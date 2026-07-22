HA$PBExportHeader$w_ge124_consulta_estoque_base_filial.srw
forward
global type w_ge124_consulta_estoque_base_filial from dc_w_sheet
end type
type tab_1 from tab within w_ge124_consulta_estoque_base_filial
end type
type tabpage_1 from userobject within tab_1
end type
type cb_med_mpe from commandbutton within tabpage_1
end type
type cb_3 from commandbutton within tabpage_1
end type
type gb_1 from groupbox within tabpage_1
end type
type dw_1 from dc_uo_dw_base within tabpage_1
end type
type cb_geracao_planilha from commandbutton within tabpage_1
end type
type cb_1 from commandbutton within tabpage_1
end type
type dw_4 from dc_uo_dw_base within tabpage_1
end type
type dw_5 from dc_uo_dw_base within tabpage_1
end type
type gb_4 from groupbox within tabpage_1
end type
type dw_6 from dc_uo_dw_base within tabpage_1
end type
type tabpage_1 from userobject within tab_1
cb_med_mpe cb_med_mpe
cb_3 cb_3
gb_1 gb_1
dw_1 dw_1
cb_geracao_planilha cb_geracao_planilha
cb_1 cb_1
dw_4 dw_4
dw_5 dw_5
gb_4 gb_4
dw_6 dw_6
end type
type tabpage_2 from userobject within tab_1
end type
type gb_2 from groupbox within tabpage_2
end type
type dw_2 from dc_uo_dw_base within tabpage_2
end type
type tabpage_2 from userobject within tab_1
gb_2 gb_2
dw_2 dw_2
end type
type tabpage_3 from userobject within tab_1
end type
type gb_3 from groupbox within tabpage_3
end type
type dw_3 from dc_uo_dw_base within tabpage_3
end type
type tabpage_3 from userobject within tab_1
gb_3 gb_3
dw_3 dw_3
end type
type tab_1 from tab within w_ge124_consulta_estoque_base_filial
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type
end forward

global type w_ge124_consulta_estoque_base_filial from dc_w_sheet
integer width = 3950
integer height = 1848
string title = "GE124 - Consulta do Estoque das Filiais"
event ue_sort ( )
event ue_filter ( )
tab_1 tab_1
end type
global w_ge124_consulta_estoque_base_filial w_ge124_consulta_estoque_base_filial

type variables
Boolean ivb_selecao_alterada = True
Boolean ivb_Check
Boolean ib_Perfil_Estatistico = False

DateTime idh_Inicio
DateTime idh_Termino

Long ivl_filial_estoque_analitico
end variables

forward prototypes
public function boolean wf_filial_selecionada ()
public function boolean wf_existe_filial_sintetico (long al_filial, ref long al_linha)
protected subroutine wf_estoque_analitico (long al_filial, string as_fantasia, ref dc_uo_ds_base ads_sintetico, string as_tipo_operacao)
public subroutine wf_estoque_analitico_unica_plan (string as_filiais, ref dc_uo_ds_base ads_sintetico, string as_tipo_operacao)
public function boolean wf_periodo_vendas ()
public function boolean wf_venda_filial (long al_filial, ref decimal adc_vendas)
public subroutine wf_verifica_estoque_unica_plan (long al_filial, string as_fantasia, string as_tipo_operacao)
public subroutine wf_verifica_estoque (long al_filial, string as_fantasia, string as_tipo_operacao)
public function boolean wf_carrega_med_mpe ()
end prototypes

event ue_sort;Choose Case Tab_1.SelectedTab
	Case 1 ; Tab_1.TabPage_1.dw_1.Event ue_Sort()
	Case 2 ; Tab_1.TabPage_2.dw_2.Event ue_Sort()
	Case 3 ; Tab_1.TabPage_3.dw_3.Event ue_Sort()
End Choose
end event

event ue_filter;Choose Case Tab_1.SelectedTab
	Case 1 ; Tab_1.TabPage_1.dw_1.Event ue_Filter()
	Case 2 ; Tab_1.TabPage_2.dw_2.Event ue_Filter()
	Case 3 ; Tab_1.TabPage_3.dw_3.Event ue_Filter()
End Choose
end event

public function boolean wf_filial_selecionada ();Long lvl_Find

lvl_Find = Tab_1.TabPage_1.dw_1.Find("id_selecao = 'S'", 1, Tab_1.TabPage_1.dw_1.RowCount())

If lvl_Find > 0 Then
	Return True
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existem filiais selecionadas na lista.", Information!)
	Return False
End If
end function

public function boolean wf_existe_filial_sintetico (long al_filial, ref long al_linha);al_Linha = Tab_1.TabPage_3.dw_3.Find("cd_filial = " + String(al_Filial), 1, Tab_1.TabPage_3.dw_3.RowCount())

If al_Linha > 0 Then
	Return True
Else
	If al_Linha < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar se a filial j$$HEX1$$e100$$ENDHEX$$ existe na planilha de estoque sint$$HEX1$$e900$$ENDHEX$$tico.", StopSign!)
	End If
	
	Return False
End If
end function

protected subroutine wf_estoque_analitico (long al_filial, string as_fantasia, ref dc_uo_ds_base ads_sintetico, string as_tipo_operacao);Long lvl_Total, &
   	  lvl_Contador, &
	  lvl_Estoque_Filial, &
	  lvl_Estoque_Calculado, &
	  lvl_Estoque_Minimo, &
	  lvl_Estoque_Base, & 
	  lvl_Estoque_Anterior, &
	  lvl_Linha, &
	  lvl_Produto, &
	  lvl_Filial,&
      lvl_Estoque_Minimo_Promo,&
      lvl_Estoque_Base_Promo
	  
Decimal lvdc_Custo, &
       	lvdc_Estoque_Filial, &
		  lvdc_Estoque_Calculado, &
		  lvdc_Estoque_Minimo, &
		  lvdc_Estoque_Base, &
		  lvdc_Estoque_Anterior, &
		  lvdc_Falta_Estoque, &
		  lvdc_Excesso_Estoque, &
		  lvdc_Total_Estoque_Filial, &
		  lvdc_Total_Estoque_Anterior, &
		  lvdc_Total_Estoque_Calculado, &
		  lvdc_Total_Estoque_Base, &
		  lvdc_Total_Estoque_Minimo, &
		  lvdc_Venda_Filial, &
		  lvdc_Minimo_A, &
		  lvdc_Minimo_B, &
		  lvdc_Minimo_C, &
		  lvdc_Minimo_D, &
		  lvdc_Minimo_E, &
		  lvdc_Custo_Dia, &
		  lvdc_Demanda_Diaria, &
		  lvdc_Aumento_Base, &
		  lvdc_Reducao_Base, &
		  lvdc_Custo_Filial,&
 		  lvdc_Excesso_Estoque_Promo,&
  		  lvdc_Estoque_Minimo_Promo,&
  		  lvdc_Total_Estoque_Min_Promo
		  
String lvs_Arquivo, &
       	lvs_Classe, &
		ls_Dw

dc_uo_ds_Base lvds
lvds = Create dc_uo_ds_Base

If Not ib_Perfil_Estatistico Then
	ls_Dw = "dw_ge124_estoque_analitico"
Else
	ls_Dw = "dw_ge124_estoque_analitico_estatistico"
End If

If Not lvds.of_ChangeDataObject(ls_Dw) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar a lvds " + ls_Dw + ".", StopSign!)
	Destroy(lvds)
	Return
End If

//If Not Tab_1.TabPage_2.dw_2.of_ChangeDataObject(ls_Dw) Then
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar a dw_2 " + ls_Dw + ".", StopSign!)
//	Return
//End If

w_Aguarde.Title = "Verificando Estoque da Filial '" + String(al_Filial) + "'..."

If al_Filial > 1000 Then
	lvl_Filial = al_Filial - 1000
Else
	lvl_Filial = al_Filial
End If

lvl_Total = lvds.Retrieve(al_Filial, lvl_Filial)

