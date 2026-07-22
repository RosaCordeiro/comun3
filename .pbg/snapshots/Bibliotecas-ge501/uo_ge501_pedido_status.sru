HA$PBExportHeader$uo_ge501_pedido_status.sru
forward
global type uo_ge501_pedido_status from nonvisualobject
end type
end forward

global type uo_ge501_pedido_status from nonvisualobject
end type
global uo_ge501_pedido_status uo_ge501_pedido_status

type variables
uo_ge501_comum iuo_comum_vtex

string is_datasource

string is_tipo_pedido
string is_objeto
string is_id_ecommerce = '2' //VTEX
string is_id_interface = 'api/oms/pvt/orders/'
string is_rede_filial
string is_ODBC_Desenv
string is_nr_pedido_ecommerce
string is_situacao_loja
string is_nr_pedido_drogaexpress
string is_url_rastreio
string is_nr_rastreio
string is_chave_acesso_nfe
string is_id_cotacao
string is_id_pedido_entrega
string is_pedido_debug
string is_nm_transportadora_ecommerce
string is_id_exige_nfe_entrega
string is_contem_manipulado
string is_Endereco_Ftp
string is_Usuario_Ftp
string is_Senha_Ftp
string is_diretorio_xml
string is_xml_nfe
string is_cd_forma_pagto
string is_de_cidade
string is_cd_uf

long il_nr_pedido
long il_filial_ecommerce
long il_cd_tipo = 13
long il_Filial_Desenv
long il_cd_filial_pedido
long il_nr_nota
long il_qt_volumes
long il_qt_pendente_faturamento

dc_uo_ds_base ids_pedidos
dc_uo_ds_base ids_filiais_sem_conexao

boolean ib_usa_pdv_java = false
boolean ib_producao
boolean ib_executar_todos_pedidos = false
boolean ib_debug = false

decimal idc_vl_nota

datetime idt_nota
datetime idh_validade_entrega_cotacao
datetime idh_data_Atual



end variables

forward prototypes
public subroutine of_limpa_variaveis ()
public function boolean of_desconecta_filial ()
public function boolean of_conecta_filial (ref string ps_log)
public function boolean of_atualiza_pedido (string ps_set_update, string ps_id_situacao, ref string ps_log)
public function boolean of_busca_filial_site (ref long pl_cd_filial, ref string ps_log)
public function boolean of_monta_json (string ps_status, ref string ps_json, ref string ps_log)
public function boolean of_reserva_etiqueta_correio (string ps_nm_transportadora, ref string ps_log)
public function boolean of_atualiza_pedido_rastreio (ref string ps_log)
public function boolean of_monta_json_rastreio (ref string ps_json)
public function boolean of_entrega_contratacao (ref string ps_log)
public function boolean of_processa_atualizacao_status (string ps_rede_filial)
public function boolean of_processa_atualizacao_rastreio (string ps_rede_filial)
public function boolean of_atualiza_pedido_loja (string ps_situacao, ref string ps_log)
public function boolean of_atualiza_pedido_loja (string ps_situacao, boolean lb_atualizar_endereco, ref string ps_log)
public function boolean of_entrega_cotacao (string ps_tipo_entrega, ref string ps_log)
public function boolean of_carrega_dados_pedido_loja (ref string ps_log, string ps_entrega, string ps_exige_nfse, ref boolean pb_continue)
public function boolean of_entrega_status (string ps_id_pedido, ref boolean pb_entregue, ref boolean pb_suspenso, ref string ps_log)
public function boolean of_cancelar_pedido (string ps_rede, long pl_cd_seller, long pl_cd_filial_ecommerce, long pl_nr_pedido, string ps_nr_pedido_ecommerce, string ps_nr_pedido_drogaexpress, ref string ps_log)
public function boolean of_grava_entrega (long pl_cd_filial, long pl_nr_pedido, string ps_nm_transportadora, decimal pdc_valor, long pl_dias_previsto, datetime pdh_validade, string ps_objeto, ref string ps_log)
public function boolean of_registra_coleta (string ps_tipo_entrega, ref string ps_log)
public function boolean of_busca_nfe_xml (long pl_cd_filial, string ps_chave_acesso, date pdt_emissao, ref string ps_xml_nfe, ref string ps_log)
public function boolean of_carrega_parametros_ftp (ref string ps_log)
end prototypes

public subroutine of_limpa_variaveis ();setnull(idc_vl_nota)
setnull(idt_nota)
setnull(il_nr_nota)
setnull(is_nr_pedido_ecommerce)
setnull(il_cd_filial_pedido)
setnull(is_situacao_loja)
setnull(is_nr_pedido_drogaexpress)
setnull(il_nr_nota)
setnull(il_qt_volumes)
setnull(il_qt_pendente_faturamento)
setnull(is_contem_manipulado)
setnull(il_nr_pedido)
setnull(is_url_rastreio)
setnull(is_chave_acesso_nfe)
setnull(is_nr_rastreio)
setnull(il_filial_ecommerce)
setnull(is_nm_transportadora_ecommerce )
setnull(idh_validade_entrega_cotacao)
setnull(is_tipo_pedido)
setnull(is_id_exige_nfe_entrega)
setnull(is_xml_nfe)
setnull(is_cd_forma_pagto)
setnull(is_de_cidade)
setnull(is_cd_uf)



end subroutine

public function boolean of_desconecta_filial ();return this.iuo_comum_vtex.of_desconecta_filial( )
end function

public function boolean of_conecta_filial (ref string ps_log);String ls_Odbc

//Primeiro Verifica se a filial esta na lista das filiais sem conexao:
if ids_filiais_sem_conexao.find('cd_filial = ' + string(il_cd_filial_pedido), 1, ids_filiais_sem_conexao.rowcount()) > 0 Then
	ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel estabelecer conex$$HEX1$$e300$$ENDHEX$$o com a Filial: ' + string(il_cd_filial_pedido) 
	return false
end if

if Not iuo_comum_vtex.of_conecta_filial( il_cd_filial_pedido, ref ps_log ) then
	
	//Adiciona filial na lista de filiais com problema de conexao:
	if ids_filiais_sem_conexao.find('cd_filial = ' + string(il_cd_filial_pedido), 1, ids_filiais_sem_conexao.rowcount()) = 0 Then
		ids_filiais_sem_conexao.insertrow(1)
		ids_filiais_sem_conexao.object.cd_filial[1] = il_cd_filial_pedido
	End if
	
	return false
end if

Return True
end function

public function boolean of_atualiza_pedido (string ps_set_update, string ps_id_situacao, ref string ps_log);string ls_Update

// Cancelado
If ps_id_situacao <> 'X' Then
	
	if ib_usa_pdv_java = false Then
		if Not this.of_atualiza_pedido_loja( ps_id_situacao, ref ps_log) Then return false
	end if
	
End If
	
//Atualiza na matriz	
ls_Update = "UPDATE pedido_ecommerce SET " + ps_Set_Update + " WHERE cd_filial_ecommerce = " + String( il_filial_ecommerce ) + " AND nr_pedido = " + String( il_nr_pedido )

Execute Immediate :ls_update Using SqlCa;

if sqlca.sqlcode = -1 then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_pedido. ' + 'Problemas ao atualizar registro na tabela "pedido_ecommerce": ' + sqlca.sqlerrtext
	return false
end if

if ps_id_situacao = 'M' Then

	update pedido_ecommerce
	set id_situacao = 'M'
	Where cd_filial_ecommerce = :il_filial_ecommerce
		and nr_pedido = :il_nr_pedido
	Using SqlCa;
	
	if SqlCa.sqlcode = -1 then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_pedido. ' + 'Problemas ao atualizar a tabela "pedido_ecommerce": ' + SqlCa.sqlerrtext
		return false
	end if

ENd if

update pedido_ecommerce_auxiliar
set dh_atualizacao_site  = getdate()
Where cd_filial_ecommerce = :il_filial_ecommerce
	and nr_pedido = :il_nr_pedido
Using SqlCa;

if SqlCa.sqlcode = -1 then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_pedido. ' + 'Problemas ao atualizar a tabela "pedido_ecommerce_auxiliar": ' + SqlCa.sqlerrtext
	return false
end if
	
return true
end function

public function boolean of_busca_filial_site (ref long pl_cd_filial, ref string ps_log);long ll_cd_filial_conexao

select top 1 ei.cd_filial_pedido
into :ll_cd_filial_conexao
	from ecommerce_log el
		 inner join ecommerce_log_item ei on ( ei.cd_filial = el.cd_filial and ei.nr_atualizacao = el.nr_atualizacao )
	where ei.nr_pedido_ecommerce = :is_nr_pedido_ecommerce
	and ei.id_rede_filial = :is_rede_filial
	and el.dh_inclusao >= dateadd(dd, -3, getdate())
	and ei.cd_filial_pedido > 0
	order by dh_inclusao desc;
				
if sqlca.sqlcode = -1 then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_busca_filial_site. ' + 'Problemas ao consultar a tabela "ecommerce_log_item" : ' + sqlca.sqlerrtext
	return false
end if
					
pl_cd_filial = ll_cd_filial_conexao
					
return true
end function

public function boolean of_monta_json (string ps_status, ref string ps_json, ref string ps_log);if isnull(is_chave_acesso_nfe) Then is_chave_acesso_nfe = ''
if isnull(is_xml_nfe) Then is_xml_nfe = ''

Choose Case ps_status
		
	//Faturado / Disponivel para retirada	/ 'M' //Postado
	Case 'F', 'D', 'M', 'C', 'X'

//		if is_url_rastreio <> '' and not isnull(is_url_rastreio) Then
//			
//			is_nr_rastreio = iif(IsNull(is_nr_rastreio), '', is_nr_rastreio)
//			
//			ps_json = '{' + &
//							' "type":"Output", ' + &
//							' "issuanceDate": "' + String(idt_nota,'yyyy-mm-dd hh:mm:ss') + '", ' + &
//							' "invoiceNumber":"' + String(il_nr_nota) + '", ' + &
//							' "invoiceValue":"' + gf_replace(string(idc_vl_nota), ',', '',0) + '", ' + &
//							' "invoiceKey":"' + is_chave_acesso_nfe + '", ' + &
//							' "trackingNumber":"' + is_nr_rastreio + '", ' + &
//							' "trackingUrl":"' + is_url_rastreio + '" ' + &
//							' }'
//			
//		else

			ps_json = '{' + &
							' "type":"Output", ' + &
							' "issuanceDate": "' + String(idt_nota,'yyyy-mm-dd hh:mm:ss') + '", ' + &
							' "invoiceNumber":"' + String(il_nr_nota) + '", ' + &
							' "invoiceValue":"' + gf_replace(string(idc_vl_nota), ',', '',0) + '", ' + &
							' "invoiceKey":"' + is_chave_acesso_nfe + '", ' + &
							' "embeddedInvoice":"' + is_xml_nfe + '" ' + &
							' }'
		//end if
		
	//Entregue
	Case 'E'
		
		ps_json = '{' + &
						' "isDelivered": true ,' + &
						' "deliveredDate": "' + String(idh_data_Atual,'yyyy-mm-dd hh:mm:ss') + '", ' + &	
						' "events": [ {' + &
						'"city": "' + is_de_cidade + '",' + &
						'"state": "' + is_Cd_uf + '",' + &
						'"description": "Entregue",' + &
						'"date": "' + String(idh_data_Atual,'yyyy-mm-dd hh:mm:ss') + '" }]' + &	
						' }'
						
End Choose
		

return true
end function

public function boolean of_reserva_etiqueta_correio (string ps_nm_transportadora, ref string ps_log);String ls_Nr_Etiqueta
String ls_de_servico

Long ll_Cd_Seq_Etiqueta
Long ll_Id_Servico
Datetime ldt_validade

//Quando for pedido da filial 454, usar etiquetas PAC Industrial/Sedex Industrial:
if il_cd_filial_pedido = 454 then
	if ps_Nm_Transportadora = 'SEDEX' then
		ls_de_servico = 'SEDEX INDUSTRIAL'
	Elseif ps_Nm_Transportadora = 'PAC' then
		ls_de_servico = 'PAC INDUSTRIAL'
	Else
		ls_de_servico = ps_Nm_Transportadora
	End if
else
	ls_de_servico = ps_Nm_Transportadora
End if

// Consulta o id_servico, que eh utilizado na reserva de etiquetas

SELECT id_servico
INTO :ll_Id_Servico
FROM ecommerce_servico_postagem
WHERE de_servico = :ls_de_servico
USING SqlCa;

If SqlCa.SqlCode = -1 Then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_reserva_etiqueta_correio. ' + 'Problemas ao consultar a tabela "ecommerce_servico_postagem":  ' + sqlca.sqlerrtext
	Return False
