HA$PBExportHeader$w_ge273_consulta_venda_pbm.srw
forward
global type w_ge273_consulta_venda_pbm from dc_w_2tab_consulta_selecao_lista_det
end type
type cb_alt_dt_pagamento from commandbutton within tabpage_1
end type
type st_1 from statictext within tabpage_1
end type
type dw_5 from dc_uo_dw_base within tabpage_1
end type
type dw_7 from dc_uo_dw_base within tabpage_1
end type
type tab_2 from tab within tabpage_2
end type
type tabpage2_1 from userobject within tab_2
end type
type gb_4 from groupbox within tabpage2_1
end type
type dw_4 from dc_uo_dw_base within tabpage2_1
end type
type tabpage2_1 from userobject within tab_2
gb_4 gb_4
dw_4 dw_4
end type
type tabpage2_2 from userobject within tab_2
end type
type gb_5 from groupbox within tabpage2_2
end type
type dw_6 from dc_uo_dw_base within tabpage2_2
end type
type tabpage2_2 from userobject within tab_2
gb_5 gb_5
dw_6 dw_6
end type
type tab_2 from tab within tabpage_2
tabpage2_1 tabpage2_1
tabpage2_2 tabpage2_2
end type
end forward

global type w_ge273_consulta_venda_pbm from dc_w_2tab_consulta_selecao_lista_det
string tag = "w_ge273_consulta_venda_pbm"
integer width = 6578
integer height = 2680
string title = "GE273 - Relat$$HEX1$$f300$$ENDHEX$$rio de Vendas Conv$$HEX1$$ea00$$ENDHEX$$nio - PBM"
long backcolor = 80269524
end type
global w_ge273_consulta_venda_pbm w_ge273_consulta_venda_pbm

type variables
uo_filial		ivo_Filial
uo_produto	ivo_Prod
end variables

forward prototypes
public subroutine wf_exporta_pedido ()
public subroutine wf_localiza_filial ()
public subroutine wf_insere_padrao ()
public function boolean wf_altera_dt_pagamento (long pl_convenio, long pl_filial, long pl_nr_nf, string ps_especie, string ps_serie, datetime pdth_pagamento)
end prototypes

public subroutine wf_exporta_pedido ();String lvs_Exe, &
       lvs_Parametro
		 
Long lvl_Filial

Date lvdt_Exportacao

lvs_EXE = "c:\sistemas\troca_dados_loja\exe\troca_dados_loja.exe"
	
If FileExists(lvs_EXE) Then
	lvl_Filial      = gvo_Parametro.of_Filial()
	lvdt_Exportacao = Date(gvo_Parametro.of_Dh_Movimentacao())
	
	lvs_Parametro = "P" + String(lvl_Filial, "0000") + String(lvdt_Exportacao, "dd/mm/yyyy")
	Run(lvs_EXE + " " + lvs_Parametro)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A exporta$$HEX2$$e700e300$$ENDHEX$$o dos arquivos n$$HEX1$$e300$$ENDHEX$$o pode ser efetuada.~r~r" + &
								 "O execut$$HEX1$$e100$$ENDHEX$$vel '" + lvs_EXE + "' do sistema de troca dados de loja n$$HEX1$$e300$$ENDHEX$$o foi localizado.", StopSign!)
End If
end subroutine

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

public subroutine wf_insere_padrao ();DataWindowChild dwc_convenio

/* Conv$$HEX1$$ea00$$ENDHEX$$nio */ 
dwc_convenio  = Tab_1.TabPage_1.dw_1.of_InsertRow_DDDW("cd_convenio" )		
dwc_convenio.SetItem(1,'cd_convenio',0)
dwc_convenio.SetItem(1,'nm_fantasia','TODOS')	
Tab_1.TabPage_1.dw_1.Object.cd_convenio	[1] = 0

/* Funcional */
dwc_convenio  = Tab_1.TabPage_1.dw_1.of_InsertRow_DDDW("cd_convenio_fun" )			
dwc_convenio.SetItem(1, "cd_conveniado", 'TD'	)
dwc_convenio.SetItem(1, "nm_conveniado", "TODOS")
Tab_1.TabPage_1.dw_1.Object.cd_convenio_fun[1] = 'TD'

/* Vidalink */
dwc_convenio  = Tab_1.TabPage_1.dw_1.of_InsertRow_DDDW("cd_convenio_vdk" )			
dwc_convenio.SetItem(1, "cd_programa", 'TD'	)
dwc_convenio.SetItem(1, "de_programa", "TODOS")
Tab_1.TabPage_1.dw_1.Object.cd_convenio_vdk[1] = 'TD'

/* Epharma */
dwc_convenio  = Tab_1.TabPage_1.dw_1.of_InsertRow_DDDW("cd_convenio_eph" )			
dwc_convenio.SetItem(1, "cd_convenio", 0	)
dwc_convenio.SetItem(1, "nm_convenio", "TODOS")
Tab_1.TabPage_1.dw_1.Object.cd_convenio_eph[1] = 0

/* Epharma Benef$$HEX1$$ed00$$ENDHEX$$cio*/
dwc_convenio  = Tab_1.TabPage_1.dw_1.of_InsertRow_DDDW("cd_convenio_benef" )			
dwc_convenio.SetItem(1, "cd_cliente", 'TD'	)
dwc_convenio.SetItem(1, "nm_cliente", "TODOS")
Tab_1.TabPage_1.dw_1.Object.cd_convenio_benef[1] = 'TD'

/* TRNCentre */
dwc_convenio  = Tab_1.TabPage_1.dw_1.of_InsertRow_DDDW("cd_convenio_trn" )			
dwc_convenio.SetItem(1, "cd_programa", 'TD'	)
dwc_convenio.SetItem(1, "de_programa", "TODOS")
Tab_1.TabPage_1.dw_1.Object.cd_convenio_trn[1] = 'TD'

/* PharmaSystem */
dwc_convenio  = Tab_1.TabPage_1.dw_1.of_InsertRow_DDDW("cd_convenio_phs" )			
dwc_convenio.SetItem(1, "cd_convenio_pbm", 'TD'	)
dwc_convenio.SetItem(1, "nm_conveniado", "TODOS")
Tab_1.TabPage_1.dw_1.Object.cd_convenio_phs[1] = 'TD'
end subroutine

public function boolean wf_altera_dt_pagamento (long pl_convenio, long pl_filial, long pl_nr_nf, string ps_especie, string ps_serie, datetime pdth_pagamento);Long lvl_Sequencial
Long lvl_Convenio

String lvs_Programa

Update conciliacao_pbm_produto
    set dh_pagamento = :pdth_Pagamento
Where cd_filial_venda		= :pl_Filial
	and nr_nf_venda			= :pl_Nr_Nf
	and de_especie_venda	= :ps_Especie
	and de_serie_venda		= :ps_Serie
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Erro na altera$$HEX2$$e700e300$$ENDHEX$$o da data de pagamento na tabela de concilia$$HEX2$$e700e300$$ENDHEX$$o.", StopSign!)
	Return False
End If

