HA$PBExportHeader$w_sobre.srw
forward
global type w_sobre from w_popup
end type
type cb_fechar from commandbutton within w_sobre
end type
type dw_1 from u_dw within w_sobre
end type
end forward

global type w_sobre from w_popup
integer width = 2363
integer height = 1400
boolean minbox = false
boolean maxbox = false
boolean resizable = false
windowtype windowtype = response!
cb_fechar cb_fechar
dw_1 dw_1
end type
global w_sobre w_sobre

type variables
STRING ivs_Title
end variables

on w_sobre.create
int iCurrent
call super::create
this.cb_fechar=create cb_fechar
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_fechar
this.Control[iCurrent+2]=this.dw_1
end on

on w_sobre.destroy
call super::destroy
destroy(this.cb_fechar)
destroy(this.dw_1)
end on

event pfc_preopen;SetPointer(HourGlass!)

String  lvs_versao
Date    lvdt_data_versao
Integer lvi_Pos

// Carrega as vari$$HEX1$$e100$$ENDHEX$$veis de nome do sistema, vers$$HEX1$$e300$$ENDHEX$$o e data

lvs_versao = gnv_app.of_GetVersion()
lvdt_data_versao = gnv_app.of_Le_Data_Versao()
lvs_versao = "Vers$$HEX1$$e300$$ENDHEX$$o " + lvs_versao + " de " + String(lvdt_data_versao, "dd/mm/yyyy")

ivs_Title = UPPER(gnv_app.iapp_object.DisplayName)

lvi_Pos   = PosA(ivs_Title,"USU$$HEX1$$c100$$ENDHEX$$RIO")

IF lvi_Pos > 0 THEN
	lvi_Pos --
	ivs_Title = LeftA(gnv_app.iapp_object.DisplayName,lvi_Pos)
ELSE
	ivs_Title = gnv_app.iapp_object.DisplayName
END IF	

dw_1.InsertRow(0)
dw_1.Object.nome[1]   = ivs_Title
dw_1.Object.versao[1] = lvs_versao
end event

event open;call super::open;SetPointer(HourGlass!)

X = 650
Y = 550

This.Title = "Sobre " + ivs_Title


end event

type cb_fechar from commandbutton within w_sobre
integer x = 1975
integer y = 1164
integer width = 302
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Ok"
boolean cancel = true
boolean default = true
end type

event clicked;close(parent)
end event

type dw_1 from u_dw within w_sobre
integer width = 2354
integer height = 1320
integer taborder = 10
string dataobject = "dw_inicial"
boolean vscrollbar = false
borderstyle borderstyle = styleraised!
end type

event constructor;SetPointer(HourGlass!)

// Desmarca o flag de atualiza$$HEX2$$e700e300$$ENDHEX$$o da PFC

ib_isupdateable = False
end event

