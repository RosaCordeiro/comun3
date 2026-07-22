HA$PBExportHeader$w_ge257_gera_planilha_almoxarifado.srw
forward
global type w_ge257_gera_planilha_almoxarifado from dc_w_sheet
end type
type gb_1 from groupbox within w_ge257_gera_planilha_almoxarifado
end type
type dw_1 from dc_uo_dw_base within w_ge257_gera_planilha_almoxarifado
end type
type cb_gerar from commandbutton within w_ge257_gera_planilha_almoxarifado
end type
type cb_cancelar from commandbutton within w_ge257_gera_planilha_almoxarifado
end type
end forward

global type w_ge257_gera_planilha_almoxarifado from dc_w_sheet
string tag = "w_ge257_gera_planilha_almoxarifado"
integer width = 965
integer height = 516
string title = "GE257 - Gera$$HEX2$$e700e300$$ENDHEX$$o Planilhas Impressos"
long backcolor = 80269524
gb_1 gb_1
dw_1 dw_1
cb_gerar cb_gerar
cb_cancelar cb_cancelar
end type
global w_ge257_gera_planilha_almoxarifado w_ge257_gera_planilha_almoxarifado

type variables
transaction impressos
end variables

forward prototypes
public function boolean wf_gera_planilha ()
public function boolean wf_verifica_valor (string as_tipo, datastore ads, long al_centro_custo, ref decimal adc_valor, integer ai_grp)
public subroutine wf_salvar (datastore ads)
public function boolean wf_gera_arquivo ()
end prototypes

public function boolean wf_gera_planilha ();Boolean lvb_Sucesso = True

String lvs_DW,&
	   lvs_Tipo,&
	   lvs_Dep_Nome

Long lvl_Mes,&
	 lvl_Ano,&
	 lvl_Linha,&
	 lvl_Linhas,&
	 lvl_Centro_Custo,&
	 lvl_Find,&
	 lvl_Linha_Excel,&
	 lvl_Insert
	 
Decimal{2} lvdc_Valor
	 
dw_1.AcceptText()

dc_uo_ds_base lvds
dc_uo_ds_base lvds_Depto
dc_uo_ds_base lvds_Filial
dc_uo_ds_base lvds_Excel

lvds 		= Create dc_uo_ds_base
lvds_Depto 	= Create dc_uo_ds_base
lvds_Filial = Create dc_uo_ds_base
lvds_Excel	= Create dc_uo_ds_base

lvds.DataObject 		= "ds_ge257_centro_custo"
lvds_Depto.DataObject 	= "ds_ge257_depto"
lvds_Filial.DataObject  = "ds_ge257_filial"
lvds_Excel.DataObject	= "ds_ge257_excel"

lvds.SetTransObject(Impressos)
lvds_Depto.SetTransObject(Impressos)
lvds_Filial.SetTransObject(Impressos)

lvl_Mes = Month(dw_1.Object.dh_mes_ano[1])
lvl_Ano = Year(dw_1.Object.dh_mes_ano [1])

Open(w_Aguarde)

w_Aguarde.Title = "Gerando o relat$$HEX1$$f300$$ENDHEX$$rio ..."

SetPointer(HourGlass!)

If lvds.Retrieve(lvl_Ano, lvl_Mes) = -1 Then 
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao recuperar as informa$$HEX2$$e700f500$$ENDHEX$$es da DataWindow.")
	Return False
End If

If lvds_Filial.Retrieve(lvl_Ano, lvl_Mes) = -1 Then 
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao recuperar as informa$$HEX2$$e700f500$$ENDHEX$$es da DataWindow.")
	Return False
End If

If lvds_Depto.Retrieve(lvl_Ano, lvl_Mes) = -1 Then 
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao recuperar as informa$$HEX2$$e700f500$$ENDHEX$$es da DataWindow.")
	Return False
End If

lvl_Linhas = lvds.RowCount()

