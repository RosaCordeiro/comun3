HA$PBExportHeader$w_ge205_cancelamento_notas_fiscais.srw
forward
global type w_ge205_cancelamento_notas_fiscais from dc_w_response
end type
type gb_1 from groupbox within w_ge205_cancelamento_notas_fiscais
end type
type dw_1 from dc_uo_dw_base within w_ge205_cancelamento_notas_fiscais
end type
type cb_fechar from commandbutton within w_ge205_cancelamento_notas_fiscais
end type
type cb_confirmar from commandbutton within w_ge205_cancelamento_notas_fiscais
end type
end forward

global type w_ge205_cancelamento_notas_fiscais from dc_w_response
integer x = 123
integer y = 424
integer width = 3346
integer height = 1540
string title = "GE205 - Cancelamento de Venda"
boolean controlmenu = false
gb_1 gb_1
dw_1 dw_1
cb_fechar cb_fechar
cb_confirmar cb_confirmar
end type
global w_ge205_cancelamento_notas_fiscais w_ge205_cancelamento_notas_fiscais

type variables

end variables

forward prototypes
public function boolean wf_cupom_selecionado ()
public function boolean wf_exclui_titulos_cr (long al_filial, long al_nf, string as_especie, string as_serie)
public subroutine wf_atualiza_matriz ()
public function boolean wf_cancela_lancamentos_nfce (long pl_filial, long pl_nf, string ps_especie, string ps_serie)
public function boolean wf_estorno_fcerta (long al_filial, long al_nf, string as_especie, string as_serie)
public function boolean wf_cancela_venda_poo (long al_filial, long al_nota, string as_especie, string as_serie)
public function boolean wf_atualiza_etiqueta_prestes (long al_filial, long al_nota, string as_especie, string as_serie)
end prototypes

public function boolean wf_cupom_selecionado ();Long lvl_Linha

lvl_Linha = dw_1.Find("id_cancelar = 'S'", 1, dw_1.RowCount())

If lvl_Linha > 0 Then
	Return True
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione pelo menos um cupom fiscal para o cancelamento.", Information!)
	Return False
End If
end function

public function boolean wf_exclui_titulos_cr (long al_filial, long al_nf, string as_especie, string as_serie);Boolean lvb_Sucesso = True

Long lvl_Total, &
     lvl_Contador
	  
String lvs_Cupom, &
       lvs_Titulo

dc_uo_ds_Base lvds_1
lvds_1 = Create dc_uo_ds_Base

If Not lvds_1.of_ChangeDataObject("ds_ge205_titulos_crediario") Then
	Destroy(lvds_1)
	Return False
End If

lvs_Cupom = String(al_Filial) + "/" + String(al_NF) + "/" + as_Especie + "/" + as_Serie

lvl_Total = lvds_1.Retrieve(al_Filial, al_NF, as_Especie, as_Serie)

If lvl_Total > 0 Then
	For lvl_Contador = 1 To lvl_Total
		lvs_Titulo = lvds_1.Object.Nr_Titulo[lvl_Contador]
		
		Delete From movimento_titulo_receber
		Where nr_titulo = :lvs_Titulo
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgdbError("Exclus$$HEX1$$e300$$ENDHEX$$o dos Movimentos do T$$HEX1$$ed00$$ENDHEX$$tulo '" + lvs_Titulo + "' do Cupom '" + lvs_Cupom + "'")
			lvb_Sucesso = False
			Exit
		End If
		
		Delete From titulo_receber
		Where nr_titulo = :lvs_Titulo
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgdbError("Exclus$$HEX1$$e300$$ENDHEX$$o do T$$HEX1$$ed00$$ENDHEX$$tulo '" + lvs_Titulo + "' do Cupom '" + lvs_Cupom + "'")
			lvb_Sucesso = False
			Exit
		End If
	Next
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Os t$$HEX1$$ed00$$ENDHEX$$tulos de credi$$HEX1$$e100$$ENDHEX$$rio referentes ao cupom '" + lvs_Cupom + "' n$$HEX1$$e300$$ENDHEX$$o foram localizados.", StopSign!)
	lvb_Sucesso = False
End If

Destroy(lvds_1)

