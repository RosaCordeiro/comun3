HA$PBExportHeader$uo_ge481_loja_nf_inventario_estorno.sru
forward
global type uo_ge481_loja_nf_inventario_estorno from uo_ge481_subida_generica
end type
end forward

global type uo_ge481_loja_nf_inventario_estorno from uo_ge481_subida_generica autoinstantiate
end type

type variables
Long	il_Integracao, &
		il_cd_filial_origem, &
		il_nr_nf
String	is_Chave_Interface, &
		is_cd_tipo_documento, &
		is_de_especie, &
		is_de_serie, &
		is_id_status_integracao	= 'C'

end variables

forward prototypes
public function boolean _of_parametros ()
public function boolean _of_filtra_nr_atualizacao (ref dc_uo_ds_base pds_dados, long pl_nr_atualizacao, ref string ps_log)
public function boolean _of_monta_xml_item (datastore pds_dados, long pl_linha, ref string ps_xml, ref string ps_log)
public function boolean _of_processa_retorno_xml (string as_xml, ref string as_log)
public function boolean of_busca_chave_interface_loja_nf_inv (string as_cd_tipo_documento, long anr_nf, long acd_filial, string ade_serie, string ade_especie, ref string as_log)
public function boolean of_log_exportacao_nao_sera_processado (ref string ps_xml, ref string ps_log)
end prototypes

public function boolean _of_parametros ();//override
is_Inicio_XML	=	'<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:exp="exporta_sap.com">'+&
						'<soapenv:Header/>'+&
						'<soapenv:Body>'+&
						'<exp:MT_MOV_MERCADORIA_OUT>'

is_Termino_XML	=	'</exp:MT_MOV_MERCADORIA_OUT>'+&
							'</soapenv:Body>'+&
							'</soapenv:Envelope>'
							
ib_usa_cabecalho = False
is_DS = 'ds_ge481_loja_nf_inventario_est'
is_Objeto = this.classname( )
is_nome_arquivo = 'loja_nf_inventario_est'
is_Parametro_URL = 'CD_URL_LOJA_NF_INVENTARIO_EST'
is_Tipo_Log_Exp = 'LOJA_NF_INVENTARIO_EST'
is_Descricao_Tipo_Log = 'LOJA_NF_INVENTARIO_EST'
is_Nome_Interface = 'LOJA_NF_INVENTARIO_EST'

//Subir um documento por vez
ii_contador_xml = 1

return True
end function

public function boolean _of_filtra_nr_atualizacao (ref dc_uo_ds_base pds_dados, long pl_nr_atualizacao, ref string ps_log);if pl_nr_atualizacao > 0 Then
	pds_dados.of_appendwhere('nr_atualizacao = ' + String(pl_nr_atualizacao))
else
	pds_dados.of_appendwhere("id_status_integracao = 'C' " )
end if

//io_sap_comum.is_usuario = 'GRC_INTEGRACAO'
//io_sap_comum.is_senha = 'Grc_1nt3gNfe'
//io_sap_comum.is_usuario = 'Matavares'
//io_sap_comum.is_senha = 'Abap@001'
//io_sap_comum.is_usuario	= 'PO_INTEGRACAO'
//io_sap_comum.is_senha = 'P0_INTEGRACAO$'

return true
end function

public function boolean _of_monta_xml_item (datastore pds_dados, long pl_linha, ref string ps_xml, ref string ps_log);//override
string ls_nr_documento
string ls_ano_documento
string ls_data
string ls_xml_retorno

ib_envia_webService	= True

is_cd_tipo_documento	= pds_dados.GetItemString(pl_linha,"cd_tipo_documento")
il_cd_filial_origem	= pds_dados.GetItemNumber(pl_linha,"cd_filial")
il_nr_nf					= pds_dados.GetItemNumber(pl_linha,"nr_nf")
is_de_especie			= pds_dados.GetItemString(pl_linha,"de_especie")
is_de_serie				= pds_dados.GetItemString(pl_linha,"de_serie")

//{NR_SOLICITACAO} $$HEX1$$c900$$ENDHEX$$ o nr_solicitacao de envio do movimento 
If Not of_busca_chave_interface_loja_nf_inv(is_cd_tipo_documento, il_nr_nf, il_cd_filial_origem, is_de_serie, is_de_especie, Ref ps_log) Then
	return false
End If

il_Integracao = Long(pds_dados.GetItemDecimal(pl_linha,"nr_atualizacao"))

if is_Chave_Interface = '' or isnull(is_Chave_Interface) Then
	return of_log_exportacao_nao_sera_processado(REF ps_xml, REF ps_log)
end if

if is_id_status_integracao <> 'P' then
	ps_log = 'O documento original ainda n$$HEX1$$e300$$ENDHEX$$o foi enviado para o SAP.'
	return false
end if

ls_data 				= String(pds_dados.GetItemDateTime(pl_linha,"dh_documento"),"YYYYMMDD")
ls_ano_documento 	= String(pds_dados.GetItemNumber(pl_linha,"ano_documento"))
ls_nr_documento 	= String(il_nr_nf)

if ls_data = '' or isnull(ls_data) Then
	ps_log = 'Data do documento {data} n$$HEX1$$e300$$ENDHEX$$o informada.'
	return false
end if

if ls_ano_documento = '' or isnull(ls_ano_documento) Then
	ps_log = 'Ano do documento {ano_documento} n$$HEX1$$e300$$ENDHEX$$o informado.'
	return false