End If
		
SELECT nr_etiqueta_com_dig
   INTO :ls_Nr_Etiqueta
    FROM ecommerce_reserva_etiqueta
  WHERE nr_pedido = :il_nr_pedido
   USING sqlCa;
	
Choose Case SqlCa.SqlCode
	Case -1
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_reserva_etiqueta_correio. ' + 'Problemas ao consultar a tabela "ecommerce_reserva_etiqueta":  ' + sqlca.sqlerrtext
		Return False
		
	Case 0
		//ps_log = "Pedido: " + String(il_nr_pedido) + " | j$$HEX1$$e100$$ENDHEX$$ possui etiqueta reservada."
		//Return False	
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
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_reserva_etiqueta_correio. ' + 'Problemas ao consultar a tabela "ecommerce_reserva_etiqueta":  ' + sqlca.sqlerrtext
	Return False
End If						

If ll_Cd_Seq_Etiqueta <=0 Then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_reserva_etiqueta_correio. ' + 'N$$HEX1$$e300$$ENDHEX$$o foi encontrada etiqueta dispon$$HEX1$$ed00$$ENDHEX$$vel para o pedido.'
	Return False
End If

UPDATE ecommerce_reserva_etiqueta
	   SET nr_pedido 	= :il_nr_pedido,
			cd_filial_ecommerce = :il_filial_ecommerce
   WHERE cd_seq_etiqueta = :ll_Cd_Seq_Etiqueta
	 Using SqlCa;
 
If SqlCa.SqlCode = -1 Then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_reserva_etiqueta_correio. ' + 'Problemas ao atualizar registro na tabela "ecommerce_reserva_etiqueta":  ' + sqlca.sqlerrtext
	Return False
End If	

If Sqlca.SQLNRows <> 1 Then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_reserva_etiqueta_correio; ' + 'N$$HEX1$$e300$$ENDHEX$$o atualizou a quantidade esperada de registros'
	return false
End If

UPDATE pedido_ecommerce
	   SET de_codigo_rastreamento_correio = :ls_Nr_Etiqueta
   WHERE cd_filial_ecommerce = :il_filial_ecommerce
	  AND nr_pedido = :il_nr_Pedido
	 Using SqlCa;
	 
If SqlCa.SqlCode = -1 Then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_reserva_etiqueta_correio. ' + 'Problemas ao atualizar registro na tabela "pedido_ecommerce":  ' + sqlca.sqlerrtext
	Return False
End If	

If Sqlca.SQLNRows <> 1 Then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_reserva_etiqueta_correio 2; ' + 'N$$HEX1$$e300$$ENDHEX$$o atualizou a quantidade esperada de registros'
	return false
End If

If Not this.of_grava_entrega( il_filial_ecommerce, il_nr_pedido, ps_nm_transportadora, idc_vl_nota, 0, ldt_validade, ls_Nr_Etiqueta, ref ps_log ) Then return false

Return True

end function

public function boolean of_atualiza_pedido_rastreio (ref string ps_log);update pedido_ecommerce_auxiliar
set dh_atualizacao_site_rastreio  = getdate()
Where cd_filial_ecommerce = :il_filial_ecommerce
	and nr_pedido = :il_nr_pedido
Using SqlCa;

if SqlCa.sqlcode = -1 then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_pedido_rastreio. ' + 'Problemas ao atualizar a tabela "pedido_ecommerce_auxiliar": ' + SqlCa.sqlerrtext
	return false
end if
	
return true
end function

public function boolean of_monta_json_rastreio (ref string ps_json);is_nr_rastreio 	=  iif(Isnull(is_nr_rastreio), '', is_nr_rastreio)
is_url_rastreio 	=  iif(Isnull(is_url_rastreio), '', is_url_rastreio)
		
ps_json = '{' + &
				' "trackingNumber":"' + is_nr_rastreio + '", ' + &
				' "trackingUrl":"' + is_url_rastreio + '", ' + &
				' "courier": "' + is_nm_transportadora_ecommerce + '" ' + &
				' }'
Return true
end function

public function boolean of_entrega_contratacao (ref string ps_log);string ls_id_pedido, ls_url_rastreio
long ll_cd_filial_loja

uo_ge509_contratacao luo_contratacao

luo_contratacao = create uo_ge509_contratacao

//Integra$$HEX2$$e700e300$$ENDHEX$$o Equilibrium - Contratacao

Try

	Select pa.id_pedido_equilibrium, pe.de_url_rastreio, pe.cd_filial
	into :ls_id_pedido, :ls_url_rastreio, :ll_cd_filial_loja
	from pedido_ecommerce pe
		inner join pedido_ecommerce_auxiliar pa on (pa.cd_filial_ecommerce = pe.cd_filial_ecommerce and pa.nr_pedido = pe.nr_pedido)
	where pe.cd_filial_ecommerce = :il_filial_ecommerce
	and pe.nr_pedido = :il_nr_pedido;
	
	if sqlca.sqlcode = -1 then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_entrega_contratacao ; Problemas ao consultar a tabela "pedido_ecommerce_auxiliar": ' + sqlca.sqlerrtext
		return false
	end if

	if ls_id_pedido = '' or isnull(ls_id_pedido) Then
		
		ls_id_pedido = ''
		ls_url_rastreio = ''
		if Not luo_contratacao.of_processa_contratacao( il_filial_ecommerce, ll_cd_filial_loja, il_nr_pedido, is_id_cotacao, ref ls_id_pedido, ref ls_url_rastreio, ref ps_log ) Then return false
	
	End if
	
	is_id_pedido_entrega = ls_id_pedido
	is_url_rastreio = ls_url_rastreio

Finally
	destroy(luo_contratacao)
end Try

return true

end function

public function boolean of_processa_atualizacao_status (string ps_rede_filial);String ls_Chave_Nula
String ls_MSG_Nula
String ls_Log
String ls_Situacao
String ls_json
String ls_id_situacao
String ls_status
String ls_Set_Update
String ls_nm_transportadora
String ls_retorno
String ls_update
String ls_id_tipo_entrega
String ls_id_registro_log
string ls_Exige_NFSE
string ls_Rede_Retrieve
string ls_tipo_entrega_equilibrium
string ls_entrega_rapida = 'N'
string ls_entrega_transportadora = 'N'

Long ll_linhas
Long ll_for
Long ll_Seq_Log
Long ll_existe
Long ll_cd_filial_ant
Long ll_cd_filial_site
Long ll_Filial_Erro_Conexao
Long ll_Seller
Long ll_Filial_Log

boolean lb_entrega_suspensa = false
boolean lb_continue=false
boolean lb_sucesso=false
boolean lb_atualiza_status = false
boolean lb_pedido_entregue = false
datetime ldt_inicio, ldt_termino

DateTime ldh_Faturado
Datetime ldh_geracao_plp

DateTime ldh_Data_Nula

SetNull(ls_Chave_Nula)
SetNull(ls_MSG_Nula)
SetNull(ldh_Data_Nula)
SetNull(ll_Filial_Erro_Conexao)

//Manipula$$HEX2$$e700e300$$ENDHEX$$o, faz a pesquisa pela MP e retorna para DC pois a venda de manipulado ocorre na DC
If ps_rede_filial = 'MP' Then
	ls_Rede_Retrieve = 'MP'
	ps_rede_filial = 'DC'
Else
	ls_Rede_Retrieve = ps_rede_filial
End If

is_rede_filial = ps_rede_filial

if ls_Rede_Retrieve = 'MP' or ib_executar_todos_pedidos = True then
	ls_entrega_rapida = 'S' 
	ls_entrega_transportadora = 'S'
	
elseif il_cd_tipo = 25 then
	ls_entrega_rapida = 'S' //Executar apenas para pedidos com entrega r$$HEX1$$e100$$ENDHEX$$pida (Retirada em loja, Motoboy, etc)
	ls_entrega_transportadora = 'N'
	
Else
	ls_entrega_rapida = 'N'
	ls_entrega_transportadora = 'S' //Executar apenas para pedidos com entrega por transportadora (Correios, Jadlog, etc)
	
ENd if

try 
	idh_data_Atual = gf_getserverdate()
	ls_situacao = 'P'
	
	Open(w_Ge501_Aguarde)
	
	w_Ge501_Aguarde.Title = "Vtex - Status Ped. (ERP -> Site)"

	iuo_comum_vtex = create uo_ge501_comum
	ids_pedidos = create dc_uo_ds_base
	ids_filiais_sem_conexao = create dc_uo_ds_base
	
	If gvo_Aplicacao.ivs_DataSource = 'central'  Then 
		ib_producao = True
	else
		ib_producao = False
	end if
	
	//Desenvolvimento
	il_Filial_Desenv 	= iuo_comum_vtex.of_desenvolvimento_filial_baixa_pedido()
	is_ODBC_Desenv 	= iuo_comum_vtex.of_desenvolvimento_odbc_baixa_pedido()
	
	iuo_comum_vtex.is_odbc_desenv = is_ODBC_Desenv
	
	//Carrega os parametros e busca o c$$HEX1$$f300$$ENDHEX$$digo da filial vinculado a rede.
	if Not iuo_comum_vtex.of_parametros_ecommerce(is_id_ecommerce, is_rede_filial, ref ll_Filial_Log, ref ls_Log ) Then return false
	
	setnull(ls_id_registro_log)
	iuo_comum_vtex.of_grava_log_historico(ref ls_id_registro_log, ll_Filial_Log, il_cd_tipo, idh_data_Atual, ldh_Data_Nula, 'C', 0, ref ls_log )
	
	if not ids_pedidos.of_changedataobject( 'ds_ge501_pedido_status' , false) Then
		ls_Log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_status ~n' + 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ds_ge501_pedido_status'
		return false
	end if
	
	if Not ids_filiais_sem_conexao.of_changedataobject( 'ds_ge501_filiais_ecommerce') then
		ls_Log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_status. ~n' + ' N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ds_ge501_filiais_ecommerce'
		return false
	end if
	
