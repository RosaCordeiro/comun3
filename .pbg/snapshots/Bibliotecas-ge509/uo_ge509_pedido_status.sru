HA$PBExportHeader$uo_ge509_pedido_status.sru
forward
global type uo_ge509_pedido_status from uo_ge516_comum_interface_ecommerce
end type
end forward

global type uo_ge509_pedido_status from uo_ge516_comum_interface_ecommerce
boolean ib_grava_log_historico = true
long il_cd_tipo = 13
string is_datastore_dados = "ds_ge509_Pedido_status"
string is_objeto_comum = "uo_ge509_comum_consulta_remedio"
long il_cd_mensagem_email = 289
string is_mensagem_email_1 = "PEDIDO - STATUS"
end type
global uo_ge509_pedido_status uo_ge509_pedido_status

type variables
string is_nr_pedido_ecommerce
string is_Nm_Transportadora
string is_nr_pedido_drogaexpress

string is_id_situacao
string is_id_situacao_plataforma
string is_situacao_loja
string is_chave_acesso_nfe
string is_url_rastreio
string is_codigo_rastreio
string is_id_sistema_novo

long il_cd_filial_ecommerce
long il_nr_pedido
long il_cd_filial_ant
long il_qt_volumes
long il_qt_pendente_faturamento
long il_nr_nota

datetime idt_nota

decimal{2} idc_vl_nota
end variables

forward prototypes
public subroutine of_configurar_parametros ()
private function boolean of_processa_interface_itens (long pl_linha, ref boolean pb_gerar_log, ref string ps_log)
public function boolean of_enviar_fatura (string ps_json, ref string ps_log)
public function boolean of_enviar_entrega (ref string ps_log)
public function boolean of_enviar_rastreio (string ps_json, ref string ps_log)
public function boolean of_monta_json (ref string ps_json, ref string ps_log)
public function boolean of_monta_json_rastreio (ref string ps_json, ref string ps_log)
public function boolean of_busca_dados_loja (ref string ps_log)
public function boolean of_reserva_etiqueta_correio (ref string ps_objeto_rastreio, ref string ps_log)
public function boolean of_atualiza_pedido (ref string ps_log)
public subroutine of_limpa_variaveis ()
private function boolean of_carrega_dados (ref long pl_linhas, ref string ps_log)
public function boolean of_enviar_entregue (ref string ps_log)
public function boolean of_busca_situacao_plataforma (ref string ps_log)
public function boolean of_cancelar_pedido (ref string ps_log)
public function boolean of_gerar_pre_postagem (ref string ps_retorno, ref string ps_log)
end prototypes

public subroutine of_configurar_parametros ();Choose Case is_id_ecommerce
	Case '5'
		
		is_id_interface = 'api/v1/store/orders/XXX/tax_invoice'
		
		
ENd Choose
end subroutine

private function boolean of_processa_interface_itens (long pl_linha, ref boolean pb_gerar_log, ref string ps_log);string ls_id_tipo_entrega
string ls_json_rastreio
string ls_json_faturamento
string ls_msg_email
string ls_id_exige_nfe
string ls_id_devolucao

datetime ldh_faturado

boolean lb_atualizar = True

is_nr_pedido_ecommerce = ids_dados.object.nr_pedido_ecommerce[pl_linha]
is_Nm_Transportadora = ids_dados.object.nm_transportadora[pl_linha]

il_cd_filial_ecommerce = ids_dados.object.cd_filial_ecommerce[pl_linha]
il_nr_pedido = ids_dados.object.nr_pedido[pl_linha]
ls_id_tipo_entrega = ids_dados.object.id_tipo_entrega[pl_linha]
is_nr_pedido_drogaexpress = ids_dados.object.nr_pedido_drogaexpress[pl_linha]
is_id_situacao = ids_dados.object.id_situacao[pl_linha]
ls_id_exige_nfe = ids_dados.object.id_exige_nfse[pl_linha]
il_Filial_Disque = ids_dados.object.cd_filial[pl_linha]
ls_id_devolucao  = ids_dados.object.id_devolucao[pl_linha]
ldh_faturado = ids_dados.object.dh_faturado[pl_linha]
is_id_sistema_novo = ids_dados.object.id_sistema_novo[pl_linha]


