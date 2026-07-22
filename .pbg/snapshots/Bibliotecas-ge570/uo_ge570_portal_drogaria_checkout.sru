HA$PBExportHeader$uo_ge570_portal_drogaria_checkout.sru
forward
global type uo_ge570_portal_drogaria_checkout from nonvisualobject
end type
end forward

global type uo_ge570_portal_drogaria_checkout from nonvisualobject
end type
global uo_ge570_portal_drogaria_checkout uo_ge570_portal_drogaria_checkout

type variables
	 String is_CentralNumber
String is_CPF
String is_NR_AUTORIZACAO
String is_Nr_Cartao_Programa	//C$$HEX1$$f300$$ENDHEX$$digo do Cart$$HEX1$$e300$$ENDHEX$$o do Programa

Date idt_Nascimento				//Data de Nascimento do cliente n$$HEX1$$e300$$ENDHEX$$o identificado

Long il_NF

String is_Especie
String is_Chave_Acesso

String is_Imagem_Autorizacao //Usado na impressao do cupom/NFC

uo_Cliente io_Cliente
uo_ge570_portal_drogaria_comum io_Comum
uo_ge073_json io_Json


dc_uo_ds_base ids_produtos_atendimento 
dc_uo_ds_base ids_produtos_autorizados
end variables

forward prototypes
public function boolean of_autenticacao_confirmacao (ref string as_json_retorno, ref string as_erro)
public function boolean of_autenticacao_efetiva (ref string as_json_retorno, ref string as_erro)
public function boolean of_processa_retorno_efetiva (string as_json, ref string as_erro)
public function boolean of_processa_retorno_confirmacao (string as_json, ref string as_erro)
public function boolean of_anula_autorizacao ()
public function boolean of_autenticacao_anula (ref string as_json_retorno, ref string as_erro)
public function boolean of_efetiva_transacao ()
public function boolean of_monta_json_produto (string as_tipo_operacao, boolean ab_envia_preco, ref string as_json_produtos, ref string as_erro)
public function boolean of_confirma_autorizacao (ref string as_erro)
end prototypes

public function boolean of_autenticacao_confirmacao (ref string as_json_retorno, ref string as_erro);Boolean lb_Envia_Preco = False

String ls_Json_Envio
String ls_Terminal
String ls_data
String ls_Json_Produtos
String ls_Especie_NF
String ls_CPF
String ls_Cartao_Industria
String ls_CNPJ

DateTime ldt_Parametro

SetNull(as_Json_Retorno)

If Not This.io_Comum.of_verifica_url_integracao('URL_CONFIRMA', Ref as_Erro) Then
 	Return False
End If

//Nome do PDV
ls_Terminal 		= gvo_Aplicacao.of_computername(  )

ldt_Parametro 	= gf_GetServerDate()
ls_Data			= String(ldt_Parametro, "YYYY-MM-DD")+"T"+String(ldt_Parametro, "HH:MM:SS")
		  		
//Formata todos os produtos
If Not This.of_monta_json_produto('CONFIRMA', lb_Envia_Preco, Ref ls_Json_Produtos, Ref as_Erro) Then
	io_Comum.of_envia_email( "Fun$$HEX2$$e700e300$$ENDHEX$$o: of_autenticacao_confirmacao - Erro ao montar o json do grupo dos produtos.")
	Return False
End If

If is_Especie = 'CF' Then
	ls_Especie_NF = 'NCF'
	is_Chave_Acesso = ''
Else
	If is_Especie = 'SAT' Then
		ls_Especie_NF = 'NFC'
	Else
		ls_Especie_NF = is_Especie		
	End If
	
	If IsNull( is_Chave_Acesso ) Then
		is_Chave_Acesso = ''
		io_Comum.of_envia_email( "Fun$$HEX2$$e700e300$$ENDHEX$$o: of_autenticacao_confirmacao - Especie: " + is_Especie + " - Necessario informar a chave de acesso da nota fiscal.")
		Return False		
	End If
End If

//Localiza_Cliente
ls_CPF = is_CPF
If IsNull(ls_CPF) Then
	ls_CPF = ''
End If

//Cart$$HEX1$$e300$$ENDHEX$$o de identificacao Industria
If IsNull(This.is_nr_cartao_programa ) Then
	ls_Cartao_Industria = ''
Else
	ls_Cartao_Industria = This.is_nr_cartao_programa 
End If		

ls_CNPJ = Gvo_Parametro.nr_cgc
							  
