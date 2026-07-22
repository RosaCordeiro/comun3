HA$PBExportHeader$w_ge162_hist_distrib_bloq.srw
forward
global type w_ge162_hist_distrib_bloq from dc_w_response_ok_cancela
end type
type rb_vigentes from radiobutton within w_ge162_hist_distrib_bloq
end type
type rb_futuros from radiobutton within w_ge162_hist_distrib_bloq
end type
type rb_passados from radiobutton within w_ge162_hist_distrib_bloq
end type
type gb_filtros from groupbox within w_ge162_hist_distrib_bloq
end type
end forward

global type w_ge162_hist_distrib_bloq from dc_w_response_ok_cancela
integer width = 3630
integer height = 1808
string title = "GE162 - Hist$$HEX1$$f300$$ENDHEX$$rico de Bloqueios de Distribuidoras"
rb_vigentes rb_vigentes
rb_futuros rb_futuros
rb_passados rb_passados
gb_filtros gb_filtros
end type
global w_ge162_hist_distrib_bloq w_ge162_hist_distrib_bloq

forward prototypes
public subroutine wf_filter (string pvs_vigencia)
end prototypes

public subroutine wf_filter (string pvs_vigencia);dw_1.SetFilter("cpt_vigencia = '"+pvs_Vigencia+"'")
dw_1.Filter()
dw_1.GroupCalc()
end subroutine

on w_ge162_hist_distrib_bloq.create
int iCurrent
call super::create
this.rb_vigentes=create rb_vigentes
this.rb_futuros=create rb_futuros
this.rb_passados=create rb_passados
this.gb_filtros=create gb_filtros
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.rb_vigentes
this.Control[iCurrent+2]=this.rb_futuros
this.Control[iCurrent+3]=this.rb_passados
this.Control[iCurrent+4]=this.gb_filtros
end on

on w_ge162_hist_distrib_bloq.destroy
call super::destroy
destroy(this.rb_vigentes)
destroy(this.rb_futuros)
destroy(this.rb_passados)
destroy(this.gb_filtros)
end on

event ue_postopen;call super::ue_postopen;dw_1.SetRedraw(False)
dw_1.Event ue_Retrieve()
wf_Filter('V')
dw_1.SetRedraw(True)
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge162_hist_distrib_bloq
boolean visible = false
integer taborder = 60
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge162_hist_distrib_bloq
integer y = 180
integer width = 3566
integer height = 1392
integer taborder = 0
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge162_hist_distrib_bloq
integer y = 228
integer width = 3502
integer height = 1268
string dataobject = "dw_ge162_hist_distrib_bloq"
boolean vscrollbar = true
end type

event dw_1::constructor;call super::constructor;This.of_SetRowSelection()
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge162_hist_distrib_bloq
integer x = 3282
integer y = 1600
integer taborder = 50
boolean cancel = true
end type

event cb_ok::clicked;call super::clicked;cb_Cancelar.Event Clicked()
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge162_hist_distrib_bloq
boolean visible = false
integer x = 1911
integer y = 1316
integer taborder = 70
end type

type rb_vigentes from radiobutton within w_ge162_hist_distrib_bloq
string tag = "V"
integer x = 73
integer y = 76
integer width = 347
integer height = 64
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "&Vigentes"
boolean checked = true
end type

event clicked;wf_Filter(This.Tag)
end event

type rb_futuros from radiobutton within w_ge162_hist_distrib_bloq
string tag = "F"
integer x = 530
integer y = 76
integer width = 347
integer height = 64
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "&Futuros"
end type

event clicked;wf_Filter(This.Tag)
end event

type rb_passados from radiobutton within w_ge162_hist_distrib_bloq
string tag = "P"
integer x = 987
integer y = 76
integer width = 347
integer height = 64
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "&Passados"
end type

event clicked;wf_Filter(This.Tag)
end event

type gb_filtros from groupbox within w_ge162_hist_distrib_bloq
integer x = 27
integer y = 12
integer width = 1330
integer height = 160
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Filtrar Bloqueios"
borderstyle borderstyle = styleraised!
end type

