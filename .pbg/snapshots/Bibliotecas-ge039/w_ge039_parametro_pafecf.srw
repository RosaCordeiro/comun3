HA$PBExportHeader$w_ge039_parametro_pafecf.srw
forward
global type w_ge039_parametro_pafecf from window
end type
type cb_confirma from commandbutton within w_ge039_parametro_pafecf
end type
type cb_cancela from commandbutton within w_ge039_parametro_pafecf
end type
type st_1 from statictext within w_ge039_parametro_pafecf
end type
type st_22 from statictext within w_ge039_parametro_pafecf
end type
type st_23 from statictext within w_ge039_parametro_pafecf
end type
type em_ecf_final from editmask within w_ge039_parametro_pafecf
end type
type em_ecf_inicial from editmask within w_ge039_parametro_pafecf
end type
type st_ecf from statictext within w_ge039_parametro_pafecf
end type
type em_coo_final from editmask within w_ge039_parametro_pafecf
end type
type em_coo_inicial from editmask within w_ge039_parametro_pafecf
end type
type st_coo from statictext within w_ge039_parametro_pafecf
end type
type dw_1 from dc_uo_dw_base within w_ge039_parametro_pafecf
end type
type st_21 from statictext within w_ge039_parametro_pafecf
end type
type em_reducao_inicial from editmask within w_ge039_parametro_pafecf
end type
type st_reducao_final from statictext within w_ge039_parametro_pafecf
end type
type em_reducao_final from editmask within w_ge039_parametro_pafecf
end type
type rb_arquivo from radiobutton within w_ge039_parametro_pafecf
end type
type rb_ecf from radiobutton within w_ge039_parametro_pafecf
end type
type em_data_final from editmask within w_ge039_parametro_pafecf
end type
type st_3 from statictext within w_ge039_parametro_pafecf
end type
type em_data_inicial from editmask within w_ge039_parametro_pafecf
end type
type gb_1 from groupbox within w_ge039_parametro_pafecf
end type
end forward

global type w_ge039_parametro_pafecf from window
integer x = 1010
integer y = 640
integer width = 2295
integer height = 664
boolean titlebar = true
string title = "GE039 - Par$$HEX1$$e200$$ENDHEX$$metros Fun$$HEX2$$e700e300$$ENDHEX$$o PAF-ECF"
windowtype windowtype = response!
long backcolor = 80269524
boolean center = true
cb_confirma cb_confirma
cb_cancela cb_cancela
st_1 st_1
st_22 st_22
st_23 st_23
em_ecf_final em_ecf_final
em_ecf_inicial em_ecf_inicial
st_ecf st_ecf
em_coo_final em_coo_final
em_coo_inicial em_coo_inicial
st_coo st_coo
dw_1 dw_1
st_21 st_21
em_reducao_inicial em_reducao_inicial
st_reducao_final st_reducao_final
em_reducao_final em_reducao_final
rb_arquivo rb_arquivo
rb_ecf rb_ecf
em_data_final em_data_final
st_3 st_3
em_data_inicial em_data_inicial
gb_1 gb_1
end type
global w_ge039_parametro_pafecf w_ge039_parametro_pafecf

type variables
s_ge039_parametro_pafecf ivs_Parametro
end variables

on w_ge039_parametro_pafecf.create
this.cb_confirma=create cb_confirma
this.cb_cancela=create cb_cancela
this.st_1=create st_1
this.st_22=create st_22
this.st_23=create st_23
this.em_ecf_final=create em_ecf_final
this.em_ecf_inicial=create em_ecf_inicial
this.st_ecf=create st_ecf
this.em_coo_final=create em_coo_final
this.em_coo_inicial=create em_coo_inicial
this.st_coo=create st_coo
this.dw_1=create dw_1
this.st_21=create st_21
this.em_reducao_inicial=create em_reducao_inicial
this.st_reducao_final=create st_reducao_final
this.em_reducao_final=create em_reducao_final
this.rb_arquivo=create rb_arquivo
this.rb_ecf=create rb_ecf
this.em_data_final=create em_data_final
this.st_3=create st_3
this.em_data_inicial=create em_data_inicial
this.gb_1=create gb_1
this.Control[]={this.cb_confirma,&
this.cb_cancela,&
this.st_1,&
this.st_22,&
this.st_23,&
this.em_ecf_final,&
this.em_ecf_inicial,&
this.st_ecf,&
this.em_coo_final,&
this.em_coo_inicial,&
this.st_coo,&
this.dw_1,&
this.st_21,&
this.em_reducao_inicial,&
this.st_reducao_final,&
this.em_reducao_final,&
this.rb_arquivo,&
this.rb_ecf,&
this.em_data_final,&
this.st_3,&
this.em_data_inicial,&
this.gb_1}
end on

