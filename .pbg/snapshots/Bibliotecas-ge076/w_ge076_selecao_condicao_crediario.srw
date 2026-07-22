HA$PBExportHeader$w_ge076_selecao_condicao_crediario.srw
forward
global type w_ge076_selecao_condicao_crediario from dc_w_selecao_generica
end type
end forward

global type w_ge076_selecao_condicao_crediario from dc_w_selecao_generica
integer width = 3570
integer height = 1684
string title = "GE076 - Sele$$HEX2$$e700e300$$ENDHEX$$o de Condi$$HEX2$$e700f500$$ENDHEX$$es de Credi$$HEX1$$e100$$ENDHEX$$rio"
long backcolor = 80269524
end type
global w_ge076_selecao_condicao_crediario w_ge076_selecao_condicao_crediario

type variables
uo_Condicao_Crediario ivo_Condicao
end variables

on w_ge076_selecao_condicao_crediario.create
call super::create
end on

on w_ge076_selecao_condicao_crediario.destroy
call super::destroy
end on

event open;call super::open;STRING lvs_Condicao

ivo_Condicao = Message.PowerObjectParm

lvs_Condicao = ivo_Condicao.ivs_Parametro_Selecao

If lvs_Condicao <> "" Then
	dw_1.Object.De_Condicao_Crediario[1] = lvs_Condicao
End If

ivb_Pesquisa_Direta = True
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge076_selecao_condicao_crediario
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge076_selecao_condicao_crediario
integer x = 23
integer y = 284
integer width = 3493
integer height = 1148
long backcolor = 80269524
string text = "Lista de Condi$$HEX2$$e700f500$$ENDHEX$$es"
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge076_selecao_condicao_crediario
integer x = 23
integer y = 4
integer width = 1618
integer height = 264
long backcolor = 80269524
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge076_selecao_condicao_crediario
integer x = 50
integer y = 72
integer width = 1577
integer height = 160
string dataobject = "dw_selecao_condicao_venda_crediario"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge076_selecao_condicao_crediario
integer x = 55
integer y = 344
integer width = 3438
integer height = 1068
string dataobject = "dw_cadastro_condicao_venda_crediario"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Condicao

Long	 lvl_Nr_Parcelas

dw_1.AcceptText()

lvs_Condicao    = Trim(dw_1.Object.De_Condicao_Crediario[1])
lvl_Nr_Parcelas = dw_1.Object.Nr_Parcelas[1]

If lvs_Condicao <> "" Then
	This.of_AppendWhere("de_condicao_crediario like '" + lvs_Condicao + "%'")
End If

If Not IsNull(lvl_Nr_Parcelas) Then
	This.of_AppendWhere("nr_parcelas = " + String(lvl_Nr_Parcelas) )
End If

Return AncestorReturnValue
end event

event dw_2::constructor;call super::constructor;This.of_SetRowSelection("if (id_ativa = ~"S~", rgb(255,255,255), rgb(255,0,0))","")
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge076_selecao_condicao_crediario
integer x = 2747
integer y = 1464
end type

event cb_selecionar::clicked;call super::clicked;Long lvl_Linha

String lvs_Condicao

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	lvs_Condicao = String(dw_2.Object.Cd_Condicao_Crediario[lvl_Linha])
	CloseWithReturn(Parent, lvs_Condicao)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma condi$$HEX2$$e700e300$$ENDHEX$$o na lista.", Information!, Ok!)
	dw_2.SetFocus()
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge076_selecao_condicao_crediario
integer x = 3145
integer y = 1464
end type

event cb_cancelar::clicked;call super::clicked;String lvs_Cd_Condicao

SetNull(lvs_Cd_Condicao)

CloseWithReturn(Parent, lvs_Cd_Condicao)
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge076_selecao_condicao_crediario
integer x = 2213
integer y = 1464
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge076_selecao_condicao_crediario
integer x = 23
integer y = 1476
long backcolor = 80269524
end type

