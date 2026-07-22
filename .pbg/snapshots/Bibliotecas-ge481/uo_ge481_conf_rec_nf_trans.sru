HA$PBExportHeader$uo_ge481_conf_rec_nf_trans.sru
forward
global type uo_ge481_conf_rec_nf_trans from uo_ge481_subida_generica
end type
end forward

global type uo_ge481_conf_rec_nf_trans from uo_ge481_subida_generica autoinstantiate
end type

type variables
Long	il_nr_atualizacao	= 0

String ivs_nova_regra_vencido_danificado,&
			ivs_Endereco_Segregado_Falta,&
			ivs_Endereco_Conferencia_Segregado,&
			ivs_Endereco_Segregado_Venc_Danif,&
			ivs_Id_Receb_Envia_End_Controlado,&
			ivs_Endereco_Segregado_RetExcessocontrolado,&
			ivs_Endereco_Segregado_Transf,&
			ivs_Endereco_Segregado_RetExcesso,&
			ivs_Valida_qtd_recebimento,&
			is_id_tipo_nf
			
st_ge481_parametros_produto ist_Parametros

dc_uo_ds_Base ids_produtos_controlados_excesso,&
					ids_Itens_Fator_Conversao
					
uo_ge258_movimentacao ids_Movimentacao
end variables

forward prototypes
public function boolean _of_parametros ()
public function boolean _of_filtra_nr_atualizacao (ref dc_uo_ds_base pds_dados, long pl_nr_atualizacao, ref string ps_log)
public function boolean _of_processa_retorno_xml (string as_xml, ref string as_log)
public function boolean _of_monta_xml_item (datastore pds_dados, long pl_linha, ref string ps_xml, ref string ps_log)
public function boolean of_grava_protocolo (long al_produto, string as_protocolo, string as_lote, long al_qtde, long al_motivo, ref string as_erro)
public function boolean of_grava_protocolo (integer al_filial, double al_nota, string as_especie, string as_serie, ref string as_erro)
public function boolean of_grava_lotes (long al_filial, long al_nota, string as_especie, string as_serie, ref string as_erro)
public function boolean of_carrega_parametro (ref string as_erro)
public function boolean of_localiza_parametro_regra_vencido (ref string as_erro)
public function boolean of_verifica_divergencia_lotes (long al_filial, long al_nota, string as_especie, string as_serie, ref string as_erro)
public function boolean of_verifica_protocolo (long al_cd_produto, string as_nr_lote, string as_nr_protocolo, long al_cd_motivo, ref long al_qt_lote, ref string as_erro)
public function boolean of_verifica_saldo_filial_1 (long al_filial, long al_nota, long al_produto, long al_qt_transferida, datetime adh_emissao_nota, ref string as_erro)
public function boolean of_grava_movimento_wms_falta (long al_filial, long al_nota, string as_especie, string as_serie, long al_produto, long al_qtde, long al_fator_conversao, string as_responsavel, decimal adc_bc_icms_st, decimal adc_icms_st, ref st_ge481_nf_transferencia_faltas ast_nf_transferencia_faltas[], ref string as_erro)
private function boolean of_troca_filial (long pl_cd_filial_origem, long pl_nr_nf, string ps_de_especie, string ps_de_serie, string ps_usuario, ref string as_erro)
public function boolean of_cadastra_produto_sem_flow (long al_filial, long al_nota, string as_especie, string as_serie, string as_matricula, string as_retirada_excesso, ref string as_log)
public function boolean of_verifica_nota_movimentacao (long al_filial, long al_nota, string as_especie, string as_serie, ref string as_log, ref string as_tipo_transf, ref string as_retirada_excesso, ref datetime adh_movimentacao_caixa, ref string as_matricula, ref string as_segrega_nota)
public function boolean of_grava_movimento_wms (long al_filial, long al_nota, string as_especie, string as_serie, string as_responsavel, datetime adh_emissao_nota, string as_retirada_excesso, string as_segrega_nota, ref st_ge481_nf_transferencia_faltas ast_nf_transferencia_faltas[], ref string as_erro)
public function boolean of_verificar_nota_exportacao_sap (ref long al_filial, ref long al_nota, ref string as_especie, ref string as_serie, ref string as_erro)
public function boolean of_grava_movimento_wms_transferencia (long al_filial, long al_nota, string as_especie, string as_serie, long al_natoperacao, long al_produto, long al_fator_conversao, string as_responsavel, string as_vencido, string as_tipo_transferencia, string as_retirada_excesso, decimal adc_bc_icms_st, decimal adc_icms_st, string as_segrega_nota, ref string as_erro)
public function boolean of_atualiza_movimento_transferencia (long al_filial, long al_nota, string as_especie, string as_serie, long al_produto, long al_qt_movimentado, ref string as_erro)
end prototypes

public function boolean _of_parametros ();//override
is_Inicio_XML	=	'<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:imp="importa_sap.com">' + &
						'   <soapenv:Header/>' + &
						'   <soapenv:Body>' + &
						'      <imp:MT_NF_TRANSF_LOCAL_DEST>'

is_Termino_XML	=	'		</imp:MT_NF_TRANSF_LOCAL_DEST>' + &
						'   </soapenv:Body>' + &
						'</soapenv:Envelope>'
							
ib_usa_cabecalho = False
is_DS = 'ds_ge481_conf_rec_nf_trans'
is_Objeto = this.classname( )
is_nome_arquivo = 'conf_rec_nf_trans'
is_Parametro_URL = 'CD_URL_CONFIRMA_REC_NF_TRANS'
is_Tipo_Log_Exp = 'CONF_REC_NF_TRANS'
is_Descricao_Tipo_Log = 'CONF_REC_NF_TRANS'
is_Nome_Interface = 'CONF_REC_NF_TRANS'
ib_validar_situacao	= False

//Subir um documento por vez
ii_contador_xml = 1

return True
end function

public function boolean _of_filtra_nr_atualizacao (ref dc_uo_ds_base pds_dados, long pl_nr_atualizacao, ref string ps_log);if pl_nr_atualizacao > 0 Then
	pds_dados.of_appendwhere('nr_atualizacao = ' + String(pl_nr_atualizacao), 2)
	pds_dados.of_appendwhere('nr_atualizacao = ' + String(pl_nr_atualizacao), 3)
end if

return true
end function

public function boolean _of_processa_retorno_xml (string as_xml, ref string as_log);long ll_contador = 1,&
		ll_nr_nf,&
		ll_filial
		
string ls_msg,&
			ls_de_especie,&
			ls_de_serie,&
			ls_erro,&
			ls_tipo_transf,&
			ls_retirada_excesso,&
			ls_matricula,&
			ls_segrega_nota

DateTime ldh_Emissao_Nota

Boolean lb_Sucesso

st_ge481_nf_transferencia_faltas	lst_nf_transferencia_faltas[]

ls_msg = of_busca_valor(as_xml, '<status>', ref ll_contador)

If upper(ls_msg) <> upper('Processado com sucesso!') And  NOT (Upper(Left(ls_msg, Len("A chave j$$HEX1$$e100$$ENDHEX$$ foi confirmada com a MIGO"))) = "A CHAVE J$$HEX1$$c100$$ENDHEX$$ FOI CONFIRMADA COM A MIGO")  Then
	this.of_atualiza_processado( il_nr_atualizacao, 'E', ls_msg, ref as_log)
Else
		
	If is_id_tipo_nf = 'CRN' Then
		
		lb_Sucesso = False
		
		ids_Movimentacao 	= Create uo_ge258_movimentacao
		
		ids_Movimentacao.ib_mostra_erro_tela = False
		
		If Not of_Carrega_Parametro(Ref as_log) Then	Return False
	
		If Not of_localiza_parametro_regra_vencido(Ref as_log) Then Return False
		
		If Not of_verificar_nota_exportacao_sap(Ref ll_filial, Ref ll_nr_nf, Ref ls_de_especie, Ref ls_de_serie, Ref as_log) Then Return False
			
		If of_Verifica_Nota_Movimentacao(ll_filial, ll_nr_nf, ls_de_especie, ls_de_serie, Ref ls_erro, Ref ls_tipo_transf, Ref ls_retirada_excesso, Ref ldh_Emissao_Nota, Ref ls_matricula, Ref ls_segrega_nota) Then
			If of_Cadastra_Produto_Sem_Flow(ll_filial, ll_nr_nf, ls_de_especie, ls_de_serie, ls_matricula, ls_retirada_excesso, Ref ls_erro) Then
				If of_Grava_Lotes(ll_filial, ll_nr_nf, ls_de_especie, ls_de_serie, Ref ls_erro) Then
					If of_Verifica_Divergencia_Lotes(ll_filial, ll_nr_nf, ls_de_especie, ls_de_serie, Ref ls_erro) Then
						If of_Grava_Movimento_WMS(ll_filial, ll_nr_nf, ls_de_especie, ls_de_serie,  ls_matricula, ldh_Emissao_Nota, ls_Retirada_Excesso, ls_Segrega_Nota, Ref lst_nf_transferencia_faltas, Ref ls_erro) Then
							If of_Troca_Filial(ll_filial, ll_nr_nf, ls_de_especie, ls_de_serie, ls_matricula, Ref ls_erro) Then
								lb_Sucesso = True		
							End If//of_Troca_Filial
						End If//of_Grava_Movimento_WMS
					End If//of_Verifica_Divergencia_Lotes
				End If//of_Grava_Lotes
			End If//of_Cadastra_Produto_Sem_Flow
		End If//of_Verifica_Nota_Movimentacao
	End If
	
	Destroy ids_Movimentacao