ls_Json_Envio = '{ "control": {' 													+&
							  '"clientId": "' + io_Comum.is_cliente_id +'",'	+&
							  '"username": "CLAMED",'							+& 
							  '"tableId": "' + io_Comum.is_table_id + '",'		+&
							  '"localNumber": "1",'									+&
							  '"localHour": "' + ls_Data + '",' 					+&													  
							  '"industryId": "999",'									+&
							  '"stationId": "' + ls_Terminal+	'",'		        	 	+&
							  '"terminalId": "CHECKOUT",'						+&
							  '"companyCode": "' + ls_CNPJ +'",'				+&
							  '"attendanceHash": "",'								+&
							  '"OperationId": ' + String(il_NF) + ',' 			+&
							  '"taxCouponType": "' + ls_Especie_NF + '",' 		+&
						       '"accessKey": "' + is_Chave_Acesso + '",' 		+& 
							  '"softwareId": "CAIXA' +gvo_Aplicacao.ivs_Versao+ '"'	+&
						'},'																+&
						'"consumer": {'												+&
							    '"holderId": "' + ls_CPF + '",'						+&
							     '"cardId": "' + ls_Cartao_Industria + '"'		+&
						'},'																+&
						'"transaction": {'														+&
							  '"transactionCode": "' +This.is_NR_AUTORIZACAO+'",'	+&
							  '"providerCode": ""'												+&
						'},'																			+&  
						 '"product": [' 												+&
	/*Produtos*/	      ls_Json_Produtos										+&		
						']}'
	
If Not io_Comum.of_post( ls_json_Envio, "", ref as_Json_Retorno, ref as_Erro ) Then Return False

Return True
end function

public function boolean of_autenticacao_efetiva (ref string as_json_retorno, ref string as_erro);Boolean lb_Envia_Preco = True

String ls_Json_Envio
String ls_Terminal
String ls_data
String ls_data_Nascimento
String ls_Json_Produtos
String ls_NSU
String ls_CPF
String ls_Cartao_Industria
String ls_CNPJ

DateTime ldt_Parametro

SetNull(as_Json_Retorno)

If Not This.io_Comum.of_verifica_url_integracao('URL_EFETIVA', Ref as_Erro) Then
 	Return False
End If

//Nome do PDV
ls_Terminal 		= gvo_Aplicacao.of_computername(  )

ldt_Parametro 	= gf_GetServerDate()
ls_Data			= String(ldt_Parametro, "YYYY-MM-DD")+"T"+String(ldt_Parametro, "HH:MM:SS")
		  		
//Formata todos os produtos
If Not This.of_monta_json_produto('EFETIVA', lb_Envia_Preco, Ref ls_Json_Produtos, Ref as_Erro) Then
	io_Comum.of_envia_email( "Fun$$HEX2$$e700e300$$ENDHEX$$o: of_autenticacao_efetiva - Erro ao montar o json do grupo dos produtos.")
	Return False
End If

//Localiza_Cliente
ls_CPF = is_CPF
If IsNull(ls_CPF) Then
	ls_CPF = ''
Else
	io_Cliente.of_localiza_cpf(ls_CPF, False)

	//Nascimento cliente
	If io_Cliente.Localizado Then
		ls_data_Nascimento = String(io_Cliente.dh_nascimento, "YYYY-MM-DD")+"T00:00:00"
	End If
End If

//Data Nascimento
//If IsNull(This.idt_nascimento) Then
//	ls_data_Nascimento = ''
//Else
//	ls_data_Nascimento = String( This.idt_nascimento, "YYYY-MM-DD")+"T00:00:00" // cliente nao identificado
//End If

//N$$HEX1$$e300$$ENDHEX$$o enviar a data de nascimento
ls_data_Nascimento = ''

//Se n$$HEX1$$e300$$ENDHEX$$o estiver preenchido o nr da autoriza$$HEX2$$e700e300$$ENDHEX$$o o sistema de caixa poder$$HEX1$$e100$$ENDHEX$$ enviar sem o nr mesmo.
If IsNull(This.is_NR_AUTORIZACAO) Then
	ls_NSU = ''
Else
	ls_NSU = This.is_NR_AUTORIZACAO
End If

//Cart$$HEX1$$e300$$ENDHEX$$o de identificacao Industria
If IsNull(This.is_nr_cartao_programa ) Then
	ls_Cartao_Industria = ''
Else
	ls_Cartao_Industria = This.is_nr_cartao_programa 
End If

ls_CNPJ = Gvo_Parametro.nr_cgc

