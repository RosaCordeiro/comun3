HA$PBExportHeader$w_ge656_movimento_dinamico_cre.srw
forward
global type w_ge656_movimento_dinamico_cre from dc_w_selecao_lista_dinamica_relatorio
end type
end forward

global type w_ge656_movimento_dinamico_cre from dc_w_selecao_lista_dinamica_relatorio
integer width = 4311
integer height = 2204
string title = "GE656 - Relat$$HEX1$$f300$$ENDHEX$$rio Din$$HEX1$$e200$$ENDHEX$$mico Movimenta$$HEX2$$e700e300$$ENDHEX$$o CRE"
end type
global w_ge656_movimento_dinamico_cre w_ge656_movimento_dinamico_cre

type variables
Private:
uo_convenio 	ivo_convenio
uo_cliente 		ivo_cliente
uo_fornecedor 	ivo_fornecedor



end variables

on w_ge656_movimento_dinamico_cre.create
call super::create
end on

on w_ge656_movimento_dinamico_cre.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_preopen;call super::ue_preopen;//Instancia Objetos
ivo_convenio	= Create uo_convenio
ivo_cliente 		= Create uo_cliente
ivo_fornecedor	= Create uo_fornecedor

//Dimensionamento de tela
Maxwidth = 7716
Maxheight = 9999

//SQL Base para formar o grid
ivs_SQLBase = "from contas_receber_movimento m " + &
					"inner join contas_receber_tipo_movimento tm " + &
					"	on tm.cd_tipo_movimento = m.cd_tipo_movimento " + &
					"left outer join convenio cv " + &
					"	on cv.cd_convenio = case when m.id_tipo_conta = 'CV' then cast(m.cd_conta as integer) else null end " + &
					"	and m.id_tipo_conta = 'CV' " + &
					"left outer join cliente cl " + &
					"	on cl.cd_cliente = m.cd_conta " + &
					"	and m.id_tipo_conta <> 'CV' " + &
					"left outer join titulo_receber t " + &
					"	on m.id_tipo_conta = 'CR' " + &
					"	and t.nr_titulo = substring(m.nr_documento,1,4)||substring(m.nr_documento,6,7)||substring(m.nr_documento,14,2) " + &
					"left outer join nf_diversa nd " + &
					"	on nd.cd_filial_origem = t.cd_filial_nf " + &
					"	and nd.nr_nf = t.nr_nf " + &
					"	and nd.de_serie = t.de_serie " + &
					"	and nd.de_especie = t.de_especie " + &
					"left outer join ( " + &
					"		select  " + &
					"			cast(isap.cd_chave_legado as integer) cd_filial_origem, " + &
					"			j1.nfnum as nr_nf, " + &
					"			'NFE' de_especie, " + &
					"			j2.series as de_serie " + &
					"		from j_1bnfdoc_1 j1 " + &
					"			inner join j_1bnfdoc_2 j2 " + &
					"				on j2.mandt = j1.mandt  " + &
					"				and j2.docnum = j1.docnum  " + &
					"				and j2.nr_sequencial = j1.nr_sequencial " + &
					"				and j2.nftype = 'ZL' /* Venda de Ativo */ " + &
					"			inner join integracao_sap isap " + &
					"				on isap.cd_empresa = 1000 " + &
					"				and isap.cd_tabela = 'FILIAL' " + &
					"				and isap.cd_chave_sap = j1.branch " + &
					"	) as j_1bnfdoc " + &
					"		on j_1bnfdoc.cd_filial_origem = t.cd_filial_nf " + &
					"		and j_1bnfdoc.nr_nf = t.nr_nf " + &
					"		and j_1bnfdoc.de_serie = t.de_serie " + &
					"		and j_1bnfdoc.de_especie = t.de_especie " 
					
//C$$HEX1$$f300$$ENDHEX$$digo da Consulta no SybaseCentral
ivl_Consulta = 21
end event

event close;call super::close;Destroy( ivo_cliente )
Destroy( ivo_convenio	 )
Destroy( ivo_fornecedor )
end event

event ue_postopen;call super::ue_postopen;dw_1.Object.dt_posicao_ini	[1] = gf_primeiro_dia_mes(RelativeDate(gf_primeiro_dia_mes(Today()),-1))
dw_1.Object.dt_posicao_fim[1] = RelativeDate(gf_primeiro_dia_mes(Today()),-1)
//dw_1.Object.dh_lancto_ini	[1] = gf_primeiro_dia_mes(Today())
//dw_1.Object.dh_lancto_fim	[1] = Datetime(Today(),Now())

