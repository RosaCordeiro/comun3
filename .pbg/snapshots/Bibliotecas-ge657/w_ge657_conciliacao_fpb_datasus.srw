HA$PBExportHeader$w_ge657_conciliacao_fpb_datasus.srw
forward
global type w_ge657_conciliacao_fpb_datasus from dc_w_2tab_consulta_selecao_lista_det
end type
type tabpage_3 from userobject within tab_1
end type
type gb_4 from groupbox within tabpage_3
end type
type dw_4 from dc_uo_dw_base within tabpage_3
end type
type tabpage_3 from userobject within tab_1
gb_4 gb_4
dw_4 dw_4
end type
end forward

global type w_ge657_conciliacao_fpb_datasus from dc_w_2tab_consulta_selecao_lista_det
string tag = "w_ge657_conciliacao_fpb_datasus"
integer width = 5883
integer height = 2680
string title = "GE657 - Concilia$$HEX2$$e700e300$$ENDHEX$$o FPB - Datasus"
end type
global w_ge657_conciliacao_fpb_datasus w_ge657_conciliacao_fpb_datasus

type variables
uo_filial		ivo_Filial
uo_produto	ivo_Prod
end variables

forward prototypes
public subroutine wf_localiza_filial ()
end prototypes

public subroutine wf_localiza_filial ();Integer lvi_Nulo

SetNull(lvi_Nulo)

Tab_1.TabPage_1.dw_1.AcceptText()

ivo_Filial.of_Localiza_Filial(Tab_1.TabPage_1.dw_1.GetText())

If ivo_Filial.Localizada Then
	Tab_1.TabPage_1.dw_1.Object.Cd_Filial       [1]   = ivo_Filial.Cd_Filial
	Tab_1.TabPage_1.dw_1.Object.Nm_Fantasia [1]   = ivo_Filial.Nm_Fantasia
Else
	Tab_1.TabPage_1.dw_1.Object.Cd_Filial       [1]  = lvi_Nulo
	Tab_1.TabPage_1.dw_1.Object.Nm_Fantasia [1]  = ""	
End If
end subroutine

on w_ge657_conciliacao_fpb_datasus.create
int iCurrent
call super::create
end on

on w_ge657_conciliacao_fpb_datasus.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_preopen;call super::ue_preopen;ivo_Filial	= Create uo_Filial
ivo_prod	= Create uo_produto
end event

event ue_postopen;call super::ue_postopen;Date lvdt_Parametro

This.ivm_Menu.ivb_Permite_Imprimir = True

lvdt_Parametro = Date(gvo_Parametro.of_Dh_Movimentacao())

Tab_1.TabPage_1.dw_1.Object.Dt_Inicio 	[1] = RelativeDate(lvdt_Parametro, -2)
Tab_1.TabPage_1.dw_1.Object.Dt_Termino	[1] = lvdt_Parametro

end event

event close;call super::close;Destroy ivo_Filial
Destroy ivo_prod
end event

type dw_visual from dc_w_2tab_consulta_selecao_lista_det`dw_visual within w_ge657_conciliacao_fpb_datasus
end type

type gb_aux_visual from dc_w_2tab_consulta_selecao_lista_det`gb_aux_visual within w_ge657_conciliacao_fpb_datasus
end type

