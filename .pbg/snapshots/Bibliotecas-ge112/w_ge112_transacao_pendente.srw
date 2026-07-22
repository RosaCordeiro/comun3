HA$PBExportHeader$w_ge112_transacao_pendente.srw
forward
global type w_ge112_transacao_pendente from window
end type
type st_2 from statictext within w_ge112_transacao_pendente
end type
type st_1 from statictext within w_ge112_transacao_pendente
end type
type dw_1 from dc_uo_dw_base within w_ge112_transacao_pendente
end type
type gb_1 from groupbox within w_ge112_transacao_pendente
end type
end forward

global type w_ge112_transacao_pendente from window
integer x = 1358
integer y = 1060
integer width = 2030
integer height = 1348
boolean titlebar = true
string title = "Transa$$HEX2$$e700e300$$ENDHEX$$o TEF cancelada"
windowtype windowtype = response!
long backcolor = 80269524
st_2 st_2
st_1 st_1
dw_1 dw_1
gb_1 gb_1
end type
global w_ge112_transacao_pendente w_ge112_transacao_pendente

type variables
Long Comando
Long TamanhoMinimo
Long TamanhoMaximo
end variables

on w_ge112_transacao_pendente.create
this.st_2=create st_2
this.st_1=create st_1
this.dw_1=create dw_1
this.gb_1=create gb_1
this.Control[]={this.st_2,&
this.st_1,&
this.dw_1,&
this.gb_1}
end on

on w_ge112_transacao_pendente.destroy
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event open;
String ls_where
String ls_ecf
String ls_cupom

This.x = ( 3680 - This.Width ) / 2
This.y = ( 2000 - This.Height) / 2

ls_ecf   = String(Long(MidA(Message.StringParm,1,3)))
ls_cupom = String(Long(MidA(Message.StringParm,4,8)))

ls_where = 'nr_ecf = ' + ls_ecf + ' and nr_coo_ecf = ' + ls_cupom

This.Show()

gf_Ativa_Janela(This)

dw_1.of_AppendWhere(ls_Where)

dw_1.Retrieve()

If dw_1.RowCount() = 0 Then 
	Close(This)
Else	
	If IsNull(dw_1.object.de_modalidade[1]) Then 
		Close(This)
	End If
End If	




end event

event key;
Choose Case key
	Case KeyF11!	
		Close(This)			
End Choose

end event

type st_2 from statictext within w_ge112_transacao_pendente
integer x = 87
integer y = 788
integer width = 1819
integer height = 316
integer textsize = -48
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 80269524
string text = "CANCELADO"
boolean focusrectangle = false
end type

type st_1 from statictext within w_ge112_transacao_pendente
integer x = 37
integer y = 1164
integer width = 1934
integer height = 76
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 128
long backcolor = 80269524
boolean enabled = false
string text = "... Pressione tecla [F11] para continuar ..."
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_1 from dc_uo_dw_base within w_ge112_transacao_pendente
integer x = 64
integer y = 68
integer width = 1883
integer height = 664
integer taborder = 20
string dataobject = "dw_ge112_transacao_tef"
end type

type gb_1 from groupbox within w_ge112_transacao_pendente
integer x = 37
integer y = 16
integer width = 1934
integer height = 740
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 128
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

