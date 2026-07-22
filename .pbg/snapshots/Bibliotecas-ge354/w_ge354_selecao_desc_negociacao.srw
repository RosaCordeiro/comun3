HA$PBExportHeader$w_ge354_selecao_desc_negociacao.srw
forward
global type w_ge354_selecao_desc_negociacao from dc_w_selecao_generica
end type
end forward

global type w_ge354_selecao_desc_negociacao from dc_w_selecao_generica
integer x = 704
integer y = 436
integer width = 2482
integer height = 1528
string title = "GE354 - Sele$$HEX2$$e700e300$$ENDHEX$$o de Desconto Negocia$$HEX2$$e700e300$$ENDHEX$$o"
end type
global w_ge354_selecao_desc_negociacao w_ge354_selecao_desc_negociacao

type variables

end variables

on w_ge354_selecao_desc_negociacao.create
call super::create
end on

on w_ge354_selecao_desc_negociacao.destroy
call super::destroy
end on

event open;call super::open;String ls_Negociacao

uo_ge354_desc_negociacao lo_Negociacao
lo_Negociacao = Create uo_ge354_desc_negociacao

lo_Negociacao = Message.PowerObjectParm

ls_Negociacao = lo_Negociacao.is_Parametro

If ls_Negociacao <> "" Then
	dw_1.Object.Nm_Negociacao[1] = ls_Negociacao
	ivb_Pesquisa_Direta = True
End If
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge354_selecao_desc_negociacao
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge354_selecao_desc_negociacao
integer x = 18
integer y = 184
integer height = 1108
long backcolor = 80269524
string text = "Lista de Negocia$$HEX2$$e700f500$$ENDHEX$$es"
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge354_selecao_desc_negociacao
integer x = 18
integer y = 4
integer height = 172
long backcolor = 80269524
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge354_selecao_desc_negociacao
integer x = 41
integer y = 64
integer width = 2377
integer height = 104
string dataobject = "dw_ge354_selecao"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge354_selecao_desc_negociacao
integer x = 41
integer y = 236
integer width = 2377
integer height = 1036
string dataobject = "dw_ge354_lista"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String ls_Negociacao
String ls_Vigente
String ls_SQL

dw_1.AcceptText()

ls_Negociacao	= Trim(dw_1.Object.Nm_Negociacao	[1])
ls_Vigente		= dw_1.Object.Id_Vigente				[1]

If Not IsNull(ls_Negociacao) Then
	This.of_AppendWhere("nm_negociacao like '" + ls_Negociacao + "%'")
End If

ls_SQL = "(select * from negociacao x, parametro p " +&
		  "where x.dh_inicio <= p.dh_movimentacao " +& 
		  "		and (x.dh_termino is null or x.dh_termino >= p.dh_movimentacao) " +&
		  "		and n.cd_negociacao = x.cd_negociacao)"

If ls_Vigente <> "T" Then
	If ls_Vigente = "V" Then
		This.of_AppendWhere(" exists " + ls_SQL)
	Else
		This.of_AppendWhere("not exists " + ls_SQL)
	End If
End If

Return 1
end event

event dw_2::constructor;call super::constructor;This.ivb_Ordena_Colunas = True
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge354_selecao_desc_negociacao
integer x = 1682
integer y = 1312
end type

event cb_selecionar::clicked;call super::clicked;Long ll_Negociacao

dw_2.AcceptText()

If dw_2.GetRow() > 0 Then
	ll_Negociacao = dw_2.Object.Cd_Negociacao[dw_2.GetRow()]
	CloseWithReturn(Parent, String(ll_Negociacao))
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma negocia$$HEX2$$e700e300$$ENDHEX$$o.", Information!, Ok!)
	dw_2.SetFocus()
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge354_selecao_desc_negociacao
integer x = 2071
integer y = 1312
end type

event cb_cancelar::clicked;call super::clicked;String ls_Negociacao

SetNull(ls_Negociacao)

CloseWithReturn(Parent, ls_Negociacao)
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge354_selecao_desc_negociacao
integer x = 1271
integer y = 1312
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge354_selecao_desc_negociacao
integer x = 27
integer y = 1324
integer width = 992
long backcolor = 80269524
end type

