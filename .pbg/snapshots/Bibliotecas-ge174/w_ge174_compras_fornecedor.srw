HA$PBExportHeader$w_ge174_compras_fornecedor.srw
forward
global type w_ge174_compras_fornecedor from dc_w_sheet
end type
type tab_1 from tab within w_ge174_compras_fornecedor
end type
type tabpage_1 from userobject within tab_1
end type
type dw_11 from dc_uo_dw_base within tabpage_1
end type
type dw_10 from dc_uo_dw_base within tabpage_1
end type
type cb_1 from commandbutton within tabpage_1
end type
type dw_9 from dc_uo_dw_base within tabpage_1
end type
type dw_8 from dc_uo_dw_base within tabpage_1
end type
type gb_2 from groupbox within tabpage_1
end type
type gb_1 from groupbox within tabpage_1
end type
type dw_4 from dc_uo_dw_base within tabpage_1
end type
type dw_1 from dc_uo_dw_base within tabpage_1
end type
type dw_2 from dc_uo_dw_base within tabpage_1
end type
type tabpage_1 from userobject within tab_1
dw_11 dw_11
dw_10 dw_10
cb_1 cb_1
dw_9 dw_9
dw_8 dw_8
gb_2 gb_2
gb_1 gb_1
dw_4 dw_4
dw_1 dw_1
dw_2 dw_2
end type
type tabpage_2 from userobject within tab_1
end type
type gb_3 from groupbox within tabpage_2
end type
type dw_3 from dc_uo_dw_base within tabpage_2
end type
type dw_5 from dc_uo_dw_base within tabpage_2
end type
type tabpage_2 from userobject within tab_1
gb_3 gb_3
dw_3 dw_3
dw_5 dw_5
end type
type tabpage_3 from userobject within tab_1
end type
type gb_4 from groupbox within tabpage_3
end type
type dw_6 from dc_uo_dw_base within tabpage_3
end type
type dw_7 from dc_uo_dw_base within tabpage_3
end type
type tabpage_3 from userobject within tab_1
gb_4 gb_4
dw_6 dw_6
dw_7 dw_7
end type
type tab_1 from tab within w_ge174_compras_fornecedor
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type
end forward

global type w_ge174_compras_fornecedor from dc_w_sheet
string tag = "w_ge174_compras_fornecedor"
integer width = 4329
integer height = 2180
string title = "GE174 - Relat$$HEX1$$f300$$ENDHEX$$rio de Compras por Fornecedor"
long backcolor = 80269524
event ue_retrieve ( )
tab_1 tab_1
end type
global w_ge174_compras_fornecedor w_ge174_compras_fornecedor

type variables
uo_fornecedor ivo_fornecedor
dc_uo_ds_base ids

Boolean lvs_Dw_Almoxarifado = False

Date idh_Inicio, idh_Termino

Long il_Divisao
end variables

forward prototypes
public function boolean wf_atualiza_faturamento_ec ()
public function boolean wf_atualiza_faturamento_detalhe_ec ()
public function boolean wf_atualiza_faturamento_est_central ()
public function long wf_gera_relatorio_padrao (long al_tipo, dc_uo_dw_base adw, string ads_detalhe, string ads_detalhe_central)
public function long wf_gera_relatorio_sumarizado (long al_tipo, dc_uo_dw_base adw, string ads_detalhe, string ads_detalhe_central)
public function boolean wf_atualiza_detalhe_divisao (string as_tipo)
public subroutine wf_atualiza_desconto ()
public subroutine wf_atualiza_desconto_detalhe ()
end prototypes

event ue_retrieve;Tab_1.TabPage_1.dw_2.Event ue_Retrieve()
end event

public function boolean wf_atualiza_faturamento_ec ();Boolean lvb_Sucesso = True

Date lvdt_Inicio,&
	 lvdt_Termino

Decimal lvdc_Valor_Total

Long lvl_Linha,&
	 lvl_Linhas,&
	 lvl_Find,&
	 lvl_Insert, &
	 ll_Divisao
	 
String lvs_Fornecedor,&
	     lvs_Razao_Social
	   
Tab_1.TabPage_1.dw_1.AcceptText()
	  
lvs_Fornecedor	= Tab_1.TabPage_1.dw_1.Object.Cd_Fornecedor				[1]
lvdt_Inicio		= Tab_1.TabPage_1.dw_1.Object.Dt_Inicio	   					[1]
lvdt_Termino	= Tab_1.TabPage_1.dw_1.Object.Dt_Termino					[1]
ll_Divisao			= Tab_1.TabPage_1.dw_1.Object.Nr_Divisao_Fornecedor	[1]

Tab_1.TabPage_1.dw_2.SetRedraw(False)

Try

	If Not IsNull(ll_Divisao	) And ll_Divisao > 0 Then
		If IsValid(ids) Then Destroy(ids)
		ids = Create dc_uo_ds_base
		
		If Not ids.of_ChangeDataObject("dw_ge174_detalhe_divisao") Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar o data store 'dw_ge174_detalhe_divisao'.", StopSign!)
			Return False
		End If
		
		ids.of_appendwhere_subquery("i.cd_produto in (select cd_produto from fornecedor_divisao_produto where cd_fornecedor = '" + lvs_Fornecedor + "' and nr_divisao = " + String(ll_Divisao) + ")", 1)
		ids.of_appendwhere_subquery("i.cd_produto in (select cd_produto from fornecedor_divisao_produto where cd_fornecedor = '" + lvs_Fornecedor + "' and nr_divisao = " + String(ll_Divisao) + ")", 3)
		
		ids.of_appendwhere_subquery("n.cd_filial = 534", 1)
		ids.of_appendwhere_subquery("n.cd_filial = 534", 3)
		
		If ids.Retrieve(lvdt_Inicio, lvdt_Termino, lvs_Fornecedor) < 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no retrieve da 'dw_ge174_detalhe_divisao'.", StopSign!)
			Return False
		End If
		
		If Not wf_Atualiza_Detalhe_Divisao('EST') Then Return False

	Else
		
		dc_uo_ds_base lvds
		lvds = Create dc_uo_ds_base
		
		If Not lvds.of_ChangeDataObject("ds_ge174_lista_ec") Then
			Return False
		End If
		
		If Not IsNull(lvs_Fornecedor) and Trim(lvs_Fornecedor) <> "" Then
			lvds.of_AppendWhere("n.cd_fornecedor = '" + lvs_Fornecedor + "'")
		End If
		
		lvds.Retrieve(lvdt_Inicio, lvdt_Termino)
		
		lvl_Linhas = lvds.RowCount()
		
		For lvl_Linha = 1 To lvl_Linhas
			lvs_Fornecedor   = lvds.Object.cd_fornecedor  		[lvl_Linha]
			lvs_Razao_Social = lvds.Object.nm_razao_social	[lvl_Linha]
			lvdc_Valor_Total = lvds.Object.valor		  			[lvl_Linha]
			
			lvl_Find = Tab_1.TabPage_1.dw_2.Find("cd_fornecedor = '" + lvs_Fornecedor + "'", 1, Tab_1.TabPage_1.dw_2.RowCount())
			
			If lvl_Find = -1 Then
				lvb_Sucesso = False
				Exit
			End If
			
			If lvl_Find > 0 Then
				Tab_1.TabPage_1.dw_2.Object.valor_ec[lvl_Find] = lvdc_Valor_Total
			Else
				lvl_Insert = Tab_1.TabPage_1.dw_2.InsertRow(0)
				
				Tab_1.TabPage_1.dw_2.Object.valor		   [lvl_Insert] = 0.00
				Tab_1.TabPage_1.dw_2.Object.valor_ec	   [lvl_Insert] = lvdc_Valor_Total	
				Tab_1.TabPage_1.dw_2.Object.cd_fornecedor  [lvl_Insert] = lvs_Fornecedor
				Tab_1.TabPage_1.dw_2.Object.nm_razao_social[lvl_Insert] = lvs_Razao_Social
			End If
		Next
	End If
				
	If Tab_1.TabPage_1.dw_1.Object.id_estoque_central[1] = 'S' Then
		If Not wf_Atualiza_Faturamento_Est_Central() Then Return False 
	End If
	
Finally
	If IsValid(lvds) Then Destroy(lvds)
	If IsValid(ids) Then Destroy(ids)
End Try
	
Tab_1.TabPage_1.dw_2.SetRedraw(True)

Return True
end function

public function boolean wf_atualiza_faturamento_detalhe_ec ();Boolean lvb_Sucesso = True

Date lvdt_Inicio,&
     lvdt_Termino
	 
Decimal lvdc_Valor_Total

Long lvl_Linha,&
	 lvl_Linhas,&
	 lvl_Find,&
	 lvl_Insert,&
	 lvl_Linha_Ativa, &
	 ll_Divisao
	 
String lvs_Fornecedor,&
	   lvs_Razao_Social,&
	   lvs_Razao_Social_For,&
	   lvs_Fornecedor_For

	   
Tab_1.TabPage_1.dw_1.AcceptText()
Tab_1.TabPage_1.dw_2.AcceptText()

lvl_Linha_Ativa = Tab_1.TabPage_1.dw_2.GetRow()

lvdt_Inicio          = Tab_1.TabPage_1.dw_1.Object.dt_inicio [1]
lvdt_Termino         = Tab_1.TabPage_1.dw_1.Object.dt_termino[1]
lvs_Fornecedor_For   = Tab_1.TabPage_1.dw_2.Object.cd_fornecedor  [lvl_Linha_Ativa]
lvs_Razao_Social_For = Tab_1.Tabpage_1.dw_2.Object.nm_razao_social[lvl_Linha_Ativa]
ll_Divisao					= Tab_1.TabPage_1.dw_1.Object.Nr_Divisao_Fornecedor[1]
	
dc_uo_ds_base lvds 
lvds = Create dc_uo_ds_base

If Not lvds.of_ChangeDataObject("ds_ge174_detalhe") Then
	Destroy(lvds)
	Return False
End If

If Not IsNull(ll_Divisao) And ll_Divisao > 0 Then
	lvds.of_appendwhere("i.cd_produto in (select cd_produto from fornecedor_divisao_produto where cd_fornecedor = '" + lvs_Fornecedor_For + "' and nr_divisao = " + String(ll_Divisao) + ")")
End If

lvds.Retrieve(lvdt_Inicio, lvdt_Termino, lvs_Fornecedor_For)

lvl_Linhas = lvds.RowCount()