If SqlCa.SQLNRows = 0 Then
	//Insere registro na tabela pai
	insert into conciliacao_pbm (cd_convenio_pbm, nr_controle)
	select :pl_convenio, :pl_filial from parametro where id_parametro = '1'
	Using SQLCa;
	
	//Localiza sequencial
	select coalesce(max(c1.nr_sequencial),0)
	Into :lvl_Sequencial
	from conciliacao_pbm_produto c1 
	where c1.nr_controle = :pl_filial
		And c1.cd_convenio_pbm = :pl_convenio
	Using SQLCa;

	If SQLCa.SQLCode = -1 Then
		SQLCa.Of_msgdberror( "Localiza$$HEX2$$e700e300$$ENDHEX$$o sequencial")
		SqlCa.Of_Rollback()
		Return False
	ElseIf SQLCa.SQLCode = 100 Then
		lvl_Sequencial = 0
	End If
	
	//Cria cursor de itens de venda pbm
	DECLARE lcu_pbm_produto CURSOR FOR
	select 	v.dh_venda, 
				vp.cd_produto, 
				vp.qt_vendida, 
				vp.vl_praticado, 
				vp.qt_vendida * vp.vl_praticado,
				case when v.cd_convenio in (52575,53725,53724) then v.nr_comprovante_venda else v.cd_convenio_pbm end,
				vp.nr_sequencial_pbm
	from venda_pbm v
	inner join venda_pbm_produto vp
		on  vp.cd_filial		= v.cd_filial
		and vp.nr_nf		= v.nr_nf
		and vp.de_especie	= v.de_especie
		and vp.de_serie	= v.de_serie
		and vp.nr_sequencial_pbm = v.nr_sequencial_pbm
	where v.cd_filial		= :pl_filial
		and v.nr_nf			= :pl_nr_nf
		and v.de_especie	= :ps_especie
		and v.de_serie		= :ps_serie
	Using SQLCa;
	
	//Abre o cursor
	OPEN lcu_pbm_produto;
	
	//Vari$$HEX1$$e100$$ENDHEX$$veis do cursor
	Datetime lvdh_Venda
	Long lvl_Produto, lvl_nr_Sequencial_PBM
	Long lvl_Qtde
	Decimal{2} lvdc_Venda_Unit
	Decimal{2} lvdc_Venda_Total
	
	FETCH lcu_pbm_produto INTO :lvdh_Venda, :lvl_Produto, :lvl_Qtde, :lvdc_Venda_Unit, :lvdc_Venda_Total, :lvs_Programa, :lvl_nr_Sequencial_PBM;
	
	// Repetir Enquanto Houver Linhas
	DO WHILE SQLCA.sqlcode = 0
		lvl_Sequencial++
		insert into conciliacao_pbm_produto (cd_convenio_pbm, nr_controle, nr_sequencial, id_tipo_registro, nr_nsu, id_status, dh_transacao, cd_produto, 
														qt_vendida, vl_venda, vl_total_venda, id_conciliada, cd_filial_venda, nr_nf_venda, de_especie_venda, de_serie_venda, 
														dh_pagamento, nr_cartao)
		values(:pl_convenio, :pl_filial, :lvl_Sequencial, 'X', '000000000', '1',:lvdh_Venda, :lvl_Produto, :lvl_Qtde, :lvdc_Venda_Unit, :lvdc_Venda_Total, 'S', :pl_filial,
				 :pl_nr_nf, :ps_especie, :ps_serie, :pdth_pagamento, :lvs_Programa)
		Using SQLCa;
		
		FETCH lcu_pbm_produto INTO :lvdh_Venda, :lvl_Produto, :lvl_Qtde, :lvdc_Venda_Unit, :lvdc_Venda_Total, :lvs_Programa, :lvl_nr_Sequencial_PBM;
	Loop
	
	If SQLCa.SQLCode = -1 Then
		SQLCa.Of_msgdberror( "Inserir registro concilia$$HEX2$$e700e300$$ENDHEX$$o")
		SqlCa.Of_Rollback()
		Return False
	End If
	
	update venda_pbm_produto 
	set id_conciliada = 'S'
	where cd_filial		= :pl_filial
		and nr_nf		= :pl_nr_nf
		and de_especie	= :ps_especie
		and de_serie	= :ps_serie
		and coalesce(id_conciliada,'N') <> 'S'
		and nr_sequencial_pbm = :lvl_nr_Sequencial_PBM
	Using SQLCa;
	
	If SQLCa.SQLCode = -1 Then
		SQLCa.Of_msgdberror( "Atualiza$$HEX2$$e700e300$$ENDHEX$$o PBM Produto")
		SqlCa.Of_Rollback()
		Return False
	End If
	
	update venda_pbm 
	set id_conciliada = 'S'
	where cd_filial		= :pl_filial
		and nr_nf		= :pl_nr_nf
		and de_especie	= :ps_especie
		and de_serie	= :ps_serie
		and coalesce(id_conciliada,'N') <> 'S'
		and nr_sequencial_pbm = :lvl_nr_Sequencial_PBM
	Using SQLCa;
	
	If SQLCa.SQLCode = -1 Then
		SQLCa.Of_msgdberror( "Atualiza$$HEX2$$e700e300$$ENDHEX$$o Venda PBM")
		SqlCa.Of_Rollback()
		Return False
	End If
End If

SqlCa.Of_Commit()

Return True
end function

on w_ge273_consulta_venda_pbm.create
int iCurrent
call super::create
end on

on w_ge273_consulta_venda_pbm.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;Date lvdt_Parametro

This.ivm_Menu.ivb_Permite_Imprimir = True

lvdt_Parametro = Date(gvo_Parametro.of_Dh_Movimentacao())

Tab_1.TabPage_1.dw_1.Object.Dt_Inicio 	[1] = RelativeDate(lvdt_Parametro, -2)
Tab_1.TabPage_1.dw_1.Object.Dt_Termino	[1] = lvdt_Parametro

wf_insere_padrao()


end event

event ue_preopen;call super::ue_preopen;// Determina as dimens$$HEX1$$f500$$ENDHEX$$es dos folders
// Sele$$HEX2$$e700e300$$ENDHEX$$o
ivl_Largura_1 = 6542

// Detalhes
ivl_Largura_2 = 6542

Maxheight = 9999

ivo_Filial	= Create uo_Filial
ivo_Prod	= Create uo_produto

end event

event close;call super::close;Destroy ivo_Filial
Destroy ivo_Prod
end event

event ue_printimmediate;Tab_1.TabPage_1.dw_5.Event ue_PrintImmediate()
end event

event ue_print;call super::ue_print;Tab_1.TabPage_1.dw_5.Event ue_Print()
end event

event ue_saveas;call super::ue_saveas;Date	lvdt_Inicio, &
    		lvdt_Termino
			 
tab_1.tabpage_1.dw_1.AcceptText()

lvdt_Inicio		= tab_1.tabpage_1.dw_1.Object.Dt_Inicio			[1]
lvdt_Termino	= tab_1.tabpage_1.dw_1.Object.Dt_Termino		[1]

//if tab_1.tabpage_1.dw_7.Retrieve(lvdt_Inicio, lvdt_Termino) > 0 then
//	Tab_1.TabPage_1.dw_7.Event ue_SaveAs()
//end if

if tab_1.tabpage_1.dw_5.Retrieve(lvdt_Inicio, lvdt_Termino) > 0 then
	Tab_1.TabPage_1.dw_5.Event ue_SaveAs()
end if
end event

