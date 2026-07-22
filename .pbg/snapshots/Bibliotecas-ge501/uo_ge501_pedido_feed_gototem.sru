HA$PBExportHeader$uo_ge501_pedido_feed_gototem.sru
forward
global type uo_ge501_pedido_feed_gototem from nonvisualobject
end type
end forward

global type uo_ge501_pedido_feed_gototem from nonvisualobject
end type
global uo_ge501_pedido_feed_gototem uo_ge501_pedido_feed_gototem

type variables
string is_objeto
string is_id_ecommerce = '2' //VTEX
string is_id_interface = 'api/oms/pvt/orders'
long il_cd_tipo = 7

String is_ODBC_Desenv
String is_pedido_debug
String is_id_registro_log
String is_id_afiliado

Long il_Filial_Desenv

boolean ib_desenv=false

dc_uo_ds_base ids_pedidos
end variables

forward prototypes
public function boolean of_carrega_pedidos (string ps_json)
public function boolean of_atualizar_baixa (string ps_rede_filial, string ps_nr_pedido, string ps_status, ref string ps_log)
public function boolean of_atualizar_feed (string ps_rede_filial, string ps_nr_pedido, string ps_status, string ps_data, datetime pdh_atualizacao, ref string ps_log)
public function boolean of_processa_atualizacao_pedido (string ps_rede_filial, long pl_cd_filial, string ps_id_afiliado)
end prototypes

public function boolean of_carrega_pedidos (string ps_json);string ls_json_restante
string ls_info_pedidos
string ls_nr_pedido
string ls_retorno
string ls_data
string ls_status

long ll_row

uo_ge073_json luo_gera_json

luo_gera_json = Create uo_ge073_json 

ls_json_restante = ps_json

luo_gera_json.of_divide_grupo_json_tag_vtex(ref ls_json_restante, 'list', ref ls_info_pedidos, 'facets')

Do While luo_gera_json.of_divide_grupo_json_completo(Ref ls_info_pedidos, Ref ls_retorno,'{') 
	
	ls_nr_pedido = luo_gera_json.of_busca_conteudo_campo_vtex(ls_retorno, 'orderId')
	ls_status = luo_gera_json.of_busca_conteudo_campo_vtex(ls_retorno, 'status')
	ls_data = luo_gera_json.of_busca_conteudo_campo_vtex(ls_retorno, 'creationDate')
	
	if left(ls_nr_pedido,3) <> is_id_afiliado Then Continue

	ls_nr_pedido = gf_replace(ls_nr_pedido, is_id_afiliado + '-', '',0 )

	ll_row = ids_pedidos.insertrow(0)
	ids_pedidos.object.orderid[ll_row] = ls_nr_pedido
	ids_pedidos.object.state[ll_row] = ls_status
	ids_pedidos.object.lastchange[ll_row] = ls_data

Loop

return true
end function

public function boolean of_atualizar_baixa (string ps_rede_filial, string ps_nr_pedido, string ps_status, ref string ps_log);long ll_existe

Select count(*)
into :ll_existe
from pedido_ecommerce_baixa
where id_ecommerce = :is_id_ecommerce
	and id_rede_filial = :ps_rede_filial
	and nr_pedido_ecommerce = :ps_nr_pedido
	and id_tipo_pedido = :is_id_afiliado
Using SqlCa;

If SqlCa.Sqlcode = -1 Then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_pedido. ~n' + ' Problemas ao selecionar os registros da tabela "pedido_ecommerce_baixa": ~n' + sqlca.sqlerrtext
	return false
End If
	
if isnull(ll_existe) or ll_existe = 0 then
	
	Insert into pedido_ecommerce_baixa(id_ecommerce, id_rede_filial, nr_pedido_ecommerce, dh_baixa, de_status_plataforma, id_tipo_pedido)
		values(:is_id_ecommerce, :ps_rede_filial, :ps_nr_pedido, getdate(), :ps_status, :is_id_afiliado);
	
	if sqlca.sqlcode = -1 then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_pedido. ~n' + ' Problemas ao inserir registro na tabela "pedido_ecommerce_baixa": ~n' + sqlca.sqlerrtext
		return false
	end if
	
elseif ll_existe > 0 Then

	Update pedido_ecommerce_baixa
	set dh_importacao = null, de_status_plataforma = :ps_status
	where id_ecommerce = :is_id_ecommerce
		and id_rede_filial = :ps_rede_filial
		and nr_pedido_ecommerce = :ps_nr_pedido
		and id_tipo_pedido = :is_id_afiliado;

	if sqlca.sqlcode = -1 then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_pedido. ~n' + ' Problemas ao atualizar registro na tabela "pedido_ecommerce_baixa": ~n' + sqlca.sqlerrtext
		return false
	end if

