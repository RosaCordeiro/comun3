HA$PBExportHeader$uo_ge501_saldo_rede.sru
forward
global type uo_ge501_saldo_rede from nonvisualobject
end type
end forward

global type uo_ge501_saldo_rede from nonvisualobject
end type
global uo_ge501_saldo_rede uo_ge501_saldo_rede

type variables
string is_objeto
string is_id_ecommerce = '2' //VTEX
string is_id_interface = 'api/logistics/pvt/inventory/skus'

long il_cd_tipo = 10
long il_qt_saldo
long il_cd_filial
long il_cd_filial_base

string is_rede_ecommerce

datetime idt_atualizacao

uo_ge501_comum iuo_comum_vtex
end variables

forward prototypes
public function boolean of_valida_dados (long pl_cd_produto, string ps_cd_sku, string ps_warehouseid, ref string ps_log)
public function boolean of_busca_produto_sku (long pl_cd_produto, ref string ps_cd_sku, ref string ps_log)
public function boolean of_busca_ultimo_saldo (long pl_cd_filial, long pl_cd_produto, ref long pl_qt_saldo, ref string ps_log)
public subroutine of_limpa_variaveis ()
public function boolean of_busca_saldo_cd (long pl_cd_filial, long pl_cd_produto, ref long pl_qt_saldo, ref string ps_log)
public function boolean of_processa_atualizacao_saldo (long pl_filial, string ps_rede)
public function boolean of_atualiza_ecommerce_prd_filial (long pl_cd_produto, long pl_qt_saldo, ref string ps_log, long pl_saldo_filial, long pl_saldo_distribuidora)
public function boolean of_saldo_distribuidoras (long pl_filial, long pl_atualizacao, long pl_filial_saldo, string ps_uf, string ps_id_rede, ref string ps_log)
public function boolean of_saldo_pendente (long pl_filial, long pl_produto, ref long pl_saldo_pendente, ref string ps_log)
public function boolean of_retorna_parametros (long pl_filial, string ps_rede_filial, ref long pl_filial_base, ref string ps_rede_base, ref string ps_uf_base, ref string ps_vende_termolabil, ref string ps_log)
private function boolean of_monta_json (ref string ps_json, long pl_qt_saldo, ref string ps_log)
public function boolean of_excluir_reserva_plataforma (string ps_warehouseid, string ps_cd_sku, ref string ps_log)
public function boolean of_valida_liberado_site (long pl_cd_produto, ref boolean pb_liberado, ref string ps_log)
public function boolean of_verifica_categoria_bloqueada (long pl_cd_filial, long pl_cd_produto)
public function boolean of_atualiza_saldo_cd (ref string ps_log)
end prototypes

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

public function boolean of_busca_produto_sku (long pl_cd_produto, ref string ps_cd_sku, ref string ps_log);
setnull(ps_cd_sku)

select cd_sku
into :ps_cd_sku
from ecommerce_prd
where cd_produto = :pl_cd_produto
	and id_ecommerce = :is_id_ecommerce
	and id_rede_filial = :is_rede_ecommerce;
	
if sqlca.sqlcode = -1 then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_busca_produto_sku ~n' + 'Problemas ao consultar a tabela "ecommerce_produto": ~n' + sqlca.sqlerrtext
	return false
end if

return true
end function

public function boolean of_busca_ultimo_saldo (long pl_cd_filial, long pl_cd_produto, ref long pl_qt_saldo, ref string ps_log);long ll_qt_saldo
long ll_dias_atualizacao

select qt_saldo, datediff(dd, cast(dh_atualizacao as date), cast(getdate() as date))
into :ll_qt_saldo, :ll_dias_atualizacao
from ecommerce_prd_filial
where cd_filial = :pl_cd_filial
	and cd_produto = :pl_cd_produto
	and id_ecommerce = :is_id_ecommerce
	and id_rede_filial = :is_rede_ecommerce;
	
If sqlca.sqlcode = -1 then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_busca_ultimo_saldo ~n' + 'Problemas ao consultar a tabela "ecommerce_prd_filial": ~n' + sqlca.sqlerrtext
	return false
end if

// Se n$$HEX1$$e300$$ENDHEX$$o encontrou ou ficou mais de 3 dias sem atualizar, for$$HEX1$$e700$$ENDHEX$$a uma atualizacao
// o par$$HEX1$$e200$$ENDHEX$$metro de 3 dias esta da data store tamb$$HEX1$$e900$$ENDHEX$$m ds_ge501_saldo_produto_rede_nova
If SqlCa.SqlCode = 100  or ll_dias_atualizacao >= 3 Then
	ll_qt_saldo = -1000
End If

pl_qt_saldo = ll_qt_saldo

return true
end function

public subroutine of_limpa_variaveis ();Setnull(il_qt_saldo)
//Setnull(il_cd_filial)
//Setnull(is_rede_ecommerce)
end subroutine

public function boolean of_busca_saldo_cd (long pl_cd_filial, long pl_cd_produto, ref long pl_qt_saldo, ref string ps_log);long ll_qt_saldo
long ll_fator
long ll_qtde_minima

SELECT	dbo.saldo_atual_estoque_central( :pl_cd_filial, pg.cd_produto, 'S'),
		COALESCE( pg.vl_fator_conversao, 1 ) as vl_fator_conversao