on w_ge039_parametro_pafecf.destroy
destroy(this.cb_confirma)
destroy(this.cb_cancela)
destroy(this.st_1)
destroy(this.st_22)
destroy(this.st_23)
destroy(this.em_ecf_final)
destroy(this.em_ecf_inicial)
destroy(this.st_ecf)
destroy(this.em_coo_final)
destroy(this.em_coo_inicial)
destroy(this.st_coo)
destroy(this.dw_1)
destroy(this.st_21)
destroy(this.em_reducao_inicial)
destroy(this.st_reducao_final)
destroy(this.em_reducao_final)
destroy(this.rb_arquivo)
destroy(this.rb_ecf)
destroy(this.em_data_final)
destroy(this.st_3)
destroy(this.em_data_inicial)
destroy(this.gb_1)
end on

event open;
em_data_inicial.text = String(Today(),'dd/mm/yyyy')
em_data_final.text   = String(Today(),'dd/mm/yyyy')

ivs_Parametro = Message.PowerObjectParm

If ivs_Parametro.id_Destino = 'S' Then
	rb_ecf.Enabled = True
	rb_arquivo.Enabled = True
Else
	rb_ecf.Enabled = False
	rb_arquivo.Enabled = False
End If	

If ivs_Parametro.id_periodo = 'S' Then
	em_data_inicial.Enabled = True
	em_data_final.Enabled = True
End If	

If ivs_Parametro.id_coo = 'S' Then
	em_coo_inicial.Enabled = True
	em_coo_final.Enabled = True
End If	

If ivs_Parametro.id_ecf = 'S' Then
	em_ecf_inicial.Enabled = True
	em_ecf_final.Enabled = True
End If	

If ivs_Parametro.id_reducao = 'S' Then
	em_reducao_inicial.Enabled = True
	em_reducao_final.Enabled = True
End If	

If em_data_inicial.Enabled Then 
	em_data_inicial.SetFocus()
Else
	If em_coo_inicial.Enabled Then
		em_coo_inicial.SetFocus()
	Else
		If em_ecf_inicial.Enabled Then
			em_ecf_inicial.SetFocus()
		Else
			If em_reducao_inicial.Enabled Then
				em_reducao_inicial.SetFocus()
			Else	
				rb_ecf.SetFocus()				
			End If	
		End If
	End If
End If	

end event

type cb_confirma from commandbutton within w_ge039_parametro_pafecf
integer x = 1874
integer y = 432
integer width = 370
integer height = 108
integer taborder = 130
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Confirmar"
end type

event clicked;If ivs_Parametro.id_periodo = 'S' Then
	ivs_Parametro.dh_inicial = Date(em_data_inicial.text)
	ivs_Parametro.dh_final   = Date(em_data_final.text)
Else
	SetNull(ivs_Parametro.dh_inicial)
	SetNull(ivs_Parametro.dh_final)
End If	

If ivs_Parametro.id_coo = 'S' Then
	ivs_Parametro.nr_coo_inicial = Long(em_coo_inicial.text)
	ivs_Parametro.nr_coo_final   = Long(em_coo_final.text)
Else
	SetNull(ivs_Parametro.nr_coo_inicial)
	SetNull(ivs_Parametro.nr_coo_final)
End If

If ivs_Parametro.id_ecf = 'S' Then
	ivs_Parametro.nr_ecf_inicial = Long(em_ecf_inicial.text)
	ivs_Parametro.nr_ecf_final   = Long(em_ecf_final.text)
Else
	SetNull(ivs_Parametro.nr_ecf_inicial)
	SetNull(ivs_Parametro.nr_ecf_final)
End If	

If ivs_Parametro.id_reducao = 'S' Then
	ivs_Parametro.nr_reducao_inicial = Long(em_reducao_inicial.text)
	ivs_Parametro.nr_reducao_final   = Long(em_reducao_final.text)
Else
	SetNull(em_reducao_inicial)
	SetNull(em_reducao_final)
End If

ivs_Parametro.id_Arquivo = rb_arquivo.Checked

ivs_Parametro.id_Retorno = "OK"

CloseWithReturn(Parent,ivs_Parametro)
end event

