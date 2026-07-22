HA$PBExportHeader$uo_ge512_smart_picking.sru
forward
global type uo_ge512_smart_picking from nonvisualobject
end type
end forward

global type uo_ge512_smart_picking from nonvisualobject
end type
global uo_ge512_smart_picking uo_ge512_smart_picking

type variables
dc_uo_ds_base ids_lista_retorno
dc_uo_ds_base ids_lista_retorno_lotes
dc_uo_ds_base lds1
dc_uo_ds_base ad_dados
dc_uo_ds_base lds_prd_lotes
dc_uo_transacao iuo_SqlCa_log

String	is_Login_Producao,&
		is_Senha_Producao,&
		is_Login_Homologacao,&
		is_Senha_Homologacao

String is_Url_Envio 
String is_Json_Envio

String is_Url_Status_Servico
String is_Status_Servico

String is_Url_Retorno
String is_Json_Retorno
Long ll_Status_Code

Boolean	ib_Producao = True
Boolean	ib_Trigger_WMS

String		is_Url_Producao,&
			is_Url_Homologacao
			
String     is_Metodo	
String 	is_Objeto
String 	is_Key

Date ldt_geracao

	
/// <Campos Retorno>
String is_NumPicking
String  is_cd_endereco
String is_cd_endereco_completo
String is_nr_lote
String is_nr_matricula
String is_situacao
String is_Situacao_Cabecalho
String is_Matricula
String is_etiq_caixa
String is_nr_lacre1
String is_nr_lacre2

LongLong il_nr_pedido
Long il_cd_filial
Long il_cd_produto
LongLong il_nr_ean
Long il_qt_pedido
Long il_qt_separada
Long il_nr_volume
Long il_qt_separada_lote
Date idt_validade

String is_tipo_processo		
String is_Usuario_PadPicking = '999988'
		
		
Boolean lb_Controlado_Lote_Endereco  = False		
		

end variables

forward prototypes
public function boolean of_processar_retorno ()
public function boolean of_autenticacao (ref string as_key, ref string as_erro, string as_json, ref string as_json_retorno, string as_tipo_processo)
public function boolean of_envia_servidor (string as_metodo, string as_url, string as_json_envio, string as_autenticacao_key, boolean ab_utiliza_api_key, boolean ab_utiliza_origem, ref string as_json_retorno, ref string as_erro)
public function boolean of_busca_url (ref string as_url_envio, ref string as_url_retorno, ref string as_url_status_servico, ref string as_erro)
public function boolean of_busca_status_servidor (string as_url, ref string as_json_retorno, ref string as_erro)
public function boolean of_grava_conferencia_romaneio (long al_pedido, long al_filial, long al_volume)
public function boolean of_retorna_status (string as_tipo, string as_status, ref string as_cd_retorno, ref string as_ds_retorno)
public function boolean of_monta_json_arquivo (long al_filial, long al_pedido, long al_volume, ref string as_picking, ref string as_json)
public function boolean of_verifica_saldo_produto (long al_produto, string as_endereco)
public function boolean of_verifica_abastecimento (long al_produto, string as_endereco)
public function boolean of_atualiza_tabela_log (string as_picking, long al_filial, long al_pedido, long al_volume, string as_tipo, string as_cd_retorno, string as_ds_retorno, string as_json)
public function boolean of_monta_json_produtos (long al_filial, long al_pedido, long al_nr_volume, ref string as_json_produtos, string as_numpicking)
public function boolean of_monta_json_produtos_lotes (long al_produto, string as_endereco, ref string as_json_produtos_lotes, string as_numpicking, long al_filial, long al_pedido, long al_nr_volume)
public function boolean of_carrega_retorno_separacao_lote (ref dc_uo_ds_base ads_lista_retorno_lotes, ref uo_ge512_json as_json, ref any as_data[], long as_linha, ref string as_log)
public function boolean of_verifica_pad_picking (long al_filial, long al_pedido, long al_volume)
public function boolean of_carrega_retorno_separacao (string as_json, ref string as_log)
public function boolean of_processa_atualizacao_envio (long al_filial, long al_pedido, long al_volume, string as_picking, string as_json_retorno, string as_json, ref string as_cd_retorno, ref string as_de_retorno)
public function boolean of_envia_email_erro (string as_mensagem)
public function boolean of_processa_atualizacao_retorno (ref string as_erro)
public function boolean of_atualiza_qtde_separada (ref dc_uo_ds_base ads_lista_retorno, ref string as_erro)
public function boolean of_atualiza_qtde_separada_pedido (long al_pedido, long al_filial, long al_produto, integer ai_qtde, ref string as_erro)
public function boolean of_insere_lote (long al_pedido, long al_filial, long al_volume, long al_produto, string as_endereco, string as_lote, integer ai_separada, ref string as_erro)
public function boolean of_insere_lotes_pedido_old (long al_filial, long al_pedido, long al_volume, string as_erro)
public function boolean of_baixa_reserva (long al_produto, string as_endereco, integer ai_separada, ref string as_erro)
public function boolean of_insere_lotes_pedido (long al_pedido, long al_filial, long al_volume, long al_produto, string as_endereco, string as_lote, integer ai_separada, string as_matricula, string as_grupo_psico, ref string as_erro)
public function boolean of_termina_conferencia (ref dc_uo_ds_base ads_lista_retorno, ref string as_erro)
public function boolean of_lotes_produtos_nao_controlados (dc_uo_ds_base ads_lista_retorno, ref dc_uo_ds_base ads_lista_retorno_lote, ref string as_erro)
public function boolean of_atualiza_qtde_separada_lote (ref dc_uo_ds_base ads_lista_retorno_lote, ref string as_erro)
public function boolean of_grupo_psico (long ai_produto, ref string as_grupo, ref string as_erro)
public function boolean of_verifica_esteira (long al_esteira)
public function boolean of_monta_json_produtos_ean (long al_produto, ref string as_json_ean)
public function boolean of_abre_conexao (string ps_log)
public function boolean of_fecha_conexao ()
public function boolean of_atualiza_tabela_log_nova (string as_picking, long al_filial, long al_pedido, long al_volume, string as_tipo, string as_cd_retorno, string as_ds_retorno, string as_json, ref string ps_log)
public function boolean of_atualiza_lista_separacao (long al_pedido, long al_filial, long al_volume, string as_tipo, ref string as_log)
public function boolean of_verifica_endereco_completo (string as_endereco_reduzido, long al_produto, ref string as_endereco_completo, ref string as_erro)
public function boolean of_verifica_divergencia_separacao (ref boolean ab_divergencia, ref string as_log)
public function boolean of_consiste_dados (long al_filial, long al_pedido, long al_volume, ref string as_erro)
public function boolean of_carrega_end_contro_json (string as_json_retorno, ref dc_uo_ds_base ads_json, ref string as_mensagem_erro)
public function boolean of_atualiza_id_endereco_pad_picking (string as_json_retorno, dc_uo_ds_base ads_endereco_controlado, dc_uo_ds_base ads_contro_json, ref string as_mensagem_erro)
public function boolean of_envia_email_endereco_control_json (dc_uo_ds_base ads_endereco_controlado, ref string as_mensagem_erro)
public function boolean of_processa_lista_endereco_controlado ()
public function boolean of_movimento_saida_flowrack (string as_endereco_saida, long al_produto, long al_cx_padrao, string as_lote, date adh_validade, long al_qtde, long al_sequencial, long al_filial, long al_nr_pedido, long al_volume, ref string as_erro)
public function boolean of_atualiza_qtde_separada_produto (long al_pedido, long al_filial, long al_volume, long al_produto, string as_endereco, integer ai_separada, string as_matricula, ref string as_erro, datetime adt_conferencia, datetime adt_ini_conferencia)
public function boolean of_carrega_parametros (ref datetime adt_parametro, ref long al_top)
end prototypes

public function boolean of_processar_retorno ();//Receber

Integer	li_Ret 
Any	la_data, la_null

Long 	ll_Filial,&
		ll_Pedido,&
		ll_Linha,&
		ll_Linhas,&
		ll_Volume,&
		ll_Top,&
		ll_Top_parametro

String 	ls_Erro,&
			ls_Picking, &
			ls_Prox_Importacao

Datetime ldh_data, &
			ldh_Prox_Importacao
			
Boolean lb_Atualizacao_Geral = False

Try
	lb_Controlado_Lote_Endereco    = gf_pad_picking_lote()
	
	ldh_data  = DateTime(Today(), Now()) 
	
	If Not of_Carrega_Parametros(Ref ldh_Prox_Importacao, Ref ll_Top_parametro ) Then
		Return False
	End If

	If ldh_data > ldh_Prox_Importacao Then
		lb_Atualizacao_Geral = True
		ll_Top = 1000
	Else
		If Isnull(ll_Top_parametro) Then
			ll_Top_parametro = 80
		End If
		
		ll_Top = ll_Top_parametro
		
	End If
	
	// Datastore de Pickings Enviados com sucesso
	dc_uo_ds_base lds_lista_envio
	lds_lista_envio  = Create dc_uo_ds_base
	
	If Not lds_lista_envio.of_ChangeDataObject("dw_ge512_lista_envio", False) Then 
		This.of_envia_email_erro("PadPicking: Lojas PickingLigt - Erro alterar Dw dw_ge512_lista_envio")
		Return False
	End If
	
	ll_Linhas =lds_lista_envio.retrieve(ll_Top)
	
	If ll_Linhas = 0 Then Return True
	
	// Verifica erro as Buscar Picking
	If ll_Linhas < 0  Then 
		This.of_envia_email_erro("Receber Picking: Erro de conex$$HEX1$$e300$$ENDHEX$$o ao banco de dados - dw_ge512_lista_envio")
		Return False
	End If
	
	// Carrega Informa$$HEX2$$e700e300$$ENDHEX$$o URL
	If Not This.of_busca_url(Ref is_Url_Envio, Ref is_Url_Retorno , Ref is_Url_Status_Servico, Ref ls_erro ) Then 
		This.of_envia_email_erro("PadPicking: Erro Busca URL de Configuracao")
		Return False
	End If 
	
	// Verifica Status Servidor SmartPicking
	If Not this.of_busca_status_servidor ( is_Url_Status_Servico, Ref is_Status_Servico, Ref ls_erro )  Then 
		This.of_envia_email_erro("PadPicking: Servi$$HEX1$$e700$$ENDHEX$$o Esta Fora / Servidor SmartPicking")
		Return False
	End If
	
	// Cria DW - Produtos - Itens
	ids_lista_retorno = create dc_uo_ds_base
	If Not ids_lista_retorno.of_changedataobject( 'dw_ge512_lista_retorno' , false) Then
		This.of_envia_email_erro(is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processar_retorno ~n' + 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: dw_ge512_lista_retorno')
		Return false
	End If
	
	// Cria DW   - Produtos - Itens  - Lotes
	ids_lista_retorno_lotes = create dc_uo_ds_base
	If Not ids_lista_retorno_lotes.of_changedataobject( 'dw_ge512_lista_retorno_lote' , false) Then
		This.of_envia_email_erro(is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processar_retorno ~n' + 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: dw_ge512_lista_retorno_lote')
		Return false
	End If
	
	If lb_Atualizacao_Geral Then
		ls_Prox_Importacao = String(ldh_data, "dd/mm/yyyy hh:mm:ss")
		
		Update parametro_geral
			Set vl_parametro = :ls_Prox_Importacao
		From parametro_geral
		Where cd_parametro = 'ULTIMA_IMPORT_RETORNO_PAD_PICKING'
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			ls_erro = SqlCa.SqlErrText
			SqlCa.of_Rollback();
			This.of_envia_email_erro("Receber Picking: Erro ao atualizar o parametro_geral 'ULTIMA_IMPORT_RETORNO_PAD_PICKING'. " + ls_erro)
			Return False
		End If
		
		SqlCa.of_Commit();
	End If
	
	// Para Carregando....
	If Not IsValid(w_aguarde) then
		Open(w_aguarde)
	End If	
	w_aguarde.Title = "WMS-Processando Retorno PadPicking."
	w_aguarde.uo_progress.of_reset()
	w_aguarde.uo_progress.Of_SetMax(ll_linhas)		

	For ll_Linha = 1 To ll_linhas
		w_aguarde.Title = "WMS-Processando Retorno PadPicking." + String(ll_Linha)+" De :"+String(ll_Linhas)				
		
		ll_Filial	 		= lds_lista_envio.Object.cd_filial						[ll_Linha]
		ll_Pedido	 		= lds_lista_envio.Object.nr_pedido_distribuidora	[ll_Linha]
		ll_Volume 			= lds_lista_envio.Object.nr_volume					[ll_Linha]
		ls_Picking 			= lds_lista_envio.Object.nr_picking					[ll_Linha]
					
		is_Json_Envio = ls_Picking
		is_Json_Retorno = ''
				
		// Inicio
		ls_erro = ''
		If Not This.of_autenticacao (is_Key , ref ls_erro, is_Json_Envio ,  ref is_Json_Retorno, 'R') Then 
			ls_Erro += ' Erro na Requisi$$HEX2$$e700e300$$ENDHEX$$o REST-Get p/ a SmartPicking - ' +ls_Erro + ' - Picking:' +ls_Picking
			
			SqlCa.of_Rollback()
			
			If Not This.of_atualiza_tabela_log_Nova(ls_Picking, ll_filial ,ll_pedido ,ll_volume, 'R', '-1' , ls_erro, is_Json_Retorno, ls_erro) Then
				ls_erro	= "Erro na atualizacao tabela de Log wms_integracao_picking. Erro: " + SqlCa.sqlErrText
				This.of_envia_email_erro(ls_erro)
			End If
			w_aguarde.uo_progress.Of_SetProgress(ll_Linha)	
			Continue
		End If
		
		ls_erro = ''
		//Parse no aquivo Json de retorno inclusao nas dw external de produto e lote
		If Not This.of_carrega_retorno_separacao(is_Json_Retorno, ref ls_Erro) Then 
			SqlCa.of_Rollback()
			If Not This.of_atualiza_tabela_log_Nova(ls_Picking, ll_filial ,ll_pedido ,ll_volume, 'R', '-1' , ls_erro, is_Json_Retorno, ls_erro) Then
				ls_erro	= "Erro na atualizacao tabela de Log wms_integracao_picking. Erro: " + SqlCa.sqlErrText
				This.of_envia_email_erro(ls_erro)
			End If
			w_aguarde.uo_progress.Of_SetProgress(ll_Linha)	
			Continue
		End If
		
		ls_erro = ''
		//Atualizacao nas tabelas de produto_separacao e produto_lote_separacao
		If Not This.of_processa_atualizacao_retorno(ref ls_erro) Then 
			SqlCa.of_Rollback()
			If Not This.of_atualiza_tabela_log_Nova(ls_Picking, ll_filial ,ll_pedido ,ll_volume, 'R', '-1' , ls_erro, is_Json_Retorno, ls_erro) Then
				ls_erro	= "Erro na atualizacao tabela de Log wms_integracao_picking. Erro: " + SqlCa.sqlErrText
				This.of_envia_email_erro(ls_erro)
			End If
			w_aguarde.uo_progress.Of_SetProgress(ll_Linha)	
			Continue
		End If
				
		ls_erro = ''
		// Marca o t$$HEX1$$e900$$ENDHEX$$rmino da separa$$HEX2$$e700e300$$ENDHEX$$o
		If Not This.of_atualiza_lista_separacao(ll_pedido, ll_filial, ll_volume, 'R', ls_erro) Then 
			SqlCa.of_Rollback()
			If Not This.of_atualiza_tabela_log_Nova(ls_Picking, ll_filial ,ll_pedido ,ll_volume, 'R', '-1' , ls_erro, is_Json_Retorno, ls_erro) Then
				ls_erro	= "Erro na atualizacao tabela de Log wms_integracao_picking. Erro: " + SqlCa.sqlErrText
				This.of_envia_email_erro(ls_erro)
			End If
			w_aguarde.uo_progress.Of_SetProgress(ll_Linha)	
			Continue
		End If
		
		// Desenvolvimento
		//		SqlCa.of_Rollback()
		//		ls_erro = 'ROLLBACK - TESTE DESENV'
		//		Return False
		
		ls_erro = ''
		// Atualiza Sempre Tabela de Log : wms_integracao_picking
		// Se n$$HEX1$$e300$$ENDHEX$$o consegui gravar registro LOG do t$$HEX1$$e900$$ENDHEX$$rmino da confer$$HEX1$$ea00$$ENDHEX$$ncia
		If Not This.of_atualiza_tabela_log(ls_Picking, ll_filial ,ll_pedido ,ll_volume, 'R', '1' , 'Retorno: Salvo com Sucesso' , is_Json_Retorno) Then 
			SqlCa.of_Rollback()
			This.of_envia_email_erro(ls_erro)
			ls_erro = '' // Neste caso seta como branco para n$$HEX1$$e300$$ENDHEX$$o tentar gravar no log novamente
			Return False		
		End If
		
		SqlCa.of_Commit()
		// Termino
		
		// Para Carregando
		w_aguarde.uo_progress.Of_SetProgress(ll_Linha)	
	Next 	
