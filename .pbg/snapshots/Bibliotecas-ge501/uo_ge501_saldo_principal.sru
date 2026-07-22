HA$PBExportHeader$uo_ge501_saldo_principal.sru
forward
global type uo_ge501_saldo_principal from nonvisualobject
end type
end forward

global type uo_ge501_saldo_principal from nonvisualobject
end type
global uo_ge501_saldo_principal uo_ge501_saldo_principal

type variables
string is_objeto
string is_id_ecommerce = '2' //VTEX
string is_id_interface = 'api/logistics/pvt/inventory/skus'

long il_cd_tipo = 11
long il_qt_saldo
long il_cd_filial

string is_rede_ecommerce

dc_uo_ds_base ids_filiais

end variables

forward prototypes
private function boolean of_monta_json (ref string ps_json, ref string ps_log)
public function boolean of_valida_dados (long pl_cd_produto, string ps_cd_sku, string ps_warehouseid, ref string ps_log)
public function boolean of_atualiza_ecommerce_prd (long pl_cd_produto, long pl_qt_saldo, ref string ps_log)
public function boolean of_processa_atualizacao_saldo (long pl_cd_filial, string ps_id_rede)
public function boolean of_busca_warehouseid (ref string ps_warehouseid, ref string ps_log)
public function boolean of_atualiza_lojas_com_saldo (ref string ps_log)
public function boolean of_atualiza_saldo_seller (string ps_rede_filial, string ps_cd_sku, long pl_cd_produto, long pl_qt_saldo_principal, ref string ps_log)
public subroutine _regra_disponibilidade_vigente ()
end prototypes

private function boolean of_monta_json (ref string ps_json, ref string ps_log);
ps_json = '{ ' + &
	'"unlimitedQuantity": false, ' + &
	'"dateUtcOnBalanceSystem": null, ' + &
	'"quantity": ' + string(il_qt_saldo) + &
	'}'

return true
end function

public function boolean of_valida_dados (long pl_cd_produto, string ps_cd_sku, string ps_warehouseid, ref string ps_log);if isnull(pl_cd_produto) or pl_cd_produto = 0 Then
	ps_log = 'C$$HEX1$$f300$$ENDHEX$$digo do produto inv$$HEX1$$e100$$ENDHEX$$lido.'
	return false
End if

if isnull(ps_cd_sku) or ps_cd_sku = '' Then
	ps_log = 'Produto [' + string(pl_cd_produto) + ']: SKU ainda n$$HEX1$$e300$$ENDHEX$$o cadastrado no Site.'
	return false
End if

if isnull(ps_warehouseid) or ps_warehouseid = '' Then
	ps_log = 'Produto [' + string(pl_cd_produto) + ']: O par$$HEX1$$e200$$ENDHEX$$metro Warehouseid $$HEX1$$e900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio estar configurado para atualiza$$HEX2$$e700e300$$ENDHEX$$o de saldo.'
	return false
End if

return true

end function

public function boolean of_atualiza_ecommerce_prd (long pl_cd_produto, long pl_qt_saldo, ref string ps_log);long ll_existe
boolean lb_sucesso=false
Try
		
	Update ecommerce_prd
	set qt_saldo = :pl_qt_saldo, dh_atualizacao_saldo = getdate()
	where id_ecommerce = :is_id_ecommerce
		and id_rede_filial = :is_rede_ecommerce
		and cd_produto = :pl_cd_produto;
		
		if sqlca.sqlcode = -1 then 
			ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_ecommerce_prd_filial ~n' + 'Problemas ao atualizar registro na tabela "ecommerce_prd_filial": ~n' + sqlca.sqlerrtext
			return false
		end if

	lb_sucesso = True

Finally
	
	if lb_sucesso Then
		//SQLCA.of_commit( ) ;
		If Not gf_ge501_commit(SQLCA) Then Return False
	else
		//SQLCA.of_rollback( ) ;
		If Not gf_ge501_RollBack(SQLCA) Then Return False
	end if
	
End Try

Return true
end function

public function boolean of_processa_atualizacao_saldo (long pl_cd_filial, string ps_id_rede);long ll_linhas, ll_for, ll_for2, ll_linhas2
long ll_cd_produto
long ll_seq_log

