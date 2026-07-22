HA$PBExportHeader$uo_ge481_sap_pedido_retorno.sru
forward
global type uo_ge481_sap_pedido_retorno from uo_ge481_subida_generica
end type
end forward

global type uo_ge481_sap_pedido_retorno from uo_ge481_subida_generica
integer ii_contador_xml = 1
boolean ib_usa_cabecalho = false
end type
global uo_ge481_sap_pedido_retorno uo_ge481_sap_pedido_retorno

type variables
long il_cd_filial

String is_tipo_pedido
end variables

forward prototypes
public function boolean _of_parametros ()
public function boolean _of_monta_xml_item (datastore pds_dados, long pl_linha, ref string ps_xml, ref string ps_log)
public function boolean _of_processa_retorno_xml (string as_xml, ref string as_log)
public function boolean of_atualiza_processado (datastore pds_itens, long pl_linha, long pl_nr_atualizacao, string ps_status, string as_mensagem, ref string as_log)
protected function boolean of_valida_situacao (datastore pds_itens, long pl_linha, ref long pl_situacao_pendente, ref string ps_log)
public function boolean _of_filtra_nr_atualizacao (ref dc_uo_ds_base pds_dados, long pl_nr_atualizacao, ref string ps_log)
public function boolean of_busca_produto_pedido (long pl_nr_pedido, long pl_cd_filial, long pl_nr_sequencial, ref long pl_cd_produto, ref string ps_log)
private function boolean of_grava_log_pedido (long pl_cd_filial, long pl_nr_pedido, long pl_cd_produto, long pl_nr_sequencial, string ps_msg, ref string ps_log)
end prototypes

public function boolean _of_parametros ();is_Inicio_XML	=	'<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:exp="exporta_sap.com">'+&
						'<soapenv:Header/>'+&
						'<soapenv:Body>'+&
						'<exp:MT_ConsultarPedido_Request>'

							
is_Termino_XML	=	'</exp:MT_ConsultarPedido_Request>'+&
							'</soapenv:Body>'+&
							'</soapenv:Envelope>'

is_DS = 'ds_ge481_pedido_distrib_retorno'
is_Objeto = this.classname( )
is_nome_arquivo = 'Pedido_retorno_xml'
is_Parametro_URL = 'CD_URL_PEDIDO_RETORNO'
is_Tipo_Log_Exp = 'PER'
is_Descricao_Tipo_Log = 'PEDIDO_RETORNO'
is_Nome_Interface = 'PEDIDO_RETORNO'

return True
end function

public function boolean _of_monta_xml_item (datastore pds_dados, long pl_linha, ref string ps_xml, ref string ps_log);String ls_nr_pedido

ls_nr_pedido = String(pds_dados.object.nr_pedido[pl_linha])

il_cd_filial = pds_dados.object.cd_filial[pl_linha]

ps_xml += '<dados>'
ps_xml += '<pedido>' + ls_nr_pedido + '</pedido>'
ps_xml += '</dados>'

return true
end function

public function boolean _of_processa_retorno_xml (string as_xml, ref string as_log);string ls_nr_pedido, ls_item, ls_status, ls_msg
long ll_controle, ll_nr_pedido, ll_nr_sequencial, ll_cd_produto, ll_seq_log, ll_nr_ordem
boolean lb_gravou_erro=false

ll_controle = 1

ls_nr_pedido = of_busca_valor(as_xml, '<pedido>', ref ll_controle)

if isnull(ls_nr_pedido) or ls_nr_pedido = '' Then
	as_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel processar o retorno: N$$HEX1$$fa00$$ENDHEX$$mero do pedido n$$HEX1$$e300$$ENDHEX$$o encontrado no xml de resposta.'
	return false
end if

ll_nr_pedido = long(ls_nr_pedido)

