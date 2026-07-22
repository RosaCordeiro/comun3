HA$PBExportHeader$uo_ge536_dermaclub_envio_info.sru
forward
global type uo_ge536_dermaclub_envio_info from nonvisualobject
end type
end forward

global type uo_ge536_dermaclub_envio_info from nonvisualobject
end type
global uo_ge536_dermaclub_envio_info uo_ge536_dermaclub_envio_info

type variables
uo_ge536_dermaclub_comum io_Comum
uo_ge040_json io_Json
end variables

forward prototypes
public function boolean of_processa_envio ()
public function boolean of_envia_venda (ref string as_json_retorno, ref string as_erro)
public subroutine of_retorna_forma_pagamento (string as_tipo_venda, string as_cd_forma_pagto, ref string as_forma_pagto, ref string as_erro)
public function boolean of_envia_dev_e_canc (ref string as_json_retorno, ref string as_erro)
public function boolean of_envia_dev_e_canc_old (ref string as_json_retorno, ref string as_erro)
public function boolean of_retorna_projeto (ref string as_projeto, ref string as_erro)
public function boolean of_carrega_dados_json (string as_json_retorno, ref string as_erro)
public function boolean of_grava_registro_envio (string as_tipo, long al_filial, long al_nota, string as_especie, string as_serie, long al_nsu_transacao, ref string as_erro)
end prototypes

public function boolean of_processa_envio ();String ls_Json_Retorno
String ls_Erro

Try

	io_Comum = Create uo_ge536_dermaclub_comum
	io_Json = Create uo_ge040_json
	
	uo_ge536_dermaclub_carga lo_Carga
	lo_Carga = Create uo_ge536_dermaclub_carga
	
	//Seta il_Tabela = 3 para gravar o registro de Enviar Informa$$HEX2$$e700e300$$ENDHEX$$o na grava$$HEX2$$e700e300$$ENDHEX$$o do log
	lo_Carga.il_Tabela = 3
	
	// Carrega Informa$$HEX2$$e700e300$$ENDHEX$$o URL 
	If Not io_Comum.of_busca_url("ENTRAR", Ref io_Comum.is_Url, Ref ls_Erro) Then
		lo_Carga.of_Atualiza_Tabela_Log( 3, "-1", "", 0, Ref ls_erro)
		io_Comum.of_envia_email(ls_Erro)
		Return False
	End If
	
	If Not io_Comum.of_Gera_Token(Ref ls_Erro) Then
		lo_Carga.of_Atualiza_Tabela_Log( 3, "-1", "", 0, Ref ls_erro)
		io_Comum.of_envia_email(ls_Erro)
		Return False
	End If
	
	If Not This.of_Envia_Venda( Ref ls_Json_Retorno, Ref ls_Erro ) Then
		//Comentado para enviar direto de onde retorna false 
		//lo_Carga.of_Atualiza_Tabela_Log( 3, "-1", "", 0, ls_erro)
		//io_Comum.of_envia_email(ls_Erro)
		Return False
	End If
	
	If Not io_Comum.of_busca_url("ENVIAR", Ref io_Comum.is_Url, Ref ls_Erro ) Then
		lo_Carga.of_Atualiza_Tabela_Log( 3, "-1", "", 0, Ref ls_erro)
		io_Comum.of_envia_email(ls_Erro)
		Return False
	End If
	
	If Not This.of_Envia_Dev_E_Canc( Ref ls_Json_Retorno, Ref ls_Erro ) Then
		lo_Carga.of_Atualiza_Tabela_Log( 3, "-1", "", 0, ls_erro)
		io_Comum.of_envia_email(ls_Erro)
		Return False
	End If

	Return True
	
Catch (RunTimeError lo_error)
	io_Comum.of_envia_email(lo_error.GetMessage())
	Return False
	
Finally
	If IsValid(io_Comum) Then Destroy(io_Comum)
	If IsValid(io_Json) Then Destroy(io_Json)
	If IsValid(lo_Carga) Then Destroy(lo_Carga)
End Try
end function