//	If gvo_Aplicacao.ivs_DataSource <> 'central' then
//		ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_status, a atualiza$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o pode ser a partir do HOMOLOGA.'
//		return false
//	End If

	if not this.of_carrega_parametros_ftp( ref ls_log) then
		return false
	end if
	
	ll_linhas = ids_pedidos.retrieve( ls_Rede_Retrieve, ls_entrega_rapida, ls_entrega_transportadora )

	if ll_linhas < 0 Then
		ls_Log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_pedido ~n' + 'Problemas ao consultar o banco de dados na seguinte datawindow: ds_ge501_pedido_status Erro: ' + sqlca.is_lasterrortext
		return false
	end if

	If ll_Linhas > 0 Then
		iuo_comum_vtex.il_qt_item_enviado_site = ll_linhas
         // Grava in$$HEX1$$ed00$$ENDHEX$$cio do processo
		If Not iuo_comum_vtex.of_grava_log(ll_Filial_Log, il_cd_tipo, ls_Chave_Nula, 'C', ls_MSG_Nula, gf_getserverdate(), gf_getserverdate(), ref ls_Log, ref ll_Seq_Log ) Then Return False
	End If
	
	w_Ge501_Aguarde.uo_progress.of_setmax(ll_Linhas)
	
	for ll_for = 1 to ll_linhas
		
		ls_log 					= ''
		ls_set_update 			= ''
		lb_atualiza_status 		= false
		ls_tipo_entrega_equilibrium = ''
		lb_continue = false
		
		setnull(is_id_pedido_entrega)
		setnull(is_id_cotacao)
		
		this.of_limpa_variaveis( )
		
		iuo_comum_vtex.of_limpa_variaveis( )
		
		is_nr_pedido_ecommerce 	=	ids_pedidos.object.nr_pedido_ecommerce[ll_for]
		ll_Seller							= ids_pedidos.object.cd_seller					[ll_for]
		ls_Exige_NFSE					= ids_pedidos.object.id_exige_nfse			[ll_for]
				
		If not IsNull(is_pedido_debug) and Trim(is_pedido_debug) <> '' Then
			If is_nr_pedido_ecommerce <>  is_pedido_debug Then
				w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
				Continue
			End If
		End If
		
		If Not IsNull(il_Filial_Desenv) Then
			il_cd_filial_pedido = il_Filial_Desenv		
			this.of_busca_filial_site( ref ll_cd_filial_site, ref ls_log )
			
			If ls_Log <> '' and not isnull(ls_Log) Then
				iuo_comum_vtex.of_envia_email(211, 'STATUS - [' + ps_rede_filial + ']', ll_Seq_Log, 'Pedido: '  + is_nr_pedido_ecommerce + ' - ' +  ls_Log, is_nr_pedido_ecommerce)
				iuo_comum_vtex.of_grava_log_item( ll_Filial_Log, ll_Seq_Log, ref ls_Log, ls_Log )
				ls_Situacao = 'E'
				ls_Log = ''
				w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
				Continue
			end if
			
		Else
			il_cd_filial_pedido = ids_pedidos.object.cd_filial[ll_for]
			ll_cd_filial_site = il_cd_filial_pedido
			
			If ll_cd_filial_site = 454 and is_rede_filial <> 'FA' Then 
				ll_cd_filial_site =  ids_pedidos.object.cd_filial_ecommerce[ll_for]
			End If
		End If
		
		If IsNull(ll_Seller) Then
			ll_Seller = ll_cd_filial_site
		End If
		
		iuo_comum_vtex.is_nr_pedido_ecommerce = is_nr_pedido_ecommerce
		iuo_comum_vtex.il_cd_filial_pedido 			= ll_Seller
		
		//Carrega os parametros e busca o c$$HEX1$$f300$$ENDHEX$$digo da filial vinculado a rede.
		if Not iuo_comum_vtex.of_parametros_ecommerce_filial( ll_Seller, is_rede_filial, is_id_ecommerce, ref ls_log ) Then
			iuo_comum_vtex.of_envia_email(211, 'STATUS - [' + ps_rede_filial + ']', ll_Seq_Log, 'Pedido: '  + is_nr_pedido_ecommerce + ' - ' +  ls_Log, is_nr_pedido_ecommerce)
			iuo_comum_vtex.of_grava_log_item( ll_Filial_Log, ll_Seq_Log, ref ls_Log, ls_Log )
			ls_Situacao = 'E'
			w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
			ll_Filial_Erro_Conexao  = il_cd_filial_pedido
			Continue
		end if
		
	
		il_nr_pedido = ids_pedidos.object.nr_pedido[ll_for]
		il_filial_ecommerce = ids_pedidos.object.cd_filial_ecommerce[ll_for]
		idt_nota = ids_pedidos.object.dh_emissao[ll_for]
		il_nr_nota = ids_pedidos.object.nr_nf[ll_for]
		idc_vl_nota = ids_pedidos.object.vl_total_nf[ll_for]
		ls_id_situacao = ids_pedidos.object.id_situacao[ll_for]
		is_nr_pedido_drogaexpress = ids_pedidos.object.nr_pedido_drogaexpress[ll_for]
		ls_nm_transportadora = ids_pedidos.object.nm_transportadora[ll_for]
		ls_id_tipo_entrega = ids_pedidos.object.id_tipo_entrega[ll_for]
		ldh_Faturado = ids_pedidos.object.dh_faturado[ll_for]
		is_chave_acesso_nfe = ids_pedidos.object.de_chave_acesso[ll_for]
		is_nr_rastreio = ids_pedidos.Object.de_Codigo_Rastreamento_Correio[ll_for]
		is_id_pedido_entrega = ids_pedidos.Object.id_pedido_equilibrium[ll_for]
		is_tipo_pedido = ids_pedidos.Object.id_tipo_pedido[ll_for]
		is_id_exige_nfe_entrega = ids_pedidos.Object.id_exige_nfse_entrega[ll_for]
		is_cd_forma_pagto = ids_pedidos.Object.cd_forma_pagamento[ll_for]
		is_de_cidade = ids_pedidos.Object.de_cidade_ent[ll_for]
		is_cd_uf = ids_pedidos.Object.cd_uf_ent[ll_for]
		ldh_geracao_plp = ids_pedidos.Object.dh_geracao_plp[ll_for]
		
		if isnull(is_tipo_pedido) Then is_tipo_pedido = 'SLR'		
				
		w_Ge501_Aguarde.Title = "Vtex - Status Ped. (ERP->Site) - "  + String(ll_for)  + " de " + STring(ll_Linhas)
		w_Ge501_Aguarde.st_msg.Text = "Pedido: " + is_nr_pedido_ecommerce + " - ["+ String(il_cd_filial_pedido) + "]"
		
		If Not IsNull(ll_Filial_Erro_Conexao) Then
			If ll_Filial_Erro_Conexao = il_cd_filial_pedido Then
				w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
				Continue
			End If
		End If
		
		gf_retorna_loja_pdv_novo(il_cd_filial_pedido, ref ib_usa_pdv_java, ref ls_log )
		if ls_log <> '' and not isnull(ls_log) Then
			iuo_comum_vtex.of_envia_email(211, 'STATUS - [' + ps_rede_filial + ']', ll_Seq_Log, 'Pedido: '  + is_nr_pedido_ecommerce + ' - ' +  ls_Log, is_nr_pedido_ecommerce)
			iuo_comum_vtex.of_grava_log_item( ll_Filial_Log, ll_Seq_Log, ref ls_Log, ls_Log )
			ls_Situacao = 'E'
			w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
			ll_Filial_Erro_Conexao  = il_cd_filial_pedido
			Continue
		End if
		
		//Valida$$HEX1$$e700$$ENDHEX$$ao incluida para avisar quando o pedido nao foi integrado com as lojas PDV novo. (Union 5)
		if ib_usa_pdv_java = True and (is_nr_pedido_drogaexpress = '' or isnull(is_nr_pedido_drogaexpress)) and (ls_id_situacao = 'A' or ls_id_situacao = 'G') Then
			ls_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel integrar o pedido com a loja [PDV Java].'
			iuo_comum_vtex.of_envia_email(211, 'STATUS - [' + ps_rede_filial + ']', ll_Seq_Log, 'Pedido: '  + is_nr_pedido_ecommerce + ' - ' +  ls_Log, is_nr_pedido_ecommerce)
			iuo_comum_vtex.of_grava_log_item( ll_Filial_Log, ll_Seq_Log, ref ls_Log, ls_Log )
			ls_Situacao = 'E'
			ls_Log = ''
			w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
			Continue
		End if
		
		//Se o pedido for de filial PDV java, j$$HEX1$$e100$$ENDHEX$$ tiver sido faturado, mas a situa$$HEX1$$e700$$ENDHEX$$ao ainda estiver aberta: Muda a situa$$HEX1$$e700$$ENDHEX$$ao pra F
		if ib_usa_pdv_java = True and ls_id_situacao = 'A' and il_nr_nota > 0 and not isnull(il_nr_nota) then
			ls_id_situacao = 'F'
		End if
		
		if ll_cd_filial_ant <> il_cd_filial_pedido or isnull(ll_cd_filial_ant) Then
			ll_cd_filial_ant = il_cd_filial_pedido
			If Not this.of_desconecta_filial( ) Then Return false
			
			if Not ib_usa_pdv_java Then
				If Not this.of_conecta_filial( ref ls_log ) Then 
					iuo_comum_vtex.of_envia_email(211, 'STATUS - [' + ps_rede_filial + ']', ll_Seq_Log, 'Pedido: '  + is_nr_pedido_ecommerce + ' - ' +  ls_Log, is_nr_pedido_ecommerce)
					iuo_comum_vtex.of_grava_log_item( ll_Filial_Log, ll_Seq_Log, ref ls_Log, ls_Log )
					ls_Situacao = 'E'
					w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
					ll_Filial_Erro_Conexao  = il_cd_filial_pedido
					ls_log = ''
					Continue
				End If
			End if
		Else
			
			//Verifica se a filial esta na lista das filiais sem conexao:
			if ids_filiais_sem_conexao.find('cd_filial = ' + string(il_cd_filial_pedido), 1, ids_filiais_sem_conexao.rowcount()) > 0 Then
				ls_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel estabelecer conex$$HEX1$$e300$$ENDHEX$$o com a Filial: ' + string(il_cd_filial_pedido) 
				iuo_comum_vtex.of_envia_email(211, 'STATUS - [' + ps_rede_filial + ']', ll_Seq_Log, 'Pedido: '  + is_nr_pedido_ecommerce + ' - ' +  ls_Log, is_nr_pedido_ecommerce)
				iuo_comum_vtex.of_grava_log_item( ll_Filial_Log, ll_Seq_Log, ref ls_Log, ls_Log )
				ls_Situacao = 'E'
				w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
				ll_Filial_Erro_Conexao  = il_cd_filial_pedido
				Continue
			end if
			
		end if
		
