HA$PBExportHeader$uo_ge536_dermaclub_carga.sru
forward
global type uo_ge536_dermaclub_carga from nonvisualobject
end type
end forward

global type uo_ge536_dermaclub_carga from nonvisualobject
end type
global uo_ge536_dermaclub_carga uo_ge536_dermaclub_carga

type variables
uo_ge536_dermaclub_comum io_Comum
uo_ge040_json io_Json

str_ge536_projeto st_projeto
str_ge536_campanha st_campanha
str_ge536_produto st_produto
str_ge536_uf st_uf
str_ge536_quantidades st_qtd
str_ge536_kit st_kit

dc_uo_transacao iuo_SqlCa_log

dc_uo_ds_base ids_EAN

Any ia_Null

Boolean ib_Proce_Campanha = False

Decimal idc_Vl_Desconto
Decimal idc_Vl_Desc_Prog

Long il_Nr_Atua_Transacao
Long il_Tipo_Log = 0 //1 - Cabe$$HEX1$$e700$$ENDHEX$$alho, 2 - Produto, 3 - Desconto Progressivo
Long il_Qt_Produto
Long il_Tabela = 1 //1 - Receber Informa$$HEX2$$e700e300$$ENDHEX$$o, 2 - Carga PBM, 3 - Enviar Informa$$HEX2$$e700e300$$ENDHEX$$o
Long il_Campanha

String is_Codigo_Barras
String is_De_Produto
String is_Tipo_Operador
String is_UF
String is_Canal_Venda
end variables

forward prototypes
public function boolean of_carrega_dados_json (string as_json_retorno, ref string as_erro)
public function boolean of_processa_carga_produto ()
public function boolean of_carrega_projeto (any aa_projeto[], ref string as_erro)
public function boolean of_carrega_uf (any aa_uf[], string as_caminho, ref string as_erro)
public function boolean of_carrega_campanha (any aa_campanha[], string as_caminho, ref string as_erro)
public function boolean of_carrega_produto (any aa_produto[], string as_caminho, ref string as_erro)
public function boolean of_grava_projeto (ref string as_erro)
public function boolean of_grava_campanha (ref string as_erro)
public function boolean of_grava_produto (ref string as_erro)
public function boolean of_processa_atualizacao_carga (ref string as_erro)
public function boolean of_atualiza_sequencial_consulta (ref string as_erro)
public function boolean of_grava_desconto_progressivo (ref string as_erro)
public subroutine of_limpa_estrutura ()
public function boolean of_carrega_kit (any aa_kit[], string as_caminho, ref string as_erro)
public function boolean of_grava_kit_produto (ref string as_erro)
public function boolean of_abre_conexao (ref string as_erro)
public function boolean of_fecha_conexao ()
public function boolean of_atualiza_tabela_log (long al_tabela, string as_status, string as_uf, long al_campanha, ref string as_erro)
public function boolean of_deleta_registros (ref string as_erro)
public function boolean of_retorna_sequencial_log (datetime adh_inicio, datetime adh_termino, string as_uf, long al_campanha, ref string as_erro)
public function boolean of_processa_carga_pbm (ref string as_erro)
public function boolean of_deleta_registros_pbm (ref string as_erro)
public function boolean of_grava_pbm_produto (ref string as_erro)
public function boolean of_grava_pbm_produto_progressivo (ref string as_erro)
public function boolean of_atualiza_tabela_log_produto (string as_codigo_barras, string as_de_produto, decimal adc_desconto, string as_mensagem_produto, ref string as_erro)
public function boolean of_atualiza_tabela_log_desc_progressivo (string as_codigo_barras, long al_qt_produto, string as_de_operador, decimal adc_desconto, string as_mensagem_produto, ref string as_erro)
public function boolean of_carrega_quantidades (any aa_quantidade[], string as_caminho, string as_codigo_produto, string as_msg_produto, ref string as_erro)
public function boolean of_autenticacao (ref string as_json_retorno, ref string as_erro)
public function boolean of_localiza_produto (ref string as_mensagem, ref string as_erro)
public function boolean of_carrega_canal_venda (any aa_canais[], string as_caminho, ref string as_erro)
end prototypes

public function boolean of_carrega_dados_json (string as_json_retorno, ref string as_erro);Any la_Data

String ls_Error

Try
	
	SetNull(ia_Null)

	ls_Error = io_json.parse(as_Json_Retorno)
	
	//check for parse error
	If ls_error <> "" then
		as_Erro = "Parse error: " + ls_Error
		Return False
	End if
	
	//In$$HEX1$$ed00$$ENDHEX$$cio
	If Not io_json.retrieve("nsuHost", Ref la_Data) Then
		as_Erro = "Retrieve grupo 'nsuHost' (null)"
		Return False
	End If
	
	la_Data = ia_Null
	
	If Not io_json.retrieve("codigoResposta", Ref la_Data) Then
		as_Erro = "Retrieve grupo 'codigoResposta' (null)"
		Return False
	End If
	
	If Not io_Comum.of_Valida_Resposta(String(la_Data), Ref as_Erro) Then Return False
	
	la_Data = ia_Null
	
	If Not io_json.retrieve("projetos", Ref la_Data) Then
		as_Erro = "Retrieve grupo 'projetos' (null)"
		Return False
	End If
	
	If Not This.of_Carrega_Projeto(la_Data, Ref as_Erro) Then Return False
	
	Return True
	
Catch (RunTimeError lo_error)
	as_Erro = lo_error.GetMessage()
	Return False
	
Finally
	
End Try
end function

public function boolean of_processa_carga_produto ();String ls_Json_Retorno
String ls_Erro

