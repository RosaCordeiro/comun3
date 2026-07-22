HA$PBExportHeader$uo_ge663_api_pricefy.sru
forward
global type uo_ge663_api_pricefy from nonvisualobject
end type
end forward

global type uo_ge663_api_pricefy from nonvisualobject
end type
global uo_ge663_api_pricefy uo_ge663_api_pricefy

type variables
//String	is_de_url_api_sftp

uo_ge663_json_pricefy io_Json

string	is_url_token,&
			is_body_token,&
			is_url_retorno_api,&
			is_parametro_produto,&
			is_parametro_filial,&
			is_url_compre_ganhe_desconto,&
			is_url_preco_a_partir_de,&
			is_url_preco_fidelidade,&
			is_url_preco_de_por,&
			is_url_preco_regular,&
			is_url_levex_paguey,&
			is_url_desconto_unidadex
			
PRIVATE Long	il_bytes_to_read = 601440




end variables

forward prototypes
public function boolean of_busca_token (ref string as_token, ref string ps_log)
public function boolean of_busca_parametros (ref string as_erro)
public function boolean of_busca_retornos_api (long al_filial, long al_produto, string as_url_promocao, ref string as_retorno_json, ref string ps_log)
public function integer salvarjsonarquivo (string ps_conteudo, string ps_arquivo)
public function boolean of_json_valido (string as_json)
public function boolean of_remover_duplicados (long al_valores[], ref long ll_resultado[])
public function boolean of_extrair_todos_cdproduto (string as_jsons[], ref long as_resultado[])
public function string of_json_extrai_colunas (string as_json, string as_key)
public function integer of_json_grava_colunas (string as_json_string, ref long al_produto[])
public function boolean of_principal (ref long al_lista_produto[])
end prototypes

public function boolean of_busca_token (ref string as_token, ref string ps_log);String	ls_response, ls_Status_Text
Long		ll_Status_Code
Blob		lblob_body
Integer	li_start, li_end

OleObject lo_Xml_Http

Try
	
	// Converter para blob com encoding UTF-8
	lblob_body = Blob(is_body_token, EncodingUTF8!)
	
	lo_Xml_Http = CREATE oleobject		
	lo_Xml_Http.ConnectToNewObject("Msxml2.ServerXMLHTTP.6.0")
	lo_Xml_Http.setTimeouts(90000, 90000, 90000, 90000)
	
	
	lo_Xml_Http.open ("POST", is_url_retorno_api + is_url_token, False)
	lo_Xml_Http.setRequestHeader("Content-Type", "application/json; charset=utf-8")
	
	// Enviar como blob para garantir o encoding correto
	lo_Xml_Http.send(lblob_body)	
	
	ls_Status_Text = lo_Xml_Http.StatusText
	ll_Status_Code = lo_Xml_Http.Status		
	ls_response		= lo_Xml_Http.ResponseText

	If ll_Status_Code >= 400 Or ll_Status_Code = 0 Then
		ps_log = "Erro na autentica$$HEX2$$e700e300$$ENDHEX$$o. C$$HEX1$$f300$$ENDHEX$$digo: " + String(ll_Status_Code) + " Descri$$HEX2$$e700e300$$ENDHEX$$o: " + ls_Status_Text + "~r~nResposta: " + ls_response
		as_token = ""
	Else
		li_start = Pos(ls_response, '"accessToken":"')
		If li_start > 0 Then
			li_start = li_start + 15 // Tamanho de '"accessToken":"'
			li_end = Pos(ls_response, '"', li_start)
			If li_end > li_start Then
				as_token = Mid(ls_response, li_start, li_end - li_start)
			Else
				ps_log = "Formato de resposta inv$$HEX1$$e100$$ENDHEX$$lido - token n$$HEX1$$e300$$ENDHEX$$o encontrado"
				as_token = ""
			End If
		End If
	End If
	
	lo_Xml_Http.DisconnectObject()
	destroy lo_Xml_Http
	
