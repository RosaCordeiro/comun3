HA$PBExportHeader$w_resumo_faturamento.srw
forward
global type w_resumo_faturamento from dc_w_sheet
end type
type dw_selecao from dc_uo_dw_base within w_resumo_faturamento
end type
type ln_2 from line within w_resumo_faturamento
end type
type ln_1a from line within w_resumo_faturamento
end type
type ln_1 from line within w_resumo_faturamento
end type
type ln_2e from line within w_resumo_faturamento
end type
type ln_2c from line within w_resumo_faturamento
end type
type ln_2b from line within w_resumo_faturamento
end type
type ln_2a from line within w_resumo_faturamento
end type
type cb_2 from commandbutton within w_resumo_faturamento
end type
type dw_3 from dc_uo_dw_base within w_resumo_faturamento
end type
type dw_1 from dc_uo_dw_base within w_resumo_faturamento
end type
type dw_relatorio from dc_uo_dw_base within w_resumo_faturamento
end type
type dw_relatorio_2 from dc_uo_dw_base within w_resumo_faturamento
end type
type gb_1 from groupbox within w_resumo_faturamento
end type
type dw_cd from dc_uo_dw_base within w_resumo_faturamento
end type
type ln_3 from line within w_resumo_faturamento
end type
type ln_2d from line within w_resumo_faturamento
end type
type dw_pro from dc_uo_dw_base within w_resumo_faturamento
end type
type dw_pp from dc_uo_dw_base within w_resumo_faturamento
end type
type dw_man from dc_uo_dw_base within w_resumo_faturamento
end type
type dw_far from dc_uo_dw_base within w_resumo_faturamento
end type
type dw_dcp from dc_uo_dw_base within w_resumo_faturamento
end type
type dw_dfc from dc_uo_dw_base within w_resumo_faturamento
end type
end forward

global type w_resumo_faturamento from dc_w_sheet
integer width = 5536
integer height = 2524
string title = "GE234 - Resumo de Faturamento"
boolean resizable = false
long backcolor = 80269524
dw_selecao dw_selecao
ln_2 ln_2
ln_1a ln_1a
ln_1 ln_1
ln_2e ln_2e
ln_2c ln_2c
ln_2b ln_2b
ln_2a ln_2a
cb_2 cb_2
dw_3 dw_3
dw_1 dw_1
dw_relatorio dw_relatorio
dw_relatorio_2 dw_relatorio_2
gb_1 gb_1
dw_cd dw_cd
ln_3 ln_3
ln_2d ln_2d
dw_pro dw_pro
dw_pp dw_pp
dw_man dw_man
dw_far dw_far
dw_dcp dw_dcp
dw_dfc dw_dfc
end type
global w_resumo_faturamento w_resumo_faturamento

type variables
uo_parametro_janelas iuo_parametro
dc_uo_ds_base ivds_2, ivds_4, ivds_4a, ivds_5, ivds_6, &
                 ivds_6a, ivds_6b, ivds_7, ivds_8, ivds_9

					  
long ivl_Filial_Ecommerce


/// DisqueEntrega Cotas - Mes/Ano/Dia
dc_uo_ds_base ivds_6d, ivds_4d, ivds_5d	 
end variables

forward prototypes
public function integer wf_monta_faturamento ()
public subroutine wf_verifica_filial_alterada ()
public function boolean wf_verifica_movimento (long al_filial)
public subroutine wf_filial_ecommerce ()
public function decimal wf_cota_mes (date adt_inicio_mes, date adt_fim_mes)
public subroutine wf_monta_data_atual ()
public subroutine wf_insere_padrao ()
public function boolean wf_monta_faturamento_disq_entrega (ref decimal ldc_venda_dia, ref decimal ldc_venda_mes, ref decimal ldc_venda_ano, ref decimal ldc_cota_dia, ref decimal ldc_cota_mes, ref decimal ldc_cota_ano, ref long lvl_num_dcp)
end prototypes

public function integer wf_monta_faturamento ();Decimal	lvdc_faturamento, lvdc_cota, lvdc_aux, lvdc_media, lvdc_previsao, lvdc_percentual, lvdc_ticket, &
			  lvdc_previsto_mes, lvdc_previsto_ano, lvdc_previsto_ano_ec
/* Resumo Centro Distribui$$HEX2$$e700e300$$ENDHEX$$o */		  
Decimal	lvdc_cd_ano, lvdc_cd_mes, lvdc_cd_dia, lvdc_cd_cota_ano, lvdc_cd_cota_mes, lvdc_cd_cota_dia
/* Resumo Drog. Catarinense */		  
Decimal	lvdc_dc_ano, lvdc_dc_mes, lvdc_dc_dia, lvdc_dc_cota_ano, lvdc_dc_cota_mes, lvdc_dc_cota_dia
/* Resumo Pre$$HEX1$$e700$$ENDHEX$$o Pop. */	
Decimal	lvdc_pp_ano, lvdc_pp_mes, lvdc_pp_dia, lvdc_pp_cota_ano, lvdc_pp_cota_mes, lvdc_pp_cota_dia
/* Resumo Farmagora */	
Decimal	lvdc_far_ano, lvdc_far_mes, lvdc_far_dia, lvdc_far_cota_ano, lvdc_far_cota_mes, lvdc_far_cota_dia
/* Resumo Proformula */	
Decimal	lvdc_pro_ano, lvdc_pro_mes, lvdc_pro_dia, lvdc_pro_cota_ano, lvdc_pro_cota_mes, lvdc_pro_cota_dia
/* Resumo Manip. Catarinense */	
Decimal	lvdc_man_ano, lvdc_man_mes, lvdc_man_dia, lvdc_man_cota_ano, lvdc_man_cota_mes, lvdc_man_cota_dia

/* Resumo Catarinense Plus :  Esta sendo Utilizado para DisqEntrega */	
Decimal	lvdc_dcp_ano, lvdc_dcp_mes, lvdc_dcp_dia, lvdc_dcp_cota_ano, lvdc_dcp_cota_mes, lvdc_dcp_cota_dia

DateTime lvdh_datetime_aux
Date lvdt_data_aux
Long	lvl_linha_dw1, lvl_contador, lvl_linha, lvl_cliente, lvl_long_aux, lvl_num_dc, lvl_num_dcp, &
		lvl_num_pp, lvl_num_man, lvl_num_pro, lvl_num_cd, lvl_num_far
Integer lvi_acima_cota, lvi_acima_mes, lvi_acima_ano, lvi_num_filiais_dia, lvi_num_filiais_mes, lvi_num_filiais_ano
String lvs_tipo_rede, lvs_aux

Date ldt_Inicio_Ano_Anterior
Date ldt_Termino_Ano_Anterior

SetPointer(HourGlass!)

Long lvl_Regiao


lvl_Regiao = dw_selecao.Accepttext( )
lvl_Regiao = dw_selecao.Object.cd_regiao [1]

// Carrega DW auxiliares
ivds_2.of_RestoreSqlOriginal()
ivds_4.of_RestoreSqlOriginal()
ivds_4a.of_RestoreSqlOriginal()
ivds_5.of_RestoreSqlOriginal()
ivds_6.of_RestoreSqlOriginal()
ivds_6a.of_RestoreSqlOriginal()
ivds_6b.of_RestoreSqlOriginal()
ivds_7.of_RestoreSqlOriginal()
ivds_8.of_RestoreSqlOriginal()
ivds_9.of_RestoreSqlOriginal()

If lvl_Regiao > 0 Then
	ivds_2.Of_AppendWhere("f.cd_regiao="+String(lvl_Regiao))
	ivds_4.Of_AppendWhere("f.cd_regiao="+String(lvl_Regiao))
	ivds_4a.Of_AppendWhere("f.cd_regiao="+String(lvl_Regiao))
	ivds_5.Of_AppendWhere("f.cd_regiao="+String(lvl_Regiao))
	ivds_6.Of_AppendWhere("f.cd_regiao="+String(lvl_Regiao))
	ivds_6a.Of_AppendWhere("f.cd_regiao="+String(lvl_Regiao))
	ivds_6b.Of_AppendWhere("f.cd_regiao="+String(lvl_Regiao))
	ivds_7.Of_AppendWhere("f.cd_regiao="+String(lvl_Regiao))
	ivds_9.Of_AppendWhere("f.cd_regiao="+String(lvl_Regiao))
	ivds_8.Of_AppendWhere_Subquery("f.cd_regiao="+String(lvl_Regiao),1)
End If
ivds_2.Retrieve(iuo_parametro.ivdh_inicio_mes, iuo_parametro.ivdt_ontem, iuo_parametro.ivi_numero_dias_mes)
ivds_4.Retrieve(iuo_parametro.ivdh_inicio_mes, iuo_parametro.ivdt_ontem)

If Day(Date(iuo_parametro.ivdh_hoje)) = 1 Then
	lvdc_previsto_mes = 0
Else
	lvdt_data_aux = Date(iuo_parametro.ivdh_fim_mes)
	ivds_4a.Retrieve(iuo_parametro.ivdh_hoje, lvdt_data_aux)
	lvdc_previsto_mes = ivds_4a.Object.vl_total_cota[1]
End If

ivds_5.Retrieve(iuo_parametro.ivdt_ontem)
ivds_6.Retrieve(iuo_parametro.ivdh_inicio_ano, iuo_parametro.ivdt_ontem)

If Day(Date(iuo_parametro.ivdh_hoje)) = 1 and Month(Date(iuo_parametro.ivdh_hoje)) = 1 Then
	lvdc_previsto_ano = 0
	lvdc_previsto_ano_ec = 0
Else
	lvdt_data_aux = Date(iuo_parametro.ivdh_fim_ano)
	ivds_6a.Retrieve(iuo_parametro.ivdh_hoje, lvdt_data_aux)
	lvdc_previsto_ano = ivds_6a.Object.vl_total_cota[1]
	ivds_6b.Retrieve(iuo_parametro.ivdh_hoje, lvdt_data_aux)
	lvdc_previsto_ano_ec = ivds_6b.Object.vl_total_cota[1]
End If

ivds_7.Retrieve(iuo_parametro.ivdt_ontem)

//Lista das filiais com disque entrega
If ivds_8.Retrieve() = -1 Then 
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar as filiais com disque entrega.", StopSign!)
End If

dw_1.SetRedRaw(False)
dw_1.Event ue_Retrieve()
dw_1.SetRedRaw(True)

wf_verifica_filial_alterada()

// Inicializa$$HEX2$$e700e300$$ENDHEX$$o da DW

dw_3.InsertRow(0)
lvdh_datetime_aux = DateTime(iuo_parametro.ivdt_ontem, Time("00:00:00"))
dw_3.SetItem(1, "dia", lvdh_datetime_aux)
dw_3.SetItem(1, "mes", month(iuo_parametro.ivdt_ontem))
dw_3.SetItem(1, "ano", year(iuo_parametro.ivdt_ontem))

SetNull(lvdc_faturamento)
SetNull(lvdc_cota)

// Monta valores do dia

lvdc_faturamento = ivds_5.Object.vl_total_venda_dia[1]
lvdc_cota = ivds_7.Object.vl_total_cota_dia[1]

