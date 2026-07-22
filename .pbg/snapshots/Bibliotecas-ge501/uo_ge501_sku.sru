HA$PBExportHeader$uo_ge501_sku.sru
forward
global type uo_ge501_sku from nonvisualobject
end type
end forward

global type uo_ge501_sku from nonvisualobject
end type
global uo_ge501_sku uo_ge501_sku

type variables
uo_ge501_comum iuo_comum_vtex

string is_objeto
string is_id_ecommerce = '2' //VTEX
string is_tabela = 'SKU'
String is_rede_ecommerce
String is_cd_grupo_psico
String is_manipulado
String is_nome_imagem_manip
String is_url_imagem_manip
String is_geladeira
String is_ean
String is_id_assinatura
String is_id_permitir_assinatura

long il_cd_tipo = 3
long il_seller_manip = 786
string is_cd_subcategoria
decimal idc_altura, idc_largura, idc_profundidade 
decimal{3} idc_peso

uo_produto iuo_Produto

constant string is_id_interface = '/api/catalog/pvt/stockkeepingunit'
constant string is_id_interface_imagem = '/api/catalog_system/pvt/sku/stockkeepingunitbyid/'
constant string is_id_interface_anexo = '/api/catalog/pvt/attachments'
constant string is_id_interface_sku_anexo = '/api/catalog/pvt/skuattachment'

end variables

forward prototypes
public function boolean of_atualiza_produto_ecommerce (long pl_cd_produto, string ps_cd_produto_ecommerce, string ps_cd_sku, boolean pb_existe, ref string ps_log)
public function boolean of_valida_sku (long pl_cd_produto, ref string ps_log)
private function boolean of_monta_json (long pl_cd_produto, string ps_sku, string ps_cd_produto_ecommerce, string ps_ds_internet, boolean pb_disponivel, ref string ps_json, ref string ps_log)
public function boolean of_processa_atualizacao_sku (string ps_rede_filial, long pl_produto)
public function boolean of_valida_retorno_imagem (long pl_cd_produto, string ps_json, ref boolean pb_possui_imagem, ref string ps_log)
public function boolean of_atualiza_prd_manipulado (ref string ps_log)
public function boolean of_atualiza_prd_manipulado_preco (string ps_sku, decimal pdc_valor_req, ref string ps_log)
public function boolean of_atualiza_prd_manipulado_imagem (long pl_produto, string ps_sku, ref string ps_log)
public function boolean of_atualiza_prd_manipulado_situacao (long pl_produto, string ps_sku, string ps_prd_ecommerce, string ps_descricao, ref string ps_log)
public function boolean of_atualiza_prd_manipulado_saldo_navemae (string ps_sku, ref string ps_log)
public function boolean of_atualiza_prd_manipulado_saldo_seller (string ps_sku, long pl_produto, ref string ps_log)
public function boolean of_busca_warehouseid (ref string ps_warehouseid, long pl_filial, ref string ps_log)
private function string of_formata_descricao (long pl_tipo, string ps_ds_marca, long pl_produto)
public function boolean of_atualiza_prd_ean (string ps_rede_filial, ref string ps_log)
public function boolean of_processar_assinatura (string ps_id_permitir_assinatura, string ps_cd_sku, ref string ps_log)
public function boolean of_carga_assinatura (string ps_rede, ref string ps_log)
end prototypes

public function boolean of_atualiza_produto_ecommerce (long pl_cd_produto, string ps_cd_produto_ecommerce, string ps_cd_sku, boolean pb_existe, ref string ps_log);datetime ldt_data
string ls_id_disponivel

ldt_data = gf_getserverdate()

If is_manipulado = 'S' Then
	pl_cd_produto = pl_cd_produto * -1
End If

if pb_existe = False Then

	Update ecommerce_prd
	set cd_sku = :ps_cd_sku, dh_inclusao_sku = :ldt_data, id_permitir_assinatura = :is_id_permitir_assinatura
	Where id_ecommerce = :is_id_ecommerce
		and id_rede_filial = :is_rede_ecommerce
		and cd_produto = :pl_cd_produto;

	if sqlca.sqlcode = -1 then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_produto_ecommerce ~n' + 'Problemas ao atualizar registro na tabela "ecommerce_prd": ~n' + sqlca.sqlerrtext
		return false
	end if

else

	Update ecommerce_prd
	set dh_atualizacao_sku = :ldt_data
	where cd_produto = :pl_cd_produto
		and id_ecommerce = :is_id_ecommerce
		and id_rede_filial = :is_rede_ecommerce;
	
	if sqlca.sqlcode = -1 then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_produto_ecommerce ~n' + 'Problemas ao atualizar registro na tabela "ecommerce_prd": ~n' + sqlca.sqlerrtext
		return false
	end if

End if

return true
end function

public function boolean of_valida_sku (long pl_cd_produto, ref string ps_log);boolean lb_sucesso = true
string ls_mensagem

ls_mensagem = 'Produto [' + string(pl_cd_produto) + ']: '

ps_log = ''

if isnull(idc_largura) or idc_largura <= 0 Then
	ps_log += 'Sem largura configurada.'
	idc_largura = 0
	lb_sucesso = false
End if

if isnull(idc_altura) or idc_altura <= 0 Then
	ps_log += 'Sem altura configurada.'
	idc_altura = 0
	lb_sucesso = false
End if

if isnull(idc_profundidade) or idc_profundidade <= 0 Then
	ps_log += 'Sem profundidade configurada.'
	idc_profundidade = 0
	lb_sucesso = false
End if

if isnull(idc_peso) or idc_peso <= 0 Then
	ps_log += 'Sem peso configurado.'
	idc_peso = 0
	lb_sucesso = false
End if

if lb_sucesso = false Then
	
	ps_log = ls_mensagem + ps_log
	
	return false
else
	return true
end if

end function

private function boolean of_monta_json (long pl_cd_produto, string ps_sku, string ps_cd_produto_ecommerce, string ps_ds_internet, boolean pb_disponivel, ref string ps_json, ref string ps_log);string ls_ativo
string ls_Peso
string ls_modal
string ls_RefID