end if

return true
end function

public function boolean of_atualizar_feed (string ps_rede_filial, string ps_nr_pedido, string ps_status, string ps_data, datetime pdh_atualizacao, ref string ps_log);long ll_existe

Select count(*)
Into :ll_existe
From pedido_ecommerce_baixa_feed
Where id_ecommerce = :is_id_ecommerce
and id_rede_filial = :ps_rede_filial
and nr_pedido_ecommerce 	= :ps_nr_pedido
Using SqlCa;

If SqlCa.SqlCode = -1 then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualizar_feed. ~n' + ' Problemas ao localizar registro na tabela "pedido_ecommerce_baixa_feed": ~n' + sqlca.sqlerrtext
	return false
End If

If ll_existe =0  Then

	INSERT INTO pedido_ecommerce_baixa_feed  ( id_ecommerce,   
																  id_rede_filial,   
																  nr_pedido_ecommerce,   
																  eventid,   
																  state,   
																  lastchange,   
																  dh_atualizacao_site)  
	
	VALUES ( :is_id_ecommerce,   
				:ps_rede_filial, 
				:ps_nr_pedido, 
				'1',   
				:ps_status,   
				:ps_data,   
				:pdh_Atualizacao)
	Using SqlCa;
		  
	if sqlca.sqlcode = -1 then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualizar_feed. ~n' + ' Problemas ao inserir registro na tabela "pedido_ecommerce_baixa_feed": ~n' + sqlca.sqlerrtext
		return false
	end if		

End If

return true
end function

public function boolean of_processa_atualizacao_pedido (string ps_rede_filial, long pl_cd_filial, string ps_id_afiliado);String ls_json
String ls_retorno
String ls_Chave_Nula
String ls_MSG_Nula
String ls_Log
String ls_Situacao
String ls_nr_pedido

String ls_state
String ls_lastchange

String ls_filtro_data_inicio
String ls_filtro_data_fim

Long ll_Achou
long ll_linhas
Long ll_for
Long ll_cd_filial
Long ll_Seq_Log
Long ll_existe
Long ll_sequencial

boolean lb_sucesso=false
datetime ldt_inicio, ldt_termino

DateTime ldh_Data_Nula
DateTime ldh_Atualizacao
DateTime ldh_log_inicio
DateTime ldh_atualizacao_feed
Datetime ldh_atual_vtex

uo_ge501_comum luo_comum_vtex

SetNull(ls_Chave_Nula)
SetNull(ls_MSG_Nula)
SetNull(ldh_Data_Nula)

try 
	ldh_log_inicio = gf_getserverdate()
	ls_situacao = 'P'
	ll_cd_filial = pl_cd_filial
	
	if isnull(ps_id_afiliado) then
		is_id_afiliado = 'GTM'
	Else
		is_id_afiliado = ps_id_afiliado
	ENd if
	
	Open(w_Ge501_Aguarde)
	
	w_Ge501_Aguarde.Title = "Vtex - Pedido/Feed GoTotem (Site -> ERP)"

	luo_comum_vtex = create uo_ge501_comum
	ids_pedidos = create dc_uo_ds_base
	
	//Carrega os parametros e busca o c$$HEX1$$f300$$ENDHEX$$digo da filial vinculado a rede.
	
	If Not luo_comum_vtex.of_parametros_ecommerce_filial( pl_cd_filial, ps_rede_filial, is_id_ecommerce, ref ls_log ) Then return false
	
	//Gravar apenas na primeira chamada (nesse caso pb_encontrou_registros = false)
	luo_comum_vtex.of_grava_log_historico(ref is_id_registro_log, pl_cd_filial, il_cd_tipo, ldh_log_inicio, ldh_Data_Nula, 'C', 0, ref ls_log )	
	
	if not ids_pedidos.of_changedataobject( 'ds_ge501_pedido_feed' , false) Then
		ls_Log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_pedido ~n' + 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ds_ge501_pedido_feed'
		return false
	end if
	
//	If gvo_Aplicacao.ivs_DataSource <> 'central' then
//		ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_pedido, a atualiza$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o pode ser a partir do HOMOLOGA.'
//		return false
//	End If

	ldh_atual_vtex = ldh_log_inicio

