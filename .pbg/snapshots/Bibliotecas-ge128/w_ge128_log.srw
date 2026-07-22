HA$PBExportHeader$w_ge128_log.srw
forward
global type w_ge128_log from window
end type
type cb_1 from commandbutton within w_ge128_log
end type
type cb_2 from commandbutton within w_ge128_log
end type
type mle_1 from multilineedit within w_ge128_log
end type
end forward

global type w_ge128_log from window
integer width = 2615
integer height = 1520
boolean titlebar = true
string title = "GE128 - Log"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_1 cb_1
cb_2 cb_2
mle_1 mle_1
end type
global w_ge128_log w_ge128_log

on w_ge128_log.create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.mle_1=create mle_1
this.Control[]={this.cb_1,&
this.cb_2,&
this.mle_1}
end on

on w_ge128_log.destroy
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.mle_1)
end on

event open;Long lvl_Linha, lvl_Linhas

lvl_Linhas = UpperBound(gvs_Log[])
For lvl_Linha = 1 to lvl_Linhas
	
	mle_1.Text += gvs_Log[lvl_Linha]

Next
end event

type cb_1 from commandbutton within w_ge128_log
integer x = 1783
integer y = 1312
integer width = 370
integer height = 100
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Salvar"
end type

event clicked;
string ls_path, ls_file
int li_rc, li_FileNum


li_rc = GetFileSaveName ( "Select File", ls_path, ls_file, "DOC", "All Files (*.txt),*.txt" , "C:\", 32770)

If li_rc = 1 Then
	li_FileNum = FileOpen(ls_path, LineMode!, Write!, LockRead!, Append!)
	FileWrite(li_FileNum, mle_1.Text)
	FileClose(li_FileNum)
	MessageBox("Aviso", "Arquivo salvo com sucesso em: "+ls_path)
End If


end event

type cb_2 from commandbutton within w_ge128_log
integer x = 2217
integer y = 1312
integer width = 370
integer height = 100
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Sair"
end type

event clicked;Close(Parent)
end event

type mle_1 from multilineedit within w_ge128_log
integer y = 8
integer width = 2592
integer height = 1284
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
boolean border = false
boolean hscrollbar = true
boolean vscrollbar = true
boolean autohscroll = true
boolean autovscroll = true
boolean displayonly = true
borderstyle borderstyle = stylelowered!
end type