ls_Json_Envio = '{ "control": {' 													+&
							  '"clientId": "' + io_Comum.is_cliente_id +'",'	+&
							  '"username": "CLAMED",'							+& 
							  '"tableId": "' + io_Comum.is_table_id + '",'		+&
							  '"localNumber": "1",'									+&
							  '"localHour": "' + ls_Data + '",' 					+&						
							  '"industryId": "999",'									+&
							  '"stationId": "' + ls_Terminal+	'",'		        	 	+&
							  '"terminalId": "CHECKOUT",'						+&
							  '"companyCode": "' + ls_CNPJ +'",'				+&
							  '"attendanceHash": "",'								+&
							  '"operationId": null,'									+&
							  '"softwareId": "CAIXA' +gvo_Aplicacao.ivs_Versao+ '"'	+&
						 '},'															+&
						 '"consumer": {'											+&
							    '"holderId": "' + ls_CPF + '",'						+&
							    '"cardId": "' + ls_Cartao_Industria + '",'		+&
								'"cardIdCompany": null,'							+&
								'"idCompany": null,'								+&
								'"birthdate": "' + ls_data_Nascimento + '",'	+&
								'"cardIdOperator": null,'							+&
								'"idOperator": null'									+&
						'},'																+&
						'"payment": {'												+&
/*Desconto em folha ???*/  '"payroll": "N"'									+&	
						 '},	'															+&
						 '"transaction": {'											+&
							  '"transactionCode": "' +ls_NSU + '",'				+&
							  '"providerCode": ""'									+&
						'},'																+&  
						 '"product": [' 												+&
	/*Produtos*/	      ls_Json_Produtos										+&		
						 ']}'
	
If Not io_Comum.of_post( ls_json_Envio, "", ref as_Json_Retorno, ref as_Erro ) Then Return False

Return True
end function

public function boolean of_processa_retorno_efetiva (string as_json, ref string as_erro);Boolean lb_Sucesso = False

String ls_Aux, ls_Aux_NSU
String ls_Json_Control, ls_Json_Transaction, ls_Json_Comprovante
String ls_itens, ls_sobra_Produto, ls_retorno
String ls_informativeText
String ls_Aux_informativeText

String ls_Ean
String ls_Industria
String ls_Mensagem
String ls_Log
String ls_RetCode
String ls_Retorno_Confirmacao


Long ll_Qtde_Autorizada

Decimal ldc_PC_Desc
Decimal ldc_Desc_Industria
Decimal{2} ldc_vl_Bruto
Decimal{2} ldc_vl_Liquido_Total
Decimal{2} ldc_vl_Liquido_Un, ldc_Vl_Liquido_Loja
Decimal{2} ldc_pc_Loja
Decimal{2} ldc_vl_Desconto

Integer li_Status, li_Row
Integer li_Find, li_qt_Vendida

