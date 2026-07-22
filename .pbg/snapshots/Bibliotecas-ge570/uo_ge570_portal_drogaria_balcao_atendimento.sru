HA$PBExportHeader$uo_ge570_portal_drogaria_balcao_atendimento.sru
forward
global type uo_ge570_portal_drogaria_balcao_atendimento from nonvisualobject
end type
end forward

global type uo_ge570_portal_drogaria_balcao_atendimento from nonvisualobject
end type
global uo_ge570_portal_drogaria_balcao_atendimento uo_ge570_portal_drogaria_balcao_atendimento

type variables
Long il_Sequencial_Cliente_Caixa

String is_CentralNumber
String is_NR_AUTORIZACAO

String is_TOKEN
String is_Codigo_Barras
String is_CPF						//CPF do cliente
String is_Nr_Cartao_Programa	//C$$HEX1$$f300$$ENDHEX$$digo do Cart$$HEX1$$e300$$ENDHEX$$o do Programa
Date idt_Nascimento				//Data de Nascimento do cliente n$$HEX1$$e300$$ENDHEX$$o identificado

//Dados Obrigatorios Cadastro prd
String is_tipo_prescritor
String is_nr_registro_prescritor
String is_uf_prescritor
String is_nm_prescritor

String is_fone_celular
String is_fone_fixo
String is_email
//Fim Dados Obrigatorios

Any ia_Null

Decimal{2} idc_Preco_Bruto
Decimal{2} idc_Preco_Liquido

uo_Cliente io_Cliente
uo_ge570_portal_drogaria_comum io_Comum
uo_ge073_json io_Json

uo_Produto io_Produto

dc_uo_api	io_api		//GE040

dc_uo_transacao iuo_SqlCa_log

dc_uo_ds_base ids_produtos_atendimento
dc_uo_ds_base ids_produtos_autorizados





end variables

forward prototypes
public function boolean of_atualiza_tabela_log (integer ai_tipo, string as_status, string as_cod_barras, string as_mensagem, ref string as_erro)
public function boolean of_consulta_produto (string as_ean, decimal adc_preco_bruto, decimal adc_preco_liquido)
public function boolean of_processa_erro (string as_json)
public function boolean of_autenticacao_produto (string as_ean, ref string as_json_retorno, ref string as_erro)
public function boolean of_processa_retorno_ativa_consumidor (string as_json, string as_ean_aceite, ref string as_erro)
public function boolean of_processa_retorno_carrinho (string as_json, ref string as_erro)
public function boolean of_autenticacao_prd_cliente (string as_ean, ref string as_json_retorno, ref string as_erro)
public function boolean of_autenticacao_carrinho (ref string as_json_retorno, ref string as_erro)
public function boolean of_finaliza_carrinho ()
public function boolean of_realiza_adesao (string as_tipo_ativacao, string as_ean_termo_aceito)
public function boolean of_autenticacao_ativa_consumidor (string as_cpf, string as_ean_termo_aceite, ref string as_json_retorno, ref string as_erro)
public function boolean of_monta_json_prd_desconto (boolean ab_envia_preco, string as_ean_termo_aceite, ref string as_json_produtos, ref string as_erro)
public function boolean of_carrega_dados_json (string as_json, string as_ean_aceite, boolean ab_abre_tela_desconto, ref string as_erro)
public function boolean of_atualiza_cliente_caixa_produto (long al_produto, long al_qtde, integer ai_status, decimal adc_vl_desconto, long al_qtde_aprovada)
public function boolean of_consulta_produto_cliente (string as_nr_cartao_programa, string as_cupom_desconto, ref string as_log)
end prototypes

public function boolean of_atualiza_tabela_log (integer ai_tipo, string as_status, string as_cod_barras, string as_mensagem, ref string as_erro);//String ls_Erro
//String ls_Null
//
////Abre uma nova transa$$HEX2$$e700e300$$ENDHEX$$o com o banco para gravar o registro
//If Not This.of_Abre_Conexao( Ref ls_Erro ) Then Return False
//
//Insert into log_integracao_interplayer(id_tipo, dh_inclusao, id_status, cd_codigo_barras, de_msg )
//Values (:ai_Tipo,  getdate(), :as_Status, :as_Cod_Barras, :as_mensagem )
//Using iuo_SqlCa_log;
//
//If iuo_SqlCa_log.SqlCode = - 1 Then
//	as_Erro = 'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_tabela_log ~n' + 'Erro ao inserir registro na tabela "log_integracao_interplayer": ' + iuo_SqlCa_log.sqlerrtext
//	iuo_SqlCa_log.of_Rollback()
//	Return False
//End If	
//
//iuo_SqlCa_log.of_Commit();
//
//this.of_fecha_conexao( )

Return True
end function

public function boolean of_consulta_produto (string as_ean, decimal adc_preco_bruto, decimal adc_preco_liquido);Boolean lb_Visualiza_Tela_Desconto = False

String ls_Json_Retorno
String ls_Erro, ls_Log
String ls_Null

SetNull(ls_Null)

Try
	//Apenas na Conulta de Produto sem o CLiente mostrar$$HEX1$$e100$$ENDHEX$$ a tela com os descontos
	lb_Visualiza_Tela_Desconto = True
	
	//Atribui valor nas variaives de instancia
	idc_Preco_Bruto 	= adc_preco_bruto
	idc_Preco_Liquido	= adc_preco_liquido
	
	//EAN para grava$$HEX2$$e700e300$$ENDHEX$$o de LOG
	is_Codigo_Barras = as_ean
	
	//Busca o Token de Acesso
	If Not io_Comum.of_gera_token( Ref ls_erro) Then
		io_Comum.of_envia_email(ls_erro)
		Return False
	End If
	
	//utiliza o Token p/ buscar
	If Not This.of_Autenticacao_Produto(as_EAN, Ref ls_Json_Retorno, Ref ls_Log) Then
		io_Comum.of_envia_email(ls_Log)			
		Return False
	End If
	
	//Tratamento de Erro
	If PosA(ls_Json_Retorno, '"error"') >0 Then
		If Not This.of_Processa_Erro(ls_Json_Retorno) Then
			io_Comum.of_envia_email( ls_Json_Retorno )
			Return False
		End If
	Else
		If Not of_Carrega_Dados_Json(ls_Json_Retorno, ls_Null, lb_Visualiza_Tela_Desconto, Ref ls_Log) Then		
			io_Comum.of_envia_email(ls_Log)
			Return False
		End If	
	End If
	
	Return True
	
Catch (RunTimeError lo_error)
	io_Comum.of_envia_email(lo_error.GetMessage())
	Return False
	
Finally

End Try
end function

public function boolean of_processa_erro (string as_json);String ls_Erros, ls_Retorno, ls_Sobra, ls_ErroEmail, ls_Null

String ls_Mensagem_log, ls_informativeText, ls_returnCode, ls_object


Try
	SetNull(ls_Null)
	 
	If Not IsNUll(This.is_CPF) Then  //Usado na ATIVA
	
		If Posa(as_Json, "informativeText") > 0 Then
			ls_object	 			= io_json.of_busca_conteudo_campo_vtex(as_Json, 'object') 	 
			ls_returnCode		= io_json.of_busca_conteudo_campo_vtex(as_Json, 'returnCode') 
			ls_informativeText	= io_json.of_busca_conteudo_campo_vtex(as_Json, 'informativeText') 		
		End If
	
		If IsNull(ls_object) 			Then ls_object 				= "N INFORMADO"
		If IsNull(ls_returnCode) 		Then ls_returnCode 		= "N INFORMADO"
		If IsNull(ls_informativeText) Then ls_informativeText 	= "N INFORMADO"
		
		ls_Mensagem_log = "object:" + ls_object + "~rreturnCode:" + ls_returnCode + "~rinformativeText:" + ls_informativeText + "~r"
	
	Else
		io_json.of_divide_grupo_json_tag_vtex( ref as_json, 'error', ref  ls_Erros, 'control' )

		//Produtos
		Do While io_json.of_divide_grupo_json_completo( Ref ls_Erros, Ref ls_retorno,'{' )
			
			ls_sobra 	= ls_retorno
			
			ls_object	 			= io_json.of_busca_conteudo_campo_vtex(ls_sobra, 'object') 	 
			ls_returnCode		= io_json.of_busca_conteudo_campo_vtex(ls_sobra, 'returnCode') 
			ls_informativeText	= io_json.of_busca_conteudo_campo_vtex(ls_sobra, 'informativeText') 	
			
			If IsNull(ls_object) 			Then ls_object 				= "N INFORMADO"
			If IsNull(ls_returnCode) 		Then ls_returnCode 		= "N INFORMADO"
			If IsNull(ls_informativeText) Then ls_informativeText 	= "N INFORMADO"
				
			ls_Mensagem_log = "object:" + ls_object + "~rreturnCode:" + ls_returnCode + "~rinformativeText:" + ls_informativeText + "~r"		
		Loop //Produtos
		
	End If
	
	If ls_Mensagem_log <> '' Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o",  ls_Mensagem_log)
		io_Comum.of_envia_email(ls_Mensagem_log)	
	End If	

	Return True
	