If (Not IsNull(lvdc_cota))and(lvdc_cota>0) Then
	dw_3.Object.cota_dia[1] = lvdc_cota
	lvdc_aux = Round(lvdc_faturamento / lvdc_cota, 4)
	dw_3.Object.perc_cota_dia[1] = lvdc_aux
End If

dw_3.Object.fat_dia[1] = lvdc_faturamento
lvl_cliente = ivds_5.Object.nr_tot_cliente_dia[1]
dw_3.Object.nr_clientes_dia[1] = lvl_cliente
lvdc_ticket = ivds_5.Object.vl_tot_ticket_dia[1]
dw_3.Object.vl_ticket_dia[1] = lvdc_ticket
lvl_long_aux = Year(iuo_parametro.ivdt_ontem) - 1
lvdt_data_aux = Date(LeftA(String(iuo_parametro.ivdt_ontem, "dd/mm/yyyy"), 6) + String(lvl_long_aux, "0000"))
//Para Comparar com o mesmo dia da semana do ano anterior
//lvdt_data_aux = Date(String(Day(RelativeDate(iuo_parametro.ivdt_ontem,iuo_parametro.ivi_Tipo_Ano))) + Mid(String(iuo_parametro.ivdt_ontem, "dd/mm/yyyy"), 3, 4) + String(lvl_long_aux, "0000"))

//Se ano informado for bisexto
If gf_ano_bisexto(Year(iuo_parametro.ivdt_ontem)) and month(iuo_parametro.ivdt_ontem) = 2 and day(iuo_parametro.ivdt_ontem) = 29 Then
	//Deixa a data como YYYY/02/28
	lvdt_data_aux = Date(Year(iuo_parametro.ivdt_ontem) - 1, 2,28)
Else
	lvdt_data_aux = Date(LeftA(String(iuo_parametro.ivdt_ontem, "dd/mm/yyyy"), 6) + String(lvl_long_aux, "0000"))
End If

If lvdt_data_aux = Date("01/01/1900") Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Data calculada do ano anterior esta inv$$HEX1$$e100$$ENDHEX$$lida.", StopSign!)
	Return -1
End If

lvl_linha = ivds_5.Retrieve(lvdt_data_aux)

If lvl_linha > 0 Then
	lvdc_aux = ivds_5.Object.vl_total_venda_dia[1]
	
	If lvdc_aux > 0 Then
		lvl_long_aux = ivds_5.Object.nr_tot_cliente_dia[1]
		
		lvdc_percentual = (lvdc_faturamento - lvdc_aux) / lvdc_aux
		dw_3.Object.pc_varia_dia[1] = lvdc_percentual
		
		lvdc_percentual = (lvl_cliente - lvl_long_aux) / lvl_long_aux
		dw_3.Object.pc_clientes_dia[1] = lvdc_percentual
		lvdc_percentual = round(lvdc_aux / lvl_long_aux, 2)
		
		lvdc_percentual = (lvdc_ticket - lvdc_percentual) / lvdc_percentual
		dw_3.Object.pc_ticket_dia[1] = lvdc_percentual
	End If
End If

// Monta valores do m$$HEX1$$ea00$$ENDHEX$$s
lvdc_faturamento = ivds_2.Object.vl_total_venda[1]
lvdc_cota = ivds_4.Object.vl_total_cota[1]

If (Not IsNull(lvdc_cota))and(lvdc_cota > 0) Then
	dw_3.Object.cota_mes[1] = lvdc_cota
	lvdc_aux = Round(lvdc_faturamento / lvdc_cota, 4)
	dw_3.Object.perc_cota_mes[1] = lvdc_aux
End If

dw_3.Object.fat_mes[1] = lvdc_faturamento
dw_3.Object.media_mes[1] = ivds_2.Object.vl_tot_media_mes[1]

dw_3.Object.previsto_mes			[1] = ivds_2.Object.vl_total_venda[1] + lvdc_previsto_mes
dw_3.Object.previsto_mes_cota	[1] = wf_Cota_Mes( Date(iuo_parametro.ivdh_inicio_mes), Date(iuo_parametro.ivdh_fim_mes)) 

lvl_cliente = ivds_2.Object.nr_tot_clientes_mes[1]
dw_3.Object.nr_clientes_mes[1] = lvl_cliente
lvdc_ticket = ivds_2.Object.vl_tot_ticket_mes[1]
dw_3.Object.vl_ticket_mes[1] = lvdc_ticket
lvdc_aux = 0

ldt_Inicio_Ano_Anterior = gf_data_ano_anterior(date(iuo_parametro.ivdh_inicio_mes))

// Se data atual for do ultimo dia do m$$HEX1$$ea00$$ENDHEX$$s
If gf_ultimo_dia_mes(date(lvdh_datetime_aux)) Then
	
	//Ano anterior $$HEX1$$e900$$ENDHEX$$ bisexto $$HEX1$$e900$$ENDHEX$$ m$$HEX1$$ea00$$ENDHEX$$s 02 
	If gf_ano_bisexto(year(date(lvdh_datetime_aux)) -1) and month(date(lvdh_datetime_aux))  = 2 Then
		ldt_Termino_Ano_Anterior = Date((year(date(lvdh_datetime_aux)) -1), 2, 29)
	ElseIf month(date(lvdh_datetime_aux))  = 2 Then
		//Deixa a data como YYYY/02/28
		ldt_Termino_Ano_Anterior = Date(Year(iuo_parametro.ivdt_ontem) - 1, 2,28)
	Else
		ldt_Termino_Ano_Anterior = gf_data_ano_anterior(date(lvdh_datetime_aux))
	End If
	
Else
	ldt_Termino_Ano_Anterior = gf_data_ano_anterior(date(lvdh_datetime_aux))
End If

If ldt_Inicio_Ano_Anterior = Date("01/01/1900") or ldt_Termino_Ano_Anterior = Date("01/01/1900") Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio ou t$$HEX1$$e900$$ENDHEX$$rmino calculada esta inv$$HEX1$$e100$$ENDHEX$$lida (1).", StopSign!)
	Return -1
End If

If ivds_9.Retrieve(ldt_Inicio_Ano_Anterior,ldt_Termino_Ano_Anterior) > 0 Then
	lvdc_aux 		= ivds_9.Object.vl_venda	[1]
	lvl_long_aux	= ivds_9.Object.qt_venda	[1]
Else
	lvdc_aux 		= 0.00
	lvl_long_aux	= 0
End If

If lvdc_aux > 0 then
	lvdc_percentual = (lvdc_faturamento - lvdc_aux) / lvdc_aux
	dw_3.Object.pc_varia_mes[1] = lvdc_percentual
	lvdc_percentual = (lvl_cliente - lvl_long_aux) / lvl_long_aux
	dw_3.Object.pc_clientes_mes[1] = lvdc_percentual
	lvdc_percentual = round(lvdc_aux / lvl_long_aux, 2)
	lvdc_percentual = (lvdc_ticket - lvdc_percentual) / lvdc_percentual
	dw_3.Object.pc_ticket_mes[1] = lvdc_percentual
End If

// Monta valores do ano

lvdc_faturamento = dw_1.Object.vl_total_venda_ano[1]
lvdc_cota = dw_1.Object.vl_total_cota_ano[1]
//  COMENTADO A PEDIDO DO OSCAR.
//If ivds_6.RowCount() > 0 Then
//	lvl_linha = ivds_6.Find("cd_filial=534", 1, ivds_6.RowCount())
//	If lvl_linha > 0 Then
//		lvdc_cota = lvdc_cota + ivds_6.Object.vl_cota[lvl_linha]
//	End If
//End If

If (Not IsNull(lvdc_cota))and(lvdc_cota>0) Then
	dw_3.Object.cota_ano[1] = lvdc_cota
	lvdc_aux = Round(lvdc_faturamento / lvdc_cota, 4)
	dw_3.Object.perc_cota_ano[1] = lvdc_aux
End If

lvdc_ticket	= dw_1.Object.vl_tot_ticket_ano		[1]
lvl_cliente	= dw_1.Object.nr_tot_clientes_ano	[1]
dw_3.Object.fat_ano					[1] = lvdc_faturamento
dw_3.Object.media_ano				[1] = dw_1.Object.vl_tot_media_ano		[1]
//2016.03.15 - Chamado 129248 - Alterado para considerar as cotas tamb$$HEX1$$e900$$ENDHEX$$m do EC, pois as filiais n$$HEX1$$e300$$ENDHEX$$o tem cota em meses futuros
//dw_3.Object.previsto_ano			[1] = dw_1.Object.vl_total_venda_ano	[1] + lvdc_previsto_ano
dw_3.Object.previsto_ano			[1] = dw_1.Object.vl_total_venda_ano	[1] + lvdc_previsto_ano_ec
//2016.03.15 - Chamado 129248 - Alterado para considerar apenas as cotas do ano todo
//dw_3.Object.previsto_ano_novas[1] = dw_1.Object.vl_total_venda_ano	[1] + lvdc_previsto_ano_ec
dw_3.Object.previsto_ano_novas	[1] = lvdc_cota + lvdc_previsto_ano_ec
dw_3.Object.nr_clientes_ano		[1] = lvl_cliente
dw_3.Object.vl_ticket_ano			[1] = lvdc_ticket
lvdc_aux = 0

ldt_Inicio_Ano_Anterior = gf_data_ano_anterior(date(iuo_parametro.ivdh_inicio_ano))

If ldt_Inicio_Ano_Anterior = Date("01/01/1900") or ldt_Termino_Ano_Anterior = Date("01/01/1900") Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio ou t$$HEX1$$e900$$ENDHEX$$rmino calculada est$$HEX1$$e100$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lida (2).", StopSign!)
	Return -1
End If

If ivds_9.Retrieve(ldt_Inicio_Ano_Anterior,ldt_Termino_Ano_Anterior) > 0 Then
	lvdc_aux 		= ivds_9.Object.vl_venda	[1]
	lvl_long_aux	= ivds_9.Object.qt_venda	[1]
Else
	lvdc_aux 		= 0.00
	lvl_long_aux	= 0
End If

If lvdc_aux > 0 Then
	lvdc_percentual = (lvdc_faturamento - lvdc_aux) / lvdc_aux
	dw_3.Object.pc_varia_ano[1] = lvdc_percentual
	lvdc_percentual = (lvl_cliente - lvl_long_aux) / lvl_long_aux
	dw_3.Object.pc_clientes_ano[1] = lvdc_percentual
	lvdc_percentual = round(lvdc_aux / lvl_long_aux, 2)
	lvdc_percentual = (lvdc_ticket - lvdc_percentual) / lvdc_percentual
	dw_3.Object.pc_ticket_ano[1] = lvdc_percentual
End If

