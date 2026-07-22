HA$PBExportHeader$uo_ge481_est_base.sru
forward
global type uo_ge481_est_base from uo_ge481_subida_generica
end type
end forward

global type uo_ge481_est_base from uo_ge481_subida_generica autoinstantiate
integer ii_contador_xml = 500
end type

forward prototypes
public function boolean _of_parametros ()
public function boolean _of_monta_xml_item (datastore pds_dados, long pl_linha, ref string ps_xml, ref string ps_log)
public function boolean _of_monta_xml_cab (datastore pds_cab, long pl_linha, ref string ps_xml, ref string ps_log)
public function boolean _of_config_filtro_cab (datastore pds_cab, long pl_linha, ref datastore pds_itens, ref string ps_log)
public function boolean _of_config_lista_cab (datastore pds_itens, long pl_linha, ref datastore pds_cab, ref string ps_log)
public function boolean _of_filtra_nr_atualizacao (ref dc_uo_ds_base pds_dados, long pl_nr_atualizacao, ref string ps_log)
end prototypes

public function boolean _of_parametros ();is_Inicio_XML	=	'<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:imp="importa_sap.com">' + &
						'   <soapenv:Header/>'+ &
						'   <soapenv:Body>'+ &
					    '  <imp:MT_Recalculo_Request>'
							
is_Termino_XML	=	'      </imp:MT_Recalculo_Request>' + &
							'	</soapenv:Body>' + &
							'</soapenv:Envelope>'

is_DS = 'ds_ge481_est_base'
is_Objeto = this.classname( )
is_nome_arquivo = 'est_base_xml'
is_Parametro_URL = 'CD_URL_ESTOQUE_BASE_REC'
is_Tipo_Log_Exp = 'EST'
is_Descricao_Tipo_Log = 'ESTOQUE_BASE_RECALCULO'
is_Nome_Interface = 'RECALCULO ESTOQUE BASE'

return True
end function

public function boolean _of_monta_xml_item (datastore pds_dados, long pl_linha, ref string ps_xml, ref string ps_log);string ls_cd_produto_sap, ls_hora, ls_produto, ls_est_base, ls_curva, ls_dias

ls_hora = String(pds_dados.object.hora_doc[pl_linha],'hh:mm:ss')
ls_produto = pds_dados.object.cd_produto_sap[pl_linha]
ls_est_base = String(pds_dados.object.estoque_base[pl_linha])
ls_curva = pds_dados.object.curva[pl_linha]
ls_dias = String(pds_dados.object.nr_dias_cobertura[pl_linha])

ps_xml += '<item>' 
ps_xml += '<material>' + ls_produto + '</material>'
ps_xml += '<estoque_base>' + ls_est_base + '</estoque_base>'
ps_xml += '<curva>' + ls_curva + '</curva>'
ps_xml += '<dias_cobertura>' + ls_dias + '</dias_cobertura>'
ps_xml += '<hora>' + ls_hora + '</hora>'
ps_xml += '</item>' 

return true
end function

public function boolean _of_monta_xml_cab (datastore pds_cab, long pl_linha, ref string ps_xml, ref string ps_log);string ls_data, ls_cd_filial_sap

ls_cd_filial_sap = pds_cab.object.id_filial_sap[pl_linha]
ls_data = String(pds_cab.object.data_doc[pl_linha],'dd/mm/yyyy')

ps_xml += '<centro>' + ls_cd_filial_sap + '</centro>'
ps_xml += '<data>' + ls_data + '</data>'
 
return true
end function

public function boolean _of_config_filtro_cab (datastore pds_cab, long pl_linha, ref datastore pds_itens, ref string ps_log);string ls_cd_filial_sap, ls_data

ls_cd_filial_sap = pds_cab.object.id_filial_sap[pl_linha]
ls_data = String(pds_cab.object.data_doc[pl_linha],'dd/mm/yyyy')
			
if pds_itens.setfilter("id_filial_sap = '" + ls_cd_filial_sap + "' and String(data_doc,'dd/mm/yyyy') = '" + ls_data + "'") 	= -1 then
	ps_log = 'Erro ao realizar filtro na datawindow ' + is_ds + '. Objeto: ' + is_Objeto + '; Fun$$HEX2$$e700e300$$ENDHEX$$o: _of_config_filtro_cab'
	return false
end if

RETURN TRUE
end function

public function boolean _of_config_lista_cab (datastore pds_itens, long pl_linha, ref datastore pds_cab, ref string ps_log);string ls_cd_filial_sap, ls_data
long ll_row, ll_find

ls_cd_filial_sap = pds_itens.object.id_filial_sap[pl_linha]
ls_data = String(pds_itens.object.data_doc[pl_linha],'dd/mm/yyyy')
			
ll_find = pds_cab.find("id_filial_sap = '" + ls_cd_filial_sap + "' and String(data_doc,'dd/mm/yyyy') = '" + ls_data + "'" , 1, pds_cab.rowcount()) 

if ll_find = 0 Then
	ll_row = pds_cab.insertrow(0)
	pds_cab.setitem(ll_row,'id_filial_sap', ls_cd_filial_sap)
	pds_cab.setitem(ll_row,'data_doc', date(ls_data))
	
elseif ll_find < 0 Then
	
	ps_log = 'Erro ao realizar FIND na datawindow ' + is_ds + '. Objeto: ' + is_Objeto + '; Fun$$HEX2$$e700e300$$ENDHEX$$o: _of_config_lista_cab'
	return false
	
end if

RETURN TRUE
end function

public function boolean _of_filtra_nr_atualizacao (ref dc_uo_ds_base pds_dados, long pl_nr_atualizacao, ref string ps_log);//Filtra a datastore para trazer um registro espec$$HEX1$$ed00$$ENDHEX$$fico.

if pl_nr_atualizacao > 0 Then
	pds_dados.of_appendwhere( 'a.nr_atualizacao = ' + String(pl_nr_atualizacao))
else
	pds_dados.of_appendwhere( "a.id_status_integracao = 'C' " )
end if

return true
end function

on uo_ge481_est_base.create
call super::create
end on

on uo_ge481_est_base.destroy
call super::destroy
end on

