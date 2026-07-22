HA$PBExportHeader$uo_ge481_wms_imposto.sru
forward
global type uo_ge481_wms_imposto from uo_ge481_subida_generica
end type
end forward

global type uo_ge481_wms_imposto from uo_ge481_subida_generica autoinstantiate
end type

type variables
Long il_Integracao
String is_tipo_movimento, is_cd_centro_custo_sap
String is_Texto_Item = ''

Long 		il_cd_tabela, il_nr_atualizacao
String 	is_nm_Tabela, is_de_chave_sap
String 	is_ws, is_xmlns, is_id_tipo
end variables

forward prototypes
public function boolean _of_parametros ()
public function boolean _of_monta_xml_item (datastore pds_dados, long pl_linha, ref string ps_xml, ref string ps_log)
public function boolean _of_processa_retorno_xml (string as_xml, ref string as_log)
public function boolean of_gera_envio_sap (long pl_nr_controle, string ps_ambiente_sap, ref string ps_log)
public function boolean of_atualiza_processado (datastore pds_itens, long pl_linha, long pl_nr_atualizacao, string ps_status, string as_mensagem, ref string as_log)
public function boolean _of_monta_xml_cab (datastore pds_cab, long pl_linha, ref string ps_xml, ref string ps_log)
protected function boolean of_valida_situacao (datastore pds_itens, long pl_linha, ref long pl_situacao_pendente, ref string ps_log)
public subroutine of_processa_envio (long pl_nr_atualizacao)
public function boolean of_atualiza_processado (long pl_nr_atualizacao, long pl_nr_controle, string ps_id_situacao_exportacao, string ps_status, string as_mensagem, ref string as_log)
public subroutine of_inicializa (integer pi_cd_tabela, long pl_nr_atualizacao)
public subroutine of_inicializa (integer pi_cd_tabela)
public function boolean _of_filtra_nr_atualizacao (ref dc_uo_ds_base pds_dados, long pl_nr_atualizacao, ref string ps_log)
public function boolean of_valida_atualiza_situacao (long pl_nr_atualizacao)
public function boolean of_ambiente_sap (ref string as_log)
end prototypes

public function boolean _of_parametros ();String lvs_Valor, lvs_Erro

//override

is_Inicio_XML	=	'<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:syn="'+is_xmlns+'">'+&
						'<soapenv:Header/>'+&
						'<soapenv:Body>'+&
						'<syn:'+is_WS+'>'

is_Termino_XML	=	'</syn:'+is_WS+'>'+&
							'</soapenv:Body>'+&
							'</soapenv:Envelope>'
							
ib_usa_cabecalho = False
is_DS = 'ds_ge481_j1btax_envio'
is_Objeto = this.classname( )
is_Parametro_URL = 'CD_URL_'+is_nm_Tabela+"_ENVIO"
is_Tipo_Log_Exp = Right(is_nm_Tabela, 3) // IC3 ST3 PIS COF
is_Descricao_Tipo_Log = 'J1BTAX_'+is_nm_Tabela
is_Nome_Interface = 'J1BTAX'
is_nome_arquivo = is_nm_Tabela+'_xml'
ib_continua_apos_erro_montar_xml = True ////// VALIDAR ISSO

// Quantas regras sobe por XML?
If Not gf_retorna_valor_param_geral('QT_REGRAS_J1BTAX_XML_ENVIO', False, Ref lvs_Valor, Ref lvs_Erro) Then
	Return False
End If

// Se configurado obedece o par$$HEX1$$e200$$ENDHEX$$metro
If Long(lvs_Valor) > 0 Then
	ii_contador_xml = Long(lvs_Valor) // Quantas regras sobe por XML
Else
	ii_contador_xml = 500 // Default 500
End If

return True
end function

public function boolean _of_monta_xml_item (datastore pds_dados, long pl_linha, ref string ps_xml, ref string ps_log);String lvs_Encerramento

ps_xml += "<"+is_id_tipo+">"