// Monta estat$$HEX1$$ed00$$ENDHEX$$sticas da cota e participa$$HEX2$$e700e300$$ENDHEX$$o por rede
lvl_linha_dw1 = dw_1.RowCount()
FOR lvl_contador = 1 TO lvl_linha_dw1
	lvs_tipo_rede = dw_1.Object.id_rede_filial [lvl_contador]
	
	If dw_1.Object.pc_cota_atingida[lvl_contador] >= 100 Then
		lvi_acima_cota = lvi_acima_cota + 1
	End If
	If dw_1.Object.liquida_dia[lvl_contador] > 0 Then
		lvi_num_filiais_dia = lvi_num_filiais_dia + 1
	End If
	If dw_1.Object.pc_cota_atingida_mes[lvl_contador] >= 100 Then
		lvi_acima_mes = lvi_acima_mes + 1
	End If
	If dw_1.Object.vl_venda_mes[lvl_contador] > 0 Then
		lvi_num_filiais_mes = lvi_num_filiais_mes + 1
	End If
	If dw_1.Object.pc_cota_atingida_ano[lvl_contador] >= 100 Then
		lvi_acima_ano = lvi_acima_ano + 1
	End If
	If dw_1.Object.vl_venda_ano[lvl_contador] > 0 Then
		lvi_num_filiais_ano = lvi_num_filiais_ano + 1
	End If
	
	CHOOSE CASE lvs_tipo_rede 
		CASE 'PP'
			iuo_parametro.ivl_filial_pp[UpperBound(iuo_parametro.ivl_filial_pp) + 1] = dw_1.Object.cd_filial[lvl_contador]
			lvdc_pp_dia			= lvdc_pp_dia			+ dw_1.Object.liquida_dia		[lvl_contador]
			lvdc_pp_mes		= lvdc_pp_mes			+ dw_1.Object.vl_venda_mes	[lvl_contador]
			lvdc_pp_ano			= lvdc_pp_ano			+ dw_1.Object.vl_venda_ano	[lvl_contador]
			lvdc_pp_cota_dia	= lvdc_pp_cota_dia	+ dw_1.Object.vl_cota_dia		[lvl_contador]
			lvdc_pp_cota_mes	= lvdc_pp_cota_mes	+ dw_1.Object.vl_cota_mes		[lvl_contador]
			lvdc_pp_cota_ano	= lvdc_pp_cota_ano	+ dw_1.Object.vl_cota_ano		[lvl_contador]
			lvl_num_pp			= lvl_num_pp + 1
		CASE 'MP'
			iuo_parametro.ivl_filial_man[UpperBound(iuo_parametro.ivl_filial_man) + 1] = dw_1.Object.cd_filial[lvl_contador]
			lvdc_man_dia 			= lvdc_man_dia			+ dw_1.Object.liquida_dia		[lvl_contador]
			lvdc_man_mes 			= lvdc_man_mes			+ dw_1.Object.vl_venda_mes	[lvl_contador]
			lvdc_man_ano 			= lvdc_man_ano			+ dw_1.Object.vl_venda_ano	[lvl_contador]
			lvdc_man_cota_dia 	= lvdc_man_cota_dia		+ dw_1.Object.vl_cota_dia		[lvl_contador]
			lvdc_man_cota_mes	= lvdc_man_cota_mes	+ dw_1.Object.vl_cota_mes		[lvl_contador]
			lvdc_man_cota_ano	= lvdc_man_cota_ano	+ dw_1.Object.vl_cota_ano		[lvl_contador]
			lvl_num_man 			= lvl_num_man + 1
		CASE 'CP'
			///Este trecho n$$HEX1$$e300$$ENDHEX$$o esta sendo utilizado, foi substrituido pelo DISQ ENTREGA
			iuo_parametro.ivl_filial_dcp[UpperBound(iuo_parametro.ivl_filial_dcp) + 1] = dw_1.Object.cd_filial[lvl_contador]
			lvdc_dcp_dia			= lvdc_dcp_dia			+ dw_1.Object.liquida_dia		[lvl_contador]
			lvdc_dcp_mes			= lvdc_dcp_mes		+ dw_1.Object.vl_venda_mes	[lvl_contador]
			lvdc_dcp_ano			= lvdc_dcp_ano		+ dw_1.Object.vl_venda_ano	[lvl_contador]
			lvdc_dcp_cota_dia		= lvdc_dcp_cota_dia	+ dw_1.Object.vl_cota_dia		[lvl_contador]
			lvdc_dcp_cota_mes	= lvdc_dcp_cota_mes	+ dw_1.Object.vl_cota_mes		[lvl_contador]
			lvdc_dcp_cota_ano	= lvdc_dcp_cota_ano	+ dw_1.Object.vl_cota_ano		[lvl_contador]
			lvl_num_dcp 			= lvl_num_dcp + 1
		CASE 'PF'
			iuo_parametro.ivl_filial_pro[UpperBound(iuo_parametro.ivl_filial_pro) + 1] = dw_1.Object.cd_filial[lvl_contador]
			lvdc_pro_dia			= lvdc_pro_dia			+ dw_1.Object.liquida_dia		[lvl_contador]
			lvdc_pro_mes			= lvdc_pro_mes		+ dw_1.Object.vl_venda_mes	[lvl_contador]
			lvdc_pro_ano 			= lvdc_pro_ano			+ dw_1.Object.vl_venda_ano	[lvl_contador]
			lvdc_pro_cota_dia 		= lvdc_pro_cota_dia	+ dw_1.Object.vl_cota_dia		[lvl_contador]
			lvdc_pro_cota_mes	= lvdc_pro_cota_mes	+ dw_1.Object.vl_cota_mes		[lvl_contador]
			lvdc_pro_cota_ano		= lvdc_pro_cota_ano	+ dw_1.Object.vl_cota_ano		[lvl_contador]
			lvl_num_pro				= lvl_num_pro + 1
		CASE 'CD'
			iuo_parametro.ivl_filial_cd[UpperBound(iuo_parametro.ivl_filial_cd) + 1] = dw_1.Object.cd_filial[lvl_contador]
			lvdc_cd_dia 			+= dw_1.Object.liquida_dia		[lvl_contador]
			lvdc_cd_mes		+= dw_1.Object.vl_venda_mes	[lvl_contador]
			lvdc_cd_ano			+= dw_1.Object.vl_venda_ano	[lvl_contador]
			lvdc_cd_cota_dia	+= dw_1.Object.vl_cota_dia		[lvl_contador]
			lvdc_cd_cota_mes	+= dw_1.Object.vl_cota_mes	[lvl_contador]
			lvdc_cd_cota_ano	+= dw_1.Object.vl_cota_ano	[lvl_contador]
			lvl_num_cd 			+= 1
		CASE 'FA'
			iuo_parametro.ivl_filial_far[UpperBound(iuo_parametro.ivl_filial_far) + 1] = dw_1.Object.cd_filial[lvl_contador]
			lvdc_far_dia 		+= dw_1.Object.liquida_dia		[lvl_contador]
			lvdc_far_mes		+= dw_1.Object.vl_venda_mes	[lvl_contador]
			lvdc_far_ano		+= dw_1.Object.vl_venda_ano	[lvl_contador]
			lvdc_far_cota_dia	+= dw_1.Object.vl_cota_dia		[lvl_contador]
			lvdc_far_cota_mes	+= dw_1.Object.vl_cota_mes	[lvl_contador]
			lvdc_far_cota_ano	+= dw_1.Object.vl_cota_ano	[lvl_contador]
			lvl_num_far 			+= 1
		CASE ELSE
			iuo_parametro.ivl_filial_dc[UpperBound(iuo_parametro.ivl_filial_dc) + 1] = dw_1.Object.cd_filial[lvl_contador]
			lvdc_dc_dia			= lvdc_dc_dia 			+ dw_1.Object.liquida_dia		[lvl_contador]
			lvdc_dc_mes		= lvdc_dc_mes			+ dw_1.Object.vl_venda_mes	[lvl_contador]
			lvdc_dc_ano			= lvdc_dc_ano			+ dw_1.Object.vl_venda_ano	[lvl_contador]
			lvdc_dc_cota_dia	= lvdc_dc_cota_dia	+ dw_1.Object.vl_cota_dia		[lvl_contador]
			lvdc_dc_cota_mes	= lvdc_dc_cota_mes	+ dw_1.Object.vl_cota_mes		[lvl_contador]
			lvdc_dc_cota_ano	= lvdc_dc_cota_ano	+ dw_1.Object.vl_cota_ano		[lvl_contador]
			lvl_num_dc			= lvl_num_dc + 1
	END CHOOSE
NEXT

dw_dfc.Reset()
dw_man.Reset()
dw_pp.Reset()
dw_dcp.Reset()
dw_pro.Reset()
dw_cd.Reset()
dw_far.Reset()

lvl_linha = dw_dfc.InsertRow(0)
lvs_aux = 'DROG. CATARINENSE (' + string(lvl_num_dc) + ')'
dw_dfc.object.rede	[lvl_linha] = lvs_aux
dw_dfc.Object.ft_dia	[lvl_linha] = lvdc_dc_dia 
dw_dfc.Object.ft_mes	[lvl_linha] = lvdc_dc_mes 
dw_dfc.Object.ft_ano	[lvl_linha] = lvdc_dc_ano

If lvdc_dc_cota_dia > 0 Then
	lvdc_aux = Round(lvdc_dc_dia / lvdc_dc_cota_dia, 2)
Else
	lvdc_aux = 0
End If

dw_dfc.Object.ct_dia[lvl_linha] = lvdc_aux

If lvdc_dc_cota_mes > 0 Then
	lvdc_aux = Round(lvdc_dc_mes / lvdc_dc_cota_mes, 2)
Else
	lvdc_aux = 0
End If

dw_dfc.Object.ct_mes[lvl_linha] = lvdc_aux

If lvdc_dc_cota_ano > 0 Then
	lvdc_aux = Round(lvdc_dc_ano / lvdc_dc_cota_ano, 2)
Else
	lvdc_aux = 0
End If

dw_dfc.Object.ct_ano[lvl_linha] = lvdc_aux

lvl_linha = dw_man.InsertRow(0)
lvs_aux = 'MANIPULA$$HEX2$$c700c300$$ENDHEX$$O (' + string(lvl_num_man) + ')'
dw_man.object.rede		[lvl_linha] = lvs_aux
dw_man.Object.ft_dia	[lvl_linha] = lvdc_man_dia 
dw_man.Object.ft_mes	[lvl_linha] = lvdc_man_mes
dw_man.Object.ft_ano	[lvl_linha] = lvdc_man_ano

If lvdc_man_cota_dia > 0 Then
	lvdc_aux = Round(lvdc_man_dia / lvdc_man_cota_dia, 2)
Else
	lvdc_aux = 0
End If

dw_man.Object.ct_dia[lvl_linha] = lvdc_aux

If lvdc_man_cota_mes > 0 Then
	lvdc_aux = Round(lvdc_man_mes / lvdc_man_cota_mes, 2)
Else
	lvdc_aux = 0
End If

dw_man.Object.ct_mes[lvl_linha] = lvdc_aux

If lvdc_man_cota_ano > 0 Then
	lvdc_aux = Round(lvdc_man_ano / lvdc_man_cota_ano, 2)
	Else
	lvdc_aux = 0
End If

dw_man.Object.ct_ano[lvl_linha] = lvdc_aux

lvl_linha = dw_pp.InsertRow(0)
lvs_aux = 'PRE$$HEX1$$c700$$ENDHEX$$O POPULAR (' + string(lvl_num_pp) + ')'
dw_pp.object.rede		[lvl_linha] = lvs_aux
dw_pp.Object.ft_dia	[lvl_linha] = lvdc_pp_dia
dw_pp.Object.ft_mes	[lvl_linha] = lvdc_pp_mes
dw_pp.Object.ft_ano	[lvl_linha] = lvdc_pp_ano

