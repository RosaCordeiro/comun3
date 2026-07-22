HA$PBExportHeader$w_ge469_cheque_custodia.srw
forward
global type w_ge469_cheque_custodia from dc_w_cadastro_selecao_lista
end type
type cb_1 from commandbutton within w_ge469_cheque_custodia
end type
type pb_1 from picturebutton within w_ge469_cheque_custodia
end type
type st_1 from statictext within w_ge469_cheque_custodia
end type
end forward

global type w_ge469_cheque_custodia from dc_w_cadastro_selecao_lista
integer width = 3689
integer height = 1932
string title = "GE469 - Leitura Arquivo de Retorno"
cb_1 cb_1
pb_1 pb_1
st_1 st_1
end type
global w_ge469_cheque_custodia w_ge469_cheque_custodia

type variables
uo_ge470_sap_comum io_sap_comum
dc_uo_api ivo_api

String is_Origem_Legado 		= "SYBASE"
String is_Termino_Cabecalho 	= '</I_CABECALHO>'
String is_Termino_Item 			= '</I_ITEM>'
String is_URL
String is_URL_Retorno
String is_Inicio_XML
String is_Termino_XML
//String is_Doc_Externo
String is_Ambiente_SAP
//Long il_Doc_Externo
Long il_Item_Documento
//Long il_Filial
String is_Chave_Log
String is_Arquivo_Log
end variables

forward prototypes
public function boolean wf_valor_decimal (string as_valor, ref decimal adc_valor)
public subroutine wf_envia_sap ()
public function boolean wf_monta_xml_cabecalho (string as_nr_atualizacao, string as_dt_documento, string as_dt_contabilizacao, string as_nr_documento_referencia, string as_texto_documento, ref string as_log, ref string as_xml_cabelho)
public function boolean wf_processa_envio_sap ()
public function string wf_monta_xml_item (string as_nr_atualizacao, string as_dt_documento, string as_tipo_conta, string as_nr_conta, string as_nr_atribuicao, string as_texto_item, string as_centro_custo, string as_centro_lucro, string as_cd_filial, string as_valor_movimento, string as_ref3, string as_forma_pagto)
public subroutine wf_renomeia_arquivo ()
public function boolean wf_valida_cpf ()
public function boolean wf_leitura_ret_txt (string as_arquivo)
public function boolean wf_processa_arquivo_ret (string as_arquivo, integer ai_arquivo)
public function boolean wf_leitura_ret_xls (string as_arquivo)
end prototypes

public function boolean wf_valor_decimal (string as_valor, ref decimal adc_valor);String lvs_Temp

If IsNumber(as_Valor) Then
	lvs_Temp = LeftA(as_Valor, LenA(as_Valor) - 2) + "," + RightA(as_Valor, 2)
	
	adc_Valor = Dec(lvs_Temp)
	Return True
Else
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao converter o valor do cheque.')
	Return False
End If
end function

public subroutine wf_envia_sap ();Boolean lb_Sucesso, lb_Abortado = False

Date ldh_Movimento, ldh_Emissao

Decimal ldc_Valor

Long li_Tipo_Log, lvl_Log, ll_Achou, ll_Find

Long ll_Linha, ll_Linhas, ll_Nota, ll_Filial, ll_NR_Lancamento, ll_Doc_Externo

String ls_DT_Documento, ls_DT_Contabilizacao, ls_Chave, ls_Texto_Doc, ls_Doc_Ref, ls_Item_XML, ls_XML
String ls_Especie_Nota, ls_Serie_Nota, ls_Caixa, ls_Log, ls_Id_Tipo_Nf, ls_Doc_Externo, ls_Cabecalho, ls_Tipo_Conta
String ls_Atribuicao, ls_Texto_Item, ls_CCusto, ls_CLucro, ls_Valor, ls_Ref3, ls_Tipificacao, ls_Xml_Retorno, ls_Cd_Condicao_Pagamento
String ls_Camara, ls_Banco, ls_Agencia, ls_Agencia_DV, ls_Conta, ls_Conta_DV, ls_Cheque, ls_Cheque_DV, ls_CMC7, ls_CPF, ls_Filial_SAP

dw_2.AcceptText()

ll_Linhas = dw_2.RowCount()

SetNull(ll_NR_Lancamento)

lvl_Log = FileLength(gvo_Aplicacao.ivs_Arquivo_LOG)

If ll_Linhas > 0 Then
	ll_Find = dw_2.Find( "IsNull(nr_cpf)", 1, ll_Linhas)
	
	If ll_Find > 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o CPF/CNPJ.", Exclamation!)
		dw_2.Event ue_Pos(ll_Find, "nr_cpf")
		Return
	ElseIf ll_Find < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no find.", StopSign!)
		Return
	End If
End If

