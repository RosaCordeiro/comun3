HA$PBExportHeader$w_ge342_relatorio_rentab_pbm.srw
forward
global type w_ge342_relatorio_rentab_pbm from dc_w_selecao_lista_relatorio
end type
type pb_info from picturebutton within w_ge342_relatorio_rentab_pbm
end type
end forward

global type w_ge342_relatorio_rentab_pbm from dc_w_selecao_lista_relatorio
integer width = 6418
integer height = 2272
string title = "GE342 - Relat$$HEX1$$f300$$ENDHEX$$rio de Rentabilidade PBM Sumarizado por M$$HEX1$$ea00$$ENDHEX$$s/Ano"
long backcolor = 80269524
pb_info pb_info
end type
global w_ge342_relatorio_rentab_pbm w_ge342_relatorio_rentab_pbm

type variables
uo_filial ivo_filial
uo_produto ivo_produto

DataWindowChild	idwc_Child
String ivs_Info = '' //Mensagem bot$$HEX1$$e300$$ENDHEX$$o info
end variables

forward prototypes
public subroutine wf_atualiza_totais ()
public subroutine wf_recupera_informacoes (date adt_inicio, date adt_termino)
public subroutine wf_seta_mensagem_informacao ()
end prototypes

public subroutine wf_atualiza_totais ();Long lvl_Row, lvl_Linhas, lvl_Qt_Atualiza

Decimal{2}	lvdc_Vendas			, &
				lvdc_Cmv			, &
				lvdc_Comissao		, &
				lvdc_Impostos		, &
				lvdc_Total_Vendas	, &
				lvdc_Rentabilidade

Try
	dw_2.SetRedraw(False)
	Open(w_Aguarde)
	w_Aguarde.Title = "Atualizando os Totais..."
	
	lvl_Linhas = dw_2.RowCount()
	w_Aguarde.uo_Progress.of_SetMax(lvl_Linhas)
	
	lvdc_Total_Vendas = dw_2.Object.Sum_Vl_Vendas[1]
	
	//Seta percentual de atualiza$$HEX2$$e700e300$$ENDHEX$$o da tela, para otimizar performance
	lvl_Qt_Atualiza = IIF(lvl_Linhas > 100000, 1000, Truncate(lvl_Linhas / 100,0))
	lvl_Qt_Atualiza = IIF(lvl_Qt_Atualiza=0, 10, lvl_Qt_Atualiza)
	
	For lvl_Row = 1 To lvl_Linhas
		lvdc_Vendas		= dw_2.Object.Vl_Vendas  	[lvl_Row]
		lvdc_Cmv			= dw_2.Object.Vl_Cmv    	[lvl_Row]
		lvdc_Comissao	= dw_2.Object.Vl_Comissao	[lvl_Row]
		lvdc_Impostos	= dw_2.Object.Vl_Impostos	[lvl_Row]
		
		lvdc_Rentabilidade = lvdc_Vendas - lvdc_CMV - lvdc_Comissao - lvdc_Impostos
	
		dw_2.Object.Perc_Vendas     [lvl_Row] = Round(lvdc_Vendas / lvdc_Total_Vendas * 100, 2)
		dw_2.Object.Vl_Rentabilidade[lvl_Row] = lvdc_Rentabilidade
		
		If lvdc_Vendas <> 0 Then
			dw_2.Object.Perc_Cmv					[lvl_Row] = Round(lvdc_Cmv				/ lvdc_Vendas * 100, 2)
			dw_2.Object.Perc_Comissao			[lvl_Row] = Round(lvdc_Comissao		/ lvdc_Vendas * 100, 2)
			dw_2.Object.Perc_Impostos			[lvl_Row] = Round(lvdc_Impostos		/ lvdc_Vendas * 100, 2)
			dw_2.Object.Perc_Rentabilidade	[lvl_Row] = Round(lvdc_Rentabilidade / lvdc_Vendas * 100, 2)
		Else
			dw_2.Object.Perc_Cmv					[lvl_Row] = 0
			dw_2.Object.Perc_Comissao			[lvl_Row] = 0
			dw_2.Object.Perc_Impostos			[lvl_Row] = 0
			dw_2.Object.Perc_Rentabilidade	[lvl_Row] = 0
		End If
			
		If Mod(lvl_Row, lvl_Qt_Atualiza)=0 Then w_Aguarde.uo_Progress.of_SetProgress(lvl_Row)
	Next

Catch (RuntimeError lvo_Erro)
	MessageBox('Erro', lvo_Erro.GetMessage(), StopSign!)
	Return 

Finally
	If IsValid(w_Aguarde) Then Close(w_Aguarde)
	dw_2.SetRedraw(True)