type tab_1 from dc_w_2tab_consulta_selecao_lista_det`tab_1 within w_ge657_conciliacao_fpb_datasus
integer x = 18
integer y = 16
integer width = 5806
integer height = 2464
tabpage_3 tabpage_3
end type

on tab_1.create
this.tabpage_3=create tabpage_3
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tabpage_3
end on

on tab_1.destroy
call super::destroy
destroy(this.tabpage_3)
end on

event tab_1::selectionchanged;// OverRide
SetPointer(HourGlass!)

Choose Case NewIndex
	Case 1
		
		TabPage_1.dw_2.ivm_Menu.mf_Classificar(True)
//		TabPage_1.dw_2.ivm_Menu.mf_Filtrar(True)
		
		TabPage_1.dw_2.ivm_Menu.mf_imprimir(TabPage_1.dw_2.RowCount( ) > 0)
		TabPage_1.dw_2.ivm_Menu.mf_salvarcomo(TabPage_1.dw_2.RowCount( ) > 0)	

		This.Width  = 5847
		This.Height = 2500
		
		Tab_1.TabPage_1.dw_2.SetFocus()		
		
	Case 2
		
		TabPage_1.dw_2.ivm_Menu.mf_Classificar(False)
//		TabPage_1.dw_2.ivm_Menu.mf_Filtrar(False)
		
		TabPage_1.dw_2.ivm_Menu.mf_Imprimir(False)
		TabPage_1.dw_2.ivm_Menu.mf_SalvarComo(False)
		
		This.Width  = 4390
		This.Height = 1020
		
		Tab_1.TabPage_2.dw_3.SetFocus()
		
	Case 3
		
		TabPage_1.dw_2.ivm_Menu.mf_Classificar(False)
//		TabPage_1.dw_2.ivm_Menu.mf_Filtrar(False)
		
		TabPage_1.dw_2.ivm_Menu.mf_Imprimir(False)
		TabPage_1.dw_2.ivm_Menu.mf_SalvarComo(False)
		
		This.Width  = 4390
		This.Height = 1020
		
		Tab_1.TabPage_3.dw_4.SetFocus()		
		
End Choose

ivm_Menu.mf_Localizar(False)

Parent.Width  = This.Width	+ This.X + 75
//Parent.Width  = This.Width + This.X + 80
//Parent.Height = This.Height + This.Y + 168

SetPointer(Arrow!)
end event

event tab_1::selectionchanging;call super::selectionchanging;//OverRide

SetPointer(HourGlass!)

//If NewIndex = 2 Then
//	If Tab_1.TabPage_1.dw_2.GetRow() > 0 Then
//		// Executa o evento de recupera$$HEX2$$e700e300$$ENDHEX$$o das linhas
//		// das DW's de detalhes
//		Tab_1.TabPage_2.dw_3.Event ue_Retrieve()
//		
//		// Permite a troca do folder
//		Return 0
//	Else
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma linha da lista para visualizar os detalhes.", StopSign!)
//		// N$$HEX1$$e300$$ENDHEX$$o permite a troca do folder
//				
//		Return 1
//	End If
//End If		

If NewIndex = 3 Then
	If Tab_1.TabPage_1.dw_2.GetRow() > 0 Then
		// Executa o evento de recupera$$HEX2$$e700e300$$ENDHEX$$o das linhas
		// das DW's de detalhes
		Tab_1.TabPage_3.dw_4.Event ue_Retrieve()
		
		// Permite a troca do folder
		Return 0
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma linha da lista para visualizar os detalhes.", StopSign!)
		// N$$HEX1$$e300$$ENDHEX$$o permite a troca do folder
				
		Return 1
	End If
End If		

SetPointer(Arrow!)
end event

type tabpage_1 from dc_w_2tab_consulta_selecao_lista_det`tabpage_1 within tab_1
integer width = 5769
integer height = 2348
end type

type gb_2 from dc_w_2tab_consulta_selecao_lista_det`gb_2 within tabpage_1
integer y = 700
integer width = 5723
integer height = 1620
end type

type gb_1 from dc_w_2tab_consulta_selecao_lista_det`gb_1 within tabpage_1
integer width = 3799
integer height = 620
end type

