HA$PBExportHeader$w_campos_consulta.srw
forward
global type w_campos_consulta from dc_w_response
end type
type pb_2 from picturebutton within w_campos_consulta
end type
type pb_1 from picturebutton within w_campos_consulta
end type
type dw_1 from dc_uo_dw_base within w_campos_consulta
end type
type cb_1 from commandbutton within w_campos_consulta
end type
type st_confirmar from statictext within w_campos_consulta
end type
type gb_1 from groupbox within w_campos_consulta
end type
end forward

global type w_campos_consulta from dc_w_response
integer width = 1390
integer height = 1528
pb_2 pb_2
pb_1 pb_1
dw_1 dw_1
cb_1 cb_1
st_confirmar st_confirmar
gb_1 gb_1
end type
global w_campos_consulta w_campos_consulta

type variables
Boolean ivb_Check = True
end variables

forward prototypes
public function boolean wf_ordena_posiciona_campo (string ps_campo)
end prototypes

public function boolean wf_ordena_posiciona_campo (string ps_campo);Long lvl_Linha

dw_1.SetSort("id_visivel desc, nr_seq asc")
dw_1.Sort()

For lvl_Linha = 1 To dw_1.RowCount()
	dw_1.Object.nr_seq [lvl_Linha] = lvl_Linha
Next

dw_1.SetSort("nr_seq asc")
dw_1.Sort()

If ps_campo <> "" Then
	lvl_Linha = dw_1.Find("campo='"+ps_campo+"'",1, dw_1.RowCount())
Else
	lvl_Linha = 1
End If

dw_1.SetRow(lvl_Linha)
dw_1.Scrolltorow(lvl_Linha)

Return True
end function

on w_campos_consulta.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.pb_1=create pb_1
this.dw_1=create dw_1
this.cb_1=create cb_1
this.st_confirmar=create st_confirmar
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.pb_1
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.st_confirmar
this.Control[iCurrent+6]=this.gb_1
end on

on w_campos_consulta.destroy
call super::destroy
destroy(this.pb_2)
destroy(this.pb_1)
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.st_confirmar)
destroy(this.gb_1)
end on

event open;call super::open;dc_uo_dw_base lds_Param

lds_Param = Message.PowerObjectParm
lds_Param.ShareData(dw_1)

dw_1.setFocus( )

Post wf_ordena_posiciona_campo("")
//Destroy(lds_Param)
end event

event closequery;call super::closequery;If dw_1.Find("id_visivel='S'",1,dw_1.RowCount()) <= 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Selecione ao menos um campo para ser exibido.",Exclamation!)
	Return -1
End If
end event

type pb_help from dc_w_response`pb_help within w_campos_consulta
boolean visible = false
end type

type pb_2 from picturebutton within w_campos_consulta
integer x = 1243
integer y = 500
integer width = 110
integer height = 96
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\Arrow_Up.png"
alignment htextalign = left!
long backcolor = 553648127
end type

event clicked;Long lvl_Row

If dw_1.RowCount() > 0 Then
	If dw_1.GetRow() > 1 Then
		lvl_Row = dw_1.GetRow()
		dw_1.Object.nr_seq[lvl_Row] = lvl_Row - 1
		dw_1.Object.nr_seq[lvl_Row - 1] = lvl_Row
		dw_1.Sort( )
		dw_1.Post SetRow(lvl_Row - 1)
		dw_1.Post ScrollToRow(lvl_Row - 1)
	End If
End If
end event

type pb_1 from picturebutton within w_campos_consulta
integer x = 1243
integer y = 600
integer width = 110
integer height = 96
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\Arrow_Down.png"
alignment htextalign = left!
long backcolor = 553648127
end type

event clicked;Long lvl_Row

If dw_1.RowCount() > 0 Then
	If dw_1.GetRow() < dw_1.RowCount() Then
		lvl_Row = dw_1.GetRow()
		dw_1.Object.nr_seq[lvl_Row] = lvl_Row + 1
		dw_1.Object.nr_seq[lvl_Row + 1] = lvl_Row
		dw_1.Sort()
		dw_1.Post SetRow(lvl_Row + 1)
		dw_1.Post ScrollToRow(lvl_Row + 1)
	End If
End If
end event

type dw_1 from dc_uo_dw_base within w_campos_consulta
event ue_mouse_move pbm_mousemove
integer x = 46
integer y = 44
integer width = 1170
integer height = 1192
integer taborder = 100
boolean bringtotop = true
string dataobject = "dw_campos_consulta"
boolean vscrollbar = true
end type

event ue_mouse_move;If This.RowCount() > 0 Then
	If XPos >= (st_confirmar.X + st_confirmar.Width - 75) and (XPos <= st_confirmar.x + st_confirmar.Width + 25) and &
		  ypos >= 2 and ypos < 90 Then	 
		
		st_confirmar.Visible = True
		
		If ivb_Check Then
			st_confirmar.Text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para desmarcar todos."
		Else
			st_confirmar.Text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para marcar todos."
		End If
	Else
		st_confirmar.Visible = False
	End If
End If
end event

event ue_recuperar;//Override
Return This.Retrieve()
end event

event constructor;call super::constructor;This.of_setrowselection( )
end event

event doubleclicked;call super::doubleclicked;If Dwo.Name = 'id_visivel_t' Then
	
	Long lvl_Row
	
	String lvs_Marcacao
	
	If ivb_Check Then
		lvs_Marcacao = 'N'
		ivb_Check = False
	Else
		lvs_Marcacao = 'S'
		ivb_Check = True
	End If
	
	For lvl_Row = 1 To This.RowCount()		
		This.Object.id_visivel [lvl_Row] = lvs_Marcacao
	Next
End If

end event

event itemchanged;call super::itemchanged;//Post wf_ordena_posiciona_campo(This.Object.campo[Row])

Return AncestorReturnValue
end event

type cb_1 from commandbutton within w_campos_consulta
integer x = 1006
integer y = 1308
integer width = 343
integer height = 100
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "OK"
boolean default = true
end type

event clicked;Close(Parent)

end event

type st_confirmar from statictext within w_campos_consulta
boolean visible = false
integer x = 96
integer y = 56
integer width = 933
integer height = 64
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 15793151
boolean enabled = false
string text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para desmarcar todos."
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_campos_consulta
integer x = 32
integer y = 8
integer width = 1198
integer height = 1252
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
end type

