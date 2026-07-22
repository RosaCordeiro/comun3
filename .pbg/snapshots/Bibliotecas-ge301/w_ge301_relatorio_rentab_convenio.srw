HA$PBExportHeader$w_ge301_relatorio_rentab_convenio.srw
forward
global type w_ge301_relatorio_rentab_convenio from dc_w_selecao_lista_relatorio
end type
type pb_info from picturebutton within w_ge301_relatorio_rentab_convenio
end type
end forward

global type w_ge301_relatorio_rentab_convenio from dc_w_selecao_lista_relatorio
string tag = "w_ge301_relatorio_rentab_convenio"
integer width = 4475
integer height = 1888
string title = "GE301 - Relat$$HEX1$$f300$$ENDHEX$$rio de Rentabilidade Conv$$HEX1$$ea00$$ENDHEX$$nio"
long backcolor = 80269524
pb_info pb_info
end type
global w_ge301_relatorio_rentab_convenio w_ge301_relatorio_rentab_convenio

type variables
uo_filial ivo_filial
uo_produto ivo_produto
uo_promocao ivo_promocao
uo_convenio ivo_convenio

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
	Open(w_Aguarde)
	w_Aguarde.Title = "Atualizando os Totais..."
	
	lvl_Linhas = dw_2.RowCount()
	w_Aguarde.uo_Progress.of_SetMax(lvl_Linhas)
	
	lvdc_Total_Vendas = dw_2.Object.Sum_Vl_Vendas[1]
	
	//Seta percentual de atualiza$$HEX2$$e700e300$$ENDHEX$$o da tela, para otimizar performance
	lvl_Qt_Atualiza = IIF(lvl_Linhas > 100000, 1000, Truncate(lvl_Linhas / 100,0))
	lvl_Qt_Atualiza = IIF(lvl_Qt_Atualiza=0, 1, lvl_Qt_Atualiza)
	
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
End Try
end subroutine

public subroutine wf_recupera_informacoes (date adt_inicio, date adt_termino);Date	lvdt_Inicio	,&
		lvdt_Termino

Boolean lvb_Sucesso = True

Decimal 	lvdc_Venda			, &
			lvdc_CMV				, &
			lvdc_CMV_Geral		, &
			lvdc_Comissao		, &
			lvdc_VL_ICMS		, &
			lvdc_VL_PIS_COFINS, &
			lvdc_VL_Impostos	, &
			lvdc_CMV_Calculado
		
Long	lvl_Produto	, &
		lvl_Linha	, &
		lvl_Linhas	, &
		lvl_Find		, &
		lvl_Insert	, &
		lvl_Qtde		, &
		lvl_Filial	, &
		lvl_Convenio, &
		lvl_Promocao, &
		lvl_Qt_Atualiza

String	lvs_Produto		, &
			lvs_Convenio	, &
			lvs_Id_Grupo	, &
			lvs_Manipulado	, &
			lvs_Frete		, &
			lvs_Lista_Pis