//		If il_nr_pedido = 600153760  or il_filial_ecommerce = 325 Then
//			w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
//			Continue
//		End If
		
		SetNull(ll_Filial_Erro_Conexao)
		
		//Cancelar pedidos com pagamento pendente a mais de 8 dias:
		if ls_id_situacao = 'G' Then
		
			this.of_cancelar_pedido( ps_rede_filial, ll_seller, il_filial_ecommerce, il_nr_pedido, is_nr_pedido_ecommerce, is_nr_pedido_drogaexpress, ref ls_log )
			
			If ls_Log <> '' and not isnull(ls_Log) Then
				iuo_comum_vtex.of_envia_email(211, 'STATUS - [' + ps_rede_filial + ']', ll_Seq_Log, 'Pedido: '  + is_nr_pedido_ecommerce + ' - ' +  ls_Log, is_nr_pedido_ecommerce)
				iuo_comum_vtex.of_grava_log_item( ll_Filial_Log, ll_Seq_Log, ref ls_Log, ls_Log )
				ls_Situacao = 'E'
				ls_Log = ''
				w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
				if ib_usa_pdv_java = false Then
					If Not gf_ge501_RollBack(iuo_comum_vtex.itr_filial) Then Return False
				end if
				Continue
			ENd if
			
			
		Else
			
			// Busca os dados da loja se na matriz ainda estiver como A - ABERTO ou diferente
			// de aberto sem nota (este segundo pode acontecer caso a nf ainda n$$HEX1$$e300$$ENDHEX$$o esteja na matriz)
			If ls_id_situacao = 'A' or IsNull(il_nr_nota) Then
				this.of_carrega_dados_pedido_loja( ref ls_log, ls_id_tipo_entrega, ls_exige_nfse, ref lb_continue )
				
				If ls_Log <> '' and not isnull(ls_Log) Then
					iuo_comum_vtex.of_envia_email(211, 'STATUS - [' + ps_rede_filial + ']', ll_Seq_Log, 'Pedido: '  + is_nr_pedido_ecommerce + ' - ' +  ls_Log, is_nr_pedido_ecommerce)
					iuo_comum_vtex.of_grava_log_item( ll_Filial_Log, ll_Seq_Log, ref ls_Log, ls_Log )
					ls_Situacao = 'E'
					ls_Log = ''
					w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
					if ib_usa_pdv_java = false Then
						If Not gf_ge501_RollBack(iuo_comum_vtex.itr_filial) Then Return False
					end if
					Continue
				ENd if
				
				//Se o pedido foi aprovado na matriz e ainda est$$HEX1$$e100$$ENDHEX$$ como pendente na Filial (Pode acontecer em casos de endere$$HEX1$$e700$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido. Em que o status do pedido $$HEX1$$e900$$ENDHEX$$ alterado para aprovado no sistema Ecommerce).
				//Atualiza a situa$$HEX2$$e700e300$$ENDHEX$$o na filial para Aprovado e atualiza o endere$$HEX1$$e700$$ENDHEX$$o na loja.
				if ls_id_situacao = 'A' and is_situacao_loja = 'G' Then
					
					//Se for entrega expressa/economica (Equilibrium) gera cota$$HEX2$$e700e300$$ENDHEX$$o:
					if ls_id_tipo_entrega = 'EXP' or ls_id_tipo_entrega = 'ECM' Then
						
						if ls_id_tipo_entrega = 'EXP' Then 
							ls_tipo_entrega_equilibrium = '2'
						else
							ls_tipo_entrega_equilibrium = '1'
						end if
						
						//Realiza cota$$HEX2$$e700e300$$ENDHEX$$o da entrega
						this.of_entrega_cotacao( ls_tipo_entrega_equilibrium, ref ls_log )
						If ls_Log <> '' and not isnull(ls_Log) Then
							iuo_comum_vtex.of_envia_email(211, 'STATUS - [' + ps_rede_filial + ']', ll_Seq_Log, 'Pedido: '  + is_nr_pedido_ecommerce + ' - ' +  ls_Log, is_nr_pedido_ecommerce)
							iuo_comum_vtex.of_grava_log_item( ll_Filial_Log, ll_Seq_Log, ref ls_Log, ls_Log )
							ls_Situacao = 'E'
							ls_Log = ''
							w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
							if ib_usa_pdv_java = false Then
								If Not gf_ge501_RollBack(iuo_comum_vtex.itr_filial) Then Return False
							end if
							Continue
						ENd if
							
						
					end if
					
					this.of_atualiza_pedido_loja( ls_id_situacao, True, ref ls_log)
					
					If ls_Log <> '' and not isnull(ls_Log) Then
						iuo_comum_vtex.of_envia_email(211, 'STATUS - [' + ps_rede_filial + ']', ll_Seq_Log, 'Pedido: '  + is_nr_pedido_ecommerce + ' - ' +  ls_Log, is_nr_pedido_ecommerce)
						iuo_comum_vtex.of_grava_log_item( ll_Filial_Log, ll_Seq_Log, ref ls_Log, ls_Log )
						ls_Situacao = 'E'
						ls_Log = ''
						w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
						if ib_usa_pdv_java = false Then
							If Not gf_ge501_RollBack(iuo_comum_vtex.itr_filial) Then Return False
						end if
						Continue
					Else
						if ib_usa_pdv_java = false Then
							If Not gf_ge501_commit(iuo_comum_vtex.itr_filial) Then Return False
						end if
						iuo_comum_vtex.of_grava_log_item( ll_Filial_Log, ll_Seq_Log, ref ls_Log, ls_Log )
						w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)	
						Continue	
					end if
					
				end if
				
				ls_id_situacao = is_situacao_loja
				
				If ls_id_situacao = 'A' Then
					//ls_Log = 'O PEDIDO AINDA NAO FOI FATURADO'
					iuo_comum_vtex.of_grava_log_item( ll_Filial_Log, ll_Seq_Log, ref ls_Log, ls_Log )
					w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
					Continue
				End If
				
			End If
			
			Choose Case ls_id_situacao
				// Pedido faturado e em seguida cancelado	
				Case 'X'
					ls_Set_Update += iif(ls_Set_Update = '', 'dh_faturado = getdate()',', dh_faturado = getdate()')
					
				//Faturado	
				Case 'F'
					// Atualiza STATUS site
					lb_atualiza_status = True
					
					// DISPONIVEL (RET - RETIRAR NA LOJA OU ARM - ARMARIO INTELIGENTE)
					if ls_id_tipo_entrega = 'RET' or ls_id_tipo_entrega = 'ARM' Then ls_id_situacao = 'D'
					
					ls_Set_Update += iif(ls_Set_Update = '', 'dh_faturado = getdate()',', dh_faturado = getdate()')
					
				//Dispon$$HEX1$$ed00$$ENDHEX$$vel
				Case 'D'
					ls_Set_Update += iif(ls_Set_Update = '', 'dh_faturado = getdate()',', dh_faturado = getdate()')
	
				//Aprovado
				Case 'A'
				Case 'E' // Entregue	
					ls_Set_Update += iif(ls_Set_Update = '', 'dh_entrega = getdate()',', dh_entrega = getdate()')
					
					If IsNull(ldh_Faturado) Then
						ls_Set_Update += iif(ls_Set_Update = '', 'dh_faturado = getdate()',', dh_faturado = getdate()')
					End IF
					
				Case 'M' // POSTADO - ALTERADO NA RL162 QUANDO O MOTOBOY SAIU PARA ENTREGA
					ls_Set_Update += iif(ls_Set_Update = '', 'dh_embarque = getdate()',', dh_embarque = getdate()')
					
					If IsNull(ldh_Faturado) Then
						ls_Set_Update += iif(ls_Set_Update = '', 'dh_faturado = getdate()',', dh_faturado = getdate()')
					End IF
					
				Case 'C' // Comunica com a transportadora para verificar situa$$HEX2$$e700e300$$ENDHEX$$o do pedido
				
					//Se for entrega expressa (Integra$$HEX2$$e700e300$$ENDHEX$$o Equilibrium):
					If ls_id_tipo_entrega = 'EXP' or ls_id_tipo_entrega = 'ECM'Then
						
						this.of_entrega_status( is_id_pedido_entrega, ref lb_pedido_entregue, ref lb_entrega_suspensa, ref ls_log )
						
						If ls_Log <> '' and not isnull(ls_Log) Then
							iuo_comum_vtex.of_envia_email(211, 'STATUS - [' + ps_rede_filial + ']', ll_Seq_Log, 'Pedido: '  + is_nr_pedido_ecommerce + ' - ' +  ls_Log, is_nr_pedido_ecommerce)
							iuo_comum_vtex.of_grava_log_item( ll_Filial_Log, ll_Seq_Log, ref ls_Log, ls_Log )
							ls_Situacao = 'E'
							ls_Log = ''
							w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
							Continue
						end if
						
						if lb_entrega_suspensa = True Then
		
							Update pedido_ecommerce_auxiliar
							set id_ignorar_integracao_status = 'S'
							where cd_filial_ecommerce = :il_filial_ecommerce
							and nr_pedido = :il_nr_pedido;
							
							If sqlca.sqlcode = -1 then
								ls_log = 'Erro ao atualizar a tabela pedido_ecommerce_auxiliar: ' + sqlca.sqlerrtext
								if ib_usa_pdv_java = false Then
									If Not gf_ge501_rollback(iuo_comum_vtex.itr_filial) Then Return False
								end if
								If Not gf_ge501_rollback(SQLCA) Then Return False
								iuo_comum_vtex.of_envia_email(211, 'STATUS - [' + ps_rede_filial + ']', ll_Seq_Log, 'Pedido: '  + is_nr_pedido_ecommerce + ' - ' +  ls_Log, is_nr_pedido_ecommerce)
								iuo_comum_vtex.of_grava_log_item( ll_Filial_Log, ll_Seq_Log, ref ls_Log, ls_Log )
								ls_Situacao = 'E'
								ls_Log = ''
								w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
								Continue
							End if
							
							if ib_usa_pdv_java = false Then
								If Not gf_ge501_commit(iuo_comum_vtex.itr_filial) Then Return False
							end if
							If Not gf_ge501_commit(SQLCA) Then Return False
						
							w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)	
							
							Continue	
							
						elseif lb_pedido_entregue = True Then
							//Se o pedido foi entregue muda a situa$$HEX2$$e700e300$$ENDHEX$$o para entregue.
							
							ls_id_situacao = 'E'
							
							ls_Set_Update += iif(ls_Set_Update = '', 'dh_entrega = getdate()',', dh_entrega = getdate()')
							
							If IsNull(ldh_Faturado) Then
								ls_Set_Update += iif(ls_Set_Update = '', 'dh_faturado = getdate()',', dh_faturado = getdate()')
							End IF
							
						else
							if ib_usa_pdv_java = false Then
								If Not gf_ge501_commit(iuo_comum_vtex.itr_filial) Then Return False
							end if
							If Not gf_ge501_commit(SQLCA) Then Return False
						
							w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)	
							
							Continue	
						end if
						
					end if
					
				Case else
					If IsNull(ls_id_situacao) Then ls_id_situacao = 'NULA'
					
					if ib_usa_pdv_java = false and ls_id_situacao = 'NULA' and is_nr_pedido_drogaexpress <> '' and not isnull(is_nr_pedido_drogaexpress) Then
						//Se existe nr_pedido_drogaexpress, e nao encontrou o pedido na base da loja, seta nulo no nr_pedido_drogaexpress para que o pedido possa ser enviado novamente pra loja.	
						Update pedido_ecommerce
						set nr_pedido_drogaexpress = null
						where cd_filial_ecommerce = :il_filial_ecommerce
						and nr_pedido = :il_nr_pedido;
						
						if sqlca.sqlcode = -1 then
							ls_log = 'Problemas ao atualizar a tabela pedido_ecommerce:' + sqlca.sqlerrtext
							If Not gf_ge501_RollBack(SQLCA) Then Return False
						Else
							If Not gf_ge501_Commit(SQLCA) Then Return False
						end if
						
					ENd if
					
					ls_log = 'Situa$$HEX2$$e700e300$$ENDHEX$$o do pedido n$$HEX1$$e300$$ENDHEX$$o mapeada na interface da VTEX: ' + ls_id_situacao
					
					iuo_comum_vtex.of_grava_log_item( ll_Filial_Log, ll_Seq_Log, ref ls_Log, ls_Log )
					ls_Situacao = 'E'
					iuo_comum_vtex.of_envia_email(211, 'STATUS - [' + ps_rede_filial + ']', ll_Seq_Log, 'Pedido: '  + is_nr_pedido_ecommerce + ' - ' +  ls_Log, is_nr_pedido_ecommerce)
					
					w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
					Continue
					
			End Choose
			
			lb_Atualiza_Status = True
			
			If Not IsNull( il_qt_volumes ) Then
				ls_Set_Update += iif(ls_Set_Update = '', "qt_volume = " + String( il_qt_volumes ) + " ",", qt_volume = " + String( il_qt_volumes ) + " ")
			End If
							
			if lb_Atualiza_Status Then
				
				// Situa$$HEX2$$e700e300$$ENDHEX$$o diferente de cancelado
				If ls_id_situacao <> 'X' Then
					
					if isnull(ldh_Faturado) and is_id_exige_nfe_entrega = 'S' and is_tipo_pedido = 'MGZ' then
						
						this.of_busca_nfe_xml( il_cd_filial_pedido, is_chave_acesso_nfe, date(idt_nota), ref is_xml_nfe, ref ls_log)
						
						If ls_Log <> '' and not isnull(ls_Log) Then
							iuo_comum_vtex.of_envia_email(211, 'STATUS - [' + ps_rede_filial + ']', ll_Seq_Log, 'Pedido: '  + is_nr_pedido_ecommerce + ' - ' +  ls_Log, is_nr_pedido_ecommerce)
							iuo_comum_vtex.of_grava_log_item( ll_Filial_Log, ll_Seq_Log, ref ls_Log, ls_Log )
							ls_Situacao = 'E'
							ls_Log = ''
							w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
							Continue
						end if
						
					ENd if
						
					
					//'SEDEX' / 'PAC'
					if ls_id_tipo_entrega = 'ECT' Then
						// Reserva a etiqueta, caso ainda n$$HEX1$$e300$$ENDHEX$$o tenha feito.
						If IsNull(is_nr_rastreio) or trim(is_nr_rastreio) = '' Then
							This.of_reserva_etiqueta_correio(ls_Nm_Transportadora, ref ls_log) 
							
							If ls_Log <> '' and not isnull(ls_Log) Then
								iuo_comum_vtex.of_envia_email(211, 'STATUS - [' + ps_rede_filial + ']', ll_Seq_Log, 'Pedido: '  + is_nr_pedido_ecommerce + ' - ' +  ls_Log, is_nr_pedido_ecommerce)
								iuo_comum_vtex.of_grava_log_item( ll_Filial_Log, ll_Seq_Log, ref ls_Log, ls_Log )
								ls_Situacao = 'E'
								ls_Log = ''
								w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
								Continue
							end if
						End If
						
						// S$$HEX1$$f300$$ENDHEX$$ entra na segunda vez que o pedido foi faturado e foi gerado a etiqueta
						If Not IsNull(is_nr_rastreio) and Trim(is_nr_rastreio) <> '' Then
							is_url_rastreio = 'https://portalpostal.com.br/sro.jsp?sro=' + is_nr_rastreio
						End If
					End If
					
					//Entrega EXpressa/Economica - Integra$$HEX2$$e700e300$$ENDHEX$$o Equilibrium
					If ( ls_id_tipo_entrega = 'EXP' or ls_id_tipo_entrega = 'ECM' ) and ls_id_situacao = 'F'  Then
						
						if ls_id_tipo_entrega = 'EXP' Then 
							ls_tipo_entrega_equilibrium = '2'
						else
							ls_tipo_entrega_equilibrium = '1'
						end if
						
						//Verifica se j$$HEX1$$e100$$ENDHEX$$ existe a cotacao:
						if this.of_entrega_cotacao( ls_tipo_entrega_equilibrium, ref ls_log ) Then
							
							//Realiza Contrata$$HEX2$$e700e300$$ENDHEX$$o da entrega
							this.of_entrega_contratacao( ref ls_log )
							
						End if
					
						If ls_Log <> '' and not isnull(ls_Log) Then
							iuo_comum_vtex.of_envia_email(211, 'STATUS - [' + ps_rede_filial + ']', ll_Seq_Log, 'Pedido: '  + is_nr_pedido_ecommerce + ' - ' +  ls_Log, is_nr_pedido_ecommerce)
							iuo_comum_vtex.of_grava_log_item( ll_Filial_Log, ll_Seq_Log, ref ls_Log, ls_Log )
							ls_Situacao = 'E'
							ls_Log = ''
							w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
							Continue
						end if
	
						ls_id_situacao = 'C'
					
					end if
					
					//Entrega pela Total Express/Jadlog
					If (ls_id_tipo_entrega = 'TOT' or ls_id_tipo_entrega = 'JAD') and ls_id_situacao = 'F'  Then
						
						// Registro Coleta
						this.of_registra_coleta(ls_id_tipo_entrega, ref ls_log)
						
						ls_id_situacao = 'C'
						
						If ls_Log <> '' and not isnull(ls_Log) Then
							iuo_comum_vtex.of_envia_email(211, 'STATUS - [' + ps_rede_filial + ']', ll_Seq_Log, 'Pedido: '  + is_nr_pedido_ecommerce + ' - ' +  ls_Log, is_nr_pedido_ecommerce)
							iuo_comum_vtex.of_grava_log_item( ll_Filial_Log, ll_Seq_Log, ref ls_Log, ls_Log )
							ls_Situacao = 'E'
							ls_Log = ''
							w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
							Continue
						end if
						
					end if
					
					//Acrescenta a url de rastreio no update do pedido.
					if not isnull(is_url_rastreio) and is_url_rastreio <> '' Then
						ls_Set_Update += iif(ls_Set_Update = '', " de_url_rastreio= '" + is_url_rastreio + "'",", de_url_rastreio= '" + is_url_rastreio + "'")
					end if
					
					// Se ainda nao foi faturado na VTEX, envia os dados da NF pra plataforma:
					If IsNull(ldh_Faturado) Then
						
						//Monta o JSON de envio para o site ** FATURADO
						this.of_monta_json('F', ref ls_json, ref ls_log) 
						
						If ls_Log <> '' and not isnull(ls_Log) Then
							iuo_comum_vtex.of_envia_email(211, 'STATUS - [' + ps_rede_filial + ']', ll_Seq_Log, 'Pedido: '  + is_nr_pedido_ecommerce + ' - ' +  ls_Log, is_nr_pedido_ecommerce)
							iuo_comum_vtex.of_grava_log_item( ll_Filial_Log, ll_Seq_Log, ref ls_Log, ls_Log )
							ls_Situacao = 'E'
							ls_Log = ''
							w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
							Continue
						end if
						
						iuo_comum_vtex.is_json = ls_json
						
						// MUDA PARA FATURADO
						if is_cd_forma_pagto = 'CV' Then
							iuo_comum_vtex.of_post( ls_json, is_id_interface + 'CNV-' + is_nr_pedido_ecommerce + '/invoice' , ref ls_retorno, ref ls_log ) 
						ELse
							iuo_comum_vtex.of_post( ls_json, is_id_interface + iif(is_tipo_pedido = 'MGZ', 'MGZ-MGZ-LU-', is_tipo_pedido + '-') + is_nr_pedido_ecommerce + '/invoice' , ref ls_retorno, ref ls_log ) 
						End if
							
						If ls_Log <> '' and not isnull(ls_Log) Then
							iuo_comum_vtex.of_envia_email(211, 'STATUS - [' + ps_rede_filial + ']', ll_Seq_Log, 'Pedido: '  + is_nr_pedido_ecommerce + ' - ' +  ls_Log, is_nr_pedido_ecommerce)
							iuo_comum_vtex.of_grava_log_item( ll_Filial_Log, ll_Seq_Log, ref ls_Log, ls_Log )
							ls_Situacao = 'E'
							ls_Log = ''
							w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
							//sqlca.of_RollBack( )
							If Not gf_ge501_RollBack(SQLCA) Then Return False
							Continue
						end if
						
						ls_Set_Update += iif(ls_Set_Update = '', " id_situacao = '" + ls_id_situacao + "' ", ", id_situacao = '" + ls_id_situacao + "' ")
						
					End If		
				
					//Situa$$HEX2$$e700e300$$ENDHEX$$o Entregue
					If ls_id_situacao = 'E' Then
				
						//Monta o JSON de envio para o site.
						this.of_monta_json(ls_id_situacao, ref ls_json, ref ls_log)
						
						If ls_Log <> '' and not isnull(ls_Log) Then
							iuo_comum_vtex.of_envia_email(211, 'STATUS - [' + ps_rede_filial + ']', ll_Seq_Log, 'Pedido: '  + is_nr_pedido_ecommerce + ' - ' +  ls_Log, is_nr_pedido_ecommerce)
							iuo_comum_vtex.of_grava_log_item( ll_Filial_Log, ll_Seq_Log, ref ls_Log, ls_Log )
							ls_Situacao = 'E'
							ls_Log = ''
							w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
							Continue
						end if
						
						iuo_comum_vtex.is_json 				= ls_json
						iuo_comum_vtex.il_cd_filial_pedido 	= ll_Seller
					
						//Envia os dados para o site.
						// Necess$$HEX1$$e100$$ENDHEX$$rio ser o methodo PUT
						if is_cd_forma_pagto = 'CV' Then
							iuo_comum_vtex.of_put( ls_json, is_id_interface + 'CNV-' + is_nr_pedido_ecommerce + '/invoice/' + string(il_nr_nota) + '/tracking' , ref ls_retorno, ref ls_log ) 						
						Else
							iuo_comum_vtex.of_put( ls_json, is_id_interface + iif(is_tipo_pedido = 'MGZ', 'MGZ-MGZ-LU-', is_tipo_pedido + '-') + is_nr_pedido_ecommerce + '/invoice/' + string(il_nr_nota) + '/tracking' , ref ls_retorno, ref ls_log ) 
						ENd if
					
						If ls_Log <> '' and not isnull(ls_Log) Then
							iuo_comum_vtex.of_envia_email(211, 'STATUS - [' + ps_rede_filial + ']', ll_Seq_Log, 'Pedido: '  + is_nr_pedido_ecommerce + ' - ' +  ls_Log, is_nr_pedido_ecommerce)
							iuo_comum_vtex.of_grava_log_item( ll_Filial_Log, ll_Seq_Log, ref ls_Log, ls_Log )
							ls_Situacao = 'E'
							ls_Log = ''
							w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
							//sqlca.of_RollBack( )
							If Not gf_ge501_RollBack(SQLCA) Then Return False
							Continue
						end if
					
					End if
				
				ENd if
				
				this.of_atualiza_pedido( ls_set_update, ls_id_situacao, ref ls_log ) 
				
				If ls_Log <> '' and not isnull(ls_Log) Then
					iuo_comum_vtex.of_envia_email(211, 'STATUS - [' + ps_rede_filial + ']', ll_Seq_Log, 'Pedido: '  + is_nr_pedido_ecommerce + ' - ' +  ls_Log, is_nr_pedido_ecommerce)
					iuo_comum_vtex.of_grava_log_item( ll_Filial_Log, ll_Seq_Log, ref ls_Log, ls_Log )
					ls_Situacao = 'E'
					ls_Log = ''
					w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
					Continue
				end if
				
			end if // Atualiza status
			
		End if	
			
		if ib_usa_pdv_java = false Then
			If Not gf_ge501_commit(iuo_comum_vtex.itr_filial) Then Return False
		end if
		If Not gf_ge501_commit(SQLCA) Then Return False
		
		if Not iuo_comum_vtex.of_grava_log_item(ll_Filial_Log, ll_Seq_Log, ref ls_Log, ls_Log ) Then Return false
		
		w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)	
	next
			
	If Not this.of_desconecta_filial( ) Then Return false
			
	lb_sucesso = True

