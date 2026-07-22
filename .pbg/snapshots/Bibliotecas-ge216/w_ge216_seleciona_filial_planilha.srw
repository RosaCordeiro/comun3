HA$PBExportHeader$w_ge216_seleciona_filial_planilha.srw
forward
global type w_ge216_seleciona_filial_planilha from dc_w_response_ok_cancela
end type
type cb_1 from commandbutton within w_ge216_seleciona_filial_planilha
end type
end forward

global type w_ge216_seleciona_filial_planilha from dc_w_response_ok_cancela
integer width = 2158
integer height = 428
string title = "GE216 - Seleciona Filial via Planilha"
cb_1 cb_1
end type
global w_ge216_seleciona_filial_planilha w_ge216_seleciona_filial_planilha

type variables
dc_uo_ds_base ids
end variables

forward prototypes
public function boolean wf_le_dados_planilha (string as_arquivo)
public function boolean wf_valida_filial (long al_filial)
end prototypes

public function boolean wf_le_dados_planilha (string as_arquivo);Any la_Dado

Long ll_Linha
Long ll_Linhas

Try
	dc_uo_excel lo_Excel
	lo_Excel = Create dc_uo_excel
	
	Open(w_Aguarde)
	w_Aguarde.Title = "Lendo a planilha..."
	
	// Refer$$HEX1$$ea00$$ENDHEX$$ncia o Arquivo 
	If ( lo_Excel.uo_Referencia_Objeto_Excel(as_Arquivo) ) Then
		// Coluna de Refer$$HEX1$$ea00$$ENDHEX$$ncia
		ll_Linhas = lo_Excel.uo_Verifica_Tamanho_Arquivo("A") 
		
		If ll_Linhas > 0 Then
			w_Aguarde.uo_Progress.of_SetMax(ll_Linhas)
					
			For ll_Linha = 1 To ll_Linhas
				la_Dado = lo_Excel.uo_Lendo_Dados(ll_Linha, "A")
				
				If Not IsNumber(String(la_Dado)) Or IsNull(la_Dado) Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Registro inv$$HEX1$$e100$$ENDHEX$$lido na linha: " + String(ll_Linha), Exclamation!)
					Continue
				End If
				
				If Not wf_Valida_Filial(Long(la_Dado)) Then Return False
			Next
			
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

public function boolean wf_valida_filial (long al_filial);Long ll_Achou
Long ll_Insert

Select Count(*)
	Into :ll_Achou
From filial
Where cd_filial = :al_Filial
	And id_situacao = 'A'
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao consultar o c$$HEX1$$f300$$ENDHEX$$digo da filial '" + String(al_Filial) + "'. " + SqlCa.SqlErrText, StopSign!)
	Return False
End If

If ll_Achou > 0 Then
	ll_Insert = ids.InsertRow(0)
	ids.Object.Cd_Filial[ll_Insert] = al_Filial
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Filial '" + String(al_Filial) + "' n$$HEX1$$e300$$ENDHEX$$o localizada ou inativa.", Exclamation!)
End If

Return True
end function

on w_ge216_seleciona_filial_planilha.create
int iCurrent
call super::create
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
end on

on w_ge216_seleciona_filial_planilha.destroy
call super::destroy
destroy(this.cb_1)
end on

event ue_postopen;call super::ue_postopen;ids = Create dc_uo_ds_base

ids = Message.PowerObjectParm
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge216_seleciona_filial_planilha
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge216_seleciona_filial_planilha
integer width = 2075
integer height = 184
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge216_seleciona_filial_planilha
integer width = 2016
integer height = 92
string dataobject = "dw_ge216_selecao_arquivo"
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge216_seleciona_filial_planilha
integer x = 1449
integer y = 216
end type

event cb_ok::clicked;call super::clicked;String ls_Arquivo

dw_1.AcceptText()

ls_Arquivo = dw_1.Object.De_Arquivo[1]

If IsNull(ls_Arquivo) Or Trim(ls_Arquivo) = "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma planilha foi selecionada.")
	Return -1
End If

If Not wf_Le_Dados_Planilha(ls_Arquivo) Then Return -1

CloseWithReturn(Parent, ids)
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge216_seleciona_filial_planilha
integer x = 1787
integer y = 216
end type

event cb_cancelar::clicked;//OverRide

ids.Reset()

CloseWithReturn(Parent, ids)
end event

type cb_1 from commandbutton within w_ge216_seleciona_filial_planilha
integer x = 23
integer y = 216
integer width = 526
integer height = 100
integer taborder = 40
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
							+ "Coluna A = C$$HEX1$$f300$$ENDHEX$$digo da Filial")

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

