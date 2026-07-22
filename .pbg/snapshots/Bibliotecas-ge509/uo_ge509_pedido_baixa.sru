HA$PBExportHeader$uo_ge509_pedido_baixa.sru
forward
global type uo_ge509_pedido_baixa from uo_ge516_comum_interface_ecommerce
end type
end forward

global type uo_ge509_pedido_baixa from uo_ge516_comum_interface_ecommerce
boolean ib_grava_log_historico = true
string is_id_ecommerce = "5"
string is_id_interface = "api/v1/store/orders"
long il_cd_tipo = 8
string is_datastore_dados = "ds_ge509_pedido_baixa"
string is_objeto_comum = "uo_ge509_comum_consulta_remedio"
long il_cd_mensagem_email = 289
string is_mensagem_email_1 = "PEDIDO_BAIXA"
end type
global uo_ge509_pedido_baixa uo_ge509_pedido_baixa

type variables
dc_uo_ds_base ids_produtos

decimal{2} idc_vl_frete, idc_vl_total, idc_subtotal, idc_desconto, idc_subtotal_pedido

string is_nr_pedido_ecommerce
string is_id_situacao
string is_nm_transportadora
string is_de_email
string is_nm_cliente
string is_nr_cpf
string is_nr_fone
string is_nm_destinatario
string is_de_logradouro
string is_nr_logradouro
string is_de_bairro
string is_de_complemento
string is_de_cidade
string is_nr_cep
string is_nr_fone_entraga
string is_de_motivo_cancel
string is_cd_uf
string is_fisica_juridica
string is_sexo
string is_de_referencia
string is_regiao
string is_tipo_pgto
string is_forma_pagto
string is_Exige_NFSE
string is_id_tipo_entrega

datetime idh_compra
datetime idh_DataNascimento

long il_nr_pedido
long il_cd_cliente
long il_cd_tipo_entrega
long il_Pagamento
long il_cd_filial_ecommerce

integer ii_prazo_entrega

end variables

forward prototypes
private function boolean of_carrega_dados (ref long pl_linhas, ref string ps_log)
private function boolean of_processa_interface_itens (long pl_linha, ref boolean pb_gerar_log, ref string ps_log)
public function boolean of_grava_pedido (ref string ps_log)
public function boolean of_busca_dados_cliente (string ps_cpf, ref string ps_tipo, ref string ps_sexo, ref datetime pdh_nascimento, ref string ps_log)
public function boolean of_busca_transportadora (string ps_nm_transportadora, ref string ps_log)
public function boolean of_grava_produtos (ref string ps_log)
public function boolean of_carrega_dados_consulta_remedios (ref long pl_linhas, ref string ps_log)
public function boolean of_carrega_dados_farmacias_app (ref long pl_linhas, ref string ps_log)
public function boolean of_configurar_consulta_remedios ()
public function boolean of_configurar_farmacias_app ()
public subroutine of_configurar_parametros ()
public function boolean of_aprovar_pedido (ref string ps_log)
public function boolean of_valida_pedido (ref string ps_log)
public function boolean of_busca_filial_ecommerce (long pl_cd_filial, string ps_rede, ref long pl_cd_filial_ecommerce, ref string ps_log)
public subroutine of_limpa_variaveis ()
public function boolean of_busca_produto (string ps_cod_barra, ref long pl_cd_produto, ref string ps_log)
public function boolean of_carrega_pedido (string ps_nr_pedido, ref string ps_log)
end prototypes

private function boolean of_carrega_dados (ref long pl_linhas, ref string ps_log);Choose Case is_id_ecommerce
		
	Case '5'
		
		return this.of_carrega_dados_consulta_remedios( ref pl_linhas, ref ps_log )
		
	Case '6'
		
		return this.of_carrega_dados_farmacias_app( ref pl_linhas, ref ps_log )
		
ENd Choose
end function

private function boolean of_processa_interface_itens (long pl_linha, ref boolean pb_gerar_log, ref string ps_log);string ls_cliente_nome, ls_cliente_sobrenome, ls_destinatario_nome, ls_destinatario_sobrenome, ls_id_situacao_entrega
string ls_id_situacao_pagamento
string ls_nm_transportadora

decimal{2} ldc_vl_frete_desconto

Try
	
	is_nr_pedido_ecommerce = ids_dados.object.nr_pedido_ecommerce[pl_linha]
	idh_compra = ids_dados.object.dh_compra[pl_linha]
	idc_vl_total = ids_dados.object.vl_total[pl_linha]
	idc_subtotal_pedido = ids_dados.object.vl_subtotal[pl_linha]
	is_id_situacao = ids_dados.object.id_situacao[pl_linha]
	ls_id_situacao_entrega = ids_dados.object.id_situacao_entrega[pl_linha]
	ls_id_situacao_pagamento = ids_dados.object.id_situacao_pagamento[pl_linha]
	idc_vl_frete = ids_dados.object.vl_frete[pl_linha]
	ldc_vl_frete_desconto = ids_dados.object.vl_frete_desconto[pl_linha]
	ls_nm_transportadora = ids_dados.object.nm_transportadora[pl_linha]
	is_de_email = ids_dados.object.de_email[pl_linha]
	idc_Desconto = ids_dados.object.vl_desconto[pl_linha]
	
	ls_cliente_nome = upper(ids_dados.object.de_cliente_nome[pl_linha])
	ls_cliente_sobrenome = upper(ids_dados.object.de_cliente_sobrenome[pl_linha])
	
	is_nm_cliente = trim(ls_cliente_nome) + ' ' + trim(ls_cliente_sobrenome)
	is_nm_cliente = gf_retira_acentos(is_nm_cliente)
	is_nm_cliente = gf_remove_caracteres_especiais(is_nm_cliente)
	
	is_nr_cpf = ids_dados.object.nr_cpf[pl_linha]
	is_nr_fone = ids_dados.object.nr_fone[pl_linha]
	
	ls_destinatario_nome = upper(ids_dados.object.de_nome_entrega[pl_linha])
	ls_destinatario_sobrenome = upper(ids_dados.object.de_sobrenome_entrega[pl_linha])
	
	is_nm_destinatario = trim(ls_destinatario_nome) + ' ' + trim(ls_destinatario_sobrenome)
	is_nm_destinatario = gf_retira_acentos(is_nm_destinatario)
	is_nm_destinatario = gf_remove_caracteres_especiais(is_nm_destinatario)
	
	is_de_logradouro = upper(ids_dados.object.de_logradouro[pl_linha])
	is_nr_logradouro = ids_dados.object.nr_logradouro[pl_linha]
	is_de_bairro = upper(ids_dados.object.de_bairro[pl_linha])
	
	is_de_complemento = upper(ids_dados.object.de_complemento[pl_linha])
	is_de_complemento = left(is_de_complemento,60)
	
	is_de_cidade = upper(ids_dados.object.de_cidade[pl_linha])
	is_cd_uf = ids_dados.object.cd_uf[pl_linha]
	is_nr_cep = ids_dados.object.nr_cep[pl_linha]
	is_nr_fone_entraga = ids_dados.object.nr_fone_entrega[pl_linha]
	is_de_motivo_cancel = upper(ids_dados.object.de_motivo_cancel[pl_linha])
	
	is_de_referencia = upper(ids_dados.object.de_referencia[pl_linha])
	is_de_referencia = left(is_de_referencia,60)
	
	if ldc_vl_frete_desconto > 0 Then
		idc_vl_frete = idc_vl_frete - ldc_vl_frete_desconto
	End if
	
	if idc_vl_frete < 0 then idc_vl_frete = 0
	
	if idc_desconto > 0 then
		idc_desconto = idc_desconto - ldc_vl_frete_desconto
	End if
	
	w_Aguarde_3.wf_settext('Filial: ' + string(il_cd_filial) + ' (' + is_rede_filial + ')' , 1)
	w_Aguarde_3.wf_settext('Pedido: ' + is_nr_pedido_ecommerce + ' (' + string(pl_linha) + ' de ' + string(ids_dados.rowcount()) + ')' , 2)
	
	iuo_comum.is_nr_pedido_ecommerce = is_nr_pedido_ecommerce
	iuo_comum.il_cd_filial_pedido = iuo_comum.il_cd_filial_hub

	//Verifica se o pedido j$$HEX1$$e100$$ENDHEX$$ existe no banco de dados. Se ja existir, passa para o proximo.
	if Not gf_valida_pedido_ecommerce(sqlca, is_nr_pedido_ecommerce, is_id_ecommerce, false, ref ps_log ) Then
		ps_log = ''
		return true
	End if

	if not this.of_busca_dados_cliente( is_nr_cpf, ref is_fisica_juridica, ref is_sexo, ref idh_DataNascimento, ref ps_log ) then return false
	
	if Not this.of_busca_transportadora( ls_nm_transportadora, ref ps_log ) then return false
	
	ii_prazo_entrega = 0
	is_regiao = string(iuo_comum.il_cd_filial_hub)
	
	idc_subtotal = 0
	
	setnull(is_tipo_pgto)
	setnull(is_forma_pagto)
	setnull(il_Pagamento)
	
	if ib_modo_Desenv = True then
		//Se estiver executando em modo desenolvimento a situa$$HEX2$$e700e300$$ENDHEX$$o fica sempre como A
		is_id_situacao = 'A'
	
	Else
		
	  Choose Case is_id_situacao
		Case 'confirmed', 'preparing'
			
			if ls_id_situacao_pagamento = 'paid' Then
				is_id_situacao = 'A'
			Else
				ps_log = 'Pagamento n$$HEX1$$e300$$ENDHEX$$o aprovado: ' + ls_id_situacao_pagamento
				return false
			End if
			
		Case Else
			ps_log = 'Pedido com status inv$$HEX1$$e100$$ENDHEX$$ilido: ' + is_id_situacao
			return false
		End Choose
		
	ENd if
	
 	if Not this.of_busca_filial_ecommerce( iuo_comum.il_cd_filial_hub, is_rede_filial , ref il_cd_filial_ecommerce, ref ps_log) Then return false
 
	if Not this.of_grava_pedido( ref ps_log ) Then return false
	
	if Not this.of_grava_produtos( ref ps_log ) Then return false
	
	If Not this.of_valida_pedido( ref ps_log ) Then return false
	