End If

If Not lb_Sucesso Then
	SqlCa.of_Rollback()
	ls_msg = ls_msg + ' - ' + ls_erro
	this.of_atualiza_processado( il_nr_atualizacao, 'E', ls_msg, ref as_log)
End If

Return True
end function

public function boolean _of_monta_xml_item (datastore pds_dados, long pl_linha, ref string ps_xml, ref string ps_log);datetime	ldt_dh_documento
datetime ldt_dh_cancelamento
string 	ls_de_chave_acesso
string 	ls_cd_deposito
string 	ls_cd_filial_sap
string	ls_action
string	ls_data
string	ls_nr_protocolo_cancelamento
long		ll_cd_filial_destino


ls_de_chave_acesso 				= pds_dados.GetItemString(pl_linha,"de_chave_acesso")
ls_cd_deposito 					= pds_dados.GetItemString(pl_linha,"cd_deposito_sap")
is_id_tipo_nf						= pds_dados.GetItemString(pl_linha,"id_tipo_nf")
ls_nr_protocolo_cancelamento	= pds_dados.GetItemString(pl_linha,"nr_protocolo_cancelamento")
ll_cd_filial_destino 			= pds_dados.GetItemNumber(pl_linha,"cd_filial_destino")
ldt_dh_documento					= pds_dados.GetItemDateTime(pl_linha,"dh_documento")
ldt_dh_cancelamento				= pds_dados.GetItemDateTime(pl_linha,"dh_cancelamento")
il_nr_atualizacao					= pds_dados.GetItemNumber(pl_linha,"nr_atualizacao")

if ls_de_chave_acesso = '' or isnull(ls_de_chave_acesso) Then
	ps_log = '[Confer$$HEX1$$ea00$$ENDHEX$$ncia de recebimento de nf transfer$$HEX1$$ea00$$ENDHEX$$ncia] Chave de acesso n$$HEX1$$e300$$ENDHEX$$o informada.'
	return false
end if

if is_id_tipo_nf = 'CRN' then
	if ll_cd_filial_destino = 1 then
		
		ls_cd_filial_sap = '1156'
	else
		select cd_chave_sap
		  into :ls_cd_filial_sap
		  from integracao_sap sa
		 where sa.cd_chave_legado = cast(:ll_cd_filial_destino as varchar) 
			and sa.cd_tabela = 'FILIAL' 
			and sa.cd_empresa = 1000;
		
		choose case sqlca.sqlcode
			case -1
				ps_log = '[Confer$$HEX1$$ea00$$ENDHEX$$ncia de recebimento de nf transfer$$HEX1$$ea00$$ENDHEX$$ncia] Erro ao buscar chave do SAP da filial de destino. Erro: ' + SQLCA.SQLErrText
				return false
			case 100
				ps_log = '[Confer$$HEX1$$ea00$$ENDHEX$$ncia de recebimento de nf transfer$$HEX1$$ea00$$ENDHEX$$ncia] Chave de filial do SAP n$$HEX1$$e300$$ENDHEX$$o encontrada para a filial: ' + String(ll_cd_filial_destino) + '.'
				return false
		end choose
	end if
else
	ls_cd_filial_sap	= ''
end if

choose case is_id_tipo_nf
	case 'CRN'
		ls_action = '01'
		ls_data	= String(ldt_dh_documento, 'YYYYMMDD HH:MM:SS')
	case 'CTL'
		if ls_cd_deposito = 'LEGADO' then
			ls_action = '05'
		else
			ls_action = '02'
		end if
		
		ls_data	= String(ldt_dh_cancelamento, 'YYYYMMDD HH:MM:SS')
	case 'CDL'
		ls_action = '03'
		ls_data	= String(ldt_dh_cancelamento, 'YYYYMMDD HH:MM:SS')
end choose

if IsNull(ls_cd_deposito) then ls_cd_deposito = ''
if IsNull(ls_nr_protocolo_cancelamento) then ls_nr_protocolo_cancelamento = ''

ps_xml += '<ACTION>' + ls_action + '</ACTION>'
ps_xml += '<ACCKEY>' + ls_de_chave_acesso + '</ACCKEY>'
ps_xml += '<WERKS>' + ls_cd_filial_sap + '</WERKS>'
ps_xml += '<LGORT>' + ls_cd_deposito + '</LGORT>'
ps_xml += '<DATA>' + ls_data + '</DATA>'
ps_xml += '<PROT_CANCEL>' + ls_nr_protocolo_cancelamento + '</PROT_CANCEL>'

if IsNull(ps_xml) Then
	ps_log = 'As informa$$HEX2$$e700f500$$ENDHEX$$es do xml da confirma$$HEX2$$e700e300$$ENDHEX$$o/cancelamento de transfer$$HEX1$$ea00$$ENDHEX$$ncia/devolu$$HEX2$$e700e300$$ENDHEX$$o est$$HEX1$$e300$$ENDHEX$$o nulas.'
	Return False
end if

return true
end function

public function boolean of_grava_protocolo (long al_produto, string as_protocolo, string as_lote, long al_qtde, long al_motivo, ref string as_erro);long ll_qt_lote

/* Teste se j$$HEX1$$e100$$ENDHEX$$ existe linha para Produto + Lote + Protocolo + Motivo */
If Not of_verifica_protocolo(al_produto, as_lote, as_protocolo, al_motivo, ll_qt_lote, Ref as_erro) Then Return false

If ll_qt_lote > 0 then
	UPDATE wms_protocolo
 	   SET qt_lote = qt_lote + :al_qtde
 	 WHERE cd_produto = :al_produto
	   AND nr_lote = :as_lote
		AND nr_protocolo = :as_protocolo
		AND cd_motivo_defeito = :al_motivo 
    USING sqlca;

	If SqlCa.SqlCode = -1 Then
		as_erro	= SQLCA.SQlErrText
		SQLCA.of_rollback()
		as_erro = "Erro ao atualizar a tabela wms_protocolo" + as_erro
		Return False
	End If
Else
	INSERT INTO wms_protocolo  
	          ( cd_produto
	     		 , nr_lote
			    , nr_protocolo
			    , qt_lote
			    , qt_utilizado
			    , id_mudou_endereco
			    , cd_motivo_defeito 
   			 )  
      VALUES ( :al_produto 
	          , :as_lote
			    , :as_protocolo
			    , :al_qtde
			    , 0
			    , 'N'
			    , :al_motivo )  
	      USING sqlca;

	If SqlCa.SqlCode = -1 Then
		as_erro	= SQLCA.SQlErrText
		SQLCA.of_rollback()
		as_erro = "Erro ao inserir registro na tabela wms_protocolo" + as_erro
		Return False
	End If
End IF

Return True
end function

public function boolean of_grava_protocolo (integer al_filial, double al_nota, string as_especie, string as_serie, ref string as_erro);Long ll_Linha, ll_linhas, ll_motivo, ll_produto, ll_qtde
String ls_protocolo, ls_lote

dc_uo_ds_Base ds_itens_selecionados

ds_itens_selecionados = Create dc_uo_ds_base

If Not ds_itens_selecionados.of_ChangeDataObject('ds_ge481_lista_item_nf_transf_lote_conf') Then
	SQLCA.of_rollback()
	as_erro = "Erro no changedata da 'ds_ge481_lista_item_nf_transf_lote_conf'."
	return False
End If

ds_itens_selecionados.retrieve(al_filial, al_nota, as_especie, as_serie)
ll_linhas = ds_itens_selecionados.rowcount()

For ll_Linha = 1 To ll_linhas
	
	ll_produto 		= ds_itens_selecionados.object.cd_produto[ll_Linha]
	ls_lote 			= ds_itens_selecionados.object.nr_lote[ll_Linha]
	ll_qtde 			= ds_itens_selecionados.object.qt_lote[ll_Linha]
	ls_protocolo 	= ds_itens_selecionados.object.nr_protocolo_defeito[ll_Linha]
	ll_motivo 		= ds_itens_selecionados.object.cd_motivo_defeito[ll_Linha]
	
	ist_Parametros.id_exige_protocolo = ds_itens_selecionados.object.id_protocolo[ll_Linha]
	
	//Possui endere$$HEX1$$e700$$ENDHEX$$o configurado
	If ist_Parametros.id_exige_protocolo = 'S' Then
		//Motivo e Protocolos Informados de maneira correta
		if (ll_Motivo > 0 And Not isnull(ls_protocolo) And ls_protocolo <> '') Then
			//Grava$$HEX2$$e700e300$$ENDHEX$$o do Protocolo
			If Not of_grava_protocolo(ll_Produto, ls_Protocolo, ls_Lote, ll_Qtde, ll_Motivo, Ref as_erro) Then 	
				SQLCA.of_rollback()
				Return false
			End if
		End if
	Else
		Continue
	End if
Next

Destroy (ds_itens_selecionados)

Return true
end function

