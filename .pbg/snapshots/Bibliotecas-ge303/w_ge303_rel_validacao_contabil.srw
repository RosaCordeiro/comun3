HA$PBExportHeader$w_ge303_rel_validacao_contabil.srw
forward
global type w_ge303_rel_validacao_contabil from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge303_rel_validacao_contabil from dc_w_selecao_lista_relatorio
integer width = 4146
integer height = 2088
string title = "GE303 - Consulta Confer$$HEX1$$ea00$$ENDHEX$$ncia Cont$$HEX1$$e100$$ENDHEX$$bil"
boolean maxbox = true
end type
global w_ge303_rel_validacao_contabil w_ge303_rel_validacao_contabil

type variables
uo_Filial		ivo_Filial
end variables

forward prototypes
public function boolean wf_insere_pagamentos (date pdt_inicio, date pdt_termino)
public function boolean wf_insere_filiais ()
public function boolean wf_insere_devolucoes (date pdt_inicio, date pdt_termino, long pl_convenio)
public function boolean wf_insere_pagamentos_conta_credito (date pdt_inicio, date pdt_termino)
public function boolean wf_insere_pagamentos_conta_debito (date pdt_inicio, date pdt_termino)
public function boolean wf_insere_vendaspbm (date pdt_inicio, date pdt_termino, long pl_convenio)
public function boolean wf_insere_estorno_caixas (date pdt_inicio, date pdt_termino)
public function boolean wf_insere_vendas1112 (date pdt_inicio, date pdt_termino)
public function boolean wf_insere_vendas_diversas (date pdt_inicio, date pdt_termino)
end prototypes

public function boolean wf_insere_pagamentos (date pdt_inicio, date pdt_termino);Long 	lvl_Total, &
		lvl_Cont, &
		lvl_Cd_Filial, &
		lvl_Linha_dw2, &
		lvl_Cd_Filial_dw1

String 	lvs_Nm_Fantasia, &
			lvs_Tipo, &
			lvs_Conta_Contabil
			
Decimal 	lvdc_Vl_Pago, &
			lvdc_Vl_CV

dw_1.AcceptText()

lvl_Cd_Filial_dw1 = dw_1.Object.Cd_Filial[1]

dc_uo_ds_base ds_1
ds_1 = Create dc_uo_ds_base

ds_1.DataObject = "ds_ge303_pagamentos_cv_cc_cr"
ds_1.SetTransObject(SQLCA)

If lvl_Cd_Filial_dw1 > 0 Then
	ds_1.of_AppendWhere("m.cd_filial_movimento = " + String(lvl_Cd_Filial_dw1), 1)
	ds_1.of_AppendWhere("m.cd_filial_movimento = " + String(lvl_Cd_Filial_dw1), 2)
	ds_1.of_AppendWhere("m.cd_filial_movimento = " + String(lvl_Cd_Filial_dw1), 3)
	ds_1.of_AppendWhere("m.cd_filial_movimento = " + String(lvl_Cd_Filial_dw1), 4)
End If

lvl_Total = ds_1.Retrieve(pdt_Inicio, pdt_Termino)

If lvl_Total > 0 Then
	Open(w_Aguarde)
	w_Aguarde.Title = "Atualizando Dados de Pagamentos do Per$$HEX1$$ed00$$ENDHEX$$odo..."
	w_Aguarde.uo_Progress.of_SetMax(lvl_Total)
End If

For lvl_Cont  = 1 To lvl_Total
	
	w_Aguarde.uo_Progress.of_SetProgress(lvl_Cont)
	
	lvdc_Vl_CV 		= 0.00
	lvdc_Vl_Pago 	= 0.00
	
	lvl_Cd_Filial				= ds_1.Object.Cd_Filial				[lvl_Cont]
	lvs_Nm_Fantasia		= ds_1.Object.Nm_Fantasia			[lvl_Cont]
	lvs_Tipo					= ds_1.Object.Tipo					[lvl_Cont]
	lvs_Conta_Contabil	= ds_1.Object.cd_conta_contabil	[lvl_Cont]
	lvdc_Vl_Pago			= ds_1.Object.Vl_Pago				[lvl_Cont]
	
	lvl_Linha_dw2 = dw_2.Find("cd_filial = " + String(lvl_Cd_Filial), 1, dw_2.RowCount())
	
	If lvl_Linha_dw2 = 0 Then
		lvl_Linha_dw2 = dw_2.InsertRow(0)

		dw_2.Object.Cd_Filial		[lvl_Linha_dw2] = lvl_Cd_Filial
		dw_2.Object.Nm_Filial	[lvl_Linha_dw2] = lvs_Nm_Fantasia
	End If

	Choose Case lvs_Tipo
		Case 'CV'
			Choose Case lvs_Conta_Contabil
				Case '1266'
					lvdc_Vl_CV = dw_2.Object.Vl_Pagto_CV1266[lvl_Linha_dw2]
					If IsNull(lvdc_Vl_CV) Then lvdc_Vl_CV = 0.00
						
					dw_2.Object.Vl_Pagto_CV1266[lvl_Linha_dw2] = lvdc_Vl_CV + lvdc_Vl_Pago
				Case '1267'
					lvdc_Vl_CV = dw_2.Object.Vl_Pagto_CV1267[lvl_Linha_dw2]
					If IsNull(lvdc_Vl_CV) Then lvdc_Vl_CV = 0.00
						
					dw_2.Object.Vl_Pagto_CV1267[lvl_Linha_dw2] = lvdc_Vl_CV + lvdc_Vl_Pago
				Case '1268'
					lvdc_Vl_CV = dw_2.Object.Vl_Pagto_CV1268[lvl_Linha_dw2]
					If IsNull(lvdc_Vl_CV) Then lvdc_Vl_CV = 0.00
						
					dw_2.Object.Vl_Pagto_CV1268[lvl_Linha_dw2] = lvdc_Vl_CV + lvdc_Vl_Pago
				Case '1269'
					lvdc_Vl_CV = dw_2.Object.Vl_Pagto_CV1269[lvl_Linha_dw2]
					If IsNull(lvdc_Vl_CV) Then lvdc_Vl_CV = 0.00
					
					dw_2.Object.Vl_Pagto_CV1269[lvl_Linha_dw2] = lvdc_Vl_CV + lvdc_Vl_Pago
				Case '1270'
					lvdc_Vl_CV = dw_2.Object.Vl_Pagto_CV1270[lvl_Linha_dw2]
					If IsNull(lvdc_Vl_CV) Then lvdc_Vl_CV = 0.00

					dw_2.Object.Vl_Pagto_CV1270[lvl_Linha_dw2] = lvdc_Vl_CV + lvdc_Vl_Pago
				Case Else
					lvdc_Vl_CV = dw_2.Object.Vl_Pagto_CV1112[lvl_Linha_dw2]
					If IsNull(lvdc_Vl_CV) Then lvdc_Vl_CV = 0.00

					dw_2.Object.Vl_Pagto_CV1112[lvl_Linha_dw2] = lvdc_Vl_CV + lvdc_Vl_Pago
			End Choose
		Case 'CC'
			Choose Case lvs_Conta_Contabil
				Case '1112'
					lvdc_Vl_CV = dw_2.Object.Vl_Pagto_CV1266[lvl_Linha_dw2]
					If IsNull(lvdc_Vl_CV) Then lvdc_Vl_CV = 0.00
				
					dw_2.Object.Vl_Pagto_CC[lvl_Linha_dw2] = lvdc_Vl_CV + lvdc_Vl_Pago
				Case '1192'
					lvdc_Vl_CV = dw_2.Object.Vl_Pagto_CV1266[lvl_Linha_dw2]
					If IsNull(lvdc_Vl_CV) Then lvdc_Vl_CV = 0.00
				
					dw_2.Object.Vl_Pagto_Patrimonio[lvl_Linha_dw2] = lvdc_Vl_CV + lvdc_Vl_Pago
			End Choose
			
		Case 'CR'			
			Choose Case lvs_Conta_Contabil
				Case '1112'
					lvdc_Vl_CV = dw_2.Object.Vl_Pagto_CV1266[lvl_Linha_dw2]
					If IsNull(lvdc_Vl_CV) Then lvdc_Vl_CV = 0.00
				
					dw_2.Object.Vl_Pagto_CR[lvl_Linha_dw2] = lvdc_Vl_CV + lvdc_Vl_Pago
				Case '1192'
					lvdc_Vl_CV = dw_2.Object.Vl_Pagto_CV1266[lvl_Linha_dw2]
					If IsNull(lvdc_Vl_CV) Then lvdc_Vl_CV = 0.00
				
					dw_2.Object.Vl_Pagto_Patrimonio[lvl_Linha_dw2] = lvdc_Vl_CV + lvdc_Vl_Pago
			End Choose
	End Choose