Try
	
	io_Comum = Create uo_ge536_dermaclub_comum
	io_Json = Create uo_ge040_json
	ids_EAN = Create dc_uo_ds_base
	
	// Carrega Informa$$HEX2$$e700e300$$ENDHEX$$o URL
	If Not io_Comum.of_busca_url("ENTRAR", Ref io_Comum.is_Url, Ref ls_Erro ) Then
		This.of_Atualiza_Tabela_Log( 1, "-1", "", 0, Ref ls_erro)
		io_Comum.of_envia_email(ls_Erro)				
		Return False
	End If
	
	If Not io_Comum.of_Gera_Token(Ref ls_Erro) Then
		This.of_Atualiza_Tabela_Log( 1, "-1", "", 0, Ref ls_erro)
		io_Comum.of_envia_email(ls_Erro)		
		Return False
	End If
	
	If Not This.of_Autenticacao(Ref ls_Json_Retorno, Ref ls_Erro) Then
		This.of_Atualiza_Tabela_Log( 1, "-1", "", 0, Ref ls_erro)
		io_Comum.of_envia_email(ls_Erro)			
		Return False
	End If
	
	If Not ids_EAN.of_ChangeDataObject("ds_ge536_lista_ean_perfumaria") Then
		This.of_Atualiza_Tabela_Log( 1, "-1", "", 0, Ref ls_erro)
		io_Comum.of_envia_email("Erro no ChangeDataObject da ds_ge536_lista_ean_perfumaria. Fun$$HEX2$$e700e300$$ENDHEX$$o of_processa_carga_produto. " + ls_Erro)		
		Return False
	End If
	
	If ids_Ean.Retrieve() < 0 Then
		This.of_Atualiza_Tabela_Log( 1, "-1", "", 0, Ref ls_erro)
		io_Comum.of_envia_email("Erro no Retrieve da ds_ge536_lista_ean_perfumaria. Fun$$HEX2$$e700e300$$ENDHEX$$o of_processa_carga_produto. " + ls_Erro)		
		Return False
	End If
	
	//Carrega os valores do json e atribui para as estruturas
	If Not This.of_Carrega_Dados_Json(ls_Json_Retorno, Ref ls_Erro) Then
		This.of_Atualiza_Tabela_Log( 1, "-1", is_UF, il_Campanha, Ref ls_erro)
		io_Comum.of_envia_email(ls_Erro)
		
		//Se deu log no cabe$$HEX1$$e700$$ENDHEX$$alho, retorna False para n$$HEX1$$e300$$ENDHEX$$o continuar para o log de produto e para n$$HEX1$$e300$$ENDHEX$$o executar a carga PBM
		If il_Tipo_Log = 0 Or il_Tipo_Log = 1 Then Return False
				
		If il_Tipo_Log = 2 Then
			This.of_Atualiza_Tabela_Log_Produto(is_Codigo_Barras, is_De_Produto, idc_Vl_Desconto, "", Ref ls_erro)
			io_Comum.of_envia_email(ls_Erro)
			Return False
		End If
		
		If il_Tipo_Log = 3 Then
			This.of_Atualiza_Tabela_Log_Desc_Progressivo(is_Codigo_Barras, il_Qt_Produto, is_Tipo_Operador, idc_Vl_Desc_Prog, "", Ref ls_erro)
			io_Comum.of_envia_email(ls_Erro)
			Return False
		End If
	End If
	
	SqlCa.of_Commit();
	
	If Not This.of_Atualiza_Sequencial_Consulta(Ref ls_Erro) Then Return False
	
	//Se der erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do sequencial de consulta (na par$$HEX1$$e200$$ENDHEX$$metro geral, j$$HEX1$$e100$$ENDHEX$$ fez um commit anteriormente para gravar a carga dos produtos)
	SqlCa.of_Commit();
	
	If Not gvb_Auto Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Terminou a Carga das Tabelas DermaClub.~r~rAgora ir$$HEX1$$e100$$ENDHEX$$ iniciar a carga nas tabelas PBM")
	End If
	
	//Seta il_Tabela = 2 para gravar o registro de Carga PBM na grava$$HEX2$$e700e300$$ENDHEX$$o do log
	il_Tabela = 2
	
	If Not This.of_Processa_Carga_PBM(Ref ls_Erro) Then
		This.of_Atualiza_Tabela_Log( 2, "-1", "", 0, Ref ls_erro)
		io_Comum.of_envia_email(ls_Erro)
		Return False
	End If
	
	SqlCa.of_Commit();
	
	If Not gvb_Auto Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Termino da Carga PBM")
	End If
	
	Return True
	
Catch (RunTimeError lo_error)
	io_Comum.of_envia_email(lo_error.GetMessage())
	Return False
	
Finally
	If IsValid(io_Comum) Then Destroy(io_Comum)
	If IsValid(io_Json) Then Destroy(io_Json)
	If IsValid(ids_EAN) Then Destroy(ids_EAN)
End Try
end function

public function boolean of_carrega_projeto (any aa_projeto[], ref string as_erro);Any la_Data

Long ll_Linha
Long ll_Linhas

ll_Linhas = UpperBound(aa_Projeto)

//Projeto
For ll_Linha = 1 To ll_Linhas
	
	il_Tipo_Log = 1

	If Not io_json.retrieve("projetos/" + String(ll_Linha) + "/idProjeto", Ref la_Data) Then
		as_Erro = "Retrieve tag idProjeto (null)"
		Return False
	End If
	
	If Long(la_Data) <> 1033 Then
		as_Erro = "idProjeto " + String(la_Data) + " inv$$HEX1$$e100$$ENDHEX$$lido. Ser$$HEX1$$e100$$ENDHEX$$ aceito somente o projeto 1033"
		Return False
	End If
	
	st_Projeto.idprojeto[ll_Linha] = Long(la_Data)
	
	la_Data = ia_Null
	
	If Not io_json.retrieve("projetos/" + String(ll_Linha) + "/projeto", Ref la_Data) Then
		as_Erro = "Retrieve tag projeto (null)"
		Return False
	End If
	
	st_Projeto.projeto[ll_Linha] = String(la_Data)
	
	la_Data = ia_Null
	
	If Not io_json.retrieve("projetos/" + String(ll_Linha) + "/tipoProjeto", Ref la_Data) Then
		as_Erro = "Retrieve tag tipoProjeto (null)"
		Return False
	End If
	
	st_Projeto.tipoprojeto[ll_Linha] = String(la_Data)
	
	la_Data = ia_Null
	
	If Not io_json.retrieve("projetos/" + String(ll_Linha) + "/msgProjeto", Ref la_Data) Then
		as_Erro = "Retrieve tag msProjeto (null)"
		Return False
	End If
	
	st_Projeto.Msgprojeto[ll_Linha] = String(la_Data)
	
	la_Data = ia_Null
	
	If Not io_json.retrieve("projetos/" + String(ll_Linha) + "/ufs", Ref la_Data) Then
		as_Erro = "Retrieve tag ufs (null)"
		Return False
	End If
	
	If Not This.of_Carrega_UF(la_Data, "projetos/" + String(ll_Linha) + "/ufs/", Ref as_Erro) Then Return False
Next

Return True
end function

public function boolean of_carrega_uf (any aa_uf[], string as_caminho, ref string as_erro);Any la_Data

Long ll_Linha
Long ll_Linhas
Long ll_Contador = 0

ll_Linhas = UpperBound(aa_UF)

//UF
For ll_Linha = 1 To ll_Linhas
	
	il_Tipo_Log = 1
	
	This.of_Limpa_Estrutura()
	
	If Not io_json.retrieve(as_Caminho + String(ll_Linha) + "/uf", Ref la_Data) Then
		as_Erro = "Retrieve tag uf (null)"
		Return False
	End If
		
	st_UF.Uf[1] = String(la_Data)
	
	is_UF = st_UF.Uf[1]
	
	la_Data = ia_Null
	
//	If Not io_json.retrieve(as_Caminho + String(ll_Linha) + "/codigoIBGE", Ref la_Data) Then
//		as_Erro = "Retrieve tag codigoIBGE (null)"
//		Return False
//	End If
//	
//	st_UF.CodigoIBGE[ll_Linha] = String(la_Data)
//	
//	la_Data = ia_Null
	
	If Not io_json.retrieve(as_Caminho + String(ll_Linha) + "/campanhas", Ref la_Data) Then
		as_Erro = "Retrieve tag campanhas (null)"
		Return False
	End If
	
	If Not This.of_Carrega_Campanha(la_Data, as_Caminho + String(ll_Linha) + "/campanhas/", Ref as_Erro) Then Return False
	
	If Not ib_Proce_Campanha Then Continue

	ll_Contador ++

	//Apaga os registros das tabelas para iniciar a nova carga e grava o projeto uma $$HEX1$$fa00$$ENDHEX$$nica vez
	If ll_Contador = 1 Then
		If Not This.of_Deleta_Registros(Ref as_Erro) Then Return False
		
		If Not This.of_Grava_Projeto(Ref as_Erro) Then Return False
	End If
	
	If Not This.of_Processa_Atualizacao_Carga(Ref as_Erro) Then Return False
	
	//Inicia as vari$$HEX1$$e100$$ENDHEX$$veis
	is_UF = ""
	il_Campanha = 0
	ib_Proce_Campanha = False
Next

Return True
end function

public function boolean of_carrega_campanha (any aa_campanha[], string as_caminho, ref string as_erro);Any la_Data

Long ll_Linha
Long ll_Linhas

ll_Linhas = UpperBound(aa_Campanha)

str_ge536_campanha st_campanha_nula

