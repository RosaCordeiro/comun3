HA$PBExportHeader$w_ge157_vendas_epharma.srw
forward
global type w_ge157_vendas_epharma from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge157_vendas_epharma from dc_w_selecao_lista_relatorio
string tag = "w_ge157_vendas_epharma"
integer width = 4215
integer height = 1908
string title = "GE157 - Vendas E-Pharma por Produto"
end type
global w_ge157_vendas_epharma w_ge157_vendas_epharma

type variables
DataWindowChild	idwc_Child

dc_uo_ds_base ivds_desconto
dc_uo_ds_base ivds_devolucao
dc_uo_ds_base ivds_programa

uo_produto ivo_Produto 	//GE001
uo_filial ivo_Filial			//GE009
end variables

forward prototypes
public subroutine wf_insere_default ()
end prototypes

public subroutine wf_insere_default ();/* Conv$$HEX1$$ea00$$ENDHEX$$nio E-Pharma */
idwc_Child  = dw_1.of_InsertRow_DDDW("cd_convenio" )			

idwc_Child.SetItem(1, "cd_convenio", 0	)
idwc_Child.SetItem(1, "nm_convenio", "TODOS"	)

dw_1.Object.cd_convenio[1] = 0

/* PBM */
idwc_Child  = dw_1.of_InsertRow_DDDW("cd_pbm" )			

idwc_Child.SetItem(1, "cd_pbm", 0	)
idwc_Child.SetItem(1, "nm_pbm", "TODOS"	)
idwc_Child.SetItem(1, "cd_convenio", 52718)
idwc_Child.SetFilter('cd_convenio=52718')
idwc_Child.Filter()


/*Canal de Vendas*/
idwc_Child  = dw_1.of_InsertRow_DDDW("id_canal_venda" )	
idwc_Child.SetItem(1, "cd_canal_venda", "TD")
idwc_Child.SetItem(1, "de_canal_venda", "TODOS")



dw_1.Object.cd_pbm[1] = 0
dw_1.Object.id_canal_venda[1] = 'TD'
end subroutine

on w_ge157_vendas_epharma.create
call super::create
end on

on w_ge157_vendas_epharma.destroy
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
ivds_desconto.of_changedataobject('ds_ge157_desconto_produto')

ivds_devolucao = Create dc_uo_ds_base
ivds_devolucao.of_changedataobject('ds_ge157_devolucao')

ivds_programa = Create dc_uo_ds_base
ivds_programa.of_changedataobject('ds_ge157_programa_pbm')


MaxHeight	= 9999
MaxWidth	= 6175
end event

event close;call super::close;Destroy(ivo_Produto)
Destroy(ivo_Filial)
Destroy(ivds_desconto)
Destroy(ivds_devolucao)
Destroy(ivds_programa)
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge157_vendas_epharma
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge157_vendas_epharma
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge157_vendas_epharma
integer y = 444
integer width = 4114
integer height = 1260
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge157_vendas_epharma
integer width = 4110
integer height = 428
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge157_vendas_epharma
integer width = 4050
integer height = 316
string dataobject = "dw_ge157_selecao"
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
End Choose
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge157_vendas_epharma
integer y = 520
integer width = 4046
integer height = 1152
string dataobject = "dw_ge157_epharma"
boolean hscrollbar = true
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Prod_PBM
String lvs_Manipulado
String lvs_Tipo_Venda
String lvs_SQL
String lvs_Canal_Venda

Date lvdt_Inicio

Long lvl_Convenio
Long lvl_PBM
Long lvl_Filial
Long lvl_Produto

dw_1.accepttext( )
ivds_devolucao.of_restoresqloriginal( )

This.SetFilter("")
This.Filter()

lvs_Prod_PBM	= dw_1.Object.id_produtos_pbm	[1]
lvl_PBM			= dw_1.Object.cd_pbm				[1]
lvl_Convenio		= dw_1.Object.cd_convenio			[1]
lvl_Filial			= dw_1.Object.cd_filial				[1]
lvl_Produto		= dw_1.Object.cd_produto			[1]
lvs_Manipulado	= dw_1.Object.id_manipulados		[1]
lvs_Tipo_Venda= dw_1.Object.id_tipo_venda		[1]
lvdt_Inicio		= dw_1.Object.dt_inicio				[1]
lvs_Canal_Venda = dw_1.Object.id_canal_venda	[1]



If lvs_Prod_PBM = 'S' Then
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
	This.of_AppendWhere("v.id_tipo_venda = '"+lvs_Tipo_Venda+"'")
	ivds_devolucao.of_AppendWhere("v.id_tipo_venda = '"+lvs_Tipo_Venda+"'")	
End If

If lvl_PBM > 0 Then
	This.of_AppendWhere('exists (select 1 from pbm_produto pp1 '+&
										' Where pp1.cd_produto = x.cd_produto '+&
										'	And pp1.cd_pbm = '+String(lvl_PBM)+')')
	ivds_devolucao.of_AppendWhere('exists (select 1 from pbm_produto pp1 '+&
														' Where pp1.cd_produto = x.cd_produto '+&
														'	And pp1.cd_pbm = '+String(lvl_PBM)+')')