Try
	dw_2.SetRedraw(False)
	dw_1.AcceptText()
	
	dc_uo_ds_base lvds_1
	lvds_1 = Create dc_uo_ds_base
	
	dc_uo_ds_base lvds_2
	lvds_2 = Create dc_uo_ds_base
	
	If Not lvds_1.Of_ChangeDataObject("ds_ge301_venda") Then Return
	If Not lvds_2.Of_ChangeDataObject("ds_ge301_devolucao") Then Return
	
	lvl_Produto			= dw_1.Object.cd_produto		[1]
	lvl_Promocao 		= dw_1.Object.cd_promocao		[1]
	lvl_Filial			= dw_1.Object.cd_filial			[1]
	lvl_Convenio		= dw_1.Object.cd_convenio		[1]
	lvs_Id_Grupo   	= dw_1.Object.id_grupo     	[1]
	lvs_Frete			= dw_1.Object.id_frete			[1]
	lvs_Manipulado		= dw_1.Object.id_manipulado	[1]
	
	If (Not IsNull(lvl_Produto))and(lvl_Produto>0) Then
		lvds_1.of_AppendWhere("i.cd_produto = " + String(lvl_Produto))
		lvds_2.of_AppendWhere("i.cd_produto = " + String(lvl_Produto))
	End If
	
	If (Not IsNull(lvl_Filial))and(lvl_Filial>0) Then
		lvds_1.of_AppendWhere("n.cd_filial = " + String(lvl_Filial))
		lvds_2.of_AppendWhere("n.cd_filial = " + String(lvl_Filial))
	End If
	
	If (Not IsNull(lvl_Convenio))and(lvl_Convenio>0) Then
		lvds_1.of_AppendWhere("n.cd_convenio = " + String(lvl_Convenio))
		lvds_2.of_AppendWhere("n.cd_convenio = " + String(lvl_Convenio))
	End If
	
	If (Not IsNull(lvl_Promocao))and(lvl_Promocao>0) Then
		lvds_1.of_AppendWhere("i.cd_produto in (select pp.cd_produto " + &
															"from promocao_sos p " + &
															"Inner Join promocao_sos_produto pp " + &
															" on pp.cd_promocao_sos = p.cd_promocao_sos" + &
															"where p.cd_promocao_sos = " + String(lvl_Promocao) + ")") 
		lvds_2.of_AppendWhere("i.cd_produto in (select pp.cd_produto " + &
															"from promocao_sos p " + &
															"Inner Join promocao_sos_produto pp " + &
															" on pp.cd_promocao_sos = p.cd_promocao_sos" + &
															"where p.cd_promocao_sos = " + String(lvl_Promocao) + ")") 
	End If
	
	If lvs_Id_Grupo <> '0' Then
		lvds_1.of_AppendWhere("substring(g.cd_subcategoria,1,1) = '" + lvs_Id_Grupo + "'")
		lvds_2.of_AppendWhere("substring(g.cd_subcategoria,1,1) = '" + lvs_Id_Grupo + "'")
	End If
	
	If lvs_Frete = 'N' Then
		lvds_1.of_AppendWhere("i.cd_produto <> 712055")
		lvds_2.of_AppendWhere("i.cd_produto <> 712055")
	End If
	
	If lvs_Manipulado = 'N' Then
		lvds_1.of_AppendWhere("i.cd_produto <> 684431")
		lvds_2.of_AppendWhere("i.cd_produto <> 684431")
	End if
	
	Open(w_Aguarde)
	w_Aguarde.Title = 'Recuperando vendas...'
	lvds_1.Retrieve(adt_Inicio, adt_Termino)
	
	w_Aguarde.Title = 'Recuperando devolu$$HEX2$$e700f500$$ENDHEX$$es...'
	lvl_Linhas = lvds_2.Retrieve(adt_Inicio, adt_Termino)
	
	//Seta percentual de atualiza$$HEX2$$e700e300$$ENDHEX$$o da tela, para otimizar performance
	lvl_Qt_Atualiza = IIF(lvl_Linhas > 100000, 1000, Truncate(lvl_Linhas / 100,0))
	lvl_Qt_Atualiza = IIF(lvl_Qt_Atualiza=0, 1, lvl_Qt_Atualiza)
	
	//Deduz as devolu$$HEX2$$e700f500$$ENDHEX$$es
	w_Aguarde.Title = 'Processando devolu$$HEX2$$e700f500$$ENDHEX$$es...'
	w_Aguarde.uo_Progress.Of_SetMax(lvl_Linhas)
	For lvl_Linha = 1 To lvl_Linhas
		lvl_Convenio   		= lvds_2.Object.cd_convenio	  			[lvl_Linha]	
		lvs_Lista_Pis   		= lvds_2.Object.id_situacao_pis_cofins	[lvl_Linha]	
		
		lvl_Find = lvds_1.Find("cd_convenio="+String(lvl_Convenio)+" and id_situacao_pis_cofins='"+lvs_Lista_Pis+"'",1,lvds_1.RowCount())
		
		If Not(lvl_Find > 0) Then
			lvl_Find = lvds_1.InsertRow(0)
			
			lvds_1.Object.cd_convenio	  				[lvl_Find] = lvl_Convenio
			lvds_1.Object.nm_convenio					[lvl_Find] = lvds_2.Object.nm_convenio					[lvl_Linha]	
			lvds_1.Object.vl_venda						[lvl_Find] = 0.00
			lvds_1.Object.qt_vendida					[lvl_Find] = 0.00
			lvds_1.Object.vl_CMV							[lvl_Find] = 0.00
			lvds_1.Object.vl_CMV_Geral					[lvl_Find] = 0.00
			lvds_1.Object.vl_comissao					[lvl_Find] = 0.00
			lvds_1.Object.cd_tributacao_icms			[lvl_Find] = lvds_2.Object.cd_tributacao_icms			[lvl_Linha]
			lvds_1.Object.id_situacao_pis_cofins	[lvl_Find] = lvds_2.Object.id_situacao_pis_cofins		[lvl_Linha]
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
		lvds_1.Object.vl_CMV_Geral		[lvl_Find] = lvdc_CMV_Geral 		- lvds_2.Object.vl_CMV_Geral	[lvl_Linha]
		lvds_1.Object.vl_comissao		[lvl_Find] = lvdc_Comissao			- lvds_2.Object.vl_comissao		[lvl_Linha]
		lvds_1.Object.vl_icms			[lvl_Find] = lvdc_VL_ICMS			- lvds_2.Object.vl_icms			[lvl_Linha]
		lvds_1.Object.vl_pis_cofins	[lvl_Find] = lvdc_VL_PIS_COFINS	- lvds_2.Object.vl_pis_cofins	[lvl_Linha]
			
		If Mod(lvl_Linha, lvl_Qt_Atualiza)=0 Then w_aguarde.uo_Progress.of_SetProgress(lvl_Linha)
	Next
	
	lvl_Linhas = lvds_1.RowCount()
	
	//Seta percentual de atualiza$$HEX2$$e700e300$$ENDHEX$$o da tela, para otimizar performance
	lvl_Qt_Atualiza = IIF(lvl_Linhas > 100000, 1000, Truncate(lvl_Linhas / 100,0))
	lvl_Qt_Atualiza = IIF(lvl_Qt_Atualiza=0, 1, lvl_Qt_Atualiza)
	
	w_Aguarde.Title = 'Processando vendas...'
	w_Aguarde.uo_Progress.Of_SetMax(lvl_Linhas)
	
	For lvl_Linha = 1 To lvl_Linhas
		lvl_Convenio    		= lvds_1.Object.cd_convenio		  		[lvl_Linha]	
		lvs_Convenio  			= lvds_1.Object.nm_convenio				[lvl_Linha]
		lvdc_Venda				= lvds_1.Object.vl_venda					[lvl_Linha]	
		lvl_Qtde					= lvds_1.Object.qt_vendida					[lvl_Linha]	
		lvdc_CMV					= lvds_1.Object.vl_CMV						[lvl_Linha]	
		lvdc_CMV_Geral			= lvds_1.Object.vl_CMV_Geral				[lvl_Linha]	
		lvdc_Comissao			= lvds_1.Object.vl_comissao				[lvl_Linha]		
		lvs_Lista_Pis			= lvds_1.Object.id_situacao_pis_cofins	[lvl_Linha]	
		lvdc_VL_ICMS			= lvds_1.Object.vl_icms						[lvl_Linha]
		lvdc_VL_PIS_COFINS	= lvds_1.Object.vl_pis_cofins				[lvl_Linha]
		lvdc_VL_Impostos		= gf_coalesce(lvdc_VL_ICMS, 0) + gf_coalesce(lvdc_VL_PIS_COFINS, 0)
			
		lvl_Find = dw_2.Find("cd_convenio = " + String(lvl_Convenio), 1, dw_2.RowCount())
			
		If lvl_Find = -1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o produto na DW.")
			Exit
		End If
		
		If lvl_Find = 0 Then
			lvl_Insert = dw_2.InsertRow(0)
			
			dw_2.Object.cd_convenio	[lvl_Insert] = lvl_Convenio
			dw_2.Object.nm_convenio	[lvl_Insert] = lvs_Convenio
			dw_2.Object.qt_vendas	[lvl_Insert] = lvl_Qtde
			dw_2.Object.vl_vendas	[lvl_Insert] = lvdc_Venda
			dw_2.Object.vl_cmv		[lvl_Insert] = lvdc_CMV
			dw_2.Object.vl_comissao	[lvl_Insert] = lvdc_Comissao
			dw_2.Object.vl_impostos	[lvl_Insert] = lvdc_VL_Impostos
		Else
			dw_2.Object.qt_vendas		[lvl_Find] = dw_2.Object.qt_vendas		[lvl_Find] + lvl_Qtde
			dw_2.Object.vl_vendas		[lvl_Find] = dw_2.Object.vl_vendas		[lvl_Find] + lvdc_Venda
			dw_2.Object.vl_cmv			[lvl_Find] = dw_2.Object.vl_cmv			[lvl_Find] + lvdc_CMV
			dw_2.Object.vl_comissao		[lvl_Find] = dw_2.Object.vl_comissao	[lvl_Find] + lvdc_Comissao
			dw_2.Object.vl_impostos		[lvl_Find] = dw_2.Object.vl_impostos	[lvl_Find] + lvdc_VL_Impostos
		End If
		
		If Mod(lvl_Linha, lvl_Qt_Atualiza)=0 Then w_aguarde.uo_Progress.of_SetProgress(lvl_Linha)
	Next
	
