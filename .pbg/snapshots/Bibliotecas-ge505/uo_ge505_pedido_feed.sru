HA$PBExportHeader$uo_ge505_pedido_feed.sru
forward
global type uo_ge505_pedido_feed from nonvisualobject
end type
end forward

global type uo_ge505_pedido_feed from nonvisualobject
end type
global uo_ge505_pedido_feed uo_ge505_pedido_feed

type variables
string is_objeto
string is_id_ecommerce = '3' //IFOOD
string is_id_interface = 'api/v1/pedido/eventos'
string is_id_interface_verificado = 'api/v1/pedido/eventos/verificado'
long il_cd_tipo = 7
long il_cd_mensagem_email = 240

String is_ODBC_Desenv

Long il_Filial_Desenv

dc_uo_ds_base ids_pedidos
end variables

forward prototypes
public function boolean of_busca_valor (string ps_json, string ps_campo, ref long pl_inicio, ref string ps_valor)
public function boolean of_carrega_pedidos (string ps_json)
public function boolean of_monta_json (string ps_id_evento, ref string ps_json, ref string ps_log)
public function boolean of_busca_dados_filial (string ps_id_loja, ref string ps_rede_filial, ref long pl_cd_filial, ref string ps_log)
public function boolean of_processa_atualizacao_pedido ()
public function boolean of_verifica_executando (long pl_qt_total, ref long pl_prox_executar)
public function boolean of_verifica_pedido_aberto (string ps_rede_filial)
public function boolean of_processa_atualizacao_pedido (string ps_rede_filial, long pl_cd_filial)
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

public function boolean of_carrega_pedidos (string ps_json);string ls_id
string ls_cod_pedido
string ls_status
string	ls_idloja

long ll_row
long ll_inicio

Do 
	
	if not of_busca_valor(ps_json,'id', ref ll_inicio, ref ls_id) Then return false
	if ll_inicio = 0 Then exit

	if not of_busca_valor(ps_json,'codigoPedido', ref ll_inicio, ref ls_cod_pedido) Then return false
	if ll_inicio = 0 Then exit
	
	if not of_busca_valor(ps_json,'status', ref ll_inicio, ref ls_status) Then return false
	if ll_inicio = 0 Then exit
	
	if not of_busca_valor(ps_json,'idLoja', ref ll_inicio, ref ls_idloja) Then return false
	if ll_inicio = 0 Then exit
	
	ll_row = ids_pedidos.insertrow(0)
	
	ids_pedidos.object.id[ll_row] = ls_id
	ids_pedidos.object.codigopedido[ll_row] = ls_cod_pedido
	ids_pedidos.object.status[ll_row] = ls_status
	ids_pedidos.object.idloja[ll_row] = ls_idloja
	
	If ls_cod_pedido = '11658-E16754954' Then
		ls_cod_pedido = ls_cod_pedido
	End If
		
	
Loop While ll_inicio > 0

return true
end function

public function boolean of_monta_json (string ps_id_evento, ref string ps_json, ref string ps_log);ps_json = '[{' + &
	'"id": "' + ps_id_evento + '"}]'


if isnull(ps_json) or ps_json = '' Then
	ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel montar o arquivo JSON para o envio dos dados.'
	return false
end if

return true
end function

public function boolean of_busca_dados_filial (string ps_id_loja, ref string ps_rede_filial, ref long pl_cd_filial, ref string ps_log);Select cd_filial, id_rede_filial 
into :pl_cd_filial, :ps_rede_filial
from ecommerce_rede_filial
where id_ecommerce = :is_id_ecommerce
and cd_warehouseid = :ps_id_loja;

if sqlca.sqlcode = -1 then 
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_busca_dados_filial ; Problemas ao consultar a tabela "ecommerce_rede_filial": ' + sqlca.sqlerrtext
	return false
end if

if pl_cd_filial = 0 or isnull(pl_cd_filial) Then
	ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar a seguinte loja do Ifood no banco de dados: ' + ps_id_loja
end if

return true
end function

public function boolean of_processa_atualizacao_pedido ();
string ls_Log, ls_rede, ls_id_filial
string ls_Nome_Janela
string ls_parametro
String ls_Rede_Anterior

long ll_linhas, ll_cd_filial, ll_for

dc_uo_ds_base lds_filial

lds_filial = create dc_uo_ds_base
		
if not lds_filial.of_changedataobject( 'ds_ge505_pedido_feed_rede' , false) Then
	Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_pedido. ~n' + ' N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ds_ge505_pedido_feed_rede')
	return false
end if