End If

If lvl_Convenio > 0 Then
	This.of_AppendWhere("k.cd_convenio_pbm = '"+String(lvl_Convenio)+"'")
	ivds_devolucao.of_AppendWhere("k.cd_convenio_pbm = '"+String(lvl_Convenio)+"'")
End If

If lvs_Manipulado = 'N' Then
	This.of_AppendWhere('x.cd_produto<>684431')
	ivds_devolucao.of_AppendWhere('inf.cd_produto<>684431')
End If

If lvl_Filial > 0 Then
	This.of_AppendWhere('k.cd_filial='+String(lvl_Filial))	
	ivds_devolucao.of_AppendWhere('inf.cd_filial='+String(lvl_Filial))	
	
	lvs_SQL = This.GetSQLSelect()
	lvs_SQL = gf_replace(lvs_SQL, 'idx_data_convenio','idx_fil_dt_conv',0)
	This.of_ChangeSQL(lvs_SQL)
End If

If lvl_Produto > 0 Then
	This.of_AppendWhere('coalesce(x.cd_produto,0)='+String(lvl_Produto))	
	//This.of_appendwhere_subquery('p1.cd_produto='+String(lvl_Produto),1)
	ivds_devolucao.of_AppendWhere('inf.cd_produto='+String(lvl_Produto))	
End If

If lvs_Canal_Venda <>  'TD' Then 
	This.of_appendwhere("v.cd_canal_venda = '"+lvs_Canal_Venda+"'")
	ivds_devolucao.of_appendwhere("v.cd_canal_venda = '"+lvs_Canal_Venda+"'")	
End If 

lvs_SQL = This.GetSQLSelect()

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

event dw_2::ue_postretrieve;call super::ue_postretrieve;Long lvl_Linha
Long lvl_Linhas
Long lvl_Filial
Long lvl_Qtde
Long lvl_Produto
Long lvl_PBM
Long lvl_Convenio
Long lvl_Find

Date lvdt_Inicio
Date lvdt_Fim

String lvs_Devolucao
String lvs_Melhor_Venda
String lvs_PBM
String lvs_sql

Decimal{2} lvdc_Desconto
Decimal{2} lvdc_Melhor_Venda
Decimal{2} lvdc_Venda
Decimal{2} lvdc_Custo
Decimal{2} lvdc_PMC

lvdt_Inicio 			= dw_1.Object.dt_inicio 				[1]
lvdt_Fim	 			= dw_1.Object.dt_fim 				[1]
lvs_Devolucao		= dw_1.Object.id_devolucao		[1]
lvs_Melhor_Venda	= dw_1.Object.id_melhor_venda	[1]

