HA$PBExportHeader$uo_ge501_vendas_dermaclub.sru
forward
global type uo_ge501_vendas_dermaclub from uo_ge516_comum_interface_ecommerce
end type
end forward

global type uo_ge501_vendas_dermaclub from uo_ge516_comum_interface_ecommerce
string is_id_ecommerce = "2"
long il_cd_tipo = 26
string is_datastore_dados = "ds_ge501_vendas_dermaclub"
string is_objeto_comum = "uo_ge516_comum_ecommerce"
boolean ib_enviar_email = false
long il_cd_mensagem_email = 289
string is_mensagem_email_1 = "DERMACLUB"
end type
global uo_ge501_vendas_dermaclub uo_ge501_vendas_dermaclub

type variables
dc_uo_ds_base ids_produtos
end variables

forward prototypes
private function boolean of_processa_interface_itens (long pl_linha, ref boolean pb_gerar_log, ref string ps_log)
private function boolean of_carrega_dados (ref long pl_linhas, ref string ps_log)
end prototypes

private function boolean of_processa_interface_itens (long pl_linha, ref boolean pb_gerar_log, ref string ps_log);long ll_nr_nf
long ll_cd_filial
long ll_cd_filial_ecommerce
long ll_nr_pedido
long ll_cd_convenio
long ll_linhas_prod
long ll_for
long ll_nr_sequencial
long ll_nr_sequencial_prod
long ll_cd_produto
long ll_qt_pedida
long ll_nr_campanha

string ls_de_especie
string ls_de_serie
string ls_cd_cliente
string ls_id_usa_desconto
string ls_nr_pedido_ecommerce

datetime ldh_venda

decimal{2} ldc_vl_preco, ldc_vl_preco_promo, ldc_vl_Desconto

ll_cd_convenio = 54567

ll_nr_nf = ids_dados.object.nr_nf[pl_linha]
ll_cd_filial = ids_dados.object.cd_filial[pl_linha]
ls_de_especie = ids_dados.object.de_especie[pl_linha]
ls_de_serie = ids_dados.object.de_serie[pl_linha]
ls_cd_cliente = ids_dados.object.cd_cliente[pl_linha]
ldh_venda = ids_dados.object.dh_emissao[pl_linha]
ll_cd_filial_ecommerce = ids_dados.object.cd_filial_ecommerce[pl_linha]
ll_nr_pedido = ids_dados.object.nr_pedido[pl_linha]
ls_nr_pedido_ecommerce = ids_dados.object.nr_pedido_ecommerce[pl_linha]

iuo_comum.il_cd_filial_pedido = ll_Cd_filial
iuo_comum.is_nr_pedido_ecommerce = ls_nr_pedido_ecommerce

if isnull(ll_nr_nf) or ll_nr_nf = 0 then
	ps_log = 'O n$$HEX1$$fa00$$ENDHEX$$mero da NF n$$HEX1$$e300$$ENDHEX$$o pode estar vazio.'
	return false
End if

if isnull(ll_cd_filial) or ll_cd_filial = 0 then
	ps_log = 'O n$$HEX1$$fa00$$ENDHEX$$mero da filial n$$HEX1$$e300$$ENDHEX$$o pode estar vazio.'
	return false
End if

if isnull(ls_cd_cliente) or ls_cd_cliente = '' then
	ps_log = 'O codigo do cliente n$$HEX1$$e300$$ENDHEX$$o pode estar vazio.'
	return false
End if

insert into venda_dermaclub (cd_filial, 
							nr_nf, 
							de_especie, 
							de_serie, 
							cd_convenio, 
							dh_venda, 
							cd_cliente, 
							id_enviada,
							nr_sessao)
values (:ll_cd_filial, :ll_nr_nf, :ls_de_especie, :ls_de_serie, :ll_cd_convenio, :ldh_venda, :ls_cd_cliente, 'N', null);

if sqlca.sqlcode = -1 then
	ps_log = 'Erro ao inserir registro na tabela venda_dermaclub: ' + sqlca.sqlerrtext
	return false
End if

ll_linhas_prod = ids_produtos.retrieve(ll_cd_filial_ecommerce,ll_nr_pedido )

if ll_linhas_prod < 1 then
	ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar os produtos relacionados a venda.'
	return false
End if

for ll_for = 1 to ll_Linhas_prod
	
	ll_Cd_produto = ids_produtos.object.cd_produto[ll_for]
	ll_nr_sequencial_prod = ids_produtos.object.nr_sequencial[ll_for]
	ll_qt_pedida = ids_produtos.object.qt_pedida[ll_for]
	ldc_vl_preco = ids_produtos.object.vl_preco[ll_for]
	ldc_vl_preco_promo = ids_produtos.object.vl_preco_promocao[ll_for]
	ls_id_usa_desconto = ids_produtos.object.id_usa_desconto_pbm[ll_for]
	ll_nr_campanha = long(ids_produtos.object.nr_campanha_pbm[ll_for])
	
	if ls_id_usa_desconto = 'S' Then
		ldc_vl_Desconto = ldc_vl_preco - ldc_vl_preco_promo
	Else
		ls_id_usa_desconto = 'N'
		ldc_vl_Desconto = 0
	End if
	
	insert into venda_dermaclub_produto (cd_filial, 
													nr_nf,
													de_especie,
													de_serie,
													nr_sequencial,
													cd_produto,
													nr_sequencial_venda,
													qt_vendida,
													vl_preco_unitario,
													vl_praticado,
													vl_desconto_dermaclub,
													id_dermaclub,
													nr_campanha)
	values(:ll_cd_filial, :ll_nr_nf, :ls_de_especie, :ls_de_serie, :ll_for, :ll_Cd_produto, :ll_nr_sequencial_prod, :ll_qt_pedida, :ldc_vl_preco, :ldc_vl_preco_promo, :ldc_vl_Desconto, :ls_id_usa_desconto, :ll_nr_campanha);
	
	
	if sqlca.sqlcode = -1 then
		ps_log = 'Erro ao inserir registro na tabela venda_dermaclub_produto: ' + sqlca.sqlerrtext
		return false
	End if
	
Next


end function

private function boolean of_carrega_dados (ref long pl_linhas, ref string ps_log);pl_linhas = ids_dados.retrieve( )

ids_produtos = create dc_uo_ds_base 

ids_produtos.of_changedataobject('ds_ge501_vendas_dermaclub_produto')

return true
end function

on uo_ge501_vendas_dermaclub.create
call super::create
end on

on uo_ge501_vendas_dermaclub.destroy
call super::destroy
end on