type dw_1 from dc_w_2tab_consulta_selecao_lista_det`dw_1 within tabpage_1
integer width = 3707
integer height = 512
string dataobject = "dw_ge657_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;Long lvl_Nulo

Choose Case dwo.Name
	Case "nm_fantasia"
		If Trim(Data) <> "" Then
			If Data <> ivo_Filial.nm_Fantasia Then
				Return 1
			End If	
		Else			
			ivo_Filial.of_Inicializa( )
			
			This.Object.Cd_Filial		[1] = ivo_Filial.Cd_Filial
			This.Object.Nm_Fantasia[1] = ivo_Filial.Nm_Fantasia			
		End If
	Case "nm_produto"
		If Trim(Data) <> "" Then
			If Data <> ivo_Prod.ivs_descricao_apresentacao_venda Then
				Return 1
			End If	
		Else			
			ivo_Prod.of_Inicializa( )
			
			This.Object.cd_produto	[1] = ivo_Prod.Cd_produto
			This.Object.nm_produto	[1] = ivo_Prod.ivs_descricao_apresentacao_venda	
		End If		
End Choose

end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Filial) Then
	This.Object.Nm_Fantasia[1] = ivo_Filial.Nm_Fantasia			
End If
				
If IsValid(ivo_Prod) Then
	This.Object.nm_produto	[1] = ivo_Prod.ivs_descricao_apresentacao_venda	
End If
end event

event dw_1::ue_key;call super::ue_key;String lvs_Coluna

If Key = KeyEnter! Then
	
	lvs_Coluna = This.GetColumnName()
	
	Choose Case lvs_Coluna
		Case 'nm_fantasia'
			wf_Localiza_Filial()
		Case 'nm_produto'
			ivo_Prod.Of_Localiza_Produto( This.GetText() )
			
			This.Object.nm_produto	[1] = ivo_Prod.ivs_descricao_apresentacao_venda
			This.Object.cd_produto	[1] = ivo_Prod.Cd_produto			
	End Choose
End If
end event

type dw_2 from dc_w_2tab_consulta_selecao_lista_det`dw_2 within tabpage_1
integer y = 772
integer width = 5641
integer height = 1512
string dataobject = "dw_ge657_lista"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;Date	lvdt_Inicio, &
    		lvdt_Termino
			 
Long	lvl_Filial
Long	lvl_Nr_Nf
Long	lvl_Nr_Lote
Long	lvl_Prod
Long 	lvl_AppendWhere_ID = 5

String lvs_Devolucao
String lvs_Datasus
String lvs_Nr_Cartao
String lvs_SQL
String	lvs_Situacao
String	lvs_Situacao_fpb
String lvs_Especie
String lvs_Serie

Parent.dw_1.AcceptText()
This.SetFilter("")

lvl_Filial					= Parent.dw_1.Object.Cd_Filial				[1]
lvdt_Inicio				= Parent.dw_1.Object.Dt_Inicio				[1]
lvdt_Termino			= Parent.dw_1.Object.Dt_Termino			[1]
lvs_Devolucao			= Parent.dw_1.Object.id_devolucao		[1]
lvl_Nr_Nf					= Parent.dw_1.Object.nr_nf					[1]
lvs_Datasus				= Parent.dw_1.Object.nr_autorizacao		[1]	
lvs_Nr_Cartao 			= Parent.dw_1.Object.nr_cartao			[1]	
//lvl_Nr_Lote				= Parent.dw_1.Object.Nr_Lote				[1]
lvs_Situacao				= Parent.dw_1.Object.id_situacao_nf		[1]
lvs_Situacao_fpb		= Parent.dw_1.Object.id_situacao_aut	[1]
lvs_Especie				= Parent.dw_1.Object.de_especie			[1]
lvs_Serie					= Parent.dw_1.Object.de_serie				[1]
lvl_Prod					= Parent.dw_1.Object.cd_produto			[1]

If (lvl_Filial>0) and (Not IsNull(lvl_Filial)) Then
	This.of_AppendWhere_SubQuery("vp.cd_filial = " +  String(lvl_Filial), 1)
	This.of_AppendWhere_SubQuery("vp.cd_filial = " +  String(lvl_Filial), 4)
	This.of_AppendWhere_SubQuery("vp.cd_filial = " +  String(lvl_Filial), 6)
	This.of_AppendWhere_SubQuery("vp.cd_filial = " +  String(lvl_Filial), 8)
	This.of_AppendWhere_SubQuery("vp.cd_filial = " +  String(lvl_Filial), 11)
	This.of_AppendWhere_SubQuery("fpb.cd_filial = " +  String(lvl_Filial), 15)