w_Aguarde_3.wf_settext('Filial: ' + string(il_cd_filial) + ' (' + is_rede_filial + ')' , 1)
w_Aguarde_3.wf_settext('Pedido: ' + is_nr_pedido_ecommerce + ' (' + string(pl_linha) + ' de ' + string(ids_dados.rowcount()) + ')' , 2)

iuo_comum.il_cd_filial_pedido = il_Filial_Disque
iuo_comum.is_nr_pedido_ecommerce = is_nr_pedido_ecommerce

if this.is_pedido_debug <> '' and not isnull(this.is_pedido_debug) then
	if this.is_pedido_debug <> is_nr_pedido_ecommerce then
		return true
	ENd if
ENd if

if is_id_sistema_novo = 'S' Then
	
	If Not this.of_busca_dados_loja( ref ps_log ) then return false
	
	// (Chave obrigatoria).
	If ls_id_exige_nfe = 'S' and (Isnull(is_chave_acesso_nfe) or is_chave_acesso_nfe = '') Then
		ps_log = 'Aguardando gera$$HEX2$$e700e300$$ENDHEX$$o da chave de acesso da NFe.'
		return false
	End If
	
Else
	
	If Not this.of_conecta_filial( ref ps_log ) Then return false
	
	if is_id_situacao = 'A' Then

		If Not this.of_busca_dados_loja( ref ps_log ) then return false
		
		if Not this.of_busca_situacao_plataforma( ref ps_log) then return false
		
		//Verifica se o pedido foi cancelado na Plataforma:
		If is_id_situacao_plataforma = 'canceled' then
			
			//Verificado se o pedido foi faturado e ainda nao foi feita devolu$$HEX1$$e700$$ENDHEX$$ao:
			if not isnull(il_nr_nota) and il_nr_nota > 0 and ls_id_devolucao = 'N' then
				ps_log = 'O pedido foi cancelado no Site mas j$$HEX1$$e100$$ENDHEX$$ foi faturado na loja: ' + is_nr_pedido_ecommerce
				ls_msg_email = 'Pedido: ' + is_nr_pedido_ecommerce + ' (' + string(il_nr_pedido) + ') - Pedido foi cancelado no Site mas est$$HEX1$$e100$$ENDHEX$$ com situa$$HEX2$$e700e300$$ENDHEX$$o faturado na loja ' + string(il_cd_filial) + '.' 
				
				iuo_comum.of_envia_email(300, 'PEDIDO STATUS', il_nr_pedido, ls_msg_email)
				
				return false
				
			Else
				
				//Cancelar o pedido:
				if Not this.of_cancelar_pedido( ref ps_log ) then return false
				
				return true
				
			End if
			
		Elseif is_situacao_loja = 'A' Then
			Return true
		End if
		
		// Como ainda n$$HEX1$$e300$$ENDHEX$$o tem a chave de acesso mantem como ABERTO para aguardar essa informa$$HEX2$$e700e300$$ENDHEX$$o ser gerada (Chave obrigatoria).
		If ls_id_exige_nfe = 'S' and is_situacao_loja <> 'G' and is_situacao_loja <> 'P' and (Isnull(is_chave_acesso_nfe) or is_chave_acesso_nfe = '') Then
			ps_log = 'Aguardando gera$$HEX2$$e700e300$$ENDHEX$$o da chave de acesso da NFe.'
			return false
		End If
		
		is_id_situacao = is_situacao_loja
	
	End if
	
ENd if