type cb_cancela from commandbutton within w_ge039_parametro_pafecf
integer x = 1486
integer y = 432
integer width = 370
integer height = 108
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Cancelar"
end type

event clicked;
ivs_Parametro.id_Retorno = 'CANCELAR'

CloseWithReturn(Parent,ivs_Parametro)
end event

type st_1 from statictext within w_ge039_parametro_pafecf
integer x = 37
integer y = 36
integer width = 329
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "Per$$HEX1$$ed00$$ENDHEX$$odo:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_22 from statictext within w_ge039_parametro_pafecf
integer x = 37
integer y = 132
integer width = 329
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "COO:"
alignment alignment = right!
boolean focusrectangle = false
end type

type st_23 from statictext within w_ge039_parametro_pafecf
integer x = 37
integer y = 228
integer width = 329
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "ECF:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_ecf_final from editmask within w_ge039_parametro_pafecf
integer x = 923
integer y = 220
integer width = 389
integer height = 84
integer taborder = 70
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
boolean enabled = false
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "#####"
end type

type em_ecf_inicial from editmask within w_ge039_parametro_pafecf
integer x = 375
integer y = 220
integer width = 389
integer height = 84
integer taborder = 50
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
boolean enabled = false
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "#####"
end type

type st_ecf from statictext within w_ge039_parametro_pafecf
integer x = 786
integer y = 228
integer width = 114
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "at$$HEX1$$e900$$ENDHEX$$"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_coo_final from editmask within w_ge039_parametro_pafecf
integer x = 923
integer y = 124
integer width = 389
integer height = 84
integer taborder = 40
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
boolean enabled = false
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "#####"
end type

type em_coo_inicial from editmask within w_ge039_parametro_pafecf
integer x = 375
integer y = 124
integer width = 389
integer height = 84
integer taborder = 30
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
boolean enabled = false
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "#####"
end type

type st_coo from statictext within w_ge039_parametro_pafecf
integer x = 786
integer y = 132
integer width = 114
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "at$$HEX1$$e900$$ENDHEX$$"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_1 from dc_uo_dw_base within w_ge039_parametro_pafecf
boolean visible = false
integer x = 1445
integer y = 864
integer width = 1143
integer height = 708
integer taborder = 60
string dataobject = "dw_ge039_pafecf_estoque"
end type

type st_21 from statictext within w_ge039_parametro_pafecf
integer x = 37
integer y = 324
integer width = 329
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "Redu$$HEX2$$e700e300$$ENDHEX$$o:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_reducao_inicial from editmask within w_ge039_parametro_pafecf
integer x = 375
integer y = 316
integer width = 389
integer height = 84
integer taborder = 80
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
boolean enabled = false
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "#####"
end type

type st_reducao_final from statictext within w_ge039_parametro_pafecf
integer x = 786
integer y = 324
integer width = 114
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "at$$HEX1$$e900$$ENDHEX$$"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_reducao_final from editmask within w_ge039_parametro_pafecf
integer x = 923
integer y = 316
integer width = 389
integer height = 84
integer taborder = 90
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
boolean enabled = false
alignment alignment = right!
borderstyle borderstyle = stylelowered!
string mask = "#####"
end type

type rb_arquivo from radiobutton within w_ge039_parametro_pafecf
integer x = 1833
integer y = 72
integer width = 361
integer height = 76
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Arquivo"
end type

type rb_ecf from radiobutton within w_ge039_parametro_pafecf
integer x = 1504
integer y = 72
integer width = 320
integer height = 76
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "ECF"
boolean checked = true
end type

type em_data_final from editmask within w_ge039_parametro_pafecf
integer x = 923
integer y = 28
integer width = 389
integer height = 84
integer taborder = 20
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 33554431
boolean enabled = false
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
end type

type st_3 from statictext within w_ge039_parametro_pafecf
integer x = 786
integer y = 36
integer width = 114
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "at$$HEX1$$e900$$ENDHEX$$"
alignment alignment = center!
boolean focusrectangle = false
end type

type em_data_inicial from editmask within w_ge039_parametro_pafecf
integer x = 375
integer y = 28
integer width = 389
integer height = 84
integer taborder = 10
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 33554431
boolean enabled = false
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "dd/mm/yyyy"
end type

type gb_1 from groupbox within w_ge039_parametro_pafecf
integer x = 1413
integer y = 4
integer width = 823
integer height = 192
integer taborder = 140
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Destino"
end type