Choose Case is_id_tipo
	Case "IC3"
		ps_xml +=	"<MANDT>"				+gf_Coalesce(pds_dados.GetItemString(pl_linha, "MANDT"), '')		+"</MANDT>"
		ps_xml +=	"<LAND1>"				+gf_Coalesce(pds_dados.GetItemString(pl_linha, "LAND1"), '')		+"</LAND1>"
		ps_xml +=	"<SHIPFROM>"			+gf_Coalesce(pds_dados.GetItemString(pl_linha, "SHIPFROM"), '')	+"</SHIPFROM>"
		ps_xml +=	"<SHIPTO>"				+gf_Coalesce(pds_dados.GetItemString(pl_linha, "SHIPTO"), '')		+"</SHIPTO>"
		ps_xml +=	"<GRUOP>"				+gf_Coalesce(pds_dados.GetItemString(pl_linha, "GRUOP"), '')		+"</GRUOP>"
		ps_xml +=	"<VALUE>"				+gf_Coalesce(pds_dados.GetItemString(pl_linha, "VALUE"), '')		+"</VALUE>"
		ps_xml +=	"<VALUE2>"				+gf_Coalesce(pds_dados.GetItemString(pl_linha, "VALUE2"), '')		+"</VALUE2>"
		ps_xml +=	"<VALUE3>"				+gf_Coalesce(pds_dados.GetItemString(pl_linha, "VALUE3"), '')		+"</VALUE3>"
		ps_xml +=	"<VALIDFROM>"			+gf_Coalesce(String(pds_dados.GetItemDateTime(pl_linha, "VALIDFROM"), "DD.MM.YYYY"), '')	+"</VALIDFROM>"
		ps_xml += 	"<VALIDTO>"				+gf_Coalesce(String(pds_dados.GetItemDateTime(pl_linha, "VALIDTO"), "DD.MM.YYYY"), '')	+"</VALIDTO>" 
		ps_xml +=	"<RATE>"					+gf_Replace(gf_Coalesce(String(pds_dados.GetItemNumber(pl_linha, "RATE")), '0'), ',', '.', 1)	+"</RATE>"
		ps_xml +=	"<BASE>"					+gf_Replace(gf_Coalesce(String(pds_dados.GetItemNumber(pl_linha, "BASE")), '0'), ',', '.', 1)	+"</BASE>"
		ps_xml +=	"<EXEMPT>"				+gf_Coalesce(pds_dados.GetItemString(pl_linha, "EXEMPT"), '')			+"</EXEMPT>"
		ps_xml +=	"<TAXLAW>"				+gf_Coalesce(pds_dados.GetItemString(pl_linha, "TAXLAW"), '')			+"</TAXLAW>"
		ps_xml +=	"<CONVEN100>"			+gf_Coalesce(pds_dados.GetItemString(pl_linha, "CONVEN100"), '')		+"</CONVEN100>"
		ps_xml +=	"<SPECF_RATE>"			+gf_Replace(gf_Coalesce(String(pds_dados.GetItemNumber(pl_linha, "SPECF_RATE")), '0'), ',', '.', 1)	+"</SPECF_RATE>"
		ps_xml +=	"<SPECF_BASE>"			+gf_Replace(gf_Coalesce(String(pds_dados.GetItemNumber(pl_linha, "SPECF_BASE")), '0'), ',', '.', 1)	+"</SPECF_BASE>"
		ps_xml +=	"<PARTILHA_EXEMPT>"	+gf_Coalesce(pds_dados.GetItemString(pl_linha, "PARTILHA_EXEMPT"), '')	+"</PARTILHA_EXEMPT>"
		ps_xml +=	"<SPECF_RESALE>"		+gf_Coalesce(pds_dados.GetItemString(pl_linha, "SPECF_RESALE"), '')		+"</SPECF_RESALE>"
		ps_xml +=	"<ENCERRAMENTO>"		+gf_Coalesce(pds_dados.GetItemString(pl_linha, "REGRA"), '')		+"</ENCERRAMENTO>"
		
	Case "ST3"
		ps_xml += 	"<MANDT>"				+gf_Coalesce(pds_dados.GetItemString(pl_linha, "MANDT"), '')		+"</MANDT>" 
		ps_xml += 	"<LAND1>"				+gf_Coalesce(pds_dados.GetItemString(pl_linha, "LAND1"), '')		+"</LAND1>" 
		ps_xml += 	"<SHIPFROM>"			+gf_Coalesce(pds_dados.GetItemString(pl_linha, "SHIPFROM"), '')	+"</SHIPFROM>" 
		ps_xml += 	"<SHIPTO>"				+gf_Coalesce(pds_dados.GetItemString(pl_linha, "SHIPTO"), '')		+"</SHIPTO>" 
		ps_xml += 	"<GRUOP>"				+gf_Coalesce(pds_dados.GetItemString(pl_linha, "GRUOP"), '')		+"</GRUOP>" 
		ps_xml += 	"<VALUE>"				+gf_Coalesce(pds_dados.GetItemString(pl_linha, "VALUE"), '')		+"</VALUE>" 
		ps_xml += 	"<VALUE2>"				+gf_Coalesce(pds_dados.GetItemString(pl_linha, "VALUE2"), '')		+"</VALUE2>" 
		ps_xml += 	"<VALUE3>"				+gf_Coalesce(pds_dados.GetItemString(pl_linha, "VALUE3"), '')		+"</VALUE3>" 
		ps_xml += 	"<STGRP>"				+gf_Coalesce(pds_dados.GetItemString(pl_linha, "STGRP"), '')		+"</STGRP>" 
		ps_xml += 	"<VALIDFROM>"			+gf_Coalesce(String(pds_dados.GetItemDateTime(pl_linha, "VALIDFROM"), "DD.MM.YYYY"), '')	+"</VALIDFROM>" 
		ps_xml += 	"<VALIDTO>"				+gf_Coalesce(String(pds_dados.GetItemDateTime(pl_linha, "VALIDTO"), "DD.MM.YYYY"), '')	+"</VALIDTO>" 
		ps_xml += 	"<SUR_TYPE>"			+gf_Coalesce(pds_dados.GetItemString(pl_linha, "SUR_TYPE"), '')				+"</SUR_TYPE>" 
		ps_xml += 	"<RATE>"					+gf_Replace(gf_Coalesce(String(pds_dados.GetItemNumber(pl_linha, "RATE")), '0'), ',', '.', 1)			+"</RATE>" 
		ps_xml += 	"<PRICE>"				+gf_Replace(gf_Coalesce(String(pds_dados.GetItemNumber(pl_linha, "PRICE")), '0'), ',', '.', 1)		+"</PRICE>" 
		ps_xml += 	"<FACTOR>"				+gf_Replace(gf_Coalesce(String(pds_dados.GetItemNumber(pl_linha, "FACTOR")), '0'), ',', '.', 1)		+"</FACTOR>" 
		ps_xml += 	"<BASE>"					+gf_Replace(gf_Coalesce(String(pds_dados.GetItemNumber(pl_linha, "BASE")), '0'), ',', '.', 1)			+"</BASE>" 
		ps_xml += 	"<UNIT>"					+gf_Coalesce(pds_dados.GetItemString(pl_linha, "UNIT"), '')						+"</UNIT>" 
		ps_xml += 	"<BASERED1>"			+gf_Replace(gf_Coalesce(String(pds_dados.GetItemNumber(pl_linha, "BASERED1")), '0'), ',', '.', 1)	+"</BASERED1>" 
		ps_xml += 	"<BASERED2>"			+gf_Replace(gf_Coalesce(String(pds_dados.GetItemNumber(pl_linha, "BASERED2")), '0'), ',', '.', 1)	+"</BASERED2>" 
		ps_xml += 	"<ICMSBASER>"			+gf_Replace(gf_Coalesce(String(pds_dados.GetItemNumber(pl_linha, "ICMSBASER")), '0'), ',', '.', 1)	+"</ICMSBASER>" 
		ps_xml += 	"<MINPRICE>"			+gf_Replace(gf_Coalesce(String(pds_dados.GetItemNumber(pl_linha, "MINPRICE")), '0'), ',', '.', 1)	+"</MINPRICE>" 
		ps_xml += 	"<WAERS>"				+gf_Coalesce(pds_dados.GetItemString(pl_linha, "WAERS"), '')					+"</WAERS>" 
		ps_xml += 	"<MINFACT>"				+gf_Replace(gf_Coalesce(String(pds_dados.GetItemNumber(pl_linha, "MINFACT")), '0'), ',', '.', 1)		+"</MINFACT>" 
		ps_xml += 	"<SURCHIN>"				+gf_Coalesce(pds_dados.GetItemString(pl_linha, "SURCHIN"), '')					+"</SURCHIN>" 
		ps_xml += 	"<FCP_BASERED1>"		+gf_Replace(gf_Coalesce(String(pds_dados.GetItemNumber(pl_linha, "FCP_BASERED1")), '0'), ',', '.', 1)	+"</FCP_BASERED1>" 
		ps_xml += 	"<FCP_BASERED2>"		+gf_Replace(gf_Coalesce(String(pds_dados.GetItemNumber(pl_linha, "FCP_BASERED2")), '0'), ',', '.', 1)	+"</FCP_BASERED2>" 
		ps_xml +=	"<ENCERRAMENTO>"		+gf_Coalesce(pds_dados.GetItemString(pl_linha, "REGRA"), '')		+"</ENCERRAMENTO>"
	
	Case "PIS", "COF"
		ps_xml += 	"<CLIENT>"					+gf_Coalesce(pds_dados.GetItemString(pl_linha, "MANDT"), '')			+"</CLIENT>"
		ps_xml += 	"<COUNTRY>"					+gf_Coalesce(pds_dados.GetItemString(pl_linha, "COUNTRY"), '')			+"</COUNTRY>"
		ps_xml += 	"<GRUOP>"					+gf_Coalesce(pds_dados.GetItemString(pl_linha, "GRUOP"), '')			+"</GRUOP>"
		ps_xml += 	"<VALUE>"					+gf_Coalesce(pds_dados.GetItemString(pl_linha, "VALUE"), '')			+"</VALUE>"
		ps_xml += 	"<VALUE2>"					+gf_Coalesce(pds_dados.GetItemString(pl_linha, "VALUE2"), '')			+"</VALUE2>"
		ps_xml += 	"<VALUE3>"					+gf_Coalesce(pds_dados.GetItemString(pl_linha, "VALUE3"), '')			+"</VALUE3>"
		ps_xml += 	"<VALIDFROM>"				+gf_Coalesce(String(pds_dados.GetItemDateTime(pl_linha, "VALIDFROM"), "DD.MM.YYYY"), '')	+"</VALIDFROM>" 
		ps_xml += 	"<VALIDTO>"					+gf_Coalesce(String(pds_dados.GetItemDateTime(pl_linha, "VALIDTO"), "DD.MM.YYYY"), '')	+"</VALIDTO>" 
		ps_xml += 	"<RATE>"						+gf_Replace(gf_Coalesce(String(pds_dados.GetItemNumber(pl_linha, "RATE")), '0'), ',', '.', 1)		+"</RATE>" 
		ps_xml += 	"<BASE>"						+gf_Replace(gf_Coalesce(String(pds_dados.GetItemNumber(pl_linha, "BASE")), '0'), ',', '.', 1)		+"</BASE>"
		ps_xml += 	"<AMOUNT>"					+gf_Replace(gf_Coalesce(String(pds_dados.GetItemNumber(pl_linha, "AMOUNT")), '0'), ',', '.', 1)	+"</AMOUNT>"
		ps_xml += 	"<FACTOR>"					+gf_Replace(gf_Coalesce(String(pds_dados.GetItemNumber(pl_linha, "FACTOR")), '0'), ',', '.', 1)	+"</FACTOR>"
		ps_xml += 	"<UNIT>"						+gf_Coalesce(pds_dados.GetItemString(pl_linha, "UNIT"), '')					+"</UNIT>"
		ps_xml += 	"<WAERS>"					+gf_Coalesce(pds_dados.GetItemString(pl_linha, "WAERS"), '')				+"</WAERS>"
		ps_xml += 	"<TAXLAW>"					+gf_Coalesce(pds_dados.GetItemString(pl_linha, "TAXLAW"), '')				+"</TAXLAW>"
		ps_xml += 	"<RATE4DEC>"				+gf_Replace(gf_Coalesce(String(pds_dados.GetItemNumber(pl_linha, "RATE4DEC")), '0'), ',', '.', 1)	+"</RATE4DEC>"
		ps_xml += 	"<AMOUNT4DEC>"				+gf_Replace(gf_Coalesce(String(pds_dados.GetItemNumber(pl_linha, "AMOUNT4DEC")), '0'), ',', '.', 1)	+"</AMOUNT4DEC>"
		ps_xml += 	"<FACTOR4DEC>"				+gf_Replace(gf_Coalesce(String(pds_dados.GetItemNumber(pl_linha, "FACTOR4DEC")), '0'), ',', '.', 1)	+"</FACTOR4DEC>"
		ps_xml += 	"<MINPRICE_AMOUNT>"		+gf_Replace(gf_Coalesce(String(pds_dados.GetItemNumber(pl_linha, "MINPRICE_AMOUNT")), '0'), ',', '.', 1) +"</MINPRICE_AMOUNT>"
		ps_xml += 	"<MINPRICE_CURRENCY>"	+gf_Coalesce(pds_dados.GetItemString(pl_linha, "MINPRICE_CURRENCY"), '')	+"</MINPRICE_CURRENCY>"
		ps_xml += 	"<MINPRICE_QUANTITY>"	+gf_Replace(gf_Coalesce(String(pds_dados.GetItemNumber(pl_linha, "MINPRICE_QUANTITY")), '0'), ',', '.', 1)		+"</MINPRICE_QUANTITY>"
		ps_xml += 	"<MINPRICE_UOM>"			+gf_Coalesce(pds_dados.GetItemString(pl_linha, "MINPRICE_UOM"), '')			+"</MINPRICE_UOM>"
		ps_xml += 	"<MINPRICE_TAXLAW>"		+gf_Coalesce(pds_dados.GetItemString(pl_linha, "MINPRICE_TAXLAW"), '')		+"</MINPRICE_TAXLAW>"
