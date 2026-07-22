HA$PBExportHeader$uo_ge038_ws.sru
forward
global type uo_ge038_ws from nonvisualobject
end type
end forward

global type uo_ge038_ws from nonvisualobject
end type
global uo_ge038_ws uo_ge038_ws

type prototypes

end prototypes

type variables
soapconnection ivo_SoapConnection

ge038_blocoxsoap ipr_sefazsc
ge038_prod_blocoxsoap ipr_sefazsc_prod

/* DADOS PARA TESTE */
Boolean ib_Autorizacao_Real = False // Real ou Simula$$HEX2$$e700e300$$ENDHEX$$o

String is_Usuario
String is_Senha
String is_ambiente_producao

// Retorno
String is_NomeUsuario
String is_NomeEmpresa

end variables

forward prototypes
public function boolean of_proxy_create ()
public subroutine of_proxy_destroy ()
public function boolean of_trata_argumentos ()
public function integer of_trata_retorno_geral (string ps_retorno)
public function boolean of_valor_retornado (string ps_xml, string ps_procura, ref string ps_retorno, integer pi_inicio)
public function boolean of_valor_retornado (string ps_xml, string ps_procura, ref string ps_retorno)
public subroutine of_importa_xml ()
public function boolean of_enviar (string ps_xml, ref string ps_retorno)
public function boolean of_valida (string ps_xml, ref string ps_retorno)
public function string of_consulta_recibo (string ps_recibo)
public function boolean of_grava_retorno (string ps_retorno, string ps_arquivo)
public function boolean of_enviar_sem_msg (string ps_xml, ref string ps_retorno, ref string ps_erro)
public function string of_consulta_recibo_sem_msg (string ps_recibo, ref string ps_erro)
public function string of_cancela_recibo_sem_msg (string ps_xml, ref string ps_erro)
public function string of_reprocessar_sem_msg (string ps_xml, ref string ps_erro)
end prototypes

public function boolean of_proxy_create ();long ll_retorno //Vari$$HEX1$$e100$$ENDHEX$$vel de retorno do m$$HEX1$$e900$$ENDHEX$$todo createinstance 

//String ps_Baixar[]

//ps_Baixar = {"pbsoapclient120.pbd"}
//gf_Download_Matriz(ps_Baixar, ps_Baixar, "c:\arquivos de programas\sybase\shared\PowerBuilder", "PB12", False)

//Cria uma conex$$HEX1$$e300$$ENDHEX$$o SOAP 
ivo_SoapConnection = create soapconnection

If This.is_ambiente_producao = 'S' Then
	ipr_sefazsc_prod	= create ge038_prod_blocoxsoap
	ll_retorno = ivo_SoapConnection.CreateInstance( ipr_sefazsc_prod, 'ge038_prod_blocoxsoap' )	
Else
	ipr_sefazsc	= create ge038_blocoxsoap
	ll_retorno = ivo_SoapConnection.CreateInstance( ipr_sefazsc, 'ge038_blocoxsoap' )
End If

If ll_retorno <> 0 Then 
	Messagebox( 'Aten$$HEX2$$e700e300$$ENDHEX$$o', 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel criar a inst$$HEX1$$e200$$ENDHEX$$ncia do objeto de conex$$HEX1$$e300$$ENDHEX$$o com a Sefaz. Erro:' + String( ll_Retorno ) + '~r' + &
								   'Tente novamente mais tarde, persistindo o problema, abra um chamado no Service Desk.', StopSign!)
	Return False
End If

Return True
end function

public subroutine of_proxy_destroy ();If IsValid( ivo_SoapConnection ) Then Destroy ivo_SoapConnection
end subroutine

public function boolean of_trata_argumentos ();Boolean lb_Retorno = True

Integer li_Tamanho_CC = 39
Integer li_Tamanho_AU = 39
Integer li_Tamanho_CA = 39

String ls_Metodo
String gvs_TipoConsulta

Choose Case gvs_TipoConsulta
	Case 'CC' // ConsultaCartao
		ls_Metodo = 'ConsultaCartao~r~rEsperado: ' + String( li_Tamanho_CC ) + ' Recebido: ' + String(LenA( '' ) ) 
		
		If LenA( '' ) <> li_Tamanho_CC Then
			lb_Retorno = False
		End If
		
	Case 'AU' // Autoriza
		ls_Metodo = 'Autoriza~r~rEsperado: ' + String( li_Tamanho_AU ) + ' Recebido: ' + String(LenA( '' ) ) 
		
		If LenA( '' ) <> li_Tamanho_AU Then
			lb_Retorno = False
		End If
		
	Case 'CA' // Cancela
		ls_Metodo = 'Cancela~r~rEsperado: ' + String( li_Tamanho_CA ) + ' Recebido: ' + String(LenA( '' ) ) 
		
		If LenA( '' ) <> li_Tamanho_CA Then
			lb_Retorno = False
		End If
		
