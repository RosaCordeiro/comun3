HA$PBExportHeader$uo_ge481_loja_nf_inventario.sru
forward
global type uo_ge481_loja_nf_inventario from uo_ge481_subida_generica
end type
end forward

global type uo_ge481_loja_nf_inventario from uo_ge481_subida_generica autoinstantiate
end type

type variables
Long il_Integracao
String is_tipo_movimento
String is_Texto_Item = ''
end variables

forward prototypes
public function boolean _of_parametros ()
public function boolean _of_filtra_nr_atualizacao (ref dc_uo_ds_base pds_dados, long pl_nr_atualizacao, ref string ps_log)
public function boolean _of_monta_xml_item (datastore pds_dados, long pl_linha, ref string ps_xml, ref string ps_log)
public function boolean _of_processa_retorno_xml (string as_xml, ref string as_log)
public function boolean of_atualiza_chave_interface (string ps_chave, ref string ps_log)
public function boolean of_monta_xml_item_produto (long pl_nr_integracao, ref string ps_xml, ref string ps_log, ref string ps_tipo_movimento, string ps_cd_motivo_ajuste, string ps_de_comentario_ajuste, string ps_deposito_saida, string ps_deposito_entrada)
public function boolean of_monta_xml_item_produto_imposto (dc_uo_ds_base adc_uo_itens, long al_row, ref string as_xml)
end prototypes

public function boolean _of_parametros ();//override
is_Inicio_XML	=	'<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:exp="exporta_sap.com">'+&
						'<soapenv:Header/>'+&
						'<soapenv:Body>'+&
						'<exp:MT_MOV_MERCADORIA_SAIDA>'

is_Termino_XML	=	'</exp:MT_MOV_MERCADORIA_SAIDA>'+&
							'</soapenv:Body>'+&
							'</soapenv:Envelope>'
							
ib_usa_cabecalho 			= False
is_DS 						= 'ds_ge481_loja_nf_inventario'
is_Objeto 					= this.classname( )
is_nome_arquivo 			= 'loja_nf_inventario'
is_Parametro_URL 			= 'CD_URL_LOJA_NF_INVENTARIO'
is_Tipo_Log_Exp 			= 'LOJA_NF_INVENTARIO'
is_Descricao_Tipo_Log 	= 'LOJA_NF_INVENTARIO'
is_Nome_Interface 		= 'LOJA_NF_INVENTARIO'

//Subir um documento por vez
ii_contador_xml = 1 

return True
end function

public function boolean _of_filtra_nr_atualizacao (ref dc_uo_ds_base pds_dados, long pl_nr_atualizacao, ref string ps_log);if pl_nr_atualizacao > 0 Then
	pds_dados.of_appendwhere('nr_atualizacao = ' + String(pl_nr_atualizacao))
else
	pds_dados.of_appendwhere("id_status_integracao = 'C' " )
end if

return true
end function

public function boolean _of_monta_xml_item (datastore pds_dados, long pl_linha, ref string ps_xml, ref string ps_log);long		ll_cd_natureza_operacao
long		ll_cd_motivo_sap
long		ll_cd_perfil_nf
long		ll_cd_filial_origem
string ls_nr_solicitacao
string ls_data_movimentacao
string ls_data_lancamento
string ls_direcao_movimento
string ls_tipo_movimento
string ls_xml_item
string ls_dados_adicionais = ''
string ls_empresa
string ls_de_chave_acesso
string ls_nr_protocolo_envio
string ls_de_comentario_ajuste
string ls_cd_motivo_sap
string ls_deposito_saida
string ls_deposito_entrada

