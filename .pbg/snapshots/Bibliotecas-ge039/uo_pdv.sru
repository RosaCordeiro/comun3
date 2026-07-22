HA$PBExportHeader$uo_pdv.sru
forward
global type uo_pdv from nonvisualobject
end type
end forward

global type uo_pdv from nonvisualobject
end type
global uo_pdv uo_pdv

type prototypes
function integer ECFOpen(long numero, long tempo, long log, long mostra) library 'SWECF.DLL' ;
function integer ECFClose() library 'SWECF.DLL';
function long    ECFWrite(REF String Comando) library 'SWECF.DLL' alias for "ECFWrite;Ansi" ;
function long    ECFRead (REF String Status, Long Extensao) library 'SWECF.DLL' alias for "ECFRead;Ansi" ;

FUNCTION Long genkkey(Ref String cChavePublica, Ref String cChavePrivada) LIBRARY "C:\Sistemas\DLL\bematech\sign_bema.dll" alias for "genkkey;Ansi";
FUNCTION Long setLibType(Integer Tipo) LIBRARY "C:\Sistemas\DLL\bematech\sign_bema.dll";
FUNCTION Long generateEAD(String cArquivo, String cChavePublica, String cChavePrivada, Ref String cEAD, Integer iSign) LIBRARY "C:\Sistemas\DLL\bematech\sign_bema.dll" alias for "generateEAD;Ansi";
FUNCTION Long validateFile(String cNomeArquivo, String cChavePublica, String cChavePrivada) LIBRARY "C:\Sistemas\DLL\bematech\sign_bema.dll" alias for "validateFile;Ansi";
FUNCTION Long md5FromFile(String cNomeArquivo, Ref String cMD5) LIBRARY "C:\Sistemas\DLL\bematech\sign_bema.dll" alias for "md5FromFile;Ansi";
end prototypes

type variables
uo_bematech		ivo_bematech
uo_sweda			ivo_sweda
uo_epson			ivo_epson
uo_daruma		ivo_Daruma
uo_ge039_nfce ivo_nfce
uo_ge039_sat   ivo_sat

//VARIAVES _nfce TAMBEM SAO USADAS NO OBJETO SAT

STRING ivs_status

STRING Fabricante
STRING Modelo
String nr_Serie

BOOLEAN ivb_cancelar     = FALSE
BOOLEAN ivb_showerror    = TRUE
BOOLEAN ivb_gaveta       = FALSE
BOOLEAN ivb_modo_teste   = FALSE
BOOLEAN ivb_porta_aberta = FALSE
BOOLEAN ivb_Ativa        		= FALSE
BOOLEAN ivb_Cadastrada   	= FALSE
BOOLEAN ivb_Iniciou_Erro = FALSE
BOOLEAN ivb_Atualizou_Registro = FALSE
BOOLEAN ivb_Aviso_cupom_aberto = FALSE

LONG ECF
LONG Porta
LONG Timeout
LONG ivl_seq_historico

STRING ivs_Path_Log
STRING ivs_Versao

STRING ivs_Tipo_Venda // gvs_Tipo_Venda
STRING ivs_Matricula_Cancelamento_Venda //gvs_matricula_cancelamento_venda
STRING ivs_unidade_federacao

STRING ivs_ChavePublica = "9716BE0910DB085542B39EE19383F3EB45A32D8962D57FFC6DAF0F04B872F52EF36F144131F6923B1A9EA73F13527A9CFD5A26F688505FC63ED9F95D240BF9D3A9655E26AE6AB706A1633693FCB3048A750E4B15EAE98F64EF6E941A78422E7ECB1D126C268DF5FA8E228A2CDD5206CE50B4D15D14B99906604C73E6DF807939"
STRING ivs_ChavePrivada = "C59A1793009F74E975542E2841C840B34D8C45143D5B761DE1FADFE447289D4308452A882AED183FB5781A1C23AED97726023C3710161C68ABA7275AE9826119C3BD9FC24E4C6DE977B674EDA0CE56F4E1F3884F51230A10CAF8362FE4C758A1DD0F9F50F0810F8507E8419884BAA981771B5EACE835E94EB62CDE4DAFE73D21"

STRING nr_chave_nfce
STRING cd_status_nfce
STRING de_motivo_nfce
STRING cd_protocolo_nfce
DateTime dt_data_nfce
STRING cd_caixa
STRING nm_impressora_nfce
STRING id_recria_gt

//datastore ids_aliquotas
dc_uo_ds_base ids_aliquotas
end variables

forward prototypes
public function string of_parametro28 (string ps_parametro)
public subroutine of_msg_impressoraoffline ()
public function string of_converte_indicador (string ps_indicador)
public subroutine of_msg_cupom_aberto_gravado ()
public function boolean of_aguarda_execucao ()
public function boolean of_aguarda_execucao_comando_tef ()
public function boolean of_atualiza_venda_bruta (boolean pb_inicializa)
public function boolean of_conecta_impressora ()
public function boolean of_configuracoes ()
public function integer of_controle_caixa_conferido (long pl_ecf, long pl_seq)
public function boolean of_cupom_gravado (long pl_ecf, long pl_seq)
public function boolean of_dados_impressora (ref long pl_sequencial, ref long pl_ecf)
public function boolean of_data_ultima_reducaoz (ref date pdh_data)
public function boolean of_desconto_cupom (string ps_texto, decimal pd_valor)
public function boolean of_desconto_item (long pl_item, decimal pd_desconto, decimal pd_valor)
public function string of_desencripta (string ps_texto)
public function datetime of_dh_movimentacao ()
public function boolean of_fecha_comprovante_tef ()
public function boolean of_grava_mapa_resumo (datetime pdt_data)
public function boolean of_horario_verao ()
public function boolean of_horario_verao_ajuste (string ps_modo)
public function boolean of_horario_verao_parametros (ref date adt_inicio, ref date adt_termino)
public function string of_indicador_aliquota (decimal pd_aliquota, string ps_tributacao_icms)
public function boolean of_inicializa_comprovante_tef_nao_fiscal (string ps_tipo_recebimento, string ps_descricao, string ps_tipo_pagamento, decimal pdc_valor)
public function boolean of_mapa_resumo (ref s_ge039_mapa_resumo ps_mapa_resumo)
public subroutine of_msg_cancelamento_invalido ()
public subroutine of_msg_cupom_aberto ()
public function boolean of_path_log (string ps_path_log)
public function boolean of_pergunta_cancelacupom ()
public function boolean of_pergunta_deseja_imprimir_cheque ()
public function boolean of_pergunta_falta_papel ()
public function boolean of_pergunta_folha_solta ()
public function boolean of_pergunta_impressoraoffline ()
public function boolean of_pergunta_leiturax ()
public function boolean of_pergunta_posiciona_cheque ()
public function boolean of_pergunta_reducaoz ()
public function boolean of_permite_cancelamento_cupom ()
public function boolean of_porta_comunicacao ()
public function boolean of_reducaoz ()
public function boolean of_registra_cancelamento (long pl_ecf, long pl_seq)
public function boolean of_registra_item_vendido (string ps_produto, long pd_qtd, decimal pd_precounitario, decimal pd_precototal, string ps_descricao, decimal pd_aliquota, string ps_complemento, string ps_tributacao_icms, string ps_un)
public subroutine of_sleep (long pl_segundos)
public function integer of_statusok ()
public function boolean of_texto_nao_fiscal_tef (string ps_texto)
public function boolean of_timeout_ecf ()
public function boolean of_totaliza_cupom (string ps_tipo[], decimal pd_valor[])
public function boolean of_verifica_cupons_pendentes ()
public subroutine of_fechaporta ()
public function boolean of_datafiscal (ref date pd_datafiscal)
public function boolean of_horaecf (ref string ps_hora)
public function boolean of_dataecf (ref date pd_dataecf)
public function boolean of_atualiza_data_fiscal ()
public function boolean of_verifica_data_movimentacao ()
public function boolean of_cancela_cupom (long pl_ecf, long pl_seq)
public function boolean of_fecha_cupom_nao_fiscal (string ps_vinculado)
public function boolean of_fecha_cupom_nao_fiscal ()
public function boolean of_numero_ecf (ref long pl_ecf)
public function boolean of_verifica_problemas_impressora ()
public function boolean of_nr_ecf (ref long pl_ecf)
public function boolean of_dh_emissao (ref datetime pdh_datahora)
public function boolean of_inicializa_comprovante_tef (string ps_tipo_recebimento, string ps_descricao, string ps_tipo_pagamento, decimal pdc_valor, long pl_parcelas, string ps_cupom)
public function boolean of_verifica_drivers ()
public function boolean of_verifica_drivers_pafecf ()
public function boolean of_assinatura_digital (string ps_file)
public function boolean of_numero_serie ()
public function boolean of_leiturax (boolean pb_arquivo)
public function boolean of_leitura_memoria_fiscal (string ps_data_de, string ps_data_ate, boolean pb_arquivo, string id_tipo)
public function boolean of_leitura_memoria_fiscal_reducao (long pl_reducao_inicial, long pl_reducao_final, boolean pb_arquivo, string ps_tipo)
public function boolean of_leitura_totais (integer pi_tipo)
public function boolean of_leitura_memoria_fita_detalhe (string ps_tipo, string ps_inicio, string ps_final)
public function boolean of_inicializa_relatorio_gerencial (string ps_titulo, decimal pdc_valor)
public function boolean of_gera_arquivo_cotepe1704 (string ps_tipo, string ps_inicio, string ps_final, string ps_razao_social, string ps_endereco)
public function boolean of_leitura_memoria_fiscal_ac1704 (string ps_data_de, string ps_data_ate)
public function string of_encripta (string ps_texto)
public function boolean of_contador_cupom_fiscal (ref long ll_ccf)
public function boolean of_cancela_ultimo_cupom (boolean pb_confirmar)
public function boolean of_cancela_ultimo_cupom (boolean pb_confirmar, string ps_responsavel)
public function boolean of_capturar_md5 (string ps_arquivo, ref string ps_md5)
public function boolean of_verifica_venda_bruta_diaria ()
public function boolean of_registra_documento_ecf (string ps_documento, string ps_totalizador, decimal pdc_valor)
public function boolean of_emite_comprovante (string ps_titulo, string ps_texto[])
public function boolean of_cancela_item (integer pl_item)
public function boolean of_abreporta ()
public function boolean of_modo_impressora ()
public function boolean of_abre_gaveta ()
public function boolean of_emite_comprovante (string ps_titulo, string ps_texto[], decimal pdc_valor)
public function boolean of_sangria_caixa (decimal pdc_valor)
public function boolean of_suprimento_caixa (decimal pdc_valor)
public function boolean of_atualiza_cadastro_ecf ()
public function boolean of_inicializa_cupom (string ps_cpf_cgc)
public function boolean of_emite_comprovante (string ps_titulo, string ps_texto[], decimal pdc_valor, boolean pb_imprime_cod_barras, string ps_cod_barras)
public function boolean of_fecha_comprovante_tef_nao_finalizado ()
public function boolean of_fecha_relatorio_gerencial (boolean pb_fecha_normal)
public function boolean of_texto_relatorio_gerencial (string ps_texto)
public function boolean of_inicializa_comprovante_nao_fiscal (string ps_tipo_recebimento, string ps_descricao, string ps_tipo_pagamento, decimal pdc_valor)
public function boolean of_codigo_barras (integer pl_tipo, string ps_codigo, string ps_tamanho)
public function boolean of_converte_data_cat52 (date pd_data, ref string ps_extensao)
public function boolean of_gera_cat52 (string ps_arquivo, date pdh_data_fiscal)
public function boolean of_gera_cat52 (string ps_arquivo, date pdh_data_fiscal, ref string ps_arquivo_destino)
public function boolean of_assina_valida_nfce ()
public function boolean of_emitente_nfce ()
public function boolean of_envia_email_nfce (string ps_chave, string ps_mail, string ps_modo)
public function boolean of_consulta_nfce (string ps_chave, ref string ps_protocolo, ref string ps_status, ref string ps_motivo, ref datetime pdt_data_rec, ref string ps_chave_rec)
public function integer of_verifica_cancelamento_cupom (long pl_sequencia, long pl_ecf, string ps_tipo)
public function boolean of_cancela_nfce (string ps_tipo_cancelamento, string ps_chave, string ps_protocolo, string ps_justificativa, long pl_nota, string ps_especie, string ps_serie, string ps_responsavel, string ps_cpf)
public function string of_centraliza_texto (string ps_texto)
public subroutine of_quebra_linha (string ps_texto, integer pi_colunas, ref string ps_dados[])
public subroutine of_quebra_linha (string ps_texto, ref string ps_dados[])
public function boolean of_destinatario_nfce (string ps_cpf_cgc, string ps_codigo_cliente, string ps_nm_cliente, string ps_endereco, string ps_nr_endereco, string ps_bairro, string ps_cidade_ibge, string ps_nm_cidade, string ps_uf, string ps_email_xml, boolean pb_programa_governo, boolean pb_mesmo_cpf)
public function boolean of_verifica_aliquotas ()
public function boolean of_atualiza_primeira_venda_ecf (integer pl_ecf, datetime pdt_data, boolean pb_atualiza)
public function boolean of_data_hora_ecf (ref datetime pdt_data_hora)
public function boolean of_fecha_cupom (string ps_msg[], boolean pb_repete, string ps_indicadores[6, 2], string ps_vinculado, string ps_tipo_envio_nfce, string ps_email_envio, ref string ps_chave_nfce, ref string ps_status, ref string ps_motivo_rej, ref string ps_dir_xml, ref datetime pdt_data_recebimento, ref string ps_protocolo, ref long pl_retorno, decimal pdc_vl_recebido, decimal pdc_troco, string ps_emite_em_contingencia)
public function long of_ecf_caixa ()
public function boolean of_data_ultima_venda_sistema (ref datetime pdt_data_venda)
public function boolean of_retorna_doc_aberto (ref long pl_doc)
public function boolean of_imprime_nfce (string ps_chave_nota, string ps_protocolo, string ps_formato, string ps_contingencia, string ps_modo, decimal pdc_vl_recebido, decimal pdc_vl_troco, ref string ps_chave_retorno)
public function boolean of_gera_espelho_mfd_mensal (long pl_ecf, date pdt_data_fiscal)
public function boolean of_leitura_memoria_fita_detalhe (string ps_tipo, string ps_inicio, string ps_final, string ps_arquivo)
public function boolean of_gera_arquivo_mfd (string ps_tipo, string ps_inicio, string ps_final, string ps_endereco, string ps_origem, long pl_tipo_geracao, ref string ps_caminho_mfd)
public function boolean of_gera_cotepe_mensal (long pl_ecf, date pdt_data_fiscal)
public function boolean of_envia_ftp_mfd (string ps_caminho, string ps_arquivo, string ps_ano, string ps_mes, ref string ps_msg_ftp, boolean pb_cotepe)
public function boolean of_verifica_arquivos_pendentes (string ps_tipo)
public function boolean of_subtotal_cupom (ref string ps_subtotal)
public function boolean of_gera_arquivos_ecf (string ps_tipo, string ps_inicio, string ps_final, string ps_endereco, string ps_origem, long pl_espelhos, long pl_tipo_geracao, string ps_caminho_mfd, ref string ps_arquivo_gerado)
public function boolean of_verifica_venda_exame (string ps_tipo, string ps_tipo_cupom, long pl_ecf, long pl_nota_cupom, string ps_especie, string ps_serie)
public function boolean of_totais_nfce (decimal pd_total_bc, decimal pd_total_icms, decimal pd_total_bcst, decimal pd_total_st, decimal pd_total_produtos, decimal pd_total_frete, decimal pd_total_seg, decimal pd_total_desc, decimal pd_total_ii, decimal pd_total_ipi, decimal pd_total_pis, decimal pd_total_cofins, decimal pd_total_outros, decimal pd_total_nf, decimal pd_total_tributos, string ps_mod_frete, string ps_formas_pgto[], decimal ps_valores_pgto[], decimal pd_troco, ref string ps_chave_nota, string ps_observacao, string ps_dados_tef[], string ps_envia_responsavel, decimal ps_total_icms_desonerado, string ps_inf_adicional, string ps_inf_fisco, string ps_cnpj_intermediario, string ps_codigo_interm)
public function boolean of_cabecalho_nfce (string ps_nr_nf, string ps_forma_pagamento, string ps_natureza_operacao, datetime pdt_emissao, string ps_tipo_impressao, string ps_forma_emissao, string ps_finalidade, string ps_consumidor, string ps_ind_presenca, string ps_intermediador, string ps_cpf_transp, string ps_cnpj_transp, string ps_nome_transp, string ps_end_transp, string ps_cidade_transp, string ps_uf_transp)
public function boolean of_registra_item_nfce (long pl_item, string ps_produto, long pd_qtd, decimal pd_precounitario, decimal pd_precototal, string ps_descricao, decimal pd_aliquota, string ps_complemento, string ps_cst_tributacao_icms, string ps_un, long pl_classificacao_fiscal, long pl_natureza_operacao, decimal pd_valor_desconto, decimal pd_valor_imposto, string ps_icms_origem, string ps_pis_cofins, decimal pd_preco_praticado, ref decimal pd_valor_icms, ref decimal pd_valor_base_icms, string ps_cest, string ps_tributacao_icms_cadastro, string ps_codigo_barras, decimal pd_red_bc_icms_efe, decimal pd_bc_icms_efe, decimal pd_icms_efe, decimal pd_valor_icms_efe, string ps_beneficio, integer pi_nr_item, decimal pd_vl_icms_desonerado, string ps_id_motivo_desoneracao, string ps_codigo_sap, string ps_cst_pis_cofins)
end prototypes

public function string of_parametro28 (string ps_parametro);//
ps_parametro = UPPER(ps_parametro)
//
CHOOSE CASE ps_parametro
	CASE "SEQ"     ; RETURN TRIM(MidA(ivs_status,03,4))
	CASE "ITEM"    ; RETURN TRIM(MidA(ivs_status,07,3))	
	CASE "STATUS"  ; RETURN TRIM(MidA(ivs_status,10,1))
	CASE "TRANSA"  ; RETURN TRIM(MidA(ivs_status,11,8))
	CASE "ESCAPE"  ; RETURN TRIM(MidA(ivs_status,19,2))
	CASE "REDUCAO" ; RETURN TRIM(MidA(ivs_status,21,1))
	CASE "LIQ"     ; RETURN TRIM(MidA(ivs_status,22,12))
	CASE "BRUTO"   ; RETURN TRIM(MidA(ivs_status,34,12))
	CASE "ERRO"    ; RETURN TRIM(MidA(ivs_status,46,1))
	CASE "DATA"    ; RETURN TRIM(MidA(ivs_status,47,6))
	CASE "HORA"    ; RETURN TRIM(MidA(ivs_status,53,4))	
	CASE "VERAO"   ; RETURN TRIM(MidA(ivs_status,57,1))		
    CASE "MENERR"  ; RETURN TRIM(MidA(ivs_status,58,35))		
	CASE "ECF"     ; RETURN TRIM(MidA(ivs_status,93,3))		
	CASE "PAPEL"   ; RETURN TRIM(MidA(ivs_status,96,1))		
	CASE "ABREV"   ; RETURN TRIM(MidA(ivs_status,97,1))			
	CASE "FALTA"   ; RETURN TRIM(MidA(ivs_status,98,12))
	CASE "SOMA"    ; RETURN TRIM(MidA(ivs_status,110,12))
	CASE "FAZX"    ; RETURN TRIM(MidA(ivs_status,122,1))	
	CASE "ABRIR"   ; RETURN TRIM(MidA(ivs_status,123,1))
	CASE "PROG"    ; RETURN TRIM(MidA(ivs_status,124,1))
	CASE "VINC"    ; RETURN TRIM(MidA(ivs_status,125,1))
	CASE ELSE ; RETURN ""
END CHOOSE
//
end function

public subroutine of_msg_impressoraoffline ();//
Messagebox("Impressora Fiscal","Verifique se a impressora "+&
           "fiscal est$$HEX1$$e100$$ENDHEX$$ ligada e se os cabos est$$HEX1$$e300$$ENDHEX$$o corretamente "+&
   		  "conectados.", StopSign!)
//
end subroutine

public function string of_converte_indicador (string ps_indicador);Choose Case This.Fabricante 
	Case "Bematech"
		Return ivo_bematech.of_converte_indicador(ps_indicador)

	Case Else	
		Return ivo_sweda.of_converte_indicador(ps_indicador)
End Choose

end function

public subroutine of_msg_cupom_aberto_gravado ();//
MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","                               CUPOM FISCAL N$$HEX1$$c300$$ENDHEX$$O ENCERRADO~r~r" + &
							"O $$HEX1$$da00$$ENDHEX$$ltimo cupom fiscal impresso n$$HEX1$$e300$$ENDHEX$$o foi finalizado corretamente. " + &
							"Este cupom j$$HEX1$$e100$$ENDHEX$$ se encontra cadastrado no sistema. Utilize a tecla [F12] " + &
							"para efetuar o cancelamento deste cupom. ",Exclamation!)

end subroutine

public function boolean of_aguarda_execucao ();If This.ivb_Modo_Teste Then Return True

Choose Case This.Fabricante 
	Case "Bematech"
		Return ivo_bematech.of_aguarda_execucao()
		
	Case "Daruma"
		Return True

	Case "NFCE", "SAT"
		Return True
		
	Case "Epson"
		Return True
		
	Case Else	
		Return ivo_sweda.of_aguarda_execucao()
End Choose

end function

public function boolean of_aguarda_execucao_comando_tef ();Choose Case This.Fabricante 
	Case "Bematech"
		Return ivo_bematech.of_aguarda_execucao_comando_tef()
		
	Case "Daruma"
		Return True

	Case "NFCE", "SAT"
		Return True	
		
	Case "Epson"
		Return True
		
	Case Else	
		Return ivo_sweda.of_aguarda_execucao_comando_tef()
End Choose

end function

public function boolean of_atualiza_venda_bruta (boolean pb_inicializa);If This.ivb_Modo_Teste Then Return True

Choose Case This.Fabricante 
	Case "Bematech"
		Return ivo_bematech.of_atualiza_venda_bruta()
		
	Case "Daruma"
		Return ivo_Daruma.of_atualiza_venda_bruta()
		
	Case "NFCE", "SAT"
		Return True
		
	Case "Epson"
		Return ivo_epson.of_atualiza_venda_bruta()		
		
	Case Else	
		Return ivo_sweda.of_atualiza_venda_bruta()
End Choose

end function

public function boolean of_conecta_impressora ();Choose Case This.Fabricante 
	Case "Bematech"
		Return ivo_bematech.of_conecta_impressora()

	Case "NFCE", "SAT"
		Return True							
	Case Else	
		Return ivo_sweda.of_conecta_impressora()
End Choose

end function

public function boolean of_configuracoes ();Choose Case This.Fabricante 
	Case "Bematech"
		Return ivo_bematech.of_configuracoes()

	Case "NFCE", "SAT"
		Return True							
	Case Else	
		Return ivo_sweda.of_configuracoes()
End Choose


end function

public function integer of_controle_caixa_conferido (long pl_ecf, long pl_seq);DateTime lvdh_Movimento,&
         lvdh_Conferencia