End Choose

If Not lb_Retorno Then
	MessageBox( 'Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Tamnaho do argumento passado inv$$HEX1$$e100$$ENDHEX$$lido para o tipo ' + ls_Metodo, StopSign! )
End If

Return lb_Retorno
end function

public function integer of_trata_retorno_geral (string ps_retorno);Long ll_Pos
Long ll_Pos_msg
Long ll_PosIni

String ls_Msg
String ls_Erro

Boolean lb_resposta = False

ll_Pos = Pos( ps_Retorno, "EstoqueResposta" ) 

If ll_Pos > 0 Then lb_resposta = True

ll_Pos = Pos( ps_Retorno, "Resposta" ) 

If ll_Pos > 0 Then lb_resposta = True

//ll_Pos = Pos( ps_Retorno, "acesso" ) //Erro no login
//If ll_Pos > 0 Then
//	ll_Pos_msg	= Pos ( ps_Retorno, "msg=" )
//	ll_PosIni		= ll_Pos_msg + 5
//	ls_Msg		= Mid( ps_Retorno, ll_PosIni, Pos( ps_Retorno, '"', ll_PosIni + 1) - ll_PosIni )
//	
//	Messagebox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Problemas no Login da FUNCIONAL CARD:~r~r" +ls_Msg, Information! )
//	Return -1
//End If
//
//ll_Pos = Pos( ps_Retorno, "erro=" )
//
//If ll_Pos > 0 Then  //Encontrou - tratar o valor
//	ll_PosIni	= ll_Pos + 6
//	ls_Erro	= Mid( ps_Retorno, ll_PosIni , 1)
//	
//	If ls_Erro = "S" Then //Erro, retornar mensagem para o usuario               
//		ll_Pos_msg	= Pos ( ps_Retorno, "msg=" )
//		ll_PosIni		= ll_Pos_msg + 5
//		ls_Msg		= Mid( ps_Retorno, ll_PosIni, Pos( ps_Retorno, '"', ll_PosIni + 1) - ll_PosIni )
//		
//		Messagebox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Problemas na regra de neg$$HEX1$$f300$$ENDHEX$$cio:~r~r" +	ls_Msg, Information! )
//		Return -1      
//	End If
//End If

If Not lb_resposta Then
	Return -1
End If

Return 1
end function

public function boolean of_valor_retornado (string ps_xml, string ps_procura, ref string ps_retorno, integer pi_inicio);Long ll_Pos
Long ll_Pos_De
Long ll_Pos_Ate

ll_Pos = PosA( ps_Xml, ps_Procura, pi_Inicio )

If ll_Pos = 0 Then
	ps_Retorno = ""
Else
	ll_Pos_De	= ll_Pos + LenA( ps_Procura ) +1
	ll_Pos_Ate	= PosA( ps_Xml, '<', ll_Pos_De ) - ll_Pos_De
	
	ps_Retorno = MidA( ps_Xml, ll_Pos_De, ll_Pos_Ate )
End If

ps_Retorno = Trim( ps_Retorno )

Return True
end function

public function boolean of_valor_retornado (string ps_xml, string ps_procura, ref string ps_retorno);Return This.of_Valor_Retornado( ps_XML, ps_Procura, ref ps_Retorno, 1 )
end function

public subroutine of_importa_xml ();PBDOM_Builder		ipbDomBuilder

PBDOM_Object		lo_Root[]
PBDOM_Object		lo_Cabecalho[]
PBDOM_Object		lo_Corpo[]
PBDOM_Object		lo_Medicamentos[]
PBDOM_Object		lo_EntradaMedicamentos[]
PBDOM_Object		lo_NotaEntradaMedicamentos[]

PBDOM_Document	ipbDOM_Doc
ipbDomBuilder	= CREATE PBDOM_Builder
ipbDOM_Doc	= ipbDomBuilder.BuildFromFile ( 'C:\Sistemas\sngpc\Arquivos\101213_161213.XML' )
ipbDOM_Doc.GetRootElement().GetContent( Ref lo_Root[] )

String ls_NomeChave
String ls_ValorChave