ll_linhas = lds_filial.retrieve( is_id_ecommerce )
if ll_linhas < 0 Then
	Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_pedido ~n' + 'Problemas ao consultar o banco de dados: ~n' + sqlca.is_lasterrortext )
	return false
end if

ls_Rede_Anterior = ''

for ll_for = 1 to ll_linhas
	
	ls_rede 		= lds_filial.object.id_rede_filial	[ll_for]
	ll_cd_filial 	= lds_filial.object.cd_filial		[ll_for]

	If ls_Rede_Anterior <> ls_Rede Then
		ls_Rede_Anterior = ls_Rede
		If Not This.of_verifica_pedido_aberto( ls_rede ) Then
			Return False
		End If		
	End If
	
//	Do 
//		Sleep(0.5)
//		this.of_verifica_executando(ll_total_executando, ref ll_prox_execucao )
//	Loop While ll_prox_execucao = 0
	
	ls_Nome_Janela = "EX - INTERFACE IFOOD - FEED [" + ls_rede + "]"

	ls_parametro =  String(ll_cd_filial) + '/' + ls_rede + '/' + ls_nome_janela

//	this.of_processa_atualizacao_pedido( ls_rede, ll_cd_filial)

	Run("C:\Sistemas\EX\Exe\ex.exe /AUTO/IFFD/" + ls_parametro  )
	
next

destroy(lds_filial)

return true
end function

public function boolean of_verifica_executando (long pl_qt_total, ref long pl_prox_executar);String ls_Janela_Ativa 
long ll_controles_executando, ll_for

pl_prox_executar=0

for ll_for = 1 to pl_qt_total

	ls_janela_ativa = "EX - INTERFACE IFOOD - FEED [" + String(ll_for) + "]"
	
	If Not gvo_aplicacao.of_appisrunning(ls_Janela_Ativa) Then
		pl_prox_executar = ll_for
		Exit
	End If
	
Next

return true
end function

public function boolean of_verifica_pedido_aberto (string ps_rede_filial);//Fun$$HEX2$$e700e300$$ENDHEX$$o utilizada para atualizar a situacao caso o pedido seja cancelado e n$$HEX1$$e300$$ENDHEX$$o tenha atualizado o status no central e na loja
//dentro de um per$$HEX1$$ed00$$ENDHEX$$odo de 3 dias
Long ll_Qtde_Aberto

Select Count( nr_pedido_ecommerce ) 
	into :ll_Qtde_Aberto
from pedido_ecommerce p
	where  p.id_ecommerce 	= '3'
		and p.id_situacao 		= 'A'						
		and p.dh_compra < dateadd(dd, -3, getdate() )
		and p.dh_compra > dateadd(dd, -30, getdate() )
		and exists (select * from pedido_ecommerce_baixa b	
						where b.nr_pedido_ecommerce  	= p.nr_pedido_ecommerce
						  and b.id_ecommerce 				= p.id_ecommerce
						  and b.id_rede_filial 					= :ps_rede_filial
						  and b.dh_importacao   				is not null)
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Erro ao verificar pedidos em aberto mais de 3 dias. Fun$$HEX2$$e700e300$$ENDHEX$$o: of_verfica_pedido_aberto().")	
	Return False
End If
		
If ll_Qtde_Aberto > 0 Then		
	update pedido_ecommerce_baixa	
		set dh_importacao = null 
		where id_ecommerce  = '3'
		  and id_rede_filial 	 = :ps_rede_filial
		  and dh_importacao   is not null
		  and exists ( select * from pedido_ecommerce p
								where p.nr_pedido_ecommerce = pedido_ecommerce_baixa.nr_pedido_ecommerce
									and p.id_ecommerce 			  = pedido_ecommerce_baixa.id_ecommerce
									and p.id_situacao = 'A'								
									and p.dh_compra < dateadd(dd, -3, getdate() )
									and p.dh_compra > dateadd(dd, -30, getdate() )
						 )
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_Rollback()
			SqlCa.of_MsgDbError("Erro ao atualizar a tabela pedido_ecommerce_baixa. Fun$$HEX2$$e700e300$$ENDHEX$$o: of_verfica_pedido_aberto().")	
			Return False
		Else
			SqlCa.of_Commit()
		End If
		
End If					 

Return True

end function

public function boolean of_processa_atualizacao_pedido (string ps_rede_filial, long pl_cd_filial);String ls_json
String ls_retorno
String ls_Chave_Nula
String ls_MSG_Nula
String ls_Log
String ls_Situacao
String ls_nr_pedido
String ls_rede_filial
String ls_status
String ls_status_anterior
String ls_id_evento
String ls_id_loja
String ls_id_registro_log