Return lvb_Sucesso
end function

public subroutine wf_atualiza_matriz ();Long	lvl_Total		, &
		lvl_Contador, &
		lvl_Filial		, &
		lvl_NF
	  
String	lvs_Cancelar	, &
		lvs_Especie		, &
		lvs_Serie			, &
		lvs_Tipo_Venda, &
		lvs_Cliente		, &
		lvs_Cartao		, &
		lvs_Dependente, &
		lvs_Documento
		 
Decimal	lvdc_Total_NF, &
			lvdc_Pontos, &
			lvdc_pago_avista

DateTime lvdt_Dh_Movimento

uo_Cliente_Central lvo_Cliente
lvo_Cliente = Create uo_Cliente_Central

uo_Conveniado lvo_Conveniado
lvo_Conveniado = Create uo_Conveniado

w_Aguarde.Title = "Atualizando Banco de Dados da Matriz..."

lvl_Total = dw_1.RowCount()

w_Aguarde.uo_Progress.of_SetMax(lvl_Total)

For lvl_Contador = 1 To lvl_Total
	lvl_Filial     				= dw_1.Object.Cd_Filial						[lvl_Contador]
	lvl_NF         				= dw_1.Object.Nr_NF							[lvl_Contador]
	lvs_Especie    			= dw_1.Object.De_Especie					[lvl_Contador]
	lvs_Serie      			= dw_1.Object.De_Serie						[lvl_Contador]
	lvs_Tipo_Venda 		= dw_1.Object.Id_Tipo_Venda				[lvl_Contador]
	lvs_Cancelar   			= dw_1.Object.Id_Cancelar					[lvl_Contador]	
	lvdt_Dh_Movimento	= DateTime(dw_1.Object.Dh_Movimentacao_Caixa	[lvl_Contador])
	lvs_Cliente		   		= dw_1.Object.Cd_Cliente					[lvl_Contador]
	lvs_Dependente		= dw_1.Object.Cd_Cliente_Dependente	[lvl_Contador]
	lvs_Cartao				= dw_1.Object.Nr_Cartao_Clube			[lvl_Contador]
	lvdc_Total_NF			= dw_1.Object.Vl_Total_NF					[lvl_Contador]
	lvdc_Pontos				= dw_1.Object.Qt_Pontos_Clube			[lvl_Contador]
	lvdc_pago_avista		= dw_1.Object.Vl_Pago_avista				[lvl_Contador]
		
	If lvs_Cancelar = "S" Then
		If IsNull(lvdc_Pontos) Then lvdc_Pontos = 0 
		If lvs_Dependente = "" Then SetNull(lvs_Dependente)
		If lvs_Cartao     = "" Then SetNull(lvs_Cartao)
		If lvs_Cliente    = "" Then SetNull(lvs_Cliente)
		
		// Inclui o movimento de cancelamento da devolu$$HEX2$$e700e300$$ENDHEX$$o de venda na matriz
		If Not IsNull(lvs_Cliente) and lvdc_Pontos > 0 Then
			lvo_Cliente.of_Inclui_Movto_Venda_Devolucao(lvl_Filial, &
																	  lvl_NF, &
																	  lvs_Especie, &
																	  lvs_Serie, &
																	  lvdt_Dh_Movimento, &
																	  lvs_Cliente, &
																	  lvs_Dependente,	& 
																	  lvs_Cartao, &
																	  lvdc_Total_NF, &
																	  lvdc_Pontos, &
																	  "V", "S")
		End If
		
		// Inclui o movimento para controle do limite de cr$$HEX1$$e900$$ENDHEX$$dito online
		If Not IsNull(lvs_Cliente) and lvs_Tipo_Venda = "CC" Then
			lvs_Documento = String(lvl_Filial) + "/" + String(lvl_NF) + "/" + Trim(lvs_Especie) + "/" + Trim(lvs_Serie)
								 
			lvo_Cliente.of_Inclui_Movto_Credito_Online(lvs_Cliente, &
																	 lvl_Filial, &
																	 Date(lvdt_Dh_Movimento), &
																	 2, &
																	 lvdc_Total_NF - lvdc_pago_avista, &
																	 lvs_Documento)
		End If
		
		// Cancela a nota fiscal de conv$$HEX1$$ea00$$ENDHEX$$nio online (controle de limite de cr$$HEX1$$e900$$ENDHEX$$dito)
		If lvs_Tipo_Venda = "CV" Then
			lvo_Conveniado.of_Cancela_Venda_OnLine(lvl_Filial, &
													lvl_NF, &
													lvs_Especie, &
													lvs_Serie)
		End If
	End If
	
	w_Aguarde.uo_Progress.of_SetProgress(lvl_Contador)	
