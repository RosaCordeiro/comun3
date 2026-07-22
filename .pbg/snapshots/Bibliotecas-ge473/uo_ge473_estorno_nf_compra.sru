HA$PBExportHeader$uo_ge473_estorno_nf_compra.sru
forward
global type uo_ge473_estorno_nf_compra from nonvisualobject
end type
end forward

global type uo_ge473_estorno_nf_compra from nonvisualobject
end type
global uo_ge473_estorno_nf_compra uo_ge473_estorno_nf_compra

type variables
String is_de_chave_acesso_sap

long il_ano_documento
datetime idt_dt_documento
string is_log_criacao_doc
string is_nr_documento
string is_nr_solicitacao

Boolean ib_execucao_simultanea = False, ib_sucesso = False
		
end variables

forward prototypes
public subroutine of_processa_atualizacao (long al_tabela)
public function boolean of_estorna_nf_compra (long al_controle, long al_tabela)
public function boolean of_estorno_nf_compra (uo_ge473_comum acomum, ref string as_log)
public function boolean wf_valida_nf_compra_filial_java (long al_filial, string as_fornecedor, long al_nr_nf, string as_especie, string as_serie, string as_chave_acesso, ref string as_filial_java, ref string as_log)
public function boolean wf_verifica_devolucao_compra_filial (long al_filial, string as_fornecedor, long al_nr_nf, string as_especie, string as_serie, string as_chave_acesso, ref string as_nota_excluida, ref string as_log)
public function boolean wf_atualiza_resumo_compra (datetime adt_movimentacao, long al_filial, long al_produto, long al_qtde, string as_fornecedor, decimal adc_total_produtos, decimal adc_descontos, decimal adc_preco_unitario, decimal adc_pc_desconto, decimal adc_icms_st, decimal adc_ipi, decimal adc_outras_despesas, string as_chave_acesso, ref string as_log)
public function boolean wf_atualiza_resumo_pedido (date adt_pedido, string as_uf, string as_distribuidora, string as_fornecedor, decimal adc_valor, long al_qtde, string as_chave_acesso, ref string as_log)
public function boolean wf_exclui_item_nf_compra_lote (long al_filial, string as_fornecedor, long al_nf, string as_especie, string as_serie, long al_natoperacao, long al_produto, string as_compra_confirmada, string as_chave_acesso, ref string as_log)
public function boolean wf_exclui_item_nf_compra (long al_filial, string as_fornecedor, long al_nf, string as_especie, string as_serie, long al_natope, long al_produto, string as_nota_confirmada, string as_chave_acesso, ref string as_log)
public function boolean wf_exclui_movimento_estoque (long al_filial, string as_fornecedor, long al_nf, string as_especie, string as_serie, long al_produto, datetime adh_data_caixa, long al_faturada, long al_qtde_recebida, string as_nota_confirmada, string as_chave_acesso, ref string as_log)
public function boolean wf_exclui_titulo_pagar (long al_filial, string as_fornecedor, long al_nf, string as_especie, string as_serie, string as_nota_confirmada, string as_chave_acesso, ref string as_log)
public function boolean wf_exclui_nf_compra (long al_filial, string as_fornecedor, long al_nf, string as_especie, string as_serie, string as_nota_confirmada, string as_chave_acesso, ref string as_log)
public function boolean wf_atualiza_resumo_movimento (long al_filial, datetime adh_data_caixa, decimal adc_valor, string as_nota_confirmada, string as_chave_acesso, ref string as_log)
public function boolean wf_atualiza_log_exportacao (long al_filial, string as_fornecedor, long al_nf, string as_especie, string as_serie, string as_nota_confirmada, string as_chave_acesso, ref string as_log)
public function boolean wf_inclui_log_exclusao (long al_filial, string as_fornecedor, long al_nota, string as_especie, string as_serie, datetime adt_movimento, decimal adc_valor, long al_pedido, string as_chave_acesso, string as_motivo, string as_nota_confirmada, ref string as_log)
public function boolean of_cancela_recebimento (string as_de_chave_acesso, ref string as_log)
end prototypes

public subroutine of_processa_atualizacao (long al_tabela);Long ll_Linhas
Long ll_Linha, ll_nr_controle, ll_controles_gerando

dc_uo_ds_base lds 

try 
	
	lds  = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject('ds_ge473_lista_controles', False) Then 
		gvo_aplicacao.of_grava_log("Interface Estorno NF Compra - Erro alterar a DW [ds_ge473_lista_controles] - uo_ge473_estorno_nf_compra.of_processa_atualizacao" )
		Return
	End If
	
	ll_Linhas = lds.Retrieve(al_Tabela)
	
	If ll_Linhas > 0 Then
		For ll_Linha = 1 To ll_Linhas
			
			if ib_execucao_simultanea = True Then
				//
			else
			
				uo_ge473_estorno_nf_compra	lo_estorno_nf_compra
				 
				Try
					lo_estorno_nf_compra	= Create uo_ge473_estorno_nf_compra
					lo_estorno_nf_compra.of_estorna_nf_compra( lds.Object.nr_controle[ll_Linha],al_tabela )
	
				Finally
					Destroy(uo_ge473_estorno_nf_compra)
				End Try			
			
			end if
			
		Next
	ElseIf ll_Linhas < 0 Then
		gvo_aplicacao.of_grava_log("Interface Estorno NF Compra - Erro ao recuperar os da DW [ds_ge473_lista_controles] - uo_ge473_estorno_nf_compra.of_processa_atualizacao.")
	End If	
	
finally
	Destroy lds
end try
end subroutine

public function boolean of_estorna_nf_compra (long al_controle, long al_tabela);Boolean 	lb_Sucesso = False
Long 		ll_Atualizacao_Pend, ll_Linhas, ll_for
String 	ls_Log, ls_Chave_Controle


