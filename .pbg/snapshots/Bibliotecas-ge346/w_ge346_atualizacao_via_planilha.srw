HA$PBExportHeader$w_ge346_atualizacao_via_planilha.srw
forward
global type w_ge346_atualizacao_via_planilha from dc_w_response_ok_cancela
end type
type cb_1 from commandbutton within w_ge346_atualizacao_via_planilha
end type
end forward

global type w_ge346_atualizacao_via_planilha from dc_w_response_ok_cancela
integer width = 2167
integer height = 464
string title = "GE346 - Importa$$HEX2$$e700e300$$ENDHEX$$o via Planilha"
cb_1 cb_1
end type
global w_ge346_atualizacao_via_planilha w_ge346_atualizacao_via_planilha

type variables
String is_Ret_Calc_EB
end variables

forward prototypes
public function long wf_le_dados_planilha (string as_arquivo)
public function boolean wf_valida_promocao (long al_promocao)
public function boolean wf_valida_produto (long al_produto)
public function boolean wf_atualiza (long al_promocao, long al_produto)
end prototypes

public function long wf_le_dados_planilha (string as_arquivo);Any la_Dado

Boolean lb_Altera

Integer li_Index

Long ll_Linha
Long ll_Linhas
Long ll_Sucesso = 1
Long ll_Promocao
Long ll_Produto
Long ll_Minimo

Try
	
	dc_uo_excel lo_Excel
	lo_Excel = Create dc_uo_excel
	
	Open(w_Aguarde)
	w_Aguarde.Title = "Atualizando dados..."
	
	// Refer$$HEX1$$ea00$$ENDHEX$$ncia o arquivo
	If ( lo_Excel.uo_Referencia_Objeto_Excel(as_Arquivo) ) Then
		// Coluna de Refer$$HEX1$$ea00$$ENDHEX$$ncia
		ll_Linhas = lo_Excel.uo_Verifica_Tamanho_Arquivo("A")
		
		If ll_Linhas > 0 Then
			w_Aguarde.uo_Progress.of_SetMax(ll_Linhas)
			
			For ll_Linha = 1 To ll_Linhas
				
				lb_Altera = True
				
				// Promo$$HEX2$$e700e300$$ENDHEX$$o
				la_Dado = lo_Excel.uo_Lendo_Dados(ll_Linha, "A")
										
				If (Not wf_Valida_Promocao(Long(la_Dado))) Or (Not IsNumber(String(la_Dado))) Then
					//Se for nulo atribui branco para mostrar a mensagem
					If IsNull(la_Dado) Then
						la_Dado = ""
					End If
					
					li_Index += 1
					gvs_Log[li_Index] = "Promo$$HEX2$$e700e300$$ENDHEX$$o '" + String(la_Dado) + "' n$$HEX1$$e300$$ENDHEX$$o localizada na linha '" + String(ll_Linha) + "'.~r~n"
					ll_Sucesso = 0
					lb_Altera = False
				End If
				
				ll_Promocao = Long(la_Dado)
						
				// Produto
				la_Dado = lo_Excel.uo_Lendo_Dados(ll_Linha, "B")
				
				If (Not wf_Valida_Produto(Long(la_Dado))) Or (Not IsNumber(String(la_Dado))) Then
					If IsNull(la_Dado) Then
						la_Dado = ""
					End If
					
					li_Index += 1
					gvs_Log[li_Index] = "Produto '" + String(la_Dado) + "' n$$HEX1$$e300$$ENDHEX$$o localizado na linha '" + String(ll_Linha) + "'.~r~n"
					ll_Sucesso = 0
					lb_Altera = False
				End If
				
				ll_Produto = Long(la_Dado)
				
				// Estoque M$$HEX1$$ed00$$ENDHEX$$nimo
//				la_Dado = lo_Excel.uo_Lendo_Dados(ll_Linha, "C")
//				
//				If Not IsNumber(String(la_Dado)) Then
//					If IsNull(la_Dado) Then
//						la_Dado = ""
//					End If
//					
//					li_Index += 1
//					gvs_Log[li_Index] = "Estoque M$$HEX1$$ed00$$ENDHEX$$nimo '" + String(la_Dado) + "' inv$$HEX1$$e100$$ENDHEX$$lido na linha '" + String(ll_Linha) + "'.~r~n"
//					ll_Sucesso = 0
//					lb_Altera = False
//				End If
//				
//				ll_Minimo = Long(la_Dado)
					
				If lb_Altera Then
					If Not wf_Atualiza(ll_Promocao, ll_Produto) Then Return -2
				End If
				
				w_Aguarde.uo_Progress.of_SetProgress(ll_Linha)
			Next
		Else
			ll_Sucesso = -1
		End If
	End If
	
	Return ll_Sucesso