//Campanha
For ll_Linha = 1 To ll_Linhas
	
	il_Tipo_Log = 1
	
	If Not io_json.retrieve(as_Caminho + String(ll_Linha) + "/idCampanha", Ref la_Data) Then
		as_Erro = "Retrieve tag idCampanha (null)"
		Return False
	End If
	
	st_Campanha.Idcampanha[1] = Long(la_Data)
	
	il_Campanha = Long(la_Data)
	
	la_Data = ia_Null
	
	If Not io_json.retrieve(as_Caminho + String(ll_Linha) + "/campanha", Ref la_Data) Then
		as_Erro = "Retrieve tag campanha (null)"
		Return False
	End If
	
	st_Campanha.Campanha[1] = String(la_Data)
		
	la_Data = ia_Null
	
//	If Not io_json.retrieve(as_Caminho + String(ll_Linha) + "/msgCupom", Ref la_Data) Then
//		as_Erro = "Retrieve tag msgCupom (null)"
//		Return False
//	End If
//	
//	st_Campanha.Msgcupom[ll_Linha] = String(la_Data)
//	
//	la_Data = ia_Null
	
	If Not io_json.retrieve(as_Caminho + String(ll_Linha) + "/url", Ref la_Data) Then
		as_Erro = "Retrieve tag url (null)"
		Return False
	End If
	
	st_Campanha.Url[1] = String(la_Data)
	
	la_Data = ia_Null
	
	If Not io_json.retrieve(as_Caminho + String(ll_Linha) + "/telefone", Ref la_Data) Then
		as_Erro = "Retrieve tag telefone (null)"
		Return False
	End If
	
	st_Campanha.Telefone[1] = String(la_Data)
	
	If Not io_json.retrieve(as_Caminho + String(ll_Linha) + "/canaisVenda", Ref la_Data) Then
		as_Erro = "Retrieve tag canaisVenda (null)"
		Return False
	End If
	
	If Not This.of_Carrega_Canal_Venda(la_Data, as_Caminho + String(ll_Linha) + "/canaisVenda/", Ref as_Erro) Then Return False
	
	//A carga ser$$HEX1$$e100$$ENDHEX$$ executada somente para canal de venda PDV ou se o canal venda for vazio/nulo
	If Not ib_Proce_Campanha Then
		If ll_Linha < ll_Linhas Then
			st_campanha = st_campanha_nula
			Continue
		Else
			Return True
		End If
	End If
	
	If Not This.of_Atualiza_Tabela_Log( 1, "1", st_UF.Uf[1], st_Campanha.Idcampanha[1], Ref as_erro) Then
		io_Comum.of_envia_email(as_Erro)
		Return False
	End If
	
	la_Data = ia_Null
	
	If Not io_json.retrieve(as_Caminho + String(ll_Linha) + "/produtos", Ref la_Data) Then
		as_Erro = "Retrieve tag produtos (null)"
		Return False
	End If
	
	If Not This.of_Carrega_Produto(la_Data, as_Caminho + String(ll_Linha) + "/produtos/", Ref as_Erro) Then Return False
	
	la_Data = ia_Null
	
	If Not io_json.retrieve(as_Caminho + String(ll_Linha) + "/kits", Ref la_Data) Then
		as_Erro = "Retrieve tag kits (null)"
		Return False
	End If
	
	If ib_Proce_Campanha Then Return True
	
	//If Not This.of_Carrega_Kit(la_Data, as_Caminho + "1/kits/", Ref as_Erro) Then Return False	
Next

Return True
end function

public function boolean of_carrega_produto (any aa_produto[], string as_caminho, ref string as_erro);Any la_Data

Long ll_Linha
Long ll_Linhas

String ls_Msg_Prd

ll_Linhas = UpperBound(aa_Produto)

//Produto
For ll_Linha = 1 To ll_Linhas
	
	il_Tipo_Log = 2

	If Not io_json.retrieve(as_Caminho + String(ll_Linha) + "/codigoProduto", Ref la_Data) Then
		as_Erro = "Retrieve tag codigoProduto (null)"
		Return False
	End If	

	is_Codigo_Barras = String(la_Data)
	
	//Verifica se existe o EAN do produto
	If Not This.of_Localiza_Produto(Ref ls_Msg_Prd, Ref as_Erro) Then Return False
	
	st_Produto.Codigoproduto[ll_Linha] = is_Codigo_Barras
	
	la_Data = ia_Null
	
	If Not io_json.retrieve(as_Caminho + String(ll_Linha) + "/produto", Ref la_Data) Then
		as_Erro = "Retrieve tag produto (null)"
		Return False
	End If
	
	st_Produto.Produto[ll_Linha] = String(la_Data)
	
	is_De_Produto = String(la_Data)
	
	la_Data = ia_Null
	
	If Not io_json.retrieve(as_Caminho + String(ll_Linha) + "/tipoProduto", Ref la_Data) Then
		as_Erro = "Retrieve tag tipoProduto (null)"
		Return False
	End If
	
	st_Produto.TipoProduto[ll_Linha] = Long(la_Data)
	
	la_Data = ia_Null
	
	If Not io_json.retrieve(as_Caminho + String(ll_Linha) + "/desconto", Ref la_Data) Then
		as_Erro = "Retrieve tag desconto (null)"
		Return False
	End If
	
	st_Produto.Desconto[ll_Linha] = Dec(la_Data)
	
	idc_Vl_Desconto = Dec(la_Data)
	
	la_Data = ia_Null
	
	If Not io_json.retrieve(as_Caminho + String(ll_Linha) + "/tipoDesconto", Ref la_Data) Then
		as_Erro = "Retrieve tag tipoDesconto (null)"
		Return False
	End If
	
	st_Produto.TipoDesconto[ll_Linha] = String(la_Data)
	
	If Not This.of_Atualiza_Tabela_Log_Produto( st_Produto.Codigoproduto[ll_Linha], st_Produto.Produto[ll_Linha], st_Produto.Desconto[ll_Linha], ls_Msg_Prd, Ref as_erro) Then
		io_Comum.of_envia_email(as_Erro)
		Return False
	End If
	
	la_Data = ia_Null
		
	If Not io_json.retrieve(as_Caminho + String(ll_Linha) + "/quantidades", Ref la_Data) Then
		as_Erro = "Retrieve tag quantidades (null)"
		Return False
	End If	
	
	If Not This.of_Carrega_Quantidades(la_Data, as_Caminho + String(ll_Linha) + "/quantidades/", st_Produto.Codigoproduto[ll_Linha], ls_Msg_Prd, Ref as_Erro) Then Return False
	
Next

Return True
end function

public function boolean of_grava_projeto (ref string as_erro);Long ll_Achou

Select Count(*)
	Into :ll_Achou
From dermaclub_projeto
Where nr_projeto = :st_Projeto.idProjeto[1]
Using SqlCa;

If SqlCa.SqlCode = - 1 Then	
	as_Erro = "Erro ao verificar se o projeto " + String(st_Projeto.idprojeto[1]) + " j$$HEX1$$e100$$ENDHEX$$ foi gravado em consulta anterior. " + SqlCa.SqlErrText
	SqlCa.of_Rollback();
	Return False
End If

If ll_Achou > 0 Then
	Update dermaclub_projeto
		Set	de_msg_projeto = :st_Projeto.Msgprojeto[1],
				dh_inicio_carga = getdate(),
				dh_termino_carga = null,
				de_hash = :io_Comum.is_Token
	Where nr_projeto = :st_Projeto.Idprojeto[1]
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		as_Erro = "Erro ao atualizar a data in$$HEX1$$ed00$$ENDHEX$$cio e t$$HEX1$$e900$$ENDHEX$$rmino da carga de produtos DermaClub"
		Return False
	End If
	
Else
	
	Insert Into dermaclub_projeto(nr_projeto, de_projeto, id_tipo_projeto, de_msg_projeto, dh_inicio_carga, dh_termino_carga, de_hash)
							Values(:st_Projeto.Idprojeto[1], :st_Projeto.Projeto[1], :st_Projeto.TipoProjeto[1], :st_Projeto.Msgprojeto[1], getdate(), null, :io_Comum.is_Token)
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		as_Erro = "Erro ao gravar o projeto Dermaclub " + String(st_Projeto.Projeto[1]) + ". " + SqlCa.SqlErrText
		SqlCa.of_Rollback();
		Return False
	End If