If lvdc_pp_cota_dia > 0 Then
	lvdc_aux = Round(lvdc_pp_dia / lvdc_pp_cota_dia, 2)
Else
	lvdc_aux = 0
End If

dw_pp.Object.ct_dia[lvl_linha] = lvdc_aux

If lvdc_pp_cota_mes > 0 Then
	lvdc_aux = Round(lvdc_pp_mes / lvdc_pp_cota_mes, 2)
Else
	lvdc_aux = 0
End If

dw_pp.Object.ct_mes[lvl_linha] = lvdc_aux

If lvdc_pp_cota_ano > 0 Then
	lvdc_aux = Round(lvdc_pp_ano / lvdc_pp_cota_ano, 2)
Else
	lvdc_aux = 0
End If

dw_pp.Object.ct_ano[lvl_linha] = lvdc_aux


// Dados do Disq Entre para Filiais Configuradas
If This.wf_monta_faturamento_disq_entrega( ref lvdc_dcp_dia,& 
																 ref lvdc_dcp_mes, &
																 ref lvdc_dcp_ano,&
																 ref lvdc_dcp_cota_dia,&
																 ref lvdc_dcp_cota_mes,&
																 ref lvdc_dcp_cota_ano,&
																 ref lvl_num_dcp) Then 

	lvl_linha = dw_dcp.InsertRow(0)
	lvs_aux = 'DISQUE ENTREGA(' + string(lvl_num_dcp) + ')'																 
	dw_dcp.object.rede		[lvl_linha] = lvs_aux
	dw_dcp.Object.ft_dia	[lvl_linha] = lvdc_dcp_dia
	dw_dcp.Object.ft_mes	[lvl_linha] = lvdc_dcp_mes
	dw_dcp.Object.ft_ano	[lvl_linha] = lvdc_dcp_ano
	
	If lvdc_dcp_cota_dia > 0 then
		lvdc_aux = Round(lvdc_dcp_dia / lvdc_dcp_cota_dia, 2)
	Else
		lvdc_aux = 0
	End If
	
	dw_dcp.Object.ct_dia[lvl_linha] = lvdc_aux
	
	If lvdc_dcp_cota_mes > 0 Then
		lvdc_aux = Round(lvdc_dcp_mes / lvdc_dcp_cota_mes, 2)
	Else
		lvdc_aux = 0
	End If
	
	dw_dcp.Object.ct_mes[lvl_linha] = lvdc_aux
	
	If lvdc_dcp_cota_ano > 0 then
		lvdc_aux = Round(lvdc_dcp_ano / lvdc_dcp_cota_ano, 2)
	Else
		lvdc_aux = 0
	End If
	
	dw_dcp.Object.ct_ano[lvl_linha] = lvdc_aux
End If 

//Estoque Central
lvl_linha = dw_cd.InsertRow(0)
lvs_aux = 'CENTRO DISTRIBUI$$HEX2$$c700c300$$ENDHEX$$O (' + string(lvl_num_cd) + ')'
dw_cd.Object.rede	[lvl_linha] = lvs_aux
dw_cd.Object.ft_dia	[lvl_linha] = lvdc_cd_dia
dw_cd.Object.ft_mes	[lvl_linha] = lvdc_cd_mes
dw_cd.Object.ft_ano	[lvl_linha] = lvdc_cd_ano

If lvdc_cd_cota_dia > 0 then
	lvdc_aux = Round(lvdc_cd_dia / lvdc_cd_cota_dia, 2)
Else
	lvdc_aux = 0
End If

dw_cd.Object.ct_dia[lvl_linha] = lvdc_aux

If lvdc_cd_cota_mes > 0 Then
	lvdc_aux = Round(lvdc_cd_mes / lvdc_cd_cota_mes, 2)
Else
	lvdc_aux = 0
End If

dw_cd.Object.ct_mes[lvl_linha] = lvdc_aux

If lvdc_cd_cota_ano > 0 then
	lvdc_aux = Round(lvdc_cd_ano / lvdc_cd_cota_ano, 2)
Else
	lvdc_aux = 0
End If

dw_cd.Object.ct_ano[lvl_linha] = lvdc_aux

//Fim CD

//Farmagora
lvl_linha = dw_far.InsertRow(0)
lvs_aux = 'FARMAGORA (' + string(lvl_num_far) + ')'
dw_far.Object.rede	[lvl_linha] = lvs_aux
dw_far.Object.ft_dia	[lvl_linha] = lvdc_far_dia
dw_far.Object.ft_mes	[lvl_linha] = lvdc_far_mes
dw_far.Object.ft_ano	[lvl_linha] = lvdc_far_ano

If lvdc_far_cota_dia > 0 then
	lvdc_aux = Round(lvdc_far_dia / lvdc_far_cota_dia, 2)
Else
	lvdc_aux = 0
End If

dw_far.Object.ct_dia[lvl_linha] = lvdc_aux

If lvdc_far_cota_mes > 0 Then
	lvdc_aux = Round(lvdc_far_mes / lvdc_far_cota_mes, 2)
Else
	lvdc_aux = 0
End If

dw_far.Object.ct_mes[lvl_linha] = lvdc_aux

If lvdc_far_cota_ano > 0 then
	lvdc_aux = Round(lvdc_far_ano / lvdc_far_cota_ano, 2)
Else
	lvdc_aux = 0
End If

dw_far.Object.ct_ano[lvl_linha] = lvdc_aux



lvl_linha = dw_pro.InsertRow(0)
lvs_aux = 'PROF$$HEX1$$d300$$ENDHEX$$RMULA (' + string(lvl_num_pro) + ')'
dw_pro.object.rede		[lvl_linha] = lvs_aux
dw_pro.Object.ft_dia		[lvl_linha] = lvdc_pro_dia
dw_pro.Object.ft_mes	[lvl_linha] = lvdc_pro_mes
dw_pro.Object.ft_ano		[lvl_linha] = lvdc_pro_ano

If lvdc_pro_cota_dia > 0 then
	lvdc_aux = Round(lvdc_pro_dia / lvdc_pro_cota_dia, 2)
Else
	lvdc_aux = 0
End If

dw_pro.Object.ct_dia[lvl_linha] = lvdc_aux

If lvdc_pro_cota_mes > 0 Then
	lvdc_aux = Round(lvdc_pro_mes / lvdc_pro_cota_mes, 2)
Else
	lvdc_aux = 0
End If

dw_pro.Object.ct_mes[lvl_linha] = lvdc_aux

If lvdc_pro_cota_ano > 0 then
	lvdc_aux = Round(lvdc_pro_ano / lvdc_pro_cota_ano, 2)
Else
	lvdc_aux = 0
End If

dw_pro.Object.ct_ano[lvl_linha] = lvdc_aux

// Comp$$HEX1$$f500$$ENDHEX$$e as informa$$HEX2$$e700f500$$ENDHEX$$es finais da DW

dw_3.SetItem(1, "num_filiais_dia", lvi_num_filiais_dia)
dw_3.SetItem(1, "num_filiais_mes", lvi_num_filiais_mes)
dw_3.SetItem(1, "num_filiais_ano", lvi_num_filiais_ano)
dw_3.SetItem(1, "acima_cota", lvi_acima_cota)
dw_3.SetItem(1, "acima_cota_mes", lvi_acima_mes)
dw_3.SetItem(1, "acima_cota_ano", lvi_acima_ano)

Return 1
end function

public subroutine wf_verifica_filial_alterada ();Boolean lvb_Achou = False

Decimal	lvdc_Liquida_Dia, &
			lvdc_Cota_Dia, &
			lvdc_Venda_Mes, &
			lvdc_Cota_Mes, &
			lvdc_Venda_Ano, &
			lvdc_Cota_Ano

Long	lvl_Linha, &
		lvl_Linhas, &
		lvl_Filial, &
		lvl_Linha_Add, &
		lvl_Find, &
		lvl_Num_Cliente_Dia, &
		lvl_Num_Cliente_Mes, &
		lvl_Num_Cliente_Ano

lvl_Linhas = dw_1.RowCount()

For lvl_Linha = 1 To lvl_Linhas
	If dw_1.Object.cd_filial[lvl_Linha] = 9 Then
		
		// Verifica se a filial j$$HEX1$$e100$$ENDHEX$$ foi alterada de DPP -> FPP verificando se h$$HEX1$$e100$$ENDHEX$$ algum movimento at$$HEX1$$e900$$ENDHEX$$ a data do paramentro
		If wf_verifica_movimento(753) Then
			lvl_Filial = 753
			lvb_Achou = True
		End If
	ElseIf dw_1.Object.cd_filial[lvl_Linha] = 779 Then
		If wf_verifica_movimento(798) Then
			lvl_Filial = 798
			lvb_Achou = True
		End If
		
	ElseIf dw_1.Object.cd_filial[lvl_Linha] = 780 Then
		If wf_verifica_movimento(797) Then
			lvl_Filial = 797
			lvb_Achou = True
		End If
	ElseIf dw_1.Object.cd_filial[lvl_Linha] = 10 Then
		If wf_verifica_movimento(799) Then
			lvl_Filial = 799
			lvb_Achou = True
		End If
	End If
	
	If lvb_Achou Then

		lvl_Num_Cliente_Dia		= dw_1.Object.num_cliente_dia	[lvl_Linha]
		lvdc_Liquida_Dia			= dw_1.Object.liquida_dia			[lvl_Linha]
		lvdc_Cota_Dia				= dw_1.Object.vl_cota_dia			[lvl_Linha]

		lvdc_Venda_Mes			= dw_1.Object.vl_venda_mes		[lvl_Linha]
		lvdc_Cota_Mes				= dw_1.Object.vl_cota_mes			[lvl_Linha]
		lvl_Num_Cliente_Mes		= dw_1.Object.num_cliente_mes	[lvl_Linha]
		
		lvdc_Venda_Ano			= dw_1.Object.vl_venda_ano	[lvl_Linha]
		lvdc_Cota_Ano				= dw_1.Object.vl_cota_ano		[lvl_Linha]
		lvl_Num_Cliente_Ano		= dw_1.Object.nr_cliente		[lvl_Linha]
						
		lvl_Find = dw_1.Find("cd_filial = " + String(lvl_Filial),1,lvl_Linhas)
		
		If lvl_Find > 0 Then
			
			//lvl_Linha_Add = dw_1.InsertRow(0)
			
			//dw_1.Object.nm_fantasia[lvl_Linha_Add]	= "TESTE " + String(lvl_Filial)
			//dw_1.Object.cd_filial[lvl_Linha_Add]	= 0000
			
			dw_1.Object.num_cliente_dia	[lvl_Find] = dw_1.Object.num_cliente_dia	[lvl_Find] + lvl_Num_Cliente_Dia
			dw_1.Object.liquida_dia			[lvl_Find] = dw_1.Object.liquida_dia			[lvl_Find] + lvdc_Liquida_Dia
			dw_1.Object.vl_cota_dia			[lvl_Find] = dw_1.Object.vl_cota_dia			[lvl_Find] + lvdc_Cota_Dia
			
			dw_1.Object.vl_venda_mes		[lvl_Find] = dw_1.Object.vl_venda_mes		[lvl_Find] + lvdc_Venda_Mes
			dw_1.Object.vl_cota_mes		[lvl_Find] = dw_1.Object.vl_cota_mes		[lvl_Find] + lvdc_Cota_Mes
			dw_1.Object.num_cliente_mes	[lvl_Find] = dw_1.Object.num_cliente_mes	[lvl_Find]	 + lvl_Num_Cliente_Mes
			
			dw_1.Object.vl_venda_ano		[lvl_Find] = dw_1.Object.vl_venda_ano		[lvl_Find] + lvdc_Venda_Ano	
			dw_1.Object.vl_cota_ano		[lvl_Find] = dw_1.Object.vl_cota_ano			[lvl_Find] + lvdc_Cota_Ano
			dw_1.Object.nr_cliente			[lvl_Find] = dw_1.Object.nr_cliente			[lvl_Find] + lvl_Num_Cliente_Ano
			
			dw_1.DeleteRow(lvl_Linha)
			lvl_Linha --
			lvl_Linhas --			
		Else
			If dw_1.Object.cd_filial[lvl_Linha] = 9 Then
				dw_1.Object.nm_fantasia[lvl_Linha]	= "FPP_CURITIBA $$HEX1$$c900$$ENDHEX$$BANO"
			ElseIf dw_1.Object.cd_filial[lvl_Linha] = 10 Then				
				dw_1.Object.nm_fantasia[lvl_Linha]	= "FPP_PA VOLUNTARIOS DA PATRIA"
			ElseIf dw_1.Object.cd_filial[lvl_Linha] = 779 Then				
				dw_1.Object.nm_fantasia[lvl_Linha]	= "FPP_PATO BRANCO"			
			ElseIf dw_1.Object.cd_filial[lvl_Linha] = 780 Then				
				dw_1.Object.nm_fantasia[lvl_Linha]	= "FPP_VIAM$$HEX1$$c300$$ENDHEX$$O"			
			End If
			
			dw_1.Object.cd_filial			[lvl_Linha]	= lvl_Filial
			dw_1.Object.id_rede_filial	[lvl_Linha]	= "PP"
			
		End If
		
		lvb_Achou = False
		
	End If
	