Catch (RunTimeError lo_error)
	io_Comum.of_envia_email(lo_error.GetMessage())
	Return False
	
Finally

End Try



end function

public function boolean of_autenticacao_produto (string as_ean, ref string as_json_retorno, ref string as_erro);String ls_Json_Envio
String ls_Terminal
String ls_data
String ls_TableID
String ls_CNPJ

DateTime ldt_Parametro

SetNull(as_Json_Retorno)

If Not This.io_Comum.of_verifica_url_integracao('URL_CONSULTAPRODUTO', Ref as_Erro) Then
 	Return False
End If

//Nome do PDV
ls_Terminal 		= gvo_Aplicacao.of_computername( )

ldt_Parametro 	= gf_GetServerDate()
ls_Data			= String(ldt_Parametro, "YYYY-MM-DD")+"T"+String(ldt_Parametro, "HH:MM:SS")	  			  

ls_TableID 		= io_Comum.is_Table_ID	
	
/*discountType
B = calculo sobre o preco BRUTO
L = calculo sobre o preco LIQUIDO
*/

ls_CNPJ = Gvo_Parametro.nr_cgc

ls_Json_Envio = '{ "control": {' +&
							  '"clientId": "' + io_Comum.is_cliente_id +'",'	+&
							  '"username": "CLAMED",'							+& 
							  '"tableId": "' + io_Comum.is_table_id + '",'		+&
							  '"localNumber": "1",'									+&
							  '"localHour": "' + ls_Data + '",' 					+&						
							  '"industryId": "999",'									+&
							  '"stationId": "' + ls_Terminal+'",'					+&
							  '"terminalId": "BALCAO",'							+&
							  '"companyCode": "' + ls_CNPJ +'",'				+&
							  '"attendanceHash": "",'								+&
							  '"softwareId": "CAIXA' +gvo_Aplicacao.ivs_Versao+ '"'	+&
						 '},'															+&
						 '"product": [' 												+&
							 '{' 														+&
									'"id": 1,' 											+&
									'"EAN": ' + as_EAN + ','						+&
									'"requestedQuantity": 1,'						+&
									'"listPrice": ' + gf_retorna_so_numeros( String(idc_Preco_Bruto) )	+ ','	+&
									'"netPrice": ' + gf_retorna_so_numeros( String(idc_preco_liquido) )	+ ','	+&
									'"discountType": "L"'			+&
							  '}'										+&
						 ']}'
	
If Not io_Comum.of_post( ls_json_Envio, "", ref as_Json_Retorno, ref as_Erro ) Then Return False

Return True
end function

public function boolean of_processa_retorno_ativa_consumidor (string as_json, string as_ean_aceite, ref string as_erro);String ls_itens, ls_sobra_Produto, ls_retorno
String ls_Ean, ls_Industria, ls_Mensagem
String ls_Log, ls_Null, ls_erro
String ls_InformativeText
String ls_EAN_TERMO_ACEITE_LOCAL

String ls_Json_Control, ls_flowDeviation, ls_url

Decimal ldc_Desc, ldc_PC_Desc, ldc_Desc_Industria, ldc_Preco_Un
Decimal ldc_PC_desconto_Fixo, ldc_Preco_Liquido

Integer ll_Qtde_Autorizada, li_Row, li_Status

String ls_Aux

Try
	SetNull( ls_Null )
	
	io_json.of_divide_grupo_json_tag(Ref ls_Aux, 'control', Ref ls_Json_Control,'}') 
	
	uo_Produto lo_Produto
	lo_Produto = Create uo_Produto
	
	//Ir$$HEX1$$e100$$ENDHEX$$ buscar:
	//De: product At$$HEX1$$e900$$ENDHEX$$: returnCode
	io_json.of_divide_grupo_json_tag_vtex( ref as_json, 'product', ref ls_itens, 'returnCode')
		
	//Produtos
	Do While io_json.of_divide_grupo_json_completo(Ref ls_itens, Ref ls_retorno,'{')
		
		ls_sobra_Produto 	= ls_retorno
									
		ls_Ean					= io_json.of_busca_conteudo_campo_vtex(ls_sobra_Produto, 'ean')
		ll_Qtde_Autorizada 	= Integer( io_json.of_busca_conteudo_campo_vtex(ls_sobra_Produto, 'authorizedQuantity') )
	 	ldc_Desc					= gf_decimal( io_json.of_busca_conteudo_campo_vtex(ls_sobra_Produto, 'discountValue'), 2)
		ldc_PC_Desc			= gf_decimal( io_json.of_busca_conteudo_campo_vtex(ls_sobra_Produto, 'discountPercentual'), 2 )
		ldc_Desc_Industria		= gf_decimal( io_json.of_busca_conteudo_campo_vtex(ls_sobra_Produto, 'discountValueIndustry'), 2 )
		ls_Industria				= io_json.of_busca_conteudo_campo_vtex(ls_sobra_Produto, 'industryName') 
		ls_Mensagem			= io_json.of_busca_conteudo_campo_vtex(ls_sobra_Produto, 'informativeMessage')
		li_Status					= Integer(io_json.of_busca_conteudo_campo_vtex(ls_sobra_Produto, 'status'))
			
		If li_Status <> 0 Then
			//Status diferente de ZERO o produto n$$HEX1$$e300$$ENDHEX$$o pertence ao PBM e ser$$HEX1$$e100$$ENDHEX$$ desconsiderado			
			Continue
		End If
		
		lo_Produto.of_localiza_codigo_barras( ls_Ean )
		
		If Not lo_Produto.localizado Then
			ls_Log = "Fun$$HEX2$$e700e300$$ENDHEX$$o: of_carrega_dados_json - Produto n$$HEX1$$e300$$ENDHEX$$o localizado. EAN: " + ls_Ean
			io_Comum.of_envia_email(ls_Log)	
			Continue
		End If
							
	Loop //Produtos

	Return True

Catch (RunTimeError lo_error)
	io_Comum.of_envia_email(lo_error.GetMessage())
	Return False
	
Finally
	If IsValid(lo_Produto)	Then Destroy lo_Produto
End Try
end function

public function boolean of_processa_retorno_carrinho (string as_json, ref string as_erro);String ls_Aux
String ls_Json_Control, ls_Json_Transaction
String ls_itens, ls_sobra_Produto, ls_retorno

String ls_Ean
String ls_Industria
String ls_Mensagem
String ls_Null
String ls_Log
String ls_ReturCode
String ls_InformativeText

Long ll_Qt_Vendida
Long ll_Produto

Decimal ldc_Desc
Decimal ldc_PC_Desc
Decimal ldc_Desc_Industria

Decimal ldc_Vl_Bruto, ldc_Vl_Liquido, ldc_Pc_Loja

Integer li_Status, li_Find, li_Row, li_Qtde_Autorizada
Integer li_Linha_Nao_Autorizados