lvdh_Movimento = This.of_dh_movimentacao()

SetPointer(HourGlass!)

Select controle_caixa.dh_conferencia Into :lvdh_Conferencia
From nf_venda,
     controle_caixa
Where nf_venda.nr_ecf                  = :pl_ecf
  and nf_venda.nr_operacao_ecf         = :pl_seq
  and nf_venda.dh_movimentacao_caixa   = :lvdh_Movimento
  and controle_caixa.cd_caixa          = nf_venda.cd_caixa
  and controle_caixa.nr_controle_caixa = nf_venda.nr_controle_caixa
Using Sqlca;  

If Sqlca.Sqlcode = -1 Then
	Sqlca.Of_MsgDbError("Verifica$$HEX2$$e700e300$$ENDHEX$$o do controle caixa")
	Return -1
ElseIf Sqlca.Sqlcode = 100 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Controle caixa referente ao cupom n$$HEX1$$e300$$ENDHEX$$o foi encontrado. ECF [" + String(pl_ecf,'000') + "] SEQ [" + String(pl_seq,'00000000') + "]",StopSign!)
	Return -1
End If	

If Not IsNull(lvdh_Conferencia) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Controle do Caixa referencia ao cupom fiscal j$$HEX1$$e100$$ENDHEX$$ foi conferido. ECF [" + String(pl_ecf,'000') + "] SEQ [" + String(pl_seq,'00000000') + "]" ,Exclamation!)
	Return -1
End If

Return 1
end function

public function boolean of_cupom_gravado (long pl_ecf, long pl_seq);Long     lvl_nr_nf

Datetime lvdh_Movimento

lvdh_Movimento = This.of_dh_movimentacao()

SetPointer(HourGlass!)

Select nf.nr_nf INTO :lvl_nr_nf
From nf_venda nf
Where nf.nr_ecf                = :pl_ecf
  and nf.nr_operacao_ecf       = :pl_seq
  and nf.dh_movimentacao_caixa = :lvdh_Movimento
Using Sqlca;

If Sqlca.Sqlcode = -1 Then
	Sqlca.Of_MsgDbError('Localiza$$HEX2$$e700e300$$ENDHEX$$o do cupom fiscal.')
	Return False
End If

//Cupom Fiscal n$$HEX1$$e300$$ENDHEX$$o foi localizado
If IsNull(lvl_nr_nf) OR lvl_nr_nf = 0 Then Return False

Return True
end function

public function boolean of_dados_impressora (ref long pl_sequencial, ref long pl_ecf);
If This.ivb_Modo_Teste Then Return True

Boolean lb_Sucesso

Choose Case This.Fabricante 
	Case "Bematech"
		lb_Sucesso = ivo_bematech.of_dados_impressora(Ref pl_sequencial,Ref pl_ecf)
		
	Case "Daruma"
		lb_Sucesso = ivo_Daruma.of_dados_impressora(Ref pl_sequencial,Ref pl_ecf)

	Case "NFCE"
		lb_Sucesso = ivo_NFCE.of_dados_nfce(This.cd_caixa, Ref pl_sequencial,Ref pl_ecf)		

	Case "SAT"
		lb_Sucesso = ivo_SAT.of_dados_sat(This.cd_caixa, Ref pl_sequencial,Ref pl_ecf)				
		
	Case "Epson"
		lb_Sucesso = ivo_epson.of_dados_impressora(Ref pl_sequencial,Ref pl_ecf)		
		
	Case Else	
		lb_Sucesso = ivo_sweda.of_dados_impressora(Ref pl_sequencial,Ref pl_ecf)
End Choose

If lb_Sucesso Then This.ECF = pl_ecf

Return lb_Sucesso

end function

public function boolean of_data_ultima_reducaoz (ref date pdh_data);Choose Case This.Fabricante 
	Case "Bematech"
		Return ivo_bematech.of_Data_Ultima_ReducaoZ(Ref pdh_data)
		
   Case "Daruma"
		Return ivo_daruma.of_Data_Ultima_ReducaoZ(Ref pdh_data)

   Case "Epson"
		Return ivo_epson.of_Data_Ultima_ReducaoZ(Ref pdh_data)		

	Case Else	
		Return ivo_sweda.of_DataFiscal(Ref pdh_data)
End Choose

end function

public function boolean of_desconto_cupom (string ps_texto, decimal pd_valor);If This.ivb_Modo_Teste Then Return True	

Choose Case This.Fabricante 
	Case "Bematech"
		Return ivo_bematech.of_desconto_cupom(ps_texto,pd_valor)
		
	Case "Daruma"
		Return ivo_Daruma.of_desconto_cupom(ps_texto,pd_valor)

	Case "NFCE", "SAT"
		Return True					

	Case "Epson"
		Return ivo_epson.of_desconto_cupom(ps_texto,pd_valor)

	Case Else	
		Return ivo_sweda.of_desconto_cupom(ps_texto,pd_valor)
End Choose

end function

public function boolean of_desconto_item (long pl_item, decimal pd_desconto, decimal pd_valor);If This.ivb_Modo_Teste Then Return True

If pd_valor = 000.00 Then Return True

Choose Case This.Fabricante 
	Case "Bematech"
		Return ivo_bematech.of_desconto_item(pl_item,pd_desconto,pd_valor)
		
	Case "Daruma"
		Return ivo_Daruma.of_desconto_item(pl_item,pd_desconto,pd_valor)

	Case "NFCE", "SAT"
		Return True

	Case "Epson"
		Return ivo_epson.of_desconto_item(pl_item,pd_desconto,pd_valor)
		
	Case Else	
		Return ivo_sweda.of_desconto_item(pl_item,pd_desconto,pd_valor)
End Choose

end function

public function string of_desencripta (string ps_texto);
String ls_Byte
String ls_Texto

Integer li_Ind

For li_Ind = 1 To LenA(ps_texto)
	
	Choose Case MidA(ps_texto,li_Ind,1)
		Case 'P'	
			ls_Byte = '0'
		Case 'E'	
			ls_Byte = '1'
		Case 'R'	
			ls_Byte = '2'
		Case 'N'	
			ls_Byte = '3'
		Case 'A'	
			ls_Byte = '4'
		Case 'M'	
			ls_Byte = '5'
		Case 'B'
			ls_Byte = '6'
		Case 'U'	
			ls_Byte = '7'
		Case 'C'	
			ls_Byte = '8'
		Case 'O'			
			ls_Byte = '9'
	End Choose
	
	ls_texto += ls_Byte
	
Next	

Return ls_Texto
end function

public function datetime of_dh_movimentacao ();DateTime ldh_movimentacao
DateTime ldh_nulo

SetNull(ldh_Nulo)

Select dh_movimentacao Into :ldh_movimentacao
From parametro 
Where id_parametro = '1'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		Return ldh_movimentacao		
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Data de movimenta$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o localizada nos par$$HEX1$$e200$$ENDHEX$$metros.", StopSign!)
		Return ldh_nulo
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o da data de movimenta$$HEX2$$e700e300$$ENDHEX$$o nos par$$HEX1$$e200$$ENDHEX$$metros." + SqlCa.SqlErrText, StopSign!)
		Return ldh_Nulo
End Choose
end function

public function boolean of_fecha_comprovante_tef ();If This.ivb_Modo_Teste Then Return True

Choose Case This.Fabricante 
	Case "Bematech"
		Return ivo_bematech.of_fecha_comprovante_tef()
		
	Case "Daruma"
		Return ivo_Daruma.of_fecha_comprovante_tef()

	Case "NFCE"
		Return ivo_NFCE.of_finaliza_impressao_texto()		
		
	Case "SAT"
		Return ivo_SAT.of_finaliza_impressao_texto()				
		
	Case "Epson"
		Return ivo_epson.of_fecha_comprovante_tef()		
		
	Case Else	
		Return ivo_sweda.of_fecha_comprovante_tef()
End Choose

end function

public function boolean of_grava_mapa_resumo (datetime pdt_data);Boolean lb_Sucesso

Choose Case This.Fabricante 
	Case "Bematech"
//		lb_Sucesso = ivo_bematech.of_grava_mapa_resumo(pdt_data)
		lb_Sucesso = ivo_bematech.of_Verifica_Ultimo_Mapa_Resumo()
	Case "Daruma"	
		lb_Sucesso = ivo_daruma.of_Verifica_Ultimo_Mapa_Resumo()		
	Case "Epson"
		lb_Sucesso = ivo_epson.of_Verifica_Ultimo_Mapa_Resumo()		
	Case Else
		lb_Sucesso = True
End Choose

Return lb_Sucesso
end function

public function boolean of_horario_verao ();Choose Case This.Fabricante 
	Case "Bematech"
		Return ivo_bematech.of_horario_verao()
		
	Case Else	
		Return ivo_sweda.of_horario_verao()
End Choose

end function

public function boolean of_horario_verao_ajuste (string ps_modo);Choose Case This.Fabricante 
	Case "Bematech"
		Return ivo_Bematech.of_horario_verao_ajuste(ps_modo)
		
	Case Else	
		Return ivo_sweda.of_horario_verao_ajuste(ps_modo)
End Choose

end function

public function boolean of_horario_verao_parametros (ref date adt_inicio, ref date adt_termino);Boolean lvb_Sucesso = False

uo_Parametro_Filial lvo_Parametro
lvo_Parametro = Create uo_Parametro_Filial

If lvo_Parametro.of_Localiza_Parametro("DT_INICIO_HORARIO_VERAO", ref adt_Inicio) Then
	If lvo_Parametro.of_Localiza_Parametro("DT_TERMINO_HORARIO_VERAO", ref adt_Termino) Then
		lvb_Sucesso = True
	End If
End If

Destroy(lvo_Parametro)

Return lvb_Sucesso
end function

public function string of_indicador_aliquota (decimal pd_aliquota, string ps_tributacao_icms);Choose Case This.Fabricante 
	Case "Bematech"
		Return ivo_bematech.of_indicador_aliquota(pd_aliquota,ps_tributacao_icms)

	Case Else	
		Return ivo_sweda.of_indicador_aliquota(pd_aliquota,ps_tributacao_icms)
End Choose

end function

public function boolean of_inicializa_comprovante_tef_nao_fiscal (string ps_tipo_recebimento, string ps_descricao, string ps_tipo_pagamento, decimal pdc_valor);If This.ivb_Modo_Teste Then Return True

Choose Case This.Fabricante 
	Case "Bematech"
		Return ivo_Bematech.of_inicializa_comprovante_tef_nao_fiscal(ps_tipo_pagamento,ps_descricao,ps_tipo_recebimento,pdc_valor)
		
	Case "Daruma"
		Return ivo_Daruma.of_inicializa_comprovante_tef_nao_fiscal(ps_tipo_pagamento,ps_descricao,ps_tipo_recebimento,pdc_valor)

	Case "NFCE", "SAT"
		Return True					

	Case "Epson"
		Return ivo_epson.of_inicializa_comprovante_tef_nao_fiscal(ps_tipo_pagamento,ps_descricao,ps_tipo_recebimento,pdc_valor)
		
	Case Else	
		Return ivo_sweda.of_inicializa_comprovante_tef_nao_fiscal(ps_tipo_recebimento,ps_descricao,ps_tipo_pagamento,pdc_valor)
End Choose

end function

public function boolean of_mapa_resumo (ref s_ge039_mapa_resumo ps_mapa_resumo);Choose Case This.Fabricante 
	Case "Bematech"
		Return ivo_bematech.of_mapa_resumo(Ref ps_mapa_resumo)
		
	Case "Daruma"
		Return ivo_Daruma.of_mapa_resumo(Ref ps_mapa_resumo)
		
	Case "Epson"
		Return ivo_epson.of_mapa_resumo(Ref ps_mapa_resumo)		
		
	Case Else	
		Return ivo_sweda.of_mapa_resumo(Ref ps_mapa_resumo)
End Choose

end function

public subroutine of_msg_cancelamento_invalido ();//
MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","                               CANCELAMENTO N$$HEX1$$c300$$ENDHEX$$O PERMITIDO~r~r" + &
							"Este cupom j$$HEX1$$e100$$ENDHEX$$ se encontra cadastrado no sistema. Utilize a tecla [F12] " + &
							"no sistema de caixa para efetuar o cancelamento deste cupom. ",Exclamation!)

end subroutine

public subroutine of_msg_cupom_aberto ();//
MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","                               CUPOM FISCAL N$$HEX1$$c300$$ENDHEX$$O ENCERRADO~r~r" + &
										"O $$HEX1$$da00$$ENDHEX$$ltimo cupom fiscal impresso n$$HEX1$$e300$$ENDHEX$$o foi finalizado corretamente. " + &
										"O Sistema ir$$HEX1$$e100$$ENDHEX$$ cancel$$HEX1$$e100$$ENDHEX$$-lo automaticamente na impressora fiscal.",Information!)
end subroutine

public function boolean of_path_log (string ps_path_log);
This.ivs_path_log = ps_path_log

Return True
end function

public function boolean of_pergunta_cancelacupom ();//
LONG  lvl_resp
//
lvl_resp = messagebox("Impressora Fiscal","Deseja cancelar cupom fiscal ?",Question!,YesNo!,2)
//										  
IF lvl_resp = 1 THEN
	RETURN TRUE
ELSE
	RETURN FALSE
END IF
//
end function

public function boolean of_pergunta_deseja_imprimir_cheque ();//
LONG  lvl_Resposta
//
lvl_Resposta = Messagebox("Impressora Fiscal","Deseja Imprimir Cheque ?",Question!,YesNo!)
//
IF lvl_Resposta = 1 THEN RETURN TRUE
//
RETURN FALSE
//
end function

public function boolean of_pergunta_falta_papel ();//
LONG  lvl_Resposta
//
lvl_Resposta = Messagebox("Impressora Fiscal","Falta de papel ou t$$HEX1$$e900$$ENDHEX$$rmino de bobina detectado. A troca j$$HEX1$$e100$$ENDHEX$$ foi efetuada ?",Question!,YesNo!,1)
//
IF lvl_Resposta = 1 THEN RETURN TRUE
//
RETURN FALSE
//
end function

public function boolean of_pergunta_folha_solta ();//
LONG  lvl_Resposta
//
lvl_Resposta = Messagebox("Impressora Fiscal","H$$HEX1$$e100$$ENDHEX$$ folha solta na Impressora Fiscal.Tentar novamente ?",Question!,YesNo!,1)
//
IF lvl_Resposta = 1 THEN RETURN TRUE
//
RETURN FALSE
//
end function

public function boolean of_pergunta_impressoraoffline ();//
LONG  lvl_resp
//
lvl_resp = Messagebox("Impressora Fiscal","Verifique se a impressora "+&
                      "fiscal est$$HEX1$$e100$$ENDHEX$$ ligada e se os cabos est$$HEX1$$e300$$ENDHEX$$o corretamente "+&
					  	    "conectados.Tentar novamente ?", Question!,YesNo!,1)
								
//
IF lvl_resp = 1 THEN
	RETURN TRUE
ELSE
	RETURN FALSE
END IF
//
end function

public function boolean of_pergunta_leiturax ();//
LONG  lvl_resp
//
lvl_resp = messagebox("Impressora Fiscal","$$HEX1$$c900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio fazer a Leitura X da Impressora Fiscal. Confirma Leitura X ?",Question!,YesNo!,1)
//
IF lvl_resp = 1 THEN
	RETURN TRUE
ELSE
	RETURN FALSE
END IF
//
end function

public function boolean of_pergunta_posiciona_cheque ();//
LONG  lvl_resp
//
lvl_resp = Messagebox("Impressora Fiscal","Insira o cheque para impress$$HEX1$$e300$$ENDHEX$$o e posicione-o corretamente. Tentar novamente ?",Question!,YesNo!,1)
//
IF lvl_resp = 1 THEN
	RETURN TRUE
ELSE
	RETURN FALSE
END IF
//
end function

public function boolean of_pergunta_reducaoz ();//
LONG  lvl_resp
//
lvl_resp = messagebox("Impressora Fiscal","$$HEX1$$c900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio fazer a Redu$$HEX2$$e700e300$$ENDHEX$$o Z da Impressora Fiscal. Confirma Redu$$HEX2$$e700e300$$ENDHEX$$o Z ?",Question!,YesNo!,1)
IF lvl_resp = 1 THEN
	RETURN TRUE
ELSE
	RETURN FALSE
END IF
//
end function

public function boolean of_permite_cancelamento_cupom ();Choose Case This.Fabricante 
	Case "Bematech"
		Return ivo_bematech.of_permite_cancelamento_cupom()
		
	Case "Daruma"
		Return ivo_Daruma.of_permite_cancelamento_cupom()
		
	Case "Epson"
		Return ivo_epson.of_permite_cancelamento_cupom()		
		
	Case Else	
		Return ivo_sweda.of_permite_cancelamento_cupom()
End Choose

end function

public function boolean of_porta_comunicacao ();
String lvs_INI,&
       lvs_Porta

lvs_INI  = gvo_Aplicacao.ivs_Arquivo_INI

// Verifica se o caminho dos arquivos de ajuda est$$HEX1$$e300$$ENDHEX$$o especificados no INI
lvs_Porta = ProfileString(lvs_INI, "ECF", "Porta","")

If Not IsNumber(lvs_Porta) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Arquivo de configura$$HEX2$$e700e300$$ENDHEX$$o : " + lvs_INI + '~n~nN$$HEX1$$e300$$ENDHEX$$o possui par$$HEX1$$e200$$ENDHEX$$metros~n~n[ECF]~nPorta=', StopSign! )
	Return False
End If

This.Porta = Long(lvs_Porta)

Return True
end function

public function boolean of_reducaoz ();Boolean lb_Sucesso

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Data atual do PDV $$HEX1$$e900$$ENDHEX$$ " + String(Today(), "dd/mm/yyyy hh:mm") + ". Caso n$$HEX1$$e300$$ENDHEX$$o esteja correto favor corrigir antes de executar a Redu$$HEX2$$e700e300$$ENDHEX$$o Z.~rDeseja continuar ?", Question!,YesNo!,2) = 2 Then Return False

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Deseja efetuar Redu$$HEX2$$e700e300$$ENDHEX$$o Z ?",Question!,YesNo!,2) = 2 Then Return False

Open(w_janela_aguarde)	
w_janela_aguarde.mle_1.text = "Imprimindo Redu$$HEX2$$e700e300$$ENDHEX$$o Z" 	

Choose Case This.Fabricante 
	Case "Bematech"
		lb_Sucesso = ivo_bematech.of_reducaoz()
		
	Case "Daruma"
		lb_Sucesso = ivo_Daruma.of_reducaoz()
		
	Case "Epson"
		lb_Sucesso = ivo_epson.of_reducaoz()	

	Case Else	
		lb_Sucesso = ivo_sweda.of_reducaoz()
End Choose

Close(w_janela_aguarde)

Return lb_Sucesso




end function

public function boolean of_registra_cancelamento (long pl_ecf, long pl_seq);Choose Case This.Fabricante 
	Case "Bematech"
		Return ivo_bematech.of_registra_cancelamento(pl_ecf,pl_seq)

	Case Else	
		Return ivo_sweda.of_registra_cancelamento(pl_ecf,pl_seq)
End Choose
end function

public function boolean of_registra_item_vendido (string ps_produto, long pd_qtd, decimal pd_precounitario, decimal pd_precototal, string ps_descricao, decimal pd_aliquota, string ps_complemento, string ps_tributacao_icms, string ps_un);If This.ivb_Modo_Teste Then Return True

Choose Case This.Fabricante 
	Case "Bematech"
		Return ivo_Bematech.of_registra_item_vendido(ps_produto,pd_qtd,pd_precounitario,pd_precototal,ps_descricao,pd_aliquota,ps_complemento,ps_tributacao_icms,ps_un)
		
	Case "Daruma"
		Return ivo_daruma.of_registra_item_vendido(ps_produto,pd_qtd,pd_precounitario,pd_precototal,ps_descricao,pd_aliquota,ps_complemento,ps_tributacao_icms)

	Case "NFCE", "SAT"
		Return True							
		
	Case "Epson"
		Return ivo_epson.of_registra_item_vendido(ps_produto,pd_qtd,pd_precounitario,pd_precototal,ps_descricao,pd_aliquota,ps_complemento,ps_tributacao_icms)		
		
	Case Else	
		Return ivo_sweda.of_registra_item_vendido(ps_produto,pd_qtd,pd_precounitario,pd_precototal,ps_descricao,pd_aliquota,ps_complemento,ps_tributacao_icms,ps_un)
End Choose

end function

public subroutine of_sleep (long pl_segundos);//
TIME  lvt_inicio
//
lvt_inicio = Now()
//
DO WHILE TRUE
	IF SecondsAfter(lvt_inicio , Now()) >= pl_segundos THEN		 
		EXIT
	END IF
LOOP
//
end subroutine

public function integer of_statusok ();Choose Case This.Fabricante 
	Case "Bematech"
		Return ivo_Bematech.of_statusok()

	Case Else	
		Return ivo_sweda.of_statusok()
End Choose

end function

public function boolean of_texto_nao_fiscal_tef (string ps_texto);Choose Case This.Fabricante 
	Case "Bematech"
		Return ivo_bematech.of_texto_nao_fiscal_tef(ps_texto)
		
	Case "Daruma"
		Return ivo_Daruma.of_texto_nao_fiscal_tef(ps_texto)

	Case "NFCE"		
		Return ivo_NFCE.of_imprime_texto(ps_texto)			
		
	Case "SAT"		
		Return ivo_SAT.of_imprime_texto(ps_texto)	
		
	Case "Epson"
		Return ivo_epson.of_texto_nao_fiscal_tef(ps_texto)
		
	Case Else	
		Return ivo_sweda.of_texto_nao_fiscal_tef(ps_texto)
End Choose

end function

public function boolean of_timeout_ecf ();String lvs_INI,&
	   lvs_Timeout

lvs_INI = gvo_Aplicacao.ivs_Arquivo_INI

lvs_Timeout = ProfileString(lvs_INI, "ECF" , "Timeout" , "")

If IsNumber(lvs_Timeout) Then
	This.Timeout = Long(lvs_Timeout)
Else
	This.Timeout = 10
End If

Return True
end function

public function boolean of_totaliza_cupom (string ps_tipo[], decimal pd_valor[]);If This.ivb_Modo_Teste Then Return True

Choose Case This.Fabricante 
	Case "Bematech"
		Return ivo_bematech.of_totaliza_cupom(ps_tipo[],pd_valor[])
		
	Case "Daruma"
		Return ivo_Daruma.of_totaliza_cupom(ps_tipo[],pd_valor[])

	Case "NFCE", "SAT"
		Return True
		
	Case "Epson"
		Return ivo_epson.of_totaliza_cupom(ps_tipo[],pd_valor[])		
		
	Case Else	
		Return ivo_sweda.of_totaliza_cupom(ps_tipo[],pd_valor[])
End Choose

end function

public function boolean of_verifica_cupons_pendentes ();Choose Case This.Fabricante 
	Case "Bematech"
		Return ivo_bematech.of_verifica_cupons_pendentes()
		
	Case "Daruma"
		Return ivo_Daruma.of_verifica_cupons_pendentes()
		
	Case "NFCE", "SAT"
		Return True
		
	Case "Epson"
		Return ivo_epson.of_verifica_cupons_pendentes()		
		
	Case Else	
		Return ivo_sweda.of_verifica_cupons_pendentes()