Try
	uo_ge473_comum lo_Comum
	lo_Comum = Create uo_ge473_comum
			
	select de_chave_sap
	  into :is_de_chave_acesso_sap
	  from interface_sap  i 
	 where i.cd_tabela 	= :al_tabela
		and i.nr_controle = :al_controle
	Using SqlCa;	
	
	If SqlCa.sqlcode = -1 Then
		ls_Log = "Erro ao buscar o controle na tabela interface_sap. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle)+". Erro: "+SqlCa.sqlErrText
		Return False
	End If	

	If Not lo_Comum.of_atualizacao_pendente(al_Controle, Ref ll_Atualizacao_Pend, Ref ls_Log) Then Return False

	//Controle j$$HEX1$$e100$$ENDHEX$$ foi processado
	If ll_Atualizacao_Pend = 0 Then Return True
	
	If Not lo_Comum.of_Muda_Situacao_Interface(al_Controle, Ref ls_Log) Then Return False
	If Not lo_Comum.of_localiza_chave_controle(al_Controle, Ref ls_Chave_Controle, Ref ls_Log) Then Return False
	
	If lo_Comum.of_processa_carrega_dados(al_controle , ref ls_Log) Then
		
		ll_Linhas = lo_Comum.ids_lista_registros.RowCount()
		
		if isvalid(w_aguarde_3) Then
			w_aguarde_3.uo_progress_2.of_reset()
			w_aguarde_3.uo_progress_2.of_setmax(ll_linhas)
		end if
		
		if isvalid(w_aguarde_3) Then
			w_aguarde_3.wf_settext('Solicita$$HEX2$$e700e300$$ENDHEX$$o: ' + is_nr_solicitacao , 3 )
		end if
		
		this.of_estorno_nf_compra(lo_Comum, Ref ls_Log)
		
		lb_Sucesso	= ib_sucesso
								
		if isvalid(w_aguarde_3) Then
			w_aguarde_3.uo_progress_2.of_setprogress(1)
		end if	
	End If
Catch ( runtimeerror  lo_rte )
	ls_Log = "Objeto [uo_ge473_estorno_nf_compra], fun$$HEX2$$e700e300$$ENDHEX$$o [of_estorna_nf_compra]. Erro: "+lo_rte.GetMessage( )
	Return False		
Finally
	If lb_Sucesso Then
		SqlCa.of_Commit()
	Else
		SqlCA.of_RollBack()
		lo_Comum.of_grava_erro(al_controle, 179, ls_Log)
	End If
	
	Destroy lo_Comum	
End Try

Return True
end function

public function boolean of_estorno_nf_compra (uo_ge473_comum acomum, ref string as_log);Boolean			lb_sucesso	= False, lb_encontrou_nf_servico = False
Date				ld_dh_emissao
DateTime			ldt_data_estorno, ldt_dh_movimento_caixa, ldt_atual
Dec{2}			ldc_vl_total_nf, ldc_vl_total_produtos, ldc_vl_desconto, ldc_vl_preco_unitario, ldc_pc_desconto, &
					ldc_vl_icms_st, ldc_vl_ipi, ldc_vl_outras_despesas, ldc_vl_custo_pedido, ldc_Valor_Resumo
Long				ll_for, ll_nr_nf, ll_cd_filial, ll_nr_pedido_distribuidora, ll_cd_produto, ll_qt_faturada, &
					ll_qt_faturada_item, ll_cd_natureza_operacao, ll_qt_recebida
String			ls_cd_fornecedor_sap, ls_centro_origem, ls_motivo, ls_nf_confirmada, ls_nr_chave_acesso, &
		   		ls_cd_fornecedor, ls_de_especie, ls_de_serie, ls_cd_chave_legado, ls_filial_java, &
					ls_nota_excluida, ls_distribuidora, ls_fornecedor_usual, ls_uf
dc_uo_ds_Base	lvds_1


ldt_atual	= gf_getserverdate()