If lvl_Total > 0 Then
	w_Aguarde.uo_Progress.of_SetMax(lvl_Total)
	
	For lvl_Contador = 1 To lvl_Total
		lvl_Produto           			= lvds.Object.Cd_Produto              		[lvl_Contador]
		
		lvl_Estoque_Filial    		= lvds.Object.Qt_Estoque_Filial       		[lvl_Contador]
			If lvl_Estoque_Filial < 0 Then lvl_Estoque_Filial = 0  					//alterado
		lvl_Estoque_Calculado 	= lvds.Object.Qt_Estoque_Calculado    	[lvl_Contador]
			//If isNull(lvl_Estoque_Calculado) Then lvl_Estoque_Calculado = 0  //alterado
			
		lvl_Estoque_Minimo    	= lvds.Object.Qt_Estoque_Minimo_EB      	[lvl_Contador]
			//If isNull(lvl_Estoque_Minimo) Then lvl_Estoque_Calculado =   //alterado
		
		lvl_Estoque_Base      		= lvds.Object.Qt_Estoque_Base         		[lvl_Contador]
			//If isNull(lvl_Estoque_Base) Then lvl_Estoque_Minimo = 0  			//alterado
		
		lvl_Estoque_Anterior  		= lvds.Object.Qt_Estoque_Base_Anterior	[lvl_Contador]
			//If isNull(lvl_Estoque_Anterior) Then lvl_Estoque_Anterior = 0  	//alterado
		
		//pegar o CUSTO_SALDO
		lvdc_Custo_Filial					= lvds.Object.Custo_Saldo					[lvl_Contador]
			If isNull(lvdc_Custo_Filial) Then lvdc_Custo_Filial = 0		
   	
		lvdc_Custo            		= lvds.Object.Vl_Custo_Gerencial      		[lvl_Contador]
		lvs_Classe            			= lvds.Object.Cd_Classe_Reposicao     	[lvl_Contador]
		lvdc_Demanda_Diaria   	= lvds.Object.Qt_Demanda_Diaria       	[lvl_Contador]
			//If IsNull(lvdc_Demanda_Diaria) Then lvdc_Demanda_Diaria = 0 // alterado
		
		If lvl_Estoque_Filial < 0 Then lvl_Estoque_Filial = 0
		
		lvdc_Estoque_Filial    		= Round(lvl_Estoque_Filial    	* lvdc_Custo_Filial, 2)
		lvdc_Estoque_Calculado 	= Round(lvl_Estoque_Calculado * lvdc_Custo, 2)
		lvdc_Estoque_Base      	= Round(lvl_Estoque_Base      	* lvdc_Custo, 2)
		lvdc_Estoque_Anterior  	= Round(lvl_Estoque_Anterior  * lvdc_Custo, 2)

		If lvdc_Estoque_Base > lvdc_Estoque_Anterior Then
			lvdc_Aumento_Base += lvdc_Estoque_Base - lvdc_Estoque_Anterior
		Else
			lvdc_Reducao_Base += lvdc_Estoque_Anterior - lvdc_Estoque_Base
		End If
		
		If lvl_Estoque_Minimo > lvl_Estoque_Calculado Then
			lvdc_Estoque_Minimo = Round((lvl_Estoque_Minimo - lvl_Estoque_Calculado) * lvdc_Custo, 2)			
		Else
			lvdc_Estoque_Minimo = 0
		End If
		
		If lvl_Estoque_Base > lvl_Estoque_Filial Then
			lvdc_Falta_Estoque   += Round((lvl_Estoque_Base - lvl_Estoque_Filial) * lvdc_Custo, 2)
		Else
			lvdc_Excesso_Estoque += Round((lvl_Estoque_Filial - lvl_Estoque_Base) * lvdc_Custo, 2)
		End If
		
		lvl_Estoque_Minimo_Promo =  lvds.Object.Qt_Estoq_Min_Promo     		[lvl_Contador]
		
		If lvl_Estoque_Minimo_Promo > lvl_Estoque_Base  Then
			lvl_Estoque_Base_Promo = lvl_Estoque_Minimo_Promo
			lvdc_Estoque_Minimo_Promo    		= Round(lvl_Estoque_Base_Promo    	* lvdc_Custo_Filial, 2)
		Else
			lvl_Estoque_Base_Promo = lvl_Estoque_Base
			lvdc_Estoque_Minimo_Promo    		= Round(lvl_Estoque_Base_Promo    	* lvdc_Custo_Filial, 2)
		End If
		
		If lvl_Estoque_Filial > lvl_Estoque_Base_Promo  Then
			lvdc_Excesso_Estoque_Promo += Round((lvl_Estoque_Filial - lvl_Estoque_Base_Promo) * lvdc_Custo, 2)
		End If
				
		lvds.Object.Vl_Estoque_Filial   		[lvl_Contador] 	= lvdc_Estoque_Filial
		lvds.Object.Vl_Estoque_Calculado[lvl_Contador] 	= lvdc_Estoque_Calculado
		lvds.Object.Vl_Estoque_Minimo   [lvl_Contador] 	= lvdc_Estoque_Minimo
		lvds.Object.Vl_Estoque_Base     [lvl_Contador] 		= lvdc_Estoque_Base
		lvds.Object.Vl_Estoque_Anterior [lvl_Contador] 	= lvdc_Estoque_Anterior
		lvds.Object.Vl_Estoque_Minimo_Promo[lvl_Contador] = lvdc_Estoque_Minimo_Promo
	    	
		lvdc_Total_Estoque_Filial    += lvdc_Estoque_Filial
		lvdc_Total_Estoque_Calculado += lvdc_Estoque_Calculado
		lvdc_Total_Estoque_Minimo    += lvdc_Estoque_Minimo		
		lvdc_Total_Estoque_Base      += lvdc_Estoque_Base
		lvdc_Total_Estoque_Anterior  += lvdc_Estoque_Anterior
		lvdc_Total_Estoque_Min_Promo += lvdc_Estoque_Minimo_Promo
		
		Choose Case lvs_Classe
			Case "A" ; lvdc_Minimo_A += lvdc_Estoque_Minimo
			Case "B" ; lvdc_Minimo_B += lvdc_Estoque_Minimo
			Case "C" ; lvdc_Minimo_C += lvdc_Estoque_Minimo
			Case "D" ; lvdc_Minimo_D += lvdc_Estoque_Minimo
			Case "E" ; lvdc_Minimo_E += lvdc_Estoque_Minimo
			Case Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Classe '" + lvs_Classe + "' n$$HEX1$$e300$$ENDHEX$$o prevista.", StopSign!)
		End Choose

		w_Aguarde.uo_Progress.of_SetProgress(lvl_Contador)
	Next
	
	/* Verifica qual o tipo de opera$$HEX2$$e700e300$$ENDHEX$$o desejada
	   1: Consulta Estoque Anal$$HEX1$$ed00$$ENDHEX$$tico da Filial Selecionada
		2: Consulta Estoque Sint$$HEX1$$e900$$ENDHEX$$tico das Filiais Selecionadas
		3: Gera$$HEX2$$e700e300$$ENDHEX$$o das Planilhas Anal$$HEX1$$ed00$$ENDHEX$$ticas + Sint$$HEX1$$e900$$ENDHEX$$tica 
	*/
	
	Choose Case as_Tipo_Operacao
		Case "1"
			Tab_1.TabPage_2.dw_2.Reset()
			
			If lvds.RowsCopy(1, lvds.RowCount(), Primary!, Tab_1.TabPage_2.dw_2, 1, Primary!) <> 1 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na c$$HEX1$$f300$$ENDHEX$$pia dos dados para consulta anal$$HEX1$$ed00$$ENDHEX$$tica.", StopSign!)
			Else
				ivl_Filial_Estoque_Analitico = al_Filial
				
				Tab_1.TabPage_2.dw_2.GroupCalc()
				Tab_1.TabPage_2.dw_2.Sort()
			End If
			
		Case Else
			If as_Tipo_Operacao = "3" Then
				lvs_Arquivo = gvo_Aplicacao.of_GetFromIni("Diretorio", "Diretorio")
				
				lvs_Arquivo = lvs_Arquivo + "estoque_base_" + String(al_Filial, "0000") + "_" + &
								  String(Today(), "ddmm") + String(Now(), "hhmm") + ".xls"
				
				If lvds.SaveAs(lvs_Arquivo, Excel!, True) <> 1 Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na gera$$HEX2$$e700e300$$ENDHEX$$o da planilha '" + lvs_Arquivo + "'.", StopSign!)
				End If
			End If
	
			// Atualiza$$HEX2$$e700e300$$ENDHEX$$o da DW sint$$HEX1$$e900$$ENDHEX$$tica
			wf_Venda_Filial(al_Filial, ref lvdc_Venda_Filial)
			
			If lvdc_Venda_Filial = 0 Then lvdc_Venda_Filial = 1
			
			lvdc_Custo_Dia = Round(lvdc_Venda_Filial * 0.59 / 30, 2)			
		
			lvl_Linha = ads_Sintetico.InsertRow(0)
			
			ads_Sintetico.Object.Cd_Filial           			[lvl_Linha] = al_Filial
			ads_Sintetico.Object.Nm_Fantasia         		[lvl_Linha] = as_Fantasia
			ads_Sintetico.Object.Vl_Estoque_Filial   		[lvl_Linha] = lvdc_Total_Estoque_Filial
			ads_Sintetico.Object.Vl_Estoque_Calculado	[lvl_Linha] = lvdc_Total_Estoque_Calculado		
			ads_Sintetico.Object.Vl_Estoque_Minimo   	[lvl_Linha] = lvdc_Total_Estoque_Minimo
			ads_Sintetico.Object.Vl_Estoque_Base     	[lvl_Linha] = lvdc_Total_Estoque_Base			
			ads_Sintetico.Object.Vl_Estoque_Anterior 	[lvl_Linha] = lvdc_Total_Estoque_Anterior			
			ads_Sintetico.Object.Vl_Aumento_Base     	[lvl_Linha] = lvdc_Aumento_Base
			ads_Sintetico.Object.Vl_Reducao_Base     	[lvl_Linha] = lvdc_Reducao_Base						
			ads_Sintetico.Object.Vl_Falta_Estoque    	[lvl_Linha] = lvdc_Falta_Estoque
			ads_Sintetico.Object.Vl_Excesso_Estoque  	[lvl_Linha] = lvdc_Excesso_Estoque 			
			ads_Sintetico.Object.Vl_Venda_Filial     		[lvl_Linha] = lvdc_Venda_Filial
			
			If lvdc_Custo_Dia > 0 Then
				ads_Sintetico.Object.Nr_Dias_Filial		[lvl_Linha] = Round(lvdc_Total_Estoque_Filial / lvdc_Custo_Dia, 2)
				ads_Sintetico.Object.Nr_Dias_Base		[lvl_Linha] = Round(lvdc_Total_Estoque_Base / lvdc_Custo_Dia, 2) 
			Else
				ads_Sintetico.Object.Nr_Dias_Filial		[lvl_Linha] = 0
				ads_Sintetico.Object.Nr_Dias_Base		[lvl_Linha] = 0
			End If			
			
			ads_Sintetico.Object.Vl_Minimo_A         		[lvl_Linha] = lvdc_Minimo_A
			ads_Sintetico.Object.Vl_Minimo_B         		[lvl_Linha] = lvdc_Minimo_B
			ads_Sintetico.Object.Vl_Minimo_C         		[lvl_Linha] = lvdc_Minimo_C
			ads_Sintetico.Object.Vl_Minimo_D         		[lvl_Linha] = lvdc_Minimo_D
			ads_Sintetico.Object.Vl_Minimo_E         		[lvl_Linha] = lvdc_Minimo_E			
 			ads_Sintetico.Object.Vl_Excesso_Promo		[lvl_Linha] = lvdc_Excesso_Estoque_Promo
			ads_Sintetico.Object.Vl_Est_Min_Promo  	[lvl_Linha] = lvdc_Total_Estoque_Min_Promo										
			
	End Choose
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Dados de estoque base da filial '" + String(al_Filial) + "' n$$HEX1$$e300$$ENDHEX$$o foram localizados.", Information!)
End If

