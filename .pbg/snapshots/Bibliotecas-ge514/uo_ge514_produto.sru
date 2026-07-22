HA$PBExportHeader$uo_ge514_produto.sru
forward
global type uo_ge514_produto from uo_ge516_comum_interface_ecommerce
end type
end forward

global type uo_ge514_produto from uo_ge516_comum_interface_ecommerce
string is_id_ecommerce = "4"
string is_id_interface = "/api/v1/products"
long il_cd_tipo = 2
string is_datastore_dados = "ds_ge514_produto"
string is_objeto_comum = "uo_ge514_comum_vmpay"
boolean ib_atualiza_log_exportacao = true
boolean ib_log_individual = true
string is_nm_tabela_log = "PRODUTO_GERAL"
long il_cd_mensagem_email = 222
string is_mensagem_email_1 = "PRODUTO"
end type
global uo_ge514_produto uo_ge514_produto

type variables
string is_de_produto
string is_cod_barras_principal
string is_cod_barras[]
string is_cd_categoria_vmpay
string is_cd_fabricante_vmpay

long il_cd_produto

decimal{3} idc_peso
end variables

forward prototypes
private function boolean of_processa_interface_itens (long pl_linha, ref boolean pb_gerar_log, ref string ps_log)
public function boolean of_monta_json (ref string ps_json, ref string ps_log)
public subroutine of_limpa_variaveis ()
end prototypes

private function boolean of_processa_interface_itens (long pl_linha, ref boolean pb_gerar_log, ref string ps_log);string ls_json
string ls_retorno
string ls_cd_fornecedor
string ls_cd_produto_vmpay

long ll_existe
long ll_for
long ll_linhas
long ll_cd_categoria_ecommerce

dc_uo_ds_base lds_cod_barras

lds_cod_barras = create dc_uo_ds_base
lds_cod_barras.of_changedataobject( 'ds_ge514_produto_cod_barras' )

is_de_produto = ids_dados.object.de_descricao_internet[pl_linha]
il_cd_produto = ids_dados.object.cd_produto[pl_linha]
il_cd_filial = ids_dados.object.cd_filial_ecommerce[pl_linha]
is_cod_barras_principal = ids_dados.object.de_codigo_barras[pl_linha]
idc_peso = ids_dados.object.qt_peso_grama[pl_linha]
ll_cd_categoria_ecommerce = ids_dados.object.cd_planograma[pl_linha]
ls_cd_fornecedor = ids_dados.object.cd_fornecedor[pl_linha]
ls_cd_produto_vmpay = ids_dados.object.cd_produto_ecommerce[pl_linha]

//*********************//
//Validar campos Obrigat$$HEX1$$f300$$ENDHEX$$rios:
//*********************//
ps_log = ''
if isnull(is_de_produto) or is_de_produto = '' Then
	ps_log += 'Sem descri$$HEX2$$e700e300$$ENDHEX$$o. '
end if

if isnull(ll_cd_categoria_ecommerce) or ll_cd_categoria_ecommerce = 0 Then
	ps_log += 'Sem categoria. '
end if

if isnull(ls_cd_fornecedor) or ls_cd_fornecedor = '' Then
	ps_log += 'Sem fabricante. '
end if

if ps_log <> '' then return false

//Busca o c$$HEX1$$f300$$ENDHEX$$digo VMPAY da categoria:
Select cd_categoria_vmpay
into :is_cd_categoria_vmpay
from ecommerce_categoria_vmpay
where id_ecommerce = :is_id_ecommerce
	and id_rede_filial = :is_rede_filial
	and cd_planograma = :ll_cd_categoria_ecommerce;

if sqlca.sqlcode = -1 then 
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_interface_itens; Problemas ao consultar a tabela "ecommerce_categoria_vmpay": ' + sqlca.sqlerrtext
	return false
end if

if isnull(is_cd_categoria_vmpay) or is_cd_categoria_vmpay = '' Then
	ps_log += 'A categoria n$$HEX1$$e300$$ENDHEX$$o possui c$$HEX1$$f300$$ENDHEX$$digo da VMPAY. '
end if

//Busca o c$$HEX1$$f300$$ENDHEX$$digo VMPAY do fornecedor:
Select cd_fabricante_vmpay
into :is_cd_fabricante_vmpay
from ecommerce_fabricante_vmpay
where id_ecommerce = :is_id_ecommerce
	and id_rede_filial = :is_rede_filial
	and cd_fornecedor = :ls_cd_fornecedor;

if sqlca.sqlcode = -1 then 
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_interface_itens; Problemas ao consultar a tabela "ecommerce_fabricante_vmpay": ' + sqlca.sqlerrtext
	return false
end if

if isnull(is_cd_fabricante_vmpay) or is_cd_fabricante_vmpay = '' Then
	ps_log += 'O fabricante/fornecedor n$$HEX1$$e300$$ENDHEX$$o possui c$$HEX1$$f300$$ENDHEX$$digo da VMPAY. '
end if

if ps_log <> '' then return false
//************************************************************************************************************//