For lvl_Linha = 1 To lvl_Linhas
	lvs_Fornecedor   = lvds.Object.cd_fornecedor_usual[lvl_Linha]
	lvs_Razao_Social = lvds.Object.nm_razao_social	  [lvl_Linha]
	lvdc_Valor_Total = lvds.Object.vl_custo		  	  [lvl_Linha]
	
	
	lvl_Find = Tab_1.TabPage_2.dw_3.Find("cd_fornecedor_usual = '" + lvs_Fornecedor + "'", 1, Tab_1.TabPage_2.dw_3.RowCount())
	
	If lvl_Find = -1 Then
		lvb_Sucesso = False
		Exit
	End If
	
	If lvl_Find > 0 Then
		Tab_1.TabPage_2.dw_3.Object.vl_custo_ec[lvl_Find] = lvdc_Valor_Total
	Else
		lvl_Insert = Tab_1.TabPage_2.dw_3.InsertRow(0)
		
		Tab_1.TabPage_2.dw_3.Object.vl_custo	   	   [lvl_Insert] = 0.00
		Tab_1.TabPage_2.dw_3.Object.vl_custo_ec	   	   [lvl_Insert] = lvdc_Valor_Total	
		Tab_1.TabPage_2.dw_3.Object.cd_fornecedor_usual[lvl_Insert] = lvs_Fornecedor
		Tab_1.TabPage_2.dw_3.Object.nm_razao_social	   [lvl_Insert] = lvs_Razao_Social
	End If
Next
	
Destroy(lvds)

Return lvb_Sucesso
end function

public function boolean wf_atualiza_faturamento_est_central ();Boolean lvb_Sucesso = True

Date lvdt_Inicio,&
	 lvdt_Termino

Decimal lvdc_Valor_Total

Long lvl_Linha,&
	 lvl_Linhas,&
	 lvl_Find,&
	 lvl_Insert
	 
String lvs_Fornecedor,&
	     lvs_Razao_Social,&
		 lvs_Material_Expediente
	   
Tab_1.TabPage_1.dw_1.AcceptText()
	  
lvdt_Inicio 				= Tab_1.TabPage_1.dw_1.Object.Dt_Inicio					[1]
lvdt_Termino  			= Tab_1.TabPage_1.dw_1.Object.Dt_Termino				[1]
lvs_Material_Expediente  =  Tab_1.TabPage_1.dw_1.Object.id_material_exped[1]
lvs_Dw_Almoxarifado   = True

dc_uo_ds_base lvds 
lvds = Create dc_uo_ds_base

If Not lvds.of_ChangeDataObject("ds_ge174_lista_central") Then
	Destroy(lvds)
	Return False
End If

//If Not IsNull(lvs_Fornecedor) and Trim(lvs_Fornecedor) <> "" Then
//	lvds.of_AppendWhere("n.cd_fornecedor = '" + lvs_Fornecedor + "'")
//End If

If lvs_Dw_Almoxarifado then 
	If lvs_Material_Expediente  = "N"  Then 
		lvds.of_AppendWhere("n.id_almoxarifado  = 'N'")
	End If 
End If

lvds.Retrieve(lvdt_Inicio, lvdt_Termino)

lvl_Linhas = lvds.RowCount()

For lvl_Linha = 1 To lvl_Linhas
	lvs_Fornecedor   = lvds.Object.nr_filial  [lvl_Linha]
	lvs_Razao_Social = lvds.Object.fantasia[lvl_Linha]
	lvdc_Valor_Total = lvds.Object.valor		  [lvl_Linha]
	
	lvl_Find = Tab_1.TabPage_1.dw_2.Find("cd_fornecedor = '" + lvs_Fornecedor + "'", 1, Tab_1.TabPage_1.dw_2.RowCount())
	
	If lvl_Find = -1 Then
		lvb_Sucesso = False
		Exit
	End If
	
	If lvl_Find > 0 Then
		Tab_1.TabPage_1.dw_2.Object.valor[lvl_Find] = lvdc_Valor_Total
	Else
		lvl_Insert = Tab_1.TabPage_1.dw_2.InsertRow(0)
		
		Tab_1.TabPage_1.dw_2.Object.valor		   [lvl_Insert] = 0.00
		Tab_1.TabPage_1.dw_2.Object.valor   	   [lvl_Insert] = lvdc_Valor_Total	
		Tab_1.TabPage_1.dw_2.Object.cd_fornecedor  [lvl_Insert] = lvs_Fornecedor
		Tab_1.TabPage_1.dw_2.Object.nm_razao_social[lvl_Insert] = lvs_Razao_Social
	End If
Next
	
Destroy(lvds)

Return True
end function

public function long wf_gera_relatorio_padrao (long al_tipo, dc_uo_dw_base adw, string ads_detalhe, string ads_detalhe_central);Boolean lvb_Sucesso = True

Date	lvdt_Inicio, &
     	lvdt_Termino
	  
Decimal{2} lvdc_Custo, lvdc_Custo_Fil, lvdc_Custo_EC

Integer lvi_Retorno

Long lvl_Linha_lds_1, lvl_Find, lvl_Insert, lvl_Linha, ll_Divisao

String	lvs_Fornecedor, &
	   	lvs_Path, &
	   	lvs_Arquivo, &
	   	lvs_Estoque_Central, &
		lvs_Lei_Generico, &
		lvs_Fornecedor_lds_1, &
		lvs_Razao_Social_lds_1, &
		lvs_Fornecedor_Usual_lds_1, &
		lvs_Razao_Social_Usual_lds_1, &
		lvs_Fornecedor_Usual, &
		lvs_Razao_Social_Usual, &
		ls_Cgc, &
		ls_Grupo, &
		ls_Comprador,&
		lvs_Material_Expediente
		

Tab_1.TabPage_1.dw_1.AcceptText()