into :ll_qt_saldo, :ll_fator
FROM produto_geral pg 
WHERE pg.cd_produto = :pl_cd_produto
    and exists (select * from ecommerce_distrib ec
	 			  where ec.id_ecommerce 	= '2'
					 and ec.cd_distribuidora 	= '053404705'
					 and ec.cd_filial 			= :pl_cd_filial
					 and ec.dh_inicio_saldo <= cast(getdate() as date)
					 and ec.dh_termino_saldo >= cast(getdate() as date))
Using SqlCa;

if sqlca.sqlcode = -1 then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_busca_saldo_cd ~n' + 'Problemas ao consultar a fun$$HEX2$$e700e300$$ENDHEX$$o "saldo_atual_estoque_central": ~n' + sqlca.sqlerrtext
	return false
end if

select coalesce(qt_minima_estoque, 0) 
Into :ll_qtde_minima
from ecommerce_distrib ec
where ec.id_ecommerce 	= '2'
 and ec.cd_distribuidora 	= '053404705'
 and ec.cd_filial 			= :pl_cd_filial
 and ec.dh_inicio_saldo <= cast(getdate() as date)
 and ec.dh_termino_saldo >= cast(getdate() as date)
Using SqlCa;

if sqlca.sqlcode = -1 then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_busca_saldo_cd ~n' + 'Problemas ao consultar informa$$HEX2$$e700f500$$ENDHEX$$es da tabela "ecommerce_distrib": ~n' + sqlca.sqlerrtext
	return false
end if

// Para garantir a qtde m$$HEX1$$ed00$$ENDHEX$$nima de estoque
If ll_qt_saldo < ll_qtde_minima Then ll_qt_saldo = 0

pl_qt_saldo = ll_qt_saldo * ll_fator

If IsNull(pl_qt_saldo) Then pl_qt_saldo = 0

return true
end function

public function boolean of_processa_atualizacao_saldo (long pl_filial, string ps_rede);long ll_linhas, ll_for
long ll_cd_produto
long ll_saldo_antigo
long ll_seq_log
long ll_qt_saldo_distribuidora
long ll_Saldo_Filial_Base, ll_saldo_distribuidora, ll_saldo_cd, ll_saldo_distrib_antigo
long ll_find
Long ll_Saldo_Pend_Filial_Base
Long ll_qt_saldo_total
Long ll_Produto_Debug
Long ll_Contador = 0
Long ll_qtde_minima

decimal ldc_Dif

String ls_json
String ls_retorno
String ls_cd_sku
String ls_Chave_Nula
String ls_MSG_Nula
String ls_Log
String ls_Situacao
String ls_Sit_Produto
String ls_id_registro_log
String ls_Rede_Base
String ls_UF_Base
String ls_Grupo_Psico
String ls_Query
String ls_vende_termolabil
String ls_warehouseid

boolean lb_sucesso=false
boolean lb_liberado_atualizar = true
boolean lb_categoria_bloqueada = false

DateTime ldh_Data_Nula
DateTime ldh_log_inicio

Date ldt_saldo
Date ldh_Data_Atual

SetNull(ls_Chave_Nula)
SetNull(ls_MSG_Nula)
SetNull(ldh_Data_Nula)

dc_uo_ds_base lds_produtos, lds_saldo_distribuidora

il_cd_filial 				= pl_filial
is_rede_ecommerce 	= ps_rede

ldh_Data_Atual  = Date(gf_GetServerDate())

try 
	ldh_log_inicio = gf_getserverdate()
	idt_atualizacao = ldh_log_inicio
	
	ls_situacao = 'P'
	
	iuo_comum_vtex = create uo_ge501_comum
	
	setnull(ls_id_registro_log)
	iuo_comum_vtex.of_grava_log_historico(ref ls_id_registro_log, pl_filial, il_cd_tipo, ldh_log_inicio, ldh_Data_Nula, 'C', 0, ref ls_log )	
	
	Open(w_Ge501_Aguarde)
	
	If gvo_Aplicacao.ivs_DataSource <> 'central' Then 
		ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_saldo ~n' + 'Atualiza$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o permitida para ambiente de HOMOLOGA$$HEX2$$c700c300$$ENDHEX$$O.'
		Return False
	End If
			
	//************************************************************************
	//OBJETIVO: Atualizar o estoque das loja de SP de cada rede [entrega via correio + transportadora], 
	//por exemplo, da DC $$HEX1$$e900$$ENDHEX$$ o SELLER(986), PP $$HEX1$$e900$$ENDHEX$$ o SELLER(318) e FA o SELLER(809).
	// PEGA O ESTOQUE DA LJ 454 + O ESTOQUE DE ALGUMAS DISTRIBUIDORAS
	// *** No caso da filial 181 s$$HEX1$$f300$$ENDHEX$$ tem o SELLER da pr$$HEX1$$f300$$ENDHEX$$pria loja, neste caso foi feito um controle na ds_ge501_saldo_produto_rede_nova
	//************************************************************************

	If Not This.of_retorna_parametros(pl_filial, ps_rede, ref il_cd_filial_base, ref ls_Rede_Base, ref ls_UF_Base, ref ls_vende_termolabil, ref ls_log) Then Return False
	
	w_Ge501_Aguarde.Title = "Vtex - Saldo Rede (Filial HUB)"

	w_Ge501_Aguarde.st_msg.Text = "Filial: [" + string(il_cd_filial) + "/" +ps_rede + "]" 

	lds_produtos = create dc_uo_ds_base
				
	// Lista os produtos, ativos, liberado para algum ecommerce, juntamente com o saldo da filial 
	if not lds_produtos.of_changedataobject( 'ds_ge501_saldo_produto_rede_nova' ) Then
		ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_saldo ~n' + 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ds_ge501_saldo_produto_rede'
		return false
	end if
	
	//Filtra produtos de geladeira:
//	if ls_vende_termolabil = 'N' then
	//	 lds_produtos.of_appendwhere_subquery("left(pg.de_produto,2) <> 'ZZ'", 6)
//	end if
	
	lds_produtos.of_appendwhere_subquery("( left(pg.de_produto,2) <> 'ZZ' and pg.cd_grupo_psico is null ) ", 2)
	
	///If Not iuo_comum_vtex.of_query_controlado(pl_filial, ps_rede, ref ls_Query, ref ls_log) Then Return False
	
//	If Not Isnull(ls_Query) Then
//		lds_produtos.of_appendwhere_subquery(ls_Query, 6)	
//	End If
	
	ll_Produto_Debug  =  0
	
	If ll_Produto_Debug > 0 Then
		lds_produtos.of_appendwhere_subquery('ep.cd_produto = ' + string(ll_Produto_Debug), 2 )
		//lds_produtos.of_appendwhere_subquery('ep.cd_produto in ( 622006,622844 )', 2 )
		
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Foi fixado um produto para teste.", Exclamation!)
	End If
		
	lds_saldo_distribuidora = create dc_uo_ds_base

	if not lds_saldo_distribuidora.of_changedataobject( 'ds_ge501_saldo_produto_distribuidora' ) Then
		ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_saldo ~n' + 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ds_ge501_saldo_produto_distribuidora'
		return false
	end if
	
	//Carrega os produtos e saldos da filial
	ll_linhas = lds_produtos.retrieve(is_id_ecommerce, il_cd_filial, is_rede_ecommerce, il_cd_filial_base, ls_Rede_Base)
		
	if ll_linhas < 0 Then
		ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_saldo ~n' + 'Problemas ao consultar o banco de dados na seguinte datawindow: ds_ge501_saldo_produto_rede ~nErro: ' + sqlca.is_lasterrortext
		return false
	end if
	
	//Carrega os produtos e saldos das distribuidoras
	if  lds_saldo_distribuidora.retrieve( il_cd_filial_base, ls_UF_Base, ps_rede ) < 0 Then
		ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_saldo ~n' + 'Problemas ao consultar o banco de dados na seguinte datawindow: ds_ge501_saldo_produto_distribuidora ~nErro: ' + sqlca.is_lasterrortext
		return false
	end if
	
	If ll_Linhas > 0 Then
		iuo_comum_vtex.il_qt_item_enviado_site = ll_linhas
         // Grava in$$HEX1$$ed00$$ENDHEX$$cio do processo
		If Not iuo_comum_vtex.of_grava_log(il_cd_filial, il_cd_tipo, ls_Chave_Nula, 'C', ls_MSG_Nula, gf_getserverdate(), gf_getserverdate(), ref ls_Log, ref ll_Seq_Log ) Then Return False
	End If
	
	update ecommerce_rede_filial
	set dh_atualizacao_saldo = getdate()
	where id_ecommerce = :is_id_ecommerce
		and id_rede_filial = :ps_rede
		and cd_filial = :il_cd_filial
	Using SqlCa;
	
	if sqlca.sqlcode = -1 then
		ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_saldo ~n' + 'Problemas ao atualizar a tabela "ecommerce_rede_filial": ~n' + sqlca.sqlerrtext
		return false
	end if
	
	// Pega o saldo de todas as distribuidoras  e grava em um hist$$HEX1$$f300$$ENDHEX$$rico
	//If Not of_saldo_distribuidoras(il_cd_filial, ll_Seq_Log, ll_cd_filial_base, ls_UF_Base, ps_rede, ref ls_Log) Then Return False
	
	//Carrega os parametros da filial relacionados ao site.
	if Not iuo_comum_vtex.of_parametros_ecommerce_filial( il_cd_filial, is_rede_ecommerce, is_id_ecommerce, ref ls_log ) then return false
	
	w_Ge501_Aguarde.uo_progress.of_setmax(ll_Linhas)
	
	for ll_for = 1 to ll_linhas
		
		w_Ge501_Aguarde.Title = "Vtex - Saldo Rede (HUB) - "  + String(ll_for)  + " de " + STring(ll_Linhas)
	
		this.of_limpa_variaveis( )
		iuo_comum_vtex.of_limpa_variaveis( )
		
		ll_qt_saldo_total = 0
		ll_Saldo_Pend_Filial_Base 	= 0
		ll_saldo_cd						= 0
		ll_saldo_antigo 					= 0
		ll_saldo_distribuidora 			= 0
		ll_saldo_distrib_antigo 		= 0
		ls_warehouseid = ''
		ls_json = ''
		
		//Busca o produto e o saldo da loja 454/181
		ll_cd_produto 					= lds_produtos.object.cd_produto						[ll_for]
		ls_Sit_Produto					= lds_produtos.object.id_situacao						[ll_for]
		
		ll_Saldo_Filial_Base 		  	= lds_produtos.object.qt_saldo_filial_base			[ll_for]
		ll_Saldo_Pend_Filial_Base 	= lds_produtos.object.qt_saldo_pend_filial_base	[ll_for]
		ll_Saldo_Antigo					= lds_produtos.object.qt_saldo_filial_referencia	[ll_for]
		ll_saldo_distrib_antigo 		= lds_produtos.object.qt_saldo_distrib_referencia	[ll_for]
		ll_saldo_cd 			= lds_produtos.object.qt_saldo_cd_original			[ll_for]
		ls_Grupo_Psico					= lds_produtos.object.cd_grupo_psico				[ll_for]	
		ll_qtde_minima = lds_produtos.object.qt_minima_estoque[ll_for]	
		
		If ll_saldo_cd < ll_qtde_minima Then ll_saldo_cd = 0
		
		// controlado - in$$HEX1$$ed00$$ENDHEX$$cio
		If Not IsNull(ls_Grupo_Psico) Then
			// N$$HEX1$$e300$$ENDHEX$$o envia controlado e nem antibi$$HEX1$$f300$$ENDHEX$$tico
			If iuo_comum_vtex.is_vende_controlado = 'N' and iuo_comum_vtex.is_vende_antibiotico = 'N' Then
				w_ge501_aguarde.uo_progress.of_setprogress(ll_for)
				Continue
			End If
			
			// Somente antibiotico
			If (iuo_comum_vtex.is_vende_controlado = 'N' and iuo_comum_vtex.is_vende_antibiotico = 'S') and ls_Grupo_Psico <> 'W'  Then
				w_ge501_aguarde.uo_progress.of_setprogress(ll_for)
				Continue
			End If
			
			// somente controlado
			If (iuo_comum_vtex.is_vende_controlado = 'S' and iuo_comum_vtex.is_vende_antibiotico = 'N') and ls_Grupo_Psico = 'W' Then
				w_ge501_aguarde.uo_progress.of_setprogress(ll_for)
				Continue
			End If
		End If
		// controlado - final
					
		lb_categoria_bloqueada = this.of_verifica_categoria_bloqueada( il_cd_filial_base, ll_cd_produto)			
					
		//Busca o Saldo das distribuidoras
		ll_find = lds_saldo_distribuidora.find('cd_produto = ' + string(ll_cd_produto) , 1, lds_saldo_distribuidora.rowcount() )
				
		if ll_find < 0 Then
			ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_saldo ~n' + 'Problemas ao executar o m$$HEX1$$e900$$ENDHEX$$todo find na seguinte datawindow: ds_ge501_saldo_produto_distribuidora ~nErro: ' + string(ll_find)
			return false
		end if
		
		// *** SALDO DISTRIBUIDORA + CD (INICIO)
		// Se o produto estiver inativo considera como zero na distribuidora
		if ll_find > 0 and ls_Sit_Produto = 'A' Then
			ll_saldo_distribuidora = lds_saldo_distribuidora.object.qt_saldo[ll_find]
		end if
		