End Choose

end function

public subroutine of_fechaporta ();
If This.ivb_Modo_Teste Then Return

Choose Case This.Fabricante 
	Case "Bematech"
		ivo_bematech.of_fechaporta()
		
	Case "Daruma"
		Return

	Case "NFCE", "SAT"
		Return
		
	Case "Epson"
		Return
	
	Case Else	
		ivo_sweda.of_fechaporta()
End Choose

end subroutine

public function boolean of_datafiscal (ref date pd_datafiscal);Choose Case This.Fabricante 
	Case "Bematech"
		Return ivo_bematech.of_datafiscal(Ref pd_datafiscal)
		
	Case "Daruma"
		Return ivo_Daruma.of_datafiscal(Ref pd_datafiscal)

	Case "NFCE", "SAT"
		pd_datafiscal = Date(Today())
		Return True							

	Case "Epson"
		Return ivo_epson.of_datafiscal(Ref pd_datafiscal)
		
	Case Else	
		Return ivo_sweda.of_datafiscal(Ref pd_datafiscal)
End Choose

end function

public function boolean of_horaecf (ref string ps_hora);Choose Case This.Fabricante 
	Case "Bematech"
		Return ivo_bematech.of_horaecf(Ref ps_hora)
		
	Case "Daruma"
		Return ivo_Daruma.of_horaecf(Ref ps_hora)

	Case "NFCE", "SAT"
		Return True							

	Case "Epson"
		Return ivo_epson.of_horaecf(Ref ps_hora)

	Case Else	
		Return ivo_sweda.of_horaecf(Ref ps_hora)
End Choose

end function

public function boolean of_dataecf (ref date pd_dataecf);Choose Case This.Fabricante 
	Case "Bematech"
		Return ivo_bematech.of_dataecf(Ref pd_dataecf)
		
	Case "Daruma"
		Return ivo_Daruma.of_dataecf(Ref pd_dataecf)

	Case "NFCE", "SAT"
		pd_dataecf = Date(Today())		
		Return True					
		
	Case "Epson"
		Return ivo_epson.of_dataecf(Ref pd_dataecf)		
		
	Case Else	
		Return ivo_sweda.of_dataecf(Ref pd_dataecf)
End Choose

end function

public function boolean of_atualiza_data_fiscal ();If This.ivb_Modo_Teste Then Return True

Choose Case This.Fabricante 
	Case "Bematech"
		Return ivo_bematech.of_atualiza_data_fiscal()
		
	Case "Daruma"
		Return ivo_Daruma.of_atualiza_data_fiscal()
		
	Case "NFCE", "SAT"
		Return True	
		
	Case Else	
		Return ivo_sweda.of_atualiza_data_fiscal()
End Choose

end function

public function boolean of_verifica_data_movimentacao ();If This.ivb_Modo_Teste Then Return True

Choose Case This.Fabricante 
	Case "Bematech"
		Return ivo_bematech.of_Verifica_Data_Movimentacao()
		
	Case "Daruma"
		Return ivo_Daruma.of_Verifica_Data_Movimentacao()
		
	Case "NFCE", "SAT"
		Return True

	Case "Epson"
		Return ivo_epson.of_Verifica_Data_Movimentacao()		
		
	Case Else	
		Return ivo_sweda.of_Verifica_Data_Movimentacao()
End Choose

end function

public function boolean of_cancela_cupom (long pl_ecf, long pl_seq);If This.ivb_Modo_Teste Then Return True

Choose Case This.Fabricante 
	Case "Bematech"
		Return ivo_bematech.of_cancela_cupom(pl_ecf,pl_seq)
		
	Case "Daruma"
		Return ivo_Daruma.of_cancela_cupom()

	Case "NFCE", "SAT"
		Return True						
		
	Case "Epson"
		Return ivo_epson.of_cancela_cupom()		
		
	Case Else	
		Return ivo_sweda.of_cancela_cupom(pl_ecf,pl_seq)
End Choose

end function

public function boolean of_fecha_cupom_nao_fiscal (string ps_vinculado);
If This.ivb_Modo_Teste Then Return True

Choose Case This.Fabricante 
	Case "Bematech"
		Return ivo_Bematech.of_fecha_cupom_nao_fiscal(ps_vinculado)
		
	Case "Daruma"
		Return ivo_Daruma.of_fecha_cupom_nao_fiscal()
		
	Case "Epson"
		Return ivo_epson.of_fecha_cupom_nao_fiscal()		
		
	Case Else	
		Return ivo_sweda.of_fecha_cupom_nao_fiscal(ps_vinculado)
End Choose

end function

public function boolean of_fecha_cupom_nao_fiscal ();Choose Case This.Fabricante 
	Case "Bematech"
		Return ivo_Bematech.of_fecha_cupom_nao_fiscal()

	Case "Daruma"
		ivo_Daruma.of_fecha_cupom_nao_fiscal()
		
	Case "Epson"
		ivo_epson.of_fecha_cupom_nao_fiscal()		
		
	Case Else	
		Return ivo_sweda.of_fecha_cupom_nao_fiscal()
End Choose

end function

public function boolean of_numero_ecf (ref long pl_ecf);
If This.ivb_Modo_Teste Then Return True

Boolean lb_Sucesso

Long ll_Sequencial

Choose Case This.Fabricante 
	Case "Bematech"
		lb_Sucesso = ivo_bematech.of_dados_impressora(Ref ll_Sequencial,Ref pl_ecf)

	Case Else	
		lb_Sucesso = ivo_sweda.of_dados_impressora(Ref ll_Sequencial, Ref pl_ecf)
End Choose

If lb_Sucesso Then This.ECF = pl_ecf

Return lb_Sucesso

end function

public function boolean of_verifica_problemas_impressora ();If This.ivb_Modo_Teste Then Return True

Choose Case This.Fabricante 
	Case "Bematech"
		Return ivo_bematech.of_verifica_problemas_impressora()
		
	Case "Daruma"
		Return ivo_Daruma.of_verifica_problemas_impressora()

	Case "NFCE", "SAT"
		Return True
		
	Case "Epson"
		Return ivo_epson.of_verifica_problemas_impressora()		
		
	Case Else	
		Return ivo_sweda.of_verifica_problemas_impressora()
End Choose

end function

public function boolean of_nr_ecf (ref long pl_ecf);Choose Case This.Fabricante 
	Case "Bematech"
		Return ivo_bematech.of_nr_ecf(Ref pl_ecf)
		
	Case "Daruma"
		Return ivo_Daruma.of_nr_ecf(Ref pl_ecf)		

	Case "NFCE", "SAT"
		pl_ecf = 0		
		Return True		
		
	Case "Epson"
		Return ivo_epson.of_nr_ecf(Ref pl_ecf)				
		
	Case Else	
		Return ivo_sweda.of_nr_ecf(Ref pl_ecf)
End Choose

end function

public function boolean of_dh_emissao (ref datetime pdh_datahora);String	ls_Hora

If This.ivb_Modo_Teste Then 
	pdh_datahora = gf_getserverdate()			
	Return True	
End If

Choose Case This.Fabricante 
	Case "Bematech"
		If Not ivo_bematech.of_data_ultimo_documento_fiscal(Ref pdh_datahora) Then Return False

	Case "Daruma"
		If Not ivo_Daruma.of_Data_Ultimo_Documento(Ref pdh_datahora) Then Return False

	Case "NFCE", "SAT"
		pdh_datahora = gf_getserverdate()		
		Return True
		
	Case "Epson"
		//If Not ivo_epson.of_Data_Ultimo_Documento(Ref pdh_datahora) Then Return False	  // Aterado porque o comando da epson retorna da da do ultimo documento finalizado e n$$HEX1$$e300$$ENDHEX$$o do aberto
		If Not ivo_epson.of_data_hora_ecf(Ref pdh_datahora) Then Return False
		
	Case Else	
		If Not ivo_Sweda.of_data_hora_ecf(Ref pdh_datahora) Then Return False
End Choose

Return True
end function

public function boolean of_inicializa_comprovante_tef (string ps_tipo_recebimento, string ps_descricao, string ps_tipo_pagamento, decimal pdc_valor, long pl_parcelas, string ps_cupom);If This.ivb_Modo_Teste Then Return True

This.ivb_Iniciou_Erro = False

Choose Case This.Fabricante 
	Case "Bematech"
		Return ivo_Bematech.of_inicializa_comprovante_tef(ps_tipo_pagamento,ps_descricao,ps_tipo_recebimento,pdc_valor, ps_cupom)

	Case "Daruma"
		Return ivo_Daruma.of_inicializa_comprovante_tef(ps_tipo_pagamento,ps_descricao,ps_tipo_recebimento,pdc_valor, ps_cupom)

	Case "NFCE"				
		Return ivo_NFCE.of_inicializa_comprovante('CARTAO',ps_tipo_pagamento,ps_descricao,ps_tipo_recebimento,pdc_valor, pl_parcelas, ps_cupom)			

	Case "SAT"				
		Return ivo_SAT.of_inicializa_comprovante('CARTAO',ps_tipo_pagamento,ps_descricao,ps_tipo_recebimento,pdc_valor, pl_parcelas, ps_cupom)
		
	Case "Epson"
		Return ivo_epson.of_inicializa_comprovante_tef(ps_tipo_pagamento,ps_descricao,ps_tipo_recebimento,pdc_valor, ps_cupom)	
		
	Case Else	
		Return ivo_sweda.of_inicializa_comprovante_tef(ps_tipo_recebimento,ps_descricao,ps_tipo_pagamento,pdc_valor,ps_cupom)
End Choose

end function

public function boolean of_verifica_drivers ();Choose Case This.Fabricante 
	Case "Bematech"
		Return ivo_bematech.of_verifica_drivers()
		
	Case "Daruma"
		Return ivo_Daruma.of_verifica_drivers()

	Case "Epson"
		Return ivo_epson.of_verifica_drivers()
		
	Case Else	
		Return ivo_sweda.of_verifica_drivers()
End Choose

end function

public function boolean of_verifica_drivers_pafecf ();
Boolean	lb_Sucesso 		= True
Boolean	lb_Existe 		= False

String   ls_Path_System
String   ls_Path
String   ls_Path_Bematech = 'C:\sistemas\dll\bematech'
String   ls_Error

String ls_Versao
String	ls_Valor

Long 		ll_File

If gvo_Aplicacao.of_is64bits() Then
	ls_Path_System = 'C:\Windows\SysWOW64'
Else
	ls_Path_System = gvo_Aplicacao.of_Get_System_Directory()
End If	

If FileExists(ls_Path_Bematech + '\AX6R32.DLL') Then
	If FileExists(ls_Path_Bematech + '\BemaFI32.DLL') Then
		If FileExists(ls_Path_Bematech + '\BemaFI32.lib') Then
			If FileExists(ls_Path_Bematech + '\BemaMFD2.DLL') Then
				If FileExists(ls_Path_Bematech + '\BemaMFD.DLL') Then
					If FileExists(ls_Path_Bematech + '\DAO350.DLL') Then
						If FileExists(ls_Path_Bematech + '\DAO2535.TLB') Then
							If FileExists(ls_Path_System + '\libeay32.DLL') Then
								If FileExists(ls_Path_Bematech + '\MSJET35.DLL') Then
//									If FileExists(ls_Path_Bematech + '\registra.bat') Then
										If FileExists(ls_Path_Bematech + '\sign_bema.DLL') Then
											lb_Existe = True
										End If
//									End If
								End If
							End If
						End If	
					End If	
				End If	
			End If
		End If
	End If	
End If

If lb_Existe Then
	Return True
End If

Select vl_parametro
Into :ls_Valor
from parametro_loja
Where cd_parametro = 'DE_SERVIDOR_DOWNLOAD_VERSAO_MATRIZ'
Using SqlCa;

Choose Case SqlCa.SqlCode
Case -1
	SqlCa.of_LogDbError(gvo_Aplicacao.ivi_Log)
	lb_Sucesso = False
	
Case 100
	gvo_Aplicacao.of_Grava_Log("N$$HEX1$$e300$$ENDHEX$$o foi encontrado o par$$HEX1$$e200$$ENDHEX$$metro 'DE_SERVIDOR_DOWNLOAD_VERSAO_MATRIZ' na tabela par$$HEX1$$e200$$ENDHEX$$metro_loja")
	lb_Sucesso = False
	
Case 0
	lb_Sucesso = True
End Choose	

If lb_Sucesso Then
	Open(w_Aguarde_1)
	
	dc_uo_ftp lo_Ftp
	lo_Ftp = Create dc_uo_ftp
										
	dc_uo_zip lo_Zip
	lo_Zip = Create dc_uo_zip
	
	If lb_Sucesso Then
		
		w_Aguarde_1.Title = "Atualizando drivers ... "

		If lo_Ftp.of_Conecta_Ftp("Verifica Versao", ls_Valor, "pdv2", "pdv2") Then
			
			lo_Ftp.of_Ftp_Set_Dir('dll_bematech')
			
			If Not lo_Ftp.of_Ftp_GetFile("bematech.zip", ls_Path_System + "\bematech.zip") Then
				
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao atualizar drivers Bematech")
				
				lb_Sucesso = False
				
			Else
				
				FileDelete(ls_Path_System + '\AX6R32.DLL')
				FileDelete(ls_Path_System + '\BemaFI32.dll')
				FileDelete(ls_Path_System + '\BemaFI32.lib')
				FileDelete(ls_Path_System + '\BemaMFD2.dll')
				FileDelete(ls_Path_System + '\BemaMFD.dll')
				FileDelete(ls_Path_System + '\DAO350.DLL') 
				FileDelete(ls_Path_System + '\DAO2535.TLB')
				FileDelete(ls_Path_System + '\libeay32.dll')
				FileDelete(ls_Path_System + '\MSJET35.dll')
				FileDelete(ls_Path_System + '\registra.bat')
				FileDelete(ls_Path_System + '\sign_bema.dll')
				
				
				w_Aguarde_1.Title = "Descompactando arquivos ... "
				w_Aguarde_1.Show()
				
				lo_Zip.of_UnZip_Origem(ls_Path_System + '\bematech.zip')
				lo_Zip.of_UnZip_Destino(ls_Path_System + '\')
				
				ls_Error = lo_Zip.of_UnZip(True)
				
				If ls_Error <> "" Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Error, StopSign!)
				Else
					lb_Sucesso = True
					Run("regsvr32 /s DAO350.DLL")
					Run("regsvr32 /s MSJET35.DLL")
				End If

			End If
			
		End If
		
	End If
	
	If IsValid(lo_Zip) Then Destroy(lo_Zip)
	
	If IsValid(lo_Ftp) Then Destroy lo_Ftp
	
	If IsValid(w_Aguarde_1) Then Close(w_Aguarde_1)
End If

Return lb_Sucesso
end function

public function boolean of_assinatura_digital (string ps_file);If This.ivb_Modo_Teste Then Return True

Long 	  ll_Retorno

String ls_Registro 

String ls_ChavePublica
String ls_ChavePrivada
String ls_ead

If Not of_verifica_drivers_pafecf() Then
	Return True
End If 

Run("regsvr32 /s DAO350.DLL")
Run("regsvr32 /s MSJET35.DLL")

ls_ChavePublica = "9716BE0910DB085542B39EE19383F3EB45A32D8962D57FFC6DAF0F04B872F52EF36F144131F6923B1A9EA73F13527A9CFD5A26F688505FC63ED9F95D240BF9D3A9655E26AE6AB706A1633693FCB3048A750E4B15EAE98F64EF6E941A78422E7ECB1D126C268DF5FA8E228A2CDD5206CE50B4D15D14B99906604C73E6DF807939"
ls_ChavePrivada = "C59A1793009F74E975542E2841C840B34D8C45143D5B761DE1FADFE447289D4308452A882AED183FB5781A1C23AED97726023C3710161C68ABA7275AE9826119C3BD9FC24E4C6DE977B674EDA0CE56F4E1F3884F51230A10CAF8362FE4C758A1DD0F9F50F0810F8507E8419884BAA981771B5EACE835E94EB62CDE4DAFE73D21"

ls_ead = Space(256)

ll_Retorno = generateEAD(ps_File, ls_ChavePublica ,ls_ChavePrivada , Ref ls_ead , 1 )

If ll_Retorno = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao assinar digitalmente o arquivo " + ps_File, StopSign!)
	Return False
Else
	Return True
End If


//Choose Case This.Fabricante 
//	Case "Bematech"
//		Return ivo_Bematech.of_assinatura_digital(ps_File)
//		
//	Case "Daruma"
//		Return ivo_Daruma.of_assinatura_digital(ps_File)
//		
//	Case Else	
//		Return True //ivo_sweda.of_assinatura_digital()
//End Choose
//
end function

public function boolean of_numero_serie ();Boolean lvb_Sucesso = True
If This.ivb_Modo_Teste Then Return True

Choose Case This.Fabricante 
	Case "Bematech"
		lvb_Sucesso = ivo_bematech.of_numero_serie()
		If lvb_Sucesso Then This.nr_Serie = ivo_bematech.Nr_serie		
		
	Case "Daruma"		
		lvb_Sucesso = ivo_Daruma.of_numero_serie()
		If lvb_Sucesso Then This.nr_Serie = ivo_Daruma.Nr_serie_MFD
		
	Case "NFCE", "SAT"
		Return True							

	Case "Epson"		
		lvb_Sucesso = ivo_epson.of_numero_serie()
		If lvb_Sucesso Then This.nr_Serie = ivo_epson.Nr_serie
		
	Case Else
		lvb_Sucesso = ivo_sweda.of_numero_serie()
		If lvb_Sucesso Then This.nr_Serie = ivo_sweda.Nr_serie
End Choose

Return lvb_Sucesso
end function

public function boolean of_leiturax (boolean pb_arquivo);Choose Case This.Fabricante 	
	Case "Bematech"
		Return ivo_bematech.of_leiturax(pb_arquivo)
		
	Case "Daruma"
		Return ivo_Daruma.of_leiturax(pb_arquivo)

	Case "NFCE"
		ivo_NFCE.of_teste()
		Return True							
		
	Case "SAT"
		ivo_SAT.of_teste()
		Return True	
		
	Case "Epson"		
		Return ivo_epson.of_leiturax()		
		
	Case Else	
		Return ivo_sweda.of_leiturax(pb_arquivo)//'N')
End Choose

end function

public function boolean of_leitura_memoria_fiscal (string ps_data_de, string ps_data_ate, boolean pb_arquivo, string id_tipo);Choose Case This.Fabricante 
	Case "Bematech"
		Return ivo_Bematech.of_leitura_memoria_fiscal(ps_data_de,ps_data_ate,pb_arquivo, id_tipo)
	Case "Daruma"
		Return ivo_Daruma.of_leitura_memoria_fiscal(ps_data_de,ps_data_ate,pb_arquivo, id_tipo, True)
	Case "Epson"
		Return ivo_Epson.of_leitura_memoria_fiscal(ps_data_de,ps_data_ate,pb_arquivo, id_tipo)		
	Case Else	
		Return ivo_sweda.of_leitura_memoria_fiscal(ps_data_de,ps_data_ate, pb_arquivo, id_tipo)
End Choose

end function

public function boolean of_leitura_memoria_fiscal_reducao (long pl_reducao_inicial, long pl_reducao_final, boolean pb_arquivo, string ps_tipo);Choose Case This.Fabricante 
	Case "Bematech"
		Return ivo_bematech.of_leitura_memoria_fiscal_reducao(pl_reducao_inicial,pl_reducao_final,pb_arquivo,ps_tipo)
	Case "Daruma"
		Return ivo_Daruma.of_leitura_memoria_fiscal_reducao(pl_reducao_inicial,pl_reducao_final,pb_arquivo,ps_tipo)
	Case "Epson"
		Return ivo_Epson.of_leitura_memoria_fiscal(String(pl_reducao_inicial),String(pl_reducao_final),pb_arquivo, ps_tipo)				
	Case Else
		Return ivo_Sweda.of_leitura_memoria_fiscal_reducao(pl_reducao_inicial,pl_reducao_final, pb_Arquivo,ps_tipo)		
End Choose

end function

public function boolean of_leitura_totais (integer pi_tipo);Choose Case This.Fabricante 
	Case "Bematech"
		Return ivo_bematech.of_leitura_totais(pi_tipo)
	Case Else	
		Return ivo_sweda.of_leitura_totais(pi_tipo)
End Choose

end function

public function boolean of_leitura_memoria_fita_detalhe (string ps_tipo, string ps_inicio, string ps_final);Choose Case This.Fabricante 
	Case "Bematech"
		Return ivo_Bematech.of_leitura_memoria_fita_detalhe(ps_tipo,ps_inicio,ps_final)
	Case "Daruma"
		Return ivo_Daruma.of_leitura_memoria_fita_detalhe(ps_tipo,ps_inicio,ps_final)
	Case "Epson"
		Return ivo_Epson.of_leitura_memoria_fita_detalhe(ps_tipo,ps_inicio,ps_final)		
	Case Else	
		Return ivo_Sweda.of_leitura_memoria_fita_detalhe(ps_tipo,ps_inicio,ps_final)
End Choose

end function

public function boolean of_inicializa_relatorio_gerencial (string ps_titulo, decimal pdc_valor);If This.ivb_Modo_Teste Then Return True

Choose Case This.Fabricante 
	Case "Bematech"
		Return ivo_Bematech.of_inicializa_relatorio_gerencial(ps_titulo,pdc_valor)
	Case "Daruma"	
		Return ivo_Daruma.of_inicializa_relatorio_gerencial(ps_titulo, pdc_valor)				
	Case "NFCE"
		Return ivo_NFCE.of_inicializa_comprovante(ps_titulo,'','','',pdc_valor, 0,'')				
	Case "SAT"
		Return ivo_SAT.of_inicializa_comprovante(ps_titulo,'','','',pdc_valor, 0,'')
	Case "Epson"
		Return ivo_epson.of_inicializa_relatorio_gerencial(ps_titulo, pdc_valor)						
	Case Else	
		Return ivo_sweda.of_inicializa_relatorio_gerencial(ps_titulo, pdc_valor)
End Choose
end function

public function boolean of_gera_arquivo_cotepe1704 (string ps_tipo, string ps_inicio, string ps_final, string ps_razao_social, string ps_endereco);Choose Case This.Fabricante 
	Case "Bematech"
		Return ivo_Bematech.of_gera_arquivo_cotepe1704(ps_tipo,ps_inicio,ps_final,ps_razao_social,ps_endereco)
	Case "Daruma"
		//Return ivo_Daruma.of_gera_arquivo_cotepe1704(ps_tipo, ps_inicio, ps_final)
		Return False

	Case Else	
		Return ivo_Sweda.of_gera_arquivo_cotepe1704(ps_tipo, ps_inicio, ps_final)
End Choose

end function

public function boolean of_leitura_memoria_fiscal_ac1704 (string ps_data_de, string ps_data_ate);Choose Case This.Fabricante 
	Case "Bematech"
		Return ivo_Bematech.of_leitura_memoria_fiscal_ac1704(ps_data_de,ps_data_ate)

	Case "Daruma"
		Return ivo_Daruma.of_leitura_memoria_fiscal_ac1704(ps_data_de,ps_data_ate)
	Case Else	
		Return ivo_Sweda.of_leitura_memoria_fiscal_ac1704(ps_data_de,ps_data_ate)
