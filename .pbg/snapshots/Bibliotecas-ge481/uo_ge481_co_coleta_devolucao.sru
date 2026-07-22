HA$PBExportHeader$uo_ge481_co_coleta_devolucao.sru
forward
global type uo_ge481_co_coleta_devolucao from uo_ge481_subida_generica
end type
end forward

global type uo_ge481_co_coleta_devolucao from uo_ge481_subida_generica autoinstantiate
end type

type variables
Long	il_Integracao
end variables

forward prototypes
public function boolean _of_parametros ()
public function boolean _of_filtra_nr_atualizacao (ref dc_uo_ds_base pds_dados, long pl_nr_atualizacao, ref string ps_log)
public function boolean _of_monta_xml_item (datastore pds_dados, long pl_linha, ref string ps_xml, ref string ps_log)
public function boolean _of_processa_retorno_xml (string as_xml, ref string as_log)
end prototypes

public function boolean _of_parametros ();//override
is_Inicio_XML	=	'<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:imp="importa_sap.com">'+&
						'<soapenv:Header/>'+&
						'<soapenv:Body>'+&
						'<imp:MT_Coleta_Devolucao_Request>'


is_Termino_XML	=	'</imp:MT_Coleta_Devolucao_Request>'+&
							'</soapenv:Body>'+&
							'</soapenv:Envelope>'
							
ib_usa_cabecalho = False
is_DS = 'ds_ge481_co_coleta_devolucao' 
is_Objeto = this.classname( )
is_nome_arquivo = 'coleta_devolucao'
is_Parametro_URL = 'CD_URL_COLETA_DEVOLUCAO'
is_Tipo_Log_Exp = 'COLETA_DEVOLUCAO'
is_Descricao_Tipo_Log = 'COLETA_DEVOLUCAO'
is_Nome_Interface = 'COLETA_DEVOLUCAO'

//Subir um documento por vez
ii_contador_xml = 1

ib_continua_apos_erro_montar_xml = True

return True
end function

public function boolean _of_filtra_nr_atualizacao (ref dc_uo_ds_base pds_dados, long pl_nr_atualizacao, ref string ps_log);if pl_nr_atualizacao > 0 Then
	pds_dados.of_appendwhere('l.nr_atualizacao = ' + String(pl_nr_atualizacao))
else
	pds_dados.of_appendwhere("l.id_status_integracao = 'C' " )
end if

//io_sap_comum.is_usuario = 'GRC_INTEGRACAO'
//io_sap_comum.is_senha = 'Grc_1nt3gNfe'c
//io_sap_comum.is_usuario = 'Matavares'
//io_sap_comum.is_senha = 'Abap@001'
//io_sap_comum.is_usuario	= 'PO_INTEGRACAO'
//io_sap_comum.is_senha = 'P0_INTEGRACAO$'

return true
end function

public function boolean _of_monta_xml_item (datastore pds_dados, long pl_linha, ref string ps_xml, ref string ps_log);Time	lt_dh_documento

Long	ll_cd_filial, &
		ll_nr_nf, &
		ll_count, &
		ll_for
String	ls_cd_fornecedor_sap, &		
		ls_nr_nf_compra, &
		ls_de_serie_compra, &
		ls_cd_chave_acesso_compra, &
		ls_de_serie, &
		ls_de_especie, &
		ls_id_tipo_nota, &
		ls_centro, &
		ls_de_chave_acesso, &
		ls_id_situacao_coleta, &
		ls_vl_total_nf, &
		ls_nr_matricula_comprador, &
		ls_nr_agrupamento_wms, &
		ls_dt_emissao, &
		ls_dh_situacao_coleta, &
		ls_nm_usuario_agrup_wms, &
		ls_de_motivo_devolucao, &
		ls_nm_usuario_sit_coleta, &
		ls_hr_documento

dc_uo_ds_base lds_coleta_devolucao_nota

