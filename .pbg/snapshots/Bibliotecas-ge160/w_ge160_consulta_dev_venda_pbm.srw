HA$PBExportHeader$w_ge160_consulta_dev_venda_pbm.srw
forward
global type w_ge160_consulta_dev_venda_pbm from dc_w_2tab_consulta_selecao_lista_det
end type
type dw_5 from dc_uo_dw_base within tabpage_1
end type
type gb_4 from groupbox within tabpage_2
end type
type dw_4 from dc_uo_dw_base within tabpage_2
end type
end forward

global type w_ge160_consulta_dev_venda_pbm from dc_w_2tab_consulta_selecao_lista_det
string tag = "w_ge160_consulta_venda_pbm"
integer width = 4992
integer height = 2656
string title = "GE160 - Relat$$HEX1$$f300$$ENDHEX$$rio de Devolu$$HEX2$$e700f500$$ENDHEX$$es de Vendas Conv$$HEX1$$ea00$$ENDHEX$$nio - PBM"
boolean resizable = false
long backcolor = 80269524
end type
global w_ge160_consulta_dev_venda_pbm w_ge160_consulta_dev_venda_pbm

type variables
uo_filial ivo_filial

end variables

forward prototypes
public subroutine wf_exporta_pedido ()
public subroutine wf_localiza_filial ()
public subroutine wf_insere_padrao ()
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

on w_ge160_consulta_dev_venda_pbm.create
int iCurrent
call super::create
end on

on w_ge160_consulta_dev_venda_pbm.destroy
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
ivl_Largura_1 = 4500
ivl_Altura_1  = 2500

// Detalhes
ivl_Largura_2 = 4985
ivl_Altura_2  = 1550

ivo_Filial = Create uo_Filial
end event

event close;call super::close;Destroy ivo_Filial
end event

event ue_printimmediate;Tab_1.TabPage_1.dw_5.Event ue_PrintImmediate()
end event

event ue_print;call super::ue_print;Tab_1.TabPage_1.dw_5.Event ue_Print()
end event

event ue_saveas;call super::ue_saveas;Tab_1.TabPage_1.dw_5.Event ue_SaveAs()
end event

type dw_visual from dc_w_2tab_consulta_selecao_lista_det`dw_visual within w_ge160_consulta_dev_venda_pbm
end type

type gb_aux_visual from dc_w_2tab_consulta_selecao_lista_det`gb_aux_visual within w_ge160_consulta_dev_venda_pbm
end type

type tab_1 from dc_w_2tab_consulta_selecao_lista_det`tab_1 within w_ge160_consulta_dev_venda_pbm
integer x = 5
integer width = 4965
integer height = 2476
end type

event tab_1::selectionchanging;//OverRide

SetPointer(HourGlass!)

If NewIndex = 2 Then
	If Tab_1.TabPage_1.dw_2.GetRow() > 0 Then
		// Executa o evento de recupera$$HEX2$$e700e300$$ENDHEX$$o das linhas
		// das DW's de detalhes
		Tab_1.TabPage_2.dw_4.Event ue_Retrieve()
		Tab_1.TabPage_2.dw_3.Event ue_Retrieve()
		
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
		TabPage_1.dw_2.ivm_Menu.mf_Filtrar(True)
		
		TabPage_1.dw_2.ivm_Menu.mf_imprimir(TabPage_1.dw_2.RowCount( ) > 0)
		TabPage_1.dw_2.ivm_Menu.mf_salvarcomo(TabPage_1.dw_2.RowCount( ) > 0)	

		This.Width  = Parent.ivl_Largura_1
		This.Height = Parent.ivl_Altura_1
		
		Tab_1.TabPage_1.dw_2.SetFocus()		
		
	Case 2
		
		TabPage_1.dw_2.ivm_Menu.mf_Classificar(False)
		TabPage_1.dw_2.ivm_Menu.mf_Filtrar(False)
		
		TabPage_1.dw_2.ivm_Menu.mf_Imprimir(False)
		TabPage_1.dw_2.ivm_Menu.mf_SalvarComo(False)
		
		This.Width  = Parent.ivl_Largura_2		
		This.Height = Parent.ivl_Altura_2
		
		Tab_1.TabPage_2.dw_3.SetFocus()
		
End Choose

ivm_Menu.mf_Localizar(False)

Parent.Width  = This.Width + This.X + 50
Parent.Height = This.Height + This.Y + 120


SetPointer(Arrow!)
end event

type tabpage_1 from dc_w_2tab_consulta_selecao_lista_det`tabpage_1 within tab_1
integer width = 4928
integer height = 2360
dw_5 dw_5
end type

