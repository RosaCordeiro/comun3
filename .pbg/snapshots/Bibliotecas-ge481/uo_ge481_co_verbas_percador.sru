HA$PBExportHeader$uo_ge481_co_verbas_percador.sru
forward
global type uo_ge481_co_verbas_percador from uo_ge481_subida_generica
end type
end forward

global type uo_ge481_co_verbas_percador from uo_ge481_subida_generica autoinstantiate
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
						'<imp:MT_Verbas_Pescador_Request>'


is_Termino_XML	=	'</imp:MT_Verbas_Pescador_Request>'+&
							'</soapenv:Body>'+&
							'</soapenv:Envelope>'
							
ib_usa_cabecalho = False
is_DS = 'ds_ge481_co_verbas_pescador'
is_Objeto = this.classname( )
is_nome_arquivo = 'verba'
is_Parametro_URL = 'CD_URL_VERBA'
is_Tipo_Log_Exp = 'VERBA'
is_Descricao_Tipo_Log = 'VERBA'
is_Nome_Interface = 'VERBA'

//Subir um documento por vez
ii_contador_xml = 1

return True
end function

public function boolean _of_filtra_nr_atualizacao (ref dc_uo_ds_base pds_dados, long pl_nr_atualizacao, ref string ps_log);if pl_nr_atualizacao > 0 Then
	pds_dados.of_appendwhere('l.nr_atualizacao = ' + String(pl_nr_atualizacao))
else
	pds_dados.of_appendwhere("l.id_status_integracao = 'C' " )
end if

//io_sap_comum.is_usuario	= 'PO_INTEGRACAO'
//io_sap_comum.is_senha = 'P0_INTEGRACAO$'

return true
end function

public function boolean _of_monta_xml_item (datastore pds_dados, long pl_linha, ref string ps_xml, ref string ps_log);Long		ll_cd_filial, &
			ll_nr_nf, &
			ll_count, &
			ll_for, &
			ll_nr_nf_aux
String	ls_cd_fornecedor_sap, &
			ls_cd_fornecedor, &
			ls_de_serie, &
			ls_de_especie, &
			ls_id_tipo_nota, &
			ls_centro, &
			ls_de_chave_acesso, &
			ls_id_base_imposto, &
			ls_vl_base, &
			ls_pc_midia, &
			ls_vl_midia, &
			ls_dt_emissao, &
			ls_dt_entrada, &
			ls_cd_produto, &
			ls_nr_nf_compra, &
			ls_de_serie_compra, &
			ls_de_chave_acesso_compra, &
			ls_id_tipo_nota_aux, &
			ls_de_serie_aux, &
			ls_de_especie_aux, &
			ls_cd_fornecedor_aux
Decimal	lde_vl_base

dc_uo_ds_base lds_verbas_pescador_nf_produto


