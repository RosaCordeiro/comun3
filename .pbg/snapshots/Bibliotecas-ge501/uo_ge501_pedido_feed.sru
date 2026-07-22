HA$PBExportHeader$uo_ge501_pedido_feed.sru
forward
global type uo_ge501_pedido_feed from nonvisualobject
end type
end forward

global type uo_ge501_pedido_feed from nonvisualobject
end type
global uo_ge501_pedido_feed uo_ge501_pedido_feed

type variables
string is_objeto
string is_id_ecommerce = '2' //VTEX
string is_id_interface = 'api/orders/feed'
long il_cd_tipo = 7

String is_ODBC_Desenv
String is_pedido_debug
String is_id_registro_log

Long il_Filial_Desenv

boolean ib_desenv=false

dc_uo_ds_base ids_pedidos
end variables

forward prototypes
public function boolean of_busca_valor (string ps_json, string ps_campo, ref long pl_inicio, ref string ps_valor)
public function boolean of_monta_json (string ps_handle, ref string ps_json, ref string ps_log)
public function boolean of_carrega_pedidos (string ps_json)
public function boolean of_processa_atualizacao_pedido (string ps_rede_filial, ref boolean pb_encontrou_registros)
end prototypes

public function boolean of_busca_valor (string ps_json, string ps_campo, ref long pl_inicio, ref string ps_valor);Long ll_Pos_De
Long ll_Pos_Ate
Long ll_inicio
Long ll_row
Long ll_for

String ls_Valor
String ls_campo
String ls_resultado

ls_campo = ps_campo

ll_inicio = pl_inicio + 1

ls_campo = '"' + ls_campo + '"'

// Localiza a letra inicial do campo
ll_Pos_De = PosA( ps_Json , ls_campo, ll_inicio )
ll_inicio = ll_Pos_De

pl_inicio = ll_inicio

if ll_inicio = 0 Then
	return true
end if

// Localiza o separador de campo/valor (:) e retorna a posi$$HEX2$$e700e300$$ENDHEX$$o do proximo caracter
ll_Pos_De = PosA( ps_Json, ':', ll_Pos_De + 1 ) + 1

// Quebra a string Json retirando o nome do campo de seu inicio
ls_resultado = Trim( Mid( ps_Json, ll_Pos_De ) )

// Verifica se o valor do campo inicia com (") aspa dupla. Caso TRUE, o campo termina na ocorrencia de (",) aspa dupla seguida de virgula, caso FALSE, o campo termina na ocorrencia da (,) virgula
If LeftA( ls_resultado, 1 ) = '"' Then
	
	// Remove a aspa dupla inicial para (") para n$$HEX1$$e300$$ENDHEX$$o causar problema na procura de teminador de valor (",) quando o valor come$$HEX1$$e700$$ENDHEX$$a com (,)
	ls_resultado		= Mid( ls_resultado, 2 )
	ll_Pos_Ate	= PosA( ls_resultado, '",' )
Else
	ll_Pos_Ate = PosA( ls_resultado, ',' )
End If

// Quando for o $$HEX1$$fa00$$ENDHEX$$ltimo valor, considera a posicao de termino o final da string Json
If ll_Pos_Ate < 1 Then
	ll_Pos_Ate = LenA( ls_resultado ) - 1
Else
	ll_Pos_Ate = ll_Pos_Ate - 1
End If

// Captura o valor entre o primeiro caracter e o da posicao do delimitador
ls_Valor	= MidA( ls_resultado, 1, ll_Pos_Ate )

// Remove ENTER
ls_Valor	= gf_Replace( ls_Valor,char(13) + char(10),'',0 ) // ENTER

// Remove (") aspa dupla
ls_Valor = gf_Replace( ls_Valor,'"','',0 )

// Remove a chave de fechamento
ls_Valor = gf_Replace( ls_Valor,'}','',0 ) //Quando $$HEX1$$e900$$ENDHEX$$ o $$HEX1$$fa00$$ENDHEX$$ltimo campo do grupo n$$HEX1$$e300$$ENDHEX$$o tem ',' depois do campo, por isso vai at$$HEX1$$e900$$ENDHEX$$ a tag de fechamento '},'