//		ps_xml +=	"<ENCERRAMENTO>"		+gf_Coalesce(pds_dados.GetItemString(pl_linha, "REGRA"), '')		+"</ENCERRAMENTO>" // ainda n$$HEX1$$e300$$ENDHEX$$o preparado no SAP

/*	Case "IP3"
		ps_xml +=	"<MANDT>"					+gf_Coalesce(pds_dados.GetItemString(pl_linha, "MANDT"), '')	+"</MANDT>"
		ps_xml +=	"<GRUOP>"					+gf_Coalesce(pds_dados.GetItemString(pl_linha, "GRUOP"), '')	+"</GRUOP>"
		ps_xml +=	"<VALUE>"					+gf_Coalesce(pds_dados.GetItemString(pl_linha, "VALUE"), '')	+"</VALUE>"
		ps_xml +=	"<VALUE2>"					+gf_Coalesce(pds_dados.GetItemString(pl_linha, "VALUE2"), '')	+"</VALUE2>"
		ps_xml +=	"<VALUE3>"					+gf_Coalesce(pds_dados.GetItemString(pl_linha, "VALUE3"), '')	+"</VALUE3>"
		ps_xml +=	"<VALIDFROM>"				+gf_Coalesce(String(pds_dados.GetItemDateTime(pl_linha, "VALIDFROM"), "DD.MM.YYYY"), '')	+"</VALIDFROM>"
		ps_xml +=	"<RATE>"						+gf_Replace(gf_Coalesce(String(pds_dados.GetItemNumber(pl_linha, "RATE")), '0'), ',', '.', 1)	+"</RATE>"
		ps_xml +=	"<BASE>"						+gf_Replace(gf_Coalesce(String(pds_dados.GetItemNumber(pl_linha, "BASE")), '0'), ',', '.', 1)	+"</BASE>"
		ps_xml +=	"<EXEMPT>"					+gf_Coalesce(pds_dados.GetItemString(pl_linha, "EXEMPT"), '')			+"</EXEMPT>"
		ps_xml +=	"<TAXLAW>"					+gf_Coalesce(pds_dados.GetItemString(pl_linha, "TAXLAW"), '')			+"</TAXLAW>"
		ps_xml +=	"<AMOUNT>"					+gf_Replace(gf_Coalesce(String(pds_dados.GetItemNumber(pl_linha, "AMOUNT")), '0'), ',', '.', 1) 	+"</AMOUNT>"
		ps_xml +=	"<FACTOR>"					+gf_Replace(gf_Coalesce(String(pds_dados.GetItemNumber(pl_linha, "FACTOR")), '0'), ',', '.', 1) 	+"</FACTOR>"
		ps_xml +=	"<UNIT>"						+gf_Coalesce(pds_dados.GetItemString(pl_linha, "UNIT"), '')					+"</UNIT>"
		ps_xml +=	"<WAERS>"					+gf_Coalesce(pds_dados.GetItemString(pl_linha, "WAERS"), '')				+"</WAERS>"
		ps_xml +=	"<MINPRICE_AMOUNT>"		+gf_Replace(gf_Coalesce(String(pds_dados.GetItemNumber(pl_linha, "MINPRICE_AMOUNT")), '0'), ',', '.', 1)		+"</MINPRICE_AMOUNT>"
		ps_xml +=	"<MINPRICE_CURRENCY>"	+gf_Coalesce(pds_dados.GetItemString(pl_linha, "MINPRICE_CURRENCY"), '') 	+"</MINPRICE_CURRENCY>"
		ps_xml +=	"<MINPRICE_QUANTITY>"	+gf_Replace(gf_Coalesce(String(pds_dados.GetItemNumber(pl_linha, "MINPRICE_QUANTITY")), '0'), ',', '.', 1) +"</MINPRICE_QUANTITY>"
		ps_xml +=	"<MINPRICE_UOM>"			+gf_Coalesce(pds_dados.GetItemString(pl_linha, "MINPRICE_UOM"), '') 			+"</MINPRICE_UOM>"
		
	Case "ISS"
		ps_xml +=	"<CLIENT>"					+gf_Coalesce(pds_dados.GetItemString(pl_linha, "MANDT"), '')		+"</CLIENT>"
		ps_xml +=	"<COUNTRY>"					+gf_Coalesce(pds_dados.GetItemString(pl_linha, "COUNTRY"), '')		+"</COUNTRY>"
		ps_xml +=	"<GRUOP>"					+gf_Coalesce(pds_dados.GetItemString(pl_linha, "GRUOP"), '')		+"</GRUOP>"
		ps_xml +=	"<TAXJURCODE>"				+gf_Coalesce(pds_dados.GetItemString(pl_linha, "TAXJURCODE"), '')	+"</TAXJURCODE>"
		ps_xml +=	"<VALUE>"					+gf_Coalesce(pds_dados.GetItemString(pl_linha, "VALUE"), '')		+"</VALUE>"
		ps_xml +=	"<VALUE2>"					+gf_Coalesce(pds_dados.GetItemString(pl_linha, "VALUE2"), '')		+"</VALUE2>"
		ps_xml +=	"<VALUE3>"					+gf_Coalesce(pds_dados.GetItemString(pl_linha, "VALUE3"), '')		+"</VALUE3>"
		ps_xml +=	"<VALIDFROM>"				+gf_Coalesce(String(pds_dados.GetItemDateTime(pl_linha, "VALIDFROM"), "DD.MM.YYYY"), '')	+"</VALIDFROM>"
		ps_xml +=	"<VALIDTO>"					+gf_Coalesce(String(pds_dados.GetItemDateTime(pl_linha, "VALIDTO"), "DD.MM.YYYY"), '')	+"</VALIDTO>"
		ps_xml +=	"<RATE>"						+gf_Replace(gf_Coalesce(String(pds_dados.GetItemNumber(pl_linha, "RATE")), '0'), ',', '.', 1)	+"</RATE>"
		ps_xml +=	"<BASE>"						+gf_Replace(gf_Coalesce(String(pds_dados.GetItemNumber(pl_linha, "BASE")), '0'), ',', '.', 1)	+"</BASE>"
		ps_xml +=	"<TAXLAW>"					+gf_Coalesce(pds_dados.GetItemString(pl_linha, "TAXLAW"), '')			+"</TAXLAW>"
		ps_xml +=	"<TAXRELLOC>"				+gf_Coalesce(pds_dados.GetItemString(pl_linha, "TAXRELLOC"), '')		+"</TAXRELLOC>"
		ps_xml +=	"<WITHHOLD>"				+gf_Coalesce(pds_dados.GetItemString(pl_linha, "WITHHOLD"), '')		+"</WITHHOLD>"
		ps_xml +=	"<MINVAL_WT>"				+gf_Replace(gf_Coalesce(String(pds_dados.GetItemNumber(pl_linha, "MINVAL_WT")), '0'), ',', '.', 1)	+"</MINVAL_WT>"
		ps_xml +=	"<WAERS>"					+gf_Coalesce(pds_dados.GetItemString(pl_linha, "WAERS"), '')			+"</WAERS>"
*/ //	IP3 E ISS N$$HEX1$$c300$$ENDHEX$$O ENVIAMOS VIAMOS REGRAS AT$$HEX1$$c900$$ENDHEX$$ O MOMENTO, S$$HEX1$$d300$$ENDHEX$$ RECEBEMOS
	Case Else
		Return False
	