Next
end subroutine

public function boolean wf_verifica_movimento (long al_filial);dc_uo_ds_base ivds_movimento

ivds_movimento = Create dc_uo_ds_base

If Not ivds_movimento.of_ChangeDataObject("dw_ge234_verifica_movimento") Then
	Return False
Else
	ivds_movimento.Retrieve(al_filial, gvo_parametro.dh_movimentacao)
	If ivds_movimento.RowCount() <= 0  Then
		Return False
	End If
End If

Destroy(ivds_movimento)

Return True
end function

public subroutine wf_filial_ecommerce ();String lvs_Parametro 

Select vl_parametro
Into :lvs_Parametro 
From parametro_geral
where cd_parametro = 'CD_FILIAL_ECOMMERCE'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		ivl_Filial_Ecommerce = Long(lvs_Parametro)
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "C$$HEX1$$f300$$ENDHEX$$digo da filial eCommerce n$$HEX1$$e300$$ENDHEX$$o foi localizada.")
	Case -1
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do c$$HEX1$$f300$$ENDHEX$$digo da filial Farmagora")
End Choose


end subroutine

public function decimal wf_cota_mes (date adt_inicio_mes, date adt_fim_mes);Decimal ldc_Cota_Mes

Long lvl_Regiao

lvl_Regiao = dw_selecao.Accepttext( )
lvl_Regiao = dw_selecao.Object.cd_regiao [1]

If lvl_Regiao = 0 Then
	Select sum(c.vl_cota)
	Into :ldc_Cota_Mes
	from cota_filial c (index pk_cota_filial), filial f 
	where c.dh_cota 	between :adt_inicio_mes and :adt_fim_mes
	  and c.cd_filial 	> 0
	  and c.cd_filial	= f.cd_filial
	  and f.id_situacao = 'A'
	Using SqlCa;
Else
	Select sum(c.vl_cota)
	Into :ldc_Cota_Mes
	from cota_filial c (index pk_cota_filial), filial f 
	where c.dh_cota 	between :adt_inicio_mes and :adt_fim_mes
	  and c.cd_filial 	> 0
	  and c.cd_filial	= f.cd_filial
	  and f.id_situacao = 'A'
	  and f.cd_regiao = :lvl_Regiao
	Using SqlCa;
End If

If SqlCa.SqlCode = -1 Then
	Sqlca.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da cota do m$$HEX1$$ea00$$ENDHEX$$s atual.")
	Return 0
End If

Return ldc_Cota_Mes


end function

public subroutine wf_monta_data_atual ();Integer lvi_dia, lvi_mes, lvi_ano
String lvs_data

Date lvdt_Analise

SetPointer(HourGlass!)

dw_selecao.Accepttext( )
lvdt_Analise = dw_selecao.Object.dt_analise [1]

iuo_parametro.ivdt_ontem	= lvdt_Analise
iuo_parametro.ivdh_hoje		= DateTime(RelativeDate(lvdt_Analise, 1))

lvi_dia = Day(iuo_parametro.ivdt_ontem)
If lvi_dia > 1 then
	lvi_dia = 1
End If

lvi_mes	= Month(iuo_parametro.ivdt_ontem)
lvi_ano	= Year(iuo_parametro.ivdt_ontem)

//Verifica Ano Bissexto
If Mod(lvi_ano,4)=0 Then
	iuo_parametro.ivi_Tipo_Ano = 2
End If

lvs_data = "01/01/" + String(lvi_ano, "0000")
iuo_parametro.ivdh_inicio_ano = DateTime(Date(lvs_data), Time("00:00:00"))
iuo_parametro.ivi_numero_dias_ano = DaysAfter(Date(lvs_data), iuo_parametro.ivdt_ontem)
If iuo_parametro.ivi_numero_dias_ano = 0 Then
	iuo_parametro.ivi_numero_dias_ano = 1
End If
lvs_data = "31/12/" + String(lvi_ano, "0000")
iuo_parametro.ivdh_fim_ano = DateTime(Date(lvs_data), Time("00:00:00"))

lvs_data = String(lvi_dia, "00") + "/" + String(lvi_mes, "00") + "/" + &
                String(lvi_ano, "0000")
iuo_parametro.ivdh_inicio_mes = DateTime(Date(lvs_data), Time("00:00:00"))

iuo_parametro.ivi_dias_corrente = DaysAfter(Date(lvs_data), iuo_parametro.ivdt_ontem)

If lvi_mes = 1 or lvi_mes = 3 or lvi_mes = 5 or lvi_mes = 7 or lvi_mes = 8 or &
   lvi_mes = 10 or lvi_mes = 12 Then
	iuo_parametro.ivi_numero_dias_mes = 31
End If
If lvi_mes = 4 or lvi_mes = 6 or lvi_mes = 9 or lvi_mes = 11 Then
	iuo_parametro.ivi_numero_dias_mes = 30
End If
If lvi_mes = 2 Then
	If Round(lvi_ano / 4, 0) <> Round(lvi_ano / 4, 1) Then
		iuo_parametro.ivi_numero_dias_mes = 28
	Else
		iuo_parametro.ivi_numero_dias_mes = 29
	End If
End If

lvs_data = String(iuo_parametro.ivi_numero_dias_mes, "00") + "/" + String(lvi_mes, "00") + "/" + &
                String(lvi_ano, "0000")
iuo_parametro.ivdh_fim_mes = DateTime(Date(lvs_data), Time("00:00:00"))

Return
end subroutine

public subroutine wf_insere_padrao ();// Coloca o item TODAS
DataWindowChild ldw_Child

Long lvl_Regiao

If dw_selecao.GetChild("cd_regiao", ldw_Child) = 1 Then
	
	ldw_Child.InsertRow(1)

	ldw_Child.SetItem(1,"cd_regiao",0)
	ldw_Child.SetItem(1,"de_regiao","TODAS")
	
	dw_selecao.Object.cd_regiao[1] = 0
Else
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao incluir o item 'TODAS' na coluna regi$$HEX1$$e300$$ENDHEX$$o.", StopSign!)
End If

select cd_regiao
Into :lvl_Regiao
From regiao
Where nr_matricula_regional = :gvo_aplicacao.ivo_seguranca.nr_matricula
Using SQLCa;

If SQLCa.SQLCode = 0 Then
	dw_selecao.Object.cd_regiao[1] = lvl_Regiao
Else
	dw_selecao.Object.cd_regiao[1] = 0	
End If
end subroutine

public function boolean wf_monta_faturamento_disq_entrega (ref decimal ldc_venda_dia, ref decimal ldc_venda_mes, ref decimal ldc_venda_ano, ref decimal ldc_cota_dia, ref decimal ldc_cota_mes, ref decimal ldc_cota_ano, ref long lvl_num_dcp);/// DISQUE ENTREGA: Esta fun$$HEX2$$e700e300$$ENDHEX$$o serve para trazer os dados das filiais configuradas no disq_entrega

String lvs_lojas_disque
Long ll_Linha
Decimal ldvc_cota_mes
Decimal ldvc_cota_ano
Decimal ldvc_cota_dia

// Lojas Configuradas para DisquEntrega
lvs_lojas_disque  = " f.cd_filial in  (select cd_filial  from parametro_loja where cd_parametro = 'ID_DISQUE_ENTREGA'  and  vl_parametro = 'S')"
/////////////////   COTAS

// Cotas Para M$$HEX1$$ea00$$ENDHEX$$s
ivds_6d = Create dc_uo_ds_base
ivds_6d.Of_ChangeDataObject("dw_lista_cota_mes")
ivds_6d.Of_AppendWhere(lvs_lojas_disque)
ivds_6d.Retrieve(iuo_parametro.ivdh_inicio_mes, iuo_parametro.ivdt_ontem)

For ll_Linha =1 To ivds_6d.rowcount( ) 
	ldc_cota_mes = ldc_cota_mes   + ivds_6d.Object.vl_Cota[ll_Linha]
Next
If IsNull(ldc_cota_mes) 	Then ldc_cota_mes 		= 0.00

// Cotas para Ano
ivds_4d = Create dc_uo_ds_base
ivds_4d.Of_ChangeDataObject("dw_lista_cota_ano")
ivds_4d.Of_AppendWhere(lvs_lojas_disque)
ivds_4d.Retrieve(iuo_parametro.ivdh_inicio_ano , iuo_parametro.ivdt_ontem)
For ll_Linha =1 To ivds_4d.rowcount( ) 
	ldc_cota_ano = ldc_cota_ano  + ivds_4d.Object.vl_Cota[ll_Linha]
Next
lvl_num_dcp =  ivds_4d.rowcount( ) 
If IsNull(ldc_cota_ano) 	Then ldc_cota_ano 		= 0.00

// Cotas para Dia
ivds_5d = Create dc_uo_ds_base
ivds_5d.Of_ChangeDataObject("dw_lista_cota_dia")
ivds_5d.Of_AppendWhere(lvs_lojas_disque)
ivds_5d.Retrieve(iuo_parametro.ivdt_ontem)
For ll_Linha =1 To ivds_5d.rowcount( ) 
	ldc_cota_dia = ldc_cota_dia  + ivds_5d.Object.vl_Cota[ll_Linha]
Next
If IsNull(ldc_cota_dia) 	Then ldc_cota_dia 		= 0.00