//	if ls_id_situacao_entrega = 'pending' Then
//	
//		if Not this.of_aprovar_pedido( ref ps_log ) Then return false
//		
//	ENd if
	
Finally

	if ps_log <> '' and not isnull(ps_log) Then ps_log = 'Objeto: ' + is_objeto + '; Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_interface_itens; ' + ps_log

End Try


return true
end function

public function boolean of_grava_pedido (ref string ps_log);long ll_existe
long ll_nr_pedido
long ll_cd_filial_loja

string ls_erro

Try

	if il_filial_desenv > 0 then
		ll_cd_filial_loja = il_filial_desenv
	else
		ll_cd_filial_loja = iuo_comum.il_cd_filial_hub
	ENd if
	
	Declare sp_pedido Procedure for sp_proximo_pedido_ecommerce
		@proximo_sequencial_retorno  = :ll_nr_pedido OUTPUT,
		@mensagem_retorno = :ls_erro OUTPUT
	USING SQLCA;
				
	Execute sp_pedido;
	
	If SQLCA.sqlcode = -1 then 
		ps_log = 'Erro ao executar a procedure "sp_proximo_pedido_ecommerce": ~n' + SQLCA.sqlerrtext 
		return false
	end if
	
	Fetch sp_pedido Into :ll_nr_pedido, :ls_erro;
	
	Close sp_pedido;
	
	if ls_erro <> '' and not isnull(ls_erro) Then
		ps_log = 'Erro ao executar a procedure "sp_proximo_pedido_ecommerce": ~n' + ls_erro
		return false
	end if

	il_nr_pedido = ll_nr_pedido

	INSERT INTO pedido_ecommerce  
			 ( cd_filial_ecommerce,
				nr_pedido,   
				nr_pedido_ecommerce,
				dh_compra,   
				dh_atualizacao,   
				id_situacao,   
				cd_cliente,   
				nm_cliente,   
				de_endereco_email,   
				nr_cpf_cgc,    
				id_fisica_juridica,   
				id_sexo,   
				dh_nascimento,     
				nr_fone,     
				nm_cliente_ent,   
				de_endereco_ent,   
				nr_endereco_ent,   
				de_complemento_ent,   
				de_bairro_ent,   
				de_cidade_ent,   
				cd_uf_ent,   
				nr_cep_ent,   
				de_referencia_ent,   
				de_pais_ent,   
				nr_fone_ent,       
				nm_transportadora,   
				cd_tipo_entrega,
				nr_prazo_entrega,   
				nm_regiao_entrega,   
				vl_subtotal,   
				vl_frete,   
				vl_desconto,      
				vl_total,   
				vl_indexador,   
				cd_boleto_parcelado,   
				cd_tipo_pagamento,   
				cd_forma_pagamento,   
				cd_filial,
				nr_pedido_drogaexpress,
				dh_inclusao,
				id_pagamento,
				id_ecommerce)  
	VALUES ( :il_cd_filial_ecommerce, 	//cd_filial_ecommerce
				:ll_nr_pedido, 		      			//nr_pedido,  
				:is_nr_pedido_ecommerce,
				:idh_compra, 					//dh_compra,   
				getdate(),				//dh_atualizacao,   
				:is_id_situacao,					//id_situacao,   
				:il_cd_cliente, 						//cd_cliente,   
				:is_nm_cliente,						//nm_cliente,   
				:is_de_email,						//de_endereco_email,   
				:is_nr_cpf,						//nr_cpf_cgc,   
				:is_fisica_juridica, 				//id_fisica_juridica,   
				:is_sexo,							//id_sexo,   
				:idh_DataNascimento,			//dh_nascimento,   
				:is_nr_fone,							//nr_fone,     
				:is_nm_destinatario,					//nm_cliente_ent,   
				:is_de_logradouro,				//de_endereco_ent,   
				:is_nr_logradouro,				//nr_endereco_ent,   
				:is_de_complemento,		//de_complemento_ent,   
				:is_de_bairro,					//de_bairro_ent,   
				:is_de_cidade,					//de_cidade_ent,   
				:is_cd_uf,						//cd_uf_ent,   
				:is_nr_cep,						//nr_cep_ent,   
				:is_de_referencia,			//de_referencia_ent,   
				'BRA',					//de_pais_ent,   
				:is_nr_fone_entraga,					//nr_fone_ent,    
				:is_nm_transportadora,			//nm_transportadora,   
				:il_cd_tipo_entrega,
				:ii_prazo_entrega,				//nr_prazo_entrega,   
				:is_regiao,						//nm_regiao_entrega,   
				:idc_subtotal,					//vl_subtotal,     
				:idc_vl_frete,						//vl_frete,   
				:idc_Desconto,					//vl_desconto,   
				:idc_vl_Total,						//vl_total,   
				0,					//vl_indexador,   
				0,			//cd_boleto_parcelado,   
				:is_tipo_pgto,					//cd_tipo_pagamento,   
				:is_forma_pagto,				//cd_forma_pagamento,   
				:ll_cd_filial_loja,				//cd_filial
				null, 								//nr_pedido_drogaexpress
				getdate(),							//dh_inclusao
				:il_Pagamento,					//id_pagamento	
				:is_id_ecommerce)
	Using SqlCa;


	If SqlCa.SqlCode = -1 Then
		ps_log = 'Erro ao inserir registro na tabela "pedido_ecommerce": ~n' + SqlCa.sqlerrtext 
		return false
	end if

Insert into pedido_ecommerce_auxiliar(cd_filial_ecommerce, nr_pedido, id_cpf_nf, id_rede_ecommerce, de_canal_venda_diretoria)
values(:il_cd_filial_ecommerce, :ll_nr_pedido, 'N', :is_rede_filial, 'CR' );
	
If SqlCa.SqlCode = -1 Then
	ps_log = 'Erro ao inserir registro na tabela "pedido_ecommerce_auxiliar": ' + SqlCa.sqlerrtext 
	return false
end if			

Insert into pedido_ecommerce_endereco( cd_filial_ecommerce,   
															nr_pedido,   
															cd_tipo_endereco,   
															de_endereco,   
															nr_endereco,   
															de_complemento,   
															de_bairro,   
															de_cidade,   
															cd_uf,   
															nr_cep,   
															de_pais,
															de_referencia_ent)
Values ( :il_cd_filial_ecommerce, :ll_nr_pedido, 1,
			:is_de_logradouro, :is_nr_logradouro, :is_de_complemento, :is_de_bairro, :is_de_cidade, :is_cd_uf, :is_nr_cep, 'BRA', :is_de_referencia);
	
If SqlCa.SqlCode = -1 Then
	ps_log = 'Erro ao inserir registro na tabela "pedido_ecommerce_endereco"[1]: ' + SqlCa.sqlerrtext 
	return false
