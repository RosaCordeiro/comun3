HA$PBExportHeader$uo_ge481_nf_servico.sru
forward
global type uo_ge481_nf_servico from uo_ge481_subida_generica
end type
end forward

global type uo_ge481_nf_servico from uo_ge481_subida_generica autoinstantiate
end type

type variables
Long	il_nr_atualizacao, il_nr_nf, il_cd_filial
String	is_Serie, is_especie, is_cd_distribuidora
end variables

forward prototypes
public function boolean _of_parametros ()
public function boolean _of_filtra_nr_atualizacao (ref dc_uo_ds_base pds_dados, long pl_nr_atualizacao, ref string ps_log)
public function boolean _of_processa_retorno_xml (string as_xml, ref string as_log)
public function boolean of_atualiza_processado (datastore pds_itens, long pl_linha, long pl_nr_atualizacao, string ps_status, string as_mensagem, ref string as_log)
public function boolean _of_monta_xml_item (datastore pds_dados, long pl_linha, ref string ps_xml, ref string ps_log)
end prototypes

public function boolean _of_parametros ();
//override
is_Inicio_XML	=	'<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:imp="importa_sap.com">' + &
						'   <soapenv:Header/>' + &
						'   <soapenv:Body>' + &
						'      <imp:MT_EntServCD_Request>'

is_Termino_XML	=	'		</imp:MT_EntServCD_Request>' + &
						'   </soapenv:Body>' + &
						'</soapenv:Envelope>'
							
ib_usa_cabecalho = False
is_DS = 'ds_ge481_nf_servico'
is_Objeto = this.classname( )
is_nome_arquivo = 'nf_servico'
is_Parametro_URL = 'CD_URL_NF_SERVICO'
is_Tipo_Log_Exp = 'NF_SERVICO'
is_Descricao_Tipo_Log = 'NF_SERVICO'
is_Nome_Interface = 'NF_SERVICO'

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
ls_status = of_busca_valor(as_xml, '<status>', ref ll_contador)

if ls_status <> 'Integrado com sucesso' and ls_status <> '' then	
	this.of_atualiza_processado( il_nr_atualizacao, 'E', ls_status, ref as_log)
end if

return true
end function

public function boolean of_atualiza_processado (datastore pds_itens, long pl_linha, long pl_nr_atualizacao, string ps_status, string as_mensagem, ref string as_log);Long		ll_nr_atualizacao
String	ls_status, ls_msg


If il_nr_atualizacao = 0 or isnull(il_nr_atualizacao) Then
	ll_nr_atualizacao = pds_itens.Object.nr_atualizacao[pl_linha]
Else
	ll_nr_atualizacao = il_nr_atualizacao
End If

If ps_status = 'E' Then
	ls_status = 'E'
	
	ls_msg = as_mensagem
Else
	ls_status = 'P'
	
	SetNull(ls_msg)
End if

update log_exportacao_sap
   set log_exportacao_sap.id_status_integracao = :ls_status, 
		 log_exportacao_sap.dh_exportacao = getdate(), 
		 log_exportacao_sap.de_erro = :ls_msg
 where log_exportacao_sap.nr_atualizacao = :ll_nr_atualizacao
Using SqlCa;

If SQLCA.SqlCode = -1 Then
	as_log = "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o de processamento log_exportacao_sap 'of_atualiza_processado': " + SQLCA.SQLErrText
	Return False
End If

update nf_compra
	set dh_enviado_sap = getdate()
 where nr_nf			= :il_nr_nf
 	and cd_filial 		= :il_cd_filial 
	and cd_fornecedor	= :is_cd_distribuidora
   and de_serie		= :is_serie
	and de_especie		= :is_especie
using sqlca;

if SQLCA.SqlCode = -1 Then
	as_log += "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o dos campos de exportacao na tabela 'nf_compra', fun$$HEX2$$e700e300$$ENDHEX$$o 'of_atualiza_processado	': " + SqlCa.SqlerrText
	return false
end if

return true
end function

