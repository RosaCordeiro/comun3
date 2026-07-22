HA$PBExportHeader$w_ge262_consulta_notas_compras_distrib.srw
forward
global type w_ge262_consulta_notas_compras_distrib from dc_w_selecao_lista_relatorio
end type
type cb_calcular from commandbutton within w_ge262_consulta_notas_compras_distrib
end type
type dw_4 from dc_uo_dw_base within w_ge262_consulta_notas_compras_distrib
end type
end forward

global type w_ge262_consulta_notas_compras_distrib from dc_w_selecao_lista_relatorio
string accessiblename = "Consulta de Notas de Compras das Distribuidoras (CO067)"
integer width = 3611
integer height = 2028
string title = "GE262 - Consulta de Notas de Compras das Distribuidoras"
long backcolor = 80269524
cb_calcular cb_calcular
dw_4 dw_4
end type
global w_ge262_consulta_notas_compras_distrib w_ge262_consulta_notas_compras_distrib

type variables
uo_filial ivo_Filial
end variables

forward prototypes
public subroutine wf_calcular_distribuidora ()
public subroutine wf_calcular_distribuidora_data ()
public subroutine wf_insere_distribuidora_default ()
public subroutine wf_calcular_distribuidora_filial ()
public function decimal wf_valor_distribuidora_data (datetime adh_movimento, string as_fornecedor, integer ai_grupo_produto)
public function decimal wf_valor_distribuidora_filial (datetime adh_movimento_de, datetime adh_movimento_ate, long al_filial, integer ai_grupo_produto, string as_fornecedor)
end prototypes

public subroutine wf_calcular_distribuidora ();String lvs_cd_fornecedor , &
		 lvs_de_especie	 , &
		 lvs_de_serie

Long lvl_linha 	, &
	  lvl_nr_nf 	, &
	  lvl_cd_filial, &
	  lvl_total_linha

Decimal lvdc_diferenca, &
		  lvdc_diferenca_positiva

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
			
			dw_2.Object.vl_medicamento[lvl_linha] = dw_4.Object.c_vl_medicamento[1] + dw_4.Object.vl_outras_despesas[1]
			dw_2.Object.vl_popular	  [lvl_linha] = dw_4.Object.c_vl_popular	  [1]
			dw_2.Object.vl_perfumaria [lvl_linha] = dw_4.Object.c_vl_perfumaria [1]
			dw_2.Object.vl_drugstore  [lvl_linha] = dw_4.Object.c_vl_drugstore  [1]

			dw_2.Object.nf_compra_vl_total_produtos[lvl_linha] = dw_2.Object.nf_compra_vl_total_produtos[lvl_linha] + dw_4.Object.vl_outras_despesas[1]

			lvdc_diferenca = dw_4.Object.c_vl_diferenca[1]
			If lvdc_diferenca <> 0.00 Then
				
				lvdc_diferenca_positiva = lvdc_diferenca
				If lvdc_diferenca_positiva < 0 Then
					lvdc_diferenca_positiva = lvdc_diferenca_positiva * -1
				End If
				
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
end subroutine

public subroutine wf_calcular_distribuidora_data ();String lvs_Fornecedor

DateTime lvdh_Movimento

Long lvl_Linha,&
	 lvl_Linhas
	 
dw_2.AcceptText()
	 
lvl_Linhas = dw_2.RowCount()

If lvl_Linhas > 0 Then
	
	Open(w_aguarde)
	Setpointer(HourGlass!)
	w_aguarde.title = "Calculando Nota de Compra..."
	w_aguarde.uo_progress.Of_SetMax(lvl_Linhas)
	
	For lvl_Linha = 1 To lvl_Linhas
		
		w_aguarde.uo_progress.Of_SetProgress(lvl_linha)
		
		lvdh_Movimento      = dw_2.Object.dh_movimentacao_caixa[lvl_Linha]
		lvs_Fornecedor      = dw_2.Object.cd_Fornecedor        [lvl_Linha]
				
		dw_2.Object.vl_medicamento[lvl_Linha] = wf_Valor_Distribuidora_Data(lvdh_Movimento, lvs_Fornecedor, 1)
		dw_2.Object.vl_popular    [lvl_Linha] = wf_Valor_Distribuidora_Data(lvdh_Movimento, lvs_Fornecedor, 2)
		dw_2.Object.vl_perfumaria [lvl_Linha] = wf_Valor_Distribuidora_Data(lvdh_Movimento, lvs_Fornecedor, 3)
		dw_2.Object.vl_drugstore  [lvl_Linha] = wf_Valor_Distribuidora_Data(lvdh_Movimento, lvs_Fornecedor, 7) 
	Next
	
	Setpointer(Arrow!)
	w_aguarde.uo_progress.Of_SetProgress(0)
	Close(w_aguarde)
	
	dw_3.GroupCalc()