ls_data_movimentacao = String(pds_dados.GetItemDateTime(pl_linha,"dh_movimentacao_caixa"),"YYYYMMDD")
ls_data_lancamento = String(pds_dados.GetItemDateTime(pl_linha,"dh_emissao"),"YYYYMMDD")
il_Integracao = Long(pds_dados.GetItemDecimal(pl_linha,"nr_atualizacao"))
ls_Dados_Adicionais = pds_dados.GetItemString(pl_linha,"dados_adicionais")
ll_cd_natureza_operacao	= pds_dados.GetItemNumber(pl_linha,"cd_natureza_operacao")
ls_de_chave_acesso = pds_dados.GetItemString(pl_linha,"de_chave_acesso")
ls_nr_protocolo_envio	= pds_dados.GetItemString(pl_linha,"nr_protocolo_envio")
ls_cd_motivo_sap = pds_dados.GetItemString(pl_linha,"cd_motivo_sap")
ll_cd_perfil_nf = pds_dados.GetItemNumber(pl_linha,"cd_perfil_nf")
ls_de_comentario_ajuste	= pds_dados.GetItemString(pl_linha,"de_comentario_ajuste")
ll_cd_filial_origem	= pds_dados.GetItemNumber(pl_linha,"cd_filial_origem")

select 
	cd_tipo_movimento_sap,
	cd_direcao_movimento_sap
into 
	:ls_tipo_movimento,
	:ls_direcao_movimento
from 
	integracao_sap_nf
where 
	cd_natureza_operacao	= :ll_cd_natureza_operacao 
	and cd_perfil_nf	 = :ll_cd_perfil_nf 
	and id_tipo_envio = 'ENV'
	and cd_filial = :ll_cd_filial_origem;

choose case sqlca.sqlcode
	case -1
		ps_log = 'Erro ao buscar informa$$HEX2$$e700f500$$ENDHEX$$es da tabela integracao_sap_nf. ' + sqlca.sqlerrtext
		return false
	case 100
		ps_log = 'n$$HEX1$$e300$$ENDHEX$$o foi encontrado dados na tabela integracao_sap_nf referente a natureza ' + String(ll_cd_natureza_operacao) + '(ENV)'
		return false
end choose

ls_empresa	= '1000'

If Not lf_ge481_proxima_solicitacao_sap(Ref ls_nr_solicitacao, Ref ps_log) Then return false
If Not of_atualiza_chave_interface(ls_nr_solicitacao, Ref ps_log) Then return false

if ls_nr_solicitacao = '' or isnull(ls_nr_solicitacao) Then
	ps_log = 'N$$HEX1$$fa00$$ENDHEX$$mero da solicita$$HEX2$$e700e300$$ENDHEX$$o de envio {nr_solicitacao} n$$HEX1$$e300$$ENDHEX$$o informado.'
	return false
end if

if ls_data_movimentacao = '' or isnull(ls_data_movimentacao) Then
	ps_log = 'Data da movimenta$$HEX2$$e700e300$$ENDHEX$$o de estoque {data_movimentacao} n$$HEX1$$e300$$ENDHEX$$o informada.'
	return false
end if

if ls_data_lancamento = '' or isnull(ls_data_lancamento) Then
	ps_log = 'Data de lan$$HEX1$$e700$$ENDHEX$$amento do movimento de estoque {data_lancamento} n$$HEX1$$e300$$ENDHEX$$o informada.'
	return false
end if

if Trim(ls_de_chave_acesso) = '' or IsNull(ls_de_chave_acesso) then
	ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi informada a chave de acesso da nf_diversa.'
	return false
end if

if Trim(ls_nr_protocolo_envio) = '' or IsNull(ls_nr_protocolo_envio) then
	ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi informada o protocolo de envio da nf_diversa.'
	return false
end if

if IsNull(ls_de_comentario_ajuste) then ls_de_comentario_ajuste = ''
if IsNull(ls_cd_motivo_sap) then ls_cd_motivo_sap = ''

choose case left(String(ll_cd_natureza_operacao), 1)
	case '5', '6', '7'
		ls_deposito_saida 	= '0005'
		ls_deposito_entrada 	= ''			
	case '1', '2', '3'
		ls_deposito_saida 	= ''
		ls_deposito_entrada 	= '0005'			
end choose