end if

if ls_nr_documento = '' or isnull(ls_nr_documento) Then
	ps_log = 'N$$HEX1$$fa00$$ENDHEX$$mero do documento {nr_documento} n$$HEX1$$e300$$ENDHEX$$o informado.'
	return false
end if

ps_xml += 	'<NR_SOLICITACAO>'+is_Chave_Interface+'</NR_SOLICITACAO>'+&
				'<NR_DOCUMENTO>'+ls_nr_documento+'</NR_DOCUMENTO>'+&
				'<ANO_DOCUMENTO>'+ls_ano_documento+'</ANO_DOCUMENTO>'+&
				'<DATA>'+ls_data+'</DATA>'

return true
end function

public function boolean _of_processa_retorno_xml (string as_xml, ref string as_log);long ll_contador = 1
string ls_Documento_Migo
string ls_dh_estorno
string ls_log_estorno
datetime ldt_dh_estorno


ls_dh_estorno = Trim(of_busca_valor(as_xml, '<DT_ESTORNO>', ref ll_contador))
ldt_dh_estorno = DateTime(Right(ls_dh_estorno,2)+'/'+Mid(ls_dh_estorno,5,2)+'/'+Left(ls_dh_estorno,4))

ll_contador = 1
ls_Documento_Migo = Trim(of_busca_valor(as_xml, '<DOCUMENTO_ESTORNO>', ref ll_contador))

If Dec(ls_Documento_Migo) = 0 or IsNull(ls_Documento_Migo) or Trim(ls_Documento_Migo) = '' Then
	ll_contador = 1
	ls_log_estorno = Trim(of_busca_valor(as_xml, '<LOG_ESTORNO>', ref ll_contador))
	
	this.of_atualiza_processado( il_Integracao, 'E', "Estorno de movimento de estoque n$$HEX1$$e300$$ENDHEX$$o realizado" + "{ Log: " +ls_log_estorno + ' }', ref as_log)
	
	Update log_exportacao_sap 
	Set dh_estornado_sap = :ldt_dh_estorno
	Where nr_atualizacao = :il_Integracao
	Using SQLCA;
	
	If SqlCa.SqlCode = -1 Then
		as_log = "Erro ao atualizar data do estorno do movimento de estoque '_of_processa_retorno_xml': " + SqlCa.SqlerrText
		Return False
	End If
	
Else
	
	Update log_exportacao_sap 
	Set cd_chave_interface = :is_Chave_Interface, nr_documento_sap = :ls_Documento_Migo, dh_estornado_sap = :ldt_dh_estorno
	Where nr_atualizacao = :il_Integracao
	Using SQLCA;
	
	If SqlCa.SqlCode = -1 Then
		as_log = "Erro ao atualizar a chave da interface do estorno do movimento de estoque '_of_processa_retorno_xml': " + SqlCa.SqlerrText
		Return False
	End If
	
	If is_cd_tipo_documento = 'WMB' Then
		
		Update nf_diversa
		Set dh_cancelamento = :ldt_dh_estorno
		Where cd_filial_origem	= :il_cd_filial_origem
			and nr_nf				= :il_nr_nf
			and de_especie			= :is_de_especie
			and de_serie			= :is_de_serie
		Using SQLCA;
		
		If SqlCa.SqlCode = -1 Then
			as_log = "Erro ao atualizar a data de cancelamento da tabela nf_diversa. '_of_processa_retorno_xml': " + SqlCa.SqlerrText
			Return False
		End If
		
	End If
	
end if

Return True
end function

public function boolean of_busca_chave_interface_loja_nf_inv (string as_cd_tipo_documento, long anr_nf, long acd_filial, string ade_serie, string ade_especie, ref string as_log);Select cd_chave_interface,
	    id_status_integracao
Into :is_Chave_Interface,
	  :is_id_status_integracao
From log_exportacao_sap
Where id_tipo_nf 			= 'IVL'
  and id_tipo_log 		= 89
  and cd_tipo_documento = 'IVL'
  and nr_nf					= :anr_nf
  and cd_filial			= :acd_filial
  and de_especie			= :ade_especie
  and de_serie				= :ade_serie
  Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_log = "Erro ao buscar a chave da interface do movimento de estoque 'of_busca_chave_interface_mov_estoque': " + SqlCa.SqlerrText
	Return False
End If

return true
end function

public function boolean of_log_exportacao_nao_sera_processado (ref string ps_xml, ref string ps_log);ps_log	= 'A nota que est$$HEX1$$e100$$ENDHEX$$ sendo estornada n$$HEX1$$e300$$ENDHEX$$o foi enviada para o SAP. O documento ser$$HEX1$$e100$$ENDHEX$$ marcado como processado autom$$HEX1$$e100$$ENDHEX$$ticamente.'

update log_exportacao_sap
	set id_status_integracao = 'P', 
	 	 dh_exportacao = getdate(), 
	 	 de_erro = :ps_log,
	 	 dh_estornado_sap	= getdate()
 where nr_atualizacao = :il_Integracao
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ps_log = "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o de processamento log_exportacao_sap 'of_atualiza_processado': " + SqlCa.SqlerrText
	Return False
End If

ps_xml	= "<xml>Not send</xml>"

ib_envia_webService	= False
return true
end function

on uo_ge481_loja_nf_inventario_estorno.create
call super::create
end on

on uo_ge481_loja_nf_inventario_estorno.destroy
call super::destroy
end on

