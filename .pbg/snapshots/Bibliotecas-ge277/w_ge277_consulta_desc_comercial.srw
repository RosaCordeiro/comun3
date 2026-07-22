HA$PBExportHeader$w_ge277_consulta_desc_comercial.srw
forward
global type w_ge277_consulta_desc_comercial from dc_w_2tab_consulta_selecao_lista_2det
end type
type dw_relatorio from dc_uo_dw_base within w_ge277_consulta_desc_comercial
end type
end forward

global type w_ge277_consulta_desc_comercial from dc_w_2tab_consulta_selecao_lista_2det
string tag = "w_ge277_consulta_desc_comercial"
integer width = 3694
integer height = 2156
string title = "GE277 - Consulta Vendas com Descontos Comercias"
boolean resizable = false
dw_relatorio dw_relatorio
end type
global w_ge277_consulta_desc_comercial w_ge277_consulta_desc_comercial

type variables

uo_Filial ivo_Filial

dc_uo_ds_base ivds_Prestes
end variables

forward prototypes
public subroutine wf_insere_padrao ()
end prototypes

public subroutine wf_insere_padrao ();// Coloca o item TODAS
DataWindowChild ldw_Child

Long lvl_Regiao

If Tab_1.TabPage_1.dw_1.GetChild("cd_regiao", ldw_Child) = 1 Then
	
	ldw_Child.InsertRow(1)

	ldw_Child.SetItem(1,"cd_regiao",0)
	ldw_Child.SetItem(1,"de_regiao","TODAS")
	
Else
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao incluir o item 'TODAS' na coluna regi$$HEX1$$e300$$ENDHEX$$o.", StopSign!)
End If

select cd_regiao
Into :lvl_Regiao
From regiao
Where nr_matricula_regional = :gvo_aplicacao.ivo_seguranca.nr_matricula
Using SQLCa;

If SQLCa.SQLCode = 0 Then
	Tab_1.TabPage_1.dw_1.Object.cd_regiao[1] = lvl_Regiao
Else
	Tab_1.TabPage_1.dw_1.Object.cd_regiao[1] = 0	
End If
end subroutine

on w_ge277_consulta_desc_comercial.create
int iCurrent
call super::create
this.dw_relatorio=create dw_relatorio
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_relatorio
end on

on w_ge277_consulta_desc_comercial.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_relatorio)
end on

event ue_preopen;call super::ue_preopen;ivo_Filial = Create uo_Filial
ivds_Prestes = Create dc_uo_ds_base
ivds_Prestes.of_changedataobject('dw_ge277_desconto_prestes')

dw_relatorio.Visible = False

ivm_menu.ivb_permite_imprimir = True
end event

event close;call super::close;Destroy(ivo_Filial)
Destroy(ivds_Prestes)
end event

event ue_postopen;call super::ue_postopen;String lvs_Param
String lvs_Data

Date lvdt_Inicio
Date lvdt_Fim

lvs_Param = Message.StringParm

If (Trim(lvs_Param)<>'')and(not(IsNull(lvs_Param))) Then
	lvs_Data = Mid(lvs_Param,1,Pos(lvs_Param,';') - 1)
	If IsDate(lvs_Data) Then
		lvdt_Inicio = Date(lvs_Data)
	Else
		lvdt_Inicio	= Today()		
	End If

	lvs_Data = Mid(lvs_Param,Pos(lvs_Param,';') + 1)
	If IsDate(lvs_Data) Then
		lvdt_Fim = Date(lvs_Data)
	Else
		lvdt_Fim	= Today()		
	End If
Else
	lvdt_Inicio	= Today()
	lvdt_Fim		= Today()
End If

Tab_1.TabPage_1.dw_1.Object.dt_Inicio	[1]	 = lvdt_Inicio
Tab_1.TabPage_1.dw_1.Object.dt_fim	[1] = lvdt_Fim

wf_insere_padrao()

Width = 3700
Height = 2100
end event

event ue_print;call super::ue_print;dw_relatorio.Event ue_Print()
end event

event ue_printimmediate;call super::ue_printimmediate;dw_relatorio.Event ue_PrintImmediate()
end event

event ue_saveas;call super::ue_saveas;dw_relatorio.Event ue_SaveAs()
end event

type dw_visual from dc_w_2tab_consulta_selecao_lista_2det`dw_visual within w_ge277_consulta_desc_comercial
end type

type gb_aux_visual from dc_w_2tab_consulta_selecao_lista_2det`gb_aux_visual within w_ge277_consulta_desc_comercial
end type

type tab_1 from dc_w_2tab_consulta_selecao_lista_2det`tab_1 within w_ge277_consulta_desc_comercial
integer width = 3648
integer height = 1972
end type

event tab_1::selectionchanged;//override
If NewIndex = 1 Then
	ivm_menu.mf_imprimir(Tabpage_1.dw_2.RowCount() > 0)
	ivm_menu.mf_salvarcomo(Tabpage_1.dw_2.RowCount() > 0)
Else
	ivm_menu.mf_imprimir(False)
	ivm_menu.mf_salvarcomo(False)
End If
end event

type tabpage_1 from dc_w_2tab_consulta_selecao_lista_2det`tabpage_1 within tab_1
integer width = 3611
integer height = 1856
end type