End If

Return True
end function

public function boolean of_grava_campanha (ref string as_erro);Date ldt_Inclusao

ldt_Inclusao = Today()

If st_UF.Uf[1] = "BR" Or st_UF.Uf[1] = "" Then
	SetNull(st_UF.Uf[1])
End If

Insert Into dermaclub_campanha(	nr_campanha,
											de_campanha,
											de_msg_cupom,
											de_url,
											nr_telefone,
											dh_inclusao,
											nr_projeto,
											cd_canal_venda,
											cd_uf)
								Values(	:st_Campanha.Idcampanha[1],
											:st_Campanha.Campanha[1],
											null,
											:st_Campanha.Url[1],
											:st_Campanha.Telefone[1],
											:ldt_Inclusao,
											:st_Projeto.IdProjeto[1],
											:is_Canal_Venda,
											:st_UF.Uf[1])
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_Erro = "Erro ao gravar a Campanha Derma Clube " + String(st_Campanha.Campanha[1]) + ". " + SqlCa.SqlErrText
	SqlCa.of_Rollback();
	Return False
End If

Return True
end function

public function boolean of_grava_produto (ref string as_erro);Long ll_Linha

For ll_Linha = 1 To UpperBound(st_Produto.Codigoproduto[])
	
	Insert Into dermaclub_produto(	de_codigo_barras,
											de_produto,
											id_tipo_produto,
											vl_desconto,
											id_tipo_desconto,
											nr_campanha)
								Values(	:st_Produto.Codigoproduto[ll_Linha],
											:st_Produto.Produto[ll_Linha],
											:st_Produto.Tipoproduto[ll_Linha],
											:st_Produto.Desconto[ll_Linha],
											:st_Produto.Tipodesconto[ll_Linha],
											:st_Campanha.Idcampanha[1])
											
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		as_Erro = "Erro ao gravar o Produto o Dermaclub " + st_Produto.Produto[ll_Linha] + " e campanha " + String(st_Campanha.Idcampanha[1]) + "." + SqlCa.SqlErrText
		SqlCa.of_Rollback();
		Return False
	End If

Next

Return True
end function

public function boolean of_processa_atualizacao_carga (ref string as_erro);If Not This.of_Grava_Campanha(Ref as_Erro) Then Return False

If Not This.of_Grava_Produto(Ref as_Erro) Then Return False

If Not This.of_Grava_Desconto_Progressivo(Ref as_Erro) Then Return False

//If Not This.of_Grava_Kit_Produto(Ref as_Erro) Then Return False

Return True
end function

public function boolean of_atualiza_sequencial_consulta (ref string as_erro);String ls_Vl_Parametro

ls_Vl_Parametro = String(io_Comum.il_Seq_Consulta)

Update parametro_geral
	Set vl_parametro = :ls_Vl_Parametro
Where cd_parametro = "NR_SEQUENCIAL_CONSULTA_DERMACLUB"
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_Erro = "Erro ao atualizar o sequencial do parametro geral 'NR_SEQUENCIAL_CONSULTA_DERMACLUB'. " + SqlCa.SqlErrText
	SqlCa.of_Rollback();
	Return False
End If


Update dermaclub_projeto
	Set dh_termino_carga = getdate()
Where nr_projeto = :st_projeto.Idprojeto[1]
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_Erro = "Erro ao atualizar o t$$HEX1$$e900$$ENDHEX$$rmino da carga de produtos " + SqlCa.SqlErrText
	SqlCa.of_Rollback();
	Return False
End If

Return True
end function

public function boolean of_grava_desconto_progressivo (ref string as_erro);Long ll_Linha

For ll_Linha = 1 To UpperBound(st_Qtd.Codigoproduto[])
	
	Insert Into dermaclub_desc_progressivo(	de_codigo_barras,
															qt_produto,
															de_operador,
															vl_desconto,
															nr_campanha)
												Values(	:st_Qtd.Codigoproduto[ll_Linha],
															:st_Qtd.Quantidade[ll_Linha],
															:st_Qtd.Operador[ll_Linha],
															:st_Qtd.Desconto[ll_Linha],
															:st_Campanha.Idcampanha[1])
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		as_Erro = "Erro ao gravar o desconto progressivo do Dermaclub " + st_Qtd.CodigoProduto[ll_Linha] + " e campanha " + String(st_Campanha.Idcampanha[1]) + "." + SqlCa.SqlErrText
		SqlCa.of_Rollback();
		Return False
	End If

Next

Return True
end function

public subroutine of_limpa_estrutura ();str_ge536_campanha st_campanha_nula
str_ge536_produto st_produto_nulo
str_ge536_uf st_uf_nula
str_ge536_quantidades st_qtd_nula
str_ge536_kit st_kit_nula

st_campanha = st_campanha_nula
st_produto = st_produto_nulo
st_uf = st_uf_nula
st_qtd = st_qtd_nula
st_kit = st_kit_nula
end subroutine

public function boolean of_carrega_kit (any aa_kit[], string as_caminho, ref string as_erro);Any la_Data
Any la_Kit_Produto

Long ll_Linha
Long ll_Linhas
Long ll_Linha_Prd
Long ll_Linhas_Prd
Long ll_Linha_Kit

String ls_CodigoKit

ll_Linhas = UpperBound(aa_Kit)

//Kit
For ll_Linha = 1 To ll_Linhas
	
	il_Tipo_Log = 4

	If Not io_json.retrieve(as_Caminho + String(ll_Linha) + "/codigoKit", Ref la_Data) Then
		as_Erro = "Retrieve tag codigoKit (null)"
		Return False
	End If
	
	ls_CodigoKit = String(la_Data)
		
	la_Data = ia_Null
	
	If Not io_json.retrieve(as_Caminho + String(ll_Linha) + "/kitProdutos", Ref la_Data) Then
		as_Erro = "Retrieve tag kitProdutos (null)"
		Return False
	End If
	
	la_Kit_Produto[] = la_Data
		
	ll_Linhas_Prd = UpperBound(la_Kit_Produto)
	
	la_Data = ia_Null
	
	For ll_Linha_Prd = 1 To ll_Linhas_Prd
		
		ll_Linha_Kit = UpperBound(st_Kit.Codigokit) + 1
		
		st_Kit.Codigokit[ll_Linha_Kit] = ls_CodigoKit
		
		If Not io_json.retrieve(as_Caminho + String(ll_Linha) + "/kitProdutos/" + String(ll_Linha_Prd) + "/codigoProduto", Ref la_Data) Then
			as_Erro = "Retrieve tag codigoProduto (null) do kitProdutos"
			Return False
		End If
		
		st_Kit.Codigoproduto[ll_Linha_Kit] = String(la_Data)
		
		la_Data = ia_Null
		
		If Not io_json.retrieve(as_Caminho + String(ll_Linha) + "/kitProdutos/" + String(ll_Linha_Prd) + "/produto", Ref la_Data) Then
			as_Erro = "Retrieve tag produto (null) do kitProdutos"
			Return False
		End If
			
		st_Kit.Produto[ll_Linha_Kit] = String(la_Data)
		
		la_Data = ia_Null
		
		If Not io_json.retrieve(as_Caminho + String(ll_Linha) + "/kitProdutos/" + String(ll_Linha_Prd) + "/tipoProduto", Ref la_Data) Then
			as_Erro = "Retrieve tag tipoProduto (null) do kitProdutos"
			Return False
		End If
		
		st_Kit.Tipoproduto[ll_Linha_Kit] = Long(la_Data)
		
		la_Data = ia_Null
		
		If Not io_json.retrieve(as_Caminho + String(ll_Linha) + "/kitProdutos/" + String(ll_Linha_Prd) + "/desconto", Ref la_Data) Then
			as_Erro = "Retrieve tag desconto (null) do kitProdutos"
			Return False
		End If
		
		st_Kit.Desconto[ll_Linha_Kit] = Double(la_Data)
		
		la_Data = ia_Null
		
		If Not io_json.retrieve(as_Caminho + String(ll_Linha) + "/kitProdutos/" + String(ll_Linha_Prd) + "/quantidadeMin", Ref la_Data) Then
			as_Erro = "Retrieve tag quantidadeMin (null) do kitProdutos"
			Return False
		End If
		
		st_Kit.Quantidademin[ll_Linha_Kit] = Long(la_Data)
		
		la_Data = ia_Null
	Next