event resize;call super::resize;Tab_1.Height = Newheight - 20

Tab_1.Tabpage_1.gb_2.Height		= Newheight - Tab_1.Tabpage_1.gb_2.Y - 140
Tab_1.Tabpage_1.dw_2.Height		= Newheight - Tab_1.Tabpage_1.dw_2.Y - 180
Tab_1.Tabpage_2.Tab_2.Height	= Newheight - Tab_1.Tabpage_2.Tab_2.Y - 140

Tab_1.TabPage_2.Tab_2.tabpage2_1.gb_4.Height		= Newheight - Tab_1.TabPage_2.Tab_2.tabpage2_1.gb_4.Y - 170
Tab_1.TabPage_2.Tab_2.tabpage2_1.dw_4.Height	= Newheight - Tab_1.TabPage_2.Tab_2.tabpage2_1.dw_4.Y - 210 

Tab_1.TabPage_2.Tab_2.tabpage2_2.gb_5.Y			= Tab_1.TabPage_2.Tab_2.tabpage2_1.gb_4.Y	
Tab_1.TabPage_2.Tab_2.tabpage2_2.gb_5.Height		= Tab_1.TabPage_2.Tab_2.tabpage2_1.gb_4.Height	
Tab_1.TabPage_2.Tab_2.tabpage2_2.dw_6.Height	= Tab_1.TabPage_2.Tab_2.tabpage2_1.dw_4.Height
end event

type dw_visual from dc_w_2tab_consulta_selecao_lista_det`dw_visual within w_ge273_consulta_venda_pbm
end type

type gb_aux_visual from dc_w_2tab_consulta_selecao_lista_det`gb_aux_visual within w_ge273_consulta_venda_pbm
end type

type tab_1 from dc_w_2tab_consulta_selecao_lista_det`tab_1 within w_ge273_consulta_venda_pbm
integer width = 6501
integer height = 2476
end type

event tab_1::selectionchanging;//OverRide

SetPointer(HourGlass!)

If NewIndex = 2 Then
	If Tab_1.TabPage_1.dw_2.GetRow() > 0 Then
		// Executa o evento de recupera$$HEX2$$e700e300$$ENDHEX$$o das linhas
		// das DW's de detalhes
		Tab_1.TabPage_2.dw_3.Event ue_Retrieve()
		Tab_1.TabPage_2.Tab_2.tabpage2_1.dw_4.Event ue_Retrieve()
		Tab_1.TabPage_2.Tab_2.tabpage2_2.dw_6.Event ue_Retrieve()
		
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

event tab_1::selectionchanged;// OverRide
SetPointer(HourGlass!)

Choose Case NewIndex
	Case 1
		
		TabPage_1.dw_2.ivm_Menu.mf_Classificar(True)
//		TabPage_1.dw_2.ivm_Menu.mf_Filtrar(True)
		
		TabPage_1.dw_2.ivm_Menu.mf_imprimir(TabPage_1.dw_2.RowCount( ) > 0)
		TabPage_1.dw_2.ivm_Menu.mf_salvarcomo(TabPage_1.dw_2.RowCount( ) > 0)	

		This.Width  = Parent.ivl_Largura_1
		//This.Height = Parent.ivl_Altura_1
		
		Tab_1.TabPage_1.dw_2.SetFocus()		
		
	Case 2
		
		TabPage_1.dw_2.ivm_Menu.mf_Classificar(False)
//		TabPage_1.dw_2.ivm_Menu.mf_Filtrar(False)
		
		TabPage_1.dw_2.ivm_Menu.mf_Imprimir(False)
		TabPage_1.dw_2.ivm_Menu.mf_SalvarComo(False)
		
		This.Width  = Parent.ivl_Largura_2		
		//This.Height = Parent.ivl_Altura_2
		
		Tab_1.TabPage_2.dw_3.SetFocus()
		
End Choose

ivm_Menu.mf_Localizar(False)

Parent.Width  = This.Width + This.X + 80
Parent.Height = This.Height + This.Y + 168

SetPointer(Arrow!)
end event

type tabpage_1 from dc_w_2tab_consulta_selecao_lista_det`tabpage_1 within tab_1
integer width = 6464
integer height = 2360
cb_alt_dt_pagamento cb_alt_dt_pagamento
st_1 st_1
dw_5 dw_5
dw_7 dw_7
end type

on tabpage_1.create
this.cb_alt_dt_pagamento=create cb_alt_dt_pagamento
this.st_1=create st_1
this.dw_5=create dw_5
this.dw_7=create dw_7
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_alt_dt_pagamento
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.dw_5
this.Control[iCurrent+4]=this.dw_7
end on

on tabpage_1.destroy
call super::destroy
destroy(this.cb_alt_dt_pagamento)
destroy(this.st_1)
destroy(this.dw_5)
destroy(this.dw_7)
end on

type gb_2 from dc_w_2tab_consulta_selecao_lista_det`gb_2 within tabpage_1
integer x = 14
integer y = 608
integer width = 6423
integer height = 1744
string text = "Lista de Vendas"
end type

type gb_1 from dc_w_2tab_consulta_selecao_lista_det`gb_1 within tabpage_1
integer x = 14
integer y = 0
integer width = 3945
integer height = 608
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
end type

type dw_1 from dc_w_2tab_consulta_selecao_lista_det`dw_1 within tabpage_1
integer x = 32
integer y = 52
integer width = 3918
integer height = 544
string dataobject = "dw_ge273_selecao"
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

event dw_1::ue_key;String lvs_Coluna

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

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Filial) Then
	This.Object.Nm_Fantasia[1] = ivo_Filial.Nm_Fantasia			
End If
				
If IsValid(ivo_Prod) Then
	This.Object.nm_produto	[1] = ivo_Prod.ivs_descricao_apresentacao_venda	
End If
end event

type dw_2 from dc_w_2tab_consulta_selecao_lista_det`dw_2 within tabpage_1
integer x = 32
integer y = 672
integer width = 6382
integer height = 1660
string dataobject = "dw_ge273_lista"
boolean hscrollbar = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;Date	lvdt_Inicio, &
    		lvdt_Termino, &
		lvdt_Pagamento

Long	lvl_Filial
Long	lvl_Convenio
Long	lvl_Conv_Eph
Long	lvl_Nr_Nf
Long	lvl_Nr_Lote
Long	lvl_Nr_Cupom
Long	lvl_Prod
Long 	lvl_AppendWhere_ID = 5

String lvs_Tipo_Venda
String lvs_Devolucao
String lvs_Conv_Vdk
String lvs_Conv_Phs
String lvs_Conv_Trn
String lvs_Conv_Fun
String lvs_Datasus
String lvs_Autorizacao
String	lvs_Id_Status_Sitef
String lvs_Nr_Cartao
String lvs_Id_PBM
String lvs_SQL
String lvs_Eph_Benef
String	lvs_Id_N$$HEX1$$e300$$ENDHEX$$o_Pagas
String	lvs_Situacao


Parent.dw_1.AcceptText()
This.SetFilter("")