for ll_for = 1 to aComum.ids_lista_registros.RowCount()
	ls_cd_fornecedor_sap	= aComum.ids_lista_registros.Object.cd_fornecedor_sap[ll_for]
	ls_centro_origem		= aComum.ids_lista_registros.Object.centro_origem[ll_for]
	ldt_data_estorno		= DateTime(aComum.ids_lista_registros.Object.data_estorno[ll_for])
	ls_motivo				= aComum.ids_lista_registros.Object.motivo[ll_for]
	ls_nf_confirmada		= aComum.ids_lista_registros.Object.nf_confirmada[ll_for]
	ls_nr_chave_acesso	= aComum.ids_lista_registros.Object.nr_chave_acesso[ll_for]
	ll_nr_nf					= Long(aComum.ids_lista_registros.Object.nr_nf[ll_for])
	ls_de_serie				= aComum.ids_lista_registros.Object.nr_serie[ll_for]
	
	if IsNull(ls_nf_confirmada) then ls_nf_confirmada = ''
	
	if ldt_data_estorno > ldt_atual then
		as_log	= 'Data de estorno maior do que a data atual. Chave de Acesso: ' + ls_nr_chave_acesso + ' Erro: ' + SQLCA.SQLErrText
		ib_sucesso	= False
		Return ib_sucesso
	end if
	
	select cd_chave_legado
	  into :ls_cd_chave_legado
	  from integracao_sap 
	 where cd_tabela 		= 'FILIAL' and
	 		 cd_chave_sap 	= :ls_centro_origem;
			  
	choose case SQLCA.SQLCode
		Case -1
			as_log	= 'Erro ao buscar a chave do legado. Chave de Acesso: ' + ls_nr_chave_acesso
			ib_sucesso	= False
			Return ib_sucesso
		Case 100
			as_log	= 'N$$HEX1$$e300$$ENDHEX$$o foi p$$HEX1$$f300$$ENDHEX$$ss$$HEX1$$ed00$$ENDHEX$$vel encontrar a chave do legado. Chave de Acesso: ' + ls_nr_chave_acesso
			ib_sucesso	= False
			Return ib_sucesso
	End Choose
	
	ls_de_serie	= String(Long(ls_de_serie))
	
	if ll_nr_nf > 0 and ls_de_serie <> '' and not IsNull(ls_de_serie) then
		select cd_fornecedor
		  into :ls_cd_fornecedor
		  from fornecedor
		 where cd_fornecedor_sap = :ls_cd_fornecedor_sap;
		 
		Choose case SQLCA.SQLCode
			Case -1
				as_log	= 'Erro ao buscar o c$$HEX1$$f300$$ENDHEX$$digo do fornecedor.'
				ib_sucesso	= False
				Return ib_sucesso
			Case 100
				as_log	= 'N$$HEX1$$e300$$ENDHEX$$o foi p$$HEX1$$f300$$ENDHEX$$ss$$HEX1$$ed00$$ENDHEX$$vel encontrar o c$$HEX1$$f300$$ENDHEX$$digo do legado do fornecedor.'
				ib_sucesso	= False
				Return ib_sucesso
		End Choose

		select nr_nf,
				 cd_fornecedor,
				 de_especie,
				 de_serie,
				 cd_filial,
				 dh_movimentacao_caixa,
				 vl_total_nf,
				 nr_pedido_distribuidora
		  into :ll_nr_nf,
				 :ls_cd_fornecedor,
				 :ls_de_especie,
				 :ls_de_serie,
				 :ll_cd_filial,
				 :ldt_dh_movimento_caixa,
				 :ldc_vl_total_nf,
				 :ll_nr_pedido_distribuidora
		  from nf_compra
		 where nr_nf 		= :ll_nr_nf
		 	and de_serie 	= :ls_de_serie
			and cd_filial 	= 534
			and de_especie	= 'NFS'
			and cd_fornecedor = :ls_cd_fornecedor;
			
		Choose case SQLCA.SQLCode
			Case -1
				as_log	= 'Erro ao buscar a nota de servi$$HEX1$$e700$$ENDHEX$$o.'
				ib_sucesso	= False
				Return ib_sucesso
			Case 100
				lb_encontrou_nf_servico = false
			Case 0
				lb_encontrou_nf_servico = true
		End Choose
	end if
	
	if not lb_encontrou_nf_servico then
		if ls_nf_confirmada = 'X' then
			select nr_nf,
					 cd_fornecedor,
					 de_especie,
					 de_serie,
					 cd_filial,
					 dh_movimentacao_caixa,
					 vl_total_nf,
					 nr_pedido_distribuidora
			  into :ll_nr_nf,
					 :ls_cd_fornecedor,
					 :ls_de_especie,
					 :ls_de_serie,
					 :ll_cd_filial,
					 :ldt_dh_movimento_caixa,
					 :ldc_vl_total_nf,
					 :ll_nr_pedido_distribuidora
			  from nf_compra
			 where de_chave_acesso	= :ls_nr_chave_acesso;
		else
			select nr_nf,
					 cd_fornecedor,
					 de_especie,
					 de_serie,
					 cd_filial,
					 dh_movimentacao_caixa,
					 vl_total_nf,
					 nr_pedido
			  into :ll_nr_nf,
					 :ls_cd_fornecedor,
					 :ls_de_especie,
					 :ls_de_serie,
					 :ll_cd_filial,
					 :ldt_dh_movimento_caixa,
					 :ldc_vl_total_nf,
					 :ll_nr_pedido_distribuidora
			  from nf_compra_pendente
			 where de_chave_acesso	= :ls_nr_chave_acesso;
		end if
		 
		choose case SQLCA.SQLCode
			Case -1
				if ls_nf_confirmada = 'X' then
					as_log	= 'Erro ao buscar dados da nota de compra. Chave de Acesso: ' + ls_nr_chave_acesso + ' Erro: ' + SQLCA.SQLErrText
				else
					as_log	= 'Erro ao buscar dados da nota de compra pendente. Chave de Acesso: ' + ls_nr_chave_acesso + ' Erro: ' + SQLCA.SQLErrText
				end if
				
				ib_sucesso	= False
				Return ib_sucesso
			Case 100
				if ls_nf_confirmada = 'X' then
					as_log	= 'N$$HEX1$$e300$$ENDHEX$$o foram encontrados dados referentes a nota de compras pela chave de acesso: ' + ls_nr_chave_acesso + '. ' + SQLCA.SQLErrText
				else
					as_log	= 'N$$HEX1$$e300$$ENDHEX$$o foram encontrados dados referentes a nota de compras pendente pela chave de acesso: ' + ls_nr_chave_acesso + '. ' + SQLCA.SQLErrText
				end if
				
				ib_sucesso	= False
				Return ib_sucesso
		End Choose
	End if
		
	if Long(ls_cd_chave_legado) <> ll_cd_filial then
		as_log	= 'A filial vinda do SAP n$$HEX1$$e300$$ENDHEX$$o corresponde a filial da nota encontrada no legado. ' + 'Empresa legado: ' + String(ll_cd_filial) + ' Empresa SAP: ' + ls_cd_chave_legado + ' Chave de Acesso: ' + ls_nr_chave_acesso
		ib_sucesso	= False
		Return ib_sucesso
	end if
	
	if ll_cd_filial = 534 and ls_de_especie <> 'NFS' then
		as_log	= 'N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel deletar notas do CD. Chave de Acesso: ' + ls_nr_chave_acesso
		ib_sucesso	= False
		Return ib_sucesso
	end if
	
	if ls_nf_confirmada = 'X' then
		if not wf_valida_nf_compra_filial_java(ll_cd_filial, ls_cd_fornecedor, ll_nr_nf, ls_de_especie, ls_de_serie, ls_nr_chave_acesso, ls_filial_java, as_log) then
			ib_sucesso	= False
			Return ib_sucesso
		else		
			If ls_filial_java = 'S' Then
				as_log	= 'N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel deletar notas de Filiais com PDV Java. Chave de Acesso: ' + ls_nr_chave_acesso
				ib_sucesso	= False
				Return ib_sucesso
			End If
		End If
		
		if not wf_verifica_devolucao_compra_filial(ll_cd_filial, ls_cd_fornecedor, ll_nr_nf, ls_de_especie, ls_de_serie, ls_nr_chave_acesso, ls_nota_excluida, as_log) then
			ib_sucesso	= False
			Return ib_sucesso
		Else
			If ls_nota_excluida = 'S' then
				as_log	= 'A nota que est$$HEX1$$e100$$ENDHEX$$ sendo estornada possui devolu$$HEX2$$e700e300$$ENDHEX$$o, favor verificar. Chave de Acesso: ' + ls_nr_chave_acesso
				ib_sucesso	= False
				Return ib_sucesso
			End IF
		end if
	End If
	
	if not of_cancela_recebimento(ls_nr_chave_acesso, REF as_log) then
		return False
	end if
	
	lvds_1 = Create dc_uo_ds_Base
	
	If ls_nf_confirmada = 'X' Then
		If Not lvds_1.of_ChangeDataObject("dw_ge473_item_nf_compra") Then 
			as_log	= "Erro ao alterar o DataObject dw_ge473_item_nf_compra"
			ib_sucesso	= False
			Return ib_sucesso
		End IF
	Else	
		If Not lvds_1.of_ChangeDataObject("dw_ge473_nf_compra_pendente_produto") Then 
			as_log	= "Erro ao alterar o DataObject dw_ge473_nf_compra_pendente_produto"
			ib_sucesso	= False
			Return ib_sucesso
		End If
	End If

	if wf_inclui_log_exclusao(ll_cd_filial, ls_cd_fornecedor, ll_nr_nf, ls_de_especie, ls_de_serie, ldt_dh_movimento_caixa, ldc_vl_total_nf, &
								  	  ll_nr_pedido_distribuidora, ls_nr_chave_acesso, ls_motivo, ls_nf_confirmada, REF as_log) then
		lvds_1.Retrieve(ll_cd_filial, ls_cd_fornecedor, ll_nr_nf, ls_de_especie, ls_de_serie)
		
		For ll_for = 1 To lvds_1.RowCount()
			ll_cd_produto 				= lvds_1.Object.cd_produto[ll_for]
			ll_qt_faturada    		= lvds_1.Object.qt_faturada[ll_for]
			ll_qt_recebida				= lvds_1.Object.qt_recebida[ll_for]
			ls_distribuidora 			= lvds_1.Object.cd_fornecedor[ll_for]
			ls_fornecedor_usual		= lvds_1.Object.cd_fornecedor_usual[ll_for]
			ld_dh_emissao				= Date(lvds_1.Object.dh_emissao[ll_for])
			ls_uf							= lvds_1.Object.cd_uf[ll_for]
			ll_qt_faturada_item		= lvds_1.Object.qt_faturada_item[ll_for]
			ldc_vl_custo_pedido		= lvds_1.Object.vl_custo_pedido[ll_for]
			ll_cd_natureza_operacao = lvds_1.Object.cd_natureza_operacao[ll_for]
			
			If ls_nf_confirmada = 'X' Then
				ldt_dh_movimento_caixa	= lvds_1.Object.dh_movimentacao_caixa[ll_for]
				ldc_vl_total_produtos 	= lvds_1.Object.vl_total_produtos[ll_for]
				ldc_vl_desconto			= lvds_1.Object.vl_desconto[ll_for]
				ldc_vl_preco_unitario	= lvds_1.Object.vl_preco_unitario[ll_for]
				ldc_pc_desconto			= lvds_1.Object.pc_desconto[ll_for]
				ldc_vl_icms_st				= lvds_1.Object.vl_icms_st[ll_for]
				ldc_vl_ipi					= lvds_1.Object.vl_ipi[ll_for]
				ldc_vl_outras_despesas	= lvds_1.Object.vl_outras_despesas[ll_for]
							
				If Not wf_atualiza_resumo_compra(ldt_dh_movimento_caixa, ll_cd_filial, ll_cd_produto, ll_Qt_Faturada,& 
																ls_cd_fornecedor, ldc_vl_total_produtos, ldc_vl_desconto,&
																ldc_vl_preco_unitario, ldc_pc_desconto, ldc_vl_icms_st, ldc_vl_ipi, &
																ldc_vl_outras_despesas, ls_nr_chave_acesso, REF as_log) Then
					ib_sucesso	= False
					Return ib_sucesso
				End If
			End If
			
			ldc_Valor_Resumo	=  round(ll_qt_faturada_item * ldc_vl_custo_pedido, 2)
				
			If Not wf_atualiza_resumo_pedido(	ld_dh_emissao, &
															ls_Uf, &
															ls_distribuidora, &
															ls_fornecedor_usual, &
															ldc_Valor_Resumo, &
															ll_qt_faturada_item, &
															ls_nr_chave_acesso, &
															REF as_log) Then
				ib_sucesso	= False
				Return ib_sucesso
			End If
			
			lb_sucesso	= False
			
			if wf_exclui_item_nf_compra_lote(ll_cd_filial, ls_cd_fornecedor, ll_nr_nf, ls_de_especie, ls_de_serie, ll_cd_natureza_operacao, &
														ll_cd_produto, ls_nf_confirmada, ls_nr_chave_acesso, REF as_log) then
				if wf_exclui_item_nf_compra(ll_cd_filial, ls_cd_fornecedor, ll_nr_nf, ls_de_especie, ls_de_serie, ll_cd_natureza_operacao, &
													 ll_cd_produto, ls_nf_confirmada, ls_nr_chave_acesso, REF as_log) then
					if wf_exclui_movimento_estoque(ll_cd_filial, ls_cd_fornecedor, ll_nr_nf, ls_de_especie, ls_de_serie, ll_cd_produto, &
															 ldt_dh_movimento_caixa, ll_qt_faturada, ll_qt_recebida, ls_nf_confirmada, ls_nr_chave_acesso, &
															 REF as_log) then
						lb_sucesso = True
					end if
				end if
			end if
			
			if not lb_sucesso then
				ib_sucesso	= False
				Return ib_sucesso
			end if
		Next
		
		If lb_sucesso Then
			lb_sucesso = False
	
			If wf_Exclui_Titulo_Pagar(ll_cd_filial, ls_cd_fornecedor, ll_nr_nf, ls_de_especie, ls_de_serie, ls_nf_confirmada, ls_nr_chave_acesso, &
											  REF as_log) Then
				If wf_Exclui_NF_Compra(ll_cd_filial, ls_cd_fornecedor, ll_nr_nf, ls_de_especie, ls_de_serie, ls_nf_confirmada, ls_nr_chave_acesso, &
											  REF as_log) Then
					If wf_Atualiza_Resumo_Movimento(ll_cd_filial, ldt_dh_movimento_caixa, ldc_vl_total_nf, ls_nf_confirmada, ls_nr_chave_acesso, REF as_log) Then			  
						If wf_Atualiza_LOG_Exportacao(ll_cd_filial, ls_cd_fornecedor, ll_nr_nf, ls_de_especie, ls_de_serie, ls_nf_confirmada, ls_nr_chave_acesso, &
																REF as_log) Then
																
							lb_sucesso = True
						End If		
					End If
				End If
			End If
			
			if not lb_sucesso then
				ib_sucesso	= False
				Return ib_sucesso
			End if
		End If
	else
		ib_sucesso	= False
		Return ib_sucesso
	end if