Try
	SetNull( ls_Null )
	
	ls_Aux = as_Json
		
	ls_ReturCode			= io_json.of_busca_conteudo_campo_vtex(as_Json, 'returnCode')
	ls_InformativeText		= io_json.of_busca_conteudo_campo_vtex(as_Json, 'informativeText')	
		
	//Verifica situa$$HEX2$$e700f500$$ENDHEX$$es espec$$HEX1$$ed00$$ENDHEX$$fica da industria/produto
	Choose Case ls_ReturCode
		Case 'N000'
			//Sucesso
		Case Else
			//F844 - Qtd.enviada superior a do Kit"
			MessageBox("Integra$$HEX2$$e700e300$$ENDHEX$$o Portal Drogaria", "Retorno API:~r~r"+ls_InformativeText)
			Return False
	End Choose	
		
	uo_Produto lo_Produto
	lo_Produto = Create uo_Produto
	
	io_json.of_divide_grupo_json_tag(Ref ls_Aux, 'control',		Ref ls_Json_Control,'}') 
	io_json.of_divide_grupo_json_tag(Ref ls_Aux, 'transaction', Ref ls_Json_Transaction,'}') 
	
	is_CentralNumber 		= io_json.of_busca_conteudo_campo_vtex(ls_Json_Control, 'centralNumber')
	is_NR_AUTORIZACAO 	= io_json.of_busca_conteudo_campo_vtex(ls_Json_Transaction, 'transactionCode')
		
	//Ir$$HEX1$$e100$$ENDHEX$$ buscar:
	//De: product At$$HEX1$$e900$$ENDHEX$$: returnCode
	io_json.of_divide_grupo_json_tag_vtex( ref as_json, 'product', ref ls_itens, 'transaction')
	
	//Inicializa os produtos autorizados
	This.ids_produtos_autorizados.Reset()
	
	//Produtos
	Do While io_json.of_divide_grupo_json_completo(Ref ls_itens, Ref ls_retorno,'{')
		
		ls_sobra_Produto 	= ls_retorno
									 
		ls_Ean					= io_json.of_busca_conteudo_campo_vtex(ls_sobra_Produto, 'ean')
		li_Qtde_Autorizada 	= Integer( io_json.of_busca_conteudo_campo_vtex(ls_sobra_Produto, 'authorizedQuantity') )
	 	ldc_Desc					= gf_decimal( io_json.of_busca_conteudo_campo_vtex(ls_sobra_Produto, 'discountValue'), 2)
		ldc_PC_Desc			= gf_decimal( io_json.of_busca_conteudo_campo_vtex(ls_sobra_Produto, 'discountPercentual'), 2 )
		ldc_Desc_Industria		= gf_decimal( io_json.of_busca_conteudo_campo_vtex(ls_sobra_Produto, 'discountValueIndustry'), 2 ) //Desconto adicional da industria
		ls_Industria				= io_json.of_busca_conteudo_campo_vtex(ls_sobra_Produto, 'industryName') 
		ls_Mensagem			= io_json.of_busca_conteudo_campo_vtex(ls_sobra_Produto, 'informativeMessage')
		li_Status					= Integer(io_json.of_busca_conteudo_campo_vtex(ls_sobra_Produto, 'status'))
			
//		If li_Status <> 0 Then
//			//Status diferente de ZERO o produto n$$HEX1$$e300$$ENDHEX$$o pertence ao PBM e ser$$HEX1$$e100$$ENDHEX$$ desconsiderado			
//			Continue
//		End If
		
		lo_Produto.of_localiza_codigo_barras( ls_Ean )
		
		If Not lo_Produto.localizado Then
			ls_Log = "Fun$$HEX2$$e700e300$$ENDHEX$$o: of_carrega_dados_json - Produto n$$HEX1$$e300$$ENDHEX$$o localizado. EAN: " + ls_Ean
			io_Comum.of_envia_email(ls_Log)	
			Continue
		End If
								
		li_Find = ids_produtos_atendimento.Find("cd_produto = " + String(lo_Produto.cd_produto), 1, ids_produtos_atendimento.RowCount())
		
		If li_Find = 0 Then
			ls_Log = "Fun$$HEX2$$e700e300$$ENDHEX$$o: of_carrega_dados_json - Produto do retotno n$$HEX1$$e300$$ENDHEX$$o localizado nos produtos do atendimento. EAN: " + ls_Ean
			io_Comum.of_envia_email(ls_Log)	
			Continue
		End If
		
		If li_Find > 0 Then
			ll_Qt_Vendida 	= ids_produtos_atendimento.Object.qt_produto			[ li_Find ]
			ldc_Vl_Bruto		= ids_produtos_atendimento.Object.vl_preco_bruto		[ li_Find ]
			ldc_Vl_Liquido	= ids_produtos_atendimento.Object.vl_preco_liquido		[ li_Find ]
			ldc_Pc_Loja		= ids_produtos_atendimento.Object.pc_desconto_loja	[ li_Find ]  	

			If IsNull(ldc_Pc_Loja) Then ldc_Pc_Loja = 0
		End If
		
		//Industria DERMACLUB n$$HEX1$$e300$$ENDHEX$$o entra na carga
		If ls_Industria = 'DERMACLUB' Then
			Continue	
		End If
		
		If ldc_Desc > 0 Then
			ldc_Vl_Liquido = (ldc_Vl_Liquido * li_Qtde_Autorizada) - ldc_Desc
		End If

		li_Row = This.ids_produtos_autorizados.InsertRow(0)
		
		This.ids_produtos_autorizados.object.cd_produto				[li_Row] = lo_Produto.cd_produto 
		This.ids_produtos_autorizados.object.nm_produto				[li_Row] = lo_Produto.ivs_descricao_apresentacao_venda 
		This.ids_produtos_autorizados.object.de_codigo_barras		[li_Row] = ls_Ean 
		This.ids_produtos_autorizados.object.qt_autorizada			[li_Row] = li_Qtde_Autorizada
		This.ids_produtos_autorizados.object.qt_vendida				[li_Row] = ll_Qt_Vendida
		This.ids_produtos_autorizados.object.vl_preco_bruto			[li_Row] = ldc_Vl_Bruto
		This.ids_produtos_autorizados.object.vl_preco_liquido		[li_Row] = ldc_Vl_Liquido
		This.ids_produtos_autorizados.object.pc_desconto			[li_Row] = ldc_PC_Desc
		This.ids_produtos_autorizados.object.id_erro					[li_Row] = li_Status	
		This.ids_produtos_autorizados.object.de_msg_retorno		[li_Row] = ls_Mensagem
		This.ids_produtos_autorizados.object.pc_desconto_padrao	[li_Row] = ldc_Pc_Loja
		
		//Atualiza$$HEX2$$e700e300$$ENDHEX$$o da cliente caixa produto
		If Not of_atualiza_cliente_caixa_produto( lo_Produto.cd_produto, ll_Qt_Vendida,  li_Status, ldc_Desc, li_Qtde_Autorizada ) Then
			Return False
		End If
		
	Loop //Produtos

	If ids_produtos_autorizados.RowCount() > 0 Then
		
		//Adiciona os produtos que nao foram enviados no json do carrinho
		ids_produtos_atendimento.setfilter( "id_envia_carrinho='N'")
		ids_produtos_atendimento.filter( )
		
		FOR li_Row = 1 To ids_produtos_atendimento.RowCount()
			ll_Produto = ids_produtos_atendimento.Object.cd_produto[ li_Row ] 
		
			lo_Produto.of_localiza_codigo_Interno( ll_Produto )
			
			li_Linha_Nao_Autorizados = This.ids_produtos_autorizados.insertrow( 0 )
			
			This.ids_produtos_autorizados.object.cd_produto				[li_Linha_Nao_Autorizados] = lo_Produto.cd_produto 
			This.ids_produtos_autorizados.object.nm_produto				[li_Linha_Nao_Autorizados] = lo_Produto.ivs_descricao_apresentacao_venda 
			This.ids_produtos_autorizados.object.de_codigo_barras		[li_Linha_Nao_Autorizados] = lo_Produto.de_codigo_barras
			This.ids_produtos_autorizados.object.qt_autorizada			[li_Linha_Nao_Autorizados] = 0
			This.ids_produtos_autorizados.object.id_erro					[li_Linha_Nao_Autorizados] = 1
			This.ids_produtos_autorizados.object.de_msg_retorno		[li_Linha_Nao_Autorizados] = ids_produtos_atendimento.Object.de_log_api[li_Row]
			
		NEXT
		
		OpenWithParm( w_ge570_confirmar_autorizacao, ids_produtos_autorizados )
		 
		 //Grava na cliente Caixa
		 Update cliente_caixa set nr_autorizacao_pbm = :is_NR_AUTORIZACAO 
		 	Where nr_sequencial = :il_Sequencial_Cliente_Caixa
			 Using SqlCa;
			 
			 If SqlCa.SqlCode = -1 Then
				SqlCa.of_Rollback( )
				SqlCa.of_MsgDbError("Erro ao gravar a autorizacao na cesta de atendimento.")
				io_Comum.of_envia_email(SqlCa.sqlerrtext )
			 End If
			
			 SqlCa.of_Commit()
	End If

	Return True