//	lvs_SQL = gf_replace(lvs_SQL, 'idx_data_convenio','idx_fil_dt_conv',0)
End If

If (lvl_Nr_Nf>0) and (Not IsNull(lvl_Nr_Nf)) Then
	This.of_AppendWhere_SubQuery("vp.nr_nf = " +  String(lvl_Nr_Nf), 1)
	This.of_AppendWhere_SubQuery("vp.nr_nf = " +  String(lvl_Nr_Nf), 4)
	This.of_AppendWhere_SubQuery("vp.nr_nf = " +  String(lvl_Nr_Nf), 6)	
	This.of_AppendWhere_SubQuery("vp.nr_nf = " +  String(lvl_Nr_Nf), 8)
	This.of_AppendWhere_SubQuery("vp.nr_nf = " +  String(lvl_Nr_Nf), 11)	
	//This.of_AppendWhere_SubQuery("fpb.nr_cupom = '" +  String(lvl_Nr_Nf) + "'", 9)
End If

If Trim(lvs_especie) <> '' And Not IsNull(lvs_especie) Then
	This.of_AppendWhere_SubQuery("vp.de_especie = '" + lvs_especie + "'", 1)
	This.of_AppendWhere_SubQuery("vp.de_especie = '" + lvs_especie + "'", 4)
	This.of_AppendWhere_SubQuery("vp.de_especie = '" + lvs_especie + "'", 6)	
	This.of_AppendWhere_SubQuery("vp.de_especie = '" + lvs_especie + "'", 8)
	This.of_AppendWhere_SubQuery("vp.de_especie = '" + lvs_especie + "'", 11)	
	//This.of_AppendWhere_SubQuery("fpb.nr_cupom = '" +  String(lvl_Nr_Nf) + "'", 5)
End If

If Trim(lvs_serie) <> '' And Not IsNull(lvs_serie) Then
	This.of_AppendWhere_SubQuery("vp.de_serie = '" + lvs_serie + "'", 1)
	This.of_AppendWhere_SubQuery("vp.de_serie = '" + lvs_serie + "'", 4)
	This.of_AppendWhere_SubQuery("vp.de_serie = '" + lvs_serie + "'", 6)	
	This.of_AppendWhere_SubQuery("vp.de_serie = '" + lvs_serie + "'", 8)	
	This.of_AppendWhere_SubQuery("vp.de_serie = '" + lvs_serie + "'", 11)		
	//This.of_AppendWhere_SubQuery("fpb.nr_cupom = '" +  String(lvl_Nr_Nf) + "'", 5)
End If

If Trim(lvs_Nr_Cartao) <> '' And Not IsNull(lvs_Nr_Cartao) Then
	This.of_AppendWhere_SubQuery("vp.nr_cartao = '" + lvs_Nr_Cartao + "'", 1)
	This.of_AppendWhere_SubQuery("vp.nr_cartao = '" + lvs_Nr_Cartao + "'", 4)
	This.of_AppendWhere_SubQuery("vp.nr_cartao = '" + lvs_Nr_Cartao + "'", 6)	
	This.of_AppendWhere_SubQuery("vp.nr_cartao = '" + lvs_Nr_Cartao + "'", 8)
	This.of_AppendWhere_SubQuery("vp.nr_cartao = '" + lvs_Nr_Cartao + "'", 11)		
	This.of_AppendWhere_SubQuery("fpb.nr_cpf = '" +  lvs_Nr_Cartao + "'", 15)
End If