end event

type dw_visual from dc_w_selecao_lista_dinamica_relatorio`dw_visual within w_ge656_movimento_dinamico_cre
integer y = 2104
end type

type gb_aux_visual from dc_w_selecao_lista_dinamica_relatorio`gb_aux_visual within w_ge656_movimento_dinamico_cre
integer y = 2032
end type

type gb_2 from dc_w_selecao_lista_dinamica_relatorio`gb_2 within w_ge656_movimento_dinamico_cre
integer y = 740
integer width = 4210
integer height = 1256
end type

type gb_1 from dc_w_selecao_lista_dinamica_relatorio`gb_1 within w_ge656_movimento_dinamico_cre
integer width = 4215
integer height = 704
end type

type dw_1 from dc_w_selecao_lista_dinamica_relatorio`dw_1 within w_ge656_movimento_dinamico_cre
integer width = 4146
integer height = 612
string dataobject = "dw_ge656_selecao"
end type

event dw_1::ue_key;call super::ue_key;Boolean	lvb_Selecionado = False

String		lvs_Coluna, &
			lvs_Conta

lvs_Coluna = This.GetColumnName()

lvs_Conta = This.GetText()

If ( lvs_Coluna = "ds_conta" ) Then 
	
	If ( key = KeyEnter! ) Then
		
		// CV
		If This.Object.Id_CV[1] = 'S' Then		
			If Not IsNull(lvs_Conta) and TRIM(lvs_Conta) <> "" Then 
			
				ivo_Convenio.Of_Localiza_Convenio(lvs_Conta)
				
				If ( ivo_Convenio.Localizado ) Then
					This.Object.Cd_Conta[1] = String(ivo_Convenio.Cd_Convenio)
					This.Object.Ds_Conta[1] = ivo_Convenio.Nm_Fantasia
				End If
			End If
					
			lvb_Selecionado = True
		End If
		
		// CC
		If This.Object.Id_CC[1] = 'S' and Not lvb_Selecionado Then
			ivo_Cliente.ivs_Tipo_Cliente = "CC"
			
			ivo_Cliente.of_Localiza_CLiente(lvs_Conta)
			
			If ivo_Cliente.Localizado Then			
				dw_1.Object.Cd_Conta[1] = ivo_Cliente.Cd_Cliente
				dw_1.Object.Ds_Conta[1] = ivo_Cliente.Nm_Cliente	
			End If

			lvb_Selecionado = True					
		End If			
		
		// CR
		If This.Object.Id_CR[1] = 'S' and Not lvb_Selecionado Then
			ivo_Cliente.ivs_Tipo_Cliente = "CR"
			
			ivo_Cliente.of_Localiza_Cliente(lvs_Conta)
			
			If ivo_Cliente.Localizado Then			
				dw_1.Object.Cd_Conta[1] = ivo_Cliente.Cd_Cliente
				dw_1.Object.Ds_Conta[1] = ivo_Cliente.Nm_Cliente	
			End If
			
			lvb_Selecionado = True					
		End If			
		
		// FO
		If This.Object.Id_FO[1] = 'S' and Not lvb_Selecionado Then
			ivo_Fornecedor.of_Localiza_Fornecedor(lvs_Conta)
			
			If ivo_Fornecedor.Localizado Then
				dw_1.Object.Cd_Conta[1] = ivo_Fornecedor.Cd_Fornecedor
				dw_1.Object.Ds_Conta[1] = ivo_Fornecedor.Nm_Razao_Social
			End If			
		End If
	End If
End If
end event

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
		
	Case "ds_conta"
		If IsNull(Data) or Trim(Data) = "" Then		
			ivo_convenio.of_inicializa( )
			ivo_cliente.of_inicializa( )
			ivo_fornecedor.of_inicializa( )
			
			This.Object.ds_conta	[1] = ""
			This.Object.cd_conta	[1] = ""
			
		End If	
End Choose
end event

type dw_2 from dc_w_selecao_lista_dinamica_relatorio`dw_2 within w_ge656_movimento_dinamico_cre
integer y = 816
integer width = 4142
integer height = 1148
string title = "Relat$$HEX1$$f300$$ENDHEX$$rio Movimenta$$HEX2$$e700e300$$ENDHEX$$o CRE"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String 	lvs_CV, &
			lvs_CC, &
		 	lvs_CR, &
		 	lvs_FO, &
		 	lvs_LP, &
		 	lvs_PT, &
		 	lvs_VB, &
		 	lvs_Filtro, &
		 	lvs_Tipo_Movto, &
			lvs_Cd_Conta, &
			lvs_Considera_PBM