Finally
	If IsValid(lo_Excel) Then Destroy(lo_Excel)
	Close(w_Aguarde)
End Try
end function

public function boolean wf_valida_promocao (long al_promocao);Long ll_Achou

String ls_Erro

If IsNull(al_Promocao) Then Return False

Select Count(*)
	Into: ll_Achou
From promocao_sos
Where cd_promocao_sos = :al_Promocao
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_Erro = SqlCa.SqlErrText
	SqlCa.of_Rollback();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar a promo$$HEX2$$e700e300$$ENDHEX$$o '" + String(al_Promocao) + "'. " + ls_Erro, StopSign!)
	Return False
End If

If ll_Achou > 0 Then
	Return True
Else
	Return False
End If
end function

public function boolean wf_valida_produto (long al_produto);Long ll_Achou

String ls_Erro

If IsNull(al_Produto) Then Return False

Select Count(*)
	Into: ll_Achou
From produto_geral
Where cd_produto = :al_Produto
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_Erro = SqlCa.SqlErrText
	SqlCa.of_Rollback();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar o produto '" + String(al_Produto) + "'. " + ls_Erro, StopSign!)
	Return False
End If

If ll_Achou > 0 Then
	Return True
Else
	Return False
End If
end function

public function boolean wf_atualiza (long al_promocao, long al_produto);Long ll_Minimo_Ant

String ls_Atualiza
String ls_Erro
String ls_Responsavel
String ls_Chave

Select coalesce(id_retira_venda_calculo_eb, 'N')
	Into :ls_Atualiza
From promocao_sos_produto
Where cd_promocao_sos = :al_Promocao
	And cd_produto = :al_Produto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		////Se o produto j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ como 'S', n$$HEX1$$e300$$ENDHEX$$o faz o update
		//If ls_Atualiza = "N" Then
		//			, qt_estoque_minimo = :al_Minimo
			Update promocao_sos_produto
				Set id_retira_venda_calculo_eb = :is_Ret_Calc_EB
			Where cd_promocao_sos = :al_Promocao
				And cd_produto = :al_Produto
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				ls_Erro = SqlCa.SqlErrText
				SqlCa.of_Rollback();
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao atualizar a promo$$HEX2$$e700e300$$ENDHEX$$o '" + String(al_Promocao) + "' e o produto '" + String(al_Produto) + "'. " + ls_Erro, StopSign!)
				Return False
			End If
		
			ls_Responsavel = gvo_Aplicacao.ivo_Seguranca.Nr_Matricula
			
			ls_Chave = MidA(String(al_Promocao) + Space(6), 1, 6) + "@#!" + String(al_Produto)
			
			If ls_Atualiza <> is_Ret_Calc_EB Then //Se houve altera$$HEX2$$e700e300$$ENDHEX$$o grava o hist$$HEX1$$f300$$ENDHEX$$rico
				If ls_Atualiza = "N" And is_Ret_Calc_EB = "S" Then
					If Not gf_Grava_Historico_Alteracao_Tabela('PROMOCAO_SOS_PRODUTO', ls_Chave, 'ID_RETIRA_VENDA_CALCULO_EB', 'N', 'S', ls_Responsavel, 'A', Ref ls_Erro, True) Then Return False
				Else
					If Not gf_Grava_Historico_Alteracao_Tabela('PROMOCAO_SOS_PRODUTO', ls_Chave, 'ID_RETIRA_VENDA_CALCULO_EB', 'S', 'N', ls_Responsavel, 'A', Ref ls_Erro, True) Then Return False
				End If
			End If
			