try
	
	Open(w_Aguarde)
	
	If Not wf_valida_cpf() Then Return
	
	w_aguarde.uo_progress.of_setmax(ll_Linhas)

	For ll_Linha = 1 To ll_Linhas
		
		ls_Item_XML 			= ''
		il_Item_Documento 	= 0
		ls_Id_Tipo_Nf			= 'CHC'
		li_Tipo_Log				= 7
		
		lb_Sucesso = False
				
		ldh_Movimento = dw_2.Object.dh_Movimento[ll_Linha]
		ls_DT_Documento		= String(ldh_Movimento, "yyyymmdd")
		ls_DT_Contabilizacao	= String(ldh_Movimento, "yyyymmdd")
		
		ls_Camara 		= dw_2.Object.cd_camara		[ll_Linha]
		ls_Banco 		= dw_2.Object.cd_banco			[ll_Linha]
		ls_Agencia 		= dw_2.Object.cd_agencia		[ll_Linha]
		ls_Agencia_DV = dw_2.Object.cd_agencia_dv	[ll_Linha]
		ls_Conta 			= dw_2.Object.cd_conta			[ll_Linha]
		ls_Conta_DV 	= dw_2.Object.cd_conta_dv		[ll_Linha]
		ls_Cheque 		= dw_2.Object.nr_cheque		[ll_Linha]
		ls_Cheque_DV 	= dw_2.Object.nr_cheque_dv	[ll_Linha]
		ls_Tipificacao	= dw_2.Object.id_tipificacao	[ll_Linha]
		ldc_Valor			= dw_2.Object.vl_cheque		[ll_Linha]
		ls_CPF			= dw_2.Object.nr_cpf				[ll_Linha]
		ll_Filial			= dw_2.Object.cd_filial			[ll_Linha]
		ls_Filial_SAP	= String(dw_2.Object.cd_filial_sap[ll_Linha])
		
		If IsNull(ls_CPF) or Trim(ls_CPF) = '' Then
			w_aguarde.uo_progress.of_setprogress(ll_Linha)
			Continue
		End If
		
		ls_CMC7 =dw_2.Object.nr_cmc7[ll_Linha]
		
		If IsNull(ls_CMC7) or Trim(ls_CMC7) = '' Then
			ls_CMC7 = ls_Banco + ls_Agencia + ls_Agencia_DV
			ls_CMC7 +=  ls_Camara + ls_Cheque + ls_Tipificacao 
			ls_CMC7 += ls_Conta_DV + ls_Conta + ls_Cheque_DV
		End If
		
		// Log Exporta$$HEX2$$e700e300$$ENDHEX$$o
		ls_Chave = ls_Banco + "/" + ls_Agencia + "/" +  ls_Conta + "/" + ls_Cheque
		
		If IsNull(ls_CMC7) Then
			gvo_Aplicacao.of_grava_log('GE469 - CMC7 do cheque n$$HEX1$$e300$$ENDHEX$$o foi localizado - [' + ls_Chave + '].')
		End If
		
		// Cabe$$HEX1$$e700$$ENDHEX$$alho  XML
		ls_Texto_Doc 	= "BCO." + ls_Banco +  "/ AG." + ls_Agencia
				
		If IsNull(ls_Filial_SAP) Then
			ldh_Emissao = Relativedate(ldh_Movimento, -90)
			
			select c.cd_filial_inclusao, i.cd_chave_sap
			Into :ll_Filial, :ls_Filial_SAP
			From cheque c
			left outer join integracao_sap i
				 on i.cd_empresa = 1000
				 and i.cd_tabela = 'FILIAL'
				 and i.cd_chave_legado = cast(c.cd_filial_inclusao as varchar)
			where nr_cpf_cliente = :ls_CPF
			 and vl_cheque = :ldc_Valor
			 and c.dh_emissao >= :ldh_Emissao
			 and c.dh_vencimento <= :ldh_Movimento
			Using SqlCa;
			
			Choose Case Sqlca.SqlCode 
				Case 0
				Case 100
					Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizado o cheque no Sybase para o CPF '" + ls_CPF + "' informado. ~r~r" + ls_Chave)
					w_aguarde.uo_progress.of_setprogress(ll_Linha)
					Continue
				Case -1
					SqlCa.of_MsgDbError("Erro ao localizar o cheque para o CPF '" + ls_CPF + "' informado.")
					w_aguarde.uo_progress.of_setprogress(ll_Linha)
					Continue
			End Choose
			
			If IsNull(ls_Filial_SAP) Then
				Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Filial SAP n$$HEX1$$e300$$ENDHEX$$o foi localizada. ~r~r" + ls_Chave)
				w_aguarde.uo_progress.of_setprogress(ll_Linha)
				Continue
			End If
		End If
		
		ls_Atribuicao = 'CH/' + Right(ls_CMC7, 8) + '/' + ls_Cheque
		ls_Texto_Item 	= "Cheque: " + ls_Atribuicao +  " - Filial:" + ls_Filial_SAP
		ls_Ref3			= ls_Atribuicao
		
		ls_Doc_Ref		= Right(ls_CMC7, 8) + '/' + String(Long(ls_Cheque))
		
		ll_Nota = Long(ls_Cheque)
		
		select count(*)
		Into :ll_Achou
		from log_exportacao_sap les
		where les.cd_empresa  	= 1000
			and les.id_tipo_log 		= :li_Tipo_Log
			and les.cd_chave 		= :ls_Chave
			and coalesce(les.id_estornar, 'N') = 'N' 
		Using SqlCa;
		
		If SqlCa.Sqlcode = -1 Then
			Sqlca.of_MsgDbError("Erro ao localizar se o doc foi exportado para o SAP.")
			Return
		End If
						
		If ll_Achou > 0 Then
			If Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O documento j$$HEX1$$e100$$ENDHEX$$ foi exportado para o SAP BCO/AG/CONTA/CHEQUE["  + ls_Chave + "].~r~rDeseja continuar ?" , Question!, YesNo!, 2) = 1 Then
				w_aguarde.uo_progress.of_setprogress(ll_Linha)
				Continue
			Else
				Return
			End If
		End If
						
		If io_sap_comum.of_insere_log_exportacao_sap(	li_Tipo_Log, ls_Chave, ls_Id_Tipo_Nf, ll_Filial, ll_Nota, ls_Especie_Nota, ls_Serie_Nota, &
																		ls_Caixa, ll_NR_Lancamento, Ref ls_Log, Ref ll_Doc_Externo, is_Ambiente_SAP, ls_CMC7) Then
																		
			//ls_Texto_Doc	= "CaixaFiliC - " + String(il_Filial, "0000") + "/" + String(pl_controle)
			ls_Doc_Externo	= "S" + String(ll_Doc_Externo)
			
			If Not wf_monta_xml_cabecalho(ls_Doc_Externo, ls_DT_Documento, ls_DT_Contabilizacao, ls_Doc_Ref, ls_Texto_Doc, ref ls_Log, ref ls_Cabecalho) Then Return
			
			// Debito - o valor $$HEX1$$e900$$ENDHEX$$ com o sinal "+"
			ls_Valor 	= gf_Valor_Com_Ponto(ldc_Valor * -1)
			ls_Conta 	= ls_CPF
			ls_Cd_Condicao_Pagamento = 'C'
			
			ls_Item_XML+= wf_monta_xml_item(ls_Doc_Externo, ls_DT_Documento, 'D', ls_Conta, ls_Atribuicao, ls_Texto_Item, ls_CCusto, ls_CLucro, ls_Filial_SAP, ls_Valor, ls_Ref3, ls_Cd_Condicao_Pagamento)
			
			If Not io_sap_comum.of_Insere_Log_Exportacao_SAP_Hist(	ll_Doc_Externo, String(ll_Doc_Externo), ldh_Movimento, il_Item_Documento, 'D', ldc_Valor * -1, &
																						Ref ls_Log, ls_Conta, ls_Atribuicao) Then
				//Informatica
				lf_ge470_log(ls_Log, 1, 'CX', is_Chave_Log, 0)
				SqlCa.of_RollBack();
				Return
			End If
					
			// Transit$$HEX1$$f300$$ENDHEX$$ria de entrada
			ls_Conta 	= '11102207'
			ls_Valor 	= gf_Valor_Com_Ponto(ldc_Valor)
			ls_Cd_Condicao_Pagamento = ''
			ls_Item_XML+= wf_monta_xml_item(ls_Doc_Externo, ls_DT_Documento, 'S', ls_Conta, ls_Atribuicao, ls_Texto_Item, ls_CCusto, ls_CLucro, ls_Filial_SAP, ls_Valor, ls_Ref3, ls_Cd_Condicao_Pagamento)
			
			If Not io_sap_comum.of_Insere_Log_Exportacao_SAP_Hist(	ll_Doc_Externo, String(ll_Doc_Externo), ldh_Movimento, il_Item_Documento, 'S', ldc_Valor, &
																						Ref ls_Log, ls_Conta, ls_Atribuicao) Then
				//Informatica
				lf_ge470_log(ls_Log, 1, 'CX', is_Chave_Log, 0)
				SqlCa.of_RollBack();
				Return
			End If
			
			ls_XML =	is_Inicio_XML + ls_Cabecalho + ls_Item_XML + is_Termino_Cabecalho + is_Termino_XML
			
			If Not IsNull(ls_XML) Then
				If io_sap_comum.of_envia_webservice(is_URL, ls_XML, Ref ls_Xml_Retorno, Ref ls_Log) Then
					If Not lf_ge470_processa_retorno(ls_Xml_Retorno, 1, '', SQLCA, 'SYB', ref ls_Log, 0) Then
						If Trim(ls_Log) <> '' Then
							lf_ge470_log(ls_Log, 1, 'CH', 'RETORNO SAP', 0)
						End If
					End If
					
					lb_Sucesso = True
				End If	
			Else
				gvo_Aplicacao.of_grava_log('GE469 - Algum campo esta com valor nulo impossibilitando o envio do CHEQUE para o SAP - [' + ls_Chave + '].')
				Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Algum campo esta com valor nulo impossibilitando o envio para o SAP. " + ls_Chave + "~r~rEntre em contato com a inform$$HEX1$$e100$$ENDHEX$$tica - o erro foi gravado no log da aplica$$HEX2$$e700e300$$ENDHEX$$o.")
			End If
			
			If lb_Sucesso Then
				Sqlca.of_Commit();
			Else
				SqlCa.of_RollBack();
			End If
																		
		Else // io_sap_comum.of_insere_log_exportacao_sap
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Log, StopSign!)
		End If
		
		w_aguarde.uo_progress.of_setprogress(ll_Linha)
	Next 
	
	If FileLength(gvo_Aplicacao.ivs_Arquivo_LOG) > lvl_Log Then
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Alguns documentos n$$HEX1$$e300$$ENDHEX$$o puderam ser exportados, verifique o log! ',Exclamation!,Ok!)
		ivo_api.of_Shell_execute('notepad.exe', gvo_Aplicacao.ivs_Arquivo_LOG)
	Else
		
		wf_renomeia_arquivo()
		
		dw_1.Object.nm_arquivo[1] = ''
		dw_2.Reset()
		
		MessageBox('Sucesso!','Os retornos foram enviados sem erros! ',Information!,Ok!)
	End If
	
