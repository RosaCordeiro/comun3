HA$PBExportHeader$w_ge155_vendas_vidalink.srw
forward
global type w_ge155_vendas_vidalink from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge155_vendas_vidalink from dc_w_selecao_lista_relatorio
string tag = "w_ge155_vendas_vidalink"
integer width = 4073
integer height = 1836
string title = "GE155 - Vendas Vidalink por Produto"
end type
global w_ge155_vendas_vidalink w_ge155_vendas_vidalink

type variables
DataWindowChild	idwc_Child

dc_uo_ds_base ivds_desconto
dc_uo_ds_base ivds_exportacao
dc_uo_ds_base ivds_devolucao
dc_uo_ds_base ivds_programa

uo_produto ivo_Produto 	//GE001
uo_filial ivo_Filial			//GE009
end variables

forward prototypes
public subroutine wf_insere_default ()
end prototypes

public subroutine wf_insere_default ();/* Conv$$HEX1$$ea00$$ENDHEX$$nio Vidalink */
idwc_Child  = dw_1.of_InsertRow_DDDW("cd_convenio" )			

idwc_Child.SetItem(1, "cd_programa", "TD"	)
idwc_Child.SetItem(1, "de_programa", "TODOS")

dw_1.Object.cd_convenio[1] = "TD"

/* PBM */
idwc_Child  = dw_1.of_InsertRow_DDDW("cd_pbm" )			

idwc_Child.SetItem(1, "cd_pbm", 0	)
idwc_Child.SetItem(1, "nm_pbm", "TODOS"	)
idwc_Child.SetItem(1, "cd_convenio", 52575)
idwc_Child.SetFilter('cd_convenio=52575')
idwc_Child.Filter()

dw_1.Object.cd_pbm[1] = 0
end subroutine

on w_ge155_vendas_vidalink.create
call super::create
end on

on w_ge155_vendas_vidalink.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;dw_1.Object.dt_inicio	[1] = Today()
dw_1.Object.dt_fim	[1] = Today()

wf_insere_default()
end event

event ue_preopen;call super::ue_preopen;ivo_Produto 	= Create uo_Produto
ivo_Filial		= Create uo_Filial

ivds_desconto = Create dc_uo_ds_base
ivds_desconto.of_changedataobject('ds_ge155_desconto_produto')

ivds_exportacao = Create dc_uo_ds_base
ivds_exportacao.of_changedataobject('ds_ge155_exportacao')

ivds_devolucao = Create dc_uo_ds_base
ivds_devolucao.of_changedataobject('ds_ge155_devolucao')

ivds_programa = Create dc_uo_ds_base
ivds_programa.of_changedataobject('ds_ge155_programa_pbm')

MaxHeight	= 9999
MaxWidth	= 7425
end event

event close;call super::close;Destroy(ivo_Produto)
Destroy(ivo_Filial)
Destroy(ivds_desconto)
Destroy(ivds_exportacao)
Destroy(ivds_Devolucao)
Destroy(ivds_programa)
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge155_vendas_vidalink
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge155_vendas_vidalink
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge155_vendas_vidalink
integer y = 448
integer width = 3977
integer height = 1184
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge155_vendas_vidalink
integer width = 3973
integer height = 420
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge155_vendas_vidalink
integer width = 3909
integer height = 336
string dataobject = "dw_ge155_selecao"
end type

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "de_produto"
			ivo_Produto.of_Localiza_Produto(This.GetText())
			
			If ivo_Produto.Localizado Then
				This.Object.Cd_Produto[1] = ivo_Produto.Cd_Produto
				This.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
			End If
			
		Case "nm_filial"
			ivo_Filial.of_Localiza_Filial(This.GetText())
			
			If ivo_Filial.Localizada Then
				This.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial
				This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
			End If
			
	End Choose
End If
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Produto) Then
	This.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
End If

If IsValid(ivo_Filial) Then
	This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
