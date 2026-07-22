HA$PBExportHeader$w_ge038_identificacao_paf_nfc.srw
forward
global type w_ge038_identificacao_paf_nfc from dc_w_response
end type
type gb_1 from groupbox within w_ge038_identificacao_paf_nfc
end type
type cb_fechar from commandbutton within w_ge038_identificacao_paf_nfc
end type
type st_1 from statictext within w_ge038_identificacao_paf_nfc
end type
type st_2 from statictext within w_ge038_identificacao_paf_nfc
end type
type st_3 from statictext within w_ge038_identificacao_paf_nfc
end type
type st_4 from statictext within w_ge038_identificacao_paf_nfc
end type
type st_5 from statictext within w_ge038_identificacao_paf_nfc
end type
type st_6 from statictext within w_ge038_identificacao_paf_nfc
end type
type st_7 from statictext within w_ge038_identificacao_paf_nfc
end type
type st_8 from statictext within w_ge038_identificacao_paf_nfc
end type
type st_9 from statictext within w_ge038_identificacao_paf_nfc
end type
type st_10 from statictext within w_ge038_identificacao_paf_nfc
end type
type st_versao from statictext within w_ge038_identificacao_paf_nfc
end type
type st_transparente from statictext within w_ge038_identificacao_paf_nfc
end type
end forward

global type w_ge038_identificacao_paf_nfc from dc_w_response
integer width = 2039
string title = "GE038 - Identifica$$HEX2$$e700e300$$ENDHEX$$o PAF-NFC-e"
gb_1 gb_1
cb_fechar cb_fechar
st_1 st_1
st_2 st_2
st_3 st_3
st_4 st_4
st_5 st_5
st_6 st_6
st_7 st_7
st_8 st_8
st_9 st_9
st_10 st_10
st_versao st_versao
st_transparente st_transparente
end type
global w_ge038_identificacao_paf_nfc w_ge038_identificacao_paf_nfc

type variables
String is_versao
end variables

on w_ge038_identificacao_paf_nfc.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.cb_fechar=create cb_fechar
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.st_5=create st_5
this.st_6=create st_6
this.st_7=create st_7
this.st_8=create st_8
this.st_9=create st_9
this.st_10=create st_10
this.st_versao=create st_versao
this.st_transparente=create st_transparente
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.cb_fechar
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.st_3
this.Control[iCurrent+6]=this.st_4
this.Control[iCurrent+7]=this.st_5
this.Control[iCurrent+8]=this.st_6
this.Control[iCurrent+9]=this.st_7
this.Control[iCurrent+10]=this.st_8
this.Control[iCurrent+11]=this.st_9
this.Control[iCurrent+12]=this.st_10
this.Control[iCurrent+13]=this.st_versao
this.Control[iCurrent+14]=this.st_transparente
end on

on w_ge038_identificacao_paf_nfc.destroy
call super::destroy
destroy(this.gb_1)
destroy(this.cb_fechar)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.st_6)
destroy(this.st_7)
destroy(this.st_8)
destroy(this.st_9)
destroy(this.st_10)
destroy(this.st_versao)
destroy(this.st_transparente)
end on

event ue_postopen;call super::ue_postopen;
// Localiza$$HEX2$$e700e300$$ENDHEX$$o da Vers$$HEX1$$e300$$ENDHEX$$o do Sistema ----------------------------------------- //
Select nr_versao
  Into :is_Versao
  From sistema
 Where cd_sistema = 'CL'
 Using SQLCa;

If SQLCa.SQLCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao localizar a vers$$HEX1$$e300$$ENDHEX$$o do sistema.")
	This.event close( )
End If
//--------------------------------------------------------------------------- //

This.st_versao.text = "Vers$$HEX1$$e300$$ENDHEX$$o: " + is_versao



end event

type pb_help from dc_w_response`pb_help within w_ge038_identificacao_paf_nfc
boolean visible = false
integer x = 82
integer y = 1116
integer taborder = 20
boolean enabled = false
end type

type gb_1 from groupbox within w_ge038_identificacao_paf_nfc
integer x = 46
integer y = 28
integer width = 1938
integer height = 1044
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Identifica$$HEX2$$e700e300$$ENDHEX$$o PAF-NFC-e"
end type

type cb_fechar from commandbutton within w_ge038_identificacao_paf_nfc
integer x = 1586
integer y = 1112
integer width = 402
integer height = 112
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "&Fechar"
boolean default = true
end type

event clicked;Close(Parent)
end event

type st_1 from statictext within w_ge038_identificacao_paf_nfc
integer x = 160
integer y = 112
integer width = 430
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 128
long backcolor = 67108864
string text = "Desenvolvedor:"
boolean focusrectangle = false
end type

type st_2 from statictext within w_ge038_identificacao_paf_nfc
integer x = 215
integer y = 280
integer width = 1303
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long backcolor = 67108864
string text = "CIA LATINO AMERICANA DE MEDICAMENTOS"
boolean focusrectangle = false
end type

type st_3 from statictext within w_ge038_identificacao_paf_nfc
integer x = 215
integer y = 204
integer width = 1303
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long backcolor = 67108864
string text = "84.683.481/0001-77"
boolean focusrectangle = false
end type

type st_4 from statictext within w_ge038_identificacao_paf_nfc
integer x = 215
integer y = 360
integer width = 1554
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long backcolor = 67108864
string text = "RUA 9 DE MARCO 638 - CENTRO - CEP: 89.201-40"
boolean focusrectangle = false
end type

type st_5 from statictext within w_ge038_identificacao_paf_nfc
integer x = 215
integer y = 444
integer width = 1554
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long backcolor = 67108864
string text = "JOINVILLE - SANTA CATARINA"
boolean focusrectangle = false
end type

type st_6 from statictext within w_ge038_identificacao_paf_nfc
integer x = 215
integer y = 524
integer width = 1554
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long backcolor = 67108864
string text = "FONE: (47) 3461-9994 FAX: (47) 3461-9959"
boolean focusrectangle = false
end type

type st_7 from statictext within w_ge038_identificacao_paf_nfc
integer x = 215
integer y = 612
integer width = 1554
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long backcolor = 67108864
string text = "CONTATO: ADMOCIR SANTANA SILVA"
boolean focusrectangle = false
end type

type st_8 from statictext within w_ge038_identificacao_paf_nfc
integer x = 215
integer y = 696
integer width = 1554
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long backcolor = 67108864
string text = "admocir.silva@clamed.com.br"
boolean focusrectangle = false
end type

type st_9 from statictext within w_ge038_identificacao_paf_nfc
integer x = 160
integer y = 788
integer width = 544
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 128
long backcolor = 67108864
string text = "Sistema PAF-NFC-e:"
boolean focusrectangle = false
end type

type st_10 from statictext within w_ge038_identificacao_paf_nfc
integer x = 215
integer y = 872
integer width = 1554
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long backcolor = 67108864
string text = "SISTEMA DE CAIXA"
boolean focusrectangle = false
end type

type st_versao from statictext within w_ge038_identificacao_paf_nfc
integer x = 215
integer y = 944
integer width = 1554
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long backcolor = 67108864
string text = "versao"
boolean focusrectangle = false
end type

type st_transparente from statictext within w_ge038_identificacao_paf_nfc
integer x = 101
integer y = 92
integer width = 1833
integer height = 952
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long backcolor = 553648127
boolean focusrectangle = false
end type