Finally
	If IsValid(w_aguarde) Then Close(w_aguarde)
	If IsValid(lds_lista_envio) Then Destroy(lds_lista_envio)
	If IsValid(ids_lista_retorno) Then Destroy(ids_lista_retorno)
	If IsValid(ids_lista_retorno_lotes) Then Destroy(ids_lista_retorno_lotes)
End Try

Return True
end function

public function boolean of_autenticacao (ref string as_key, ref string as_erro, string as_json, ref string as_json_retorno, string as_tipo_processo);String	ls_Json,&
		ls_Login,&
		ls_Senha,&
		ls_Url,&
		ls_json_retorno
		
Boolean	lb_Sucesso = False

Try
	SetNull(as_json_retorno)

	If as_tipo_processo = 'E' Then 
		ls_Url = is_Url_Envio
	Else
		ls_Url = is_Url_Retorno
	End If 
		
	If This.of_Envia_Servidor ("POST", ls_Url, as_json, is_Key , True , False, Ref ls_Json_Retorno, Ref as_Erro) Then
		lb_Sucesso = True		
	Else
		lb_Sucesso = False		
		//as_Erro = "Erro no Envio Arquivo:  of_autenticacao"
	End If 	
	
	// Informa$$HEX2$$e700e300$$ENDHEX$$o do Retorno
	as_json_retorno = ls_Json_Retorno
	
	
Catch (RuntimeError rte)
	as_Erro = "Erro no Envio Arquiovo:  of_autenticacao" + String(rte.getMessage())
	as_json_retorno = ls_Json_Retorno
	lb_Sucesso = False
End Try

Return lb_Sucesso
end function

public function boolean of_envia_servidor (string as_metodo, string as_url, string as_json_envio, string as_autenticacao_key, boolean ab_utiliza_api_key, boolean ab_utiliza_origem, ref string as_json_retorno, ref string as_erro);String ls_Status_Text

OleObject	lo_Http,&
				lo_Send
				
Long		li_rc1,&
			li_rc2
			

Try
	Try
		lo_Send	= CREATE oleobject
		lo_Http	= CREATE oleobject
		lo_Send.ConnectToNewObject("Msxml2.DOMDocument.6.0")		
		lo_Http.ConnectToNewObject("MSXML2.SERVERXMLHTTP.6.0")
		lo_Http.open (as_Metodo, as_Url, False)  
		lo_Http.SetRequestHeader( "Content-Type", "application/json")
		
		//If ab_Utiliza_Api_Key Then
		//	lo_Http.setRequestHeader("api_key", as_Autenticacao_Key)
		///End If
		
		// Trust the SSL Certificate 
		//lo_Http.setOption(2,'13056') 
		
		If as_Metodo = "POST" Then
			lo_Http.send(as_Json_Envio)
		Else
			lo_Http.send(lo_Send)
		End If
		
		//Pega a resposta do web service
		ls_Status_Text 	= lo_Http.StatusText
		ll_Status_Code 	= lo_Http.Status
		as_json_retorno = lo_Http.ResponseText
		
		If ll_Status_Code > 201 Then
			as_Erro = "SmartPicking: Erro no retorno Servi$$HEX1$$e700$$ENDHEX$$o-Descri$$HEX2$$e700e300$$ENDHEX$$o : " + String(as_json_retorno)
			Return False
		Else					
			Return True 
		End If
		
	Finally
		//Disconecta
		lo_Http.DisconnectObject()		
		Destroy(lo_Http)
		Destroy(lo_Send)
	End Try

Catch (RuntimeError rte)
	as_Json_Retorno = lo_Http.ResponseText
	as_Erro = "SmartPicking: Erro retorno do Servi$$HEX1$$e700$$ENDHEX$$o-Codigo do Erro: " +String(ll_Status_Code)+ "~r~nDescri$$HEX2$$e700e300$$ENDHEX$$o Erro: " + String(ls_Status_Text)
	Return False	
End Try
end function

public function boolean of_busca_url (ref string as_url_envio, ref string as_url_retorno, ref string as_url_status_servico, ref string as_erro);
//// URL STATUS DO SERVICO
Select de_parametro
Into :as_url_status_servico
From  wms_parametro
Where cd_parametro = 'URL_STATUS_SMARTPICKING'
Using SqlCA;
				
If SqlCa.SqlCode = - 1 Then
	as_Erro = "Erro ao consultar url_status: "+Sqlca.sqlErrText
	Return False
End If
		
If IsNull(as_url_status_servico) or as_url_status_servico='' Then 
	as_Erro = "Erro ao consultar url_status: "+Sqlca.sqlErrText
	Return False
End If 


/// URL ENVIO INFORMA$$HEX2$$c700d500$$ENDHEX$$ES
Select de_parametro
Into :as_url_envio
From  wms_parametro
Where cd_parametro = 'URL_ENVIO_SMARTPICKING'
Using SqlCA;
				
If SqlCa.SqlCode = - 1 Then
	as_Erro = "Erro ao consultar url_envio: "+Sqlca.sqlErrText
	Return False
End If
		
If IsNull(as_url_envio) or as_url_envio='' Then 
	as_Erro = "Erro ao consultar url_envio: "+Sqlca.sqlErrText
	Return False
End If 
		
/// URL RETORNO INFORMA$$HEX2$$c700d500$$ENDHEX$$ES		
Select de_parametro
Into :as_url_retorno
From  wms_parametro
Where cd_parametro = 'URL_RETORNO_SMARTPICKING'
Using SqlCA;	
		
If SqlCa.SqlCode = - 1 Then
	as_Erro = "Erro ao consultar url_retorno: "+Sqlca.sqlErrText
	Return False
End If
		
If IsNull(as_url_envio) or as_url_envio='' Then 
	as_Erro = "Erro ao consultar url_retorno: "+Sqlca.sqlErrText
	Return False
End If 		

is_Url_Status_Servico = as_url_status_servico		
is_Url_Envio 	= as_url_envio
is_Url_Retorno  = as_url_retorno

Return True 

	
	



end function

public function boolean of_busca_status_servidor (string as_url, ref string as_json_retorno, ref string as_erro);String ls_Status_Text
Long  ll_Cd_Sucesso = 0 
OleObject	lo_Http,&
				lo_Send
				
Long		li_rc1,&
			li_rc2

Try
	Try
		lo_Send	= CREATE oleobject
		lo_Http	= CREATE oleobject
		lo_Send.ConnectToNewObject("Msxml2.DOMDocument.6.0")		
		lo_Http.ConnectToNewObject("MSXML2.SERVERXMLHTTP.6.0")
		lo_Http.open ('GET', as_Url, False)  
		lo_Http.SetRequestHeader( "Content-Type", "application/json")
		lo_Http.send(as_Url)
				
		//Pega a resposta do web service
		ls_Status_Text 	= lo_Http.StatusText
		ll_Status_Code 	= lo_Http.Status
		as_json_retorno = lo_Http.ResponseText
	
		If ll_Status_Code > 201 Then
			Return False
		Else					
			ll_Cd_Sucesso = Pos (as_json_retorno , "1")
			If ll_Cd_Sucesso >0 Then 
				Return True 
			Else
				Return True 
			End If 
		End If
	Catch (RuntimeError lo_rte2)
		Return False
	Finally
		//Disconecta
		lo_Http.DisconnectObject()	
		GarbageCollect()
		Destroy(lo_Http)
		Destroy(lo_Send)
	End Try

Catch (RuntimeError rte)	
	Return False	
End Try
end function

public function boolean of_grava_conferencia_romaneio (long al_pedido, long al_filial, long al_volume);Long			ll_Qtde
String 		ls_MSG,&
		 		ls_Motivo

Select count(*) 
  Into :ll_Qtde
  from wms_romaneio_conferencia
 where cd_filial =:al_filial
   and nr_pedido_distribuidora =:al_pedido
   and nr_volume =:al_volume
 Using SqlCA;

If (ll_Qtde=0) Then 
	Insert into wms_romaneio_conferencia 
	          ( cd_filial
				 ,	nr_pedido_distribuidora
				 ,	nr_volume
				 , dh_insercao 
				 ) 													 
      Values ( :al_filial
		       , :al_pedido
				 , :al_volume
				 , getdate() 
				 ) 
      Using SqlCA;	
End If 


If SqlCa.SqlCode = -1 Then
	ls_MSG = 	"Erro ao atualizar a data do registro: " + SQLCA.SQLErrText
	SqlCa.of_Rollback()
	MessageBox("Erro", ls_MSG, StopSign!)
	Return False
End If

If SqlCa.sqlnrows <> 1 Then
	SqlCa.of_Rollback()
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Na fun$$HEX2$$e700e300$$ENDHEX$$o 'wf_grava_conferencia' deveria atualizar uma linha, est$$HEX1$$e100$$ENDHEX$$ atualizando "+String(SqlCa.sqlnrows)+" linhas.", StopSign!)
	Return False
End If

end function

public function boolean of_retorna_status (string as_tipo, string as_status, ref string as_cd_retorno, ref string as_ds_retorno);String lvs_status

////{"retorno":-1,"mensagem":null}  
////{"retorno":1,"mensagem":null}                                                                                                                                           
////{"retorno":902,"mensagem":"105630010384714004"}                                                     

If PosA (as_status, ":-1,") <>0  Then  
	lvs_status  = MidA(as_status, 12,2)
ElseIf PosA (as_status, ":1,") <>0  Then 
	lvs_status  = MidA(as_status, 12,1)
Else  
	lvs_status  = MidA(as_status, 12,3)
End If 

as_cd_retorno = lvs_status

Choose Case as_tipo
	Case "E"    /// Status para Envio
		Choose Case Long(lvs_status)
			Case 1
				as_ds_retorno = "Picking salvo com sucesso"
			Case -1
				as_ds_retorno = "Erro Nao Especificado"
			Case 900
				as_ds_retorno = "Numero Picking Nao Informado"
			Case 901
				as_ds_retorno = "Codigo Caixa Plastica Nao Informado"
			Case 902
				as_ds_retorno = "Ja Existe o Picking"
			Case 903
				as_ds_retorno = "Codigo Caixa Plastica Vinculada Outro Picking"
			Case 904
				as_ds_retorno = "Verificar Se Caixa Plastica Existe"
			Case 909
				as_ds_retorno = "Endereco Inexistente"
			Case 910
				as_ds_retorno = "LED Nao Cadastrado"	
			Case Else
				as_ds_retorno = "Erro Sem Retorno-CLAMED"	
		End Choose		
	Case "I"    /// Status para Retorno

End Choose


Return True 


//-1 - Erro n$$HEX1$$e300$$ENDHEX$$o especificado
//1 - Picking salvo com sucesso
//900 - Numero de picking n$$HEX1$$e300$$ENDHEX$$o informado
//901 - C$$HEX1$$f300$$ENDHEX$$digo da caixa plastica n$$HEX1$$e300$$ENDHEX$$o informado
//902 - J$$HEX1$$e100$$ENDHEX$$ existe o picking
//903 - C$$HEX1$$f300$$ENDHEX$$digo da caixa plastica j$$HEX1$$e100$$ENDHEX$$ vinculada a outro picking
//904 - Verificar se a caixa plastica existe
//909 - Endere$$HEX1$$e700$$ENDHEX$$o inexistente
//910 - LED nao cadastrado
end function

public function boolean of_monta_json_arquivo (long al_filial, long al_pedido, long al_volume, ref string as_picking, ref string as_json);Boolean	lb_verifica = false

String  lvs_cd_filial,&
		lvs_Json,&
		lvs_nr_pedido, &
		ls_log
		
String lvs_nr_volume,	&
		lvs_json_produtos, &
		ls_nr_etiqueta_fixa,&
		ls_nr_lacre1,&
		ls_nr_lacre2
		
Long ll_Linhas, ll_Linha, ll_cd_esteira

Long ll_Chave_Volume


Try 
	// Inicia Variaveis	
	SetNull(lvs_Json)
	
	lb_Controlado_Lote_Endereco    = gf_pad_picking_lote()
	
		
	lvs_Json	=''
	lvs_cd_filial		= Trim(String(al_filial))
	lvs_nr_pedido	= Trim(String(al_pedido))
	lvs_nr_volume	= Trim(String(al_volume))
	//lvs_Codigo_Barras = "1" + right("0000" + String(lvs_cd_filial),4) +right("0000000000"+String(lvs_nr_pedido),10) + right("000"+String(lvs_nr_volume),3)
	
	select nr_chave_volume,
			 cd_esteira,
			 nr_etiqueta_fixa,
			 nr_lacre1,
			 nr_lacre2
  	  Into :ll_Chave_Volume,
		 	 :ll_cd_esteira,
			 :ls_nr_etiqueta_fixa,
			 :ls_nr_lacre1,
			 :ls_nr_lacre2
	from wms_lista_separacao
	where cd_filial = :al_filial
	     and nr_pedido_distribuidora = :al_pedido
		and nr_volume = :al_volume
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			if not gf_esteira_verifica_lacre_vol(ll_cd_esteira, al_filial, ref lb_verifica, ref ls_log) then
				MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_log, StopSign!)
				Return False
			end if
		Case 100
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Volume n$$HEX1$$e300$$ENDHEX$$o foi localizado")
			Return False
		Case -1 
			SqlCa.of_MsgDbError("Erro ao localizar o volume")
			Return False
	End Choose
	
	as_picking = String(ll_Chave_Volume)

	// Abre Cabe$$HEX1$$e700$$ENDHEX$$alho
	lvs_Json	+='{'
	lvs_Json	+='"numPicking": "'+as_picking+'",'

	if lb_verifica then
		if IsNull(ls_nr_etiqueta_fixa) then ls_nr_etiqueta_fixa = ''
		if IsNull(ls_nr_lacre1) then ls_nr_lacre1 = ''
		if IsNull(ls_nr_lacre2) then ls_nr_lacre2 = ''

		lvs_Json	+='"numCaixa": "'+ls_nr_etiqueta_fixa+'",'
		lvs_Json	+='"numLacreDireito": "'+ls_nr_lacre1+'",'
		lvs_Json	+='"numLacreEsquerdo": "'+ls_nr_lacre2+'",'
	end if
	
	// Produtos e Chama Lotes
	If This.of_monta_json_produtos(Long(lvs_cd_filial), Long(lvs_nr_pedido), Long(lvs_nr_volume), Ref lvs_json_produtos, as_picking ) Then 
		lvs_Json	+=lvs_json_produtos
	Else
		MessageBox("Aviso", "PadPicking: Erro Cria$$HEX2$$e700e300$$ENDHEX$$o Arquivo!")
		Return False
	End If 	
			
	// Fecha Cabe$$HEX1$$e700$$ENDHEX$$alho
	If ll_linha < ll_Linhas	Then
		lvs_Json	+='},'
	Else
		lvs_Json	+='}'
	End If				
	
Finally
	If IsNull(lvs_Json) Then 
		MessageBox("Aviso", "PadPicking: Erro Cria$$HEX2$$e700e300$$ENDHEX$$o Arquivo para Envio!")
		Return False			
	End If 	
	as_json = lvs_Json
End try

Return True
end function

public function boolean of_verifica_saldo_produto (long al_produto, string as_endereco);Long ll_Qtd


Select count(*) 
Into 	:ll_Qtd
from   wms_localizacao
where cd_produto=:al_produto
and    cd_endereco=:as_endereco
Using SqlCA;
// ver sergio

Choose Case Sqlca.Sqlcode
	Case -1	
		MessageBox("Erro", "Verifica$$HEX2$$e700e300$$ENDHEX$$o saldo Produto: " + SQLCA.SQLErrText, StopSign!)
		Return False	
	Case 0
		If ll_Qtd=0 Then 
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Sem Saldo para o Produto:" + String(al_Produto) + " no Endere$$HEX1$$e700$$ENDHEX$$o:"+String(as_endereco))
			Return False
		End If 

		If ll_Qtd>0 Then Return True 
		
	Case 100
		Return False
