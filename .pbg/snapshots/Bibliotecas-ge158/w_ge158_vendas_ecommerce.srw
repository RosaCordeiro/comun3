HA$PBExportHeader$w_ge158_vendas_ecommerce.srw
forward
global type w_ge158_vendas_ecommerce from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge158_vendas_ecommerce from dc_w_selecao_lista_relatorio
integer width = 3511
integer height = 1800
string title = "GE158 - Resumo de Vendas do e-Commerce"
long backcolor = 80269524
end type
global w_ge158_vendas_ecommerce w_ge158_vendas_ecommerce

type variables
Date ivdt_inicio, ivdt_termino

Long il_Filial_Ecommerce
end variables

forward prototypes
public subroutine wf_atualiza_informacoes ()
public function boolean wf_localiza_dados (datastore ads_dados, long al_filial, integer ai_pagamento, ref decimal adc_venda)
end prototypes

public subroutine wf_atualiza_informacoes ();Boolean lvb_Sucesso

Decimal lvdc_Venda
		
Long	lvl_Linha	
Long	lvl_Linhas	
Long	lvl_Filial		
Long	lvl_Find
Long	lvl_Pagamento
	
dc_uo_ds_base lvds

lvds = Create dc_uo_ds_base

If Not lvds.of_ChangeDataObject("ds_ge158_vendas") Then
	Destroy(lvds)
	Return	
End If

dc_uo_ds_base lvds_devolucao

lvds_devolucao = Create dc_uo_ds_base

If Not lvds_devolucao.of_ChangeDataObject("ds_ge158_devolucao") Then
	Destroy(lvds_devolucao)
	Destroy(lvds)
	Return	
End If

lvds_devolucao.Retrieve(ivdt_inicio, ivdt_termino, il_Filial_Ecommerce)
lvds.Retrieve(ivdt_inicio, ivdt_termino, il_Filial_Ecommerce)

If lvds_devolucao.RowCount() > 0 Then
	For lvl_Linha = 1 To lvds_devolucao.RowCount()
		lvl_Filial			= lvds_devolucao.Object.cd_filial 			[lvl_Linha]
		lvl_Pagamento = lvds_devolucao.Object.id_pagamento	[lvl_Linha]
		
		lvl_Find = lvds.Find("cd_filial="+String(lvl_Filial)+" and id_pagamento="+String(lvl_Pagamento),1,lvds.RowCount())
		If Not(lvl_Find > 0) Then
			lvl_Find = lvds.InsertRow(0)
			lvds.Object.cd_filial 			[lvl_Find] = lvds_devolucao.Object.cd_filial 			[lvl_Linha]
			lvds.Object.id_pagamento	[lvl_Find] = lvds_devolucao.Object.id_pagamento	[lvl_Linha]
			lvds.Object.vl_total			[lvl_Find] = 0.00
		End If
		
		lvdc_Venda = lvds.Object.vl_total [lvl_Find]
		lvds.Object.vl_total [lvl_Find] = lvdc_Venda - lvds_devolucao.Object.vl_total [lvl_Linha]
	Next
End If

If lvds.RowCount() > 0 Then
	
	lvl_Linhas = dw_2.RowCount()

	For lvl_Linha = 1 To lvl_Linhas
		
		lvl_Filial = dw_2.Object.cd_filial[lvl_Linha]
		
		lvb_Sucesso = False
		
		// Boleto
		If wf_Localiza_Dados(lvds, lvl_Filial, 3, Ref lvdc_Venda) Then
			dw_2.Object.vl_boleto			[lvl_Linha] = lvdc_Venda 
			
			// VISA
			If wf_Localiza_Dados(lvds, lvl_Filial, 6, Ref lvdc_Venda) Then
				dw_2.Object.vl_visa[lvl_Linha] = lvdc_Venda 
								
				// MASTER
				If wf_Localiza_Dados(lvds, lvl_Filial, 7, Ref lvdc_Venda) Then
					dw_2.Object.vl_master_card[lvl_Linha] = lvdc_Venda 
					
					// MASTER / Hipercard
					If wf_Localiza_Dados(lvds, lvl_Filial, 24, Ref lvdc_Venda) Then
						dw_2.Object.vl_master_card[lvl_Linha] = dw_2.Object.vl_master_card[lvl_Linha] + lvdc_Venda 
					
						// DINNERS
						If wf_Localiza_Dados(lvds, lvl_Filial, 8, Ref lvdc_Venda) Then
							dw_2.Object.vl_dinners[lvl_Linha] = lvdc_Venda 
						
							// TRANSFER$$HEX1$$ca00$$ENDHEX$$NCIA ELETR$$HEX1$$d400$$ENDHEX$$NICA BRADESCO
							If wf_Localiza_Dados(lvds, lvl_Filial, 12, Ref lvdc_Venda) Then
								dw_2.Object.vl_transf_eletr[lvl_Linha] = lvdc_Venda 
							
								// TRANSFER$$HEX1$$ca00$$ENDHEX$$NCIA ELETR$$HEX1$$d400$$ENDHEX$$NICA ITAU
								If wf_Localiza_Dados(lvds, lvl_Filial, 19, Ref lvdc_Venda) Then
									dw_2.Object.vl_transf_eletr[lvl_Linha] = dw_2.Object.vl_transf_eletr[lvl_Linha] + lvdc_Venda 
								
									lvb_Sucesso = True
								End If			
							End If
						End If
					End If
				End If
			End If
		End If
		
		If Not lvb_Sucesso Then
			Exit
		End If
		
	Next
	
	dw_2.Sort()
	dw_2.GroupCalc()
	