If Trim(lvs_Datasus) <> '' And Not IsNull(lvs_Datasus) Then
	This.of_AppendWhere_SubQuery("vp.nr_autorizacao_datasus = '" + lvs_Datasus + "'", 1)
	This.of_AppendWhere_SubQuery("vp.nr_autorizacao_datasus = '" + lvs_Datasus + "'", 4)
	This.of_AppendWhere_SubQuery("vp.nr_autorizacao_datasus = '" + lvs_Datasus + "'", 6)	
	This.of_AppendWhere_SubQuery("vp.nr_autorizacao_datasus = '" + lvs_Datasus + "'", 8)
	This.of_AppendWhere_SubQuery("vp.nr_autorizacao_datasus = '" + lvs_Datasus + "'", 11)	
	This.of_AppendWhere_SubQuery("fpb.nr_autorizacao = '" +  lvs_Datasus + "'", 15)
End If

Choose Case lvs_Situacao
	Case 'N'
		This.of_AppendWhere_SubQuery("nf.dh_cancelamento is null", 1)
		This.of_AppendWhere_SubQuery("nf.dh_cancelamento is null", 4)
		This.of_AppendWhere_SubQuery("nf.dh_cancelamento is null", 6)		
		This.of_AppendWhere_SubQuery("nf.dh_cancelamento is null", 8)		
	Case 'C'
		This.of_AppendWhere_SubQuery("nf.dh_cancelamento is not null", 1)
		This.of_AppendWhere_SubQuery("nf.dh_cancelamento is not null", 4)
		This.of_AppendWhere_SubQuery("nf.dh_cancelamento is not null", 6)
		This.of_AppendWhere_SubQuery("nf.dh_cancelamento is not null", 8)
End Choose

If lvs_Devolucao = "S" Then
	lvl_AppendWhere_ID = 6
	This.of_AppendWhere_SubQuery(	"not exists (select d.nr_nf from nf_devolucao_venda d " + &
													"where d.cd_filial_venda = vp.cd_filial "+ &
													 "and d.nr_nf_venda = vp.nr_nf "+ &
													 "and d.de_serie_venda = vp.de_serie "+ &
													 "and d.de_especie_venda = vp.de_especie "+ &
													 "and d.dh_cancelamento is null)", 1)	
	This.of_AppendWhere_SubQuery(	"not exists (select d.nr_nf from nf_devolucao_venda d " + &
													"where d.cd_filial_venda = vp.cd_filial "+ &
													 "and d.nr_nf_venda = vp.nr_nf "+ &
													 "and d.de_serie_venda = vp.de_serie "+ &
													 "and d.de_especie_venda = vp.de_especie "+ &
 													 "and d.dh_cancelamento is null)", 5)	
	This.of_AppendWhere_SubQuery(	"not exists (select d.nr_nf from nf_devolucao_venda d " + &
													"where d.cd_filial_venda = vp.cd_filial "+ &
													 "and d.nr_nf_venda = vp.nr_nf "+ &
													 "and d.de_serie_venda = vp.de_serie "+ &
													 "and d.de_especie_venda = vp.de_especie "+ &
  													 "and d.dh_cancelamento is null)", 8)
	This.of_AppendWhere_SubQuery(	"not exists (select d.nr_nf from nf_devolucao_venda d " + &
													"where d.cd_filial_venda = vp.cd_filial "+ &
													 "and d.nr_nf_venda = vp.nr_nf "+ &
													 "and d.de_serie_venda = vp.de_serie "+ &
													 "and d.de_especie_venda = vp.de_especie "+ &
  													 "and d.dh_cancelamento is null)", 11)
	This.of_AppendWhere_SubQuery(	"not exists (select d.nr_nf from nf_devolucao_venda d " + &
													"where d.cd_filial_venda = vp.cd_filial "+ &
													 "and d.nr_nf_venda = vp.nr_nf "+ &
													 "and d.de_serie_venda = vp.de_serie "+ &
													 "and d.de_especie_venda = vp.de_especie "+ &
  													 "and d.dh_cancelamento is null)", 15)														 													 														
End If

