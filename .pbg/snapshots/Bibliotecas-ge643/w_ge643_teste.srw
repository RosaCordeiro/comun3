HA$PBExportHeader$w_ge643_teste.srw
forward
global type w_ge643_teste from dc_w_response
end type
type cb_1 from commandbutton within w_ge643_teste
end type
type sle_1 from singlelineedit within w_ge643_teste
end type
type st_1 from statictext within w_ge643_teste
end type
end forward

global type w_ge643_teste from dc_w_response
integer width = 1161
integer height = 492
string title = "GE643 - Calcula Cr$$HEX1$$e900$$ENDHEX$$dito Pis/Cofins"
cb_1 cb_1
sle_1 sle_1
st_1 st_1
end type
global w_ge643_teste w_ge643_teste

on w_ge643_teste.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.sle_1=create sle_1
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.sle_1
this.Control[iCurrent+3]=this.st_1
end on

on w_ge643_teste.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.sle_1)
destroy(this.st_1)
end on

type pb_help from dc_w_response`pb_help within w_ge643_teste
end type

type cb_1 from commandbutton within w_ge643_teste
integer x = 215
integer y = 260
integer width = 402
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Executar"
end type

event clicked;String ls_text

ls_text = sle_1.text 

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja executar a c$$HEX1$$e100$$ENDHEX$$lculo do cr$$HEX1$$e900$$ENDHEX$$dito do  PIS/COFINS?", Question!, YesNo!, 2) = 2 Then Return

uo_ge642_apura_pis_cofins uo

uo = create uo_ge642_apura_pis_cofins

//uo.of_processa(date("01/08/2024"), date("31/08/2024"), 0)
//uo.of_processa(date("01/11/2024"), date("30/11/2024"), 0)

//uo.of_processa()

// ****************
// S$$HEX1$$f300$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ gerando a ST - 5405, 6405 
// A Kamila pediu para priorizar

uo.of_processa_individual(ls_text)

destroy uo
end event

type sle_1 from singlelineedit within w_ge643_teste
integer x = 215
integer y = 128
integer width = 402
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
boolean hideselection = false
end type

type st_1 from statictext within w_ge643_teste
integer x = 206
integer y = 48
integer width = 581
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "Informe (yyyy/mm): "
boolean focusrectangle = false
end type