w_Aguarde.uo_Progress.of_Reset()

Destroy(lvds)
end subroutine

public subroutine wf_estoque_analitico_unica_plan (string as_filiais, ref dc_uo_ds_base ads_sintetico, string as_tipo_operacao);Long	lvl_Total, &
		lvl_Contador, &
		lvl_Estoque_Filial, &
		lvl_Estoque_Calculado, &
		lvl_Estoque_Minimo, &
		lvl_Estoque_Base, & 
		lvl_Estoque_Anterior, &
		lvl_Linha, &
		lvl_Produto, &
		lvl_Filial,&
		lvl_Estoque_Minimo_Promo,&
		lvl_Estoque_Base_Promo, &
		ll_Filial_Prox, &
		ll_Find, &
		ll_Len		
	  
Decimal	lvdc_Custo, &
			lvdc_Estoque_Filial, &
			lvdc_Estoque_Calculado, &
			lvdc_Estoque_Minimo, &
			lvdc_Estoque_Base, &
			lvdc_Estoque_Anterior, &
			lvdc_Falta_Estoque, &
			lvdc_Excesso_Estoque, &
			lvdc_Total_Estoque_Filial, &
			lvdc_Total_Estoque_Anterior, &
			lvdc_Total_Estoque_Calculado, &
			lvdc_Total_Estoque_Base, &
			lvdc_Total_Estoque_Minimo, &
			lvdc_Venda_Filial, &
			lvdc_Minimo_A, &
			lvdc_Minimo_B, &
			lvdc_Minimo_C, &
			lvdc_Minimo_D, &
			lvdc_Minimo_E, &
			lvdc_Custo_Dia, &
			lvdc_Demanda_Diaria, &
			lvdc_Aumento_Base, &
			lvdc_Reducao_Base, &
			lvdc_Custo_Filial,&
			lvdc_Excesso_Estoque_Promo,&
			lvdc_Estoque_Minimo_Promo,&
			lvdc_Total_Estoque_Min_Promo
		  
String	lvs_Arquivo, &
		lvs_Classe, &
		ls_Dw

dc_uo_ds_Base lvds
lvds = Create dc_uo_ds_Base

If Not ib_Perfil_Estatistico Then
	ls_Dw = "dw_ge124_estoque_analitico_unica_plan"
Else
	ls_Dw = "dw_ge124_estoque_analitico_unica_plan_estatis"
End If

If Not lvds.of_ChangeDataObject(ls_Dw) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar a lvds " + ls_Dw + ".", StopSign!)
	Destroy(lvds)
	Return
End If

w_Aguarde.Title = "Verificando Estoque das Filiais ..."

//If al_Filial > 1000 Then
//	lvl_Filial = al_Filial - 1000
//Else
//	lvl_Filial = al_Filial
//End If

ll_Len = LenA(as_Filiais)
as_Filiais = LeftA(as_Filiais, ll_Len - 1)

lvds.of_AppendWhere("r.cd_filial in (" + as_Filiais + ")")

lvl_Total = lvds.Retrieve()