Catch (RunTimeError lo_error)
	io_Comum.of_envia_email(lo_error.GetMessage())
	Return False
	
Finally
	If IsValid(lo_Produto)		Then Destroy lo_Produto
End Try
end function

public function boolean of_autenticacao_prd_cliente (string as_ean, ref string as_json_retorno, ref string as_erro);Boolean lb_Envia_Preco = True

String ls_Json_Envio
String ls_Terminal
String ls_data
String ls_Json_Produtos

String ls_data_Nascimento
String ls_Fone_Celular, ls_Fone
String ls_DDD
String ls_Null

DateTime ldt_Parametro

SetNull(as_Json_Retorno)
SetNull(ls_Null)

If Not This.io_Comum.of_verifica_url_integracao('URL_CONSULTADESCONTO', Ref as_Erro) Then
 	Return False
End If

//Nome do PDV
ls_Terminal 		= gvo_Aplicacao.of_computername(  )

ldt_Parametro 	= gf_GetServerDate()
ls_Data			= String(ldt_Parametro, "YYYY-MM-DD")+"T"+String(ldt_Parametro, "HH:MM:SS")
		  		
//Formata todos os produtos da tela de atendimento para submeter a consulta dos descontos do cliente
If Not This.of_monta_json_prd_desconto( lb_Envia_Preco, ls_Null,  Ref ls_Json_Produtos, Ref as_Erro) Then
	io_Comum.of_envia_email( "Fun$$HEX2$$e700e300$$ENDHEX$$o: of_autenticacao_prd_cliente - Erro ao montar o json do grupo dos produtos.")
	Return False
End If
			
io_Cliente.of_localiza_cpf(is_CPF)

ls_data_Nascimento 	= String(io_Cliente.dh_nascimento , "YYYY-MM-DD")+"T00:00:00"

//Zera o CentralNumber
This.is_CentralNumber  = '0'

If IsNull( This.is_nr_cartao_programa ) Then This.is_nr_cartao_programa = 'null'

ls_Json_Envio = '{ "control": {' 																	+&
							  '"clientId": "' + io_Comum.is_cliente_id +'",'	+&
							  '"username": "CLAMED",'							+& 
							  '"tableId": "' + io_Comum.is_table_id + '",'		+&
							  '"localNumber": "1",'									+&
							  '"centralNumber": ' + is_CentralNumber + ','	+&
							  '"localHour": "' + ls_Data + '",' 					+&						
							  '"industryId": "999",'									+&
							  '"stationId": "' + ls_Terminal + '",'				+&
							  '"terminalId": "BALCAO",'							+&
							  '"companyCode": "99999994002455",'			+&
							  '"attendanceHash": "",'								+&
							  '"softwareId": "CER09999999424A"'				+&
						 '},'															+&
						 '"consumer": {'											+&
						  '"holderId": "' + is_CPF + '",'							+&
						  '"cardId": ' + This.is_nr_cartao_programa + ','	+&
						  '"cardIdCompany": null,	'								+&	
						  '"idCompany": null,'										+&
						  '"cardIdOperator": null,'								+&	
						  '"idOperator": null,'										+&
						  '"birthdate": "' + ls_data_Nascimento + '",'			+&	
						  '"cellphone": "' + This.is_fone_celular +'",'			+&
						  '"phone": "' + This.is_fone_fixo + '",'				+&	
						  '"email": ""'												+&		
						'},'																+&
						 '"product": [' 												+&
	/*Produtos*/	      ls_Json_Produtos										+&		
						 ']}'
	
If Not io_Comum.of_post( ls_json_Envio, "", ref as_Json_Retorno, ref as_Erro ) Then Return False

Return True
end function

public function boolean of_autenticacao_carrinho (ref string as_json_retorno, ref string as_erro);Boolean lb_Envia_Preco = True

String ls_Json_Envio
String ls_Terminal
String ls_data
String ls_data_Nascimento
String ls_Json_Produtos
String ls_Fone_Celular
String ls_Fone
String ls_Null

DateTime ldt_Parametro

SetNull(as_Json_Retorno)
SetNull(ls_Null)

If Not This.io_Comum.of_verifica_url_integracao('URL_CARRINHO', Ref as_Erro) Then
 	Return False
End If

//Nome do PDV
ls_Terminal 		= gvo_Aplicacao.of_computername(  )

ldt_Parametro 	= gf_GetServerDate()
ls_Data			= String(ldt_Parametro, "YYYY-MM-DD")+"T"+String(ldt_Parametro, "HH:MM:SS")
		  		
//Formata todos os produtos da tela de atendimento para submeter a consulta dos descontos do cliente
If Not This.of_monta_json_prd_desconto(lb_Envia_Preco, ls_Null, Ref ls_Json_Produtos, Ref as_Erro) Then
	io_Comum.of_envia_email( "Fun$$HEX2$$e700e300$$ENDHEX$$o: of_autenticacao_prd_cliente - Erro ao montar o json do grupo dos produtos.")
	Return False
End If

//Localiza_Cliente
io_Cliente.of_localiza_cpf(is_CPF)

ls_data_Nascimento 	= String(io_Cliente.dh_nascimento , "YYYY-MM-DD")+"T00:00:00"
ls_Fone_Celular		= String(Integer(io_Cliente.nr_ddd_celular),'000') + io_Cliente.nr_fone_celular
ls_Fone					= String(Integer(io_Cliente.nr_ddd_fone),'000')  + io_Cliente.nr_fone
		
If IsNull(ls_Fone_Celular) 	Then ls_Fone_Celular		= ""
If IsNull(ls_Fone) 				Then ls_Fone 			 	= ""
		
ls_Json_Envio = '{ "control": {' 																	+&
							  '"clientId": "' + io_Comum.is_cliente_id +'",'	+&
							  '"username": "CLAMED",'							+& 
							  '"tableId": "' + io_Comum.is_table_id + '",'		+&
							  '"localNumber": "1",'									+&
							  '"localHour": "' + ls_Data + '",' 					+&						
							  '"centralNumber":' +is_CentralNumber+ 	','	+&
							  '"industryId": "999",'									+&
							  '"stationId": "' + ls_Terminal+	'",'		        	 	+&
							  '"terminalId": "BALCAO",'							+&
							  '"companyCode": "99999994002455",'			+&
							  '"attendanceHash": "",'								+&
							  '"softwareId": "CER09999999424A"'				+&
						 '},'															+&
						 '"transaction": {'											+&
							  '"transactionCode": "",'								+&
							  '"providerCode": ""'									+&
						 '},'															+&
						 '"consumer": {'											+&
							    '"holderId": "' + is_CPF + '",'						+&
							    '"cardId": "",'										+&
								'"cardIdCompany": null,'							+&
								'"idCompany": null,'								+&
								'"birthdate": "' + ls_data_Nascimento + '",'	+&
								'"cardIdOperator": null,'							+&
								'"idOperator": null'									+&
						'},'																+&
						 '"product": [' 												+&
	/*Produtos*/	      ls_Json_Produtos										+&		
						 ']}'
	
If Not io_Comum.of_post( ls_json_Envio, "", ref as_Json_Retorno, ref as_Erro ) Then Return False

Return True

end function