If  lvl_Linhas > 0 Then
				
	w_Aguarde.uo_Progress.of_SetMax(lvl_Linhas)
		
	For lvl_Linha = 1 To lvl_Linhas
		
		w_Aguarde.uo_Progress.of_SetProgress(lvl_Linha)
		
		lvl_Centro_Custo	= lvds.Object.cd_centro_custo	[lvl_Linha]
		lvs_Tipo		 		= lvds.Object.id_tipo		  		[lvl_Linha]
		lvs_Dep_Nome		= lvds.Object.tabdep_dep_nom	[lvl_Linha]
		
		lvl_Find = lvds_Excel.Find("cd_centro_custo = " + String(lvl_Centro_Custo), 1, lvds_Excel.RowCount())
		
		If lvl_Find = -1 Then
			Exit
		End If
		
		If lvl_Find = 0 Then
			lvl_Insert = lvds_Excel.InsertRow(0)
			
			lvds_Excel.Object.cd_centro_custo	[lvl_Insert]	= lvl_Centro_Custo
			lvds_Excel.Object.dep_nome		[lvl_Insert]	= lvs_Dep_Nome
			lvl_Linha_Excel 										 	= lvl_Insert
		Else
			lvds_Excel.Object.cd_centro_custo	[lvl_Linha]	= lvl_Centro_Custo
			lvds_Excel.Object.dep_nome		[lvl_Linha]	= lvs_Dep_Nome
			lvl_Linha_Excel										 	= lvl_Linha
		End If
				
		If lvs_Tipo = "1" Then
			
			// Material de embalagem
			If Not wf_Verifica_Valor(lvs_Tipo, lvds_Depto, lvl_Centro_Custo, Ref lvdc_Valor, 1) Then Exit
									
			lvds_Excel.Object.material_embalagem[lvl_Linha_Excel] = lvdc_Valor
				
			
			// Material de expediente
			If Not wf_Verifica_Valor(lvs_Tipo, lvds_Depto, lvl_Centro_Custo, Ref lvdc_Valor, 2) Then Exit
									
			lvds_Excel.Object.material_expediente[lvl_Linha_Excel] = lvdc_Valor
			
			
			// Material de limpeza
			If Not wf_Verifica_Valor(lvs_Tipo, lvds_Depto, lvl_Centro_Custo, Ref lvdc_Valor, 3) Then Exit
									
			lvds_Excel.Object.material_limpeza[lvl_Linha_Excel] = lvdc_Valor
				
			
			// Uniformes
			If Not wf_Verifica_Valor(lvs_Tipo, lvds_Depto, lvl_Centro_Custo, Ref lvdc_Valor, 4) Then Exit
									
			lvds_Excel.Object.uniformes[lvl_Linha_Excel] = lvdc_Valor
			
			
			// Caf$$HEX1$$e900$$ENDHEX$$
			If Not wf_Verifica_Valor(lvs_Tipo, lvds_Depto, lvl_Centro_Custo, Ref lvdc_Valor, 5) Then Exit
									
			lvds_Excel.Object.cafe[lvl_Linha_Excel] = lvdc_Valor
			
			
			// Material Clube
			If Not wf_Verifica_Valor(lvs_Tipo, lvds_Depto, lvl_Centro_Custo, Ref lvdc_Valor, 8) Then Exit
									
			lvds_Excel.Object.material_clube[lvl_Linha_Excel] = lvdc_Valor
						
		Else
			
			// Material de embalagem
			If Not wf_Verifica_Valor(lvs_Tipo, lvds_Filial, lvl_Centro_Custo, Ref lvdc_Valor, 1) Then Exit
									
			lvds_Excel.Object.material_embalagem[lvl_Linha_Excel] = lvdc_Valor
				
			
			// Material de expediente
			If Not wf_Verifica_Valor(lvs_Tipo, lvds_Filial, lvl_Centro_Custo, Ref lvdc_Valor, 2) Then Exit
									
			lvds_Excel.Object.material_expediente[lvl_Linha_Excel] = lvdc_Valor
			
			
			// Material de limpeza
			If Not wf_Verifica_Valor(lvs_Tipo, lvds_Filial, lvl_Centro_Custo, Ref lvdc_Valor, 3) Then Exit
									
			lvds_Excel.Object.material_limpeza[lvl_Linha_Excel] = lvdc_Valor
				
			
			// Uniformes
			If Not wf_Verifica_Valor(lvs_Tipo, lvds_Filial, lvl_Centro_Custo, Ref lvdc_Valor, 4) Then Exit
									
			lvds_Excel.Object.uniformes[lvl_Linha_Excel] = lvdc_Valor
			
			
			// Caf$$HEX1$$e900$$ENDHEX$$
			If Not wf_Verifica_Valor(lvs_Tipo, lvds_Filial, lvl_Centro_Custo, Ref lvdc_Valor, 5) Then Exit
									
			lvds_Excel.Object.cafe[lvl_Linha_Excel] = lvdc_Valor
			
			
			// Material Clube
			If Not wf_Verifica_Valor(lvs_Tipo, lvds_Filial, lvl_Centro_Custo, Ref lvdc_Valor, 8) Then Exit
									
			lvds_Excel.Object.material_clube[lvl_Linha_Excel] = lvdc_Valor
			
		End If
		
	Next
	
	wf_Salvar(lvds_Excel)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.")
