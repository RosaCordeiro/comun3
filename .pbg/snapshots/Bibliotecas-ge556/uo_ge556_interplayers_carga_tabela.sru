HA$PBExportHeader$uo_ge556_interplayers_carga_tabela.sru
forward
global type uo_ge556_interplayers_carga_tabela from nonvisualobject
end type
end forward

global type uo_ge556_interplayers_carga_tabela from nonvisualobject
end type
global uo_ge556_interplayers_carga_tabela uo_ge556_interplayers_carga_tabela

type variables
uo_ge570_portal_drogaria_comum io_Comum
uo_ge040_json io_Json

dc_uo_ds_base ids_EAN

dc_uo_transacao iuo_SqlCa_log

str_ge556_combo		st_combo
str_ge556_loadtable	st_loadtable
str_ge556_coupons	st_coupons
str_ge556_produto	st_produto

String is_Codigo_Barras

Any ia_Null
end variables

forward prototypes
public function boolean of_processa_lista_produto ()
public function boolean of_autenticacao (ref string as_json_retorno, ref string as_erro)
public function boolean of_carrega_dados_json (string as_json_retorno, ref string as_erro)
public function boolean of_deleta_registros_pbm (ref string as_erro)
public function boolean of_grava_pbm_produto (ref string as_erro)
public function boolean of_processa_carga_pbm (ref string as_erro)
public function boolean of_abre_conexao (ref string as_erro)
public function boolean of_fecha_conexao ()
public function boolean of_processa_atualizacao_carga (ref string as_erro)
public function boolean of_grava_produto (ref string as_erro)
public function boolean of_atualiza_tabela_log (integer ai_tipo, string as_status, string as_cod_barras, string as_mensagem, ref string as_erro)
public function boolean of_localiza_produto (string as_codigo_barras, ref string as_cod_barras_alterado, ref long al_produto, ref string as_erro)
public function boolean of_carrega_cupom (string as_json, ref string as_erro)
end prototypes

public function boolean of_processa_lista_produto ();String ls_Json_Retorno
String ls_Erro, ls_Log
String ls_Null

SetNull(ls_Null)


//---- of_Atualiza_Tabela_Log -------
//TIPO 1 - CARGA TABELA
//TIPO 2 - CARGA PBM_PRODUTO