Next

Return True
end function

public function boolean of_grava_kit_produto (ref string as_erro);Long ll_Linha

For ll_Linha = 1 To UpperBound(st_Kit.Codigokit[])
	
	Insert Into dermaclub_kit_produto(cd_kit,
												de_codigo_barras,
												de_produto,
												id_tipo_produto,
												vl_desconto,
												qt_minima,
												nr_campanha)
									Values(	:st_Kit.Codigokit[ll_Linha],
												:st_Kit.Codigoproduto[ll_Linha],
												:st_Kit.Produto[ll_Linha],
												:st_Kit.Tipoproduto[ll_Linha],
												:st_Kit.Desconto[ll_Linha],
												:st_Kit.Quantidademin[ll_Linha],
												:st_Campanha.Idcampanha[1])	
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		as_Erro = "Erro ao gravar o kit produto DermaClub " + st_Kit.Codigokit[ll_Linha] + ", produto " + st_Kit.Produto[ll_Linha] + " e campanha " + String(st_Campanha.Idcampanha[1]) + "." + SqlCa.SqlErrText
		SqlCa.of_Rollback();
		Return False
	End If

Next

Return True
end function

public function boolean of_abre_conexao (ref string as_erro);//Abre uma nova transa$$HEX2$$e700e300$$ENDHEX$$o com o banco para gravar o registro.
If Not isvalid(iuo_SqlCa_log) Then
	iuo_SqlCa_log = Create dc_uo_transacao
	iuo_SqlCa_log.ivs_database = "SYBASE"
End If

If Not iuo_SqlCa_log.of_isconnected() Then
	If Not iuo_SqlCa_log.of_Connect(gvo_Aplicacao.ivs_DataSource, 'GE536 - Carga Produto DermaClub') Then
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

public function boolean of_atualiza_tabela_log (long al_tabela, string as_status, string as_uf, long al_campanha, ref string as_erro);Datetime ldh_data
DateTime ldh_Inicio
DateTime ldh_Termino

Long ll_Achou

String ls_Data
String ls_Erro

//Abre uma nova transa$$HEX2$$e700e300$$ENDHEX$$o com o banco para gravar o registro
If Not This.of_Abre_Conexao( Ref ls_Erro ) Then Return False

ldh_data  = DateTime(Today(), Now())
ls_Data =  String(ldh_data, "yyyy-mm-dd hh:mm:ss")

ldh_Inicio = DateTime(String(Today(), "dd/mm/yyyy 00:00:00"))
ldh_Termino= DateTime(String(Today(), "dd/mm/yyyy 23:59:59"))

If as_UF = "" Or as_UF = "BR" Then
	SetNull(as_UF)
End If

select count(*)
Into :ll_Achou
from log_integracao_derm_transacao
where nr_tabela = :al_Tabela
	and dh_registro between :ldh_Inicio And :ldh_Termino
	and cd_uf = :as_UF
	and nr_campanha = :al_Campanha
Using iuo_SqlCa_log;

If iuo_SqlCa_log.SqlCode = -1 Then
	as_Erro = 'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_tabela_log ~n' + 'Erro ao localizar registro na tabela "log_integracao_derm_transacao": ' + iuo_SqlCa_log.sqlerrtext
	iuo_SqlCa_log.of_Rollback()
	Return False
End If

If ll_Achou > 0 Then
	
	If Not This.of_Retorna_Sequencial_Log( ldh_Inicio, ldh_Termino, as_UF, al_Campanha, Ref as_Erro) Then Return False
//	
//	//Se for realizada a carga mais de uma vez no dia, exclui os registros de log (iniciando pelos itens)
//	Delete from log_integracao_derm_prd
//	where dh_registro between :ldh_Inicio And :ldh_Termino
//		and nr_atualizacao_transacao = :il_Nr_Atua_Transacao
//	Using iuo_SqlCa_log;
//	
//	If iuo_SqlCa_log.SqlCode = -1 Then
//		as_Erro = 'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_tabela_log ~n' + 'Erro ao excluir registro na tabela "log_integracao_derm_prd": ' + iuo_SqlCa_log.sqlerrtext
//		iuo_SqlCa_log.of_Rollback()
//		Return False
//	End If
	
//	Delete from log_integracao_derm_transacao
//	where nr_tabela = :al_Tabela
//		and dh_registro between :ldh_Inicio And :ldh_Termino
//		and cd_uf = :as_UF
//		and nr_campanha = :al_Campanha
//	Using iuo_SqlCa_log;
//	
//	If iuo_SqlCa_log.SqlCode = -1 Then
//		as_Erro = 'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_tabela_log ~n' + 'Erro ao excluir registro na tabela "log_integracao_derm_transacao": ' + iuo_SqlCa_log.sqlerrtext
//		iuo_SqlCa_log.of_Rollback()
//		Return False
//	End If

	Update log_integracao_derm_transacao
		Set  dh_registro = getdate(),
			  id_status = :as_Status,
			  cd_uf = :as_UF,
			  nr_campanha = :al_Campanha,
			  nr_projeto = :st_Projeto.Idprojeto[1],
			  de_erro = :as_Erro
	Where nr_atualizacao = :il_Nr_Atua_Transacao
	Using iuo_SqlCa_log;
	
	If iuo_SqlCa_log.SqlCode = - 1 Then
		as_Erro = 'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_tabela_log ~n' + 'Erro ao atualizar registro na tabela "log_integracao_derm_transacao": ' + iuo_SqlCa_log.sqlerrtext
		iuo_SqlCa_log.of_Rollback()
		Return False
	End If	

Else
	
	Insert into log_integracao_derm_transacao(nr_tabela, dh_registro, id_status, cd_uf, nr_campanha, nr_projeto, de_erro)
	Values (:al_Tabela,  getdate(), :as_Status, :as_UF, :al_Campanha, :st_Projeto.Idprojeto[1], :as_Erro)
	Using iuo_SqlCa_log;
	
	If iuo_SqlCa_log.SqlCode = - 1 Then
		as_Erro = 'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_tabela_log ~n' + 'Erro ao inserir registro na tabela "log_integracao_derm_transacao": ' + iuo_SqlCa_log.sqlerrtext
		iuo_SqlCa_log.of_Rollback()
		Return False
	End If	
End If

iuo_SqlCa_log.of_Commit();

//Captura o sequencial para utilizar na grava$$HEX2$$e700e300$$ENDHEX$$o do log de produto
//S$$HEX1$$f300$$ENDHEX$$ captura o sequencial se for uma inser$$HEX2$$e700e300$$ENDHEX$$o de sucesso
//Caso tenha erro, utiliza o sequencial j$$HEX1$$e100$$ENDHEX$$ existente na var$$HEX1$$e100$$ENDHEX$$vel il_Nr_Atua_Transacao
If Not This.of_Retorna_Sequencial_Log( ldh_Inicio, ldh_Termino, as_UF, al_Campanha, as_Erro) Then Return False

this.of_fecha_conexao( )

Return True
end function

