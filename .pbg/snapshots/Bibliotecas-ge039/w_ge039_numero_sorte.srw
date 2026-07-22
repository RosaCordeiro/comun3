HA$PBExportHeader$w_ge039_numero_sorte.srw
forward
global type w_ge039_numero_sorte from window
end type
type dw_1 from datawindow within w_ge039_numero_sorte
end type
type cb_ok from commandbutton within w_ge039_numero_sorte
end type
type cb_fechar from commandbutton within w_ge039_numero_sorte
end type
type gb_1 from groupbox within w_ge039_numero_sorte
end type
end forward

global type w_ge039_numero_sorte from window
integer x = 1170
integer y = 804
integer width = 1303
integer height = 572
boolean titlebar = true
string title = "GE039 - Reimpress$$HEX1$$e300$$ENDHEX$$o N$$HEX1$$fa00$$ENDHEX$$mero da Sorte"
windowtype windowtype = response!
long backcolor = 80269524
boolean center = true
dw_1 dw_1
cb_ok cb_ok
cb_fechar cb_fechar
gb_1 gb_1
end type
global w_ge039_numero_sorte w_ge039_numero_sorte

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

on w_ge039_numero_sorte.create
this.dw_1=create dw_1
this.cb_ok=create cb_ok
this.cb_fechar=create cb_fechar
this.gb_1=create gb_1
this.Control[]={this.dw_1,&
this.cb_ok,&
this.cb_fechar,&
this.gb_1}
end on

on w_ge039_numero_sorte.destroy
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

type dw_1 from datawindow within w_ge039_numero_sorte
event tecla pbm_dwnkey
integer x = 59
integer y = 76
integer width = 1152
integer height = 172
integer taborder = 20
string title = "none"
string dataobject = "dw_ge039_numero_nota"
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

type cb_ok from commandbutton within w_ge039_numero_sorte
integer x = 498
integer y = 332
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

event clicked;Long ll_nota

dw_1.AcceptText()
	
ll_nota = dw_1.object.nr_nf[1]

If IsNull(ll_nota) or ll_Nota = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe um n$$HEX1$$fa00$$ENDHEX$$mero v$$HEX1$$e100$$ENDHEX$$lido!", Information!)
	dw_1.SetFocus()
	Return		
Else
	CloseWithReturn(Parent, ll_Nota)
End If
		

end event

type cb_fechar from commandbutton within w_ge039_numero_sorte
integer x = 878
integer y = 332
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

type gb_1 from groupbox within w_ge039_numero_sorte
integer x = 27
integer y = 12
integer width = 1230
integer height = 288
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
string text = "Reimpress$$HEX1$$e300$$ENDHEX$$o N$$HEX1$$fa00$$ENDHEX$$mero da Sorte"
borderstyle borderstyle = styleraised!
end type

