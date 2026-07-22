HA$PBExportHeader$uo_ge481_estoque_base_prin_sap.sru
forward
global type uo_ge481_estoque_base_prin_sap from uo_ge481_exportacao
end type
end forward

global type uo_ge481_estoque_base_prin_sap from uo_ge481_exportacao
end type
global uo_ge481_estoque_base_prin_sap uo_ge481_estoque_base_prin_sap

forward prototypes
public function boolean _of_parametros ()
public function boolean _of_monta_xml_item (datastore pds_dados, long pl_linha, ref string ps_xml, ref string ps_log)
public function boolean _of_processa_retorno_xml (string as_xml, ref string as_log)
public function boolean _of_monta_xml_cab (datastore pds_cab, long pl_linha, ref string ps_xml, ref string ps_log)
public function boolean _of_config_filtro_cab (datastore pds_cab, long pl_linha, ref datastore pds_itens, ref string ps_log)
public function boolean _of_config_lista_cab (datastore pds_itens, long pl_linha, ref datastore pds_cab, ref string ps_log)
end prototypes

public function boolean _of_parametros ();is_Inicio_XML	=	'<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:imp="importa_sap.com">' + &
						'   <soapenv:Header/>'+ &
						'   <soapenv:Body>'+ &
					    '  	<imp:MT_Recalculo_Request>'

is_Termino_XML	=	'		</imp:MT_Recalculo_Request>' + &
						'	</soapenv:Body>' + &
						'</soapenv:Envelope>'
							
is_DS = 'ds_ge481_estoque_base_prin_sap'
is_Objeto = this.classname( )
is_nome_arquivo = 'est_base_xml'
is_Parametro_URL = 'CD_URL_ESTOQUE_BASE_REC'
is_Descricao_Tipo_Log = 'ESTOQUE_BASE_RECALCULO'
is_Nome_Interface = 'RECALCULO ESTOQUE BASE'

ib_continua_apos_erro_montar_xml	= True

return True
end function

public function boolean _of_monta_xml_item (datastore pds_dados, long pl_linha, ref string ps_xml, ref string ps_log);String ls_cd_produto_sap, ls_hora, ls_produto, ls_est_base, ls_curva, ls_dias, ls_cd_produto_legado


ls_hora 					= String(Time(pds_dados.object.dh_documento[pl_linha]),'hh:mm:ss')
ls_produto 				= pds_dados.object.cd_produto_sap[pl_linha]
ls_est_base 			= String(pds_dados.object.estoque_base[pl_linha])
ls_curva 				= pds_dados.object.curva[pl_linha]
ls_dias	 				= String(pds_dados.object.nr_dias_cobertura[pl_linha])
ls_cd_produto_legado	= String(pds_dados.object.cd_produto[pl_linha])

If IsNull(ls_curva) or Trim(ls_curva) = '' Then
	ps_log	= 'N$$HEX1$$e300$$ENDHEX$$o foi localizado registro de CURVA para o produto ' + ls_cd_produto_legado
	Return False
End if

If IsNull(ls_produto) or Trim(ls_produto) = '' Then
	ps_log	= 'N$$HEX1$$e300$$ENDHEX$$o foi localizado registro de CD_PRODUTO_SAP para o produto ' + ls_cd_produto_legado
	Return False
End if

ps_xml += '<item>' 
ps_xml += '<material>' + ls_produto + '</material>'
ps_xml += '<estoque_base>' + ls_est_base + '</estoque_base>'
ps_xml += '<curva>' + ls_curva + '</curva>'
ps_xml += '<dias_cobertura>' + ls_dias + '</dias_cobertura>'
ps_xml += '<hora>' + ls_hora + '</hora>'
ps_xml += '</item>' 

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
	
	If This.of_atualiza_processado(is_nr_exportacao, 'S', ls_mensagem, ref as_log)  Then
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

public function boolean _of_monta_xml_cab (datastore pds_cab, long pl_linha, ref string ps_xml, ref string ps_log);DateTime	ldt_dh_documento
String 	ls_cd_filial_sap


ls_cd_filial_sap 	= pds_cab.object.cd_filial_sap[pl_linha]
ldt_dh_documento	= pds_cab.object.dh_documento[pl_linha]

If IsNull(ls_cd_filial_sap) or Trim(ls_cd_filial_sap) = '' Then
	ps_log	= 'N$$HEX1$$e300$$ENDHEX$$o foi localizado registro de CD_FILIAL_SAP para a filial ' + ls_cd_filial_sap
	Return False
End if

ps_xml += '<centro>' + ls_cd_filial_sap + '</centro>'
ps_xml += '<data>' + String(ldt_dh_documento,'dd/mm/yyyy') + '</data>'
 
Return True
end function

public function boolean _of_config_filtro_cab (datastore pds_cab, long pl_linha, ref datastore pds_itens, ref string ps_log);DateTime	ldt_dh_documento
String 	ls_cd_filial_sap


ls_cd_filial_sap 	= pds_cab.object.cd_filial_sap[pl_linha]
ldt_dh_documento	= pds_cab.object.dh_documento[pl_linha]
			
if pds_itens.SetFilter("cd_filial_sap = '" + ls_cd_filial_sap + "' and string(dt_documento, 'dd/mm/yyyy') = '" + String(ldt_dh_documento, 'dd/mm/yyyy') + "'") = -1 then
	ps_log = 'Erro ao realizar filtro na datawindow ' + is_ds + '. Objeto: ' + is_objeto + '; Fun$$HEX2$$e700e300$$ENDHEX$$o: _of_config_filtro_cab'
	Return False
end if

Return True
end function

public function boolean _of_config_lista_cab (datastore pds_itens, long pl_linha, ref datastore pds_cab, ref string ps_log);Long 		ll_row, ll_find
String	ls_cd_filial_sap, ls_dh_documento


ls_cd_filial_sap 	= pds_itens.object.cd_filial_sap[pl_linha]
ls_dh_documento 	= String(pds_itens.object.dh_documento[pl_linha],'dd/mm/yyyy')
			
ll_find = pds_cab.find("cd_filial_sap = '" + ls_cd_filial_sap + "' and string(dt_documento, 'dd/mm/yyyy') = '" + ls_dh_documento + "'" , 1, pds_cab.RowCount()) 

if ll_find = 0 Then
	ll_row = pds_cab.InsertRow(0)
	
	pds_cab.SetItem(ll_row, 'cd_filial_sap', ls_cd_filial_sap)
	pds_cab.SetItem(ll_row, 'dh_documento', Date(pds_itens.object.dh_documento[pl_linha]))
	pds_cab.SetItem(ll_row, 'dt_documento', Date(ls_dh_documento))
elseif ll_find < 0 Then
	
	ps_log = 'Erro ao realizar FIND na datawindow ' + is_ds + '. Objeto: ' + is_Objeto + '; Fun$$HEX2$$e700e300$$ENDHEX$$o: _of_config_lista_cab'
	return false
	
end if

Return True
end function

on uo_ge481_estoque_base_prin_sap.create
call super::create
end on

on uo_ge481_estoque_base_prin_sap.destroy
call super::destroy
end on