public function boolean of_grava_lotes (long al_filial, long al_nota, string as_especie, string as_serie, ref string as_erro);String	ls_sqlerrtext


DELETE  FROM item_nf_transferencia_lote_prt
WHERE cd_filial_origem 	= :al_Filial	
AND nr_nf 					= :al_Nota
AND de_especie 			= :as_Especie
AND de_serie 				= :as_Serie
USING SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_sqlerrtext	= SqlCa.SqlErrtext
	SQLCA.of_rollback()
	as_Erro = "Erro no delete da tabela item_nf_transferencia_lote_prt : "+ls_sqlerrtext
	Return False
End If

DELETE 
  FROM item_nf_transferencia_lote
 WHERE cd_filial_origem 	= :al_Filial	
   AND nr_nf 					= :al_Nota
   AND de_especie 			= :as_Especie
   AND de_serie 				= :as_Serie
 USING SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_sqlerrtext	= SqlCa.SqlErrtext
	SQLCA.of_rollback()
	as_Erro = "Erro no delete da tabela item_nf_transferencia_lote : "+ls_sqlerrtext
	Return False
End If

INSERT INTO item_nf_transferencia_lote
            (	cd_filial_origem
	    ,	nr_nf
	    ,	de_especie
	    ,	de_serie
	    ,	cd_natureza_operacao
	    ,	cd_produto
	    ,	nr_lote
	    ,	qt_lote
	    ,	dh_validade
	    ,	cd_tipo_transferencia)
SELECT cd_filial_origem
		,	nr_nf
	    ,	de_especie
	    , 	de_serie
	    ,	cd_natureza_operacao
	    ,	cd_produto
	    ,	nr_lote
	    ,	qt_lote
	    ,	dh_validade
	    ,	cd_tipo_transferencia			 
FROM item_nf_transf_lote_conf
WHERE cd_filial_origem 	= :al_Filial	
AND nr_nf = :al_Nota
AND de_especie= :as_Especie
AND de_serie = :as_Serie
USING SqlCa;
			
If SqlCa.SqlCode = -1 Then
	ls_sqlerrtext	= SqlCa.SqlErrtext
	SQLCA.of_rollback()
	as_Erro = "Erro no insert da tabela item_nf_transferencia_lote." + ls_sqlerrtext
	Return False
End If

INSERT INTO item_nf_transferencia_lote_prt
			 (cd_filial_origem
			,	nr_nf
			,	de_especie
			,	de_serie
			,	cd_natureza_operacao
			,	cd_produto
			,	nr_lote
			,	qt_lote
			,	nr_protocolo_defeito
			,	cd_motivo_defeito)
SELECT cd_filial_origem
			,	nr_nf
			 ,	de_especie
			, 	de_serie
			,	cd_natureza_operacao
			, 	cd_produto
			,	nr_lote
			, 	qt_lote
			,	nr_protocolo_defeito
			,	cd_motivo_defeito
FROM item_nf_transf_lote_conf_prt
WHERE cd_filial_origem 	= :al_Filial	
AND nr_nf 					= :al_Nota
AND de_especie				= :as_Especie
AND de_serie 				= :as_Serie
USING SqlCa;
	
If SqlCa.SqlCode = -1 Then
	ls_sqlerrtext	= SqlCa.SqlErrtext
	SQLCA.of_rollback()
	as_Erro = "Erro no insert da tabela item_nf_transferencia_lote_prt : " + ls_sqlerrtext
	Return False
End If

// Testa todas as condi$$HEX2$$e700f500$$ENDHEX$$es para Grava$$HEX2$$e700e300$$ENDHEX$$o do Protocolo
//Parametros Gerais
If not of_grava_protocolo(al_Filial, al_Nota, as_Especie, as_Serie, Ref as_erro) then
	SQLCA.of_rollback()
	Return False
End if	

Return True
end function

public function boolean of_carrega_parametro (ref string as_erro);String ls_Achou

Select vl_parametro
Into :ivs_Endereco_Segregado_Falta
From wms_parametro
Where cd_parametro = 'CD_ENDERECO_SEGREGADO_FALTA'
Using Sqlca;

Choose Case Sqlca.SqlCode
	Case 0
		
		Select cd_endereco
		Into :ls_Achou
		From wms_endereco
		Where cd_endereco = :ivs_Endereco_Segregado_Falta
		Using SqlCa;
		
		Choose Case Sqlca.SqlCode
			Case 100
				as_erro = "O endere$$HEX1$$e700$$ENDHEX$$o de falta do segregado n$$HEX1$$e300$$ENDHEX$$o foi localizado '" + ivs_Endereco_Segregado_Falta + "'."
				Return False
			Case -1
				as_erro = "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do endere$$HEX1$$e700$$ENDHEX$$o de falta do segregado '" + ivs_Endereco_Segregado_Falta + "'."
				Return False
		End Choose
	Case 100
		as_erro = "O par$$HEX1$$e200$$ENDHEX$$metro n$$HEX1$$e300$$ENDHEX$$o foi localizado 'CD_ENDERECO_SEGREGADO_FALTA'."
		Return False
	Case -1
		as_erro = "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do parametro WMS 'CD_ENDERECO_SEGREGADO_FALTA'."
		Return False
End Choose

Select vl_parametro
Into :ivs_Endereco_Segregado_Transf
From wms_parametro
Where cd_parametro = 'CD_ENDERECO_SEGREGADO_TRANSFERENCIA'
Using Sqlca;

Choose Case Sqlca.SqlCode
	Case 0
		
		Select cd_endereco
		Into :ls_Achou
		From wms_endereco
		Where cd_endereco = :ivs_Endereco_Segregado_Transf
		Using SqlCa;
		
		Choose Case Sqlca.SqlCode
			Case 100
				as_erro = "O endere$$HEX1$$e700$$ENDHEX$$o de transfer$$HEX1$$ea00$$ENDHEX$$ncia do segregado n$$HEX1$$e300$$ENDHEX$$o foi localizado '" + ivs_Endereco_Segregado_Transf + "'."
				Return False
			Case -1
				as_erro = "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do endere$$HEX1$$e700$$ENDHEX$$o de transfer$$HEX1$$ea00$$ENDHEX$$ncia do segregado '" + ivs_Endereco_Segregado_Transf + "'."
				Return False
		End Choose
		
	Case 100
		as_erro = "O par$$HEX1$$e200$$ENDHEX$$metro n$$HEX1$$e300$$ENDHEX$$o foi localizado 'CD_ENDERECO_SEGREGADO_TRANSFERENCIA'."
		Return False
	Case -1
		as_erro = "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do parametro WMS 'CD_ENDERECO_SEGREGADO_TRANSFERENCIA'."
		Return False
End Choose

// VENCIDO OU DANFICADO
Select vl_parametro
Into :ivs_Endereco_Segregado_Venc_Danif
From wms_parametro
Where cd_parametro = 'CD_ENDERECO_SEGREGADO_VENCIDO_DANIFICADO'
Using Sqlca;

Choose Case Sqlca.SqlCode
	Case 0
		
		Select cd_endereco
		Into :ls_Achou
		From wms_endereco
		Where cd_endereco = :ivs_Endereco_Segregado_Venc_Danif
		Using SqlCa;
		
		Choose Case Sqlca.SqlCode
			Case 100
				as_erro = "O endere$$HEX1$$e700$$ENDHEX$$o de falta do segregado n$$HEX1$$e300$$ENDHEX$$o foi localizado '" + ivs_Endereco_Segregado_Venc_Danif + "'."
				Return False
			Case -1
				as_erro = "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do endere$$HEX1$$e700$$ENDHEX$$o de falta do segregado '" + ivs_Endereco_Segregado_Venc_Danif + "'."
				Return False
		End Choose
		
	Case 100
		as_erro = "O par$$HEX1$$e200$$ENDHEX$$metro n$$HEX1$$e300$$ENDHEX$$o foi localizado 'CD_ENDERECO_SEGREGADO_VENCIDO_DANIFICADO'."
		Return False
	Case -1
		as_erro = "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do parametro WMS 'CD_ENDERECO_SEGREGADO_VENCIDO_DANIFICADO'."
		Return False
End Choose

// VENCIDO OU DANIFICADO

// SEGREGADO RETIRADA DE EXCESSO
Select vl_parametro
Into :ivs_Endereco_Segregado_RetExcesso
From wms_parametro
Where cd_parametro ='CD_ENDERECO_SEGREGADO_RETEXCESSO'
Using Sqlca;

Choose Case Sqlca.SqlCode
	Case 0
		Select cd_endereco
		Into :ls_Achou
		From wms_endereco
		Where cd_endereco = :ivs_Endereco_Segregado_RetExcesso
		Using SqlCa;
		
		Choose Case Sqlca.SqlCode
			Case 100
				as_erro = "O endere$$HEX1$$e700$$ENDHEX$$o de ret.execesso do segregado n$$HEX1$$e300$$ENDHEX$$o foi localizado '" + ivs_Endereco_Segregado_RetExcesso + "'."
				Return False
			Case -1
				as_erro = "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do endere$$HEX1$$e700$$ENDHEX$$o ret.execesso do segregado '" + ivs_Endereco_Segregado_RetExcesso + "'."
				Return False
		End Choose
		
	Case 100
		as_erro = "O par$$HEX1$$e200$$ENDHEX$$metro n$$HEX1$$e300$$ENDHEX$$o foi localizado 'CD_ENDERECO_SEGREGADO_RETEXCESSO'."
		Return False
	Case -1
		as_erro = "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do parametro WMS 'CD_ENDERECO_SEGREGADO_RETEXCESSO'."
		Return False