End If

Destroy(lvds)
Destroy(lvds_devolucao)

end subroutine

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

on w_ge158_vendas_ecommerce.create
call super::create
end on

on w_ge158_vendas_ecommerce.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;dw_1.Object.dt_Inicio [1] = DateTime(gf_Primeiro_Dia_Mes(Date(gvo_Parametro.of_DH_Movimentacao())))

If Day(Date(gvo_Parametro.of_DH_Movimentacao())) = 1 Then
	dw_1.Object.dt_Termino [1] = gvo_Parametro.of_DH_Movimentacao()
Else
	dw_1.Object.dt_Termino[1] = DateTime(RelativeDate(Date(gvo_Parametro.of_DH_Movimentacao()), -1) )	
End If

This.ivm_Menu.ivb_Permite_Imprimir = True

// exclui o item TODAS
DataWindowChild ldw_Child
dw_1.GetChild("cd_filial_ecommerce", ldw_Child)
ldw_Child.deleterow( 1 ) 




end event

event ue_saveas;dw_3.Event ue_SaveAs()
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge158_vendas_ecommerce
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge158_vendas_ecommerce
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge158_vendas_ecommerce
integer x = 23
integer y = 284
integer width = 3419
integer height = 1296
integer weight = 700
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge158_vendas_ecommerce
integer x = 23
integer y = 8
integer width = 1243
integer height = 268
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge158_vendas_ecommerce
integer x = 41
integer y = 76
integer width = 1202
integer height = 172
string dataobject = "dw_ge158_selecao"
end type

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge158_vendas_ecommerce
integer x = 37
integer y = 344
integer width = 3387
integer height = 1204
string dataobject = "dw_ge158_lista"
boolean ivb_ordena_colunas = true
end type

event dw_2::constructor;call super::constructor;This.ivb_Ordena_Colunas = True


end event

event dw_2::ue_recuperar;dw_1.AcceptText()

ivdt_Inicio				= dw_1.Object.dt_inicio					[1]
ivdt_Termino			= dw_1.Object.dt_termino				[1]
il_Filial_Ecommerce 	= dw_1.Object.cd_filial_ecommerce 	[1]

If Isnull(ivdt_Inicio) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio corretamente.")
	dw_1.SetFocus()
	dw_1.Event ue_Pos(1, "dt_inicio")
	Return -1 
End If

If Isnull(ivdt_Termino) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a tada de t$$HEX1$$e900$$ENDHEX$$rmino corretamente.")
	dw_1.SetFocus()
	dw_1.Event ue_Pos(1, "dt_termino")
	Return -1
End If

dw_2.Reset()

Return This.Retrieve( ivdt_Inicio, ivdt_Termino, il_Filial_Ecommerce )
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;This.ivm_Menu.mf_SalvarComo( pl_Linhas > 0)
This.ivm_Menu.mf_Imprimir( pl_Linhas > 0)

If pl_Linhas > 0 Then	
	wf_Atualiza_Informacoes()
End If

Return pl_Linhas


end event

event dw_2::ue_reset;call super::ue_reset;This.ivm_Menu.mf_SalvarComo(False)
This.ivm_Menu.mf_Imprimir(False)
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge158_vendas_ecommerce
integer x = 2432
integer y = 44
integer height = 144
string dataobject = "dw_ge158_lista_relatorio"
end type

event dw_3::ue_preprint;call super::ue_preprint;this.Object.t_periodo.Text = string(dw_1.Object.dt_inicio[1],"dd/mm/yyyy")+&
                             ' $$HEX1$$e000$$ENDHEX$$ '+string(dw_1.Object.dt_termino[1],"dd/mm/yyyy")
									  
This.Object.t_rede.Text = dw_1.Describe("Evaluate('LookUpDisplay(cd_filial_ecommerce)', 1)")

return 1
end event

