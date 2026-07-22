HA$PBExportHeader$uo_ge509_produto.sru
forward
global type uo_ge509_produto from uo_ge516_comum_interface_ecommerce
end type
end forward

global type uo_ge509_produto from uo_ge516_comum_interface_ecommerce
boolean ib_grava_log_historico = true
string is_id_ecommerce = "5"
string is_id_interface = "api/v1/store/products/"
long il_cd_tipo = 2
string is_datastore_dados = "ds_ge509_produto"
string is_objeto_comum = "uo_ge509_comum_consulta_remedio"
boolean ib_atualiza_log_exportacao = true
boolean ib_enviar_email = false
string is_nm_tabela_log = "PRODUTO_GERAL"
long il_cd_mensagem_email = 289
string is_mensagem_email_1 = "PRODUTO"
end type
global uo_ge509_produto uo_ge509_produto

type variables
string is_cod_barras_principal
long il_cd_produto
long il_qt_estoque

Datetime idh_data_atual

Decimal{2} idc_preco, idc_preco_original

dc_uo_ds_base ids_cod_barras
end variables

forward prototypes
private function boolean of_processa_interface_itens (long pl_linha, ref boolean pb_gerar_log, ref string ps_log)
public function boolean of_busca_saldo (long pl_cd_produto, ref long pl_qt_estoque, ref string ps_log)
public function boolean of_monta_json (ref string ps_json, ref string ps_log)
private function boolean of_carrega_dados (ref long pl_linhas, ref string ps_log)
public subroutine of_configurar_parametros ()
public function boolean of_busca_cod_barra (long pl_cd_produto, ref string ps_cod_barra, ref string ps_cd_unidade_medida, ref string ps_log)
end prototypes

private function boolean of_processa_interface_itens (long pl_linha, ref boolean pb_gerar_log, ref string ps_log);string ls_json
string ls_retorno
string ls_cd_fornecedor
string ls_cd_produto_ecommerce
string ls_cod_barra_produto, ls_cod_barra_sec
string ls_id_visivel_prd
string ls_id_inativar_atualizacao_saldo
string ls_cd_unidade
string ls_json_zerado

long ll_existe
long ll_for
long ll_linhas
long ll_cd_categoria_ecommerce

dc_uo_ds_base lds_cod_barras