Try
	
	lds_coleta_devolucao_nota = create dc_uo_ds_base
	
	If Not lds_coleta_devolucao_nota.of_ChangeDataObject('ds_ge481_co_coleta_devolucao_nota', False) Then
		ps_log = "Erro ao alterar a DW 'ds_ge481_co_verbas_pescador_nf_produto'."
		Return False
	End If

	ll_cd_filial				= pds_dados.GetItemNumber(pl_linha,"cd_filial")
	ll_nr_nf						= pds_dados.GetItemNumber(pl_linha,"nr_nf")
	ls_de_serie					= pds_dados.GetItemString(pl_linha,"de_serie")
	ls_de_especie				= pds_dados.GetItemString(pl_linha,"de_especie")
	ls_cd_fornecedor_sap		= pds_dados.GetItemString(pl_linha,"cd_fornecedor_sap")
	ls_centro					= pds_dados.GetItemString(pl_linha,"centro")
	ls_id_tipo_nota			= pds_dados.GetItemString(pl_linha,"cd_chave")
	ls_id_situacao_coleta 	= pds_dados.GetItemString(pl_linha,"cd_varchar")
	il_Integracao				= Long(pds_dados.GetItemDecimal(pl_linha,"nr_atualizacao"))
	ls_hr_documento			= String(Time(pds_dados.GetItemDateTime(pl_linha,"dh_documento")), 'hhmmss')
	
	Choose Case Left(Trim(ls_id_tipo_nota),4)
		Case "DEV#"
			ls_id_tipo_nota = 'DEV'
		Case "COL#"
			ls_id_tipo_nota = 'COL'
		Case Else
			//
	End Choose
	
	If ll_cd_filial = 0 or isnull(ll_cd_filial) Then
		ps_log = 'C$$HEX1$$f300$$ENDHEX$$digo da filial {cd_filial} n$$HEX1$$e300$$ENDHEX$$o informado.'
		Return False
	End If
	
	If ll_nr_nf = 0 or isnull(ll_nr_nf) Then
		ps_log = 'N$$HEX1$$fa00$$ENDHEX$$mero da nota fiscal {nr_nf} n$$HEX1$$e300$$ENDHEX$$o informado.'
		Return False
	End If
	
	If ls_cd_fornecedor_sap = '' or isnull(ls_cd_fornecedor_sap) Then
		ps_log = 'C$$HEX1$$f300$$ENDHEX$$digo do fornecedor no SAP {cd_fornecedor} n$$HEX1$$e300$$ENDHEX$$o informado.'
		Return False
	End If
	
	If ls_centro = '' or isnull(ls_centro) Then
		ps_log = 'C$$HEX1$$f300$$ENDHEX$$digo do centro do SAP {centro} n$$HEX1$$e300$$ENDHEX$$o informado.'
		Return False
	End If
	
	If IsNull(ls_de_serie) or ls_de_serie = "" Then
		ps_log = 'S$$HEX1$$e900$$ENDHEX$$rie da Nota Fiscal {de_serie} n$$HEX1$$e300$$ENDHEX$$o informada.'
		Return False
	End If
	
	If IsNull(ls_de_especie) or ls_de_especie = "" Then
		ps_log = 'Especie da Nota Fiscal {de_especie} n$$HEX1$$e300$$ENDHEX$$o informada.'
		Return False
	End If
	
	If IsNull(ls_id_tipo_nota) Then ls_id_tipo_nota = ""
		
	ll_count = lds_coleta_devolucao_nota.retrieve( ll_cd_filial, ll_nr_nf, ls_de_serie, ls_de_especie, ls_id_tipo_nota )
	
	If ll_count < 0 Then
		ps_log = "Erro ao recuperar os dados da DW 'ds_coleta_devolucao_nota'."
		Return False
	End If
	
	For ll_for = 1 To ll_count
		
		ls_dt_emissao = String(lds_coleta_devolucao_nota.GetItemDateTime(ll_for,"dh_emissao"),"YYYYMMDD")
		ls_dh_situacao_coleta = String(lds_coleta_devolucao_nota.GetItemDateTime(ll_for,"dh_situacao_coleta"),"YYYYMMDD")
		ls_de_chave_acesso = lds_coleta_devolucao_nota.GetItemString(ll_for,"de_chave_acesso")
		ls_vl_total_nf = String(lds_coleta_devolucao_nota.GetItemNumber(ll_for,"vl_total_nf"))
		ls_vl_total_nf = gf_replace(ls_vl_total_nf,',','.',0)
		
		ls_nr_matricula_comprador = lds_coleta_devolucao_nota.GetItemString(ll_for,"nr_matricula_comprador")
		ls_nr_agrupamento_wms = String(lds_coleta_devolucao_nota.GetItemNumber(ll_for,"nr_agrupamento_dev_compra"))		
		ls_nm_usuario_agrup_wms = lds_coleta_devolucao_nota.GetItemString(ll_for,"nm_usuario_agrup_wms")
		ls_de_motivo_devolucao = lds_coleta_devolucao_nota.GetItemString(ll_for,"de_motivo_devolucao")
		ls_nm_usuario_sit_coleta = lds_coleta_devolucao_nota.GetItemString(ll_for,"nm_usuario_sit_coleta")
		
		ls_nr_nf_compra = String(lds_coleta_devolucao_nota.GetItemNumber(ll_for,"nr_nf_compra"))		
		ls_de_serie_compra = lds_coleta_devolucao_nota.GetItemString(ll_for,"de_serie_compra")		
		ls_cd_chave_acesso_compra = lds_coleta_devolucao_nota.GetItemString(ll_for,"de_chave_acesso_compra")
		
		If IsNull(ls_de_chave_acesso) or ls_de_chave_acesso = "" Then
			ps_log = 'Chave de acesso da nota fiscal de devolu$$HEX2$$e700e300$$ENDHEX$$o {cd_chave_acesso} n$$HEX1$$e300$$ENDHEX$$o informada.'
			Return False
		End If
		
		If IsNull(ls_cd_chave_acesso_compra) or ls_cd_chave_acesso_compra = "" Then
			ps_log = 'Chave de acesso da nota fiscal de compra {cd_chave_acesso_compra} n$$HEX1$$e300$$ENDHEX$$o informada.'
			Return False
		End If
		
		If IsNull(ls_de_serie_compra) or ls_de_serie_compra = "" Then
			ps_log = 'S$$HEX1$$e900$$ENDHEX$$rie da nota fiscal de compra {de_serie_compra} n$$HEX1$$e300$$ENDHEX$$o informada.'
			Return False
		End If
		
		If IsNull(ls_nr_nf_compra) or ls_nr_nf_compra = "" Then
			ps_log = 'N$$HEX1$$fa00$$ENDHEX$$mero da nota fiscal de compra {nr_nf_compra} n$$HEX1$$e300$$ENDHEX$$o informada.'
			Return False
		End If
		
		If IsNull(ls_nm_usuario_sit_coleta) Then ls_nm_usuario_sit_coleta = ""	
		If IsNull(ls_de_motivo_devolucao) Then ls_de_motivo_devolucao = ""
		If IsNull(ls_nr_matricula_comprador) Then ls_nr_matricula_comprador = ""
		If IsNull(ls_nr_agrupamento_wms) Then ls_nr_agrupamento_wms = ""		
		If IsNull(ls_nm_usuario_agrup_wms) Then ls_nm_usuario_agrup_wms = ""
		If IsNull(ls_de_chave_acesso) Then ls_de_chave_acesso = ""
		If IsNull(ls_dh_situacao_coleta) Then ls_dh_situacao_coleta = ""
		If IsNull(ls_hr_documento) Then ls_hr_documento = ""
		
		If IsNull(ls_vl_total_nf) or ls_vl_total_nf = "" Then
			ps_log = 'Valor da Nota Fiscal {vl_nota} n$$HEX1$$e300$$ENDHEX$$o informado.'
			Return False
		End If
		
		If IsNull(ls_dt_emissao) or ls_dt_emissao = "" Then
			ps_log = 'Data de emiss$$HEX1$$e300$$ENDHEX$$o {dt_emissao} n$$HEX1$$e300$$ENDHEX$$o informada.'
			Return False
		End If
		
		ps_xml += "<DADOS>"
		ps_xml += "<cd_fornecedor>"+ls_cd_fornecedor_sap+"</cd_fornecedor>"
		ps_xml += "<nr_nf>"+String(ll_nr_nf)+"</nr_nf>"
		ps_xml += "<nr_serie_nf>"+ls_de_serie+"</nr_serie_nf>"
		ps_xml += "<cd_centro>"+ls_centro+"</cd_centro>"
		ps_xml += "<data_emissao>"+ls_dt_emissao+"</data_emissao>"
		ps_xml += "<cd_chave_acesso>"+ls_de_chave_acesso+"</cd_chave_acesso>"
		ps_xml += "<nr_matricula_comprador>"+ls_nr_matricula_comprador+"</nr_matricula_comprador>"
		ps_xml += "<vl_nota>"+ls_vl_total_nf+"</vl_nota>"
		ps_xml += "<nr_agrupamento_wms>"+ls_nr_agrupamento_wms+"</nr_agrupamento_wms>"
		ps_xml += "<nome_usuario_agrup_wms>"+ls_nm_usuario_agrup_wms+"</nome_usuario_agrup_wms>"
		ps_xml += "<desc_motivo_devolucao>"+ls_de_motivo_devolucao+"</desc_motivo_devolucao>"
		ps_xml += "<id_situacao_coleta>"+ls_id_situacao_coleta+"</id_situacao_coleta>"
		ps_xml += "<data_situacao_coleta>"+ls_dh_situacao_coleta+"</data_situacao_coleta>"
		ps_xml += "<hora_situacao_coleta>"+ls_hr_documento+"</hora_situacao_coleta>"
		ps_xml += "<nome_sit_usuario_coleta>"+ls_nm_usuario_sit_coleta+"</nome_sit_usuario_coleta>"
		ps_xml += "<nr_nf_compra>"+ls_nr_nf_compra+"</nr_nf_compra>"
		ps_xml += "<nr_serie_nf_compra>"+ls_de_serie_compra+"</nr_serie_nf_compra>"
		ps_xml += "<cd_chave_acesso_compra>"+ls_cd_chave_acesso_compra+"</cd_chave_acesso_compra>"
		ps_xml += "</DADOS>"
	Next
	
Finally
	Destroy(lds_coleta_devolucao_nota)
End Try	

Return True
end function

public function boolean _of_processa_retorno_xml (string as_xml, ref string as_log);long ll_contador = 1
string ls_status

ll_contador = 1
ls_status = Trim(of_busca_valor(as_xml, '<status>', ref ll_contador))

If Lower(ls_status) <> "integrado com sucesso" Then
		
	this.of_atualiza_processado( il_Integracao, 'E', "Envio da coleta de devolu$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o realizado" + "{ Log: " +ls_status + ' }', ref as_log)
	
End If

Return True
end function

on uo_ge481_co_coleta_devolucao.create
call super::create
end on

on uo_ge481_co_coleta_devolucao.destroy
call super::destroy
end on