Next


Destroy(lvo_Cliente)
Destroy(lvo_Conveniado)
end subroutine

public function boolean wf_cancela_lancamentos_nfce (long pl_filial, long pl_nf, string ps_especie, string ps_serie);Boolean  lb_MF

Long     ll_filial,&
         ll_lancamento,&
		ll_conta_receita,&
		ll_conta_receb, &
		ll_pag, &
		ll_controle, &
		ll_convenio		

String ls_historico_receita, &
		ls_historico_receb, &
		ls_tipo_venda, &
		ls_caixa, &
		ls_forma_pagamento, &
		ls_convenio_vidalink
		
		 
DateTime ldh_movimentacao_caixa

Decimal {2} ldc_valor, &
				ldc_valor_prazo, &
				ldc_valor_avista, &
				ldc_valor_pagamento, &
				ldc_total_nf,&
				ldc_avista_nf

uo_controle_caixa lo_controle_caixa //GE020
lo_controle_caixa = Create uo_controle_caixa			
				
select id_tipo_venda, dh_movimentacao_caixa, cd_caixa, nr_controle_caixa, cd_forma_pagamento, vl_total_nf, vl_pago_avista, cd_convenio
  into :ls_tipo_venda, :ldh_movimentacao_caixa, :ls_caixa, :ll_controle, :ls_forma_pagamento, :ldc_total_nf, :ldc_avista_nf, :ll_convenio
  from nf_venda 
