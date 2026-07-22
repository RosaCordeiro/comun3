HA$PBExportHeader$uo_ge501_produto_imagem.sru
forward
global type uo_ge501_produto_imagem from nonvisualobject
end type
end forward

global type uo_ge501_produto_imagem from nonvisualobject
end type
global uo_ge501_produto_imagem uo_ge501_produto_imagem

type variables
string is_objeto
string is_id_ecommerce = '2' //VTEX
String is_rede_ecommerce

String is_nome_imagem
String is_de_url_imagem
end variables

forward prototypes
private function boolean of_monta_json (ref string ps_json, ref string ps_log)
public function boolean of_processa_atualizacao_imagem (string ps_rede_filial)
public function boolean of_atualiza_prd_imagem (string ps_tipo, long pl_cd_produto, string ps_mensagem, ref string ps_log)
public function boolean of_insere_log_exportacao (long pl_cd_produto, ref string ps_log)
end prototypes

private function boolean of_monta_json (ref string ps_json, ref string ps_log);
ps_json = '{ ' + &
	'"IsMain": true, ' + &
	'"Label": "", ' + &
	'"Name": "' + is_nome_imagem + '" , ' + &
	'"Text": null, ' + &
	'"Url": "' + is_de_url_imagem + '"' + & 
	'}'

return true
end function

public function boolean of_processa_atualizacao_imagem (string ps_rede_filial);long ll_linhas, ll_for
long ll_cd_produto
long ll_cd_filial

String ls_json
String ls_retorno
String ls_Log
String ls_Situacao
String ls_cd_sku

boolean lb_sucesso=false

dc_uo_ds_base lds_dados
uo_ge501_comum luo_comum_vtex

try 

	ls_situacao = 'P'
	
	Open(w_Ge501_Aguarde)

	is_rede_ecommerce = ps_rede_filial

	luo_comum_vtex = create uo_ge501_comum

	lds_dados = create dc_uo_ds_base
	
	if not lds_dados.of_changedataobject( 'ds_ge501_produto_imagem' ) Then
		ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualiza_imagem ~n' + 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ds_ge501_produto_imagem'
		return false
	end if
	
	//Carrega os parametros e busca o c$$HEX1$$f300$$ENDHEX$$digo da filial vinculado a rede.
	if Not luo_comum_vtex.of_parametros_ecommerce(is_id_ecommerce, ps_rede_filial, ref ll_cd_filial, ref ls_log ) Then return false
	
	ll_linhas = lds_dados.retrieve( is_id_ecommerce, is_rede_ecommerce)
	
	if ll_linhas < 0 Then
		ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualiza_imagem ~n' + 'Problemas ao consultar o banco de dados na seguinte datawindow: ds_ge501_produto_imagem'
		return false
	end if
	