End If

Close(w_Aguarde)
	
SetPointer(Arrow!)

Destroy(lvds)
Destroy(lvds_Depto)
Destroy(lvds_Filial)
Destroy(lvds_Excel)

Return True
end function

public function boolean wf_verifica_valor (string as_tipo, datastore ads, long al_centro_custo, ref decimal adc_valor, integer ai_grp);Long lvl_Find

If as_Tipo = "1" Then
	lvl_Find = ads.Find("dep_cod = " + String(al_Centro_Custo) + " and grp_cod = " + String(ai_grp), 1, ads.RowCount()) 
Else
	lvl_Find = ads.Find("fil_cod = " + String(al_Centro_Custo) + " and grp_cod = " + String(ai_grp), 1, ads.RowCount())
End If
			
If lvl_Find = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o valor do depto.")
	Return False
End If

If lvl_Find = 0 Then
	adc_Valor = 0
Else
	adc_valor = ads.Object.Valor[lvl_Find]
End If

Return True
end function

public subroutine wf_salvar (datastore ads);Integer lvi_Retorno

String	lvs_Path		,&
		lvs_Arquivo

If ads.RowCount() > 0 Then
	lvi_retorno = GetFileSaveName('Arquivo', lvs_Path, lvs_Arquivo, 'xls', 'Planilha Excel (*.xls),*.xls')
	
	If lvi_retorno = 1 Then
		
		If ads.SaveAs(lvs_Path, Excel!, True) = 1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O arquivo foi salvo com sucesso '" + lvs_Path + "'.")
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gerar o arquivo '" + lvs_Path + "'.", StopSign!)
		End If
	End If
End If
end subroutine

public function boolean wf_gera_arquivo ();Boolean lvb_Sucesso = True

String	lvs_Cd_SubGrupo, &
		lvs_Departamento

Long	lvl_Cd_Centro_Custo , &  
		lvl_Linha			, &
		lvl_Linhas		, &
		lvl_Linha_Excel	, &
		lvl_Find			, &
		lvl_Insert

Date lvdt_Inicio
Date lvdt_Fim

Double lvd_Valor
	 
dw_1.AcceptText()

SetPointer(HourGlass!)

dc_uo_ds_base lvds

dc_uo_ds_base lvds_Excel

lvds 		   = Create dc_uo_ds_base
lvds_Excel	= Create dc_uo_ds_base

lvds.of_ChangeDataObject        ("ds_ge257_lista")  
lvds_Excel.of_ChangeDataObject  ("ds_ge257_excel")

// N$$HEX1$$e300$$ENDHEX$$o vai considerar os tonners
lvds.of_AppendWhere("pg.cd_subcategoria <> '503004008'", 1)

lvdt_Inicio	= gf_primeiro_dia_mes(dw_1.Object.dh_mes_ano[1])
lvdt_Fim		= gf_retorna_ultimo_dia_mes(dw_1.Object.dh_mes_ano[1])

If lvds.Retrieve(lvdt_Inicio, lvdt_Fim) = -1 Then 
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao recuperar as informa$$HEX2$$e700f500$$ENDHEX$$es da DataWindow.")
	Return False
End If

Open(w_Aguarde)

