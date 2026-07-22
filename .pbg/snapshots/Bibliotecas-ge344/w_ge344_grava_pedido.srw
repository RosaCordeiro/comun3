HA$PBExportHeader$w_ge344_grava_pedido.srw
forward
global type w_ge344_grava_pedido from dc_w_response_ok_cancela
end type
type dw_2 from dc_uo_dw_base within w_ge344_grava_pedido
end type
type cb_1 from commandbutton within w_ge344_grava_pedido
end type
type gb_2 from groupbox within w_ge344_grava_pedido
end type
end forward

global type w_ge344_grava_pedido from dc_w_response_ok_cancela
integer width = 2583
integer height = 1860
string title = "GE344 - Grava Pedido Almoxarifado"
dw_2 dw_2
cb_1 cb_1
gb_2 gb_2
end type
global w_ge344_grava_pedido w_ge344_grava_pedido

type variables
uo_filial io_Filial

Boolean ivb_Check
Boolean ib_Possui_Pedido = False

String is_Tipo
end variables

forward prototypes
public function boolean wf_le_dados_planilha ()
public function boolean wf_verifica_resumo_reposicao_estoque (long al_filial, long al_produto, ref long al_achou)
public function boolean wf_grava_cabecalho_pedido (long al_filial, long al_pedido, ref string as_erro)
public function boolean wf_verifica_ultimo_pedido (long al_filial, ref long al_pedido, string as_tipo)
public function boolean wf_verifica_contato_entrega (long al_filial, ref string as_contato)
public function boolean wf_grava_item_pedido (long al_filial, long al_pedido, long al_produto[], long al_qt_pedida[], string as_atualiza[], ref string as_erro)
public function boolean wf_verifica_dados_filial ()
public function boolean wf_verifica_filial_nova (long al_filial)
public function boolean wf_nome_responsavel (ref string as_nome_responsavel)
public function boolean wf_preenche_custo_unitario (long al_produto, ref decimal ad_custo_unitario)
public function boolean wf_localiza_filial (long al_filial, ref string as_nome_fantasia, ref string as_uf_filial)
public function boolean wf_localiza_produto (long al_produto, ref string as_descricao, ref decimal adc_fat_conv, ref string as_uf_produto)
end prototypes

public function boolean wf_le_dados_planilha ();Any la_Dado
Any la_Nulo

Decimal ldc_Custo_Unit
Decimal ldc_Fat_Conv

Long ll_Linha
Long ll_Linhas
Long ll_Produto
Long ll_Qtd_Prod
Long ll_Achou
Long ll_Find
Long ll_Linha_Dw = 0
Long ll_Filial
Long ll_Nulo

String ls_Arquivo
String ls_Descricao_Prod
String ls_Coluna = "A"
String ls_Nome_Fantasia
String ls_UF_Produto
String ls_UF_Filial
String ls_UF_Divergente = "N"