End If
end event

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case "de_produto"
		If Data <> ivo_Produto.ivs_Descricao_Apresentacao_Venda Then
			If Data <> '' Then
				Return 1
			Else
				ivo_Produto.of_inicializa( )
				This.Object.cd_produto [Row] = ivo_Produto.cd_produto
			End If
		End If
		
	Case "nm_filial"
		If Data <> ivo_Filial.Nm_Fantasia Then
			If Data <> '' Then
				Return 1
			Else
				ivo_Filial.of_inicializa( )
				This.Object.cd_filial [Row] = ivo_Filial.cd_filial
			End If
		End If
	Case "cd_convenio"
		If Data = 'AVFARPOP' Then
			This.Object.id_produtos_pbm [Row] = 'N'
		End If
End Choose
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge155_vendas_vidalink
integer y = 524
integer width = 3909
integer height = 1076
string dataobject = "dw_ge155_lista"
boolean hscrollbar = true
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Prod_PBM
String lvs_Manipulado
String lvs_Convenio
String lvs_Tipo_Venda
String lvs_Datasus
String lvs_SQL

Long lvl_PBM
Long lvl_Filial
Long lvl_Produto

Date lvdt_Inicio

dw_1.AcceptText( )
ivds_devolucao.of_RestoreSQLOriginal( )

This.SetFilter("")
This.Filter()

lvdt_Inicio 		= dw_1.Object.dt_inicio						[1]
lvs_Prod_PBM	= dw_1.Object.id_produtos_pbm			[1]
lvl_PBM			= dw_1.Object.cd_pbm						[1]
lvs_Convenio	= dw_1.Object.cd_convenio					[1]
lvl_Filial			= dw_1.Object.cd_filial						[1]
lvl_Produto		= dw_1.Object.cd_produto					[1]
lvs_Manipulado	= dw_1.Object.id_manipulados				[1]
lvs_Tipo_Venda= dw_1.Object.id_tipo_venda				[1]
lvs_Datasus		= dw_1.Object.nr_autorizacao_datasus	[1]

If lvs_Prod_PBM = 'S' Then
	If Not IsNull(lvs_Datasus)and(gf_retorna_so_numeros(lvs_Datasus)<>'') Then
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','O n$$HEX1$$ba00$$ENDHEX$$ Datasus est$$HEX1$$e100$$ENDHEX$$ dispon$$HEX1$$ed00$$ENDHEX$$vel somente para vendas Farm$$HEX1$$e100$$ENDHEX$$cia Popular.~r~n'+ &
							'Para retornar valores corretamente $$HEX1$$e900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio desmarcar a op$$HEX2$$e700e300$$ENDHEX$$o:~r~n~r~n "[x] Somente Produtos PBM".',Exclamation!)
		Return -1
	End If
	
	If lvdt_Inicio < Date('01/04/2015') Then
		This.of_AppendWhere(' exists (select 1 ' + &
												' from pbm pb1 ' + &
												' inner join pbm_produto p1 (index pk_pbm_produto)' + &
												'	on p1.cd_pbm = pb1.cd_pbm' + &
												' where p1.cd_produto = inf.cd_produto' + & 
												'	and pb1.cd_convenio = k.cd_convenio)')
		ivds_devolucao.of_AppendWhere(' exists (select 1 ' + &
															' from pbm pb1 ' + &
															' inner join pbm_produto p1 (index pk_pbm_produto)' + &
															'	on p1.cd_pbm = pb1.cd_pbm' + &
															' where p1.cd_produto = inf.cd_produto' + & 
															'	and pb1.cd_convenio = k.cd_convenio)')
	Else
		This.of_AppendWhere("x.id_pbm='S'")
		ivds_devolucao.of_AppendWhere("x.id_pbm='S'")
	End If
End If