String 	lvs_tp_venda			, &
       		lvs_tp_canc_venda		, &
		 	lvs_tp_tx_entr			, &
		 	lvs_tp_canc_tx_entr	, &
		 	lvs_tp_alt_venda_cre	, &
			lvs_tp_alt_venda_deb	, &
		 	lvs_tp_alt_tx_cre		, &
		 	lvs_tp_alt_tx_deb		, &
			lvs_tp_fec_venda		, &
			lvs_tp_est_fec_venda	, &
			lvs_tp_abert_titulo		, &
			lvs_tp_est_abert_titulo, &
			lvs_tp_pag_titulo		, &
			lvs_tp_est_pag_titulo	, &
			lvs_tp_out_cre			, &
			lvs_tp_out_deb			, &
			lvs_tp_luc_perd_cre	, &
			lvs_tp_luc_perd_deb	, &
			lvs_vd_pago_avista	, &
			lvs_Id_Considera_Conv_DV, &
			lvs_Cd_Conta_SAP


Date lvdt_Posicao_ini
Date lvdt_Posicao_Fim
Datetime lvdh_Sistema_Ini
Datetime lvdh_Sistema_Fim

Boolean lvb_Ok = False

String lvs_SQL

lvs_SQL = This.GetSQLSelect()
lvs_SQL = gf_replace(lvs_SQL, "'cv'","'CV'",0)
lvs_SQL = gf_replace(lvs_SQL, "'cr'","'CR'",0)
lvs_SQL = gf_replace(lvs_SQL, "'nfe'","'NFE'",0)
lvs_SQL = gf_replace(lvs_SQL, "'zl'","'ZL'",0)
lvs_SQL = gf_replace(lvs_SQL, "'filial'","'FILIAL'",0)
This.SetSQLSelect(lvs_SQL)

dw_1.AcceptText()

lvdt_Posicao_ini			= dw_1.Object.dt_posicao_ini			[1]
lvdt_Posicao_Fim			= dw_1.Object.dt_posicao_fim			[1]
lvdh_Sistema_Ini			= dw_1.Object.dh_lancto_ini			[1]
lvdh_Sistema_Fim			= dw_1.Object.dh_lancto_fim			[1]
lvs_CV     		 			= dw_1.Object.Id_CV   				 	[1]
lvs_CC      					= dw_1.Object.Id_CC   				 	[1]
lvs_CR      					= dw_1.Object.Id_CR    					[1]
lvs_FO      					= dw_1.Object.Id_FO    					[1]
lvs_LP      					= dw_1.Object.Id_LP    					[1]
lvs_PT      					= dw_1.Object.Id_PT    					[1]
lvs_VB      					= dw_1.Object.Id_VB    					[1]
lvs_Cd_Conta				= dw_1.Object.Cd_Conta				[1]
lvs_Considera_PBM		= dw_1.Object.id_considerar_pbm	[1]
lvs_Tipo_Movto				= dw_1.Object.id_tipo_movto			[1]
lvs_tp_venda				= dw_1.Object.id_tp_venda				[1]
lvs_tp_canc_venda			= dw_1.Object.id_tp_canc_venda		[1]
lvs_tp_tx_entr				= dw_1.Object.id_tp_tx_entr			[1]
lvs_tp_canc_tx_entr		= dw_1.Object.id_tp_canc_tx_entr		[1]
lvs_tp_alt_venda_cre		= dw_1.Object.id_tp_alt_venda_cre	[1]
lvs_tp_alt_venda_deb		= dw_1.Object.id_tp_alt_venda_deb	[1]
lvs_tp_alt_tx_cre			= dw_1.Object.id_tp_alt_tx_cre		[1]
lvs_tp_alt_tx_deb			= dw_1.Object.id_tp_alt_tx_deb		[1]
lvs_tp_fec_venda			= dw_1.Object.id_tp_fec_venda		[1]
lvs_tp_est_fec_venda		= dw_1.Object.id_tp_est_fec_venda	[1]
lvs_tp_abert_titulo			= dw_1.Object.id_tp_abert_titulo		[1]
lvs_tp_est_abert_titulo	= dw_1.Object.id_tp_est_abert_titulo	[1]
lvs_tp_pag_titulo			= dw_1.Object.id_tp_pag_titulo		[1]
lvs_tp_est_pag_titulo		= dw_1.Object.id_tp_est_pag_titulo	[1]
lvs_tp_out_cre				= dw_1.Object.id_tp_out_cre			[1]
lvs_tp_out_deb				= dw_1.Object.id_tp_out_deb			[1]
lvs_tp_luc_perd_cre		= dw_1.Object.id_tp_luc_perd_cre	[1]
lvs_tp_luc_perd_deb		= dw_1.Object.id_tp_luc_perd_deb	[1]
lvs_vd_pago_avista		= dw_1.Object.id_vd_pago_avista		[1]
lvs_Id_Considera_Conv_DV= dw_1.Object.id_conv_devolucao	[1]
lvs_Cd_Conta_SAP			= dw_1.Object.cd_conta_sap			[1]