//		// S$$HEX1$$f300$$ENDHEX$$ vai consultar o saldo do CD se possuir saldo na tabela SALDO_PRODUTO, a fun$$HEX2$$e700e300$$ENDHEX$$o pega o saldo dispon$$HEX1$$ed00$$ENDHEX$$vel no WMS
//		If ll_Saldo_CD_Original > 0 Then
//			If Not this.of_busca_saldo_cd( il_cd_filial_base, ll_cd_produto, ref ll_saldo_cd, ref ls_log ) Then return false
//		End If
		
		ll_saldo_distribuidora = ll_saldo_distribuidora + ll_saldo_cd
		// *** SALDO DISTRIBUIDORA + CD (TERMINO)
		
		// N$$HEX1$$c300$$ENDHEX$$O PEGA SALDO DE CONTROLADO
		If Not Isnull(ls_Grupo_Psico) Then ll_saldo_distribuidora = 0
		
		//ll_Saldo_Filial_Base = ll_Saldo_Filial_Base - ll_Saldo_Pend_Filial_Base
		
		il_qt_saldo = ll_Saldo_Filial_Base - ll_Saldo_Pend_Filial_Base
		
		If il_qt_saldo < 0 Then il_qt_saldo = 0

		ll_qt_saldo_total = il_qt_saldo + ll_saldo_distribuidora

		if isnull(ll_qt_saldo_total) then ll_qt_saldo_total = 0

		iuo_comum_vtex.il_cd_filial_pedido = il_cd_filial
		
		If Isnull(ll_saldo_distrib_antigo) Then ll_saldo_distrib_antigo = 0
		
		//Se a categoria do produto estiver bloqueada na filial, sobe zero pra VTEX:
		if lb_categoria_bloqueada = True Then
			il_qt_saldo = 0
			ll_saldo_distribuidora = 0
			ll_Saldo_Filial_Base = 0
			ll_qt_saldo_total = 0
		End if
		
		if ll_saldo_distrib_antigo = ll_saldo_distribuidora Then 
			
			If Not this.of_atualiza_ecommerce_prd_filial( ll_cd_produto, il_qt_saldo, ref ls_log, ll_Saldo_Filial_Base, ll_saldo_distribuidora ) Then return false
		
			If ll_Contador >= 50 Then
				gf_ge501_commit(SQLCA)
				ll_Contador = 0
			End If
			
			w_ge501_aguarde.uo_progress.of_setprogress(ll_for)
			Continue
		End If
		
		If Isnull(ll_saldo_antigo) Then ll_saldo_antigo = 0
			
		//Busca o c$$HEX1$$f300$$ENDHEX$$digo do SKU
		if Not this.of_busca_produto_sku(ll_cd_produto, ref ls_cd_sku, ref ls_log) Then return false
		
		If Not this.of_valida_dados( ll_cd_produto, ls_cd_sku, iuo_comum_vtex.is_warehouseid, ref ls_log ) Then 
			//Grava log de erro.
			iuo_comum_vtex.of_grava_log_item( il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
			ls_Situacao = 'E'
			ls_Log = ''
			w_ge501_aguarde.uo_progress.of_setprogress(ll_for)
			continue
		end if
		
		lb_liberado_atualizar = True
		
//		if pl_filial = 454 then
//			lb_liberado_atualizar = True
//		else
//			//Verifica se esta disponivel para exibir no site.
//			this.of_valida_liberado_site( ll_cd_produto, ref lb_liberado_atualizar, ref ls_log )
//			If ls_Log <> '' and not isnull(ls_Log) Then
//				iuo_comum_vtex.of_grava_log_item( il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
//				ls_Situacao = 'E'
//				ls_Log = ''
//				w_ge501_aguarde.uo_progress.of_setprogress(ll_for)
//				Continue
//			end if
//			
//		End if
		
		iuo_comum_vtex.idc_qt_saldo = ll_saldo_distribuidora	
		iuo_comum_vtex.il_cd_produto = ll_cd_produto	
			
		if lb_liberado_atualizar = True Then
			
			If iuo_comum_vtex.is_warehouseid_virtual = iuo_comum_vtex.is_warehouseid and Not isnull(iuo_comum_vtex.is_warehouseid_virtual) Then
				
				iuo_comum_vtex.idc_qt_saldo = ll_qt_saldo_total
				
				if Not this.of_monta_json( ref ls_json, ll_qt_saldo_total, ref ls_log) Then return false
				
			else
				if Not this.of_monta_json( ref ls_json, ll_saldo_distribuidora, ref ls_log) Then return false
						
			End if
			
			if isnull(ls_json) then ls_json = ''
			
			//Se h$$HEX1$$e100$$ENDHEX$$ separa$$HEX2$$e700e300$$ENDHEX$$o entre estoque fisico da loja e estoque virtual (Fisico + distribuidoras), atualiza nesse momento somente o estoque virtual. 
			//O estoque fisico (saldo da loja) $$HEX1$$e900$$ENDHEX$$ atualizado na interface Saldo - Filial
			//If iuo_comum_vtex.is_warehouseid_virtual <> '' and Not isnull(iuo_comum_vtex.is_warehouseid_virtual) Then
			
			if Isnull(iuo_comum_vtex.is_warehouseid_virtual) or iuo_comum_vtex.is_warehouseid_virtual = '' Then
				//Envia o saldo para o estoque Principal:
				ls_warehouseid =  iuo_comum_vtex.is_warehouseid
			else
				//Envia o saldo para o estoque virtual:
				ls_warehouseid =  iuo_comum_vtex.is_warehouseid_virtual
			end if
			
			iuo_comum_vtex.is_json = 'Estoque: ' + ls_warehouseid + ' - ' + ls_json
			
			//Envia os dados de saldo para o site.
			iuo_comum_vtex.of_put( ls_json, is_id_interface + '/' + ls_cd_sku + '/warehouses/' + ls_warehouseid , ref ls_retorno, ref ls_log ) 
			
			If ls_Log <> '' and not isnull(ls_Log) Then
				iuo_comum_vtex.of_grava_log_item( il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
				ls_Situacao = 'E'
				ls_Log = ''
				w_ge501_aguarde.uo_progress.of_setprogress(ll_for)
				Continue
			end if
		Else
			iuo_comum_vtex.is_json = 'Produto bloqueado na rede.'
		End if
		
		If Not this.of_atualiza_ecommerce_prd_filial( ll_cd_produto, il_qt_saldo, ref ls_log, ll_Saldo_Filial_Base, ll_saldo_distribuidora ) Then return false
		
		If ll_Contador >= 50 Then
			gf_ge501_commit(SQLCA)
			ll_Contador = 0
		End If
		
		ll_Contador ++
	
		//Grava no log como processado com $$HEX1$$ea00$$ENDHEX$$xito.
		if Not iuo_comum_vtex.of_grava_log_item(il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log ) Then Return false
		
		w_ge501_aguarde.uo_progress.of_setprogress(ll_for)
		
	next

	if isvalid(w_ge501_aguarde) Then Close(w_ge501_aguarde)
	
	lb_sucesso = True
	
Catch ( runtimeerror  lo_rte )
	ls_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_processa_atualizacao_saldo'. Erro: "+lo_rte.GetMessage( )
	Return False		
Finally
	
	if Not lb_sucesso then 
		ls_situacao = 'E'
		
		//sqlca.of_rollback( )
		gf_ge501_RollBack(SQLCA)
		
		// J$$HEX1$$e100$$ENDHEX$$ iniciou o envio dos itens
		If ll_for > 0 Then
			// Atualiza log com erro
			If Not iuo_comum_vtex.of_atualiza_ecommerce_log(il_cd_filial, ll_Seq_Log, 'E', ls_Log, gf_getserverdate(), ref ls_Log) Then Return False
			if Not iuo_comum_vtex.of_grava_log_item(il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log) Then Return false
		Else
			// Se n$$HEX1$$e300$$ENDHEX$$o tiver log insere um novo com erro
			If IsNull(ll_Seq_Log) or ll_Seq_Log = 0 Then
				// Grava in$$HEX1$$ed00$$ENDHEX$$cio do processo - chave e mensagem est$$HEX1$$e300$$ENDHEX$$o indo como nulo
				If Not iuo_comum_vtex.of_grava_log(il_cd_filial, il_cd_tipo, ls_Chave_Nula, 'E', ls_Log, ldh_Data_Nula, gf_getserverdate(), ref ls_Log, ref ll_Seq_Log ) Then Return False
			Else
				// Atualiza log com erro
				If Not iuo_comum_vtex.of_atualiza_ecommerce_log(il_cd_filial, ll_Seq_Log, 'E', ls_Log, gf_getserverdate(), ref ls_Log) Then Return False
			End If		
		End If
	Else
		//sqlca.of_commit( )
		If gf_ge501_commit(SQLCA) Then
			If ll_Linhas > 0 Then
				// Marca o log como processado
				If Not iuo_comum_vtex.of_atualiza_ecommerce_log(il_cd_filial, ll_Seq_Log, ls_Situacao, ls_MSG_Nula, gf_getserverdate(), ref ls_Log) Then Return False
			End If
		End If
	End If
	
	iuo_comum_vtex.of_grava_log_historico(ref ls_id_registro_log, pl_filial, il_cd_tipo, ldh_log_inicio, gf_getserverdate(), ls_situacao, ll_Seq_Log, ref ls_log )	
	
	destroy(iuo_comum_vtex)
//	destroy(lds_filiais)
	destroy(lds_produtos)
	destroy(lds_saldo_distribuidora)

	if isvalid(w_ge501_aguarde) Then Close(w_ge501_aguarde)

End try

return true
end function

public function boolean of_atualiza_ecommerce_prd_filial (long pl_cd_produto, long pl_qt_saldo, ref string ps_log, long pl_saldo_filial, long pl_saldo_distribuidora);long ll_existe
boolean lb_sucesso=false

Try

	select Count(cd_produto)
	into :ll_existe
	from ecommerce_prd_filial
	where id_ecommerce = :is_id_ecommerce
		and id_rede_filial = :is_rede_ecommerce
		and cd_produto = :pl_cd_produto
		and cd_filial = :il_cd_filial;
		
		if sqlca.sqlcode = -1 then 
			ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_ecommerce_prd_filial ~n' + 'Problemas ao consultar a tabela "ecommerce_prd_filial": ~n' + sqlca.sqlerrtext
			return false
		end if
		
	if ll_existe > 0 Then

		//N$$HEX1$$e300$$ENDHEX$$o atualiza o campo qt_saldo_filial (j$$HEX1$$e100$$ENDHEX$$ $$HEX1$$e900$$ENDHEX$$ feito pela interface Saldo - Filial )
		
		Update ecommerce_prd_filial
		set qt_saldo_distribuidora =:pl_saldo_distribuidora, dh_atualizacao_saldo_distrib = :idt_atualizacao
		where id_ecommerce = :is_id_ecommerce
			and id_rede_filial = :is_rede_ecommerce
			and cd_produto = :pl_cd_produto
			and cd_filial = :il_cd_filial;	
	
		if sqlca.sqlcode = -1 then 
			ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_ecommerce_prd_filial ~n' + 'Problemas ao atualizar registro na tabela "ecommerce_prd_filial": ~n' + sqlca.sqlerrtext
			return false
		end if
		
	Else
		
		insert into ecommerce_prd_filial(id_ecommerce, id_rede_filial, cd_produto, cd_filial, qt_saldo, dh_atualizacao, dh_atualizacao_saldo_distrib, qt_saldo_filial, qt_saldo_distribuidora)
		values (:is_id_ecommerce, :is_rede_ecommerce, :pl_cd_produto, :il_cd_filial, 0, getdate(), :idt_atualizacao, :pl_saldo_filial,  :pl_saldo_distribuidora);
		
		if sqlca.sqlcode = -1 then 
			ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_ecommerce_prd_filial ~n' + 'Problemas ao inserir registro na tabela "ecommerce_prd_filial": ~n' + sqlca.sqlerrtext
			return false
		end if
		
	End if

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

public function boolean of_saldo_distribuidoras (long pl_filial, long pl_atualizacao, long pl_filial_saldo, string ps_uf, string ps_id_rede, ref string ps_log);INSERT INTO ecommerce_log_detalhe  ( cd_filial, nr_atualizacao, cd_distribuidora, cd_produto, cd_unidade_federacao,qt_saldo ) 
Select	:pl_filial, 
		:pl_atualizacao,
		 d.cd_distribuidora, 
		 d.cd_produto, 
		 d.cd_unidade_federacao, 
		 COALESCE( d.qt_estoque_disponivel , 0 ) * COALESCE( g.vl_fator_conversao, 1 )
 From distribuidora_produto d
 	Inner join fornecedor f
 		on f.cd_fornecedor = d.cd_distribuidora
 	Inner join filial_distribuidora fd
 		on fd.cd_distribuidora = d.cd_distribuidora
 	Inner join produto_geral g
 		on g.cd_produto = d.cd_produto
	 inner join ecommerce_distrib ec
		on ec.id_ecommerce = '2'
		and ec.cd_distribuidora = d.cd_distribuidora
		and ec.cd_filial = fd.cd_filial
 Where  fd.cd_filial = :pl_filial_saldo
 	and d.cd_unidade_federacao = :ps_uf
	and coalesce(d.id_estoque_maior_10dias, 'N') = 'S'
 	and coalesce(f.id_atende_pedido_ecommerce, 'N') = 'S'
 	and coalesce(f.id_situacao, 'A') = 'A'
 	and fd.id_situacao = 'A'
 	and d.id_situacao	 = 'A'
 	and d.qt_estoque_disponivel >= ec.qt_minima_estoque
	and ec.dh_inicio_saldo <= cast(getdate() as date)
	and ec.dh_termino_saldo >= cast(getdate() as date)
    and  ( ( :ps_id_rede = 'DC' and g.id_liberado_ecommerce_dc = 'S' ) 
	or ( :ps_id_rede = 'PP' and g.id_liberado_ecommerce_pp = 'S' ) 
	or ( :ps_id_rede = 'FA' and g.id_liberado_ecommerce = 'S' )
	or ( :ps_id_rede = 'MP' and g.id_liberado_ecommerce_mp = 'S' ) )
	Using SqlCa;
	
If sqlca.sqlcode = -1 then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_saldo_distribuidoras ~n' + 'Problemas ao consultar a tabela "distribuidora_produto": ~n' + sqlca.sqlerrtext
	return false
end if

Return True
end function

public function boolean of_saldo_pendente (long pl_filial, long pl_produto, ref long pl_saldo_pendente, ref string ps_log);SELECT COALESCE( SUM( pep.qt_pedida ), 0 )
Into :pl_saldo_pendente
FROM pedido_ecommerce pe
	INNER JOIN pedido_ecommerce_produto pep
		ON pep.nr_pedido = pe.nr_pedido
WHERE pe.dh_compra >= (select DATEADD (day , -30 , dh_movimentacao ) from parametro where id_parametro = '1')
AND pe.cd_filial			= 454
AND pe.id_situacao	in ('P','A')
and pe.cd_filial_ecommerce <> :pl_filial
AND pep.cd_produto	= :pl_produto
Using SqlCa;
	
If sqlca.sqlcode = -1 then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_saldo_pendente ~n' + 'Problemas ao consultar a tabela "pedido_ecommerce_produto": ~n' + sqlca.sqlerrtext
	return false
end if

Return True
end function

public function boolean of_retorna_parametros (long pl_filial, string ps_rede_filial, ref long pl_filial_base, ref string ps_rede_base, ref string ps_uf_base, ref string ps_vende_termolabil, ref string ps_log);select coalesce(r.cd_filial_hub,r.cd_filial), coalesce(r.id_vende_termolabil,'N')
Into :pl_filial_base, :ps_vende_termolabil
from ecommerce_rede_filial r
where r.id_ecommerce = '2'
  and r.id_rede_filial = :ps_rede_filial
  and r.cd_filial = :pl_filial
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_retorna_parametros ~n' + 'N$$HEX1$$e300$$ENDHEX$$o foram localizados os dados base na "ecommerce_rede_filial".'
		Return false
	Case -1 
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_retorna_parametros ~n' + 'Problemas ao consultar a tabela "ecommerce_rede_filial": ~n' + sqlca.sqlerrtext
		Return false
End Choose

select f.id_rede_filial, c.cd_unidade_federacao
Into :ps_rede_base, :ps_uf_base
from filial f
	inner join cidade c on c.cd_cidade = f.cd_cidade
where f.cd_filial = :pl_filial_base;

if sqlca.sqlcode = -1 then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_retorna_parametros ~n' + 'Problemas ao consultar a tabela "ecommerce_rede_filial": ~n' + sqlca.sqlerrtext
	return false
ENd if

Return True
end function

private function boolean of_monta_json (ref string ps_json, long pl_qt_saldo, ref string ps_log);
ps_json = '{ ' + &
	'"unlimitedQuantity": false, ' + &
	'"dateUtcOnBalanceSystem": null, ' + &
	'"quantity": ' + string(pl_qt_saldo) + &
	'}'

return true
end function

public function boolean of_excluir_reserva_plataforma (string ps_warehouseid, string ps_cd_sku, ref string ps_log);string ls_retorno
string ls_json_restante
string ls_reservas
string ls_id_reserva

uo_ge073_json luo_gera_json

luo_gera_json = Create uo_ge073_json 

//Buscar a lista de reservas vinculadas ao SKU
iuo_comum_vtex.of_get( 'api/logistics/pvt/inventory/reservations/' + ps_warehouseid + '/' + ps_cd_sku , ref ls_retorno, ref ps_log ) 

if ps_log <> '' and not isnull(ps_log) Then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_excluir_reserva_plataforma ; ' + ps_log
	Return false
end if

luo_gera_json.of_divide_grupo_json_tag_vtex(ref ls_retorno, 'items', ref ls_reservas, ']')

ls_retorno=''

Do While luo_gera_json.of_divide_grupo_json_completo(Ref ls_reservas, Ref ls_retorno,'{') 
	
	ls_id_reserva = luo_gera_json.of_busca_conteudo_campo_vtex(ls_retorno, 'LockId')
	
	if ls_id_reserva <> '' and not isnull(ls_id_reserva) Then
	
		//Cancelar a reserva
		iuo_comum_vtex.of_post('','api/logistics/pvt/inventory/reservations/' + ls_id_reserva + '/cancel', ref ls_retorno, ref ps_log)
		
		if ps_log <> '' and not isnull(ps_log) Then
			ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_excluir_reserva_plataforma ; ' + ps_log
			Return false
		end if
	end if
	
Loop

return true
end function

public function boolean of_valida_liberado_site (long pl_cd_produto, ref boolean pb_liberado, ref string ps_log);long ll_qt_saldo_principal

//Verifica se o saldo est$$HEX1$$e100$$ENDHEX$$ liberado pra subir pra VTEX. A interface Saldo - Principal que faz o controle de acordo com as regras de disponibilidade aplicadas.

select qt_saldo
into :ll_qt_saldo_principal
from ecommerce_prd
where id_ecommerce = :is_id_ecommerce
and id_rede_filial = :is_rede_ecommerce
and cd_produto = :pl_cd_produto;

if sqlca.sqlcode = -1 then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_valida_liberado_site ; Problemas ao consultar a tabela "ecommerce_prd" : ' + sqlca.sqlerrtext
	return false
end if

if isnull(ll_qt_saldo_principal) then ll_qt_saldo_principal= 0

if ll_qt_saldo_principal > 0 Then
	pb_liberado = True
else
	pb_liberado = false
end if

return true
end function

public function boolean of_verifica_categoria_bloqueada (long pl_cd_filial, long pl_cd_produto);string ls_categoria_bloqueada

//Verifica se a categoria do produto est$$HEX1$$e100$$ENDHEX$$ bloqueada na filial:
SELECT dbo.f_movimento_bloqueado( :pl_cd_filial, :pl_cd_produto )
into :ls_categoria_bloqueada
from parametro;
					
If ls_categoria_bloqueada = 'S' then
	return true
ELse
	return false
end if
end function

public function boolean of_atualiza_saldo_cd (ref string ps_log);boolean lb_concluido = false

datetime ldh_atual, ldh_atualizacao

string ls_data_atual
string ls_data_atualizacao
string ls_existe

long ll_for, ll_linhas
long ll_cd_produto
long ll_qt_saldo
long ll_cd_filial_cd = 534

dc_uo_ds_base lds_produtos, lds_empurrado, lds_distrib

lds_produtos = create dc_uo_ds_base

Try

	lds_produtos.of_changedataobject( 'ds_ge501_saldo_rede_cd' )
	
	ldh_atual = gf_getserverdate()

	ls_data_atual = string(ldh_atual, 'dd/mm/yyyy hh:mm')
	
	Open(w_Ge501_Aguarde)
	
	w_Ge501_Aguarde.Title = "Vtex - Saldo Rede (Estoque Central) - Atualizando o saldo do CD na base Central"
	
	select vl_parametro
	into :ls_data_atualizacao
	from parametro_geral
	where cd_parametro = 'DH_ATUALIZACAO_SALDO_PROD_ECOMMERCE';
	
	if ls_data_atualizacao = '' or isnull(ls_data_atualizacao) then
		
		ldh_atualizacao = datetime(relativedate(date(ldh_atual),-1), time('00:00'))
		
	else
		
		ldh_atualizacao = datetime(ls_data_atualizacao)
		
	End if
	
	ll_linhas = lds_produtos.retrieve( this.is_id_ecommerce, ldh_atualizacao, date(ldh_atualizacao) )
	
	w_Ge501_Aguarde.uo_progress.of_setmax(ll_Linhas)
	
	for ll_for = 1 to ll_linhas
		
		ll_cd_produto = lds_produtos.getitemnumber(ll_for,'cd_produto')
		ll_qt_saldo = lds_produtos.getitemnumber(ll_for,'qt_saldo_cd')
		ls_existe = lds_produtos.getitemstring(ll_for,'id_existe')
		
		if isnull(ls_existe) then ls_existe = 'N'
		
		if ls_existe = 'N' then
			
			insert into saldo_produto_ecommerce (cd_filial_ecommerce, cd_filial, cd_produto, qt_saldo, dh_atualizacao)
			values(:ll_cd_filial_cd, :ll_cd_filial_cd, :ll_cd_produto, :ll_qt_saldo, :ldh_atual);
			
			if sqlca.sqlcode = -1 then
				ps_log = 'Erro ao inserir registro na tabela saldo_produto_ecommerce: ' + sqlca.sqlerrtext
				return false
			End if
			
		Else
			
			update saldo_produto_ecommerce
			set qt_saldo = :ll_qt_saldo,
					dh_atualizacao = :ldh_atual
			where cd_filial_ecommerce = :ll_cd_filial_cd
			and cd_filial = :ll_cd_filial_cd
			and cd_produto = :ll_cd_produto;
			
			if sqlca.sqlcode = -1 then
				ps_log = 'Erro ao atualizar a tabela saldo_produto_ecommerce: ' + sqlca.sqlerrtext
				return false
			End if
			
		End if
		
		SQLCA.of_commit( )
		
		w_ge501_aguarde.uo_progress.of_setprogress(ll_for)
		
	Next

	update parametro_geral 
	set vl_parametro = :ls_data_atual
	where cd_parametro = 'DH_ATUALIZACAO_SALDO_PROD_ECOMMERCE';
	
	if sqlca.sqlcode = -1 then
		ps_log = 'Erro ao atualizar a tabela parametro_geral: ' + sqlca.sqlerrtext
		return false
	End if

	lb_concluido = true
	
	SQLCA.of_commit( )
	
Finally
	
	Close(w_Ge501_Aguarde)
	
	if lb_concluido = false then
		SQLCA.of_rollback( )
	ENd if
	
	
ENd Try

return true
end function

on uo_ge501_saldo_rede.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge501_saldo_rede.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;is_objeto = 'Objeto: ' + this.classname() + '~n'
end event