public function boolean of_envia_venda (ref string as_json_retorno, ref string as_erro);Long ll_Linha
Long ll_Linhas
Long ll_Nr_Nf
Long ll_Filial

String ls_CPF
String ls_Tipo_Venda
String ls_Forma_Pagto
String ls_Cd_Forma_Pagto
String ls_Especie
String ls_Serie
String ls_Projeto
String ls_CNPJ
String ls_Cd_Canal_Venda

Try
	
	dc_uo_ds_base lds
	lds = Create dc_uo_ds_base
	
	uo_ge536_dermaclub_loja lo
	lo = Create uo_ge536_dermaclub_loja
	
	uo_ge536_dermaclub_carga lo_Carga
	lo_Carga = Create uo_ge536_dermaclub_carga
	
	//Seta il_Tabela = 3 para gravar o registro de Enviar Informa$$HEX2$$e700e300$$ENDHEX$$o na grava$$HEX2$$e700e300$$ENDHEX$$o do log
	lo_Carga.il_Tabela = 3
	
	If Not lds.of_ChangeDataObject("ds_ge536_lista_nota_venda") Then
		as_Erro = "Erro no change data object da 'ds_ge536_lista_nota_venda'. Fun$$HEX2$$e700e300$$ENDHEX$$o of_envia_venda"
		Return False
	End If
	
	ll_Linhas = lds.Retrieve()
	
	If ll_Linhas < 0 Then
		as_Erro = "Erro no retrieve da 'ds_ge536_lista_nota_venda'. Fun$$HEX2$$e700e300$$ENDHEX$$o of_envia_venda"
		Return False
	End If
	
	If ll_Linhas > 0 Then
		
		SetNull(as_Json_Retorno)
					
		If Not This.of_Retorna_Projeto( Ref ls_Projeto, Ref as_Erro ) Then Return False
		
		lo.is_Projeto	= ls_Projeto
		lo.is_usuario= io_Comum.is_usuario
		lo.is_senha	= io_Comum.is_senha
		
		For ll_Linha = 1 To ll_Linhas
			SetNull(as_Json_Retorno)
			SetNull(as_Erro)
			
			ls_CPF 					= lds.Object.Nr_Cpf_Cgc					[ll_Linha]
			ll_Nr_Nf					= lds.Object.Nr_NF						[ll_Linha]
			ls_Tipo_Venda			= lds.Object.Id_Tipo_Venda				[ll_Linha]
			ls_Cd_Forma_Pagto	= lds.Object.Cd_Forma_Pagamento	[ll_Linha]
			ll_Filial					= lds.Object.Cd_Filial_Venda			[ll_Linha]
			ls_Especie				= lds.Object.De_Especie					[ll_Linha]
			ls_Serie					= lds.Object.De_Serie					[ll_Linha]
			ls_CNPJ					= lds.Object.Nr_CGC						[ll_Linha]
			ls_Cd_Canal_Venda	= lds.Object.Cd_Canal_Venda			[ll_Linha]
			
			If isnull(ls_CPF) then
				as_Erro =  'CPF nulo, o processo continuar$$HEX1$$e100$$ENDHEX$$ sem esta venda. Canal de venda: ' + ls_Cd_Canal_Venda + ', NF: ' + string(ll_Nr_Nf) + ', Especie: ' + ls_Especie + ', Serie: ' + ls_Serie
				lo_Carga.of_Atualiza_Tabela_Log( 3, "-1", "", 0, as_Erro)
				io_Comum.of_envia_email(as_Erro)
				Continue
			End if
			
			If Not lo.of_Consulta_Cliente( ls_CPF, String(ll_Nr_Nf), ls_CNPJ, ls_Cd_Canal_Venda, Ref as_Erro ) Then 
				lo_Carga.of_Atualiza_Tabela_Log( 3, "-1", "", 0, as_Erro)
				io_Comum.of_envia_email(as_Erro)
				Continue
			End If
				
			If lo.ib_possui_cadastro Then
				This.of_Retorna_forma_pagamento( ls_Tipo_Venda, ls_Cd_Forma_Pagto, Ref ls_Forma_Pagto, Ref as_Erro)
				
				If Not lo.of_envia_venda( lo.is_sessao_consulta, ll_Filial, ll_Nr_NF, ls_Especie, ls_Serie, ls_Forma_Pagto, ls_CNPJ, Ref as_Json_Retorno, Ref as_Erro) Then 
					SqlCa.of_Rollback( );
					lo_Carga.of_Atualiza_Tabela_Log( 3, "-1", "", 0, as_Erro)
					io_Comum.of_envia_email(as_Erro)
					Continue
				End If
					
				If Not This.of_Grava_Registro_Envio("V", ll_Filial, ll_Nr_NF, ls_Especie, ls_Serie, lo.il_NSU_transacao, Ref as_Erro) Then
					lo_Carga.of_Atualiza_Tabela_Log( 3, "-1", "", 0, as_Erro)
					io_Comum.of_envia_email(as_Erro)
					Continue
				End If
				
				SqlCa.of_Commit();
			End If
		Next
	End If

	Return True
	