w_Aguarde.Title = "Gerando o relat$$HEX1$$f300$$ENDHEX$$rio ..."

SetPointer(HourGlass!)

lvl_Linhas = lvds.RowCount()

If  lvl_Linhas > 0 Then
				
	w_Aguarde.uo_Progress.of_SetMax(lvl_Linhas)
		
	For lvl_Linha = 1 To lvl_Linhas
		
		w_Aguarde.uo_Progress.of_SetProgress(lvl_Linha)
		
		lvl_Cd_Centro_Custo	= lvds.Object.centro_custo	[lvl_Linha]
		lvs_Cd_SubGrupo		= lvds.Object.cd_subgrupo	[lvl_Linha]
		lvs_Departamento		= lvds.Object.departamento	[lvl_Linha]
		lvd_Valor            		= lvds.Object.valor			[lvl_Linha]
		
		lvl_Find = lvds_Excel.Find("centro_custo = " + String(lvl_Cd_Centro_Custo), 1, lvds_Excel.RowCount())	
		
		If lvl_Find = -1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar 'find' o centro de custo.", StopSign!)
			lvb_Sucesso = False
			Exit
		End If
		
		If lvl_Find = 0 Then
			lvl_Insert = lvds_Excel.InsertRow(0)
			
			lvds_Excel.Object.centro_custo		[lvl_Insert]	= lvl_Cd_Centro_Custo
			lvds_Excel.Object.departamento	[lvl_Insert]	= lvs_Departamento	
			lvl_Linha_Excel 											= lvl_Insert
			lvds_Excel.Sort( )
		Else
			lvds_Excel.Object.centro_custo		[lvl_Find]	= lvl_Cd_Centro_Custo
			lvds_Excel.Object.departamento	[lvl_Find]	= lvs_Departamento	
			lvl_Linha_Excel							   			= lvl_Find
		End If  		
		
		Choose Case lvs_Cd_SubGrupo 
			Case '502'  //Cafe
				lvds_Excel.Object.cafe			[lvl_Linha_Excel] = lvds_Excel.Object.cafe			[lvl_Linha_Excel] + lvd_Valor	
			Case '503'  //Expediente
				lvds_Excel.Object.expediente	[lvl_Linha_Excel] = lvds_Excel.Object.expediente	[lvl_Linha_Excel] + lvd_Valor
			Case '504'  //Limpeza
				lvds_Excel.Object.limpeza		[lvl_Linha_Excel] = lvds_Excel.Object.limpeza		[lvl_Linha_Excel] + lvd_Valor
			Case '505'  //Uniforme
				lvds_Excel.Object.uniformes		[lvl_Linha_Excel] = lvds_Excel.Object.uniformes	[lvl_Linha_Excel] + lvd_Valor
			Case '506'  //Embalagem
				lvds_Excel.Object.embalagem	[lvl_Linha_Excel] = lvds_Excel.Object.embalagem	[lvl_Linha_Excel] + lvd_Valor
			Case '507'  //Club
				lvds_Excel.Object.clube			[lvl_Linha_Excel] = lvds_Excel.Object.clube			[lvl_Linha_Excel] + lvd_Valor
			Case '508'  //bens de custo baixo
				lvds_Excel.Object.bens_baixo_custo[lvl_Linha_Excel] = lvds_Excel.Object.bens_baixo_custo[lvl_Linha_Excel] 		+ lvd_Valor
			Case Else   //Outros que estiverem  no sql mas n$$HEX1$$e300$$ENDHEX$$o estiverem no case
				lvds_Excel.Object.outros			[lvl_Linha_Excel] = lvds_Excel.Object.outros			[lvl_Linha_Excel] + lvd_Valor
		End Choose			
		
	Next
	
	// In$$HEX1$$ed00$$ENDHEX$$cio - Tonner 
	dc_uo_ds_base lds_Tonner
	lds_Tonner = Create dc_uo_ds_base
	lds_Tonner.of_ChangeDataObject("ds_ge257_lista")  

	// Somente tonners
	lds_Tonner.of_AppendWhere("pg.cd_subcategoria = '503004008'", 1)

	If lds_Tonner.Retrieve(lvdt_Inicio, lvdt_Fim) = -1 Then 
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao recuperar as informa$$HEX2$$e700f500$$ENDHEX$$es da DataWindow.")
		Return False
	End If
	
	lvl_Linhas = lds_Tonner.RowCount()
	
	For lvl_Linha = 1 To lvl_Linhas
		
		lvl_Cd_Centro_Custo	= lds_Tonner.Object.centro_custo 	[lvl_Linha]
		lvs_Cd_SubGrupo	 	= lds_Tonner.Object.cd_subgrupo		[lvl_Linha]
		lvs_Departamento	   	= lds_Tonner.Object.departamento	[lvl_Linha]
		lvd_Valor            		= lds_Tonner.Object.valor        		[lvl_Linha]
		
		lvl_Find = lvds_Excel.Find("centro_custo = " + String(lvl_Cd_Centro_Custo), 1, lvds_Excel.RowCount())	
		
		If lvl_Find = -1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar 'find' o centro de custo.", StopSign!)
			lvb_Sucesso = False
			Exit
		End If
		
		If lvl_Find = 0 Then
			lvl_Insert = lvds_Excel.InsertRow(0)
			
			lvds_Excel.Object.centro_custo 	[lvl_Insert] = lvl_Cd_Centro_Custo
			lvds_Excel.Object.departamento 	[lvl_Insert] = lvs_Departamento	
			lvl_Linha_Excel 							= lvl_Insert
		Else
			lvds_Excel.Object.centro_custo 	[lvl_Find]  = lvl_Cd_Centro_Custo
			lvds_Excel.Object.departamento 	[lvl_Find]  = lvs_Departamento	
			lvl_Linha_Excel						   	= lvl_Find
		End If  	
		
		lvds_Excel.Object.tonner_imp[lvl_Linha_Excel] = lvds_Excel.Object.tonner_imp[lvl_Linha_Excel] + lvd_Valor
		
	Next
	
	Destroy(lds_Tonner)
		
	// T$$HEX1$$e900$$ENDHEX$$rmino - Tonner
	
	SetPointer(Arrow!)
	
	If lvb_Sucesso Then
		wf_Salvar(lvds_Excel)
	End IF
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.")
End If  

