HA$PBExportHeader$w_ge038_lista_estoque.srw
forward
global type w_ge038_lista_estoque from dc_w_response_ok_cancela
end type
type st_1 from statictext within w_ge038_lista_estoque
end type
type cb_1 from commandbutton within w_ge038_lista_estoque
end type
end forward

global type w_ge038_lista_estoque from dc_w_response_ok_cancela
integer width = 2542
string title = "GE038 - Estoque Mensal Pendente Envio"
st_1 st_1
cb_1 cb_1
end type
global w_ge038_lista_estoque w_ge038_lista_estoque

on w_ge038_lista_estoque.create
int iCurrent
call super::create
this.st_1=create st_1
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.cb_1
end on

on w_ge038_lista_estoque.destroy
call super::destroy
destroy(this.st_1)
destroy(this.cb_1)
end on

event ue_postopen;call super::ue_postopen;String ls_envio_blocoX, ls_gera_blocoX, ls_mostra_botao

uo_Parametro_Filial lvo_Parametro
lvo_Parametro = Create uo_Parametro_Filial
lvo_Parametro.of_Localiza_Parametro("ID_ENVIA_ARQUIVO_BLOCOX", ref ls_envio_blocoX, False)		
lvo_Parametro.of_Localiza_Parametro("ID_GERA_ARQUIVO_BLOCOX", ref ls_gera_blocoX, False)		
Destroy(lvo_Parametro)

If ls_gera_blocoX = 'S' Then
	dw_1.Event ue_Retrieve()
	
	If dw_1.RowCount() = 0 Then 
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum Estoque Mensal pendente de envio!")
	End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Envio de pend$$HEX1$$ea00$$ENDHEX$$ncias Bloco X n$$HEX1$$e300$$ENDHEX$$o liberado.")
	Close(This)
End If

If ls_envio_blocoX = 'L' Then
	ls_mostra_botao = Message.stringparm
	If ls_mostra_botao <> 'N' Then
		This.cb_1.visible = True
	End If
End If

end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge038_lista_estoque
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge038_lista_estoque
integer width = 2482
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge038_lista_estoque
integer width = 2441
string dataobject = "dw_ge038_pendencias_estoque"
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge038_lista_estoque
boolean visible = false
integer x = 1851
integer y = 1172
boolean default = false
end type

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge038_lista_estoque
integer x = 2176
integer y = 1172
string text = "&Fechar"
boolean default = true
end type

type st_1 from statictext within w_ge038_lista_estoque
integer x = 663
integer y = 1140
integer width = 960
integer height = 168
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Para envio de pend$$HEX1$$ea00$$ENDHEX$$ncias use o Sistema de Caixa em Menu Fiscal / Envio FISCO-ESTOQUE"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_ge038_lista_estoque
boolean visible = false
integer x = 37
integer y = 1172
integer width = 544
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
Boolean lb_mensagem = False

uo_Menu_Fiscal lvo_Menu
lvo_Menu = Create uo_Menu_Fiscal

//For ll_row = 1 TO dw_1.RowCount()	
	If Not lvo_menu.of_envia_pendencias_blocox('EST', 0, False) Then
		lb_mensagem = False
	Else
		lb_mensagem = True
	End If
//Next

Destroy(lvo_Menu)

If lb_mensagem Then
	MessageBox("Aviso","Arquivos enviados com sucesso!",Information!)
End If

dw_1.Event ue_Retrieve()
end event