End Choose
end function

public function string of_encripta (string ps_texto);
String ls_Byte
String ls_Valor

Integer li_Ind

For li_Ind = 1 To LenA(ps_texto)
	
	Choose Case MidA(ps_texto,li_Ind,1)
		Case '0'	
			ls_Byte = 'P'
		Case '1'	
			ls_Byte = 'E'
		Case '2'	
			ls_Byte = 'R'
		Case '3'	
			ls_Byte = 'N'
		Case '4'	
			ls_Byte = 'A'
		Case '5'	
			ls_Byte = 'M'
		Case '6'
			ls_Byte = 'B'
		Case '7'	
			ls_Byte = 'U'
		Case '8'	
			ls_Byte = 'C'
		Case '9'			
			ls_Byte = 'O'
		Case Else
			ls_Byte = ''
	End Choose
	
	ls_Valor += ls_Byte
	
Next	

Return ls_Valor
end function

public function boolean of_contador_cupom_fiscal (ref long ll_ccf);If This.ivb_Modo_Teste Then Return True

Choose Case This.Fabricante 
	Case "Bematech"
		Return ivo_bematech.of_contador_cupom_fiscal(Ref ll_ccf)
		

		Return True		
		
	Case "Daruma"
		Return True
		
	Case "NFCE", "SAT"
		Return True					
		
	Case Else	
		Return True
End Choose

end function

public function boolean of_cancela_ultimo_cupom (boolean pb_confirmar);If This.ivb_Modo_Teste Then Return True

String ls_Responsavel

SetNull(ls_Responsavel)

Choose Case This.Fabricante 
	Case "NFCE","SAT"
		Return True									
		
	Case Else	
		Return This.of_Cancela_Ultimo_Cupom( pb_confirmar, ls_Responsavel )
End Choose
end function

public function boolean of_cancela_ultimo_cupom (boolean pb_confirmar, string ps_responsavel);If This.ivb_Modo_Teste Then Return True

Long   lvl_Seq ,&
		 lvl_Retorno, &
		 lvl_Nota

DateTime lvdh_Data_Movimento

String   lvs_Transacao, &
		  lvs_tipo_cupom = 'COO'

This.of_Nr_Ecf(ref This.ECF)

If of_permite_cancelamento_cupom() Then
	
	If Not of_Dados_Impressora(Ref lvl_seq,Ref This.ECF) Then Return False
	
	If This.Fabricante = "Daruma" Then
		If Not ivo_Daruma.of_Sequencial_Cancelamento(ref lvl_seq) Then Return False
	End If
	
	If Trim(UPPER(This.Fabricante)) = "BEMATECH" and Pos(UPPER(This.modelo),'4200') > 0 Then
		If Not ivo_bematech.of_contador_cupom_fiscal(ref lvl_seq) Then Return False
		lvs_tipo_cupom = 'CCF'
	End If	
	
	//Verifica se pode cancelar venda produto exame COVID.
	If Not This.of_verifica_venda_exame( 'CF', lvs_tipo_cupom, this.ECF, lvl_seq, '', '') Then Return False	
	
	If pb_confirmar Then
		If Not of_pergunta_cancelacupom() Then Return False
	End If

	lvl_Retorno = of_Verifica_Cancelamento_Cupom( lvl_seq,This.ECF,lvs_tipo_cupom )
	
	Choose Case lvl_Retorno
		Case -1  //Erro ao verificar cupom
			Return False
			
		Case 1  //Cupom encontrado
		
			ivb_showerror = False
			
			If of_cancela_cupom(This.ECF,lvl_Seq) Then
				
				lvdh_Data_Movimento = This.of_dh_movimentacao()
				
				If lvs_tipo_cupom = 'COO' Then
					Update nf_venda
						Set id_cancelamento_impressora = 'S',
							 nr_matricula_cancelamento  = :ps_Responsavel
					 Where nr_ecf                     = :This.ECF
						and nr_operacao_ecf            = :lvl_seq
						and dh_movimentacao_caixa      = :lvdh_Data_Movimento					
					Using Sqlca;
				Else
					Update nf_venda
						Set id_cancelamento_impressora = 'S',
							 nr_matricula_cancelamento  = :ps_Responsavel
					 Where nr_ecf                     = :This.ECF
						and nr_ccf            = :lvl_seq
						and dh_movimentacao_caixa      = :lvdh_Data_Movimento					
					Using Sqlca;	
				End If
				
				If Sqlca.Sqlcode = -1 Then
					SQLCA.of_MsgDBError('Cancelamento do Cupom Fiscal')
					MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o','O cupom fiscal foi cancelado somente na impressora, verIfique a situa$$HEX2$$e700e300$$ENDHEX$$o do cupom no sistema.',Information!)
					Return False
				End If
				
				If SQLCA.Of_Commit() = -1 Then
					SQLCA.Of_RollBack()
					SQLCA.Of_MsgDbError('Erro no commit')
					MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o','O cupom fiscal foi cancelado somente na impressora, verIfique a situa$$HEX2$$e700e300$$ENDHEX$$o do cupom no sistema.',Information!)
					Return False
				ELSE
					//Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","V E N D A   C A N C E L A D A.~r~rECF: "+String(This.ECF,'000')+" SEQ: "+String(lvl_Seq,'0000000'), Exclamation!)					
				End If				
				
				Return True
			End If
			
			Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel cancelar $$HEX1$$fa00$$ENDHEX$$ltimo cupom fiscal.", Exclamation!)
		
		Case 100							//Cupom n$$HEX1$$e300$$ENDHEX$$o foi encontrado
		
			If pb_confirmar Then
				If Not of_pergunta_cancelacupom() Then Return False
			End If
			
			If of_cancela_cupom(This.ECF ,lvl_Seq) Then
				SqlCa.of_End_Transaction( )
				//Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","V E N D A   C A N C E L A D A.", Exclamation!)
				Return True
			End If
			
			Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel cancelar $$HEX1$$fa00$$ENDHEX$$ltimo cupom fiscal.", Exclamation!)
			
	End Choose
	
Else
	
	Return of_fecha_cupom_nao_fiscal()
	
End If

Return False

end function

public function boolean of_capturar_md5 (string ps_arquivo, ref string ps_md5);If This.ivb_Modo_Teste Then Return True

Long ll_Retorno
	
String ls_MD5
	
If Not of_verifica_drivers_pafecf() Then
	Return True
End If 

Run("regsvr32 /s DAO350.DLL")
Run("regsvr32 /s MSJET35.DLL")
	
ls_MD5 = Space(33)
	
ll_Retorno = md5FromFile(ps_Arquivo,Ref ls_MD5)
	
If ll_Retorno = 1 Then
	ps_MD5 = Upper(ls_MD5)
	Return True
End IF

Return False

end function

public function boolean of_verifica_venda_bruta_diaria ();If This.ivb_Modo_Teste Then Return True

Choose Case This.Fabricante 
	Case "Bematech"
		Return ivo_bematech.of_verifica_venda_bruta_diaria()	
		Return True		
		
	Case "Daruma"
		Return ivo_Daruma.of_verifica_venda_bruta_diaria()
		
	Case "NFCE", "SAT"
		Return True
		
	Case "Epson"
		Return ivo_epson.of_verifica_venda_bruta_diaria()		
		
	Case Else	
		Return ivo_sweda.of_verifica_venda_bruta_diaria()
End Choose

end function

public function boolean of_registra_documento_ecf (string ps_documento, string ps_totalizador, decimal pdc_valor);If This.ivb_Modo_Teste Then Return True

Choose Case This.Fabricante 
	Case "Bematech"
		Return ivo_bematech.of_registra_documento_ecf(ps_documento, ps_totalizador, pdc_valor)
		Return True		
		
	Case "Daruma"
		Return ivo_Daruma.of_registra_documento_ecf(ps_documento, ps_totalizador, pdc_valor)
		
	Case "Epson"
		Return ivo_epson.of_registra_documento_ecf(ps_documento, ps_totalizador, pdc_valor)		
		
	Case Else	
		//Return ivo_sweda.of_registra_documento_ecf(ps_documento, ps_totalizador, pdc_valor)
		Return True
End Choose

end function

public function boolean of_emite_comprovante (string ps_titulo, string ps_texto[]);If This.ivb_Modo_Teste Then Return True

Boolean lvb_Sucesso = False

Decimal{2} lvd_Valor 

lvd_Valor = 0.00

If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = "RL" Then
	This.ivb_Aviso_cupom_aberto = True
End If

Choose Case This.Fabricante 
	Case "Bematech"
		If ivo_Bematech.of_emite_comprovante(ps_titulo,ps_texto[], lvd_Valor) Then
			lvb_Sucesso = True
		End If		
		
	Case "Daruma"
		If ivo_Daruma.of_emite_comprovante(ps_titulo,ps_texto[], lvd_Valor) Then
			lvb_Sucesso = True
		End If		

	Case "NFCE"
		If ivo_NFCE.of_emite_comprovante(ps_titulo,ps_texto[], lvd_valor) Then
			lvb_Sucesso = True
		End If						
		
	Case "SAT"
		If ivo_SAT.of_emite_comprovante(ps_titulo,ps_texto[], lvd_valor) Then
			lvb_Sucesso = True
		End If								
		
	Case "Epson"
		If ivo_epson.of_emite_comprovante(ps_titulo,ps_texto[], lvd_Valor) Then
			lvb_Sucesso = True
		End If				
		
	Case Else	
		If ivo_sweda.of_emite_comprovante(ps_titulo,ps_texto[], lvd_Valor) Then
			lvb_Sucesso = True
		End If		
End Choose

Return lvb_Sucesso

//If lvb_Sucesso Then
////	This.of_registra_documento_ecf("RG", ps_Titulo, pdc_Valor)
//	
//	Return True
//End If		
end function

public function boolean of_cancela_item (integer pl_item);If This.ivb_Modo_Teste Then Return True

Choose Case This.Fabricante 
	Case "Bematech"
		Return ivo_bematech.of_cancela_item(pl_item)

	Case "Daruma"
		Return ivo_daruma.of_cancela_item(pl_item)
		
	Case "NFCE", "SAT"
		Return True			
		
	Case "Epson"
		Return ivo_epson.of_cancela_item(pl_item)
		
	Case Else	
		Return ivo_sweda.of_cancela_item(pl_item)
End Choose

end function

public function boolean of_abreporta ();Boolean lb_Sucesso

If This.ivb_Modo_Teste Then Return True

Choose Case This.Fabricante 
	Case "Bematech"
		lb_Sucesso = ivo_bematech.of_abreporta()
		
		If lb_Sucesso Then This.Modelo 	= ivo_bematech.de_Modelo
		If lb_Sucesso Then This.nr_Serie = ivo_bematech.nr_Serie
		If lb_Sucesso Then This.Ecf    	= ivo_bematech.Ecf
				
	Case "Daruma"
		lb_Sucesso = ivo_Daruma.of_abreporta()
		
		If lb_Sucesso Then This.Modelo = ivo_Daruma.de_Modelo
		If lb_Sucesso Then This.nr_Serie = ivo_Daruma.nr_Serie_MFD		
		If lb_Sucesso Then This.Ecf    = ivo_Daruma.Ecf

	Case "NFCE"
		lb_Sucesso = ivo_NFCE.of_abreporta()		
		
	Case "SAT"
		lb_Sucesso = ivo_SAT.of_abreporta()		
	
	Case "Epson"
		lb_Sucesso = ivo_epson.of_abreporta()
		
		If lb_Sucesso Then This.Modelo 	= ivo_epson.de_Modelo
		If lb_Sucesso Then This.nr_Serie = ivo_epson.nr_Serie
		If lb_Sucesso Then This.Ecf    	= ivo_epson.Ecf	
		
	Case Else
		lb_Sucesso = ivo_sweda.of_abreporta()
		
		If lb_Sucesso Then This.Modelo 	= ivo_sweda.Modelo
		If lb_Sucesso Then This.nr_Serie = ivo_sweda.nr_Serie
		If lb_Sucesso Then This.Ecf    	= ivo_sweda.Ecf
		
End Choose

Return lb_Sucesso

end function

public function boolean of_modo_impressora ();String ls_INI,&
       ls_Modelo,&
       ls_Modo,&
       ls_Gaveta,&
	   ls_Timeout,&
	   ls_Log,&
	   ls_modo_inc

Boolean lb_Verifica_Porta = FALSE

ls_INI = gvo_Aplicacao.ivs_Arquivo_INI

If IsNull(ls_INI) Or Trim(ls_INI) = "" Then
	Return True
End If

// Verifica se o caminho dos arquivos de ajuda est$$HEX1$$e300$$ENDHEX$$o especificados no INI
ls_Modelo  = ProfileString(ls_INI, "ECF" , "Modelo","")
ls_Modo    = ProfileString(ls_INI, "ECF" , "Modo","")
ls_Gaveta  = ProfileString(ls_INI, "ECF" , "Gaveta","")
ls_Timeout = ProfileString(ls_INI, "ECF" , "Timeout" , "")
This.nm_impressora_nfce = ProfileString(ls_INI, "ECF" , "NomeImpressora" , "")
ls_modo_inc = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "Desenvolvimento", "Inclusao_NF","")

//This.cd_caixa 	= ProfileString(ls_INI, "CAIXA" , "Caixa" , "")

Try
	uo_parametro_pdv lo_parametro_pdv
	lo_parametro_pdv = create uo_parametro_pdv
	This.cd_caixa = lo_parametro_pdv.of_get_cd_caixa( )
	
Catch( RuntimeError ru )
	MessageBox( "RuntimeError", ru.getMessage( ) + '~ruo_pdv.of_modo_impressora( )', StopSign! )
Finally
	Destroy lo_parametro_pdv
End Try

Choose Case Upper(Trim(ls_Modelo))
	Case "BEMATECH"
		If IsValid(ivo_Bematech) Then Return True
		ivo_Bematech    = Create uo_Bematech
		This.Fabricante = "Bematech"
		
	Case "DARUMA"
		ivo_Daruma  = Create uo_Daruma
		This.Fabricante = "Daruma"
		
	Case "NFCE"
		This.Fabricante = "NFCE"			
		
		If gvo_parametro.id_nfce_ativa = 'S' Then
			If IsNull(gvo_parametro.de_especie_NFCE) Or Trim(gvo_parametro.de_especie_NFCE) = ''  Then  // Verifica especie do parametro, que ser$$HEX1$$e100$$ENDHEX$$ gravada com especie da NF de venda.
				Messagebox("NFC-e","Especie NFC-e do Par$$HEX1$$e200$$ENDHEX$$metro n$$HEX1$$e300$$ENDHEX$$o configurada."+&
							  " Avise o Departamento de Inform$$HEX1$$e100$$ENDHEX$$tica.", StopSign!)
				Return False
			End If			
			If IsNull(gvo_parametro.de_serie_NFCE) Or Trim(gvo_parametro.de_serie_NFCE) = ''  Then  // Verifica serie do parametro, que ser$$HEX1$$e100$$ENDHEX$$ gravada com serie da NF de venda.
				Messagebox("NFC-e","Serie NFC-e do Par$$HEX1$$e200$$ENDHEX$$metro n$$HEX1$$e300$$ENDHEX$$o configurada."+&
							  " Avise o Departamento de Inform$$HEX1$$e100$$ENDHEX$$tica.", StopSign!)
				Return False
			End If
			If IsNull(gvo_parametro.nr_csc_token) Or Trim(gvo_parametro.nr_csc_token) = ''  Then  // Verifica token.
				Messagebox("NFC-e","Token n$$HEX1$$e300$$ENDHEX$$o configurado no Par$$HEX1$$e200$$ENDHEX$$metro da Loja."+&
							  " Avise o Departamento de Inform$$HEX1$$e100$$ENDHEX$$tica.", StopSign!)
				Return False
			End If			
			If IsNull(gvo_parametro.nr_token_NFCE) Or Trim(gvo_parametro.nr_token_NFCE) = ''  Then  // Verifica id Token CSC.
				Messagebox("NFC-e","Identificador Token n$$HEX1$$e300$$ENDHEX$$o configurado no Par$$HEX1$$e200$$ENDHEX$$metro."+&
							  " Avise o Departamento de Inform$$HEX1$$e100$$ENDHEX$$tica.", StopSign!)
				Return False
			End If				
			If Not This.ivb_Porta_Aberta Then		
				ivo_nfce  = Create uo_ge039_nfce
			End If
		Else
			Messagebox("NFC-e","Par$$HEX1$$e200$$ENDHEX$$metro NFC-e n$$HEX1$$e300$$ENDHEX$$o ativado na Loja."+&
						  " Avise o Departamento de Inform$$HEX1$$e100$$ENDHEX$$tica.", StopSign!)
			Return False
		End If		
		
	Case "SAT"
		This.Fabricante = "SAT"			
		ivo_SAT  = Create uo_ge039_sat
		If gvo_parametro.id_sat_ativa = 'S' Then
			If IsNull(gvo_parametro.de_especie_SAT) Or Trim(gvo_parametro.de_especie_SAT) = ''  Then  // Verifica especie do parametro, que ser$$HEX1$$e100$$ENDHEX$$ gravada com especie da NF de venda.
				Messagebox("SAT","Especie SAT do Par$$HEX1$$e200$$ENDHEX$$metro n$$HEX1$$e300$$ENDHEX$$o configurada."+&
							  " Avise o Departamento de Inform$$HEX1$$e100$$ENDHEX$$tica.", StopSign!)
				Return False
			End If			
			If IsNull(gvo_parametro.de_serie_SAT) Or Trim(gvo_parametro.de_serie_SAT) = ''  Then  // Verifica serie do parametro, que ser$$HEX1$$e100$$ENDHEX$$ gravada com serie da NF de venda.
				Messagebox("SAT","Serie SAT do Par$$HEX1$$e200$$ENDHEX$$metro n$$HEX1$$e300$$ENDHEX$$o configurada."+&
							  " Avise o Departamento de Inform$$HEX1$$e100$$ENDHEX$$tica.", StopSign!)
				Return False
			End If
			If IsNull(gvo_parametro.cd_ativacao_SAT) Or Trim(gvo_parametro.cd_ativacao_SAT) = ''  Then  // Verifica senha aparelho SAT
				Messagebox("SAT","C$$HEX1$$f300$$ENDHEX$$digo ativa$$HEX2$$e700e300$$ENDHEX$$o do SAT n$$HEX1$$e300$$ENDHEX$$o configurada."+&
							  " Avise o Departamento de Inform$$HEX1$$e100$$ENDHEX$$tica.", StopSign!)
				Return False
			End If						
		Else
			Messagebox("SAT","Par$$HEX1$$e200$$ENDHEX$$metro SAT n$$HEX1$$e300$$ENDHEX$$o ativado na Loja."+&
						  " Avise o Departamento de Inform$$HEX1$$e100$$ENDHEX$$tica.", StopSign!)
			Return False
		End If				
		
	Case "EPSON"
		If IsValid(ivo_Epson) Then Return True
		ivo_Epson    = Create uo_Epson
		This.Fabricante = "Epson"	
		
	Case Else
		If Not This.ivb_Porta_Aberta Then		
			ivo_Sweda  = Create uo_Sweda
		End If
		This.Fabricante = "Sweda"		
		
End Choose

If Upper(Trim(ls_Modo)) = "TESTE" Then 
	This.ivb_modo_teste = True
Else
	This.ivb_modo_teste = False	
End If

If Upper(Trim(ls_modo_inc)) = "S" Then
	This.ivb_modo_teste = True
End If

If Upper(Trim(ls_Gaveta)) = "SIM" Then 
	This.ivb_gaveta = True
Else
	This.ivb_gaveta = False
End If

If IsNumber(ls_Timeout) Then
	This.Timeout = Long(ls_Timeout)
Else
	This.Timeout = 10
End If

If Not This.of_abreporta() Then Return False

Return True
end function

public function boolean of_abre_gaveta ();If This.ivb_Modo_Teste Then Return True

Choose Case This.Fabricante 
	Case "Bematech"
		Return True
		
	Case "Daruma"
		Return ivo_Daruma.of_abre_gaveta()
		
	Case "NFCE", "SAT"
		Return True					
		
	Case "Epson"
		Return True		
		
	Case Else	
		Return ivo_sweda.of_abre_gaveta()
End Choose

end function

public function boolean of_emite_comprovante (string ps_titulo, string ps_texto[], decimal pdc_valor);If This.ivb_Modo_Teste Then Return True

Boolean lvb_Sucesso = False

If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = "RL" Then
	This.ivb_Aviso_cupom_aberto = True
End If

Choose Case This.Fabricante 
	Case "Bematech"
		If ivo_Bematech.of_emite_comprovante(ps_titulo,ps_texto[],pdc_valor) Then
			lvb_Sucesso = True
		End If		

	Case "Daruma"
		If ivo_Daruma.of_emite_comprovante(ps_titulo,ps_texto[], pdc_valor) Then
			lvb_Sucesso = True
		End If		

	Case "NFCE"
		If ivo_NFCE.of_emite_comprovante(ps_titulo,ps_texto[], pdc_valor) Then
			lvb_Sucesso = True
		End If						
		
	Case "SAT"
		If ivo_SAT.of_emite_comprovante(ps_titulo,ps_texto[], pdc_valor) Then
			lvb_Sucesso = True
		End If	
		
	Case "Epson"
		If ivo_epson.of_emite_comprovante(ps_titulo,ps_texto[], pdc_valor) Then
			lvb_Sucesso = True
		End If				
		
	Case Else	
		If ivo_sweda.of_emite_comprovante(ps_titulo,ps_texto[], pdc_valor) Then
			lvb_Sucesso = True
		End If		
End Choose

If lvb_Sucesso And pdc_Valor > 0 Then
	This.of_registra_documento_ecf("RG", ps_Titulo, pdc_Valor)
End If		

Return lvb_Sucesso
end function

public function boolean of_sangria_caixa (decimal pdc_valor);Boolean lvb_Sucesso = False

Choose Case This.Fabricante 
	Case "Bematech"
		If ivo_bematech.of_Sangria_Caixa(pdc_valor) Then
			lvb_Sucesso = True
		End If
	Case "Daruma"
		If ivo_Daruma.of_Sangria_Caixa(pdc_valor) Then
			lvb_Sucesso = True
		End If
	Case "NFCE"
		If ivo_NFCE.of_Sangria(pdc_valor) Then
			lvb_Sucesso = True
		End If
	Case "SAT"
		If ivo_SAT.of_Sangria(pdc_valor) Then
			lvb_Sucesso = True
		End If		
	Case "Epson"
		If ivo_epson.of_Sangria_Caixa(pdc_valor) Then
			lvb_Sucesso = True
		End If		
	Case Else	
		If ivo_sweda.of_Sangria_Caixa(pdc_valor) Then
			lvb_Sucesso = True
		End If
End Choose

If lvb_Sucesso Then
	This.of_registra_documento_ecf("CN", "SANGRIA", pdc_Valor)
End If

Return lvb_Sucesso

end function

