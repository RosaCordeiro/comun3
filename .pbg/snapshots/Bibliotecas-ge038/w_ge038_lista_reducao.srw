HA$PBExportHeader$w_ge038_lista_reducao.srw
forward
global type w_ge038_lista_reducao from dc_w_response_ok_cancela
end type
type st_1 from statictext within w_ge038_lista_reducao
end type
type cb_envio_pendencias from commandbutton within w_ge038_lista_reducao
end type
type cb_xml from commandbutton within w_ge038_lista_reducao
end type
end forward

global type w_ge038_lista_reducao from dc_w_response_ok_cancela
integer width = 2958
string title = "GE038 - Redu$$HEX2$$e700e300$$ENDHEX$$o Z Pendente Envio"
st_1 st_1
cb_envio_pendencias cb_envio_pendencias
cb_xml cb_xml
end type
global w_ge038_lista_reducao w_ge038_lista_reducao

on w_ge038_lista_reducao.create
int iCurrent
call super::create
this.st_1=create st_1
this.cb_envio_pendencias=create cb_envio_pendencias
this.cb_xml=create cb_xml
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.cb_envio_pendencias
this.Control[iCurrent+3]=this.cb_xml
end on

on w_ge038_lista_reducao.destroy
call super::destroy
destroy(this.st_1)
destroy(this.cb_envio_pendencias)
destroy(this.cb_xml)
end on

event ue_postopen;call super::ue_postopen;String ls_envio_blocoX, ls_gera_blocoX

uo_Parametro_Filial lvo_Parametro
lvo_Parametro = Create uo_Parametro_Filial
lvo_Parametro.of_Localiza_Parametro("ID_ENVIA_ARQUIVO_BLOCOX", ref ls_envio_blocoX, False)		
lvo_Parametro.of_Localiza_Parametro("ID_GERA_ARQUIVO_BLOCOX", ref ls_gera_blocoX, False)		
Destroy(lvo_Parametro)

If ls_gera_blocoX = 'S' Then
	dw_1.Event ue_Retrieve()
	
	If dw_1.RowCount() = 0 Then 
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma Redu$$HEX2$$e700e300$$ENDHEX$$o Z pendente de envio!")
	End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Envio de pend$$HEX1$$ea00$$ENDHEX$$ncias Bloco X n$$HEX1$$e300$$ENDHEX$$o liberado.")
	Close(This)
End If

If ls_envio_blocoX = 'L' Then
	This.cb_envio_pendencias.visible = True
End If
	

end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge038_lista_reducao
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge038_lista_reducao
integer width = 2894
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge038_lista_reducao
integer width = 2848
string dataobject = "dw_ge038_pendencias_reducao"
boolean hscrollbar = true
boolean vscrollbar = true
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge038_lista_reducao
boolean visible = false
integer x = 2258
integer y = 1172
boolean default = false
end type

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge038_lista_reducao
integer x = 2583
integer y = 1172
string text = "&Fechar"
boolean default = true
end type

type st_1 from statictext within w_ge038_lista_reducao
integer x = 622
integer y = 1160
integer width = 1605
integer height = 120
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Para envio de pend$$HEX1$$ea00$$ENDHEX$$ncias use o Sistema de Caixa em Menu Fiscal / Envio FISCO-REDU$$HEX2$$c700c300$$ENDHEX$$OZ"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_envio_pendencias from commandbutton within w_ge038_lista_reducao
boolean visible = false
integer x = 27
integer y = 1132
integer width = 562
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Enviar pend$$HEX1$$ea00$$ENDHEX$$ncias"
end type

event clicked;Long ll_row
Long ll_ecf
Boolean lb_mensagem = False

uo_Menu_Fiscal lvo_Menu
lvo_Menu = Create uo_Menu_Fiscal

For ll_row = 1 TO dw_1.RowCount()	
	ll_ecf = dw_1.Object.nr_ecf[ll_row]
	If Not lvo_menu.of_envia_pendencias_blocox('RZ', ll_ecf, False) Then
		Exit
	Else
		lb_mensagem = True
	End If
Next

Destroy(lvo_Menu)

If lb_mensagem Then
	MessageBox("Aviso","Arquivos enviados com sucesso!",Information!)
End If

dw_1.Event ue_Retrieve()
end event

type cb_xml from commandbutton within w_ge038_lista_reducao
boolean visible = false
integer x = 27
integer y = 1220
integer width = 562
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Gera Xml Pend"
end type

event clicked;Long ll_row
Long ll_ecf
Boolean lb_mensagem = False

uo_Menu_Fiscal lvo_Menu
lvo_Menu = Create uo_Menu_Fiscal

If Not lvo_menu.of_envia_pendencias_blocox_matriz('RZ', 0, False, False) Then
	//erro
Else
	lb_mensagem = True
End If

Destroy(lvo_Menu)

If lb_mensagem Then
	MessageBox("Aviso","Arquivos Gerados com sucesso!",Information!)
End If

dw_1.Event ue_Retrieve()
end event