finally
	Close(w_Aguarde)
end try				
				

end subroutine

public function boolean wf_monta_xml_cabecalho (string as_nr_atualizacao, string as_dt_documento, string as_dt_contabilizacao, string as_nr_documento_referencia, string as_texto_documento, ref string as_log, ref string as_xml_cabelho);String	ls_Inserir_Estornar, ls_Empresa_Est, ls_Doc_Est, ls_DT_Doc_Est

Long ll_Achou, ll_Achou2, ll_CC_Estornado, ll_Registros

as_xml_cabelho =		 				'<I_CABECALHO>'+&
											'<BUKRS>1000</BUKRS>'+&
											'<BELNR_EXT>' +as_nr_atualizacao+'</BELNR_EXT>'+&
											'<BLDAT>'+as_dt_documento+'</BLDAT>'+&
											'<BUDAT>'+as_dt_contabilizacao+'</BUDAT>'+&
											'<BLART>CC</BLART>'+&
											'<XBLNR>'+as_nr_documento_referencia+'</XBLNR>'+&
											'<BKTXT>'+as_texto_documento+'</BKTXT>'+&
											'<WAERS>BRL</WAERS>'+&
											'<ZSIST_ORIGEM>'+is_Origem_Legado+'</ZSIST_ORIGEM>'+&
/*I $$HEX1$$1320$$ENDHEX$$ Inserir / E $$HEX1$$1320$$ENDHEX$$ Estornar */		'<ZTIPO_LANC>I</ZTIPO_LANC>'+&
/*Empresa estornar*/				'<BUKRS_EST></BUKRS_EST>'+&
/*Doc Ext estornar*/					'<BELNR_EST></BELNR_EST>'+&
/*Data doc estorar*/					'<BLDAT_EST></BLDAT_EST>'+&
											'<ZFIM_ENVIO>X</ZFIM_ENVIO>'


							
Return True
end function

public function boolean wf_processa_envio_sap ();String ls_Log

is_Ambiente_SAP = 'PRD'

If is_Ambiente_SAP <> 'PRD' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o esta no BD produ$$HEX2$$e700e300$$ENDHEX$$o.")
	
End If
						
If Not gf_retorna_pametro_sap(SqlCa, is_Ambiente_SAP, 'CD_URL_CONTABIL_ENVIO', ref is_URL, ref ls_Log) Then
	MessageBox('Erro', ls_Log)
	Return False
End If

If Not gf_retorna_pametro_sap(SqlCa, is_Ambiente_SAP, 'CD_URL_CONTABIL_RETORNO', ref is_URL_Retorno, ref ls_Log) Then
	MessageBox('Erro', ls_Log)
	Return False
End If	