Try
	  
	lvs_Fornecedor      		= Tab_1.TabPage_1.dw_1.Object.Cd_Fornecedor     			[1]
	lvdt_Inicio 	    				= Tab_1.TabPage_1.dw_1.Object.Dt_Inicio	    					[1]
	lvdt_Termino  	    			= Tab_1.TabPage_1.dw_1.Object.Dt_Termino     				[1]
	lvs_estoque_Central		= Tab_1.TabPage_1.dw_1.Object.id_estoque_central			[1]
	lvs_Material_Expediente	= Tab_1.TabPage_1.dw_1.Object.id_material_exped			[1]
	ll_Divisao						= Tab_1.TabPage_1.dw_1.Object.Nr_Divisao_Fornecedor	[1]
							
	SetPointer(HourGlass!)
	
	adw.Event ue_Reset()
	
	dc_uo_ds_base lds_1
	lds_1 = Create dc_uo_ds_base
	
	If Not lds_1.of_ChangeDataObject(ads_detalhe) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar o data store '" + ads_detalhe + "'.", StopSign!)
		Destroy(lds_1)
		Return -1
	End If
	
	If Not IsNull(lvs_Fornecedor) and Trim(lvs_Fornecedor) <> "" Then
		lds_1.of_appendwhere_subquery("n.cd_fornecedor = '" + lvs_Fornecedor + "'", 1)
		lds_1.of_appendwhere_subquery("n.cd_fornecedor = '" + lvs_Fornecedor + "'", 2)
		lds_1.of_appendwhere_subquery("n.cd_fornecedor = '" + lvs_Fornecedor + "'", 3)
		
		If Not IsNull(ll_Divisao) And ll_Divisao > 0 Then
			lds_1.of_appendwhere_subquery("i.cd_produto in (select cd_produto from fornecedor_divisao_produto where cd_fornecedor = '" + lvs_Fornecedor + "' and nr_divisao = " + String(ll_Divisao) + ")", 1)
			lds_1.of_appendwhere_subquery("i.cd_produto in (select cd_produto from fornecedor_divisao_produto where cd_fornecedor = '" + lvs_Fornecedor + "' and nr_divisao = " + String(ll_Divisao) + ")", 3)
			lds_1.of_appendwhere_subquery("i.cd_produto in (select cd_produto from fornecedor_divisao_produto where cd_fornecedor = '" + lvs_Fornecedor + "' and nr_divisao = " + String(ll_Divisao) + ")", 5)
		End If
	End If
	
	If lds_1.Retrieve(lvdt_Inicio, lvdt_Termino) = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no retrieve do data store '" + ads_detalhe + "'.", StopSign!)
		Destroy(lds_1)
		Return -1
	End If
	
	Open(w_Aguarde)
	
	For lvl_Linha_lds_1	= 1 To lds_1.RowCount() 
		
		lvs_Fornecedor_lds_1 			= 	lds_1.Object.cd_fornecedor				[lvl_Linha_lds_1]
		lvs_Razao_Social_lds_1			= 	lds_1.Object.nm_razao_social			[lvl_Linha_lds_1]
		
		lvs_Fornecedor_Usual_lds_1	= 	lds_1.Object.cd_fornecedor_usual		[lvl_Linha_lds_1]
		lvs_Razao_Social_Usual_lds_1	= 	lds_1.Object.nm_razao_social_usual	[lvl_Linha_lds_1]
		ls_Cgc								=  lds_1.Object.Nr_Cgc						[lvl_Linha_lds_1]
		
		If al_Tipo = 1 Then
			lvs_Lei_Generico				= 	lds_1.Object.id_lei_generico				[lvl_Linha_lds_1]
			ls_Grupo							=  lds_1.Object.de_grupo					[lvl_Linha_lds_1]
		ElseIf al_Tipo = 3 Then
			ls_Comprador					= lds_1.Object.Nm_Comprador				[lvl_Linha_lds_1]
			ls_Grupo							=  lds_1.Object.de_grupo					[lvl_Linha_lds_1]
		Else
			ls_Comprador					= lds_1.Object.Nm_Comprador				[lvl_Linha_lds_1]
		End If
		
		lvdc_Custo			 				=	lds_1.Object.vl_valor						[lvl_Linha_lds_1]
		lvdc_Custo_FIL						=	lds_1.Object.vl_valor_fil					[lvl_Linha_lds_1]
		lvdc_Custo_EC						=	lds_1.Object.vl_valor_ec					[lvl_Linha_lds_1]
		
		//Planilha por Fornecedor tem id_lei_gen$$HEX1$$e900$$ENDHEX$$rico e de_grupo
		//Planilha por Fornecedor por M$$HEX1$$ea00$$ENDHEX$$s tem somente id_lei gen$$HEX1$$e900$$ENDHEX$$rico	
		
		Choose Case al_Tipo
			Case 1
				lvl_Find = adw.Find("cd_fornecedor = '" + lvs_Fornecedor_lds_1 + "' and cd_fornecedor_usual = '" + lvs_Fornecedor_Usual_lds_1 + "' and id_lei_generico = '" + lvs_Lei_Generico + "' and de_grupo = '" + ls_Grupo + "'", 1, adw.RowCount())		
			Case 3
				lvl_Find = adw.Find("cd_fornecedor = '" + lvs_Fornecedor_lds_1 + "' and cd_fornecedor_usual = '" + lvs_Fornecedor_Usual_lds_1 + "' and nm_comprador = '" + ls_Comprador + "' and de_grupo = '" + ls_Grupo + "'", 1, adw.RowCount())
			Case Else
				lvl_Find = adw.Find("cd_fornecedor = '" + lvs_Fornecedor_lds_1 + "' and cd_fornecedor_usual = '" + lvs_Fornecedor_Usual_lds_1 + "' and nm_comprador = '" + ls_Comprador + "'", 1, adw.RowCount())
		End Choose
					
		If lvl_Find < 0 Then
			Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no FIND ao localizar o fornecedor.")
			lvb_Sucesso = False
			Exit
		End If
		
		If lvl_Find = 0 Then
			lvl_Insert = adw.InsertRow(0)
			
			adw.Object.cd_fornecedor				[lvl_Insert] 	= 	lvs_Fornecedor_lds_1
			adw.Object.nm_razao_social			[lvl_Insert]	=	lvs_Razao_Social_lds_1	
			adw.Object.cd_fornecedor_usual		[lvl_Insert] 	= 	lvs_Fornecedor_Usual_lds_1
			adw.Object.nm_razao_social_usual	[lvl_Insert] 	= 	lvs_Razao_Social_Usual_lds_1
			adw.Object.Nr_Cgc						[lvl_Insert]	=  ls_Cgc
					
			If al_Tipo = 1 Then
				adw.Object.id_lei_generico			[lvl_Insert] 	= 	lvs_Lei_Generico
				adw.Object.de_grupo					[lvl_Insert] 	= 	ls_Grupo
			ElseIf al_Tipo = 3 Then
				adw.Object.Nm_Comprador			[lvl_Insert]	= ls_Comprador
				adw.Object.de_grupo					[lvl_Insert] 	= 	ls_Grupo
			Else
				adw.Object.Nm_Comprador			[lvl_Insert]	= ls_Comprador
			End If
			
			adw.Object.vl_valor						[lvl_Insert]	= 	lvdc_Custo_Fil + lvdc_Custo_EC
			adw.Object.vl_valor_fil					[lvl_Insert]	= 	lvdc_Custo_Fil
			adw.Object.vl_valor_ec					[lvl_Insert]	= 	lvdc_Custo_ec
		Else		
			adw.Object.vl_valor			[lvl_Find]	= adw.Object.vl_valor		[lvl_Find] + lvdc_Custo_Fil + lvdc_Custo_ec
			adw.Object.vl_valor_fil		[lvl_Find]	= adw.Object.vl_valor_fil		[lvl_Find] + lvdc_Custo_Fil
			adw.Object.vl_valor_ec		[lvl_Find]	= adw.Object.vl_valor_ec	[lvl_Find] + lvdc_Custo_EC
		End If
		
	Next	 
	
	If Not lvb_Sucesso Then
		Return -1
	End If 
	
	adw.Sort()
	adw.GroupCalc()
		 
	If lvs_estoque_Central = 'S' Then	 
		lvs_Dw_Almoxarifado = True	 
		dc_uo_ds_base lds_2 
		lds_2 = Create dc_uo_ds_base
		
		If Not lds_2.of_ChangeDataObject(ads_detalhe_central) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar o data store '" + + "'.", StopSign!)
			Return -1
		End If
		
		If lvs_Dw_Almoxarifado Then 
			If lvs_Material_Expediente  = "N"  Then 
				lds_2.of_appendwhere("n.id_almoxarifado  ='N' ")
			End If 
		End If 
		
		If Not IsNull(lvs_Fornecedor) and Trim(lvs_Fornecedor) <> "" Then
			lds_2.of_AppendWhere("f.cd_fornecedor = '" + lvs_Fornecedor + "'", 1)
			
			If Not IsNull(ll_Divisao) And ll_Divisao > 0 Then
				lds_2.of_AppendWhere("i.cd_produto in (select cd_produto from fornecedor_divisao_produto where cd_fornecedor = '" + lvs_Fornecedor + "' and nr_divisao = " + String(ll_Divisao) + ")", 1)
			End If
		End If
		
		If lds_2.Retrieve(lvdt_Inicio, lvdt_Termino) = -1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no retrieve da dw '" + ads_detalhe_central + "'.")
			Return -1
		End If
				
		For lvl_Linha = 1 To lds_2.RowCount()
			
			lvs_Fornecedor_Usual		= lds_2.Object.cd_fornecedor_usual	[lvl_Linha]
			lvs_Razao_Social_Usual 	= lds_2.Object.nm_razao_social	  	[lvl_Linha]
			ls_Cgc						= lds_2.Object.Nr_Cgc					[lvl_Linha]
			lvdc_Custo 					= lds_2.Object.vl_custo		  	  		[lvl_Linha]
			
			If al_Tipo = 1 Then
				lvs_Lei_Generico			= lds_2.Object.id_lei_generico 		[lvl_Linha]
				ls_Grupo						= lds_2.Object.de_grupo		 		[lvl_Linha]
			ElseIf al_Tipo = 3 Then
				ls_Comprador				= lds_2.Object.Nm_Comprador		[lvl_Linha]
				ls_Grupo						= lds_2.Object.de_grupo		 		[lvl_Linha]
			Else
				ls_Comprador				= lds_2.Object.Nm_Comprador		[lvl_Linha]
			End If
			
			lvl_Insert = adw.InsertRow(0)	
					
			adw.Object.cd_fornecedor    			[lvl_Insert] = '53404705'
			adw.Object.nm_razao_social         	[lvl_Insert] = 'ESTOQUE CENTRAL'
			adw.Object.cd_fornecedor_usual     	[lvl_Insert] = lvs_Fornecedor_usual
			adw.Object.nm_razao_social_usual	[lvl_Insert] = lvs_Razao_Social_Usual
			adw.Object.Nr_Cgc						[lvl_Insert] = ls_Cgc
		
			If al_Tipo = 1 Then
				adw.Object.id_lei_generico          	[lvl_Insert] = lvs_Lei_Generico
				adw.Object.de_grupo					[lvl_Insert] = ls_Grupo
			ElseIf al_Tipo = 3 Then
				adw.Object.Nm_Comprador			[lvl_Insert] = ls_Comprador
				adw.Object.de_grupo					[lvl_Insert] = ls_Grupo
			Else
				adw.Object.Nm_Comprador			[lvl_Insert] = ls_Comprador
			End If
					
			adw.Object.vl_valor	   	              	[lvl_Insert] = lvdc_Custo
			adw.Object.vl_valor_fil 	              	[lvl_Insert] = lvdc_Custo
			adw.Object.vl_valor_ec 	           	  	[lvl_Insert] = 0.00
		Next		
	End If
	
	If adw.RowCount() > 0 Then
		adw.Event ue_SaveAs()
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.")
	End If

Finally	
	SetPointer(Arrow!)
	If IsValid(lds_1) Then Destroy(lds_1)
	If IsValid(lds_2) Then Destroy(lds_2)
	Close(w_Aguarde)
End Try
end function

public function long wf_gera_relatorio_sumarizado (long al_tipo, dc_uo_dw_base adw, string ads_detalhe, string ads_detalhe_central);Boolean lvb_Sucesso = True

Date	lvdt_Inicio, &
     	lvdt_Termino, &
		ldt_Inicio_Sum, &
		ldt_Fim_Sum, &
		ldt_Periodo
		 	  
Decimal{2} lvdc_Custo, lvdc_Custo_Fil, lvdc_Custo_EC

Integer lvi_Retorno

Long lvl_Linha_DS, lvl_Find, lvl_Insert, lvl_Linha, ll_Mes, ll_Ano, ll_Divisao

String	lvs_Path,&
	   	lvs_Arquivo,&
		lvs_Lei_Generico,&
		lvs_Fornecedor_DS,&
		lvs_Razao_Social_DS,&
		lvs_Fornecedor_Usual_DS,&
		lvs_Razao_Social_Usual_DS,&
		lvs_Fornecedor_Usual,&
		lvs_Razao_Social_Usual, &
		ls_Cgc, &
		lvs_Diretorio, &
		ls_Nome_Pla, &
		lvs_Fornecedor, &
		lvs_estoque_Central, &
		ls_Comprador,& 
		ls_Grupo,&
		lvs_Material_Expediente		
	
Tab_1.TabPage_1.dw_1.AcceptText()