End Try
end subroutine

public subroutine wf_recupera_informacoes (date adt_inicio, date adt_termino);Date lvdt_Inicio,&
	   lvdt_Termino,&
	   lvdt_AnoMes

Boolean lvb_Sucesso = True

Decimal lvdc_Venda,&
	    lvdc_CMV,&
		lvdc_CMV_Geral,&
		lvdc_Comissao,&
		lvdc_VL_ICMS,&
		lvdc_VL_PIS_COFINS,&
		lvdc_VL_Impostos,&
		lvdc_CMV_Calculado
	

Long lvl_Produto,&
	 lvl_Linha,&
	 lvl_Linhas,&
	 lvl_Find,&
	 lvl_Insert,&
	 lvl_Qtde,&
	 lvl_Filial,&
	 lvl_PBM,&
	 lvl_Convenio, &
	 lvl_Qt_Atualiza, &
	 ll_Mes

String lvs_Produto	, &
		lvs_Grupo		, &
		lvs_Id_Grupo	, &
		lvs_PBM			, &
		lvs_Programa	, &
		lvs_Aux			, &
		lvs_SQL			, &
		lvs_Nm_Fantasia		

Try
	dw_1.AcceptText()
	dw_2.SetRedraw(False)
	
	dc_uo_ds_base lvds_1
	lvds_1 = Create dc_uo_ds_base
	
	dc_uo_ds_base lvds_2
	lvds_2 = Create dc_uo_ds_base
	
	If Not lvds_1.Of_ChangeDataObject("ds_ge342_venda") Then Return	
	If Not lvds_2.Of_ChangeDataObject("ds_ge342_devolucao") Then Return
	
	lvl_Produto		= dw_1.Object.cd_produto	[1]
	lvl_PBM		 	= dw_1.Object.cd_pbm			[1]
	lvl_Filial		= dw_1.Object.cd_filial		[1]
	lvs_Id_Grupo	= dw_1.Object.id_grupo		[1]
	lvs_Pbm			= dw_1.Object.id_pbm			[1]
	lvl_Convenio	= dw_1.Object.cd_convenio	[1]
	lvs_Programa	= dw_1.Object.cd_programa	[1]
	
	// Para filtro do Convenio
	If (lvl_Convenio>0) then 
		 lvds_1.of_AppendWhere("vp.cd_convenio = " + String(lvl_Convenio))
		 lvds_2.of_AppendWhere("vp.cd_convenio = " + String(lvl_Convenio))
	end if 
	
	// Para filtro do Produto
	If Not IsNull(lvl_Produto) Then
		lvds_1.of_AppendWhere("i.cd_produto = " + String(lvl_Produto))
		lvds_2.of_AppendWhere("i.cd_produto = " + String(lvl_Produto))
	End If
	
	// Para filtro de Filial
	If Not IsNull(lvl_Filial) Then
		lvds_1.of_AppendWhere("vp.cd_filial = " + String(lvl_Filial))
		lvds_2.of_AppendWhere("vp.cd_filial = " + String(lvl_Filial))	
		lvs_SQL = lvds_1.GetSQLSelect()
		lvs_SQL = gf_replace(lvs_SQL, 'idx_data_convenio','idx_fil_dt_conv',0)
		lvds_1.SetSQLSelect(lvs_SQL)
	End If
	
	// Para filtro do Grupo
	If lvs_Id_Grupo <> '0' Then
		lvds_1.of_AppendWhere("substring(g.cd_subcategoria,1,1) = '" + lvs_Id_Grupo + "'")
		lvds_2.of_AppendWhere("substring(g.cd_subcategoria,1,1) = '" + lvs_Id_Grupo + "'")
	End If
	
	// Para filtro do Programa
	If lvs_Programa<>'' Then
		Choose Case lvl_Convenio
			Case 52575, 53724, 53725 //VIDALINK
				lvds_1.of_AppendWhere("vp.nr_comprovante_venda='"+lvs_Programa+"'")
				lvds_2.of_AppendWhere("vp.nr_comprovante_venda='"+lvs_Programa+"'")
			Case Else 
				lvds_1.of_AppendWhere("vp.cd_convenio_pbm='"+lvs_Programa+"'")
				lvds_2.of_AppendWhere("vp.cd_convenio_pbm='"+lvs_Programa+"'")
		End Choose
	End If
	
	If (lvs_PBM = 'S')or(lvl_PBM>0) Then
		If (lvl_PBM>0) Then
			lvs_Aux = String(lvl_PBM)
		else
			lvs_Aux = 'p1.cd_pbm'
		End If
		If adt_Inicio >= Date('01/05/2015') Then
			lvds_1.of_AppendWhere("vpp.id_pbm='S'")		
			lvds_2.of_AppendWhere("vpp.id_pbm='S'")		
		End If		
		If (adt_Inicio <= Date('30/04/2015'))or(lvl_PBM>0) Then
			lvds_1.of_AppendWhere("exists (select pb1.cd_convenio, pb1.cd_pbm, p1.cd_produto "	+ &
													"from pbm pb1 " 													+ &
													"inner join pbm_produto p1 (index pk_pbm_produto) " 	+ &
														"on p1.cd_pbm = pb1.cd_pbm " 							+ &
													"where pb1.cd_convenio = vp.cd_convenio "				+ &
														"and p1.cd_produto = vpp.cd_produto "					+ &
														"and pb1.cd_pbm="+lvs_Aux+" "+							+ &
													"group by pb1.cd_convenio, pb1.cd_pbm, p1.cd_produto) ")
			lvds_2.of_AppendWhere("exists (select pb1.cd_convenio, pb1.cd_pbm, p1.cd_produto "	+ &
													"from pbm pb1 " 													+ &
													"inner join pbm_produto p1 (index pk_pbm_produto) " 	+ &
														"on p1.cd_pbm = pb1.cd_pbm " 							+ &
													"where pb1.cd_convenio = vp.cd_convenio " 				+ &
														"and p1.cd_produto = i.cd_produto "						+ &
														"and p1.cd_pbm="+lvs_Aux+" "+							+ &
													"group by pb1.cd_convenio, pb1.cd_pbm, p1.cd_produto) ")
		End If									
	End If
	
	Open(w_Aguarde)
	w_Aguarde.Title = 'Recuperando Vendas...'
	lvs_Aux = lvds_1.GetSQLSelect()
	lvds_1.Retrieve(adt_Inicio, adt_Termino,lvl_Convenio)
	
	w_Aguarde.Title = 'Recuperando Devolu$$HEX2$$e700f500$$ENDHEX$$es...'
	lvs_Aux = lvds_2.GetSQLSelect()
	lvl_Linhas = lvds_2.Retrieve(adt_Inicio, adt_Termino,lvl_Convenio)
	
	w_Aguarde.Title = 'Processando Devolu$$HEX2$$e700f500$$ENDHEX$$es...'
	w_Aguarde.uo_Progress.Of_SetMax(lvl_Linhas)
	lvl_Qt_Atualiza = IIF(lvl_Linhas > 100000, 1000, Truncate(lvl_Linhas / 100,0))
	lvl_Qt_Atualiza = IIF(lvl_Qt_Atualiza=0, 1, lvl_Qt_Atualiza)
	
	//Deduz as devolu$$HEX2$$e700f500$$ENDHEX$$es
	For lvl_Linha = 1 To lvds_2.RowCount()
		//lvl_Filial 	     	= lvds_2.Object.cd_filial		[lvl_Linha]	
		lvl_Produto      		= lvds_2.Object.Cd_Produto		[lvl_Linha]
		
		//lvl_Find = lvds_1.Find("cd_filial="+String(lvl_Filial)+" and cd_produto="+String(lvl_Produto)+" and pc_imposto="+gf_replace(String(lvdc_Perc_Imposto),',','.',0),1,lvds_1.RowCount())
		lvl_Find = lvds_1.Find("cd_produto="+String(lvl_Produto),1,lvds_1.RowCount())
		
		If Not(lvl_Find > 0) Then
			lvl_Find = lvds_1.InsertRow(0)
			
			//lvds_1.Object.cd_filial			  		[lvl_Find] = lvl_Filial	
			lvds_1.Object.Cd_Produto		  			[lvl_Find] = lvl_Produto	
			lvds_1.Object.de_Produto					[lvl_Find] = lvds_2.Object.de_Produto					[lvl_Linha]
			lvds_1.Object.de_apresentacao_venda		[lvl_Find] = lvds_2.Object.de_apresentacao_venda	[lvl_Linha]			
			lvds_1.Object.dh_data						[lvl_Find] = lvds_2.Object.dh_data						[lvl_Linha]
			lvds_1.Object.nm_fantasia					[lvl_Find] = lvds_2.Object.nm_fantasia					[lvl_Linha]		
			
			lvds_1.Object.vl_venda						[lvl_Find] = 0.00
			lvds_1.Object.qt_vendida					[lvl_Find] = 0.00
			lvds_1.Object.vl_CMV							[lvl_Find] = 0.00
			lvds_1.Object.vl_CMV_Geral					[lvl_Find] = 0.00
			lvds_1.Object.vl_comissao					[lvl_Find] = 0.00
			lvds_1.Object.cd_tributacao_icms			[lvl_Find] = lvds_2.Object.cd_tributacao_icms			[lvl_Linha]
			lvds_1.Object.id_situacao_pis_cofins	[lvl_Find] = lvds_2.Object.id_situacao_pis_cofins		[lvl_Linha]	
			lvds_1.Object.grupo                		[lvl_Find] = lvds_2.Object.grupo                		[lvl_Linha]
			lvds_1.Object.vl_icms						[lvl_Find] = 0.00
			lvds_1.Object.vl_pis_cofins				[lvl_Find] = 0.00
		End If
		
		lvdc_Venda				= lvds_1.Object.vl_venda		[lvl_Find]	
		lvl_Qtde					= lvds_1.Object.qt_vendida		[lvl_Find]	
		lvdc_CMV					= lvds_1.Object.vl_CMV			[lvl_Find]
		lvdc_CMV_Geral			= lvds_1.Object.vl_CMV_Geral	[lvl_Find] 
		lvdc_Comissao			= lvds_1.Object.vl_comissao	[lvl_Find]
		lvdc_VL_ICMS			= lvds_1.Object.vl_icms			[lvl_Find]
		lvdc_VL_PIS_COFINS	= lvds_1.Object.vl_pis_cofins	[lvl_Find]
		
		lvds_1.Object.qt_vendida		[lvl_Find] = lvl_Qtde				- lvds_2.Object.qt_devolvida		[lvl_Linha]
		lvds_1.Object.vl_venda			[lvl_Find] = lvdc_Venda 			- lvds_2.Object.vl_devolucao	[lvl_Linha]
		lvds_1.Object.vl_CMV				[lvl_Find] = lvdc_CMV				- lvds_2.Object.vl_CMV			[lvl_Linha]
		lvds_1.Object.vl_CMV_Geral		[lvl_Find] = lvdc_CMV_Geral		- lvds_2.Object.vl_CMV_Geral	[lvl_Linha]
		lvds_1.Object.vl_comissao		[lvl_Find] = lvdc_Comissao			- lvds_2.Object.vl_comissao		[lvl_Linha]
		lvds_1.Object.vl_icms			[lvl_Find] = lvdc_VL_ICMS			- lvds_2.Object.vl_icms			[lvl_Linha]
		lvds_1.Object.vl_pis_cofins	[lvl_Find] = lvdc_VL_PIS_COFINS	- lvds_2.Object.vl_pis_cofins	[lvl_Linha]
				
		If Mod(lvl_Linha, lvl_Qt_Atualiza)=0 Then w_aguarde.uo_Progress.of_SetProgress(lvl_Linha)
	Next
	
	lvl_Linhas = lvds_1.RowCount()
	w_Aguarde.Title = 'Processando Vendas...'
	w_Aguarde.uo_Progress.Of_SetMax(lvl_Linhas)
	lvl_Qt_Atualiza = IIF(lvl_Linhas > 100000, 1000, Truncate(lvl_Linhas / 100,0))
	lvl_Qt_Atualiza = IIF(lvl_Qt_Atualiza=0, 1, lvl_Qt_Atualiza)
	
	For lvl_Linha = 1 To lvl_Linhas
		
		lvl_Produto				= lvds_1.Object.Cd_Produto		  		[lvl_Linha]	
		lvs_Produto				= lvds_1.Object.de_Produto				[lvl_Linha] + " : " + lvds_1.Object.de_apresentacao_venda [lvl_Linha]	
		lvs_Nm_Fantasia		= lvds_1.Object.nm_fantasia 	 		[lvl_Linha]	
		lvdt_AnoMes				= date(lvds_1.Object.dh_data			[lvl_Linha])
		lvdc_Venda				= lvds_1.Object.vl_venda				[lvl_Linha]	
		lvl_Qtde					= lvds_1.Object.qt_vendida				[lvl_Linha]	
		lvdc_CMV					= lvds_1.Object.vl_CMV					[lvl_Linha]	
		lvdc_CMV_Geral			= lvds_1.Object.vl_CMV_Geral			[lvl_Linha]	
		lvdc_Comissao			= lvds_1.Object.vl_comissao			[lvl_Linha]		
		lvs_Grupo				= lvds_1.Object.grupo					[lvl_Linha] 
		lvdc_VL_ICMS			= lvds_1.Object.vl_icms					[lvl_Linha]
		lvdc_VL_PIS_COFINS	= lvds_1.Object.vl_pis_cofins			[lvl_Linha]
		lvdc_VL_Impostos		= gf_coalesce(lvdc_VL_ICMS, 0) + gf_coalesce(lvdc_VL_PIS_COFINS, 0)
	
		ll_Mes = Month(lvdt_AnoMes)
				
		lvl_Find = dw_2.Find("cd_produto = " + String(lvl_Produto) + "and month(dh_data) = " + String(ll_Mes), 1, dw_2.RowCount())
			
		If lvl_Find = -1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o produto na DW.")
			Exit
		End If
		
		If lvl_Find = 0 Then
			lvl_Insert = dw_2.InsertRow(0)
			
			dw_2.Object.cd_produto		[lvl_Insert] = lvl_Produto
			dw_2.Object.de_produto		[lvl_Insert] = lvs_Produto
			dw_2.Object.nm_fantasia		[lvl_Insert] = lvs_Nm_Fantasia
			dw_2.Object.dh_data			[lvl_Insert] = lvdt_AnoMes		
			dw_2.Object.qt_vendas		[lvl_Insert] = lvl_Qtde
			dw_2.Object.vl_vendas		[lvl_Insert] = lvdc_Venda
			dw_2.Object.vl_cmv			[lvl_Insert] = lvdc_CMV
			dw_2.Object.vl_comissao		[lvl_Insert] = lvdc_Comissao
			dw_2.Object.vl_impostos		[lvl_Insert] = lvdc_VL_Impostos
			dw_2.Object.grupo				[lvl_Insert] = lvs_Grupo
		Else
			dw_2.Object.qt_vendas		[lvl_Find] = dw_2.Object.qt_vendas		[lvl_Find] + lvl_Qtde
			dw_2.Object.vl_vendas		[lvl_Find] = dw_2.Object.vl_vendas		[lvl_Find] + lvdc_Venda
			dw_2.Object.vl_cmv			[lvl_Find] = dw_2.Object.vl_cmv			[lvl_Find] + lvdc_CMV
			dw_2.Object.vl_comissao		[lvl_Find] = dw_2.Object.vl_comissao	[lvl_Find] + lvdc_Comissao
			dw_2.Object.vl_impostos		[lvl_Find] = dw_2.Object.vl_impostos	[lvl_Find] + lvdc_VL_Impostos
			//dw_2.Object.grupo			[lvl_Find] = dw_2.Object.grupo      	[lvl_Find] + lvs_Grupo
		End If
	
		If Mod(lvl_Linha, lvl_Qt_Atualiza)=0 Then w_aguarde.uo_Progress.of_SetProgress(lvl_Linha)
	Next