Try
	
	
	io_Comum 	= Create uo_ge570_portal_drogaria_comum
	io_Json 		= Create uo_ge040_json
	ids_EAN 		= Create dc_uo_ds_base
	
	uo_Parametro_Geral lo_Parametro_Geral
	lo_Parametro_Geral = Create uo_Parametro_Geral
	
	//Busca o Token de Acesso
	If Not io_Comum.of_Gera_Token(Ref ls_Log) Then	
		If Not This.of_Atualiza_Tabela_Log( 1, "-1", ls_Null, ls_Log, Ref ls_erro) Then
			ls_Log = ls_erro + " - LOG: " + ls_Log
		End If
		io_Comum.of_envia_email(ls_Log)
		Return False
	End If
	
	//utiliza o Token p/ buscar a carga de tabela
	If Not This.of_Autenticacao(Ref ls_Json_Retorno, Ref ls_Log) Then
		If Not This.of_Atualiza_Tabela_Log( 1, "-1", ls_Null, ls_Log, Ref ls_erro) Then
			ls_Log = ls_erro + " - LOG: " + ls_Log
		End If
		io_Comum.of_envia_email(ls_Log)			
		Return False
	End If
	
	//Lista de Produto/EAN Interno
	If Not ids_EAN.of_ChangeDataObject("ds_ge556_lista_ean") Then
		ls_Log = "Erro no ChangeDataObject da ds_ge556_lista_ean. Fun$$HEX2$$e700e300$$ENDHEX$$o of_processa_carga_produto"
		If Not This.of_Atualiza_Tabela_Log( 1, "-1", ls_Null, ls_Log, Ref ls_erro) Then
			ls_Log = ls_erro + " - LOG: " + ls_Log
		End If
		io_Comum.of_envia_email( ls_Log )		
		Return False
	End If
	
	//Retrieve na lista de ean
	If ids_Ean.Retrieve() < 0 Then
		ls_Log = "Erro no Retrieve da ds_ge556_lista_ean. Fun$$HEX2$$e700e300$$ENDHEX$$o of_processa_carga_produto"
		If Not This.of_Atualiza_Tabela_Log( 1, "-1", ls_Null, ls_Log, Ref ls_erro) Then
			ls_Log = ls_erro + " - LOG: " + ls_Log
		End If
		io_Comum.of_envia_email( ls_Log )		
		Return False
	End If	
	
	//Carrega os valores do json e atribui para as estruturas
	If Not This.of_Carrega_Dados_Json(ls_Json_Retorno, Ref ls_Erro) Then
		If Not This.of_Atualiza_Tabela_Log( 1, "-1", ls_Null, ls_Log, Ref ls_erro) Then
			ls_Log = ls_erro + " - LOG: " + ls_Log
		End If
		io_Comum.of_envia_email( ls_Log )	
	End If
	
	//Pega os valores da estrutura e grava no banco 
	If Not This.of_Processa_atualizacao_carga( Ref ls_erro) Then
		If Not This.of_Atualiza_Tabela_Log( 1, "-1", ls_Null, ls_Log, Ref ls_erro) Then
			ls_Log = ls_erro + " - LOG: " + ls_Log
		End If
		io_Comum.of_envia_email( ls_Log )	
	End If
	
	//Grava na tabela pbm_produto
	If Not This.of_Processa_Carga_PBM(Ref ls_Erro) Then
		If Not This.of_Atualiza_Tabela_Log( 2, "-1", ls_Null, ls_Log, Ref ls_erro) Then
			ls_Log = ls_erro + " - LOG: " + ls_Log
		End If
		io_Comum.of_envia_email( ls_Log )	
		Return False
	End If	
	
	Update parametro_interplayer set vl_parametro = :st_loadtable.tableid
	 Where cd_parametro = 'TABLEID'
	 Using SqlCa;
	 
	 If SqlCa.SqlCode = -1 Then
		ls_Log = "Erro ao atualizar o TableID na tabela parametro_interplayer, parametro: TABLEID. Erro:" + SqlCa.sqlerrtext 
		This.of_atualiza_tabela_log( 1, "-1", ls_Null, ls_Log, Ref ls_erro)
	End If
	
	//Somente no final do processo
	SqlCa.of_Commit()
		
	Return True
	
Catch (RunTimeError lo_error)
	io_Comum.of_envia_email(lo_error.GetMessage())
	Return False
	
Finally
	If IsValid(io_Comum) 				Then Destroy(io_Comum)
	If IsValid(io_Json) 					Then Destroy(io_Json)
	If IsValid(ids_EAN) 				Then Destroy(ids_EAN)
	If IsValid(lo_Parametro_Geral)	Then Destroy(lo_Parametro_Geral)
End Try
end function

public function boolean of_autenticacao (ref string as_json_retorno, ref string as_erro);String ls_Json_Envio
String ls_Terminal

DateTime ldt_Parametro

String ls_data

//Nome do PDV
ls_Terminal 		= gvo_Aplicacao.of_computername(  )

ldt_Parametro 	= gf_GetServerDate()
ls_Data			= String(ldt_Parametro, "YYYY-MM-DD")+"T"+String(ldt_Parametro, "HH:MM:SS")

SetNull(as_Json_Retorno)

If Not This.io_Comum.of_verifica_url_integracao('URL_LOADTABLE', Ref as_Erro) Then
 	Return False
End If	 

//companyCode = CNPJ da matriz
ls_Json_Envio = '{"control": { ' +&
							   '"clientId": "' + io_Comum.is_cliente_id +'",'	+&
							  '"username": "CLAMED",'							+& 
							  '"tableId": "1",'										+&
							  '"localNumber": "",'									+&
							  '"localHour": "' + ls_Data + '",' 					+&
							  '"industryId": "999",'									+&
  						      '"stationId": "' + ls_Terminal + '",'				+&
							  '"companyCode": "84683481000177",'			+&
							  '"tableVersion": "1",'									+&
							  '"tableImage": "1" }' 								+&
					'}'
	