If lvl_Total > 0 Then
	w_Aguarde.uo_Progress.of_SetMax(lvl_Total)
	
	For lvl_Contador = 1 To lvl_Total
		lvl_Filial = lvds.Object.Cd_Filial[lvl_Contador]
		
		w_Aguarde.Title = "Verificando Estoque da Filial '" + String(lvl_Filial) + "'..."
		
		lvl_Produto           			= lvds.Object.Cd_Produto              		[lvl_Contador]
		
		lvl_Estoque_Filial    		= lvds.Object.Qt_Estoque_Filial       		[lvl_Contador]
			If lvl_Estoque_Filial < 0 Then lvl_Estoque_Filial = 0  					//alterado
		lvl_Estoque_Calculado 	= lvds.Object.Qt_Estoque_Calculado    	[lvl_Contador]
			//If isNull(lvl_Estoque_Calculado) Then lvl_Estoque_Calculado = 0  //alterado
			
		lvl_Estoque_Minimo    	= lvds.Object.Qt_Estoque_Minimo_EB     [lvl_Contador]
			//If isNull(lvl_Estoque_Minimo) Then lvl_Estoque_Calculado =   //alterado
		
		lvl_Estoque_Base      		= lvds.Object.Qt_Estoque_Base         		[lvl_Contador]
			//If isNull(lvl_Estoque_Base) Then lvl_Estoque_Minimo = 0  			//alterado
		
		lvl_Estoque_Anterior  		= lvds.Object.Qt_Estoque_Base_Anterior	[lvl_Contador]
			//If isNull(lvl_Estoque_Anterior) Then lvl_Estoque_Anterior = 0  	//alterado
		
		//pegar o CUSTO_SALDO
		lvdc_Custo_Filial					= lvds.Object.Custo_Saldo			[lvl_Contador]
			If isNull(lvdc_Custo_Filial) Then lvdc_Custo_Filial = 0		
   	
		lvdc_Custo            		= lvds.Object.Vl_Custo_Gerencial      		[lvl_Contador]
		lvs_Classe            			= lvds.Object.Cd_Classe_Reposicao     	[lvl_Contador]
		lvdc_Demanda_Diaria   	= lvds.Object.Qt_Demanda_Diaria       	[lvl_Contador]
			//If IsNull(lvdc_Demanda_Diaria) Then lvdc_Demanda_Diaria = 0 // alterado
		
		If lvl_Estoque_Filial < 0 Then lvl_Estoque_Filial = 0
		
		lvdc_Estoque_Filial    		= Round(lvl_Estoque_Filial    	* lvdc_Custo_Filial, 2)
		lvdc_Estoque_Calculado 	= Round(lvl_Estoque_Calculado * lvdc_Custo, 2)
		lvdc_Estoque_Base      	= Round(lvl_Estoque_Base      	* lvdc_Custo, 2)
		lvdc_Estoque_Anterior  	= Round(lvl_Estoque_Anterior  * lvdc_Custo, 2)

		If lvdc_Estoque_Base > lvdc_Estoque_Anterior Then
			lvdc_Aumento_Base += lvdc_Estoque_Base - lvdc_Estoque_Anterior
		Else
			lvdc_Reducao_Base += lvdc_Estoque_Anterior - lvdc_Estoque_Base
		End If
		
		If lvl_Estoque_Minimo > lvl_Estoque_Calculado Then
			lvdc_Estoque_Minimo = Round((lvl_Estoque_Minimo - lvl_Estoque_Calculado) * lvdc_Custo, 2)			
		Else
			lvdc_Estoque_Minimo = 0
		End If
		
		If lvl_Estoque_Base > lvl_Estoque_Filial Then
			lvdc_Falta_Estoque   += Round((lvl_Estoque_Base - lvl_Estoque_Filial) * lvdc_Custo, 2)
		Else
			lvdc_Excesso_Estoque += Round((lvl_Estoque_Filial - lvl_Estoque_Base) * lvdc_Custo, 2)
		End If
		
		lvl_Estoque_Minimo_Promo =  lvds.Object.Qt_Estoq_Min_Promo     		[lvl_Contador]
		
		If lvl_Estoque_Minimo_Promo > lvl_Estoque_Base  Then
			lvl_Estoque_Base_Promo = lvl_Estoque_Minimo_Promo
			lvdc_Estoque_Minimo_Promo    		= Round(lvl_Estoque_Base_Promo    	* lvdc_Custo_Filial, 2)
		Else
			lvl_Estoque_Base_Promo = lvl_Estoque_Base
			lvdc_Estoque_Minimo_Promo    		= Round(lvl_Estoque_Base_Promo    	* lvdc_Custo_Filial, 2)
		End If
		
		If lvl_Estoque_Filial > lvl_Estoque_Base_Promo  Then
			lvdc_Excesso_Estoque_Promo += Round((lvl_Estoque_Filial - lvl_Estoque_Base_Promo) * lvdc_Custo, 2)
		End If
				
		lvds.Object.Vl_Estoque_Filial   		[lvl_Contador] 	= lvdc_Estoque_Filial
		lvds.Object.Vl_Estoque_Calculado[lvl_Contador] 	= lvdc_Estoque_Calculado
		lvds.Object.Vl_Estoque_Minimo   [lvl_Contador] 	= lvdc_Estoque_Minimo
		lvds.Object.Vl_Estoque_Base     [lvl_Contador] 		= lvdc_Estoque_Base
		lvds.Object.Vl_Estoque_Anterior [lvl_Contador] 	= lvdc_Estoque_Anterior
		lvds.Object.Vl_Estoque_Minimo_Promo[lvl_Contador] = lvdc_Estoque_Minimo_Promo
	    	
		lvdc_Total_Estoque_Filial    += lvdc_Estoque_Filial
		lvdc_Total_Estoque_Calculado += lvdc_Estoque_Calculado
		lvdc_Total_Estoque_Minimo    += lvdc_Estoque_Minimo		
		lvdc_Total_Estoque_Base      += lvdc_Estoque_Base
		lvdc_Total_Estoque_Anterior  += lvdc_Estoque_Anterior
		lvdc_Total_Estoque_Min_Promo += lvdc_Estoque_Minimo_Promo
		
		Choose Case lvs_Classe
			Case "A" ; lvdc_Minimo_A += lvdc_Estoque_Minimo
			Case "B" ; lvdc_Minimo_B += lvdc_Estoque_Minimo
			Case "C" ; lvdc_Minimo_C += lvdc_Estoque_Minimo
			Case "D" ; lvdc_Minimo_D += lvdc_Estoque_Minimo
			Case "E" ; lvdc_Minimo_E += lvdc_Estoque_Minimo
			Case Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Classe '" + lvs_Classe + "' n$$HEX1$$e300$$ENDHEX$$o prevista.", StopSign!)
		End Choose
		
		If lvl_Contador < lvds.RowCount() Then
			ll_Filial_Prox = lvds.Object.Cd_Filial[lvl_Contador + 1]
		End If
		
		//Monta o relat$$HEX1$$f300$$ENDHEX$$rio sint$$HEX1$$e900$$ENDHEX$$tico
		If (ll_Filial_Prox <> lvl_Filial) Or (lvl_Contador = lvds.RowCount()) Then
			wf_Venda_Filial(lvl_Filial, Ref lvdc_Venda_Filial)
	
			If lvdc_Venda_Filial = 0 Then lvdc_Venda_Filial = 1
			
			lvdc_Custo_Dia = Round(lvdc_Venda_Filial * 0.59 / 30, 2)
		
			lvl_Linha = ads_Sintetico.InsertRow(0)
			
			ads_Sintetico.Object.Cd_Filial           			[lvl_Linha] = lvl_Filial
			ads_Sintetico.Object.Vl_Estoque_Filial   		[lvl_Linha] = lvdc_Total_Estoque_Filial
			ads_Sintetico.Object.Vl_Estoque_Calculado	[lvl_Linha] = lvdc_Total_Estoque_Calculado
			ads_Sintetico.Object.Vl_Estoque_Minimo   	[lvl_Linha] = lvdc_Total_Estoque_Minimo
			ads_Sintetico.Object.Vl_Estoque_Base     	[lvl_Linha] = lvdc_Total_Estoque_Base
			ads_Sintetico.Object.Vl_Estoque_Anterior 	[lvl_Linha] = lvdc_Total_Estoque_Anterior
			ads_Sintetico.Object.Vl_Aumento_Base     	[lvl_Linha] = lvdc_Aumento_Base
			ads_Sintetico.Object.Vl_Reducao_Base     	[lvl_Linha] = lvdc_Reducao_Base
			ads_Sintetico.Object.Vl_Falta_Estoque    	[lvl_Linha] = lvdc_Falta_Estoque
			ads_Sintetico.Object.Vl_Excesso_Estoque  	[lvl_Linha] = lvdc_Excesso_Estoque
			ads_Sintetico.Object.Vl_Venda_Filial     		[lvl_Linha] = lvdc_Venda_Filial
			
			If lvdc_Custo_Dia > 0 Then
				ads_Sintetico.Object.Nr_Dias_Filial		[lvl_Linha] = Round(lvdc_Total_Estoque_Filial / lvdc_Custo_Dia, 2)
				ads_Sintetico.Object.Nr_Dias_Base		[lvl_Linha] = Round(lvdc_Total_Estoque_Base  / lvdc_Custo_Dia, 2)
			Else
				ads_Sintetico.Object.Nr_Dias_Filial		[lvl_Linha] = 0
				ads_Sintetico.Object.Nr_Dias_Base		[lvl_Linha] = 0
			End If
			
			ads_Sintetico.Object.Vl_Minimo_A         		[lvl_Linha] = lvdc_Minimo_A
			ads_Sintetico.Object.Vl_Minimo_B         		[lvl_Linha] = lvdc_Minimo_B
			ads_Sintetico.Object.Vl_Minimo_C         		[lvl_Linha] = lvdc_Minimo_C
			ads_Sintetico.Object.Vl_Minimo_D         		[lvl_Linha] = lvdc_Minimo_D
			ads_Sintetico.Object.Vl_Minimo_E         		[lvl_Linha] = lvdc_Minimo_E
			ads_Sintetico.Object.Vl_Excesso_Promo  	[lvl_Linha] = lvdc_Excesso_Estoque_Promo
			ads_Sintetico.Object.Vl_Est_Min_Promo  	[lvl_Linha] = lvdc_Total_Estoque_Min_Promo
							
			//Procura a filial na dw_1, se encontrar captura o nome fantasia
			ll_Find = Tab_1.TabPage_1.dw_1.Find("cd_filial = " + String(lvl_Filial) + " and id_selecao = 'S'", 1, Tab_1.TabPage_1.dw_1.RowCount())
			
			If ll_Find < 0 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Find da dw_1.", StopSign!)
				Return
			End If
			
			If ll_Find > 0 Then
				ads_Sintetico.Object.Nm_Fantasia[lvl_Linha] = Tab_1.TabPage_1.dw_1.Object.Nm_Fantasia[ll_Find]
			End If
			
			lvdc_Total_Estoque_Filial				= 0.00
			lvdc_Total_Estoque_Calculado		= 0.00
			lvdc_Total_Estoque_Minimo			= 0.00
			lvdc_Total_Estoque_Base			= 0.00
			lvdc_Total_Estoque_Anterior		= 0.00
			lvdc_Total_Estoque_Min_Promo	= 0.00
			lvdc_Aumento_Base					= 0.00
			lvdc_Reducao_Base					= 0.00
			lvdc_Falta_Estoque 					= 0.00
			lvdc_Excesso_Estoque				= 0.00
			lvdc_Excesso_Estoque_Promo		= 0.00
			
			lvdc_Minimo_A	= 0.00
			lvdc_Minimo_B	= 0.00
			lvdc_Minimo_C	= 0.00
			lvdc_Minimo_D	= 0.00
			lvdc_Minimo_E	= 0.00
		End If

		w_Aguarde.uo_Progress.of_SetProgress(lvl_Contador)
	Next
	
	/* Verifica qual o tipo de opera$$HEX2$$e700e300$$ENDHEX$$o desejada
	   1: Consulta Estoque Anal$$HEX1$$ed00$$ENDHEX$$tico da Filial Selecionada
		2: Consulta Estoque Sint$$HEX1$$e900$$ENDHEX$$tico das Filiais Selecionadas
		3: Gera$$HEX2$$e700e300$$ENDHEX$$o das Planilhas Anal$$HEX1$$ed00$$ENDHEX$$ticas + Sint$$HEX1$$e900$$ENDHEX$$tica 	*/

	If as_Tipo_Operacao = "3" Then
		lvs_Arquivo = gvo_Aplicacao.of_GetFromIni("Diretorio", "Diretorio")
		
		If lvds.RowCount() <= 63000 Then
			
			lvs_Arquivo = lvs_Arquivo + "\estoque_base_" + "unica_planilha" + "_" + String(Today(), "ddmm") + String(Now(), "hhmm") + ".xls"
			
			If lvds.SaveAs(lvs_Arquivo, Excel!, True) <> 1 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na gera$$HEX2$$e700e300$$ENDHEX$$o da planilha '" + lvs_Arquivo + "'.", StopSign!)
			End If
			
		Else
			
			lvs_Arquivo = lvs_Arquivo + "\estoque_base_" + "unica_planilha" + "_" + String(Today(), "ddmm") + String(Now(), "hhmm") + ".txt"
			
			If lvds.SaveAs(lvs_Arquivo, Text!, True) <> 1 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na gera$$HEX2$$e700e300$$ENDHEX$$o da planilha '" + lvs_Arquivo + "'.", StopSign!)
			End If
		End If
	End If
	
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Dados de estoque base das filiais selecionadas n$$HEX1$$e300$$ENDHEX$$o foram localizados.", Information!)
End If

