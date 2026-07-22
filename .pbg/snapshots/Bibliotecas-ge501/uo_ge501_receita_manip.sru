HA$PBExportHeader$uo_ge501_receita_manip.sru
forward
global type uo_ge501_receita_manip from nonvisualobject
end type
end forward

global type uo_ge501_receita_manip from nonvisualobject
end type
global uo_ge501_receita_manip uo_ge501_receita_manip

type variables
string is_objeto
string is_id_ecommerce = '2' //VTEX
string is_id_interface = 'api/dataentities/OM/search?_fields=_all'
String is_Codigo_Filial_Vtex
string is_rede_filial
long il_cd_tipo = 23 
Long il_Filial

dc_uo_ds_base ids_dados
uo_ge501_comum iuo_comum
end variables

forward prototypes
public function boolean of_processa_atualizacao_receita (string ps_rede_filial)
public function boolean of_carrega_receita (ref string ps_log)
public function boolean of_executa_upload_receita (long pl_linha, ref string ps_log)
end prototypes

public function boolean of_processa_atualizacao_receita (string ps_rede_filial);String ls_Chave_Nula
String ls_MSG_Nula
String ls_Log
String ls_Situacao
String ls_json
String ls_retorno

long ll_linhas
Long ll_for
Long ll_cd_filial
Long ll_Seq_Log
boolean lb_sucesso=false

DateTime ldh_Data_Nula

SetNull(ls_Chave_Nula)
SetNull(ls_MSG_Nula)
SetNull(ldh_Data_Nula)