Close(w_Aguarde)
	
SetPointer(Arrow!)

Destroy(lvds)
Destroy(lvds_Excel)

Return True
end function

on w_ge257_gera_planilha_almoxarifado.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.dw_1=create dw_1
this.cb_gerar=create cb_gerar
this.cb_cancelar=create cb_cancelar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.cb_gerar
this.Control[iCurrent+4]=this.cb_cancelar
end on

on w_ge257_gera_planilha_almoxarifado.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.cb_gerar)
destroy(this.cb_cancelar)
end on

event ue_postopen;call super::ue_postopen;dw_1.Event ue_AddRow()

dw_1.SetFocus()

dw_1.Object.dh_mes_ano[1] = Date(gvo_Parametro.of_DH_Movimentacao())
end event

event close;call super::close;Destroy(Impressos)
end event

type dw_visual from dc_w_sheet`dw_visual within w_ge257_gera_planilha_almoxarifado
end type

type gb_aux_visual from dc_w_sheet`gb_aux_visual within w_ge257_gera_planilha_almoxarifado
end type

type gb_1 from groupbox within w_ge257_gera_planilha_almoxarifado
integer x = 23
integer y = 8
integer width = 859
integer height = 176
integer taborder = 10
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

type dw_1 from dc_uo_dw_base within w_ge257_gera_planilha_almoxarifado
integer x = 41
integer y = 64
integer width = 613
integer height = 100
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge257_selecao"
end type

event constructor;call super::constructor;This.of_SetColSelection(True)
end event

type cb_gerar from commandbutton within w_ge257_gera_planilha_almoxarifado
integer x = 23
integer y = 208
integer width = 462
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Gerar Planilha"
end type

event clicked;wf_Gera_Arquivo()

end event

type cb_cancelar from commandbutton within w_ge257_gera_planilha_almoxarifado
integer x = 530
integer y = 208
integer width = 352
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Cancelar"
end type

event clicked;Close(Parent)
end event