where cd_filial = :pl_filial
	and nr_nf = :pl_nf
	and de_especie = :ps_especie
	and de_serie = :ps_serie
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0 		
		ldc_valor = ldc_total_nf - ldc_avista_nf
		
		If (ls_tipo_venda = 'CC' or ls_tipo_venda = 'CV' or ls_tipo_venda = 'CR') And ldc_valor > 0 Then
			ll_conta_receita = 210
			ls_historico_receita = 'TOTAL VENDA PRAZO NFC-e/SAT'
			Choose Case ll_convenio
				Case 52349
					ll_conta_receb = 204
					ls_historico_receb = 'TOTAL PRAZO FUNCIONAL - NFC-e/SAT'
				Case 52718
					ll_conta_receb = 203
					ls_historico_receb = 'TOTAL PRAZO E-PHARMA - NFC-e/SAT'			
				Case 52575
					//Busca o conv$$HEX1$$ea00$$ENDHEX$$nio Vidalink para venda.
					select nr_comprovante_venda
					  into :ls_convenio_vidalink
					  from venda_pbm 
					where cd_filial = :pl_filial
						and nr_nf = :pl_nf
						and de_especie = :ps_especie
						and de_serie = :ps_serie
					Using SqlCa;
					
					If SqlCa.SqlCode = -1 Then
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro localiza$$HEX2$$e700e300$$ENDHEX$$o conv$$HEX1$$ea00$$ENDHEX$$nio Vidalink." + SqlCa.SqlErrText, StopSign!, Ok!)
						Return False
					End If	  			
					
					If Upper(Trim(ls_convenio_vidalink)) = 'AVFARPOP' Then
						ll_conta_receb = 200
						ls_historico_receb = 'TOTAL PRAZO VIDALINK POPULAR - NFC-e/SAT'
					ElseIf Upper(Trim(ls_convenio_vidalink)) = 'AVFCOPEL' Then
						ll_conta_receb = 201
						ls_historico_receb = 'TOTAL PRAZO VIDALINK COPEL - NFC-e/SAT'
					ElseIf (Upper(Trim(ls_convenio_vidalink)) = 'AVCOPMUC') and (ldh_movimentacao_caixa >= Datetime('2016/06/01')) Then
						ll_conta_receb = 201
						ls_historico_receb = 'TOTAL PRAZO VIDALINK COPEL - NFC-e/SAT'
					Else
						ll_conta_receb = 202
						ls_historico_receb = 'TOTAL PRAZO VIDALINK - NFC-e/SAT'
					End If
				Case Else
					ll_conta_receb = 211
					ls_historico_receb = 'TOTAL A RECEBER CONV/CLIENTE - NFC-e/SAT'						
			End Choose
		Else
			//verifica forma pagamento MF
			If ls_forma_pagamento = 'MF' Then		
				dc_uo_ds_base lds_pgto
				lds_pgto = Create dc_uo_ds_base				
				If Not lds_pgto.of_ChangeDataObject('ds_ge205_formas_pgto') Then Return False
			
				lds_pgto.of_RestoreSqlOriginal()
				lds_pgto.Retrieve(pl_filial,pl_nf,ps_especie,ps_serie)				
				If lds_pgto.RowCount() > 0 Then				
					For ll_pag = 1 TO lds_pgto.RowCount()
						Choose Case lds_pgto.Object.cd_forma_pagamento[ll_pag]
							Case 'CP', 'HP'
								ldc_valor_prazo = ldc_valor_prazo + lds_pgto.Object.vl_pagamento[ll_pag]
							Case Else
								ldc_valor_avista = ldc_valor_avista + lds_pgto.Object.vl_pagamento[ll_pag]
						End Choose
					Next
					Destroy(lds_pgto)
				Else
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o foram encontrados as formas de pagamento para NFC-e!" , StopSign!)			
					Return False
				End If		
			Else
				If ls_forma_pagamento = 'CP'  OR ls_forma_pagamento = 'HP' Then
					ll_conta_receita = 210
					ls_historico_receita = 'TOTAL VENDA PRAZO NFC-e/SAT'			
				Else
					ll_conta_receita = 209
					ls_historico_receita = 'TOTAL VISTA NFC-e/SAT'			
				End If
			End If
		End If
		
		If ldc_valor_prazo > 0 Or ldc_valor_avista > 0 Then
			If ldc_valor_prazo > 0 Then
				ll_conta_receita = 210		
				//Faz o lancamento de caixa do valor em ldc_valor_prazo		
				select nr_lancamento
				  into :ll_lancamento
				  from lancamento_caixa 
				where cd_caixa = :ls_caixa
					and nr_controle_caixa = :ll_controle
					and cd_conta_fluxo_caixa = :ll_conta_receita
				Using SqlCa;
				
				Choose Case SqlCa.SqlCode
					Case 0 //Econtrou, vai fazer update				
						Update lancamento_caixa
						Set vl_lancamento = vl_lancamento - :ldc_valor_prazo
						where cd_caixa = :ls_caixa
							and nr_controle_caixa = :ll_controle
							and nr_lancamento = :ll_lancamento
							and cd_conta_fluxo_caixa = :ll_conta_receita;
						  
						If SqlCa.SqlCode = -1 Then
							MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do lan$$HEX1$$e700$$ENDHEX$$amento de Caixa." + SqlCa.SqlErrText, StopSign!, Ok!)
							Return False
						End If		  				
						
					Case 100 // N$$HEX1$$e300$$ENDHEX$$o encontrou, vai inserir
						If Not lo_controle_caixa.of_insere_lancamento_caixa(ls_caixa,&
																							  ll_controle,&
																							  ll_conta_receita,&
																							  ldh_movimentacao_caixa,&
																							  - ldc_valor_prazo,&
																							  ls_historico_receita,&
																							  '') Then				
							MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel efetuar o lancamento no caixa: " + ls_caixa + " controle: " + String(ll_controle) )																													  
							Return False
						End If
					Case -1
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do controle do caixa." + SqlCa.SqlErrText, StopSign!)
						Return False
				End Choose	
			End If
			If ldc_valor_avista > 0 Then
				ll_conta_receita = 209
				//Faz o lancamento de caixa do valor em ldc_valor_avista
				select nr_lancamento
				  into :ll_lancamento
				  from lancamento_caixa 
				where cd_caixa = :ls_caixa
					and nr_controle_caixa = :ll_controle
					and cd_conta_fluxo_caixa = :ll_conta_receita
				Using SqlCa;
				
				Choose Case SqlCa.SqlCode
					Case 0 //Econtrou, vai fazer update				
						Update lancamento_caixa
						Set vl_lancamento = vl_lancamento - :ldc_valor_avista
						where cd_caixa = :ls_caixa
							and nr_controle_caixa = :ll_controle
							and nr_lancamento = :ll_lancamento
							and cd_conta_fluxo_caixa = :ll_conta_receita;
						  
						If SqlCa.SqlCode = -1 Then
							MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do lan$$HEX1$$e700$$ENDHEX$$amento de Caixa." + SqlCa.SqlErrText, StopSign!, Ok!)
							Return False
						End If		  				
						
					Case 100 // N$$HEX1$$e300$$ENDHEX$$o encontrou, vai inserir
						If Not lo_controle_caixa.of_insere_lancamento_caixa(ls_caixa,&
																							  ll_controle,&
																							  ll_conta_receita,&
																							  ldh_movimentacao_caixa,&
																							  - ldc_valor_avista,&
																							  ls_historico_receita,&
																							  '') Then				
							MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel efetuar o lancamento no caixa: " + ls_caixa + " controle: " + String(ll_controle) )																													  
							Return False
						End If
					Case -1
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do controle do caixa." + SqlCa.SqlErrText, StopSign!)
						Return False
				End Choose			
			End If	
		Else
			If ldc_valor = 0 Then
				ldc_valor = ldc_total_nf
			End If	
			//Faz lancamento conta receita com valor
			select nr_lancamento
			  into :ll_lancamento
			  from lancamento_caixa 
			where cd_caixa = :ls_caixa
				and nr_controle_caixa = :ll_controle
				and cd_conta_fluxo_caixa = :ll_conta_receita
			Using SqlCa;
			
			Choose Case SqlCa.SqlCode
				Case 0 //Econtrou, vai fazer update				
					Update lancamento_caixa
					Set vl_lancamento = vl_lancamento - :ldc_valor
					where cd_caixa = :ls_caixa
						and nr_controle_caixa = :ll_controle
						and nr_lancamento = :ll_lancamento
						and cd_conta_fluxo_caixa = :ll_conta_receita;
					  
					If SqlCa.SqlCode = -1 Then
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do lan$$HEX1$$e700$$ENDHEX$$amento de Caixa." + SqlCa.SqlErrText, StopSign!, Ok!)
						Return False
					End If		  				
					
				Case 100 // N$$HEX1$$e300$$ENDHEX$$o encontrou, vai inserir
					If Not lo_controle_caixa.of_insere_lancamento_caixa(ls_caixa,&
																						  ll_controle,&
																						  ll_conta_receita,&
																						  ldh_movimentacao_caixa,&
																						  - ldc_valor,&
																						  ls_historico_receita,&
																						  '') Then				
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel efetuar o lancamento no caixa: " + ls_caixa + " controle: " + String(ll_controle) )
						Return False
					End If
				Case -1
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do controle do caixa." + SqlCa.SqlErrText, StopSign!)
					Return False
			End Choose				
		
			If ll_conta_receb > 0 Then
				//Faz lancamento conta recebimento
				select nr_lancamento
				  into :ll_lancamento
				  from lancamento_caixa 
				where cd_caixa = :ls_caixa
					and nr_controle_caixa = :ll_controle
					and cd_conta_fluxo_caixa = :ll_conta_receb
				Using SqlCa;
				
				Choose Case SqlCa.SqlCode
					Case 0 //Econtrou, vai fazer update				
						Update lancamento_caixa
						Set vl_lancamento = vl_lancamento - :ldc_valor
						where cd_caixa = :ls_caixa
							and nr_controle_caixa = :ll_controle
							and nr_lancamento = :ll_lancamento
							and cd_conta_fluxo_caixa = :ll_conta_receb;
						  
						If SqlCa.SqlCode = -1 Then
							MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do lan$$HEX1$$e700$$ENDHEX$$amento de Caixa." + SqlCa.SqlErrText, StopSign!, Ok!)
							Return False
						End If		  				
						
					Case 100 // N$$HEX1$$e300$$ENDHEX$$o encontrou, vai inserir
						If Not lo_controle_caixa.of_insere_lancamento_caixa(ls_caixa,&
																							  ll_controle,&
																							  ll_conta_receb,&
																							  ldh_movimentacao_caixa,&
																							  - ldc_valor,&
																							  ls_historico_receb,&
																							  '') Then				
							MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel efetuar o lancamento no caixa: " + ls_caixa + " controle: " + String(ll_controle) )																													  
							Return False
						End If
					Case -1
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do controle do caixa." + SqlCa.SqlErrText, StopSign!)
						Return False
				End Choose					
			End If	
		End If		
		
	Case Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o da NFC-e." + SqlCa.SqlErrText, StopSign!)
		Return False
