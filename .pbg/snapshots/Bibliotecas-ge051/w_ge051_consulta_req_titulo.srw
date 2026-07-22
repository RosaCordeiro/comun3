HA$PBExportHeader$w_ge051_consulta_req_titulo.srw
forward
global type w_ge051_consulta_req_titulo from dc_w_base
end type
type dw_2 from dc_uo_dw_base within w_ge051_consulta_req_titulo
end type
type cb_fechar from commandbutton within w_ge051_consulta_req_titulo
end type
type dw_1 from datawindow within w_ge051_consulta_req_titulo
end type
type gb_1 from groupbox within w_ge051_consulta_req_titulo
end type
type gb_2 from groupbox within w_ge051_consulta_req_titulo
end type
end forward

global type w_ge051_consulta_req_titulo from dc_w_base
integer width = 1819
integer height = 964
string title = "GE051 - Dados Requisi$$HEX2$$e700e300$$ENDHEX$$o Manipulado T$$HEX1$$ed00$$ENDHEX$$tulo"
boolean minbox = false
boolean resizable = false
windowtype windowtype = response!
boolean center = true
dw_2 dw_2
cb_fechar cb_fechar
dw_1 dw_1
gb_1 gb_1
gb_2 gb_2
end type
global w_ge051_consulta_req_titulo w_ge051_consulta_req_titulo

type variables
st_ge051_nota ivst_nota
end variables

on w_ge051_consulta_req_titulo.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.cb_fechar=create cb_fechar
this.dw_1=create dw_1
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.cb_fechar
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.gb_2
end on

on w_ge051_consulta_req_titulo.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.cb_fechar)
destroy(this.dw_1)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;call super::open;ivst_nota = Message.PowerObjectParm

dw_1.SetRedraw(False)
dw_1.InsertRow(0)

//Preenche dw com dados da nota
dw_1.Object.cd_filial[1] 		= ivst_nota.cd_filial
dw_1.Object.nr_nf[1] 		= ivst_nota.nr_nf
dw_1.Object.de_especie[1] = ivst_nota.de_especie
dw_1.Object.de_serie[1] 	= ivst_nota.de_serie

dw_1.SetReDraw(True)
dw_1.SetFocus()

end event

event ue_postopen;call super::ue_postopen;dw_2.Event ue_AddRow()
dw_2.SetFocus()

dw_2.Event ue_Retrieve()

If dw_2.RowCount() = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ requisi$$HEX2$$e700f500$$ENDHEX$$es para esta venda.")
	Close(w_ge051_consulta_req_titulo)
End If
end event

type dw_2 from dc_uo_dw_base within w_ge051_consulta_req_titulo
integer x = 59
integer y = 312
integer width = 1659
integer height = 408
integer taborder = 20
string dataobject = "dw_ge051_consulta_req"
boolean vscrollbar = true
end type

event ue_recuperar;//Override

Return This.retrieve(ivst_nota.cd_filial, ivst_nota.nr_nf, ivst_nota.de_especie, ivst_nota.de_serie)
end event

event constructor;call super::constructor;This.ivb_Selecao_Linhas = False
end event

type cb_fechar from commandbutton within w_ge051_consulta_req_titulo
integer x = 1381
integer y = 748
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Fechar"
boolean cancel = true
end type

event clicked;Close(Parent)
end event

type dw_1 from datawindow within w_ge051_consulta_req_titulo
integer x = 41
integer y = 92
integer width = 1737
integer height = 108
integer taborder = 20
string title = "none"
string dataobject = "dw_ge051_dados_venda"
boolean border = false
boolean livescroll = true
end type

type gb_1 from groupbox within w_ge051_consulta_req_titulo
integer x = 23
integer width = 1769
integer height = 236
integer taborder = 10
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Dados Venda"
borderstyle borderstyle = styleraised!
end type

type gb_2 from groupbox within w_ge051_consulta_req_titulo
integer x = 23
integer y = 256
integer width = 1769
integer height = 476
integer taborder = 10
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Dados Requisi$$HEX2$$e700e300$$ENDHEX$$o"
borderstyle borderstyle = styleraised!
end type