public function boolean _of_monta_xml_item (datastore pds_dados, long pl_linha, ref string ps_xml, ref string ps_log);DateTime	ldt_dh_emissao, ldt_dh_movimentacao_caixa
Dec{2}	ldc_vl_total_nf, ldc_vl_preco_unitario, ldc_pc_desconto
Long	 	ll_nr_nf, ll_cd_filial, ll_for, ll_qt_faturada, ll_cd_natureza
String	ls_id_tipo, ls_tp_nf, ls_cd_fornecedor_sap, ls_nr_matricula_registro, ls_de_chave_acesso_remessa, &
			ls_de_serie, ls_de_especie, ls_cd_fornecedor, ls_cd_filial_sap, ls_cd_produto_sap, ls_id_tipo_nf, &
			ls_cd_chave, ls_vl_total_nf, ls_dh_movimentacao_caixa, ls_dh_emissao,&
			ls_pedido_sap

dc_uo_ds_base	ldc_uo_ds_base


ldc_uo_ds_base	= create dc_uo_ds_base

ls_id_tipo							= pds_dados.GetItemString(pl_linha,"id_tipo")
ls_cd_fornecedor_sap				= pds_dados.GetItemString(pl_linha,"cd_fornecedor_sap")
ls_nr_matricula_registro		= pds_dados.GetItemString(pl_linha,"nr_matricula_registro")
ls_de_chave_acesso_remessa 	= pds_dados.GetItemString(pl_linha,"de_chave_acesso_remessa")
ls_de_serie							= pds_dados.GetItemString(pl_linha,"de_serie")
ls_de_especie						= pds_dados.GetItemString(pl_linha,"de_especie")
ls_cd_fornecedor					= pds_dados.GetItemString(pl_linha,"cd_fornecedor")
ls_cd_chave							= pds_dados.GetItemString(pl_linha,"cd_chave")
ls_id_tipo_nf						= pds_dados.GetItemString(pl_linha,"id_tipo_nf")
ll_nr_nf								= pds_dados.GetItemNumber(pl_linha,"nr_nf")
ls_pedido_sap						= pds_dados.GetItemString(pl_linha,"nr_pedido_sap")
ll_cd_filial						= pds_dados.GetItemNumber(pl_linha,"cd_filial")
ldc_vl_total_nf					= pds_dados.GetItemNumber(pl_linha,"vl_total_nf")
ldt_dh_emissao						= pds_dados.GetItemDateTime(pl_linha,"dh_emissao")
ldt_dh_movimentacao_caixa		= pds_dados.GetItemDateTime(pl_linha,"dh_movimentacao_caixa")

il_nr_atualizacao	= pds_dados.Object.nr_atualizacao[pl_linha]

if IsNull(ls_pedido_sap) then
	ps_log = "N$$HEX1$$e300$$ENDHEX$$o foi encontrado o c$$HEX1$$f300$$ENDHEX$$digo do pedido SAP"
	return false
end if

select cd_chave_sap
  into :ls_cd_filial_sap
  from integracao_sap
 where cd_tabela	= 'FILIAL'
 	and cd_chave_legado	= cast(:ll_cd_filial as varchar(4));

Choose Case SQLCA.SQLCode
	Case -1
		ps_log = "Erro ao buscar o c$$HEX1$$f300$$ENDHEX$$digo SAP da filial. " + SQLCA.SQLErrText
		return false
	Case 100
		ps_log = "N$$HEX1$$e300$$ENDHEX$$o foi encontrado o c$$HEX1$$f300$$ENDHEX$$digo SAP da filial."
		return false
End Choose

if IsNull(ls_de_chave_acesso_remessa) then ls_de_chave_acesso_remessa = ''