Try
	lds_verbas_pescador_nf_produto = create dc_uo_ds_base
	
	If Not lds_verbas_pescador_nf_produto.of_ChangeDataObject('ds_ge481_co_verbas_pescador_nf_produto', False) Then
		ps_log = "Erro ao alterar a DW 'ds_ge481_co_verbas_pescador_nf_produto'."
		Return False
	End If

	ll_cd_filial			= pds_dados.GetItemNumber(pl_linha,"cd_filial")
	ll_nr_nf					= pds_dados.GetItemNumber(pl_linha,"nr_nf")
	ls_de_serie				= pds_dados.GetItemString(pl_linha,"de_serie")
	ls_de_especie			= pds_dados.GetItemString(pl_linha,"de_especie")
	ls_cd_fornecedor		= pds_dados.GetItemString(pl_linha,"cd_fornecedor")
	ls_id_tipo_nota_aux	= pds_dados.GetItemString(pl_linha,"id_tipo_nf")
	ls_cd_fornecedor_sap	= pds_dados.GetItemString(pl_linha,"cd_fornecedor_sap")
	ls_centro				= pds_dados.GetItemString(pl_linha,"centro")
	ls_id_base_imposto	= pds_dados.GetItemString(pl_linha,"id_utiliza_imposto_base_verba")
	il_Integracao			= Long(pds_dados.GetItemDecimal(pl_linha,"nr_atualizacao"))
	
	Choose Case ls_id_tipo_nota_aux
		Case "VEB"
			ls_id_tipo_nota = 'C'
			
			ll_nr_nf_aux			= ll_nr_nf
			ls_de_serie_aux		= ls_de_serie
			ls_de_especie_aux		= ls_de_especie
			ls_cd_fornecedor_aux	= ls_cd_fornecedor
		Case Else
			select nr_nf_compra,
					 de_serie_compra,
					 de_especie_compra,
					 cd_fornecedor
			  into :ll_nr_nf_aux,
			  		 :ls_de_serie_aux,
					 :ls_de_especie_aux,
					 :ls_cd_fornecedor_aux
			  from nf_devolucao_compra
			 where nr_nf 		= :ll_nr_nf and 
			 		 cd_filial 	= :ll_cd_filial and 
					 de_serie 	= :ls_de_serie and 
					 de_especie	= :ls_de_especie;

			if sqlca.sqlcode = -1 then 
				messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Erro ao consultar nota de compra da devolu$$HEX2$$e700e300$$ENDHEX$$o. : ' + sqlca.sqlerrtext)
				return false
			end if
			
			select cd_fornecedor_sap
			  into :ls_cd_fornecedor_sap
			  from fornecedor
			 where cd_fornecedor	= :ls_cd_fornecedor_aux;

			if sqlca.sqlcode = -1 then 
				messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Erro ao consultar c$$HEX1$$f300$$ENDHEX$$digo do fornecedor do SAP. : ' + sqlca.sqlerrtext)
				return false
			end if

			ls_id_tipo_nota = "D"
	End Choose
	
	If ll_cd_filial = 0 or isnull(ll_cd_filial) Then
		ps_log = 'C$$HEX1$$f300$$ENDHEX$$digo da filial {cd_filial} n$$HEX1$$e300$$ENDHEX$$o informado.'
		Return False
	End If
	
	If ll_nr_nf_aux = 0 or isnull(ll_nr_nf_aux) Then
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
	
	If ls_de_serie_aux = '' or IsNull(ls_de_serie_aux) Then 
		ps_log = 'S$$HEX1$$e900$$ENDHEX$$rie da Nota Fiscal {nr_serie_nf} n$$HEX1$$e300$$ENDHEX$$o informada.'
		Return False
	End If

	If ls_id_base_imposto = '' or IsNull(ls_id_base_imposto) Then 
		ps_log = 'Identificador de Base Imposto da Nota Fiscal {id_base_imposto} n$$HEX1$$e300$$ENDHEX$$o informado.'
		Return False
	End If
	
	ll_count = lds_verbas_pescador_nf_produto.Retrieve( ll_cd_filial, ls_cd_fornecedor_aux, ll_nr_nf_aux, ls_de_serie_aux, ls_de_especie_aux)
	
	If ll_count < 0 Then
		ps_log = "Erro ao recuperar os dados da DW 'ds_ge481_co_verbas_pescador_nf_produto'."
		Return False
	End If
	
	If ll_count = 0 Then
		ps_log = "N$$HEX1$$e300$$ENDHEX$$o foram encontrados os dados referente a verbas de marketing."
		Return False
	End If
	
	For ll_for = 1 To ll_count
		ls_dt_emissao 					= String(lds_verbas_pescador_nf_produto.GetItemDateTime(ll_for,"dh_emissao"),"YYYYMMDD")
		ls_dt_entrada 					= String(lds_verbas_pescador_nf_produto.GetItemDateTime(ll_for,"dh_movimentacao_caixa"),"YYYYMMDD")
		ls_cd_produto 					= lds_verbas_pescador_nf_produto.GetItemString(ll_for,"cd_produto_sap")
		ls_de_chave_acesso 			= lds_verbas_pescador_nf_produto.GetItemString(ll_for,"de_chave_acesso")
		
		if ls_id_tipo_nota = 'D' then
			ls_nr_nf_compra 				= String(ll_nr_nf_aux)
			ls_de_serie_compra 			= ls_de_serie_aux
			
			select de_chave_acesso
			  into :ls_de_chave_acesso_compra
			  from nf_compra
			 where nr_nf			= :ll_nr_nf_aux and
			 		 de_serie		= :ls_de_serie_aux and
					 de_especie		= :ls_de_especie_aux and
					 cd_filial		= :ll_cd_filial and
					 cd_fornecedor	= :ls_cd_fornecedor_aux;

			choose case sqlca.sqlcode
				case -1
					messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Erro ao consultar chave de acesso da nota de compra de origem da devolu$$HEX2$$e700e300$$ENDHEX$$o. : ' + sqlca.sqlerrtext)
					return false
				case 100
					messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','N$$HEX1$$e300$$ENDHEX$$o foi encontrada a nota de compra referente a devolu$$HEX2$$e700e300$$ENDHEX$$o.')
					return false
				case else
					if IsNull(ls_de_chave_acesso_compra) then
						ls_de_chave_acesso_compra = ''
					end if
			end choose
		else
			ls_nr_nf_compra 				= ''
			ls_de_serie_compra 			= ''
			ls_de_chave_acesso_compra 	= ''
		end if
		
		If ls_de_chave_acesso = '' or IsNull(ls_de_chave_acesso) Then 
			ps_log = 'Chave de acesso da Nota Fiscal {de_chave_acesso} n$$HEX1$$e300$$ENDHEX$$o informada.'
			Return False
		End If
		
		If IsNull(ls_dt_emissao) or ls_dt_emissao = "" Then
			ps_log = 'Data de emissao da Nota Fiscal {dt_emissao} n$$HEX1$$e300$$ENDHEX$$o informada.'
			Return False
		End If
		
		If IsNull(ls_dt_entrada) or ls_dt_entrada = "" Then
			ps_log = 'Data de entrada da Nota Fiscal {dt_entrada} n$$HEX1$$e300$$ENDHEX$$o informada.'
			Return False
		End If
		
		If IsNull(ls_cd_produto) or ls_cd_produto = "" Then
			ps_log = 'C$$HEX1$$f300$$ENDHEX$$digo do produto no SAP {cd_produto} n$$HEX1$$e300$$ENDHEX$$o informado.'
			Return False
		End If
				
		lde_vl_base =	lds_verbas_pescador_nf_produto.GetItemDecimal(ll_for,"vl_preco_unitario") + &
							lds_verbas_pescador_nf_produto.GetItemDecimal(ll_for,"vl_icms_repassado") - &
							lds_verbas_pescador_nf_produto.GetItemDecimal(ll_for,"vl_desconto") 
		
		If ls_id_base_imposto = "S" Then
			lde_vl_base =	lde_vl_base + &
								lds_verbas_pescador_nf_produto.GetItemDecimal(ll_for,"vl_icms_st") + &
								lds_verbas_pescador_nf_produto.GetItemDecimal(ll_for,"vl_ipi")
		End If
		
		lde_vl_base = Round(lde_vl_base * lds_verbas_pescador_nf_produto.GetItemNumber(ll_for,"qt_faturada"), 2)
		
		ls_vl_base = String(lde_vl_base)
		ls_vl_base = gf_replace(ls_vl_base,',','.',0)

		If IsNull(ls_vl_base) or ls_vl_base = "" Then
			ps_log = 'Valor base para calculo da midia {vl_base} n$$HEX1$$e300$$ENDHEX$$o informado.'
			Return False
		End If		
		
		ls_pc_midia = String(lds_verbas_pescador_nf_produto.GetItemDecimal(ll_for,"pc_desconto_midia"))
		ls_pc_midia = gf_replace(ls_pc_midia,',','.',0)

		If IsNull(ls_pc_midia) or ls_pc_midia = "" Then
			ps_log = 'Percentual de midia {pc_midia} n$$HEX1$$e300$$ENDHEX$$o informado.'
			Return False
		End If
		
		ls_vl_midia = String(Round((lds_verbas_pescador_nf_produto.GetItemDecimal(ll_for,"pc_desconto_midia") * &
									lde_vl_base) / &
									100,2))
		ls_vl_midia = gf_replace(ls_vl_midia,',','.',0)
		
		If IsNull(ls_vl_midia) or ls_vl_midia = "" Then
			ps_log = 'Valor de midia {vl_midia} n$$HEX1$$e300$$ENDHEX$$o informado.'
			Return False
		End If
		
		If IsNull(ls_nr_nf_compra) Then ls_nr_nf_compra = ""
		If IsNull(ls_de_serie_compra) Then ls_de_serie_compra = ""
		If IsNull(ls_de_chave_acesso_compra) Then ls_de_chave_acesso_compra = ''
			
		ps_xml += "<DADOS>"
		ps_xml += "<cd_fornecedor>"+ls_cd_fornecedor_sap+"</cd_fornecedor>"
		ps_xml += "<cd_produto>"+ls_cd_produto+"</cd_produto>"
		ps_xml += "<cd_centro>"+ls_centro+"</cd_centro>"
		ps_xml += "<nr_nf>"+String(ll_nr_nf)+"</nr_nf>"
		ps_xml += "<nr_serie_nf>"+ls_de_serie+"</nr_serie_nf>"
		ps_xml += "<cd_chave_acesso>"+ls_de_chave_acesso+"</cd_chave_acesso>"
		ps_xml += "<dt_emissao>"+ls_dt_emissao+"</dt_emissao>"
		ps_xml += "<dt_entrada>"+ls_dt_entrada+"</dt_entrada>"
		ps_xml += "<id_tipo_nota>"+ls_id_tipo_nota+"</id_tipo_nota>"
		ps_xml += "<tp_verba>Z053</tp_verba>"
		ps_xml += "<id_base_imposto>"+ls_id_base_imposto+"</id_base_imposto>"
		ps_xml += "<vl_base>"+ls_vl_base+"</vl_base>"
		ps_xml += "<perc_midia>"+ls_pc_midia+"</perc_midia>"
		ps_xml += "<vl_midia>"+ls_vl_midia+"</vl_midia>"
		ps_xml += "<nr_nf_compra>"+ls_nr_nf_compra+"</nr_nf_compra>"
		ps_xml += "<nr_serie_nf_compra>"+ls_de_serie_compra+"</nr_serie_nf_compra>"
		ps_xml += "<cd_chave_acesso_compra>"+ls_de_chave_acesso_compra+"</cd_chave_acesso_compra>"
		ps_xml += "<nr_contrato_verba></nr_contrato_verba>"
		ps_xml += "</DADOS>"
	Next
Finally
	Destroy(lds_verbas_pescador_nf_produto)
End Try	

if IsNull(ps_xml) then
	ps_log = 'As informa$$HEX2$$e700f500$$ENDHEX$$es do xml da verba est$$HEX1$$e300$$ENDHEX$$o nulas.'
	Return False
end if

Return True
end function

public function boolean _of_processa_retorno_xml (string as_xml, ref string as_log);long ll_contador = 1
string ls_status

ll_contador = 1
ls_status = Trim(of_busca_valor(as_xml, '<status>', ref ll_contador))

If Lower(ls_status) <> "integrado com sucesso" Then
	this.of_atualiza_processado( il_Integracao, 'E', "Envio de verba do pescador n$$HEX1$$e300$$ENDHEX$$o realizado" + "{ Log: " +ls_status + ' }', ref as_log)
End If

Return True
end function

on uo_ge481_co_verbas_percador.create
call super::create
end on

on uo_ge481_co_verbas_percador.destroy
call super::destroy
end on