type gb_2 from dc_w_2tab_consulta_selecao_lista_2det`gb_2 within tabpage_1
integer width = 3561
integer height = 1452
end type

type gb_1 from dc_w_2tab_consulta_selecao_lista_2det`gb_1 within tabpage_1
integer width = 2363
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
end type

type dw_1 from dc_w_2tab_consulta_selecao_lista_2det`dw_1 within tabpage_1
integer width = 2341
string dataobject = "dw_ge277_selecao"
end type

event dw_1::ue_key;call super::ue_key;If key = KeyEnter! Then
	If This.GetColumnName() = "nm_filial" Then
		
		ivo_Filial.of_Localiza_Filial(GetText())
		
		If ivo_Filial.Localizada Then
			
			This.Object.cd_filial	[1] = ivo_Filial.cd_filial
			This.Object.nm_filial	[1] = ivo_Filial.nm_fantasia
			
			This.Object.cd_regiao	[1] = 0
		End If
		
	End If
End If
end event

event dw_1::losefocus;call super::losefocus;If Not IsNull(This.Object.cd_filial[1]) Then
	If IsValid(ivo_Filial) Then
		This.Object.cd_filial	[1] = ivo_Filial.cd_filial
		This.Object.nm_filial	[1] = ivo_Filial.nm_fantasia
	End If
End If
end event

event dw_1::itemchanged;call super::itemchanged;If dwo.Name = "nm_filial" Then
	If data <> "" Then
		If Trim(Data) <> ivo_Filial.nm_fantasia Then
			Return 1 
		End If
	End If
End If

end event

event dw_1::editchanged;call super::editchanged;If dwo.Name = "nm_filial" Then
	If Data = "" or IsNull(Data) Then
		ivo_Filial.of_inicializa( )
		This.Object.cd_filial[1] = ivo_Filial.cd_filial
		Return 0
	End If
End If
end event

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)
end event

type dw_2 from dc_w_2tab_consulta_selecao_lista_2det`dw_2 within tabpage_1
integer x = 50
integer width = 3520
integer height = 1352
string dataobject = "dw_ge277_lista"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_recuperar;Date lvdt_Inicio
Date lvdt_Fim

Parent.dw_1.Accepttext( )
lvdt_Inicio 	= Parent.dw_1.Object.dt_inicio	[1]
lvdt_Fim		= Parent.dw_1.Object.dt_fim	[1]

Return This.Retrieve(lvdt_Inicio,lvdt_Fim)
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;Long lvl_Regiao
Long lvl_Filial

Parent.dw_1.AcceptText( )

lvl_Filial		= Parent.dw_1.Object.cd_filial		[1]
lvl_Regiao	= Parent.dw_1.Object.cd_regiao	[1]

If lvl_Filial > 0 Then
	This.of_appendwhere_subquery('nf.cd_filial = '+String(lvl_Filial),1)
End If

If lvl_Regiao > 0 Then
	This.of_appendwhere_subquery('f.cd_regiao = '+String(lvl_Regiao),1)
End If

If dw_1.Object.id_prestes [1] = 'S' Then
	This.of_appendwhere_subquery("not exists (Select id1.cd_filial "+ &
															"from item_nf_venda_desconto id1 "+&
															"where id1.cd_filial = nf.cd_filial "+ &
															"and id1.nr_nf = nf.nr_nf "+ &
															"and id1.de_especie = nf.de_especie "+&
															"and id1.de_serie = nf.de_serie "+&
															"and id1.id_tipo_desconto = 'PVE'"+&
															")",1)

	This.of_appendwhere_subquery("not exists (Select 1 "+ &
															"from produto_preste_a_vencer ppv1 "+&
															"where ppv1.cd_filial = nf.cd_filial "+ &
															"and ppv1.nr_nf = nf.nr_nf "+ &
															"and ppv1.de_especie = nf.de_especie "+&
															"and ppv1.de_serie = nf.de_serie "+&
															"and ppv1.id_situacao = 'B'"+&
															"and ppv1.id_tipo_baixa = 'V'"+&
															")",1)
End If

ivm_menu.mf_imprimir(False)
ivm_menu.mf_salvarcomo(False)

Return AncestorReturnValue
end event

event dw_2::clicked;call super::clicked;If This.RowCount() > 0 and ivb_Ordena_Colunas and Row = 0 Then
	This.Event RowFocusChanged(1)
End If
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;Long lvl_Linha
Long lvl_Filial
Long lvl_Nr_Nf

String lvs_Serie
String lvs_Especie

