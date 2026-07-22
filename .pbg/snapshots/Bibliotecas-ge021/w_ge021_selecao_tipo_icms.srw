HA$PBExportHeader$w_ge021_selecao_tipo_icms.srw
forward
global type w_ge021_selecao_tipo_icms from dc_w_selecao_generica
end type
end forward

global type w_ge021_selecao_tipo_icms from dc_w_selecao_generica
integer width = 2802
string title = "GE021 - Sele$$HEX2$$e700e300$$ENDHEX$$o Tipo ICMS"
end type
global w_ge021_selecao_tipo_icms w_ge021_selecao_tipo_icms

forward prototypes
public subroutine wf_insere_padrao ()
end prototypes

public subroutine wf_insere_padrao ();DataWindowChild	ldwc_Child

/*Grupo*/
ldwc_Child  = dw_1.of_InsertRow_DDDW("cd_uf" )			

ldwc_Child.SetItem(1, "cd_unidade_federacao", ""	)
ldwc_Child.SetItem(1, "nm_unidade_federacao", "TODOS")
ldwc_Child.SetItem(1, "nr_ordem", -1)

dw_1.Object.cd_uf[1] = ""
end subroutine

on w_ge021_selecao_tipo_icms.create
call super::create
end on

on w_ge021_selecao_tipo_icms.destroy
call super::destroy
end on

event ue_postopen;call super::ue_postopen;String lvs_Parametro
String lvs_Pesquisa
String lvs_UF

wf_insere_padrao()

lvs_Parametro = Message.StringParm

If Pos(lvs_Parametro,";") > 0 Then
	lvs_Pesquisa = Mid(lvs_Parametro,1,Pos(lvs_Parametro,";") - 1)
	lvs_UF		 =	Mid(lvs_Parametro, Pos(lvs_Parametro,";") + 1)
Else
	lvs_Pesquisa = gf_replace(lvs_Parametro, ";", "", 0)
End If

If Not IsNull(lvs_Parametro) and Trim(lvs_Parametro) <> "" Then
	dw_1.Object.de_pesquisa [1] = gf_replace(lvs_Parametro, ";", "", 0)
End If

If Not IsNull(lvs_UF) and Trim(lvs_UF)<>"" Then
	dw_1.Object.cd_uf [1] = lvs_UF
End If

If 	(Not IsNull(lvs_UF) and Trim(lvs_UF)<>"") or &
	(Not IsNull(lvs_Parametro) and Trim(lvs_Parametro) <> "") Then
	dw_2.Event ue_Retrieve()
End If
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge021_selecao_tipo_icms
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge021_selecao_tipo_icms
integer y = 300
integer width = 2747
integer height = 992
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge021_selecao_tipo_icms
integer width = 1499
integer height = 276
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge021_selecao_tipo_icms
integer width = 1445
integer height = 176
string dataobject = "dw_ge021_selecao_tipo_icms"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge021_selecao_tipo_icms
integer y = 372
integer width = 2679
integer height = 900
string dataobject = "dw_ge021_lista_tipo_icms"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_UF
String lvs_Filtro

dw_1.AcceptText( )

lvs_UF	= dw_1.Object.cd_uf 			[1]
lvs_Filtro	= dw_1.Object.de_pesquisa	[1]

If lvs_UF <> '' Then
	This.Of_AppendWhere("cd_unidade_federacao='"+lvs_UF+"'")
End If

If lvs_Filtro <> '' Then
	This.Of_AppendWhere("(de_tipo_icms like '%"+lvs_UF+"%'"+IIF(IsNumber(lvs_Filtro), " or cd_tipo_icms = "+lvs_Filtro, "")+")" )
End If

Return AncestorReturnValue
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge021_selecao_tipo_icms
integer x = 2016
end type

event cb_selecionar::clicked;call super::clicked;Long lvl_Tipo

If dw_2.GetRow() > 0 Then
	lvl_Tipo = dw_2.Object.cd_tipo_icms [dw_2.GetRow()]
	CloseWithReturn(Parent,String(lvl_Tipo))
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Selecione um registro antes de confirmar.", Exclamation!)
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge021_selecao_tipo_icms
integer x = 2405
end type

event cb_cancelar::clicked;call super::clicked;CloseWithReturn(Parent,"")
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge021_selecao_tipo_icms
integer x = 1573
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge021_selecao_tipo_icms
end type