lvl_Filial					= Parent.dw_1.Object.Cd_Filial				[1]
lvdt_Inicio				= Parent.dw_1.Object.Dt_Inicio				[1]
lvdt_Termino			= Parent.dw_1.Object.Dt_Termino			[1]
lvl_Convenio				= Parent.dw_1.Object.Cd_Convenio		[1]
lvs_Tipo_Venda		= Parent.dw_1.Object.id_tipo_venda		[1]
lvs_Devolucao			= Parent.dw_1.Object.id_devolucao		[1]
lvs_Conv_Vdk			= Parent.dw_1.Object.cd_convenio_vdk	[1]
lvl_Conv_Eph			= Parent.dw_1.Object.cd_convenio_eph	[1]
lvs_Eph_Benef			= Parent.dw_1.Object.cd_convenio_benef[1]
lvs_Conv_Phs			= Parent.dw_1.Object.cd_convenio_phs	[1]
lvs_Conv_Trn			= Parent.dw_1.Object.cd_convenio_trn	[1]
lvs_Conv_Fun			= Parent.dw_1.Object.cd_convenio_fun	[1]
lvs_Autorizacao			= Parent.dw_1.Object.nr_autorizacao		[1]	
lvl_Nr_Nf					= Parent.dw_1.Object.nr_nf					[1]
lvs_Datasus				= Parent.dw_1.Object.nr_autorizacao_datasus	[1]	
lvs_Id_Status_Sitef 	= Parent.dw_1.Object.id_status_sitef		[1]	
lvs_Nr_Cartao 			= Parent.dw_1.Object.nr_cartao			[1]	
lvdt_Pagamento		= Parent.dw_1.Object.dh_pagamento		[1]	
lvs_Id_PBM				= Parent.dw_1.Object.id_pbm				[1]
lvl_Nr_Lote				= Parent.dw_1.Object.Nr_Lote				[1]
lvs_Id_N$$HEX1$$e300$$ENDHEX$$o_Pagas		= Parent.dw_1.Object.Id_Nao_Pagas		[1]
lvl_Nr_Cupom			= Parent.dw_1.Object.Nr_Cupom			[1]
lvs_Situacao				= Parent.dw_1.Object.id_situacao			[1]
lvl_Prod					= Parent.dw_1.Object.cd_produto			[1]

If (lvl_Filial>0) and (Not IsNull(lvl_Filial)) Then
	This.of_AppendWhere_SubQuery("vp.cd_filial = " +  String(lvl_Filial), lvl_AppendWhere_ID)
	dw_7.of_AppendWhere_SubQuery("vp.cd_filial = " +  String(lvl_Filial), lvl_AppendWhere_ID)
	
	lvs_SQL = This.GetSQLSelect()
	lvs_SQL = gf_replace(lvs_SQL, 'idx_data_convenio','idx_fil_dt_conv',0)
	This.SetSQLSelect(lvs_SQL)
End If

If (lvl_Nr_Nf>0) and (Not IsNull(lvl_Nr_Nf)) Then
	This.of_AppendWhere_SubQuery("vp.nr_nf = " +  String(lvl_Nr_Nf), lvl_AppendWhere_ID)
	This.of_AppendWhere_SubQuery("vp.nr_nf = " +  String(lvl_Nr_Nf), lvl_AppendWhere_ID)
	
	dw_7.of_AppendWhere_SubQuery("vp.nr_nf = " +  String(lvl_Nr_Nf), lvl_AppendWhere_ID)
	dw_7.of_AppendWhere_SubQuery("vp.nr_nf = " +  String(lvl_Nr_Nf), lvl_AppendWhere_ID)
End If

If (lvl_Nr_Cupom>0) and (Not IsNull(lvl_Nr_Cupom)) Then
	This.of_AppendWhere_SubQuery("vp.nr_cupom= '" +  String(lvl_Nr_Cupom) + "'", lvl_AppendWhere_ID)
	
	dw_7.of_AppendWhere_SubQuery("vp.nr_cupom= '" +  String(lvl_Nr_Cupom) + "'", lvl_AppendWhere_ID)
End If

If lvs_Tipo_Venda <> "TD" Then
	If lvs_Tipo_Venda = "AV" Then
		This.of_AppendWhere_SubQuery("nf.id_tipo_venda in('AV', 'CV')", lvl_AppendWhere_ID)
		dw_7.of_AppendWhere_SubQuery("nf.id_tipo_venda in('AV', 'CV')", lvl_AppendWhere_ID)
	Else
		This.of_AppendWhere_SubQuery("nf.id_tipo_venda = '" + lvs_Tipo_Venda + "'", lvl_AppendWhere_ID)
		dw_7.of_AppendWhere_SubQuery("nf.id_tipo_venda = '" + lvs_Tipo_Venda + "'", lvl_AppendWhere_ID)
	End If
End If

If IsNull(lvdt_Inicio) Then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Informe uma data de in$$HEX1$$ed00$$ENDHEX$$cio.',Exclamation!)
	Parent.dw_1.Event ue_Pos(1,'dt_inicio')
	Return -1
End If	

If IsNull(lvdt_Termino) Then 
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Informe uma data de t$$HEX1$$e900$$ENDHEX$$rmino.',Exclamation!)
	Parent.dw_1.Event ue_Pos(1,'dt_termino')
	Return -1
End If	

If Not IsNull(lvl_Convenio) and (lvl_Convenio > 0) Then
	This.of_AppendWhere_SubQuery("vp.cd_convenio = " + String(lvl_Convenio), lvl_AppendWhere_ID)
	dw_7.of_AppendWhere_SubQuery("vp.cd_convenio = " + String(lvl_Convenio), lvl_AppendWhere_ID)
End If

If lvs_Id_PBM = 'S' Then
	This.of_AppendWhere_SubQuery("nf.cd_convenio = vp.cd_convenio", lvl_AppendWhere_ID)
	dw_7.of_AppendWhere_SubQuery("nf.cd_convenio = vp.cd_convenio", lvl_AppendWhere_ID)
End If

If lvs_Devolucao = "S" Then
	This.of_AppendWhere_SubQuery(	"not exists (select d.nr_nf from nf_devolucao_venda d " + &
													"where d.cd_filial_venda = vp.cd_filial "+ &
													 "and d.nr_nf_venda = vp.nr_nf "+ &
													 "and d.de_serie_venda = vp.de_serie "+ &
													 "and d.de_especie_venda = vp.de_especie)", lvl_AppendWhere_ID)
													 
	dw_7.of_AppendWhere_SubQuery(	"not exists (select d.nr_nf from nf_devolucao_venda d " + &
													"where d.cd_filial_venda = vp.cd_filial "+ &
													 "and d.nr_nf_venda = vp.nr_nf "+ &
													 "and d.de_serie_venda = vp.de_serie "+ &
													 "and d.de_especie_venda = vp.de_especie)", lvl_AppendWhere_ID)
End If