Try

	lvs_Fornecedor      		= Tab_1.TabPage_1.dw_1.Object.Cd_Fornecedor     			[1]
	lvdt_Inicio					= Tab_1.TabPage_1.dw_1.Object.Dt_Inicio						[1]
	lvdt_Termino				= Tab_1.TabPage_1.dw_1.Object.Dt_Termino					[1]
	lvs_estoque_Central 		= Tab_1.TabPage_1.dw_1.Object.id_estoque_central			[1]
	lvs_Material_Expediente	= Tab_1.TabPage_1.dw_1.Object.id_material_exped			[1]
	ll_Divisao						= Tab_1.TabPage_1.dw_1.Object.Nr_Divisao_Fornecedor	[1]
	
	lvdt_Inicio = Date("01/" + String(lvdt_Inicio, "mm/yyyy"))
	
	lvs_Diretorio = gvo_Aplicacao.of_GetFromINI("Diretorio", "Diretorio")
	
	SetPointer(HourGlass!)
	
	dc_uo_ds_base ds
	ds = Create dc_uo_ds_base
	
	If Not ds.of_ChangeDataObject(ads_detalhe) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar o data store " + ads_detalhe + ".", StopSign!)
		Return -1
	End If
	
	Open(w_Aguarde)
	
	Do While lvdt_Inicio <= lvdt_Termino
		
		//Limpa o data store para n$$HEX1$$e300$$ENDHEX$$o acumular os valores
		adw.Event ue_Reset()
		
		ldt_Inicio_Sum	= lvdt_Inicio
		ldt_Fim_Sum	= gf_Retorna_Ultimo_Dia_Mes(ldt_Inicio_Sum)
		
		w_Aguarde.Title = "Gerando per$$HEX1$$ed00$$ENDHEX$$odo '" + String(ldt_Inicio_Sum, "mm/yyyy") + "'. Aguarde..."
		
		If Not IsNull(lvs_Fornecedor) and Trim(lvs_Fornecedor) <> "" Then
			ds.of_appendwhere_subquery("n.cd_fornecedor = '" + lvs_Fornecedor + "'", 1)
			ds.of_appendwhere_subquery("n.cd_fornecedor = '" + lvs_Fornecedor + "'", 2)
			ds.of_appendwhere_subquery("n.cd_fornecedor = '" + lvs_Fornecedor + "'", 3)
			
			If Not IsNull(ll_Divisao) And ll_Divisao > 0 Then
				ds.of_appendwhere_subquery("i.cd_produto in (select cd_produto from fornecedor_divisao_produto where cd_fornecedor = '" + lvs_Fornecedor + "' and nr_divisao = " + String(ll_Divisao) + ")", 1)
				ds.of_appendwhere_subquery("i.cd_produto in (select cd_produto from fornecedor_divisao_produto where cd_fornecedor = '" + lvs_Fornecedor + "' and nr_divisao = " + String(ll_Divisao) + ")", 3)
				ds.of_appendwhere_subquery("i.cd_produto in (select cd_produto from fornecedor_divisao_produto where cd_fornecedor = '" + lvs_Fornecedor + "' and nr_divisao = " + String(ll_Divisao) + ")", 5)
			End If
		End If
		
		//Limpa o data store para n$$HEX1$$e300$$ENDHEX$$o acumular os valores
		ds.Reset()
		
		If ds.Retrieve(ldt_Inicio_Sum, ldt_Fim_Sum) = -1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao recuperar as informa$$HEX2$$e700f500$$ENDHEX$$es.")
			Return -1
		End If
		
		For lvl_Linha_DS	= 1 To ds.RowCount()
						
			ldt_Periodo						=  Date(ds.Object.Dh_Movimentacao_Caixa[lvl_Linha_DS])
			lvs_Fornecedor_DS 			= 	ds.Object.cd_fornecedor				[lvl_Linha_DS]
			lvs_Razao_Social_DS			= 	ds.Object.nm_razao_social			[lvl_Linha_DS]
			
			lvs_Fornecedor_Usual_DS	= 	ds.Object.cd_fornecedor_usual		[lvl_Linha_DS]
			lvs_Razao_Social_Usual_DS	= 	ds.Object.nm_razao_social_usual	[lvl_Linha_DS]
			ls_Cgc							=  ds.Object.Nr_Cgc						[lvl_Linha_DS]
			
			If al_Tipo = 2 Then
				lvs_Lei_Generico				= ds.Object.id_lei_generico			[lvl_Linha_DS]
			Else
				ls_Comprador					= ds.Object.Nm_Comprador			[lvl_Linha_Ds]
				
				If al_Tipo = 4 Then
					ls_Grupo	= ds.Object.de_grupo	[lvl_Linha_Ds]
				End If
			End If
			
			lvdc_Custo			 			=	ds.Object.vl_valor						[lvl_Linha_DS]
			lvdc_Custo_FIL					=	ds.Object.vl_valor_fil					[lvl_Linha_DS]
			lvdc_Custo_EC					=	ds.Object.vl_valor_ec					[lvl_Linha_DS]
			
			//Planilha por Fornecedor tem id_lei_gen$$HEX1$$e900$$ENDHEX$$rico e de_grupo
			//Planilha por Fornecedor por M$$HEX1$$ea00$$ENDHEX$$s tem somente id_lei gen$$HEX1$$e900$$ENDHEX$$rico
			
			If al_Tipo = 2 Then
				lvl_Find = adw.Find("cd_fornecedor = '" + lvs_Fornecedor_DS + "' and cd_fornecedor_usual = '" + lvs_Fornecedor_Usual_DS + "' and id_lei_generico = '" + lvs_Lei_Generico + "'", 1, adw.RowCount())
			ElseIf al_Tipo = 4 Then
				lvl_Find = adw.Find("cd_fornecedor = '" + lvs_Fornecedor_Ds + "' and cd_fornecedor_usual = '" + lvs_Fornecedor_Usual_Ds + "' and nm_comprador = '" + ls_Comprador + "' and de_grupo = '" + ls_Grupo + "'", 1, adw.RowCount())
			Else
				lvl_Find = adw.Find("cd_fornecedor = '" + lvs_Fornecedor_Ds + "' and cd_fornecedor_usual = '" + lvs_Fornecedor_Usual_Ds + "' and nm_comprador = '" + ls_Comprador + "'", 1, adw.RowCount())
			End If
			
			If lvl_Find < 0 Then
				Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no FIND ao localizar o fornecedor.", StopSign!)
				lvb_Sucesso = False
				Exit
			End If
			
			If lvl_Find = 0 Then
				lvl_Insert = adw.InsertRow(0)
				
				adw.Object.Dh_Movimentacao_Caixa	[lvl_Insert] 	= 	ldt_Periodo
				adw.Object.cd_fornecedor				[lvl_Insert] 	= 	lvs_Fornecedor_DS
				adw.Object.nm_razao_social			[lvl_Insert]	=	lvs_Razao_Social_DS	
				adw.Object.cd_fornecedor_usual		[lvl_Insert] 	= 	lvs_Fornecedor_Usual_DS
				adw.Object.nm_razao_social_usual	[lvl_Insert] 	= 	lvs_Razao_Social_Usual_DS
				adw.Object.Nr_Cgc						[lvl_Insert]	= 	ls_Cgc
				
				If al_Tipo = 2 Then			
					adw.Object.id_lei_generico				[lvl_Insert] 	= 	lvs_Lei_Generico
				Else
					adw.Object.Nm_Comprador				[lvl_Insert] = ls_Comprador
					
					If al_Tipo = 4 Then
						adw.Object.de_grupo	[lvl_Insert] = ls_Grupo
					End If
				End If
				
				adw.Object.vl_valor						[lvl_Insert]	= 	lvdc_Custo_Fil + lvdc_Custo_EC
				adw.Object.vl_valor_fil					[lvl_Insert]	= 	lvdc_Custo_Fil
				adw.Object.vl_valor_ec					[lvl_Insert]	= 	lvdc_Custo_ec
			Else		
				adw.Object.vl_valor		[lvl_Find]	= adw.Object.vl_valor		[lvl_Find] + lvdc_Custo_Fil + lvdc_Custo_ec
				adw.Object.vl_valor_fil	[lvl_Find]	= adw.Object.vl_valor_fil		[lvl_Find] + lvdc_Custo_Fil
				adw.Object.vl_valor_ec	[lvl_Find]	= adw.Object.vl_valor_ec	[lvl_Find] + lvdc_Custo_EC
			End If
			
		Next	 
		
		If Not lvb_Sucesso Then
			Return -1 
		End If 
		
		adw.Sort()
		adw.GroupCalc()
			 
		If lvs_estoque_Central = 'S' Then	 
			lvs_Dw_Almoxarifado = True
			dc_uo_ds_base lvds 
			lvds = Create dc_uo_ds_base
			
			If Not lvds.of_ChangeDataObject(ads_detalhe_central) Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar o data store " + ads_detalhe_central + ".", StopSign!)
				Return -1
			End If
			
			//Limpa o data store para n$$HEX1$$e300$$ENDHEX$$o acumular os valores
			lvds.Reset()
			
			If Not IsNull(lvs_Fornecedor) and Trim(lvs_Fornecedor) <> "" Then
				lvds.of_AppendWhere("f.cd_fornecedor = '" + lvs_Fornecedor + "'", 1)
				
				If Not IsNull(ll_Divisao) And ll_Divisao > 0 Then
					lvds.of_AppendWhere("i.cd_produto in (select cd_produto from fornecedor_divisao_produto where cd_fornecedor = '" + lvs_Fornecedor + "' and nr_divisao = " + String(ll_Divisao) + ")", 1)
				End If
			End If
			
			If lvs_Dw_Almoxarifado Then 
				If lvs_Material_Expediente  = "N"  Then
					lvds.of_appendwhere("n.id_almoxarifado  ='N' ")
				End If 		
			End If 
			
			lvds.Retrieve(ldt_Inicio_Sum, ldt_Fim_Sum)
					
			For lvl_Linha = 1 To lvds.RowCount()
				
				ldt_Periodo					= Date(lvds.Object.Dh_Movimentacao_Caixa	[lvl_Linha])
				lvs_Fornecedor_Usual		= lvds.Object.cd_fornecedor_usual		[lvl_Linha]
				lvs_Razao_Social_Usual 	= lvds.Object.nm_razao_social	  			[lvl_Linha]
				ls_Cgc						= lvds.Object.Nr_Cgc							[lvl_Linha]
				lvdc_Custo 					= lvds.Object.vl_custo		  	  			[lvl_Linha]
				
				If al_Tipo = 2 Then
					lvs_Lei_Generico			= lvds.Object.id_lei_generico 			[lvl_Linha]
				Else
					ls_Comprador				= lvds.Object.Nm_Comprador			[lvl_Linha]
					
					If al_Tipo = 4 Then
						ls_Grupo					= lvds.Object.de_grupo					[lvl_Linha]
					End If
				End If
				
				lvl_Insert = adw.InsertRow(0)	
						
				adw.Object.Dh_Movimentacao_Caixa	[lvl_Insert] = ldt_Periodo		
				adw.Object.cd_fornecedor    			[lvl_Insert] = '53404705'
				adw.Object.nm_razao_social        		[lvl_Insert] = 'ESTOQUE CENTRAL'
				adw.Object.cd_fornecedor_usual     	[lvl_Insert] = lvs_Fornecedor_usual
				adw.Object.nm_razao_social_usual	[lvl_Insert] = lvs_Razao_Social_Usual
				adw.Object.Nr_Cgc						[lvl_Insert] = ls_Cgc
				
				If al_Tipo = 2 Then
					adw.Object.id_lei_generico        [lvl_Insert] = lvs_Lei_Generico
				Else
					adw.Object.Nm_Comprador		  [lvl_Insert] = ls_Comprador
					
					If al_Tipo = 4 Then
						adw.Object.de_grupo			  [lvl_Insert] = ls_Grupo
					End If
				End If
				
				adw.Object.vl_valor	   	            	[lvl_Insert] = lvdc_Custo
				adw.Object.vl_valor_fil 	             	[lvl_Insert] = lvdc_Custo
				adw.Object.vl_valor_ec 	             	[lvl_Insert] = 0.00				
			Next		
		End If
		
		ls_Nome_Pla = gf_Replace(String(ldt_Inicio_Sum), "/", "_", 2)
		ls_Nome_Pla += " a " + gf_Replace(String(ldt_Fim_Sum), "/", "_", 2)
		
		If Not IsNull(ll_Divisao) And ll_Divisao > 0 Then
			ls_Nome_Pla += "_Divisao_" + String(ll_Divisao)
		End If
		
		If adw.RowCount() > 0 Then
			lvs_Arquivo = lvs_Diretorio + "Compras Sumarizadas por Fornecedor por Mes de " + ls_Nome_Pla + ".xls"
			
			If adw.SaveAs(lvs_Arquivo, Excel!, True) <> 1 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no saveas da planilha '" + lvs_Arquivo + "'.", StopSign!)
				Return -1
			End If
		End If
		
		ll_Mes = Month(lvdt_Inicio)
		ll_Ano = Year(lvdt_Inicio)
		
		If ll_Mes >= 12 Then
			ll_Ano++
			ll_Mes = 1
		Else
			ll_Mes++
		End If
		
		lvdt_Inicio = Date("01/" + String(ll_Mes) + "/" + String(ll_Ano))
	Loop	
		
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Arquivos gerados com sucesso em '" + lvs_Diretorio + "'.")		
	