end if	
//	
Insert into pedido_ecommerce_endereco( cd_filial_ecommerce,   
															nr_pedido,   
															cd_tipo_endereco,   
															de_endereco,   
															nr_endereco,   
															de_complemento,   
															de_bairro,   
															de_cidade,   
															cd_uf,   
															nr_cep,   
															de_pais,
															de_referencia_ent)
Values ( :il_cd_filial_ecommerce, :ll_nr_pedido, 2,
			:is_de_logradouro, :is_nr_logradouro, :is_de_complemento, :is_de_bairro, :is_de_cidade, :is_cd_uf, :is_nr_cep, 'BRA', :is_de_referencia);
	
If SqlCa.SqlCode = -1 Then
	ps_log = 'Erro ao inserir registro na tabela "pedido_ecommerce_endereco"[2]: ' + SqlCa.sqlerrtext 
	return false
end if	

Finally
	if ps_log <> '' and not isnull(ps_log) Then ps_log = 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_pedido;' + ps_log
End Try	
	
return true

end function

public function boolean of_busca_dados_cliente (string ps_cpf, ref string ps_tipo, ref string ps_sexo, ref datetime pdh_nascimento, ref string ps_log);

select id_fisica_juridica , dh_nascimento, id_sexo 
into :ps_tipo, :pdh_nascimento, :ps_sexo
from cliente where nr_cpf_cgc = :ps_cpf;

if sqlca.sqlcode = -1 then
	ps_log = 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_busca_dados_cliente; Problemas ao consultar a tabela cliente: ' + sqlca.sqlerrtext
	return false
end if

return true
end function

public function boolean of_busca_transportadora (string ps_nm_transportadora, ref string ps_log);string ls_id_situacao
string ls_Disque

ps_nm_transportadora = Upper(ps_nm_transportadora)

If ps_nm_transportadora = 'CORREIO PAC' Then ps_nm_transportadora = 'CORREIOS PAC'

Select cd_tipo_entrega, de_tipo_entrega, id_situacao, id_tipo_entrega, id_exige_nfse
into :il_cd_tipo_entrega, :is_nm_transportadora, :ls_id_situacao, :is_id_tipo_entrega, :is_Exige_NFSE
from tipo_entrega_ecommerce
where de_tipo_entrega_site = :ps_nm_transportadora;

if sqlca.sqlcode = -1 then 
	ps_log = 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_busca_transportadora. ' + 'Problemas ao consultar a tabela "tipo_entrega_ecommerce": ' + sqlca.sqlerrtext
	return false
end if

if il_cd_tipo_entrega = 0 or isnull(il_cd_tipo_entrega) Then
	ps_log = 'Transportadora n$$HEX1$$e300$$ENDHEX$$o mapeada: ' + ps_nm_transportadora
	return false
end if

if ls_id_situacao = 'I' Then
	ps_log = 'Transportadora com situa$$HEX2$$e700e300$$ENDHEX$$o inativa: ' + is_nm_transportadora
	return false
end if

If (is_id_tipo_entrega = 'MOT' ) and iuo_comum.il_cd_filial_hub <> 454 Then
			
	Select coalesce(vl_parametro, 'N')
	Into :ls_Disque
	from parametro_loja
	where cd_filial = :iuo_comum.il_cd_filial_hub
	  and cd_parametro = 'ID_DISQUE_ENTREGA'
    Using SqlCa;
	
	if sqlca.sqlcode = -1 then 
		ps_log = 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_busca_transportadora. ' + 'Problemas ao consultar a tabela "parametro_loja": ' + sqlca.sqlerrtext
		return false
	end if
	
	If (ls_Disque <> 'S') or sqlca.sqlcode = 100  Then
		ps_log = 'O servi$$HEX1$$e700$$ENDHEX$$o de disque entrega n$$HEX1$$e300$$ENDHEX$$o esta ativo para esta filial - ' + iif(IsNull(iuo_comum.il_cd_filial_hub), '', String(iuo_comum.il_cd_filial_hub))
		return false
	End If
	
End If

return true
end function

public function boolean of_grava_produtos (ref string ps_log);long ll_for, ll_linhas
long ll_qt_pedida
long ll_cd_produto
long ll_Sequencial
long ll_count

string ls_cod_barra
string ls_cd_produto_ecommerce

decimal{2} ldc_preco, ldc_vl_total, ldc_preco_praticado, ldc_pc_desconto, ldc_pc_preco, ldc_vl_desconto, ldc_diferenca

dc_uo_ds_base lds_cod_barra_secundarios

Try

	lds_cod_barra_secundarios = create dc_uo_ds_base
	lds_cod_barra_secundarios.of_changedataobject( ids_produtos.dataobject )

	this.ids_produtos.setfilter('nr_pedido_ecommerce = "' + is_nr_pedido_ecommerce + '"')
	this.ids_produtos.filter()
	
	ids_produtos.rowscopy( 1, ids_produtos.rowcount(), primary!, lds_cod_barra_secundarios , 1, primary!)
	
	ll_linhas = this.ids_produtos.rowcount()
	
	for ll_for = 1 to ll_linhas
	
		ldc_pc_desconto = 0
		ldc_vl_desconto = 0
	
		if ids_produtos.object.id_cod_barra_secundario[ll_for] = 'S' Then continue
	
		ls_cod_barra = ids_produtos.object.de_cod_barra[ll_for]
		ll_qt_pedida = ids_produtos.object.qt_pedida[ll_for] 
		ldc_preco = ids_produtos.object.vl_preco[ll_for]
		ldc_vl_total = ids_produtos.object.vl_total[ll_for]
		
		//Filtrar os cod barras secundarios vinculados ao principal:
		lds_cod_barra_secundarios.setfilter('de_cod_barra_principal = "' + ls_cod_barra + '"')
		lds_cod_barra_secundarios.filter()
		
		if idc_desconto > 0 Then
			
			ldc_pc_preco =  ((ldc_preco*ll_qt_pedida)/idc_subtotal_pedido) * 100
			
			ldc_vl_desconto = (idc_desconto *  ldc_pc_preco) / 100
			
			ldc_vl_desconto = Round(ldc_vl_desconto / ll_qt_pedida,2)

			ldc_preco_praticado = ldc_preco - ldc_vl_desconto
			
			ldc_pc_desconto = round((1 - (ldc_preco_praticado/ldc_preco)) * 100, 4)
	
			if ldc_preco_praticado > ldc_preco then
				ldc_preco = ldc_preco_praticado
				ldc_pc_desconto = 0
				ldc_vl_desconto = 0
			ENd if
			
		Else
			ldc_preco_praticado = ldc_preco
		ENd if
		
		idc_subtotal += ldc_preco_praticado*ll_qt_pedida
	
		ll_count=0
	
		Do
	
			ll_count++
			
			//Verificar se o cod barras principal $$HEX1$$e900$$ENDHEX$$ v$$HEX1$$e100$$ENDHEX$$lido:
			if not this.of_busca_produto( ls_cod_barra, ref ll_cd_produto, ref ps_log ) then return false
			
			if ll_cd_produto = 0 then
				//Cod barras principal nao $$HEX1$$e900$$ENDHEX$$ v$$HEX1$$e100$$ENDHEX$$lido.
				//Verifica se existem cod barras secundarios. Se existir, tenta encontrar algum v$$HEX1$$e100$$ENDHEX$$lido para trocar pelo principal.
				if ll_count > lds_cod_barra_secundarios.rowcount() Then
					Exit
				end if
				
				if lds_cod_barra_secundarios.rowcount( )> 0 then
					//Troca o cod barras principal pelo secundario:
					ls_cod_barra = lds_cod_barra_secundarios.object.de_cod_barra[ll_count]
				End if
				
			End if
			
		Loop While ll_cd_produto = 0

		//Nao encontrou cod de barras v$$HEX1$$e100$$ENDHEX$$lidos para usar na integra$$HEX1$$e700$$ENDHEX$$ao:
		if ll_cd_produto = 0 or isnull(ll_cd_produto) Then
			ps_log = 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_produtos; N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar o produto com o seguinte c$$HEX1$$f300$$ENDHEX$$digo de barras: ' + ls_cod_barra
			return false			
		End if

		if ldc_vl_desconto < 0 Then
			ps_log = 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_produtos ~n' + 'O valor calculado para o desconto do produto ' + string(ll_cd_produto) + ' deu negativo: ' + string(ldc_vl_desconto)
			return false
		end if

		ls_cd_produto_ecommerce = string(ll_cd_produto)
		
		Select nr_sequencial
		Into :ll_Sequencial
		From pedido_ecommerce_produto
		Where cd_filial_ecommerce 		= :il_cd_filial_ecommerce
			 and nr_pedido					 	= :il_nr_pedido
			 and cd_produto_ecommerce 	= :ls_cd_produto_ecommerce
		Using SqlCa;
		
		if isnull(ll_sequencial) Then ll_sequencial = 0
		
		ll_sequencial++
		
		INSERT INTO pedido_ecommerce_produto  
		 (  cd_filial_ecommerce,
			nr_pedido,   
			cd_produto_ecommerce, 
			nr_sequencial,
			qt_pedida,    
			cd_produto,   
			vl_preco,   			 		// Pre$$HEX1$$e700$$ENDHEX$$o venda sem o desconto
			vl_preco_promocao, // Pre$$HEX1$$e700$$ENDHEX$$o liquido j$$HEX1$$e100$$ENDHEX$$ com o desconto
			vl_desconto,
			pc_desconto)     	
		VALUES( :il_cd_filial_ecommerce,
					:il_nr_pedido,   
					:ls_cd_produto_ecommerce,   
					:ll_sequencial,
					:ll_qt_pedida,
					:ll_cd_Produto,   
					:ldc_preco,   
					:ldc_preco_praticado,
					:ldc_vl_desconto,
					:ldc_pc_desconto)
		Using SqlCa;