Try

	dc_uo_excel lo_Excel
	lo_Excel = Create dc_uo_excel
	
	ls_Arquivo = dw_1.Object.De_Arquivo[1]
	
	Open(w_Aguarde)
	w_Aguarde.Title = "Importando o arquivo: " + ls_Arquivo + "..."
	
	SetNull(la_Nulo)
	
	SetRedraw(False)
	
	/* Pedido Inicial - Coluna A: C$$HEX1$$f300$$ENDHEX$$digo Produto, B: Qtd Pedida
			Pedido Empurrado - Coluna A: C$$HEX1$$f300$$ENDHEX$$digo Filial, B: C$$HEX1$$f300$$ENDHEX$$digo Produto, Qtd Pedida */
			 
	If is_Tipo = "I" Then
		ll_Filial = dw_1.Object.Cd_Filial[1]
	End If
	
	// Refer$$HEX1$$ea00$$ENDHEX$$ncia o arquivo 
	If ( lo_Excel.uo_Referencia_Objeto_Excel(ls_Arquivo) ) Then
		
		ll_Linhas = lo_Excel.uo_Verifica_Tamanho_Arquivo(ls_Coluna) 
		
		If ll_Linhas > 0 Then
			w_Aguarde.uo_Progress.of_SetMax(ll_Linhas)
			
			For ll_Linha = 1 To ll_Linhas
				
				ls_Coluna = "A"
				
				If is_Tipo = "E" Or Is_Tipo = "A" Then
					
					//C$$HEX1$$f300$$ENDHEX$$digo da filial
					la_Dado = lo_Excel.uo_Lendo_Dados(ll_Linha, ls_Coluna)
					
					If Not IsNumber(String(la_Dado)) Or IsNull(String(la_Dado)) Then
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "C$$HEX1$$f300$$ENDHEX$$digo da filial $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido na linha '" + String(ll_Linha) + "'. ~rN$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ inclu$$HEX1$$ed00$$ENDHEX$$do na lista.", Exclamation!)
						Continue
					End If	
					
					ll_Filial = Long(la_Dado)
					
					If Not wf_Localiza_Filial(ll_Filial, Ref ls_Nome_Fantasia, Ref ls_UF_Filial) Then Return False
					
					ls_Coluna = "B"
				End If
				
				//C$$HEX1$$f300$$ENDHEX$$digo do produto
				la_Dado = lo_Excel.uo_Lendo_Dados(ll_Linha, ls_Coluna)
				
				If Not IsNumber(String(la_Dado)) Or IsNull(String(la_Dado)) Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "C$$HEX1$$f300$$ENDHEX$$digo do produto $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido na linha '" + String(ll_Linha) + "'. ~rN$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ inclu$$HEX1$$ed00$$ENDHEX$$do na lista.", Exclamation!)
					Continue
				End If
				
				If is_Tipo = "I" Then
				
					ll_Find = dw_2.Find("cd_produto = " + String(Long(la_Dado)), 1, dw_2.RowCount())
					
					If ll_Find > 0 Then
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto '" + String(la_Dado) + "' foi informado mais de uma vez na planilha." + &
										"~rSomente o primeiro registro ser$$HEX1$$e100$$ENDHEX$$ considerado.", Exclamation!)
						Continue
					End If
				Else

					ll_Find = dw_2.Find("cd_produto = " + String(Long(la_Dado)) + " and cd_filial = " + String(ll_Filial), 1, dw_2.RowCount())
					
					If ll_Find > 0 Then
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto '" + String(la_Dado) + "' foi informado mais de uma vez na planilha para a filial '" + String(ll_Filial) + "'." + &
										"~rSomente o primeiro registro ser$$HEX1$$e100$$ENDHEX$$ considerado.", Exclamation!)
						Continue
					End If
				End If
				
				ll_Produto = Long(la_Dado)
				
				If Not wf_Localiza_Produto(ll_Produto, Ref ls_Descricao_Prod, Ref ldc_Fat_Conv, Ref ls_UF_Produto) Then Return False
				
				//Produto n$$HEX1$$e300$$ENDHEX$$o localizado
				If ls_Descricao_Prod = "X" Then
					Continue
				End If
				
				If is_Tipo = "E" Or is_Tipo = "A" Then
					ls_Coluna = "C"
				Else
					ls_Coluna = "B"
				End If
				
				//Quantidade pedida do produto
				la_Dado = lo_Excel.uo_Lendo_Dados(ll_Linha, ls_Coluna)
						
				If Not IsNumber(String(la_Dado)) Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Quantidade pedida do produto $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lida na linha '" + String(ll_Linha) + "'. ~rSer$$HEX1$$e100$$ENDHEX$$ inclu$$HEX1$$ed00$$ENDHEX$$do na lista com quantidade nula.")
					la_Dado = la_Nulo
				End If
				
				ll_Qtd_Prod = Long(la_Dado)
				
				If Not wf_Preenche_Custo_Unitario(ll_Produto, Ref ldc_Custo_Unit) Then Return False
				
				If Not wf_Verifica_Resumo_Reposicao_Estoque(ll_Filial, ll_Produto, Ref ll_Achou) Then Return False
				
				ll_Linha_Dw++
				
				//Se achou na resumo_reposicao_estoque
				If ll_Achou = 0 Then
					dw_2.Object.Id_Divergencia[ll_Linha_Dw] = 1
					dw_2.Object.Id_Selecionado[ll_Linha_Dw] = "N"
				Else
					dw_2.Object.Id_Divergencia[ll_Linha_Dw] = 0
					dw_2.Object.Id_Selecionado[ll_Linha_Dw] = "S"
				End If
								
				dw_2.Object.Cd_Filial			[ll_Linha_Dw] = ll_Filial
				dw_2.Object.Nm_Fantasia	[ll_Linha_Dw] = ls_Nome_Fantasia
					
				If is_Tipo = "E" Then					
					If (ls_UF_Produto <> ls_UF_Filial) Or (IsNull(ls_UF_Produto) Or ls_UF_Produto = "") Then
						dw_2.Object.Id_UF_Divergente[ll_Linha_Dw] = 1
						ls_UF_Divergente = "S"
						dw_2.Object.Id_Selecionado[ll_Linha_Dw] = "N"
					End If
				End If
				
				dw_2.Object.Cd_Produto				[ll_Linha_Dw] = ll_Produto
				dw_2.Object.De_Produto				[ll_Linha_Dw] = ls_Descricao_Prod
				dw_2.Object.Qtd_Produto			[ll_Linha_Dw] = ll_Qtd_Prod
				dw_2.Object.Vl_Custo				[ll_Linha_Dw] = ldc_Custo_Unit
				dw_2.Object.Vl_Fator_Conversao	[ll_Linha_Dw] = Long(ldc_Fat_Conv)
				dw_2.Object.Cd_UF_Produto		[ll_Linha_Dw] = ls_UF_Produto
				dw_2.Object.Cd_UF_Filial			[ll_Linha_Dw] = ls_UF_Filial
				dw_2.Object.Id_Tipo_Pedido		[ll_Linha_Dw] = is_Tipo
			Next
			
			If dw_2.RowCount() > 0 Then
				cb_Ok.Enabled = True
			End If
		End If
	End If

	SetRedraw(True)
	
	dw_2.SetFocus()
	dw_2.Sort()
	dw_2.GroupCalc()
	
	dw_2.of_SetRowSelection( "if(id_uf_divergente > 0,  if(getrow() = currentrow(), rgb(255, 0, 0), rgb(255,255,255)),  if(getrow() = currentrow(), rgb(0,128,128), rgb(255, 255, 255)) )", "if( id_uf_divergente > 0, RGB(255,0, 0), RGB(0,0,0))",   False )
	
	Return True