If pl_Linhas > 0 Then
	Open(w_aguarde)
	This.SetRedraw(False)
	
	w_aguarde.Title = 'Atualizando informa$$HEX2$$e700f500$$ENDHEX$$es de programa PBM...'
	w_aguarde.uo_Progress.of_SetMax(pl_Linhas)
	
	If ivds_programa.RowCount() = 0 Then	ivds_programa.Retrieve()
	For lvl_Linha = 1 To pl_Linhas
		lvl_Produto	= This.Object.cd_produto	[lvl_Linha]
		lvl_Find = ivds_programa.Find('cd_produto='+String(lvl_Produto),1,ivds_programa.RowCount())
		
		If lvl_Find > 0 Then
			This.Object.cd_pbm	[lvl_Linha] = ivds_programa.Object.cd_pbm		[lvl_Find]
			This.Object.nm_pbm	[lvl_Linha] = ivds_programa.Object.nm_pbm	[lvl_Find]
		End if
		
		If lvs_Melhor_Venda = 'S' Then
			lvl_Filial 		= This.Object.cd_filial 		[lvl_Linha]
			lvl_Qtde		= This.Object.qt_venda		[lvl_Linha]
			lvdc_PMC	= This.Object.vl_pmc_unit	[lvl_Linha]
			If ivds_desconto.Retrieve(lvdt_Inicio,lvl_Produto,lvl_Filial) > 0 Then
				lvdc_Desconto = ivds_desconto.Object.pc_desconto_sos [1]
			Else
				lvdc_Desconto = 0.00
			End If
			lvdc_Melhor_Venda = lvl_Qtde * Round(( lvdc_PMC * (1 - (lvdc_Desconto / 100))) , 2)
			This.Object.vl_melhor_venda [lvl_Linha] = lvdc_Melhor_Venda
			This.Object.pc_desconto_sos [lvl_Linha] = lvdc_Desconto
		End If
		
			
		w_aguarde.uo_Progress.of_SetProgress(lvl_Linha)
	
	Next
	
	If lvs_Devolucao = 'S' Then
		w_aguarde.uo_Progress.of_SetProgress(0)
		w_aguarde.Title = 'Deduzindo devolu$$HEX2$$e700f500$$ENDHEX$$es vendas...'
		Yield()
		
		lvl_Linhas = ivds_devolucao.Retrieve(lvdt_Inicio,lvdt_Fim)
		lvs_sql = ivds_devolucao.GetSQLselect( )
		w_aguarde.uo_Progress.of_SetMax(lvl_Linhas)
		
		For lvl_Linha = 1 To lvl_Linhas
			lvl_Produto		= ivds_devolucao.Object.cd_produto	[lvl_Linha]
			lvl_Filial			= ivds_devolucao.Object.cd_filial		[lvl_Linha]
			lvl_Convenio		= ivds_devolucao.Object.cd_convenio	[lvl_Linha]
			
			lvl_Find = ivds_programa.Find('cd_produto='+String(lvl_Produto),1,ivds_programa.RowCount())
			If lvl_Find > 0 Then
				lvl_PBM	= ivds_programa.Object.cd_pbm		[lvl_Find]
				lvs_PBM	= ivds_programa.Object.nm_pbm		[lvl_Find]
			Else
				SetNull(lvl_PBM)
				lvs_PBM	= ''
			End if
			
			If (lvl_PBM > 0)and(Not IsNull(lvl_PBM)) Then
				//Controle colocado porque algumas vendas do PDV vem sem codigo de conv$$HEX1$$ea00$$ENDHEX$$nio PBM
				If lvl_Convenio > 0 and Not IsNull(lvl_Convenio) Then 
					lvl_Find =This.Find("cd_filial="+String(lvl_Filial)+" and cd_produto="+String(lvl_Produto)+ &
											" and cd_convenio="+String(lvl_Convenio)+" and cd_pbm="+String(lvl_PBM),1,This.RowCount())
				Else
					lvl_Find =This.Find("cd_filial="+String(lvl_Filial)+" and cd_produto="+String(lvl_Produto)+ &
											" and cd_pbm="+String(lvl_PBM),1,This.RowCount())					
				End If
			Else
				lvl_Find =This.Find("cd_filial="+String(lvl_Filial)+" and cd_produto="+String(lvl_Produto)+ &
										" and cd_convenio="+String(lvl_Convenio),1,This.RowCount())
			End If
			

			If Not(lvl_Find > 0) Or IsNull(lvl_Find) Then
				lvl_Find = This.InsertRow(0)
				This.Object.cd_filial 		[lvl_Find] = lvl_Filial
				This.Object.cd_produto 	[lvl_Find] = lvl_Produto
				This.Object.de_produto	[lvl_Find] = ivds_devolucao.Object.de_produto 	[lvl_Linha]
				This.Object.cd_convenio	[lvl_Find] = lvl_Convenio
				This.Object.cd_pbm		[lvl_Find] = lvl_PBM
				This.Object.nm_pbm		[lvl_Find] = lvs_PBM
				This.Object.nm_convenio[lvl_Find] = ivds_devolucao.Object.nm_convenio	[lvl_Linha]
				This.Object.vl_pmc_unit	[lvl_Find] = ivds_devolucao.Object.vl_pmc_unit		[lvl_Linha]	
				This.Object.vl_pmc		[lvl_Find] = 0.00	
				This.Object.vl_venda		[lvl_Find] = 0.00
				This.Object.qt_venda		[lvl_Find] = 0.00
				This.Object.vl_custo		[lvl_Find] = 0.00
			Else
				lvdc_Venda 	= This.Object.vl_venda	[lvl_Find]
				lvl_Qtde		= This.Object.qt_venda	[lvl_Find]
				lvdc_Custo	= This.Object.vl_custo	[lvl_Find]
				lvdc_PMC	= This.Object.vl_pmc		[lvl_Find]				
			End If
			
			This.Object.vl_venda	[lvl_Find] = lvdc_Venda	- ivds_devolucao.Object.vl_devolucao	[lvl_Linha]
			This.Object.qt_venda	[lvl_Find] = lvl_Qtde 		- ivds_devolucao.Object.qt_devolvida	[lvl_Linha]
			This.Object.vl_custo	[lvl_Find] = lvdc_Custo	- ivds_devolucao.Object.vl_custo		[lvl_Linha]
			This.Object.vl_pmc	[lvl_Find] = lvdc_PMC 	- ivds_devolucao.Object.vl_pmc		[lvl_Linha]
			
			w_aguarde.uo_Progress.of_SetProgress(lvl_Linha)
		Next
	End If
	
	This.SetFilter("vl_venda <> 0")
	This.Filter()
	
	This.SetRedraw(True)
	Close(w_aguarde)
End If

ivm_menu.mf_salvarComo(pl_Linhas > 0)

Return AncestorReturnValue
end event

event dw_2::ue_reset;call super::ue_reset;ivm_menu.mf_salvarComo(False)
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge157_vendas_epharma
integer x = 2715
integer y = 36
integer height = 220
end type