Catch (RuntimeError lvo_Erro)
	MessageBox('Erro', lvo_Erro.GetMessage(), StopSign!)
	Return

Finally
	If IsValid(lvds_1) Then Destroy(lvds_1)
	If IsValid(lvds_1) Then Destroy(lvds_2)
	If IsValid(w_Aguarde) Then Close(w_Aguarde)
	
	dw_2.SetRedraw(True)
End Try
end subroutine

public subroutine wf_seta_mensagem_informacao ();String lvs_Tipo_Calculo
String lvs_Dt_Calc_PIS
String lvs_Calc_PIS
String lvs_Calc_COF

String lvs_Inf_Imposto
String lvs_Inf_CMV

Date lvdt_Mes_Rel

dw_1.AcceptText()
lvdt_Mes_Rel = dw_1.Object.dt_inicio [1]

//Consulta tipo calculo PIS
Select coalesce(vl_parametro,'01/12/2024')
Into :lvs_Dt_Calc_PIS
from parametro_geral
Where cd_parametro = 'DH_INICIO_OPERACAO_PIS_COFINS'
Using SQLCa;

If SQLCa.SQLCode = -1 Then MessageBox('Falha', 'Falha ao buscar o parametro_geral DH_INICIO_OPERACAO_PIS_COFINS.~r~n'+SQLCa.SQLErrText,Exclamation!)
If SQLCa.SQLCode = 100 Then lvs_Dt_Calc_PIS = '01/12/2024'