on tabpage_1.create
this.dw_5=create dw_5
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_5
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_5)
end on

type gb_2 from dc_w_2tab_consulta_selecao_lista_det`gb_2 within tabpage_1
integer x = 14
integer y = 576
integer width = 4416
integer height = 1776
string text = "Lista de Vendas"
end type

type gb_1 from dc_w_2tab_consulta_selecao_lista_det`gb_1 within tabpage_1
integer x = 14
integer y = 0
integer width = 3127
integer height = 568
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
end type

type dw_1 from dc_w_2tab_consulta_selecao_lista_det`dw_1 within tabpage_1
integer x = 32
integer y = 52
integer width = 3086
integer height = 508
string dataobject = "dw_ge160_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;Long lvl_Nulo

If dwo.Name = "nm_fantasia" Then
	
	SetNull(lvl_Nulo)
	
	If Data = "" Or IsNull(Data) Then
			This.Object.Cd_Filial[1] = lvl_nulo
			Return 0
		End If	
		
	If Data <> ivo_Filial.Nm_Fantasia Then Return 1
End if

end event

event dw_1::ue_key;String lvs_Coluna

If Key = KeyEnter! Then
	
	lvs_Coluna = This.GetColumnName()
	
	If lvs_Coluna = 'nm_fantasia' Then
		
		wf_Localiza_Filial()
		
	End If
End If
	
end event

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)
end event

type dw_2 from dc_w_2tab_consulta_selecao_lista_det`dw_2 within tabpage_1
integer x = 32
integer y = 640
integer width = 4375
integer height = 1692
string dataobject = "dw_ge160_lista"
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

String lvs_Tipo_Venda
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
String	lvs_Id_Pagas

Parent.dw_1.AcceptText()

lvl_Filial					= Parent.dw_1.Object.Cd_Filial				[1]
lvdt_Inicio				= Parent.dw_1.Object.Dt_Inicio				[1]
lvdt_Termino			= Parent.dw_1.Object.Dt_Termino			[1]
lvl_Convenio				= Parent.dw_1.Object.Cd_Convenio		[1]
lvs_Tipo_Venda		= Parent.dw_1.Object.id_tipo_venda		[1]
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
lvs_Id_Pagas			= Parent.dw_1.Object.Id_Pagas			[1]

If (lvl_Filial>0) and (Not IsNull(lvl_Filial)) Then
	This.of_AppendWhere("nf.cd_filial = " +  String(lvl_Filial))
End If

If (lvl_Nr_Nf>0) and (Not IsNull(lvl_Nr_Nf)) Then
	This.of_AppendWhere("nf.nr_nf = " +  String(lvl_Nr_Nf))
End If

If lvs_Tipo_Venda <> "TD" Then
	This.of_AppendWhere("v.id_tipo_venda = '" + lvs_Tipo_Venda + "'")	
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
	This.of_AppendWhere("vp.cd_convenio = " + String(lvl_Convenio) )
End If

