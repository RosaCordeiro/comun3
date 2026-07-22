HA$PBExportHeader$uo_ge481_estoque_base_min_promo_sap.sru
forward
global type uo_ge481_estoque_base_min_promo_sap from uo_ge481_exportacao
end type
end forward

global type uo_ge481_estoque_base_min_promo_sap from uo_ge481_exportacao
end type
global uo_ge481_estoque_base_min_promo_sap uo_ge481_estoque_base_min_promo_sap

forward prototypes
public function boolean _of_parametros ()
public function boolean _of_monta_xml_item (datastore pds_dados, long pl_linha, ref string ps_xml, ref string ps_log)
public function boolean _of_processa_retorno_xml (string as_xml, ref string as_log)
end prototypes

public function boolean _of_parametros ();is_Inicio_XML	=	'<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:imp="importa_sap.com">'+&
						'<soapenv:Header/>'+&
						'<soapenv:Body>'+&
						'<imp:MT_EstoqueBase_SyBASE_Request_Sync>'
							
is_Termino_XML	=	'</imp:MT_EstoqueBase_SyBASE_Request_Sync>'+&
						'</soapenv:Body>'+&
						'</soapenv:Envelope>'
							
ib_usa_cabecalho 			= False
is_ds 						= 'ds_ge481_estoque_base_min_promo_sap'
is_objeto 					= this.ClassName()
is_nome_arquivo 			= 'estoque_base_sap'
is_parametro_url 			= 'CD_URL_EST_BASE_MINIMO_PROMO'
is_tipo_log_exp 			= 'ESTOQUE_BASE_SAP'
is_descricao_tipo_log 	= 'ESTOQUE_BASE_SAP'
is_nome_interface 		= 'ESTOQUE_BASE_SAP'
ii_contador_xml = 1

return True
end function

public function boolean _of_monta_xml_item (datastore pds_dados, long pl_linha, ref string ps_xml, ref string ps_log);DateTime	ldt_dh_inicio_vigencia, ldt_dh_termino_vigencia, ldt_dh_documento
Long		ll_qt_estoque_atual, ll_qt_estoque_minimo_matriz
String	ls_de_motivo, ls_cd_produto_sap, ls_cd_centro_sap, ls_nr_matricula_alteracao, &
			ls_id_alteracao


Try
	ls_de_motivo 						= pds_dados.Object.de_motivo[pl_linha]
	ldt_dh_inicio_vigencia 			= pds_dados.Object.dh_inicio_vigencia[pl_linha]
	ldt_dh_termino_vigencia 		= pds_dados.Object.dh_termino_vigencia[pl_linha]
	ls_cd_produto_sap 				= pds_dados.Object.cd_produto_sap[pl_linha]
	ls_cd_centro_sap 					= pds_dados.Object.id_filial_sap[pl_linha]
	ll_qt_estoque_atual 				= pds_dados.Object.qt_estoque_atual[pl_linha]
	ls_nr_matricula_alteracao 		= pds_dados.Object.nr_matricula_alteracao[pl_linha]
	ldt_dh_documento 					= pds_dados.Object.dh_documento[pl_linha]
	ls_id_alteracao 					= pds_dados.Object.id_alteracao[pl_linha]
	ll_qt_estoque_minimo_matriz	= pds_dados.Object.qt_estoque_minimo_matriz[pl_linha]
	
	if IsNull(ldt_dh_termino_vigencia) or ldt_dh_termino_vigencia = DateTime('1900-01-01') then
		ldt_dh_termino_vigencia	= DateTime('2099-12-31')
	end if
							
	if IsNull(ls_nr_matricula_alteracao) Then
		ps_log	= 'N$$HEX1$$e300$$ENDHEX$$o foi localizada a matricula de altera$$HEX2$$e700e300$$ENDHEX$$o da promo$$HEX2$$e700e300$$ENDHEX$$o.'
		Return False
	end if
	
	ps_xml = 	'<Cabecalho>'
	ps_xml += 		'<id_tipo>'+'ESB'+'</id_tipo>'
	ps_xml +=		'<Item>'
	ps_xml +=			'<cd_promocao_planograma></cd_promocao_planograma>'+&
							'<cd_promocao_sap></cd_promocao_sap>'+&
							'<cd_filial_sap>' + ls_cd_centro_sap + '</cd_filial_sap>'	+&
							'<cd_produto_sap>' + ls_cd_produto_sap + '</cd_produto_sap>'+&
							'<qt_estoque>' + String(ll_qt_estoque_atual) + '</qt_estoque>'+&
							'<dh_item_inicio_vigencia>' + String(Date(ldt_dh_inicio_vigencia)) + '</dh_item_inicio_vigencia>'+&
							'<dh_item_termino_vigencia>' + String(Date(ldt_dh_termino_vigencia)) + '</dh_item_termino_vigencia>'+&
							'<cd_motivo_alteracao>' + ls_de_motivo + '</cd_motivo_alteracao>'+&
							'<nr_matricula>' + ls_nr_matricula_alteracao + '</nr_matricula>'+&
							'<qt_min_base_planograma>' + String(ll_qt_estoque_minimo_matriz) + '</qt_min_base_planograma>'+&
							'<dh_alteracao>' + String(ldt_dh_documento) + '</dh_alteracao>'+&
							'<id_alteracao>' + ls_id_alteracao + '</id_alteracao>'									
									
												
	ps_xml += 		'</Item>'
	ps_xml +=	'</Cabecalho>'
Catch (RunTimeError RTE)
	ps_log	= RTE.GetMessage()
	Return False
End Try

Return True
end function

public function boolean _of_processa_retorno_xml (string as_xml, ref string as_log);Boolean	lb_sucesso
Long 		ll_contador = 0
String 	ls_msg, ls_msg2, ls_mensagem

DO 
	ll_contador++
	
	ls_msg = of_busca_valor(as_xml, '<id>', ll_contador)
	
	if ls_msg = '' or isnull(ls_msg) Then
		Exit
	end if
	
	if Upper(ls_msg) <> 'S' Then
		ls_msg2 = of_busca_valor(as_xml, '<message>', ll_contador)
		
		ls_mensagem += ls_msg2
	end if
Loop While ll_contador > 0

If IsNull(ls_mensagem) or ls_mensagem = '' Then
	ls_mensagem	= 'Importado com Sucesso'
	If This.of_atualiza_processado(is_nr_exportacao, 'S', ref ls_mensagem, ref as_log)  Then
		lb_Sucesso = True	
	else
		lb_Sucesso = false
	End If
else
	If This.of_atualiza_processado(is_nr_exportacao, 'E', ls_mensagem, ref as_log)  Then
		lb_Sucesso = True	
	else
		lb_Sucesso = false
	End If
end if

return lb_sucesso
end function

on uo_ge481_estoque_base_min_promo_sap.create
call super::create
end on

on uo_ge481_estoque_base_min_promo_sap.destroy
call super::destroy
end on

