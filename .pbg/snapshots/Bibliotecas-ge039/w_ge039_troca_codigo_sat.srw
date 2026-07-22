HA$PBExportHeader$w_ge039_troca_codigo_sat.srw
forward
global type w_ge039_troca_codigo_sat from window
end type
type dw_1 from datawindow within w_ge039_troca_codigo_sat
end type
type cb_ok from commandbutton within w_ge039_troca_codigo_sat
end type
type cb_fechar from commandbutton within w_ge039_troca_codigo_sat
end type
type gb_1 from groupbox within w_ge039_troca_codigo_sat
end type
end forward

global type w_ge039_troca_codigo_sat from window
integer x = 1170
integer y = 804
integer width = 1303
integer height = 800
boolean titlebar = true
string title = "GE039 - Reimpress$$HEX1$$e300$$ENDHEX$$o N$$HEX1$$fa00$$ENDHEX$$mero da Sorte"
windowtype windowtype = response!
long backcolor = 80269524
dw_1 dw_1
cb_ok cb_ok
cb_fechar cb_fechar
gb_1 gb_1
end type
global w_ge039_troca_codigo_sat w_ge039_troca_codigo_sat

type variables
uo_cliente              ivo_cliente

Boolean ibl_ESC = False

String ivs_data
end variables

forward prototypes
public subroutine wf_centraliza_janela ()
end prototypes

public subroutine wf_centraliza_janela ();Window w_Parent
w_Parent = ParentWindow()

This.X = (w_Parent.WorkSpaceWidth () - This.Width ) / 2
This.Y = (w_Parent.WorkSpaceHeight() - This.Height) / 2

This.Show()
end subroutine

on w_ge039_troca_codigo_sat.create
this.dw_1=create dw_1
this.cb_ok=create cb_ok
this.cb_fechar=create cb_fechar
this.gb_1=create gb_1
this.Control[]={this.dw_1,&
this.cb_ok,&
this.cb_fechar,&
this.gb_1}
end on

on w_ge039_troca_codigo_sat.destroy
destroy(this.dw_1)
destroy(this.cb_ok)
destroy(this.cb_fechar)
destroy(this.gb_1)
end on

event open;call super::open;
//wf_centraliza_janela()

ivs_data = Message.StringParm

dw_1.InsertRow(1)
dw_1.SetFocus()
end event

type dw_1 from datawindow within w_ge039_troca_codigo_sat
event tecla pbm_dwnkey
integer x = 59
integer y = 76
integer width = 1152
integer height = 448
integer taborder = 20
string title = "none"
string dataobject = "dw_ge039_troca_codigo_sat"
boolean border = false
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

event tecla;Choose Case Key

	Case KeyEscape!

		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Cancelar Opera$$HEX2$$e700e300$$ENDHEX$$o?", Question!,YesNo!, 2) = 1 Then
			Close(Parent)		
		Else
			ibl_ESC = True
			dw_1.SetFocus()			
		End If
		
End Choose
end event

event itemchanged;If dwo.Name = "id_perdeu" Then
	If Data = "2" Then
		dw_1.Object.t_msg.Visible  = True
	Else
		dw_1.Object.t_msg.Visible  = False		
	End If
End If
end event

type cb_ok from commandbutton within w_ge039_troca_codigo_sat
integer x = 498
integer y = 576
integer width = 370
integer height = 104
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&OK"
boolean cancel = true
boolean default = true
end type

event clicked;String ls_codigo, ls_perdeu, ls_retorno

dw_1.AcceptText()
	
ls_codigo 	= dw_1.object.cd_codigo[1]
ls_perdeu	= dw_1.object.id_perdeu[1]

If IsNull(ls_codigo)  Or Trim(ls_codigo) = '' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe um c$$HEX1$$f300$$ENDHEX$$digo v$$HEX1$$e100$$ENDHEX$$lido!", Information!)
	dw_1.SetFocus()
	Return		
Else
	If LenA(Trim(ls_codigo)) < 8 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","C$$HEX1$$f300$$ENDHEX$$digo deve ter no min$$HEX1$$ed00$$ENDHEX$$mo 8 caracteres!", Information!)
		dw_1.SetFocus()
		Return
	Else	
		ls_retorno = ls_perdeu + "|" + ls_codigo
		CloseWithReturn(Parent, ls_retorno)
	End If
End If
		

end event

type cb_fechar from commandbutton within w_ge039_troca_codigo_sat
integer x = 878
integer y = 576
integer width = 370
integer height = 104
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Fechar"
boolean cancel = true
end type

event clicked;Close(Parent)
end event

type gb_1 from groupbox within w_ge039_troca_codigo_sat
integer x = 27
integer y = 12
integer width = 1230
integer height = 540
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
string text = "Troca de C$$HEX1$$f300$$ENDHEX$$digo de Ativa$$HEX2$$e700e300$$ENDHEX$$o SAT"
borderstyle borderstyle = styleraised!
end type