End Choose


end function

public function boolean of_verifica_abastecimento (long al_produto, string as_endereco);Long ll_Qtde

Select count(*)
Into :ll_Qtde
From(
	 Select      a.qt_abastecer - (	Select isnull(sum(qt_movimento), 0) 
											From wms_movimentacao d 
											Where d.cd_endereco_saida	= a.cd_endereco_retirada 
											And d.cd_produto				= a.cd_produto 
											And d.nr_lote					= a.nr_lote 
											And d.qt_caixa_padrao		= a.qt_caixa_padrao) as qt_retirar
	 From wms_abastecimento_flow_rack a
	 Where a.cd_endereco_retirada	= :as_Endereco
	 And a.cd_produto						= :al_Produto
	) as tudo
Where qt_retirar > 0
Using SqlCa;
	
If SqlCa.Sqlcode = -1 Then
	MessageBox("Erro", "Verifica$$HEX2$$e700e300$$ENDHEX$$o se tem abastecimento para o endere$$HEX1$$e700$$ENDHEX$$o e produto. " + SQLCA.SQLErrText, StopSign!)
	Return False
End If
	
If ll_Qtde > 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existem um Abastecimento Pendente para o Produto:"+String(al_produto)+" Endereco:" + String(as_endereco))
	Return False
End If
end function

public function boolean of_atualiza_tabela_log (string as_picking, long al_filial, long al_pedido, long al_volume, string as_tipo, string as_cd_retorno, string as_ds_retorno, string as_json);Long ll_Achou

Datetime ldh_data
String lvs_datahora

ldh_data  = DateTime(Today(), Now()) 
lvs_datahora =  String  (ldh_data, "yyyy-mm-dd hh:mm:ss")

select count(*)
Into :ll_Achou
from wms_integracao_picking
where cd_filial = :al_filial
   and nr_pedido_distribuidora = :al_pedido
   and nr_volume = :al_volume
   and cd_tipo = :as_tipo
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Erro ao localizar o registro do log")
	Return False
End If

If ll_Achou > 0 Then
	
	Delete from wms_integracao_picking
	where cd_filial = :al_filial
   		and nr_pedido_distribuidora = :al_pedido
   		and nr_volume = :al_volume
   		and cd_tipo = :as_tipo
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgDbError("Erro ao localizar o registro do log")
		Return False
	End If
	
End If

Insert into wms_integracao_picking(nr_picking, cd_filial, nr_pedido_distribuidora, nr_volume, dt_inclusao, cd_tipo, ds_arquivo_json , ds_integracao , cd_integracao) 
Values (:as_picking,  :al_filial , :al_pedido , :al_volume,: lvs_datahora, :as_tipo, :as_json , :as_ds_retorno, :as_cd_retorno )
Using SqlCa;

If SqlCa.SqlCode = - 1 Then
	SqlCa.of_Rollback()
	Return False				
End If 	

Return True
end function

public function boolean of_monta_json_produtos (long al_filial, long al_pedido, long al_nr_volume, ref string as_json_produtos, string as_numpicking);Long 	 ll_Linhas, ll_Linha

String	 lvs_Json_Prd,& 
		lvs_endereco,& 
		lvs_produto,& 
		lvs_descricao,& 
		lvs_qtd,& 
		lvs_ean,& 
		lvs_jsonLotes,&
	 	lvs_cd_filial,&
		lvs_erro,&
		lvs_Grupo_Psico,&
		lvs_end_flow,&
		lvs_JsonEAN

SetNull(lvs_Json_Prd)
SetNull(lvs_jsonLotes)

Try 
     // Dados do Volume e Produtos
	dc_uo_ds_base lds_base_prd
	lds_base_prd = create dc_uo_ds_base
	If Not lds_base_prd.of_changedataobject( 'dw_ge512_lista_separacao_produtos' ) Then
		MessageBox("Aviso", "PadPicking: Erro alterar Dw dw_ge512_lista_separacao_produtos")		
		Return False
	End if

	ll_linhas = lds_base_prd.retrieve(al_filial, al_pedido, al_nr_volume)
	If  ll_linhas <= 0 Then
		Return  False
	Else
	
		// Inicio
		lvs_Json_Prd = '"listaItens":['
		
		For ll_Linha = 1 to ll_Linhas
			
			lvs_endereco		= Trim(String(lds_base_prd.object.cd_endereco[ll_Linha]))
			lvs_produto			= Trim(String(lds_base_prd.object.cd_produto[ll_Linha]))
			lvs_descricao		= Trim(String(lds_base_prd.object.descricao[ll_Linha]))
			lvs_qtd				= Trim(String(lds_base_prd.object.qtd[ll_Linha]))
			lvs_ean				= Trim(String(lds_base_prd.object.ean[ll_Linha]))
			lvs_Grupo_Psico	= Trim(String(lds_base_prd.object.cd_grupo_psico[ll_Linha])) 
			lvs_end_flow     	= Trim(String(lds_base_prd.object.de_endereco_flow_rack[ll_Linha]))    
						
			// Campo Produto
			lvs_Json_Prd	+='{'
			lvs_Json_Prd	+= '"numEndereco": "'+lvs_end_flow+'",'
			lvs_Json_Prd	+= '"codSKU": "'+lvs_produto+'",'
			lvs_Json_Prd	+= '"descricao": "'+lvs_descricao+'",'
			lvs_Json_Prd	+= '"quantidade": "'+lvs_qtd+'",'

			/// json EAN
			If This.of_monta_json_produtos_ean(Long(lvs_produto),  Ref lvs_JsonEAN) Then 
				lvs_Json_Prd	+= lvs_JsonEAN + iif(Not IsNull(lvs_Grupo_Psico), ',', '')
			Else				
				Return False				
			End If 
				
			// Lotes Disponiveis do Produto: Apenas Controlado. Vigiado n$$HEX1$$e300$$ENDHEX$$o manda.
			If  Not IsNull(lvs_Grupo_Psico) Then 
				If This.of_monta_json_produtos_lotes(Long(lvs_produto), lvs_endereco, Ref lvs_jsonLotes,&
																  as_numpicking, al_filial, al_pedido, al_nr_volume) Then 
					lvs_Json_Prd	+= lvs_jsonLotes
				Else				
					Return False				
				End If 
			End If 
						
			If ll_linha < ll_Linhas   	Then
				lvs_Json_Prd	+='},'
			Else
				lvs_Json_Prd	+='}'
			End If	
			
		Next		
		lvs_Json_Prd	+=']'		
		as_json_produtos = lvs_Json_Prd
	
		If IsNull(as_json_produtos) Then 
			MessageBox("Aviso", "PadPicking: Erro Cria$$HEX2$$e700e300$$ENDHEX$$o Arquivo dos Produtos!")
			Return False		
		End If 
	End If 
Finally	
	Destroy(lds_base_prd)
End try

Return True 
end function

public function boolean of_monta_json_produtos_lotes (long al_produto, string as_endereco, ref string as_json_produtos_lotes, string as_numpicking, long al_filial, long al_pedido, long al_nr_volume);Long ll_Linhas, ll_Linha, ll_Achou
String	 lvs_Json_lote , lvs_lote, lvs_erro, lvs_validade
SetNull(lvs_Json_lote)
SetNull(lvs_lote)
SetNull(lvs_validade)

Try 
	 
	// Dados do Volume e Produtos
	lds_prd_lotes = create dc_uo_ds_base
	If Not lds_prd_lotes.of_changedataobject( 'dw_ge512_lista_separacao_produtos_lotes' ) Then
		MessageBox("Aviso", "PadPicking: Erro Erro alterar Dw dw_ge512_lista_separacao_produtos_lotes")
		Return False
	End if

	// Carrega os Dados
	ll_linhas = lds_prd_lotes.retrieve(al_produto, as_endereco)
	// Inicio		
	lvs_Json_lote = '"listaLotes":['

	// Quando nao temos lotes mandamos Vazio e Recebemos Vazio
	If  ll_linhas <= 0 Then
		lvs_lote = " "
		lvs_validade = " "
		lvs_Json_lote	+='{'
		lvs_Json_lote	+= '"lote":"'+lvs_lote+'"'					
		lvs_Json_lote	+=','
		lvs_Json_lote	+= '"validade":"'+lvs_validade+'"'					
		lvs_Json_lote	+='}'			
	Else
		//  Percorrer Lotes Disponiveis
		For ll_Linha = 1 to ll_Linhas
			// Campo Lote
			lvs_lote		= Trim(String(lds_prd_lotes.object.nr_lote[ll_Linha]))
			lvs_validade = Trim(String( lds_prd_lotes.object.dh_validade[ll_Linha], 'dd/mm/yyyy'   )     )
			
			Select count(*) 
			Into :ll_Achou
			From wms_lista_separacao_prd_pick
			Where cd_filial 						=:al_filial
			   and nr_pedido_distribuidora 	=:al_pedido
			   and nr_volume 					= :al_nr_volume
			   and cd_produto 					=:al_produto
			   and cd_endereco_localizacao	=:as_endereco 
			   and nr_lote 						=:lvs_lote
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				SqlCa.of_MsgDbError("Erro ao localizar os dados enviados ao PAD Picking na wms_lista_separacao_prd_pick")
				SqlCa.of_RollBack();
				Return False
			End If
			
			If ll_Achou = 0 Then
				INSERT INTO wms_lista_separacao_prd_pick  ( cd_filial, nr_pedido_distribuidora, nr_volume, cd_produto, cd_endereco_localizacao, nr_lote )  
				VALUES ( :al_filial, :al_pedido, :al_nr_volume,   :al_produto, :as_endereco, :lvs_lote) 
				Using SqlCa;
				
				If SqlCa.SqlCode = -1 Then
					SqlCa.of_MsgDbError("Erro ao incluir os dados enviados ao PAD Picking na wms_lista_separacao_prd_pick")
					SqlCa.of_RollBack();
					Return False
				End If
			End If
			
			lvs_Json_lote	+='{'
			lvs_Json_lote	+= '"lote":"'+lvs_lote+'"'					
			lvs_Json_lote	+=','
			lvs_Json_lote	+= '"validade":"'+lvs_validade+'"'					
			
			If ll_linha < ll_Linhas	Then
				lvs_Json_lote	+='},'
			Else
				lvs_Json_lote	+='}'			
			End If
		Next
	End If 
	
	// Fim Arquivo
	lvs_Json_lote	+=']'
	as_json_produtos_lotes  = lvs_Json_lote
		
	If IsNull(as_json_produtos_lotes) Then 
		MessageBox("Aviso", "PadPicking: Erro nos dados de lote do arquivo")
		Return False		
	End If 
	
	
Finally
	Destroy(lds_prd_lotes)
End try

Return True
end function

public function boolean of_carrega_retorno_separacao_lote (ref dc_uo_ds_base ads_lista_retorno_lotes, ref uo_ge512_json as_json, ref any as_data[], long as_linha, ref string as_log);Any la_data,la_null
Long ll_Count, ll_For, ll_Linha

ll_Count = UpperBound(as_Data)

For ll_For = 1 To ll_Count
			
		la_data = la_null	
		if not as_Json.retrieve("listaItens/"+String(as_Linha)+"/listaLotes/"+String(ll_For)+"/lote", ref la_data) then
			as_Log = "Retrieve Tag 'lote' (null)"
			Return False
		else
			is_nr_lote = String(la_data)
		end if
		
		la_data = la_null
		//ou "valida$$HEX2$$e700e300$$ENDHEX$$o"
		if not as_Json.retrieve("listaItens/"+String(as_Linha)+"/listaLotes/"+String(ll_For)+"/validade", ref la_data) then
			as_Log = "Retrieve Tag 'validade' (null)"
			Return False
		else
			idt_validade = Date(la_data)
		end if
		
		la_data = la_null	
		if not as_Json.retrieve("listaItens/"+String(as_Linha)+"/listaLotes/"+String(ll_For)+"/quantidadeSeparada", ref la_data) then
			as_Log = "Retrieve Tag 'quantidadeSeparada' (null)"
			Return False
		else
			il_qt_separada_lote = Long(la_data)
		end if
		
//		PARA POSSIVEL NECESSIDADE DE ALTERACAO		
//		If il_cd_produto = 735421   Then 
//				il_cd_produto = 735421 
// 				is_nr_lote   =  'CKP03750'
//		 		idt_validade = 2024-02-01
//		End If 
		
		
		
		ll_Linha = ads_lista_retorno_lotes.insertrow( 0 )
		// Campos Chave
		ads_lista_retorno_lotes.object.qt_separada_lote[ll_Linha]	= il_qt_separada_lote
		ads_lista_retorno_lotes.object.nr_lote[ll_Linha] 				= is_nr_lote
		ads_lista_retorno_lotes.object.dt_validade[ll_Linha] 			= String(idt_validade)
		// Demais Campos
		ads_lista_retorno_lotes.object.cd_endereco[ll_Linha] 		= is_cd_endereco
		ads_lista_retorno_lotes.object.cd_produto[ll_Linha] 			= il_cd_produto
		ads_lista_retorno_lotes.object.cd_filial[ll_Linha] 				= il_cd_filial
		ads_lista_retorno_lotes.object.nr_pedido[ll_Linha] 			= il_nr_pedido
		ads_lista_retorno_lotes.object.nr_volume[ll_Linha] 			= il_nr_volume	
		ads_lista_retorno_lotes.object.de_endereco_flow_rack[ll_linha] = is_cd_endereco_completo		
	Next

Return True
end function

public function boolean of_verifica_pad_picking (long al_filial, long al_pedido, long al_volume);Long ll_Qtd


Select  count(*)
Into :ll_Qtd
From wms_integracao_picking a
Inner join wms_lista_separacao b 
On		b.cd_filial = a.cd_filial
And	b.nr_pedido_distribuidora = a.nr_pedido_distribuidora
And 	b.nr_volume = b.nr_volume
Where b.dh_exportacao is not null 
And b.cd_filial=:al_filial
And b.nr_pedido_distribuidora=:al_pedido
And b.nr_volume =:al_volume
//And a.cd_integracao = '1'
//And a.cd_tipo = 'E'
Using SqlCA;

Choose Case Sqlca.Sqlcode
	Case 0
		If ll_Qtd <= 0 Then			
			Return True
		Else 			
			Return False
		End If
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao verificar a integra$$HEX2$$e700e300$$ENDHEX$$o"+Sqlca.SqlErrText)
		Return False
End Choose

Return  True 

end function

public function boolean of_carrega_retorno_separacao (string as_json, ref string as_log);Boolean	lb_verifica = false

String ls_info_itens
String ls_json_restante
String ls_valor
String ls_valor_tag
String ls_retorno
String ls_info_valores_lotes
String ls_info_valores_Itens
String ls_nr_etiqueta_fixa
String ls_nr_lacre1
String ls_nr_lacre2
String ls_Error

Long ll_Linha
Long ll_Count
Long ll_For
Long ll_Chave_Volume
Long ll_cd_esteira

DateTime ldh_Conf
DateTime ldh_Conf_ini

Any la_Data, la_Null

// Instaicia Objeto
uo_ge512_Json ln_Json
ln_Json = create uo_ge512_Json

//Clear
ids_lista_retorno.reset()
ids_lista_retorno_lotes.reset()
	
