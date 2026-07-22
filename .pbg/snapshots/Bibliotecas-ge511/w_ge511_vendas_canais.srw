HA$PBExportHeader$w_ge511_vendas_canais.srw
forward
global type w_ge511_vendas_canais from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge511_vendas_canais from dc_w_selecao_lista_relatorio
integer width = 4937
integer height = 2868
string title = "GE511 - Relat$$HEX1$$f300$$ENDHEX$$rio de Vendas dos Canais"
long backcolor = 16777215
end type
global w_ge511_vendas_canais w_ge511_vendas_canais

type variables
uo_parametro_janelas iuo_parametro

Date ivdt_inicio, ivdt_termino
Long  il_regiao
String is_rede
String is_nm_Relatorio = "Relat$$HEX1$$f300$$ENDHEX$$rio de Vendas por Canal"


String  ivs_dt_inicio_AnoAnterior, ivs_dt_termino_AnoAnterior
String ivs_dt_inicio_MesAnoAnterior, ivs_dt_termino_MesAnoAnterior
String ivs_dt_inicio_DiaAnoAnterior

Long lvi_numero_mes
Long lvi_numero_dia
Long lvi_numero_ano
String ivs_nome_mes


Boolean  ivs_mudou_filtro = False




end variables

forward prototypes
public function boolean wf_localiza_dados (datastore ads_dados, long al_filial, integer ai_pagamento, ref decimal adc_venda)
public subroutine wf_monta_data_atual ()
public subroutine wf_atualiza_informacoes ()
public subroutine wf_insere_padrao ()
end prototypes

public function boolean wf_localiza_dados (datastore ads_dados, long al_filial, integer ai_pagamento, ref decimal adc_venda);Long lvl_Find

lvl_Find = ads_Dados.Find("cd_filial = " + String(al_Filial) + " and id_pagamento = " + String(ai_Pagamento), 1, ads_Dados.RowCount())
					
If lvl_Find > 0 Then
	adc_Venda   = ads_Dados.Object.vl_total	[lvl_Find]
Else
	If lvl_Find < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar os dados da filial '" + String(al_Filial) + "'.")
		Return False
	Else
		adc_Venda 	= 0.00
	End If
End If

Return True
end function

public subroutine wf_monta_data_atual ();Integer lvi_dia, lvi_mes, lvi_ano
Integer lvi_anoAnterior,lvi_ontem
String lvs_data
Date lvdt_Analise

SetPointer(HourGlass!)

dw_1.Accepttext( )
lvdt_Analise = dw_1.Object.dt_analise [1]

iuo_parametro.ivdt_ontem	= lvdt_Analise
iuo_parametro.ivdh_hoje		= DateTime(RelativeDate(lvdt_Analise, 1))

lvi_dia = Day(iuo_parametro.ivdt_ontem)
If lvi_dia > 1 then
	lvi_dia = 1
End If

lvi_mes	= Month(iuo_parametro.ivdt_ontem)
lvi_ano	= Year(iuo_parametro.ivdt_ontem)
lvi_anoAnterior = Year(iuo_parametro.ivdt_ontem) - 1 
lvi_ontem   = Day(iuo_parametro.ivdt_ontem)

//Verifica Ano Bissexto
If Mod(lvi_ano,4)=0 Then
	iuo_parametro.ivi_Tipo_Ano = 2
End If

// Ano Atual
lvs_data = "01/01/" + String(lvi_ano, "0000")

// Ano Anterior 
ivs_dt_inicio_AnoAnterior =   "01/01/" + String(lvi_anoAnterior, "0000")    
ivs_dt_termino_AnoAnterior = "31/12/" + String(lvi_anoAnterior, "0000") 

/// Ano M$$HEX1$$ea00$$ENDHEX$$s Anterior
ivs_dt_inicio_MesAnoAnterior = String(lvi_dia, "00") + "/" + String(lvi_mes, "00") + "/" +     String(lvi_anoAnterior, "0000")
ivs_dt_termino_MesAnoAnterior = String(lvi_ontem, "00") + "/" + String(lvi_mes, "00") + "/" +     String(lvi_anoAnterior, "0000")
// Dia Ano Anteior
ivs_dt_inicio_DiaAnoAnterior = String(lvi_ontem, "00") + "/" + String(lvi_mes, "00") + "/" +     String(lvi_anoAnterior, "0000")