Finally
	Close(w_Aguarde)
	If IsValid(lo_Excel) Then Destroy(lo_Excel)
	
	If is_Tipo = "E" Then
		If ls_UF_Divergente = "S" Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existem produtos com diverg$$HEX1$$ea00$$ENDHEX$$ncia entre U.F. do produto e U.F. da filial ou U.F. do produto n$$HEX1$$e300$$ENDHEX$$o cadastrada.")
		End If
	End If
End Try
end function

public function boolean wf_verifica_resumo_reposicao_estoque (long al_filial, long al_produto, ref long al_achou);Long ll_Mix

Select cd_mix_produto
	Into :ll_Mix
From produto_central
Where cd_produto = :al_Produto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		//O Mix 2 $$HEX1$$e900$$ENDHEX$$ [SOMENTE ENCOMENDA]. Se for este Mix n$$HEX1$$e300$$ENDHEX$$o passa na valida$$HEX2$$e700e300$$ENDHEX$$o abaixo, o produto n$$HEX1$$e300$$ENDHEX$$o necessariamente precisa estar no mix da loja.
		If ll_Mix = 2 Then
			al_Achou = 1
			Return True
		End If
		
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizado o produto '" + String(al_Produto) + "' na tabela PRODUTO_CENTRAL.")
		Return False
		
	Case -1
		SqlCa.of_MsgdbError("Erro ao localizar o mix do produto")
		Return False
End Choose

Select Count(*)
	Into :al_Achou
From resumo_reposicao_estoque
Where cd_filial		= :al_Filial
	And cd_produto= :al_Produto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		Return True
		
	Case -1
		SqlCa.of_MsgdbError("Erro ao localizar o produto na RESUMO_REPOSICAO_ESTOQUE")
		Return False
End Choose
end function

public function boolean wf_grava_cabecalho_pedido (long al_filial, long al_pedido, ref string as_erro);DateTime ldh_Emissao
DateTime ldh_Atual

String ls_Contato
String ls_Nulo

as_Erro = ""

If Not ib_Possui_Pedido Then

	SetNull(ls_Nulo)
	
	If Not gf_Data_Parametro(Ref ldh_Emissao) Then Return False
	
	ldh_Atual = gf_GetServerDate()
	
	If is_Tipo = "I" Then
		If Not wf_Verifica_Contato_Entrega(al_Filial, Ref ls_Contato) Then Return False
	End If
	
	If ls_Contato = "" Then
		ls_Contato = ls_Nulo
	End If

	Insert Into pedido_almoxarifado(cd_filial, nr_pedido, dh_emissao, id_situacao, nr_matricula_cadastramento, dh_inclusao, id_tipo_pedido, vl_total_pedido, de_dados_adicionais)
									Values(:al_filial, :al_pedido, :ldh_Emissao, 'C', :gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, :ldh_Atual, :is_Tipo, 0.00, :ls_Contato)
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		as_Erro = "Erro ao gravar o cabe$$HEX1$$e700$$ENDHEX$$alho do pedido." +  SqlCa.SqlErrText
		Return False
	End If
End If

Return True
end function

public function boolean wf_verifica_ultimo_pedido (long al_filial, ref long al_pedido, string as_tipo);Long ll_Achou

Select Count(*)
	Into :ll_Achou
From pedido_almoxarifado
Where cd_filial = :al_Filial
	And nr_pedido >= 30000
	And id_situacao = 'C'
	And dh_emissao >= dateadd(day, -5, getdate())
	and id_tipo_pedido = :as_tipo
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Erro ao consultar se j$$HEX1$$e100$$ENDHEX$$ existe um pedido colocado 'COLOCADO'." + SqlCa.SqlErrText)
	Return False
End If

If ll_Achou > 0 Then
	Select Max(nr_pedido)
		Into :al_pedido
	From pedido_almoxarifado
	Where cd_filial = :al_Filial
		And nr_pedido >= 30000
		And id_situacao = 'C'
		And dh_emissao >= dateadd(day, -5, getdate())
		and id_tipo_pedido = :as_tipo
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgdbError("Erro ao consultar o n$$HEX1$$fa00$$ENDHEX$$mero do pedido j$$HEX1$$e100$$ENDHEX$$ existente com situa$$HEX2$$e700e300$$ENDHEX$$o 'COLOCADO'." + SqlCa.SqlErrText)
		Return False
	End If

	ib_Possui_Pedido = True
	Return True
End If

Select coalesce(max(nr_pedido), 29999) + 1
	Into :al_Pedido
From pedido_almoxarifado
Where cd_filial =:al_Filial
	And nr_pedido >= 30000
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Erro ao consultar o $$HEX1$$fa00$$ENDHEX$$ltimo pedido da filial" + SqlCa.SqlErrText)
	Return False