Try	
	ls_Aux 						= as_Json
	ls_Aux_NSU 				= as_Json
	ls_Aux_informativeText 	= as_Json
					
	uo_Produto lo_Produto
	lo_Produto = Create uo_Produto
	
	//Nao mudar a ordem de leitura desses campos
	//inicio
	io_json.of_divide_grupo_json_tag(Ref ls_Aux, 'control', Ref ls_Json_Control,'}') 
	io_json.of_divide_grupo_json_tag_vtex( ref ls_Aux, 'product', ref ls_itens, 'taxReceipt')
	ls_RetCode 				= io_json.of_busca_conteudo_campo_vtex(ls_Aux, 'returnCode')
	ls_informativeText		= io_json.of_busca_conteudo_campo_vtex(ls_Aux, 'informativeText')
	io_json.of_divide_grupo_json_tag(Ref ls_Aux, 'transaction', Ref ls_Json_Transaction,'}') 
	io_json.of_divide_grupo_json_tag_vtex( Ref ls_Aux_NSU, 'taxReceipt', ref ls_Json_Comprovante, 'transaction' )
	//Termino
	
	//N$$HEX1$$e300$$ENDHEX$$o gerou autorizacao
	If ls_Json_Comprovante = '' Then
		io_json.of_divide_grupo_json_tag(Ref ls_Aux_informativeText, 'product', Ref ls_itens,']') 
		ls_informativeText		= io_json.of_busca_conteudo_campo_vtex(ls_Aux_informativeText, 'informativeText')
	End If
	
	If PosA(ls_informativeText, 'Transacao Aprovada') = 0 Then 
		If PosA(ls_informativeText, 'Consumidor nao cadastrado') > 0 Then
			//Consumidor nao cadastrado, apresentar a mensagem para efetuar o cadastro e continua a venda sem desconto
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Consumidor nao cadastrado no Programa. Realize o cadastro no Portal Drogaria para receber o desconto.~r~rA venda ser$$HEX1$$e100$$ENDHEX$$ realizada sem os descontos PBM.", Exclamation!)	
			//Return True
		Else
			If PosA(as_Json, '"error"') > 0 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gerar a Autoriza$$HEX2$$e700e300$$ENDHEX$$o.~r~r" + as_Json, Exclamation!)
				io_Comum.of_envia_email(as_Json)
				Return lb_Sucesso
			Else
				as_erro = ls_informativeText
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel gerar a Autoriza$$HEX2$$e700e300$$ENDHEX$$o~r~rMotivo: " + as_erro, Exclamation!)
			End If
		End If
	End If
	
	//Caso seja realizado a busca direta pelo caixa sem ter passado pelo Carrinho no RL
	If IsNull(This.is_nr_autorizacao) Or This.is_nr_autorizacao = '' Then
		//N$$HEX1$$e300$$ENDHEX$$o gerou autorizacao
		If ls_Json_Comprovante <> '' Then
			This.is_Nr_Autorizacao =  io_json.of_busca_conteudo_campo_vtex(ls_Json_Transaction, 'transactionCode')
			Gvo_Aplicacao.of_grava_log( "PORTAL DROGARIA: Autorizacao gerada: " + This.is_nr_autorizacao)
		End If
	End If
	
	//Ir$$HEX1$$e100$$ENDHEX$$ buscar:
	//De: product At$$HEX1$$e900$$ENDHEX$$: taxReceipt
	//io_json.of_divide_grupo_json_tag_vtex( ref as_json, 'product', ref ls_itens, 'taxReceipt')
		
	//Produtos
	Do While io_json.of_divide_grupo_json_completo(Ref ls_itens, Ref ls_retorno,'{')
		
		ls_sobra_Produto 	= ls_retorno
									
		ls_Ean					= io_json.of_busca_conteudo_campo_vtex(ls_sobra_Produto, 'ean')
		ll_Qtde_Autorizada 	= Integer( io_json.of_busca_conteudo_campo_vtex(ls_sobra_Produto, 'authorizedQuantity') )
	 	ldc_Vl_desconto		= gf_decimal( io_json.of_busca_conteudo_campo_vtex(ls_sobra_Produto, 'discountValue'), 2)
		ldc_PC_Desc			= gf_decimal( io_json.of_busca_conteudo_campo_vtex(ls_sobra_Produto, 'discountPercentual'), 2 )
		ldc_Desc_Industria		= gf_decimal( io_json.of_busca_conteudo_campo_vtex(ls_sobra_Produto, 'discountValueIndustry'), 2 ) //Desconto adicional da industria
		ls_Industria				= io_json.of_busca_conteudo_campo_vtex(ls_sobra_Produto, 'industryName') 
		//ls_Mensagem			= io_json.of_busca_conteudo_campo_vtex(ls_sobra_Produto, 'informativeMessage')
		ls_Mensagem			= io_json.of_busca_conteudo_campo_vtex(ls_sobra_Produto, 'informativeText')
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
			li_Qt_Vendida 			= ids_produtos_atendimento.Object.qt_produto			[ li_Find ]
			ldc_Vl_Bruto				= ids_produtos_atendimento.Object.vl_preco_bruto		[ li_Find ]
			ldc_Pc_Loja				= ids_produtos_atendimento.Object.pc_desconto_loja	[ li_Find ]  	
		End If
		
		//Industria DERMACLUB n$$HEX1$$e300$$ENDHEX$$o entra na carga