public function boolean of_suprimento_caixa (decimal pdc_valor);Boolean lvb_Sucesso = False

Choose Case This.Fabricante 
	Case "Bematech"
		If ivo_bematech.of_Suprimento_Caixa(pdc_valor) Then
			lvb_Sucesso = True
		End If
	Case "Daruma"
		If ivo_Daruma.of_Suprimento_Caixa(pdc_valor) Then
			lvb_Sucesso = True
		End If
	Case "NFCE"
		If ivo_NFCE.of_Suprimento(pdc_valor) Then
			lvb_Sucesso = True
		End If
	Case "SAT"
		If ivo_SAT.of_Suprimento(pdc_valor) Then
			lvb_Sucesso = True
		End If
	Case "Epson"
		If ivo_epson.of_Suprimento_Caixa(pdc_valor) Then
			lvb_Sucesso = True
		End If		
	Case Else	
		If ivo_Sweda.of_Suprimento_Caixa(pdc_valor) Then
			lvb_Sucesso = True
		End If
End Choose

If lvb_Sucesso Then
	This.of_registra_documento_ecf("CN", "SUPRIMENTO", pdc_Valor)
End If		

Return lvb_Sucesso

end function

public function boolean of_atualiza_cadastro_ecf ();Boolean lb_Sucesso = False

If This.ivb_Modo_Teste Then Return True

If This.ivb_Cadastrada Then Return True

If This.ecf = 0 Then Return True

Choose Case This.Fabricante 
	Case "Bematech"
		lb_Sucesso = ivo_bematech.of_atualiza_cadastro_ecf()
		If lb_Sucesso Then This.ivb_Cadastrada = ivo_bematech.ivb_Cadastrada
		
	Case "Daruma"
		lb_Sucesso = ivo_Daruma.of_atualiza_cadastro_ecf()
		If lb_Sucesso Then This.ivb_Cadastrada = ivo_daruma.ivb_Cadastrada
		
	Case "NFCE"
		Return True							
		
	Case "SAT"
		Return True	//Verifica$$HEX2$$e700e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ feita na fun$$HEX2$$e700e300$$ENDHEX$$o abre porta
		
	Case "Epson"
		lb_Sucesso = ivo_epson.of_atualiza_cadastro_ecf()
		If lb_Sucesso Then This.ivb_Cadastrada = ivo_epson.ivb_Cadastrada		
		
	Case Else	
		lb_Sucesso = ivo_Sweda.of_atualiza_cadastro_ecf()
		If lb_Sucesso Then This.ivb_Cadastrada = ivo_sweda.ivb_Cadastrada
		
End Choose

Return lb_Sucesso
end function

public function boolean of_inicializa_cupom (string ps_cpf_cgc);If This.ivb_Modo_Teste Then Return True

Choose Case This.Fabricante 
	Case "Bematech"
		Return ivo_bematech.of_inicializa_cupom(ps_cpf_cgc)
	
	Case "Daruma"
		Return ivo_Daruma.of_inicializa_cupom(ps_cpf_cgc)

	Case "NFCE"
		Return ivo_NFCE.of_abre_doc()		
		
	Case "SAT"
		Return ivo_SAT.of_abre_doc()				
		
	Case "Epson"
		Return ivo_epson.of_inicializa_cupom(ps_cpf_cgc)		
		
	Case Else	
		Return ivo_sweda.of_inicializa_cupom(ps_cpf_cgc)
End Choose

end function

public function boolean of_emite_comprovante (string ps_titulo, string ps_texto[], decimal pdc_valor, boolean pb_imprime_cod_barras, string ps_cod_barras);If This.ivb_Modo_Teste Then Return True

Boolean lvb_Sucesso = False

If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = "RL" Then
	This.ivb_Aviso_cupom_aberto = True
End If

Choose Case This.Fabricante 
	Case "Bematech"		
		ivo_Bematech.ivb_Cod_Barras = pb_Imprime_Cod_Barras
		ivo_Bematech.ivs_Cod_Barras = ps_Cod_Barras		
		If ivo_Bematech.of_emite_comprovante(ps_titulo,ps_texto[],pdc_valor) Then
			lvb_Sucesso = True
		End If		
		ivo_Bematech.ivb_Cod_Barras = False
		SetNull(ivo_Bematech.ivs_Cod_Barras)		
		
	Case "Daruma"
		ivo_Daruma.ivb_Cod_Barras = pb_Imprime_Cod_Barras
		ivo_Daruma.ivs_Cod_Barras = ps_Cod_Barras				
		If ivo_Daruma.of_emite_comprovante(ps_titulo,ps_texto[], pdc_valor) Then
			lvb_Sucesso = True
		End If		
		ivo_Daruma.ivb_Cod_Barras = False
		SetNull(ivo_Daruma.ivs_Cod_Barras)

	Case "NFCE"
		ivo_NFCE.ivb_Cod_Barras = pb_Imprime_Cod_Barras
		ivo_NFCE.ivs_Cod_Barras = ps_Cod_Barras						
		If ivo_NFCE.of_emite_comprovante(ps_titulo,ps_texto[], pdc_valor) Then
			lvb_Sucesso = True
		End If		
		ivo_NFCE.ivb_Cod_Barras = False
		SetNull(ivo_NFCE.ivs_Cod_Barras)		
		
	Case "SAT"
		ivo_SAT.ivb_Cod_Barras = pb_Imprime_Cod_Barras
		ivo_SAT.ivs_Cod_Barras = ps_Cod_Barras						
		If ivo_SAT.of_emite_comprovante(ps_titulo,ps_texto[], pdc_valor) Then
			lvb_Sucesso = True
		End If		
		ivo_SAT.ivb_Cod_Barras = False
		SetNull(ivo_SAT.ivs_Cod_Barras)				
		
	Case "Epson"
		ivo_epson.ivb_Cod_Barras = pb_Imprime_Cod_Barras
		ivo_epson.ivs_Cod_Barras = ps_Cod_Barras				
		If ivo_epson.of_emite_comprovante(ps_titulo,ps_texto[], pdc_valor) Then
			lvb_Sucesso = True
		End If		
		ivo_epson.ivb_Cod_Barras = False
		SetNull(ivo_epson.ivs_Cod_Barras)		
		
	Case Else	
		ivo_Sweda.ivb_Cod_Barras = pb_Imprime_Cod_Barras
		ivo_Sweda.ivs_Cod_Barras = ps_Cod_Barras
		If ivo_sweda.of_emite_comprovante(ps_titulo,ps_texto[], pdc_valor) Then
			lvb_Sucesso = True
		End If		
		ivo_Sweda.ivb_Cod_Barras = False
		SetNull(ivo_Sweda.ivs_Cod_Barras)
End Choose

If lvb_Sucesso And pdc_Valor > 0 Then
	This.of_registra_documento_ecf("RG", ps_Titulo, pdc_Valor)
End If		

Return lvb_Sucesso
end function

public function boolean of_fecha_comprovante_tef_nao_finalizado ();If This.ivb_Modo_Teste Then Return True

Choose Case This.Fabricante 
	Case "Bematech"
		Return ivo_bematech.of_fecha_comprovante_tef()

		
	Case "Daruma"
		Return ivo_Daruma.of_fecha_comprovante_tef()

	Case "NFCE", "SAT"
		Return True					
		
	Case "Epson"
		Return ivo_epson.of_fecha_comprovante_tef()		

	Case Else				
		Return ivo_sweda.of_fecha_comprovante_nao_finalizado()	

End Choose
end function

public function boolean of_fecha_relatorio_gerencial (boolean pb_fecha_normal);If This.ivb_Modo_Teste Then Return True

Choose Case This.Fabricante 
	Case "Bematech"
		Return ivo_bematech.of_fecha_relatorio_gerencial()

	Case "Daruma"
		Return ivo_Daruma.of_fecha_relatorio_gerencial()

	Case "NFCE"
		Return ivo_NFCE.of_finaliza_impressao_texto()		

	Case "SAT"
		Return ivo_SAT.of_finaliza_impressao_texto()				
		
	Case "Epson"
		Return ivo_epson.of_fecha_relatorio_gerencial()		
		
	Case Else	
		If pb_Fecha_Normal Then
			Return ivo_sweda.of_fecha_cupom_nao_fiscal()
		Else
			Return ivo_sweda.of_fecha_comprovante_nao_finalizado()		
		End IF
End Choose
end function

public function boolean of_texto_relatorio_gerencial (string ps_texto);Choose Case This.Fabricante 
	Case "Bematech"
		Return ivo_bematech.of_texto_relatorio_gerencial(ps_texto)
		
	Case "Daruma"
		Return ivo_Daruma.of_texto_relatorio_gerencial(ps_texto)

	Case "NFCE"
		Return ivo_NFCE.of_imprime_texto(ps_texto)					
		
	Case "SAT"
		Return ivo_SAT.of_imprime_texto(ps_texto)	
		
	Case "Epson"
		Return ivo_epson.of_texto_relatorio_gerencial(ps_texto)
		
	Case Else	
		Return ivo_sweda.of_texto_nao_fiscal_tef(ps_texto)
End Choose
end function

public function boolean of_inicializa_comprovante_nao_fiscal (string ps_tipo_recebimento, string ps_descricao, string ps_tipo_pagamento, decimal pdc_valor);If This.ivb_Modo_Teste Then Return True

Choose Case This.Fabricante 
	Case "Bematech"
		Return ivo_Bematech.of_inicializa_comprovante_nao_fiscal(ps_tipo_pagamento,ps_descricao,ps_tipo_recebimento,pdc_valor)
		
	Case "Daruma"
		Return ivo_Daruma.of_inicializa_comprovante_nao_fiscal(ps_tipo_pagamento,ps_descricao,ps_tipo_recebimento,pdc_valor)
		
	Case "NFCE"
		Return ivo_NFCE.of_comprovante_nao_fiscal(ps_tipo_pagamento,ps_descricao,ps_tipo_recebimento,pdc_valor)		
		
	Case "SAT"
		Return ivo_SAT.of_comprovante_nao_fiscal(ps_tipo_pagamento,ps_descricao,ps_tipo_recebimento,pdc_valor)
		
	Case "Epson"
		Return ivo_epson.of_inicializa_comprovante_nao_fiscal(ps_tipo_pagamento,ps_descricao,ps_tipo_recebimento,pdc_valor)
		
	Case Else	
		Return ivo_sweda.of_inicializa_comprovante_nao_fiscal(ps_tipo_recebimento,ps_descricao,ps_tipo_pagamento,pdc_valor)
End Choose
end function

public function boolean of_codigo_barras (integer pl_tipo, string ps_codigo, string ps_tamanho);If This.ivb_Modo_Teste Then Return True

Choose Case This.Fabricante 
	Case "Bematech"
		Return ivo_bematech.of_Codigo_Barras(pl_Tipo,ps_Codigo,ps_Tamanho)
	Case "Daruma"
		Return ivo_Daruma.of_Codigo_Barras(pl_Tipo,ps_Codigo,ps_Tamanho)		
	Case "NFCE", "SAT"
		Return True
	Case "Epson"
		Return ivo_Epson.of_Codigo_Barras(pl_Tipo,ps_Codigo,ps_Tamanho)
	Case Else
		Return ivo_Sweda.of_Codigo_Barras(pl_Tipo,ps_Codigo,ps_Tamanho)		
End Choose

end function

public function boolean of_converte_data_cat52 (date pd_data, ref string ps_extensao);//Fun$$HEX2$$e700e300$$ENDHEX$$o para converter uma data na extens$$HEX1$$e300$$ENDHEX$$o de arquivo pedida na legisla$$HEX2$$e700e300$$ENDHEX$$o CAT-52
//A extens$$HEX1$$e300$$ENDHEX$$o do arquivo gerado pela ECF $$HEX1$$e900$$ENDHEX$$ definida por dia, m$$HEX1$$ea00$$ENDHEX$$s e ano da redu$$HEX2$$e700e300$$ENDHEX$$o Z, exemplo: .ACD (10/12/2013).
//Onde os n$$HEX1$$fa00$$ENDHEX$$meros de 01 a 09 correspondem as dias de 01 a 09.
//As letras de A at$$HEX1$$e900$$ENDHEX$$ Z compreendem os dias acima de 09, onde o dia 10 corresponde a letra A, 
//dia 11 a letra B, dia 12 a letra C e assim sucessivamente.

String ls_st1, ls_st2, ls_st3
String ls_dia, ls_mes, ls_ano
String ls_Data

ls_Data = String(pd_data, 'ddmmyyyy')

ls_dia 	= 	String(Day(pd_data),'00')
ls_mes 	=	String(Month(pd_data),'00')
ls_ano	=	RightA(String(Year(pd_data),'0000'),2)

If Long(ls_dia) >= 1 and  Long(ls_dia) <= 9 Then
	ls_st1 = String(Long(ls_dia))
Else
	Choose Case Long(ls_dia)
		Case 10
			ls_st1 = 'A'
		Case 11
			ls_st1 = 'B'
		Case 12
			ls_st1 = 'C'
		Case 13
			ls_st1 = 'D'
		Case 14
			ls_st1 = 'E'
		Case 15
			ls_st1 = 'F'
		Case 16
			ls_st1 = 'G'
		Case 17
			ls_st1 = 'H'
		Case 18
			ls_st1 = 'I'
		Case 19
			ls_st1 = 'J'
		Case 20
			ls_st1 = 'K'
		Case 21
			ls_st1 = 'L'
		Case 22
			ls_st1 = 'M'
		Case 23
			ls_st1 = 'N'
		Case 24
			ls_st1 = 'O'
		Case 25
			ls_st1 = 'P'
		Case 26
			ls_st1 = 'Q'
		Case 27
			ls_st1 = 'R'
		Case 28
			ls_st1 = 'S'
		Case 29
			ls_st1 = 'T'
		Case 30
			ls_st1 = 'U'
		Case 31
			ls_st1 = 'V'
		Case Else
			Return False
	End Choose
End If

If Long(ls_mes) >= 1 and  Long(ls_mes) <= 9 Then
	ls_st2 = String(Long(ls_mes))
Else
	Choose Case Long(ls_mes)
		Case 10
			ls_st2 = 'A'
		Case 11
			ls_st2 = 'B'
		Case 12
			ls_st2 = 'C'
		Case Else
			Return False
	End Choose
End If

If Long(ls_ano) >= 1 and  Long(ls_ano) <= 9 Then
	ls_st3 = String(Long(ls_ano))
Else
	Choose Case Long(ls_ano)
		Case 10
			ls_st3 = 'A'
		Case 11
			ls_st3 = 'B'
		Case 12
			ls_st3 = 'C'
		Case 13
			ls_st3 = 'D'
		Case 14
			ls_st3 = 'E'
		Case 15
			ls_st3 = 'F'
		Case 16
			ls_st3 = 'G'
		Case 17
			ls_st3 = 'H'
		Case 18
			ls_st3 = 'I'
		Case 19
			ls_st3 = 'J'
		Case 20
			ls_st3 = 'K'
		Case 21
			ls_st3 = 'L'
		Case 22
			ls_st3 = 'M'
		Case 23
			ls_st3 = 'N'
		Case 24
			ls_st3 = 'O'
		Case 25
			ls_st3 = 'P'
		Case 26
			ls_st3 = 'Q'
		Case 27
			ls_st3 = 'R'
		Case 28
			ls_st3 = 'S'
		Case 29
			ls_st3 = 'T'
		Case 30
			ls_st3 = 'U'
		Case 31
			ls_st3 = 'V'
		Case 32
			ls_st3 = 'W'
		Case 33
			ls_st3 = 'X'
		Case 34
			ls_st3 = 'Y'
		Case 35
			ls_st3 = 'Z'			
		Case Else
			//Acabaram as letras do alfabeto para fazer a convers$$HEX1$$e300$$ENDHEX$$o.   :(
			Return False
	End Choose
End If

ps_extensao = ls_st1 + ls_st2 + ls_st3

Return True
end function

public function boolean of_gera_cat52 (string ps_arquivo, date pdh_data_fiscal);Choose Case This.Fabricante 
	Case "Bematech"
		Return ivo_Bematech.of_gera_arquivo_cat52(ps_arquivo,pdh_data_fiscal)
	Case "Daruma"

	Case Else	
//		Return ivo_Sweda.of_gera_arquivo_cotepe1704(ps_tipo, ps_inicio, ps_final)
End Choose

end function

public function boolean of_gera_cat52 (string ps_arquivo, date pdh_data_fiscal, ref string ps_arquivo_destino);Choose Case This.Fabricante 
	Case "Bematech"
		Return ivo_Bematech.of_gera_arquivo_cat52(ps_arquivo,pdh_data_fiscal, Ref ps_arquivo_destino)
	Case "Daruma"

	Case Else	
//		Return ivo_Sweda.of_gera_arquivo_cotepe1704(ps_tipo, ps_inicio, ps_final)
End Choose

end function

public function boolean of_assina_valida_nfce ();If This.ivb_Modo_Teste Then Return True

Choose Case This.Fabricante 
	Case "NFCE"
		Return ivo_NFCE.of_assina_valida()
		
	Case "SAT"
		Return ivo_SAT.of_assina_valida()
		
End Choose

Return False;
end function

public function boolean of_emitente_nfce ();If This.ivb_Modo_Teste Then Return True

Choose Case This.Fabricante 
	Case "NFCE"
		Return ivo_NFCE.of_emitente()
		
	Case "SAT"
		Return ivo_SAT.of_emitente()		
		
End Choose

end function

public function boolean of_envia_email_nfce (string ps_chave, string ps_mail, string ps_modo);If This.ivb_Modo_Teste Then Return True

Choose Case This.Fabricante 
		
	Case "NFCE"
		Return ivo_NFCE.of_email_xml(ps_chave, ps_mail, ps_modo)
		
	Case "SAT"
		Return ivo_SAT	.of_email_xml(ps_chave, ps_mail, ps_modo)
		
End Choose

end function

public function boolean of_consulta_nfce (string ps_chave, ref string ps_protocolo, ref string ps_status, ref string ps_motivo, ref datetime pdt_data_rec, ref string ps_chave_rec);String ls_retorno

If This.ivb_Modo_Teste Then Return True

Choose Case This.Fabricante 
		
	Case "NFCE"
		Return ivo_NFCE.of_consulta_nfce(ps_chave, Ref ps_protocolo, Ref ls_retorno, Ref ps_status, Ref ps_motivo, Ref pdt_Data_Rec, Ref ps_chave_rec)
	Case Else
		Return True
		
End Choose

end function

public function integer of_verifica_cancelamento_cupom (long pl_sequencia, long pl_ecf, string ps_tipo);// Antigo

//If This.ivb_Modo_Teste Then Return 1
//
//Choose Case This.Fabricante 
//	Case "Bematech"
//		Return ivo_bematech.of_verifica_cancelamento_cupom(pl_sequencia,pl_ecf)
//
//	Case Else	
//		Return ivo_sweda.of_verifica_cancelamento_cupom(pl_sequencia,pl_ecf)
//End Choose


Long     lvl_ecf, &
         lvl_nr_nf

Datetime lvdh_Movimento,&
			lvdh_Conferencia,&
			lvdh_Devolucao

lvdh_Movimento = This.of_dh_movimentacao()

SetPointer(HourGlass!)

If ps_tipo = 'COO' Then // procura pelo coo do cupom
	//Verifica controle de caixa aberto
	Select nf.nr_nf, nf.dh_devolucao, cc.dh_conferencia INTO :lvl_nr_nf, :lvdh_devolucao, :lvdh_conferencia
	From nf_venda nf,
		  controle_caixa cc
	Where nf.nr_ecf                = :pl_ecf
	  and nf.nr_operacao_ecf       = :pl_sequencia
	  and nf.dh_movimentacao_caixa = :lvdh_Movimento
	  and cc.cd_caixa              = nf.cd_caixa
	  and cc.nr_controle_caixa     = nf.nr_controle_caixa
	Using Sqlca;
End If
If ps_tipo = 'CCF' Then //procura pelo ccf do cupom
	Select nf.nr_nf, nf.dh_devolucao, cc.dh_conferencia INTO :lvl_nr_nf, :lvdh_devolucao, :lvdh_conferencia
	From nf_venda nf,
		  controle_caixa cc
	Where nf.nr_ecf    = :pl_ecf
	  and nf.nr_ccf      = :pl_sequencia
	  and nf.dh_movimentacao_caixa = :lvdh_Movimento
	  and cc.cd_caixa              = nf.cd_caixa
	  and cc.nr_controle_caixa     = nf.nr_controle_caixa
	Using Sqlca;
End If

If SQLCA.Sqlcode = -1 Then
	SQLCA.Of_MsgDbError('Localiza$$HEX2$$e700e300$$ENDHEX$$o do cupom fiscal.')
	Return -1
End If

//Cupom Fiscal n$$HEX1$$e300$$ENDHEX$$o foi localizado
If IsNull(lvl_nr_nf) OR lvl_nr_nf = 0 Then Return 100

//Controle caixa j$$HEX1$$e100$$ENDHEX$$ conferido
If Not IsNull(lvdh_conferencia) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Controle do caixa referente ao $$HEX1$$fa00$$ENDHEX$$ltimo cupom j$$HEX1$$e100$$ENDHEX$$ foi conferido. N$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ mais permitido o cancelamento do mesmo.~nFavor emitir uma nota de devolu$$HEX2$$e700e300$$ENDHEX$$o referente ao cupom e providenciar o lan$$HEX1$$e700$$ENDHEX$$amento da mesma no caixa geral.",Exclamation!)
	Return -1
End If

//Venda j$$HEX1$$e100$$ENDHEX$$ devolvida
If Not IsNull(lvdh_devolucao) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Venda j$$HEX1$$e100$$ENDHEX$$ Devolvida, cancelamento n$$HEX1$$e300$$ENDHEX$$o permitido.",Exclamation!)
	Return -1
End If

Return 1
end function

public function boolean of_cancela_nfce (string ps_tipo_cancelamento, string ps_chave, string ps_protocolo, string ps_justificativa, long pl_nota, string ps_especie, string ps_serie, string ps_responsavel, string ps_cpf);If This.ivb_Modo_Teste Then Return True

String ls_protocolo_canc
DateTime ldt_data_cancelamento, &
			 ldh_Data_Movimento
Long ll_filial

ll_filial   = gvo_parametro.cd_filial

//Verifica se pode cancelar venda produto exame COVID.
If Not This.of_verifica_venda_exame( This.Fabricante, '', this.ECF, pl_nota, ps_especie, ps_serie) Then Return False	