public function boolean of_deleta_registros (ref string as_erro);//Zera as tabelas de carga (com exe$$HEX2$$e700e300$$ENDHEX$$o do dermaclub_projeto e dermaclub_canal_venda) para reimportar a nova carga via json do DermaClub

Delete From dermaclub_desc_progressivo
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_Erro = "Erro ao deletar os registros da tabela dermaclub_desc_progressivo. " + SqlCa.SqlErrText
	SqlCa.of_Rollback();
	Return False
End If

//Delete From dermaclub_kit_produto
//Using SqlCa;
//
//If SqlCa.SqlCode = -1 Then
//	as_Erro = "Erro ao deletar os registros da tabela dermaclub_kit_produto. " + SqlCa.SqlErrText
//	SqlCa.of_Rollback();
//	Return False
//End If

Delete From dermaclub_produto
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_Erro = "Erro ao deletar os registros da tabela dermaclub_produto. " + SqlCa.SqlErrText
	SqlCa.of_Rollback();
	Return False
End If

Delete From dermaclub_campanha
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_Erro = "Erro ao deletar os registros da tabela dermaclub_campanha. " + SqlCa.SqlErrText
	SqlCa.of_Rollback();
	Return False
End If

SqlCa.of_Commit();

Return True
end function

public function boolean of_retorna_sequencial_log (datetime adh_inicio, datetime adh_termino, string as_uf, long al_campanha, ref string as_erro);il_Nr_Atua_Transacao = 0

select nr_atualizacao
Into :il_Nr_Atua_Transacao
from log_integracao_derm_transacao
where nr_tabela = :This.il_Tabela
	and dh_registro between :adh_Inicio And :adh_Termino
	and cd_uf = :as_UF
	and nr_campanha = :al_Campanha
Using iuo_SqlCa_log;

If iuo_SqlCa_log.SqlCode = -1 Then
	as_Erro = 'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_retorna_sequencial_log ~n' + 'Erro ao localizar registro na tabela "of_retorna_sequencial_log": ' + iuo_SqlCa_log.sqlerrtext
	iuo_SqlCa_log.of_Rollback()
	Return False
End If

Return True
end function

public function boolean of_processa_carga_pbm (ref string as_erro);If Not This.of_Deleta_Registros_PBM(Ref as_Erro) Then Return False

If Not This.of_Grava_PBM_Produto(Ref as_Erro) Then Return False

If Not This.of_Grava_PBM_Produto_Progressivo(Ref as_Erro) Then Return False

Return True
end function

public function boolean of_deleta_registros_pbm (ref string as_erro);//Antes de iniciar a carga dos produtos DermaClub nas tabelas PBM, os registros s$$HEX1$$e300$$ENDHEX$$o exclu$$HEX1$$ed00$$ENDHEX$$dos para ap$$HEX1$$f300$$ENDHEX$$s serem inseridos os valores atualizados

Delete From pbm_produto_progressivo
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_Erro = "Erro ao excluir os registros DermaClub da tabela pbm_produto_progressivo " + SqlCa.SqlErrText
	SqlCa.of_Rollback();
	Return False
End If

Delete From pbm_produto
Where id_tipo = 'D'
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_Erro = "Erro ao excluir os registros DermaClub da tabela pbm_produto " + SqlCa.SqlErrText
	SqlCa.of_Rollback();
	Return False
End If

Return True
end function

public function boolean of_grava_pbm_produto (ref string as_erro);Decimal ldc_Vl_Desconto

Long ll_Linha
Long ll_Linhas
Long ll_PBM
Long ll_Produto
Long ll_Achou
Long ll_Campanha

String ls_UF
String ls_Id_Desconto
String ls_Msg_Cupom

Try
	
	dc_uo_ds_base lds
	lds = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject("ds_ge536_lista_produtos_json") Then
		as_Erro = "Erro ao carregar a ds 'ds_ge536_lista_produtos_json'. Fun$$HEX2$$e700e300$$ENDHEX$$o of_carrega_informacoes_pbm"
		Return False
	End If
	
	ll_Linhas = lds.Retrieve()
	
	If ll_Linhas < 0 Then
		as_Erro = "Erro no retrieve da ds 'ds_ge536_lista_produtos_json'. Fun$$HEX2$$e700e300$$ENDHEX$$o of_carrega_informacoes_pbm"
		Return False
	End If
	
	If ll_Linhas = 0 Then
		as_Erro = "N$$HEX1$$e300$$ENDHEX$$o retornou nenhum produto no retrieve da ds ds_ge536_lista_produtos_json"
		Return False
	End If
	
	For ll_Linha = 1 To ll_Linhas
		ll_PBM				= lds.Object.Cd_PBM				[ll_Linha]
		ll_Produto 			= lds.Object.Cd_Produto			[ll_Linha]
		ldc_Vl_Desconto	= lds.Object.Vl_Desconto		[ll_Linha]
		ls_UF					= lds.Object.Cd_UF				[ll_Linha]
		ls_Msg_Cupom		= lds.Object.De_Msg_Cupom	[ll_Linha]
		ll_Campanha		= lds.Object.Nr_Campanha		[ll_Linha]
				
		If ldc_Vl_Desconto > 0.0 Then
			ls_Id_Desconto = "S"
		Else
			ls_Id_Desconto = "N"
		End If
		
		Select Count(*)
			Into :ll_Achou
		From pbm_produto
		Where cd_pbm = :ll_PBM
			And cd_produto = :ll_Produto
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			as_Erro = "Erro ao verificar se o produto [" + String(ll_Produto) + "] j$$HEX1$$e100$$ENDHEX$$ foi inserido no PBM [" + String(ll_PBM) + "]. " + SqlCa.SqlErrTExt
			SqlCa.of_Rollback();
			Return False
		End If
		
		If ll_Achou = 0 Then
			Insert Into pbm_produto(cd_pbm, cd_produto, id_preco_fixo, vl_preco_fixo, id_desconto, pc_desconto, id_gratis, id_caixa_bonus, de_observacao, id_tipo, vl_desconto, nr_campanha)
								  Values(:ll_PBM, :ll_Produto, 'N', 0.00, :ls_Id_Desconto, 0.00, 'N', 'N', :ls_Msg_Cupom, 'D', :ldc_Vl_Desconto, :ll_Campanha)
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
	If IsValid(lds) Then Destroy(lds)
End Try
end function

public function boolean of_grava_pbm_produto_progressivo (ref string as_erro);Decimal ldc_Vl_Desconto

Long ll_Linha
Long ll_Linhas
Long ll_PBM
Long ll_Produto
Long ll_Produto_Ant = 0
Long ll_Qt_Produto
Long ll_Achou
Long ll_Nr_Campanha
Long ll_Nr_Camp_Ant = 0

String ls_Tipo_Operador