Choose case is_id_situacao
		
	Case 'E'	//Entregue
		
		If Not this.of_enviar_entregue( ref ps_log ) then return false
		
	Case 'C','M'	//Com a Transportadora
		
		//Verificar se o pedido foi entregue:
		if Not this.of_busca_situacao_plataforma( ref ps_log) then return false
	
		If is_id_situacao_plataforma = 'delivered' then
			
			is_id_situacao = 'E'
		Else
			lb_atualizar = false
		ENd if
		
	Case 'F' //Faturado
		
		Choose case ls_id_tipo_entrega
		
			Case 'ECT' //Correios
			
				if isnull(ldh_faturado) then
					
					//if Not this.of_reserva_etiqueta_correio( ref is_codigo_rastreio, ref ps_log ) then return false
					
					if Not this.of_gerar_pre_postagem( ref is_codigo_rastreio, ref ps_log ) then return false
					
					if is_codigo_rastreio = '' or isnull(is_codigo_rastreio) then
						ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi possivel gerar o codigo de rastreio.'
						return false
					ENd if
					
					is_url_rastreio = 'https://portalpostal.com.br/sro.jsp?sro=' + is_codigo_rastreio
					
					If Not this.of_monta_json_rastreio( ref ls_json_rastreio, ref ps_log ) Then return false
					
					if Not this.of_enviar_entrega( ref ps_log ) then return false
					
					if Not this.of_enviar_rastreio( ls_json_rastreio, ref ps_log ) then return false
					
				Else
			
					//Verificar se o pedido foi entregue:
					if Not this.of_busca_situacao_plataforma( ref ps_log) then return false
				
					If is_id_situacao_plataforma = 'delivered' then
						
						is_id_situacao = 'E'
					Else
						lb_atualizar = false
					ENd if
			
				ENd if
			
			Case 'UBE' //UBER
			
				is_id_situacao = 'C'
				
				if Not this.of_enviar_entrega( ref ps_log ) then return false
			
			Case 'RET' //Retirada em Loja
			
				is_id_situacao = 'D'
				
				if Not this.of_enviar_entrega( ref ps_log ) then return false
			
			Case 'MOT' //Motoboy
				
				if Not this.of_enviar_entrega( ref ps_log ) then return false
				
		ENd Choose
		
		if isnull(ldh_faturado) then
			If Not this.of_monta_json( ref ls_json_faturamento, ref ps_log ) then return false
			
			If Not this.of_enviar_fatura( ls_json_faturamento, ref ps_log ) then return false
		ENd if
		
	Case ELse
		ps_log = 'Situa$$HEX2$$e700e300$$ENDHEX$$o do pedido n$$HEX1$$e300$$ENDHEX$$o mapeada: ' + is_id_situacao
		
ENd Choose

if lb_atualizar = True Then
	If Not this.of_atualiza_pedido( ref ps_log ) then return false
End if

return true
end function

public function boolean of_enviar_fatura (string ps_json, ref string ps_log);string ls_retorno

Choose Case is_id_ecommerce
	Case '5'
		
		iuo_comum.of_post( ps_json, 'api/v1/store/orders/' + is_nr_pedido_ecommerce + '/tax_invoice', ref ls_retorno, ref ps_log )
			
		//{errors:{base:[Pedido j$$HEX1$$e100$$ENDHEX$$ possui nota]}}
		
		if match(ps_log, 'Pedido j$$HEX1$$e100$$ENDHEX$$ possui nota') = True Then ps_log = ''	
		
End Choose

if ps_log <> '' and not isnull(ps_log) then return false

return true
end function

public function boolean of_enviar_entrega (ref string ps_log);string ls_retorno
string ls_erro

uo_ge073_json luo_gera_json

Choose Case is_id_ecommerce
	Case '5'
		
		iuo_comum.of_patch( '', 'api/v1/store/orders/' + is_nr_pedido_ecommerce + '/ship', ref ls_retorno, ref ps_log )
			
		if ps_log <> '' and not isnull(ps_log) then
			
			luo_gera_json = Create uo_ge073_json 
			
			ls_erro = luo_gera_json.of_busca_conteudo_campo_vtex(ps_log, 'errors')
			
			if '[Pedido j$$HEX1$$e100$$ENDHEX$$ foi marcado como enviado' = ls_erro then
				ps_log = ''
			End if
			
		End if
			
			
End Choose

if ps_log <> '' and not isnull(ps_log) then return false

return true
end function