try
	
	gvb_Carrega_Contas_Mult = False
	
	io_sap_comum = Create uo_ge470_sap_comum 
	
	// Fecha o arquivo de log para n$$HEX1$$e300$$ENDHEX$$o dar erro quando tela do EX for utilizar o objeto, a abetura esta no construtor.
	FileClose (io_sap_comum.ii_log)
	
	wf_envia_sap()
		
finally
	
	Destroy(io_sap_comum)
end try
end function

public function string wf_monta_xml_item (string as_nr_atualizacao, string as_dt_documento, string as_tipo_conta, string as_nr_conta, string as_nr_atribuicao, string as_texto_item, string as_centro_custo, string as_centro_lucro, string as_cd_filial, string as_valor_movimento, string as_ref3, string as_forma_pagto);String	ls_XML_Item

String ls_NR_Item

il_Item_Documento ++

ls_NR_Item = String(il_Item_Documento) 

ls_XML_Item = '<I_ITEM>'+&
					'<BUKRS>1000</BUKRS>'+&
					'<BELNR_EXT>'+as_nr_atualizacao+'</BELNR_EXT>'+&
					'<BLDAT>'+as_dt_documento+'</BLDAT>'+&
					'<BUZEI>'+ls_NR_Item+'</BUZEI>'+&
					'<BUKRS_BAIXA></BUKRS_BAIXA>'+&
					'<BELNR_BAIXA></BELNR_BAIXA>'+&
					'<BLDAT_BAIXA></BLDAT_BAIXA>'+&
					'<BUZEI_BAIXA></BUZEI_BAIXA>'+&
					'<KOART>'+as_Tipo_Conta+'</KOART>'+&
					'<UMSKZ></UMSKZ>'+&
					'<ZCONTA>'+as_Nr_Conta+'</ZCONTA>'+&
					'<ZLSPR></ZLSPR>'+&
					'<ZFBDT></ZFBDT>'+&
					'<ZTERM></ZTERM>'+&
					'<ZLSCH>' + as_forma_pagto + '</ZLSCH>'+&
					'<ZUONR>'+as_Nr_Atribuicao+'</ZUONR>'+&
					'<SGTXT>'+as_Texto_Item+'</SGTXT>'+&
					'<KOSTL>' + as_centro_custo +  '</KOSTL>'+&
					'<PRCTR>'+as_Centro_Lucro+'</PRCTR>'+&
					'<BUPLA>'+as_Cd_Filial+'</BUPLA>'+&
					'<WRBTR>'+as_Valor_Movimento+'</WRBTR>'+&
					'<XREF1></XREF1>'+&
					'<XREF2></XREF2>'+&
					'<XREF3>' + as_ref3 +'</XREF3>'+&
					'<WERKS>' + as_Cd_Filial + '</WERKS>'+&
					'<GSBER>' + as_Cd_Filial + '</GSBER>'+&
					is_Termino_Item
							
Return ls_XML_Item
end function

public subroutine wf_renomeia_arquivo ();String ls_Arquivo, ls_Arquivo_Novo

integer li_FileNum

dw_1.AcceptText()

ls_Arquivo  = dw_1.Object.nm_arquivo[1]

If IsNull(ls_Arquivo) or Trim(ls_Arquivo) = '' Then Return

ls_Arquivo_Novo = Mid (ls_Arquivo, 1, Len(ls_Arquivo) -3) + 'OK'
 
li_FileNum = FileMove (ls_Arquivo, ls_Arquivo_Novo)

If li_FileNum <> 1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao mover o arquivo '" + ls_Arquivo + "'.")
End If


end subroutine

public function boolean wf_valida_cpf ();Long ll_Linha, ll_Achou

String ls_CPF

For ll_Linha = 1 To dw_2.RowCount()
	If IsNull(dw_2.Object.cd_filial[ll_Linha]) Then
		
		ls_CPF = dw_2.Object.nr_cpf[ll_Linha]
		
		If LenA(ls_CPF) = 14 Then
			If Not gf_CGC_Valido(ls_CPF, False) Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe um CNPJ v$$HEX1$$e100$$ENDHEX$$lido.", Exclamation!)
				dw_2.Event ue_Pos(ll_Linha, "nr_cpf")
				Return False
			End If
		Else
			If Not gf_Valida_CPF(ls_CPF) Then
				//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe um CPF v$$HEX1$$e100$$ENDHEX$$lido.", Exclamation!)
				dw_2.Event ue_Pos(ll_Linha, "nr_cpf")
				Return False
			End If			
		End If
		
		Select count(*)
		Into :ll_Achou
		From cliente
		where nr_cpf_cgc = :ls_CPF
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do cliente")
			Return False
		End If
		
		If ll_Achou = 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existe cliente cadastrado com o CPF/CNPJ ["  + ls_CPF +  "].")
			dw_2.Event ue_Pos(ll_Linha, "nr_cpf")
			Return False
		End If
		
	End If
Next

Return True
end function

public function boolean wf_leitura_ret_txt (string as_arquivo);Integer li_Arquivo

Try
	
	Open(w_Aguarde)
	w_Aguarde.Title = "Lendo o Arquivo ..."
	
	li_Arquivo = FileOpen(as_Arquivo, LineMode!, Read!, LockRead!)

	If li_Arquivo = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na Abertura do Arquivo '" + as_Arquivo + "'.")
		Return False
	End If
	
	If Not wf_processa_arquivo_ret(as_Arquivo, li_Arquivo) Then Return False

	Return True
	
Finally
	FileClose(li_Arquivo)
	If IsValid(w_Aguarde) Then Close(w_Aguarde)
End Try
end function

public function boolean wf_processa_arquivo_ret (string as_arquivo, integer ai_arquivo);Date ldt_Movimento, ldh_Emissao

Decimal ldc_Valor, ldc_Valor_Acumulado, ldc_Valor_Arq, ldc_Cheque_Loja, ldc_Valor_Arq_Total, ldc_Vlor_Min, ldc_Vlor_Max

Integer li_Read

Long ll_Insert, ll_Filial, ll_Nulo

String ls_Registro, ls_Nulo, ls_Conta_Pesquisa, ls_Cheque_Pesquisa, ls_MSG

String ls_Banco, ls_Agencia, ls_Cheque, ls_CPF, ls_Filial_SAP, ls_CMC7, ls_Agencia_DV, ls_Camara, ls_Tipificacao, ls_Conta_DV, ls_Conta, ls_Cheque_DV, ls_CPF_Arq

dw_2.SetRedraw(false)

