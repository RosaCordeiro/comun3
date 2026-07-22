HA$PBExportHeader$w_ge319_estoque_sintetico_por_filial.srw
forward
global type w_ge319_estoque_sintetico_por_filial from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge319_estoque_sintetico_por_filial from dc_w_selecao_lista_relatorio
string tag = "w_ge319_estoque_sintetico_por_filial"
integer width = 3630
integer height = 1912
string title = "GE319 - Relat$$HEX1$$f300$$ENDHEX$$rio de Posi$$HEX2$$e700e300$$ENDHEX$$o de Estoque Sint$$HEX1$$e900$$ENDHEX$$tico por Filial"
end type
global w_ge319_estoque_sintetico_por_filial w_ge319_estoque_sintetico_por_filial

type variables
uo_filial ivo_filial
end variables

forward prototypes
public function boolean wf_saldo_filial (date lvdt_periodo, integer lvi_row, long lvl_filial)
end prototypes

public function boolean wf_saldo_filial (date lvdt_periodo, integer lvi_row, long lvl_filial);Long lvl_Total, &
     	lvl_Row, &
	  	lvl_Linha_Nova
	  
String lvs_Fantasia


Decimal{2} lvdc_Saldo_Estoque

dc_uo_ds_base lvds_Saldo
lvds_Saldo = Create dc_uo_ds_base

If Not lvds_Saldo.of_ChangeDataObject("ds_ge319_saldo") Then Return False

If Not IsNull(lvl_Filial) Then
	lvds_Saldo.of_AppendWhere("s.cd_filial = " + String(lvl_Filial))
End IF

lvl_Total = lvds_Saldo.Retrieve(lvdt_Periodo)

If lvl_Total > 0 Then
	
	For lvl_Row = 1 To lvl_Total
		
		lvl_Filial	     				= lvds_Saldo.Object.cd_filial			[lvl_Row]
		lvs_Fantasia 				= lvds_Saldo.Object.nm_fantasia		[lvl_Row]
		lvdc_Saldo_Estoque   		= lvds_Saldo.Object.valor_estoque	[lvl_Row]
					
		dw_2.Object.cd_filial	[lvl_Row] 		= lvl_Filial
		dw_2.Object.nm_fantasia[lvl_Row]	= lvs_Fantasia
			
		If lvi_row = 1 Then
			dw_2.Object.vl_saldo1[lvl_Row]	= lvdc_Saldo_Estoque
		Else
			dw_2.Object.vl_saldo2[lvl_Row] 	= lvdc_Saldo_Estoque
		End If

		Return False
		
	Next	
End If

Destroy(lvds_Saldo)

Return True
end function

on w_ge319_estoque_sintetico_por_filial.create
call super::create
end on

on w_ge319_estoque_sintetico_por_filial.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;ivo_Filial = Create uo_Filial
end event

event close;call super::close;Destroy(ivo_Filial)
end event

event ue_postopen;call super::ue_postopen;DateTime lvdh_1, &
			lvdh_2
			

Select dateadd(month, -1, dh_movimentacao),
		dh_movimentacao
Into :lvdh_1,
	  :lvdh_2
From parametro
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		dw_1.Object.dh_Inicio 		[1] = Date("1/" + String(lvdh_1, "mm/yyyy"))
		dw_1.Object.dh_Termino	[1] = Date("1/" + String(lvdh_2, "mm/yyyy"))
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Ocorreu um erro na localiza$$HEX2$$e700e300$$ENDHEX$$o das datas", Information!)
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o das Datas de Sele$$HEX2$$e700e300$$ENDHEX$$o Default")
End Choose

This.ivm_Menu.ivb_Permite_Imprimir = true
end event