End Choose
// SEGREGADO RETIRADA EXCESSO

// QTD RECEBIMENTO :   SE VALIDA QTD OU N$$HEX1$$c300$$ENDHEX$$O
Select vl_parametro
Into :ivs_Valida_qtd_recebimento
From wms_parametro
Where cd_parametro ='ID_VALIDA_QTD_RECEBIMENTO'
Using Sqlca;

Choose Case Sqlca.SqlCode
	Case 100
		as_erro = "O par$$HEX1$$e200$$ENDHEX$$metro n$$HEX1$$e300$$ENDHEX$$o foi localizado 'ID_VALIDA_QTD_RECEBIMENTO'."
		Return False
	Case -1
		as_erro = "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do parametro WMS: 'ID_VALIDA_QTD_RECEBIMENTO'."
		Return False
End Choose

// SEGREGADO RETIRADA DE EXCESSO - CONTROLADOS
Select vl_parametro
Into :ivs_Endereco_Segregado_RetExcessoControlado
From wms_parametro
Where cd_parametro ='CD_ENDERECO_SEGREGADO_RETEXCESSO_CONTROL'
Using Sqlca;

Choose Case Sqlca.SqlCode
	Case 0
		
		Select cd_endereco
		Into :ls_Achou
		From wms_endereco
		Where cd_endereco = :ivs_Endereco_Segregado_RetExcessoControlado
		Using SqlCa;
		
		Choose Case Sqlca.SqlCode
			Case 0
			Case 100
				as_erro = "O endere$$HEX1$$e700$$ENDHEX$$o de retirada por excesso do segregado de controlados n$$HEX1$$e300$$ENDHEX$$o foi localizado '" + ivs_Endereco_Segregado_RetExcessoControlado + "'."
				Return False
			Case -1
				as_erro = "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do endere$$HEX1$$e700$$ENDHEX$$o de retirada por excesso do segregado de controlados '" + ivs_Endereco_Segregado_RetExcessoControlado + "'."
				Return False
		End Choose
		
	Case 100
		as_erro = "O par$$HEX1$$e200$$ENDHEX$$metro 'CD_ENDERECO_SEGREGADO_RETEXCESSO_CONTROL' n$$HEX1$$e300$$ENDHEX$$o foi localizado."
		Return False
	Case -1
		as_erro = "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro WMS 'CD_ENDERECO_SEGREGADO_RETEXCESSO_CONTROL'."
		Return False
End Choose
// SEGREGADO RETIRADA EXCESSO - CONTROLADOS

// CONTROLE DE SEPARA$$HEX2$$c700c300$$ENDHEX$$O PARA SEGREGADO RETIRADA DE EXCESSO - CONTROLADOS
Select vl_parametro
Into :ivs_Id_Receb_Envia_End_Controlado
From wms_parametro
Where cd_parametro ='ID_RECEB_ENVIA_END_CONTROLADO'
Using Sqlca;

Choose Case Sqlca.SqlCode
	Case 100
		as_erro = "O par$$HEX1$$e200$$ENDHEX$$metro 'ID_RECEB_ENVIA_END_CONTROLADO' n$$HEX1$$e300$$ENDHEX$$o foi localizado."
		Return False
	Case -1
		as_erro = "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro WMS 'ID_RECEB_ENVIA_END_CONTROLADO'."
		Return False
End Choose
// CONTROLE DE SEPARA$$HEX2$$c700c300$$ENDHEX$$O PARA SEGREGADO RETIRADA DE EXCESSO - CONTROLADOS

// SEGREGADO CONFER$$HEX1$$ca00$$ENDHEX$$NCIA
SELECT vl_parametro
  INTO :ivs_Endereco_Conferencia_Segregado
  FROM wms_parametro
 WHERE cd_parametro ='CD_ENDERECO_CONFERENCIA_SEGREGADO'
 USING SQLCA;

Choose Case SQLCA.SQLCode
	Case 0
		
		SELECT cd_endereco
		  INTO :ls_Achou
		  FROM wms_endereco
		 WHERE cd_endereco = :ivs_Endereco_Conferencia_Segregado
		 USING SQLCA;
		
		Choose Case SQLCA.SQLCode
			Case 0
			Case 100
				as_erro = "O endere$$HEX1$$e700$$ENDHEX$$o de confer$$HEX1$$ea00$$ENDHEX$$ncia do segregado '" + ivs_Endereco_Conferencia_Segregado + "' n$$HEX1$$e300$$ENDHEX$$o foi localizado."
				Return False
			Case -1
				as_erro = "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do endere$$HEX1$$e700$$ENDHEX$$o de confer$$HEX1$$ea00$$ENDHEX$$ncia do segregado: '" + ivs_Endereco_Conferencia_Segregado + "'."
				Return False
		End Choose
		
	Case 100
		as_erro = "O par$$HEX1$$e200$$ENDHEX$$metro 'CD_ENDERECO_CONFERENCIA_SEGREGADO' n$$HEX1$$e300$$ENDHEX$$o foi localizado."
		Return False
	Case -1
		as_erro = "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro WMS 'CD_ENDERECO_CONFERENCIA_SEGREGADO'."
		Return False
End Choose
// SEGREGADO CONFER$$HEX1$$ca00$$ENDHEX$$NCIA

Return True
end function

public function boolean of_localiza_parametro_regra_vencido (ref string as_erro);Select vl_parametro
Into :ivs_nova_regra_vencido_danificado
From wms_parametro 
Where cd_parametro = 'ID_UTILIZA_NOVA_REGRA_VENCIDO_DANIFICADO'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		
		If ivs_nova_regra_vencido_danificado <> 'S' and ivs_nova_regra_vencido_danificado <> 'N' Then
			as_erro = "Par$$HEX1$$e200$$ENDHEX$$metro para tratar nova regra de vencido/danificado diferente do esperado S/N."
			Return False
		End If
		
		Return True
	Case 100
		as_erro = "Par$$HEX1$$e200$$ENDHEX$$metro do WMS n$$HEX1$$e300$$ENDHEX$$o foi localizado 'ID_UTILIZA_NOVA_REGRA_VENCIDO_DANIFICADO'."
	Case -1
		as_erro = "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro 'ID_UTILIZA_NOVA_REGRA_VENCIDO_DANIFICADO'."
End Choose

Return False
end function

public function boolean of_verifica_divergencia_lotes (long al_filial, long al_nota, string as_especie, string as_serie, ref string as_erro);Boolean	lb_Divergencia	= False,&
			lb_Divergencia_Fat_Conversao	= False

Long	ll_Transferida,&
		ll_Recebida,&
		ll_Linhas,&
		ll_Linha,&
		ll_Produto,&
		ll_Qt_Lote

String		ls_Mensagem,&
			ls_Produto,&
			ls_Usuario

Boolean lb_Sucesso = True

Decimal	ldc_Fator_Conversao

dc_uo_ds_Base lds_Itens

Try	
	lds_Itens = Create dc_uo_ds_Base
		
	If Not lds_Itens.of_ChangeDataObject("ds_ge481_item_nf_transferencia") Then
		as_erro = "Erro no changedata dos itens[ds_ge481_item_nf_transferencia]."
		Return False
	End If
	
	ll_Linhas = lds_Itens.Retrieve(al_Filial, al_Nota, as_Especie, as_Serie)
	
	If ll_Linhas > 0 Then
		
		For ll_Linha = 1 To ll_Linhas
			
			ll_Produto				= lds_Itens.Object.cd_produto				[ll_Linha]
			ll_Transferida			= lds_Itens.Object.qt_transferida			[ll_Linha]
			ll_Recebida 			= lds_Itens.Object.qt_recebida				[ll_Linha]
			ls_Produto 				= lds_Itens.Object.de_produto				[ll_Linha]
			ldc_Fator_Conversao	= lds_Itens.Object.vl_fator_conversao	[ll_Linha]
		
			
			//Verifica a quantidade dos lotes
			select isnull(Sum(qt_lote), 0)
			into : ll_Qt_Lote
			from item_nf_transferencia_lote
			where cd_filial_origem 	= :al_Filial
			and nr_nf 					= :al_Nota
			and de_especie 			= :as_Especie
			and de_serie 				= :as_Serie
			and cd_produto 			= :ll_Produto
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				ls_Mensagem	= SqlCa.SqlErrtext
				SQLCA.of_rollback()
				as_erro = "Erro ao consultar a quantidade de lotes. ~r~rErro: "+ls_Mensagem+"."
				lb_Sucesso = False
				Exit
			End If
			
			If ll_Recebida <> ll_Qt_Lote Then
				as_erro =	"A quantidade recebida '" + String(ll_Recebida) +&
										"' n$$HEX1$$e300$$ENDHEX$$o pode ser diferente da quantidade do lote '" + String(ll_Qt_Lote) + "' .~r~r" +&
										"Produto: " + ls_Produto + " (" + String(ll_Produto) + ").~r" +&
										"Filial: " + string(al_Filial) + ".~r" +&
										"Nota: " + string(al_Nota) + "."
				SQLCA.of_rollback()
				lb_Sucesso = False
				Exit
			End If
			
		Next
		
	ElseIf ll_Linhas = -1 Then
		SQLCA.of_rollback()
		as_erro = "Erro ao localizar os itens da nota fiscal."
		lb_Sucesso = False
	Else
		SQLCA.of_rollback()
		as_erro = "Os itens n$$HEX1$$e300$$ENDHEX$$o foram localizados para a nota '" + String(al_Nota) +"'."
		lb_Sucesso = False
	End If