If Not io_Comum.of_post( ls_json_Envio, "", ref as_Json_Retorno, ref as_Erro ) Then Return False

Return True
end function

public function boolean of_carrega_dados_json (string as_json_retorno, ref string as_erro);
String ls_retorno_produto, ls_sobra_Produto
String ls_retorno_coupons, ls_sobra_coupons
String ls_aux, ls_retorno
String ls_retorno_Combo, ls_sobra_combo
String ls_retorno_Control

String ls_EAN, ls_EAN_Combo
String ls_Cod_Industria
String ls_Aux_Combo
String ls_Control
String ls_Data
String ls_info_itens
String ls_Nome_Industria
String ls_Msg_Prd
String ls_Msg_Retorno_WS
String ls_Cod_Retorno_WS
String ls_EAN_Alterado

String ls_TABLE_ID
String ls_Null
String ls_Log

DateTime ldt_Data

Long ll_Produto
Long ll_Produto_Combo

integer li_Pos_Inicio, li_pos_Fim
Integer li_Len
Integer li_Row, li_Row_Combo

Any la_Ret_API

Try
	SetNull(ls_Null)

	uo_ge073_json lo_json
	lo_json = Create uo_ge073_json 
		
	ls_aux = as_json_retorno
	
	ls_Cod_Retorno_WS = lo_json.of_busca_conteudo_campo(ls_aux, 'returnCode')
	ls_Msg_Retorno_WS = lo_json.of_busca_conteudo_campo(ls_aux, 'informativeText')
		
	ls_Data = lo_json.of_busca_conteudo_campo(ls_aux, 'centralHour')
	ls_Data = mid(ls_data, 1, 10) + " " + mid(ls_data, 12, 8)
	ldt_Data = DateTime(  ls_Data )
	
	//C$$HEX1$$f300$$ENDHEX$$digo da tabela que dever$$HEX1$$e100$$ENDHEX$$ ser usado em todas as outras consultas da api
	ls_TABLE_ID = lo_json.of_busca_conteudo_campo(ls_aux, 'tableId')
	
	If TRIM(ls_TABLE_ID) = "" Then
		ls_Log = "Erro ao buscar o TableID na carta de tabela"
		This.of_atualiza_tabela_log( 1, "-1", ls_Null, ls_Log, Ref as_erro)
	End If

	st_loadtable.centralhour 	= ldt_Data
	st_loadtable.tableid		= ls_TABLE_ID
	
	//Ira buscar:
	//De: tableImage At$$HEX1$$e900$$ENDHEX$$: coupons
	lo_json.of_divide_grupo_json_tag_vtex( ref as_json_retorno, 'tableImage', ref ls_info_itens, 'coupons')
	
	//Zera o contador
	li_Row = 0
	
	//Produtos
	Do While lo_json.of_divide_grupo_json_completo(Ref ls_info_itens, Ref ls_retorno,'{')
		
		ls_sobra_Produto 	= ls_retorno
		ls_Sobra_Combo	= ls_retorno
								
		ls_Ean				=  lo_json.of_busca_conteudo_campo_vtex(ls_sobra_Produto, 'ean')
		ls_Cod_Industria 	=  lo_json.of_busca_conteudo_campo_vtex(ls_sobra_Produto, 'industryId')
		ls_Nome_Industria	=	UPPER( lo_json.of_busca_conteudo_campo_vtex(ls_sobra_Produto, 'industryName') )
		
		//Zera o contador dos combos
		li_Row_Combo 		= 0
		
		If Not This.of_localiza_produto( ls_Ean, Ref ls_EAN_Alterado, Ref ll_Produto, Ref ls_Msg_Prd ) Then
			This.of_Atualiza_Tabela_Log( 1, "1", ls_Ean, ls_Msg_Prd, Ref as_erro)
			Continue
		End If
		
		//Se alterou o EAN no localizacao
		ls_Ean = IIF( IsNull(ls_EAN_Alterado), ls_Ean, ls_EAN_Alterado )
		
		//Industria DERMACLUB n$$HEX1$$e300$$ENDHEX$$o entre na carga
		If ls_Nome_Industria = 'DERMACLUB' Then
			Continue	
		End If
		
		//Contador
		li_Row++
		
		//Utilizado p/ registro de logs
		is_Codigo_Barras = ls_Ean
				
		st_loadtable.produto[li_Row].ean							= ls_Ean
		st_loadtable.produto[li_Row].industryid					= ls_Cod_Industria		
		st_loadtable.produto[li_Row].industryName				= ls_Nome_Industria
		st_loadtable.produto[li_Row].informativetext			= lo_json.of_busca_conteudo_campo_vtex(ls_sobra_Produto, 'informativeText')
		st_loadtable.produto[li_Row].discountmax				= lo_json.of_busca_conteudo_campo_vtex(ls_sobra_Produto, 'discountMax')
		st_loadtable.produto[li_Row].discountmin				= lo_json.of_busca_conteudo_campo_vtex(ls_sobra_Produto, 'discountMin')
		st_loadtable.produto[li_Row].suggestedprice			= lo_json.of_busca_conteudo_campo_vtex(ls_sobra_Produto, 'suggestedPrice')
		st_loadtable.produto[li_Row].authorizer					= lo_json.of_busca_conteudo_campo_vtex(ls_sobra_Produto, 'authorizer')
		st_loadtable.produto[li_Row].requestholderid			= lo_json.of_busca_conteudo_campo_vtex(ls_sobra_Produto, 'requestHolderId')
		st_loadtable.produto[li_Row].requestcoupon			= lo_json.of_busca_conteudo_campo_vtex(ls_sobra_Produto, 'requestCoupon')
		st_loadtable.produto[li_Row].discountabsolute			= lo_json.of_busca_conteudo_campo_vtex(ls_sobra_Produto, 'discountAbsolute')
		st_loadtable.produto[li_Row].pointing						= lo_json.of_busca_conteudo_campo_vtex(ls_sobra_Produto, 'pointing')
		st_loadtable.produto[li_Row].allchain						= lo_json.of_busca_conteudo_campo_vtex(ls_sobra_Produto, 'allChain')
		st_loadtable.produto[li_Row].requiredonline				= lo_json.of_busca_conteudo_campo_vtex(ls_sobra_Produto, 'requiredOnLine')
		st_loadtable.produto[li_Row].discountMaxNewPatient	= lo_json.of_busca_conteudo_campo_vtex(ls_sobra_Produto, 'discountMaxNewPatient')
		st_loadtable.produto[li_Row].qtyForDiscountMax		= lo_json.of_busca_conteudo_campo_vtex(ls_sobra_Produto, 'qtyForDiscountMax')
		st_loadtable.produto[li_Row].cd_produto_interno 		= ll_Produto
		
		ls_retorno = gf_Replace(ls_retorno, "        ", 	"", 0 ) //Espaco
		ls_retorno = gf_Replace(ls_retorno, "~r~n", 	"", 0 ) //Enter
		st_loadtable.produto[li_Row].json_prd				= ls_retorno
				
		//----EAN COMBO