Choose Case lvl_Convenio
	Case 52349
		If Not IsNull(lvs_Conv_Fun) and (lvs_Conv_Fun<>'TD') Then 
			This.of_AppendWhere_SubQuery("vp.cd_convenio_pbm = '" + lvs_Conv_Fun+"'", lvl_AppendWhere_ID)
			dw_7.of_AppendWhere_SubQuery("vp.cd_convenio_pbm = '" + lvs_Conv_Fun+"'", lvl_AppendWhere_ID)
		end if
	Case 52568
		If Not IsNull(lvs_Conv_Trn) and (lvs_Conv_Trn<>'TD') Then 
			This.of_AppendWhere_SubQuery("vp.cd_convenio_pbm = '" + lvs_Conv_Trn+"'", lvl_AppendWhere_ID)
			dw_7.of_AppendWhere_SubQuery("vp.cd_convenio_pbm = '" + lvs_Conv_Trn+"'", lvl_AppendWhere_ID)
		end if
	Case 52575
		If Not IsNull(lvs_Conv_Vdk) and (lvs_Conv_Vdk<>'TD') Then 
			If  lvs_Conv_Vdk = 'PROGFPG' Then
				This.of_AppendWhere_SubQuery("pg.cd_conveniado not in ('AVPRA001','AVFCOPEL','AVFARPOP','AVMEDIC1','AVJANSSE','AVINVOKA','AVCOPMUC')", lvl_AppendWhere_ID)
				dw_7.of_AppendWhere_SubQuery("pg.cd_conveniado not in ('AVPRA001','AVFCOPEL','AVFARPOP','AVMEDIC1','AVJANSSE','AVINVOKA','AVCOPMUC')", lvl_AppendWhere_ID)
			ElseIf lvs_Conv_Vdk = 'AVFCOPEL' or lvs_Conv_Vdk = 'AVCOPMUC' Then
				This.of_AppendWhere_SubQuery("pg.cd_conveniado in ('AVFCOPEL','AVCOPMUC')", lvl_AppendWhere_ID)
				dw_7.of_AppendWhere_SubQuery("pg.cd_conveniado in ('AVFCOPEL','AVCOPMUC')", lvl_AppendWhere_ID)
			Else
				This.of_AppendWhere_SubQuery("vp.nr_comprovante_venda = '" +lvs_Conv_Vdk+"'", lvl_AppendWhere_ID)
				dw_7.of_AppendWhere_SubQuery("vp.nr_comprovante_venda = '" +lvs_Conv_Vdk+"'", lvl_AppendWhere_ID)
			End If			
		End If
		If Not IsNull(lvs_Datasus) and (Trim(lvs_Datasus)<>'') and (lvs_Conv_Vdk='AVFARPOP') Then 
			This.of_AppendWhere_SubQuery("vp.nr_autorizacao_datasus = '" + Mid(lvs_Datasus,1,3)+'.'+Mid(lvs_Datasus,4,3)+'.'+Mid(lvs_Datasus,7,3)+'.'+Mid(lvs_Datasus,10,3)+'.'+Mid(lvs_Datasus,13,3)+"'", lvl_AppendWhere_ID)
			dw_7.of_AppendWhere_SubQuery("vp.nr_autorizacao_datasus = '" + Mid(lvs_Datasus,1,3)+'.'+Mid(lvs_Datasus,4,3)+'.'+Mid(lvs_Datasus,7,3)+'.'+Mid(lvs_Datasus,10,3)+'.'+Mid(lvs_Datasus,13,3)+"'", lvl_AppendWhere_ID)
		end if
	Case 52718
		If Not IsNull(lvl_Conv_Eph) and (lvl_Conv_Eph>0) Then 
			This.of_AppendWhere_SubQuery("vp.cd_convenio_pbm = '" + String(lvl_Conv_Eph)+"'", lvl_AppendWhere_ID)
			dw_7.of_AppendWhere_SubQuery("vp.cd_convenio_pbm = '" + String(lvl_Conv_Eph)+"'", lvl_AppendWhere_ID)
		end if
		If Not IsNull(lvs_Eph_Benef) and (lvs_Eph_Benef<>"TD") Then 
			This.of_AppendWhere_SubQuery("ceb.cd_cliente = '" + lvs_Eph_Benef +"'", lvl_AppendWhere_ID)
			dw_7.of_AppendWhere_SubQuery("ceb.cd_cliente = '" + lvs_Eph_Benef +"'", lvl_AppendWhere_ID)
		end if
	Case 53545
		If Not IsNull(lvs_Conv_Phs) and (lvs_Conv_Phs<>'TD') Then 
			This.of_AppendWhere_SubQuery("vp.cd_convenio_pbm = '" + lvs_Conv_Phs+"'", lvl_AppendWhere_ID)
			dw_7.of_AppendWhere_SubQuery("vp.cd_convenio_pbm = '" + lvs_Conv_Phs+"'", lvl_AppendWhere_ID)
		end if
End Choose

If Not IsNull(lvs_Autorizacao) and (Trim(lvs_Autorizacao)<>'') and (Not((lvl_Convenio = 52575)and(lvs_Conv_Vdk='AVFARPOP')))Then
	If lvl_Convenio = 52718 Then
		This.of_AppendWhere_SubQuery("vp.nr_comprovante_venda = '" + lvs_Autorizacao+"'", lvl_AppendWhere_ID)
		dw_7.of_AppendWhere_SubQuery("vp.nr_comprovante_venda = '" + lvs_Autorizacao+"'", lvl_AppendWhere_ID)
	Else
		This.of_AppendWhere_SubQuery("vp.nr_autorizacao = '" + lvs_Autorizacao+"'", lvl_AppendWhere_ID)
		dw_7.of_AppendWhere_SubQuery("vp.nr_autorizacao = '" + lvs_Autorizacao+"'", lvl_AppendWhere_ID)
	End If
End If

If lvs_Id_Status_Sitef <> 'T' Then
	If lvs_Id_Status_Sitef = 'D' Then
		This.of_AppendWhere_SubQuery("coalesce(vp.id_status_sitef, '') <> 'E'", lvl_AppendWhere_ID)
		dw_7.of_AppendWhere_SubQuery("coalesce(vp.id_status_sitef, '') <> 'E'", lvl_AppendWhere_ID)
	Else
		This.of_AppendWhere_SubQuery("vp.id_status_sitef = '" + lvs_Id_Status_Sitef+"'", lvl_AppendWhere_ID)
		dw_7.of_AppendWhere_SubQuery("vp.id_status_sitef = '" + lvs_Id_Status_Sitef+"'", lvl_AppendWhere_ID)
	End If
End If

If Not IsNull(lvs_Nr_Cartao) and (lvs_Nr_Cartao<>'') Then
	This.of_AppendWhere_SubQuery("vp.nr_cartao = '" + lvs_Nr_Cartao+"'", lvl_AppendWhere_ID)
	dw_7.of_AppendWhere_SubQuery("vp.nr_cartao = '" + lvs_Nr_Cartao+"'", lvl_AppendWhere_ID)
End If

If Not IsNull(lvdt_Pagamento)  Then
	This.of_AppendWhere_SubQuery("cpp.dh_pagamento = '" + String(lvdt_Pagamento, 'yyyy/mm/dd') +"'", lvl_AppendWhere_ID)
	dw_7.of_AppendWhere_SubQuery("cpp.dh_pagamento = '" + String(lvdt_Pagamento, 'yyyy/mm/dd') +"'", lvl_AppendWhere_ID)
End If

If Not IsNull(lvl_Nr_Lote) and lvl_Nr_Lote <> 0 Then
	This.of_AppendWhere_SubQuery("vp.nr_lote_convenio = " + String(lvl_Nr_Lote), lvl_AppendWhere_ID)
	dw_7.of_AppendWhere_SubQuery("vp.nr_lote_convenio = " + String(lvl_Nr_Lote), lvl_AppendWhere_ID)