Catch ( runtimeerror  lo_rte )
	SQLCA.of_rollback()
  	as_erro = "Erro '"+ lo_rte.GetMessage( ) + "'."
  	lb_Sucesso 	= False
		
Finally
	
	Destroy lds_Itens
	
	Return lb_Sucesso
	
End Try

end function

public function boolean of_verifica_protocolo (long al_cd_produto, string as_nr_lote, string as_nr_protocolo, long al_cd_motivo, ref long al_qt_lote, ref string as_erro);string ls_Erro

/* 
   Verifica a quantidade existente na tabela wms_protocolo
   Na volta da fun$$HEX2$$e700e300$$ENDHEX$$o
	Se houver saldo ent$$HEX1$$e300$$ENDHEX$$o faz a atualiza$$HEX2$$e700e300$$ENDHEX$$o (qt_lote +) 
	Se n$$HEX1$$e300$$ENDHEX$$o houver saldo insere nova linha
*/

SELECT COALESCE(SUM(qt_lote),0)
  INTO :al_qt_lote
  FROM wms_protocolo
 WHERE cd_produto = :al_cd_produto
   AND nr_lote = :as_nr_lote
	AND nr_protocolo = :as_nr_protocolo
   AND cd_motivo_defeito = :al_cd_motivo
 USING SQLCA;

Choose Case SqlCa.SqlCode
	Case -1
		al_qt_lote = 0
		ls_Erro	= SqlCa.SqlErrtext
		SQLCA.of_rollback()
		as_erro = "Produto: " + string(al_cd_produto) + "  Lote: " + as_nr_lote + " Protocolo: " + as_nr_protocolo + " Motivo: " + string(al_cd_motivo) + "~rErro ao consultar quantidade total da wms_protocolo." + ls_Erro
		Return False
End Choose

return true
end function

public function boolean of_verifica_saldo_filial_1 (long al_filial, long al_nota, long al_produto, long al_qt_transferida, datetime adh_emissao_nota, ref string as_erro);DateTime	ldh_Saldo

Long	ll_Saldo_Final

String	ls_Erro

ldh_Saldo	= DateTime(String(gf_GetServerDate(), '01/mm/yyyy')) // DateTime(String(adh_Emissao_Nota, "01/mm/yyyy"))

select	qt_saldo_final
Into	:ll_Saldo_Final
from saldo_produto
where cd_filial = 1
and cd_produto = :al_Produto
and dh_saldo = :ldh_Saldo
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		//if ib_Iniciado_Operacao_SAP then ()*******VERIFICAR SE TEM QUE DEIXA ESSA VARIAVEL EM FUNCIONAMENTO
			If al_Qt_Transferida > ll_Saldo_Final Then
				SqlCa.of_Rollback()
				as_erro = "Filial: "+String(al_Filial)+"  Nota: "+String(al_Nota)+"~rA quantidade movimentada ["+String(al_Qt_Transferida)+"] do produto "+String(al_Produto)+" $$HEX1$$e900$$ENDHEX$$ maior do que a quantidade ["+String(ll_Saldo_Final)+"] na filial 1."
				Return False
			End If
		//end if
		
	Case 100
		SqlCa.of_Rollback()
		as_erro = "Filial: "+String(al_Filial)+"  Nota: "+String(al_Nota)+"~rN$$HEX1$$e300$$ENDHEX$$o foi localizado o saldo do produto "+String(al_Produto)+" na filial 1."
		Return False
		
	Case -1
		ls_Erro	= SqlCa.SqlErrtext
		SqlCa.of_Rollback()
		as_erro = "Filial: "+String(al_Filial)+"  Nota: "+String(al_Nota)+"~rErro ao consultar o saldo do produto "+String(al_Produto)+" na filial 1. "+ls_Erro
		Return False
End Choose

Return True
end function

public function boolean of_grava_movimento_wms_falta (long al_filial, long al_nota, string as_especie, string as_serie, long al_produto, long al_qtde, long al_fator_conversao, string as_responsavel, decimal adc_bc_icms_st, decimal adc_icms_st, ref st_ge481_nf_transferencia_faltas ast_nf_transferencia_faltas[], ref string as_erro);String		ls_Nulo,&
			ls_Lote,&
			ls_Erro

Long	ll_Nulo,&
		ll_Mod,&
		ll_Linha

Date ldt_Validade

SetNull(ls_Nulo)
SetNull(ll_Nulo)

ls_Lote 			= 'SEM LOTE'

Select dh_validade
Into :ldt_Validade
From wms_localizacao
Where	cd_produto 				= :al_Produto
	And	nr_lote				= :ls_Lote
	And	qt_caixa_padrao	= 1
	And	cd_endereco			= (Select max(cd_endereco) from wms_endereco_produto where cd_produto = :al_produto)
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 100
		ldt_Validade	= Date(String(Today(), "01/mm/yyyy"))
		
	Case -1
		ls_Erro = SqlCa.SqlErrtext
		SqlCa.of_Rollback()
		as_erro = "Erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'wf_grava_movimento_wms_falta'. O produto "+String(al_Produto)+" est$$HEX1$$e100$$ENDHEX$$ repetido no flow rack com o lote "+ls_Lote+": " + ls_Erro
		Return False
End Choose

ids_Movimentacao.ivb_Commit 					= False
ids_Movimentacao.ivb_endereco_bloqueado 	= False
ids_Movimentacao.ivb_valida_inventario 	= False

If al_fator_conversao > 1 Then
	ll_Mod = Mod(al_qtde ,  al_fator_conversao)
	
	If ll_Mod = 0 Then
		al_qtde = al_qtde /  al_fator_conversao
		
		If Not IsNull(ldt_Validade) Then		
			ldt_Validade	= Date(String(ldt_Validade, '01/mm/yyyy'))
		End If
		
		If Not ids_Movimentacao.of_Insere_Movimentacao(	ivs_Endereco_Segregado_Falta,	ls_Nulo,	al_produto,	1,ls_Lote,ldt_Validade,al_qtde,&
																			'S', al_Filial,ls_Nulo,al_Nota,as_Especie,as_Serie,&
																			 as_responsavel, ll_Nulo,&
																			 Round(adc_Bc_Icms_St * al_qtde, 2), Round(adc_Icms_St * al_qtde, 2), 0, 0) Then
			as_erro = 'Erro em realizar a movimenta$$HEX2$$e700e300$$ENDHEX$$o do produto ('+ String(al_produto) +').[FALTA_FATOR] '+ ids_movimentacao.is_log_erro
			SQLCA.of_rollback()
			Return False													 
		End If
		
		ll_Linha = Upperbound(ast_nf_transferencia_faltas) + 1
		
		ast_nf_transferencia_faltas[ll_Linha].cd_endereco_falta			= ivs_Endereco_Segregado_Falta
		ast_nf_transferencia_faltas[ll_Linha].cd_produto					= al_produto
		ast_nf_transferencia_faltas[ll_Linha].nr_lote						= ls_Lote
		ast_nf_transferencia_faltas[ll_Linha].dt_validade					= ldt_Validade
		ast_nf_transferencia_faltas[ll_Linha].qt_falta						= al_qtde
	End If
Else

	If Not ids_Movimentacao.of_Insere_Movimentacao(	ivs_Endereco_Segregado_Falta,	ls_Nulo,	al_produto,	1,ls_Lote,ldt_Validade,al_qtde,&
																		'S', al_Filial,ls_Nulo,al_Nota,as_Especie,as_Serie,&
																		 as_responsavel, ll_Nulo,&
																		 Round(adc_Bc_Icms_St * al_qtde, 2), Round(adc_Icms_St * al_qtde, 2), 0, 0) Then
		as_erro = 'Erro em realizar a movimenta$$HEX2$$e700e300$$ENDHEX$$o do produto ('+ String(al_produto) +').[FALTA] '+ ids_movimentacao.is_log_erro
		SQLCA.of_rollback()
		Return False													 
	End If
	
	ll_Linha = Upperbound(ast_nf_transferencia_faltas) + 1
		
	ast_nf_transferencia_faltas[ll_Linha].cd_endereco_falta			= ivs_Endereco_Segregado_Falta
	ast_nf_transferencia_faltas[ll_Linha].cd_produto					= al_produto
	ast_nf_transferencia_faltas[ll_Linha].nr_lote						= ls_Lote
	ast_nf_transferencia_faltas[ll_Linha].dt_validade					= ldt_Validade
	ast_nf_transferencia_faltas[ll_Linha].qt_falta						= al_qtde
	
End if

Return True
end function