String ls_json
String ls_retorno
String ls_cd_sku
String ls_Chave_Nula
String ls_MSG_Nula
String ls_Log
String ls_Situacao
String ls_id_registro_log
String ls_dataobject
string ls_id_controlado

boolean lb_sucesso=false
DateTime ldt_inicio
DateTime ldh_Data_Nula
DateTime ldh_log_inicio

Date ldt_saldo

uo_ge501_comum luo_comum_vtex

SetNull(ls_Chave_Nula)
SetNull(ls_MSG_Nula)
SetNull(ldh_Data_Nula)

dc_uo_ds_base lds_produtos

try 

	il_cd_filial = pl_cd_filial
	is_rede_ecommerce = ps_id_rede

	Open(w_Aguarde)
	
	w_Aguarde.Title = "Vtex - Saldo Site Principal"

	luo_comum_vtex = create uo_ge501_comum

	ldh_log_inicio = gf_getserverdate()
	ls_situacao = 'P'
	
	setnull(ls_id_registro_log)
	luo_comum_vtex.of_grava_log_historico(ref ls_id_registro_log, il_cd_filial, il_cd_tipo, ldh_log_inicio, ldh_Data_Nula, 'C', 0, ref ls_log )

	//Carrega os parametros da filial relacionados ao site.
	if Not luo_comum_vtex.of_parametros_ecommerce(is_id_ecommerce, is_rede_ecommerce, il_cd_filial, ref ls_log ) then return false

	if Not this.of_busca_warehouseid( ref luo_comum_vtex.is_warehouseid , ref ls_log ) Then return false

	lds_produtos = create dc_uo_ds_base

	//Muda a datawindow de acordo com a rede. Cada rede tem uma regra de disponibilidade de produto diferente.
	//Regra vigente explicada na fun$$HEX2$$e700e300$$ENDHEX$$o : _regra_disponibilidade_vigente
	Choose Case is_rede_ecommerce
		Case 'FA'
			ls_dataobject = 'ds_ge501_saldo_produto_principal'
		Case 'DC'
			ls_dataobject = 'ds_ge501_saldo_produto_principal_dc'
		Case 'PP'
			ls_dataobject = 'ds_ge501_saldo_produto_principal_pp'
	End Choose

	if not lds_produtos.of_changedataobject( ls_dataobject ) Then
		ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_saldo ~n' + 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ' + ls_dataobject
		return false
	end if
	
	If gvo_Aplicacao.ivs_DataSource <> 'central' then
		ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_saldo, a atualiza$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o pode ser a partir do HOMOLOGA.'
		return false
	End If
	
	ids_filiais = create dc_uo_ds_base
	ids_filiais.of_changedataobject( 'ds_ge501_filiais_saldo_produto')
	if not isvalid(ids_filiais.object) Then
		ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_saldo_seller; N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar a seguinte datawindow: ds_ge501_filiais_saldo_produto'
		return false
	end if
	
	//if Not this.of_atualiza_lojas_com_saldo( ref ls_log ) Then return false
	
	ll_linhas = lds_produtos.retrieve( is_id_ecommerce, is_rede_ecommerce )
		
	if ll_linhas < 0 Then
		ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_saldo ~n' + 'Problemas ao consultar o banco de dados na seguinte datawindow: ds_ge501_saldo_produto_principal ~nErro: ' + sqlca.is_lasterrortext
		return false
	end if
	
	If ll_Linhas > 0 Then
		luo_comum_vtex.il_qt_item_enviado_site = ll_linhas
         // Grava in$$HEX1$$ed00$$ENDHEX$$cio do processo
		If Not luo_comum_vtex.of_grava_log(il_cd_filial, il_cd_tipo, ls_Chave_Nula, 'C', ls_MSG_Nula, gf_getserverdate(), gf_getserverdate(), ref ls_Log, ref ll_Seq_Log ) Then Return False
	End If
	
	w_aguarde.uo_progress.of_setmax(ll_Linhas)
	
	for ll_for = 1 to ll_linhas
		
		w_Aguarde.Title = "VTEX - [Nave M$$HEX1$$e300$$ENDHEX$$e] - Filial: [" + string(il_cd_filial) +  "] - "  + String(ll_for)  + " de " + STring(ll_Linhas)
		
		luo_comum_vtex.of_limpa_variaveis( )
		
		ldt_inicio = gf_getserverdate()
	
		ll_cd_produto = lds_produtos.object.cd_produto[ll_for]
		ls_cd_sku = lds_produtos.object.cd_sku[ll_for]
		il_qt_saldo = lds_produtos.object.qt_saldo_atualizar[ll_for]
		ls_id_controlado = lds_produtos.object.id_controlado[ll_for]
		
		//Ignorar os produtos de Teste COVID:
		if ll_cd_produto = 739825 or ll_cd_produto = 739822 Then
			w_aguarde.uo_progress.of_setprogress(ll_for)
			continue
		end if
		
		If Not this.of_valida_dados( ll_cd_produto, ls_cd_sku, luo_comum_vtex.is_warehouseid, ref ls_log ) Then 
			//Grava log de erro.
			luo_comum_vtex.of_grava_log_item( il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
			ls_Situacao = 'E'
			ls_Log = ''
			w_aguarde.uo_progress.of_setprogress(ll_for)
			continue
		end if
		
		//Monta o JSON de envio para o site.
		if Not this.of_monta_json( ref ls_json, ref ls_log) Then return false
		
		luo_comum_vtex.is_json = ls_json
		luo_comum_vtex.idc_qt_saldo = il_qt_saldo
		luo_comum_vtex.il_cd_produto = ll_cd_produto
		luo_comum_vtex.il_cd_filial_pedido = il_cd_filial
	
		//Envia os dados de saldo para o site.
		luo_comum_vtex.of_put( ls_json, is_id_interface + '/' + ls_cd_sku + '/warehouses/' + luo_comum_vtex.is_warehouseid , ref ls_retorno, ref ls_log ) 
		
		If ls_Log <> '' and not isnull(ls_Log) Then
			luo_comum_vtex.of_grava_log_item( il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
			ls_Situacao = 'E'
			ls_Log = ''
			w_aguarde.uo_progress.of_setprogress(ll_for)
			Continue
		end if
	
		if ls_id_controlado = 'N' or isnull(ls_id_controlado) Then
			//Atualizar o saldo nos seller para disponibilizar/indisponibilizar o produto no site.
			this.of_atualiza_saldo_seller( ps_id_rede, ls_cd_sku, ll_cd_produto, il_qt_saldo, ref ls_log )
			If ls_Log <> '' and not isnull(ls_Log) Then
				luo_comum_vtex.of_grava_log_item( il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
				ls_Situacao = 'E'
				ls_Log = ''
				w_aguarde.uo_progress.of_setprogress(ll_for)
				Continue
			end if
		End if
	
		If Not this.of_atualiza_ecommerce_prd( ll_cd_produto, il_qt_saldo, ref ls_log ) Then return false
	
		//Grava no log como processado com $$HEX1$$ea00$$ENDHEX$$xito.
		if Not luo_comum_vtex.of_grava_log_item(il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log ) Then Return false
		
		w_aguarde.uo_progress.of_setprogress(ll_for)
		
	next

	if isvalid(w_aguarde) Then Close(w_aguarde)

	lb_sucesso = True

Finally
	
	if Not lb_sucesso then 
		ls_situacao = 'E'
		
		//sqlca.of_rollback( )
		gf_ge501_RollBack(SQLCA)
		
		// J$$HEX1$$e100$$ENDHEX$$ iniciou o envio dos itens
		If ll_for > 0 Then
			// Atualiza log com erro
			If Not luo_comum_vtex.of_atualiza_ecommerce_log(il_cd_filial, ll_Seq_Log, 'E', ls_Log, gf_getserverdate(), ref ls_Log) Then Return False
			if Not luo_comum_vtex.of_grava_log_item(il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log) Then Return false
		Else
			// Se n$$HEX1$$e300$$ENDHEX$$o tiver log insere um novo com erro
			If IsNull(ll_Seq_Log) or ll_Seq_Log = 0 Then
				// Grava in$$HEX1$$ed00$$ENDHEX$$cio do processo - chave e mensagem est$$HEX1$$e300$$ENDHEX$$o indo como nulo
				If Not luo_comum_vtex.of_grava_log(il_cd_filial, il_cd_tipo, ls_Chave_Nula, 'E', ls_Log, ldh_Data_Nula, gf_getserverdate(), ref ls_Log, ref ll_Seq_Log ) Then Return False
			Else
				// Atualiza log com erro
				If Not luo_comum_vtex.of_atualiza_ecommerce_log(il_cd_filial, ll_Seq_Log, 'E', ls_Log, gf_getserverdate(), ref ls_Log) Then Return False
			End If		
		End If
	Else
		//sqlca.of_commit( )
		If gf_ge501_commit(SQLCA) Then
			If ll_Linhas > 0 Then
				// Marca o log como processado
				If Not luo_comum_vtex.of_atualiza_ecommerce_log(il_cd_filial, ll_Seq_Log, ls_Situacao, ls_MSG_Nula, gf_getserverdate(), ref ls_Log) Then Return False
			End If
		End If
	End If

	luo_comum_vtex.of_grava_log_historico(ref ls_id_registro_log, il_cd_filial, il_cd_tipo, ldh_log_inicio, gf_getserverdate(), ls_situacao, ll_Seq_Log, ref ls_log )

	destroy(luo_comum_vtex)
	destroy(lds_produtos)

	if isvalid(w_aguarde) Then Close(w_aguarde)

End try

return true
end function

public function boolean of_busca_warehouseid (ref string ps_warehouseid, ref string ps_log);string ls_retorno

select cd_warehouseid
into :ls_retorno
from ecommerce_rede_filial
where cd_filial = :il_cd_filial
and id_ecommerce = :is_id_ecommerce
and id_rede_filial = :is_rede_ecommerce;


if sqlca.sqlcode = -1 Then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_busca_warehouseid ~n' + 'Problemas ao consultar a tabela "ecommerce_rede_filial": ' + sqlca.sqlerrtext
	return false
end if

ps_warehouseid = ls_retorno

return true
end function

public function boolean of_atualiza_lojas_com_saldo (ref string ps_log);
//update ecommerce_prd
//set qt_lojas = (select count(*)
//                from ecommerce_prd_filial a
//                inner join ecommerce_prd b
//                    on b.id_ecommerce = a.id_ecommerce
//                           and b.id_rede_filial = a.id_rede_filial
//                    and b.cd_produto = a.cd_produto
//                inner join ecommerce_rede_filial er on (er.id_ecommerce = a.id_ecommerce and er.cd_filial = a.cd_filial and er.id_rede_filial = a.id_rede_filial )
//                where a.id_ecommerce = ecommerce_prd.id_ecommerce
//                  and a.id_rede_filial =ecommerce_prd.id_rede_filial
//                  and a.qt_saldo > 0
//                  and er.id_situacao = 'A'
//                  AND a.cd_filial not in (select cd_filial_ecommerce
//                                            from ecommerce_hub_rede hub
//                                            where hub.id_ecommerce = ecommerce_prd.id_ecommerce
//                                            and hub.id_rede_filial = ecommerce_prd.id_rede_filial)
//                   AND a.cd_filial not in (select cd_filial_hub
//                                            from ecommerce_hub_rede hub
//                                            where hub.id_ecommerce = ecommerce_prd.id_ecommerce
//                                            and hub.id_rede_filial = ecommerce_prd.id_rede_filial)
//                  and a.cd_produto = ecommerce_prd.cd_produto )
//where ecommerce_prd.id_ecommerce = :is_id_ecommerce
//  and ecommerce_prd.id_rede_filial = :is_rede_ecommerce
//  and ecommerce_prd.qt_saldo > 0;
//  
//If sqlca.sqlcode = -1 then
//	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_lojas_com_saldo; Problemas ao atualizar a tabela "ecommerce_prd"(1): ' + sqlca.sqlerrtext
//	return false
//end if

update ecommerce_prd
set qt_lojas = (select count(*)
                from ecommerce_prd_filial a
                inner join ecommerce_prd b
                    on b.id_ecommerce = a.id_ecommerce
                           and b.id_rede_filial = a.id_rede_filial
                    and b.cd_produto = a.cd_produto
                inner join ecommerce_rede_filial er on (er.id_ecommerce = a.id_ecommerce and er.cd_filial = a.cd_filial and er.id_rede_filial = a.id_rede_filial )
                where a.id_ecommerce = ecommerce_prd.id_ecommerce
                  and a.id_rede_filial =ecommerce_prd.id_rede_filial
                  and a.qt_saldo > 0
                  and er.id_situacao = 'A'
                  AND a.cd_filial not in (454, 986,331,328,325,318)
                  and a.cd_produto = ecommerce_prd.cd_produto )
where ecommerce_prd.id_ecommerce = :is_id_ecommerce
  and ecommerce_prd.id_rede_filial = :is_rede_ecommerce;
  
If sqlca.sqlcode = -1 then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_lojas_com_saldo; Problemas ao atualizar a tabela "ecommerce_prd"(1): ' + sqlca.sqlerrtext
	return false
end if

//update ecommerce_prd
//set qt_lojas_hub = (select count(*)
//                from ecommerce_prd_filial a
//                         inner join ecommerce_prd b
//                                    on b.id_ecommerce = a.id_ecommerce
//                                        and b.id_rede_filial = a.id_rede_filial
//                                        and b.cd_produto = a.cd_produto
//                inner join ecommerce_rede_filial er on (er.id_ecommerce = a.id_ecommerce and er.cd_filial = a.cd_filial and er.id_rede_filial = a.id_rede_filial )
//                where a.id_ecommerce = ecommerce_prd.id_ecommerce
//                  and a.id_rede_filial =ecommerce_prd.id_rede_filial
//                  and a.qt_saldo > 0
//                  and er.id_situacao = 'A'
//                  AND a.cd_filial in (select cd_filial_hub
//                                          from ecommerce_hub_rede hub
//                                          where hub.id_ecommerce = ecommerce_prd.id_ecommerce
//                                            and hub.id_rede_filial = ecommerce_prd.id_rede_filial)
//                  and a.cd_produto = ecommerce_prd.cd_produto )
//where ecommerce_prd.id_ecommerce = :is_id_ecommerce
//  and ecommerce_prd.id_rede_filial = :is_rede_ecommerce
//  and ecommerce_prd.qt_saldo > 0;
//  
//  If sqlca.sqlcode = -1 then
//	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_lojas_com_saldo; Problemas ao atualizar a tabela "ecommerce_prd"(2): ' + sqlca.sqlerrtext
//	return false
//end if

// Conforme conversado com o Julio considerar somente a filial 454 com HUB, pois as demais s$$HEX1$$e300$$ENDHEX$$o regionais..
update ecommerce_prd
set qt_lojas_hub = (select count(*)
                from ecommerce_prd_filial a
                inner join ecommerce_prd b
                                    on b.id_ecommerce = a.id_ecommerce
                                        and b.id_rede_filial = a.id_rede_filial
                                        and b.cd_produto = a.cd_produto
                inner join ecommerce_rede_filial er on (er.id_ecommerce = a.id_ecommerce and er.cd_filial = a.cd_filial and er.id_rede_filial = a.id_rede_filial )
                where a.id_ecommerce = ecommerce_prd.id_ecommerce
                  and a.qt_saldo > 0
                  and er.id_situacao = 'A'
                  AND a.cd_filial in (454)
                  and a.cd_produto = ecommerce_prd.cd_produto )
where ecommerce_prd.id_ecommerce = :is_id_ecommerce
  and ecommerce_prd.id_rede_filial = :is_rede_ecommerce;
  
 If sqlca.sqlcode = -1 then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_lojas_com_saldo; Problemas ao atualizar a tabela "ecommerce_prd"(2): ' + sqlca.sqlerrtext
	return false
end if

SqlCa.of_Commit()
  
return true
end function

public function boolean of_atualiza_saldo_seller (string ps_rede_filial, string ps_cd_sku, long pl_cd_produto, long pl_qt_saldo_principal, ref string ps_log);String ls_json, ls_retorno
long ll_for, ll_linhas, ll_cd_filial, ll_qt_saldo, ll_qt_saldo_distrib, ll_qt_saldo_fisico, ll_qt_saldo_total
uo_ge501_comum luo_comum_vtex

ids_filiais.reset()

//Busca todos os seller que possuem saldo do produto.
ll_linhas = ids_filiais.retrieve(is_id_ecommerce, ps_rede_filial, pl_cd_produto)

if ll_linhas = 0 then
	return true
elseif ll_linhas < 0 Then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_saldo_seller; Erro ao consultar a seguinte datawindow: ds_ge501_filiais_saldo_produto'
	return false
end if

Try

	for ll_for = 1 to ll_linhas
	
		ll_qt_saldo_total = 0
	
		ll_cd_filial = ids_filiais.object.cd_filial[ll_for]
		ll_qt_saldo = ids_filiais.object.qt_saldo[ll_for]
		ll_qt_saldo_distrib = ids_filiais.object.qt_saldo_distribuidora[ll_for]
		
		luo_comum_vtex = create uo_ge501_comum
		
		//Carrega os parametros e busca o c$$HEX1$$f300$$ENDHEX$$digo da filial vinculado a rede.
		if Not luo_comum_vtex.of_parametros_ecommerce_filial( ll_cd_filial, ps_rede_filial, is_id_ecommerce, ref ps_log ) then return false
		
		if pl_qt_saldo_principal = 0 Then
			//Tornar o produto indisponivel
			ll_qt_saldo = 0 
			ll_qt_saldo_fisico = 0
			ll_qt_saldo_distrib = 0
		else
			
			ll_qt_saldo_fisico = ll_qt_saldo
			
		end if
		
		ll_qt_saldo_total = ll_qt_saldo_fisico + ll_qt_saldo_distrib
		
		if luo_comum_vtex.is_warehouseid_virtual <> '' and not isnull(luo_comum_vtex.is_warehouseid_virtual) and luo_comum_vtex.is_warehouseid_virtual <> luo_comum_vtex.is_warehouseid then
			
			//Estoque fisico
			ls_json = '{ ' + &
			'"unlimitedQuantity": false, ' + &
			'"dateUtcOnBalanceSystem": null, ' + &
			'"quantity": ' + string(ll_qt_saldo_fisico) + &
			'}'
		
			luo_comum_vtex.of_put( ls_json, 'api/logistics/pvt/inventory/skus/' + ps_cd_sku + '/warehouses/' + luo_comum_vtex.is_warehouseid , ref ls_retorno, ref ps_log ) 
							
			If ps_log <> '' and not isnull(ps_log) Then return false
			
			//Estoque virtual
			ls_json = '{ ' + &
			'"unlimitedQuantity": false, ' + &
			'"dateUtcOnBalanceSystem": null, ' + &
			'"quantity": ' + string(ll_qt_saldo_distrib) + &
			'}'
			
			luo_comum_vtex.of_put( ls_json, 'api/logistics/pvt/inventory/skus/' + ps_cd_sku + '/warehouses/' + luo_comum_vtex.is_warehouseid_virtual , ref ls_retorno, ref ps_log ) 
						
			If ps_log <> '' and not isnull(ps_log) Then return false	
			
		elseif luo_comum_vtex.is_warehouseid_virtual <> '' and not isnull(luo_comum_vtex.is_warehouseid_virtual) and luo_comum_vtex.is_warehouseid_virtual = luo_comum_vtex.is_warehouseid Then
			
			//Estoque fisico + Distribuidora
			ls_json = '{ ' + &
			'"unlimitedQuantity": false, ' + &
			'"dateUtcOnBalanceSystem": null, ' + &
			'"quantity": ' + string(ll_qt_saldo_total) + &
			'}'
		
			luo_comum_vtex.of_put( ls_json, 'api/logistics/pvt/inventory/skus/' + ps_cd_sku + '/warehouses/' + luo_comum_vtex.is_warehouseid , ref ls_retorno, ref ps_log ) 
							
			If ps_log <> '' and not isnull(ps_log) Then return false
		
		Else
			
			//Somente Estoque fisico
			ls_json = '{ ' + &
			'"unlimitedQuantity": false, ' + &
			'"dateUtcOnBalanceSystem": null, ' + &
			'"quantity": ' + string(ll_qt_saldo_fisico) + &
			'}'
		
			luo_comum_vtex.of_put( ls_json, 'api/logistics/pvt/inventory/skus/' + ps_cd_sku + '/warehouses/' + luo_comum_vtex.is_warehouseid , ref ls_retorno, ref ps_log ) 
							
			If ps_log <> '' and not isnull(ps_log) Then return false
			
		end if
		
		Destroy(luo_comum_vtex)
	
	next

Finally
	
	If ps_log <> '' and not isnull(ps_log) and ll_cd_filial > 0 Then
		ps_log = 'Seller: ' + string(ll_cd_filial) + ' - ' + ps_log
	ENd if
	
ENd Try

return true
end function

public subroutine _regra_disponibilidade_vigente ();
/*Chamado: 969131

Produto consta no Hub SP (envia para todos os estados), aparece nos 3 fronts dos e-commerces.

DC:

Produto consta no Hub SP (envia para todos os estados), mant$$HEX1$$e900$$ENDHEX$$m no Front DC.

Produto n$$HEX1$$e300$$ENDHEX$$o consta no Hub SP, mas tem no Hub SC (envia para todo estado SC), mant$$HEX1$$e900$$ENDHEX$$m no Front DC.

Produto n$$HEX1$$e300$$ENDHEX$$o consta no Hub SP nem no Hub SC, mas est$$HEX1$$e100$$ENDHEX$$ dispon$$HEX1$$ed00$$ENDHEX$$vel em 20 lojas DCs ou mais, mant$$HEX1$$e900$$ENDHEX$$m no Front DC.

Produto n$$HEX1$$e300$$ENDHEX$$o consta no Hub SP nem no Hub SC, e est$$HEX1$$e100$$ENDHEX$$ dispon$$HEX1$$ed00$$ENDHEX$$vel apenas em 19 lojas DCs ou menos, tira do Front DC.

 

PP:

Produto consta no Hub SP (envia para todos os estados), mant$$HEX1$$e900$$ENDHEX$$m no Front PP.

Produto n$$HEX1$$e300$$ENDHEX$$o consta no Hub SP, mas tem em pelo menos um dos Hubs Regionais que atendem seus respectivos estados (SC, PR ou RS), mant$$HEX1$$e900$$ENDHEX$$m no Front PP. (No momento o HUB BA nao entra na regra)

Produto n$$HEX1$$e300$$ENDHEX$$o consta no Hub SP nem nos Hubs Regionais, mas est$$HEX1$$e100$$ENDHEX$$ dispon$$HEX1$$ed00$$ENDHEX$$vel em 50 lojas PPs ou mais, mant$$HEX1$$e900$$ENDHEX$$m no Front PP.

Produto n$$HEX1$$e300$$ENDHEX$$o consta no Hub SP nem nos Hubs Regionais, e est$$HEX1$$e100$$ENDHEX$$ dispon$$HEX1$$ed00$$ENDHEX$$vel apenas em 49 lojas PPs ou menos, tira do Front PP.

 

FA:

Produto consta no Hub SP (envia para todos os estados), mant$$HEX1$$e900$$ENDHEX$$m no Front FA.

Produto n$$HEX1$$e300$$ENDHEX$$o consta no Hub SP, mas tem em pelo menos dois dos Hubs Regionais que atendem seus respectivos estados (SC, PR ou RS), mant$$HEX1$$e900$$ENDHEX$$m no Front FA.

Produto n$$HEX1$$e300$$ENDHEX$$o consta no Hub SP, e n$$HEX1$$e300$$ENDHEX$$o consta em pelo menos 2 Hubs Regionais, tira do Front FA.

*/
end subroutine

on uo_ge501_saldo_principal.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge501_saldo_principal.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;is_objeto = 'Objeto: ' + this.classname() + '~n'
end event