if ps_sku = '' or isnull(ps_sku) Then
	ps_sku = 'null'
end if

if pb_disponivel Then
	ls_ativo = '"IsActive": true, "ActivateIfPossible": true, '
else
	ls_ativo = '"IsActive": false, "ActivateIfPossible": false, '
end if

ls_Peso = String(idc_peso)
ls_Peso = gf_replace(ls_Peso, ",", '.', 0)

if is_geladeira = 'S' then
	ls_modal = '"ModalType": "REFRIGERATED", '
else
	
	if is_cd_subcategoria = '206027007' then
		ls_modal = '"ModalType": "CHEMICALS", '
	elseif is_cd_grupo_psico = '' or isnull(is_cd_grupo_psico) Then
		ls_modal = '"ModalType": null, ' 
	else
		ls_modal = '"ModalType": "CHEMICALS", '
	end if
end if

If is_Manipulado = 'S' Then
	ls_RefID  = 'OR' + String(pl_cd_produto)
	ls_modal = '"ModalType": "LIQUID", '
Else
	ls_RefID = String(pl_cd_produto)
End If

ps_json = '{ ' + &
	'"Id": ' + ps_sku + ', ' + &
	'"ProductId": ' + ps_cd_produto_ecommerce + ', ' + &
	ls_ativo + & 
	'"Name": "' + this.of_formata_descricao(1, ps_ds_internet, pl_cd_produto) + '", ' + &
	'"RefId": "' + ls_RefID + '", ' + &
	'"PackagedHeight": ' + gf_valor_com_ponto(idc_altura) + ', ' + &
	'"PackagedLength": ' + gf_valor_com_ponto(idc_profundidade) + ', ' + &
	'"PackagedWidth": ' + gf_valor_com_ponto(idc_largura) + ', ' + &
	'"PackagedWeightKg": ' + ls_Peso + ', ' + &
	'"Height": null, ' + &
	'"Length": null, ' + &
	'"Width": null, ' + &
	'"WeightKg": null, ' + &
	'"CubicWeight": 0, ' + &
	'"IsKit": false, ' + &
	'"CreationDate": null, ' + &
	'"RewardValue": null, ' + &
	'"EstimatedDateArrival": null, ' + &
	'"ManufacturerCode": "", ' + &
	'"CommercialConditionId": 1, ' + &
	'"MeasurementUnit": "un", ' + &
	'"UnitMultiplier": 1, ' + &
	ls_modal + &
	'"KitItensSellApart": false ' + &
	'}'

if isnull(ps_json) or ps_json = '' Then
	ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel montar o arquivo JSON para o envio dos dados.'
	return false
end if

return true
end function

public function boolean of_processa_atualizacao_sku (string ps_rede_filial, long pl_produto);long ll_linhas
Long ll_for
long ll_cd_produto
Long ll_cd_filial
Long ll_Seq_Log

String ls_ds_Descricao
String ls_json
String ls_retorno
String ls_cd_produto_ecommerce
String ls_cd_sku
String ls_Chave_Nula
String ls_MSG_Nula
String ls_Log
String ls_Situacao
String ls_id_registro_log
String ls_Chave_log

boolean lb_existe_movimento
boolean lb_disponivel = true
boolean lb_sucesso=false
boolean lb_possui_imagem = false

datetime ldt_inicio
DateTime ldh_Data_Nula
DateTime ldh_log_inicio

SetNull(ls_MSG_Nula)
SetNull(ls_Chave_Nula)
SetNull(ldh_Data_Nula)

dc_uo_ds_base lds_dados

