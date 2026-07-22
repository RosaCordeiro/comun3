HA$PBExportHeader$w_ge231_selecao_diretorio.srw
forward
global type w_ge231_selecao_diretorio from window
end type
type cb_2 from commandbutton within w_ge231_selecao_diretorio
end type
type cb_1 from commandbutton within w_ge231_selecao_diretorio
end type
type p_1 from picture within w_ge231_selecao_diretorio
end type
type sle_1 from singlelineedit within w_ge231_selecao_diretorio
end type
end forward

global type w_ge231_selecao_diretorio from window
integer x = 814
integer y = 916
integer width = 2085
integer height = 356
boolean titlebar = true
string title = "GE231 - Sele$$HEX2$$e700e300$$ENDHEX$$o do Diret$$HEX1$$f300$$ENDHEX$$rio"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 79741120
cb_2 cb_2
cb_1 cb_1
p_1 p_1
sle_1 sle_1
end type
global w_ge231_selecao_diretorio w_ge231_selecao_diretorio

type variables
String ivs_escolha
end variables

forward prototypes
public function boolean wf_valida_nome (string ps_nome_arquivo)
end prototypes

public function boolean wf_valida_nome (string ps_nome_arquivo);Integer lvi_retorno

If IsNull(ps_nome_arquivo) or Trim(ps_nome_arquivo) = "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Favor escolher o arquivo a ser salvo.", Information!, Ok!)
	sle_1.SetFocus()
	Return False
End If

If RightA(ps_nome_arquivo, 4) <> '.xls' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O tipo do arquivo escolhido deve ser planilha Excel (.xls)", Information!, Ok!)
	sle_1.SetFocus()
	Return False
End If

If FileExists(ps_nome_arquivo) Then
	lvi_retorno = MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O arquivo informado j$$HEX1$$e100$$ENDHEX$$ existe. Deseja continuar?", Question!, YesNo!, 2)
	If lvi_retorno = 2 Then
		sle_1.SetFocus()
		Return False
	End If
End If

Return True
end function

on w_ge231_selecao_diretorio.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.p_1=create p_1
this.sle_1=create sle_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.p_1,&
this.sle_1}
end on

on w_ge231_selecao_diretorio.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.p_1)
destroy(this.sle_1)
end on

event open;String lvs_Arquivo

lvs_Arquivo = Message.StringParm

sle_1.Text = gvo_Aplicacao.of_GetFromIni("Diretorio", "Diretorio") + lvs_Arquivo + '.xls'

ivs_Escolha = sle_1.Text

end event

type cb_2 from commandbutton within w_ge231_selecao_diretorio
integer x = 1691
integer y = 148
integer width = 347
integer height = 96
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Cancelar"
end type

event clicked;CloseWithReturn(Parent, "")
end event

type cb_1 from commandbutton within w_ge231_selecao_diretorio
integer x = 1349
integer y = 148
integer width = 320
integer height = 96
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&OK"
end type

event clicked;ivs_Escolha = sle_1.Text

CloseWithReturn(Parent, ivs_Escolha)
end event

type p_1 from picture within w_ge231_selecao_diretorio
integer x = 1915
integer y = 24
integer width = 128
integer height = 96
string picturename = "s:\sistemas\comuns\figuras\localizar_arquivo.bmp"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

event clicked;SetPointer(HourGlass!)

Integer lvi_retorno

String lvs_default

lvs_default = sle_1.text

lvi_retorno = GetFileSaveName('Arquivo', lvs_default, ivs_Escolha, 'xls', 'Planilha Excel (*.xls),*.xls')

If lvi_retorno = 0 Then
	Return
End If

If wf_valida_nome(lvs_Default) Then
	sle_1.Text = lvs_default
End If
end event

type sle_1 from singlelineedit within w_ge231_selecao_diretorio
integer x = 32
integer y = 24
integer width = 1861
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
boolean autohscroll = false
borderstyle borderstyle = stylelowered!
end type