If IsNull(lvdt_Posicao_ini) or Not IsDate(String(lvdt_Posicao_ini, "dd/mm/yyyy")) Then
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Informe a data in$$HEX1$$ed00$$ENDHEX$$cio da movimenta$$HEX2$$e700e300$$ENDHEX$$o corretamente.", Exclamation!, YesNo!, 2) = 2 Then
		dw_1.Event ue_Pos(1, "dt_posicao_ini")
		Return -1
	End If
Else
	lvb_Ok = True
	This.Of_AppendWhere("m.dh_movimento >= '"+String(lvdt_Posicao_ini,"YYYY.MM.DD")+"'")
End If

If IsNull(lvdt_Posicao_fim) or Not IsDate(String(lvdt_Posicao_fim, "dd/mm/yyyy")) Then
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Data t$$HEX1$$e900$$ENDHEX$$rmino da movimenta$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o informada corretamente.~r~rDeseja continuar?", Exclamation!, YesNo!, 2) = 2 Then
		dw_1.Event ue_Pos(1, "dt_posicao_fim")
		Return -1
	End If
Else
	This.Of_AppendWhere("m.dh_movimento <= '"+String(lvdt_Posicao_fim,"YYYY.MM.DD")+"'")
End If

If IsNull(lvdh_Sistema_Ini) or Not IsDate(String(lvdh_Sistema_Ini, "dd/mm/yyyy")) Then
	If Not lvb_Ok Then
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Data de in$$HEX1$$ed00$$ENDHEX$$cio dos lan$$HEX1$$e700$$ENDHEX$$amentos n$$HEX1$$e300$$ENDHEX$$o informada corretamente.~r~rDeseja continuar?", Exclamation!, YesNo!, 2) = 2 Then
			dw_1.Event ue_Pos(1, "dh_lancto_ini")
			Return -1
		End If
	End If
Else
	This.Of_AppendWhere("m.dh_sistema >= '"+String(lvdh_Sistema_Ini,"YYYY.MM.DD HH:MM")+"'")
End If

If IsNull(lvdh_Sistema_Fim) or Not IsDate(String(lvdh_Sistema_Fim, "dd/mm/yyyy"))  Then
	If Not lvb_Ok Then
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Data de t$$HEX1$$e900$$ENDHEX$$rmino dos lan$$HEX1$$e700$$ENDHEX$$amentos n$$HEX1$$e300$$ENDHEX$$o informada corretamente.", Exclamation!, YesNo!, 2) = 2 Then
			dw_1.Event ue_Pos(1, "dh_lancto_fim")
			Return -1
		End If
	End If
Else
	This.Of_AppendWhere("m.dh_sistema <= '"+String(lvdh_Sistema_Fim,"YYYY.MM.DD HH:MM")+"'")
End If

This.ivs_filtro_relatorio [ UpperBound(This.ivs_filtro_relatorio) + 1] = "Movimenta$$HEX2$$e700e300$$ENDHEX$$o: "+String(lvdt_Posicao_ini, "DD/MM/YYYY")+" $$HEX1$$e000$$ENDHEX$$ "+String(lvdt_Posicao_fim, "DD/MM/YYYY")
This.ivs_filtro_relatorio [ UpperBound(This.ivs_filtro_relatorio) + 1] = "Data/Hora Lan$$HEX1$$e700$$ENDHEX$$amento: "+String(lvdh_Sistema_Ini, "DD/MM/YYYY HH:MM")+" $$HEX1$$e000$$ENDHEX$$ "+String(lvdh_Sistema_Fim, "DD/MM/YYYY HH:MM")