Catch (RuntimeError lo_rte)
	ps_log = "Erro na autentica$$HEX2$$e700e300$$ENDHEX$$o: " + lo_rte.GetMessage()
	as_token = ""
	If IsValid(lo_Xml_Http) Then
		lo_Xml_Http.DisconnectObject()
		destroy lo_Xml_Http
	End If
End Try

Return True
end function

public function boolean of_busca_parametros (ref string as_erro);/*SELECT * from parametro_geral where cd_parametro in 
('URL_TOKEN',
'BODY__TOKEN',
'URL_RETORNO_API',
'PARAMETRO_PRODUTO',
'PARAMETRO_FILIAL') */

select vl_parametro
Into	:is_url_token
	from parametro_geral 
	where cd_parametro ='URL_TOKEN'
Using SqlCa;

Choose Case SqlCa.Sqlcode
	Case 100
		as_erro = "N$$HEX1$$e300$$ENDHEX$$o foi localizado o parametro 'URL_TOKEN' na tabela parametro_geral "
		Return False
	Case -1
		as_erro = "Localiza$$HEX2$$e700e300$$ENDHEX$$o parametro 'URL_TOKEN' na tabela parametro_geral " + SqlCa.SqlErrText
		Return False
End Choose

select vl_parametro
Into	:is_body_token
	from parametro_geral 
	where cd_parametro ='BODY__TOKEN'
Using SqlCa;


Choose Case SqlCa.Sqlcode
	Case 100
		as_erro = "N$$HEX1$$e300$$ENDHEX$$o foi localizado o parametro 'BODY__TOKEN' na tabela parametro_geral "
		Return False
	Case -1
		as_erro = "Localiza$$HEX2$$e700e300$$ENDHEX$$o parametro 'BODY__TOKEN' na tabela parametro_geral " + SqlCa.SqlErrText
		Return False
End Choose


select vl_parametro
Into	:is_url_retorno_api
	from parametro_geral 
	where cd_parametro ='URL_RETORNO_API'
Using SqlCa;


Choose Case SqlCa.Sqlcode
	Case 100
		as_erro = "N$$HEX1$$e300$$ENDHEX$$o foi localizado o parametro 'URL_RETORNO_API' na tabela parametro_geral "
		Return False
	Case -1
		as_erro = "Localiza$$HEX2$$e700e300$$ENDHEX$$o parametro 'URL_RETORNO_API' na tabela parametro_geral " + SqlCa.SqlErrText
		Return False
End Choose


select vl_parametro
Into	:is_parametro_produto
	from parametro_geral 
	where cd_parametro ='PARAMETRO_PRODUTO'
Using SqlCa;


Choose Case SqlCa.Sqlcode
	Case 100
		as_erro = "N$$HEX1$$e300$$ENDHEX$$o foi localizado o parametro 'PARAMETRO_PRODUTO' na tabela parametro_geral "
		Return False
	Case -1
		as_erro = "Localiza$$HEX2$$e700e300$$ENDHEX$$o parametro 'PARAMETRO_PRODUTO' na tabela parametro_geral " + SqlCa.SqlErrText
		Return False
End Choose


select vl_parametro
Into	:is_parametro_filial
	from parametro_geral 
	where cd_parametro ='PARAMETRO_FILIAL'
Using SqlCa;


Choose Case SqlCa.Sqlcode
	Case 100
		as_erro = "N$$HEX1$$e300$$ENDHEX$$o foi localizado o parametro 'PARAMETRO_FILIAL' na tabela parametro_geral "
		Return False
	Case -1
		as_erro = "Localiza$$HEX2$$e700e300$$ENDHEX$$o parametro 'PARAMETRO_FILIAL' na tabela parametro_geral " + SqlCa.SqlErrText
		Return False
End Choose

select vl_parametro
Into	:is_url_compre_ganhe_desconto
	from parametro_geral 
	where cd_parametro ='URL_COMPRE_GANHE_DESCONTO'
Using SqlCa;


Choose Case SqlCa.Sqlcode
	Case 100
		as_erro = "N$$HEX1$$e300$$ENDHEX$$o foi localizado o parametro 'URL_COMPRE_GANHE_DESCONTO' na tabela parametro_geral "
		Return False
	Case -1
		as_erro = "Localiza$$HEX2$$e700e300$$ENDHEX$$o parametro 'URL_COMPRE_GANHE_DESCONTO' na tabela parametro_geral " + SqlCa.SqlErrText
		Return False