//Consulta tipo calculo PIS
Select coalesce(vl_parametro,'1')
Into :lvs_Tipo_Calculo
from parametro_geral
Where cd_parametro = 'ID_CALCULO_PIS_COFINS'
Using SQLCa;

If SQLCa.SQLCode = -1 Then MessageBox('Falha', 'Falha ao buscar o parametro_geral ID_CALCULO_PIS_COFINS.~r~n'+SQLCa.SQLErrText,Exclamation!)
If SQLCa.SQLCode = 100 Then lvs_Tipo_Calculo = '1'

If Date(lvs_Dt_Calc_PIS) <= lvdt_Mes_Rel Then
	lvs_Inf_CMV = "$$HEX1$$c900$$ENDHEX$$ considerado o custo m$$HEX1$$e900$$ENDHEX$$dio de entrada da mercadoria, "+&
						"descontado dos impostos creditados (ICMS/PIS/COFINS)."
	
	Choose Case lvs_Tipo_Calculo
		Case '1' //Base PIS = Venda 
			lvs_Calc_PIS = "[ Valor Venda ] x [ Aliq. PIS ]"
			lvs_Calc_COF = "[ Valor Venda ] x [ Aliq. COFINS ]"
		Case '2' //Base PIS = Venda - ICMS
			lvs_Calc_PIS = "( [ Valor Venda ] - [Valor ICMS] ) x [ Aliq. PIS ]"
			lvs_Calc_COF = "( [ Valor Venda ] - [Valor ICMS] ) x [ Aliq. COFINS ]"
		Case '3' //Base PIS = Venda - ICMS
			lvs_Calc_PIS = "[ $$HEX1$$9403$$ENDHEX$$ Valor Agregado (Venda - CMV)] x [ Aliq. PIS ]"
			lvs_Calc_COF = "[ $$HEX1$$9403$$ENDHEX$$ Valor Agregado (Venda - CMV)] x [ Aliq. COFINS ]"
		Case '4' //Base PIS = Venda - CMV - ICMS 
			lvs_Calc_PIS = "( [ $$HEX1$$9403$$ENDHEX$$ Valor Agregado (Venda - CMV)] - [ Valor ICMS ] ) x [ Aliq. PIS ]"
			lvs_Calc_COF = "( [ $$HEX1$$9403$$ENDHEX$$ Valor Agregado (Venda - CMV)] - [ Valor ICMS ] ) x [ Aliq. PIS ]"
		Case '5' //Base PIS = CMV / (1 - % PIS)
			lvs_Calc_PIS = "( [ CMV ] / ( 1 - [ Aliq. PIS ] ) x [ Aliq. PIS ]"
			lvs_Calc_COF = "( [ CMV ] / ( 1 - [ Aliq. PIS ] ) x [ Aliq. PIS ]"
		Case Else //Zero
			lvs_Calc_PIS = ''
			lvs_Calc_COF = ''
	End Choose