End Choose

Destroy(lo_controle_caixa)

Return True
end function

public function boolean wf_estorno_fcerta (long al_filial, long al_nf, string as_especie, string as_serie);Boolean lb_Sucesso = True

Long 	ll_Total, &
     	ll_Contador, &
	 	ll_registro, &
		ll_filial_fcerta, &
		ll_produto, &
		ll_retorno

String ls_integraFC

uo_Parametro_Filial lo_Parametro
lo_Parametro = Create uo_Parametro_Filial
lo_Parametro.of_Localiza_Parametro("ID_PERMITE_INTEGRACAO_FCERTA", ref ls_integraFC, False)
Destroy(lo_parametro)

If Trim(ls_integraFC) = 'N' Then Return True

dc_uo_ds_Base lvds_1
lvds_1 = Create dc_uo_ds_Base

If Not lvds_1.of_ChangeDataObject("ds_ge205_registro_manip") Then
	Destroy(lvds_1)
	Return False
End If

ll_Total = lvds_1.Retrieve(al_Filial, al_NF, as_Especie, as_Serie)

If ll_Total > 0 Then
	uo_ge119_formula_certa lo_FCerta
	lo_FCerta = Create uo_ge119_formula_certa	
	
	For ll_Contador = 1 To ll_Total
		ll_Produto 		= lvds_1.Object.cd_produto[ll_Contador]		
		ll_Registro		= lvds_1.Object.Nr_registro[ll_Contador]
		ll_filial_fcerta 	= lvds_1.Object.cd_filial_fcerta[ll_Contador]	
		
		If Not IsNull(ll_Filial_fcerta) And ll_filial_fcerta > 0 Then	
			If lo_FCerta.of_estornar_pagamento(ll_filial_fcerta, ll_registro, Ref ll_retorno) Then
				If ll_retorno = 0 Then
					gvo_Aplicacao.of_Grava_Log( "CANCELAMENTO CUPOM - Estorno Requis$$HEX2$$e700e300$$ENDHEX$$o FCerta com Sucesso! " + &
														" Requisicao [" + String(ll_registro) + "]" + & 
														", Filia_FCerta [" + String(ll_filial_fcerta) + "]")
				Else
					gvo_Aplicacao.of_Grava_Log( "CANCELAMENTO CUPOM - Erro no Estorno Requis$$HEX2$$e700e300$$ENDHEX$$o FCerta!" + &
														" Requisicao [" + String(ll_registro) + "]" + & 
														", Filia_FCerta [" + String(ll_filial_fcerta) + "]" + &
														", Retorno [" + String(ll_retorno) + "]")
				End If
			Else
				gvo_Aplicacao.of_Grava_Log( "CANCELAMENTO CUPOM - Erro no Estorno Requis$$HEX2$$e700e300$$ENDHEX$$o FCerta!" + &
													" Requisicao [" + String(ll_registro) + "]" + & 
													", Filia_FCerta [" + String(ll_filial_fcerta) + "]" + &
													", Retorno [" + String(ll_retorno) + "]")
			End If	
		Else
			gvo_Aplicacao.of_Grava_Log( "CANCELAMENTO CUPOM - Requisi$$HEX2$$e700e300$$ENDHEX$$o sem Filial FCerta para fazer o Estorno!" + &
												" Requisicao [" + String(ll_registro) + "]")		
		End If
		
	Next
	
	Destroy(lo_FCerta)