//Busca os c$$HEX1$$f300$$ENDHEX$$digos de barras relacionados ao produto:
ll_linhas = lds_cod_barras.retrieve( il_cd_produto )

for ll_for = 1 to ll_linhas
	
	is_cod_barras[ll_for] = lds_cod_barras.object.de_codigo_barras[ll_for]	
	
Next
//************************************************************************************************************//

if Not this.of_monta_json( ref ls_json, ref ps_log ) Then return false

iuo_comum.is_json = ls_json
iuo_comum.il_cd_categoria = ll_cd_categoria_ecommerce
iuo_comum.il_cd_produto = il_cd_produto
iuo_comum.idc_qt_peso = idc_peso
iuo_comum.is_cd_fornecedor = ls_cd_fornecedor
iuo_comum.is_cd_ean = is_cod_barras_principal

If ls_cd_produto_vmpay = '' or isnull(ls_cd_produto_vmpay) Then
	//Se o produto ainda n$$HEX1$$e300$$ENDHEX$$o foi exportado pra VMPAY:
	
	iuo_comum.of_post( ls_json, is_id_interface, ref ls_retorno, ref ps_log )
	
	if ps_log <> '' and not isnull(ps_log) Then return false	
	
	if isnull(ls_retorno) or ls_retorno = '' Then
		ps_log = 'A interface da VMPAY n$$HEX1$$e300$$ENDHEX$$o retornou o c$$HEX1$$f300$$ENDHEX$$digo do produto ap$$HEX1$$f300$$ENDHEX$$s a inclus$$HEX1$$e300$$ENDHEX$$o.'
		return false
	end if
	
	insert into ecommerce_prd(id_ecommerce, id_rede_filial, cd_produto, cd_produto_ecommerce, dh_inclusao_prd, id_visivel_prd)
	Values( :is_id_ecommerce,
				:is_rede_filial,
				:il_cd_produto,
				:ls_retorno,
				getdate(),
				'S');
				
	if sqlca.sqlcode = -1 then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_interface_itens; Problemas ao inserir registro na tabela "ecommerce_prd": ' + sqlca.sqlerrtext
		return false
	end if
	
	
Else
	//Se o produto j$$HEX1$$e100$$ENDHEX$$ foi exportado pra VMPAY:
	
	iuo_comum.of_patch( ls_json, is_id_interface + '/' + ls_cd_produto_vmpay , ref ls_retorno, ref ps_log )
	
	if ps_log <> '' and not isnull(ps_log) Then return false
	
	update ecommerce_prd
	set dh_atualizacao_prd = getdate()
	where id_ecommerce = :is_id_ecommerce
	and id_rede_filial = :is_rede_filial
	and cd_produto = :il_cd_produto;
	
	if sqlca.sqlcode = -1 then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_interface_itens; Problemas ao atualizar registro na tabela "ecommerce_prd": ' + sqlca.sqlerrtext
		return false
	end if
	
End if

//Altera situacao para Processado
if Not iuo_comum.of_altera_situacao_log_ecommerce( 'S', is_nm_tabela_log, il_cd_filial, string(il_cd_produto), ref ps_log ) Then return false			
			

return true
end function

public function boolean of_monta_json (ref string ps_json, ref string ps_log);string ls_cod_barras_adicional=''
long ll_for, ll_linhas, ll_peso

ll_linhas = upperbound(is_cod_barras)

for ll_for = 1 to ll_linhas
	
	if is_cod_barras[ll_for] = is_cod_barras_principal Then continue
	
	ls_cod_barras_adicional = '{ "value": "' + is_cod_barras[ll_for] + '" }' 
	
	if ls_cod_barras_adicional <> '' and ll_for < ll_linhas then ls_cod_barras_adicional += ','
	
Next

if isnull( ls_cod_barras_adicional ) Then ls_cod_barras_adicional = ''

ll_peso = long( gf_replace( String(idc_peso), ',', '', 0) )

ps_json =  '{ "product": ' + &
				'{ "type": "Product", ' + & 
					' "name": "' + is_de_produto + '", ' + & 
					' "manufacturer_id": ' + is_cd_fabricante_vmpay + ', ' + &
					' "category_id": ' + is_cd_categoria_vmpay + ', ' + &
					' "barcode": "' + is_cod_barras_principal + '", ' + &
					' "upc_code": ' + string(il_cd_produto) + ', ' + &
					' "external_id": "' + string(il_cd_produto) + '", ' + &
					' "weight": ' + string(ll_peso) + ', ' + &
					' "additional_barcodes_attributes": [ ' + ls_cod_barras_adicional + ' ]  } } ' 
		
return true
end function

public subroutine of_limpa_variaveis ();string is_nulo[]

setnull( is_de_produto )
setnull( is_cod_barras_principal )
setnull( il_cd_produto )
setnull( is_cd_fabricante_vmpay )
setnull( is_cd_categoria_vmpay )
setnull( idc_peso )

is_cod_barras[] = is_nulo[]
end subroutine

on uo_ge514_produto.create
call super::create
end on

on uo_ge514_produto.destroy
call super::destroy
end on