Else 
	lvs_Inf_CMV = "$$HEX1$$c900$$ENDHEX$$ considerado o custo m$$HEX1$$e900$$ENDHEX$$dio de entrada da mercadoria, "+&
						"descontado do ICMS apenas. PIS e COFINS est$$HEX1$$e300$$ENDHEX$$o inclusos no CMV."
	lvs_Calc_PIS = ''
	lvs_Calc_COF = ''
End If
	
//Essa vari$$HEX1$$e100$$ENDHEX$$vel deve receber somente o texto que ser$$HEX1$$e100$$ENDHEX$$ exibido na coluna imposto
lvs_Inf_Imposto =	" + [ ICMS e ST ] = [ CMV Gerencial ] - [ CMV ]" + &
				IIF(lvs_Calc_PIS<>'', "~r~n + [ PIS ] = "+ lvs_Calc_PIS, '') + &
				IIF(lvs_Calc_PIS<>'', "~r~n + [ COFINS ] = "+ lvs_Calc_COF, '')

//Essa vari$$HEX1$$e100$$ENDHEX$$vel pode receber a explica$$HEX2$$e700e300$$ENDHEX$$o de mais colunas al$$HEX1$$e900$$ENDHEX$$m da coluna imposto
// ele ser$$HEX1$$e100$$ENDHEX$$ exibido no bot$$HEX1$$e300$$ENDHEX$$o de interroga$$HEX2$$e700e300$$ENDHEX$$o
ivs_Info =  "Coluna CMV: ~r~n" + lvs_Inf_CMV + "~r~n~r~n" + &
				"Coluna IMPOSTO: ~r~n"+lvs_Inf_Imposto