//		lo_json.of_divide_grupo_json_tag(Ref ls_Sobra_Combo, 'eanCombos', Ref ls_retorno_Combo,']') 
//					
//		If PosA( ls_retorno_combo, "SEM DESCONTO COMBO" ) > 0 Then
//			//Sem EAN Combo
//		Else
//			ls_Aux_Combo = ls_retorno_combo
//			
//			li_Pos_Inicio	    = PosA(ls_Aux_Combo, 'ean": [') // 7 caracter
//			ls_Aux_Combo = Mid(ls_Aux_Combo, li_Pos_Inicio + 7)	
//				
//			ls_Aux_Combo = Trim(ls_Aux_Combo)
//			ls_Aux_Combo = gf_Replace(ls_Aux_Combo, ",", "", 0)	
//
//			//Processa EAN Combo
//			Do	
//				li_Row_Combo++
//				ls_EAN_Combo = ''
//				
//				li_Pos_Inicio 	= PosA(ls_Aux_Combo, '"')
//				li_Pos_fim 		= PosA(Mid(ls_Aux_Combo, li_Pos_Inicio+1), '"')
//				
//				ls_EAN_Combo = Mid(ls_Aux_Combo, li_Pos_Inicio+1, li_Pos_fim - 1)
//				
//				If Not This.of_localiza_produto( ls_EAN_Combo, Ref ls_EAN_Alterado, Ref ll_Produto_Combo, Ref ls_Msg_Prd ) Then
//					This.of_Atualiza_Tabela_Log( 1, "1", ls_EAN_Combo, ls_Msg_Prd, Ref as_erro)
//				End If
//				
//				//Se alterou o EAN no localizacao
//				ls_EAN_Combo = IIF( IsNull(ls_EAN_Alterado), ls_EAN_Combo, ls_EAN_Alterado )
//				
//				st_loadtable.produto[li_Row].eacombos[li_Row_Combo].ean = ls_EAN_Combo
//				
//				//Adiciona ean combo
//				li_Len = LenA(ls_EAN_Combo)						
//				
//				ls_Aux_Combo = Mid(ls_Aux_Combo, Pos(ls_Aux_Combo, ls_EAN_Combo) + li_Len + 2) //Retirando a ultima
//						
//			Loop While PosA(ls_Aux_Combo, '"') > 0	
//		End If 
		//---FIM EAN COMBO
		
	Loop //Produtos

	
	//Processa Coupons ******************************
	// N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio gravar o registro de cupons
	//If Not This.of_Carrega_Cupom(as_json_retorno, Ref as_Erro) Then 	End If

	Return True
	