//		If ls_Industria = 'DERMACLUB' Then
//			Continue
//		End If
		
		ldc_Vl_Liquido_Loja = Round( ldc_Vl_Bruto * ((100 - ldc_Pc_Loja) / 100), 2)
		
		ldc_Vl_Liquido_UN 	= ldc_Vl_Liquido_Loja
		ldc_vl_Liquido_Total	= ldc_Vl_Liquido_UN * li_Qt_Vendida
		
		If li_Status = 0 Then //Autorizado
			If ldc_Vl_desconto > 0 Then			
				//Mandado no Efetiva o preco liquido, dessa forma o desconto pbm $$HEX1$$e900$$ENDHEX$$ sobre o liquido
				//ldc_Vl_Liquido_UN	= (ldc_Vl_Bruto - ldc_vl_desconto )
				
				ldc_Vl_Liquido_UN		= (ldc_Vl_Liquido_Loja - ldc_vl_desconto )				
				ldc_vl_Liquido_Total	= ldc_Vl_Liquido_UN * ll_Qtde_Autorizada
				
				ldc_PC_Desc = ROUND(( (ldc_Vl_Bruto - ldc_Vl_Liquido_UN) / ldc_Vl_Bruto ) * 100, 2)
			Else
				ls_Mensagem = "DESCONTO DA LOJA MAIOR/IGUAL AO DESCONTO PBM"	
				ldc_PC_Desc = ldc_Pc_Loja
			End If
		Else
			ll_Qtde_Autorizada = 0
			ldc_vl_Liquido_Total = ldc_Vl_Liquido_UN
		End If
				
		li_Row = ids_produtos_autorizados.InsertRow(0)
		
		ids_produtos_autorizados.object.cd_produto				[li_Row] = lo_Produto.cd_produto 
		ids_produtos_autorizados.object.nm_produto				[li_Row] = lo_Produto.ivs_descricao_apresentacao_venda 
		ids_produtos_autorizados.object.de_codigo_barras		[li_Row] = ls_Ean 
		ids_produtos_autorizados.object.qt_autorizada				[li_Row] = ll_Qtde_Autorizada
		ids_produtos_autorizados.object.qt_vendida					[li_Row] = li_Qt_Vendida
		ids_produtos_autorizados.object.vl_preco_bruto			[li_Row] = ldc_Vl_Bruto
		ids_produtos_autorizados.object.vl_preco_liquido			[li_Row] = ldc_Vl_Liquido_UN
		ids_produtos_autorizados.object.vl_total_liquido			[li_Row] = ldc_vl_Liquido_Total
		ids_produtos_autorizados.object.vl_desconto				[li_Row] = ldc_vl_desconto		
		ids_produtos_autorizados.object.pc_desconto				[li_Row] = ldc_PC_Desc
		ids_produtos_autorizados.object.id_erro						[li_Row] = li_Status	
		ids_produtos_autorizados.object.de_msg_retorno			[li_Row] = ls_Mensagem
		ids_produtos_autorizados.object.pc_desconto_padrao	[li_Row] = ldc_Pc_Loja
		ids_produtos_autorizados.object.vl_liquido_loja			[li_Row] = ldc_Vl_Liquido_Loja
			
	Loop //Produtos
	
	//Imagem do Cupom
	io_json.of_divide_grupo_json_tag_vtex( ref ls_Json_Comprovante, 'lines', ref is_Imagem_Autorizacao, ']' )
	
	//is_Imagem_Autorizacao = io_json.of_busca_conteudo_campo_vtex(ls_Json_Comprovante, 'lines')
	is_Imagem_Autorizacao = gf_Replace(is_Imagem_Autorizacao, ':', '', 1)
	is_Imagem_Autorizacao = gf_Replace(is_Imagem_Autorizacao, '[', '', 0)
	is_Imagem_Autorizacao = gf_Replace(is_Imagem_Autorizacao, ']', '', 0)
	is_Imagem_Autorizacao = gf_Replace(is_Imagem_Autorizacao, '"', '', 0)
	is_Imagem_Autorizacao = gf_Replace(is_Imagem_Autorizacao, ',', '', 0)
	is_Imagem_Autorizacao = gf_Replace(is_Imagem_Autorizacao, '         ', '', 0)
	
	If ids_produtos_autorizados.RowCount() > 0 Then
		 OpenWithParm( w_ge570_confirmar_autorizacao, ids_produtos_autorizados )
		 ls_Retorno_Confirmacao = Message.StringParm	
		 
		 If ls_Retorno_Confirmacao = 'OK' Then
			lb_Sucesso = True
			//Imagem do Cupom
			//is_Imagem_Autorizacao = io_json.of_busca_conteudo_campo_vtex( ls_Json_Comprovante, 'lines' )
		 End If
	End If
		
	Return lb_Sucesso

Catch (RunTimeError lo_error)
	io_Comum.of_envia_email(lo_error.GetMessage())
	Return False
	
Finally
	If IsValid(lo_Produto)	Then Destroy lo_Produto
End Try

end function

public function boolean of_processa_retorno_confirmacao (string as_json, ref string as_erro);String ls_InformativeText
String ls_RetCode
String ls_Log

Try
	ls_RetCode 				= io_json.of_busca_conteudo_campo_vtex(as_json, 'returnCode')
	ls_InformativeText		= io_json.of_busca_conteudo_campo_vtex(as_json, 'informativeText')
		
	If PosA(ls_informativeText, 'Transacao Aprovada') > 0 Then 
		Return True
	Else
		as_erro = ls_informativeText
		ls_Log = "Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_retorno_confirmacao - Retorno: " + ls_informativeText
		io_Comum.of_envia_email(ls_Log)	
		Return False
	End If	

Catch (RunTimeError lo_error)
	io_Comum.of_envia_email(lo_error.GetMessage())
	Return False
	
Finally
//
End Try

end function

public function boolean of_anula_autorizacao ();String ls_Json_Retorno
String ls_Erro, ls_Log
String ls_Null
String ls_InformativeText
String ls_RetCode

SetNull(ls_Null)

