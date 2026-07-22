HA$PBExportHeader$w_ge260_selecao_analise.srw
forward
global type w_ge260_selecao_analise from dc_w_selecao_generica
end type
end forward

global type w_ge260_selecao_analise from dc_w_selecao_generica
integer width = 2455
integer height = 1376
string title = "GE260 - Sele$$HEX2$$e700e300$$ENDHEX$$o An$$HEX1$$e100$$ENDHEX$$lise Spaceman"
end type
global w_ge260_selecao_analise w_ge260_selecao_analise

type variables
string is_id_vending_machine
end variables

on w_ge260_selecao_analise.create
call super::create
end on

on w_ge260_selecao_analise.destroy
call super::destroy
end on

event open;call super::open;String ls_Analise
st_generica lst_param

if isvalid(message.powerobjectparm) Then
	if message.powerobjectparm.classname() = lst_param.classname() Then
		lst_param = message.powerobjectparm
		
		ls_analise = lst_param.string_par[1]
		is_id_vending_machine = lst_param.string_par[2]
		
	end if
	
else
	ls_Analise = Message.StringParm
	setnull(is_id_vending_machine)
end if

If ls_Analise <> "" Then
	dw_1.Object.de_alteracao[1] = ls_Analise
	dw_1.AcceptText()
End If

ivb_Pesquisa_Direta = True	
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge260_selecao_analise
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge260_selecao_analise
integer y = 212
integer width = 2386
integer height = 936
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge260_selecao_analise
integer width = 1746
integer height = 188
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge260_selecao_analise
integer x = 64
integer width = 1691
integer height = 76
string dataobject = "dw_ge260_selecao"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge260_selecao_analise
integer y = 284
integer width = 2313
integer height = 844
string dataobject = "dw_ge260_lista"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String ls_Descricao

dw_1.AcceptText()

ls_Descricao = Trim( dw_1.Object.de_alteracao [1] )

If ls_Descricao <> "" Then
	This.of_AppendWhere("de_analise like '" + ls_Descricao + "%'")
End If

if is_id_vending_machine <> '' and not isnull(is_id_vending_machine) Then
	This.of_AppendWhere("coalesce(id_vending_machine,'N') = '" + is_id_vending_machine + "'")
end if

Return 1
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge260_selecao_analise
integer x = 1664
integer y = 1172
end type

event cb_selecionar::clicked;call super::clicked;Long ll_Linha, &
     ll_Analise

ll_Linha = dw_2.GetRow()

If ll_Linha > 0 Then
	ll_Analise = dw_2.Object.nr_analise [ ll_Linha ]
	CloseWithReturn(Parent, String( ll_Analise) )
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma an$$HEX1$$e100$$ENDHEX$$lise na lista.", Information! )
	dw_2.SetFocus()
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge260_selecao_analise
integer x = 2053
integer y = 1172
end type

event cb_cancelar::clicked;call super::clicked;CloseWithReturn(Parent, '')
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge260_selecao_analise
integer x = 1221
integer y = 1172
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge260_selecao_analise
integer y = 1172
end type