Catch (RunTimeError lo_error)
	as_Erro = lo_error.GetMessage()
	Return False
	
Finally
	If IsValid(lo_json) 					Then Destroy lo_json
End Try
end function

public function boolean of_deleta_registros_pbm (ref string as_erro);//Antes de iniciar a carga dos produtos Interplayer nas tabelas PBM, os registros s$$HEX1$$e300$$ENDHEX$$o exclu$$HEX1$$ed00$$ENDHEX$$dos para ap$$HEX1$$f300$$ENDHEX$$s serem inseridos os valores atualizados



Delete From pbm_produto
Where cd_pbm = 175
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_Erro = "Erro ao excluir os registros Interplayer da tabela pbm_produto " + SqlCa.SqlErrText
	SqlCa.of_Rollback();
	Return False
End If

Return True
end function

public function boolean of_grava_pbm_produto (ref string as_erro);Decimal ldc_Vl_Desconto

Integer li_Achou
Integer li_Row
Integer li_Qt_Para_Desconto_Maximo

Long ll_Linhas
Long ll_PBM
Long ll_Produto

String ls_Consulta_Online
String ls_utiliza_cupom
String ls_Msg
String ls_Id_Desconto
String ls_Industria
String ls_utiliza_cpf

Decimal{2} ldc_PC_Desconto
Decimal{2} ldc_PC_Desc_Maximo
Decimal{2} ldc_PC_Desc_Minimo
Decimal{2} ldc_PC_Desc_Novo_Cliente

ll_PBM = 175

Try
	ll_Linhas = 	UpperBound( st_loadtable.produto[] )
	
	For li_Row = 1 To ll_Linhas
		//Atualiza a var para gravar nos registros de log
		is_Codigo_Barras 		= st_loadtable.produto[ li_Row ].ean
				
		ll_Produto 				= st_loadtable.produto[ li_Row ].cd_produto_interno
		ldc_Vl_Desconto		= gf_Decimal( st_loadtable.produto[ li_Row ].discountabsolute, 2 )
		ls_Msg					= st_loadtable.produto[ li_Row ].informativetext
		ls_Consulta_Online	= st_loadtable.produto[ li_Row ].requiredonline
		ls_Utiliza_Cupom		= st_loadtable.produto[ li_Row ].requestcoupon //Cartao consumidor - identifica$$HEX2$$e700e300$$ENDHEX$$o da industria 
		ldc_PC_Desconto		= gf_Decimal(st_loadtable.produto[ li_Row ].discountMin, 2)
		ls_Industria				= st_loadtable.produto[ li_Row ].industryname
		ls_utiliza_cpf			= st_loadtable.produto[ li_Row ].requestholderid 
		//novos campos da carga
		ldc_PC_Desc_Maximo				= gf_Decimal(st_loadtable.produto[ li_Row ].discountMax, 2)
		ldc_PC_Desc_Minimo				= gf_Decimal(st_loadtable.produto[ li_Row ].discountmin , 2)
		ldc_PC_Desc_Novo_Cliente		= gf_Decimal(st_loadtable.produto[ li_Row ].discountmaxnewpatient , 2)
		li_Qt_Para_Desconto_Maximo	= Integer( st_loadtable.produto[ li_Row ].qtyfordiscountmax )
		If IsNull(li_Qt_Para_Desconto_Maximo) Then li_Qt_Para_Desconto_Maximo = 0		
		
		