If lvl_Prod > 0 Then	
	This.of_AppendWhere_SubQuery(	"exists (select vpp.cd_produto from dbo.venda_pbm_produto vpp (index PK_VENDA_PBM_PRODUTO) "+&
												"where 	vpp.cd_filial 		= vp.cd_filial "+&
												"and 	vpp.nr_nf 		= vp.nr_nf "+&
												"and	vpp.de_especie	= vp.de_especie "+&
												"and	vpp.de_serie 	= vp.de_serie "+&
												"and 	vpp.nr_sequencial_pbm = vp.nr_sequencial_pbm "+&
												"and 	vpp.cd_produto = " + String(lvl_Prod) + ")", 1)
	This.of_AppendWhere_SubQuery(	"exists (select vpp.cd_produto from dbo.venda_pbm_produto vpp (index PK_VENDA_PBM_PRODUTO) "+&
												"where 	vpp.cd_filial 		= vp.cd_filial "+&
												"and 	vpp.nr_nf 		= vp.nr_nf "+&
												"and	vpp.de_especie	= vp.de_especie "+&
												"and	vpp.de_serie 	= vp.de_serie "+&
												"and 	vpp.nr_sequencial_pbm = vp.nr_sequencial_pbm "+&
												"and 	vpp.cd_produto = " + String(lvl_Prod) + ")", lvl_AppendWhere_ID)
	If lvs_Devolucao = "S" Then
		lvl_AppendWhere_ID = lvl_AppendWhere_ID + 4
	Else
		lvl_AppendWhere_ID = lvl_AppendWhere_ID + 3
	End If
	This.of_AppendWhere_SubQuery(	"exists (select vpp.cd_produto from dbo.venda_pbm_produto vpp (index PK_VENDA_PBM_PRODUTO) "+&
												"where 	vpp.cd_filial 		= vp.cd_filial "+&
												"and 	vpp.nr_nf 		= vp.nr_nf "+&
												"and	vpp.de_especie	= vp.de_especie "+&
												"and	vpp.de_serie 	= vp.de_serie "+&
												"and 	vpp.nr_sequencial_pbm = vp.nr_sequencial_pbm "+&
												"and 	vpp.cd_produto = " + String(lvl_Prod) + ")", lvl_AppendWhere_ID)
	If lvs_Devolucao = "S" Then
		lvl_AppendWhere_ID = lvl_AppendWhere_ID + 4
	Else
		lvl_AppendWhere_ID = lvl_AppendWhere_ID + 3
	End If												
	This.of_AppendWhere_SubQuery(	"exists (select vpp.cd_produto from dbo.venda_pbm_produto vpp (index PK_VENDA_PBM_PRODUTO) "+&
												"where 	vpp.cd_filial 		= vp.cd_filial "+&
												"and 	vpp.nr_nf 		= vp.nr_nf "+&
												"and	vpp.de_especie	= vp.de_especie "+&
												"and	vpp.de_serie 	= vp.de_serie "+&
												"and 	vpp.nr_sequencial_pbm = vp.nr_sequencial_pbm "+&
												"and 	vpp.cd_produto = " + String(lvl_Prod) + ")", lvl_AppendWhere_ID)
	If lvs_Devolucao = "S" Then
		lvl_AppendWhere_ID = lvl_AppendWhere_ID + 5
	Else
		lvl_AppendWhere_ID = lvl_AppendWhere_ID + 4
	End If												
	This.of_AppendWhere_SubQuery(	"exists (select vpp.cd_produto from dbo.venda_pbm_produto vpp (index PK_VENDA_PBM_PRODUTO) "+&
												"where 	vpp.cd_filial 		= vp.cd_filial "+&
												"and 	vpp.nr_nf 		= vp.nr_nf "+&
												"and	vpp.de_especie	= vp.de_especie "+&
												"and	vpp.de_serie 	= vp.de_serie "+&
												"and 	vpp.nr_sequencial_pbm = vp.nr_sequencial_pbm "+&
												"and 	vpp.cd_produto = " + String(lvl_Prod) + ")", lvl_AppendWhere_ID)												
	If lvs_Devolucao = "S" Then
		lvl_AppendWhere_ID = lvl_AppendWhere_ID + 6
	Else
		lvl_AppendWhere_ID = lvl_AppendWhere_ID + 5
	End If																								
	This.of_AppendWhere_SubQuery(	"exists (select b.cd_produto from dbo.codigo_barras_produto b "+&
												"where b.cd_produto = " + String(lvl_Prod) +&
												" and b.de_codigo_barras = fpb.cd_ean_produto)", lvl_AppendWhere_ID)
