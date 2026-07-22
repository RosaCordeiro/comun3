HA$PBExportHeader$uo_ge501_saldo_filial.sru
forward
global type uo_ge501_saldo_filial from nonvisualobject
end type
end forward

global type uo_ge501_saldo_filial from nonvisualobject
end type
global uo_ge501_saldo_filial uo_ge501_saldo_filial

type variables
string is_objeto
string is_id_ecommerce = '2' //VTEX
string is_id_interface = 'api/logistics/pvt/inventory/skus'
string is_tabela = 'SALDO'
string is_rede_ecommerce
string is_DataSource
string is_vende_termolabil
string is_cd_grupo_psico
string is_id_termolabil

long il_cd_tipo = 5
long il_cd_filial
long il_qt_saldo
long il_qt_reserva
long il_qt_transf
Long il_Carga_Completa
Long il_qt_saldo_Original
Long il_qt_saldo_virtual
Long il_qt_saldo_prestes

Boolean ib_produto_cadastrado

Boolean lb_Desenv = False
Boolean ib_usa_pdv_java = false

datetime idh_busca_saldo_loja

dc_uo_transacao itr_legado

dc_uo_ds_base ids_saldo_produto
dc_uo_ds_base ids_reserva
dc_uo_ds_base ids_transf
dc_uo_ds_base ids_pendentes

dc_uo_ds_base iuo_filiais_hub

uo_ge501_comum iuo_comum_vtex

end variables

forward prototypes
public function boolean of_conecta_filial (ref string ps_log)
public function boolean of_desconecta_filial ()
public function boolean of_valida_dados (long pl_cd_produto, string ps_cd_sku, string ps_warehouseid, ref string ps_log)
public function boolean of_verifica_pedido_ecommerce (long pl_cd_produto, ref long pl_qt_pedido, ref string ps_log)
public function boolean of_atualiza_produto_novo (string ps_rede_filial, long pl_filial, ref string ps_log)
public function boolean of_processa_atualizacao_saldo (string ps_rede_filial, long pl_cd_filial)
public function boolean of_verifica_carga_completa (ref string ps_log)
public function boolean of_filial_parametro (ref string ps_log)
public function boolean of_carrega_transferencia (date pdt_saldo, ref string ps_log)
public function boolean of_carrega_reserva (date pdt_saldo, ref string ps_log)
public function boolean of_atualiza_enviado_site (ref string ps_log, date pdt_saldo)
public function boolean of_atualiza_ecommerce_prd_filial (long pl_cd_produto, long pl_qt_saldo, ref string ps_log, string ps_atualiza_saldo, boolean pb_filial_hub)
public function boolean of_busca_saldo_filial (long pl_cd_produto, date pdt_saldo, ref long pl_qt_saldo, ref string ps_log)
public function boolean of_carrega_saldo_virtual (long pl_cd_filial_virtual, datetime pdt_saldo, string ps_filtro_controlado, date pdt_saldo_filial, ref string ps_log)
public function boolean of_limpa_saldo_geladeira (string ps_rede_filial, long pl_cd_filial)
public function boolean of_carrega_saldo_prestes (date pdt_saldo, string ps_filtro_controlado, ref string ps_log)
public function boolean of_limpa_saldo_controlado (string ps_rede_filial, long pl_cd_filial, ref string ps_log)
public function boolean of_excluir_reserva_plataforma (string ps_cd_sku, ref string ps_log)
private function boolean of_monta_json (ref string ps_json, long pl_qt_saldo, ref string ps_log)
public function boolean of_atualiza_saldo_produto_individual (long pl_cd_produto, string ps_rede_filial, ref string ps_log)
public function boolean of_valida_liberado_site (long pl_cd_produto, string ps_rede, ref boolean pb_liberado, ref string ps_log)
public function boolean of_verifica_categoria_bloqueada (long pl_cd_filial, long pl_cd_produto)
public function boolean of_carrega_produto_bloqueado (ref string ps_log)
public function boolean of_conecta_legado (long pl_cd_filial, ref string ps_log)
public function boolean of_atualiza_seller_hub (long pl_cd_produto, long pl_qt_saldo, long pl_qt_saldo_virtual, ref string ps_log)
public function boolean of_busca_produto_sku (long pl_cd_produto, ref string ps_cd_sku, ref string ps_id_termolabil, ref string ps_log)
public function boolean of_busca_saldo_atual (string ps_rede_filial, long pl_cd_filial, long pl_cd_produto, ref long pl_saldo_atual, ref string ps_log, ref long pl_saldo_atual_original, ref long pl_saldo_pendente_atual, ref long pl_saldo_transf_atual, ref long pl_saldo_prestes_atual, ref long pl_saldo_distribuidora, ref boolean pb_inativar_atualizacao_saldo)
public function boolean of_busca_saldo_cd (long pl_cd_filial, long pl_cd_produto, ref long pl_qt_saldo, ref string ps_log)
public function boolean of_carrega_saldo_retirada (string ps_filtro_controlado, ref string ps_log)
public function boolean of_limpa_saldo_prd_marcado (string ps_rede_filial, long pl_cd_filial, boolean pb_apenas_estoque_virtual, ref string ps_log)
end prototypes

public function boolean of_conecta_filial (ref string ps_log);long ll_cd_filial

if iuo_comum_vtex.il_cd_filial_hub > 0 and il_cd_filial <> iuo_comum_vtex.il_cd_filial_hub Then
	ll_cd_filial = this.iuo_comum_vtex.il_cd_filial_hub
else
	ll_cd_filial = il_cd_filial
end if

if Not iuo_comum_vtex.of_conecta_filial( ll_cd_filial, ref ps_log) then return false

Return True
end function

public function boolean of_desconecta_filial ();if this.ib_usa_pdv_java = false Then

	iuo_comum_vtex.of_desconecta_filial( )
	
Else
	
	If itr_legado.of_IsConnected( ) Then
		itr_legado.of_Disconnect( )
	End If
	
ENd if

return true
end function

public function boolean of_valida_dados (long pl_cd_produto, string ps_cd_sku, string ps_warehouseid, ref string ps_log);long ll_existe

ib_produto_cadastrado = True

if isnull(pl_cd_produto) or pl_cd_produto = 0 Then
	ps_log = 'C$$HEX1$$f300$$ENDHEX$$digo do produto inv$$HEX1$$e100$$ENDHEX$$lido.'
	return false
End if
	
if isnull(ps_cd_sku) or ps_cd_sku = '' Then
	ps_log = 'Produto [' + string(pl_cd_produto) + ']: SKU ainda n$$HEX1$$e300$$ENDHEX$$o cadastrado no Site.'
	ib_produto_cadastrado = False
	return false
End if

if isnull(ps_warehouseid) or ps_warehouseid = '' Then
	ps_log = 'Produto [' + string(pl_cd_produto) + ']: O par$$HEX1$$e200$$ENDHEX$$metro Warehouseid $$HEX1$$e900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio estar configurado para atualiza$$HEX2$$e700e300$$ENDHEX$$o de saldo.'
	return false
End if

return true

end function

public function boolean of_verifica_pedido_ecommerce (long pl_cd_produto, ref long pl_qt_pedido, ref string ps_log);setnull(pl_qt_pedido)

SELECT COALESCE( SUM( pep.qt_pedida ), 0 )
INTO :pl_qt_pedido
FROM pedido_ecommerce pe
		INNER JOIN pedido_ecommerce_produto pep ON pep.nr_pedido = pe.nr_pedido
WHERE pe.dh_compra >= (select DATEADD (day , -30 , dh_movimentacao ) from parametro where id_parametro = '1')
	AND pe.cd_filial = :il_cd_filial
	AND pe.nr_pedido > 999999
	AND pe.id_situacao in ('P','A') //Verificar situa$$HEX2$$e700e300$$ENDHEX$$o
	AND pep.cd_produto = :pl_cd_Produto ;
	
If SQLCA.sqlcode = -1 then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_verifica_pedido_ecommerce ~n' + 'Problemas ao consultar a tabela "pedido_ecommerce": ~n' + sqlca.sqlerrtext
	return false
end if

if isnull(pl_qt_pedido) Then pl_qt_pedido = 0

return true
end function

public function boolean of_atualiza_produto_novo (string ps_rede_filial, long pl_filial, ref string ps_log);long ll_linhas
long ll_Linha
long ll_cd_produto
date ldt_saldo

boolean lb_sucesso = false

dc_uo_ds_base lds

ldt_saldo = gf_primeiro_dia_mes(date(gf_getserverdate() ) )

//**************************************************************************************//
// Pega os produtos que recem foram cadastrados no site e marca para atualizado igual a n
//**************************************************************************************//
try
	
	Open(w_aguarde)
	
	lds = create dc_uo_ds_base

	if not lds.of_changedataobject( 'ds_ge501_produto_novo' , false) Then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_produto_novo ~n' + 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ds_ge501_produto_novo'
		return false
	end if
		
	ll_linhas = lds.Retrieve(is_id_ecommerce, ps_rede_filial,  pl_filial)
	
	if ll_linhas = 0 Then 
		lb_sucesso = True
		return true
	end if
	
	w_aguarde.uo_progress.of_setmax(ll_Linhas)
	
	//Abre conex$$HEX1$$e300$$ENDHEX$$o com a filial
	if Not this.of_conecta_filial( ref ps_log ) then return false
	
	For ll_Linha = 1 to ll_linhas
	
		w_Aguarde.Title = "Atualizando situa$$HEX2$$e700e300$$ENDHEX$$o PRD novo na filial: [" + string(il_cd_filial) +  "] - "  + String(ll_Linha)  + " de " + STring(ll_Linhas)

		ll_cd_produto = lds.object.cd_produto[ll_Linha]
	
		//Marca saldo do produto como atualizado no site.
		Update saldo_produto
		set id_atualizado_site = 'N'
		where cd_produto = :ll_cd_produto
			and dh_saldo = :ldt_saldo
		Using iuo_comum_vtex.itr_filial;
	
		if iuo_comum_vtex.itr_filial.sqlcode = -1 Then
			ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_produto_novo ~n' + 'Problemas ao atualizar registro na tabela "saldo_produto: ~n"' + iuo_comum_vtex.itr_filial.sqlerrtext
			return false
		end if
		
		//itr_filial.of_commit( ) ;
		If Not gf_ge501_commit(iuo_comum_vtex.itr_filial) Then Return False
			
		w_aguarde.uo_progress.of_setprogress(ll_Linha)
	
	next

	lb_sucesso = True

Finally
	
	if lb_sucesso = false Then
		if iuo_comum_vtex.itr_filial.of_isconnected( ) Then
			iuo_comum_vtex.itr_filial.of_rollback( )
		end if
	end if
	
	this.of_desconecta_filial( )
	
	if isvalid(w_aguarde) then Close(w_aguarde)
	
end try

return true
end function

public function boolean of_processa_atualizacao_saldo (string ps_rede_filial, long pl_cd_filial);long ll_linhas, ll_for
long ll_cd_produto
long ll_seq_log
Long ll_Saldo_Atual
Long ll_Saldo_Original
Long ll_Prd_Atualizados
Long ll_Achou
Long ll_Saldo_Pend_Atual
Long ll_Saldo_Transf_Atual
Long ll_Saldo_prestes_Atual
Long ll_Saldo_distribuidora_Atual
Long ll_Saldo_distribuidora_Novo
Long ll_qt_saldo_atualizado
Long ll_cd_filial_hub

String ls_rede_hub
String ls_json, ls_json_virtual
String ls_retorno
String ls_cd_sku
String ls_Chave_Nula
String ls_MSG_Nula
String ls_Log
String ls_Situacao
String ls_situacao_ecommerce, ls_situacao_ecommerce_rede
String ls_id_registro_log
String ls_Query

boolean lb_sucesso=false
boolean lb_liberado_atualizar_site=false
boolean lb_categoria_bloqueada = false
boolean lb_atualizar_saldo_site = true
boolean lb_inativar_atualizacao_saldo = false
boolean lb_executar_prd_marcado = True

DateTime ldh_Data_Nula
dateTime ldh_log_inicio
datetime ldh_atualizacao_saldo
Date ldt_saldo

SetNull(ls_Chave_Nula)
SetNull(ls_MSG_Nula)
SetNull(ldh_Data_Nula)