//	
		if SqlCa.sqlcode = -1 Then
			ps_log = 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_produtos ~n' + 'Problemas ao inserir registro na tabela "pedido_ecommerce_produto":~n' + SqlCa.sqlerrtext
			return false
		end if
	
	next

	Update pedido_ecommerce
	set vl_subtotal = :idc_subtotal
	where cd_filial_ecommerce = :il_cd_filial_ecommerce
	and nr_pedido = :il_nr_pedido;

	if SqlCa.sqlcode = -1 Then
		ps_log = 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_produtos ~n' + 'Problemas ao atualizar registro na tabela "pedido_ecommerce":~n' + SqlCa.sqlerrtext
		return false
	end if

Finally
	this.ids_produtos.setfilter('')
	this.ids_produtos.filter()	
End Try

return true
end function

public function boolean of_carrega_dados_consulta_remedios (ref long pl_linhas, ref string ps_log);String ls_retorno
String ls_parametros
String ls_info_vendas
String ls_nr_pedido

uo_ge073_json luo_gera_json

//1) Conecta na Consulta Remedios
//2) Busca todas os pedidos pendentes
//3) Pega as informacoes dos pedidos

Try

	w_Aguarde_3.title = 'CONSULTA REMEDIOS - PEDIDO BAIXA'	
	
	ids_produtos = create dc_uo_ds_base
	ids_produtos.of_changedataobject('ds_ge509_pedido_baixa_produto')
	
	//Buscar a lista de pedidos pendentes:
	if isnull(is_pedido_debug) or is_pedido_debug = '' then
		
		ls_parametros = '?shipment_state=ready&page=1&per=100'
		
		luo_gera_json = Create uo_ge073_json 
		
		if Not iuo_comum.of_get( is_id_interface + ls_parametros, ref ls_retorno, ref ps_log) then return false
	
		Do While luo_gera_json.of_divide_grupo_json_completo(Ref ls_retorno, Ref ls_info_vendas,'{')
	
			ls_nr_pedido = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_vendas, 'order_number')
			
			If Not this.of_carrega_pedido( ls_nr_pedido, ref ps_log ) then return false
			
		Loop
	
//		ls_parametros = '?shipment_state=pending&page=1&per=100'
//		
//		ls_retorno = ''
//		ls_info_vendas = ''
//		
//		if Not iuo_comum.of_get( is_id_interface + ls_parametros, ref ls_retorno, ref ps_log) then return false
//	
//		Do While luo_gera_json.of_divide_grupo_json_completo(Ref ls_retorno, Ref ls_info_vendas,'{')
//	
//			ls_nr_pedido = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_vendas, 'order_number')
//			
//			If Not this.of_carrega_pedido( ls_nr_pedido, ref ps_log ) then return false
//			
//		Loop
	
	
	Else
		//Buscar por um pedido especifico:
		If Not this.of_carrega_pedido( is_pedido_debug, ref ps_log ) then return false
		
	End if
	
Finally
	
	if ps_log <> '' and not isnull(ps_log) Then ps_log = 'Objeto: ' + is_objeto + '; Fun$$HEX2$$e700e300$$ENDHEX$$o: of_carrega_dados_consulta_remedios; ' + ps_log
	
	pl_linhas = ids_dados.rowcount()
	
	destroy(luo_gera_json)
	
End Try

Return true
end function

public function boolean of_carrega_dados_farmacias_app (ref long pl_linhas, ref string ps_log);long ll_linha
long ll_quantidade

String ls_retorno
String ls_info_vendas
String ls_info_produtos
String ls_info_itens
String ls_json_restante
String ls_id_venda
String ls_vl_venda
String ls_cod_barra
String ls_data_compra
String ls_id_situacao	
String ls_id_situacao_pagamento
String ls_tipo_entrega
String ls_nm_transportadora
String ls_cliente_email
String ls_cliente_nome
String ls_cliente_sobrenome
String ls_cliente_cpf
String ls_cliente_fone
String ls_entrega_nome
String ls_entrega_sobrenome
String ls_entrega_logradouro
String ls_entrega_numero
String ls_entrega_bairro
String ls_entrega_comp
String ls_entrega_referencia
String ls_entrega_cidade
String ls_entrega_cep
String ls_entrega_fone
String ls_motivo_cancel
String ls_entrega_uf
String ls_vl_frete
String ls_vl_preco
String ls_vl_total

datetime ldh_compra
datetime ldh_inicio
datetime ldh_fim
datetime ldt_filtro

uo_ge073_json luo_gera_json

//1) Conecta na Consulta Remedios
//2) Busca todas as vendas
//3) Carrega as vendas na datastore ids_dados
//4) Carrega os produtos na datastore ids_produtos

Try

	luo_gera_json = Create uo_ge073_json 
	ids_produtos = create dc_uo_ds_base
	ids_produtos.of_changedataobject('ds_ge509_pedido_baixa_produto')
		
	if Not iuo_comum.of_get( is_id_interface + '/6', ref ls_retorno, ref ps_log) then return false
	
	Do While luo_gera_json.of_divide_grupo_json_completo(Ref ls_retorno, Ref ls_info_vendas,'{') 
	
		ls_json_restante = ls_info_vendas
	
		luo_gera_json.of_divide_grupo_json_tag_vtex(ref ls_json_restante, 'line_items', ref ls_info_produtos, '}')
		
		ls_id_venda = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_vendas, 'order_number')
		ls_id_situacao = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_vendas, 'state')
		ls_id_situacao_pagamento = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_vendas, 'payment_state')
		ls_vl_frete = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_vendas, 'shipment')
		ls_nm_transportadora = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_vendas, 'shipping_method_name')
		ls_tipo_entrega = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_vendas, 'shipping_method_type')
		ls_cliente_email = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_vendas, 'email')
		ls_cliente_nome = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_vendas, 'first_name')
		ls_cliente_sobrenome = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_vendas, 'last_name')
		ls_cliente_cpf = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_vendas, 'cpf')
		ls_cliente_fone = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_vendas, 'phone')
		ls_entrega_nome = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_vendas, 'ship_address_first_name')
		ls_entrega_sobrenome = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_vendas, 'ship_address_last_name')
		ls_entrega_logradouro = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_vendas, 'ship_address_street')
		ls_entrega_numero = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_vendas, 'ship_address_number')
		ls_entrega_bairro = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_vendas, 'ship_address_neighborhood')
		ls_entrega_comp = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_vendas, 'ship_address_complement')
		ls_entrega_referencia = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_vendas, 'ship_address_reference')
		ls_entrega_cidade = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_vendas, 'ship_address_city')
		ls_entrega_uf = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_vendas, 'ship_address_state_abbr')
		ls_entrega_cep = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_vendas, 'ship_address_zipcode')
		ls_entrega_fone = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_vendas, 'ship_address_phone')
		ls_motivo_cancel = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_vendas, 'order_cancelation_reason')

		ls_data_compra = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_vendas, 'payment_confirmed_at')
		ldh_compra = Datetime(Date(ls_data_compra) , Time( Mid(ls_data_compra,12,8) ) )
		
		ls_vl_venda = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_vendas, 'total')
			