End Choose

ps_xml += "</"+is_id_tipo+">"

Return True
end function

public function boolean _of_processa_retorno_xml (string as_xml, ref string as_log);long 	ll_contador = 1
String lvs_Status

lvs_Status = Trim(of_busca_valor(Upper(as_xml), "<STATUS>", ref ll_contador))

If lvs_Status = '' Then
	lvs_Status = "N$$HEX1$$c300$$ENDHEX$$O ENCONTRADA A TAG <STATUS> NO XML DE RETORNO"
End If

// Cataloga o erro
If lvs_Status <> "INTEGRADO COM SUCESSO" Then
	this.of_atualiza_processado( il_Integracao, 'E', lvs_Status, ref as_log)
end if

return True
end function

public function boolean of_gera_envio_sap (long pl_nr_controle, string ps_ambiente_sap, ref string ps_log);String 	lsnull
Long 		llnull

SetNull(lsnull)
SetNull(llnull)

If Not io_sap_comum.of_insere_log_exportacao_sap(99					/*integer ai_tipo_log*/, &
																String(pl_nr_controle) /*string as_nr_documento*/, &
																is_id_tipo, &
																llnull				/*long al_cd_filial_nota*/, &
																llnull				/*long al_nr_nf_nota*/, &
																lsnull				/*string as_especie_nota*/, &
																lsnull				/*string as_serie_nota*/, &
																lsnull				/*string as_fornecedor*/, &
																llnull				/*long al_nr_lancamento_caixa*/, &
																ref ps_log, &
																llnull				/*ref long al_nr_atualizacao*/, &
																ps_Ambiente_SAP, &
																lsnull				/*string as_chave_interface */) Then
	Return False