iuo_parametro.ivdh_inicio_ano = DateTime(Date(lvs_data), Time("00:00:00"))
iuo_parametro.ivi_numero_dias_ano = DaysAfter(Date(lvs_data), iuo_parametro.ivdt_ontem)
If iuo_parametro.ivi_numero_dias_ano = 0 Then
	iuo_parametro.ivi_numero_dias_ano = 1
End If

lvs_data = "31/12/" + String(lvi_ano, "0000")
iuo_parametro.ivdh_fim_ano = DateTime(Date(lvs_data), Time("00:00:00"))
lvs_data = String(lvi_dia, "00") + "/" + String(lvi_mes, "00") + "/" +     String(lvi_ano, "0000")


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

lvs_data = String(iuo_parametro.ivi_numero_dias_mes, "00") + "/" + String(lvi_mes, "00") + "/" + String(lvi_ano, "0000")
iuo_parametro.ivdh_fim_mes = DateTime(Date(lvs_data), Time("00:00:00"))
lvi_numero_mes = lvi_mes

ivs_nome_mes  = gf_mes_extenso (lvi_mes)

Return
end subroutine

public subroutine wf_atualiza_informacoes ();String lvs_Canal
String lvs_CanalAux
String lvs_id_modo
String lvs_desc_modo_entrega

Decimal lvdc_Venda
Decimal lvdc_SomaDia
Decimal lvdc_SomaAno
Decimal lvdc_SomaMes

Long	lvl_Linha	
Long	lvl_Linhas	

Long  lvl_ContaAno
Long lvl_ContaMes
Long lvl_ContaDia
Long lvl_ContaDados
Long lvl_FindAno,&
		lvl_FindMes,&
			lvl_FindDia
			
Long lvl_FindAnoAnterior,&
		lvl_FindMesAnterior,&
			lvl_FindDiaAnterior			
			
lvl_ContaDados = dw_2.RowCount()

////////////////////////   ANO ATUAL PESQUISADO
// Ano Atual
dc_uo_ds_base lvds_Ano
lvds_Ano = Create dc_uo_ds_base
If Not lvds_Ano.of_ChangeDataObject("ds_ge511_dados") Then
	Destroy(lvds_Ano)
	Return	
End If
If il_regiao>0 Then 	lvds_Ano.Of_AppendWhere("f.cd_regiao="+String(il_regiao))
If  is_rede<>"TD"  Then 	lvds_Ano.Of_AppendWhere("f.id_rede_filial='"+String(is_rede)+"'")
lvds_Ano.Retrieve(Date(iuo_parametro.ivdh_inicio_ano), Date(iuo_parametro.ivdt_ontem))


/// Mes Atual
dc_uo_ds_base lvds_Mes
lvds_Mes = Create dc_uo_ds_base
If Not lvds_Mes.of_ChangeDataObject("ds_ge511_dados") Then
	Destroy(lvds_Mes)
	Return	
End If
If il_regiao>0 Then lvds_Mes.Of_AppendWhere("f.cd_regiao="+String(il_regiao))
If  is_rede<>"TD"  Then 	lvds_Mes.Of_AppendWhere("f.id_rede_filial='"+String(is_rede)+"'")
lvds_Mes.Retrieve(Date(iuo_parametro.ivdh_inicio_mes), Date(iuo_parametro.ivdt_ontem))


////Dia Atual
dc_uo_ds_base lvds_Dia
lvds_Dia = Create dc_uo_ds_base
If Not lvds_Dia.of_ChangeDataObject("ds_ge511_dados") Then
	Destroy(lvds_Dia)
	Return	
End If
If il_regiao>0 Then  lvds_Dia.Of_AppendWhere("f.cd_regiao="+String(il_regiao))
If  is_rede<>"TD"  Then lvds_Dia.Of_AppendWhere("f.id_rede_filial='"+String(is_rede)+"'")
lvds_Dia.Retrieve(Date(iuo_parametro.ivdt_ontem), Date(iuo_parametro.ivdt_ontem)) 