Next

Destroy(ds_1)

If lvl_Total > 0 Then
	Close(w_Aguarde)
End If

Return True
end function

public function boolean wf_insere_filiais ();Long 	lvl_Total, &
		lvl_Cont, &
		lvl_Cd_Filial, &
		lvl_Linha_dw2, &
		lvl_Cd_Filial_dw1

String 	lvs_Nm_Fantasia

dw_1.AcceptText()

lvl_Cd_Filial_dw1 = dw_1.Object.Cd_Filial[1]

dc_uo_ds_base ds_1
ds_1 = Create dc_uo_ds_base

ds_1.DataObject = "ds_ge303_filiais"
ds_1.SetTransObject(SQLCA)

If lvl_Cd_Filial_dw1 > 0 Then
	ds_1.Of_AppendWhere("f.cd_filial = " + String(lvl_Cd_Filial_dw1))
End If

lvl_Total = ds_1.Retrieve()

If lvl_Total > 0 Then
	Open(w_Aguarde)
	w_Aguarde.Title = "Atualizando Filiais..."
	w_Aguarde.uo_Progress.of_SetMax(lvl_Total)
End If

For lvl_Cont  = 1 To lvl_Total
	
	w_Aguarde.uo_Progress.of_SetProgress(lvl_Cont)
	
	lvl_Cd_Filial			= ds_1.Object.Cd_Filial		[lvl_Cont]
	lvs_Nm_Fantasia	= ds_1.Object.Nm_Fantasia	[lvl_Cont]
	
	lvl_Linha_dw2 = dw_2.Find("cd_filial = " + String(lvl_Cd_Filial), 1, dw_2.RowCount())
	
	If lvl_Linha_dw2 = 0 Then
		lvl_Linha_dw2 = dw_2.InsertRow(0)
	End If

	dw_2.Object.Cd_Filial		[lvl_Linha_dw2] = lvl_Cd_Filial
	dw_2.Object.Nm_Filial	[lvl_Linha_dw2] = lvs_Nm_Fantasia	
Next

Destroy(ds_1)

If lvl_Total > 0 Then
	Close(w_Aguarde)
End If

Return True
end function

public function boolean wf_insere_devolucoes (date pdt_inicio, date pdt_termino, long pl_convenio);Long 	lvl_Total, &
		lvl_Cont, &
		lvl_Cd_Filial, &
		lvl_Linha_dw2, &
		lvl_Cd_Filial_dw1, &
		lvl_Nr_Nf_Venda, &
		lvl_Filial_Venda

String 	lvs_Nm_Fantasia, &
			lvs_Especie_Venda, &
			lvs_Serie_Venda, &
			lvs_Cd_Conveniado, &
			lvs_Nr_Comprovante

Decimal	lvdc_Vl_Total_VidaLink_Diversos, &
			lvdc_Vl_Total_VidaLink_FarPop, &
			lvdc_Vl_Total_VidaLink_Copel, &
			lvdc_Vl_Total_Funcional, &
			lvdc_Vl_Total_Outros, &
			lvdc_Vl_Pago_Avista, &
			lvdc_Vl_Total_Pago_Avista, &
			lvdc_Vl_Total_EPharma, &
			lvdc_Vl_Total_Nf, &
			lvdc_Vl_Total_Geral, &
			lvdc_Vl_Aux
			
Date	lvdt_Dt_Movimentacao_Caixa			

dw_1.AcceptText()

lvl_Cd_Filial_dw1 = dw_1.Object.Cd_Filial[1]

dc_uo_ds_base ds_1
ds_1 = Create dc_uo_ds_base

ds_1.DataObject = "ds_ge303_lista_nf_convenio_lote"
ds_1.SetTransObject(SQLCA)

If lvl_Cd_Filial_dw1 > 0 Then
	ds_1.Of_AppendWhere("nf.cd_filial = " + String(lvl_Cd_Filial_dw1))
End If

lvl_Total = ds_1.Retrieve(pl_Convenio, pdt_Inicio, pdt_Termino)

If lvl_Total > 0 Then
	Open(w_Aguarde)
	w_Aguarde.Title = "Atualizando Devolu$$HEX2$$e700f500$$ENDHEX$$es..."
	w_Aguarde.uo_Progress.of_SetMax(lvl_Total)
End If

lvdc_Vl_Total_EPharma				= 0.00
lvdc_Vl_Total_VidaLink_FarPop		= 0.00
lvdc_Vl_Total_VidaLink_Copel		= 0.00
lvdc_Vl_Total_VidaLink_Diversos 	= 0.00
lvdc_Vl_Total_Funcional 				= 0.00
lvdc_Vl_Total_Outros 					= 0.00			
lvdc_Vl_Pago_Avista 					= 0.00
lvdc_Vl_Total_Pago_Avista 			= 0.00

For lvl_Cont  = 1 To lvl_Total
	
	w_Aguarde.uo_Progress.of_SetProgress(lvl_Cont)
	
	lvl_Filial_Venda 					= ds_1.Object.Cd_Filial								[lvl_Cont]
	lvl_Nr_Nf_Venda 					= ds_1.Object.Nr_Nf									[lvl_Cont]
	lvs_Especie_Venda 				= ds_1.Object.De_Especie							[lvl_Cont]
	lvs_Serie_Venda 					= ds_1.Object.De_Serie								[lvl_Cont]
	lvdc_Vl_Total_Nf					= ds_1.Object.Vl_Total_Nf							[lvl_Cont]
	lvdc_Vl_Pago_Avista				= ds_1.Object.Vl_Pago_Avista						[lvl_Cont]
	lvs_Cd_Conveniado				= ds_1.Object.Cd_Conveniado						[lvl_Cont]
	lvdt_Dt_Movimentacao_Caixa 	= Date(ds_1.Object.Dh_Movimentacao_Caixa	[lvl_Cont])
	//lvs_Nr_Comprovante			= ds_1.Object.nr_comprovante_venda			[lvl_Cont]	
	
	lvdc_Vl_Total_Geral			+= lvdc_Vl_Total_Nf
	lvdc_Vl_Total_Pago_Avista 	+= lvdc_Vl_Pago_Avista
	
	Select nr_comprovante_venda 
	 Into :lvs_Nr_Comprovante
	From venda_pbm 
	Where cd_filial 			= :lvl_Filial_Venda
	    and nr_nf 			= :lvl_Nr_Nf_Venda
	    and de_especie 	= :lvs_Especie_Venda
		and de_serie 		= :lvs_Serie_Venda
     Using SqlCa;
	  
	  If SqlCa.SqlCode = -1 Then
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do cart$$HEX1$$e300$$ENDHEX$$o comprovante venda da filial: " + String(lvl_Filial_Venda) + " nota: " + String(lvl_Nr_Nf_Venda), StopSign!)		
		Return False
	End If
	
	Choose Case lvs_Cd_Conveniado 
		Case "52718" // ePharma
			lvdc_Vl_Total_EPharma += lvdc_Vl_Total_Nf //- lvdc_Vl_Pago_Avista
		Case "52575", "53724", "53725" // Vida Link
			Choose Case lvs_Nr_Comprovante
				Case "AVFARPOP"
					lvdc_Vl_Total_VidaLink_FarPop += lvdc_Vl_Total_Nf //- lvdc_Vl_Pago_Avista					
				Case "AVFCOPEL"
					lvdc_Vl_Total_VidaLink_Copel += lvdc_Vl_Total_Nf //- lvdc_Vl_Pago_Avista
				Case Else
					lvdc_Vl_Total_VidaLink_Diversos += lvdc_Vl_Total_Nf //- lvdc_Vl_Pago_Avista
			End Choose
		Case "52349" // Funcional Card
			lvdc_Vl_Total_Funcional += lvdc_Vl_Total_Nf //- lvdc_Vl_Pago_Avista
		Case Else
			lvdc_Vl_Total_Outros += lvdc_Vl_Total_Nf
	End Choose	