Catch (RuntimeError lvo_Erro)
	MessageBox('Erro', lvo_Erro.GetMessage(), StopSign!)
	Return 
	
Finally
	If IsValid(lvds_1) Then Destroy(lvds_1)
	If IsValid(lvds_2) Then Destroy(lvds_2)
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

on w_ge301_relatorio_rentab_convenio.create
int iCurrent
call super::create
this.pb_info=create pb_info
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_info
end on

on w_ge301_relatorio_rentab_convenio.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_info)
end on

event close;call super::close;Destroy(ivo_Filial)
Destroy(ivo_Produto)
Destroy(ivo_Promocao)
Destroy(ivo_convenio)
end event

event ue_postopen;call super::ue_postopen;Date lvdt_Movimentacao

lvdt_Movimentacao = Date(gvo_Parametro.of_DH_Movimentacao())

dw_1.Object.dt_Inicio 	[1] = RelativeDate(lvdt_Movimentacao, -2)
dw_1.Object.dt_Termino	[1] = RelativeDate(lvdt_Movimentacao, -1) 	

This.ivm_Menu.ivb_Permite_Imprimir = True

Post wf_seta_mensagem_informacao()

end event

event ue_preopen;call super::ue_preopen;ivo_convenio	= Create uo_convenio
ivo_Filial  		= Create uo_Filial
ivo_Produto 		= Create uo_Produto
ivo_Promocao 	= Create uo_Promocao

