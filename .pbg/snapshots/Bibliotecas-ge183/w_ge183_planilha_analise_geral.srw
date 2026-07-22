HA$PBExportHeader$w_ge183_planilha_analise_geral.srw
forward
global type w_ge183_planilha_analise_geral from dc_w_response
end type
type cb_gerar from commandbutton within w_ge183_planilha_analise_geral
end type
type cb_sair from commandbutton within w_ge183_planilha_analise_geral
end type
type gb_1 from groupbox within w_ge183_planilha_analise_geral
end type
type dw_1 from dc_uo_dw_base within w_ge183_planilha_analise_geral
end type
end forward

global type w_ge183_planilha_analise_geral from dc_w_response
integer x = 197
integer y = 524
integer width = 1499
integer height = 568
string title = "GE183 - Planilha para An$$HEX1$$e100$$ENDHEX$$lise Geral"
boolean controlmenu = false
long backcolor = 80269528
cb_gerar cb_gerar
cb_sair cb_sair
gb_1 gb_1
dw_1 dw_1
end type
global w_ge183_planilha_analise_geral w_ge183_planilha_analise_geral

type variables
uo_filial ivo_filial


end variables

forward prototypes
public function decimal wf_desconto_sos (long al_produto)
public function long wf_saldo_matriz (long al_produto, date adt_saldo)
public subroutine wf_dados_resumo_geral (long al_produto, ref dc_uo_ds_base ads, ref decimal adc_preco, ref decimal adc_comissao, ref long al_qtde_venda, ref long al_saldo, ref decimal adc_custo)
public subroutine wf_dados_resumo_filial (long al_produto, ref dc_uo_ds_base ads, ref decimal adc_preco, ref decimal adc_comissao, ref long al_qtde_venda, ref decimal adc_custo)
public subroutine wf_saldo_filial (long al_produto, date adt_saldo, long al_filial, ref long al_saldo, ref decimal adc_custo)
end prototypes

public function decimal wf_desconto_sos (long al_produto);Decimal lvdc_Desconto

Select b.pc_desconto Into :lvdc_Desconto 
From promocao_sos a, 
	  promocao_sos_produto b,
	  parametro p
Where a.cd_promocao_sos = b.cd_promocao_sos
  and b.cd_produto = :al_Produto
  and a.id_situacao = 'L'
  and a.id_tipo_promocao = 'S'
  and a.dh_inicio <= p.dh_movimentacao
  and (a.dh_termino >= p.dh_movimentacao or a.dh_termino Is Null)
Using SqlCa;
		
Choose Case SqlCa.SqlCode
	Case 0
	Case 100
		lvdc_Desconto = 0
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Desconto SOS")
		lvdc_Desconto = 0
End Choose

Return lvdc_Desconto
end function

public function long wf_saldo_matriz (long al_produto, date adt_saldo);Long lvl_Saldo

Select sum(s.qt_saldo_final * p.vl_fator_conversao) Into :lvl_saldo
From saldo_produto s,
     produto_geral p
Where s.cd_filial in (1, 534)
  and s.cd_produto = :al_Produto
  and s.dh_saldo   = :adt_Saldo  
  and p.cd_produto = s.cd_produto
Using SqlCa;

Choose Case SqlCa.SqlCode 
	Case 0
	Case 100
		lvl_Saldo = 0
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Saldo da Matriz")		
		lvl_Saldo = 0
End Choose

Return lvl_Saldo
end function

public subroutine wf_dados_resumo_geral (long al_produto, ref dc_uo_ds_base ads, ref decimal adc_preco, ref decimal adc_comissao, ref long al_qtde_venda, ref long al_saldo, ref decimal adc_custo);Long lvl_Linha

lvl_Linha = ads.Find("cd_produto = " + String(al_Produto), 1, ads.RowCount())

If lvl_Linha > 0 Then
	adc_Preco     = ads.Object.Vl_Venda   [lvl_Linha]
	adc_Comissao  = ads.Object.Vl_Comissao[lvl_Linha]
	al_Qtde_Venda = ads.Object.Qt_Venda   [lvl_Linha]
	al_Saldo      = ads.Object.Qt_Saldo   [lvl_Linha]
	adc_Custo     = ads.Object.Vl_CMV     [lvl_Linha]