Finally
	Close(w_Aguarde)
	SetPointer(Arrow!)
	If IsValid(ds) Then Destroy(ds)
	If IsValid(lvds) Then Destroy(lvds)
End Try
end function

public function boolean wf_atualiza_detalhe_divisao (string as_tipo);Decimal ldc_Custo

Long ll_Linha
Long ll_Find

String ls_Fornecedor
String ls_Razao_Social

Tab_1.TabPage_1.dw_1.AcceptText()
Tab_1.TabPage_1.dw_2.AcceptText()

If Not IsNull(Tab_1.TabPage_1.dw_1.Object.Nr_Divisao_Fornecedor[1]) And Tab_1.TabPage_1.dw_1.Object.Nr_Divisao_Fornecedor[1] > 0 Then
	For ll_Linha = 1 To ids.RowCount()		
		ls_Fornecedor		= ids.Object.Cd_Fornecedor		[ll_Linha]
		ls_Razao_Social	= ids.Object.Nm_Razao_Social	[ll_Linha]
				
		If as_Tipo = "FIL" Then
			Tab_1.TabPage_1.dw_2.InsertRow(0)
			
			ldc_Custo = ids.Object.Vl_Custo[ll_Linha]
			
			Tab_1.TabPage_1.dw_2.Object.Valor[Tab_1.TabPage_1.dw_2.RowCount()] = ldc_Custo
		Else
			ll_Find = Tab_1.TabPage_1.dw_2.Find("cd_fornecedor = '" + ls_Fornecedor + "'", 1, Tab_1.TabPage_1.dw_2.RowCount())
			
			If ll_Find < 0 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no find da dw_2.", StopSign!)
				Return False
			End If
			
			If ll_Find = 0 Then
				Tab_1.TabPage_1.dw_2.InsertRow(0)
				Tab_1.TabPage_1.dw_2.Object.Valor[Tab_1.TabPage_1.dw_2.RowCount()] = 0.00
			End If
			
			ldc_Custo = ids.Object.Vl_Custo[ll_Linha]
			
			Tab_1.TabPage_1.dw_2.Object.Valor_EC[Tab_1.TabPage_1.dw_2.RowCount()] = ldc_Custo
		End If
		
		Tab_1.TabPage_1.dw_2.Object.Cd_Fornecedor		[Tab_1.TabPage_1.dw_2.RowCount()] = ls_Fornecedor
		Tab_1.TabPage_1.dw_2.Object.Nm_Razao_Social		[Tab_1.TabPage_1.dw_2.RowCount()] = ls_Razao_Social
	Next
End If

Return True
end function

public subroutine wf_atualiza_desconto ();Long ll_Linha, ll_Linhas_Desc

String ls_Fornecedor

try
	dc_uo_ds_base lds 
	lds = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject("ds_ge174_desconto") Then Return
		
	For ll_Linha = 1 To Tab_1.TabPage_1.dw_2.RowCount()
		
		ls_Fornecedor = Tab_1.TabPage_1.dw_2.Object.cd_fornecedor[ll_Linha]
		
		Tab_1.TabPage_1.dw_2.Object.vl_bruto_fil			[ll_Linha] = 0.00
		Tab_1.TabPage_1.dw_2.Object.vl_bruto_ec			[ll_Linha] = 0.00
		Tab_1.TabPage_1.dw_2.Object.vl_desconto_fil		[ll_Linha] = 0.00
		Tab_1.TabPage_1.dw_2.Object.vl_desconto_ec	[ll_Linha] = 0.00
		Tab_1.TabPage_1.dw_2.Object.pc_desconto_fil	[ll_Linha]	 = 0.00
		
		If ls_Fornecedor = '053404705' Then
			ls_Fornecedor = '053404705'
		End If
		
		If Tab_1.TabPage_1.dw_2.Object.valor[ll_Linha] > 0 Then
			
			lds.of_restoresqloriginal()
			
			lds.of_AppendWhere("n.cd_filial <> 534")
			
			If Not IsNull(il_Divisao) and il_Divisao > 0 Then
				lds.of_AppendWhere("i.cd_produto in (select cd_produto from fornecedor_divisao_produto where cd_fornecedor = '" + ls_Fornecedor + "' and nr_divisao = " + String(il_Divisao) + ")")
			End If
						
			ll_Linhas_Desc = lds.Retrieve(idh_Inicio, idh_Termino, ls_Fornecedor)
			
			If  ll_Linhas_Desc > 0 Then
				Tab_1.TabPage_1.dw_2.Object.vl_bruto_fil			[ll_Linha] = lds.Object.vl_preco_bruto[1]
				Tab_1.TabPage_1.dw_2.Object.vl_desconto_fil		[ll_Linha] = lds.Object.vl_desconto	[1]
				
				If Tab_1.TabPage_1.dw_2.Object.vl_bruto_fil[ll_Linha] > 0 Then
					Tab_1.TabPage_1.dw_2.Object.pc_desconto_fil	[ll_Linha] = round(round((lds.Object.vl_desconto[1] / lds.Object.vl_preco_bruto[1]), 6) * 100, 2)
				End If
				
			ElseIf ll_Linhas_Desc < 0 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao recuperar o percentual de desconto para as notas das filiais.", StopSign!)
				Return
			End If	
		End If
		
		If Tab_1.TabPage_1.dw_2.Object.valor_ec[ll_Linha] > 0 Then
			lds.of_restoresqloriginal()
			
			lds.of_AppendWhere("n.cd_filial = 534")
			
			If Not IsNull(il_Divisao) and il_Divisao > 0 Then
				lds.of_AppendWhere("i.cd_produto in (select cd_produto from fornecedor_divisao_produto where cd_fornecedor = '" + ls_Fornecedor + "' and nr_divisao = " + String(il_Divisao) + ")")
			End If
			
			ll_Linhas_Desc = lds.Retrieve(idh_Inicio, idh_Termino, ls_Fornecedor)
			
			If  ll_Linhas_Desc > 0 Then
				Tab_1.TabPage_1.dw_2.Object.vl_bruto_ec			[ll_Linha] = lds.Object.vl_preco_bruto[1]
				Tab_1.TabPage_1.dw_2.Object.vl_desconto_ec	[ll_Linha] = lds.Object.vl_desconto	[1]
				
				If Tab_1.TabPage_1.dw_2.Object.vl_bruto_ec[ll_Linha] > 0 Then
					Tab_1.TabPage_1.dw_2.Object.pc_desconto_ec	[ll_Linha] = round(round((lds.Object.vl_desconto[1] / lds.Object.vl_preco_bruto[1]), 6) * 100, 2)
				End If
			ElseIf ll_Linhas_Desc < 0 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao recuperar o percentual de desconto para as notas das filiais.", StopSign!)
				Return
			End If	
		End If
		
	Next	
		
finally
	Destroy lds 
end try



end subroutine

public subroutine wf_atualiza_desconto_detalhe ();Long ll_Linha, ll_Linhas_Desc

String ls_Fornecedor, ls_fornecedor_usual

try
	Open(w_Aguarde)
	
	w_Aguarde.Title = "Atualizando os Descontos ..."
	
	dc_uo_ds_base lds 
	lds = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject("ds_ge174_desconto") Then Return
	
	ls_Fornecedor = Tab_1.TabPage_1.dw_2.Object.cd_fornecedor[Tab_1.TabPage_1.dw_2.GetRow()]
	
	w_aguarde.uo_progress.of_setmax(Tab_1.TabPage_2.dw_3.RowCount())
		
	For ll_Linha = 1 To Tab_1.TabPage_2.dw_3.RowCount()
		
		ls_fornecedor_usual = Tab_1.TabPage_2.dw_3.Object.cd_fornecedor_usual[ll_Linha]
				
		Tab_1.TabPage_2.dw_3.Object.vl_bruto_fil			[ll_Linha] = 0.00
		Tab_1.TabPage_2.dw_3.Object.vl_bruto_ec			[ll_Linha] = 0.00
		Tab_1.TabPage_2.dw_3.Object.vl_desconto_fil		[ll_Linha] = 0.00
		Tab_1.TabPage_2.dw_3.Object.vl_desconto_ec	[ll_Linha] = 0.00
		Tab_1.TabPage_2.dw_3.Object.pc_desconto_fil	[ll_Linha]	 = 0.00
		
		If ls_fornecedor_usual = '053405200' Then
			ls_fornecedor_usual = '053405200'
		End If
					
		If Tab_1.TabPage_2.dw_3.Object.vl_custo[ll_Linha] > 0 Then
			
			lds.of_restoresqloriginal()
			lds.of_AppendWhere("i.cd_produto in (select cd_produto from produto_geral where cd_fornecedor_usual = '" + ls_fornecedor_usual + "')")
			
			lds.of_AppendWhere("n.cd_filial <> 534")
			
			If Not IsNull(il_Divisao) and il_Divisao > 0 Then
				lds.of_AppendWhere("i.cd_produto in (select cd_produto from fornecedor_divisao_produto where cd_fornecedor = '" + ls_Fornecedor + "' and nr_divisao = " + String(il_Divisao) + ")")
			End If
						
			ll_Linhas_Desc = lds.Retrieve(idh_Inicio, idh_Termino, ls_Fornecedor)
			
			If  ll_Linhas_Desc > 0 Then
				Tab_1.TabPage_2.dw_3.Object.vl_bruto_fil			[ll_Linha] = lds.Object.vl_preco_bruto[1]
				Tab_1.TabPage_2.dw_3.Object.vl_desconto_fil		[ll_Linha] = lds.Object.vl_desconto	[1]
				
				If Tab_1.TabPage_2.dw_3.Object.vl_bruto_fil[ll_Linha] > 0 Then
					Tab_1.TabPage_2.dw_3.Object.pc_desconto_fil	[ll_Linha] = round(round((lds.Object.vl_desconto[1] / lds.Object.vl_preco_bruto[1]), 6) * 100, 2)
				End If
				
			ElseIf ll_Linhas_Desc < 0 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao recuperar o percentual de desconto para as notas das filiais.", StopSign!)
				Return
			End If	
		End If
		
		If Tab_1.TabPage_2.dw_3.Object.vl_custo_ec[ll_Linha] > 0 Then
			lds.of_restoresqloriginal()
			lds.of_AppendWhere("i.cd_produto in (select cd_produto from produto_geral where cd_fornecedor_usual = '" + ls_fornecedor_usual + "')")
			
			lds.of_AppendWhere("n.cd_filial = 534")
			
			If Not IsNull(il_Divisao) and il_Divisao > 0 Then
				lds.of_AppendWhere("i.cd_produto in (select cd_produto from fornecedor_divisao_produto where cd_fornecedor = '" + ls_Fornecedor + "' and nr_divisao = " + String(il_Divisao) + ")")
			End If
			
			ll_Linhas_Desc = lds.Retrieve(idh_Inicio, idh_Termino, ls_Fornecedor)
			
			If  ll_Linhas_Desc > 0 Then
				Tab_1.TabPage_2.dw_3.Object.vl_bruto_ec			[ll_Linha] = lds.Object.vl_preco_bruto[1]
				Tab_1.TabPage_2.dw_3.Object.vl_desconto_ec	[ll_Linha] = lds.Object.vl_desconto	[1]
				
				If Tab_1.TabPage_2.dw_3.Object.vl_bruto_ec[ll_Linha] > 0 Then
					Tab_1.TabPage_2.dw_3.Object.pc_desconto_ec	[ll_Linha] = round(round((lds.Object.vl_desconto[1] / lds.Object.vl_preco_bruto[1]), 6) * 100, 2)
				End If
			ElseIf ll_Linhas_Desc < 0 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao recuperar o percentual de desconto para as notas das filiais.", StopSign!)
				Return
			End If	
		End If
		
		w_aguarde.uo_progress.of_setprogress(ll_Linha)
	Next	
		