End Choose

select vl_parametro
Into	:is_url_preco_a_partir_de
	from parametro_geral 
	where cd_parametro ='URL_PRECO_A_PARTIR_DE'
Using SqlCa;

Choose Case SqlCa.Sqlcode
	Case 100
		as_erro = "N$$HEX1$$e300$$ENDHEX$$o foi localizado o parametro 'URL_PRECO_A_PARTIR_DE' na tabela parametro_geral "
		Return False
	Case -1
		as_erro = "Localiza$$HEX2$$e700e300$$ENDHEX$$o parametro 'URL_PRECO_A_PARTIR_DE' na tabela parametro_geral " + SqlCa.SqlErrText
		Return False
End Choose

select vl_parametro
Into	:is_url_preco_fidelidade
	from parametro_geral 
	where cd_parametro ='URL_PRECO_FIDELIDADE'
Using SqlCa;


Choose Case SqlCa.Sqlcode
	Case 100
		as_erro = "N$$HEX1$$e300$$ENDHEX$$o foi localizado o parametro 'URL_PRECO_FIDELIDADE' na tabela parametro_geral "
		Return False
	Case -1
		as_erro = "Localiza$$HEX2$$e700e300$$ENDHEX$$o parametro 'URL_PRECO_FIDELIDADE' na tabela parametro_geral " + SqlCa.SqlErrText
		Return False
End Choose

select vl_parametro
Into	:is_url_preco_de_por
	from parametro_geral 
	where cd_parametro ='URL_PRECO_DE_POR'
Using SqlCa;


Choose Case SqlCa.Sqlcode
	Case 100
		as_erro = "N$$HEX1$$e300$$ENDHEX$$o foi localizado o parametro 'URL_PRECO_DE_POR' na tabela parametro_geral "
		Return False
	Case -1
		as_erro = "Localiza$$HEX2$$e700e300$$ENDHEX$$o parametro 'URL_PRECO_DE_POR' na tabela parametro_geral " + SqlCa.SqlErrText
		Return False
End Choose

select vl_parametro
Into	:is_url_preco_regular
	from parametro_geral 
	where cd_parametro ='URL_PRECO_REGULAR'
Using SqlCa;


Choose Case SqlCa.Sqlcode
	Case 100
		as_erro = "N$$HEX1$$e300$$ENDHEX$$o foi localizado o parametro 'URL_PRECO_REGULAR' na tabela parametro_geral "
		Return False
	Case -1
		as_erro = "Localiza$$HEX2$$e700e300$$ENDHEX$$o parametro 'URL_PRECO_REGULAR' na tabela parametro_geral " + SqlCa.SqlErrText
		Return False
End Choose

select vl_parametro
Into	:is_url_levex_paguey
	from parametro_geral 
	where cd_parametro ='URL_LEVEX_PAGUEY'
Using SqlCa;


Choose Case SqlCa.Sqlcode
	Case 100
		as_erro = "N$$HEX1$$e300$$ENDHEX$$o foi localizado o parametro 'URL_LEVEX_PAGUEY' na tabela parametro_geral "
		Return False
	Case -1
		as_erro = "Localiza$$HEX2$$e700e300$$ENDHEX$$o parametro 'URL_LEVEX_PAGUEY' na tabela parametro_geral " + SqlCa.SqlErrText
		Return False
End Choose

select vl_parametro
Into	:is_url_desconto_unidadex
	from parametro_geral 
	where cd_parametro ='URL_DESCONTO_UNIDADEX'
Using SqlCa;

Choose Case SqlCa.Sqlcode
	Case 100
		as_erro = "N$$HEX1$$e300$$ENDHEX$$o foi localizado o parametro 'URL_DESCONTO_UNIDADEX' na tabela parametro_geral "
		Return False
	Case -1
		as_erro = "Localiza$$HEX2$$e700e300$$ENDHEX$$o parametro 'URL_DESCONTO_UNIDADEX' na tabela parametro_geral " + SqlCa.SqlErrText
		Return False