MaxWidth	= 5500
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

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge301_relatorio_rentab_convenio
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge301_relatorio_rentab_convenio
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge301_relatorio_rentab_convenio
integer x = 18
integer y = 364
integer width = 4384
integer height = 1320
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge301_relatorio_rentab_convenio
integer x = 18
integer y = 8
integer width = 4192
integer height = 336
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge301_relatorio_rentab_convenio
integer x = 46
integer y = 72
integer width = 4151
integer height = 248
string dataobject = "dw_ge301_selecao"
end type

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	
	Choose Case This.GetColumnName()
		Case 'nm_fantasia'
			ivo_Filial.of_Localiza_Filial(This.GetText())
			
			If ivo_Filial.Localizada Then
				This.Object.cd_filial		[1]	= ivo_Filial.cd_filial
				This.Object.nm_fantasia	[1] = ivo_Filial.nm_fantasia
			End If
			
		Case 'de_produto'  
			ivo_Produto.of_Localiza_Produto(This.GetText())
			
			If ivo_Produto.Localizado Then
				This.Object.cd_produto	[1] = ivo_Produto.cd_produto
				This.Object.de_produto	[1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
			End If
	
		Case 'nm_promocao' 
			ivo_Promocao.of_Localiza(This.GetText())
			
			If ivo_Promocao.Localizado Then
				This.Object.cd_promocao	[1] = ivo_Promocao.cd_promocao
				This.Object.nm_promocao	[1] = ivo_Promocao.nm_promocao
			End If
			
		Case 'nm_convenio'
			ivo_convenio.of_localiza_convenio(This.GetText())
			
			If ivo_convenio.Localizado Then
				This.Object.cd_convenio	[1] = ivo_convenio.cd_convenio
				This.Object.nm_convenio[1] = ivo_convenio.nm_razao_social
			End If
	End Choose
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
	Case 'nm_convenio'
		If Not IsNull(Data) and Trim(Data) <> '' Then
			If Data <> ivo_convenio.nm_razao_social Then
				Return 1
			End If
		Else
			ivo_convenio.of_Inicializa()
			This.Object.cd_convenio		[1] = ivo_convenio.cd_convenio
			This.Object.nm_convenio	[1] = ivo_convenio.nm_razao_social
		End If
	Case 'nm_promocao'
		If Not IsNull(Data) and Trim(Data) <> '' Then
			If Data <> ivo_Promocao.nm_promocao Then
				Return 1
			End If
		Else
			ivo_Promocao.of_Inicializa()
			
			This.Object.cd_promocao	[1] = ivo_Promocao.cd_promocao
			This.Object.nm_promocao	[1] = ivo_Promocao.nm_promocao
		End If
End Choose
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Filial) Then
	This.Object.Cd_Filial		[1] = ivo_Filial.Cd_Filial
	This.Object.Nm_Fantasia	[1] = ivo_Filial.nm_fantasia