public function boolean of_enviar_rastreio (string ps_json, ref string ps_log);string ls_retorno

Choose Case is_id_ecommerce
	Case '5'
		
		iuo_comum.of_patch( ps_json, 'api/v1/store/orders/' + is_nr_pedido_ecommerce + '/tracking', ref ls_retorno, ref ps_log )
			
End Choose

if ps_log <> '' and not isnull(ps_log) then return false

return true
end function

public function boolean of_monta_json (ref string ps_json, ref string ps_log);string ls_json

Choose Case is_id_ecommerce
	Case '5'
		
		if isnull(is_chave_acesso_nfe) or is_chave_acesso_nfe = '' then is_chave_acesso_nfe = '0'
		
		ls_json = '{ "kind": "NFe",' + &
					  '"number": "' + string(il_nr_nota) + '",' + &
					  '"series": "1",' + &
					  '"access_key": "' + is_chave_acesso_nfe + '",' + &
					  '"total": ' + gf_replace(string(idc_vl_nota), ',', '.',0) + ',' + &
					  '"invoice_date": "' + String(idt_nota,'yyyy-mm-dd hh:mm:ss') + '"}'
		
End Choose

if isnull(ls_json) then
	ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel montar o JSON de faturamento.'
	return false
End if

ps_json = ls_json

return true
end function

public function boolean of_monta_json_rastreio (ref string ps_json, ref string ps_log);string ls_json

Choose Case is_id_ecommerce
	Case '5'
		
		ls_json = '{ "tracking": "' + is_codigo_rastreio + '"}'
		
		
End Choose

if isnull(ls_json) then
	ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel montar o JSON de rastreio.'
	return false
End if

ps_json = ls_json

return true
end function

public function boolean of_busca_dados_loja (ref string ps_log);long ll_nr_nf_devolucao

if this.is_id_sistema_novo = 'S' Then
	
	//Busca os dados da NF na base central
	Select top 1
		 p.id_situacao,
		 dateadd( HOUR, 3, nv.dh_emissao ),
		 nv.vl_total_nf,
		 nv.nr_nf,
		 nvf.de_chave_acesso,
		 ndv.nr_nf
	Into
		:is_situacao_loja,
		:idt_nota,
		:idc_vl_nota,
		:il_nr_nota,
		:is_chave_acesso_nfe,
		:ll_nr_nf_devolucao
	From pedido_ecommerce p
		left join nf_venda nv on ( nv.cd_filial_ecommerce = p.cd_filial_ecommerce 
											and nv.nr_pedido_ecommerce = p.nr_pedido
											and nv.dh_cancelamento is null
											and nv.nr_nf_anexa is null) 
		left join nf_venda_nfe nvf on ( nvf.cd_filial = nv.cd_filial
											and nvf.nr_nf = nv.nr_nf
											and nvf.de_especie = nv.de_especie
											and nvf.de_serie = nv.de_serie )
		left join nf_devolucao_venda ndv on ( ndv.cd_filial_venda = nv.cd_filial
													and ndv.nr_nf_venda = nv.nr_nf
													and ndv.de_especie_venda = nv.de_especie
													and ndv.de_serie_venda = nv.de_serie
													and ndv.dh_cancelamento is null)											
	Where p.nr_pedido =:il_nr_pedido
	and p.cd_filial_ecommerce = :il_cd_filial_ecommerce
	and nv.dh_cancelamento is null
	and nv.nr_nf_anexa is null
	Using SQLCA;
	
	If SQLCA.SqlCode = -1 Then
		ps_log = 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_busca_dados_loja. ' + 'Problemas ao consultar a tabela "pedido_ecommerce": ' + SQLCA.sqlerrtext
		Return False
	End If
	