End If

Return True
end function

public function boolean of_atualiza_processado (datastore pds_itens, long pl_linha, long pl_nr_atualizacao, string ps_status, string as_mensagem, ref string as_log);long ll_nr_controle, ll_nr_item
String ls_status, ls_msg, ls_id_situacao_exportacao

ll_nr_controle		= pds_itens.GetItemNumber(pl_linha, "nr_controle")
ll_nr_item			= pds_itens.GetItemNumber(pl_linha, "nr_item")
is_de_chave_sap 	= String(ll_nr_controle)

if ps_status = 'E' Then
	ls_status = 'E' // Erro
	ls_id_situacao_exportacao = 'X' // Erro
	ls_msg = as_mensagem
else
	ls_status = 'P' // Processado
	ls_id_situacao_exportacao = 'E' // Enviado
	setnull(ls_msg)
end if

// Se processou
If ls_status = 'P' Then
	update log_exportacao_j1btax_item
	set dh_exportacao = getdate()
	where nr_controle = :ll_nr_controle
		and nr_item = :ll_nr_item
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		as_log = "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o de processamento log_exportacao_j1btax_item 'of_atualiza_processado': " + SqlCa.SqlerrText
		Return False
	End If
	
End If

// Se deu erro ou terminou o processamento
If ls_status = 'E' Or pl_Linha = pds_itens.RowCount() Then
	If pl_nr_atualizacao = 0 Then pl_nr_atualizacao = il_nr_atualizacao
	If Not of_Atualiza_Processado(pl_nr_atualizacao, ll_nr_controle, ls_id_situacao_exportacao, ls_status, ls_msg, ref as_Log) Then
		Return False
	End If