If dw_1.Object.id_prestes [1] <> 'S' Then
	
	For lvl_Linha = 1 To This.RowCount()
		lvl_Filial 		= This.Object.cd_filial 	[lvl_Linha]
		lvl_Nr_Nf		= This.Object.nr_nf 		[lvl_Linha]
		lvs_Serie		= This.Object.de_serie 	[lvl_Linha]
		lvs_Especie	= This.Object.de_especie[lvl_Linha]
		If ivds_Prestes.Retrieve(lvl_Filial,lvl_Nr_Nf,lvs_Especie,lvs_Serie) > 0 Then	
			This.Object.vl_desconto_pve [lvl_Linha] = ivds_Prestes.Object.vl_desconto[1]
		End If
	Next
End If

ivm_menu.mf_imprimir(pl_linhas > 0)
ivm_menu.mf_salvarcomo(pl_linhas > 0)

Return AncestorReturnValue
end event

event dw_2::ue_reset;call super::ue_reset;ivm_menu.mf_imprimir(False)
ivm_menu.mf_salvarcomo(False)
end event

event dw_2::constructor;call super::constructor;This.Sharedata(dw_relatorio)
end event

type tabpage_2 from dc_w_2tab_consulta_selecao_lista_2det`tabpage_2 within tab_1
integer width = 3611
integer height = 1856
end type

type gb_4 from dc_w_2tab_consulta_selecao_lista_2det`gb_4 within tabpage_2
integer y = 792
integer width = 3557
integer height = 1044
integer weight = 700
string facename = "Verdana"
string text = "Itens NF"
end type

type gb_3 from dc_w_2tab_consulta_selecao_lista_2det`gb_3 within tabpage_2
integer width = 3406
integer height = 776
integer weight = 700
string facename = "Verdana"
end type

type dw_3 from dc_w_2tab_consulta_selecao_lista_2det`dw_3 within tabpage_2
integer width = 3323
integer height = 696
string dataobject = "dw_ge277_detalhe"
end type

event dw_3::ue_recuperar;//override
Long lvl_Filial
Long lvl_Nr_NF
Long lvl_Linha

String lvs_Serie
String lvs_Especie

lvl_Linha = Tab_1.Tabpage_1.dw_2.GetRow()

lvl_Filial		= Tab_1.Tabpage_1.dw_2.Object.cd_filial		[lvl_Linha]
lvl_Nr_NF	= Tab_1.Tabpage_1.dw_2.Object.nr_nf			[lvl_Linha]
lvs_Especie	= Tab_1.Tabpage_1.dw_2.Object.de_especie	[lvl_Linha]
lvs_Serie		= Tab_1.Tabpage_1.dw_2.Object.de_serie		[lvl_Linha]

Return This.Retrieve(lvl_Filial,lvl_Nr_NF,lvs_Especie,lvs_Serie)
end event

type dw_4 from dc_w_2tab_consulta_selecao_lista_2det`dw_4 within tabpage_2
integer x = 32
integer y = 860
integer width = 3547
integer height = 944
string dataobject = "dw_ge277_item_nf"
boolean vscrollbar = true
end type

event dw_4::ue_recuperar;//override
Long lvl_Filial
Long lvl_Nr_NF
Long lvl_Linha

String lvs_Serie
String lvs_Especie

lvl_Linha = Tab_1.Tabpage_1.dw_2.GetRow()

lvl_Filial		= Tab_1.Tabpage_1.dw_2.Object.cd_filial		[lvl_Linha]
lvl_Nr_NF	= Tab_1.Tabpage_1.dw_2.Object.nr_nf			[lvl_Linha]
lvs_Especie	= Tab_1.Tabpage_1.dw_2.Object.de_especie	[lvl_Linha]
lvs_Serie		= Tab_1.Tabpage_1.dw_2.Object.de_serie		[lvl_Linha]

Return This.Retrieve(lvl_Filial,lvl_Nr_NF,lvs_Serie,lvs_Especie)
end event

event dw_4::constructor;call super::constructor;This.Of_SetRowSelection()
end event

type dw_relatorio from dc_uo_dw_base within w_ge277_consulta_desc_comercial
integer x = 2656
integer y = 16
integer width = 439
integer height = 224
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_ge277_relatorio"
boolean border = true
borderstyle borderstyle = styleraised!
end type

event ue_preprint;call super::ue_preprint;Date lvdt_Inicio
Date lvdt_Fim

Tab_1.tabpage_1.dw_1.Accepttext( )

lvdt_Inicio 	= Tab_1.tabpage_1.dw_1.Object.dt_inicio	[1]
lvdt_Fim		= Tab_1.tabpage_1.dw_1.Object.dt_fim		[1]

This.Object.st_periodo.Text = 'Per$$HEX1$$ed00$$ENDHEX$$odo: '+String(lvdt_Inicio)+' $$HEX1$$e000$$ENDHEX$$ '+String(lvdt_Fim)

Return AncestorReturnValue
end event

