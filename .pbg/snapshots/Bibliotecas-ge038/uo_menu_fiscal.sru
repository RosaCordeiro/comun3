HA$PBExportHeader$uo_menu_fiscal.sru
forward
global type uo_menu_fiscal from nonvisualobject
end type
end forward

global type uo_menu_fiscal from nonvisualobject
end type
global uo_menu_fiscal uo_menu_fiscal

type prototypes
FUNCTION boolean MoveFileA(string lpExistingFileName,string lpNewFileName)library "Kernel32.dll" alias for "MoveFileA;Ansi";
FUNCTION boolean CopyFileA(ref string cfrom, ref string cto, boolean flag) LIBRARY "Kernel32.dll" alias for "CopyFileA;Ansi";

FUNCTION Long generateEAD(String cArquivo, String cChavePublica, String cChavePrivada, Ref String cEAD, Integer iSign) LIBRARY "c:\sistemas\dll\bematech\sign_bema.dll" alias for "generateEAD;Ansi";
FUNCTION Long md5FromFile(String cNomeArquivo, Ref String cMD5) LIBRARY "c:\sistemas\dll\bematech\sign_bema.dll" alias for "md5FromFile;Ansi";

Function integer Assinaxml_GeraAssinatura(String a_nomearquivo, String a_xmloriginal, String a_diretorio) LIBRARY "C:\sistemas\dll\Assinaxml.dll" alias for "Assinaxml_GeraAssinatura;Ansi"
Function integer AtualizaCertificado() LIBRARY "C:\sistemas\dll\Assinaxml.dll" alias for "AtualizaCertificado;Ansi"
end prototypes

type variables
Long ivl_Filial

STRING nr_Serie
STRING de_Modelo
STRING de_Marca
STRING de_Tipo
STRING nr_versao_swbasico
STRING Id_Situacao
STRING cd_identificacao_nacional
STRING Id_MFAdicional
STRING nr_Versao_Caixa
STRING nr_Serie_MFD

STRING ivs_MD5

DATETIME dh_SWBasico
Date dt_inicio_blocox
Date dt_envio_codigo_sap

s_contador_bloco cont_bloco

DataStore ids_Arquivo

CONSTANT String is_Caminho_Arquivo_Xml = "c:\sistemas\cl\arquivos\PAF-ECF\"
String is_numero_credenciamento
//'102029869341' - login site sat SC.
//'1806900009738' - atual
//'1706900000619' - vencido

Integer ivi_Arquivo_Xml

String ivs_Nome_Arquivo
String ivs_Arquivo_Xml
String ivs_Enter = ''
String ivs_Tab = ""

Boolean ivb_registros170 //= true
Boolean ivb_padraoH

String cd_caixa
String id_envia_blocoX
String id_gera_blocoX
String cd_cest_generico
end variables

forward prototypes
public function boolean of_renomeia_arquivo (string ps_antigo, string ps_novo, boolean pb_replace)
public function boolean of_pafecf_ac0908_bloco_outros (date pdh_inicial, date pdh_final, long pl_arquivo)
public function boolean of_pafecf_conv5795_r11 (long pl_arquivo)
public function boolean of_pafecf_conv5795_r50 (date pdh_inicial, date pdh_final, long pl_arquivo)
public function boolean of_pafecf_conv5795_r54 (date pdh_inicial, date pdh_final, long pl_arquivo)
public function boolean of_pafecf_conv5795_r60a (date pdh_registro, long pl_arquivo, long pl_ecf)
public function boolean of_pafecf_conv5795_r60d (date pdh_registro, long pl_arquivo)
public function boolean of_pafecf_conv5795_r60m (date pdh_registro, long pl_arquivo, long pl_ecf)
public function boolean of_pafecf_conv5795_r60r (date pdh_inicial, date pdh_final, long pl_arquivo)
public function boolean of_pafecf_conv5795_r75 (date pdh_inicial, date pdh_final, long pl_arquivo)
public function boolean of_pafecf_ac0908_bloco_c (date pdh_inicial, date pdh_final, long pl_arquivo, long pl_ecf)
public function boolean of_inconsistencia_inclusao_exclusao ()
public function boolean of_inconsistencia_filial (long pl_filial)
public function boolean of_inconsistencia_mapa_resumo (long pl_mapa, long pl_filial)
public function boolean of_inconsistencia_mapa_resumo_ecf (long pl_mapa, long pl_filial, long pl_ecf)
public function boolean of_inconsistencia_meio_pagamento (long pl_coo, long pl_ecf, long pl_filial, boolean pb_update)
public function boolean of_inconsistencia_produto_geral (long pl_produto)
public function boolean of_verifica_alteracao_tabela (string ps_tabela, string ps_chave, string ps_valor)
public function boolean of_capturar_md5_old (string ps_arquivo, ref string ps_md5)
public function boolean of_identificacao_pafecf ()
public function boolean of_pafecf_conv5795_r90 (date pdh_inicial, date pdh_final, long pl_arquivo)
public function boolean of_pafecf_conv5795_r10 (date pdh_inicial, date pdh_final, long pl_arquivo)
public function boolean of_pafecf_ac0908_bloco_0 (date pdh_inicial, date pdh_final, long pl_arquivo)
public function boolean of_inconsistencia_impressora_fiscal (long pl_ecf)
public function boolean of_pafecf_registro_r07_old (long pl_ecf, date pdh_inicial, date pdh_final, long pl_arquivo, ref boolean pb_evidenciado)
public function boolean of_carrega_dados_ecf (long pl_ecf)
public function boolean of_inconsistencia_saldo_produto (long pl_produto, date pdt_saldo, boolean pb_update, long pl_quantidade)
public function boolean of_pafecf_registro_r05 (long pl_ecf, date pdh_inicial, date pdh_final, long pl_arquivo, ref boolean pb_evidenciado)
public function boolean of_pafecf_registro_r01 (long pl_ecf, date pdh_inicial, date pdh_final, long pl_arquivo, ref boolean pb_evidenciado)
public function boolean of_pafecf_registro_r02 (long pl_ecf, date pdh_inicial, date pdh_final, long pl_arquivo, ref boolean pb_evidenciado)
public function boolean of_pafecf_registro_r03 (long pl_ecf, date pdh_inicial, date pdh_final, long pl_arquivo, ref boolean pb_evidenciado)
public function string of_formata_valor_pafecf (decimal pdc_valor, long pl_inteiro, long pl_decimal)
public function boolean of_gera_vendas_periodo (ref string ps_arquivo, date pdh_inicial, date pdh_final, boolean pb_convenio, long pl_ecf)
public function boolean of_pafecf_registro_r04 (long pl_ecf, date pdh_inicial, date pdh_final, long pl_arquivo, ref boolean pb_evidenciado)
public function boolean of_inconsistencia_documento_ecf (long pl_ecf, date pdh_movimento, long pl_coo)
public function boolean of_pafecf_registro_r06 (long pl_ecf, date pdh_inicial, date pdh_final, long pl_arquivo, ref boolean pb_evidenciado)
public function boolean of_assinatura_digital (string ps_arquivo)
public function boolean of_data_primeira_venda (ref datetime pd_datahora, long pl_ecf)
public function boolean of_registro_cat52_e00 (long pl_ecf, date pdh_inicial, date pdh_final, long pl_arquivo, ref boolean pb_evidenciado)
public function boolean of_registro_cat52_e01 (long pl_ecf, date pdh_inicial, date pdh_final, long pl_arquivo, ref boolean pb_evidenciado)
public function boolean of_registro_cat52_e02 (long pl_ecf, date pdh_inicial, date pdh_final, long pl_arquivo, ref boolean pb_evidenciado)
public function boolean of_registro_cat52_e12 (long pl_ecf, date pdh_inicial, date pdh_final, long pl_arquivo, ref boolean pb_evidenciado)
public function boolean of_registro_cat52_e13 (long pl_ecf, date pdh_inicial, date pdh_final, long pl_arquivo, ref boolean pb_evidenciado)
public function boolean of_registro_cat52_e14 (long pl_ecf, date pdh_inicial, date pdh_final, long pl_arquivo, ref boolean pb_evidenciado)
public function boolean of_registro_cat52_e15 (long pl_ecf, date pdh_inicial, date pdh_final, long pl_arquivo, ref boolean pb_evidenciado)
public function boolean of_registro_cat52_e16 (long pl_ecf, date pdh_inicial, date pdh_final, long pl_arquivo, ref boolean pb_evidenciado)
public function boolean of_registro_cat52_e21 (long pl_ecf, date pdh_inicial, date pdh_final, long pl_arquivo, ref boolean pb_evidenciado)
public function boolean of_gera_movimento_cat52 (ref string ps_arquivo, long pl_ecf, date pdh_inicial, date pdh_final)
public function boolean of_gera_meios_pagamento (date pdh_inicial, date pdh_final, long pl_arquivo, ref boolean pb_evidenciado)
public function boolean of_busca_ecf_primeira_venda (ref long pl_ecf)
public function boolean of_pafecf_registro_r07 (long pl_ecf, date pdh_inicial, date pdh_final, long pl_arquivo, ref boolean pb_evidenciado)
public subroutine of_grava_registro_temp_arquivo (long pl_arquivo)
public function boolean of_grava_registro_temp (string ps_tipo, string ps_data, string ps_tipo_doc, string ps_meio_pagamento, string ps_registro)
public function boolean of_evidencia (string ps_data, string ps_meio_pagamento, string ps_tipo_doc)
public function boolean of_atualiza_dll_sign ()
public function boolean of_abre_arquivo ()
public function string of_abre_tag (string ps_tag, long pl_identacao)
public function string of_identa (string ps_registro, long pl_tabulacao)
public function string of_elemento (string ps_tag, string ps_string, long pl_identacao)
public function string of_fecha_tag (string ps_tag, long pl_identacao)
public function boolean of_grava_arquivo (integer pi_arquivo, string ps_registro)
public function boolean of_grava_arquivo (string ps_registro)
public function boolean of_gera_vendas_identificadas (date pdh_inicial, date pdh_final, long pl_arquivo, string ps_cpf)
public function boolean of_envia_pendencias_blocox (string ps_tipo, long pl_ecf, boolean pb_aviso)
public function boolean of_gera_produto_estoque (integer pl_arquivo, string ps_tipo, ref boolean pb_evidenciado)
public function boolean of_gera_estoque_saldo (integer pl_arquivo, string ps_tipo, datetime pdt_data_estoque, ref boolean pb_evidenciado)
public function boolean of_gera_movimento_pafecf (ref string ps_arquivo, long pl_ecf, date pdh_inicial, date pdh_final, date pdh_ultima_venda)
public function boolean of_inconsistencia_item_cancelado (long pl_nota, long pl_filial, long pl_produto)
public function boolean of_inconsistencia_aliquota_ecf (long pl_mapa, long pl_filial, long pl_ecf)
public function boolean of_inconsistencia_aliquota_ecf_produto (long pl_mapa, long pl_filial, long pl_ecf, decimal pdc_aliquota)
public function boolean of_pafecf_registro_j01 (date pdh_inicial, date pdh_final, long pl_arquivo, ref boolean pb_evidenciado)
public function boolean of_pafecf_registro_j02 (long pl_ecf, date pdh_inicial, date pdh_final, long pl_arquivo, ref boolean pb_evidenciado)
public function boolean of_gera_blocox_estoque (long pl_mes, long pl_ano, ref string ps_recibo, ref string ps_situacao)
public function boolean of_inconsistencia_nf_venda (long pl_nota, long pl_filial, string ps_especie, string ps_serie, boolean pb_update)
public function boolean of_inconsistencia_nf_venda (long pl_nota, long pl_filial, string ps_especie, string ps_serie, boolean pb_update, ref string ps_cancelado)
public function boolean of_inconsistencia_item_nf_venda (long pl_nota, long pl_filial, long pl_produto, string ps_especie, string ps_serie)
public function boolean of_inconsistencia_nfe (long pl_nota, long pl_filial, string ps_especie, string ps_serie, boolean pb_update)
public function boolean of_envia_ftp (string ps_caminho, string ps_arquivo, string ps_ano, string ps_mes, ref string ps_msg_ftp, boolean pb_estoque)
public function boolean of_envia_pendencias_blocox_matriz (string ps_tipo, long pl_ecf, boolean pb_mensagem, boolean pb_aviso_sem_registro)
public function boolean of_gera_blocox_reducao (date pdt_data_fiscal, long pl_ecf, long pl_seq_historico)
public function boolean of_gera_blocox_reducao (date pdt_inicio, long pl_ecf, ref string ps_recibo, ref string ps_situacao, long pl_sequencial_hist, long pl_filial)
public function boolean of_gera_blocox_reducao_matriz (long pl_filial, long pl_mapa, date pdt_data_fiscal, long pl_ecf, long pl_seq_historico, string ps_diretorio, string ps_inscricao, ref string ps_erro)
public function string of_elemento_vazio (string ps_tag, string ps_string, long pl_identacao)
public function boolean of_gera_xml_consulta (long pl_filial, long pl_qt_rz, date pdt_data_fiscal, long pl_ecf, long pl_seq_historico, string ps_diretorio, string ps_recibo, ref string ps_erro, ref string ps_nome_xml)
public function boolean of_assinar_arquivo (string ps_nome_arquivo_assinado, string ps_arquivo_para_assinar, string ps_caminho_gravar_arquivo_assinado, boolean pb_compactar)
public function boolean of_atualiza_historico_erro (long pl_filial, long pl_seq, string ps_erro)
public function boolean of_gera_blocox_canc_rep (long pl_filial, long pl_qt_rz, date pdt_data_fiscal, long pl_ecf, long pl_seq_historico, string ps_diretorio, string ps_recibo, string ps_motivo, ref string ps_erro, ref string ps_nome_xml, boolean pb_reprocesso)
public function boolean of_verifica_pendencias_blocox (string ps_tipo, long pl_ecf, boolean pb_mensagem, boolean pb_aviso_sem_registro, ref boolean pb_bloquear, string ps_mostra_registros)
public function boolean of_gera_xml_consulta_loja (long pl_filial, string ps_tipo, date pdt_data_fiscal, long pl_ecf, long pl_seq_historico, string ps_diretorio, string ps_recibo, ref string ps_erro, ref string ps_nome_xml)
public function boolean of_grava_retorno (string ps_retorno, string ps_arquivo, ref string ps_msg)
public function boolean of_pafecf_registro_nfc_j01 (date pdh_inicial, date pdh_final, long pl_arquivo, ref boolean pb_evidenciado)
public function boolean of_pafecf_registro_nfc_j02 (date pdh_inicial, date pdh_final, long pl_arquivo, ref boolean pb_evidenciado)
public function boolean of_atualiza_certificado (string ps_arquivo)
public function boolean of_gera_blocox_reducao (date pdt_data_fiscal, long pl_ecf, long pl_seq_historico, string as_path_arquivo)
end prototypes

public function boolean of_renomeia_arquivo (string ps_antigo, string ps_novo, boolean pb_replace);Boolean lb_Retorno = True

If pb_replace Then
	
	If FileExists(ps_novo) Then
	
		lb_Retorno = FileDelete(ps_novo)
		
		If Not lb_Retorno Then Return False
		
	End If	

End If

lb_Retorno = MoveFileA(ps_antigo,ps_novo)

IF NOT lb_Retorno THEN
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao renomear arquivo : " + ps_antigo + " para " + ps_novo , StopSign!) 
END IF	

Return lb_Retorno
end function

public function boolean of_pafecf_ac0908_bloco_outros (date pdh_inicial, date pdh_final, long pl_arquivo);//Vendas do per$$HEX1$$ed00$$ENDHEX$$odo pelo formato Ato Cotepe 09/08 bloco D, E, H, I, 1 e 9

Boolean lb_Sucesso = True

Date ldt_Venc_ICMS

Decimal{2} ldc_ICMS

Long ll_Retorno
Long ll_Linha
Long ll_Linha2
Long ll_Contador

String ls_Registro
String ls_Aux


// B L O C O - D


//Fixo, indica Bloco D, registro D001 / 1 - Bloco sem dados
ls_Registro  = '|D001|1|'

If FileWrite(pl_arquivo,ls_Registro) = -1 Then
	lb_Sucesso = False
End If

//Fixo, indica Bloco D, registro D990 / Total de linhas do Bloco D
ls_Registro  = '|D990|2|'

If FileWrite(pl_arquivo,ls_Registro) = -1 Then
	lb_Sucesso = False
End If


// B L O C O - E


//Fixo, indica Bloco E, registro E001  / 0 - Bloco com dados
ls_Registro  = '|E001|0|'

If FileWrite(pl_arquivo,ls_Registro) = -1 Then
	lb_Sucesso = False
End If
ll_Contador = 1


//Fixo, indica Bloco E, registro E100
ls_Registro  = '|E100|'

//Data inicial
ls_Registro  += String(pdh_Inicial,"DDMMYYYY") + '|'

//Data Final
ls_Registro  += String(pdh_Final,"DDMMYYYY") + '|'

If FileWrite(pl_arquivo,ls_Registro) = -1 Then
	lb_Sucesso = False
End If

ll_Contador++


//Fixo, indica Bloco E, registro E110
ls_Registro  = '|E110|'

Select Sum(vl_icms)
  Into :ldc_ICMS
  From nf_venda
// Where dh_movimentacao_caixa >= :pdh_Inicial
//   And dh_movimentacao_caixa <= :pdh_Final
 Where dh_emissao >= :pdh_Inicial
 AND 	dh_emissao < dbo.adddate('day', 1, :pdh_Final)
 Using SQLCa;

If IsNull(ldc_ICMS) Then ldc_ICMS = 0

If SQLCa.SQLCode <> -1 Then
	//Valor total debitos do imposto
	ls_Registro  += String(ldc_ICMS,"###0.00") + '|0,00|0,00|0,00|0,00|0,00|0,00|0,00|0,00|' + String(ldc_ICMS,"###0.00") + '|0,00|' + String(ldc_ICMS,"###0.00") + '|0,00|0,00|'
End If

If FileWrite(pl_arquivo,ls_Registro) = -1 Then
	lb_Sucesso = False
End If
ll_Contador++


//Fixo, indica Bloco E, registro E116
ls_Registro  = '|E116|'

//2014.08.15 - Marlon
//ldt_Venc_ICMS = Date("01/" + String(Month(pdh_Final) + 1,"00") + "/2010")
ldt_Venc_ICMS = Date("10/" + String(Month(pdh_Final) + 1,"00") + "/"+String(Year(Today())))
//ls_Registro  += "000|" + String(ldc_ICMS,"###0.00") + "|" + String(ldt_Venc_ICMS,"DDMMYYYY") + "|1449|||||"
ls_Registro  += "000|" + String(ldc_ICMS,"###0.00") + "|" + String(ldt_Venc_ICMS,"DDMMYYYY") + "|144910014|||||"
ls_Registro  += String(pdh_Final,'mmyyyy')+'|'

If FileWrite(pl_arquivo,ls_Registro) = -1 Then
	lb_Sucesso = False
End If
ll_Contador++


//Fixo, indica Bloco E, registro E200
ls_Registro  = '|E200|'

ls_Registro  += "SC|" + String(pdh_Inicial,"DDMMYYYY") + "|" + String(pdh_Final,"DDMMYYYY") + "|"

If FileWrite(pl_arquivo,ls_Registro) = -1 Then
	lb_Sucesso = False
End If
ll_Contador++


//Fixo, indica Bloco E, registro E210
ls_Registro  = '|E210|'

ls_Registro  += "0|0,00|0,00|0,00|0,00|0,00|0,00|0,00|0,00|0,00|0,00|0,00|0,00|0,00|"

If FileWrite(pl_arquivo,ls_Registro) = -1 Then
	lb_Sucesso = False
End If
ll_Contador++

//Fixo, indica Bloco E, registro E300
ls_Registro  = '|E300|'

ls_Registro  += "SC|" + String(pdh_Inicial,"DDMMYYYY") + "|" + String(pdh_Final,"DDMMYYYY") + "|"

If FileWrite(pl_arquivo,ls_Registro) = -1 Then
	lb_Sucesso = False
End If
ll_Contador++

//Fixo, indica Bloco E, registro E310
ls_Registro  = '|E310|'

ls_Registro  += "0|0,00|0,00|0,00|0,00|0,00|0,00|0,00|0,00|0,00|0,00|0,00|0,00|"

If FileWrite(pl_arquivo,ls_Registro) = -1 Then
	lb_Sucesso = False
End If
ll_Contador++

//Fixo, indica Bloco E, registro E990
ls_Registro  = '|E990|'

//Contador de linhas do BLOCO E
ll_Contador++
ls_Registro  += String(ll_Contador) + "|"

If FileWrite(pl_arquivo,ls_Registro) = -1 Then
	lb_Sucesso = False
End If
Cont_Bloco.cont_e990 = ll_Contador

// B L O C O - G

//Fixo, indica Bloco G, registro G001 / 1 - Bloco sem dados
ls_Registro  = '|G001|1|'

If FileWrite(pl_arquivo,ls_Registro) = -1 Then
	lb_Sucesso = False
End If
ll_Contador = 1

//Fixo, indica Bloco G, registro G990 / 
ls_Registro  = '|G990|2|'
If FileWrite(pl_arquivo,ls_Registro) = -1 Then
	lb_Sucesso = False
End If
ll_Contador ++

// B L O C O - H

//Fixo, indica Bloco H, registro H001 / 0 - Bloco com dados
ls_Registro  = '|H001|0|'

If FileWrite(pl_arquivo,ls_Registro) = -1 Then
	lb_Sucesso = False
End If
ll_Contador = 1

//Fixo, indica Bloco H, registro H005
ls_Registro  = '|H005|'

//Data do invent$$HEX1$$e100$$ENDHEX$$rio
ls_Registro  += String(pdh_Final,"DDMMYYYY") + '|'

//Valor do invent$$HEX1$$e100$$ENDHEX$$rio
ls_Registro  += '0,00|'

//Motivo do invent$$HEX1$$e100$$ENDHEX$$rio
ls_Registro  += '01|'

If FileWrite(pl_arquivo,ls_Registro) = -1 Then
	lb_Sucesso = False
End If
ll_Contador++

//Fixo, indica Bloco H, registro H990
ls_Registro  = '|H990|'

//Contador de linhas do BLOCO H
ll_Contador++
ls_Registro  += String(ll_Contador) + "|"

If FileWrite(pl_arquivo,ls_Registro) = -1 Then
	lb_Sucesso = False
End If
Cont_Bloco.cont_h990 = ll_Contador

// B L O C O - K

//Fixo, indica Bloco K, registro K001 / 1 - Bloco sem dados
ls_Registro  = '|K001|1|'

If FileWrite(pl_arquivo,ls_Registro) = -1 Then
	lb_Sucesso = False
End If
ll_Contador = 1

//Fixo, indica Bloco k, registro k990 / 
ls_Registro  = '|k990|2|'
If FileWrite(pl_arquivo,ls_Registro) = -1 Then
	lb_Sucesso = False
End If
ll_Contador ++


// B L O C O - 1

//Fixo, indica Bloco 1, registro 1001 / 0 - Bloco com dados
ls_Registro  = '|1001|0|'
If FileWrite(pl_arquivo,ls_Registro) = -1 Then
	lb_Sucesso = False
End If
ll_Contador = 1

ls_Registro  = '|1010|N|N|N|N|N|N|N|N|N|'

If FileWrite(pl_arquivo,ls_Registro) = -1 Then
	lb_Sucesso = False
End If
ll_Contador = 1

//Fixo, indica Bloco 1, registro 1990 / 
ls_Registro  = '|1990|3|'

If FileWrite(pl_arquivo,ls_Registro) = -1 Then
	lb_Sucesso = False
End If
ll_Contador++

Cont_Bloco.cont_1990 = ll_Contador


// B L O C O - 9
//Totalizadores
ll_Contador = 1

//Fixo, indica Bloco E, registro 9001
ls_Registro  = '|9001|0|'

If FileWrite(pl_arquivo,ls_Registro) = -1 Then
	lb_Sucesso = False
End If

ls_Registro   = '|9900|C001|1|' + CharA(13) + CharA(10)
ls_Registro  += '|9900|C100|' + String(Cont_Bloco.cont_C100) + '|' + CharA(13) + CharA(10)
If ivb_registros170 Then
	ls_Registro  += '|9900|C170|' + String(Cont_Bloco.cont_C170) + '|' + CharA(13) + CharA(10)
	ls_Registro  += '|9900|C176|' + String(Cont_Bloco.cont_C176) + '|' + CharA(13) + CharA(10)
End If
ls_Registro  += '|9900|C190|' + String(Cont_Bloco.cont_C190) + '|' + CharA(13) + CharA(10)
ls_Registro  += '|9900|C400|' + String(Cont_Bloco.cont_C400) + '|' + CharA(13) + CharA(10)
ls_Registro  += '|9900|C405|' + String(Cont_Bloco.cont_C405) + '|' + CharA(13) + CharA(10)
ls_Registro  += '|9900|C420|' + String(Cont_Bloco.cont_C420) + '|' + CharA(13) + CharA(10)
ls_Registro  += '|9900|C460|' + String(Cont_Bloco.cont_C460) + '|' + CharA(13) + CharA(10)
ls_Registro  += '|9900|C470|' + String(Cont_Bloco.cont_C470) + '|' + CharA(13) + CharA(10)
ls_Registro  += '|9900|C490|' + String(Cont_Bloco.cont_C490) + '|' + CharA(13) + CharA(10)
ls_Registro  += '|9900|C990|1|' + CharA(13) + CharA(10)
ls_Registro  += '|9900|D001|1|' + CharA(13) + CharA(10)
ls_Registro  += '|9900|D990|1|' + CharA(13) + CharA(10)
ls_Registro  += '|9900|E001|1|' + CharA(13) + CharA(10)
ls_Registro  += '|9900|E100|1|' + CharA(13) + CharA(10)
ls_Registro  += '|9900|E110|1|' + CharA(13) + CharA(10)
ls_Registro  += '|9900|E116|1|' + CharA(13) + CharA(10)
ls_Registro  += '|9900|E200|1|' + CharA(13) + CharA(10)
ls_Registro  += '|9900|E210|1|' + CharA(13) + CharA(10)
ls_Registro  += '|9900|E300|1|' + CharA(13) + CharA(10)
ls_Registro  += '|9900|E310|1|' + CharA(13) + CharA(10)
ls_Registro  += '|9900|E990|1|' + CharA(13) + CharA(10)
ls_Registro  += '|9900|G001|1|' + CharA(13) + CharA(10)
ls_Registro  += '|9900|G990|1|' + CharA(13) + CharA(10)
ls_Registro  += '|9900|H001|1|' + CharA(13) + CharA(10)
ls_Registro  += '|9900|H005|1|' + CharA(13) + CharA(10)
ls_Registro  += '|9900|H990|1|' + CharA(13) + CharA(10)
ls_Registro  += '|9900|K001|1|' + CharA(13) + CharA(10)
ls_Registro  += '|9900|K990|1|' + CharA(13) + CharA(10)
ls_Registro  += '|9900|1001|1|' + CharA(13) + CharA(10)
ls_Registro  += '|9900|1010|1|' + CharA(13) + CharA(10)
ls_Registro  += '|9900|1990|1|' + CharA(13) + CharA(10)
ls_Registro  += '|9900|0000|1|' + CharA(13) + CharA(10)
ls_Registro  += '|9900|0001|1|' + CharA(13) + CharA(10)
ls_Registro  += '|9900|0005|1|' + CharA(13) + CharA(10)
ls_Registro  += '|9900|0015|1|' + CharA(13) + CharA(10)
ls_Registro  += '|9900|0100|1|' + CharA(13) + CharA(10)
ls_Registro  += '|9900|0150|' + String(Cont_Bloco.cont_0150) + '|' + CharA(13) + CharA(10)
ls_Registro  += '|9900|0190|' + String(Cont_Bloco.cont_0190) + '|' + CharA(13) + CharA(10)
ls_Registro  += '|9900|0200|' + String(Cont_Bloco.cont_0200) + '|' + CharA(13) + CharA(10)
If ivb_registros170 Then
	ls_Registro  += '|9900|0400|1|' + CharA(13) + CharA(10)
End If
ls_Registro  += '|9900|0990|1|' + CharA(13) + CharA(10)
ls_Registro  += '|9900|9001|1|' + CharA(13) + CharA(10)

ls_Registro  += '|9900|9900|'+Iif(ivb_registros170,'47','44')+'|' + CharA(13) + CharA(10)
ls_Registro  += '|9900|9990|1|' + CharA(13) + CharA(10)
ls_Registro  += '|9900|9999|1|'

If FileWrite(pl_arquivo,ls_Registro) = -1 Then
	lb_Sucesso = False
End If

Cont_Bloco.cont_9990 = Iif(ivb_registros170,50,47)
ls_Registro  = '|9990|'+String(Cont_Bloco.cont_9990)+'|'


If FileWrite(pl_arquivo,ls_Registro) = -1 Then
	lb_Sucesso = False
End If

ls_Registro  = '|9999|' + String(Cont_Bloco.cont_0990 + Cont_Bloco.cont_C990 + 7 + Cont_Bloco.cont_E990 + Cont_Bloco.cont_H990 + Cont_Bloco.cont_1990 + Cont_Bloco.cont_9990) + '|'

If FileWrite(pl_arquivo,ls_Registro) = -1 Then
	lb_Sucesso = False
End If

Return lb_Sucesso
end function

public function boolean of_pafecf_conv5795_r11 (long pl_arquivo);//Vendas do per$$HEX1$$ed00$$ENDHEX$$odo pelo formato Convenio 57/95 registro 10

Boolean lb_Sucesso = False

Long ll_Retorno

String ls_Registro

ls_Registro = "11Vicente Machado                   00284                      Centro         83880970S$$HEX1$$f400$$ENDHEX$$nia Bresciani Mariano     004734619907"

If FileWrite(pl_arquivo,ls_Registro) = -1 Then
	lb_Sucesso = False
End If
cont_bloco.cont_99++

lb_Sucesso = True

Return lb_Sucesso


end function

public function boolean of_pafecf_conv5795_r50 (date pdh_inicial, date pdh_final, long pl_arquivo);//Vendas do per$$HEX1$$ed00$$ENDHEX$$odo pelo formato Convenio 57/95 registro 10

Boolean lb_Sucesso = True

Decimal{2} ldc_Aux

Long ll_Retorno
Long ll_Linha 
Long ll_Linha2 
Long ll_Nota

String ls_Registro
String ls_serie
String ls_especie

Decimal {2} ldc_icms
Decimal {2} ldc_outros
Decimal {2} ldc_total_trib
Decimal {2} ldc_total_outros
Decimal {2} ldc_praticado_trib
Decimal {2} ldc_praticado_outros
Long ll_cfop_outros
Long ll_cfop_trib				

dc_uo_ds_base lvds_1
dc_uo_ds_base lvds_2
lvds_1 = Create dc_uo_ds_base
lvds_2 = Create dc_uo_ds_base

If Not lvds_1.of_ChangeDataObject('dw_ge038_pafecf_nota_fiscal') Then 
	Destroy(lvds_1)
	Return False
End If 

ll_Retorno = lvds_1.Retrieve(pdh_Inicial,pdh_Final)

If ll_Retorno <> -1 Then
	
	For ll_Linha = 1 To lvds_1.RowCount()
		ll_Nota 		= lvds_1.Object.nr_nf[ll_Linha]
		ls_especie 	= lvds_1.Object.de_especie[ll_Linha]		
		ls_serie 		= lvds_1.Object.de_serie[ll_Linha]
		
		If Not lvds_2.of_ChangeDataObject('dw_ge038_pafecf_item_nota_fiscal') Then 
			Destroy(lvds_1)
			Destroy(lvds_2)
			Return False
		End If 
		
		lvds_2.of_AppendWhere("nf_venda.nr_nf = " + String(ll_Nota) + " and nf_venda.de_especie = '" + ls_especie + "' and nf_venda.de_serie = '" + ls_serie + "'")
		
		ll_Retorno = lvds_2.Retrieve(gvo_Parametro.cd_Filial)
		
		If ll_Retorno <> -1 Then	
			For ll_Linha2 = 1 To lvds_2.RowCount()								
				
				Choose Case lvds_2.Object.cd_situacao_tributaria[ll_linha2]
					Case "00"						
						ldc_icms = lvds_2.Object.pc_icms[ll_Linha2]
						ll_cfop_trib = lvds_2.Object.cd_natureza_operacao[ll_Linha2]
						ldc_total_trib += lvds_2.Object.vl_preco_praticado[ll_Linha2] * lvds_2.Object.qt_vendida[ll_Linha2]
						//ldc_Aux = lvds_2.Object.pc_icms[ll_Linha2]/100
						//ldc_Aux = lvds_2.Object.vl_preco_praticado[ll_Linha2] * ldc_Aux						
					Case Else
						ldc_outros = 0.00
						ll_cfop_outros = lvds_2.Object.cd_natureza_operacao[ll_Linha2]
						ldc_total_outros += lvds_2.Object.vl_preco_praticado[ll_Linha2] * lvds_2.Object.qt_vendida[ll_Linha2]						
				End Choose		
				
			Next				
				
			If ll_cfop_trib > 0 Then
			
				ls_Registro  = '50'
				
				//ls_Registro += Left(gvo_Parametro.nr_cgc + Space(14) ,14) 
				//ls_Registro += "00000000000000"
				If IsNull(lvds_1.Object.nr_cpf_cgc[ll_Linha]) Or Trim(lvds_1.Object.nr_cpf_cgc[ll_Linha]) = "" Then
					ls_Registro += Right('000'+'02623683905',14)
				Else
					ls_Registro += Right('000'+lvds_1.Object.nr_cpf_cgc[ll_Linha],14)
				End If
							
				//ls_Registro += Left(gf_Replace(gvo_Parametro.nr_Inscricao_Estadual,".","",0) + Space(14) ,14)
				ls_Registro += LeftA("ISENTO" + Space(14), 14)
					
				ls_Registro += String(lvds_1.Object.dh_emissao[ll_Linha],"YYYYMMDD")
				
				ls_Registro += LeftA(gvo_Parametro.ivs_UF_Filial + Space(2), 2)
						
				ls_Registro += "01"
				
				//ls_Registro += LeftA(lvds_1.Object.de_serie[ll_Linha] + Space(3),3) // validador nao aceitou serie informada, deixar em branco passa.
				ls_Registro += Space(3)  //SERIE
				
				ls_Registro += of_Formata_Valor_PafEcf(lvds_1.Object.nr_nf[ll_Linha],6,0)
					
				ls_Registro += String(ll_cfop_trib,"0000")
				
				ls_Registro += "P"
				
				ls_Registro += of_Formata_Valor_PafEcf(ldc_total_trib,11,2)
				
				ls_Registro += of_Formata_Valor_PafEcf(ldc_total_trib,11,2)
				ldc_Aux = ldc_icms/100
				ldc_Aux = ldc_total_trib * ldc_Aux
				ls_Registro += of_Formata_Valor_PafEcf(ldc_Aux,11,2)
				ls_Registro += "0000000000000"
				ls_Registro += "0000000000000"
					
				ls_Registro += of_Formata_Valor_PafEcf(ldc_icms,4,0)
				
				If lvds_1.Object.id_cancelamento_impressora[ll_Linha] = 'S' Then
					ls_Registro += "S"
				Else
					ls_Registro += "N"
				End If
				
				If FileWrite(pl_arquivo,ls_Registro) = -1 Then
					lb_Sucesso = False
					Exit
				End If
				cont_bloco.cont_50++
				
			End If	
			If ll_cfop_outros > 0 Then
			
				ls_Registro  = '50'
				
				//ls_Registro += Left(gvo_Parametro.nr_cgc + Space(14) ,14) 
				//ls_Registro += "00000000000000"
				If IsNull(lvds_1.Object.nr_cpf_cgc[ll_Linha]) Or Trim(lvds_1.Object.nr_cpf_cgc[ll_Linha]) = "" Then
					ls_Registro += Right('000'+'02623683905',14)
				Else
					ls_Registro += Right('000'+lvds_1.Object.nr_cpf_cgc[ll_Linha],14)
				End If
							
				//ls_Registro += Left(gf_Replace(gvo_Parametro.nr_Inscricao_Estadual,".","",0) + Space(14) ,14)
				ls_Registro += LeftA("ISENTO" + Space(14), 14)
					
				ls_Registro += String(lvds_1.Object.dh_emissao[ll_Linha],"YYYYMMDD")
				
				ls_Registro += LeftA(gvo_Parametro.ivs_UF_Filial + Space(2), 2)
						
				ls_Registro += "01"
				
				//ls_Registro += LeftA(lvds_1.Object.de_serie[ll_Linha] + Space(3),3) // validador nao aceitou serie informada, deixar em branco passa.
				ls_Registro += Space(3)  //SERIE
				
				ls_Registro += of_Formata_Valor_PafEcf(lvds_1.Object.nr_nf[ll_Linha],6,0)
					
				ls_Registro += String(ll_cfop_outros,"0000")
				
				ls_Registro += "P"
				
				ls_Registro += of_Formata_Valor_PafEcf(ldc_total_outros,11,2)
				
				ls_Registro += "0000000000000"
				ls_Registro += "0000000000000"
				ls_Registro += "0000000000000"
				ls_Registro += of_Formata_Valor_PafEcf(ldc_total_outros,11,2)
					
				ls_Registro += of_Formata_Valor_PafEcf(ldc_outros,4,0)
				
				If lvds_1.Object.id_cancelamento_impressora[ll_Linha] = 'S' Then
					ls_Registro += "S"
				Else
					ls_Registro += "N"
				End If
				
				If FileWrite(pl_arquivo,ls_Registro) = -1 Then
					lb_Sucesso = False
					Exit
				End If
				cont_bloco.cont_50++
				
			End If		
			
		End IF
		
		ldc_icms 						= 0.00
		ldc_outros					= 0.00
		ldc_total_trib				= 0.00
		ldc_total_outros			= 0.00
		ldc_praticado_trib			= 0.00
		ldc_praticado_outros		= 0.00
		ll_cfop_outros				= 0
		ll_cfop_trib					= 0		
		
	Next
	
End If

Destroy(lvds_1)
Destroy(lvds_2)

Return lb_Sucesso
end function

public function boolean of_pafecf_conv5795_r54 (date pdh_inicial, date pdh_final, long pl_arquivo);//Vendas do per$$HEX1$$ed00$$ENDHEX$$odo pelo formato Convenio 57/95 registro 10

Boolean lb_Sucesso = True

Decimal{2} ldc_Aux

Long ll_Retorno
Long ll_Linha 
Long ll_Linha2 
Long ll_Nota

String ls_Registro
String ls_especie
String ls_serie

dc_uo_ds_base lvds_1
dc_uo_ds_base lvds_2
lvds_1 = Create dc_uo_ds_base
lvds_2 = Create dc_uo_ds_base

If Not lvds_1.of_ChangeDataObject('dw_ge038_pafecf_nota_fiscal') Then 
	Destroy(lvds_1)
	Return False
End If 

ll_Retorno = lvds_1.Retrieve(pdh_Inicial,pdh_Final)

If ll_Retorno <> -1 Then
	
	For ll_Linha = 1 To lvds_1.RowCount()
		ll_Nota 		= lvds_1.Object.nr_nf[ll_Linha]
		ls_especie	= lvds_1.Object.de_especie[ll_Linha]
		ls_serie		= lvds_1.Object.de_serie[ll_Linha]
		
		If Not lvds_2.of_ChangeDataObject('dw_ge038_pafecf_item_nota_fiscal') Then 
			Destroy(lvds_1)
			Destroy(lvds_2)
			Return False
		End If 
		
		lvds_2.of_AppendWhere("nf_venda.nr_nf = " + String(ll_Nota) + " and nf_venda.de_especie = '" + ls_especie + "' and nf_venda.de_serie = '" + ls_serie + "'")
		
		ll_Retorno = lvds_2.Retrieve(gvo_Parametro.cd_Filial)
		
		If ll_Retorno <> -1 Then		
			For ll_Linha2 = 1 To lvds_2.RowCount()				
				ls_Registro  = '54'
				
				//ls_Registro += Left(gvo_Parametro.nr_cgc + Space(14) ,14) 
				//ls_Registro += "00000000000000"				
				If IsNull(lvds_1.Object.nr_cpf_cgc[ll_Linha]) Or Trim(lvds_1.Object.nr_cpf_cgc[ll_Linha]) = "" Then
					ls_Registro += Right('000'+'02623683905',14)
				Else
					ls_Registro += Right('000'+lvds_1.Object.nr_cpf_cgc[ll_Linha],14)
				End If
							
				ls_Registro += "01"
				
				//ls_Registro += LeftA(lvds_1.Object.de_serie[ll_Linha] + Space(3),3) //validador n$$HEX1$$e300$$ENDHEX$$o aceita serie informada, deixa em branco passa.
				ls_Registro += Space(3)   //Serie
				
				ls_Registro += of_Formata_Valor_PafEcf(lvds_1.Object.nr_nf[ll_Linha],6,0)
					
				ls_Registro += String(lvds_2.Object.cd_natureza_operacao[ll_Linha2],"0000")
				
				ls_Registro += LeftA(lvds_2.Object.cd_situacao_tributaria[ll_Linha2] + "000",3)
				
				ls_Registro += String(ll_Linha2,"000")
				
				ls_Registro += LeftA(String(lvds_2.Object.cd_produto[ll_Linha2]) + Space(14),14)
	
				ls_Registro += String(lvds_2.Object.qt_vendida[ll_Linha2],"00000000") + "000"
				
				ldc_Aux = lvds_2.Object.vl_preco_praticado[ll_Linha2] * lvds_2.Object.qt_vendida[ll_Linha2]
				ls_Registro += of_Formata_Valor_PafEcf(ldc_Aux,10,2)
				
				ldc_Aux = lvds_2.Object.vl_preco_unitario[ll_Linha2] - lvds_2.Object.vl_preco_praticado[ll_Linha2]
				ls_Registro += of_Formata_Valor_PafEcf(ldc_Aux,10,2)
				
				If lvds_2.Object.pc_icms[ll_Linha2] > 0 Then
					ls_Registro += of_Formata_Valor_PafEcf(lvds_2.Object.vl_preco_praticado[ll_Linha2],10,2)
					ls_Registro += "000000000000"
				Else
					ls_Registro += "000000000000"
					ls_Registro += "000000000000"
				End If
				
				ls_Registro += "000000000000"
				
				ls_Registro += of_Formata_Valor_PafEcf(lvds_2.Object.pc_icms[ll_Linha2],4,0)
				
				If FileWrite(pl_arquivo,ls_Registro) = -1 Then
					lb_Sucesso = False
					Exit
				End If
				cont_bloco.cont_54++
			Next
			
		End IF
		
	Next
	
End If

Destroy(lvds_1)
Destroy(lvds_2)

Return lb_Sucesso

end function

public function boolean of_pafecf_conv5795_r60a (date pdh_registro, long pl_arquivo, long pl_ecf);//Vendas do per$$HEX1$$ed00$$ENDHEX$$odo pelo formato Convenio 57/95 registro 10

Boolean lb_Sucesso = True

Long ll_Retorno
Long ll_Linha 
Long ll_Linha2

String ls_Registro
String ls_Padrao 

ls_Padrao = '60A' + String(pdh_registro,"YYYYMMDD") + LeftA(This.nr_Serie + Space(20), 20)

dc_uo_ds_base lvds_1
dc_uo_ds_base lvds_2
lvds_1 = Create dc_uo_ds_base

lvds_1 = Create dc_uo_ds_base

If Not lvds_1.of_ChangeDataObject('dw_ge038_pafecf_reducaoz') Then 
	Destroy(lvds_1)
	Return False
End If 

ll_Retorno = lvds_1.Retrieve(pl_ecf, pdh_Registro, pdh_Registro)

For ll_Linha = 1 To lvds_1.RowCount()
	
	lvds_2 = Create dc_uo_ds_base
	
	If Not lvds_2.of_ChangeDataObject('dw_mapa_resumo_ecf_aliq') Then 
		Destroy(lvds_1)
		Destroy(lvds_2)
		Return False
	End If
	
	lvds_2.Retrieve(gvo_Parametro.cd_Filial,lvds_1.object.nr_mapa[ll_Linha],lvds_1.object.de_especie[ll_Linha],lvds_1.object.de_serie[ll_Linha])
	
	For ll_Linha2 = 1 To lvds_2.RowCount()
		If lvds_2.object.vl_base_calculo[ll_Linha2] > 0 Then
			ls_Registro  = ls_Padrao
			
			ls_Registro += of_Formata_Valor_PafEcf(lvds_2.object.pc_aliquota[ll_Linha2],2,2)
			
			ls_Registro += of_Formata_Valor_PafEcf(lvds_2.object.vl_base_calculo[ll_Linha2],10,2)
						
			ls_Registro += Space(79)
			
			If FileWrite(pl_arquivo,ls_Registro) = -1 Then
				lb_Sucesso = False
				Exit
			End If
			cont_bloco.cont_60++
		End If		
	Next
	
	Destroy(lvds_2)

	If Not lb_Sucesso Then Exit
	
	If lvds_1.object.vl_st[ll_Linha] > 0 Or lvds_1.object.vl_st_iss[ll_Linha] > 0 Then
		
		ls_Registro  = ls_Padrao
		ls_Registro += 'F   ' + of_Formata_Valor_PafEcf(lvds_1.object.vl_st[ll_Linha] + lvds_1.object.vl_st_iss[ll_Linha],10,2)
		ls_Registro += Space(79)
		
		If FileWrite(pl_arquivo,ls_Registro) = -1 Then
			lb_Sucesso = False
			Exit
		End If
		cont_bloco.cont_60++

	End If
		
	If lvds_1.object.vl_isenta[ll_Linha] > 0 Or lvds_1.object.vl_isento_iss[ll_Linha] > 0 Then
		
		ls_Registro  = ls_Padrao
		ls_Registro += 'I   ' + of_Formata_Valor_PafEcf(lvds_1.object.vl_isenta[ll_Linha] + lvds_1.object.vl_isento_iss[ll_Linha],10,2)
		ls_Registro += Space(79)
		
		If FileWrite(pl_arquivo,ls_Registro) = -1 Then
			lb_Sucesso = False
			Exit
		End If
		cont_bloco.cont_60++
	End If

	If lvds_1.object.vl_nao_incidencia[ll_Linha] > 0 Then
		ls_Registro  = ls_Padrao
		ls_Registro += 'N   ' + of_Formata_Valor_PafEcf(lvds_1.object.vl_nao_incidencia[ll_Linha],10,2)
		ls_Registro += Space(79)
		
		If FileWrite(pl_arquivo,ls_Registro) = -1 Then
			lb_Sucesso = False
			Exit
		End If
		cont_bloco.cont_60++
	End If
		
	If lvds_1.object.vl_cancelamento[ll_Linha] > 0 Or lvds_1.object.vl_cancelamento_iss[ll_Linha] > 0 Then
		ls_Registro  = ls_Padrao
		ls_Registro += 'CANC' + of_Formata_Valor_PafEcf(lvds_1.object.vl_cancelamento[ll_Linha] + lvds_1.object.vl_cancelamento_iss[ll_Linha],10,2)
		ls_Registro += Space(79)
		
		If FileWrite(pl_arquivo,ls_Registro) = -1 Then
			lb_Sucesso = False
			Exit
		End If
		cont_bloco.cont_60++
	End If
		
	If lvds_1.object.vl_desconto[ll_Linha] > 0 Or lvds_1.object.vl_desconto_iss[ll_Linha] > 0 Then
		ls_Registro  = ls_Padrao
		ls_Registro += 'DESC' + of_Formata_Valor_PafEcf(lvds_1.object.vl_desconto[ll_Linha] + lvds_1.object.vl_desconto_iss[ll_Linha],10,2)
		ls_Registro += Space(79)
		
		If FileWrite(pl_arquivo,ls_Registro) = -1 Then
			lb_Sucesso = False
			Exit
		End If
		cont_bloco.cont_60++
	End If
Next

Destroy(lvds_1)

Return lb_Sucesso


end function

public function boolean of_pafecf_conv5795_r60d (date pdh_registro, long pl_arquivo);//Vendas do per$$HEX1$$ed00$$ENDHEX$$odo pelo formato Convenio 57/95 registro 10

Boolean lb_Sucesso = False

Decimal{2} ldc_Aux

Long ll_Retorno
Long ll_Linha 

String ls_Registro

dc_uo_ds_base lvds_1
lvds_1 = Create dc_uo_ds_base

//Alterar datawindow
If Not lvds_1.of_ChangeDataObject('dw_ge038_pafecf_sum_item') Then 
	Destroy(lvds_1)
	Return False
End If 

//lvds_1.of_AppendWhere("nf_venda.dh_movimentacao_caixa = '" + String(pdh_Registro,"YYYYMMDD") + "'")
lvds_1.of_AppendWhere("nf_venda.dh_emissao >= '" + String(pdh_Registro, "YYYYMMDD") + "'" + &
							 " AND n_venda.dh_emissao < dbo.adddate('day', 1,'" + String(pdh_Registro, "YYYYMMDD") + "')" + &
							 " AND nf_venda.de_especie = 'CF'" )

ll_Retorno = lvds_1.Retrieve(gvo_Parametro.cd_Filial)

If ll_Retorno <> -1 Then
	
	For ll_Linha = 1 To lvds_1.RowCount()
	
		ls_Registro  = '60D'
		
		ls_Registro += String(pdh_registro,"YYYYMMDD") 
		
		ls_Registro += LeftA(This.nr_Serie + Space(20), 20)
		
		ls_Registro += LeftA(String(lvds_1.Object.cd_produto[ll_Linha]) + Space(14) ,14) 
		
		ls_Registro += String(lvds_1.Object.qt_vendida[ll_Linha],"0000000000") + "000"
		
		ls_Registro += of_Formata_Valor_PafEcf(lvds_1.Object.vl_preco_praticado[ll_Linha],16,0) 
		
		
		ls_Registro += of_Formata_Valor_PafEcf(lvds_1.Object.vl_preco_praticado[ll_Linha],16,0) 
//		If lvds_1.Object.pc_icms[ll_Linha] > 0 Then
//			ls_Registro += of_Formata_Valor_PafEcf(lvds_1.Object.vl_preco_praticado[ll_Linha],14,2) 
//		Else
//			ls_Registro += "0000000000000000"
//		End If
		
		ls_Registro += of_Formata_Valor_PafEcf(lvds_1.Object.pc_icms[ll_Linha],4,0) 
		
		ldc_Aux = lvds_1.Object.vl_preco_praticado[ll_Linha]
		ldc_Aux = ldc_Aux * lvds_1.Object.pc_icms[ll_Linha]
		ls_Registro += of_Formata_Valor_PafEcf(ldc_Aux,13,0)
		
		//Base calculo do ICMS - valor acumulado do dia
		//ls_Registro += Left(lvds_1.Object.vl_preco_pratico[ll_Linha] + Space(16) ,16) 
		
		//Identificador do ST / ICMS 
		//ls_Registro += Left(lvds_1.Object.pc_icms[ll_Linha] + Space(04) ,04) 
		
		//Valor do ICMS - Montante do Imposto
		//ls_Registro += Left(lvds_1.Object.vl_icms[ll_Linha] + Space(13) ,13) 
			
		ls_Registro += Space(19)
	
		If FileWrite(pl_arquivo,ls_Registro) = -1 Then
			lb_Sucesso = False
			Exit
		End If
		cont_bloco.cont_60++
	
	Next
	
	lb_Sucesso = True
	
End If

Destroy(lvds_1)

Return lb_Sucesso


end function

public function boolean of_pafecf_conv5795_r60m (date pdh_registro, long pl_arquivo, long pl_ecf);//Vendas do per$$HEX1$$ed00$$ENDHEX$$odo pelo formato Convenio 57/95 registro 60M - Mestre

Boolean lb_Sucesso = True

Long ll_Retorno
Long ll_Linha 

String ls_Registro

dc_uo_ds_base lvds_1
lvds_1 = Create dc_uo_ds_base

If Not lvds_1.of_ChangeDataObject('dw_ge038_pafecf_reducaoz') Then 
	Destroy(lvds_1)
	Return False
End If 

ll_Retorno = lvds_1.Retrieve(pl_ecf, pdh_Registro, pdh_Registro)

If ll_Retorno <> -1 Then
	For ll_Linha = 1 To lvds_1.RowCount()
		
		ls_Registro  = '60M'
		
		ls_Registro += String(pdh_registro,"YYYYMMDD") 
		
		ls_Registro += LeftA(This.nr_Serie + Space(20), 20)
		
		ls_Registro += LeftA(String(pl_ecf,"000"), 03)
		
		ls_Registro += '2D'
		
		ls_Registro += RightA(String(lvds_1.Object.nr_operacao_inicial[ll_Linha],"000000"),6)
		
		ls_Registro += RightA(String(lvds_1.Object.nr_operacao_final[ll_Linha],"000000"),6)
		
		ls_Registro += RightA(String(lvds_1.Object.qt_reducao_z[ll_Linha],"000000"),6)
		
		ls_Registro += RightA(String(lvds_1.Object.qt_reinicio_z[ll_Linha],"000"),3)
		
		ls_Registro += of_Formata_Valor_PafEcf(lvds_1.Object.vl_total_geral_final[ll_Linha] - lvds_1.Object.vl_total_geral_inicial[ll_Linha],14,2)
		
		ls_Registro += RightA(String(lvds_1.Object.vl_total_geral_final[ll_Linha],"0000000000000000"),16)
		
		ls_Registro += Space(37)
	
		If FileWrite(pl_arquivo,ls_Registro) = -1 Then
			lb_Sucesso = False
			Exit
		End If
		cont_bloco.cont_60++
	
	Next
	
End If

Destroy(lvds_1)

Return lb_Sucesso


end function

public function boolean of_pafecf_conv5795_r60r (date pdh_inicial, date pdh_final, long pl_arquivo);//Vendas do per$$HEX1$$ed00$$ENDHEX$$odo pelo formato Convenio 57/95 registro 10

Boolean lb_Sucesso = False

Decimal{2} ldc_Aux

Long ll_Retorno
Long ll_Linha 

String ls_Registro

dc_uo_ds_base lvds_1
lvds_1 = Create dc_uo_ds_base

//Alterar datawindow
If Not lvds_1.of_ChangeDataObject('dw_ge038_pafecf_sum_item') Then 
	Destroy(lvds_1)
	Return False
End If 

//lvds_1.of_AppendWhere("nf_venda.dh_movimentacao_caixa >= '" + String(pdh_Inicial,"YYYYMMDD") + "'")
//lvds_1.of_AppendWhere("nf_venda.dh_movimentacao_caixa <= '" + String(pdh_Final,"YYYYMMDD") + "'")
lvds_1.of_AppendWhere("nf_venda.dh_emissao >= '" + String(pdh_inicial, "YYYYMMDD") + "'" + &
							 " AND nf_venda.dh_emissao < dbo.adddate('day', 1,'" + String(pdh_final, "YYYYMMDD") + "')" + &
 							 " AND nf_venda.de_especie = 'CF'")

ll_Retorno = lvds_1.Retrieve(gvo_Parametro.cd_Filial)

If ll_Retorno <> -1 Then
	
	For ll_Linha = 1 To lvds_1.RowCount()
	
		ls_Registro  = '60R'
		
		ls_Registro += String(pdh_Inicial,"MMYYYY") 
		
		ls_Registro += LeftA(String(lvds_1.Object.cd_produto[ll_Linha]) + Space(14) ,14) 
		
		ls_Registro += String(lvds_1.Object.qt_vendida[ll_Linha],"0000000000") + "000"
		
		ls_Registro += of_Formata_Valor_PafEcf(lvds_1.Object.vl_preco_praticado[ll_Linha],16,0) 
		
		If lvds_1.Object.pc_icms[ll_Linha] > 0 Then
			ls_Registro += of_Formata_Valor_PafEcf(lvds_1.Object.vl_preco_praticado[ll_Linha],16,0) 
			ls_Registro += of_Formata_Valor_PafEcf(lvds_1.Object.pc_icms[ll_Linha],4,0) 
		Else
			ls_Registro += "0000000000000000"
			ls_Registro += "N   "
		End If
			
		ls_Registro += Space(54)
	
		If FileWrite(pl_arquivo,ls_Registro) = -1 Then
			lb_Sucesso = False
			Exit
		End If
		cont_bloco.cont_60++
	
	Next
	
	lb_Sucesso = True
	
End If

Destroy(lvds_1)

Return lb_Sucesso


end function

public function boolean of_pafecf_conv5795_r75 (date pdh_inicial, date pdh_final, long pl_arquivo);//Vendas do per$$HEX1$$ed00$$ENDHEX$$odo pelo formato Convenio 57/95 registro 10

Boolean lb_Sucesso = True

Long ll_Retorno
Long ll_Linha 

String ls_Registro

dc_uo_ds_base lvds_1
lvds_1 = Create dc_uo_ds_base

//Notas fiscais
If Not lvds_1.of_ChangeDataObject('dw_ge038_pafecf_sum_item') Then 
	Destroy(lvds_1)
	Return False
End If 

//lvds_1.of_AppendWhere(" nf_venda.dh_movimentacao_caixa >= '" + String(pdh_Inicial,"YYYYMMDD") + "'")
//lvds_1.of_AppendWhere(" nf_venda.dh_movimentacao_caixa <= '" + String(pdh_Final	,"YYYYMMDD") + "'")
lvds_1.of_AppendWhere("nf_venda.dh_emissao >= '" + String(pdh_inicial, "YYYYMMDD") + "'" + &
							 " AND nf_venda.dh_emissao < dbo.adddate('day', 1,'" + String(pdh_final, "YYYYMMDD") + "')" + &
 							 " AND (nf_venda.de_especie = 'CF' OR nf_venda.de_especie = 'NF')")


ll_Retorno = lvds_1.Retrieve(gvo_Parametro.cd_Filial)

If ll_Retorno <> -1 Then
	
	For ll_Linha = 1 To lvds_1.RowCount()
		ls_Registro  = '75'
		
		ls_Registro += String(pdh_Inicial,"YYYYMMDD")
		
		ls_Registro += String(pdh_Final	,"YYYYMMDD")
		
		ls_Registro += LeftA(String(lvds_1.Object.cd_produto[ll_Linha]) + Space(14) ,14) 
		
		ls_Registro += LeftA(String(lvds_1.Object.nr_classificacao_fiscal[ll_Linha]) + Space(08) ,08) 
		
		ls_Registro += LeftA(lvds_1.Object.desc_produto				 	[ll_Linha] + Space(53) ,53) 
		
		ls_Registro += LeftA(lvds_1.Object.cd_un[ll_Linha] + Space(06) ,06)
		
		//IPI
		ls_Registro += "00000"
			
		ls_Registro += of_Formata_Valor_PafEcf(lvds_1.Object.pc_icms[ll_Linha],2,2)
		
		//Redu$$HEX2$$e700e300$$ENDHEX$$o Base de Calculo ICMS
		ls_Registro += "00000"
		
		//Base de calculo ICMS ST
		ls_Registro += "0000000000000"

		If FileWrite(pl_arquivo,ls_Registro) = -1 Then
			lb_Sucesso = False
			Exit
		End If
		cont_bloco.cont_75++
		
		lb_Sucesso = True
		
	Next
	
End If

Destroy(lvds_1)

Return lb_Sucesso


end function

public function boolean of_pafecf_ac0908_bloco_c (date pdh_inicial, date pdh_final, long pl_arquivo, long pl_ecf);//Vendas do per$$HEX1$$ed00$$ENDHEX$$odo pelo formato Ato Cotepe 09/08 bloco C
Boolean lb_Sucesso = True

Decimal{2} ldc_Aux
Decimal{2} ldc_Aux2
Decimal{2} ldc_Produto
Decimal{2} ldc_pc_desconto
Decimal{2} ldc_preco_comdesconto

Date ldh_Aux
Date ldh_nota

Long ll_Retorno
Long ll_Linha
Long ll_Linha2
Long ll_Linha3
Long ll_Nota
Long ll_Contador

String ls_Registro
String ls_Aux
String ls_ChaveNfe
String ls_Serie
String ls_especie
String ls_CST

Boolean lb_Cancelado

dc_uo_ds_base lvds_1
lvds_1 = Create dc_uo_ds_base

dc_uo_ds_base lvds_2
dc_uo_ds_base lvds_3

If Not lvds_1.of_ChangeDataObject('dw_ge038_pafecf_nota_fiscal') Then 
	Destroy(lvds_1)
	Return False
End If 

ll_Retorno = lvds_1.Retrieve(pdh_Inicial, pdh_Final)

If ll_Retorno <> -1 Then
	
	//BLOCO C - registro C001
	
	//Fixo, indica Bloco C, registro C001
	ls_Registro  = '|C001|'
		
	//Vers$$HEX1$$e300$$ENDHEX$$o do layout conforme tabela do Ato Cotepe
	If ll_Retorno > 0 Then
		ls_Registro  += '0|'
	Else
		ls_Registro  += '1|'
	End If
	
	If FileWrite(pl_arquivo,ls_Registro) = -1 Then	
		Destroy(lvds_1)
		Return False
	End If
	ll_Contador++
	
	// C 1 0 0
	
	For ll_Linha = 1 To lvds_1.RowCount()		
		ll_Nota 		= lvds_1.Object.nr_nf[ll_Linha]
		ls_especie 	= lvds_1.Object.de_especie[ll_Linha]
		ls_serie 		= lvds_1.Object.de_serie[ll_Linha]
		
		//Fixo, indica Bloco C, registro C100
		ls_Registro  = '|C100|'
		
		//Tipo de opera$$HEX2$$e700e300$$ENDHEX$$o (0,1) (Entrada,Saida)
		ls_Registro  += '1|'
		
		//Emitente do documento fiscal (0,1) (Emissao Propria, terceiros)
		ls_Registro  += '0|'
		
		//Codigo do participante (Campo 2 do registro 0150, bloco 0)
		ls_Registro  += '104538|'
		
		//Codigo do documento fiscal
		//2014.08.15 - Marlon 
		//ls_Registro  += '01|'
		Select Coalesce(de_chave_acesso,'')
		Into :ls_ChaveNfe
		From nf_venda_nfe
		Where nr_nf = :ll_Nota
		And de_especie = :ls_especie
		And de_serie = :ls_Serie
		Using SQLCa;
		
		If ls_ChaveNfe<>'' Then
			If ls_especie = 'NFE' Then				
				ls_Registro  += '55|'
			Else
				ls_Registro  += '65|'				
			End If			
		Else
			ls_Registro  += '01|'	
		End If
		
		//Codigo da situa$$HEX2$$e700e300$$ENDHEX$$o do documento
		lb_Cancelado = ((Not IsNull(lvds_1.Object.dh_cancelamento[ll_linha])) Or (Not IsNull(lvds_1.Object.id_cancelamento_impressora[ll_Linha])) Or lvds_1.Object.id_cancelamento_impressora[ll_Linha] = 'S')
		If lb_Cancelado Then
			ls_Registro  += '02|'
		Else
			ls_Registro  += '00|'
		End If
		
		//Numero de Serie
		ls_Serie = lvds_1.Object.de_serie[ll_Linha]
		ls_Registro  += LeftA(lvds_1.Object.de_serie[ll_Linha],3) + "|"
		
		//Numero do documento
		ls_Registro  += LeftA(String(ll_Nota),9) + "|"

		//2014.08.15 - Marlon
		If Not(lb_Cancelado) Then
			//Chave NFe		
			//2014.08.15 - Marlon
			ls_Registro  += ls_ChaveNfe+"|"
			
			//Data de emiss$$HEX1$$e300$$ENDHEX$$o
			ls_Registro  += String(lvds_1.Object.dh_emissao[ll_Linha],"DDMMYYYY") + "|"
			
			//Data Entrada e Saida
			ldh_nota = Date(lvds_1.Object.dh_movimentacao_caixa[ll_Linha])			
//			ls_Registro  += String(lvds_1.Object.dh_movimentacao_caixa[ll_Linha],"DDMMYYYY") + "|"
			ls_Registro  += String(lvds_1.Object.dh_emissao[ll_Linha],"DDMMYYYY") + "|"			
			
			//Valor documento
			ls_Registro  += String(lvds_1.Object.vl_total_nf[ll_Linha]) + "|"
			
			//Forma de pagamento (0 - A vista)
			ls_Registro  += "0|"
			
			//Valor total do desconto
			ldc_Aux			= lvds_1.Object.vl_total_nf[ll_Linha]
			ldc_Aux2	= lvds_1.Object.vl_total_nf_bruto[ll_Linha]
			If IsNull(ldc_Aux) Then ldc_Aux = 0.00
			If IsNull(ldc_Aux2) Then ldc_Aux2 = 0.00
			If ldc_Aux2 = 0.00 Then ldc_Aux2 = ldc_Aux
			ls_Registro  += String(Round(ldc_Aux2 - ldc_Aux,2)) + "|"
			
			//Valor abatimento n$$HEX1$$e300$$ENDHEX$$o tributado
			ls_Registro += "0,00|"
			
	
			//Valor total produtos
			ldc_Aux = lvds_1.Object.vl_total_produtos[ll_Linha]
			ldc_Produto = lvds_1.Object.vl_total_produtos[ll_Linha]
			ls_Registro += String(Round(ldc_Aux,2)) + "|"
			
			//Indicador do frete (1 - Por conta do emitente)
			ls_Registro += "1|"
			
			//Valor do frete
			ls_Registro += "0,00|"
			
			//Valor do seguro
			ls_Registro += "0,00|"
			
			//Valor de outras dispesas
			ls_Registro += "0,00|"
							
			//Valor bc icms
			ldc_Aux = lvds_1.Object.vl_bc_icms[ll_Linha]
			ls_Registro += String(Round(ldc_Aux,2)) + "|"
			
			//Valor icms
			ldc_Aux = lvds_1.Object.vl_icms[ll_Linha]
			ls_Registro += String(ldc_Aux,"##0.00") + "|"
			
			//Valor bc icms st
			ldc_Aux = lvds_1.Object.vl_bc_icms_st[ll_Linha]
			ls_Registro += String(ldc_Aux,"##0.00") + "|"
			
			//Valor icms st
			ldc_Aux = lvds_1.Object.vl_icms_st[ll_Linha]
			ls_Registro += String(ldc_Aux,"##0.00") + "|"
			
			//Valor ipi
			ls_Registro += "0,00|"
			
			//Valor pis
			ls_Registro += "0,00|"
			
			//Valor cofins
			ls_Registro += "0,00|"
			
			//Valor pis st
			ls_Registro += "0,00|"
			
			//Valor confis st
			ls_Registro += "0,00|"
		Else
			//Chave NFe		
			ls_Registro  += "|"
			
			//Data de emiss$$HEX1$$e300$$ENDHEX$$o
			ls_Registro  += "|"
			
			//Data Entrada e Saida
			ls_Registro  += "|"
			
			//Valor documento
			ls_Registro  += "|"
			
			//Forma de pagamento (0 - A vista)
			ls_Registro  += "|"
			
			//Valor total do desconto
			ls_Registro  += "|"
			
			//Valor abatimento n$$HEX1$$e300$$ENDHEX$$o tributado
			ls_Registro += "|"
			
			//Valor total produtos
			ls_Registro +=  "|"
			
			//Indicador do frete (1 - Por conta do emitente)
			ls_Registro += "|"
			
			//Valor do frete
			ls_Registro += "|"
			
			//Valor do seguro
			ls_Registro += "|"
			
			//Valor de outras dispesas
			ls_Registro += "|"
							
			//Valor bc icms
			ls_Registro += "|"
			
			//Valor icms
			ls_Registro += "|"
			
			//Valor bc icms st
			ls_Registro += "|"
			
			//Valor icms st
			ls_Registro += "|"
			
			//Valor ipi
			ls_Registro += "|"
			
			//Valor pis
			ls_Registro += "|"
			
			//Valor cofins
			ls_Registro += "|"
			
			//Valor pis st
			ls_Registro += "|"
			
			//Valor confis st
			ls_Registro += "|"
		End If
		
		If FileWrite(pl_arquivo,ls_Registro) = -1 Then
			lb_Sucesso = False
			Exit
		End If
		ll_Contador++
		cont_Bloco.cont_c100++
		
		If Trim(ls_especie) = 'NF' Then
			ivb_registros170 = True
			// C 1 7 0			
			
			lvds_2 = Create dc_uo_ds_base
			
			If Not lvds_2.of_ChangeDataObject('dw_ge038_pafecf_item_nota_fiscal') Then 
				Destroy(lvds_1)
				Destroy(lvds_2)
				Return False
			End If 
					
			lvds_2.of_AppendWhere("nf_venda.nr_nf = " + String(ll_Nota) + " and nf_venda.de_especie = '" + ls_especie + "' and nf_venda.de_serie = '" + ls_serie + "'")
			
			ll_Retorno = lvds_2.Retrieve(gvo_Parametro.cd_Filial)
	
			If ll_Retorno <> -1 Then
				For ll_Linha2 = 1 To lvds_2.RowCount()
					//Fixo, indica Bloco C, registro C170
					ls_Registro  = '|C170|'
					
					//Sequencial do item na nota
					ls_Registro  += String(ll_Linha2) + '|'
					
					//Codigo do item
					ls_Registro  += LeftA(String(lvds_2.Object.cd_produto[ll_Linha2]),60) + '|'
					
					//Descri$$HEX2$$e700e300$$ENDHEX$$o do item
					ls_Registro  += lvds_2.Object.de_produto[ll_Linha2] + '|'
					
					//Codigo do produto
					ldc_Aux = lvds_2.Object.qt_vendida[ll_Linha2]
					ls_Registro  += String(Round(ldc_Aux,5))  + '|'
					
					//Unidade de medida
					ls_Registro  += lvds_2.Object.cd_un[ll_Linha2] + '|'
					
					//Valor total do item
					ldc_Aux = lvds_2.Object.vl_preco_praticado[ll_Linha2]
					ls_Registro  += String(Round(ldc_Aux,2))  + '|'
					
					//Valor total desconto
					ldc_Aux  = lvds_2.Object.vl_preco_praticado[ll_Linha2]
					ldc_Aux2 = lvds_2.Object.vl_preco_unitario[ll_Linha2]
					ls_Registro  += String(ldc_Aux2 - ldc_Aux,"###0.00")  + '|'
					
					//Movimenta$$HEX2$$e700e300$$ENDHEX$$o Fisica do item (0 - SIM)
					ls_Registro  += "0|"
					
					//Codigo situacao tributaria
					ls_CST = LeftA(lvds_2.Object.cd_situacao_tributaria[ll_Linha2] + "000",3)
					ls_Registro  += LeftA(lvds_2.Object.cd_situacao_tributaria[ll_Linha2] + "000",3) + '|'
					
					//Codigo Fiscal de operacao e prestacao
					ls_Registro  += LeftA(String(lvds_2.Object.cd_natureza_operacao[ll_Linha2]),5) + '|'
					
					//Codigo natureza de operacao (Fixo: 50 - Venda consumidor final)
					ls_Registro  += "0000000050|"
					
					//Vl bc icms
					If lvds_2.Object.pc_icms[ll_Linha2] > 0 Then
						ldc_Aux  = lvds_2.Object.vl_preco_praticado[ll_Linha2]
						ldc_Aux2 = lvds_2.Object.qt_vendida[ll_Linha2]
						//Quantidade x preco
						ldc_Aux	= ldc_Aux * ldc_Aux2
						ls_Registro  += String(ldc_Aux) + "|"
					Else
						ls_Registro  += "0,00|"
					End If
					
					//Aliquota icms
					//Percentual icms para calcular o valor posteriormente
					ldc_Aux2	= lvds_2.Object.pc_icms[ll_Linha2]
					ls_Registro  += String(ldc_Aux2,"##0.00") + "|"
					
					//Vl icms
					ldc_Aux2 = (ldc_Aux2*0.01) * ldc_Aux
					ls_Registro  += String(ldc_Aux2,"##0.00") + "|"
					
					//Vl bc icms st
					ls_Registro  += "0,00|"
					
					//Aliquota st
					ls_Registro  += "0,00|"
					
					//Vl icms st
					ls_Registro  += "0,00|"
					
					//Indicador de per$$HEX1$$ed00$$ENDHEX$$odo de apura$$HEX2$$e700e300$$ENDHEX$$o do IPI (0 - Mensal)
					ls_Registro  += "0|"
					
					//Codigo ST do IPI
					ls_Registro  += "99|"
					
					//Codigo enquadramento do IPI
					ls_Registro  += "|"
					
					//Valor bc IPI
					ls_Registro  += "0,00|"
									
					//Aliquota IPI
					ls_Registro  += "0,00|"
					
					//Valor IPI
					ls_Registro  += "0,00|"
					
					//Codigo da Situa$$HEX2$$e700e300$$ENDHEX$$o tributaria PIS
					ls_Registro  += "99|"
					
					//Valor bc PIS
					ls_Registro  += "0,00|"
					
					//Aliquota PIS (em Percentual)
					ls_Registro  += "0,00|"
					
					//Quantidade bc PIS
					ls_Registro  += "0,000|"
					
					//Aliquota PIS (em Reais)
					ls_Registro  += "0,0000|"
					
					//Valor PIS
					ls_Registro  += "0,00|"
					
					//Codigo da Situa$$HEX2$$e700e300$$ENDHEX$$o tributaria CONFINS
					ls_Registro  += "99|"
					
					//Valor bc CONFINS
					ls_Registro  += "0,00|"				
					
					//Aliquota CONFINS (em Percentual)
					ls_Registro  += "0,00|"
					
					//Quantidade bc CONFINS
					ls_Registro  += "0,000|"
					
					//Aliquota CONFINS (em Reais)
					ls_Registro  += "0,0000|"
					
					//Valor CONFINS
					ls_Registro  += "0,00|"
					
					//Codigo conta analitica contabil
					ls_Registro  += "|"
					
					If FileWrite(pl_arquivo,ls_Registro) = -1 Then
						lb_Sucesso = False
						Exit
					End If
					ll_Contador++
					cont_Bloco.cont_c170++
	
					If ls_CST = '060' Then
						// C 1 7 6 
						//REG 
						ls_Registro  = '|C176|'
						
						//COD_MOD_ULT_E
						ls_Registro  += "55|"
						
						//N$$HEX1$$fa00$$ENDHEX$$mero do documento fiscal ultima entrada
						ls_Registro  += String(ll_Nota)+"0|"
						
						//SER_ULT_E 
						ls_Registro  += "001|"
						
						//DT_ULT_E 
						ls_Registro  += String(RelativeDate(ldh_nota,-2),'ddmmyyyy')+"|"
						
						//COD_PART_ULT_E
						ls_Registro  += "104538|"
						
						//QUANT_ULT_E
						ls_Registro  += "5|"
						
						//VL_UNIT_ULT_E
						ls_Registro  += String(Round(ldc_Produto * 0.70,2))+"|"
						
						//VL_UNIT_BC_ST 
						ls_Registro  += String(Round(ldc_Produto * 0.95,2))+"|"
						
						If FileWrite(pl_arquivo,ls_Registro) = -1 Then
							lb_Sucesso = False
							Exit
						End If
						cont_Bloco.cont_c176++
						ll_Contador++
						
					End If			
				Next
				
			End If
			
			Destroy(lvds_2)
			
			If Not lb_Sucesso Then
				Exit
			End If
		End If		
		
		// C 1 9 0
		
		lvds_2 = Create dc_uo_ds_base
		
		If Not lvds_2.of_ChangeDataObject('dw_ge038_pafecf_sum_nota') Then 
			Destroy(lvds_1)
			Destroy(lvds_2)
			Return False
		End If 
		
		lvds_2.of_AppendWhere("i.de_especie = '" + ls_especie + "' and i.de_serie = '" + ls_serie + "'")		
		
		ll_Retorno = lvds_2.Retrieve(ll_Nota, gvo_Parametro.cd_Filial)

		If ll_Retorno <> -1 Then	
			For ll_Linha2 = 1 To lvds_2.RowCount()		
				//Fixo, indica Bloco C, registro C100
				ls_Registro  = '|C190|'
				
				//Codigo situacao tributaria
				ls_Aux = LeftA(lvds_2.Object.cd_situacao_tributaria[ll_Linha2] + "000",3)
				ls_Registro  += ls_Aux + '|'
				
				//Codigo natureza operacao
				ls_Registro  += LeftA(String(lvds_2.Object.cd_natureza_operacao[ll_Linha2]) ,4) + '|'
				
				//Aliquota ICMS
				ldc_Aux = lvds_2.Object.pc_icms[ll_Linha2]
				ls_Registro  += String(ldc_Aux,"#####0.00") + '|'
				
				//Valor total bruto
				ls_Registro  += String(lvds_2.Object.vl_preco_unitario[ll_Linha2],"##0.00") + '|'
				
				//Valor bc icms
				If (ldc_Aux > 0) Then
					ls_Registro  += String(lvds_2.Object.vl_bc_icms[ll_Linha2],"##0.00") + '|'
				Else
					ls_Registro  += "0,00|"
				End IF
				
				//Valor icms
				ls_Registro  += String(lvds_2.Object.vl_icms[ll_Linha2],"##0.00") + '|'
				
				//Valor bc icms st
				ls_Registro  += "0,00|"
				
				//Valor icms st
				ls_Registro  += "0,00|"
				
				//Valor redu$$HEX2$$e700e300$$ENDHEX$$o bc
				If ls_Aux = "020" Or ls_Aux = "070" Then
					ls_Registro  += String(lvds_2.Object.vl_bc_icms[ll_Linha2],"##0.00") + '|'
				Else
					ls_Registro  += "0,00|"
				End If
				
				//Valor IPI / Codigo da observa$$HEX2$$e700e300$$ENDHEX$$o do lan$$HEX1$$e700$$ENDHEX$$amento fiscal Registro 0460
				ls_Registro  += "0,00||"
			
				If FileWrite(pl_arquivo,ls_Registro) = -1 Then
					lb_Sucesso = False
					Exit
				End If
				ll_Contador++
				cont_Bloco.cont_c190++
			Next
		End If
		
		Destroy(lvds_2)
		
		If Not lb_Sucesso Then
			Exit
		End If
		
		ls_ChaveNfe = ''
	Next	
		
End If

Destroy(lvds_1)

//INICIO Nota devolucao venda

dc_uo_ds_base lvds_4
lvds_4 = Create dc_uo_ds_base

If Not lvds_4.of_ChangeDataObject('dw_ge038_pafecf_nota_fiscal_dev') Then 
	Destroy(lvds_4)
	Return False
End If 

ll_Retorno = lvds_4.Retrieve(pdh_Inicial, pdh_Final)

If ll_Retorno <> -1 Then
	
	// C 1 0 0  DEVOLUCAO
	
	For ll_Linha = 1 To lvds_4.RowCount()		
		ll_Nota 		= lvds_4.Object.nr_nf[ll_Linha]
		ls_especie 	= lvds_4.Object.de_especie[ll_Linha]
		ls_serie 		= lvds_4.Object.de_serie[ll_Linha]
		
		//Fixo, indica Bloco C, registro C100
		ls_Registro  = '|C100|'
		
		//Tipo de opera$$HEX2$$e700e300$$ENDHEX$$o (0,1) (Entrada,Saida)
		ls_Registro  += '1|'
		
		//Emitente do documento fiscal (0,1) (Emissao Propria, terceiros)
		ls_Registro  += '0|'
		
		//Codigo do participante (Campo 2 do registro 0150, bloco 0)
		ls_Registro  += '104538|'
		
		//Codigo do documento fiscal
		//2014.08.15 - Marlon 
		//ls_Registro  += '01|'
		Select Coalesce(de_chave_acesso,'')
		Into :ls_ChaveNfe
		From nf_devolucao_venda_nfe
		Where nr_nf = :ll_Nota
		And de_especie = :ls_especie
		And de_serie = :ls_Serie
		Using SQLCa;
		
		If ls_ChaveNfe<>'' Then
			If ls_especie = 'NFE' Then				
				ls_Registro  += '55|'
			Else
				ls_Registro  += '65|'				
			End If			
		Else
			ls_Registro  += '01|'	
		End If
		
		//Codigo da situa$$HEX2$$e700e300$$ENDHEX$$o do documento
		lb_Cancelado = (Not IsNull(lvds_4.Object.dh_cancelamento[ll_linha]))
		If lb_Cancelado Then
			ls_Registro  += '02|'
		Else
			ls_Registro  += '00|'
		End If
		
		//Numero de Serie
		ls_Serie = lvds_4.Object.de_serie[ll_Linha]
		ls_Registro  += LeftA(lvds_4.Object.de_serie[ll_Linha],3) + "|"
		
		//Numero do documento
		ls_Registro  += LeftA(String(ll_Nota),9) + "|"

		//2014.08.15 - Marlon
		If Not(lb_Cancelado) Then
			//Chave NFe		
			//2014.08.15 - Marlon
			ls_Registro  += ls_ChaveNfe+"|"
			
			//Data de emiss$$HEX1$$e300$$ENDHEX$$o
			ls_Registro  += String(lvds_4.Object.dh_recebimento[ll_Linha],"DDMMYYYY") + "|"
			
			//Data Entrada e Saida
			ldh_nota = Date(lvds_4.Object.dh_movimentacao_caixa[ll_Linha])			
//			ls_Registro  += String(lvds_4.Object.dh_movimentacao_caixa[ll_Linha],"DDMMYYYY") + "|"
			ls_Registro  += String(lvds_4.Object.dh_recebimento[ll_Linha],"DDMMYYYY") + "|"			
			
			//Valor documento
			ls_Registro  += String(lvds_4.Object.vl_total_nf[ll_Linha]) + "|"
			
			//Forma de pagamento (0 - A vista)
			ls_Registro  += "0|"
			
			//Valor total do desconto
			ldc_Aux			= lvds_4.Object.vl_total_nf[ll_Linha]
			ldc_Aux2	= lvds_4.Object.vl_total_nf_bruto[ll_Linha]
			If IsNull(ldc_Aux) Then ldc_Aux = 0.00
			If IsNull(ldc_Aux2) Then ldc_Aux2 = 0.00
			If ldc_Aux2 = 0.00 Then ldc_Aux2 = ldc_Aux
			ls_Registro  += String(Round(ldc_Aux2 - ldc_Aux,2)) + "|"
			
			//Valor abatimento n$$HEX1$$e300$$ENDHEX$$o tributado
			ls_Registro += "0,00|"			
	
			//Valor total produtos
			ldc_Aux = lvds_4.Object.vl_total_produtos[ll_Linha]
			ldc_Produto = lvds_4.Object.vl_total_produtos[ll_Linha]
			ls_Registro += String(Round(ldc_Aux,2)) + "|"
			
			//Indicador do frete (1 - Por conta do emitente)
			ls_Registro += "1|"
			
			//Valor do frete
			ls_Registro += "0,00|"
			
			//Valor do seguro
			ls_Registro += "0,00|"
			
			//Valor de outras dispesas
			ls_Registro += "0,00|"
							
			//Valor bc icms
			ldc_Aux = lvds_4.Object.vl_bc_icms[ll_Linha]
			ls_Registro += String(Round(ldc_Aux,2)) + "|"
			
			//Valor icms
			ldc_Aux = lvds_4.Object.vl_icms[ll_Linha]
			ls_Registro += String(ldc_Aux,"##0.00") + "|"
			
			//Valor bc icms st
			ldc_Aux = lvds_4.Object.vl_bc_icms_st[ll_Linha]
			ls_Registro += String(ldc_Aux,"##0.00") + "|"
			
			//Valor icms st
			ldc_Aux = lvds_4.Object.vl_icms_st[ll_Linha]
			ls_Registro += String(ldc_Aux,"##0.00") + "|"
			
			//Valor ipi
			ls_Registro += "0,00|"
			
			//Valor pis
			ls_Registro += "0,00|"
			
			//Valor cofins
			ls_Registro += "0,00|"
			
			//Valor pis st
			ls_Registro += "0,00|"
			
			//Valor confis st
			ls_Registro += "0,00|"
		Else
			//Chave NFe		
			ls_Registro  += "|"
			
			//Data de emiss$$HEX1$$e300$$ENDHEX$$o
			ls_Registro  += "|"
			
			//Data Entrada e Saida
			ls_Registro  += "|"
			
			//Valor documento
			ls_Registro  += "|"
			
			//Forma de pagamento (0 - A vista)
			ls_Registro  += "|"
			
			//Valor total do desconto
			ls_Registro  += "|"
			
			//Valor abatimento n$$HEX1$$e300$$ENDHEX$$o tributado
			ls_Registro += "|"
			
			//Valor total produtos
			ls_Registro +=  "|"
			
			//Indicador do frete (1 - Por conta do emitente)
			ls_Registro += "|"
			
			//Valor do frete
			ls_Registro += "|"
			
			//Valor do seguro
			ls_Registro += "|"
			
			//Valor de outras dispesas
			ls_Registro += "|"
							
			//Valor bc icms
			ls_Registro += "|"
			
			//Valor icms
			ls_Registro += "|"
			
			//Valor bc icms st
			ls_Registro += "|"
			
			//Valor icms st
			ls_Registro += "|"
			
			//Valor ipi
			ls_Registro += "|"
			
			//Valor pis
			ls_Registro += "|"
			
			//Valor cofins
			ls_Registro += "|"
			
			//Valor pis st
			ls_Registro += "|"
			
			//Valor confis st
			ls_Registro += "|"
		End If
		
		If FileWrite(pl_arquivo,ls_Registro) = -1 Then
			lb_Sucesso = False
			Exit
		End If
		ll_Contador++
		cont_Bloco.cont_c100++		
		
		dc_uo_ds_base lvds_5
		lvds_5 = Create dc_uo_ds_base		
		
		If Not lvds_5.of_ChangeDataObject('dw_ge038_pafecf_sum_nota_dev') Then 
			Destroy(lvds_4)
			Destroy(lvds_5)
			Return False
		End If 
		
		lvds_5.of_AppendWhere("i.de_especie = '" + ls_especie + "' and i.de_serie = '" + ls_serie + "'")		
		
		ll_Retorno = lvds_5.Retrieve(ll_Nota, gvo_Parametro.cd_Filial)

		If ll_Retorno <> -1 Then	
			For ll_Linha2 = 1 To lvds_5.RowCount()		
				//Fixo, indica Bloco C, registro C100
				ls_Registro  = '|C190|'
				
				//Codigo situacao tributaria
				ls_Aux = LeftA(lvds_5.Object.cd_situacao_tributaria[ll_Linha2] + "000",3)
				ls_Registro  += ls_Aux + '|'
				
				//Codigo natureza operacao
				ls_Registro  += LeftA(String(lvds_5.Object.cd_natureza_operacao[ll_Linha2]) ,4) + '|'
				
				//Aliquota ICMS
				ldc_Aux = lvds_5.Object.pc_icms[ll_Linha2]
				ls_Registro  += String(ldc_Aux,"#####0.00") + '|'
				
				//Valor total bruto
				ls_Registro  += String(lvds_5.Object.vl_preco_unitario[ll_Linha2],"##0.00") + '|'
				
				//Valor bc icms
				If (ldc_Aux > 0) Then
					ls_Registro  += String(lvds_5.Object.vl_bc_icms[ll_Linha2],"##0.00") + '|'
				Else
					ls_Registro  += "0,00|"
				End IF
				
				//Valor icms
				ls_Registro  += String(lvds_5.Object.vl_icms[ll_Linha2],"##0.00") + '|'
				
				//Valor bc icms st
				ls_Registro  += "0,00|"
				
				//Valor icms st
				ls_Registro  += "0,00|"
				
				//Valor redu$$HEX2$$e700e300$$ENDHEX$$o bc
				If ls_Aux = "020" Or ls_Aux = "070" Then
					ls_Registro  += String(lvds_5.Object.vl_bc_icms[ll_Linha2],"##0.00") + '|'
				Else
					ls_Registro  += "0,00|"
				End If
				
				//Valor IPI / Codigo da observa$$HEX2$$e700e300$$ENDHEX$$o do lan$$HEX1$$e700$$ENDHEX$$amento fiscal Registro 0460
				ls_Registro  += "0,00||"
			
				If FileWrite(pl_arquivo,ls_Registro) = -1 Then
					lb_Sucesso = False
					Exit
				End If
				ll_Contador++
				cont_Bloco.cont_c190++
			Next
		End If
		
		Destroy(lvds_5)
		
		If Not lb_Sucesso Then
			Exit
		End If
		
		ls_ChaveNfe = ''
	Next		
End If

Destroy(lvds_4)

//FIM nota devolucao	
	
	
//C 4 0 0 - Cupom fiscal

lvds_1 = Create dc_uo_ds_base

If Not lvds_1.of_ChangeDataObject('dw_ge038_pafecf_reducaoz') Then 
	Destroy(lvds_1)
	Return False
End If 

ll_Retorno = lvds_1.Retrieve(pl_ecf, pdh_Inicial, pdh_Final)

If ll_Retorno <> -1 Then
	If ll_Retorno > 0 Then
		// C 4 0 0 
	
		//Fixo, indica Bloco C, registro C400
		ls_Registro  = '|C400|'
		
		//Codigo do modelo do documento fiscal
		ls_Registro  += '2D|'
		
		//Modelo do ECF
		ls_Registro  += LeftA(This.de_modelo,20) + '|'
		
		//Serie do ECF
		ls_Registro  += LeftA(This.nr_Serie,20) + '|'
		
		//Numero do ECF
		ls_Registro  += LeftA(String(pl_ecf),3) + '|'
		
		If FileWrite(pl_arquivo,ls_Registro) = -1 Then
			Destroy(lvds_1)
			Return False
		End If
		ll_Contador++
		cont_Bloco.cont_c400++
	End If	
	
	// C 4 0 5 
	
	For ll_Linha = 1 To lvds_1.RowCount()	
		//Fixo, indica Bloco C, registro C450
		ls_Registro  = '|C405|'
		
		//Data do movimento da RZ
		ldh_Aux = Date(lvds_1.Object.dh_Movimento[ll_Linha])
		ls_Registro  += String(ldh_Aux,"DDMMYYYY") + "|"
		
		//Contador de reinicio de operacao
		ls_Registro  += LeftA(String(lvds_1.Object.qt_reinicio_z[ll_Linha]),3) + "|"
		
		//Contador de reinicio Z
		ls_Registro  += LeftA(String(lvds_1.Object.qt_reducao_z[ll_Linha]),6) + "|"
		
		//COO Final
		ls_Registro  += LeftA(String(lvds_1.Object.nr_operacao_final[ll_Linha]),6) + "|"
		
		//Valor GT Final
		ls_Registro  += String(lvds_1.Object.vl_total_geral_final[ll_Linha]) + "|"
		
		//Valor venda bruta
		ldc_Aux = lvds_1.Object.vl_total_geral_final  [ll_Linha]
		ldc_Aux2 = lvds_1.Object.vl_total_geral_inicial[ll_Linha]
		ldc_Aux = ldc_Aux - ldc_Aux2
		ls_Registro  += String(ldc_Aux) + "|"
		
		If FileWrite(pl_arquivo,ls_Registro) = -1 Then
			lb_Sucesso = False
			Exit
		End If
		ll_Contador++
		cont_Bloco.cont_c405++
		
		
		
		// C 4 2 0
		
		lvds_2 = Create dc_uo_ds_base

		If Not lvds_2.of_ChangeDataObject('dw_mapa_resumo_ecf_aliq') Then 
			Destroy(lvds_1)
			Destroy(lvds_2)
			Destroy(lvds_3)
			Return False
		End If

				
		lvds_2.Retrieve(gvo_Parametro.cd_Filial,lvds_1.object.nr_mapa[ll_Linha],lvds_1.object.de_especie[ll_Linha],lvds_1.object.de_serie[ll_Linha])
		
		For ll_Linha2 = 1 To lvds_2.RowCount()
			If lvds_2.object.vl_base_calculo[ll_Linha2] > 0 Then
				ldc_Aux = lvds_2.object.pc_aliquota[ll_Linha2]
				
				//Conferir se a mesma aliquota $$HEX1$$e900$$ENDHEX$$ utilizada mais de uma vez		
//				Select  a.pc_aliquota,count(a.nr_mapa) 
//				  Into :ldc_Aux2, :ll_Aux
//				  From	aliquota_mapa_resumo_ecf a,
//							mapa_resumo_ecf e,
//							mapa_resumo m
//				 Where m.nr_mapa = e.nr_mapa
//				   and m.cd_filial = e.cd_filial
//				   and m.de_especie = e.de_especie
//				  and m.de_serie = e.de_serie
//				   and a.nr_mapa = e.nr_mapa
//				  and a.cd_filial = e.cd_filial
//				  and a.de_especie = e.de_especie
//				  and a.de_serie = e.de_serie
//				  and m.dh_emissao >= :pdh_Inicial
//				  and m.dh_emissao <= :pdh_Final
//				  and a.vl_base_calculo > 0 
//				  and a.pc_aliquota = :ldc_Aux
//				group by a.pc_aliquota
//				Using SQLCa;
//				
//				If SQLCa.SQLCode = -1 Then
//					lb_Sucesso = False
//					Exit
//				End If
				
				ls_Registro = '|C420|T' + LeftA(String(ldc_Aux,"00") + "0000",4)  + '|' + String(lvds_2.object.vl_base_calculo[ll_Linha2],"##0.00") + '|' + String(ll_Linha2) + '||'
				
//				If ll_Aux > 0 Then
//					ls_Registro = '|C420|T' + Left(String(ldc_Aux,"00") + "0000",4)  + '|' + String(lvds_2.object.vl_base_calculo[ll_Linha2],"##0.00") + '|' + String(ll_Linha2) + '||'
//				Else
//					ls_Registro = '|C420|T' + Left(String(ldc_Aux,"00") + "0000",4)  + '|' + String(lvds_2.object.vl_base_calculo[ll_Linha2],"##0.00") + '|||'
//				End If
				
				If FileWrite(pl_arquivo,ls_Registro) = -1 Then
					lb_Sucesso = False
					Exit
				End If
				ll_Contador++
				cont_Bloco.cont_c420++
			End If
			
		Next	
		
		Destroy(lvds_2)
		
		If Not lb_Sucesso Then Exit
		
		If lvds_1.object.vl_st[ll_Linha] > 0 Then
			ls_Registro  = '|C420|F1|' 	+ String(lvds_1.object.vl_st[ll_Linha],"##0.00") + "|||"
			
			If FileWrite(pl_arquivo,ls_Registro) = -1 Then
				lb_Sucesso = False
				Exit
			End If
			ll_Contador++
			cont_Bloco.cont_c420++
		End If
		
		If lvds_1.object.vl_isenta[ll_Linha] > 0 Then
			ls_Registro = '|C420|I1|' 	+ String(lvds_1.object.vl_isenta[ll_Linha],"##0.00") 	+ "|||"
			
			If FileWrite(pl_arquivo,ls_Registro) = -1 Then
				lb_Sucesso = False
				Exit
			End If
			ll_Contador++
			cont_Bloco.cont_c420++
		End If
		
		If lvds_1.object.vl_nao_incidencia[ll_Linha] > 0 Then
			ls_Registro = '|C420|N1|' 	+ String(lvds_1.object.vl_nao_incidencia[ll_Linha],"##0.00") + "|||"
			
			If FileWrite(pl_arquivo,ls_Registro) = -1 Then
				lb_Sucesso = False
				Exit
			End If
			ll_Contador++
			cont_Bloco.cont_c420++
		End If
		
		If lvds_1.object.vl_st_iss[ll_Linha] > 0 Then
			ls_Registro = '|C420|FS1|' 	+ String(lvds_1.object.vl_st_iss[ll_Linha],"##0.00") 	+ "|||"
			
			If FileWrite(pl_arquivo,ls_Registro) = -1 Then
				lb_Sucesso = False
				Exit
			End If
			ll_Contador++
			cont_Bloco.cont_c420++
		End If
		
		If lvds_1.object.vl_isento_iss[ll_Linha] > 0 Then
			ls_Registro = '|C420|IS1|' 	+ String(lvds_1.object.vl_isento_iss[ll_Linha],"##0.00") 			+ "|||"
			
			If FileWrite(pl_arquivo,ls_Registro) = -1 Then
				lb_Sucesso = False
				Exit
			End If
			ll_Contador++
			cont_Bloco.cont_c420++
		End If
		
		If lvds_1.object.vl_nao_incidencia_iss[ll_Linha] > 0 Then
			ls_Registro = '|C420|NS1|' 	+ String(lvds_1.object.vl_nao_incidencia_iss[ll_Linha],"##0.00") 	+ "|||"
			
			If FileWrite(pl_arquivo,ls_Registro) = -1 Then
				lb_Sucesso = False
				Exit
			End If
			ll_Contador++
			cont_Bloco.cont_c420++
		End If
		
		If lvds_1.object.vl_operacao_nao_fiscal[ll_Linha] > 0 Then
			ls_Registro = '|C420|OPNF|' 	+ String(lvds_1.object.vl_operacao_nao_fiscal[ll_Linha],"##0.00") + "|||"
			
			If FileWrite(pl_arquivo,ls_Registro) = -1 Then
				lb_Sucesso = False
				Exit
			End If
			ll_Contador++
			cont_Bloco.cont_c420++
		End If
				
		If lvds_1.object.vl_desconto[ll_Linha] > 0 Then
			ls_Registro = '|C420|DT|' 	+ String(lvds_1.object.vl_desconto[ll_Linha],"##0.00") 			+ "|||"
			
			If FileWrite(pl_arquivo,ls_Registro) = -1 Then
				lb_Sucesso = False
				Exit
			End If
			ll_Contador++
			cont_Bloco.cont_c420++
		End If
		
		If lvds_1.object.vl_desconto_iss[ll_Linha] > 0 Then
			ls_Registro = '|C420|DS|' 	+ String(lvds_1.object.vl_desconto_iss[ll_Linha],"##0.00") 		+ "|||"
		
			If FileWrite(pl_arquivo,ls_Registro) = -1 Then
				lb_Sucesso = False
				Exit
			End If
			ll_Contador++
			cont_Bloco.cont_c420++
		End If
		
		If lvds_1.object.vl_acrescimo[ll_Linha] > 0 Then
			ls_Registro = '|C420|AT|' 	+ String(lvds_1.object.vl_acrescimo[ll_Linha],"##0.00") 			+ "|||"
			
			If FileWrite(pl_arquivo,ls_Registro) = -1 Then
				lb_Sucesso = False
				Exit
			End If
			ll_Contador++
			cont_Bloco.cont_c420++
		End If
		
		If lvds_1.object.vl_acrescimo_iss[ll_Linha] > 0 Then
			ls_Registro = '|C420|AS|' 	+ String(lvds_1.object.vl_acrescimo_iss[ll_Linha],"##0.00") 	+ "|||"
			
			If FileWrite(pl_arquivo,ls_Registro) = -1 Then
				lb_Sucesso = False
				Exit
			End If
			ll_Contador++
			cont_Bloco.cont_c420++
		End If
		
		If lvds_1.object.vl_cancelamento[ll_Linha] > 0 Then
			ls_Registro = '|C420|Can-T|' + String(lvds_1.object.vl_cancelamento[ll_Linha],"##0.00") 		+ "|||"
			
			If FileWrite(pl_arquivo,ls_Registro) = -1 Then
				lb_Sucesso = False
				Exit
			End If
			ll_Contador++
			cont_Bloco.cont_c420++
		End If
		
		If lvds_1.object.vl_cancelamento_iss[ll_Linha] > 0 Then
			ls_Registro = '|C420|Can-S|' + String(lvds_1.object.vl_cancelamento_iss[ll_Linha],"##0.00") + "|||"
			
			If FileWrite(pl_arquivo,ls_Registro) = -1 Then
				lb_Sucesso = False
				Exit
			End If
			ll_Contador++
			cont_Bloco.cont_c420++
		End If
		
		
//		// C 4 2 5
//
//		lvds_2 = Create dc_uo_ds_base
//
//		If Not lvds_2.of_ChangeDataObject('dw_ge038_pafecf_produto_cupom_fiscal') Then
//			Destroy(lvds_1)
//			Destroy(lvds_2)
//			Destroy(lvds_3)
//			Return False
//		End If 
//		
//		ll_Retorno = lvds_2.Retrieve(This.ECF,ldh_Aux,ldh_Aux)
//		
//		If ll_Retorno <> -1 Then
//		
//			For ll_Linha2 = 1 To lvds_2.RowCount()
//				//Fixo, indica Bloco C, registro C450
//				ls_Registro  = '|C425|'
//					
//				//Codigo do produto
//				ls_Registro  += String(lvds_2.Object.cd_produto[ll_Linha2]) + '|'
//				
//				//Quantidade do produto
//				ls_Registro  += String(lvds_2.Object.qt_vendida[ll_Linha2],"####0.000") + '|'
//								
//				//Unidade de medida
//				ls_Registro  += Left(lvds_2.Object.cd_un[ll_Linha2],6) + '|'
//				
//				//Valor total do item
//				ls_Registro += String(lvds_2.object.vl_preco_praticado[ll_Linha2],"####0.00") + "|"
//				
//				//Valor PIS do documento
//				ls_Registro += "0,00|"
//				
//				//Valor COFINS do documento
//				ls_Registro += "0,00|"
//				
//				If FileWrite(pl_arquivo,ls_Registro) = -1 Then
//					lb_Sucesso = False
//					Exit
//				End If
//				ll_Contador++
//				//cont_Bloco.cont_c470++
//				
//			Next				
//		End If
//		
		
		
		
		
		// C 4 6 0 
		
		lvds_2 = Create dc_uo_ds_base
		
		If Not lvds_2.of_ChangeDataObject('dw_ge038_pafecf_cupom_fiscal') Then
			Destroy(lvds_1)
			Destroy(lvds_2)
			Return False
		End If 
		
		ll_Retorno = lvds_2.Retrieve(pl_ecf,ldh_Aux,ldh_Aux)
		
		If ll_Retorno <> -1 Then
		
			For ll_Linha2 = 1 To lvds_2.RowCount()
				ll_Nota = lvds_2.Object.nr_nf[ll_Linha2]
				
				//Fixo, indica Bloco C, registro C450
				ls_Registro  = '|C460|'
					
				//Tipo do documento fiscal
				ls_Registro  += '2D|'
				
				//Situacao do documento fiscal
				lb_Cancelado = (Not IsNull(lvds_2.Object.dh_cancelamento[ll_Linha2])) Or (Not IsNull(lvds_2.Object.id_cancelamento_impressora[ll_Linha2])) Or lvds_2.Object.id_cancelamento_impressora[ll_Linha2] = 'S'
				If (Not IsNull(lvds_2.Object.dh_cancelamento[ll_Linha2])) Or (Not IsNull(lvds_2.Object.id_cancelamento_impressora[ll_Linha2])) Or lvds_2.Object.id_cancelamento_impressora[ll_Linha2] = 'S' Then
					ls_Registro  += '02|'
				Else
					ls_Registro  += '00|'
				End If
				
				//COO do documento
				ls_Registro += LeftA(String(lvds_2.object.nr_operacao_ecf[ll_Linha2]),6) + "|"
				
				If Not(lb_Cancelado) Then
					//Data de emissao do documento
					ls_Registro += String(lvds_2.object.dh_emissao[ll_Linha2],"DDMMYYYY") + "|"
					
					//Valor total do documento
					ls_Registro += String(lvds_2.object.vl_total_nf[ll_Linha2]) + "|"
					
					//Valor PIS do documento
					ls_Registro += "0,00|"
					
					//Valor COFINS do documento
					ls_Registro += "0,00|"
					
					//Valor CPF/CNPJ do cliente / Nome do cliente do documento
					ls_Registro += "||"
				Else
					//Data de emissao do documento
					ls_Registro += "|"
					
					//Valor total do documento
					ls_Registro +=  "|"
					
					//Valor PIS do documento
					ls_Registro += "|"
					
					//Valor COFINS do documento
					ls_Registro += "|"
					
					//Valor CPF/CNPJ do cliente / Nome do cliente do documento
					ls_Registro += "||"
				End If
				
				ldc_pc_desconto = lvds_2.object.pc_desconto[ll_Linha2]
				
				If FileWrite(pl_arquivo,ls_Registro) = -1 Then
					lb_Sucesso = False
					Exit
				End If
				ll_Contador++
				cont_Bloco.cont_c460++
				
				
				
				// C 4 7 0 
		
				lvds_3 = Create dc_uo_ds_base
		
				If Not lvds_3.of_ChangeDataObject('dw_ge038_pafecf_produto_cupom_fiscal') Then
					Destroy(lvds_1)
					Destroy(lvds_2)
					Destroy(lvds_3)
					Return False
				End If 
				
				lvds_3.of_AppendWhere('nf_venda.nr_nf = ' + String(ll_Nota) + ' and nf_venda.cd_filial = ' + String(gvo_Parametro.cd_filial))
				
				ll_Retorno = lvds_3.Retrieve(pl_ecf,ldh_Aux,ldh_Aux)
				
				If ll_Retorno <> -1 Then
				
					For ll_Linha3 = 1 To lvds_3.RowCount()
						//Fixo, indica Bloco C, registro C450
						ls_Registro  = '|C470|'
							
						//Codigo do produto
						ls_Registro  += String(lvds_3.Object.cd_produto[ll_Linha3]) + '|'
						
						//Quantidade do produto
						ls_Registro  += String(lvds_3.Object.qt_vendida[ll_Linha3],"####0.000") + '|'
						
						//Quantidade cancelada
						ls_Registro  += "0,000|"
						
						//Unidade de medida
						ls_Registro  += LeftA(lvds_3.Object.cd_un[ll_Linha3],6) + '|'
						
						//Valor total do item
						If ldc_pc_desconto > 0 Then
							ldc_preco_comdesconto = lvds_3.object.vl_preco_praticado[ll_Linha3] - Round(((lvds_3.object.vl_preco_praticado[ll_Linha3] * ldc_pc_desconto)  / 100 ) , 2 )
							ls_Registro += String(ldc_preco_comdesconto,"####0.00") + "|"							
						Else
							ls_Registro += String(lvds_3.object.vl_preco_praticado[ll_Linha3],"####0.00") + "|"
						End If
						
						//Codigo Situacao Tributaria
						ls_Registro += LeftA(lvds_3.object.cd_situacao_tributaria[ll_Linha3] + "000",3) + "|"
						
						//Codigo CFOP, natureza operacao
						ls_Registro += LeftA(String(lvds_3.object.cd_natureza_operacao[ll_Linha3]),4) + "|"
						
						//Aliquota ICMS
						ls_Registro += String(lvds_3.object.pc_icms[ll_Linha3],"###0.00") + "|"
					
						//Valor PIS do documento
						ls_Registro += "0,00|"
						
						//Valor COFINS do documento
						ls_Registro += "0,00|"
						
						If FileWrite(pl_arquivo,ls_Registro) = -1 Then
							lb_Sucesso = False
							Exit
						End If
						ll_Contador++
						cont_Bloco.cont_c470++
						
					Next				
				End If
				
			Next				
		End If	
		
		Destroy(lvds_2)
		
		If Not lb_Sucesso Then
			Exit
		End If
		
		// C 4 9 0
		
		lvds_2 = Create dc_uo_ds_base
		
		If Not lvds_2.of_ChangeDataObject('dw_ge038_pafecf_sum_diario') Then 
			Destroy(lvds_1)
			Destroy(lvds_2)
			Return False
		End If 
		
		ll_Retorno = lvds_2.Retrieve(ldh_Aux, gvo_Parametro.cd_Filial)
		//ll_Retorno = lvds_2.Retrieve(pdh_Inicial, pdh_Final, gvo_Parametro.cd_Filial)

		If ll_Retorno <> -1 Then	
			For ll_Linha2 = 1 To lvds_2.RowCount()		
				//Fixo, indica Bloco C, registro C490
				ls_Registro  = '|C490|'
				
				//Codigo situacao tributaria
				ls_Aux = LeftA(lvds_2.Object.cd_situacao_tributaria[ll_Linha2] + "000",3)
				ls_Registro  += ls_Aux + '|'
				
				//Codigo natureza operacao
				ls_Registro  += LeftA(String(lvds_2.Object.cd_natureza_operacao[ll_Linha2]) ,4) + '|'
				
				Choose Case ls_Aux
					Case "030","040","041","050","060"
						//Aliquota ICMS
						ls_Registro  += '0,00|'
						
						//Valor total bruto
						ls_Registro  += String(lvds_2.Object.vl_preco_unitario[ll_Linha2],"##0.00") + '|'
						
						//Valor bc icms / Valor icms
						ls_Registro  += '0,00|0,00|'
					Case Else
						//Aliquota ICMS
						ls_Registro  += String(lvds_2.Object.pc_icms[ll_Linha2],"#####0.00") + '|'
						
						//Valor total bruto
						ls_Registro  += String(lvds_2.Object.vl_preco_unitario[ll_Linha2],"##0.00") + '|'
						
						//Valor bc icms
						ls_Registro  += String(lvds_2.Object.vl_bc_icms[ll_Linha2],"##0.00") + '|'
						
						//Valor icms
						ls_Registro  += String(lvds_2.Object.vl_icms[ll_Linha2],"##0.00") + '|'
				End Choose	
				
				//Codigo da observa$$HEX2$$e700e300$$ENDHEX$$o do lan$$HEX1$$e700$$ENDHEX$$amento fiscal Registro 0460
				ls_Registro  += "|"
			
				If FileWrite(pl_arquivo,ls_Registro) = -1 Then
					lb_Sucesso = False
					Exit
				End If
				ll_Contador++
				cont_Bloco.cont_c490++
			Next
		End If
		
		Destroy(lvds_2)
		
		If Not lb_Sucesso Then
			//Exit
		End If
		
	Next
	
End If	
		
		
		
	

//Fixo, indica Bloco C, registro C990
ls_Registro  = '|C990|'

//Contador de linhas do Bloco C
ll_Contador++
ls_Registro  += String(ll_Contador) + "|"

If FileWrite(pl_arquivo,ls_Registro) = -1 Then
	lb_Sucesso = False
End If			
cont_Bloco.cont_c990 = ll_Contador

Destroy(lvds_1)

Return lb_Sucesso

end function

public function boolean of_inconsistencia_inclusao_exclusao ();Long lvl_Linha

If PDV.fabricante = "NFCE" Then  Return False  //PAF-NFC-e n$$HEX1$$e300$$ENDHEX$$o necessita a marca$$HEX2$$e700e300$$ENDHEX$$o.

If ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "Desenvolvimento", "Homologacao","") = 'S' Then	
	
	Select Count(cont) 
	  Into :lvl_Linha
	  From (
				 Select distinct 1 as cont     // conta registros na paf que n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ na original
				  From impressora_fiscal_paf ip
				  where not exists ( select *
						       from impressora_fiscal i 
						      where i.nr_ecf = ip.nr_ecf )
				  union
				 Select distinct 1 // conta registros na original que n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ na _paf
				  From impressora_fiscal ip
				  where not exists ( select *
						       from impressora_fiscal_paf i 
						      where i.nr_ecf = ip.nr_ecf )				
				 union				
				 Select distinct 1 as cont     
				  From produto_geral_paf ip
				  where not exists ( select *
						       from produto_geral i 
						      where i.cd_produto = ip.cd_produto )
				  union
				 Select distinct 1
				  From produto_geral ip
				  where not exists ( select *
						       from produto_geral_paf i 
						      where i.cd_produto = ip.cd_produto )				
				 union
				select distinct 1 as cont     
				 from saldo_produto_paf ip
				where ip.dh_saldo = make_date( Cast( date_part( 'year', uf_dh_parametro() ) as integer ), Cast( date_part( 'month', uf_dh_parametro() ) as integer ), 1)
				  and not exists ( select *
				                                    from saldo_produto i 
				                                   where i.cd_produto = ip.cd_produto  )				
				  union
				select distinct 1 as cont     
				 from saldo_produto ip
				where ip.dh_saldo = make_date( Cast( date_part( 'year', uf_dh_parametro() ) as integer ), Cast( date_part( 'month', uf_dh_parametro() ) as integer ), 1)
				  and not exists ( select *
				                                    from saldo_produto_paf i 
				                                   where i.cd_produto = ip.cd_produto  )				
				 union
				Select distinct 1 as cont     
				  From filial_paf ip
				  where not exists ( select *
						       from filial i 
						      where i.cd_filial = ip.cd_filial )
				  union
				 Select distinct 1
				  From filial ip
				  where not exists ( select *
						       from filial_paf i 
						      where i.cd_filial = ip.cd_filial )				
				 union
				Select distinct 1 as cont     
				  From mapa_resumo_paf ip
				  where not exists ( select *
						       from mapa_resumo i 
						      where i.cd_filial = ip.cd_filial
							and i.nr_mapa = ip.nr_mapa
							and i.de_especie = ip.de_especie
							and i.de_serie = ip.de_serie)				
				  union
				 Select distinct 1 as cont     
				  From mapa_resumo ip
				  where not exists ( select *
						       from mapa_resumo_paf i 
						      where i.cd_filial = ip.cd_filial
							and i.nr_mapa = ip.nr_mapa
							and i.de_especie = ip.de_especie
							and i.de_serie = ip.de_serie)				
				 union
				Select distinct 1 as cont     
				  From mapa_resumo_ecf_paf ip
				  where not exists ( select *
						       from mapa_resumo_ecf i 
						      where i.cd_filial = ip.cd_filial
							and i.nr_mapa = ip.nr_mapa
							and i.de_especie = ip.de_especie
							and i.de_serie = ip.de_serie
							and i.nr_ecf = ip.nr_ecf)				
				  union  
				 Select distinct 1 as cont     
				  From mapa_resumo_ecf ip
				  where not exists ( select *
						       from mapa_resumo_ecf_paf i 
						      where i.cd_filial = ip.cd_filial
							and i.nr_mapa = ip.nr_mapa
							and i.de_especie = ip.de_especie
							and i.de_serie = ip.de_serie
							and i.nr_ecf = ip.nr_ecf)				
				union
				Select distinct 1 as cont     
				  From nf_venda_paf ip
				  where not exists ( select *
						       from nf_venda i 
						      where i.cd_filial = ip.cd_filial
							and i.nr_nf = ip.nr_nf
							and i.de_especie = ip.de_especie
							and i.de_serie = ip.de_serie )
					and ip.de_especie = 'CF'
				  union				
				Select distinct 1 as cont     
				  From nf_venda ip
				  where not exists ( select *
						       from nf_venda_paf i 
						      where i.cd_filial = ip.cd_filial
							and i.nr_nf = ip.nr_nf
							and i.de_especie = ip.de_especie
							and i.de_serie = ip.de_serie )
					and ip.de_especie = 'CF'
				 union
				Select distinct 1 as cont     
				  From item_nf_venda_paf ip
				  where not exists ( select *
						       from item_nf_venda i 
						      where i.cd_filial = ip.cd_filial
							and i.nr_nf = ip.nr_nf
							and i.de_especie = ip.de_especie
							and i.de_serie = ip.de_serie
							and i.nr_sequencial = ip.nr_sequencial
							and i.cd_produto = ip.cd_produto )
					and ip.de_especie = 'CF'
				  union				
				Select distinct 1 as cont     
				  From item_nf_venda ip
				  where not exists ( select *
						       from item_nf_venda_paf i 
						      where i.cd_filial = ip.cd_filial
							and i.nr_nf = ip.nr_nf
							and i.de_especie = ip.de_especie
							and i.de_serie = ip.de_serie
							and i.nr_sequencial = ip.nr_sequencial
							and i.cd_produto = ip.cd_produto )
					and ip.de_especie = 'CF'
				 union
				Select distinct 1 as cont     
				  From documento_ecf_paf ip
				  where not exists ( select *
						       from documento_ecf i 
						      where i.dh_movimento = ip.dh_movimento
							and i.nr_ecf = ip.nr_ecf
							and i.nr_coo = ip.nr_coo )
				  union
				Select distinct 1 as cont     
				  From documento_ecf ip
				  where not exists ( select *
						       from documento_ecf_paf i 
						      where i.dh_movimento = ip.dh_movimento
							and i.nr_ecf = ip.nr_ecf
							and i.nr_coo = ip.nr_coo )
							
				  union
				Select distinct 1 as cont     
				  From aliquota_mapa_resumo_ecf_paf ip
				  where not exists ( select *
						       from aliquota_mapa_resumo_ecf i 
						      where i.cd_filial = ip.cd_filial
							and i.nr_mapa = ip.nr_mapa
							and i.de_especie = ip.de_especie
							and i.de_serie = ip.de_serie 
							and i.pc_aliquota = ip.pc_aliquota)
				  union
				Select distinct 1 as cont     
				  From aliquota_mapa_resumo_ecf ip
				  where not exists ( select *
						       from aliquota_mapa_resumo_ecf_paf i 
						      where i.cd_filial = ip.cd_filial
							and i.nr_mapa = ip.nr_mapa
							and i.de_especie = ip.de_especie
							and i.de_serie = ip.de_serie 
							and i.pc_aliquota = ip.pc_aliquota)

				) as cont
	 Using SQLCa;
	
	If SQLCa.SQLCode = -1 Then
		SQLCa.of_MsgDbError("Erro ao localizar inclus$$HEX1$$f500$$ENDHEX$$es ou exclus$$HEX1$$f500$$ENDHEX$$es no banco de dados")
	End If
	
	If lvl_Linha > 0 Then
		Return True
	End If
	  
	Return False
Else
	Return False
End If
end function

public function boolean of_inconsistencia_filial (long pl_filial);String lvs_Fantasia
String lvs_Cgc
String lvs_Hash

If PDV.fabricante = "NFCE" Then  Return False  //PAF-NFC-e n$$HEX1$$e300$$ENDHEX$$o necessita a marca$$HEX2$$e700e300$$ENDHEX$$o.

Select nm_fantasia,   
		nr_cgc
Into	:lvs_Fantasia,
		:lvs_Cgc
From filial f
Where f.cd_filial = :pl_filial
Using SQLCa;

Select de_hash
Into	:lvs_Hash
From filial_paf p
Where p.cd_filial = :pl_filial
Using SQLCa;

If SQLCa.SQLCode = 0 Then
	//cd_filial + nm_fantasia + nr_cgc
	If Trim(lvs_Hash) <> "" And Not IsNull(lvs_Hash) Then
		If lvs_Hash <> gf_Captura_Hash(String(pl_filial) + lvs_Fantasia + lvs_Cgc) Then
			Return True
		End If 
	Else
		lvs_Hash = gf_Captura_Hash(String(pl_filial) + lvs_Fantasia + lvs_Cgc) 
		 
		Update filial_paf f
			Set de_hash 		= :lvs_Hash
		 Where f.cd_filial	= :pl_Filial
		 Using SQLCa;
		 
		If SQLCa.SQLCode <> -1 Then	
			SQLCa.of_Commit()
		End If
	End If
End If
  
Return False
end function

public function boolean of_inconsistencia_mapa_resumo (long pl_mapa, long pl_filial);
DateTime lvdh_Movimento

String lvs_Hash
String lvs_data
String lvs_especie
String lvs_serie

Select	 de_especie,
		 de_serie,
		COALESCE( TO_CHAR( dh_movimentacao_caixa, 'DD/MM/YYYY HH24:MI:SS' ), '' )
	Into 	:lvs_especie,
		 	:lvs_serie,
			:lvs_data	
	From mapa_resumo m
  Where m.nr_mapa		= :pl_Mapa
	 And m.cd_filial 	= :pl_Filial
	 And m.de_especie	= 'MR'
	 And m.de_serie	= '1'
  Using SQLCa;

Select	 	de_hash
	Into 	:lvs_Hash
	From mapa_resumo_paf p
  Where p.nr_mapa		= :pl_Mapa
	 And p.cd_filial 	= :pl_Filial
	 And p.de_especie	= 'MR'
	 And p.de_serie	= '1'
  Using SQLCa;

If SQLCa.SQLCode = 0 Then	
	//nr_mapa + cd_filial + dh_movimentacao_caixa(ddmmyyyy)
	If Trim(lvs_Hash) <> "" And Not IsNull(lvs_Hash) Then
		If lvs_Hash <> gf_Captura_Hash(String(pl_filial) + String(pl_Mapa) + lvs_especie + lvs_serie + lvs_data) Then
			Return True
		End If 
	Else
		Update mapa_resumo
			Set de_especie 		= de_especie
		  Where nr_mapa		= :pl_Mapa
			 And cd_filial 	= :pl_Filial
			 And de_especie	= 'MR'
			 And de_serie	= '1'
		 Using SQLCa;
		 
		If SQLCa.SQLCode <> -1 Then	
			SQLCa.of_Commit()
		End If		
	End If
End If
  
Return False
end function

public function boolean of_inconsistencia_mapa_resumo_ecf (long pl_mapa, long pl_filial, long pl_ecf);
Long lvl_qt_reducao_z
Long lvl_nr_operacao_final
Long lvl_qt_reinicio_z

DateTime lvdh_reducao

Decimal{2} lvdc_vl_total_geral_final
Decimal{2} lvdc_vl_st_iss
Decimal{2} lvdc_vl_isento_iss
Decimal{2} lvdc_vl_nao_incidencia_iss
Decimal{2} lvdc_vl_operacao_nao_fiscal
Decimal{2} lvdc_vl_desconto_iss
Decimal{2} lvdc_vl_acrescimo
Decimal{2} lvdc_vl_acrescimo_iss
Decimal{2} lvdc_vl_cancelamento_iss

String lvs_Hash
String lvs_serie
String lvs_especie
String lvs_total_geral
String lvs_st_iss
String lvs_isento_iss
String lvs_naoinc_iss
String lvs_oper_nao_fiscal
String lvs_desconto_iss
String lvs_acrescimo
String lvs_acrescimo_iss
String lvs_cancelamento_iss
String lvs_data

Select		de_especie,
			de_serie,
			qt_reducao_z,
			nr_operacao_final,
			qt_reinicio_z,
			COALESCE( TO_CHAR( dh_reducao, 'DD/MM/YYYY HH24:MI:SS' ), '' ),			
			vl_total_geral_final,
			vl_st_iss,
			vl_isento_iss,
			vl_nao_incidencia_iss,
			vl_operacao_nao_fiscal,
			vl_desconto_iss,
			vl_acrescimo,
			vl_acrescimo_iss,
			vl_cancelamento_iss
	Into	:lvs_especie,
			:lvs_serie,
			:lvl_qt_reducao_z,
			:lvl_nr_operacao_final,
			:lvl_qt_reinicio_z,
			:lvs_data,
			:lvdc_vl_total_geral_final,
			:lvdc_vl_st_iss,
			:lvdc_vl_isento_iss,
			:lvdc_vl_nao_incidencia_iss,
			:lvdc_vl_operacao_nao_fiscal,
			:lvdc_vl_desconto_iss,
			:lvdc_vl_acrescimo,
			:lvdc_vl_acrescimo_iss,
			:lvdc_vl_cancelamento_iss
	From mapa_resumo_ecf m
  Where m.nr_mapa		= :pl_Mapa
	 And m.cd_filial 	= :pl_Filial
	 And m.de_especie	= 'MR'
	 And m.de_serie	= '1'
	 And m.nr_ecf		= :pl_Ecf
  Using SQLCa;
  
lvs_total_geral = gf_valor_com_ponto(lvdc_vl_total_geral_final) 
lvs_st_iss = gf_valor_com_ponto(lvdc_vl_st_iss) 
lvs_isento_iss = gf_valor_com_ponto(lvdc_vl_isento_iss) 
lvs_naoinc_iss = gf_valor_com_ponto(lvdc_vl_nao_incidencia_iss) 
lvs_oper_nao_fiscal = gf_valor_com_ponto(lvdc_vl_operacao_nao_fiscal) 
lvs_desconto_iss = gf_valor_com_ponto(lvdc_vl_desconto_iss) 
lvs_acrescimo = gf_valor_com_ponto(lvdc_vl_acrescimo) 
lvs_acrescimo_iss = gf_valor_com_ponto(lvdc_vl_acrescimo_iss) 
lvs_cancelamento_iss = gf_valor_com_ponto(lvdc_vl_cancelamento_iss) 
  
  Select	de_hash
	Into	:lvs_Hash
	From mapa_resumo_ecf_paf p
  Where p.nr_mapa		= :pl_Mapa
	 And p.cd_filial 	= :pl_Filial
	 And p.de_especie	= 'MR'
	 And p.de_serie	= '1'
	 And p.nr_ecf		= :pl_Ecf
  Using SQLCa;

If SQLCa.SQLCode = 0 Then	

	If Trim(lvs_Hash) <> "" And Not IsNull(lvs_Hash) Then
		
		If lvs_Hash <> gf_Captura_Hash(	String(pl_Filial) + String(pl_Mapa) + lvs_especie + lvs_serie + String(pl_ecf) + String(lvl_qt_reducao_z) + String(lvl_nr_operacao_final) + &
													String(lvl_qt_reinicio_z) + lvs_data + lvs_total_geral + &
													lvs_st_iss + lvs_isento_iss + lvs_naoinc_iss + &
													lvs_oper_nao_fiscal + lvs_desconto_iss + lvs_acrescimo + &
													lvs_acrescimo_iss + lvs_cancelamento_iss) Then
			Return True
		End If 
	Else
		Update mapa_resumo_ecf
			Set nr_operacao_final	= nr_operacao_final
		  Where nr_mapa		= :pl_Mapa
			 And cd_filial 	= :pl_Filial
			 And de_especie	= 'MR'
			 And de_serie	= '1'
			 And nr_ecf		= :pl_Ecf
		 Using SQLCa;
		 
		If SQLCa.SQLCode <> -1 Then	
			SQLCa.of_Commit()
		End If							
	End If
End If
  
Return False
end function

public function boolean of_inconsistencia_meio_pagamento (long pl_coo, long pl_ecf, long pl_filial, boolean pb_update);
Decimal{2} lvdc_Total, lvdc_desconto, lvdc_total_bruto

Long lvl_Coo
Long lvl_Ccf
Long lvl_Nota

String lvs_Cancelado
String lvs_Hash
String lvs_pagamento
String lvs_serie
String lvs_especie
String lvs_valor
String lvs_valor_bruto
String lvs_cliente
String lvs_cpf
String lvs_desconto
String lvs_emissao

If PDV.fabricante = "NFCE" Then  Return False  //PAF-NFC-e n$$HEX1$$e300$$ENDHEX$$o necessita a marca$$HEX2$$e700e300$$ENDHEX$$o.

 Select	nr_nf,
 			nr_operacao_ecf, 			
			vl_total_nf,
			id_cancelamento_impressora,
			nr_ccf,
			cd_forma_pagamento,
			de_especie,
			de_serie,
			COALESCE( TO_CHAR( dh_emissao, 'DD/MM/YYYY HH24:MI:SS' ), '' ),
			pc_desconto,
			vl_total_nf_bruto,
			cd_cliente,
			nr_cpf_cgc
	Into	:lvl_Nota,
			:lvl_Coo,
			:lvdc_Total,
			:lvs_Cancelado,
			:lvl_Ccf,
			:lvs_pagamento,
			:lvs_especie,
			:lvs_serie,
			:lvs_emissao,
			:lvdc_desconto,
			:lvdc_total_bruto,
			:lvs_cliente,
			:lvs_cpf
	From nf_venda n
  Where n.nr_ecf		= :pl_Ecf
	 And n.cd_filial 	= :pl_Filial
	 and n.nr_operacao_ecf = :pl_coo
	 And n.de_especie	= 'CF'
	 And n.de_serie	= 'ECF'
  Using SQLCa;	

 Select	de_hash
	Into	:lvs_Hash
	From nf_venda_paf p
  Where p.nr_nf		= :lvl_Nota
	 And p.cd_filial 	= :pl_Filial
	 And p.de_especie	= 'CF'
	 And p.de_serie	= 'ECF'
  Using SQLCa;

If IsNull(lvl_Ccf) Then
	lvl_Ccf = 0
End If

If IsNull(lvs_Cancelado) Then
	lvs_Cancelado = "N"
End If

If IsNull(lvs_pagamento) Then
	lvs_pagamento = ""
End If	

lvs_valor = gf_valor_com_ponto(lvdc_Total)

If IsNull(lvdc_desconto) Then
	lvs_desconto = '0'
Else
	lvs_desconto = gf_valor_com_ponto(lvdc_desconto)
End If	

If IsNull(lvdc_total_bruto) Then
	lvs_valor_bruto = ""
Else
	lvs_valor_bruto = gf_valor_com_ponto(lvdc_total_bruto)
End If	

If IsNull(lvs_cliente) Then
	lvs_cliente = ""
End If	

If IsNull(lvs_cpf) Then
	lvs_cpf = ""
End If	

If SQLCa.SQLCode = 0 Then	
	If Trim(lvs_Hash) <> "" And Not IsNull(lvs_Hash) Then
		If lvs_Hash <> gf_Captura_Hash(String(pl_filial) + String(lvl_Nota) + lvs_especie + lvs_serie + lvs_valor + String(lvl_Coo) + lvs_Cancelado + String(lvl_Ccf) + lvs_pagamento + lvs_emissao + lvs_valor_bruto + lvs_desconto + lvs_cliente + lvs_cpf) Then
			Return True	
		End If 
	End If
End If
  
Return False
end function

public function boolean of_inconsistencia_produto_geral (long pl_produto);
Decimal{2} lvdc_Preco

Long lvl_Saldo

String lvs_Descricao
String lvs_Tributacao
String lvs_Aliquota
String lvs_Hash
String lvs_superfluo
String lvs_preco
String lvs_unidade

If PDV.fabricante = "NFCE" Then  Return False  //PAF-NFC-e n$$HEX1$$e300$$ENDHEX$$o necessita a marca$$HEX2$$e700e300$$ENDHEX$$o.

 Select	de_produto,
			vl_preco_venda_atual,
			cd_tributacao_icms,
			cd_tipo_icms,
			id_superfluo,
			cd_unidade_medida_venda
	Into	:lvs_Descricao,
			:lvdc_Preco,
			:lvs_Tributacao,
			:lvs_Aliquota,
			:lvs_superfluo,
			:lvs_unidade
	From produto_geral p
  Where p.cd_produto = :pl_produto
  Using SQLCa;
  
 Select	de_hash
	Into	:lvs_Hash
	From produto_geral_paf pf
  Where pf.cd_produto = :pl_produto
  Using SQLCa;
  
lvs_preco = gf_valor_com_ponto(lvdc_Preco)

If SQLCa.SQLCode = 0 Then	
	//cd_produto + de_produto + vl_preco_venda_atual + cd_tributacao_icms + id_superfluo
	If Trim(lvs_Hash) <> "" And Not IsNull(lvs_Hash) Then
		If lvs_Hash <> gf_Captura_Hash(String(pl_Produto) + lvs_Descricao + lvs_preco + lvs_Tributacao + lvs_superfluo + lvs_Aliquota + lvs_unidade) Then
			Return True
		End If 
	Else
		//lvs_Hash = gf_Captura_Hash(String(pl_Produto) + lvs_Descricao + String(lvdc_Preco) + lvs_Tributacao + lvs_Aliquota)
		 
		Update produto_geral p
			Set de_produto 		= de_produto
		 Where p.cd_produto	= :pl_Produto
		 Using SQLCa;
		 
		If SQLCa.SQLCode <> -1 Then	
			SQLCa.of_Commit()
		End If
	End If
End If
  
Return False

end function

public function boolean of_verifica_alteracao_tabela (string ps_tabela, string ps_chave, string ps_valor);//ps_Tabela - Tabela do banco
//ps_Chave	- Campos da chave prim$$HEX1$$e100$$ENDHEX$$ria
//ps_Valor	- Valores da chave prim$$HEX1$$e100$$ENDHEX$$ria
//Em chaves composta, s$$HEX1$$e300$$ENDHEX$$o separados os campos por ";"

String lvs_Retorno

//Montar SQL din$$HEX1$$e200$$ENDHEX$$mico
String lvs_Select
String lvs_Where

Long lvl_Inicio_Chave
Long lvl_Final_Chave
Long lvl_Inicio_Valor
Long lvl_Final_Valor

DataStore lvds
lvds = Create DataStore

lvds.SetTransObject(SQLCa)

If Not IsNull(ps_tabela) And Trim(ps_tabela) <> '' Then
	lvl_Final_Chave = PosA(ps_Chave, ";")
	
	If lvl_Final_Chave > 0 Then
		lvl_Final_Valor = PosA(ps_Valor, ";")	
		Do While lvl_Final_Chave > 0 
			
		Loop
	Else
//		lvs_Where = "Where " + ps_Chave + " = " + ps_Valor55
	End IF
	
	lvds.SetSQLSelect("")
	lvds.Retrieve()
End If



Destroy(lvds)


Return False
end function

public function boolean of_capturar_md5_old (string ps_arquivo, ref string ps_md5);Long ll_Retorno
	
String ls_MD5
	
ls_MD5 = Space(33)	

ll_Retorno = md5FromFile(ps_Arquivo,Ref ls_MD5)
	
If ll_Retorno = 1 Then
	ps_MD5 = ls_MD5
	Return True
End IF

Return False
end function

public function boolean of_identificacao_pafecf ();Return True
end function

public function boolean of_pafecf_conv5795_r90 (date pdh_inicial, date pdh_final, long pl_arquivo);//Vendas do per$$HEX1$$ed00$$ENDHEX$$odo pelo formato Convenio 57/95 registro 10

Boolean lb_Sucesso = False

Long ll_Retorno
Long ll_Linha 

String ls_Registro

dc_uo_ds_base lvds_1
lvds_1 = Create dc_uo_ds_base

If Not lvds_1.of_ChangeDataObject('dw_ge038_pafecf_dados_filial') Then 
	Destroy(lvds_1)
	Return False
End If 

ll_Retorno = lvds_1.Retrieve(gvo_Parametro.cd_Filial)

If ll_Retorno <> -1 Then
	
	For ll_Linha = 1 To lvds_1.RowCount()
		ls_Registro  = '90'
		
		ls_Registro += LeftA(lvds_1.Object.nr_Cgc					 [ll_Linha] + Space(14) ,14) 
		
		ls_Registro += LeftA(gf_Replace(lvds_1.Object.nr_Inscricao_Estadual[ll_Linha],".","",0) + Space(14) ,14)
		
		ls_Registro += "50" + of_Formata_Valor_PafEcf(cont_bloco.cont_50,8,0)
		
		ls_Registro += "54" + of_Formata_Valor_PafEcf(cont_bloco.cont_54,8,0)
		
		ls_Registro += "60" + of_Formata_Valor_PafEcf(cont_bloco.cont_60,8,0)
		
		ls_Registro += "75" + of_Formata_Valor_PafEcf(cont_bloco.cont_75,8,0)
		
		cont_bloco.cont_99++
		
		ls_Registro += "99" + of_Formata_Valor_PafEcf(cont_bloco.cont_99 + cont_bloco.cont_60 + cont_bloco.cont_75 + cont_bloco.cont_54 + cont_bloco.cont_50,8,0)
		
		ls_Registro += Space(45)
		
		ls_Registro += String(ll_Linha)

		If FileWrite(pl_arquivo,ls_Registro) = -1 Then
			lb_Sucesso = False
			Exit
		End If
		
		lb_Sucesso = True
		
	Next
	
End If

Destroy(lvds_1)

Return lb_Sucesso


end function

public function boolean of_pafecf_conv5795_r10 (date pdh_inicial, date pdh_final, long pl_arquivo);//Vendas do per$$HEX1$$ed00$$ENDHEX$$odo pelo formato Convenio 57/95 registro 10

Boolean lb_Sucesso = False

Long ll_Retorno
Long ll_Linha 

String ls_Registro

dc_uo_ds_base lvds_1
lvds_1 = Create dc_uo_ds_base

If Not lvds_1.of_ChangeDataObject('dw_ge038_pafecf_dados_filial') Then 
	Destroy(lvds_1)
	Return False
End If 

ll_Retorno = lvds_1.Retrieve(gvo_Parametro.cd_Filial)

If ll_Retorno <> -1 Then
	
	For ll_Linha = 1 To lvds_1.RowCount()
		ls_Registro  = '10'
		
		ls_Registro += LeftA(lvds_1.Object.nr_Cgc					 [ll_Linha] + Space(14) ,14) 
		
		ls_Registro += LeftA(gf_Replace(lvds_1.Object.nr_Inscricao_Estadual[ll_Linha],".","",0) + Space(14) ,14)
		
		ls_Registro += LeftA(lvds_1.Object.nm_Razao_Social		 [ll_Linha] + Space(35) ,35)
		
		ls_Registro += LeftA(lvds_1.Object.nm_cidade				 [ll_Linha] + Space(30) ,30)
		
		ls_Registro += LeftA(lvds_1.Object.cd_unidade_federacao [ll_Linha] + Space(2)  ,2)
		
		ls_Registro += LeftA(RightA(lvds_1.Object.nr_ddd_fax[ll_Linha],2) + lvds_1.Object.nr_fax[ll_Linha] + Space(10) ,10)	
	
		ls_Registro += String(pdh_Inicial,"YYYYMMDD")
		
		ls_Registro += String(pdh_Final	,"YYYYMMDD")
		
		ls_Registro += '331'
		
		If FileWrite(pl_arquivo,ls_Registro) = -1 Then
			lb_Sucesso = False
			Exit
		End If
		cont_bloco.cont_99++
		
		lb_Sucesso = True
		
	Next
	
End If

Destroy(lvds_1)

Return lb_Sucesso


end function

public function boolean of_pafecf_ac0908_bloco_0 (date pdh_inicial, date pdh_final, long pl_arquivo);//Vendas do per$$HEX1$$ed00$$ENDHEX$$odo pelo formato Ato Cotepe 09/08 bloco 0

Boolean lb_Sucesso = True

Long ll_Retorno
Long ll_Linha
Long ll_Linha2
Long ll_Contador
Long ll_Produto

Decimal{2} ldc_Aliq


String ls_Registro
String ls_Aux

dc_uo_ds_base lvds_1
lvds_1 = Create dc_uo_ds_base

If Not lvds_1.of_ChangeDataObject('dw_ge038_pafecf_dados_filial') Then 
	Destroy(lvds_1)
	Return False
End If 

ll_Retorno = lvds_1.Retrieve(ivl_Filial)

If ll_Retorno <> -1 Then
	
	//BLOCO 0 - registro 0000
	For ll_Linha = 1 To lvds_1.RowCount()
		
		// 0 0 0 0
		
		//Fixo, indica Bloco 0, registro 0000
		ls_Registro  = '|0000|'
		
		//Vers$$HEX1$$e300$$ENDHEX$$o do layout conforme tabela do Ato Cotepe
		//2014.08.15 - Marlon
		//ls_Registro  += '003|'
		ls_Registro  += '010|'
		
		//Finalidade do arquivo (0 - Remessa original, 1 - Remessa substituto)
		ls_Registro  += '0|'
		
		//Data Inicial dos dados no arquivo
		ls_Registro += String(pdh_Inicial,"DDMMYYYY") + "|"
		
		//Data final dos dados no arquivo
		ls_Registro += String(pdh_Final	,"DDMMYYYY") + "|"
		
		//Nome empresarial
		ls_Registro += LeftA(lvds_1.Object.nm_Razao_Social[ll_Linha],100) + "|"
		
		//CNPJ
		ls_Aux = lvds_1.Object.nr_Cgc[ll_Linha]
		ls_Aux = gf_Replace(ls_Aux,".","",0)
		ls_Aux = gf_Replace(ls_Aux,"-","",0)
		ls_Aux = gf_Replace(ls_Aux,"/","",0)
		
		ls_Registro += LeftA(ls_Aux + Space(14) ,14) + "||"
		
		//UF
		ls_Registro += LeftA(lvds_1.Object.cd_unidade_federacao [ll_Linha] + Space(2)  ,2) + "|"
		
		//Inscri$$HEX2$$e700e300$$ENDHEX$$o Estadual
		ls_Aux = lvds_1.Object.nr_Inscricao_Estadual[ll_Linha]
		ls_Aux = gf_Replace(ls_Aux,".","",0)
		ls_Aux = gf_Replace(ls_Aux,"-","",0)
		ls_Aux = gf_Replace(ls_Aux,"/","",0)
		
		ls_Registro += LeftA(ls_Aux,14) + "|"
		
		//Codigo municipio IBGE		
		//ls_Registro += Space(07)
		ls_Registro += "4209102|"
		
		//Inscri$$HEX2$$e700e300$$ENDHEX$$o Municipal
		ls_Registro += "|"
		
		//Inscri$$HEX2$$e700e300$$ENDHEX$$o na SUFRAMA
		//ls_Registro += Space(09)
		ls_Registro += "|"		
		
		//Perfil de apresenta$$HEX2$$e700e300$$ENDHEX$$o do arquivo fiscal (A,B,C)
		ls_Registro += "A|"
		
		//Tipo de Atividade (0,1)
		ls_Registro += "1|"

		If FileWrite(pl_arquivo,ls_Registro) = -1 Then
			lb_Sucesso = False
			Exit
		End If
		
		ll_Contador++
		
		
		
		// 0 0 0 1
		
		//Fixo, indica Bloco 0, registro 0001
		ls_Registro  = '|0001|'
		
		//Indica se bloco contem dados ou nao (0,1)
		ls_Registro  += '0|'
		
		If FileWrite(pl_arquivo,ls_Registro) = -1 Then
			lb_Sucesso = False
			Exit
		End If
		
		ll_Contador++
		
		//	 0 0 0 5
		
		//Fixo, indica Bloco 0, registro 0005
		ls_Registro  = '|0005|'
		
		//Nome Fantasia
		ls_Registro += LeftA(lvds_1.Object.nm_fantasia[ll_Linha],60) + "|"
		
		//Numero do CEP
		ls_Registro += LeftA(lvds_1.Object.nr_cep		[ll_Linha] + "00000000" ,8) + "|"
			
		//Endere$$HEX1$$e700$$ENDHEX$$o
		ls_Registro += LeftA(lvds_1.Object.de_endereco[ll_Linha],60) + "|"
		
		//N$$HEX1$$fa00$$ENDHEX$$mero Endere$$HEX1$$e700$$ENDHEX$$o
		ls_Registro += LeftA(String(lvds_1.Object.nr_endereco[ll_Linha]),10) + "|"
		
		//Complemento
		ls_Registro += "|"
		
		//Bairro
		ls_Registro += LeftA(lvds_1.Object.de_bairro	[ll_Linha],60) + "|"
		
		//Telefone (DDD+FONE)
		ls_Registro += LeftA(lvds_1.Object.nr_ddd_telefone[ll_Linha] + lvds_1.Object.nr_telefone[ll_Linha] + Space(10) ,10) + "|"
		
		//Telefone Fax (DDD+FONE)
		ls_Registro += LeftA(lvds_1.Object.nr_ddd_fax[ll_Linha] + lvds_1.Object.nr_fax[ll_Linha] + Space(10) ,10) + "|"
		
		//Email
		ls_Registro += "|"
		
		If FileWrite(pl_arquivo,ls_Registro) = -1 Then
			lb_Sucesso = False
			Exit
		End If
		
		ll_Contador++
		
		//	0 0 1 5
		
		//Fixo, indica Bloco 0, registro 0015
		ls_Registro  = '|0015|'
		
		//UF
		ls_Registro += LeftA(lvds_1.Object.cd_unidade_federacao [ll_Linha] + Space(2)  ,2) + "|"
		
		//Inscri$$HEX2$$e700e300$$ENDHEX$$o Estadual
		ls_Aux = lvds_1.Object.nr_Inscricao_Estadual[ll_Linha]
		ls_Aux = gf_Replace(ls_Aux,".","",0)
		ls_Aux = gf_Replace(ls_Aux,"-","",0)
		ls_Aux = gf_Replace(ls_Aux,"/","",0)
		
		ls_Registro += LeftA(ls_Aux,14) + "|"
		
		If FileWrite(pl_arquivo,ls_Registro) = -1 Then
			lb_Sucesso = False
			Exit
		End If
		
		ll_Contador++
		
		
		// 0 1 0 0 
		
 		//Fixo, indica Bloco 0, registro 0100
		ls_Registro  = '|0100|'
		
		//Nome do Contabilista
		ls_Registro  += 'SONIA BRESCIANI MARIANO|'
		
		//CPF do Contabilista
		ls_Registro  += '48624799953|'
		
		//CRC do Contabilista
		ls_Registro  += '10253374|'
		
		//CNPJ do Contabilista
		ls_Registro  += '|'
		
		//CEP
		ls_Registro  += '89201400|'
		
		//Endere$$HEX1$$e700$$ENDHEX$$o
		ls_Registro  += 'RUA NOVE DE MAR$$HEX1$$c700$$ENDHEX$$O|'
		
		//N$$HEX1$$fa00$$ENDHEX$$mero Endere$$HEX1$$e700$$ENDHEX$$o
		ls_Registro  += '638|'
		
		//Complemento
		ls_Registro  += '|'
		
		//Bairro
		ls_Registro  += 'CENTRO|'
		
		//Telefone
		ls_Registro  += '4734619953|'
		
		//Telefone Fax
		ls_Registro  += '4734619959|'
		
		//Email
		//2014.08.15 - Marlon
		//ls_Registro  += '|'
		ls_Registro  += 'sonia.mariano@clamed.com.br|'
		
		//Codigo cidade IBGE
		ls_Registro  += '4209102|'
		
		If FileWrite(pl_arquivo,ls_Registro) = -1 Then
			lb_Sucesso = False
			Exit
		End If
		
		ll_Contador++
		

		// 0 1 5 0
		//Fixo, indica Bloco 0, registro 0150
		//2014.08.15 - Marlon
		//ls_Registro  = '|0150|104538|CIA LATINO AMERICANA DE MEDICAMENTOS|01058|84683481005217||251713369|4204202||R. 9 MARCO|0||350N|'
		ls_Registro  = '|0150|104538|CIA LATINO AMERICANA DE MEDICAMENTOS|01058|84683481005217||251713369|4204202||R. 9 MARCO|0||CENTRO|'
		
		If FileWrite(pl_arquivo,ls_Registro) = -1 Then
			lb_Sucesso = False
			Exit
		End If
		ll_Contador++
		cont_bloco.cont_0150 = 1
		
				
		// 0 1 9 0	
		dc_uo_ds_base lvds_2
		lvds_2 = Create dc_uo_ds_base
		
		If Not lvds_2.of_ChangeDataObject('dw_ge038_pafecf_unidade_medida') Then 
			Destroy(lvds_1)
			Destroy(lvds_2)
			Return False
		End If
		
//		lvds_2.of_AppendWhere("n.dh_movimentacao_caixa >= '" + String(pdh_Inicial,"YYYY/MM/DD") + "' and n.dh_movimentacao_caixa <= '" + String(pdh_Final,"YYYY/MM/DD") + "'")		
		//lvds_2.of_AppendWhere("n.dh_emissao between '" + String(pdh_inicial, "YYYYMMDD") + "' AND '" + String(RelativeDate(pdh_final,1), "YYYYMMDD") + "'",2)
		
		ll_Retorno = lvds_2.Retrieve(Datetime(pdh_inicial),Datetime(RelativeDate(pdh_final,1)),ivl_Filial)
		
		If ll_Retorno <> -1 Then
			For ll_Linha2 = 1 To lvds_2.RowCount()
				//Fixo, indica Bloco 0, registro 0190
				ls_Registro  = '|0190|'
				
				//Codigo da unidade medida
				ls_Registro += LeftA(lvds_2.Object.cd_unidade_medida[ll_Linha2],6) + "|"
				
				//Descri$$HEX2$$e700e300$$ENDHEX$$o da unidade medida
				ls_Registro += lvds_2.Object.de_unidade_medida[ll_Linha2] + "|"
				
				If FileWrite(pl_arquivo,ls_Registro) = -1 Then
					lb_Sucesso = False
					Exit
				End If
				
				ll_Contador++
				cont_bloco.cont_0190++
			Next			
		End If	
		
		Destroy(lvds_2)
		
		
		// 0 2 0 0		
		lvds_2 = Create dc_uo_ds_base
		
		If Not lvds_2.of_ChangeDataObject('dw_ge038_pafecf_produto') Then 
			Destroy(lvds_1)
			Destroy(lvds_2)
			Return False
		End If
		
//		lvds_2.of_AppendWhere("nf_venda.dh_movimentacao_caixa >= '" + String(pdh_Inicial,"YYYY/MM/DD") + "' and nf_venda.dh_movimentacao_caixa <= '" + String(pdh_Final,"YYYY/MM/DD") + "'")		
		lvds_2.of_AppendWhere("nf_venda.dh_emissao >= '" + String(pdh_inicial, "YYYYMMDD") + "'" + &
									 " AND nf_venda.dh_emissao < dbo.adddate('day', 1,'" + String(pdh_final, "YYYYMMDD") + "')")
		
		ll_Retorno = lvds_2.Retrieve()
		
		If ll_Retorno <> -1 Then
			For ll_Linha2 = 1 To lvds_2.RowCount()
				//Fixo, indica Bloco 0, registro 0200
				ls_Registro  = '|0200|'
				
				//Codigo do produto
				ll_Produto = lvds_2.Object.cd_produto[ll_Linha2]
				ls_Registro += LeftA(String(lvds_2.Object.cd_produto[ll_Linha2]),60) + "|"
				
				//Descri$$HEX2$$e700e300$$ENDHEX$$o do produto
				ls_Registro += lvds_2.Object.de_produto[ll_Linha2] + "|"
				
				//Codigo de barras do produto / Codigo anterior do item / Unidade de medida / Tipo do item
				ls_Registro += "||" + LeftA(lvds_2.Object.cd_un[ll_Linha2],6) + "|00|"
				
				//Codigo NCM, nomenclatura comum mercosul / Codigo EX, conforme TIPI / Coodigo do genero do item / Codigo do servi$$HEX1$$e700$$ENDHEX$$o
				ls_Registro += LeftA(String(lvds_2.Object.nr_classificacao_fiscal[ll_Linha2]) + "00000000", 8) + "||30||"
				
				//2014.08.15 - Marlon
				Select tp.pc_icms 
				Into :ldc_Aliq
				from tipo_icms tp
					join produto_geral p on p.cd_produto = :ll_Produto
							and p.cd_tipo_icms = tp.cd_tipo_icms
				Using SQLCa;
				
				//Aliquota ICMS
				ls_Registro += String(ldc_Aliq)+"|"
				
				If FileWrite(pl_arquivo,ls_Registro) = -1 Then
					lb_Sucesso = False
					Exit
				End If
				
				cont_bloco.cont_0200++
				ll_Contador++
			Next			
		End If	
		
		Destroy(lvds_2)	
		
		
		// 0 4 0 0		
		
		//Fixo, indica Bloco 0, registro 0400
		ls_Registro  = '|0400|'
		
		//Codigo da natureza operacao
		ls_Registro += "0000000050|"
		
		//Descri$$HEX2$$e700e300$$ENDHEX$$o da natureza operacao
		ls_Registro += "Venda consumidor final|"
		
		If FileWrite(pl_arquivo,ls_Registro) = -1 Then
			lb_Sucesso = False
			Exit
		End If	
		
		ll_Contador++

		
		// 0 9 9 0	
		
		//Fixo, indica Bloco 0, registro 0990
		ls_Registro  = '|0990|'
		
		//Contador de Linhas do Bloco 0
		ll_Contador++
		ls_Registro  += String(ll_Contador) + '|'
		
		If FileWrite(pl_arquivo,ls_Registro) = -1 Then
			lb_Sucesso = False
			Exit
		End If
		cont_bloco.cont_0990 = ll_Contador
	Next
	
End If

Destroy(lvds_1)

Return lb_Sucesso




end function

public function boolean of_inconsistencia_impressora_fiscal (long pl_ecf);DateTime ldh_primeira_venda

String lvs_Serie
String lvs_Hash
String lvs_data
String lvs_situacao

 Select	nr_serie,
			COALESCE( TO_CHAR( dh_primeira_venda_dia, 'DD/MM/YYYY HH24:MI:SS' ), '' ),
			id_situacao
	Into	:lvs_Serie,
			:lvs_data,
			:lvs_situacao
	From impressora_fiscal i
  Where i.nr_ecf = :pl_ecf
  Using SQLCa;
  
 Select	de_hash
	Into	:lvs_Hash
	From impressora_fiscal_paf p
  Where p.nr_ecf = :pl_ecf
  Using SQLCa;  
  
If SQLCa.SQLCode = 0 Then
	If Trim(lvs_Hash) <> "" And Not IsNull(lvs_Hash) Then
		If lvs_Hash <> gf_Captura_Hash(String(pl_Ecf) + lvs_Serie + lvs_situacao + lvs_data) Then
			Return True
		End If
	Else		
		Update impressora_fiscal
			Set nr_serie = :lvs_serie
		 Where nr_ecf	= :pl_ecf
		 Using SQLCa;
		 
		If SQLCa.SQLCode <> -1 Then	
			SQLCa.of_Commit()
		End If		
	End If
End If
  
Return False
end function

public function boolean of_pafecf_registro_r07_old (long pl_ecf, date pdh_inicial, date pdh_final, long pl_arquivo, ref boolean pb_evidenciado);
Boolean 	lb_Sucesso = True

String 	ls_Registro

Long 	 	ll_Row
Long     ll_Retorno

String ls_Modelo

dc_uo_ds_base lds_Documento

lds_Documento = Create dc_uo_ds_base

If Not lds_Documento.of_ChangeDataObject('dw_ge038_pafecf_documento') Then Return False

ll_Retorno = lds_Documento.Retrieve(pl_ecf, pdh_inicial, pdh_final)

If ll_Retorno <> -1 Then

	For ll_Row = 1 To lds_Documento.RowCount()
				
		ls_Registro += 'R07'
		
		ls_Registro += LeftA(This.nr_Serie + Space(20), 20)
	
		ls_Registro += LeftA(This.id_MfAdicional, 1)
					 
		// Acerto para inserir ? nos espa$$HEX1$$e700$$ENDHEX$$os em branco dos registros alterados
		ls_Modelo = Space(20)
						
		//Verifica se h$$HEX1$$e100$$ENDHEX$$ altera$$HEX2$$e700e300$$ENDHEX$$o nos dados da ECF
		If of_inconsistencia_impressora_fiscal(pl_ecf) Then
			ls_Modelo = FillA("?", 20)
			ls_Registro += gf_Replace(LeftA( This.de_Modelo + ls_Modelo , 20 ), " ", "?", 0)		
			pb_evidenciado = True		
		//Verifica se h$$HEX1$$e100$$ENDHEX$$ altera$$HEX2$$e700e300$$ENDHEX$$o nos dados dos documentos ECF
		ElseIf of_inconsistencia_documento_ecf(pl_ecf, Date(lds_Documento.object.dh_final[ll_row]), lds_Documento.object.nr_coo[ll_row]) Then		
			ls_Modelo = FillA("?", 20)
			ls_Registro += gf_Replace(LeftA( This.de_Modelo + ls_Modelo , 20 ), " ", "?", 0)
			pb_evidenciado = True				
		Else			
			ls_Registro += LeftA( This.de_Modelo + ls_Modelo , 20 )
		End If
		
		ls_Registro += '01'
		
		ls_Registro += String(lds_Documento.object.nr_coo[ll_row],'000000')
		
		ls_Registro += String(lds_Documento.object.nr_ccf[ll_row],'000000')

		ls_Registro += String(lds_Documento.object.nr_gnf[ll_row],'000000')

		Choose Case lds_Documento.object.cd_forma_pagamento[ll_row]
			Case 'DI'
				ls_Registro += 'DINHEIRO       '
			Case 'HA'
				ls_Registro += 'CHEQUE         '
			Case 'HP'
				ls_Registro += 'CHEQUE-PRE     '
			Case 'CA'
				ls_Registro += 'CARTAO DEBITO  '
			Case 'CP'
				ls_Registro += 'CARTAO CREDITO '
			Case 'CV'
				ls_Registro += 'CONVENIO       '
			Case Else
				ls_Registro += 'DINHEIRO       '
		End Choose		
			
		ls_Registro += of_Formata_Valor_PafEcf(lds_Documento.object.vl_documento[ll_row],11,02)
		
		ls_Registro += 'N'
		
		ls_Registro += FillA("0", 13)

		If FileWrite(pl_arquivo,ls_Registro) = -1 Then lb_Sucesso = False
		
		ls_Registro = ''
		
		If Not lb_Sucesso Then Exit
		
	Next
	
Else
	lb_Sucesso = False
	
End If	

Destroy(lds_Documento)

Return lb_Sucesso
end function

public function boolean of_carrega_dados_ecf (long pl_ecf);If gvo_Parametro.cd_filial = 534 Then
	Select nr_serie,   
			 id_situacao,   
			 de_fabricante,   
			 de_modelo,   
			 de_tipo,
			 nr_versao_swbasico,
			 dh_swbasico,
			 id_mfadicional,
			 cd_identificacao_nacional,
			 nr_serie_mfd
	 Into :This.nr_Serie,
			:This.Id_Situacao,
			:This.de_marca,
			:This.de_modelo,
			:This.de_tipo,
			:This.nr_versao_swbasico,
			:This.dh_swbasico,
			:This.id_mfadicional,
			:This.cd_identificacao_nacional,
			:This.nr_serie_mfd
	 From impressora_fiscal  
	Where impressora_fiscal.nr_ecf = :pl_ecf
	    And impressora_fiscal.cd_filial = :ivl_filial
	Using Sqlca;
Else
	Select nr_serie,   
			 id_situacao,   
			 de_fabricante,   
			 de_modelo,   
			 de_tipo,
			 nr_versao_swbasico,
			 dh_swbasico,
			 id_mfadicional,
			 cd_identificacao_nacional,
			 nr_serie_mfd
	 Into :This.nr_Serie,
			:This.Id_Situacao,
			:This.de_marca,
			:This.de_modelo,
			:This.de_tipo,
			:This.nr_versao_swbasico,
			:This.dh_swbasico,
			:This.id_mfadicional,
			:This.cd_identificacao_nacional,
			:This.nr_serie_mfd
	 From impressora_fiscal  
	Where impressora_fiscal.nr_ecf = :pl_ecf
	Using Sqlca;
End If

If Sqlca.Sqlcode = -1 Then
	Sqlca.of_MsgDbError('Localiza$$HEX2$$e700e300$$ENDHEX$$o de par$$HEX1$$e200$$ENDHEX$$metros da ECF.')
	Return False
End If

Return True
end function

public function boolean of_inconsistencia_saldo_produto (long pl_produto, date pdt_saldo, boolean pb_update, long pl_quantidade);
Long lvl_Saldo, lvl_Saldo_Anterior

String lvs_Hash
String lvs_Data

If PDV.fabricante = "NFCE" Then  Return False  //PAF-NFC-e n$$HEX1$$e300$$ENDHEX$$o necessita a marca$$HEX2$$e700e300$$ENDHEX$$o.

pdt_Saldo = gf_Primeiro_Dia_Mes(pdt_Saldo)

Select COALESCE( TO_CHAR( dh_saldo, 'DD/MM/YYYY HH24:MI:SS' ), '' ),
			qt_saldo_final
	Into	:lvs_data,
			:lvl_Saldo
	From saldo_produto s
  Where s.cd_produto = :pl_Produto
	 and s.dh_saldo	= :pdt_Saldo
  Using SQLCa;
  
Select 	de_hash
	Into	:lvs_Hash
	From saldo_produto_paf p
  Where p.cd_produto = :pl_Produto
	 and p.dh_saldo	= :pdt_Saldo
  Using SQLCa;  

If SQLCa.SQLCode = 0 Then	
	If Trim(lvs_Hash) <> "" And Not IsNull(lvs_Hash) Then
		If lvs_Hash <> gf_Captura_Hash(String(pl_Produto) + lvs_data + String(lvl_Saldo)) Then
			Return True
		End If 
	Else
		Update saldo_produto
			Set qt_saldo_final 		= qt_saldo_final
		  Where cd_produto = :pl_Produto
			 and dh_saldo	= :pdt_Saldo
		 Using SQLCa;
		 
		If SQLCa.SQLCode <> -1 Then	
			SQLCa.of_Commit()
		End If	
	End If				
End If
  
Return False

end function

public function boolean of_pafecf_registro_r05 (long pl_ecf, date pdh_inicial, date pdh_final, long pl_arquivo, ref boolean pb_evidenciado);
Boolean 	lb_Sucesso = True

String 	ls_Registro
String   ls_Tributacao

Long 	 	ll_Row
Long		ll_row2
Long     ll_Retorno
Long 		ll_Item
Long     ll_Doc_Anterior
Long ll_filial
Long ll_nota
Long ll_mapa
Long ll_ecf
String ls_serie
String ls_especie
long ll_produto
long ll_natureza
string ls_sit_trib

Decimal {2} ldc_Desconto, ldc_icms
 
String ls_Modelo

Date ldt_emissao

dc_uo_ds_base lds_Item

lds_Item = Create dc_uo_ds_base

If Not lds_Item.of_ChangeDataObject('dw_ge038_pafecf_produto_cupom_fiscal') Then Return False

ll_Retorno = lds_Item.Retrieve(pl_ecf,pdh_inicial,pdh_final)

If ll_Retorno <> -1 Then

	For ll_Row = 1 To lds_Item.RowCount()		
		
		If ll_Doc_Anterior <> lds_Item.object.nr_nf[ll_row] Then
			ll_Doc_Anterior = lds_Item.object.nr_nf[ll_row]
			ll_Item = 1
		End If
		
		ldc_icms = lds_Item.object.pc_icms[ll_row]
		ll_ecf	= lds_Item.object.nr_ecf[ll_row]		
		ldt_emissao = Date(lds_Item.object.dh_data_fiscal[ll_row])
		
		Select nr_mapa 
			into :ll_mapa		
		from mapa_resumo where 
			dh_emissao = :ldt_emissao
		Using sqlca;		
		
		
		ll_filial = lds_Item.object.cd_filial[ll_row]
		ll_nota = lds_Item.object.nr_nf[ll_row]
		ls_especie = lds_Item.object.de_especie[ll_row]
		ls_serie	= lds_Item.object.de_serie[ll_row]
		
		ldc_Desconto = lds_Item.object.vl_preco_unitario[ll_row] - lds_Item.object.vl_preco_praticado[ll_row]
					
		ls_Registro = 'R05'
		
		ls_Registro += LeftA(This.nr_Serie + Space(20), 20)
	
		ls_Registro += LeftA(This.id_MfAdicional, 1)
		
		// Acerto para inserir ? nos espa$$HEX1$$e700$$ENDHEX$$os em branco dos registros alterados
		ls_Modelo = Space(20)
		
		//Verifica se h$$HEX1$$e100$$ENDHEX$$ altera$$HEX2$$e700e300$$ENDHEX$$o nos dados da ECF
		If of_inconsistencia_impressora_fiscal(pl_ecf) Then
			ls_Modelo = FillA("?", 20)
			ls_Registro += gf_Replace(LeftA( This.de_Modelo + ls_Modelo , 20 ), " ", "?", 0)			
			pb_evidenciado = True	
		ElseIf of_inconsistencia_nf_venda(lds_Item.object.nr_nf[ll_row], gvo_Parametro.of_Filial(), ls_especie, ls_serie, False) Then
			ls_Modelo = FillA("?", 20)
			ls_Registro += gf_Replace(LeftA( This.de_Modelo + ls_Modelo , 20 ), " ", "?", 0)	
			pb_evidenciado = True			
		ElseIf of_inconsistencia_item_nf_venda(lds_Item.object.nr_nf[ll_row], gvo_Parametro.of_Filial(), lds_Item.object.cd_produto[ll_row], ls_especie, ls_serie) Then
			ls_Modelo = FillA("?", 20)
			ls_Registro += gf_Replace(LeftA( This.de_Modelo + ls_Modelo , 20 ), " ", "?", 0)	
			pb_evidenciado = True			
		ElseIf of_inconsistencia_produto_geral(lds_Item.object.cd_produto[ll_row]) Then
			ls_Modelo = FillA("?", 20)
			ls_Registro += gf_Replace(LeftA( This.de_Modelo + ls_Modelo , 20 ), " ", "?", 0)	
			pb_evidenciado = True
		ElseIf ldc_icms > 0 Then
				If of_inconsistencia_aliquota_ecf_produto(ll_mapa, gvo_Parametro.of_Filial(), ll_ecf, ldc_icms) Then
					ls_Modelo = FillA("?", 20)
					ls_Registro += gf_Replace(LeftA( This.de_Modelo + ls_Modelo , 20 ), " ", "?", 0)	
					pb_evidenciado = True
				Else
					ls_Registro += LeftA( This.de_Modelo + ls_Modelo , 20 )					
				End If
		Else
			ls_Registro += LeftA( This.de_Modelo + ls_Modelo , 20 )
		End If
		
		ls_Registro += '01'
		
		ls_Registro += String(lds_Item.object.nr_operacao_ecf[ll_row],'000000000')
		
		ls_Registro += String(lds_Item.object.nr_ccf[ll_row],'000000000')		
				
		ls_Registro += String(ll_Item,'000')
		
		ls_Registro += LeftA(String(lds_Item.object.cd_produto[ll_row]) + Space(14) , 14 )		
	
		ls_Registro += LeftA(lds_Item.object.de_produto[ll_row] + Space(100),100)	
		
		ls_Registro += String(lds_Item.object.qt_vendida[ll_row],'0000000')
		
		ls_Registro += LeftA(lds_Item.object.cd_un[ll_row] + Space(3) ,3)
		
		ls_Registro += of_Formata_Valor_PafEcf(lds_Item.object.vl_preco_unitario[ll_row],6,2)
		
		ls_Registro += of_Formata_Valor_PafEcf(ldc_Desconto,6,2)
		
		ls_Registro += FillA("0", 8)
		
		ls_Registro += of_Formata_Valor_PafEcf(lds_Item.object.vl_preco_praticado[ll_row],12,2)
		
		Choose Case lds_Item.object.pc_icms[ll_row]
			Case 7    ; ls_Tributacao = "01T0700"
			Case 12   ; ls_Tributacao = "02T1200"
			Case 25   ; ls_Tributacao = "03T2500"		
			Case 17   ; ls_Tributacao = "04T1700"
			Case 18	 ; ls_Tributacao = "05T1800"
			Case Else 
				If lds_Item.object.cd_situacao_tributaria[ll_row] = '06' Then
					ls_Tributacao = "F1     "
				Else
					ls_Tributacao = "I1     "
				End If
		End Choose
	
		ls_Registro += ls_Tributacao
		
		ls_Registro += 'N'
		
		ls_Registro += FillA("0", 7)
		
		ls_Registro += FillA("0", 13)
		
		ls_Registro += FillA("0", 13)
		
		ls_Registro += 'A'
		
		ls_Registro += 'T'
		
		ls_Registro += '0'
		
		ls_Registro += '2'
								
		//If FileWrite(pl_arquivo,ls_Registro) = -1 Then lb_Sucesso = False
		
		If Not This.of_grava_registro_temp( 'R05', '', '', '', ls_Registro ) Then
			lb_Sucesso = False
		End If
		
		ls_Registro = ''
		
		If Not lb_Sucesso Then Exit
		
		ll_Item ++
		
		
		//Itens cancelados
		dc_uo_ds_base lds_Item_cancelado		
		lds_Item_cancelado = Create dc_uo_ds_base
		
		If Not lds_Item_cancelado.of_ChangeDataObject('dw_ge038_pafecf_produto_cupom_fiscal_cancelado') Then Return False
		
		ll_Retorno = lds_Item_cancelado.Retrieve(ll_filial, ll_nota, ls_especie, ls_serie)
		
		If ll_Retorno <> -1 Then
			
			For ll_Row2 = 1 To lds_Item_cancelado.RowCount()				
				
				ll_produto = lds_Item_cancelado.object.cd_produto[ll_row2]
				
				uo_produto             			lvo_produto
				lvo_produto = Create uo_produto
				
				lvo_produto.of_localiza_codigo_interno(ll_produto)			
				
				UO_TRATAMENTO_FISCAL             			lvo_tratamento_fiscal
				If IsValid(lvo_tratamento_fiscal) Then Destroy lvo_tratamento_fiscal
				lvo_tratamento_fiscal = CREATE UO_TRATAMENTO_FISCAL
				lvo_tratamento_fiscal.of_grava_contribuinte(FALSE)
				lvo_tratamento_fiscal.of_grava_uf_origem_destino(gvo_parametro.ivs_uf_filial,gvo_parametro.ivs_uf_filial)
				lvo_tratamento_fiscal.of_grava_operacao(lvo_tratamento_fiscal.VENDA)
				lvo_tratamento_fiscal.of_grava_tipo_venda('AV')	
				
				UO_ATRIBUTO_FISCAL_ITEM_NF  					lvo_atributo
				lvo_atributo = Create UO_ATRIBUTO_FISCAL_ITEM_NF	
				
				lvo_atributo = lvo_tratamento_fiscal.of_atributo_fiscal_produto(lvo_produto)

//				If Not lvo_atributo.Localizado Then
//				End If
				
				ll_natureza = lvo_atributo.cd_natureza_operacao
				ls_sit_trib = lvo_atributo.cd_situacao_tributaria
				ldc_icms = lvo_atributo.pc_icms						
					
				ldc_Desconto = lds_Item_cancelado.object.vl_preco_bruto[ll_row2] - lds_Item_cancelado.object.vl_preco_praticado[ll_row2]
							
				ls_Registro = 'R05'
				
				ls_Registro += LeftA(This.nr_Serie + Space(20), 20)
			
				ls_Registro += LeftA(This.id_MfAdicional, 1)
				
				// Acerto para inserir ? nos espa$$HEX1$$e700$$ENDHEX$$os em branco dos registros alterados
				ls_Modelo = Space(20)
				
				//Verifica se h$$HEX1$$e100$$ENDHEX$$ altera$$HEX2$$e700e300$$ENDHEX$$o nos dados da ECF
				If of_inconsistencia_impressora_fiscal(pl_ecf) Then
					ls_Modelo = FillA("?", 20)
					ls_Registro += gf_Replace(LeftA( This.de_Modelo + ls_Modelo , 20 ), " ", "?", 0)			
					pb_evidenciado = True	
				ElseIf of_inconsistencia_nf_venda(lds_Item_cancelado.object.nr_nf[ll_row2], gvo_Parametro.of_Filial(), ls_especie, ls_serie, False) Then
					ls_Modelo = FillA("?", 20)
					ls_Registro += gf_Replace(LeftA( This.de_Modelo + ls_Modelo , 20 ), " ", "?", 0)	
					pb_evidenciado = True			
				ElseIf of_inconsistencia_item_cancelado(lds_Item_cancelado.object.nr_nf[ll_row2], gvo_Parametro.of_Filial(), lds_Item_cancelado.object.cd_produto[ll_row2]) Then
					ls_Modelo = FillA("?", 20)
					ls_Registro += gf_Replace(LeftA( This.de_Modelo + ls_Modelo , 20 ), " ", "?", 0)	
					pb_evidenciado = True			
				ElseIf of_inconsistencia_produto_geral(lds_Item_cancelado.object.cd_produto[ll_row2]) Then
					ls_Modelo = FillA("?", 20)
					ls_Registro += gf_Replace(LeftA( This.de_Modelo + ls_Modelo , 20 ), " ", "?", 0)	
					pb_evidenciado = True			
				Else
					ls_Registro += LeftA( This.de_Modelo + ls_Modelo , 20 )
				End If
				
				ls_Registro += '01'
				
				ls_Registro += String(lds_Item_cancelado.object.nr_operacao_ecf[ll_row2],'000000000')
				
				ls_Registro += String(lds_Item_cancelado.object.nr_ccf[ll_row2],'000000000')		
						
				ls_Registro += String(ll_Item,'000')
				
				ls_Registro += LeftA(String(lds_Item_cancelado.object.cd_produto[ll_row2]) + Space(14) , 14 )		
			
				ls_Registro += LeftA(lds_Item_cancelado.object.de_produto[ll_row2] + Space(100),100)	
				
				ls_Registro += String(lds_Item_cancelado.object.qt_cancelada[ll_row2],'0000000')
				
				ls_Registro += LeftA(lds_Item_cancelado.object.cd_un[ll_row2] + Space(3) ,3)
				
				ls_Registro += of_Formata_Valor_PafEcf(lds_Item_cancelado.object.vl_preco_bruto[ll_row2],6,2)
				
				ls_Registro += of_Formata_Valor_PafEcf(ldc_Desconto,6,2)
				
				ls_Registro += FillA("0", 8)
				
				ls_Registro += of_Formata_Valor_PafEcf(lds_Item_cancelado.object.vl_preco_praticado[ll_row2],12,2)
				
				Choose Case long(ldc_icms)
					Case 7    ; ls_Tributacao = "01T0700"
					Case 12   ; ls_Tributacao = "02T1200"
					Case 25   ; ls_Tributacao = "03T2500"		
					Case 17   ; ls_Tributacao = "04T1700"
					Case 18	 ; ls_Tributacao = "05T1800"
					Case Else 
						If ls_sit_trib = '06' Then
							ls_Tributacao = "F1     "
						Else
							ls_Tributacao = "I1     "
						End If
				End Choose
			
				ls_Registro += ls_Tributacao
				
				ls_Registro += 'S'
				
				ls_Registro += FillA("0", 7)
				
				ls_Registro += FillA("0", 13)
				
				ls_Registro += FillA("0", 13)
				
				ls_Registro += 'A'
				
				ls_Registro += 'T'
				
				ls_Registro += '0'
				
				ls_Registro += '2'
										
				//If FileWrite(pl_arquivo,ls_Registro) = -1 Then lb_Sucesso = False
				
				If Not This.of_grava_registro_temp( 'R05', '', '', '', ls_Registro ) Then
					lb_Sucesso = False
				End If
				
				ls_Registro = ''
				
				If Not lb_Sucesso Then Exit
				
				ll_Item ++
			Next
		End If		// fim cancelados
		
		
	Next
	

	
	
Else
	lb_Sucesso = False
	
End If

Destroy(lds_Item)

Return lb_Sucesso
end function

public function boolean of_pafecf_registro_r01 (long pl_ecf, date pdh_inicial, date pdh_final, long pl_arquivo, ref boolean pb_evidenciado);Boolean lb_Sucesso = False

Long ll_Retorno
Long ll_Linha 

String ls_Registro
String ls_Modelo
String ls_Insc_estadual

//dc_uo_ds_base lvds_1
//lvds_1 = Create dc_uo_ds_base
//
//If Not lvds_1.of_ChangeDataObject('dw_ge038_pafecf_alteracao_r01') Then 
//	Destroy(lvds_1)
//	Return False
//End If 
//
//ll_Retorno = lvds_1.Retrieve()
//
//If ll_Retorno <> -1 Then
	
	ls_Registro = 'R01' 
	
	ls_Registro += LeftA(This.nr_Serie + Space(20), 20)
	
	ls_Registro += LeftA(This.id_MfAdicional, 1)
	
	If IsNull(This.de_Tipo) Then 
		ls_Registro += Space(07)
	Else				 
		ls_Registro += LeftA(This.de_Tipo + Space(07) , 07 )
	End If
	
	If IsNull(This.de_Marca) Then
		ls_Registro += Space(20)
	Else	
		ls_Registro += LeftA(This.de_Marca + Space(20) , 20 )
	End If	
	
	ls_Modelo = Space(20)
	
	//Verifica se h$$HEX1$$e100$$ENDHEX$$ altera$$HEX2$$e700e300$$ENDHEX$$o nos dados da ECF
	If of_inconsistencia_impressora_fiscal(pl_ecf) Then
		ls_Modelo = FillA("?", 20)
		ls_Registro += gf_Replace(LeftA( This.de_Modelo + ls_Modelo , 20 ), " ", "?", 0)
		pb_evidenciado = True
	ElseIf of_inconsistencia_filial(gvo_Parametro.of_Filial()) Then
		ls_Modelo = FillA("?", 20)
		ls_Registro += gf_Replace(LeftA( This.de_Modelo + ls_Modelo , 20 ), " ", "?", 0)
		pb_evidenciado = True
	Else			
		ls_Registro += LeftA( This.de_Modelo + ls_Modelo , 20 )
	End If
					 
	ls_Registro += LeftA( This.nr_Versao_SWBasico + Space(10) , 10 )
					 
	If	IsNull(This.dh_SWBasico) Then 
		ls_Registro += Space(08)	// Data
		ls_Registro += Space(06)	// Hora
	Else
		ls_Registro += String(This.dh_SWBasico,'yyyymmdd')
		ls_Registro += String(This.dh_SWBasico,'hhmmss')
	End If
	
	ls_Registro += String(pl_ecf,'000')
	
	//CNPJ Loja
	ls_Registro += LeftA(gvo_parametro.nr_cgc + Space(14),14)
	
	//Inscri$$HEX2$$e700e300$$ENDHEX$$o Estadual Loja
	ls_Insc_Estadual = gf_replace(gvo_parametro.nr_inscricao_estadual,'.','',0)
	
	ls_Registro += LeftA(ls_Insc_Estadual + Space(14),14)
	
	//CNPJ Matriz
	ls_Registro += '84683481000177'
	
	//Inscri$$HEX2$$e700e300$$ENDHEX$$o Estadual Matriz
	ls_Registro += '250330539     '
	
	//Inscri$$HEX2$$e700e300$$ENDHEX$$o Municipal Matriz
	ls_Registro += Space(14)
	
	//Raz$$HEX1$$e300$$ENDHEX$$o Social Matriz - Desenvolvedora
	If of_inconsistencia_inclusao_exclusao() Then		
		ls_Registro += LeftA('CIA?LATINO?AMERICANA?DE?MEDICAMENTOS' + FillA("?", 40),40)
		pb_evidenciado = True
	Else
		ls_Registro += LeftA('CIA LATINO AMERICANA DE MEDICAMENTOS' + Space(40),40)
	End If
	
	//Software
	ls_Registro += LeftA('SISTEMA DE CAIXA' + Space(40),40)
	
	//Vers$$HEX1$$e300$$ENDHEX$$o do Software
	ls_Registro += LeftA('16.00' + Space(10),10)
	
	//Autentica$$HEX2$$e700e300$$ENDHEX$$o MD5
	ls_Registro += LeftA(ivs_MD5 + Space(32),32)
	
	//Data In$$HEX1$$ed00$$ENDHEX$$cio
	ls_Registro += String(pdh_inicial,'yyyymmdd')
	
	//Data Final
	ls_Registro += String(pdh_final,'yyyymmdd')
	
	//Vers$$HEX1$$e300$$ENDHEX$$o Especifica$$HEX2$$e700e300$$ENDHEX$$o PAF-ECF
	ls_Registro += '0206'
	
//	If FileWrite(pl_arquivo,ls_Registro) <> -1 Then
//		lb_Sucesso = True
//	End If

	Return This.of_grava_registro_temp( 'R01', '', '', '', ls_Registro )

//End If
//
//Destroy(lvds_1)

Return lb_Sucesso 
end function

public function boolean of_pafecf_registro_r02 (long pl_ecf, date pdh_inicial, date pdh_final, long pl_arquivo, ref boolean pb_evidenciado);
Boolean 	lb_Sucesso = True

Decimal{2} lvdc_Total
 
String 	ls_Registro

Long 	 	ll_Row
Long     ll_Retorno

String ls_Modelo

dc_uo_ds_base lds_Reducao
lds_Reducao = Create dc_uo_ds_base

If Not lds_Reducao.of_ChangeDataObject('dw_ge038_pafecf_reducaoz') Then Return False

ll_Retorno = lds_Reducao.Retrieve(pl_ecf,pdh_inicial,pdh_final)

If ll_Retorno <> -1 Then

	For ll_Row = 1 To lds_Reducao.RowCount()
		
		ls_Registro += 'R02' 
		
		ls_Registro += LeftA(This.nr_Serie + Space(20), 20)
		
		ls_Registro += This.id_MfAdicional
		
		// Acerto para inserir ? nos espa$$HEX1$$e700$$ENDHEX$$os em branco dos registros alterados
		ls_Modelo = Space(20)
				
		//Verifica se h$$HEX1$$e100$$ENDHEX$$ altera$$HEX2$$e700e300$$ENDHEX$$o nos dados da ECF
		If of_inconsistencia_impressora_fiscal(pl_ecf) Then
			ls_Modelo = FillA("?", 20)
			ls_Registro += gf_Replace(LeftA( This.de_Modelo + ls_Modelo , 20 ), " ", "?", 0)			
			pb_evidenciado = True
		ElseIf of_inconsistencia_mapa_resumo(lds_Reducao.object.nr_mapa[ll_row], gvo_Parametro.of_Filial()) Then
			ls_Modelo = FillA("?", 20)
			ls_Registro += gf_Replace(LeftA( This.de_Modelo + ls_Modelo , 20 ), " ", "?", 0)
			pb_evidenciado = True
		ElseIf of_inconsistencia_mapa_resumo_ecf(lds_Reducao.object.nr_mapa[ll_row], gvo_Parametro.of_Filial(), pl_ecf) Then
			ls_Modelo = FillA("?", 20)
			ls_Registro += gf_Replace(LeftA( This.de_Modelo + ls_Modelo , 20 ), " ", "?", 0)						
			pb_evidenciado = True
		Else
			ls_Registro += LeftA( This.de_Modelo + ls_Modelo , 20 )
		End If
		
		ls_Registro += '01'
		
		ls_Registro += String(lds_Reducao.object.qt_reducao_z[ll_row],'000000')
		
		ls_Registro += String(lds_Reducao.object.nr_operacao_final[ll_row],'000000000')
		
		ls_Registro += String(lds_Reducao.object.qt_reinicio_z[ll_row],'000000')
			
		ls_Registro += String(lds_Reducao.object.dh_movimento[ll_row],'yyyymmdd')
		
		ls_Registro += String(lds_Reducao.object.dh_reducao[ll_row],'yyyymmdd')
		
		ls_Registro += String(lds_Reducao.object.dh_reducao[ll_row],'hhmmss')
		
		lvdc_Total	= lds_Reducao.object.vl_total_geral_final[ll_Row] - lds_Reducao.object.vl_total_geral_inicial[ll_Row]
		
		ls_Registro += of_Formata_Valor_PafEcf(lvdc_Total,12,2)
		
		ls_Registro += 'N'
	
		//If FileWrite(pl_arquivo,ls_Registro) = -1 Then lb_Sucesso = False
		
		 If Not This.of_grava_registro_temp( 'R02', '', '', '', ls_Registro ) Then
			lb_Sucesso = False
		End If
		
		ls_Registro = ''
		
		If Not lb_Sucesso Then Exit
		
	Next
	
Else
	lb_Sucesso = False
End If	

Destroy(lds_Reducao)

Return lb_Sucesso
end function

public function boolean of_pafecf_registro_r03 (long pl_ecf, date pdh_inicial, date pdh_final, long pl_arquivo, ref boolean pb_evidenciado);
Boolean 	lb_Sucesso = True

String 	ls_Registro
String   ls_Cabecalho
String   ls_Especie
String   ls_Serie
String   ls_Indice

Long 	 	ll_Row
Long     ll_Retorno
Long 		ll_Filial
Long     ll_Mapa
Long 		ll_Aliquota

Decimal  ldc_Aliquota
		 
String ls_Modelo 

dc_uo_ds_base lds_Reducao
dc_uo_ds_base lds_Aliquota

lds_Aliquota = Create dc_uo_ds_base
lds_Reducao  = Create dc_uo_ds_base

If Not lds_Reducao.of_ChangeDataObject('dw_ge038_pafecf_reducaoz') Then Return False

If Not lds_Aliquota.of_ChangeDataObject('dw_mapa_resumo_ecf_aliq') Then Return False

ll_Retorno = lds_Reducao.Retrieve(pl_ecf,pdh_inicial,pdh_final)

If ll_Retorno <> -1 Then

	For ll_Row = 1 To lds_Reducao.RowCount()
		
		ll_Filial 	= lds_Reducao.object.cd_filial	[ll_row]
		ll_Mapa		= lds_Reducao.object.nr_mapa		[ll_row]
		ls_Especie	= lds_Reducao.object.de_especie	[ll_row]
		ls_Serie    = lds_Reducao.object.de_serie		[ll_row]
		
		
		ls_Cabecalho = ''
		
		ls_Cabecalho += 'R03' 

		ls_Cabecalho += LeftA(This.nr_Serie + Space(20), 20)		
		
		ls_Cabecalho += This.id_MfAdicional
		
		// Acerto para inserir ? nos espa$$HEX1$$e700$$ENDHEX$$os em branco dos registros alterados
		ls_Modelo = Space(20)
				
		//Verifica se h$$HEX1$$e100$$ENDHEX$$ altera$$HEX2$$e700e300$$ENDHEX$$o nos dados da ECF
		If of_inconsistencia_impressora_fiscal(pl_ecf) Then
			ls_Modelo = FillA("?", 20)
			ls_Cabecalho += gf_Replace(LeftA( This.de_Modelo + ls_Modelo , 20 ), " ", "?", 0)		
			pb_evidenciado = True	
		ElseIf of_inconsistencia_mapa_resumo_ecf(lds_Reducao.object.nr_mapa[ll_row], gvo_Parametro.of_Filial(), pl_ecf) Then
			ls_Modelo = FillA("?", 20)
			ls_Cabecalho += gf_Replace(LeftA( This.de_Modelo + ls_Modelo , 20 ), " ", "?", 0)		
			pb_evidenciado = True					
		ElseIf of_inconsistencia_aliquota_ecf(lds_Reducao.object.nr_mapa[ll_row], gvo_Parametro.of_Filial(), pl_ecf) Then
			ls_Modelo = FillA("?", 20)
			ls_Cabecalho += gf_Replace(LeftA( This.de_Modelo + ls_Modelo , 20 ), " ", "?", 0)		
			pb_evidenciado = True					
		Else			
			ls_Cabecalho += LeftA( This.de_Modelo + ls_Modelo , 20 )
		End If
		
		ls_Cabecalho += '01'
		
		ls_Cabecalho += String(lds_Reducao.object.qt_reducao_z[ll_row],'000000')
		
		ls_Registro = ''
		
		lds_Aliquota.Retrieve(ll_filial,ll_mapa,ls_especie,ls_serie)
				
		For ll_Aliquota = 1 To lds_Aliquota.RowCount()
			
			ldc_Aliquota = lds_Aliquota.object.pc_aliquota[ll_Aliquota]
			
			Choose Case ldc_Aliquota
				Case 07
					ls_Indice = '01'
				Case 12
					ls_Indice = '02'
				Case 25
					ls_Indice = '03'
				Case 17
					ls_Indice = '04'
				Case 18
					ls_Indice = '05'
			End Choose
			
			//Acerto para n$$HEX1$$e300$$ENDHEX$$o informar valores zerados
			If Dec(lds_Aliquota.object.vl_base_calculo[ll_Aliquota]) > 0 Then
				ls_Registro += ls_Cabecalho + ls_Indice + 'T' + of_Formata_Valor_PafEcf(ldc_Aliquota,2,2)
				ls_Registro += of_formata_valor_pafecf(lds_Aliquota.object.vl_base_calculo[ll_Aliquota],11,02)
				
				//If FileWrite(pl_arquivo,ls_Registro) = -1 Then lb_Sucesso = False
				
			If Not This.of_grava_registro_temp( 'R03', '', '', '', ls_Registro ) Then
					lb_Sucesso = False
				End If
			End If
			
			ls_Registro = ''
		
			If Not lb_Sucesso Then Exit
			
		Next		
		
		If Not lb_Sucesso Then Exit
		
		//Acerto para n$$HEX1$$e300$$ENDHEX$$o informar valores zerados
		If Dec(lds_Reducao.object.vl_acrescimo_iss[ll_row]) > 0 Then
			ls_Registro = ls_Cabecalho + 'AS     ' + of_formata_valor_pafecf(lds_Reducao.object.vl_acrescimo_iss[ll_row],11,02)
	
			//If FileWrite(pl_arquivo,ls_Registro) = -1 Then lb_Sucesso = False
			
			If Not This.of_grava_registro_temp( 'R03', '', '', '', ls_Registro ) Then
				lb_Sucesso = False
			End If
		End If
		
		ls_Registro = ''
		
		If Not lb_Sucesso Then Exit
		
		//Acerto para n$$HEX1$$e300$$ENDHEX$$o informar valores zerados
		If Dec(lds_Reducao.object.vl_acrescimo[ll_row]) > 0 Then
			ls_Registro = ls_Cabecalho + 'AT     ' + of_formata_valor_pafecf(lds_Reducao.object.vl_acrescimo[ll_row],11,02)
	
			//If FileWrite(pl_arquivo,ls_Registro) = -1 Then lb_Sucesso = False
			
			If Not This.of_grava_registro_temp( 'R03', '', '', '', ls_Registro ) Then
				lb_Sucesso = False
			End If
		End If
		
		ls_Registro = ''
		
		If Not lb_Sucesso Then Exit
		
		//Acerto para n$$HEX1$$e300$$ENDHEX$$o informar valores zerados
		If Dec(lds_Reducao.object.vl_cancelamento_iss[ll_row]) > 0 Then
			ls_Registro = ls_Cabecalho + 'Can-S  ' + of_formata_valor_pafecf(lds_Reducao.object.vl_cancelamento_iss[ll_row],11,02)
	
			//If FileWrite(pl_arquivo,ls_Registro) = -1 Then lb_Sucesso = False
			
			If Not This.of_grava_registro_temp( 'R03', '', '', '', ls_Registro ) Then
				lb_Sucesso = False
			End If
		End If
		
		ls_Registro = ''
		
		If Not lb_Sucesso Then Exit
		
		//Acerto para n$$HEX1$$e300$$ENDHEX$$o informar valores zerados
		If Dec(lds_Reducao.object.vl_cancelamento[ll_row]) > 0 Then		
			ls_Registro = ls_Cabecalho + 'Can-T  ' + of_formata_valor_pafecf(lds_Reducao.object.vl_cancelamento[ll_row],11,02)
	
			//If FileWrite(pl_arquivo,ls_Registro) = -1 Then lb_Sucesso = False
			
			If Not This.of_grava_registro_temp( 'R03', '', '', '', ls_Registro ) Then
				lb_Sucesso = False
			End If
		End If
		
		ls_Registro = ''
		
		If Not lb_Sucesso Then Exit
		
		//Acerto para n$$HEX1$$e300$$ENDHEX$$o informar valores zerados
		If Dec(lds_Reducao.object.vl_desconto_iss[ll_row]) > 0 Then		
			ls_Registro = ls_Cabecalho + 'DS     ' + of_formata_valor_pafecf(lds_Reducao.object.vl_desconto_iss[ll_row],11,02)
	
			//If FileWrite(pl_arquivo,ls_Registro) = -1 Then lb_Sucesso = False
			
			If Not This.of_grava_registro_temp( 'R03', '', '', '', ls_Registro ) Then
				lb_Sucesso = False
			End If
		End If
		
		ls_Registro = ''
		
		If Not lb_Sucesso Then Exit
		
		//Acerto para n$$HEX1$$e300$$ENDHEX$$o informar valores zerados
		If Dec(lds_Reducao.object.vl_desconto[ll_row]) > 0 Then	
			ls_Registro = ls_Cabecalho + 'DT     ' + of_formata_valor_pafecf(lds_Reducao.object.vl_desconto[ll_row],11,02)
	
			//If FileWrite(pl_arquivo,ls_Registro) = -1 Then lb_Sucesso = False
			
			If Not This.of_grava_registro_temp( 'R03', '', '', '', ls_Registro ) Then
				lb_Sucesso = False
			End If
		End If
		ls_Registro = ''
		
		If Not lb_Sucesso Then Exit
		
		//Acerto para n$$HEX1$$e300$$ENDHEX$$o informar valores zerados
		If Dec(lds_Reducao.object.vl_st[ll_row]) > 0 Then					
			ls_Registro = ls_Cabecalho + 'F1     ' + of_formata_valor_pafecf(lds_Reducao.object.vl_st[ll_row],11,02)
			
			//If FileWrite(pl_arquivo,ls_Registro) = -1 Then lb_Sucesso = False
			
			If Not This.of_grava_registro_temp( 'R03', '', '', '', ls_Registro ) Then
				lb_Sucesso = False
			End If
		End If
		ls_Registro = ''
		
		If Not lb_Sucesso Then Exit
		
		//Acerto para n$$HEX1$$e300$$ENDHEX$$o informar valores zerados
		If Dec(lds_Reducao.object.vl_st_iss[ll_row]) > 0 Then	
			ls_Registro = ls_Cabecalho + 'FS1    ' + of_formata_valor_pafecf(lds_Reducao.object.vl_st_iss[ll_row],11,02)
	
			//If FileWrite(pl_arquivo,ls_Registro) = -1 Then lb_Sucesso = False
			
			If Not This.of_grava_registro_temp( 'R03', '', '', '', ls_Registro ) Then
				lb_Sucesso = False
			End If
		End If
		
		ls_Registro = ''
		
		If Not lb_Sucesso Then Exit
		
		//Acerto para n$$HEX1$$e300$$ENDHEX$$o informar valores zerados
		If Dec(lds_Reducao.object.vl_isenta[ll_row]) > 0 Then	
			ls_Registro = ls_Cabecalho + 'I1     ' + of_formata_valor_pafecf(lds_Reducao.object.vl_isenta[ll_row],11,02)
	
			//If FileWrite(pl_arquivo,ls_Registro) = -1 Then lb_Sucesso = False
			
			If Not This.of_grava_registro_temp( 'R03', '', '', '', ls_Registro ) Then
				lb_Sucesso = False
			End If
		End If
		
		ls_Registro = ''
		
		If Not lb_Sucesso Then Exit
		
		//Acerto para n$$HEX1$$e300$$ENDHEX$$o informar valores zerados
		If Dec(lds_Reducao.object.vl_isento_iss[ll_row]) > 0 Then	
			ls_Registro = ls_Cabecalho + 'Is1    ' + of_formata_valor_pafecf(lds_Reducao.object.vl_isento_iss[ll_row],11,02)
	
			//If FileWrite(pl_arquivo,ls_Registro) = -1 Then lb_Sucesso = False
			
			If Not This.of_grava_registro_temp( 'R03', '', '', '', ls_Registro ) Then
				lb_Sucesso = False
			End If
		End If
		
		ls_Registro = ''
		
		If Not lb_Sucesso Then Exit
		
		//Acerto para n$$HEX1$$e300$$ENDHEX$$o informar valores zerados
		If Dec(lds_Reducao.object.vl_nao_incidencia[ll_row]) > 0 Then
			ls_Registro = ls_Cabecalho + 'N1     ' + of_formata_valor_pafecf(lds_Reducao.object.vl_nao_incidencia[ll_row],11,02)
	
			//If FileWrite(pl_arquivo,ls_Registro) = -1 Then lb_Sucesso = False
			
			If Not This.of_grava_registro_temp( 'R03', '', '', '', ls_Registro ) Then
				lb_Sucesso = False
			End If
		End If
		
		ls_Registro = ''
		
		If Not lb_Sucesso Then Exit
		
		//Acerto para n$$HEX1$$e300$$ENDHEX$$o informar valores zerados
		If Dec(lds_Reducao.object.vl_nao_incidencia_iss[ll_row]) > 0 Then
			ls_Registro = ls_Cabecalho + 'NS1    ' + of_formata_valor_pafecf(lds_Reducao.object.vl_nao_incidencia_iss[ll_row],11,02)
	
			//If FileWrite(pl_arquivo,ls_Registro) = -1 Then lb_Sucesso = False
			
			If Not This.of_grava_registro_temp( 'R03', '', '', '', ls_Registro ) Then
				lb_Sucesso = False
			End If
		End If
		
		ls_Registro = ''
		
		If Not lb_Sucesso Then Exit
		
		//Acerto para n$$HEX1$$e300$$ENDHEX$$o informar valores zerados
		If Dec(lds_Reducao.object.vl_operacao_nao_fiscal[ll_row]) > 0 Then
			ls_Registro = ls_Cabecalho + 'OPFN   ' + of_formata_valor_pafecf(lds_Reducao.object.vl_operacao_nao_fiscal[ll_row],11,02)
	
			//If FileWrite(pl_arquivo,ls_Registro) = -1 Then lb_Sucesso = False
			
			If Not This.of_grava_registro_temp( 'R03', '', '', '', ls_Registro ) Then
				lb_Sucesso = False
			End If
		End If
		
		ls_Registro = ''
		
		If Not lb_Sucesso Then Exit
						
	Next
	
Else
	lb_Sucesso = False
End If	

Destroy(lds_Reducao)
Destroy(lds_Aliquota)

Return lb_Sucesso 
end function

public function string of_formata_valor_pafecf (decimal pdc_valor, long pl_inteiro, long pl_decimal);String 	ls_Valor

If IsNull(pdc_Valor) Then pdc_Valor = 000.00

ls_Valor = FillA('0', pl_inteiro + pl_decimal) + MidA( String(pdc_valor) , 1, LenA(String(pdc_valor)) -3 ) + RightA(String(pdc_valor),2)

ls_Valor = RightA( ls_Valor, pl_inteiro + pl_decimal )

Return ls_Valor
end function

public function boolean of_gera_vendas_periodo (ref string ps_arquivo, date pdh_inicial, date pdh_final, boolean pb_convenio, long pl_ecf);Date		ldh_Aux
Long 		ll_File
Long 		ll_Linha = 0

Boolean 	lb_Sucesso = False

String ls_Origem  = 'c:\download.mfd'
String ls_Destino = 'c:\retorno.txt'
String ls_Laudo

If IsValid(w_Aguarde) Then Close(w_Aguarde)

Open(w_Aguarde)

w_Aguarde.Title = "Gerando arquivo de vendas por per$$HEX1$$ed00$$ENDHEX$$odo"

FileDelete(ls_Origem)
FileDelete(ls_Destino)

If pl_Ecf <> 0 Then
	w_Aguarde.Title = "Carregando dados da impressora fiscal"
	If Not This.of_Carrega_dados_ecf(pl_ecf) Then Return False
End If

If gvo_Parametro.cd_Filial = 534 Then
	ls_Laudo = "SPED_" + String(ivl_Filial) + "_"
	
	ps_Arquivo = 'c:\sistemas\cr\arquivos\' + ls_Laudo + String(Today(),'DDMMYYYYHHMMSS') + '.txt'
Else
	Select vl_parametro
	  Into :ls_Laudo
	  From parametro_loja
	 Where cd_parametro = 'NR_LAUDO_PAFECF'
	 Using SQLCa;
	
	If SQLCa.SQLCode = -1 Then Return False
	
	ps_Arquivo = 'c:\sistemas\cl\arquivos\paf-ecf\' + ls_Laudo + String(Today(),'DDMMYYYYHHMMSS') + '.txt'
End If


FileDelete(ps_Arquivo)

ll_File = FileOpen(ps_Arquivo, LineMode!, Write!, LockWrite!, Append!)
	
If ll_File <> - 1 Then
	
	If pb_Convenio Then
		w_Aguarde.Title = "Gerando arquivo de vendas por per$$HEX1$$ed00$$ENDHEX$$odo - R10"
		If of_pafecf_conv5795_r10(pdh_Inicial, pdh_Final, ll_File) Then
			w_Aguarde.Title = "Gerando arquivo de vendas por per$$HEX1$$ed00$$ENDHEX$$odo - R11"
			If of_pafecf_conv5795_r11(ll_File) Then
//				//Documentos emitidos
				w_Aguarde.Title = "Gerando arquivo de vendas por per$$HEX1$$ed00$$ENDHEX$$odo - R50"
				If of_pafecf_conv5795_r50(pdh_Inicial, pdh_Final, ll_File) Then
					w_Aguarde.Title = "Gerando arquivo de vendas por per$$HEX1$$ed00$$ENDHEX$$odo - R54"
					If of_pafecf_conv5795_r54(pdh_Inicial, pdh_Final, ll_File) Then
						lb_Sucesso = True
					End IF
				End If				
				
				
				//Documentos emitidos pelo ECF
				ldh_Aux = pdh_Inicial 
				Do While ldh_Aux <= pdh_Final
						w_Aguarde.Title = "Gerando arquivo de vendas por per$$HEX1$$ed00$$ENDHEX$$odo - R60M"
						If of_pafecf_conv5795_r60m(ldh_Aux, ll_File, pl_Ecf) Then
							w_Aguarde.Title = "Gerando arquivo de vendas por per$$HEX1$$ed00$$ENDHEX$$odo - R60A"
							If of_pafecf_conv5795_r60a(ldh_Aux,ll_File, pl_Ecf) Then
								
							End IF							
						End If				
					ldh_Aux = RelativeDate(ldh_Aux, 1)
				Loop
				w_Aguarde.Title = "Gerando arquivo de vendas por per$$HEX1$$ed00$$ENDHEX$$odo - R60R"
				If of_pafecf_conv5795_r60r(pdh_Inicial,pdh_Final,ll_File) Then
					lb_Sucesso = True
				End If
								
				IF lb_Sucesso Then
					lb_Sucesso = False
					w_Aguarde.Title = "Gerando arquivo de vendas por per$$HEX1$$ed00$$ENDHEX$$odo - R75"
					If of_pafecf_conv5795_r75(pdh_Inicial, pdh_Final, ll_File) Then
						w_Aguarde.Title = "Gerando arquivo de vendas por per$$HEX1$$ed00$$ENDHEX$$odo - R90"
						If of_pafecf_conv5795_r90(pdh_Inicial, pdh_Final, ll_File) Then
							lb_Sucesso = True
						End IF
					End IF
				End If
			End If
		End If
	Else
		w_Aguarde.Title = "Gerando arquivo de vendas por per$$HEX1$$ed00$$ENDHEX$$odo - Bloco 0"
		If of_pafecf_ac0908_bloco_0(pdh_Inicial, pdh_Final, ll_File) Then
			w_Aguarde.Title = "Gerando arquivo de vendas por per$$HEX1$$ed00$$ENDHEX$$odo - Bloco C"
			If of_pafecf_ac0908_bloco_C(pdh_Inicial, pdh_Final, ll_File, pl_Ecf) Then
				w_Aguarde.Title = "Gerando arquivo de vendas por per$$HEX1$$ed00$$ENDHEX$$odo - Bloco Final"
				If of_pafecf_ac0908_bloco_Outros(pdh_Inicial, pdh_Final, ll_File) Then
					lb_Sucesso = True
				End If
			End If
		End If
	End If
	
End If	

If Not lb_Sucesso Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Ocorreu um erro na gera$$HEX2$$e700e300$$ENDHEX$$o do arquivo.")
End IF

FileClose(ll_File)

If IsValid(w_Aguarde) Then Close(w_Aguarde)

Return lb_Sucesso
end function

public function boolean of_pafecf_registro_r04 (long pl_ecf, date pdh_inicial, date pdh_final, long pl_arquivo, ref boolean pb_evidenciado);
Boolean 	lb_Sucesso = True

String 	ls_Registro
String   ls_Indice

Long 	 	ll_Row
Long     ll_Retorno

Decimal {2} ldc_Desconto

String ls_Modelo
String ls_Cancelado

dc_uo_ds_base lds_Cupom

lds_Cupom = Create dc_uo_ds_base

If Not lds_Cupom.of_ChangeDataObject('dw_ge038_pafecf_cupom_fiscal') Then Return False

ll_Retorno = lds_Cupom.Retrieve(pl_ecf,pdh_inicial,pdh_final)

If ll_Retorno <> -1 Then

	For ll_Row = 1 To lds_Cupom.RowCount()
			
		ldc_Desconto = lds_Cupom.object.vl_total_produtos[ll_row] - lds_Cupom.object.vl_total_nf[ll_row]
		
		ls_Registro = 'R04'
		
		ls_Registro += LeftA(This.nr_Serie + Space(20), 20)
	
		ls_Registro += LeftA(This.id_MfAdicional,1)

		// Acerto para inserir ? nos espa$$HEX1$$e700$$ENDHEX$$os em branco dos registros alterados
		ls_Modelo = Space(20)
				
		//Verifica se h$$HEX1$$e100$$ENDHEX$$ altera$$HEX2$$e700e300$$ENDHEX$$o nos dados da ECF
		If of_inconsistencia_impressora_fiscal(pl_ecf) Then
			ls_Modelo = FillA("?", 20)
			ls_Registro += gf_Replace(LeftA( This.de_Modelo + ls_Modelo , 20 ), " ", "?", 0)	
			pb_evidenciado = True			
		ElseIf of_inconsistencia_nf_venda(lds_Cupom.object.nr_nf[ll_row], gvo_Parametro.of_Filial(), lds_Cupom.object.de_especie[ll_row], lds_Cupom.object.de_serie[ll_row], False, Ref ls_Cancelado) Then
			ls_Modelo = FillA("?", 20)
			ls_Registro += gf_Replace(LeftA( This.de_Modelo + ls_Modelo , 20 ), " ", "?", 0)	
			pb_evidenciado = True			
		Else
			ls_Registro += LeftA( This.de_Modelo + ls_Modelo , 20 )
		End If
		
		ls_Registro += '01'
		
		ls_Registro += String(lds_Cupom.object.nr_ccf[ll_row],'000000000')
		
		ls_Registro += String(lds_Cupom.object.nr_operacao_ecf[ll_row],'000000000')
				
		ls_Registro += String(lds_Cupom.object.dh_data_fiscal[ll_row],'yyyymmdd')
			
		ls_Registro += of_Formata_Valor_PafEcf(lds_Cupom.object.vl_total_produtos[ll_row],12,2)
					
		ls_Registro += of_Formata_Valor_PafEcf(ldc_Desconto,11,2)
		
		ls_Registro += 'V'
		
		ls_Registro += FillA("0", 13)
		
		ls_Registro += 'V'
		
		ls_Registro += of_Formata_Valor_PafEcf(lds_Cupom.object.vl_total_nf[ll_row],12,2)
		
		If Not IsNull(ls_Cancelado) Or Trim(ls_Cancelado) <> "" Then
			ls_Registro += ls_Cancelado
		Else
			If lds_Cupom.object.id_cancelamento_impressora[ll_row] = "S" Then		
				ls_Registro += 'S'
			Else	
				ls_Registro += 'N'
			End If	
		End If
		
		ls_Registro += FillA("0", 13)
		
		ls_Registro += 'D'

		
		If Not IsNull(lds_Cupom.object.nm_cliente[ll_row]) Or Trim(lds_Cupom.object.nm_cliente[ll_row]) <> "" Then
			ls_Registro += LeftA(lds_Cupom.object.nm_cliente[ll_row] + Space(40), 40)		
		Else		
			ls_Registro += Space(40)			
		End If

		If Not IsNull(lds_Cupom.object.nr_cpf_cgc[ll_row]) Or Trim(String(lds_Cupom.object.nr_cpf_cgc[ll_row])) <> "" Then
			ls_Registro += RightA('00000000000000' + lds_Cupom.object.nr_cpf_cgc[ll_row], 14)
		Else		
			ls_Registro += FillA("0", 14)
		End If
			
//		ls_Registro += Space(40)
		
//		ls_Registro += Fill("0", 14)
						
		//If FileWrite(pl_arquivo,ls_Registro) = -1 Then lb_Sucesso = False
		
		If Not This.of_grava_registro_temp( 'R04', String(lds_Cupom.object.dh_data_fiscal[ll_row],'yyyymmdd'),'','', ls_Registro ) Then
			lb_Sucesso = False
		End If
		
		ls_Registro = ''
		
		If Not lb_Sucesso Then Exit
		
	Next
	
Else
	lb_Sucesso = False
	
End If	

Destroy(lds_Cupom)

Return lb_Sucesso
end function

public function boolean of_inconsistencia_documento_ecf (long pl_ecf, date pdh_movimento, long pl_coo);Long lvl_Coo
Long lvl_Gnf
Long lvl_Grg
Long lvl_Cdc
Long lvl_Ccf

DateTime lvdh_Final

String lvs_Documento
String lvs_Hash
String lvs_Pagamento
String lvs_data_final
String lvs_data_mov


Select	 	COALESCE( TO_CHAR( dh_movimento, 'DD/MM/YYYY' ), '' ),
			nr_coo,
			COALESCE( TO_CHAR( dh_final, 'DD/MM/YYYY HH24:MI:SS' ), '' ),
			id_documento,
			nr_gnf,
			nr_grg,   
			nr_cdc,
			nr_ccf,
			cd_forma_pagamento
	Into	:lvs_data_mov,
			:lvl_Coo,
			:lvs_data_final,
			:lvs_Documento,
			:lvl_Gnf,
			:lvl_Grg,
			:lvl_Cdc,
			:lvl_Ccf,
			:lvs_pagamento
	From documento_ecf d
  Where d.dh_movimento 	= :pdh_movimento
	 and d.nr_ecf       	= :pl_ecf
	 and d.nr_coo			= :pl_coo
  Using SQLCa;

Select	 	de_hash
	Into	:lvs_Hash
	From documento_ecf_paf p
  Where p.dh_movimento 	= :pdh_movimento
	 and p.nr_ecf       	= :pl_ecf
	 and p.nr_coo			= :pl_coo
  Using SQLCa;

If IsNull(lvl_Ccf) Then
	lvl_Ccf = 0
End If

If IsNull(lvs_pagamento) Then
	lvs_pagamento = ""
End If		

If SQLCa.SQLCode = 0 Then

	If Trim(lvs_Hash) <> "" And Not IsNull(lvs_Hash) Then
		If lvs_Hash <> gf_Captura_Hash(lvs_data_mov + String(pl_ecf) + String(lvl_Coo) + String(lvl_Gnf) + String(lvl_Cdc) + lvs_Documento  + lvs_data_final + String(lvl_Ccf) + String(lvl_Grg)  +  lvs_pagamento) Then
			Return True
		End If 
	Else
		Update documento_ecf
			Set id_documento = id_documento
		  Where dh_movimento 	= :pdh_movimento
			 and nr_ecf       	= :pl_ecf
			 and nr_coo			= :pl_coo
		 Using SQLCa;
		 
		If SQLCa.SQLCode <> -1 Then	
			SQLCa.of_Commit()
		End If				
	End If	
End If
  
Return False
end function

public function boolean of_pafecf_registro_r06 (long pl_ecf, date pdh_inicial, date pdh_final, long pl_arquivo, ref boolean pb_evidenciado);
Boolean 	lb_Sucesso = True

String 	ls_Registro

Long 	 	ll_Row
Long     ll_Retorno

String ls_Modelo

dc_uo_ds_base lds_Documento

lds_Documento = Create dc_uo_ds_base

If Not lds_Documento.of_ChangeDataObject('dw_ge038_pafecf_documento') Then Return False

ll_Retorno = lds_Documento.Retrieve(pl_ecf, pdh_inicial, pdh_final)

If ll_Retorno <> -1 Then

	For ll_Row = 1 To lds_Documento.RowCount()
					
		ls_Registro = 'R06'
		
		ls_Registro += LeftA(This.nr_Serie + Space(20), 20)
	
		ls_Registro += LeftA(This.id_MfAdicional, 1)
		
		// Acerto para inserir ? nos espa$$HEX1$$e700$$ENDHEX$$os em branco dos registros alterados
		ls_Modelo = Space(20)
		
		//Verifica se h$$HEX1$$e100$$ENDHEX$$ altera$$HEX2$$e700e300$$ENDHEX$$o nos dados da ECF
		If of_inconsistencia_impressora_fiscal(pl_ecf) Then
			ls_Modelo = FillA("?", 20)
			ls_Registro += gf_Replace(LeftA( This.de_Modelo + ls_Modelo , 20 ), " ", "?", 0)	
			pb_evidenciado = True			
		//Verifica se h$$HEX1$$e100$$ENDHEX$$ altera$$HEX2$$e700e300$$ENDHEX$$o nos dados dos documentos ECF
//		ElseIf of_inconsistencia_documento_ecf(pl_ecf, Date(lds_Documento.object.dh_final[ll_row]), lds_Documento.object.nr_coo[ll_row]) Then		
		ElseIf of_inconsistencia_documento_ecf(pl_ecf, Date(lds_Documento.object.dh_movimento[ll_row]), lds_Documento.object.nr_coo[ll_row]) Then								
			ls_Modelo = FillA("?", 20)
			ls_Registro += gf_Replace(LeftA( This.de_Modelo + ls_Modelo , 20 ), " ", "?", 0)		
			pb_evidenciado = True		
		Else			
			ls_Registro += LeftA( This.de_Modelo + ls_Modelo , 20 )
		End If
		
		ls_Registro += '01'
		
		ls_Registro += String(lds_Documento.object.nr_coo[ll_row],'000000000')
		
		ls_Registro += String(lds_Documento.object.nr_gnf[ll_row],'000000')
		
		ls_Registro += String(lds_Documento.object.nr_grg[ll_row],'000000')
		
		ls_Registro += String(lds_Documento.object.nr_cdc[ll_row],'0000')
		
		ls_Registro += lds_Documento.object.id_Documento[ll_row]
		
		ls_Registro += String(lds_Documento.object.dh_Final[ll_row],'yyyymmdd')
		
		ls_Registro += String(lds_Documento.object.dh_Final[ll_row],'hhmmss')
										
		//If FileWrite(pl_arquivo,ls_Registro) = -1 Then lb_Sucesso = False
		
		If Not This.of_grava_registro_temp( 'R06', '', '', '', ls_Registro ) Then
			lb_Sucesso = False
		End If
		
		ls_Registro = ''
		
		If Not lb_Sucesso Then Exit
			
	Next
Else
	lb_Sucesso = False
	
End If	

Destroy(lds_Documento)

Return lb_Sucesso
end function

public function boolean of_assinatura_digital (string ps_arquivo);Long 	  ll_Retorno

String ls_Registro 

String ls_ChavePublica
String ls_ChavePrivada
String ls_ead

ls_ChavePublica = "9716BE0910DB085542B39EE19383F3EB45A32D8962D57FFC6DAF0F04B872F52EF36F144131F6923B1A9EA73F13527A9CFD5A26F688505FC63ED9F95D240BF9D3A9655E26AE6AB706A1633693FCB3048A750E4B15EAE98F64EF6E941A78422E7ECB1D126C268DF5FA8E228A2CDD5206CE50B4D15D14B99906604C73E6DF807939"
ls_ChavePrivada = "C59A1793009F74E975542E2841C840B34D8C45143D5B761DE1FADFE447289D4308452A882AED183FB5781A1C23AED97726023C3710161C68ABA7275AE9826119C3BD9FC24E4C6DE977B674EDA0CE56F4E1F3884F51230A10CAF8362FE4C758A1DD0F9F50F0810F8507E8419884BAA981771B5EACE835E94EB62CDE4DAFE73D21"

ls_ead = Space(256)

ll_Retorno = generateEAD(ps_arquivo, ls_ChavePublica ,ls_ChavePrivada , Ref ls_ead , 1 )

If ll_Retorno = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao assinar digitalmente o arquivo " + ps_arquivo, StopSign!)
	Return False
Else
	Return True
End If


end function

public function boolean of_data_primeira_venda (ref datetime pd_datahora, long pl_ecf);//Primeira venda no dia para ECF
Select dh_primeira_venda_dia
Into   :pd_datahora
From   impressora_fiscal
Where nr_ecf = :pl_ecf
Using Sqlca;

If Sqlca.Sqlcode = -1 Then
	Sqlca.of_MsgDbError('Localiza$$HEX2$$e700e300$$ENDHEX$$o primeira venda da ECF.')
	Return False
End If

//Sen$$HEX1$$e300$$ENDHEX$$o achou busca a ultima nota de dia anterior ao atual.
//If IsNull(pd_datahora) Then
//	Select Max(dh_emissao)
//	 Into :pd_datahora
//	 From nf_venda
//	Where nr_ecf = :pl_ecf
//	  and dh_emissao > Today()
//	Using Sqlca;
//	
//	If Sqlca.Sqlcode = -1 Then
//		Sqlca.of_MsgDbError('Localiza$$HEX2$$e700e300$$ENDHEX$$o primeira venda da ECF.')
//		Return False
//	End If	
//End If
//
Return True
end function

public function boolean of_registro_cat52_e00 (long pl_ecf, date pdh_inicial, date pdh_final, long pl_arquivo, ref boolean pb_evidenciado);Boolean lb_Sucesso = False

Long ll_Retorno
Long ll_Linha 

String ls_Registro
String ls_Modelo
String ls_Insc_estadual
String ls_COO
String ls_numero_aplicacao

//dc_uo_ds_base lvds_1
//lvds_1 = Create dc_uo_ds_base
//
//If Not lvds_1.of_ChangeDataObject('dw_ge038_pafecf_alteracao_r01') Then 
//	Destroy(lvds_1)
//	Return False
//End If 
//
//ll_Retorno = lvds_1.Retrieve()
//
	
	ls_Registro = 'E00' 
	//Serie
	ls_Registro += LeftA(This.nr_Serie_MFD + Space(20), 20)
	//Letra MF
	ls_Registro += LeftA(This.id_MfAdicional, 1)
	//Ordem usuario ECF
	ls_Registro += LeftA('01', 2)
	//Tipo ECF
	If IsNull(This.de_Tipo) Then 
		ls_Registro += Space(07)
	Else				 
		ls_Registro += LeftA(This.de_Tipo + Space(07) , 07 )
	End If
	//Marca
	If IsNull(This.de_Marca) Then
		ls_Registro += Space(20)
	Else	
		ls_Registro += LeftA(This.de_Marca + Space(20) , 20 )
	End If	
	
	ls_Modelo = Space(20)
	//Modelo
	//Verifica se h$$HEX1$$e100$$ENDHEX$$ altera$$HEX2$$e700e300$$ENDHEX$$o nos dados da ECF
	If of_inconsistencia_impressora_fiscal(pl_ecf) Then
		ls_Modelo = FillA("?", 20)
		ls_Registro += gf_Replace(LeftA( This.de_Modelo + ls_Modelo , 20 ), " ", "?", 0)
		pb_evidenciado = True
	ElseIf of_inconsistencia_filial(gvo_Parametro.of_Filial()) Then
		ls_Modelo = FillA("?", 20)
		ls_Registro += gf_Replace(LeftA( This.de_Modelo + ls_Modelo , 20 ), " ", "?", 0)
		pb_evidenciado = True
	Else			
		ls_Registro += LeftA( This.de_Modelo + ls_Modelo , 20 )
	End If
	
	//COO
	ls_COO = Space(6)
	ls_Registro += LeftA(ls_COO, 6)
	//Numero Aplicacao
	ls_numero_aplicacao = Space(2)
	ls_Registro += LeftA(ls_numero_aplicacao, 2)
	
//					 
//	ls_Registro += LeftA( This.nr_Versao_SWBasico + Space(10) , 10 )
//					 
//	If	IsNull(This.dh_SWBasico) Then 
//		ls_Registro += Space(08)	// Data
//		ls_Registro += Space(06)	// Hora
//	Else
//		ls_Registro += String(This.dh_SWBasico,'yyyymmdd')
//		ls_Registro += String(This.dh_SWBasico,'hhmmss')
//	End If
//	
//	ls_Registro += String(pl_ecf,'000')
//	
	
	//CNPJ Matriz - Desenvolvedor
	ls_Registro += '84683481000177'
	
	//Inscri$$HEX2$$e700e300$$ENDHEX$$o Estadual Matriz - Desenvolvedor
	ls_Registro += '250330539     '
	
	//Inscri$$HEX2$$e700e300$$ENDHEX$$o Municipal Matriz - Desenvolvedor
	ls_Registro += Space(14)
	
	//Raz$$HEX1$$e300$$ENDHEX$$o Social Matriz - Desenvolvedora
	If of_inconsistencia_inclusao_exclusao() Then		
		ls_Registro += LeftA('CIA?LATINO?AMERICANA?DE?MEDICAMENTOS' + FillA("?", 40),40)
		pb_evidenciado = True
	Else
		ls_Registro += LeftA('CIA LATINO AMERICANA DE MEDICAMENTOS' + Space(40),40)
	End If
	
	//Software
	ls_Registro += LeftA('SISTEMA DE CAIXA' + Space(40),40)
	
	//Vers$$HEX1$$e300$$ENDHEX$$o do Software 
	ls_Registro += LeftA(This.nr_Versao_Caixa,10)
	
	//Linha 01
	ls_Registro += LeftA(Space(42),42)
	
	//Linha 02
	ls_Registro += LeftA(Space(42),42)
	
	If FileWrite(pl_arquivo,ls_Registro) <> -1 Then
		lb_Sucesso = True
	End If

//End If
//
//Destroy(lvds_1)

Return lb_Sucesso 
end function

public function boolean of_registro_cat52_e01 (long pl_ecf, date pdh_inicial, date pdh_final, long pl_arquivo, ref boolean pb_evidenciado);Boolean lb_Sucesso = False

Long ll_Retorno
Long ll_Linha 
Long ll_Reducoes
Long ll_Row

String ls_Registro
String ls_Modelo

ls_Registro = 'E01' 
//Serie ECF	
ls_Registro += LeftA(This.nr_Serie_MFD + Space(20), 20)
//MF ECF
ls_Registro += LeftA(This.id_MfAdicional, 1)
//Tipo
If IsNull(This.de_Tipo) Then 
	ls_Registro += Space(07)
Else				 
	ls_Registro += LeftA(This.de_Tipo + Space(07) , 07 )
End If
//Marca
If IsNull(This.de_Marca) Then
	ls_Registro += Space(20)
Else	
	ls_Registro += LeftA(This.de_Marca + Space(20) , 20 )
End If	

ls_Modelo = Space(20)
//MOdelo
//Verifica se h$$HEX1$$e100$$ENDHEX$$ altera$$HEX2$$e700e300$$ENDHEX$$o nos dados da ECF
If of_inconsistencia_impressora_fiscal(pl_ecf) Then
	ls_Modelo = FillA("?", 20)
	ls_Registro += gf_Replace(LeftA( This.de_Modelo + ls_Modelo , 20 ), " ", "?", 0)
	pb_evidenciado = True
ElseIf of_inconsistencia_filial(gvo_Parametro.of_Filial()) Then
	ls_Modelo = FillA("?", 20)
	ls_Registro += gf_Replace(LeftA( This.de_Modelo + ls_Modelo , 20 ), " ", "?", 0)
	pb_evidenciado = True
Else			
	ls_Registro += LeftA( This.de_Modelo + ls_Modelo , 20 )
End If
//Versao sw basico ECF				 
ls_Registro += LeftA( This.nr_Versao_SWBasico + Space(10) , 10 )
//Data e hora SW				 
If	IsNull(This.dh_SWBasico) Then 
	ls_Registro += Space(08)	// Data
	ls_Registro += Space(06)	// Hora
Else
	ls_Registro += String(This.dh_SWBasico,'yyyymmdd')
	ls_Registro += String(This.dh_SWBasico,'hhmmss')
End If
//Numero ECF
ls_Registro += String(pl_ecf,'000')

//CNPJ Loja
ls_Registro += LeftA(gvo_parametro.nr_cgc + Space(14),14)

//Comando de gera$$HEX2$$e700e300$$ENDHEX$$o, pela aplica$$HEX2$$e700e300$$ENDHEX$$o PAF
ls_Registro += LeftA('APL',3)


dc_uo_ds_base lds_Reducao
lds_Reducao = Create dc_uo_ds_base

If Not lds_Reducao.of_ChangeDataObject('dw_ge038_pafecf_reducaoz') Then Return False

ll_Retorno = lds_Reducao.Retrieve(pl_ecf,pdh_inicial,pdh_final)

If ll_Retorno <> -1 Then

	For ll_Row = 1 To lds_Reducao.RowCount()		
		//CRZ INICIAL
		//Como no mapa resumo grava o contador com a redu$$HEX2$$e700e300$$ENDHEX$$o j$$HEX1$$e100$$ENDHEX$$ emitida, aqui eu subtraio 1.
		ll_Reducoes = lds_Reducao.object.qt_reducao_z[ll_row]
		ls_Registro += LeftA(String(ll_Reducoes,'000000'),6)
		//CRZ Final
		ls_Registro += LeftA(String(lds_Reducao.object.qt_reducao_z[ll_row],'000000'),6)	
		
	Next
	
Else
	lb_Sucesso = False
	Return lb_Sucesso
End If	

Destroy(lds_Reducao)

//Data In$$HEX1$$ed00$$ENDHEX$$cio
ls_Registro += String(pdh_inicial,'yyyymmdd')

//Data Final
ls_Registro += String(pdh_final,'yyyymmdd')

//DLL ECF que gera o MFD
//Na BEMATECH n$$HEX1$$e300$$ENDHEX$$o consegui buscar a informa$$HEX2$$e700e300$$ENDHEX$$o direto da ECF entao olhei direto na dll BemaMFD = 02.01.02
ls_Registro +='02.01.02'

//Vers$$HEX1$$e300$$ENDHEX$$o Especifica$$HEX2$$e700e300$$ENDHEX$$o ato cotepe
ls_Registro += 'AC1704 01.00.00'

If FileWrite(pl_arquivo,ls_Registro) <> -1 Then
	lb_Sucesso = True
End If

Return lb_Sucesso 
end function

public function boolean of_registro_cat52_e02 (long pl_ecf, date pdh_inicial, date pdh_final, long pl_arquivo, ref boolean pb_evidenciado);
Boolean 	lb_Sucesso = True

Decimal{2} lvdc_Total
 
String 	ls_Registro

Long 	 	ll_Row
Long     ll_Retorno

String ls_Modelo
String ls_Insc_Estadual
String ls_Endereco_loja

dc_uo_ds_base lds_Reducao
lds_Reducao = Create dc_uo_ds_base

If Not lds_Reducao.of_ChangeDataObject('dw_ge038_pafecf_reducaoz') Then Return False

ll_Retorno = lds_Reducao.Retrieve(pl_ecf,pdh_inicial,pdh_final)

If ll_Retorno <> -1 Then
	
	If lds_Reducao.RowCount() > 1 Then
		//N$$HEX1$$e300$$ENDHEX$$o pode trazer mais de 1 registro.
		Return False
	End If

	For ll_Row = 1 To lds_Reducao.RowCount()
				
		ls_Registro = 'E02' 
		//Serie
		ls_Registro += LeftA(This.nr_Serie_MFD + Space(20), 20)
		//MF
		ls_Registro += LeftA(This.id_MfAdicional, 1)	
		
		ls_Modelo = Space(20)
		//MODELO
		//Verifica se h$$HEX1$$e100$$ENDHEX$$ altera$$HEX2$$e700e300$$ENDHEX$$o nos dados da ECF
		If of_inconsistencia_impressora_fiscal(pl_ecf) Then
			ls_Modelo = FillA("?", 20)
			ls_Registro += gf_Replace(LeftA( This.de_Modelo + ls_Modelo , 20 ), " ", "?", 0)
			pb_evidenciado = True
		ElseIf of_inconsistencia_filial(gvo_Parametro.of_Filial()) Then
			ls_Modelo = FillA("?", 20)
			ls_Registro += gf_Replace(LeftA( This.de_Modelo + ls_Modelo , 20 ), " ", "?", 0)
			pb_evidenciado = True
		Else			
			ls_Registro += LeftA( This.de_Modelo + ls_Modelo , 20 )
		End If
		
		//CNPJ Loja
		ls_Registro += LeftA(gvo_parametro.nr_cgc + Space(14),14)		

		//Inscri$$HEX2$$e700e300$$ENDHEX$$o Estadual Loja
		ls_Insc_Estadual = gf_replace(gvo_parametro.nr_inscricao_estadual,'.','',0)		
		ls_Registro += LeftA(ls_Insc_Estadual + Space(14),14)
		
		//Razao Social - Loja
		ls_Registro += LeftA(gvo_parametro.nm_razao_social + Space(40),40)		
		
		//Endereco da loja
		ls_Endereco_Loja = gvo_parametro.de_endereco + '     ' + gvo_parametro.nm_cidade_filial + ' / ' + gvo_parametro.ivs_UF_Filial
		ls_Registro += LeftA(ls_Endereco_Loja + Space(120),120)						 

		//Data e hora cadastro usuario ECF				 
		If	IsNull(This.dh_SWBasico) Then 
			ls_Registro += Space(08)	// Data
			ls_Registro += Space(06)	// Hora
		Else
			ls_Registro += String(This.dh_SWBasico,'yyyymmdd')
			ls_Registro += String(This.dh_SWBasico,'hhmmss')
		End If
		//CRO	
		ls_Registro += String(lds_Reducao.object.qt_reinicio_z[ll_row],'000000')
		//GT
		lvdc_Total	= lds_Reducao.object.vl_total_geral_final[ll_Row] - lds_Reducao.object.vl_total_geral_inicial[ll_Row]		
		ls_Registro += of_Formata_Valor_PafEcf(lvdc_Total,16,2)
		//Usuario ECF
		ls_Registro += '01'
	
		If FileWrite(pl_arquivo,ls_Registro) = -1 Then lb_Sucesso = False
		
		ls_Registro = ''
		
		If Not lb_Sucesso Then Exit
		
	Next
	
Else
	lb_Sucesso = False
End If	

Destroy(lds_Reducao)

Return lb_Sucesso
end function

public function boolean of_registro_cat52_e12 (long pl_ecf, date pdh_inicial, date pdh_final, long pl_arquivo, ref boolean pb_evidenciado);
Boolean 	lb_Sucesso = True

Decimal{2} lvdc_Total
 
String 	ls_Registro

Long 	 	ll_Row
Long     ll_Retorno

String ls_Modelo

dc_uo_ds_base lds_Reducao
lds_Reducao = Create dc_uo_ds_base

If Not lds_Reducao.of_ChangeDataObject('dw_ge038_pafecf_reducaoz') Then Return False

ll_Retorno = lds_Reducao.Retrieve(pl_ecf,pdh_inicial,pdh_final)

If ll_Retorno <> -1 Then
	
	If lds_Reducao.RowCount() > 1 Then
		//N$$HEX1$$e300$$ENDHEX$$o pode trazer mais de 1 registro.
		Return False
	End If

	For ll_Row = 1 To lds_Reducao.RowCount()
		
		ls_Registro = 'E12' 
		//Serie
		ls_Registro += LeftA(This.nr_Serie_MFD + Space(20), 20)
		//MF
		ls_Registro += LeftA(This.id_MfAdicional, 1)	
		
		// Acerto para inserir ? nos espa$$HEX1$$e700$$ENDHEX$$os em branco dos registros alterados
		ls_Modelo = Space(20)
				
		//Verifica se h$$HEX1$$e100$$ENDHEX$$ altera$$HEX2$$e700e300$$ENDHEX$$o nos dados da ECF
		If of_inconsistencia_impressora_fiscal(pl_ecf) Then
			ls_Modelo = FillA("?", 20)
			ls_Registro += gf_Replace(LeftA( This.de_Modelo + ls_Modelo , 20 ), " ", "?", 0)			
			pb_evidenciado = True
		ElseIf of_inconsistencia_mapa_resumo(lds_Reducao.object.nr_mapa[ll_row], gvo_Parametro.of_Filial()) Then
			ls_Modelo = FillA("?", 20)
			ls_Registro += gf_Replace(LeftA( This.de_Modelo + ls_Modelo , 20 ), " ", "?", 0)
			pb_evidenciado = True
		ElseIf of_inconsistencia_mapa_resumo_ecf(lds_Reducao.object.nr_mapa[ll_row], gvo_Parametro.of_Filial(), pl_ecf) Then
			ls_Modelo = FillA("?", 20)
			ls_Registro += gf_Replace(LeftA( This.de_Modelo + ls_Modelo , 20 ), " ", "?", 0)						
			pb_evidenciado = True
		Else
			ls_Registro += LeftA( This.de_Modelo + ls_Modelo , 20 )
		End If
		//Usuario ECF
		ls_Registro += '01'
		//CRZ		
		ls_Registro += String(lds_Reducao.object.qt_reducao_z[ll_row],'000000')
		//COO da redu$$HEX2$$e700e300$$ENDHEX$$o Z
		ls_Registro += String(lds_Reducao.object.nr_operacao_final[ll_row],'000000')
		//CRO
		ls_Registro += String(lds_Reducao.object.qt_reinicio_z[ll_row],'000000')
		//Data movimento
		ls_Registro += String(lds_Reducao.object.dh_movimento[ll_row],'yyyymmdd')
		//Data emissao reducao Z
		ls_Registro += String(lds_Reducao.object.dh_reducao[ll_row],'yyyymmdd')
		//Hora Emissao
		ls_Registro += String(lds_Reducao.object.dh_reducao[ll_row],'hhmmss')
		//Venda bruta Diaria
		lvdc_Total	= lds_Reducao.object.vl_total_geral_final[ll_Row] - lds_Reducao.object.vl_total_geral_inicial[ll_Row]		
		ls_Registro += of_Formata_Valor_PafEcf(lvdc_Total,16,2)
		//ISSQN
		ls_Registro += 'N'
	
		If FileWrite(pl_arquivo,ls_Registro) = -1 Then lb_Sucesso = False
		
		ls_Registro = ''
		
		If Not lb_Sucesso Then Exit
		
	Next
	
Else
	lb_Sucesso = False
End If	

Destroy(lds_Reducao)

Return lb_Sucesso
end function

public function boolean of_registro_cat52_e13 (long pl_ecf, date pdh_inicial, date pdh_final, long pl_arquivo, ref boolean pb_evidenciado);
Boolean 	lb_Sucesso = True

String 	ls_Registro
String   ls_Cabecalho
String   ls_Especie
String   ls_Serie
String   ls_Indice

Long 	 	ll_Row
Long     ll_Retorno
Long 		ll_Filial
Long     ll_Mapa
Long 		ll_Aliquota

Decimal  ldc_Aliquota
		 
String ls_Modelo 

dc_uo_ds_base lds_Reducao
dc_uo_ds_base lds_Aliquota

lds_Aliquota = Create dc_uo_ds_base
lds_Reducao  = Create dc_uo_ds_base

If Not lds_Reducao.of_ChangeDataObject('dw_ge038_pafecf_reducaoz') Then Return False


If Not lds_Aliquota.of_ChangeDataObject('dw_mapa_resumo_ecf_aliq') Then Return False

ll_Retorno = lds_Reducao.Retrieve(pl_ecf,pdh_inicial,pdh_final)

If ll_Retorno <> -1 Then
	
	If lds_Reducao.RowCount() > 1 Then
		//N$$HEX1$$e300$$ENDHEX$$o pode trazer mais de 1 registro.
		Return False
	End If

	For ll_Row = 1 To lds_Reducao.RowCount()
		
		ll_Filial 	= lds_Reducao.object.cd_filial	[ll_row]
		ll_Mapa		= lds_Reducao.object.nr_mapa		[ll_row]
		ls_Especie	= lds_Reducao.object.de_especie	[ll_row]
		ls_Serie    = lds_Reducao.object.de_serie		[ll_row]
		
		
		ls_Cabecalho = ''
		
		ls_Cabecalho = 'E13' 
		//Serie
		ls_Cabecalho += LeftA(This.nr_Serie_MFD + Space(20), 20)
		//MF
		ls_Cabecalho += LeftA(This.id_MfAdicional, 1)					
		//Modelo
		// Acerto para inserir ? nos espa$$HEX1$$e700$$ENDHEX$$os em branco dos registros alterados
		ls_Modelo = Space(20)
				
		//Verifica se h$$HEX1$$e100$$ENDHEX$$ altera$$HEX2$$e700e300$$ENDHEX$$o nos dados da ECF
		If of_inconsistencia_impressora_fiscal(pl_ecf) Then
			ls_Modelo = FillA("?", 20)
			ls_Cabecalho += gf_Replace(LeftA( This.de_Modelo + ls_Modelo , 20 ), " ", "?", 0)		
			pb_evidenciado = True	
		ElseIf of_inconsistencia_mapa_resumo_ecf(lds_Reducao.object.nr_mapa[ll_row], gvo_Parametro.of_Filial(), pl_ecf) Then
			ls_Modelo = FillA("?", 20)
			ls_Cabecalho += gf_Replace(LeftA( This.de_Modelo + ls_Modelo , 20 ), " ", "?", 0)		
			pb_evidenciado = True					
		Else
			ls_Cabecalho += LeftA( This.de_Modelo + ls_Modelo , 20 )
		End If
		//Usuario ECF
		ls_Cabecalho += '01'
		//CRZ
		ls_Cabecalho += String(lds_Reducao.object.qt_reducao_z[ll_row],'000000')
		
		ls_Registro = ''
		
		lds_Aliquota.Retrieve(ll_filial,ll_mapa,ls_especie,ls_serie)
				
		For ll_Aliquota = 1 To lds_Aliquota.RowCount()
			
			ldc_Aliquota = lds_Aliquota.object.pc_aliquota[ll_Aliquota]
			
			Choose Case ldc_Aliquota
				Case 07
					ls_Indice = '01'
				Case 12
					ls_Indice = '02'
				Case 25
					ls_Indice = '03'
				Case 17
					ls_Indice = '04'
				Case 18
					ls_Indice = '05'
			End Choose
			
			//Acerto para n$$HEX1$$e300$$ENDHEX$$o informar valores zerados
			If Dec(lds_Aliquota.object.vl_base_calculo[ll_Aliquota]) > 0 Then
				ls_Registro += ls_Cabecalho + ls_Indice + 'T' + of_Formata_Valor_PafEcf(ldc_Aliquota,2,2)
				ls_Registro += of_formata_valor_pafecf(lds_Aliquota.object.vl_base_calculo[ll_Aliquota],11,02)
				
				If FileWrite(pl_arquivo,ls_Registro) = -1 Then lb_Sucesso = False
			End If
			
			ls_Registro = ''
		
			If Not lb_Sucesso Then Exit
			
		Next		
		
		If Not lb_Sucesso Then Exit
		
		//Acerto para n$$HEX1$$e300$$ENDHEX$$o informar valores zerados
		If Dec(lds_Reducao.object.vl_acrescimo_iss[ll_row]) > 0 Then
			ls_Registro = ls_Cabecalho + 'AS     ' + of_formata_valor_pafecf(lds_Reducao.object.vl_acrescimo_iss[ll_row],11,02)
	
			If FileWrite(pl_arquivo,ls_Registro) = -1 Then lb_Sucesso = False
		End If
		
		ls_Registro = ''
		
		If Not lb_Sucesso Then Exit
		
		//Acerto para n$$HEX1$$e300$$ENDHEX$$o informar valores zerados
		If Dec(lds_Reducao.object.vl_acrescimo[ll_row]) > 0 Then
			ls_Registro = ls_Cabecalho + 'AT     ' + of_formata_valor_pafecf(lds_Reducao.object.vl_acrescimo[ll_row],11,02)
	
			If FileWrite(pl_arquivo,ls_Registro) = -1 Then lb_Sucesso = False
		End If
		
		ls_Registro = ''
		
		If Not lb_Sucesso Then Exit
		
		//Acerto para n$$HEX1$$e300$$ENDHEX$$o informar valores zerados
		If Dec(lds_Reducao.object.vl_cancelamento_iss[ll_row]) > 0 Then
			ls_Registro = ls_Cabecalho + 'Can-S  ' + of_formata_valor_pafecf(lds_Reducao.object.vl_cancelamento_iss[ll_row],11,02)
	
			If FileWrite(pl_arquivo,ls_Registro) = -1 Then lb_Sucesso = False
		End If
		
		ls_Registro = ''
		
		If Not lb_Sucesso Then Exit
		
		//Acerto para n$$HEX1$$e300$$ENDHEX$$o informar valores zerados
		If Dec(lds_Reducao.object.vl_cancelamento[ll_row]) > 0 Then		
			ls_Registro = ls_Cabecalho + 'Can-T  ' + of_formata_valor_pafecf(lds_Reducao.object.vl_cancelamento[ll_row],11,02)
	
			If FileWrite(pl_arquivo,ls_Registro) = -1 Then lb_Sucesso = False
		End If
		
		ls_Registro = ''
		
		If Not lb_Sucesso Then Exit
		
		//Acerto para n$$HEX1$$e300$$ENDHEX$$o informar valores zerados
		If Dec(lds_Reducao.object.vl_desconto_iss[ll_row]) > 0 Then		
			ls_Registro = ls_Cabecalho + 'DS     ' + of_formata_valor_pafecf(lds_Reducao.object.vl_desconto_iss[ll_row],11,02)
	
			If FileWrite(pl_arquivo,ls_Registro) = -1 Then lb_Sucesso = False
		End If
		
		ls_Registro = ''
		
		If Not lb_Sucesso Then Exit
		
		//Acerto para n$$HEX1$$e300$$ENDHEX$$o informar valores zerados
		If Dec(lds_Reducao.object.vl_desconto[ll_row]) > 0 Then	
			ls_Registro = ls_Cabecalho + 'DT     ' + of_formata_valor_pafecf(lds_Reducao.object.vl_desconto[ll_row],11,02)
	
			If FileWrite(pl_arquivo,ls_Registro) = -1 Then lb_Sucesso = False
		End If
		ls_Registro = ''
		
		If Not lb_Sucesso Then Exit
		
		//Acerto para n$$HEX1$$e300$$ENDHEX$$o informar valores zerados
		If Dec(lds_Reducao.object.vl_st[ll_row]) > 0 Then					
			ls_Registro = ls_Cabecalho + 'F1     ' + of_formata_valor_pafecf(lds_Reducao.object.vl_st[ll_row],11,02)
			
			If FileWrite(pl_arquivo,ls_Registro) = -1 Then lb_Sucesso = False
		End If
		ls_Registro = ''
		
		If Not lb_Sucesso Then Exit
		
		//Acerto para n$$HEX1$$e300$$ENDHEX$$o informar valores zerados
		If Dec(lds_Reducao.object.vl_st_iss[ll_row]) > 0 Then	
			ls_Registro = ls_Cabecalho + 'FS1    ' + of_formata_valor_pafecf(lds_Reducao.object.vl_st_iss[ll_row],11,02)
	
			If FileWrite(pl_arquivo,ls_Registro) = -1 Then lb_Sucesso = False
		End If
		
		ls_Registro = ''
		
		If Not lb_Sucesso Then Exit
		
		//Acerto para n$$HEX1$$e300$$ENDHEX$$o informar valores zerados
		If Dec(lds_Reducao.object.vl_isenta[ll_row]) > 0 Then	
			ls_Registro = ls_Cabecalho + 'I1     ' + of_formata_valor_pafecf(lds_Reducao.object.vl_isenta[ll_row],11,02)
	
			If FileWrite(pl_arquivo,ls_Registro) = -1 Then lb_Sucesso = False
		End If
		
		ls_Registro = ''
		
		If Not lb_Sucesso Then Exit
		
		//Acerto para n$$HEX1$$e300$$ENDHEX$$o informar valores zerados
		If Dec(lds_Reducao.object.vl_isento_iss[ll_row]) > 0 Then	
			ls_Registro = ls_Cabecalho + 'Is1    ' + of_formata_valor_pafecf(lds_Reducao.object.vl_isento_iss[ll_row],11,02)
	
			If FileWrite(pl_arquivo,ls_Registro) = -1 Then lb_Sucesso = False
		End If
		
		ls_Registro = ''
		
		If Not lb_Sucesso Then Exit
		
		//Acerto para n$$HEX1$$e300$$ENDHEX$$o informar valores zerados
		If Dec(lds_Reducao.object.vl_nao_incidencia[ll_row]) > 0 Then
			ls_Registro = ls_Cabecalho + 'N1     ' + of_formata_valor_pafecf(lds_Reducao.object.vl_nao_incidencia[ll_row],11,02)
	
			If FileWrite(pl_arquivo,ls_Registro) = -1 Then lb_Sucesso = False
		End If
		
		ls_Registro = ''
		
		If Not lb_Sucesso Then Exit
		
		//Acerto para n$$HEX1$$e300$$ENDHEX$$o informar valores zerados
		If Dec(lds_Reducao.object.vl_nao_incidencia_iss[ll_row]) > 0 Then
			ls_Registro = ls_Cabecalho + 'NS1    ' + of_formata_valor_pafecf(lds_Reducao.object.vl_nao_incidencia_iss[ll_row],11,02)
	
			If FileWrite(pl_arquivo,ls_Registro) = -1 Then lb_Sucesso = False
		End If
		
		ls_Registro = ''
		
		If Not lb_Sucesso Then Exit
		
		//Acerto para n$$HEX1$$e300$$ENDHEX$$o informar valores zerados
		If Dec(lds_Reducao.object.vl_operacao_nao_fiscal[ll_row]) > 0 Then
			ls_Registro = ls_Cabecalho + 'OPFN   ' + of_formata_valor_pafecf(lds_Reducao.object.vl_operacao_nao_fiscal[ll_row],11,02)
	
			If FileWrite(pl_arquivo,ls_Registro) = -1 Then lb_Sucesso = False
		End If
		
		ls_Registro = ''
		
		If Not lb_Sucesso Then Exit
						
	Next
	
Else
	lb_Sucesso = False
End If	

Destroy(lds_Reducao)
Destroy(lds_Aliquota)

Return lb_Sucesso 
end function

public function boolean of_registro_cat52_e14 (long pl_ecf, date pdh_inicial, date pdh_final, long pl_arquivo, ref boolean pb_evidenciado);
Boolean 	lb_Sucesso = True

String 	ls_Registro
String   ls_Indice

Long 	 	ll_Row
Long     ll_Retorno

Decimal {2} ldc_Desconto

String ls_Modelo
String ls_Cancelado

dc_uo_ds_base lds_Cupom

lds_Cupom = Create dc_uo_ds_base

If Not lds_Cupom.of_ChangeDataObject('dw_ge038_pafecf_cupom_fiscal') Then Return False

ll_Retorno = lds_Cupom.Retrieve(pl_ecf,pdh_inicial,pdh_final)

If ll_Retorno <> -1 Then

	For ll_Row = 1 To lds_Cupom.RowCount()
			
		ldc_Desconto = lds_Cupom.object.vl_total_produtos[ll_row] - lds_Cupom.object.vl_total_nf[ll_row]
		
		ls_Registro = 'E14'
		//Nr. Fabricacao
		ls_Registro += LeftA(This.nr_Serie_MFD + Space(20), 20)
		//MF Adicional
		ls_Registro += LeftA(This.id_MfAdicional,1)
		//Modelo
		// Acerto para inserir ? nos espa$$HEX1$$e700$$ENDHEX$$os em branco dos registros alterados
		ls_Modelo = Space(20)
				
		//Verifica se h$$HEX1$$e100$$ENDHEX$$ altera$$HEX2$$e700e300$$ENDHEX$$o nos dados da ECF
		If of_inconsistencia_impressora_fiscal(pl_ecf) Then
			ls_Modelo = FillA("?", 20)
			ls_Registro += gf_Replace(LeftA( This.de_Modelo + ls_Modelo , 20 ), " ", "?", 0)	
			pb_evidenciado = True			
		ElseIf of_inconsistencia_nf_venda(lds_Cupom.object.nr_nf[ll_row], gvo_Parametro.of_Filial(), lds_Cupom.object.de_especie[ll_row], lds_Cupom.object.de_serie[ll_row], False, Ref ls_Cancelado) Then
			ls_Modelo = FillA("?", 20)
			ls_Registro += gf_Replace(LeftA( This.de_Modelo + ls_Modelo , 20 ), " ", "?", 0)	
			pb_evidenciado = True			
		Else
			ls_Registro += LeftA( This.de_Modelo + ls_Modelo , 20 )
		End If
		//Usuario ECF
		ls_Registro += '01'
		//CCF
		ls_Registro += String(lds_Cupom.object.nr_ccf[ll_row],'000000')
		//COO
		ls_Registro += String(lds_Cupom.object.nr_operacao_ecf[ll_row],'000000')
		//Data Emissao CF		
		ls_Registro += String(lds_Cupom.object.dh_emissao[ll_row],'yyyymmdd')
		//Total CF	
		ls_Registro += of_Formata_Valor_PafEcf(lds_Cupom.object.vl_total_produtos[ll_row],12,2)
		//Desconto CF			
		ls_Registro += of_Formata_Valor_PafEcf(ldc_Desconto,11,2)
		//Tipo de desconto - V=Valor P=Percentual
		ls_Registro += 'V'
		//Acrescimo sobre total - N$$HEX1$$e300$$ENDHEX$$o usamos.
		ls_Registro += FillA("0", 13)
		//Tipo de desconto - V=Valor P=Percentual
		ls_Registro += 'V'
		//Total liquido CF
		ls_Registro += of_Formata_Valor_PafEcf(lds_Cupom.object.vl_total_nf[ll_row],12,2)
		//Indicador de CF cancelado
		If Not IsNull(ls_Cancelado) Or Trim(ls_Cancelado) <> "" Then
			ls_Registro += ls_Cancelado
		Else
			If lds_Cupom.object.id_cancelamento_impressora[ll_row] = "S" Then		
				ls_Registro += 'S'
			Else	
				ls_Registro += 'N'
			End If	
		End If
		//Cancelamento de acrescimo
		ls_Registro += FillA("0", 13)
		//Ordem de aplicacao de desconto
		ls_Registro += 'D'

		//Nome cliente CF
		If Not IsNull(lds_Cupom.object.nm_cliente[ll_row]) Or Trim(lds_Cupom.object.nm_cliente[ll_row]) <> "" Then
			ls_Registro += LeftA(lds_Cupom.object.nm_cliente[ll_row] + Space(40), 40)		
		Else		
			ls_Registro += Space(40)			
		End If
		//CPF/CNPJ cliente CF
		If Not IsNull(lds_Cupom.object.nr_cpf_cgc[ll_row]) Or Trim(String(lds_Cupom.object.nr_cpf_cgc[ll_row])) <> "" Then
			ls_Registro += RightA('00000000000000' + lds_Cupom.object.nr_cpf_cgc[ll_row], 14)
		Else		
			ls_Registro += FillA("0", 14)
		End If
			
		If FileWrite(pl_arquivo,ls_Registro) = -1 Then lb_Sucesso = False
		
		ls_Registro = ''
		
		If Not lb_Sucesso Then Exit
		
	Next
	
Else
	lb_Sucesso = False
	
End If	

Destroy(lds_Cupom)

Return lb_Sucesso
end function

public function boolean of_registro_cat52_e15 (long pl_ecf, date pdh_inicial, date pdh_final, long pl_arquivo, ref boolean pb_evidenciado);
Boolean 	lb_Sucesso = True

String 	ls_Registro
String   ls_Tributacao

Long 	 	ll_Row
Long     ll_Retorno
Long 		ll_Item
Long     ll_Doc_Anterior

Decimal {2} ldc_Desconto
 
String ls_Modelo

dc_uo_ds_base lds_Item

lds_Item = Create dc_uo_ds_base

If Not lds_Item.of_ChangeDataObject('dw_ge038_pafecf_produto_cupom_fiscal') Then Return False

ll_Retorno = lds_Item.Retrieve(pl_ecf,pdh_inicial,pdh_final)

If ll_Retorno <> -1 Then

	For ll_Row = 1 To lds_Item.RowCount()
		
		If ll_Doc_Anterior <> lds_Item.object.nr_nf[ll_row] Then
			ll_Doc_Anterior = lds_Item.object.nr_nf[ll_row]
			ll_Item = 1
		End If	
		
		ldc_Desconto = lds_Item.object.vl_preco_unitario[ll_row] - lds_Item.object.vl_preco_praticado[ll_row]
					
		ls_Registro = 'E15'
		//Nr. Fabricacao ECF
		ls_Registro += LeftA(This.nr_Serie_MFD + Space(20), 20)
		//MF adicional	
		ls_Registro += LeftA(This.id_MfAdicional, 1)
		//Modelo
		// Acerto para inserir ? nos espa$$HEX1$$e700$$ENDHEX$$os em branco dos registros alterados
		ls_Modelo = Space(20)
		
		//Verifica se h$$HEX1$$e100$$ENDHEX$$ altera$$HEX2$$e700e300$$ENDHEX$$o nos dados da ECF
		If of_inconsistencia_impressora_fiscal(pl_ecf) Then
			ls_Modelo = FillA("?", 20)
			ls_Registro += gf_Replace(LeftA( This.de_Modelo + ls_Modelo , 20 ), " ", "?", 0)			
			pb_evidenciado = True	
		ElseIf of_inconsistencia_nf_venda(lds_Item.object.nr_nf[ll_row], gvo_Parametro.of_Filial(), lds_Item.object.de_especie[ll_row], lds_Item.object.de_serie[ll_row], False) Then
			ls_Modelo = FillA("?", 20)
			ls_Registro += gf_Replace(LeftA( This.de_Modelo + ls_Modelo , 20 ), " ", "?", 0)	
			pb_evidenciado = True			
		ElseIf of_inconsistencia_item_nf_venda(lds_Item.object.nr_nf[ll_row], gvo_Parametro.of_Filial(), lds_Item.object.cd_produto[ll_row], lds_Item.object.de_especie[ll_row], lds_Item.object.de_serie[ll_row]) Then
			ls_Modelo = FillA("?", 20)
			ls_Registro += gf_Replace(LeftA( This.de_Modelo + ls_Modelo , 20 ), " ", "?", 0)	
			pb_evidenciado = True			
		ElseIf of_inconsistencia_produto_geral(lds_Item.object.cd_produto[ll_row]) Then
			ls_Modelo = FillA("?", 20)
			ls_Registro += gf_Replace(LeftA( This.de_Modelo + ls_Modelo , 20 ), " ", "?", 0)	
			pb_evidenciado = True			
		Else
			ls_Registro += LeftA( This.de_Modelo + ls_Modelo , 20 )
		End If
		//Usuario ECF
		ls_Registro += '01'
		//COO
		ls_Registro += String(lds_Item.object.nr_operacao_ecf[ll_row],'000000')
		//CCF
		ls_Registro += String(lds_Item.object.nr_ccf[ll_row],'000000')		
		//Nr item		
		ls_Registro += String(ll_Item,'000')
		//Cod. Produto
		ls_Registro += LeftA(String(lds_Item.object.cd_produto[ll_row]) + Space(14) , 14 )
		//Descricao
		ls_Registro += LeftA(lds_Item.object.de_produto[ll_row] + Space(100),100)	
		//Qt Vendida
		ls_Registro += String(lds_Item.object.qt_vendida[ll_row],'0000000')
		//Unidade Medida
		ls_Registro += LeftA(lds_Item.object.cd_un[ll_row] + Space(3) ,3)
		//Valor unit$$HEX1$$e100$$ENDHEX$$rio
		ls_Registro += of_Formata_Valor_PafEcf(lds_Item.object.vl_preco_unitario[ll_row],6,2)
		//Desconto item
		ls_Registro += of_Formata_Valor_PafEcf(ldc_Desconto,6,2)
		//Acrescimo item
		ls_Registro += FillA("0", 8)
		//Total liquido
		ls_Registro += of_Formata_Valor_PafEcf(lds_Item.object.vl_preco_praticado[ll_row],12,2)
		//Cod. Totalizador parcial
		Choose Case lds_Item.object.pc_icms[ll_row]
			Case 7    ; ls_Tributacao = "01T0700"
			Case 12   ; ls_Tributacao = "02T1200"
			Case 25   ; ls_Tributacao = "03T2500"		
			Case 17   ; ls_Tributacao = "04T1700"
			Case 18	 ; ls_Tributacao = "05T1800"
			Case Else 
				If lds_Item.object.cd_situacao_tributaria[ll_row] = '06' Then
					ls_Tributacao = "F1     "
				Else
					ls_Tributacao = "I1     "
				End If
		End Choose
	
		ls_Registro += ls_Tributacao
		//Indicador de cancelamento de item
		ls_Registro += 'N'
		//Qtdade Cancelada
		ls_Registro += FillA("0", 7)
		//Valor Cancelado
		ls_Registro += FillA("0", 13)
		//Cancelamento Acrescimo
		ls_Registro += FillA("0", 13)
		//Indicador de arredondamento IAT
		ls_Registro += 'A'
		//Casas decimais da quantidade
		ls_Registro += '0'
		//Casas decimais de valor unitario
		ls_Registro += '2'
								
		If FileWrite(pl_arquivo,ls_Registro) = -1 Then lb_Sucesso = False
		
		ls_Registro = ''
		
		If Not lb_Sucesso Then Exit
		
		ll_Item ++
		
	Next
Else
	lb_Sucesso = False
	
End If	

Destroy(lds_Item)

Return lb_Sucesso
end function

public function boolean of_registro_cat52_e16 (long pl_ecf, date pdh_inicial, date pdh_final, long pl_arquivo, ref boolean pb_evidenciado);
Boolean 	lb_Sucesso = True

String 	ls_Registro

Long 	 	ll_Row
Long     ll_Retorno

String ls_Modelo
String ls_CRZ

//Busca contador Reducao Z
dc_uo_ds_base lds_Reducao
lds_Reducao = Create dc_uo_ds_base
If Not lds_Reducao.of_ChangeDataObject('dw_ge038_pafecf_reducaoz') Then Return False
ll_Retorno = lds_Reducao.Retrieve(pl_ecf,pdh_inicial,pdh_final)

If ll_Retorno <> -1 Then	
	If lds_Reducao.RowCount() > 1 Then
		//N$$HEX1$$e300$$ENDHEX$$o pode trazer mais de 1 registro.
		Return False
	End If

	For ll_Row = 1 To lds_Reducao.RowCount()		
		//CRZ		
		ls_CRZ += String(lds_Reducao.object.qt_reducao_z[ll_row],'000000')
	Next
End If
Destroy(lds_Reducao)

dc_uo_ds_base lds_Documento

lds_Documento = Create dc_uo_ds_base

If Not lds_Documento.of_ChangeDataObject('dw_ge038_pafecf_documento') Then Return False

ll_Retorno = lds_Documento.Retrieve(pl_ecf, pdh_inicial, pdh_final)

If ll_Retorno <> -1 Then

	For ll_Row = 1 To lds_Documento.RowCount()
					
		ls_Registro = 'E16'
		//Nr. Fabricao ECF
		ls_Registro += LeftA(This.nr_Serie_MFD + Space(20), 20)
		//MF Adicional
		ls_Registro += LeftA(This.id_MfAdicional, 1)
		//Modelo
		// Acerto para inserir ? nos espa$$HEX1$$e700$$ENDHEX$$os em branco dos registros alterados
		ls_Modelo = Space(20)
		
		//Verifica se h$$HEX1$$e100$$ENDHEX$$ altera$$HEX2$$e700e300$$ENDHEX$$o nos dados da ECF
		If of_inconsistencia_impressora_fiscal(pl_ecf) Then
			ls_Modelo = FillA("?", 20)
			ls_Registro += gf_Replace(LeftA( This.de_Modelo + ls_Modelo , 20 ), " ", "?", 0)	
			pb_evidenciado = True			
		//Verifica se h$$HEX1$$e100$$ENDHEX$$ altera$$HEX2$$e700e300$$ENDHEX$$o nos dados dos documentos ECF
//		ElseIf of_inconsistencia_documento_ecf(pl_ecf, Date(lds_Documento.object.dh_final[ll_row]), lds_Documento.object.nr_coo[ll_row]) Then		
		ElseIf of_inconsistencia_documento_ecf(pl_ecf, Date(lds_Documento.object.dh_movimento[ll_row]), lds_Documento.object.nr_coo[ll_row]) Then								
			ls_Modelo = FillA("?", 20)
			ls_Registro += gf_Replace(LeftA( This.de_Modelo + ls_Modelo , 20 ), " ", "?", 0)		
			pb_evidenciado = True		
		Else			
			ls_Registro += LeftA( This.de_Modelo + ls_Modelo , 20 )
		End If
		//Usuario ECF
		ls_Registro += '01'
		//COO
		ls_Registro += String(lds_Documento.object.nr_coo[ll_row],'000000')
		//GNF
		ls_Registro += String(lds_Documento.object.nr_gnf[ll_row],'000000')
		//GRG
		ls_Registro += String(lds_Documento.object.nr_grg[ll_row],'000000')
		//CDC
		ls_Registro += String(lds_Documento.object.nr_cdc[ll_row],'0000')
		//CRZ
		ls_Registro += LeftA(ls_CRZ, 6)				
		//Denomina$$HEX2$$e700e300$$ENDHEX$$o
		ls_Registro += lds_Documento.object.id_Documento[ll_row]
		//Data Final Emissao
		ls_Registro += String(lds_Documento.object.dh_Final[ll_row],'yyyymmdd')
		//Hora final Emissao
		ls_Registro += String(lds_Documento.object.dh_Final[ll_row],'hhmmss')
										
		If FileWrite(pl_arquivo,ls_Registro) = -1 Then lb_Sucesso = False
		
		ls_Registro = ''
		
		If Not lb_Sucesso Then Exit
			
	Next
Else
	lb_Sucesso = False
	
End If	

Destroy(lds_Documento)

Return lb_Sucesso
end function

public function boolean of_registro_cat52_e21 (long pl_ecf, date pdh_inicial, date pdh_final, long pl_arquivo, ref boolean pb_evidenciado);
Boolean 	lb_Sucesso = True

String 	ls_Registro

Long 	 	ll_Row
Long     ll_Retorno
Long		ll_coo_ecf

String ls_Modelo

dc_uo_ds_base lds_Documento

lds_Documento = Create dc_uo_ds_base

If Not lds_Documento.of_ChangeDataObject('dw_ge038_pafecf_cupom_meio_pagamento') Then Return False

ll_Retorno = lds_Documento.Retrieve(pl_ecf, pdh_inicial, pdh_final)

If ll_Retorno <> -1 Then

	For ll_Row = 1 To lds_Documento.RowCount()
				
		ls_Registro += 'E21'
		//Nr Fabricacao ECF
		ls_Registro += LeftA(This.nr_Serie_MFD + Space(20), 20)
		//MF Adicional
		ls_Registro += LeftA(This.id_MfAdicional, 1)
		//MODELO			 
		// Acerto para inserir ? nos espa$$HEX1$$e700$$ENDHEX$$os em branco dos registros alterados
		ls_Modelo = Space(20)
						
		ll_coo_ecf = lds_Documento.object.nr_operacao_ecf[ll_row] + 1 
		
		//Verifica se h$$HEX1$$e100$$ENDHEX$$ altera$$HEX2$$e700e300$$ENDHEX$$o nos dados da ECF
		If of_inconsistencia_impressora_fiscal(pl_ecf) Then
			ls_Modelo = FillA("?", 20)
			ls_Registro += gf_Replace(LeftA( This.de_Modelo + ls_Modelo , 20 ), " ", "?", 0)		
			pb_evidenciado = True		
		//Verifica se h$$HEX1$$e100$$ENDHEX$$ altera$$HEX2$$e700e300$$ENDHEX$$o nos dados dos documentos ECF
		ElseIf of_inconsistencia_documento_ecf(pl_ecf, Date(lds_Documento.object.dh_movimentacao_caixa[ll_row]), ll_coo_ecf) Then		
			ls_Modelo = FillA("?", 20)
			ls_Registro += gf_Replace(LeftA( This.de_Modelo + ls_Modelo , 20 ), " ", "?", 0)		
			pb_evidenciado = True				
		ElseIf of_inconsistencia_meio_pagamento(lds_Documento.object.nr_operacao_ecf[ll_row], pl_ecf, gvo_Parametro.of_Filial(), False) Then		
			ls_Modelo = FillA("?", 20)
			ls_Registro += gf_Replace(LeftA( This.de_Modelo + ls_Modelo , 20 ), " ", "?", 0)
			pb_evidenciado = True				
		Else				
			ls_Registro += LeftA( This.de_Modelo + ls_Modelo , 20 )
		End If
		//Usuario ECF
		ls_Registro += '01'
		//COO
		ls_Registro += String(lds_Documento.object.nr_operacao_ecf[ll_row],'000000')
		//CCF
		ls_Registro += String(lds_Documento.object.nr_ccf[ll_row],'000000')
		//GNF
		ls_Registro += FillA("0", 6)

//		Choose Case lds_Documento.object.cd_forma_pagamento[ll_row]
//			Case 'DI'
//				ls_Registro += 'DINHEIRO       '
//			Case 'HA'
//				ls_Registro += 'CHEQUE         '
//			Case 'HP'
//				ls_Registro += 'CHEQUE-PRE     '
//			Case 'CA'
//				ls_Registro += 'CARTAO DEBITO  '
//			Case 'CP'
//				ls_Registro += 'CARTAO CREDITO '
//			Case 'CV'
//				ls_Registro += 'CONVENIO       '
//			Case Else
//				ls_Registro += 'DINHEIRO       '
//		End Choose		

		//Meio de pagamento
		ls_Registro += lds_Documento.object.cd_forma_pagamento[ll_row]
		//Valor Pago
		ls_Registro += of_Formata_Valor_PafEcf(lds_Documento.object.vl_pagamento[ll_row],11,02)
		//Indicador de Estorno
		ls_Registro += 'N'
		//Valor Estornado
		ls_Registro += FillA("0", 13)

		If FileWrite(pl_arquivo,ls_Registro) = -1 Then lb_Sucesso = False
		
		ls_Registro = ''
		
		If Not lb_Sucesso Then Exit
		
	Next
	
Else
	lb_Sucesso = False
	
End If	

Destroy(lds_Documento)

Return lb_Sucesso
end function

public function boolean of_gera_movimento_cat52 (ref string ps_arquivo, long pl_ecf, date pdh_inicial, date pdh_final);
Long 		ll_File

Boolean 	lb_Sucesso = False
Boolean	lb_Evidenciado = False

String lvs_Arquivo_Evidenciado
String lvs_Extensao
String lvs_Nome_Arquivo

If Not This.of_Carrega_dados_ecf(pl_ecf) Then Return False

//If pdh_inicial = pdh_final Then
//	ps_Arquivo = 'c:\sistemas\cl\arquivos\paf-ecf\' + LeftA(This.cd_identificacao_nacional,6) + RightA(This.nr_Serie,14) + String(pdh_inicial,'ddmmyyyy') + '.txt'
//Else	
//	ps_Arquivo = 'c:\sistemas\cl\arquivos\paf-ecf\' + LeftA(This.cd_identificacao_nacional,6) + RightA(This.nr_Serie,14) + String(gf_GetServerDate(),'ddmmyyyy') + '.txt'
//End If	

If Not PDV.of_converte_data_cat52(Date(pdh_inicial), ref lvs_extensao) Then Return False

//Define nome do arquivo
Choose Case Upper(This.de_Marca)
	Case 'BEMATECH'
		lvs_nome_arquivo = 'BE'
		If Upper(This.de_modelo) = 'MP-4000 TH FI' Then
			lvs_nome_arquivo = lvs_nome_arquivo + 'J'
		End If
	Case 'DARUMA'
		//Quando usar em SP tem que montar o Case
	Case 'SWEDA'
		//Quando usar em SP tem que montar o Case
End Choose

If Trim(lvs_nome_arquivo) > '' And Not IsNull(lvs_nome_arquivo) Then
	lvs_nome_arquivo = lvs_nome_arquivo + RightA(This.nr_Serie_MFD,5) + '.' + lvs_Extensao
	ps_arquivo =  'c:\sistemas\rl\arquivos\ecf\' + lvs_nome_arquivo
Else
	//ECF n$$HEX1$$e300$$ENDHEX$$o preparada para o arquivo.
	Return False	
End If 

FileDelete(ps_Arquivo)

ll_File = FileOpen(ps_Arquivo, LineMode!, Write!, LockWrite!, Append!)
	
If ll_File <> - 1 Then
		
	If This.of_Registro_CAT52_E00(pl_ecf, pdh_inicial, pdh_final, ll_File, Ref lb_Evidenciado) Then
		
		If This.of_Registro_CAT52_E01(pl_ecf, pdh_inicial, pdh_final, ll_File, Ref lb_Evidenciado) Then
			
			If This.of_Registro_CAT52_E02(pl_ecf, pdh_inicial, pdh_final, ll_File, Ref lb_Evidenciado) Then

				If This.of_Registro_CAT52_E12(pl_ecf, pdh_inicial, pdh_final, ll_File, Ref lb_Evidenciado) Then
			
					If This.of_Registro_CAT52_E13(pl_ecf, pdh_inicial, pdh_final, ll_File, Ref lb_Evidenciado) Then
				
						If This.of_Registro_CAT52_E14(pl_ecf, pdh_inicial, pdh_final, ll_File, Ref lb_Evidenciado) Then
							
							If This.of_Registro_CAT52_E15(pl_ecf, pdh_inicial, pdh_final, ll_File, Ref lb_Evidenciado) Then
								
								If This.of_Registro_CAT52_E16(pl_ecf, pdh_inicial, pdh_final, ll_File, Ref lb_Evidenciado) Then								
									
									If This.of_Registro_CAT52_E21(pl_ecf, pdh_inicial, pdh_final, ll_File, Ref lb_Evidenciado) Then									
				
										lb_Sucesso = True
										
									End If
								End If
							End If
						End If
					End If
				End If
			End If
		End If
	End If
End If

FileClose(ll_File)

If lb_Evidenciado Then
	lvs_Arquivo_Evidenciado = MidA(ps_Arquivo, 1, LenA(ps_Arquivo) - 4) + "_evid_" + String(Today(),"DDMMYYhhmmss") + ".txt"
	If This.of_Renomeia_Arquivo(ps_Arquivo, lvs_Arquivo_Evidenciado, True) Then	
		ps_Arquivo = lvs_Arquivo_Evidenciado
	Else
		lb_Sucesso = False
	End If
End If 

Return lb_Sucesso
end function

public function boolean of_gera_meios_pagamento (date pdh_inicial, date pdh_final, long pl_arquivo, ref boolean pb_evidenciado);Boolean lb_Sucesso = True

Long ll_Retorno
Long ll_row

String ls_Registro
String ls_Modelo
String ls_Insc_estadual
String ls_Forma_Pagamento
String ls_Tipo_Mov
String ls_Tipo_Mov2

Date ldh_Data_Atual

Decimal{2} ldc_total
Decimal{2} ldc_acumulador

dc_uo_ds_base lvds_1
lvds_1 = Create dc_uo_ds_base

If PDV.Fabricante <> "NFCE" Then  //PARA ECFs
	If Not lvds_1.of_ChangeDataObject('dw_ge038_pafecf_meio_pagamento') Then 
		Destroy(lvds_1)
		Return False
	End If
	
	lvds_1.of_AppendWhere("nf.dh_data_fiscal >= '" + String(pdh_inicial, "YYYYMMDD") + "'" + &
								 " AND nf.dh_data_fiscal < dbo.adddate('day', 1,'" + String(pdh_final, "YYYYMMDD") + "')", 2)
	lvds_1.of_AppendWhere("nf.dh_data_fiscal >= '" + String(pdh_inicial, "YYYYMMDD") + "'" + &
								 " AND nf.dh_data_fiscal < dbo.adddate('day', 1,'" + String(pdh_final, "YYYYMMDD") + "')", 3)
	
	lvds_1.of_AppendWhere("nf.dh_data_fiscal >= '" + String(pdh_inicial, "YYYYMMDD") + "'" + &
								 " AND nf.dh_data_fiscal < dbo.adddate('day', 1,'" + String(pdh_final, "YYYYMMDD") + "')", 4)							 							
								 
	lvds_1.of_AppendWhere("nf.dh_emissao >= '" + String(pdh_inicial, "YYYYMMDD") + "'" + &
								 " AND nf.dh_emissao < dbo.adddate('day', 1,'" + String(pdh_final, "YYYYMMDD") + "')", 5)							 														 
								 
	lvds_1.of_AppendWhere("dc.dh_movimento >= '" + String(pdh_inicial, "YYYYMMDD") + "'" + &
								 " AND dc.dh_movimento < dbo.adddate('day', 1,'" + String(pdh_final, "YYYYMMDD") + "')", 6)
Else  // para NFC-e
	If Not lvds_1.of_ChangeDataObject('dw_ge038_paf_nfc_meio_pagamento') Then 
		Destroy(lvds_1)
		Return False
	End If
	
	lvds_1.of_AppendWhere("nf.dh_emissao >= '" + String(pdh_inicial, "YYYYMMDD") + "'" + &
								 " AND nf.dh_emissao< dbo.adddate('day', 1,'" + String(pdh_final, "YYYYMMDD") + "')", 2)
	lvds_1.of_AppendWhere("nf.dh_emissao >= '" + String(pdh_inicial, "YYYYMMDD") + "'" + &
								 " AND nf.dh_emissao < dbo.adddate('day', 1,'" + String(pdh_final, "YYYYMMDD") + "')", 3)

End If
							 
lvds_1.Retrieve()

If lvds_1.RowCount() > 0 Then

	For ll_row = 1 To lvds_1.RowCount()	
		
		ldc_total = lvds_1.object.vl_total_venda[ll_row]			
		
		Choose Case lvds_1.object.cd_forma_pagamento[ll_row]
			Case 'DI'
				ls_Forma_Pagamento = 'DINHEIRO'
			Case 'CP'
				ls_Forma_Pagamento = 'CARTAO CREDITO'
			Case 'CA'
				ls_Forma_Pagamento = 'CARTAO DEBITO'
			Case 'HA'
				ls_Forma_Pagamento = 'CHEQUE'				
			Case 'HP'
				ls_Forma_Pagamento = 'CHEQUE-PRE'
			Case 'CV'	
				ls_Forma_Pagamento = 'CONVENIO'
			Case 'CR'	
				ls_Forma_Pagamento = 'CREDIARIO'
			Case 'CC'	
				ls_Forma_Pagamento = 'CLUBE'				
			Case Else
				ls_Forma_Pagamento = lvds_1.object.cd_forma_pagamento[ll_row]		
		End Choose	
		
		Choose Case lvds_1.object.id_documento[ll_row]
			Case 'CF'
				ls_Tipo_Mov = '1'
				ls_Tipo_Mov2 = 'CF'
			Case 'CN'
				ls_Tipo_Mov = '2'
				ls_Tipo_Mov2 = 'CN'
			Case 'NF'
				ls_Tipo_Mov = '3'
				ls_Tipo_Mov2 = 'NF'								
			Case 'NFC'
				ls_Tipo_Mov = '1'
				ls_Tipo_Mov2 = 'NFC'												
		End Choose		

		If IsNull(ldh_Data_Atual) Or (ldh_Data_Atual = Date(lvds_1.object.dh_movimentacao[ll_row])) Or (ll_row = 1) Then
			If lvds_1.object.id_documento[ll_row] = 'CN' And &
			 (ls_Forma_Pagamento = 'DINHEIRO' Or ls_Forma_Pagamento = 'SUPRIMENTO' Or ls_Forma_Pagamento = 'SANGRIA') Then					
				If ls_Forma_Pagamento = 'SANGRIA' Then					
					ldc_acumulador -= ldc_total
				Else
					ldc_acumulador += ldc_total
				End If
				ldh_Data_Atual = Date(lvds_1.object.dh_movimentacao[ll_row])
				Continue
			Else
				If ldc_acumulador <> 0.000 Then
					ls_Registro += 'A2' 						
					ls_Registro += String(ldh_Data_Atual,'yyyymmdd')
					ls_Registro += LeftA('DINHEIRO'+Space(25), 25)
					ls_Registro += '2'
					ls_Registro += of_Formata_Valor_PafEcf(Abs(ldc_acumulador),10,2)
					//If FileWrite(pl_arquivo,ls_Registro) = -1 Then lb_Sucesso = False
					
					If Not This.of_grava_registro_temp( 'A2', String(ldh_Data_Atual,'yyyymmdd'), ls_Tipo_Mov2, 'DINHEIRO', ls_Registro ) Then
						lb_Sucesso = False
					End If
					
					ls_Registro = ''
					ldc_acumulador = 0.000					
					If Not lb_Sucesso Then Exit					
				End If
				
				ls_Registro += 'A2' 						
				ls_Registro += String(Date(lvds_1.object.dh_movimentacao[ll_row]),'yyyymmdd')
				ls_Registro += LeftA(ls_Forma_Pagamento+Space(25), 25)
				ls_Registro += ls_Tipo_Mov
				ls_Registro += of_Formata_Valor_PafEcf(ldc_Total,10,2)
				If PDV.Fabricante = "NFCE" Then				
					ls_Registro += FillA('0',24)  //cpf cliente + documento = para transa$$HEX2$$e700f500$$ENDHEX$$es n$$HEX1$$e300$$ENDHEX$$o fiscais, n$$HEX1$$e300$$ENDHEX$$o temos no NFC.
				End If				
				
				//If FileWrite(pl_arquivo,ls_Registro) = -1 Then lb_Sucesso = False
				
				If Not This.of_grava_registro_temp( 'A2', String( Date(lvds_1.object.dh_movimentacao[ll_row]), 'yyyymmdd' ), ls_Tipo_Mov2, ls_Forma_Pagamento, ls_Registro ) Then
					lb_Sucesso = False
				End If
				
				ls_Registro = ''
				ldh_Data_Atual = Date(lvds_1.object.dh_movimentacao[ll_row])
				
				If Not lb_Sucesso Then Exit													
			End If
		Else			
			If ldc_acumulador <> 0.000 Then
				ls_Registro += 'A2' 						
				ls_Registro += String(ldh_Data_Atual,'yyyymmdd')
				ls_Registro += LeftA('DINHEIRO'+Space(25), 25)
				ls_Registro += '2'
				ls_Registro += of_Formata_Valor_PafEcf(Abs(ldc_acumulador),10,2)
				//If FileWrite(pl_arquivo,ls_Registro) = -1 Then lb_Sucesso = False
				
				If Not This.of_grava_registro_temp( 'A2', String(ldh_Data_Atual,'yyyymmdd'), ls_Tipo_Mov2, 'DINHEIRO', ls_Registro ) Then
					lb_Sucesso = False
				End If
				
				ls_Registro = ''
				ldc_acumulador = 0.000
				If Not lb_Sucesso Then Exit
			Else
				If lvds_1.object.id_documento[ll_row] = 'CN' And &
				 (ls_Forma_Pagamento = 'DINHEIRO' Or ls_Forma_Pagamento = 'SUPRIMENTO' Or ls_Forma_Pagamento = 'SANGRIA') Then
					If ls_Forma_Pagamento = 'SANGRIA' Then					
						ldc_acumulador -= ldc_total
					Else
						ldc_acumulador += ldc_total
					End If
					ldh_Data_Atual = Date(lvds_1.object.dh_movimentacao[ll_row])
					Continue
				End If				
			End If
			
			ls_Registro += 'A2' 						
			ls_Registro += String(Date(lvds_1.object.dh_movimentacao[ll_row]),'yyyymmdd')
			ls_Registro += LeftA(ls_Forma_Pagamento+Space(25), 25)
			ls_Registro += ls_Tipo_Mov
			ls_Registro += of_Formata_Valor_PafEcf(ldc_Total,10,2)
			If PDV.Fabricante = "NFCE" Then				
				ls_Registro += FillA('0',24)  //cpf cliente + documento = para transa$$HEX2$$e700f500$$ENDHEX$$es n$$HEX1$$e300$$ENDHEX$$o fiscais, n$$HEX1$$e300$$ENDHEX$$o temos no NFC.
			End If			
			//If FileWrite(pl_arquivo,ls_Registro) = -1 Then lb_Sucesso = False
			
			If Not This.of_grava_registro_temp( 'A2', String( Date(lvds_1.object.dh_movimentacao[ll_row]), 'yyyymmdd' ), ls_Tipo_Mov2, ls_Forma_Pagamento, ls_Registro ) Then
				lb_Sucesso = False
			End If
			
			ls_Registro = ''
			ldh_Data_Atual = Date(lvds_1.object.dh_movimentacao[ll_row])
			If Not lb_Sucesso Then Exit	
		End If
	Next
	//Se os ultimos registros da consulta forem CN.
	If ldc_acumulador <> 0.000  Then
		ls_Registro += 'A2' 						
		ls_Registro += String(ldh_Data_Atual,'yyyymmdd')
		ls_Registro += LeftA('DINHEIRO'+Space(25), 25)
		ls_Registro += '2'
		ls_Registro += of_Formata_Valor_PafEcf(ldc_acumulador,10,2)
		//If FileWrite(pl_arquivo,ls_Registro) = -1 Then lb_Sucesso = False
		
		If Not This.of_grava_registro_temp( 'A2', String(ldh_Data_Atual,'yyyymmdd'), ls_Tipo_Mov2, 'DINHEIRO', ls_Registro ) Then
			lb_Sucesso = False
		End If
		
		ls_Registro = ''
		ldc_acumulador = 0.000
	End If	

End If

Destroy(lvds_1)

Return lb_Sucesso 
end function

public function boolean of_busca_ecf_primeira_venda (ref long pl_ecf);Select i1.nr_ecf Into   :pl_ecf
From   impressora_fiscal i1
WHERE i1.dh_primeira_venda_dia =
	(SELECT MAX(i2.dh_primeira_venda_dia)
	 FROM impressora_fiscal i2)
Using Sqlca;

If Sqlca.Sqlcode = -1 Then
	Sqlca.of_MsgDbError('Localiza$$HEX2$$e700e300$$ENDHEX$$o primeira venda da ECF.')
	Return False
End If

Return True
end function

public function boolean of_pafecf_registro_r07 (long pl_ecf, date pdh_inicial, date pdh_final, long pl_arquivo, ref boolean pb_evidenciado);
Boolean 	lb_Sucesso = True

String 	ls_Registro

Long 	 	ll_Row
Long     ll_Retorno
Long		ll_coo_ecf

String ls_Modelo

dc_uo_ds_base lds_Documento

lds_Documento = Create dc_uo_ds_base

If Not lds_Documento.of_ChangeDataObject('dw_ge038_pafecf_cupom_meio_pagamento') Then Return False

ll_Retorno = lds_Documento.Retrieve(pl_ecf, pdh_inicial, pdh_final)

If ll_Retorno <> -1 Then

	For ll_Row = 1 To lds_Documento.RowCount()
				
		ls_Registro += 'R07'
		
		ls_Registro += LeftA(This.nr_Serie + Space(20), 20)
	
		ls_Registro += LeftA(This.id_MfAdicional, 1)
					 
		// Acerto para inserir ? nos espa$$HEX1$$e700$$ENDHEX$$os em branco dos registros alterados
		ls_Modelo = Space(20)
						
		ll_coo_ecf = lds_Documento.object.nr_operacao_ecf[ll_row] + 1 
		
		//Verifica se h$$HEX1$$e100$$ENDHEX$$ altera$$HEX2$$e700e300$$ENDHEX$$o nos dados da ECF
		If of_inconsistencia_impressora_fiscal(pl_ecf) Then
			ls_Modelo = FillA("?", 20)
			ls_Registro += gf_Replace(LeftA( This.de_Modelo + ls_Modelo , 20 ), " ", "?", 0)		
			pb_evidenciado = True		
		//Verifica se h$$HEX1$$e100$$ENDHEX$$ altera$$HEX2$$e700e300$$ENDHEX$$o nos dados dos documentos ECF
		ElseIf of_inconsistencia_documento_ecf(pl_ecf, Date(lds_Documento.object.dh_movimentacao_caixa[ll_row]), ll_coo_ecf) Then		
			ls_Modelo = FillA("?", 20)
			ls_Registro += gf_Replace(LeftA( This.de_Modelo + ls_Modelo , 20 ), " ", "?", 0)		
			pb_evidenciado = True
		ElseIf of_inconsistencia_meio_pagamento(lds_Documento.object.nr_operacao_ecf[ll_row], pl_ecf, gvo_Parametro.of_Filial(), False) Then		
			ls_Modelo = FillA("?", 20)
			ls_Registro += gf_Replace(LeftA( This.de_Modelo + ls_Modelo , 20 ), " ", "?", 0)
			pb_evidenciado = True
			This.of_evidencia( String(lds_Documento.object.dh_movimentacao_caixa[ll_row],'yyyymmdd'), lds_Documento.object.cd_forma_pagamento[ll_row], lds_Documento.object.id_Documento[ll_row])
		Else				
			ls_Registro += LeftA( This.de_Modelo + ls_Modelo , 20 )
		End If
		
		ls_Registro += '01'
		
		ls_Registro += String(lds_Documento.object.nr_operacao_ecf[ll_row],'000000000')
		
		ls_Registro += String(lds_Documento.object.nr_ccf[ll_row],'000000000')

		ls_Registro += FillA("0", 6)

//		Choose Case lds_Documento.object.cd_forma_pagamento[ll_row]
//			Case 'DI'
//				ls_Registro += 'DINHEIRO       '
//			Case 'HA'
//				ls_Registro += 'CHEQUE         '
//			Case 'HP'
//				ls_Registro += 'CHEQUE-PRE     '
//			Case 'CA'
//				ls_Registro += 'CARTAO DEBITO  '
//			Case 'CP'
//				ls_Registro += 'CARTAO CREDITO '
//			Case 'CV'
//				ls_Registro += 'CONVENIO       '
//			Case Else
//				ls_Registro += 'DINHEIRO       '
//		End Choose		

		ls_Registro += lds_Documento.object.cd_forma_pagamento[ll_row]
			
		ls_Registro += of_Formata_Valor_PafEcf(lds_Documento.object.vl_pagamento[ll_row],11,02)
		
		ls_Registro += 'N'
		
		ls_Registro += FillA("0", 13)

		//If FileWrite(pl_arquivo,ls_Registro) = -1 Then lb_Sucesso = False
		
		If Not This.of_grava_registro_temp( 'R07', String(lds_Documento.object.dh_movimentacao_caixa[ll_row], 'yyyymmdd') , lds_Documento.object.id_documento[ll_row] ,lds_Documento.object.cd_forma_pagamento[ll_row], ls_Registro ) Then
			lb_Sucesso = False
		End If

		
		ls_Registro = ''
		
		If Not lb_Sucesso Then Exit
		
	Next
	
Else
	lb_Sucesso = False
	
End If	

Destroy(lds_Documento)

Return lb_Sucesso
end function

public subroutine of_grava_registro_temp_arquivo (long pl_arquivo);Long ll_Linha

String ls_Registro

For ll_Linha = 1 To ids_Arquivo.RowCount( )	
	ls_Registro = ids_Arquivo.Object.de_Registro[ ll_Linha ]
	
	FileWrite( pl_arquivo,ls_Registro )
Next
end subroutine

public function boolean of_grava_registro_temp (string ps_tipo, string ps_data, string ps_tipo_doc, string ps_meio_pagamento, string ps_registro);Long ll_Linha

ll_Linha = ids_Arquivo.InsertRow( 0 )

ids_Arquivo.Object.Nr_Ordem[ ll_Linha ] = ll_Linha
ids_Arquivo.Object.de_Tipo[ ll_Linha ] = ps_Tipo
ids_Arquivo.Object.dt_Data[ ll_Linha ] = ps_Data
ids_Arquivo.Object.de_Meio_Pagamento[ ll_Linha ] = ps_meio_pagamento
ids_Arquivo.Object.de_Registro[ ll_Linha ] = ps_Registro
ids_Arquivo.Object.de_Tipo_Pagamento[ ll_Linha ] = ps_tipo_doc

Return True
end function

public function boolean of_evidencia (string ps_data, string ps_meio_pagamento, string ps_tipo_doc);Long ll_Find

String ls_Find
String ls_Registro
String ls_evidencia

ls_Find =  "de_tipo = 'A2' and dt_data = '" + ps_Data + "' and de_tipo_pagamento = '" + ps_tipo_doc + "' and de_meio_pagamento = '" + ps_Meio_Pagamento + "'"

ll_Find = ids_Arquivo.Find( ls_Find, 1, ids_Arquivo.RowCount( ) )

If ll_Find < 0 Then
	Return False
ElseIf ll_Find = 0 Then
	Return False
End If

ls_Registro = ids_Arquivo.Object.de_Registro[ ll_Find ]

ls_Evidencia = Trim(MidA(ls_Registro,11,25))

ls_Evidencia = LeftA(ls_Evidencia + FillA('?',25),25)

ls_Registro = MidA(ls_Registro,1,10) + ls_Evidencia + MidA(ls_Registro,36)

ids_Arquivo.Object.de_Registro[ ll_Find ] = ls_Registro

Return False
end function

public function boolean of_atualiza_dll_sign ();Boolean	lb_Sucesso 		= True

String   ls_Path_System
String	   ls_path_dll = 'c:\sistemas\dll\bematech'
String   ls_Validar[]
String   ls_Baixar[]

ls_Validar = {"sign_bema.dll"}
ls_Baixar  = {"sign_bema.zip"}

If gvo_Aplicacao.of_is64bits() Then
	ls_Path_System = 'C:\Windows\SysWOW64'
Else
	ls_Path_System = gvo_Aplicacao.of_Get_System_Directory()
End If	

dc_uo_api lo_api
lo_api = Create dc_uo_api

If FileExists(ls_Path_System + '\sign_bema.dll')  And lb_Sucesso Then
	
	If Not FileExists(ls_Path_dll) Then
		lo_Api.of_Create_Directory(ls_Path_dll)
	End If
	
	//Move para diretorio das dlls	
	If Not lo_api.of_move_file(ls_Path_System + '\sign_bema.dll', ls_Path_dll + '\sign_bema.dll', true, true) Then lb_Sucesso = False					
	
End If

If Not FileExists(ls_Path_dll + '\sign_bema.dll')  And lb_Sucesso Then

	lb_Sucesso = gf_Download_Matriz(ls_Validar, ls_Baixar, ls_Path_dll, "dll_bematech", True)	

End If

Destroy(lo_api)

If IsValid(w_Aguarde_1) Then Close(w_Aguarde_1)

Return lb_Sucesso
end function

public function boolean of_abre_arquivo ();ivi_Arquivo_Xml  = FileOpen(ivs_Arquivo_Xml , TextMode!, Write!, LockReadWrite!, Replace! )

If ivi_Arquivo_Xml < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel abrir o arquivo '" + ivs_Arquivo_Xml  + ".")
	Return False
End If

Return True
end function

public function string of_abre_tag (string ps_tag, long pl_identacao);String lvs_Retorno

lvs_Retorno = This.of_Identa("<" + ps_Tag + ">", pl_identacao) + ivs_Enter

Return lvs_Retorno
end function

public function string of_identa (string ps_registro, long pl_tabulacao);Long lvl_Linha

For lvl_Linha = 1 To pl_Tabulacao
	ps_Registro = ivs_Tab + ps_Registro
Next

Return ps_Registro
end function

public function string of_elemento (string ps_tag, string ps_string, long pl_identacao);String lvs_Retorno

lvs_Retorno = This.of_Identa("<" + ps_Tag + ">" + ps_String + "</" + ps_Tag + ">", pl_identacao) + ivs_Enter

Return lvs_Retorno
end function

public function string of_fecha_tag (string ps_tag, long pl_identacao);String lvs_Retorno

lvs_Retorno = This.of_Identa("</" + ps_Tag + ">", pl_identacao) + ivs_Enter

Return lvs_Retorno
end function

public function boolean of_grava_arquivo (integer pi_arquivo, string ps_registro);Long ll_Write

ll_Write = FileWriteEx( pi_Arquivo, ps_Registro )

If ll_Write < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel gravar registro no arquivo '" + ivs_Arquivo_Xml + "'")
	Return False
End If

Return True
end function

public function boolean of_grava_arquivo (string ps_registro);Return This.of_Grava_Arquivo( ivi_Arquivo_XML, ps_Registro )
end function

public function boolean of_gera_vendas_identificadas (date pdh_inicial, date pdh_final, long pl_arquivo, string ps_cpf);Boolean lb_Sucesso = True

Long ll_Retorno
Long ll_row
Long ll_qt_registros

String ls_Registro
String ls_Modelo
String ls_Insc_estadual
String ls_Forma_Pagamento
String ls_Tipo_Mov
String ls_Tipo_Mov2

Date ldh_Data_Atual

Decimal{2} ldc_total
Decimal{2} ldc_acumulador

dc_uo_ds_base lvds_1
lvds_1 = Create dc_uo_ds_base

If Not lvds_1.of_ChangeDataObject('ds_ge038_pafecf_venda_identificada') Then 
	Destroy(lvds_1)
	Return False
End If

If PDV.fabricante = 'NFCE' Then
	lvds_1.of_AppendWhere("de_especie = 'NFC'")	
Else
	lvds_1.of_AppendWhere("de_especie = 'CF'")		
End If

If Not IsNull(ps_cpf) And Trim(ps_cpf) <> '' Then
	lvds_1.of_AppendWhere("nr_cpf_cgc = '" + Trim(ps_cpf) + "'")
End If
lvds_1.Retrieve(pdh_inicial, pdh_final)

If lvds_1.RowCount() > 0 Then
	ll_qt_registros = lvds_1.RowCount()

	For ll_row = 1 To lvds_1.RowCount()	
		
		ldc_total = lvds_1.object.total[ll_row]			
			
		ls_Registro += 'Z4' 
		ls_Registro += RightA(FillA("0",3) + lvds_1.object.nr_cpf_cgc[ll_row],14)
		ls_Registro += of_Formata_Valor_PafEcf(ldc_Total,12,2)		
		ls_Registro += String(pdh_inicial,'yyyymmdd')
		ls_Registro += String(pdh_final,'yyyymmdd')		
		ls_Registro += String(Date(Today()),'yyyymmdd')
		ls_Registro += String(Time(Today()),'hhmmss')
	
		If Not This.of_grava_registro_temp( 'Z4', '', '', '', ls_Registro ) Then
			lb_Sucesso = False
		End If
		
		ls_Registro = ''
		If Not lb_Sucesso Then Exit	

	Next

	ls_Registro += 'Z9' 
	ls_Registro += LeftA('84683481000177'+Space(14), 14)
	ls_Registro += LeftA('250330539'+Space(14), 14)
	ls_Registro += String(ll_qt_registros,'000000')
	
	If Not This.of_grava_registro_temp( 'Z9', '', '', '', ls_Registro ) Then
		lb_Sucesso = False
	End If
	
	ls_Registro = ''	
End If

Destroy(lvds_1)

Return lb_Sucesso 
end function

public function boolean of_envia_pendencias_blocox (string ps_tipo, long pl_ecf, boolean pb_aviso);Boolean lb_Sucesso, &
		   lb_reenvio

Long 	ll_Retorno, &
		ll_Row, &
		ll_Sequencial, &
		ll_ecf, &
		ll_mapa, &
		ll_cont_rz, &
		ll_filial, &
		ll_mes, &
		ll_ano, &
		ll_file
		
String	ls_tipo, &
		ls_recibo, &
		ls_recibo_salvo, &
		ls_mensagem, &
		ls_situacao, &
		ls_situacao_salvo, &
		ls_retorno, &
		ls_codigo, &
		ls_arquivo_retorno, &
		ls_situacao_ws, &
		ls_Arquivo_Consulta,&
		ls_Arquivo_Recibo,&
		ls_erro, &
		ls_nome_xml,&
		ls_conteudo,&
		ls_msg,&
		ls_recibo_retorno

String ls_diretorio_arquivos
String ls_diretorio_arquivos_assinados = 'C:\Sistemas\CL\Arquivos\PAF-ECF\AssinadosX'
String ls_diretorio_arquivos_retorno = 'C:\Sistemas\CL\Arquivos\PAF-ECF\RetornosX'
String ls_diretorio_arquivos_recibo = 'C:\Sistemas\CL\Arquivos\PAF-ECF\Recibos - Bloco X'

Date	ldt_movimento

DateTime ldt_reducaoz

If Not DirectoryExists(ls_diretorio_arquivos_assinados) Then CreateDirectory(ls_diretorio_arquivos_assinados)
If Not DirectoryExists(ls_diretorio_arquivos_retorno) Then CreateDirectory(ls_diretorio_arquivos_retorno)
If Not DirectoryExists(ls_diretorio_arquivos_recibo) Then CreateDirectory(ls_diretorio_arquivos_recibo)

Try
	Open(w_janela_aguarde)	
	w_janela_aguarde.mle_1.Text = "Enviando Arquivos BlocoX ..."	
	
	dc_uo_ds_base lds_Pendencias
	lds_Pendencias  = Create dc_uo_ds_base
	//debug teste
	//This.of_envia_pendencias_blocox_matriz( 'RZ', 0, false, false)	
	//
	If Not lds_Pendencias.of_ChangeDataObject('dw_ge038_pafecf_hist_blocox') Then Return False
	
	If Not IsNull(ps_tipo) And Trim(ps_Tipo) <> '' Then
		lds_Pendencias.of_AppendWhere("cd_tipo = '" + Trim(ps_Tipo) + "'")
	End If
	If Not IsNull(pl_ecf) And pl_ecf > 0 Then
		lds_Pendencias.of_AppendWhere("nr_ecf = " + String(pl_ecf))	
	End If
	lds_Pendencias.of_AppendWhere("id_situacao in ('P','A')")	
	
	ll_Retorno = lds_Pendencias.Retrieve()
	
	If ps_tipo = 'RZ' Then
		lds_Pendencias.SetSort("qt_reducao_z asc")
		ls_diretorio_arquivos = 'C:\Sistemas\CL\Arquivos\PAF-ECF\Arquivos - Redu$$HEX2$$e700e300$$ENDHEX$$o Z'	
	End If
	If ps_tipo = 'EST' Then
		lds_Pendencias.SetSort("dh_estoque asc")
		ls_diretorio_arquivos = 'C:\Sistemas\CL\Arquivos\PAF-ECF\Arquivos - Estoque Mensal'	
	End If
	
	
	If ll_Retorno <> -1 Then
		If lds_Pendencias.RowCount() = 0 Then
			If pb_aviso Then
				MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Sem pend$$HEX1$$ea00$$ENDHEX$$ncias de Envio!", Information!)			
			End If
			Return True
		Else
			For ll_Row = 1 To lds_Pendencias.RowCount()	
				ll_sequencial 		= lds_Pendencias.object.nr_sequencial[ll_row]
				ll_filial				= lds_Pendencias.object.cd_filial[ll_row]
				ll_ecf					= lds_Pendencias.object.nr_ecf[ll_row]
				ls_tipo		 		= lds_Pendencias.object.cd_tipo[ll_row]
				ll_cont_rz	 		= lds_Pendencias.object.qt_reducao_z[ll_row]
				ll_mapa				= lds_Pendencias.object.nr_mapa_resumo[ll_row]
				ldt_movimento		= lds_Pendencias.object.dh_movimento[ll_row]
				ls_recibo_salvo		= lds_Pendencias.object.nr_recibo[ll_row]
				ls_situacao_salvo	= lds_Pendencias.object.id_situacao[ll_row]

				If ls_situacao_salvo = 'A' Then //J$$HEX1$$e100$$ENDHEX$$ enviou e est$$HEX1$$e100$$ENDHEX$$ aguardando processamento SEFAZ, vai enviar novamente a verifica$$HEX2$$e700e300$$ENDHEX$$o de status.
					If Trim(ls_recibo_salvo) > '' Or Not IsNull(ls_recibo_salvo) Then						
						//Comp$$HEX1$$f500$$ENDHEX$$e o nome do arquivo
						If ps_tipo = 'RZ' Then
							ls_Arquivo_Consulta	= 'Reducao Z ' + String(ldt_movimento,'ddmmyyyy') + '_consulta.xml'
							ls_Arquivo_Recibo	= 'Reducao Z ' + String(ldt_movimento,'ddmmyyyy') + '_recibo.xml'					
						End If
						If ps_tipo = 'EST' Then
							ll_mes = Month(ldt_movimento)
							ll_ano = Year(ldt_movimento)
							ls_Arquivo_Consulta	= 'Estoque ' + String(ll_mes,'00') + String(ll_ano) + '_consulta.xml'
							ls_Arquivo_Recibo	= 'Estoque ' +  String(ll_mes,'00') + String(ll_ano) + '_recibo.xml'					
						End If						
						
						If This.of_gera_xml_consulta_loja( ll_Filial, ps_tipo, ldt_movimento, ll_ecf, ll_sequencial, ls_diretorio_arquivos, ls_recibo_salvo, Ref ls_erro, Ref ls_nome_xml) Then
							If This.of_assinar_arquivo( ls_nome_xml, ls_diretorio_arquivos +'\'+ ls_nome_xml+'.xml' , ls_diretorio_arquivos_assinados+'\', false) Then
								ll_File = FileOpen(ls_diretorio_arquivos_assinados +'\'+ ls_nome_xml+'.xml', StreamMode!)			
								If ll_File = -1 Then
									//msg erro assinar
								Else								
									FileRead(ll_File, ls_conteudo)								
									FileClose(ll_File)
									
									uo_ge038_ws lo_WS
									lo_WS = Create uo_ge038_ws
									
									ls_retorno = lo_WS.of_consulta_recibo(ls_conteudo)
								
									If Not IsNull(ls_retorno) And Trim(ls_retorno) > '' Then
										If lo_WS.of_Trata_Retorno_Geral( ls_Retorno ) > 0 Then
											
											This.of_grava_retorno(ls_retorno, ls_diretorio_arquivos_retorno+"\"+ls_arquivo_consulta, Ref ls_msg)
											
											lo_WS.of_Valor_Retornado( Lower( ls_Retorno ), 'situacaoprocessamentocodigo'		, ref ls_codigo )
											lo_WS.of_Valor_Retornado( Lower( ls_Retorno ), 'situacaoprocessamentodescricao'	, ref ls_situacao_ws )
											lo_WS.of_Valor_Retornado( Lower( ls_Retorno ), 'mensagem'	, ref ls_mensagem )
											lo_WS.of_Valor_Retornado( Lower( ls_Retorno ), 'recibo'		, ref ls_recibo_retorno )			
											
											ls_situacao_ws 	= LeftA(ls_situacao_ws,100)
											ls_mensagem		= LeftA(ls_mensagem,200)
										
											Choose Case ls_codigo
												Case '0'
													ls_situacao = 'A'
													lb_sucesso = True													
												Case '1'
													ls_situacao = 'S'
													lb_sucesso = True
													This.of_grava_retorno(ls_retorno, ls_diretorio_arquivos_recibo+"\"+ls_Arquivo_Recibo, Ref ls_msg)		
													//Gravar arquivo assinado quando sucesso no FTP
												Case '2'
													ls_situacao = 'E'
													lb_sucesso = True
												Case '3'
													ls_situacao = 'C'
													lb_sucesso = True
												Case Else
													//msg erro
													//This.Of_Grava_Log("R", "E", "INF", This.ClassName()+".of_consulta_recibo(): Situa$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o esperada. Arquivo: "+ lvs_Arquivo_consulta + " Retorno Sefaz Codigo: " + lvs_codigo + " Mensagem: " + lvs_mensagem, true, True, True)
													lb_sucesso = False
													Return False
											End Choose
										
											If lb_sucesso Then		//Sucesso na consulta, mas o retorno pode ser de erro.
									
												Update historico_envio_arquivo_paf
												Set id_situacao = :ls_situacao,
													  de_descricao_processamento = :ls_situacao_ws,
													  de_mensagem_retorno = :ls_mensagem,
													  dh_consulta_processo = GetDate()
												Where nr_sequencial = :ll_sequencial
												  and cd_filial   = :ll_filial
												Using Sqlca;
												
												If Sqlca.Sqlcode = -1 Then
													SQLCa.Of_Rollback()
													SQLCa.Of_MsgDBError("Erro ao atualizar historico.")
													Return False
												Else
													Sqlca.of_Commit()	
												End If
											End If											
										Else
											MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao tratar retorno webservice.")
											Return False
										End If								
									Else
										MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Retorno NULO webservice.")
										Return False
									End If
								End If
							else
								MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao assinar arquivo de consulta.")
								Return False
							End If
						Else
							MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro gerar xml consulta.")
							Return False
						End If
					Else
						//recibo vazio
						lb_sucesso = False
						Destroy(lo_WS)						
					End If
					lb_reenvio = True
				Else
					lb_reenvio = False
					lb_sucesso = False
				End If
				
				If Not lb_reenvio Then				
					If ls_tipo = 'RZ' Then
						//busca data da redu$$HEX2$$e700e300$$ENDHEX$$o z
						Select dh_emissao
						  Into :ldt_reducaoz
						  From mapa_resumo
						 Where cd_filial = :ll_filial
							and nr_mapa = :ll_mapa
							and de_especie = 'MR'
							and de_serie = '1'
						 Using SQLCa;					
	//					Select dh_reducao
	//					  Into :ldt_reducaoz
	//					  From mapa_resumo_ecf
	//					 Where cd_filial = :ll_filial
	//						and nr_mapa = :ll_mapa
	//						and de_especie = 'MR'
	//						and de_serie = '1'
	//						and nr_ecf = :ll_ecf
	//					 Using SQLCa;
						
						If SQLCa.SQLCode = -1 Then
							SQLCa.Of_MsgDBError("Erro ao localizar mapa resumo.")
							Return False
						End If
						
						//Gera xml e envia ao Sefaz
						If Not of_gera_blocox_reducao(date(ldt_reducaoz), ll_ecf, Ref ls_recibo, Ref ls_situacao, ll_sequencial, ll_filial) Then
							Return False
						End If	
					End If
					
					If ls_tipo = 'EST' Then
						ll_mes = Month(ldt_movimento)
						ll_ano = Year(ldt_movimento)
						
						If Not of_gera_blocox_estoque(ll_mes, ll_ano, Ref ls_recibo, Ref ls_situacao) Then					
							Return False
						End If				
					End If
					
					If Trim(ls_recibo) <> '' And Not IsNull(ls_recibo) Then
						If ls_situacao = '1' Then
							ls_situacao = 'E'
						End If
						If ls_situacao = '0' Then
							ls_situacao = 'A'
						End If
						
						Update historico_envio_arquivo_paf
						Set nr_recibo = :ls_recibo,
							 id_situacao = :ls_situacao
						Where nr_sequencial = :ll_sequencial
						  and cd_filial   = :ll_filial
						Using Sqlca;
						
						If Sqlca.Sqlcode = -1 Then
							SqlCa.of_RollBack( )
							Sqlca.Of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do hist$$HEX1$$f300$$ENDHEX$$rico de envio PAF.")
							Return False
						Else
							Sqlca.of_Commit()				
						End If
					End If
				End If
			
			Next			
			If pb_aviso Then
				If ls_tipo = 'RZ' Then
					ls_mensagem = "Arquivo com Informa$$HEX2$$e700f500$$ENDHEX$$es da Redu$$HEX2$$e700e300$$ENDHEX$$o Z do PAF-ECF transmitido com sucesso."
				Else
					ls_mensagem = "Arquivo com Informa$$HEX2$$e700f500$$ENDHEX$$es do Estoque Mensal do Estabelecimento transmitido com sucesso."
				End If
				MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_mensagem, Information!)
				lb_sucesso = true
			End If	
		End If
	End If	
	
	Return lb_Sucesso
	
Finally
	Destroy(lds_Pendencias)
	Close(w_janela_aguarde)
End Try
end function

public function boolean of_gera_produto_estoque (integer pl_arquivo, string ps_tipo, ref boolean pb_evidenciado);Long ll_Row
Long ll_Linhas
Long ll_Produto

String ls_Estoque
String ls_IAT
String ls_IPPT
String ls_Situacao_Tributaria
String ls_Registro
String ls_Desc_Produto
String ls_Und
String ls_Unidade
String ls_codigo_barras
String ls_Cest
String ls_NCM

Decimal{2} ldc_Preco
Decimal{2} ldc_Aliquota
Decimal{2} ldc_Desconto

dc_uo_ds_base lvds_produto
lvds_produto = Create dc_uo_ds_base

uo_Produto lvo_Produto
lvo_Produto = Create uo_Produto

uo_Tratamento_Fiscal	lvo_tratamento_fiscal
lvo_tratamento_fiscal = Create uo_Tratamento_Fiscal

uo_Atributo_Fiscal_Item_Nf	lvo_atributo
lvo_atributo = Create uo_Atributo_Fiscal_Item_Nf

lvo_tratamento_fiscal.of_grava_uf_origem_destino( gvo_parametro.ivs_uf_filial, gvo_parametro.ivs_uf_filial)

If ps_tipo = 'P' Then	
	
	SetPointer(HourGlass!)
	
	Open(w_Aguarde)
	w_Aguarde.Title = "Gerando arquivos Produto..."
	ll_Linhas = lvds_produto.RowCount()
	
	w_Aguarde.uo_Progress.of_SetMax(ll_Linhas)	
	
	For ll_Row = 1 To lvds_produto.RowCount()
	
		ll_Produto 		  = lvds_produto.Object.Cd_Produto[ll_Row]	
		ls_Desc_Produto = lvds_produto.Object.De_Produto[ll_Row]
		ls_Und			  = lvds_produto.Object.cd_un[ll_Row]
	
		lvo_Produto.of_Localiza_Codigo_Interno(ll_Produto)
		
		// Carrega os atributos fiscais 
		lvo_atributo = lvo_tratamento_fiscal.of_atributo_fiscal_produto(lvo_Produto)
		
		If lvo_Produto.Localizado Then
			ldc_Preco 			= lvo_Produto.of_Preco_Venda_Filial()
			ldc_Desconto  		= lvo_Produto.of_Desconto_Filial()
			ldc_Preco 			= ldc_Preco * ((100 - ldc_Desconto) / 100)
			ls_codigo_barras 	= lvo_produto.de_codigo_barras
			If IsNull(lvo_produto.cd_cest) Or Trim(lvo_produto.cd_cest) = '' Then
				ls_cest = '0000000'
			Else
				ls_cest = lvo_produto.cd_cest
			End If			
			If IsNull(String(lvo_produto.nr_classificacao_fiscal,'00000000')) Then	
				ls_ncm = '00000000'
			Else
				ls_ncm = String(lvo_produto.nr_classificacao_fiscal,'00000000')
			End If

			Choose Case lvo_atributo.cd_situacao_tributaria
				Case '00'
					ls_Situacao_Tributaria = 'T'
					ldc_Aliquota = lvo_tratamento_fiscal.of_Aliquota_Tipo_ICMS(lvo_produto.cd_tipo_icms)							
				Case '04'
					ls_Situacao_Tributaria = 'I'
					ldc_Aliquota = 0.00
				Case else
					ls_Situacao_Tributaria = 'F'
					ldc_Aliquota = 0.00
			End Choose 
			
			ls_IAT = 'A'
			ls_IPPT = 'T'
			
		End If
		
		// Acerto para inserir ? nos espa$$HEX1$$e700$$ENDHEX$$os em branco dos registros alterados
		ls_Unidade = Space(6)
		
		//Verifica se h$$HEX1$$e100$$ENDHEX$$ altera$$HEX2$$e700e300$$ENDHEX$$o nos dados do estoque
		If This.of_inconsistencia_produto_geral(ll_Produto) Then
			ls_Unidade = FillA("?", 6)
			pb_Evidenciado = True			
		ElseIf This.of_inconsistencia_saldo_produto(ll_Produto, Today(), False, 0) Then
			ls_Unidade = FillA("?", 6)
			pb_Evidenciado = True
		End If				
		
		ls_Registro += 'P2' 						
		ls_Registro += LeftA(gvo_parametro.nr_cgc+Space(14),14)
		ls_Registro += LeftA(String(ll_produto)+Space(14),14)
		ls_Registro += LeftA(ls_cest+Space(7),7)
		ls_Registro += LeftA(ls_ncm+Space(8),8)		
		ls_Registro += LeftA(ls_Desc_Produto+Space(50),50)
		ls_Registro += LeftA(ls_und+ls_Unidade,6)
		ls_Registro += LeftA(ls_IAT,1)
		ls_Registro += LeftA(ls_IPPT,1)
		ls_Registro += LeftA(ls_Situacao_Tributaria,1)
		ls_Registro += This.of_Formata_Valor_PafEcf(ldc_Aliquota,2,2)
		ls_Registro += This.of_Formata_Valor_PafEcf(ldc_Preco,10,2)
		//If FileWrite(pl_arquivo,ls_Registro) = -1 Then Return False
		
		If Not This.of_grava_registro_temp( 'P2', '', '', '', ls_Registro ) Then
			Return False
		End If	
		
		ls_Registro = ''
		w_Aguarde.uo_Progress.of_SetProgress(ll_Row)
	
	Next

	Close(w_Aguarde)

End If

If ps_tipo = 'T' Then
	If Not lvds_produto.of_ChangeDataObject('dw_ge038_pafecf_estoque') Then
		Return False
	End If
	
	lvds_produto.Retrieve()
	
	SetPointer(HourGlass!)
	
	Open(w_Aguarde)
	w_Aguarde.Title = "Gerando arquivos Produto..."
	ll_Linhas = lvds_produto.RowCount()
	
	w_Aguarde.uo_Progress.of_SetMax(ll_Linhas)	
	
	For ll_Row = 1 To lvds_produto.RowCount()
	
		ll_Produto 		  = lvds_produto.Object.Cd_Produto[ll_Row]	
		ls_Desc_Produto = lvds_produto.Object.De_Produto[ll_Row]
		ls_Und			  = lvds_produto.Object.cd_un[ll_Row]
	
		lvo_Produto.of_Localiza_Codigo_Interno(ll_Produto)
		
		// Carrega os atributos fiscais 
		lvo_atributo = lvo_tratamento_fiscal.of_atributo_fiscal_produto(lvo_Produto)
		
		If lvo_Produto.Localizado Then
			ldc_Preco = lvo_Produto.of_Preco_Venda_Filial()
			ldc_Desconto  	= lvo_Produto.of_Desconto_Filial()
			ldc_Preco 		= ldc_Preco * ((100 - ldc_Desconto) / 100)
			ls_codigo_barras 	= lvo_produto.de_codigo_barras
			If IsNull(lvo_produto.cd_cest) Or Trim(lvo_produto.cd_cest) = '' Then
				ls_cest = '0000000'
			Else
				ls_cest = lvo_produto.cd_cest
			End If			
			If IsNull(String(lvo_produto.nr_classificacao_fiscal,'00000000')) Then	
				ls_ncm = '00000000'
			Else
				ls_ncm = String(lvo_produto.nr_classificacao_fiscal,'00000000')
			End If			

			Choose Case lvo_atributo.cd_situacao_tributaria
				Case '00'
					ls_Situacao_Tributaria = 'T'
					ldc_Aliquota = lvo_tratamento_fiscal.of_Aliquota_Tipo_ICMS(lvo_produto.cd_tipo_icms)							
				Case '04'
					ls_Situacao_Tributaria = 'I'
					ldc_Aliquota = 0.00
				Case else
					ls_Situacao_Tributaria = 'F'
					ldc_Aliquota = 0.00
			End Choose 
			
			ls_IAT = 'A'
			ls_IPPT = 'T'
			
		End If
		
		// Acerto para inserir ? nos espa$$HEX1$$e700$$ENDHEX$$os em branco dos registros alterados
		ls_Unidade = Space(6)
		
		//Verifica se h$$HEX1$$e100$$ENDHEX$$ altera$$HEX2$$e700e300$$ENDHEX$$o nos dados do estoque
		If This.of_inconsistencia_produto_geral(ll_Produto) Then
			ls_Unidade = FillA("?", 6)
			pb_Evidenciado = True			
		ElseIf This.of_inconsistencia_saldo_produto(ll_Produto, Today(), False, 0) Then
			ls_Unidade = FillA("?", 6)
			pb_Evidenciado = True
		End If				
		
		ls_Registro += 'P2' 						
		ls_Registro += LeftA(gvo_parametro.nr_cgc+Space(14),14)
		ls_Registro += LeftA(String(ll_produto)+Space(14),14)
		ls_Registro += LeftA(ls_cest+Space(7),7)
		ls_Registro += LeftA(ls_ncm+Space(8),8)				
		ls_Registro += LeftA(ls_Desc_Produto+Space(50),50)
		ls_Registro += LeftA(ls_und+ls_Unidade,6)
		ls_Registro += LeftA(ls_IAT,1)
		ls_Registro += LeftA(ls_IPPT,1)
		ls_Registro += LeftA(ls_Situacao_Tributaria,1)
		ls_Registro += This.of_Formata_Valor_PafEcf(ldc_Aliquota,2,2)
		ls_Registro += This.of_Formata_Valor_PafEcf(ldc_Preco,10,2)
		//If FileWrite(pl_arquivo,ls_Registro) = -1 Then Return False
		
		If Not This.of_grava_registro_temp( 'P2', '', '', '', ls_Registro ) Then
			Return False
		End If	
		
		ls_Registro = ''
		w_Aguarde.uo_Progress.of_SetProgress(ll_Row)
	
	Next
	
	Close(w_Aguarde)	
	
End If

Destroy(lvo_Produto)
Destroy(lvo_atributo)
Destroy(lvo_tratamento_fiscal)
Destroy(lvds_produto)

Return True
end function

public function boolean of_gera_estoque_saldo (integer pl_arquivo, string ps_tipo, datetime pdt_data_estoque, ref boolean pb_evidenciado);Long ll_Row
Long ll_Linhas
Long ll_Produto
Long ll_Saldo
Long ll_Movimentado
Long ll_Quantidade

String ls_Estoque
String ls_Registro
String ls_Desc_Produto
String ls_Und
String ls_Unidade
String ls_Sinal
String ls_cest
String ls_ncm

DateTime ldh_Data_Estoque
Date ldh_Data_Movimento

//This.of_data_primeira_venda(ldh_Data_Estoque, PDV.ecf)
dc_uo_ds_base lvds_produto
lvds_produto = Create dc_uo_ds_base

If ps_tipo = 'P' Then	
	
	SetPointer(HourGlass!)
	
	Open(w_Aguarde)
	w_Aguarde.Title = "Gerando arquivos Saldo Estoque..."
	ll_Linhas = lvds_produto.RowCount()
	
	w_Aguarde.uo_Progress.of_SetMax(ll_Linhas)	
	
	For ll_Row = 1 To lvds_produto.RowCount()
	
		ll_Produto 		  	= lvds_produto.Object.Cd_Produto[ll_Row]	
		ls_Desc_Produto 	= lvds_produto.Object.De_Produto[ll_Row]
		ls_Und			  	= lvds_produto.Object.cd_un[ll_Row]
		If IsNull(lvds_Produto.Object.cd_cest[ll_Row]) Or Trim(lvds_Produto.Object.cd_cest[ll_Row]) = '' Then
			ls_cest = '0000000'
		Else
			ls_cest = lvds_Produto.Object.cd_cest[ll_Row]
		End If			
		If IsNull(String(lvds_Produto.Object.nr_classificacao_fiscal[ll_Row],'00000000')) Then	
			ls_ncm = '00000000'
		Else
			ls_ncm = String(lvds_Produto.Object.nr_classificacao_fiscal[ll_Row],'00000000')
		End If
		
		ldh_Data_Movimento = lvds_produto.object.dh_ultima_venda[ll_row]
//		If Date(ldh_Data_Estoque) = Date(ldh_Data_Movimento) Then	
		If Date(pdt_data_estoque) >= Date(ldh_Data_Movimento) Then				
				
			 SELECT COALESCE( SUM( i.qt_vendida ), 0 ) + dbo.uf_saldo_produto_parcial( Date(:pdt_data_estoque), :ll_produto ) INTO :ll_quantidade
					  FROM nf_venda n
							INNER JOIN item_nf_venda i ON i.cd_filial = n.cd_filial AND
					  i.nr_nf = n.nr_nf AND
					  i.de_especie = n.de_especie AND
					  i.de_serie = n.de_serie
					  WHERE CAST( n.dh_emissao AS DATE ) >= :pdt_data_estoque
						 AND i.cd_produto = :ll_produto
						 AND COALESCE( n.id_cancelamento_impressora, 'N' ) = 'N'
			Using Sqlca;

//			select sum(qt_movimento) 
//				into :ll_quantidade
//			from movimento_estoque
//			where dh_movimento >= :pdt_data_estoque
//			  and cd_tipo_movimento = 1
//			  and cd_produto = :ll_produto
//			Using Sqlca;
//			
			If Sqlca.Sqlcode = -1 Then
				Sqlca.of_MsgDbError('Localiza$$HEX2$$e700e300$$ENDHEX$$o quantidade mov. estoque.')
				Return False
			End If			

			If IsNull(ll_quantidade) Then
				ll_quantidade = 0
			End If			
			
			//ls_Estoque = Trim(String(lvds_produto.object.qt_saldo_final[ll_row] + ll_quantidade))
			ls_Estoque = Trim(String(ll_quantidade))

		Else		
			ls_Estoque = Trim(String(lvds_produto.object.qt_saldo_final[ll_row]))
		End If		
		
		If Dec(ls_Estoque) < 0 Then
			ls_Estoque = gf_Replace(ls_Estoque,"-","0",0)
			ls_Sinal = "-"
		Else
			ls_Sinal = "+"
		End If		

		// Acerto para inserir ? nos espa$$HEX1$$e700$$ENDHEX$$os em branco dos registros alterados
		ls_Unidade = Space(6)
		
		//Verifica se h$$HEX1$$e100$$ENDHEX$$ altera$$HEX2$$e700e300$$ENDHEX$$o nos dados do estoque
		If This.of_inconsistencia_produto_geral(ll_Produto) Then
			ls_Unidade = FillA("?", 6)
			pb_Evidenciado = True			
		ElseIf This.of_inconsistencia_saldo_produto(ll_Produto, Today(), False, 0) Then
			ls_Unidade = FillA("?", 6)
			pb_Evidenciado = True
		End If		
		
		ll_Saldo = Long(ls_Estoque)
		
		ls_Registro += 'E2' 						
		ls_Registro += LeftA(gvo_parametro.nr_cgc+Space(14),14)
		ls_Registro += LeftA(String(ll_Produto)+Space(14),14)
		ls_Registro += LeftA(ls_cest+Space(7),7)
		ls_Registro += LeftA(ls_ncm+Space(8),8)				
		ls_Registro += LeftA(ls_Desc_Produto+Space(50),50)
		ls_Registro += LeftA(ls_und+ls_Unidade,6)		
		ls_Registro += LeftA(ls_Sinal,1)
//		ls_Registro += RightA('000000000'+ ls_Estoque,09)
		ls_Registro += LeftA(String(ll_Saldo,'000000')+'000',9)		
		If PDV.fabricante = "NFCE" Then
			ls_Registro += String(Date(Today()),'yyyymmdd')
			ls_Registro += String(ldh_Data_Movimento,'yyyymmdd')			
		End If
		
		//If FileWrite(pl_arquivo,ls_Registro) = -1 Then Return False
		
		If Not This.of_grava_registro_temp( 'E2', '', '', '', ls_Registro ) Then
			Return False
		End If
		
		ls_Registro = ''
		w_Aguarde.uo_Progress.of_SetProgress(ll_Row)
	
	Next

	Close(w_Aguarde)
End If

If ps_tipo = 'T' Then	
	If Not lvds_produto.of_ChangeDataObject('dw_ge038_pafecf_estoque') Then
		Return False
	End If
	
	lvds_produto.Retrieve()
	
	SetPointer(HourGlass!)
	
	Open(w_Aguarde)
	w_Aguarde.Title = "Gerando arquivos Saldo Estoque..."
	ll_Linhas = lvds_produto.RowCount()
	
	w_Aguarde.uo_Progress.of_SetMax(ll_Linhas)	
	
	For ll_Row = 1 To lvds_produto.RowCount()
	
		ll_Produto 		  	= lvds_produto.Object.Cd_Produto[ll_Row]	
		ls_Desc_Produto 	= lvds_produto.Object.De_Produto[ll_Row]
		ls_Und			  	= lvds_produto.Object.cd_un[ll_Row]
		If IsNull(lvds_Produto.Object.cd_cest[ll_Row]) Or Trim(lvds_Produto.Object.cd_cest[ll_Row]) = '' Then
			ls_cest = '0000000'
		Else
			ls_cest = lvds_Produto.Object.cd_cest[ll_Row]
		End If			
		If IsNull(String(lvds_Produto.Object.nr_classificacao_fiscal[ll_Row],'00000000')) Then	
			ls_ncm = '00000000'
		Else
			ls_ncm = String(lvds_Produto.Object.nr_classificacao_fiscal[ll_Row],'00000000')
		End If		

		ldh_Data_Movimento = lvds_produto.object.dh_ultima_venda[ll_row]
//		If Date(ldh_Data_Estoque) = Date(ldh_Data_Movimento) Then			
		If Date(pdt_data_estoque) >= Date(ldh_Data_Movimento) Then			
			
			 SELECT COALESCE( SUM( i.qt_vendida ), 0 ) + dbo.uf_saldo_produto_parcial( Date(:pdt_data_estoque), :ll_produto ) INTO :ll_quantidade
					  FROM nf_venda n
							INNER JOIN item_nf_venda i ON i.cd_filial = n.cd_filial AND
					  i.nr_nf = n.nr_nf AND
					  i.de_especie = n.de_especie AND
					  i.de_serie = n.de_serie
					  WHERE CAST( n.dh_emissao AS DATE ) >= :pdt_data_estoque
						 AND i.cd_produto = :ll_produto
						 AND COALESCE( n.id_cancelamento_impressora, 'N' ) = 'N'
			Using Sqlca;
			
//			select sum(qt_movimento) 
//				into :ll_quantidade
//			from movimento_estoque
//			where dh_movimento >= :pdt_data_estoque
//			  and cd_tipo_movimento = 1
//			  and cd_produto = :ll_produto
//			Using Sqlca;
			
			If Sqlca.Sqlcode = -1 Then
				Sqlca.of_MsgDbError('Localiza$$HEX2$$e700e300$$ENDHEX$$o quantidade mov. estoque.')
				Return False
			End If			

			If IsNull(ll_quantidade) Then
				ll_quantidade = 0
			End If			
			
//			ls_Estoque = Trim(String(lvds_produto.object.qt_saldo_final[ll_row] + ll_quantidade))
			ls_Estoque = Trim(String(ll_quantidade))
			
		Else		
			ls_Estoque = Trim(String(lvds_produto.object.qt_saldo_final[ll_row]))
		End If		
		
		If Dec(ls_Estoque) < 0 Then
			ls_Estoque = gf_Replace(ls_Estoque,"-","0",0)
			ls_Sinal = "-"
		Else
			ls_Sinal = "+"
		End If	
		ll_Saldo = Long(ls_Estoque)
		
		// Acerto para inserir ? nos espa$$HEX1$$e700$$ENDHEX$$os em branco dos registros alterados
		ls_Unidade = Space(6)
		
		//Verifica se h$$HEX1$$e100$$ENDHEX$$ altera$$HEX2$$e700e300$$ENDHEX$$o nos dados do estoque
		If This.of_inconsistencia_produto_geral(ll_Produto) Then
			ls_Unidade = FillA("?", 6)
			pb_Evidenciado = True			
		ElseIf This.of_inconsistencia_saldo_produto(ll_Produto, Today(), False, 0) Then
			ls_Unidade = FillA("?", 6)
			pb_Evidenciado = True
		End If				
		
		ls_Registro += 'E2' 						
		ls_Registro += LeftA(gvo_parametro.nr_cgc+Space(14),14)
		ls_Registro += LeftA(String(ll_Produto)+Space(14),14)
		ls_Registro += LeftA(ls_cest+Space(7),7)
		ls_Registro += LeftA(ls_ncm+Space(8),8)				
		ls_Registro += LeftA(ls_Desc_Produto+Space(50),50)
//		ls_Registro += LeftA(ls_und+Space(6),6)
		ls_Registro += LeftA(ls_und+ls_Unidade,6)		
		ls_Registro += LeftA(ls_Sinal,1)
		ls_Registro += LeftA(String(ll_Saldo,'000000')+'000',9)
		//If FileWrite(pl_arquivo,ls_Registro) = -1 Then Return False
		If PDV.fabricante = "NFCE" Then
			ls_Registro += String(Date(Today()),'yyyymmdd')
			ls_Registro += String(ldh_Data_Movimento,'yyyymmdd')			
		End If		
		
		If Not This.of_grava_registro_temp( 'E2', '', '', '', ls_Registro ) Then
			Return False
		End If
		
		ls_Registro = ''
		w_Aguarde.uo_Progress.of_SetProgress(ll_Row)
	
	Next
	
	Close(w_Aguarde)	
	
End If

Return True
end function

public function boolean of_gera_movimento_pafecf (ref string ps_arquivo, long pl_ecf, date pdh_inicial, date pdh_final, date pdh_ultima_venda);Long 		ll_File

Boolean 	lb_Sucesso = False
Boolean	lb_Evidenciado = False
Boolean  lb_EvidenciaA2 = False

String lvs_Arquivo_Evidenciado
String ls_Razao_Social
String ls_Insc_Estadual
String ls_tipo
String ls_marca
String ls_modelo

DateTime ldt_movimentacao
DateTime ldt_data_estoque
DateTime ldt_Ultima_Venda
//wf_cria_diretorio_paf()

ldt_movimentacao = PDV.of_dh_movimentacao()

If Not This.of_Carrega_dados_ecf(PDV.ecf) Then Return False

pl_ecf = PDV.ecf

This.of_data_primeira_venda(ldt_Data_Estoque,pl_ecf)

If pdh_inicial = pdh_final Then
	ps_Arquivo = 'c:\sistemas\cl\arquivos\paf-ecf\' + LeftA(This.cd_identificacao_nacional,6) + RightA(This.nr_Serie_MFD,14) + String(pdh_inicial,'ddmmyyyy') + '.txt'
Else	
	ps_Arquivo = 'c:\sistemas\cl\arquivos\paf-ecf\' + LeftA(This.cd_identificacao_nacional,6) + RightA(This.nr_Serie_MFD,14) + String(gf_GetServerDate(),'ddmmyyyy') + '.txt'
End If	
FileDelete(ps_Arquivo)

ll_File = FileOpen(ps_Arquivo, LineMode!, Write!, LockWrite!, Append!)
	
If ll_File <> - 1 Then
	
	If This.of_inconsistencia_inclusao_exclusao() Then		
		ls_Razao_Social = gf_Replace(gvo_parametro.nm_razao_social, " ", "?", 0) + FillA("?", 50)
	Else
		ls_Razao_Social = gvo_parametro.nm_razao_social + Space(50)
	End If

	ls_Insc_Estadual = gf_replace(gvo_parametro.nr_inscricao_estadual,'.','',0)
	
	If Not This.of_grava_registro_temp( 'U1', '', '', '', 'U1' + &
								 LeftA(gvo_parametro.nr_cgc+Space(14),14) + &
								 LeftA(ls_Insc_Estadual+Space(14),14) + &
								 Space(14) + &
								 LeftA(ls_Razao_Social, 50)  ) Then
	End If
	
	//Registro A2 - Meios Pagamento	
	If Not This.of_gera_meios_pagamento(pdh_inicial, pdh_final, ll_File, Ref lb_Evidenciado) Then
		Return False
	End If

	If pdh_ultima_venda < pdh_final Then
		//Registo P2 - Produtos
		If Not This.of_Gera_Produto_Estoque(ll_File, 'T', Ref lb_Evidenciado) Then		
			Return False
		Else
			//Registo E2 - Saldo
			If Not This.of_Gera_Estoque_Saldo(ll_File, 'T', ldt_Data_Estoque, Ref lb_Evidenciado) Then		
				Return False
			End If			
		End If
	End If

	//Registro E3 - ECFs
	If IsNull(This.de_Tipo) Then 
		ls_Tipo += Space(07)
	Else				 
		ls_Tipo += LeftA(This.de_Tipo + Space(07) , 07 )
	End If
	
	If IsNull(This.de_Marca) Then
		ls_Marca += Space(20)
	Else	
		ls_Marca += LeftA(This.de_Marca + Space(20) , 20 )
	End If
	
	If This.of_inconsistencia_impressora_fiscal(pl_ecf) Then					
		ls_Modelo = FillA("?", 20)
		ls_Modelo = gf_Replace(LeftA( This.de_Modelo + ls_Modelo , 20 ), " ", "?", 0)			
		lb_Evidenciado = True			
	Else
		ls_Modelo += LeftA(This.de_Modelo + Space(20) , 20 )
	End If	
	
	If This.of_grava_registro_temp( 'E3', '', '', '', 'E3' + &
								 LeftA(This.nr_Serie + Space(20),20) + &
								 LeftA(This.id_MfAdicional, 1) + &
								 ls_Tipo + ls_Marca + ls_Modelo + &
								 String(ldt_Data_Estoque,'yyyymmdd') + & 
								 String(ldt_Data_Estoque,'hhmmss') ) Then
		
		lb_sucesso = True
	Else
		Return False
	End If	
		
	If This.of_pafecf_Registro_R01(pl_ecf, pdh_inicial, pdh_final, ll_File, Ref lb_Evidenciado) Then
		
		If This.of_pafecf_Registro_R02(pl_ecf, pdh_inicial, pdh_final, ll_File, Ref lb_Evidenciado) Then
			
			If This.of_pafecf_Registro_R03(pl_ecf, pdh_inicial, pdh_final, ll_File, Ref lb_Evidenciado) Then

				If This.of_pafecf_Registro_R04(pl_ecf, pdh_inicial, pdh_final, ll_File, Ref lb_Evidenciado) Then
			
					If This.of_pafecf_Registro_R05(pl_ecf, pdh_inicial, pdh_final, ll_File, Ref lb_Evidenciado) Then
				
						If This.of_pafecf_Registro_R06(pl_ecf, pdh_inicial, pdh_final, ll_File, Ref lb_Evidenciado) Then
							
							If This.of_pafecf_Registro_R07(pl_ecf, pdh_inicial, pdh_final, ll_File, Ref lb_Evidenciado) Then
								
								If This.of_pafecf_Registro_J01(pdh_inicial, pdh_final, ll_File, Ref lb_Evidenciado) Then
	
									If This.of_pafecf_Registro_J02(pl_ecf, pdh_inicial, pdh_final, ll_File, Ref lb_Evidenciado) Then				
					
										lb_Sucesso = True
		
									End If
								End If
							End If
						End If
					End If
				End If
			End If
		End If
	End If
End If

This.of_grava_registro_temp_arquivo( ll_File )	

This.ids_Arquivo.Reset()

FileClose(ll_File)

If lb_Evidenciado Then
	lvs_Arquivo_Evidenciado = MidA(ps_Arquivo, 1, LenA(ps_Arquivo) - 4) + "_evid_" + String(Today(),"DDMMYYhhmmss") + ".txt"
	If This.of_Renomeia_Arquivo(ps_Arquivo, lvs_Arquivo_Evidenciado, True) Then	
		ps_Arquivo = lvs_Arquivo_Evidenciado
	Else
		lb_Sucesso = False
	End If
End If 

Return lb_Sucesso
end function

public function boolean of_inconsistencia_item_cancelado (long pl_nota, long pl_filial, long pl_produto);Decimal{2} lvdc_Unitario
Decimal{2} lvdc_Praticado

Long lvl_Quantidade
Long lvl_seq
Long lvl_ecf
long lvl_produto
long lvl_coo

String lvs_Cancelado
String lvs_Hash
String lvs_serie
String lvs_especie
String lvs_vl_unitario
String lvs_vl_praticado
String lvs_id
String lvs_data

If PDV.fabricante = "NFCE" Then  Return False  //PAF-NFC-e n$$HEX1$$e300$$ENDHEX$$o necessita a marca$$HEX2$$e700e300$$ENDHEX$$o.

Select	 nr_sequencial,
			COALESCE( TO_CHAR( dh_cancelamento, 'DD/MM/YYYY HH24:MI:SS' ), '' ),
			nr_ecf,
			cd_produto,
			qt_cancelada,
			de_especie,	
			de_serie,
			id_cancelamento,
			nr_coo
	Into	:lvl_seq,
			:lvs_data,
			:lvl_ecf,
			:lvl_produto,
			:lvl_Quantidade,
			:lvs_especie,
			:lvs_serie,
			:lvs_id,
			:lvl_coo
	From log_cancelamento_fiscal n
  Where n.nr_nf		= :pl_Nota
	 And n.cd_filial 	= :pl_Filial
	 And n.cd_produto = :pl_Produto
	 And n.de_especie	= 'CF'
	 And n.de_serie	= 'ECF'
  Using SQLCa;
  
  Select	de_hash
	Into	:lvs_Hash
	From log_cancelamento_fiscal_paf p
  Where p.nr_nf		= :pl_Nota
	 And p.cd_produto = :pl_Produto
	 And p.de_especie	= 'CF'
	 And p.de_serie	= 'ECF'
  Using SQLCa;


If SQLCa.SQLCode = 0 Then	
	If Trim(lvs_Hash) <> "" And Not IsNull(lvs_Hash) Then
		If lvs_Hash <> gf_Captura_Hash(String(lvl_seq) + lvs_data + String(lvl_ecf) + String(lvl_produto) + String(lvl_Quantidade) +  String(pl_Nota) + lvs_especie + lvs_serie + lvs_id + String(lvl_coo)) Then
			Return True
		End If 
	Else
		lvs_Hash = gf_Captura_Hash(String(lvl_seq) + lvs_data + String(lvl_ecf) + String(lvl_produto) + String(lvl_Quantidade) +  String(pl_Nota) + lvs_especie + lvs_serie + lvs_id + String(lvl_coo))
		 
		Update log_cancelamento_fiscal_paf
			Set de_hash = :lvs_hash
		  Where nr_sequencial = :lvl_seq
		 Using SQLCa;
		 
		If SQLCa.SQLCode <> -1 Then	
			SQLCa.of_Commit()
		End If		
	End If
End If

If SQLCa.SQLCode = 100 Then	
	Update log_cancelamento_fiscal
		Set nr_nf = nr_nf
	  Where nr_sequencial = :lvl_seq
	 Using SQLCa;

	If SQLCa.SQLCode <> -1 Then	
		SQLCa.of_Commit()
	End If		
End If

  
Return False
end function

public function boolean of_inconsistencia_aliquota_ecf (long pl_mapa, long pl_filial, long pl_ecf);
DateTime lvdh_Movimento

String lvs_Hash
String lvs_data
String lvs_especie
String lvs_serie
String lvs_base, lvs_icms, lvs_aliquota

Long ll_filial, ll_mapa, ll_ecf

Decimal {2} ldc_base, ldc_icms, ldc_aliquota

Select	 cd_filial,
		 nr_mapa,
		de_especie,
		de_serie,
		nr_ecf,
		pc_aliquota,
		vl_base_calculo,
		vl_icms		
	Into 	:ll_filial,
			:ll_mapa,			
			:lvs_especie,
		 	:lvs_serie,
			:ll_ecf,
			:ldc_aliquota,
			:ldc_base,
			:ldc_icms
	From aliquota_mapa_resumo_ecf m
  Where m.nr_mapa		= :pl_Mapa
	 And m.cd_filial 	= :pl_Filial
	 And m.de_especie	= 'MR'
	 And m.de_serie	= '1'
	 And m.nr_ecf = :pl_ecf
  Using SQLCa;

Select	 	de_hash
	Into 	:lvs_Hash
	From aliquota_mapa_resumo_ecf_paf p
  Where p.nr_mapa		= :pl_Mapa
	 And p.cd_filial 	= :pl_Filial
	 And p.de_especie	= 'MR'
	 And p.de_serie	= '1'
	 And p.nr_ecf = :pl_ecf	 
  Using SQLCa;
  
lvs_base 	 = gf_valor_com_ponto(ldc_base)
lvs_icms = gf_valor_com_ponto(ldc_icms)  
lvs_aliquota = gf_valor_com_ponto(ldc_aliquota)  

If SQLCa.SQLCode = 0 Then	
	//nr_mapa + cd_filial + dh_movimentacao_caixa(ddmmyyyy)
	If Trim(lvs_Hash) <> "" And Not IsNull(lvs_Hash) Then
		If lvs_Hash <> gf_Captura_Hash(String(pl_filial) + String(pl_Mapa) + lvs_especie + lvs_serie + String(ll_ecf) + lvs_aliquota + lvs_base + lvs_icms) Then
			Return True
		End If 
	Else
		Update aliquota_mapa_resumo_ecf
			Set de_especie 		= de_especie
		  Where nr_mapa		= :pl_Mapa
			 And cd_filial 	= :pl_Filial
			 And de_especie	= 'MR'
			 And de_serie	= '1'
			 And nr_ecf = :pl_ecf
		 Using SQLCa;
		 
		If SQLCa.SQLCode <> -1 Then	
			SQLCa.of_Commit()
		End If		
	End If
End If

If SQLCa.SQLCode = 100 Then	
	Update aliquota_mapa_resumo_ecf
		Set de_especie 		= de_especie
	  Where nr_mapa		= :pl_Mapa
		 And cd_filial 	= :pl_Filial
		 And de_especie	= 'MR'
		 And de_serie	= '1'
		 And nr_ecf = :pl_ecf
	 Using SQLCa;
	 
	If SQLCa.SQLCode <> -1 Then	
		SQLCa.of_Commit()
	End If			
End If
  
Return False
end function

public function boolean of_inconsistencia_aliquota_ecf_produto (long pl_mapa, long pl_filial, long pl_ecf, decimal pdc_aliquota);
DateTime lvdh_Movimento

String lvs_Hash
String lvs_data
String lvs_especie
String lvs_serie
String lvs_base, lvs_icms, lvs_aliquota

Long ll_filial, ll_mapa, ll_ecf

Decimal {2} ldc_base, ldc_icms, ldc_aliquota

Select	 cd_filial,
		 nr_mapa,
		de_especie,
		de_serie,
		nr_ecf,
		pc_aliquota,
		vl_base_calculo,
		vl_icms		
	Into 	:ll_filial,
			:ll_mapa,			
			:lvs_especie,
		 	:lvs_serie,
			:ll_ecf,
			:ldc_aliquota,
			:ldc_base,
			:ldc_icms
	From aliquota_mapa_resumo_ecf m
  Where m.nr_mapa		= :pl_Mapa
	 And m.cd_filial 	= :pl_Filial
	 And m.de_especie	= 'MR'
	 And m.de_serie	= '1'
	 And m.nr_ecf = :pl_ecf
	 and m.pc_aliquota = :pdc_aliquota
  Using SQLCa;

Select	 	de_hash
	Into 	:lvs_Hash
	From aliquota_mapa_resumo_ecf_paf p
  Where p.nr_mapa		= :pl_Mapa
	 And p.cd_filial 	= :pl_Filial
	 And p.de_especie	= 'MR'
	 And p.de_serie	= '1'
	 And p.nr_ecf = :pl_ecf
	 And p.pc_aliquota = :pdc_aliquota
  Using SQLCa;
  
lvs_base 	 = gf_valor_com_ponto(ldc_base)
lvs_icms = gf_valor_com_ponto(ldc_icms)  
lvs_aliquota = gf_valor_com_ponto(ldc_aliquota)  

If SQLCa.SQLCode = 0 Then	
	//nr_mapa + cd_filial + dh_movimentacao_caixa(ddmmyyyy)
	If Trim(lvs_Hash) <> "" And Not IsNull(lvs_Hash) Then
		If lvs_Hash <> gf_Captura_Hash(String(pl_filial) + String(pl_Mapa) + lvs_especie + lvs_serie + String(ll_ecf) + lvs_aliquota + lvs_base + lvs_icms) Then
			Return True
		End If 
	Else
		Update aliquota_mapa_resumo_ecf
			Set de_especie 		= de_especie
		  Where nr_mapa		= :pl_Mapa
			 And cd_filial 	= :pl_Filial
			 And de_especie	= 'MR'
			 And de_serie	= '1'
			 And nr_ecf = :pl_ecf
		 	 And pc_aliquota = :pdc_aliquota
		 Using SQLCa;
		 
		If SQLCa.SQLCode <> -1 Then	
			SQLCa.of_Commit()
		End If		
	End If
End If

If SQLCa.SQLCode = 100 Then	
	Update aliquota_mapa_resumo_ecf
		Set de_especie 		= de_especie
	  Where nr_mapa		= :pl_Mapa
		 And cd_filial 	= :pl_Filial
		 And de_especie	= 'MR'
		 And de_serie	= '1'
		 And nr_ecf = :pl_ecf
	 	And pc_aliquota = :pdc_aliquota		 
	 Using SQLCa;
	 
	If SQLCa.SQLCode <> -1 Then	
		SQLCa.of_Commit()
	End If			
End If
  
Return False
end function

public function boolean of_pafecf_registro_j01 (date pdh_inicial, date pdh_final, long pl_arquivo, ref boolean pb_evidenciado);
Boolean 	lb_Sucesso = True

String 	ls_Registro
String   ls_Indice

Long 	 	ll_Row
Long     ll_Retorno

Decimal {2} ldc_Desconto

String ls_Modelo
String ls_Cancelado
String ls_nome_cliente

dc_uo_ds_base lds_nota

lds_nota = Create dc_uo_ds_base

If Not lds_nota.of_ChangeDataObject('dw_ge038_pafecf_nota_fiscal_j1') Then Return False

ll_Retorno = lds_nota.Retrieve(pdh_inicial,pdh_final)

If ll_Retorno <> -1 Then

	For ll_Row = 1 To lds_nota.RowCount()
			
		ldc_Desconto = lds_nota.object.vl_total_produtos[ll_row] - lds_nota.object.vl_total_nf[ll_row]
		
		ls_Registro = 'J1'
		
		ls_Registro += LeftA(gvo_parametro.nr_cgc + Space(14), 14)
	
		ls_Registro += String(lds_nota.object.dh_emissao[ll_row],'yyyymmdd')		
		
		ls_Registro += of_Formata_Valor_PafEcf(lds_nota.object.vl_total_produtos[ll_row],12,2)
		
		ls_Registro += of_Formata_Valor_PafEcf(ldc_Desconto,11,2)		
		
		ls_Registro += 'V'
		
		ls_Registro += FillA("0", 13)		
		
		ls_Registro += 'V'

		ls_Registro += of_Formata_Valor_PafEcf(lds_nota.object.vl_total_nf[ll_row],12,2)			

		If Not IsNull(lds_nota.object.dh_cancelamento[ll_row]) Then
//			If IsDate(lds_nota.object.dh_cancelamento[ll_row]) Then
				ls_Registro += 'S'
//			Else	
//				ls_Registro += 'N'
//			End If
		Else
			ls_Registro += 'N'
		End If
		
		ls_Registro += FillA("0", 13)		
		
		ls_Registro += 'D'
			
		If Not IsNull(lds_nota.object.nm_cliente[ll_row]) Or Trim(lds_nota.object.nm_cliente[ll_row]) <> "" Then
			ls_nome_cliente = LeftA(lds_nota.object.nm_cliente[ll_row] + Space(40), 40)		
		Else		
			ls_nome_cliente = Space(40)			
		End If
			
		ls_Registro += ls_nome_cliente

		If Not IsNull(lds_nota.object.nr_cpf_cgc[ll_row]) Or Trim(String(lds_nota.object.nr_cpf_cgc[ll_row])) <> "" Then
			ls_Registro += RightA('00000000000000' + lds_nota.object.nr_cpf_cgc[ll_row], 14)
		Else		
			ls_Registro += FillA("0", 14)
		End If
	
		ls_Registro += String(lds_nota.object.nr_nf[ll_row],'0000000000')
		
		ls_Registro += LeftA(lds_nota.object.de_serie[ll_row] + Space(3), 3)				
			
		If Not IsNull(lds_nota.object.de_chave_acesso[ll_row]) Or Trim(String(lds_nota.object.de_chave_acesso[ll_row])) <> "" Then
			ls_Registro += LeftA(lds_nota.object.de_chave_acesso[ll_row] + Space(44), 44)
			If of_inconsistencia_filial(gvo_Parametro.of_Filial()) Then				
				ls_Registro += '?2'				
				pb_evidenciado = True		
			ElseIf of_inconsistencia_nf_venda(lds_nota.object.nr_nf[ll_row], gvo_Parametro.of_Filial(), lds_nota.object.de_especie[ll_row], lds_nota.object.de_serie[ll_row], False) Then
				ls_Registro += '?2'				
				pb_evidenciado = True		
			ElseIf of_inconsistencia_nfe(lds_nota.object.nr_nf[ll_row], gvo_Parametro.of_Filial(), lds_nota.object.de_especie[ll_row], lds_nota.object.de_serie[ll_row], False) Then
				ls_Registro += '?2'				
				pb_evidenciado = True		
			Else
				ls_Registro += '02'
			End If
		Else
			ls_Registro += FillA("0", 44)
			If of_inconsistencia_filial(gvo_Parametro.of_Filial()) Then				
				ls_Registro += '?1'				
				pb_evidenciado = True		
			ElseIf of_inconsistencia_nf_venda(lds_nota.object.nr_nf[ll_row], gvo_Parametro.of_Filial(), lds_nota.object.de_especie[ll_row], lds_nota.object.de_serie[ll_row], False) Then
				ls_Registro += '?1'				
				pb_evidenciado = True		
			ElseIf of_inconsistencia_nfe(lds_nota.object.nr_nf[ll_row], gvo_Parametro.of_Filial(), lds_nota.object.de_especie[ll_row], lds_nota.object.de_serie[ll_row], False) Then
				ls_Registro += '?1'				
				pb_evidenciado = True		
			Else
				ls_Registro += '01'
			End If			
		End If
				
		If Not This.of_grava_registro_temp( 'J1', String(lds_nota.object.dh_emissao[ll_row],'yyyymmdd'),'','', ls_Registro ) Then
			lb_Sucesso = False
		End If
		
		ls_Registro = ''
		
		If Not lb_Sucesso Then Exit
		
	Next
	
Else
	lb_Sucesso = False
	
End If	

Destroy(lds_nota)

Return lb_Sucesso
end function

public function boolean of_pafecf_registro_j02 (long pl_ecf, date pdh_inicial, date pdh_final, long pl_arquivo, ref boolean pb_evidenciado);
Boolean 	lb_Sucesso = True

String 	ls_Registro
String   ls_Tributacao
String   ls_produto

Long 	 	ll_Row
Long		ll_row2
Long     ll_Retorno
Long 		ll_Item
Long     ll_Doc_Anterior
Long ll_filial
Long ll_nota
Long ll_mapa
Long ll_ecf
String ls_serie
String ls_especie
long ll_produto
long ll_natureza
string ls_sit_trib

Decimal {2} ldc_Desconto, ldc_icms
 
String ls_Modelo

Date ldt_emissao

dc_uo_ds_base lds_Item

lds_Item = Create dc_uo_ds_base

If Not lds_Item.of_ChangeDataObject('dw_ge038_pafecf_item_nota_fiscal_j2') Then Return False

ll_Retorno = lds_Item.Retrieve(gvo_parametro.cd_filial,pdh_inicial,pdh_final)

If ll_Retorno <> -1 Then

	For ll_Row = 1 To lds_Item.RowCount()		
		
		If ll_Doc_Anterior <> lds_Item.object.nr_nf[ll_row] Then
			ll_Doc_Anterior = lds_Item.object.nr_nf[ll_row]
			ll_Item = 1
		End If
		
		ldc_icms = lds_Item.object.pc_icms[ll_row]
		//ll_ecf	= lds_Item.object.nr_ecf[ll_row]		
		ldt_emissao = Date(lds_Item.object.dh_emissao[ll_row])
		
		Select nr_mapa 
			into :ll_mapa		
		from mapa_resumo where 
			dh_emissao = :ldt_emissao
		Using sqlca;		
		
		
		ll_filial = lds_Item.object.cd_filial[ll_row]
		ll_nota = lds_Item.object.nr_nf[ll_row]
		ls_especie = lds_Item.object.de_especie[ll_row]
		ls_serie	= lds_Item.object.de_serie[ll_row]
		
		ldc_Desconto = lds_Item.object.vl_preco_unitario[ll_row] - lds_Item.object.vl_preco_praticado[ll_row]
					
		ls_Registro = 'J2'
		
		ls_Registro += LeftA(gvo_parametro.nr_cgc + Space(14), 14)
		
		ls_Registro += String(lds_item.object.dh_emissao[ll_row],'yyyymmdd')		
		
		ls_Registro += String(lds_item.object.nr_sequencial[ll_row],'000')
		
		ls_Registro += LeftA(String(lds_Item.object.cd_produto[ll_row]) + Space(14) , 14 )
		
		ls_produto = Space(100)
		
		ls_Registro += LeftA(lds_Item.object.de_produto[ll_row] + ls_produto, 100)
			
		ls_Registro += String(lds_Item.object.qt_vendida[ll_row],'0000000')		
		
		ls_Registro += LeftA(lds_Item.object.cd_un[ll_row] + Space(3) ,3)

		ls_Registro += of_Formata_Valor_PafEcf(lds_Item.object.vl_preco_unitario[ll_row],6,2)		

		ls_Registro += of_Formata_Valor_PafEcf(ldc_Desconto,6,2)		

		ls_Registro += FillA("0", 8)		
		
		ls_Registro += of_Formata_Valor_PafEcf(lds_Item.object.vl_preco_praticado[ll_row],12,2)

		Choose Case lds_Item.object.pc_icms[ll_row]
			Case 7    ; ls_Tributacao = "01T0700"
			Case 12   ; ls_Tributacao = "02T1200"
			Case 25   ; ls_Tributacao = "03T2500"		
			Case 17   ; ls_Tributacao = "04T1700"
			Case 18	 ; ls_Tributacao = "05T1800"
			Case Else 
				If lds_Item.object.cd_situacao_tributaria[ll_row] = '06' Then
					ls_Tributacao = "F1     "
				Else
					ls_Tributacao = "I1     "
				End If
		End Choose	
		ls_Registro += ls_Tributacao		

		ls_Registro += '0'
		
		ls_Registro += '2'
		
		ls_Registro += String(ll_nota,'0000000000')	
		
		ls_Registro += LeftA(ls_serie + Space(3), 3)		

		If Not IsNull(lds_item.object.de_chave_acesso[ll_row]) Or Trim(String(lds_item.object.de_chave_acesso[ll_row])) <> "" Then
			ls_Registro += LeftA(lds_item.object.de_chave_acesso[ll_row] + Space(44), 44)						
			If of_inconsistencia_filial(gvo_Parametro.of_Filial()) Then
				ls_Registro += '?2'
				pb_evidenciado = True		
			ElseIf of_inconsistencia_nf_venda(lds_Item.object.nr_nf[ll_row], gvo_Parametro.of_Filial(), ls_especie, ls_serie, False) Then
				ls_Registro += '?2'
				pb_evidenciado = True		
			ElseIf of_inconsistencia_nfe(lds_Item.object.nr_nf[ll_row], gvo_Parametro.of_Filial(), ls_especie, ls_serie, False) Then
				ls_Registro += '?2'
				pb_evidenciado = True		
			ElseIf of_inconsistencia_item_nf_venda(lds_Item.object.nr_nf[ll_row], gvo_Parametro.of_Filial(), lds_Item.object.cd_produto[ll_row], ls_especie, ls_serie) Then
				ls_Registro += '?2'
				pb_evidenciado = True		
			ElseIf of_inconsistencia_produto_geral(lds_Item.object.cd_produto[ll_row]) Then
				ls_Registro += '?2'
				pb_evidenciado = True		
			Else
				ls_Registro += '02'
			End If			
		Else
			ls_Registro += FillA("0", 44)
			If of_inconsistencia_filial(gvo_Parametro.of_Filial()) Then
				ls_Registro += '?1'
				pb_evidenciado = True		
			ElseIf of_inconsistencia_nf_venda(lds_Item.object.nr_nf[ll_row], gvo_Parametro.of_Filial(), ls_especie, ls_serie, False) Then
				ls_Registro += '?1'
				pb_evidenciado = True		
			ElseIf of_inconsistencia_nfe(lds_Item.object.nr_nf[ll_row], gvo_Parametro.of_Filial(), ls_especie, ls_serie, False) Then
				ls_Registro += '?1'
				pb_evidenciado = True		
			ElseIf of_inconsistencia_item_nf_venda(lds_Item.object.nr_nf[ll_row], gvo_Parametro.of_Filial(), lds_Item.object.cd_produto[ll_row], ls_especie, ls_serie) Then
				ls_Registro += '?1'
				pb_evidenciado = True		
			ElseIf of_inconsistencia_produto_geral(lds_Item.object.cd_produto[ll_row]) Then
				ls_Registro += '?1'
				pb_evidenciado = True		
			Else
				ls_Registro += '01'
			End If
		End If
				
		If Not This.of_grava_registro_temp( 'J2', String(lds_item.object.dh_emissao[ll_row],'yyyymmdd'),'','', ls_Registro ) Then
			lb_Sucesso = False
		End If
		
		ls_Registro = ''
		
		If Not lb_Sucesso Then Exit
		
		ll_Item ++
		
		
//		//Itens cancelados
//		dc_uo_ds_base lds_Item_cancelado		
//		lds_Item_cancelado = Create dc_uo_ds_base
//		
//		If Not lds_Item_cancelado.of_ChangeDataObject('dw_ge038_pafecf_produto_cupom_fiscal_cancelado') Then Return False
//		
//		ll_Retorno = lds_Item_cancelado.Retrieve(ll_filial, ll_nota, ls_especie, ls_serie)
//		
//		If ll_Retorno <> -1 Then
//			
//			For ll_Row2 = 1 To lds_Item_cancelado.RowCount()				
//				
//				ll_produto = lds_Item_cancelado.object.cd_produto[ll_row2]
//				
//				uo_produto             			lvo_produto
//				lvo_produto = Create uo_produto
//				
//				lvo_produto.of_localiza_codigo_interno(ll_produto)			
//				
//				UO_TRATAMENTO_FISCAL             			lvo_tratamento_fiscal
//				If IsValid(lvo_tratamento_fiscal) Then Destroy lvo_tratamento_fiscal
//				lvo_tratamento_fiscal = CREATE UO_TRATAMENTO_FISCAL
//				lvo_tratamento_fiscal.of_grava_contribuinte(FALSE)
//				lvo_tratamento_fiscal.of_grava_uf_origem_destino(gvo_parametro.ivs_uf_filial,gvo_parametro.ivs_uf_filial)
//				lvo_tratamento_fiscal.of_grava_operacao(lvo_tratamento_fiscal.VENDA)
//				lvo_tratamento_fiscal.of_grava_tipo_venda('AV')	
//				
//				UO_ATRIBUTO_FISCAL_ITEM_NF  					lvo_atributo
//				lvo_atributo = Create UO_ATRIBUTO_FISCAL_ITEM_NF	
//				
//				lvo_atributo = lvo_tratamento_fiscal.of_atributo_fiscal_produto(lvo_produto)
//
////				If Not lvo_atributo.Localizado Then
////				End If
//				
//				ll_natureza = lvo_atributo.cd_natureza_operacao
//				ls_sit_trib = lvo_atributo.cd_situacao_tributaria
//				ldc_icms = lvo_atributo.pc_icms						
//					
//				ldc_Desconto = lds_Item_cancelado.object.vl_preco_bruto[ll_row2] - lds_Item_cancelado.object.vl_preco_praticado[ll_row2]
//							
//				ls_Registro = 'R05'
//				
//				ls_Registro += LeftA(This.nr_Serie + Space(20), 20)
//			
//				ls_Registro += LeftA(This.id_MfAdicional, 1)
//				
//				// Acerto para inserir ? nos espa$$HEX1$$e700$$ENDHEX$$os em branco dos registros alterados
//				ls_Modelo = Space(20)
//				
//				//Verifica se h$$HEX1$$e100$$ENDHEX$$ altera$$HEX2$$e700e300$$ENDHEX$$o nos dados da ECF
//				If of_inconsistencia_impressora_fiscal(pl_ecf) Then
//					ls_Modelo = FillA("?", 20)
//					ls_Registro += gf_Replace(LeftA( This.de_Modelo + ls_Modelo , 20 ), " ", "?", 0)			
//					pb_evidenciado = True	
//				ElseIf of_inconsistencia_nf_venda(lds_Item_cancelado.object.nr_nf[ll_row2], gvo_Parametro.of_Filial(), False) Then
//					ls_Modelo = FillA("?", 20)
//					ls_Registro += gf_Replace(LeftA( This.de_Modelo + ls_Modelo , 20 ), " ", "?", 0)	
//					pb_evidenciado = True			
//				ElseIf of_inconsistencia_item_cancelado(lds_Item_cancelado.object.nr_nf[ll_row2], gvo_Parametro.of_Filial(), lds_Item_cancelado.object.cd_produto[ll_row2]) Then
//					ls_Modelo = FillA("?", 20)
//					ls_Registro += gf_Replace(LeftA( This.de_Modelo + ls_Modelo , 20 ), " ", "?", 0)	
//					pb_evidenciado = True			
//				ElseIf of_inconsistencia_produto_geral(lds_Item_cancelado.object.cd_produto[ll_row2]) Then
//					ls_Modelo = FillA("?", 20)
//					ls_Registro += gf_Replace(LeftA( This.de_Modelo + ls_Modelo , 20 ), " ", "?", 0)	
//					pb_evidenciado = True			
//				Else
//					ls_Registro += LeftA( This.de_Modelo + ls_Modelo , 20 )
//				End If
//				
//				ls_Registro += '01'
//				
//				ls_Registro += String(lds_Item_cancelado.object.nr_operacao_ecf[ll_row2],'000000000')
//				
//				ls_Registro += String(lds_Item_cancelado.object.nr_ccf[ll_row2],'000000000')		
//						
//				ls_Registro += String(ll_Item,'000')
//				
//				ls_Registro += LeftA(String(lds_Item_cancelado.object.cd_produto[ll_row2]) + Space(14) , 14 )		
//			
//				ls_Registro += LeftA(lds_Item_cancelado.object.de_produto[ll_row2] + Space(100),100)	
//				
//				ls_Registro += String(lds_Item_cancelado.object.qt_cancelada[ll_row2],'0000000')
//				
//				ls_Registro += LeftA(lds_Item_cancelado.object.cd_un[ll_row2] + Space(3) ,3)
//				
//				ls_Registro += of_Formata_Valor_PafEcf(lds_Item_cancelado.object.vl_preco_bruto[ll_row2],6,2)
//				
//				ls_Registro += of_Formata_Valor_PafEcf(ldc_Desconto,6,2)
//				
//				ls_Registro += FillA("0", 8)
//				
//				ls_Registro += of_Formata_Valor_PafEcf(lds_Item_cancelado.object.vl_preco_praticado[ll_row2],12,2)
//				
//				Choose Case long(ldc_icms)
//					Case 7    ; ls_Tributacao = "01T0700"
//					Case 12   ; ls_Tributacao = "02T1200"
//					Case 25   ; ls_Tributacao = "03T2500"		
//					Case 17   ; ls_Tributacao = "04T1700"
//					Case 18	 ; ls_Tributacao = "05T1800"
//					Case Else 
//						If ls_sit_trib = '06' Then
//							ls_Tributacao = "F1     "
//						Else
//							ls_Tributacao = "I1     "
//						End If
//				End Choose
//			
//				ls_Registro += ls_Tributacao
//				
//				ls_Registro += 'S'
//				
//				ls_Registro += FillA("0", 7)
//				
//				ls_Registro += FillA("0", 13)
//				
//				ls_Registro += FillA("0", 13)
//				
//				ls_Registro += 'A'
//				
//				ls_Registro += 'T'
//				
//				ls_Registro += '0'
//				
//				ls_Registro += '2'
//										
//				//If FileWrite(pl_arquivo,ls_Registro) = -1 Then lb_Sucesso = False
//				
//				If Not This.of_grava_registro_temp( 'R05', '', '', '', ls_Registro ) Then
//					lb_Sucesso = False
//				End If
//				
//				ls_Registro = ''
//				
//				If Not lb_Sucesso Then Exit
//				
//				ll_Item ++
//			Next
//		End If		// fim cancelados
		
		
	Next
	

	
	
Else
	lb_Sucesso = False
	
End If

Destroy(lds_Item)

Return lb_Sucesso
end function

public function boolean of_gera_blocox_estoque (long pl_mes, long pl_ano, ref string ps_recibo, ref string ps_situacao);String ls_Registro, &
		 ls_ins_est, &
		 ls_cst_trib, &
		 ls_icms, &
		 ls_nome_arquivo, &
		 ls_data_estoque, &		 
		 ls_IAT = 'true', &
		 ls_IPPT = 'Terceiros', &
		 ls_situacao, &
		 ls_retorno, &
		 ls_arquivo, &
		 ls_xml_estoque, &
		 ls_codigo, &
		 ls_mensagem, &
		 ls_arquivo_retorno, &
		 ls_versao, &
		 ls_recibo, &
		 ls_cest, &
		 ls_ncm, &
		 ls_error, &
		 ls_situacao_ws
		 
Long 	ll_retorno, &
		ll_row, &
		ll_produto, &
		ll_qtd, &
		ll_FileNum, &
		ll_Bytes, &
		ll_qtd_aq
		
Decimal {2} lvdc_venda_bruta, &
				lvdc_icms, &
				lvdc_aquisicao

Date ldt_estoque, &
	   ldt_ultimo_dia		

Boolean lb_sucesso, &
		   lb_enviar = True

//cria diretorios blocoX

dc_uo_api lo_api
lo_api = Create dc_uo_api

lo_api.of_create_directory('C:\Sistemas\CL\Arquivos\PAF-ECF\Recibos - Bloco X')
lo_api.of_create_directory('C:\Sistemas\CL\Arquivos\PAF-ECF\Arquivos - Estoque Mensal')

Destroy(lo_api)

//Goto Teste

Select nr_versao
  Into :ls_Versao
  From sistema
 Where cd_sistema = 'CL'
 Using SQLCa;

If SQLCa.SQLCode = -1 Then
	SQLCa.Of_MsgDBError("Erro ao localizar a vers$$HEX1$$e300$$ENDHEX$$o do sistema.")
	Return False
End If

ls_Arquivo	= is_Caminho_Arquivo_Xml+'Arquivos - Estoque Mensal\' + 'Estoque ' + String(pl_mes,'00') + String(pl_ano) + '.xml'
ls_nome_arquivo = 'Estoque ' + String(pl_mes,'00') + String(pl_ano)
If Not FileExists( ls_Arquivo ) Then  // N$$HEX1$$e300$$ENDHEX$$o existe no PDV, vai criar o xml
	ls_data_estoque 	= String(pl_ano) +'/'+ String(pl_mes,'00') +'/'+ '01'
	ldt_estoque			= Date(ls_data_estoque)
	ldt_ultimo_dia		= gf_retorna_ultimo_dia_mes(ldt_estoque)
	
	ls_ins_est			= gf_replace(gvo_parametro.nr_inscricao_estadual, '.', '', 0)
	ls_ins_est			= gf_replace(ls_ins_est, '/', '', 0)
	ls_ins_est			= gf_replace(ls_ins_est, '-', '', 0)
	
	//cabe$$HEX1$$e700$$ENDHEX$$aho, dados da loja e sistema
	ls_Registro = '<?xml version="1.0" encoding="UTF-8"?>' + ivs_Enter 							+ &
						'<Estoque Versao="1.0">' + ivs_Enter 												+ &
						This.of_Abre_Tag('Mensagem', 1)														+ &					
						This.of_Abre_Tag('Estabelecimento', 2)												+ &
						This.of_Elemento('Ie', ls_ins_est, 3)													+ &
						This.of_Fecha_tag('Estabelecimento', 2)												+ &					
						This.of_Abre_Tag('PafEcf', 2)															+ &
						This.of_Elemento('NumeroCredenciamento', is_numero_credenciamento, 3)+ &
						This.of_Fecha_tag('PafEcf', 2)
	
	//Dados do movimento
	ls_Registro += This.of_Abre_Tag('DadosEstoque', 2)	+ &
						This.of_Elemento('DataReferencia', String(ldt_ultimo_dia,'yyyy-mm-dd'), 3)	+ &
						This.of_Abre_Tag('Produtos', 3)
	
	//Dados Produtos
	dc_uo_ds_base lds_Produtos
	lds_Produtos  = Create dc_uo_ds_base
	
	If Not lds_Produtos.of_ChangeDataObject('ds_ge038_pafecf_estoque_blocox') Then Return False
	
	ll_Retorno = lds_Produtos.Retrieve(ldt_estoque, ldt_ultimo_dia)
	
	If ll_Retorno <> -1 Then
		
		If lds_Produtos.RowCount() = 0 Then
			//sem dados de reducaoZ
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o",'Sem produtos para gerar o arquivo.')
			Return False
		End If
		
		uo_Produto lvo_Produto
		lvo_Produto = Create uo_Produto
		
		uo_Tratamento_Fiscal	lvo_tratamento_fiscal
		lvo_tratamento_fiscal = Create uo_Tratamento_Fiscal	
		
		lvo_tratamento_fiscal.of_grava_contribuinte(FALSE)
		lvo_tratamento_fiscal.of_grava_uf_origem_destino(gvo_parametro.ivs_uf_filial,gvo_parametro.ivs_uf_filial)
		lvo_tratamento_fiscal.of_grava_operacao(lvo_tratamento_fiscal.VENDA)		
	
		uo_Atributo_Fiscal_Item_Nf	lvo_atributo
		lvo_atributo = Create uo_Atributo_Fiscal_Item_Nf	
		
		For ll_row = 1 To lds_Produtos.RowCount()
			ls_icms = ''
			ll_produto = lds_produtos.Object.Cd_Produto[ll_row]		
			lvo_Produto.of_Localiza_Codigo_Interno(ll_Produto)
			
			// Carrega os atributos fiscais 
			lvo_atributo = lvo_tratamento_fiscal.of_atributo_fiscal_produto(lvo_Produto)
			
			If lvo_Produto.Localizado Then
				lvdc_venda_bruta = lvo_Produto.of_Preco_Venda_Filial()			
				Choose Case lvo_atributo.cd_situacao_tributaria
					Case '00'
						ls_cst_trib = 'Tributado pelo ICMS'
						lvdc_icms = lvo_atributo.Pc_ICMS
						ls_icms = String(lvdc_icms,'##0.00')
					Case '04'
						ls_cst_trib = 'Isento'
					Case else
						ls_cst_trib = 'Substituicao tributaria'
				End Choose 			
			End If
			
			If lds_Produtos.object.qt_saldo_final[ll_row] >= 0 Then
				ls_situacao = 'Positivo'
			Else
				ls_situacao = 'Negativo'
			End If	
			ll_qtd = Abs(lds_Produtos.object.qt_saldo_final[ll_row])
			If IsNull(lds_Produtos.Object.qt_aquisicao[ll_Row]) Then	
				ll_qtd_aq = 0
			Else
				If Abs(lds_Produtos.object.qt_aquisicao[ll_row]) < 0 Then
					ll_qtd_aq = 0
				Else
					ll_qtd_aq = Abs(lds_Produtos.object.qt_aquisicao[ll_row])				
				End If
			End If			
			
			If IsNull(lds_Produtos.Object.cd_cest[ll_Row]) Or Trim(lds_Produtos.Object.cd_cest[ll_Row]) = '' Then
				ls_cest = '0000000'
			Else
				ls_cest = lds_Produtos.Object.cd_cest[ll_Row]
			End If			
			If IsNull(String(lds_Produtos.Object.nr_classificacao_fiscal[ll_Row],'00000000')) Then	
				ls_ncm = '00000000'
			Else
				ls_ncm = String(lds_Produtos.Object.nr_classificacao_fiscal[ll_Row],'00000000')
			End If
			
			If ll_qtd_aq <= 0 Then
				lvdc_aquisicao = 0				
			Else
				lvdc_aquisicao = (lds_Produtos.Object.vl_preco_reposicao[ll_Row] / lds_Produtos.Object.vl_fator_conversao[ll_Row]) * ll_qtd_aq
			End If			
		
			ls_Registro += 	This.of_Abre_Tag('Produto', 4)																+ &
								This.of_Elemento('Descricao', lds_Produtos.object.descricao[ll_row], 5)			+ &
								This.of_Elemento('CodigoGTIN', lds_Produtos.object.de_codigo_barras[ll_row], 5)+ &
								This.of_Elemento('CodigoCEST', ls_cest, 5)+ &
								This.of_Elemento('CodigoNCMSH', ls_ncm, 5)+ &																
								This.of_Elemento('CodigoProprio', String(ll_produto), 5)								+ &				
								This.of_Elemento('Quantidade', String(Real(ll_qtd),'#####0.000'), 5) 			+ &
								This.of_Elemento('QuantidadeTotalAquisicao', String(Real(ll_qtd_aq),'#####0.000'), 5)+ &								
								This.of_Elemento('Unidade', lds_Produtos.object.cd_um[ll_row], 5)				+ &
								This.of_Elemento('ValorUnitario', String(lvdc_venda_bruta,'#####0.000'), 5)	+ &
								This.of_Elemento('ValorTotalAquisicao', String(lvdc_aquisicao,'#####0.00'), 5)+ &
								This.of_Elemento('ValorTotalICMSDebitoFornecedor', String(0,'#####0.00'), 5)+ &																
								This.of_Elemento('ValorBaseCalculoICMSST', String(0,'#####0.00'), 5)	    		+ &
								This.of_Elemento('ValorTotalICMSST', String(0,'#####0.00'), 5)	    				+ &								
								This.of_Elemento('SituacaoTributaria', ls_cst_trib, 5)									+ &
								This.of_Elemento('Aliquota', ls_icms, 5)													+ &
								This.of_Elemento('IsArredondado', ls_IAT, 5)											+ &
								This.of_Elemento('Ippt', ls_IPPT, 5)														+ &
								This.of_Elemento('SituacaoEstoque', ls_situacao, 5)									+ &							
								This.of_Fecha_Tag('Produto', 4)
	
		Next
		
		Destroy(lvo_produto)
		Destroy(lvo_tratamento_fiscal)
		Destroy(lvo_atributo)
							
	Else
		//Erro ao buscar dados dos produtos
		Return False				
	End If
		
	ls_Registro += 	This.of_Fecha_Tag('Produtos', 3)	+ &
						This.of_Fecha_Tag('DadosEstoque', 2)	+ &
						This.of_Fecha_tag('Mensagem'	, 1) 				
	
	//ASSINATURA
	ls_Registro += This.of_Abre_Tag('Signature xmlns="http://www.w3.org/2000/09/xmldsig#"',1)  + &
						This.of_Abre_Tag('SignedInfo', 2)	+ &
						This.of_Abre_Tag('CanonicalizationMethod Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315"',3) + &
						This.of_Fecha_Tag('CanonicalizationMethod',3) +&
						This.of_Abre_Tag('SignatureMethod Algorithm="http://www.w3.org/2000/09/xmldsig#rsa-sha1"', 3) + &					
						This.of_Fecha_Tag('SignatureMethod',3) +&
						This.of_Abre_Tag('Reference URI=""', 3)	+ &
						This.of_Abre_Tag('Transforms', 4)	+ &
						This.of_Abre_Tag('Transform Algorithm="http://www.w3.org/2000/09/xmldsig#enveloped-signature"', 5)	+ &
						This.of_Fecha_Tag('Transform',5) +&
						This.of_Abre_Tag('Transform Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315"', 5)	+ &
						This.of_Fecha_Tag('Transform',5) +&			
						This.of_Fecha_Tag('Transforms',4) +&
						This.of_Abre_Tag('DigestMethod Algorithm="http://www.w3.org/2000/09/xmldsig#sha1"', 4)	+ &
						This.of_Fecha_Tag('DigestMethod',4) +&
						This.of_Elemento('DigestValue', '', 4)		+ &
						This.of_Fecha_Tag('Reference',3) +&
						This.of_Fecha_Tag('SignedInfo',2) +&										
						This.of_Elemento('SignatureValue', '', 1)	+ &
						This.of_Abre_Tag('KeyInfo', 2)	+ &
						This.of_Abre_Tag('X509Data',3) + &
						This.of_Elemento('X509Certificate', '', 4)		+ &					
						This.of_Fecha_Tag('X509Data',3) +&					
						This.of_Fecha_Tag('KeyInfo',2) +&										
						This.of_Fecha_Tag('Signature', 1)+ &
												 '</Estoque>'	
	
	ivs_Arquivo_Xml = is_Caminho_Arquivo_Xml+'Arquivos - Estoque Mensal\' + 'Estoque ' + String(pl_mes,'00') + String(pl_ano) + '_ORI.xml'
			 
	This.of_abre_arquivo()
	
	This.of_Grava_Arquivo(ls_Registro)
	
	FileClose(ivi_Arquivo_Xml)
	
	Destroy(lds_Produtos)
	
	ll_retorno = Assinaxml_GeraAssinatura(ls_nome_arquivo, ivs_Arquivo_Xml, is_Caminho_Arquivo_Xml+'Arquivos - Estoque Mensal\')
	
	//Teste:
	If ll_retorno = 1 Then
		lb_enviar = True
	Else
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Problemas ao assinar o XML de Estoque.", Exclamation! )
		lb_enviar = False
	End If
	
	FileDelete(ivs_Arquivo_Xml)				
End If

If lb_enviar Then
	
	dc_uo_zip lo_Zip
	lo_Zip = Create dc_uo_zip
	
	lo_Zip.of_Salva_Estrutura( False )
	ls_Error = lo_Zip.of_Zip( ls_Arquivo, ls_arquivo + '.zip' )
		
	If ls_Error <> "" Then
		MessageBox( 'Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao tentar compactar arquivo ' + ls_Arquivo + '~r~r' + ls_Error, StopSign! )
		lb_enviar = False
	Else
		ls_arquivo = ls_arquivo + '.zip'
	End If

	Destroy(lo_Zip)	

	If lb_enviar Then	
		uo_ge038_ws lo_WS
		lo_WS = Create uo_ge038_ws
		
		If lo_WS.of_enviar( ls_Arquivo, ref ls_Retorno ) Then
			If lo_WS.of_Trata_Retorno_Geral( ls_Retorno ) > 0 Then
				lo_WS.of_Valor_Retornado( Lower( ls_Retorno ), 'situacaoprocessamentocodigo'		, ref ls_codigo )
				lo_WS.of_Valor_Retornado( Lower( ls_Retorno ), 'situacaoprocessamentodescricao'	, ref ls_situacao_ws )
				lo_WS.of_Valor_Retornado( Lower( ls_Retorno ), 'mensagem'	, ref ls_mensagem )				
				lo_WS.of_Valor_Retornado( Lower( ls_Retorno ), 'recibo'		, ref ls_recibo )			
							
				If ls_codigo = '1' or ls_codigo = '0' Then			
					ls_arquivo_retorno = is_Caminho_Arquivo_Xml+'RetornosX\' + ls_nome_arquivo + '_retorno.xml'								
					lo_WS.of_grava_retorno(ls_retorno, ls_arquivo_retorno)
					ps_recibo = ls_recibo
					ps_situacao = ls_codigo
					lb_sucesso = true	
					MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Arquivo "+ ls_nome_arquivo + " transmitido com sucesso.", Information! )					
				End If
				If ls_codigo = '2' Then //erro.
					MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no envio do XML de Estoque.~r~r" +&
									  "Codigo: " + ls_codigo + " Mensagem: " + ls_mensagem, Exclamation! )
					lb_sucesso = False
				End If			
	
			End If					
		Else
			lb_sucesso = False
		End If	
		Destroy(lo_WS)
	End If
	
End If

If lb_sucesso Then
	Return True
Else
	Return False
End If
end function

public function boolean of_inconsistencia_nf_venda (long pl_nota, long pl_filial, string ps_especie, string ps_serie, boolean pb_update);
Decimal{2} lvdc_Total, lvdc_total_bruto,lvdc_desconto

Long lvl_Coo
Long lvl_Ccf

String lvs_Cancelado
String lvs_Hash
String lvs_Pagamento
String lvs_serie
String lvs_especie
String lvs_valor
String lvs_valor_bruto
String lvs_cliente
String lvs_cpf
String lvs_desconto
String lvs_emissao

If PDV.fabricante = "NFCE" Then  Return False  //PAF-NFC-e n$$HEX1$$e300$$ENDHEX$$o necessita a marca$$HEX2$$e700e300$$ENDHEX$$o.

 Select	nr_operacao_ecf, 			
			vl_total_nf,
			id_cancelamento_impressora,
			nr_ccf,
			cd_forma_pagamento,
			de_especie,
			de_serie,
			COALESCE( TO_CHAR( dh_emissao, 'DD/MM/YYYY HH24:MI:SS' ), '' ),
			pc_desconto,
			vl_total_nf_bruto,
			cd_cliente,
			nr_cpf_cgc			
	Into	:lvl_Coo,
			:lvdc_Total,
			:lvs_Cancelado,
			:lvl_Ccf,
			:lvs_pagamento,
			:lvs_especie,
			:lvs_serie,
			:lvs_emissao,
			:lvdc_desconto,
			:lvdc_total_bruto,
			:lvs_cliente,
			:lvs_cpf			
	From nf_venda n
  Where n.nr_nf		= :pl_Nota
	 And n.cd_filial 	= :pl_Filial
	 And n.de_especie	= :ps_especie
	 And n.de_serie	= :ps_serie
  Using SQLCa;

 Select	de_hash
	Into	:lvs_Hash
	From nf_venda_paf p
  Where p.nr_nf		= :pl_Nota
	 And p.cd_filial 	= :pl_Filial
	 And p.de_especie	= :ps_especie
	 And p.de_serie	= :ps_serie
  Using SQLCa;

If IsNull(lvl_Ccf) Then
	lvl_Ccf = 0
End If

If IsNull(lvl_coo) Then
	lvl_coo = 0
End If

If IsNull(lvs_Cancelado) Then
	lvs_Cancelado = "N"
End If

If IsNull(lvs_pagamento) Then
	lvs_pagamento = ""
End If		

lvs_valor = gf_valor_com_ponto(lvdc_Total)

If IsNull(lvdc_desconto) Then
	lvs_desconto = '0'
Else
	lvs_desconto = gf_valor_com_ponto(lvdc_desconto)
End If	

If IsNull(lvdc_total_bruto) Then
	lvs_valor_bruto = "0"
Else
	lvs_valor_bruto = gf_valor_com_ponto(lvdc_total_bruto)
End If	

If IsNull(lvs_cliente) Then
	lvs_cliente = ""
End If	

If IsNull(lvs_cpf) Then
	lvs_cpf = ""
End If	

If SQLCa.SQLCode = 0 Then	
	If Trim(lvs_Hash) <> "" And Not IsNull(lvs_Hash) Then
		If lvs_Hash <> gf_Captura_Hash(String(pl_filial) + String(pl_Nota) + lvs_especie + lvs_serie + lvs_valor + String(lvl_Coo) + lvs_Cancelado + String(lvl_Ccf) + lvs_pagamento + lvs_emissao + lvs_valor_bruto + lvs_desconto + lvs_cliente + lvs_cpf) Then
			Return True	
		End If 
	Else
		Return True
	End If
End If
  
Return False
end function

public function boolean of_inconsistencia_nf_venda (long pl_nota, long pl_filial, string ps_especie, string ps_serie, boolean pb_update, ref string ps_cancelado);
Decimal{2} lvdc_Total, lvdc_total_bruto,lvdc_desconto

Long lvl_Coo
Long lvl_Ccf

String lvs_Cancelado
String lvs_Hash
String lvs_Pagamento
String lvs_serie
String lvs_especie
String lvs_valor
String lvs_valor_bruto
String lvs_cliente
String lvs_cpf
String lvs_desconto
String lvs_emissao

If PDV.fabricante = "NFCE" Then  Return False  //PAF-NFC-e n$$HEX1$$e300$$ENDHEX$$o necessita a marca$$HEX2$$e700e300$$ENDHEX$$o.

 Select	nr_operacao_ecf, 			
			vl_total_nf,
			id_cancelamento_impressora,
			nr_ccf,
			cd_forma_pagamento,
			de_especie,
			de_serie,
			COALESCE( TO_CHAR( dh_emissao, 'DD/MM/YYYY HH24:MI:SS' ), '' ),
			pc_desconto,
			vl_total_nf_bruto,
			cd_cliente,
			nr_cpf_cgc
	Into	:lvl_Coo,
			:lvdc_Total,
			:lvs_Cancelado,
			:lvl_Ccf,
			:lvs_pagamento,
			:lvs_especie,
			:lvs_serie,
			:lvs_emissao,
			:lvdc_desconto,
			:lvdc_total_bruto,
			:lvs_cliente,
			:lvs_cpf
	From nf_venda n
  Where n.nr_nf		= :pl_Nota
	 And n.cd_filial 	= :pl_Filial
	 And n.de_especie	= :ps_especie
	 And n.de_serie	= :ps_serie
  Using SQLCa;

 Select	de_hash
	Into	:lvs_Hash
	From nf_venda_paf p
  Where p.nr_nf		= :pl_Nota
	 And p.cd_filial 	= :pl_Filial
	 And p.de_especie	= :ps_especie
	 And p.de_serie	= :ps_serie
  Using SQLCa;

If IsNull(lvl_Ccf) Then
	lvl_Ccf = 0
End If

If IsNull(lvl_coo) Then
	lvl_coo = 0
End If

If IsNull(lvs_Cancelado) Or Trim(lvs_Cancelado) = "" Then
	lvs_Cancelado = "N"
End If

If IsNull(lvs_pagamento) Then
	lvs_pagamento = ""
End If	

ps_Cancelado = lvs_Cancelado

lvs_valor = gf_valor_com_ponto(lvdc_Total)

If IsNull(lvdc_desconto) Then
	lvs_desconto = '0'
Else
	lvs_desconto = gf_valor_com_ponto(lvdc_desconto)
End If	

If IsNull(lvdc_total_bruto) Then
	lvs_valor_bruto = "0"
Else
	lvs_valor_bruto = gf_valor_com_ponto(lvdc_total_bruto)
End If	

If IsNull(lvs_cliente) Then
	lvs_cliente = ""
End If	

If IsNull(lvs_cpf) Then
	lvs_cpf = ""
End If	

If SQLCa.SQLCode = 0 Then	
	If Trim(lvs_Hash) <> "" And Not IsNull(lvs_Hash) Then
		If lvs_Hash <> gf_Captura_Hash(String(pl_filial) + String(pl_Nota) + lvs_especie + lvs_serie + lvs_valor + String(lvl_Coo) + lvs_Cancelado + String(lvl_Ccf) + lvs_pagamento + lvs_emissao + lvs_valor_bruto + lvs_desconto + lvs_cliente + lvs_cpf) Then
			Return True	
		End If 
	Else
		Return True
	End If
End If
  
Return False
end function

public function boolean of_inconsistencia_item_nf_venda (long pl_nota, long pl_filial, long pl_produto, string ps_especie, string ps_serie);Decimal{2} lvdc_Unitario
Decimal{2} lvdc_Praticado

Long lvl_Quantidade
Long lvl_seq

String lvs_Cancelado
String lvs_Hash
String lvs_serie
String lvs_especie
String lvs_vl_unitario
String lvs_vl_praticado

If PDV.fabricante = "NFCE" Then  Return False  //PAF-NFC-e n$$HEX1$$e300$$ENDHEX$$o necessita a marca$$HEX2$$e700e300$$ENDHEX$$o.

Select	qt_vendida,
			vl_preco_unitario,
			vl_preco_praticado,
			id_cancelado,
			de_especie,
			de_serie,	
			nr_sequencial
	Into	:lvl_Quantidade,
			:lvdc_Unitario,
			:lvdc_Praticado,
			:lvs_Cancelado,
			:lvs_especie,
			:lvs_serie,
			:lvl_seq
	From item_nf_venda n
  Where n.nr_nf		= :pl_Nota
	 And n.cd_filial 	= :pl_Filial
	 And n.cd_produto = :pl_Produto
	 And n.de_especie	= :ps_especie
	 And n.de_serie	= :ps_serie
  Using SQLCa;
  
  Select	de_hash
	Into	:lvs_Hash
	From item_nf_venda_paf p
  Where p.nr_nf		= :pl_Nota
	 And p.cd_filial 	= :pl_Filial
	 And p.cd_produto = :pl_Produto
	 And p.de_especie	= :ps_especie
	 And p.de_serie	= :ps_serie
  Using SQLCa;

If IsNull(lvs_Cancelado) Then
	lvs_Cancelado = "N"
End If

lvs_vl_unitario 	 = gf_valor_com_ponto(lvdc_unitario)
lvs_vl_praticado = gf_valor_com_ponto(lvdc_praticado)

If SQLCa.SQLCode = 0 Then	
	//nr_nf + cd_filial + cd_produto + qt_vendida + vl_preco_unitario + vl_preco_praticado + id_cancelado		
	If Trim(lvs_Hash) <> "" And Not IsNull(lvs_Hash) Then
		If lvs_Hash <> gf_Captura_Hash(String(pl_filial) + String(pl_Nota) + lvs_especie + lvs_serie + String(lvl_seq) + String(pl_Produto) +  String(lvl_Quantidade) + lvs_vl_unitario + lvs_vl_praticado + lvs_Cancelado) Then
			Return True
		End If 
	Else
		lvs_Hash = gf_Captura_Hash(String(pl_filial) + String(pl_Nota) + lvs_especie + lvs_serie + String(lvl_seq) + String(pl_Produto) +  String(lvl_Quantidade) + lvs_vl_unitario + lvs_vl_praticado + lvs_Cancelado)
		 
		Update item_nf_venda_paf p
			Set de_hash 		= :lvs_Hash
		  Where p.cd_filial 	= :pl_Filial
			 And p.nr_nf		= :pl_Nota
			 And p.cd_produto = :pl_Produto
			 And p.de_especie	= 'CF'
			 And p.de_serie	= 'ECF'
		 Using SQLCa;
		 
		If SQLCa.SQLCode <> -1 Then	
			SQLCa.of_Commit()
		End If		
	End If
End If
  
Return False
end function

public function boolean of_inconsistencia_nfe (long pl_nota, long pl_filial, string ps_especie, string ps_serie, boolean pb_update);String lvs_chave
String lvs_Hash
String lvs_prot_envio
String lvs_prot_canc
String lvs_envio
String lvs_situacao

If PDV.fabricante = "NFCE" Then  Return False  //PAF-NFC-e n$$HEX1$$e300$$ENDHEX$$o necessita a marca$$HEX2$$e700e300$$ENDHEX$$o.

 Select	de_chave_acesso, 			
			nr_protocolo_envio,
			nr_protocolo_cancelamento,
			COALESCE( TO_CHAR( dh_envio, 'DD/MM/YYYY' ), '' ),
			id_situacao		
	Into	:lvs_chave,
			:lvs_prot_envio,
			:lvs_prot_canc,
			:lvs_envio,
			:lvs_situacao
	From nf_venda_nfe n
  Where n.nr_nf		= :pl_Nota
	 And n.cd_filial 	= :pl_Filial
	 And n.de_especie	= :ps_especie
	 And n.de_serie	= :ps_serie
  Using SQLCa;

 Select	de_hash
	Into	:lvs_Hash
	From nf_venda_nfe_paf p
  Where p.nr_nf		= :pl_Nota
	 And p.cd_filial 	= :pl_Filial
	 And p.de_especie	= :ps_especie
	 And p.de_serie	= :ps_serie
  Using SQLCa;

If IsNull(lvs_chave) Then
	lvs_chave = ''
End If

If IsNull(lvs_prot_envio) Then
	lvs_prot_envio = ''
End If

If IsNull(lvs_prot_canc) Then
	lvs_prot_canc = ""
End If

If IsNull(lvs_situacao) Then
	lvs_situacao = ""
End If		

If SQLCa.SQLCode = 0 Then	
	If Trim(lvs_Hash) <> "" And Not IsNull(lvs_Hash) Then
		If lvs_Hash <> gf_Captura_Hash(String(pl_filial) + String(pl_Nota) + ps_especie + ps_serie + lvs_chave + lvs_prot_envio + lvs_prot_canc + lvs_envio + lvs_situacao) Then
			Return True	
		End If 
	Else		 
		Update nf_venda_nfe 
			Set id_situacao	= id_situacao
		  Where cd_filial 	= :pl_Filial
			 And nr_nf		= :pl_Nota
			 And de_especie	= :ps_especie
			 And de_serie	= :ps_serie
		 Using SQLCa;
		 
		If SQLCa.SQLCode <> -1 Then	
			SQLCa.of_Commit()
		End If			
	End If
End If
  
Return False
end function

public function boolean of_envia_ftp (string ps_caminho, string ps_arquivo, string ps_ano, string ps_mes, ref string ps_msg_ftp, boolean pb_estoque);String ls_Msg, &
		ls_ip_ftp = '10.0.4.30', &
		ls_usuario_ftp = 'caixafilial', &
		ls_acesso_ftp = 'Spum@qa8res#', &
		ls_info_ftp = 'ARQUIVO_BLOCOX', &
		ls_caminho_ftp = 'BLOCOX/'

Boolean lb_sucesso

dc_uo_ftp lo_Ftp
lo_Ftp = Create dc_uo_ftp
lo_Ftp.of_DesConecta_Ftp()

If pb_estoque Then
//	ls_caminho_ftp = ls_caminho_ftp + 'ESTOQUE/'
End If

Try
	ls_caminho_ftp = ls_caminho_ftp + String( This.ivl_filial, '0000' ) + '/' + ps_ano + '/' + ps_mes
	
	//FTP para MATRIZ				
	If lo_Ftp.of_Conecta_Ftp( ls_info_ftp, ls_ip_ftp, ls_usuario_ftp, ls_acesso_ftp, Ref ls_Msg ) Then			
		
		lb_Sucesso = lo_Ftp.of_Ftp_Set_Dir( "/", ref ls_Msg) > 0
	
		If lo_Ftp.of_Ftp_Set_Dir( "/" + ls_Caminho_ftp, ref ls_Msg) <= 0 Then	
			/* Tentar criar a estrutura necess$$HEX1$$e100$$ENDHEX$$rio no FTP */
			lo_Ftp.of_Ftp_Cria_Dir( 'BLOCOX', Ref ls_Msg )
			lo_Ftp.of_Ftp_Cria_Dir( 'BLOCOX/'+String( This.ivl_filial, '0000' ), Ref ls_Msg )						
			lo_Ftp.of_Ftp_Cria_Dir( 'BLOCOX/'+String( This.ivl_filial, '0000' ) + '/' + ps_ano, Ref ls_Msg )
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

public function boolean of_envia_pendencias_blocox_matriz (string ps_tipo, long pl_ecf, boolean pb_mensagem, boolean pb_aviso_sem_registro);Long	ll_retorno, &
		ll_row, &
		ll_sequencial, &
		ll_filial, &
		ll_ecf, &
		ll_mapa, &
		li_Contador, &
		ll_reducao

String ls_mensagem, &
		 ls_diretorio_base, &
		 ls_caminho, &
		 ls_arquivo, &
		 ls_base_producao, &
		 ls_data, &
		 ls_msg, &
		 ls_enviado
		 
String	ls_Arquivos[]		 

Date ldt_movimento

Boolean lb_Sucesso = True

gvo_aplicacao.Of_Grava_Log("Envio arquivo ReducaoZ - Entrada da fun$$HEX2$$e700e300$$ENDHEX$$o! (of_envia_pendencia_blocox_matriz).")			

ls_caminho = 'C:\Sistemas\CL\Arquivos\PAF-ECF\Arquivos - Redu$$HEX2$$e700e300$$ENDHEX$$o Z\'

dc_uo_ds_base lds_Pendencias
lds_Pendencias  = Create dc_uo_ds_base

If Not lds_Pendencias.of_ChangeDataObject('dw_ge038_pafecf_hist_blocox') Then Return False

If Not IsNull(ps_tipo) And Trim(ps_Tipo) <> '' Then
	lds_Pendencias.of_AppendWhere("cd_tipo = '" + Trim(ps_Tipo) + "'")
End If
If Not IsNull(pl_ecf) And pl_ecf > 0 Then
	lds_Pendencias.of_AppendWhere("nr_ecf = " + String(pl_ecf))	
End If

lds_Pendencias.of_AppendWhere("id_situacao = 'P' and dh_geracao_arquivo is null and id_enviado_matriz = 'N'")	

ll_Retorno = lds_Pendencias.Retrieve()
lds_Pendencias.setsort( 'nr_sequencial asc' )
lds_Pendencias.sort()

If ll_Retorno <> -1 Then
	For ll_Row = 1 To lds_Pendencias.RowCount()
		ll_sequencial 		= lds_Pendencias.object.nr_sequencial[ll_row]
		ll_filial				= lds_Pendencias.object.cd_filial[ll_row]
		ll_ecf					= lds_Pendencias.object.nr_ecf[ll_row]
		ll_mapa				= lds_Pendencias.object.nr_mapa_resumo[ll_row]
		ldt_movimento		= lds_Pendencias.object.dh_movimento[ll_row]
		
		If Not This.of_gera_blocox_reducao( ldt_movimento, ll_ecf, ll_sequencial) Then
			lb_sucesso = False
			Exit
		End If
	Next	
Else
	gvo_aplicacao.Of_Grava_Log("Envio arquivo ReducaoZ - Erro na busca de arquivos sem gera$$HEX2$$e700e300$$ENDHEX$$o! (of_envia_pendencia_blocox_matriz).")				
End If

//Vai enviar xmls da pasta	
uo_Parametro_Filial lo_Parametro_Filial
lo_Parametro_Filial = Create uo_Parametro_Filial
lo_Parametro_Filial.of_Localiza_Parametro("ID_BASE_PRODUCAO", ref ls_base_producao, False)
Destroy lo_Parametro_Filial

If ls_base_producao <> 'N' Then
	gf_dir_list( ls_caminho, '*.xml', 0+1, Ref ls_Arquivos )	
	
	For li_Contador = 1 To UpperBound( ls_Arquivos )
		// Ex: 05630000002014012126072019260720190800.xml
		ls_Arquivo 		= ls_Arquivos[ li_Contador ]
		If LenA(ls_Arquivo) = 42 Then //tamanho diferente de 42 n$$HEX1$$e300$$ENDHEX$$o envio.			
			ll_filial			= Long(LeftA( ls_Arquivo, 4 ))
			ll_sequencial	= Long(MidA( ls_Arquivo, 5, 7 ))
			ll_ecf 				= Long(MidA( ls_Arquivo, 12, 3 ))
			ll_reducao		= Long(MidA( ls_Arquivo, 15, 4 ))
			ls_data 			= MidA( ls_Arquivo, 19, 2 ) + '/' + MidA( ls_Arquivo, 21, 2 ) + '/'+ MidA( ls_Arquivo, 23, 4 )
			ldt_movimento = Date(ls_data)
			This.ivl_filial = ll_filial
			If Not This.of_envia_ftp(ls_caminho, ls_Arquivo, String( ldt_movimento, 'YYYY' ), String( ldt_movimento, 'MM' ), Ref ls_Msg, False) Then			
				gvo_aplicacao.of_grava_log('Envio arquivo ReducaoZ - Erro FTP: ' + ls_msg + ' Arquivo: ' + ls_Arquivo + ' (of_envia_pendencia_blocox_matriz)')	
				lb_sucesso = False
				exit			
			Else			
				FileMove(ls_caminho+ls_Arquivo, ls_caminho+'Enviados\'+ls_Arquivo)
				ls_enviado = 'S'
				
				Update historico_envio_arquivo_paf
				Set id_enviado_matriz = :ls_enviado
				Where cd_filial   = :ll_filial
					and nr_sequencial =:ll_sequencial
				Using Sqlca;
				
				If Sqlca.Sqlcode = -1 Then
					Sqlca.of_LogDbError(gvo_Aplicacao.ivi_Log,"Atualiza$$HEX2$$e700e300$$ENDHEX$$o Hitorico PAF.")
					Return False
				Else
					Sqlca.of_Commit()	
					lb_sucesso = true
				End If
				
			End If
		End If
	Next		
	
End If

gvo_aplicacao.Of_Grava_Log("Envio arquivo ReducaoZ - Saida da fun$$HEX2$$e700e300$$ENDHEX$$o! (of_envia_pendencia_blocox_matriz).")			

Return lb_Sucesso
end function

public function boolean of_gera_blocox_reducao (date pdt_data_fiscal, long pl_ecf, long pl_seq_historico);//FUN$$HEX2$$c700c300$$ENDHEX$$O QUE MONTA O ARQUIVO XML DO BLOCO X REDUCA$$HEX2$$c700c300$$ENDHEX$$O Z
//ALTERA$$HEX2$$c700d500$$ENDHEX$$ES NA ESTRUTURA DO ARQUIVO DEVEM SER FEISTA AQUI E NAS OUTRA DUAS FUN$$HEX2$$c700d500$$ENDHEX$$ES QUE GERAM O ARQUIVO

String ls_Path_Arquivo

SetNull(ls_Path_Arquivo)

Return This.of_gera_blocox_reducao( pdt_data_fiscal, pl_ecf, pl_seq_historico, ls_path_arquivo)


end function

public function boolean of_gera_blocox_reducao (date pdt_inicio, long pl_ecf, ref string ps_recibo, ref string ps_situacao, long pl_sequencial_hist, long pl_filial);//FUN$$HEX2$$c700c300$$ENDHEX$$O QUE MONTA O ARQUIVO XML DO BLOCO X REDUCA$$HEX2$$c700c300$$ENDHEX$$O Z
//ALTERA$$HEX2$$c700d500$$ENDHEX$$ES NA ESTRUTURA DO ARQUIVO DEVEM SER FEISTA AQUI E NAS OUTRA DUAS FUN$$HEX2$$c700d500$$ENDHEX$$ES QUE GERAM O ARQUIVO

String ls_Registro, &
		 ls_ins_est, &
		 ls_cst_trib, &
		 ls_cst_trib_ant, &
		 ls_nome_totalizador, &
		 ls_icms, &
		 ls_qtRZ, &
		 ls_dataRZ, &
		 ls_nome_arquivo,&
		 ls_arquivo, &
		 ls_retorno, &
		 ls_codigo, &
		 ls_cod_barras, &
		 ls_mensagem, &
		 ls_arquivo_retorno, &
		 ls_recibo, &
		 ls_cest, &
		 ls_ncm, &
		 ls_error, &
		 ls_situacao, &
		 ls_CPD, &
		 ls_descricao, &
		 ls_data_hora, &
		 ls_erro,&
		 ls_enviado = 'N'
		 
Long ll_ecf, &
		ll_retorno, &
		ll_row, &
		ll_mapa, &
		ll_find, &
		ll_qt_reducao, &
		ll_Row_canc, &
		ll_produto, &
		ll_nova_linha,&
		ll_qt_redz_ant,&
		ll_mapa_ant	,&
		ll_filial
		
Decimal {2} lvdc_venda_bruta, &
			 	lvdc_total_F1, &
				lvdc_total_I1, &
				lvdc_total_N1, &
				lvdc_icms, &
				lvdc_icms_ant, &
				lvdc_valor_imposto, &
				lvdc_cancelamento_mapa, &
				lvdc_desconto_mapa, &
				lvdc_total_item_canc, &
				lvdc_Sum_Cancelamento, &
				lvdc_Sum_Desconto, &
				lvdc_Sum_Itens, &
				lvdc_Sum_Aliquotas, &
				lvdc_Sum_Aliq17, &
				lvdc_Sum_Aliq25, &				
				lvdc_dif_cancelamento, &
				lvdc_dif_venda_liquida, &
				lvdc_dif_desconto, &
				lvdc_Aux, &
				lvdc_sum_i1, &
				lvdc_sum_n1, &
				lvdc_sum_f1, &
				lvdc_sum_17, &
				lvdc_sum_25, &
				lvdc_sum_tributado, &
				lvdc_dif_i1, &
				lvdc_dif_n1, &
				lvdc_dif_f1, &
				lvdc_dif_tributado, &
				lvdc_dif_17, &
				lvdc_dif_25, &
				lvdc_divisao_dif,&				
				lvdc_gt_inicial_ant,&
				lvdc_gt_final_ant,&
				lvdc_dif_limite
				
Boolean lb_enviar, &
		   lb_sucesso, &
		   lb_ordena

DateTime ldt_data_geracao
Date		ldt_data_rz

gvo_aplicacao.Of_Grava_Log("Grava$$HEX2$$e700e300$$ENDHEX$$o Arquivo Redu$$HEX2$$e700e300$$ENDHEX$$oZ - Entrada na fun$$HEX2$$e700e300$$ENDHEX$$o!(of_gera_blocox_reducao).")			

dc_uo_api lo_api
lo_api = Create dc_uo_api

lo_api.of_create_directory('C:\Sistemas\CL\Arquivos\PAF-ECF\Recibos - Bloco X')
lo_api.of_create_directory('C:\Sistemas\CL\Arquivos\PAF-ECF\Arquivos - Redu$$HEX2$$e700e300$$ENDHEX$$o Z')
lo_api.of_create_directory('C:\Sistemas\CL\Arquivos\PAF-ECF\Arquivos - Redu$$HEX2$$e700e300$$ENDHEX$$o Z\Enviados')

Destroy(lo_api)								

lvdc_dif_limite = 0.50
		 
ls_ins_est			= gf_replace(gvo_parametro.nr_inscricao_estadual, '.', '', 0)
ls_ins_est			= gf_replace(ls_ins_est, '/', '', 0)
ls_ins_est			= gf_replace(ls_ins_est, '-', '', 0)

//cabe$$HEX1$$e700$$ENDHEX$$aho, dados da loja e sistema
ls_Registro = '<?xml version="1.0" encoding="UTF-8"?>' + ivs_Enter 							+ &
					'<ReducaoZ Versao="1.0">' + ivs_Enter 												+ &
					This.of_Abre_Tag('Mensagem', 1)														+ &					
					This.of_Abre_Tag('Estabelecimento', 2)												+ &
					This.of_Elemento('Ie', ls_ins_est, 3)													+ &
					This.of_Fecha_tag('Estabelecimento', 2)												+ &					
					This.of_Abre_Tag('PafEcf', 2)															+ &
					This.of_Elemento('NumeroCredenciamento', is_numero_credenciamento, 3)+ &
					This.of_Fecha_tag('PafEcf', 2)				

ll_ecf = pl_ecf
ll_filial = gvo_parametro.cd_filial

If Not This.of_Carrega_dados_ecf(ll_ecf) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o foi possivel ler os dados da ECF.",StopSign!)
	Return False
End If				
//Fazer esquema para 1 ECF ou todas
//Dados ECF
ls_CPD = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "ECF", "CPD","")

If Trim(UPPER(ls_CPD)) = 'SIM' Then //Fixo, porque ECFs de testes n$$HEX1$$e300$$ENDHEX$$o tem cadastro no SEFAZ.	
	Choose Case Upper(Trim(This.de_marca))
		Case "BEMATECH"
			This.nr_serie_mfd = 'BE111710101110021142' 
		Case "DARUMA"
			This.nr_serie_mfd = 'DR0512BR000000352916'
		Case "EPSON"
			This.nr_serie_mfd = 'EP121710000000015156'
		Case "SWEDA"
			This.nr_serie_mfd = 'SW031000000000008755'
		Case Else			
			If LeftA(Upper(Trim(This.de_marca)),6) = "DARUMA" then
				This.nr_serie_mfd = 'DR0512BR000000352916'
			End If
	End Choose
End If

String ls_serie_mfd
ls_serie_mfd = This.nr_serie_mfd

If 	(ll_filial = 301 And ll_ecf = 4) Or &
	(ll_filial = 592 And ll_ecf = 3) Or &
 	(ll_filial = 702 And ll_ecf = 2) Or &
	(ll_filial = 811 And ll_ecf = 4) Or &
	(ll_filial = 820 And ll_ecf = 1) Or &
	(ll_filial = 877 And ll_ecf = 4) Or &
	(ll_filial = 890 And ll_ecf = 4) Or &
	(ll_filial = 921 And ll_ecf = 2) Then
	If LenA(ls_serie_mfd) = 20 Then
		ls_serie_mfd = ls_serie_mfd + 'A'
	End If
End If

ls_Registro += This.of_Abre_Tag('Ecf', 2)	+ &									   	
					This.of_Elemento('NumeroFabricacao', ls_serie_mfd, 3)

//Dados ReducaoZ
dc_uo_ds_base lds_Reducao
lds_Reducao  = Create dc_uo_ds_base

If Not lds_Reducao.of_ChangeDataObject('dw_ge038_pafecf_reducaoz') Then Return False

ll_Retorno = lds_Reducao.Retrieve(ll_ecf,pdt_inicio,pdt_inicio)

If ll_Retorno <> -1 Then
	
	If lds_Reducao.RowCount() = 0 Then
		//sem dados de reducaoZ
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o",'Sem vendas para gerar arquivo.')
		gvo_aplicacao.Of_Grava_Log("Grava$$HEX2$$e700e300$$ENDHEX$$o Arquivo Redu$$HEX2$$e700e300$$ENDHEX$$oZ - Sem dados de mapa resumo da redua$$HEX2$$e700e300$$ENDHEX$$oZ.(of_gera_blocox_reducao).")						
		Return False
	End If
	
	lvdc_venda_bruta 	= lds_Reducao.object.vl_total_geral_final[1] - lds_Reducao.object.vl_total_geral_inicial[1]  // - lds_Reducao.object.vl_cancelamento[1]
	lvdc_total_F1 		= lds_Reducao.object.vl_st[1]
	lvdc_total_I1 		= lds_Reducao.object.vl_isenta[1]	
	lvdc_total_N1 		= lds_Reducao.object.vl_nao_incidencia[1]
	lvdc_cancelamento_mapa = lds_Reducao.object.vl_cancelamento[1]
	lvdc_desconto_mapa = lds_Reducao.object.vl_desconto[1]
	ll_mapa				= lds_Reducao.object.nr_mapa[1]
	ll_qt_reducao		= lds_Reducao.object.qt_reducao_z[1]	
	ls_qtRZ				= String(lds_Reducao.object.qt_reducao_z[1],'0000')
	ls_dataRZ			= String(lds_Reducao.object.dh_emissao[1],'ddmmyyyy')
	ldt_data_rz			= lds_Reducao.object.dh_emissao[1]
	
	ls_Registro += This.of_Abre_Tag('DadosReducaoZ', 3)	+ &
						This.of_Elemento('DataReferencia', String(lds_Reducao.object.dh_emissao[1],'yyyy-mm-dd'), 4)	+ &
						This.of_Elemento('DataHoraEmissao', String(lds_Reducao.object.dh_reducao[1],'yyyy-mm-ddThh:mm:ss'), 4)	+ &						
						This.of_Elemento('CRZ', String(lds_Reducao.object.qt_reducao_z[1],'0000'), 4)								+ &					
						This.of_Elemento('COO', String(lds_Reducao.object.nr_operacao_final[1],'000000000'), 4)					+ &
						This.of_Elemento('CRO', String(lds_Reducao.object.qt_reinicio_z[1],'000'), 4)									+ &
						This.of_Elemento('VendaBrutaDiaria', This.of_Formata_Valor_PafEcf(lvdc_venda_bruta,12,2), 4)			+ &
						This.of_Elemento('GT', This.of_Formata_Valor_PafEcf(lds_Reducao.object.vl_total_geral_final[1],16,2), 4)

	//Busca GTs do dia anterior e contador de reducao z
	If lds_Reducao.object.dh_emissao[1] > dt_inicio_blocox Then
		select nr_mapa, vl_total_geral_inicial, vl_total_geral_final, qt_reducao_z 
			into :ll_mapa_ant,:lvdc_gt_inicial_ant, :lvdc_gt_final_ant, :ll_qt_redz_ant
		from mapa_resumo_ecf 
			where cd_filial = :pl_filial
				and nr_ecf = :pl_ecf
				and qt_reducao_z = :ll_qt_reducao - 1
		Using SqlCa;
		
		Choose Case Sqlca.SqlCode		
			Case -1		
				Sqlca.of_LogDbError(gvo_Aplicacao.ivi_Log,"Localiza$$HEX2$$e700e300$$ENDHEX$$o do Mapa Resumo ECF anterior")
				Return False
			Case 0
				If lvdc_gt_final_ant <> lds_Reducao.object.vl_total_geral_inicial[1] Then
					//GT Final anterior diferente do GT inicial 
					ls_erro = "XML n$$HEX1$$e300$$ENDHEX$$o gerado. GT Final anterior(" + String(lvdc_gt_final_ant, '0.00')  +  ") diferente do GT inicial atual(" + String(lds_Reducao.object.vl_total_geral_inicial[1],'0.00') + ")."
					This.of_atualiza_historico_erro( pl_filial, pl_sequencial_hist, ls_erro)
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","GT Final anterior diferente do GT Inicial atual.",StopSign!)					
					Return False
				End If
				If (ll_qt_redz_ant + 1) <> lds_Reducao.object.qt_reducao_z[1] Then
					//Contador de reducaoz diferente do esperado
					ls_erro = "XML n$$HEX1$$e300$$ENDHEX$$o gerado. Contador de reducaoz atual diferente do esperado. Atual " + String(lds_Reducao.object.qt_reducao_z[1]) + " Anterior: " + String(ll_qt_redz_ant)
					This.of_atualiza_historico_erro( pl_filial, pl_sequencial_hist, ls_erro)
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Contador de reducaoz atual diferente do esperado.",StopSign!)					
					Return False
				End If			
			Case 100
				//N$$HEX1$$e300$$ENDHEX$$o achou, n$$HEX1$$e300$$ENDHEX$$o faz a verifica$$HEX2$$e700e300$$ENDHEX$$o		
				//Verificar se tratar pulo de contador de redu$$HEX2$$e700e300$$ENDHEX$$oZ
		End choose	
	End If					
						
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o foi possivel ler os dados da redu$$HEX2$$e700e300$$ENDHEX$$o Z.",StopSign!)
	gvo_aplicacao.Of_Grava_Log("Grava$$HEX2$$e700e300$$ENDHEX$$o Arquivo Redu$$HEX2$$e700e300$$ENDHEX$$oZ - Erro ao buscar dados da redua$$HEX2$$e700e300$$ENDHEX$$oZ.(of_gera_blocox_reducao).")				
	Return False				
End If

//Busca dados de aliquotas
dc_uo_ds_base lds_mapa_aliq
lds_mapa_aliq  = Create dc_uo_ds_base

If Not lds_mapa_aliq.of_ChangeDataObject('ds_ge038_pafecf_resumo_ecf_aliq') Then Return False

ll_Retorno = lds_mapa_aliq.Retrieve(ll_mapa, ll_ecf)

If ll_Retorno = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o foi possivel ler os dados de al$$HEX1$$ed00$$ENDHEX$$quotas.",StopSign!)
	gvo_aplicacao.Of_Grava_Log("Grava$$HEX2$$e700e300$$ENDHEX$$o Arquivo Redu$$HEX2$$e700e300$$ENDHEX$$oZ - Erro ao buscar al$$HEX1$$ed00$$ENDHEX$$quotas do mapa resumo.(of_gera_blocox_reducao).")						
	Return False				
End If

lvdc_Sum_Aliquotas 	= lds_mapa_aliq.GetItemDecimal(lds_mapa_aliq.RowCount(), "sum_base_calculo")
lvdc_Sum_Aliq17		= lds_mapa_aliq.GetItemDecimal(lds_mapa_aliq.RowCount(), "sum_aliq_17")
lvdc_Sum_Aliq25		= lds_mapa_aliq.GetItemDecimal(lds_mapa_aliq.RowCount(), "sum_aliq_25")

//Dados de totalizadores
dc_uo_ds_base lds_Produtos
lds_Produtos  = Create dc_uo_ds_base

If Not lds_Produtos.of_ChangeDataObject('ds_ge038_pafecf_produto_cupom_aliquota') Then Return False

ll_Retorno = lds_Produtos.Retrieve(ll_ecf,pdt_inicio,pdt_inicio)

If ll_Retorno <> -1 Then
	
	//Dados produto cancelados  
	dc_uo_ds_base lds_cancelamentos
	lds_cancelamentos  = Create dc_uo_ds_base
	
	If Not lds_cancelamentos.of_ChangeDataObject('ds_ge038_pafecf_produto_cancelado_blocox') Then 
		//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o foi possivel ler os dados de cancelamentos.",StopSign!)
		gvo_aplicacao.Of_Grava_Log("Grava$$HEX2$$e700e300$$ENDHEX$$o Arquivo Redu$$HEX2$$e700e300$$ENDHEX$$oZ - Erro ao buscar cancelamentos.(of_gera_blocox_reducao).")						
		Return False				
	End If
	
	ll_Retorno = lds_cancelamentos.Retrieve(pl_filial, ll_ecf,pdt_inicio,pdt_inicio)
	
	If ll_Retorno <> -1 Then
		If lds_cancelamentos.RowCount() > 0 Then
			lvdc_Sum_Cancelamento = lds_cancelamentos.GetItemDecimal(lds_cancelamentos.RowCount(), "sum_total_cancelado")
			lvdc_dif_cancelamento = lvdc_cancelamento_mapa - lvdc_Sum_Cancelamento
			If Abs(lvdc_dif_cancelamento) = lvdc_Sum_Cancelamento Then //diferen$$HEX1$$e700$$ENDHEX$$a igual a soma do grid, indica que no ECF n$$HEX1$$e300$$ENDHEX$$o registrou cancelamento
				gvo_aplicacao.Of_Grava_Log("Grava$$HEX2$$e700e300$$ENDHEX$$o Arquivo Redu$$HEX2$$e700e300$$ENDHEX$$oZ - Existe cancelamento registrado no Sistema e n$$HEX1$$e300$$ENDHEX$$o na redu$$HEX2$$e700e300$$ENDHEX$$o Z. ECF: " + String(ll_ecf)  + " Mapa: " + String(ll_mapa) + " Data Fiscal: " + ls_dataRZ + " (of_gera_blocox_reducao).")
				ls_erro = "XML n$$HEX1$$e300$$ENDHEX$$o gerado. Cancelamentos registrados no Sistema e n$$HEX1$$e300$$ENDHEX$$o na Redu$$HEX2$$e700e300$$ENDHEX$$o Z."
				This.of_atualiza_historico_erro( pl_filial, pl_sequencial_hist, ls_erro)								
				Return False
			End If
			
			uo_produto lvo_produto
			lvo_produto = Create uo_produto
			
			uo_Tratamento_Fiscal lvo_Fiscal
			lvo_Fiscal = Create uo_Tratamento_Fiscal

			uo_Atributo_Fiscal_Item_NF	 lvo_Atributo
			lvo_Atributo = Create uo_Atributo_Fiscal_Item_NF
			
			lvo_Fiscal.of_Grava_Contribuinte(False)
			lvo_Fiscal.of_Grava_UF_Origem_Destino( 'SC', 'SC')
			lvo_Fiscal.of_Grava_Operacao(lvo_Fiscal.VENDA)	
			
			If lvdc_dif_cancelamento <> 0.00 Then
				lvdc_divisao_dif = lvdc_dif_cancelamento / lds_cancelamentos.RowCount()
			End if
			For ll_Row_canc = 1 To lds_cancelamentos.RowCount()
				If lvdc_dif_cancelamento <> 0.00 Then							
					//Se for o $$HEX1$$fa00$$ENDHEX$$ltimo item a diferen$$HEX1$$e700$$ENDHEX$$a ser$$HEX1$$e100$$ENDHEX$$ o restante
					If ll_Row_canc = lds_cancelamentos.RowCount() Then
						If lvdc_dif_cancelamento > 0.00 Then
							lvdc_Aux = lvdc_dif_cancelamento
						Else
							If lds_cancelamentos.Object.total_cancelado[ll_row_Canc] > Abs(lvdc_dif_cancelamento) Then
								lvdc_Aux = lvdc_dif_cancelamento
							Else
								gvo_aplicacao.Of_Grava_Log("Grava$$HEX2$$e700e300$$ENDHEX$$o Arquivo Redu$$HEX2$$e700e300$$ENDHEX$$oZ - N$$HEX1$$e300$$ENDHEX$$o foi possivel dividir a diferen$$HEX1$$e700$$ENDHEX$$a de cancelamento entre os itens. ECF: " + String(ll_ecf)  + " Mapa: " + String(ll_mapa) + " Data Fiscal: " + ls_dataRZ + "(of_gera_blocox_reducao).")
								ls_erro = "XML n$$HEX1$$e300$$ENDHEX$$o gerado. N$$HEX1$$e300$$ENDHEX$$o foi possivel dividir a diferen$$HEX1$$e700$$ENDHEX$$a de cancelamento entre os itens."
								This.of_atualiza_historico_erro( pl_filial, pl_sequencial_hist, ls_erro)																
								Return False							
							End If
						End If
					Else
						If lvdc_divisao_dif > 0.00 Then
							lvdc_Aux = lvdc_divisao_dif
						Else  
							//Verifica se o valor do item n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ suficiente, deixa o item com 1 centavo e o resto tira da diferen$$HEX1$$e700$$ENDHEX$$a.
							If lds_cancelamentos.Object.total_cancelado[ll_row_Canc] <= Abs(lvdc_dif_cancelamento) Then
								If lds_cancelamentos.Object.total_cancelado[ll_row_Canc] > 0.01 Then
									lvdc_Aux = 0.01 - lds_cancelamentos.Object.total_cancelado[ll_row_Canc]
								Else
									lvdc_Aux = 0.00
								End If
							Else
								lvdc_Aux = lvdc_dif_cancelamento
							End If
						End If
					End If					
					lds_cancelamentos.Object.total_cancelado[ll_row_Canc] = lds_cancelamentos.Object.total_cancelado[ll_row_Canc] + lvdc_Aux
					lvdc_dif_cancelamento -= lvdc_Aux
				End If				
				
				ll_produto = lds_cancelamentos.object.cd_produto[ll_Row_canc]
				ll_find    = lds_Produtos.Find ("cd_produto = " + STRING( ll_produto ), 1 ,lds_Produtos.RowCount())				
				If ll_find > 0 Then
					lds_Produtos.Object.TotalCanc[ll_find] = lds_cancelamentos.Object.total_cancelado[ll_row_Canc]			
				Else
					If ll_find = 0 Then  //N$$HEX1$$e300$$ENDHEX$$o encontrou, incluir no grid produtos
						//Busca Tributacao
						lvo_Produto.of_Localiza_Codigo_Interno(ll_Produto) 			
						If Not lvo_Produto.Localizado Then
							//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao buscar dados de produto cancelado Produto: " +String(ll_produto),StopSign!)
							gvo_aplicacao.Of_Grava_Log("Grava$$HEX2$$e700e300$$ENDHEX$$o Arquivo Redu$$HEX2$$e700e300$$ENDHEX$$oZ - Erro ao buscar dados do produto cancelado.(of_gera_blocox_reducao).")							
							Return False				
						End If
						
						lvo_Atributo = lvo_Fiscal.of_Atributo_Fiscal_Produto(lvo_Produto)						
						If Not lvo_Atributo.Localizado Then
							//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Os atributos fiscais do produto cancelado'" + String(ll_Produto) + "' n$$HEX1$$e300$$ENDHEX$$o foram localizados.",StopSign!)
							gvo_aplicacao.Of_Grava_Log("Grava$$HEX2$$e700e300$$ENDHEX$$o Arquivo Redu$$HEX2$$e700e300$$ENDHEX$$oZ - Erro ao buscar dados do atributo fiscal produto: " + String(ll_Produto) + ".(of_gera_blocox_reducao).")							
							Return False
						End If
						
						ll_nova_linha = lds_produtos.InsertRow(0)
						lds_produtos.object.cd_produto					[ll_nova_linha] = lds_cancelamentos.object.cd_produto[ll_Row_canc]
						lds_produtos.object.de_produto					[ll_nova_linha] = lds_cancelamentos.object.de_produto[ll_Row_canc]
						lds_produtos.object.cd_unidade_medida_venda[ll_nova_linha] = lds_cancelamentos.object.cd_unidade_medida_venda[ll_Row_canc]
						lds_produtos.object.de_codigo_barras			[ll_nova_linha] = lds_cancelamentos.object.de_codigo_barras[ll_Row_canc]						
						lds_produtos.object.cd_cest							[ll_nova_linha] = lds_cancelamentos.object.cd_cest[ll_Row_canc]
						lds_produtos.object.nr_classificacao_fiscal		[ll_nova_linha] = lds_cancelamentos.object.nr_classificacao_fiscal[ll_Row_canc]
						lds_produtos.object.pc_icms						[ll_nova_linha] = lvo_atributo.pc_icms
						lds_produtos.object.cd_cst_tributacao			[ll_nova_linha] = RightA(lvo_atributo.cd_situacao_tributaria,1) + '0'
						lds_produtos.object.cd_produto_sap				[ll_nova_linha] = lds_cancelamentos.object.cd_produto_sap[ll_Row_canc]						
						lds_produtos.object.qtd								[ll_nova_linha] = 0   //????????
						lds_produtos.object.totalitem						[ll_nova_linha] = 0
						lds_produtos.object.Totaldesc						[ll_nova_linha] = 0
						lds_produtos.object.TotalCanc						[ll_nova_linha] = lds_cancelamentos.object.total_cancelado[ll_Row_canc]
						lb_ordena = True
					Else			
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no find do produto: " + String(ll_Produto),StopSign!)
						gvo_aplicacao.Of_Grava_Log("Grava$$HEX2$$e700e300$$ENDHEX$$o Arquivo Redu$$HEX2$$e700e300$$ENDHEX$$oZ - Erro find do produto: " + String(ll_Produto) + ".(of_gera_blocox_reducao).")							
						Return False
					End If
				End If	
			Next
			If lb_ordena Then
				lds_produtos.SetSort("i.pc_icms, i.cd_cst_tributacao")
				lds_produtos.Sort()				
			End If
		End If
	Else
		//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o foi possivel ler os dados de cancelamentos.",StopSign!)
		gvo_aplicacao.Of_Grava_Log("Grava$$HEX2$$e700e300$$ENDHEX$$o Arquivo Redu$$HEX2$$e700e300$$ENDHEX$$oZ - Erro ao buscar cancelamentos. " + lds_cancelamentos.itr_transacao.is_lasterrortext + "(of_gera_blocox_reducao).")						
		Return False							
	End If	
	//Fim produtos cancelados		
	
	ls_Registro += This.of_Abre_Tag('TotalizadoresParciais', 4)	+ &
						This.of_Abre_Tag('TotalizadorParcial', 5)		

	For ll_Row = 1 To lds_Produtos.RowCount()
		If ll_Row = 1 Then //Verifica diferen$$HEX1$$e700$$ENDHEX$$as
			lvdc_Sum_Itens 			= lds_Produtos.GetItemDecimal(lds_Produtos.RowCount(), "sum_totalitem")
			lvdc_Sum_Desconto 		= lds_Produtos.GetItemDecimal(lds_Produtos.RowCount(), "sum_totaldesc")		
			
			lvdc_dif_venda_liquida 	= (lvdc_total_F1 + lvdc_total_I1 + lvdc_total_N1 + lvdc_Sum_Aliquotas) - lvdc_Sum_Itens
			lvdc_dif_desconto = lvdc_desconto_mapa - lvdc_Sum_Desconto
			If lvdc_dif_venda_liquida <> 0.00  Or lvdc_dif_desconto <> 0.00 Then
				If Abs(lvdc_dif_venda_liquida) > lvdc_dif_limite Or Abs(lvdc_dif_desconto) > lvdc_dif_limite Then //diferen$$HEX1$$e700$$ENDHEX$$a maior que 0,50 n$$HEX1$$e300$$ENDHEX$$o continua
					gvo_aplicacao.Of_Grava_Log("Valor de diferen$$HEX1$$e700$$ENDHEX$$a na venda liquida e desconto supera o limite permitido.(of_gera_blocox_reducao_matriz).")
					ls_erro = "XML n$$HEX1$$e300$$ENDHEX$$o gerado. Valor de diferen$$HEX1$$e700$$ENDHEX$$a na venda liquida ou desconto supera o limite permitido. Diferen$$HEX1$$e700$$ENDHEX$$a venda: " + String(lvdc_dif_venda_liquida, '0.00') + ". Diferen$$HEX1$$e700$$ENDHEX$$a Desconto: " + String(lvdc_dif_desconto, '0.00')
					This.of_atualiza_historico_erro( pl_filial, pl_sequencial_hist, ls_erro)										
					Return False
				End If	
	
				//Busca totais por Situacao
				lvdc_sum_i1 			= lds_Produtos.GetItemDecimal(ll_find, "sum_grupo_i1")
				lvdc_dif_i1 				= lvdc_total_I1 - lvdc_sum_i1							
				lvdc_sum_n1 			= lds_Produtos.GetItemDecimal(ll_find, "sum_grupo_n1")
				lvdc_dif_n1 				= lvdc_total_N1 - lvdc_sum_n1
				lvdc_sum_f1 			= lds_Produtos.GetItemDecimal(ll_find, "sum_grupo_f1")
				lvdc_dif_f1				= lvdc_total_F1 - lvdc_sum_f1				
				lvdc_sum_17 			= lds_Produtos.GetItemDecimal(ll_find, "sum_grupo_17")
				lvdc_dif_17 				= lvdc_Sum_Aliq17 - lvdc_sum_17
				lvdc_sum_25 			= lds_Produtos.GetItemDecimal(ll_find, "sum_grupo_25")				
				lvdc_dif_25 				= lvdc_Sum_Aliq25 - lvdc_sum_25
				lvdc_sum_tributado	= lvdc_sum_17 + lvdc_sum_25
				lvdc_dif_tributado 		= lvdc_Sum_Aliquotas - lvdc_sum_tributado
			End If
		End If
		
		If IsNull(lds_Produtos.Object.cd_cest[ll_Row]) Or Trim(lds_Produtos.Object.cd_cest[ll_Row]) = '' Then
			ls_cest = '0000000'
		Else
			ls_cest = lds_Produtos.Object.cd_cest[ll_Row]
		End If			
		If IsNull(String(lds_Produtos.Object.nr_classificacao_fiscal[ll_Row],'00000000')) Then	
			ls_ncm = '00000000'
		Else
			ls_ncm = String(lds_Produtos.Object.nr_classificacao_fiscal[ll_Row],'00000000')
		End If
		//****TRATAMENTO PARA HOMOLOGACAO****** RETIRAR PARA PRODUCAO
		//		NCMs 34011190, 34011900, 34011900, 34012010 e 34013000 aceitar$$HEX1$$e300$$ENDHEX$$o somente os CESTs 2003400, 2003500, 2003501, 2003600, 2003700, 2802000, 2802100, 2802200 e 2802300.
		//If ls_ncm = '34011190' or ls_ncm = '34011900' or ls_ncm = '34011900' or ls_ncm = '34012010' or ls_ncm = '34013000' Then
		//	ls_cest = '2003400'
		//End If		
		//****
		If IsNull(lds_Produtos.object.de_codigo_barras[ll_row]) Or Trim(lds_Produtos.object.de_codigo_barras[ll_row]) = '' Then
			ls_cod_barras = '0'
		Else
			Choose Case lds_Produtos.object.cd_produto[ll_row]    //Tratamentos para produtos "servi$$HEX1$$e700$$ENDHEX$$o".
				Case 684431,735582,577625,723786,712055,735909,735947,135570,683845,123060,693844,135562,693843,733631,705965,700495,707440,707439,700118,735001,734997,733159,733164,736956,736957,738063,738062,733651,705861
					ls_cod_barras = '0'
				Case Else
					ls_cod_barras = lds_Produtos.object.de_codigo_barras[ll_row]					
			End Choose		
		End If		
		
		ls_descricao = gf_retira_caracteres_especiais(lds_Produtos.object.de_produto[ll_row])		
		ls_cst_trib = Trim(lds_Produtos.object.cd_cst_tributacao[ll_row])
//		 ls_cst_trib_ant
		lvdc_icms = lds_Produtos.object.pc_icms[ll_row]
		//lvdc_icms_ant
		If lvdc_icms = 0 Then  //produto com substituicao, isento, ou sem incidencia
			Choose Case ls_cst_trib
				Case '40'
					ls_nome_totalizador = 'I1'
					lvdc_valor_imposto = lvdc_total_I1
					If lvdc_dif_i1 <> 0.00 Then //Diferen$$HEX1$$e700$$ENDHEX$$a
						If lds_Produtos.object.totalitem[ll_row] > 0 And lds_Produtos.object.totalitem[ll_row] > Abs(lvdc_dif_i1) Then												
							lvdc_Aux = lvdc_dif_i1
							lds_Produtos.object.totalitem[ll_row] = lds_Produtos.object.totalitem[ll_row] + lvdc_Aux
							lvdc_dif_i1 -= lvdc_Aux
						End If
					End If
				Case '41'
					ls_nome_totalizador = 'N1'
					lvdc_valor_imposto = lvdc_total_N1
					If lvdc_dif_n1 <> 0.00 Then //Diferen$$HEX1$$e700$$ENDHEX$$a
						If lds_Produtos.object.totalitem[ll_row] > 0 And lds_Produtos.object.totalitem[ll_row] > Abs(lvdc_dif_n1) Then							
							lvdc_Aux = lvdc_dif_n1
							lds_Produtos.object.totalitem[ll_row] = lds_Produtos.object.totalitem[ll_row] + lvdc_Aux
							lvdc_dif_n1 -= lvdc_Aux
						End If
					End If					
				Case Else
					ls_nome_totalizador = 'F1'
					lvdc_valor_imposto = lvdc_total_F1
					If lvdc_dif_f1 <> 0.00 Then //Diferen$$HEX1$$e700$$ENDHEX$$a
						If lds_Produtos.object.totalitem[ll_row] > 0 And lds_Produtos.object.totalitem[ll_row] > Abs(lvdc_dif_f1) Then							
							lvdc_Aux = lvdc_dif_f1
							lds_Produtos.object.totalitem[ll_row] = lds_Produtos.object.totalitem[ll_row] + lvdc_Aux
							lvdc_dif_f1 -= lvdc_Aux
						End If
					End If
					//Diferen$$HEX1$$e700$$ENDHEX$$a de desconto jogo somente aqui
					If lvdc_dif_desconto <> 0.00 And lds_Produtos.object.totaldesc[ll_row] > 0 And lds_Produtos.object.totaldesc[ll_row] > Abs(lvdc_dif_desconto) Then //Diferen$$HEX1$$e700$$ENDHEX$$a DESCONTO						
						lvdc_Aux = lvdc_dif_desconto
						lds_Produtos.object.totaldesc[ll_row] = lds_Produtos.object.totaldesc[ll_row] + lvdc_Aux
						lvdc_dif_desconto -= lvdc_Aux						
					End If										
			End Choose
			
			If ls_cst_trib <> ls_cst_trib_ant Then
				If (ls_cst_trib_ant = '' or IsNull(ls_cst_trib_ant)) Then  //1$$HEX1$$aa00$$ENDHEX$$ vez
					ls_Registro += This.of_Elemento('Nome', ls_nome_totalizador, 6)	+ &
										This.of_Elemento('Valor', String(lvdc_valor_imposto,'####0.00'), 6)	+ &
										This.of_Abre_Tag('ProdutosServicos', 6)
				Else	//precisa fechar tag de totalizador anterior e abrir para o novo
					ls_Registro += 	This.of_Fecha_Tag('ProdutosServicos', 6)	+ &					
										This.of_Fecha_Tag('TotalizadorParcial', 5)	+ &
										This.of_Abre_Tag('TotalizadorParcial', 5)	+ &
										This.of_Elemento('Nome', ls_nome_totalizador, 6)	+ &
										This.of_Elemento('Valor', String(lvdc_valor_imposto,'####0.00'), 6)	+ &
										This.of_Abre_Tag('ProdutosServicos', 6)										
				End If
			End If			
			
			ls_Registro += This.of_Abre_Tag('Produto', 7)	+ &
								This.of_Elemento('Descricao', ls_descricao, 8)
			If ls_cod_barras = '0' Then
				ls_Registro += This.of_Elemento_Vazio('CodigoGTIN', '', 8)
			Else
				ls_Registro +=	This.of_Elemento('CodigoGTIN', ls_cod_barras, 8)
			End if								
			ls_Registro += This.of_Elemento('CodigoCEST', ls_cest, 8)+ &
								This.of_Elemento('CodigoNCMSH', ls_ncm, 8)
			If Not IsNull(This.dt_envio_codigo_sap) Then
				If ldt_data_rz >= This.dt_envio_codigo_sap Then
					ls_Registro += This.of_Elemento('CodigoProprio', lds_Produtos.object.cd_produto_sap[ll_row], 8)								
				Else
					ls_Registro += This.of_Elemento('CodigoProprio', String(lds_Produtos.object.cd_produto[ll_row]), 8)								
				End If				
			Else
				ls_Registro += This.of_Elemento('CodigoProprio', String(lds_Produtos.object.cd_produto[ll_row]), 8)												
			End If
			ls_Registro += This.of_Elemento('Quantidade', String(lds_Produtos.object.qtd[ll_row],'####0.000'), 8)		+ &
								This.of_Elemento('Unidade', lds_Produtos.object.cd_unidade_medida_venda[ll_row], 8) + &
								This.of_Elemento('ValorDesconto', String(lds_Produtos.object.totaldesc[ll_row],'####0.00'), 8) + &
								This.of_Elemento('ValorAcrescimo', String(0,'####0.00'), 8) + &
								This.of_Elemento('ValorCancelamento', String(lds_Produtos.object.totalcanc[ll_row],'####0.00'), 8) + &
								This.of_Elemento('ValorTotalLiquido', String(lds_Produtos.object.totalitem[ll_row],'####0.00'), 8) + &								
								This.of_Fecha_Tag('Produto', 7)
			
			ls_cst_trib_ant = ls_cst_trib	
			
		Else		//tributados
			If lvdc_dif_tributado <> 0.00 Then //Diferen$$HEX1$$e700$$ENDHEX$$a
				Choose Case Long(lvdc_icms)
					Case 17
						If lvdc_dif_17 <> 0.00 Then //Diferen$$HEX1$$e700$$ENDHEX$$a 17
							If lds_Produtos.object.totalitem[ll_row] > 0 And lds_Produtos.object.totalitem[ll_row] > Abs(lvdc_dif_17) Then
								lvdc_Aux = lvdc_dif_17
								lds_Produtos.object.totalitem[ll_row] = lds_Produtos.object.totalitem[ll_row] + lvdc_dif_17
								lvdc_dif_17 -= lvdc_Aux
								lvdc_dif_tributado -= lvdc_Aux
							End If
						End If
					Case 25
						If lvdc_dif_25 <> 0.00 Then //Diferen$$HEX1$$e700$$ENDHEX$$a 25
							If lds_Produtos.object.totalitem[ll_row] > 0 And lds_Produtos.object.totalitem[ll_row] > Abs(lvdc_dif_25) Then
								lvdc_Aux = lvdc_dif_25
								lds_Produtos.object.totalitem[ll_row] = lds_Produtos.object.totalitem[ll_row] + lvdc_Aux
								lvdc_dif_25 -= lvdc_Aux
								lvdc_dif_tributado -= lvdc_Aux								
							End If
						End If					
				End Choose
			End If
			
			ls_nome_totalizador = String(Long(lvdc_icms))
			If LenA(ls_nome_totalizador) = 1 Then
				ls_nome_totalizador = 'T0'+ls_nome_totalizador+'00'
			Else
				ls_nome_totalizador = 'T'+ls_nome_totalizador+'00'
			End If
			
			ls_icms = gf_valor_com_ponto(lvdc_icms)			
			
			ll_find    = lds_mapa_aliq.Find ("pc_aliquota = " + ls_icms,1,lds_mapa_aliq.RowCount())
		
			If ll_find > 0 Then
				lvdc_valor_imposto = lds_mapa_aliq.Object.vl_base_calculo [ll_find]
			Else
				If ll_find < 0 Then
					gvo_aplicacao.Of_Grava_Log("Grava$$HEX2$$e700e300$$ENDHEX$$o Arquivo Redu$$HEX2$$e700e300$$ENDHEX$$oZ - Erro no Find de aliquiotas.(of_gera_blocox_reducao).")												
					Return False
				Else
					//N$$HEX1$$e300$$ENDHEX$$o encontrou a aliquota no find, indica que o produto apenas foi cancelado, ent$$HEX1$$e300$$ENDHEX$$o o totalizado da aliquota $$HEX1$$e900$$ENDHEX$$ zero.
					lvdc_valor_imposto = 0.00
				End If
			End If			
			
			If lvdc_icms <> lvdc_icms_ant Then
				If (lvdc_icms_ant = 0 or IsNull(lvdc_icms_ant)) Then  //1$$HEX1$$aa00$$ENDHEX$$ vez
					If (Trim(ls_cst_trib_ant) <> '' And not IsNull(ls_cst_trib_ant)) Then //Tinha produtos sem tributacao antes
						ls_Registro += 	This.of_Fecha_Tag('ProdutosServicos', 6)	+ &					
											This.of_Fecha_Tag('TotalizadorParcial', 5)	+ &
											This.of_Abre_Tag('TotalizadorParcial', 5)					
					End If
					ls_Registro += This.of_Elemento('Nome', ls_nome_totalizador, 6)	+ &
										This.of_Elemento('Valor', String(lvdc_valor_imposto,'####0.00'), 6)	+ &
										This.of_Abre_Tag('ProdutosServicos', 6)
				Else	//precisa fechar tag de totalizador anterior e abrir para o novo
					ls_Registro += 	This.of_Fecha_Tag('ProdutosServicos', 6)	+ &					
										This.of_Fecha_Tag('TotalizadorParcial', 5)	+ &
										This.of_Abre_Tag('TotalizadorParcial', 5)	+ &
										This.of_Elemento('Nome', ls_nome_totalizador, 6)	+ &
										This.of_Elemento('Valor', String(lvdc_valor_imposto,'####0.00'), 6)	+ &
										This.of_Abre_Tag('ProdutosServicos', 6)										
				End If
				
			End If
			
			ls_Registro += This.of_Abre_Tag('Produto', 7)	+ &
								This.of_Elemento('Descricao', ls_descricao, 8)
			If ls_cod_barras = '0' Then
				ls_Registro += This.of_Elemento_Vazio('CodigoGTIN', '', 8)
			Else
				ls_Registro +=	This.of_Elemento('CodigoGTIN', ls_cod_barras, 8)
			End if								
			ls_Registro += This.of_Elemento('CodigoCEST', ls_cest, 8)+ &								
								This.of_Elemento('CodigoNCMSH', ls_ncm, 8)
			If Not IsNull(This.dt_envio_codigo_sap) Then
				If ldt_data_rz >= This.dt_envio_codigo_sap Then
					ls_Registro += This.of_Elemento('CodigoProprio', lds_Produtos.object.cd_produto_sap[ll_row], 8)								
				Else
					ls_Registro += This.of_Elemento('CodigoProprio', String(lds_Produtos.object.cd_produto[ll_row]), 8)								
				End If				
			Else
				ls_Registro += This.of_Elemento('CodigoProprio', String(lds_Produtos.object.cd_produto[ll_row]), 8)												
			End If
			ls_Registro += This.of_Elemento('Quantidade', String(lds_Produtos.object.qtd[ll_row],'####0.000'), 8)		+ &
								This.of_Elemento('Unidade', lds_Produtos.object.cd_unidade_medida_venda[ll_row], 8) + &
								This.of_Elemento('ValorDesconto', String(lds_Produtos.object.totaldesc[ll_row],'####0.00'), 8) + &
								This.of_Elemento('ValorAcrescimo', String(0,'####0.00'), 8) + &
								This.of_Elemento('ValorCancelamento', String(lds_Produtos.object.totalcanc[ll_row],'####0.00'), 8) + &								
								This.of_Elemento('ValorTotalLiquido', String(lds_Produtos.object.totalitem[ll_row],'####0.00'), 8) + &
								This.of_Fecha_Tag('Produto', 7)
								
			lvdc_icms_ant = lvdc_icms			
		End If	
	Next
	
	//Redu$$HEX2$$e700e300$$ENDHEX$$o Z sem movimento, tem que gravar os totalizadores zerados.
	If lds_Produtos.RowCount() = 0 Then
		ls_nome_totalizador = 'F1'  //J$$HEX1$$e100$$ENDHEX$$ abriu TAG antes do FOR
		ls_Registro += This.of_Elemento('Nome', ls_nome_totalizador, 6)	+ &
							This.of_Elemento('Valor', String(0,'####0.00'), 6)	+ &
							This.of_Abre_Tag('ProdutosServicos', 6) + &
							This.of_Fecha_Tag('ProdutosServicos', 6)	+ &					
							This.of_Fecha_Tag('TotalizadorParcial', 5)					
		
		ls_nome_totalizador = 'I1'
		ls_Registro += This.of_Abre_Tag('TotalizadorParcial', 5)	+ &
							This.of_Elemento('Nome', ls_nome_totalizador, 6)	+ &
							This.of_Elemento('Valor', String(0,'####0.00'), 6)	+ &
							This.of_Abre_Tag('ProdutosServicos', 6) + &
							This.of_Fecha_Tag('ProdutosServicos', 6)	+ &					
							This.of_Fecha_Tag('TotalizadorParcial', 5)					
		
		ls_nome_totalizador = 'N1'		
		ls_Registro += This.of_Abre_Tag('TotalizadorParcial', 5)	+ &
							This.of_Elemento('Nome', ls_nome_totalizador, 6)	+ &
							This.of_Elemento('Valor', String(0,'####0.00'), 6)	+ &
							This.of_Abre_Tag('ProdutosServicos', 6) + &
							This.of_Fecha_Tag('ProdutosServicos', 6)	+ &					
							This.of_Fecha_Tag('TotalizadorParcial', 5)		
							
		//Busca aliquotas ICMS na base
		dc_uo_ds_base lds_aliquotas
		lds_aliquotas = Create dc_uo_ds_base

		If Not lds_aliquotas.of_ChangeDataObject('ds_ge039_aliquota_ecf') Then 
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o foi possivel ler aliquotas para Redu$$HEX2$$e700e300$$ENDHEX$$o sem movimento.",StopSign!)
			gvo_aplicacao.Of_Grava_Log("Grava$$HEX2$$e700e300$$ENDHEX$$o Arquivo Redu$$HEX2$$e700e300$$ENDHEX$$oZ - Erro ao buscar al$$HEX1$$ed00$$ENDHEX$$quotas para Redu$$HEX2$$e700e300$$ENDHEX$$o sem movimento.(of_gera_blocox_reducao).")									
			Return False				
		End If			

		lds_aliquotas.of_RestoreSqlOriginal()
		lds_aliquotas.Retrieve(gvo_parametro.ivs_uf_filial)

		For ll_Row = 1 To lds_aliquotas.RowCount()
			lvdc_icms = lds_aliquotas.object.pc_icms [ll_row] + lds_aliquotas.object.pc_fcp [ll_row]			
			
			ls_nome_totalizador = String(Long(lvdc_icms))
			If LenA(ls_nome_totalizador) = 1 Then
				ls_nome_totalizador = 'T0'+ls_nome_totalizador+'00'
			Else
				ls_nome_totalizador = 'T'+ls_nome_totalizador+'00'
			End If
			ls_Registro += This.of_Abre_Tag('TotalizadorParcial', 5)	+ &
								This.of_Elemento('Nome', ls_nome_totalizador, 6)	+ &
								This.of_Elemento('Valor', String(0,'####0.00'), 6)	+ &
								This.of_Abre_Tag('ProdutosServicos', 6) + &
								This.of_Fecha_Tag('ProdutosServicos', 6)	+ &					
								This.of_Fecha_Tag('TotalizadorParcial', 5)					
		Next
		
		Destroy(lds_aliquotas)							
	Else
		ls_Registro += 	This.of_Fecha_Tag('ProdutosServicos', 6)	+ &					
							This.of_Fecha_Tag('TotalizadorParcial', 5)
	End If

	ls_Registro += 	This.of_Fecha_Tag('TotalizadoresParciais', 4)	+ &
						This.of_Fecha_Tag('DadosReducaoZ', 3)	+ &
						This.of_Fecha_Tag('Ecf', 2)	+ &
						This.of_Fecha_tag('Mensagem'	, 1) 				
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o foi possivel ler os produtos das vendas.",StopSign!)
	gvo_aplicacao.Of_Grava_Log("Grava$$HEX2$$e700e300$$ENDHEX$$o Arquivo Redu$$HEX2$$e700e300$$ENDHEX$$oZ - Erro ao carregar os produtos vendidos.(of_gera_blocox_reducao).")							
	Return False				
End If

//ASSINATURA
ls_Registro += This.of_Abre_Tag('Signature xmlns="http://www.w3.org/2000/09/xmldsig#"',1)  + &
					This.of_Abre_Tag('SignedInfo', 2)	+ &
					This.of_Abre_Tag('CanonicalizationMethod Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315"',3) + &
					This.of_Fecha_Tag('CanonicalizationMethod',3) +&
					This.of_Abre_Tag('SignatureMethod Algorithm="http://www.w3.org/2000/09/xmldsig#rsa-sha1"', 3) + &					
					This.of_Fecha_Tag('SignatureMethod',3) +&
					This.of_Abre_Tag('Reference URI=""', 3)	+ &
					This.of_Abre_Tag('Transforms', 4)	+ &
					This.of_Abre_Tag('Transform Algorithm="http://www.w3.org/2000/09/xmldsig#enveloped-signature"', 5)	+ &
					This.of_Fecha_Tag('Transform',5) +&
					This.of_Abre_Tag('Transform Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315"', 5)	+ &
					This.of_Fecha_Tag('Transform',5) +&			
					This.of_Fecha_Tag('Transforms',4) +&
					This.of_Abre_Tag('DigestMethod Algorithm="http://www.w3.org/2000/09/xmldsig#sha1"', 4)	+ &
					This.of_Fecha_Tag('DigestMethod',4) +&
					This.of_Elemento('DigestValue', '', 4)		+ &
					This.of_Fecha_Tag('Reference',3) +&
					This.of_Fecha_Tag('SignedInfo',2) +&										
					This.of_Elemento('SignatureValue', '', 1)	+ &
					This.of_Abre_Tag('KeyInfo', 2)	+ &
					This.of_Abre_Tag('X509Data',3) + &
					This.of_Elemento('X509Certificate', '', 4)		+ &					
					This.of_Fecha_Tag('X509Data',3) +&					
					This.of_Fecha_Tag('KeyInfo',2) +&										
					This.of_Fecha_Tag('Signature', 1)+ &
											 '</ReducaoZ>'	

//Nome do arquivo: Filial(0000) + Sequencial tabela(0000000) + ECF(000) + Qt_RZ(0000) + DataReducao(ddmmyyy)  + datahorageracao(ddmmyyyhhmm)  -  Ex: 0563000002014012126072019260720190800.xml
ldt_data_geracao = gf_getserverdate()
ls_data_hora = String(ldt_data_geracao, 'DDMMYYYY') + String(ldt_data_geracao, 'HHMM')
If This.ivb_padraoh Then
	ls_arquivo = is_Caminho_Arquivo_Xml+'Arquivos - Redu$$HEX2$$e700e300$$ENDHEX$$o Z\' + 'Reducao Z ' + ls_dataRZ + '.xml'
	ls_nome_arquivo = 'Reducao Z ' + ls_dataRZ
	ivs_Arquivo_Xml = is_Caminho_Arquivo_Xml+'Arquivos - Redu$$HEX2$$e700e300$$ENDHEX$$o Z\' + 'Reducao Z ' + ls_dataRZ + '_ORI.xml'	
Else
	ls_arquivo = is_Caminho_Arquivo_Xml+'Arquivos - Redu$$HEX2$$e700e300$$ENDHEX$$o Z\' + String(pl_filial, '0000') + String(pl_sequencial_hist,'0000000') + String(ll_ecf,'000') + ls_qtRZ + ls_dataRZ + ls_data_hora +'.xml'
	ls_nome_arquivo = String(pl_filial, '0000') + String(pl_sequencial_hist,'0000000') +  String(ll_ecf,'000') + ls_qtRZ + ls_dataRZ + ls_data_hora
	ivs_Arquivo_Xml = is_Caminho_Arquivo_Xml+'Arquivos - Redu$$HEX2$$e700e300$$ENDHEX$$o Z\' + String(pl_filial, '0000') + String(pl_sequencial_hist,'0000000') +  String(ll_ecf,'000') + ls_qtRZ + ls_dataRZ + ls_data_hora +'_ORI.xml'	
End If

If FileExists( ls_Arquivo ) Then
	FileDelete( ls_Arquivo )
End If
		 
This.of_abre_arquivo()

This.of_Grava_Arquivo(ls_Registro)

FileClose(ivi_Arquivo_Xml)

Destroy(lds_reducao)
Destroy(lds_Produtos)
Destroy(lds_mapa_aliq)
Destroy(lds_cancelamentos)
If IsValid(lvo_produto) Then Destroy(lvo_produto) 
If IsValid(lvo_Fiscal) Then Destroy(lvo_Fiscal)
If IsValid(lvo_Atributo) Then Destroy(lvo_Atributo)

//Quando terminar os testes Remover essa parte, criar fun$$HEX2$$e700e300$$ENDHEX$$o separada.
ll_retorno = Assinaxml_GeraAssinatura(ls_nome_arquivo, ivs_Arquivo_Xml, is_Caminho_Arquivo_Xml+'Arquivos - Redu$$HEX2$$e700e300$$ENDHEX$$o Z\\')

If ll_retorno = 1 Then
	lb_enviar = True
Else
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Problemas ao assinar o XML de Redu$$HEX2$$e700e300$$ENDHEX$$o Z.", Exclamation! )	
	lb_enviar = False
End If

FileDelete(ivs_Arquivo_Xml)

If lb_enviar Then	
//ANTES DE ENVIAR VERIFICAR PENDENCIAS DESSA ECF E MANDAR TENTAR ENVIAR AS PENDENTES PRIMEIRO	
	dc_uo_zip lo_Zip
	lo_Zip = Create dc_uo_zip
	
	lo_Zip.of_Salva_Estrutura( False )
	ls_Error = lo_Zip.of_Zip( ls_Arquivo, ls_arquivo + '.zip' )
		
	If ls_Error <> "" Then
		MessageBox( 'Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao tentar compactar arquivo ' + ls_Arquivo + '~r~r' + ls_Error, StopSign! )
		lb_enviar = False
	Else
		ls_arquivo = ls_arquivo + '.zip'
	End If

	Destroy(lo_Zip)	
	
//	String ls_teste
//	ls_teste = LoadFileToAnsiStr(ls_arquivo)
	
	If lb_enviar Then
		uo_ge038_ws lo_WS
		lo_WS = Create uo_ge038_ws
		
		If lo_WS.of_enviar( ls_arquivo, ref ls_Retorno ) Then
//		If lo_WS.of_valida( ls_Arquivo, ref ls_Retorno ) Then			
			If lo_WS.of_Trata_Retorno_Geral( ls_Retorno ) > 0 Then
				lo_WS.of_Valor_Retornado( Lower( ls_Retorno ), 'situacaoprocessamentocodigo'		, ref ls_codigo )
				lo_WS.of_Valor_Retornado( Lower( ls_Retorno ), 'situacaoprocessamentodescricao'	, ref ls_situacao )
				lo_WS.of_Valor_Retornado( Lower( ls_Retorno ), 'mensagem'	, ref ls_mensagem )				
				lo_WS.of_Valor_Retornado( Lower( ls_Retorno ), 'recibo'		, ref ls_recibo )			
				
				If ls_codigo = '1' or ls_codigo = '0' Then
					ls_arquivo_retorno = is_Caminho_Arquivo_Xml + ls_nome_arquivo + '_retorno.xml'								
					lo_WS.of_grava_retorno(ls_retorno, ls_arquivo_retorno)				
					ps_recibo = ls_recibo
					ps_situacao = ls_codigo
					lb_sucesso = true
					//MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Arquivo com Informa$$HEX2$$e700f500$$ENDHEX$$es da Redu$$HEX2$$e700e300$$ENDHEX$$o Z do PAF-ECF transmitido com sucesso.", Information! )				
				End If
				If ls_codigo = '2' Then //erro.
					MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no envio do XML de Redu$$HEX2$$e700e300$$ENDHEX$$oZ.~r~r" +&
									  "Codigo: " + ls_codigo + " Mensagem: " + ls_mensagem, Exclamation! )
					lb_sucesso = False
				End If
				
			End If					
		Else
			lb_sucesso = False
		End If	
		Destroy(lo_WS)
	End If
Else
	lb_sucesso = False	
End If

If lb_sucesso Then
	Return True
Else
	Return False
End If

end function

public function boolean of_gera_blocox_reducao_matriz (long pl_filial, long pl_mapa, date pdt_data_fiscal, long pl_ecf, long pl_seq_historico, string ps_diretorio, string ps_inscricao, ref string ps_erro);//FUN$$HEX2$$c700c300$$ENDHEX$$O QUE MONTA O ARQUIVO XML DO BLOCO X REDUCA$$HEX2$$c700c300$$ENDHEX$$O Z
//ALTERA$$HEX2$$c700d500$$ENDHEX$$ES NA ESTRUTURA DO ARQUIVO DEVEM SER FEISTA AQUI E NAS OUTRA DUAS FUN$$HEX2$$c700d500$$ENDHEX$$ES QUE GERAM O ARQUIVO

String ls_Registro, &
		 ls_ins_est, &
		 ls_cst_trib, &
		 ls_cst_trib_ant, &
		 ls_nome_totalizador, &
		 ls_icms, &
		 ls_qtRZ, &
		 ls_dataRZ, &
		 ls_nome_arquivo,&
		 ls_arquivo, &
		 ls_retorno, &
		 ls_codigo, &
		 ls_cod_barras, &
		 ls_mensagem, &
		 ls_arquivo_retorno, &
		 ls_recibo, &
		 ls_cest, &
		 ls_ncm, &
		 ls_erro, &
		 ls_situacao, &
		 ls_CPD, &
		 ls_descricao,  &
		 ls_data_hora, &
		 ls_serie_mapa, &
		 ls_especie_mapa, &
		 ls_enviado = 'N'		 
		 
Long ll_ecf, &
		ll_retorno, &
		ll_row, &
		ll_Row_canc, &
		ll_mapa, &
		ll_find, &
		ll_filial, &
		ll_qt_reducao, &
		ll_produto, &
		ll_nova_linha, &
		ll_count_F1, &
		ll_count_I1, &
		ll_count_N1, &
		ll_count_trib, &
		ll_qt_redz_ant,&
		ll_qt_redz_multipla,&
		ll_mapa_ant,&
		ll_coo_inicial,&
		ll_coo_final
		
Decimal {2} lvdc_venda_bruta, &
			 	lvdc_total_F1, &
				lvdc_total_I1, &
				lvdc_total_N1, &
				lvdc_icms, &
				lvdc_icms_ant, &
				lvdc_valor_imposto, &
				lvdc_cancelamento_mapa, &
				lvdc_desconto_mapa, &
				lvdc_total_item_canc, &
				lvdc_Sum_Cancelamento, &
				lvdc_Sum_Desconto, &
				lvdc_Sum_Itens, &
				lvdc_Sum_Aliquotas, &
				lvdc_Sum_Aliq17, &
				lvdc_Sum_Aliq25, &				
				lvdc_dif_cancelamento, &
				lvdc_dif_venda_liquida, &
				lvdc_dif_desconto, &
				lvdc_Aux, &
				lvdc_sum_i1, &
				lvdc_sum_n1, &
				lvdc_sum_f1, &
				lvdc_sum_17, &
				lvdc_sum_25, &
				lvdc_sum_tributado, &
				lvdc_dif_i1, &
				lvdc_dif_n1, &
				lvdc_dif_f1, &
				lvdc_dif_tributado, &
				lvdc_dif_17, &
				lvdc_dif_25, &
				lvdc_divisao_dif,&
				lvdc_gt_inicial_ant,&
				lvdc_gt_final_ant,&				
				lvdc_dif_limite, &
				lvdc_venda_bruta_mapa, &
				lvdc_dif_bruta
				
Boolean lb_Sucesso
Boolean lb_ordena
Boolean lb_multipla_reducao
				
DateTime ldt_data_geracao
Date ldt_reducao


dc_uo_api lo_api
lo_api = Create dc_uo_api

lo_api.of_create_directory(ps_diretorio+ '\Enviados')

Destroy(lo_api)					

ll_filial = pl_filial
ll_ecf = pl_ecf
lvdc_dif_limite = 0.50

//Verifica se tem mais de uma redu$$HEX2$$e700e300$$ENDHEX$$oZ para o mesmo dia
dc_uo_ds_base lds_Reducao_multipla
lds_Reducao_multipla  = Create dc_uo_ds_base

If Not lds_Reducao_multipla.of_ChangeDataObject('ds_ge038_pafecf_multipla_reducao') Then 
	ps_erro = "Erro carregar dados da ds_ge038_pafecf_multipla_reducao."
	Return False
End If

ll_Retorno = lds_Reducao_multipla.Retrieve(ll_filial,ll_ecf,pdt_data_fiscal,pdt_data_fiscal)

If ll_Retorno <> -1 Then
	If ll_retorno > 1 Then //Encontrada mais de uma redu$$HEX2$$e700e300$$ENDHEX$$o para o mesmo dia
		lb_multipla_reducao = True	
		
		select qt_reducao_z 
			into :ll_qt_redz_multipla
		from historico_envio_arquivo_paf
			where cd_filial = :ll_filial
				and nr_sequencial = :pl_seq_historico
		Using SqlCa;
		
		If Sqlca.SqlCode = -1 Then
			Sqlca.of_LogDbError(gvo_Aplicacao.ivi_Log,"Localiza$$HEX2$$e700e300$$ENDHEX$$o do Historico envio")
			Return False
		Else
			If ll_qt_redz_multipla = 0 Or IsNull(ll_qt_redz_multipla) Then
				ps_erro = "Erro carregar historico da redu$$HEX2$$e700e300$$ENDHEX$$o z multipla."
				Return False
			End If
		End If	
		
		ll_find = lds_Reducao_multipla.Find ("qt_reducao_z = " + STRING( ll_qt_redz_multipla ), 1 ,lds_Reducao_multipla.RowCount())				
		If ll_find > 0 Then
			ls_especie_mapa = lds_Reducao_multipla.Object.de_especie[ll_find]
			ls_serie_mapa = lds_Reducao_multipla.Object.de_serie[ll_find]
		Else
			ps_erro = "Erro no FIND da redu$$HEX2$$e700e300$$ENDHEX$$o z multipla."
			Return False			
		End If		
		ll_find = 0
	End If
Else
	ps_erro = "Erro ao buscar dados de multiplas redu$$HEX2$$e700f500$$ENDHEX$$es."
	Return False						
End If
			 
ls_ins_est			= gf_replace(ps_inscricao, '.', '', 0)
ls_ins_est			= gf_replace(ls_ins_est, '/', '', 0)
ls_ins_est			= gf_replace(ls_ins_est, '-', '', 0)

//cabe$$HEX1$$e700$$ENDHEX$$alho, dados da loja e sistema
ls_Registro = '<?xml version="1.0" encoding="UTF-8"?>' + ivs_Enter 							+ &
					'<ReducaoZ Versao="1.0">' + ivs_Enter 												+ &
					This.of_Abre_Tag('Mensagem', 1)														+ &					
					This.of_Abre_Tag('Estabelecimento', 2)												+ &
					This.of_Elemento('Ie', ls_ins_est, 3)													+ &
					This.of_Fecha_tag('Estabelecimento', 2)												+ &					
					This.of_Abre_Tag('PafEcf', 2)															+ &
					This.of_Elemento('NumeroCredenciamento', is_numero_credenciamento, 3)+ &
					This.of_Fecha_tag('PafEcf', 2)

This.ivl_filial = ll_filial
If Not This.of_Carrega_dados_ecf(ll_ecf) Then
	ps_erro = "Erro carregar dados do ECF."
	Return False
End If				

String ls_serie_mfd
ls_serie_mfd = This.nr_serie_mfd

If 	(ll_filial = 301 And ll_ecf = 4) Or &
	(ll_filial = 592 And ll_ecf = 3) Or &
 	(ll_filial = 702 And ll_ecf = 2) Or &
	(ll_filial = 811 And ll_ecf = 4) Or &
	(ll_filial = 820 And ll_ecf = 1) Or &
	(ll_filial = 877 And ll_ecf = 4) Or &
	(ll_filial = 890 And ll_ecf = 4) Or &
	(ll_filial = 921 And ll_ecf = 2) Then
	If LenA(ls_serie_mfd) = 20 Then
		ls_serie_mfd = ls_serie_mfd + 'A'
	End If
End If

ls_Registro += This.of_Abre_Tag('Ecf', 2)	+ &									   	
					This.of_Elemento('NumeroFabricacao', ls_serie_mfd, 3)

//Dados ReducaoZ
dc_uo_ds_base lds_Reducao
lds_Reducao  = Create dc_uo_ds_base

If Not lds_Reducao.of_ChangeDataObject('ds_ge038_pafecf_reducaoz_matriz') Then 
	ps_erro = "Erro carregar dados da ds_ge038_pafecf_reducaoz_matriz."
	Return False
End If

If lb_multipla_reducao Then
	lds_Reducao.of_AppendWhere("mapa_resumo_ecf.qt_reducao_z = " + String(ll_qt_redz_multipla))
End If

ll_Retorno = lds_Reducao.Retrieve(ll_filial, pl_mapa, ll_ecf,pdt_data_fiscal,pdt_data_fiscal)

If ll_Retorno <> -1 Then
	
	If lds_Reducao.RowCount() = 0 Then
		ps_erro = "Sem dados de mapa resumo da redua$$HEX2$$e700e300$$ENDHEX$$oZ."
		Return False
	End If
	
	lvdc_venda_bruta 	= lds_Reducao.object.vl_total_geral_final[1] - lds_Reducao.object.vl_total_geral_inicial[1]//  - lds_Reducao.object.vl_cancelamento[1]
	lvdc_total_F1 		= lds_Reducao.object.vl_st[1]
	lvdc_total_I1 		= lds_Reducao.object.vl_isenta[1]	
	lvdc_total_N1 		= lds_Reducao.object.vl_nao_incidencia[1]
	lvdc_cancelamento_mapa = lds_Reducao.object.vl_cancelamento[1]
	lvdc_desconto_mapa = lds_Reducao.object.vl_desconto[1]
	ll_mapa				= lds_Reducao.object.nr_mapa[1]
	ll_qt_reducao		= lds_Reducao.object.qt_reducao_z[1]
	ls_qtRZ				= String(lds_Reducao.object.qt_reducao_z[1],'0000')
	ls_dataRZ			= String(lds_Reducao.object.dh_emissao[1],'ddmmyyyy')
	ldt_reducao			= Date(lds_Reducao.object.dh_emissao[1])
	ll_coo_inicial		= lds_Reducao.object.nr_operacao_inicial[1]
	ll_coo_final			= lds_Reducao.object.nr_operacao_final[1]
	
	ls_Registro += This.of_Abre_Tag('DadosReducaoZ', 3)	+ &
						This.of_Elemento('DataReferencia', String(lds_Reducao.object.dh_emissao[1],'yyyy-mm-dd'), 4)	+ &
						This.of_Elemento('DataHoraEmissao', String(lds_Reducao.object.dh_reducao[1],'yyyy-mm-ddThh:mm:ss'), 4)	+ &						
						This.of_Elemento('CRZ', String(lds_Reducao.object.qt_reducao_z[1],'0000'), 4)								+ &					
						This.of_Elemento('COO', String(lds_Reducao.object.nr_operacao_final[1],'000000000'), 4)					+ &
						This.of_Elemento('CRO', String(lds_Reducao.object.qt_reinicio_z[1],'000'), 4)									+ &
						This.of_Elemento('VendaBrutaDiaria', This.of_Formata_Valor_PafEcf(lvdc_venda_bruta,12,2), 4)			+ &
						This.of_Elemento('GT', This.of_Formata_Valor_PafEcf(lds_Reducao.object.vl_total_geral_final[1],16,2), 4)

	//Busca GTs do dia anterior e contador de reducao z
	If lds_Reducao.object.dh_emissao[1] > dt_inicio_blocox Then
		select me.nr_mapa, me.vl_total_geral_inicial, me.vl_total_geral_final, me.qt_reducao_z 
			into :ll_mapa_ant,:lvdc_gt_inicial_ant, :lvdc_gt_final_ant, :ll_qt_redz_ant
		from mapa_resumo_ecf me
			inner join mapa_resumo mr
				on  mr.cd_filial = me.cd_filial
			    and mr.nr_mapa = me.nr_mapa
				and mr.de_especie = me.de_especie
				and mr.de_serie = me.de_serie
				and mr.dh_emissao >= :dt_inicio_blocox
			where me.cd_filial = :ll_filial
				and me.nr_ecf = :pl_ecf
				and me.qt_reducao_z = :ll_qt_reducao - 1
		Using SqlCa;
		
		Choose Case Sqlca.SqlCode		
			Case -1		
				Sqlca.of_LogDbError(gvo_Aplicacao.ivi_Log,"Localiza$$HEX2$$e700e300$$ENDHEX$$o do Mapa Resumo ECF anterior")
				Return False
			Case 0
				If lvdc_gt_final_ant <> lds_Reducao.object.vl_total_geral_inicial[1] Then
					//GT Final anterior diferente do GT inicial 
					ls_erro = "XML n$$HEX1$$e300$$ENDHEX$$o gerado. GT Final anterior(" + String(lvdc_gt_final_ant, '0.00')  +  ") diferente do GT inicial atual(" + String(lds_Reducao.object.vl_total_geral_inicial[1],'0.00') + ")."
					This.of_atualiza_historico_erro( ll_filial, pl_seq_historico, ls_erro)
					Return False
				End If
				If (ll_qt_redz_ant + 1) <> lds_Reducao.object.qt_reducao_z[1] Then
					//Contador de reducaoz diferente do esperado
					ls_erro = "Contador de reducaoz atual diferente do esperado. Atual " + String(lds_Reducao.object.qt_reducao_z[1]) + " Anterior: " + String(ll_qt_redz_ant)
					This.of_atualiza_historico_erro( ll_filial, pl_seq_historico, ls_erro)
					Return False
				End If			
			Case 100
				//N$$HEX1$$e300$$ENDHEX$$o achou, n$$HEX1$$e300$$ENDHEX$$o faz a verifica$$HEX2$$e700e300$$ENDHEX$$o		
				//Verificar se tratar pulo de contador de redu$$HEX2$$e700e300$$ENDHEX$$oZ
		End choose		
	End If		
						
Else
	ps_erro = "Erro ao buscar dados da redua$$HEX2$$e700e300$$ENDHEX$$oZ."
	Return False				
End If

//Busca dados de aliquotas
dc_uo_ds_base lds_mapa_aliq
lds_mapa_aliq  = Create dc_uo_ds_base

If Not lds_mapa_aliq.of_ChangeDataObject('ds_ge038_pafecf_resumo_ecf_aliq') Then 
	ps_erro = "Erro carregar dados da ds_ge038_pafecf_resumo_ecf_aliq."
	Return False
End If

If lb_multipla_reducao Then
	lds_mapa_aliq.of_AppendWhere("de_serie = '" + ls_serie_mapa + "'")	
	lds_mapa_aliq.of_AppendWhere("de_especie = '" + ls_especie_mapa + "'")	
End If

lds_mapa_aliq.of_AppendWhere("cd_filial = " + String(ll_filial))

ll_Retorno = lds_mapa_aliq.Retrieve(ll_mapa, ll_ecf)

If ll_Retorno = -1 Then
	ps_erro = "Erro ao buscar al$$HEX1$$ed00$$ENDHEX$$quotas do mapa resumo. " +lds_mapa_aliq.itr_transacao.is_lasterrortext
	Return False				
End If

lvdc_Sum_Aliquotas 	= lds_mapa_aliq.GetItemDecimal(lds_mapa_aliq.RowCount(), "sum_base_calculo")
lvdc_Sum_Aliq17		= lds_mapa_aliq.GetItemDecimal(lds_mapa_aliq.RowCount(), "sum_aliq_17")
lvdc_Sum_Aliq25		= lds_mapa_aliq.GetItemDecimal(lds_mapa_aliq.RowCount(), "sum_aliq_25")

lvdc_venda_bruta_mapa = lvdc_total_F1 + lvdc_total_I1 + lvdc_total_N1 + lvdc_cancelamento_mapa + lvdc_desconto_mapa + lvdc_Sum_Aliquotas
lvdc_dif_bruta = lvdc_venda_bruta - lvdc_venda_bruta_mapa
If Abs(lvdc_dif_bruta) > 100 Then
	//verificar
Else
	lvdc_cancelamento_mapa = lvdc_cancelamento_mapa + lvdc_dif_bruta		
End If

//Dados de totalizadores
dc_uo_ds_base lds_Produtos
lds_Produtos  = Create dc_uo_ds_base

If Not lds_Produtos.of_ChangeDataObject('ds_ge038_pafecf_produto_cupom_aliquota') Then 
	ps_erro = "Erro carregar dados da ds_ge038_pafecf_produto_cupom_aliquota."
	Return False
End If

If lb_multipla_reducao Then
	lds_Produtos.of_AppendWhere("v.nr_coo_ecf >= " + String(ll_coo_inicial))	
	lds_Produtos.of_AppendWhere("v.nr_coo_ecf <= " + String(ll_coo_final))	
End If

lds_Produtos.of_AppendWhere("i.cd_filial = " + String(ll_filial))

ll_Retorno = lds_Produtos.Retrieve(ll_ecf,pdt_data_fiscal,pdt_data_fiscal)

If ll_Retorno <> -1 Then	
	
	//Dados produto cancelados  **********
	dc_uo_ds_base lds_cancelamentos
	lds_cancelamentos  = Create dc_uo_ds_base
	
	If Not lds_cancelamentos.of_ChangeDataObject('ds_ge038_pafecf_produto_cancelado_blocox') Then 
		ps_erro = "Erro carregar dados da ds_ge038_pafecf_produto_cancelado_blocox."
		Return False				
	End If
	
	ll_Retorno = lds_cancelamentos.Retrieve(pl_filial, ll_ecf,pdt_data_fiscal,pdt_data_fiscal)
	
	If ll_Retorno <> -1 Then
		//If lb_multipla_reducao and ls_serie_mapa = '1' Then
			If lds_cancelamentos.RowCount() > 0 Then
				lvdc_Sum_Cancelamento = lds_cancelamentos.GetItemDecimal(lds_cancelamentos.RowCount(), "sum_total_cancelado")
				lvdc_dif_cancelamento = lvdc_cancelamento_mapa - lvdc_Sum_Cancelamento
				If Abs(lvdc_dif_cancelamento) = lvdc_Sum_Cancelamento Then //diferen$$HEX1$$e700$$ENDHEX$$a igual a soma do grid, indica que no ECF n$$HEX1$$e300$$ENDHEX$$o registrou cancelamento
					ps_erro = "Existe cancelamento registrado no Sistema e n$$HEX1$$e300$$ENDHEX$$o na redu$$HEX2$$e700e300$$ENDHEX$$o Z. Filial: "+String(ll_filial) + " ECF: " + String(ll_ecf)  + " Mapa: " + String(pl_mapa) + " Data Fiscal: " + ls_dataRZ + " (of_gera_blocox_reducao_matriz)."								
					ls_erro = "XML n$$HEX1$$e300$$ENDHEX$$o gerado. Cancelamentos registrados no Sistema e n$$HEX1$$e300$$ENDHEX$$o na Redu$$HEX2$$e700e300$$ENDHEX$$o Z."
					This.of_atualiza_historico_erro( ll_filial, pl_seq_historico, ls_erro)								
					Return False
				End If
				
				uo_produto lvo_produto
				lvo_produto = Create uo_produto
				
				uo_Tratamento_Fiscal lvo_Fiscal
				lvo_Fiscal = Create uo_Tratamento_Fiscal
	
				uo_Atributo_Fiscal_Item_NF	 lvo_Atributo
				lvo_Atributo = Create uo_Atributo_Fiscal_Item_NF
				
				lvo_Fiscal.of_Grava_Contribuinte(False)
				lvo_Fiscal.of_Grava_UF_Origem_Destino( 'SC', 'SC')
				lvo_Fiscal.of_Grava_Operacao(lvo_Fiscal.VENDA)	
				
				If lvdc_dif_cancelamento <> 0.00 Then
					lvdc_divisao_dif = lvdc_dif_cancelamento / lds_cancelamentos.RowCount()
				End if
				For ll_Row_canc = 1 To lds_cancelamentos.RowCount()
					If lvdc_dif_cancelamento <> 0.00 Then							
						//Se for o $$HEX1$$fa00$$ENDHEX$$ltimo item a diferen$$HEX1$$e700$$ENDHEX$$a ser$$HEX1$$e100$$ENDHEX$$ o restante
						If ll_Row_canc = lds_cancelamentos.RowCount() Then
							If lvdc_dif_cancelamento > 0.00 Then
								lvdc_Aux = lvdc_dif_cancelamento
							Else
								If lds_cancelamentos.Object.total_cancelado[ll_row_Canc] > Abs(lvdc_dif_cancelamento) Then
									lvdc_Aux = lvdc_dif_cancelamento
								Else
									ps_erro = "N$$HEX1$$e300$$ENDHEX$$o foi possivel dividir a diferen$$HEX1$$e700$$ENDHEX$$a de cancelamento entre os itens. Filial: "+String(ll_filial) + " ECF: " + String(ll_ecf)  + " Mapa: " + String(pl_mapa) + " Data Fiscal: " + ls_dataRZ + " (of_gera_blocox_reducao_matriz)."								
									ls_erro = "XML n$$HEX1$$e300$$ENDHEX$$o gerado. N$$HEX1$$e300$$ENDHEX$$o foi possivel dividir a diferen$$HEX1$$e700$$ENDHEX$$a de cancelamento entre os itens."
									This.of_atualiza_historico_erro( ll_filial, pl_seq_historico, ls_erro)								
									Return False							
								End If
							End If
						Else
							If lvdc_divisao_dif > 0.00 Then
								lvdc_Aux = lvdc_divisao_dif
							Else  
								//Verifica se o valor do item n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ suficiente, deixa o item com 1 centavo e o resto tira da diferen$$HEX1$$e700$$ENDHEX$$a.
								If lds_cancelamentos.Object.total_cancelado[ll_row_Canc] <= Abs(lvdc_dif_cancelamento) Then
									If lds_cancelamentos.Object.total_cancelado[ll_row_Canc] > 0.01 Then
										lvdc_Aux = 0.01 - lds_cancelamentos.Object.total_cancelado[ll_row_Canc]
									Else
										lvdc_Aux = 0.00
									End If
								Else
									lvdc_Aux = lvdc_dif_cancelamento
								End If
							End If
						End If					
						lds_cancelamentos.Object.total_cancelado[ll_row_Canc] = lds_cancelamentos.Object.total_cancelado[ll_row_Canc] + lvdc_Aux
						lvdc_dif_cancelamento -= lvdc_Aux
					End If				
					
					ll_produto = lds_cancelamentos.object.cd_produto[ll_Row_canc]
					ll_find    = lds_Produtos.Find ("cd_produto = " + STRING( ll_produto ), 1 ,lds_Produtos.RowCount())				
					If ll_find > 0 Then
						lds_Produtos.Object.TotalCanc[ll_find] = lds_cancelamentos.Object.total_cancelado[ll_row_Canc]			
					Else
						If ll_find = 0 Then  //N$$HEX1$$e300$$ENDHEX$$o encontrou, incluir no grid produtos
							//Busca Tributacao
							lvo_Produto.of_Localiza_Codigo_Interno(ll_Produto) 			
							If Not lvo_Produto.Localizado Then
								ps_erro = "Erro ao buscar dados do produto cancelado.(of_gera_blocox_reducao_matriz)."
								Return False				
							End If
							
							lvo_Atributo = lvo_Fiscal.of_Atributo_Fiscal_Produto(lvo_Produto)						
							If Not lvo_Atributo.Localizado Then
								ps_erro = "Os atributos fiscais do produto cancelado " + String(ll_Produto) + " n$$HEX1$$e300$$ENDHEX$$o foram localizados.(of_gera_blocox_reducao_matriz)."								
								Return False
							End If
							
							ll_nova_linha = lds_produtos.InsertRow(0)
							lds_produtos.object.cd_produto					[ll_nova_linha] = lds_cancelamentos.object.cd_produto[ll_Row_canc]
							lds_produtos.object.de_produto					[ll_nova_linha] = lds_cancelamentos.object.de_produto[ll_Row_canc]
							lds_produtos.object.cd_unidade_medida_venda[ll_nova_linha] = lds_cancelamentos.object.cd_unidade_medida_venda[ll_Row_canc]
							lds_produtos.object.de_codigo_barras			[ll_nova_linha] = lds_cancelamentos.object.de_codigo_barras[ll_Row_canc]						
							lds_produtos.object.cd_cest							[ll_nova_linha] = lds_cancelamentos.object.cd_cest[ll_Row_canc]
							lds_produtos.object.nr_classificacao_fiscal		[ll_nova_linha] = lds_cancelamentos.object.nr_classificacao_fiscal[ll_Row_canc]
							lds_produtos.object.pc_icms						[ll_nova_linha] = lvo_atributo.pc_icms
							lds_produtos.object.cd_cst_tributacao			[ll_nova_linha] = RightA(lvo_atributo.cd_situacao_tributaria,1) + '0'
							lds_produtos.object.cd_produto_sap				[ll_nova_linha] = lds_cancelamentos.object.cd_produto_sap[ll_Row_canc]							
							lds_produtos.object.qtd								[ll_nova_linha] = 0   //????????
							lds_produtos.object.totalitem						[ll_nova_linha] = 0
							lds_produtos.object.Totaldesc						[ll_nova_linha] = 0
							lds_produtos.object.TotalCanc						[ll_nova_linha] = lds_cancelamentos.object.total_cancelado[ll_Row_canc]
							lb_ordena = True
						Else			
							ps_erro = "Erro find do produto: " + String(ll_Produto) + ".(of_gera_blocox_reducao_matriz)."
							Return False
						End If
					End If	
				Next
				If lb_ordena Then
					lds_produtos.SetSort("i.pc_icms, i.cd_cst_tributacao")
					lds_produtos.Sort()				
				End If
			Else
				If lvdc_cancelamento_mapa > 0 Then
					ps_erro = "Cancelamento registrado na RZ e n$$HEX1$$e300$$ENDHEX$$o no sistema. Filial: "+String(ll_filial) + " ECF: " + String(ll_ecf)  + " Mapa: " + String(pl_mapa) + " Data Fiscal: " + ls_dataRZ + "(of_gera_blocox_reducao_matriz)."
					Return False											
				End If			
			End If		
		//End If
	Else
		ps_erro = "Erro ao carregar os produtos cancelados. " + lds_cancelamentos.itr_transacao.is_lasterrortext
		Return False							
	End If	
	//Fim produtos cancelados			
	
	ls_Registro += This.of_Abre_Tag('TotalizadoresParciais', 4)	+ &
						This.of_Abre_Tag('TotalizadorParcial', 5)		

	For ll_Row = 1 To lds_Produtos.RowCount()
		If ll_Row = 1 Then //Verifica diferen$$HEX1$$e700$$ENDHEX$$as
			lvdc_Sum_Itens 			= lds_Produtos.GetItemDecimal(lds_Produtos.RowCount(), "sum_totalitem")
			lvdc_Sum_Desconto 		= lds_Produtos.GetItemDecimal(lds_Produtos.RowCount(), "sum_totaldesc")
			
			lvdc_dif_venda_liquida 	= (lvdc_total_F1 + lvdc_total_I1 + lvdc_total_N1 + lvdc_Sum_Aliquotas) - lvdc_Sum_Itens
			lvdc_dif_desconto = lvdc_desconto_mapa - lvdc_Sum_Desconto
			If lvdc_dif_venda_liquida <> 0.00  Or lvdc_dif_desconto <> 0.00 Then
				If Abs(lvdc_dif_venda_liquida) > lvdc_dif_limite Or Abs(lvdc_dif_desconto) > lvdc_dif_limite Then //diferen$$HEX1$$e700$$ENDHEX$$a maior que 0,50 n$$HEX1$$e300$$ENDHEX$$o continua
					ps_erro = "Valor de diferen$$HEX1$$e700$$ENDHEX$$a na venda liquida e desconto supera o limite permitido. Filial: "+String(ll_filial) + " ECF: " + String(ll_ecf)  + " Mapa: " + String(pl_mapa) + " Data Fiscal: " + ls_dataRZ + "(of_gera_blocox_reducao_matriz)."
					ls_erro = "XML n$$HEX1$$e300$$ENDHEX$$o gerado. Valor de diferen$$HEX1$$e700$$ENDHEX$$a na venda liquida ou desconto supera o limite permitido. Diferen$$HEX1$$e700$$ENDHEX$$a venda: " + String(lvdc_dif_venda_liquida, '0.00') + ". Diferen$$HEX1$$e700$$ENDHEX$$a Desconto: " + String(lvdc_dif_desconto, '0.00')
					This.of_atualiza_historico_erro( ll_filial, pl_seq_historico, ls_erro)										
					Return False
				End If		
				//Busca totais por Situacao
				lvdc_sum_i1 			= lds_Produtos.GetItemDecimal(ll_find, "sum_grupo_i1")
				lvdc_dif_i1 				= lvdc_total_I1 - lvdc_sum_i1							
				lvdc_sum_n1 			= lds_Produtos.GetItemDecimal(ll_find, "sum_grupo_n1")
				lvdc_dif_n1 				= lvdc_total_N1 - lvdc_sum_n1
				lvdc_sum_f1 			= lds_Produtos.GetItemDecimal(ll_find, "sum_grupo_f1")
				lvdc_dif_f1				= lvdc_total_F1 - lvdc_sum_f1				
				lvdc_sum_17 			= lds_Produtos.GetItemDecimal(ll_find, "sum_grupo_17")
				lvdc_dif_17 				= lvdc_Sum_Aliq17 - lvdc_sum_17
				lvdc_sum_25 			= lds_Produtos.GetItemDecimal(ll_find, "sum_grupo_25")				
				lvdc_dif_25 				= lvdc_Sum_Aliq25 - lvdc_sum_25
				lvdc_sum_tributado	= lvdc_sum_17 + lvdc_sum_25
				lvdc_dif_tributado 		= lvdc_Sum_Aliquotas - lvdc_sum_tributado
			End If
		End If
		
		If IsNull(lds_Produtos.Object.cd_cest[ll_Row]) Or Trim(lds_Produtos.Object.cd_cest[ll_Row]) = '' Then
			ls_cest = '0000000'
		Else
			ls_cest = lds_Produtos.Object.cd_cest[ll_Row]
		End If			
		If IsNull(String(lds_Produtos.Object.nr_classificacao_fiscal[ll_Row],'00000000')) Then	
			ls_ncm = '00000000'
		Else
			ls_ncm = String(lds_Produtos.Object.nr_classificacao_fiscal[ll_Row],'00000000')
		End If
		//****TRATAMENTO PARA HOMOLOGACAO****** RETIRAR PARA PRODUCAO
		//		NCMs 34011190, 34011900, 34011900, 34012010 e 34013000 aceitar$$HEX1$$e300$$ENDHEX$$o somente os CESTs 2003400, 2003500, 2003501, 2003600, 2003700, 2802000, 2802100, 2802200 e 2802300.
		If ls_ncm = '34011190' or ls_ncm = '34011900' or ls_ncm = '34011900' or ls_ncm = '34012010' or ls_ncm = '34013000' Then
			ls_cest = '2003400'
		End If		
		//****		
		If IsNull(lds_Produtos.object.de_codigo_barras[ll_row]) Or Trim(lds_Produtos.object.de_codigo_barras[ll_row]) = '' Then
			ls_cod_barras = '0'
		Else
			Choose Case lds_Produtos.object.cd_produto[ll_row]    //Tratamentos para produtos "servi$$HEX1$$e700$$ENDHEX$$o" ou produtos inativos
				Case 684431,735582,577625,723786,712055,735909,735947,135570,683845,123060,693844,135562,693843,733631,705965,700495,707440,707439,700118,735001,734997,733159,733164,736956,736957,738063,738062,733651,705861
					ls_cod_barras = '0'
				Case Else
					ls_cod_barras = lds_Produtos.object.de_codigo_barras[ll_row]					
			End Choose		
		End If		
		
		ls_descricao = gf_retira_caracteres_especiais(lds_Produtos.object.de_produto[ll_row])
		ls_cst_trib = Trim(lds_Produtos.object.cd_cst_tributacao[ll_row])
//		 ls_cst_trib_ant
		lvdc_icms = lds_Produtos.object.pc_icms[ll_row]
		//lvdc_icms_ant
		If lvdc_icms = 0 Then  //produto com substituicao, isento, ou sem incidencia
			Choose Case ls_cst_trib
				Case '40'
					ls_nome_totalizador = 'I1'
					lvdc_valor_imposto = lvdc_total_I1					
					If lvdc_dif_i1 <> 0.00 Then //Diferen$$HEX1$$e700$$ENDHEX$$a
						If lds_Produtos.object.totalitem[ll_row] > 0 And lds_Produtos.object.totalitem[ll_row] > Abs(lvdc_dif_i1) Then
							lvdc_Aux = lvdc_dif_i1
							lds_Produtos.object.totalitem[ll_row] = lds_Produtos.object.totalitem[ll_row] + lvdc_Aux
							lvdc_dif_i1 -= lvdc_Aux
						End If
					End If
				Case '41'
					ls_nome_totalizador = 'N1'
					lvdc_valor_imposto = lvdc_total_N1
					If lvdc_dif_n1 <> 0.00 Then //Diferen$$HEX1$$e700$$ENDHEX$$a
						If lds_Produtos.object.totalitem[ll_row] > 0 And lds_Produtos.object.totalitem[ll_row] > Abs(lvdc_dif_n1) Then							
							lvdc_Aux = lvdc_dif_n1
							lds_Produtos.object.totalitem[ll_row] = lds_Produtos.object.totalitem[ll_row] + lvdc_Aux
							lvdc_dif_n1 -= lvdc_Aux
						End If
					End If					
				Case Else
					ls_nome_totalizador = 'F1'
					lvdc_valor_imposto = lvdc_total_F1
					If lvdc_dif_f1 <> 0.00 Then //Diferen$$HEX1$$e700$$ENDHEX$$a
						If lds_Produtos.object.totalitem[ll_row] > 0 And lds_Produtos.object.totalitem[ll_row] > Abs(lvdc_dif_f1) Then
							lvdc_Aux = lvdc_dif_f1
							lds_Produtos.object.totalitem[ll_row] = lds_Produtos.object.totalitem[ll_row] + lvdc_Aux
							lvdc_dif_f1 -= lvdc_Aux
						End If
					End If
					//Diferen$$HEX1$$e700$$ENDHEX$$a de desconto jogo somente aqui
					If lvdc_dif_desconto <> 0.00 And lds_Produtos.object.totaldesc[ll_row] > 0 And lds_Produtos.object.totaldesc[ll_row] > Abs(lvdc_dif_desconto) Then //Diferen$$HEX1$$e700$$ENDHEX$$a DESCONTO
						lvdc_Aux = lvdc_dif_desconto
						lds_Produtos.object.totaldesc[ll_row] = lds_Produtos.object.totaldesc[ll_row] + lvdc_Aux
						lvdc_dif_desconto -= lvdc_Aux
					End If					
					//PARA DIFEREN$$HEX1$$c700$$ENDHEX$$A DESCONTO NEGATIVO 
					/*
					If lvdc_dif_desconto <> 0.00 And lds_Produtos.object.totaldesc[ll_row] > 0 Then
						If lvdc_dif_desconto < 0.00 Then
							If Abs(lvdc_dif_desconto) > lds_Produtos.object.totaldesc[ll_row] Then
								lvdc_Aux = lds_Produtos.object.totaldesc[ll_row]
								lds_Produtos.object.totaldesc[ll_row] = 0
								lvdc_dif_desconto += lvdc_Aux
							Else
								lvdc_Aux = Abs(lvdc_dif_desconto)
								lds_Produtos.object.totaldesc[ll_row] = lds_Produtos.object.totaldesc[ll_row] - Abs(lvdc_dif_desconto)
								lvdc_dif_desconto += lvdc_Aux								
							End If
						Else
							lvdc_Aux = lvdc_dif_desconto
							lds_Produtos.object.totaldesc[ll_row] = lds_Produtos.object.totaldesc[ll_row] + lvdc_Aux
							lvdc_dif_desconto -= lvdc_Aux
						End If
					End If															
					*/
			End Choose
			
			If ls_cst_trib <> ls_cst_trib_ant Then
				If (ls_cst_trib_ant = '' or IsNull(ls_cst_trib_ant)) Then  //1$$HEX1$$aa00$$ENDHEX$$ vez
					ls_Registro += This.of_Elemento('Nome', ls_nome_totalizador, 6)	+ &
										This.of_Elemento('Valor', String(lvdc_valor_imposto,'####0.00'), 6)	+ &
										This.of_Abre_Tag('ProdutosServicos', 6)
				Else	//precisa fechar tag de totalizador anterior e abrir para o novo
					ls_Registro += 	This.of_Fecha_Tag('ProdutosServicos', 6)	+ &					
										This.of_Fecha_Tag('TotalizadorParcial', 5)	+ &
										This.of_Abre_Tag('TotalizadorParcial', 5)	+ &
										This.of_Elemento('Nome', ls_nome_totalizador, 6)	+ &
										This.of_Elemento('Valor', String(lvdc_valor_imposto,'####0.00'), 6)	+ &
										This.of_Abre_Tag('ProdutosServicos', 6)										
				End If
			End If						
			
			ls_Registro += This.of_Abre_Tag('Produto', 7)	+ &
								This.of_Elemento('Descricao', ls_descricao, 8)
								
			If ls_cod_barras = '0' Then
				ls_Registro += This.of_Elemento_Vazio('CodigoGTIN', '', 8)
			Else
				ls_Registro +=	This.of_Elemento('CodigoGTIN', ls_cod_barras, 8)
			End if			
								
			ls_Registro +=	This.of_Elemento('CodigoCEST', ls_cest, 8)+ &
								This.of_Elemento('CodigoNCMSH', ls_ncm, 8)
			If Not IsNull(This.dt_envio_codigo_sap) Then
				If pdt_data_fiscal >= This.dt_envio_codigo_sap Then
					ls_Registro += This.of_Elemento('CodigoProprio', lds_Produtos.object.cd_produto_sap[ll_row], 8)								
				Else
					ls_Registro += This.of_Elemento('CodigoProprio', String(lds_Produtos.object.cd_produto[ll_row]), 8)								
				End If				
			Else
				ls_Registro += This.of_Elemento('CodigoProprio', String(lds_Produtos.object.cd_produto[ll_row]), 8)												
			End If
			ls_Registro += 	This.of_Elemento('Quantidade', String(lds_Produtos.object.qtd[ll_row],'####0.000'), 8)		+ &								
								This.of_Elemento('Unidade', lds_Produtos.object.cd_unidade_medida_venda[ll_row], 8) + &
								This.of_Elemento('ValorDesconto', String(lds_Produtos.object.totaldesc[ll_row],'####0.00'), 8) + &
								This.of_Elemento('ValorAcrescimo', String(0,'####0.00'), 8) + &
								This.of_Elemento('ValorCancelamento', String(lds_Produtos.object.totalcanc[ll_row],'####0.00'), 8) + &								
								This.of_Elemento('ValorTotalLiquido', String(lds_Produtos.object.totalitem[ll_row],'####0.00'), 8) + &								
								This.of_Fecha_Tag('Produto', 7)
			
			ls_cst_trib_ant = ls_cst_trib	
			
		Else		//tributados			
			If lvdc_dif_tributado <> 0.00 Then //Diferen$$HEX1$$e700$$ENDHEX$$a
				Choose Case Long(lvdc_icms)
					Case 17
						If lvdc_dif_17 <> 0.00 Then //Diferen$$HEX1$$e700$$ENDHEX$$a 17
							If lds_Produtos.object.totalitem[ll_row] > 0 And lds_Produtos.object.totalitem[ll_row] > Abs(lvdc_dif_17) Then
								lvdc_Aux = lvdc_dif_17
								lds_Produtos.object.totalitem[ll_row] = lds_Produtos.object.totalitem[ll_row] + lvdc_dif_17
								lvdc_dif_17 -= lvdc_Aux
								lvdc_dif_tributado -= lvdc_Aux
							End If
						End If
					Case 25
						If lvdc_dif_25 <> 0.00 Then //Diferen$$HEX1$$e700$$ENDHEX$$a 25
							If lds_Produtos.object.totalitem[ll_row] > 0 And lds_Produtos.object.totalitem[ll_row] > Abs(lvdc_dif_25) Then
								lvdc_Aux = lvdc_dif_25
								lds_Produtos.object.totalitem[ll_row] = lds_Produtos.object.totalitem[ll_row] + lvdc_Aux
								lvdc_dif_25 -= lvdc_Aux
								lvdc_dif_tributado -= lvdc_Aux								
							End If
						End If					
				End Choose
			End If
			
			ls_nome_totalizador = String(Long(lvdc_icms))
			If LenA(ls_nome_totalizador) = 1 Then
				ls_nome_totalizador = 'T0'+ls_nome_totalizador+'00'
			Else
				ls_nome_totalizador = 'T'+ls_nome_totalizador+'00'
			End If
			
			ls_icms = gf_valor_com_ponto(lvdc_icms)			
			
			ll_find    = lds_mapa_aliq.Find ("pc_aliquota = " + ls_icms,1,lds_mapa_aliq.RowCount())
		
			If ll_find > 0 Then
				lvdc_valor_imposto = lds_mapa_aliq.Object.vl_base_calculo [ll_find]
			Else
				If ll_find < 0 Then
					ps_erro = "Erro no Find de aliquiotas"
					Return False
				Else
					//N$$HEX1$$e300$$ENDHEX$$o encontrou a aliquota no find, indica que o produto apenas foi cancelado, ent$$HEX1$$e300$$ENDHEX$$o o totalizado da aliquota $$HEX1$$e900$$ENDHEX$$ zero.
					lvdc_valor_imposto = 0.00
				End If
			End If			
			
			If lvdc_icms <> lvdc_icms_ant Then
				If (lvdc_icms_ant = 0 or IsNull(lvdc_icms_ant)) Then  //1$$HEX1$$aa00$$ENDHEX$$ vez
					If (Trim(ls_cst_trib_ant) <> '' And not IsNull(ls_cst_trib_ant)) Then //Tinha produtos sem tributacao antes
						ls_Registro += 	This.of_Fecha_Tag('ProdutosServicos', 6)	+ &					
											This.of_Fecha_Tag('TotalizadorParcial', 5)	+ &
											This.of_Abre_Tag('TotalizadorParcial', 5)					
					End If
					ls_Registro += This.of_Elemento('Nome', ls_nome_totalizador, 6)	+ &
										This.of_Elemento('Valor', String(lvdc_valor_imposto,'####0.00'), 6)	+ &
										This.of_Abre_Tag('ProdutosServicos', 6)
				Else	//precisa fechar tag de totalizador anterior e abrir para o novo
					ls_Registro += 	This.of_Fecha_Tag('ProdutosServicos', 6)	+ &					
										This.of_Fecha_Tag('TotalizadorParcial', 5)	+ &
										This.of_Abre_Tag('TotalizadorParcial', 5)	+ &
										This.of_Elemento('Nome', ls_nome_totalizador, 6)	+ &
										This.of_Elemento('Valor', String(lvdc_valor_imposto,'####0.00'), 6)	+ &
										This.of_Abre_Tag('ProdutosServicos', 6)										
				End If
				
			End If
			
			ls_Registro += This.of_Abre_Tag('Produto', 7)	+ &
								This.of_Elemento('Descricao', ls_descricao, 8)
				
			If ls_cod_barras = '0' Then
				ls_Registro += This.of_Elemento_Vazio('CodigoGTIN', '', 8)
			Else
				ls_Registro +=	This.of_Elemento('CodigoGTIN', ls_cod_barras, 8)
			End if
			
			ls_Registro +=	This.of_Elemento('CodigoCEST', ls_cest, 8)+ &
								This.of_Elemento('CodigoNCMSH', ls_ncm, 8)
			If Not IsNull(This.dt_envio_codigo_sap) Then
				If pdt_data_fiscal >= This.dt_envio_codigo_sap Then
					ls_Registro += This.of_Elemento('CodigoProprio', lds_Produtos.object.cd_produto_sap[ll_row], 8)								
				Else
					ls_Registro += This.of_Elemento('CodigoProprio', String(lds_Produtos.object.cd_produto[ll_row]), 8)								
				End If				
			Else
				ls_Registro += This.of_Elemento('CodigoProprio', String(lds_Produtos.object.cd_produto[ll_row]), 8)												
			End If
			ls_Registro += 	This.of_Elemento('Quantidade', String(lds_Produtos.object.qtd[ll_row],'####0.000'), 8)		+ &
								This.of_Elemento('Unidade', lds_Produtos.object.cd_unidade_medida_venda[ll_row], 8) + &
								This.of_Elemento('ValorDesconto', String(lds_Produtos.object.totaldesc[ll_row],'####0.00'), 8) + &
								This.of_Elemento('ValorAcrescimo', String(0,'####0.00'), 8) + &
								This.of_Elemento('ValorCancelamento', String(lds_Produtos.object.totalcanc[ll_row],'####0.00'), 8) + &								
								This.of_Elemento('ValorTotalLiquido', String(lds_Produtos.object.totalitem[ll_row],'####0.00'), 8) + &
								This.of_Fecha_Tag('Produto', 7)
								
			lvdc_icms_ant = lvdc_icms			
		End If	
	Next
	
	//Redu$$HEX2$$e700e300$$ENDHEX$$o Z sem movimento, tem que gravar os totalizadores zerados.
	If lds_Produtos.RowCount() = 0 Then
		ls_nome_totalizador = 'F1'  //J$$HEX1$$e100$$ENDHEX$$ abriu TAG antes do FOR
		ls_Registro += This.of_Elemento('Nome', ls_nome_totalizador, 6)	+ &
							This.of_Elemento('Valor', String(0,'####0.00'), 6)	+ &
							This.of_Abre_Tag('ProdutosServicos', 6) + &
							This.of_Fecha_Tag('ProdutosServicos', 6)	+ &					
							This.of_Fecha_Tag('TotalizadorParcial', 5)					
		
		ls_nome_totalizador = 'I1'
		ls_Registro += This.of_Abre_Tag('TotalizadorParcial', 5)	+ &
							This.of_Elemento('Nome', ls_nome_totalizador, 6)	+ &
							This.of_Elemento('Valor', String(0,'####0.00'), 6)	+ &
							This.of_Abre_Tag('ProdutosServicos', 6) + &
							This.of_Fecha_Tag('ProdutosServicos', 6)	+ &					
							This.of_Fecha_Tag('TotalizadorParcial', 5)					
		
		ls_nome_totalizador = 'N1'		
		ls_Registro += This.of_Abre_Tag('TotalizadorParcial', 5)	+ &
							This.of_Elemento('Nome', ls_nome_totalizador, 6)	+ &
							This.of_Elemento('Valor', String(0,'####0.00'), 6)	+ &
							This.of_Abre_Tag('ProdutosServicos', 6) + &
							This.of_Fecha_Tag('ProdutosServicos', 6)	+ &					
							This.of_Fecha_Tag('TotalizadorParcial', 5)		
							
		//Busca aliquotas ICMS na base
		dc_uo_ds_base lds_aliquotas
		lds_aliquotas = Create dc_uo_ds_base

		If Not lds_aliquotas.of_ChangeDataObject('ds_ge039_aliquota_ecf') Then 
			ps_erro = "Erro ao buscar al$$HEX1$$ed00$$ENDHEX$$quotas para Redu$$HEX2$$e700e300$$ENDHEX$$o sem movimento."
			Return False				
		End If			

		lds_aliquotas.of_RestoreSqlOriginal()
		lds_aliquotas.Retrieve('SC')

		For ll_Row = 1 To lds_aliquotas.RowCount()
			lvdc_icms = lds_aliquotas.object.pc_icms [ll_row] + lds_aliquotas.object.pc_fcp [ll_row]			
			
			ls_nome_totalizador = String(Long(lvdc_icms))
			If LenA(ls_nome_totalizador) = 1 Then
				ls_nome_totalizador = 'T0'+ls_nome_totalizador+'00'
			Else
				ls_nome_totalizador = 'T'+ls_nome_totalizador+'00'
			End If
			ls_Registro += This.of_Abre_Tag('TotalizadorParcial', 5)	+ &
								This.of_Elemento('Nome', ls_nome_totalizador, 6)	+ &
								This.of_Elemento('Valor', String(0,'####0.00'), 6)	+ &
								This.of_Abre_Tag('ProdutosServicos', 6) + &
								This.of_Fecha_Tag('ProdutosServicos', 6)	+ &					
								This.of_Fecha_Tag('TotalizadorParcial', 5)					
		Next
		
		Destroy(lds_aliquotas)							
	Else
		ls_Registro += 	This.of_Fecha_Tag('ProdutosServicos', 6)	+ &					
							This.of_Fecha_Tag('TotalizadorParcial', 5)
	End If	

	ls_Registro += 	This.of_Fecha_Tag('TotalizadoresParciais', 4)	+ &
						This.of_Fecha_Tag('DadosReducaoZ', 3)	+ &
						This.of_Fecha_Tag('Ecf', 2)	+ &
						This.of_Fecha_tag('Mensagem'	, 1) 				
Else
	ps_erro = "Erro ao carregar os produtos vendidos." + lds_produtos.itr_transacao.is_lasterrortext
	Return False				
End If

//ASSINATURA
ls_Registro += This.of_Abre_Tag('Signature xmlns="http://www.w3.org/2000/09/xmldsig#"',1)  + &
					This.of_Abre_Tag('SignedInfo', 2)	+ &
					This.of_Abre_Tag('CanonicalizationMethod Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315"',3) + &
					This.of_Fecha_Tag('CanonicalizationMethod',3) +&
					This.of_Abre_Tag('SignatureMethod Algorithm="http://www.w3.org/2000/09/xmldsig#rsa-sha1"', 3) + &					
					This.of_Fecha_Tag('SignatureMethod',3) +&
					This.of_Abre_Tag('Reference URI=""', 3)	+ &
					This.of_Abre_Tag('Transforms', 4)	+ &
					This.of_Abre_Tag('Transform Algorithm="http://www.w3.org/2000/09/xmldsig#enveloped-signature"', 5)	+ &
					This.of_Fecha_Tag('Transform',5) +&
					This.of_Abre_Tag('Transform Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315"', 5)	+ &
					This.of_Fecha_Tag('Transform',5) +&			
					This.of_Fecha_Tag('Transforms',4) +&
					This.of_Abre_Tag('DigestMethod Algorithm="http://www.w3.org/2000/09/xmldsig#sha1"', 4)	+ &
					This.of_Fecha_Tag('DigestMethod',4) +&
					This.of_Elemento('DigestValue', '', 4)		+ &
					This.of_Fecha_Tag('Reference',3) +&
					This.of_Fecha_Tag('SignedInfo',2) +&										
					This.of_Elemento('SignatureValue', '', 1)	+ &
					This.of_Abre_Tag('KeyInfo', 2)	+ &
					This.of_Abre_Tag('X509Data',3) + &
					This.of_Elemento('X509Certificate', '', 4)		+ &					
					This.of_Fecha_Tag('X509Data',3) +&					
					This.of_Fecha_Tag('KeyInfo',2) +&										
					This.of_Fecha_Tag('Signature', 1)+ &
											 '</ReducaoZ>'	

//Nome do arquivo: Filial(0000) + Sequencial tabela(0000000) + ECF(000) + Qt_RZ(0000) + DataReducao(ddmmyyy)  + datahorageracao(ddmmyyyhhmm)  -  Ex: 0563000002014012126072019260720190800.xml
ldt_data_geracao = gf_getserverdate()
ls_data_hora = String(ldt_data_geracao, 'DDMMYYYY') + String(ldt_data_geracao, 'HHMM')
ls_arquivo = ps_diretorio+'\' + String(ll_filial, '0000') + String(pl_seq_historico,'0000000') + String(ll_ecf,'000') + ls_qtRZ + ls_dataRZ + ls_data_hora +'.xml'

If FileExists( ls_Arquivo ) Then
	FileDelete( ls_Arquivo )
End If

ls_nome_arquivo = String(ll_filial, '0000') + String(pl_seq_historico,'0000000') +  String(ll_ecf,'000') + ls_qtRZ + ls_dataRZ + ls_data_hora

ivs_Arquivo_Xml = ps_diretorio+'\' + String(ll_filial, '0000') + String(pl_seq_historico,'0000000') +  String(ll_ecf,'000') + ls_qtRZ + ls_dataRZ + ls_data_hora + '.xml'
		 
This.of_abre_arquivo()

This.of_Grava_Arquivo(ls_Registro)

FileClose(ivi_Arquivo_Xml)

Destroy(lds_reducao)
Destroy(lds_Produtos)
Destroy(lds_mapa_aliq)
Destroy(lds_cancelamentos)
If IsValid(lvo_produto) Then Destroy(lvo_produto) 
If IsValid(lvo_Fiscal) Then Destroy(lvo_Fiscal)
If IsValid(lvo_Atributo) Then Destroy(lvo_Atributo)

//Atualizar informa$$HEX2$$e700e300$$ENDHEX$$o de gera$$HEX2$$e700e300$$ENDHEX$$o e envio na tabela historico.
If FileExists(ivs_Arquivo_Xml) Then //gerou xml

	If Not This.of_envia_ftp(ps_diretorio+'\', ls_nome_arquivo+'.xml', String( ldt_reducao, 'YYYY' ), String( ldt_reducao, 'MM' ), Ref ps_erro, False) Then			
		ps_erro = ps_erro + ' Erro FTP'
		Return False
	Else		
		FileMove(ls_arquivo, ps_diretorio +'\Enviados\'+ls_nome_arquivo+'.xml')
		ls_enviado = 'S'		
		
		Update historico_envio_arquivo_paf
		Set dh_geracao_arquivo = :ldt_data_geracao,
			 id_enviado_matriz = :ls_enviado,
			 de_descricao_processamento = 'XML GERADO NA MATRIZ',
			 id_situacao = 'P'
		Where cd_filial   = :ll_filial
			and nr_sequencial = :pl_seq_historico
		Using Sqlca;
		
		If Sqlca.Sqlcode = -1 Then
			ps_erro = "Atualiza$$HEX2$$e700e300$$ENDHEX$$o Hitorico PAF. " + SQLCa.is_lasterrortext
			Sqlca.of_Rollback()	
			Return False
		Else
			Sqlca.of_Commit()	
			lb_sucesso = true
		End If			
	End If
Else
	ps_erro = "Arquivo xml n$$HEX1$$e300$$ENDHEX$$o gerado."
	lb_sucesso = False
End If

If lb_sucesso Then
	Return True
Else
	Return False
End If
end function

public function string of_elemento_vazio (string ps_tag, string ps_string, long pl_identacao);String lvs_Retorno

lvs_Retorno = This.of_Identa("<" + ps_Tag + "/>", pl_identacao) + ivs_Enter

Return lvs_Retorno
end function

public function boolean of_gera_xml_consulta (long pl_filial, long pl_qt_rz, date pdt_data_fiscal, long pl_ecf, long pl_seq_historico, string ps_diretorio, string ps_recibo, ref string ps_erro, ref string ps_nome_xml);//FUN$$HEX2$$c700c300$$ENDHEX$$O QUE MONTA O ARQUIVO XML DE CONSULTA PROCESSAMENTO

String ls_Registro, &
		 ls_qtRZ, &
		 ls_dataRZ, &
		 ls_data_hora, &
		 ls_nome_arquivo,&
		 ls_arquivo

Long ll_filial
				
Boolean lb_Sucesso
				
DateTime ldt_data_geracao
Date ldt_reducao

ll_filial = pl_filial		 

//cabe$$HEX1$$e700$$ENDHEX$$alho
ls_Registro = '<?xml version="1.0" encoding="UTF-8"?>' + ivs_Enter 							+ &
					'<Manutencao Versao="1.0">' + ivs_Enter 											+ &
					This.of_Abre_Tag('Mensagem', 1)														+ &
					This.of_Elemento('Recibo', ps_recibo, 2)												+ &
					This.of_Fecha_tag('Mensagem'	, 1)
//ASSINATURA
ls_Registro += This.of_Abre_Tag('Signature xmlns="http://www.w3.org/2000/09/xmldsig#"',1)  + &
					This.of_Abre_Tag('SignedInfo', 2)	+ &
					This.of_Abre_Tag('CanonicalizationMethod Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315"',3) + &
					This.of_Fecha_Tag('CanonicalizationMethod',3) +&
					This.of_Abre_Tag('SignatureMethod Algorithm="http://www.w3.org/2000/09/xmldsig#rsa-sha1"', 3) + &					
					This.of_Fecha_Tag('SignatureMethod',3) +&
					This.of_Abre_Tag('Reference URI=""', 3)	+ &
					This.of_Abre_Tag('Transforms', 4)	+ &
					This.of_Abre_Tag('Transform Algorithm="http://www.w3.org/2000/09/xmldsig#enveloped-signature"', 5)	+ &
					This.of_Fecha_Tag('Transform',5) +&
					This.of_Abre_Tag('Transform Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315"', 5)	+ &
					This.of_Fecha_Tag('Transform',5) +&			
					This.of_Fecha_Tag('Transforms',4) +&
					This.of_Abre_Tag('DigestMethod Algorithm="http://www.w3.org/2000/09/xmldsig#sha1"', 4)	+ &
					This.of_Fecha_Tag('DigestMethod',4) +&
					This.of_Elemento('DigestValue', '', 4)		+ &
					This.of_Fecha_Tag('Reference',3) +&
					This.of_Fecha_Tag('SignedInfo',2) +&										
					This.of_Elemento('SignatureValue', '', 1)	+ &
					This.of_Abre_Tag('KeyInfo', 2)	+ &
					This.of_Abre_Tag('X509Data',3) + &
					This.of_Elemento('X509Certificate', '', 4)		+ &					
					This.of_Fecha_Tag('X509Data',3) +&					
					This.of_Fecha_Tag('KeyInfo',2) +&										
					This.of_Fecha_Tag('Signature', 1)+ &
											 '</Manutencao>'	

//Nome do arquivo: Filial(0000) + Sequencial tabela(0000000) + ECF(000) + Qt_RZ(0000) + DataReducao(ddmmyyy)  + datahorageracao(ddmmyyyhhmm)  -  Ex: 0563000002014012126072019260720190800.xml
ls_qtRZ				= String(pl_qt_rz,'0000')
ls_dataRZ			= String(pdt_data_fiscal,'ddmmyyyy')

ldt_data_geracao = gf_getserverdate()
ls_data_hora = String(ldt_data_geracao, 'DDMMYYYY') + String(ldt_data_geracao, 'HHMM')
ls_arquivo = ps_diretorio+'\' + String(ll_filial, '0000') + String(pl_seq_historico,'0000000') + String(pl_ecf,'000') + ls_qtRZ + ls_dataRZ + ls_data_hora +'_consulta.xml'

If FileExists( ls_Arquivo ) Then
	FileDelete( ls_Arquivo )
End If

ls_nome_arquivo = String(ll_filial, '0000') + String(pl_seq_historico,'0000000') +  String(pl_ecf,'000') + ls_qtRZ + ls_dataRZ + ls_data_hora + '_consulta'

ivs_Arquivo_Xml = ps_diretorio+'\' + String(ll_filial, '0000') + String(pl_seq_historico,'0000000') +  String(pl_ecf,'000') + ls_qtRZ + ls_dataRZ + ls_data_hora + '_consulta.xml'
		 
This.of_abre_arquivo()

This.of_Grava_Arquivo(ls_Registro)

FileClose(ivi_Arquivo_Xml)

//Atualizar informa$$HEX2$$e700e300$$ENDHEX$$o de gera$$HEX2$$e700e300$$ENDHEX$$o e envio na tabela historico.
If FileExists(ivs_Arquivo_Xml) Then //gerou xml
	ps_nome_xml = ls_nome_arquivo
	lb_sucesso = true
Else
	ps_erro = "Arquivo xml de consulta n$$HEX1$$e300$$ENDHEX$$o gerado."
	lb_sucesso = False
End If

If lb_sucesso Then
	Return True
Else
	Return False
End If
end function

public function boolean of_assinar_arquivo (string ps_nome_arquivo_assinado, string ps_arquivo_para_assinar, string ps_caminho_gravar_arquivo_assinado, boolean pb_compactar);String ls_error, ls_arquivo
Long ll_retorno

ls_arquivo = ps_caminho_gravar_arquivo_assinado +'\' + ps_nome_arquivo_assinado +'.xml'

ll_retorno = Assinaxml_GeraAssinatura(ps_nome_arquivo_assinado, ps_arquivo_para_assinar, ps_caminho_gravar_arquivo_assinado)
If ll_retorno = 1 Then
	If FileExists(ls_arquivo) Then		
		If pb_compactar Then
			dc_uo_zip lo_Zip
			lo_Zip = Create dc_uo_zip
			
			lo_Zip.of_Salva_Estrutura( False )
			ls_Error = lo_Zip.of_Zip( ls_arquivo, ls_arquivo + '.zip' )
				
			If ls_Error <> "" Then
				//MessageBox( 'Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao tentar compactar arquivo ' + ls_Arquivo + '~r~r' + ls_Error, StopSign! )
				//Gravar log
				Return False			
			End If
		
			Destroy(lo_Zip)		
		End If
	
		Return True
	Else
		Return False
	End If
Else	
	Return False
End If
end function

public function boolean of_atualiza_historico_erro (long pl_filial, long pl_seq, string ps_erro);String ls_erro

ls_erro = LeftA(ps_erro,200)

Update historico_envio_arquivo_paf
Set id_situacao = 'E',
	de_mensagem_retorno = :ls_erro
Where cd_filial   = :pl_filial
	and nr_sequencial =:pl_seq
Using Sqlca;

If Sqlca.Sqlcode = -1 Then
	Sqlca.of_LogDbError(gvo_Aplicacao.ivi_Log,"Atualiza$$HEX2$$e700e300$$ENDHEX$$o Hitorico PAF com erro.")
	Return False
Else
	Sqlca.of_Commit()	
	Return True
End If
end function

public function boolean of_gera_blocox_canc_rep (long pl_filial, long pl_qt_rz, date pdt_data_fiscal, long pl_ecf, long pl_seq_historico, string ps_diretorio, string ps_recibo, string ps_motivo, ref string ps_erro, ref string ps_nome_xml, boolean pb_reprocesso);//FUN$$HEX2$$c700c300$$ENDHEX$$O QUE MONTA O ARQUIVO XML DE CANCELAMENTO/REPROCESSO DO BLOCO X REDUCA$$HEX2$$c700c300$$ENDHEX$$O Z

String ls_Registro, &
		 ls_qtRZ, &
		 ls_dataRZ, &
		 ls_data_hora, &
		 ls_nome_arquivo,&
		 ls_arquivo,& 
		 ls_tipo

Long ll_filial
				
Boolean lb_Sucesso
				
DateTime ldt_data_geracao
Date ldt_reducao

dc_uo_api lo_api
lo_api = Create dc_uo_api

lo_api.of_create_directory(ps_diretorio+ '\Enviados')

Destroy(lo_api)

ll_filial = pl_filial

If pb_reprocesso Then
	ls_tipo = '_rep'
Else
	ls_tipo = '_canc'
End If

//cabe$$HEX1$$e700$$ENDHEX$$alho
ls_Registro = '<?xml version="1.0" encoding="UTF-8"?>' + ivs_Enter 							+ &
					'<Manutencao Versao="1.0">' + ivs_Enter 											+ &
					This.of_Abre_Tag('Mensagem', 1)														+ &
					This.of_Elemento('Recibo', ps_recibo, 2)												+ &
					This.of_Elemento('Motivo', ps_motivo, 2)											+ &
					This.of_Fecha_tag('Mensagem'	, 1)
//ASSINATURA
ls_Registro += This.of_Abre_Tag('Signature xmlns="http://www.w3.org/2000/09/xmldsig#"',1)  + &
					This.of_Abre_Tag('SignedInfo', 2)	+ &
					This.of_Abre_Tag('CanonicalizationMethod Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315"',3) + &
					This.of_Fecha_Tag('CanonicalizationMethod',3) +&
					This.of_Abre_Tag('SignatureMethod Algorithm="http://www.w3.org/2000/09/xmldsig#rsa-sha1"', 3) + &					
					This.of_Fecha_Tag('SignatureMethod',3) +&
					This.of_Abre_Tag('Reference URI=""', 3)	+ &
					This.of_Abre_Tag('Transforms', 4)	+ &
					This.of_Abre_Tag('Transform Algorithm="http://www.w3.org/2000/09/xmldsig#enveloped-signature"', 5)	+ &
					This.of_Fecha_Tag('Transform',5) +&
					This.of_Abre_Tag('Transform Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315"', 5)	+ &
					This.of_Fecha_Tag('Transform',5) +&			
					This.of_Fecha_Tag('Transforms',4) +&
					This.of_Abre_Tag('DigestMethod Algorithm="http://www.w3.org/2000/09/xmldsig#sha1"', 4)	+ &
					This.of_Fecha_Tag('DigestMethod',4) +&
					This.of_Elemento('DigestValue', '', 4)		+ &
					This.of_Fecha_Tag('Reference',3) +&
					This.of_Fecha_Tag('SignedInfo',2) +&										
					This.of_Elemento('SignatureValue', '', 1)	+ &
					This.of_Abre_Tag('KeyInfo', 2)	+ &
					This.of_Abre_Tag('X509Data',3) + &
					This.of_Elemento('X509Certificate', '', 4)		+ &					
					This.of_Fecha_Tag('X509Data',3) +&					
					This.of_Fecha_Tag('KeyInfo',2) +&										
					This.of_Fecha_Tag('Signature', 1)+ &
											 '</Manutencao>'	

//Nome do arquivo: Filial(0000) + Sequencial tabela(0000000) + ECF(000) + Qt_RZ(0000) + DataReducao(ddmmyyy)  + datahorageracao(ddmmyyyhhmm)  -  Ex: 0563000002014012126072019260720190800.xml
ls_qtRZ				= String(pl_qt_rz,'0000')
ls_dataRZ			= String(pdt_data_fiscal,'ddmmyyyy')

ldt_data_geracao = gf_getserverdate()
ls_data_hora = String(ldt_data_geracao, 'DDMMYYYY') + String(ldt_data_geracao, 'HHMM')
ls_arquivo = ps_diretorio+'\' + String(ll_filial, '0000') + String(pl_seq_historico,'0000000') + String(pl_ecf,'000') + ls_qtRZ + ls_dataRZ + ls_data_hora + ls_tipo +'.xml'

If FileExists( ls_Arquivo ) Then
	FileDelete( ls_Arquivo )
End If

ls_nome_arquivo = String(ll_filial, '0000') + String(pl_seq_historico,'0000000') +  String(pl_ecf,'000') + ls_qtRZ + ls_dataRZ + ls_data_hora + ls_tipo

ivs_Arquivo_Xml = ps_diretorio+'\' + String(ll_filial, '0000') + String(pl_seq_historico,'0000000') +  String(pl_ecf,'000') + ls_qtRZ + ls_dataRZ + ls_data_hora + ls_tipo + '.xml'
		 
This.of_abre_arquivo()

This.of_Grava_Arquivo(ls_Registro)

FileClose(ivi_Arquivo_Xml)

If FileExists(ivs_Arquivo_Xml) Then //gerou xml
	ps_nome_xml = ls_nome_arquivo
	lb_sucesso = true
Else
	ps_erro = "Arquivo xml de cancelamento/reprocesso n$$HEX1$$e300$$ENDHEX$$o gerado."
	lb_sucesso = False
End If

If lb_sucesso Then
	Return True
Else
	Return False
End If
end function

public function boolean of_verifica_pendencias_blocox (string ps_tipo, long pl_ecf, boolean pb_mensagem, boolean pb_aviso_sem_registro, ref boolean pb_bloquear, string ps_mostra_registros);Long	ll_retorno, &
		ll_qt_registros, &
		ll_row, &
		ll_aguardando, &
		ll_pendente

String ls_mensagem

Boolean lb_Sucesso

dc_uo_ds_base lds_Pendencias
lds_Pendencias  = Create dc_uo_ds_base

If Not lds_Pendencias.of_ChangeDataObject('dw_ge038_pafecf_hist_blocox') Then Return False

If Not IsNull(ps_tipo) And Trim(ps_Tipo) <> '' Then
	lds_Pendencias.of_AppendWhere("cd_tipo = '" + Trim(ps_Tipo) + "'")
End If
If Not IsNull(pl_ecf) And pl_ecf > 0 Then
	lds_Pendencias.of_AppendWhere("nr_ecf = " + String(pl_ecf))	
End If

lds_Pendencias.of_AppendWhere("id_situacao in ('P','A','E')")	

ll_Retorno = lds_Pendencias.Retrieve()

If ll_Retorno <> -1 Then
	If lds_Pendencias.RowCount() = 0 Then 
		If pb_aviso_sem_registro Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o existem pend$$HEX1$$ea00$$ENDHEX$$ncias de envio!",Information!)			
		End If
		Return False
	Else		
		ll_qt_registros= lds_Pendencias.RowCount()
		For ll_Row = 1 To lds_Pendencias.RowCount()
			If lds_Pendencias.Object.id_situacao[ll_Row] = 'A' Then
				ll_aguardando += 1 
			Else
				ll_pendente += 1
			End If
		Next
		If ll_pendente = 0 And ll_aguardando = 0 Then
			pb_mensagem = False
		End If;
		
		lb_sucesso = True
		If pb_mensagem Then
			If ps_tipo = 'RZ' Then
					ls_mensagem = 'H$$HEX1$$c100$$ENDHEX$$ ' + String(ll_qt_registros) + ' ARQUIVOS COM INFORMA$$HEX2$$c700d500$$ENDHEX$$ES DA REDU$$HEX2$$c700c300$$ENDHEX$$O Z DO PAF-ECF PENDENTES DE TRANSMISS$$HEX1$$c300$$ENDHEX$$O AO FISCO.' + &
										 ' O CONTRIBUINTE PODE TRANSMITIR OS ARQUIVOS PELO MENU FISCAL POR MEIO DO COMANDO $$HEX1$$1820$$ENDHEX$$Envio ao FISCO-REDU$$HEX2$$c700c300$$ENDHEX$$OZ$$HEX1$$1920$$ENDHEX$$.'
			End If
			If ps_tipo = 'EST' Then
					ls_mensagem = 'H$$HEX1$$c100$$ENDHEX$$ '+ String(ll_qt_registros) +' ARQUIVOS COM INFORMA$$HEX2$$c700d500$$ENDHEX$$ES DO ESTOQUE MENSAL DO ESTABELECIMENTO PENDENTE DE TRANSMISS$$HEX1$$c300$$ENDHEX$$O AO FISCO.' + & 
										 ' O CONTRIBUINTE PODE TRANSMITIR O ARQUIVO PELO MENU FISCAL POR MEIO DO COMANDO $$HEX1$$1820$$ENDHEX$$Envio ao FISCO-ESTOQUE$$HEX1$$1920$$ENDHEX$$.'					
			End If
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o",ls_mensagem,Exclamation!)
			//Abrir tela listando
			If ps_mostra_registros = 'S' Then
				If ps_tipo = 'RZ' Then
					OpenWithParm(w_ge038_lista_reducao,'N')
				End If
				If ps_tipo = 'EST' Then
					OpenWithParm(w_ge038_lista_estoque,'N')
				End If
			End If
		End If
	End If
End If

Return lb_Sucesso
end function

public function boolean of_gera_xml_consulta_loja (long pl_filial, string ps_tipo, date pdt_data_fiscal, long pl_ecf, long pl_seq_historico, string ps_diretorio, string ps_recibo, ref string ps_erro, ref string ps_nome_xml);//FUN$$HEX2$$c700c300$$ENDHEX$$O QUE MONTA O ARQUIVO XML DE CONSULTA PROCESSAMENTO

String ls_Registro, &
		 ls_qtRZ, &
		 ls_dataRZ, &
		 ls_data_hora, &
		 ls_nome_arquivo,&
		 ls_arquivo

Long ll_filial, &
	   ll_mes, &
	   ll_ano
				
Boolean lb_Sucesso
				
DateTime ldt_data_geracao
Date ldt_reducao

ll_filial = pl_filial		 

//cabe$$HEX1$$e700$$ENDHEX$$alho
ls_Registro = '<?xml version="1.0" encoding="UTF-8"?>' + ivs_Enter 							+ &
					'<Manutencao Versao="1.0">' + ivs_Enter 											+ &
					This.of_Abre_Tag('Mensagem', 1)														+ &
					This.of_Elemento('Recibo', ps_recibo, 2)												+ &
					This.of_Fecha_tag('Mensagem'	, 1)
//ASSINATURA
ls_Registro += This.of_Abre_Tag('Signature xmlns="http://www.w3.org/2000/09/xmldsig#"',1)  + &
					This.of_Abre_Tag('SignedInfo', 2)	+ &
					This.of_Abre_Tag('CanonicalizationMethod Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315"',3) + &
					This.of_Fecha_Tag('CanonicalizationMethod',3) +&
					This.of_Abre_Tag('SignatureMethod Algorithm="http://www.w3.org/2000/09/xmldsig#rsa-sha1"', 3) + &					
					This.of_Fecha_Tag('SignatureMethod',3) +&
					This.of_Abre_Tag('Reference URI=""', 3)	+ &
					This.of_Abre_Tag('Transforms', 4)	+ &
					This.of_Abre_Tag('Transform Algorithm="http://www.w3.org/2000/09/xmldsig#enveloped-signature"', 5)	+ &
					This.of_Fecha_Tag('Transform',5) +&
					This.of_Abre_Tag('Transform Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315"', 5)	+ &
					This.of_Fecha_Tag('Transform',5) +&			
					This.of_Fecha_Tag('Transforms',4) +&
					This.of_Abre_Tag('DigestMethod Algorithm="http://www.w3.org/2000/09/xmldsig#sha1"', 4)	+ &
					This.of_Fecha_Tag('DigestMethod',4) +&
					This.of_Elemento('DigestValue', '', 4)		+ &
					This.of_Fecha_Tag('Reference',3) +&
					This.of_Fecha_Tag('SignedInfo',2) +&										
					This.of_Elemento('SignatureValue', '', 1)	+ &
					This.of_Abre_Tag('KeyInfo', 2)	+ &
					This.of_Abre_Tag('X509Data',3) + &
					This.of_Elemento('X509Certificate', '', 4)		+ &					
					This.of_Fecha_Tag('X509Data',3) +&					
					This.of_Fecha_Tag('KeyInfo',2) +&										
					This.of_Fecha_Tag('Signature', 1)+ &
											 '</Manutencao>'	

ls_dataRZ			= String(pdt_data_fiscal,'ddmmyyyy')

ldt_data_geracao = gf_getserverdate()
ls_data_hora = String(ldt_data_geracao, 'DDMMYYYY') + String(ldt_data_geracao, 'HHMM')
If ps_tipo = 'RZ' Then
	ls_arquivo = ps_diretorio+'\Reducao Z ' + ls_dataRZ + '_consulta.xml'
End If
If ps_tipo = 'EST' Then
	ll_mes = Month(pdt_data_fiscal)
	ll_ano = Year(pdt_data_fiscal)	
	ls_arquivo = ps_diretorio+'\Estoque ' + String(ll_mes,'00') + String(ll_ano) + '_consulta.xml'
End If

If FileExists( ls_Arquivo ) Then
	FileDelete( ls_Arquivo )
End If

If ps_tipo = 'RZ' Then
	ls_nome_arquivo = 'Reducao Z ' + ls_dataRZ + '_consulta'
	ivs_Arquivo_Xml = ps_diretorio+'\Reducao Z ' + ls_dataRZ + '_consulta.xml'
End If
If ps_tipo = 'EST' Then
	ls_nome_arquivo = 'Estoque ' + String(ll_mes,'00') + String(ll_ano) + '_consulta'
	ivs_Arquivo_Xml = ps_diretorio+'\Reducao Z ' + ls_dataRZ + '_consulta.xml'
End If
		 
This.of_abre_arquivo()

This.of_Grava_Arquivo(ls_Registro)

FileClose(ivi_Arquivo_Xml)

//Atualizar informa$$HEX2$$e700e300$$ENDHEX$$o de gera$$HEX2$$e700e300$$ENDHEX$$o e envio na tabela historico.
If FileExists(ivs_Arquivo_Xml) Then //gerou xml
	ps_nome_xml = ls_nome_arquivo
	lb_sucesso = true
Else
	ps_erro = "Arquivo xml de consulta n$$HEX1$$e300$$ENDHEX$$o gerado."
	lb_sucesso = False
End If

If lb_sucesso Then
	Return True
Else
	Return False
End If
end function

public function boolean of_grava_retorno (string ps_retorno, string ps_arquivo, ref string ps_msg);Integer li_FileNum
Integer li_FileWrite

String ls_Arquivo

If FileExists( ps_Arquivo ) Then
	FileDelete( ps_Arquivo )
End If

li_FileNum = FileOpen( ps_Arquivo, StreamMode!, Write!, LockWrite!, Replace!, EncodingUTF8! )

If li_FileNum = -1 Then
	ps_msg = "Ocorreu um erro na tentativa de abrir o arquivo '" + ps_Arquivo + "'."
	Return False
End If

li_FileWrite = FileWrite( li_FileNum, ps_Retorno )
FileClose( li_FileNum )

If li_FileWrite = -1 Then
	ps_msg = "Ocorreu um erro na tentativa de gravar o retorno no arquivo '" + ps_Arquivo + "'."
	FileDelete( ls_Arquivo )
	Return False
End If

Return True
end function

public function boolean of_pafecf_registro_nfc_j01 (date pdh_inicial, date pdh_final, long pl_arquivo, ref boolean pb_evidenciado);
Boolean 	lb_Sucesso = True

String 	ls_Registro
String   ls_Indice

Long 	 	ll_Row
Long     ll_Retorno

Decimal {2} ldc_Desconto

String ls_Modelo
String ls_Cancelado
String ls_nome_cliente
String ls_chave

dc_uo_ds_base lds_nota

lds_nota = Create dc_uo_ds_base

If Not lds_nota.of_ChangeDataObject('dw_ge038_pafecf_nota_fiscal_j1_nfc') Then Return False

ll_Retorno = lds_nota.Retrieve(pdh_inicial,pdh_final)

If ll_Retorno <> -1 Then

	For ll_Row = 1 To lds_nota.RowCount()
			
		ldc_Desconto = lds_nota.object.vl_total_produtos[ll_row] - lds_nota.object.vl_total_nf[ll_row]
		
		ls_Registro = 'J1'
		
		ls_Registro += LeftA(gvo_parametro.nr_cgc + Space(14), 14)
	
		ls_Registro += String(lds_nota.object.dh_emissao[ll_row],'yyyymmdd')		
		
		ls_Registro += of_Formata_Valor_PafEcf(lds_nota.object.vl_total_produtos[ll_row],12,2)
		
		ls_Registro += of_Formata_Valor_PafEcf(ldc_Desconto,11,2)		
		
		ls_Registro += 'V'
		
		ls_Registro += FillA("0", 13)		
		
		ls_Registro += 'V'

		ls_Registro += of_Formata_Valor_PafEcf(lds_nota.object.vl_total_nf[ll_row],12,2)	
		
		If lds_nota.object.id_situacao[ll_row] = 'A' Then  //Tipo emissao			
			If MidA(lds_nota.object.de_chave_acesso[ll_row], 35,1) = '1' Then				
				ls_Registro += '1'
			Else
				ls_Registro += '9'
			End If
			ls_chave = LeftA(lds_nota.object.de_chave_acesso[ll_row] + Space(44), 44)			
		Else
			ls_Registro += '9'
			ls_chave = FillA("0", 44)			
		End If
				
		ls_Registro += ls_chave	//Chave acesso				
	
		ls_Registro += String(lds_nota.object.nr_nf[ll_row],'0000000000')
		
		ls_Registro += LeftA(lds_nota.object.de_serie[ll_row] + Space(3), 3)	
		
		//cpf_cnpj
		If Not IsNull(lds_nota.object.nr_cpf_cgc[ll_row]) And Trim(lds_nota.object.nr_cpf_cgc[ll_row]) <> "" Then
			ls_Registro += RightA(Space(14) + lds_nota.object.nr_cpf_cgc[ll_row], 14)		
		Else		
			ls_registro += Space(14)
		End If		
		
		ls_chave = ''
		
		If Not This.of_grava_registro_temp( 'J1', String(lds_nota.object.dh_emissao[ll_row],'yyyymmdd'),'','', ls_Registro ) Then
			lb_Sucesso = False
		End If
				
		ls_Registro = ''
		
		If Not lb_Sucesso Then Exit
		
	Next
	
Else
	lb_Sucesso = False
	
End If	

Destroy(lds_nota)

Return lb_Sucesso
end function

public function boolean of_pafecf_registro_nfc_j02 (date pdh_inicial, date pdh_final, long pl_arquivo, ref boolean pb_evidenciado);
Boolean 	lb_Sucesso = True

String 	ls_Registro
String   ls_Tributacao
String   ls_produto

Long 	 	ll_Row
Long		ll_row2
Long     ll_Retorno
Long 		ll_Item
Long     ll_Doc_Anterior
Long ll_filial
Long ll_nota
Long ll_mapa
Long ll_ecf
String ls_serie
String ls_especie
long ll_produto
long ll_natureza
string ls_sit_trib

Decimal {2} ldc_Desconto, ldc_icms
 
String ls_Modelo

Date ldt_emissao

dc_uo_ds_base lds_Item

lds_Item = Create dc_uo_ds_base

If Not lds_Item.of_ChangeDataObject('dw_ge038_pafecf_item_nota_fiscal_j2_nfc') Then Return False

ll_Retorno = lds_Item.Retrieve(gvo_parametro.cd_filial,pdh_inicial,pdh_final)

If ll_Retorno <> -1 Then

	For ll_Row = 1 To lds_Item.RowCount()		
		
		If ll_Doc_Anterior <> lds_Item.object.nr_nf[ll_row] Then
			ll_Doc_Anterior = lds_Item.object.nr_nf[ll_row]
			ll_Item = 1
		End If
		
		ldc_icms = lds_Item.object.pc_icms[ll_row]
		ldt_emissao = Date(lds_Item.object.dh_emissao[ll_row])
		
		Select nr_mapa 
			into :ll_mapa		
		from mapa_resumo where 
			dh_emissao = :ldt_emissao
		Using sqlca;		
		
		
		ll_filial = lds_Item.object.cd_filial[ll_row]
		ll_nota = lds_Item.object.nr_nf[ll_row]
		ls_especie = lds_Item.object.de_especie[ll_row]
		ls_serie	= lds_Item.object.de_serie[ll_row]
		
		ldc_Desconto = lds_Item.object.vl_preco_unitario[ll_row] - lds_Item.object.vl_preco_praticado[ll_row]
					
		ls_Registro = 'J2'
		
		ls_Registro += LeftA(gvo_parametro.nr_cgc + Space(14), 14)
		
		ls_Registro += String(lds_item.object.dh_emissao[ll_row],'yyyymmdd')		
		
		ls_Registro += String(lds_item.object.nr_sequencial[ll_row],'000')
		
		ls_Registro += LeftA(String(lds_Item.object.cd_produto[ll_row]) + Space(14) , 14 )
		
		ls_produto = Space(100)
		
		ls_Registro += LeftA(lds_Item.object.de_produto[ll_row] + ls_produto, 100)
			
		ls_Registro += String(lds_Item.object.qt_vendida[ll_row],'0000000')		
		
		ls_Registro += LeftA(lds_Item.object.cd_un[ll_row] + Space(3) ,3)

		ls_Registro += of_Formata_Valor_PafEcf(lds_Item.object.vl_preco_unitario[ll_row],6,2)		

		ls_Registro += of_Formata_Valor_PafEcf(ldc_Desconto,6,2)		

		ls_Registro += FillA("0", 8)		
		
		ls_Registro += of_Formata_Valor_PafEcf(lds_Item.object.vl_preco_praticado[ll_row],12,2)

		Choose Case lds_Item.object.pc_icms[ll_row]
			Case 7    ; ls_Tributacao = "T0700  "
			Case 12   ; ls_Tributacao = "T1200  "
			Case 25   ; ls_Tributacao = "T2500  "		
			Case 17   ; ls_Tributacao = "T1700  "
			Case 18	 ; ls_Tributacao = "T1800  "
			Case Else 
				If lds_Item.object.cd_situacao_tributaria[ll_row] = '06' Then
					ls_Tributacao = "F      "
				Else
					ls_Tributacao = "I      "
				End If
		End Choose	
		ls_Registro += ls_Tributacao		

		ls_Registro += '0'
		
		ls_Registro += '2'
		
		ls_Registro += String(ll_nota,'0000000000')	
		
		ls_Registro += LeftA(ls_serie + Space(3), 3)		

		If Not IsNull(lds_item.object.de_chave_acesso[ll_row]) Or Trim(String(lds_item.object.de_chave_acesso[ll_row])) <> "" Then
			ls_Registro += LeftA(lds_item.object.de_chave_acesso[ll_row] + Space(44), 44)						
		Else
			ls_Registro += FillA("0", 44)
		End If
				
		If Not This.of_grava_registro_temp( 'J2', String(lds_item.object.dh_emissao[ll_row],'yyyymmdd'),'','', ls_Registro ) Then
			lb_Sucesso = False
		End If
		
		ls_Registro = ''
		
		If Not lb_Sucesso Then Exit
		
		ll_Item ++
				
		
	Next
	

	
	
Else
	lb_Sucesso = False
	
End If

Destroy(lds_Item)

Return lb_Sucesso
end function

public function boolean of_atualiza_certificado (string ps_arquivo);//Atualiza o nosso certificado digital no PDV
//O arquivo .pfx do certificado precisa estar no C:\Sistemas\DLL\nfce
//A dll Assinaxml.dll precisa existir e estar atualizada no C:\Sistemas\DLL\
Long 	  ll_Retorno

If Not FileExists(ps_arquivo) Then
	//arquivo do certificado n$$HEX1$$e300$$ENDHEX$$o encontrado
	Return False
End If

//Quando terminar os testes Remover essa parte, criar fun$$HEX2$$e700e300$$ENDHEX$$o separada.
ll_retorno = AtualizaCertificado()

If ll_Retorno = -1 Then
	//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","problemas para atualizar certificado " + ps_arquivo, StopSign!)
	Return False
Else
	Return True
End If


end function

public function boolean of_gera_blocox_reducao (date pdt_data_fiscal, long pl_ecf, long pl_seq_historico, string as_path_arquivo);//FUN$$HEX2$$c700c300$$ENDHEX$$O QUE MONTA O ARQUIVO XML DO BLOCO X REDUCA$$HEX2$$c700c300$$ENDHEX$$O Z
//ALTERA$$HEX2$$c700d500$$ENDHEX$$ES NA ESTRUTURA DO ARQUIVO DEVEM SER FEISTA AQUI E NAS OUTRA DUAS FUN$$HEX2$$c700d500$$ENDHEX$$ES QUE GERAM O ARQUIVO


String ls_Registro, &
		 ls_ins_est, &
		 ls_cst_trib, &
		 ls_cst_trib_ant, &
		 ls_nome_totalizador, &
		 ls_icms, &
		 ls_qtRZ, &
		 ls_dataRZ, &
		 ls_arquivo, &
		 ls_retorno, &
		 ls_codigo, &
		 ls_cod_barras, &
		 ls_mensagem, &
		 ls_arquivo_retorno, &
		 ls_recibo, &
		 ls_cest, &
		 ls_ncm, &
		 ls_erro, &
		 ls_situacao, &
		 ls_CPD, &
		 ls_descricao, &
		 ls_data_hora, &
		 ls_serie_mapa, &
		 ls_especie_mapa, &		 
		 ls_enviado = 'N'
		 
Long ll_ecf, &
		ll_retorno, &
		ll_row, &
		ll_mapa, &
		ll_find, &
		ll_filial, &
		ll_qt_reducao, &
		ll_Row_canc, &
		ll_produto, &
		ll_nova_linha,&
		ll_qt_redz_ant,&
		ll_mapa_ant,&
		ll_qt_redz_multipla,&
		ll_coo_inicial,&
		ll_coo_final		
		
Decimal {2} lvdc_venda_bruta, &
			 	lvdc_total_F1, &
				lvdc_total_I1, &
				lvdc_total_N1, &
				lvdc_icms, &
				lvdc_icms_ant, &
				lvdc_valor_imposto, &
				lvdc_cancelamento_mapa, &
				lvdc_desconto_mapa, &
				lvdc_total_item_canc, &
				lvdc_Sum_Cancelamento, &
				lvdc_Sum_Desconto, &
				lvdc_Sum_Itens, &
				lvdc_Sum_Aliquotas, &
				lvdc_Sum_Aliq17, &
				lvdc_Sum_Aliq25, &				
				lvdc_dif_cancelamento, &
				lvdc_dif_venda_liquida, &
				lvdc_dif_desconto, &
				lvdc_Aux, &
				lvdc_sum_i1, &
				lvdc_sum_n1, &
				lvdc_sum_f1, &
				lvdc_sum_17, &
				lvdc_sum_25, &
				lvdc_sum_tributado, &
				lvdc_dif_i1, &
				lvdc_dif_n1, &
				lvdc_dif_f1, &
				lvdc_dif_tributado, &
				lvdc_dif_17, &
				lvdc_dif_25, &
				lvdc_divisao_dif,&
				lvdc_gt_inicial_ant,&
				lvdc_gt_final_ant,&
				lvdc_dif_limite

				
Boolean lb_Sucesso, &
		   lb_ordena
Boolean lb_multipla_reducao
				
DateTime ldt_data_geracao

String ls_Diretorio_Arquivo

gvo_aplicacao.Of_Grava_Log("Grava$$HEX2$$e700e300$$ENDHEX$$o Arquivo Redu$$HEX2$$e700e300$$ENDHEX$$oZ - Entrada da fun$$HEX2$$e700e300$$ENDHEX$$o! Data: " + String(pdt_data_fiscal,'DDMMYYYY') + ' ECF: ' + String(pl_ecf) + " (of_gera_blocox_reducao).")			

ll_filial = gvo_parametro.cd_filial	
ll_ecf = pl_ecf

dc_uo_api lo_api
lo_api = Create dc_uo_api

lo_api.of_create_directory('C:\Sistemas\CL\Arquivos\PAF-ECF\Recibos - Bloco X')
lo_api.of_create_directory('C:\Sistemas\CL\Arquivos\PAF-ECF\Arquivos - Redu$$HEX2$$e700e300$$ENDHEX$$o Z')
lo_api.of_create_directory('C:\Sistemas\CL\Arquivos\PAF-ECF\Arquivos - Redu$$HEX2$$e700e300$$ENDHEX$$o Z\Enviados')

If IsNull(as_path_arquivo) Then
	ls_Diretorio_Arquivo = This.is_caminho_arquivo_xml + 'Arquivos - Redu$$HEX2$$e700e300$$ENDHEX$$o Z\'
Else
	ls_Diretorio_Arquivo = as_Path_Arquivo
	lo_api.of_create_directory(ls_Diretorio_Arquivo)
End If

If IsValid(lo_Api) Then Destroy(lo_api)				

lvdc_dif_limite = 0.50

//Verifica se tem mais de uma redu$$HEX2$$e700e300$$ENDHEX$$oZ para o mesmo dia
dc_uo_ds_base lds_Reducao_multipla
lds_Reducao_multipla  = Create dc_uo_ds_base

If Not lds_Reducao_multipla.of_ChangeDataObject('ds_ge038_pafecf_multipla_reducao') Then Return False

ll_Retorno = lds_Reducao_multipla.Retrieve(ll_filial, ll_ecf,pdt_data_fiscal,pdt_data_fiscal)

If ll_Retorno <> -1 Then
	If ll_retorno > 1 Then //Encontrada mais de uma redu$$HEX2$$e700e300$$ENDHEX$$o para o mesmo dia
		lb_multipla_reducao = True	
		
		select qt_reducao_z 
			into :ll_qt_redz_multipla
		from historico_envio_arquivo_paf
			where cd_filial = :ll_filial
				and nr_sequencial = :pl_seq_historico
		Using SqlCa;
		
		If Sqlca.SqlCode = -1 Then
			Sqlca.of_LogDbError(gvo_Aplicacao.ivi_Log,"Localiza$$HEX2$$e700e300$$ENDHEX$$o do Historico envio")
			Return False
		Else
			If ll_qt_redz_multipla = 0 Or IsNull(ll_qt_redz_multipla) Then
				gvo_aplicacao.Of_Grava_Log("Grava$$HEX2$$e700e300$$ENDHEX$$o Arquivo Redu$$HEX2$$e700e300$$ENDHEX$$oZ - Erro carregar historico da redu$$HEX2$$e700e300$$ENDHEX$$o z multipla.(of_gera_blocox_reducao).")	
				Return False
			End If
		End If	
		
		ll_find = lds_Reducao_multipla.Find ("qt_reducao_z = " + STRING( ll_qt_redz_multipla ), 1 ,lds_Reducao_multipla.RowCount())				
		If ll_find > 0 Then
			ls_especie_mapa = lds_Reducao_multipla.Object.de_especie[ll_find]
			ls_serie_mapa = lds_Reducao_multipla.Object.de_serie[ll_find]
		Else
			gvo_aplicacao.Of_Grava_Log("Grava$$HEX2$$e700e300$$ENDHEX$$o Arquivo Redu$$HEX2$$e700e300$$ENDHEX$$oZ - Erro no FIND da redu$$HEX2$$e700e300$$ENDHEX$$o z multipla..(of_gera_blocox_reducao).")				
			Return False			
		End If		
		ll_find = 0
	End If
Else
	gvo_aplicacao.Of_Grava_Log("Grava$$HEX2$$e700e300$$ENDHEX$$o Arquivo Redu$$HEX2$$e700e300$$ENDHEX$$oZ - Erro ao buscar dados de multiplas redu$$HEX2$$e700f500$$ENDHEX$$es.(of_gera_blocox_reducao).")
	Return False						
End If
			 
ls_ins_est			= gf_replace(gvo_parametro.nr_inscricao_estadual, '.', '', 0)
ls_ins_est			= gf_replace(ls_ins_est, '/', '', 0)
ls_ins_est			= gf_replace(ls_ins_est, '-', '', 0)

//cabe$$HEX1$$e700$$ENDHEX$$alho, dados da loja e sistema
ls_Registro = '<?xml version="1.0" encoding="UTF-8"?>' + ivs_Enter 							+ &
					'<ReducaoZ Versao="1.0">' + ivs_Enter 												+ &
					This.of_Abre_Tag('Mensagem', 1)														+ &					
					This.of_Abre_Tag('Estabelecimento', 2)												+ &
					This.of_Elemento('Ie', ls_ins_est, 3)													+ &
					This.of_Fecha_tag('Estabelecimento', 2)												+ &					
					This.of_Abre_Tag('PafEcf', 2)															+ &
					This.of_Elemento('NumeroCredenciamento', is_numero_credenciamento, 3)+ &
					This.of_Fecha_tag('PafEcf', 2)				

If Not This.of_Carrega_dados_ecf(ll_ecf) Then
	gvo_aplicacao.Of_Grava_Log("Grava$$HEX2$$e700e300$$ENDHEX$$o Arquivo Redu$$HEX2$$e700e300$$ENDHEX$$oZ - Erro carregar dados do ECF.(of_gera_blocox_reducao).")	
	Return False
End If				

//Dados ECF
ls_CPD = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "ECF", "CPD","")

If Trim(UPPER(ls_CPD)) = 'SIM' Then //Fixo, porque ECFs de testes n$$HEX1$$e300$$ENDHEX$$o tem cadastro no SEFAZ.	
	Choose Case Upper(Trim(This.de_marca))
		Case "BEMATECH"
			This.nr_serie_mfd = 'BE111710101110021142' 
		Case "DARUMA"
			This.nr_serie_mfd = 'DR0512BR000000352916'
		Case "EPSON"
			This.nr_serie_mfd = 'EP121710000000015156'
		Case Else	
			This.nr_serie_mfd = 'SW031000000000008755'
	End Choose
End If

String ls_serie_mfd
ls_serie_mfd = This.nr_serie_mfd

If 	(ll_filial = 301 And ll_ecf = 4) Or &
	(ll_filial = 592 And ll_ecf = 3) Or &
	(ll_filial = 702 And ll_ecf = 2) Or &
	(ll_filial = 811 And ll_ecf = 4) Or &
	(ll_filial = 820 And ll_ecf = 1) Or &
	(ll_filial = 877 And ll_ecf = 4) Or &
	(ll_filial = 890 And ll_ecf = 4) Or &
	(ll_filial = 921 And ll_ecf = 2) Then
	If LenA(ls_serie_mfd) = 20 Then
		ls_serie_mfd = ls_serie_mfd + 'A'
	End If
End If

ls_Registro += This.of_Abre_Tag('Ecf', 2)	+ &									   	
					This.of_Elemento('NumeroFabricacao', ls_serie_mfd, 3)

//Dados ReducaoZ
dc_uo_ds_base lds_Reducao
lds_Reducao  = Create dc_uo_ds_base

If Not lds_Reducao.of_ChangeDataObject('dw_ge038_pafecf_reducaoz') Then Return False

If lb_multipla_reducao Then
	lds_Reducao.of_AppendWhere("mapa_resumo_ecf.qt_reducao_z = " + String(ll_qt_redz_multipla))
End If

ll_Retorno = lds_Reducao.Retrieve(ll_ecf,pdt_data_fiscal,pdt_data_fiscal)

If ll_Retorno <> -1 Then
	
	If lds_Reducao.RowCount() = 0 Then
		//sem dados de reducaoZ
		gvo_aplicacao.Of_Grava_Log("Grava$$HEX2$$e700e300$$ENDHEX$$o Arquivo Redu$$HEX2$$e700e300$$ENDHEX$$oZ - Sem dados de mapa resumo da redua$$HEX2$$e700e300$$ENDHEX$$oZ. Filial: "+String(ll_filial) + " ECF: " + String(ll_ecf)  + " Data Fiscal: " + String(pdt_data_fiscal,'ddmmyyyy') + " (of_gera_blocox_reducao).")		
		Return False
	End If
	
	lvdc_venda_bruta 	= lds_Reducao.object.vl_total_geral_final[1] - lds_Reducao.object.vl_total_geral_inicial[1] // - lds_Reducao.object.vl_cancelamento[1]
	lvdc_total_F1 		= lds_Reducao.object.vl_st[1]
	lvdc_total_I1 		= lds_Reducao.object.vl_isenta[1]	
	lvdc_total_N1 		= lds_Reducao.object.vl_nao_incidencia[1]
	lvdc_cancelamento_mapa = lds_Reducao.object.vl_cancelamento[1]
	lvdc_desconto_mapa = lds_Reducao.object.vl_desconto[1]
	ll_mapa				= lds_Reducao.object.nr_mapa[1]
	ll_qt_reducao		= lds_Reducao.object.qt_reducao_z[1]
	ls_qtRZ				= String(lds_Reducao.object.qt_reducao_z[1],'0000')
	ls_dataRZ			= String(lds_Reducao.object.dh_emissao[1],'ddmmyyyy')
	ll_coo_inicial		= lds_Reducao.object.nr_operacao_inicial[1]
	ll_coo_final			= lds_Reducao.object.nr_operacao_final[1]	
	
	ls_Registro += This.of_Abre_Tag('DadosReducaoZ', 3)	+ &
						This.of_Elemento('DataReferencia', String(lds_Reducao.object.dh_emissao[1],'yyyy-mm-dd'), 4)	+ &
						This.of_Elemento('DataHoraEmissao', String(lds_Reducao.object.dh_reducao[1],'yyyy-mm-ddThh:mm:ss'), 4)	+ &						
						This.of_Elemento('CRZ', String(lds_Reducao.object.qt_reducao_z[1],'0000'), 4)								+ &					
						This.of_Elemento('COO', String(lds_Reducao.object.nr_operacao_final[1],'000000000'), 4)					+ &
						This.of_Elemento('CRO', String(lds_Reducao.object.qt_reinicio_z[1],'000'), 4)									+ &
						This.of_Elemento('VendaBrutaDiaria', This.of_Formata_Valor_PafEcf(lvdc_venda_bruta,12,2), 4)			+ &
						This.of_Elemento('GT', This.of_Formata_Valor_PafEcf(lds_Reducao.object.vl_total_geral_final[1],16,2), 4)
						
	//Busca GTs do dia anterior e contador de reducao z
	If lds_Reducao.object.dh_emissao[1] > dt_inicio_blocox Then
		select nr_mapa, vl_total_geral_inicial, vl_total_geral_final, qt_reducao_z 
			into :ll_mapa_ant,:lvdc_gt_inicial_ant, :lvdc_gt_final_ant, :ll_qt_redz_ant
		from mapa_resumo_ecf 
			where cd_filial = :ll_filial
				and nr_ecf = :pl_ecf
				and qt_reducao_z = :ll_qt_reducao - 1
		Using SqlCa;
		
		Choose Case Sqlca.SqlCode		
			Case -1		
				Sqlca.of_LogDbError(gvo_Aplicacao.ivi_Log,"Localiza$$HEX2$$e700e300$$ENDHEX$$o do Mapa Resumo ECF anterior")
				Return False
			Case 0
				If lvdc_gt_final_ant <> lds_Reducao.object.vl_total_geral_inicial[1] Then
					//GT Final anterior diferente do GT inicial 
					ls_erro = "XML n$$HEX1$$e300$$ENDHEX$$o gerado. GT Final anterior(" + String(lvdc_gt_final_ant, '0.00')  +  ") diferente do GT inicial atual(" + String(lds_Reducao.object.vl_total_geral_inicial[1],'0.00') + ")."
					This.of_atualiza_historico_erro( ll_filial, pl_seq_historico, ls_erro)
					Return False
				End If
				If (ll_qt_redz_ant + 1) <> lds_Reducao.object.qt_reducao_z[1] Then
					//Contador de reducaoz diferente do esperado
					ls_erro = "Contador de reducaoz atual diferente do esperado. Atual " + String(lds_Reducao.object.qt_reducao_z[1]) + " Anterior: " + String(ll_qt_redz_ant)
					This.of_atualiza_historico_erro( ll_filial, pl_seq_historico, ls_erro)
					Return False
				End If			
			Case 100
				//N$$HEX1$$e300$$ENDHEX$$o achou, n$$HEX1$$e300$$ENDHEX$$o faz a verifica$$HEX2$$e700e300$$ENDHEX$$o		
				//Verificar se tratar pulo de contador de redu$$HEX2$$e700e300$$ENDHEX$$oZ
		End choose	
	End If					
						
Else
	gvo_aplicacao.Of_Grava_Log("Grava$$HEX2$$e700e300$$ENDHEX$$o Arquivo Redu$$HEX2$$e700e300$$ENDHEX$$oZ - Erro ao buscar dados da redua$$HEX2$$e700e300$$ENDHEX$$oZ. Filial: "+String(ll_filial) + " ECF: " + String(ll_ecf)  + " Data Fiscal: " + String(pdt_data_fiscal,'ddmmyyyy') + " (of_gera_blocox_reducao).")				
	Return False				
End If

//Busca dados de aliquotas
dc_uo_ds_base lds_mapa_aliq
lds_mapa_aliq  = Create dc_uo_ds_base

If Not lds_mapa_aliq.of_ChangeDataObject('ds_ge038_pafecf_resumo_ecf_aliq') Then Return False

If lb_multipla_reducao Then
	lds_mapa_aliq.of_AppendWhere("de_serie = '" + ls_serie_mapa + "'")	
	lds_mapa_aliq.of_AppendWhere("de_especie = '" + ls_especie_mapa + "'")	
End If

ll_Retorno = lds_mapa_aliq.Retrieve(ll_mapa, ll_ecf)

If ll_Retorno = -1 Then
	gvo_aplicacao.Of_Grava_Log("Grava$$HEX2$$e700e300$$ENDHEX$$o Arquivo Redu$$HEX2$$e700e300$$ENDHEX$$oZ - Erro ao buscar al$$HEX1$$ed00$$ENDHEX$$quotas do mapa resumo. Filial: "+String(ll_filial) + " ECF: " + String(ll_ecf)  + " Mapa: " + String(ll_mapa) + " Data Fiscal: " + ls_dataRZ + " (of_gera_blocox_reducao).")						
	Return False				
End If

lvdc_Sum_Aliquotas 	= lds_mapa_aliq.GetItemDecimal(lds_mapa_aliq.RowCount(), "sum_base_calculo")
lvdc_Sum_Aliq17		= lds_mapa_aliq.GetItemDecimal(lds_mapa_aliq.RowCount(), "sum_aliq_17")
lvdc_Sum_Aliq25		= lds_mapa_aliq.GetItemDecimal(lds_mapa_aliq.RowCount(), "sum_aliq_25")

//Dados de totalizadores
dc_uo_ds_base lds_Produtos
lds_Produtos  = Create dc_uo_ds_base

If Not lds_Produtos.of_ChangeDataObject('ds_ge038_pafecf_produto_cupom_aliquota') Then Return False

If lb_multipla_reducao Then
	lds_Produtos.of_AppendWhere("v.nr_operacao_ecf >= " + String(ll_coo_inicial))	
	lds_Produtos.of_AppendWhere("v.nr_operacao_ecf <= " + String(ll_coo_final))	
End If

ll_Retorno = lds_Produtos.Retrieve(ll_ecf,pdt_data_fiscal,pdt_data_fiscal)

If ll_Retorno <> -1 Then	
	//Dados produto cancelados
	dc_uo_ds_base lds_cancelamentos
	lds_cancelamentos  = Create dc_uo_ds_base
	
	If Not lds_cancelamentos.of_ChangeDataObject('ds_ge038_pafecf_produto_cancelado_blocox') Then 
		gvo_aplicacao.Of_Grava_Log("Grava$$HEX2$$e700e300$$ENDHEX$$o Arquivo Redu$$HEX2$$e700e300$$ENDHEX$$oZ - Erro ao buscar cancelamentos. Filial: "+String(ll_filial) + " ECF: " + String(ll_ecf)  + " Mapa: " + String(ll_mapa) + " Data Fiscal: " + ls_dataRZ + "(of_gera_blocox_reducao).")						
		Return False				
	End If
	
	If lb_multipla_reducao Then
		lds_cancelamentos.of_AppendWhere("l.nr_coo >= " + String(ll_coo_inicial))	
		lds_cancelamentos.of_AppendWhere("l.nr_coo <= " + String(ll_coo_final))	
	End If	
	
	ll_Retorno = lds_cancelamentos.Retrieve(ll_filial, ll_ecf,pdt_data_fiscal,pdt_data_fiscal)
	
	If ll_Retorno <> -1 Then
		If lds_cancelamentos.RowCount() > 0 Then
			lvdc_Sum_Cancelamento = lds_cancelamentos.GetItemDecimal(lds_cancelamentos.RowCount(), "sum_total_cancelado")
			lvdc_dif_cancelamento = lvdc_cancelamento_mapa - lvdc_Sum_Cancelamento
			If Abs(lvdc_dif_cancelamento) = lvdc_Sum_Cancelamento Then //diferen$$HEX1$$e700$$ENDHEX$$a igual a soma do grid, indica que no ECF n$$HEX1$$e300$$ENDHEX$$o registrou cancelamento
				gvo_aplicacao.Of_Grava_Log("Grava$$HEX2$$e700e300$$ENDHEX$$o Arquivo Redu$$HEX2$$e700e300$$ENDHEX$$oZ - Existe cancelamento registrado no Sistema e n$$HEX1$$e300$$ENDHEX$$o na redu$$HEX2$$e700e300$$ENDHEX$$o Z. ECF: " + String(ll_ecf)  + " Mapa: " + String(ll_mapa) + " Data Fiscal: " + ls_dataRZ + " (of_gera_blocox_reducao).")
				ls_erro = "XML n$$HEX1$$e300$$ENDHEX$$o gerado. Cancelamentos registrados no Sistema e n$$HEX1$$e300$$ENDHEX$$o na Redu$$HEX2$$e700e300$$ENDHEX$$o Z."
				This.of_atualiza_historico_erro( ll_filial, pl_seq_historico, ls_erro)				
				Return False
			End If
			
			uo_produto lvo_produto
			lvo_produto = Create uo_produto
			
			uo_Tratamento_Fiscal lvo_Fiscal
			lvo_Fiscal = Create uo_Tratamento_Fiscal

			uo_Atributo_Fiscal_Item_NF	 lvo_Atributo
			lvo_Atributo = Create uo_Atributo_Fiscal_Item_NF
			
			lvo_Fiscal.of_Grava_Contribuinte(False)
			lvo_Fiscal.of_Grava_UF_Origem_Destino( 'SC', 'SC')
			lvo_Fiscal.of_Grava_Operacao(lvo_Fiscal.VENDA)	
			
			If lvdc_dif_cancelamento <> 0.00 Then
				lvdc_divisao_dif = lvdc_dif_cancelamento / lds_cancelamentos.RowCount()
			End if
			For ll_Row_canc = 1 To lds_cancelamentos.RowCount()
				If lvdc_dif_cancelamento <> 0.00 Then							
					//Se for o $$HEX1$$fa00$$ENDHEX$$ltimo item a diferen$$HEX1$$e700$$ENDHEX$$a ser$$HEX1$$e100$$ENDHEX$$ o restante
					If ll_Row_canc = lds_cancelamentos.RowCount() Then
						If lvdc_dif_cancelamento > 0.00 Then
							lvdc_Aux = lvdc_dif_cancelamento
						Else
							If lds_cancelamentos.Object.total_cancelado[ll_row_Canc] > Abs(lvdc_dif_cancelamento) Then
								lvdc_Aux = lvdc_dif_cancelamento
							Else
								gvo_aplicacao.Of_Grava_Log("Grava$$HEX2$$e700e300$$ENDHEX$$o Arquivo Redu$$HEX2$$e700e300$$ENDHEX$$oZ - N$$HEX1$$e300$$ENDHEX$$o foi possivel dividir a diferen$$HEX1$$e700$$ENDHEX$$a de cancelamento entre os itens. ECF: " + String(ll_ecf)  + " Mapa: " + String(ll_mapa) + " Data Fiscal: " + ls_dataRZ + "(of_gera_blocox_reducao).")
								ls_erro = "XML n$$HEX1$$e300$$ENDHEX$$o gerado. N$$HEX1$$e300$$ENDHEX$$o foi possivel dividir a diferen$$HEX1$$e700$$ENDHEX$$a de cancelamento entre os itens."
								This.of_atualiza_historico_erro( ll_filial, pl_seq_historico, ls_erro)								
								Return False							
							End If
						End If
					Else
						If lvdc_divisao_dif > 0.00 Then
							lvdc_Aux = lvdc_divisao_dif
						Else  
							//Verifica se o valor do item n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ suficiente, deixa o item com 1 centavo e o resto tira da diferen$$HEX1$$e700$$ENDHEX$$a.
							If lds_cancelamentos.Object.total_cancelado[ll_row_Canc] <= Abs(lvdc_dif_cancelamento) Then
								If lds_cancelamentos.Object.total_cancelado[ll_row_Canc] > 0.01 Then
									lvdc_Aux = 0.01 - lds_cancelamentos.Object.total_cancelado[ll_row_Canc]
								Else
									lvdc_Aux = 0.00
								End If
							Else
								lvdc_Aux = lvdc_dif_cancelamento
							End If
						End If
					End If					
					lds_cancelamentos.Object.total_cancelado[ll_row_Canc] = lds_cancelamentos.Object.total_cancelado[ll_row_Canc] + lvdc_Aux
					lvdc_dif_cancelamento -= lvdc_Aux
				End If				
				
				ll_produto = lds_cancelamentos.object.cd_produto[ll_Row_canc]
				ll_find    = lds_Produtos.Find ("cd_produto = " + STRING( ll_produto ), 1 ,lds_Produtos.RowCount())				
				If ll_find > 0 Then
					lds_Produtos.Object.TotalCanc[ll_find] = lds_cancelamentos.Object.total_cancelado[ll_row_Canc]			
				Else
					If ll_find = 0 Then  //N$$HEX1$$e300$$ENDHEX$$o encontrou, incluir no grid produtos
						//Busca Tributacao
						lvo_Produto.of_Localiza_Codigo_Interno(ll_Produto) 			
						If Not lvo_Produto.Localizado Then
							gvo_aplicacao.Of_Grava_Log("Grava$$HEX2$$e700e300$$ENDHEX$$o Arquivo Redu$$HEX2$$e700e300$$ENDHEX$$oZ - Erro ao buscar dados do produto cancelado. Filial: "+String(ll_filial) + " ECF: " + String(ll_ecf)  + " Mapa: " + String(ll_mapa) + " Data Fiscal: " + ls_dataRZ + " (of_gera_blocox_reducao).")							
							Return False				
						End If
						
						lvo_Atributo = lvo_Fiscal.of_Atributo_Fiscal_Produto(lvo_Produto)						
						If Not lvo_Atributo.Localizado Then
							gvo_aplicacao.Of_Grava_Log("Grava$$HEX2$$e700e300$$ENDHEX$$o Arquivo Redu$$HEX2$$e700e300$$ENDHEX$$oZ - Erro ao buscar dados do atributo fiscal produto: " + String(ll_Produto) + ".(of_gera_blocox_reducao).")							
							Return False
						End If
						
						ll_nova_linha = lds_produtos.InsertRow(0)
						lds_produtos.object.cd_produto					[ll_nova_linha] = lds_cancelamentos.object.cd_produto[ll_Row_canc]
						lds_produtos.object.de_produto					[ll_nova_linha] = lds_cancelamentos.object.de_produto[ll_Row_canc]
						lds_produtos.object.cd_unidade_medida_venda[ll_nova_linha] = lds_cancelamentos.object.cd_unidade_medida_venda[ll_Row_canc]
						lds_produtos.object.de_codigo_barras			[ll_nova_linha] = lds_cancelamentos.object.de_codigo_barras[ll_Row_canc]						
						lds_produtos.object.cd_cest							[ll_nova_linha] = lds_cancelamentos.object.cd_cest[ll_Row_canc]
						lds_produtos.object.nr_classificacao_fiscal		[ll_nova_linha] = lds_cancelamentos.object.nr_classificacao_fiscal[ll_Row_canc]
						lds_produtos.object.pc_icms						[ll_nova_linha] = lvo_atributo.pc_icms
						lds_produtos.object.cd_cst_tributacao			[ll_nova_linha] = RightA(lvo_atributo.cd_situacao_tributaria,1) + '0'
						lds_produtos.object.cd_produto_sap				[ll_nova_linha] = lds_cancelamentos.object.cd_produto_sap[ll_Row_canc]
						lds_produtos.object.qtd								[ll_nova_linha] = 0   //????????
						lds_produtos.object.totalitem						[ll_nova_linha] = 0
						lds_produtos.object.Totaldesc						[ll_nova_linha] = 0
						lds_produtos.object.TotalCanc						[ll_nova_linha] = lds_cancelamentos.object.total_cancelado[ll_Row_canc]						
						lb_ordena = True
					Else			
						gvo_aplicacao.Of_Grava_Log("Grava$$HEX2$$e700e300$$ENDHEX$$o Arquivo Redu$$HEX2$$e700e300$$ENDHEX$$oZ - Erro find do produto: " + String(ll_Produto) + ".(of_gera_blocox_reducao).")							
						Return False
					End If
				End If	
			Next
			If lb_ordena Then
				lds_produtos.SetSort("i.pc_icms, i.cd_cst_tributacao")
				lds_produtos.Sort()				
			End If
		End If
	Else
		gvo_aplicacao.Of_Grava_Log("Grava$$HEX2$$e700e300$$ENDHEX$$o Arquivo Redu$$HEX2$$e700e300$$ENDHEX$$oZ - Erro ao buscar cancelamentos. " + lds_cancelamentos.itr_transacao.is_lasterrortext + "(of_gera_blocox_reducao).")						
		Return False							
	End If	
	//Fim produtos cancelados		
	
	ls_Registro += This.of_Abre_Tag('TotalizadoresParciais', 4)	+ &
						This.of_Abre_Tag('TotalizadorParcial', 5)		

	For ll_Row = 1 To lds_Produtos.RowCount()
		If ll_Row = 1 Then //Verifica diferen$$HEX1$$e700$$ENDHEX$$as
			lvdc_Sum_Itens 			= lds_Produtos.GetItemDecimal(lds_Produtos.RowCount(), "sum_totalitem")
			lvdc_Sum_Desconto 		= lds_Produtos.GetItemDecimal(lds_Produtos.RowCount(), "sum_totaldesc")		
			
			lvdc_dif_venda_liquida 	= (lvdc_total_F1 + lvdc_total_I1 + lvdc_total_N1 + lvdc_Sum_Aliquotas) - lvdc_Sum_Itens
			lvdc_dif_desconto = lvdc_desconto_mapa - lvdc_Sum_Desconto
			If lvdc_dif_venda_liquida <> 0.00  Or lvdc_dif_desconto <> 0.00 Then
				If Abs(lvdc_dif_venda_liquida) > lvdc_dif_limite Or Abs(lvdc_dif_desconto) > lvdc_dif_limite Then //diferen$$HEX1$$e700$$ENDHEX$$a maior que 0,50 n$$HEX1$$e300$$ENDHEX$$o continua
					gvo_aplicacao.Of_Grava_Log("Valor de diferen$$HEX1$$e700$$ENDHEX$$a na venda liquida e desconto supera o limite permitido.Filial: "+String(ll_filial) + " ECF: " + String(ll_ecf)  + " Mapa: " + String(ll_mapa) + " Data Fiscal: " + ls_dataRZ + "(of_gera_blocox_reducao_matriz).")
					ls_erro = "XML n$$HEX1$$e300$$ENDHEX$$o gerado. Valor de diferen$$HEX1$$e700$$ENDHEX$$a na venda liquida ou desconto supera o limite permitido. Diferen$$HEX1$$e700$$ENDHEX$$a venda: " + String(lvdc_dif_venda_liquida, '0.00') + ". Diferen$$HEX1$$e700$$ENDHEX$$a Desconto: " + String(lvdc_dif_desconto, '0.00')
					This.of_atualiza_historico_erro( ll_filial, pl_seq_historico, ls_erro)					
					Return False
				End If	
	
				//Busca totais por Situacao
				lvdc_sum_i1 			= lds_Produtos.GetItemDecimal(ll_find, "sum_grupo_i1")
				lvdc_dif_i1 				= lvdc_total_I1 - lvdc_sum_i1							
				lvdc_sum_n1 			= lds_Produtos.GetItemDecimal(ll_find, "sum_grupo_n1")
				lvdc_dif_n1 				= lvdc_total_N1 - lvdc_sum_n1
				lvdc_sum_f1 			= lds_Produtos.GetItemDecimal(ll_find, "sum_grupo_f1")
				lvdc_dif_f1				= lvdc_total_F1 - lvdc_sum_f1				
				lvdc_sum_17 			= lds_Produtos.GetItemDecimal(ll_find, "sum_grupo_17")
				lvdc_dif_17 				= lvdc_Sum_Aliq17 - lvdc_sum_17
				lvdc_sum_25 			= lds_Produtos.GetItemDecimal(ll_find, "sum_grupo_25")				
				lvdc_dif_25 				= lvdc_Sum_Aliq25 - lvdc_sum_25
				lvdc_sum_tributado	= lvdc_sum_17 + lvdc_sum_25
				lvdc_dif_tributado 		= lvdc_Sum_Aliquotas - lvdc_sum_tributado
			End If
		End If
		
		If IsNull(lds_Produtos.Object.cd_cest[ll_Row]) Or Trim(lds_Produtos.Object.cd_cest[ll_Row]) = '' Then
			ls_cest = '0000000'
		Else
			ls_cest = lds_Produtos.Object.cd_cest[ll_Row]
		End If			
		If IsNull(String(lds_Produtos.Object.nr_classificacao_fiscal[ll_Row],'00000000')) Then	
			ls_ncm = '00000000'
		Else
			ls_ncm = String(lds_Produtos.Object.nr_classificacao_fiscal[ll_Row],'00000000')
		End If	
		//****TRATAMENTO PARA HOMOLOGACAO****** RETIRAR PARA PRODUCAO
		//		NCMs 34011190, 34011900, 34011900, 34012010 e 34013000 aceitar$$HEX1$$e300$$ENDHEX$$o somente os CESTs 2003400, 2003500, 2003501, 2003600, 2003700, 2802000, 2802100, 2802200 e 2802300.
		//If ls_ncm = '34011190' or ls_ncm = '34011900' or ls_ncm = '34011900' or ls_ncm = '34012010' or ls_ncm = '34013000' Then
		//	ls_cest = '2003400'
		//End If		
		//****		
		If IsNull(lds_Produtos.object.de_codigo_barras[ll_row]) Or Trim(lds_Produtos.object.de_codigo_barras[ll_row]) = '' Then
			ls_cod_barras = '0'
		Else
			Choose Case lds_Produtos.object.cd_produto[ll_row]    //Tratamentos para produtos "servi$$HEX1$$e700$$ENDHEX$$o", ou produtos inativos
				Case 684431,735582,577625,723786,712055,735909,735947,135570,683845,123060,693844,135562,693843,733631,705965,700495,707440,707439,700118,735001,735001,734997,733159,733164,736956,736957,738063,738062,733651,705861
					ls_cod_barras = '0'
				Case Else
					ls_cod_barras = lds_Produtos.object.de_codigo_barras[ll_row]					
			End Choose		
		End If		
		
		ls_descricao = gf_retira_caracteres_especiais(lds_Produtos.object.de_produto[ll_row])		
		ls_cst_trib = Trim(lds_Produtos.object.cd_cst_tributacao[ll_row])
//		 ls_cst_trib_ant
		lvdc_icms = lds_Produtos.object.pc_icms[ll_row]
		//lvdc_icms_ant
		If lvdc_icms = 0 Then  //produto com substituicao, isento, ou sem incidencia
			Choose Case ls_cst_trib
				Case '40'
					ls_nome_totalizador = 'I1'
					lvdc_valor_imposto = lvdc_total_I1
					If lvdc_dif_i1 <> 0.00 Then //Diferen$$HEX1$$e700$$ENDHEX$$a
						If lds_Produtos.object.totalitem[ll_row] > 0 And lds_Produtos.object.totalitem[ll_row] > Abs(lvdc_dif_i1) Then												
							lvdc_Aux = lvdc_dif_i1
							lds_Produtos.object.totalitem[ll_row] = lds_Produtos.object.totalitem[ll_row] + lvdc_Aux
							lvdc_dif_i1 -= lvdc_Aux
						End If
					End If
				Case '41'
					ls_nome_totalizador = 'N1'
					lvdc_valor_imposto = lvdc_total_N1
					If lvdc_dif_n1 <> 0.00 Then //Diferen$$HEX1$$e700$$ENDHEX$$a
						If lds_Produtos.object.totalitem[ll_row] > 0 And lds_Produtos.object.totalitem[ll_row] > Abs(lvdc_dif_n1) Then							
							lvdc_Aux = lvdc_dif_n1
							lds_Produtos.object.totalitem[ll_row] = lds_Produtos.object.totalitem[ll_row] + lvdc_Aux
							lvdc_dif_n1 -= lvdc_Aux
						End If
					End If					
				Case Else
					ls_nome_totalizador = 'F1'
					lvdc_valor_imposto = lvdc_total_F1
					If lvdc_dif_f1 <> 0.00 Then //Diferen$$HEX1$$e700$$ENDHEX$$a
						If lds_Produtos.object.totalitem[ll_row] > 0 And lds_Produtos.object.totalitem[ll_row] > Abs(lvdc_dif_f1) Then							
							lvdc_Aux = lvdc_dif_f1
							lds_Produtos.object.totalitem[ll_row] = lds_Produtos.object.totalitem[ll_row] + lvdc_Aux
							lvdc_dif_f1 -= lvdc_Aux
						End If
					End If
					//Diferen$$HEX1$$e700$$ENDHEX$$a de desconto jogo somente aqui
					If lvdc_dif_desconto <> 0.00 And lds_Produtos.object.totaldesc[ll_row] > 0 And lds_Produtos.object.totaldesc[ll_row] > Abs(lvdc_dif_desconto) Then //Diferen$$HEX1$$e700$$ENDHEX$$a DESCONTO						
						lvdc_Aux = lvdc_dif_desconto
						lds_Produtos.object.totaldesc[ll_row] = lds_Produtos.object.totaldesc[ll_row] + lvdc_Aux
						lvdc_dif_desconto -= lvdc_Aux						
					End If										
			End Choose
			
			If ls_cst_trib <> ls_cst_trib_ant Then
				If (ls_cst_trib_ant = '' or IsNull(ls_cst_trib_ant)) Then  //1$$HEX1$$aa00$$ENDHEX$$ vez
					ls_Registro += This.of_Elemento('Nome', ls_nome_totalizador, 6)	+ &
										This.of_Elemento('Valor', String(lvdc_valor_imposto,'####0.00'), 6)	+ &
										This.of_Abre_Tag('ProdutosServicos', 6)
				Else	//precisa fechar tag de totalizador anterior e abrir para o novo
					ls_Registro += 	This.of_Fecha_Tag('ProdutosServicos', 6)	+ &					
										This.of_Fecha_Tag('TotalizadorParcial', 5)	+ &
										This.of_Abre_Tag('TotalizadorParcial', 5)	+ &
										This.of_Elemento('Nome', ls_nome_totalizador, 6)	+ &
										This.of_Elemento('Valor', String(lvdc_valor_imposto,'####0.00'), 6)	+ &
										This.of_Abre_Tag('ProdutosServicos', 6)										
				End If
			End If			
			
			ls_Registro += This.of_Abre_Tag('Produto', 7)	+ &
								This.of_Elemento('Descricao', ls_descricao, 8)
			If ls_cod_barras = '0' Then
				ls_Registro += This.of_Elemento_Vazio('CodigoGTIN', '', 8)
			Else
				ls_Registro +=	This.of_Elemento('CodigoGTIN', ls_cod_barras, 8)
			End if								
			ls_Registro += This.of_Elemento('CodigoCEST', ls_cest, 8)+ &								
								This.of_Elemento('CodigoNCMSH', ls_ncm, 8)
			If Not IsNull(This.dt_envio_codigo_sap) Then
				If pdt_data_fiscal >= This.dt_envio_codigo_sap Then
					ls_Registro += This.of_Elemento('CodigoProprio', lds_Produtos.object.cd_produto_sap[ll_row], 8)								
				Else
					ls_Registro += This.of_Elemento('CodigoProprio', String(lds_Produtos.object.cd_produto[ll_row]), 8)								
				End If				
			Else
				ls_Registro += This.of_Elemento('CodigoProprio', String(lds_Produtos.object.cd_produto[ll_row]), 8)												
			End If
			ls_Registro += 	This.of_Elemento('Quantidade', String(lds_Produtos.object.qtd[ll_row],'####0.000'), 8)		+ &
								This.of_Elemento('Unidade', lds_Produtos.object.cd_unidade_medida_venda[ll_row], 8) + &
								This.of_Elemento('ValorDesconto', String(lds_Produtos.object.totaldesc[ll_row],'####0.00'), 8) + &
								This.of_Elemento('ValorAcrescimo', String(0,'####0.00'), 8) + &
								This.of_Elemento('ValorCancelamento', String(lds_Produtos.object.totalcanc[ll_row],'####0.00'), 8) + &
								This.of_Elemento('ValorTotalLiquido', String(lds_Produtos.object.totalitem[ll_row],'####0.00'), 8) + &								
								This.of_Fecha_Tag('Produto', 7)
			
			ls_cst_trib_ant = ls_cst_trib	
			
		Else		//tributados
			If lvdc_dif_tributado <> 0.00 Then //Diferen$$HEX1$$e700$$ENDHEX$$a
				Choose Case Long(lvdc_icms)
					Case 17
						If lvdc_dif_17 <> 0.00 Then //Diferen$$HEX1$$e700$$ENDHEX$$a 17
							If lds_Produtos.object.totalitem[ll_row] > 0 And lds_Produtos.object.totalitem[ll_row] > Abs(lvdc_dif_17) Then
								lvdc_Aux = lvdc_dif_17
								lds_Produtos.object.totalitem[ll_row] = lds_Produtos.object.totalitem[ll_row] + lvdc_dif_17
								lvdc_dif_17 -= lvdc_Aux
								lvdc_dif_tributado -= lvdc_Aux
							End If
						End If
					Case 25
						If lvdc_dif_25 <> 0.00 Then //Diferen$$HEX1$$e700$$ENDHEX$$a 25
							If lds_Produtos.object.totalitem[ll_row] > 0 And lds_Produtos.object.totalitem[ll_row] > Abs(lvdc_dif_25) Then
								lvdc_Aux = lvdc_dif_25
								lds_Produtos.object.totalitem[ll_row] = lds_Produtos.object.totalitem[ll_row] + lvdc_Aux
								lvdc_dif_25 -= lvdc_Aux
								lvdc_dif_tributado -= lvdc_Aux								
							End If
						End If					
				End Choose
			End If
			
			ls_nome_totalizador = String(Long(lvdc_icms))
			If LenA(ls_nome_totalizador) = 1 Then
				ls_nome_totalizador = 'T0'+ls_nome_totalizador+'00'
			Else
				ls_nome_totalizador = 'T'+ls_nome_totalizador+'00'
			End If
			
			ls_icms = gf_valor_com_ponto(lvdc_icms)			
			
			ll_find    = lds_mapa_aliq.Find ("pc_aliquota = " + ls_icms,1,lds_mapa_aliq.RowCount())
		
			If ll_find > 0 Then
				lvdc_valor_imposto = lds_mapa_aliq.Object.vl_base_calculo [ll_find]
			Else
				If ll_find < 0 Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no Find de aliquiotas.",StopSign!)
					gvo_aplicacao.Of_Grava_Log("Grava$$HEX2$$e700e300$$ENDHEX$$o Arquivo Redu$$HEX2$$e700e300$$ENDHEX$$oZ - Erro no Find de aliquiotas.(of_gera_blocox_reducao).")												
					Return False
				Else
					//N$$HEX1$$e300$$ENDHEX$$o encontrou a aliquota no find, indica que o produto apenas foi cancelado, ent$$HEX1$$e300$$ENDHEX$$o o totalizado da aliquota $$HEX1$$e900$$ENDHEX$$ zero.
					lvdc_valor_imposto = 0.00
				End If
			End If			
			
			If lvdc_icms <> lvdc_icms_ant Then
				If (lvdc_icms_ant = 0 or IsNull(lvdc_icms_ant)) Then  //1$$HEX1$$aa00$$ENDHEX$$ vez
					If (Trim(ls_cst_trib_ant) <> '' And not IsNull(ls_cst_trib_ant)) Then //Tinha produtos sem tributacao antes
						ls_Registro += 	This.of_Fecha_Tag('ProdutosServicos', 6)	+ &					
											This.of_Fecha_Tag('TotalizadorParcial', 5)	+ &
											This.of_Abre_Tag('TotalizadorParcial', 5)					
					End If
					ls_Registro += This.of_Elemento('Nome', ls_nome_totalizador, 6)	+ &
										This.of_Elemento('Valor', String(lvdc_valor_imposto,'####0.00'), 6)	+ &
										This.of_Abre_Tag('ProdutosServicos', 6)
				Else	//precisa fechar tag de totalizador anterior e abrir para o novo
					ls_Registro += 	This.of_Fecha_Tag('ProdutosServicos', 6)	+ &					
										This.of_Fecha_Tag('TotalizadorParcial', 5)	+ &
										This.of_Abre_Tag('TotalizadorParcial', 5)	+ &
										This.of_Elemento('Nome', ls_nome_totalizador, 6)	+ &
										This.of_Elemento('Valor', String(lvdc_valor_imposto,'####0.00'), 6)	+ &
										This.of_Abre_Tag('ProdutosServicos', 6)										
				End If
				
			End If
			
			ls_Registro += This.of_Abre_Tag('Produto', 7)	+ &
								This.of_Elemento('Descricao', ls_descricao, 8)
			If ls_cod_barras = '0' Then
				ls_Registro += This.of_Elemento_Vazio('CodigoGTIN', '', 8)
			Else
				ls_Registro +=	This.of_Elemento('CodigoGTIN', ls_cod_barras, 8)
			End if								
			ls_Registro += This.of_Elemento('CodigoCEST', ls_cest, 8)+ &
								This.of_Elemento('CodigoNCMSH', ls_ncm, 8)
			If Not IsNull(This.dt_envio_codigo_sap) Then
				If pdt_data_fiscal >= This.dt_envio_codigo_sap Then
					ls_Registro += This.of_Elemento('CodigoProprio', lds_Produtos.object.cd_produto_sap[ll_row], 8)								
				Else
					ls_Registro += This.of_Elemento('CodigoProprio', String(lds_Produtos.object.cd_produto[ll_row]), 8)								
				End If				
			Else
				ls_Registro += This.of_Elemento('CodigoProprio', String(lds_Produtos.object.cd_produto[ll_row]), 8)												
			End If
			ls_Registro += 	This.of_Elemento('Quantidade', String(lds_Produtos.object.qtd[ll_row],'####0.00'), 8)		+ &
								This.of_Elemento('Unidade', lds_Produtos.object.cd_unidade_medida_venda[ll_row], 8) + &
								This.of_Elemento('ValorDesconto', String(lds_Produtos.object.totaldesc[ll_row],'####0.00'), 8) + &
								This.of_Elemento('ValorAcrescimo', String(0,'####0.00'), 8) + &
								This.of_Elemento('ValorCancelamento', String(lds_Produtos.object.totalcanc[ll_row],'####0.00'), 8) + &
								This.of_Elemento('ValorTotalLiquido', String(lds_Produtos.object.totalitem[ll_row],'####0.00'), 8) + &
								This.of_Fecha_Tag('Produto', 7)
								
			lvdc_icms_ant = lvdc_icms			
		End If	
	Next
	
	//Redu$$HEX2$$e700e300$$ENDHEX$$o Z sem movimento, tem que gravar os totalizadores zerados.
	If lds_Produtos.RowCount() = 0 Then
		ls_nome_totalizador = 'F1'  //J$$HEX1$$e100$$ENDHEX$$ abriu TAG antes do FOR
		ls_Registro += This.of_Elemento('Nome', ls_nome_totalizador, 6)	+ &
							This.of_Elemento('Valor', String(0,'####0.00'), 6)	+ &
							This.of_Abre_Tag('ProdutosServicos', 6) + &
							This.of_Fecha_Tag('ProdutosServicos', 6)	+ &					
							This.of_Fecha_Tag('TotalizadorParcial', 5)					
		
		ls_nome_totalizador = 'I1'
		ls_Registro += This.of_Abre_Tag('TotalizadorParcial', 5)	+ &
							This.of_Elemento('Nome', ls_nome_totalizador, 6)	+ &
							This.of_Elemento('Valor', String(0,'####0.00'), 6)	+ &
							This.of_Abre_Tag('ProdutosServicos', 6) + &
							This.of_Fecha_Tag('ProdutosServicos', 6)	+ &					
							This.of_Fecha_Tag('TotalizadorParcial', 5)					
		
		ls_nome_totalizador = 'N1'		
		ls_Registro += This.of_Abre_Tag('TotalizadorParcial', 5)	+ &
							This.of_Elemento('Nome', ls_nome_totalizador, 6)	+ &
							This.of_Elemento('Valor', String(0,'####0.00'), 6)	+ &
							This.of_Abre_Tag('ProdutosServicos', 6) + &
							This.of_Fecha_Tag('ProdutosServicos', 6)	+ &					
							This.of_Fecha_Tag('TotalizadorParcial', 5)		
							
		//Busca aliquotas ICMS na base
		dc_uo_ds_base lds_aliquotas
		lds_aliquotas = Create dc_uo_ds_base

		If Not lds_aliquotas.of_ChangeDataObject('ds_ge039_aliquota_ecf') Then 
			gvo_aplicacao.Of_Grava_Log("Grava$$HEX2$$e700e300$$ENDHEX$$o Arquivo Redu$$HEX2$$e700e300$$ENDHEX$$oZ - Erro ao buscar al$$HEX1$$ed00$$ENDHEX$$quotas para Redu$$HEX2$$e700e300$$ENDHEX$$o sem movimento. Filial: "+String(ll_filial) + " ECF: " + String(ll_ecf)  + " Mapa: " + String(ll_mapa) + " Data Fiscal: " + ls_dataRZ + "(of_gera_blocox_reducao).")									
			Return False				
		End If			

		lds_aliquotas.of_RestoreSqlOriginal()
		lds_aliquotas.Retrieve(gvo_parametro.ivs_uf_filial)

		For ll_Row = 1 To lds_aliquotas.RowCount()
			lvdc_icms = lds_aliquotas.object.pc_icms [ll_row] + lds_aliquotas.object.pc_fcp [ll_row]			
			
			ls_nome_totalizador = String(Long(lvdc_icms))
			If LenA(ls_nome_totalizador) = 1 Then
				ls_nome_totalizador = 'T0'+ls_nome_totalizador+'00'
			Else
				ls_nome_totalizador = 'T'+ls_nome_totalizador+'00'
			End If
			ls_Registro += This.of_Abre_Tag('TotalizadorParcial', 5)	+ &
								This.of_Elemento('Nome', ls_nome_totalizador, 6)	+ &
								This.of_Elemento('Valor', String(0,'####0.00'), 6)	+ &
								This.of_Abre_Tag('ProdutosServicos', 6) + &
								This.of_Fecha_Tag('ProdutosServicos', 6)	+ &					
								This.of_Fecha_Tag('TotalizadorParcial', 5)					
		Next
		
		Destroy(lds_aliquotas)							
	Else
		ls_Registro += 	This.of_Fecha_Tag('ProdutosServicos', 6)	+ &					
							This.of_Fecha_Tag('TotalizadorParcial', 5)
	End If

	ls_Registro += 	This.of_Fecha_Tag('TotalizadoresParciais', 4)	+ &
						This.of_Fecha_Tag('DadosReducaoZ', 3)	+ &
						This.of_Fecha_Tag('Ecf', 2)	+ &
						This.of_Fecha_tag('Mensagem'	, 1) 				
Else
	gvo_aplicacao.Of_Grava_Log("Grava$$HEX2$$e700e300$$ENDHEX$$o Arquivo Redu$$HEX2$$e700e300$$ENDHEX$$oZ - Erro ao carregar os produtos vendidos. Filial: "+String(ll_filial) + " ECF: " + String(ll_ecf)  + " Mapa: " + String(ll_mapa) + " Data Fiscal: " + ls_dataRZ + "(of_gera_blocox_reducao).")							
	Return False				
End If

//ASSINATURA
ls_Registro += This.of_Abre_Tag('Signature xmlns="http://www.w3.org/2000/09/xmldsig#"',1)  + &
					This.of_Abre_Tag('SignedInfo', 2)	+ &
					This.of_Abre_Tag('CanonicalizationMethod Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315"',3) + &
					This.of_Fecha_Tag('CanonicalizationMethod',3) +&
					This.of_Abre_Tag('SignatureMethod Algorithm="http://www.w3.org/2000/09/xmldsig#rsa-sha1"', 3) + &					
					This.of_Fecha_Tag('SignatureMethod',3) +&
					This.of_Abre_Tag('Reference URI=""', 3)	+ &
					This.of_Abre_Tag('Transforms', 4)	+ &
					This.of_Abre_Tag('Transform Algorithm="http://www.w3.org/2000/09/xmldsig#enveloped-signature"', 5)	+ &
					This.of_Fecha_Tag('Transform',5) +&
					This.of_Abre_Tag('Transform Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315"', 5)	+ &
					This.of_Fecha_Tag('Transform',5) +&			
					This.of_Fecha_Tag('Transforms',4) +&
					This.of_Abre_Tag('DigestMethod Algorithm="http://www.w3.org/2000/09/xmldsig#sha1"', 4)	+ &
					This.of_Fecha_Tag('DigestMethod',4) +&
					This.of_Elemento('DigestValue', '', 4)		+ &
					This.of_Fecha_Tag('Reference',3) +&
					This.of_Fecha_Tag('SignedInfo',2) +&										
					This.of_Elemento('SignatureValue', '', 1)	+ &
					This.of_Abre_Tag('KeyInfo', 2)	+ &
					This.of_Abre_Tag('X509Data',3) + &
					This.of_Elemento('X509Certificate', '', 4)		+ &					
					This.of_Fecha_Tag('X509Data',3) +&					
					This.of_Fecha_Tag('KeyInfo',2) +&										
					This.of_Fecha_Tag('Signature', 1)+ &
											 '</ReducaoZ>'	

//Nome do arquivo: Filial(0000) + Sequencial tabela(0000000) + ECF(000) + Qt_RZ(0000) + DataReducao(ddmmyyy)  + datahorageracao(ddmmyyyhhmm)  -  Ex: 0563000002014012126072019260720190800.xml
ldt_data_geracao = gf_getserverdate()
ls_data_hora = String(ldt_data_geracao, 'DDMMYYYY') + String(ldt_data_geracao, 'HHMM')

If This.ivb_padraoh Then
	ls_arquivo = ls_Diretorio_Arquivo + 'Reducao Z ' + ls_dataRZ + '.xml'
	ivs_Nome_Arquivo = 'Reducao Z ' + ls_dataRZ
	ivs_Arquivo_Xml = ls_Diretorio_Arquivo + ivs_Nome_Arquivo + '_ORI.xml'	
Else
	ls_arquivo = ls_Diretorio_Arquivo + String(ll_filial, '0000') + String(pl_seq_historico,'0000000') + String(ll_ecf,'000') + ls_qtRZ + ls_dataRZ + ls_data_hora +'.xml'
	ivs_Nome_Arquivo = String(ll_filial, '0000') + String(pl_seq_historico,'0000000') +  String(ll_ecf,'000') + ls_qtRZ + ls_dataRZ + ls_data_hora
	ivs_Arquivo_Xml = ls_Diretorio_Arquivo + ivs_Nome_Arquivo +'.xml'
End If

If FileExists( ls_Arquivo ) Then
	FileDelete( ls_Arquivo )
End If

//Abre o Arquivo		 
This.of_abre_arquivo()
This.of_Grava_Arquivo(ls_Registro)
FileClose(ivi_Arquivo_Xml)

Destroy(lds_reducao)
Destroy(lds_Produtos)
Destroy(lds_mapa_aliq)
Destroy(lds_cancelamentos)
If IsValid(lvo_produto) Then Destroy(lvo_produto) 
If IsValid(lvo_Fiscal) Then Destroy(lvo_Fiscal)
If IsValid(lvo_Atributo) Then Destroy(lvo_Atributo)

//Aqui far$$HEX1$$e100$$ENDHEX$$ o envio para o Central
//Atualizar informa$$HEX2$$e700e300$$ENDHEX$$o de gera$$HEX2$$e700e300$$ENDHEX$$o e envio na tabela historico.
//Assinatura digital e envio do arquivo ser$$HEX1$$e100$$ENDHEX$$ feito no Central
If FileExists(ivs_Arquivo_Xml) Then //gerou xml
	
	Update historico_envio_arquivo_paf
	Set dh_geracao_arquivo = :ldt_data_geracao,
		 id_enviado_matriz = :ls_enviado
	Where cd_filial   = :ll_filial
		and nr_sequencial = :pl_seq_historico
	Using Sqlca;
	
	If Sqlca.Sqlcode = -1 Then
		Sqlca.of_LogDbError(gvo_Aplicacao.ivi_Log,"Atualiza$$HEX2$$e700e300$$ENDHEX$$o Historico PAF.")
		Return False
	Else
		Sqlca.of_Commit()	
		lb_sucesso = true
	End If	
Else
	lb_sucesso = False
End If

If lb_sucesso Then
	gvo_aplicacao.Of_Grava_Log("Grava$$HEX2$$e700e300$$ENDHEX$$o Arquivo Redu$$HEX2$$e700e300$$ENDHEX$$oZ - XML gerado. Data: " + String(pdt_data_fiscal,'DDMMYYYY') + ' ECF: ' + String(pl_ecf) + " (of_gera_blocox_reducao).")				
	Return True
Else
	Return False
End If 
end function

on uo_menu_fiscal.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_menu_fiscal.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;String ls_Autenticacao_Caixa, ls_credenciamento, ls_enviar_blocox, ls_gerar_blocox, ls_data_blocox, ls_data_envio_sap

If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = 'FI' Then
	Select vl_parametro
	Into :ls_Autenticacao_Caixa
	From parametro_loja
	Where cd_filial = :gvo_parametro.cd_filial
	And cd_parametro = 'ID_AUTENTICACAO_PAFECF_CL'
	Using SQLCa;
	
	This.ivs_MD5 = ls_Autenticacao_Caixa
	
	Select vl_parametro
	Into :ls_credenciamento
	From parametro_loja
	Where cd_filial = :gvo_parametro.cd_filial
	And cd_parametro = 'NR_CREDENCIAMENTO_PAFECF'
	Using SQLCa;
	
	This.is_numero_credenciamento = ls_credenciamento
	
	Select vl_parametro
	Into :ls_enviar_blocox
	From parametro_loja
	Where cd_filial = :gvo_parametro.cd_filial
	And cd_parametro = 'ID_ENVIA_ARQUIVO_BLOCOX'
	Using SQLCa;
	
	This.id_envia_blocoX = ls_enviar_blocox	
	
	Select vl_parametro
	Into :ls_gerar_blocox
	From parametro_loja
	Where cd_filial = :gvo_parametro.cd_filial
	And cd_parametro = 'ID_GERA_ARQUIVO_BLOCOX'
	Using SQLCa;
	
	This.id_gera_blocoX = ls_gerar_blocox		
	
	Select vl_parametro
	Into :ls_data_blocox
	From parametro_loja
	Where cd_filial = :gvo_parametro.cd_filial
	And cd_parametro = 'DT_INICIO_BLOCOX'
	Using SQLCa;
	
	If IsDate(ls_data_blocox) Then
		This.dt_inicio_blocox = Date(ls_data_blocox)
	Else
		IsNull(This.dt_inicio_blocox)
	End If
	
	Select vl_parametro
	Into :ls_data_envio_sap
	From parametro_loja
	Where cd_filial = :gvo_parametro.cd_filial
	And cd_parametro = 'DH_INICIO_ENVIO_CODIGO_SAP_XML'
	Using SQLCa;
	
	If IsDate(ls_data_envio_sap) Then
		This.dt_envio_codigo_sap = Date(ls_data_envio_sap)
	Else
		IsNull(This.dt_envio_codigo_sap)
	End If	
Else
	uo_Parametro_Filial lvo_Parametro
	lvo_Parametro = Create uo_Parametro_Filial
	
	If lvo_Parametro.of_Localiza_Parametro("ID_AUTENTICACAO_PAFECF_CL", ref ls_Autenticacao_Caixa) Then
		This.ivs_MD5 = ls_Autenticacao_Caixa
	End If
	
	lvo_Parametro.of_Localiza_Parametro("ID_ENVIA_ARQUIVO_BLOCOX", ref This.id_envia_blocoX, False)
	lvo_Parametro.of_Localiza_Parametro("ID_GERA_ARQUIVO_BLOCOX", ref This.id_gera_blocoX, False)	
	lvo_Parametro.of_Localiza_Parametro("CD_CEST_GENERICO", ref This.cd_cest_generico, False)
	lvo_Parametro.of_Localiza_Parametro("NR_CREDENCIAMENTO_PAFECF", ref This.is_numero_credenciamento, False)
	lvo_Parametro.of_Localiza_Parametro("DT_INICIO_BLOCOX", ref ls_data_blocox, False)
	If IsDate(ls_data_blocox) Then
		This.dt_inicio_blocox = Date(ls_data_blocox)
	Else
		IsNull(This.dt_inicio_blocox)
	End If	
	lvo_Parametro.of_Localiza_Parametro("DH_INICIO_ENVIO_CODIGO_SAP_XML", ref ls_data_envio_sap, False)
	If IsDate(ls_data_envio_sap) Then
		This.dt_envio_codigo_sap = Date(ls_data_envio_sap)
	Else
		IsNull(This.dt_envio_codigo_sap)
	End If		
	
	Destroy(lvo_Parametro)
End if

// Localiza$$HEX2$$e700e300$$ENDHEX$$o da Vers$$HEX1$$e300$$ENDHEX$$o do Sistema ----------------------------------------- //
Select nr_versao
  Into :nr_Versao_Caixa
  From sistema
 Where cd_sistema = 'CL'
 Using SQLCa;

If SQLCa.SQLCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao localizar a vers$$HEX1$$e300$$ENDHEX$$o de caixa do sistema.")
End If
//--------------------------------------------------------------------------- //

If ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "Desenvolvimento", "Homologacao","") = 'S' Then
	ivb_padraoH = True
End If

ids_Arquivo = Create DataStore
ids_Arquivo.DataObject = "ds_ge038_registros_paf"

This.of_atualiza_dll_sign()
end event

event destructor;Destroy ids_Arquivo
end event