Try
	If IsNull(This.is_Nr_Autorizacao) Or This.is_Nr_Autorizacao = '' Then
		//Nao gerou autorizacao
		Return True
	End if
	
	//Busca o Token de Acesso
	If Not io_Comum.of_gera_token( Ref ls_erro) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel gerar o token de acesso da api.~rVerifique a comunica$$HEX2$$e700e300$$ENDHEX$$o com a matriz.~rRetorno: " + ls_erro, Exclamation!)
		io_Comum.of_envia_email(ls_erro)
		Return False
	End If
	
	//Utiliza o Token p/ buscar
	If Not This.of_autenticacao_anula( Ref ls_Json_Retorno, Ref ls_Erro ) Then
		io_Comum.of_envia_email(ls_Erro)			
		Return False
	End If
	
	ls_RetCode 				= io_json.of_busca_conteudo_campo_vtex(ls_Json_Retorno, 'returnCode')
	ls_informativeText		= io_json.of_busca_conteudo_campo_vtex(ls_Json_Retorno, 'informativeText')
	
	If PosA(ls_informativeText, 'Transacao Aprovada') > 0 Then 
		ls_informativeText = "AUTORIZA$$HEX2$$c700c300$$ENDHEX$$O CANCELADA~r~rNSU: " + This.is_nr_autorizacao
		Gvo_Aplicacao.of_grava_log( "PORTAL DROGARIA: AUTORIZACAO CANCELADA, NSU: " + This.is_nr_autorizacao)
	Else
		ls_Log = "Fun$$HEX2$$e700e300$$ENDHEX$$o: of_anula_autorizacao - Retorno: " + ls_informativeText
		io_Comum.of_envia_email(ls_Log)	
		Gvo_Aplicacao.of_grava_log( "CANCELANDO AUTORIZACAO PORTAL DROGARIA: " + ls_Log)
	End If	
	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_informativeText)
	
	Return True
	
Catch (RunTimeError lo_error)
	io_Comum.of_envia_email(lo_error.GetMessage())
	Return False
	
Finally

End Try
end function

public function boolean of_autenticacao_anula (ref string as_json_retorno, ref string as_erro);Boolean lb_Envia_Preco = True

String ls_Json_Envio
String ls_Terminal
String ls_data
String ls_data_Nascimento
String ls_Json_Produtos
String ls_Nr_NF
String ls_Cartao_Industria
String ls_CPF
String ls_CNPJ

DateTime ldt_Parametro

SetNull(as_Json_Retorno)

If Not This.io_Comum.of_verifica_url_integracao('URL_ANULA', Ref as_Erro) Then
 	Return False
End If

//Nome do PDV
ls_Terminal 		= gvo_Aplicacao.of_computername(  )

ldt_Parametro 	= gf_GetServerDate()
ls_Data			= String(ldt_Parametro, "YYYY-MM-DD")+"T"+String(ldt_Parametro, "HH:MM:SS")
		  		
////Formata todos os produtos
If Not This.of_monta_json_produto('ANULA', lb_Envia_Preco, Ref ls_Json_Produtos, Ref as_Erro) Then
	io_Comum.of_envia_email( "Fun$$HEX2$$e700e300$$ENDHEX$$o: of_autenticacao_anula - Erro ao montar o json do grupo dos produtos.")
	Return False
End If

//Localiza_Cliente
ls_CPF = is_CPF
If IsNull(ls_CPF) Then
	ls_CPF = ''
Else
	io_Cliente.of_localiza_cpf(ls_CPF, False)

	//Nascimento cliente
	If io_Cliente.Localizado Then
		ls_data_Nascimento = String(io_Cliente.dh_nascimento, "YYYY-MM-DD")+"T00:00:00"
	End If
End If

//Data Nascimento
//If IsNull(This.idt_nascimento) Then
//	ls_data_Nascimento = ''
//Else
//	ls_data_Nascimento = String( This.idt_nascimento, "YYYY-MM-DD")+"T00:00:00" // cliente nao identificado
//End If

//N$$HEX1$$e300$$ENDHEX$$o enviar a data de Nascimento
ls_data_Nascimento = ''

//Se n$$HEX1$$e300$$ENDHEX$$o estiver preenchido o nr da autoriza$$HEX2$$e700e300$$ENDHEX$$o o sistema de caixa poder$$HEX1$$e100$$ENDHEX$$ enviar sem o nr mesmo.
If Not IsNull(This.il_NF) And This.il_NF > 0 Then
	ls_Nr_NF = String(This.il_NF)
Else
	ls_Nr_NF = MID( is_NR_AUTORIZACAO, lenA(is_NR_AUTORIZACAO) - 4 )
End If