Next

Destroy(ds_1)

lvl_Linha_dw2 = dw_2.Find("cd_filial = " + String(534), 1, dw_2.RowCount())
	
If lvl_Linha_dw2 = 0 Then
	lvl_Linha_dw2 = dw_2.InsertRow(0)
	
	dw_2.Object.Cd_Filial		[lvl_Linha_dw2] = 534
	dw_2.Object.Nm_Filial	[lvl_Linha_dw2] = 'ESTOQUE CENTRAL - PERINI'	
End If

// 1112
If lvdc_Vl_Total_Outros > 0 Then
	lvdc_Vl_Aux = dw_2.Object.Vl_Dev_CV1112[lvl_Linha_dw2]
	If IsNull(lvdc_Vl_Aux) Then lvdc_Vl_Aux = 0.00
	dw_2.Object.Vl_Dev_CV1112[lvl_Linha_dw2] = lvdc_Vl_Aux + lvdc_Vl_Total_Outros //+ lvdc_Vl_Total_Pago_Avista
End If

// 1266
If lvdc_Vl_Total_VidaLink_FarPop > 0 Then
	lvdc_Vl_Aux = dw_2.Object.Vl_Dev_CV1266[lvl_Linha_dw2]
	If IsNull(lvdc_Vl_Aux) Then lvdc_Vl_Aux = 0.00
	dw_2.Object.Vl_Dev_CV1266[lvl_Linha_dw2] = lvdc_Vl_Aux + lvdc_Vl_Total_VidaLink_FarPop
End If

// 1267
If lvdc_Vl_Total_VidaLink_Copel > 0 Then
	lvdc_Vl_Aux = dw_2.Object.Vl_Dev_CV1268[lvl_Linha_dw2]
	If IsNull(lvdc_Vl_Aux) Then lvdc_Vl_Aux = 0.00
	dw_2.Object.Vl_Dev_CV1268[lvl_Linha_dw2] = lvdc_Vl_Aux + lvdc_Vl_Total_VidaLink_Copel
End If

// 1268	
If lvdc_Vl_Total_VidaLink_Diversos > 0 Then
	lvdc_Vl_Aux = dw_2.Object.Vl_Dev_CV1268[lvl_Linha_dw2]
	If IsNull(lvdc_Vl_Aux) Then lvdc_Vl_Aux = 0.00
	dw_2.Object.Vl_Dev_CV1268[lvl_Linha_dw2] = lvdc_Vl_Aux + lvdc_Vl_Total_VidaLink_Diversos
End If

// 1269	
If lvdc_Vl_Total_EPharma > 0 Then
	lvdc_Vl_Aux = dw_2.Object.Vl_Dev_CV1269[lvl_Linha_dw2]
	If IsNull(lvdc_Vl_Aux) Then lvdc_Vl_Aux = 0.00
	dw_2.Object.Vl_Dev_CV1269[lvl_Linha_dw2] = lvdc_Vl_Aux + lvdc_Vl_Total_EPharma
End If

// 1270	
If lvdc_Vl_Total_Funcional > 0 Then
	lvdc_Vl_Aux = dw_2.Object.Vl_Dev_CV1270[lvl_Linha_dw2]
	If IsNull(lvdc_Vl_Aux) Then lvdc_Vl_Aux = 0.00
	dw_2.Object.Vl_Dev_CV1270[lvl_Linha_dw2] = lvdc_Vl_Aux + lvdc_Vl_Total_Funcional
End If

If lvl_Total > 0 Then
	Close(w_Aguarde)
End If

Return True
end function

public function boolean wf_insere_pagamentos_conta_credito (date pdt_inicio, date pdt_termino);Long 	lvl_Total, &
		lvl_Cont, &
		lvl_Cd_Filial, &
		lvl_Linha_dw2, &
		lvl_Cd_Filial_dw1

String 	lvs_Nm_Fantasia, &
			lvs_Tipo, &
			lvs_Conta_Contabil
			
Decimal 	lvdc_Vl_Pago, &
			lvdc_Vl_Movimento

dw_1.AcceptText()

lvl_Cd_Filial_dw1 = dw_1.Object.Cd_Filial[1]

dc_uo_ds_base ds_1
ds_1 = Create dc_uo_ds_base

ds_1.DataObject = "ds_ge303_pagtos_conta_cv_cc_cr_credito"
ds_1.SetTransObject(SQLCA)

If lvl_Cd_Filial_dw1 > 0 Then
	ds_1.of_AppendWhere("crm.cd_filial = " + String(lvl_Cd_Filial_dw1))
End If

lvl_Total = ds_1.Retrieve(pdt_Inicio, pdt_Termino)

If lvl_Total > 0 Then
	Open(w_Aguarde)
	w_Aguarde.Title = "Atualizando Dados de Pagamentos por Conta - Cr$$HEX1$$e900$$ENDHEX$$dito do Per$$HEX1$$ed00$$ENDHEX$$odo..."
	w_Aguarde.uo_Progress.of_SetMax(lvl_Total)
End If

For lvl_Cont  = 1 To lvl_Total
	
	w_Aguarde.uo_Progress.of_SetProgress(lvl_Cont)
	
	lvdc_Vl_Movimento	= 0.00
	lvdc_Vl_Pago			= 0.00
	
	lvl_Cd_Filial				= ds_1.Object.Cd_Filial				[lvl_Cont]
	lvs_Nm_Fantasia		= ds_1.Object.Nm_Fantasia			[lvl_Cont]
	lvs_Tipo					= ds_1.Object.Id_Tipo_Conta		[lvl_Cont]
	lvs_Conta_Contabil	= ds_1.Object.cd_conta_contabil	[lvl_Cont]
	lvdc_Vl_Movimento	= ds_1.Object.Vl_Movimento		[lvl_Cont]
	
	lvl_Linha_dw2 = dw_2.Find("cd_filial = " + String(lvl_Cd_Filial), 1, dw_2.RowCount())
	
	If lvl_Linha_dw2 = 0 Then
		lvl_Linha_dw2 = dw_2.InsertRow(0)
		
		dw_2.Object.Cd_Filial		[lvl_Linha_dw2] = lvl_Cd_Filial
		dw_2.Object.Nm_Filial	[lvl_Linha_dw2] = lvs_Nm_Fantasia		
	End If

	Choose Case lvs_Tipo
		Case 'CV'
			Choose Case lvs_Conta_Contabil
				Case '1266'
					lvdc_Vl_Pago = dw_2.Object.Vl_Pagto_CV1266[lvl_Linha_dw2]
					If IsNull(lvdc_Vl_Pago) Then lvdc_Vl_Pago = 0.00
						
					dw_2.Object.Vl_Pagto_CV1266[lvl_Linha_dw2] = lvdc_Vl_Pago + lvdc_Vl_Movimento
				Case '1267'
					lvdc_Vl_Pago = dw_2.Object.Vl_Pagto_CV1267[lvl_Linha_dw2]
					If IsNull(lvdc_Vl_Pago) Then lvdc_Vl_Pago = 0.00
						
					dw_2.Object.Vl_Pagto_CV1267[lvl_Linha_dw2] = lvdc_Vl_Pago + lvdc_Vl_Movimento
				Case '1268'
					lvdc_Vl_Pago = dw_2.Object.Vl_Pagto_CV1268[lvl_Linha_dw2]
					If IsNull(lvdc_Vl_Pago) Then lvdc_Vl_Pago = 0.00
						
					dw_2.Object.Vl_Pagto_CV1268[lvl_Linha_dw2] = lvdc_Vl_Pago + lvdc_Vl_Movimento
				Case '1269'
					lvdc_Vl_Pago = dw_2.Object.Vl_Pagto_CV1269[lvl_Linha_dw2]
					If IsNull(lvdc_Vl_Pago) Then lvdc_Vl_Pago = 0.00
						
					dw_2.Object.Vl_Pagto_CV1269[lvl_Linha_dw2] = lvdc_Vl_Pago + lvdc_Vl_Movimento
				Case '1270'
					lvdc_Vl_Pago = dw_2.Object.Vl_Pagto_CV1270[lvl_Linha_dw2]
					If IsNull(lvdc_Vl_Pago) Then lvdc_Vl_Pago = 0.00
						
					dw_2.Object.Vl_Pagto_CV1270[lvl_Linha_dw2] = lvdc_Vl_Pago + lvdc_Vl_Movimento
				Case Else
					lvdc_Vl_Pago = dw_2.Object.Vl_Pagto_CV1112[lvl_Linha_dw2]
					If IsNull(lvdc_Vl_Pago) Then lvdc_Vl_Pago = 0.00
						
					dw_2.Object.Vl_Pagto_CV1112[lvl_Linha_dw2] = lvdc_Vl_Pago + lvdc_Vl_Movimento
			End Choose
		Case 'CC'
			lvdc_Vl_Pago = dw_2.Object.Vl_Pagto_CC[lvl_Linha_dw2]
			If IsNull(lvdc_Vl_Pago) Then lvdc_Vl_Pago = 0.00
			
			dw_2.Object.Vl_Pagto_CC[lvl_Linha_dw2] = lvdc_Vl_Pago + lvdc_Vl_Movimento
		Case 'CR'
			lvdc_Vl_Pago = dw_2.Object.Vl_Pagto_CR[lvl_Linha_dw2]
			If IsNull(lvdc_Vl_Pago) Then lvdc_Vl_Pago = 0.00
			
			dw_2.Object.Vl_Pagto_CR[lvl_Linha_dw2] = lvdc_Vl_Pago + lvdc_Vl_Movimento
	End Choose