If Not of_monta_xml_item_produto(il_Integracao, ref ls_xml_item, ref ps_log, ref ls_tipo_movimento, ls_cd_motivo_sap, ls_de_comentario_ajuste, ls_deposito_saida, ls_deposito_entrada) Then
	Return False
End If

ps_xml += '<CABECALHO>'+&
				'<NR_SOLICITACAO>'+ls_nr_solicitacao+'</NR_SOLICITACAO>'+&
				'<DATA_MOVIMENTACAO>'+ls_data_movimentacao+'</DATA_MOVIMENTACAO>'+&
				'<DATA_LANCAMENTO>'+ls_data_lancamento+'</DATA_LANCAMENTO>'+&
				'<DIRECAO_MOVIMENTO>'+ls_direcao_movimento+'</DIRECAO_MOVIMENTO>'+&
				'<TIPO_MOVIMENTO>'+ls_tipo_movimento+'</TIPO_MOVIMENTO>'+&
				'<EMPRESA>'+ls_empresa+'</EMPRESA>'+&
				'<DADOS_ADICIONAIS>'+ ls_Dados_Adicionais + '</DADOS_ADICIONAIS>'+&
				'<FORNECEDOR></FORNECEDOR>'+&
				'<NF_TRANSPORTE></NF_TRANSPORTE>'+&
				'<CHAVE_ACESSO>'+ls_de_chave_acesso+'</CHAVE_ACESSO>'+&
				'<LOG>' + ls_nr_protocolo_envio + '</LOG>'+&
				'</CABECALHO>'

ps_xml += ls_xml_item

return true
end function

public function boolean _of_processa_retorno_xml (string as_xml, ref string as_log);long ll_contador = 1
string ls_msg

ls_msg = of_busca_valor(as_xml, '<MENSAGEM>', ref ll_contador)

if upper(Trim(ls_msg)) <> 'INSERIDO COM SUCESSO' Then
	
	this.of_atualiza_processado( il_Integracao, 'E', ls_msg, ref as_log)
	
end if

return True
end function

public function boolean of_atualiza_chave_interface (string ps_chave, ref string ps_log);String	ls_cd_chave


update log_exportacao_sap
set cd_chave_interface = :ps_chave
where nr_atualizacao = :il_Integracao
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ps_log = "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o de processamento log_exportacao_sap 'of_atualiza_processado': " + SqlCa.SqlerrText
	Return False
End If
end function

public function boolean of_monta_xml_item_produto (long pl_nr_integracao, ref string ps_xml, ref string ps_log, ref string ps_tipo_movimento, string ps_cd_motivo_ajuste, string ps_de_comentario_ajuste, string ps_deposito_saida, string ps_deposito_entrada);//override
string ls_material
string ls_quantidade
string ls_unidade_de_medida
string ls_centro
string ls_centro_de_custo
string ls_Entrada_Saida
string ls_preco_unitario
long ll_for
long ll_count
long ll_cd_filial


dc_uo_ds_base lds_loja_nf_inventario_item
lds_loja_nf_inventario_item = create dc_uo_ds_base

