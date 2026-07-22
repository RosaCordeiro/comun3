HA$PBExportHeader$w_ge220_selecao_tributa_farmaceuticos.srw
forward
global type w_ge220_selecao_tributa_farmaceuticos from dc_w_selecao_generica
end type
end forward

global type w_ge220_selecao_tributa_farmaceuticos from dc_w_selecao_generica
string tag = "GE220 - Sele$$HEX2$$e700e300$$ENDHEX$$o Tributa$$HEX2$$e700e300$$ENDHEX$$o de Produtos Farmac$$HEX1$$ea00$$ENDHEX$$uticos"
integer width = 3099
string title = "GE220 - Sele$$HEX2$$e700e300$$ENDHEX$$o Tributa$$HEX2$$e700e300$$ENDHEX$$o de Produtos Farmac$$HEX1$$ea00$$ENDHEX$$uticos"
end type
global w_ge220_selecao_tributa_farmaceuticos w_ge220_selecao_tributa_farmaceuticos

type variables
String ivs_Tributacao_Antiga
end variables

forward prototypes
public subroutine wf_insere_padrao ()
end prototypes

public subroutine wf_insere_padrao ();// Coloca o item TODAS
DataWindowChild ldwc_Child

If dw_1.GetChild("cd_uf", ldwc_Child) = 1 Then
	
	ldwc_Child.InsertRow(1)

	ldwc_Child.SetItem(1,"cd_unidade_federacao","TD")
	ldwc_Child.SetItem(1,"nm_unidade_federacao","TODOS")
	
	dw_1.Object.cd_uf[1] = "TD"
Else
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao incluir o item 'TODAS' no filtro 'Estado'.", StopSign!)
End If

/*Lei Gen$$HEX1$$e900$$ENDHEX$$rico*/
ldwc_Child  = dw_1.of_InsertRow_DDDW("id_lei_generico" )			

ldwc_Child.SetItem(1, "id_lei_generico", ""	)
ldwc_Child.SetItem(1, "de_lei_generico", "TODOS")

dw_1.Object.id_lei_generico[1] = ""

/*Lista Pis/Cofins*/
ldwc_Child  = dw_1.of_InsertRow_DDDW("id_lista_pis_cofins" )			

ldwc_Child.SetItem(1, "id_lista_pis_cofins", ""	)
ldwc_Child.SetItem(1, "de_lista_pis_cofins", "TODOS")

dw_1.Object.id_lista_pis_cofins[1] = ""
end subroutine

on w_ge220_selecao_tributa_farmaceuticos.create
call super::create
end on

on w_ge220_selecao_tributa_farmaceuticos.destroy
call super::destroy
end on

event ue_postopen;call super::ue_postopen;String lvs_Aux
String lvs_UF
String lvs_Pesquisa
String lvs_NCM
String lvs_Lei
String lvs_Pis

wf_insere_padrao()

lvs_Aux = Message.StringParm

lvs_UF					= Mid(lvs_Aux, 1, Pos(lvs_Aux,';') -1)
lvs_Aux					= Mid(lvs_Aux, Pos(lvs_Aux,';') + 1)
lvs_Pesquisa			= Mid(lvs_Aux, 1, Pos(lvs_Aux,';') -1)
lvs_Aux					= Mid(lvs_Aux, Pos(lvs_Aux,';') + 1)
ivs_Tributacao_Antiga= Mid(lvs_Aux, 1, Pos(lvs_Aux,';') -1)
lvs_Aux					= Mid(lvs_Aux, Pos(lvs_Aux,';') + 1)
lvs_NCM					= Mid(lvs_Aux, 1, Pos(lvs_Aux,';') -1)
lvs_Aux					= Mid(lvs_Aux, Pos(lvs_Aux,';') + 1)
lvs_Pis					= Mid(lvs_Aux, 1, Pos(lvs_Aux,';') -1)
lvs_Aux					= Mid(lvs_Aux, Pos(lvs_Aux,';') + 1)
lvs_Lei					= lvs_Aux

If Trim(lvs_Uf) = "" Then 
	lvs_UF = "TD"
	dw_1.Object.cd_uf.TabSequence = 20
End If

If (lvs_NCM <> '')and(IsNumber(lvs_NCM)) Then
	dw_1.Object.nr_ncm	[1] = Long(lvs_NCM)
End If

dw_1.Object.id_lei_generico			[1] = lvs_Lei
dw_1.Object.id_lista_pis_cofins			[1] = lvs_Pis
dw_1.Object.de_tributacao_produto	[1] = lvs_Pesquisa
dw_1.Object.cd_uf							[1] = lvs_UF

