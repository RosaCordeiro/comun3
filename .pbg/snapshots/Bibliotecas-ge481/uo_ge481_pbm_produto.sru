HA$PBExportHeader$uo_ge481_pbm_produto.sru
forward
global type uo_ge481_pbm_produto from uo_ge481_subida_generica
end type
end forward

global type uo_ge481_pbm_produto from uo_ge481_subida_generica autoinstantiate
integer ii_contador_xml = 500
boolean ib_usa_cabecalho = false
end type

forward prototypes
public function boolean _of_parametros ()
public function boolean _of_monta_xml_item (datastore pds_dados, long pl_linha, ref string ps_xml, ref string ps_log)
public function boolean _of_filtra_nr_atualizacao (ref dc_uo_ds_base pds_dados, long pl_nr_atualizacao, ref string ps_log)
end prototypes

public function boolean _of_parametros ();is_Inicio_XML	=	'<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:exp="exporta_sap.com">'+&
						'  <soapenv:Header/>'+&
						' <soapenv:Body>'+&
						'<exp:MT_MaterialPBM_Request>'	
							
is_Termino_XML	=	'</exp:MT_MaterialPBM_Request>'+&
						   	'</soapenv:Body>'+&
							'</soapenv:Envelope>'

is_DS = 'ds_ge481_pbm_produto'
is_Objeto = this.classname( )
is_nome_arquivo = 'pbm_produto_xml'
is_Parametro_URL = 'CD_URL_PRODUTO_PBM'
is_Tipo_Log_Exp = 'PBM'
is_Descricao_Tipo_Log = 'PRODUTO_PBM'
is_Nome_Interface = 'PRODUTO PBM'

return True
end function

public function boolean _of_monta_xml_item (datastore pds_dados, long pl_linha, ref string ps_xml, ref string ps_log);string ls_cd_produto_sap, ls_tp_operacao
string ls_pbm

ls_cd_produto_sap = pds_dados.object.cd_produto_sap[pl_linha]
ls_tp_operacao = pds_dados.object.id_tipo_operacao[pl_linha]

if ls_tp_operacao = 'I' Then
	ls_pbm = 'X'
else
	ls_pbm = ''
end if

ps_xml += '<dados>'
ps_xml += '<material>' + ls_cd_produto_sap + '</material>'
ps_xml += '<pbm>' + ls_pbm + '</pbm>'
ps_xml += '</dados>'

return true
end function

public function boolean _of_filtra_nr_atualizacao (ref dc_uo_ds_base pds_dados, long pl_nr_atualizacao, ref string ps_log);//Filtra a datastore para trazer um registro espec$$HEX1$$ed00$$ENDHEX$$fico.

if pl_nr_atualizacao > 0 Then
	pds_dados.of_appendwhere( 'ls.nr_atualizacao = ' + String(pl_nr_atualizacao) )
else
	pds_dados.of_appendwhere( "ls.id_status_integracao = 'C' " )
end if

return true
end function

on uo_ge481_pbm_produto.create
call super::create
end on

on uo_ge481_pbm_produto.destroy
call super::destroy
end on

