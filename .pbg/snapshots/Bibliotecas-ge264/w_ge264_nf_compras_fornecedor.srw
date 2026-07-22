HA$PBExportHeader$w_ge264_nf_compras_fornecedor.srw
forward
global type w_ge264_nf_compras_fornecedor from dc_w_selecao_lista_relatorio
end type
type dw_4 from dc_uo_dw_base within w_ge264_nf_compras_fornecedor
end type
type cb_calcular from commandbutton within w_ge264_nf_compras_fornecedor
end type
end forward

global type w_ge264_nf_compras_fornecedor from dc_w_selecao_lista_relatorio
integer width = 3945
integer height = 1916
string title = "GE264 - Relat$$HEX1$$f300$$ENDHEX$$rio Nota Fornecedor - Entrada Manual"
dw_4 dw_4
cb_calcular cb_calcular
end type
global w_ge264_nf_compras_fornecedor w_ge264_nf_compras_fornecedor

type variables
uo_fornecedor		ivo_fornecedor
uo_filial				ivo_filial

end variables

on w_ge264_nf_compras_fornecedor.create
int iCurrent
call super::create
this.dw_4=create dw_4
this.cb_calcular=create cb_calcular
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_4
this.Control[iCurrent+2]=this.cb_calcular
end on

on w_ge264_nf_compras_fornecedor.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_4)
destroy(this.cb_calcular)
end on

event ue_postopen;call super::ue_postopen;ivo_fornecedor 	= Create uo_fornecedor		
ivo_filial			= Create uo_filial				

dw_1.Object.Dt_Inicio		[1] = RelativeDate(Today(), -1)
dw_1.Object.Dt_Termino	[1] = Today()

This.ivm_Menu.ivb_Permite_Imprimir = True


end event

event close;call super::close;Destroy ivo_Filial
Destroy ivo_Fornecedor
end event

event ue_save;call super::ue_save;SetFocus(dw_2)

dw_2.Event ue_SaveAs()

Return 1
end event

event ue_preopen;call super::ue_preopen;MaxHeight = 2000
MaxWidth = 4175
end event

event ue_saveas;dw_3.Event ue_SaveAs()
end event

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge264_nf_compras_fornecedor
integer y = 432
integer width = 3831
integer height = 1280
integer weight = 700
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge264_nf_compras_fornecedor
integer y = 12
integer width = 2354
integer height = 408
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge264_nf_compras_fornecedor
integer x = 73
integer y = 76
integer width = 2295
integer height = 316
string dataobject = "dw_ge264_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case "de_filial"	
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Filial.Nm_Fantasia Then
				Return 1
			End If
		Else
			ivo_Filial.of_Inicializa()
			
			This.Object.cd_filial	[1] = ivo_Filial.Cd_Filial
			This.Object.de_filial	[1] = ivo_Filial.Nm_Fantasia
		End If
		
	Case "nm_fornecedor"		
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Fornecedor.Nm_Razao_Social Then
				Return 1
			End If
		Else
			ivo_Fornecedor.of_Inicializa()
			
			This.Object.cd_fornecedor	[1] = ivo_Fornecedor.Cd_Fornecedor
			This.Object.nm_fornecedor	[1] = ivo_Fornecedor.Nm_Razao_Social
		End If
			
End Choose

end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "nm_fornecedor"
			ivo_Fornecedor.of_Localiza_Fornecedor(This.GetText())
			
			If ivo_Fornecedor.Localizado Then
				This.Object.nm_fornecedor	[1] = ivo_Fornecedor.Nm_Razao_Social
				This.Object.cd_fornecedor	[1] = ivo_Fornecedor.Cd_Fornecedor			
			End If
			
		Case "de_filial"
			ivo_Filial.of_Localiza_Filial(This.GetText())
			
			If ivo_Filial.Localizada Then
				This.Object.de_filial			[1] = ivo_Filial.Nm_Fantasia
				This.Object.cd_filial			[1] = ivo_Filial.Cd_Filial
			End If	
	End Choose
	
End If
end event