Next

Destroy(ds_1)

If lvl_Total > 0 Then
	Close(w_Aguarde)
End If

Return True
end function

public function boolean wf_insere_pagamentos_conta_debito (date pdt_inicio, date pdt_termino);Long 	lvl_Total, &
		lvl_Cont, &
		lvl_Cd_Filial, &
		lvl_Linha_dw2, &
		lvl_Cd_Filial_dw1

String 	lvs_Nm_Fantasia, &
			lvs_Tipo, &
			lvs_Conta_Contabil
			
Decimal 	lvdc_Vl_Pago, &
			lvdc_Vl_Movimento

dw_1.AcceptText()

lvl_Cd_Filial_dw1 = dw_1.Object.Cd_Filial[1]

dc_uo_ds_base ds_1
ds_1 = Create dc_uo_ds_base

ds_1.DataObject = "ds_ge303_pagtos_conta_cv_cc_cr_debito"
ds_1.SetTransObject(SQLCA)

If lvl_Cd_Filial_dw1 > 0 Then
	ds_1.of_AppendWhere("crm.cd_filial = " + String(lvl_Cd_Filial_dw1))
End If

lvl_Total = ds_1.Retrieve(pdt_Inicio, pdt_Termino)

If lvl_Total > 0 Then
	Open(w_Aguarde)
	w_Aguarde.Title = "Atualizando Dados de Pagamentos por Conta - D$$HEX1$$e900$$ENDHEX$$bito do Per$$HEX1$$ed00$$ENDHEX$$odo..."
	w_Aguarde.uo_Progress.of_SetMax(lvl_Total)
End If

For lvl_Cont  = 1 To lvl_Total
	
	w_Aguarde.uo_Progress.of_SetProgress(lvl_Cont)
	
	lvdc_Vl_Movimento	= 0.00
	lvdc_Vl_Pago			= 0.00
	
	lvl_Cd_Filial				= ds_1.Object.Cd_Filial				[lvl_Cont]
	lvs_Nm_Fantasia		= ds_1.Object.Nm_Fantasia			[lvl_Cont]
	lvs_Tipo					= ds_1.Object.Id_Tipo_Conta		[lvl_Cont]
	lvs_Conta_Contabil	= ds_1.Object.cd_conta_contabil	[lvl_Cont]
	lvdc_Vl_Movimento	= ds_1.Object.Vl_Movimento		[lvl_Cont]
	
	lvl_Linha_dw2 = dw_2.Find("cd_filial = " + String(lvl_Cd_Filial), 1, dw_2.RowCount())
	
	If lvl_Linha_dw2 = 0 Then
		lvl_Linha_dw2 = dw_2.InsertRow(0)
		
		dw_2.Object.Cd_Filial		[lvl_Linha_dw2] = lvl_Cd_Filial
		dw_2.Object.Nm_Filial	[lvl_Linha_dw2] = lvs_Nm_Fantasia		
	End If

	Choose Case lvs_Tipo
		Case 'CV'
			Choose Case lvs_Conta_Contabil
				Case '1266'
					lvdc_Vl_Pago = dw_2.Object.Vl_Pagto_CV1266[lvl_Linha_dw2]
					If IsNull(lvdc_Vl_Pago) Then lvdc_Vl_Pago = 0.00
						
					dw_2.Object.Vl_Pagto_CV1266[lvl_Linha_dw2] = lvdc_Vl_Pago - lvdc_Vl_Movimento
				Case '1267'
					lvdc_Vl_Pago = dw_2.Object.Vl_Pagto_CV1267[lvl_Linha_dw2]
					If IsNull(lvdc_Vl_Pago) Then lvdc_Vl_Pago = 0.00
						
					dw_2.Object.Vl_Pagto_CV1267[lvl_Linha_dw2] = lvdc_Vl_Pago - lvdc_Vl_Movimento
				Case '1268'
					lvdc_Vl_Pago = dw_2.Object.Vl_Pagto_CV1268[lvl_Linha_dw2]
					If IsNull(lvdc_Vl_Pago) Then lvdc_Vl_Pago = 0.00
						
					dw_2.Object.Vl_Pagto_CV1268[lvl_Linha_dw2] = lvdc_Vl_Pago - lvdc_Vl_Movimento
				Case '1269'
					lvdc_Vl_Pago = dw_2.Object.Vl_Pagto_CV1269[lvl_Linha_dw2]
					If IsNull(lvdc_Vl_Pago) Then lvdc_Vl_Pago = 0.00
						
					dw_2.Object.Vl_Pagto_CV1269[lvl_Linha_dw2] = lvdc_Vl_Pago - lvdc_Vl_Movimento
				Case '1270'
					lvdc_Vl_Pago = dw_2.Object.Vl_Pagto_CV1270[lvl_Linha_dw2]
					If IsNull(lvdc_Vl_Pago) Then lvdc_Vl_Pago = 0.00
						
					dw_2.Object.Vl_Pagto_CV1270[lvl_Linha_dw2] = lvdc_Vl_Pago - lvdc_Vl_Movimento
				Case Else
					lvdc_Vl_Pago = dw_2.Object.Vl_Pagto_CV1112[lvl_Linha_dw2]
					If IsNull(lvdc_Vl_Pago) Then lvdc_Vl_Pago = 0.00
						
					dw_2.Object.Vl_Pagto_CV1112[lvl_Linha_dw2] = lvdc_Vl_Pago - lvdc_Vl_Movimento
			End Choose
		Case 'CC'
			lvdc_Vl_Pago = dw_2.Object.Vl_Pagto_CC[lvl_Linha_dw2]
			If IsNull(lvdc_Vl_Pago) Then lvdc_Vl_Pago = 0.00
			
			dw_2.Object.Vl_Pagto_CC[lvl_Linha_dw2] = lvdc_Vl_Pago - lvdc_Vl_Movimento
		Case 'CR'
			lvdc_Vl_Pago = dw_2.Object.Vl_Pagto_CR[lvl_Linha_dw2]
			If IsNull(lvdc_Vl_Pago) Then lvdc_Vl_Pago = 0.00
			
			dw_2.Object.Vl_Pagto_CR[lvl_Linha_dw2] = lvdc_Vl_Pago - lvdc_Vl_Movimento
	End Choose
Next

Destroy(ds_1)

If lvl_Total > 0 Then
	Close(w_Aguarde)
End If

Return True
end function