/////////////////   VENDAS    :   venda  - devolucao 

// Vendas para Dia
Select sum(vl_venda - vl_devolucao_venda)
Into :ldc_venda_dia
From resumo_venda_disque_entrega
Where  dh_resumo				=: iuo_Parametro.ivdt_ontem
and cd_filial  in (select cd_filial  from parametro_loja where cd_parametro = 'ID_DISQUE_ENTREGA'  and  vl_parametro = 'S')
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Verifica$$HEX2$$e700e300$$ENDHEX$$o das vendas di$$HEX1$$e100$$ENDHEX$$ria disque.")
	Return False
End If

// Vendas para M$$HEX1$$ea00$$ENDHEX$$s
Select sum(vl_venda - vl_devolucao_venda)
Into :ldc_venda_mes
From resumo_venda_disque_entrega
Where dh_resumo				between :iuo_Parametro.ivdh_inicio_mes and :iuo_parametro.ivdt_ontem
and cd_filial  in (select cd_filial  from parametro_loja where cd_parametro = 'ID_DISQUE_ENTREGA'  and  vl_parametro = 'S')
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Verifica$$HEX2$$e700e300$$ENDHEX$$o das vendas do m$$HEX1$$ea00$$ENDHEX$$s do disque.")
	Return False
End If

// Vendas para Ano
Select sum(vl_venda - vl_devolucao_venda)
Into :ldc_venda_ano
From resumo_venda_disque_entrega
Where dh_resumo				between :iuo_parametro.ivdh_inicio_ano and :iuo_parametro.ivdt_ontem
and cd_filial  in (select cd_filial  from parametro_loja where cd_parametro = 'ID_DISQUE_ENTREGA'  and  vl_parametro = 'S')
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Verifica$$HEX2$$e700e300$$ENDHEX$$o das vendas do ano do disque.")
	Return False
End If

If IsNull(ldc_venda_ano) 	Then ldc_venda_ano 	= 0.00
If IsNull(ldc_venda_dia) 	Then ldc_venda_dia 		= 0.00
If IsNull(ldc_venda_mes) 	Then ldc_venda_mes	= 0.00

Destroy(ivds_4d)
Destroy(ivds_5d)
Destroy(ivds_6d)

Return True 
end function

on w_resumo_faturamento.create
int iCurrent
call super::create
this.dw_selecao=create dw_selecao
this.ln_2=create ln_2
this.ln_1a=create ln_1a
this.ln_1=create ln_1
this.ln_2e=create ln_2e
this.ln_2c=create ln_2c
this.ln_2b=create ln_2b
this.ln_2a=create ln_2a
this.cb_2=create cb_2
this.dw_3=create dw_3
this.dw_1=create dw_1
this.dw_relatorio=create dw_relatorio
this.dw_relatorio_2=create dw_relatorio_2
this.gb_1=create gb_1
this.dw_cd=create dw_cd
this.ln_3=create ln_3
this.ln_2d=create ln_2d
this.dw_pro=create dw_pro
this.dw_pp=create dw_pp
this.dw_man=create dw_man
this.dw_far=create dw_far
this.dw_dcp=create dw_dcp
this.dw_dfc=create dw_dfc
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_selecao
this.Control[iCurrent+2]=this.ln_2
this.Control[iCurrent+3]=this.ln_1a
this.Control[iCurrent+4]=this.ln_1
this.Control[iCurrent+5]=this.ln_2e
this.Control[iCurrent+6]=this.ln_2c
this.Control[iCurrent+7]=this.ln_2b
this.Control[iCurrent+8]=this.ln_2a
this.Control[iCurrent+9]=this.cb_2
this.Control[iCurrent+10]=this.dw_3
this.Control[iCurrent+11]=this.dw_1
this.Control[iCurrent+12]=this.dw_relatorio
this.Control[iCurrent+13]=this.dw_relatorio_2
this.Control[iCurrent+14]=this.gb_1
this.Control[iCurrent+15]=this.dw_cd
this.Control[iCurrent+16]=this.ln_3
this.Control[iCurrent+17]=this.ln_2d
this.Control[iCurrent+18]=this.dw_pro
this.Control[iCurrent+19]=this.dw_pp
this.Control[iCurrent+20]=this.dw_man
this.Control[iCurrent+21]=this.dw_far
this.Control[iCurrent+22]=this.dw_dcp
this.Control[iCurrent+23]=this.dw_dfc
end on

on w_resumo_faturamento.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_selecao)
destroy(this.ln_2)
destroy(this.ln_1a)
destroy(this.ln_1)
destroy(this.ln_2e)
destroy(this.ln_2c)
destroy(this.ln_2b)
destroy(this.ln_2a)
destroy(this.cb_2)
destroy(this.dw_3)
destroy(this.dw_1)
destroy(this.dw_relatorio)
destroy(this.dw_relatorio_2)
destroy(this.gb_1)
destroy(this.dw_cd)
destroy(this.ln_3)
destroy(this.ln_2d)
destroy(this.dw_pro)
destroy(this.dw_pp)
destroy(this.dw_man)
destroy(this.dw_far)
destroy(this.dw_dcp)
destroy(this.dw_dfc)
end on

event ue_postopen;call super::ue_postopen;SetPointer(HourGlass!)

dw_selecao.InsertRow(0)
dw_selecao.Object.dt_analise [1] = RelativeDate(Today(),-1)

wf_insere_padrao()

iuo_parametro = Create uo_parametro_janelas
ivds_2 = Create dc_uo_ds_base
ivds_2.Of_ChangeDataObject("dw_lista_faturamento_mes")

// vai somar somente as cotas dos dias em que a loja teve venda
ivds_4 = Create dc_uo_ds_base
ivds_4.Of_ChangeDataObject("dw_lista_cota_mes_2")

ivds_4a = Create dc_uo_ds_base
ivds_4a.Of_ChangeDataObject("dw_lista_cota_mes")

ivds_5 = Create dc_uo_ds_base
ivds_5.Of_ChangeDataObject("dw_lista_faturamento_dia")

ivds_6 = Create dc_uo_ds_base
ivds_6.Of_ChangeDataObject("dw_lista_cota_ano_com_ec")

ivds_6a = Create dc_uo_ds_base
ivds_6a.Of_ChangeDataObject("dw_lista_cota_ano")

ivds_6b = Create dc_uo_ds_base
ivds_6b.Of_ChangeDataObject("dw_lista_cota_ano_com_ec")

ivds_7 = Create dc_uo_ds_base
ivds_7.Of_ChangeDataObject("dw_lista_cota_dia")

ivds_8 = Create dc_uo_ds_base
ivds_8.Of_ChangeDataObject("dw_lista_filial_disque")

ivds_9 = Create dc_uo_ds_base
ivds_9.Of_ChangeDataObject("dw_ge234_resumo_est_ano_ant")

wf_Filial_Ecommerce()

wf_monta_data_atual()

If wf_monta_faturamento() = -1 Then
	Close(This)
	SetPointer(Arrow!)
	Return
End If

//wf_verifica_filial_alterada()
ivm_menu.ivb_permite_imprimir = True
ivm_menu.mf_imprimir(True)

SetPointer(Arrow!)
end event

event ue_printimmediate;call super::ue_printimmediate;dw_relatorio.Event ue_printimmediate()
dw_relatorio_2.Event ue_printimmediate()
end event

event activate;call super::activate;dw_relatorio.Visible = False
dw_relatorio_2.Visible = False
end event

event ue_print;call super::ue_print;dw_relatorio.Event ue_Print()
dw_relatorio_2.Event ue_Print()
end event

event close;call super::close;Destroy(iuo_parametro)
Destroy(ivds_2)
Destroy(ivds_4)
Destroy(ivds_4a)
Destroy(ivds_5)
Destroy(ivds_6)
Destroy(ivds_6a)
Destroy(ivds_6b)
Destroy(ivds_7)
Destroy(ivds_8)
Destroy(ivds_9)
					  
end event

event ue_saveas;dw_1.Event ue_SaveAs()
end event

type dw_visual from dc_w_sheet`dw_visual within w_resumo_faturamento
integer x = 347
integer y = 2868
end type

type gb_aux_visual from dc_w_sheet`gb_aux_visual within w_resumo_faturamento
integer x = 283
integer y = 2812
end type

type dw_selecao from dc_uo_dw_base within w_resumo_faturamento
integer x = 3918
integer y = 1376
integer width = 1093
integer height = 172
integer taborder = 20
string dataobject = "dw_ge234_selecao"
end type

type ln_2 from line within w_resumo_faturamento
long linecolor = 33554432
integer linethickness = 8
integer beginx = 3081
integer beginy = 1260
integer endx = 3081
integer endy = 1940
end type

type ln_1a from line within w_resumo_faturamento
long linecolor = 33554432
integer linethickness = 8
integer beginx = 9
integer beginy = 1948
integer endx = 5499
integer endy = 1948
end type

type ln_1 from line within w_resumo_faturamento
long linecolor = 33554432
integer linethickness = 8
integer beginx = 9
integer beginy = 1260
integer endx = 5499
integer endy = 1260
end type

type ln_2e from line within w_resumo_faturamento
long linecolor = 33554432
integer linethickness = 8
integer beginx = 795
integer beginy = 1952
integer endx = 795
integer endy = 2344
end type

type ln_2c from line within w_resumo_faturamento
long linecolor = 33554432
integer linethickness = 8
integer beginx = 2363
integer beginy = 1952
integer endx = 2363
integer endy = 2348
end type

type ln_2b from line within w_resumo_faturamento
long linecolor = 33554432
integer linethickness = 8
integer beginx = 3145
integer beginy = 1952
integer endx = 3145
integer endy = 2340
end type

type ln_2a from line within w_resumo_faturamento
long linecolor = 33554432
integer linethickness = 8
integer beginx = 3927
integer beginy = 1952
integer endx = 3927
integer endy = 2340
end type

type cb_2 from commandbutton within w_resumo_faturamento
integer x = 5047
integer y = 1320
integer width = 439
integer height = 108
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Altera"
boolean default = true
end type

event clicked;Date lvdt_data

dw_selecao.Accepttext( )
lvdt_data = dw_selecao.Object.dt_analise [1]

If lvdt_data >= Today() Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Data de in$$HEX1$$ed00$$ENDHEX$$cio informada n$$HEX1$$e300$$ENDHEX$$o pode ser maior ou igual a hoje.", Information!, Ok!)
	dw_selecao.Event ue_pos(1,'dt_analise')
	Return
End If

If (IsNull(lvdt_data))or(lvdt_data <= Date('01/08/2007')) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Data de in$$HEX1$$ed00$$ENDHEX$$cio informada n$$HEX1$$e300$$ENDHEX$$o pode ser menor que 01/08/2007.", Information!, Ok!)
	dw_selecao.Event ue_pos(1,'dt_analise')
	Return
End If

wf_monta_data_atual()

If wf_monta_faturamento() = -1  Then
	Close(parent)
	SetPointer(Arrow!)
	Return
End If

dw_1.Event RowFocusChanged(1)
dw_1.SetRow(1)
dw_1.SetFocus()

SetPointer(Arrow!)

end event

type dw_3 from dc_uo_dw_base within w_resumo_faturamento
integer x = 9
integer y = 1264
integer width = 3392
integer height = 680
integer taborder = 0
boolean bringtotop = true
string dataobject = "dw_faturamento"
end type