Catch (RunTimeError lo_error)
	io_Comum.of_envia_email(lo_error.GetMessage())
	Return False
	
Finally
	If IsValid(lds) Then Destroy(lds)
	If IsValid(lo) Then Destroy(lo)
	If IsValid(lo_Carga) Then Destroy(lo_Carga)
End Try
end function

public subroutine of_retorna_forma_pagamento (string as_tipo_venda, string as_cd_forma_pagto, ref string as_forma_pagto, ref string as_erro);as_Forma_Pagto = ""

If as_Tipo_Venda <> 'AV' Then
    as_Forma_Pagto  = '99'
Else
    Choose Case as_Cd_Forma_Pagto
        Case 'DI'
            as_Forma_Pagto = '01'
        Case 'CA'
            as_Forma_Pagto = '02'
        Case 'CP'
            as_Forma_Pagto = '03'
        Case Else
            as_Forma_Pagto = '99'
    End Choose
End If
end subroutine

public function boolean of_envia_dev_e_canc (ref string as_json_retorno, ref string as_erro);DateTime ldh_Atual

Long ll_Linha
Long ll_Linhas
Long ll_Nr_Nf
Long ll_Nr_Nf_Prox
Long ll_Nr_Transacao
Long ll_Nr_Transacao_Prox
Long ll_Qt_Devolvida
Long ll_Filial

String ls_CNPJ_Dev
String ls_CNPJ_Dev_Prox
String ls_Json_Envio
String ls_Interface
String ls_Produtos
String ls_EAN
String ls_Requisicao
String ls_Tipo
String ls_Especie
String ls_Serie

