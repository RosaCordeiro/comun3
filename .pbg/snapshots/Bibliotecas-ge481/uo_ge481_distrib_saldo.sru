HA$PBExportHeader$uo_ge481_distrib_saldo.sru
forward
global type uo_ge481_distrib_saldo from uo_ge481_subida_generica
end type
end forward

global type uo_ge481_distrib_saldo from uo_ge481_subida_generica autoinstantiate
boolean ib_usa_cabecalho = false
end type

forward prototypes
public function boolean _of_monta_xml_item (datastore pds_dados, long pl_linha, ref string ps_xml, ref string ps_log)
public function boolean _of_parametros ()
public function boolean _of_processa_retorno_xml (string as_xml, ref string as_log)
public function boolean _of_filtra_nr_atualizacao (ref dc_uo_ds_base pds_dados, long pl_nr_atualizacao, ref string ps_log)
end prototypes

public function boolean _of_monta_xml_item (datastore pds_dados, long pl_linha, ref string ps_xml, ref string ps_log);ps_xml += '<dados>'
ps_xml += '<cd_produto_sap>' + pds_dados.object.cd_produto_sap[pl_linha] + '</cd_produto_sap>'
ps_xml += '<cd_fornecedor_sap>' + pds_dados.object.cd_fornecedor_sap[pl_linha] + '</cd_fornecedor_sap>'
ps_xml += '<qt_estoque_disponivel>' + string(pds_dados.object.qt_estoque_disponivel[pl_linha]) + '</qt_estoque_disponivel>'
ps_xml += '<id_estoque_maior_10dias>' + pds_dados.object.id_estoque_maior_10dias[pl_linha] + '</id_estoque_maior_10dias>'
ps_xml += '</dados>'

return true
end function

public function boolean _of_parametros ();is_Inicio_XML	=	'<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:exp="exporta_sap.com">'+&
						'<soapenv:Header/>'+&
						'<soapenv:Body>'+&
						'<exp:MT_EnviarSaldo_Request>'


is_Termino_XML	=	'</exp:MT_EnviarSaldo_Request>'+&
							'</soapenv:Body>'+&
							'</soapenv:Envelope>'

is_DS = 'ds_ge481_distrib_saldo'
is_Objeto = 'uo_ge481_distrib_saldo'
is_nome_arquivo = 'distrib_saldo_xml'
is_Parametro_URL = 'CD_URL_DISTRIB_SALDO'
is_Tipo_Log_Exp = 'DIS'
is_Descricao_Tipo_Log = 'SALDO DISTRIBUIDORA'
is_Nome_Interface = 'DISTRIB_SALDO'

return True
end function

public function boolean _of_processa_retorno_xml (string as_xml, ref string as_log);long ll_contador=0
string ls_nr_doc, ls_status, ls_condicao, ls_nr_doc_ant

ll_contador = 1

DO 
	
	ls_nr_doc = of_busca_valor(as_xml, '<nr_doc_externo>', ref ll_contador)
	
	if ls_nr_doc = '' or isnull(ls_nr_doc) Then
		Exit
	end if
	
	ls_condicao = of_busca_valor(as_xml, '<condicao>', ref ll_contador)
	
	ls_status = of_busca_valor(as_xml, '<status>', ref ll_contador)
	
	if upper(ls_status) <> 'INTEGRADO COM SUCESSO!' Then
		
		this.of_atualiza_processado( long(ls_nr_doc), 'E', ls_status, ref as_log)
		
	end if
	
Loop While ll_contador > 0

return True
end function

public function boolean _of_filtra_nr_atualizacao (ref dc_uo_ds_base pds_dados, long pl_nr_atualizacao, ref string ps_log);//Filtra a datastore para trazer um registro espec$$HEX1$$ed00$$ENDHEX$$fico.

string ls_teste

if pl_nr_atualizacao > 0 Then
	pds_dados.of_appendwhere_subquery( 'nr_atualizacao = ' + String(pl_nr_atualizacao), 1 )
else
	pds_dados.of_appendwhere_subquery( "id_status_integracao = 'C' " , 1 )
end if

ls_teste = pds_dados.getsqlselect()

return true
end function

on uo_ge481_distrib_saldo.create
call super::create
end on

on uo_ge481_distrib_saldo.destroy
call super::destroy
end on

