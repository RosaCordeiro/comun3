HA$PBExportHeader$w_ge090_relatorio_venda_grupo_filial.srw
forward
global type w_ge090_relatorio_venda_grupo_filial from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge090_relatorio_venda_grupo_filial from dc_w_selecao_lista_relatorio
integer width = 3653
integer height = 1908
string title = "GE090 - Relat$$HEX1$$f300$$ENDHEX$$rio de Vendas por Grupo e Filial"
long backcolor = 80269524
end type
global w_ge090_relatorio_venda_grupo_filial w_ge090_relatorio_venda_grupo_filial

type variables
uo_filial ivo_filial

end variables

forward prototypes
public subroutine wf_localiza_filial ()
public subroutine wf_procura_venda (date pdt_dt_inicio, date pdt_dt_termino, long pl_filial, long pl_regiao)
public subroutine wf_procura_devolucao (date pdt_dt_inicio, date pdt_dt_termino, long pl_filial, long pl_regiao)
public subroutine wf_insere_padrao ()
end prototypes

public subroutine wf_localiza_filial ();STRING lvs_Filial
//
// Verifica o par$$HEX1$$e200$$ENDHEX$$metro digitado pelo usu$$HEX1$$e100$$ENDHEX$$rio

lvs_Filial = dw_1.GetText()
	
ivo_Filial.of_Localiza_Filial(lvs_Filial)

// Verifica se a Filial foi localizada e atualiza a DW
If ivo_Filial.Localizada Then
	dw_1.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial
  	dw_1.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
Else

	SetNull(ivo_Filial.Cd_Filial)
	ivo_Filial.Nm_Fantasia = ""
	
	dw_1.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial
  	dw_1.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
End If
end subroutine

public subroutine wf_procura_venda (date pdt_dt_inicio, date pdt_dt_termino, long pl_filial, long pl_regiao);dc_uo_ds_base lvds_Vendas

Long lvl_linha , &
	  lvl_row   , &
	  lvl_filial, &
	  lvl_insert

String lvs_grupo

lvds_Vendas = Create dc_uo_ds_base

w_Aguarde.Title = "Localizando Vendas..."
If Not lvds_Vendas.of_ChangeDataObject('ds_ge090_venda_grupo') Then
	Destroy(lvds_Vendas)
	Return
End If

If Not IsNull(pl_filial) Then
	lvds_Vendas.of_AppendWhere("n.cd_filial = " + String(pl_filial) )
End If

If Not IsNull(pl_regiao) and (pl_regiao > 0) Then
	lvds_Vendas.of_AppendWhere("f.cd_regiao = " + String(pl_regiao) )
End If

lvds_Vendas.Retrieve(pdt_dt_inicio, pdt_dt_termino)

lvl_filial = -1
lvl_row = lvds_Vendas.RowCount()

For lvl_linha=1 To lvl_row
	
	If lvl_filial <> lvds_Vendas.Object.cd_filial[lvl_linha] Then
		lvl_filial  = lvds_Vendas.Object.cd_filial[lvl_linha]
		
		lvl_insert  = dw_2.InsertRow(0)
		
		If lvl_insert <= 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao tentar inserir nova linha na dw_2")
			Destroy(lvds_Vendas)
			Return
		End If
		
		dw_2.Object.Cd_filial[lvl_insert] = lvl_filial
		dw_2.Object.Nm_filial[lvl_insert] = lvds_Vendas.Object.Nm_Fantasia[lvl_linha] + &
													  ' (' + String(lvds_Vendas.Object.Cd_Filial[lvl_linha]) + ')'
													  
		dw_2.Object.Id_Rede	   [lvl_Insert] = lvds_Vendas.Object.Id_Rede   [lvl_linha]
		dw_2.Object.Cd_Regiao[lvl_Insert] = lvds_Vendas.Object.Cd_Regiao[lvl_linha]
													  
		dw_2.Object.vl_venda_medi[lvl_insert] = 0
		dw_2.Object.vl_venda_popu[lvl_insert] = 0
		dw_2.Object.vl_venda_perf[lvl_insert] = 0
		dw_2.Object.vl_venda_conv[lvl_insert] = 0
		dw_2.Object.vl_venda_mani[lvl_insert] = 0
		dw_2.Object.vl_venda_serv[lvl_insert] = 0
	End If
	
	lvs_grupo = lvds_Vendas.Object.cd_grupo[lvl_linha]
	
	Choose Case lvs_grupo
		Case '1'
			dw_2.Object.vl_venda_medi[lvl_insert] = lvds_Vendas.Object.Vl_Venda[lvl_linha]
		Case '2'
			dw_2.Object.vl_venda_popu[lvl_insert] = lvds_Vendas.Object.Vl_Venda[lvl_linha]
		Case '3'
			dw_2.Object.vl_venda_perf[lvl_insert] = lvds_Vendas.Object.Vl_Venda[lvl_linha]
		Case '4'
			dw_2.Object.vl_venda_conv[lvl_insert] = lvds_Vendas.Object.Vl_Venda[lvl_linha]
		Case '6'
			dw_2.Object.vl_venda_mani[lvl_insert] = lvds_Vendas.Object.Vl_Venda[lvl_linha]
		Case '7'
			dw_2.Object.vl_venda_serv[lvl_insert] = lvds_Vendas.Object.Vl_Venda[lvl_linha]
		Case Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Foram localizadas vendas para um grupo n$$HEX1$$e300$$ENDHEX$$o previsto. ~n Grupo = " + lvs_grupo)
	End Choose
	