type dw_1 from dc_uo_dw_base within w_resumo_faturamento
integer x = 9
integer y = 4
integer width = 5499
integer height = 1248
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_lista_faturamento_ano"
boolean vscrollbar = true
boolean ivb_selecao_linhas = true
end type

event doubleclicked;call super::doubleclicked;If row < 1 Then
	Return
End If

//If This.Object.cd_filial[row] = 723 Then
//	
//	If iuo_parametro.ivdt_ontem >= Date('2011/05/09') Then
//	
//		// A loja iniciou as vendas de produtos de dispensa$$HEX2$$e700e300$$ENDHEX$$o no dia 09/05
//		iuo_parametro.ivl_filial_umso[1] 	= This.Object.cd_filial					[row]
//		
//		iuo_Parametro.ivdc_Venda_Dia 	= This.Object.liquida_dia				[Row]
//		iuo_Parametro.ivdc_Cota_Dia		= This.Object.vl_cota_dia			[Row]
//		iuo_Parametro.ivl_Clientes_Dia		= This.Object.num_cliente_dia		[Row]
//		
//		iuo_Parametro.ivdc_Venda_Mes	= This.Object.vl_venda_mes		[Row]
//		iuo_Parametro.ivdc_Cota_Mes		= This.Object.vl_cota_mes			[Row]
//		iuo_Parametro.ivl_Clientes_Mes	= This.Object.num_cliente_Mes	[Row]
//		
//		iuo_Parametro.ivdc_Venda_Ano 	= This.Object.vl_venda_ano			[Row]
//		iuo_Parametro.ivdc_Cota_Ano		= This.Object.vl_cota_ano			[Row]
//		iuo_Parametro.ivl_Clientes_Ano	= This.Object.nr_cliente				[Row]
//		
//		OpenWithParm(w_detalhe_2, iuo_parametro)
//		
//	Else
//		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Vendas de produtos de DISPENSA$$HEX2$$c700c300$$ENDHEX$$O somente a partir de "09/05/2011".')
//	End If
//ElseIf This.Object.cd_filial[row] = 786 Then
//	If iuo_parametro.ivdt_ontem >= Date('2016/06/01') Then
//		// A loja iniciou as vendas de produtos de dispensa$$HEX2$$e700e300$$ENDHEX$$o no dia 09/05
//		iuo_parametro.ivl_filial_umso[1] 	= This.Object.cd_filial					[row]
//		
//		iuo_Parametro.ivdc_Venda_Dia 	= This.Object.liquida_dia				[Row]
//		iuo_Parametro.ivdc_Cota_Dia		= This.Object.vl_cota_dia			[Row]
//		iuo_Parametro.ivl_Clientes_Dia		= This.Object.num_cliente_dia		[Row]
//		
//		iuo_Parametro.ivdc_Venda_Mes	= This.Object.vl_venda_mes		[Row]
//		iuo_Parametro.ivdc_Cota_Mes		= This.Object.vl_cota_mes			[Row]
//		iuo_Parametro.ivl_Clientes_Mes	= This.Object.num_cliente_Mes	[Row]
//		
//		iuo_Parametro.ivdc_Venda_Ano 	= This.Object.vl_venda_ano			[Row]
//		iuo_Parametro.ivdc_Cota_Ano		= This.Object.vl_cota_ano			[Row]
//		iuo_Parametro.ivl_Clientes_Ano	= This.Object.nr_cliente				[Row]
//		
//		OpenWithParm(w_detalhe_2, iuo_parametro)	
//	Else
//		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Vendas de produtos de DISPENSA$$HEX2$$c700c300$$ENDHEX$$O somente a partir de "01/06/2016".')
//	End If	
//Else
	If This.Object.id_filial_disque_entrega[row] = 'S' or  This.Object.cd_filial[row] = ivl_Filial_Ecommerce Then
		
		// A loja iniciou as vendas de produtos de dispensa$$HEX2$$e700e300$$ENDHEX$$o no dia 09/05
		iuo_parametro.ivl_filial_umso[1] 	= This.Object.cd_filial					[row]
		
		iuo_Parametro.ivdc_Venda_Dia 	= This.Object.liquida_dia				[Row]
		iuo_Parametro.ivdc_Cota_Dia		= This.Object.vl_cota_dia			[Row]
		iuo_Parametro.ivl_Clientes_Dia		= This.Object.num_cliente_dia		[Row]
		
		iuo_Parametro.ivdc_Venda_Mes	= This.Object.vl_venda_mes		[Row]
		iuo_Parametro.ivdc_Cota_Mes		= This.Object.vl_cota_mes			[Row]
		iuo_Parametro.ivl_Clientes_Mes	= This.Object.num_cliente_Mes	[Row]
		
		iuo_Parametro.ivdc_Venda_Ano 	= This.Object.vl_venda_ano			[Row]
		iuo_Parametro.ivdc_Cota_Ano		= This.Object.vl_cota_ano			[Row]
		iuo_Parametro.ivl_Clientes_Ano	= This.Object.nr_cliente				[Row]
		
		//OpenWithParm(w_detalhe_vendas_farmagora, iuo_parametro)
		OpenWithParm(w_detalhe_vendas, iuo_parametro)
	End If
	
////End If


end event

event retrieverow;Long lvl_linha_dw, lvl_filial, lvl_porte
String lvs_expressao

lvl_filial	= dw_1.Object.cd_filial	[row]
lvl_Porte	= dw_1.Object.cd_porte	[row]

lvs_expressao = "cd_filial=" + String(lvl_filial)

dw_1.Object.vl_media_ano[row] = dw_1.Object.vl_venda_ano[row] / (iuo_parametro.ivi_numero_dias_ano)

If ivds_2.RowCount() > 0 Then
	lvl_linha_dw = ivds_2.Find(lvs_expressao, 1, ivds_2.RowCount())
	If lvl_linha_dw > 0 Then
		dw_1.Object.vl_venda_mes		[row] = ivds_2.Object.venda			[lvl_linha_dw]
		dw_1.Object.num_cliente_mes	[row] = ivds_2.Object.num_clientes	[lvl_linha_dw]
	End If
End If

If ivds_4.RowCount() > 0 Then
	lvl_linha_dw = ivds_4.Find(lvs_expressao, 1, ivds_4.RowCount())
	If lvl_linha_dw > 0 Then
		dw_1.Object.vl_cota_mes[row] = ivds_4.Object.vl_cota[lvl_linha_dw]
	End If
End If

If ivds_5.RowCount() > 0 Then
	lvl_linha_dw = ivds_5.Find(lvs_expressao, 1, ivds_5.RowCount())
	If lvl_linha_dw > 0 Then
		dw_1.Object.liquida_dia[row] = ivds_5.Object.venda[lvl_linha_dw]
		dw_1.Object.num_cliente_dia[row] = ivds_5.Object.nr_cliente[lvl_linha_dw]
	End If
End If

If ivds_6.RowCount() > 0 Then
	lvl_linha_dw = ivds_6.Find(lvs_expressao, 1, ivds_6.RowCount())
	If lvl_linha_dw > 0 Then
		dw_1.Object.vl_cota_ano[row] = ivds_6.Object.vl_cota[lvl_linha_dw]
	End If
End If

If ivds_7.RowCount() > 0 Then
	lvl_linha_dw = ivds_7.Find(lvs_expressao, 1, ivds_7.RowCount())
	If lvl_linha_dw > 0 Then
		dw_1.Object.vl_cota_dia[row] = ivds_7.Object.vl_cota[lvl_linha_dw]
	End If
End If

If ivds_8.RowCount() > 0 Then
	If lvl_filial = ivl_Filial_Ecommerce  or lvl_filial = 723 or lvl_filial = 786 Then
		dw_1.Object.id_filial_disque_entrega[row] = 'S'
	Else
		lvl_linha_dw = ivds_8.Find(lvs_expressao, 1, ivds_8.RowCount())
		If lvl_linha_dw > 0 Then
			dw_1.Object.id_filial_disque_entrega[row] = 'S'
		End If
	End If
	

	
End If
end event

event constructor;call super::constructor;This.ivb_Ordena_Colunas = True
end event

event ue_postretrieve;call super::ue_postretrieve;Parent.ivm_menu.mf_imprimir(This.RowCount()>0)
Parent.ivm_menu.mf_salvarcomo(This.RowCount()>0)

If This.RowCount() > 0 Then
	This.Event RowFocusChanged(1)
	This.SetRow(1)
	This.SetFocus()
End If

Return This.RowCount()
end event

event ue_recuperar;//override
Return This.Retrieve(iuo_parametro.ivdh_inicio_ano, iuo_parametro.ivdt_ontem)
end event

event ue_preretrieve;call super::ue_preretrieve;Long lvl_Regiao

lvl_Regiao = dw_selecao.Accepttext( )
lvl_Regiao = dw_selecao.Object.cd_regiao [1]

If lvl_Regiao > 0 Then
	This.Of_AppendWhere_Subquery("f.cd_regiao="+String(lvl_Regiao),3)
End if

Return AncestorReturnValue
end event

event ue_reset;call super::ue_reset;Parent.ivm_menu.mf_imprimir(False)
Parent.ivm_menu.mf_salvarcomo(False)
end event

type dw_relatorio from dc_uo_dw_base within w_resumo_faturamento
integer x = 3835
integer y = 1096
integer width = 178
integer height = 152
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_lista_faturamento_ano_relatorio"
boolean border = true
borderstyle borderstyle = styleraised!
end type

event ue_preprint;call super::ue_preprint;dw_relatorio.Reset()
//T$$HEX1$$ed00$$ENDHEX$$tulo
This.Object.t_data.Text		= String(dw_3.Object.dia	[1])
This.Object.st_regiao.Text	= 'Regi$$HEX1$$e300$$ENDHEX$$o: '+dw_selecao.Describe("Evaluate('LookUpDisplay(cd_regiao)',1)")

This.Object.liquida_dia_t.Text 		= String(dw_3.Object.dia	[1])
This.Object.vl_venda_mes_t.Text	= gf_mes_extenso(Month(dw_3.Object.dia[1]))
This.Object.vl_venda_ano_t.Text	= String(Year(dw_3.Object.dia	[1]))

dw_1.RowsCopy(1, dw_1.RowCount(), Primary!, dw_relatorio, 1, Primary!)

Return This.RowCount()
end event

type dw_relatorio_2 from dc_uo_dw_base within w_resumo_faturamento
integer x = 4082
integer y = 1076
integer width = 169
integer height = 136
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_faturamento_relatorio"
boolean border = true
borderstyle borderstyle = styleraised!
end type

event ue_preprint;call super::ue_preprint;This.Reset()

//T$$HEX1$$ed00$$ENDHEX$$tulo
This.Object.t_dia.Text = String(dw_3.Object.dia			[1])

//Resumo por Rede

//Drogaria Catarinense
This.Object.rede_2.Text	 = dw_dfc.Object.rede	[1]
This.Object.ft_dia_2	[1] = dw_dfc.Object.ft_dia	[1]
This.Object.ft_mes_2	[1] = dw_dfc.Object.ft_mes	[1]
This.Object.ft_ano_2	[1] = dw_dfc.Object.ft_ano	[1]
This.Object.ct_dia_2	[1] = dw_dfc.Object.ct_dia	[1]
This.Object.ct_mes_2	[1] = dw_dfc.Object.ct_mes	[1]
This.Object.ct_ano_2	[1] = dw_dfc.Object.ct_ano	[1]