End If
//Choose Case Trim(lvs_Situacao_fpb)
//	Case '00RV'
//		This.of_AppendWhere_SubQuery("fpb.de_status_datasus = '" +  lvs_situacao_fpb + "'", 2)		
//		This.of_AppendWhere_SubQuery("fpb.de_status_datasus = '" +  lvs_situacao_fpb + "'", 4)		
//		This.of_AppendWhere_SubQuery("fpb.de_status_datasus = '" +  lvs_situacao_fpb + "'", 5)
//	Case 'EST'
//		This.of_AppendWhere_SubQuery("fpb.de_status_datasus = '" +  lvs_situacao_fpb + "'", 2)		
//		This.of_AppendWhere_SubQuery("fpb.de_status_datasus = '" +  lvs_situacao_fpb + "'", 4)				
//		This.of_AppendWhere_SubQuery("fpb.de_status_datasus = '" +  lvs_situacao_fpb + "'", 5)
//End Choose

lvs_SQL = This.GetSQLSelect()
This.SetSQLSelect(lvs_SQL)

This.SetRedraw(False)
This.Post SetRedraw(True)

Return 1
end event

event dw_2::ue_reset;call super::ue_reset;ivo_controle_menu.of_salvarcomo(False)
ivo_controle_menu.of_imprimir(False)
end event

event dw_2::constructor;call super::constructor;//This.Of_SetRowselection("", "~tIf ( Not IsNull( dh_cancelamento ) , rgb(255,0,0) , 0 )")
//This.Of_SetRowselection("", "~tIf ( Not IsNull( dh_devolucao ) , rgb(255,255,0) , 0 )")
//This.Of_SetRowselection("", "~tIf ( de_concilicao = 'SOMENTE VENDA' , rgb(255,255,0) , 0 )")
This.of_SetRowSelection("if (de_conciliacao = ~"SV~", rgb(255, 198, 198), if(de_conciliacao = ~"OK~",rgb(213, 255, 213), if(de_conciliacao = ~"SD~",rgb(192, 192, 192), rgb(255, 0, 0))))","")


This.ivb_Ordena_Colunas = True

//This.ShareData(Parent.dw_5)
end event

event dw_2::rowfocuschanged;call super::rowfocuschanged;This.ivm_menu.mf_salvarcomo(This.RowCount() > 0)

Return AncestorReturnValue
end event

event dw_2::ue_recuperar;//override
Date	lvdt_Inicio, &
    		lvdt_Termino
Parent.dw_1.AcceptText()

lvdt_Inicio		= Parent.dw_1.Object.Dt_Inicio			[1]
lvdt_Termino	= Parent.dw_1.Object.Dt_Termino		[1]

//This.SetRedraw(False)

Return This.Retrieve(lvdt_Inicio, lvdt_Termino)
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;Long 	lvl_Row
Long 	lvl_Filial
Long 	lvl_NF

String lvs_conciliada
String lvs_Serie

Decimal{2} lvdc_Pago_Avista
Decimal{2} lvdc_Total_NF

This.SetReDraw(False)
If Parent.dw_1.Object.id_nao_conciliada[1] = 'S' Then
	This.SetFilter("de_conciliacao <> 'OK'")
	This.Filter()