End Choose

Return true
end function

public function boolean of_busca_retornos_api (long al_filial, long al_produto, string as_url_promocao, ref string as_retorno_json, ref string ps_log);Blob          lblob_file
Integer       li_FileNum, li_arq
Long          ll_Status_Code, ll_ret
String        ls_file, ls_boundary, ls_formdata, ls_Status_Text, ls_content_type, ls_guid, ls_MimeType, ls_retorno_api
String        ls_token, ls_url, ls_parametro_filial,ls_parametro_produto,ls_response
Boolean       lb_Sucesso = True
OleObject     lo_Xml_Http

//ps_filename = 'TestePricefy'
//ps_local_download = 'U:\Chamados\Pricefy'

of_busca_token(ref ls_token,ref ps_log)

If al_produto > 0 Then
	ls_url = is_url_retorno_api + as_url_promocao +is_parametro_filial + string(al_filial) +"&"+ string(is_parametro_produto) + string(al_produto)
Else
	ls_url = is_url_retorno_api + as_url_promocao +is_parametro_filial + string(al_filial)
End if

Try
    lo_Xml_Http = CREATE oleobject        
    lo_Xml_Http.ConnectToNewObject("Msxml2.ServerXMLHTTP.6.0")
    
    lo_Xml_Http.setTimeouts(90000, 90000, 90000, 90000)
    
    lo_Xml_Http.open ("GET", ls_url, False)
    
    // headers
	 lo_Xml_Http.setRequestHeader("Content-Type", "application/json")
    lo_Xml_Http.setRequestHeader("Authorization", "Bearer " + ls_token)
    
    lo_Xml_Http.send()    

    ls_Status_Text	= lo_Xml_Http.StatusText
    ll_Status_Code	= lo_Xml_Http.Status
    ls_response		= lo_Xml_Http.ResponseText
	 
	 
	 //verificar as tratativas do json e retornar na string abaixo o correto
	 
	 as_retorno_json = ls_response
	 
    If ll_Status_Code >= 300 Or ll_Status_Code = 0 Then
        ps_log   = "Erro no retorno do Web Service. C$$HEX1$$f300$$ENDHEX$$digo do erro: " + String(ll_Status_Code) + " Descri$$HEX2$$e700e300$$ENDHEX$$o do erro: " + ls_Status_Text
        lb_Sucesso =    False
        Return False
//    Else
//        lblob_file = Blob(lo_Xml_Http.ResponseBody)
//        ls_retorno_api = String(lblob_file) // Converter blob para string para ver a resposta
//        
//		  //De inicio validar com arquivo salvo
//        if trim(ps_local_download) <> '' and not IsNull(ps_local_download) then
//            If FileExists (ps_local_download) Then
//                FileDelete (ps_local_download)
//            End If
//    
//            li_FileNum = FileOpen(ps_local_download, StreamMode!, Write!, LockWrite!, Replace!, EncodingAnsi!)    
//            If li_FileNum = -1 Then
//                ps_log = "Erro ao abrir o arquivo " + ps_local_download
//                Return False
//            End If
//            
//            ll_ret = FileWriteEx(li_FileNum, lblob_file)
//        
//            If IsNull(ll_ret) or ll_ret <= 0 Then
//                ps_log = "Erro ao salvar o arquivo " + ps_filename
//                FileClose(li_FileNum)
//                lb_Sucesso =    False
//                Return False
//            End If
//            
//            FileClose(li_FileNum)
//        end if
//        
//        ps_log = "Sucesso: " + ls_retorno_api
    End If

Catch (RuntimeError lo_rte2)
    ps_log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o. Erro: " + lo_rte2.GetMessage()
    
    if IsValid(lo_Xml_Http) then
        lo_Xml_Http.DisconnectObject()
        Destroy(lo_Xml_Http)
    End if
    
    Return False
    
Finally
    if IsValid(lo_Xml_Http) then
        lo_Xml_Http.DisconnectObject()
        Destroy(lo_Xml_Http)
    End if
    
    GarbageCollect()
    
    If lb_Sucesso Then
        Return True
    End If
    