//PS_TIPO_CANCELAMENTO:  0 = Cancela no SEFAZ e Banco,  1 = Somente no SEFAZ e 2 = Somente Banco
Choose Case This.Fabricante 
	Case "NFCE"
		If ps_tipo_cancelamento = "0" or ps_tipo_cancelamento = "1" Then		
			If Not ivo_NFCE.of_cancela_nfce(ps_chave, ps_protocolo, ps_justificativa, Ref ls_protocolo_canc, Ref ldt_data_cancelamento) Then
				Return False
			End If
		End If
		If ps_tipo_cancelamento = "0" or ps_tipo_cancelamento = "2" Then
			
			ldh_Data_Movimento = This.of_dh_movimentacao()
			
			Update nf_venda
				Set id_cancelamento_impressora = 'S',
					 nr_matricula_cancelamento  = :ps_Responsavel
			 Where cd_filial 			= :ll_filial
			 	and nr_nf                  = :pl_nota
				and de_especie         = :ps_especie
				and de_serie      		= :ps_serie
			Using Sqlca;
			
			If Sqlca.Sqlcode = -1 Then
				SQLCA.of_MsgDBError('Cancelamento NFC-e')
				If ps_tipo_cancelamento = "0" Then
					MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o','A NFC-e foi cancelada somente no SEFAZ, verifique a situa$$HEX2$$e700e300$$ENDHEX$$o da Nota no sistema.',Information!)
				End If
				Return False
			End If
			
			If ps_tipo_cancelamento = "0"	Then
				Update nf_venda_nfe
					Set id_situacao = 'X',
						 nr_matricula_cancelamento  = :ps_Responsavel,
						 dh_cancelamento = :ldh_data_movimento,
						 nr_protocolo_cancelamento = :ls_protocolo_canc
				 Where cd_filial 			= :ll_filial
					and nr_nf                  = :pl_nota
					and de_especie         = :ps_especie
					and de_serie      		= :ps_serie
				Using Sqlca;
				
				If Sqlca.Sqlcode = -1 Then
					SQLCA.of_MsgDBError('Cancelamento NFC-e chave.')
					If ps_tipo_cancelamento = "0" Then
						MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o','A NFC-e foi cancelada somente no SEFAZ, verifique a situa$$HEX2$$e700e300$$ENDHEX$$o da Nota no sistema.',Information!)
					End If
					Return False
				End If				
			End If
			
			If SQLCA.Of_Commit() = -1 Then
				SQLCA.Of_RollBack()
				SQLCA.Of_MsgDbError('Erro no commit')
				If ps_tipo_cancelamento = "0" Then
					MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o','A NFC-e foi cancelada somente no SEFAZ, verifique a situa$$HEX2$$e700e300$$ENDHEX$$o da Nota no sistema.',Information!)
				End If
				Return False
			ELSE
				//Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","V E N D A   C A N C E L A D A.~r~rNOTA: "+String(pl_nota)+" Especie: "+ps_especie+" Serie: "+ps_serie, Exclamation!)
				Return True
			End If			
			
		End If
		If ps_tipo_cancelamento = "1" Then
			Return True
		End If
	Case "SAT"
		If ps_tipo_cancelamento = "0" or ps_tipo_cancelamento = "1" Then		
			If Not ivo_SAT.of_cancela_sat(ps_chave, ps_protocolo, ps_cpf, Ref ls_protocolo_canc, Ref ldt_data_cancelamento) Then
				Return False
			End If
		End If
		If ps_tipo_cancelamento = "0" or ps_tipo_cancelamento = "2" Then
			
			ldh_Data_Movimento = This.of_dh_movimentacao()
			
			Update nf_venda
				Set id_cancelamento_impressora = 'S',
					 nr_matricula_cancelamento  = :ps_Responsavel
			 Where cd_filial 			= :ll_filial
			 	and nr_nf                  = :pl_nota
				and de_especie         = :ps_especie
				and de_serie      		= :ps_serie
			Using Sqlca;
			
			If Sqlca.Sqlcode = -1 Then
				SQLCA.of_MsgDBError('Cancelamento SAT')
				If ps_tipo_cancelamento = "0" Then
					MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o','O CF-e foi cancelado somente no SEFAZ, verifique a situa$$HEX2$$e700e300$$ENDHEX$$o da Nota no sistema.',Information!)
				End If
				Return False
			End If
			
			If ps_tipo_cancelamento = "0"	Then
				Update nf_venda_nfe
					Set id_situacao = 'X',
						 nr_matricula_cancelamento  = :ps_Responsavel,
						 dh_cancelamento = :ldh_data_movimento,
						 nr_protocolo_cancelamento = :ls_protocolo_canc
				 Where cd_filial 			= :ll_filial
					and nr_nf                  = :pl_nota
					and de_especie         = :ps_especie
					and de_serie      		= :ps_serie
				Using Sqlca;
				
				If Sqlca.Sqlcode = -1 Then
					SQLCA.of_MsgDBError('Cancelamento NFC-e chave.')
					If ps_tipo_cancelamento = "0" Then
						MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o','O CF-e foi cancelado somente no SEFAZ, verifique a situa$$HEX2$$e700e300$$ENDHEX$$o da Nota no sistema.',Information!)
					End If
					Return False
				End If				
			End If
			
			If ps_tipo_cancelamento = "2"	Then // EXCLUI a nota da tabela nf_venda_nfe pois ela n$$HEX1$$e300$$ENDHEX$$o foi enviada ao SEFAZ.
				Delete From nf_venda_nfe
				 Where cd_filial 			= :ll_filial
					and nr_nf                  = :pl_nota
					and de_especie         = :ps_especie
					and de_serie      		= :ps_serie
				Using Sqlca;
				
				If Sqlca.Sqlcode = -1 Then
					SQLCA.of_MsgDBError('Exclusao SAT.')
					Return False
				End If				
			End If			
			
			If SQLCA.Of_Commit() = -1 Then
				SQLCA.Of_RollBack()
				SQLCA.Of_MsgDbError('Erro no commit')
				If ps_tipo_cancelamento = "0" Then
					MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o','O CF-e foi cancelado somente no SEFAZ, verifique a situa$$HEX2$$e700e300$$ENDHEX$$o da Nota no sistema.',Information!)
				End If
				Return False
			ELSE
				//Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","V E N D A   C A N C E L A D A.~r~rNOTA: "+String(pl_nota)+" Especie: "+ps_especie+" Serie: "+ps_serie, Exclamation!)
				Return True
			End If			
			
		End If
		If ps_tipo_cancelamento = "1" Then
			Return True
		End If				
End Choose

Return False;
end function

public function string of_centraliza_texto (string ps_texto);Choose Case This.Fabricante 
	Case "Bematech"
		Return ivo_bematech.of_Centraliza_Texto( ps_texto )
		
	Case 'Daruma'
		Return ivo_Daruma.of_Centraliza_Texto( ps_texto )
		
	Case 'Sweda'	
		Return ivo_sweda.of_Centraliza_Texto( ps_texto )		

		Return ps_Texto
		
	Case "NFCE", "SAT"
		
		Return ps_Texto
		
	Case 'Epson'
		Return ivo_epson.of_Centraliza_Texto( ps_texto )
		
	Case Else
		
		Return ps_Texto
End Choose

end function

public subroutine of_quebra_linha (string ps_texto, integer pi_colunas, ref string ps_dados[]);String ls_Aux

Do While LenA( ps_Texto ) > pi_colunas
	ls_Aux = Mid( ps_Texto, 1, pi_colunas ) 
	
	ps_dados[ UpperBound( ps_dados ) + 1 ] = ls_Aux
		
	ps_Texto = Mid( ps_Texto, ( pi_colunas + 1 ) )
Loop 

If LenA(ps_Texto) > 0 Then 
	ps_dados[ UpperBound( ps_dados ) + 1 ] = ps_Texto
End If

Return

end subroutine

public subroutine of_quebra_linha (string ps_texto, ref string ps_dados[]);Choose Case This.Fabricante 
	Case "Bematech"
		This.of_Quebra_Linha( ps_texto, ivo_bematech.COLUNAS, Ref ps_dados[] )
			
	//Case "NFCE", "SAT"
	
	Case Else
		This.of_Quebra_Linha( ps_texto, 48, Ref ps_dados[] )
					
End Choose

Return
end subroutine

public function boolean of_destinatario_nfce (string ps_cpf_cgc, string ps_codigo_cliente, string ps_nm_cliente, string ps_endereco, string ps_nr_endereco, string ps_bairro, string ps_cidade_ibge, string ps_nm_cidade, string ps_uf, string ps_email_xml, boolean pb_programa_governo, boolean pb_mesmo_cpf);If This.ivb_Modo_Teste Then Return True

Choose Case This.Fabricante 
	Case "NFCE"
		Return ivo_NFCE.of_destinatario(ps_cpf_cgc, ps_codigo_cliente, ps_nm_cliente, ps_endereco, ps_nr_endereco,&
												  ps_bairro, ps_cidade_ibge, ps_nm_cidade, ps_uf, ps_email_xml, pb_programa_governo, pb_mesmo_cpf)

	Case "SAT"
		Return ivo_SAT.of_destinatario(ps_cpf_cgc, ps_codigo_cliente, ps_nm_cliente, ps_endereco, ps_nr_endereco,&
												 ps_bairro, ps_cidade_ibge, ps_nm_cidade, ps_uf, ps_email_xml, pb_programa_governo, pb_mesmo_cpf)		
		
End Choose

end function

public function boolean of_verifica_aliquotas ();Long ll_row
Decimal {2} ldc_pc_aliquota

If This.ivb_Modo_Teste Then Return True

If This.Fabricante = "NFCE" or This.Fabricante = "SAT" Then
	Return True
End If

ids_aliquotas = Create dc_uo_ds_base

If Not ids_aliquotas.of_ChangeDataObject('ds_ge039_aliquota_ecf') Then Return False

ids_aliquotas.of_RestoreSqlOriginal()

ids_aliquotas.Retrieve(gvo_parametro.ivs_uf_filial)

//For ll_Row = 1 To ids_aliquotas.RowCount()
//	ldc_pc_aliquota = ids_aliquotas.object.pc_icms [ll_row] + ids_aliquotas.object.pc_fcp [ll_row]
//Next

Choose Case This.Fabricante 
	Case "Bematech"
		Return ivo_bematech.of_programa_aliquota(True,0,0,False)
		
	Case "Daruma"		
		Return ivo_daruma.of_programa_aliquota(True,0,0,False)
	
	Case "Sweda"
		Return ivo_sweda.of_programa_aliquota(True,0,0,False)
		
	Case "Epson"
		Return ivo_epson.of_programa_aliquota(True,0,0,False)		
End Choose

Destroy(ids_aliquotas)

Return True
end function

public function boolean of_atualiza_primeira_venda_ecf (integer pl_ecf, datetime pdt_data, boolean pb_atualiza);Boolean		lb_Sucesso
DateTime 	ldh_Data_Atual
String 		ls_Serie
Long			ll_ecf

If IsNull(pl_ecf) or pl_ecf = 0 Then
	This.of_nr_ecf(ll_ecf)
	pl_ecf = ll_ecf
End If

Select nr_serie, dh_primeira_venda_dia
Into   :ls_serie, :ldh_Data_Atual
From   impressora_fiscal
Where nr_ecf = :pl_ecf
Using Sqlca;

Choose Case Sqlca.SqlCode
	Case 0		
		If (Isnull(ldh_Data_Atual)) Or (date(ldh_Data_Atual) < date(pdt_data)) Then
		
			Update impressora_fiscal
			Set dh_primeira_venda_dia = :pdt_data
			Where nr_ecf = :pl_ecf
			Using Sqlca;
			
			If Sqlca.Sqlcode <> 0 Then
				Sqlca.of_Rollback()
				Sqlca.of_MsgDBError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o Dados ECF.")
				Return False
			Else
				lb_Sucesso = True
			End If				
			
			If lb_Sucesso And pb_Atualiza Then
				Sqlca.of_Commit()
			Else
				Sqlca.of_Rollback()				
			End If		
			
			Return True	
		End If
		
	Case 100
		Return False
	Case -1
		Sqlca.of_Rollback()		
		Sqlca.of_MsgDbError('Atualiza$$HEX2$$e700e300$$ENDHEX$$o Primeira Venda ECF.')		
		Return False
End Choose

Return True

end function

public function boolean of_data_hora_ecf (ref datetime pdt_data_hora);Choose Case This.Fabricante 
	Case "Bematech"
		Return ivo_bematech.of_data_hora_ecf(Ref pdt_data_hora)
		
	Case "Daruma"
		Return ivo_Daruma.of_data_hora_ecf(Ref pdt_data_hora)

	Case "NFCE", "SAT"
		pdt_data_hora = DateTime(Today())		
		Return True
		
	Case "Epson"
		Return ivo_epson.of_data_hora_ecf(Ref pdt_data_hora)		
		
	Case Else	
		Return ivo_sweda.of_data_hora_ecf(Ref pdt_data_hora)
End Choose
end function

public function boolean of_fecha_cupom (string ps_msg[], boolean pb_repete, string ps_indicadores[6, 2], string ps_vinculado, string ps_tipo_envio_nfce, string ps_email_envio, ref string ps_chave_nfce, ref string ps_status, ref string ps_motivo_rej, ref string ps_dir_xml, ref datetime pdt_data_recebimento, ref string ps_protocolo, ref long pl_retorno, decimal pdc_vl_recebido, decimal pdc_troco, string ps_emite_em_contingencia);If This.ivb_Modo_Teste Then Return True

String ls_nulo
SetNull(ls_nulo)

Choose Case This.Fabricante 
	Case "Bematech"
		Return ivo_Bematech.of_fecha_cupom(ps_msg[],pb_repete,ps_indicadores[],ps_vinculado)
		
	Case "Daruma"
		Return ivo_Daruma.of_Fecha_Cupom(ps_msg[],pb_repete,ps_indicadores[],ps_vinculado)		
	
	Case "NFCE"
		ivo_NFCE.of_fecha_nota( ls_nulo, ls_nulo, ls_nulo, '4', ps_tipo_envio_nfce, ps_email_envio, Ref ps_chave_nfce , Ref ps_status , ref ps_motivo_rej , ref ps_dir_xml ,ref pdt_data_recebimento, ref ps_protocolo, ref pl_retorno, pdc_vl_recebido, pdc_troco, ps_emite_em_contingencia )
		Choose Case pl_retorno
			Case 1 
				Return True
			Case -1, -2 // -1 = Erro de comunicacao com o SEFAZ -2 erro por valida$$HEX2$$e700e300$$ENDHEX$$o.
				Return True
			Case -3 //Duplicidade de nota no SEFAZ
				Return False				
			Case Else
				Return False
		End Choose
		
	Case "SAT"
		ivo_SAT.of_fecha_nota( ls_nulo, ls_nulo, ls_nulo, '4', ps_tipo_envio_nfce, ps_email_envio, Ref ps_chave_nfce , Ref ps_status , ref ps_motivo_rej , ref ps_dir_xml ,ref pdt_data_recebimento, ref ps_protocolo, ref pl_retorno )
		Choose Case pl_retorno
			Case 1 
				Return True
			Case Else
				Return False
		End Choose
		
	Case "Epson"
		Return ivo_epson.of_Fecha_Cupom(ps_msg[],pb_repete,ps_indicadores[],ps_vinculado)				
	
	Case Else	
		Return ivo_sweda.of_fecha_cupom(ps_msg[],pb_repete,ps_indicadores[],ps_vinculado)
End Choose
end function

public function long of_ecf_caixa ();Long ll_ecf

select max(nr_ecf)  into :ll_ecf
from nf_venda 
where cd_filial = :gvo_parametro.cd_filial
and  nf_venda.dh_emissao >= dbo.adddate('day', -3, Getdate())
and cd_caixa = :This.cd_caixa
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		Return ll_ecf
	Case 100
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Sem vendas para o Caixa", StopSign!)
		Return 0
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o da ECF do Caixa." + SqlCa.SqlErrText, StopSign!)
		Return 0
End Choose
end function

public function boolean of_data_ultima_venda_sistema (ref datetime pdt_data_venda);If This.ivb_Modo_Teste Then Return True

Boolean lb_Sucesso = False

Select Max(dh_ultima_venda) Into :pdt_data_Venda
From impressora_fiscal
Using Sqlca;

If Sqlca.Sqlcode = -1 Then
	Sqlca.of_MsgDbError('Data Ultima Venda ECF no sistema.')
	lb_sucesso = False
Else
	lb_sucesso = True
End If	

Return lb_Sucesso
end function

public function boolean of_retorna_doc_aberto (ref long pl_doc);//Fun$$HEX2$$e700e300$$ENDHEX$$o retorna o documento aberto na ECF
//0 - Sem documento Aberto / 1 - Cupom fiscal / 2 - CCD / 3 - RG / 4 - Cupom N$$HEX1$$e300$$ENDHEX$$o Fiscal
If This.ivb_Modo_Teste Then Return True

Choose Case This.Fabricante 
	Case "Bematech"
		Return ivo_bematech.of_retorna_doc_aberto(Ref pl_doc)		
		
	Case "Daruma"  //N$$HEX1$$e300$$ENDHEX$$o temos mais Daruma para testar, por isso retorno 0.
		pl_doc = 0
		Return True
		
	Case "NFCE", "SAT"
		pl_doc = 0
		Return True					
		
	Case "Epson"
		Return ivo_epson.of_retorna_doc_aberto(Ref pl_doc)
		
	Case Else	
		Return ivo_sweda.of_retorna_doc_aberto(Ref pl_doc)
End Choose

end function

public function boolean of_imprime_nfce (string ps_chave_nota, string ps_protocolo, string ps_formato, string ps_contingencia, string ps_modo, decimal pdc_vl_recebido, decimal pdc_vl_troco, ref string ps_chave_retorno);If This.ivb_Modo_Teste Then Return True

Choose Case This.Fabricante 
	Case "NFCE"
		Return ivo_NFCE.of_imprime_nota(ps_chave_nota, ps_protocolo, ps_formato, ps_contingencia, ps_modo, pdc_vl_recebido, pdc_vl_troco, Ref ps_chave_retorno)
		
	Case "SAT"
		Return ivo_SAT.of_imprime_nota(ps_chave_nota, ps_protocolo, ps_formato, ps_contingencia, ps_modo)		
		
End Choose

Return False;
end function

public function boolean of_gera_espelho_mfd_mensal (long pl_ecf, date pdt_data_fiscal);Boolean 	lb_Sucesso = False, &
			lb_sem_nota, &
			lb_null
Date 	ldt_data_referencia, &
		ldt_fiscal_ref, &
		ldt_data_cont, &
		ldt_fim
Long 	ll_mes_ref, &
		ll_ano_ref, &
		ll_qtd_venda, &
		ll_filial, &
		ll_file, &
		ll_file_log, &
		ll_ecf_24hr

String	ls_arquivo, &
		ls_caminho = 'c:\sistemas\rl\arquivos\mfd\', &
		ls_arquivo_log, &
		ls_procura_log, &
		ls_conteudo_log, &
		ls_erro, &
		ls_arquivo_ftp, &
		ls_msg, &
		ls_24h, &
		ls_base_producao
		
If pl_ecf <= 0 Then
	PDV.of_nr_ecf(Ref pl_ecf)
End If

uo_Parametro_Filial lo_Parametro_Filial
lo_Parametro_Filial = Create uo_Parametro_Filial
lo_Parametro_Filial.of_Localiza_Parametro("ID_BASE_PRODUCAO", ref ls_base_producao, False)
Destroy lo_Parametro_Filial

ls_arquivo_log = ls_caminho + 'LogMFD.txt'