Next

ib_sucesso	= True
Return True
end function

public function boolean wf_valida_nf_compra_filial_java (long al_filial, string as_fornecedor, long al_nr_nf, string as_especie, string as_serie, string as_chave_acesso, ref string as_filial_java, ref string as_log);Long ll_Qtde

String ls_Erro


select coalesce(id_pdv_java, 'N')
into :as_Filial_Java
from parametro_odbc
where cd_filial = :al_Filial
Using SqlCa;

Choose Case SqlCa.sqlcode			
	Case 100
		as_log	= "N$$HEX1$$e300$$ENDHEX$$o forma localizadas as informa$$HEX2$$e700f500$$ENDHEX$$es para ver se a filial $$HEX1$$e900$$ENDHEX$$ Java.~r" + 'Chave de Acesso: ' + as_chave_acesso
		Return False
	Case -1
		as_log	= "Erro ao verificar se a filial $$HEX1$$e900$$ENDHEX$$ Java.~r" + 'Chave de Acesso: ' + as_chave_acesso + ' Erro: ' + SQLCA.SQLErrText
		Return False
End Choose

If as_Filial_Java = "S" Then
	select count(*)
	into :ll_Qtde
	from nf_compra
	where	cd_filial 			= :al_Filial
		and	cd_fornecedor	= :as_Fornecedor
		and	nr_nf				= :al_Nr_Nf
		and	de_especie		= :as_Especie
		and	de_serie			= :as_Serie
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		as_log	= "Erro ao verificar se nota ja foi importada na filial Java.~r" + 'Chave de Acesso: ' + as_chave_acesso + ' Erro: ' + SQLCA.SQLErrText
		Return False
	End If
	
	If ll_Qtde > 0 Then
		as_log	= "Notas que j$$HEX1$$e100$$ENDHEX$$ foram importadas em filiais com o novo sistema de PDV n$$HEX1$$e300$$ENDHEX$$o poder$$HEX1$$e300$$ENDHEX$$o ser exclu$$HEX1$$ed00$$ENDHEX$$das.~r" + 'Chave de Acesso: ' + as_chave_acesso
		Return False
	End If	
