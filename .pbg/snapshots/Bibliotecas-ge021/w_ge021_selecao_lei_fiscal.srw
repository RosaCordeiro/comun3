HA$PBExportHeader$w_ge021_selecao_lei_fiscal.srw
forward
global type w_ge021_selecao_lei_fiscal from dc_w_selecao_generica
end type
end forward

global type w_ge021_selecao_lei_fiscal from dc_w_selecao_generica
integer width = 2889
string title = "GE021 - Sele$$HEX2$$e700e300$$ENDHEX$$o Lei Fiscal SAP"
end type
global w_ge021_selecao_lei_fiscal w_ge021_selecao_lei_fiscal

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

on w_ge021_selecao_lei_fiscal.create
call super::create
end on

on w_ge021_selecao_lei_fiscal.destroy
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

type pb_help from dc_w_selecao_generica`pb_help within w_ge021_selecao_lei_fiscal
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge021_selecao_lei_fiscal
integer y = 300
integer width = 2807
integer height = 992
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge021_selecao_lei_fiscal
integer width = 1499
integer height = 276
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge021_selecao_lei_fiscal
integer width = 1445
integer height = 176
string dataobject = "dw_ge021_selecao_lei_fiscal"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge021_selecao_lei_fiscal
integer y = 372
integer width = 2738
integer height = 900
string dataobject = "dw_ge021_lista_lei_fiscal"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_UF
String lvs_Filtro

dw_1.AcceptText( )

lvs_UF	= dw_1.Object.cd_uf 			[1]
lvs_Filtro	= dw_1.Object.de_pesquisa	[1]

If lvs_UF <> '' Then
	This.Of_AppendWhere("cd_uf='"+lvs_UF+"'")
End If

If lvs_Filtro <> '' Then
	This.Of_AppendWhere("(de_lei_fiscal_sap like '%"+lvs_Filtro+"%'"+IIF(Len(lvs_Filtro)<=3, " or cd_lei_fiscal_sap = '"+lvs_Filtro+"'", "")+")" )
End If

Return AncestorReturnValue
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge021_selecao_lei_fiscal
integer x = 2085
end type

event cb_selecionar::clicked;call super::clicked;String lvs_Lei

If dw_2.GetRow() > 0 Then
	lvs_Lei = dw_2.Object.cd_lei_fiscal_sap [dw_2.GetRow()]
	CloseWithReturn(Parent,lvs_Lei)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Selecione um registro antes de confirmar.", Exclamation!)
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge021_selecao_lei_fiscal
integer x = 2473
end type

event cb_cancelar::clicked;call super::clicked;CloseWithReturn(Parent,"")
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge021_selecao_lei_fiscal
integer x = 1641
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge021_selecao_lei_fiscal
end type