//		If ldc_Vl_Desconto > 0.0 Then
//			ls_Id_Desconto = "S"
//		Else
//			ls_Id_Desconto = "N"
//		End If
		
		ls_Id_Desconto = "S"
		
		Select Count(*)
			Into :li_Achou
		From pbm_produto
		Where cd_pbm 		= :ll_PBM
			And cd_produto 	= :ll_Produto
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			as_Erro = "Erro ao verificar se o produto [" + String(ll_Produto) + "] j$$HEX1$$e100$$ENDHEX$$ foi inserido no PBM [" + String(ll_PBM) + "]. " + SqlCa.SqlErrTExt
			SqlCa.of_Rollback();
			Return False
		End If
		
		If li_Achou = 0 Then
			Insert Into pbm_produto(cd_pbm,
					 cd_produto,
					 id_preco_fixo,
					 vl_preco_fixo,
					 id_desconto,
					 pc_desconto,
					 id_gratis,
					 id_caixa_bonus,
					 de_observacao,
					 id_tipo,
					 vl_desconto,
					 id_consulta_online,
					 id_utiliza_cartao_consumidor,
					 id_utiliza_cpf,
					 nm_industria,
					 pc_desconto_minimo,
					 pc_desconto_maximo,
					 pc_desconto_novo_paciente,
					 qt_desconto_maximo)
			 Values(:ll_PBM,
					  :ll_Produto,
					  'N',
					  0.00,
					  :ls_Id_Desconto,
					  :ldc_PC_Desconto,
					  'N',
					  'N',
					  :ls_Msg,
					  'I',
					  :ldc_Vl_Desconto,
					  :ls_consulta_online,
					  :ls_utiliza_cupom,
					  :ls_utiliza_cpf,
					  :ls_Industria,
					  :ldc_PC_Desc_Minimo,
					  :ldc_PC_Desc_Maximo,
					  :ldc_PC_Desc_Novo_Cliente,
					  :li_Qt_Para_Desconto_Maximo
					  )
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				as_Erro = "Erro ao inserir o produto " + String(ll_Produto) + " no PBM " + String(ll_PBM) + ". Fun$$HEX2$$e700e300$$ENDHEX$$o of_grava_pbm_produto. " + SqlCa.SqlErrText
				SqlCa.of_Rollback();
				Return False
			End If
		End If
	Next

	Return True
	
Catch (RunTimeError lo_error)
	as_Erro = lo_error.GetMessage()
	Return False
	
Finally
//
End Try
end function

public function boolean of_processa_carga_pbm (ref string as_erro);If UpperBound(st_loadtable.produto[]) > 0 Then

	If Not This.of_Deleta_Registros_PBM(Ref as_Erro) Then Return False
	
	If Not This.of_Grava_PBM_Produto(Ref as_Erro) Then Return False
Else
	//Nenhum produto foi ligo no arquivo e deve permacer a carga anterior.
	
End If

Return True
end function

public function boolean of_abre_conexao (ref string as_erro);//Abre uma nova transa$$HEX2$$e700e300$$ENDHEX$$o com o banco para gravar o registro.
If Not isvalid(iuo_SqlCa_log) Then
	iuo_SqlCa_log = Create dc_uo_transacao
	iuo_SqlCa_log.ivs_database = "SYBASE"
End If