If lvs_Tipo_Venda <> 'TD' Then
	This.of_AppendWhere("v.id_tipo_venda='"+lvs_Tipo_Venda+"'")
	ivds_devolucao.of_AppendWhere("v.id_tipo_venda='"+lvs_Tipo_Venda+"'")
End If

If lvl_PBM > 0 Then
	This.of_AppendWhere('exists (select 1 from pbm_produto pp1 '+&
										' Where pp1.cd_produto = x.cd_produto '+&
										'	And pp1.cd_pbm = '+String(lvl_PBM)+')')
	ivds_devolucao.of_AppendWhere('exists (select 1 from pbm_produto pp1 '+&
														' Where pp1.cd_produto = x.cd_produto '+&
														'	And pp1.cd_pbm = '+String(lvl_PBM)+')')
End If

If lvs_Convenio <>'TD' Then
	This.of_AppendWhere("k.nr_comprovante_venda = '"+lvs_Convenio+"'")
	ivds_devolucao.of_AppendWhere("k.nr_comprovante_venda = '"+lvs_Convenio+"'")
End If

If lvs_Manipulado = 'N' Then
	If Not(lvl_Produto > 0) Then
		This.of_AppendWhere('x.cd_produto<>684431')
		ivds_devolucao.of_AppendWhere('inf.cd_produto<>684431')
	End If
End If

If Not IsNull(lvs_Datasus)and(gf_retorna_so_numeros(lvs_Datasus)<>'') Then
	This.of_AppendWhere("k.nr_autorizacao_datasus='"+Mid(lvs_Datasus,1,3)+'.'+Mid(lvs_Datasus,4,3)+'.'+Mid(lvs_Datasus,7,3)+'.'+Mid(lvs_Datasus,10,3)+'.'+Mid(lvs_Datasus,13,3)+"'",2)	
	ivds_devolucao.of_AppendWhere("k.nr_autorizacao_datasus='"+Mid(lvs_Datasus,1,3)+'.'+Mid(lvs_Datasus,4,3)+'.'+Mid(lvs_Datasus,7,3)+'.'+Mid(lvs_Datasus,10,3)+'.'+Mid(lvs_Datasus,13,3)+"'",2)	
	
	lvs_SQL = This.GetSQLSelect()
	lvs_SQL = gf_replace(lvs_SQL, 'idx_data_convenio','idx_autorizacao_datasus',0)
	This.of_ChangeSQL(lvs_SQL)
End If

If lvl_Filial > 0 Then
	This.of_AppendWhere('k.cd_filial='+String(lvl_Filial))	
	ivds_devolucao.of_AppendWhere('nf.cd_filial='+String(lvl_Filial))	
	
	lvs_SQL = This.GetSQLSelect()
	lvs_SQL = gf_replace(lvs_SQL, 'idx_data_convenio','idx_fil_dt_conv',0)
	This.of_ChangeSQL(lvs_SQL)
End If

If lvl_Produto > 0 Then
	This.of_AppendWhere('x.cd_produto + 0 ='+String(lvl_Produto))	
	ivds_devolucao.of_AppendWhere('inf.cd_produto='+String(lvl_Produto))	
End If

Return AncestorReturnValue
end event

event dw_2::ue_recuperar;//override
Date lvdt_Inicio
Date lvdt_Fim

Long lvl_Linhas

dw_1.Accepttext( )

lvdt_Inicio 	= dw_1.Object.dt_inicio	[1]
lvdt_Fim		= dw_1.Object.dt_fim		[1]

Open(w_aguarde)
w_aguarde.Title = 'Recuperando vendas PBM do per$$HEX1$$ed00$$ENDHEX$$odo...'
lvl_Linhas = This.Retrieve(lvdt_Inicio,lvdt_Fim)
Close(w_aguarde)

Return lvl_Linhas
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;Long lvl_Produto
Long lvl_Filial
Long lvl_PBM
Long lvl_Find
Long lvl_Qtde
Long lvl_Linhas
Long lvl_Linha

