HA$PBExportHeader$w_ge317_consulta_nf_venda_alteracao.srw
forward
global type w_ge317_consulta_nf_venda_alteracao from dc_w_response_ok_cancela
end type
end forward

global type w_ge317_consulta_nf_venda_alteracao from dc_w_response_ok_cancela
string tag = "w_ge317_consulta_nf_venda_alteracao"
integer width = 3497
integer height = 1380
string title = "GE317 - Consulta Notas Alteradas"
end type
global w_ge317_consulta_nf_venda_alteracao w_ge317_consulta_nf_venda_alteracao

type variables
String	ivs_Especie, &
		ivs_Serie
		
Long 	ivl_Cd_Filial, &
		ivl_Nr_Nf
end variables

event open;call super::open;String lvs_Parm

lvs_Parm = Message.StringParm

ivl_Cd_Filial 	= Long(MidA(lvs_Parm, 1, 4))
ivl_Nr_Nf		= Long(MidA(lvs_Parm, 5,8))
ivs_Especie 	= Trim(MidA(lvs_Parm, 13,3))
ivs_Serie		= Trim(MidA(lvs_Parm, 16,3))

dw_1.Event ue_Retrieve()


end event

on w_ge317_consulta_nf_venda_alteracao.create
call super::create
end on

on w_ge317_consulta_nf_venda_alteracao.destroy
call super::destroy
end on

event ue_postopen;//OverRide

ivo_dbError = Create dc_uo_dbError
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge317_consulta_nf_venda_alteracao
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge317_consulta_nf_venda_alteracao
integer width = 3442
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge317_consulta_nf_venda_alteracao
integer width = 3383
string dataobject = "dw_ge317_lista_nf_venda_alteracao"
boolean hscrollbar = true
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event dw_1::ue_recuperar;// OverRide

Return This.Retrieve(ivl_Cd_Filial, ivl_Nr_Nf, ivs_Especie, ivs_Serie)
end event

event dw_1::constructor;call super::constructor;ivi_Tipo_Cancelar = RETRIEVE
end event

event dw_1::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then	
	This.SetFocus()
	
	This.of_SetRowSelection()
End If

Return pl_Linhas
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge317_consulta_nf_venda_alteracao
integer x = 3154
end type

event cb_ok::clicked;call super::clicked;String lvs_Retorno

SetNull(lvs_Retorno)
CloseWithReturn(Parent, lvs_Retorno)
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge317_consulta_nf_venda_alteracao
boolean visible = false
integer x = 2821
end type