long ll_linhas
Long ll_for
Long ll_cd_filial
Long ll_Seq_Log
Long ll_existe, ll_existe_pedido
Long ll_Achou
long ll_cd_filial_ecommerce

boolean lb_sucesso=false
boolean ib_desenv=false

DateTime ldt_inicio, ldt_termino
DateTime ldh_log_inicio
DateTime ldh_Data_Nula

uo_ge505_comum luo_comum

SetNull(ls_Chave_Nula)
SetNull(ls_MSG_Nula)
SetNull(ldh_Data_Nula)

try 
	ldh_log_inicio = gf_getserverdate()
	ls_situacao = 'P'
	ll_cd_filial_ecommerce = pl_cd_filial
	
	Open(w_Ge501_Aguarde)
	w_Ge501_Aguarde.Title = "IFOOD - Feed (Site -> ERP)"
     	  
	luo_comum = create uo_ge505_comum
	ids_pedidos = create dc_uo_ds_base

	setnull(ls_id_registro_log)
	luo_comum.of_grava_log_historico(ref ls_id_registro_log, 0, il_cd_tipo, ldh_log_inicio, ldh_Data_Nula, 'C', 0, ref ls_log )	
	
	//Desenvolvimento
	is_ODBC_Desenv = luo_comum.of_desenvolvimento_odbc_baixa_pedido()
	il_Filial_Desenv = luo_comum.of_desenvolvimento_filial_baixa_pedido()
	
	If (Not IsNull(is_ODBC_Desenv) or Not IsNull(il_Filial_Desenv)) and gvo_Aplicacao.ivs_DataSource = 'central' Then
		ls_Log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_pedido. ~n' + ' No INI esta configurado FILIAL ou ODBC de desenvolvimento, no entanto esta gravando no BD CENTRAL.'
		return false
	End If
	
	If (IsNull(is_ODBC_Desenv) and IsNull(il_Filial_Desenv)) and gvo_Aplicacao.ivs_DataSource <> 'central' Then
		ls_Log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_pedido. ~n' + ' No INI n$$HEX1$$e300$$ENDHEX$$o esta configurado FILIAL e ODBC de desenvolvimento, no entanto esta gravando no BD diferente do CENTRAL.'
		return false
	End If

	if gvo_Aplicacao.ivs_DataSource <> 'central' then ib_desenv = true
	
	if Not luo_comum.of_parametros_ecommerce( is_id_ecommerce, ps_rede_filial, ref ll_cd_filial_ecommerce, ref ls_log) Then return false
	
	if not ids_pedidos.of_changedataobject( 'ds_ge505_pedido_feed' , false) Then
		ls_Log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_pedido ~n' + 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ds_ge505_pedido_feed'
		return false
	end if

	//Gera o token pra conectar no webservice.		
	luo_comum.of_gera_token( ref ls_log )
	
	If ls_Log <> '' and not isnull(ls_Log) Then		
		ls_Situacao = 'E'
		return false
	end if

	//Busca a Lista de pedidos no ecommerce.
	luo_comum.of_get( is_id_interface, ref ls_retorno, ref ls_Log ) 

	If ls_Log <> '' and not isnull(ls_Log) Then		
		ls_Situacao = 'E'
		return false
	end if

	//L$$HEX1$$ea00$$ENDHEX$$ a lista de pedidos e salva as informa$$HEX2$$e700f500$$ENDHEX$$es necess$$HEX1$$e100$$ENDHEX$$rias na ids_pedidos.
	if Not this.of_carrega_pedidos( ls_retorno ) Then Return false

	ll_linhas = ids_pedidos.rowcount( )

	If ll_Linhas > 0 Then
		
		luo_comum.il_qt_item_enviado_site = ll_linhas
         // Grava in$$HEX1$$ed00$$ENDHEX$$cio do processo
		If Not luo_comum.of_grava_log(ll_cd_filial_ecommerce, il_cd_tipo, ls_Chave_Nula, 'C', ls_MSG_Nula, gf_getserverdate(), gf_getserverdate(), ref ls_Log, ref ll_Seq_Log ) Then Return False
		
	End If
	
	w_Ge501_Aguarde.uo_progress.of_setmax(ll_Linhas)
	
	for ll_for = 1 to ll_linhas
		
		ls_log = ''
		
		luo_comum.of_limpa_variaveis( )
		
		ls_nr_pedido = ids_pedidos.object.codigopedido[ll_for]
		ls_status = ids_pedidos.object.status[ll_for]		
		ls_id_evento = ids_pedidos.object.id[ll_for]	
		ls_id_loja = ids_pedidos.object.idloja[ll_for]
		
		luo_comum.is_nr_pedido_ecommerce = ls_nr_pedido
		
		w_Ge501_Aguarde.Title = "IFOOD - Feed (Site -> ERP) - "  + String(ll_for)  + " de " + STring(ll_Linhas)
		w_Ge501_Aguarde.st_msg.Text = "Pedido: " + ls_nr_pedido
		
		Choose Case ls_status
			Case 'PE0', 'PE1', 'ENT', 'ENP', 'FIN', 'CAN', 'DEV', 'RET', 'REP'
		
				//Buscar rede e cd_filial
				If Not this.of_busca_dados_filial( ls_id_loja, ref ls_rede_filial, ref ll_cd_filial, ref ls_log ) Then return false
				
				if ls_log <> '' and not isnull(ls_log) Then
					luo_comum.of_grava_log_item( ll_cd_filial_ecommerce, ll_Seq_Log, ref ls_Log, ls_Log )
					ls_Situacao = 'E'
					ls_Log = ''
								
					w_aguarde.uo_progress.of_setprogress(ll_for)
					Continue
				end if
				
				luo_comum.il_cd_filial_pedido = ll_cd_filial
				
				Select count(*)
				into :ll_existe
				from pedido_ecommerce_baixa
				where id_ecommerce = :is_id_ecommerce
					and id_rede_filial = :ls_rede_filial
					and nr_pedido_ecommerce = :ls_nr_pedido
				Using SqlCa;
				
				If SqlCa.Sqlcode = -1 Then
					ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_pedido. ~n' + ' Problemas ao selecionar os registros da tabela "pedido_ecommerce_baixa": ~n' + sqlca.sqlerrtext
					return false
				End If
						
				if isnull(ll_existe) or ll_existe = 0 then
					
					Insert into pedido_ecommerce_baixa(id_ecommerce, id_rede_filial, nr_pedido_ecommerce, dh_baixa)
						values(:is_id_ecommerce, :ls_rede_filial, :ls_nr_pedido, getdate());
					
					if sqlca.sqlcode = -1 then
						ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_pedido. ~n' + ' Problemas ao inserir registro na tabela "pedido_ecommerce_baixa": ~n' + sqlca.sqlerrtext
						return false
					end if
					
				elseif ll_existe > 0 and ( ls_status = 'DEV' or ls_status = 'CAN' ) Then							
		
						Update pedido_ecommerce_baixa
						set dh_importacao = null
						where id_ecommerce = :is_id_ecommerce
							and id_rede_filial = :ls_rede_filial
							and nr_pedido_ecommerce = :ls_nr_pedido;
					
						if sqlca.sqlcode = -1 then
							ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_pedido. ~n' + ' Problemas ao atualizar registro na tabela "pedido_ecommerce_baixa": ~n' + sqlca.sqlerrtext
							return false
						end if
				end if
					
				Select count(*)
				Into :ll_Achou
				From pedido_ecommerce_baixa_feed
				Where id_ecommerce			= :is_id_ecommerce
					and id_rede_filial 				= :ps_rede_filial
					and nr_pedido_ecommerce 	= :ls_nr_pedido
					and eventid 						= :ls_id_evento
				Using SqlCa;
				
				If SqlCa.SqlCode = -1 then
					ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_pedido. ~n' + ' Problemas ao localizar registro na tabela "pedido_ecommerce_baixa_feed": ~n' + sqlca.sqlerrtext
					return false
				End If
			
				If ll_Achou =0  Then
								
					INSERT INTO pedido_ecommerce_baixa_feed  ( id_ecommerce,  id_rede_filial,  nr_pedido_ecommerce,  eventid, state )  
					VALUES ( :is_id_ecommerce, :ls_rede_filial, :ls_nr_pedido, :ls_id_evento, :ls_status )
					Using SqlCa;
						  
					if sqlca.sqlcode = -1 then
						ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_pedido. ~n' + ' Problemas ao inserir registro na tabela "pedido_ecommerce_baixa_feed": ~n' + sqlca.sqlerrtext
						return false
					end if		
	
				end if
			
		End Choose
		
		if ib_desenv = false Then //N$$HEX1$$e300$$ENDHEX$$o executar em ambiente de homologa$$HEX2$$e700e300$$ENDHEX$$o/desenvolvimento
			
	//		//Manda informa$$HEX2$$e700e300$$ENDHEX$$o pro ecommerce dizendo que o pedido j$$HEX1$$e100$$ENDHEX$$ foi recebido.
			If Not this.of_monta_json( ls_id_evento, ref ls_json, ref ls_log ) Then return false
			
			luo_comum.is_json = ls_json
			luo_comum.is_nr_pedido_ecommerce = ls_nr_pedido
			
			//Gera o token pra conectar no webservice.		
			luo_comum.of_gera_token( ref ls_log ) 
			
			if ls_log <> '' and not isnull(ls_log) Then
				sqlca.of_rollback( )
				luo_comum.of_envia_email(il_cd_mensagem_email, 'PEDIDO FEED Ifood', ll_Seq_Log, 'Pedido: '  + ls_nr_pedido + ' - ' +  ls_Log, ls_nr_pedido)
				luo_comum.of_grava_log_item( ll_cd_filial_ecommerce, ll_Seq_Log, ref ls_Log, ls_Log )
				ls_Situacao = 'E'
				w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
				Continue
			end if
			
			luo_comum.of_post(ls_json , is_id_interface_verificado, ls_retorno, ref ls_log )
			
			if ls_log <> '' and not isnull(ls_log) Then
				sqlca.of_rollback( )
				luo_comum.of_envia_email(il_cd_mensagem_email, 'PEDIDO FEED Ifood', ll_Seq_Log, 'Pedido: '  + ls_nr_pedido + ' - ' +  ls_Log, ls_nr_pedido)
				luo_comum.of_grava_log_item( ll_cd_filial_ecommerce, ll_Seq_Log, ref ls_Log, ls_Log )
				ls_Situacao = 'E'
				w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
				Continue
			end if
			
		End if	
		
		sqlca.of_Commit( )
		
		if Not luo_comum.of_grava_log_item(ll_cd_filial_ecommerce, ll_Seq_Log, ref ls_Log, ls_Log ) Then Return false
		
		w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)	
	next
			
	lb_sucesso = True