public function boolean wf_insere_vendaspbm (date pdt_inicio, date pdt_termino, long pl_convenio);Long 	lvl_Total, &
		lvl_Cont, &
		lvl_Cd_Filial

Decimal	lvdc_Vl_Total_Venda, &
			lvdc_Vl_Total_AVista, &
			lvdc_Vl_Total_NF, &
			lvdc_Vl_Total_Pago_Avista, &
			lvdc_Vl_Total_NFC, &
			lvdc_Vl_Total_Aux, &
			lvdc_Vl_Total_Pago_Avista_NFC
			
lvl_Total = dw_2.RowCount()

If lvl_Total > 0 Then
	Open(w_Aguarde)
	w_Aguarde.Title = "Atualizando Dados de Vendas PBM do Per$$HEX1$$ed00$$ENDHEX$$odo - Conv$$HEX1$$ea00$$ENDHEX$$nio [" + String(pl_Convenio) + "]"
	w_Aguarde.uo_Progress.of_SetMax(lvl_Total)
End If

For lvl_Cont  = 1 To lvl_Total
	w_Aguarde.uo_Progress.of_SetProgress(lvl_Cont)
	
	lvl_Cd_Filial	= dw_2.Object.Cd_Filial	[lvl_Cont]
	
	lvdc_Vl_Total_Venda	= gf_retorna_venda_convenio_pbm(lvl_Cd_Filial, pdt_Inicio, pdt_Termino, pl_Convenio, '', 0, ref lvdc_Vl_Total_NF, ref lvdc_Vl_Total_Pago_Avista, ref lvdc_Vl_Total_NFC, ref lvdc_Vl_Total_Pago_Avista_NFC)
	lvdc_Vl_Total_AVista	= lvdc_Vl_Total_Pago_Avista + lvdc_Vl_Total_Pago_Avista_NFC
	If IsNull(lvdc_Vl_Total_Venda) Then lvdc_Vl_Total_Venda = 0.00
	If IsNull(lvdc_Vl_Total_AVista) Then lvdc_Vl_Total_AVista = 0.00

	Choose Case pl_Convenio
		Case 52575 // VidaLink
			If (pdt_inicio >= Date('01/11/2016')) Then
				//Vidalink Farm$$HEX1$$e100$$ENDHEX$$cia Popular
				dw_2.Object.Vl_Venda_1266		[lvl_Cont] = lvdc_Vl_Total_Venda
				dw_2.Object.vl_pago_avista_1266	[lvl_Cont] = lvdc_Vl_Total_AVista
			ElseIf pdt_inicio >= Date('01/06/2015')  Then
				//Deduzir Farm$$HEX1$$e100$$ENDHEX$$cia Popular
				lvdc_Vl_Total_Aux = gf_retorna_venda_convenio_pbm(lvl_Cd_Filial, pdt_Inicio, pdt_Termino, pl_Convenio, 'AVFARPOP', 0, ref lvdc_Vl_Total_NF, ref lvdc_Vl_Total_Pago_Avista, ref lvdc_Vl_Total_NFC, ref lvdc_Vl_Total_Pago_Avista_NFC)
				lvdc_Vl_Total_Venda -= lvdc_Vl_Total_Aux
				lvdc_Vl_Total_AVista -= lvdc_Vl_Total_Pago_Avista + lvdc_Vl_Total_Pago_Avista_NFC
				dw_2.Object.Vl_Venda_1266		[lvl_Cont] = lvdc_Vl_Total_Aux
				dw_2.Object.vl_pago_avista_1266	[lvl_Cont] = lvdc_Vl_Total_Pago_Avista + lvdc_Vl_Total_Pago_Avista_NFC
				//Deduzir Copel
				lvdc_Vl_Total_Aux = gf_retorna_venda_convenio_pbm(lvl_Cd_Filial, pdt_Inicio, pdt_Termino, pl_Convenio, 'AVFCOPEL', 0, ref lvdc_Vl_Total_NF, ref lvdc_Vl_Total_Pago_Avista, ref lvdc_Vl_Total_NFC, ref lvdc_Vl_Total_Pago_Avista_NFC)
				lvdc_Vl_Total_Venda -= lvdc_Vl_Total_Aux
				lvdc_Vl_Total_AVista -= lvdc_Vl_Total_Pago_Avista + lvdc_Vl_Total_Pago_Avista_NFC
				dw_2.Object.Vl_Venda_1267		[lvl_Cont] = lvdc_Vl_Total_Aux
				dw_2.Object.vl_pago_avista_1267	[lvl_Cont] = lvdc_Vl_Total_Pago_Avista + lvdc_Vl_Total_Pago_Avista_NFC
				
				//Vidalink Diversos
				dw_2.Object.Vl_Venda_1268		[lvl_Cont] = lvdc_Vl_Total_Venda
				dw_2.Object.vl_pago_avista_1268	[lvl_Cont] = lvdc_Vl_Total_AVista
			End If
		Case 53724
			dw_2.Object.Vl_Venda_1267		[lvl_Cont] = lvdc_Vl_Total_Venda
			dw_2.Object.vl_pago_avista_1267	[lvl_Cont] = lvdc_Vl_Total_AVista
		Case 53725
			dw_2.Object.Vl_Venda_1268		[lvl_Cont] = lvdc_Vl_Total_Venda
			dw_2.Object.vl_pago_avista_1268	[lvl_Cont] = lvdc_Vl_Total_AVista
		Case 52718 // e-Pharma
			dw_2.Object.Vl_Venda_1269		[lvl_Cont] = lvdc_Vl_Total_Venda
			dw_2.Object.vl_pago_avista_1269	[lvl_Cont] = lvdc_Vl_Total_AVista
		Case 52349 // FuncionalCard
			dw_2.Object.Vl_Venda_1270		[lvl_Cont] = lvdc_Vl_Total_Venda		
			dw_2.Object.vl_pago_avista_1270	[lvl_Cont] = lvdc_Vl_Total_AVista	
	End Choose
Next

If IsValid(w_Aguarde) Then Close(w_Aguarde)

Return True
end function

public function boolean wf_insere_estorno_caixas (date pdt_inicio, date pdt_termino);Long	lvl_Total, &
		lvl_Cont, &
		lvl_Loop, &
		lvl_Cd_Filial
		
Date	lvdt_Termino, &
		lvdt_Termino1

Decimal	lvdc_Vl_Venda_Estorno
Decimal	lvdc_Aux
			
String 	lvs_Conta
String 	lvs_Tipo_Venda
String 	lvs_Tipo_Estorno
String 	lvs_Tipo_Lacto
		
lvl_Total = dw_2.RowCount()

Open(w_Aguarde)
w_Aguarde.Title = "Atualizando Dados de Estornos do Per$$HEX1$$ed00$$ENDHEX$$odo..."
w_Aguarde.uo_Progress.of_SetMax(lvl_Total)

lvdt_Termino 		= gf_Retorna_Ultimo_Dia_Mes(pdt_Termino) //RelativeDate(pdt_Termino, 10)
lvdt_Termino1 		= RelativeDate(pdt_Termino, 1)