Long ll_Medicamentos
Long ll_EntradaMedicamentos
Long ll_NotaEntradaMedicamentos

lo_Root[1].GetContent( Ref lo_Cabecalho[] )
lo_Root[2].GetContent( Ref lo_Corpo[] )

lo_Corpo[1].GetContent( Ref lo_Medicamentos[] )

For ll_Medicamentos = 1 To Upperbound( lo_Medicamentos )
	lo_Medicamentos[ ll_Medicamentos ].GetContent( Ref lo_EntradaMedicamentos[] )
	
	For ll_EntradaMedicamentos = 1 To Upperbound( lo_EntradaMedicamentos )
		ls_NomeChave = lo_EntradaMedicamentos[ ll_EntradaMedicamentos ].GetName( )
		
		Choose Case Lower( ls_NomeChave )
			Case 'notafiscalentradamedicamento'				
				lo_EntradaMedicamentos[ ll_EntradaMedicamentos ].GetContent( Ref lo_NotaEntradaMedicamentos[] )
				
				For ll_NotaEntradaMedicamentos = 1 To Upperbound( lo_NotaEntradaMedicamentos )
					ls_NomeChave	= lo_NotaEntradaMedicamentos[ ll_NotaEntradaMedicamentos ].GetName( )
					ls_ValorChave	= lo_NotaEntradaMedicamentos[ ll_NotaEntradaMedicamentos ].GetText( )
				Next
		
			Case 'medicamentoentrada'
				lo_EntradaMedicamentos[ ll_EntradaMedicamentos ].GetContent( Ref lo_NotaEntradaMedicamentos[] )
				
				For ll_NotaEntradaMedicamentos = 1 To Upperbound( lo_NotaEntradaMedicamentos )
					ls_NomeChave	= lo_NotaEntradaMedicamentos[ ll_NotaEntradaMedicamentos ].GetName( )
					ls_ValorChave	= lo_NotaEntradaMedicamentos[ ll_NotaEntradaMedicamentos ].GetText( )
				Next

			Case 'datarecebimentomedicamento'
				ls_ValorChave	= lo_EntradaMedicamentos[ ll_EntradaMedicamentos ].GetText( )

		End Choose
	Next	
Next
end subroutine

public function boolean of_enviar (string ps_xml, ref string ps_retorno);Boolean lb_Sucesso = True

Integer li_FileNum
Integer li_Bytes

String ls_Retorno
String ls_XML_envio
String ls_Arquivo

Blob lbl_arquivo_xml

ls_Arquivo	= ps_xml
If Not FileExists( ls_Arquivo ) Then
	MessageBox( 'Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Arquivo ' + ls_Arquivo + ' n$$HEX1$$e300$$ENDHEX$$o localizado.', StopSign! )
	Return False
End If

li_FileNum	= FileOpen( ls_Arquivo, StreamMode! )

If li_FileNum = -1 Then
	MessageBox( 'Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao abrir o arquivo para leitura ' + ls_Arquivo + '.', StopSign! )
	Return False
End If

//li_Bytes	= FileRead( li_FileNum, ls_XML_envio )
li_Bytes = FileReadEx( li_FileNum, lbl_arquivo_xml )

FileClose( li_FileNum )

If li_Bytes = -1 Then
	MessageBox( 'Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao ler o conte$$HEX1$$fa00$$ENDHEX$$do do arquivo ' + ls_Arquivo + '.', StopSign! )
	Return False
End If

If Not This.of_Proxy_Create() Then
	Return False
End If

Try
	If This.is_ambiente_producao = 'S' Then
		ps_Retorno = ipr_sefazsc_prod.transmitirarquivo(lbl_arquivo_xml)	
	Else
		ps_Retorno = ipr_sefazsc.transmitirarquivo(lbl_arquivo_xml)	
	End If
	
	//If Not This.of_Grava_Retorno( ps_Retorno ) Then
	//	lb_Sucesso = False
	//End If
	
Catch ( SoapException e ) // Soap
	MessageBox( 'Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro na conex$$HEX1$$e300$$ENDHEX$$o com o Sefaz~r~r' + e.getMessage(), StopSign! )		
		
Finally // Soap
	This.of_Proxy_Destroy()
	Return lb_Sucesso
End Try
end function

public function boolean of_valida (string ps_xml, ref string ps_retorno);//N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ mais usada

Boolean lb_Sucesso = True

Integer li_FileNum
Integer li_Bytes

String ls_Retorno
String ls_XML_valida
String ls_Arquivo