End If



end subroutine

public subroutine wf_insere_distribuidora_default ();DataWindowChild lvdwc

Integer lvi_Retorno,&
        lvi_Row

If dw_1.GetChild("cd_distribuidora", lvdwc) = 1 Then
	lvdwc.InsertRow(1)
	
	lvdwc.SetItem(1, "cd_fornecedor", "000000000")
	lvdwc.SetItem(1, "nm_fantasia",   "TODAS")
	
	dw_1.Object.Cd_Distribuidora[1] = "000000000"
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild da distribuidora.")
End If
end subroutine

public subroutine wf_calcular_distribuidora_filial ();DateTime lvdh_Inicio,&
		 lvdh_Termino

Long lvl_Linha,&
	 lvl_Linhas,&
	 lvl_Filial

String lvs_Distribuidora
	 
dw_1.AcceptText()
dw_2.AcceptText()
	 
lvl_Linhas = dw_2.RowCount()

lvdh_Inicio       = DateTime(dw_1.Object.dt_inicio [1])
lvdh_Termino      = DateTime(dw_1.Object.dt_termino[1])
lvs_Distribuidora = dw_1.Object.cd_distribuidora   [1]

If lvl_Linhas > 0 Then
		
	Open(w_aguarde)
	Setpointer(HourGlass!)
	w_aguarde.title = "Calculando Nota de Compra..."
	w_aguarde.uo_progress.Of_SetMax(lvl_Linhas)
	
	For lvl_Linha = 1 To lvl_Linhas
		
		w_aguarde.uo_progress.Of_SetProgress(lvl_linha)
		
		lvl_Filial     = dw_2.Object.nf_compra_cd_filial[lvl_Linha]
				
		dw_2.Object.vl_medicamento[lvl_Linha] = wf_Valor_Distribuidora_Filial(lvdh_Inicio, lvdh_Termino, lvl_Filial, 1, lvs_Distribuidora)
		dw_2.Object.vl_popular    [lvl_Linha] = wf_Valor_Distribuidora_Filial(lvdh_Inicio, lvdh_Termino, lvl_Filial, 2, lvs_Distribuidora)
		dw_2.Object.vl_perfumaria [lvl_Linha] = wf_Valor_Distribuidora_Filial(lvdh_Inicio, lvdh_Termino, lvl_Filial, 3, lvs_Distribuidora)
		dw_2.Object.vl_drugstore  [lvl_Linha] = wf_Valor_Distribuidora_Filial(lvdh_Inicio, lvdh_Termino, lvl_Filial, 7, lvs_Distribuidora) 
	Next
	
	Setpointer(Arrow!)
	w_aguarde.uo_progress.Of_SetProgress(0)
	Close(w_aguarde)
	
	dw_3.GroupCalc()
End If



end subroutine

public function decimal wf_valor_distribuidora_data (datetime adh_movimento, string as_fornecedor, integer ai_grupo_produto);Decimal{2} lvdc_Valor

Select sum(round((round(i.vl_preco_unitario * ((100 - i.pc_desconto) / 100), 2) - i.vl_icms_repassado) * i.qt_faturada, 2))
Into :lvdc_Valor
From nf_compra n, 
     item_nf_compra i, 
	 produto_geral p
