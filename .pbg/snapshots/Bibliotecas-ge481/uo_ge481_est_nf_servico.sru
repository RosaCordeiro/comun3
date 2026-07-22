HA$PBExportHeader$uo_ge481_est_nf_servico.sru
forward
global type uo_ge481_est_nf_servico from uo_ge481_subida_generica
end type
end forward

global type uo_ge481_est_nf_servico from uo_ge481_subida_generica autoinstantiate
end type

type variables
Long	il_nr_atualizacao, il_nr_nf, il_cd_filial
String	is_Serie, is_especie, is_cd_distribuidora
end variables

forward prototypes
public function boolean _of_parametros ()
public function boolean _of_filtra_nr_atualizacao (ref dc_uo_ds_base pds_dados, long pl_nr_atualizacao, ref string ps_log)
public function boolean _of_processa_retorno_xml (string as_xml, ref string as_log)
public function boolean _of_monta_xml_item (datastore pds_dados, long pl_linha, ref string ps_xml, ref string ps_log)
end prototypes

public function boolean _of_parametros ();
//override
is_Inicio_XML	=	'<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:syn="http://Estorno_NF_Servico_CD/SyncSOAP2Proxy">' + &
						'   <soapenv:Header/>' + &
						'   <soapenv:Body>' + &
						'      <syn:MT_Estorno_Request>'
						
is_Termino_XML	=	'		</syn:MT_Estorno_Request>' + &
						'   </soapenv:Body>' + &
						'</soapenv:Envelope>'
													
ib_usa_cabecalho = False
is_DS = 'ds_ge481_est_nf_servico'
is_Objeto = this.classname( )
is_nome_arquivo = 'est_nf_servico'
is_Parametro_URL = 'CD_URL_EST_NF_SERVICO'
is_Tipo_Log_Exp = 'EST_NF_SERVICO'
is_Descricao_Tipo_Log = 'EST_NF_SERVICO'
is_Nome_Interface = 'EST_NF_SERVICO'

//Subir um documento por vez
ii_contador_xml = 1

return True
end function

public function boolean _of_filtra_nr_atualizacao (ref dc_uo_ds_base pds_dados, long pl_nr_atualizacao, ref string ps_log);if pl_nr_atualizacao > 0 Then
	pds_dados.of_appendwhere('nr_atualizacao = ' + String(pl_nr_atualizacao))
else
	pds_dados.of_appendwhere("id_status_integracao = 'C' ")
end if

return true
end function

public function boolean _of_processa_retorno_xml (string as_xml, ref string as_log);Long 		ll_contador = 1
String 	ls_status


//Aguardar para ver a mensagem real do retorno
ls_status = of_busca_valor(as_xml, '<Status>', ref ll_contador)

if ls_status <> 'Integrado com sucessso' then	
	this.of_atualiza_processado( il_nr_atualizacao, 'E', ls_status, ref as_log)
end if

return true
end function

public function boolean _of_monta_xml_item (datastore pds_dados, long pl_linha, ref string ps_xml, ref string ps_log);DateTime	ldt_dh_emissao, ldt_dh_movimentacao_caixa
Dec{2}	ldc_vl_total_nf, ldc_vl_preco_unitario
Long	 	ll_nr_nf, ll_cd_filial, ll_for, ll_qt_faturada, ll_cd_natureza
String	ls_id_tipo, ls_tp_nf, ls_cd_fornecedor_sap, ls_nr_matricula_registro, ls_de_chave_acesso_remessa, &
			ls_de_serie, ls_de_especie, ls_cd_fornecedor, ls_cd_filial_sap, ls_cd_produto_sap, ls_id_tipo_nf, &
			ls_cd_chave, ls_vl_total_nf, ls_dh_movimentacao_caixa, ls_dh_emissao,&
			ls_pedido_sap

dc_uo_ds_base	ldc_uo_ds_base


ldc_uo_ds_base	= create dc_uo_ds_base

ls_cd_fornecedor					= pds_dados.GetItemString(pl_linha,"cd_fornecedor")
ll_nr_nf								= pds_dados.GetItemNumber(pl_linha,"nr_nf")
il_nr_atualizacao					= pds_dados.GetItemNumber(pl_linha,"nr_atualizacao")

select cd_fornecedor_sap
  into :ls_cd_Fornecedor_sap
  from fornecedor
 where cd_fornecedor = :ls_cd_fornecedor;

Choose Case SQLCA.SQLCode
	Case -1
		ps_log = "Erro ao buscar o c$$HEX1$$f300$$ENDHEX$$digo SAP do fornecedor. " + SQLCA.SQLErrText
		return false
	Case 100
		ps_log = "N$$HEX1$$e300$$ENDHEX$$o foi encontrado o c$$HEX1$$f300$$ENDHEX$$digo SAP do fornecedor."
		return false
End Choose

if IsNull(ls_cd_Fornecedor_sap) then 
	ps_log = "Fornecedor sem c$$HEX1$$f300$$ENDHEX$$digo SAP."
	return false
end if

ps_xml += 	'<CD_Fornecedor>' + ls_cd_Fornecedor_sap + '</CD_Fornecedor>' + &
         	'<NR_NF>' + String(ll_nr_nf) + '</NR_NF>' + &
         	'<NR_Serie>'+'0'+'</NR_Serie>'

Return True
end function

on uo_ge481_est_nf_servico.create
call super::create
end on

on uo_ge481_est_nf_servico.destroy
call super::destroy
end on