////////////////////////   ANO ANTERIOR AO PESQUISADO
// Ano Anterior Ano
dc_uo_ds_base lvds_AnoAnteior
lvds_AnoAnteior = Create dc_uo_ds_base
If Not lvds_AnoAnteior.of_ChangeDataObject("ds_ge511_dados") Then
	Destroy(lvds_AnoAnteior)
	Return	
End If
If il_regiao>0 Then  lvds_AnoAnteior.Of_AppendWhere("f.cd_regiao="+String(il_regiao))
If  is_rede<>"TD"  Then lvds_AnoAnteior.Of_AppendWhere("f.id_rede_filial='"+String(is_rede)+"'")
lvds_AnoAnteior.Retrieve(Date(ivs_dt_inicio_AnoAnterior), Date(ivs_dt_inicio_DiaAnoAnterior))


/// Ano Anterior Mes
dc_uo_ds_base lvds_AnoMesAnteior
lvds_AnoMesAnteior = Create dc_uo_ds_base
If Not lvds_AnoMesAnteior.of_ChangeDataObject("ds_ge511_dados") Then
	Destroy(lvds_AnoMesAnteior)
	Return	
End If
If il_regiao>0 Then lvds_AnoMesAnteior.Of_AppendWhere("f.cd_regiao="+String(il_regiao))
If  is_rede<>"TD"  Then lvds_AnoMesAnteior.Of_AppendWhere("f.id_rede_filial='"+String(is_rede)+"'")
lvds_AnoMesAnteior.Retrieve(Date(ivs_dt_inicio_MesAnoAnterior),Date(ivs_dt_termino_MesAnoAnterior))


// Ano Anterior Dia
dc_uo_ds_base lvds_AnoDiaAnteior
lvds_AnoDiaAnteior = Create dc_uo_ds_base
If Not lvds_AnoDiaAnteior.of_ChangeDataObject("ds_ge511_dados") Then
	Destroy(lvds_AnoDiaAnteior)
	Return	
End If
If il_regiao>0 Then  lvds_AnoDiaAnteior.Of_AppendWhere("f.cd_regiao="+String(il_regiao))
If  is_rede<>"TD"  Then lvds_AnoDiaAnteior.Of_AppendWhere("f.id_rede_filial='"+String(is_rede)+"'")
lvds_AnoDiaAnteior.Retrieve(Date(ivs_dt_inicio_DiaAnoAnterior), Date(ivs_dt_inicio_DiaAnoAnterior)) 