Catch (RuntimeError lo_rte)
	ls_situacao = 'E'
	ls_log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o of_processa_atualizacao_status: "+lo_rte.GetMessage()
	Return False

Finally
	
	if Not lb_sucesso then 
		ls_situacao = 'E'
		
		If Not gf_ge501_RollBack(SQLCA) Then Return False
		if ib_usa_pdv_java = false Then
			If Not gf_ge501_RollBack(iuo_comum_vtex.itr_filial) Then Return False
		end if
		
		// J$$HEX1$$e100$$ENDHEX$$ iniciou o envio dos itens
		If ll_for > 0 Then
			// Atualiza log com erro
			If Not iuo_comum_vtex.of_atualiza_ecommerce_log(ll_Filial_Log, ll_Seq_Log, 'E', ls_Log, gf_getserverdate(), ref ls_Log) Then Return False
			if Not iuo_comum_vtex.of_grava_log_item(ll_Filial_Log, ll_Seq_Log, ref ls_Log, ls_Log) Then Return false
		Else
			// Se n$$HEX1$$e300$$ENDHEX$$o tiver log insere um novo com erro
			If IsNull(ll_Seq_Log) or ll_Seq_Log = 0 Then
				// Grava in$$HEX1$$ed00$$ENDHEX$$cio do processo - chave e mensagem est$$HEX1$$e300$$ENDHEX$$o indo como nulo
				If Not iuo_comum_vtex.of_grava_log(ll_Filial_Log, il_cd_tipo, ls_Chave_Nula, 'E', ls_Log, ldh_Data_Nula, gf_getserverdate(), ref ls_Log, ref ll_Seq_Log ) Then Return False
			Else
				// Atualiza log com erro
				If Not iuo_comum_vtex.of_atualiza_ecommerce_log(ll_Filial_Log, ll_Seq_Log, 'E', ls_Log, gf_getserverdate(), ref ls_Log) Then Return False
			End If		
		End If
	Else
		If ll_Linhas > 0 Then
			// Marca o log como processado
			If Not iuo_comum_vtex.of_atualiza_ecommerce_log(ll_Filial_Log, ll_Seq_Log, ls_Situacao, ls_MSG_Nula, gf_getserverdate(), ref ls_Log) Then Return False
		End If
	End If
		
	this.of_desconecta_filial( )	
	
	iuo_comum_vtex.of_grava_log_historico(ref ls_id_registro_log, ll_Filial_Log, il_cd_tipo, idh_data_Atual, gf_getserverdate(), ls_situacao, ll_Seq_Log, ref ls_log )	
	
	destroy(ids_pedidos)
	destroy(iuo_comum_vtex)
	
	Close(w_Ge501_Aguarde)
	
End try

return true
end function

public function boolean of_processa_atualizacao_rastreio (string ps_rede_filial);String ls_Chave_Nula
String ls_MSG_Nula
String ls_Log
String ls_json
String ls_retorno
String ls_Situacao
String ls_Interface
String ls_id_tipo_entrega
String ls_Exige_NFSE
String ls_Rede_Retrieve
String ls_rastreio_jadlog

Long ll_linhas
Long ll_for
Long ll_Seq_Log
Long ll_Nota
Long ll_Integracao
Long ll_Seller
Long ll_Filial_Rast_Log

Long ll_cd_filial_site

boolean lb_continue=false
boolean lb_sucesso=false

DateTime ldh_Data_Nula

ll_Integracao = 16

uo_ge501_comum luo_comum_vtex

SetNull(ls_Chave_Nula)
SetNull(ls_MSG_Nula)
SetNull(ldh_Data_Nula)

//Manipula$$HEX2$$e700e300$$ENDHEX$$o, faz a pesquisa pela MP e retorna para DC pois a venda de manipulado ocorre na DC
If ps_rede_filial = 'MP' Then
	ls_Rede_Retrieve 	= 'MP'
	ps_rede_filial 		= 'DC'
Else
	ls_Rede_Retrieve = ps_rede_filial
End If