//		//Transaforma pro hor$$HEX1$$e100$$ENDHEX$$rio de Brasilia ( GMT -3 )
//		Select dateadd( HOUR, -3, :ldh_compra )
//		Into :ldh_compra
//		From parametro;
	
		ll_linha = ids_dados.insertrow(0)
		
		ids_dados.object.nr_pedido_ecommerce[ll_linha] = ls_id_venda
		ids_dados.object.dh_compra[ll_linha] = ldh_compra
		ids_dados.object.vl_total[ll_linha] = iuo_comum.of_decimal( ls_vl_venda )
		ids_dados.object.id_situacao[ll_linha] = ls_id_situacao 
		ids_dados.object.id_situacao_pagamento[ll_linha] = ls_id_situacao_pagamento 
		ids_dados.object.vl_frete[ll_linha] =  iuo_comum.of_decimal( ls_vl_frete )
		ids_dados.object.nm_transportadora[ll_linha] = ls_nm_transportadora 
		ids_dados.object.id_tipo_entrega[ll_linha] = ls_tipo_entrega 
		ids_dados.object.de_email[ll_linha] = ls_cliente_email 
		ids_dados.object.de_cliente_nome[ll_linha] = ls_cliente_nome 
		ids_dados.object.de_cliente_sobrenome[ll_linha] = ls_cliente_sobrenome 
		ids_dados.object.nr_cpf[ll_linha] = ls_cliente_cpf 
		ids_dados.object.nr_fone[ll_linha] = ls_cliente_fone 
		ids_dados.object.de_nome_entrega[ll_linha] = ls_entrega_nome 
		ids_dados.object.de_sobrenome_entrega[ll_linha] = ls_entrega_sobrenome 
		ids_dados.object.de_logradouro[ll_linha] = ls_entrega_logradouro 
		ids_dados.object.nr_logradouro[ll_linha] = ls_entrega_numero 
		ids_dados.object.de_bairro[ll_linha] = ls_entrega_bairro 
		ids_dados.object.de_complemento[ll_linha] = ls_entrega_comp 
		ids_dados.object.de_referencia[ll_linha] = ls_entrega_referencia 
		ids_dados.object.de_cidade[ll_linha] = ls_entrega_cidade 
		ids_dados.object.cd_uf[ll_linha] = ls_entrega_uf 
		ids_dados.object.nr_cep[ll_linha] = ls_entrega_cep 
		ids_dados.object.nr_fone_entrega[ll_linha] = ls_entrega_fone 
		ids_dados.object.de_motivo_cancel[ll_linha] = ls_motivo_cancel 
		
		Do While luo_gera_json.of_divide_grupo_json_completo(Ref ls_info_produtos, Ref ls_info_itens,'{') 
		
			//Informa$$HEX2$$e700f500$$ENDHEX$$es do Produto
			ls_cod_barra = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_itens, 'sku')
			ls_vl_preco = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_itens, 'price')
			ls_vl_total = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_itens, 'total')
			ll_quantidade = Long(luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_itens, 'quantity'))
			
			ll_linha = ids_produtos.insertrow(0)
			
			ids_produtos.object.nr_pedido_ecommerce[ll_linha] = ls_id_venda
			ids_produtos.object.de_cod_barra[ll_linha] = ls_cod_barra
			ids_produtos.object.qt_pedida[ll_linha] = ll_quantidade
			ids_produtos.object.vl_preco[ll_linha] =  iuo_comum.of_decimal( ls_vl_preco )
			ids_produtos.object.vl_total[ll_linha] =  iuo_comum.of_decimal( ls_vl_total )
			
		Loop
			
	Loop
	
Finally
	
	if ps_log <> '' and not isnull(ps_log) Then ps_log = 'Objeto: ' + is_objeto + '; Fun$$HEX2$$e700e300$$ENDHEX$$o: of_carrega_dados_farmacias_app; ' + ps_log
	
	pl_linhas = ids_dados.rowcount()
	
	destroy(luo_gera_json)
	
//
//    "Orders": [
//        {
//            "ref_id": "01G92FBHC053TR5X",
//            "partner_id": null,
//            "customer": {
//                "id": 370756558,
//                "name": "TESTE IVAN HOMOLOGA$$HEX2$$c700c300$$ENDHEX$$O FARMACIAS APP",
//                "first_name": "TESTE",
//                "last_name": "IVAN HOMOLOGA$$HEX2$$c700c300$$ENDHEX$$O FARMACIAS APP",
//                "principal_phone": "47991869921",
//                "email": "filidisivan@gmail.com",
//                "document": "370.756.558-09"
//            },
//            "address": {
//                "description": "Avenida Santo Albano",
//                "street": "Avenida Santo Albano",
//                "number": "490",
//                "neighborhood": "Vila Vera",
//                "zipcode": "04296-000",
//                "complement": null,
//                "reference_point": null,
//                "city": {
//                    "id": 123456,
//                    "name": "S$$HEX1$$e300$$ENDHEX$$o Paulo",
//                    "state": {
//                        "id": 26,
//                        "name": "S$$HEX1$$e300$$ENDHEX$$o Paulo",
//                        "code": "SP"
//                    }
//                }
//            },
//            "status": {
//                "id": 13,
//                "title": "Confirmando Disponibilidade",
//                "subtitle": "Confirmando Disponibilidade"
//            },
//            "customer_document": "370.756.558-09",
//            "customer_ip": "1**.1**.3*.2**",
//            "items": [
//                {
//                    "id": 7896269900150,
//                    "name": "Aerolin Spray - 100mcg | 200 doses",
//                    "quantity": 1,
//                    "price_un": 40.85,
//                    "price_total": 40.85,
//                    "sku": "636"
//                }
//            ],
//            "shipping": {
//                "id": 728131853,
//                "type": {
//                    "id": 100,
//                    "partner_id": null,
//                    "title": "DELIVERY"
//                },
//                "cost": 0,
//                "courier_name": "DELIVERY",
//                "tracking_code": null,
//                "tracking_url": null,
//                "customer_name": "",
//                "created_at": "2022-07-28 13:18:53",
//                "paid_at": null,
//                "packed_at": null,
//                "out_at": null,
//                "delivered_at": null,
//                "is_pickup": false,
//                "is_delivery": true,
//                "estimated_delivery_time": 59,
//                "estimated_delivery_date": "2022-07-28 14:18:53",
//                "status": {
//                    "id": 2,
//                    "title": "Preparando"
//                },
//                "pickup": {
//                    "name": null,
//                    "document": null
//                },
//                "items": null
//            },
//            "payment": {
//                "id": 728131853,
//                "created_at": "2022-07-28 13:18:53",
//                "updated_at": "2022-07-28 13:18:53",
//                "transaction_receipt": null,
//                "nsu": null,
//                "status": {
//                    "id": 7,
//                    "title": "Pgto. na Entrega"
//                },
//                "method": {
//                    "id": 7,
//                    "title": "Cart$$HEX1$$e300$$ENDHEX$$o de D$$HEX1$$e900$$ENDHEX$$bito na entrega"
//                },
//                "amount": 40.85,
//                "change_for": 0,
//                "credit_discount": 0,
//                "credit_shipping_discount": 0,
//                "credit_card": {
//                    "id": null,
//                    "expiration_month": null,
//                    "expiration_year": null,
//                    "holder_name": null,
//                    "last_number_part": null,
//                    "provider": {
//                        "id": null,
//                        "title": null
//                    },
//                    "status": {
//                        "id": null,
//                        "title": null
//                    }
//                },
//                "card": {
//                    "id": null,
//                    "expiration_month": null,
//                    "expiration_year": null,
//                    "holder_name": null,
//                    "last_number_part": null,
//                    "provider": {
//                        "id": null,
//                        "title": null
//                    },
//                    "status": {
//                        "id": null,
//                        "title": null
//                    }
//                },
//                "installment": null,
//                "billet": {
//                    "valid_until": null,
//                    "partner_number": null,
//                    "bar_code": null,
//                    "value": null,
//                    "url": null,
//                    "codes": {
//                        "digitable": null,
//                        "barcode": ""
//                    }
//                },
//                "billet_valid_until": null,
//                "billet_partner_number": null,
//                "billet_bar_code": null,
//                "billet_value": null,
//                "billet_url": null
//            },
//            "created_at": "2022-07-28 13:18:53",
//            "updated_at": "2022-07-28 13:18:59",
//            "requested_at": "2022-07-28 13:18:53",
//            "total_price": 40.85,
//            "total_reference_price": 40.85,
//            "cancellation_reason": [
//                {
//                    "id": 1,
//                    "description": "Produto sem estoque"
//                },
//                {
//                    "id": 2,
//                    "description": "Tempo de entrega ultrapassado (fora do hor$$HEX1$$e100$$ENDHEX$$rio de atendimento)"
//                },
//                {
//                    "id": 3,
//                    "description": "Suspeita de fraude"
//                },
//                {
//                    "id": 4,
//                    "description": "$$HEX1$$c100$$ENDHEX$$rea de entrega n$$HEX1$$e300$$ENDHEX$$o atendida"
//                },
//                {
//                    "id": 5,
//                    "description": "Dados do cliente incompletos"
//                },
//                {
//                    "id": 6,
//                    "description": "Endere$$HEX1$$e700$$ENDHEX$$o incorreto ou incompleto"
//                },
//                {
//                    "id": 7,
//                    "description": "Outro"
//                },
//                {
//                    "id": 8,
//                    "description": "Pagamento N$$HEX1$$e300$$ENDHEX$$o Realizado / Negado"
//                },
//                {
//                    "id": 9,
//                    "description": "Homologa$$HEX2$$e700e300$$ENDHEX$$o"
//                },
//                {
//                    "id": 10,
//                    "description": "Testes Internos"
//                },
//                {
//                    "id": 11,
//                    "description": "Desist$$HEX1$$ea00$$ENDHEX$$ncia do Cliente"
//                }
//            ]
//        }
//    ]
//}
	
	
End Try