//	if ll_linhas > 1500 Then ll_linhas = 1500
	
	w_Ge501_Aguarde.uo_progress.of_setmax(ll_Linhas)
	
	for ll_for = 1 to ll_linhas
		
		w_Ge501_Aguarde.Title = "Atualizando imagem dos produtos no eCommerce - [" + ps_rede_filial +  "] - "  + String(ll_for)  + " de " + STring(ll_Linhas)
		
		is_nome_imagem = ''
		is_de_url_imagem = ''
		
		ll_cd_produto = lds_dados.object.cd_produto[ll_for]
		
		w_Ge501_Aguarde.st_msg.Text = "Produto: " + string(ll_cd_produto)
		
		ls_cd_sku = lds_dados.object.cd_sku[ll_for]
		is_de_url_imagem = lds_dados.object.de_url_nova[ll_for]
		
		if pos(upper(is_de_url_imagem), 'MEDICAMENTOS.JPG') > 0 Then
			is_nome_imagem = 'Medicamentos'
		elseif pos(upper(is_de_url_imagem), 'MEDICAMENTOS-GENERICOS.JPG') > 0 Then
			is_nome_imagem = 'Medicamentos-Genericos'
		else
			if Not this.of_atualiza_prd_imagem( 'E', ll_cd_produto, 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel identificar o nome da imagem no endere$$HEX1$$e700$$ENDHEX$$o configurado.', ref ls_log ) then return false
			ls_situacao = 'E'
			ls_log = ''
			w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
			Continue
		end if
		
		//Excluir a imagem no site
		luo_comum_vtex.of_delete('', '/api/catalog/pvt/stockkeepingunit/' + ls_cd_sku + '/file' , ref ls_retorno,ref ls_log )
		
		If ls_Log <> '' and not isnull(ls_Log) Then
			if Not this.of_atualiza_prd_imagem( 'E', ll_cd_produto, ls_log, ref ls_log ) Then return false
			ls_Situacao = 'E'
			ls_Log = ''
			w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
			Continue
		end if
		
		//Excluido com sucesso
		if Not this.of_atualiza_prd_imagem( 'E', ll_cd_produto, '', ref ls_log ) then return false
		
		//Espera de 3 segundos
		Sleep(3)
		
		//Monta o JSON de envio para o site.
		if Not this.of_monta_json( ref ls_json, ref ls_log) Then return false
		
		//Envia a imagem nova para o site.
		luo_comum_vtex.of_post( ls_json, '/api/catalog/pvt/stockkeepingunit/' + ls_cd_sku + '/file', ref ls_retorno, ref ls_log ) 
		
		If ls_Log <> '' and not isnull(ls_Log) Then
			if Not this.of_atualiza_prd_imagem( 'I', ll_cd_produto, ls_log, ref ls_log ) then return false
			ls_Situacao = 'E'
			ls_Log = ''
			w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
			Continue
		end if
		
		//Incluiu a imagem com sucesso
		if Not this.of_atualiza_prd_imagem( 'I', ll_cd_produto, '', ref ls_log ) Then return false
		
		//Insere na log_exportacao_ecommerce para que seja ativada a interface de produtos
		If Not this.of_insere_log_exportacao( ll_cd_produto, ref ls_log ) Then return false
		
		w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
		
	next

	lb_sucesso = True

Finally
	
	if Not lb_sucesso then 
		sqlca.of_rollback( )
		Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_log )	
	else
		if ls_situacao = 'E' Then
			messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Algumas imagens n$$HEX1$$e300$$ENDHEX$$o puderam ser inseridas. Conferir o log do processo.')
		elseif ll_linhas > 0 Then
			messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Imagens enviadas com sucesso.')
		end if
	end if
	
	destroy(lds_dados)
	destroy(luo_comum_vtex)
	
	Close(w_Ge501_Aguarde)
End try

return true
end function

public function boolean of_atualiza_prd_imagem (string ps_tipo, long pl_cd_produto, string ps_mensagem, ref string ps_log);
Choose Case ps_tipo
		
	Case 'E'
		
		if ps_mensagem = '' or isnull(ps_mensagem) Then

			update ecommerce_prd_atualizacao
			set dh_exclusao = getdate(), de_erro_exclusao = null
			where id_ecommerce = :is_id_ecommerce
				and id_rede_filial = :is_rede_ecommerce
				and cd_produto = :pl_cd_produto
				Using sqlca;
				
		else	
				
			update ecommerce_prd_atualizacao
				set de_erro_exclusao = :ps_mensagem
				where id_ecommerce = :is_id_ecommerce
					and id_rede_filial = :is_rede_ecommerce
					and cd_produto = :pl_cd_produto
					Using sqlca;		
					
		end if
		
		if sqlca.sqlcode = -1 then
			ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_prd_imagem~nProblemas ao atualizar registro de exclus$$HEX1$$e300$$ENDHEX$$o: ~n' + sqlca.sqlerrtext
			return false
		end if
		
	Case 'I'	
		
		if ps_mensagem = '' or isnull(ps_mensagem) Then

			update ecommerce_prd_atualizacao
			set dh_inclusao = getdate(), de_erro_inclusao = null
			where id_ecommerce = :is_id_ecommerce
				and id_rede_filial = :is_rede_ecommerce
				and cd_produto = :pl_cd_produto
				Using sqlca;
				
		else	
				
			update ecommerce_prd_atualizacao
				set de_erro_inclusao = :ps_mensagem
				where id_ecommerce = :is_id_ecommerce
					and id_rede_filial = :is_rede_ecommerce
					and cd_produto = :pl_cd_produto
					Using sqlca;		
					
		end if
	
		if sqlca.sqlcode = -1 then
			ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_prd_imagem~nProblemas ao atualizar registro de inclus$$HEX1$$e300$$ENDHEX$$o: ~n' + sqlca.sqlerrtext
			return false
		end if
	