End If

Return True
end function

public function boolean _of_monta_xml_cab (datastore pds_cab, long pl_linha, ref string ps_xml, ref string ps_log);ps_xml  = "<NM_TABELA>"+ is_nm_tabela +"</NM_TABELA>"
ps_xml += "<DE_CHAVE_SAP>"+ is_de_chave_sap +"</DE_CHAVE_SAP>" 

Return True
end function

protected function boolean of_valida_situacao (datastore pds_itens, long pl_linha, ref long pl_situacao_pendente, ref string ps_log);pl_situacao_pendente=1//bypass - j$$HEX1$$e100$$ENDHEX$$ traz s$$HEX1$$f300$$ENDHEX$$ os pendentes no select
Return True
end function

public subroutine of_processa_envio (long pl_nr_atualizacao);Long ll_For

// Com nr_atualizacao, envia o controle.
If pl_nr_atualizacao > 0 Then
	If Not of_Valida_Atualiza_Situacao(pl_nr_atualizacao) Then Return
	Open(w_aguarde_3)
	Super::of_processa_envio( pl_nr_atualizacao )
	Close(w_aguarde_3)
	Sleep(1) // depois de fechar precisa esperar um pouco antes de abrir de novo
Else
	// Sem nr_atualizacao, processa os controles colocados
	
	dc_uo_ds_base lds
	lds = Create dc_uo_ds_base
	
	lds.of_ChangeDataObject("ds_ge481_j1btax_controles")
	
	lds.of_AppendWhere("les.id_tipo_nf = '"+is_id_tipo+"'")
	
	lds.Retrieve()
	
	For ll_For = 1 To lds.RowCount()
		il_nr_atualizacao = lds.GetItemNumber(ll_For, "nr_atualizacao")
		If il_nr_atualizacao > 0 Then This.of_processa_envio(il_nr_atualizacao)
	NExt
	
	Destroy lds
	