ELse

	Select	 p.id_situacao,
		 p.qt_volume,
		 (select count(cd_produto) from produto_pedido_drogaexpress x where x.nr_pedido_drogaexpress = p.nr_pedido_drogaexpress and COALESCE(qt_faturada,0) < qt_pedida),
		 nv.dh_emissao + INTERVAL '3 hour',
		 nv.vl_total_nf,
		 nv.nr_nf,
		 nvf.de_chave_acesso,
		 ndv.nr_nf
	Into :is_situacao_loja,
		:il_qt_volumes,
		:il_qt_pendente_faturamento,
		:idt_nota,
		:idc_vl_nota,
		:il_nr_nota,
		:is_chave_acesso_nfe,
		:ll_nr_nf_devolucao
	From pedido_drogaexpress p
		left join nf_venda nv on ( nv.nr_pedido_drogaexpress = p.nr_pedido_drogaexpress ) 
		left join nf_venda_nfe nvf on ( nvf.cd_filial = nv.cd_filial
											and nvf.nr_nf = nv.nr_nf
											and nvf.de_especie = nv.de_especie
											and nvf.de_serie = nv.de_serie )
		left join nf_devolucao_venda ndv on ( ndv.cd_filial_venda = nv.cd_filial
													and ndv.nr_nf_venda = nv.nr_nf
													and ndv.de_especie_venda = nv.de_especie
													and ndv.de_serie_venda = nv.de_serie
													and ndv.dh_cancelamento is null)
	Where p.nr_pedido_drogaexpress =:is_nr_pedido_drogaexpress
	and nv.dh_cancelamento is null
	and nv.nr_nf_anexa is null
	limit 1
	Using itr_Filial;
	
	If itr_Filial.SqlCode = -1 Then
		ps_log = 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_busca_dados_loja. ' + 'Problemas ao consultar a tabela "pedido_drogaexpress": ' + itr_filial.sqlerrtext
		Return False
	End If
	
ENd if

if isnull(is_chave_acesso_nfe) then is_chave_acesso_nfe = ''
	
if isnull(is_situacao_loja) then is_situacao_loja = 'A'

if ll_nr_nf_devolucao > 0 then
	setnull(il_nr_nota)
End if
	
return true
end function

public function boolean of_reserva_etiqueta_correio (ref string ps_objeto_rastreio, ref string ps_log);String ls_Nr_Etiqueta
String ls_de_servico
Long ll_Cd_Seq_Etiqueta
Long ll_Id_Servico
Datetime ldt_validade

Try
	//Quando for pedido da filial 454, usar etiquetas PAC Industrial/Sedex Industrial:
//	if il_Filial_Disque = 454 then
//		if is_Nm_Transportadora = 'SEDEX' then
//			ls_de_servico = 'SEDEX INDUSTRIAL'
//		Elseif is_Nm_Transportadora = 'PAC' then
//			ls_de_servico = 'PAC INDUSTRIAL'
//		Else
//			ls_de_servico = is_Nm_Transportadora	
//		End if
//	else
		ls_de_servico = is_Nm_Transportadora
