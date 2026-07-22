HA$PBExportHeader$w_ge252_lista_protocolos.srw
forward
global type w_ge252_lista_protocolos from dc_w_base
end type
type dw_2 from datawindow within w_ge252_lista_protocolos
end type
type cb_2 from commandbutton within w_ge252_lista_protocolos
end type
type dw_1 from dc_uo_dw_base within w_ge252_lista_protocolos
end type
type gb_1 from groupbox within w_ge252_lista_protocolos
end type
end forward

global type w_ge252_lista_protocolos from dc_w_base
string tag = "w_ge252_lista_protocolos"
integer width = 1618
integer height = 1152
string title = "GE252 - Protocolo Defeito F$$HEX1$$e100$$ENDHEX$$brica"
boolean controlmenu = false
boolean minbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 134217750
dw_2 dw_2
cb_2 cb_2
dw_1 dw_1
gb_1 gb_1
end type
global w_ge252_lista_protocolos w_ge252_lista_protocolos

type variables
Long il_qtde_Recebida, il_Qtde_Informada
		
st_parametros_protocolo ist_parametros_protocolo
end variables

forward prototypes
public function boolean wf_valida_quantidade (string as_protocolo, long al_qtd)
end prototypes

public function boolean wf_valida_quantidade (string as_protocolo, long al_qtd);long ll_selecinados, ll_find, ll_insert, ll_nova_qtd

dw_2.accepttext()
ll_selecinados = dw_2.rowcount()

if ll_selecinados > 0 then
	ll_find = dw_2.find("nr_protocolo = '" + as_protocolo + "'", 0, ll_selecinados)
	if ll_find > 0 then
		dw_2.object.qt_lote[ll_find] = al_qtd
	else
		ll_insert = dw_2.insertrow(0)
		dw_2.object.cd_produto[ll_insert] = ist_parametros_protocolo.cd_produto
		dw_2.object.nr_lote[ll_insert] = ist_parametros_protocolo.nr_lote
		dw_2.object.nr_protocolo[ll_insert] = as_protocolo
		dw_2.object.qt_lote[ll_insert] = al_qtd
	end if
else
	ll_insert = dw_2.insertrow(0)
	dw_2.object.cd_produto[ll_insert] = ist_parametros_protocolo.cd_produto
	dw_2.object.nr_lote[ll_insert] = ist_parametros_protocolo.nr_lote
	dw_2.object.nr_protocolo[ll_insert] = as_protocolo
	dw_2.object.qt_lote[ll_insert] = al_qtd
end if
		
Return True

end function

on w_ge252_lista_protocolos.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.cb_2=create cb_2
this.dw_1=create dw_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.gb_1
end on

on w_ge252_lista_protocolos.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.cb_2)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event ue_postopen;call super::ue_postopen;long ll_linhas

ist_parametros_protocolo = Message.PowerObjectParm	

ll_Linhas = dw_1.Retrieve(ist_parametros_protocolo.nr_agrupamento)

If ll_Linhas < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o protocolo!")
	Return
End If

If ll_Linhas = 0 Then MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizado nenhum um Protocolo para o agrupamento selecionado.")
end event

type dw_2 from datawindow within w_ge252_lista_protocolos
boolean visible = false
integer x = 64
integer y = 1132
integer width = 2194
integer height = 548
integer taborder = 30
boolean enabled = false
string title = "none"
string dataobject = "ds_ge252_qtd_selecao_protocolo"
boolean border = false
boolean livescroll = true
end type

type cb_2 from commandbutton within w_ge252_lista_protocolos
integer x = 1275
integer y = 968
integer width = 311
integer height = 96
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "OK"
end type

event clicked;close(parent)
end event

type dw_1 from dc_uo_dw_base within w_ge252_lista_protocolos
integer x = 64
integer y = 56
integer width = 1499
integer height = 896
integer taborder = 20
string dataobject = "dw_ge252_lista_protocolos"
boolean vscrollbar = true
boolean livescroll = false
end type

type gb_1 from groupbox within w_ge252_lista_protocolos
integer x = 32
integer width = 1545
integer height = 964
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 134217750
borderstyle borderstyle = styleraised!
end type