w_Aguarde.uo_Progress.of_Reset()

Destroy(lvds)
end subroutine

public function boolean wf_periodo_vendas ();Boolean lvb_Sucesso
  
Select convert(datetime, substring(convert(char(8), dateadd(month, -1, dh_movimentacao), 112), 1, 6) + '01'),
		 dateadd(day, -1, dateadd(month, 1, convert(datetime, substring(convert(char(8), dateadd(month, -1, dh_movimentacao), 112), 1, 6) + '01')))
Into :idh_Inicio, 
     :idh_Termino
From parametro
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		lvb_Sucesso = True
		
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Per$$HEX1$$ed00$$ENDHEX$$odo de vendas n$$HEX1$$e300$$ENDHEX$$o localizado.")
		
	Case -1
		SqlCa.of_MsgdbError("Determina$$HEX2$$e700e300$$ENDHEX$$o do Per$$HEX1$$ed00$$ENDHEX$$odo de Vendas")
End Choose

Return lvb_Sucesso
end function

public function boolean wf_venda_filial (long al_filial, ref decimal adc_vendas);Boolean lvb_Sucesso = True

Decimal lvdc_Venda, &
        lvdc_Devolucao
		  
Integer lvi_Dias
		  
//If Not wf_Periodo_Vendas(ref lvdh_Inicio, ref lvdh_Termino) Then Return False

Select sum(vl_venda_avista         + 
           vl_venda_cartao_debito  + 
			  vl_venda_cheque_avista  +
           vl_venda_crediario      + 
			  vl_venda_convenio       + 
			  vl_venda_conta_corrente + 
			  vl_venda_cartao_credito + 
			  vl_venda_cheque_aprazo),
       sum(vl_devolucao_venda)
Into :lvdc_Venda,
	  :lvdc_Devolucao
From resumo_movimento_estoque
Where cd_filial = :al_Filial
  and dh_resumo Between :idh_Inicio and :idh_Termino
Using SqlCa;			

Choose Case SqlCa.SqlCode
	Case 0
		If IsNull(lvdc_Venda)     Then lvdc_Venda     = 0
		If IsNull(lvdc_Devolucao) Then lvdc_Devolucao = 0
		
		adc_Vendas = lvdc_Venda - lvdc_Devolucao
		
		lvi_Dias = Day(Date(idh_Termino))
		
		adc_Vendas = Round(adc_Vendas / lvi_Dias * 30, 2)
		
	Case 100
		adc_Vendas = 0
		
	Case -1
		SqlCa.of_MsgdbError("Verifica$$HEX2$$e700e300$$ENDHEX$$o das Vendas da Filial")
		lvb_Sucesso = False
End Choose

Return lvb_Sucesso
end function

public subroutine wf_verifica_estoque_unica_plan (long al_filial, string as_fantasia, string as_tipo_operacao);Long lvl_Total, &
     lvl_Contador, &
	  lvl_Filial, &
	  lvl_Linha
	  
String lvs_Selecao, &
		 lvs_Caminho, &
		 lvs_Arquivo, &
		 ls_Filiais

dc_uo_ds_Base lvds
lvds = Create dc_uo_ds_Base

If Not lvds.of_ChangeDataObject("dw_ge124_estoque_sintetico") Then
	Destroy(lvds)
	Return
End If

SetPointer(HourGlass!)
Open(w_Aguarde)

/* Verifica qual o tipo de opera$$HEX2$$e700e300$$ENDHEX$$o desejada
	1: Consulta Estoque Anal$$HEX1$$ed00$$ENDHEX$$tico da Filial Selecionada
	2: Consulta Estoque Sint$$HEX1$$e900$$ENDHEX$$tico das Filiais Selecionadas
	3: Gera$$HEX2$$e700e300$$ENDHEX$$o das Planilhas Anal$$HEX1$$ed00$$ENDHEX$$ticas + Sint$$HEX1$$e900$$ENDHEX$$tica */