End Choose

SQLCA.of_commit( )

return true
end function

public function boolean of_insere_log_exportacao (long pl_cd_produto, ref string ps_log);
// Inserir o registro na LOG_EXPORTACAO_ECOMMERCE para com o NM_TABELA PRODUTO_GERAL e SKU

//SKU
insert into log_exportacao_ecommerce ( nm_tabela, dh_atualizacao,de_chave,id_atualizacao,id_processado,cd_filial_ecommerce, id_ecommerce, de_origem_inclusao)
	select 'SKU',
				 getdate(),
				convert(char(6), g.cd_produto),
				'A',
				'N',
				r.cd_filial_ecommerce,
				'2',
				'ATUALIZACAO IMAGEM'
	from produto_central c
	inner join produto_geral g on g.cd_produto = c.cd_produto
	inner join ecommerce_rede r on ( r.id_ecommerce = :is_id_ecommerce
									 	   and r.id_rede_filial = :is_rede_ecommerce )
	left outer join ecommerce_prd e on ( e.id_ecommerce = r.id_ecommerce
											   and e.id_rede_filial = r.id_rede_filial
											   and e.cd_produto = g.cd_produto )
	where g.cd_produto = :pl_cd_produto
	and  (  (:is_rede_ecommerce = 'DC' and g.id_liberado_ecommerce_dc = 'S' ) 
				or (:is_rede_ecommerce = 'PP' and g.id_liberado_ecommerce_pp = 'S' ) 
				or (:is_rede_ecommerce = 'FA' and g.id_liberado_ecommerce = 'S' )
				or (:is_rede_ecommerce = 'MP' and g.id_liberado_ecommerce_mp = 'S' )
			 )
	Using SQLCA;
	
	If SQLCA.sqlcode = -1 then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_log_exportacao~nProblemas ao inserir registro na tabela "log_exportacao_ecommerce": ~n' + sqlca.sqlerrtext
		return false
	end if
	
	//PRODUTO_GERAL
	insert into log_exportacao_ecommerce ( nm_tabela, dh_atualizacao,de_chave,id_atualizacao,id_processado,cd_filial_ecommerce, id_ecommerce, de_origem_inclusao)
	select 'PRODUTO_GERAL',
				 getdate(),
				convert(char(6), g.cd_produto),
				'A',
				'N',
				r.cd_filial_ecommerce,
				'2',
				'ATUALIZACAO IMAGEM'
	from produto_central c
	inner join produto_geral g on g.cd_produto = c.cd_produto
	inner join ecommerce_rede r on ( r.id_ecommerce = :is_id_ecommerce
									 	   and r.id_rede_filial = :is_rede_ecommerce )
	left outer join ecommerce_prd e on ( e.id_ecommerce = r.id_ecommerce
											   and e.id_rede_filial = r.id_rede_filial
											   and e.cd_produto = g.cd_produto )
	where g.cd_produto = :pl_cd_produto
	and  (  (:is_rede_ecommerce = 'DC' and g.id_liberado_ecommerce_dc = 'S' ) 
				or (:is_rede_ecommerce = 'PP' and g.id_liberado_ecommerce_pp = 'S' ) 
				or (:is_rede_ecommerce = 'FA' and g.id_liberado_ecommerce = 'S' )
				or (:is_rede_ecommerce = 'MP' and g.id_liberado_ecommerce_mp = 'S' )
			 )
	Using SQLCA;
	
	If SQLCA.sqlcode = -1 then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_log_exportacao~nProblemas ao inserir registro na tabela "log_exportacao_ecommerce": ~n' + sqlca.sqlerrtext
		return false
	end if
	
	SQLCA.of_commit( )
	
	return True
end function

on uo_ge501_produto_imagem.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge501_produto_imagem.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;is_objeto = 'Objeto: ' + this.classname() + '~n'
end event