End If

Return True
end function

public function boolean wf_verifica_contato_entrega (long al_filial, ref string as_contato);Long ll_Pos

String ls_Vl_Parametro

as_Contato = ""

Select vl_parametro
	Into :ls_Vl_Parametro
From parametro_loja
Where cd_filial = :al_Filial
	And cd_parametro = 'DE_CONTATO_ENTREGA_PEDIDO_ALMOXARIFADO'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If ls_Vl_Parametro <> "X" Then
			ll_Pos = PosA(ls_Vl_Parametro, "/")
			as_Contato = "Contato para o recebimento: "
			as_Contato += MidA(ls_Vl_Parametro, 1, ll_Pos - 1)
			as_Contato += " /Fone: "
			as_Contato += MidA(ls_Vl_Parametro, ll_Pos+ 1)
		End If
		
	Case -1
		SqlCa.of_MsgdbError("Erro ao localizar o parametro 'DE_CONTATO_ENTREGA_PEDIDO_ALMOXARIFADO'." + SqlCa.SqlErrText)
		Return False
End Choose
end function

public function boolean wf_grava_item_pedido (long al_filial, long al_pedido, long al_produto[], long al_qt_pedida[], string as_atualiza[], ref string as_erro);Long ll_Linha, ll_Produto, ll_Qtde, ll_Achou, ll_Qtd_Selec

ll_Qtd_Selec = 0

as_Erro = ""

For ll_Linha = 1 To UpperBound(al_produto[])
	
	If as_Atualiza[ll_Linha] = "N" Then Continue
	
	ll_Qtd_Selec++
	
	ll_Produto 	= al_produto[ll_Linha]
	ll_Qtde		= al_qt_pedida[ll_Linha]
	
	Select cd_produto
		Into :ll_Achou
	From pedido_almoxarifado_produto
	Where cd_filial = :al_Filial
		And nr_pedido = :al_Pedido
		And cd_produto = :ll_Produto
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			
		Case 100
			Insert Into pedido_almoxarifado_produto(cd_filial, nr_pedido, cd_produto, qt_pedida, qt_atendida, qt_separada, qt_faturada)
														Values(:al_filial, :al_pedido, :ll_Produto, :ll_Qtde, 0, 0, 0)
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				as_Erro = "Erro ao inserir o item no pedido." + SqlCa.SqlErrText
				Return False
			End If
			
		Case -1
			SqlCa.of_MsgdbError("Erro ao incluir o produto no pedido." + SqlCa.SqlErrText)
			Return False
	End Choose
Next

//Se n$$HEX1$$e300$$ENDHEX$$o tem nenhum produto para atualizar faz o RollBack() para deletar o cabe$$HEX1$$e700$$ENDHEX$$alho
If ll_Qtd_Selec = 0 Then
	SqlCa.of_RollBack();
End If

Return True
end function

public function boolean wf_verifica_dados_filial ();DateTime ldh_Emissao

String ls_Mensagem
String ls_Anexo[]
String ls_Nome_Reponsavel
String ls_Email_Regional
String ls_Cnpj
String ls_Inscricao_Estadual
String ls_Mid

//S$$HEX1$$f300$$ENDHEX$$ valida se o banco for o Central
If gvo_Aplicacao.ivs_DataSource <> 'central' Then Return True

If Not gf_Data_Parametro(Ref ldh_Emissao) Then Return False

ls_Mensagem = "Filial: " + io_Filial.Nm_Fantasia + " (" + String(io_Filial.Cd_Filial) + ")" + "<br><br>"
ls_Mensagem += "Data: " + String(gf_GetServerDate()) + "<br><br>"
ls_Mensagem += "Gera$$HEX2$$e700e300$$ENDHEX$$o do Pedido Inicial do Almoxarifado: '" + String(ldh_Emissao, "dd/mm/yyyy") + "'<br><br>"

ls_Cnpj = gf_Replace(io_Filial.Nr_Cgc, ".", "", 0)

If Not gf_Cgc_Valido(ls_Cnpj, False) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "CNPJ '" + io_Filial.Nr_Cgc + "' inv$$HEX1$$e100$$ENDHEX$$lido.", StopSign!)
	Return False
End If

ls_Inscricao_Estadual = gf_Replace(io_Filial.Nr_Inscricao_Estadual, ".", "", 0)

ls_Mid = MidA(ls_Inscricao_Estadual, 1, 5)

If (Trim(ls_Inscricao_Estadual) = "" Or IsNull(ls_Inscricao_Estadual)) Or (ls_Mid = "99999" Or ls_Mid = "00000" Or ls_Mid = "09999" Or ls_Mid = "O9999") Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Inscri$$HEX2$$e700e300$$ENDHEX$$o Estadual '" + io_Filial.Nr_Inscricao_Estadual + "' inv$$HEX1$$e100$$ENDHEX$$lida.", StopSign!)
	Return False
End If

If Not wf_Nome_Responsavel(Ref ls_Nome_Reponsavel) Then Return False

ls_Mensagem += "Respons$$HEX1$$e100$$ENDHEX$$vel: '" + ls_Nome_Reponsavel + "' (" + gvo_Aplicacao.ivo_Seguranca.Nr_Matricula + ")'"