Try
	
	ls_error = ln_json.parse(as_json)
	
	//check for parse error
	if ls_error <> "" then
		as_log = "Parse error: " + ls_error
		Return False
	end if
	
	//working with parsed data
	 if not ln_json.retrieve("numPicking", ref la_data) then
		as_log = "Retrieve grupo 'numPicking' (null)"
		Return False
	 else
		
		ll_Chave_Volume = Long(la_data)
		
		select cd_filial,
				 nr_pedido_distribuidora, 
				 nr_volume,
				 cd_esteira,
				 nr_etiqueta_fixa,
				 nr_lacre1,
				 nr_lacre2
		  Into :il_cd_filial, 
			    :il_nr_pedido, 
				 :il_nr_volume,
				 :ll_cd_esteira,
				 :ls_nr_etiqueta_fixa,
				 :ls_nr_lacre1,
				 :ls_nr_lacre2
		from wms_lista_separacao
		where nr_chave_volume = :ll_Chave_Volume
		Using SqlCa;
		
		Choose Case SqlCa.SqlCode
			Case 0 
				if not gf_esteira_verifica_lacre_vol(ll_cd_esteira, il_cd_filial, ref lb_verifica, ref as_log) then
					Return False
				end if
			Case 100
				as_log = "Volume n$$HEX1$$e300$$ENDHEX$$o foi localizado para a chave [" + String(ll_Chave_Volume) + "]"
				Return False
			Case -1 
				SqlCa.of_MsgDbError("Erro ao localizar o chave do volume na lista de separa$$HEX2$$e700e300$$ENDHEX$$o")
				as_log = "Erro ao localizar o chave do volume na lista de separa$$HEX2$$e700e300$$ENDHEX$$o"
				Return False
		End Choose
	
		 //il_cd_filial = Long(MidA(la_data , 2, 4) )
		 //il_nr_pedido = LongLong(MidA(la_data , 6, 10) )
		 //il_nr_volume = Long(MidA(la_data , 16, 3) )
	 end if
	 
	 //Campo novo no json, situacao
	 la_data = la_null
	 If Not ln_json.retrieve("situacao", Ref la_data) Then
		as_log = "Retrieve grupo 'situacao' (null)"
		Return False
	Else
		is_Situacao_Cabecalho = String(la_Data)
	End If
	
	if lb_verifica then
		la_data = la_null
		If Not ln_json.retrieve("numCaixa", Ref la_data) Then
			as_log = "Retrieve grupo 'numCaixa' (null)"
			Return False
		Else
			is_etiq_caixa = String(la_Data)
		End If
		
		la_data = la_null
		If Not ln_json.retrieve("numLacreDireito", Ref la_data) Then
			as_log = "Retrieve grupo 'numLacreDireito' (null)"
			Return False
		Else
			is_nr_lacre1 = String(la_Data)
		End If
		
		la_data = la_null
		If Not ln_json.retrieve("numLacreEsquerdo", Ref la_data) Then
			as_log = "Retrieve grupo 'numLacreEsquerdo' (null)"
			Return False
		Else
			is_nr_lacre2 = String(la_Data)
		End If
	end if
	
//	If ls_Situacao <> "F" Then
//		as_log = "Pedido ainda n$$HEX1$$e300$$ENDHEX$$o confererido"
//		Return False
//	End If
	 
	 la_data = la_null
	 if not ln_json.retrieve("listaItens", ref la_data) then
		as_log = "Retrieve grupo 'listaItens' (null)"
		Return False
	else
			
		ll_Count = upperbound(la_data)
		For ll_For=1 To ll_Count
			
			la_data = la_null
			if not ln_json.retrieve("listaItens/"+String(ll_For)+"/numEndereco", ref la_data) then
				as_log = "Retrieve Tag 'numEndereco' (null)"
				Return False
			else
				is_cd_endereco = String(la_data)
			end if
			
			la_data = la_null			
			if not ln_json.retrieve("listaItens/"+String(ll_For)+"/codSKU", ref la_data) then
				as_log = "Retrieve Tag 'codSKU' (null)"
				Return False
			else
				il_cd_produto = Long(la_data)
			end if
			
			la_data = la_null	
			if not ln_json.retrieve("listaItens/"+String(ll_For)+"/quantidade", ref la_data) then
				as_log = "Retrieve Tag 'quantidade' (null)"
				Return False
			else
				il_qt_pedido = Long(la_data)
			end if
			
			la_data = la_null	
			if not ln_json.retrieve("listaItens/"+String(ll_For)+"/quantidadeSeparada", ref la_data) then
				as_log = "Retrieve Tag 'quantidadeSeparada' (null)"
				Return False
			else
				il_qt_separada = Long(la_data)
			end if
			
			// Alterado devido a altera$$HEX2$$e700e300$$ENDHEX$$o do EAN, estamos enviado mais de um EAN para um mesmo produto
//			la_data = la_null	
//			if not ln_json.retrieve("listaItens/"+String(ll_For)+"/ean", ref la_data) then
//				as_log = "Retrieve Tag 'ean' (null)"
//				Return False
//			else
//				il_nr_ean = LongLong(la_data)
//			end if
			
			la_data = la_null	
			if not ln_json.retrieve("listaItens/"+String(ll_For)+"/situacao", ref la_data) then
				as_log = "Retrieve Tag 'situacao' (null)"
				Return False
			else
				is_situacao = String(la_data)
			end if
			
			la_data = la_null	
			if not ln_json.retrieve("listaItens/"+String(ll_For)+"/usuario", ref la_data) then
				as_log = "Retrieve Tag 'usuario' (null)"
				Return False
			else
				is_matricula = String(la_data)
			end if	
			
			If is_matricula = '123' Then
				is_matricula = is_Usuario_PadPicking  // Pad Picking 
			End If

			///Valida existencia da matricula de usuario
			If Not f_ge512_existe_usuario(is_matricula, REF is_matricula, REF as_log) then
				If IsNull(is_matricula) or is_matricula = 'MFC' Then 
					is_matricula = is_Usuario_PadPicking  // Pad Picking
				End If 
			End if
			
			la_data = la_null	
			if not ln_json.retrieve("listaItens/"+String(ll_For)+"/dataFinalizacao", ref la_data) then
				as_log = "Retrieve Tag 'dataFinalizacao' (null)"
				Return False
			else
				ldh_Conf = DateTime(la_data)
			end if	
			
			la_data = la_null	
			if not ln_json.retrieve("listaItens/"+String(ll_For)+"/dataInicializacao", ref la_data) then
				as_log = "Retrieve Tag 'dataInicializacao' (null)"
				Return False
			else
				ldh_Conf_ini = DateTime(la_data)
			end if	
			
//			If il_cd_produto = 742002 Then 
//				il_cd_produto = 742002
//				Continue 
//			End If 	
			
			
			// Armazena os dados na DW para processos...
			ll_Linha = ids_lista_retorno.insertrow( 0 )
			
			if is_situacao = 'P' and il_qt_pedido - il_qt_separada = 0 then is_situacao = 'F'
			
			ids_lista_retorno.object.nr_linha[ll_linha] 				= ll_Linha
			ids_lista_retorno.object.cd_produto[ll_linha] 			= il_cd_produto
			ids_lista_retorno.object.ean[ll_linha] 					= String(il_nr_ean)
			ids_lista_retorno.object.cd_filial[ll_linha] 			= il_cd_filial
			ids_lista_retorno.object.nr_pedido[ll_linha] 			= il_nr_pedido
			ids_lista_retorno.object.nr_volume[ll_linha] 			= il_nr_volume
			ids_lista_retorno.object.cd_endereco[ll_linha] 			= is_cd_endereco
			ids_lista_retorno.object.qt_pedido[ll_linha] 			= il_qt_pedido
			ids_lista_retorno.object.qt_separada[ll_linha]			= il_qt_separada
			ids_lista_retorno.object.qt_divergencia[ll_linha]		= (il_qt_pedido - il_qt_separada)	
			ids_lista_retorno.object.nr_matricula[ll_linha]			= is_matricula
			ids_lista_retorno.object.situacao[ll_linha]				= is_situacao
			ids_lista_retorno.object.dh_conferencia[ll_linha]		= ldh_Conf
			ids_lista_retorno.object.dh_ini_conferencia[ll_linha]	= ldh_Conf_ini
			
			// Retorna o Endere$$HEX1$$e700$$ENDHEX$$o Completo			
			If Not This.of_verifica_endereco_completo(is_cd_endereco,il_cd_produto,  Ref is_cd_endereco_completo, Ref as_log ) Then 
				Return False
			End If 
			
			ids_lista_retorno.object.de_endereco_flow_rack[ll_linha] = is_cd_endereco_completo
			
			la_data = la_null	
			If Not ln_json.retrieve("listaItens/"+String(ll_For)+"/listaLotes", ref la_data) Then
				as_log = "Retrieve Tag 'listaLotes' (null)"
			Else
				//Carrega lotes do $$HEX1$$cd00$$ENDHEX$$tem
				If Not This.of_carrega_retorno_separacao_lote(ref ids_lista_retorno_lotes, ref ln_json ,  ref la_data, ll_For, as_log) Then
					Return False
				End If
				
			End If
			
		Next
		
		///   **************** GERA EXCEL:  AQUI SERVE PARA VALIDAR QUANDO PRECISAR ************************* 
		///ids_lista_retorno.SaveAs("C:\TEMP\RETORNO_PED" + String(il_nr_pedido) + '_' + String(il_nr_volume) + "_"  + String(Today(), "ddmmyyyyhhmm") + ".XLSX" ,XLSX!, TRUE)
		////ids_lista_retorno_lotes.SaveAs("C:\TEMP\RETORNO_PED_LT" + String(il_nr_pedido) + '_' + String(il_nr_volume) + "_"  + String(Today(), "ddmmyyyyhhmm") + ".XLSX" ,XLSX!, TRUE)
		
	 End If
	
Finally 
	Destroy(ln_json)
End Try


Return True
end function

public function boolean of_processa_atualizacao_envio (long al_filial, long al_pedido, long al_volume, string as_picking, string as_json_retorno, string as_json, ref string as_cd_retorno, ref string as_de_retorno);String lvs_numpicking,&
		lvs_ds_status_code,&
		lvs_json,&
		lvs_erro,&
		lvs_Cod_Retorno,&
		lvs_Ds_Retorno,&
		lvs_datahora


Long ll_Linha,&
		ll_Linhas,&
		ll_filial,&
		ll_nr_pedido,&
		ll_nr_volume,&
		ll_cd_status_code,&
		ll_Qtd

	
Datetime ldh_data

ldh_data  = DateTime(Today(), Now()) 
lvs_datahora =  String  (ldh_data, "yyyy-mm-dd hh:mm:ss")


ll_filial 			= al_filial
ll_nr_pedido 	= al_pedido
ll_nr_volume 	= al_volume
lvs_numpicking	= as_picking
lvs_json = as_json
	
// Codigo do Retorno para Atualizacao : LOG
If Not This.of_retorna_status('E', as_json_retorno, Ref lvs_Cod_Retorno,  Ref lvs_Ds_Retorno) Then 
	MessageBox("Erro", "PadPicking: Buscar Status de Retorno")
	Return False
End If 

// Para gravar o erro e n$$HEX1$$e300$$ENDHEX$$o o json montado
If lvs_Cod_Retorno <> '1' And lvs_Cod_Retorno <> '902' Then lvs_json = as_json_retorno


//// VER SOBRE IMPRESSAO GELADEIRA. ATUALIZA OUTRO CAMPO  ??????
		
// Atualiza Sempre Tabela de Log : wms_integracao_picking
If Not This.of_atualiza_tabela_log(lvs_numpicking, ll_filial ,ll_nr_pedido ,ll_nr_volume, 'E', lvs_Cod_Retorno , lvs_Ds_Retorno  , lvs_json) Then 
	MessageBox("Erro", "PadPicking: Atualizar Tabela Monitor Integracao")
	Return False		
End If		

/// Sucesso no Envio Atualiza WMS - Clamed	
If lvs_Cod_Retorno = '1' Or lvs_Cod_Retorno = '902' Then   
	// Atualiza Lista Separacao : Exporta$$HEX2$$e700e300$$ENDHEX$$o : Inicio
	If Not This.of_atualiza_lista_separacao(ll_nr_pedido, ll_filial, ll_nr_volume, 'E', ref lvs_erro) Then 
		//MessageBox("Erro", "PadPicking: Erro atulizar Lista de Separacao")
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvs_erro)
		Return False
	End If 	
	
	/// Atualiza Confer$$HEX1$$ea00$$ENDHEX$$ncia Romaneio
	If Not This.of_grava_conferencia_romaneio(ll_nr_pedido, ll_filial, ll_nr_volume ) Then 
		MessageBox("Erro", "PadPicking: Erro atualizar Romaneio Conferencia")
		Return False
	End If 
End If 

as_cd_retorno = lvs_Cod_Retorno
as_de_retorno = lvs_Ds_Retorno


SqlCa.of_Commit()		
Return True 

end function

public function boolean of_envia_email_erro (string as_mensagem);String	ls_Msg
s_email lst_Email					

ls_Msg =	"Aten$$HEX2$$e700e300$$ENDHEX$$o!<br><br>" +&
			"Recebimento da confer$$HEX1$$ea00$$ENDHEX$$ncia via SmartPicking.<br><br>"+&
			"Descri$$HEX2$$e700e300$$ENDHEX$$o: "+as_mensagem+"<br>"	

lst_Email.ps_mensagem	= ls_Msg
lst_Email.pb_assinatura = True

If Not gf_ge202_envia_email_padrao(226, lst_Email)	Then
	Return False
End If
			
Return True
end function

public function boolean of_processa_atualizacao_retorno (ref string as_erro);Long ll_Find
Long  ll_Find_Inicio

String lvs_volume
String lvs_produto
String lvs_pedido
String lvs_endereco
String lvs_nr_matricula
String ls_Situacao_Prd

Long ll_filial
Long ll_pedido
Long ll_volume

DateTime ldh_Conferencia

ids_lista_retorno.SetSort("cd_endereco A")
ids_lista_retorno.Sort()

//// is_situacao = "P"  -  Significa que esta pendente o picking e que n$$HEX1$$e300$$ENDHEX$$o foi pego nenhuma quantidade para o produto. N$$HEX1$$e300$$ENDHEX$$o devemos seguir no processo, e na proxima execu$$HEX2$$e700e300$$ENDHEX$$o pode estar como F.
//// is_situacao = "F"  -  Significa que esta finalizado o piking para aquele produto/lote. Exemoplo : Se tem 7 para separar e foi pego 4 e situacao F seguimos no nosso processo.
ll_find 			= ids_lista_retorno.Find(" situacao = 'P' ", 1, ids_lista_retorno.rowcount())
ll_Find_Inicio    = ids_lista_retorno.Find(" situacao = 'F' ", 1, ids_lista_retorno.rowcount()) 

// Atualiza O Inicio da Confer$$HEX1$$ea00$$ENDHEX$$ncia
If ll_Find_Inicio >0 Then 
	
	ll_filial 			= ids_lista_retorno.object.cd_filial[ll_Find_Inicio] 
	ll_pedido 			= ids_lista_retorno.object.nr_pedido[ll_Find_Inicio] 
	ll_volume 			= ids_lista_retorno.object.nr_volume[ll_Find_Inicio]
	lvs_nr_matricula	= String(ids_lista_retorno.object.nr_matricula[ll_Find_Inicio])
	ldh_Conferencia	= ids_lista_retorno.object.dh_conferencia[ll_Find_Inicio]
	ls_Situacao_Prd	= ids_lista_retorno.object.situacao[ll_Find_Inicio]
	
	// pegar a rua que foi conferida por primeiro
	
	If is_Situacao_Cabecalho = "F" Or (is_Situacao_Cabecalho = "P" And ls_Situacao_Prd = "F" And ll_Find_Inicio = 1) Then
		// Atualiza Inicio
		Update wms_lista_separacao
		Set  dh_inicio_conferencia			=:ldh_Conferencia ,  
			  nr_matricula_conferente		=:is_Usuario_PadPicking,
			  nr_etiqueta_fixa				=:is_etiq_caixa,
			  nr_lacre1							=:is_nr_lacre1,
			  nr_lacre2							=:is_nr_lacre2,
			  nr_matricula_lacres			=:is_Usuario_PadPicking
		Where	cd_filial					  	=:ll_filial
		And		nr_pedido_distribuidora	=:ll_pedido
		And		nr_volume				  	=:ll_volume 
		And		(dh_inicio_conferencia is null  or :ldh_Conferencia < dh_inicio_conferencia)
		Using SqlCA;
		
		If SqlCa.SqlCode = - 1 Then
			as_erro = "Erro Atualiza$$HEX2$$e700e300$$ENDHEX$$o Data Inicio Conferencia: "+Sqlca.sqlErrText
			SqlCa.of_Rollback()
			Return False
		End If	
		
		// S$$HEX1$$f300$$ENDHEX$$ para garantir que o n$$HEX1$$e300$$ENDHEX$$o deu erro em nenhum dos FINDS.
		If ll_Find <> -1 Then
			If Sqlca.SQLNRows = 1 Then
				SqlCa.of_Commit();
			End If
		End If
	End If
End If 

// Para Mensagem de Pendente/Gravar no Log
If ll_Find <> 0 Then 
	lvs_volume 			=  String(ids_lista_retorno.object.nr_volume[ll_find])
	lvs_pedido 			=  String(ids_lista_retorno.object.nr_pedido[ll_find])
	lvs_produto			=  String(ids_lista_retorno.object.cd_produto[ll_find])
	lvs_endereco 		=  String(ids_lista_retorno.object.cd_endereco[ll_find])
End If 