End If

end subroutine

public function boolean of_atualiza_processado (long pl_nr_atualizacao, long pl_nr_controle, string ps_id_situacao_exportacao, string ps_status, string as_mensagem, ref string as_log);DateTime lvdh_Exportacao

SetNull(lvdh_Exportacao)
If ps_Status = 'P' Then lvdh_Exportacao = gf_GetServerDate()

If as_mensagem = '' Then SetNull(as_mensagem)

update log_exportacao_sap
set id_status_integracao = :ps_status,
	 dh_exportacao = :lvdh_Exportacao, 
	 de_erro = :as_mensagem
where nr_atualizacao = :pl_nr_atualizacao
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_log = "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o de processamento log_exportacao_sap 'of_atualiza_processado': " + SqlCa.SqlerrText
	Return False
End If

update log_exportacao_j1btax
set 	id_situacao_exportacao = :ps_id_situacao_exportacao,
		dh_exportacao = :lvdh_Exportacao,
		de_obs = :as_mensagem
where nr_controle = :pl_nr_controle
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_log = "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do log_exportacao_j1btax.id_situacao_exportacao = '"+ps_id_situacao_exportacao+"' 'of_atualiza_processado': " + SqlCa.SqlerrText
	Return False
End If
	
Return True
end function

public subroutine of_inicializa (integer pi_cd_tabela, long pl_nr_atualizacao);il_cd_tabela 		= pi_cd_tabela
il_nr_atualizacao = pl_nr_atualizacao

Choose Case il_cd_tabela
	Case 140
		is_nm_Tabela 	= 'J_1BTXIC3'
		is_WS 			= 'MT_IC3_REQUEST'
		is_id_tipo 		= 'IC3'
		is_xmlns			= 'http://IC3/SyncSoap2Proxy'

	Case 141
		is_nm_Tabela 	= 'J_1BTXIP3'
		is_WS 			= 'MT_IP3_REQUEST'
		is_id_tipo 		= 'IP3'
		is_xmlns			= 'http://IP3/SyncSoap2Proxy'
		
	Case 142
		is_nm_Tabela 	= 'J_1BTXISS'
		is_WS 			= 'MT_Response' 	//////// VERIFICAR ESTE, EST$$HEX1$$c100$$ENDHEX$$ ESTRANHO
		is_id_tipo 		= 'ISS'
		is_xmlns			= 'http://ISS/SyncSoap2Proxy'
		
	Case 143
		is_nm_Tabela 	= 'J_1BTXPIS'
		is_WS 			= 'MT_PIS_REQUEST'
		is_id_tipo 		= 'PIS'
		is_xmlns			= 'http://PIS/SyncSoap2Proxy'
		
	Case 144 
		is_nm_Tabela 	= 'J_1BTXCOF'
		is_WS 			= 'MT_COF_REQUEST' 	//////// VERIFICAR ESTE, EST$$HEX1$$c100$$ENDHEX$$ DIFERENTE
		is_id_tipo 		= 'COF'
		is_xmlns			= 'http://COF/SyncSOAP2Proxy'
		
	Case 145
		is_nm_Tabela 	= 'J_1BTXST3'
		is_WS 			= 'MT_ST3_REQUEST'
		is_id_tipo 		= 'ST3'
		is_xmlns			= 'http://ST3/SyncSoap2Proxy'
		