End If

Destroy(lvds_1)

Return lb_Sucesso
end function

public function boolean wf_cancela_venda_poo (long al_filial, long al_nota, string as_especie, string as_serie);update nf_venda_poo
	set id_situacao_pagamento = 'X'
 where cd_filial 						= :al_Filial
 	and nr_nf 							= :al_Nota
	and de_especie 					= :as_Especie
	and de_serie 						= :as_Serie
	and id_situacao_pagamento 	= 'P'
Using SqlCa;

If SqlCa.SqlCode = -1 Then
//	SqlCa.of_Rollback() --> Esta sendo feito fora desta fun$$HEX2$$e700e300$$ENDHEX$$o
	SqlCa.of_MsgDbError("Erro ao cancelar a venda POO. Chave: " + String(al_Nota) + '-'+as_Especie+'-'+as_Serie +'.')
	Return False
End If

Return True
end function

public function boolean wf_atualiza_etiqueta_prestes (long al_filial, long al_nota, string as_especie, string as_serie);update produto_preste_a_vencer
	set id_situacao = 'A',
		 cd_filial					= null,
		 nr_nf						= null,
		 de_especie				= null,
		 de_serie					= null,
		 dh_baixa				= null,
		 nr_matricula_baixa	= null,
		 id_tipo_baixa			= null
 where cd_filial		= :al_Filial
 	and nr_nf		= :al_Nota
	and de_especie	= :as_Especie
	and de_serie	= :as_Serie
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Erro ao atualizar etiqueta prestes. Chave: " + String(al_Nota) + '-'+as_Especie+'-'+as_Serie +'.')
	Return False