Try
	If Not lds_loja_nf_inventario_item.of_ChangeDataObject('ds_ge481_loja_nf_inventario_item', False) Then
		ps_log = "Erro ao alterar a DW 'ds_ge481_loja_nf_inventario_item'."
		Return False
	End If
	
	ls_Entrada_Saida = 'S'
	
	ll_count = lds_loja_nf_inventario_item.Retrieve( pl_nr_integracao, ls_Entrada_Saida, is_tipo_movimento)
	
	If ll_count < 0 Then
		ps_log = "Erro ao recuperar os dados da DW 'ds_ge481_loja_nf_inventario_item'."
		Return False
	End If
	
	If ll_count = 0 Then
		ps_log = "Nenhum produto foi localizado na DW 'ds_ge481_loja_nf_inventario_item'."
		Return False
	End If
						
	For ll_for = 1 To ll_count	
		ls_material 			= lds_loja_nf_inventario_item.GetItemString(ll_for,"material")
		ls_quantidade 			= String(lds_loja_nf_inventario_item.GetItemNumber(ll_for,"quantidade"))
		ls_preco_unitario		= gf_replace(String(lds_loja_nf_inventario_item.GetItemNumber(ll_for,"vl_preco_unitario")), ',', '.', 0)
		ls_unidade_de_medida = lds_loja_nf_inventario_item.GetItemString(ll_for,"unidade_de_medida")
		ll_cd_filial			= lds_loja_nf_inventario_item.GetItemNumber(ll_for,"cd_filial")
		
		select cd_chave_sap
		  into :ls_centro
		  from integracao_sap
		 where cd_chave_legado = cast(:ll_cd_filial as varchar) and 
				 cd_tabela = 'FILIAL' and 
				 cd_empresa = 1000;

		choose case sqlca.sqlcode
			case -1
				ps_log = 'Erro ao buscar informa$$HEX2$$e700f500$$ENDHEX$$es da tabela integracao_sap. ' + sqlca.sqlerrtext
				return false
			case 100
				ps_log = 'n$$HEX1$$e300$$ENDHEX$$o foi encontrado dados na tabela integracao_sap referente a empresa ' + String(ll_cd_filial)
				return false
		end choose
		
		ls_centro_de_custo	= '1003001'
		
		if ls_material = '' or isnull(ls_material) Then
			ps_log = 'Campo do movimento de estoque {material} n$$HEX1$$e300$$ENDHEX$$o informado.'
			return false
		end if

		if ls_quantidade = '' or isnull(ls_quantidade) Then
			ps_log = 'Campo do movimento de estoque {quantidade} n$$HEX1$$e300$$ENDHEX$$o informado.'
			return false
		end if
		
		if ls_preco_unitario = '' or IsNull(ls_preco_unitario) then
			ps_log = 'Campo do movimento de estoque {preco_unitario} n$$HEX1$$e300$$ENDHEX$$o informado.'
			return false
		end if
		
		if ls_unidade_de_medida = '' or isnull(ls_unidade_de_medida) Then
			ps_log = 'Campo do movimento de estoque {unidade_de_medida} n$$HEX1$$e300$$ENDHEX$$o informado.'
			return false
		end if				
		
		if ls_centro = '' or isnull(ls_centro) Then
			ps_log = 'Campo do movimento de estoque {centro} n$$HEX1$$e300$$ENDHEX$$o informado.'
			return false
		end if						
			
		if IsNull(ls_centro_de_custo) then ls_centro_de_custo = ''
		
		ps_xml += '<ITENS>' 
		
		ps_xml += '<ITEM>'+String(ll_for)+'</ITEM>'+&
						'<MATERIAL>'+ls_material+'</MATERIAL>'+&
						'<QUANTIDADE>'+ls_quantidade+'</QUANTIDADE>'+&
						'<PRECO_UNITARIO>'+ls_preco_unitario+'</PRECO_UNITARIO>'+&
						'<UNIDADE_DE_MEDIDA>'+ls_unidade_de_medida+'</UNIDADE_DE_MEDIDA>'+&
						'<CENTRO>'+ls_centro+'</CENTRO>'+&
						'<DEPOSITO_ENTRADA>'+ps_deposito_entrada+'</DEPOSITO_ENTRADA>'+&
						'<DEPOSITO_SAIDA>'+ps_deposito_saida+'</DEPOSITO_SAIDA>'+&
						'<CONTA_RAZAO></CONTA_RAZAO>'+&
						'<CENTRO_DE_CUSTO>'+ls_centro_de_custo+'</CENTRO_DE_CUSTO>'+&
						'<TEXTO>' + ps_de_comentario_ajuste + '</TEXTO>'+&
						'<MOTIVO>'+ ps_cd_motivo_ajuste +'</MOTIVO>'
						
		of_monta_xml_item_produto_imposto(lds_loja_nf_inventario_item, ll_for, ps_xml)
		
		ps_xml += '</ITENS>'
	Next
	
	
Finally
	Destroy(lds_loja_nf_inventario_item)