event dw_1::editchanged;call super::editchanged;ivm_Menu.mf_salvarComo(False)
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge264_nf_compras_fornecedor
integer y = 508
integer width = 3753
integer height = 1180
string dataobject = "dw_ge264_lista_notas_compras_fornecedor"
boolean hscrollbar = true
boolean hsplitscroll = true
end type

event dw_2::ue_recuperar;//OverRide

Date lvdt_inicial
Date lvdt_final

String	 lvs_cd_fornecedor, &
		 lvs_nm_fornecedor, &
		 lvs_considera_estoque, &
		 lvs_id_agrupar, &
		 lvs_id_agrupar_filial

Long   lvl_cd_filial

dw_1.AcceptText()

lvdt_inicial          			= dw_1.Object.dt_inicio    				[1]
lvdt_final            			= dw_1.Object.dt_termino   			[1]
lvl_cd_filial         			= dw_1.Object.cd_filial    				[1]
lvs_cd_fornecedor     		= dw_1.Object.cd_fornecedor			[1]
lvs_nm_fornecedor     	= dw_1.Object.nm_fornecedor			[1]
lvs_considera_estoque 	= dw_1.Object.id_considera_estoque	[1]
lvs_id_agrupar        		= dw_1.Object.id_agrupar				[1]
lvs_id_agrupar_filial 		= dw_1.Object.id_agrupar_filial		[1]

If lvs_id_agrupar = 'S' Then
	This.of_ChangeDataObject("dw_ge264_lista_notas_compras_fornec_total")
	dw_3.of_ChangeDataObject("dw_ge264_relatorio_notas_compras_fornec_total")
	
ElseIf lvs_id_agrupar_filial = 'S' Then
	This.of_ChangeDataObject("dw_ge264_lista_notas_compras_forn_filial")
	dw_3.of_ChangeDataObject("dw_ge264_relatorio_notas_compras_forn_filial")
Else
	This.of_ChangeDataObject("dw_ge264_lista_notas_compras_fornecedor")
	dw_3.of_ChangeDataObject("dw_ge264_relatorio_notas_compras_fornecedor")
End If
//
dw_2.ShareData(dw_3)
This.of_SetRowSelection()
//
If lvs_Considera_Estoque = 'N' Then
	This.Of_AppendWhere("nf_compra.cd_filial not in (" + String(534) + ")")
End If

If Not IsNull(lvl_cd_filial) Then
	 This.Of_AppendWhere("nf_compra.cd_filial = " + String(lvl_cd_filial)	)
End If

If Not IsNull(lvs_cd_fornecedor) Then
	 This.Of_AppendWhere("nf_compra.cd_fornecedor = '" + String(lvs_cd_fornecedor)	+ "'")
End If

This.Of_AppendWhere("nf_compra.dh_movimentacao_caixa between '" + &
								  String(lvdt_inicial,"yyyymmdd") + "' and '"      + &
								  String(lvdt_final  ,"yyyymmdd") + "'")


Return This.Retrieve()
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	
	This.of_SetRowSelection()
	
	ivm_Menu.mf_salvarComo(True)
Else
	ivm_Menu.mf_salvarComo(False)
End If

Return pl_Linhas
end event

event dw_2::constructor;call super::constructor;This.of_SetRowSelection()
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge264_nf_compras_fornecedor
integer x = 2446
integer y = 32
integer width = 233
integer height = 324
string dataobject = "dw_ge264_relatorio_notas_compras_fornecedor"
end type

event dw_3::ue_preprint;call super::ue_preprint;dw_3.Object.st_periodo.text = String(dw_1.Object.dt_inicio[1],"dd/mm/yyyy") + ' $$HEX1$$e000$$ENDHEX$$ ' + &
										String(dw_1.Object.dt_termino[1]  ,"dd/mm/yyyy")

If Not IsNull(dw_1.Object.cd_fornecedor[1]) Then
	dw_3.Object.st_fornecedor.text = dw_1.Object.nm_fornecedor[1] + ' (' + dw_1.Object.cd_fornecedor[1] + ')'
Else
	dw_3.Object.st_fornecedor.text = 'TODOS'
End If

Return 1
end event