//   Para Carregar os Dados
For lvl_Linha = 1 To lvl_ContaDados
	lvs_Canal = dw_2.Object.cd_canal_venda[lvl_Linha]
	lvs_desc_modo_entrega  = dw_2.Object.desc_modo_entrega[lvl_Linha] 
	dw_2.Object.nr_mes[lvl_Linha] = 	lvi_numero_mes
	dw_2.Object.nr_ano[lvl_Linha] = 	lvi_numero_ano
	dw_2.Object.nr_dia[lvl_Linha] = 	lvi_numero_dia
	
	dw_2.Object.nm_mes[lvl_Linha] = ivs_nome_mes
	
	
	// Linha do Dia
	lvl_FindDia = lvds_Dia.Find("desc_modo_entrega = '"+String(lvs_desc_modo_entrega)+"'"+ " and cd_canal_venda = '" + String(lvs_Canal) + "'", 1, lvds_Dia.RowCount())
	lvl_FindDiaAnterior = lvds_AnoDiaAnteior.Find("desc_modo_entrega = '"+String(lvs_desc_modo_entrega)+"'"+ " and cd_canal_venda = '" + String(lvs_Canal) + "'", 1, lvds_AnoDiaAnteior.RowCount())
	
	// Linha do Mes
	lvl_FindMes = lvds_Mes.Find("desc_modo_entrega = '"+String(lvs_desc_modo_entrega)+"'"+ " and cd_canal_venda = '" + String(lvs_Canal) + "'", 1, lvds_Mes.RowCount())
	lvl_FindMesAnterior = lvds_AnoMesAnteior.Find("desc_modo_entrega = '"+String(lvs_desc_modo_entrega)+"'"+ " and cd_canal_venda = '" + String(lvs_Canal) + "'", 1, lvds_AnoMesAnteior.RowCount())

	// Linha do Ano
	lvl_FindAno = lvds_Ano.Find("desc_modo_entrega = '"+String(lvs_desc_modo_entrega)+"'"+ " and cd_canal_venda = '" + String(lvs_Canal) + "'", 1, lvds_Ano.RowCount())
	lvl_FindAnoAnterior = lvds_AnoAnteior.Find("desc_modo_entrega = '"+String(lvs_desc_modo_entrega)+"'"+ " and cd_canal_venda = '" + String(lvs_Canal) + "'", 1, lvds_AnoAnteior.RowCount())
	
	If  lvl_FindDiaAnterior>0 Then 
		dw_2.Object.vlr_ano_dia_anterior[lvl_Linha] = lvds_AnoDiaAnteior.Object.vl_venda[lvl_FindDiaAnterior]		
	End If 
	
	If lvl_FindAnoAnterior>0 Then  
		dw_2.Object.vlr_ano_anterior[lvl_Linha] = lvds_AnoAnteior.Object.vl_venda[lvl_FindAnoAnterior]
	End If 
	
	If lvl_FindMesAnterior > 0 Then 
		dw_2.Object.vlr_ano_mes_anterior[lvl_Linha] = lvds_AnoMesAnteior.Object.vl_venda[lvl_FindMesAnterior]		
	End If 
	
	
	// Atualiza Ano
	If lvl_FindAno >0 Then 
		dw_2.Object.vlr_ano[lvl_Linha] = lvds_Ano.Object.vl_venda[lvl_FindAno]	
        	dw_2.Object.qtd_cliente_ano[lvl_Linha] = lvds_Ano.Object.qtd_cliente[lvl_FindAno]	
		// PercAno Planilha		
		lvdc_SomaAno  =lvdc_SomaAno + lvds_Ano.Object.vl_venda[lvl_FindAno]	
	
		// PercEvolucao Ano Planilha
		If dw_2.Object.vlr_ano_anterior[lvl_Linha]>0 Then 
			dw_2.Object.evo_ano[lvl_Linha]   =   (( lvds_Ano.Object.vl_venda[lvl_FindAno] - dw_2.Object.vlr_ano_anterior[lvl_Linha])/dw_2.Object.vlr_ano_anterior[lvl_Linha])*100 		
		End If 
	End If 		

	// Atualiza Mes
	If lvl_FindMes >0 Then 
		dw_2.Object.vlr_mes[lvl_Linha] = lvds_Mes.Object.vl_venda[lvl_FindMes]		
		dw_2.Object.qtd_cliente_mes[lvl_Linha] = lvds_Mes.Object.qtd_cliente[lvl_FindMes]			
		// PercMes Planilha		
		lvdc_SomaMes  =lvdc_SomaMes + lvds_Mes.Object.vl_venda[lvl_FindMes]	
	
		// PercEvolucao Mes Planilha
		If dw_2.Object.vlr_ano_mes_anterior[lvl_Linha]>0 Then 
			dw_2.Object.evo_mes[lvl_Linha]   =   (( lvds_Mes.Object.vl_venda[lvl_FindMes] - dw_2.Object.vlr_ano_mes_anterior[lvl_Linha])/dw_2.Object.vlr_ano_mes_anterior[lvl_Linha])*100 		
		End If 
	End If 
	
	// Atualiza Dia
	If lvl_FindDia >0 Then 
		dw_2.Object.vlr_dia[lvl_Linha] 				= lvds_Dia.Object.vl_venda[lvl_FindDia]		
		dw_2.Object.qtd_cliente_dia[lvl_Linha] 	= lvds_Dia.Object.qtd_cliente[lvl_FindDia]		
		// PercDia Planilha		
		lvdc_SomaDia  		= lvdc_SomaDia+ lvds_Dia.Object.vl_venda[lvl_FindDia]		
		
		// PercEvolucao Dia Planilha
		If dw_2.Object.vlr_ano_dia_anterior[lvl_Linha]>0 Then 
			dw_2.Object.evo_dia[lvl_Linha]   =   (( lvds_Dia.Object.vl_venda[lvl_FindDia] - dw_2.Object.vlr_ano_dia_anterior[lvl_Linha])/dw_2.Object.vlr_ano_dia_anterior[lvl_Linha])*100 		
		End If 
	End If 
	
Next