private function boolean of_troca_filial (long pl_cd_filial_origem, long pl_nr_nf, string ps_de_especie, string ps_de_serie, string ps_usuario, ref string as_erro);Long		ll_cd_filial_destino
String	ls_erro


SELECT
	nt.cd_filial_destino
INTO
	:ll_cd_filial_destino
FROM
	nf_transferencia nt
WHERE 
	nt.cd_filial_origem	= :pl_cd_filial_origem 
	AND nt.nr_nf 		 	= :pl_nr_nf 
	AND nt.de_especie 	= :ps_de_especie 
	AND nt.de_serie 	 	= :ps_de_serie;

Choose Case SQLCA.SQLCode
	Case -1
		ls_erro	= SqlCa.SqlErrtext
		SqlCa.of_rollback()
		as_erro = "Erro ao buscar registro da tabela nf_transfer$$HEX1$$ea00$$ENDHEX$$ncia. ~r~rErro: " + ls_Erro + "."
		Return False
	Case 100
		SqlCa.of_rollback()
		as_erro = "N$$HEX1$$e300$$ENDHEX$$o foi encontrado registro na tabela nf_transferencia."
		Return False
	Case 0
		if ll_cd_filial_destino = 534 then
			SqlCa.of_rollback()
			as_erro = "Essa nota fiscal j$$HEX1$$e100$$ENDHEX$$ consta como recebida, favor verificar."
			Return False
		end if
End Choose

UPDATE 
	nf_transferencia  
SET
	cd_filial_destino = 534, 
	dh_entrada_cd 		= getdate(),
	dh_recebido_sap	= getdate()
WHERE 
	cd_filial_origem	= :pl_cd_filial_origem 
	AND nr_nf 		 	= :pl_nr_nf 
	AND de_especie 	= :ps_de_especie 
	AND de_serie 	 	= :ps_de_serie
USING SQLCA;

If SqlCa.SqlCode = -1 Then
	ls_erro = SqlCa.SqlErrtext
	SqlCa.of_rollback()
	as_erro = "Erro no update na tabela nf_transfer$$HEX1$$ea00$$ENDHEX$$ncia: " + ls_erro + "."
	Return False
Else
	Return True
End If

end function

public function boolean of_cadastra_produto_sem_flow (long al_filial, long al_nota, string as_especie, string as_serie, string as_matricula, string as_retirada_excesso, ref string as_log);Long ll_Linhas_Retrieve,&
		ll_Linha_Retrieve
		
st_ge481_cadastra_prd_flow lst_Produtos[]
uo_ge481_cadastra_produto_flow lo_Cadastra_Prd_Flow //ACREDITO QUE DEVE FICA COMO GE, TRANSFORMA EM GE***(ANALISAR MELHOR)
dc_uo_ds_base lds_Produtos

If as_retirada_excesso = 'S' Then
	
	Try
		lds_Produtos			= Create dc_uo_ds_base
		lo_Cadastra_Prd_Flow	= Create uo_ge481_cadastra_produto_flow
		
		lo_Cadastra_Prd_Flow.ib_ignora_sem_endereco_vago	= True
		
		If ivs_Id_Receb_Envia_End_Controlado = 'S' Then//Analisar melhor esse ponto de controlado, EST$$HEX1$$c100$$ENDHEX$$ NO PARAMETRO NA TELA WS_021.
			If Not lds_Produtos.of_ChangeDataObject("dw_ge481_lst_prd_n_contr_s_end") Then
				Return False
			End If														
			
			ll_Linhas_Retrieve	= lds_Produtos.Retrieve(al_Filial, al_Nota, as_Especie, as_Serie)
			
			If ll_Linhas_Retrieve < 0 Then
				SqlCa.of_Rollback ()
				as_log = "Erro no retrieve da 'dw_ge481_lst_prd_n_contr_s_end'."
				Return False
			End If
		else
			If Not lds_Produtos.of_ChangeDataObject("dw_ge481_lista_produto_sem_endereco_new") Then
				SqlCa.of_Rollback ()
				Return False
			End If														
			
			ll_Linhas_Retrieve	= lds_Produtos.Retrieve(al_Filial, al_Nota, as_Especie, as_Serie)
			
			If ll_Linhas_Retrieve < 0 Then
				SqlCa.of_Rollback() 
				as_log = "Erro no retrieve da 'dw_ge481_lista_produto_sem_endereco_new'."
				Return False
			End If
		End if
		
		If ll_Linhas_Retrieve > 0 Then
			// Se o par$$HEX1$$e200$$ENDHEX$$metro ivs_Id_Receb_Envia_End_Controlado estiver com S, o cadastro ser$$HEX1$$e100$$ENDHEX$$ somente para os n$$HEX1$$e300$$ENDHEX$$o controlados
			For ll_Linha_Retrieve = 1 To ll_Linhas_Retrieve
				lst_Produtos[ll_Linha_Retrieve].cd_produto					= lds_Produtos.Object.cd_produto							[ll_Linha_Retrieve]
				lst_Produtos[ll_Linha_Retrieve].de_produto					= lds_Produtos.Object.nm_produto							[ll_Linha_Retrieve]
				lst_Produtos[ll_Linha_Retrieve].de_grupo						= lds_Produtos.Object.de_grupo							[ll_Linha_Retrieve]
				lst_Produtos[ll_Linha_Retrieve].qt_cadastrar					= lds_Produtos.Object.qt_recebida						[ll_Linha_Retrieve]
				lst_Produtos[ll_Linha_Retrieve].qt_media_transferencia	= lds_Produtos.Object.qt_media							[ll_Linha_Retrieve]
				lst_Produtos[ll_Linha_Retrieve].id_exclusivo_bahia			= lds_Produtos.Object.id_exclusivo_pedido_falta_ba	[ll_Linha_Retrieve]
				lst_Produtos[ll_Linha_Retrieve].nr_lote						= lds_Produtos.Object.nr_lote								[ll_Linha_Retrieve]
				lst_Produtos[ll_Linha_Retrieve].id_origem_excesso			= as_retirada_excesso
			Next
			
			If Not lo_Cadastra_Prd_Flow.of_cadastra_produto_flow(lst_Produtos, as_matricula, Ref as_log, False ) Then
				SqlCa.of_Rollback()
				Return False
			End If
		End If
	Finally
		Destroy(lds_Produtos)
		Destroy(lo_Cadastra_Prd_Flow)
	End Try
End If	

Return True
end function

public function boolean of_verifica_nota_movimentacao (long al_filial, long al_nota, string as_especie, string as_serie, ref string as_log, ref string as_tipo_transf, ref string as_retirada_excesso, ref datetime adh_movimentacao_caixa, ref string as_matricula, ref string as_segrega_nota);Datetime ldh_entrada_cd

Select 
	CASE id_produto_vencido
		WHEN 'S'
			THEN '1'
		ELSE '0'
		END AS id_tipo_transferencia,
	Coalesce(id_retirada_excesso,'N'),
	dh_movimentacao_caixa,
	nr_matricula_entrada_cd,
	Coalesce(id_segrega_nota,'N'),
	dh_entrada_cd
Into 
	:as_Tipo_Transf,
	:as_Retirada_Excesso,
	:adh_movimentacao_caixa,
	:as_matricula,
	:as_segrega_nota,
	:ldh_entrada_cd
From nf_transferencia 
Where cd_filial_origem 		= :al_filial
	and nr_nf 		= :al_nota
	and de_especie = :as_especie
	and de_serie 	= :as_serie
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_log = 'Erro na consulta da nota de transferencia.'
	Return False
End If

If Not Isnull(ldh_entrada_cd) Then
	as_log = 'Nota j$$HEX1$$e100$$ENDHEX$$ foi confirmada em ' + string(ldh_entrada_cd)
	Return False
End If 

If Isnull(as_matricula) Then
	as_log = 'N$$HEX1$$e300$$ENDHEX$$o foi encontrado o responsavel pela confirma$$HEX2$$e700e300$$ENDHEX$$o da nota.' 
	Return False
End If

Return True


end function

public function boolean of_grava_movimento_wms (long al_filial, long al_nota, string as_especie, string as_serie, string as_responsavel, datetime adh_emissao_nota, string as_retirada_excesso, string as_segrega_nota, ref st_ge481_nf_transferencia_faltas ast_nf_transferencia_faltas[], ref string as_erro);Boolean	lb_Divergencia,&
			lb_Sucesso = True

Long	ll_Transferida,&
		ll_Recebida,&
		ll_Linhas,&
		ll_Linha,&
		ll_Produto,&
		ll_Falta,&
		ll_NatOperacao,&
		ll_Fator_Conversao,&
		ll_Mod,&
		ll_Movimento,&
		ll_Nulo

String	ls_Mensagem,&
		ls_Produto,&
		ls_Vencido,&
		ls_Tipo_Trasferencia,&
		ls_Nulo

Decimal	ldc_Bc_Icms_St,&
			ldc_Icms_St

SetNull(ls_Nulo)