Next

Destroy(lvds_Vendas)
end subroutine

public subroutine wf_procura_devolucao (date pdt_dt_inicio, date pdt_dt_termino, long pl_filial, long pl_regiao);dc_uo_ds_base lvds_Devolucao

Long lvl_linha , &
	  lvl_row   , &
	  lvl_filial, &
	  lvl_achou

String lvs_grupo , &
		 lvs_filial

Decimal lvdc_valor

lvds_Devolucao = Create dc_uo_ds_base

w_Aguarde.Title = "Localizando Devolu$$HEX2$$e700f500$$ENDHEX$$es..."
If Not lvds_Devolucao.of_ChangeDataObject('ds_ge090_devolucao_grupo') Then
	Destroy(lvds_Devolucao)
	Return
End If

If Not IsNull(pl_filial) Then
	lvds_Devolucao.of_AppendWhere("n.cd_filial = " + String(pl_filial) )
End If

If Not IsNull(pl_regiao) and (pl_regiao > 0) Then
	lvds_Devolucao.of_AppendWhere("f.cd_regiao = " + String(pl_regiao) )
End If

lvds_Devolucao.Retrieve(pdt_dt_inicio, pdt_dt_termino)

lvl_filial = -1
lvl_row 	  = lvds_Devolucao.RowCount()

For lvl_linha=1 To lvl_row
	
	If lvl_filial <> lvds_Devolucao.Object.cd_filial[lvl_linha] Then
		lvl_filial  = lvds_Devolucao.Object.cd_filial[lvl_linha]
		lvl_achou   = dw_2.Find("cd_filial = " + String(lvl_filial), 1, dw_2.RowCount() )
		
		If lvl_achou < 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o da filial no DataStore de devolu$$HEX2$$e700e300$$ENDHEX$$o")
			Destroy(lvds_Devolucao)
			Return
		End If
		
		If lvl_achou = 0 Then
			lvl_achou = dw_2.InsertRow(0)
			
			If lvl_achou <= 0 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao tentar inserir nova linha na dw_2")
				Destroy(lvds_Devolucao)
				Return
			End If
			
			lvs_filial = lvds_Devolucao.Object.Nm_Fantasia[lvl_linha]
			dw_2.Object.Cd_filial[lvl_achou] = lvl_filial 
			dw_2.Object.Nm_filial[lvl_achou] = lvs_filial + ' (' + String(lvl_filial) + ')'
			dw_2.Object.Vl_venda_medi[lvl_achou] = 0
			dw_2.Object.Vl_venda_popu[lvl_achou] = 0
			dw_2.Object.Vl_venda_perf[lvl_achou] = 0
			dw_2.Object.Vl_venda_conv[lvl_achou] = 0
			dw_2.Object.Vl_venda_mani[lvl_achou] = 0
			dw_2.Object.Vl_venda_serv[lvl_achou] = 0
		End If
		
	End If
	
	lvs_grupo  = lvds_Devolucao.Object.cd_grupo    [lvl_linha]
	lvdc_valor = lvds_Devolucao.Object.Vl_Devolucao[lvl_linha]
	
	Choose Case lvs_grupo
		Case '1'
			dw_2.Object.vl_venda_medi[lvl_achou] = dw_2.Object.vl_venda_medi[lvl_achou] - lvdc_valor
		Case '2'
			dw_2.Object.Vl_venda_popu[lvl_achou] = dw_2.Object.Vl_venda_popu[lvl_achou] - lvdc_valor
		Case '3'
			dw_2.Object.Vl_venda_perf[lvl_achou] = dw_2.Object.Vl_venda_perf[lvl_achou] - lvdc_valor
		Case '4'
			dw_2.Object.Vl_venda_conv[lvl_achou] = dw_2.Object.Vl_venda_conv[lvl_achou] - lvdc_valor
		Case '6'
			dw_2.Object.Vl_venda_mani[lvl_achou] = dw_2.Object.Vl_venda_mani[lvl_achou] - lvdc_valor
		Case '7'
			dw_2.Object.Vl_venda_serv[lvl_achou] = dw_2.Object.Vl_venda_serv[lvl_achou] - lvdc_valor
	End Choose
	