finally
	Destroy lds 
	Close(w_Aguarde)
end try



end subroutine

on w_ge174_compras_fornecedor.create
int iCurrent
call super::create
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
end on

on w_ge174_compras_fornecedor.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_1)
end on

event ue_postopen;call super::ue_postopen;Tab_1.TabPage_1.dw_1.Event ue_AddRow()
Tab_1.TabPage_1.dw_1.SetFocus()

Tab_1.TabPage_1.dw_1.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_1.dw_2.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_2.dw_3.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_3.dw_6.of_SetMenu(This.ivm_Menu)

Tab_1.TabPage_1.dw_1.ivo_Controle_Menu.of_Recuperar(True)
Tab_1.TabPage_1.dw_2.ivo_Controle_Menu.of_Recuperar(True)
Tab_1.TabPage_1.dw_2.ivo_Controle_Menu.of_Imprimir(True)
Tab_1.TabPage_2.dw_3.ivo_Controle_Menu.of_Imprimir(True)
Tab_1.TabPage_1.dw_2.ivo_Controle_Menu.of_SalvarComo(True)
Tab_1.TabPage_2.dw_3.ivo_Controle_Menu.of_SalvarComo(True)
Tab_1.TabPage_3.dw_6.ivo_Controle_Menu.of_SalvarComo(True)

This.ivm_Menu.ivb_Permite_Imprimir = True

Tab_1.TabPage_1.dw_1.Object.DT_Inicio [1] = Today()
Tab_1.TabPage_1.dw_1.Object.Dt_Termino[1] = Today()

gf_ge003_lista_divisao_fornecedor(Tab_1.TabPage_1.dw_1, "", 1)
end event

event close;call super::close;If IsValid(ivo_Fornecedor) Then Destroy(ivo_Fornecedor)
If IsValid(ids) Then Destroy(ids)
end event

event ue_preopen;call super::ue_preopen;ivo_Fornecedor = Create uo_Fornecedor
end event

type dw_visual from dc_w_sheet`dw_visual within w_ge174_compras_fornecedor
end type

type gb_aux_visual from dc_w_sheet`gb_aux_visual within w_ge174_compras_fornecedor
end type

type tab_1 from tab within w_ge174_compras_fornecedor
integer x = 18
integer y = 8
integer width = 4265
integer height = 1980
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long backcolor = 67108864
boolean raggedright = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
end on

event selectionchanging;//string lvs_teste
SetPointer(HourGlass!)
lvs_Dw_Almoxarifado  = False

If NewIndex = 1 Then
	Tab_1.TabPage_1.dw_1.ivo_Controle_Menu.of_Recuperar(True)
End If

If NewIndex = 2 and OldIndex = 1 Then
	If Tab_1.TabPage_1.dw_2.GetRow() > 0 Then
		// Executa o evento de recupera$$HEX2$$e700e300$$ENDHEX$$o das linhas
		// das DW's de detalhes
		If Tab_1.TabPage_1.dw_2.Object.cd_fornecedor[Tab_1.TabPage_1.dw_2.GetRow()] = '053404705' Then
			lvs_Dw_Almoxarifado = True
			Tab_1.TabPage_2.dw_3.DataObject = 'dw_ge174_detalhe_central'	
		Else
			Tab_1.TabPage_2.dw_3.DataObject = 'dw_ge174_detalhe'
		End If	

		Tab_1.TabPage_2.dw_3.SetTransObject(SQLCA)
		Tab_1.TabPage_2.dw_3.Event ue_Retrieve()

		// Permite a troca do folder
		Return 0
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma linha da lista para visualizar os detalhes.", StopSign!)
		// N$$HEX1$$e300$$ENDHEX$$o permite a troca do folder
		Return 1
	End If
End If		

If NewIndex = 3 Then
	If Tab_1.TabPage_2.dw_3.GetRow() > 0 Then
		// Executa o evento de recupera$$HEX2$$e700e300$$ENDHEX$$o das linhas
		// das DW's de detalhes
		If Tab_1.TabPage_1.dw_2.Object.cd_fornecedor[Tab_1.TabPage_1.dw_2.GetRow()] = '053404705' Then
			lvs_Dw_Almoxarifado = True
			Tab_1.TabPage_3.dw_6.DataObject = 'dw_ge174_produto_central'			
		else
			Tab_1.TabPage_3.dw_6.DataObject = 'dw_ge174_produto'
		End If
		Tab_1.TabPage_3.dw_6.SetTransObject(SQLCA)
		Tab_1.TabPage_3.dw_6.Event ue_Retrieve()

		// Permite a troca do folder
		Return 0
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um fornecedor para visualizar os produtos.", StopSign!)
		// N$$HEX1$$e300$$ENDHEX$$o permite a troca do folder
		Return 1
	End If
End If

SetPointer(Arrow!)
end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4229
integer height = 1864
long backcolor = 80269524
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_11 dw_11
dw_10 dw_10
cb_1 cb_1
dw_9 dw_9
dw_8 dw_8
gb_2 gb_2
gb_1 gb_1
dw_4 dw_4
dw_1 dw_1
dw_2 dw_2
end type

on tabpage_1.create
this.dw_11=create dw_11
this.dw_10=create dw_10
this.cb_1=create cb_1
this.dw_9=create dw_9
this.dw_8=create dw_8
this.gb_2=create gb_2
this.gb_1=create gb_1
this.dw_4=create dw_4
this.dw_1=create dw_1
this.dw_2=create dw_2
this.Control[]={this.dw_11,&
this.dw_10,&
this.cb_1,&
this.dw_9,&
this.dw_8,&
this.gb_2,&
this.gb_1,&
this.dw_4,&
this.dw_1,&
this.dw_2}
end on

on tabpage_1.destroy
destroy(this.dw_11)
destroy(this.dw_10)
destroy(this.cb_1)
destroy(this.dw_9)
destroy(this.dw_8)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.dw_4)
destroy(this.dw_1)
destroy(this.dw_2)
end on

type dw_11 from dc_uo_dw_base within tabpage_1
boolean visible = false
integer x = 2519
integer width = 197
integer height = 148
integer taborder = 30
string dataobject = "ds_ge174_detalhe_excel_comprador"
end type

type dw_10 from dc_uo_dw_base within tabpage_1
boolean visible = false
integer x = 2734
integer width = 197
integer height = 148
integer taborder = 50
boolean bringtotop = true
string dataobject = "ds_ge174_detalhe_excel_sumarizado"
end type

type cb_1 from commandbutton within tabpage_1
integer x = 2185
integer y = 420
integer width = 425
integer height = 112
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Gerar Planilha"
end type

event clicked;Long ll_Tipo

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a gera$$HEX2$$e700e300$$ENDHEX$$o do relat$$HEX1$$f300$$ENDHEX$$rio?", Question!, YesNo!, 2) = 2 Then
	Return -1
End If

Tab_1.TabPage_1.dw_1.AcceptText()

ll_Tipo = Tab_1.TabPage_1.dw_1.Object.Id_Tipo[1]

If ll_Tipo = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum tipo de planilha foi selecionado.", Exclamation!)
	Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "id_tipo")
	Return -1
End If

If Tab_1.TabPage_1.dw_1.Object.Dt_Inicio[1] > Tab_1.TabPage_1.dw_1.Object.Dt_Termino[1] Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a data de t$$HEX1$$e900$$ENDHEX$$rmino.", Exclamation!)
	Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "dt_inicio")
	Return -1
End If

If IsNull(Tab_1.TabPage_1.dw_1.Object.Dt_Inicio[1]) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lida.", Exclamation!)
	Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "dt_inicio")
	Return -1
End If

If IsNull(Tab_1.TabPage_1.dw_1.Object.Dt_Termino[1]) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de t$$HEX1$$e900$$ENDHEX$$rmino $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lida.", Exclamation!)
	Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "dt_termino")
	Return -1
End If

If Tab_1.TabPage_1.dw_1.Object.Dt_Termino[1] > Date(Today()) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de t$$HEX1$$e900$$ENDHEX$$rmino n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a data corrente.", Exclamation!)
	Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "dt_termino")
	Return -1	
End If

Choose Case ll_Tipo
		
	Case 1 //Por Fornecedor
		wf_Gera_Relatorio_Padrao(ll_Tipo, Tab_1.TabPage_1.dw_8, 'dw_ge174_detalhe_excel_new', 'dw_ge174_detalhe_excel_central_new')
		
	Case 2 //Por Fornecedor por M$$HEX1$$ea00$$ENDHEX$$s
		wf_Gera_Relatorio_Sumarizado(ll_Tipo, Tab_1.TabPage_1.dw_10, 'dw_ge174_detalhe_excel_sumarizado', 'dw_ge174_detalhe_excel_central_sumarizado')
		
	Case 3 //Por Comprador
		wf_Gera_Relatorio_Padrao(ll_Tipo, Tab_1.TabPage_1.dw_11, 'dw_ge174_detalhe_excel_comprador', 'dw_ge174_detalhe_excel_central_comprador')
		
	Case 4 //Por Comprador por M$$HEX1$$ea00$$ENDHEX$$s
		wf_Gera_Relatorio_Sumarizado(ll_Tipo, Tab_1.TabPage_1.dw_9, 'dw_ge174_detalhe_excel_comprador_sumarizado', 'dw_ge174_detalhe_excel_central_comprador_sumarizado')
	
End Choose
end event

type dw_9 from dc_uo_dw_base within tabpage_1
boolean visible = false
integer x = 3246
integer width = 197
integer height = 148
integer taborder = 40
string dataobject = "ds_ge174_detalhe_excel_comprador_sumarizado"
end type