Try

	if not isvalid(ids_cod_barras) Then
		ids_cod_barras = create dc_uo_ds_base
		ids_cod_barras.of_changedataobject('ds_ge509_produto_cod_barra')
	End if

	ps_log = ''

	il_cd_produto = ids_dados.object.cd_produto[pl_linha]
	//idc_peso = ids_dados.object.qt_peso_grama[pl_linha]
	ls_cd_produto_ecommerce = ids_dados.object.cd_produto_ecommerce[pl_linha]
	idc_preco = ids_dados.object.vl_preco_promocao[pl_linha]
	idc_preco_original = ids_dados.object.vl_preco[pl_linha]
	il_qt_estoque = ids_dados.object.qt_saldo_filial[pl_linha]
	ls_cod_barra_produto = ids_dados.object.de_codigo_barras[pl_linha]
	ls_id_visivel_prd = ids_dados.object.id_visivel_prd[pl_linha]
	ls_id_inativar_atualizacao_saldo = ids_dados.object.id_inativar_atualizacao_saldo[pl_linha]
	
	if isnull(il_qt_estoque) Then il_qt_estoque = 0
	
	if il_qt_estoque < 0 Then il_qt_estoque = 0
	
	if ls_id_visivel_prd = 'N' or ls_id_inativar_atualizacao_saldo = 'S' then
		//Produto nao deve ser exibido na loja:
		il_qt_estoque = 0
	ENd if
	
	iuo_comum.il_cd_produto = il_cd_produto
	
	If Not this.of_busca_cod_barra( il_cd_produto, ref is_cod_barras_principal, ref ls_cd_unidade, ref ps_log) then return false
	
	if isnull(is_cod_barras_principal) or is_cod_barras_principal = '' then
		//Se nao exisir na tabela codigo_barras_produto usa o da tabela produto_geral:
		is_cod_barras_principal = ls_cod_barra_produto
	End if
	
	w_Aguarde_3.wf_settext('Filial: ' + string(il_cd_filial) + ' (' + is_rede_filial + ')' , 1)
	w_Aguarde_3.wf_settext('Produto: ' + string(il_cd_produto) + ' (' + string(pl_linha) + ' de ' + string(ids_dados.rowcount()) + ')' , 2)
	
	//*********************//
	//Validar campos Obrigat$$HEX1$$f300$$ENDHEX$$rios:
	//*********************//
	
	if isnull(idc_preco) or idc_preco = 0 Then
		ps_log += 'Produto sem pre$$HEX1$$e700$$ENDHEX$$o definido. '
	end if
	
	if isnull(is_cod_barras_principal) or is_cod_barras_principal = '' Then
		ps_log += 'Produto sem c$$HEX1$$f300$$ENDHEX$$digo de barras definido. '
	end if
	
	if ps_log <> '' then return false
	
	if Not this.of_monta_json( ref ls_json, ref ps_log ) Then return false
	
	iuo_comum.is_json = ls_json
	//iuo_comum.idc_qt_peso = idc_peso
	iuo_comum.is_cd_ean = is_cod_barras_principal
	
	ids_cod_barras.retrieve(il_cd_produto)
	
	Choose CAse is_id_ecommerce
		Case '5'
			iuo_comum.of_patch( ls_json, is_id_interface + this.is_cod_barras_principal + '/price_stock', ref ls_retorno, ref ps_log )
			
			if ps_log <> '' and not isnull(ps_log) Then return false
			
			if ids_cod_barras.rowcount() > 0 then
				ls_json_zerado = '{' + &
									 '"price": ' + gf_valor_com_ponto(idc_preco) + ', ' + &
									 '"stock": 0' + &
									'}'
			End if
			
			//Tratar os codigo de barras secundarios:
			for ll_for = 1 to ids_cod_barras.rowcount()
				
				ls_cod_barra_sec = ids_cod_barras.object.de_codigo_barras[ll_for]
				
				if ls_cd_unidade = ids_cod_barras.object.cd_unidade_medida_venda[ll_for] Then
				
					if ls_cod_barra_sec <> this.is_cod_barras_principal Then
						iuo_comum.of_patch( ls_json_zerado, is_id_interface + ls_cod_barra_sec + '/price_stock', ref ls_retorno, ref ps_log )
					ENd if
					
				ENd if
				
			Next
			
		Case '6'
			iuo_comum.of_put( ls_json, is_id_interface, ref ls_retorno, ref ps_log )
	End Choose
	
	if ps_log <> '' and not isnull(ps_log) Then return false
	
	If ls_cd_produto_ecommerce = '' or isnull(ls_cd_produto_ecommerce) Then
		
		ls_cd_produto_ecommerce = string(il_cd_produto)
		
		insert into ecommerce_prd(id_ecommerce, id_rede_filial, cd_produto, cd_produto_ecommerce, dh_inclusao_prd, id_visivel_prd)
		Values( :is_id_ecommerce,
					:is_rede_filial,
					:il_cd_produto,
					:ls_cd_produto_ecommerce,
					:idh_data_atual,
					'S');
					
		if sqlca.sqlcode = -1 then
			ps_log = 'Problemas ao inserir registro na tabela "ecommerce_prd": ' + sqlca.sqlerrtext
			return false
		end if
		
		
	Else
		
		update ecommerce_prd
		set dh_atualizacao_prd = :idh_data_atual
		where id_ecommerce = :is_id_ecommerce
		and id_rede_filial = :is_rede_filial
		and cd_produto = :il_cd_produto;
		
		if sqlca.sqlcode = -1 then
			ps_log = 'Problemas ao atualizar registro na tabela "ecommerce_prd": ' + sqlca.sqlerrtext
			return false
		end if
		
	End if
	
	select count(*)
	into :ll_existe
	from ecommerce_prd_filial
	where id_ecommerce = :is_id_ecommerce
	and id_rede_filial = :is_rede_filial
	and cd_filial = :il_cd_filial
	and cd_produto = :il_cd_produto;
	
	if ll_existe = 0 or isnull(ll_existe) Then
		
		Insert into ecommerce_prd_filial(id_ecommerce, id_rede_filial, cd_produto, cd_filial, qt_saldo, dh_atualizacao )
		values( :is_id_ecommerce, :is_rede_filial, :il_cd_produto, :il_cd_filial, :il_qt_estoque, :idh_data_atual );
	
		if sqlca.sqlcode = -1 then
			ps_log = 'Problemas ao inserir registro na tabela "ecommerce_prd_filial": ~n' + sqlca.sqlerrtext
			return false
		end if

	else
	
		Update ecommerce_prd_filial
		set qt_saldo = :il_qt_estoque, dh_atualizacao = :idh_data_atual
		where id_ecommerce = :is_id_ecommerce
			and id_rede_filial = :is_rede_filial
			and cd_filial = :il_cd_filial
			and cd_produto = :il_cd_produto;
				
		if sqlca.sqlcode = -1 then
			ps_log = 'Problemas ao atualizar registro na tabela "ecommerce_prd_filial": ~n' + sqlca.sqlerrtext
			return false
		end if
		
	End if
	
	//Altera situacao para Processado
	if Not iuo_comum.of_altera_situacao_log_ecommerce( 'S', is_nm_tabela_log, il_cd_filial, string(il_cd_produto), ref ps_log ) Then return false			
				