End Try
end function

public function integer salvarjsonarquivo (string ps_conteudo, string ps_arquivo); int li_arquivo
    
    // Abre arquivo para escrita (sobrescreve se existir)
    li_arquivo = FileOpen(ps_arquivo, StreamMode!, Write!, LockWrite!, Replace!)
    
    if li_arquivo = -1 then
        MessageBox("Erro", "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel criar o arquivo: " + ps_arquivo)
        return -1
    end if
    
    // Escreve conte$$HEX1$$fa00$$ENDHEX$$do e fecha arquivo
    FileWrite(li_arquivo, ps_conteudo)
    FileClose(li_arquivo)
    
    return 1
end function

public function boolean of_json_valido (string as_json);IF Trim(as_json) = "" THEN RETURN False
IF Trim(as_json) = "[]" THEN RETURN False
IF Trim(as_json) = "{}" THEN RETURN False


RETURN True
end function

public function boolean of_remover_duplicados (long al_valores[], ref long ll_resultado[]);
    Long ll_valor
    Integer i, j
    Boolean lb_existe
    
    
    FOR i = 1 TO UpperBound(al_valores)
        ll_valor = al_valores[i]
        lb_existe = False
        
        FOR j = 1 TO UpperBound(ll_resultado)
            IF ll_resultado[j] = ll_valor THEN
                lb_existe = True
                EXIT
            END IF
        NEXT
        
        IF NOT lb_existe THEN
            ll_resultado[UpperBound(ll_resultado) + 1] = ll_valor
        END IF
    NEXT
    
    RETURN true
end function

public function boolean of_extrair_todos_cdproduto (string as_jsons[], ref long as_resultado[]);
    Long ll_temp[]
    Integer i, j
    Any la_data
    String ls_error
    
//    ll_resultado = []
    
    FOR i = 1 TO UpperBound(as_jsons)
        IF Trim(as_jsons[i]) <> "" THEN
            ls_error = io_Json.parse(as_jsons[i])
            
            IF ls_error = "" THEN
                // Tenta como array
                j = 1
                DO WHILE io_Json.retrieve("cdProduto[" + String(j) + "]", Ref la_data)
                    as_resultado[UpperBound(as_resultado) + 1] = Long(la_data)
                    j++
                LOOP
                
                // Se n$$HEX1$$e300$$ENDHEX$$o encontrou array, tenta valor $$HEX1$$fa00$$ENDHEX$$nico
                IF j = 1 AND io_Json.retrieve("cdProduto", Ref la_data) THEN
                    as_resultado[UpperBound(as_resultado) + 1] = Long(la_data)
                END IF
            END IF
        END IF
    NEXT
    
    RETURN true
end function

public function string of_json_extrai_colunas (string as_json, string as_key);// Fun$$HEX2$$e700e300$$ENDHEX$$o: uf_extract_json_value
// Par$$HEX1$$e200$$ENDHEX$$metros:
//   as_json - String JSON
//   as_key - Chave a ser extra$$HEX1$$ed00$$ENDHEX$$da
// Retorno: String com o valor

String ls_result, ls_temp
Integer li_start, li_end, li_length

// Encontra a posi$$HEX2$$e700e300$$ENDHEX$$o da chave
li_start = Pos(as_json, '~"' + as_key + '~":')
IF li_start = 0 THEN RETURN ""

// Encontra o in$$HEX1$$ed00$$ENDHEX$$cio do valor
li_start = Pos(as_json, ":", li_start) + 1
IF li_start = 0 THEN RETURN ""

// Remove espa$$HEX1$$e700$$ENDHEX$$os iniciais
DO WHILE Mid(as_json, li_start, 1) = " "
    li_start ++
LOOP