If lvs_CV = "N" and lvs_CC = "N" and lvs_VB = "N" and lvs_CR = "N" and lvs_FO = "N" and lvs_LP = "N" and lvs_PT = "N" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Selecione pelo menos um tipo de conta.", Exclamation!)
	dw_1.Event ue_Pos(1, "id_cv")
	Return -1
End If

lvs_Filtro = ""
If lvs_CV = "S" Then lvs_Filtro += IIF(lvs_Filtro <> "", ",", "")+"'CV'"
If lvs_CC = "S" Then lvs_Filtro += IIF(lvs_Filtro <> "", ",", "")+"'CC'"
If lvs_FO = "S" Then lvs_Filtro += IIF(lvs_Filtro <> "", ",", "")+"'FO'"
If lvs_LP = "S" Then lvs_Filtro += IIF(lvs_Filtro <> "", ",", "")+"'LP'"
If lvs_CR = "S" or lvs_PT = "S" or lvs_VB = "S" Then lvs_Filtro += IIF(lvs_Filtro <> "", ",", "")+"'CR'"

If lvs_Filtro <> "" Then
	This.Of_AppendWhere("m.id_tipo_conta in ("+lvs_Filtro+")")
End If

If lvs_PT = "S" Then
	If lvs_CR = "N" Then
		If lvs_VB = "N" Then
			This.Of_AppendWhere("((m.id_tipo_conta = 'CR' and (nd.nr_nf is not null or j_1bnfdoc.nr_nf is not null)) or (m.id_tipo_conta <>'CR'))")
		Else
			This.Of_AppendWhere("((m.id_tipo_conta = 'CR' and (nd.nr_nf is not null or j_1bnfdoc.nr_nf is not null or t.nr_conta_sap='0011201067' or m.id_tipo_lancto='1')) or (m.id_tipo_conta <>'CR'))")			
		End If
	End If
ElseIf Pos(lvs_Filtro, 'CR') > 0 Then
	This.Of_AppendWhere("(nd.nr_nf is null and j_1bnfdoc.nr_nf is null)")
End If

//Trazer movimentos de verba
If lvs_VB = 'S' Then
	If lvs_CR = "N" Then
		If lvs_PT = "N" Then
			This.Of_AppendWhere("(m.id_tipo_conta <> 'CR' or (m.id_tipo_conta = 'CR' and (t.nr_conta_sap='0011201067' or m.id_tipo_lancto='1')))")		
		Else
			This.Of_AppendWhere("((m.id_tipo_conta = 'CR' and (nd.nr_nf is not null or j_1bnfdoc.nr_nf is not null or t.nr_conta_sap='0011201067' or m.id_tipo_lancto='1')) or (m.id_tipo_conta <>'CR'))")			
		End If
	End If
//Se tiver algum outro tipo de CR (CR=Credi$$HEX1$$e100$$ENDHEX$$rio ou PT=Patrim$$HEX1$$f400$$ENDHEX$$nio)
ElseIf Pos(lvs_Filtro, 'CR') > 0 Then
	This.Of_AppendWhere("coalesce(t.nr_conta_sap,'')<>'0011201067' and coalesce(m.id_tipo_lancto,'')<>'1'")			
End If

If Not IsNull(lvs_Cd_Conta) and lvs_Cd_Conta <> '' Then
	This.of_AppendWhere("m.cd_conta='" + lvs_Cd_Conta + "'")
End If

If Not IsNull(lvs_Cd_Conta_SAP) and lvs_Cd_Conta_SAP <> '' Then
	If lvs_CV = "S" Then
		This.of_AppendWhere("cv.cd_cliente_sap='" + lvs_Cd_Conta_SAP + "'")
	End If 
	
	If lvs_CR = "S" or lvs_CC = "S" Then
		This.of_AppendWhere("cl.cd_cliente_sap='" + lvs_Cd_Conta_SAP + "'")
	End If
End If

If lvs_Considera_PBM = "N" Then
	If lvs_CV = "S" Then	
		This.of_AppendWhere("m.cd_conta not in ('52575', '53724', '53725', '52349' ,'52718','53847')")
	End If
End If