Return true



return true
end function

public function boolean of_configurar_consulta_remedios ();
is_id_interface = 'api/v1/store/orders'

il_cd_mensagem_email = 289

return false
end function

public function boolean of_configurar_farmacias_app ();
is_id_interface = 'partner/v1/order/list/'
il_cd_mensagem_email = 288

return true
end function

public subroutine of_configurar_parametros ();Choose Case is_id_ecommerce
	Case '5'
		
		this.of_configurar_consulta_remedios( )
		
	Case '6'
		
		this.of_configurar_farmacias_app( )
		
End Choose
end subroutine

public function boolean of_aprovar_pedido (ref string ps_log);string ls_retorno

Try

	if ib_modo_desenv = True then return true

	Choose Case is_id_ecommerce
		Case '5' //Consulta remedios
	
			iuo_comum.of_patch( '', 'api/v1/store/orders/' + is_nr_pedido_ecommerce + '/approve', ref ls_retorno, ref ps_log )
			
		Case '6' //Farmacias app
			
			iuo_comum.of_put( '', '/order/' + is_nr_pedido_ecommerce + '/received', ref ls_retorno, ref ps_log )
			
			
	End Choose

	if ps_log <> '' and not isnull(ps_log) then return false

Finally
	
	if ps_log <> '' and not isnull(ps_log) then ps_log = 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_aprovar_pedido; ' + ps_log
	
End Try

return true
end function

public function boolean of_valida_pedido (ref string ps_log);Decimal ldc_Tot_Prd_Calc
Decimal ldc_Tot_Desc, ldc_diferenca
Decimal ldc_vl_preco, ldc_vl_preco_promocao, ldc_vl_desconto, ldc_pc_desconto

string ls_produto

Long ll_Produto_Pedido
Long ll_qt_pedida
Long ll_Achou
Long ll_sequencial, ll_sequencial_novo

Select coalesce(sum(round(qt_pedida * vl_preco_promocao, 2)), 0) 
Into :ldc_Tot_Prd_Calc
From pedido_ecommerce_produto
where cd_filial_ecommerce = :il_cd_filial_ecommerce
  and nr_pedido = :il_nr_pedido
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_valida_pedido ~n' + 'Problemas ao consultar os valores da tabela "pedido_ecommerce_produto":~n' + SqlCa.sqlerrtext
	return false
End If

If idc_subtotal <> ldc_Tot_Prd_Calc Then
	ps_log = is_objeto + 'O total dos produtos calculado esta diferente do SUBTOTAL informado no pedido.'
	return false
End If

ldc_diferenca =  idc_vl_Total - (idc_subtotal + idc_vl_frete)

If ldc_diferenca > 0.5 or ldc_diferenca < -0.5 Then
	ps_log = is_objeto + 'O total do pedido calculado esta diferente do informado no pedido.'
	return false
End If

//ldc_diferenca = idc_subtotal - ldc_Tot_Prd_Calc

if ldc_diferenca <> 0 and ldc_diferenca < 0.5 and ldc_diferenca > -0.5 Then
	
	select top 1 cd_produto_ecommerce, nr_sequencial, qt_pedida, vl_preco, vl_preco_promocao, vl_desconto, pc_desconto
	into :ls_produto, :ll_sequencial, :ll_qt_pedida, :ldc_vl_preco, :ldc_vl_preco_promocao, :ldc_vl_desconto, :ldc_pc_desconto
	from pedido_ecommerce_produto
	where cd_filial_ecommerce = :il_cd_filial_ecommerce
	  and nr_pedido = :il_nr_pedido
	  and vl_preco_promocao > 0.1
	  order by qt_pedida
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		ps_log = 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_valida_pedido ~n' + 'Problemas ao consultar os valores da tabela "pedido_ecommerce_produto":~n' + SqlCa.sqlerrtext
		return false
	End If
	
	if ldc_diferenca > 0 Then
		
		ldc_vl_desconto = ldc_vl_desconto - ldc_diferenca
				
		ldc_vl_preco_promocao = ldc_vl_preco_promocao + ldc_diferenca
	
	ELse
		
		ldc_diferenca = ldc_diferenca * -1
		
		ldc_vl_desconto = ldc_vl_desconto + ldc_diferenca
		
		ldc_vl_preco_promocao = ldc_vl_preco_promocao - ldc_diferenca
				
	ENd if
	
	ldc_pc_desconto = round((1 - (ldc_vl_preco_promocao/ldc_vl_preco)) * 100, 4)

	if ll_qt_pedida = 1 Then
		
			update pedido_ecommerce_produto
			set vl_preco_promocao = :ldc_vl_preco_promocao , vl_desconto = :ldc_vl_desconto, pc_desconto = :ldc_pc_desconto
			where cd_filial_ecommerce = :il_cd_filial_ecommerce
			  and nr_pedido = :il_nr_pedido
			  and cd_produto_ecommerce = :ls_produto
			  and nr_sequencial = :ll_sequencial;
	
		If SqlCa.SqlCode = -1 Then
			ps_log = 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_valida_pedido ~n' + 'Problemas ao atualizar registro da tabela "pedido_ecommerce_produto":~n' + SqlCa.sqlerrtext
			return false
		End If
		
	Else

		select max(nr_sequencial)
		into :ll_sequencial_novo
		from pedido_ecommerce_produto
		where cd_filial_ecommerce = :il_cd_filial_ecommerce
			  and nr_pedido = :il_nr_pedido;

		If SqlCa.SqlCode = -1 Then
			ps_log = 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_valida_pedido ~n' + 'Problemas ao consultar registro da tabela "pedido_ecommerce_produto":~n' + SqlCa.sqlerrtext
			return false
		End If
		
		if isnull(ll_sequencial_novo) Then ll_sequencial_novo = 0
		
		ll_sequencial_novo++
		
		INSERT INTO pedido_ecommerce_produto  
		 (  cd_filial_ecommerce,
			nr_pedido,   
			cd_produto_ecommerce, 
			nr_sequencial,
			qt_pedida,   
			cd_produto,   
			vl_preco,   			 		
			vl_preco_promocao,
			nr_requisicao_manip,
			vl_desconto,
			pc_desconto)
		Select  cd_filial_ecommerce,
			nr_pedido,   
			cd_produto_ecommerce, 
			:ll_sequencial_novo,
			1,   
			cd_produto,   
			vl_preco,   			 		
			:ldc_vl_preco_promocao,
			nr_requisicao_manip,
			:ldc_vl_desconto,
			:ldc_pc_desconto
			from pedido_ecommerce_produto
		Where  cd_filial_ecommerce = :il_cd_filial_ecommerce
		  and nr_pedido = :il_nr_pedido
		  and nr_sequencial = :ll_sequencial ;
	
		If SqlCa.SqlCode = -1 Then
			ps_log = 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_valida_pedido ~n' + 'Problemas ao inserir registro da tabela "pedido_ecommerce_produto":~n' + SqlCa.sqlerrtext
			return false
		End If
		
		update pedido_ecommerce_produto
			set qt_pedida = qt_pedida - 1
			where cd_filial_ecommerce = :il_cd_filial_ecommerce
			  and nr_pedido = :il_nr_pedido
			  and cd_produto_ecommerce = :ls_produto
			  and nr_sequencial = :ll_sequencial;
	
		If SqlCa.SqlCode = -1 Then
			ps_log = 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_valida_pedido ~n' + 'Problemas ao atualizar registro da tabela "pedido_ecommerce_produto":~n' + SqlCa.sqlerrtext
			return false
		End If
		
	End if
	
	Select coalesce(sum(round(qt_pedida * vl_preco_promocao, 2)), 0) 
	Into :ldc_Tot_Prd_Calc
	From pedido_ecommerce_produto
	where cd_filial_ecommerce = :il_cd_filial_ecommerce
	  and nr_pedido = :il_nr_pedido
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		ps_log = 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_valida_pedido ~n' + 'Problemas ao consultar os valores da tabela "pedido_ecommerce_produto":~n' + SqlCa.sqlerrtext
		return false
	End If
	
	update pedido_ecommerce
		set vl_subtotal = :ldc_Tot_Prd_Calc
		where cd_filial_ecommerce = :il_cd_filial_ecommerce
		  and nr_pedido = :il_nr_pedido;
	
		If SqlCa.SqlCode = -1 Then
			ps_log = 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_valida_pedido ~n' + 'Problemas ao atualizar registro da tabela "pedido_ecommerce":~n' + SqlCa.sqlerrtext
			return false
		End If
	
	ldc_diferenca =  idc_vl_Total - (ldc_Tot_Prd_Calc + idc_vl_frete)
	