If Not iuo_SqlCa_log.of_isconnected() Then
	If Not iuo_SqlCa_log.of_Connect(gvo_Aplicacao.ivs_DataSource, 'GE556 - Carga Produto Interplayer') Then
		as_Erro =  'Objeto: ' + This.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_abre_conexao_log ~n' + "Erro ao conectar no Sybase."
		Return False
	End If	
End If

Return True
end function

public function boolean of_fecha_conexao ();//Fecha conex$$HEX1$$e300$$ENDHEX$$o usada para gerar log
If isvalid(iuo_SqlCa_log) Then
	iuo_SqlCa_log.of_disconnect( )
	Destroy(iuo_SqlCa_log)
End If

Return True
end function

public function boolean of_processa_atualizacao_carga (ref string as_erro);If Not This.of_Grava_Produto(Ref as_Erro) Then Return False

//Ver se precisa gravar o cupons

Return True
end function

public function boolean of_grava_produto (ref string as_erro);Long ll_Row
Long ll_Rows

Decimal ldc_Desconto_Max
Decimal ldc_Desconto_Absoluto

For ll_Row = 1 To UpperBound(st_loadtable.produto[])
	
	//Atualiza a var para usar nos registros de log
	is_Codigo_Barras = st_loadtable.produto[ll_Row].ean
	
	ldc_Desconto_Max			= gf_Decimal( st_loadtable.produto[ll_Row].discountmax, 2 )
	ldc_Desconto_Absoluto 	= gf_Decimal( st_loadtable.produto[ll_Row].discountabsolute, 2 )
		
	Insert Into interplayer_carga_tabela(	dh_inclusao,
											de_codigo_barras,
											cd_produto,
											id_industria,
											nm_industria,
											id_consulta_online,
											id_utiliza_cupom,
											vl_desconto_maximo,
											vl_desconto_absoluto,
											de_retorno_json
											)
								Values(	getdate(),
											:is_Codigo_Barras,
											:st_loadtable.produto[ll_Row].cd_produto_interno,
											:st_loadtable.produto[ll_Row].industryid,
											:st_loadtable.produto[ll_Row].industryname,
											:st_loadtable.produto[ll_Row].requiredonline,
											:st_loadtable.produto[ll_Row].requestcoupon,
											:ldc_Desconto_Max,
											:ldc_Desconto_Absoluto,
											:st_loadtable.produto[ll_Row].json_prd
											)
											
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		as_Erro = "Erro ao gravar o Produto " + st_loadtable.produto[ll_Row].ean + "na tabela  interplayer_carga_tabela. " + SqlCa.SqlErrText
		SqlCa.of_Rollback();
		Return False
	End If

Next

Return True
end function

public function boolean of_atualiza_tabela_log (integer ai_tipo, string as_status, string as_cod_barras, string as_mensagem, ref string as_erro);String ls_Erro
String ls_Null

//Abre uma nova transa$$HEX2$$e700e300$$ENDHEX$$o com o banco para gravar o registro
If Not This.of_Abre_Conexao( Ref ls_Erro ) Then Return False

Insert into log_integracao_interplayer(id_tipo, dh_inclusao, id_status, cd_codigo_barras, de_msg )
Values (:ai_Tipo,  getdate(), :as_Status, :as_Cod_Barras, :as_mensagem )
Using iuo_SqlCa_log;

If iuo_SqlCa_log.SqlCode = - 1 Then
	as_Erro = 'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_tabela_log ~n' + 'Erro ao inserir registro na tabela "log_integracao_interplayer": ' + iuo_SqlCa_log.sqlerrtext
	iuo_SqlCa_log.of_Rollback()
	Return False
End If	

iuo_SqlCa_log.of_Commit();

this.of_fecha_conexao( )

Return True
end function

public function boolean of_localiza_produto (string as_codigo_barras, ref string as_cod_barras_alterado, ref long al_produto, ref string as_erro);Long ll_Find

String ls_Cod_Barras_Aux
String ls_Situacao

SetNull(as_Cod_Barras_Alterado)
SetNull(al_Produto)

//ATRIBUI PARA A VAR LOCAL
ls_Cod_Barras_Aux = as_codigo_barras

