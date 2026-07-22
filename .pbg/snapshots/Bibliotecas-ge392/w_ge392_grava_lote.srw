HA$PBExportHeader$w_ge392_grava_lote.srw
forward
global type w_ge392_grava_lote from dc_w_response_ok_cancela
end type
type cb_1 from commandbutton within w_ge392_grava_lote
end type
type cb_2 from commandbutton within w_ge392_grava_lote
end type
end forward

global type w_ge392_grava_lote from dc_w_response_ok_cancela
integer width = 1317
integer height = 712
string title = "GE392 - Grava Lote"
cb_1 cb_1
cb_2 cb_2
end type
global w_ge392_grava_lote w_ge392_grava_lote

type variables
Long il_Aprovacao
end variables

on w_ge392_grava_lote.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
end on

on w_ge392_grava_lote.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_2)
end on

event ue_postopen;call super::ue_postopen;String ls_Retorno

ls_Retorno = Message.StringParm

il_Aprovacao = Long(ls_Retorno)

dw_1.Event ue_Retrieve()

dc_uo_dw_Base lvo_Dw[]
lvo_Dw = {dw_1}
This.wf_SetUpdate_Dw(lvo_Dw)
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge392_grava_lote
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge392_grava_lote
integer x = 14
integer width = 832
integer height = 480
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge392_grava_lote
integer x = 46
integer width = 773
integer height = 392
string dataobject = "dw_ge392_lote"
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event dw_1::ue_preinsertrow;call super::ue_preinsertrow;dw_1.AcceptText()

If AncestorReturnValue = 1 Then
	If dw_1.RowCount() > 0 Then
		If IsNull(dw_1.Object.Nr_Lote[dw_1.RowCount()]) Or dw_1.Object.Nr_Lote[dw_1.RowCount()] = "" Then
			Return -1
		End If
	End If
End If

Return AncestorReturnValue
end event

event dw_1::ue_recuperar;//OverRide

Return This.Retrieve(il_Aprovacao)
end event

event dw_1::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas = 0 Then
	dw_1.Event ue_Addrow()
End If

Return pl_Linhas
end event

event dw_1::editchanged;call super::editchanged;ivb_Valida_Salva = True
end event

event dw_1::ue_preupdate;call super::ue_preupdate;Long ll_Linha

dw_1.AcceptText()

For ll_Linha = 1 To dw_1.RowCount()
	dw_1.Object.Nr_Aprovacao[ll_Linha] = il_Aprovacao
Next

Return 1
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge392_grava_lote
integer x = 201
integer y = 508
end type

event cb_ok::clicked;call super::clicked;Long ll_Find

dw_1.AcceptText()

ll_Find = dw_1.Find("isnull(nr_lote) or nr_lote = ''", 1, dw_1.RowCount())

If ll_Find > 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o lote.")
	dw_1.Event ue_Pos(ll_Find, "nr_lote")
	Return -1
End If

Event ue_Save()

CloseWithReturn(Parent, "OK")
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge392_grava_lote
integer x = 535
integer y = 508
end type

type cb_1 from commandbutton within w_ge392_grava_lote
integer x = 878
integer y = 124
integer width = 393
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Insere Lote"
end type

event clicked;dw_1.Event ue_AddRow()
end event

type cb_2 from commandbutton within w_ge392_grava_lote
integer x = 878
integer y = 248
integer width = 393
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Exclui Lote"
end type

event clicked;dw_1.Event ue_DeleteRow()
end event