End Try
			
return true
end function

public function boolean of_monta_xml_item_produto_imposto (dc_uo_ds_base adc_uo_itens, long al_row, ref string as_xml);Dec		ldc_rate, ldc_rate4dec, ldc_taxval, ldc_base, ldc_othbas, ldc_tax_difference, &
			ldc_srate, ldc_pauta_base, ldc_factor, ldc_factor4dec, ldc_excbas, ldc_basered1, &
			ldc_basered2
Long		ll_for_impostos
String	ls_cd_cst_tributacao, ls_taxgrp, ls_taxtyp, ls_base, ls_othbas, ls_tax_difference, &
			ls_srate, ls_pauta_base, ls_factor, ls_factor4dec, ls_excbas, ls_basered1, &
			ls_basered2, ls_rate, ls_rate4dec, ls_taxval

Try
	For ll_for_impostos = 1 to 4
			Choose Case ll_for_impostos
				case 1
					ls_cd_cst_tributacao	= adc_uo_itens.Object.cd_cst_tributacao[al_row]
					
					ldc_rate			= adc_uo_itens.Object.pc_icms[al_row]
					ldc_rate4dec	= adc_uo_itens.Object.pc_icms[al_row]						
					ldc_taxval		= adc_uo_itens.Object.vl_icms[al_row]
					ldc_base			= adc_uo_itens.Object.vl_bc_icms[al_row]
					ldc_othbas		= 0
					
					ls_taxgrp	= 'ICMS'
					ls_taxtyp	= 'ICM0'					
					
					ldc_tax_difference	= 0
					ldc_srate				= 0
					ldc_pauta_base			= 0
					ldc_factor				= 0
					ldc_factor4dec			= 0
					ldc_excbas				= 0
					ldc_basered1			= 0
					ldc_basered2			= 0
				case 2
					ls_taxgrp	= 'PIS'
					ldc_base		= 0
					ldc_othbas	= 0
					ldc_rate		= 0
					ldc_taxval	= 0
					ls_taxtyp	= 'IPIS'
				case 3
					ls_taxgrp	= 'COFI'
					ldc_base		= 0
					ldc_othbas	= 0
					ldc_rate		= 0
					ldc_taxval	= 0
					ls_taxtyp	= 'ICOF'
				case 4
					ls_taxgrp	= 'IPI'
					ldc_rate			= adc_uo_itens.Object.pc_ipi[al_row]
					ldc_rate4dec	= adc_uo_itens.Object.pc_ipi[al_row]						
					ldc_taxval		= adc_uo_itens.Object.vl_ipi[al_row]
					ldc_base			= adc_uo_itens.Object.vl_bc_ipi[al_row]
					ls_taxtyp	= 'IPI0'
			End Choose
			
			if ldc_rate = 0 and ls_taxtyp <> 'ICM0' and ls_taxtyp <> 'ICM3' then continue
			
			If IsNull(ldc_base) Then
				ls_base = '0.00'
			Else
				ls_base = gf_replace(String(ldc_base, '###,##0.00'), ',', '.', 0)
			End If
			
			If IsNull(ldc_othbas) Then
				ls_othbas = '0.00'
			Else
				ls_othbas = gf_replace(String(ldc_othbas, '###,##0.00'), ',', '.', 0)
			End If

			If IsNull(ldc_rate) Then
				ls_rate = '0.00'
			Else
				ls_rate = gf_replace(String(ldc_rate, '###,##0.00'), ',', '.', 0)
			End If
			
			if IsNull(ldc_rate4dec) then
				ls_rate4dec	= '0.00'
			else
				ls_rate4dec	= gf_replace(String(ldc_rate4dec, '###,##0.0000'), ',', '.', 0)
			end if
			
			If IsNull(ldc_taxval) Then
				ls_taxval = '0.00'
			Else
				ls_taxval = gf_replace(String(ldc_taxval, '###,##0.00'), ',', '.', 0)
			End If
			
			If IsNull(ldc_tax_difference) Then
				ls_tax_difference = '0.00'
			Else
				ls_tax_difference = gf_replace(String(ldc_tax_difference, '###,##0.00'), ',', '.', 0)
			End If
			
			If IsNull(ldc_srate) Then
				ls_srate = '0.00'
			Else
				ls_srate = gf_replace(String(ldc_srate, '###,##0.00'), ',', '.', 0)
			End If
			
			If IsNull(ldc_factor) Then
				ls_factor = '0.00'
			Else
				ls_factor = gf_replace(String(ldc_factor), ',', '.', 0)
			End If
			
			If IsNull(ldc_factor4dec) Then
				ls_factor4dec = '0.00'
			Else
				ls_factor4dec = gf_replace(String(ldc_factor4dec), ',', '.', 0)
			End If
			
			If IsNull(ldc_excbas) Then
				ls_excbas = '0.00'
			Else
				ls_excbas = gf_replace(String(ldc_excbas, '###,##0.00'), ',', '.', 0)
			End If
			
			If IsNull(ldc_basered1) Then
				ls_basered1 = '0.00'
			Else
				ls_basered1 = gf_replace(String(ldc_basered1, '###,##0.00'), ',', '.', 0)
			End If
			
			If IsNull(ldc_basered2) Then
				ls_basered2 = '0.00'
			Else
				ls_basered2 = gf_replace(String(ldc_basered2, '###,##0.00'), ',', '.', 0)
			End If
			
			as_xml += '<IMPOSTOS>'
			as_xml += '<ITMNUM>'+String(al_row)+'</ITMNUM>'
			as_xml += '<TAXTYP>'+ls_taxtyp+'</TAXTYP>'
			as_xml += '<BASE>'+ls_base+'</BASE>'
			as_xml += '<RATE>'+ls_rate+'</RATE>'
			as_xml += '<TAXVAL>'+ls_taxval+'</TAXVAL>'
			as_xml += '<EXCBAS>0</EXCBAS>'
			as_xml += '<OTHBAS>'+ls_othbas+'</OTHBAS>'
			as_xml += '<STATTX></STATTX>'
			as_xml += '<RECTYPE></RECTYPE>'
			as_xml += '<FACTOR>' + ls_factor + '</FACTOR>'
			as_xml += '<UNIT></UNIT>'
			as_xml += '<TAX_LOC></TAX_LOC>'
			as_xml += '<SERVTYPE_IN></SERVTYPE_IN>'
			as_xml += '<SERVTYPE_OUT></SERVTYPE_OUT>'
			as_xml += '<WITHHOLD></WITHHOLD>'
			as_xml += '<TAXINNET></TAXINNET>'
			as_xml += '<WHTCOLLCODE></WHTCOLLCODE>'
			as_xml += '<BASERED1>' + ls_basered1 + '</BASERED1>'
			as_xml += '<BASERED2>' + ls_basered2 + '</BASERED2>'
			as_xml += '<RATE4DEC>' + ls_rate4dec + '</RATE4DEC>'
			as_xml += '<FACTOR4DEC>' + ls_factor4dec + '</FACTOR4DEC>'
			as_xml += '<UNIT4DEC></UNIT4DEC>'		
			as_xml += '<TAX_DIFFERENCE>' + ls_tax_difference + '</TAX_DIFFERENCE>'
			as_xml += '<SRATE>' + ls_srate + '</SRATE>'
			as_xml += '<PAUTA_BASE>' + ls_pauta_base + '</PAUTA_BASE>'
			as_xml += '<TAXGRP>'+ls_taxgrp+'</TAXGRP>'
			as_xml += '<TAXOFF></TAXOFF>'
			as_xml += '<TAXOUTVALUE></TAXOUTVALUE>'
			as_xml += '</IMPOSTOS>'
		next
Finally
	//none
End Try
			
return true
end function

on uo_ge481_loja_nf_inventario.create
call super::create
end on

on uo_ge481_loja_nf_inventario.destroy
call super::destroy
end on