//			If (ll_Minimo_Ant <> al_Minimo) Or (IsNull(ll_Minimo_Ant) And Not IsNull(al_Minimo)) Or (Not IsNull(ll_Minimo_Ant) And IsNull(al_Minimo)) Then
//				If Not gf_Grava_Historico_Alteracao_Tabela('PROMOCAO_SOS_PRODUTO', ls_Chave, 'QT_ESTOQUE_MINIMO', String(ll_Minimo_Ant), String(al_Minimo), ls_Responsavel, 'A', Ref ls_Erro, True) Then Return False
//			End If
			
			SqlCa.of_Commit();
	
		//End If
		
	Case 100
		//N$$HEX1$$e300$$ENDHEX$$o localizou o produto na promo$$HEX2$$e700e300$$ENDHEX$$o
		
	Case -1
		ls_Erro = SqlCa.SqlErrText
		SqlCa.of_Rollback();
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar a promo$$HEX2$$e700e300$$ENDHEX$$o '" + String(al_Promocao) + "' e o produto '" + String(al_Produto) + "'. " + ls_Erro, StopSign!)
		Return False
End Choose

Return True
end function

on w_ge346_atualizacao_via_planilha.create
int iCurrent
call super::create
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
end on

on w_ge346_atualizacao_via_planilha.destroy
call super::destroy
destroy(this.cb_1)
end on

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge346_atualizacao_via_planilha
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge346_atualizacao_via_planilha
integer width = 2080
integer height = 240
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge346_atualizacao_via_planilha
integer width = 2021
integer height = 148
string dataobject = "dw_ge346_selecao_arquivo"
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge346_atualizacao_via_planilha
integer x = 1458
integer y = 260
integer width = 320
string text = "&Atualizar"
end type

event cb_ok::clicked;call super::clicked;String ls_Arquivo
String ls_Mensagem

dw_1.AcceptText()

ls_Arquivo		= dw_1.Object.De_Arquivo						[1]
is_Ret_Calc_EB	= dw_1.Object.Id_Retira_Venda_Calculo_EB[1]

If IsNull(ls_Arquivo) Or Trim(ls_Arquivo) = "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione o arquivo a ser atualizado.")
	dw_1.SetFocus()
	Return -1
End If

If is_Ret_Calc_EB = "S" Then
	ls_Mensagem = "Foi marcada a op$$HEX2$$e700e300$$ENDHEX$$o [Retira Venda do Calculo do EB].~rDeseja continuar?"
Else
	ls_Mensagem = "N$$HEX1$$c300$$ENDHEX$$O foi marcada a op$$HEX2$$e700e300$$ENDHEX$$o [Retira Venda do Calculo do EB].~rDeseja continuar?"
End If

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Mensagem, Question!, YesNo!, 2) = 1 Then
	Choose Case wf_Le_Dados_Planilha(ls_Arquivo)
		Case 1
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Todos os dados foram atualizados com sucesso.")
			CloseWithReturn(Parent, "OK")
		Case 0
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Alguns dados n$$HEX1$$e300$$ENDHEX$$o foram atualizados.")
			Open(w_ge128_log)
		Case -1
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A planilha n$$HEX1$$e300$$ENDHEX$$o possui nenhuma linha.")
	End Choose
End If
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge346_atualizacao_via_planilha
integer x = 1792
integer y = 260
end type

type cb_1 from commandbutton within w_ge346_atualizacao_via_planilha
integer x = 27
integer y = 260
integer width = 549
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Selecionar Arquivo"
end type

event clicked;Integer li_Retorno

String ls_Arquivo
String ls_Nome
String ls_Nulo

dw_1.AcceptText()

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Os dados devem estar da seguinte forma:~r" + &
							+ "~rColuna A = C$$HEX1$$f300$$ENDHEX$$digo da Promo$$HEX2$$e700e300$$ENDHEX$$o " + &
							+ "~rColuna B = C$$HEX1$$f300$$ENDHEX$$digo do Produto ")
							
							
//							+ &
//							+ "~rColuna C = Qtd. Estoque M$$HEX1$$ed00$$ENDHEX$$nimo")

li_Retorno = GetFileOpenName("Selecione o arquivo", + ls_Arquivo, ls_Nome, "XLSX", "Excel 2007 (*.XLSX),*.XLSX, Excel (*.XLS), *.XLS")

If li_Retorno = 1 Then 
	dw_1.Object.De_Arquivo[1] = Upper(ls_Arquivo)
	cb_Ok.Enabled = True
Else
	SetNull(ls_Nulo)
	dw_1.Object.De_Arquivo[1] = ls_Nulo
	cb_Ok.Enabled = False
End If



end event