try 

	Open(w_ge501_Aguarde)
	
	w_Ge501_Aguarde.Title = "Vtex - Status Ped. Rastreio"

	luo_comum_vtex = create uo_ge501_comum
	ids_pedidos = create dc_uo_ds_base
	
	//Desenvolvimento
	il_Filial_Desenv 	= luo_comum_vtex.of_desenvolvimento_filial_baixa_pedido()
	is_ODBC_Desenv 	= luo_comum_vtex.of_desenvolvimento_odbc_baixa_pedido()
	
	//Carrega os parametros e busca o c$$HEX1$$f300$$ENDHEX$$digo da filial vinculado a rede.
	if Not luo_comum_vtex.of_parametros_ecommerce(is_id_ecommerce, ps_rede_filial, ref ll_Filial_Rast_Log, ref ls_Log ) Then return false
	
	if not ids_pedidos.of_changedataobject( 'ds_ge501_pedido_status_rastreio' , false) Then
		ls_Log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_rastreio ~n' + 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ds_ge501_pedido_status_rastreio'
		return false
	end if

	ll_linhas = ids_pedidos.retrieve( ls_Rede_Retrieve )

	if ll_linhas < 0 Then
		ls_Log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_rastreio ~n' + 'Problemas ao consultar o banco de dados na seguinte datawindow: ds_ge501_pedido_status Erro: ' + sqlca.is_lasterrortext
		return false
	end if

	If ll_Linhas > 0 Then
		luo_comum_vtex.il_qt_item_enviado_site = ll_linhas
         // Grava in$$HEX1$$ed00$$ENDHEX$$cio do processo
		If Not luo_comum_vtex.of_grava_log(ll_Filial_Rast_Log, ll_Integracao, ls_Chave_Nula, 'C', ls_MSG_Nula, gf_getserverdate(), gf_getserverdate(), ref ls_Log, ref ll_Seq_Log ) Then Return False
	End If

	ls_Situacao = 'P'
	
	w_Ge501_Aguarde.uo_progress.of_setmax(ll_Linhas)
	
	for ll_for = 1 to ll_linhas
		
		ls_log = ''

		this.of_limpa_variaveis( )
		luo_comum_vtex.of_limpa_variaveis( )
		
		is_nr_pedido_ecommerce 	=	ids_pedidos.object.nr_pedido_ecommerce[ll_for]
		ll_Seller							= ids_pedidos.object.cd_seller					[ll_for]
		ls_Exige_NFSE					= ids_pedidos.object.id_exige_nfse			[ll_for]
		
		w_Ge501_Aguarde.Title = "Vtex - Status Ped. Rastreio - "  + String(ll_for)  + " de " + STring(ll_Linhas)
		w_Ge501_Aguarde.st_msg.Text = 'Pedido: ' + is_nr_pedido_ecommerce
	
		If Not IsNull(il_Filial_Desenv) Then
			il_cd_filial_pedido = il_Filial_Desenv		
			if Not this.of_busca_filial_site( ref ll_cd_filial_site, ref ls_log ) Then return false 
		Else
			il_cd_filial_pedido = ids_pedidos.object.cd_filial[ll_for]
			ll_cd_filial_site = il_cd_filial_pedido
			
			If ll_cd_filial_site = 454 Then 
				ll_cd_filial_site = ids_pedidos.object.cd_filial_ecommerce[ll_for]
			End If			
		End If
		
		If IsNull(ll_Seller) Then
			ll_Seller = ll_cd_filial_site
		End If
					
		//Carrega os parametros e busca o c$$HEX1$$f300$$ENDHEX$$digo da filial vinculado a rede.
		if Not luo_comum_vtex.of_parametros_ecommerce_filial( ll_seller, ps_rede_filial, is_id_ecommerce, ref ls_log ) Then return false
					
		il_nr_pedido 					= ids_pedidos.object.nr_pedido								[ll_for]
		il_filial_ecommerce			= ids_pedidos.object.cd_filial_ecommerce					[ll_for]
		is_nr_rastreio					= ids_pedidos.Object.de_Codigo_Rastreamento_Correio	[ll_for]
		is_url_rastreio					= ids_pedidos.Object.de_url_rastreio							[ll_for]
		ll_Nota							= ids_pedidos.Object.nr_nf										[ll_for]
		is_nr_pedido_drogaexpress 	= ids_pedidos.object.nr_pedido_drogaexpress				[ll_for]
		ls_id_tipo_entrega 			= ids_pedidos.object.id_tipo_entrega							[ll_for]
		is_tipo_pedido 					= ids_pedidos.object.id_tipo_pedido							[ll_for]
		is_nm_transportadora_ecommerce = ids_pedidos.object.nm_transportadora			[ll_for]
		ls_rastreio_jadlog= ids_pedidos.object.nr_rastreio_jadlog[ll_for]
		
		if isnull(is_tipo_pedido) Then is_tipo_pedido = 'SLR'
		
		If ls_id_tipo_entrega = 'TOT' Then
			If IsNull(is_nr_rastreio) or trim(is_nr_rastreio) = '' Then
				is_nr_rastreio = is_nr_pedido_ecommerce
			End If
		elseif ls_id_tipo_entrega = 'JAD' then
			is_nr_rastreio = ls_rastreio_jadlog
		End If
		
		If IsNull(ll_Nota) Then
			
			If Not this.of_desconecta_filial( ) Then Return false
			
			If Not this.of_conecta_filial( ref ls_log ) Then 
				luo_comum_vtex.of_grava_log_item( ll_Filial_Rast_Log, ll_Seq_Log, ref ls_Log, ls_Log )
				ls_Situacao = 'E'
				w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
				Continue
			End If
			
			if Not this.of_carrega_dados_pedido_loja( ref ls_log, ls_id_tipo_entrega, ls_Exige_NFSE, ref lb_continue ) Then return false
			
			If Not this.of_desconecta_filial( ) Then Return false
			
			If IsNull(il_nr_nota) Then
				w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
				Continue
			End If
			
			ll_Nota = il_nr_nota			
		End If
				
		luo_comum_vtex.is_nr_pedido_ecommerce = is_nr_pedido_ecommerce
							
		//Monta o JSON de envio para o site.
		if Not this.of_monta_json_rastreio(ref ls_json) Then return false
		
		luo_comum_vtex.is_json 				= ls_json
		luo_comum_vtex.il_cd_filial_pedido 	= ll_Seller
		
		If IsnUll(is_url_rastreio) or Trim(is_url_rastreio) = '' Then
			ls_Log = "C$$HEX1$$d300$$ENDHEX$$DIGO DO RASTREIO N$$HEX1$$c300$$ENDHEX$$O INFORMADO"
			luo_comum_vtex.of_grava_log_item( ll_Filial_Rast_Log, ll_Seq_Log, ref ls_Log, ls_Log )
			ls_Situacao = 'E'
			ls_Log = ''
			w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
			Continue
		End If
		
		//https://{{accountName}}.{{environment}}.com.br/api/oms/pvt/orders/{{orderId}}/invoice/{{invoiceNumber}}
		ls_Interface = 'api/oms/pvt/orders/' + iif(is_tipo_pedido = 'MGZ', 'MGZ-MGZ-LU-', is_tipo_pedido + '-') + is_nr_pedido_ecommerce + '/invoice/' + String(ll_Nota)
		
		//Envia os dados para o site.
		luo_comum_vtex.of_patch( ls_json, ls_Interface , ref ls_retorno, ref ls_log ) 
			
		If ls_Log <> '' and not isnull(ls_Log) Then
			luo_comum_vtex.of_grava_log_item( ll_Filial_Rast_Log, ll_Seq_Log, ref ls_Log, ls_Log )
			ls_Situacao = 'E'
			ls_Log = ''
			w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
			//sqlca.of_RollBack( )
			If Not gf_ge501_RollBack(SQLCA) Then Return False
			Continue
		end if
		
		If Not of_atualiza_pedido_rastreio(ref ls_log ) Then return false
			
		//sqlca.of_commit( )
		If Not gf_ge501_commit(SQLCA) Then Return False
		
		if Not luo_comum_vtex.of_grava_log_item(ll_Filial_Rast_Log, ll_Seq_Log, ref ls_Log, ls_Log ) Then Return false
		
		w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)	
	next
		
	lb_sucesso = True

Finally
	
	if Not lb_sucesso then 
		//sqlca.of_rollback( )
		gf_ge501_RollBack(SQLCA)
		// J$$HEX1$$e100$$ENDHEX$$ iniciou o envio dos itens
		If ll_for > 0 Then
			// Atualiza log com erro
			If Not luo_comum_vtex.of_atualiza_ecommerce_log(ll_Filial_Rast_Log, ll_Seq_Log, 'E', ls_Log, gf_getserverdate(), ref ls_Log) Then Return False
			if Not luo_comum_vtex.of_grava_log_item(ll_Filial_Rast_Log, ll_Seq_Log, ref ls_Log, ls_Log) Then Return false
		Else
			// Se n$$HEX1$$e300$$ENDHEX$$o tiver log insere um novo com erro
			If IsNull(ll_Seq_Log) or ll_Seq_Log = 0 Then
				// Grava in$$HEX1$$ed00$$ENDHEX$$cio do processo - chave e mensagem est$$HEX1$$e300$$ENDHEX$$o indo como nulo
				If Not luo_comum_vtex.of_grava_log(ll_Filial_Rast_Log, ll_Integracao, ls_Chave_Nula, 'E', ls_Log, ldh_Data_Nula, gf_getserverdate(), ref ls_Log, ref ll_Seq_Log ) Then Return False
			Else
				// Atualiza log com erro
				If Not luo_comum_vtex.of_atualiza_ecommerce_log(ll_Filial_Rast_Log, ll_Seq_Log, 'E', ls_Log, gf_getserverdate(), ref ls_Log) Then Return False
			End If		
		End If
	Else
		If ll_Linhas > 0 Then
			// Marca o log como processado
			If Not luo_comum_vtex.of_atualiza_ecommerce_log(ll_Filial_Rast_Log, ll_Seq_Log, ls_Situacao, ls_MSG_Nula, gf_getserverdate(), ref ls_Log) Then Return False
		End If
	End If
		
	destroy(ids_pedidos)
	destroy(luo_comum_vtex)
	
	Close(w_Ge501_Aguarde)
	
End try

return true
end function

public function boolean of_atualiza_pedido_loja (string ps_situacao, ref string ps_log);return this.of_atualiza_pedido_loja( ps_situacao, false, ref ps_log )
end function

public function boolean of_atualiza_pedido_loja (string ps_situacao, boolean lb_atualizar_endereco, ref string ps_log);string ls_cep, ls_bairro, ls_cd_uf, ls_nr_endereco, ls_comp, ls_de_cidade, ls_de_endereco

//Atualiza situa$$HEX2$$e700e300$$ENDHEX$$o na filial para Aprovado

if lb_atualizar_endereco = false then
	
	update pedido_drogaexpress
		 Set id_situacao = :ps_situacao
	Where nr_pedido_drogaexpress = :is_nr_pedido_drogaexpress
	  Using iuo_comum_vtex.itr_filial;

else
	
	Select nr_cep, de_bairro, cd_uf, nr_endereco, de_complemento, de_cidade, de_endereco
	into :ls_cep, :ls_bairro, :ls_cd_uf, :ls_nr_endereco, :ls_comp, :ls_de_cidade, :ls_de_endereco
	from pedido_ecommerce_endereco
	where nr_pedido = :il_nr_pedido
		and cd_filial_ecommerce = :il_filial_ecommerce
		and cd_tipo_endereco = 2
		Using SQLCA;
	
	if SQLCA.sqlcode = -1 then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_pedido_loja. ' + 'Problemas ao consultar a tabela "pedido_ecommerce_endereco": ' + SQLCA.sqlerrtext
		return false
	end if
	
	update pedido_drogaexpress
				set id_situacao = :ps_situacao, 
					nr_cep_entrega = :ls_cep,
					cd_uf_entrega = :ls_cd_uf,
					de_complemento_endereco = :ls_comp,
					de_bairro_entrega = :ls_bairro,
					nr_endereco_entrega = :ls_nr_endereco,
					nm_transportadora_ecommerce = :is_nm_transportadora_ecommerce,
					nm_cidade_entrega = :ls_de_cidade,
					de_endereco_entrega = :ls_de_endereco,
					dh_validade_cotacao_entrega = :idh_validade_entrega_cotacao
		Where nr_pedido_drogaexpress = :is_nr_pedido_drogaexpress
	  	Using iuo_comum_vtex.itr_filial;
		
end if

if iuo_comum_vtex.itr_filial.sqlcode = -1 then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_pedido_loja. ' + 'Problemas ao atualizar a tabela "pedido_drogaexpress": ' + iuo_comum_vtex.itr_filial.sqlerrtext
	return false
end if

return true
end function

public function boolean of_entrega_cotacao (string ps_tipo_entrega, ref string ps_log);string ls_id_oferta, ls_nm_transportadora
datetime ldh_validade

uo_ge509_cotacao luo_cotacao

//Integra$$HEX2$$e700e300$$ENDHEX$$o Equilibrium - Cotacao

Try

		Select x1.cd_oferta, x1.nm_transportadora, x1.dh_validade
		into :ls_id_oferta, :ls_nm_transportadora, :ldh_validade
		from pedido_ecommerce_entrega x1
		where x1.cd_filial_ecommerce = :il_filial_ecommerce
		and x1.nr_pedido = :il_nr_pedido
		and x1.nr_sequencial = ( Select Max(x2.nr_sequencial) 
										from pedido_ecommerce_entrega x2
										where x2.cd_filial_ecommerce = x1.cd_filial_ecommerce
										and x2.nr_pedido = x1.nr_pedido );
	
		if sqlca.sqlcode = -1 then
			ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_entrega_cotacao ; Problemas ao consultar a tabela "pedido_ecommerce_entrega": ' + sqlca.sqlerrtext
			return false
		end if
	
		//Cria uma nova cota$$HEX2$$e700e300$$ENDHEX$$o se ainda n$$HEX1$$e300$$ENDHEX$$o existe:
		if ls_id_oferta = '' or isnull(ls_id_oferta) Then
			
			luo_cotacao = create uo_ge509_cotacao
			
			//Cria nova cota$$HEX2$$e700e300$$ENDHEX$$o
			if Not luo_cotacao.of_processa_cotacao( il_filial_ecommerce, il_nr_pedido, ps_tipo_entrega, ref ls_id_oferta, ref ls_nm_transportadora, ref ldh_validade, ref ps_log ) Then return false
		
		end if
		
		is_id_cotacao = ls_id_oferta
		is_nm_transportadora_ecommerce = ls_nm_transportadora
		idh_validade_entrega_cotacao = ldh_validade