Try
	
	dc_uo_ds_base lds
	lds = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject("ds_ge536_lista_notas") Then
		as_Erro = "Erro no change data object da 'ds_ge536_lista_notas'. Fun$$HEX2$$e700e300$$ENDHEX$$o of_envia_dev_e_canc"
		Return False
	End If
	
	ll_Linhas = lds.Retrieve()
	
	If ll_Linhas < 0 Then
		as_Erro = "Erro no retrieve da 'ds_ge536_lista_notas'. Fun$$HEX2$$e700e300$$ENDHEX$$o of_envia_dev_e_canc"
		Return False
	End If
	
	If ll_Linhas > 0 Then
		
		SetNull(as_Json_Retorno)

		ls_Interface = "devolver_produto"
		
		For ll_Linha = 1 To ll_Linhas
			ls_Tipo				= lds.Object.Id_Tipo					[ll_Linha]
			ls_CNPJ_Dev		= lds.Object.Nr_CGC_Dev			[ll_Linha]
			ll_Nr_Nf				= lds.Object.Nr_NF					[ll_Linha]
			ll_Nr_Transacao 	= lds.Object.Nr_Nsu_Transacao	[ll_Linha]
			ls_EAN				= lds.Object.De_Codigo_Barras		[ll_Linha]
			ll_Qt_Devolvida		= lds.Object.Qt_Devolvida			[ll_Linha]
			ll_Filial				= lds.Object.Cd_Filial_Venda		[ll_Linha]
			ls_Especie			= lds.Object.De_Especie				[ll_Linha]
			ls_Serie				= lds.Object.De_Serie				[ll_Linha]
			
			If ll_Linha < ll_Linhas	Then
				ls_CNPJ_Dev_Prox	= lds.Object.Nr_CGC_Dev	[ll_Linha + 1]
				ll_Nr_Nf_Prox		= lds.Object.Nr_NF			[ll_Linha + 1]
			Else
				ls_CNPJ_Dev_Prox = ""
				ll_Nr_Nf_Prox = 0
			End If
			
			//Se a pr$$HEX1$$f300$$ENDHEX$$ximo CNPJ Dev e nota forem iguais, ou seja, se tem mais de um produto, adicona a v$$HEX1$$ed00$$ENDHEX$$rgula no final
			If (ls_CNPJ_Dev_Prox = ls_CNPJ_Dev) And (ll_Nr_Nf_Prox = ll_Nr_Nf) Then
				ls_Produtos += "{" + &
									'"CodigoProduto": "' + ls_EAN + '",' + &
									'"QtdeDevolvida": ' + String(ll_Qt_Devolvida) + &
									 "},"
								 
			Else
				
				ls_Produtos += "{" + &
									'"CodigoProduto": "' + ls_EAN + '",' + &
									'"QtdeDevolvida": ' + String(ll_Qt_Devolvida) + &
									 "}"
				
			End If
			
			If (ls_CNPJ_Dev_Prox <> ls_CNPJ_Dev) Or (ll_Nr_Nf_Prox <> ll_Nr_Nf) Then
				
				ldh_Atual = gf_GetServerDate()
								
				ls_Requisicao = String(ldh_Atual, 'YYSSHHMMDD')
				
				ls_Json_Envio = "{" + &
										 '"NsuTransacao": ' + String(ll_Nr_Transacao) + ', ' + &
										 '"Produtos": [' + ls_Produtos + &
										 "]," + &
										 '"CNPJ": ' + ls_CNPJ_Dev + ',' +&
										 '"IdTerminal": "' + gvo_Aplicacao.of_Computername() + '", ' + &
										 '"NsuReq": ' + ls_Requisicao + &
									"}"
									
				If Not io_Comum.of_post( ls_Json_Envio, ls_Interface, Ref as_Json_Retorno, Ref as_Erro ) Then Return False
				
				If Not This.of_Carrega_Dados_Json(as_Json_Retorno, Ref as_Erro) Then Return False
				
				If Not This.of_Grava_Registro_Envio(ls_Tipo, ll_Filial, ll_Nr_NF, ls_Especie, ls_Serie, 0, Ref as_Erro) Then Return False
				
				SqlCa.of_Commit();
				
				ls_Produtos = ""
			End If
		Next
	End If

	Return True
	
Catch (RunTimeError lo_error)
	io_Comum.of_envia_email(lo_error.GetMessage())
	Return False
	
Finally
	If IsValid(lds) Then Destroy(lds)
End Try
end function

public function boolean of_envia_dev_e_canc_old (ref string as_json_retorno, ref string as_erro);DateTime ldh_Atual

Long ll_Linha
Long ll_Linhas
Long ll_Nr_Nf
Long ll_Nr_Nf_Prox = 0
Long ll_Nr_Transacao
Long ll_Qt_Devolvida
Long ll_Filial

String ls_CNPJ_Dev
String ls_CNPJ_Dev_Prox = ""
String ls_Json_Envio
String ls_Interface
String ls_Produtos
String ls_Cd_Caixa
String ls_CNPJ_Venda
String ls_Data_Registro
String ls_EAN
String ls_Requisicao
String ls_Tipo
String ls_Especie
String ls_Serie