Next

Destroy(lvds_Devolucao)
end subroutine

public subroutine wf_insere_padrao ();Integer 	lvi_Retorno, &
        		lvi_Linha

Long lvl_Regiao

DataWindowChild lvdwc

lvi_Retorno = dw_1.GetChild("cd_regiao", lvdwc)

If lvi_Retorno = 1 Then
	lvi_Linha = lvdwc.InsertRow(1)
	
	If lvi_Linha > 0 Then
		lvdwc.SetItem(lvi_Linha, "cd_regiao", 0)
		lvdwc.SetItem(lvi_Linha, "de_regiao", "TODAS")
		
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
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na inclus$$HEX1$$e300$$ENDHEX$$o da regi$$HEX1$$e300$$ENDHEX$$o default.", StopSign!)
	End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild da regi$$HEX1$$e300$$ENDHEX$$o.", StopSign!)
End If
end subroutine

on w_ge090_relatorio_venda_grupo_filial.create
call super::create
end on

on w_ge090_relatorio_venda_grupo_filial.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;// Cria o Objeto Filial
ivo_filial = Create uo_filial

dw_1.Object.Dt_Emissao_De [1] = Today()
dw_1.Object.Dt_Emissao_Ate[1] = Today()

This.ivm_Menu.Mf_Recuperar(True)

This.ivm_Menu.ivb_Permite_Imprimir = True

wf_insere_padrao()




end event

event close;call super::close;Destroy(ivo_Filial)
end event

event ue_preopen;call super::ue_preopen;MaxWidth = 5295
MaxHeight = 9999
end event

event ue_saveas;dw_3.Event ue_SaveAs()
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge090_relatorio_venda_grupo_filial
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge090_relatorio_venda_grupo_filial
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge090_relatorio_venda_grupo_filial
integer x = 14
integer y = 252
integer width = 3584
integer height = 1456
integer weight = 700
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge090_relatorio_venda_grupo_filial
integer x = 14
integer y = 0
integer width = 2510
integer height = 236
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge090_relatorio_venda_grupo_filial
integer x = 32
integer y = 60
integer width = 2473
integer height = 164
string dataobject = "dw_ge090_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;String lvs_Coluna[], &
		 lvs_Nome[]
		 