//	//Transforma pro horario do servidor da VTEX (GMT +3)
//	Select dateadd( HOUR, +3, :ldh_atual_vtex )
//	Into :ldh_atual_vtex
//	From parametro;

	if isnull( luo_comum_vtex.idh_atualizacao_feed ) or Date( luo_comum_vtex.idh_atualizacao_feed ) = Date( '01/01/1900' ) Then
		
		//Pegar os pedidos de D-1
		ls_filtro_data_inicio = String( relativedate( date(ldh_atual_vtex), -1 ), 'yyyy-mm-dd' ) + 'T' + String( ldh_atual_vtex, 'hh:mm:ss' ) + '.000Z'
	else
		ls_filtro_data_inicio = String( date(luo_comum_vtex.idh_atualizacao_feed ), 'yyyy-mm-dd' ) + 'T' + String( luo_comum_vtex.idh_atualizacao_feed , 'hh:mm:ss' ) + '.000Z'
	end if
	
	ls_filtro_data_fim = String( date( ldh_atual_vtex ), 'yyyy-mm-dd' ) + 'T' + '23:59:59.000Z'
	
	//?f_affiliateId=GTM&f_creationDate=creationDate:[2021-06-01T02:00:00.000Z TO 2021-07-01T01:59:59.999Z]

	//Busca a Lista de pedidos no ecommerce.
	if not luo_comum_vtex.of_get( is_id_interface + '?f_affiliateId=' + is_id_afiliado + '&f_creationDate=creationDate:[' + ls_filtro_data_inicio + ' TO ' + ls_filtro_data_fim + ']'  , ref ls_retorno, ref ls_Log ) Then return false

	//L$$HEX1$$ea00$$ENDHEX$$ a lista de pedidos e salva as informa$$HEX2$$e700f500$$ENDHEX$$es necess$$HEX1$$e100$$ENDHEX$$rias na ids_pedidos.
	if Not this.of_carrega_pedidos( ls_retorno ) Then Return false

	ll_linhas = ids_pedidos.rowcount( )

	If ll_Linhas > 0 Then
		
		luo_comum_vtex.il_qt_item_enviado_site = ll_linhas
         // Grava in$$HEX1$$ed00$$ENDHEX$$cio do processo
		If Not luo_comum_vtex.of_grava_log(ll_cd_filial, il_cd_tipo, ls_Chave_Nula, 'C', ls_MSG_Nula, gf_getserverdate(), gf_getserverdate(), ref ls_Log, ref ll_Seq_Log ) Then Return False
		
	End If
	
	w_Ge501_Aguarde.uo_progress.of_setmax(ll_Linhas)
	
	for ll_for = 1 to ll_linhas
		
		ls_log = ''
		
		luo_comum_vtex.of_limpa_variaveis( )
		
		ls_nr_pedido = ids_pedidos.object.orderid[ll_for]
		ls_state = ids_pedidos.object.state[ll_for]
		ls_lastchange = ids_pedidos.object.lastchange[ll_for]
		
		ldh_Atualizacao =  Datetime( date(ls_lastchange), time( mid( ls_lastchange, 12, 8) ) )
	
		//TRansaforma pro hor$$HEX1$$e100$$ENDHEX$$rio de Brasilia ( GMT -3 )
		Select dateadd( HOUR, -3, :ldh_Atualizacao )
		Into :ldh_Atualizacao
		From parametro;
		
		If Not IsNull(is_pedido_debug)  Then
			If ls_nr_pedido <>  is_pedido_debug Then
				w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
				Continue
			End If
		End If
	
		w_Ge501_Aguarde.Title = "Vtex - Pedido/Feed GoTotem (Site -> ERP) - "  + String(ll_for)  + " de " + STring(ll_Linhas)
		w_Ge501_Aguarde.st_msg.Text = "Pedido: " + ls_nr_pedido + ' ['+ps_rede_filial + ']'
		
		ll_existe = 0
		
		//Se o pedido ja foi baixado, nao baixar novamente:
		select count(*)
		into :ll_existe
		from pedido_ecommerce_baixa
		where id_ecommerce = :is_id_ecommerce
		and id_rede_filial = :ps_rede_filial
		and id_tipo_pedido = :is_id_afiliado
		and nr_pedido_ecommerce = :ls_nr_pedido;
		
		if sqlca.sqlcode = -1 then
			ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_pedido. ~n' + ' Problemas ao consultar a tabela "pedido_ecommerce_baixa": ~n' + sqlca.sqlerrtext
			If Not gf_ge501_rollback(SQLCA) Then Return False
			luo_comum_vtex.of_grava_log_item( pl_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
			ls_Situacao = 'E'
			w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
			Continue
		end if	
		
		if isnull(ll_existe) Then ll_existe = 0
		
		if ll_existe > 0 Then
			w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
			Continue
		End if
		
		// Pagto aprovado ou pedido cancelado
		Choose case ls_state 
				
			Case 'payment-approved', 'cancel', 'canceled', 'ready-for-handling'
		
				this.of_atualizar_baixa( ps_rede_filial, ls_nr_pedido, ls_state, ref ls_log)
				
				if ls_log <> '' and not isnull(ls_log) Then
					If Not gf_ge501_rollback(SQLCA) Then Return False
					luo_comum_vtex.of_grava_log_item( pl_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
					ls_Situacao = 'E'
					w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
					Continue
				end if
		
		End Choose
		
		this.of_atualizar_feed( ps_rede_filial, ls_nr_pedido, ls_state, ls_lastchange, ldh_atualizacao, ref ls_log)
		
		if ls_log <> '' and not isnull(ls_log) Then
				If Not gf_ge501_rollback(SQLCA) Then Return False
				luo_comum_vtex.of_grava_log_item( pl_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
				ls_Situacao = 'E'
				w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
				Continue
			end if
		
		If Not gf_ge501_commit(SQLCA) Then Return False
				
		if Not luo_comum_vtex.of_grava_log_item(ll_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log ) Then Return false
		
		w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)	
	next
		
		//S$$HEX1$$f300$$ENDHEX$$ atualiza a data se n$$HEX1$$e300$$ENDHEX$$o houveram erros:
		if ls_Situacao <> 'E' Then
		
			Update ecommerce_rede_filial 
				set dh_atualizacao_feed = :ldh_atual_vtex 
				where id_ecommerce = :is_id_ecommerce
					and id_rede_filial = :ps_rede_filial
					and cd_filial = :pl_cd_filial
			Using SQLCA;
			
			if sqlca.sqlcode = -1 then
					ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_pedido. ~n' + ' Problemas ao atualizar registro na tabela "ecommerce_rede_filial": ~n' + sqlca.sqlerrtext
					return false
			end if			
			
			If Not gf_ge501_commit(SQLCA) Then Return False
		End if	
			
	lb_sucesso = True

Finally
	
	if Not lb_sucesso then 
		ls_situacao = 'E'
		
		gf_ge501_RollBack(SQLCA)

		// J$$HEX1$$e100$$ENDHEX$$ iniciou o envio dos itens
		If ll_for > 0 Then
			// Atualiza log com erro
			If Not luo_comum_vtex.of_atualiza_ecommerce_log(ll_cd_filial, ll_Seq_Log, 'E', ls_Log, gf_getserverdate(), ref ls_Log) Then Return False
			if Not luo_comum_vtex.of_grava_log_item(ll_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log) Then Return false
		Else
			// Se n$$HEX1$$e300$$ENDHEX$$o tiver log insere um novo com erro
			If IsNull(ll_Seq_Log) or ll_Seq_Log = 0 Then
				// Grava in$$HEX1$$ed00$$ENDHEX$$cio do processo - chave e mensagem est$$HEX1$$e300$$ENDHEX$$o indo como nulo
				If Not luo_comum_vtex.of_grava_log(ll_cd_filial, il_cd_tipo, ls_Chave_Nula, 'E', ls_Log, ldh_Data_Nula, gf_getserverdate(), ref ls_Log, ref ll_Seq_Log ) Then Return False
			Else
				// Atualiza log com erro
				If Not luo_comum_vtex.of_atualiza_ecommerce_log(ll_cd_filial, ll_Seq_Log, 'E', ls_Log, gf_getserverdate(), ref ls_Log) Then Return False
			End If		
		End If
	Else
		If ll_Linhas > 0 Then
			// Marca o log como processado
			If Not luo_comum_vtex.of_atualiza_ecommerce_log(ll_cd_filial, ll_Seq_Log, ls_Situacao, ls_MSG_Nula, gf_getserverdate(), ref ls_Log) Then Return False
		End If
	End If
	
	luo_comum_vtex.of_grava_log_historico(ref is_id_registro_log, ll_cd_filial, il_cd_tipo, ldh_log_inicio, gf_getserverdate(), ls_situacao, ll_Seq_Log, ref ls_log )	
	
	destroy(ids_pedidos)
	destroy(luo_comum_vtex)
	
	Close(w_Ge501_Aguarde)
	
End try

return true
end function

on uo_ge501_pedido_feed_gototem.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge501_pedido_feed_gototem.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;is_objeto = 'Objeto: ' + this.classname() + '~n'

SetNull(is_pedido_debug)
end event