ENd if

if ldc_diferenca < 0 then ldc_diferenca = ldc_diferenca * -1

If ldc_diferenca > 0 Then
	ps_log = 'O total de produtos calculado est$$HEX1$$e100$$ENDHEX$$ diferente do SUBTOTAL informado no pedido.'
	return false
End If

//// valida desconto
//Select sum(coalesce(vl_desconto, 0))
//Into :ldc_Tot_Desc
//From pedido_ecommerce_produto
//where cd_filial_ecommerce = :il_cd_filial_ecommerce
//  and nr_pedido = :il_nr_pedido
//Using SqlCa;
//
//If SqlCa.SqlCode = -1 Then
//	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_valida_pedido ~n' + 'Problemas ao consultar os valores da tabela - desc "pedido_ecommerce_produto":~n' + SqlCa.sqlerrtext
//	return false
//End If
//
//If idc_Desconto_Validacao <> ldc_Tot_Desc Then
//	ps_log = is_objeto + 'A soma dos descontos dos produtos esta diferente do informado no pedido.'
//	return false
//End If
// valida desconto

select top 1 p.cd_produto 
Into :ll_Produto_Pedido
from pedido_ecommerce_produto p
where p.cd_filial_ecommerce 	= :il_cd_filial_ecommerce
  and p.nr_pedido 					= :il_nr_pedido
  and not exists (select 1 from ecommerce_prd pr
				  where pr.id_ecommerce = :is_id_ecommerce
					 and pr.id_rede_filial = :is_rede_filial
					 and pr.cd_produto = p.cd_produto)
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_valida_pedido ~n' + 'Problemas ao consultar os valores para validar os produtos da tabela "pedido_ecommerce_produto":~n' + SqlCa.sqlerrtext
	return false
End If

If Not IsNull(ll_Produto_Pedido) and ll_Produto_Pedido > 0 Then
	ps_log = is_objeto +  'O produto ' + String(ll_Produto_Pedido) + ' inserido no pedido n$$HEX1$$e300$$ENDHEX$$o foi localizado na tabela "ecommerce_prd".'
	Return False
End If


Return True
end function

public function boolean of_busca_filial_ecommerce (long pl_cd_filial, string ps_rede, ref long pl_cd_filial_ecommerce, ref string ps_log);long ll_filial_ecommerce

Select cd_filial_ecommerce
Into :ll_filial_ecommerce
From ecommerce_hub_rede
where id_ecommerce = :this.is_id_ecommerce
  and cd_filial_hub = :pl_cd_filial
  and id_rede_filial = :ps_rede
  Using SqlCa;
  
  Choose Case SqlCa.SqlCode
	Case 0
	Case 100
		// Neste caso a cd_filial_ecommerce fica o que retorno do par$$HEX1$$e200$$ENDHEX$$metro
		ll_filial_ecommerce = pl_Cd_filial
	Case -1
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_busca_filial_ecommerce ~n' + 'Problemas ao consultar a tabela "ecommerce_hub_rede": ~n'  + sqlca.sqlerrtext
		return false
End Choose

pl_cd_filial_ecommerce = ll_filial_ecommerce

return true
end function

public subroutine of_limpa_variaveis ();setnull(il_cd_tipo_entrega)

setnull(idc_vl_frete)
setnull(idc_vl_total)
setnull(idc_subtotal)
setnull(idc_desconto)
setnull(idc_subtotal_pedido)

setnull(is_nr_pedido_ecommerce)
setnull(is_id_situacao)
setnull(is_nm_transportadora)
setnull(is_de_email)
setnull(is_nm_cliente)
setnull(is_nr_cpf)
setnull(is_nr_fone)
setnull(is_nm_destinatario)
setnull(is_de_logradouro)
setnull(is_nr_logradouro)
setnull(is_de_bairro)
setnull(is_de_complemento)
setnull(is_de_cidade)
setnull(is_nr_cep)
setnull(is_nr_fone_entraga)
setnull(is_de_motivo_cancel)
setnull(is_cd_uf)
setnull(is_fisica_juridica)
setnull(is_sexo)
setnull(is_de_referencia)
setnull(is_regiao)
setnull(is_tipo_pgto)
setnull(is_forma_pagto)
setnull(is_Exige_NFSE)
setnull(is_id_tipo_entrega)

setnull(idh_compra)
setnull(idh_DataNascimento)

setnull(il_nr_pedido)
setnull(il_cd_cliente)
setnull(il_cd_tipo_entrega)
setnull(il_Pagamento)
setnull(il_cd_filial_ecommerce)

setnull(ii_prazo_entrega)

end subroutine

public function boolean of_busca_produto (string ps_cod_barra, ref long pl_cd_produto, ref string ps_log);long ll_existe
boolean lb_produto_valido=false

Try

	select top 1 cd_produto 
	into :pl_cd_produto
	from codigo_barras_produto where de_codigo_barras =:ps_cod_barra;
	
	if sqlca.sqlcode = -1 then
		ps_log = 'Problemas ao consultar a tabela codigo_barras_produto: ' + sqlca.sqlerrtext
		return false
	End if
	
	if pl_cd_produto > 0 and not isnull(pl_cd_produto) then
	
		select count(*)
		into :ll_existe
		from ecommerce_prd
		where id_ecommerce = :is_id_ecommerce
		and id_rede_filial = :is_rede_filial
		and cd_produto = :pl_cd_produto;
		
		if sqlca.sqlcode = -1 then
			ps_log = 'Problemas ao consultar a tabela codigo_barras_produto: ' + sqlca.sqlerrtext
			return false
		End if
		
		if ll_existe > 0 and not isnull(ll_existe) then
			lb_produto_valido = True
		ENd if
	
	ENd if
	
	if lb_produto_valido = false Then
		pl_cd_produto = 0
	ENd if
	
Finally 
	
	if ps_log <> '' and not isnull(ps_log) then ps_log = 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_busca_produto; ' + ps_log
	
ENd Try

return true
end function

public function boolean of_carrega_pedido (string ps_nr_pedido, ref string ps_log);long ll_linha
long ll_quantidade
long ll_pos_ini, ll_pos_fim

String ls_retorno
String ls_info_vendas
String ls_info_produtos
String ls_info_itens
String ls_json_restante
String ls_id_venda
String ls_vl_venda
String ls_cod_barra
String ls_data_compra
String ls_id_situacao	
String ls_id_situacao_pagamento
String ls_tipo_entrega
String ls_nm_transportadora
String ls_cliente_email
String ls_cliente_nome
String ls_cliente_sobrenome
String ls_cliente_cpf
String ls_cliente_fone
String ls_entrega_nome
String ls_entrega_sobrenome
String ls_entrega_logradouro
String ls_entrega_numero
String ls_entrega_bairro
String ls_entrega_comp
String ls_entrega_referencia
String ls_entrega_cidade
String ls_entrega_cep
String ls_entrega_fone
String ls_motivo_cancel
String ls_entrega_uf
String ls_vl_frete_desconto
String ls_vl_desconto
String ls_vl_frete
String ls_vl_preco
String ls_vl_total
String ls_parametros 
String ls_vl_subtotal
String ls_json_aux
String ls_cod_barra_secundario
String ls_info_secundario
String ls_status_entrega

datetime ldh_compra
datetime ldh_inicio
datetime ldh_fim
datetime ldt_filtro

uo_ge073_json luo_gera_json

//1) Conecta na Consulta Remedios
//2) Busca todas as vendas
//3) Carrega as vendas na datastore ids_dados
//4) Carrega os produtos na datastore ids_produtos