Try
	
	dc_uo_ds_base lds
	lds = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject("ds_ge536_lista_notas") Then
		as_Erro = "Erro no change data object da 'ds_ge536_lista_notas'. Fun$$HEX2$$e700e300$$ENDHEX$$o of_envia_dev_e_canc"
		Return False
	End If
	
	ll_Linhas = lds.Retrieve()
	
	If ll_Linhas < 0 Then
		as_Erro = "Erro no retrieve da 'ds_ge536_lista_notas'. Fun$$HEX2$$e700e300$$ENDHEX$$o of_envia_dev_e_canc"
		Return False
	End If
	
	If ll_Linhas > 0 Then
		
		SetNull(as_Json_Retorno)

		ls_Interface = "devolver_produto"
		
		For ll_Linha = 1 To ll_Linhas
			ls_Tipo				= lds.Object.Id_Tipo					[ll_Linha]
			ls_CNPJ_Dev		= lds.Object.Nr_CGC_Dev			[ll_Linha]
			ls_CNPJ_Venda		= lds.Object.Nr_CGC_Venda			[ll_Linha]
			ll_Nr_Nf				= lds.Object.Nr_NF					[ll_Linha]
			ls_Cd_Caixa			= lds.Object.Cd_Caixa				[ll_Linha]
			ll_Nr_Transacao 	= lds.Object.Nr_Nsu_Transacao	[ll_Linha]
			ls_EAN				= lds.Object.De_Codigo_Barras		[ll_Linha]
			ll_Qt_Devolvida		= lds.Object.Qt_Devolvida			[ll_Linha]
			ll_Filial				= lds.Object.Cd_Filial_Venda		[ll_Linha]
			ls_Especie			= lds.Object.De_Especie				[ll_Linha]
			ls_Serie				= lds.Object.De_Serie				[ll_Linha]
			
			If ll_Linha < ll_Linhas	Then
				ls_CNPJ_Dev_Prox	= lds.Object.Nr_CGC_Dev	[ll_Linha + 1]
				ll_Nr_Nf_Prox		= lds.Object.Nr_NF			[ll_Linha + 1]
			Else
				ls_CNPJ_Dev_Prox = ""
				ll_Nr_Nf_Prox = 0
			End If
			
			//Se a pr$$HEX1$$f300$$ENDHEX$$ximo CNPJ Dev e nota forem iguais, ou seja, se tem mais de um produto, adicona a v$$HEX1$$ed00$$ENDHEX$$rgula no final
			If (ls_CNPJ_Dev_Prox = ls_CNPJ_Dev) And (ll_Nr_Nf_Prox = ll_Nr_Nf) Then				
				ls_Produtos += "{" + &
									'"CodigoProduto": "' + ls_EAN + '",' + &
									'"QtdeDevolvida": ' + String(ll_Qt_Devolvida) + &
									 "},"
								 
			Else
				
				ls_Produtos += "{" + &
									'"CodigoProduto": "' + ls_EAN + '",' + &
									'"QtdeDevolvida": ' + String(ll_Qt_Devolvida) + &
									 "}"
				
			End If
			
			If (ls_CNPJ_Dev_Prox <> ls_CNPJ_Dev) Or (ll_Nr_Nf_Prox <> ll_Nr_Nf) Then
				
				ldh_Atual = gf_GetServerDate()
				
				ls_Data_Registro = String(ldh_Atual, 'YYYY-mm-dd"T"HH:mm:ss:fff')
				
				ls_Requisicao = String(ldh_Atual, 'YYSSHHMMDD')
				
				ls_Json_Envio = "{" + &
										 '"NsuTransacao": ' + String(ll_Nr_Transacao) + ', ' + &
										 '"CNPJCupom": ' + ls_CNPJ_Venda + ',' + &
										 '"IdTerminalCupom": "' + ls_Cd_Caixa + '", ' + &
										 '"NumeroCupom":  ' + String(ll_Nr_Nf) + ',' +&
										 '"DataHoraCupom": "' + ls_Data_Registro +'", ' + &
										 '"Produtos": [' + ls_Produtos + &
										 "]," + &
										 '"CNPJ": ' + ls_CNPJ_Dev + ',' +&
										 '"IdTerminal": "' + gvo_Aplicacao.of_Computername() + '", ' + &
										 '"NsuReq": ' + ls_Requisicao + &
									"}"
									
				//If Not io_Comum.of_post( ls_Json_Envio, ls_Interface, Ref as_Json_Retorno, Ref as_Erro ) Then Return False
				
				If Not This.of_Grava_Registro_Envio(ls_Tipo, ll_Filial, ll_Nr_NF, ls_Especie, ls_Serie, 0, Ref as_Erro) Then Return False
				
				SqlCa.of_Commit();
				
				ls_Produtos = ""
			End If
		Next
	End If

	Return True
	