event ue_saveas;dw_3.Event ue_SaveAs()
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge319_estoque_sintetico_por_filial
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge319_estoque_sintetico_por_filial
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge319_estoque_sintetico_por_filial
integer y = 328
integer width = 3529
integer height = 1368
integer weight = 700
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge319_estoque_sintetico_por_filial
integer width = 1966
integer height = 300
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge319_estoque_sintetico_por_filial
integer x = 50
integer width = 1934
integer height = 216
string dataobject = "dw_ge319_selecao"
end type

event dw_1::ue_key;call super::ue_key;If Key = keyEnter! Then
	Choose Case This.GetColumnName()
		Case "nm_fantasia"
			ivo_Filial.of_Localiza_Filial(This.GetText())
		
			If ivo_Filial.Localizada Then
	
				This.Object.cd_Filial		[1] = ivo_filial.cd_filial
				This.Object.nm_fantasia	[1] = ivo_filial.nm_fantasia
				
			End If		
	End Choose
End If
end event

event dw_1::itemchanged;call super::itemchanged;Choose Case Dwo.Name
	Case "nm_fantasia"
		If Trim(Data) <> "" and Not IsNull(Data) Then
			If Data <> ivo_Filial.Nm_Fantasia Then				
				Return 1
			End If
		Else
			ivo_Filial.of_Inicializa()
			
			This.Object.Cd_Filial		[1] = ivo_Filial.cd_filial
			This.Object.Nm_Fantasia[1] = ivo_Filial.nm_fantasia			
		End If	
End Choose
		
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge319_estoque_sintetico_por_filial
integer x = 64
integer y = 376
integer width = 3479
integer height = 1300
string dataobject = "dw_ge319_lista"
boolean hscrollbar = true
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_recuperar;//OverRide

Date 		lvdt_Inicio, &
			lvdt_Termino, &
			lvdt_Data_Atual, &
			lvdt_Periodo

long lvl_Codigo, &
	  lvl_Linha, &
	  lvl_Total, &
	  lvl_Filial, &
	  lvl_Find, &
	  lvl_Find_Dias
	  
String lvs_nm_fantasia
String lvs_Considera_EC
String lvs_Manipulado

Decimal	lvdc_Saldo, &
			lvdc_Saldo_2, &
			lvdc_Valor_Variacao, &
			lvdc_Percentual_Variacao, &
			lvdc_Dias_1, &
			lvdc_Dias_2

integer lvi_Row

Dw_1.AcceptText()

lvdt_Inicio 			= gf_Primeiro_Dia_Mes(dw_1.Object.dh_inicio		[1])
lvdt_Termino 		= gf_Primeiro_Dia_Mes(dw_1.Object.dh_termino	[1])
lvdt_Data_Atual 	= gf_Primeiro_Dia_Mes(Today())
lvl_Filial				= dw_1.Object.cd_filial				[1]
lvs_Considera_EC	= dw_1.Object.id_considera_ec	[1]
lvs_Manipulado		= dw_1.Object.id_manipulado		[1]


If lvdt_Termino <= lvdt_Inicio Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data do M$$HEX1$$ea00$$ENDHEX$$s 1 deve ser menor do que a data do M$$HEX1$$ea00$$ENDHEX$$s 2", Information!)
	dw_1.Event ue_Pos(1,"dh_Inicio")
	Return -1
End If

If lvdt_Termino > lvdt_Data_Atual Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","A data do segundo m$$HEX1$$ea00$$ENDHEX$$s deve ser igual ao m$$HEX1$$ea00$$ENDHEX$$s corrente.",Information!)
	Return -1
End If

This.SetRedraw(False)

//DS_Saldo  
dc_uo_ds_base lvds_Saldo
lvds_Saldo = Create dc_uo_ds_base
//DS_Saldo_2
dc_uo_ds_base lvds_Saldo_2
lvds_Saldo_2 = Create dc_uo_ds_base

If Not lvds_Saldo.of_ChangeDataObject("ds_ge319_saldo") Then Return -1
If Not lvds_Saldo_2.of_ChangeDataObject("ds_ge319_saldo") Then Return -1