try 
	ldh_log_inicio = gf_getserverdate()
	ls_situacao = 'P'
	
	Open(w_ge501_Aguarde)

	is_rede_ecommerce = ps_rede_filial
	
	iuo_comum_vtex = create uo_ge501_comum

	iuo_Produto = create uo_produto

	lds_dados = create dc_uo_ds_base
	
	if not lds_dados.of_changedataobject( 'ds_ge501_sku_log', False ) Then
		ls_Log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_sku ~n' + 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ds_ge501_sku_log'
		return false
	end if
	
	If gvo_Aplicacao.ivs_DataSource <> 'central' then
		ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_sku, a atualiza$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o pode ser a partir do HOMOLOGA.'
		return false
	End If
	
	//Carrega os parametros e busca o c$$HEX1$$f300$$ENDHEX$$digo da filial vinculado a rede.
	if Not iuo_comum_vtex.of_parametros_ecommerce(is_id_ecommerce, ps_rede_filial, ref ll_cd_filial, ref ls_Log ) Then return false

	setnull(ls_id_registro_log)
	iuo_comum_vtex.of_grava_log_historico(ref ls_id_registro_log, ll_cd_filial, il_cd_tipo, ldh_log_inicio, ldh_Data_Nula, 'C', 0, ref ls_log )	

	//Altera situacao para pendente
	If not iuo_comum_vtex.of_altera_situacao_log_ecommerce( 'P', is_tabela, ll_cd_filial, '', ref ls_Log ) Then return false
	
	If Not IsNull( pl_Produto ) and pl_produto > 0 Then
		lds_dados.of_AppendWhere("de_chave = '" + String( pl_Produto ) + "'" )
	End If
	
	ll_linhas = lds_dados.retrieve( is_id_ecommerce, ll_cd_filial, is_rede_ecommerce)
	
	if ll_linhas < 0 Then
		ls_Log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_sku ~n' + 'Problemas ao consultar o banco de dados na seguinte datawindow: ds_ge501_sku_log'
		return false
	end if
	
	If ll_Linhas > 0 Then
		iuo_comum_vtex.il_qt_item_enviado_site = ll_linhas
         // Grava in$$HEX1$$ed00$$ENDHEX$$cio do processo
		If Not iuo_comum_vtex.of_grava_log(ll_cd_filial, il_cd_tipo, ls_Chave_Nula, 'C', ls_MSG_Nula, gf_getserverdate(), gf_getserverdate(), ref ls_Log, ref ll_Seq_Log ) Then Return False
	End If
	
	w_ge501_Aguarde.uo_progress.of_setmax(ll_Linhas)
	
	for ll_for = 1 to ll_linhas
		
		w_ge501_Aguarde.Title = "VTEX - [SKU] - [" + ps_rede_filial +  "] - "  + String(ll_for)  + " de " + STring(ll_Linhas)
		is_ean=''
		iuo_comum_vtex.of_limpa_variaveis( )
		lb_disponivel = True
		
		is_id_permitir_assinatura = ''
		
		ldt_inicio = gf_getserverdate()
		
		ll_cd_produto 					= lds_dados.object.cd_produto					[ll_for]
		ls_cd_produto_ecommerce 	= lds_dados.object.cd_produto_ecommerce[ll_for]
		ls_cd_sku 						= lds_dados.object.cd_sku						[ll_for]
		idc_altura 						= lds_dados.object.qt_altura_cm				[ll_for]
		idc_largura 						= lds_dados.object.qt_largura_cm				[ll_for]
		idc_profundidade 				= lds_dados.object.qt_profundidade_cm		[ll_for]
		idc_peso 						= lds_dados.object.qt_peso_grama			[ll_for]
		ls_ds_Descricao 				= lds_dados.object.de_descricao_internet	[ll_for]
		is_cd_grupo_psico				= lds_dados.object.cd_grupo_psico			[ll_for]
		is_manipulado 					= lds_dados.object.id_manipulado				[ll_for]
		is_geladeira 					= lds_dados.object.id_geladeira				[ll_for]
		is_cd_subcategoria			= lds_dados.object.cd_subcategoria			[ll_for]
		is_id_permitir_assinatura = lds_dados.object.id_permitir_assinatura  [ll_for]
		
		if isnull(is_id_permitir_assinatura) then is_id_permitir_assinatura = 'N'
		
		iuo_Produto.of_Localiza_Codigo_Interno(ll_cd_Produto)
		
		is_ean = iuo_produto.de_codigo_barras
		
		//Tratar os produtos TESTE COVID como de geladeira
		if ll_cd_produto = 739825 or ll_cd_produto = 739822 Then
			is_geladeira = 'S'
		end if
		
		If is_Manipulado = 'S' Then
			ls_Chave_log = 'OR' + String(ll_cd_produto)
			//ls_ds_Descricao = '(RQ' + String(ll_cd_produto) + ') ' + ls_ds_Descricao 
		Else
			ls_Chave_log = String(ll_cd_produto)
		End If
		
		If Not this.of_valida_sku( ll_cd_produto, ref ls_Log ) Then 
			iuo_comum_vtex.of_grava_log_item( ll_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
			ls_Situacao = 'E'
			ls_Log = ''
			w_ge501_Aguarde.uo_progress.of_setprogress(ll_for)
			Continue
		End if
		
		if isnull(ls_cd_sku) or ls_cd_sku = '' Then
			lb_disponivel = false
		elseif not isnull(ls_cd_sku) and ls_cd_sku <> ''  Then //O SKU j$$HEX1$$e100$$ENDHEX$$ foi exportado pra VTEX
			//Verificar se a imagem j$$HEX1$$e100$$ENDHEX$$ foi cadastrada:
			iuo_comum_vtex.of_get( is_id_interface_imagem + string(ls_cd_sku) , ref ls_retorno, ref ls_log )
			
			if ls_retorno = '' Then //Erro no retorno do webservice
				iuo_comum_vtex.of_grava_log_item( ll_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
				ls_Situacao = 'E'
				ls_Log = ''
				w_ge501_Aguarde.uo_progress.of_setprogress(ll_for)
				Continue
			end if
			
			ls_log = ''
			this.of_valida_retorno_imagem( ll_cd_produto, ls_retorno, ref lb_possui_imagem, ref ls_log) 
			
			if ls_log <> '' and not isnull(ls_log) Then //Erro 
				gf_ge501_RollBack(SQLCA)
				iuo_comum_vtex.of_grava_log_item( ll_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
				ls_Situacao = 'E'
				ls_Log = ''
				w_ge501_Aguarde.uo_progress.of_setprogress(ll_for)
				Continue
			end if
			
			if lb_disponivel and Not lb_possui_imagem Then
				lb_disponivel = false
			end if
			
			ls_retorno = ''
			
		end if
		
		this.of_monta_json( ll_cd_produto, ls_cd_sku, ls_cd_produto_ecommerce, ls_ds_Descricao, lb_disponivel, ref ls_json, ref ls_Log)
		
		if ls_log <> '' and not isnull(ls_log) Then //Erro 
			gf_ge501_RollBack(SQLCA)
			iuo_comum_vtex.of_grava_log_item( ll_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
			ls_Situacao = 'E'
			ls_Log = ''
			w_ge501_Aguarde.uo_progress.of_setprogress(ll_for)
			Continue
		end if
		
		iuo_comum_vtex.il_cd_produto 			= ll_cd_produto
		iuo_comum_vtex.idc_qt_altura 				= idc_altura
		iuo_comum_vtex.idc_qt_largura 			= idc_largura
		iuo_comum_vtex.idc_qt_profundidade 	= idc_profundidade
		iuo_comum_vtex.idc_qt_peso 				= idc_peso
				
		iuo_comum_vtex.is_json = ls_json
		
		if not isnull(ls_cd_sku) and ls_cd_sku <> '' Then //O SKU j$$HEX1$$e100$$ENDHEX$$ foi exportado pra VTEX
		
			if not iuo_comum_vtex.of_put( ls_json, is_id_interface + '/' + ls_cd_sku , ref ls_retorno, ref ls_Log ) Then return false
			
			if ls_retorno = '' Then //Erro no retorno do webservice
				iuo_comum_vtex.of_grava_log_item( ll_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
				ls_Situacao = 'E'
				ls_Log = ''
				w_ge501_Aguarde.uo_progress.of_setprogress(ll_for)
				Continue
			else
				setnull(ls_log)
				//Chama fun$$HEX2$$e700e300$$ENDHEX$$o para gravar no sybase as atualiza$$HEX2$$e700f500$$ENDHEX$$es do SKU na VTEX.
				if not this.of_atualiza_produto_ecommerce( ll_cd_produto, ls_cd_produto_ecommerce, ls_cd_sku, TRUE, ref ls_Log ) Then Return false
			end if
		
		else //SKU ainda n$$HEX1$$e300$$ENDHEX$$o foi exportado pra VTEX
				
			is_id_permitir_assinatura = 'S'	
				
			if not iuo_comum_vtex.of_post( ls_json, is_id_interface, ref ls_retorno, ref ls_Log ) Then return false
			
			if ls_retorno = '' Then
				iuo_comum_vtex.of_grava_log_item( ll_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
				ls_Situacao = 'E'
				ls_Log = ''
				w_ge501_Aguarde.uo_progress.of_setprogress(ll_for)
				Continue
			else
				setnull(ls_log)
				
				ls_cd_sku = ls_retorno
				
				//Chama fun$$HEX2$$e700e300$$ENDHEX$$o para gravar no sybase o c$$HEX1$$f300$$ENDHEX$$digo do SKUs criado na VTEX.
				if not this.of_atualiza_produto_ecommerce( ll_cd_produto, ls_cd_produto_ecommerce, ls_cd_sku,  FALSE, ref ls_Log ) Then Return false
			end if
			
			//Cadastra o EAN
			if is_ean <> '' and not isnull(is_ean) Then
				if not iuo_comum_vtex.of_post( '', is_id_interface + '/' + ls_cd_sku + '/ean/' + is_ean, ref ls_retorno, ref ls_Log ) Then
					iuo_comum_vtex.of_grava_log_item( ll_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
					ls_Situacao = 'E'
					ls_Log = ''
					w_ge501_Aguarde.uo_progress.of_setprogress(ll_for)
					Continue
				end if
			end if
			
		end if	

		if isnull(is_cd_grupo_psico) and is_manipulado = 'N' and is_geladeira = 'N' then
		
			//Busca os anexos do SKU, para verificar se possui assinatura:
			if Not this.of_processar_assinatura( is_id_permitir_assinatura, ls_cd_sku, ref ls_log) Then
				iuo_comum_vtex.of_grava_log_item( ll_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
				ls_Situacao = 'E'
				ls_Log = ''
				w_ge501_Aguarde.uo_progress.of_setprogress(ll_for)
				Continue
			End if
			
		Else 
			is_id_permitir_assinatura = 'N'

		ENd if

		//Altera situacao para Processado
		If not iuo_comum_vtex.of_altera_situacao_log_ecommerce( 'S', is_tabela, ll_cd_filial, ls_Chave_log, ref ls_Log ) Then return false
		
		//sqlca.of_commit( )
		If Not gf_ge501_commit(SQLCA) Then Return False
		
		if Not iuo_comum_vtex.of_grava_log_item(ll_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log ) Then Return false
				
		w_ge501_Aguarde.uo_progress.of_setprogress(ll_for)
	next
	
	// At$$HEX1$$e900$$ENDHEX$$ aqui j$$HEX1$$e100$$ENDHEX$$ foi comitado
	If ps_rede_filial = 'DC' Then
		If This.of_atualiza_prd_manipulado(ref ls_Log) Then 
			If Not gf_ge501_commit(SQLCA) Then Return False
		Else
			gf_ge501_RollBack(SQLCA)
			iuo_comum_vtex.of_grava_log_item( ll_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
			ls_Situacao = 'E'
			w_ge501_Aguarde.uo_progress.of_setprogress(ll_for)
		End If
	End If

	lb_sucesso = True

Finally
	
	if Not lb_sucesso then 
		ls_Situacao = 'E'
		
		//sqlca.of_rollback( )
		gf_ge501_RollBack(SQLCA)
		
		// J$$HEX1$$e100$$ENDHEX$$ iniciou o envio dos itens
		If ll_for > 0 Then
			// Atualiza log com erro
			If Not iuo_comum_vtex.of_atualiza_ecommerce_log(ll_cd_filial, ll_Seq_Log, 'E', ls_Log, gf_getserverdate(), ref ls_Log) Then Return False
			if Not iuo_comum_vtex.of_grava_log_item(ll_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log) Then Return false
		Else
			// Se n$$HEX1$$e300$$ENDHEX$$o tiver log insere um novo com erro
			If IsNull(ll_Seq_Log) or ll_Seq_Log = 0 Then
				// Grava in$$HEX1$$ed00$$ENDHEX$$cio do processo - chave e mensagem est$$HEX1$$e300$$ENDHEX$$o indo como nulo
				If Not iuo_comum_vtex.of_grava_log(ll_cd_filial, il_cd_tipo, ls_Chave_Nula, 'E', ls_Log, ldh_Data_Nula, gf_getserverdate(), ref ls_Log, ref ll_Seq_Log ) Then Return False
			Else
				// Atualiza log com erro
				If Not iuo_comum_vtex.of_atualiza_ecommerce_log(ll_cd_filial, ll_Seq_Log, 'E', ls_Log, gf_getserverdate(), ref ls_Log) Then Return False
			End If		
		End If
	Else
		If ll_Linhas > 0 Then
			// Marca o log como processado
			If Not iuo_comum_vtex.of_atualiza_ecommerce_log(ll_cd_filial, ll_Seq_Log, ls_Situacao, ls_MSG_Nula, gf_getserverdate(), ref ls_Log) Then Return False
		End If
	End If
	
	iuo_comum_vtex.of_grava_log_historico(ref ls_id_registro_log, ll_cd_filial, il_cd_tipo, ldh_log_inicio, gf_getserverdate(), ls_situacao, ll_Seq_Log, ref ls_log )
	
	destroy(lds_dados)
	destroy(iuo_comum_vtex)
	
	Close(w_ge501_Aguarde)
	
End try

return true
end function

public function boolean of_valida_retorno_imagem (long pl_cd_produto, string ps_json, ref boolean pb_possui_imagem, ref string ps_log);string ls_url
long ll_cd_filial

uo_ge073_json luo_gera_json

Try
		
	luo_gera_json = Create uo_ge073_json 
	
	ls_url = luo_gera_json.of_busca_conteudo_campo_vtex(ps_json, 'ImageUrl')
	
	if isnull(ls_url) or ls_url = '' Then
		pb_possui_imagem = false
		return true
		
	else
		pb_possui_imagem = true
		
		update ecommerce_prd
		set id_possui_imagem = 'S', cd_url_imagem_produto = :ls_url, dh_atualizacao_imagem = getdate()
		where id_ecommerce = :is_id_ecommerce
		and id_rede_filial = :is_rede_ecommerce
		and cd_produto = :pl_cd_produto;
		
		if sqlca.sqlcode = -1 then
			ps_log = 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_valida_retorno_imagem; Problemas ao atualizar a tabela "ecommerce_prd": ' + sqlca.sqlerrtext
			return false
		end if
		
	end if

Finally
	Destroy(luo_gera_json)
End Try

return true
end function

public function boolean of_atualiza_prd_manipulado (ref string ps_log);Long ll_Linha
Long ll_Linhas
Long ll_Produto
Long ll_Req_Manip

String ls_SKu
String ls_Prd_Eco
STring ls_Descricao

Decimal ldc_Valor

try
	dc_uo_ds_base	lds 
	lds = Create dc_uo_ds_base
	
	If IsValid(w_Ge501_Aguarde) Then
		w_Ge501_Aguarde.st_msg.Text = 'Atual. PRD Manipulado [PRECO/IMAGEM/SALDO]'
	End If
	
	if not lds.of_changedataobject( 'ds_ge501_produto_manipulado', False ) Then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_produto_manipulado ~n' + 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ds_ge501_produto_manipulado'
		return false
	end if
	
	ll_Linhas = lds.Retrieve(is_id_ecommerce, is_rede_ecommerce )
	
	If ll_Linhas > 0 Then
		
		For ll_Linha = 1 To ll_Linhas
			
			ls_SKu 						= lds.Object.cd_sku							[ll_Linha]
			ls_Prd_Eco					= lds.Object.cd_produto_ecommerce		[ll_Linha]
			ldc_Valor						= lds.Object.vl_requisicao_manip			[ll_Linha]
			
			ll_Produto					= lds.Object.cd_produto						[ll_Linha] // Mesmo c$$HEX1$$f300$$ENDHEX$$diog da req s$$HEX1$$f300$$ENDHEX$$ que com valor negativo
			ll_Req_Manip				= lds.Object.nr_requisicao_manip			[ll_Linha]
			ls_Descricao					= lds.Object.de_descricao_manip			[ll_Linha]
			
			is_nome_imagem_manip	= lds.Object.de_nome_imagem_manip	[ll_Linha]
			is_url_imagem_manip 	= lds.Object.de_url_imagem_manip		[ll_Linha]
			
			idc_altura					= lds.Object.qt_altura_cm					[ll_Linha]
			idc_profundidade 			= lds.Object.qt_profundidade_cm			[ll_Linha]
			idc_largura 					= lds.Object.qt_largura_cm					[ll_Linha]
			idc_peso 					= lds.Object.qt_peso_grama				[ll_Linha]
		
			// NAVE M$$HEX1$$c300$$ENDHEX$$E		
			If Not This.of_atualiza_prd_manipulado_preco(ls_SKu, ldc_Valor, ref ps_Log) Then Return False
			
			If lds.Object.id_possui_imagem	[ll_Linha] = 'N' Then
				// NAVE M$$HEX1$$c300$$ENDHEX$$E		
				If Not This.of_atualiza_prd_manipulado_imagem(ll_Produto, ls_SKu, ref ps_Log) Then Return False
			End If
			
			// SELLER
			If Not This.of_atualiza_prd_manipulado_saldo_seller(ls_SKu, ll_Produto, ref ps_Log) Then Return False
			
			// NAVE M$$HEX1$$c300$$ENDHEX$$E		
			If Not This.of_atualiza_prd_manipulado_saldo_navemae(ls_SKu, ref ps_Log) Then Return False

			// NAVE M$$HEX1$$c300$$ENDHEX$$E		
			If Not This.of_atualiza_prd_manipulado_situacao(ll_Req_Manip, ls_SKu, ls_Prd_Eco, ls_Descricao, ref ps_Log) Then Return False
	
			Update ecommerce_prd
			Set dh_atualizacao_manip = GetDate(), qt_saldo = 1, dh_atualizacao_saldo = getdate()
			Where id_ecommerce 	= :is_id_ecommerce
				and id_rede_filial 		= :is_rede_ecommerce
				and cd_produto			= :ll_Produto
			Using SqlCa;
			
			if sqlca.sqlcode = -1 then
				ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_prd_manipulado ~n' + 'Problemas ao atualizar registro na tabela "ecommerce_prd": ~n' + sqlca.sqlerrtext
				return false
			end if			
		Next	
	
	ElseIf ll_Linhas  < 0 Then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_prd_manipulado ~n' + 'Erro ao recuperar os dados da ds_ge501_produto_manipulado'
		return false
	End If
	
	If IsValid(w_Ge501_Aguarde) Then
		w_Ge501_Aguarde.st_msg.Text = ""
	End If
	
finally
	Destroy lds
end try

Return True
end function

public function boolean of_atualiza_prd_manipulado_preco (string ps_sku, decimal pdc_valor_req, ref string ps_log);String ls_Json
String ls_retorno

Long ll_cd_filial

ls_Json = 	'{ ' + &
				'"listPrice": ' + gf_valor_com_ponto(pdc_valor_req) + ', ' + &
				'"costPrice": ' + gf_valor_com_ponto(pdc_valor_req) + ', ' + &
				'"basePrice": ' + gf_valor_com_ponto(pdc_valor_req) + &
				'}'

If IsNull(ls_Json) and Trim(ls_Json) <> '' Then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_prd_manipulado_preco ~n' + 'Json  nulo ou vazio - SKU: ' + ps_sku
	return false
End IF

try
	uo_ge501_comum luo_comum_vtex
	luo_comum_vtex = create uo_ge501_comum
	
	//Carrega os parametros e busca o c$$HEX1$$f300$$ENDHEX$$digo da filial vinculado a rede.
	if Not luo_comum_vtex.of_parametros_ecommerce(is_id_ecommerce, is_rede_ecommerce, ref ll_cd_filial, ref ps_log ) Then return false
	
	//Envia os dados de pre$$HEX1$$e700$$ENDHEX$$o para o site.
	luo_comum_vtex.of_put( ls_json, '/api/pricing/prices' + '/' + ps_sku , ref ls_retorno, ref ps_log ) 
	
	If ps_log <> '' and not isnull(ps_log) Then Return False
finally
	Destroy luo_comum_vtex
end try

Return True
end function

public function boolean of_atualiza_prd_manipulado_imagem (long pl_produto, string ps_sku, ref string ps_log);String ls_Json
String ls_retorno

Long ll_cd_filial

is_url_imagem_manip = "https://drogariacatarinense.vteximg.com.br" + is_url_imagem_manip

ls_Json ='{ ' + &
			'"IsMain": true, ' + &
			'"Label": "", ' + &
			'"Name": "' + is_nome_imagem_manip + '" , ' + &
			'"Text": null, ' + &
			'"Url": "' + is_url_imagem_manip + '"' + & 
			'}'

If IsNull(ls_Json) and Trim(ls_Json) <> '' Then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_prd_manipulado_imagem ~n' + 'Json  nulo ou vazio - SKU: ' + ps_sku
	return false
End IF

try
	uo_ge501_comum luo_comum_vtex
	luo_comum_vtex = create uo_ge501_comum
	
	//Carrega os parametros e busca o c$$HEX1$$f300$$ENDHEX$$digo da filial vinculado a rede.
	if Not luo_comum_vtex.of_parametros_ecommerce(is_id_ecommerce, is_rede_ecommerce, ref ll_cd_filial, ref ps_log ) Then return false
	
	//Envia a imagem nova para o site.
	luo_comum_vtex.of_post( ls_json, '/api/catalog/pvt/stockkeepingunit/' + ps_sku + '/file', ref ls_retorno, ref ps_log ) 
	
	If ps_log <> '' and not isnull(ps_log) Then Return False
	
	update ecommerce_prd
	set id_possui_imagem = 'S', cd_url_imagem_produto =:is_url_imagem_manip, dh_atualizacao_imagem = getdate()
	where id_ecommerce = :is_id_ecommerce
		and id_rede_filial = :is_rede_ecommerce
		and cd_produto = :pl_produto
	Using sqlca;		
					
	if sqlca.sqlcode = -1 then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_prd_manipulado_preco_imagem~nProblemas ao atualizar imagem: ~n' + sqlca.sqlerrtext
		return false
	end if	
	
finally
	Destroy luo_comum_vtex
end try

Return True
end function

public function boolean of_atualiza_prd_manipulado_situacao (long pl_produto, string ps_sku, string ps_prd_ecommerce, string ps_descricao, ref string ps_log);String ls_Json
String ls_retorno

Long ll_cd_filial

is_Manipulado = 'S'

if Not this.of_monta_json( pl_produto, ps_sku, ps_prd_ecommerce, ps_descricao, true, ref ls_json, ref ps_log) Then return false

try
	uo_ge501_comum luo_comum_vtex
	luo_comum_vtex = create uo_ge501_comum
	
	//Carrega os parametros e busca o c$$HEX1$$f300$$ENDHEX$$digo da filial vinculado a rede.
	if Not luo_comum_vtex.of_parametros_ecommerce(is_id_ecommerce, is_rede_ecommerce, ref ll_cd_filial, ref ps_log ) Then return false
	
	if not luo_comum_vtex.of_put( ls_json, is_id_interface + '/' + ps_sku , ref ls_retorno, ref ps_log ) Then return false
			
	If ps_log <> '' and not isnull(ps_log) Then Return False
finally
	Destroy luo_comum_vtex
end try

Return True
end function

public function boolean of_atualiza_prd_manipulado_saldo_navemae (string ps_sku, ref string ps_log);String ls_Json
String ls_retorno

Long ll_Filial

ls_Json = 	'{ ' + &
				'"unlimitedQuantity": false, ' + &
				'"dateUtcOnBalanceSystem": null, ' + &
				'"quantity": 1' + &
				'}'
				
If IsNull(ls_Json) and Trim(ls_Json) <> '' Then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_prd_manipulado_saldo ~n' + 'Json  nulo ou vazio - SKU: ' + ps_sku
	return false
End IF

try
	uo_ge501_comum luo_comum_vtex
	luo_comum_vtex = create uo_ge501_comum

	//Carrega os parametros e busca o c$$HEX1$$f300$$ENDHEX$$digo da filial vinculado a rede.
	if Not luo_comum_vtex.of_parametros_ecommerce(is_id_ecommerce, is_rede_ecommerce, ref ll_Filial, ref ps_log ) Then return false
	
	if Not This.of_busca_warehouseid( ref luo_comum_vtex.is_warehouseid , ll_Filial, ref ps_log ) Then return false

	//Envia os dados de saldo para o site.
	luo_comum_vtex.of_put( ls_json, 'api/logistics/pvt/inventory/skus/' + ps_sku + '/warehouses/' + luo_comum_vtex.is_warehouseid , ref ls_retorno, ref ps_log ) 
	
	If ps_log <> '' and not isnull(ps_log) Then Return False
finally
	Destroy luo_comum_vtex
end try

Return True
end function

public function boolean of_atualiza_prd_manipulado_saldo_seller (string ps_sku, long pl_produto, ref string ps_log);String ls_Json
String ls_retorno
Long ll_existe

ls_Json = 	'{ ' + &
				'"unlimitedQuantity": false, ' + &
				'"dateUtcOnBalanceSystem": null, ' + &
				'"quantity": 1' + &
				'}'
				
If IsNull(ls_Json) and Trim(ls_Json) <> '' Then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_prd_manipulado_saldo ~n' + 'Json  nulo ou vazio - SKU: ' + ps_sku
	return false
End IF

try
	uo_ge501_comum luo_comum_vtex
	luo_comum_vtex = create uo_ge501_comum
	
	//Carrega os parametros e busca o c$$HEX1$$f300$$ENDHEX$$digo da filial vinculado a rede.
	if Not luo_comum_vtex.of_parametros_ecommerce_filial( il_seller_manip, is_rede_ecommerce, is_id_ecommerce, ref ps_log ) then return false

	//Envia os dados de saldo para o site.
	luo_comum_vtex.of_put( ls_json, 'api/logistics/pvt/inventory/skus/' + ps_sku + '/warehouses/' + luo_comum_vtex.is_warehouseid , ref ls_retorno, ref ps_log ) 
	
	If ps_log <> '' and not isnull(ps_log) Then Return False
	
	Select cd_produto
	into :ll_existe
	from ecommerce_prd_filial
	where id_ecommerce	= :is_id_ecommerce
		and id_rede_filial 	= :is_rede_ecommerce
		and cd_produto 	= :pl_produto
		and cd_filial 		= :il_seller_manip
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
	Case 0
		
		Update ecommerce_prd_filial
		set qt_saldo = 1, dh_atualizacao = getdate(), qt_saldo_pendente =0, qt_saldo_transferencia =0, qt_saldo_filial =1, dh_busca_saldo_loja = getdate()
		where id_ecommerce	= :is_id_ecommerce
			and id_rede_filial 	= :is_rede_ecommerce
			and cd_produto 	= :pl_produto
			and cd_filial 		= :il_seller_manip
		Using SqlCa;

		if sqlca.sqlcode = -1 then 
			ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_prd_manipulado_saldo_seller ~n' + 'Problemas ao atualizar registro na tabela "ecommerce_prd_filial": ~n' + sqlca.sqlerrtext
			return false
		end if
		
	Case 100
	
		insert into ecommerce_prd_filial(id_ecommerce, id_rede_filial, cd_produto, cd_filial, qt_saldo, dh_atualizacao, qt_saldo_pendente, qt_saldo_transferencia, qt_saldo_filial, dh_busca_saldo_loja)
		values (:is_id_ecommerce, :is_rede_ecommerce, :pl_produto, :il_seller_manip, 1, getdate(), 0, 0, 1, getdate() )
		Using SqlCa;
				
		if sqlca.sqlcode = -1 then 
			ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_ecommerce_prd_filial ~n' + 'Problemas ao inserir registro na tabela "ecommerce_prd_filial": ~n' + sqlca.sqlerrtext
			return false
		end if
		
	Case -1 
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_ecommerce_prd_filial ~n' + 'Problemas ao consultar a tabela "ecommerce_prd_filial": ~n' + sqlca.sqlerrtext
		return false
	End Choose
	
	
	
finally
	Destroy luo_comum_vtex
end try

Return True
end function

public function boolean of_busca_warehouseid (ref string ps_warehouseid, long pl_filial, ref string ps_log);string ls_retorno

select cd_warehouseid
into :ls_retorno
from ecommerce_rede_filial
where cd_filial = :pl_filial
and id_ecommerce = :is_id_ecommerce
and id_rede_filial = :is_rede_ecommerce;

if sqlca.sqlcode = -1 Then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_busca_warehouseid ~n' + 'Problemas ao consultar a tabela "ecommerce_rede_filial": ' + sqlca.sqlerrtext
	return false
end if

ps_warehouseid = ls_retorno

return true
end function

private function string of_formata_descricao (long pl_tipo, string ps_ds_marca, long pl_produto);string ls_resultado

//Trata as aspas
ps_ds_marca = gf_replace(ps_ds_marca,'"','&quot;',0)

Choose Case pl_tipo
	Case 1
		ls_resultado = wordcap(ps_ds_marca)
		
		If is_manipulado = 'S' Then
			ls_resultado =  "(OR" + String(pl_produto) + ") " + ls_resultado
		End If
		
	Case 2
		ls_resultado = wordcap(ps_ds_marca)
		
		If is_manipulado = 'S' Then
			ls_resultado =  "(OR" + String(pl_produto) + ") " + ls_resultado
		End If
		
		ls_resultado = gf_replace(ls_resultado, ' ', '-', 0)
	Case 3
		ls_resultado = lower(ps_ds_marca)
	Case else
		ls_resultado = ps_ds_marca
End Choose

return ls_resultado
end function

public function boolean of_atualiza_prd_ean (string ps_rede_filial, ref string ps_log);string ls_cd_sku, ls_retorno
long ll_for, ll_cd_produto, ll_cd_filial, ll_linhas
dc_uo_ds_base lds_dados
uo_ge501_comum luo_comum_vtex

Try

	Open(w_ge501_Aguarde)
	
	luo_comum_vtex = create uo_ge501_comum
	
	iuo_Produto = create uo_produto
	
	lds_dados = create dc_uo_ds_base
	
	if not lds_dados.of_changedataobject( 'ds_ge501_sku_ean', False ) Then
		ps_Log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_sku ~n' + 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ds_ge501_sku_log'
		return false
	end if
	
	//Carrega os parametros e busca o c$$HEX1$$f300$$ENDHEX$$digo da filial vinculado a rede.
	if Not luo_comum_vtex.of_parametros_ecommerce(is_id_ecommerce, ps_rede_filial, ref ll_cd_filial, ref ps_Log ) Then return false

	
	ll_linhas = lds_dados.retrieve( ps_rede_filial )
	w_ge501_Aguarde.uo_progress.of_setmax(ll_Linhas)
	for ll_for = 1 to ll_linhas
		
		w_ge501_Aguarde.Title = "VTEX - [SKU EAN] - [" + ps_rede_filial +  "] - "  + String(ll_for)  + " de " + STring(ll_Linhas)
		
		is_ean = ''
		
		ls_cd_sku = lds_dados.object.cd_sku[ll_for]
		ll_cd_produto = lds_dados.object.cd_produto[ll_for]
		
		iuo_Produto.of_Localiza_Codigo_Interno(ll_cd_Produto)
		
		is_ean = iuo_produto.de_codigo_barras
		
		//Cadastra o EAN
		if is_ean <> '' and not isnull(is_ean) Then
			if not luo_comum_vtex.of_post( '', is_id_interface + '/' + ls_cd_sku + '/ean/' + is_ean, ref ls_retorno, ref ps_Log ) Then
				w_ge501_Aguarde.uo_progress.of_setprogress(ll_for)
				Continue
			end if
		end if

		w_ge501_Aguarde.uo_progress.of_setprogress(ll_for)

	Next
Finally
	close(w_ge501_Aguarde)
End Try

return true
end function

public function boolean of_processar_assinatura (string ps_id_permitir_assinatura, string ps_cd_sku, ref string ps_log);string ls_json_assinatura
string ls_json_anexos
string ls_info_anexo
string ls_retorno
string ls_nome_assinatura = ''
string ls_json
string ls_id_ass_sku
string ls_id_vinculado
long ll_cd_filial

boolean lb_sku_ass_vinculada = false

uo_ge073_json luo_json

Try
	
	luo_json = create uo_ge073_json
	
//	if not isvalid(iuo_comum_vtex) then 
//		iuo_comum_vtex = create uo_ge501_comum
//		
//		if not iuo_comum_vtex.of_parametros_ecommerce( '2', 'DC', ref ll_cd_filial, ref ps_log ) then return false
//	End if
	
	if is_id_assinatura = '' or isnull(is_id_assinatura) Then
	
		if not iuo_comum_vtex.of_get( is_id_interface_anexo , ref ls_json_anexos, ref ps_Log ) Then return false
		
		
		Do While luo_json.of_divide_grupo_json_tag_vtex(ref ls_json_anexos, 'Id', ref ls_retorno, ']}')
		
			ls_info_anexo = '"Id"' + ls_retorno
		
		
			ls_nome_assinatura = luo_json.of_busca_conteudo_campo_vtex( ls_info_anexo, 'Name')
			
			if ls_nome_assinatura = 'vtex.subscription.assinatura' then
			
				is_id_assinatura = luo_json.of_busca_conteudo_campo_vtex( ls_info_anexo, 'Id')
				
			End if
			
		Loop
		
	ENd if
	
	ls_json_assinatura = ''
	ls_retorno = ''
	
	if is_id_assinatura <> '' and not isnull(is_id_assinatura) then
	
		
		if not iuo_comum_vtex.of_get( is_id_interface + '/' + ps_cd_sku + '/attachment' , ref ls_json_assinatura, ref ps_Log ) Then return false
		
		
		Do While luo_json.of_divide_grupo_json_completo( ref ls_json_assinatura, ref ls_retorno, '{')
			
			ls_id_ass_sku = luo_json.of_busca_conteudo_campo_vtex( ls_retorno, 'AttachmentId')
			
			if ls_id_ass_sku = is_id_assinatura then
				ls_id_vinculado = luo_json.of_busca_conteudo_campo_vtex( ls_retorno, 'Id')
				
				lb_sku_ass_vinculada = True
				exit
			End if
	
		Loop
		
		ls_json = '{"AttachmentId": ' + is_id_assinatura + ', "SkuId": ' + ps_cd_sku + '}'
		
		if ps_id_permitir_assinatura = 'S' and lb_sku_ass_vinculada = false then
			//Vincular assinatura ao SKU:
			if not iuo_comum_vtex.of_post( ls_json, is_id_interface_sku_anexo , ref ls_retorno, ref ps_Log ) Then return false
			
		Elseif ps_id_permitir_assinatura = 'N' and lb_sku_ass_vinculada = True then
			//Desvincular assinatura do SKU:
			if not iuo_comum_vtex.of_delete( '', is_id_interface_sku_anexo + '/' + ls_id_vinculado , ref ls_retorno, ref ps_log) Then return false
			
		End if

	End if

Finally
	if ps_log <> '' and not isnull(ps_log) then ps_log = 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processar_assinatura; ' + ps_log
End Try

return true
end function

public function boolean of_carga_assinatura (string ps_rede, ref string ps_log);String ls_cd_sku, ls_id_assinatura
long ll_linhas, ll_linha, ll_cd_filial

try
	
	dc_uo_ds_base	lds 
	lds = Create dc_uo_ds_base
	
	Open(w_Ge501_Aguarde)
	
	w_ge501_Aguarde.Title = "VTEX - Carga Assinatura - " + ps_rede
	
	if not lds.of_changedataobject( 'ds_ge501_sku_carga_assinatura', False ) Then
		ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ds_ge501_sku_carga_assinatura'
		return false
	end if
	
	if not isvalid(iuo_comum_vtex) then 
		iuo_comum_vtex = create uo_ge501_comum
		
		if not iuo_comum_vtex.of_parametros_ecommerce( '2', ps_rede, ref ll_cd_filial, ref ps_log ) then return false
	End if
	
	ll_Linhas = lds.Retrieve(is_id_ecommerce, ps_rede )
	
	If ll_Linhas > 0 Then
		
		w_ge501_Aguarde.uo_progress.of_setmax(ll_Linhas)
		
		For ll_Linha = 1 To ll_Linhas
			
			ls_cd_sku = lds.object.cd_sku[ll_linha]
			ls_id_assinatura = lds.object.id_permitir_assinatura[ll_linha]
			
			if Not this.of_processar_assinatura( ls_id_assinatura, ls_cd_sku, ref ps_log) then return false
			
			w_ge501_Aguarde.uo_progress.of_setprogress(ll_linha)
		Next
		
	ENd if

Finally
	Close(w_ge501_Aguarde)
End Try

return true
end function

on uo_ge501_sku.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge501_sku.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;is_objeto = 'Objeto: ' + this.classname() + '~n'
end event