try 
	
	iuo_comum_vtex = create uo_ge501_comum
	
	ldh_log_inicio = gf_getserverdate()
	ls_situacao = 'P'
	
	setnull(ls_id_registro_log)
	iuo_comum_vtex.of_grava_log_historico(ref ls_id_registro_log, pl_cd_filial, il_cd_tipo, ldh_log_inicio, ldh_Data_Nula, 'C', 0, ref ls_log )

	Open(w_ge501_aguarde)
	w_ge501_aguarde.Title = "Vtex - Saldo Filial ["  + String(pl_cd_filial) + "]"
	
	ldt_saldo 				= gf_primeiro_dia_mes(date(gf_getserverdate() ) )
	il_cd_filial 				= pl_cd_filial
	is_rede_ecommerce 	= ps_rede_filial

	//Carrega os parametros e busca o c$$HEX1$$f300$$ENDHEX$$digo da filial vinculado a rede.
	if Not iuo_comum_vtex.of_parametros_ecommerce_filial( pl_cd_filial, ps_rede_filial, is_id_ecommerce, ref ls_log ) then return false
	
	is_vende_termolabil = iuo_comum_vtex.is_vende_termolabil
	
	If gvo_Aplicacao.ivs_DataSource <> 'central' then
		ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_saldo, a atualiza$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o pode ser a partir do HOMOLOGA.'
		return false
	End If
	
	gf_retorna_loja_pdv_novo(il_cd_filial, ref ib_usa_pdv_java, ref ls_log)
	
	if ib_usa_pdv_java = False Then
	
		// PRODUTOS NAO ATUALIZADOS
		if not ids_saldo_produto.of_changedataobject( 'ds_ge501_saldo_produto_filial_nova' ) Then
			ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_saldo ~n' + 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ds_ge501_saldo_produto_filial_nova'
			return false
		end if
				
		// RESERVAS
		// 16/10/2020 - Foi inclu$$HEX1$$ed00$$ENDHEX$$do no SQL para pegar tamb$$HEX1$$e900$$ENDHEX$$m a quantidade dos pedidos que est$$HEX1$$e300$$ENDHEX$$o EM ABERTO, PEDIDO DROGAEXRESS/ECOMMERCE/IFOOD
		if not ids_reserva.of_changedataobject( 'ds_ge501_saldo_produto_reserva' ) Then
			ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_saldo ~n' + 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ds_ge501_saldo_produto_reserva'
			return false
		end if
		
		// TRANSFERENCIAS
		if not ids_transf.of_changedataobject( 'ds_ge501_saldo_produto_transf' ) Then
			ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_saldo ~n' + 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ds_ge501_saldo_produto_transf'
			return false
		end if
		
		if not this.of_conecta_filial( ref ls_log ) Then return false
		
		//Conecta a datawindow com a transa$$HEX2$$e700e300$$ENDHEX$$o da filial
		ids_saldo_produto.of_settransobject( iuo_comum_vtex.itr_filial )
		ids_reserva.of_settransobject( iuo_comum_vtex.itr_filial )
		ids_transf.of_settransobject( iuo_comum_vtex.itr_filial )
		
	Else
		
		
		// PRODUTOS NAO ATUALIZADOS
		if not ids_saldo_produto.of_changedataobject( 'ds_ge501_saldo_produto_filial_nova_matriz' ) Then
			ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_saldo ~n' + 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ds_ge501_saldo_produto_filial_nova'
			return false
		end if
		
		// RESERVAS
		if not ids_reserva.of_changedataobject( 'ds_ge501_saldo_produto_reserva_matriz' ) Then
			ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_saldo ~n' + 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ds_ge501_saldo_produto_reserva_matriz'
			return false
		end if
		
		// TRANSFERENCIAS
		if not ids_transf.of_changedataobject( 'ds_ge501_saldo_produto_transf_matriz' ) Then
			ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_saldo ~n' + 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ds_ge501_saldo_produto_transf_matriz'
			return false
		end if
		
		if Not this.of_conecta_legado( pl_cd_filial, ref ls_log) Then return false
		
	ENd if
		
	ids_pendentes = create dc_uo_ds_base
	ids_pendentes.of_changedataobject( 'ds_ge501_saldo_produto_pendente')	
		
	iuo_filiais_hub = create dc_uo_ds_base
	iuo_filiais_hub.of_changedataobject( 'ds_ge501_saldo_filiais')	
		
	iuo_filiais_hub.retrieve( is_id_ecommerce, il_cd_filial )	

	If Not This.of_verifica_carga_completa(ref ls_Log) Then Return False
	
	If Not iuo_comum_vtex.of_verifica_venda_controlado(pl_cd_filial, ps_rede_filial, ref ls_log) Then Return False
	
	If Not iuo_comum_vtex.of_filial_hub(pl_cd_filial, ref ls_log) Then Return False
			
	w_Ge501_Aguarde.st_msg.Text = 'Conectado: Listando os produtos...'
	
	// Verifica par$$HEX1$$e200$$ENDHEX$$metros clausa where para controlado/antibiotico
	If Not iuo_comum_vtex.of_query_controlado(pl_cd_filial, ps_rede_filial, ref ls_Query, ref ls_log) Then Return False
	
	if ib_usa_pdv_java = false Then
	
		If il_Carga_Completa > 0 Then
			//ids_saldo_produto.of_appendwhere("(s.id_atualizado_site is not null or (s.id_atualizado_site is null and s.qt_saldo_final > 0) )")
		Else
			ids_saldo_produto.of_appendwhere("(s.id_atualizado_site = 'N' or (s.id_atualizado_site is null and s.qt_saldo_final > 0) )")			
		End If
		
		If Not Isnull(ls_Query) Then
			// ds_ge501_saldo_produto_filial_nova
			ids_saldo_produto.of_appendwhere_subquery(ls_Query, 1)	
			
			//ds_ge501_saldo_produto_reserva
			ids_reserva.of_appendwhere_subquery(ls_Query, 3)	
			
			//ds_ge501_saldo_produto_transf
			ids_transf.of_appendwhere_subquery(ls_Query, 1)	
		End If
		
			////Filtro por produtos de geladeira:
		if is_vende_termolabil = 'N' then
			
			ids_saldo_produto.of_appendwhere_subquery("left(pg.de_produto,2) <> 'ZZ'", 1)	
			
			ids_reserva.of_appendwhere_subquery("left(pg.de_produto,2) <> 'ZZ'", 3)	
			
			ids_transf.of_appendwhere("left(pg.de_produto,2) <> 'ZZ'")
			
		end if
		
	else
		
		If il_Carga_Completa = 0 or isnull(il_Carga_Completa) Then
			
			ids_saldo_produto.of_appendwhere_subquery("s.dh_ultimo_movimento is not null" ,1)
			
			ids_saldo_produto.of_appendwhere_subquery(" (( e.dh_busca_saldo_loja is null and s.qt_saldo_final > 0 ) " + &
																		"or ( e.dh_busca_saldo_loja is not null and exists (select 1 from movimento_estoque m " + &
																															" where m.cd_filial_movimento = s.cd_filial " + &
																															" and m.cd_produto = s.cd_produto " + &
																															" and m.dh_inclusao >= e.dh_busca_saldo_loja) ) ) " ,1)
																		
		End If

		If Not Isnull(ls_Query) Then
			// ds_ge501_saldo_produto_filial_nova
			ids_saldo_produto.of_appendwhere_subquery(ls_Query, 1)	
			
			//ds_ge501_saldo_produto_reserva
			ids_reserva.of_appendwhere_subquery(ls_Query, 3)	
			
			//ds_ge501_saldo_produto_transf
			ids_transf.of_appendwhere_subquery(ls_Query, 1)	
		End If
		
			////Filtro por produtos de geladeira:
		if is_vende_termolabil = 'N' then
			
			ids_saldo_produto.of_appendwhere_subquery("left(pg.de_produto,2) <> 'ZZ'", 1)	

			ids_reserva.of_appendwhere_subquery("left(pg.de_produto,2) <> 'ZZ'", 3)	
			
			ids_transf.of_appendwhere("left(pg.de_produto,2) <> 'ZZ'")
			
		end if
		
	end if
	