End If 
Choose Case Parent.dw_1.Object.id_situacao_conc[1]
	Case 'OK'
		This.SetFilter("de_conciliacao = 'OK'")
		This.Filter()		
	Case 'SV'
		This.SetFilter("de_conciliacao = 'SV'")
		This.Filter()
	Case 'CA'
		This.SetFilter("de_conciliacao = 'CA'")
		This.Filter()
	Case 'SD'
		This.SetFilter("de_conciliacao = 'SD'")
		This.Filter()
End Choose
This.SetReDraw(True)

If This.RowCount() > 0 Then
	This.ivo_controle_menu.of_SalvarComo(True)
	This.ivo_controle_menu.of_Imprimir(True)
Else
	// Se tem algo no filtro e nada na tela, mostrar a msg.
	If This.FilteredCount() > 0 Then MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.")
End If

Return AncestorReturnValue

end event

type tabpage_2 from dc_w_2tab_consulta_selecao_lista_det`tabpage_2 within tab_1
integer width = 5769
integer height = 2348
end type

type gb_3 from dc_w_2tab_consulta_selecao_lista_det`gb_3 within tabpage_2
integer width = 4256
integer height = 924
end type

type dw_3 from dc_w_2tab_consulta_selecao_lista_det`dw_3 within tabpage_2
integer width = 4206
integer height = 832
string dataobject = "dw_ge657_detalhe_itens"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event dw_3::ue_recuperar;// OverRide
Long 		lvl_Linha, &
     		lvl_Filial, &
     		lvl_Doc, &
			lvl_nr_Sequencial_PBM
	  
String	lvl_Especie,&
			lvl_Serie
	  
lvl_Linha = Tab_1.TabPage_1.dw_2.GetRow()

lvl_Filial		= Tab_1.TabPage_1.dw_2.Object.Cd_Filial		[lvl_Linha]
lvl_Doc		= Tab_1.TabPage_1.dw_2.Object.Nr_Nf			[lvl_Linha]
lvl_Especie	= Tab_1.TabPage_1.dw_2.Object.De_Especie	[lvl_Linha]
lvl_Serie		= Tab_1.TabPage_1.dw_2.Object.De_Serie		[lvl_Linha]

Return This.Retrieve(lvl_Filial, lvl_Doc, lvl_Especie, lvl_Serie)
end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 5769
integer height = 2348
long backcolor = 67108864
string text = "DataSus"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
gb_4 gb_4
dw_4 dw_4
end type

on tabpage_3.create
this.gb_4=create gb_4
this.dw_4=create dw_4
this.Control[]={this.gb_4,&
this.dw_4}
end on

on tabpage_3.destroy
destroy(this.gb_4)
destroy(this.dw_4)
end on

type gb_4 from groupbox within tabpage_3
integer x = 14
integer y = 8
integer width = 4315
integer height = 736
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
string text = "Itens Datasus"
borderstyle borderstyle = styleraised!
end type

type dw_4 from dc_uo_dw_base within tabpage_3
integer x = 41
integer y = 72
integer width = 4251
integer height = 656
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_ge657_detalhe_datasus"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.of_SetRowSelection()
end event

event ue_recuperar;// OverRide

Long 		lvl_Linha, &
     		lvl_Filial, &
     		lvl_Doc, &
			lvl_nr_Sequencial_PBM
	  
String	lvl_Especie,&
			lvl_Serie,&
			lvs_aut
	  
lvl_Linha = Tab_1.TabPage_1.dw_2.GetRow()

lvl_Filial		= Tab_1.TabPage_1.dw_2.Object.Cd_Filial						[lvl_Linha]
lvs_aut		= Tab_1.TabPage_1.dw_2.Object.nr_autorizacao_datasus	[lvl_Linha]
//lvl_Especie	= Tab_1.TabPage_1.dw_2.Object.De_Especie	[lvl_Linha]
//lvl_Serie		= Tab_1.TabPage_1.dw_2.Object.De_Serie		[lvl_Linha]
//lvl_nr_Sequencial_PBM = Tab_1.TabPage_1.dw_2.Object.nr_Sequencial_PBM[lvl_Linha]

Return This.Retrieve(lvl_Filial, lvs_aut)
end event