ls_Arquivo	= ps_xml
If Not FileExists( ls_Arquivo ) Then
	MessageBox( 'Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Arquivo ' + ls_Arquivo + ' n$$HEX1$$e300$$ENDHEX$$o localizado.', StopSign! )
	Return False
End If

li_FileNum	= FileOpen( ls_Arquivo, StreamMode! )

If li_FileNum = -1 Then
	MessageBox( 'Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao abrir o arquivo para leitura ' + ls_Arquivo + '.', StopSign! )
	Return False
End If

li_Bytes	= FileRead( li_FileNum, ls_XML_valida )

FileClose( li_FileNum )

If li_Bytes = -1 Then
	MessageBox( 'Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao ler o conte$$HEX1$$fa00$$ENDHEX$$do do arquivo ' + ls_Arquivo + '.', StopSign! )
	Return False
End If

If Not This.of_Proxy_Create() Then
	Return False
End If

Try
//	If This.is_ambiente_producao = 'S' Then
//		ps_Retorno = ipr_sefazsc_prod.validar( True, True, ls_xml_valida)			
//	Else
//		ps_Retorno = ipr_sefazsc.validar( True, True, ls_xml_valida)	
//	End If
	
//	ps_Retorno = ipr_sefazsc.validar( True, True, ls_xml_valida)	
	
//	If Not This.of_Grava_Retorno( ps_Retorno ) Then
//		lb_Sucesso = False
//	End If
	
Catch ( SoapException e ) // Soap
	MessageBox( 'Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro na conex$$HEX1$$e300$$ENDHEX$$o com o Sefaz~r~r' + e.getMessage(), StopSign! )		
		
Finally // Soap
	This.of_Proxy_Destroy()
	Return lb_Sucesso
End Try
end function

public function string of_consulta_recibo (string ps_recibo);Boolean lb_Sucesso = True

String ls_Retorno = ''

If Not This.of_Proxy_Create( ) Then
	Return ''
End If

Try
	If This.is_ambiente_producao = 'S' Then	
		ls_Retorno = ipr_sefazsc_prod.consultarprocessamentoarquivo( ps_recibo )
	Else
		ls_Retorno = ipr_sefazsc.consultarprocessamentoarquivo( ps_recibo )		
	End If
	
Catch ( SoapException e ) // Soap
		MessageBox( 'Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro na conex$$HEX1$$e300$$ENDHEX$$o com a Sefaz~r~r' + e.getMessage( ), StopSign! )
		
Finally // Soap
	This.of_Proxy_Destroy( )
	Return ls_Retorno
End Try
end function

public function boolean of_grava_retorno (string ps_retorno, string ps_arquivo);Integer li_FileNum
Integer li_FileWrite

String ls_Arquivo

If FileExists( ps_Arquivo ) Then
	FileDelete( ps_Arquivo )
End If

li_FileNum = FileOpen( ps_Arquivo, StreamMode!, Write!, LockWrite!, Replace!, EncodingUTF8! )

If li_FileNum = -1 Then
	MessageBox( 'Aten$$HEX2$$e700e300$$ENDHEX$$o', "Ocorreu um erro na tentativa de abrir o arquivo '" + ps_Arquivo + "'.", StopSign! )
	Return False
End If

li_FileWrite = FileWrite( li_FileNum, ps_Retorno )
FileClose( li_FileNum )

If li_FileWrite = -1 Then
	MessageBox( 'Aten$$HEX2$$e700e300$$ENDHEX$$o', "Ocorreu um erro na tentativa de gravar o retorno no arquivo '" + ps_Arquivo + "'.", StopSign! )
	FileDelete( ls_Arquivo )
	Return False
End If

Return True
end function

public function boolean of_enviar_sem_msg (string ps_xml, ref string ps_retorno, ref string ps_erro);Boolean lb_Sucesso = True

Integer li_FileNum
Integer li_Bytes

String ls_Retorno
String ls_XML_envio
String ls_Arquivo

Blob lbl_arquivo_xml

ls_Arquivo	= ps_xml
If Not FileExists( ls_Arquivo ) Then
	ps_erro = 'Arquivo ' + ls_Arquivo + ' n$$HEX1$$e300$$ENDHEX$$o localizado.'
	Return False
End If

li_FileNum	= FileOpen( ls_Arquivo, StreamMode! )

If li_FileNum = -1 Then
	ps_erro = 'Erro ao abrir o arquivo para leitura ' + ls_Arquivo + '.'
	Return False