Choose Case dwo.name
	Case "nm_filial"
		If Trim(Data) <> "" Then
			If Data <> ivo_Filial.nm_Fantasia Then
				Return 1
			End If	
		Else			
			SetNull(ivo_Filial.Cd_Filial)
			ivo_Filial.Nm_Fantasia = ""
			
			This.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial
			This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia			
		End If
	Case "id_mensal"
		If (Data) <> "S" Then
			dw_2.Of_changedataobject('dw_ge090_lista_venda_grupo')
			dw_3.Of_changedataobject('dw_ge090_relatorio')
					 
			lvs_Coluna = {"cd_filial"     , &
							  "nm_filial"   , &
							  "cd_regiao", &
							  "id_rede", &
							  "vl_venda_medi" , &
							  "vl_venda_popu" , &
							  "vl_venda_perf" , &
							  "vl_venda_conv" , &
							  "vl_venda_mani" , &
							  "vl_venda_serv" , &
							  "vl_total_grupos" }
						
			lvs_Nome   = {"C$$HEX1$$f300$$ENDHEX$$digo da Filial"		  , &
							  "Nome da Filial"		  , &
							  "Regi$$HEX1$$e300$$ENDHEX$$o", &
							  "Rede", &
							  "Venda de Medicamentos" , &
							  "Venda de Popular"		  , &
							  "Venda de Perfumaria"	  , &
							  "Venda de Conveni$$HEX1$$ea00$$ENDHEX$$ncia" , &
							  "Venda de Manipula$$HEX2$$e700e300$$ENDHEX$$o"  , &
							  "Venda de Servi$$HEX1$$e700$$ENDHEX$$os"	  , &
							  "Venda Total da Filial" }
		Else			
			dw_2.Of_changedataobject('dw_ge090_lista_mensal')
			dw_3.Of_changedataobject('dw_ge090_relatorio_mensal')
			
			lvs_Coluna = {"dt_mes"     , &
							  "cd_filial"     , &
							  "nm_fantasia"   , &
							  "cd_regiao", &
							  "id_rede_filial", &
							  "vl_medicamento" , &
							  "vl_popular" , &
							  "vl_perfumaria" , &
							  "vl_convenio" , &
							  "vl_manipulado" , &
							  "vl_diversos" , &
							  "vl_total_venda" }
						
			lvs_Nome   = {"M$$HEX1$$ea00$$ENDHEX$$s"		  , &
							   "C$$HEX1$$f300$$ENDHEX$$digo da Filial"		  , &
							  "Nome da Filial"		  , &
							  "Regi$$HEX1$$e300$$ENDHEX$$o", &
							  "Rede", &
							  "Venda de Medicamentos" , &
							  "Venda de Popular"		  , &
							  "Venda de Perfumaria"	  , &
							  "Venda de Conveni$$HEX1$$ea00$$ENDHEX$$ncia" , &
							  "Venda de Manipula$$HEX2$$e700e300$$ENDHEX$$o"  , &
							  "Venda de Diversos"	  , &
							  "Venda Total da Filial" }
		End If
		
		dw_2.ShareData(dw_3)
		dw_2.of_SetSort(lvs_Coluna, lvs_Nome)
		dw_2.of_SetFilter(lvs_Coluna, lvs_Nome)
		
		This.ivb_Ordena_Colunas = True
End Choose		
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Filial) Then 
	dw_1.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
End If	
end event

event dw_1::ue_key;call super::ue_key;STRING lvs_Coluna

If Key = KeyEnter! Then
	lvs_Coluna = dw_1.GetColumnName()

	Choose Case lvs_Coluna
		Case "nm_filial"
			wf_Localiza_Filial()
	End Choose
End If

end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge090_relatorio_venda_grupo_filial
integer x = 37
integer y = 316
integer width = 3525
integer height = 1376
string dataobject = "dw_ge090_lista_venda_grupo"
boolean hscrollbar = true
end type

event dw_2::ue_recuperar;//OverRide

Long lvl_linha	, &
	  lvl_Filial		, &
	  lvl_Regiao
	  
Date lvdt_dt_inicio , &
	  lvdt_dt_termino
	  
String lvs_Mensal
	  
dw_2.Reset()
dw_1.AcceptText()

This.SetRedraw(False)

lvl_Filial			= dw_1.Object.cd_filial     		[1]
lvl_Regiao		= dw_1.Object.cd_regiao    		[1]
lvdt_dt_inicio	= dw_1.Object.dt_emissao_de [1]
lvdt_dt_termino	= dw_1.Object.dt_emissao_ate[1]
lvs_Mensal		= dw_1.Object.id_mensal		[1]

If lvs_Mensal = 'N' Then
	Open(w_Aguarde)
	w_Aguarde.Title = "Recuperando informa$$HEX2$$e700f500$$ENDHEX$$es..."	
	
	wf_procura_venda(lvdt_dt_inicio, lvdt_dt_termino, lvl_Filial,lvl_Regiao)
	wf_procura_devolucao(lvdt_dt_inicio, lvdt_dt_termino, lvl_Filial,lvl_Regiao)

	Close(w_Aguarde)
Else
	If Not IsNull(lvl_Filial) and lvl_Filial > 0 Then
		This.of_appendwhere('r.cd_filial = '+String(lvl_Filial))
	End If
	
	If Not IsNull(lvl_Regiao) and (lvl_Regiao > 0) Then
		This.of_appendwhere('f.cd_regiao = '+String(lvl_Regiao))
	End If
	
	lvdt_dt_inicio	= gf_primeiro_dia_mes(lvdt_dt_inicio)
	lvdt_dt_termino	= gf_primeiro_dia_mes(lvdt_dt_termino)
	This.Retrieve(lvdt_dt_inicio,lvdt_dt_termino)
End If