public function boolean of_finaliza_carrinho ();String ls_Erro, ls_Log
String ls_Null

String ls_Json_Retorno

Try
	SetNull(ls_Null)
		
	//Busca o Token de Acesso
	If Not io_Comum.of_gera_token( Ref ls_erro) Then
		io_Comum.of_envia_email(ls_erro)
		Return False
	End If
	
	If Not This.of_autenticacao_carrinho( Ref ls_Json_Retorno, Ref ls_erro) Then
		io_Comum.of_envia_email(ls_Log)			
		Return False
	End If
	
	//Tratamento de Erro
	If PosA(ls_Json_Retorno, '"error"') > 0 Then
		If Not This.of_Processa_Erro(ls_Json_Retorno) Then
			Return False
		End If
	Else
		If Not This.of_processa_retorno_carrinho( ls_Json_Retorno, Ref ls_Log) Then				
			//io_Comum.of_envia_email(ls_Log)
			Return False
		End If	
	End If	

	Return True

Catch (RunTimeError lo_error)
	io_Comum.of_envia_email(lo_error.GetMessage())
	Return False
	
Finally

End Try
end function

public function boolean of_realiza_adesao (string as_tipo_ativacao, string as_ean_termo_aceito);/*
			ATIVA1 : Ativa$$HEX2$$e700e300$$ENDHEX$$o Simples : Dados do Profissional de sa$$HEX1$$fa00$$ENDHEX$$de
			ATIVA2 : Dados b$$HEX1$$e100$$ENDHEX$$sicos do consumidor
			ATIVA3 : Dados b$$HEX1$$e100$$ENDHEX$$sicos do consumidor e Dados do profissional de sa$$HEX1$$fa00$$ENDHEX$$de
			ATIVA4 : Ativa$$HEX2$$e700e300$$ENDHEX$$o Plena do consumidor, SEM Dados do profissional de sa$$HEX1$$fa00$$ENDHEX$$de
			ATIVA5 : Ativa$$HEX2$$e700e300$$ENDHEX$$o Plena do consumidor, COM Dados do profissional de sa$$HEX1$$fa00$$ENDHEX$$de
*/

String ls_Erro, ls_Log
String ls_Null

String ls_Json_Retorno

Try
	SetNull(ls_Null)
	
	Choose Case as_tipo_ativacao
		Case 'ATIVA1'
			//UF, C$$HEX1$$f300$$ENDHEX$$digo (CRM, CRO, etc) e Nome do Profissional
			
		Case 'ATIVA2'
			//Telefone Celular e Nome para contato (como deseja ser chamado)
			//Aceite do Termo para participa$$HEX2$$e700e300$$ENDHEX$$o no programa
			
		Case 'ATIVA3'
			//Telefone Celular e Nome para contato (como deseja ser chamado)
			//Aceite do Termo para participa$$HEX2$$e700e300$$ENDHEX$$o no programa
			//UF, C$$HEX1$$f300$$ENDHEX$$digo (CRM, CRO, etc) e Nome do Profissional
			
	
		Case 'ATIVA4'
			//Telefone Celular e Nome para contato (como deseja ser chamado)
			//Aceite do Termo para participa$$HEX2$$e700e300$$ENDHEX$$o no programa
			//Aceite Por Telefone/Por Correio/Por SMS/Por E-mail
	

		Case 'ATIVA5'
			//Telefone Celular e Nome para contato (como deseja ser chamado)
			//Nome Completo, Data Nascimento, Sexo, Telefone Fixo, Endere$$HEX1$$e700$$ENDHEX$$o Completo
			//Aceite do Termo para participa$$HEX2$$e700e300$$ENDHEX$$o no programa
			//Aceites de Contato da Ind$$HEX1$$fa00$$ENDHEX$$stria:  Telefone/Por Correio/Por SMS/Por E-mail
			//UF, C$$HEX1$$f300$$ENDHEX$$digo (CRM, CRO, etc) e Nome do Profissional
			
	End Choose
			
	//Busca o Token de Acesso
	If Not io_Comum.of_gera_token( Ref ls_erro) Then
		io_Comum.of_envia_email(ls_erro)
		Return False
	End If
	
	If Not This.of_Autenticacao_Ativa_Consumidor( is_CPF, ls_Null, Ref ls_Json_Retorno, Ref ls_erro) Then
		io_Comum.of_envia_email(ls_erro)			
		Return False
	End If
	
	//Tratamento de Erro
	If PosA(ls_Json_Retorno, '"error"') >0 Then
		If Not This.of_Processa_Erro(ls_Json_Retorno) Then
			Return False
		End If
	Else
		If Not of_Processa_Retorno_Ativa_Consumidor(ls_Json_Retorno, ls_Null, Ref ls_Log) Then		
			Return False
		End If	
	End If	
	
	Return True
	
Catch (RunTimeError lo_error)
	io_Comum.of_envia_email(lo_error.GetMessage())
	Return False
	
Finally

End Try
end function

public function boolean of_autenticacao_ativa_consumidor (string as_cpf, string as_ean_termo_aceite, ref string as_json_retorno, ref string as_erro);Boolean lb_Envia_Preco = False

String ls_Json_Envio
String ls_Terminal
String ls_data
String ls_data_Nascimento
String ls_Json_Produtos
String ls_Fone_Celular
String ls_Fone
String ls_Null

DateTime ldt_Parametro

SetNull(as_Json_Retorno)
SetNull(ls_Null)

If Not This.io_Comum.of_verifica_url_integracao('URL_ATIVA', Ref as_Erro) Then
 	Return False
End If

//Nome do PDV
ls_Terminal 		= gvo_Aplicacao.of_computername(  )

ldt_Parametro 	= gf_GetServerDate()
ls_Data			= String(ldt_Parametro, "YYYY-MM-DD")+"T"+String(ldt_Parametro, "HH:MM:SS")
		  		
//Formata todos os produtos da tela de atendimento para submeter a consulta dos descontos do cliente
If Not This.of_monta_json_prd_desconto(lb_Envia_Preco, ls_Null, Ref ls_Json_Produtos, Ref as_Erro) Then
	io_Comum.of_envia_email( "Fun$$HEX2$$e700e300$$ENDHEX$$o: of_autenticacao_prd_cliente - Erro ao montar o json do grupo dos produtos.")
	Return False
End If

//Localiza_Cliente
io_Cliente.of_localiza_cpf(is_CPF)

ls_data_Nascimento 	= String(io_Cliente.dh_nascimento , "YYYY-MM-DD")+"T00:00:00"
		
ls_Json_Envio = '{ "control": {' 																	+&
							  '"clientId": "' + io_Comum.is_cliente_id +'",'	+&
							  '"username": "CLAMED",'							+& 
							  '"tableId": "' + io_Comum.is_table_id + '",'		+&
							  '"localNumber": "1",'									+&
							  '"localHour": "' + ls_Data + '",' 					+&						
							  '"centralNumber": ' +is_CentralNumber+ ','	+&
							  '"industryId": "999",'									+&
							  '"stationId": "' + ls_Terminal+	'",'		        	 	+&
							  '"terminalId": "BALCAO",'							+&
							  '"companyCode": "99999994002455",'			+&
							  '"attendanceHash": "",'								+&
							  '"softwareId": "CER09999999424A"'				+&
						 '},'															+&
						 '"consumer": {'											+&
							    '"holderId": "' + is_CPF + '",'						+&
							    '"cardId": "",'										+&
								'"cardIdCompany": null,'							+&
								'"idCompany": null,'								+&
								'"cardIdOperator": null,'							+&
								'"idOperator": null,'								+&
								'"birthdate": "' + ls_data_Nascimento + '",'	+&
								'"name": "' + io_Cliente.Nm_Cliente +'",'		+&
								'"genre": "' + io_Cliente.id_sexo + '",'			+&	
								'"postalCode": "' + io_Cliente.nr_cep + '",'				+&
								'"stateCode": "' + io_Cliente.cd_uf + '",'					+&	
								'"cityName": "' + io_Cliente.nm_cidade  	+'",'			+&
								'"cityRegion": "' + io_Cliente.de_bairro 	+'",'			+&	
								'"addressType": "Av.",'										+&
								'"streetAddress": "'+ io_Cliente.de_endereco  + '",'	+&
								'"addressNumber": "' +io_Cliente.nr_endereco + '",'	+&		
								'"addressAdditionalInformation": "",' 			+&
								'"cellphone": "' + This.is_fone_celular + '",'	+&
								'"phone": "' + This.is_fone_fixo	+ '",'			+&
								'"email": "' + This.is_Email + '",'				+&	
								'"acceptTerm": "S",'								+&
								'"acceptInformativeMaterial": "N",'				+&	
								'"acceptMail": "N",'									+&
								'"acceptEmail": "N",'								+&		
								'"acceptCalls": "N",'								+&	
								'"acceptSMS": "N"'									+&		
						'},'																+&
						 '"product": [' 												+&
	/*Produtos*/	      ls_Json_Produtos										+&		
						 '],'															+&
						 '"healthProfessional": {'									+&
							'"type": "' + This.is_tipo_prescritor + '",'					+&
							'"id": "' + This.is_nr_registro_prescritor + '",'			+&
							'"stateCode": "'+This.is_uf_prescritor+'",'				+&	
							'"name": "' + This.is_nm_prescritor +'"'					+&		
						 '}}'
	