// Remove o colchete de fechamento
ls_Valor	= gf_Replace( ls_Valor,']','',0 ) //Quando $$HEX1$$e900$$ENDHEX$$ o $$HEX1$$fa00$$ENDHEX$$ltimo campo do grupo n$$HEX1$$e300$$ENDHEX$$o tem ',' depois do campo, por isso vai at$$HEX1$$e900$$ENDHEX$$ a tag de fechamento '],'

// Remove espacos do inicio e do final
ls_Valor = Trim( ls_Valor )
	
ps_valor = ls_valor

return true
end function

public function boolean of_monta_json (string ps_handle, ref string ps_json, ref string ps_log);ps_json = '{ ' + &
	'"handles":[ "' + ps_handle + '" ]}'


if isnull(ps_json) or ps_json = '' Then
	ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel montar o arquivo JSON para o envio dos dados.'
	return false
end if

return true
end function

public function boolean of_carrega_pedidos (string ps_json);string ls_state
string ls_handle
string ls_orderId
string	ls_eventid
string	ls_domain
string	ls_laststate
string	ls_lastchange
string	ls_currentchange
string	ls_availabledate

long ll_row
long ll_inicio

Do 
	
	if not of_busca_valor(ps_json,'eventId', ref ll_inicio, ref ls_eventid) Then return false
	if ll_inicio = 0 Then exit

	if not of_busca_valor(ps_json,'handle', ref ll_inicio, ref ls_handle) Then return false
	if ll_inicio = 0 Then exit
	
	if not of_busca_valor(ps_json,'domain', ref ll_inicio, ref ls_domain) Then return false
	if ll_inicio = 0 Then exit
	
	if not of_busca_valor(ps_json,'state', ref ll_inicio, ref ls_state) Then return false
	if ll_inicio = 0 Then exit

	if not of_busca_valor(ps_json,'lastState', ref ll_inicio, ref ls_laststate) Then return false
	
	if not of_busca_valor(ps_json,'orderId', ref ll_inicio, ref ls_orderid) Then return false
	if ll_inicio = 0 Then exit
	
	if not of_busca_valor(ps_json,'lastChange', ref ll_inicio, ref ls_lastchange) Then return false
	if ll_inicio = 0 Then exit
	
	if not of_busca_valor(ps_json,'currentChange', ref ll_inicio, ref ls_currentchange) Then return false
	if ll_inicio = 0 Then exit
	
	if not of_busca_valor(ps_json,'availableDate', ref ll_inicio, ref ls_availabledate) Then return false
	if ll_inicio = 0 Then exit
	
	ll_row = ids_pedidos.insertrow(0)
	
	ids_pedidos.object.state				[ll_row] 	= ls_state
	ids_pedidos.object.orderid			[ll_row] 	= ls_orderId
	ids_pedidos.object.eventid			[ll_row] 	= ls_eventid
	ids_pedidos.object.domain			[ll_row] 	= ls_domain
	ids_pedidos.object.laststate			[ll_row] 	= ls_laststate
	ids_pedidos.object.lastchange		[ll_row] 	= ls_lastchange
	ids_pedidos.object.currentchange	[ll_row] 	= ls_currentchange
	ids_pedidos.object.availabledate	[ll_row] 	= ls_availabledate
		
	ids_pedidos.setitem(ll_row, 'handle', ls_handle)

Loop While ll_inicio > 0

return true
end function

public function boolean of_processa_atualizacao_pedido (string ps_rede_filial, ref boolean pb_encontrou_registros);String ls_json
String ls_retorno
String ls_Chave_Nula
String ls_MSG_Nula
String ls_Log
String ls_Situacao
String ls_nr_pedido
String ls_handle
String ls_tipo_pedido
String ls_state
String ls_eventid
String ls_domain
String ls_laststate
String ls_lastchange
String ls_currentchange
String ls_availabledate

Long ll_Achou
long ll_linhas
Long ll_for
Long ll_cd_filial
Long ll_Seq_Log
Long ll_existe

boolean lb_sucesso=false
datetime ldt_inicio, ldt_termino

DateTime ldh_Data_Nula
DateTime ldh_Atualizacao
DateTime ldh_log_inicio