//Monta a estrutura para enviar o e-mail
s_email str
	
Select u.de_endereco_email
	Into :ls_Email_Regional
From filial f
	Inner Join regiao r
		On r.cd_regiao = f.cd_regiao
	Inner join usuario u
		On u.nr_matricula = r.nr_matricula_regional
Where f.cd_filial = :io_Filial.Cd_Filial
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
				
		str.ps_mensagem = ls_Mensagem
		str.ps_cc[1] = ls_Email_Regional
		str.pb_assinatura = True
				
		gf_ge202_envia_email_padrao(50, str)
		
		ls_Mensagem += '<br><br><br><br>' + "E-MAIL ENVIADO SOMENTE PARA A FILIAL."
		
		str.ps_mensagem = ls_Mensagem
		str.ps_cc[1] = String(io_Filial.Cd_Filial, "0000") + '@drogarialocal.com.br'
	
		//E-mail enviado separado para a filial com c$$HEX1$$f300$$ENDHEX$$pia para os contatos do c$$HEX1$$f300$$ENDHEX$$digo 70
		gf_ge202_envia_email_padrao(70, str)
	
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizado o gerente regional da loja. '" + String(io_Filial.Cd_Filial) + "'.", StopSign!)
		Return False
		
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o gerente regional. " + SqlCa.SQLErrText, StopSign!)
		Return False
End Choose

Return True
end function

public function boolean wf_verifica_filial_nova (long al_filial);Long ll_Loja_Nova
Long ll_Ultimo_Pedido

Select count(*)
	Into :ll_Loja_Nova
From resumo_movimento_estoque r
	Inner Join filial f
 		On f.cd_filial = r.cd_filial
Where r.dh_resumo >= coalesce(f.dh_reinauguracao, cast('1900/01/01' as date))
	And r.cd_filial = :al_Filial
	And r.vl_venda_avista > 100.00
 Using SqlCa;
 
 If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Erro na consulta do movimento da loja." + SqlCa.SqlErrText)
	Return False
 End If
 
Select coalesce(max(nr_pedido), 0)
	Into :ll_Ultimo_Pedido
From pedido_almoxarifado
Where cd_filial = :al_Filial
	And nr_pedido < 30000
Using SqlCa;

 If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Erro ao consultar se a loja j$$HEX1$$e100$$ENDHEX$$ possui pedido." + SqlCa.SqlErrText)
	Return False
 End If

If ll_Loja_Nova = 0 And ll_Ultimo_Pedido > 0 Then
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Esta filial $$HEX1$$e900$$ENDHEX$$ nova e j$$HEX1$$e100$$ENDHEX$$ possui pedido. Deseja continuar mesmo assim?", Question!, YesNo!, 2) = 2 Then
		Return False
	End If
End If

 If ll_Loja_Nova > 0 Then
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Esta filial N$$HEX1$$c300$$ENDHEX$$O $$HEX1$$e900$$ENDHEX$$ nova. Deseja continuar mesmo assim?", Question!, YesNo!, 2) = 2 Then
		Return False
	End If
 End If

Return True
end function

public function boolean wf_nome_responsavel (ref string as_nome_responsavel);select nm_usuario
Into :as_Nome_Responsavel
From usuario
Where nr_matricula = :gvo_Aplicacao.ivo_Seguranca.Nr_Matricula
Using SqlCa;

If SqlCa.Sqlcode = -1 Then
	SqlCa.of_MsgDbError("Erro ao localizar o nome do usu$$HEX1$$e100$$ENDHEX$$rio.")
	Return False
End If

Return True
end function

public function boolean wf_preenche_custo_unitario (long al_produto, ref decimal ad_custo_unitario);Select Coalesce(vl_custo_gerencial, 0)
	Into :ad_custo_unitario
From vw_saldo_atual_produto
Where cd_filial = 534
   And cd_produto = :al_Produto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		Return True
		
	Case 100
		ad_custo_unitario = 0
		
	Case -1
		SqlCa.of_MsgdbError("Erro ao localizado custo unit$$HEX1$$e100$$ENDHEX$$rio do produto na vw_saldo_atual_produto")
		Return False
		
End Choose
end function

public function boolean wf_localiza_filial (long al_filial, ref string as_nome_fantasia, ref string as_uf_filial);Select nm_fantasia, cd_uf
	Into :as_Nome_Fantasia, :as_UF_Filial
From vw_filial
Where cd_filial = :al_Filial
	And cd_filial Not In(534)
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "C$$HEX1$$f300$$ENDHEX$$digo da filial '" + String(al_Filial) + "' $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido ou inativo.", Exclamation!)
		as_Nome_Fantasia = "X"
		
	Case -1
		SqlCa.of_MsgdbError("Erro ao localizar o nome da filial")
		Return False
End Choose

Return True
end function

public function boolean wf_localiza_produto (long al_produto, ref string as_descricao, ref decimal adc_fat_conv, ref string as_uf_produto);String ls_Descricao
String ls_Apresentacao_Estoque
String ls_Grupo