Else
	adc_Preco     = 0
	adc_Comissao  = 0
	al_Qtde_Venda = 0
	al_Saldo      = 0
	adc_Custo     = 0
End If
end subroutine

public subroutine wf_dados_resumo_filial (long al_produto, ref dc_uo_ds_base ads, ref decimal adc_preco, ref decimal adc_comissao, ref long al_qtde_venda, ref decimal adc_custo);Long lvl_Linha

lvl_Linha = ads.Find("cd_produto = " + String(al_Produto), 1, ads.RowCount())

If lvl_Linha > 0 Then
	adc_Preco     = ads.Object.Vl_Venda   [lvl_Linha]
	adc_Comissao  = ads.Object.Vl_Comissao[lvl_Linha]
	al_Qtde_Venda = ads.Object.Qt_Venda   [lvl_Linha]
	adc_Custo     = ads.Object.Vl_CMV     [lvl_Linha]
Else
	adc_Preco     = 0
	adc_Comissao  = 0
	al_Qtde_Venda = 0
	adc_Custo     = 0
End If
end subroutine

public subroutine wf_saldo_filial (long al_produto, date adt_saldo, long al_filial, ref long al_saldo, ref decimal adc_custo);Select qt_saldo_final,
       vl_custo_medio
Into :al_Saldo,
     :adc_Custo
From saldo_produto
Where cd_filial  = :al_Filial
  and cd_produto = :al_Produto
  and dh_saldo   = :adt_Saldo  
Using SqlCa;

Choose Case SqlCa.SqlCode 
	Case 0
		
	Case 100
		al_Saldo  = 0
		adc_Custo = 0
		
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Saldo da Filial")		
		al_Saldo  = 0
		adc_Custo = 0
End Choose
end subroutine

on w_ge183_planilha_analise_geral.create
int iCurrent
call super::create
this.cb_gerar=create cb_gerar
this.cb_sair=create cb_sair
this.gb_1=create gb_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_gerar
this.Control[iCurrent+2]=this.cb_sair
this.Control[iCurrent+3]=this.gb_1
this.Control[iCurrent+4]=this.dw_1
end on

on w_ge183_planilha_analise_geral.destroy
call super::destroy
destroy(this.cb_gerar)
destroy(this.cb_sair)
destroy(this.gb_1)
destroy(this.dw_1)
end on

event ue_postopen;call super::ue_postopen;dw_1.Event ue_AddRow()
dw_1.SetFocus()

ivo_Filial = Create uo_Filial

end event

event close;call super::close;Destroy(ivo_Filial)

end event