End Choose



// C$$HEX1$$f300$$ENDHEX$$digo movido do constructor pra c$$HEX1$$e100$$ENDHEX$$
this._of_parametros( )
of_Abre_Log(is_nome_arquivo)
io_sap_comum = Create uo_ge470_sap_comum
// --


end subroutine

public subroutine of_inicializa (integer pi_cd_tabela);of_inicializa( pi_cd_tabela, 0)
end subroutine

public function boolean _of_filtra_nr_atualizacao (ref dc_uo_ds_base pds_dados, long pl_nr_atualizacao, ref string ps_log);//Filtra a datastore para trazer um registro espec$$HEX1$$ed00$$ENDHEX$$fico.
If pl_nr_atualizacao > 0 Then
	pds_dados.of_appendwhere( 'nr_atualizacao = ' + String(pl_nr_atualizacao) )
End If

pds_dados.of_appendwhere( "les.id_tipo_nf = '"+is_id_tipo+"'" )

return true
end function

public function boolean of_valida_atualiza_situacao (long pl_nr_atualizacao);Long lvl_Count, lvl_nr_Controle
String lvs_Log

SELECT cast(cd_chave as integer)
INTO 	:lvl_nr_Controle
FROM log_exportacao_sap
WHERE nr_atualizacao = :pl_nr_atualizacao
USING SQLCA;

If SQLCA.SQLCode = -1 Then
	lf_ge470_log("of_processa_envio: "+SQLCA.SqlErrText, 1, is_Tipo_Log_Exp, is_Descricao_Tipo_Log, ii_log)
	Return False
End If

If lvl_nr_Controle = 0 Then
	lf_ge470_log("of_processa_envio: log_exportacao_sap.cd_chave (Atualiza$$HEX2$$e700e300$$ENDHEX$$o:"+String(pl_nr_atualizacao)+") deve conter o nr_controle da log_exportacao_j1btax.", 1, is_Tipo_Log_Exp, is_Descricao_Tipo_Log, ii_log)
	Return False
End If

SELECT count(*)
INTO	:lvl_Count
FROM	log_exportacao_j1btax_item
WHERE	nr_controle = :lvl_nr_controle
	AND id_aprovado = 'S'
	AND dh_exportacao IS NULL
USING SQLCA;

If SQLCA.SQLCode = -1 Then
	lf_ge470_log("of_processa_envio: "+SQLCA.SqlErrText, 1, is_Tipo_Log_Exp, is_Descricao_Tipo_Log, ii_log)
	Return False
End If

// Controle n$$HEX1$$e300$$ENDHEX$$o possui pend$$HEX1$$ea00$$ENDHEX$$ncias, update no log para PROCESSADO
If lvl_Count = 0 Then
	If pl_nr_atualizacao = 0 Then pl_nr_atualizacao = il_nr_atualizacao
	If of_atualiza_processado(pl_nr_atualizacao, lvl_nr_Controle, 'E', 'P', '', Ref lvs_Log) Then
		lvs_Log = "Atualiza$$HEX2$$e700e300$$ENDHEX$$o: " + String(pl_nr_atualizacao) + " sem pend$$HEX1$$ea00$$ENDHEX$$ncias. Atualizado para PROCESSADO."
		lf_ge470_log(lvs_Log, 1, is_Tipo_Log_Exp, is_Descricao_Tipo_Log, ii_log)
	Else
		lf_ge470_log(lvs_Log, 1, is_Tipo_Log_Exp, is_Descricao_Tipo_Log, ii_log)
	End If
	SQLCA.of_Commit()
End If

Return True
end function

public function boolean of_ambiente_sap (ref string as_log);SELECT cd_ambiente_sap
INTO :is_ambiente_sap
FROM log_exportacao_sap
WHERE nr_atualizacao = :il_nr_atualizacao
Using SqlCa;

If SQLCA.SQLCode = -1 Then
	lf_ge470_log("of_ambiente_sap: "+SQLCA.SqlErrText, 1, is_Tipo_Log_Exp, is_Descricao_Tipo_Log, ii_log)
	Return False
End If

Return True
end function

on uo_ge481_wms_imposto.create
call super::create
end on

on uo_ge481_wms_imposto.destroy
call super::destroy
end on

event constructor;////Override - c$$HEX1$$f300$$ENDHEX$$digo na of_inicializa()
end event