SetNull(ll_Nulo)
SetNull(ls_Nulo)

li_Read = FileRead(ai_Arquivo, ls_Registro)

If li_Read <= 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na primeira leitura do arquivo '" + as_Arquivo + "'.", StopSign!)
	Return False
End If

//ldh_Emissao = RelativeDate(Date(gf_GetServerDate()), 
	
Do While li_Read > 0
	
	If MidA(ls_Registro,1,1) = 'H' or MidA(ls_Registro,1,1) = 'T' Then
//		If MidA(ls_Registro,1,1) = 'H' Then
//			ldt_Movimento = Date(MidA(ls_Registro,46,4) + '/' +  MidA(ls_Registro,50,2) + '/' + MidA(ls_Registro,52,2))
//		End If
		
		If MidA(ls_Registro,1,1) = 'T' Then
			If Not wf_valor_decimal(MidA(ls_Registro,80,15), ref ldc_Valor_Arq) Then Return False
			ldc_Valor_Arq_Total = ldc_Valor_Arq_Total + ldc_Valor_Arq
		End If
		
		li_Read = FileRead(ai_Arquivo, ls_Registro)
		Continue
	End If
		
//	If MidA(ls_Registro,51,2) <> "00" Then
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O arquivo de retorno do banco est$$HEX1$$e100$$ENDHEX$$ diferente do esperado [DEP$$HEX1$$d300$$ENDHEX$$SITO].", Exclamation!)
//		Return False
//	End If
	
	ll_Insert = dw_2.InsertRow(0)
	
	ldt_Movimento  = Date(MidA(ls_Registro,71,4) + '/' +  MidA(ls_Registro,75,2) + '/' + MidA(ls_Registro,77,2))
	
	dw_2.Object.dh_movimento	[ll_Insert] = ldt_Movimento
	
	ldh_Emissao = Relativedate(ldt_Movimento, -60)
	
	dw_2.Object.cd_camara		[ll_Insert] = MidA(ls_Registro,1,3)
	
	dw_2.Object.cd_banco		[ll_Insert] = MidA(ls_Registro,4,3)
	
	dw_2.Object.cd_agencia		[ll_Insert] = MidA(ls_Registro,7,4)
	dw_2.Object.cd_agencia_dv[ll_Insert] = MidA(ls_Registro,11,1)
	
	//
	dw_2.Object.cd_conta		[ll_Insert] = MidA(ls_Registro,14,10)
	
	dw_2.Object.cd_conta_dv	[ll_Insert] = MidA(ls_Registro,24,1)
	
	dw_2.Object.nr_cheque		[ll_Insert] = MidA(ls_Registro,25,6)
	dw_2.Object.nr_cheque_dv	[ll_Insert] = MidA(ls_Registro,31,1)
	
	dw_2.Object.id_tipificacao	[ll_Insert] = MidA(ls_Registro,53,1)
	
	ls_CPF_Arq = gf_tira_zero_esquerda(MidA(ls_Registro,127,14))
			
	If Not wf_valor_decimal(MidA(ls_Registro,34,17), ref ldc_Valor) Then Return False
	
	dw_2.Object.vl_cheque	[ll_Insert] = ldc_Valor
	
	ls_Banco 		= dw_2.Object.cd_banco			[ll_Insert]
	
	ls_Conta			= dw_2.Object.cd_conta			[ll_Insert]
	ls_Conta_DV	= dw_2.Object.cd_conta_dv		[ll_Insert]
	
	ls_Agencia		= dw_2.Object.cd_agencia		[ll_Insert]
	ls_Agencia_DV	= dw_2.Object.cd_agencia_dv	[ll_Insert]
	
	ls_Cheque 		= dw_2.Object.nr_cheque		[ll_Insert]
	ls_Cheque_DV	=  dw_2.Object.nr_cheque_dv	[ll_Insert]
	
	ls_Camara 		= dw_2.Object.cd_camara		[ll_Insert]
	ls_Tipificacao 	= dw_2.Object.id_tipificacao	[ll_Insert]
	
	ls_CMC7 = ls_Banco + ls_Agencia + ls_Agencia_DV
	ls_CMC7 +=  ls_Camara + ls_Cheque + ls_Tipificacao 
	ls_CMC7 += ls_Conta_DV + ls_Conta + ls_Cheque_DV
	
	select c.nr_cpf_cliente, c.cd_filial_inclusao, i.cd_chave_sap, c.vl_cheque
	Into :ls_CPF, :ll_Filial, :ls_Filial_SAP, :ldc_Cheque_Loja
	From cheque c
	left outer join integracao_sap i
		 on i.cd_empresa = 1000
		 and i.cd_tabela = 'FILIAL'
		 and i.cd_chave_legado = cast(c.cd_filial_inclusao as varchar)
	Where c.cd_banco 	= :ls_Banco
	  and c.nr_agencia 	= :ls_Agencia
	 // and c.nr_conta 		= :ls_Conta
	  //and c.nr_cheque 	   = :ls_Cheque
	  and c.nr_cmc7    = :ls_CMC7
	Using SqlCa;
	
	Choose Case Sqlca.SqlCode
		Case 0
		Case 100
			
			ls_Conta_Pesquisa		= Right(ls_Conta, 6)
			ls_Cheque_Pesquisa	= Right(ls_Cheque, 6)
						
			select c.nr_cpf_cliente, c.cd_filial_inclusao, i.cd_chave_sap, c.vl_cheque
			Into :ls_CPF, :ll_Filial, :ls_Filial_SAP, :ldc_Cheque_Loja
			From cheque c
			left outer join integracao_sap i
				 on i.cd_empresa = 1000
				 and i.cd_tabela = 'FILIAL'
				 and i.cd_chave_legado = cast(c.cd_filial_inclusao as varchar)
			Where c.cd_banco 	= :ls_Banco
			  and c.nr_agencia 	= :ls_Agencia
		  	  and c.nr_conta 		like '%' + :ls_Conta_Pesquisa
			  and c.nr_cheque 	   	like '%' + :ls_Cheque_Pesquisa
			  and c.vl_cheque 		= :ldc_Valor
			  and c.dh_emissao >= :ldh_Emissao
			  and c.dh_vencimento <= :ldt_Movimento
			Using SqlCa;
			
			Choose Case SqlCa.SqlCode
				Case 0
				Case 100
					
					select c.nr_cpf_cliente, c.cd_filial_inclusao, i.cd_chave_sap, c.vl_cheque
					Into :ls_CPF, :ll_Filial, :ls_Filial_SAP, :ldc_Cheque_Loja
					From cheque c
					left outer join integracao_sap i
						 on i.cd_empresa = 1000
						 and i.cd_tabela = 'FILIAL'
						 and i.cd_chave_legado = cast(c.cd_filial_inclusao as varchar)
					Where c.cd_banco 	= :ls_Banco
					  and c.nr_agencia 	= :ls_Agencia
					  and c.nr_conta 		like '%' + :ls_Conta_Pesquisa
					  and c.vl_cheque 		= :ldc_Valor
				   	  and c.dh_emissao >= :ldh_Emissao
			  		  and c.dh_vencimento <= :ldt_Movimento
					Using SqlCa;
					
					Choose Case SqlCa.SqlCode
						Case 0
						Case 100
							
							If ldc_Valor >= 10.00 Then
								ldc_Vlor_Min 	= ldc_Valor - 10.00
								ldc_Vlor_Max 	= ldc_Valor + 10
							Else
								ldc_Vlor_Min = 0.00
							End If
							 
							select top 1 c.nr_cpf_cliente, c.cd_filial_inclusao, i.cd_chave_sap, c.vl_cheque
							Into :ls_CPF, :ll_Filial, :ls_Filial_SAP, :ldc_Cheque_Loja
							From cheque c
							left outer join integracao_sap i
								 on i.cd_empresa = 1000
								 and i.cd_tabela = 'FILIAL'
								 and i.cd_chave_legado = cast(c.cd_filial_inclusao as varchar)
							Where c.cd_banco 	= :ls_Banco
							  and c.nr_agencia 	= :ls_Agencia
							  and c.nr_conta 		like '%' + :ls_Conta_Pesquisa
							  and c.dh_emissao >= :ldh_Emissao
			  		  		  and c.dh_vencimento <= :ldt_Movimento
							  and c.vl_cheque >= :ldc_Vlor_Min
							  and c.vl_cheque <= :ldc_Vlor_Max
							order by dh_emissao desc
							Using SqlCa;
							
							Choose Case Sqlca.SqlCode
								Case 0
								Case 100
									
									ls_Cheque_Pesquisa = gf_tira_zero_esquerda(ls_Cheque_Pesquisa)
									
									select c.nr_cpf_cliente, c.cd_filial_inclusao, i.cd_chave_sap, c.vl_cheque
									Into :ls_CPF, :ll_Filial, :ls_Filial_SAP, :ldc_Cheque_Loja
									From cheque c
									left outer join integracao_sap i
										 on i.cd_empresa = 1000
										 and i.cd_tabela = 'FILIAL'
										 and i.cd_chave_legado = cast(c.cd_filial_inclusao as varchar)
									Where c.cd_banco 	= :ls_Banco
									  and c.nr_agencia 	= :ls_Agencia
									  and c.nr_cheque like '%'+ :ls_Cheque_Pesquisa
									  and c.dh_emissao >= :ldh_Emissao
									  and c.dh_vencimento <= :ldt_Movimento
									  and c.vl_cheque = :ldc_Valor
									Using SqlCa;
									
									Choose Case SqlCa.SqlCode
										Case 0
										Case 100
											ls_MSG += ls_Banco + '/' + ls_Agencia + '/' + ls_Conta + '/' + ls_Cheque + "/" + String(ldc_Valor) + char(13) + char(10)
									
											ls_CPF 				= ls_Nulo
											ldc_Cheque_Loja 	= 0.00
											ls_CMC7 				= ""
											ll_Filial 				= ll_Nulo
											ls_Filial_SAP 		= ls_Nulo
										Case -1
											SqlCa.of_MsgDbError("Erro ao localizar o cheque. (5)")
											Return False
									End Choose
																		

								Case -1 
									SqlCa.of_MsgDbError("Erro ao localizar o cheque. (4)")
									Return False
							End Choose
							
						Case -1
							SqlCa.of_MsgDbError("Erro ao localizar o cheque. (3)")
							Return False
						End Choose
						
				Case -1
					SqlCa.of_MsgDbError("Erro ao localizar o cheque. (2)")
					Return False
			End Choose

		Case -1
			SqlCa.of_MsgDbError("Erro ao localizar o cheque. (1)")
			Return False
	End Choose	
	
	dw_2.Object.cd_filial				[ll_Insert] = ll_Filial
	dw_2.Object.cd_filial_sap		[ll_Insert] = Long(ls_Filial_SAP)
	dw_2.Object.nr_cpf				[ll_Insert] = ls_CPF
	dw_2.Object.vl_cheque_loja		[ll_Insert] = ldc_Cheque_Loja
	dw_2.Object.nr_cmc7				[ll_Insert] = ls_CMC7
	
	dw_2.Object.id_xls				[ll_Insert] = 0
	
	dw_2.Object.vl_diferenca		[ll_Insert]  = dw_2.Object.vl_cheque	[ll_Insert]  - dw_2.Object.vl_cheque_loja [ll_Insert] 
					
	ldc_Valor_Acumulado = ldc_Valor_Acumulado + ldc_Valor
	
	li_Read = FileRead(ai_Arquivo, ls_Registro)