If Not io_Comum.of_post( ls_json_Envio, "", ref as_Json_Retorno, ref as_Erro ) Then Return False

Return True
end function

public function boolean of_monta_json_prd_desconto (boolean ab_envia_preco, string as_ean_termo_aceite, ref string as_json_produtos, ref string as_erro);/*
Esta fun$$HEX2$$e700e300$$ENDHEX$$o montara os itens que foram selecionados no momento do atendimento para serem enviados para o portal
O retorno ser$$HEX1$$e100$$ENDHEX$$ os descontos de cada item e/ou os desvios de fluxos existes
*/

Integer li_Row
Integer li_Linhas
Integer li_Qtde
Integer li_Find

String ls_EAN
String ls_JSON_Produtos

Decimal{2} ldc_Bruto
Decimal{2} ldc_Liquido

String ls_Envia_Carrinho

li_Linhas = ids_produtos_atendimento.RowCount()

If li_Linhas <= 0 Then
	as_Erro = "Nenhum produto foi selecionado"
	Return False
End If

//Envia somente o produto retornado para termo de aceite 
If Not IsNull(as_ean_termo_aceite) Then
	li_Find = ids_produtos_atendimento.find("de_codigo_barras = '" + as_ean_termo_aceite + "'", 1, li_Linhas )
	
	If li_Find < 0 Then
		as_Erro = "Erro ao localizar o EAN: " + as_ean_termo_aceite + " nos produtos do atendimentos (ids_produtos_atendimento)"
		Return False
	End If
	
	If li_Find > 0 Then
		li_Qtde				= ids_produtos_atendimento.object.qt_produto	 			[li_Find]
			
		//Utilizado na ATIVACAO do CLIENTE
		ls_JSON_Produtos = 	'{ "id":' + String(li_Row)	+','													+&
											'"EAN": ' + as_ean_termo_aceite + ','									+&
											'"requestedQuantity": ' + String(li_Qtde) + ' }'
	End If
	
Else
	
		For li_Row = 1 To li_Linhas
			
			ls_EAN				= ids_produtos_atendimento.object.de_codigo_barras 		[li_Row]
			li_Qtde				= ids_produtos_atendimento.object.qt_produto				 	[li_Row]
			ldc_Bruto				= ids_produtos_atendimento.object.vl_preco_bruto			[li_Row]
			ldc_Liquido			= ids_produtos_atendimento.object.vl_preco_liquido			[li_Row]
			ls_Envia_Carrinho 	= ids_produtos_atendimento.object.id_envia_carrinho		[li_Row]
			
			If ls_Envia_Carrinho = 'N' Then Continue
			
			If ab_Envia_Preco Then
				ls_JSON_Produtos += 	'{ "id":' + String(li_Row)	+','													+&
												'"EAN": ' + ls_EAN + ','															+&
												'"requestedQuantity": ' + String(li_Qtde) + ','								+&
												'"listPrice": ' + gf_retorna_so_numeros( String(ldc_Bruto) )	+ ','		+&
												'"netPrice": ' + gf_retorna_so_numeros( String(ldc_Liquido) )	+ ','	+&
												'"discountType": "L" },'
												
			Else
				ls_JSON_Produtos += 	'{ "id":' + String(li_Row)	+','													+&
												'"EAN": ' + ls_EAN + ','															+&
												'"requestedQuantity": ' + String(li_Qtde) + ' },'
			End If
			
			//No ultimo Produto retira a ultima virgula
			If li_Row = li_Linhas Then
				ls_JSON_Produtos = Mid( ls_JSON_Produtos, 1, LenA(ls_JSON_Produtos) -1 )
			End if
		Next
End If

//Retorna o json com todos os itens do atendimento
as_Json_Produtos = ls_Json_Produtos






end function

public function boolean of_carrega_dados_json (string as_json, string as_ean_aceite, boolean ab_abre_tela_desconto, ref string as_erro);String ls_itens, ls_sobra_Produto, ls_retorno
String ls_Ean, ls_Industria, ls_Mensagem
String ls_Log, ls_Null, ls_erro
String ls_InformativeText
String ls_EAN_TERMO_ACEITE_LOCAL
String ls_ReturCode

String ls_Json_Control, ls_flowDeviation, ls_url

Decimal{2} ldc_Desc, ldc_PC_Desc, ldc_Desc_Industria, ldc_Preco_Un
Decimal{2} ldc_PC_desconto_Fixo, ldc_Preco_Liquido

Decimal{2} ldc_Vl_Bruto, ldc_Vl_Liquido, ldc_Pc_Loja

Integer ll_Qtde_Autorizada, li_Row, li_Status, li_Find, li_Qt_Vendida

String ls_Aux

Try
	SetNull( ls_Null )
						
	//Variavel auxiliar				
	ls_Aux = as_Json
	
	ls_ReturCode			= io_json.of_busca_conteudo_campo_vtex(as_Json, 'returnCode')
	ls_InformativeText		= io_json.of_busca_conteudo_campo_vtex(as_Json, 'informativeText')
	
	io_json.of_divide_grupo_json_tag(Ref ls_Aux, 'control', Ref ls_Json_Control,'}') 
	
	is_CentralNumber 		= io_json.of_busca_conteudo_campo_vtex(ls_Json_Control, 'centralNumber')	//Nr unico de cada transacao
	ls_flowDeviation		= io_json.of_busca_conteudo_campo_vtex(ls_Json_Control, 'flowDeviation')
	ls_url						= io_json.of_busca_conteudo_campo_vtex(ls_Json_Control, 'urlAcceptTerm')
	
	If Not IsNull(ls_url) And Trim(ls_url) <> "" Then
		ls_flowDeviation = "DESVIOURL"
	End If
	
	//Desvio de Fluxo para aceite de termo
	Choose Case ls_flowDeviation
		Case 'ADESSITE'
			
		Case 'DESVIOURL'	
			SetNull(ls_EAN_TERMO_ACEITE_LOCAL)
			//ls_EAN_TERMO_ACEITE_LOCAL = io_json.of_busca_conteudo_campo_vtex(as_json, 'ean')
			