Choose Case lvl_Convenio
	Case 52349
		If Not IsNull(lvs_Conv_Fun) and (lvs_Conv_Fun<>'TD') Then This.of_AppendWhere("vp.cd_convenio_pbm = '" + lvs_Conv_Fun+"'")	
	Case 52568
		If Not IsNull(lvs_Conv_Trn) and (lvs_Conv_Trn<>'TD') Then This.of_AppendWhere("vp.cd_convenio_pbm = '" + lvs_Conv_Trn+"'")	
	Case 52575, 53724, 53725
		If Not IsNull(lvs_Conv_Vdk) and (lvs_Conv_Vdk<>'TD') Then
			If  lvs_Conv_Vdk = 'PROGFPG' Then
				This.of_AppendWhere("pg.cd_conveniado not in ('AVPRA001','AVFCOPEL','AVFARPOP','AVMEDIC1','AVJANSSE','AVINVOKA')")
			Else
				This.of_AppendWhere("vp.nr_comprovante_venda = '" +lvs_Conv_Vdk+"'")	
			End If
		End If		
		If Not IsNull(lvs_Datasus) and (lvs_Datasus<>'') and (lvs_Conv_Vdk='AVFARPOP') Then This.of_AppendWhere("vp.nr_autorizacao_datasus = '" + Mid(lvs_Datasus,1,3)+'.'+Mid(lvs_Datasus,4,3)+'.'+Mid(lvs_Datasus,7,3)+'.'+Mid(lvs_Datasus,10,3)+'.'+Mid(lvs_Datasus,13,3)+"'")
	Case 52718
		If Not IsNull(lvl_Conv_Eph) and (lvl_Conv_Eph>0) Then This.of_AppendWhere("vp.cd_convenio_pbm = '" + String(lvl_Conv_Eph)+"'")	
		If Not IsNull(lvs_Eph_Benef) and (lvs_Eph_Benef<>"TD") Then This.of_AppendWhere("ceb.cd_cliente = '" + lvs_Eph_Benef +"'")
	Case 53545
		If Not IsNull(lvs_Conv_Phs) and (lvs_Conv_Phs<>'TD') Then This.of_AppendWhere("vp.cd_convenio_pbm = '" + lvs_Conv_Phs+"'")	
End Choose

If Not IsNull(lvs_Autorizacao) and (lvs_Autorizacao<>'') and (Not((lvl_Convenio = 52575)and(lvs_Conv_Vdk='AVFARPOP')))Then
	If lvl_Convenio = 52718 Then
		This.of_AppendWhere("vp.nr_comprovante_venda = '" + lvs_Autorizacao+"'")	
	Else
		This.of_AppendWhere("vp.nr_autorizacao = '" + lvs_Autorizacao+"'")	
	End If
End If

If lvs_Id_Status_Sitef <> 'T' Then
	If lvs_Id_Status_Sitef = 'D' Then
		This.of_AppendWhere("coalesce(vp.id_status_sitef, '') <> 'E'")
	Else
		This.of_AppendWhere("vp.id_status_sitef = '" + lvs_Id_Status_Sitef+"'")	
	End If
End If

If Not IsNull(lvs_Nr_Cartao) and (lvs_Nr_Cartao<>'') Then
	This.of_AppendWhere("vp.nr_cartao = '" + lvs_Nr_Cartao+"'")	
End If

If Not IsNull(lvdt_Pagamento)  Then
	This.of_AppendWhere("cpp.dh_pagamento = '" + String(lvdt_Pagamento, 'yyyy/mm/dd') +"'")	
End If

If lvl_Nr_Lote > 0 and (Not IsNull(lvl_Nr_Lote)) Then
	This.of_AppendWhere("vp.nr_lote_convenio = " + String(lvl_Nr_Lote))
End If

If lvs_Id_Pagas = 'S' Then
	This.of_AppendWhere("cpp.dh_pagamento is not null")
End If

Return 1
end event

event dw_2::constructor;call super::constructor;String lvs_Coluna[], &
       lvs_Nome[]
		 
Integer  lvi_ColX