//DS_Resumo  
dc_uo_ds_base lvds_Resumo
lvds_Resumo = Create dc_uo_ds_base
//DS_Resumo_2
dc_uo_ds_base lvds_Resumo_2
lvds_Resumo_2 = Create dc_uo_ds_base

If Not lvds_Resumo.of_ChangeDataObject("ds_ge319_resumo") Then Return -1
If Not lvds_Resumo_2.of_ChangeDataObject("ds_ge319_resumo") Then Return -1 

If lvs_Considera_EC = 'N' Then
	lvds_Saldo.of_AppendWhere("s.cd_filial not in (1,534)")
	lvds_Saldo_2.of_AppendWhere("s.cd_filial not in (1,534)")
	lvds_Resumo.of_AppendWhere("r.cd_filial not in (1,534)")
	lvds_Resumo_2.of_AppendWhere("r.cd_filial not in (1,534)")
End If

If lvs_Manipulado = 'N' Then
	lvds_Saldo.of_AppendWhere("s.cd_produto not in (684431,577625)")
	lvds_Saldo_2.of_AppendWhere("s.cd_produto not in (684431,577625)")
	lvds_Resumo.of_AppendWhere("r.cd_produto not in (684431,577625)")
	lvds_Resumo_2.of_AppendWhere("r.cd_produto not in (684431,577625)")
End If

If Not IsNull(lvl_filial) Then
	lvds_Saldo.of_AppendWhere("s.cd_filial = " + String(lvl_Filial))
	lvds_Saldo_2.of_AppendWhere("s.cd_filial = " + String(lvl_Filial))
	lvds_Resumo.of_AppendWhere("r.cd_filial = " + String(lvl_Filial))
	lvds_Resumo_2.of_AppendWhere("r.cd_filial = " + String(lvl_Filial))
Else 
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Devido ao grande n$$HEX1$$fa00$$ENDHEX$$mero de informa$$HEX2$$e700e300$$ENDHEX$$o, este relat$$HEX1$$f300$$ENDHEX$$rio pode demorar alguns minutos.")
End If

Open(w_Aguarde)
w_Aguarde.uo_progress.of_SetMax(4)

w_Aguarde.Title = "Recuperando Saldo do M$$HEX1$$ea00$$ENDHEX$$s "+String(lvdt_Inicio,'MM/YYYY')+"..."
lvl_Total = lvds_Saldo.Retrieve(lvdt_Inicio)
w_Aguarde.uo_progress.of_SetProgress(1)
w_Aguarde.Title = "Recuperando Saldo do M$$HEX1$$ea00$$ENDHEX$$s "+String(lvdt_Termino,'MM/YYYY')+"..."
lvds_Saldo_2.Retrieve(lvdt_Termino)
w_Aguarde.uo_progress.of_SetProgress(2)
w_Aguarde.Title = "Recuperando Dias do M$$HEX1$$ea00$$ENDHEX$$s "+String(lvdt_Inicio,'MM/YYYY')+"..."
lvds_Resumo.Retrieve(lvdt_Inicio)
w_Aguarde.uo_progress.of_SetProgress(3)
w_Aguarde.Title = "Recuperando Dias do M$$HEX1$$ea00$$ENDHEX$$s "+String(lvdt_Termino,'MM/YYYY')+"..."
lvds_Resumo_2.Retrieve(lvdt_Termino)
w_Aguarde.uo_progress.of_SetProgress(4)

This.Reset()