Finally
	
ENd Try

return true
end function

public function boolean of_busca_saldo (long pl_cd_produto, ref long pl_qt_estoque, ref string ps_log);long ll_qt_estoque=0

Select coalesce(qt_saldo_filial, 0) - coalesce(qt_saldo_pendente, 0) - coalesce(qt_saldo_transferencia, 0) - coalesce(qt_saldo_prestes, 0)
into :ll_qt_estoque
from ecommerce_prd_filial
where id_ecommerce = '2'
and id_rede_filial = :is_rede_filial
and cd_produto = :pl_cd_produto
and cd_filial = :il_cd_filial ;

if sqlca.sqlcode = -1 then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_busca_saldo ; Problemas ao consultar a tabela "ecommerce_prd_filial": ' + sqlca.sqlerrtext
	return false
end if

if isnull(ll_qt_estoque) or ll_qt_estoque < 0 then ll_qt_estoque = 0

pl_qt_estoque = ll_qt_estoque

return true
end function

public function boolean of_monta_json (ref string ps_json, ref string ps_log);Choose Case is_id_ecommerce
	Case '5'

		ps_json = '{' + &
					 '"price": ' + gf_valor_com_ponto(idc_preco) + ', ' + &
					 '"stock": ' + String(this.il_qt_estoque)  + &
					'}'
			
	Case '6'	
		
		ps_json = '{' + &
					'"ean": ' + is_cod_barras_principal + ', ' + &
					' "price_original": ' + gf_valor_com_ponto(idc_preco_original) + ', ' + &
					 '"price": ' + gf_valor_com_ponto(idc_preco) + ', ' + &
					 '"available": ' + String(this.il_qt_estoque)  + ', ' + &
					 '"sku": "' + string(il_cd_produto) + '"' + &
					'}'
					
End Choose			

Return true
end function

private function boolean of_carrega_dados (ref long pl_linhas, ref string ps_log);Choose Case is_id_ecommerce
	Case '6'
		
		if Not this.iuo_comum.of_gerar_token( ref ps_log ) then return false
End Choose

idh_data_atual = gf_getserverdate()

pl_linhas = ids_dados.retrieve( is_id_ecommerce, is_rede_filial, il_cd_filial )

return true
end function

public subroutine of_configurar_parametros ();Choose Case is_id_ecommerce
	Case '5'
		is_id_interface = 'api/v1/store/products/'
		il_cd_mensagem_email = 289
	Case '6'
		is_id_interface = 'partner/v1/offer/ean/'
		
ENd Choose
end subroutine

public function boolean of_busca_cod_barra (long pl_cd_produto, ref string ps_cod_barra, ref string ps_cd_unidade_medida, ref string ps_log);string ls_cod_barra

select top 1 cbp.de_codigo_barras, cbp.cd_unidade_medida_venda
into :ls_cod_barra, :ps_cd_unidade_medida
from produto_geral p
	inner join codigo_barras_produto cbp on cbp.cd_produto = p.cd_produto 
Where cbp.cd_unidade_medida_venda = p.cd_unidade_medida_venda
and p.cd_produto = :pl_cd_produto
order by id_principal desc;

if sqlca.sqlcode = -1 then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_busca_cod_barra ; Problemas ao consultar a tabela "codigo_barras_produto": ' + sqlca.sqlerrtext
	return false
end if

ps_cod_barra = ls_cod_barra

return true
end function

on uo_ge509_produto.create
call super::create
end on

on uo_ge509_produto.destroy
call super::destroy
end on