End If

Return True
end function

public function boolean wf_verifica_devolucao_compra_filial (long al_filial, string as_fornecedor, long al_nr_nf, string as_especie, string as_serie, string as_chave_acesso, ref string as_nota_excluida, ref string as_log);boolean 	lb_Sucesso = True
Long 		ll_Retorno = 0


as_nota_excluida = "N"

Select Count(*)
Into	:ll_Retorno
From nf_devolucao_compra
Where 	cd_fornecedor 			= :as_Fornecedor
	and 	nr_nf_compra			= :al_nr_nf
	and 	de_especie_compra 	= :as_especie
	and 	de_serie_compra		= :as_serie;
	
Choose Case SQLCA.SqlCode
	Case 0
		If ll_Retorno > 0 Then
			as_nota_excluida = "S"					
		End If			
	Case -1
		as_log	= "Filial: " + String(al_Filial) + " - Localiza$$HEX2$$e700e300$$ENDHEX$$o da nota fiscal de compra " + String(al_nr_nf) + " como refer$$HEX1$$ea00$$ENDHEX$$ncia na NF Dev. Compra."
		lb_Sucesso = False
End Choose
	
Return lb_Sucesso
end function

public function boolean wf_atualiza_resumo_compra (datetime adt_movimentacao, long al_filial, long al_produto, long al_qtde, string as_fornecedor, decimal adc_total_produtos, decimal adc_descontos, decimal adc_preco_unitario, decimal adc_pc_desconto, decimal adc_icms_st, decimal adc_ipi, decimal adc_outras_despesas, string as_chave_acesso, ref string as_log);Date ldt_Data_Convertida
Decimal ldc_Preco_Liquido, ldc_valor_desc_prd, ldc_preco_liquid_res, ldc_impostos, ldc_preco_liq_calc, ldc_impostos_calc
Long ll_Qtde_Faturada
String ls_Achou, ls_MSG


ldt_Data_Convertida = Date(String(adt_movimentacao, '01/mm/yyyy'))

ldc_Preco_Liquido =  round(adc_preco_unitario * ((100 - adc_pc_desconto) / 100), 2)
ldc_Valor_Desc_PRD = round(ldc_Preco_Liquido * (adc_descontos       / adc_total_produtos), 2)
ldc_Preco_Liquid_Res	= ldc_Preco_Liquido - ldc_Valor_Desc_PRD
ldc_Impostos 			= round(adc_icms_st + adc_outras_despesas + adc_ipi, 2)

ldc_preco_liq_calc	= ldc_Preco_Liquid_Res * (-1)
ldc_impostos_calc	= ldc_Impostos * (-1)
ll_Qtde_Faturada	= al_qtde * (-1)

ldc_preco_liq_calc = round(ldc_preco_liq_calc * al_qtde, 2)
ldc_impostos_calc	= round(ldc_impostos_calc * al_qtde, 2)