//M$$HEX1$$ea00$$ENDHEX$$s 1
w_Aguarde.uo_progress.of_SetMax(lvl_Total)
For lvl_Linha = 1 To lvl_Total
	/* Saldo */
	lvl_codigo    		= lvds_Saldo.Object.cd_filial			[lvl_Linha]
	lvs_nm_fantasia 	= lvds_Saldo.Object.nm_fantasia		[lvl_Linha]
	lvdc_Saldo  			= lvds_Saldo.Object.valor_estoque	[lvl_Linha]
	
	lvl_Find = This.Find('cd_filial='+String(lvl_codigo),1,This.RowCount())
	
	If (IsNull(lvl_Find))or(Not (lvl_Find > 0)) Then
		lvl_Find = This.InsertRow(0)
		
		This.Object.cd_filial		[lvl_Find] = lvl_codigo
		This.Object.nm_fantasia	[lvl_Find] = lvs_nm_Fantasia	
	End If
	
	This.Object.vl_saldo1		[lvl_Find] = lvdc_Saldo
	
	/* Dias */
	lvl_Find_Dias = lvds_Resumo.Find("cd_filial=" + String(lvl_codigo), 1, lvds_Resumo.RowCount())
	If lvl_Find_Dias > 0 Then
		lvdc_Dias_1 = lvds_Resumo.Object.valor_cmv[lvl_Find_Dias]
		
		This.Object.vl_cmv1	[lvl_Linha] = lvdc_Dias_1
		
		If lvdc_Dias_1 > 0 Then
			This.Object.vl_dias1	[lvl_Linha] = (lvdc_Saldo * 30) / lvdc_Dias_1
		Else
			This.Object.vl_dias1	[lvl_Linha] = 0
		End If		
	End If
	
	w_Aguarde.uo_progress.of_SetProgress(lvl_Linha)
Next

//M$$HEX1$$ea00$$ENDHEX$$s 2
lvl_Total = lvds_Saldo_2.RowCount()
w_Aguarde.uo_progress.of_SetMax(lvl_Total)
For lvl_Linha = 1 To lvl_Total
	/* Saldo */
	lvl_codigo    		= lvds_Saldo_2.Object.cd_filial			[lvl_Linha]
	lvs_nm_fantasia 	= lvds_Saldo_2.Object.nm_fantasia	[lvl_Linha]
	lvdc_Saldo_2		= lvds_Saldo_2.Object.valor_estoque	[lvl_Linha]
	
	lvl_Find = This.Find('cd_filial='+String(lvl_codigo),1,This.RowCount())
	
	If (IsNull(lvl_Find))or(Not (lvl_Find > 0)) Then
		lvl_Find = This.InsertRow(0)
		
		This.Object.cd_filial		[lvl_Find] = lvl_codigo
		This.Object.nm_fantasia	[lvl_Find] = lvs_nm_Fantasia	
	End If
	
	This.Object.vl_saldo2		[lvl_Find] = lvdc_Saldo_2
	
	/* Dias */
	lvl_Find_Dias = lvds_Resumo_2.Find("cd_filial=" + String(lvl_codigo), 1, lvds_Resumo_2.RowCount())
	If lvl_Find_Dias > 0 Then
		lvdc_Dias_2 = lvds_Resumo_2.Object.valor_cmv[lvl_Find_Dias]
		
		This.Object.vl_cmv2	[lvl_Linha] = lvdc_Dias_2
		
		If lvdc_Dias_2 > 0 Then
			This.Object.vl_dias2	[lvl_Linha] = (lvdc_Saldo_2 * 30) / lvdc_Dias_2
		Else
			This.Object.vl_dias2	[lvl_Linha] = 0
		End If		
	End If
	
	w_Aguarde.uo_progress.of_SetProgress(lvl_Linha)
Next

/* Varia$$HEX2$$e700e300$$ENDHEX$$o */
For lvl_Linha = 1 To This.RowCount()
	lvdc_Saldo		= This.Object.vl_saldo1	[lvl_Linha]
	lvdc_Saldo_2	= This.Object.vl_saldo2	[lvl_Linha]

	//Valor Variacao
	lvdc_Valor_Variacao = lvdc_Saldo_2 - lvdc_Saldo
	dw_2.Object.vl_variacao	[lvl_Linha] = lvdc_Valor_Variacao
	
	//Percentual Variacao			
	If lvdc_Saldo > 0 Then
		lvdc_Percentual_Variacao 				= (lvdc_Valor_Variacao / lvdc_Saldo) * 100
		This.Object.pc_variacao [lvl_Linha] 	= lvdc_Percentual_Variacao
	Else
		This.Object.pc_variacao [lvl_Linha]	= 0
	End If
