HA$PBExportHeader$w_ge039_cnpj_sat.srw
forward
global type w_ge039_cnpj_sat from window
end type
type dw_1 from datawindow within w_ge039_cnpj_sat
end type
type cb_ok from commandbutton within w_ge039_cnpj_sat
end type
type cb_fechar from commandbutton within w_ge039_cnpj_sat
end type
type gb_1 from groupbox within w_ge039_cnpj_sat
end type
end forward

global type w_ge039_cnpj_sat from window
integer x = 1170
integer y = 804
integer width = 1038
integer height = 540
boolean titlebar = true
string title = "GE039 - Reimpress$$HEX1$$e300$$ENDHEX$$o N$$HEX1$$fa00$$ENDHEX$$mero da Sorte"
windowtype windowtype = response!
long backcolor = 80269524
dw_1 dw_1
cb_ok cb_ok
cb_fechar cb_fechar
gb_1 gb_1
end type
global w_ge039_cnpj_sat w_ge039_cnpj_sat

type variables
uo_cliente              ivo_cliente

Boolean ibl_ESC = False

String ivs_data
end variables

forward prototypes
public subroutine wf_centraliza_janela ()
public function boolean wf_valida_cgc (string ps_parametro)
end prototypes

public subroutine wf_centraliza_janela ();Window w_Parent
w_Parent = ParentWindow()

This.X = (w_Parent.WorkSpaceWidth () - This.Width ) / 2
This.Y = (w_Parent.WorkSpaceHeight() - This.Height) / 2

This.Show()
end subroutine

public function boolean wf_valida_cgc (string ps_parametro);Boolean lvb_Retorno

ps_parametro = Trim(ps_parametro)

If LenA(ps_parametro) = 14 Then
	lvb_Retorno = gf_cgc_valido(ps_parametro)           //Valida cgc
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe o CPF ou CGC v$$HEX1$$e100$$ENDHEX$$lido.")
End If

Return lvb_Retorno
end function

on w_ge039_cnpj_sat.create
this.dw_1=create dw_1
this.cb_ok=create cb_ok
this.cb_fechar=create cb_fechar
this.gb_1=create gb_1
this.Control[]={this.dw_1,&
this.cb_ok,&
this.cb_fechar,&
this.gb_1}
end on

on w_ge039_cnpj_sat.destroy
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

type dw_1 from datawindow within w_ge039_cnpj_sat
event tecla pbm_dwnkey
integer x = 59
integer y = 120
integer width = 882
integer height = 88
integer taborder = 20
string title = "none"
string dataobject = "dw_ge039_cnpj_sat"
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

type cb_ok from commandbutton within w_ge039_cnpj_sat
integer x = 242
integer y = 308
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

event clicked;String ls_cnpj

dw_1.AcceptText()
	
ls_cnpj = Trim(dw_1.object.nr_cnpj[1])

If Not wf_valida_cgc(ls_cnpj) Then
	dw_1.SetFocus()
	Return
Else
	CloseWithReturn(Parent, ls_cnpj)
End If
		

end event

type cb_fechar from commandbutton within w_ge039_cnpj_sat
integer x = 622
integer y = 308
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

type gb_1 from groupbox within w_ge039_cnpj_sat
integer x = 27
integer y = 12
integer width = 969
integer height = 256
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
string text = "Gera C$$HEX1$$f300$$ENDHEX$$digo Vincula$$HEX2$$e700e300$$ENDHEX$$o SAT"
borderstyle borderstyle = styleraised!
end type