Try

	dc_uo_ds_Base lds_Itens
	lds_Itens = Create dc_uo_ds_Base
		
	If Not lds_Itens.of_ChangeDataObject("ds_ge481_item_nf_transferencia") Then
		SQLCA.of_rollback()
		as_erro = "Erro no changedata dos itens[ds_ge481_item_nf_transferencia]."
		Return False
	End If

	ll_Linhas = lds_Itens.Retrieve(al_Filial, al_Nota, as_Especie, as_Serie)
	
	If ll_Linhas > 0 Then
		
		ids_Movimentacao.ivb_Commit 					= False
		ids_Movimentacao.ivb_endereco_bloqueado 	= False
		ids_Movimentacao.ivb_valida_inventario 	= False
		
		For ll_Linha = 1 To ll_Linhas
			
			ll_Produto				= lds_Itens.Object.cd_produto					[ll_Linha]
			ll_Transferida			= lds_Itens.Object.qt_transferida			[ll_Linha]
			ll_Recebida 			= lds_Itens.Object.qt_recebida				[ll_Linha]
			ll_NatOperacao			= lds_Itens.Object.cd_natureza_operacao	[ll_Linha]
			ls_Produto 				= lds_Itens.Object.de_produto					[ll_Linha]
			ls_Vencido				= lds_Itens.Object.id_produto_vencido		[ll_Linha]
			ll_Fator_Conversao 	= lds_Itens.Object.vl_fator_conversao		[ll_Linha]
			ls_Tipo_Trasferencia	= lds_Itens.Object.id_tipo_transferencia	[ll_Linha]	
			ldc_Bc_Icms_St			= lds_Itens.Object.vl_bc_icms_st				[ll_Linha]	
			ldc_Icms_St				= lds_Itens.Object.vl_icms_st					[ll_Linha]	
			
		
			
			
			ldc_Bc_Icms_St			= ldc_Bc_Icms_St / ll_Transferida
			ldc_Icms_St				= ldc_Icms_St / ll_Transferida
			
			If Truncate(ll_Transferida / ll_Fator_Conversao, 0) > 0 Then
				If Not of_Verifica_Saldo_Filial_1(al_Filial, al_Nota, ll_Produto, Truncate(ll_Transferida / ll_Fator_Conversao, 0), adh_Emissao_Nota, Ref as_erro) Then
					lb_Sucesso = False
					Exit
				End If
			End If
			
			If ivs_nova_regra_vencido_danificado = 'S' Then
		
				// Dever$$HEX1$$e100$$ENDHEX$$ ser sempre  divido pelo qtde transferida
				ll_Movimento = Truncate(ll_Transferida / ll_Fator_Conversao, 0)
				If ll_Movimento > 0 Then
					
					If Not of_atualiza_movimento_transferencia(al_Filial, al_Nota, as_Especie, as_Serie, ll_Produto, ll_Movimento, Ref as_erro) Then
						lb_Sucesso = False
						Exit	
					End If
					
					// FAZ O MOVIMENTO DE SAIDA DO ENDERE$$HEX1$$c700$$ENDHEX$$O SEGREG MERCADORIAS EM TRANSITO
					If Not ids_Movimentacao.of_Insere_Movimentacao(	ls_Nulo, 'F910010A', ll_Produto,1,&
																						'SEM LOTE',Date("31/12/2099"),ll_Movimento,'Y',al_Filial,ls_Nulo,&
																						al_Nota,as_Especie,as_Serie,'14330', ll_Nulo,&
																						Round(ldc_Bc_Icms_St * ll_Movimento, 2), Round(ldc_Icms_St * ll_Movimento, 2), 0, 0) Then																										
						lb_Sucesso = False
						as_erro = 'Erro em realizar a movimenta$$HEX2$$e700e300$$ENDHEX$$o do produto('+ String(ll_Produto) +'). '+ ids_movimentacao.is_log_erro
						Exit
					End If					
				End If
				
			End If
						
			If ll_Recebida <= ll_Transferida Then
				
				ll_Falta = ll_Transferida - ll_Recebida
				
				If ll_Falta > 0 Then
					If Not of_grava_movimento_wms_falta(al_Filial, al_Nota, as_Especie, as_Serie,&
																		ll_Produto, ll_Falta,  ll_fator_conversao, as_responsavel,&
																		ldc_Bc_Icms_St, ldc_Icms_St,&
																		Ref ast_nf_transferencia_faltas, Ref as_erro) Then
						lb_Sucesso = False
						Exit																						 
					End If
				End If
				
				If ll_Recebida > 0  Then
					//Vencido ou danificado
					If ls_Tipo_Trasferencia = "1" Then 
						//If ll_Fator_Conversao = 1 Then//Vencido ou danificado grava movimento apenas se o fator de convers$$HEX1$$e300$$ENDHEX$$o for 1
							If Not of_grava_movimento_wms_transferencia(al_Filial, al_Nota, as_Especie, as_Serie,&
																							 ll_NatOperacao, ll_Produto, ll_Fator_Conversao,&
																							 as_responsavel, ls_Vencido, ls_Tipo_Trasferencia, as_retirada_excesso,&
																							 ldc_Bc_Icms_St, ldc_Icms_St, as_segrega_nota, Ref as_erro) Then
								lb_Sucesso = False
								Exit																						 
							End If
						//End If
					Else
						
						If ll_fator_conversao > 1 Then
							ll_Mod = Mod(ll_Recebida ,  ll_fator_conversao)
							
							If ll_Mod = 0 Then
								ll_Recebida = ll_Recebida /  ll_fator_conversao
							Else
								SQLCA.of_rollback()
								as_erro =  "A quantidade recebida do produto ("+String(ll_produto)+") "+ls_Produto+" n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ divis$$HEX1$$ed00$$ENDHEX$$vel pelo fator de convers$$HEX1$$e300$$ENDHEX$$o."
								lb_Sucesso = False
								Exit
							End If						
						End If
						
						If Not of_grava_movimento_wms_transferencia(al_Filial, al_Nota, as_Especie, as_Serie,&
																						 ll_NatOperacao, ll_Produto, ll_Fator_Conversao,&
																						 as_responsavel, ls_Vencido, ls_Tipo_Trasferencia, as_retirada_excesso,&
																						 ldc_Bc_Icms_St, ldc_Icms_St, as_segrega_nota, Ref as_erro) Then
							lb_Sucesso = False
							Exit																						 
						End If			
					End If
				End If
								
			Else
				SQLCA.of_rollback()
				as_erro = "A quantidade recebida '" + String(ll_Recebida) +&
										"' n$$HEX1$$e300$$ENDHEX$$o pode ser maior que a  faturada '" + String(ll_Transferida) + "' .~r~r" +&
										"Produto: " + ls_Produto + " (" + String(ll_Produto) + ")."
				lb_Sucesso = False
				Exit
			End If
	
		Next
		
	ElseIf ll_Linhas = -1 Then
		SQLCA.of_rollback()
		as_erro = "Erro ao localizar os itens da nota fiscal."
		lb_Sucesso = False
	Else
		SQLCA.of_rollback()
		as_erro = "Os itens n$$HEX1$$e300$$ENDHEX$$o foram localizados para a nota '" + String(al_Nota) +"'."
		lb_Sucesso = False
	End If

Catch ( runtimeerror  lo_rte )
	SQLCA.of_rollback()
  as_erro = "Erro '"+ lo_rte.GetMessage( ) + "'."
  lb_Sucesso 	= False
		
Finally
	
	Destroy lds_Itens
	
	Return lb_Sucesso
	
End Try

end function

public function boolean of_verificar_nota_exportacao_sap (ref long al_filial, ref long al_nota, ref string as_especie, ref string as_serie, ref string as_erro);Select cd_filial,
	nr_nf,
	de_especie,
	de_serie
Into :al_filial,
	:al_nota,
	:as_especie,
	:as_serie
From log_exportacao_sap
Where nr_atualizacao = :il_nr_atualizacao
Using SqlCa;

Choose case SQLCA.SQLCode
	case is < 0
		as_erro = "Erro em consulta a informa$$HEX2$$e700e300$$ENDHEX$$o tabela [LOG_EXPORTACAO_SAP]. Erro"+ SqlCa.SqlErrText 
		Return False
	case 100
		as_erro = "O controle "+ String(il_nr_atualizacao) + " n$$HEX1$$e300$$ENDHEX$$o foi encontrado na consulta na tabela log_exportacao_sap."
		Return False
End choose

Return True
end function

public function boolean of_grava_movimento_wms_transferencia (long al_filial, long al_nota, string as_especie, string as_serie, long al_natoperacao, long al_produto, long al_fator_conversao, string as_responsavel, string as_vencido, string as_tipo_transferencia, string as_retirada_excesso, decimal adc_bc_icms_st, decimal adc_icms_st, string as_segrega_nota, ref string as_erro);Long 	ll_Linhas,&
		ll_Linha,&
		ll_Qtde,&
		ll_Nulo,&
		ll_Nr_Movimentacao,&
		ll_Mod,&
		ll_Result,&
		ll_Produto,&
		ll_Row, &
		ll_lin_control, &
		ll_qt_pendente

String 	ls_Mensagem,&
			ls_Produto,&
			ls_Lote,&
			ls_Nulo,&
			ls_Endereco,&
			ls_Grupo_Psico,&
			ls_Erro,&
			ls_Endereco_Flow, &
			ls_log

Date ldt_Validade

Boolean lb_Sucesso

lb_Sucesso = True
SetNull(ls_Nulo)
SetNull(ll_Nulo)