Choose Case ll_find
	Case -1 
		as_erro = "Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_retorno - Erro no find {situacao = 'P'} da ids_lista_retorno"
		SqlCa.of_Rollback()
		Return False
		
	Case 0
		// 1- Atualiza QT_SEPARADA e QT_DIVERGENCIA na tabela - WMS_LISTA_SEPARACAO_PRODUTO
		// 2 - Atualiza a baixa da reserva na tabela - WMS_RESERVA_FLOW_RACK
		If Not This.of_atualiza_qtde_separada( ref ids_lista_retorno, ref as_erro) Then
			SqlCa.of_Rollback()
			Return False
		End If
		
		//Atualiza QT_SEPARADA dos Lotes
		// 1 - Grava o lote na tabela WMS_LISTA_SEPARACAO_PRD_LOTE
		// 2 - Localiza o sequencial na tabela WMS_LOCALIZACAO, e grava o MOVIMENTO no WMS
		If Not This.of_atualiza_qtde_separada_lote( ref ids_lista_retorno_lotes, ref as_erro) Then
			SqlCa.of_Rollback()
			Return False
		End If

		//Atualiza QT_SEPARADA e QT_DIVERGENCIA
		If Not This.of_lotes_produtos_nao_controlados( ref ids_lista_retorno, ref ids_lista_retorno_lotes, ref as_erro) Then
			SqlCa.of_Rollback()
			Return False
		End If
		
		// Verifica se a quantidade separada no cabe$$HEX1$$e700$$ENDHEX$$alho do endere$$HEX1$$e700$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ igual ao dos lotes
		If Not This.of_consiste_dados(ll_filial, ll_Pedido, ll_Volume,ref as_erro) Then Return False
		
		//Finaliza Conferencia
		If Not This.of_termina_conferencia( ids_lista_retorno, ref as_erro) Then
			as_erro = "Fun$$HEX2$$e700e300$$ENDHEX$$o: of_termina_conferencia - Erro: " + as_erro
			Return False
		End If

	Case Else
		
		//Precisa que todos os produtos estejam como "F"
		// VAI GRAVAR NO LOG E N$$HEX1$$c300$$ENDHEX$$O CONTINUARA
		as_erro = "Pendente Separacao: Produto:"+String(lvs_Produto)+" Endereco:" +String(lvs_endereco)+ " Pedido:" + String(lvs_pedido)+" Volume:"+String(lvs_volume)
		Return False
End Choose

Return True 
end function

public function boolean of_atualiza_qtde_separada (ref dc_uo_ds_base ads_lista_retorno, ref string as_erro);Long ll_For
Long ll_Count
DateTime ldh_Conferencia
DateTime ldh_ini_Conferencia

ll_count = ads_lista_retorno.rowcount()
For ll_for = 1 to ll_count
	
	il_cd_produto	= ads_lista_retorno.object.cd_produto[ll_for]
	il_cd_filial		= ads_lista_retorno.object.cd_filial[ll_for]
	il_nr_pedido		= ads_lista_retorno.object.nr_pedido[ll_for]
	il_nr_volume	= ads_lista_retorno.object.nr_volume[ll_for]
//	is_cd_endereco= ads_lista_retorno.object.cd_endereco[ll_for]
	is_cd_endereco= ads_lista_retorno.object.de_endereco_flow_rack[ll_for]
	il_qt_separada	= ads_lista_retorno.object.qt_separada[ll_for]
	is_matricula		= ads_lista_retorno.object.nr_matricula[ll_for]
	ldh_Conferencia = ads_lista_retorno.object.dh_conferencia[ll_for]
	ldh_ini_Conferencia = ads_lista_retorno.object.dh_ini_Conferencia[ll_for]
	

	
//	If il_cd_produto = 692321 Then 
//		String teste
//		teste = "ts"
//	End If 
	
	/// Atualiza QT_SEPARADA e QT_DIVERGENCIA
	as_erro = ''
	If Not This.of_atualiza_qtde_separada_produto (il_nr_pedido, il_cd_filial, il_nr_volume, il_cd_produto, &
																  is_cd_endereco, il_qt_separada, is_matricula, ref as_erro, &
																  ldh_Conferencia, ldh_ini_Conferencia) Then
		Return False
	End If	
	
	as_Erro = ''
	// Atualiza baixa reserva
	If not This.of_baixa_reserva( il_cd_produto, is_cd_endereco, il_qt_separada, as_Erro) Then
		SqlCa.of_Rollback()
		Return False
	End iF
	
Next

Return True

end function

public function boolean of_atualiza_qtde_separada_pedido (long al_pedido, long al_filial, long al_produto, integer ai_qtde, ref string as_erro);////atualiza qtde separada pedido... ATUALIZA A PEDIDO DISTRIBUIDORA 

Update pedido_distribuidora_produto
Set qt_separada = coalesce(qt_separada,0) + :ai_qtde
Where cd_filial 							= :al_Filial
	And nr_pedido_distribuidora 	= :al_Pedido
	And cd_produto 					= :al_Produto
Using SqlCa;

If  Sqlca.Sqlcode = -1	 Then
	as_Erro = "Erro ao finalizar a confer$$HEX1$$ea00$$ENDHEX$$ncia: "+SqlCa.SqlErrText
	SqlCa.of_RollBack();
	Return False
End If

Return True
end function

public function boolean of_insere_lote (long al_pedido, long al_filial, long al_volume, long al_produto, string as_endereco, string as_lote, integer ai_separada, ref string as_erro);String ls_Achou

//If al_produto = 692048 Then
//	al_produto = 692048
//End If

Select nr_lote
  Into :ls_Achou
  From wms_lista_separacao_prd_lote
 Where cd_filial 						= :al_Filial
  	and nr_pedido_distribuidora	= :al_Pedido
  	and cd_produto						= :al_produto
	and nr_volume						= :al_volume
	and cd_endereco_localizacao 	= :as_endereco
  	and nr_lote							= :as_Lote
Using SqlCa;

Choose Case SqlCa.Sqlcode
		
	Case 0
		
		UPDATE wms_lista_separacao_prd_lote  
     		SET qt_lote                 = qt_lote + :ai_separada
		 Where cd_filial					 = :al_Filial
		   and nr_pedido_distribuidora = :al_Pedido
			and cd_produto 				 = :al_Produto
			and nr_volume					 = :al_volume
			and cd_endereco_localizacao = :as_endereco
			and nr_lote						 = :as_Lote
       Using SqlCa;
		
		If SqlCa.SqlCode = - 1 Then
			as_Erro = "Erro ao Atualizar o Produto/Lote/Endreco:"+String(al_Produto)+"/"+String(as_Lote)+"/"+String(as_endereco)+"lote: "+Sqlca.sqlErrText
			SqlCa.of_RollBack();
			Return False
		End If
		
	Case 100
		
		INSERT INTO wms_lista_separacao_prd_lote 
		          (	cd_filial
					 ,	nr_pedido_distribuidora
					 ,	cd_produto
					 ,	nr_volume
					 ,	cd_endereco_localizacao
					 ,	nr_lote
					 ,	qt_lote 
					 )  
		     VALUES 
			       ( :al_Filial
					 , :al_Pedido
					 ,	:al_Produto
					 ,	:al_volume
					 ,	:as_endereco
					 ,	:as_Lote
					 ,	:ai_separada
					 )
		      Using SqlCa;
		
		If SqlCa.SqlCode = - 1 Then
			as_Erro = "Erro ao Inserir o Produto/Lote/Endereco: "+String(al_Produto)+"/"+String(as_Lote)+"/"+String(as_endereco)+"lote: "+Sqlca.sqlErrText
			SqlCa.of_RollBack();
			Return False
		End If

	Case -1
		as_Erro = "Erro ao localizar o Produto/Lote/Endereco: "+String(al_Produto)+"/"+String(as_Lote)+"/"+String(as_endereco)+"lote: "+Sqlca.sqlErrText
		SqlCa.of_RollBack();
		Return False
End Choose

Return True
end function

public function boolean of_insere_lotes_pedido_old (long al_filial, long al_pedido, long al_volume, string as_erro);//Long 	ll_linha,&
//		ll_Linhas,&
//		ll_Produto,&
//		ll_Qtde,&
//		ll_Qt_Cx_Padrao,&
//		ll_Sequencial,&
//		ll_Saldo
//		
//String 	ls_Lote,&
//			ls_lote_Select,&
//			ls_Endereco,&
//			ls_Grupo_Psico,&
//			ls_Anexo[]
//			
//Date ldh_Validade
//dc_uo_ds_base lds
//
//Try
//	
//	lds = Create dc_uo_ds_base
//	
//	If Not lds.of_ChangeDataObject("dw_ws018_lista_lote_finalizar") Then
//		as_Erro = "Erro ao criar a 'dw_ws018_lista_lote_finalizar'"
//		Return False
//	End If
//	
//	ll_Linhas = lds.Retrieve(al_filial, al_pedido, al_volume)
//	
//	If (ll_Linhas < 0) or IsNull(ll_Linhas) Then
//		MessageBox("Erro", "Erro no retrieve da fun$$HEX2$$e700e300$$ENDHEX$$o 'wf_insere_lotes_pedido'.")	
//		Return False
//	End If
//	
//	For ll_Linha = 1 To ll_Linhas
//		
//		ll_Produto 			= lds.Object.cd_produto[ll_Linha]
//		ls_Lote				= Trim(lds.Object.nr_lote[ll_Linha])
//		ll_Qtde				= lds.Object.qt_lote[ll_Linha]
//		ls_Endereco			= lds.Object.cd_endereco_localizacao[ll_Linha]
//		//ll_Qt_Cx_Padrao	= lds.Object.qt_caixa_padrao[ll_Linha]
//		//ll_Sequencial		= lds.Object.nr_sequencial[ll_Linha]
//		//ldh_Validade		= Date(lds.Object.dh_validade[ll_Linha])
//		ls_Grupo_Psico		= lds.Object.cd_grupo_psico[ll_Linha]
//		
//		If Not IsNull(ls_Grupo_Psico) and ls_Grupo_Psico <> "" Then
//			select  	top 1 
//						isnull(nr_sequencial, 1) as nr_sequencial,
//						isnull(qt_caixa_padrao, 1) as qt_caixa_padrao,
//						dh_validade ,
//						isnull(qt_saldo, 0) qt_saldo
//			Into 	: ll_Sequencial, 
//					:ll_Qt_Cx_Padrao, 
//					:ldh_Validade, 
//					:ll_Saldo	  
//			from wms_localizacao
//			where cd_endereco 	= :ls_Endereco
//			and cd_produto			= :ll_Produto
//			and nr_lote				= :ls_Lote
//			and qt_saldo			>= :ll_Qtde 
//			Using SqlCa;
//			
//			Choose Case SqlCa.Sqlcode
//				Case -1
//					as_Erro = "Erro ao localizar o lote: "+Sqlca.sqlErrText
//					Return False
//					
//				Case 100
//					as_Erro = "Produto "+String(ll_Produto)+ " n$$HEX1$$e300$$ENDHEX$$o localizado no endere$$HEX1$$e700$$ENDHEX$$o "+ls_Endereco
//					Return False				
//			End Choose
//			
//		Else
//			ll_Saldo = ll_Qtde
//			
//			Select 	top 1 
//						qt_caixa_padrao,
//						nr_sequencial,
//						dh_validade
//			Into		:ll_Qt_Cx_Padrao,
//						:ll_Sequencial,
//						:ldh_Validade
//			From wms_localizacao
//			Where cd_endereco 	= :ls_Endereco
//				and cd_produto 	= :ll_Produto
//				and nr_lote 			= :ls_Lote
//			Using SqlCa;	
//			
//			Choose Case SqlCa.Sqlcode
//				Case 100
//					ll_Qt_Cx_Padrao 	= 1
//					ll_Sequencial 		= 1
//					ldh_Validade 		= Date(gf_GetServerDate())
//					gf_ge202_envia_email_automatico(5, "Log Confer$$HEX1$$ea00$$ENDHEX$$ncia volumes", "N$$HEX1$$e300$$ENDHEX$$o foi localizado o produto '"+String(ll_Produto)+"', lote '"+string(ls_Lote)+"' no endere$$HEX1$$e700$$ENDHEX$$o '"+ls_Endereco+"'.", ls_Anexo)
//				Case -1
//					gf_ge202_envia_email_automatico(5, "Log Confer$$HEX1$$ea00$$ENDHEX$$ncia volumes", "Erro ao localizar o produto no endere$$HEX1$$e700$$ENDHEX$$o. Produto '"+String(ll_Produto)+"', lote '"+string(ls_Lote)+"' no endere$$HEX1$$e700$$ENDHEX$$o '"+ls_Endereco+"': ~r"+Sqlca.sqlErrText, ls_Anexo)
//					Return False
//			End Choose	
//			
//		End If
//		
//		If ll_Saldo >= ll_Qtde Then
//			
//			Integer li_Retorno
//			li_Retorno = gf_wms_verifica_trigger()
//			If li_Retorno = -1 Then 
//				SqlCa.of_Rollback()					
//				Return False
//			End If
//			
//			// N$$HEX1$$e300$$ENDHEX$$o tiver a trigger
//			If li_Retorno = 0 Then 
//		
//				Select nr_lote
//				Into :ls_lote_Select
//				From pedido_distribuidora_prd_lote
//				Where cd_filial 						= :al_Filial
//				and nr_pedido_distribuidora 	= :al_Pedido
//				and cd_produto 					= :ll_Produto
//				and nr_lote 							= :ls_Lote
//				Using SqlCa;
//								
//				Choose Case SqlCa.Sqlcode
//					Case 0
//						
//						  UPDATE pedido_distribuidora_prd_lote  
//							SET   qt_lote =   qt_lote +  :ll_Qtde
//						  Where	cd_filial						= :al_Filial
//							 and 	nr_pedido_distribuidora 	= :al_Pedido
//							 and 	cd_produto 					= :ll_Produto
//							 and	nr_lote						= :ls_Lote
//						Using SqlCa;
//						
//						If SqlCa.SqlCode = - 1 Then
//							as_Erro = "Erro ao atualizar o lote: "+Sqlca.sqlErrText
//							SqlCa.of_Rollback()
//							Return False
//						End If
//						
//					Case 100
//						
//						INSERT INTO pedido_distribuidora_prd_lote(
//										cd_filial, 
//										nr_pedido_distribuidora,  
//										cd_produto,
//										nr_lote, 
//										qt_lote )  
//						VALUES ( 	:al_Filial, 
//										:al_Pedido, 
//										:ll_Produto, 
//										:ls_Lote, 
//										:ll_Qtde)
//						Using SqlCa;
//						
//						If SqlCa.SqlCode = - 1 Then
//							as_Erro = "Erro ao inserir o lote: "+Sqlca.sqlErrText
//							SqlCa.of_Rollback()					
//							Return False
//						End If
//				
//					Case -1
//						as_Erro = "Erro ao localizar o lote: "+Sqlca.sqlErrText
//						Return False
//				End Choose
//			End If // Sem trigger
//			
//			//Movimento de saida do flowRack
//			If Not of_movimento_saida_flowrack(	ls_Endereco,&
//																ll_Produto,&
//																ll_Qt_Cx_Padrao,&
//																ls_Lote,&
//																ldh_Validade,&
//																ll_Qtde,&
//																ll_Sequencial,&
//																al_Filial,&
//																"",&
//																Ref as_Erro) Then
//				Return False
//			End If
//
//		End If	
//		
//	Next
//	
//Finally
//	Destroy(lds)
//End Try
//
Return True
end function

public function boolean of_baixa_reserva (long al_produto, string as_endereco, integer ai_separada, ref string as_erro);// Chamado: 1504787 - Resolver Problema de Lock no WMS
Return True

//Long ll_Reserva, ll_Qt_Sobra

//Select qt_reserva
//Into :ll_Reserva
//From wms_reserva_flow_rack
//Where cd_endereco 	= :as_Endereco
//	and cd_produto 	= :al_Produto
//Using SqlCa;
//
//Choose Case Sqlca.Sqlcode
//	Case 0
//		ll_Qt_Sobra = ll_Reserva - ai_separada
//		
//		If ll_Qt_Sobra < 1 Then
//			
//			Delete From wms_reserva_flow_rack
//			Where cd_endereco = :as_Endereco
//				and cd_produto = :al_Produto
//			Using SqlCa;
//			
//			Choose Case Sqlca.Sqlcode
//				Case -1	
//					as_Erro = "Erro no delete da 'wms_reserva_flow_rack': "+SqlCa.SqlErrText
//					SqlCa.of_Rollback();
//					Return False
//			End Choose	
//			
//		Else
//			
//			Update wms_reserva_flow_rack
//			Set qt_reserva = :ll_Qt_Sobra
//			Where cd_endereco = :as_Endereco
//				and cd_produto = :al_Produto
//			Using SqlCa;
//			
//			Choose Case Sqlca.Sqlcode
//				Case -1	
//					as_Erro = "Erro no update da 'wms_reserva_flow_rack': "+SqlCa.SqlErrText
//					SqlCa.of_Rollback();
//					Return False
//			End Choose	
//			
//		End If			
//		
//	Case -1	
//		as_Erro = "Erro no select da 'wms_reserva_flow_rack': "+SqlCa.SqlErrText
//		SqlCa.of_Rollback();
//		Return False
//End Choose
//
//Return True
end function