try 
	
	Open(w_Aguarde)

	iuo_comum = create uo_ge501_comum
	ids_dados = create dc_uo_ds_base
	
	is_rede_filial = ps_rede_filial
	
	//Carrega os parametros e busca o c$$HEX1$$f300$$ENDHEX$$digo da filial vinculado a rede.
	if Not iuo_comum.of_parametros_ecommerce(is_id_ecommerce, ps_rede_filial, ref ll_cd_filial, ref ls_Log ) Then return false
	
	if not ids_dados.of_changedataobject( 'ds_ge501_receita' , false) Then
		ls_Log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_carrega_marca ~n' + 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ds_ge501_receita'
		return false
	end if

	this.of_carrega_receita( ref ls_log )
	
	if not isnull(ls_log) and ls_log <> '' Then
		iuo_comum.of_envia_email(211, 'RECEITA - [' + ps_rede_filial + ']', ll_Seq_Log, ls_Log, 'RECEITA - [' + ps_rede_filial + ']')
		ls_Situacao = 'E'
		Return false
	end if
	
	ll_linhas = ids_dados.rowcount()

	If ll_Linhas > 0 Then
		iuo_comum.il_qt_item_enviado_site = ll_linhas
         // Grava in$$HEX1$$ed00$$ENDHEX$$cio do processo
		If Not iuo_comum.of_grava_log(ll_cd_filial, il_cd_tipo, ls_Chave_Nula, 'C', ls_MSG_Nula, gf_getserverdate(), gf_getserverdate(), ref ls_Log, ref ll_Seq_Log ) Then Return False
	End If
	
	ls_Situacao = 'P'
	
	w_aguarde.uo_progress.of_setmax(ll_Linhas)
	
	for ll_for = 1 to ll_linhas
		
		w_Aguarde.Title = "Fazendo Upload de Receitas de Manipula$$HEX2$$e700e300$$ENDHEX$$o - [" + ps_rede_filial +  "] - "  + String(ll_for)  + " de " + STring(ll_Linhas)
		
		this.of_executa_upload_receita( ll_for, ref ls_log )
		
		if not isnull(ls_log) and ls_log <> '' Then
			iuo_comum.of_envia_email(211, 'RECEITA - [' + ps_rede_filial + ']', ll_Seq_Log, ls_Log, 'RECEITA - [' + ps_rede_filial + ']')
			iuo_comum.of_grava_log_item( ll_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
			ls_Situacao = 'E'
			w_aguarde.uo_progress.of_setprogress(ll_for)
			ls_log = ''
			Continue
		end if

		iuo_comum.is_url = iuo_comum.is_url_master_data
				
		//sqlca.of_Commit( )
		If Not gf_ge501_commit(SQLCA) Then Return False
		
		if Not iuo_comum.of_grava_log_item(ll_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log ) Then Return false
		
		w_aguarde.uo_progress.of_setprogress(ll_for)
		
	next
			
	lb_sucesso = True

Finally
	
	if Not lb_sucesso then 
		//sqlca.of_rollback( )
		gf_ge501_RollBack(SQLCA)
		
		// J$$HEX1$$e100$$ENDHEX$$ iniciou o envio dos itens
		If ll_for > 0 Then
			// Atualiza log com erro
			If Not iuo_comum.of_atualiza_ecommerce_log(ll_cd_filial, ll_Seq_Log, 'E', ls_Log, gf_getserverdate(), ref ls_Log) Then Return False
			if Not iuo_comum.of_grava_log_item(ll_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log) Then Return false
		Else
			// Se n$$HEX1$$e300$$ENDHEX$$o tiver log insere um novo com erro
			If IsNull(ll_Seq_Log) or ll_Seq_Log = 0 Then
				// Grava in$$HEX1$$ed00$$ENDHEX$$cio do processo - chave e mensagem est$$HEX1$$e300$$ENDHEX$$o indo como nulo
				If Not iuo_comum.of_grava_log(ll_cd_filial, il_cd_tipo, ls_Chave_Nula, 'E', ls_Log, ldh_Data_Nula, gf_getserverdate(), ref ls_Log, ref ll_Seq_Log ) Then Return False
			Else
				// Atualiza log com erro
				If Not iuo_comum.of_atualiza_ecommerce_log(ll_cd_filial, ll_Seq_Log, 'E', ls_Log, gf_getserverdate(), ref ls_Log) Then Return False
			End If		
		End If
	Else
		If ll_Linhas > 0 Then
			// Marca o log como processado
			If Not iuo_comum.of_atualiza_ecommerce_log(ll_cd_filial, ll_Seq_Log, ls_Situacao, ls_MSG_Nula, gf_getserverdate(), ref ls_Log) Then Return False
		End If
	End If
		
	destroy(ids_dados)
	destroy(iuo_comum)
	
	Close(w_Aguarde)
	
End try

return true
end function

public function boolean of_carrega_receita (ref string ps_log);string ls_retorno
string ls_info_receita
string ls_email
string ls_nome
string ls_cpf
string ls_obs
string ls_telefone
string ls_nm_receita
string ls_id_receita
string ls_data_inclusao_site

long ll_linha
long ll_existe

uo_ge073_json luo_gera_json 

datetime ldh_inclusao_site
datetime ldh_inclusao

//Buscar no MasterData da VTEX as receitas de Manipula$$HEX2$$e700e300$$ENDHEX$$o e salvar no Sybase:

luo_gera_json = create uo_ge073_json

//Busca do sybase os registros pendentes , que ainda n$$HEX1$$e300$$ENDHEX$$o foram integrados:
ids_dados.retrieve()

ldh_inclusao = gf_getserverdate()

select max(dh_inclusao_site)
into :ldh_inclusao_site
from ecommerce_manip_receita;

if Not isnull(ldh_inclusao_site) and date(ldh_inclusao_site) <> date('01/01/1900') Then

	//TRansaforma pro hor$$HEX1$$e100$$ENDHEX$$rio de Brasilia ( GMT -3 )
	Select dateadd( HOUR, -1, :ldh_inclusao_site )
	Into :ldh_inclusao_site
	From parametro;
	

	//Acrescenta filtro pela data.
	is_id_interface += '&_where=createdIn > ' + string(ldh_inclusao_site, 'yyyy-mm-dd') + 'T' + String(ldh_inclusao_site,'hh:mm:ss') 

end if

//Busca as receitas da Vtex:
if Not iuo_comum.of_get( is_id_interface, ref ls_retorno, ref ps_log) then return false
	
if not isnull(ps_log) and ps_log <> '' Then return false	
	
Do While luo_gera_json.of_divide_grupo_json_completo(Ref ls_retorno, Ref ls_info_receita,'{') 
	
	ls_email = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_receita, 'email')
	ls_nome = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_receita, 'name')
	
	ls_cpf = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_receita, 'cpf')
	
	ls_obs = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_receita, 'obs')
	ls_telefone = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_receita, 'phone')
	ls_nm_receita = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_receita, 'prescription')
	ls_id_receita = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_receita, 'id')
	ls_data_inclusao_site = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_receita, 'createdIn')
	
	if ids_dados.find('id_receita = "' + ls_id_receita + '"', 1, ids_dados.rowcount( )) > 0 Then Continue
	
	if ls_nm_receita = '' or isnull(ls_nm_receita) Then Continue
	
	Select Count(*)
	into :ll_existe
	from ecommerce_manip_receita
	where id_receita = :ls_id_receita;
	
	if ll_existe > 0 Then Continue

	//Retirar os caracteres especiais do cpf
	ls_cpf = gf_replace(ls_cpf, '.', '',0)
	ls_cpf = gf_replace(ls_cpf, '-', '',0)
	
	ll_linha = ids_dados.insertrow(0)

	ids_dados.object.id_ecommerce[ll_linha] = is_id_ecommerce
	ids_dados.object.id_rede_filial[ll_linha] = is_rede_filial
	ids_dados.object.de_endereco_email[ll_linha] = ls_email
	ids_dados.object.nm_cliente[ll_linha] = ls_nome
	ids_dados.object.nr_cpf_cgc[ll_linha] = ls_cpf
	ids_dados.object.de_observacao[ll_linha] = ls_obs
	ids_dados.object.nr_telefone[ll_linha] = ls_telefone
	ids_dados.object.nm_arquivo_receita[ll_linha] = ls_nm_receita
	ids_dados.object.id_receita[ll_linha] = ls_id_receita
	ids_dados.object.dh_inclusao_site[ll_linha] = Datetime(Date(Left(ls_data_inclusao_site,10)), Time(Mid(ls_data_inclusao_site,12,8) ) )
	ids_dados.object.dh_inclusao[ll_linha] = ldh_inclusao