End If

li_Bytes = FileReadEx( li_FileNum, lbl_arquivo_xml )

FileClose( li_FileNum )

If li_Bytes = -1 Then
	ps_erro = 'Erro ao ler o conte$$HEX1$$fa00$$ENDHEX$$do do arquivo ' + ls_Arquivo + '.'
	Return False
End If

If Not This.of_Proxy_Create() Then
	ps_erro = 'Erro no Proxy Create.'
	Return False
End If

Try
	If This.is_ambiente_producao = 'S' Then
		ps_Retorno = ipr_sefazsc_prod.transmitirarquivo(lbl_arquivo_xml)	
	Else
		ps_Retorno = ipr_sefazsc.transmitirarquivo(lbl_arquivo_xml)	
	End If
	
	//If Not This.of_Grava_Retorno( ps_Retorno ) Then
	//	lb_Sucesso = False
	//End If
	
Catch ( SoapException e ) // Soap
	ps_erro = 'Erro na conex$$HEX1$$e300$$ENDHEX$$o com o Sefaz: ' + e.getMessage()		
		
Finally // Soap
	This.of_Proxy_Destroy()
	Return lb_Sucesso
End Try
end function

public function string of_consulta_recibo_sem_msg (string ps_recibo, ref string ps_erro);Boolean lb_Sucesso = True

String ls_Retorno = ''

If Not This.of_Proxy_Create( ) Then
	ps_erro = 'Erro no Proxy Create'
	Return ''
End If

Try
	If This.is_ambiente_producao = 'S' Then	
		ls_Retorno = ipr_sefazsc_prod.consultarprocessamentoarquivo( ps_recibo )
	Else
		ls_Retorno = ipr_sefazsc.consultarprocessamentoarquivo( ps_recibo )		
	End If
	
Catch ( SoapException e ) // Soap
	ps_erro = 'Erro na conex$$HEX1$$e300$$ENDHEX$$o com a Sefaz: ' + e.getMessage( )
		
Finally // Soap
	This.of_Proxy_Destroy( )
	Return ls_Retorno
End Try
end function

public function string of_cancela_recibo_sem_msg (string ps_xml, ref string ps_erro);Boolean lb_Sucesso = True

String ls_Retorno = ''

If Not This.of_Proxy_Create( ) Then
	ps_erro = 'Erro no Proxy Create'
	Return ''
End If

Try
	If This.is_ambiente_producao = 'S' Then	
		ls_Retorno = ipr_sefazsc_prod.cancelararquivo( ps_xml )
	Else
		ls_Retorno = ipr_sefazsc.cancelararquivo( ps_xml )		
	End If
	
Catch ( SoapException e ) // Soap
	ps_erro = 'Erro na conex$$HEX1$$e300$$ENDHEX$$o com a Sefaz: ' + e.getMessage( )
		
Finally // Soap
	This.of_Proxy_Destroy( )
	Return ls_Retorno
End Try
end function

public function string of_reprocessar_sem_msg (string ps_xml, ref string ps_erro);Boolean lb_Sucesso = True

String ls_Retorno = ''

If Not This.of_Proxy_Create( ) Then
	ps_erro = 'Erro no Proxy Create'
	Return ''
End If

Try
	If This.is_ambiente_producao = 'S' Then	
		ls_Retorno = ipr_sefazsc_prod.reprocessararquivo( ps_xml )
	Else
		ls_Retorno = ipr_sefazsc.reprocessararquivo( ps_xml )
	End If
	
Catch ( SoapException e ) // Soap
	ps_erro = 'Erro na conex$$HEX1$$e300$$ENDHEX$$o com a Sefaz: ' + e.getMessage( )
		
Finally // Soap
	This.of_Proxy_Destroy( )
	Return ls_Retorno
End Try
end function

on uo_ge038_ws.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge038_ws.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;
String ls_producao

If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = 'FI' Then
	Select vl_parametro
	Into :ls_producao
	From parametro_loja
	Where cd_filial = :gvo_parametro.cd_filial
	And cd_parametro = 'ID_BLOCOX_PRODUCAO'
	Using SQLCa;
	
	This.is_ambiente_producao = ls_producao
Else
	uo_Parametro_Filial lvo_Parametro
	lvo_Parametro = Create uo_Parametro_Filial
	
	lvo_Parametro.of_Localiza_Parametro("ID_BLOCOX_PRODUCAO", ref This.is_ambiente_producao, False)
	
	Destroy(lvo_Parametro)
End If
end event