Dw_2.Event ue_Retrieve()

dw_1.SetFocus()

end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge220_selecao_tributa_farmaceuticos
integer taborder = 0
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge220_selecao_tributa_farmaceuticos
integer y = 308
integer width = 3031
integer height = 1008
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge220_selecao_tributa_farmaceuticos
integer width = 2880
integer height = 280
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge220_selecao_tributa_farmaceuticos
integer x = 55
integer y = 84
integer width = 2834
integer height = 172
integer taborder = 10
string dataobject = "dw_ge220_selecao"
end type

event dw_1::editchanged;call super::editchanged;st_Mensagem.Text = "Nenhum registro encontrado."
end event

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge220_selecao_tributa_farmaceuticos
integer x = 55
integer y = 360
integer width = 2976
integer height = 928
integer taborder = 20
string dataobject = "dw_ge220_lista"
boolean ivb_ordena_colunas = true
end type

event dw_2::constructor;call super::constructor;This.ivb_Ordena_Colunas = True
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;Long lvl_Linha

String lvs_Tributacao

If pl_Linhas > 0 Then
	
	If ivs_Tributacao_Antiga <> "" And Not IsNull(ivs_Tributacao_Antiga) Then 
	
		lvl_Linha = This.Find("cd_tributacao_produto = " + ivs_Tributacao_Antiga, 0, pl_Linhas )
		
		If lvl_Linha < 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao localizar a trib. antiga pelo m$$HEX1$$e900$$ENDHEX$$todo FIND.")
		ElseIf lvl_Linha > 0 Then
			This.Event ue_Pos(lvl_Linha, "cd_tributacao_produto")
		End If
		
	End If

End If

Return pl_Linhas
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Pesquisa
String lvs_UF
String lvs_Pis
String lvs_Lei

Long lvl_NCM

dw_1.Accepttext( )
lvs_Pesquisa= dw_1.Object.de_tributacao_produto	[1]
lvs_UF		= dw_1.Object.cd_uf							[1]
lvs_Lei		= dw_1.Object.id_lei_generico				[1]
lvs_Pis		= dw_1.Object.id_lista_pis_cofins			[1]
lvl_NCM		= dw_1.Object.nr_ncm						[1]

If lvs_UF <> 'TD' Then
	This.Of_AppendWhere("((cd_unidade_federacao = '" + lvs_UF + "') or (cd_tributacao_produto = 0))")
End If

If lvs_Lei <> '' Then
	This.Of_AppendWhere("((coalesce(id_lei_generico,'"+lvs_Lei+"') = '" + lvs_Lei + "') or (cd_tributacao_produto = 0))")
End If

If lvs_Pis <> '' Then
	This.Of_AppendWhere("((coalesce(id_situacao_pis_cofins,'"+lvs_Pis+"') = '" + lvs_Pis + "') or (cd_tributacao_produto = 0))")
End If

If Not IsNumber(lvs_Pesquisa) Then
	This.Of_AppendWhere("de_tributacao_produto like '" + lvs_Pesquisa + "%'")
else
	This.Of_AppendWhere("cd_tributacao_produto = " + lvs_Pesquisa)
End If

If (Not IsNull(lvl_NCM)) Then
	This.Of_AppendWhere("((cd_tributacao_produto = 0) or ((cd_ncm_final is null) and (cd_ncm_inicial = " + String(lvl_NCM)+"))" + &
								" or ((cd_ncm_final is not null) and (cd_ncm_inicial <= " + String(lvl_NCM)+") and (cd_ncm_final >= " + String(lvl_NCM)+")))")
End If

Return AncestorReturnValue
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge220_selecao_tributa_farmaceuticos
integer x = 2304
integer y = 1352
integer taborder = 40
end type

event cb_selecionar::clicked;call super::clicked;Long lvl_Linha

String lvs_Tributacao

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	lvs_Tributacao = String(dw_2.Object.cd_tributacao_produto[lvl_Linha])
	CloseWithReturn(Parent, lvs_Tributacao)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione a Tributa$$HEX2$$e700e300$$ENDHEX$$o dos Produtos Farmaceuticos.", Information!, Ok!)
	dw_2.SetFocus()
End If

end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge220_selecao_tributa_farmaceuticos
integer x = 2693
integer y = 1352
integer taborder = 50
end type

event cb_cancelar::clicked;call super::clicked;CloseWithReturn(Parent, ivs_Tributacao_Antiga)
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge220_selecao_tributa_farmaceuticos
integer x = 1861
integer y = 1352
integer taborder = 30
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge220_selecao_tributa_farmaceuticos
integer y = 1352
end type