For lvl_Cont  = 1 To lvl_Total
	
	w_Aguarde.uo_Progress.of_SetProgress(lvl_Cont)
	lvl_Cd_Filial			= dw_2.Object.Cd_Filial 		[lvl_Cont]
	
	// Estorno CV
	
	DECLARE lcu_lancamento CURSOR FOR
	Select 	cfc.cd_conta_contabil, 
				lc.id_estorno,
				case when lc.cd_conta_fluxo_caixa in (4, 5, 6, 7, 8) then 'P' else 'V' end,
				case when cfc.cd_conta_contabil = '1112' then 
					case lc.cd_conta_fluxo_caixa 
						when 6 then 'CC'
						when 8 then 'CC'
						when 5 then 'CR'
						when 7 then 'CR'
					else 'CV' end
				else 'CV' end as id_tipo_venda,
				coalesce(sum(vl_lancamento), 0)
	From lancamento_caixa lc
	 Inner join controle_caixa cc
	 on cc.cd_caixa = lc.cd_caixa
	  and cc.nr_controle_caixa = lc.nr_controle_caixa
	 Inner join caixa cx
	  on cx.cd_caixa = cc.cd_caixa
	 Inner Join conta_fluxo_caixa cfc
	 	on cfc.cd_conta_fluxo_caixa  = lc.cd_conta_fluxo_caixa
	Where cc.dh_movimentacao_caixa = :pdt_Inicio 
	  and cx.cd_filial 			= :lvl_Cd_Filial
	  and lc.id_estorno 		= 'S'
	  and lc.cd_conta_fluxo_caixa in ( 2, 3, 4, 5, 6, 7, 8, 218, 219, 220, 221, 222 )
	  and cx.id_caixa_geral 	= 'S'
	  //and lc.id_estorno 		in ('S','X')
	  //and ((lc.id_estorno = 'S') or ((lc.id_estorno = 'X') and (lc.cd_conta_fluxo_caixa in (7, 8))))
	  group by cfc.cd_conta_contabil, 
				lc.id_estorno,
				case when lc.cd_conta_fluxo_caixa in (4, 5, 6, 7, 8) then 'P' else 'V' end,
				case when cfc.cd_conta_contabil = '1112' then 
					case lc.cd_conta_fluxo_caixa 
						when 6 then 'CC'
						when 8 then 'CC'
						when 5 then 'CR'
						when 7 then 'CR'
					else 'CV' end
				else 'CV' end
	  Using SqlCa;

	 OPEN lcu_lancamento;
	 
	 FETCH lcu_lancamento INTO :lvs_Conta, :lvs_Tipo_Lacto, :lvs_Tipo_Estorno, :lvs_Tipo_Venda, :lvdc_Vl_Venda_Estorno;
	 
	If SqlCa.SqlCode = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Erro na verifica$$HEX2$$e700e300$$ENDHEX$$o do estorno de pagto CV da filial: " + String(lvl_Cd_Filial))
		Return False
	End If
	
	DO WHILE SQLCA.sqlcode = 0
		If lvs_Tipo_Lacto = "S" Then
			If lvs_Tipo_Estorno = "P" Then
				Choose Case lvs_Conta
					Case '1112'
						Choose Case lvs_Tipo_Venda
							Case 'CV'
								lvdc_Aux = dw_2.Object.vl_pagto_estorno_1112_cv	[lvl_Cont]
								If IsNull(lvdc_Aux) Then lvdc_Aux = 0.00
								dw_2.Object.vl_pagto_estorno_1112_cv		[lvl_Cont] = lvdc_Aux + lvdc_Vl_Venda_Estorno
							Case 'CC'
								lvdc_Aux = dw_2.Object.vl_pagto_estorno_1112_cc	[lvl_Cont]
								If IsNull(lvdc_Aux) Then lvdc_Aux = 0.00
								dw_2.Object.vl_pagto_estorno_1112_cc		[lvl_Cont] = lvdc_Aux + lvdc_Vl_Venda_Estorno
							Case 'CR'
								lvdc_Aux = dw_2.Object.vl_pagto_estorno_1112_cr	[lvl_Cont]
								If IsNull(lvdc_Aux) Then lvdc_Aux = 0.00
								dw_2.Object.vl_pagto_estorno_1112_cr		[lvl_Cont] = lvdc_Aux + lvdc_Vl_Venda_Estorno
						End Choose
					Case '1266'
						lvdc_Aux = dw_2.Object.vl_pagto_estorno_1266		[lvl_Cont]
						If IsNull(lvdc_Aux) Then lvdc_Aux = 0.00
						dw_2.Object.vl_pagto_estorno_1266		[lvl_Cont] = lvdc_Aux + lvdc_Vl_Venda_Estorno
					Case '1267'
						lvdc_Aux = dw_2.Object.vl_pagto_estorno_1267		[lvl_Cont]
						If IsNull(lvdc_Aux) Then lvdc_Aux = 0.00
						dw_2.Object.vl_pagto_estorno_1267		[lvl_Cont] = lvdc_Aux + lvdc_Vl_Venda_Estorno
					Case '1268'
						lvdc_Aux = dw_2.Object.vl_pagto_estorno_1268		[lvl_Cont]
						If IsNull(lvdc_Aux) Then lvdc_Aux = 0.00
						dw_2.Object.vl_pagto_estorno_1268		[lvl_Cont] = lvdc_Aux + lvdc_Vl_Venda_Estorno
					Case '1269'
						lvdc_Aux = dw_2.Object.vl_pagto_estorno_1269		[lvl_Cont]
						If IsNull(lvdc_Aux) Then lvdc_Aux = 0.00
						dw_2.Object.vl_pagto_estorno_1269		[lvl_Cont] = lvdc_Aux + lvdc_Vl_Venda_Estorno
					Case '1270'
						lvdc_Aux = dw_2.Object.vl_pagto_estorno_1270		[lvl_Cont]
						If IsNull(lvdc_Aux) Then lvdc_Aux = 0.00
						dw_2.Object.vl_pagto_estorno_1270		[lvl_Cont] = lvdc_Aux + lvdc_Vl_Venda_Estorno
				End Choose				
			Else
				Choose Case lvs_Conta
					Case '1112'
						Choose Case lvs_Tipo_Venda
							Case 'CV'
								lvdc_Aux = dw_2.Object.vl_venda_estorno_1112_cv		[lvl_Cont]
								If IsNull(lvdc_Aux) Then lvdc_Aux = 0.00
								dw_2.Object.vl_venda_estorno_1112_cv		[lvl_Cont] = lvdc_Aux + lvdc_Vl_Venda_Estorno
							Case 'CC'
								lvdc_Aux = dw_2.Object.vl_venda_estorno_1112_cc		[lvl_Cont]
								If IsNull(lvdc_Aux) Then lvdc_Aux = 0.00
								dw_2.Object.vl_venda_estorno_1112_cc		[lvl_Cont] = lvdc_Aux + lvdc_Vl_Venda_Estorno
							Case 'CR'
								lvdc_Aux = dw_2.Object.vl_venda_estorno_1112_cr		[lvl_Cont]
								If IsNull(lvdc_Aux) Then lvdc_Aux = 0.00
								dw_2.Object.vl_venda_estorno_1112_cr		[lvl_Cont] = lvdc_Aux + lvdc_Vl_Venda_Estorno
						End Choose
					Case '1266'
						lvdc_Aux = dw_2.Object.vl_venda_estorno_1266		[lvl_Cont]
						If IsNull(lvdc_Aux) Then lvdc_Aux = 0.00
						dw_2.Object.vl_venda_estorno_1266		[lvl_Cont] = lvdc_Aux + lvdc_Vl_Venda_Estorno
					Case '1267'
						lvdc_Aux = dw_2.Object.vl_venda_estorno_1267		[lvl_Cont]
						If IsNull(lvdc_Aux) Then lvdc_Aux = 0.00
						dw_2.Object.vl_venda_estorno_1267		[lvl_Cont] = lvdc_Aux + lvdc_Vl_Venda_Estorno
					Case '1268'
						lvdc_Aux = dw_2.Object.vl_venda_estorno_1268		[lvl_Cont]
						If IsNull(lvdc_Aux) Then lvdc_Aux = 0.00
						dw_2.Object.vl_venda_estorno_1268		[lvl_Cont] = lvdc_Aux + lvdc_Vl_Venda_Estorno
					Case '1269'
						lvdc_Aux = dw_2.Object.vl_venda_estorno_1269		[lvl_Cont]
						If IsNull(lvdc_Aux) Then lvdc_Aux = 0.00
						dw_2.Object.vl_venda_estorno_1269		[lvl_Cont] = lvdc_Aux + lvdc_Vl_Venda_Estorno
					Case '1270'
						lvdc_Aux = dw_2.Object.vl_venda_estorno_1270		[lvl_Cont]
						If IsNull(lvdc_Aux) Then lvdc_Aux = 0.00
						dw_2.Object.vl_venda_estorno_1270		[lvl_Cont] = lvdc_Aux + lvdc_Vl_Venda_Estorno
				End Choose
			End If
			
		//Lancamentos pagamentos Estornados
		ElseIf lvs_Tipo_Estorno = "P" Then
			Choose Case lvs_Conta
				Case '1112'
					Choose Case lvs_Tipo_Venda
						Case 'CV'  
							lvdc_Aux = dw_2.Object.vl_pagto_cv1112	[lvl_Cont]
							If IsNull(lvdc_Aux) Then lvdc_Aux = 0.00
							dw_2.Object.vl_pagto_cv1112		[lvl_Cont] = lvdc_Aux + lvdc_Vl_Venda_Estorno
						Case 'CC'
							lvdc_Aux = dw_2.Object.vl_pagto_cc	[lvl_Cont]
							If IsNull(lvdc_Aux) Then lvdc_Aux = 0.00
							dw_2.Object.vl_pagto_cc		[lvl_Cont] = lvdc_Aux + lvdc_Vl_Venda_Estorno
						Case 'CR'
							lvdc_Aux = dw_2.Object.vl_pagto_cr	[lvl_Cont]
							If IsNull(lvdc_Aux) Then lvdc_Aux = 0.00
							dw_2.Object.vl_pagto_cr		[lvl_Cont] = lvdc_Aux + lvdc_Vl_Venda_Estorno
					End Choose
				Case '1266'
					lvdc_Aux = dw_2.Object.vl_pagto_cv1266	[lvl_Cont]
					If IsNull(lvdc_Aux) Then lvdc_Aux = 0.00
					dw_2.Object.vl_pagto_cv1266	[lvl_Cont] = lvdc_Aux + lvdc_Vl_Venda_Estorno
				Case '1267'
					lvdc_Aux = dw_2.Object.vl_pagto_cv1267	[lvl_Cont]
					If IsNull(lvdc_Aux) Then lvdc_Aux = 0.00
					dw_2.Object.vl_pagto_cv1267	[lvl_Cont] = lvdc_Aux + lvdc_Vl_Venda_Estorno
				Case '1268'
					lvdc_Aux = dw_2.Object.vl_pagto_cv1268	[lvl_Cont]
					If IsNull(lvdc_Aux) Then lvdc_Aux = 0.00
					dw_2.Object.vl_pagto_cv1268	[lvl_Cont] = lvdc_Aux + lvdc_Vl_Venda_Estorno
				Case '1269'
					lvdc_Aux = dw_2.Object.vl_pagto_cv1269	[lvl_Cont]
					If IsNull(lvdc_Aux) Then lvdc_Aux = 0.00
					dw_2.Object.vl_pagto_cv1269	[lvl_Cont] = lvdc_Aux + lvdc_Vl_Venda_Estorno
				Case '1270'
					lvdc_Aux = dw_2.Object.vl_pagto_cv1270	[lvl_Cont]
					If IsNull(lvdc_Aux) Then lvdc_Aux = 0.00
					dw_2.Object.vl_pagto_cv1270	[lvl_Cont] = lvdc_Aux + lvdc_Vl_Venda_Estorno
			End Choose	
		End If
		
		FETCH lcu_lancamento INTO :lvs_Conta, :lvs_Tipo_Lacto, :lvs_Tipo_Estorno, :lvs_Tipo_Venda, :lvdc_Vl_Venda_Estorno;
	Loop
	
	Close lcu_lancamento;