Do 
	
	ls_item = of_busca_valor(as_xml, '<item>', ref ll_controle)
	
	if isnull(ls_item) or ls_item = '' Then
		Exit
	end if
	
	ls_status = of_busca_valor(as_xml, '<tipo>', ref ll_controle)
	
	if ls_status = 'E' Then //Erro
		
		ls_msg = of_busca_valor(as_xml, '<texto>', ref ll_controle)
		
		if lb_gravou_erro = false then
			lb_gravou_erro = True
		end if
		
		ll_nr_sequencial = long(ls_item)
		
		//Busca o c$$HEX1$$f300$$ENDHEX$$digo do Produto relacionado ao item
		If Not this.of_busca_produto_pedido( ll_nr_pedido, il_cd_filial, ll_nr_sequencial, ref ll_cd_produto, ref as_log ) Then Return False
				
		//Grava Registro na tabela de LOG de pedidos.
		If Not this.of_grava_log_pedido( il_cd_filial, ll_nr_pedido, ll_cd_produto, ll_nr_sequencial, ls_msg, ref as_log ) Then Return False
		
	End if
	
Loop While ls_item <> ''

if lb_gravou_erro = True Then
	//Atualiza status para Erro (E)
	if Not this.of_atualiza_processado( ll_nr_pedido, 'E', ls_msg, ref as_log) then return false
else
	//Atualiza status para Processado (P)
	if Not this.of_atualiza_processado( ll_nr_pedido, 'P', '', ref as_log) then return false
end if

return true
end function

public function boolean of_atualiza_processado (datastore pds_itens, long pl_linha, long pl_nr_atualizacao, string ps_status, string as_mensagem, ref string as_log);String ls_status, ls_msg

long ll_nr_pedido

if pl_nr_atualizacao = 0 or isnull(pl_nr_atualizacao) Then
	ll_nr_pedido = pds_itens.object.nr_pedido[pl_linha]
else
	ll_nr_pedido = pl_nr_atualizacao
end if

if ps_status = 'E' Then
	ls_status = 'E'
	ls_msg = as_mensagem
else
	ls_status = 'P'
	setnull(ls_msg)
end if

If is_tipo_pedido = 'D' Then
	//Pedido_Distribuidora
	
	Update pedido_distribuidora
		Set id_exportacao_sap = :ls_status, 
			de_erro_envio_sap = :ls_msg,
			dh_exportacao_sap = getdate()
	Where nr_pedido_distribuidora =:ll_nr_pedido
	Using SqlCa;

	If SqlCa.SqlCode = -1 Then
		as_log = 'Objeto: ' + this.classname( ) + '~nM$$HEX1$$e900$$ENDHEX$$todo: of_atualiza_processado ~nProblemas ao atualizar registro da tabela "pedido_distribuidora" : ' + SqlCa.SqlerrText
		Return False
	End If

else
	//Pedido_empurrado
	
	Update pedido_empurrado
		Set id_exportacao_sap = :ls_status, 
			de_erro_envio_sap = :ls_msg,
			dh_envio_sap = getdate()
	Where nr_pedido_sap =:ll_nr_pedido
	Using SqlCa;

	If SqlCa.SqlCode = -1 Then
		as_log = 'Objeto: ' + this.classname( ) + '~nM$$HEX1$$e900$$ENDHEX$$todo: of_atualiza_processado ~nProblemas ao atualizar registro da tabela "pedido_empurrado" : ' + SqlCa.SqlerrText
		Return False
	End If
	
end if

return true
end function

protected function boolean of_valida_situacao (datastore pds_itens, long pl_linha, ref long pl_situacao_pendente, ref string ps_log);long ll_nr_pedido, ll_nr_pedido_sap

ll_nr_pedido = pds_itens.object.nr_pedido[pl_linha]
is_tipo_pedido = pds_itens.object.id_tipo_pedido[pl_linha]