// PercDia Planilha		
For lvl_Linha = 1 To lvl_ContaDados    
	If lvdc_SomaDia >  0  Then  dw_2.Object.part_dia[lvl_Linha]   =  ((dw_2.Object.vlr_dia[lvl_Linha] / lvdc_SomaDia)*100)
	If lvdc_SomaMes  > 0 Then dw_2.Object.part_mes[lvl_Linha]   =  ((dw_2.Object.vlr_mes[lvl_Linha] / lvdc_SomaMes)*100)
	If lvdc_SomaAno >0 Then dw_2.Object.part_ano[lvl_Linha]   =  ((dw_2.Object.vlr_ano[lvl_Linha] / lvdc_SomaAno)*100)	
Next 

// Texto Dia/Mes Ano
If lvl_ContaDados>0 Then 
	dw_2.Object.t_dia.Text = "Dia: " + String(lvi_numero_dia)
	dw_2.Object.t_ano.Text = "Ano: " + String(lvi_numero_ano)
	dw_2.Object.t_mes.Text = "M$$HEX1$$ea00$$ENDHEX$$s: " + String(ivs_nome_mes)
End If 

Destroy(lvds_Ano)
Destroy(lvds_Mes)
Destroy(lvds_Dia)
Destroy(lvds_AnoAnteior)
Destroy(lvds_AnoMesAnteior)
Destroy(lvds_AnoDiaAnteior)
end subroutine

public subroutine wf_insere_padrao ();// Coloca o item TODAS
DataWindowChild ldw_Child
DataWindowChild ldw_Child2

Long lvl_Regiao

If dw_1.GetChild("cd_regiao", ldw_Child) = 1 Then
	
	ldw_Child.InsertRow(1)

	ldw_Child.SetItem(1,"cd_regiao",0)
	ldw_Child.SetItem(1,"de_regiao","TODAS")
	
	dw_1.Object.cd_regiao[1] = 0
Else
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao incluir o item 'TODAS' na coluna regi$$HEX1$$e300$$ENDHEX$$o.", StopSign!)
End If

select cd_regiao
Into :lvl_Regiao
From regiao
Where nr_matricula_regional = :gvo_aplicacao.ivo_seguranca.nr_matricula
Using SQLCa;

If SQLCa.SQLCode = 0 Then
	dw_1.Object.cd_regiao[1] = lvl_Regiao
Else
	dw_1.Object.cd_regiao[1] = 0	
End If


If dw_1.GetChild("cd_rede", ldw_Child2) = 1 Then
	ldw_Child2.InsertRow(1)
	ldw_Child2.SetItem(1,"id_rede","TD")
	ldw_Child2.SetItem(1,"nm_rede","TODAS")
	dw_1.Object.cd_rede[1] = "TD"
Else
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao incluir o item 'TODAS' na coluna rede.", StopSign!)
End If

end subroutine

on w_ge511_vendas_canais.create
call super::create
end on

on w_ge511_vendas_canais.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;SetPointer(HourGlass!)

iuo_parametro = Create uo_parametro_janelas

dw_1.InsertRow(0)
wf_insere_padrao()

dw_1.Object.dt_analise [1] = RelativeDate(Today(),-1)
ivdt_inicio = dw_1.Object.dt_analise [1]
il_regiao = dw_1.Object.cd_regiao [1]

wf_monta_data_atual()

dw_2.Event ue_preretrieve()

ivm_menu.ivb_permite_imprimir = True
ivm_menu.mf_imprimir(True)
ivm_menu.mf_salvarcomo(True)

SetPointer(Arrow!)
end event

event close;call super::close;Destroy(iuo_parametro)
end event

event ue_saveas;call super::ue_saveas;dw_1.Event ue_SaveAs()
end event

event ue_print;//override
dw_2.event ue_imprimir_relatorio( is_nm_Relatorio , "CL", False)
end event

event ue_printimmediate;//override
dw_2.event ue_imprimir_relatorio(is_nm_Relatorio , "CL", True)
end event