If lvs_Tipo_Movto <> "T" Then
	This.Of_AppendWhere("tm.id_atualizacao_saldo = '"+lvs_Tipo_Movto+"'")	
End If

/*Filtro tipos de movimento */
If lvs_tp_venda = "N" Then
	This.of_AppendWhere("tm.id_venda='N'")
End If 

If lvs_tp_canc_venda = "N" Then
	This.of_AppendWhere("tm.id_cancelamento_venda='N'")
End If 

If lvs_tp_tx_entr = "N" Then
	This.of_AppendWhere("tm.id_taxa_entrega='N'")
End If 

If lvs_tp_canc_tx_entr = "N" Then
	This.of_AppendWhere("tm.id_cancelamento_taxa_entrega='N'")
End If 

If lvs_tp_alt_venda_cre = "N" Then
	This.of_AppendWhere("tm.id_alteracao_venda_credito='N'")
End If 

If lvs_tp_alt_venda_deb = "N" Then
	This.of_AppendWhere("tm.id_alteracao_venda_debito='N'")
End If 

If lvs_tp_alt_tx_cre = "N" Then
	This.of_AppendWhere("tm.id_alteracao_taxa_credito='N'")
End If 

If lvs_tp_alt_tx_deb = "N" Then
	This.of_AppendWhere("tm.id_alteracao_taxa_debito='N'")
End If 

If lvs_tp_fec_venda = "N" Then
	This.of_AppendWhere("tm.id_fechamento_vendas='N'")
End If 

If lvs_tp_est_fec_venda = "N" Then
	This.of_AppendWhere("tm.id_estorno_fechamento_vendas='N'")
End If 

If lvs_tp_abert_titulo = "N" Then
	This.of_AppendWhere("tm.id_abertura_titulo='N'")
End If 

If lvs_tp_est_abert_titulo = "N" Then
	This.of_AppendWhere("tm.id_estorno_abertura_titulo='N'")
End If 

If lvs_tp_pag_titulo = "N" Then
	This.of_AppendWhere("tm.id_pagamento_titulo='N'")
End If 

If lvs_tp_est_pag_titulo = "N" Then
	This.of_AppendWhere("tm.id_estorno_pagamento_titulo='N'")
End If 

If lvs_tp_out_cre = "N" Then
	This.of_AppendWhere("tm.id_outro_credito='N'")
End If 

If lvs_tp_out_deb = "N" Then
	This.of_AppendWhere("tm.id_outro_debito='N'")
End If 

If lvs_tp_luc_perd_cre = "N" Then
	This.of_AppendWhere("tm.id_lucro_perda_credito='N'")
End If 

If lvs_tp_luc_perd_deb = "N" Then
	This.of_AppendWhere("tm.id_lucro_perda_debito='N'")
End If 

If lvs_vd_pago_avista = "N" Then
	This.of_AppendWhere( "not exists (select 1 "													+ &
												"from titulo_receber t1 (index pk_titulo_receber) "	+ &
												"inner join nf_venda nv1 (index pk_nf_venda) "		+ &
												"	on nv1.cd_filial = t1.cd_filial_nf "					+ &
												"	and nv1.nr_nf = t1.nr_nf "							+ &
												"	and nv1.de_serie = t1.de_serie "					+ &
												"	and nv1.de_especie = t1.de_especie "			+ &
												"	and ((nv1.id_tipo_venda = 'CV') or (nv1.vl_pago_avista = t1.vl_nominal)) "		+ &
												"where t1.nr_titulo = substring(m.nr_documento,1,4)||substring(m.nr_documento,6,7)||substring(m.nr_documento,14,2))")
End If

If lvs_Id_Considera_Conv_DV = 'N' Then
	This.of_AppendWhere("m.cd_conta not in ('51014', '52602', '53847')")
End if

Return AncestorReturnValue
end event

type dw_3 from dc_w_selecao_lista_dinamica_relatorio`dw_3 within w_ge656_movimento_dinamico_cre
integer x = 1705
integer y = 60
integer width = 279
integer height = 156
end type

type dw_campos from dc_w_selecao_lista_dinamica_relatorio`dw_campos within w_ge656_movimento_dinamico_cre
integer x = 3799
integer y = 860
integer width = 311
integer height = 156
end type

type st_dica from dc_w_selecao_lista_dinamica_relatorio`st_dica within w_ge656_movimento_dinamico_cre
integer y = 936
end type