//Cart$$HEX1$$e300$$ENDHEX$$o de identificacao Industria
If IsNull(This.is_nr_cartao_programa ) Then
	ls_Cartao_Industria = ''
Else
	ls_Cartao_Industria = This.is_nr_cartao_programa 
End If

ls_CNPJ = Gvo_Parametro.nr_cgc

ls_Json_Envio = '{ "control": {' 													+&
							  '"clientId": "' + io_Comum.is_cliente_id +'",'	+&
							  '"username": "CLAMED",'							+& 
							  '"tableId": "' + io_Comum.is_table_id + '",'		+&
							  '"localNumber": "1",'									+&
							  '"localHour": "' + ls_Data + '",' 					+&						
							  '"industryId": "999",'									+&
							  '"stationId": "' + ls_Terminal+	'",'		        	 	+&
							  '"terminalId": "CHECKOUT",'						+&
							  '"companyCode": "' + ls_CNPJ +'",'				+&
							  '"attendanceHash": "",'								+&
							   '"OperationId": ' + ls_NR_NF + ',' 				+&
							  '"softwareId": "CAIXA' +gvo_Aplicacao.ivs_Versao+ '"'	+&
						 '},'															+&
						'"consumer": {'												+&
							    '"holderId": "' + ls_CPF + '",'						+&
							     '"cardId": "' + ls_Cartao_Industria + '"'		+&
						 '},	'															+&
						 '"product": [' 												+&
	/*Produtos*/	      ls_Json_Produtos										+&		
						 '],'															+&
						'"transaction": {'														+&
							  '"transactionCode": "' +is_NR_AUTORIZACAO + '"'		+&
						'}}'
	
If Not io_Comum.of_post( ls_json_Envio, "", ref as_Json_Retorno, ref as_Erro ) Then Return False

Return True
end function

public function boolean of_efetiva_transacao ();String ls_Json_Retorno
String ls_Erro, ls_Log
String ls_Null

SetNull(ls_Null)

Try
	//Busca o Token de Acesso
	If Not io_Comum.of_gera_token( Ref ls_erro) Then
		io_Comum.of_envia_email(ls_erro)
		Return False
	End If
	
	//utiliza o Token p/ buscar
	If Not This.of_autenticacao_efetiva( Ref ls_Json_Retorno, Ref ls_Erro ) Then
		io_Comum.of_envia_email(ls_Erro)			
		Return False
	End If
	
	//Tratamento de Erro
//	If PosA(ls_Json_Retorno, '"error"') > 0 Then
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao finalizar a Autoriza$$HEX2$$e700e300$$ENDHEX$$o.~r~r" + ls_Json_Retorno)
//		io_Comum.of_envia_email(ls_Json_Retorno)
//		Return False
//	Else
		If Not This.of_processa_retorno_efetiva( ls_json_retorno, ref ls_erro ) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao finalizar a Autoriza$$HEX2$$e700e300$$ENDHEX$$o.~r~rRETORNO PBM: " + ls_erro)
			//io_Comum.of_envia_email(ls_erro)
			Return False
		End If	
//	End If
	
	Return True
	
Catch (RunTimeError lo_error)
	io_Comum.of_envia_email(lo_error.GetMessage())
	Return False
	
Finally

End Try
end function

public function boolean of_monta_json_produto (string as_tipo_operacao, boolean ab_envia_preco, ref string as_json_produtos, ref string as_erro);Integer li_Row
Integer li_Linhas
Integer li_Qtde

String ls_EAN
String ls_JSON_Produtos

Decimal ldc_Bruto
Decimal ldc_Liquido