String lvs_Devolucao
String lvs_Convenio
String lvs_Aux
String lvs_PBM

Date lvdt_Inicio
Date lvdt_Fim

Decimal{2} lvdc_Venda
Decimal{2} lvdc_Custo
Decimal{2} lvdc_Pago_Avista
Decimal{2} lvdc_Reposicao_Prev
Decimal{2} lvdc_Pagto_Prev
Decimal{2} lvdc_Pagto_Real
Decimal{2} lvdc_PMC

If pl_Linhas > 0 Then
	
	lvdt_Inicio		= dw_1.Object.dt_inicio		[1]
	lvdt_Fim			= dw_1.Object.dt_fim			[1]
	lvs_Devolucao 	= dw_1.Object.id_devolucao[1]
	
	Open(w_aguarde)
	This.SetRedraw(False)	
	
	/*Atualiza o programa PBM cadastrado para o produto */
	If ivds_programa.RowCount() = 0 Then ivds_programa.Retrieve()
	w_aguarde.Title = 'Recuperando informa$$HEX2$$e700f500$$ENDHEX$$es PBM...'
	w_aguarde.uo_Progress.of_SetMax(pl_Linhas)
	For lvl_Linha = 1 To pl_Linhas
		lvl_Produto		= This.Object.cd_produto	[lvl_Linha]
		lvl_Find = ivds_programa.Find('cd_produto='+String(lvl_Produto),1,ivds_programa.RowCount())
		If lvl_Find > 0 Then
			This.Object.cd_pbm	[lvl_Linha] = ivds_programa.Object.cd_pbm		[lvl_Find]
			This.Object.nm_pbm	[lvl_Linha] = ivds_programa.Object.nm_pbm	[lvl_Find]
		End if
		w_aguarde.uo_Progress.of_SetProgress(lvl_Linha)
	Next 
	
	If lvs_Devolucao = 'S' Then
		w_aguarde.Title = 'Deduzindo devolu$$HEX2$$e700f500$$ENDHEX$$es vendas...'
			
		lvl_Linhas = ivds_devolucao.Retrieve(lvdt_Inicio,lvdt_Fim)
		w_aguarde.uo_Progress.of_SetMax(lvl_Linhas)
		
		For lvl_Linha = 1 To lvl_Linhas
			lvl_Produto		= ivds_devolucao.Object.cd_produto	[lvl_Linha]
			lvl_Filial			= ivds_devolucao.Object.cd_filial		[lvl_Linha]
			lvs_Convenio	= ivds_devolucao.Object.cd_convenio	[lvl_Linha]
			
			lvl_Find = ivds_programa.Find('cd_produto='+String(lvl_Produto),1,ivds_programa.RowCount())
			If lvl_Find > 0 Then
				lvl_PBM	= ivds_programa.Object.cd_pbm		[lvl_Find]
				lvs_PBM	= ivds_programa.Object.nm_pbm		[lvl_Find]
			Else
				SetNull(lvl_PBM)
				lvs_PBM	= ''
			End if
			
			If IsNull(lvs_Convenio) Then
				lvs_Aux = "IsNull(cd_convenio)"
			Else
				lvs_Aux = "cd_convenio='"+lvs_Convenio+"'"
			End If
			If (lvl_PBM > 0)and(Not IsNull(lvl_PBM)) Then
				lvl_Find =This.Find(lvs_Aux+" and cd_filial="+String(lvl_Filial)+ &
										" and cd_produto="+String(lvl_Produto)+" and cd_pbm="+String(lvl_PBM),1,This.RowCount())
			Else
				lvl_Find =This.Find(lvs_Aux+" and cd_filial="+String(lvl_Filial)+ &
									" and cd_produto="+String(lvl_Produto),1,This.RowCount())
			End If
			
			If Not(lvl_Find > 0) Then
				lvl_Find = This.InsertRow(0)
				This.Object.cd_filial 					[lvl_Find] = lvl_Filial
				This.Object.cd_produto 				[lvl_Find] = lvl_Produto
				This.Object.de_produto				[lvl_Find] = ivds_devolucao.Object.de_produto 	[lvl_Linha]
				This.Object.cd_convenio				[lvl_Find] = lvs_Convenio
				This.Object.cd_pbm					[lvl_Find] = lvl_PBM
				This.Object.nm_pbm					[lvl_Find] = lvs_PBM
				This.Object.vl_pmc					[lvl_Find] = ivds_devolucao.Object.vl_pmc 			[lvl_Linha]
				This.Object.nm_convenio			[lvl_Find] = ivds_devolucao.Object.nm_convenio	[lvl_Linha]		
				This.Object.vl_venda					[lvl_Find] = 0.00
				This.Object.qt_venda					[lvl_Find] = 0.00
				This.Object.vl_custo					[lvl_Find] = 0.00
				This.Object.vl_pago_avista			[lvl_Find] = 0.00
				This.Object.vl_reposicao_previsto	[lvl_Find] = 0.00
				This.Object.vl_pagto_previsto		[lvl_Find] = 0.00
				This.Object.vl_pagto_realizado		[lvl_Find] = 0.00
			End If
			
			lvdc_Venda 				= This.Object.vl_venda					[lvl_Find]
			lvl_Qtde					= This.Object.qt_venda					[lvl_Find]
			lvdc_Custo				= This.Object.vl_custo					[lvl_Find]
			lvdc_Pago_Avista 		= This.Object.vl_pago_avista			[lvl_Find]
			lvdc_Reposicao_Prev	= This.Object.vl_reposicao_previsto	[lvl_Find]
			lvdc_Pagto_Prev		= This.Object.vl_pagto_previsto		[lvl_Find]
			lvdc_Pagto_Real		= This.Object.vl_pagto_realizado		[lvl_Find]
			lvdc_PMC				= This.Object.vl_pmc						[lvl_Find]
			
			This.Object.vl_venda					[lvl_Find] = lvdc_Venda				- ivds_devolucao.Object.vl_devolucao				[lvl_Linha]
			This.Object.qt_venda					[lvl_Find] = lvl_Qtde 					- ivds_devolucao.Object.qt_devolvida				[lvl_Linha]
			This.Object.vl_custo					[lvl_Find] = lvdc_Custo				- ivds_devolucao.Object.vl_custo					[lvl_Linha]
			This.Object.vl_pago_avista			[lvl_Find] = lvdc_Pago_Avista 		- ivds_devolucao.Object.vl_pago_avista			[lvl_Linha]
			This.Object.vl_reposicao_previsto	[lvl_Find] = lvdc_Reposicao_Prev	- ivds_devolucao.Object.vl_reposicao_previsto	[lvl_Linha]
			This.Object.vl_pagto_previsto		[lvl_Find] = lvdc_Pagto_Prev 		- ivds_devolucao.Object.vl_pagto_previsto		[lvl_Linha]
			This.Object.vl_pagto_realizado		[lvl_Find] = lvdc_Pagto_Real 		- ivds_devolucao.Object.vl_pagto_realizado		[lvl_Linha]
			This.Object.vl_pmc					[lvl_Find] = lvdc_PMC					- ivds_devolucao.Object.vl_pmc					[lvl_Linha]
			
			w_aguarde.uo_Progress.of_SetProgress(lvl_Linha)
		Next
	End If
	
	This.SetRedraw(True)
	Close(w_aguarde)
End If

This.SetFilter("vl_venda <> 0")
This.Filter()

This.ShareData(ivds_exportacao)

ivm_menu.mf_salvarComo(pl_Linhas > 0)

Return AncestorReturnValue
end event

event dw_2::ue_reset;call super::ue_reset;ivm_menu.mf_salvarComo(False)
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge155_vendas_vidalink
integer x = 3525
integer y = 1260
integer height = 220
end type