where i.cd_filial     		  = n.cd_filial
  and i.cd_fornecedor 		  = n.cd_fornecedor
  and i.nr_nf         		  = n.nr_nf
  and i.de_especie    		  = n.de_especie
  and i.de_serie      		  = n.de_serie
  and p.cd_produto    		  = i.cd_produto
  and n.dh_movimentacao_caixa = :adh_Movimento
  and n.cd_fornecedor         = :as_Fornecedor
  and p.cd_grupo_produto      = :ai_grupo_produto
  Using SqlCa;
  
  If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Erro ao calcular o valor do grupo '" + String(ai_grupo_produto) + "'")
	lvdc_Valor = 0.00
  End If
  
  If IsNull(lvdc_Valor) Then lvdc_Valor = 0.00
  
  Return lvdc_Valor
  
  

end function

public function decimal wf_valor_distribuidora_filial (datetime adh_movimento_de, datetime adh_movimento_ate, long al_filial, integer ai_grupo_produto, string as_fornecedor);Decimal{2} lvdc_Valor

If as_Fornecedor <> "000000000" Then
	Select sum(round((round(i.vl_preco_unitario * ((100 - i.pc_desconto) / 100), 2) - i.vl_icms_repassado) * i.qt_faturada, 2))
	Into :lvdc_Valor
	From nf_compra n, 
		 item_nf_compra i, 
		 produto_geral p
	where i.cd_filial     		  = n.cd_filial
	  and i.cd_fornecedor 		  = n.cd_fornecedor
	  and i.nr_nf         		  = n.nr_nf
	  and i.de_especie    		  = n.de_especie
	  and i.de_serie      		  = n.de_serie
	  and p.cd_produto    		  = i.cd_produto
	  and n.cd_filial             = :al_Filial
	  and n.cd_fornecedor         = :as_Fornecedor
	  and n.dh_movimentacao_caixa between :adh_Movimento_de and :adh_Movimento_ate
	  and p.cd_grupo_produto      = :ai_grupo_produto
	  Using SqlCa;
Else
	Select sum(round((round(i.vl_preco_unitario * ((100 - i.pc_desconto) / 100), 2) - i.vl_icms_repassado) * i.qt_faturada, 2))
	Into :lvdc_Valor
	From nf_compra n, 
		 item_nf_compra i, 
		 produto_geral p
	where i.cd_filial     		  = n.cd_filial
	  and i.cd_fornecedor 		  = n.cd_fornecedor
	  and i.nr_nf         		  = n.nr_nf
	  and i.de_especie    		  = n.de_especie
	  and i.de_serie      		  = n.de_serie
	  and p.cd_produto    		  = i.cd_produto
  	  and n.cd_filial             = :al_filial
	  and n.dh_movimentacao_caixa between :adh_Movimento_de and :adh_Movimento_ate
	  and p.cd_grupo_produto      = :ai_grupo_produto
	  Using SqlCa;
End If
  
If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Erro ao calcular o valor do grupo '" + String(ai_grupo_produto) + "'")
	lvdc_Valor = 0.00
End If

If IsNull(lvdc_Valor) Then lvdc_Valor = 0.00
  
  Return lvdc_Valor
  
  

end function

on w_ge262_consulta_notas_compras_distrib.create
int iCurrent
call super::create
this.cb_calcular=create cb_calcular
this.dw_4=create dw_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_calcular
this.Control[iCurrent+2]=this.dw_4
end on

on w_ge262_consulta_notas_compras_distrib.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_calcular)
destroy(this.dw_4)
end on

event ue_postopen;call super::ue_postopen;dw_1.Object.Dt_Inicio [1] = Today()
dw_1.Object.Dt_Termino[1] = Today()

ivo_Filial = Create uo_filial

dw_2.ivo_Controle_Menu.of_SalvarComo(True)

This.ivm_Menu.ivb_Permite_Imprimir = True

wf_Insere_Distribuidora_Default()
end event

event close;call super::close;Destroy(ivo_Filial)
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge262_consulta_notas_compras_distrib
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge262_consulta_notas_compras_distrib
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge262_consulta_notas_compras_distrib
integer x = 14
integer y = 636
integer width = 3543
integer height = 1196
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge262_consulta_notas_compras_distrib
integer x = 14
integer width = 2464
integer height = 576
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge262_consulta_notas_compras_distrib
integer x = 41
integer y = 88
integer width = 2409
integer height = 480
string dataobject = "dw_ge262_selecao"
end type