// Verifica o tipo do valor
CHOOSE CASE Mid(as_json, li_start, 1)
    CASE '"' // String
        li_start ++
        li_end = Pos(as_json, '"', li_start)
        IF li_end = 0 THEN RETURN ""
        ls_result = Mid(as_json, li_start, li_end - li_start)
        
    CASE '[' // Array
        li_end = Pos(as_json, "]", li_start)
        IF li_end = 0 THEN RETURN ""
        ls_result = Mid(as_json, li_start, li_end - li_start + 1)
        
    CASE '{' // Object
        li_end = Pos(as_json, "}", li_start)
        IF li_end = 0 THEN RETURN ""
        ls_result = Mid(as_json, li_start, li_end - li_start + 1)
        
    CASE ELSE // Number, boolean ou null
        li_end = Pos(as_json, ",", li_start)
        IF li_end = 0 THEN
            li_end = Pos(as_json, "}", li_start)
            IF li_end = 0 THEN RETURN ""
        END IF
        ls_result = Trim(Mid(as_json, li_start, li_end - li_start))
END CHOOSE

RETURN ls_result
end function

public function integer of_json_grava_colunas (string as_json_string, ref long al_produto[]);// Fun$$HEX2$$e700e300$$ENDHEX$$o: uf_populate_dw_from_json
// Par$$HEX1$$e200$$ENDHEX$$metros:
//   adv_target - DataWindow alvo
//   as_json_string - String contendo o array JSON
// Retorno: Integer (1=Sucesso, -1=Erro)

Integer li_i, li_pos, li_start, li_end, li_length,li_count
Long ll_row
String ls_json, ls_item, ls_key, ls_value, ls_temp
String ls_gtin, ls_cdProduto, ls_cdFilial, ls_exibeFraseInformativa
String ls_dtVigenciaInicial, ls_dtVigenciaFinal, ls_cdPrecoGrupo
String ls_cdPromocao, ls_vlPrecoUnitario, ls_qtCompre
String ls_cdProdutoDesconto, ls_gtinProdutoDesconto, ls_deResumidaProdutoDesconto
String ls_deApresentacaoVendaProdutoDesconto, ls_pcDesconto, ls_qtProdutoDesconto
String ls_exibeFraseInformativaProdutoDesconto, ls_deFraseInformativaProdutoDesconto

// Remove espa$$HEX1$$e700$$ENDHEX$$os e quebras de linha
ls_json = Trim(as_json_string)
ls_json = gf_replace(ls_json, "~r~n", "", 0)
ls_json = gf_replace(ls_json, "~t", "", 0)

// Verifica se $$HEX1$$e900$$ENDHEX$$ um array JSON
IF Left(ls_json, 1) <> "[" OR Right(ls_json, 1) <> "]" THEN
    RETURN -1
END IF

// Remove os colchetes externos
ls_json = Mid(ls_json, 2, Len(ls_json) - 2)

// Limpa a DataWindow
//adv_target.Reset()

li_i = 1
li_start = 1

li_count = Upperbound(al_produto)

// Processa cada objeto do array
DO WHILE li_start > 0
    // Encontra o pr$$HEX1$$f300$$ENDHEX$$ximo objeto
    li_start = Pos(ls_json, "{", li_start)
    IF li_start = 0 THEN EXIT
    
    li_end = Pos(ls_json, "}", li_start)
    IF li_end = 0 THEN EXIT
    
    // Extrai o objeto JSON
    ls_item = Mid(ls_json, li_start, li_end - li_start + 1)
    
    // Insere nova linha na DataWindow
    //ll_row = adv_target.InsertRow(0)
    
    // Parse manual dos campos do JSON
    ls_gtin = of_json_extrai_colunas(ls_item, "gtin")
    ls_cdProduto = of_json_extrai_colunas(ls_item, "cdProduto")
    ls_cdFilial = of_json_extrai_colunas(ls_item, "cdFilial")
    ls_exibeFraseInformativa = of_json_extrai_colunas(ls_item, "exibeFraseInformativa")
    ls_dtVigenciaInicial = of_json_extrai_colunas(ls_item, "dtVigenciaInicial")
    ls_dtVigenciaFinal = of_json_extrai_colunas(ls_item, "dtVigenciaFinal")
    ls_cdPrecoGrupo = of_json_extrai_colunas(ls_item, "cdPrecoGrupo")
    ls_cdPromocao = of_json_extrai_colunas(ls_item, "cdPromocao")
    ls_vlPrecoUnitario = of_json_extrai_colunas(ls_item, "vlPrecoUnitario")
    ls_qtCompre = of_json_extrai_colunas(ls_item, "qtCompre")
    ls_cdProdutoDesconto = of_json_extrai_colunas(ls_item, "cdProdutoDesconto")
    ls_gtinProdutoDesconto = of_json_extrai_colunas(ls_item, "gtinProdutoDesconto")
    ls_deResumidaProdutoDesconto = of_json_extrai_colunas(ls_item, "deResumidaProdutoDesconto")
    ls_deApresentacaoVendaProdutoDesconto = of_json_extrai_colunas(ls_item, "deApresentacaoVendaProdutoDesconto")
    ls_pcDesconto = of_json_extrai_colunas(ls_item, "pcDesconto")
    ls_qtProdutoDesconto = of_json_extrai_colunas(ls_item, "qtProdutoDesconto")
    ls_exibeFraseInformativaProdutoDesconto = of_json_extrai_colunas(ls_item, "exibeFraseInformativaProdutoDesconto")
    ls_deFraseInformativaProdutoDesconto = of_json_extrai_colunas(ls_item, "deFraseInformativaProdutoDesconto")
    
	     // Adiciona o c$$HEX1$$f300$$ENDHEX$$digo do produto $$HEX1$$e000$$ENDHEX$$ lista