Finally
	
	Close(w_Ge501_Aguarde)
	
	if Not lb_sucesso then
		ls_situacao = 'E'
		
		sqlca.of_rollback( )
		
		// J$$HEX1$$e100$$ENDHEX$$ iniciou o envio dos itens
		If ll_for > 0 Then
			// Atualiza log com erro
			If Not luo_comum.of_atualiza_ecommerce_log(ll_cd_filial_ecommerce, ll_Seq_Log, 'E', ls_Log, gf_getserverdate(), ref ls_Log) Then Return False
			if Not luo_comum.of_grava_log_item(ll_cd_filial_ecommerce, ll_Seq_Log, ref ls_Log, ls_Log) Then Return false
		Else
			// Se n$$HEX1$$e300$$ENDHEX$$o tiver log insere um novo com erro
			If IsNull(ll_Seq_Log) or ll_Seq_Log = 0 Then
				// Grava in$$HEX1$$ed00$$ENDHEX$$cio do processo - chave e mensagem est$$HEX1$$e300$$ENDHEX$$o indo como nulo
				If Not luo_comum.of_grava_log(ll_cd_filial_ecommerce, il_cd_tipo, ls_Chave_Nula, 'E', ls_Log, ldh_Data_Nula, gf_getserverdate(), ref ls_Log, ref ll_Seq_Log ) Then Return False
			Else
				// Atualiza log com erro
				If Not luo_comum.of_atualiza_ecommerce_log(ll_cd_filial_ecommerce, ll_Seq_Log, 'E', ls_Log, gf_getserverdate(), ref ls_Log) Then Return False
			End If		
			luo_comum.of_envia_email(il_cd_mensagem_email, 'PEDIDO FEED Ifood', ll_Seq_Log, 'MSG: ' + ls_Log, '')
		End If
	Else
		If ll_Linhas > 0 Then
			// Marca o log como processado
			If Not luo_comum.of_atualiza_ecommerce_log(ll_cd_filial_ecommerce, ll_Seq_Log, ls_Situacao, ls_MSG_Nula, gf_getserverdate(), ref ls_Log) Then Return False
		End If
	End If
		
	luo_comum.of_grava_log_historico(ref ls_id_registro_log, ll_cd_filial_ecommerce, il_cd_tipo, ldh_log_inicio, gf_getserverdate(), ls_situacao, ll_Seq_Log, ref ls_log )		
		
	destroy(ids_pedidos)
	destroy(luo_comum)
	
	
End try

return true
end function

on uo_ge505_pedido_feed.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge505_pedido_feed.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;is_objeto = 'Objeto: ' + this.classname() + '~n'
end event