if is_tipo_pedido = 'E' Then
	//Pedido_empurrado
	
	Select 1
	into :pl_situacao_pendente
	from pedido_empurrado
	where nr_pedido_sap = :ll_nr_pedido
	and id_exportacao_sap = 'I';
	
	If SqlCa.SqlCode = -1 Then
		ps_log = "Objeto: " + this.classname() + "~nM$$HEX1$$e900$$ENDHEX$$todo: of_valida_situacao ~nErro ao consultar a tabela 'pedido_empurrado' : " + SqlCa.SqlerrText
		Return False
	End If
	
elseif is_tipo_pedido = 'D' Then
	//Pedido_distribuidora
	
	Select 1
	into :pl_situacao_pendente
	from pedido_distribuidora
	where nr_pedido_distribuidora = :ll_nr_pedido
	and id_exportacao_sap = 'I';
	
	If SqlCa.SqlCode = -1 Then
		ps_log = "Objeto: " + this.classname() + "~nM$$HEX1$$e900$$ENDHEX$$todo: of_valida_situacao ~nErro ao consultar a tabela 'pedido_distribuidora': " + SqlCa.SqlerrText
		Return False
	End If

else
	ps_log = "Objeto: " + this.classname() + "~nM$$HEX1$$e900$$ENDHEX$$todo: of_valida_situacao ~nN$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel identificar o tipo do pedido: pedido_distribuidora/pedido_empurrado" + SqlCa.SqlerrText
	Return False
end if

return true
end function

public function boolean _of_filtra_nr_atualizacao (ref dc_uo_ds_base pds_dados, long pl_nr_atualizacao, ref string ps_log);//Filtra a datastore para trazer um registro espec$$HEX1$$ed00$$ENDHEX$$fico.
if pl_nr_atualizacao > 0 Then
	pds_dados.of_appendwhere( 'pd.nr_pedido_distribuidora = ' + String(pl_nr_atualizacao) )
	
	pds_dados.of_appendwhere_subquery( ' pe.nr_pedido_sap = ' + String(pl_nr_atualizacao) , 2)
	
else
	
	pds_dados.of_appendwhere( "pd.id_exportacao_sap = 'I' " )
	
	pds_dados.of_appendwhere_subquery( " pe.id_exportacao_sap = 'I' " , 2)
	
end if

return true
end function

public function boolean of_busca_produto_pedido (long pl_nr_pedido, long pl_cd_filial, long pl_nr_sequencial, ref long pl_cd_produto, ref string ps_log);
if is_tipo_pedido = 'D' Then
			
	//Pedido_distribuidora
	Select cd_produto
		into :pl_cd_produto
	from pedido_distribuidora_prd_item
	where nr_pedido_distribuidora = :pl_nr_pedido
		and cd_filial = :pl_cd_filial
		and nr_sequencial = :pl_nr_sequencial;
	
	if sqlca.sqlcode = -1 then
		ps_log = 'Objeto: ' + this.classname() + '~nM$$HEX1$$e900$$ENDHEX$$todo: of_busca_produto_pedido ~n' + 'Erro ao consultar a tabela "pedido_distribuidora_prd_item": ' + sqlca.sqlerrtext
		return false
	end if
		
else
	
	//Pedido_Empurrado
	Select pep.cd_produto
		into :pl_cd_produto
	from pedido_empurrado pe
	inner join pedido_empurrado_produto pep on (pep.cd_filial = pe.cd_filial 
															and pep.nr_pedido_empurrado = pe.nr_pedido_empurrado )
	where pe.nr_pedido_sap = :pl_nr_pedido;
	
	if sqlca.sqlcode = -1 then
		ps_log = 'Objeto: ' + this.classname() + '~nM$$HEX1$$e900$$ENDHEX$$todo: of_busca_produto_pedido ~n' + 'Erro ao consultar a tabela "pedido_distribuidora_prd_item": ' + sqlca.sqlerrtext
		return false
	end if
	
end if

return true
end function

