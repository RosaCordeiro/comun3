HA$PBExportHeader$w_ge465_selecao_desc_progressivo.srw
forward
global type w_ge465_selecao_desc_progressivo from dc_w_selecao_generica
end type
end forward

global type w_ge465_selecao_desc_progressivo from dc_w_selecao_generica
string tag = "w_ge465_selecao_desc_progressivo"
integer x = 704
integer y = 436
integer width = 1733
integer height = 1460
string title = "GE465 - Sele$$HEX2$$e700e300$$ENDHEX$$o de Desconto Progressivo"
end type
global w_ge465_selecao_desc_progressivo w_ge465_selecao_desc_progressivo

type variables

end variables

on w_ge465_selecao_desc_progressivo.create
call super::create
end on

on w_ge465_selecao_desc_progressivo.destroy
call super::destroy
end on

event open;call super::open;String ls_Negociacao

uo_ge465_desc_progressivo lo_Negociacao
lo_Negociacao = Create uo_ge465_desc_progressivo

lo_Negociacao = Message.PowerObjectParm

ls_Negociacao = lo_Negociacao.is_Parametro

If ls_Negociacao <> "" Then
	dw_1.Object.Nm_Desconto[1] = ls_Negociacao
	ivb_Pesquisa_Direta = True
End If


end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge465_selecao_desc_progressivo
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge465_selecao_desc_progressivo
integer x = 18
integer y = 228
integer width = 1673
integer height = 956
long backcolor = 80269524
string text = "Lista dos Descontos Progressivos"
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge465_selecao_desc_progressivo
integer x = 18
integer y = 4
integer width = 1669
integer height = 216
long backcolor = 80269524
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge465_selecao_desc_progressivo
integer x = 41
integer y = 84
integer width = 1632
integer height = 128
string dataobject = "dw_ge465_selecao"
end type

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	If This.GetColumnName() = "nm_desconto" Then
		
//		If ivb_Valida_Salva Then
//			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existem altera$$HEX2$$e700f500$$ENDHEX$$es pendentes. Salve ou cancele as altera$$HEX2$$e700f500$$ENDHEX$$es.", Exclamation!)
//			Return -1
//		End If
		
//		io_Negociacao.of_Localiza_Negociacao(This.GetText())
		
//		If io_Negociacao.Localizada Then
//			dw_1.Object.Cd_Desconto[1] = io_Negociacao.Cd_Desconto
//		This.Event ue_Retrieve()
//		Else
//		io_Negociacao.of_Inicializa()
//		End If
	End If
	
End If
end event

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge465_selecao_desc_progressivo
integer x = 50
integer y = 292
integer width = 1495
integer height = 872
string dataobject = "dw_ge465_lista"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String ls_Desconto
String ls_Ativo
String ls_SQL

dw_1.AcceptText()

ls_Desconto	= Trim(dw_1.Object.Nm_Desconto	[1])


If Not IsNull(ls_Desconto) Then
	This.of_AppendWhere("de_desconto like '" + ls_Desconto + "%'")
End If

Return 1
end event

event dw_2::constructor;call super::constructor;This.ivb_Ordena_Colunas = True
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge465_selecao_desc_progressivo
integer x = 933
integer y = 1188
end type

event cb_selecionar::clicked;call super::clicked;Long ll_Desconto

dw_2.AcceptText()

If dw_2.GetRow() > 0 Then
	ll_Desconto = dw_2.Object.Cd_Desconto[dw_2.GetRow()]
	CloseWithReturn(Parent, String(ll_Desconto))
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um desconto.", Information!, Ok!)
	dw_2.SetFocus()
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge465_selecao_desc_progressivo
integer x = 1321
integer y = 1188
end type

event cb_cancelar::clicked;call super::clicked;String ls_Desconto

SetNull(ls_Desconto)

CloseWithReturn(Parent, ls_Desconto)
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge465_selecao_desc_progressivo
integer x = 521
integer y = 1188
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge465_selecao_desc_progressivo
integer y = 1304
integer width = 992
integer height = 64
long backcolor = 80269524
end type