Catch (RunTimeError lo_error)
	io_Comum.of_envia_email(lo_error.GetMessage())
	Return False
	
Finally
	If IsValid(lds) Then Destroy(lds)
End Try
end function

public function boolean of_retorna_projeto (ref string as_projeto, ref string as_erro);SetNull(as_Projeto)

Select nr_projeto
	Into :as_Projeto
From dermaclub_projeto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If Not IsNull(as_Projeto) And as_Projeto <> "" Then
			Return True
		Else
			as_Erro = "Projeto est$$HEX1$$e100$$ENDHEX$$ nulo ou vazio."
		End If
		
	Case 100
		as_Erro = "N$$HEX1$$e300$$ENDHEX$$o localizado o n$$HEX1$$fa00$$ENDHEX$$mero do projeto na dermaclub_projeto. Fun$$HEX2$$e700e300$$ENDHEX$$o of_retorna_projeto."
		
	Case -1
		as_Erro = "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o d projeto na dermaclub_projeto. Fun$$HEX2$$e700e300$$ENDHEX$$o of_retorna_projeto. " + SqlCa.SqlErrText
		
End Choose

Return False
end function

public function boolean of_carrega_dados_json (string as_json_retorno, ref string as_erro);Any la_Data

String ls_Error

Try
	
	ls_Error = io_json.parse(as_Json_Retorno)
	
	//check for parse error
	If ls_error <> "" then
		as_Erro = "Parse error: " + ls_Error
		Return False
	End if
			
	If Not io_json.retrieve("codigoResposta", Ref la_Data) Then
		as_Erro = "Retrieve grupo 'codigoResposta' (null)"
		Return False
	End If
	
	If Not io_Comum.of_Valida_Resposta(String(la_Data), Ref as_Erro) Then Return False
		
	Return True
	
Catch (RunTimeError lo_error)
	as_Erro = lo_error.GetMessage()
	Return False
	
Finally
	
End Try
end function

public function boolean of_grava_registro_envio (string as_tipo, long al_filial, long al_nota, string as_especie, string as_serie, long al_nsu_transacao, ref string as_erro);If as_Tipo = "D" Or as_Tipo = "C" Then
	Update venda_dermaclub
		Set id_devolucao_venda_enviada = 'S',
			  dh_envio_registro = getdate()
	Where cd_filial = :al_Filial
		And nr_nf = :al_Nota
		And de_especie = :as_Especie
		And de_serie = :as_Serie
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		as_Erro = "Erro ao atualizar o registro de envio de informa$$HEX2$$e700e300$$ENDHEX$$o. Fun$$HEX2$$e700e300$$ENDHEX$$o of_grava_registro_envio. " + SqlCa.SqlErrText
		SqlCa.of_Rollback();
		Return False
	End If
	
Else
	
	Update venda_dermaclub
		Set id_enviada = 'S',
			  dh_envio_registro = getdate(),
			  nr_nsu_transacao = :al_NSU_Transacao
	Where cd_filial = :al_Filial
		And nr_nf = :al_Nota
		And de_especie = :as_Especie
		And de_serie = :as_Serie
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		as_Erro = "Erro ao atualizar o registro de envio de informa$$HEX2$$e700e300$$ENDHEX$$o. Fun$$HEX2$$e700e300$$ENDHEX$$o of_grava_registro_envio. " + SqlCa.SqlErrText
		SqlCa.of_Rollback();
		Return False
	End If	
End If

Return True
end function

on uo_ge536_dermaclub_envio_info.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge536_dermaclub_envio_info.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