public function boolean of_insere_lotes_pedido (long al_pedido, long al_filial, long al_volume, long al_produto, string as_endereco, string as_lote, integer ai_separada, string as_matricula, string as_grupo_psico, ref string as_erro);Long  ll_Sequencial,& 
		ll_Qt_Cx_Padrao, &
		ll_Saldo
Date 	ldh_Validade 
String ls_lote_Select

If Not IsNull(as_Grupo_Psico) and as_Grupo_Psico <> "" Then
	select  	top 1 
				isnull(nr_sequencial, 1) as nr_sequencial,
				isnull(qt_caixa_padrao, 1) as qt_caixa_padrao,
				dh_validade ,
				isnull(qt_saldo, 0) qt_saldo
	Into 	: ll_Sequencial, 
			:ll_Qt_Cx_Padrao, 
			:ldh_Validade, 
			:ll_Saldo	  
	from wms_localizacao
	where cd_endereco 	= :as_Endereco
	and cd_produto			= :al_Produto
	and nr_lote				= :as_Lote
	and qt_saldo			>= :ai_Separada 
	Using SqlCa;
	
	Choose Case SqlCa.Sqlcode
		Case -1
			as_Erro = "Erro ao localizar o lote: "+Sqlca.sqlErrText
			SqlCa.of_RollBack();
			Return False
			
		Case 100
			as_Erro = "Produto:"+String(al_Produto)+" Endereco:"+String(as_Endereco)+" Lote:"+String(as_Lote)+"nao localizado"
			SqlCa.of_RollBack();
			Return False				
	End Choose
	
Else
	ll_Saldo = ai_Separada
	
	Select 	top 1 
				qt_caixa_padrao,
				nr_sequencial,
				dh_validade
	Into		:ll_Qt_Cx_Padrao,
				:ll_Sequencial,
				:ldh_Validade
	From wms_localizacao
	Where cd_endereco 	= :as_Endereco
		and cd_produto 	= :al_Produto
		and nr_lote 			= :as_Lote
	Using SqlCa;	
	
	Choose Case SqlCa.Sqlcode
		Case 100
			ll_Qt_Cx_Padrao 	= 1
			ll_Sequencial 		= 1
			ldh_Validade 		= Date(gf_GetServerDate())
			gf_ge202_envia_email_automatico(5, "Log Confer$$HEX1$$ea00$$ENDHEX$$ncia volumes", "N$$HEX1$$e300$$ENDHEX$$o foi localizado o produto '"+String(al_Produto)+"', lote '"+string(as_Lote)+"' no endere$$HEX1$$e700$$ENDHEX$$o '"+as_Endereco+"'.")
		Case -1
			gf_ge202_envia_email_automatico(5, "Log Confer$$HEX1$$ea00$$ENDHEX$$ncia volumes", "Erro ao localizar o produto no endere$$HEX1$$e700$$ENDHEX$$o. Produto '"+String(al_Produto)+"', lote '"+string(as_Lote)+"' no endere$$HEX1$$e700$$ENDHEX$$o '"+as_Endereco+"': ~r"+Sqlca.sqlErrText)
			Return False
	End Choose	
	
End If

If ll_Saldo >= ai_Separada  and   ai_Separada > 0  Then
	//Movimento de saida do flowRack
	If Not This.of_movimento_saida_flowrack(as_Endereco,&
														al_Produto,&
														ll_Qt_Cx_Padrao,&
														as_Lote,&
														ldh_Validade,&
														ai_Separada,&
														ll_Sequencial,&
														al_Filial,&
														al_pedido,&
														al_volume,&
														Ref as_Erro) Then
		Return False
	End If
End If	
end function

public function boolean of_termina_conferencia (ref dc_uo_ds_base ads_lista_retorno, ref string as_erro);Long ll_Itens, ll_Unidades

ll_Itens 		= ads_lista_retorno.rowcount()
ll_Unidades 	= Long(ads_lista_retorno.Describe("Evaluate('Sum(qt_separada)',0)"))
il_cd_filial	= ads_lista_retorno.object.cd_filial[1]
il_nr_pedido	= ads_lista_retorno.object.nr_pedido[1]
il_nr_volume= ads_lista_retorno.object.nr_volume[1]
is_matricula = ads_lista_retorno.object.nr_matricula[1]

Update wms_lista_separacao
Set 	dh_termino_conferencia 			= GetDate(),
		qt_itens 								= :ll_Itens,
		qt_unidades 						= :ll_Unidades,
		id_atualizacao_mov_estoque 	= Null 
Where cd_filial = :il_cd_filial
and nr_pedido_distribuidora = :il_nr_pedido
and nr_volume = :il_nr_volume
Using SqlCa;


Choose Case Sqlca.Sqlcode
	Case -1	
		as_Erro = "Erro ao finalizar a confer$$HEX1$$ea00$$ENDHEX$$ncia: "+SqlCa.SqlErrText
		Return False
End Choose

Return True
end function

public function boolean of_lotes_produtos_nao_controlados (dc_uo_ds_base ads_lista_retorno, ref dc_uo_ds_base ads_lista_retorno_lote, ref string as_erro);Long ll_For
Long ll_Count
Long ll_Qt_Lote
Long ll_Qt_Temp
Long ll_Qt_Separada
Long ll_Linha_Lote
Long ll_Linhas_Lote
String ls_Grupo_Psico
String ls_Controlado
dc_uo_ds_base lds_lotes_produto

Try
	
	lds_lotes_produto 	= Create dc_uo_ds_base
	
	If Not lds_lotes_produto.of_ChangeDataObject("ds_ge512_lista_lote_nao_controlados") Then
		as_erro = "Erro ao criar a 'ds_ge512_lista_lote_nao_controlados'"
		Return False
	End If
		

	ll_count = ads_lista_retorno.rowcount()
	For ll_for = 1 to ll_count
		
		il_cd_produto	= ads_lista_retorno.object.cd_produto[ll_for]
		il_cd_filial		= ads_lista_retorno.object.cd_filial[ll_for]
		il_nr_pedido		= ads_lista_retorno.object.nr_pedido[ll_for]
		il_nr_volume	= ads_lista_retorno.object.nr_volume[ll_for]
//		is_cd_endereco= ads_lista_retorno.object.cd_endereco[ll_for]
		is_cd_endereco= ads_lista_retorno.object.de_endereco_flow_rack[ll_for]
		ll_Qt_Separada = ads_lista_retorno.object.qt_separada[ll_for]
		
				
		ls_Controlado = 'N'	
		If This.of_grupo_psico(il_cd_produto, ref ls_Grupo_Psico, ref as_erro) Then
			ls_Controlado = ls_Grupo_Psico
		else
			as_erro = 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grupo_psico - ' + as_erro
			Return False
		End If	
		
		If ls_Controlado <> 'S' Then
			
			//Recupera os lotes dos produtos no FlowRack					
			ll_Linhas_Lote = lds_lotes_produto.Retrieve(il_cd_produto, is_cd_endereco)
			
			If (ll_Linhas_Lote < 0) or IsNull(ll_Linhas_Lote) Then
				as_erro = "Erro no retrieve dos lotes dos produtos n$$HEX1$$e300$$ENDHEX$$o controlados."
				Return False
			End If
			
			If ll_Linhas_Lote > 0 Then
				
				For ll_Linha_Lote = 1 To ll_Linhas_Lote
					
					is_nr_lote = lds_lotes_produto.Object.nr_lote[ll_Linha_Lote]
					ll_Qt_Lote = lds_lotes_produto.Object.qt_saldo[ll_Linha_Lote]
			
					If ll_Qt_Separada <= ll_Qt_Lote Then
						ll_Qt_Temp = ll_Qt_Separada						
					Else
						ll_Qt_Temp = ll_Qt_Lote					
					End If
					
					as_Erro  =''
					If Not This.of_Insere_Lote( il_nr_pedido, il_cd_filial, il_nr_volume, il_cd_produto, is_cd_endereco, is_nr_lote, ll_Qt_Temp, Ref as_Erro) Then
						SqlCa.of_Rollback()
						Return False	
					End If
										
					ll_Qt_Separada = ll_Qt_Separada - ll_Qt_Temp
					
					If ll_Qt_Separada > 0 and ll_Linha_Lote = ll_Linhas_Lote Then
						This.of_envia_email_erro("Log Confer$$HEX1$$ea00$$ENDHEX$$ncia volumes - Produto: '" + String(il_cd_produto) + "' sem lote suficiente no endere$$HEX1$$e700$$ENDHEX$$o: "+is_cd_endereco+".")
						
						as_Erro = ''
						If Not This.of_Insere_Lote( il_nr_pedido, il_cd_filial, il_nr_volume, il_cd_produto, is_cd_endereco, "LOTE CONF", ll_Qt_Separada, Ref as_Erro) Then
							SqlCa.of_Rollback()
							Return False	
						End If
						ll_Qt_Separada = 0
					End If
									
					as_Erro = ''
					If not This.of_insere_lotes_pedido( il_nr_pedido, il_cd_filial, il_nr_volume, il_cd_produto, is_cd_endereco, is_nr_lote, ll_Qt_Temp, is_matricula, ls_Grupo_Psico, Ref as_Erro) Then
						SqlCa.of_Rollback()
						Return False
					End If
					
					If ll_Qt_Separada = 0 Then Exit
				Next
				
			else
				This.of_envia_email_erro("No Produto:"+ String(il_cd_produto)+"No Lote: "+ is_nr_lote + " Sem saldo. Validade: " + String(idt_validade))
				If not This.of_Insere_Lote( il_nr_pedido, il_cd_filial, il_nr_volume, il_cd_produto, is_cd_endereco, "LOTE CONF", ll_Qt_Temp, Ref as_Erro) Then
					SqlCa.of_Rollback()
					Return False
				End If
				Return True
			end if
			
		end if
		
	Next

Finally
	Destroy(lds_lotes_produto)
End Try

Return True

end function

public function boolean of_atualiza_qtde_separada_lote (ref dc_uo_ds_base ads_lista_retorno_lote, ref string as_erro);Long ll_For
Long ll_Count
Long ll_Qt_Lote
Long ll_Qt_Temp
Long ll_Qt_Separada
String ls_Grupo_Psico
String ls_Controlado

ll_count = ads_lista_retorno_lote.rowcount()
For ll_for = 1 to ll_count

	// Carrega dados dos Lotes
	il_cd_produto			= ads_lista_retorno_lote.object.cd_produto[ll_for]
	il_cd_filial				= ads_lista_retorno_lote.object.cd_filial[ll_for]
	il_nr_pedido				= ads_lista_retorno_lote.object.nr_pedido[ll_for]
	il_nr_volume			= ads_lista_retorno_lote.object.nr_volume[ll_for]
//	is_cd_endereco			= ads_lista_retorno_lote.object.cd_endereco[ll_for]
	is_cd_endereco			= ads_lista_retorno_lote.object.de_endereco_flow_rack[ll_for]
		
	il_qt_separada_lote	= ads_lista_retorno_lote.object.qt_separada_lote[ll_for]
	is_nr_lote 				= ads_lista_retorno_lote.object.nr_lote[ll_for]
	idt_validade 			= Date(ads_lista_retorno_lote.object.dt_validade[ll_for])
		
	//Valida Numero do Lote e Quantidade
	If IsNull(is_nr_lote) or Trim(is_nr_lote) = '' Then 
		Continue 
	End If 

	// Valida Qtd Separada Lote
	If IsNull(il_qt_separada_lote) or il_qt_separada_lote <= 0 then 
		Continue 
	End If 
	
	// Dados do Produto Controlado ou N$$HEX1$$e300$$ENDHEX$$o	
	ls_Controlado = 'N'
	If This.of_grupo_psico(il_cd_produto, ref ls_Grupo_Psico, ref as_erro) Then
		ls_Controlado = ls_Grupo_Psico
	else
		as_erro = 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grupo_psico - ' + as_erro
		Return False
	End If		
		
	If Not This.of_Insere_Lote( il_nr_pedido, il_cd_filial, il_nr_volume, il_cd_produto, is_cd_endereco, is_nr_lote, il_qt_separada_lote, Ref as_Erro) Then
		SqlCa.of_Rollback()
		Return False	
	End If
	
	as_Erro = ''
	If not This.of_insere_lotes_pedido( il_nr_pedido, il_cd_filial, il_nr_volume, il_cd_produto, is_cd_endereco, is_nr_lote, il_qt_separada_lote, is_matricula, ls_Grupo_Psico, Ref as_Erro) Then
		SqlCa.of_Rollback()
		Return False
	End If
	
Next

Return True

end function

public function boolean of_grupo_psico (long ai_produto, ref string as_grupo, ref string as_erro); String ls_Grupo_Psico
 String ls_Grupo_Nao_Psico
 
 Select cd_grupo_psico
	Into :ls_Grupo_Psico 
 From produto_geral 
 Where cd_produto = :ai_produto
 Using SqlCa;

Choose Case SqlCa.Sqlcode
	Case -1
		as_Erro = "Erro ao localizar o produto: "+String(ai_produto)+". Erro: "+Sqlca.sqlErrText
		Return False			
	Case 100
		as_Erro = "Produto "+String(ai_produto)+ " n$$HEX1$$e300$$ENDHEX$$o localizado."
		Return False				
End Choose

If gf_Grupo_Nao_Psico_Matriz(ls_Grupo_Psico, ref ls_Grupo_Nao_Psico) Then
	If ls_Grupo_Nao_Psico = 'N' then
		as_grupo = 'S'
	else
		as_grupo = 'N'
	end if
else
	as_grupo = ls_Grupo_Psico
End If	
			
Return True
end function

public function boolean of_verifica_esteira (long al_esteira);String lvs_utiliza

Select  id_utiliza_pick_light
Into :lvs_utiliza
From wms_esteira 
Where id_situacao  = "A"  
And cd_esteira  =:al_esteira
Using SqlCA;

Choose Case Sqlca.Sqlcode
	Case 0
		If lvs_utiliza = "S" Then			
			Return True
		Else 			
			Return False
		End If
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao localizar esteira configurada:"+Sqlca.SqlErrText)
		Return False
End Choose



end function

public function boolean of_monta_json_produtos_ean (long al_produto, ref string as_json_ean);Long ll_Linhas, ll_Linha
String	 lvs_Json_lote
String lvs_ean

SetNull(lvs_Json_lote)

dc_uo_ds_base lds_EAN

Try 
	// Dados EAN
	lds_EAN = create dc_uo_ds_base
	If Not lds_EAN.of_changedataobject( 'ds_ge512_lista_ean' ) Then
		MessageBox("Aviso", "PadPicking: Erro Erro alterar Dw ds_ge512_lista_ean")
		Return False
	End if

	// Carrega os Dados
	ll_linhas = lds_EAN.retrieve(al_produto)
	// Inicio		
	lvs_Json_lote = '"listaEans":['

	//  Percorrer EAN Disponiveis
	For ll_Linha = 1 to ll_Linhas
		// Campo Lote
		lvs_ean		= Trim(lds_EAN.object.de_codigo_barras[ll_Linha])
		
		lvs_Json_lote	+='{'
		lvs_Json_lote	+= '"ean":"'+lvs_ean+'"'					
		
		If ll_linha < ll_Linhas	Then
			lvs_Json_lote	+='},'
		Else
			lvs_Json_lote	+='}'			
		End If
	Next
	
	// Fim Arquivo
	lvs_Json_lote	+=']'
	as_json_ean  = lvs_Json_lote
		
	If IsNull(as_json_ean) Then 
		MessageBox("Aviso", "PadPicking: Erro nos dados de EAN do arquivo")
		Return False		
	End If 
	
Finally
	Destroy(lds_EAN)
End try

Return True
end function