If al_Filial > 0 Then
	wf_Estoque_Analitico(al_Filial, as_Fantasia, lvds, "1")
Else
	lvl_Total = Tab_1.TabPage_1.dw_1.RowCount()
	
	For lvl_Contador = 1 To lvl_Total
		lvl_Filial   = Tab_1.TabPage_1.dw_1.Object.Cd_Filial  [lvl_Contador]
		lvs_Selecao  = Tab_1.TabPage_1.dw_1.Object.Id_Selecao [lvl_Contador]
				
		If lvs_Selecao = "S" Then
			ls_Filiais += String(lvl_Filial) + ","
		End If
	Next

	If ls_Filiais <> "" Then		
		wf_Estoque_Analitico_Unica_Plan(ls_Filiais, lvds, as_Tipo_Operacao)
	End If

	If as_Tipo_Operacao = "2" Then
		Tab_1.TabPage_3.dw_3.Reset()
		
		If lvds.RowsCopy(1, lvds.RowCount(), Primary!, Tab_1.TabPage_3.dw_3, 1, Primary!) <> 1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na c$$HEX1$$f300$$ENDHEX$$pia dos dados para consulta sint$$HEX1$$e900$$ENDHEX$$tica.", StopSign!)
		Else
			Tab_1.TabPage_3.dw_3.GroupCalc()
			Tab_1.TabPage_3.dw_3.Sort()
		End If
	ElseIf as_Tipo_Operacao = "3" Then
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "As planilhas anal$$HEX1$$ed00$$ENDHEX$$ticas foram geradas com sucesso.~r" + &
										 "Deseja gerar a planilha sint$$HEX1$$e900$$ENDHEX$$tica das filiais selecionadas ?", Question!, YesNo!, 1) = 1 Then 
			
			lvs_Caminho = gvo_Aplicacao.of_GetFromIni("Diretorio", "Diretorio")
			
			lvs_Arquivo = lvs_Caminho + "estoque_base_sintetico_" + String(Today(), "ddmm") + String(Now(), "hhmm") + ".xls"
										 
			If lvds.SaveAs(lvs_Arquivo, Excel!, True) = 1 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A planilha '" + lvs_Arquivo + "' foi gerada com sucesso.", Information!)
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na gera$$HEX2$$e700e300$$ENDHEX$$o da planilha '" + lvs_Arquivo + "'.", StopSign!)
			End If
		End If
	End If
End If

Destroy(lvds)
Close(w_Aguarde)
SetPointer(Arrow!)
end subroutine

public subroutine wf_verifica_estoque (long al_filial, string as_fantasia, string as_tipo_operacao);Long	lvl_Total, &
     	lvl_Contador, &
		lvl_Filial, &
		lvl_Linha
                  
String	lvs_Fantasia, &
       	lvs_Selecao, &
		lvs_Caminho, &
		lvs_Arquivo

dc_uo_ds_Base lvds
lvds = Create dc_uo_ds_Base

If Not lvds.of_ChangeDataObject("dw_ge124_estoque_sintetico") Then
	Destroy(lvds)
	Return
End If

SetPointer(HourGlass!)
Open(w_Aguarde)

/* Verifica qual o tipo de opera$$HEX2$$e700e300$$ENDHEX$$o desejada
	1: Consulta Estoque Anal$$HEX1$$ed00$$ENDHEX$$tico da Filial Selecionada
	2: Consulta Estoque Sint$$HEX1$$e900$$ENDHEX$$tico das Filiais Selecionadas
	3: Gera$$HEX2$$e700e300$$ENDHEX$$o das Planilhas Anal$$HEX1$$ed00$$ENDHEX$$ticas + Sint$$HEX1$$e900$$ENDHEX$$tica 
*/

If al_Filial > 0 Then
	wf_Estoque_Analitico(al_Filial, as_Fantasia, lvds, "1")
Else
	lvl_Total = Tab_1.TabPage_1.dw_1.RowCount()
                
	For lvl_Contador = 1 To lvl_Total
		 lvl_Filial   = Tab_1.TabPage_1.dw_1.Object.Cd_Filial  [lvl_Contador]
		 lvs_Fantasia = Tab_1.TabPage_1.dw_1.Object.Nm_Fantasia[lvl_Contador]
		 lvs_Selecao  = Tab_1.TabPage_1.dw_1.Object.Id_Selecao [lvl_Contador]
		 
		If lvs_Selecao = "S" Then
			wf_Estoque_Analitico(lvl_Filial, lvs_Fantasia, lvds, as_Tipo_Operacao)
		End If
	Next

	If as_Tipo_Operacao = "2" Then
		Tab_1.TabPage_3.dw_3.Reset()
				 
		If lvds.RowsCopy(1, lvds.RowCount(), Primary!, Tab_1.TabPage_3.dw_3, 1, Primary!) <> 1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na c$$HEX1$$f300$$ENDHEX$$pia dos dados para consulta sint$$HEX1$$e900$$ENDHEX$$tica.", StopSign!)
		Else
			Tab_1.TabPage_3.dw_3.GroupCalc()
			Tab_1.TabPage_3.dw_3.Sort()
		End If
		 
	ElseIf as_Tipo_Operacao = "3" Then
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "As planilhas anal$$HEX1$$ed00$$ENDHEX$$ticas foram geradas com sucesso.~r" + &
										"Deseja gerar a planilha sint$$HEX1$$e900$$ENDHEX$$tica das filiais selecionadas ?", Question!, YesNo!, 1) = 1 Then 
		
			lvs_Caminho = gvo_Aplicacao.of_GetFromIni("Diretorio", "Diretorio")
			
			lvs_Arquivo = lvs_Caminho + "\estoque_base_sintetico_" + String(Today(), "ddmm") + String(Now(), "hhmm") + ".xls"
																															  
			If lvds.SaveAs(lvs_Arquivo, Excel!, True) = 1 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A planilha '" + lvs_Arquivo + "' foi gerada com sucesso.", Information!)
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na gera$$HEX2$$e700e300$$ENDHEX$$o da planilha '" + lvs_Arquivo + "'.", StopSign!)
			End If
		End If
	End If
End If

Destroy(lvds)
Close(w_Aguarde)
SetPointer(Arrow!)
end subroutine

public function boolean wf_carrega_med_mpe ();Long ll_Linha
Long ll_Find
Long ll_Filial
Long ll_Linhas

Try
	Tab_1.TabPage_1.dw_1.AcceptText()
	
	dc_uo_ds_base lds
	lds = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject("ds_ge124_media_mpe") Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar a ds 'ds_ge124_media_mpe'.", StopSign!)
		Return False
	End If
	
	Open(w_Aguarde)
	w_Aguarde.Title = "Carregando M$$HEX1$$e900$$ENDHEX$$dia MPE. Aguarde..."
	
	If lds.Retrieve() < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no retrieve da ds 'ds_ge124_media_mpe'.", StopSign!)
		Return False
	End If
	
	ll_Linhas = Tab_1.TabPage_1.dw_1.RowCount()
	
	w_aguarde.uo_progress.of_setmax(ll_Linhas)
	
	For ll_Linha = 1 To ll_Linhas
		ll_Filial = Tab_1.TabPage_1.dw_1.Object.Cd_Filial[ll_Linha]
			
		ll_Find = lds.Find("cd_filial = " + String(ll_Filial), 1, lds.RowCount())
		
		If ll_Find < 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Find da ds 'ds_ge124_media_mpe'.", StopSign!)
			Return False
		End If
		
		If ll_Find > 0 Then
			Tab_1.TabPage_1.dw_1.Object.Med_Mpe[ll_Linha] = lds.Object.Med_Mpe[ll_Find]
		End If
		
		w_Aguarde.Title = "Filial: " + String(ll_Linha) + " at$$HEX1$$e900$$ENDHEX$$ " + String(ll_Linhas)
		w_aguarde.uo_progress.of_setprogress(ll_Linha)
	Next

	Return True
	
Finally
	If IsValid(lds) Then Destroy(lds)
	Close(w_Aguarde)
End Try
end function

on w_ge124_consulta_estoque_base_filial.create
int iCurrent
call super::create
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
end on

on w_ge124_consulta_estoque_base_filial.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_1)
end on