dw_2.Object.vl_impostos.Tooltip.Enabled = True
dw_2.Object.vl_impostos.Tooltip.Title = "Valor Imposto"
dw_2.Object.vl_impostos.Tooltip.Tip = lvs_Inf_Imposto

pb_info.Visible = True
end subroutine

on w_ge342_relatorio_rentab_pbm.create
int iCurrent
call super::create
this.pb_info=create pb_info
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_info
end on

on w_ge342_relatorio_rentab_pbm.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_info)
end on

event close;call super::close;Destroy(ivo_Filial)
Destroy(ivo_Produto)
end event

event ue_postopen;call super::ue_postopen;Date lvdt_Movimentacao

ivo_Filial  	= Create uo_Filial
ivo_Produto 	= Create uo_Produto

lvdt_Movimentacao = Date(gvo_Parametro.of_DH_Movimentacao())

dw_1.Object.dt_Inicio [1] = DateTime(gf_Primeiro_Dia_Mes(lvdt_Movimentacao))

If Day(lvdt_Movimentacao) = 1 Then
	dw_1.Object.dt_Termino [1] = gvo_Parametro.of_DH_Movimentacao()
Else
	dw_1.Object.dt_Termino[1] = DateTime(RelativeDate(lvdt_Movimentacao, -1) )	