Loop

dw_2.GroupCalc()

dw_2.SetRedraw(true)

If ls_MSG <> '' Then
	Messagebox("Cheques n$$HEX1$$e300$$ENDHEX$$o Localizados", "Cheques [BCO/AG/CONTA/CH/VLR]: "  + char(13) + char(10) + ls_MSG)
End If

//If ldc_Valor_Arq_Total <> ldc_Valor_Acumulado Then
//	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'O valor dos cheques esta diferente do arquivo.')
//	dw_2.Reset()
//End If
	
Return True
end function

public function boolean wf_leitura_ret_xls (string as_arquivo);Boolean lb_Sucesso = True

Any la_Dado

Date ldh_Movmto
Date ldh_Emissao

Decimal ldc_Valor

Long ll_Linha
Long ll_Linhas
Long ll_Cheque
Long ll_Filial
Long ll_Insert

String ls_Banco
String ls_Agencia
String ls_CPF
String ls_Filial_SAP
String ls_MSG

String ls_Conta_Pla
String ls_Conta_Pesq

String ls_CMC7

Decimal ldc_Valor_Fil

Try
	dc_uo_excel lo_Excel
	lo_Excel = Create dc_uo_excel
	
	Open(w_Aguarde)
	w_Aguarde.Title = "Lendo a planilha..."
	
	dw_2.setredraw( False)
	
	// Refer$$HEX1$$ea00$$ENDHEX$$ncia o Arquivo 
	If ( lo_Excel.uo_Referencia_Objeto_Excel(as_Arquivo) ) Then
		// Coluna de Refer$$HEX1$$ea00$$ENDHEX$$ncia
		ll_Linhas = lo_Excel.uo_Verifica_Tamanho_Arquivo("A") 
		
		If ll_Linhas > 0 Then
			w_Aguarde.uo_Progress.of_SetMax(ll_Linhas)
					
			For ll_Linha = 1 To ll_Linhas
				// Movimento
				la_Dado = lo_Excel.uo_Lendo_Dados(ll_Linha, "A")
				If Not IsDate (Mid(string(la_Dado), 1, 10)) Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ uma data v$$HEX1$$e100$$ENDHEX$$lida na coluna 'A' da linha: " + String(ll_Linha), Exclamation!)
					Continue
				End If
				ldh_Movmto = Date(Mid(string(la_Dado), 1, 10))
				
				// Cheque
				la_Dado 		= lo_Excel.uo_Lendo_Dados(ll_Linha, "B")
				ll_Cheque 	= Long(la_Dado) 
				
				// Conta
				ls_Conta_Pla 	= String(lo_Excel.uo_Lendo_Dados(ll_Linha, "C"))
				// Descarta o $$HEX1$$fa00$$ENDHEX$$ltimo n$$HEX1$$fa00$$ENDHEX$$mero que $$HEX1$$e900$$ENDHEX$$ o ultimo n$$HEX1$$fa00$$ENDHEX$$mero do CMC7
				ls_Conta_Pesq 	= Mid(ls_Conta_Pla, 1, len(ls_Conta_Pla) -1 )
															
				// Valor
				la_Dado = lo_Excel.uo_Lendo_Dados(ll_Linha, "D")
				If Not IsNumber (string(la_Dado)) Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ um valor v$$HEX1$$e100$$ENDHEX$$lido na coluna 'D' da linha: " + String(ll_Linha), Exclamation!)
					Continue
				End If
				ldc_Valor = Round(Dec(la_Dado), 2)
				
				ldh_Emissao = Relativedate(ldh_Movmto, -120)
				
