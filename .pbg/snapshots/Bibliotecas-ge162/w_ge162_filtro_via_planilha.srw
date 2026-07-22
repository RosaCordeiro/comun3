HA$PBExportHeader$w_ge162_filtro_via_planilha.srw
forward
global type w_ge162_filtro_via_planilha from dc_w_response_ok_cancela
end type
type cb_1 from commandbutton within w_ge162_filtro_via_planilha
end type
end forward

global type w_ge162_filtro_via_planilha from dc_w_response_ok_cancela
integer width = 2162
integer height = 432
string title = "GE162 - Filtra Produto via Planilha"
cb_1 cb_1
end type
global w_ge162_filtro_via_planilha w_ge162_filtro_via_planilha

type variables

end variables

forward prototypes
public function boolean wf_valida_produto (long al_produto, ref boolean ab_achou)
public function boolean wf_le_dados_planilha (string as_arquivo, ref string as_produto)
end prototypes

public function boolean wf_valida_produto (long al_produto, ref boolean ab_achou);Long ll_Achou

ab_Achou = False

If Not IsNumber(String(al_Produto)) Then Return True

Select Count(*)
	Into: ll_Achou
From produto_geral
Where cd_produto = :al_Produto
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o produto. " + SqlCa.SqlErrText, StopSign!)
	Return False
End If

If ll_Achou > 0 Then
	ab_Achou = True
End If

Return True
end function

public function boolean wf_le_dados_planilha (string as_arquivo, ref string as_produto);Any la_Dado

Boolean lb_Achou = False

Long ll_Linha
Long ll_Linhas
Long ll_Produto
Long ll_Len

as_Produto = ""

dw_1.AcceptText()

Try
	dc_uo_excel lo_Excel
	lo_Excel = Create dc_uo_excel
	
	Open(w_Aguarde)
	w_Aguarde.Title = "Lendo a planilha..."
	
	// Refer$$HEX1$$ea00$$ENDHEX$$ncia o arquivo 
	If ( lo_Excel.uo_Referencia_Objeto_Excel(as_Arquivo) ) Then
		// Coluna de Refer$$HEX1$$ea00$$ENDHEX$$ncia
		ll_Linhas = lo_Excel.uo_Verifica_Tamanho_Arquivo("A") 
		
		If ll_Linhas > 0 Then
			w_Aguarde.uo_Progress.of_SetMax(ll_Linhas)
					
			For ll_Linha = 1 To ll_Linhas
				la_Dado = lo_Excel.uo_Lendo_Dados(ll_Linha, "A")
				
				If Not wf_Valida_Produto(Long(la_Dado), Ref lb_Achou) Then Return False
				
				If Not lb_Achou Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produto '" + String(la_Dado) + "' n$$HEX1$$e300$$ENDHEX$$o localizado. ~rLinha " + String(ll_Linha) + ".", Exclamation!)
					Return False
				Else
					as_Produto += String(la_Dado) + ","
				End If
			Next
			
			If as_Produto <> "" Then
				ll_Len = LenA(as_Produto)
				as_Produto = MidA(as_Produto, 1, ll_Len -1)
			End If
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A planilha est$$HEX1$$e100$$ENDHEX$$ em branco.")
			Return False
		End If
	End If
	
Finally
	Close(w_Aguarde)
	If IsValid(lo_Excel) Then Destroy(lo_Excel)
End Try
end function

on w_ge162_filtro_via_planilha.create
int iCurrent
call super::create
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
end on

on w_ge162_filtro_via_planilha.destroy
call super::destroy
destroy(this.cb_1)
end on

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge162_filtro_via_planilha
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge162_filtro_via_planilha
integer y = 8
integer width = 2075
integer height = 188
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge162_filtro_via_planilha
integer y = 72
integer width = 2016
integer height = 96
string dataobject = "dw_ge162_selecao_arquivo"
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge162_filtro_via_planilha
integer x = 1463
integer y = 224
end type

event cb_ok::clicked;call super::clicked;String ls_Arquivo
String ls_Produto

dw_1.AcceptText()

ls_Arquivo = dw_1.Object.De_Arquivo[1]

If IsNull(ls_Arquivo) Or Trim(ls_Arquivo) = "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma planilha foi selecionada.")
	Return -1
End If

If Not wf_Le_Dados_Planilha(ls_Arquivo, Ref ls_Produto) Then Return -1

CloseWithReturn(Parent, ls_Produto)
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge162_filtro_via_planilha
integer x = 1797
integer y = 224
end type

type cb_1 from commandbutton within w_ge162_filtro_via_planilha
integer x = 37
integer y = 224
integer width = 526
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Seleciona Arquivo"
end type

event clicked;Integer li_Retorno

String ls_Arquivo
String ls_Nome
String ls_Nulo

dw_1.AcceptText()

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Os dados devem estar da seguinte forma:~r~r" + &
							+ "Coluna A = C$$HEX1$$f300$$ENDHEX$$digo do Produto")

li_Retorno = GetFileOpenName("Seleciona o arquivo", + ls_Arquivo, ls_Nome, "XLSX", "Excel 2007 (*.XLSX),*.XLSX, Excel (*.XLS), *.XLS")

If li_Retorno = 1 Then 
	dw_1.Object.De_Arquivo[1] = Upper(ls_Arquivo)
	cb_Ok.Enabled = True
Else
	SetNull(ls_Nulo)
	dw_1.Object.De_Arquivo[1] = ls_Nulo
	cb_Ok.Enabled = False
End If
end event

