HA$PBExportHeader$uo_ge514_fabricante.sru
forward
global type uo_ge514_fabricante from uo_ge516_comum_interface_ecommerce
end type
end forward

global type uo_ge514_fabricante from uo_ge516_comum_interface_ecommerce
string is_id_ecommerce = "4"
string is_id_interface = "/api/v1/manufacturers"
long il_cd_tipo = 21
string is_datastore_dados = "ds_ge514_fabricante"
string is_objeto_comum = "uo_ge514_comum_vmpay"
boolean ib_atualiza_log_exportacao = true
boolean ib_log_individual = true
string is_nm_tabela_log = "FABRICANTE"
long il_cd_mensagem_email = 222
string is_mensagem_email_1 = "FABRICANTE"
end type
global uo_ge514_fabricante uo_ge514_fabricante

forward prototypes
private function boolean of_carrega_dados (ref long pl_linhas, ref string ps_log)
private function boolean of_processa_interface_itens (long pl_linha, ref boolean pb_gerar_log, ref string ps_log)
end prototypes

private function boolean of_carrega_dados (ref long pl_linhas, ref string ps_log);pl_linhas = ids_dados.retrieve( is_id_ecommerce )

return true
end function

private function boolean of_processa_interface_itens (long pl_linha, ref boolean pb_gerar_log, ref string ps_log);string ls_cd_fornecedor
string ls_json
string ls_nm_fornecedor
string ls_retorno
string ls_id_vmpay

long ll_existe

ls_cd_fornecedor = ids_dados.object.cd_fornecedor[pl_linha]
ls_nm_fornecedor = ids_dados.object.nm_razao_social[pl_linha]
il_cd_filial = ids_dados.object.cd_filial_ecommerce[pl_linha]

Select cd_fabricante_vmpay
into :ls_id_vmpay
from ecommerce_fabricante_vmpay
where cd_fornecedor = :ls_cd_fornecedor;

if sqlca.sqlcode = -1 then 
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_interface_itens; Problemas ao consultar a tabela "ecommerce_fabricante_vmpay": ' + sqlca.sqlerrtext
	return false
end if

ls_json = '{"manufacturer": {"name": "' + ls_nm_fornecedor + '"  }} '

iuo_comum.is_json = ls_json

If ls_id_vmpay = '' or isnull(ls_id_vmpay) Then
	
	iuo_comum.of_post( ls_json, is_id_interface, ref ls_retorno, ref ps_log )
	
	if ps_log <> '' and not isnull(ps_log) Then return false	
		
	insert into ecommerce_fabricante_vmpay(id_ecommerce, id_rede_filial, cd_fabricante_vmpay, cd_fornecedor)
	Values( :is_id_ecommerce,
				:is_rede_filial,
				:ls_retorno,
				:ls_cd_fornecedor);
				
	if sqlca.sqlcode = -1 then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_interface_itens; Problemas ao inserir registro na tabela "ecommerce_fabricante_vmpay": ' + sqlca.sqlerrtext
		return false
	end if
	
	
Else
	
	iuo_comum.of_patch( ls_json, is_id_interface + '/' + ls_id_vmpay , ref ls_retorno, ref ps_log )
	
	if ps_log <> '' and not isnull(ps_log) Then return false
	
End if

//Altera situacao para Processado
if Not iuo_comum.of_altera_situacao_log_ecommerce( 'S', is_nm_tabela_log, il_cd_filial, ls_cd_fornecedor, ref ps_log ) Then return false			
			
end function

on uo_ge514_fabricante.create
call super::create
end on

on uo_ge514_fabricante.destroy
call super::destroy
end on