End If

This.ivm_Menu.ivb_Permite_Imprimir = True
	
idwc_Child  = dw_1.of_InsertRow_DDDW("cd_pbm")	
idwc_Child.SetItem(1, "cd_pbm", 0	)
idwc_Child.SetItem(1, "nm_pbm", "TODOS"	)
dw_1.Object.cd_pbm [1] = 0

idwc_Child  = dw_1.of_InsertRow_DDDW("cd_programa")	
idwc_Child.SetItem(1, "cd_programa", ''	)
idwc_Child.SetItem(1, "de_programa", "TODOS")
//idwc_Child.SetItem(1, "cd_convenio", 0)
dw_1.Object.cd_programa [1] = ''

idwc_Child  = dw_1.of_InsertRow_DDDW("cd_convenio")	
idwc_Child.SetItem(1, "cd_convenio", 0	)
idwc_Child.SetItem(1, "nm_fantasia", "TODOS OS CONVENIOS")
dw_1.Object.cd_convenio[1] = 0



//dw_1.Event ItemChanged(1,dw_1.Object.cd_convenio,'52575')

Post wf_seta_mensagem_informacao()
end event

event ue_preopen;call super::ue_preopen;MaxWidth	= 6600
MaxHeight	= 9999

end event

event ue_print;//override
dw_3.Event ue_Print()
end event

event ue_printimmediate;//override
dw_3.Event ue_PrintImmediate()
end event

event ue_saveas;call super::ue_saveas;dw_3.Event ue_SaveAs()
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge342_relatorio_rentab_pbm
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge342_relatorio_rentab_pbm
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge342_relatorio_rentab_pbm
integer x = 18
integer y = 416
integer width = 6345
integer height = 1656
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge342_relatorio_rentab_pbm
integer x = 18
integer y = 8
integer width = 4302
integer height = 388
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge342_relatorio_rentab_pbm
integer x = 46
integer y = 72
integer width = 4137
integer height = 300
string dataobject = "dw_ge342_selecao"
end type

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then

	If This.GetColumnName() = 'nm_fantasia' Then
		ivo_Filial.of_Localiza_Filial(This.GetText())
		
		If ivo_Filial.Localizada Then
			This.Object.cd_filial	[1]	= ivo_Filial.cd_filial
			This.Object.nm_fantasia	[1] = ivo_Filial.nm_fantasia
		End If
	End If
	
	If This.GetColumnName() = 'de_produto' Then 
		ivo_Produto.of_Localiza_Produto(This.GetText())
		
		If ivo_Produto.Localizado Then
			This.Object.cd_produto[1] = ivo_Produto.cd_produto
			This.Object.de_produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
		End If
	End If
	
End If
end event

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case 'nm_fantasia'
		If Not IsNull(Data) and Trim(Data) <> '' Then
			If Data <> ivo_Filial.nm_fantasia Then
				Return 1
			End If
		Else
			ivo_Filial.of_Inicializa()
			
			This.Object.cd_filial	[1] = ivo_Filial.cd_filial
			This.Object.nm_fantasia	[1] = ivo_Filial.nm_fantasia
		End If
	Case 'de_produto' 
		If Not IsNull(Data) and Trim(Data) <> '' Then
			If Data <> ivo_Produto.ivs_Descricao_Apresentacao_Venda Then
				Return 1
			End If
		Else
			ivo_Produto.of_Inicializa()
			
			This.Object.cd_produto	[1] = ivo_Produto.cd_produto
			This.Object.de_produto	[1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
		End If
	Case 'cd_convenio'
		This.GetChild("cd_pbm", idwc_Child)	
		idwc_Child.SetFilter("cd_pbm=0 or cd_convenio="+Data)
		idwc_Child.Filter()
		This.Object.cd_pbm[1] = 0
		
		This.GetChild("cd_programa", idwc_Child)			
		idwc_Child.SetFilter("cd_convenio=0 or cd_convenio="+Data)
		idwc_Child.Filter()
		This.Object.cd_programa[1] = ''
	Case 'cd_programa'
		If Data = 'AVFARPOP' Then
			This.Object.id_pbm [1] = 'N'
		End If
End Choose
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Filial) Then
	This.Object.Cd_Filial	[1] = ivo_Filial.Cd_Filial
	This.Object.Nm_Fantasia	[1] = ivo_Filial.nm_fantasia