Select g.de_produto, g.de_apresentacao_estoque, substring(g.cd_subcategoria, 1, 1), g.vl_fator_conversao, c.cd_uf_encarte
Into :ls_Descricao, :ls_Apresentacao_Estoque, :ls_Grupo, :adc_Fat_Conv, :as_Uf_Produto
From produto_geral g
	Inner Join produto_central c
		On c.cd_produto = g.cd_produto
Where g.cd_produto = :al_produto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		as_Descricao = ls_Descricao + " : " + ls_Apresentacao_Estoque
		
		If ls_Grupo <> '5' Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produto '" + as_Descricao + "' c$$HEX1$$f300$$ENDHEX$$digo '" + String(al_Produto) + "' n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ almoxarifado.", Exclamation!)
			as_Descricao = "X"
		End If
		
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produto '" + String(al_Produto) + "' n$$HEX1$$e300$$ENDHEX$$o localizado.", Exclamation!)
		as_Descricao = "X"
		
	Case -1
		SqlCa.of_MsgdbError("Erro ao localizar o produto na tabela PRODUTO_GERAL na fun$$HEX2$$e700e300$$ENDHEX$$o wf_localiza_produto")
		Return False
End Choose

Return True
end function

on w_ge344_grava_pedido.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.cb_1=create cb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.gb_2
end on

on w_ge344_grava_pedido.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.cb_1)
destroy(this.gb_2)
end on

event open;call super::open;is_Tipo = Message.StringParm

io_Filial = Create uo_filial
end event

event ue_postopen;call super::ue_postopen;If is_Tipo = "E" Or is_Tipo = "A" Then
	dw_1.Object.Cd_Filial.Visible = False
	dw_1.Object.Nm_Filial.Visible = False
	dw_1.Object.Nm_Filial_t.Visible = False
End If

If is_Tipo <> "E" Then
	dw_2.Object.T_3.Visible = False
	dw_2.Object.T_4.Visible = False
End If

Choose Case is_Tipo
	Case "A"
		This.Title = "GE344 - Grava Pedido Almoxarifado"
	Case "E"
		This.Title = "GE344 - Grava Pedido Empurrado - ENCARTE"
	Case "I"
		This.Title = "GE344 - Grava Pedido Inicial"
End Choose

dw_2.of_SetRowSelection()

dw_1.SetFocus()
end event

event close;call super::close;Destroy(io_Filial)
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge344_grava_pedido
integer x = 0
integer y = 112
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge344_grava_pedido
integer width = 2281
integer height = 260
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge344_grava_pedido
integer width = 2213
integer height = 168
string dataobject = "dw_ge344_selecao_response"
end type

event dw_1::itemchanged;call super::itemchanged;dw_2.Event ue_Reset()

If dwo.Name = "nm_filial" Then
	If Not IsNull(Data) And Trim(Data) <> "" Then
		If Data <> io_Filial.Nm_Fantasia Then
			Return 1
		End If
	Else
		io_Filial.of_Inicializa()
		
		This.Object.Cd_Filial		[1] = io_Filial.Cd_Filial
		This.Object.Nm_Filial		[1] = io_Filial.Nm_Fantasia
	End If
End If
end event

event dw_1::editchanged;call super::editchanged;dw_2.Event ue_Reset()

If dwo.Name = "nm_filial" Then
	If Not IsNull(Data) And Trim(Data) <> "" Then
		If Data <> io_Filial.Nm_Fantasia Then
			Return 1
		End If
	Else
		io_Filial.of_Inicializa()
		
		This.Object.Cd_Filial		[1] = io_Filial.Cd_Filial
		This.Object.Nm_Filial		[1] = io_Filial.Nm_Fantasia
	End If
End If
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	If This.GetColumnName() = "nm_filial" Then
		io_Filial.of_Localiza_Filial(This.GetText())
		
		If Not io_Filial.Localizada Then
			io_Filial.of_Inicializa()
		End If
		
		This.Object.Cd_Filial		[1]	= io_Filial.Cd_Filial
		This.Object.Nm_Filial		[1]	= io_Filial.Nm_Fantasia
	End If
End If
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge344_grava_pedido
integer x = 1710
integer y = 1648
integer width = 462
boolean enabled = false
string text = "Gravar Pedido"
end type

event cb_ok::clicked;call super::clicked;Integer li_resposta

Boolean lb_Sucesso = True
Boolean lb_Alteracao = False

Long ll_Find
Long ll_Filial
Long ll_Pedido
Long ll_Linha
Long ll_Fator
Long ll_Qtd_Pedida
Long ll_Produto
Long ll_Nulo
Long ll_Array_Nulo[]
Long ll_Filial_Array[]
Long ll_Contador
Long ll_Filial_Proxima
Long ll_Filial_Produto[]
Long ll_Filial_Qtde[]

String ls_Erro
String ls_Selecionado
String ls_Atualiza[]
String ls_Array_Nulo[]
String ls_msg

dw_1.AcceptText()
dw_2.AcceptText()

SetNull(ll_Nulo)

ll_Find = dw_2.Find("id_selecionado = 'S'", 1, dw_2.RowCount())