event dw_1::losefocus;call super::losefocus;IF IsValid(ivo_filial) THEN
	dw_1.Object.De_filial[1] = ivo_filial.nm_fantasia
END IF

end event

event dw_1::ue_key;call super::ue_key;If This.GetColumnName() = "de_filial" Then
	
	If Key = KeyEnter! Then
		ivo_filial.Of_Localiza_Filial(This.GetText())

		If ivo_Filial.Localizada Then
			dw_1.Object.cd_filial[1] = ivo_filial.cd_filial
			dw_1.Object.de_filial[1] = ivo_filial.nm_fantasia
		End If
	End If
End If



end event

event dw_1::itemchanged;call super::itemchanged;If This.GetColumnName() = "de_filial" Then
	If Not IsNull(Data) and Data <> "" Then
		If Trim(Data) <> ivo_Filial.nm_fantasia Then
			Return 1
		End If 
	Else
		ivo_Filial.of_Inicializa()
		
		dw_1.Object.cd_filial[1] = ivo_Filial.cd_filial
		dw_1.Object.de_filial[1] = ivo_Filial.nm_fantasia
	End If
End If

cb_calcular.Enabled = False
end event

event dw_1::editchanged;call super::editchanged;cb_calcular.Enabled = False
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge262_consulta_notas_compras_distrib
integer x = 50
integer y = 624
integer width = 3483
integer height = 1192
string dataobject = "dw_ge262_lista_notas_compras_distrib"
end type

event dw_2::ue_recuperar;//OverRide

Date lvdt_Inicial, &
	 lvdt_Final

Long lvl_Filial

Integer lvi_Pedido

String lvs_Distribuidora,&
		 lvs_Tipo_Filial,&
       lvs_Agrupar_Geral,&
	   lvs_Agrupar_Filial,&
	   lvs_DataWindow1,&
	   lvs_DataWindow2,&
	   lvs_ordenar_distribuidora,&
	   lvs_ordenar_filial

String lvs_Considera_Manuais

dw_1.AcceptText()

lvl_Filial         					= dw_1.Object.cd_filial        			[1]
lvdt_Inicial       					= dw_1.Object.dt_inicio        			[1]
lvdt_Final         				= dw_1.Object.dt_termino       			[1]
lvs_Distribuidora  				= dw_1.Object.cd_distribuidora 		[1]
lvs_Tipo_Filial    				= dw_1.Object.id_tipo_filial   			[1]
lvi_Pedido         				= dw_1.Object.nr_pedido        			[1]
lvs_Agrupar_Geral  			= dw_1.Object.id_agrupar_geral 		[1]
lvs_Agrupar_Filial 				= dw_1.Object.id_agrupar_filial		[1]
lvs_ordenar_distribuidora	= dw_1.Object.id_ordenar_distrib		[1]
lvs_ordenar_filial 				= dw_1.object.id_ordenar_filial			[1]
lvs_Considera_Manuais		= dw_1.object.id_notas_manuais		[1]

If lvs_Agrupar_Geral = 'S' Then
	lvs_DataWindow1 = 'dw_ge262_lista_notas_compras_dist_total'
	lvs_DataWindow2 = 'dw_ge262_relat_notas_compras_dist_total'
ElseIf lvs_Agrupar_Filial = 'S' Then
	lvs_DataWindow1 = 'dw_ge262_lista_notas_compras_dist_filial'
	lvs_DataWindow2 = 'dw_ge262_relat_notas_compras_dist_filial'
ElseIf lvs_ordenar_distribuidora = 'S' Then
	lvs_DataWindow1 =  'dw_ge262_lista_notas_compras_distrib'
	lvs_DataWindow2 = 'dw_ge262_relat_notas_compras_distrib'	
ElseIf lvs_ordenar_filial = 'S' Then
	lvs_DataWindow1 = 'dw_ge262_lista_notas_compras_filial_distrib'
	lvs_DataWindow2 = 'dw_ge262_relat_notas_compras_filial_distrib'	