event ue_preopen;call super::ue_preopen;This.ivm_menu.ivb_permite_imprimir = True
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge511_vendas_canais
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge511_vendas_canais
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge511_vendas_canais
integer x = 23
integer y = 348
integer width = 4850
integer height = 2332
long backcolor = 16777215
string text = "Canal de Vendas"
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge511_vendas_canais
integer x = 27
integer y = 12
integer width = 1929
integer height = 328
long backcolor = 134217732
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge511_vendas_canais
integer x = 46
integer y = 60
integer width = 1888
integer height = 264
string dataobject = "dw_ge511_selecao"
end type

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge511_vendas_canais
integer x = 46
integer y = 392
integer width = 4800
integer height = 2272
string title = "Relat$$HEX1$$f300$$ENDHEX$$rio de Vendas por Canal"
string dataobject = "dw_ge511_lista"
string ivs_cor_linha_padrao = ""
end type

event dw_2::ue_postretrieve;call super::ue_postretrieve;Parent.ivm_menu.mf_imprimir(This.RowCount()>0)
Parent.ivm_menu.mf_salvarcomo(This.RowCount()>0)
ivm_menu.mf_salvarcomo(True)

If This.RowCount() > 0 Then	
	This.Event RowFocusChanged(1)
	This.SetRow(1)
	This.SetFocus()
End If

Return This.RowCount()

end event

event dw_2::ue_reset;call super::ue_reset;Parent.ivm_menu.mf_imprimir(False)
Parent.ivm_menu.mf_salvarcomo(False)

end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;dw_1.AcceptText()
//dw_2.Reset()

//Reinicia o filtro de par$$HEX1$$e200$$ENDHEX$$metros selecionados para gerar o relat$$HEX1$$f300$$ENDHEX$$rio
This.ivs_Filtro_Relatorio = {""}

ivdt_Inicio					= dw_1.Object.dt_analise			[1]
il_regiao						= dw_1.Object.cd_regiao			[1]
is_rede						= dw_1.Object.cd_rede				[1]

lvi_numero_mes	= Month(dw_1.Object.dt_analise			[1])
lvi_numero_dia 	= Day(dw_1.Object.dt_analise				[1])
lvi_numero_ano 	= Year(dw_1.Object.dt_analise				[1])

If Isnull(ivdt_Inicio) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio corretamente.")
	dw_1.SetFocus()
	dw_1.Event ue_Pos(1, "dt_inicio")
	Return -1 
End If

If ivdt_Inicio >= Today() Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Data n$$HEX1$$e300$$ENDHEX$$o pode ser maior ou a hoje.", Information!, OK!)
	dw_1.Event ue_pos(1,'dt_analise')
	Return -1
End If


This.Retrieve()

This.ivs_filtro_relatorio [ UpperBound(This.ivs_filtro_relatorio) +1 ] = "Periodo(DataBase): "+Trim(String(ivdt_Inicio))
This.ivs_filtro_relatorio [ UpperBound(This.ivs_filtro_relatorio) +1 ] = "Regi$$HEX1$$e300$$ENDHEX$$o: "+Parent.dw_1.Describe("Evaluate('LookUpDisplay(cd_regiao)',1)")
This.ivs_filtro_relatorio [ UpperBound(This.ivs_filtro_relatorio) +1 ] = "Rede: "+Parent.dw_1.Describe("Evaluate('LookUpDisplay(cd_rede)',1)")

wf_monta_data_atual()
wf_atualiza_informacoes()  

dw_1.Event RowFocusChanged(1)
dw_1.SetRow(1)
dw_1.SetFocus()

ivm_menu.ivb_permite_imprimir = True
ivm_menu.mf_imprimir(True)
ivm_menu.mf_salvarcomo(True)

SetPointer(Arrow!)

Return AncestorReturnValue
end event

event dw_2::ue_recuperar;call super::ue_recuperar;dw_2.Event ue_preretrieve()

Return 1

end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge511_vendas_canais
boolean visible = false
integer x = 2432
integer y = 44
integer width = 1001
integer height = 268
boolean enabled = false
string dataobject = "dw_ge511_lista_relatorio"
end type

event dw_3::ue_preprint;call super::ue_preprint;this.Object.t_periodo.Text = string(dw_1.Object.dt_inicio[1],"dd/mm/yyyy")+&
                             ' $$HEX1$$e000$$ENDHEX$$ '+string(dw_1.Object.dt_termino[1],"dd/mm/yyyy")
									  
This.Object.t_rede.Text = dw_1.Describe("Evaluate('LookUpDisplay(cd_filial_ecommerce)', 1)")

return 1
end event