Try
	Open(w_Janela_Aguarde)
	w_Janela_Aguarde.Wf_Mensagem("MFD Mensal. N$$HEX1$$c300$$ENDHEX$$O DESLIGUE o PDV/ECF.")	
	Yield( )
	
	dc_uo_zip lo_Zip
	lo_Zip = Create dc_uo_zip
	
	gvo_aplicacao.of_grava_log("Inicio grava$$HEX2$$e700e300$$ENDHEX$$o de arquivo Mensal ECF: " + String(pl_ecf) + ' uo_pdv - of_gera_espelho_mfd_mensal')		
	
	ll_filial   = gvo_parametro.cd_filial
	
	//Cria diretorio
	dc_uo_api lo_api
	lo_api = Create dc_uo_api
	lo_api.of_create_directory('C:\Sistemas\RL\Arquivos\MFD')
	lo_api.of_create_directory('C:\Sistemas\RL\Arquivos\MFD\Enviados')
	Destroy(lo_api)
	
	//Verifica se todos possui arquivos finalizados pendentes de envio e envia.
	If ls_base_producao <> 'N' Then	
		This.of_verifica_arquivos_pendentes('MFD')
	End If
	
	//Select Coalesce(dh_referencia_arquivo_mfd, '01/11/2016')
	Select dh_referencia_arquivo_mfd
	Into :ldt_data_referencia
	From Impressora_fiscal
		Where nr_ecf = :pl_ecf
	Using Sqlca;
	
	Choose Case SqlCa.SqlCode
		Case -1				
			gvo_aplicacao.of_grava_log("Erro na consulta da ECF "+SQLCa.SQLErrText)
			Sqlca.of_MsgDbError('Consulta ECF.')
			lb_Sucesso = False		
		Case 100		
			gvo_aplicacao.of_grava_log("N$$HEX1$$e300$$ENDHEX$$o encontrou Impressora Fiscal no cadastro ECF: " + String(pl_ecf) + ' uo_pdv - of_gera_espelho_mfd_mensal')		
			lb_Sucesso = False
		Case 0
			If IsNull(ldt_data_referencia) Then
				lb_null = True
				ldt_data_referencia = Date('01/11/2016')
			End If
			lb_Sucesso = True
	End Choose	
	
	If lb_sucesso Then
	
		ldt_data_cont = ldt_data_referencia	
		If not lb_null Then //J$$HEX1$$e100$$ENDHEX$$ foi gerado algum m$$HEX1$$ea00$$ENDHEX$$s, ent$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ preciso gerar do m$$HEX1$$ea00$$ENDHEX$$s referencia gravado + 1.
			ll_mes_ref = Month(ldt_data_cont)
			ll_ano_ref = Year(ldt_data_cont)
			If ll_mes_ref = 12 Then
				ll_mes_ref = 1
				ll_ano_ref = ll_ano_ref + 1
			Else
				ll_mes_ref = ll_mes_ref + 1
			End If		
			ldt_data_cont = Date('01/'+String(ll_mes_ref)+'/'+String(ll_ano_ref))		
		End If		
		//Ajuste do prazo final, o m$$HEX1$$ea00$$ENDHEX$$s final $$HEX1$$e900$$ENDHEX$$ o atual - 1.
		ll_mes_ref = Month(pdt_data_fiscal)
		ll_ano_ref = Year(pdt_data_fiscal)
		If ll_mes_ref = 1 Then
			ll_mes_ref = 12
			ll_ano_ref = ll_ano_ref - 1
		Else
			ll_mes_ref = ll_mes_ref - 1
		End If	
		ldt_fiscal_ref = Date('01/'+String(ll_mes_ref)+'/'+String(ll_ano_ref))	
		
		//FILIAL 24RHS, tenta fazer o processo em uma ECF por dia.
		select id_24horas
		into :ls_24h
		from filial
		where cd_filial = :gvo_Parametro.Cd_Filial
		Using Sqlca;
		
		If SqlCa.Sqlcode = -1 Then
			gvo_aplicacao.of_grava_log("Erro ao localizar a coluna id_24horas da tabela filial "+SQLCa.SQLErrText)
			Sqlca.of_MsgDbError('Consulta 24hrs.')
			Return False
		End If
		
		If Trim(Upper(ls_24h)) = 'S' Then	
			gvo_aplicacao.of_grava_log("Loja 24hrs, vai verificar se pode ser gerado para a ECF: " + String(pl_ecf) + ' uo_pdv - of_gera_espelho_mfd_mensal')					
			//Se exitir ECF menor que a atual sem ter feito o processamento mensal, sai da fun$$HEX2$$e700e300$$ENDHEX$$o.
			Select count(nr_ecf)
			Into :ll_ecf_24hr
			From Impressora_fiscal
				Where nr_ecf < :pl_ecf
				and dh_ultima_venda >= CAST(:pdt_data_fiscal AS TIMESTAMPTZ) - INTERVAL '60 DAYS'
				and Coalesce(dh_referencia_arquivo_mfd, '01/10/2016') < :ldt_data_cont
			Using Sqlca;
			
			Choose Case SqlCa.SqlCode
				Case -1				
					gvo_aplicacao.of_grava_log("Erro na consulta ultima ECF gerada 24rhs. "+SQLCa.SQLErrText)
					Sqlca.of_MsgDbError('Consulta ECF 24hrs.')
					Return False		
				Case 0
					If ll_ecf_24hr > 0 Then
						gvo_aplicacao.of_grava_log("Loja 24hrs, ainda n$$HEX1$$e300$$ENDHEX$$o poder ser gerado para ECF: " + String(pl_ecf) + ' uo_pdv - of_gera_espelho_mfd_mensal')											
						Return True
					Else
						gvo_aplicacao.of_grava_log("Loja 24hrs, vai gerar para ECF: " + String(pl_ecf) + ' uo_pdv - of_gera_espelho_mfd_mensal')																	
					End If
			End Choose			
		End If		
		// Fim 24hrs		
		
		Do While ldt_data_cont <= ldt_fiscal_ref			
			ldt_fim = gf_retorna_ultimo_dia_mes(DateTime(ldt_data_cont))
			
			ll_mes_ref = Month(ldt_data_cont)
			ll_ano_ref = Year(ldt_data_cont)
			
			ls_arquivo_ftp = String(gvo_parametro.cd_filial,'0000') +'_'+ String(pl_ecf,'00') + '_' + String(ll_ano_ref) + String(ll_mes_ref,'00')
			
			ls_arquivo = String(gvo_parametro.cd_filial,'0000') +'_'+ String(pl_ecf,'00') + '_' + String(ll_ano_ref) + String(ll_mes_ref,'00') + '.txt'
			ls_procura_log = String(gvo_parametro.cd_filial,'0000') +'_'+ String(pl_ecf,'00') + '_' + String(ll_ano_ref) + String(ll_mes_ref,'00')
			
			//Abre arquivo de log MFD
			If FileExists(ls_arquivo_log) Then
				ll_File_log = FileOpen(ls_arquivo_log, StreamMode!)			
				If ll_File_log = -1 Then
					gvo_aplicacao.of_grava_log("Erro ao abrir arquivo LOG MFD: " + ls_arquivo_log + ' uo_pdv - of_gera_espelho_mfd_mensal')						
					Return False
				End If
				//Procura periodo no arquivo log MFD, se estiver $$HEX1$$e900$$ENDHEX$$ que o arquivo j$$HEX1$$e100$$ENDHEX$$ foi criado, s$$HEX1$$f300$$ENDHEX$$ faltou a atualizacao na tabela
				FileRead(ll_File_log, ls_conteudo_log)			
				If PosA(ls_conteudo_log, 'OK ['+ ls_procura_log + ']') > 0 Then
					//Atualiza m$$HEX1$$ea00$$ENDHEX$$s
					Update impressora_fiscal
					Set dh_referencia_arquivo_mfd = :ldt_data_cont
					Where nr_ecf = :pl_ecf
					Using Sqlca;
					
					If Sqlca.Sqlcode <> 0 Then
						Sqlca.of_Rollback()
						gvo_aplicacao.of_grava_log("Erro na atualizaca$$HEX2$$e700e300$$ENDHEX$$o da ECF - of_gera_espelho_mfd_mensal - "+SQLCa.SQLErrText)			
						Sqlca.of_MsgDBError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o Dados ECF.")
						Return False
					Else
						Sqlca.of_Commit()
						gvo_aplicacao.of_grava_log("Sucesso na grava$$HEX2$$e700e300$$ENDHEX$$o de arquivo Mensal ECF por LOG: " + String(pl_ecf) + ' Per$$HEX1$$ed00$$ENDHEX$$odo: ' + ls_arquivo + ' uo_pdv - of_gera_espelho_mfd_mensal')									
					End If	
					
					If ll_mes_ref = 12 Then
						ll_mes_ref = 1
						ll_ano_ref = ll_ano_ref + 1
					Else
						ll_mes_ref = ll_mes_ref + 1
					End If
					ldt_data_cont = Date('01/'+String(ll_mes_ref)+'/'+String(ll_ano_ref))	
					FileClose(ll_File_log)
					Continue
				End If
				FileClose(ll_File_log)
			End If
			
			ll_File_log = FileOpen(ls_arquivo_log,linemode!,Write!,Shared!,Append!)			
			If ll_File_log = -1 Then
				gvo_aplicacao.of_grava_log("Erro ao gravar arquivo LOG MFD: " + ls_arquivo_log + ' uo_pdv - of_gera_espelho_mfd_mensal')						
				Return False
			End If
			
			//Verifica se possui vendas no per$$HEX1$$ed00$$ENDHEX$$odo.
			select count(cd_filial) as qtd_venda 
			into :ll_qtd_venda 
			from nf_venda where cd_filial = :ll_filial
				and dh_emissao >= :ldt_data_cont 
				and dh_emissao <= :ldt_fim
				and nr_ecf = :pl_ecf
			Using Sqlca;
			
			Choose Case SqlCa.SqlCode
				Case -1				
					gvo_aplicacao.of_grava_log("Erro na consulta de Notas "+SQLCa.SQLErrText)
					Sqlca.of_MsgDbError('Consulta Notas.')
					Return False
				Case 100		
					lb_sem_nota = True
				Case 0		
					If ll_qtd_venda <= 0 Then
						lb_sem_nota = True
					Else
						lb_sem_nota = False
					End If		
			End Choose	
			
			If lb_sem_nota Then
				//Gera arquivo "vazio"
				ll_File = FileOpen(ls_caminho + ls_arquivo,linemode!,Write!,Shared!,Replace!)			 
				If ll_File = -1 Then
					gvo_aplicacao.of_grava_log("Erro ao gravar arquivo sem movimenta$$HEX2$$e700e300$$ENDHEX$$o: " + ls_arquivo + ' uo_pdv - of_gera_espelho_mfd_mensal')						
					Return False
				End If			
				FileWrite(ll_File,"PERIODO SEM MOVIMENTO")			
				FileClose(ll_File)				
				gvo_aplicacao.of_grava_log("Grava$$HEX2$$e700e300$$ENDHEX$$o de arquivo Mensal ECF: " + String(pl_ecf) + ' Per$$HEX1$$ed00$$ENDHEX$$odo sem movimento: ' + ls_arquivo + ' uo_pdv - of_gera_espelho_mfd_mensal')					
				lb_sucesso = True
				FileWrite(ll_File_log,String(Today(), "dd/mm/yyyy hh:mm:ss") + ' OK ['+ ls_procura_log + ']')											
				FileClose(ll_File_log)				
			Else
				Sqlca.of_end_transaction()
				//Gera arquivo ECF
				lb_sucesso = This.of_leitura_memoria_fita_detalhe('1',String(ldt_data_cont,'ddmmyyyy'),String(ldt_fim,'ddmmyyyy'), ls_arquivo)
				//lb_sucesso = This.of_leitura_memoria_fita_detalhe('1',String(ldt_data_cont,'dd/mm/yyyy'),String(ldt_fim,'dd/mm/yyyy'))
	
				If not lb_sucesso Then
					gvo_aplicacao.of_grava_log("Erro na Grava$$HEX2$$e700e300$$ENDHEX$$o de arquivo Mensal ECF: " + String(pl_ecf) + ' Per$$HEX1$$ed00$$ENDHEX$$odo: ' + ls_arquivo + ' uo_pdv - of_gera_espelho_mfd_mensal')									
					Return False
				End If				
				FileWrite(ll_File_log,String(Today(), "dd/mm/yyyy hh:mm:ss") + ' OK ['+ ls_procura_log + ']')
				FileClose(ll_File_log)
			End If
			
			If lb_sucesso Then
				//Compacta arquivo Gerado.
				ls_erro = lo_zip.of_zip(ls_caminho + ls_arquivo,ls_caminho + ls_arquivo_ftp + '.zip')				
				If ls_Erro <> "" Then
					gvo_aplicacao.of_grava_log("Erro compactar arquivo: " + ls_arquivo + ' - ' +ls_Erro + ' uo_pdv - of_gera_espelho_mfd_mensal')											
					Return False
				Else
					FileDelete(ls_caminho + ls_arquivo)
				End If
				
				//Envia via FTP
				If ls_base_producao <> 'N' Then
					If Not This.of_envia_ftp_mfd(ls_caminho, ls_arquivo_ftp + '.zip', String( ldt_data_cont, 'YYYY' ), String( ldt_data_cont, 'MM' ), Ref ls_Msg, False) Then			
							gvo_aplicacao.of_grava_log(ls_msg + " - uo_pdv - of_gera_espelho_mfd_mensal")	
					Else
						FileMove(ls_caminho+ls_arquivo_ftp + '.zip', ls_caminho+'Enviados\'+ls_arquivo_ftp + '.zip')					
					End If
				Else
					FileMove(ls_caminho+ls_arquivo_ftp + '.zip', ls_caminho+'Enviados\'+ls_arquivo_ftp + '.zip')										
				End If
				
				//Atualiza m$$HEX1$$ea00$$ENDHEX$$s
				Update impressora_fiscal
				Set dh_referencia_arquivo_mfd = :ldt_data_cont
				Where nr_ecf = :pl_ecf
				Using Sqlca;
				
				If Sqlca.Sqlcode <> 0 Then
					Sqlca.of_Rollback()
					gvo_aplicacao.of_grava_log("Erro na atualizaca$$HEX2$$e700e300$$ENDHEX$$o da ECF - of_gera_espelho_mfd_mensal - "+SQLCa.SQLErrText)
					Sqlca.of_MsgDBError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o Dados ECF.")
					Return False
				Else
					Sqlca.of_Commit()
					gvo_aplicacao.of_grava_log("Sucesso na grava$$HEX2$$e700e300$$ENDHEX$$o de arquivo Mensal ECF: " + String(pl_ecf) + ' Per$$HEX1$$ed00$$ENDHEX$$odo: ' + ls_arquivo + ' uo_pdv - of_gera_espelho_mfd_mensal')									
				End If		
			End If
		
			If ll_mes_ref = 12 Then
				ll_mes_ref = 1
				ll_ano_ref = ll_ano_ref + 1
			Else
				ll_mes_ref = ll_mes_ref + 1
			End If
			ldt_data_cont = Date('01/'+String(ll_mes_ref)+'/'+String(ll_ano_ref))		
		Loop
		
		gvo_aplicacao.of_grava_log("T$$HEX1$$e900$$ENDHEX$$rmino da grava$$HEX2$$e700e300$$ENDHEX$$o de arquivo Mensal ECF: " + String(pl_ecf) + ' uo_pdv - of_gera_espelho_mfd_mensal')
		Return True
	Else
		Return False
	End If
Finally
	Close(w_Janela_Aguarde)
	FileClose(ll_File_log)
	FileClose(ll_File)
	Destroy(lo_zip)
End Try
end function

public function boolean of_leitura_memoria_fita_detalhe (string ps_tipo, string ps_inicio, string ps_final, string ps_arquivo);Choose Case This.Fabricante 
	Case "Bematech"
		Return ivo_Bematech.of_leitura_memoria_fita_detalhe(ps_tipo,ps_inicio,ps_final,ps_arquivo)
	Case "Daruma"
		Return ivo_Daruma.of_leitura_memoria_fita_detalhe(ps_tipo,ps_inicio,ps_final,ps_arquivo)
	Case "Epson"
		Return ivo_Epson.of_leitura_memoria_fita_detalhe(ps_tipo,ps_inicio,ps_final,ps_arquivo)		
	Case Else	
		Return ivo_Sweda.of_leitura_memoria_fita_detalhe(ps_tipo,ps_inicio,ps_final,ps_arquivo)
End Choose

end function

public function boolean of_gera_arquivo_mfd (string ps_tipo, string ps_inicio, string ps_final, string ps_endereco, string ps_origem, long pl_tipo_geracao, ref string ps_caminho_mfd);Choose Case This.Fabricante 
	Case "Bematech"
		Return ivo_Bematech.of_gera_arquivo_mfd(ps_tipo,ps_inicio,ps_final,ps_endereco,ps_origem,pl_tipo_geracao, Ref ps_caminho_MFD)
	Case "Daruma"
		Return False
	Case "Epson"
		Return ivo_Epson.of_gera_arquivo_mfd(ps_tipo,ps_inicio,ps_final,ps_endereco,ps_origem,pl_tipo_geracao, Ref ps_caminho_MFD)
	Case Else	
		Return ivo_Sweda.of_gera_arquivo_mfd(ps_tipo,ps_inicio,ps_final,ps_endereco,ps_origem,pl_tipo_geracao, Ref ps_caminho_MFD)
End Choose

end function

public function boolean of_gera_cotepe_mensal (long pl_ecf, date pdt_data_fiscal);Boolean 	lb_Sucesso = False, &
			lb_sem_nota, &
			lb_null, &
			lb_gerarMFD = True, &
			lb_gerado_MFD = False
Date 	ldt_data_referencia, &
		ldt_fiscal_ref, &
		ldt_data_cont, &
		ldt_fim
Long 	ll_mes_ref, &
		ll_ano_ref, &
		ll_qtd_venda, &
		ll_filial, &
		ll_file, &
		ll_file_log

String	ls_arquivo, &
		ls_caminho = 'c:\sistemas\rl\arquivos\mfd\cotepe\', &
		ls_caminho_mfd = 'c:\sistemas\rl\arquivos\mfd\', &
		ls_arquivo_log, &
		ls_procura_log, &
		ls_conteudo_log, &
		ls_erro, &
		ls_arquivo_ftp, &
		ls_msg, &
		ls_base_producao, &
		ls_gera_cotepe, &
		ls_inicio_cotepe
		
If pl_ecf <= 0 Then
	PDV.of_nr_ecf(Ref pl_ecf)
End If

uo_Parametro_Filial lo_Parametro_Filial
lo_Parametro_Filial = Create uo_Parametro_Filial
lo_Parametro_Filial.of_Localiza_Parametro("ID_BASE_PRODUCAO", ref ls_base_producao, False)
lo_Parametro_Filial.of_Localiza_Parametro("ID_GERA_COTEPE_MENSAL", ref ls_gera_cotepe, False)
lo_Parametro_Filial.of_Localiza_Parametro("DT_INICIO_COTEPE", ref ls_inicio_cotepe, False)
Destroy lo_Parametro_Filial

If Upper(Trim(ls_gera_cotepe)) <> 'S' Then Return True

If Upper(Trim(ls_inicio_cotepe)) = '' Or Isnull(ls_inicio_cotepe) Then Return True

If IsDate(ls_inicio_cotepe) Then
	ldt_data_referencia = Date(ls_inicio_cotepe)
	lb_sucesso = True
Else
	Return True
	gvo_aplicacao.of_grava_log('Param$$HEX1$$ea00$$ENDHEX$$tro de Data inicio n$$HEX1$$e300$$ENDHEX$$o definida.' + ' uo_pdv - of_gera_cotepe_mensal')		
End If

ls_arquivo_log = ls_caminho + 'LogCOTEPE.txt'

Try
	Open(w_Janela_Aguarde)
	w_Janela_Aguarde.Wf_Mensagem("Gerando COTEPE Mensal. N$$HEX1$$c300$$ENDHEX$$O DESLIGUE o PDV/ECF.")	
	Yield( )
	
	dc_uo_zip lo_Zip
	lo_Zip = Create dc_uo_zip
	
	uo_Menu_Fiscal lo_Menu
	lo_Menu = Create uo_Menu_Fiscal
	
	gvo_aplicacao.of_grava_log("Inicio grava$$HEX2$$e700e300$$ENDHEX$$o de arquivo Mensal COTEPE: " + String(pl_ecf) + ' uo_pdv - of_gera_cotepe_mensal')		
	
	ll_filial   = gvo_parametro.cd_filial
	
	//Cria diretorio
	dc_uo_api lo_api
	lo_api = Create dc_uo_api
	lo_api.of_create_directory('C:\Sistemas\RL\Arquivos\MFD')
	lo_api.of_create_directory('C:\Sistemas\RL\Arquivos\MFD\Cotepe')
	lo_api.of_create_directory('C:\Sistemas\RL\Arquivos\MFD\Cotepe\Enviados')	
	Destroy(lo_api)
	
	//Verifica se todos possui arquivos finalizados pendentes de envio e envia.
	If ls_base_producao <> 'N' Then	
		This.of_verifica_arquivos_pendentes('COTEPE')
	End If	

	lb_null = True
	
	If lb_sucesso Then	
		
		If Not PDV.of_Numero_Serie() Then 			
			gvo_aplicacao.of_grava_log("N$$HEX1$$e300$$ENDHEX$$o conseguiu carregar n. serie ECF: " + String(pl_ecf) + ' uo_pdv - of_gera_cotepe_mensal')			
			Return True	
		Else
			If This.Fabricante = "Daruma" Then
				This.nr_serie = ivo_Daruma.nr_serie_mfd
			End If
		End If
	
		ldt_data_cont = ldt_data_referencia	
		If not lb_null Then //J$$HEX1$$e100$$ENDHEX$$ foi gerado algum m$$HEX1$$ea00$$ENDHEX$$s, ent$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ preciso gerar do m$$HEX1$$ea00$$ENDHEX$$s referencia gravado + 1.
			ll_mes_ref = Month(ldt_data_cont)
			ll_ano_ref = Year(ldt_data_cont)
			If ll_mes_ref = 12 Then
				ll_mes_ref = 1
				ll_ano_ref = ll_ano_ref + 1
			Else
				ll_mes_ref = ll_mes_ref + 1
			End If		
			ldt_data_cont = Date('01/'+String(ll_mes_ref)+'/'+String(ll_ano_ref))		
		End If		
		//Ajuste do prazo final, o m$$HEX1$$ea00$$ENDHEX$$s final $$HEX1$$e900$$ENDHEX$$ o atual - 1.
		ll_mes_ref = Month(pdt_data_fiscal)
		ll_ano_ref = Year(pdt_data_fiscal)
		If ll_mes_ref = 1 Then
			ll_mes_ref = 12
			ll_ano_ref = ll_ano_ref - 1
		Else
			ll_mes_ref = ll_mes_ref - 1
		End If	
		ldt_fiscal_ref = Date('01/'+String(ll_mes_ref)+'/'+String(ll_ano_ref))	
		
		//FILIAL 24RHS, como para este processo n$$HEX1$$e300$$ENDHEX$$o tem campos no banco de dados para controle, ser$$HEX1$$e100$$ENDHEX$$ feito por aviso as lojas.
		
		Do While ldt_data_cont <= ldt_fiscal_ref			
			ldt_fim = gf_retorna_ultimo_dia_mes(DateTime(ldt_data_cont))
			
			ll_mes_ref = Month(ldt_data_cont)
			ll_ano_ref = Year(ldt_data_cont)
			
			ls_arquivo_ftp = String(gvo_parametro.cd_filial,'0000') +'_'+ String(pl_ecf,'00') + '_' + String(ll_ano_ref) + String(ll_mes_ref,'00')
			
			//ls_arquivo = String(gvo_parametro.cd_filial,'0000') +'_'+ String(pl_ecf,'00') + '_' + String(ll_ano_ref) + String(ll_mes_ref,'00') + '.txt'
			ls_arquivo = 'MFD' + PDV.nr_serie + '_' + String(Today(), "yyyymmdd") + '_' + String(Now(), "hhmmss") + '.txt'
			ls_procura_log = String(gvo_parametro.cd_filial,'0000') +'_'+ String(pl_ecf,'00') + '_' + String(ll_ano_ref) + String(ll_mes_ref,'00')
			
			//Abre arquivo de log MFD
			If FileExists(ls_arquivo_log) Then
				ll_File_log = FileOpen(ls_arquivo_log, StreamMode!)			
				If ll_File_log = -1 Then
					gvo_aplicacao.of_grava_log("Erro ao abrir arquivo LOG Cotepe: " + ls_arquivo_log + ' uo_pdv - of_gera_cotepe_mensal')						
					Return False
				End If
				//Procura periodo no arquivo log MFD, se estiver $$HEX1$$e900$$ENDHEX$$ que o arquivo j$$HEX1$$e100$$ENDHEX$$ foi criado, s$$HEX1$$f300$$ENDHEX$$ faltou a atualizacao na tabela
				FileRead(ll_File_log, ls_conteudo_log)			
				If PosA(ls_conteudo_log, 'OK ['+ ls_procura_log + ']') > 0 Then					
					If ll_mes_ref = 12 Then
						ll_mes_ref = 1
						ll_ano_ref = ll_ano_ref + 1
					Else
						ll_mes_ref = ll_mes_ref + 1
					End If
					ldt_data_cont = Date('01/'+String(ll_mes_ref)+'/'+String(ll_ano_ref))	
					FileClose(ll_File_log)
					Continue
				End If
				FileClose(ll_File_log)
			End If
			
			ll_File_log = FileOpen(ls_arquivo_log,linemode!,Write!,Shared!,Append!)			
			If ll_File_log = -1 Then
				gvo_aplicacao.of_grava_log("Erro ao gravar arquivo LOG Cotepe: " + ls_arquivo_log + ' uo_pdv - of_gera_cotepe_mensal')						
				Return False
			End If
			
			//Verifica se possui vendas no per$$HEX1$$ed00$$ENDHEX$$odo.
			select count(cd_filial) as qtd_venda 
			into :ll_qtd_venda 
			from nf_venda where cd_filial = :ll_filial
				and dh_emissao >= :ldt_data_cont 
				and dh_emissao <= :ldt_fim
				and nr_ecf = :pl_ecf
			Using Sqlca;
			
			Choose Case SqlCa.SqlCode
				Case -1				
					gvo_aplicacao.of_grava_log("Erro na consulta de Notas geracao Cotepe"+SQLCa.SQLErrText)
					Sqlca.of_MsgDbError('Consulta Notas - Cotepe.')
					Return False
				Case 100		
					lb_sem_nota = True
				Case 0		
					If ll_qtd_venda <= 0 Then
						lb_sem_nota = True
					Else
						lb_sem_nota = False
					End If		
			End Choose	
			
			If lb_sem_nota Then
				//Gera arquivo "vazio"
				ll_File = FileOpen(ls_caminho + ls_arquivo,linemode!,Write!,Shared!,Replace!)			 
				If ll_File = -1 Then
					gvo_aplicacao.of_grava_log("Erro ao gravar arquivo sem movimenta$$HEX2$$e700e300$$ENDHEX$$o: " + ls_arquivo + ' uo_pdv - of_gera_cotepe_mensal')						
					Return False
				End If			
				FileWrite(ll_File,"PERIODO SEM MOVIMENTO")			
				FileClose(ll_File)				
				gvo_aplicacao.of_grava_log("Grava$$HEX2$$e700e300$$ENDHEX$$o de arquivo Cotepe Mensal ECF: " + String(pl_ecf) + ' Per$$HEX1$$ed00$$ENDHEX$$odo sem movimento: ' + ls_arquivo + ' uo_pdv - of_gera_cotepe_mensal')					
				lb_sucesso = True
				FileWrite(ll_File_log,String(Today(), "dd/mm/yyyy hh:mm:ss") + ' OK ['+ ls_procura_log + ']')											
				FileClose(ll_File_log)				
			Else
				Sqlca.of_end_transaction()
				//Gera arquivo ECF cotepe
				gvo_aplicacao.of_grava_log("Vai iniciar grava$$HEX2$$e700e300$$ENDHEX$$o no ECF Cotepe Mensal - uo_pdv - of_gera_cotepe_mensal")				
				
				Choose Case This.Fabricante 
					Case "Bematech"
						lb_sucesso = ivo_Bematech.of_gera_arquivo_cotepe_mensal('D',String(ldt_data_cont,'ddmmyyyy'),String(ldt_fim,'ddmmyyyy'),ls_caminho + ls_arquivo,'',1, ls_caminho_mfd, lb_gerarMFD, Ref lb_gerado_MFD)
					Case "Daruma"
						lb_sucesso = ivo_Daruma.of_gera_arquivo_cotepe_mensal('D',String(ldt_data_cont,'ddmmyyyy'),String(ldt_fim,'ddmmyyyy'),ls_caminho + ls_arquivo,'',1, ls_caminho_mfd, lb_gerarMFD, Ref lb_gerado_MFD, String(ldt_data_referencia, "ddmmyyyy"), String(pdt_data_fiscal, "ddmmyyyy"))
					Case "Epson"
						lb_sucesso = ivo_Epson.of_gera_arquivo_cotepe_mensal('D',String(ldt_data_cont,'ddmmyyyy'),String(ldt_fim,'ddmmyyyy'),ls_caminho + ls_arquivo,'',1, ls_caminho_mfd, lb_gerarMFD, Ref lb_gerado_MFD)
					Case Else	
						lb_sucesso = ivo_Sweda.of_gera_arquivo_cotepe_mensal('D',String(ldt_data_cont,'ddmmyyyy'),String(ldt_fim,'ddmmyyyy'),ls_caminho + ls_arquivo,'',1, ls_caminho_mfd, lb_gerarMFD, Ref lb_gerado_MFD)
				End Choose
				
				//lb_sucesso = This.of_leitura_memoria_fita_detalhe('1',String(ldt_data_cont,'ddmmyyyy'),String(ldt_fim,'ddmmyyyy'), ls_arquivo)	
				If not lb_sucesso Then
					gvo_aplicacao.of_grava_log("Erro na Grava$$HEX2$$e700e300$$ENDHEX$$o de arquivo Mensal ECF: " + String(pl_ecf) + ' Per$$HEX1$$ed00$$ENDHEX$$odo: ' + ls_arquivo + ' uo_pdv - of_gera_cotepe_mensal')									
					Return False
				End If	
				gvo_aplicacao.of_grava_log("Terminou grava$$HEX2$$e700e300$$ENDHEX$$o Cotepe Mensal no ECF, vai assinar o arquivo. - uo_pdv - of_gera_cotepe_mensal")								
				//Inclui assinatura digital no arquivo gerado pela dll do ECF
				Choose Case PDV.Fabricante
					Case "Bematech"
						//A dll j$$HEX1$$e100$$ENDHEX$$ inclui a chave no arquivo
					Case "Daruma"
						lo_Menu.of_Assinatura_Digital(ls_caminho + ls_arquivo)										
					Case "Epson"				
						lo_Menu.of_Assinatura_Digital(ls_caminho + ls_arquivo)				
					Case Else
						lo_Menu.of_Assinatura_Digital(ls_caminho + ls_arquivo)
				End Choose			
				
				FileWrite(ll_File_log,String(Today(), "dd/mm/yyyy hh:mm:ss") + ' OK ['+ ls_procura_log + ']')
				FileClose(ll_File_log)
			End If
			gvo_aplicacao.of_grava_log("Arquivo Cotepe Assinado, vai compactar e enviar FTP. - uo_pdv - of_gera_cotepe_mensal")								
			If lb_sucesso Then
				If lb_gerado_MFD Then
					lb_gerarMFD = False
				End If
				//Compacta arquivo Gerado.
				ls_erro = lo_zip.of_zip(ls_caminho + ls_arquivo,ls_caminho + ls_arquivo_ftp + '.zip')				
				If ls_Erro <> "" Then
					gvo_aplicacao.of_grava_log("Erro compactar arquivo: " + ls_arquivo + ' - ' +ls_Erro + ' uo_pdv - of_gera_cotepe_mensal')											
					Return False
				Else
					FileDelete(ls_caminho + ls_arquivo)
				End If
				
				//Envia via FTP
				If ls_base_producao <> 'N' Then
					If Not This.of_envia_ftp_mfd(ls_caminho, ls_arquivo_ftp + '.zip', String( ldt_data_cont, 'YYYY' ), String( ldt_data_cont, 'MM' ), Ref ls_Msg, True) Then			
							gvo_aplicacao.of_grava_log(ls_msg + " - uo_pdv - of_gera_espelho_mfd_mensal")	
					Else
						FileMove(ls_caminho+ls_arquivo_ftp + '.zip', ls_caminho+'Enviados\'+ls_arquivo_ftp + '.zip')					
					End If
				Else
					FileMove(ls_caminho+ls_arquivo_ftp + '.zip', ls_caminho+'Enviados\'+ls_arquivo_ftp + '.zip')										
				End If

			End If
		
			If ll_mes_ref = 12 Then
				ll_mes_ref = 1
				ll_ano_ref = ll_ano_ref + 1
			Else
				ll_mes_ref = ll_mes_ref + 1
			End If
			ldt_data_cont = Date('01/'+String(ll_mes_ref)+'/'+String(ll_ano_ref))		
		Loop
		
		gvo_aplicacao.of_grava_log("T$$HEX1$$e900$$ENDHEX$$rmino da grava$$HEX2$$e700e300$$ENDHEX$$o de arquivo Mensal ECF: " + String(pl_ecf) + ' uo_pdv - of_gera_cotepe_mensal')
		Return True
	Else
		Return False
	End If
Finally
	Close(w_Janela_Aguarde)
	FileClose(ll_File_log)
	FileClose(ll_File)
	Destroy(lo_zip)
	Destroy(lo_menu)
End Try
end function

public function boolean of_envia_ftp_mfd (string ps_caminho, string ps_arquivo, string ps_ano, string ps_mes, ref string ps_msg_ftp, boolean pb_cotepe);String ls_Msg, &
		ls_ip_ftp = '10.0.4.30', &
		ls_usuario_ftp = 'caixafilial', &
		ls_acesso_ftp = 'Spum@qa8res#', &
		ls_info_ftp = 'LEITURA_MFD', &
		ls_caminho_ftp = 'MFD/'

Boolean lb_sucesso

dc_uo_ftp lo_Ftp
lo_Ftp = Create dc_uo_ftp
lo_Ftp.of_DesConecta_Ftp()

If pb_cotepe Then
	ls_caminho_ftp = ls_caminho_ftp + 'COTEPE/'
End If

Try
	ls_caminho_ftp = ls_caminho_ftp + String( gvo_Parametro.Cd_Filial, '0000' ) + '/' + ps_ano + '/' + ps_mes
	
	//FTP para MATRIZ				
	If lo_Ftp.of_Conecta_Ftp( ls_info_ftp, ls_ip_ftp, ls_usuario_ftp, ls_acesso_ftp, Ref ls_Msg ) Then			
		
		lb_Sucesso = lo_Ftp.of_Ftp_Set_Dir( "/", ref ls_Msg) > 0
	
		If lo_Ftp.of_Ftp_Set_Dir( "/" + ls_Caminho_ftp, ref ls_Msg) <= 0 Then
			/* Tentar criar a estrutura necess$$HEX1$$e100$$ENDHEX$$rio no FTP */
			lo_Ftp.of_Ftp_Cria_Dir( 'MFD', Ref ls_Msg )
			If pb_cotepe Then
				lo_Ftp.of_Ftp_Cria_Dir( 'MFD/COTEPE', Ref ls_Msg )
				lo_Ftp.of_Ftp_Cria_Dir( 'MFD/COTEPE/'+String( gvo_Parametro.Cd_Filial, '0000' ), Ref ls_Msg )						
				lo_Ftp.of_Ftp_Cria_Dir( 'MFD/COTEPE/'+String( gvo_Parametro.Cd_Filial, '0000' ) + '/' + ps_ano, Ref ls_Msg )				
			Else
				lo_Ftp.of_Ftp_Cria_Dir( 'MFD/'+String( gvo_Parametro.Cd_Filial, '0000' ), Ref ls_Msg )						
				lo_Ftp.of_Ftp_Cria_Dir( 'MFD/'+String( gvo_Parametro.Cd_Filial, '0000' ) + '/' + ps_ano, Ref ls_Msg )
			End If
			lo_Ftp.of_Ftp_Cria_Dir( ls_Caminho_ftp, Ref ls_Msg )
			/******/
			lb_Sucesso = lo_Ftp.of_Ftp_Set_Dir( "/", ref ls_Msg) > 0
			
			lb_Sucesso = lo_Ftp.of_Ftp_Set_Dir( "/" + ls_Caminho_ftp , ref ls_Msg) > 0
		End If
		
		If lb_Sucesso Then
			lb_sucesso = lo_Ftp.of_Ftp_PutFile( ps_caminho+ps_arquivo, ps_arquivo, Ref ls_Msg )		
		End If	

	Else
		ls_Msg = "Erro na conex$$HEX1$$e300$$ENDHEX$$o com o servidor '" + ls_ip_ftp + "'."
		lb_Sucesso = False
	End If			

Catch( Exception e )
	ls_Msg = e.GetMessage()
	lb_Sucesso = False
	
Finally
	lo_Ftp.of_DesConecta_Ftp()	
	Destroy(lo_ftp)
	ps_msg_ftp = ls_Msg
	Return lb_Sucesso	
End Try
end function

public function boolean of_verifica_arquivos_pendentes (string ps_tipo);//Verifica arquivos que n$$HEX1$$e300$$ENDHEX$$o foram enviados ao FTP e faz o envio
String ls_Arquivos[]
String ls_arquivo
String ls_temp
String ls_msg
String ls_caminho
String ls_ano
String ls_mes
Long ll_Arquivo

If ps_tipo = 'MFD' Then
	ls_caminho = 'c:\sistemas\rl\arquivos\mfd\'	
Else
	ls_caminho = 'c:\sistemas\rl\arquivos\mfd\Cotepe\'
End If
	
gf_dir_list( ls_caminho, '*.zip', 0+1, Ref ls_Arquivos )

If UpperBound( ls_Arquivos ) = 0 Then Return True	

For ll_Arquivo = 1 To UpperBound( ls_Arquivos )
	 ls_Arquivo = ls_Arquivos[ll_Arquivo]
	 
	 If LenA(ls_Arquivo) <> 18 Then //se o tamanho do nome do arquivo for outro n$$HEX1$$e300$$ENDHEX$$o envia.
		Continue
	Else
		ls_temp = Trim(MidA(ls_Arquivo, 1, PosA(ls_Arquivo,'.')-1))				
		ls_temp = RightA(ls_temp, 6)
		ls_ano = LeftA(ls_temp,4)
		ls_mes = RightA(ls_temp,2)	
	
		If This.of_envia_ftp_mfd(ls_caminho, ls_arquivo, ls_ano, ls_mes, Ref ls_msg, False) Then //Move arquivo para pasta enviadas.
			If FileExists(ls_caminho+'enviados\'+ls_arquivo) Then
				FileDelete(ls_caminho+'enviados\'+ls_arquivo)
			End If
			FileMove(ls_caminho+ls_arquivo, ls_caminho+'enviados\'+ls_arquivo)
		End If				
		
	End If		 
Next

Return True
end function

public function boolean of_subtotal_cupom (ref string ps_subtotal);If This.ivb_Modo_Teste Then Return True

Choose Case This.Fabricante 
	Case "Bematech"
		Return ivo_bematech.of_subtotal_cupom(Ref ps_subtotal)
		
	Case "Daruma"
		Return ivo_daruma.of_subtotal_cupom(Ref ps_subtotal)
		
	Case "Epson"
		Return ivo_epson.of_subtotal_cupom(Ref ps_subtotal)
		
	Case "NFCE", "SAT"
		Return True							
		
	Case Else	
		Return ivo_sweda.of_subtotal_cupom(Ref ps_subtotal)		
End Choose

end function

public function boolean of_gera_arquivos_ecf (string ps_tipo, string ps_inicio, string ps_final, string ps_endereco, string ps_origem, long pl_espelhos, long pl_tipo_geracao, string ps_caminho_mfd, ref string ps_arquivo_gerado);Choose Case This.Fabricante 
	Case "Bematech"
		Return ivo_Bematech.of_gera_arquivos_ecf(ps_tipo,ps_inicio,ps_final,ps_endereco,'',pl_espelhos,pl_tipo_geracao, ps_caminho_mfd, Ref ps_arquivo_gerado)
	Case "Daruma"
		Return ivo_Daruma.of_gera_arquivos_ecf(ps_tipo,ps_inicio,ps_final,ps_endereco,'',pl_espelhos,pl_tipo_geracao, ps_caminho_mfd, Ref ps_arquivo_gerado)
	Case "Epson"
		Return ivo_Epson.of_gera_arquivos_ecf(ps_tipo,ps_inicio,ps_final,ps_endereco,'',pl_espelhos,pl_tipo_geracao, ps_caminho_mfd, Ref ps_arquivo_gerado)
	Case Else	
		Return ivo_sweda.of_gera_arquivos_ecf(ps_tipo,ps_inicio,ps_final,ps_endereco,'',pl_espelhos,pl_tipo_geracao, ps_caminho_mfd, Ref ps_arquivo_gerado)
End Choose
end function

public function boolean of_verifica_venda_exame (string ps_tipo, string ps_tipo_cupom, long pl_ecf, long pl_nota_cupom, string ps_especie, string ps_serie);DateTime lvdh_Data
String ls_permite
Long ll_nota

uo_Parametro_Filial lo_Parametro_Filial
lo_Parametro_Filial = Create uo_Parametro_Filial
lo_Parametro_Filial.of_Localiza_Parametro("ID_PERMITE_DEV_CANC_EXAME", ref ls_permite, False)
Destroy lo_Parametro_Filial

If ls_permite = 'S' Then Return True

If ps_tipo = 'CF' Then
	lvdh_Data = This.of_dh_movimentacao()	
	
	If ps_tipo_cupom = 'COO' Then
		select count(*) as notas
		into :ll_nota
		from nf_venda v		
		inner join nf_venda_exame e
			on e.cd_filial = v.cd_filial
			and e.nr_nf = v.nr_nf
			and e.de_especie = v.de_especie
			and e.de_serie = v.de_serie
		where v.nr_ecf                     = :pl_ecf
			and v.nr_operacao_ecf            = :pl_nota_cupom
			and dh_movimentacao_caixa      = :lvdh_data
		Using SqlCa;		
	Else
		select count(*) as notas
		into :ll_nota
		from nf_venda v
		inner join nf_venda_exame e
			on e.cd_filial = v.cd_filial
			and e.nr_nf = v.nr_nf
			and e.de_especie = v.de_especie
			and e.de_serie = v.de_serie
		where v.nr_ecf                     = :pl_ecf
			and v.nr_ccf            = :pl_nota_cupom
			and dh_movimentacao_caixa      = :lvdh_data
		Using SqlCa;
	End If
Else
	select count(*) as notas
	into :ll_nota
	from nf_venda v
	inner join nf_venda_exame e
		on e.cd_filial = v.cd_filial
		and e.nr_nf = v.nr_nf
		and e.de_especie = v.de_especie
		and e.de_serie = v.de_serie
	where v.cd_filial                     = :gvo_Parametro.Cd_Filial
		and v.nr_nf           = :pl_nota_cupom
		and v.de_especie      = :ps_especie
		and v.de_serie = :ps_serie
	Using SqlCa;
End If

Choose Case SqlCa.SqlCode
	Case 0
		If Not IsNull(ll_nota) And ll_nota > 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitido o cancelamento da venda(Venda Exame).",Exclamation!)
			Return False
		End If
	Case 100
		Return True
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o da venda exame." + SqlCa.SqlErrText, StopSign!)
		Return False
End Choose
end function

public function boolean of_totais_nfce (decimal pd_total_bc, decimal pd_total_icms, decimal pd_total_bcst, decimal pd_total_st, decimal pd_total_produtos, decimal pd_total_frete, decimal pd_total_seg, decimal pd_total_desc, decimal pd_total_ii, decimal pd_total_ipi, decimal pd_total_pis, decimal pd_total_cofins, decimal pd_total_outros, decimal pd_total_nf, decimal pd_total_tributos, string ps_mod_frete, string ps_formas_pgto[], decimal ps_valores_pgto[], decimal pd_troco, ref string ps_chave_nota, string ps_observacao, string ps_dados_tef[], string ps_envia_responsavel, decimal ps_total_icms_desonerado, string ps_inf_adicional, string ps_inf_fisco, string ps_cnpj_intermediario, string ps_codigo_interm);If This.ivb_Modo_Teste Then Return True

Choose Case This.Fabricante 
	Case "NFCE"
		Return ivo_NFCE.of_totais_nfce(pd_total_bc, pd_total_icms, pd_total_bcst, pd_total_st, &
												 pd_total_produtos, pd_total_frete, pd_total_seg, pd_total_desc, &
												 pd_total_ii, pd_total_ipi, pd_total_pis, pd_total_cofins, pd_total_outros, &
												 pd_total_nf, pd_total_tributos, ps_mod_frete, ps_formas_pgto[], &
												 ps_valores_pgto[], pd_troco, Ref ps_chave_nota, ps_dados_tef[], &
												 ps_envia_responsavel, ps_total_icms_desonerado, ps_inf_adicional, ps_inf_fisco,ps_cnpj_intermediario,ps_codigo_interm)
		
	Case "SAT"
		Return ivo_SAT.of_totais_sat(pd_total_bc, pd_total_icms, pd_total_bcst, pd_total_st, pd_total_produtos, &
											  pd_total_frete, pd_total_seg, pd_total_desc, pd_total_ii, pd_total_ipi, &
											  pd_total_pis, pd_total_cofins, pd_total_outros, pd_total_nf, pd_total_tributos, &
											  ps_mod_frete, ps_formas_pgto[], ps_valores_pgto[], pd_troco, Ref ps_chave_nota, ps_observacao)
		
End Choose

Return False;
end function

public function boolean of_cabecalho_nfce (string ps_nr_nf, string ps_forma_pagamento, string ps_natureza_operacao, datetime pdt_emissao, string ps_tipo_impressao, string ps_forma_emissao, string ps_finalidade, string ps_consumidor, string ps_ind_presenca, string ps_intermediador, string ps_cpf_transp, string ps_cnpj_transp, string ps_nome_transp, string ps_end_transp, string ps_cidade_transp, string ps_uf_transp);If This.ivb_Modo_Teste Then Return True

Choose Case This.Fabricante 
	Case "NFCE"
		Return ivo_NFCE.of_cabecalho_nfce(ps_nr_nf, ps_forma_pagamento, ps_natureza_operacao, pdt_emissao, ps_tipo_impressao, ps_forma_emissao, &
														ps_finalidade, ps_consumidor, ps_ind_presenca, ps_intermediador, ps_cpf_transp, ps_cnpj_transp, ps_nome_transp, &
														ps_end_transp, ps_cidade_transp, ps_uf_transp)
		
	Case "SAT"
		Return ivo_SAT.of_cabecalho_sat(ps_nr_nf, ps_forma_pagamento, ps_natureza_operacao, pdt_emissao, ps_tipo_impressao, ps_forma_emissao, &
													ps_finalidade, ps_consumidor, ps_ind_presenca)		
		
End Choose

end function

public function boolean of_registra_item_nfce (long pl_item, string ps_produto, long pd_qtd, decimal pd_precounitario, decimal pd_precototal, string ps_descricao, decimal pd_aliquota, string ps_complemento, string ps_cst_tributacao_icms, string ps_un, long pl_classificacao_fiscal, long pl_natureza_operacao, decimal pd_valor_desconto, decimal pd_valor_imposto, string ps_icms_origem, string ps_pis_cofins, decimal pd_preco_praticado, ref decimal pd_valor_icms, ref decimal pd_valor_base_icms, string ps_cest, string ps_tributacao_icms_cadastro, string ps_codigo_barras, decimal pd_red_bc_icms_efe, decimal pd_bc_icms_efe, decimal pd_icms_efe, decimal pd_valor_icms_efe, string ps_beneficio, integer pi_nr_item, decimal pd_vl_icms_desonerado, string ps_id_motivo_desoneracao, string ps_codigo_sap, string ps_cst_pis_cofins);If This.ivb_Modo_Teste Then Return True

String ls_nulo
SetNull(ls_nulo)

Choose Case This.Fabricante 
	Case "NFCE"
		Return ivo_NFCE.of_registra_Item_nfce( pl_item, ps_produto, ps_codigo_barras, ps_descricao, pl_classificacao_fiscal, pl_natureza_operacao, ps_un, pd_qtd,  pd_precounitario, '0', &
															pd_valor_desconto,0, pd_valor_imposto, ps_icms_origem, ps_cst_tributacao_icms, pd_aliquota, ps_pis_cofins, ls_nulo, pd_preco_praticado, &
															Ref pd_valor_icms, Ref pd_valor_base_icms, ps_CEST, ps_tributacao_icms_cadastro, pd_red_bc_icms_efe, pd_bc_icms_efe,pd_icms_efe, pd_valor_icms_efe,&
															ps_beneficio, pi_nr_item, pd_vl_icms_desonerado, ps_id_motivo_desoneracao, ps_codigo_sap, ps_CST_Pis_Cofins ) 
		
	Case "SAT"
		Return ivo_SAT.of_registra_Item_sat( pl_item, ps_produto, ls_nulo, ps_descricao, pl_classificacao_fiscal, pl_natureza_operacao, ps_un, pd_qtd, pd_precounitario, '0', &
														 pd_valor_desconto,0, pd_valor_imposto, ps_icms_origem, ps_cst_tributacao_icms, pd_aliquota, ps_pis_cofins, ls_nulo, &
														 pd_preco_praticado, ps_CEST, ps_beneficio, pi_nr_item, ps_codigo_sap )
		
End Choose

end function

on uo_pdv.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_pdv.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;this.of_modo_impressora()
end event

event destructor;If IsValid(ivo_bematech) Then Destroy(ivo_bematech)
If IsValid(ivo_sweda) 	 Then Destroy(ivo_sweda)
If IsValid(ivo_epson)	 Then Destroy(ivo_epson)
If IsValid(ivo_Daruma)	 Then Destroy(ivo_Daruma)
If IsValid(ivo_NFCE)	 Then Destroy(ivo_NFCE)
If IsValid(ivo_SAT)	 Then Destroy(ivo_SAT)
end event