End If

If lvl_Nr_Lote = 0 Then
	This.of_AppendWhere_SubQuery("vp.nr_lote_convenio is null", lvl_AppendWhere_ID)
	dw_7.of_AppendWhere_SubQuery("vp.nr_lote_convenio is null", lvl_AppendWhere_ID)
End If

If lvs_Id_N$$HEX1$$e300$$ENDHEX$$o_Pagas = 'S' Then
	This.of_AppendWhere_SubQuery("cpp.dh_pagamento is null", lvl_AppendWhere_ID)
	dw_7.of_AppendWhere_SubQuery("cpp.dh_pagamento is null", lvl_AppendWhere_ID)
End If

Choose Case lvs_Situacao
	Case 'N'
		This.of_AppendWhere_SubQuery("nf.dh_cancelamento is null", lvl_AppendWhere_ID)
		dw_7.of_AppendWhere_SubQuery("nf.dh_cancelamento is null", lvl_AppendWhere_ID)
	Case 'C'
		This.of_AppendWhere_SubQuery("nf.dh_cancelamento is not null", lvl_AppendWhere_ID)
		dw_7.of_AppendWhere_SubQuery("nf.dh_cancelamento is not null", lvl_AppendWhere_ID)
End Choose

If lvl_Prod > 0 Then
	This.of_AppendWhere_SubQuery("vpp.cd_produto = "+String(lvl_Prod), lvl_AppendWhere_ID)
	dw_7.of_AppendWhere_SubQuery("vpp.cd_produto = "+String(lvl_Prod), lvl_AppendWhere_ID)
End If

This.SetRedraw(False)
This.Post SetRedraw(True)

Return 1
end event

event dw_2::constructor;call super::constructor;String lvs_Coluna[], &
       lvs_Nome[]
		 
Integer  lvi_ColX

/*lvs_Coluna = {	"id_conciliada",&
					"cd_filial", &
					"dh_movimentacao_caixa", &
					"pc_desconto", &
					"vl_pago_avista", &
					"vl_total_nf", &
					"vl_prev_pagto", &
					"vl_pagto", &
					"vl_subsidio", &
					"vl_taxa_administracao", &
					"dh_pagamento", &
					"nm_fantasia", &
					"cd_convenio_pbm"}

lvs_Nome = {	"Conciliada?",&
					"C$$HEX1$$f300$$ENDHEX$$digo da Filial", &
					"Data Venda", &
					"% Desc. NF", &
					"Valor Pago $$HEX1$$c000$$ENDHEX$$ Vista", &
					"Valor Total NF", &
					"Valor Previsto Pagto", &
					"Valor Pago", &
					"Valor Subs$$HEX1$$ed00$$ENDHEX$$dio", &
					"Valor Taxa Adm.", &
					"Data Pagto", &
					"Nome Conv$$HEX1$$ea00$$ENDHEX$$nio", &
					"Programa PBM"}

This.of_SetSort(lvs_Coluna, lvs_Nome)
This.of_SetFilter(lvs_Coluna, lvs_Nome)*/
This.Of_SetRowselection("", "~tIf ( Not IsNull( dh_cancelamento ) , rgb(255,0,0) , 0 )")

This.ivb_Ordena_Colunas = True

This.ShareData(Parent.dw_5)
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;Long 	lvl_Row
Long 	lvl_Filial
Long 	lvl_NF

String lvs_Especie
String lvs_Serie

Decimal{2} lvdc_Pago_Avista
Decimal{2} lvdc_Total_NF

This.SetReDraw(False)
Choose Case Parent.dw_1.Object.id_tipo_venda[1]
	Case 'AV'
		This.SetFilter("vl_prev_pagto = 0 or vl_prev_pagto_pbm = 0")
		This.Filter()
	Case 'CV'
		This.SetFilter("vl_prev_pagto > 0")
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

/* Comentado. Se um dia usar isso descomentar.
cb_alt_dt_pagamento.Enabled = (This.Find("(cd_convenio = 52349 or cd_convenio = 52575 or cd_convenio = 53724 or cd_convenio = 53725 or cd_convenio = 52718) and (nr_lote_convenio=0 or IsNull(nr_lote_convenio))", 1, pl_linhas) > 0)

If pl_Linhas > 0 Then	

	This.SetReDraw(False)
	This.SetFilter("cd_convenio_venda = 51014 or cd_convenio_venda = 53847")
	This.Filter()
	For lvl_Row = 1 To This.RowCount()
		
		lvl_Filial			= This.Object.cd_filial			[lvl_Row]
		lvl_NF				= This.Object.nr_nf			[lvl_Row]
		lvs_Especie		= This.Object.de_especie	[lvl_Row]
		lvs_Serie			= This.Object.de_serie		[lvl_Row]
		lvdc_Total_NF	= This.Object.vl_total_nf		[lvl_Row]
		
		Select max(na.vl_pago_avista_de)
		Into :lvdc_Pago_Avista
		from nf_venda_alteracao na
		Where na.cd_filial			=	:lvl_Filial
			and na.nr_nf			=	:lvl_NF
			and na.de_serie		=	:lvs_Serie
			and na.de_especie		=	:lvs_Especie
			and na.dh_alteracao	= (select min(na1.dh_alteracao)
											from nf_venda_alteracao na1
											Where na.cd_filial			= na1.cd_filial
												and na.nr_nf			= na1.nr_nf
												and na.de_serie		= na1.de_serie
												and na.de_especie		= na1.de_especie	)
		Using SQLCa;
		
		If SQLCa.SQLCode = -1 Then
			SQLCa.of_msgdberror( "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do pagamento $$HEX1$$e000$$ENDHEX$$ vista original." )
		Else
			This.Object.vl_pago_avista	[lvl_Row] = lvdc_Pago_Avista
			This.Object.vl_prev_pagto	[lvl_Row] = lvdc_Total_NF - lvdc_Pago_Avista
		End If
	Next	
	This.SetFilter("")
	This.Filter()
	This.SetReDraw(True)

End If
*/

Return AncestorReturnValue
end event

event dw_2::ue_reset;call super::ue_reset;ivo_controle_menu.of_salvarcomo(False)
ivo_controle_menu.of_imprimir(False)
end event

event dw_2::rowfocuschanged;call super::rowfocuschanged;This.ivm_menu.mf_salvarcomo(This.RowCount() > 0)

Return AncestorReturnValue
end event

event dw_2::ue_saveas;//override
dw_5.Event ue_SaveAs()
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