public function boolean of_abre_conexao (string ps_log);//Abre uma nova transa$$HEX2$$e700e300$$ENDHEX$$o com o banco para gravar o registro.
if Not isvalid(iuo_SqlCa_log) Then
	iuo_SqlCa_log = create dc_uo_transacao
	iuo_SqlCa_log.ivs_database = "SYBASE"
end if

if Not iuo_SqlCa_log.of_isconnected() Then

	If Not iuo_SqlCa_log.of_Connect(gvo_Aplicacao.ivs_DataSource, 'GE512 - Picking Light') Then
		ps_log =  'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_abre_conexao_log ~n' + "Erro ao conectar no Sybase."
		Return False
	End If
	
end if

return true
end function

public function boolean of_fecha_conexao ();//Fecha conex$$HEX1$$e300$$ENDHEX$$o usada para gerar log.
if isvalid(iuo_SqlCa_log) Then
	iuo_SqlCa_log.of_disconnect( )
	destroy(iuo_SqlCa_log)
end if

return true
end function

public function boolean of_atualiza_tabela_log_nova (string as_picking, long al_filial, long al_pedido, long al_volume, string as_tipo, string as_cd_retorno, string as_ds_retorno, string as_json, ref string ps_log);Long ll_Achou

Datetime ldh_data
String lvs_datahora
String ls_Log

ldh_data  = DateTime(Today(), Now()) 
lvs_datahora =  String  (ldh_data, "yyyy-mm-dd hh:mm:ss")

//Abre uma nova transa$$HEX2$$e700e300$$ENDHEX$$o com o banco para gravar o registro.
if Not this.of_abre_conexao( ref ls_Log ) Then return false

select count(*)
Into :ll_Achou
from wms_integracao_picking
where cd_filial = :al_filial
   and nr_pedido_distribuidora = :al_pedido
   and nr_volume = :al_volume
   and cd_tipo = :as_tipo
Using iuo_SqlCa_log;

If iuo_SqlCa_log.SqlCode = -1 Then
	ps_log = 'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_tabela_log_nova ~n' + 'Erro ao localizar registro na tabela "wms_integracao_picking": ' + iuo_SqlCa_log.sqlerrtext 
	iuo_SqlCa_log.of_Rollback()
	Return False
End If

If ll_Achou > 0 Then
	
	Delete from wms_integracao_picking
	where cd_filial = :al_filial
   		and nr_pedido_distribuidora = :al_pedido
   		and nr_volume = :al_volume
   		and cd_tipo = :as_tipo
	Using iuo_SqlCa_log;
	
	If iuo_SqlCa_log.SqlCode = -1 Then
		ps_log = 'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_tabela_log_nova ~n' + 'Erro ao excluir registro na tabela "wms_integracao_picking": ' + iuo_SqlCa_log.sqlerrtext 
		iuo_SqlCa_log.of_Rollback()
		Return False
	End If
	
End If

Insert into wms_integracao_picking(nr_picking, cd_filial, nr_pedido_distribuidora, nr_volume, dt_inclusao, cd_tipo, ds_arquivo_json , ds_integracao , cd_integracao) 
Values (:as_picking,  :al_filial , :al_pedido , :al_volume,: lvs_datahora, :as_tipo, :as_json , :as_ds_retorno, :as_cd_retorno )
Using iuo_SqlCa_log;

If iuo_SqlCa_log.SqlCode = - 1 Then
	ps_log = 'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_tabela_log_nova ~n' + 'Erro ao inserir registro na tabela "wms_integracao_picking": ' + iuo_SqlCa_log.sqlerrtext 
	iuo_SqlCa_log.of_Rollback()
	Return False				
End If 	

iuo_SqlCa_log.of_Commit();

this.of_fecha_conexao( )

Return True
end function

public function boolean of_atualiza_lista_separacao (long al_pedido, long al_filial, long al_volume, string as_tipo, ref string as_log);Boolean lb_Divergencia

If as_tipo = 'E' Then 
	
	/// Atualiza Lista para Exportado. 
	Update	wms_lista_separacao
	Set 		dh_exportacao  =GetDate()
	Where 	nr_pedido_distribuidora = :al_pedido
	And    	cd_filial =:al_filial
	And    	nr_volume=:al_volume
	Using SqlCa;

	If SqlCa.sqlcode = -1 Then
		as_log = "Erro na atualizacao exportacao wms_lista_separacao :  EXPORTADO'. Erro: "+SqlCa.sqlErrText
		SqlCa.of_Rollback()
		Return False	
	End If 
	
Else
	
	//Verifica se possui diverg$$HEX1$$ea00$$ENDHEX$$ncia na lista de separacao (qt_separada < qt_pedida)
	If Not This.of_verifica_divergencia_separacao(Ref lb_Divergencia, Ref as_Log) Then Return False
	
	/// Atualiza Lista para Importado. 
	Update	wms_lista_separacao
	Set 		dh_termino_separacao  	=GetDate(),	
				dh_importacao   			=GetDate(),
				dh_termino_conferencia	=GetDate()
	Where 	nr_pedido_distribuidora = :al_pedido
	And    	cd_filial =:al_filial
	And    	nr_volume=:al_volume
	Using SqlCa;

	If SqlCa.sqlcode = -1 Then	
		as_log = "Erro na atualizacao exportacao wms_lista_separacao :  SEP. TERMINADA'. Erro: "+SqlCa.sqlErrText
		SqlCa.of_Rollback()
		Return False	
	End If 
	
End If 

Return True 
	
end function

public function boolean of_verifica_endereco_completo (string as_endereco_reduzido, long al_produto, ref string as_endereco_completo, ref string as_erro);Select a.cd_endereco 
Into :as_endereco_completo
From wms_endereco_produto e
Inner join vw_wms_endereco a
  on a.cd_endereco = e.cd_endereco
Where e.cd_produto = :al_produto
  and a.de_endereco_flow_rack = :as_endereco_reduzido
Using SqlCA;

Choose Case Sqlca.Sqlcode
	Case 0
		If Not IsNull(as_endereco_completo) Then			
			Return True
		End If
		
	Case 100
		as_Erro = "N$$HEX1$$e300$$ENDHEX$$o foi localizado o endere$$HEX1$$e700$$ENDHEX$$o completo do produto " + String(al_produto) + " e endere$$HEX1$$e700$$ENDHEX$$o flow " + as_endereco_reduzido + ".  Filial: " + String(il_cd_filial) + &
										 "Pedido Distribuidora: " + String(il_nr_pedido) + " e volume: " + String(il_nr_volume) + ". "
		
	Case -1
		as_Erro = "Erro ao consultar o endere$$HEX1$$e700$$ENDHEX$$o completo do produto " + String(al_produto) + " e endere$$HEX1$$e700$$ENDHEX$$o flow " + as_endereco_reduzido + ".  Filial: " + String(il_cd_filial) + &
										 "Pedido Distribuidora: " + String(il_nr_pedido) + " e volume: " + String(il_nr_volume) + ". " + Sqlca.SqlErrText
End Choose

Return False
end function

public function boolean of_verifica_divergencia_separacao (ref boolean ab_divergencia, ref string as_log);Long ll_Linha
Long ll_Linhas
Long ll_Filial
Long ll_Produto
Long ll_Qt_Pedida
Long ll_Qt_Separada

String ls_Msg_Email
String ls_Parametro

Try
	
	ab_Divergencia = False
	
	dc_uo_ds_base lds
	lds = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject("ds_ge512_diverg_lista_separacao") Then
		as_Log = "Erro no change object da ds 'ds_ge512_diverg_lista_separacao'. Fun$$HEX2$$e700e300$$ENDHEX$$o of_verifica_divergencia_separacao"
		Return False
	End If
	
	ll_Linhas = lds.Retrieve(il_cd_filial, il_nr_pedido, il_nr_volume)
	
	If ll_Linhas < 0 Then
		as_Log = "Erro no retrieve da ds 'ds_ge512_diverg_lista_separacao'. Fun$$HEX2$$e700e300$$ENDHEX$$o of_verifica_divergencia_separacao. Filial: " + String(il_cd_filial) + "," + &
										 "Pedido Distribuidora: " + String(il_nr_pedido) + " e volume: " + String(il_nr_volume)
		Return False
	End If
	
	If ll_Linhas > 0 Then
		
		uo_parametro_geral lo_Parametro_Geral
		lo_Parametro_Geral = Create uo_parametro_geral
		
		lo_Parametro_Geral.ib_Mostra_Mensagem = False
		
		If Not lo_Parametro_Geral.of_Localiza_Parametro("ID_VALIDA_DIVERG_SEPARA_PAD_PICKING", Ref ls_Parametro) Then
			as_Log = lo_Parametro_Geral.is_Mensagem_Log
			Return False
		End If
		
		If ls_Parametro = "S" Then
		
			ab_Divergencia = True
		
			ls_Msg_Email = "Ol$$HEX1$$e100$$ENDHEX$$!<br><br>" +&
								"Segue diverg$$HEX1$$ea00$$ENDHEX$$ncia na lista de separa$$HEX2$$e700e300$$ENDHEX$$o na importa$$HEX2$$e700e300$$ENDHEX$$o do retorno Pad Picking:<br><br>"+&
								"<table border=2  style='table-layout: fixed; width: 700; overflow: hidden;'>"+&
								"<tr>"+&
								"<th WIDTH=50 align=left><FONT size=2 face=Verdana>Filial</font></th>"+&
								"<th WIDTH=80 align=left><FONT size=2 face=Verdana>Pedido Distribuidora</font></th>"+&
								"<th WIDTH=20 align=left><FONT size=2 face=Verdana>Volume</font></th>"+&
								"<th WIDTH=50 align=left><FONT size=2 face=Verdana>Produto</font></th>"+&
								"<th WIDTH=30 align=left><FONT size=2 face=Verdana>Qt Pedida</font></th>"+&
								"<th WIDTH=30 align=left><FONT size=2 face=Verdana>Qt Separada</font></th>"+&
								"</tr>"
									
			For ll_Linha = 1 To ll_Linhas
				ll_Filial			= lds.Object.Cd_Filial			[ll_Linha]
				ll_Produto		= lds.Object.Cd_Produto		[ll_Linha]
				ll_Qt_Pedida		= lds.Object.Qt_Pedida		[ll_Linha]
				ll_Qt_Separada	= lds.Object.Qt_Separada	[ll_Linha]
				
				ls_Msg_Email +=	"<tr>"+&
										"<td><FONT size=2 face=Verdana><center>"+String(ll_Filial)+"</center></font></td>"+&
										"<td><FONT size=2 face=Verdana><center>"+String(il_nr_pedido)+"</center></font></td>"+&
										"<td><FONT size=2 face=Verdana><center>"+String(il_nr_volume)+"</center></font></td>"+&
										"<td><FONT size=2 face=Verdana><center>"+String(ll_Produto)+"</center></font></td>"+&
										"<td><FONT size=2 face=Verdana>"+String(ll_Qt_Pedida)+"</font></td>"+&
										"<td><FONT size=2 face=Verdana>"+String(ll_Qt_Separada)+"</font></td>"+&
										"</tr>"
			Next
			
			ls_Msg_Email += "</table>"
			
			//Se tem registro (ll_Linhas > 0) $$HEX1$$e900$$ENDHEX$$ porque tem diverg$$HEX1$$ea00$$ENDHEX$$ncia e ser$$HEX1$$e100$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio investigar o problema com a lista de separacao
			//Ser$$HEX1$$e100$$ENDHEX$$ enviado e-mail com erro, mas n$$HEX1$$e300$$ENDHEX$$o ter$$HEX1$$e100$$ENDHEX$$ mais o rollback();
			//SqlCa.of_Rollback();
			
			s_email str
			
			str.ps_Mensagem	= ls_Msg_Email
			str.pb_assinatura = True
			
			If Not gf_ge202_envia_email_padrao(251, str) Then
				as_Log = "Erro no enviar email na fun$$HEX2$$e700e300$$ENDHEX$$o of_verifica_divergencia_separacao"
				Return False
			End If
		End If
	End If

	Return True

Catch (RunTimeError lo_error)
	as_Log = lo_error.GetMessage() + ". Fun$$HEX2$$e700e300$$ENDHEX$$o of_verifica_divergencia_separacao"
	Return False
	
Finally
	If IsValid(lds) Then Destroy(lds)
	If IsValid(lo_Parametro_Geral) Then Destroy(lo_Parametro_Geral)
End Try
end function

public function boolean of_consiste_dados (long al_filial, long al_pedido, long al_volume, ref string as_erro);Long ll_Linha
Long ll_Linhas
Long ll_Produto
Long ll_Qt_Separada
Long ll_Qt_Lote_Select
Long ll_Qt_Pedida
String ls_Endereco_Localizacao

try
	
	dc_uo_ds_base lds
	lds = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject("ds_ge512_lista_separada") Then
		as_Erro = "Erro na  fun$$HEX2$$e700e300$$ENDHEX$$o of_consiste_dados: Mudan$$HEX1$$e700$$ENDHEX$$a da DW 'ds_ge512_lista_separada'"
		Return False
	End If
	
	ll_Linhas = lds.Retrieve(al_Filial, al_Pedido, al_Volume)
	
	If ll_Linhas > 0 Then
		
		For ll_Linha = 1 To ll_Linhas

			ll_Produto						= lds.Object.cd_produto[ll_Linha]
			ll_Qt_Separada 				= lds.Object.qt_separada[ll_Linha]
			ll_Qt_Pedida						= lds.Object.qt_pedida[ll_Linha]
			ls_Endereco_Localizacao		=	lds.Object.cd_endereco_localizacao[ll_Linha]
			
			If	lb_Controlado_Lote_Endereco  Then 
				Select isnull(sum(qt_lote), 0)
				Into :ll_Qt_Lote_Select
				From wms_lista_separacao_prd_lote
				Where cd_filial 						=:al_Filial
				and nr_pedido_distribuidora		=:al_Pedido
				and nr_volume						=:al_Volume
				and cd_produto						=:ll_Produto
				and cd_endereco_localizacao    =:ls_Endereco_Localizacao
				Using SqlCa;		
			Else
				Select isnull(sum(qt_lote), 0)
				Into :ll_Qt_Lote_Select
				From wms_lista_separacao_prd_lote
				Where cd_filial 							=:al_Filial
				and nr_pedido_distribuidora		=:al_Pedido
				and nr_volume						=:al_Volume
				and cd_produto						=:ll_Produto									
				Using SqlCa;					
			End If
			Choose Case Sqlca.Sqlcode
				Case -1	
					as_erro = "Erro na  fun$$HEX2$$e700e300$$ENDHEX$$o of_consiste_dados: "+SqlCa.SqlErrText	
					Return False
			End Choose
	
			If ll_Qt_Lote_Select <> ll_Qt_Separada Then
				as_Erro = "Diverg$$HEX1$$ea00$$ENDHEX$$ncias ~r"+ "Produto "+String(ll_Produto)+" Qtde. Separada: "+String(ll_Qt_Separada)+" Qtde. salva: "+String(ll_Qt_Lote_Select)
				Return False
			End If
			
			If ll_Qt_Separada > ll_Qt_Pedida Then
				as_Erro = "Diverg$$HEX1$$ea00$$ENDHEX$$ncias ~r"+ "Produto "+String(ll_Produto)+" Qtde. Pedida: "+String(ll_Qt_Pedida)+" Qtde. Separada: "+String(ll_Qt_Separada)
				Return False
			End If

		Next		
		
	ElseIf ll_Linhas = 0 Then
		as_Erro = "Erro na  fun$$HEX2$$e700e300$$ENDHEX$$o of_consiste_dados: Nenhum produto foi retornado ao recuperar os dados da 'ds_ge512_lista_separada'"
		Return False
	Else
		as_Erro = "Erro na  fun$$HEX2$$e700e300$$ENDHEX$$o of_consiste_dados: Erro ao recuperar os dados da 'ds_ge512_lista_separada'"
		Return False
	End If
	
finally
	If IsValid(lds) Then Destroy(lds)
end try

Return True 
end function

public function boolean of_carrega_end_contro_json (string as_json_retorno, ref dc_uo_ds_base ads_json, ref string as_mensagem_erro);Any la_Data
Any la_Endereco

Long ll_Linha
Long ll_Linhas

String ls_Error