Try
	
	dc_uo_ds_Base lds_Itens
	lds_Itens = Create dc_uo_ds_Base
		
	If Not lds_Itens.of_ChangeDataObject("ds_ge481_item_nf_transferencia_lote") Then
		SQLCA.of_rollback()
		as_erro = "Erro no changedata dos itens."
		Return False
	End If
	
	ll_Linhas = lds_Itens.Retrieve(al_Filial, al_Nota, as_Especie, as_Serie, al_natoperacao, al_produto )
	
	If ll_Linhas > 0 Then
		
		ids_Movimentacao.ivb_Commit 						= False
		ids_Movimentacao.ivb_endereco_bloqueado 		= False
		ids_Movimentacao.ivb_valida_inventario 		= False
		
		For ll_Linha = 1 To ll_Linhas
			
			ll_Produto		= lds_Itens.Object.cd_produto			[ll_Linha]
			ll_Qtde 			= lds_Itens.Object.qt_lote				[ll_Linha]
			ls_Produto 		= lds_Itens.Object.de_produto			[ll_Linha]
			ls_Lote			= lds_Itens.Object.nr_lote				[ll_Linha]
			ldt_Validade	= Date(lds_Itens.Object.dh_validade	[ll_Linha])
			ls_Grupo_Psico	= lds_Itens.Object.cd_grupo_psico	[ll_Linha]			
			
			If as_segrega_nota = 'S' then
				ls_Endereco = ivs_Endereco_Conferencia_Segregado
			Else
				If as_Vencido <> "S" Then
					ls_Endereco		= lds_Itens.Object.cd_endereco_wms[ll_Linha]
				Else
					ls_Endereco		= ivs_Endereco_Segregado_Venc_Danif
				End If
			End If
			
			If ivs_Id_Receb_Envia_End_Controlado = 'S' then
				//
				//Verifica se o produto est$$HEX1$$e100$$ENDHEX$$ na lista dos controlados transferidos por excesso (a DS estar$$HEX1$$e100$$ENDHEX$$ vazia se n$$HEX1$$e300$$ENDHEX$$o for o caso)
				//
				ll_lin_control = ids_produtos_controlados_excesso.Find ('cd_produto = ' + String (ll_produto), 1, ids_produtos_controlados_excesso.Rowcount ())
				Choose case ll_lin_control
					case is < 0
						SQLCA.of_rollback()
						as_erro = "Erro no find da 'ds_produtos_controlados_excesso'"
						lb_Sucesso = False
						Exit
					case 0	// n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ produto controlado, ou n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ retirada por excesso, portanto, ignora
					case is > 0
						ls_Endereco = ivs_Endereco_Segregado_RetExcessocontrolado	//controlado em retirada por excesso vai para endere$$HEX1$$e700$$ENDHEX$$o fixo, parametrizado
				End choose
			End if
			
			If Trim(ls_Endereco) = "" Then
				SQLCA.of_rollback()
				as_erro = "N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ endere$$HEX1$$e700$$ENDHEX$$o para o produto '"+String(al_produto)+"', nota '"+String(al_Nota)+"', filial '"+String(al_Filial)+"'."
				lb_Sucesso = False
				Exit
			End If
			
			If al_Fator_Conversao > 1 Then
				ll_Mod = Mod(ll_qtde ,  al_Fator_Conversao)
				
				If ll_Mod = 0 Then
					ll_qtde = ll_qtde /  al_Fator_Conversao
				Else
					If as_Tipo_Transferencia = "1" Then	//Vencido ou danificado					
						ll_Result = Truncate(ll_qtde /  al_Fator_Conversao, 0)
						If ll_Result = 0 Then
							//ll_Row = ids_Itens_Fator_Conversao.RowCount() + 1
				
//							ids_Itens_Fator_Conversao.object.cd_filial				[ll_Row]	= al_Filial
//							ids_Itens_Fator_Conversao.object.nr_nf						[ll_Row]	= al_Nota
//							ids_Itens_Fator_Conversao.object.de_especie				[ll_Row]	= as_Especie
//							ids_Itens_Fator_Conversao.object.de_serie					[ll_Row]	= as_Serie		
//							ids_Itens_Fator_Conversao.Object.cd_produto				[ll_Row] = ll_Produto
//							ids_Itens_Fator_Conversao.Object.de_produto				[ll_Row] = ls_Produto
//							ids_Itens_Fator_Conversao.Object.nr_lote					[ll_Row] = ls_Lote
//							ids_Itens_Fator_Conversao.Object.qt_faturado				[ll_Row] = ll_Qtde
//							ids_Itens_Fator_Conversao.Object.qt_fator_conversao	[ll_Row] = al_Fator_conversao
//							ids_Itens_Fator_Conversao.Object.qt_movimentada			[ll_Row] = 0
//							ids_Itens_Fator_Conversao.Object.qt_descartada			[ll_Row] = ll_qtde
							
							Continue
						Else
//							ll_Row = ids_Itens_Fator_Conversao.RowCount() + 1
//				
//							ids_Itens_Fator_Conversao.object.cd_filial				[ll_Row]	= al_Filial
//							ids_Itens_Fator_Conversao.object.nr_nf						[ll_Row]	= al_Nota
//							ids_Itens_Fator_Conversao.object.de_especie				[ll_Row]	= as_Especie
//							ids_Itens_Fator_Conversao.object.de_serie					[ll_Row]	= as_Serie		
//							ids_Itens_Fator_Conversao.Object.cd_produto				[ll_Row] = ll_Produto
//							ids_Itens_Fator_Conversao.Object.de_produto				[ll_Row] = ls_Produto
//							ids_Itens_Fator_Conversao.Object.nr_lote					[ll_Row] = ls_Lote
//							ids_Itens_Fator_Conversao.Object.qt_faturado				[ll_Row] = ll_Qtde
//							ids_Itens_Fator_Conversao.Object.qt_fator_conversao	[ll_Row] = al_Fator_conversao
//							ids_Itens_Fator_Conversao.Object.qt_movimentada			[ll_Row] = ll_Result
//							ids_Itens_Fator_Conversao.Object.qt_descartada			[ll_Row] = ll_qtde - (ll_Result*al_Fator_Conversao)
//							
							ll_qtde = ll_Result
						End If
					Else		
						SQLCA.of_rollback()
						as_erro = "A quantidade recebida do lote '"+ls_Lote+"' do produto ("+String(al_Produto)+") "+ls_Produto+" n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ divis$$HEX1$$ed00$$ENDHEX$$vel pelo fator de convers$$HEX1$$e300$$ENDHEX$$o."
						lb_Sucesso = False
						Exit
					End If
				End If
			End If
			
			if not IsNull(ldt_Validade) then
				ldt_Validade	= Date(String(ldt_Validade, '01/mm/yyyy'))
			end if
			
			If Not ids_Movimentacao.of_Insere_Movimentacao(	ls_Endereco,ls_Nulo, al_Produto,1,&
																				ls_Lote,ldt_Validade,ll_qtde,'S',al_Filial,ls_Nulo,&
																				al_Nota,as_Especie,as_Serie,as_Responsavel,&
																				ll_Nulo, Round(adc_bc_icms_st * ll_qtde, 2), Round(adc_icms_st * ll_qtde, 2), 0, 0) Then
				as_erro = 'Erro em realizar a movimenta$$HEX2$$e700e300$$ENDHEX$$o do produto.[TRANSFERENCIA] '+ ids_movimentacao.is_log_erro
				SQLCA.of_rollback()
				lb_Sucesso = False
				Exit
			End If
		Next
		
	ElseIf ll_Linhas = -1 Then
		SQLCA.of_rollback()
		as_erro = "Erro ao localizar os lotes da nota fiscal."
		lb_Sucesso = False
	Else
		SQLCA.of_rollback()
		as_erro = "Os lotes n$$HEX1$$e300$$ENDHEX$$o foram localizados para a nota '" + String(al_Nota) +"'."
		lb_Sucesso = False
	End If

Catch ( runtimeerror  lo_rte )
	SQLCA.of_rollback()
	as_erro = "Erro '"+ lo_rte.GetMessage( ) + "'."
	lb_Sucesso 	= False
		
Finally
	Destroy lds_Itens
	Return lb_Sucesso
End Try


end function

public function boolean of_atualiza_movimento_transferencia (long al_filial, long al_nota, string as_especie, string as_serie, long al_produto, long al_qt_movimentado, ref string as_erro);UPDATE
	item_nf_transferencia  
SET
	qt_movimentado = :al_qt_movimentado
WHERE 
	cd_filial_origem	= :al_filial 
	AND nr_nf 		 	= :al_nota 
	AND de_especie 	= :as_especie 
	AND de_serie 	 	= :as_serie
	And cd_produto		= :al_produto
USING SQLCA;

If SqlCa.SqlCode = -1 Then
	as_erro = SqlCa.SqlErrtext
	SqlCa.of_rollback()
	as_erro = "Erro no update na tabela item_nf_transfer$$HEX1$$ea00$$ENDHEX$$ncia: " + as_erro + "."
	Return False
Else
	Return True
End If	
end function

on uo_ge481_conf_rec_nf_trans.create
call super::create
end on

on uo_ge481_conf_rec_nf_trans.destroy
call super::destroy
end on