event ue_postopen;call super::ue_postopen;String ls_Dw

If Not ib_Perfil_Estatistico Then
	ls_Dw = "dw_ge124_estoque_analitico"
	
	Tab_1.TabPage_1.dw_1.Object.Med_Mpe.Visible = 0
	Tab_1.TabPage_1.dw_1.Object.Med_Mpe_t.Visible = 0
	Tab_1.TabPage_1.dw_1.Object.Med_Mpe_l.Visible = 0
	
	Tab_1.TabPage_1.cb_Med_Mpe.Visible = False
Else
	ls_Dw = "dw_ge124_estoque_analitico_estatistico"
End If

If Not Tab_1.TabPage_2.dw_2.of_ChangeDataObject(ls_Dw) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar a dw_2 " + ls_Dw + ".", StopSign!)
	Return
End If

Tab_1.TabPage_1.dw_1.Event ue_Retrieve()
Tab_1.TabPage_1.dw_1.SetFocus()

If Not wf_Periodo_Vendas() Then Return
end event

event open;call super::open;Tab_1.TabPage_1.dw_1.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_2.dw_2.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_3.dw_3.of_SetMenu(This.ivm_Menu)

ivb_permite_fechar = false
end event

event ue_preopen;call super::ue_preopen;//Se for perfil estat$$HEX1$$ed00$$ENDHEX$$stico do Compras (J$$HEX1$$e900$$ENDHEX$$ssica) o sistema utiliza as dw's de estat$$HEX1$$ed00$$ENDHEX$$stica, que possui a informa$$HEX2$$e700e300$$ENDHEX$$o de estat$$HEX1$$ed00$$ENDHEX$$stica
If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = "CO" Then
	If gvo_Aplicacao.ivo_Seguranca.Cd_Perfil_Usuario = 39 Then
		ib_Perfil_Estatistico = True
	End If
End If
end event

type dw_visual from dc_w_sheet`dw_visual within w_ge124_consulta_estoque_base_filial
end type

type gb_aux_visual from dc_w_sheet`gb_aux_visual within w_ge124_consulta_estoque_base_filial
end type

type tab_1 from tab within w_ge124_consulta_estoque_base_filial
event ue_filter ( )
event ue_sort ( )
integer x = 5
integer y = 4
integer width = 3872
integer height = 1636
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long backcolor = 67108864
boolean raggedright = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
end on

event selectionchanging;Long lvl_Linha, &
     lvl_Total, &
     lvl_Contador, &
	  lvl_Filial
	  
String lvs_Fantasia, &
       lvs_Caminho, &
		 lvs_Selecao, &
		 lvs_Arquivo

Choose Case NewIndex
	Case 2
		lvl_Linha = Tab_1.TabPage_1.dw_1.GetRow()
		
		If lvl_Linha > 0 Then
			lvl_Filial		= Tab_1.TabPage_1.dw_1.Object.Cd_Filial  [lvl_Linha]
			lvs_Fantasia	= Tab_1.TabPage_1.dw_1.Object.Nm_Fantasia[lvl_Linha]
			
			// Verifica se a filial selecionada $$HEX1$$e900$$ENDHEX$$ diferente da $$HEX1$$fa00$$ENDHEX$$ltima
			If lvl_Filial <> ivl_Filial_Estoque_Analitico Then
				If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma consulta do estoque anal$$HEX1$$ed00$$ENDHEX$$tico da filial '" + lvs_Fantasia + " (" + String(lvl_Filial) + ")' ?", Question!, YesNo!, 2) = 1 Then 
					wf_Verifica_Estoque(lvl_Filial, lvs_Fantasia, "1")
				Else
					Return 1
				End If	
			End If
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma filial na lista para consultar o estoque anal$$HEX1$$ed00$$ENDHEX$$tico.", Information!)
		End If
		
	Case 3
		If Not ivb_Selecao_Alterada Then Return 0
		
		If Not wf_Filial_Selecionada() Then Return 1
		
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma consulta do estoque sint$$HEX1$$e900$$ENDHEX$$tico das filiais selecionadas ?", Question!, YesNo!, 2) = 2 Then 
			Return 1
		End If
		
		wf_Verifica_Estoque(0, "", "2")
		
		ivb_Selecao_Alterada = False
End Choose
end event

event selectionchanged;Choose Case NewIndex
	Case 1
		ivm_Menu.mf_Classificar(True)
		ivm_Menu.mf_Filtrar(False)
		ivm_Menu.mf_SalvarComo(True)
		
		Tab_1.TabPage_1.dw_1.SetFocus()
	Case 2
		ivm_Menu.mf_Classificar(False)
		ivm_Menu.mf_Filtrar(True)
		ivm_Menu.mf_SalvarComo(True)
		
		Tab_1.TabPage_2.dw_2.SetFocus()
		Tab_1.TabPage_2.dw_2.of_SetRowSelection()
	Case 3
		ivm_Menu.mf_Classificar(True)
		ivm_Menu.mf_Filtrar(True)
		ivm_Menu.mf_SalvarComo(True)
		
		Tab_1.TabPage_3.dw_3.SetFocus()
End Choose
end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3835
integer height = 1520
long backcolor = 79741120
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
cb_med_mpe cb_med_mpe
cb_3 cb_3
gb_1 gb_1
dw_1 dw_1
cb_geracao_planilha cb_geracao_planilha
cb_1 cb_1
dw_4 dw_4
dw_5 dw_5
gb_4 gb_4
dw_6 dw_6
end type

on tabpage_1.create
this.cb_med_mpe=create cb_med_mpe
this.cb_3=create cb_3
this.gb_1=create gb_1
this.dw_1=create dw_1
this.cb_geracao_planilha=create cb_geracao_planilha
this.cb_1=create cb_1
this.dw_4=create dw_4
this.dw_5=create dw_5
this.gb_4=create gb_4
this.dw_6=create dw_6
this.Control[]={this.cb_med_mpe,&
this.cb_3,&
this.gb_1,&
this.dw_1,&
this.cb_geracao_planilha,&
this.cb_1,&
this.dw_4,&
this.dw_5,&
this.gb_4,&
this.dw_6}
end on

on tabpage_1.destroy
destroy(this.cb_med_mpe)
destroy(this.cb_3)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.cb_geracao_planilha)
destroy(this.cb_1)
destroy(this.dw_4)
destroy(this.dw_5)
destroy(this.gb_4)
destroy(this.dw_6)
end on

type cb_med_mpe from commandbutton within tabpage_1
integer x = 2638
integer y = 516
integer width = 599
integer height = 104
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Carregar M$$HEX1$$e900$$ENDHEX$$dia MPE"
end type

event clicked;If ib_Perfil_Estatistico Then
	If Not wf_Carrega_Med_Mpe() Then Return -1
End If
end event

type cb_3 from commandbutton within tabpage_1
integer x = 2638
integer y = 1396
integer width = 599
integer height = 100
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Gerar $$HEX1$$da00$$ENDHEX$$nica Planilha"
end type

event clicked;If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a gera$$HEX2$$e700e300$$ENDHEX$$o da planilha $$HEX1$$fa00$$ENDHEX$$nica das filiais selecionadas ?", Question!, YesNo!, 2) = 1 Then 
	If wf_Filial_Selecionada() Then
		wf_Verifica_Estoque_Unica_Plan(0, "", "3")
	End If
End If
end event

type gb_1 from groupbox within tabpage_1
integer x = 14
integer y = 8
integer width = 2574
integer height = 1484
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista de Filiais"
borderstyle borderstyle = styleraised!
end type

type dw_1 from dc_uo_dw_base within tabpage_1
integer x = 41
integer y = 56
integer width = 2514
integer height = 1400
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge124_lista_filial"
boolean vscrollbar = true
end type

event constructor;call super::constructor;String lvs_Coluna[], &
       lvs_Nome[]
		 
lvs_Coluna = {"cd_filial", "nm_fantasia", "dh_termino_calculo", "dh_proximo_calculo"}

lvs_Nome = {"C$$HEX1$$f300$$ENDHEX$$digo", "Nome de Fantasia", "$$HEX1$$da00$$ENDHEX$$ltimo C$$HEX1$$e100$$ENDHEX$$lculo", "Pr$$HEX1$$f300$$ENDHEX$$ximo C$$HEX1$$e100$$ENDHEX$$lculo"}