type dw_8 from dc_uo_dw_base within tabpage_1
boolean visible = false
integer x = 2944
integer width = 197
integer height = 148
integer taborder = 30
string dataobject = "ds_ge174_detalhe_excel"
end type

type gb_2 from groupbox within tabpage_1
integer x = 14
integer y = 536
integer width = 4165
integer height = 1300
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
string text = "Lista"
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within tabpage_1
integer x = 14
integer y = 28
integer width = 2126
integer height = 504
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
borderstyle borderstyle = styleraised!
end type

type dw_4 from dc_uo_dw_base within tabpage_1
boolean visible = false
integer x = 3049
integer y = 192
integer width = 279
integer height = 172
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge174_relatorio"
boolean border = true
borderstyle borderstyle = styleraised!
end type

event ue_preprint;call super::ue_preprint;This.Object.Inicio.Text	= String(dw_1.Object.dt_inicio		[1], "dd/mm/yyyy")
This.Object.Fim.Text		= String(dw_1.Object.dt_Termino	[1], "dd/mm/yyyy")

Return AncestorReturnValue
end event

event ue_saveas;//override
This.Event ue_PrePrint()

SUPER::EVENT ue_SaveAs()
end event

type dw_1 from dc_uo_dw_base within tabpage_1
integer x = 41
integer y = 88
integer width = 2071
integer height = 416
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge174_selecao"
end type

event itemchanged;call super::itemchanged;Tab_1.TabPage_1.dw_2.Event ue_Reset()

Choose Case dwo.Name
	Case "nm_fornecedor"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Fornecedor.Nm_Razao_Social Then
				Return 1
			End If
		Else
			ivo_Fornecedor.of_Inicializa()
			
			This.Object.Cd_Fornecedor[1] = ivo_Fornecedor.Cd_Fornecedor
			This.Object.Nm_Fornecedor[1] = ivo_Fornecedor.Nm_Razao_Social
		End If
		
		gf_ge003_lista_divisao_fornecedor(Tab_1.TabPage_1.dw_1, ivo_Fornecedor.Cd_Fornecedor, 1)
		
	Case "id_tipo"
		
		If Data <> String(2) And Data <> String(4) Then
			dw_1.Object.Dt_Inicio.EditMask.Mask		= "dd/mm/yyyy"
			dw_1.Object.Dt_Termino.EditMask.Mask	= "dd/mm/yyyy"
		Else
			dw_1.Object.Dt_Inicio.EditMask.Mask		= "mm/yyyy"
			dw_1.Object.Dt_Termino.EditMask.Mask	= "mm/yyyy"
		End If
End Choose
end event

event losefocus;call super::losefocus;If IsValid(ivo_Fornecedor) Then
	This.Object.Cd_Fornecedor[1] = ivo_Fornecedor.Cd_Fornecedor
	This.Object.Nm_Fornecedor[1] = ivo_Fornecedor.Nm_Razao_Social
End If
end event

event ue_key;call super::ue_key;If Key = KeyEnter! Then
	If This.GetColumnName() = "nm_fornecedor" Then
		ivo_Fornecedor.of_Localiza_Fornecedor(This.GetText())
		
		If ivo_Fornecedor.Localizado Then
			This.Object.Cd_Fornecedor[1] = ivo_Fornecedor.Cd_Fornecedor
			This.Object.Nm_Fornecedor[1] = ivo_Fornecedor.Nm_Razao_Social
		End If
	End If
	
	gf_ge003_lista_divisao_fornecedor(Tab_1.TabPage_1.dw_1, ivo_Fornecedor.Cd_Fornecedor, 1)
End If
end event

event getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
end event

event constructor;call super::constructor;This.of_SetColSelection(True)
end event

event editchanged;call super::editchanged;Tab_1.TabPage_1.dw_2.Event ue_Reset()

Choose Case dwo.Name
	Case "nm_fornecedor"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Fornecedor.Nm_Razao_Social Then
				Return 1
			End If
		Else
			ivo_Fornecedor.of_Inicializa()
			
			This.Object.Cd_Fornecedor[1] = ivo_Fornecedor.Cd_Fornecedor
			This.Object.Nm_Fornecedor[1] = ivo_Fornecedor.Nm_Razao_Social
		End If
		
		gf_ge003_lista_divisao_fornecedor(Tab_1.TabPage_1.dw_1, ivo_Fornecedor.Cd_Fornecedor, 1)
End Choose
end event

type dw_2 from dc_uo_dw_base within tabpage_1
integer x = 46
integer y = 596
integer width = 4110
integer height = 1220
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge174_lista"
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event constructor;call super::constructor;String lvs_Coluna[], &
       lvs_Nome[]
		 
lvs_Coluna = {"nm_razao_social","valor","valor_ec","valor_total"}

lvs_Nome = {"Raz$$HEX1$$e300$$ENDHEX$$o Social", "Valor Filial","Valor Estoque Central", "Valor Total"}

This.of_SetSort(lvs_Coluna, lvs_Nome)
This.of_SetFilter(lvs_Coluna, lvs_Nome)

This.of_SetRowSelection()

If This.ShareData(Tab_1.TabPage_1.dw_4) = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no share data da dw_4.", StopSign!)
	Return -1
End If
end event

event ue_recuperar;//OverRide

Date lvdt_Inicio, &
     lvdt_Termino

Long ll_Divisao

String lvs_Fornecedor

Tab_1.TabPage_1.dw_1.AcceptText()
	  
lvs_Fornecedor = dw_1.Object.Cd_Fornecedor				[1]
lvdt_Inicio 		= dw_1.Object.Dt_Inicio						[1]
lvdt_Termino  	= dw_1.Object.Dt_Termino					[1]
ll_Divisao			= dw_1.Object.Nr_Divisao_Fornecedor	[1]

idh_Inicio 		= lvdt_Inicio
idh_Termino 	= lvdt_Termino
il_Divisao			= ll_Divisao

dw_2.Reset()

If Not IsNull(ll_Divisao) Or ll_Divisao > 0 Then
	If IsValid(ids) Then Destroy(ids)
	ids = Create dc_uo_ds_base
	
	If Not ids.of_ChangeDataObject("dw_ge174_detalhe_divisao") Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar o data store 'dw_ge174_detalhe_divisao'.", StopSign!)
		Return -1
	End If
	
	ids.of_appendwhere_subquery("i.cd_produto in (select cd_produto from fornecedor_divisao_produto where cd_fornecedor = '" + lvs_Fornecedor + "' and nr_divisao = " + String(ll_Divisao) + ")", 1)
	ids.of_appendwhere_subquery("i.cd_produto in (select cd_produto from fornecedor_divisao_produto where cd_fornecedor = '" + lvs_Fornecedor + "' and nr_divisao = " + String(ll_Divisao) + ")", 3)
	
	ids.of_appendwhere_subquery("n.cd_filial <> 534", 1)
	ids.of_appendwhere_subquery("n.cd_filial <> 534", 3)
	
	Return ids.Retrieve(lvdt_Inicio, lvdt_Termino, lvs_Fornecedor)
	
Else
	This.of_appendwhere_subquery("n.cd_fornecedor = '" + lvs_Fornecedor + "'", 1)
	This.of_appendwhere_subquery("n.cd_fornecedor = '" + lvs_Fornecedor + "'", 2)
	
	Return This.Retrieve(lvdt_Inicio, lvdt_Termino)
End If
end event

event ue_postretrieve;Boolean lvb_Classificar, &
        lvb_Filtrar


Open(w_Aguarde)

w_Aguarde.Title = "Atualizando os Descontos..."

If Not wf_Atualiza_Detalhe_Divisao('FIL') Then Return -1

If Not wf_Atualiza_Faturamento_EC() Then Return -1	

wf_atualiza_desconto()

Close(w_Aguarde)

If (pl_Linhas > 0) Or (This.RowCount() > 0) Then
	
	lvb_Classificar = IsValid(This.ivo_Sort)
	lvb_Filtrar     = IsValid(This.ivo_Filter)

	This.Sort()		
	This.GroupCalc()
	
	This.ScrollToRow(1)
	This.Event RowFocusChanged(1)
	This.SetRow(1)
	This.SetFocus()
Else
	If pl_Linhas = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.", Information!)
	End If
End If

This.ivo_Controle_Menu.of_Classificar(lvb_Classificar)
This.ivo_Controle_Menu.of_Filtrar(lvb_Filtrar)

This.ivm_menu.mf_SalvarComo(pl_linhas > 0)

Return pl_Linhas
end event

event getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
This.ivm_menu.mf_SalvarComo(This.RowCount()>0)
end event

event ue_printimmediate;// OverRide
dw_4.Event ue_PrintImmediate()
end event

event ue_reset;call super::ue_reset;This.ivm_menu.mf_SalvarComo(False)
end event

event losefocus;call super::losefocus;This.ivm_menu.mf_SalvarComo(False)
end event

event ue_print;// OverRide
dw_4.Event ue_Print()
end event

event ue_saveas;// OverRide
dw_4.Event ue_SaveAs()
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4229
integer height = 1864
long backcolor = 80269524
string text = "Detalhes"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
gb_3 gb_3
dw_3 dw_3
dw_5 dw_5
end type

on tabpage_2.create
this.gb_3=create gb_3
this.dw_3=create dw_3
this.dw_5=create dw_5
this.Control[]={this.gb_3,&
this.dw_3,&
this.dw_5}
end on

on tabpage_2.destroy
destroy(this.gb_3)
destroy(this.dw_3)
destroy(this.dw_5)
end on

type gb_3 from groupbox within tabpage_2
integer x = 14
integer y = 24
integer width = 4096
integer height = 1804
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
string text = "Fornecedores dos Produtos"
borderstyle borderstyle = styleraised!
end type

type dw_3 from dc_uo_dw_base within tabpage_2
integer x = 50
integer y = 80
integer width = 4032
integer height = 1724
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge174_detalhe"
boolean vscrollbar = true
end type

event ue_recuperar;//OverRide
Long ll_Divisao

Date	lvd_Inicio,&
		lvd_Termino

Integer lvi_Linha
	 
String lvs_Fornecedor,&
		lvs_Material_Expediente

Tab_1.TabPage_1.dw_1.AcceptText()
Tab_1.TabPage_1.dw_2.AcceptText()

lvi_Linha = Tab_1.TabPage_1.dw_2.GetRow()

lvd_Inicio  	= Tab_1.TabPage_1.dw_1.Object.dt_inicio 		[1]
lvd_Termino	= Tab_1.TabPage_1.dw_1.Object.dt_termino	[1]
lvs_Fornecedor =  Tab_1.TabPage_1.dw_2.Object.cd_fornecedor[lvi_Linha]
lvs_Material_Expediente  =  Tab_1.TabPage_1.dw_1.Object.id_material_exped [1]
ll_Divisao = Tab_1.TabPage_1.dw_1.Object.Nr_Divisao_Fornecedor[1]
						