Try
	
	// Instancia Objeto
	uo_ge512_Json lo_Json
	lo_Json = create uo_ge512_Json
		
	ls_Error = lo_Json.parse(as_Json_Retorno)
	
	//check for parse error
	If ls_Error <> "" then
		as_Mensagem_Erro = "Parse error: " + ls_Error
		Return False
	End If
	
	//working with parsed data
	 If Not lo_Json.retrieve("myArrayList", Ref la_Data) then
		as_Mensagem_Erro = "Retrieve grupo 'myArrayList' (null)"
		Return False
	End If
	
	ll_Linhas = UpperBound(la_Data)
	
	If ll_Linhas > 0 Then
		
		Open(w_Aguarde)
		w_Aguarde.Title = "Carregando Endere$$HEX1$$e700$$ENDHEX$$os de Controlados do Json..."
		w_aguarde.uo_progress.of_setmax(ll_Linhas)

		//Carrega Lista de Endere$$HEX1$$e700$$ENDHEX$$o Controlado do JSON
		For ll_Linha = 1 To ll_Linhas
			
			If Not lo_Json.retrieve("myArrayList/" + String(ll_Linha) + "/myHashMap", Ref la_Endereco) Then
				as_Mensagem_Erro = "Retrieve tag myHashMap (null)"
				Return False
			End If
			
			If Not lo_Json.retrieve("myArrayList/" + String(ll_Linha) + "/myHashMap/numEndereco", Ref la_Endereco) Then
				as_Mensagem_Erro = "Retrieve tag numEndereco (null)"
				Return False
			End If
				
			ads_json.InsertRow(0)
			ads_json.Object.De_Endereco_Flow_Rack[ads_json.RowCount()] = String(la_Endereco)
			
			w_aguarde.uo_progress.of_setprogress(ll_Linha)
		Next
		
		ads_json.SaveAs("D:\TEMP\ENDERECO_CONTROLADO.XLS", Excel!, TRUE)
	End If
	
	Return True
	
Catch (RunTimeError lo_error)
	as_Mensagem_Erro = lo_error.GetMessage()
	Return False
	
Finally
	If IsValid(w_Aguarde) Then Close(w_Aguarde)
End Try
end function

public function boolean of_atualiza_id_endereco_pad_picking (string as_json_retorno, dc_uo_ds_base ads_endereco_controlado, dc_uo_ds_base ads_contro_json, ref string as_mensagem_erro);Long ll_Linha
Long ll_Linhas
Long ll_Find

String ls_Error
String ls_End_Contro
String ls_Valor

Try
	
	ll_Linhas = ads_Endereco_Controlado.RowCount()
	
	Open(w_Aguarde)
	w_Aguarde.Title = "Atualizando o id_endereco_pad_picking..."
	w_aguarde.uo_progress.of_setmax(ll_Linhas)

	For ll_Linha = 1 To ll_Linhas
		
		ls_End_Contro = ads_Endereco_Controlado.Object.De_Endereco_Flow_Rack[ll_Linha]
		
		ll_Find = ads_contro_json.Find("de_endereco_flow_rack = '" + ls_End_Contro + "'", 1, ads_contro_json.RowCount())
		
		If ll_Find < 0 Then
			as_Mensagem_Erro = "Erro no Find na fun$$HEX2$$e700e300$$ENDHEX$$o of_atualiza_id_endereco_pad_picking"
			Return False
		End If
		
		//Se encontrou o endere$$HEX1$$e700$$ENDHEX$$o no json grava S
		If ll_Find > 0 Then
			ls_Valor = "S"
		Else
			ls_Valor = "N"
		End If
		
		//S$$HEX1$$f300$$ENDHEX$$ faz o update se o valor for diferente do que est$$HEX1$$e100$$ENDHEX$$ gravado na base
		Update wms_endereco
			Set id_endereco_pad_picking = :ls_Valor
		From wms_endereco a
			Inner Join vw_wms_endereco v
				On v.cd_endereco = a.cd_endereco
		Where v.de_endereco_flow_rack = :ls_End_Contro
			And coalesce(v.id_endereco_pad_picking, 'N') <> :ls_Valor
		Using SqlCa;
			
		If SqlCa.SqlCode = -1 Then
			as_Mensagem_Erro = "Erro ao atualizar o id_endereco_pad_picking da wms_endereco para o endere$$HEX1$$e700$$ENDHEX$$o flow rack [" + ls_End_Contro + "]. " + SqlCa.SqlErrText
			SqlCa.of_Rollback();
			Return False
		End If
		
		If SqlCa.SqlNRows > 1 Then
			as_Mensagem_Erro = "Foi atualizado quantidade de registro [" + String(SqlCa.SqlNRows) +  "] no id_endereco_pad_picking da wms_endereco para o endere$$HEX1$$e700$$ENDHEX$$o flow rack [" + ls_End_Contro + "]. " + SqlCa.SqlErrText
			SqlCa.of_Rollback();
			Return False
		End If
		
		w_aguarde.uo_progress.of_setprogress(ll_Linha)
	Next
	
	SqlCa.of_Commit();

	Return True
	
Catch (RunTimeError lo_error)
	as_Mensagem_Erro = lo_error.GetMessage()
	Return False
	
Finally
	If IsValid(w_Aguarde) Then Close(w_Aguarde)
End Try
end function

public function boolean of_envia_email_endereco_control_json (dc_uo_ds_base ads_endereco_controlado, ref string as_mensagem_erro);Long ll_Linha
Long ll_Linhas

String ls_End_Contro
String ls_Mensagem = "Os endere$$HEX1$$e700$$ENDHEX$$os abaixo n$$HEX1$$e300$$ENDHEX$$o existem no pad picking: <br><br>"
String ls_Anexo[]

Try
	
	ll_Linhas = ads_Endereco_Controlado.RowCount()
	
	If ll_Linhas > 0 Then

		For ll_Linha = 1 To ll_Linhas
			
			ls_End_Contro = ads_Endereco_Controlado.Object.De_Endereco_Flow_Rack[ll_Linha]
			
			ls_Mensagem += ls_End_Contro + ", "
		Next
		
		//Retira a v$$HEX1$$ed00$$ENDHEX$$rgula
		ls_Mensagem = MidA(ls_Mensagem, 1, LenA(ls_Mensagem) - 2)
		
		gf_ge202_envia_email_automatico(281, "", ls_Mensagem, ls_Anexo, False)
	End If
	
	Return True
	
Catch (RunTimeError lo_error)
	as_Mensagem_Erro = lo_error.GetMessage()
	Return False
	
Finally

End Try
end function

public function boolean of_processa_lista_endereco_controlado ();String ls_Json_Retorno
String ls_URL
String ls_Mensagem_Erro

Try
	
	dc_uo_ds_base lds_End_Controlado
	lds_End_Controlado = Create dc_uo_ds_base
	
	If Not lds_End_Controlado.of_ChangeDataObject("ds_ge512_lista_endereco_controlado") Then
		ls_Mensagem_Erro = "Erro no change data object da [ds_ge512_lista_endereco_controlado]."
		Return False
	End If
	
	If lds_End_Controlado.Retrieve() < 0 Then
		ls_Mensagem_Erro = "Erro no retrieve da [ds_ge512_lista_endereco_controlado]."
		Return False
	End If
	
	If lds_End_Controlado.RowCount() > 0 Then
		
		Select de_parametro
		Into :ls_URL
		From  wms_parametro
		Where cd_parametro = 'URL_LISTA_ENDERECOS_SMARTPICING'
		Using SqlCA;	
				
		Choose Case SqlCa.SqlCode
				
			Case 0				
				If IsNull(ls_URL) or ls_URL='' Then 
					ls_Mensagem_Erro = "de_parametro da wms_parametro URL_LISTA_ENDERECOS_SMARTPICING est$$HEX1$$e100$$ENDHEX$$ nulo ou em branco."
					Return False
				End If
			
			Case 100
				ls_Mensagem_Erro = "N$$HEX1$$e300$$ENDHEX$$o foi localizado o de_parametro da wms_parametro URL_LISTA_ENDERECOS_SMARTPICING."
				Return False
				
			Case -1
				ls_Mensagem_Erro = "Erro ao localizar o de_parametro da wms_parametro URL_LISTA_ENDERECOS_SMARTPICING. " +Sqlca.sqlErrText
				Return False
		End Choose
		
		If Not This.of_Envia_Servidor ('POST', ls_URL, "", "" , False , False, Ref ls_Json_Retorno, Ref ls_Mensagem_Erro) Then
			ls_Mensagem_Erro = "Erro ao conectar na URL de endere$$HEX1$$e700$$ENDHEX$$os de controlado do Pad Picking.~r~r" + ls_Mensagem_Erro
			Return False
		End If
		
		dc_uo_ds_base lds_Json
		lds_Json = Create dc_uo_ds_base
		
		If Not lds_Json.of_ChangeDataObject("ds_ge512_lista_end_controlado_json") Then
			ls_Mensagem_Erro = "Erro no change data object da [ds_ge512_lista_end_controlado_json]."
			Return False
		End If

		If Not This.of_Carrega_End_Contro_Json( ls_Json_Retorno, Ref lds_Json, Ref ls_Mensagem_Erro ) Then Return False
		
		If Not This.of_Atualiza_Id_Endereco_Pad_Picking( ls_Json_Retorno, lds_End_Controlado, lds_Json, Ref ls_Mensagem_Erro ) Then Return False
		
		lds_End_Controlado.of_AppendWhere("id_endereco_pad_picking = 'N'")
		
		If lds_End_Controlado.Retrieve() < 0 Then
			ls_Mensagem_Erro = "Erro no retrieve da [ds_ge512_lista_endereco_controlado]."
			Return False
		End If
	
		If Not This.of_Envia_Email_Endereco_Control_Json(lds_End_Controlado, Ref ls_Mensagem_Erro) Then Return False
	End If
	
	Return True

Catch (RunTimeError lo_error)
	ls_Mensagem_Erro = lo_error.GetMessage()
	Return False
	
Finally
	If IsValid(lds_End_Controlado) Then Destroy(lds_End_Controlado)
	If IsValid(lds_Json) Then Destroy(lds_Json)
	
	If ls_Mensagem_Erro <> "" Then
		This.of_Envia_Email_Erro(ls_Mensagem_Erro)
	End If
End Try
end function

public function boolean of_movimento_saida_flowrack (string as_endereco_saida, long al_produto, long al_cx_padrao, string as_lote, date adh_validade, long al_qtde, long al_sequencial, long al_filial, long al_nr_pedido, long al_volume, ref string as_erro);string ls_matricula_conferente

/*
Localiza o n$$HEX1$$fa00$$ENDHEX$$mero da matricula do respons$$HEX1$$e100$$ENDHEX$$vel pela confer$$HEX1$$ea00$$ENDHEX$$ncia.
Chamado 1186594
*/
SELECT nr_matricula_conferente
  INTO :ls_matricula_conferente
  FROM wms_lista_separacao_produto 
 WHERE cd_filial               = :al_Filial
   AND nr_pedido_distribuidora = :al_nr_pedido
   AND nr_volume               = :al_volume
   AND cd_produto              = :al_Produto
   AND cd_endereco_localizacao = :as_endereco_saida
 USING SQLCA;

If SqlCa.SqlCode = -1 Then
	as_Erro = "Erro ao localizar nr_matricula_conferente na tabela 'wms_lista_separacao_produto': "+SqlCa.SQLErrText
	SqlCa.of_RollBack();
	Return False
End If

/// VER: o campo nr_matricula_responsavel deve vir do arquivo de retorno.
Insert into wms_movimentacao
          ( cd_endereco_entrada
			 ,	nr_sequencial_entrada
			 ,	cd_endereco_saida
			 ,	nr_sequencial_saida
			 , cd_produto
			 ,	qt_caixa_padrao
			 , nr_lote
			 ,	dh_validade
			 ,	qt_movimento
			 ,	id_tipo_movimento
			 ,	dh_movimentacao
			 ,	nr_matricula_responsavel
			 ,	cd_filial
			 ,	cd_fornecedor
			 ,	nr_nf
			 ,	de_especie
			 ,	de_serie
			 )
    Values( NULL
	       ,	NULL
			 , :as_endereco_saida
			 , :al_sequencial
			 ,	:al_Produto
			 ,	:al_Cx_Padrao
			 ,	:as_Lote
			 ,	:adh_Validade
			 ,	:al_qtde
			 ,	'P'
			 ,	GetDate()
			 ,	:ls_matricula_conferente
			 ,	:al_Filial
			 ,	NULL
			 ,	NULL
			 ,	NULL
			 ,	NULL
			 )
      Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_Erro = "Erro ao inserir dados na tabela 'wms_movimentacao': "+SqlCa.SQLErrText
	SqlCa.of_RollBack();
	Return False
End If

Return True
end function

public function boolean of_atualiza_qtde_separada_produto (long al_pedido, long al_filial, long al_volume, long al_produto, string as_endereco, integer ai_separada, string as_matricula, ref string as_erro, datetime adt_conferencia, datetime adt_ini_conferencia);	
/// Atualiza Qtde separada do produto E tamb$$HEX1$$e900$$ENDHEX$$m a Diverg$$HEX1$$ea00$$ENDHEX$$ncia Lista Importada. 
Update	wms_lista_separacao_produto
Set 		qt_separada  =:ai_separada,	
			qt_divergencia   = qt_pedida - :ai_separada,
			nr_matricula_conferente = :as_matricula,
			dh_conferencia			= :adt_conferencia,
			dh_ini_conferencia   = :adt_ini_conferencia
Where 	nr_pedido_distribuidora = :al_pedido
And    	cd_filial =:al_filial
And    	nr_volume =:al_volume
And		cd_produto =:al_produto
And		cd_endereco_localizacao =:as_endereco
Using SqlCa;

If SqlCa.sqlcode = -1 Then
	as_erro	= "Erro na atualizacao importa$$HEX2$$e700e300$$ENDHEX$$o wms_lista_separacao_produto :  QT_SEPARADA'. Erro: "+SqlCa.sqlErrText
	SqlCa.of_Rollback()
	Return False	
End If 

Return True 
	
end function

public function boolean of_carrega_parametros (ref datetime adt_parametro, ref long al_top);//Retorna a data da $$HEX1$$fa00$$ENDHEX$$ltima importa$$HEX2$$e700e300$$ENDHEX$$o + 2 horas que $$HEX1$$e900$$ENDHEX$$ a pr$$HEX1$$f300$$ENDHEX$$xima e execu$$HEX2$$e700e300$$ENDHEX$$o da rotina geral (sem o top 40)
Select dateadd(hour, 2, cast(substring(vl_parametro,7,4)+'/'+substring(vl_parametro, 4,2)+'/'+substring(vl_parametro, 1,2)+' '+substring(vl_parametro, 12, 8) as datetime))
	Into :adt_parametro
From parametro_geral
Where cd_parametro = 'ULTIMA_IMPORT_RETORNO_PAD_PICKING'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If IsNull(adt_parametro) Then
			This.of_envia_email_erro("PadPicking: Parametro_geral 'ULTIMA_IMPORT_RETORNO_PAD_PICKING'. inv$$HEX1$$e100$$ENDHEX$$lido." +SqlCa.sqlErrText)
		End If
		
	Case 100
		This.of_envia_email_erro("PadPicking: Parametro_geral 'ULTIMA_IMPORT_RETORNO_PAD_PICKING'. n$$HEX1$$e300$$ENDHEX$$o cadastrado." +SqlCa.sqlErrText)
		
	Case -1		
		This.of_envia_email_erro("PadPicking: Erro ao consultar o parametro_geral 'ULTIMA_IMPORT_RETORNO_PAD_PICKING'." +SqlCa.sqlErrText)
		Return False
End Choose


//Seleciona quantidade para top que deve retorna no retrive
Select cast(vl_parametro as Int)
	Into :al_top
From wms_parametro
Where cd_parametro = 'ID_UTILIZA_SELECAO_SMARTPICKING'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If IsNull(al_top) Then
			This.of_envia_email_erro("PadPicking: wms_parametro 'ID_UTILIZA_SELECAO_SMARTPICKING'. inv$$HEX1$$e100$$ENDHEX$$lido." +SqlCa.sqlErrText)
		End If
		
	Case 100
		This.of_envia_email_erro("PadPicking: wms_parametro 'ID_UTILIZA_SELECAO_SMARTPICKING'. n$$HEX1$$e300$$ENDHEX$$o cadastrado." +SqlCa.sqlErrText)
		
	Case -1		
		This.of_envia_email_erro("PadPicking: Erro ao consultar o wms_parametro 'ID_UTILIZA_SELECAO_SMARTPICKING'." +SqlCa.sqlErrText)
		Return False
	End Choose


Return True
end function

on uo_ge512_smart_picking.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge512_smart_picking.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;////is_objeto = 'Objeto: ' + this.classname() + '~n'
end event

event destructor;this.of_fecha_conexao( )
end event