uo_ge501_comum luo_comum_vtex

SetNull(ls_Chave_Nula)
SetNull(ls_MSG_Nula)
SetNull(ldh_Data_Nula)

try 
	ldh_log_inicio = gf_getserverdate()
	ls_situacao = 'P'
	
	Open(w_Ge501_Aguarde)
	
	w_Ge501_Aguarde.Title = "Vtex - Altera$$HEX2$$e700e300$$ENDHEX$$o Pedido/Feed (Site -> ERP)"

	luo_comum_vtex = create uo_ge501_comum
	ids_pedidos = create dc_uo_ds_base
	
	//Desenvolvimento
	is_ODBC_Desenv = luo_comum_vtex.of_desenvolvimento_odbc_baixa_pedido()
	il_Filial_Desenv = luo_comum_vtex.of_desenvolvimento_filial_baixa_pedido()
	
	If Not IsNull(il_Filial_Desenv) and il_filial_desenv > 0 Then
		ib_Desenv = True // nao atualiza a VTEX
	End If
	
	//Carrega os parametros e busca o c$$HEX1$$f300$$ENDHEX$$digo da filial vinculado a rede.
	if Not luo_comum_vtex.of_parametros_ecommerce(is_id_ecommerce, ps_rede_filial, ref ll_cd_filial, ref ls_Log ) Then return false
	
	//Gravar apenas na primeira chamada (nesse caso pb_encontrou_registros = false)
	if pb_encontrou_registros = false then
		setnull(is_id_registro_log)
		luo_comum_vtex.of_grava_log_historico(ref is_id_registro_log, ll_cd_filial, il_cd_tipo, ldh_log_inicio, ldh_Data_Nula, 'C', 0, ref ls_log )	
	end if
	
	if not ids_pedidos.of_changedataobject( 'ds_ge501_pedido_feed' , false) Then
		ls_Log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_pedido ~n' + 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ds_ge501_pedido_feed'
		return false
	end if
	
	If gvo_Aplicacao.ivs_DataSource <> 'central' then
		ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_pedido, a atualiza$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o pode ser a partir do HOMOLOGA.'
		return false
	End If

	//Busca a Lista de pedidos no ecommerce.
	if not luo_comum_vtex.of_get( is_id_interface , ref ls_retorno, ref ls_Log ) Then return false
	
	If (Not IsNull(is_ODBC_Desenv) or Not IsNull(il_Filial_Desenv)) and gvo_Aplicacao.ivs_DataSource = 'central' Then
		ls_Log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_pedido. ~n' + ' No INI esta configurado FILIAL ou ODBC de desenvolvimento, no entanto esta gravando no BD CENTRAL.'
		return false
	End If
	
	If (IsNull(is_ODBC_Desenv) and IsNull(il_Filial_Desenv)) and gvo_Aplicacao.ivs_DataSource <> 'central' Then
		ls_Log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_pedido. ~n' + ' No INI n$$HEX1$$e300$$ENDHEX$$o esta configurado FILIAL e ODBC de desenvolvimento, no entanto esta gravando no BD diferente do CENTRAL.'
		return false
	End If

	//L$$HEX1$$ea00$$ENDHEX$$ a lista de pedidos e salva as informa$$HEX2$$e700f500$$ENDHEX$$es necess$$HEX1$$e100$$ENDHEX$$rias na ids_pedidos.
	if Not this.of_carrega_pedidos( ls_retorno ) Then Return false

	ll_linhas = ids_pedidos.rowcount( )

	If ll_Linhas > 0 Then
		
		pb_encontrou_registros = True
		
		luo_comum_vtex.il_qt_item_enviado_site = ll_linhas
         // Grava in$$HEX1$$ed00$$ENDHEX$$cio do processo
		If Not luo_comum_vtex.of_grava_log(ll_cd_filial, il_cd_tipo, ls_Chave_Nula, 'C', ls_MSG_Nula, gf_getserverdate(), gf_getserverdate(), ref ls_Log, ref ll_Seq_Log ) Then Return False
		
	else
		
		pb_encontrou_registros = false
		
	End If
	
	w_Ge501_Aguarde.uo_progress.of_setmax(ll_Linhas)
	
	for ll_for = 1 to ll_linhas
		
		ls_log = ''
		
		luo_comum_vtex.of_limpa_variaveis( )
		
		ls_nr_pedido 		= ids_pedidos.object.orderid			[ll_for]
		ls_state 				= ids_pedidos.object.state				[ll_for]		
		ls_eventid 			= ids_pedidos.object.eventid			[ll_for]		
		ls_domain 			= ids_pedidos.object.domain			[ll_for]		
		ls_laststate			= ids_pedidos.object.laststate			[ll_for]
		ls_lastchange 		= ids_pedidos.object.lastchange		[ll_for]	
		ls_currentchange 	= ids_pedidos.object.currentchange	[ll_for]
		ls_availabledate 	= ids_pedidos.object.availabledate	[ll_for]
		
		ldh_Atualizacao =  Datetime( date(ls_lastchange), time( mid( ls_lastchange, 12, 8) ) )
	
		//TRansaforma pro hor$$HEX1$$e100$$ENDHEX$$rio de Brasilia ( GMT -3 )
		Select dateadd( HOUR, -3, :ldh_Atualizacao )
		Into :ldh_Atualizacao
		From parametro;
		
		if pos( ls_nr_pedido, 'MGZ-LU-',1) > 0 Then
			//Pedido gerado no Magazine Luiza
			ls_tipo_pedido = 'MGZ' 
			
			ls_nr_pedido = gf_replace( ls_nr_pedido, 'MGZ-LU-', '',0 )
			
		ELse
			ls_tipo_pedido = 'SLR'
		End if
		
		If Not IsNull(is_pedido_debug)  Then
			If ls_nr_pedido <>  is_pedido_debug Then
				w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
				Continue
			End If
		End If
				
		ls_handle = ids_pedidos.getitemstring(ll_for, 'handle')
		
		w_Ge501_Aguarde.Title = "Vtex - Altera$$HEX2$$e700e300$$ENDHEX$$o Pedido/Feed (Site -> ERP) - "  + String(ll_for)  + " de " + STring(ll_Linhas)
		w_Ge501_Aguarde.st_msg.Text = "Pedido: " + ls_nr_pedido + ' ['+ps_rede_filial + ']'
		
		//ready-for-handling -> pronto para manuseio
		//start-handling -> preparando entrega (quem muda para este status $$HEX1$$e900$$ENDHEX$$ interface que grava na loja)
		//handling -> separando 
		
		// Pagto aprovado ou pedido cancelado
		If ls_state = 'payment-approved' or ls_state = 'ready-for-handling' or ls_state = 'cancel' or ls_state = 'payment-pending' or  ls_state = "waiting-seller-handling" Then
		
			Select count(*)
			into :ll_existe
			from pedido_ecommerce_baixa
			where id_ecommerce = :is_id_ecommerce
				and id_rede_filial = :ps_rede_filial
				and nr_pedido_ecommerce = :ls_nr_pedido
				and id_tipo_pedido = :ls_tipo_pedido
			Using SqlCa;
			
			If SqlCa.Sqlcode = -1 Then
				ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_pedido. ~n' + ' Problemas ao selecionar os registros da tabela "pedido_ecommerce_baixa": ~n' + sqlca.sqlerrtext
				return false
			End If
				
			if isnull(ll_existe) or ll_existe = 0 then
				
				Insert into pedido_ecommerce_baixa(id_ecommerce, id_rede_filial, nr_pedido_ecommerce, dh_baixa, de_status_plataforma, id_tipo_pedido)
					values(:is_id_ecommerce, :ps_rede_filial, :ls_nr_pedido, getdate(), :ls_state, :ls_tipo_pedido);
				
				if sqlca.sqlcode = -1 then
					ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_pedido. ~n' + ' Problemas ao inserir registro na tabela "pedido_ecommerce_baixa": ~n' + sqlca.sqlerrtext
					return false
				end if
				
			elseif ll_existe > 0 Then
	
				Update pedido_ecommerce_baixa
				set dh_importacao = null, de_status_plataforma = :ls_state
				where id_ecommerce = :is_id_ecommerce
					and id_rede_filial = :ps_rede_filial
					and nr_pedido_ecommerce = :ls_nr_pedido
					and id_tipo_pedido = :ls_tipo_pedido;
			
				if sqlca.sqlcode = -1 then
					ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_pedido. ~n' + ' Problemas ao atualizar registro na tabela "pedido_ecommerce_baixa": ~n' + sqlca.sqlerrtext
					return false
				end if
			
			end if
		
		End If
		