This.of_SetSort(lvs_Coluna, lvs_Nome)

This.of_SetRowSelection()

This.ivb_Ordena_Colunas = True
end event

event rowfocuschanged;call super::rowfocuschanged;Long lvl_Filial

If CurrentRow > 0 Then
	SetPointer(HourGlass!)
	
	lvl_Filial = This.Object.Cd_Filial[CurrentRow]
	
	dw_4.Visible = False
	dw_5.Visible = False
	dw_6.Visible = False
	
	//gb_4.Visible =  False
	//gb_5.Visible =  False
	//gb_7.Visible =  False
	
//	If This.Object.id_novo_calculo[CurrentRow] = 'SIM' Then
		dw_6.Visible = True
		//gb_7.Visible =  True
		dw_6.Retrieve(lvl_Filial)
//	Else
//		
//		dw_4.Visible = True
//		dw_5.Visible = True
//		
//		//gb_4.Visible =  True
//		//gb_5.Visible =  True
//		
//		dw_4.Retrieve(lvl_Filial)
//		dw_5.Retrieve(lvl_Filial)
//	End If

	SetPointer(Arrow!)
End If
end event

event itemchanged;call super::itemchanged;ivb_Selecao_Alterada = True
end event

event getfocus;call super::getfocus;If This.FilteredCount() > 0 Then
	ivm_Menu.m_Editar.m_LimparFiltro.Enabled = True
Else
	ivm_Menu.m_Editar.m_LimparFiltro.Enabled = False
End If
end event

event ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	Tab_1.TabPage_1.dw_1.ivo_Controle_Menu.of_SalvarComo(True)
Else
	Tab_1.TabPage_1.dw_1.ivo_Controle_Menu.of_SalvarComo(False)
End If

Return pl_Linhas
end event

event doubleclicked;call super::doubleclicked;dw_1.AcceptText()

If dwo.Name = 'p_1' Then
	
	Long lvl_Row
	
	String lvs_Marcacao
	
	If ivb_Check Then
		lvs_Marcacao = 'N'
		ivb_Check = False
	Else
		lvs_Marcacao = 'S'
		ivb_Check = True
	End If
	
	For lvl_Row = 1 To This.RowCount()				
		This.Object.Id_Selecao[lvl_Row] = lvs_Marcacao		
	Next
	
	ivb_Selecao_Alterada = True
End If
end event

type cb_geracao_planilha from commandbutton within tabpage_1
integer x = 3314
integer y = 1396
integer width = 485
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Gerar &Planilhas"
end type

event clicked;If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma gera$$HEX2$$e700e300$$ENDHEX$$o das planilhas anal$$HEX1$$ed00$$ENDHEX$$ticas das filiais selecionadas ?", Question!, YesNo!, 2) = 1 Then 
	If wf_Filial_Selecionada() Then
		wf_Verifica_Estoque(0, "", "3")
	End If
End If
end event

type cb_1 from commandbutton within tabpage_1
boolean visible = false
integer x = 2098
integer y = 448
integer width = 421
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Nenhuma Filial"
end type

event clicked;Long lvl_Contador

String lvs_Selecao

If This.Text = "&Nenhuma Filial" Then
	This.Text = "&Todas Filiais"
	lvs_Selecao = "N"	
Else
	This.Text = "&Nenhuma Filial"
	lvs_Selecao = "S"
End If

dw_1.AcceptText()

For lvl_Contador = 1 To dw_1.RowCount()
	dw_1.Object.Id_Selecao[lvl_Contador] = lvs_Selecao
Next

ivb_Selecao_Alterada = True
end event

type dw_4 from dc_uo_dw_base within tabpage_1
boolean visible = false
integer x = 905
integer y = 664
integer width = 1294
integer height = 692
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge124_detalhe_estavel"
end type

type dw_5 from dc_uo_dw_base within tabpage_1
boolean visible = false
integer x = 160
integer y = 668
integer width = 1225
integer height = 680
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_ge124_detalhe_sazonal"
end type

type gb_4 from groupbox within tabpage_1
integer x = 2629
integer y = 8
integer width = 1166
integer height = 444
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Per$$HEX1$$ed00$$ENDHEX$$odos C$$HEX1$$e100$$ENDHEX$$lculo"
borderstyle borderstyle = styleraised!
end type

type dw_6 from dc_uo_dw_base within tabpage_1
integer x = 2656
integer y = 68
integer width = 1125
integer height = 364
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_ge124_detalhe_novo_calc"
end type

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3835
integer height = 1520
long backcolor = 79741120
string text = "Estoque Anal$$HEX1$$ed00$$ENDHEX$$tico"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
gb_2 gb_2
dw_2 dw_2
end type

on tabpage_2.create
this.gb_2=create gb_2
this.dw_2=create dw_2
this.Control[]={this.gb_2,&
this.dw_2}
end on

on tabpage_2.destroy
destroy(this.gb_2)
destroy(this.dw_2)
end on

type gb_2 from groupbox within tabpage_2
integer x = 14
integer width = 3790
integer height = 1492
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

type dw_2 from dc_uo_dw_base within tabpage_2
integer x = 32
integer y = 40
integer width = 3744
integer height = 1436
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge124_estoque_analitico_estatistico"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event constructor;call super::constructor;String lvs_Coluna[], &
       lvs_Nome[]
		 
lvs_Coluna = {"cd_produto"}

lvs_Nome = {"C$$HEX1$$f300$$ENDHEX$$digo"}

//This.of_SetSort(lvs_Coluna, lvs_Nome)

This.of_SetFilter(lvs_Coluna, lvs_Nome)

This.of_SetRowSelection()
end event

event getfocus;call super::getfocus;If This.FilteredCount() > 0 Then
	ivm_Menu.m_Editar.m_LimparFiltro.Enabled = True
Else
	ivm_Menu.m_Editar.m_LimparFiltro.Enabled = False
End If

end event

event doubleclicked;call super::doubleclicked;Long ll_Filial
Long ll_Produto

String ls_Parametro

If this.RowCount() > 0 Then 
	
	This.AcceptText()
	
	ll_Produto 	= this.Object.cd_produto		[ this.GetRow() ]
	ll_Filial		= this.Object.cd_filial			[ this.GetRow() ]
	
	ls_Parametro = String( ll_Filial, '0000') + String( ll_Produto )
	
	OpenWithParm(w_ge168_historico_alteracao, ls_Parametro)
	
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Selecione uma filial para visualizar o hist$$HEX1$$f300$$ENDHEX$$rico das~raltera$$HEX2$$e700f500$$ENDHEX$$es do estoque base.")
	Return
End If
end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3835
integer height = 1520
long backcolor = 79741120
string text = "Estoque Sint$$HEX1$$e900$$ENDHEX$$tico"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
gb_3 gb_3
dw_3 dw_3
end type

on tabpage_3.create
this.gb_3=create gb_3
this.dw_3=create dw_3
this.Control[]={this.gb_3,&
this.dw_3}
end on

on tabpage_3.destroy
destroy(this.gb_3)
destroy(this.dw_3)
end on

type gb_3 from groupbox within tabpage_3
integer x = 14
integer width = 3767
integer height = 1496
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

type dw_3 from dc_uo_dw_base within tabpage_3
integer x = 37
integer y = 48
integer width = 3703
integer height = 1412
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge124_estoque_sintetico"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event constructor;call super::constructor;String lvs_Coluna[], &
       lvs_Nome[]
		 
lvs_Coluna = {"cd_filial", "nm_fantasia"}

lvs_Nome = {"C$$HEX1$$f300$$ENDHEX$$digo", "Nome de Fantasia"}

This.of_SetSort(lvs_Coluna, lvs_Nome)

This.of_SetFilter(lvs_Coluna, lvs_Nome)

This.of_SetRowSelection()
end event

event getfocus;call super::getfocus;If This.FilteredCount() > 0 Then
	ivm_Menu.m_Editar.m_LimparFiltro.Enabled = True
Else
	ivm_Menu.m_Editar.m_LimparFiltro.Enabled = False
End If

end event

