HA$PBExportHeader$w_ge250_importacao_chaves.srw
forward
global type w_ge250_importacao_chaves from dc_w_response_ok_cancela
end type
type pb_localiza from picturebutton within w_ge250_importacao_chaves
end type
end forward

global type w_ge250_importacao_chaves from dc_w_response_ok_cancela
integer width = 2295
integer height = 500
string title = "ge250 - Insere Estoque M$$HEX1$$ed00$$ENDHEX$$nimo na Promo$$HEX2$$e700e300$$ENDHEX$$o "
long backcolor = 80269524
pb_localiza pb_localiza
end type
global w_ge250_importacao_chaves w_ge250_importacao_chaves

type variables

end variables

on w_ge250_importacao_chaves.create
int iCurrent
call super::create
this.pb_localiza=create pb_localiza
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_localiza
end on

on w_ge250_importacao_chaves.destroy
call super::destroy
destroy(this.pb_localiza)
end on

event ue_postopen;call super::ue_postopen;cb_OK.Enabled = False

end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge250_importacao_chaves
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge250_importacao_chaves
integer width = 2203
integer height = 244
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o de Arquivo"
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge250_importacao_chaves
integer x = 37
integer y = 100
integer width = 2030
integer height = 76
string dataobject = "dw_ge250_selecao_arquivo"
boolean livescroll = false
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge250_importacao_chaves
integer x = 1573
integer y = 284
end type

event cb_ok::clicked;String lvs_Arquivo

dw_1.AcceptText()

lvs_Arquivo = dw_1.Object.nm_arquivo [1]

ClosewithReturn(Parent, lvs_Arquivo) 
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge250_importacao_chaves
integer x = 1915
integer y = 284
end type

type pb_localiza from picturebutton within w_ge250_importacao_chaves
string tag = "Localiza o arquivo com os produtos da promo$$HEX2$$e700e300$$ENDHEX$$o."
integer x = 2057
integer y = 92
integer width = 128
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\localizar_arquivo.bmp"
end type

event clicked;String lvs_Path, &
       lvs_Nome_Arquivo
		 
Integer lvi_Arquivo
		 
lvi_Arquivo = GetFileOpenName("Seleciona o arquivo", + lvs_Path, lvs_Nome_Arquivo, "XLSX", "Excel 2007 (*.XLSX),*.XLSX, Excel (*.XLS), *.XLS")

If lvi_Arquivo = 1 Then
	dw_1.Object.nm_arquivo[1] = lvs_Path
	cb_OK.Enabled = True
End If
end event