//		Select count(*)
//		Into :ll_Achou
//		From pedido_ecommerce_baixa_feed
//		Where id_ecommerce			= :is_id_ecommerce
//			and id_rede_filial 				= :ps_rede_filial
//			and nr_pedido_ecommerce 	= :ls_nr_pedido
//			and eventid 						= :ls_eventid
//		Using SqlCa;
//		
//		If SqlCa.SqlCode = -1 then
//			ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_pedido. ~n' + ' Problemas ao localizar registro na tabela "pedido_ecommerce_baixa_feed": ~n' + sqlca.sqlerrtext
//			return false
//		End If
//		
//		If ll_Achou =0  Then
			
//			INSERT INTO pedido_ecommerce_baixa_feed  ( id_ecommerce,   
//																		  id_rede_filial,   
//																		  nr_pedido_ecommerce,   
//																		  eventid,   
//																		  domain,   
//																		  state,   
//																		  laststate,   
//																		  lastchange,   
//																		  currentchange,   
//																		  availabledate,
//																		  dh_atualizacao_site)  
//			
//			VALUES ( :is_id_ecommerce,   
//						:ps_rede_filial, 
//						:ls_nr_pedido, 
//						:ls_eventid,   
//						:ls_domain,   
//						:ls_state,   
//						:ls_laststate,   
//						:ls_lastchange,   
//						:ls_currentchange,   
//						:ls_availabledate,
//						:ldh_Atualizacao)
//			Using SqlCa;
//				  
//			if sqlca.sqlcode = -1 then
//				ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_pedido. ~n' + ' Problemas ao inserir registro na tabela "pedido_ecommerce_baixa_feed": ~n' + sqlca.sqlerrtext
//				return false
//			end if		
		