type dw_4 from dc_uo_dw_base within w_ge264_nf_compras_fornecedor
boolean visible = false
integer x = 2715
integer y = 28
integer width = 261
integer height = 288
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge264_calcula_notas_compras_fornecedor"
end type

type cb_calcular from commandbutton within w_ge264_nf_compras_fornecedor
integer x = 3374
integer y = 328
integer width = 494
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Calcular &Grupo"
end type

event clicked;String lvs_cd_fornecedor , &
		 lvs_de_especie	 , &
		 lvs_de_serie

Long lvl_linha 		, &
	  lvl_nr_nf 		, &
	  lvl_cd_filial		, &
	  lvl_total_linha

Decimal lvdc_diferenca			, &
		  lvdc_diferenca_positiva	, &
		  lvdc_vl_ipi	 				, &
		  lvdc_vl_total_produtos	

lvl_total_linha = dw_2.rowcount()

If lvl_total_linha > 0 Then
	
	Open(w_aguarde)
	Setpointer(HourGlass!)
	w_aguarde.title = "Calculando Nota de Compra..."
	w_aguarde.uo_progress.Of_SetMax(lvl_total_linha)

	For lvl_linha = 1 To lvl_total_linha
		
		w_aguarde.uo_progress.Of_SetProgress(lvl_linha)
		
		lvl_cd_filial     = dw_2.Object.filial_cd_filial		 [lvl_linha]
		lvl_nr_nf         = dw_2.Object.nf_compra_nr_nf        [lvl_linha]
		lvs_cd_fornecedor = dw_2.Object.nf_compra_cd_fornecedor[lvl_linha]
		lvs_de_especie    = dw_2.Object.nf_compra_de_especie   [lvl_linha]
		lvs_de_serie      = dw_2.Object.nf_compra_de_serie     [lvl_linha]
		
		If dw_4.Retrieve(lvl_cd_filial	 , &
							  lvs_cd_fornecedor, &
							  lvl_nr_nf			 , &
  							  lvs_de_especie	 , &
							  lvs_de_serie) > 0 Then

			dw_2.Object.vl_medicamento	[lvl_linha] = dw_4.Object.c_vl_medicamento	[1] 
			dw_2.Object.vl_popular	  		[lvl_linha] = dw_4.Object.c_vl_popular	  		[1]
			dw_2.Object.vl_perfumaria	 	[lvl_linha] = dw_4.Object.c_vl_perfumaria 		[1]
			dw_2.Object.vl_drugstore 	 	[lvl_linha] = dw_4.Object.c_vl_drugstore  		[1]
	
			lvdc_diferenca = dw_4.Object.c_vl_diferenca[1]
			If lvdc_diferenca <> 0.00 Then
				//
				lvdc_diferenca_positiva = lvdc_diferenca
				If lvdc_diferenca_positiva < 0 Then
					lvdc_diferenca_positiva = lvdc_diferenca_positiva * -1
				End If
				//
				If	dw_4.Object.c_vl_medicamento[1] > lvdc_diferenca_positiva Then
					dw_2.Object.vl_medicamento[lvl_linha] = dw_2.Object.vl_medicamento[lvl_linha] + lvdc_diferenca
				ElseIf dw_4.Object.c_vl_popular[1] > lvdc_diferenca_positiva Then	
					dw_2.Object.vl_popular    [lvl_linha] = dw_2.Object.vl_popular    [lvl_linha] + lvdc_diferenca
				ElseIf dw_4.Object.c_vl_perfumaria[1] > lvdc_diferenca_positiva Then	
					dw_2.Object.vl_perfumaria [lvl_linha] = dw_2.Object.vl_perfumaria [lvl_linha] + lvdc_diferenca
				ElseIf dw_4.Object.c_vl_drugstore[1] > lvdc_diferenca_positiva Then	
					dw_2.Object.vl_drugstore  [lvl_linha] = dw_2.Object.vl_drugstore  [lvl_linha] + lvdc_diferenca	
				End If
			End If
				
		End If
		
	Next
	
	Setpointer(Arrow!)
	w_aguarde.uo_progress.Of_SetProgress(0)
	Close(w_aguarde)
	
End If

dw_3.GroupCalc()
end event