End If

Return True
end function

on w_ge205_cancelamento_notas_fiscais.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.dw_1=create dw_1
this.cb_fechar=create cb_fechar
this.cb_confirmar=create cb_confirmar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.cb_fechar
this.Control[iCurrent+4]=this.cb_confirmar
end on

on w_ge205_cancelamento_notas_fiscais.destroy
call super::destroy
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.cb_fechar)
destroy(this.cb_confirmar)
end on

event ue_postopen;call super::ue_postopen;dw_1.Event ue_Retrieve()

end event

event ue_preopen;call super::ue_preopen;If Not This.ib_Solicitou_Liberacao_Procedimento_Base  Then
	If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("W_GE205_CANCELAMENTO_NOTAS_FISCAIS", ref is_Matricula_Abertura_Tela) Then 
		This.il_Retorno = -1
		Return
	End If
End If
end event

type pb_help from dc_w_response`pb_help within w_ge205_cancelamento_notas_fiscais
end type

type gb_1 from groupbox within w_ge205_cancelamento_notas_fiscais
integer x = 23
integer y = 4
integer width = 3282
integer height = 1296
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Vendas Canceladas na Impressora"
borderstyle borderstyle = styleraised!
end type

type dw_1 from dc_uo_dw_base within w_ge205_cancelamento_notas_fiscais
integer x = 50
integer y = 60
integer width = 3214
integer height = 1224
boolean bringtotop = true
string dataobject = "ds_dw_ge205_lista"
boolean vscrollbar = true
end type

event ue_postretrieve;If pl_Linhas = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existem vendas para cancelar.", Information!)
	Close(Parent)
End If

Return pl_Linhas
end event

event constructor;call super::constructor;This.of_SetRowSelection()
end event

type cb_fechar from commandbutton within w_ge205_cancelamento_notas_fiscais
integer x = 2944
integer y = 1324
integer width = 361
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Fechar"
boolean cancel = true
end type

event clicked;Close(Parent)
end event

type cb_confirmar from commandbutton within w_ge205_cancelamento_notas_fiscais
integer x = 2555
integer y = 1324
integer width = 361
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Confirmar"
boolean default = true
end type

event clicked;Try
	uo_ge205_cancelamento lo_Cancelar
	lo_Cancelar = Create uo_ge205_cancelamento
	
	If lo_Cancelar.of_Cancelar( ) Then dw_1.Event ue_Retrieve()

Finally
	If IsValid( lo_Cancelar ) Then Destroy lo_Cancelar
End Try
end event