If ll_Find < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Find da dw_2 no campo id_selecionado.", StopSign!)
	Return -1
End If

If ll_Find = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum produto foi selecionado.")
	dw_2.SetFocus()
	Return -1
End If

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a gera$$HEX2$$e700e300$$ENDHEX$$o do pedido?", Question!, YesNo!, 2) = 2 Then
	Return -1
End If

ll_Find = 0

ll_Find = dw_2.Find("IsNull(qtd_produto)", 1, dw_2.RowCount())

If ll_Find < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Find da dw_2 no campo qtd_produto.", StopSign!)
	Return -1
End If

If ll_Find > 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a quantidade pedida do produto.")
	dw_2.Event ue_Pos(ll_Find, "qtd_produto")
	Return -1
End If

If is_Tipo = "I" Then
	ll_Filial = dw_1.Object.Cd_Filial[1]
	
	If IsNull(ll_Filial) Or ll_Filial = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a filial.")
		dw_1.Event ue_Pos(1, "nm_filial")
		Return -1
	End If
	
	If Not wf_Verifica_Filial_Nova(ll_Filial) Then Return -1
	
	If Not wf_Verifica_Dados_Filial() Then Return -1
End If

For ll_Linha = 1 To dw_2.RowCount()
	
	lb_Alteracao = False
	ib_Possui_Pedido = False
		
	ll_Contador ++
	
	ll_Qtd_Pedida	= dw_2.Object.Qtd_Produto				[ll_Linha]
	ll_Fator			= dw_2.Object.Vl_Fator_Conversao	[ll_Linha]
	ll_Produto		= dw_2.Object.Cd_Produto				[ll_Linha]
	ls_Selecionado	= dw_2.Object.Id_Selecionado			[ll_Linha]
	
	If ls_Selecionado = "N" Then
		ls_Atualiza[ll_Contador] = "N"
	Else
		ls_Atualiza[ll_Contador] = "S"
	End If
	
	If is_Tipo = "I" Then 
		If IsNull(ll_Filial) Then ll_Filial = dw_1.Object.Cd_Filial[1]
		
		ll_Filial_Proxima = ll_Filial
	Else
		ll_Filial = dw_2.Object.Cd_Filial[ll_Linha]
		
		If ( ll_Linha < dw_2.RowCount() ) Then
			ll_Filial_Proxima = dw_2.Object.Cd_Filial [ll_Linha + 1]
		End If
	End If
	
	If ll_Qtd_Pedida <= 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A quantidade pedida tem de ser maior que zero.")
		dw_2.Object.Qtd_Produto[ll_Linha] = ll_Nulo
		dw_2.Event ue_Pos(ll_Linha, "qtd_produto")
		lb_Sucesso = False
		Exit
	End If
	
	If ll_Fator > 1 Then	
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produtos almoxarifados com fator de convers$$HEX1$$e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o geram lista de separa$$HEX2$$e700e300$$ENDHEX$$o.", Exclamation!)
		ls_msg += "Deseja seguir com a opera$$HEX2$$e700e300$$ENDHEX$$o?~rSim = Continuar | N$$HEX1$$e300$$ENDHEX$$o = Cancelar"
		li_resposta = MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_msg, Question!, YesNo!, 2)
		
		If li_resposta = 2 Then
			Exit
		End if
		
	End if 	
	
	If Mod(ll_Qtd_Pedida, ll_Fator) <> 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A quantidade pedida '" + String(ll_Qtd_Pedida) + "' do produto '" + String(ll_Produto) + "' deve ser m$$HEX1$$fa00$$ENDHEX$$ltipla do fator de convers$$HEX1$$e300$$ENDHEX$$o '" + String(ll_Fator) + "' utilizado no Estoque Central.", Exclamation!)
	//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produtos almoxarifados com fator de convers$$HEX1$$e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o geram lista de separa$$HEX2$$e700e300$$ENDHEX$$o.", Exclamation!)		
		dw_2.Object.Qtd_Produto[ll_Linha] = ll_Nulo
		dw_2.Event ue_Pos(ll_Linha, "qtd_produto")
		lb_Sucesso = False
		Exit
	End If
	
	ll_Filial_Array	[ll_Contador] = ll_Filial
	ll_Filial_Produto[ll_Contador] = ll_Produto
	ll_Filial_Qtde	[ll_Contador] = ll_Qtd_Pedida
	
	If (ll_Filial <> ll_Filial_Proxima) Or (ll_Linha = dw_2.RowCount()) Then
				
		If Not wf_Verifica_Ultimo_Pedido(ll_Filial, Ref ll_Pedido, is_Tipo) Then Return -1
		
		If Not wf_Grava_Cabecalho_Pedido(ll_Filial, ll_Pedido, Ref ls_Erro) Then Return -1
		
		If wf_Grava_Item_Pedido(ll_Filial, ll_Pedido, ll_Filial_Produto[], ll_Filial_Qtde[], ls_Atualiza[], Ref ls_Erro) Then
			SqlCa.of_Commit();
			lb_Alteracao = True
		Else
			SqlCa.of_RollBack();
	
			If ls_Erro <> "" Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Erro, StopSign!)
			End If
		End If
		
		ll_Contador = 0
		ll_Filial_Array	[] = ll_Array_Nulo	[]
		ll_Filial_Produto[] = ll_Array_Nulo	[]
		ll_Filial_Qtde	[] = ll_Array_Nulo	[]
		ls_Atualiza		[] = ls_Array_Nulo	[]
	End If