//				select c.cd_banco, c.nr_agencia, c.cd_filial_inclusao, c.nr_cpf_cliente, c.vl_cheque, i.cd_chave_sap
//				Into :ls_Banco, :ls_Agencia, :ll_Filial, :ls_CPF, :ldc_Valor_Fil, :ls_Filial_SAP
//				from cheque c
//				left outer join integracao_sap i
//					 on i.cd_empresa = 1000
//					 and i.cd_tabela = 'FILIAL'
//					 and i.cd_chave_legado = cast(c.cd_filial_inclusao as varchar)
//				where  cast(c.nr_cheque as integer) = :ll_Cheque
//					and cast(right(nr_conta, 6) + RIGHT(c.nr_cmc7, 1) as integer) = :ll_Conta
//					and  c.vl_cheque = :ldc_Valor
//				  and c.dh_emissao >= :ldh_Emissao
//				Using SqlCa;

				select c.cd_banco, c.nr_agencia, c.cd_filial_inclusao, c.nr_cpf_cliente, c.vl_cheque, i.cd_chave_sap, c.nr_cmc7
				Into :ls_Banco, :ls_Agencia, :ll_Filial, :ls_CPF, :ldc_Valor_Fil, :ls_Filial_SAP, :ls_CMC7
				from cheque c
				left outer join integracao_sap i
					 on i.cd_empresa = 1000
					 and i.cd_tabela = 'FILIAL'
					 and i.cd_chave_legado = cast(c.cd_filial_inclusao as varchar)
				where  cast(c.nr_cheque as integer) = :ll_Cheque
					and c.nr_conta like '%' + :ls_Conta_Pesq + '%'
					and  c.vl_cheque = :ldc_Valor
					 and c.dh_emissao >= :ldh_Emissao
				Using SqlCa;
				
				Choose Case SqlCa.SqlCode 
					Case 0
					Case 100
						SetNull(ls_Banco)
						SetNull(ls_Agencia)
						SetNull(ll_Filial)
						SetNull(ls_Filial_SAP)
						SetNull(ls_CPF)
						SetNull(ldc_Valor_Fil)
						SetNull(ls_CMC7)
						
						ls_MSG += String(ll_Cheque) + '/' + ls_Conta_Pla + '/' + String(ldc_Valor) + char(13) + char(10)
					Case -1
						SqlCa.of_MsgDbError("Erro ao localizar o cheque." )
						lb_Sucesso = False
						Return False
				End choose
				
				ll_Insert = dw_2.InsertRow(0)
				
				dw_2.Object.dh_movimento	[ll_Insert] = ldh_Movmto
				dw_2.Object.cd_banco		[ll_Insert] = ls_Banco
				dw_2.Object.cd_agencia		[ll_Insert] = ls_Agencia
				dw_2.Object.cd_conta		[ll_Insert] = ls_Conta_Pla
				dw_2.Object.nr_cheque		[ll_Insert] = String(ll_Cheque)
				dw_2.Object.cd_filial			[ll_Insert] = ll_Filial
				dw_2.Object.cd_filial_sap	[ll_Insert] = Long(ls_Filial_SAP)
				dw_2.Object.nr_cpf			[ll_Insert] = ls_CPF	
				dw_2.Object.nr_cmc7			[ll_Insert] = ls_CMC7	
				
				dw_2.Object.vl_cheque_loja	[ll_Insert] = ldc_Valor_Fil		
				dw_2.Object.vl_cheque		[ll_Insert] = ldc_Valor	
				
				dw_2.Object.id_xls			[ll_Insert] = 1
				
				dw_2.Object.vl_diferenca	[ll_Insert] = dw_2.Object.vl_cheque[ll_Insert] - dw_2.Object.vl_cheque_loja[ll_Insert]
	
			Next
			
			If ls_MSG <> '' Then
				Messagebox("Cheques n$$HEX1$$e300$$ENDHEX$$o Localizados", "Cheques [CH/CONTA/VLR]: "  + char(13) + char(10) + ls_MSG)
			End If		
			
			If Not lb_Sucesso Then
				dw_2.Reset()
			End If			
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A planilha est$$HEX1$$e100$$ENDHEX$$ em branco.")
			Return False
		End If
	End If
	