if ls_id_tipo_nf = 'NFS' then
	ls_tp_nf = '01'
	ls_vl_total_nf					= gf_Valor_Com_Ponto(ldc_vl_total_nf)
	ls_dh_movimentacao_caixa	= String(ldt_dh_movimentacao_caixa, 'dd.mm.yyyy')
	ls_dh_emissao					= String(ldt_dh_emissao, 'dd.mm.yyyy')
	
	if ISNull(ls_dh_movimentacao_caixa) or Trim(ls_dh_movimentacao_caixa) = '' then
		ls_dh_movimentacao_caixa	= ls_dh_emissao
	end if
else
	ls_tp_nf = '02'
	
	ls_de_chave_acesso_remessa	= ls_cd_chave
	ls_nr_matricula_registro			= ''
	ls_pedido_sap						= ''
	ls_vl_total_nf						= ''
	ls_dh_movimentacao_caixa		= ''
	ls_dh_emissao						= ''
end if

ps_xml += 	'<TP_Serv>'+ls_tp_nf+'</TP_Serv>'+&
				'<CD_Fornecedor>'+ls_cd_fornecedor_sap+'</CD_Fornecedor>'+&
				'<NR_NF>'+String(ll_nr_nf)+'</NR_NF>'+&
				'<NR_Serie>' + ls_de_serie + '</NR_Serie>' + &
				'<TP_NF>'+ls_tp_nf+'</TP_NF>'+&
				'<DT_Emissao_NF>'+ls_dh_emissao+'</DT_Emissao_NF>'+&
				'<DT_Lancamento_NF>'+ls_dh_movimentacao_caixa+'</DT_Lancamento_NF>'+&
				'<VL_Total_NF>'+ls_vl_total_nf+'</VL_Total_NF>'+&
				'<NR_Pedido>'+ls_pedido_sap+'</NR_Pedido>'+&
				'<Matricula_Usuario>'+ls_nr_matricula_registro+'</Matricula_Usuario>'+&
				'<Chave_Acesso>'+ls_de_chave_acesso_remessa+'</Chave_Acesso>'

If Not ldc_uo_ds_base.of_changedataobject('ds_ge481_nf_servico_detalhes', False) Then
	ps_log = "Erro ao alterar a DW 'ds_ge481_nf_servico_detalhes'."
	return false
end if

if ls_tp_nf = '02' then
	ps_xml += 	'<Itens></Itens>'
else
	ldc_uo_ds_base.Retrieve(ll_cd_filial, ll_nr_nf, ls_de_serie, ls_de_especie, ls_cd_fornecedor)
	
	for ll_for = 1 to ldc_uo_ds_base.RowCount()
		ll_cd_natureza				= ldc_uo_ds_base.GetItemNumber(ll_for,"cd_natureza_operacao")
		ls_cd_produto_sap			= ldc_uo_ds_base.GetItemString(ll_for,"cd_produto_sap")
		ll_qt_faturada				= ldc_uo_ds_base.GetItemNumber(ll_for,"qt_faturada")
		ldc_vl_preco_unitario	= ldc_uo_ds_base.GetItemNumber(ll_for,"vl_preco_unitario")
		ldc_pc_desconto			= ldc_uo_ds_base.GetItemNumber(ll_for,"pc_desconto")
		
		ldc_vl_preco_unitario = ldc_vl_preco_unitario - ldc_vl_preco_unitario * (ldc_pc_desconto / 100)
		
		ps_xml += 	'<Itens>' + &
						'<CD_Filial>'+ls_cd_filial_sap+'</CD_Filial>'+&
						'<Natureza_Operacao>'+String(ll_cd_natureza)+'</Natureza_Operacao>'+&
						'<NR_Pedido>'+ls_pedido_sap+'</NR_Pedido>'+&
						'<CD_Material>'+ls_cd_produto_sap+'</CD_Material>'+&
						'<Quantidade>'+String(ll_qt_faturada)+'</Quantidade>'+&
						'<VL_Unitario>'+String(ldc_vl_preco_unitario)+'</VL_Unitario>'+&
						'</Itens>'
	next
end if

Return True
end function

on uo_ge481_nf_servico.create
call super::create
end on

on uo_ge481_nf_servico.destroy
call super::destroy
end on