Select cd_fornecedor
Into :ls_achou
From resumo_produto_compra
Where dh_resumo 			=:ldt_Data_Convertida
  	and cd_filial					=:al_filial
	and cd_produto				=:al_produto
	and cd_fornecedor			=:as_fornecedor
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		
		update resumo_produto_compra
		set qt_faturada 		= qt_faturada + :ll_Qtde_Faturada,
			vl_preco_liquido    = vl_preco_liquido + :ldc_preco_liq_calc,   
			vl_impostos			= vl_impostos + :ldc_impostos_calc 
		where dh_resumo  		= :ldt_Data_Convertida
		  and cd_filial  		= :al_filial
		  and cd_produto		= :al_produto
		  and cd_fornecedor 	= :as_fornecedor
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			as_log = "Erro ao atualizar o resumo do pedido.~r" + "Cahve de Acesso: " + as_chave_acesso + ".~r" + SQLCA.SQLErrText
			Return false
		End If
	Case 100
				
		insert into resumo_produto_compra (dh_resumo,cd_filial,cd_produto,cd_fornecedor,qt_faturada,vl_preco_liquido,vl_impostos)
		values (:ldt_Data_Convertida,:al_Filial,:al_Produto,:as_fornecedor,:ll_Qtde_Faturada,:ldc_preco_liq_calc,:ldc_impostos_calc  )
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			as_log = "Erro ao incluir o resumo do pedido.~r" + "Cahve de Acesso: " + as_chave_acesso + ".~r" + SQLCA.SQLErrText
			Return False
		End If
		
	Case -1
		as_log = "Erro ao localizar o resumo de compra.~r" + "Cahve de Acesso: " + as_chave_acesso + ".~r" + SQLCA.SQLErrText
		Return False		
End Choose

Return True

end function

public function boolean wf_atualiza_resumo_pedido (date adt_pedido, string as_uf, string as_distribuidora, string as_fornecedor, decimal adc_valor, long al_qtde, string as_chave_acesso, ref string as_log);String ls_Achou, ls_MSG


If IsNull(adt_pedido) Then Return True

adc_valor	= adc_valor * (-1)
al_qtde		= al_qtde * (-1)

Select cd_uf
Into :ls_achou
From resumo_pedido_distribuidora
Where dh_pedido 			=:adt_pedido
  	and cd_uf				=:as_uf
	and cd_distribuidora	=:as_distribuidora
	and cd_fornecedor		=:as_fornecedor
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		
		Update resumo_pedido_distribuidora
		set vl_faturado = vl_faturado + :adc_valor, qt_faturada = qt_faturada  + :al_qtde
		where dh_pedido 			= :adt_pedido 
			and cd_uf				= :as_uf 
			and cd_distribuidora 	= :as_distribuidora 
			and cd_fornecedor 	= :as_fornecedor
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			as_log	= "Erro ao atualizar o resumo do pedido.~r" + 'Chave de Acesso: ' + as_chave_acesso + "'.~r" + SQLCA.SQLErrText
			Return false
		End If
		
	Case 100
		
		INSERT INTO resumo_pedido_distribuidora ( dh_pedido, cd_uf, cd_distribuidora, cd_fornecedor,vl_pedido,qt_pedida,vl_faturado, qt_faturada )  
		values (:adt_pedido, :as_uf, :as_distribuidora, :as_fornecedor, 0.00, 0, :adc_valor, :al_qtde)
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			as_log	= "Erro ao incluir o resumo do pedido.~r" + 'Chave de Acesso: ' + as_chave_acesso + "'.~r" + SQLCA.SQLErrText
			Return false
		End If
		
	Case -1
		as_log	= "Erro ao localizar o resumo do pedido.~r" + 'Chave de Acesso: ' + as_chave_acesso + "'.~r" + SQLCA.SQLErrText
		Return false
		
End Choose

Return True
end function

public function boolean wf_exclui_item_nf_compra_lote (long al_filial, string as_fornecedor, long al_nf, string as_especie, string as_serie, long al_natoperacao, long al_produto, string as_compra_confirmada, string as_chave_acesso, ref string as_log);String ls_Erro

If as_compra_confirmada = "X" Then
	Delete From produto_lote_nf_entrada
	Where cd_filial            					= :al_Filial
	  	and cd_fornecedor        			= :as_Fornecedor
	  	and nr_nf                					= :al_NF
	  	and de_especie           	= :as_Especie
	  	and de_serie             	= :as_Serie
	  	and cd_natureza_operacao	= :al_NatOperacao
	  	and cd_produto          	= :al_Produto
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		as_log	= "Erro na exclus$$HEX1$$e300$$ENDHEX$$o do Lote da PRODUTO_LOTE_NF_ENTRADA.~r" + "Chave de Acesso: " + as_chave_acesso + ".~r" + SQLCA.SQLErrText
		Return False
	End If	
	
	Delete From item_nf_compra_lote
	Where cd_filial            = :al_Filial
	  and cd_fornecedor        = :as_Fornecedor
	  and nr_nf                = :al_NF
	  and de_especie           = :as_Especie
	  and de_serie             = :as_Serie
	  and cd_natureza_operacao = :al_NatOperacao
	  and cd_produto           = :al_Produto
	Using SqlCa;
Else	
	Delete From nf_compra_pendente_prd_lote
	Where cd_filial            = :al_Filial
	  and cd_fornecedor        = :as_Fornecedor
	  and nr_nf                = :al_NF
	  and de_especie           = :as_Especie
	  and de_serie             = :as_Serie
	  and cd_natureza_operacao = :al_NatOperacao
	  and cd_produto           = :al_Produto
	Using SqlCa;
End If	

If SqlCa.SqlCode = -1 Then
	as_log	= "Erro na exclus$$HEX1$$e300$$ENDHEX$$o do Lote da nf_compra_pendente_prd_lote.~r" + "Chave de Acesso: " + as_chave_acesso + ".~r" + SQLCA.SQLErrText
	Return False
Else
	Return True
End If
end function

public function boolean wf_exclui_item_nf_compra (long al_filial, string as_fornecedor, long al_nf, string as_especie, string as_serie, long al_natope, long al_produto, string as_nota_confirmada, string as_chave_acesso, ref string as_log);String ls_Erro