Finally
	if isvalid(luo_cotacao) Then destroy(luo_cotacao)
end Try

return true
end function

public function boolean of_carrega_dados_pedido_loja (ref string ps_log, string ps_entrega, string ps_exige_nfse, ref boolean pb_continue);Long ll_Achou

if ib_usa_pdv_java = True Then
	
	//Busca os dados da NF na base central
	Select	 top 1
		 p.id_situacao,
		 (Case when(select count(cd_produto) from pedido_ecommerce_produto x where x.cd_filial_ecommerce = p.cd_filial_ecommerce and  x.nr_pedido = p.nr_pedido and cd_produto = 684431) > 0 then 'S' else 'N' end),
		 dateadd( HOUR, 3, nv.dh_emissao ),
		 nv.vl_total_nf,
		 nv.nr_nf,
		 nvf.de_chave_acesso
	Into
		:is_situacao_loja,
		:is_contem_manipulado,
		:idt_nota,
		:idc_vl_nota,
		:il_nr_nota,
		:is_chave_acesso_nfe
	From pedido_ecommerce p
		left join nf_venda nv on ( nv.cd_filial_ecommerce = p.cd_filial_ecommerce 
											and nv.nr_pedido_ecommerce = p.nr_pedido
											and nv.dh_cancelamento is null
											and nv.nr_nf_anexa is null) 
		left join nf_venda_nfe nvf on ( nvf.cd_filial = nv.cd_filial
											and nvf.nr_nf = nv.nr_nf
											and nvf.de_especie = nv.de_especie
											and nvf.de_serie = nv.de_serie )
	Where p.nr_pedido =:il_nr_pedido
	and p.cd_filial_ecommerce = :il_filial_ecommerce
	Using SQLCA;

	If SQLCA.SqlCode = -1 Then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_carrega_dados_pedido_loja. ' + 'Problemas ao consultar a tabela "pedido_ecommerce": ' + SQLCA.sqlerrtext
		Return False
	End If
	
	if is_situacao_loja = 'F' and isnull(il_nr_nota) then
		ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar os dados da nota fiscal.'
		return false
	End If
	
	// Verifica se foi emitido a nota de servi$$HEX1$$e700$$ENDHEX$$o
	If Not Isnull(ps_exige_nfse) and ps_exige_nfse = 'S' Then
		
		select count(*) 
		Into :ll_Achou
		from pedido_ecommerce_auxiliar p
		inner join nf_venda nv
			on nv.cd_filial_ecommerce = p.cd_filial_ecommerce
			and nv.nr_pedido_ecommerce = p.nr_pedido
		inner join nf_servico ns
			on ns.cd_filial = nv.cd_filial
			and ns.nr_nf = nv.nr_nf
			and ns.de_especie = nv.de_especie
			and ns.de_serie	= nv.de_serie
		where p.id_exige_nfse = 'S'
			and ns.nr_nf_servico is not null
			and p.nr_pedido = :il_nr_pedido
			and p.cd_filial_ecommerce = :il_filial_ecommerce
		Using SQLCA;
	
		If SQLCA.SqlCode = -1 Then
			ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_carrega_dados_pedido_loja. ' + 'Problemas ao consultar a tabela "nf_servico": ' + SQLCA.sqlerrtext
			Return False
		End If
		
		// Se ainda n$$HEX1$$e300$$ENDHEX$$o tiver a nota de servi$$HEX1$$e700$$ENDHEX$$o mant$$HEX1$$e900$$ENDHEX$$m o pedido em aberto
		If ll_Achou = 0 Then
			pb_continue = True
			return true
		End If
	Else
		// Como ainda n$$HEX1$$e300$$ENDHEX$$o tem a chave de acesso mantem como ABERTO para aguardar essa informa$$HEX2$$e700e300$$ENDHEX$$o ser gerada (Chave obrigatoria pra entregas via transportadora).
		If is_situacao_loja <>  'G' and is_situacao_loja <>  'A' and is_situacao_loja <>  'P' and ( Isnull(is_chave_acesso_nfe) or is_chave_acesso_nfe = '' ) and ( is_id_exige_nfe_entrega = 'S') Then
			is_situacao_loja = 'A'
			pb_continue = True
			return true
		End If
		
	End If
	
Else

	Select	 p.id_situacao,
		 p.qt_volume,
		 (select count(cd_produto) from produto_pedido_drogaexpress x where x.nr_pedido_drogaexpress = p.nr_pedido_drogaexpress and COALESCE(qt_faturada,0) < qt_pedida),
		 (Case when(select count(cd_produto) from produto_pedido_drogaexpress x where x.nr_pedido_drogaexpress = p.nr_pedido_drogaexpress and cd_produto = 684431) > 0 then 'S' else 'N' end),
		 nv.dh_emissao + INTERVAL '3 hour',
		 nv.vl_total_nf,
		 nv.nr_nf,
		 nvf.de_chave_acesso
	Into :is_situacao_loja,
		:il_qt_volumes,
		:il_qt_pendente_faturamento,
		:is_contem_manipulado,
		:idt_nota,
		:idc_vl_nota,
		:il_nr_nota,
		:is_chave_acesso_nfe
	From pedido_drogaexpress p
		left join nf_venda nv on ( nv.nr_pedido_ecommerce = p.nr_pedido_ecommerce
											and nv.dh_cancelamento is null
											and nv.nr_nf_anexa is null) 
		left join nf_venda_nfe nvf on ( nvf.cd_filial = nv.cd_filial
											and nvf.nr_nf = nv.nr_nf
											and nvf.de_especie = nv.de_especie
											and nvf.de_serie = nv.de_serie )
	Where p.nr_pedido_drogaexpress =:is_nr_pedido_drogaexpress
	limit 1
	Using iuo_comum_vtex.itr_Filial;
	
	If iuo_comum_vtex.itr_Filial.SqlCode = -1 Then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualiza_status. ' + 'Problemas ao consultar a tabela "pedido_drogaexpress": ' + iuo_comum_vtex.itr_filial.sqlerrtext
		Return False
	End If
	
	// Verifica se foi emitido a nota de servi$$HEX1$$e700$$ENDHEX$$o
	If Not Isnull(ps_exige_nfse) and ps_exige_nfse = 'S' Then
		select count(*) 
		Into :ll_Achou
		from pedido_drogaexpress p
		inner join nf_venda nv
			on nv.cd_filial_ecommerce = p.cd_filial_ecommerce
			and nv.nr_pedido_ecommerce = p.nr_pedido_ecommerce
		inner join nf_servico ns
			on ns.cd_filial = nv.cd_filial
			and ns.nr_nf = nv.nr_nf
			and ns.de_especie = nv.de_especie
			and ns.de_serie	= nv.de_serie
		where p.id_exige_nfse = 'S'
			and ns.nr_nf_servico is not null
			and p.nr_pedido_drogaexpress = :is_nr_pedido_drogaexpress
		Using iuo_comum_vtex.itr_Filial;
	
		If iuo_comum_vtex.itr_Filial.SqlCode = -1 Then
			ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualiza_status. ' + 'Problemas ao consultar a tabela "nf_servico": ' + iuo_comum_vtex.itr_filial.sqlerrtext
			Return False
		End If
		
		// Se ainda n$$HEX1$$e300$$ENDHEX$$o tiver a nota de servi$$HEX1$$e700$$ENDHEX$$o mant$$HEX1$$e900$$ENDHEX$$m o pedido em aberto
		If ll_Achou = 0 and is_situacao_loja <> 'G' Then
			is_situacao_loja = 'A'
			pb_continue = True
			return true
		End If
		
	Else
		// Como ainda n$$HEX1$$e300$$ENDHEX$$o tem a chave de acesso mantem como ABERTO para aguardar essa informa$$HEX2$$e700e300$$ENDHEX$$o ser gerada (Chave obrigatoria pra entrega Total Express/Equilibrium).
		If is_situacao_loja <>  'G' and is_situacao_loja <>  'A' and is_situacao_loja <>  'P' and ( Isnull(is_chave_acesso_nfe) or is_chave_acesso_nfe = '' ) and ( is_id_exige_nfe_entrega = 'S') Then
			is_situacao_loja = 'A'
			pb_continue = True
			return true
		End If
	End If
	
End if

return true
end function

public function boolean of_entrega_status (string ps_id_pedido, ref boolean pb_entregue, ref boolean pb_suspenso, ref string ps_log);String ls_status
uo_ge509_status luo_status

Try
	//Verifica se o pedido foi entregue
	luo_status = create uo_ge509_status
//

	pb_suspenso = False
	pb_entregue = False

	if Not luo_status.of_processa_status(il_filial_ecommerce, il_nr_pedido,  ps_id_pedido, ref ls_status, ref ps_log ) Then return false
	
	Choose Case ls_status 
		Case 'ENTREGUE' 
			pb_entregue = True
		Case 'SUSPENSO', 'CANCELADO', 'EM DEVOLU$$HEX2$$c700c300$$ENDHEX$$O'
			pb_suspenso = True
	Case else
		pb_entregue = false
	end CHoose

Finally 
	
	destroy(luo_status)
	
End Try


return true
end function

public function boolean of_cancelar_pedido (string ps_rede, long pl_cd_seller, long pl_cd_filial_ecommerce, long pl_nr_pedido, string ps_nr_pedido_ecommerce, string ps_nr_pedido_drogaexpress, ref string ps_log);string ls_Cod_Transacao
string ls_Valor_Venda
string ls_resp
string ls_retorno
string ls_motivo

uo_ge501_comum luo_comum_vtex	
	
Try	
	
	luo_comum_vtex = Create uo_ge501_comum
		
	//Carrega os parametros e busca o c$$HEX1$$f300$$ENDHEX$$digo da filial vinculado a rede.
	if Not luo_comum_vtex.of_parametros_ecommerce_filial(pl_cd_seller, ps_Rede, '2', ref ps_log ) Then return false
						
	ls_Motivo = 'CANCELADO AUTOMATICO - PAGAMENTO PENDENTE'					
	ls_resp = '14330'
					
	// PRIMEIRA CHAMADA
	//https://bazarhorizonte.vtexcommercestable.com.br/api/oms/pvt/orders/{{pedido}}/cancel
	if is_cd_forma_pagto = 'CV' Then
		luo_comum_vtex.of_post( '', '/api/oms/pvt/orders/' + 'CNV-' + ps_nr_pedido_ecommerce + '/cancel' , ref ls_retorno, ref ps_Log ) 		
	Else	
		luo_comum_vtex.of_post( '', '/api/oms/pvt/orders/' + iif(is_tipo_pedido = 'MGZ', 'MGZ-MGZ-LU-', is_tipo_pedido + '-') + ps_nr_pedido_ecommerce + '/cancel' , ref ls_retorno, ref ps_Log ) 
	End if
	
	If ps_Log <> '' and not isnull(ps_Log) Then Return False
	
//	// SEGUNDA CHAMADA
//	//https://bazarhorizonte.vtexcommercestable.com.br/api/oms/pvt/orders/{{pedido}}/cancel
//	luo_comum_vtex.of_post( '', '/api/oms/pvt/orders/' + iif(ll_cd_seller = 809, '', 'SLR-') + ls_Pedido_Ecommerce + '/cancel' , ref ls_retorno, ref ps_Log ) 
//							
//	If ps_Log <> '' and not isnull(ps_Log) Then Return False
	
	Update pedido_ecommerce 
	set id_situacao = 'X', 	
		dh_cancelamento = getdate(), 
		nr_matric_alteracao_situacao = :ls_Resp
	where cd_filial_ecommerce = :pl_cd_Filial_Ecommerce
		and nr_pedido = :pl_nr_pedido
	Using SqlCa;
			
	If SqlCa.SqlCode = -1 Then
		ps_Log = 	'Erro ao mudar a situa$$HEX2$$e700e300$$ENDHEX$$o do pedido para cancelado": ~n' + SqlCa.sqlerrtext
		Return False
	End If
					
	Update pedido_ecommerce_auxiliar 
	set de_motivo_cancelamento_pedido = :ls_Motivo
	where cd_filial_ecommerce = :pl_cd_Filial_Ecommerce
		and nr_pedido= :pl_nr_pedido
	Using SqlCa;
			
	If SqlCa.SqlCode = -1 Then
		ps_Log = 	'Erro ao gravar o motivo do cancelamento": ~n' + SqlCa.sqlerrtext
		Return False
	End If
					
	if ib_usa_pdv_java = False Then
	
		Update pedido_drogaexpress
		Set id_situacao = 'X',
			 nr_matricula_cancelamento = :ls_Resp
		Where nr_pedido_drogaexpress = :ps_nr_pedido_drogaexpress 			  
		Using iuo_comum_vtex.itr_Filial;
		
		If iuo_comum_vtex.itr_Filial.SqlCode = -1 Then
			ps_Log = 'Erro ao atualizar a situa$$HEX2$$e700e300$$ENDHEX$$o do pedido na tabela "pedido_drogaexpress": ~n' + iuo_comum_vtex.itr_Filial.sqlerrtext
			return false
		End IF
		
	End if