//		End If
	
		//sqlca.of_Commit( )
		If Not gf_ge501_commit(SQLCA) Then Return False
		
		if Not ib_Desenv Then
		
	//		//Manda informa$$HEX2$$e700e300$$ENDHEX$$o pro ecommerce dizendo que o pedido j$$HEX1$$e100$$ENDHEX$$ foi recebido.
			If Not this.of_monta_json( ls_handle, ref ls_json, ref ls_log ) Then return false
			
			luo_comum_vtex.is_json 						= ls_json
			luo_comum_vtex.is_nr_pedido_ecommerce 	= ls_nr_pedido
			
			luo_comum_vtex.of_post(ls_json , is_id_interface, ls_retorno, ref ls_log )
			
			if ls_log <> '' and not isnull(ls_log) Then
				luo_comum_vtex.of_grava_log_item( ll_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
				ls_Situacao = 'E'
				w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
				Continue
			end if
			
		End if
		
		if Not luo_comum_vtex.of_grava_log_item(ll_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log ) Then Return false
		
		w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)	
	next
			
	lb_sucesso = True

Finally
	
	if Not lb_sucesso then 
		ls_situacao = 'E'
		
		//sqlca.of_rollback( )
		gf_ge501_RollBack(SQLCA)
		
		pb_encontrou_registros = false
		
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
	
	//Grava apenas na ultima chamada (pb_encontrou_registros = false)
	if pb_encontrou_registros = false then
		luo_comum_vtex.of_grava_log_historico(ref is_id_registro_log, ll_cd_filial, il_cd_tipo, ldh_log_inicio, gf_getserverdate(), ls_situacao, ll_Seq_Log, ref ls_log )	
	end if
	
	destroy(ids_pedidos)
	destroy(luo_comum_vtex)
	
	Close(w_Ge501_Aguarde)
	
End try

return true
end function

on uo_ge501_pedido_feed.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge501_pedido_feed.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;is_objeto = 'Objeto: ' + this.classname() + '~n'

SetNull(is_pedido_debug)
end event

