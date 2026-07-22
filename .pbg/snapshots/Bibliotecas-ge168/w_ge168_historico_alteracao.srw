HA$PBExportHeader$w_ge168_historico_alteracao.srw
forward
global type w_ge168_historico_alteracao from dc_w_response_ok_cancela
end type
type cb_1 from commandbutton within w_ge168_historico_alteracao
end type
end forward

global type w_ge168_historico_alteracao from dc_w_response_ok_cancela
integer width = 3246
integer height = 1436
string title = "GE168 - Hist$$HEX1$$f300$$ENDHEX$$rico de altera$$HEX2$$e700f500$$ENDHEX$$es"
cb_1 cb_1
end type
global w_ge168_historico_alteracao w_ge168_historico_alteracao

on w_ge168_historico_alteracao.create
int iCurrent
call super::create
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
end on

on w_ge168_historico_alteracao.destroy
call super::destroy
destroy(this.cb_1)
end on

event ue_postopen;call super::ue_postopen;String ls_Retorno

Long ll_Filial
Long ll_Produto

ls_Retorno = Message.StringParm

ll_Filial = Long( Mid(ls_Retorno, 1, 4) )

ll_Produto = Long( MId(ls_Retorno, 5) )

dw_1.Retrieve(ll_Filial, ll_Produto )
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge168_historico_alteracao
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge168_historico_alteracao
integer width = 3195
integer height = 1224
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge168_historico_alteracao
integer width = 3109
integer height = 1136
string dataobject = "dw_ge168_lista_hist_alteracao"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event dw_1::constructor;call super::constructor;This.of_SetRowSelection()
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge168_historico_alteracao
integer x = 2793
integer y = 1236
end type

event cb_ok::clicked;call super::clicked;String lvs_Retorno

SetNull(lvs_Retorno)
CloseWithReturn(Parent, lvs_Retorno)
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge168_historico_alteracao
boolean visible = false
integer x = 1669
integer y = 1240
end type

type cb_1 from commandbutton within w_ge168_historico_alteracao
integer x = 27
integer y = 1236
integer width = 457
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Exportar XLS"
end type

event clicked;dw_1.Event ue_SaveAs()
end event