//Drogaria Catarinense Plus
This.Object.rede_3.Text	 = dw_dcp.Object.rede		[1]
This.Object.ft_dia_3	[1] = dw_dcp.Object.ft_dia		[1]
This.Object.ft_mes_3	[1] = dw_dcp.Object.ft_mes	[1]
This.Object.ft_ano_3	[1] = dw_dcp.Object.ft_ano		[1]
This.Object.ct_dia_3	[1] = dw_dcp.Object.ct_dia		[1]
This.Object.ct_mes_3	[1] = dw_dcp.Object.ct_mes	[1]
This.Object.ct_ano_3	[1] = dw_dcp.Object.ct_ano		[1]

//Manipula$$HEX2$$e700e300$$ENDHEX$$o
This.Object.rede_4.Text  = dw_man.Object.rede		[1]
This.Object.ft_dia_4	[1] = dw_man.Object.ft_dia		[1]
This.Object.ft_mes_4	[1] = dw_man.Object.ft_mes	[1]
This.Object.ft_ano_4	[1] = dw_man.Object.ft_ano	[1]
This.Object.ct_dia_4	[1] = dw_man.Object.ct_dia	[1]
This.Object.ct_mes_4	[1] = dw_man.Object.ct_mes	[1]
This.Object.ct_ano_4	[1] = dw_man.Object.ct_ano	[1]

//Pre$$HEX1$$e700$$ENDHEX$$o Popular
This.Object.rede_5.Text  = dw_pp.Object.rede		[1]
This.Object.ft_dia_5	[1] = dw_pp.Object.ft_dia	[1]
This.Object.ft_mes_5	[1] = dw_pp.Object.ft_mes	[1]
This.Object.ft_ano_5	[1] = dw_pp.Object.ft_ano	[1]
This.Object.ct_dia_5	[1] = dw_pp.Object.ct_dia	[1]
This.Object.ct_mes_5	[1] = dw_pp.Object.ct_mes	[1]
This.Object.ct_ano_5	[1] = dw_pp.Object.ct_ano	[1]

//Prof$$HEX1$$f300$$ENDHEX$$rmula
This.Object.rede_6.Text  = dw_pro.Object.rede	[1]
This.Object.ft_dia_6	[1] = dw_pro.Object.ft_dia	[1]
This.Object.ft_mes_6	[1] = dw_pro.Object.ft_mes	[1]
This.Object.ft_ano_6	[1] = dw_pro.Object.ft_ano	[1]
This.Object.ct_dia_6	[1] = dw_pro.Object.ct_dia	[1]
This.Object.ct_mes_6	[1] = dw_pro.Object.ct_mes[1]
This.Object.ct_ano_6	[1] = dw_pro.Object.ct_ano	[1]

//Estoque Central
This.Object.rede_1.Text  = dw_cd.Object.rede		[1]
This.Object.ft_dia_1	[1] = dw_cd.Object.ft_dia	[1]
This.Object.ft_mes_1	[1] = dw_cd.Object.ft_mes	[1]
This.Object.ft_ano_1	[1] = dw_cd.Object.ft_ano	[1]
This.Object.ct_dia_1	[1] = dw_cd.Object.ct_dia	[1]
This.Object.ct_mes_1	[1] = dw_cd.Object.ct_mes	[1]
This.Object.ct_ano_1	[1] = dw_cd.Object.ct_ano	[1]

//Farmagora
This.Object.rede_7.Text  = dw_far.Object.rede	[1]
This.Object.ft_dia_7	[1] = dw_far.Object.ft_dia	[1]
This.Object.ft_mes_7	[1] = dw_far.Object.ft_mes	[1]
This.Object.ft_ano_7	[1] = dw_far.Object.ft_ano	[1]
This.Object.ct_dia_7	[1] = dw_far.Object.ct_dia	[1]
This.Object.ct_mes_7	[1] = dw_far.Object.ct_mes	[1]
This.Object.ct_ano_7	[1] = dw_far.Object.ct_ano	[1]

//Resumo Geral
This.Object.dia						[1] = dw_3.Object.dia						[1]
This.Object.fat_dia				[1] = dw_3.Object.fat_dia					[1]
This.Object.cota_dia				[1] = dw_3.Object.cota_dia					[1]
This.Object.perc_cota_dia		[1] = dw_3.Object.perc_cota_dia			[1]
This.Object.num_filiais_dia		[1] = dw_3.Object.num_filiais_dia			[1]
This.Object.acima_cota			[1] = dw_3.Object.acima_cota				[1]
This.Object.pc_varia_dia			[1] = dw_3.Object.pc_varia_dia			[1]
This.Object.nr_clientes_dia		[1] = dw_3.Object.nr_clientes_dia			[1]
This.Object.pc_clientes_dia		[1] = dw_3.Object.pc_clientes_dia			[1]
This.Object.vl_ticket_dia			[1] = dw_3.Object.vl_ticket_dia			[1]
This.Object.pc_ticket_dia			[1] = dw_3.Object.pc_ticket_dia			[1]
This.Object.mes					[1] = dw_3.Object.mes						[1]
This.Object.fat_mes				[1] = dw_3.Object.fat_mes					[1]
This.Object.cota_mes				[1] = dw_3.Object.cota_mes				[1]
This.Object.media_mes			[1] = dw_3.Object.media_mes				[1]
This.Object.previsto_mes		[1] = dw_3.Object.previsto_mes			[1]
This.Object.perc_cota_mes		[1] = dw_3.Object.perc_cota_mes			[1]
This.Object.num_filiais_mes		[1] = dw_3.Object.num_filiais_mes		[1]
This.Object.acima_cota_mes	[1] = dw_3.Object.acima_cota_mes		[1]
This.Object.pc_varia_mes		[1] = dw_3.Object.pc_varia_mes			[1]
This.Object.nr_clientes_mes	[1] = dw_3.Object.nr_clientes_mes		[1]
This.Object.pc_clientes_mes	[1] = dw_3.Object.pc_clientes_mes		[1]
This.Object.vl_ticket_mes		[1] = dw_3.Object.vl_ticket_mes			[1]
This.Object.pc_ticket_mes		[1] = dw_3.Object.pc_ticket_mes			[1]
This.Object.previsto_mes_cota	[1] = dw_3.Object.previsto_mes_cota	[1]
This.Object.ano					[1] = dw_3.Object.ano						[1]
This.Object.fat_ano				[1] = dw_3.Object.fat_ano					[1]
This.Object.cota_ano				[1] = dw_3.Object.cota_ano				[1]
This.Object.media_ano			[1] = dw_3.Object.media_ano				[1]
This.Object.previsto_ano			[1] = dw_3.Object.previsto_ano			[1]
This.Object.previsto_ano_novas[1] = dw_3.Object.previsto_ano_novas	[1]
This.Object.perc_cota_ano		[1] = dw_3.Object.perc_cota_ano			[1]
This.Object.num_filiais_ano		[1] = dw_3.Object.num_filiais_ano		[1]
This.Object.acima_cota_ano	[1] = dw_3.Object.acima_cota_ano		[1]
This.Object.pc_varia_ano		[1] = dw_3.Object.pc_varia_ano			[1]
This.Object.nr_clientes_ano		[1] = dw_3.Object.nr_clientes_ano		[1]
This.Object.pc_clientes_ano		[1] = dw_3.Object.pc_clientes_ano		[1]
This.Object.vl_ticket_ano			[1] = dw_3.Object.vl_ticket_ano			[1]
This.Object.pc_ticket_ano		[1] = dw_3.Object.pc_ticket_ano			[1]

Return 1
end event

type gb_1 from groupbox within w_resumo_faturamento
integer x = 3899
integer y = 1300
integer width = 1115
integer height = 296
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
end type

type dw_cd from dc_uo_dw_base within w_resumo_faturamento
integer x = 14
integer y = 1952
integer width = 768
integer height = 400
integer taborder = 30
string dataobject = "dw_resumo_rede"
end type

event doubleclicked;call super::doubleclicked;SetPointer(HourGlass!)

iuo_parametro.ivs_rede = 'CD'

OpenWithParm(w_detalhe, iuo_parametro)
end event

type ln_3 from line within w_resumo_faturamento
long linecolor = 33554432
integer linethickness = 8
integer beginx = 4718
integer beginy = 1952
integer endx = 4718
integer endy = 2340
end type

type ln_2d from line within w_resumo_faturamento
long linecolor = 33554432
integer linethickness = 8
integer beginx = 1577
integer beginy = 1956
integer endx = 1577
integer endy = 2344
end type

type dw_pro from dc_uo_dw_base within w_resumo_faturamento
integer x = 4736
integer y = 1952
integer width = 768
integer height = 396
integer taborder = 90
string dataobject = "dw_resumo_rede"
end type

event doubleclicked;call super::doubleclicked;SetPointer(HourGlass!)

iuo_parametro.ivs_rede = 'PF'

OpenWithParm(w_detalhe, iuo_parametro)
end event

type dw_pp from dc_uo_dw_base within w_resumo_faturamento
integer x = 3936
integer y = 1952
integer width = 768
integer height = 396
integer taborder = 80
string dataobject = "dw_resumo_rede"
end type

event doubleclicked;call super::doubleclicked;SetPointer(HourGlass!)

iuo_parametro.ivs_rede = 'PP'

OpenWithParm(w_detalhe, iuo_parametro)
end event

type dw_man from dc_uo_dw_base within w_resumo_faturamento
integer x = 3150
integer y = 1952
integer width = 768
integer height = 396
integer taborder = 70
string dataobject = "dw_resumo_rede"
end type

event doubleclicked;call super::doubleclicked;SetPointer(HourGlass!)

iuo_parametro.ivs_rede = 'MP'

OpenWithParm(w_detalhe, iuo_parametro)
end event

type dw_far from dc_uo_dw_base within w_resumo_faturamento
integer x = 2368
integer y = 1952
integer width = 768
integer height = 396
integer taborder = 100
string dataobject = "dw_resumo_rede"
end type

event doubleclicked;call super::doubleclicked;SetPointer(HourGlass!)

iuo_parametro.ivs_rede = 'FA'

OpenWithParm(w_detalhe, iuo_parametro)
end event

type dw_dcp from dc_uo_dw_base within w_resumo_faturamento
integer x = 1582
integer y = 1952
integer width = 768
integer height = 396
integer taborder = 60
string dataobject = "dw_resumo_rede"
end type

event doubleclicked;call super::doubleclicked;SetPointer(HourGlass!)

iuo_parametro.ivs_rede = 'CP'

OpenWithParm(w_detalhe, iuo_parametro)
end event

type dw_dfc from dc_uo_dw_base within w_resumo_faturamento
integer x = 805
integer y = 1952
integer width = 768
integer height = 396
integer taborder = 50
string dataobject = "dw_resumo_rede"
end type

event doubleclicked;call super::doubleclicked;SetPointer(HourGlass!)

iuo_parametro.ivs_rede = 'DC'

OpenWithParm(w_detalhe, iuo_parametro)
end event