Loop

if ids_dados.update() = -1 then
	sqlca.of_rollback( )
	ps_log = is_objeto + '; Fun$$HEX2$$e700e300$$ENDHEX$$o: of_carrega_dados ; Problemas ao salvar registros na tabela "ecommerce_manip_receita" : ' + sqlca.is_lasterrortext
	return false
end if

If Not gf_ge501_commit(SQLCA) Then Return False

return true
end function

public function boolean of_executa_upload_receita (long pl_linha, ref string ps_log);
long ll_for
long ll_linhas
long ll_cd_filial
long ll_cd_produto
long ll_nr_pedido
long ll_length
long ll_erro

blob lb_args, lb_retorno

string ls_email
string ls_erro
string ls_retorno
string ls_argumentos
string ls_headers
string ls_id_rede
string ls_id_receita
string ls_nm_arquivo
string ls_nm_cliente
string ls_cpf_cgc
string ls_url_padrao
string ls_url_envio
boolean lb_erro=false

OleObject loo_xmlhttp

Try

	loo_xmlhttp = CREATE oleobject
	loo_xmlhttp.ConnectToNewObject("WinHTTP.WinHTTPRequest.5.1")
		
	// DESENVOLVIMENTO 
	//'https://wssync.clamed.com.br:8091/sync.php?'

	//PRODUCAO
	//'https://wssync.clamed.com.br:8090/sync.php?'
	
	ls_url_padrao = 'https://wssync.clamed.com.br:8090/sync.php?'
	
	//https://wssync.clamed.com.br:8091/sync.php?hash=42dd24a1-3955-11eb-82ac-0a7d25835bcd&nmArquivo=Receita%20QRcode2%20(1).pdf&nrCpfCnpj=075.086.739-64&nmCliente=Rodrigo%20widmann&idRede=PP
		
	ls_id_rede = ids_dados.object.id_rede_filial[pl_linha]	
	ls_id_receita = ids_dados.object.id_receita[pl_linha]
	ls_nm_arquivo = ids_dados.object.nm_arquivo_receita[pl_linha]
	ls_cpf_cgc = ids_dados.object.nr_cpf_cgc[pl_linha]
	ls_nm_cliente = ids_dados.object.nm_cliente[pl_linha]
	ls_email = ids_dados.object.de_endereco_email[pl_linha]
	
	//Valida informa$$HEX2$$e700f500$$ENDHEX$$es obrigat$$HEX1$$f300$$ENDHEX$$rias:
	if isnull(ls_email) or ls_email = '' then
		ps_log = 'email.'
	end if
	
	if isnull(ls_nm_cliente) or ls_nm_cliente = '' then
		ps_log += 'nome.'
	end if
	
	if isnull(ls_cpf_cgc) or ls_cpf_cgc = '' then
		ps_log += 'CPF.'
	end if

	if ps_log <> '' and not isnull(ps_log) Then
		ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar as seguintes informa$$HEX2$$e700f500$$ENDHEX$$es do usu$$HEX1$$e100$$ENDHEX$$rio: ' + ps_log
		return false
	end if

	if isnull(ls_nm_arquivo) Then
		ls_nm_arquivo = ''
	else
		ls_nm_arquivo = gf_replace(ls_nm_arquivo, ' ' , '%20', 0)
	end if
	
	if isnull(ls_nm_cliente) Then
		ls_nm_cliente = ''
	else
		ls_nm_cliente = gf_replace(ls_nm_cliente, ' ' , '%20', 0)
	end if
	
	ls_argumentos = 'hash=' + ls_id_receita + '&nmArquivo=' + ls_nm_arquivo + '&nrCpfCnpj=' + ls_cpf_cgc + '&nmCliente=' + ls_nm_cliente + '&idRede=' + ls_id_rede + '&entidade=OM'
	
	loo_xmlhttp.open ("GET",ls_url_padrao + ls_argumentos, false)
	loo_xmlhttp.send()
	
	ls_retorno = upper(loo_xmlhttp.ResponseText)
	
	if isnull(ls_retorno) Then ls_retorno = ''
	
	If ls_retorno <> '"PDF CADASTRADO COM SUCESSO"'  Then
		ps_log = is_objeto + '; Fun$$HEX2$$e700e300$$ENDHEX$$o: of_executa_upload_receita ; ' + ' - N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel fazer o upload da receita: ' + ls_retorno 
		return false
	end if

	Update ecommerce_manip_receita
	set dh_receita_integrada = getdate()
	where id_ecommerce = :is_id_ecommerce
		and id_rede_filial = :ls_id_rede
		and id_receita = :ls_id_receita;
	
	If SqlCa.SqlCode = -1 Then
		ps_log = is_objeto + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_executa_upload_receita ~n' + 'Erro ao atualizar registro na tabela "ecommerce_manip_receita": ~n' + SqlCa.sqlerrtext 
		return false
	end if

Finally 
	
	loo_xmlhttp.DisconnectObject()
	
	Destroy(loo_xmlhttp)
End Try

return true


return true
end function

on uo_ge501_receita_manip.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge501_receita_manip.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;is_objeto = 'Objeto: ' + this.classname() + '~n'
end event