Next

This.Sort()

If IsValid(W_Aguarde) Then
	Close(W_Aguarde)
End If

This.Object.Mes1.Text = "Estoque do M$$HEX1$$ea00$$ENDHEX$$s: " + String(lvdt_Inicio,"mm/yyyy")
This.Object.Mes2.Text = "Estoque do M$$HEX1$$ea00$$ENDHEX$$s: " + String(lvdt_Termino,"mm/yyyy")

This.SetRedraw(True)

This.GroupCalc()

Return This.RowCount()
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;This.ivm_Menu.mf_SalvarComo(pl_Linhas > 0)
This.ivm_Menu.mf_Classificar(pl_Linhas > 0)
This.ivm_Menu.mf_Imprimir(pl_Linhas > 0)

Return pl_Linhas
end event

event dw_2::constructor;call super::constructor;String lvs_Coluna[], &
       lvs_Nome[]
		 
lvs_Coluna = {"cd_filial", "vl_saldo1", "vl_saldo2", "vl_dias1", "vl_dias2", "vl_variacao", "pc_variacao"}

lvs_Nome = {"C$$HEX1$$f300$$ENDHEX$$digo Filial", "Saldo M$$HEX1$$ea00$$ENDHEX$$s 1", "Saldo M$$HEX1$$ea00$$ENDHEX$$s 2", "Dias M$$HEX1$$ea00$$ENDHEX$$s 1", "Dias M$$HEX1$$ea00$$ENDHEX$$s 2","Varia$$HEX2$$e700e300$$ENDHEX$$o", "% Varia$$HEX2$$e700e300$$ENDHEX$$o"}

This.of_SetSort(lvs_Coluna, lvs_Nome)
This.of_SetFilter(lvs_Coluna, lvs_Nome)

This.of_SetRowSelection()

end event

event dw_2::ue_reset;call super::ue_reset;This.ivm_Menu.mf_SalvarComo(False)
This.ivm_Menu.mf_Classificar(False)
This.ivm_Menu.mf_Imprimir(False)
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge319_estoque_sintetico_por_filial
integer x = 2263
integer y = 0
integer width = 434
integer height = 224
string dataobject = "dw_ge319_relatorio"
end type

event dw_3::ue_preprint;call super::ue_preprint;Date  lvdt_Inicio, &
		lvdt_Termino

dw_1.AcceptText()

lvdt_Inicio 		= dw_1.Object.dh_inicio		[1] 
lvdt_Termino 	= dw_1.Object.dh_termino	[1] 

This.Object.Mes1.Text = "Estoque do M$$HEX1$$ea00$$ENDHEX$$s: " + String(lvdt_Inicio,"mm/yyyy")
This.Object.Mes2.Text = "Estoque do M$$HEX1$$ea00$$ENDHEX$$s: " + String(lvdt_Termino,"mm/yyyy")

This.Object.saldo1.Text		= String(Round(dw_2.Object.total_saldo1		[1],2),"#,##0.00")
This.Object.saldo2.Text		= String(Round(dw_2.Object.total_saldo2		[1],2),"#,##0.00")
This.Object.dias1.Text		= String(Round(dw_2.Object.total_dias1			[1],2),"#,##0.00")
This.Object.dias2.Text		= String(Round(dw_2.Object.total_dias2			[1],2),"#,##0.00")
This.Object.variacao.Text	= String(Round(dw_2.Object.total_variacao		[1],2),"#,##0.00")
This.Object.percentual.Text	= String(Round(dw_2.Object.total_percentual	[1],2),"#,##0.00")

Return AncestorReturnValue
end event

