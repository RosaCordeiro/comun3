HA$PBExportHeader$uo_ge481_estoque_base_resumo_filial.sru
forward
global type uo_ge481_estoque_base_resumo_filial from uo_ge481_exportacao
end type
end forward

global type uo_ge481_estoque_base_resumo_filial from uo_ge481_exportacao
end type
global uo_ge481_estoque_base_resumo_filial uo_ge481_estoque_base_resumo_filial

forward prototypes
public function boolean _of_parametros ()
public function boolean _of_monta_xml_item (datastore pds_dados, long pl_linha, ref string ps_xml, ref string ps_log)
public function boolean of_atualiza_chave_interface (string as_chave, ref string ps_log)
end prototypes

public function boolean _of_parametros ();//override
is_Inicio_XML	=	'<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:syn="http://Update_Estoque_Base/SyncSOAP2Proxy">' + &
						'<soapenv:Header/>'+&
						'<soapenv:Body>'+&
						'<syn:MT_Request_Update_Estoque_Base>'

is_Termino_XML	=	'</syn:MT_Request_Update_Estoque_Base>'+&
							'</soapenv:Body>'+&
							'</soapenv:Envelope>'
							
ib_usa_cabecalho 			= False
is_DS 						= 'ds_ge481_estoque_base_resumo_filial'
is_Objeto 					= this.classname( )
is_nome_arquivo 			= 'wms_est_base_resumo_filial_xml'
is_Parametro_URL 			= 'CD_URL_EST_BASE_RESUM_FILIAL'
is_Tipo_Log_Exp 			= 'EST_BASE_RESUM_FILIAL'
is_Descricao_Tipo_Log 	= 'EST_BASE_RESUM_FILIAL'
is_Nome_Interface 		= 'EST_BASE_RESUM_FILIAL'

ii_contador_xml = 1

ib_continua_apos_erro_montar_xml = True

return True
end function

public function boolean _of_monta_xml_item (datastore pds_dados, long pl_linha, ref string ps_xml, ref string ps_log);Long		ll_cd_filial, ll_cd_produto, ll_qt_estoque_base
String	ls_nr_exportacao, ls_centro, ls_cd_produto_sap, ls_tp_estoque_base


ls_nr_exportacao		= pds_dados.GetItemString(pl_linha,"nr_exportacao")
ll_cd_filial			= pds_dados.GetItemNumber(pl_linha,"cd_filial")
ll_cd_produto			= pds_dados.GetItemNumber(pl_linha,"cd_produto")
ll_qt_estoque_base	= pds_dados.GetItemNumber(pl_linha,"qt_estoque_base")
ls_tp_estoque_base	= pds_dados.GetItemString(pl_linha,"tp_estoque_base")

If IsNull(ll_cd_filial) or ll_cd_filial <= 0 Then
	ps_log = 'Registro de filial est$$HEX1$$e100$$ENDHEX$$ zerada ou em branco.'
	return false
End If

If IsNull(ll_cd_produto) or ll_cd_produto <= 0 Then
	ps_log = 'Registro de produto est$$HEX1$$e100$$ENDHEX$$ zerado ou em branco.'
	return false
End If 

If IsNull(ll_qt_estoque_base) or ll_cd_produto < 0 Then
	ps_log = 'Registro de quantidade base est$$HEX1$$e100$$ENDHEX$$ branco ou $$HEX1$$e900$$ENDHEX$$ um valor negativo.'
	return false
End If

SELECT 
	cd_chave_sap
INTO
	:ls_centro
FROM
	integracao_sap isap
WHERE
	isap.cd_tabela = 'FILIAL' 
	AND isap.cd_chave_legado = Cast(:ll_cd_filial as varchar(10));
	
Choose Case SQLCA.SQLCode
	Case -1
		ps_log	= 'Problema ao encontrar o c$$HEX1$$f300$$ENDHEX$$digo da filial SAP.~r~rErro: ' + SQLCA.SQLErrText
		Return False
	Case 100
		ps_log	= 'N$$HEX1$$e300$$ENDHEX$$o foi localizado o c$$HEX1$$f300$$ENDHEX$$digo da filial SAP.'
		Return False
End Choose

SELECT
	cd_produto_sap
INTO
	:ls_cd_produto_sap
FROM
	produto_geral pg
WHERE
	pg.cd_produto	= :ll_cd_produto;

Choose Case SQLCA.SQLCode
	Case -1
		ps_log	= 'Problema ao encontrar o c$$HEX1$$f300$$ENDHEX$$digo do produto SAP.~r~rErro: ' + SQLCA.SQLErrText
		Return False
	Case 100
		ps_log	= 'N$$HEX1$$e300$$ENDHEX$$o foi localizado o c$$HEX1$$f300$$ENDHEX$$digo do produto SAP.'
		Return False
End Choose

if IsNull(ls_tp_estoque_base) Then ls_tp_estoque_base = 'EB'

ps_xml += '<Centro>'+ls_centro+'</Centro>' + &
	'<Material>'+ls_cd_produto_sap+'</Material>' + &
	'<Estoque>'+String(ll_qt_estoque_base)+'</Estoque>' + &
	'<TP_Estoque>'+ls_tp_estoque_base+'</TP_Estoque>'
	

if IsNull(ps_xml) then
	ps_log = 'XML est$$HEX1$$e100$$ENDHEX$$ nulo para o envio do estoque base resumido.'
	return false
end if

return true
end function

public function boolean of_atualiza_chave_interface (string as_chave, ref string ps_log);return true
end function

on uo_ge481_estoque_base_resumo_filial.create
call super::create
end on

on uo_ge481_estoque_base_resumo_filial.destroy
call super::destroy
end on