If lvs_Dw_Almoxarifado  Then 
	If lvs_Material_Expediente  = "N"  Then 
		this.of_appendwhere("n.id_almoxarifado  ='N' ")
	End If 
End If

If lvs_Fornecedor <> "053404705" Then
	If Not IsNull(ll_Divisao) And ll_Divisao > 0 Then
		This.of_appendwhere_subquery("i.cd_produto in (select cd_produto from fornecedor_divisao_produto where cd_fornecedor = '" + lvs_Fornecedor + "' and nr_divisao = " + String(ll_Divisao) + ")", 1)
		This.of_appendwhere_subquery("i.cd_produto in (select cd_produto from fornecedor_divisao_produto where cd_fornecedor = '" + lvs_Fornecedor + "' and nr_divisao = " + String(ll_Divisao) + ")", 3)
	End If
End If

Return This.Retrieve(lvd_Inicio, lvd_Termino, lvs_Fornecedor)
end event

event getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
This.ivm_menu.mf_SalvarComo(This.RowCount()>0)
end event

event constructor;call super::constructor;String lvs_Coluna[], &
       lvs_Nome[]
		 
lvs_Coluna = {"nm_razao_social","vl_custo","vl_custo_ec","valor_total"}

lvs_Nome = {"Raz$$HEX1$$e300$$ENDHEX$$o Social", "Valor Filial","Valor Estoque Central", "Valor Total"}

This.of_SetSort(lvs_Coluna, lvs_Nome)
This.of_SetFilter(lvs_Coluna, lvs_Nome)		

This.of_SetRowSelection()

If This.ShareData(Tab_1.TabPage_2.dw_5) = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no share data da dw_5.", StopSign!)
	Return -1
End If
end event

event ue_printimmediate;// OverRide
Parent.dw_5.Event ue_PrintImmediate()
end event

event ue_postretrieve;Boolean lvb_Classificar, &
        lvb_Filtrar

Decimal lvdc_Percentual

Long lvl_Linha_Ativa,&
	 lvl_Linha	
	 
String lvs_Fornecedor,&
	   lvs_Razao_Social
	   
If Not wf_Atualiza_Faturamento_Detalhe_EC() Then Return -1

If This.RowCount() > 0 Then
	
	// O percentual de desconto do EC ser$$HEX1$$e100$$ENDHEX$$ sempre zerado
	If Tab_1.TabPage_1.dw_2.Object.cd_fornecedor[Tab_1.TabPage_1.dw_2.GetRow()] <> '053404705' Then
		wf_atualiza_desconto_detalhe()
	End If
	
	lvb_Classificar	= IsValid(This.ivo_Sort)
	lvb_Filtrar		= IsValid(This.ivo_Filter)
	
	This.Sort()	
	This.GroupCalc()

	Tab_1.Tabpage_1.dw_2.AcceptText()
	
   lvl_Linha_Ativa  = Tab_1.TabPage_1.dw_2.GetRow()
	lvs_Razao_Social	= Tab_1.Tabpage_1.dw_2.Object.nm_razao_social	[lvl_Linha_Ativa] 
	lvs_Fornecedor		= Tab_1.Tabpage_1.dw_2.Object.cd_fornecedor		[lvl_Linha_Ativa] 
	
	This.Object.st_Fornecedor.text = lvs_Razao_Social + " (" + lvs_Fornecedor + ")" 
	This.of_SetRowSelection()
End If

If This.ShareData(Parent.dw_5) = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no share data da dw_5.", StopSign!)
	Return -1
End If

This.ivo_Controle_Menu.of_Classificar(lvb_Classificar)
This.ivo_Controle_Menu.of_Filtrar(lvb_Filtrar)
This.ivm_menu.mf_SalvarComo(pl_linhas > 0)

Return pl_Linhas
end event

event losefocus;call super::losefocus;This.ivm_menu.mf_SalvarComo(False)
end event

event ue_reset;call super::ue_reset;This.ivm_menu.mf_SalvarComo(False)
end event

event ue_saveas;//override
dw_5.Event ue_SaveAs()
end event

event ue_print;//override
Parent.dw_5.Event ue_Print()
end event

type dw_5 from dc_uo_dw_base within tabpage_2
boolean visible = false
integer x = 1797
integer y = 760
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge174_detalhe_relatorio"
boolean border = true
borderstyle borderstyle = styleraised!
end type

event ue_preprint;call super::ue_preprint;String lvs_Fornecedor,&
	   lvs_Razao_Social
	   
Long lvl_Linha_Ativa

Tab_1.Tabpage_1.dw_2.AcceptText()
	
lvl_Linha_Ativa		= Tab_1.TabPage_1.dw_2.GetRow()
lvs_Razao_Social	= Tab_1.Tabpage_1.dw_2.Object.nm_razao_social	[lvl_Linha_Ativa] 
lvs_Fornecedor		= Tab_1.Tabpage_1.dw_2.Object.cd_fornecedor		[lvl_Linha_Ativa] 

This.Object.Inicio.Text 	   		= String(Tab_1.TabPage_1.dw_1.Object.dt_inicio[1], "dd/mm/yyyy")
This.Object.Fim.Text           	= String(Tab_1.TabPage_1.dw_1.Object.dt_Termino[1], "dd/mm/yyyy")
This.Object.st_Fornecedor.text = lvs_Razao_Social + " (" + lvs_Fornecedor + ")" 

Return AncestorReturnValue
end event

event ue_saveas;//override
This.Event ue_PrePrint()

SUPER::EVENT ue_SaveAs()
end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 4229
integer height = 1864
long backcolor = 80269524
string text = "Produtos"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
gb_4 gb_4
dw_6 dw_6
dw_7 dw_7
end type

on tabpage_3.create
this.gb_4=create gb_4
this.dw_6=create dw_6
this.dw_7=create dw_7
this.Control[]={this.gb_4,&
this.dw_6,&
this.dw_7}
end on

on tabpage_3.destroy
destroy(this.gb_4)
destroy(this.dw_6)
destroy(this.dw_7)
end on

type gb_4 from groupbox within tabpage_3
integer x = 14
integer y = 24
integer width = 2761
integer height = 1808
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
string text = "Lista"
borderstyle borderstyle = styleraised!
end type

type dw_6 from dc_uo_dw_base within tabpage_3
integer x = 55
integer y = 84
integer width = 2693
integer height = 1720
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge174_produto"
boolean vscrollbar = true
end type

event ue_recuperar;// OverRide

Date	lvdt_Inicio,&
		lvdt_Termino

String	lvs_Fornecedor, &
		lvs_Fornecedor_Usual,&
		lvs_Material_Expediente
	   
Long	lvl_Linha1,&
		lvl_Linha2, &
		ll_Divisao
	   
Tab_1.TabPage_1.dw_1.AcceptText()
Tab_1.TabPage_1.dw_2.AcceptText()
Tab_1.TabPage_2.dw_3.AcceptText()

lvl_Linha1 = Tab_1.TabPage_1.dw_2.GetRow()
lvl_Linha2 = Tab_1.TabPage_2.dw_3.GetRow()

lvdt_Inicio		= Tab_1.TabPage_1.dw_1.Object.dt_inicio 		[1]
lvdt_Termino	= Tab_1.TabPage_1.dw_1.Object.dt_termino	[1]
lvs_Material_Expediente  =  Tab_1.TabPage_1.dw_1.Object.id_material_exped [1]

lvs_Fornecedor			= Tab_1.TabPage_1.dw_2.Object.cd_fornecedor      		[lvl_Linha1]
lvs_Fornecedor_Usual	= Tab_1.TabPage_2.dw_3.Object.cd_fornecedor_usual	[lvl_Linha2]
ll_Divisao					= Tab_1.TabPage_1.dw_1.Object.Nr_Divisao_Fornecedor[1]

If lvs_Dw_Almoxarifado Then 
	If lvs_Material_Expediente = "N"  Then 
		this.of_appendwhere("n.id_almoxarifado = 'N'")
	End If
End If

If Not IsNull(ll_Divisao) And ll_Divisao > 0 Then
	This.of_appendwhere_subquery("i.cd_produto in (select cd_produto from fornecedor_divisao_produto where cd_fornecedor = '" + lvs_Fornecedor + "' and nr_divisao = " + String(ll_Divisao) + ")", 1)
	This.of_appendwhere_subquery("i.cd_produto in (select cd_produto from fornecedor_divisao_produto where cd_fornecedor = '" + lvs_Fornecedor + "' and nr_divisao = " + String(ll_Divisao) + ")", 3)
	This.of_appendwhere_subquery("i.cd_produto in (select cd_produto from fornecedor_divisao_produto where cd_fornecedor = '" + lvs_Fornecedor + "' and nr_divisao = " + String(ll_Divisao) + ")", 5)
End If

Return This.Retrieve(lvdt_Inicio, lvdt_Termino, lvs_Fornecedor_Usual, lvs_Fornecedor)
end event

event constructor;call super::constructor;This.of_SetRowSelection()
end event

event ue_printimmediate;// OverRide
Parent.dw_7.Event ue_PrintImmediate()
end event

event getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
This.ivm_menu.mf_SalvarComo(This.RowCount() > 0)
end event

event ue_postretrieve;call super::ue_postretrieve;This.ivm_menu.mf_SalvarComo(pl_linhas > 0)

This.RowsCopy(1,This.RowCount(), Primary!, dw_7, 1, Primary!)
This.Of_SetRowSelection()

Return AncestorReturnValue
end event

event losefocus;call super::losefocus;This.ivm_menu.mf_SalvarComo(False)
end event

event ue_print;// OverRide
Parent.dw_7.Event ue_Print()
end event

event ue_saveas;// OverRide
Parent.dw_7.Event ue_SaveAs()
end event

event ue_reset;call super::ue_reset;This.ivm_menu.mf_SalvarComo(False)
end event

type dw_7 from dc_uo_dw_base within tabpage_3
boolean visible = false
integer x = 1143
integer y = 104
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge174_produto_relatorio"
boolean border = true
borderstyle borderstyle = styleraised!
end type

event ue_preprint;call super::ue_preprint;Parent.dw_7.Object.Inicio.Text	= String(Tab_1.TabPage_1.dw_1.Object.dt_inicio 		[1], "dd/mm/yyyy")
Parent.dw_7.Object.Fim.Text	= String(Tab_1.TabPage_1.dw_1.Object.dt_Termino	[1], "dd/mm/yyyy")

Return AncestorReturnValue
end event

event ue_saveas;//override
This.Event ue_PrePrint()

SUPER::EVENT ue_SaveAs()
end event