//	string ls_teste
//	
//	ls_teste = ids_saldo_produto.getsqlselect( )
	
	idh_busca_saldo_loja = gf_getserverdate()
	
	//Busca os dados da base da filial
	if ib_usa_pdv_java = False Then
		ll_linhas = ids_saldo_produto.retrieve( ldt_saldo, is_rede_ecommerce )
	else
		ll_linhas = ids_saldo_produto.retrieve(il_cd_filial, ldt_saldo, is_rede_ecommerce )
	end if
	
	if ll_linhas < 0 Then
		ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_saldo ~n' + 'Problemas ao consultar o banco de dados na seguinte datawindow: ds_ge501_saldo_produto_filial_nova ~nErro: ' + iuo_comum_vtex.itr_filial.is_lasterrortext
		//Fecha conex$$HEX1$$e300$$ENDHEX$$o com a filial
		if Not this.of_desconecta_filial( ) then return false
		return false
	end if

	If Not This.of_carrega_reserva(ldt_saldo, ref ls_Log) Then Return False
	If Not This.of_carrega_transferencia(ldt_saldo, ref ls_Log) Then Return False
		
	//Veirifica se a filial usa saldo virtual:
	if Not isnull(iuo_comum_vtex.il_cd_filial_saldo_vitual) and iuo_comum_vtex.il_cd_filial_saldo_vitual > 0 then
		If Not this.of_carrega_saldo_virtual( iuo_comum_vtex.il_cd_filial_saldo_vitual, iuo_comum_vtex.idh_atualizacao_saldo , ls_Query, ldt_saldo, ref ls_log) Then return false
	end if	
		
	If Not this.of_carrega_saldo_prestes( ldt_saldo, ls_query, ref ls_log )	Then return false
	
	If Not this.of_carrega_saldo_retirada( ls_query, ref ls_log )	Then return false
		
	if Not this.of_carrega_produto_bloqueado( ref ls_log ) then return false
		
	if ib_usa_pdv_java	= false Then
		// Pega o c$$HEX1$$f300$$ENDHEX$$digo da filial da parametro da filial
		If Not This.of_filial_parametro(ref ls_Log) Then Return False
		
		//Fecha conex$$HEX1$$e300$$ENDHEX$$o com a filial
		w_Ge501_Aguarde.st_msg.Text = 'Desconectando o BD da filial...'
		if Not this.of_desconecta_filial( ) then return false
		
	end if
	
	w_Ge501_Aguarde.st_msg.Text = ''
	
	ll_linhas = ids_saldo_produto.RowCount()
				
	If ll_Linhas > 0 Then
		iuo_comum_vtex.il_qt_item_enviado_site = ll_linhas
         // Grava in$$HEX1$$ed00$$ENDHEX$$cio do processo
		If Not iuo_comum_vtex.of_grava_log(il_cd_filial, il_cd_tipo, ls_Chave_Nula, 'C', ls_MSG_Nula, gf_getserverdate(), gf_getserverdate(), ref ls_Log, ref ll_Seq_Log ) Then Return False
	End If
			
	w_ge501_aguarde.uo_progress.of_setmax(ll_Linhas)
	
	ll_Prd_Atualizados = 0
	
	for ll_for = 1 to ll_linhas
		
		w_ge501_aguarde.Title = "Vtex - Saldo Filial - "  + String(ll_for)  + " de " + STring(ll_Linhas)
		w_Ge501_Aguarde.st_msg.Text = "Filial: [" + string(il_cd_filial) +  "]" 
		
		lb_atualizar_saldo_site = true
		
		iuo_comum_vtex.of_limpa_variaveis( )
		
		ll_cd_produto 	= ids_saldo_produto.object.cd_produto		[ll_for]
		il_qt_saldo 		= ids_saldo_produto.object.qt_saldo_final	[ll_for]
		il_qt_reserva	= ids_saldo_produto.object.qt_reserva		[ll_for]
		il_qt_transf		= ids_saldo_produto.object.qt_transf			[ll_for]
		il_qt_saldo_virtual	= ids_saldo_produto.object.qt_saldo_virtual [ll_for]
		il_qt_saldo_prestes = ids_saldo_produto.object.qt_saldo_prestes [ll_for]
		is_cd_grupo_psico	= ids_saldo_produto.object.cd_grupo_psico	[ll_for]
		ldh_atualizacao_saldo = ids_saldo_produto.object.dh_atualizacao[ll_for]
		
		if ll_cd_produto = 727630 then
			ll_cd_produto = ll_cd_produto
		end if				
						
		If il_Carga_Completa > 0 Then
			//Se for carga completa e o produto ja tiver sido atualizado na data de hoje, nao atualiza novamente.
			
			if ib_usa_pdv_java = False Then
			
				setnull(ldh_atualizacao_saldo)
			
				Select dh_atualizacao
				into :ldh_atualizacao_saldo
				from ecommerce_prd_filial
				where id_ecommerce = :is_id_ecommerce
				and id_rede_filial = :ps_rede_filial
				and cd_filial = :pl_cd_filial
				and cd_produto = :ll_cd_produto
				Using SQLCA;
				
				if SQLCA.sqlcode = -1 then
					ls_log = 'Problemas ao consultar a tabela ecommerce_prd_filial: ' + sqlca.sqlerrtext
					iuo_comum_vtex.of_grava_log_item( il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
					ls_Situacao = 'E'
					ls_Log = ''
					w_ge501_aguarde.uo_progress.of_setprogress(ll_for)
					Continue
				ENd if
				
			End if
			
			if date(ldh_atualizacao_saldo) = date(ldh_log_inicio) Then 
				w_ge501_aguarde.uo_progress.of_setprogress(ll_for)
				Continue
			end if
			
		ENd if
						
		If Not IsNull(is_cd_grupo_psico) Then
			// N$$HEX1$$e300$$ENDHEX$$o envia controlado e nem antibi$$HEX1$$f300$$ENDHEX$$tico
			If iuo_comum_vtex.is_vende_controlado = 'N' and iuo_comum_vtex.is_vende_antibiotico = 'N' Then
				w_ge501_aguarde.uo_progress.of_setprogress(ll_for)
				Continue
			End If
			
			// Somente antibiotico
			If (iuo_comum_vtex.is_vende_controlado = 'N' and iuo_comum_vtex.is_vende_antibiotico = 'S') and is_cd_grupo_psico <> 'W'  Then
				w_ge501_aguarde.uo_progress.of_setprogress(ll_for)
				Continue
			End If
			
			// somente controlado
			If (iuo_comum_vtex.is_vende_controlado = 'S' and iuo_comum_vtex.is_vende_antibiotico = 'N') and is_cd_grupo_psico = 'W' Then
				w_ge501_aguarde.uo_progress.of_setprogress(ll_for)
				Continue
			End If
		End If
	
		il_qt_saldo_Original = il_qt_saldo
		
		If IsNull(il_qt_saldo) 		Then il_qt_saldo 	= 0
		If IsNull(il_qt_reserva) 	Then il_qt_reserva	= 0
		If IsNull(il_qt_transf) 		Then il_qt_transf 	= 0
		If IsNull(il_qt_saldo_virtual) 	Then il_qt_saldo_virtual 	= 0
		If IsNull(il_qt_saldo_prestes) Then il_qt_saldo_prestes = 0
		
		ll_Saldo_Atual 			= 0
		ll_Saldo_Original 		= 0
		ll_Saldo_Pend_Atual 	= 0
		ll_Saldo_Transf_Atual	= 0
		ll_Saldo_prestes_Atual	= 0
		ll_saldo_distribuidora_atual = 0
		ll_Saldo_distribuidora_Novo = 0
		
		If Not of_busca_saldo_atual(is_rede_ecommerce, il_cd_filial, ll_cd_produto, ref ll_Saldo_Atual, ref ls_log, ref ll_Saldo_Original, ref ll_Saldo_Pend_Atual, ref ll_Saldo_Transf_Atual, ref ll_Saldo_prestes_Atual, ref ll_Saldo_distribuidora_Atual, ref lb_inativar_atualizacao_saldo ) Then Return False	
		
		//Atualizacao de saldo do produto inativado na filial. O processo nao deve seguir para esse produto:
		if lb_inativar_atualizacao_saldo = True Then
			ls_Log = ''
			w_ge501_aguarde.uo_progress.of_setprogress(ll_for)
			Continue
		ENd if
		
		If il_qt_saldo < 0 Then il_qt_saldo = 0		
		
		il_qt_saldo = il_qt_saldo - il_qt_reserva - il_qt_transf - il_qt_saldo_prestes
		
		//Soma o saldo fisico da loja ao saldo da distribuidora:
		ll_Saldo_distribuidora_Novo = il_qt_saldo + ll_Saldo_distribuidora_Atual
		
		If il_qt_saldo < 0 Then il_qt_saldo = 0
		if ll_Saldo_distribuidora_Novo < 0 Then ll_Saldo_distribuidora_Novo = 0
		
		//Acrescenta o saldo virtual
		il_qt_saldo = il_qt_saldo + il_qt_saldo_virtual
		
		iuo_comum_vtex.il_cd_produto = ll_cd_produto
		iuo_comum_vtex.idc_qt_saldo = il_qt_saldo
		
		//Busca o c$$HEX1$$f300$$ENDHEX$$digo do SKU
		if Not this.of_busca_produto_sku(ll_cd_produto, ref ls_cd_sku, ref is_id_termolabil, ref ls_log) Then return false
									
		If Not this.of_valida_dados( ll_cd_produto, ls_cd_sku, iuo_comum_vtex.is_warehouseid, ref ls_log ) Then 
			// Se esta cadastrado houve outro erro, neste caso continua
			If Not ib_produto_cadastrado Then
				// X, significa que n$$HEX1$$e300$$ENDHEX$$o houve atualiza$$HEX2$$e700e300$$ENDHEX$$o no produto, somente saldo pendente, neste caso n$$HEX1$$e300$$ENDHEX$$o precisa atualizar 
				// o id_atualizado_site = S
				If ids_saldo_produto.Object.id_enviado_site[ll_for] <> 'X' Then
					ids_saldo_produto.object.id_enviado_site[ll_for] = 'S'
					ll_Prd_Atualizados ++
				End If
				ls_Log = ''
				w_ge501_aguarde.uo_progress.of_setprogress(ll_for)
				Continue
			End If
			
			//Grava log de erro.
			iuo_comum_vtex.of_grava_log_item( il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
			ls_Situacao = 'E'
			ls_Log = ''
		
			Return False
		end if
			
		//Se a categoria do produto estiver bloqueada na filial, sobe zero de saldo pra VTEX:
		lb_categoria_bloqueada = this.of_verifica_categoria_bloqueada( il_cd_filial, ll_cd_produto )	
		
		If lb_categoria_bloqueada = True Then
			
			il_qt_saldo = 0
			ll_saldo_distribuidora_atual = 0
			il_qt_saldo_original = 0
			il_qt_reserva = 0
			il_qt_transf = 0
			il_qt_saldo_prestes = 0
			ll_Saldo_distribuidora_Novo=0
		End if
		
		
		If il_Carga_Completa = 0 or isnull(il_Carga_Completa) Then //Se for carga completa, mandar o saldo pra VTEX mesmo se o saldo for igual ao j$$HEX1$$e100$$ENDHEX$$ enviado.	
			
			// Se  o saldo tiver igual ao que foi enviado por ultimo para o site, ent$$HEX1$$e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o atualiza novamente
			// NULO SIGNIFICA QUE O SALDO ESTA SENDO ENVIADO A PRIMEIRA VEZ
			If iuo_comum_vtex.ib_filial_hub Then
				// Filial hub n$$HEX1$$e300$$ENDHEX$$o atualiza a qt_saldo, por isso que precisa testar o pendente e o de transf
				If (il_qt_saldo_original = ll_Saldo_Original) and (il_qt_reserva = ll_Saldo_Pend_Atual) and (il_qt_transf = ll_Saldo_Transf_Atual) and (il_qt_saldo_prestes = ll_Saldo_prestes_Atual) Then
					
					this.of_atualiza_ecommerce_prd_filial( ll_cd_produto, il_qt_saldo, ref ls_log, 'N' , iuo_comum_vtex.ib_filial_hub)
					
					If ls_Log <> '' and not isnull(ls_Log) Then
						iuo_comum_vtex.of_grava_log_item( il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
						ls_Situacao = 'E'
						ls_Log = ''
						w_ge501_aguarde.uo_progress.of_setprogress(ll_for)
						Continue
					end if
					
					
					w_ge501_aguarde.uo_progress.of_setprogress(ll_for)
					Continue
				End If
			Else
				// il_qt_saldo => aqui j$$HEX1$$e100$$ENDHEX$$ contempla saldo pendente e transfer$$HEX1$$ea00$$ENDHEX$$ncia
				If (il_qt_saldo = ll_Saldo_Atual) and (il_qt_saldo_original = ll_Saldo_Original) Then
					
					this.of_atualiza_ecommerce_prd_filial( ll_cd_produto, il_qt_saldo, ref ls_log, 'N' , iuo_comum_vtex.ib_filial_hub) 
					
					If ls_Log <> '' and not isnull(ls_Log) Then
						iuo_comum_vtex.of_grava_log_item( il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
						ls_Situacao = 'E'
						ls_Log = ''
						w_ge501_aguarde.uo_progress.of_setprogress(ll_for)
						Continue
					end if
					
					w_ge501_aguarde.uo_progress.of_setprogress(ll_for)
					Continue
				End If
			End If
			
		End if
		
		// S$$HEX1$$f300$$ENDHEX$$ atualiza na plataforma se a filial n$$HEX1$$e300$$ENDHEX$$o for HUB, ou se for HUB e estiver configurada para usar estoque principal na VTEX (Fisico).
		if Not iuo_comum_vtex.ib_filial_hub Or ( iuo_comum_vtex.ib_filial_hub = True and iuo_comum_vtex.is_warehouseid <> '' and Not isnull(iuo_comum_vtex.is_warehouseid ) ) Then
			
			// Se passou pela valida$$HEX2$$e700e300$$ENDHEX$$o e existe cadastro atualiza no site, caso contr$$HEX1$$e100$$ENDHEX$$rio pode ser um produto novo, 
			// para n$$HEX1$$e300$$ENDHEX$$o ficar a toda hora l$$HEX1$$e100$$ENDHEX$$ indo verificar coloca como processado, depois quando for cadastrado no site
			// o sistema muda a flag na loja para come$$HEX1$$e700$$ENDHEX$$ar a atualizar
			If ib_produto_cadastrado Then
				
				if il_cd_filial = 454 or ( il_qt_saldo = 0 and ll_Saldo_distribuidora_Novo = 0 )  Then
					lb_liberado_atualizar_site = True
				else
					this.of_valida_liberado_site( ll_cd_produto, is_rede_ecommerce, ref lb_liberado_atualizar_site, ref ls_log )
					
					If ls_Log <> '' and not isnull(ls_Log) Then
						iuo_comum_vtex.of_grava_log_item( il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
						ls_Situacao = 'E'
						ls_Log = ''
						w_ge501_aguarde.uo_progress.of_setprogress(ll_for)
						Continue
					end if
				end if
			
				//Somente atualiza saldo no SIte se o produto estiver liberado ou for uma carga completa (se for esse ultimo caso e o produto nao estiver liberado, sobe sempre saldo 0)
				If lb_liberado_atualizar_site = True or il_Carga_Completa > 0 Then
				
					if lb_liberado_atualizar_site = False Then
						//Se estiver indisponivel pra exibir no SIte, manda sempre saldo 0.
						if Not this.of_monta_json( ref ls_json, 0, ref ls_log) Then return false 
						
						ll_qt_saldo_atualizado = 0
						
					Elseif Not isnull(iuo_comum_vtex.is_warehouseid_virtual) and iuo_comum_vtex.is_warehouseid_virtual <> '' and iuo_comum_vtex.is_warehouseid_virtual = iuo_comum_vtex.is_warehouseid Then
						//Se existe estoque virtual configurado, e $$HEX1$$e900$$ENDHEX$$ igual ao estoque principal, entao adiciona o saldo de distribuidora no estoque principal:
						if Not this.of_monta_json( ref ls_json, ll_Saldo_distribuidora_Novo, ref ls_log) Then return false 
						
						ll_qt_saldo_atualizado = ll_Saldo_distribuidora_Novo
						
					Else
						if Not this.of_monta_json( ref ls_json, il_qt_saldo, ref ls_log) Then return false 
						
						ll_qt_saldo_atualizado = il_qt_saldo
						
					End if
				
					iuo_comum_vtex.is_json = ls_json
				
					//Envia os dados de saldo para o site.
					iuo_comum_vtex.of_put( ls_json, is_id_interface + '/' + ls_cd_sku + '/warehouses/' + iuo_comum_vtex.is_warehouseid , ref ls_retorno, ref ls_log ) 
					
					If ls_Log <> '' and not isnull(ls_Log) Then
						iuo_comum_vtex.of_grava_log_item( il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
						ls_Situacao = 'E'
						ls_Log = ''
						w_ge501_aguarde.uo_progress.of_setprogress(ll_for)
						Continue
					end if
					
					//Nao atualizar mais o estoque virtual com o saldo fisico da loja:
//					//Se usar estoque virtual, e ele for dirferente do estoque principal, atualiza com o saldo fisico da loja + distribuidora
//					if  iuo_comum_vtex.is_warehouseid_virtual <> '' and not isnull( iuo_comum_vtex.is_warehouseid_virtual ) and iuo_comum_vtex.is_warehouseid_virtual <> iuo_comum_vtex.is_warehouseid Then
//						
//						If lb_liberado_atualizar_site = False Then
//							//Se estiver indisponivel pra exibir no SIte, manda sempre saldo 0.
//							if Not this.of_monta_json( ref ls_json_virtual, 0, ref ls_log) Then return false
//						Else
//							//Monta o JSON de envio para o site.
//							if Not this.of_monta_json( ref ls_json_virtual, ll_Saldo_distribuidora_Novo, ref ls_log) Then return false
//						End if
//						
//						//Envia os dados de saldo para o site.
//						iuo_comum_vtex.of_put( ls_json_virtual, is_id_interface + '/' + ls_cd_sku + '/warehouses/' + iuo_comum_vtex.is_warehouseid_virtual , ref ls_retorno, ref ls_log ) 
//						
//						If ls_Log <> '' and not isnull(ls_Log) Then
//							iuo_comum_vtex.of_grava_log_item( il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
//							ls_Situacao = 'E'
//							ls_Log = ''
//							w_ge501_aguarde.uo_progress.of_setprogress(ll_for)
//							Continue
//						end if
//						
//					end if
					
				End if
				
			End If
		
		end if
	
		//Se for produto controlado ou termolabil, nao atualiza nos sellers do hub.
		if ( isnull(is_cd_grupo_psico) or is_cd_grupo_psico = '' ) and ( is_id_termolabil = 'N' or isnull(is_id_termolabil) ) then
	
			this.of_atualiza_seller_hub( ll_cd_produto, il_qt_saldo, ll_Saldo_distribuidora_Novo, ref ls_log )
			
			If ls_Log <> '' and not isnull(ls_Log) Then
				iuo_comum_vtex.of_grava_log_item( il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
				ls_Situacao = 'E'
				ls_Log = ''
				w_ge501_aguarde.uo_progress.of_setprogress(ll_for)
				Continue
			end if
			
		End if
	
	     this.of_atualiza_ecommerce_prd_filial( ll_cd_produto, ll_qt_saldo_atualizado, ref ls_log, 'S', iuo_comum_vtex.ib_filial_hub ) 
		
		If ls_Log <> '' and not isnull(ls_Log) Then
			iuo_comum_vtex.of_grava_log_item( il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
			ls_Situacao = 'E'
			ls_Log = ''
			w_ge501_aguarde.uo_progress.of_setprogress(ll_for)
			Continue
		end if
		
		// X, significa que n$$HEX1$$e300$$ENDHEX$$o houve atualiza$$HEX2$$e700e300$$ENDHEX$$o no produto, somente saldo pendente, neste caso n$$HEX1$$e300$$ENDHEX$$o precisa atualizar 
		// o id_atualizado_site = S
		If ids_saldo_produto.Object.id_enviado_site[ll_for] <> 'X' Then
			ids_saldo_produto.object.id_enviado_site[ll_for] = 'S'
			ll_Prd_Atualizados ++
		End If
		
		//Grava no log como processado com $$HEX1$$ea00$$ENDHEX$$xito.
		if Not iuo_comum_vtex.of_grava_log_item(il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log ) Then Return false
		
		gf_ge501_commit(SQLCA)
		
		w_ge501_aguarde.uo_progress.of_setprogress(ll_for)
		
	next

	if isvalid(w_ge501_aguarde) Then Close(w_ge501_aguarde)

	if ib_usa_pdv_java	= false Then
		
		If il_Carga_Completa = 0 or isnull(il_Carga_Completa) Then //Quando for carga completa nao precisa atualizar na filial
			If ll_Prd_Atualizados > 0 Then
				//Atualiza na base da filial os produtos que foram enviados ao site.
				if Not this.of_atualiza_enviado_site( ref ls_log, ldt_saldo ) Then return false
			End If
		End if
		
		If Not This.of_atualiza_produto_novo(ps_rede_filial, pl_cd_filial, Ref ls_Log ) Then Return False
	
	ENd if
	
	update ecommerce_rede_filial
	set dh_atualizacao_saldo = getdate(), dh_busca_saldo_loja = :idh_busca_saldo_loja
	where id_ecommerce = :is_id_ecommerce
		and id_rede_filial = :ps_rede_filial
		and cd_filial = :pl_cd_filial
	Using SqlCa;
	
	if sqlca.sqlcode = -1 then
		ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_saldo ~n' + 'Problemas ao atualizar a tabela "ecommerce_rede_filial": ~n' + sqlca.sqlerrtext
		return false
	end if
	
	If il_Carga_Completa > 0 Then
		update ecommerce_rede_filial
		set dh_carga_saldo_completa = getdate(), dh_proxima_carga_saldo_comp = null
		where id_ecommerce = :is_id_ecommerce
			and id_rede_filial = :ps_rede_filial
			and cd_filial = :pl_cd_filial
		Using SqlCa;
		
		if sqlca.sqlcode = -1 then
			ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_saldo ~n' + 'Problemas ao atualizar a tabela "ecommerce_rede_filial": ~n' + sqlca.sqlerrtext
			return false
		end if
	End If

	gf_ge501_commit(SQLCA)

	if lb_executar_prd_marcado = True Then

	  this.of_limpa_saldo_prd_marcado( ps_rede_filial, pl_cd_filial, False, ref ls_log)
		
		If ls_Log <> '' and not isnull(ls_Log) Then
			iuo_comum_vtex.of_grava_log_item( il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
			ls_Situacao = 'E'
			ls_Log = ''
		end if
		
		if this.iuo_filiais_hub.rowcount() > 0 then
			
			For ll_for = 1 to this.iuo_filiais_hub.rowcount()
			
				ll_cd_filial_hub = iuo_filiais_hub.object.cd_filial[ll_for]
				ls_rede_hub = iuo_filiais_hub.object.id_rede_filial[ll_for]
		
				this.of_limpa_saldo_prd_marcado( ls_rede_hub, ll_cd_filial_hub, false, ref ls_log)
				
				If ls_Log <> '' and not isnull(ls_Log) Then
					iuo_comum_vtex.of_grava_log_item( il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
					ls_Situacao = 'E'
					ls_Log = ''
					Continue
				end if
				
			Next
	
		End if
		
	ENd if

	lb_sucesso = True

Catch ( runtimeerror  lo_rte )
	ls_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_processa_atualizacao_saldo'. Erro: "+lo_rte.GetMessage( )
	Return False		

Finally
	
	if Not lb_sucesso then 
		
		ls_situacao = 'E'
		
		gf_ge501_rollback(SQLCA)
		
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
		If gf_ge501_commit(SQLCA) Then
			If ll_Linhas > 0 Then
				// Marca o log como processado
				If Not iuo_comum_vtex.of_atualiza_ecommerce_log(il_cd_filial, ll_Seq_Log, ls_Situacao, ls_MSG_Nula, gf_getserverdate(), ref ls_Log) Then Return False
			End If
		End If
	End If
	
	iuo_comum_vtex.of_grava_log_historico(ref ls_id_registro_log, pl_cd_filial, il_cd_tipo, ldh_log_inicio, gf_getserverdate(), ls_situacao, ll_Seq_Log, ref ls_log )
	
	destroy(iuo_comum_vtex)

	destroy(itr_legado)
	destroy(iuo_filiais_hub)
	
	if isvalid(w_ge501_aguarde) Then Close(w_ge501_aguarde)

End try

return true
end function

public function boolean of_verifica_carga_completa (ref string ps_log);Select count(*)
Into :il_Carga_Completa
From ecommerce_rede_filial
where id_ecommerce = :is_id_ecommerce
	and id_rede_filial = :is_rede_ecommerce
	and cd_filial = :il_cd_filial
	and ( dh_atualizacao_saldo is null 
		Or ( dh_proxima_carga_saldo_comp is not null
			and dh_proxima_carga_saldo_comp <= (select dh_movimentacao from parametro where id_parametro = '1') ) )
Using SqlCa;

if sqlca.sqlcode = -1 then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_saldo ~n' + 'Problemas ao consultar a tabela "ecommerce_rede_filial": ~n' + sqlca.sqlerrtext
	return false
end if

If il_Carga_Completa = 0 Then
	
	Select count(*)
	Into :il_Carga_Completa
	From ecommerce_rede_filial
	where id_ecommerce = :is_id_ecommerce
		and id_rede_filial = :is_rede_ecommerce
		and cd_filial = :il_cd_filial
		and DATEPART(dd,getdate()) = coalesce(nr_dia_carga_completa, 0)
		and cast(dh_carga_saldo_completa as date) <> cast(getdate() as date)
	Using SqlCa;
		
	if sqlca.sqlcode = -1 then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_saldo ~n' + 'Problemas ao consultar (2) a tabela "ecommerce_rede_filial": ~n' + sqlca.sqlerrtext
		return false
	end if	
	
End If

Return True
end function

public function boolean of_filial_parametro (ref string ps_log);Long ll_Filial_Parametro

select cd_filial 
Into :ll_Filial_Parametro
from parametro
where id_parametro = '1'
Using iuo_comum_vtex.itr_filial;

If iuo_comum_vtex.itr_filial.SqlCode = -1 Then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_saldo ~n' + 'Problemas ao recuperar os dados da tabela "parametro": ~n' + iuo_comum_vtex.itr_filial.sqlerrtext
	return false
End If

If ll_Filial_Parametro <> il_cd_filial Then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_saldo ~n' + "A filial '" + String(ll_Filial_Parametro) + "' do par$$HEX1$$e200$$ENDHEX$$metro do BD da loja esta diferente da filial '" + string(il_cd_filial) + "'"
	return false
End If

Return True
end function

public function boolean of_carrega_transferencia (date pdt_saldo, ref string ps_log);Long ll_linhas
Long ll_linha
Long ll_cd_produto
Long ll_Find
Long ll_Insert
Long ll_cd_filial_origem, ll_nr_nf
String ls_especie, ls_serie
datetime ldh_recebimento, ldh_recebimento_central
boolean lb_atualizou_transf=false

Try

	// TRANSFERENCIAS
	w_Ge501_Aguarde.st_msg.Text = 'Conectado: Listando transfer$$HEX1$$ea00$$ENDHEX$$ncias...'
	
	if ids_pendentes.retrieve( is_id_ecommerce, is_rede_ecommerce, il_cd_filial, 'TRANSF' ) < 0 then
		ps_log = 'Problemas ao consultar o banco de dados na seguinte datawindow: ds_ge501_saldo_produto_pendente ~nErro: ' + SQLCA.is_lasterrortext
		return false
	ENd if
	
	if ib_usa_pdv_java = false Then
	
		ll_linhas = ids_transf.retrieve(is_rede_ecommerce, pdt_saldo )
		
	else
		
		ll_linhas = ids_transf.retrieve(is_rede_ecommerce, il_cd_filial, pdt_saldo )
		
	end if
	
	if ll_linhas < 0 Then
		if ib_usa_pdv_java = false Then
			ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_carrega_transferencia ~n' + 'Problemas ao consultar o banco de dados na seguinte datawindow: ds_ge501_saldo_produto_transf ~nErro: ' + iuo_comum_vtex.itr_filial.is_lasterrortext
		else
			ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_carrega_transferencia ~n' + 'Problemas ao consultar o banco de dados na seguinte datawindow: ds_ge501_saldo_produto_transf_matriz ~nErro: ' + SQLCA.is_lasterrortext
		end if
		//Fecha conex$$HEX1$$e300$$ENDHEX$$o com a filial
		if Not this.of_desconecta_filial( ) then return false
		Return False
	end if
	
	If ll_linhas > 0 Then
		
		For ll_linha = 1 To ll_linhas
			ll_cd_produto 	= ids_Transf.Object.cd_produto		[ll_linha]
			il_qt_Transf		= ids_Transf.Object.qt_saldo_transf	[ll_linha]
			
			if ll_cd_produto = 15429 then
				ll_cd_produto = ll_cd_produto
			ENd if
			
			If ib_usa_pdv_java = True Then
				
				ll_cd_filial_origem	= ids_Transf.Object.cd_filial_origem[ll_linha]
				ll_nr_nf = ids_Transf.Object.nr_nf[ll_linha]
				ls_especie = ids_Transf.Object.de_especie[ll_linha]
				ls_serie	= ids_Transf.Object.de_serie[ll_linha]
				ldh_recebimento_central = ids_Transf.Object.dh_recebimento[ll_linha]
				
				setnull(ldh_recebimento)
				
				if isnull(ldh_recebimento_central) or date(ldh_recebimento_central) = date('01/01/1900') Then
					//Consultar a tabela nf_transferencia do schema legado para verificar se j$$HEX1$$e100$$ENDHEX$$ houve recebimento:
					Select dh_recebimento
						into :ldh_recebimento
					from nf_transferencia
					where cd_filial_origem = :ll_cd_filial_origem
						and cd_filial_destino = :il_cd_filial
						and nr_nf = :ll_nr_nf
						and de_especie = :ls_especie
						and de_serie = :ls_serie
					Using itr_legado;
					
					if itr_legado.sqlcode = -1 then
						ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_carrega_transferencia ~n' + 'Problemas ao consultar a tabela nf_transferencia (schema legado): ' + itr_legado.sqlerrtext
						return false
					ENd if
					
//					//Se ja foi recebido atualizada na base central (schema dbo):
//					if not isnull(ldh_recebimento) and date(ldh_recebimento) <> date('01/01/1900') Then
//						
//						Update nf_transferencia
//						set dh_recebimento = :ldh_recebimento
//						where cd_filial_origem = :ll_cd_filial_origem
//							and cd_filial_destino = :il_cd_filial
//							and nr_nf = :ll_nr_nf
//							and de_especie = :ls_especie
//							and de_serie = :ls_serie
//							Using SQLCA;
//					
//						if SQLCA.sqlcode = -1 then
//							ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_carrega_transferencia ~n' + 'Problemas ao atualizar a tabela nf_transferencia: ' + SQLCA.sqlerrtext
//							return false
//						ENd if
//						
//					End if
				Else
					ldh_recebimento = ldh_recebimento_central
				ENd if
			else
				setnull(ldh_recebimento)
			ENd if
			
			if isnull(il_qt_Transf) Then il_qt_Transf = 0
	
			//Faz uma nova verificacao se ja foi recebido.
			if not isnull(ldh_recebimento) and date(ldh_recebimento) <> date('01/01/1900') Then
				il_qt_Transf = 0
			ENd if
	
			ll_Find = ids_saldo_produto.Find(  "cd_produto = " + String(ll_cd_produto) , 1, ids_saldo_produto.RowCount())
			
			If ll_Find > 0 Then
				
				if isnull(ids_saldo_produto.Object.qt_transf[ll_Find]) then 
					ids_saldo_produto.Object.qt_transf[ll_Find] = il_qt_Transf
				Else
					ids_saldo_produto.Object.qt_transf[ll_Find] = ids_saldo_produto.Object.qt_transf[ll_Find] + il_qt_Transf
				ENd if
				
			ElseIf ll_Find = 0 Then
				ll_Insert = ids_saldo_produto.InsertRow(0)
				
				If ll_Insert > 0 Then
					ids_saldo_produto.Object.cd_produto			[ll_Insert] = ll_cd_produto
					ids_saldo_produto.Object.qt_Transf			[ll_Insert] = il_qt_Transf
					ids_saldo_produto.Object.qt_saldo_final		[ll_Insert] = ids_Transf.Object.qt_saldo_final[ll_linha]
				Else
					ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_carrega_transferencia ~n' + "Erro ao inserir uma nova linha na DW - transf"
					Return False
				End If
				
			Else
				ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_carrega_transferencia ~n' + "Erro ao find na DW - transf"
				Return False
			End If
			
		Next
		
	End if	
		
	//Tratar os produtos que ainda possuem quantidade em transferencia, nao estao mais em transferencia, mas ainda nao tiveram atualizacao de saldo na loja:
	if ids_pendentes.rowcount() > 0 then
		//Percorre todos os produtos que possuem quantidade em transferencia:
		for ll_linha = 1 to ids_pendentes.rowcount()
			
			ll_cd_produto = ids_pendentes.object.cd_produto[ll_linha]
			
			if ll_cd_produto = 15429 then
				ll_cd_produto = ll_cd_produto
			ENd if
			
			ll_find = ids_saldo_produto.find('cd_produto = ' + string(ll_cd_produto), 1, ids_saldo_produto.rowcount( ))
			if ll_find < 0 then
				ps_log = "Erro no find da datastore ids_saldo_produto."
				Return False
			ENd if
			
			if ll_find = 0 Then //Produto nao teve atualizacao de saldo na loja
				
				ll_find = ids_Transf.find('cd_produto = ' + string(ll_cd_produto), 1, ids_Transf.rowcount( )) 
				if ll_find < 0 then
					ps_log = "Erro no find da datastore ids_reserva."
					Return False
				ENd if
				
				if ll_find = 0 then //Produto nao possui mais quantidade em transferencia
				
					ll_Insert = ids_saldo_produto.InsertRow(0)
				
					If ll_Insert > 0 Then
						ids_saldo_produto.Object.cd_produto[ll_Insert] = ll_cd_produto
						ids_saldo_produto.Object.qt_Transf[ll_Insert] = 0 //Zerar a quantidade em transferencia
						ids_saldo_produto.Object.qt_saldo_final[ll_Insert] = ids_pendentes.Object.qt_saldo_filial[ll_linha]
						ids_saldo_produto.Object.id_enviado_site[ll_Insert] = 'X' // NAO VAI ATUALIZAR O ID_ATUALIZADO_SITE
					Else
						ps_log = "Erro ao inserir uma nova linha na DW"
						Return False
					End If
					
				ENd if
			End if
		Next
		
	END if	

Finally
	if ps_log <> '' and not isnull(ps_log) then ps_log = 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_carrega_transferencia; ' + ps_log
ENd Try

Return True
end function

public function boolean of_carrega_reserva (date pdt_saldo, ref string ps_log);Long ll_linhas
Long ll_linha
Long ll_cd_produto
Long ll_Find
Long ll_Insert

Try

	// RESERVAS
	w_Ge501_Aguarde.st_msg.Text = 'Conectado: Listando reservas...'
	
	if ids_pendentes.retrieve( is_id_ecommerce, is_rede_ecommerce, il_cd_filial, 'RES' ) < 0 then
		ps_log = 'Problemas ao consultar o banco de dados na seguinte datawindow: ds_ge501_saldo_produto_pendente ~nErro: ' + SQLCA.is_lasterrortext
		return false
	ENd if
	
	if ib_usa_pdv_java = false then
		ll_linhas = ids_reserva.retrieve(is_rede_ecommerce, pdt_saldo )
	else
		ll_linhas = ids_reserva.retrieve(il_cd_filial, is_rede_ecommerce, pdt_saldo )
	end if
	
	if ll_linhas < 0 Then
		if ib_usa_pdv_java = false then
			ps_log = 'Problemas ao consultar o banco de dados na seguinte datawindow: ds_ge501_saldo_produto_reserva ~nErro: ' + iuo_comum_vtex.itr_filial.is_lasterrortext
		else
			ps_log = 'Problemas ao consultar o banco de dados na seguinte datawindow: ds_ge501_saldo_produto_reserva_matriz ~nErro: ' + SQLCA.is_lasterrortext
		end if
		//Fecha conex$$HEX1$$e300$$ENDHEX$$o com a filial
		if Not this.of_desconecta_filial( ) then return false
		return false
	end if
	
	// Verifica reserva
	If ll_linhas > 0 Then
		
		For ll_linha = 1 To ll_linhas
			ll_cd_produto 	= ids_reserva.Object.cd_produto			[ll_linha]
			il_qt_reserva	= ids_reserva.Object.qt_saldo_reserva	[ll_linha]
	
			ll_Find = ids_saldo_produto.Find(  "cd_produto = " + String(ll_cd_produto) , 1, ids_saldo_produto.RowCount())
			
			If ll_Find > 0 Then
				
				if isnull(ids_saldo_produto.Object.qt_reserva[ll_Find]) then 
					ids_saldo_produto.Object.qt_reserva[ll_Find] = il_qt_reserva
				Else
					ids_saldo_produto.Object.qt_reserva[ll_Find] = ids_saldo_produto.Object.qt_reserva[ll_Find] + il_qt_reserva
				ENd if
				
				ids_saldo_produto.Object.id_enviado_site[ll_Find] = 'X' // NAO VAI ATUALIZAR O ID_ATUALIZADO_SITE
			ElseIf ll_Find = 0 Then
				ll_Insert = ids_saldo_produto.InsertRow(0)
				
				If ll_Insert > 0 Then
					ids_saldo_produto.Object.cd_produto			[ll_Insert] = ll_cd_produto
					ids_saldo_produto.Object.qt_reserva			[ll_Insert] = il_qt_reserva
					ids_saldo_produto.Object.qt_saldo_final		[ll_Insert] = ids_reserva.Object.qt_saldo_final[ll_linha]
					ids_saldo_produto.Object.id_enviado_site	[ll_Insert] = 'X' // NAO VAI ATUALIZAR O ID_ATUALIZADO_SITE
				Else
					ps_log = "Erro ao inserir uma nova linha na DW"
					Return False
				End If
				
			Else
				ps_log = "Erro no find na DW"
				Return False
			End If
			
		Next
		
	End If
	// Fim reserva

	//Tratar os produtos que possuem quantidade reservada, nao estao mais reservados, mas ainda nao tiveram atualizacao de saldo na loja:
	if ids_pendentes.rowcount() > 0 then
		//Percorre todos os produtos que possuem quantidade pendente (Reservados):		
		for ll_linha = 1 to ids_pendentes.rowcount()
			
			ll_cd_produto = ids_pendentes.object.cd_produto[ll_linha]
			
			ll_find = ids_saldo_produto.find('cd_produto = ' + string(ll_cd_produto), 1, ids_saldo_produto.rowcount( ))
			if ll_find < 0 then
				ps_log = "Erro no find da datastore ids_saldo_produto."
				Return False
			ENd if
			
			if ll_find = 0 Then //Produto nao teve atualizacao de saldo na loja
				
				ll_find = ids_reserva.find('cd_produto = ' + string(ll_cd_produto), 1, ids_reserva.rowcount( )) 
				if ll_find < 0 then
					ps_log = "Erro no find da datastore ids_reserva."
					Return False
				ENd if
				
				if ll_find = 0 then //Produto nao est$$HEX1$$e100$$ENDHEX$$ mais reservado
				
					ll_Insert = ids_saldo_produto.InsertRow(0)
				
					If ll_Insert > 0 Then
						ids_saldo_produto.Object.cd_produto[ll_Insert] = ll_cd_produto
						ids_saldo_produto.Object.qt_reserva[ll_Insert] = 0 //Zerar a quantidade reservada
						ids_saldo_produto.Object.qt_saldo_final[ll_Insert] = ids_pendentes.Object.qt_saldo_filial[ll_linha]
						ids_saldo_produto.Object.id_enviado_site[ll_Insert] = 'X' // NAO VAI ATUALIZAR O ID_ATUALIZADO_SITE
					Else
						ps_log = "Erro ao inserir uma nova linha na DW"
						Return False
					End If
					
				ENd if
			End if
		Next
		
	END if

Finally
	if ps_log <> '' and not isnull(ps_log) then ps_log = 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_carrega_reserva; ' + ps_log
ENd Try

Return True


end function

public function boolean of_atualiza_enviado_site (ref string ps_log, date pdt_saldo);long ll_linhas
long ll_for
long ll_cd_produto
long ll_qt_saldo
long ll_Contador

//date ldt_saldo

boolean lb_sucesso = false

//**************************************************************************************//
// Pega todos os produtos que foram enviados ao site e marca como atualizado no banco de dados da Filial.
//**************************************************************************************//
try
	
	Open(w_ge501_aguarde)
	
	w_ge501_aguarde.Title = "Vtex - Saldo Filial (Status BD Loja)"

	ll_linhas = this.ids_saldo_produto.rowcount( )
	
	if ll_linhas = 0 Then 
		lb_sucesso = True
		return true
	end if
	
	w_ge501_aguarde.uo_progress.of_setmax(ll_Linhas)
			
	For ll_for = 1 to ll_linhas
	
		w_ge501_aguarde.Title = "Vtex - Saldo Filial (Status BD Loja) - "  + String(ll_for)  + " de " + STring(ll_Linhas)
	
		//Somente atualiza os produtos que foram enviados ao site.
		if ids_saldo_produto.object.id_enviado_site[ll_for] <> 'S' Then
			w_ge501_aguarde.uo_progress.of_setprogress(ll_for)
			Continue
		end if
		
		ll_Contador ++
		
		// Conecta somente se achar o primeiro produto para atualizar
		If ll_Contador = 1 Then
			w_Ge501_Aguarde.st_msg.Text = 'Conectando Banco Loja [Status] ...'
			
			if Not this.of_conecta_filial( ref ps_log ) then return false
			w_Ge501_Aguarde.st_msg.Text = 'Conectado Banco Loja [Status] ...'
			
			w_Ge501_Aguarde.st_msg.Text = "Filial: [" + string(il_cd_filial) +  "]"
		End If
	
		ll_cd_produto 	= ids_saldo_produto.object.cd_produto		[ll_for]
		ll_qt_saldo 		= ids_saldo_produto.object.qt_saldo_final	[ll_for]
		//ldt_saldo 		= ids_saldo_produto.object.dh_saldo			[ll_for]
	
		//Marca saldo do produto como atualizado no site.
		Update saldo_produto
		set id_atualizado_site = 'S'
		where cd_produto = :ll_cd_produto
			and dh_saldo = :pdt_saldo
			and qt_saldo_final = :ll_qt_saldo
			Using iuo_comum_vtex.itr_filial;
	
		if iuo_comum_vtex.itr_filial.sqlcode = -1 Then
			ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_enviado_site ~n' + 'Problemas ao atualizar registro na tabela "saldo_produto: ~n"' + iuo_comum_vtex.itr_filial.sqlerrtext
			return false
		end if
		
//		If itr_filial.SQLNRows <> 1 Then
//			ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_enviado_site ~n' + "O saldo do produto n$$HEX1$$e300$$ENDHEX$$o foi atualizado '" + String (ll_cd_produto) + "' - " + itr_filial.sqlerrtext
//			Return False
//		End If
	
		//itr_filial.of_commit( ) ;
		If Not gf_ge501_Commit(iuo_comum_vtex.itr_filial) Then Return False
	
		w_ge501_aguarde.uo_progress.of_setprogress(ll_for)
	
	next

	lb_sucesso = True

Finally
	
	if lb_sucesso = false Then
		if iuo_comum_vtex.itr_filial.of_isconnected( ) Then
			iuo_comum_vtex.itr_filial.of_rollback( )
		end if
	end if
	
	this.of_desconecta_filial( )
	
	if isvalid(w_ge501_aguarde) then Close(w_ge501_aguarde)
	
end try

return true
end function

public function boolean of_atualiza_ecommerce_prd_filial (long pl_cd_produto, long pl_qt_saldo, ref string ps_log, string ps_atualiza_saldo, boolean pb_filial_hub);long ll_existe, ll_linhas, ll_for, ll_cd_filial
string ls_rede
boolean lb_sucesso=false
dc_uo_ds_base luo_filiais_hub

// Se o produto ainda n$$HEX1$$e300$$ENDHEX$$o estiver cadastrado no site n$$HEX1$$e300$$ENDHEX$$o atualiza
If Not ib_produto_cadastrado  Then Return True

Try

	select cd_produto
	into :ll_existe
	from ecommerce_prd_filial
	where id_ecommerce	= :is_id_ecommerce
		and id_rede_filial 	= :is_rede_ecommerce
		and cd_produto 	= :pl_cd_produto
		and cd_filial 		= :il_cd_filial
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
	Case 0
		
		If ps_atualiza_saldo = 'N' Then
			
			// N$$HEX1$$e300$$ENDHEX$$o atualiza os campos qt_saldo, dh_atualizacao, como esta loja $$HEX1$$e900$$ENDHEX$$ HUB o saldo ser$$HEX1$$e100$$ENDHEX$$ atualizado na integra$$HEX2$$e700e300$$ENDHEX$$o de rede
			Update ecommerce_prd_filial
			set dh_busca_saldo_loja = :idh_busca_saldo_loja
			where id_ecommerce	= :is_id_ecommerce
				and id_rede_filial 	= :is_rede_ecommerce
				and cd_produto 	= :pl_cd_produto
				and cd_filial 		= :il_cd_filial
			Using SqlCa;
			
		Else
			
			Update ecommerce_prd_filial
			set qt_saldo = :pl_qt_saldo, 
				dh_atualizacao = getdate(), 
				qt_saldo_pendente =:il_qt_reserva, 
				qt_saldo_transferencia =:il_qt_transf, 
				qt_saldo_filial =:il_qt_saldo_original, 
				dh_busca_saldo_loja = :idh_busca_saldo_loja, 
				qt_saldo_virtual = :il_qt_saldo_virtual, 
				qt_saldo_prestes = :il_qt_saldo_prestes
			where id_ecommerce	= :is_id_ecommerce
				and id_rede_filial 	= :is_rede_ecommerce
				and cd_produto 	= :pl_cd_produto
				and cd_filial 		= :il_cd_filial
			Using SqlCa;
			
		End If
		
		if sqlca.sqlcode = -1 then 
			ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_ecommerce_prd_filial ~n' + 'Problemas ao atualizar registro na tabela "ecommerce_prd_filial": ~n' + sqlca.sqlerrtext
			return false
		end if
		
	Case 100
		
		If pb_filial_hub Then
			
			// Para for$$HEX1$$e700$$ENDHEX$$ar a atualiza$$HEX2$$e700e300$$ENDHEX$$o pela interface de saldo REDE, o qt_saldo fica igual a zero e a data de atualiza$$HEX2$$e700e300$$ENDHEX$$o com um minuto menos que busca o saldo loja
			insert into ecommerce_prd_filial(id_ecommerce, id_rede_filial, cd_produto, cd_filial, qt_saldo, dh_atualizacao, qt_saldo_pendente, qt_saldo_transferencia, qt_saldo_filial, dh_busca_saldo_loja, qt_saldo_virtual, qt_saldo_prestes)
			values (:is_id_ecommerce, :is_rede_ecommerce, :pl_cd_produto, :il_cd_filial, 0, dateadd(ss, -60, getdate()), :il_qt_reserva, :il_qt_transf, :il_qt_saldo_original, :idh_busca_saldo_loja, :il_qt_saldo_virtual, :il_qt_saldo_prestes)
			Using SqlCa;
			
		Else
			
			insert into ecommerce_prd_filial(id_ecommerce, id_rede_filial, cd_produto, cd_filial, qt_saldo, dh_atualizacao, qt_saldo_pendente, qt_saldo_transferencia, qt_saldo_filial, dh_busca_saldo_loja, qt_saldo_virtual, qt_saldo_prestes)
			values (:is_id_ecommerce, :is_rede_ecommerce, :pl_cd_produto, :il_cd_filial, :pl_qt_saldo, getdate(), :il_qt_reserva, :il_qt_transf, :il_qt_saldo_original, :idh_busca_saldo_loja, :il_qt_saldo_virtual, :il_qt_saldo_prestes)
			Using SqlCa;
			
		End If
				
		if sqlca.sqlcode = -1 then 
			ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_ecommerce_prd_filial ~n' + 'Problemas ao inserir registro na tabela "ecommerce_prd_filial": ~n' + sqlca.sqlerrtext
			return false
		end if
		
	Case -1 
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_ecommerce_prd_filial ~n' + 'Problemas ao consultar a tabela "ecommerce_prd_filial": ~n' + sqlca.sqlerrtext
		return false
	End Choose

	ll_existe = 0

	//Atualiza o saldo fisico dos sellers que fazem parte de Hub.
	
	if ( isnull(is_cd_grupo_psico) or is_cd_grupo_psico = '' ) and ( is_id_termolabil = 'N' or isnull(is_id_termolabil) ) then
	
		//Busca os sellers que fazem parte do Hub
		ll_linhas = iuo_filiais_hub.rowcount()
		
		for ll_for = 1 to ll_linhas
		
			ll_cd_filial = iuo_filiais_hub.object.cd_filial[ll_for]
			ls_rede = iuo_filiais_hub.object.id_rede_filial[ll_for]
			
			//Verifica se o produto esta cadastrado para a rede
			select count(*)
			into :ll_existe
			from ecommerce_prd
			where id_ecommerce = :is_id_ecommerce
			and id_rede_filial = :ls_rede
			and cd_produto = :pl_cd_produto;
	
			if sqlca.sqlcode = -1 then 
					ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_ecommerce_prd_filial ~n' + 'Problemas ao consultar a tabela "ecommerce_prd": ~n' + sqlca.sqlerrtext
					return false
				end if
			
			if ll_existe = 0 or isnull(ll_existe) Then Continue
			
			ll_existe = 0
			
			select count(*)
			into :ll_existe
			from ecommerce_prd_filial
			where id_ecommerce	= :is_id_ecommerce
				and id_rede_filial 	= :ls_rede
				and cd_produto 	= :pl_cd_produto
				and cd_filial 		= :ll_cd_filial
			Using SqlCa;
			
			if sqlca.sqlcode = -1 then 
					ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_ecommerce_prd_filial ~n' + 'Problemas ao consultar a tabela "ecommerce_prd_filial(2)": ~n' + sqlca.sqlerrtext
					return false
				end if
			
			if ll_existe > 0 Then
				
				If ps_atualiza_saldo = 'N' Then
				
					Update ecommerce_prd_filial
					set dh_busca_saldo_loja = :idh_busca_saldo_loja
					where id_ecommerce	= :is_id_ecommerce
						and id_rede_filial 	= :ls_rede
						and cd_produto 	= :pl_cd_produto
						and cd_filial 		= :ll_cd_filial
					Using SqlCa;
				
				Else
				
					Update ecommerce_prd_filial
					set dh_atualizacao = getdate(),  
						qt_saldo_pendente =:il_qt_reserva, 
						qt_saldo_transferencia =:il_qt_transf, 
						qt_saldo_filial =:il_qt_saldo_original, 
						dh_busca_saldo_loja = :idh_busca_saldo_loja, 
						qt_saldo_virtual = :il_qt_saldo_virtual, 
						qt_saldo_prestes = :il_qt_saldo_prestes,
						qt_saldo = :pl_qt_saldo
					where id_ecommerce	= :is_id_ecommerce
						and id_rede_filial 	= :ls_rede
						and cd_produto 	= :pl_cd_produto
						and cd_filial 		= :ll_cd_filial
					Using SqlCa;
				
				End if
				
				if sqlca.sqlcode = -1 then 
					ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_ecommerce_prd_filial ~n' + 'Problemas ao atualizar registro na tabela "ecommerce_prd_filial(2)": ~n' + sqlca.sqlerrtext
					return false
				end if
				
			else
				
				insert into ecommerce_prd_filial(id_ecommerce, id_rede_filial, cd_produto, cd_filial, qt_saldo, dh_atualizacao, qt_saldo_pendente, qt_saldo_transferencia, qt_saldo_filial, dh_busca_saldo_loja, qt_saldo_virtual, qt_saldo_prestes)
				values (:is_id_ecommerce, :ls_rede, :pl_cd_produto, :ll_cd_filial, :pl_qt_saldo, getdate(), :il_qt_reserva, :il_qt_transf, :il_qt_saldo_original, :idh_busca_saldo_loja, :il_qt_saldo_virtual, :il_qt_saldo_prestes)
				Using SqlCa;
				
				if sqlca.sqlcode = -1 then 
					ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_ecommerce_prd_filial ~n' + 'Problemas ao inserir registro na tabela "ecommerce_prd_filial(2)": ~n' + sqlca.sqlerrtext
					return false
				end if
				
			end if
	
		Next
		
	ENd if

	lb_sucesso = True

Finally
	
	if lb_sucesso Then
		If Not gf_ge501_commit(SQLCA) Then Return False
	else
		If Not gf_ge501_rollback(SQLCA) Then Return False
	end if
	
End Try

Return true
end function

public function boolean of_busca_saldo_filial (long pl_cd_produto, date pdt_saldo, ref long pl_qt_saldo, ref string ps_log);long ll_qt_saldo

if ib_usa_pdv_java = false then

	select s.qt_saldo_final
	into :ll_qt_saldo
	from saldo_produto s
	where s.dh_saldo = :pdt_saldo
	and s.cd_produto = :pl_cd_produto
	Using iuo_comum_vtex.itr_filial;
	
	if iuo_comum_vtex.itr_filial.sqlcode = -1 then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_busca_saldo_filial; Prolemas ao consultar a tabela "saldo_produto": ' + iuo_comum_vtex.itr_filial.sqlerrtext
		return false
	end if

else
	
	select s.qt_saldo_final
	into :ll_qt_saldo
	from saldo_produto s
	where s.dh_saldo = :pdt_saldo
	and s.cd_produto = :pl_cd_produto
	and s.cd_filial = il_cd_filial
	Using SQLCA;
	
	if SQLCA.sqlcode = -1 then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_busca_saldo_filial; Prolemas ao consultar a tabela "saldo_produto": ' + SQLCA.sqlerrtext
		return false
	end if
	
end if

if isnull( ll_qt_saldo ) then ll_qt_saldo = 0

pl_qt_saldo = ll_qt_saldo

return true

end function

public function boolean of_carrega_saldo_virtual (long pl_cd_filial_virtual, datetime pdt_saldo, string ps_filtro_controlado, date pdt_saldo_filial, ref string ps_log);Long ll_linhas
Long ll_linha
Long ll_cd_produto
Long ll_Find
Long ll_Insert
Long ll_qt_saldo_filial

String ls_rede_virtual

dc_uo_ds_base lds_saldo_virtual

Try
	
	lds_saldo_virtual = create dc_uo_ds_base
	lds_saldo_virtual.of_changedataobject( 'ds_ge501_saldo_produto_filial_virtual' )
	
	w_Ge501_Aguarde.st_msg.Text = 'Conectado: Listando saldo virtual..'
	
	select id_rede_filial
	into :ls_rede_virtual
	from filial
	where cd_filial = :pl_cd_filial_virtual
	Using SQLCA;
	
	if sqlca.sqlcode = -1 then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_carrega_saldo_virtual ~n' + 'Problemas ao consultar a tabela "filial": ~n' + sqlca.is_lasterrortext
		Return False
	end if
	
	//Filtro por produtos de geladeira:
	if is_vende_termolabil = 'N' then
		lds_saldo_virtual.of_appendwhere("left(pg.de_produto,2) <> 'ZZ'")	
	end if
	
	// Filtra os controlados conforme a filial base:
	If ps_filtro_controlado <> '' and not isnull(ps_filtro_controlado) Then
		lds_saldo_virtual.of_appendwhere(ps_filtro_controlado)
	End If
	
	ll_linhas = lds_saldo_virtual.retrieve(ls_rede_virtual, pl_cd_filial_virtual, pdt_saldo)
	
	if ll_linhas < 0 Then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_carrega_saldo_virtual ~n' + 'Problemas ao consultar o banco de dados na seguinte datawindow: ' + lds_saldo_virtual.dataobject + ' ~nErro: ' + sqlca.is_lasterrortext
		Return False
	end if
	
	If ll_linhas > 0 Then
		
		For ll_linha = 1 To ll_linhas
			
			ll_qt_saldo_filial = 0
			
			ll_cd_produto = lds_saldo_virtual.Object.cd_produto[ll_linha]
	
			ll_Find = ids_saldo_produto.Find(  "cd_produto = " + String(ll_cd_produto) , 1, ids_saldo_produto.RowCount())
			
			If ll_Find = 0 Then
				
				ll_Insert = ids_saldo_produto.InsertRow(0)
				
				If ll_Insert > 0 Then
					
					if Not this.of_busca_saldo_filial( ll_cd_produto, pdt_saldo_filial, ref ll_qt_saldo_filial, ref ps_log) then return false
					
					if isnull(ll_qt_saldo_filial) then ll_qt_saldo_filial = 0
					
					ids_saldo_produto.Object.cd_produto			[ll_Insert] = ll_cd_produto
					ids_saldo_produto.Object.qt_saldo_final		[ll_Insert] = ll_qt_saldo_filial 
					ids_saldo_produto.Object.id_enviado_site	[ll_Insert] = 'N'
					ids_saldo_produto.Object.cd_grupo_psico	[ll_Insert] = lds_saldo_virtual.Object.cd_grupo_psico[ll_linha]
					ids_saldo_produto.Object.qt_saldo_virtual	[ll_Insert] = lds_saldo_virtual.Object.qt_saldo[ll_linha]
			
				Else
					ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_carrega_saldo_virtual ~n' + "Erro ao inserir uma nova linha na ids_saldo_produto"
					Return False
				End If
			
			elseif ll_find > 0 Then
				
				//Acrescenta o saldo da filial virtual
				ids_saldo_produto.Object.qt_saldo_virtual[ll_find]	= lds_saldo_virtual.Object.qt_saldo[ll_linha]
			Else
				ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_carrega_saldo_virtual ~n' + "Erro no find na DW - ids_saldo_virtual"
				Return False
			End If
			
		Next
		
	End If	
	
Finally
	destroy(lds_saldo_virtual)
End Try

Return True
end function

public function boolean of_limpa_saldo_geladeira (string ps_rede_filial, long pl_cd_filial);uo_ge501_comum luo_comum_vtex

string ls_Log
string ls_Query
String ls_cd_sku
String ls_json
String ls_retorno
String ls_id_termolabil

Long ll_Linhas
Long ll_For
Long ll_cd_produto

//****************************************************
//ESTA FUN$$HEX2$$c700c300$$ENDHEX$$O $$HEX1$$c900$$ENDHEX$$ SOMENTE PARA ZERAR OS SALDO DOS geladeira
//******************************************************

try 
	luo_comum_vtex = create uo_ge501_comum
	
	Open(w_ge501_aguarde)
	w_ge501_aguarde.Title = "Vtex - Zera Saldo GELADEIRA ["  + String(pl_cd_filial) + "]"
	
	il_cd_filial 				= pl_cd_filial
	is_rede_ecommerce 	= ps_rede_filial
	
	//Carrega os parametros e busca o c$$HEX1$$f300$$ENDHEX$$digo da filial vinculado a rede.
	if Not luo_comum_vtex.of_parametros_ecommerce_filial( pl_cd_filial, ps_rede_filial, is_id_ecommerce, ref ls_log ) then return false

	If luo_comum_vtex.is_vende_termolabil = 'S'  Then
		ls_log = "VERIFIQUE O PAR$$HEX1$$c200$$ENDHEX$$METRO DE LIBERA$$HEX2$$c700c300$$ENDHEX$$O, POIS ESTA LIBERADO GELADEIRA"
		return false
	End If
	
	// ***************************************
	// SOMENTE CONTROLADOS GELADEIRA
	//***************************************
	if not ids_saldo_produto.of_changedataobject( 'ds_ge501_produto_geladeira' ) Then
		ls_log = "Erro o mudar a DW ds_ge501_produto_geladeira"
		return false
	end if
	
	If gvo_Aplicacao.ivs_DataSource <> 'central' then
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", 'Atualiza$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o pode ser a partir do HOMOLOGA.')
		return false
	End If

	w_Ge501_Aguarde.st_msg.Text = 'Conectado: Listando os produtos...'
	
	//Busca os dados da base da filial
	ll_linhas = ids_saldo_produto.retrieve( ps_rede_filial, pl_cd_filial )
		
	If ll_linhas = 0 Then
		ls_Log = 'N$$HEX1$$e300$$ENDHEX$$o foi encontrado registros para serem atualizados.'
		Return False
	ElseIf ll_linhas < 0 Then
		ls_Log = 'Erro ao recuperar os dados da DW.'
		Return False
	End If		

	w_ge501_aguarde.uo_progress.of_setmax(ll_Linhas)
			
	for ll_for = 1 to ll_linhas
			
		luo_comum_vtex.of_limpa_variaveis( )
		
		ll_cd_produto 	= ids_saldo_produto.object.cd_produto		[ll_for]
		
		//Busca o c$$HEX1$$f300$$ENDHEX$$digo do SKU
		if Not this.of_busca_produto_sku(ll_cd_produto, ref ls_cd_sku, ref ls_id_termolabil, ref ls_log) Then return false
		
		ls_json = '{ ' + 	'"unlimitedQuantity": false, ' + '"dateUtcOnBalanceSystem": null, ' + '"quantity": 0}'
				
		//Envia os dados de saldo para o site.
		luo_comum_vtex.of_put( ls_json, is_id_interface + '/' + ls_cd_sku + '/warehouses/' + luo_comum_vtex.is_warehouseid , ref ls_retorno, ref ls_log ) 
				
		If ls_Log <> '' and not isnull(ls_Log) Then Return False
				
		Update ecommerce_prd_filial
		set qt_saldo = 0, dh_atualizacao = getdate(), qt_saldo_pendente =0, qt_saldo_transferencia =0, qt_saldo_filial =0, dh_busca_saldo_loja = getdate(), qt_saldo_distribuidora = 0, qt_saldo_virtual = 0
		where id_ecommerce	= '2'
			and id_rede_filial 	= :ps_rede_filial
			and cd_produto 	= :ll_cd_produto
			and cd_filial 		= :pl_cd_filial
		Using SqlCa;
			
		if sqlca.sqlcode = -1 then 
			ls_log = sqlca.sqlerrtext
			return false
		end if
		
		SqlCa.of_Commit()
		
		//sleep(1)
		
		w_ge501_aguarde.uo_progress.of_setprogress(ll_for)		
	next

Catch ( runtimeerror  lo_rte )
	ls_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_processa_atualizacao_saldo'. Erro: "+lo_rte.GetMessage( )
	Return False		

Finally
	
	destroy(luo_comum_vtex)
	
	if isvalid(w_ge501_aguarde) Then Close(w_ge501_aguarde)
	
	If ls_log <> '' Then
		SqlCa.of_RollBack()
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_log, stopsign!)
	Else
		SqlCa.of_Commit()
	End If
	
End try

return true
end function

public function boolean of_carrega_saldo_prestes (date pdt_saldo, string ps_filtro_controlado, ref string ps_log);Long ll_linhas
Long ll_linha
Long ll_cd_produto
Long ll_Find
Long ll_Insert
string ls_select

dc_uo_ds_base lds_saldo_prestes

Try
	
	if ids_pendentes.retrieve( is_id_ecommerce, is_rede_ecommerce, il_cd_filial, 'PRE' ) < 0 then
		ps_log = 'Problemas ao consultar o banco de dados na seguinte datawindow: ds_ge501_saldo_produto_pendente ~nErro: ' + SQLCA.is_lasterrortext
		return false
	ENd if
	
	lds_saldo_prestes = create dc_uo_ds_base

	if ib_usa_pdv_java = false Then
		
		lds_saldo_prestes.of_changedataobject( 'ds_ge501_saldo_produto_filial_prestes' )
		lds_saldo_prestes.of_settransobject( iuo_comum_vtex.itr_filial )
		
	else
		
		lds_saldo_prestes.of_changedataobject( 'ds_ge501_saldo_produto_filial_prestes_matriz' )
		
	end if
	
	w_Ge501_Aguarde.st_msg.Text = 'Conectado: Listando saldo prestes..'
	
	//Filtro por produtos de geladeira:
	if is_vende_termolabil = 'N' then
		lds_saldo_prestes.of_appendwhere("left(pg.de_produto,2) <> 'ZZ'")	
	end if
	
	// Filtra os controlados conforme a filial base:
	If ps_filtro_controlado <> '' and not isnull(ps_filtro_controlado) Then
		lds_saldo_prestes.of_appendwhere(ps_filtro_controlado)
	End If
	
	ll_linhas = lds_saldo_prestes.retrieve(pdt_saldo, il_cd_filial, is_rede_ecommerce)
	
	if ll_linhas < 0 Then
		if ib_usa_pdv_java = false then
			ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_carrega_saldo_prestes ~n' + 'Problemas ao consultar o banco de dados na seguinte datawindow: ' + lds_saldo_prestes.dataobject + ' ~nErro: ' + iuo_comum_vtex.itr_filial.is_lasterrortext
		else
			ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_carrega_saldo_prestes ~n' + 'Problemas ao consultar o banco de dados na seguinte datawindow: ' + lds_saldo_prestes.dataobject + ' ~nErro: ' + SQLCA.is_lasterrortext
		end if
		Return False
	end if
	
	If ll_linhas > 0 Then
		
		For ll_linha = 1 To ll_linhas
			
			ll_cd_produto = lds_saldo_prestes.Object.cd_produto[ll_linha]
	
			if ll_cd_produto = 734259 then
				ll_cd_produto = 734259 
			end if
	
			ll_Find = ids_saldo_produto.Find(  "cd_produto = " + String(ll_cd_produto) , 1, ids_saldo_produto.RowCount())
			
			If ll_Find = 0 Then
				
				ll_Insert = ids_saldo_produto.InsertRow(0)
				
				If ll_Insert > 0 Then
						
					ids_saldo_produto.Object.cd_produto			[ll_Insert] = ll_cd_produto
					ids_saldo_produto.Object.qt_saldo_final		[ll_Insert] = lds_saldo_prestes.Object.qt_saldo_final[ll_linha] 
					ids_saldo_produto.Object.id_enviado_site	[ll_Insert] = 'N'
					ids_saldo_produto.Object.cd_grupo_psico	[ll_Insert] = lds_saldo_prestes.Object.cd_grupo_psico[ll_linha]
					ids_saldo_produto.Object.qt_saldo_prestes	[ll_Insert] = lds_saldo_prestes.Object.qt_prestes[ll_linha]
			
				Else
					ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_carrega_saldo_prestes ~n' + "Erro ao inserir uma nova linha na ids_saldo_produto"
					Return False
				End If
			
			elseif ll_find > 0 Then
				
				//Acrescenta o saldo da filial virtual
				ids_saldo_produto.Object.qt_saldo_prestes[ll_find]	= lds_saldo_prestes.Object.qt_prestes[ll_linha]
			Else
				ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_carrega_saldo_prestes ~n' + "Erro no find na DW - ids_saldo_virtual"
				Return False
			End If
			
		Next
		
	End If	
	
	//Tratar os produtos que ainda possuem quantidade em prestes, nao estao mais em prestes, e ainda nao tiveram atualizacao de saldo na loja:
	if ids_pendentes.rowcount() > 0 then
		//Percorre todos os produtos que possuem quantidade em transferencia:
		for ll_linha = 1 to ids_pendentes.rowcount()
			
			ll_cd_produto = ids_pendentes.object.cd_produto[ll_linha]
			
			ll_find = ids_saldo_produto.find('cd_produto = ' + string(ll_cd_produto), 1, ids_saldo_produto.rowcount( ))
			if ll_find < 0 then
				ps_log = "Erro no find da datastore ids_saldo_produto."
				Return False
			ENd if
			
			if ll_find = 0 Then //Produto nao teve atualizacao de saldo na loja
				
				ll_find = lds_saldo_prestes.find('cd_produto = ' + string(ll_cd_produto), 1, lds_saldo_prestes.rowcount( )) 
				if ll_find < 0 then
					ps_log = "Erro no find da datastore ids_reserva."
					Return False
				ENd if
				
				if ll_find = 0 then //Produto nao possui mais quantidade prestes
				
					ll_Insert = ids_saldo_produto.InsertRow(0)
				
					If ll_Insert > 0 Then
						ids_saldo_produto.Object.cd_produto[ll_Insert] = ll_cd_produto
						ids_saldo_produto.Object.qt_saldo_prestes[ll_Insert] = 0 //Zerar a quantidade prestes
						ids_saldo_produto.Object.qt_saldo_final[ll_Insert] = ids_pendentes.Object.qt_saldo_filial[ll_linha]
						ids_saldo_produto.Object.id_enviado_site[ll_Insert] = 'X' // NAO VAI ATUALIZAR O ID_ATUALIZADO_SITE
					Else
						ps_log = "Erro ao inserir uma nova linha na DW"
						Return False
					End If
					
				ENd if
			End if
		Next
		
	END if
	
	
Finally
	destroy(lds_saldo_prestes)
End Try

Return True
end function

public function boolean of_limpa_saldo_controlado (string ps_rede_filial, long pl_cd_filial, ref string ps_log);uo_ge501_comum luo_comum_vtex
dc_uo_ds_base lds_dados

string ls_Query
String ls_cd_sku
String ls_json
String ls_retorno
String ls_Grupo_Psico
String ls_id_termolabil

Long ll_Linhas
Long ll_For
Long ll_cd_produto
boolean lb_sucesso = false

//****************************************************
//ESTA FUN$$HEX2$$c700c300$$ENDHEX$$O $$HEX1$$c900$$ENDHEX$$ SOMENTE PARA ZERAR OS SALDO DOS CONTROLADOS
//******************************************************

try 
	luo_comum_vtex = create uo_ge501_comum
	
	if not isvalid(w_ge501_aguarde) then Open(w_ge501_aguarde)
	w_ge501_aguarde.Title = "Vtex - Zera Saldo CONTROLADO ["  + String(pl_cd_filial) + "]"
	
	il_cd_filial 				= pl_cd_filial
	is_rede_ecommerce 	= ps_rede_filial
	
	//If Not luo_comum_vtex.of_verifica_venda_controlado(pl_cd_filial, ps_rede_filial, ref ps_log) Then Return False
	
//	If luo_comum_vtex.is_vende_controlado = 'S' or luo_comum_vtex.is_vende_antibiotico = 'S' Then Return true

	//Carrega os parametros e busca o c$$HEX1$$f300$$ENDHEX$$digo da filial vinculado a rede.
	if Not luo_comum_vtex.of_parametros_ecommerce_filial( pl_cd_filial, ps_rede_filial, is_id_ecommerce, ref ps_log ) then return false
	
	// ***************************************
	// SOMENTE CONTROLADOS PSICO E ANTIBIOTIO
	//***************************************
	lds_dados = create dc_uo_ds_base
	
	if not lds_dados.of_changedataobject( 'ds_ge501_produto_controlado' ) Then
		ps_log = "Fun$$HEX2$$e700e300$$ENDHEX$$o: of_limpa_saldo_controlado; " + "Erro o mudar a DW ds_ge501_produto_controlado"
		return false
	end if
	
	If gvo_Aplicacao.ivs_DataSource <> 'central' then return true

	w_Ge501_Aguarde.st_msg.Text = 'Conectado: Listando os produtos...'
	
	//Busca os dados da base da filial
	ll_linhas = lds_dados.retrieve( ps_rede_filial, pl_cd_filial )
		
	If ll_linhas = 0 Then
		Return True
	ElseIf ll_linhas < 0 Then
		ps_Log = "Fun$$HEX2$$e700e300$$ENDHEX$$o: of_limpa_saldo_controlado; " + 'Erro ao recuperar os dados da DW: ds_ge501_produto_controlado'
		Return False
	End If		
	
	w_ge501_aguarde.uo_progress.of_setmax(ll_Linhas)
			
	for ll_for = 1 to ll_linhas
			
		luo_comum_vtex.of_limpa_variaveis( )
		
		ll_cd_produto = lds_dados.object.cd_produto[ll_for]
		ls_cd_sku = lds_dados.object.cd_sku[ll_for]
		
		ls_json = '{ ' + 	'"unlimitedQuantity": false, ' + '"dateUtcOnBalanceSystem": null, ' + '"quantity": 0}'
				
		//Envia os dados de saldo para o site.
		luo_comum_vtex.of_put( ls_json, is_id_interface + '/' + ls_cd_sku + '/warehouses/' + luo_comum_vtex.is_warehouseid_virtual , ref ls_retorno, ref ps_log ) 
				
		If ps_Log <> '' and not isnull(ps_Log) Then Return False
				
		Update ecommerce_prd_filial
		set  dh_atualizacao_saldo_distrib = getdate(), qt_saldo_distribuidora = 0
		where id_ecommerce	= '2'
			and id_rede_filial 	= :ps_rede_filial
			and cd_produto 	= :ll_cd_produto
			and cd_filial 		= :pl_cd_filial
		Using SqlCa;
			
		if sqlca.sqlcode = -1 then 
			ps_log = "Fun$$HEX2$$e700e300$$ENDHEX$$o: of_limpa_saldo_controlado; " + "Problemas ao atualizar tabela 'ecommerce_prd_filial: " + sqlca.sqlerrtext
			return false
		end if
		
		SqlCa.of_Commit()
		
		w_ge501_aguarde.uo_progress.of_setprogress(ll_for)		
	next

	lb_sucesso = true

Catch ( runtimeerror  lo_rte )
	ps_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_limpa_saldo_controlado'. Erro: "+lo_rte.GetMessage( )
	Return False		

Finally
	
	destroy(luo_comum_vtex)
	
	if isvalid(w_ge501_aguarde) Then Close(w_ge501_aguarde)
	
	if lb_sucesso = false then
		SqlCa.of_RollBack()
	Else
		SqlCa.of_Commit()
	End If
	
End try

return true
end function

public function boolean of_excluir_reserva_plataforma (string ps_cd_sku, ref string ps_log);string ls_retorno
string ls_json_restante
string ls_reservas
string ls_id_reserva

uo_ge073_json luo_gera_json

luo_gera_json = Create uo_ge073_json 

//Buscar a lista de reservas vinculadas ao SKU
iuo_comum_vtex.of_get( 'api/logistics/pvt/inventory/reservations/' + iuo_comum_vtex.is_warehouseid + '/' + ps_cd_sku , ref ls_retorno, ref ps_log ) 

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

private function boolean of_monta_json (ref string ps_json, long pl_qt_saldo, ref string ps_log);
ps_json = '{ ' + &
	'"unlimitedQuantity": false, ' + &
	'"dateUtcOnBalanceSystem": null, ' + &
	'"quantity": ' + string(pl_qt_saldo) + &
	'}'

return true
end function

public function boolean of_atualiza_saldo_produto_individual (long pl_cd_produto, string ps_rede_filial, ref string ps_log);String ls_json, ls_retorno, ls_cd_sku
long ll_for, ll_linhas, ll_cd_filial, ll_qt_saldo, ll_qt_saldo_distrib, ll_qt_saldo_fisico
dc_uo_ds_base lds_dados
uo_ge501_comum luo_comum_vtex

lds_dados = create dc_uo_ds_base
lds_dados.of_changedataobject( 'ds_ge501_filiais_saldo_produto')
if not isvalid(lds_dados.object) Then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_saldo_seller; N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar a seguinte datawindow: ds_ge501_filiais_saldo_produto'
	return false
end if

//Busca todos os seller que possuem saldo do produto.
ll_linhas = lds_dados.retrieve(is_id_ecommerce, ps_rede_filial, pl_cd_produto)

if ll_linhas = 0 then
	return true
elseif ll_linhas < 0 Then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_saldo_seller; Erro ao consultar a seguinte datawindow: ds_ge501_filiais_saldo_produto'
	return false
end if

Try 
	
	Open(w_ge501_aguarde)
	w_ge501_aguarde.Title = "Vtex - Saldo Produto ["  + String(pl_cd_produto) + "]"
	w_ge501_aguarde.uo_progress.of_setmax(ll_Linhas)
		
		Select cd_sku
		into :ls_cd_sku
		from ecommerce_prd
		where id_ecommerce = :is_id_ecommerce
		and id_rede_filial = :ps_rede_filial
		and cd_produto = :pl_cd_produto;	
		
	for ll_for = 1 to ll_linhas
	
		ll_cd_filial = lds_dados.object.cd_filial[ll_for]
		ll_qt_saldo = lds_dados.object.qt_saldo[ll_for]
		ll_qt_saldo_distrib = lds_dados.object.qt_saldo_distribuidora[ll_for]
		
		w_Ge501_Aguarde.st_msg.Text = "Seller: [" + string(ll_cd_filial) +  "]" 
		
		if ls_cd_sku = '' or isnull(ls_cd_sku) then 
			w_ge501_aguarde.uo_progress.of_setprogress(ll_for)
			continue
		end if
		
		luo_comum_vtex = create uo_ge501_comum
		
		//Carrega os parametros e busca o c$$HEX1$$f300$$ENDHEX$$digo da filial vinculado a rede.
		if Not luo_comum_vtex.of_parametros_ecommerce_filial( ll_cd_filial, ps_rede_filial, is_id_ecommerce, ref ps_log ) then return false
			
		if luo_comum_vtex.il_Cd_filial_hub > 0 then
			ll_qt_saldo_fisico = ll_qt_saldo - ll_qt_saldo_distrib
		else
			ll_qt_saldo_fisico = ll_qt_saldo
		end if
	
		if  luo_comum_vtex.il_Cd_filial_hub > 0 and luo_comum_vtex.is_warehouseid_virtual <> '' and not isnull(luo_comum_vtex.is_warehouseid_virtual) then
			
			//Estoque fisico
			ls_json = '{ ' + &
			'"unlimitedQuantity": false, ' + &
			'"dateUtcOnBalanceSystem": null, ' + &
			'"quantity": ' + string(ll_qt_saldo_fisico) + &
			'}'
		
			luo_comum_vtex.of_put( ls_json, 'api/logistics/pvt/inventory/skus/' + ls_cd_sku + '/warehouses/' + luo_comum_vtex.is_warehouseid , ref ls_retorno, ref ps_log ) 
							
			If ps_log <> '' and not isnull(ps_log) Then return false
			
			//Estoque virtual
			ls_json = '{ ' + &
			'"unlimitedQuantity": false, ' + &
			'"dateUtcOnBalanceSystem": null, ' + &
			'"quantity": ' + string(ll_qt_saldo) + &
			'}'
			
			luo_comum_vtex.of_put( ls_json, 'api/logistics/pvt/inventory/skus/' + ls_cd_sku + '/warehouses/' + luo_comum_vtex.is_warehouseid_virtual , ref ls_retorno, ref ps_log ) 
						
			If ps_log <> '' and not isnull(ps_log) Then return false	
			
		else
			
			ls_json = '{ ' + &
			'"unlimitedQuantity": false, ' + &
			'"dateUtcOnBalanceSystem": null, ' + &
			'"quantity": ' + string(ll_qt_saldo_fisico) + &
			'}'
		
			luo_comum_vtex.of_put( ls_json, 'api/logistics/pvt/inventory/skus/' + ls_cd_sku + '/warehouses/' + luo_comum_vtex.is_warehouseid , ref ls_retorno, ref ps_log ) 
							
			If ps_log <> '' and not isnull(ps_log) Then return false
			
			
		end if
		
		Destroy(luo_comum_vtex)
		w_ge501_aguarde.uo_progress.of_setprogress(ll_for)
		
	next

Finally
	Close(w_ge501_aguarde)
End Try

return true
end function

public function boolean of_valida_liberado_site (long pl_cd_produto, string ps_rede, ref boolean pb_liberado, ref string ps_log);long ll_qt_saldo_principal

//Verifica se o saldo est$$HEX1$$e100$$ENDHEX$$ liberado pra subir pra VTEX. A interface Saldo - Principal que faz o controle de acordo com as regras de disponibilidade aplicadas.

select qt_saldo
into :ll_qt_saldo_principal
from ecommerce_prd
where id_ecommerce = :is_id_ecommerce
and id_rede_filial = :ps_rede
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

public function boolean of_carrega_produto_bloqueado (ref string ps_log);Long ll_linhas
Long ll_linha
Long ll_cd_produto
Long ll_Find
Long ll_Insert
string ls_select

dc_uo_ds_base lds_bloqueado

//Carrega os produtos bloqueados na filial que estao com saldo no ecommerce:

Try
	
	lds_bloqueado = create dc_uo_ds_base
		
	lds_bloqueado.of_changedataobject( 'ds_ge501_saldo_produto_filial_bloqueado' )
		
	
	w_Ge501_Aguarde.st_msg.Text = 'Conectado: Listando produtos bloqueados...'
	
	ll_linhas = lds_bloqueado.retrieve(is_id_ecommerce, il_cd_filial, is_rede_ecommerce)
	
	if ll_linhas < 0 Then
		ps_log = 'Problemas ao consultar o banco de dados na seguinte datawindow: ' + lds_bloqueado.dataobject + ' ~nErro: ' + SQLCA.is_lasterrortext
		Return False
	end if
	
	If ll_linhas > 0 Then
		
		For ll_linha = 1 To ll_linhas
			
			ll_cd_produto = lds_bloqueado.Object.cd_produto[ll_linha]
	
			ll_Find = ids_saldo_produto.Find(  "cd_produto = " + String(ll_cd_produto) , 1, ids_saldo_produto.RowCount())
			
			If ll_Find = 0 Then
				
				ll_Insert = ids_saldo_produto.InsertRow(0)
				
				If ll_Insert > 0 Then
						
					ids_saldo_produto.Object.cd_produto			[ll_Insert] = ll_cd_produto
					ids_saldo_produto.Object.qt_saldo_final		[ll_Insert] = 0
					ids_saldo_produto.Object.id_enviado_site	[ll_Insert] = 'N'
			
				Else
					ps_log = "Erro ao inserir uma nova linha na ids_saldo_produto"
					Return False
				End If
			
			Elseif ll_find < 0 then
				ps_log = "Erro no find na DW - ids_saldo_virtual"
				Return False
			End If
			
		Next
		
	End If	
	
Finally
	destroy(lds_bloqueado)
	
	if ps_log <> '' and not isnull(ps_log) Then ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_carrega_produto_bloqueado ~n' + ps_log
	
End Try

Return True
end function

public function boolean of_conecta_legado (long pl_cd_filial, ref string ps_log);
string lvs_Odbc_Destino

is_DataSource = gvo_Aplicacao.ivs_DataSource

itr_legado = create dc_uo_transacao

lvs_Odbc_Destino = String(pl_cd_filial, "0000")

itr_legado.ivs_DataBase = 'POSTGRESQL_JAVA'

If Not itr_legado.of_Connect(lvs_Odbc_Destino, 'vtex_saldo_filial', false) Then	 
	ps_log = 'Problemas ao conectar no schema legado: ' + itr_legado.sqlerrtext
	return false
ENd if

if itr_legado.sqlcode = -1 then
	ps_log = 'Problemas ao conectar no schema legado (filial = ' + string (pl_cd_filial) + ' - ' + itr_legado.sqlerrtext
	return false
end if

return true
end function

public function boolean of_atualiza_seller_hub (long pl_cd_produto, long pl_qt_saldo, long pl_qt_saldo_virtual, ref string ps_log);string ls_json, ls_retorno, ls_rede, ls_cd_sku, ls_json_virtual, ls_inativado
long ll_for, ll_linhas, ll_cd_filial
boolean lb_liberado_atualizar

uo_ge501_comum luo_comum

//Atualizar o saldo fisico dos sellers que fazem parte do hub.

ll_linhas = iuo_filiais_hub.rowcount( )

for ll_for = 1 to ll_linhas
	
	setnull(ls_inativado)
	
	ll_cd_filial = iuo_filiais_hub.object.cd_filial[ll_for]
	ls_rede = iuo_filiais_hub.object.id_rede_filial[ll_for]
	
	select id_inativar_atualizacao_saldo
	into :ls_inativado
	from ecommerce_prd_filial
	where id_ecommerce = '2'
	and id_rede_filial = :ls_rede
	and cd_filial = :ll_cd_filial
	and cd_produto = :pl_cd_produto;
	
	If sqlca.sqlcode = -1 then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_seller_hub; Problemas ao consultar a tabela "ecommerce_prd_filial": ' + sqlca.sqlerrtext
		return false
	end if
	
	if ls_inativado = 'S' then
		Continue
	End if
	
	if il_cd_filial = 454 then
		//Se for HUB de SP sempre atualizar
		lb_liberado_atualizar = True
	else
		if Not this.of_valida_liberado_site( pl_cd_produto, ls_rede, ref lb_liberado_atualizar, ref ps_log ) Then return false
	end if
	
	//Somente atualizar o site se estiver liberado, ou for uma carga completa.
	if lb_liberado_atualizar = True or this.il_carga_completa > 0 Then
	
		Try
		
			luo_comum = create uo_ge501_comum
			
			luo_comum.of_parametros_ecommerce_filial( ll_cd_filial, ls_rede, is_id_ecommerce, ref ps_log )
			
//			//Somente atualiza se o seller estiver configurado para trabalhar de forma separada Estoque fisico e estoque virtual
//			if luo_comum.is_warehouseid_virtual = '' or isnull(luo_comum.is_warehouseid_virtual) Then 
//				Continue
//			end if
			
			select cd_sku
			into :ls_cd_sku
			from ecommerce_prd
			where id_ecommerce = :is_id_ecommerce
			and id_rede_filial = :ls_rede
			and cd_produto = :pl_cd_produto;
			
			If sqlca.sqlcode = -1 then
				ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_seller_hub; Problemas ao consultar a tabela "ecommerce_prd": ' + sqlca.sqlerrtext
				return false
			end if
			
			if ls_cd_sku = '' or isnull(ls_cd_sku) Then Continue
			
			If lb_liberado_atualizar = False Then
				//Se estiver indisponivel pra exibir no SIte, manda sempre saldo 0.
				if Not this.of_monta_json( ref ls_json, 0, ref ps_log) Then return false 
				
			Elseif Not isnull(luo_comum.is_warehouseid_virtual) and luo_comum.is_warehouseid_virtual <> '' and luo_comum.is_warehouseid_virtual = luo_comum.is_warehouseid Then
				//Se existe estoque virtual configurado, e $$HEX1$$e900$$ENDHEX$$ igual ao estoque principal, entao adiciona o saldo de distribuidora no estoque principal:
				if Not this.of_monta_json( ref ls_json, pl_qt_saldo_virtual, ref ps_log) Then return false 
			Else
				if Not this.of_monta_json( ref ls_json, pl_qt_saldo, ref ps_log) Then return false 
			End if
			
			//Atualiza o estoque fisico:
			luo_comum.of_put( ls_json, is_id_interface + '/' + ls_cd_sku + '/warehouses/' + luo_comum.is_warehouseid , ref ls_retorno, ref ps_log ) 
			
			If ps_log <> '' and not isnull(ps_log) Then
				ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_seller_hub ; ' + ps_log
				return false
			end if
			
			//Nao atualizar mais o estoque virtual com o saldo fisico da loja:
//			if  luo_comum.is_warehouseid <> luo_comum.is_warehouseid_virtual Then
//				
//				If lb_liberado_atualizar = False Then
//					//Se estiver indisponivel pra exibir no SIte, manda sempre saldo 0.
//					if Not this.of_monta_json( ref ls_json_virtual, 0, ref ps_log) Then return false 
//				Else
//					if Not this.of_monta_json( ref ls_json_virtual, pl_qt_saldo_virtual, ref ps_log) Then return false 
//				End if
//				
//				//Atualiza tamb$$HEX1$$e900$$ENDHEX$$m o estoque virtual, se nao forem o mesmo estoque:
//				luo_comum.of_put( ls_json_virtual, is_id_interface + '/' + ls_cd_sku + '/warehouses/' + luo_comum.is_warehouseid_virtual , ref ls_retorno, ref ps_log ) 
//				
//				If ps_log <> '' and not isnull(ps_log) Then
//					ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_seller_hub ; ' + ps_log
//					return false
//				end if
//				
//			End if
			
		Finally
			destroy(luo_comum)
		end try
		
	ENd if
	
Next

return true
end function

public function boolean of_busca_produto_sku (long pl_cd_produto, ref string ps_cd_sku, ref string ps_id_termolabil, ref string ps_log);
setnull(ps_cd_sku)
setnull(ps_id_termolabil)

select e.cd_sku, (case when left(p.de_produto,2) = 'ZZ' then 'S' else 'N' End ) as id_produto_termolabil
into :ps_cd_sku, :ps_id_termolabil
from ecommerce_prd e
	inner join produto_geral p on p.cd_produto = e.cd_produto
where e.cd_produto = :pl_cd_produto
	and e.id_ecommerce = :is_id_ecommerce
	and e.id_rede_filial = :is_rede_ecommerce;
	
if sqlca.sqlcode = -1 then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_busca_produto_sku ~n' + 'Problemas ao consultar a tabela "ecommerce_produto": ~n' + sqlca.sqlerrtext
	return false
end if

return true
end function

public function boolean of_busca_saldo_atual (string ps_rede_filial, long pl_cd_filial, long pl_cd_produto, ref long pl_saldo_atual, ref string ps_log, ref long pl_saldo_atual_original, ref long pl_saldo_pendente_atual, ref long pl_saldo_transf_atual, ref long pl_saldo_prestes_atual, ref long pl_saldo_distribuidora, ref boolean pb_inativar_atualizacao_saldo);Long ll_dias_atualizacao
String ls_id_inativar_atualizacao_saldo

Select 	coalesce(qt_saldo, 0), 
			datediff(dd, cast(dh_atualizacao as date), 
			cast(getdate() as date)), 
			coalesce(qt_saldo_filial, 0), 
			coalesce(qt_saldo_pendente, 0),
			coalesce(qt_saldo_transferencia, 0),
			coalesce(qt_saldo_prestes, 0),
			coalesce(qt_saldo_distribuidora, 0),
			coalesce(id_inativar_atualizacao_saldo, 'N')
Into 	:pl_saldo_atual, 
		:ll_dias_atualizacao, 
		:pl_saldo_atual_original,
		:pl_saldo_pendente_atual,
		:pl_saldo_transf_atual,
		:pl_saldo_prestes_atual,
		:pl_saldo_distribuidora,
		:ls_id_inativar_atualizacao_saldo
From ecommerce_prd_filial
Where id_ecommerce = :is_id_ecommerce
  and id_rede_filial = :ps_rede_filial
  and cd_produto = :pl_cd_produto
  and cd_filial = :pl_cd_filial
Using SqlCa;
	
if sqlca.sqlcode = -1 then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_busca_saldo_atual ~n' + 'Problemas ao consultar a tabela "ecommerce_prd_filial": ~n' + sqlca.sqlerrtext
	return false
end if

If ls_id_inativar_atualizacao_saldo = 'S' Then
	pb_inativar_atualizacao_saldo = True
Else
	pb_inativar_atualizacao_saldo = False
End if

if isnull(pl_saldo_atual) then pl_saldo_atual = 0
if isnull(pl_saldo_atual_original) then pl_saldo_atual_original = 0
if isnull(pl_saldo_pendente_atual) then pl_saldo_pendente_atual = 0
if isnull(pl_saldo_transf_atual) then pl_saldo_transf_atual = 0
if isnull(pl_saldo_prestes_atual) then pl_saldo_prestes_atual = 0
if isnull(pl_saldo_distribuidora) then pl_saldo_distribuidora = 0

If il_Carga_Completa > 0 Then
	If sqlca.sqlcode = 100 or ll_dias_atualizacao >= 5 Then
		///SetNull(pl_saldo_atual)
		pl_saldo_atual = -1000
		pl_saldo_atual_original = -1000
	End If
Else
	If sqlca.sqlcode = 100 Then
		SetNull(pl_saldo_atual)
		SetNull(pl_saldo_atual_original)
	End If
End If

return true
end function

public function boolean of_busca_saldo_cd (long pl_cd_filial, long pl_cd_produto, ref long pl_qt_saldo, ref string ps_log);long ll_qt_saldo
long ll_fator
long ll_qtde_minima

Try

	SELECT dbo.saldo_atual_estoque_central( :pl_cd_filial, pg.cd_produto, 'S'),
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
		ps_log = 'Problemas ao consultar a fun$$HEX2$$e700e300$$ENDHEX$$o "saldo_atual_estoque_central": ' + sqlca.sqlerrtext
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
		ps_log = 'Problemas ao consultar informa$$HEX2$$e700f500$$ENDHEX$$es da tabela "ecommerce_distrib": ' + sqlca.sqlerrtext
		return false
	end if
	
	// Para garantir a qtde m$$HEX1$$ed00$$ENDHEX$$nima de estoque
	If ll_qt_saldo < ll_qtde_minima Then ll_qt_saldo = 0
	
	pl_qt_saldo = ll_qt_saldo * ll_fator
	
	If IsNull(pl_qt_saldo) Then pl_qt_saldo = 0

Finally
	if ps_log <> '' and not isnull(ps_log) then ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_busca_saldo_cd;' + ps_log
End Try

return true
end function

public function boolean of_carrega_saldo_retirada (string ps_filtro_controlado, ref string ps_log);Long ll_linhas
Long ll_linha
Long ll_cd_produto
Long ll_Find
Long ll_Insert
string ls_select

dc_uo_ds_base lds_saldo_retirada

Try
	
	//Verificar se a loja possui produtos com saldo reservados pra retirada da loja.
	//Esse saldo deve ser descontado do saldo dos produtos.
	
	lds_saldo_retirada = create dc_uo_ds_base

	lds_saldo_retirada.of_changedataobject( 'ds_ge501_saldo_produto_filial_retirada' )

	w_Ge501_Aguarde.st_msg.Text = 'Conectado: Listando saldo retirada..'
	
	//Filtro por produtos de geladeira:
	if is_vende_termolabil = 'N' then
		lds_saldo_retirada.of_appendwhere_subquery( "left(pg.de_produto,2) <> 'ZZ'", 1)
		lds_saldo_retirada.of_appendwhere_subquery( "left(pg.de_produto,2) <> 'ZZ'", 2)
	end if
	
	// Filtra os controlados conforme a filial base:
	If ps_filtro_controlado <> '' and not isnull(ps_filtro_controlado) Then
		lds_saldo_retirada.of_appendwhere_subquery(ps_filtro_controlado, 1)
		lds_saldo_retirada.of_appendwhere_subquery(ps_filtro_controlado, 2)
	End If
	
	ll_linhas = lds_saldo_retirada.retrieve(il_cd_filial, is_rede_ecommerce)
	
	if ll_linhas < 0 Then
		ps_log = 'Problemas ao consultar o banco de dados na seguinte datawindow: ' + lds_saldo_retirada.dataobject + '; Erro: ' + SQLCA.is_lasterrortext
		Return False
	end if
	
	If ll_linhas > 0 Then
		
		For ll_linha = 1 To ll_linhas
			
			ll_cd_produto = lds_saldo_retirada.Object.cd_produto[ll_linha]
	
			ll_Find = ids_saldo_produto.Find(  "cd_produto = " + String(ll_cd_produto) , 1, ids_saldo_produto.RowCount())
			
			If ll_Find = 0 Then
				
				ll_Insert = ids_saldo_produto.InsertRow(0)
				
				If ll_Insert > 0 Then
						
					ids_saldo_produto.Object.cd_produto			[ll_Insert] = ll_cd_produto
					ids_saldo_produto.Object.qt_saldo_final	[ll_Insert] = lds_saldo_retirada.Object.qt_saldo_filial[ll_linha] 
					ids_saldo_produto.Object.id_enviado_site	[ll_Insert] = 'N'
					ids_saldo_produto.Object.cd_grupo_psico	[ll_Insert] = lds_saldo_retirada.Object.cd_grupo_psico[ll_linha]
					ids_saldo_produto.Object.qt_saldo_prestes	[ll_Insert] = lds_saldo_retirada.Object.qt_solicitada[ll_linha]
			
				Else
					ps_log = "Erro ao inserir uma nova linha na ids_saldo_produto"
					Return False
				End If
			
			elseif ll_find > 0 Then
				
				//Acrescenta o saldo 
				ids_saldo_produto.Object.qt_saldo_prestes[ll_find]	= ids_saldo_produto.Object.qt_saldo_prestes[ll_find] + lds_saldo_retirada.Object.qt_solicitada[ll_linha]
			Else
				ps_log = "Erro no find na DW - ids_saldo_produto"
				Return False
			End If
			
		Next
		
	End If	
	
Finally
	destroy(lds_saldo_retirada)
	if ps_log <> '' and not isnull(ps_log) then ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_carrega_saldo_retirada; ' + ps_log
	
End Try

Return True
end function

public function boolean of_limpa_saldo_prd_marcado (string ps_rede_filial, long pl_cd_filial, boolean pb_apenas_estoque_virtual, ref string ps_log);uo_ge501_comum luo_comum_vtex
dc_uo_ds_base lds_dados

string ls_Query
String ls_cd_sku
String ls_json
String ls_retorno
String ls_id_termolabil

Long ll_Linhas
Long ll_For
Long ll_cd_produto
Long lvl_umporcento, ll_count


//****************************************************
//ESTA FUN$$HEX2$$c700c300$$ENDHEX$$O $$HEX1$$c900$$ENDHEX$$ SOMENTE PARA ZERAR MARCADOS PARA ZERAR
//******************************************************

try 
	luo_comum_vtex = create uo_ge501_comum
	lds_dados = create dc_uo_ds_base
	
	if not isvalid(w_ge501_aguarde) then Open(w_ge501_aguarde)
	w_ge501_aguarde.Title = "Vtex - Zera Saldo PRDS MARCADOS ["  + String(pl_cd_filial) + "]"
	
	is_rede_ecommerce = ps_rede_filial
	
	//Carrega os parametros e busca o c$$HEX1$$f300$$ENDHEX$$digo da filial vinculado a rede.
	if Not luo_comum_vtex.of_parametros_ecommerce_filial( pl_cd_filial, ps_rede_filial, is_id_ecommerce, ref ps_log ) then return false

	// ***************************************
	// SOMENTE PRDS MARCADOS PARA ZERAR
	//***************************************
	if not lds_dados.of_changedataobject( 'ds_ge501_produto_zerar' ) Then
		ps_log = is_objeto + "Fun$$HEX2$$e700e300$$ENDHEX$$o: of_limpa_prd_marcado; Erro o mudar a DW ds_ge501_produto_zerar"
		return false
	end if
	
	If gvo_Aplicacao.ivs_DataSource <> 'central' then return true

	if pb_apenas_estoque_virtual = False Then
		 lds_dados.of_appendwhere("coalesce(e.id_zera_saldo_site, 'N') = 'S'")
	Else
		lds_dados.of_appendwhere("coalesce(e.qt_saldo_distribuidora, 0) > 0")
	ENd if

	w_Ge501_Aguarde.st_msg.Text = 'Listando os produtos...'
	
	//Busca os dados da base da filial
	ll_linhas = lds_dados.retrieve( ps_rede_filial, pl_cd_filial )
		
	If ll_linhas = 0 Then
		return true
	ElseIf ll_linhas < 0 Then
		ps_log = is_objeto + "Fun$$HEX2$$e700e300$$ENDHEX$$o: of_limpa_prd_marcado; Erro ao recuperar os dados da DW: ds_ge501_produto_zerar"
		Return False
	End If		

	w_ge501_aguarde.uo_progress.of_setmax(ll_Linhas)
	
	if ll_Linhas > 100 Then
		lvl_umporcento = ll_Linhas/100
	ENd if
	
	ll_count=1
	
	for ll_for = 1 to ll_linhas
			
		luo_comum_vtex.of_limpa_variaveis( )
		
		ll_cd_produto 	= lds_dados.object.cd_produto[ll_for]
		
		//Busca o c$$HEX1$$f300$$ENDHEX$$digo do SKU
		if Not this.of_busca_produto_sku(ll_cd_produto, ref ls_cd_sku, ref ls_id_termolabil, ref ps_log) Then return false
		
		if isnull(ls_cd_sku) or ls_cd_sku = '' Then 
			
			If ll_linhas <= 100 Then
				w_ge501_aguarde.uo_progress.of_setprogress(ll_for)
			ELse
				if ll_for >= (lvl_umporcento*ll_count) or ll_for >= ll_linhas Then
					ll_count++
					w_ge501_aguarde.uo_progress.of_setprogress(ll_for)
				ENd if
			ENd if
			
			continue
		ENd if
		
		ls_json = '{ ' + 	'"unlimitedQuantity": false, ' + '"dateUtcOnBalanceSystem": null, ' + '"quantity": 0}'
		
		if pb_apenas_estoque_virtual = False Then
		
			//Envia os dados de saldo para o site.
			luo_comum_vtex.of_put( ls_json, is_id_interface + '/' + ls_cd_sku + '/warehouses/' + luo_comum_vtex.is_warehouseid , ref ls_retorno, ref ps_log ) 
			
			If ps_log <> '' and not isnull(ps_log) Then 
				
				If ll_linhas <= 100 Then
					w_ge501_aguarde.uo_progress.of_setprogress(ll_for)	
				ELse
					if ll_for >= (lvl_umporcento*ll_count) or ll_for >= ll_linhas Then
						ll_count++
						w_ge501_aguarde.uo_progress.of_setprogress(ll_for)	
					ENd if
				ENd if
				ps_log = ''
				Continue
			ENd if
		
			if luo_comum_vtex.is_warehouseid_virtual <> '' and not isnull(luo_comum_vtex.is_warehouseid_virtual) and luo_comum_vtex.is_warehouseid_virtual <> luo_comum_vtex.is_warehouseid Then
				//Envia os dados de saldo para o estoque virtual se houver.
				luo_comum_vtex.of_put( ls_json, is_id_interface + '/' + ls_cd_sku + '/warehouses/' + luo_comum_vtex.is_warehouseid_virtual , ref ls_retorno, ref ps_log ) 
				
				If ps_log <> '' and not isnull(ps_log) Then 
					
					If ll_linhas <= 100 Then
						w_ge501_aguarde.uo_progress.of_setprogress(ll_for)	
					ELse
						if ll_for >= (lvl_umporcento*ll_count) or ll_for >= ll_linhas Then
							ll_count++
							w_ge501_aguarde.uo_progress.of_setprogress(ll_for)	
						ENd if
					ENd if
					ps_log = ''
					Continue
				ENd if
				
			End if
			
		Else
			
			//Envia os dados de saldo para o estoque virtual se houver.
				luo_comum_vtex.of_put( ls_json, is_id_interface + '/' + ls_cd_sku + '/warehouses/1_2', ref ls_retorno, ref ps_log ) 
				
				If ps_log <> '' and not isnull(ps_log) Then 
					
					If ll_linhas <= 100 Then
						w_ge501_aguarde.uo_progress.of_setprogress(ll_for)	
					ELse
						if ll_for >= (lvl_umporcento*ll_count) or ll_for >= ll_linhas Then
							ll_count++
							w_ge501_aguarde.uo_progress.of_setprogress(ll_for)	
						ENd if
					ENd if
					ps_log = ''
					Continue
				ENd if
			
		ENd if
		
		if pb_apenas_estoque_virtual = False Then
		
			Update ecommerce_prd_filial
			set qt_saldo = 0, dh_atualizacao = getdate(), qt_saldo_pendente =0, qt_saldo_transferencia =0, qt_saldo_filial =0, dh_busca_saldo_loja = getdate(), qt_saldo_distribuidora = 0, qt_saldo_virtual = 0, id_zera_saldo_site = 'N', qt_saldo_prestes = 0
			where id_ecommerce	= '2'
				and id_rede_filial 	= :ps_rede_filial
				and cd_produto 	= :ll_cd_produto
				and cd_filial 		= :pl_cd_filial
			Using SqlCa;
				
			if sqlca.sqlcode = -1 then 
				ps_log = is_objeto + "Fun$$HEX2$$e700e300$$ENDHEX$$o: of_limpa_prd_marcado; 'Erro ao atualizar a tabela 'ecommerce_prd_filial': " + sqlca.sqlerrtext
				return false
			end if
		
		
		Else
		
			Update ecommerce_prd_filial
			set qt_saldo_distribuidora = 0
			where id_ecommerce	= '2'
				and id_rede_filial 	= :ps_rede_filial
				and cd_produto 	= :ll_cd_produto
				and cd_filial 		= :pl_cd_filial
			Using SqlCa;
				
			if sqlca.sqlcode = -1 then 
				ps_log = is_objeto + "Fun$$HEX2$$e700e300$$ENDHEX$$o: of_limpa_prd_marcado; 'Erro ao atualizar a tabela 'ecommerce_prd_filial': " + sqlca.sqlerrtext
				return false
			end if
		
		ENd if
		
		SqlCa.of_Commit()
		
		If ll_linhas <= 100 Then
			w_ge501_aguarde.uo_progress.of_setprogress(ll_for)	
		ELse
			if ll_for >= (lvl_umporcento*ll_count) or ll_for >= ll_linhas Then
				ll_count++
				w_ge501_aguarde.uo_progress.of_setprogress(ll_for)	
			ENd if
		ENd if
		
	next

Catch ( runtimeerror  lo_rte )
	ps_log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_limpa_saldo_prd_marcado'. Erro: "+lo_rte.GetMessage( )
	Return False		

Finally
	
	destroy(luo_comum_vtex)
	destroy(lds_dados)
	
	if isvalid(w_ge501_aguarde) Then Close(w_ge501_aguarde)
	
	If ps_log <> '' Then
		SqlCa.of_RollBack()
	Else
		SqlCa.of_Commit()
	End If
	
End try

return true
end function

on uo_ge501_saldo_filial.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge501_saldo_filial.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;is_objeto = 'Objeto: ' + this.classname() + '; '

ids_saldo_produto = create dc_uo_ds_base
ids_reserva			= Create dc_uo_ds_base 
ids_transf			= Create dc_uo_ds_base  





end event

event destructor;destroy(ids_saldo_produto)
Destroy(ids_reserva)
Destroy(ids_transf)
end event