End If

If IsValid(ivo_Produto) Then
	This.Object.cd_produto	[1] = ivo_Produto.cd_produto
	This.Object.de_produto	[1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
End If


end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge342_relatorio_rentab_pbm
integer x = 27
integer y = 480
integer width = 6290
integer height = 1564
string dataobject = "dw_ge342_lista"
boolean hscrollbar = true
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_recuperar;// OverRide

Date lvdt_Inicio,&
	 lvdt_Termino

dw_1.AcceptText()

lvdt_Inicio 		= dw_1.Object.dt_inicio 		[1]
lvdt_Termino 	= dw_1.Object.dt_termino	[1]

If IsNull(lvdt_Inicio) or Not IsDate(String(lvdt_Inicio, "dd/mm/yyyy")) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data do in$$HEX1$$ed00$$ENDHEX$$cio corretamente.")
	dw_1.SetFocus()
	dw_1.Event ue_Pos(1,"dt_inicio")
	Return -1
End If

If IsNull(lvdt_Termino) or Not IsDate(String(lvdt_Termino, "dd/mm/yyyy")) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino corretamente.")
	dw_1.SetFocus()
	dw_1.Event ue_Pos(1,"dt_termino")
	Return -1
End If

If lvdt_Termino < lvdt_Inicio Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data o t$$HEX1$$e900$$ENDHEX$$rmino deve ser menor que a do in$$HEX1$$ed00$$ENDHEX$$cio.")
	dw_1.SetFocus()
	dw_1.Event ue_Pos(1,"dt_termino")
	Return -1
End If

This.SetRedraw(False)
This.Reset()

lvdt_Inicio = Date("01/" + String(lvdt_Inicio, "mm/yyyy"))
lvdt_Termino = gf_Retorna_Ultimo_Dia_Mes(lvdt_Termino)

wf_Recupera_Informacoes(lvdt_Inicio, lvdt_Termino)

Return This.RowCount()
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;This.ivm_Menu.mf_SalvarComo(pl_linhas > 0)
This.ivm_Menu.mf_Imprimir(pl_linhas > 0)

If pl_linhas > 0 Then
	
	wf_Atualiza_Totais()
	
	This.Sort()
	This.GroupCalc()
End If

wf_seta_mensagem_informacao()

This.SetRedraw(True)

Return AncestorReturnValue
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;This.ivm_Menu.mf_Imprimir(False)
This.ivm_Menu.mf_SalvarComo(False)

Return AncestorReturnValue
end event

event dw_2::ue_reset;call super::ue_reset;This.ivm_Menu.mf_Imprimir(False)
This.ivm_Menu.mf_SalvarComo(False)
end event

event dw_2::constructor;call super::constructor;This.ShareData(dw_3)

end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge342_relatorio_rentab_pbm
integer x = 4430
integer y = 64
integer width = 727
integer height = 276
string dataobject = "dw_ge342_relatorio"
end type

event dw_3::ue_preprint;call super::ue_preprint;Long lvl_Filial

String		lvs_Filial,&
			lvs_Programa

dw_1.AccepTtext()

lvl_Filial 	 = dw_1.Object.cd_filial  		[1] 

If IsNull(lvl_Filial) Then
	lvs_Filial = 'TODAS'
Else
	lvs_Filial = dw_1.Object.nm_fantasia[1] + " (" + String(lvl_Filial) + ")"
End If

This.Object.st_Periodo.Text		= String(dw_1.Object.dt_inicio[1] , 'dd/mm/yyyy') + " $$HEX1$$e000$$ENDHEX$$ " + String(dw_1.Object.dt_termino[1] , 'dd/mm/yyyy')
This.Object.st_Filial.Text			= lvs_Filial
This.Object.st_programa.Text	= dw_1.Describe("Evaluate('LookUpDisplay(cd_programa)',1)")

Return AncestorReturnValue
end event

type pb_info from picturebutton within w_ge342_relatorio_rentab_pbm
boolean visible = false
integer x = 4343
integer y = 244
integer width = 174
integer height = 148
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\information_1.png"
alignment htextalign = left!
end type

event clicked;If ivs_Info<>'' Then
	MessageBox("Informa$$HEX2$$e700e300$$ENDHEX$$o", ivs_Info)
End If
end event