private function boolean of_grava_log_pedido (long pl_cd_filial, long pl_nr_pedido, long pl_cd_produto, long pl_nr_sequencial, string ps_msg, ref string ps_log);long ll_seq_log, ll_nr_pedido_empurrado

if is_tipo_pedido = 'D' Then //Distribuidora

	select max(nr_sequencial_log)
		into :ll_seq_log
	from pedido_distri_prd_item_log
	where cd_filial = :pl_cd_filial
		and nr_pedido_distribuidora = :pl_nr_pedido
		and cd_produto = :pl_cd_produto;
	
	if sqlca.sqlcode = -1 then
		ps_log = 'Objeto: ' + this.classname() + '~nM$$HEX1$$e900$$ENDHEX$$todo: of_grava_log_pedido ~n' + 'Erro ao consultar a tabela "pedido_distri_prd_item_log": ' + sqlca.sqlerrtext
		return false
	end if
	
	if ll_seq_log = 0 or isnull(ll_seq_log) Then
		ll_seq_log = 1
	else
		ll_seq_log++
	end if
	
	insert into pedido_distri_prd_item_log(cd_filial, nr_pedido_distribuidora, cd_produto, nr_sequencial_item, nr_sequencial_log, de_erro)
	values( :pl_cd_filial, :pl_nr_pedido, :pl_cd_produto, :pl_nr_sequencial, :ll_seq_log, :ps_msg );
	
	if sqlca.sqlcode = -1 then
		ps_log = 'Objeto: ' + this.classname() + '~nM$$HEX1$$e900$$ENDHEX$$todo: of_grava_log_pedido ~n' + 'Erro ao inserir registro na tabela "pedido_distri_prd_item_log": ' + sqlca.sqlerrtext
		return false
	end if

else //empurrado

	select nr_pedido_empurrado
		into :ll_nr_pedido_empurrado
	from pedido_empurrado
	Where nr_pedido_sap = :pl_nr_pedido;
	
	if sqlca.sqlcode = -1 then
		ps_log = 'Objeto: ' + this.classname() + '~nM$$HEX1$$e900$$ENDHEX$$todo: of_grava_log_pedido ~n' + 'Erro ao consultar a tabela "pedido_empurrado": ' + sqlca.sqlerrtext
		return false
	end if	

	select max(nr_sequencial_log)
		into :ll_seq_log
	from pedido_empurrado_prd_log
	where cd_filial = :pl_cd_filial
		and nr_pedido_empurrado = :ll_nr_pedido_empurrado
		and cd_produto = :pl_cd_produto;
	
	if sqlca.sqlcode = -1 then
		ps_log = 'Objeto: ' + this.classname() + '~nM$$HEX1$$e900$$ENDHEX$$todo: of_grava_log_pedido ~n' + 'Erro ao consultar a tabela "pedido_empurrado_prd_log": ' + sqlca.sqlerrtext
		return false
	end if
	
	if ll_seq_log = 0 or isnull(ll_seq_log) Then
		ll_seq_log = 1
	else
		ll_seq_log++
	end if
	
	insert into pedido_empurrado_prd_log(cd_filial, nr_pedido_empurrado, cd_produto, nr_item, nr_sequencial_log, de_erro, nr_pedido_sap)
	values( :pl_cd_filial, :ll_nr_pedido_empurrado, :pl_cd_produto, :pl_nr_sequencial, :ll_seq_log, :ps_msg, :pl_nr_pedido );
	
	if sqlca.sqlcode = -1 then
		ps_log = 'Objeto: ' + this.classname() + '~nM$$HEX1$$e900$$ENDHEX$$todo: of_grava_log_pedido ~n' + 'Erro ao inserir registro na tabela "pedido_empurrado_prd_log": ' + sqlca.sqlerrtext
		return false
	end if	

end if

return true
end function

on uo_ge481_sap_pedido_retorno.create
call super::create
end on

on uo_ge481_sap_pedido_retorno.destroy
call super::destroy
end on

