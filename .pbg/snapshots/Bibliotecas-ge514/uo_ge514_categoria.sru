HA$PBExportHeader$uo_ge514_categoria.sru
forward
global type uo_ge514_categoria from uo_ge516_comum_interface_ecommerce
end type
end forward

global type uo_ge514_categoria from uo_ge516_comum_interface_ecommerce
string is_id_ecommerce = "4"
string is_id_interface = "/api/v1/categories"
long il_cd_tipo = 22
string is_datastore_dados = "ds_ge514_categoria"
string is_objeto_comum = "uo_ge514_comum_vmpay"
boolean ib_atualiza_log_exportacao = true
boolean ib_log_individual = true
string is_nm_tabela_log = "CATEGORIA"
long il_cd_mensagem_email = 222
string is_mensagem_email_1 = "CATEGORIA"
end type
global uo_ge514_categoria uo_ge514_categoria

forward prototypes
private function boolean of_carrega_dados (ref long pl_linhas, ref string ps_log)
private function boolean of_processa_interface_itens (long pl_linha, ref boolean pb_gerar_log, ref string ps_log)
end prototypes

private function boolean of_carrega_dados (ref long pl_linhas, ref string ps_log);pl_linhas = ids_dados.retrieve( is_id_ecommerce )

return true
end function

private function boolean of_processa_interface_itens (long pl_linha, ref boolean pb_gerar_log, ref string ps_log);string ls_json
string ls_de_planograma
string ls_retorno
string ls_id_vmpay

long ll_existe
long ll_cd_planograma

ll_cd_planograma = ids_dados.object.cd_planograma[pl_linha]
ls_de_planograma = ids_dados.object.de_planograma[pl_linha]
il_cd_filial = ids_dados.object.cd_filial_ecommerce[pl_linha]

Select cd_categoria_vmpay
into :ls_id_vmpay
from ecommerce_categoria_vmpay
where cd_planograma = :ll_cd_planograma
and id_ecommerce = :is_id_ecommerce;

if sqlca.sqlcode = -1 then 
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_interface_itens; Problemas ao consultar a tabela "ecommerce_categoria_vmpay": ' + sqlca.sqlerrtext
	return false
end if

ls_json = '{"name": "' + ls_de_planograma + '"  } '

iuo_comum.is_json = ls_json

If ls_id_vmpay = '' or isnull(ls_id_vmpay) Then
	
	iuo_comum.of_post( ls_json, is_id_interface, ref ls_retorno, ref ps_log )
	
	if ps_log <> '' and not isnull(ps_log) Then return false	
		
	insert into ecommerce_categoria_vmpay(id_ecommerce, id_rede_filial, cd_categoria_vmpay, cd_planograma)
	Values( :is_id_ecommerce,
				:is_rede_filial,
				:ls_retorno,
				:ll_cd_planograma);
				
	if sqlca.sqlcode = -1 then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_interface_itens; Problemas ao inserir registro na tabela "ecommerce_categoria_vmpay": ' + sqlca.sqlerrtext
		return false
	end if
	
	
Else
	
	iuo_comum.of_patch( ls_json, is_id_interface + '/' + ls_id_vmpay , ref ls_retorno, ref ps_log )
	
	if ps_log <> '' and not isnull(ps_log) Then return false
	
End if

//Altera situacao para Processado
if Not iuo_comum.of_altera_situacao_log_ecommerce( 'S', is_nm_tabela_log, il_cd_filial, string(ll_cd_planograma), ref ps_log ) Then return false			
			
end function

on uo_ge514_categoria.create
call super::create
end on

on uo_ge514_categoria.destroy
call super::destroy
end on