event dw_2::ue_key;call super::ue_key;If Key = KeyF5! Then
	If dw_2.RowCount() > 0 Then
		
		Long 	lvl_Linha, &
				lvl_Seq, &
				lvl_Filial, &
				lvl_Nr_Nf, &
				lvl_Convenio, &
				lvl_Nr_Lote
		
		Date	lvdt_Pagamento, &
				lvdt_Movimento
				
		String lvs_Especie, &
				lvs_Serie
		
		dw_2.AcceptText()
		
		lvl_Linha 				= dw_2.GetRow() + 1
		lvl_Convenio			= Tab_1.TabPage_1.dw_1.Object.Cd_Convenio[1]
		lvdt_Pagamento 	= Date(Tab_1.TabPage_1.dw_2.Object.Dh_Pagamento[dw_2.GetRow()])
		
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Deseja alterar a data de pagamento das transa$$HEX2$$e700f500$$ENDHEX$$es abaixo da linha atual?", Question!, YesNo!, 2) = 0 Then Return
		
		If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("ALTERAR_DT_PAGAMENTO_CV_PBM", gvo_Aplicacao.ivo_Seguranca.nr_Matricula) Then Return		

		For lvl_Seq = lvl_Linha To dw_2.RowCount()
			
			lvl_Filial				= This.Object.Cd_Filial								[lvl_Seq]
			lvl_Nr_Nf				= This.Object.Nr_Nf									[lvl_Seq]
			lvs_Especie			= This.Object.De_Especie							[lvl_Seq]
			lvs_Serie				= This.Object.De_Serie								[lvl_Seq]
			lvl_Nr_Lote			= This.Object.Nr_Lote_Convenio					[lvl_Seq]
			lvdt_Movimento		= Date(This.Object.Dh_Movimentacao_Caixa	[lvl_Seq])
						
			If lvl_Nr_Lote = 0 and lvdt_Pagamento > lvdt_Movimento Then
				If Wf_Altera_Dt_Pagamento(lvl_Convenio, lvl_Filial, lvl_Nr_Nf, lvs_Especie, lvs_Serie, DateTime(lvdt_Pagamento)) Then
					Tab_1.TabPage_1.dw_2.Object.Dh_Pagamento[lvl_Seq] = lvdt_Pagamento
				End If
			End If
		Next			
	End If
End If
end event

type tabpage_2 from dc_w_2tab_consulta_selecao_lista_det`tabpage_2 within tab_1
integer width = 6464
integer height = 2360
tab_2 tab_2
end type

on tabpage_2.create
this.tab_2=create tab_2
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_2
end on

on tabpage_2.destroy
call super::destroy
destroy(this.tab_2)
end on

type gb_3 from dc_w_2tab_consulta_selecao_lista_det`gb_3 within tabpage_2
integer x = 14
integer y = 8
integer width = 6327
integer height = 728
long backcolor = 80269524
string text = "Detalhes da Venda"
end type