Finally
	dw_2.setredraw(True)
	Close(w_Aguarde)
	If IsValid(lo_Excel) Then Destroy(lo_Excel)
End Try
Return True
end function

on w_ge469_cheque_custodia.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.pb_1=create pb_1
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.pb_1
this.Control[iCurrent+3]=this.st_1
end on

on w_ge469_cheque_custodia.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
destroy(this.pb_1)
destroy(this.st_1)
end on

event ue_postopen;call super::ue_postopen;is_Inicio_XML 	=	'<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:imp="importa_sap.com">'+&
						'<soapenv:Header/>'+&
						'<soapenv:Body>'+&
						'<imp:MT_REQUEST_CONTABIL>'
								
is_Termino_XML ='</imp:MT_REQUEST_CONTABIL>'+&
						'</soapenv:Body>'+&
						'</soapenv:Envelope>'	
						
ivo_api 					= Create dc_uo_api



This.ivm_Menu.mf_Incluir(False)
This.ivm_Menu.mf_Recuperar(False)

This.ivm_Menu.mf_SalvarComo(True)


end event

event close;call super::close;Destroy(ivo_api)
end event

type dw_visual from dc_w_cadastro_selecao_lista`dw_visual within w_ge469_cheque_custodia
end type

type gb_aux_visual from dc_w_cadastro_selecao_lista`gb_aux_visual within w_ge469_cheque_custodia
end type

type dw_1 from dc_w_cadastro_selecao_lista`dw_1 within w_ge469_cheque_custodia
integer x = 64
integer y = 68
integer width = 2597
integer height = 108
string dataobject = "dw_ge469_selecao"
end type

type gb_2 from dc_w_cadastro_selecao_lista`gb_2 within w_ge469_cheque_custodia
integer y = 216
integer width = 3575
integer height = 1376
end type

type gb_1 from dc_w_cadastro_selecao_lista`gb_1 within w_ge469_cheque_custodia
integer width = 2665
integer height = 180
integer weight = 700
end type

type dw_2 from dc_w_cadastro_selecao_lista`dw_2 within w_ge469_cheque_custodia
integer y = 292
integer width = 3497
integer height = 1276
string dataobject = "dw_ge469_lista"
end type

event dw_2::ue_postretrieve;call super::ue_postretrieve;Parent.ivm_Menu.mf_Excluir(False)

If pl_Linhas > 0 Then
	dw_2.ivo_Controle_Menu.of_SalvarComo(True)
Else
	dw_2.ivo_Controle_Menu.of_SalvarComo(False)
End If

Return AncestorReturnValue
end event

event dw_2::getfocus;call super::getfocus;This.ivm_Menu.mf_Excluir(False)

// Habilitar a ordena$$HEX2$$e700e300$$ENDHEX$$o na coluna
This.ivb_Ordena_Colunas = True
end event

type cb_1 from commandbutton within w_ge469_cheque_custodia
integer x = 3205
integer y = 1616
integer width = 402
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Enviar SAP"
end type

event clicked;If dw_2.RowCount() > 0 Then
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma o envio dos retornos para o SAP ?", Question!, YesNo!, 2) = 1 Then
		wf_processa_envio_sap()
	End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existem retornos para serem enviados para o SAP.")
End If
end event

type pb_1 from picturebutton within w_ge469_cheque_custodia
integer x = 2747
integer y = 64
integer width = 119
integer height = 96
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "none"
boolean originalsize = true
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\localizar_arquivo.bmp"
alignment htextalign = left!
end type

event clicked;Boolean lb_Planilha

Integer lvi_Arquivo

String lvs_Path, &
       lvs_Arquivo,&
		 ls_Extensao

//lvi_Arquivo = GetFileOpenName("Selecione o Arquivo de Retorno", lvs_Path, lvs_Arquivo, "", "Retornos (*.RET), *.RET")

lvi_Arquivo = GetFileOpenName("Selecione o Arquivo de Retorno", lvs_Path, lvs_Arquivo, "", "Retornos (*.RET), *.RET,Excel 2007 (*.XLSX),*.XLSX,Excel (*.XLS), *.XLS")

If lvi_Arquivo = 1 Then
	dw_1.Object.nm_arquivo[1] = Upper(lvs_Path)

	dw_2.Event ue_Reset()
	
	ls_Extensao = Lower(Right(lvs_Arquivo, 4))
		
	If ls_Extensao = '.ret' Then
		lb_Planilha = False
	ElseIf ls_Extensao = '.xls'  or ls_Extensao = 'xlsx' Then
		lb_Planilha = True
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tipo de arquivo n$$HEX1$$e300$$ENDHEX$$o previsto para importa$$HEX2$$e700e300$$ENDHEX$$o.")
		Return
	End If
	
	If lb_Planilha Then
		
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Os dados da PLANILHA devem estar da seguinte forma:~r~r" + &
							+ "Coluna A = Data do Movimento~r" + &
							+ "Coluna B = N$$HEX1$$fa00$$ENDHEX$$mero do Cheque~r" + &
							+ "Coluna C = N$$HEX1$$fa00$$ENDHEX$$mero da Conta~r" + &
							+ "Coluna D = Valor", Question!, YesNo!, 2 ) = 1 Then
			wf_leitura_ret_xls(lvs_Path)
		End If
		
	Else
		If Not wf_leitura_ret_txt(lvs_Arquivo) Then Return -1
	End If
		
	dw_2.Sort()
	
Else
	dw_1.Object.nm_arquivo[1] = ""
End If
end event

type st_1 from statictext within w_ge469_cheque_custodia
integer x = 46
integer y = 1620
integer width = 2153
integer height = 72
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Os documentos estar$$HEX1$$e300$$ENDHEX$$o dispon$$HEX1$$ed00$$ENDHEX$$veis no SAP at$$HEX1$$e900$$ENDHEX$$ 30 minutos ap$$HEX1$$f300$$ENDHEX$$s o envio"
boolean focusrectangle = false
end type