Finally
	if ps_log <> '' and not isnull(ps_log) Then	
		ps_log = is_objeto + 'Funcao: of_cancelar_pedido; ' + ps_log
	end if
	if isvalid(luo_comum_vtex) then destroy(luo_comum_vtex)
End try

return true
end function

public function boolean of_grava_entrega (long pl_cd_filial, long pl_nr_pedido, string ps_nm_transportadora, decimal pdc_valor, long pl_dias_previsto, datetime pdh_validade, string ps_objeto, ref string ps_log);long ll_sequencial
boolean lb_sucesso = false

Try

	Select max(nr_sequencial)
	into :ll_sequencial
	from pedido_ecommerce_entrega
	where cd_filial_ecommerce = :pl_cd_filial
	and nr_pedido = :pl_nr_pedido;
	
	if sqlca.sqlcode = -1 then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_entrega ; Problemas ao consultar a tabela "pedido_ecommerce_entrega": ' + sqlca.sqlerrtext
		return false
	end if
	
	if ll_sequencial = 0 or isnull(ll_sequencial) Then
		ll_sequencial = 1
	else
		ll_sequencial ++
	end if
	
	Insert into pedido_ecommerce_entrega( cd_filial_ecommerce,
															nr_pedido,
															nr_sequencial,
															nm_transportadora,
															vl_entrega,
															nr_dias_entrega,
															dh_validade,
															cd_transportadora,
															id_situacao,
															de_objeto,
															id_comunicacao_pendente)
	values( :pl_cd_filial,
				:pl_nr_pedido,
				:ll_sequencial,
				:ps_nm_transportadora,
				:pdc_valor,
				:pl_dias_previsto,
				:pdh_validade,
				:ps_nm_transportadora,
				'A',
				:ps_objeto,
				'N')
	Using sqlca;
				
	if sqlca.sqlcode = -1 then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_entrega ; Problemas ao inserir registro na tabela "pedido_ecommerce_entrega": ' + sqlca.sqlerrtext
		return false
	end if
	
Finally
	
End Try

return true
end function

public function boolean of_registra_coleta (string ps_tipo_entrega, ref string ps_log);Integer li_Status
Integer li_Achou_Nota
Integer li_Linhas_Atualizadas = 0
Integer li_Qt_Volumes
long ll_for
Date ldt_Compra
Datetime ldt_validade
String ls_objeto
String ls_codigo_pedido

Try	
	
	Choose Case ps_tipo_entrega
			
		//JADLOG	
		Case 'JAD'
			
			if is_id_pedido_entrega = '' or isnull(is_id_pedido_entrega) Then
			
				uo_ge501_jadlog luo_jadlog
	
				luo_jadlog = create uo_ge501_jadlog
				
				if Not luo_jadlog.of_executar( 'INCLUIR', il_filial_ecommerce, il_nr_pedido, ref ps_log) Then return false
			
				ls_codigo_pedido = luo_jadlog.is_codigo_jadlog
				
			Else
				ls_codigo_pedido = is_id_pedido_entrega
			End if
			
			If Not this.of_grava_entrega( il_filial_ecommerce, il_nr_pedido, 'JADLOG', idc_vl_nota, 0, ldt_validade, ls_codigo_pedido, ref ps_log ) Then return false
			
			is_url_rastreio = 'https://www.jadlog.com.br/siteInstitucional/tracking.jad'
			
		//TOTAL EXPRESS	
		CAse 'TOT'	
		
			uo_ge501_total_express luo_total_express
								
			luo_total_express = create uo_ge501_total_express
			
			If Not luo_total_express.of_registra_coleta_e_total( il_filial_ecommerce, is_nr_pedido_ecommerce, ib_producao, iuo_comum_vtex.itr_filial, ref ps_log, is_rede_filial, il_cd_filial_pedido) Then
				Return true
			End If
			
			setnull(ldt_validade)
			setnull(ls_objeto)
			
			for ll_for = 1 to il_qt_volumes
				If Not this.of_grava_entrega( il_filial_ecommerce, il_nr_pedido, 'TOTAL EXPRESS', idc_vl_nota, 0, ldt_validade, ls_objeto, ref ps_log ) Then return false
			Next
			
			is_nr_rastreio = is_nr_pedido_ecommerce
								
			is_url_rastreio = 'https://tracking.totalexpress.com.br/poupup_track.php?reid=' + luo_total_express.is_reid + '&pedido=' + is_nr_pedido_ecommerce + '&nfiscal=' + string(il_nr_nota)

End Choose

Finally
	if isvalid(luo_total_express) Then Destroy(luo_total_express)
End Try
					
Return True
end function

public function boolean of_busca_nfe_xml (long pl_cd_filial, string ps_chave_acesso, date pdt_emissao, ref string ps_xml_nfe, ref string ps_log);string ls_log, ls_erro
string ls_Modelo
string ls_Cnpj_Origem
string ls_Ano, ls_Mes, ls_Dia
string ls_Diretorio
string ls_Arquivo

string ls_Arquivo_Aux
string ls_arquivo_xml
string ls_retorno

string ls_xml

long ll_arquivo
long ll_retorno

dc_uo_Ftp lo_Ftp
dc_uo_zip lo_zip

Try

	lo_Ftp = Create dc_uo_Ftp
	
	If Not lo_Ftp.of_Conecta_Ftp("", is_Endereco_Ftp, is_Usuario_Ftp, is_Senha_Ftp, ref ps_log ) Then
		ps_log = "Erro ao buscar o arquivo via ftp: " + ps_log
		Return false
	End If
	
	ls_Modelo = Mid(ps_chave_acesso, 21, 2)
	ls_Cnpj_Origem	= Mid(ps_chave_acesso, 7, 14)
	
	Choose Case ls_Modelo
		Case '59' 
			ls_Ano		= String(Year(pdt_emissao))
			ls_Mes		= Right("0"+String(Month(pdt_emissao)), 2)
			ls_Dia			= Right("0"+String(Day(pdt_emissao)), 2)
			ls_Diretorio	= ls_Ano+"/"+ls_Mes+"/"+ls_Dia+"/"+String(pl_cd_Filial, "0000")
			ls_Arquivo	= 'AD'+ps_chave_acesso+".xml.zip"
		Case '65' 	
			ls_Ano		= String(Year(pdt_emissao))
			ls_Mes		= Right("0"+String(Month(pdt_emissao)), 2)
			ls_Dia			= Right("0"+String(Day(pdt_emissao)), 2)
			ls_Diretorio	= ls_Ano+"/"+ls_Mes+"/"+ls_Dia+"/"+String(pl_cd_Filial, "0000")
			ls_Arquivo	= ps_chave_acesso+"-nfce.xml.zip"
		Case Else
			ls_Ano		= "Ano_"+String(Year(pdt_emissao))
			ls_Mes		= "Mes_"+Right("0"+String(Month(pdt_emissao)), 2)
			ls_Dia			= "Dia_"+Right("0"+String(Day(pdt_emissao)), 2)
			ls_Diretorio	= ls_Ano+"/"+ls_Mes+"/"+ls_Dia+"/"+ls_Cnpj_Origem
			ls_Arquivo	= ps_chave_acesso+"-nfe.xml"
	End Choose
	
	If lo_Ftp.of_Ftp_Set_Dir(ls_Diretorio, Ref ps_log) = -1 Then 
		ps_log = "Erro ao buscar o arquivo via ftp: " + ps_log
		Return  false	
	End If
	
	If not lo_Ftp.of_Ftp_GetFile(ls_Arquivo, is_Diretorio_Xml + ls_Arquivo, Ref ps_log) Then
		ps_log = "Erro ao buscar o arquivo via ftp: " + ps_log
		Return false
	End If
	
	
	//Recebe o valor arquivo
	ls_Arquivo_Aux = ls_Arquivo
	
	//Se for arquivo compactado
	If Upper(Right(ls_Arquivo, 3))="ZIP" Then
		//Verifica se objeto ZIP j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ criado
		If Not IsValid(lo_zip) Then lo_zip = Create dc_uo_zip
		
		//Novo arquivo XML
		ls_Arquivo_Aux = Mid(ls_Arquivo, 1, Len(ls_Arquivo) -4)
		
		//Se o arquivo ZIP j$$HEX1$$e100$$ENDHEX$$ existir ele exclui
		If FileExists(is_Diretorio_Xml+ls_Arquivo_Aux) Then FileDelete(is_Diretorio_Xml + ls_Arquivo_Aux)
		
		//Verifica se o arquivo existe
		If FileExists(is_Diretorio_Xml+ls_Arquivo) Then 
			lo_zip.Of_UnZip_Origem( is_Diretorio_Xml+ls_Arquivo )
			lo_zip.Of_UnZip_Destino( is_Diretorio_Xml )
			lo_zip.Of_UnZip( True )
		End If
	End If
	
	//Retorna o arquivo XML
	ls_arquivo_xml = is_Diretorio_Xml+ls_Arquivo_Aux
	
	ll_arquivo = FileOpen(ls_arquivo_xml, LineMode!)
	
	Do while ll_retorno <> -100
	
		ll_retorno = FileReadEx(ll_arquivo, ls_retorno)
		
		ls_xml = ls_xml + ls_retorno
	
	Loop
	
	if ls_xml = '' or isnull(ls_xml) then
		ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar o XML da NFE.'
		return false
	End if
	
	if isnull(ls_xml) then ls_xml = ''
	
	ps_xml_nfe = ls_xml
	
	FileClose(ll_arquivo)
	FileDelete(ls_arquivo_xml)
	
	is_xml_nfe = gf_replace(is_xml_nfe, '"', "'",0)
	
Catch ( runtimeerror  lo_rte )
	ps_log = lo_rte.GetMessage( )
	Return False		
	
Finally

	lo_Ftp.of_desconecta_ftp( )
	
	if ps_log <> '' and not isnull(ps_log) then ps_log = 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_busca_nfe_xml; ' + ps_log
	
	destroy(lo_zip)
	destroy(lo_ftp)
	
End Try

return true
end function

public function boolean of_carrega_parametros_ftp (ref string ps_log);
Try

	select (select vl_parametro From parametro_geral Where cd_parametro = 'DE_FTP_XML_SENHA'),
			(select vl_parametro From parametro_geral Where cd_parametro = 'DE_FTP_XML_USUARIO'),
			(select vl_parametro From parametro_geral Where cd_parametro = 'DE_FTP_XML_ENDERECO')
	into :is_Senha_Ftp, :is_Usuario_Ftp, :is_Endereco_Ftp
	from parametro;
	
	if sqlca.sqlcode = -1 then
		ps_log = 'Erro ao buscar os parametro FTP: ' + sqlca.sqlerrtext
		return false
	ENd if
	
	if isnull(is_Senha_Ftp) or is_Senha_Ftp = '' then
		ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar a senha de acesso ao FTP.'
		return false
	ENd if
	
	if isnull(is_Usuario_Ftp) or is_Usuario_Ftp = '' then
		ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar o usu$$HEX1$$e100$$ENDHEX$$rio de acesso ao FTP.'
		return false
	ENd if
	
	if isnull(is_Endereco_Ftp) or is_Endereco_Ftp = '' then
		ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar o endere$$HEX1$$e700$$ENDHEX$$o de acesso ao FTP.'
		return false
	ENd if

	if ib_debug = True Then
		
		is_diretorio_xml = 'C:\Sistemas\Ex\Exe\'
		
	Else

		is_diretorio_xml = GetCurrentDirectory( )
	
	End if
	
	if isnull(is_diretorio_xml) or is_diretorio_xml = '' then
		ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar o diret$$HEX1$$f300$$ENDHEX$$rio de acesso ao FTP.'
		return false
	ENd if
	
	
	

Finally
	if ps_log <> '' and not isnull(ps_log) then ps_log = 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_carrega_parametros_ftp; ' + ps_log
End Try

return true
end function

on uo_ge501_pedido_status.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge501_pedido_status.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;is_objeto = 'Objeto: ' + this.classname() + '~n'

#if defined DEBUG then
  ib_debug = True
#end if
end event

