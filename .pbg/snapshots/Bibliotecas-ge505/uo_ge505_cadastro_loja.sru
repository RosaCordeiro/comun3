HA$PBExportHeader$uo_ge505_cadastro_loja.sru
forward
global type uo_ge505_cadastro_loja from nonvisualobject
end type
end forward

global type uo_ge505_cadastro_loja from nonvisualobject
end type
global uo_ge505_cadastro_loja uo_ge505_cadastro_loja

forward prototypes
public function boolean of_cadastrar_lojas (string ps_rede)
end prototypes

public function boolean of_cadastrar_lojas (string ps_rede);string ls_log
string ls_id_interface = 'api/v1/loja'
string ls_retorno, ls_json_completo
string ls_id_loja
string ls_cnpj
string ls_id_rede
string ls_url = 'https://service.sitemercado.com.br/'
string ls_chave, ls_token
string ls_info_rede
string ls_json_restante
string ls_de_loja, ls_de_rede

long ll_cd_filial
long ll_existe
long ll_count=0

boolean lb_sucesso = false

uo_ge505_comum luo_comum
uo_ge073_json luo_json
Try 
	luo_comum = create uo_ge505_comum
	luo_json = Create uo_ge073_json 
	
		select top 1 cd_chave_integracao, cd_token_integracao
		into :ls_chave, :ls_token
		from ecommerce_rede_filial
		where id_ecommerce = '3'
		and id_situacao = 'A'
		and id_rede_filial = :ps_rede;
			
		if sqlca.sqlcode = -1 then
			ls_log = sqlca.sqlerrtext
			return false
		end if
	
	luo_comum.is_url = ls_url
	luo_comum.is_senha = ls_token
	luo_comum.is_usuario = ls_chave
	
	//Gera o token pra conectar no webservice.		
	if Not	 luo_comum.of_gera_token( ref ls_log ) Then return false
	
	If ls_Log <> '' and not isnull(ls_Log) Then return false
	
	//Busca a Lista de lojas cadastradas.
	if Not luo_comum.of_get( ls_id_interface , ref ls_json_completo, ref ls_Log ) Then return false
	
	If ls_Log <> '' and not isnull(ls_Log) Then return false
	
	Do While luo_json.of_divide_grupo_json_completo(Ref ls_json_completo, Ref ls_retorno,'{') 
		
		ls_json_restante = ls_retorno
		
		luo_json.of_divide_grupo_json_tag_vtex(ref ls_json_restante, 'rede', ref ls_info_rede, '}')
		
		ls_id_loja = luo_json.of_busca_conteudo_campo_vtex(ls_retorno, 'id')
		ls_cnpj = luo_json.of_busca_conteudo_campo_vtex(ls_retorno, 'cnpj')
		ls_de_loja = luo_json.of_busca_conteudo_campo_vtex(ls_retorno, 'nome')
		
		ls_de_rede = luo_json.of_busca_conteudo_campo_vtex(ls_info_rede, 'nome')
		
		
		Select count(*)
		into :ll_existe
		from ecommerce_rede_filial
		where id_ecommerce = '3'
		and cd_warehouseid = :ls_id_loja;
		
		if sqlca.sqlcode = -1 then
			ls_log = sqlca.sqlerrtext
			return false
		end if
		
		if ll_existe > 0 Then 
		
			Update ecommerce_rede_filial
			set de_ifood = :ls_de_loja, de_rede_ifood = :ls_de_rede,
				cd_chave_integracao = :ls_chave,
				cd_token_integracao = :ls_token
			where cd_warehouseid = :ls_id_loja;
			
			if sqlca.sqlcode = -1 then
				ls_log = sqlca.sqlerrtext
				return false
			end if
			
		else
		
			Select cd_filial, id_rede_filial
			into :ll_cd_filial, :ls_id_rede
			from filial
			where nr_cgc = :ls_cnpj
			and id_situacao = 'A';
			
			if sqlca.sqlcode = -1 then
				ls_log = sqlca.sqlerrtext
				return false
			end if
			
			Insert ecommerce_rede_filial (id_ecommerce,
													id_rede_filial,
													cd_filial,
													cd_url_integracao, 
													cd_chave_integracao,
													cd_token_integracao,
													cd_warehouseid,
													id_situacao,
													de_ifood,
													de_rede_ifood)
				Values('3',
							:ls_id_rede,
							:ll_cd_filial,
							:ls_url,
							:ls_chave,
							:ls_token,
							:ls_id_loja,
							'I',
							:ls_de_loja,
							:ls_de_rede);
													
			
			if sqlca.sqlcode = -1 then
				ls_log = sqlca.sqlerrtext
				return false
			end if
		
		End if
	
		Commit;
		
		ll_count++
		
	Loop
	
	lb_sucesso = true
	
Finally
	
	Destroy(luo_json)
	Destroy(luo_comum)
	
	if lb_sucesso = false then
		Rollback;
		
		If ls_Log <> '' and not isnull(ls_Log) Then
			Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Erro: ' + ls_log)
		end if
	else
		if ll_count = 0 Then
			Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ lojas a serem cadastradas.')
		else
			Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Um total de ' + string(ll_count) + ' lojas foram cadastradas.')
		end if
	end if
	
End Try

return true
end function

on uo_ge505_cadastro_loja.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge505_cadastro_loja.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