type pb_help from dc_w_response`pb_help within w_ge183_planilha_analise_geral
end type

type cb_gerar from commandbutton within w_ge183_planilha_analise_geral
integer x = 581
integer y = 364
integer width = 466
integer height = 88
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Gerar Planilha"
end type

event clicked;Long lvl_Contador, &
     lvl_Total, &
	  lvl_Produto, &
	  lvl_Saldo_Matriz, &
	  lvl_Saldo_Filiais, &
	  lvl_Filial, &
	  lvl_Linha, &
	  lvl_Qt_Venda, &
	  lvl_saldo_total, & 
	  lvl_qt_venda_total 

Decimal lvdc_Custo_Medio, &
		  lvdc_Preco_Venda, &
		  lvdc_Desc_Venda, &
		  lvdc_Imposto, &
		  lvdc_Comissao, &
		  lvdc_Valor_Total, &
	     lvdc_bruta_total, &   
	     lvdc_desconto_total, &
		  lvdc_liquida_total, & 
		  lvdc_cmv_total, &     
		  lvdc_comissao_total, &
 		  lvdc_imposto_total, & 
		  lvdc_estoque_total, &
		  lvdc_Custo_Praticado, &
		  lvdc_Venda_Praticado, &
		  lvdc_Percentual_ICMS

Date lvdt_Base

Time lvt_Inicio, &
     lvt_Termino

String lvs_Diretorio, &
       lvs_Arquivo, &
		 lvs_DW, &
		 lvs_Tributacao_ICMS, &
		 lvs_id_sintetico, &
		 lvs_agrupamento,&
		 lvs_grupo, &
		 lvs_subgrupo, &
		 lvs_pis_cofins, &
		 lvs_fornecedor

Integer lvi_sequencial

dw_1.AcceptText()

lvl_Filial       = dw_1.Object.Cd_Filial   [1]
lvdt_Base        = dw_1.Object.Dt_Base     [1]
lvs_id_sintetico = dw_1.Object.Id_Sintetico[1]

If Not IsNull(lvl_Filial) and lvl_Filial <> 0 Then
	lvs_DW = "dw_ge183_planilha_analitica_filial"
Else
	lvs_DW = "dw_ge183_planilha_analitica_geral"
End If

If IsNull(lvdt_Base) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe corretamente o m$$HEX1$$ea00$$ENDHEX$$s/ano para gera$$HEX2$$e700e300$$ENDHEX$$o da planilha.", StopSign!)
	dw_1.Event ue_Pos(1, "dt_base")
	Return
End If

lvs_Diretorio = gvo_Aplicacao.of_GetFromINI("Diretorio", "Diretorio")

dc_uo_ds_Base lvds_1
lvds_1 = Create dc_uo_ds_Base
If Not lvds_1.of_ChangeDataObject(lvs_DW) Then Return

dc_uo_ds_Base lvds_2
lvds_2 = Create dc_uo_ds_Base
If Not lvds_2.of_ChangeDataObject("dw_ge183_resumo_filial") Then Return

dc_uo_ds_Base lvds_3
lvds_3 = Create dc_uo_ds_Base
If Not lvds_3.of_ChangeDataObject("dw_ge183_planilha_sintetica") Then Return

dc_uo_ds_Base lvds_4
lvds_4 = Create dc_uo_ds_Base
If Not lvds_4.of_ChangeDataObject("dw_ge183_resumo_geral") Then Return

lvt_Inicio = Now()

SetPointer(HourGlass!)
Open(w_Aguarde)
w_Aguarde.Title = "Localizando os Produtos..."

lvl_Total = lvds_1.Retrieve()

If lvl_Total > 0 Then
	w_Aguarde.Title = "Verificando Dados do Resumo..."
	
	If Not IsNull(lvl_Filial) and lvl_Filial <> 0 Then
		lvds_2.Retrieve(lvdt_Base, lvl_Filial)
	Else
		lvds_4.Retrieve(lvdt_Base)
	End If
	
	w_Aguarde.Title = "Gerando Planilha..."
	w_Aguarde.uo_Progress.of_SetMax(lvl_Total)

   lvdc_valor_total    = 0.00
	lvl_saldo_total     = 0
	lvl_qt_venda_total  = 0
	lvdc_bruta_total    = 0.00
	lvdc_desconto_total = 0.00
	lvdc_liquida_total  = 0.00
	lvdc_cmv_total      = 0.00
	lvdc_comissao_total = 0.00
 	lvdc_imposto_total  = 0.00
	lvdc_estoque_total  = 0.00

	For lvl_Contador = 1 To lvl_Total
		lvl_Produto          = lvds_1.Object.Cd_Produto            [lvl_Contador]
		lvs_Tributacao_ICMS  = lvds_1.Object.Cd_Tributacao_ICMS    [lvl_Contador]
		lvs_grupo            = lvds_1.Object.De_Grupo_Produto      [lvl_Contador]
		lvs_subgrupo         = lvds_1.Object.De_Subgrupo_Produto   [lvl_Contador]
		lvs_pis_cofins       = lvds_1.Object.Id_Situacao_Pis_Cofins[lvl_Contador]
		lvdc_Preco_Venda     = lvds_1.Object.vl_preco_venda_atual  [lvl_Contador]
		lvdc_Desc_Venda      = lvds_1.Object.pc_desconto_atual     [lvl_Contador]
      lvdc_Custo_Medio     = lvds_1.Object.vl_custo_medio	     [lvl_Contador]
		lvs_fornecedor       = lvds_1.Object.cd_fornecedor_usual   [lvl_Contador]		
		lvdc_Percentual_ICMS = lvds_1.Object.Pc_ICMS               [lvl_Contador]
		
		lvds_1.Object.Pc_Desconto_SOS[lvl_Contador] = wf_Desconto_SOS(lvl_Produto)
			
		If Not IsNull(lvl_Filial) and lvl_Filial <> 0 Then
			wf_Saldo_Filial(lvl_Produto, lvdt_Base, lvl_Filial, ref lvl_Saldo_Filiais, ref lvdc_Custo_Medio)
			
			wf_Dados_Resumo_Filial(lvl_Produto, lvds_2, ref lvdc_Venda_Praticado, ref lvdc_Comissao, ref lvl_Qt_Venda, ref lvdc_Custo_Praticado)
			
			lvds_1.Object.Qt_Saldo_Filial[lvl_Contador] = lvl_Saldo_Filiais
			lvds_1.Object.Vl_Custo_Medio [lvl_Contador] = lvdc_Custo_Medio
		Else
			lvl_Saldo_Matriz = wf_Saldo_Matriz(lvl_Produto, lvdt_Base)
			
			wf_Dados_Resumo_Geral(lvl_Produto, lvds_4, ref lvdc_Venda_Praticado, ref lvdc_Comissao, ref lvl_Qt_Venda, ref lvl_Saldo_Filiais, ref lvdc_Custo_Praticado)
			
			lvds_1.Object.Qt_Saldo_Matriz [lvl_Contador] = lvl_Saldo_Matriz
			lvds_1.Object.Qt_Saldo_Filiais[lvl_Contador] = lvl_Saldo_Filiais - lvl_Saldo_Matriz
		End If
		
		// Calcula Rentabilidade, Impostos
		// Verifica o ICMS
		If lvs_Tributacao_ICMS = "1" Then
			lvdc_Imposto = Round(Round(lvdc_Preco_Venda * lvl_Qt_Venda, 2) * lvdc_Percentual_ICMS / 100, 2)
		Else
			lvdc_Imposto = Round(lvdc_Venda_Praticado * lvdc_Percentual_ICMS / 100, 2)
		End If

		// Verifica o PIS/COFINS
		If lvs_Pis_Cofins = "T" Then
		   lvdc_Imposto += Round(lvdc_Venda_Praticado * 3.75 / 100, 2)
		End If			

		// Atualiza os dados na planilha anal$$HEX1$$ed00$$ENDHEX$$tica
		lvds_1.Object.Qt_Venda_Mes      [lvl_Contador] = lvl_Qt_Venda
		lvds_1.Object.Vl_Venda_Praticado[lvl_Contador] = lvdc_Venda_Praticado
		lvds_1.Object.Vl_Custo_Praticado[lvl_Contador] = lvdc_Custo_Praticado
		lvds_1.Object.Vl_Comissao       [lvl_Contador] = lvdc_Comissao
		lvds_1.Object.Vl_Imposto        [lvl_Contador] = lvdc_Imposto

		// Planilha Sint$$HEX1$$e900$$ENDHEX$$tica
		If lvs_Id_Sintetico = 'S' Then
			If lvl_Saldo_Filiais < 0 Then
				lvl_Saldo_Filiais = 0
			End If

			// Verifica a qual Agrupamento Pertence
			If lvs_subgrupo = 'CREDITOS GLOBAL TELECOM' Then
				lvi_sequencial = 9
				lvs_agrupamento = 'CREDITO VIRTUAL'
			ElseIf lvl_produto = 684431 Then
				lvi_sequencial = 10
				lvs_agrupamento = 'PRODUTO MANIPULADO'
			ElseIf lvs_grupo = 'CONVENI$$HEX1$$ca00$$ENDHEX$$NCIA' Then
				lvi_sequencial = 1
				lvs_agrupamento = 'CONVENIENCIA'
			ElseIf lvs_grupo = 'MEDICAMENTOS' and lvs_subgrupo = 'GEN$$HEX1$$c900$$ENDHEX$$RICOS' Then
				lvi_sequencial = 2
				lvs_agrupamento = 'GENERICOS'
			ElseIf lvs_grupo = 'JORNAIS, REVISTAS E CARTOES' Then
				lvi_sequencial = 3
				lvs_agrupamento = 'REVISTAS'
			ElseIf lvs_grupo = 'MEDICAMENTOS' and lvs_pis_cofins <> 'P' Then
				lvi_sequencial = 4
				lvs_agrupamento = 'MED NEGATIVO'
			ElseIf lvs_grupo = 'MEDICAMENTOS' and lvs_pis_cofins = 'P' Then
				lvi_sequencial = 5
				lvs_agrupamento = 'MED POSITIVO'
			ElseIF lvs_grupo = 'PERFUMARIA GERAL' Then
				lvi_sequencial = 6
				lvs_agrupamento = 'PERFUMARIA'
			Else
				lvi_sequencial = 7
				lvs_agrupamento = 'POPULARES'
			End If
			
//			If lvl_produto = 684431 Then
//				lvdc_CMV_Produto = Round(lvdc_Preco_Medio * 0.21, 2)
//			Else
//				lvdc_CMV_Produto = Round(lvl_Qt_Venda * lvdc_Custo_Medio, 2)
//			End If
			
			// Soma totais
			If lvi_sequencial <= 7 Then
				lvdc_valor_total    = lvdc_valor_total + lvdc_Venda_Praticado
				lvl_saldo_total     = lvl_saldo_total + lvl_Saldo_Filiais
			   lvl_qt_venda_total  = lvl_qt_venda_total + lvl_Qt_Venda
		   	lvdc_bruta_total    = lvdc_bruta_total + (lvl_Qt_Venda * lvdc_Preco_Venda)
		   	lvdc_desconto_total = lvdc_desconto_total + (lvl_Qt_Venda * round(lvdc_Preco_Venda * (lvdc_Desc_Venda / 100),2))
			   lvdc_liquida_total  = lvdc_liquida_total + (lvl_Qt_Venda * round(lvdc_Preco_Venda - (lvdc_Preco_Venda * (lvdc_Desc_Venda / 100)),2))
			   lvdc_cmv_total      = lvdc_cmv_total + lvdc_Custo_Praticado
		   	lvdc_comissao_total = lvdc_comissao_total + lvdc_Comissao
	 		   lvdc_imposto_total  = lvdc_imposto_total + lvdc_Imposto
			   lvdc_estoque_total  = lvdc_estoque_total + (lvl_Saldo_Filiais * lvdc_Custo_Medio)
			End If
			// Grava na DW Sint$$HEX1$$e900$$ENDHEX$$tica	
			lvl_Linha = lvds_3.Find("sequencial = " + string(lvi_sequencial),1,lvds_3.RowCount())
			If lvl_Linha <= 0 Then
				lvl_Linha = lvds_3.InsertRow(0)
				lvds_3.Object.sequencial[lvl_Linha]      = lvi_sequencial
				lvds_3.Object.grupo[lvl_Linha]           = lvs_agrupamento
				lvds_3.Object.saldo[lvl_Linha]           = lvl_Saldo_Filiais
				lvds_3.Object.qtde_vendas[lvl_Linha]     = lvl_Qt_Venda
				lvds_3.Object.venda_bruta[lvl_Linha]     = lvl_Qt_Venda * lvdc_Preco_Venda
				lvds_3.Object.desconto[lvl_Linha]        = lvl_Qt_Venda * round(lvdc_Preco_Venda * (lvdc_Desc_Venda / 100),2)
				lvds_3.Object.venda_liquida[lvl_Linha]   = lvl_Qt_Venda * round(lvdc_Preco_Venda - (lvdc_Preco_Venda * (lvdc_Desc_Venda / 100)),2)
				lvds_3.Object.preco_praticado[lvl_Linha] = lvdc_Venda_Praticado
				lvds_3.Object.cmv[lvl_Linha]             = lvdc_Custo_Praticado
				lvds_3.Object.comissao[lvl_Linha]        = lvdc_Comissao
				lvds_3.Object.imposto[lvl_Linha]         = lvdc_Imposto
				lvds_3.Object.estoque[lvl_Linha]         = lvl_Saldo_Filiais * lvdc_Custo_Medio
			Else
				lvds_3.Object.saldo[lvl_Linha]           = lvds_3.Object.saldo[lvl_Linha] + lvl_Saldo_Filiais
				lvds_3.Object.qtde_vendas[lvl_Linha]     = lvds_3.Object.qtde_vendas[lvl_Linha] + lvl_Qt_Venda
				lvds_3.Object.venda_bruta[lvl_Linha]     = lvds_3.Object.venda_bruta[lvl_Linha] + (lvl_Qt_Venda * lvdc_Preco_Venda)
				lvds_3.Object.desconto[lvl_Linha]        = lvds_3.Object.desconto[lvl_Linha] + (lvl_Qt_Venda * round(lvdc_Preco_Venda * (lvdc_Desc_Venda / 100),2))
				lvds_3.Object.venda_liquida[lvl_Linha]   = lvds_3.Object.venda_liquida[lvl_Linha] + (lvl_Qt_Venda * round(lvdc_Preco_Venda - (lvdc_Preco_Venda * (lvdc_Desc_Venda / 100)),2))
				lvds_3.Object.preco_praticado[lvl_Linha] = lvds_3.Object.preco_praticado[lvl_Linha] + lvdc_Venda_Praticado
				lvds_3.Object.cmv[lvl_Linha]             = lvds_3.Object.cmv[lvl_Linha] + lvdc_Custo_Praticado
				lvds_3.Object.comissao[lvl_Linha]        = lvds_3.Object.comissao[lvl_Linha] + lvdc_Comissao
				lvds_3.Object.imposto[lvl_Linha]         = lvds_3.Object.imposto[lvl_Linha] + lvdc_Imposto
				lvds_3.Object.estoque[lvl_Linha]         = lvds_3.Object.estoque[lvl_Linha] + (lvl_Saldo_Filiais * lvdc_Custo_Medio)
			End If
		End If
		
		w_Aguarde.uo_Progress.of_SetProgress(lvl_Contador)	
	Next

	// Grava Planilha
	w_Aguarde.Title = "Salvando Planilha..."
	
   If lvs_id_sintetico = 'S' Then
		If Not IsNull(lvl_Filial) and lvl_Filial <> 0 Then
			lvs_Arquivo = lvs_Diretorio + "Rentabilidade " + Trim(dw_1.Object.nm_filial[1]) + " " + &
													String(lvdt_Base, "mmyyyy") + ".xls"
		Else
			lvs_Arquivo = lvs_Diretorio + "Rentabilidade_Geral_" + String(lvdt_Base, "mmyyyy") + ".xls"
		End If
	Else
		If Not IsNull(lvl_Filial) and lvl_Filial <> 0 Then
			lvs_Arquivo = lvs_Diretorio + "analise_filial_" + String(lvl_Filial, "0000") + "_" + &
													String(Today(), "ddmm") + "_" + String(Now(), "hhmm") + ".xls"
		Else
			lvs_Arquivo = lvs_Diretorio + "analise_geral_" + &
												String(Today(), "ddmm") + "_" + String(Now(), "hhmm") + ".xls"
		End If
	End If

   If lvs_id_sintetico = 'S' Then
		// Sumariza
		lvl_Linha = lvds_3.InsertRow(0)
		lvds_3.Object.sequencial[lvl_Linha]      = 8
		lvds_3.Object.grupo[lvl_Linha]           = 'TOTAL 1-7'
		lvds_3.Object.saldo[lvl_Linha]           = lvl_saldo_total
		lvds_3.Object.qtde_vendas[lvl_Linha]     = lvl_qt_venda_total 
		lvds_3.Object.venda_bruta[lvl_Linha]     = lvdc_bruta_total
		lvds_3.Object.desconto[lvl_Linha]        = lvdc_desconto_total
		lvds_3.Object.venda_liquida[lvl_Linha]   = lvdc_liquida_total
		lvds_3.Object.preco_praticado[lvl_Linha] = lvdc_Valor_Total
		lvds_3.Object.cmv[lvl_Linha]             = lvdc_cmv_total
		lvds_3.Object.comissao[lvl_Linha]        = lvdc_comissao_total
		lvds_3.Object.imposto[lvl_Linha]         = lvdc_imposto_total
		lvds_3.Object.estoque[lvl_Linha]         = lvdc_estoque_total
		
		// Calcula Percentuais
		lvl_Total = lvds_3.Rowcount()
		For lvl_linha = 1 to lvl_total
			 If lvds_3.Object.preco_praticado[lvl_Linha] > 0.00 Then
				 lvds_3.Object.rentabilidade[lvl_Linha]  = lvds_3.Object.preco_praticado[lvl_Linha] - lvds_3.Object.cmv[lvl_Linha] - lvds_3.Object.imposto[lvl_Linha] - lvds_3.Object.comissao[lvl_Linha]
				 lvds_3.Object.pc_rentab[lvl_Linha]      = round((lvds_3.Object.rentabilidade[lvl_Linha] / lvds_3.Object.preco_praticado[lvl_Linha])*100,2)
				 lvds_3.Object.pc_imposto[lvl_Linha]     = round((lvds_3.Object.imposto[lvl_Linha] / lvds_3.Object.preco_praticado[lvl_Linha])*100,2)
				 lvds_3.Object.pc_comissao[lvl_Linha]    = round((lvds_3.Object.comissao[lvl_Linha] / lvds_3.Object.preco_praticado[lvl_Linha])*100,2)
 				 lvds_3.Object.pc_cmv[lvl_Linha]         = round((lvds_3.Object.cmv[lvl_Linha] / lvds_3.Object.preco_praticado[lvl_Linha])*100,2)
				 If lvds_3.Object.sequencial[lvl_Linha] <= 8 Then
	  			 	 lvds_3.Object.pc_faturamento[lvl_Linha] = round((lvds_3.Object.preco_praticado[lvl_Linha] / lvdc_Valor_Total)*100,2)
				 End If
				 If lvds_3.Object.cmv[lvl_Linha] > 0 Then
	  			 	 lvds_3.Object.giro[lvl_Linha] = round((lvds_3.Object.estoque[lvl_Linha] / lvds_3.Object.cmv[lvl_Linha])*30,2)
				 End If
			 End If
		Next		
		lvds_3.SetSort("sequencial A")
		lvds_3.Sort()
				
		If lvds_3.SaveAs(lvs_Arquivo, Excel!, True) = 1 Then
			lvt_Termino = Now()
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Planilha '" + lvs_Arquivo + "' gerada com sucesso.~r~r" + &
			                      "In$$HEX1$$ed00$$ENDHEX$$cio: "  + String(lvt_Inicio , "hh:mm:ss") + "~r" + &
										 "T$$HEX1$$e900$$ENDHEX$$rmino: " + String(lvt_Termino, "hh:mm:ss"), Information!)
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no saveas da planilha '" + lvs_Arquivo + "'.", StopSign!)
		End If
	Else
		If lvds_1.SaveAs(lvs_Arquivo, Excel!, True) = 1 Then
			lvt_Termino = Now()
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Planilha '" + lvs_Arquivo + "' gerada com sucesso.~r~r" + &
			                      "In$$HEX1$$ed00$$ENDHEX$$cio: "  + String(lvt_Inicio , "hh:mm:ss") + "~r" + &
										 "T$$HEX1$$e900$$ENDHEX$$rmino: " + String(lvt_Termino, "hh:mm:ss"), Information!)
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no saveas da planilha '" + lvs_Arquivo + "'.", StopSign!)
		End If
	End If
End If

Destroy(lvds_1)
Destroy(lvds_2)
Destroy(lvds_3)
Destroy(lvds_4)

Close(w_Aguarde)
SetPointer(Arrow!)

end event

type cb_sair from commandbutton within w_ge183_planilha_analise_geral
integer x = 1070
integer y = 364
integer width = 379
integer height = 88
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Sai&r"
boolean cancel = true
end type

event clicked;Close(Parent)
end event

type gb_1 from groupbox within w_ge183_planilha_analise_geral
integer x = 23
integer y = 8
integer width = 1426
integer height = 324
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
borderstyle borderstyle = styleraised!
end type

type dw_1 from dc_uo_dw_base within w_ge183_planilha_analise_geral
integer x = 46
integer y = 80
integer width = 1385
integer height = 212
boolean bringtotop = true
string dataobject = "dw_ge183_selecao"
end type

event itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case "nm_filial"
		If Trim(Data) <> "" Then
			If Data <> ivo_Filial.Nm_Fantasia Then
				Return 1
			End If
		Else
			SetNull(ivo_Filial.Cd_Filial)
			ivo_Filial.Nm_Fantasia = ""
			
			This.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial
			This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
		End If
End Choose		
end event

event losefocus;call super::losefocus;If IsValid(ivo_Filial) Then
	This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
End If
end event

event ue_key;call super::ue_key;If This.GetColumnName() = "nm_filial" Then
	If Key = KeyEnter! Then
		ivo_Filial.of_Localiza_Filial(This.GetText())
		
		If ivo_Filial.Localizada Then
			This.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial
			This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
		End If
	End If
End If
end event