//			If Not IsNull(as_EAN_ACEITE) Then
//				If ls_EAN_TERMO_ACEITE_LOCAL = as_EAN_ACEITE Then
//					If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O cliente n$$HEX1$$e300$$ENDHEX$$o confirmou o termo de participa$$HEX2$$e700e300$$ENDHEX$$o do Programa da Ind$$HEX1$$fa00$$ENDHEX$$stria para o produto " + ls_EAN_TERMO_ACEITE_LOCAL + "~r~r" +&
//													"Deseja enviar o termo de aceite novamante?", Question!,YesNo!) = 2 Then
//													
//						//N$$HEX1$$e300$$ENDHEX$$o envia mais a solicita$$HEX2$$e700e300$$ENDHEX$$o 
//						Return False
//													
//					End If					
//				End If
//			End If
			
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O Cliente precisa aceitar o termo de participa$$HEX2$$e700e300$$ENDHEX$$o do Programa da Ind$$HEX1$$fa00$$ENDHEX$$stria.~r~rInforme ao cliente que $$HEX1$$e900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio o aceite para validar os benef$$HEX1$$ed00$$ENDHEX$$cios/descontos.")
			
			io_api.of_Shell_Execute(ls_url, '')
			
			If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O cliente j$$HEX1$$e100$$ENDHEX$$ realizou o aceite da Ind$$HEX1$$fa00$$ENDHEX$$stria ?" , Question!, YesNo!, 2) = 2 Then
				ls_Log = "Fun$$HEX2$$e700e300$$ENDHEX$$o: of_carrega_dados_json - " + ls_Erro
				io_Comum.of_envia_email(ls_Log)	
				Return False
			End If
						
			//Return This.of_Carrega_dados_json( as_json, ls_EAN_TERMO_ACEITE_LOCAL, Ref as_ERRO )
			RETURN  This.of_consulta_produto_cliente( "", "", Ref as_Erro)
		
		Case 'ATIVA1', 'ATIVA2', 'ATIVA3', 'ATIVA4','ATIVA5'
			ls_EAN_TERMO_ACEITE_LOCAL = io_json.of_busca_conteudo_campo_vtex(as_json, 'ean')
			
			Try
				//Solicita dados do Prescritor
				uo_ge570_dados_obrigatorios lo_dados_Prescritor
				//lo_dados_Prescritor = Create uo_ge570_dados_obrigatorios
				
				MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Favor informar o prescritor para finalizar o cadastro do cliente na industria.")
				
				Open(w_ge570_dados_prescritor)
				
				lo_dados_Prescritor = Message.powerobjectparm
				
				If IsNull(lo_dados_Prescritor) Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Necess$$HEX1$$e100$$ENDHEX$$rio informar os dados do prescritor para realizar o cadastro.", Exclamation!)
					Return False
				End If
								
				is_tipo_prescritor				= lo_dados_Prescritor.id_tipo_registro
				is_nr_registro_prescritor		= lo_dados_Prescritor.nr_registro
				is_uf_prescritor					= lo_dados_Prescritor.uf_prescritor
				is_nm_prescritor				= lo_dados_Prescritor.nm_pescritor
							
			Finally	
				If IsValid(lo_dados_Prescritor) Then Destroy lo_dados_Prescritor
			End Try
				
			//Realiza adesao do produto 
			If This.of_realiza_adesao(ls_flowDeviation, ls_EAN_TERMO_ACEITE_LOCAL) Then
				
				//Chama novamente a consulta com todos os produtos
				Return This.of_consulta_produto_cliente( "", "", Ref as_Erro)
				
			End If
			
	End Choose
	
	//Verifica situa$$HEX2$$e700f500$$ENDHEX$$es espec$$HEX1$$ed00$$ENDHEX$$ficas da industria/produto
	Choose Case ls_ReturCode
		Case 'N000'
			//Sucesso
			
		Case 'F803'
			//Integra$$HEX2$$e700e300$$ENDHEX$$o Portal Drogaria
			If This.ids_produtos_atendimento.RowCount() = 1 Then
				ls_EAN = This.ids_produtos_atendimento.object.de_codigo_barras [1]
						
				io_Produto.of_localiza_codigo_barras( ls_EAN )
				
				ls_InformativeText = "Produto: " + String(io_Produto.cd_Produto) + " - " + ls_InformativeText
				//MessageBox("Integra$$HEX2$$e700e300$$ENDHEX$$o Portal Drogaria", "Produto: " + String(io_Produto.ivs_descricao_apresentacao_venda) + "~r~r" + ls_InformativeText )
			Else	
				//MessageBox("Integra$$HEX2$$e700e300$$ENDHEX$$o Portal Drogaria", "Retorno API:~r~r"+ls_InformativeText )
			End If
			
			as_Erro = ls_InformativeText
			Return False
			
		Case Else
			//"informativeText": "Q275 - N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel efetuar essa fun$$HEX2$$e700e300$$ENDHEX$$o, pois o PDV n$$HEX1$$e300$$ENDHEX$$o possui servi$$HEX1$$e700$$ENDHEX$$o de Ativa$$HEX2$$e700e300$$ENDHEX$$o cadastrado. Entre em contato com o Suporte Center."
			MessageBox("Integra$$HEX2$$e700e300$$ENDHEX$$o Portal Drogaria", "Retorno API:~r~r"+ls_InformativeText )
			as_Erro = ls_InformativeText
			Return False
	End Choose	
	
	uo_Produto lo_Produto
	lo_Produto = Create uo_Produto
	
	dc_uo_ds_base lds_produtos
	lds_produtos = Create dc_uo_ds_base
	
	If Not lds_produtos.of_ChangeDataObject("dw_ge570_produtos_autorizados") Then
		ls_Log = "Fun$$HEX2$$e700e300$$ENDHEX$$o: of_carrega_dados_json - Erro no evento of_ChangeDataObject: ds_ge570_consulta_desconto_produto"
		io_Comum.of_envia_email(ls_Log)	
		Return False
	End If
	
	//Ir$$HEX1$$e100$$ENDHEX$$ buscar:
	//De: product At$$HEX1$$e900$$ENDHEX$$: centralHour
	io_json.of_divide_grupo_json_tag_vtex( ref as_json, 'product', ref ls_itens, 'centralHour')
		
	//Produtos
	Do While io_json.of_divide_grupo_json_completo(Ref ls_itens, Ref ls_retorno,'{')
		
		ls_sobra_Produto 	= ls_retorno
									
		ls_Ean					= io_json.of_busca_conteudo_campo_vtex(ls_sobra_Produto, 'ean')
		ll_Qtde_Autorizada 	= Integer( io_json.of_busca_conteudo_campo_vtex(ls_sobra_Produto, 'authorizedQuantity') )
	 	ldc_Desc					= gf_decimal( io_json.of_busca_conteudo_campo_vtex(ls_sobra_Produto, 'discountValue'), 2)
		ldc_PC_Desc			= gf_decimal( io_json.of_busca_conteudo_campo_vtex(ls_sobra_Produto, 'discountPercentual'), 2 )
		ldc_Desc_Industria		= gf_decimal( io_json.of_busca_conteudo_campo_vtex(ls_sobra_Produto, 'discountValueIndustry'), 2 )
		ls_Industria				= io_json.of_busca_conteudo_campo_vtex(ls_sobra_Produto, 'industryName') 
		ls_Mensagem			= io_json.of_busca_conteudo_campo_vtex(ls_sobra_Produto, 'informativeMessage')
		li_Status					= Integer(io_json.of_busca_conteudo_campo_vtex(ls_sobra_Produto, 'status'))
			
		lo_Produto.of_localiza_codigo_barras( ls_Ean )
		
		If Not lo_Produto.localizado Then
			ls_Log = "Fun$$HEX2$$e700e300$$ENDHEX$$o: of_carrega_dados_json - Produto n$$HEX1$$e300$$ENDHEX$$o localizado. EAN: " + ls_Ean			
			io_Comum.of_envia_email(ls_Log)	
			Continue
		End If
		
		li_Find = ids_produtos_atendimento.Find("cd_produto = " + String(lo_Produto.cd_produto), 1, ids_produtos_atendimento.RowCount())
		
		If li_Find = 0 Then
			ls_Log = "Fun$$HEX2$$e700e300$$ENDHEX$$o: of_carrega_dados_json - Produto do retorno n$$HEX1$$e300$$ENDHEX$$o localizado nos produtos do atendimento. EAN: " + ls_Ean
			io_Comum.of_envia_email(ls_Log)	
			Continue
		End If
		
		If li_Find > 0 Then
			li_Qt_Vendida 	= ids_produtos_atendimento.Object.qt_produto				[ li_Find ]
			ldc_Vl_Bruto		= ids_produtos_atendimento.Object.vl_preco_bruto			[ li_Find ]
			ldc_Vl_Liquido	= ids_produtos_atendimento.Object.vl_preco_liquido			[ li_Find ]
			ldc_Pc_Loja		= ids_produtos_atendimento.Object.pc_desconto_loja		[ li_Find ]  	
			
			If IsNull(ldc_Pc_Loja) Then ldc_Pc_Loja = 0
		End If
		
		//Industria DERMACLUB n$$HEX1$$e300$$ENDHEX$$o entra na carga
		If ls_Industria = 'DERMACLUB' Then
			Continue	
		End If
		
		If ldc_Desc > 0 Then
			//O que eles falaram
			ldc_Vl_Liquido = ldc_Vl_Liquido - ldc_Desc
			
			ldc_PC_Desc = ( (ldc_Vl_Bruto -  ldc_Vl_Liquido) / ldc_Vl_Bruto) * 100
		
			//O sistema de caixa nao funciona com o valor do desconto e sim com o pc_desconto
			//ldc_Vl_Liquido = Round( ldc_Vl_Bruto * ( (100 - ldc_PC_Desc) /100 ) , 2 ) * ll_Qtde_Autorizada
		Else
			ldc_PC_Desc 	= ldc_Pc_Loja
		End If
		
		//Mostra na consulta o valor total por item
		ldc_Vl_Liquido = ldc_Vl_Liquido * ll_Qtde_Autorizada				
						
		li_Row = lds_produtos.InsertRow(0)
		
		lds_produtos.object.cd_produto				[li_Row] = lo_Produto.cd_produto
		lds_produtos.object.nm_produto				[li_Row] = lo_Produto.ivs_descricao_apresentacao_venda
		lds_produtos.object.de_codigo_barras		[li_Row] = ls_Ean
		lds_produtos.object.qt_autorizada				[li_Row] = ll_Qtde_Autorizada
		lds_produtos.object.qt_vendida					[li_Row] = li_Qt_Vendida
		lds_produtos.object.vl_preco_bruto			[li_Row] = ldc_Vl_Bruto
		lds_produtos.object.vl_preco_liquido			[li_Row] = ldc_Vl_Liquido
		lds_produtos.object.pc_desconto				[li_Row] = ldc_PC_Desc
		lds_produtos.object.id_erro						[li_Row] = li_Status
		lds_produtos.object.de_msg_retorno			[li_Row] = ls_Mensagem
		lds_produtos.object.pc_desconto_padrao	[li_Row] = ldc_Pc_Loja
		lds_produtos.object.vl_total_liquido			[li_Row] = ldc_Vl_Liquido
		
	Loop //Produtos
	
	If ab_abre_tela_desconto Then
		If lds_produtos.RowCount() > 0 Then
			//OpenWithParm(w_ge570_confirmar_autorizacao, lds_produtos)
			  OpenWithParm(w_ge570_consulta_desconto_produto, lds_produtos)
			 
			  If Message.StringParm = 'CANCELAR' Then
			   	 Return False
			  End If
		End If
	End If

	Return True