Next

If IsValid(w_Aguarde) then Close(w_Aguarde)

Return True
end function

public function boolean wf_insere_vendas1112 (date pdt_inicio, date pdt_termino);Long 	lvl_Total, &
		lvl_Cont, &
		lvl_Cd_Filial, &
		lvl_Linha_dw2, &
		lvl_Cd_Filial_dw1

String 	lvs_Nm_Fantasia, &
			lvs_Id_Tipo_Venda
			
Decimal 	lvdc_Vl_Total_Venda, &
			lvdc_Vl_Total_AVista, &
			lvdc_Vl_Total_PBM, &
			lvdc_Vl_Total_Vidalink, &
			lvdc_Vl_Total_EPharma, &
			lvdc_Vl_Total_Funcional, &
			lvdc_Vl_Total_TRN

dw_1.AcceptText()

lvl_Cd_Filial_dw1 = dw_1.Object.Cd_Filial[1]

dc_uo_ds_base ds_1
ds_1 = Create dc_uo_ds_base

ds_1.DataObject = "ds_ge303_vendas_cv_cc_cr"
ds_1.SetTransObject(SQLCA)

If lvl_Cd_Filial_dw1 > 0 Then
	ds_1.of_AppendWhere("n.cd_filial = " + String(lvl_Cd_Filial_dw1), 1)
	ds_1.of_AppendWhere("n.cd_filial = " + String(lvl_Cd_Filial_dw1), 2)
End If

lvl_Total = ds_1.Retrieve(pdt_Inicio, pdt_Termino)

If lvl_Total > 0 Then
	Open(w_Aguarde)
	w_Aguarde.Title = "Atualizando Dados de Vendas do Per$$HEX1$$ed00$$ENDHEX$$odo..."
	w_Aguarde.uo_Progress.of_SetMax(lvl_Total)
End If

For lvl_Cont  = 1 To lvl_Total
	
	w_Aguarde.uo_Progress.of_SetProgress(lvl_Cont)
	
	lvl_Cd_Filial				= ds_1.Object.Cd_Filial			[lvl_Cont]
	lvs_Nm_Fantasia		= ds_1.Object.Nm_Fantasia		[lvl_Cont]
	lvs_Id_Tipo_Venda	= ds_1.Object.Id_Tipo_Venda	[lvl_Cont]
	lvdc_Vl_Total_Venda	= ds_1.Object.Vl_Total_NF		[lvl_Cont]
	lvdc_Vl_Total_Avista	= ds_1.Object.Vl_Pago_Avista	[lvl_Cont]	
	
	lvl_Linha_dw2 = dw_2.Find("cd_filial = " + String(lvl_Cd_Filial), 1, dw_2.RowCount())
	
	If lvl_Linha_dw2 = 0 Then
		lvl_Linha_dw2 = dw_2.InsertRow(0)
	End If
	
	Choose Case lvs_Id_Tipo_Venda
		Case "CV"			
			lvdc_Vl_Total_Vidalink	= dw_2.Object.Vl_Venda_1268 [lvl_Linha_dw2] + dw_2.Object.Vl_Venda_1266 [lvl_Linha_dw2] + dw_2.Object.Vl_Venda_1267 [lvl_Linha_dw2]
			lvdc_Vl_Total_EPharma	= dw_2.Object.Vl_Venda_1269 [lvl_Linha_dw2]
			lvdc_Vl_Total_Funcional	= dw_2.Object.Vl_Venda_1270 [lvl_Linha_dw2]			
			
			lvdc_Vl_Total_PBM = lvdc_Vl_Total_Vidalink + lvdc_Vl_Total_EPharma + lvdc_Vl_Total_Funcional + lvdc_Vl_Total_TRN
			
			lvdc_Vl_Total_Venda -= lvdc_Vl_Total_PBM
			
			lvdc_Vl_Total_Vidalink	= dw_2.Object.vl_pago_avista_1268 [lvl_Linha_dw2] + dw_2.Object.vl_pago_avista_1266 [lvl_Linha_dw2] + dw_2.Object.vl_pago_avista_1267 [lvl_Linha_dw2]
			lvdc_Vl_Total_EPharma	= dw_2.Object.vl_pago_avista_1269 [lvl_Linha_dw2]
			lvdc_Vl_Total_Funcional	= dw_2.Object.vl_pago_avista_1270 [lvl_Linha_dw2]			
			
			lvdc_Vl_Total_PBM = lvdc_Vl_Total_Vidalink + lvdc_Vl_Total_EPharma + lvdc_Vl_Total_Funcional + lvdc_Vl_Total_TRN
			lvdc_Vl_Total_Avista -= lvdc_Vl_Total_PBM
			
			dw_2.Object.Vl_Venda_CV		[lvl_Linha_dw2] = lvdc_Vl_Total_Venda
			dw_2.Object.vl_pago_avista_cv	[lvl_Linha_dw2] = lvdc_Vl_Total_Avista
			
		Case "CC"
			dw_2.Object.Vl_Venda_CC		[lvl_Linha_dw2] = lvdc_Vl_Total_Venda
			dw_2.Object.vl_pago_avista_cc	[lvl_Linha_dw2] = lvdc_Vl_Total_Avista
			
		Case "CR"
			dw_2.Object.Vl_Venda_CR		[lvl_Linha_dw2] = lvdc_Vl_Total_Venda
			dw_2.Object.vl_pago_avista_cr	[lvl_Linha_dw2] = lvdc_Vl_Total_Avista
	End Choose			