Try
	
	dc_uo_ds_base lds
	lds = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject("ds_ge536_lista_prd_desc_prog_json") Then
		as_Erro = "Erro ao carregar a ds 'ds_ge536_lista_prd_desc_prog_json'. Fun$$HEX2$$e700e300$$ENDHEX$$o of_carrega_informacoes_pbm"
		Return False
	End If
	
	ll_Linhas = lds.Retrieve()
	
	If ll_Linhas < 0 Then
		as_Erro = "Erro no retrieve da ds 'ds_ge536_lista_prd_desc_prog_json'. Fun$$HEX2$$e700e300$$ENDHEX$$o of_carrega_informacoes_pbm"
		Return False
	End If
	
	For ll_Linha = 1 To ll_Linhas
		ll_PBM				= lds.Object.Cd_PBM			[ll_Linha]
		ll_Produto 			= lds.Object.Cd_Produto		[ll_Linha]
		ll_Qt_Produto		= lds.Object.Qt_Produto		[ll_Linha]
		ls_Tipo_Operador	= lds.Object.De_Operador	[ll_Linha]
		ldc_Vl_Desconto	= lds.Object.Vl_Desconto	[ll_Linha]
		ll_Nr_Campanha	= lds.Object.Nr_Campanha	[ll_Linha]
				
		If (ll_Produto <> ll_Produto_Ant) Or (ll_Nr_Campanha <> ll_Nr_Camp_Ant) Then
			
			Update pbm_produto
				Set id_desconto = 'S'
			Where cd_pbm = :ll_PBM
				And cd_produto = :ll_Produto
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				as_Erro = "Erro ao atualizar o id_desconto do PBM Produto para o produto " + String(ll_Produto) + " no PBM " + String(ll_PBM) + ". Fun$$HEX2$$e700e300$$ENDHEX$$o of_grava_pbm_produto_progressivo. " + SqlCa.SqlErrText
				SqlCa.of_Rollback();
				Return False
			End If			
		End If
		
		Select Count(*)
			Into :ll_Achou
		From pbm_produto_progressivo
		Where cd_pbm = :ll_PBM
			And cd_produto = :ll_Produto
			And qt_produto = :ll_Qt_Produto
			And de_tipo_operador = :ls_Tipo_Operador
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			as_Erro = "Erro ao verificar se o produto [" + String(ll_Produto) + "] j$$HEX1$$e100$$ENDHEX$$ foi inserido no PBM Progressivo [" + String(ll_PBM) + "]. " + SqlCa.SqlErrTExt
			SqlCa.of_Rollback();
			Return False
		End If
		
		If ll_Achou = 0 Then
			Insert Into pbm_produto_progressivo(cd_pbm, cd_produto, qt_produto, de_tipo_operador, vl_desconto)
								  Values(:ll_PBM, :ll_Produto, :ll_Qt_Produto, :ls_Tipo_Operador, :ldc_Vl_Desconto)
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				as_Erro = "Erro ao inserir o produto " + String(ll_Produto) + " no PBM " + String(ll_PBM) + ". Fun$$HEX2$$e700e300$$ENDHEX$$o of_grava_pbm_produto_progressivo. " + SqlCa.SqlErrText
				SqlCa.of_Rollback();
				Return False
			End If
		End If
		
		ll_Produto_Ant 		= ll_Produto
		ll_Nr_Camp_Ant 	= ll_Nr_Campanha
	Next

	Return True
	
Catch (RunTimeError lo_error)
	as_Erro = lo_error.GetMessage()
	Return False
	
Finally
	If IsValid(lds) Then Destroy(lds)
End Try
end function

public function boolean of_atualiza_tabela_log_produto (string as_codigo_barras, string as_de_produto, decimal adc_desconto, string as_mensagem_produto, ref string as_erro);Datetime ldh_data
DateTime ldh_Inicio
DateTime ldh_Termino

Long ll_Achou

String ls_Data
String ls_Erro

ldh_data  = DateTime(Today(), Now())
ls_Data =  String(ldh_data, "yyyy-mm-dd hh:mm:ss")

//Abre uma nova transa$$HEX2$$e700e300$$ENDHEX$$o com o banco para gravar o registro
If Not This.of_Abre_Conexao( Ref ls_Erro ) Then Return False

ldh_Inicio = DateTime(String(Today(), "dd/mm/yyyy 00:00:00"))
ldh_Termino= DateTime(String(Today(), "dd/mm/yyyy 23:59:59"))

select count(*)
Into :ll_Achou
from log_integracao_derm_prd
where dh_registro between :ldh_Inicio And :ldh_Termino
	and de_codigo_barras = :as_Codigo_Barras
	and nr_atualizacao_transacao = :il_Nr_Atua_Transacao
Using iuo_SqlCa_log;

If iuo_SqlCa_log.SqlCode = -1 Then
	as_Erro = 'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_tabela_log_produto ~n' + 'Erro ao localizar registro na tabela "log_integracao_derm_prd": ' + iuo_SqlCa_log.sqlerrtext
	iuo_SqlCa_log.of_Rollback()
	Return False
End If

If ll_Achou > 0 Then
	
	Delete from log_integracao_derm_prd
	where dh_registro between :ldh_Inicio And :ldh_Termino
		and de_codigo_barras = :as_Codigo_Barras
		and nr_atualizacao_transacao = :il_Nr_Atua_Transacao
	Using iuo_SqlCa_log;
	
	If iuo_SqlCa_log.SqlCode = -1 Then
		as_Erro = 'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_tabela_log_produto ~n' + 'Erro ao excluir registro na tabela "log_integracao_derm_prd": ' + iuo_SqlCa_log.sqlerrtext
		iuo_SqlCa_log.of_Rollback()
		Return False
	End If
End If

//Se o produto n$$HEX1$$e300$$ENDHEX$$o foi localizado, ir$$HEX1$$e100$$ENDHEX$$ mostrar a mensagem de produto n$$HEX1$$e300$$ENDHEX$$o localizado
If as_Mensagem_Produto <> "" And Not IsNull(as_Mensagem_Produto) Then
	as_Erro = as_Mensagem_Produto
End If

Insert into log_integracao_derm_prd(nr_atualizacao_transacao, dh_registro, de_codigo_barras, de_produto, vl_desconto, de_erro)
Values (:il_Nr_Atua_Transacao, getdate(), :as_Codigo_Barras, :as_De_Produto, :adc_Desconto, :as_Erro)
Using iuo_SqlCa_log;

If iuo_SqlCa_log.SqlCode = - 1 Then
	as_Erro = 'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_tabela_log_produto ~n' + 'Erro ao inserir registro na tabela "log_integracao_derm_prd": ' + iuo_SqlCa_log.sqlerrtext
	iuo_SqlCa_log.of_Rollback()
	Return False
End If

iuo_SqlCa_log.of_Commit();

this.of_fecha_conexao( )

as_Erro = ""

Return True
end function

public function boolean of_atualiza_tabela_log_desc_progressivo (string as_codigo_barras, long al_qt_produto, string as_de_operador, decimal adc_desconto, string as_mensagem_produto, ref string as_erro);Datetime ldh_data
DateTime ldh_Inicio
DateTime ldh_Termino

Long ll_Achou

String ls_Data
String ls_Erro

ldh_data  = DateTime(Today(), Now())
ls_Data =  String(ldh_data, "yyyy-mm-dd hh:mm:ss")

//Abre uma nova transa$$HEX2$$e700e300$$ENDHEX$$o com o banco para gravar o registro
If Not This.of_Abre_Conexao( Ref ls_Erro ) Then Return False

ldh_Inicio = DateTime(String(Today(), "dd/mm/yyyy 00:00:00"))
ldh_Termino= DateTime(String(Today(), "dd/mm/yyyy 23:59:59"))

select count(*)
Into :ll_Achou
from log_integracao_derm_desc_prog
where dh_registro between :ldh_Inicio And :ldh_Termino
	and de_codigo_barras = :as_Codigo_Barras
	and nr_atualizacao_transacao = :il_Nr_Atua_Transacao
	and qt_produto = :al_Qt_produto
	and de_operador = :as_De_Operador
Using iuo_SqlCa_log;

If iuo_SqlCa_log.SqlCode = -1 Then
	as_Erro = 'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_tabela_log_desc_progressivo ~n' + 'Erro ao localizar registro na tabela "log_integracao_derm_desc_prog": ' + iuo_SqlCa_log.sqlerrtext
	iuo_SqlCa_log.of_Rollback()
	Return False
End If

