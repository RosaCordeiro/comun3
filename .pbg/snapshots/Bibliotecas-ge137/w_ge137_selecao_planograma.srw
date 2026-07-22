HA$PBExportHeader$w_ge137_selecao_planograma.srw
forward
global type w_ge137_selecao_planograma from dc_w_response_ok_cancela
end type
type cb_selecao from commandbutton within w_ge137_selecao_planograma
end type
end forward

global type w_ge137_selecao_planograma from dc_w_response_ok_cancela
integer width = 1979
integer height = 1340
string title = "GE137 - Sele$$HEX2$$e700e300$$ENDHEX$$o de Planogramas"
cb_selecao cb_selecao
end type
global w_ge137_selecao_planograma w_ge137_selecao_planograma

type variables
uo_ge137_planogramas io_Plan
end variables

on w_ge137_selecao_planograma.create
int iCurrent
call super::create
this.cb_selecao=create cb_selecao
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_selecao
end on

on w_ge137_selecao_planograma.destroy
call super::destroy
destroy(this.cb_selecao)
end on

event ue_postopen;call super::ue_postopen;io_Plan = Create uo_ge137_planogramas

io_Plan = Message.PowerObjectParm	

dw_1.Event ue_Retrieve()
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge137_selecao_planograma
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge137_selecao_planograma
integer width = 1925
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge137_selecao_planograma
integer width = 1870
integer height = 1036
string dataobject = "dw_ge137_planogramas"
boolean vscrollbar = true
end type

event dw_1::ue_recuperar;//Over

Long ll_Analise

ll_Analise = io_Plan.il_Analise

If IsNull(ll_Analise) Then ll_Analise = 0

//Se for ZERO a dw_1 traz todos os planogramas desmarcados
Return This.Retrieve( ll_analise )
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge137_selecao_planograma
integer x = 1303
integer y = 1144
end type

event cb_ok::clicked;call super::clicked;Integer i
String ls_Plan
Long ll_Null[]

io_Plan.il_Planogramas[] = ll_Null[]

For i = 1 To dw_1.RowCount()
	If dw_1.Object.id_selecao[ i ] = 'S' Then 
		io_Plan.is_Planogramas += String( dw_1.Object.cd_planograma[ i ] ) + ","
		io_Plan.il_Planogramas[ UpperBound(io_Plan.il_Planogramas) + 1 ] = dw_1.Object.cd_planograma[ i ]
	End If
Next

If IsNull( io_Plan.is_Planogramas ) Or io_Plan.is_Planogramas = "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Selecione pelo menos um planograma")
	Return -1
End if

io_Plan.is_Planogramas = Mid( io_Plan.is_Planogramas,1, LenA( io_Plan.is_Planogramas) -1 )

CloseWithReturn(Parent, io_Plan  )
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge137_selecao_planograma
integer x = 1637
integer y = 1144
end type

event cb_cancelar::clicked;//Over

CloseWithReturn(Parent, io_Plan  )
end event

type cb_selecao from commandbutton within w_ge137_selecao_planograma
integer x = 23
integer y = 1144
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
string text = "Marcar Todos"
end type

event clicked;Long ll_Linha

String ls_Selecao, ls_Titulo

If This.Text = "Marcar Todos" Then
	ls_Titulo  = "Desmarcar Todos"
	ls_Selecao = "S"
Else
	ls_Titulo  = "Marcar Todos"
	ls_Selecao = "N"
End If

For ll_Linha = 1 To dw_1.RowCount()
	dw_1.Object.id_selecao [ ll_Linha ] = ls_Selecao
Next

This.Text = ls_Titulo
end event