If as_nota_confirmada = "X" Then
	Delete From item_nf_compra_prd
	Where cd_filial            = :al_Filial
	  and cd_fornecedor        = :as_Fornecedor
	  and nr_nf                = :al_NF
	  and de_especie           = :as_Especie
	  and de_serie             = :as_Serie
	  and cd_produto           = :al_Produto
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		as_log	= "Exclus$$HEX1$$e300$$ENDHEX$$o do Produto '" + String(al_Produto) + "' da item_nf_compra_prd'.~r" + "Chave de Acesso: " + as_chave_acesso + ".~r" + SqlCa.SqlErrText
		Return False
	End If	
	
	Delete From item_nf_compra
	Where cd_filial            = :al_Filial
	  and cd_fornecedor        = :as_Fornecedor
	  and nr_nf                = :al_NF
	  and de_especie           = :as_Especie
	  and de_serie             = :as_Serie
	  and cd_natureza_operacao = :al_NatOpe
	  and cd_produto           = :al_Produto
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		as_log	= "Exclus$$HEX1$$e300$$ENDHEX$$o do Produto '" + String(al_Produto) + "' da item_nf_compra'.~r" + "Chave de Acesso: " + as_chave_acesso + ".~r" + SqlCa.SqlErrText
		return False
	End If 	
Else	
	Delete From nf_compra_pendente_prd_item
	Where cd_filial            = :al_Filial
	  and cd_fornecedor        = :as_Fornecedor
	  and nr_nf                = :al_NF
	  and de_especie           = :as_Especie
	  and de_serie             = :as_Serie
	  and cd_produto           = :al_Produto
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		as_log	= "Exclus$$HEX1$$e300$$ENDHEX$$o do Produto '" + String(al_Produto) + "' da nf_compra_pendente_prd_item'.~r" + "Chave de Acesso: " + as_chave_acesso + ".~r" + SqlCa.SqlErrText
		return False
	End If 
			
	Delete From nf_compra_pendente_produto
	Where cd_filial            = :al_Filial
	  and cd_fornecedor        = :as_Fornecedor
	  and nr_nf                = :al_NF
	  and de_especie           = :as_Especie
	  and de_serie             = :as_Serie
	  and cd_natureza_operacao = :al_NatOpe
	  and cd_produto           = :al_Produto
	Using SqlCa;

	If SqlCa.SqlCode = -1 Then
		as_log	= "Exclus$$HEX1$$e300$$ENDHEX$$o do Produto '" + String(al_Produto) + "' da nf_compra_pendente_produto'.~r" + "Chave de Acesso: " + as_chave_acesso + ".~r" + SqlCa.SqlErrText
		return False
	End If 
End If

Return True
end function

public function boolean wf_exclui_movimento_estoque (long al_filial, string as_fornecedor, long al_nf, string as_especie, string as_serie, long al_produto, datetime adh_data_caixa, long al_faturada, long al_qtde_recebida, string as_nota_confirmada, string as_chave_acesso, ref string as_log);Boolean lvb_Sucesso = False

String lvs_Chave, &
		ls_Erro

Long lvl_Movimento, &
     	lvl_Qtde

	  
If as_nota_confirmada <> "X" Then Return True  
	  
lvs_Chave = "(" + String(al_Filial) + "-" + as_Fornecedor + "-" + String(al_NF) + "-" + &
            as_Especie + "-" + as_Serie + "-" + String(al_Produto) + ")"

Select nr_movimento_estoque,
       qt_movimento
Into :lvl_Movimento,
     :lvl_Qtde
From movimento_estoque
Where cd_filial_movimento = :al_Filial
  and cd_produto          = :al_Produto
  and dh_movimento        = :adh_Data_Caixa
  and nr_nf               = :al_NF
  and de_especie          = :as_Especie
  and de_serie            = :as_Serie
  and cd_fornecedor       = :as_Fornecedor
  and cd_tipo_movimento in (3, 16)
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If lvl_Qtde = al_faturada Then
			Delete From movimento_estoque
			Where cd_filial_movimento  = :al_Filial
			  and cd_produto           = :al_Produto
			  and dh_movimento         = :adh_Data_Caixa
			  and nr_movimento_estoque = :lvl_Movimento
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				as_log	= "Exclus$$HEX1$$e300$$ENDHEX$$o do Movimento de Estoque.~r" + "Chave de Acesso: " + as_chave_acesso + ".~r" + SqlCa.SqlErrText
				Return False
			End If
		Else
			as_log	= "Movimento de estoque $$HEX1$$e900$$ENDHEX$$ diferente da nota fiscal.~r" + "Chave de Acesso: " + as_chave_acesso + ".~r" + SqlCa.SqlErrText
			Return False
		End If
	Case 100
		as_log	= "Movimento de estoque n$$HEX1$$e300$$ENDHEX$$o localizado.~r" + "Chave de Acesso: " + as_chave_acesso + ".~r" + SqlCa.SqlErrText
		Return False
	Case -1
		as_log	= "Erro na Localiza$$HEX2$$e700e300$$ENDHEX$$o do Movimento de Estoque.~r" + "Chave de Acesso: " + as_chave_acesso + ".~r" + SqlCa.SqlErrText
		Return False
End Choose

Return True
end function

public function boolean wf_exclui_titulo_pagar (long al_filial, string as_fornecedor, long al_nf, string as_especie, string as_serie, string as_nota_confirmada, string as_chave_acesso, ref string as_log);String ls_Erro

If as_nota_confirmada = "X" Then
	
	Delete From titulo_pagar
	Where cd_filial     	= :al_Filial
	  and cd_fornecedor 	= :as_Fornecedor
	  and nr_nf         	= :al_NF
	  and de_especie    	= :as_Especie
	  and de_serie      	= :as_Serie
	Using SqlCa;
Else
	Delete From titulo_pagar_pendente
	Where cd_filial     	= :al_Filial
	  and cd_fornecedor 	= :as_Fornecedor
	  and nr_nf         	= :al_NF
	  and de_especie    	= :as_Especie
	  and de_serie      	= :as_Serie
	Using SqlCa;
End If	