//	End if

	// Consulta o id_servico, que eh utilizado na reserva de etiquetas
	
	SELECT id_servico
	INTO :ll_Id_Servico
	FROM ecommerce_servico_postagem
	WHERE de_servico = :ls_de_servico
	USING SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		ps_log = 'Problemas ao consultar a tabela "ecommerce_servico_postagem":  ' + sqlca.sqlerrtext
		Return False
	End If
			
	SELECT nr_etiqueta_com_dig
		INTO :ls_Nr_Etiqueta
		 FROM ecommerce_reserva_etiqueta
	  WHERE nr_pedido = :il_nr_pedido
	  	and cd_filial_ecommerce = :il_cd_filial_ecommerce
		USING sqlCa;
		
	Choose Case SqlCa.SqlCode
		Case -1
			ps_log = 'Problemas ao consultar a tabela "ecommerce_reserva_etiqueta":  ' + sqlca.sqlerrtext
			Return False
			
		Case 0
			Return True
	End Choose
	
	SELECT	TOP 1 cd_seq_etiqueta,
				nr_etiqueta_com_dig
		INTO :ll_Cd_Seq_Etiqueta,
				:ls_Nr_Etiqueta
		 FROM ecommerce_reserva_etiqueta
	  WHERE nr_pedido IS NULL
			AND id_servico =:ll_Id_Servico
	ORDER BY cd_seq_etiqueta ASC;	
		
	If SqlCa.SqlCode = -1 Then
		ps_log = 'Problemas ao consultar a tabela "ecommerce_reserva_etiqueta":  ' + sqlca.sqlerrtext
		Return False
	End If						
	
	If ll_Cd_Seq_Etiqueta <=0 Then
		ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi encontrada etiqueta dispon$$HEX1$$ed00$$ENDHEX$$vel para o pedido.'
		Return False
	End If
	
	UPDATE ecommerce_reserva_etiqueta
			SET nr_pedido 	= :il_nr_pedido,
				cd_filial_ecommerce = :il_cd_filial_ecommerce
		WHERE cd_seq_etiqueta = :ll_Cd_Seq_Etiqueta
		 Using SqlCa;
	 
	If SqlCa.SqlCode = -1 Then
		ps_log = 'Problemas ao atualizar registro na tabela "ecommerce_reserva_etiqueta":  ' + sqlca.sqlerrtext
		Return False
	End If	
	
	If Sqlca.SQLNRows <> 1 Then
		ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel reservar etiquetas do correios para esse pedido.'
		return false
	End If
	
	UPDATE pedido_ecommerce
			SET de_codigo_rastreamento_correio = :ls_Nr_Etiqueta
		WHERE cd_filial_ecommerce = :il_cd_filial_ecommerce
		  AND nr_pedido = :il_nr_Pedido
		 Using SqlCa;
		 
	If SqlCa.SqlCode = -1 Then
		ps_log = 'Problemas ao atualizar registro na tabela "pedido_ecommerce":  ' + sqlca.sqlerrtext
		Return False
	End If	
	
	If Sqlca.SQLNRows <> 1 Then
		ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel gravar o codigo de rastreio no pedido.'
		return false
	End If
	
	ps_objeto_rastreio = ls_Nr_Etiqueta
	
	//If Not this.of_grava_entrega( il_filial_ecommerce, il_nr_pedido, ps_nm_transportadora, idc_vl_nota, 0, ldt_validade, ls_Nr_Etiqueta, ref ps_log ) Then return false

Finally
	
	if ps_log <> '' and not isnull(ps_log) Then ps_log = 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_reserva_etiqueta_correio. ' + ps_log
	
End Try

Return True

end function

public function boolean of_atualiza_pedido (ref string ps_log);
Choose CAse is_id_situacao
	Case 'F','D'
		Update pedido_ecommerce
		set id_situacao = :is_id_situacao,
			dh_faturado = getdate(),
			de_url_rastreio = :is_url_rastreio
		where nr_pedido = :il_nr_pedido
		and cd_filial_ecommerce = :il_cd_filial_ecommerce;

		if sqlca.sqlcode = -1 then
			ps_log = 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_pedido; Problemas ao atualizar a tabela pedido_ecommerce: ' + sqlca.sqlerrtext
			return false
		ENd if

		if is_id_situacao = 'D' and is_id_sistema_novo = 'N' Then
			
			Update pedido_drogaexpress
			set id_situacao = 'D'
			where nr_pedido_drogaexpress = :is_nr_pedido_drogaexpress
			Using itr_filial;
			
			if itr_filial.sqlcode = -1 then
				ps_log = 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_pedido; Problemas ao atualizar a tabela pedido_drogaexpress: ' + itr_filial.sqlerrtext
				return false
			ENd if

		ENd if

	Case 'C'
	
		Update pedido_ecommerce
			set id_situacao = :is_id_situacao,
				dh_faturado = getdate()
			where nr_pedido = :il_nr_pedido
			and cd_filial_ecommerce = :il_cd_filial_ecommerce;

			if sqlca.sqlcode = -1 then
				ps_log = 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_pedido; Problemas ao atualizar a tabela pedido_ecommerce: ' + sqlca.sqlerrtext
				return false
			ENd if

	CAse 'E'
	
		Update pedido_ecommerce
		set dh_entrega = getdate(), id_situacao = 'E'
		where nr_pedido = :il_nr_pedido
		and cd_filial_ecommerce = :il_cd_filial_ecommerce;
		
		if sqlca.sqlcode = -1 then
			ps_log = 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_pedido; Problemas ao atualizar a tabela pedido_ecommerce: ' + sqlca.sqlerrtext
			return false
		ENd if

		if is_id_sistema_novo = 'N' Then
			
			Update pedido_drogaexpress
			set id_situacao = 'E'
			where nr_pedido_drogaexpress = :is_nr_pedido_drogaexpress
			Using itr_filial;
			
			if itr_filial.sqlcode = -1 then
				ps_log = 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_pedido; Problemas ao atualizar a tabela pedido_ecommerce: ' + itr_filial.sqlerrtext
				return false
			ENd if
			
		ENd if