Else
	lvs_DataWindow1 = 'dw_ge262_lista_notas_compras_distrib'
	lvs_DataWindow2 = 'dw_ge262_relat_notas_compras_distrib'	
End If

If Not dw_2.of_ChangeDataObject(lvs_DataWindow1) Then
	Return -1
End If

If Not dw_3.of_ChangeDataObject(lvs_DataWindow2) Then
	Return -1
End If

If IsNull(lvdt_Inicial) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data do in$$HEX1$$ed00$$ENDHEX$$cio corretamente.")
	dw_1.SetFocus()
	dw_1.Event ue_Pos(1, "dt_inicio")
	Return -1
End If

If IsNull(lvdt_Final) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data do t$$HEX1$$e900$$ENDHEX$$rmino corretamente.")
	dw_1.SetFocus()
	dw_1.Event ue_Pos(1, "dt_termino")
	Return -1
End If
		 
If Not IsNull(lvl_Filial) Then
	dw_2.of_AppendWhere("nf_compra.cd_filial = " + String(lvl_Filial) )	
End If

If lvs_tipo_filial = '1' Then
	dw_2.of_AppendWhere("parametro_loja.vl_parametro <> 'DP'")
End If

If lvs_tipo_filial = '2' Then
	dw_2.of_AppendWhere("parametro_loja.vl_parametro = 'DP'")
End If

If lvs_distribuidora <> "000000000" Then
	dw_2.of_AppendWhere("nf_compra.cd_fornecedor = " + "'" + String(lvs_distribuidora) + "'")	
End If

If Not IsNull(lvi_Pedido) Then
	dw_2.of_AppendWhere("nf_compra.nr_pedido_distribuidora = " + String(lvi_Pedido))	
End If

If lvs_Considera_Manuais = "N" Then
	dw_2.of_AppendWhere("nf_compra.cd_filial_pedido is not null ")	
	dw_3.of_AppendWhere("nf_compra.cd_filial_pedido is not null ")	
End If

dw_3.Object.st_periodo.text = String(lvdt_inicial,"dd/mm/yyyy") + ' at$$HEX1$$e900$$ENDHEX$$: ' + String(lvdt_final  ,"dd/mm/yyyy")

dw_2.of_AppendWhere("nf_compra.dh_movimentacao_caixa between '" + String(lvdt_Inicial,"yyyymmdd") + "' and '" + String(lvdt_Final  ,"yyyymmdd") + "'")

Return This.Retrieve()
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;cb_calcular.Enabled = pl_Linhas > 0
This.ivm_menu.mf_salvarcomo( pl_linhas > 0 )

This.ShareData(dw_3)
This.of_SetRowSelection()

Return pl_Linhas
end event

event dw_2::ue_reset;call super::ue_reset;This.ivm_menu.mf_salvarcomo( False )
end event

event dw_2::ue_saveas;//Override
dw_3.Event ue_saveas( )
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge262_consulta_notas_compras_distrib
integer x = 2501
integer y = 40
integer width = 430
integer height = 532
integer taborder = 60
string dataobject = "dw_ge262_relat_notas_compras_distrib"
end type

type cb_calcular from commandbutton within w_ge262_consulta_notas_compras_distrib
integer x = 3003
integer y = 404
integer width = 526
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "&Calcular Grupos"
end type

event clicked;String lvs_Agrupar_Geral,&
	   lvs_Agrupar_Filial
	   
dw_1.AcceptText()

lvs_Agrupar_Geral  = dw_1.Object.id_agrupar_geral [1]
lvs_Agrupar_Filial = dw_1.Object.id_agrupar_filial[1]

If lvs_Agrupar_Geral = 'S' Then
	wf_Calcular_Distribuidora_Data()
ElseIf lvs_Agrupar_Filial = 'S' Then
	wf_Calcular_Distribuidora_Filial()
Else
	wf_Calcular_Distribuidora()
End If


end event

type dw_4 from dc_uo_dw_base within w_ge262_consulta_notas_compras_distrib
boolean visible = false
integer x = 2967
integer y = 40
integer width = 558
integer height = 328
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge262_calcula_notas_compras_distrib"
end type