Next

Destroy(ds_1)

If lvl_Total > 0 Then
	Close(w_Aguarde)
End If

Return True
end function

public function boolean wf_insere_vendas_diversas (date pdt_inicio, date pdt_termino);Long 	lvl_Total, &
		lvl_Cont, &
		lvl_Cd_Filial, &
		lvl_Linha_dw2, &
		lvl_Cd_Filial_dw1

String 	lvs_Nm_Fantasia
			
Decimal 	lvdc_Vl_Total_Venda

dw_1.AcceptText()

lvl_Cd_Filial_dw1 = dw_1.Object.Cd_Filial[1]

dc_uo_ds_base ds_1
ds_1 = Create dc_uo_ds_base

ds_1.DataObject = "ds_ge303_vendas_diversas"
ds_1.SetTransObject(SQLCA)

If lvl_Cd_Filial_dw1 > 0 Then
	ds_1.of_AppendWhere("n.cd_filial_origem = " + String(lvl_Cd_Filial_dw1))
End If

lvl_Total = ds_1.Retrieve(pdt_Inicio, pdt_Termino)

If lvl_Total > 0 Then
	Open(w_Aguarde)
	w_Aguarde.Title = "Atualizando Dados de Vendas do Per$$HEX1$$ed00$$ENDHEX$$odo..."
	w_Aguarde.uo_Progress.of_SetMax(lvl_Total)
End If

For lvl_Cont  = 1 To lvl_Total
	
	w_Aguarde.uo_Progress.of_SetProgress(lvl_Cont)
	
	lvl_Cd_Filial				= ds_1.Object.Cd_Filial			[lvl_Cont]
	lvs_Nm_Fantasia		= ds_1.Object.Nm_Fantasia		[lvl_Cont]
	lvdc_Vl_Total_Venda	= ds_1.Object.Vl_Total_NF		[lvl_Cont]
	
	lvl_Linha_dw2 = dw_2.Find("cd_filial = " + String(lvl_Cd_Filial), 1, dw_2.RowCount())
	
	If lvl_Linha_dw2 = 0 Then
		lvl_Linha_dw2 = dw_2.InsertRow(0)
	End If
	
	dw_2.Object.Vl_Venda_Patrimonio	[lvl_Linha_dw2] = lvdc_Vl_Total_Venda
Next

Destroy(ds_1)

If lvl_Total > 0 Then
	Close(w_Aguarde)
End If

Return True
end function

on w_ge303_rel_validacao_contabil.create
call super::create
end on

on w_ge303_rel_validacao_contabil.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;Date lvdt_Data

lvdt_Data = RelativeDate(Date(gf_GetServerDate()), -1)

dw_1.Object.Dt_Inicio[1] 		= lvdt_Data
dw_1.Object.Dt_Termino[1] 	= lvdt_Data

ivo_Filial = Create uo_Filial
end event

event close;call super::close;Destroy(ivo_Filial)
end event

event ue_saveas;call super::ue_saveas;dw_2.Event ue_SaveAs()
end event

event ue_preopen;call super::ue_preopen;//Tamanho ideal da tela para exibi$$HEX2$$e700e300$$ENDHEX$$o sem necessidade de Scroll
MaxWidth	= 8650

//Tamanho ideal da tela para exibi$$HEX2$$e700e300$$ENDHEX$$o sem necessidade de Scroll
//Neste caso como s$$HEX1$$e300$$ENDHEX$$o muitos registros o sistema ajusta ao m$$HEX1$$e100$$ENDHEX$$ximo poss$$HEX1$$ed00$$ENDHEX$$vel da tela
MaxHeight	= 9999
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge303_rel_validacao_contabil
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge303_rel_validacao_contabil
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge303_rel_validacao_contabil
integer y = 288
integer width = 4046
integer height = 1588
integer weight = 700
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge303_rel_validacao_contabil
integer width = 1554
integer height = 268
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge303_rel_validacao_contabil
integer x = 69
integer y = 80
integer width = 1513
integer height = 180
string dataobject = "dw_ge303_selecao"
boolean livescroll = false
end type

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)
end event

event dw_1::itemchanged;call super::itemchanged;Long    lvl_nulo
SetNull(lvl_Nulo)

Choose Case dwo.Name
	Case "nm_filial"
		If Trim(Data) <> "" Then
			If Data <> ivo_Filial.Nm_Fantasia Then
				Return 1
			End If
		Else
			This.Object.Cd_Filial[1] = lvl_Nulo
			ivo_Filial.Nm_Fantasia   = ''
		End If
End Choose
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then	
	Choose Case GetColumnName()			
		Case "nm_filial"
			ivo_Filial.Of_Localiza_Filial(dw_1.GetText())			
			
			If ivo_Filial.Localizada Then				
				dw_1.Object.Cd_Filial[1] 	= ivo_Filial.Cd_Filial
				dw_1.Object.Nm_Filial[1]	= ivo_Filial.Nm_Fantasia				
			End If
	End Choose
End If
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Filial) Then
	dw_1.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
End If
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge303_rel_validacao_contabil
integer y = 364
integer width = 3977
integer height = 1480
string dataobject = "dw_ge303_lista"
boolean hscrollbar = true
boolean hsplitscroll = true
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_recuperar;// OverRide

Date	lvdt_Inicio, &
		lvdt_Termino

dw_1.AcceptText()

lvdt_Inicio 		= dw_1.Object.Dt_Inicio		[1]
lvdt_Termino	= dw_1.Object.Dt_Termino	[1]

This.SetRedraw(False)

wf_Insere_Filiais()
wf_Insere_Pagamentos(lvdt_Inicio, lvdt_Termino) // Pagamentos CV,CC,CR 
wf_insere_Estorno_Caixas(lvdt_Inicio, lvdt_Termino) // Pagamentos CV,CC,CR  - Estornos
wf_Insere_Pagamentos_Conta_Credito(lvdt_Inicio, lvdt_Termino) // Pagamentos por Conta CV,CC,CR 
wf_Insere_Pagamentos_Conta_Debito(lvdt_Inicio, lvdt_Termino) // Pagamentos por Conta CV,CC,CR 
wf_Insere_VendasPBM(lvdt_Inicio, lvdt_Termino, 52575) // Vida Link - FPB
wf_Insere_VendasPBM(lvdt_Inicio, lvdt_Termino, 53724) // Vida Link - Copel
wf_Insere_VendasPBM(lvdt_Inicio, lvdt_Termino, 53725) // Vida Link - Diversos
wf_Insere_VendasPBM(lvdt_Inicio, lvdt_Termino, 52718) // e-Pharma
wf_Insere_VendasPBM(lvdt_Inicio, lvdt_Termino, 52349) // FuncionalCard
wf_Insere_Vendas1112(lvdt_Inicio, lvdt_Termino) // Vendas $$HEX1$$e000$$ENDHEX$$ Prazo CV,CC,CR 
wf_insere_vendas_diversas(lvdt_Inicio, lvdt_Termino) // Vendas Diversas (Patrim$$HEX1$$f400$$ENDHEX$$nio/Sucata)
wf_Insere_Devolucoes(lvdt_Inicio, lvdt_Termino, 51014) // CV Normais
wf_Insere_Devolucoes(lvdt_Inicio, lvdt_Termino, 53847) // CV PBMs
wf_Insere_Devolucoes(lvdt_Inicio, lvdt_Termino, 52602) // CC

This.SetSort("cd_filial")
This.Sort()
This.GroupCalc()

This.SetRedraw(True)

Return This.RowCount()
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;This.ivm_Menu.mf_SalvarComo(pl_Linhas > 0)

Return pl_Linhas
end event

event dw_2::ue_reset;call super::ue_reset;This.ivm_Menu.mf_SalvarComo(False)
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge303_rel_validacao_contabil
integer x = 2391
integer y = 56
integer height = 112
end type