If ll_Achou > 0 Then
	
	Delete from log_integracao_derm_desc_prog
	where dh_registro between :ldh_Inicio And :ldh_Termino
		and de_codigo_barras = :as_Codigo_Barras
		and nr_atualizacao_transacao = :il_Nr_Atua_Transacao
		and qt_produto = :al_Qt_produto
		and de_operador = :as_De_Operador
	Using iuo_SqlCa_log;
	
	If iuo_SqlCa_log.SqlCode = -1 Then
		as_Erro = 'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_tabelal_log_desc_progressivo ~n' + 'Erro ao excluir registro na tabela "log_integracao_derm_desc_prog": ' + iuo_SqlCa_log.sqlerrtext
		iuo_SqlCa_log.of_Rollback()
		Return False
	End If
End If

//Se o produto n$$HEX1$$e300$$ENDHEX$$o foi localizado, ir$$HEX1$$e100$$ENDHEX$$ mostrar a mensagem de produto n$$HEX1$$e300$$ENDHEX$$o localizado
If as_Mensagem_Produto <> "" And Not IsNull(as_Mensagem_Produto) Then
	as_Erro = as_Mensagem_Produto
End If

Insert into log_integracao_derm_desc_prog(nr_atualizacao_transacao, dh_registro, de_codigo_barras, qt_produto, de_operador, vl_desconto, de_erro)
Values (:il_Nr_Atua_Transacao, getdate(), :as_Codigo_Barras, :al_Qt_Produto, :as_De_Operador, :adc_Desconto, :as_Erro)
Using iuo_SqlCa_log;

If iuo_SqlCa_log.SqlCode = - 1 Then
	as_Erro = 'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_tabelal_log_desc_progressivo ~n' + 'Erro ao inserir registro na tabela "log_integracao_derm_desc_progress": ' + iuo_SqlCa_log.sqlerrtext
	iuo_SqlCa_log.of_Rollback()
	Return False
End If

iuo_SqlCa_log.of_Commit();

this.of_fecha_conexao( )

Return True
end function

public function boolean of_carrega_quantidades (any aa_quantidade[], string as_caminho, string as_codigo_produto, string as_msg_produto, ref string as_erro);Any la_Data

Long ll_Linha
Long ll_Linhas
Long ll_Linha_Qtd

ll_Linhas = UpperBound(aa_Quantidade)

//Quantidades - Desconto Progressivo
For ll_Linha = 1 To ll_Linhas
	
	il_Tipo_Log = 3
	
	ll_Linha_Qtd = UpperBound(st_Qtd.CodigoProduto) + 1
	
	st_Qtd.Codigoproduto[ll_Linha_Qtd] = as_Codigo_Produto

	If Not io_json.retrieve(as_Caminho + String(ll_Linha) + "/quantidade", Ref la_Data) Then
		as_Erro = "Retrieve tag quantidade (null)"
		Return False
	End If
	
	st_Qtd.Quantidade[ll_Linha_Qtd] = Long(la_Data)
	
	il_Qt_Produto = Long(la_Data)
	
	la_Data = ia_Null
	
	If Not io_json.retrieve(as_Caminho + String(ll_Linha) + "/operador", Ref la_Data) Then
		as_Erro = "Retrieve tag operador (null)"
		Return False
	End If
	
	st_Qtd.Operador[ll_Linha_Qtd] = String(la_Data)
	
	is_Tipo_Operador = String(la_Data)
	
	la_Data = ia_Null
	
	If Not io_json.retrieve(as_Caminho + String(ll_Linha) + "/desconto", Ref la_Data) Then
		as_Erro = "Retrieve tag desconto (null) no grupo quantidades"
		Return False
	End If
	
	st_Qtd.Desconto[ll_Linha_Qtd] = Double(la_Data)
	
	idc_Vl_Desc_Prog = Double(la_Data)
	
	la_Data = ia_Null
	
	If Not This.of_Atualiza_Tabela_Log_Desc_Progressivo(st_Qtd.Codigoproduto[ll_Linha_Qtd], st_Qtd.Quantidade[ll_Linha_Qtd], st_Qtd.Operador[ll_Linha_Qtd], st_Qtd.Desconto[ll_Linha_Qtd], as_Msg_Produto, Ref as_erro) Then
		io_Comum.of_envia_email(as_Erro)
		Return False
	End If
Next

Return True
end function

public function boolean of_autenticacao (ref string as_json_retorno, ref string as_erro);String ls_Json_Envio
String ls_Terminal = "PDV_CLAMED"

SetNull(as_Json_Retorno)

If Not io_Comum.of_busca_url("CONSULTAR", Ref io_Comum.is_Url, Ref as_Erro) Then Return False
			 
ls_Json_Envio = "{" + &
					 '"cnpj": "' + io_Comum.is_Cnpj_Login + '", ' + &
					 '"idTerminal": "' + ls_Terminal + '", ' + &
					 '"nsuReq": "' + String(io_Comum.il_Seq_Consulta) + '"' + &
					 "}"
	
If Not io_Comum.of_post( ls_json_Envio, "", ref as_Json_Retorno, ref as_Erro ) Then Return False

Return True
end function

public function boolean of_localiza_produto (ref string as_mensagem, ref string as_erro);Long ll_Find

String ls_Cod_Barras_Aux

as_Mensagem = ""

ll_Find = ids_EAN.Find("de_codigo_barras = '" + is_Codigo_Barras + "'", 1, ids_EAN.RowCount())

If ll_Find < 0 Then
	as_Erro = "Erro no Find do EAN [" + is_Codigo_Barras + "]. Fun$$HEX2$$e700e300$$ENDHEX$$o of_Localiza_Produto"
	Return False
End If

If ll_Find = 0 Then
	ls_Cod_Barras_Aux = gf_Tira_Zero_Esquerda(is_Codigo_Barras)
	
	//Se removeu os zeros a esquerda, tenta localizar sem os zeros a esquerda
	If LenA(ls_Cod_Barras_Aux) < LenA(is_Codigo_Barras) Then		
		
		ll_Find = ids_EAN.Find("de_codigo_barras = '" + ls_Cod_Barras_Aux + "'", 1, ids_EAN.RowCount())
	
		If ll_Find < 0 Then
			as_Erro = "Erro no Find do EAN [" + ls_Cod_Barras_Aux + "]. Fun$$HEX2$$e700e300$$ENDHEX$$o of_Localiza_Produto"
			Return False
		End If
		
		If ll_Find = 0 Then
			as_Mensagem = "EAN [" + ls_Cod_Barras_Aux + "] N$$HEX1$$c300$$ENDHEX$$O LOCALIZADO NO CADASTRO DE PRODUTO"
		Else
			is_Codigo_Barras = ls_Cod_Barras_Aux
		End If
		
	Else
		as_Mensagem = "EAN [" + is_Codigo_Barras + "] N$$HEX1$$c300$$ENDHEX$$O LOCALIZADO NO CADASTRO DE PRODUTO"
	End If
End If

Return True
end function

public function boolean of_carrega_canal_venda (any aa_canais[], string as_caminho, ref string as_erro);Any la_Data

Long ll_Linha
Long ll_Linhas

//A carga ser$$HEX1$$e100$$ENDHEX$$ executada somente para canal de venda PDV ou se o canal venda for vazio/nulo

ib_Proce_Campanha = False
is_Canal_Venda = "TD"

ll_Linhas = UpperBound(aa_Canais)

If ll_Linhas = 0 Then
	ib_Proce_Campanha = True
	Return True
End If

//Campanha
For ll_Linha = 1 To ll_Linhas
	
	il_Tipo_Log = 1

	If Not io_json.retrieve(as_Caminho + String(ll_Linha) + "/canalVenda", Ref la_Data) Then
		as_Erro = "Retrieve tag canalVenda (null)"
		Return False
	End If
	
	If IsNull(la_Data) Or String(la_Data) = "" Or String(la_Data) = "01" Then
		If String(la_Data) = "01" Then
			is_Canal_Venda = "01"
		End If
		
		ib_Proce_Campanha = True
		Return True
	End If
Next

Return True
end function

on uo_ge536_dermaclub_carga.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge536_dermaclub_carga.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