End Choose

return true
end function

public subroutine of_limpa_variaveis ();setnull(is_nr_pedido_ecommerce)
setnull(is_Nm_Transportadora)
setnull(is_nr_pedido_drogaexpress)

setnull(is_id_situacao)
setnull(is_situacao_loja)
setnull(is_chave_acesso_nfe)
setnull(is_url_rastreio)
setnull(is_codigo_rastreio)

setnull(il_cd_filial_ecommerce)
setnull(il_nr_pedido)

setnull(il_qt_volumes)
setnull(il_qt_pendente_faturamento)
setnull(il_nr_nota)

setnull(idt_nota)

setnull(idc_vl_nota)

setnull( is_id_situacao_plataforma )
end subroutine

private function boolean of_carrega_dados (ref long pl_linhas, ref string ps_log);pl_linhas = ids_dados.retrieve( is_id_ecommerce, is_rede_filial, il_filial_disque )

return true
end function

public function boolean of_enviar_entregue (ref string ps_log);string ls_retorno

Choose Case is_id_ecommerce
	Case '5'
		
		iuo_comum.of_patch( '', 'api/v1/store/orders/' + is_nr_pedido_ecommerce + '/deliver', ref ls_retorno, ref ps_log )
			
End Choose

if ps_log <> '' and not isnull(ps_log) then return false

return true
end function

public function boolean of_busca_situacao_plataforma (ref string ps_log);string ls_id_endpoint = 'api/v1/store/orders'
string ls_retorno

uo_ge073_json luo_gera_json

//Busca a situacao do pedido na Plataforma:

luo_gera_json = Create uo_ge073_json

if Not iuo_comum.of_get( ls_id_endpoint + '/' + is_nr_pedido_ecommerce, ref ls_retorno, ref ps_log) then return false

is_id_situacao_plataforma = luo_gera_json.of_busca_conteudo_campo_vtex(ls_retorno, 'state')

return true
end function

public function boolean of_cancelar_pedido (ref string ps_log);
Try
	
	Update pedido_ecommerce
	set id_situacao = 'X', dh_cancelamento = getdate()
	where nr_pedido = :il_nr_pedido
	and cd_filial_ecommerce = :il_cd_filial_ecommerce;
	
	if sqlca.sqlcode = -1 then
		ps_log = 'Problemas ao atualizar a tabela pedido_ecommerce: ' + sqlca.sqlerrtext
		return false
	End if
	
	Update pedido_ecommerce_auxiliar
		set de_motivo_cancelamento_pedido = 'PEDIDO CANCELADO NO SITE'
	where nr_pedido = :il_nr_pedido
	and cd_filial_ecommerce = :il_cd_filial_ecommerce;

	if sqlca.sqlcode = -1 then
		ps_log = 'Problemas ao atualizar a tabela pedido_ecommerce_auxiliar: ' + sqlca.sqlerrtext
		return false
	End if
	
	if is_id_sistema_novo = 'N' Then
		
		update pedido_drogaexpress
		set id_situacao = 'X'
		where nr_pedido_drogaexpress = :is_nr_pedido_drogaexpress
		Using itr_Filial;
	
		if itr_Filial.sqlcode = -1 then
			ps_log = 'Problemas ao atualizar a tabela pedido_ecommerce_auxiliar: ' + itr_Filial.sqlerrtext
			return false
		End if
		
	ENd if