Next
	
If lb_Sucesso And lb_Alteracao Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Pedido(s) gravado(s) com sucesso.")
	CloseWithReturn(Parent, "OK")
End If
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge344_grava_pedido
integer x = 2213
integer y = 1648
end type

type dw_2 from dc_uo_dw_base within w_ge344_grava_pedido
integer x = 37
integer y = 344
integer width = 2446
integer height = 1240
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge344_lista_planilha"
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.of_SetRowSelection()
end event

event doubleclicked;call super::doubleclicked;If dwo.Name = 'st_selecionado' Then
	
	Long lvl_Row
	
	String lvs_Marcacao
	
	If ivb_Check Then
		lvs_Marcacao = 'N'
		ivb_Check = False
	Else
		lvs_Marcacao = 'S'
		ivb_Check = True
	End If
	
	This.AcceptText()
	
	For lvl_Row = 1 To This.RowCount()
		
		If lvs_Marcacao = 'S' Then
			If This.Object.Id_Divergencia[lvl_Row] > 0 Or This.Object.Id_UF_Divergente[lvl_Row] > 0 Then
				Continue
			End If
		End If
		
		This.Object.Id_Selecionado[lvl_Row] = lvs_Marcacao
	Next
End If
end event

event itemchanged;call super::itemchanged;This.AcceptText()

String ls_Mensagem

Choose Case dwo.Name
	Case "id_selecionado"
		
		If This.RowCount() = 0 Then Return 1
		
		If is_Tipo = "E" Then //Encarte
			If Data = "S" Then
				If This.Object.Id_UF_Divergente[This.GetRow()] > 0 Then
					If Not IsNull(This.Object.Cd_UF_Produto[This.GetRow()]) Then
						ls_Mensagem = "A U.F. '" + This.Object.Cd_UF_Produto[This.GetRow()] + "' do produto '" + String(This.Object.Cd_Produto[This.GetRow()]) + "' $$HEX1$$e900$$ENDHEX$$ " + &
											"diferente da U.F. '" + This.Object.Cd_UF_Filial[This.GetRow()] + "' da filial '" + String(This.Object.Cd_Filial[This.GetRow()]) + "'." + &
											"~rDeseja inserir mesmo assim?"
														
					If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Mensagem, Question!, YesNo!, 2) = 2 Then Return 1
					
					Else
						
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "UF do produto '" + String(This.Object.Cd_Produto[This.GetRow()]) + "' n$$HEX1$$e300$$ENDHEX$$o cadastrada.")
						Return 1
					End If
				End If
			End If
		End If
End Choose
end event

type cb_1 from commandbutton within w_ge344_grava_pedido
integer x = 23
integer y = 1648
integer width = 507
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Importar Planilha"
end type

event clicked;Integer li_Retorno

Long ll_Filial

String ls_Arquivo
String ls_Nome
String ls_Nulo

dw_1.AcceptText()

If is_Tipo = "I" Then
	ll_Filial = dw_1.Object.Cd_Filial[1]
	
	If IsNull(ll_Filial) Or ll_Filial = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a filial.")
		dw_1.Event ue_Pos(1, "nm_filial")
		Return -1
	End If
End If

If dw_2.RowCount() > 0 Then
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A planilha j$$HEX1$$e100$$ENDHEX$$ foi importada. Deseja desfazer e import$$HEX1$$e100$$ENDHEX$$-la novamente?", Question!, YesNo!, 2) = 2 Then
		Return -1
	Else
		dw_2.Event ue_Reset()
	End If
End If

If is_Tipo = "I" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Os dados devem estar da seguinte forma:" + &
					"~rColuna A = C$$HEX1$$f300$$ENDHEX$$digo do produto" + &
					"~rColuna B = Quantidade pedida do produto")
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Os dados devem estar da seguinte forma:" + &
					"~rColuna A = C$$HEX1$$f300$$ENDHEX$$digo da filial" + &
					"~rColuna B = C$$HEX1$$f300$$ENDHEX$$digo do produto" + &
					"~rColuna C = Quantidade pedida do produto")
End If
				
li_Retorno = GetFileOpenName("Seleciona o arquivo", + ls_Arquivo, ls_Nome, "XLSX", "Excel 2007 (*.XLSX),*.XLSX, Excel (*.XLS), *.XLS")

If li_Retorno = 1 Then 
	dw_1.Object.De_Arquivo[1] = Upper(ls_Arquivo)
	
	If Not wf_Le_Dados_Planilha() Then Return -1
Else
	SetNull(ls_Nulo)
	dw_1.Object.De_Arquivo[1] = ls_Nulo
End If
end event

type gb_2 from groupbox within w_ge344_grava_pedido
integer x = 23
integer y = 288
integer width = 2501
integer height = 1328
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista"
borderstyle borderstyle = styleraised!
end type