This.SetRedraw(True)

Return This.RowCount()
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;This.ivm_Menu.mf_SalvarComo(pl_linhas > 0)

This.Sort()

Return pl_linhas
end event

event dw_2::ue_reset;call super::ue_reset;This.ivm_Menu.mf_SalvarComo(False)
end event

event dw_2::constructor;call super::constructor;String lvs_Coluna[], &
       lvs_Nome[]
		 
lvs_Coluna = {"cd_filial"     , &
				  "nm_filial"   , &
				  "cd_regiao", &
				  "id_rede", &
				  "vl_venda_medi" , &
				  "vl_venda_popu" , &
  				  "vl_venda_perf" , &
				  "vl_venda_conv" , &
				  "vl_venda_mani" , &
				  "vl_venda_serv" , &
				  "vl_total_grupos" }
			
lvs_Nome   = {"C$$HEX1$$f300$$ENDHEX$$digo da Filial"		  , &
				  "Nome da Filial"		  , &
				  "Regi$$HEX1$$e300$$ENDHEX$$o", &
				  "Rede", &
				  "Venda de Medicamentos" , &
				  "Venda de Popular"		  , &
				  "Venda de Perfumaria"	  , &
				  "Venda de Conveni$$HEX1$$ea00$$ENDHEX$$ncia" , &
				  "Venda de Manipula$$HEX2$$e700e300$$ENDHEX$$o"  , &
				  "Venda de Servi$$HEX1$$e700$$ENDHEX$$os"	  , &
				  "Venda Total da Filial" }
				 
This.of_SetSort(lvs_Coluna, lvs_Nome)
This.of_SetFilter(lvs_Coluna, lvs_Nome)

This.ivb_Ordena_Colunas = True
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge090_relatorio_venda_grupo_filial
integer x = 2642
integer y = 60
integer width = 302
integer height = 108
integer taborder = 50
string dataobject = "dw_ge090_relatorio"
boolean vscrollbar = false
end type

event dw_3::ue_preprint;call super::ue_preprint;String lvs_Mensal

dw_1.AcceptText()
dw_2.AcceptText()

lvs_Mensal		= dw_1.Object.id_mensal		[1]
					
If lvs_Mensal = 'N' Then
	This.Object.periodo.Text =		String(dw_1.Object.dt_emissao_de [1],"dd/mm/yyyy") + " $$HEX1$$e000$$ENDHEX$$ " + &
											String(dw_1.Object.dt_emissao_ate[1],"dd/mm/yyyy")
	This.Object.St_Total_Medicamento.Text	= String(dw_2.Object.Total_Medi	[1], "###,##0.00")
	This.Object.St_Total_Popular.Text			= String(dw_2.Object.Total_Popu	[1], "###,##0.00")
	This.Object.St_Total_Perfumaria.Text	= String(dw_2.Object.Total_Perf	[1], "###,##0.00")
	This.Object.St_Total_Conveniencia.Text	= String(dw_2.Object.Total_Conv	[1], "###,##0.00")
	This.Object.St_Total_Manipulacao.Text	= String(dw_2.Object.Total_Mani	[1], "###,##0.00")
	This.Object.St_Total_Servicos.Text		= String(dw_2.Object.Total_Serv	[1], "###,##0.00")
	
	This.Object.St_Perc_Medicamento.Text	= String(dw_2.Object.Perc_Medi	[1], "#0.00")
	This.Object.St_Perc_Popular.Text			= String(dw_2.Object.Perc_Popu	[1], "#0.00")
	This.Object.St_Perc_Perfumaria.Text		= String(dw_2.Object.Perc_Perf	[1], "#0.00")
	This.Object.St_Perc_Conveniencia.Text	= String(dw_2.Object.Perc_Conv	[1], "#0.00")
	This.Object.St_Perc_Manipulacao.Text	= String(dw_2.Object.Perc_Mani	[1], "#0.00")
	This.Object.St_Perc_Servicos.Text			= String(dw_2.Object.Perc_Serv	[1], "#0.00")
	
	This.Object.St_Total_Geral.Text = String(dw_2.Object.Total_Geral[1], "###,##0.00")
Else
	This.Object.periodo.Text =		String(dw_1.Object.dt_emissao_de [1],"mm/yyyy") + " $$HEX1$$e000$$ENDHEX$$ " + &
											String(dw_1.Object.dt_emissao_ate[1],"mm/yyyy")
End If

Return AncestorReturnValue
end event

