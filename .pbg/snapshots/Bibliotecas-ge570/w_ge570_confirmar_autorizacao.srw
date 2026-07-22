HA$PBExportHeader$w_ge570_confirmar_autorizacao.srw
forward
global type w_ge570_confirmar_autorizacao from dc_w_response
end type
type dw_1 from dc_uo_dw_base within w_ge570_confirmar_autorizacao
end type
type gb_1 from groupbox within w_ge570_confirmar_autorizacao
end type
type cb_ok from commandbutton within w_ge570_confirmar_autorizacao
end type
type st_msg from statictext within w_ge570_confirmar_autorizacao
end type
type cb_cancelar from commandbutton within w_ge570_confirmar_autorizacao
end type
type gb_2 from groupbox within w_ge570_confirmar_autorizacao
end type
end forward

global type w_ge570_confirmar_autorizacao from dc_w_response
integer x = 142
integer y = 496
integer width = 3323
integer height = 1408
string title = "GE570 - Pr$$HEX1$$e900$$ENDHEX$$-Autoriza$$HEX2$$e700e300$$ENDHEX$$o / Consulta Produtos"
boolean controlmenu = false
long backcolor = 80269524
dw_1 dw_1
gb_1 gb_1
cb_ok cb_ok
st_msg st_msg
cb_cancelar cb_cancelar
gb_2 gb_2
end type
global w_ge570_confirmar_autorizacao w_ge570_confirmar_autorizacao

type variables
Decimal {2} vl_desconto

dc_uo_ds_base ids_Produtos



end variables

forward prototypes
public function boolean wf_carrega_produtos ()
end prototypes

public function boolean wf_carrega_produtos ();
Return True

end function

on w_ge570_confirmar_autorizacao.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.gb_1=create gb_1
this.cb_ok=create cb_ok
this.st_msg=create st_msg
this.cb_cancelar=create cb_cancelar
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.cb_ok
this.Control[iCurrent+4]=this.st_msg
this.Control[iCurrent+5]=this.cb_cancelar
this.Control[iCurrent+6]=this.gb_2
end on

on w_ge570_confirmar_autorizacao.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.gb_1)
destroy(this.cb_ok)
destroy(this.st_msg)
destroy(this.cb_cancelar)
destroy(this.gb_2)
end on

event ue_preopen;call super::ue_preopen;ids_Produtos = Message.powerobjectparm
end event

event ue_postopen;call super::ue_postopen;ids_Produtos.sharedata( dw_1)
end event

type pb_help from dc_w_response`pb_help within w_ge570_confirmar_autorizacao
end type

type dw_1 from dc_uo_dw_base within w_ge570_confirmar_autorizacao
integer x = 50
integer y = 56
integer width = 3209
integer height = 976
boolean bringtotop = true
string dataobject = "dw_ge570_produtos_autorizados"
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.ivb_Selecao_Linhas = True
end event

event rowfocuschanged;call super::rowfocuschanged;String ls_Retorno_Api

st_Msg.Text =""

If currentRow > 0 Then
	ls_Retorno_Api = This.Object.de_msg_retorno[ currentRow ]
	
	If IsNull(ls_Retorno_Api) Then ls_Retorno_Api = ""

	st_Msg.Text =  ls_Retorno_Api
	
End If
end event

type gb_1 from groupbox within w_ge570_confirmar_autorizacao
integer x = 23
integer width = 3255
integer height = 1052
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Produtos"
borderstyle borderstyle = styleraised!
end type

type cb_ok from commandbutton within w_ge570_confirmar_autorizacao
integer x = 2917
integer y = 1080
integer width = 370
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&OK"
boolean default = true
end type

event clicked;String ls_retorno

ls_retorno = "OK"

CloseWithReturn(Parent, ls_retorno)
end event

event getfocus;This.Weight  = 700
This.Default = True
end event

event losefocus;This.Weight  = 400
This.Default = False
end event

type st_msg from statictext within w_ge570_confirmar_autorizacao
integer x = 41
integer y = 1108
integer width = 2391
integer height = 192
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 128
long backcolor = 80269524
boolean enabled = false
boolean focusrectangle = false
end type

type cb_cancelar from commandbutton within w_ge570_confirmar_autorizacao
boolean visible = false
integer x = 2528
integer y = 1080
integer width = 370
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "&Cancelar"
end type

event clicked;
Parent.vl_desconto = 000.00

CloseWithReturn(Parent,'CANCELAR')


end event

event getfocus;This.Weight  = 700
This.Default = True
end event

event losefocus;This.Weight  = 400
This.Default = False
end event

type gb_2 from groupbox within w_ge570_confirmar_autorizacao
integer x = 18
integer y = 1052
integer width = 2432
integer height = 260
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
string text = "Retorno API"
end type