If SqlCa.SqlCode = -1 Then
	as_log	= "Exclus$$HEX1$$e300$$ENDHEX$$o dos T$$HEX1$$ed00$$ENDHEX$$tulos a Pagar.~r" + "Chave de Acesso: " + as_chave_acesso + ".~r" + SqlCa.SqlErrText
	Return False
Else
	Return True
End If
end function

public function boolean wf_exclui_nf_compra (long al_filial, string as_fornecedor, long al_nf, string as_especie, string as_serie, string as_nota_confirmada, string as_chave_acesso, ref string as_log);String ls_Erro


If as_nota_confirmada = "X" Then
	Delete From nf_compra
	Where cd_filial     = :al_Filial
	  and cd_fornecedor = :as_Fornecedor
	  and nr_nf         = :al_NF
	  and de_especie    = :as_Especie
	  and de_serie      = :as_Serie
	Using SqlCa;
Else
	Delete From nf_compra_pendente
	Where cd_filial     = :al_Filial
	  and cd_fornecedor = :as_Fornecedor
	  and nr_nf         = :al_NF
	  and de_especie    = :as_Especie
	  and de_serie      = :as_Serie
	Using SqlCa;
End If

If SqlCa.SqlCode = -1 Then
	as_log	= "Exclus$$HEX1$$e300$$ENDHEX$$o da Nota Fiscal de Compra.~r" + "Chave de Acesso: " + as_chave_acesso + ".~r" + SqlCa.SqlErrText
	Return False
Else
	Return True
End If
end function

public function boolean wf_atualiza_resumo_movimento (long al_filial, datetime adh_data_caixa, decimal adc_valor, string as_nota_confirmada, string as_chave_acesso, ref string as_log);String ls_Erro


If as_nota_confirmada <> "X" Then Return True

Update resumo_movimento_estoque
Set vl_compra = vl_compra - :adc_Valor
Where cd_filial = :al_Filial
  and dh_resumo = :adh_Data_Caixa
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_log	= "Atualiza$$HEX2$$e700e300$$ENDHEX$$o do Resumo de Movimenta$$HEX2$$e700e300$$ENDHEX$$o da filial.~r" + "Chave de Acesso: " + as_chave_acesso + ".~r" + SQLCA.SQLErrText
	Return False
Else
	Return True
End If
end function

public function boolean wf_atualiza_log_exportacao (long al_filial, string as_fornecedor, long al_nf, string as_especie, string as_serie, string as_nota_confirmada, string as_chave_acesso, ref string as_log);String lvs_Tabela
String ls_Erro


If as_nota_confirmada = "X" Then
	lvs_Tabela = "NF_COMPRA"
Else
	lvs_Tabela = "NF_COMPRA_PENDENTE"	
End If 

Insert Into log_exportacao_filial (cd_filial_atualizacao,
           								  nm_tabela,
											  dh_atualizacao,
											  de_chave,
											  id_atualizacao)
Select :al_Filial,
      	:lvs_Tabela,
		 getdate(),
		 convert(char(4), :al_Filial) + '@#!' + :as_Fornecedor + '@#!' + convert(char(8), :al_NF) + '@#!' + :as_Especie + '@#!' + :as_Serie,
        'E'
From parametro
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_log	= "Atualiza$$HEX2$$e700e300$$ENDHEX$$o do LOG de Exporta$$HEX2$$e700e300$$ENDHEX$$o.~r" + "Chave de Acesso: " + as_chave_acesso + ".~r" + SQLCA.SQLErrText
	Return False
Else
	Return True
End If
end function

public function boolean wf_inclui_log_exclusao (long al_filial, string as_fornecedor, long al_nota, string as_especie, string as_serie, datetime adt_movimento, decimal adc_valor, long al_pedido, string as_chave_acesso, string as_motivo, string as_nota_confirmada, ref string as_log);Long ll_Seq
String ls_Erro, ls_pendente


If Not gf_ge040_Seq_Log_Exc_Nf_Compra(al_Filial, as_Fornecedor, al_Nota, as_Especie, as_Serie, Ref ll_Seq) Then Return False

if as_nota_confirmada = 'X' then
	ls_pendente = 'N'
else
	ls_pendente = 'S'
End If

INSERT INTO log_exclusao_nf_compra (cd_filial,   
												cd_fornecedor,   
												nr_nf,   
												de_especie,   
												de_serie,   
												dh_movimentacao_caixa,   
												vl_total_nf,   
												nr_pedido_distribuidora,   
												nr_matricula_solicitante,   
												nr_matricula_responsavel,   
												dh_exclusao,   
												de_chave_acesso,   
												de_motivo,
												nr_sequencial,
												id_nf_pendente,
												id_exportada_mult)
								    VALUES (:al_filial,   
												:as_fornecedor,   
												:al_nota,   
												:as_especie,   
												:as_serie,   
												:adt_movimento,   
												:adc_valor,   
												:al_pedido,   
												null,   
												'SAP001',   
												getdate(),   
												:as_chave_acesso,   
												:as_motivo,
												:ll_Seq,
												:ls_pendente,
												'N')
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_log	= "Erro na inclus$$HEX1$$e300$$ENDHEX$$o do log exporta$$HEX2$$e700e300$$ENDHEX$$o de exclus$$HEX1$$e300$$ENDHEX$$o de nota.~r" + 'Chave Acesso: ' + as_chave_acesso + ".~r" + SQLCA.SQLErrText
	Return False
End If

Return True
end function

public function boolean of_cancela_recebimento (string as_de_chave_acesso, ref string as_log);update recebimento_sap
set id_situacao = 'X',
	 dh_estornado = getdate()
where de_chave_acesso	= :as_de_chave_acesso
using SQLCA;

Choose case SQLCa.SqlCode
	Case -1
		as_log	= 'Erro ao atualizar o recebimento_sap com situa$$HEX2$$e700e300$$ENDHEX$$o Cancelado. Chave de Acesso: ' + as_de_chave_acesso + ' Erro: ' + SQLCA.SQLErrText
		return False
End Choose

return True
end function

on uo_ge473_estorno_nf_compra.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge473_estorno_nf_compra.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