type dw_3 from dc_w_2tab_consulta_selecao_lista_det`dw_3 within tabpage_2
integer x = 37
integer y = 60
integer width = 6290
integer height = 656
string dataobject = "dw_ge273_detalhe_nota"
end type

event dw_3::ue_recuperar;// OverRide

Long 		lvl_Linha, &
     		lvl_Filial, &
     		lvl_Doc, &
			lvl_nr_Sequencial_PBM
	  
String	lvl_Especie,&
			lvl_Serie
	  
lvl_Linha = Tab_1.TabPage_1.dw_2.GetRow()

lvl_Filial  = Tab_1.TabPage_1.dw_2.Object.Cd_Filial [lvl_Linha]
lvl_Doc	   = Tab_1.TabPage_1.dw_2.Object.Nr_Nf		 [lvl_Linha]
lvl_Especie = Tab_1.TabPage_1.dw_2.Object.De_Especie[lvl_Linha]
lvl_Serie   = Tab_1.TabPage_1.dw_2.Object.De_Serie  [lvl_Linha]
lvl_nr_Sequencial_PBM = Tab_1.TabPage_1.dw_2.Object.nr_Sequencial_PBM[lvl_Linha]

Return This.Retrieve(lvl_Filial, lvl_Doc, lvl_Especie, lvl_Serie, lvl_nr_Sequencial_PBM)
end event

event dw_3::getfocus;//OverRide
This.ivm_Menu.mf_Classificar(True)
//This.ivm_Menu.mf_Filtrar(True)
This.ivm_Menu.mf_Localizar(False)
This.ivm_Menu.mf_Recuperar(False)
end event

event dw_3::ue_postretrieve;call super::ue_postretrieve;Long lvl_Convenio
Long lvl_Filial
Long lvl_NF

String lvs_Serie
String lvs_Especie

Decimal{2} lvdc_Pago_Avista

If pl_linhas > 0 Then
	
	lvl_Convenio	= This.Object.cd_convenio_venda	[1]
	
	If lvl_Convenio = 51014 or lvl_Convenio = 53847 Then
		lvl_Filial		= This.Object.cd_filial			[1]
		lvl_NF			= This.Object.nr_nf			[1]
		lvs_Serie		= This.Object.de_serie		[1]
		lvs_Especie	= This.Object.de_especie	[1]
		
		Select max(na.vl_pago_avista_de)
		Into :lvdc_Pago_Avista
		from nf_venda_alteracao na
		Where na.cd_filial			=	:lvl_Filial
			and na.nr_nf			=	:lvl_NF
			and na.de_serie		=	:lvs_Serie
			and na.de_especie		=	:lvs_Especie
			and na.dh_alteracao	= (select min(na1.dh_alteracao)
											from nf_venda_alteracao na1
											Where na.cd_filial			= na1.cd_filial
												and na.nr_nf			= na1.nr_nf
												and na.de_serie		= na1.de_serie
												and na.de_especie		= na1.de_especie	)
		Using SQLCa;
		
		If SQLCa.SQLCode = -1 Then
			SQLCa.of_msgdberror( "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do pagamento $$HEX1$$e000$$ENDHEX$$ vista original." )
		Else	
			If IsNull(lvdc_Pago_Avista) Then lvdc_Pago_Avista = 0.00
		
			This.Object.vl_pago_avista [1] = lvdc_Pago_Avista
		End If
	End If
End If

Return AncestorReturnValue
end event

type cb_alt_dt_pagamento from commandbutton within tabpage_1
integer x = 4014
integer y = 448
integer width = 686
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Alterar Data Pagamento"
end type

event clicked;Long	lvl_Filial, &
		lvl_Nr_Nf, &
		lvl_Row, &
		lvl_Convenio, &
		lvl_Nr_Lote

Date	lvdt_Movimento, &
		lvdt_Pagamento, &
		lvdt_Pagamento_Alterado
		
DateTime lvdth_Pagamento
		
String lvs_Parametro, &
		lvs_Retorno, &
		lvs_Especie, &
		lvs_Serie, &
		lvs_Conciliada
		
lvl_Row				= Parent.dw_2.GetRow()
lvl_Convenio			= Parent.dw_2.Object.Cd_Convenio	[lvl_Row]
lvl_Filial				= Parent.dw_2.Object.Cd_Filial			[lvl_Row]
lvl_Nr_Nf				= Parent.dw_2.Object.Nr_Nf			[lvl_Row]
lvs_Especie			= Parent.dw_2.Object.De_Especie		[lvl_Row]
lvs_Serie				= Parent.dw_2.Object.De_Serie		[lvl_Row]
lvs_Conciliada		= Parent.dw_2.Object.id_conciliada	[lvl_Row]	
lvdt_Movimento		= Date(Parent.dw_2.Object.Dh_Movimentacao_Caixa[lvl_Row])
lvdt_Pagamento 	= Date(Parent.dw_2.Object.Dh_Pagamento[lvl_Row])
lvl_Nr_Lote			= Parent.dw_2.Object.Nr_Lote_Convenio[lvl_Row]

If lvl_Nr_Lote > 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitido a altera$$HEX2$$e700e300$$ENDHEX$$o da data de pagamento. Nota j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ em lote.", Exclamation!)
	Return
End If

If (IsNull(lvs_Conciliada) or (lvs_Conciliada <> 'S')) Then
	If  MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","A venda "+String(lvl_Nr_Nf)+" n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ conciliada.~r"+ &
						"Para alterar a data do pagamento o sistema ir$$HEX1$$e100$$ENDHEX$$ criar um registro de concilia$$HEX2$$e700e300$$ENDHEX$$o manual.~r~r"+ &
						"Deseja continuar com a altera$$HEX2$$e700e300$$ENDHEX$$o de data de pagamento?", Question!, Yesno!, 2) = 2 Then
		Return
	End If
End If

If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("ALTERAR_DT_PAGAMENTO_CV_PBM", gvo_Aplicacao.ivo_Seguranca.nr_Matricula) Then Return

lvs_Parametro = String(lvdt_Movimento, "YYYY/MM/DD") + "@#!" + String(lvdt_Pagamento, "YYYY/MM/DD")

OpenWithParm(w_ge273_data_pagamento, lvs_Parametro)

lvs_Retorno = Message.StringParm

If IsNull(lvs_Retorno) Then Return

lvdt_Pagamento_Alterado = Date(lvs_Retorno)

Tab_1.TabPage_1.dw_2.Object.Dh_Pagamento[lvl_Row] = lvdt_Pagamento_Alterado

lvdth_Pagamento = DateTime(lvdt_Pagamento_Alterado)

If Not Wf_Altera_Dt_Pagamento(lvl_Convenio, lvl_Filial, lvl_Nr_Nf, lvs_Especie, lvs_Serie, lvdth_Pagamento) Then Return
end event

type st_1 from statictext within tabpage_1
integer x = 4078
integer y = 548
integer width = 581
integer height = 56
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "F5 - Replica Data Pagto"
boolean focusrectangle = false
end type

type dw_5 from dc_uo_dw_base within tabpage_1
integer x = 4526
integer y = 28
integer width = 1221
integer height = 476
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge273_relatorio"
boolean border = true
borderstyle borderstyle = styleraised!
end type

event constructor;call super::constructor;This.Visible = False
end event

event ue_preprint;call super::ue_preprint;Date	lvdt_Inicio, &
    		lvdt_Termino

Long	lvl_Filial

String	lvs_Filial

Parent.dw_1.AcceptText()

lvl_Filial			= Parent.dw_1.Object.Cd_Filial			[1]
lvs_Filial			= Parent.dw_1.Object.Nm_Fantasia	[1]
lvdt_Inicio		= Parent.dw_1.Object.Dt_Inicio			[1]
lvdt_Termino	= Parent.dw_1.Object.Dt_Termino		[1]

If IsNull(lvl_Filial) Then
	This.Object.st_filial.text	= 'TODAS'
Else
	This.Object.st_filial.text	= lvs_Filial + ' (' + String(lvl_Filial) + ')'
End If	
	
This.Object.st_periodo.text		= String(lvdt_Inicio,'dd/mm/yyyy') + ' $$HEX1$$e000$$ENDHEX$$ ' + String(lvdt_Termino,'dd/mm/yyyy')
This.Object.st_convenio.text		= Parent.dw_1.Describe("Evaluate('LookUpDisplay(cd_convenio)',1)")
This.Object.st_tipo_venda.text	= Parent.dw_1.Describe("Evaluate('LookUpDisplay(id_tipo_venda)',1)")

Return AncestorReturnValue
end event

type dw_7 from dc_uo_dw_base within tabpage_1
boolean visible = false
integer x = 3968
integer y = 72
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge273_relatorio_produto"
end type

type tab_2 from tab within tabpage_2
event create ( )
event destroy ( )
integer x = 18
integer y = 776
integer width = 6331
integer height = 872
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long backcolor = 67108864
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage2_1 tabpage2_1
tabpage2_2 tabpage2_2
end type

on tab_2.create
this.tabpage2_1=create tabpage2_1
this.tabpage2_2=create tabpage2_2
this.Control[]={this.tabpage2_1,&
this.tabpage2_2}
end on

on tab_2.destroy
destroy(this.tabpage2_1)
destroy(this.tabpage2_2)
end on

type tabpage2_1 from userobject within tab_2
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 6295
integer height = 756
long backcolor = 67108864
string text = "Itens NF"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
gb_4 gb_4
dw_4 dw_4
end type

on tabpage2_1.create
this.gb_4=create gb_4
this.dw_4=create dw_4
this.Control[]={this.gb_4,&
this.dw_4}
end on

on tabpage2_1.destroy
destroy(this.gb_4)
destroy(this.dw_4)
end on

type gb_4 from groupbox within tabpage2_1
integer x = 14
integer y = 8
integer width = 6249
integer height = 736
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
string text = "Itens da Venda"
borderstyle borderstyle = styleraised!
end type

type dw_4 from dc_uo_dw_base within tabpage2_1
integer x = 37
integer y = 68
integer width = 6222
integer height = 656
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_ge273_detalhe_itens"
boolean hscrollbar = true
end type

event ue_recuperar;// OverRide

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
//lvl_nr_Sequencial_PBM = Tab_1.TabPage_1.dw_2.Object.nr_Sequencial_PBM[lvl_Linha]

Return This.Retrieve(lvl_Filial, lvl_Doc, lvl_Especie, lvl_Serie)//, lvl_nr_Sequencial_PBM)
end event

event constructor;call super::constructor;This.of_SetRowSelection()
end event

type tabpage2_2 from userobject within tab_2
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 6295
integer height = 756
long backcolor = 67108864
string text = "Devolu$$HEX2$$e700f500$$ENDHEX$$es de Venda"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
gb_5 gb_5
dw_6 dw_6
end type

on tabpage2_2.create
this.gb_5=create gb_5
this.dw_6=create dw_6
this.Control[]={this.gb_5,&
this.dw_6}
end on

on tabpage2_2.destroy
destroy(this.gb_5)
destroy(this.dw_6)
end on

type gb_5 from groupbox within tabpage2_2
integer x = 14
integer y = 8
integer width = 4882
integer height = 736
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Devolu$$HEX2$$e700f500$$ENDHEX$$es de Venda"
end type

type dw_6 from dc_uo_dw_base within tabpage2_2
integer x = 37
integer y = 68
integer width = 4855
integer height = 656
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_ge273_lista_devolucao"
end type

event constructor;call super::constructor;This.Of_SetRowSelection( )
end event

event ue_recuperar;// OverRide

Long 		lvl_Linha, &
     		lvl_Filial, &
     		lvl_Doc
	  
String	lvl_Especie,&
			lvl_Serie
	  
lvl_Linha = Tab_1.TabPage_1.dw_2.GetRow()

lvl_Filial		= Tab_1.TabPage_1.dw_2.Object.Cd_Filial		[lvl_Linha]
lvl_Doc		= Tab_1.TabPage_1.dw_2.Object.Nr_Nf			[lvl_Linha]
lvl_Especie	= Tab_1.TabPage_1.dw_2.Object.De_Especie	[lvl_Linha]
lvl_Serie		= Tab_1.TabPage_1.dw_2.Object.De_Serie		[lvl_Linha]

Return This.Retrieve(lvl_Filial, lvl_Doc, lvl_Especie, lvl_Serie)
end event