ll_Find = ids_EAN.Find("de_codigo_barras = '" + ls_Cod_Barras_Aux + "'", 1, ids_EAN.RowCount())

If ll_Find < 0 Then
	as_erro = "Erro no Find do EAN [" + ls_Cod_Barras_Aux + "]. Fun$$HEX2$$e700e300$$ENDHEX$$o of_Localiza_Produto"
	Return False
End If

If ll_Find = 0 Then
	ls_Cod_Barras_Aux = gf_Tira_Zero_Esquerda(ls_Cod_Barras_Aux)
	
	//Se removeu os zeros a esquerda, tenta localizar sem os zeros a esquerda
	If LenA(ls_Cod_Barras_Aux) < LenA(as_codigo_barras) Then		
		
		ll_Find = ids_EAN.Find("de_codigo_barras = '" + ls_Cod_Barras_Aux + "'", 1, ids_EAN.RowCount())
	
		If ll_Find < 0 Then
			as_erro = "Erro no Find do EAN [" + ls_Cod_Barras_Aux + "] apos retirar zero a esquerda. Fun$$HEX2$$e700e300$$ENDHEX$$o of_Localiza_Produto."
			Return False
		End If
		
		If ll_Find = 0 Then
			as_erro = "EAN [" + ls_Cod_Barras_Aux + "] apos retirar zero a esquerda. N$$HEX1$$c300$$ENDHEX$$O LOCALIZADO NO CADASTRO DE PRODUTO"
			Return False
		Else
			as_Cod_Barras_Alterado = ls_Cod_Barras_Aux
		End If
		
	Else
		as_erro = "EAN [" + ls_Cod_Barras_Aux + "] apos retirar zero a esquerda. N$$HEX1$$c300$$ENDHEX$$O LOCALIZADO NO CADASTRO DE PRODUTO"
		Return False
	End If
End If

If ll_Find > 0 Then
	ls_Situacao = ids_EAN.Object.id_situacao[ ll_Find ]
	al_Produto = ids_EAN.Object.cd_produto[ ll_Find ] //Retorna o cd_produto
	
	If ls_Situacao <> "A" Then
		as_erro = "EAN [" + ls_Cod_Barras_Aux + "] PRODUTO INATIVO. CD_PRODUTO: " +STRING(al_Produto)
		Return False
	End If
End If

Return True
end function

public function boolean of_carrega_cupom (string as_json, ref string as_erro);String ls_info_cupom
String ls_Sobra
String ls_Retorno
String ls_Nome_Industria
String ls_RangeStart
String ls_RangeEnd

Integer li_Row

Try
	uo_ge073_json lo
	lo = Create uo_ge073_json
	
	//lo_json.of_divide_grupo_json_tag_vtex( ref as_json_retorno, 'tableImage', ref ls_info_itens, 'coupons')
	
	//Produtos
	Do While lo.of_divide_grupo_json_completo( Ref ls_info_cupom, Ref ls_Retorno,'{' )		
		ls_sobra 	= ls_retorno
		
		/*
		"industryName": "ALFA",
	     "rangeStart": "6395730340",
	      "rangeEnd": "6395730349"
		*/
				
		ls_Nome_Industria	= UPPER( lo.of_busca_conteudo_campo_vtex( ls_sobra, 'industryName') )
		ls_RangeStart		= UPPER( lo.of_busca_conteudo_campo_vtex( ls_sobra, 'rangeStart') )
		ls_RangeEnd		= UPPER( lo.of_busca_conteudo_campo_vtex( ls_sobra, 'rangeEnd') )
		
		li_Row++
		st_loadtable.cupom[ li_Row ].industryName 	= ls_Nome_Industria
		st_loadtable.cupom[ li_Row ].rangeStart 		= ls_RangeStart
		st_loadtable.cupom[ li_Row ].rangeEnd 			= ls_RangeEnd
	
	LOOP
	
	Return True	
Finally
	If IsValid( lo ) Then Destroy lo
End Try
end function

on uo_ge556_interplayers_carga_tabela.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge556_interplayers_carga_tabela.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