Catch (RunTimeError lo_error)
	MessageBox("Erro", "Erro ao gerar a autoriza$$HEX2$$e700e300$$ENDHEX$$o Portal Drogaria.~r~rLog Error " + lo_error.GetMessage())
	io_Comum.of_envia_email("Fun$$HEX2$$e700e300$$ENDHEX$$o: of_carrega_dados_json()~r" + lo_error.GetMessage())
	Return False
	
Finally
	If IsValid(lo_Produto)		Then Destroy lo_Produto
	If IsValid(lds_produtos)	Then Destroy lds_produtos
End Try

end function

public function boolean of_atualiza_cliente_caixa_produto (long al_produto, long al_qtde, integer ai_status, decimal adc_vl_desconto, long al_qtde_aprovada);Integer li_Sequencial_Item

String ls_Autorizado

Select Max(nr_sequencial) 
	Into :li_Sequencial_Item
from cliente_caixa_produto
Where nr_sequencial_cliente_caixa 	= :il_Sequencial_Cliente_Caixa
and cd_produto 							= :al_produto
and qt_produto								= :al_qtde
Using SqlCa;
 
If SqlCa.SqlCode = -1 Then
	io_Comum.of_envia_email( "Erro ao localizar o sequencial do item " + String(al_Produto) + " na tb.cliente_caixa_produto. Seq. Cliente Caixa: "+String(il_Sequencial_Cliente_Caixa)) 
	Return False
End If

If li_Sequencial_Item > 0 Then
	
	ls_Autorizado = IIF( ai_Status=0, 'S', 'N' )	
	
	update cliente_caixa_produto
	 Set id_autorizado_pbm 					= :ls_Autorizado,
	 	vl_total_desconto_pbm				= :adc_vl_desconto,
		qt_produto								= :al_qtde_aprovada,
		id_situacao								= 'A'
	 Where nr_sequencial_cliente_caixa 	= :il_Sequencial_Cliente_Caixa
	  and cd_produto 						= :al_produto
	  and nr_sequencial					= :li_Sequencial_Item
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		io_Comum.of_envia_email( "Erro no update do status do item " + String(al_Produto) + " na tb.cliente_caixa_produto. Seq. Cliente Caixa: "+String(il_Sequencial_Cliente_Caixa) + " = Status: " + ls_Autorizado) 
		Return False
	End If
End If
		
Return True
		
		
	 
end function

public function boolean of_consulta_produto_cliente (string as_nr_cartao_programa, string as_cupom_desconto, ref string as_log);Boolean lb_Visualiza_Tela_Desconto = False

String ls_Json_Retorno
String ls_Erro, ls_Log
String ls_Null

SetNull(ls_Null)

Try
	//Busca o Token de Acesso
	If Not io_Comum.of_gera_token( Ref ls_erro) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na conex$$HEX1$$e300$$ENDHEX$$o com o Portal Drogaria.~r~r" + ls_erro, StopSign!)
		io_Comum.of_envia_email(ls_erro)
		Return False
	End If
	
	//utiliza o Token p/ buscar
	If Not This.of_Autenticacao_prd_Cliente(ls_Null, Ref ls_Json_Retorno, Ref ls_Log) Then		
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na conex$$HEX1$$e300$$ENDHEX$$o com o Portal Drogaria.~r~r" + ls_erro, StopSign!)
		io_Comum.of_envia_email(ls_Log)			
		Return False
	End If
	
	//Tratamento de Erro
	If PosA(ls_Json_Retorno, '"error"') >0 Then
		If Not This.of_Processa_Erro(ls_Json_Retorno) Then
			io_Comum.of_envia_email(ls_Json_Retorno)
		End If
		Return False
	Else
		If Not of_Carrega_Dados_Json(ls_Json_Retorno, ls_Null, lb_Visualiza_Tela_Desconto,  Ref as_Log) Then		
			//io_Comum.of_envia_email(ls_Log)
			Return False
		End If	
	End If
	
	Return True
	
Catch (RunTimeError lo_error)
	io_Comum.of_envia_email(lo_error.GetMessage())
	Return False
	
Finally

End Try
end function

on uo_ge570_portal_drogaria_balcao_atendimento.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge570_portal_drogaria_balcao_atendimento.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ids_produtos_autorizados	= Create dc_uo_ds_base
ids_produtos_atendimento 	= Create dc_uo_ds_base
io_api								= Create dc_uo_api
io_Cliente						= Create uo_Cliente
io_Comum						= Create uo_ge570_portal_drogaria_comum 
io_Json 							= Create uo_ge073_json
io_Produto 						= Create uo_Produto

ids_produtos_atendimento.of_changedataobject( "ds_ge570_produtos_atendimento" )
ids_produtos_autorizados.of_changedataobject( "dw_ge570_produtos_autorizados" )

end event

event destructor;If IsValid(ids_produtos_atendimento) Then Destroy ids_produtos_atendimento
If IsValid(ids_produtos_autorizados) 	Then Destroy ids_produtos_autorizados

If IsValid(io_Api) 		Then Destroy io_Api
If IsValid(io_Cliente) 	Then Destroy io_Cliente
If IsValid(io_Comum) 	Then Destroy io_Comum
If IsValid(io_Json) 		Then Destroy io_Json
If IsValid(io_Produto) Then Destroy io_Produto


end event

