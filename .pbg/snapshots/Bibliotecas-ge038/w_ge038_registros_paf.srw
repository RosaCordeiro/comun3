HA$PBExportHeader$w_ge038_registros_paf.srw
forward
global type w_ge038_registros_paf from dc_w_base
end type
type cb_selecao from commandbutton within w_ge038_registros_paf
end type
type cb_cancela from commandbutton within w_ge038_registros_paf
end type
type cb_confirma from commandbutton within w_ge038_registros_paf
end type
type rb_total from radiobutton within w_ge038_registros_paf
end type
type rb_parcial from radiobutton within w_ge038_registros_paf
end type
type em_data_inicial from editmask within w_ge038_registros_paf
end type
type st_3 from statictext within w_ge038_registros_paf
end type
type em_data_final from editmask within w_ge038_registros_paf
end type
type st_1 from statictext within w_ge038_registros_paf
end type
type gb_1 from groupbox within w_ge038_registros_paf
end type
end forward

global type w_ge038_registros_paf from dc_w_base
integer width = 1486
integer height = 724
string title = "GE038 - Registros do PAF"
boolean minbox = false
boolean resizable = false
windowtype windowtype = response!
cb_selecao cb_selecao
cb_cancela cb_cancela
cb_confirma cb_confirma
rb_total rb_total
rb_parcial rb_parcial
em_data_inicial em_data_inicial
st_3 st_3
em_data_final em_data_final
st_1 st_1
gb_1 gb_1
end type
global w_ge038_registros_paf w_ge038_registros_paf

type variables
//s_ge038_parametro_pafecf ivs_Parametro
dc_uo_ds_base ivds_produto

end variables

on w_ge038_registros_paf.create
int iCurrent
call super::create
this.cb_selecao=create cb_selecao
this.cb_cancela=create cb_cancela
this.cb_confirma=create cb_confirma
this.rb_total=create rb_total
this.rb_parcial=create rb_parcial
this.em_data_inicial=create em_data_inicial
this.st_3=create st_3
this.em_data_final=create em_data_final
this.st_1=create st_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_selecao
this.Control[iCurrent+2]=this.cb_cancela
this.Control[iCurrent+3]=this.cb_confirma
this.Control[iCurrent+4]=this.rb_total
this.Control[iCurrent+5]=this.rb_parcial
this.Control[iCurrent+6]=this.em_data_inicial
this.Control[iCurrent+7]=this.st_3
this.Control[iCurrent+8]=this.em_data_final
this.Control[iCurrent+9]=this.st_1
this.Control[iCurrent+10]=this.gb_1
end on

on w_ge038_registros_paf.destroy
call super::destroy
destroy(this.cb_selecao)
destroy(this.cb_cancela)
destroy(this.cb_confirma)
destroy(this.rb_total)
destroy(this.rb_parcial)
destroy(this.em_data_inicial)
destroy(this.st_3)
destroy(this.em_data_final)
destroy(this.st_1)
destroy(this.gb_1)
end on

event open;call super::open;em_data_inicial.text = String(Today(),'dd/mm/yyyy')
em_data_final.text   = String(Today(),'dd/mm/yyyy')

ivds_produto = Create dc_uo_ds_base
//ivs_Parametro = Message.PowerObjectParm

If w_ge038_menu_fiscal.ivs_Parametro.id_periodo = 'S' Then
	em_data_inicial.Enabled = True
	em_data_final.Enabled = True
End If	
end event

type cb_selecao from commandbutton within w_ge038_registros_paf
integer x = 878
integer y = 280
integer width = 425
integer height = 108
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Selecionar"
end type

event clicked;OpenWithParm(w_ge038_selecionar_produto3, ivds_produto)

ivds_produto = Message.PowerObjectParm
end event

type cb_cancela from commandbutton within w_ge038_registros_paf
integer x = 951
integer y = 484
integer width = 389
integer height = 108
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Cancelar"
end type

event clicked;
w_ge038_menu_fiscal.ivs_Parametro.id_Retorno = 'CANCELAR'

CloseWithReturn(Parent,'PASSAR O LVDS')
end event

type cb_confirma from commandbutton within w_ge038_registros_paf
integer x = 517
integer y = 484
integer width = 389
integer height = 108
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Con&firmar"
end type

event clicked;If rb_parcial.Checked Then
	If ivds_Produto.RowCount() <=0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Nenhum Produto foi Selecionado!")
		Return
	End If
End If

If rb_Parcial.Checked Then
	w_ge038_menu_fiscal.ivs_Parametro.id_Estoque = "P"
Else
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","A gera$$HEX2$$e700e300$$ENDHEX$$o do arquivo com Estoque Total $$HEX1$$e900$$ENDHEX$$ extremamente demorada, deseja prosseguir?",Question!,YesNo!,1) = 2 Then
		Return
	End If	
	w_ge038_menu_fiscal.ivs_Parametro.id_Estoque = "T"	
End If

w_ge038_menu_fiscal.ivs_Parametro.dh_inicial = Date(em_data_inicial.text)
w_ge038_menu_fiscal.ivs_Parametro.dh_final   = Date(em_data_final.text)
w_ge038_menu_fiscal.ivs_Parametro.id_Retorno = "OK"

CloseWithReturn(Parent,ivds_produto)
end event

type rb_total from radiobutton within w_ge038_registros_paf
integer x = 553
integer y = 280
integer width = 279
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "Total"
end type

event clicked;cb_Selecao.Visible = False
end event

type rb_parcial from radiobutton within w_ge038_registros_paf
integer x = 192
integer y = 280
integer width = 320
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "Parcial"
boolean checked = true
end type

event clicked;cb_Selecao.Visible = True
end event

type em_data_inicial from editmask within w_ge038_registros_paf
integer x = 439
integer y = 72
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

type st_3 from statictext within w_ge038_registros_paf
integer x = 850
integer y = 80
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

type em_data_final from editmask within w_ge038_registros_paf
integer x = 987
integer y = 72
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

type st_1 from statictext within w_ge038_registros_paf
integer x = 101
integer y = 80
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

type gb_1 from groupbox within w_ge038_registros_paf
integer x = 133
integer y = 196
integer width = 1248
integer height = 228
integer taborder = 30
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Estoque"
end type

