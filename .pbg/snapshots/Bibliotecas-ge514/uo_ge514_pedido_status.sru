HA$PBExportHeader$uo_ge514_pedido_status.sru
forward
global type uo_ge514_pedido_status from uo_ge516_comum_interface_ecommerce
end type
end forward

global type uo_ge514_pedido_status from uo_ge516_comum_interface_ecommerce
string is_id_ecommerce = "4"
long il_cd_tipo = 13
string is_datastore_dados = "ds_ge514_pedido_status"
string is_objeto_comum = "uo_ge514_comum_vmpay"
boolean ib_log_individual = true
long il_cd_mensagem_email = 222
string is_mensagem_email_1 = "PEDIDO - STATUS"
end type
global uo_ge514_pedido_status uo_ge514_pedido_status

type variables
String is_nr_pedido_ecommerce
Long il_nr_pedido
end variables

forward prototypes
public function boolean of_atualiza_pedido (string ps_status, ref string ps_log)
public function boolean of_busca_status_loja (ref string ps_status, ref string ps_log)
private function boolean of_carrega_dados (ref long pl_linhas, ref string ps_log)
private function boolean of_processa_interface_itens (long pl_linha, ref boolean pb_gerar_log, ref string ps_log)
end prototypes

public function boolean of_atualiza_pedido (string ps_status, ref string ps_log);
//Atualiza na Matriz
Update pedido_ecommerce
	Set id_situacao = :ps_status
Where cd_filial_ecommerce =:il_cd_filial
	AND nr_pedido =:il_nr_Pedido
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_pedido ; ' + 'Problemas ao atualizar a tabela "pedido_ecommerce": ' + SqlCa.sqlerrtext
	Return False
End If

Return True
end function

public function boolean of_busca_status_loja (ref string ps_status, ref string ps_log);string ls_id_situacao

If Not this.of_conecta_filial( ref ps_log ) Then Return false

Select id_situacao
into :ls_id_situacao
from pedido_drogaexpress
where nr_pedido_ecommerce_site = :is_nr_pedido_ecommerce
and id_plataforma_ecommerce = :is_id_ecommerce
Using itr_Filial;

if itr_Filial.sqlcode = -1 then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_busca_status_loja ; Problemas ao consultar a tabela "pedido_drogaexpress": ' + itr_Filial.sqlerrtext
	If Not this.of_desconecta_filial( ) Then Return false
	return false
end if

If Not this.of_desconecta_filial( ) Then Return false

if ls_id_situacao = '' or isnull(ls_id_situacao) Then
	ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar o pedido [' + is_nr_pedido_ecommerce + '] na filial [' + string(il_cd_filial) + '].'
	return false
end if

if ls_id_situacao = 'P'	then ls_id_situacao = 'A'
		
ps_status = ls_id_situacao	
		
return true
end function

private function boolean of_carrega_dados (ref long pl_linhas, ref string ps_log);pl_linhas = ids_dados.retrieve( is_id_ecommerce )

return true
end function

private function boolean of_processa_interface_itens (long pl_linha, ref boolean pb_gerar_log, ref string ps_log);string ls_id_situacao_pedido

is_nr_pedido_ecommerce = ids_dados.object.nr_pedido_ecommerce[pl_linha]
il_cd_filial = ids_dados.object.cd_filial[pl_linha]
il_nr_pedido = ids_dados.object.nr_pedido[pl_linha]
il_Filial_Disque = il_cd_filial
is_rede_filial = ids_dados.object.id_rede_filial[pl_linha]

is_mensagem_email_2 = 'Pedido: ' + is_nr_pedido_ecommerce

iuo_comum.is_rede_ecommerce = is_rede_filial

if il_Filial_desenv > 0 then
	il_cd_filial = il_Filial_desenv
end if

iuo_comum.il_qt_item_enviado_site = 1
iuo_comum.is_nr_pedido_ecommerce = is_nr_pedido_ecommerce
iuo_comum.il_cd_filial_pedido = il_cd_filial

//Busca a situa$$HEX2$$e700e300$$ENDHEX$$o do pedido na Loja
if Not this.of_busca_status_loja( ref ls_id_situacao_pedido, ref ps_log ) then return false

//Se n$$HEX1$$e300$$ENDHEX$$o houve altera$$HEX2$$e700e300$$ENDHEX$$o no status do pedido, passa para o pr$$HEX1$$f300$$ENDHEX$$ximo.
if ls_id_situacao_pedido = 'A' Then 
	return true
end if

//Atualiza a situa$$HEX2$$e700e300$$ENDHEX$$o do pedido na Matriz
if Not this.of_atualiza_pedido( ls_id_situacao_pedido, ref ps_log ) then return false

return true
end function

on uo_ge514_pedido_status.create
call super::create
end on

on uo_ge514_pedido_status.destroy
call super::destroy
end on