Try
	dc_uo_ds_base lo_Produtos
	lo_Produtos = Create dc_uo_ds_base
	
	Choose Case as_tipo_operacao
		Case 'CONFIRMA', 'ANULA'
			If Not lo_Produtos.of_changedataobject( 'dw_ge570_produtos_autorizados') Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no evento of_changedataobject. FUn$$HEX2$$e700e300$$ENDHEX$$o: of_monta_json_produto()")
			End If
			This.ids_produtos_autorizados.RowsCopy(1, This.ids_produtos_autorizados.RowCount(), Primary!, lo_Produtos, 1, Primary!)
			
		Case 'EFETIVA'
			If Not lo_Produtos.of_changedataobject( 'ds_ge570_produtos_atendimento') Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no evento of_changedataobject. Fun$$HEX2$$e700e300$$ENDHEX$$o: of_monta_json_produto()")
			End If
			This.ids_produtos_atendimento.RowsCopy(1, This.ids_produtos_atendimento.RowCount(), Primary!, lo_Produtos, 1, Primary!)
	End Choose
	
	//li_Linhas = ids_produtos_atendimento.RowCount()
	li_Linhas = lo_Produtos.RowCount()
	
	If li_Linhas <= 0 Then
		as_Erro = "Nenhum produto localizado / autorizado"
		Return False
	End If
	
	For li_Row = 1 To li_Linhas
		
		Choose Case as_tipo_operacao
			Case 'CONFIRMA', 'ANULA'
				If lo_Produtos.object.id_erro [li_Row] <> 0 Then
					Continue
				End If
				li_Qtde		= lo_Produtos.object.qt_autorizada		[li_Row]
			Case 'EFETIVA'
				li_Qtde		= lo_Produtos.object.qt_produto			[li_Row] 
		End Choose
			
		ls_EAN		= lo_Produtos.object.de_codigo_barras 		[li_Row]
		ldc_Bruto		= lo_Produtos.object.vl_preco_bruto			[li_Row]
		ldc_Liquido	= lo_Produtos.object.vl_preco_liquido			[li_Row]
		
		If ab_Envia_Preco Then
			ls_JSON_Produtos += 	'{ "id":' + String(li_Row)	+','													+&
											'"packId": 0,'																		+&
											'"EAN": ' + ls_EAN + ','															+&
											'"requestedQuantity": ' + String(li_Qtde) + ','								+&
											'"listPrice": ' + gf_retorna_so_numeros( String(ldc_Bruto) )	+ ','		+&
											'"netPrice": ' + gf_retorna_so_numeros( String(ldc_Liquido) )	+ ','	+&
											'"discountType": "B" },'
											
		Else
			//Utilizado na Confirma$$HEX2$$e700e300$$ENDHEX$$o
			ls_JSON_Produtos += 	'{ "id":' + String(li_Row)	+','													+&
											'"EAN": ' + ls_EAN 																	+&
											' },'
		End If
	Next
	
	//No ultimo Produto retira a ultima virgula
	If Not IsNull(ls_JSON_Produtos) And Trim(ls_JSON_Produtos)<>'' Then
		ls_JSON_Produtos = Mid( ls_JSON_Produtos, 1, LenA(ls_JSON_Produtos) -1 )
	End if
	
	//Retorna o json com todos os itens do atendimento
	as_Json_Produtos = ls_Json_Produtos
	
Finally
	If IsValid(lo_Produtos) Then Destroy lo_Produtos
End Try
	
	
 
end function

public function boolean of_confirma_autorizacao (ref string as_erro);String ls_Json_Retorno
String ls_Log
String ls_Null

SetNull(ls_Null)

Try
	If IsNull(This.is_Nr_Autorizacao) Or This.is_Nr_Autorizacao = '' Then
		//Nao gerou autorizacao
		Return True
	End if
		
	//Busca o Token de Acesso
	If Not io_Comum.of_gera_token( Ref as_erro) Then
		io_Comum.of_envia_email(as_erro)
		Return False
	End If
	
	//utiliza o Token p/ buscar
	If Not This.of_autenticacao_confirmacao( Ref ls_Json_Retorno, Ref as_erro ) Then
		io_Comum.of_envia_email(as_erro)			
		Return False
	End If
	
	//Tratamento de Erro
	If PosA(ls_Json_Retorno, '"error"') >0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao confirmar a Autoriza$$HEX2$$e700e300$$ENDHEX$$o.~r~r" + ls_Json_Retorno)
		io_Comum.of_envia_email(ls_Json_Retorno)
		as_erro = ls_Json_Retorno
		Return False
	Else
		If Not This.of_processa_retorno_confirmacao( ls_json_retorno, ref as_erro ) Then
			io_Comum.of_envia_email(as_erro)
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

on uo_ge570_portal_drogaria_checkout.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge570_portal_drogaria_checkout.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;io_Comum						= Create uo_ge570_portal_drogaria_comum 
io_Json 							= Create uo_ge073_json
io_Cliente						= Create uo_Cliente

ids_produtos_atendimento 	= Create dc_uo_ds_base 
ids_produtos_autorizados	= Create dc_uo_ds_base 

ids_produtos_atendimento.of_changedataobject( "ds_ge570_produtos_atendimento" )
ids_produtos_autorizados.of_changedataobject( "dw_ge570_produtos_autorizados" )
end event

event destructor;If IsValid(io_Comum) 	Then Destroy io_Comum
If IsValid(io_Json) 		Then Destroy io_Json
If IsValid(io_Cliente) 	Then Destroy io_Cliente

If IsValid( ids_produtos_atendimento ) Then Destroy ids_produtos_atendimento
If IsValid( ids_produtos_autorizados ) Then Destroy ids_produtos_autorizados


end event