//    IF ls_cdProduto <> "" THEN
//        IF as_produto = "" THEN
//            as_produto = ls_cdProduto
//        ELSE
//            as_produto = as_produto + "," + ls_cdProduto
//        END IF
//    END IF

	IF ls_cdProduto <> "" THEN
	  li_count++
	  al_produto[li_count] = Long(ls_cdProduto)
	END IF

    // Preenche a DataWindow
    /*adv_target.SetItem(ll_row, "gtin", ls_gtin)
    adv_target.SetItem(ll_row, "cdproduto", ls_cdProduto)
    adv_target.SetItem(ll_row, "cdfilial", Integer(ls_cdFilial))
    adv_target.SetItem(ll_row, "exibefraseinformativa", (Lower(ls_exibeFraseInformativa) = "true"))
    adv_target.SetItem(ll_row, "dtvigenciainicial", Date(ls_dtVigenciaInicial))
    adv_target.SetItem(ll_row, "dtvigenciainicial", Date(ls_dtVigenciaFinal))
    adv_target.SetItem(ll_row, "cdprecogrupo", ls_cdPrecoGrupo)
    adv_target.SetItem(ll_row, "cdpromocao", Long(ls_cdPromocao))
    adv_target.SetItem(ll_row, "vlprecounitario", Double(ls_vlPrecoUnitario))
    adv_target.SetItem(ll_row, "qtcompre", Integer(ls_qtCompre))
    adv_target.SetItem(ll_row, "cdprodutodesconto", ls_cdProdutoDesconto)
    adv_target.SetItem(ll_row, "gtinprodutodesconto", ls_gtinProdutoDesconto)
    adv_target.SetItem(ll_row, "deresumidaprodutodesconto", ls_deResumidaProdutoDesconto)
    adv_target.SetItem(ll_row, "deapresentacaovendaprodutodesconto", ls_deApresentacaoVendaProdutoDesconto)
    adv_target.SetItem(ll_row, "pcdesconto", Double(ls_pcDesconto))
    adv_target.SetItem(ll_row, "qtprodutodesconto", Integer(ls_qtProdutoDesconto))
    adv_target.SetItem(ll_row, "exibefraseinformativaprodutodesconto", (Lower(ls_exibeFraseInformativaProdutoDesconto) = "true"))
    adv_target.SetItem(ll_row, "defraseinformativaprodutodesconto", ls_deFraseInformativaProdutoDesconto)*/
    
    li_start = li_end + 1
    li_i ++
LOOP

RETURN 1
end function

public function boolean of_principal (ref long al_lista_produto[]);String ls_json_compre_ganhe_desconto
String ls_json_preco_a_partir_de
String ls_json_preco_fidelidade
String ls_json_preco_de_por
String ls_json_preco_regular
String ls_json_levex_paguey
String ls_json_desconto_unidadex
String ps_log, ls_Error
String ls_caminho = "U:\json\"

