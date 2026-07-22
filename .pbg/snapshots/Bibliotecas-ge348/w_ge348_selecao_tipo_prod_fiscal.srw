HA$PBExportHeader$w_ge348_selecao_tipo_prod_fiscal.srw
forward
global type w_ge348_selecao_tipo_prod_fiscal from dc_w_selecao_generica
end type
end forward

global type w_ge348_selecao_tipo_prod_fiscal from dc_w_selecao_generica
string title = "GE348 - Sele$$HEX2$$e700e300$$ENDHEX$$o Tipo Produto Fiscal"
end type
global w_ge348_selecao_tipo_prod_fiscal w_ge348_selecao_tipo_prod_fiscal

forward prototypes
public subroutine wf_insere_padrao ()
end prototypes

public subroutine wf_insere_padrao ();// Coloca o item TODAS
DataWindowChild ldw_Child

If dw_1.GetChild("cd_uf", ldw_Child) = 1 Then
	
	ldw_Child.InsertRow(1)

	ldw_Child.SetItem(1,"cd_unidade_federacao","TD")
	ldw_Child.SetItem(1,"nm_unidade_federacao","TODAS")
	
	dw_1.Object.cd_uf[1] = "TD"
Else
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao incluir o item 'NENHUMA' na coluna mensagem fiscal.", StopSign!)
End If
end subroutine

on w_ge348_selecao_tipo_prod_fiscal.create
call super::create
end on

on w_ge348_selecao_tipo_prod_fiscal.destroy
call super::destroy
end on

event ue_postopen;call super::ue_postopen;String lvs_Parametro
String lvs_Filtro
String lvs_UF
String lvs_NCM

Long lvl_Pos

wf_insere_padrao()

lvs_Parametro = Message.StringParm
//Filtro
lvl_Pos 	= IIF(Pos(lvs_Parametro, ";") > 0, Pos(lvs_Parametro, ";"), Len(lvs_Parametro) )
lvs_Filtro	= Mid(lvs_Parametro, 1, lvl_Pos - 1)
lvs_Parametro = Mid(lvs_Parametro, lvl_Pos + 1)
//UF
lvl_Pos	= IIF(Pos(lvs_Parametro, ";") > 0, Pos(lvs_Parametro, ";"), Len(lvs_Parametro) )
lvs_UF	= Mid(lvs_Parametro, 1, lvl_Pos - 1)
lvs_Parametro = Mid(lvs_Parametro, lvl_Pos + 1)
//NCM
lvl_Pos	= IIF(Pos(lvs_Parametro, ";") > 0, Pos(lvs_Parametro, ";"), Len(lvs_Parametro) )
lvs_NCM	= Mid(lvs_Parametro, 1)

If (Trim(lvs_Filtro)<>"") Then 
	dw_1.Object.de_filtro [1] = lvs_Filtro
End If

If (Trim(lvs_UF)<>"") Then 
	dw_1.Object.cd_uf [1] = lvs_UF
End If

If (Trim(lvs_NCM)<>"") and (IsNumber(lvs_NCM)) Then 
	dw_1.Object.nr_ncm [1] = Long(lvs_NCM)
End If

dw_2.Event ue_Retrieve()
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge348_selecao_tipo_prod_fiscal
integer taborder = 0
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge348_selecao_tipo_prod_fiscal
integer y = 372
integer height = 924
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge348_selecao_tipo_prod_fiscal
integer width = 1819
integer height = 348
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge348_selecao_tipo_prod_fiscal
integer width = 1737
integer height = 248
string dataobject = "dw_ge348_selecao"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge348_selecao_tipo_prod_fiscal
integer y = 444
integer width = 2382
integer height = 824
string dataobject = "dw_ge348_lista"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Filtro
String lvs_UF

Long lvl_NCM
Long lvl_Where = 1

dw_1.AcceptText( )

lvs_Filtro	= dw_1.Object.de_filtro	[1]
lvs_UF 	= dw_1.Object.cd_uf		[1]
lvl_NCM	= dw_1.Object.nr_ncm	[1]

If Not IsNull(lvs_Filtro) and Trim(lvs_Filtro) <> "" Then
	This.Of_appendwhere("upper(tf.de_tipo_produto_fiscal) like '%"+lvs_Filtro+"%'")
End If

If lvs_UF <> "TD" Then
	This.Of_appendwhere("exists (select 1 from tipo_produto_fiscal_uf tfu1 where tfu1.cd_tipo_produto_fiscal = tf.cd_tipo_produto_fiscal and tfu1.cd_uf = '"+lvs_UF+"')")
	lvl_Where++
End If

If Not IsNull(lvl_NCM) Then
	This.Of_appendwhere_Subquery("exists (select 1 from tipo_produto_fiscal_ncm tfn1 "+ &
														" where tfn1.cd_tipo_produto_fiscal = tf.cd_tipo_produto_fiscal "+ &
														" and ((tfn1.nr_ncm_inicial = "+String(lvl_NCM)+" and tfn1.nr_ncm_final is null) "+ &
															" or (tfn1.nr_ncm_inicial <= "+String(lvl_NCM)+" and tfn1.nr_ncm_final >= "+String(lvl_NCM)+")))", lvl_Where)
End If

Return AncestorReturnValue
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge348_selecao_tipo_prod_fiscal
end type

event cb_selecionar::clicked;call super::clicked;String lvs_Codigo

If dw_2.GetRow() > 0 Then
	lvs_Codigo = String(dw_2.Object.cd_tipo_produto_fiscal [ dw_2.GetRow() ])
	CloseWithReturn(Parent,lvs_Codigo)
Else
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Selecione um registro antes de confirmar.',Exclamation!)
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge348_selecao_tipo_prod_fiscal
end type

event cb_cancelar::clicked;call super::clicked;CloseWithReturn(Parent,'')
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge348_selecao_tipo_prod_fiscal
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge348_selecao_tipo_prod_fiscal
end type

