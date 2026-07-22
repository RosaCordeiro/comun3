HA$PBExportHeader$w_ge482_selecao_padrao_docto.srw
forward
global type w_ge482_selecao_padrao_docto from dc_w_selecao_generica
end type
end forward

global type w_ge482_selecao_padrao_docto from dc_w_selecao_generica
integer width = 2213
integer height = 1524
string title = "GE482 - Sele$$HEX2$$e700e300$$ENDHEX$$o Padr$$HEX1$$e300$$ENDHEX$$o Documento"
end type
global w_ge482_selecao_padrao_docto w_ge482_selecao_padrao_docto

type variables
uo_mult_padrao_docto ivo_padrao_docto
end variables

on w_ge482_selecao_padrao_docto.create
call super::create
end on

on w_ge482_selecao_padrao_docto.destroy
call super::destroy
end on

event open;call super::open;String lvs_filtro

ivo_padrao_docto = Message.PowerObjectParm

lvs_filtro = Upper(ivo_padrao_docto.ivs_Parametro_Selecao)

If lvs_filtro <> "" Then
	dw_1.Object.de_filtro[1] = lvs_filtro
End If
end event

event ue_postopen;call super::ue_postopen;dw_2.of_SetTransObject(ivo_padrao_docto.ivtr_trans)

If (ivo_padrao_docto.ivs_Parametro_Selecao) <> '' Then
 	dw_2.Event ue_Retrieve()
End if
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge482_selecao_padrao_docto
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge482_selecao_padrao_docto
integer y = 224
integer width = 2117
integer height = 1068
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge482_selecao_padrao_docto
integer width = 1659
integer height = 188
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge482_selecao_padrao_docto
integer width = 1577
integer height = 104
string dataobject = "dw_ge482_selecao_padrao_docto"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge482_selecao_padrao_docto
integer y = 296
integer width = 2066
integer height = 968
string dataobject = "dw_ge482_lista_padrao_docto"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Filtro

dw_1.Accepttext( )

lvs_Filtro		= dw_1.Object.de_filtro 			[1]

If Trim(lvs_Filtro)<>'' Then
	This.of_appendwhere("(upper(nmpadrao) like '%"+lvs_Filtro+"%')")
End If

Return AncestorReturnValue
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge482_selecao_padrao_docto
integer x = 1394
end type

event cb_selecionar::clicked;call super::clicked;Long lvl_Linha, &
     lvl_Id

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	lvl_Id = dw_2.Object.id [lvl_Linha]
	CloseWithReturn(Parent, String(lvl_Id))
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um Padr$$HEX1$$e300$$ENDHEX$$o de Documento.", Information!)
	dw_2.SetFocus()
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge482_selecao_padrao_docto
integer x = 1783
end type

event cb_cancelar::clicked;call super::clicked;Close(Parent)
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge482_selecao_padrao_docto
integer x = 951
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge482_selecao_padrao_docto
integer width = 919
end type