//Long ls_lista_produto []

Any 	la_item
Any	la_Data

Long	ll_produtos[]
Long	ll_filial 
Long	ll_produto
Long	ll_unicos[]
Long	ll_valor

String	lsa_todos_jsons[7]
String	lsa_jsons[]

Integer	li_count = 0
Integer	i
Integer li_count2 

Boolean lb_existe


ll_filial = 611
// ll_produto = 734343

// Instancia objeto JSON
io_Json = Create uo_ge663_json_pricefy

// --- Chama APIs e popula os JSONs ---
of_busca_retornos_api(ll_filial,ll_produto,is_url_compre_ganhe_desconto, ref ls_json_compre_ganhe_desconto, ref ps_log)
of_busca_retornos_api(ll_filial,ll_produto,is_url_preco_a_partir_de,     ref ls_json_preco_a_partir_de,     ref ps_log)
of_busca_retornos_api(ll_filial,ll_produto,is_url_preco_fidelidade,     ref ls_json_preco_fidelidade,      ref ps_log)
of_busca_retornos_api(ll_filial,ll_produto,is_url_preco_de_por,         ref ls_json_preco_de_por,          ref ps_log)
of_busca_retornos_api(ll_filial,ll_produto,is_url_preco_regular,        ref ls_json_preco_regular,         ref ps_log)
of_busca_retornos_api(ll_filial,ll_produto,is_url_levex_paguey,         ref ls_json_levex_paguey,          ref ps_log)
of_busca_retornos_api(ll_filial,ll_produto,is_url_desconto_unidadex,    ref ls_json_desconto_unidadex,     ref ps_log)

// --- lista de JSONs filtrados ---
lsa_todos_jsons[1] = ls_json_compre_ganhe_desconto
lsa_todos_jsons[2] = ls_json_preco_a_partir_de
lsa_todos_jsons[3] = ls_json_preco_fidelidade
lsa_todos_jsons[4] = ls_json_preco_de_por
lsa_todos_jsons[5] = ls_json_preco_regular
lsa_todos_jsons[6] = ls_json_levex_paguey
lsa_todos_jsons[7] = ls_json_desconto_unidadex

// Filtra apenas os JSONs v$$HEX1$$e100$$ENDHEX$$lidos

FOR i = 1 TO 7
    IF of_json_valido(lsa_todos_jsons[i]) THEN
        li_count++
        lsa_jsons[li_count] = lsa_todos_jsons[i]
    END IF
NEXT

For li_count2 = 1 TO Upperbound(lsa_jsons)
	
	of_json_grava_colunas(lsa_jsons[li_count2],ref al_lista_produto[])
	
Next

//IF NOT DirectoryExists(ls_caminho) THEN
//    CreateDirectory(ls_caminho)
//END IF

//SalvarJsonArquivo(ls_json_compre_ganhe_desconto, ls_caminho + "ls_json_compre_ganhe_desconto.txt")
//SalvarJsonArquivo(ls_json_preco_a_partir_de,     ls_caminho + "ls_json_preco_a_partir_de.txt")
//SalvarJsonArquivo(ls_json_preco_fidelidade,      ls_caminho + "ls_json_preco_fidelidade.txt")
//SalvarJsonArquivo(ls_json_preco_de_por,          ls_caminho + "ls_json_preco_de_por.txt")
//SalvarJsonArquivo(ls_json_preco_regular,         ls_caminho + "ls_json_preco_regular.txt")
//SalvarJsonArquivo(ls_json_levex_paguey,          ls_caminho + "ls_json_levex_paguey.txt")
//SalvarJsonArquivo(ls_json_desconto_unidadex,     ls_caminho + "ls_json_desconto_unidadex.txt")

IF IsValid(io_Json) THEN Destroy(io_Json)

RETURN True
end function

on uo_ge663_api_pricefy.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge663_api_pricefy.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;//Busca o registro da API para envios SFTP
//busca parametros
String as_erro
of_busca_parametros(as_erro)

//as_erro messagebox
end event

