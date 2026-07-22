HA$PBExportHeader$w_ge232_selecionar_lote.srw
forward
global type w_ge232_selecionar_lote from dc_w_response_ok_cancela
end type
type st_nome from statictext within w_ge232_selecionar_lote
end type
type sle_lote from singlelineedit within w_ge232_selecionar_lote
end type
end forward

global type w_ge232_selecionar_lote from dc_w_response_ok_cancela
integer width = 997
integer height = 504
string title = "GE232 - Lotes de Controlados"
st_nome st_nome
sle_lote sle_lote
end type
global w_ge232_selecionar_lote w_ge232_selecionar_lote

type variables
uo_saldo_lote ivo_saldo_lote

long ivl_Produto
end variables

on w_ge232_selecionar_lote.create
int iCurrent
call super::create
this.st_nome=create st_nome
this.sle_lote=create sle_lote
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_nome
this.Control[iCurrent+2]=this.sle_lote
end on

on w_ge232_selecionar_lote.destroy
call super::destroy
destroy(this.st_nome)
destroy(this.sle_lote)
end on

event ue_postopen;call super::ue_postopen;ivo_Saldo_Lote.of_preenche_lista_matriz(dw_1, 534, ivl_Produto)

DataWindowChild lvdwc

Integer lvi_Retorno,&
        lvi_Row

If dw_1.GetChild("nr_lote", lvdwc) = 1 Then
	 lvi_Row = lvdwc.InsertRow(0)
	
	lvdwc.SetItem(lvi_Row, "nr_lote", "NAO CADAST")

//	dw_1.Object.Cd_grupo[1] = "0"
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild do Grupo.")
End If

end event

event open;call super::open;ivo_saldo_lote = Create uo_saldo_lote

ivl_Produto = Long(Message.StringParm)
end event

event close;call super::close;Destroy(ivo_saldo_lote)
end event

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge232_selecionar_lote
integer width = 914
integer height = 260
string text = "Lotes"
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge232_selecionar_lote
integer x = 50
integer width = 855
integer height = 96
string dragicon = "AppRectangle!"
string dataobject = "dw_ge232_lista_lote"
end type

event dw_1::itemchanged;call super::itemchanged;If data = 'NAO CADAST' Then
	st_nome.visible	= true
	sle_lote.visible	= true
	sle_lote.setfocus()
Else
	st_nome.visible	= false
	sle_lote.visible	= false
End if

end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge232_selecionar_lote
integer x = 626
integer y = 296
end type

event cb_ok::clicked;call super::clicked;String lvs_Lote

lvs_Lote = dw_1.Object.nr_lote[1]

If lvs_Lote = 'NAO CADAST' Then
	lvs_Lote = sle_lote.text
End If

If IsNull(lvs_Lote) or Trim(lvs_Lote) = '' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione ou informe o lote do produto controlado.")
	dw_1.SetFocus()
	dw_1.SetColumn('nr_lote')
	Return
End If

CloseWithReturn(Parent, lvs_Lote)
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge232_selecionar_lote
boolean visible = false
integer x = 1070
integer y = 16
integer width = 110
end type

type st_nome from statictext within w_ge232_selecionar_lote
boolean visible = false
integer x = 64
integer y = 156
integer width = 366
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Digite o Lote:"
boolean focusrectangle = false
end type

type sle_lote from singlelineedit within w_ge232_selecionar_lote
boolean visible = false
integer x = 425
integer y = 156
integer width = 443
integer height = 64
integer taborder = 30
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
textcase textcase = upper!
end type