End If

If IsValid(ivo_Produto) Then
	This.Object.cd_produto	[1] = ivo_Produto.cd_produto
	This.Object.de_produto	[1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
End If

If IsValid(ivo_Promocao) Then
	This.Object.cd_promocao	[1] = ivo_Promocao.cd_promocao
	This.Object.nm_promocao	[1] = ivo_Promocao.nm_promocao
End If

If IsValid(ivo_convenio) Then
	This.Object.cd_convenio		[1] = ivo_convenio.cd_convenio
	This.Object.nm_convenio	[1] = ivo_convenio.nm_razao_social
End If

end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge301_relatorio_rentab_convenio
integer x = 50
integer y = 440
integer width = 4302
integer height = 1188
string dataobject = "dw_ge301_lista"
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

wf_Recupera_Informacoes(lvdt_Inicio, lvdt_Termino)

Return This.RowCount()
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_linhas > 0 Then	
	wf_Atualiza_Totais()
	
	This.Sort()
	This.GroupCalc()
End If

This.ivm_Menu.mf_SalvarComo(pl_linhas > 0)
This.SetRedraw(True)

wf_seta_mensagem_informacao()

Return AncestorReturnValue
end event

event dw_2::constructor;call super::constructor;String lvs_Coluna[]
String lvs_Nome[]

lvs_Coluna = {	"cd_convenio"		,&
					"nm_convenio"		, &
					"qt_vendas"			, &
					"vl_vendas"			, &
					"perc_vendas"		, &
					"vl_cmv"				, &
					"perc_cmv"			, &
					"vl_comissao"		, &
					"perc_comissao"	, &
					"vl_impostos"		, &
					"perc_impostos"	, &
					"vl_rentabilidade"	, &
					"perc_rentabilidade"}

lvs_Nome = {	"C$$HEX1$$f300$$ENDHEX$$digo Conv$$HEX1$$ea00$$ENDHEX$$nio"		, &
					"Nome Convenio"		, &
					"Qtde Vendas"			, &
					"Valor Vendas"			, &
					"% Vendas"				, &
					"Valor CMV"				, &
					"% CMV"					, &
					"Valor Comiss$$HEX1$$e300$$ENDHEX$$o"		, &
					"% Comiss$$HEX1$$e300$$ENDHEX$$o"			, &
					"Valor Impostos"		, &
					"% Impostos"			, &
					"Valor Rentabilidade"	, &
					"% Rentabilidade"}

This.of_SetSort(lvs_Coluna, lvs_Nome)
This.of_SetFilter(lvs_Coluna, lvs_Nome)

This.ivb_Ordena_Colunas = True
end event

event dw_2::ue_reset;call super::ue_reset;This.ivm_Menu.mf_SalvarComo(False)
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge301_relatorio_rentab_convenio
integer x = 1376
integer y = 36
integer width = 375
integer height = 116
string dataobject = "dw_ge301_relatorio"
end type

event dw_3::ue_preprint;call super::ue_preprint;Long lvl_Filial,&
	 lvl_Promocao 

String  lvs_Filial,&
		lvs_Promocao

dw_1.AccepTtext()

lvl_Filial 	 = dw_1.Object.cd_filial  [1] 
lvl_Promocao = dw_1.Object.cd_promocao[1] 

If IsNull(lvl_Filial) Then
	lvs_Filial = 'TODAS'
Else
	lvs_Filial = dw_1.Object.nm_fantasia[1] + " (" + String(lvl_Filial) + ")"
End If

If IsNull(lvl_Promocao) Then
	lvs_Promocao = 'NENHUMA'
Else
	lvs_Promocao = dw_1.Object.nm_promocao[1] + " (" + String(lvl_Promocao) + ")"
End If

dw_3.Object.st_Periodo.text  = String(dw_1.Object.dt_inicio[1] , 'dd/mm/yyyy') + " at$$HEX1$$e900$$ENDHEX$$ " + String(dw_1.Object.dt_termino[1] , 'dd/mm/yyyy')
dw_3.Object.st_Filial.text 	 = lvs_Filial
dw_3.Object.st_Promocao.text = lvs_Promocao

Return AncestorReturnValue
end event

event dw_3::ue_saveas;//override
This.Event ue_PrePrint()

SUPER::EVENT ue_SaveAs()
end event

type pb_info from picturebutton within w_ge301_relatorio_rentab_convenio
boolean visible = false
integer x = 4238
integer y = 200
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