Finally
	
	if not isnull(ps_log) and ps_log <> '' then
		ps_log = 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_cancelar_pedido; ' + ps_log
	ENd if
	
	
End Try

return true
end function

public function boolean of_gerar_pre_postagem (ref string ps_retorno, ref string ps_log);string ls_rastreio
string ls_json

uo_ge073_json luo_gera_json

oleobject lole_SrvHTTP

Long ll_status_code
String ls_url_local
String ls_status_text
String ls_Retorno_Api
any la_result

//Adiciona $$HEX1$$e000$$ENDHEX$$ url qual interface est$$HEX1$$e100$$ENDHEX$$ sendo utilizada
ls_url_local = 'http://172.19.12.57:3015/v1/prePostagem'
	
Try	
	
	ls_json = '{"idRede":"' + is_rede_filial + '",' + &
    			 '"nrPedidoEcommerce":"' + is_nr_pedido_ecommerce + '"}'
	
	IF Not IsValid(lole_SrvHTTP) THEN
		
		lole_SrvHTTP = CREATE oleobject
		lole_SrvHTTP.ConnectToNewObject("MSXML2.SERVERXMLHTTP.6.0")
		
	End If
	
	lole_SrvHTTP.open ('POST', ls_url_local, false) 
	
	lole_SrvHTTP.SetRequestHeader("content-type", "application/json")
	
	// Trust the SSL Certificate - IGNORA OS ERROS DE CERTIFICADO
	lole_SrvHTTP.setOption(2,'13056') 
	
	IF IsValid(lole_SrvHTTP) THEN
		
		TRY
			If IsNull( ls_json ) Then ls_json = ''
			
			lole_SrvHTTP.send(ls_json) 
			
		CATCH (RuntimeError e) 
			ps_log = this.classname( ) + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_comunicacao_api ~nErro: ' + e.getMessage()
			Return false
		END TRY 
		
		ll_status_code = lole_SrvHTTP.readyState 
		IF ll_status_code <> 4 THEN
			lole_SrvHTTP.DisconnectObject() 
			Destroy lole_SrvHTTP 
			
			ps_log = this.classname( ) + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_comunicacao_api ~nErro: readyState = ' + String(ll_status_code)
			Return false
			
		End If
		
		//Get response 
		ls_status_text = lole_SrvHTTP.StatusText 
		ll_status_code = lole_SrvHTTP.Status 
		
		ls_Retorno_Api = String( lole_SrvHTTP.ResponseText )
		
		if ll_status_code = 200 or ll_status_code = 201 Then
			
			luo_gera_json = Create uo_ge073_json 
			
			ls_rastreio = luo_gera_json.of_busca_conteudo_campo_vtex(ls_Retorno_Api, 'codigoObjeto')
			
			if ls_rastreio = '' or isnull(ls_rastreio) Then
				ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel capturar o c$$HEX1$$f300$$ENDHEX$$digo de rastreio do pedido.'
				return false
			ENd if
		
			ps_retorno = ls_rastreio
		
		elseif ll_status_code = 401 Then
			
			ps_retorno = ''
			if ls_status_text = '' or isnull(ls_status_text) Then
				ls_status_text = 'Erro no retorno do webservice: Erro 401'
			end if
			
			ps_log = ls_status_text
			
			return false
		
		else
			
			ps_retorno = ''
			
			if ls_Retorno_Api = '' or isnull(ls_Retorno_Api) Then
				ls_Retorno_Api = 'Erro no retorno do webservice: Erro ' + string(ll_status_code)
			end if
			
			ps_log = ls_Retorno_Api
			Return True
			
		end if
		
	End If
	
Finally	
	
	IF IsValid(lole_SrvHTTP) THEN 
		lole_SrvHTTP.DisconnectObject()
		Destroy lole_SrvHTTP 
	end if

End Try

return True
end function

on uo_ge509_pedido_status.create
call super::create
end on

on uo_ge509_pedido_status.destroy
call super::destroy
end on