Try

	luo_gera_json = Create uo_ge073_json 
		
	if Not iuo_comum.of_get( is_id_interface + '/' + ps_nr_pedido, ref ls_retorno, ref ps_log) then return false	
	
	Do While luo_gera_json.of_divide_grupo_json_completo(Ref ls_retorno, Ref ls_info_vendas,'{') 
	
		ls_json_restante = ls_info_vendas
	
		luo_gera_json.of_divide_grupo_json_tag_vtex(ref ls_json_restante, 'line_items', ref ls_info_produtos, '}]')
		
		ls_id_venda = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_vendas, 'order_number')
		ls_id_situacao = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_vendas, 'state')
		ls_status_entrega = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_vendas, 'shipment_state')
		ls_id_situacao_pagamento = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_vendas, 'payment_state')
		ls_vl_frete = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_vendas, 'shipment')
		ls_vl_frete_desconto = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_vendas, 'shipment_discount')
		ls_vl_desconto = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_vendas, 'discount')
		
		ls_nm_transportadora = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_vendas, 'shipping_method_name')
		ls_tipo_entrega = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_vendas, 'shipping_method_type')
		ls_cliente_email = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_vendas, 'email')
		ls_cliente_nome = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_vendas, 'first_name')
		ls_cliente_sobrenome = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_vendas, 'last_name')
		ls_cliente_cpf = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_vendas, 'cpf')
		ls_cliente_fone = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_vendas, 'phone')
		ls_entrega_nome = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_vendas, 'ship_address_first_name')
		ls_entrega_sobrenome = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_vendas, 'ship_address_last_name')
		ls_entrega_logradouro = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_vendas, 'ship_address_street')
		ls_entrega_numero = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_vendas, 'ship_address_number')
		ls_entrega_bairro = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_vendas, 'ship_address_neighborhood')
		ls_entrega_comp = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_vendas, 'ship_address_complement')
		ls_entrega_referencia = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_vendas, 'ship_address_reference')
		ls_entrega_cidade = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_vendas, 'ship_address_city')
		ls_entrega_uf = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_vendas, 'ship_address_state_abbr')
		ls_entrega_cep = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_vendas, 'ship_address_zipcode')
		ls_entrega_fone = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_vendas, 'ship_address_phone')
		ls_motivo_cancel = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_vendas, 'order_cancelation_reason')

		ls_data_compra = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_vendas, 'payment_confirmed_at')
		ldh_compra = Datetime(Date(ls_data_compra) , Time( Mid(ls_data_compra,12,8) ) )
		
		ls_vl_venda = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_vendas, 'total')
		ls_vl_subtotal = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_vendas, 'subtotal')
			
//		//Transaforma pro hor$$HEX1$$e100$$ENDHEX$$rio de Brasilia ( GMT -3 )
//		Select dateadd( HOUR, -3, :ldh_compra )
//		Into :ldh_compra
//		From parametro;
	
		ll_linha = ids_dados.insertrow(0)
		
		ids_dados.object.nr_pedido_ecommerce[ll_linha] = ls_id_venda
		ids_dados.object.dh_compra[ll_linha] = ldh_compra
		ids_dados.object.vl_total[ll_linha] = iuo_comum.of_decimal( ls_vl_venda )
		ids_dados.object.id_situacao[ll_linha] = ls_id_situacao 
		ids_dados.object.id_situacao_entrega[ll_linha] = ls_status_entrega
		ids_dados.object.id_situacao_pagamento[ll_linha] = ls_id_situacao_pagamento 
		ids_dados.object.vl_frete[ll_linha] =  iuo_comum.of_decimal( ls_vl_frete )
		ids_dados.object.vl_frete_desconto[ll_linha] =  iuo_comum.of_decimal( ls_vl_frete_desconto )
		ids_dados.object.vl_desconto[ll_linha] =  iuo_comum.of_decimal( ls_vl_desconto )
		ids_dados.object.nm_transportadora[ll_linha] = ls_nm_transportadora 
		ids_dados.object.id_tipo_entrega[ll_linha] = ls_tipo_entrega 
		ids_dados.object.de_email[ll_linha] = ls_cliente_email 
		ids_dados.object.de_cliente_nome[ll_linha] = ls_cliente_nome 
		ids_dados.object.de_cliente_sobrenome[ll_linha] = ls_cliente_sobrenome 
		ids_dados.object.nr_cpf[ll_linha] = ls_cliente_cpf 
		ids_dados.object.nr_fone[ll_linha] = ls_cliente_fone 
		ids_dados.object.de_nome_entrega[ll_linha] = ls_entrega_nome 
		ids_dados.object.de_sobrenome_entrega[ll_linha] = ls_entrega_sobrenome 
		ids_dados.object.de_logradouro[ll_linha] = ls_entrega_logradouro 
		ids_dados.object.nr_logradouro[ll_linha] = ls_entrega_numero 
		ids_dados.object.de_bairro[ll_linha] = ls_entrega_bairro 
		ids_dados.object.de_complemento[ll_linha] = ls_entrega_comp 
		ids_dados.object.de_referencia[ll_linha] = ls_entrega_referencia 
		ids_dados.object.de_cidade[ll_linha] = ls_entrega_cidade 
		ids_dados.object.cd_uf[ll_linha] = ls_entrega_uf 
		ids_dados.object.nr_cep[ll_linha] = ls_entrega_cep 
		ids_dados.object.nr_fone_entrega[ll_linha] = ls_entrega_fone 
		ids_dados.object.de_motivo_cancel[ll_linha] = ls_motivo_cancel 
		ids_dados.object.vl_subtotal[ll_linha] = iuo_comum.of_decimal( ls_vl_subtotal ) 

		Do While luo_gera_json.of_divide_grupo_json_completo(Ref ls_info_produtos, Ref ls_info_itens,'{') 
		
			//Informa$$HEX2$$e700f500$$ENDHEX$$es do Produto
			ls_cod_barra = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_itens, 'sku')
			ls_vl_preco = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_itens, 'price')
			ls_vl_total = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_itens, 'total')
			ll_quantidade = Long(luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_itens, 'quantity'))
			
			ll_linha = ids_produtos.insertrow(0)
			
			ids_produtos.object.nr_pedido_ecommerce[ll_linha] = ls_id_venda
			ids_produtos.object.de_cod_barra[ll_linha] = ls_cod_barra
			ids_produtos.object.qt_pedida[ll_linha] = ll_quantidade
			ids_produtos.object.vl_preco[ll_linha] =  iuo_comum.of_decimal( ls_vl_preco )
			ids_produtos.object.vl_total[ll_linha] =  iuo_comum.of_decimal( ls_vl_total )
			
			ls_json_aux = ls_info_itens
			
			//carrega os sku/cod barras secundarios:
			luo_gera_json.of_divide_grupo_json_tag_vtex(ref ls_json_aux, 'secondary_skus', ref ls_info_secundario, ']')
			
			//:["7897337707596","7897337707711","7897572020283"]

			ll_pos_ini = pos(ls_info_secundario,'"',1)
			
			Do While ll_pos_ini > 0
				
				ll_pos_ini++
				
				ll_pos_fim = pos(ls_info_secundario,'"',ll_pos_ini)
				
				ls_cod_barra_secundario = mid(ls_info_secundario, ll_pos_ini, ll_pos_fim - ll_pos_ini)
				
				ll_linha = ids_produtos.insertrow(0)
			
				ids_produtos.object.nr_pedido_ecommerce[ll_linha] = ls_id_venda
				ids_produtos.object.de_cod_barra[ll_linha] = ls_cod_barra_secundario
				ids_produtos.object.qt_pedida[ll_linha] = ll_quantidade
				ids_produtos.object.vl_preco[ll_linha] =  iuo_comum.of_decimal( ls_vl_preco )
				ids_produtos.object.vl_total[ll_linha] =  iuo_comum.of_decimal( ls_vl_total )
	
				ids_produtos.object.id_cod_barra_secundario[ll_linha] = 'S'
				ids_produtos.object.de_cod_barra_principal[ll_linha] = ls_cod_barra
				
				ll_pos_ini = pos(ls_info_secundario,'"',ll_pos_fim  + 1)
				
			Loop
			
			
		Loop
			
	Loop
	
Finally
	
	if ps_log <> '' and not isnull(ps_log) Then ps_log = 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_carrega_pedido; ' + ps_log
	
	destroy(luo_gera_json)
	
End Try

Return true
end function

on uo_ge509_pedido_baixa.create
call super::create
end on

on uo_ge509_pedido_baixa.destroy
call super::destroy
end on