lvs_Coluna = {	"id_conciliada",&
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
This.of_SetFilter(lvs_Coluna, lvs_Nome)

This.ivb_Ordena_Colunas = True

This.ShareData(Parent.dw_5)
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;This.ivo_controle_menu.of_salvarcomo(pl_linhas > 0)
This.ivo_controle_menu.of_imprimir(pl_linhas > 0)

If pl_Linhas > 0 Then	
	
	Long 	lvl_Convenio, &
			lvl_Row, &
			lvl_Nr_Lote
	
	For lvl_Row = 1 To This.RowCount()
		
		lvl_Convenio 	= This.Object.Cd_Convenio[lvl_Row]
		lvl_Nr_Lote		= This.Object.Nr_Lote_Convenio[lvl_Row]
		
	Next	

End If

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

type tabpage_2 from dc_w_2tab_consulta_selecao_lista_det`tabpage_2 within tab_1
integer width = 4928
integer height = 2360
gb_4 gb_4
dw_4 dw_4
end type

on tabpage_2.create
this.gb_4=create gb_4
this.dw_4=create dw_4
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_4
this.Control[iCurrent+2]=this.dw_4
end on

on tabpage_2.destroy
call super::destroy
destroy(this.gb_4)
destroy(this.dw_4)
end on

type gb_3 from dc_w_2tab_consulta_selecao_lista_det`gb_3 within tabpage_2
integer x = 14
integer y = 724
integer width = 4896
integer height = 680
long backcolor = 80269524
string text = "Itens Devolu$$HEX2$$e700e300$$ENDHEX$$o"
end type

type dw_3 from dc_w_2tab_consulta_selecao_lista_det`dw_3 within tabpage_2
integer x = 37
integer y = 776
integer width = 4859
integer height = 608
string dataobject = "dw_ge160_detalhe_itens"
boolean vscrollbar = true
end type

event dw_3::constructor;call super::constructor;
This.of_SetRowSelection()
end event

event dw_3::ue_recuperar;// OverRide

Long 		lvl_Linha, &
     		lvl_Filial, &
     		lvl_Doc
	  
String	lvl_Especie,&
			lvl_Serie
	  
lvl_Linha = Tab_1.TabPage_1.dw_2.GetRow()

lvl_Filial  = Tab_1.TabPage_1.dw_2.Object.Cd_Filial [lvl_Linha]
lvl_Doc	   = Tab_1.TabPage_1.dw_2.Object.Nr_Nf		 [lvl_Linha]
lvl_Especie = Tab_1.TabPage_1.dw_2.Object.De_Especie[lvl_Linha]
lvl_Serie   = Tab_1.TabPage_1.dw_2.Object.De_Serie  [lvl_Linha]

Return This.Retrieve(lvl_Filial, lvl_Doc, lvl_Especie, lvl_Serie)
end event

event dw_3::getfocus;//OverRide
This.ivm_Menu.mf_Classificar(True)
This.ivm_Menu.mf_Filtrar(True)
This.ivm_Menu.mf_Localizar(False)
This.ivm_Menu.mf_Recuperar(False)
end event

type dw_5 from dc_uo_dw_base within tabpage_1
integer x = 4526
integer y = 28
integer width = 1221
integer height = 476
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge160_relatorio"
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

type gb_4 from groupbox within tabpage_2
integer x = 14
integer y = 8
integer width = 4896
integer height = 712
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
string text = "Dados da Nota"
borderstyle borderstyle = styleraised!
end type

type dw_4 from dc_uo_dw_base within tabpage_2
integer x = 37
integer y = 68
integer width = 4850
integer height = 632
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge160_detalhe_nota"
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
lvl_Serie		= Tab_1.TabPage_1.dw_2.Object.De_Serie  	[lvl_Linha]
lvl_nr_Sequencial_PBM = Tab_1.TabPage_1.dw_2.Object.nr_Sequencial_PBM[lvl_Linha]

Return This.Retrieve(lvl_Filial, lvl_Doc, lvl_Especie, lvl_Serie, lvl_nr_Sequencial_PBM)
end event

