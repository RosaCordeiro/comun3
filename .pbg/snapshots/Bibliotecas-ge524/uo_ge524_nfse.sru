HA$PBExportHeader$uo_ge524_nfse.sru
forward
global type uo_ge524_nfse from nonvisualobject
end type
end forward

global type uo_ge524_nfse from nonvisualobject
end type
global uo_ge524_nfse uo_ge524_nfse

type variables

boolean ib_exibe_msg = false

string is_objeto
string is_url
string is_id_interface = '/nfse'
string is_token
string is_json_completo
string is_chave_nf_servico
string is_nr_protocolo
string is_nr_protocolo_canc
string is_numero_nfse
string is_codigo_verificacao

//string is_url_impressao = 'https://nfemhomologacao.joinville.sc.gov.br/processos/imprimir_nfe.aspx?codigo=@CODIGO@&numero=@NR_NFSE@&documento_prestador=@NR_CNPJ@'
//string is_url_impressao = 'https://nfem.joinville.sc.gov.br/processos/imprimir_nfe.aspx?codigo=@CODIGO@&numero=@NR_NFSE@&documento_prestador=@NR_CNPJ@'

string is_url_impressao = 'https://wssync.clamed.com.br:8090/recebe_nota/SendNota.php?hash=@HASH@&token=@TOKEN@'

string is_prestador_cgc
string is_prestador_razao_social
string is_prestador_nm_fantasia
string is_prestador_endereco
string is_prestador_nr_endereco
string is_prestador_endereco_compl
string is_prestador_bairro
string is_prestador_estado
string is_prestador_cep
string is_prestador_cd_cidade
string is_prestador_nm_cidade
string is_prestador_nr_ddd
string is_prestador_nr_telefone
string is_prestador_email
string is_prestador_simples
string is_prestador_reg_trib
string is_prestador_inc_cultural
string is_prestador_inc_fiscal
string is_prestador_reg_trib_espec

string is_tomador_nr_endereco
string is_tomador_cpf
string is_tomador_nome
string is_tomador_endereco
string is_tomador_estado
string is_tomador_cep
string is_tomador_cidade_ibge
string is_tomador_bairro
string is_tomador_ddd
string is_tomador_telefone
string is_tomador_email
string is_tomador_complemento
Long il_tomador_cidade

String is_inscricao_municipal
String is_inscricao_estadual

string is_de_especie
string is_de_serie
string is_nr_nf_servico
string is_matricula_operador
string is_cd_servico 
string is_de_servico 

string is_base_producao
string is_email_homologacao = 'sergio.gol@clamed.com.br'
string is_status
string is_mensagem_retorno

boolean ib_base_matriz

decimal idc_pc_aliquota_iss
decimal idc_vl_iss
decimal idc_base_iss

datetime idh_emissao
datetime idh_retorno
datetime idh_envio
datetime idh_cancelamento
datetime idh_envio_canc
datetime idh_retorno_canc

long il_cd_filial
long il_nr_nf_cupom

str_ge524_tomador istr_tomador
end variables

forward prototypes
public function boolean of_carrega_dados_prestador (ref string ps_log)
public function boolean of_carrega_dados_tomador (ref string ps_log)
public function boolean of_monta_json (ref string ps_log)
public function boolean of_processa_nfse (long pl_cd_filial, long pl_nr_nota, string ps_especie, string ps_serie, string ps_cd_servico, string ps_de_servico, decimal pdc_base_iss, decimal pdc_aliq_iss, str_ge524_tomador pstr_tomador, boolean pb_exibe_msg, ref string ps_log)
public function boolean of_processa_nfse (long pl_cd_filial, long pl_nr_nota, string ps_especie, string ps_serie, string ps_cd_servico, string ps_de_servico, decimal pdc_base_iss, decimal pdc_aliq_iss, boolean pb_exibe_msg, ref string ps_log)
public function boolean of_verifica_base (ref string ps_log)
public function boolean of_comunicacao_api (string ps_metodo, string ps_json, string ps_interface, ref string ps_retorno, ref string ps_log)
public function boolean of_tratar_retorno (string ps_tipo, string ps_json, ref string ps_log)
public function boolean of_atualiza_nf_servico (string ps_situacao, string ps_msg, ref string ps_log)
public function boolean of_consulta_nfse (string ps_nr_protocolo, ref string ps_log)
public function boolean of_consulta_nfse (string ps_nr_protocolo, string ps_id_chave_nf_servico, long pl_cd_filial, boolean pb_consulta_individual, ref string ps_log)
public function boolean of_grava_nota_servico (boolean pb_insercao, ref string ps_log)
public function boolean of_imprimir_nfse (string ps_url_impressao, ref string ps_log)
public function boolean of_imprimir_nfse (string ps_nr_protocolo, ref string ps_url_impressao, ref string ps_log)
public function boolean of_carregar_parametros (ref string ps_log, boolean pb_impressao)
public function boolean of_cancelar_nfse_consulta (string ps_nr_protocolo, string ps_id_chave_nf_servico, long pl_cd_filial, ref string ps_log)
public function datetime of_transforma_data (datetime pdt_data)
public function boolean of_cancelar_nfse (long pl_cd_filial, string ps_nr_protocolo, string ps_id_nfse, boolean pb_exibe_msg, ref string ps_log)
public function boolean of_imprimir_nfse (string ps_url_impressao)
end prototypes

public function boolean of_carrega_dados_prestador (ref string ps_log);


select f.nr_cgc, 
		f.nm_razao_social, 
		f.nm_fantasia, 
		f.de_endereco, 
		f.nr_endereco, 
		f.de_bairro, 
		f.nr_cep, 
		c.cd_cidade_ibge, 
		c.nm_cidade, 
		f.nr_ddd_telefone, 
		f.nr_telefone,
		f.nr_inscricao_estadual,
		c.cd_unidade_federacao
into :is_prestador_cgc,
	 :is_prestador_razao_social,
	:is_prestador_nm_fantasia,
	:is_prestador_endereco,
	:is_prestador_nr_endereco,
	:is_prestador_bairro,
	:is_prestador_cep,
	:is_prestador_cd_cidade,
	:is_prestador_nm_cidade,
	:is_prestador_nr_ddd,
	:is_prestador_nr_telefone,
	:is_inscricao_estadual,
	:is_prestador_estado
from filial f
    inner join cidade c on c.cd_cidade = f.cd_cidade 
where cd_filial = :il_cd_filial;

if sqlca.sqlcode = -1 then
	ps_log =  is_objeto + '; Fun$$HEX2$$e700e300$$ENDHEX$$o: of_carrega_dados_prestador; Erro: ' + sqlca.sqlerrtext
	return false
end if

is_prestador_email = iif(is_base_producao = 'S', 'fiscal@clamed.com.br', is_email_homologacao)
is_prestador_simples = 'false'
is_prestador_reg_trib = '4'
is_prestador_inc_cultural = 'false'
is_prestador_reg_trib_espec = '0'
is_prestador_inc_fiscal = 'false'

is_inscricao_estadual = gf_replace( is_inscricao_estadual, '.','',0)

if is_prestador_cgc = '' or isnull(is_prestador_cgc) Then
	ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar o CNPJ do prestador.'
	return false
end if

if is_prestador_razao_social = '' or isnull(is_prestador_razao_social) Then
	ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar a raz$$HEX1$$e300$$ENDHEX$$o social do prestador.'
	return false
end if

if is_prestador_nm_fantasia = '' or isnull(is_prestador_nm_fantasia) Then
	ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar o nome fantasia do prestador.'
	return false
end if

if is_prestador_endereco = '' or isnull(is_prestador_endereco) Then
	ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar o endere$$HEX1$$e700$$ENDHEX$$o do prestador.'
	return false
end if

if is_prestador_nr_endereco = '' or isnull(is_prestador_nr_endereco) Then
	ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar o n$$HEX1$$fa00$$ENDHEX$$mero do endere$$HEX1$$e700$$ENDHEX$$o do prestador.'
	return false
end if

if is_prestador_bairro = '' or isnull(is_prestador_bairro) Then
	ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar o bairro do prestador.'
	return false
end if

if is_prestador_estado = '' or isnull(is_prestador_estado) Then
	ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar o estado (UF) do prestador.'
	return false
end if

if is_prestador_cep = '' or isnull(is_prestador_cep) Then
	ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar o CEP do prestador.'
	return false
end if

if is_prestador_cd_cidade = '' or isnull(is_prestador_cd_cidade) Then
	ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar a cidade do prestador.'
	return false
end if

if is_prestador_nm_cidade = '' or isnull(is_prestador_nm_cidade) Then
	ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar o nome da cidade do prestador.'
	return false
end if

if is_prestador_nr_ddd = '' or isnull(is_prestador_nr_ddd) Then
	ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar o n$$HEX1$$fa00$$ENDHEX$$mero DDD do prestador.'
	return false
end if

if is_prestador_nr_telefone = '' or isnull(is_prestador_nr_telefone) Then
	ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar o telefone do prestador.'
	return false
end if

if is_inscricao_estadual = '' or isnull(is_inscricao_estadual) Then
	ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar o n$$HEX1$$fa00$$ENDHEX$$mero da inscri$$HEX2$$e700e300$$ENDHEX$$o estadual do prestador.'
	return false
end if

return true
end function

public function boolean of_carrega_dados_tomador (ref string ps_log);boolean lb_usa_tomador = false
string ls_nm_cidade

if ib_base_matriz = True Then 
	
	if isvalid(istr_tomador) Then
	
		is_tomador_cep = istr_tomador.cep
		//is_tomador_cidade = istr_tomador.cidade
		is_tomador_cpf = istr_tomador.cpf
		is_tomador_endereco = istr_tomador.de_endereco
		is_tomador_email = istr_tomador.email
		is_tomador_ddd = istr_tomador.ddd
		is_tomador_nome = istr_tomador.nome
		is_tomador_nr_endereco = String(istr_tomador.nr_endereco)
		is_tomador_telefone = istr_tomador.telefone
		
	end if
	
else

	select p.nr_cpf_cheque, 
			p.nm_cliente_entrega, 
			p.de_endereco_entrega, 
			p.nr_endereco_entrega, 
			p.nr_cep_entrega, 
			p.nr_telefone_entrega, 
			p.de_endereco_email,
			p.de_bairro_entrega,
			p.de_complemento_endereco,
			p.cd_cidade_entrega,
			p.cd_uf_entrega
	into :is_tomador_cpf,
			:is_tomador_nome,
			:is_tomador_endereco,
			:is_tomador_nr_endereco,
			:is_tomador_cep,
			:is_tomador_telefone,
			:is_tomador_email,
			:is_tomador_bairro,
			:is_tomador_complemento,
			:il_tomador_cidade,
			:is_tomador_estado
	from nf_venda n
		inner join pedido_drogaexpress p on (p.nr_pedido_ecommerce = n.nr_pedido_ecommerce)
	where n.cd_filial = :il_cd_filial
		and n.nr_nf = :il_nr_nf_cupom
		and n.de_especie = :is_de_especie
		and n.de_serie = :is_de_serie;
	
	if sqlca.sqlcode = -1 then
		ps_log =  is_objeto + '; Fun$$HEX2$$e700e300$$ENDHEX$$o: of_carrega_dados_tomador; Problemas ao consultar a tabela "nf_venda/pedido_drogaexpress": ' + sqlca.sqlerrtext
		return false
	end if
	
	ls_nm_cidade = gf_retira_acentos(ls_nm_cidade)
	
	Select cd_cidade_ibge
	into :is_tomador_cidade_ibge
	from cidade
	where cd_cidade = :il_tomador_cidade;
	
	if sqlca.sqlcode = -1 then
		ps_log =  is_objeto + '; Fun$$HEX2$$e700e300$$ENDHEX$$o: of_carrega_dados_tomador; Problemas ao consultar a tabela "cidade" : ' + sqlca.sqlerrtext
		return false
	end if
	
	is_tomador_ddd = mid( is_tomador_telefone,2,2)
	is_tomador_telefone = mid( is_tomador_telefone, 5 )

End if

is_tomador_endereco = mid(is_tomador_endereco,1,40)
if isnull(is_tomador_endereco) then is_tomador_endereco = ''

is_tomador_bairro = mid(is_tomador_bairro,1,30)
if isnull(is_tomador_bairro) then is_tomador_bairro = ''

is_tomador_complemento = mid(is_tomador_complemento,1,30)
if isnull(is_tomador_complemento) then is_tomador_complemento = ''

if is_tomador_cpf = '' or isnull(is_tomador_cpf) Then
	ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar o CPF do tomador.'
	return false
end if

if is_tomador_nome = '' or isnull(is_tomador_nome) Then
	ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar o Nome do tomador.'
	return false
end if

if is_tomador_endereco = '' or isnull(is_tomador_endereco) Then
	ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar o endere$$HEX1$$e700$$ENDHEX$$o do tomador.'
	return false
end if

if is_tomador_nr_endereco = '' or isnull(is_tomador_nr_endereco) Then
	ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar o n$$HEX1$$fa00$$ENDHEX$$mero do endere$$HEX1$$e700$$ENDHEX$$o do tomador.'
	return false
end if

if is_tomador_estado = '' or isnull(is_tomador_estado) Then
	ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar o estado (UF) do tomador.'
	return false
end if

if is_tomador_cep = '' or isnull(is_tomador_cep) Then
	ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar o CEP do tomador.'
	return false
end if

if is_tomador_cidade_ibge = '' or isnull(is_tomador_cidade_ibge) Then
	ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar a cidade do tomador.'
	return false
end if

if is_tomador_telefone = '' or isnull(is_tomador_telefone) Then
	ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar o telefone do tomador.'
	return false
end if

if is_tomador_ddd = '' or isnull(is_tomador_ddd) Then
	ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar o DDD do tomador.'
	return false
end if

if is_tomador_email = '' or isnull(is_tomador_email) Then
	ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar o email do tomador.'
	return false
end if

return true
end function

public function boolean of_monta_json (ref string ps_log);

is_json_completo = '[{'

is_json_completo += '"idIntegracao": "' + is_chave_nf_servico + '", '
is_json_completo += '"enviarEmail": true, '

//Endereco Prestador
is_json_completo += '"cidade_prestacao": { '
is_json_completo += '"codigo": "' + is_prestador_cd_cidade + '", '
is_json_completo += '"descricao": "' + is_prestador_nm_cidade + '", '
is_json_completo += '"logradouro": "' + is_prestador_endereco + '", '
is_json_completo += '"numero": "' + is_prestador_nr_endereco + '", '
is_json_completo += '"complemento": "' + is_prestador_endereco_compl + '", '
is_json_completo += '"bairro": "' + is_prestador_bairro + '", '
is_json_completo += '"cep": "' + is_prestador_cep + '" '
is_json_completo += ' }, '


is_json_completo += '"idNotaSubstituida": "", ' 
is_json_completo += '"naturezaTributacao": "", ' 

//****************************
//Dados da Empresa (Prestador):
is_json_completo += '"prestador": { ' 
is_json_completo += '"cpfCnpj": "' + is_prestador_cgc + '", '
is_json_completo += '"inscricaoMunicipal": "' + is_inscricao_municipal + '", '
is_json_completo += '"inscricaoEstadual": "' + is_inscricao_estadual + '", '
is_json_completo += '"razaoSocial": "' + is_prestador_razao_social + '", '
is_json_completo += '"nomeFantasia": "' + is_prestador_nm_fantasia + '", '
is_json_completo += '"simplesNacional": ' + is_prestador_simples + ', '
is_json_completo += '"regimeTributario": ' + is_prestador_reg_trib+ ', '
is_json_completo += '"incentivoFiscal": ' + is_prestador_inc_fiscal+ ', '
is_json_completo += '"incentivadorCultural": ' + is_prestador_inc_cultural+ ', '
is_json_completo += '"regimeTributarioEspecial": ' + is_prestador_reg_trib_espec+ ', '
is_json_completo += '"email": "' + is_prestador_email + '", '

//Endere$$HEX1$$e700$$ENDHEX$$o da Empresa:
is_json_completo += '"endereco": { ' 
is_json_completo += '"logradouro": "' + is_prestador_endereco + '", ' 
is_json_completo += '"numero": "' + is_prestador_nr_endereco + '", '
is_json_completo += '"complemento": "' + is_prestador_endereco_compl + '", '
is_json_completo += '"bairro": "' + is_prestador_bairro + '", '
is_json_completo += '"codigoCidade": "' + is_prestador_cd_cidade + '", '
is_json_completo += '"descricaoCidade": "' + is_prestador_nm_cidade + '", '
is_json_completo += '"estado": "' + is_prestador_estado + '", '
is_json_completo += '"cep": "' + is_prestador_cep + '" '
is_json_completo += ' }, '

//Telefone da Empresa:
is_json_completo += '"telefone": { '
is_json_completo +=  '"ddd": "' + is_prestador_nr_ddd + '", '
is_json_completo +=  '"numero": "' + is_prestador_nr_telefone + '" '
is_json_completo += '} '

is_json_completo += '}, '
//****************************

//****************************
//Dados do Cliente (Tomador):
is_json_completo += '"tomador": { '
is_json_completo += '"cpfCnpj": "' + is_tomador_cpf + '", '
is_json_completo += '"razaoSocial": "' + is_tomador_nome + '", '
is_json_completo += '"endereco": { '
is_json_completo += '"logradouro": "' + is_tomador_endereco + '", '
is_json_completo += '"numero": "' + is_tomador_nr_endereco + '", '
is_json_completo += '"complemento": "' + is_tomador_complemento + '", '
is_json_completo += '"bairro": "' + is_tomador_bairro + '", '
is_json_completo += '"codigoCidade": "' + is_tomador_cidade_ibge + '", '
is_json_completo += '"estado": "' + is_tomador_estado + '", '
is_json_completo += '"cep": "' + is_tomador_cep + '" '
is_json_completo += ' } '

is_json_completo += '}, '
//****************************

//Informa$$HEX2$$e700f500$$ENDHEX$$es do servi$$HEX1$$e700$$ENDHEX$$o:
is_json_completo += '"servico": [{ '
is_json_completo += '"codigo": "' + is_cd_servico + '", '
is_json_completo += '"discriminacao": "' + is_de_servico + '", '
is_json_completo += '"codigoCidadeIncidencia": "' + is_prestador_cd_cidade + '", '
is_json_completo += '"descricaoCidadeIncidencia": "' + is_prestador_nm_cidade + '", '
is_json_completo += '"quantidade": 1, '
 
is_json_completo += '"iss": { '
is_json_completo += '"tipoTributacao": 6, '
is_json_completo += '"exigibilidade": 1, '
is_json_completo += '"retido": false, '
is_json_completo += '"aliquota": ' + gf_replace( String(idc_pc_aliquota_iss), ',','.',0) + ', '
is_json_completo += '"valor": ' + gf_replace( String(idc_vl_iss), ',','.',0) 
is_json_completo += '}, '

is_json_completo += '"valor": { '
is_json_completo += '"servico": ' + gf_replace( String(idc_base_iss), ',','.',0)  + ', '
is_json_completo += '"baseCalculo": ' + gf_replace( String(idc_base_iss), ',','.',0)  + ', '
is_json_completo += '"descontoCondicionado": 0.00, '
is_json_completo += '"descontoIncondicionado": 0.00, '
is_json_completo += '"liquido": ' + gf_replace( String(idc_base_iss), ',','.',0)  + ', '
is_json_completo += '"unitario": ' + gf_replace( String(idc_base_iss), ',','.',0)  + ', '
is_json_completo += '"valorAproximadoTributos": 0.00 '
is_json_completo += '}, '

is_json_completo+= '"tributavel": false '
is_json_completo += '}], '
//****************************

is_json_completo += '"descricao": "", '
is_json_completo += '"informacoesComplementares": "" '
is_json_completo += '}] '


return true
end function

public function boolean of_processa_nfse (long pl_cd_filial, long pl_nr_nota, string ps_especie, string ps_serie, string ps_cd_servico, string ps_de_servico, decimal pdc_base_iss, decimal pdc_aliq_iss, str_ge524_tomador pstr_tomador, boolean pb_exibe_msg, ref string ps_log);string ls_retorno, ls_erro
long ll_for
boolean lb_sucesso = false
boolean lb_consultar = True

Try
	
	il_cd_filial = pl_cd_filial
	il_nr_nf_cupom = pl_nr_nota
	is_de_especie = ps_especie
	is_de_serie = ps_serie
	is_cd_servico = ps_cd_servico
	is_de_servico = ps_de_servico
	idc_base_iss = pdc_base_iss
	idc_pc_aliquota_iss = pdc_aliq_iss
	
	istr_tomador = pstr_tomador
	
	is_matricula_operador = gvo_aplicacao.ivo_seguranca.nr_matricula
	
	if isnull(idc_base_iss) Then idc_base_iss = 0
	if isnull(idc_pc_aliquota_iss) Then idc_pc_aliquota_iss = 0
	
	idc_vl_iss = round(idc_base_iss * (idc_pc_aliquota_iss / 100), 2)
	
	//Verifica se est$$HEX1$$e100$$ENDHEX$$ na Matriz (Sybase) ou em uma filial (Postgresql):
	If Not this.of_verifica_base( ref ps_log ) Then return false
	
	If Not this.of_carregar_parametros( ref ps_log, False ) then return false
	
	//Primeiro j$$HEX1$$e100$$ENDHEX$$ insere um registro na tabela nf_servico:
	If Not this.of_grava_nota_servico( True, ref ps_log ) then return false
	
	SQLCA.of_commit( )
	
	//Busca os dados do prestador:
	If Not this.of_carrega_dados_prestador( ref ps_log ) then return false
	
	//Busca os dados do tomador:
	If Not this.of_carrega_dados_tomador( ref ps_log ) then return false
	
	//Atualiza os dados na tabela nf_servico:
	If Not this.of_grava_nota_servico( False, ref ps_log ) then return false
	
	//Se o numero do protocolo ainda n$$HEX1$$e300$$ENDHEX$$o existe, Emite a NFSe.
	if is_nr_protocolo = '' or isnull(is_nr_protocolo) Then
		
		If Not this.of_monta_json( ref ps_log ) then return false
		
		//Realiza emiss$$HEX1$$e300$$ENDHEX$$o da nota:
		If Not this.of_comunicacao_api( 'POST', is_json_completo, is_id_interface, ref ls_retorno, ref ps_log ) then return false
		
		if ps_log <> '' and not isnull(ps_log) Then
			ls_retorno = ps_log
			ps_log = ''
			If Not this.of_tratar_retorno( 'ERRO', ls_retorno, ref ps_log ) then return false
			return false
		end if
		
		If Not this.of_tratar_retorno( 'E', ls_retorno, ref ps_log ) then return false
		
		//Atualiza$$HEX2$$e700e300$$ENDHEX$$o situa$$HEX2$$e700e300$$ENDHEX$$o para Enviada:
		If Not this.of_atualiza_nf_servico( 'N', '', ref ps_log ) then return false
		
		SQLCA.of_commit( )
		
		Sleep(5)
		
	end if
	
	if lb_consultar = True Then
	
		//Realiza 3 tentativas de consulta para verificar se foi Autorizada:
		for ll_for = 1 to 3 
			
			if Not this.of_consulta_nfse( is_nr_protocolo, ref ps_log ) then return false
			
			//Se a nfse j$$HEX1$$e100$$ENDHEX$$ foi processada sai do loop
			if is_numero_nfse <> '' and not isnull(is_numero_nfse) then 
				Exit
			end if
			
			if ll_for < 3 then
				Sleep(5)
			end if
			
		Next
	
	end if
	
	lb_sucesso = true
	
Finally
	
	If lb_sucesso = True Then
		SQLCA.of_commit( )
	else
		SQLCA.of_rollback( )	
		
		//Muda situa$$HEX2$$e700e300$$ENDHEX$$o para erro e grava Log:
		if is_chave_nf_servico <> '' and not isnull(is_chave_nf_servico) Then		
			ls_erro = ps_log
			If Not this.of_atualiza_nf_servico( 'E', ls_erro, ref ps_log ) then
				SQLCA.of_rollback( )
			else
				SQLCA.of_commit( )
			end if
		else
			//Se ainda n$$HEX1$$e300$$ENDHEX$$o existe registro na tabela, exibe mensagem de erro para o usu$$HEX1$$e100$$ENDHEX$$rio:
			if pb_exibe_msg Then
				Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', ps_log)
				ps_log = '-1'
			end if
		end if
		
	end if
	
End Try

return true
end function

public function boolean of_processa_nfse (long pl_cd_filial, long pl_nr_nota, string ps_especie, string ps_serie, string ps_cd_servico, string ps_de_servico, decimal pdc_base_iss, decimal pdc_aliq_iss, boolean pb_exibe_msg, ref string ps_log);str_ge524_tomador lstr_nulo

return this.of_processa_nfse( pl_cd_filial, pl_nr_nota, ps_especie, ps_serie, ps_cd_servico, ps_de_servico, pdc_base_iss, pdc_aliq_iss, lstr_nulo, pb_exibe_msg, ref ps_log )


end function

public function boolean of_verifica_base (ref string ps_log);long ll_cd_filial, ll_cd_filial_matriz

Select cd_filial, cd_filial_matriz
Into :ll_cd_filial, :ll_cd_filial_matriz
From parametro
Where id_parametro = '1'
Using SqlCa;

if sqlca.sqlcode = -1 then
	ps_log = is_objeto + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_verifica_base ~nProblemas ao consultar a tabela "parametro": ~n' + sqlca.sqlerrtext
	return false
end if

if ll_cd_filial = ll_cd_filial_matriz Then
	ib_base_matriz = True
else
	ib_base_matriz = false
end if

return true
end function

public function boolean of_comunicacao_api (string ps_metodo, string ps_json, string ps_interface, ref string ps_retorno, ref string ps_log);Long ll_status_code
String ls_url_local
String ls_status_text
String ls_Retorno_Api
any la_result

OleObject luo_SrvHTTP, luo_Send

//Adiciona $$HEX1$$e000$$ENDHEX$$ url qual interface est$$HEX1$$e100$$ENDHEX$$ sendo utilizada
ls_url_local = is_url + ps_interface
	
Try	
		
	luo_SrvHTTP = CREATE oleobject
	luo_SrvHTTP.ConnectToNewObject("MSXML2.SERVERXMLHTTP.6.0")
		
	luo_Send = CREATE oleobject
	luo_Send.ConnectToNewObject("Msxml2.DOMDocument.6.0")
			
		
	luo_SrvHTTP.open (ps_metodo, ls_url_local, false) 
	
	luo_SrvHTTP.setRequestHeader("x-api-key", is_token) 
	
	if ps_json <> '' and not isnull(ps_json) Then
		luo_SrvHTTP.SetRequestHeader("content-type", "application/json")
	end if
	
	//
	//// Trust the SSL Certificate - IGNORA OS ERROS DE CERTIFICADO
	//iole_SrvHTTP.setOption(2,'13056') 
	
	IF IsValid(luo_SrvHTTP) THEN
		
		TRY
			If IsNull( ps_Json ) Then ps_Json = ''
			
			If(ps_metodo = 'GET') Then
				luo_SrvHTTP.Send(luo_Send)
			Else
				luo_SrvHTTP.send(ps_json) 
			End If
			
		CATCH (RuntimeError e) 
			ps_log = this.classname( ) + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_comunicacao_api ~nErro: ' + e.getMessage()
			Return false
		END TRY 
		
		ll_status_code = luo_SrvHTTP.readyState 
		IF luo_SrvHTTP.readyState <> 4 THEN
			luo_SrvHTTP.DisconnectObject() 
			Destroy luo_SrvHTTP 
			
			ps_log = this.classname( ) + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_comunicacao_api ~nErro: readyState = ' + String(ll_status_code)
			Return false
			
		End If
		
		//Get response 
		ls_status_text = luo_SrvHTTP.StatusText 
		ll_status_code = luo_SrvHTTP.Status 
		
		ls_Retorno_Api = String( luo_SrvHTTP.ResponseText )
		
		if ll_status_code = 200 Then
			
			ps_retorno = ls_retorno_api
			ps_log = ''
			
		else
			ps_retorno = ''
			ps_log = ls_Retorno_Api
		end if
		
	End If
	
Finally	
	
	IF IsValid(luo_SrvHTTP) THEN 
		luo_SrvHTTP.DisconnectObject()
		Destroy luo_SrvHTTP 
	end if
	
	IF IsValid(luo_Send) THEN 
		luo_Send.DisconnectObject()
		Destroy luo_Send 
	end if

End Try

Return true



end function

public function boolean of_tratar_retorno (string ps_tipo, string ps_json, ref string ps_log);string ls_json_restante, ls_retorno, ls_situacao, ls_data_emissao, ls_data_cancel, ls_nr_nf_retorno
uo_ge073_json luo_gera_json

luo_gera_json = Create uo_ge073_json 

ls_json_restante = ps_json

if ps_tipo = 'E' Then //Tratar retorno do processo de Emiss$$HEX1$$e300$$ENDHEX$$o
	
	luo_gera_json.of_divide_grupo_json_tag_vtex(ref ls_json_restante, 'documents', ref ls_retorno, '}')
	
	is_nr_protocolo = luo_gera_json.of_busca_conteudo_campo_vtex(ls_retorno, 'id')

Elseif ps_tipo = 'S' then //Tratar retorno do processo de Solicita$$HEX2$$e700e300$$ENDHEX$$o deCancelamento
	
	luo_gera_json.of_divide_grupo_json_tag_vtex(ref ls_json_restante, 'data', ref ls_retorno, '}')
	
	is_nr_protocolo_canc = luo_gera_json.of_busca_conteudo_campo_vtex(ls_retorno, 'protocol')
	
Elseif ps_tipo = 'X' then //Tratar retorno do processo Conculta de Cancelamento
	
	luo_gera_json.of_divide_grupo_json_tag_vtex(ref ls_json_restante, 'data', ref ls_retorno, '}')
	
	is_status = luo_gera_json.of_busca_conteudo_campo_vtex(ls_retorno, 'status')
	ls_data_cancel = luo_gera_json.of_busca_conteudo_campo_vtex(ls_retorno, 'date')
	idh_cancelamento = Datetime( Date( left( ls_data_cancel, 10) ), time( mid( ls_data_cancel, 12, 8 ) ) )
	
	idh_cancelamento = this.of_transforma_data( idh_cancelamento )

Elseif ps_tipo = 'C' then //Tratar retorno do processo de Consulta
	
	luo_gera_json.of_divide_grupo_json_tag_vtex(ref ls_json_restante, 'retorno', ref ls_retorno, '}')
	
	ls_data_emissao = luo_gera_json.of_busca_conteudo_campo_vtex(ps_json, 'dataEmissao')
	idh_emissao = Datetime( Date( left( ls_data_emissao, 10) ), time( mid( ls_data_emissao, 12, 8 ) ) )
	
	idh_emissao = this.of_transforma_data( idh_emissao )

	is_codigo_verificacao 	= luo_gera_json.of_busca_conteudo_campo_vtex(ls_retorno, 'codigoVerificacao')
	is_mensagem_retorno = luo_gera_json.of_busca_conteudo_campo_vtex(ls_retorno, 'mensagemRetorno')
	ls_nr_nf_retorno	= luo_gera_json.of_busca_conteudo_campo_vtex(ls_retorno, 'numeroNfse')
	ls_situacao 			= luo_gera_json.of_busca_conteudo_campo_vtex(ls_retorno, 'situacao')
	is_status				= luo_gera_json.of_busca_conteudo_campo_vtex(ls_json_restante, 'status')
	//Retorna = "202400000002323"
	is_numero_nfse 	= Mid(ls_nr_nf_retorno, 5)
	
	
Else //erro
	
	ps_log = luo_gera_json.of_busca_conteudo_campo_vtex(ps_json, 'message')
	
ENd if

destroy(luo_gera_json)

return true
end function

public function boolean of_atualiza_nf_servico (string ps_situacao, string ps_msg, ref string ps_log);long ll_nr_nfse

if ps_msg = '' then setnull(ps_msg)

if ps_situacao = 'N' then //Enviada

	//Salva o ID da nota para poder consultar depois.
	Update nf_servico
	set nr_protocolo = :is_nr_protocolo, id_situacao = :ps_situacao, de_retorno = null
	where id_nfse = :is_chave_nf_servico;
	
	if sqlca.sqlcode = -1 then
		ps_log = is_objeto + '; Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_nf_servico ; Problemas ao atualizar a tabela "nf_servico":  ' + sqlca.sqlerrtext
		return false
	end if

Elseif ps_situacao =  'A' then //Autorizada
	
	ll_nr_nfse = long(is_numero_nfse)
	
	idh_retorno = gf_getserverdate()
	
	Update nf_servico
	set nr_nf_servico = :ll_nr_nfse, 
		dh_emissao = :idh_emissao, 
		dh_retorno = :idh_retorno, 
		id_situacao = :ps_situacao, 
		de_retorno = :is_status,
		cd_verificacao = :is_codigo_verificacao
	where id_nfse = :is_chave_nf_servico;
	
	if sqlca.sqlcode = -1 then
		ps_log = is_objeto + '; Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_nf_servico ; Problemas ao atualizar a tabela "nf_servico":  ' + sqlca.sqlerrtext
		return false
	end if

Elseif ps_situacao = 'C' then //Solicita$$HEX2$$e700e300$$ENDHEX$$o de Cancelamento	
	
	idh_envio_canc = gf_getserverdate()
	
	Update nf_servico
	set nr_protocolo_cancelamento = :is_nr_protocolo_canc, 
		dh_envio_cancelamento = :idh_envio_canc,
		id_situacao = 'C'
	where id_nfse = :is_chave_nf_servico;
	
	if sqlca.sqlcode = -1 then
		ps_log = is_objeto + '; Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_nf_servico ; Problemas ao atualizar a tabela "nf_servico":  ' + sqlca.sqlerrtext
		return false
	end if

Elseif ps_situacao = 'X' then //NFSe Cancelada
	
	idh_retorno_canc = gf_getserverdate()
	
	Update nf_servico
	set id_situacao = 'X',
		dh_retorno_cancelamento = :idh_retorno_canc,
		dh_cancelamento = :idh_cancelamento
	where id_nfse = :is_chave_nf_servico;
	
	if sqlca.sqlcode = -1 then
		ps_log = is_objeto + '; Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_nf_servico ; Problemas ao atualizar a tabela "nf_servico":  ' + sqlca.sqlerrtext
		return false
	end if

Elseif ps_situacao = 'ER' then //Solicita$$HEX2$$e700e300$$ENDHEX$$o de envio rejeitado
	
	idh_retorno = gf_getserverdate()
	
	Update nf_servico
	set id_situacao = 'R',
		dh_retorno = :idh_retorno, 
		de_retorno = :is_mensagem_retorno,
		nr_protocolo = null
	where id_nfse = :is_chave_nf_servico;
	
	if sqlca.sqlcode = -1 then
		ps_log = is_objeto + '; Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_nf_servico ; Problemas ao atualizar a tabela "nf_servico":  ' + sqlca.sqlerrtext
		return false
	end if	
	
Elseif ps_situacao = 'CR' then //Solicita$$HEX2$$e700e300$$ENDHEX$$o de cancelamento rejeitado
	
	idh_retorno_canc = gf_getserverdate()
	
	Update nf_servico
	set id_situacao = 'R',
		dh_retorno_cancelamento = :idh_retorno_canc,
		nr_protocolo_cancelamento = null
	where id_nfse = :is_chave_nf_servico;
	
	if sqlca.sqlcode = -1 then
		ps_log = is_objeto + '; Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_nf_servico ; Problemas ao atualizar a tabela "nf_servico":  ' + sqlca.sqlerrtext
		return false
	end if
	
Elseif ps_situacao = 'D' then //Situa$$HEX2$$e700e300$$ENDHEX$$o DENEGADA
	
	idh_retorno = gf_getserverdate()
	
	Update nf_servico
	set dh_retorno = :idh_retorno, 
		id_situacao = :ps_situacao, 
		de_retorno = :is_status,
		cd_verificacao = :is_codigo_verificacao
	where id_nfse = :is_chave_nf_servico;
	
	if sqlca.sqlcode = -1 then
		ps_log = is_objeto + '; Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_nf_servico ; Problemas ao atualizar a tabela "nf_servico":  ' + sqlca.sqlerrtext
		return false
	end if
	
	
Elseif ps_situacao = 'E' then //Erro	
	
	ps_msg = left(ps_msg, 150)
	
	Update nf_servico
	set id_situacao = :ps_situacao, de_retorno = :ps_msg
	where id_nfse = :is_chave_nf_servico;
	
	if sqlca.sqlcode = -1 then
		ps_log = is_objeto + '; Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_nf_servico ; Problemas ao atualizar a tabela "nf_servico":  ' + sqlca.sqlerrtext
		return false
	end if
	
End if

return true
end function

public function boolean of_consulta_nfse (string ps_nr_protocolo, ref string ps_log);return this.of_consulta_nfse( ps_nr_protocolo, '', 0, false, ref ps_log)
end function

public function boolean of_consulta_nfse (string ps_nr_protocolo, string ps_id_chave_nf_servico, long pl_cd_filial, boolean pb_consulta_individual, ref string ps_log);string ls_retorno
string ls_erro
string ls_situacao

If pb_consulta_individual = True Then
	
	il_cd_filial = pl_cd_filial
	
	If Not this.of_carregar_parametros( ref ps_log, False) then return false
	
end if

//Realiza a consulta da NFS-e:
If Not this.of_comunicacao_api( 'GET', '', is_id_interface + '/' + ps_nr_protocolo, ref ls_retorno, ref ps_log ) then return false

if ps_log <> '' and not isnull(ps_log) Then
	ls_retorno = ps_log
	ps_log = ''
	If Not this.of_tratar_retorno( 'ERRO', ls_retorno, ref ps_log ) then return false
	
	if pb_consulta_individual Then
		ls_erro = ps_log
		//Altera a situa$$HEX2$$e700e300$$ENDHEX$$o para Erro:
		If Not this.of_atualiza_nf_servico( 'E', ls_erro, ref ps_log ) then 
			SQLCA.of_rollback( )
		else
			SQLCA.of_commit( )
		end if
	end if
	
	return false
end if		
		
If Not this.of_tratar_retorno( 'C', ls_retorno, ref ps_log ) then return false

if ( is_numero_nfse <> '' and is_numero_nfse <> '0' and not isnull(is_numero_nfse) ) or is_status = 'DENEGADO' or is_status = 'REJEITADO' then //Se a Nota foi Autorizada, DENEGADA ou REJEITADA altera a situa$$HEX2$$e700e300$$ENDHEX$$o no banco de dados:
	
	Choose Case is_status
		Case 'DENEGADO' 
			ls_situacao = 'D'
			is_mensagem_retorno = ''
		Case 'REJEITADO'
			ls_situacao = 'ER'
		Case else
			ls_situacao = 'A'
			is_mensagem_retorno = ''
	End Choose
	
	if ps_id_chave_nf_servico <> '' and not isnull(ps_id_chave_nf_servico) Then
		this.is_chave_nf_servico = ps_id_chave_nf_servico
	end if
	
	//Atualiza$$HEX2$$e700e300$$ENDHEX$$o situa$$HEX2$$e700e300$$ENDHEX$$o para Autorizada:
	If Not this.of_atualiza_nf_servico( ls_situacao, is_mensagem_retorno, ref ps_log ) then 
		if pb_consulta_individual = True then
			SQLCA.of_rollback( )
		end if
		return false
	end if
	
	if pb_consulta_individual = True then
		SQLCA.of_commit( )
	end if
Else
	
	If Not IsNull(is_status)  and trim(is_status) <> '' Then
		
		Update nf_servico
		set de_retorno = :is_status
		where id_nfse = :ps_id_chave_nf_servico
		Using SqlCa;
		
		if sqlca.sqlcode = -1 then
			ps_log = is_objeto + '; Fun$$HEX2$$e700e300$$ENDHEX$$o: of_consulta_nfse ; Problemas ao atualizar a tabela "nf_servico":  ' + sqlca.sqlerrtext
			return false
		end if
		
		if pb_consulta_individual = True then
			SQLCA.of_commit( )
		end if
		
	End If	
	
end if

return true
end function

public function boolean of_grava_nota_servico (boolean pb_insercao, ref string ps_log);string ls_nr_chave
long ll_nr_nf_servico, ll_nr_endereco
long ll_existe

//Primeiro faz o insert do registro na tabela:
if pb_insercao = True Then

	ls_nr_chave = string(il_cd_filial) + string(il_nr_nf_cupom) + is_de_especie + is_de_serie
	
	Select id_nfse, nr_protocolo
	into :is_chave_nf_servico, :is_nr_protocolo
	from nf_servico
	where id_nfse = :ls_nr_chave;
	
	if sqlca.sqlcode = -1 then
		ps_log =  is_objeto + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_nota_servico ~nErro: ' + sqlca.sqlerrtext
		return false
	end if
	
	//Se j$$HEX1$$e100$$ENDHEX$$ existe o registro na tabela passa direto pra emiss$$HEX1$$e300$$ENDHEX$$o da Nota
	if is_chave_nf_servico <> '' and not isnull(is_chave_nf_servico) Then
		return true
	end if

	insert into  nf_servico (id_nfse,   
										cd_filial,   
										nr_nf,   
										de_especie,   
										de_serie,  
										vl_total,   
										vl_bc_iss,   
										pc_aliquota_iss,   
										vl_iss,
										id_situacao,
										nr_matricula_operador,
										cd_cidade)
	values ( :ls_nr_chave,
			:il_cd_filial,
			:il_nr_nf_cupom,
			:is_de_especie,
			:is_de_serie,
			:idc_base_iss,
			:idc_base_iss,
			:idc_pc_aliquota_iss,
			:idc_vl_iss,
			'P',
			:is_matricula_operador,
			0);
	
	if sqlca.sqlcode = -1 then
		ps_log =  is_objeto + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_nota_servico ~Erro(1): ' + sqlca.sqlerrtext
		return false
	end if
	
	is_chave_nf_servico = ls_nr_chave		
				
else

	ll_nr_endereco = long(is_tomador_nr_endereco)
	
	idh_envio = gf_getserverdate()

	Update nf_servico
		Set	dh_envio = :idh_envio,   
				nr_matricula_operador = :is_matricula_operador,   
				nr_cpf_cgc = :is_tomador_cpf,
				nm_razao_social = :is_tomador_nome,
				nm_fantasia = :is_tomador_nome,
				nr_inscricao_municipal = :is_inscricao_municipal,
				nr_inscricao_estadual = :is_inscricao_estadual,
				de_endereco = :is_tomador_endereco,
				nr_endereco = :ll_nr_endereco,
				de_complemento = :is_tomador_complemento, 
				de_bairro = :is_tomador_bairro,
				nr_cep = :is_tomador_cep,
				cd_cidade = :il_tomador_cidade,  
				nr_ddd = :is_tomador_ddd,
				nr_telefone = :is_tomador_telefone, 
				de_email = :is_tomador_email,
				cd_servico = :is_cd_servico,
				de_servico = :is_de_servico,
				vl_total = :idc_base_iss,
				vl_bc_iss = :idc_base_iss, 
				pc_aliquota_iss = :idc_pc_aliquota_iss,
				vl_iss = :idc_vl_iss 
	where id_nfse = :is_chave_nf_servico;
  
	if sqlca.sqlcode = -1 then
		ps_log =  is_objeto + '; Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_nota_servico; Erro(2): ' + sqlca.sqlerrtext
		return false
	end if
	
end if

return true
end function

public function boolean of_imprimir_nfse (string ps_url_impressao, ref string ps_log);return this.of_imprimir_nfse( '', ps_url_impressao, ref ps_log)
end function

public function boolean of_imprimir_nfse (string ps_nr_protocolo, ref string ps_url_impressao, ref string ps_log);string ls_url

dc_uo_api luo_api

luo_api = create dc_uo_api

if Not this.of_verifica_base(ref ps_log ) then return false

if Not this.of_carregar_parametros( ref ps_log, True ) then return false

if ps_url_impressao = '' or isnull(ps_url_impressao) Then
	
	if is_token = '' or isnull(is_token) Then
		ps_log = 'N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel imprimir a NFSe. Informa$$HEX2$$e700e300$$ENDHEX$$o faltando: C$$HEX1$$f300$$ENDHEX$$digo Token'
		return false
	end if
	
	if ps_nr_protocolo = '' or isnull(ps_nr_protocolo) Then
		ps_log = 'N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel imprimir a NFSe. Informa$$HEX2$$e700e300$$ENDHEX$$o faltando: N$$HEX1$$fa00$$ENDHEX$$mero do Protocolo'
		return false
	end if
	
	is_url_impressao = gf_replace(is_url_impressao, '@TOKEN@', is_token,0)
	is_url_impressao = gf_replace(is_url_impressao, '@HASH@', ps_nr_protocolo,0)
else
	is_url_impressao = ps_url_impressao
end if

luo_api.of_Shell_Execute(is_url_impressao, '')

return true
end function

public function boolean of_carregar_parametros (ref string ps_log, boolean pb_impressao);string ls_id_emite_nfse
string ls_ambiente

if ib_base_matriz  Then
	
	If gvo_Aplicacao.ivs_DataSource = 'central'  Then 
		is_base_producao = 'S'
	Else
		is_base_producao = 'N'
	End If

	//Busca o par$$HEX1$$e200$$ENDHEX$$metro que habilita a gera$$HEX2$$e700e300$$ENDHEX$$o de NFSE para a filial.
	select vl_parametro
	into :ls_id_emite_nfse
	from parametro_geral
	where cd_parametro = 'ID_NFSE_EMITE' ;
	
	if sqlca.sqlcode = -1 then
		ps_log =  is_objeto + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_carregar_parametros ~nErro: ' + sqlca.sqlerrtext
		return false
	end if
		
	//Busca o Token necess$$HEX1$$e100$$ENDHEX$$rio para acessar o webservice.
	select vl_parametro
	into :is_token
	from parametro_geral
	where cd_parametro = 'ID_NFSE_TOKEN' ;
	
	if sqlca.sqlcode = -1 then
		ps_log =  is_objeto + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_carregar_parametros ~nErro: ' + sqlca.sqlerrtext
		return false
	end if
	
	//Busca o Endpoint (URL) necess$$HEX1$$e100$$ENDHEX$$rio para acessar o webservice.
	select vl_parametro
	into :is_url
	from parametro_geral
	where cd_parametro = 'ID_NFSE_ENDPOINT' ;
	
	if sqlca.sqlcode = -1 then
		ps_log =  is_objeto + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_carregar_parametros ~nErro: ' + sqlca.sqlerrtext
		return false
	end if

	//Busca o n$$HEX1$$fa00$$ENDHEX$$mero da inscri$$HEX2$$e700e300$$ENDHEX$$o municipal.
	select vl_parametro
	into :is_inscricao_municipal
	from parametro_geral
	where cd_parametro = 'NR_INSCRICAO_MUNICIPAL' ;
	
	if sqlca.sqlcode = -1 then
		ps_log =  is_objeto + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_carrega_dados_prestador ~nErro: ' + sqlca.sqlerrtext
		return false
	end if

Else
	
	//Verifica base produ$$HEX2$$e700e300$$ENDHEX$$o
	select coalesce(vl_parametro, 'N')
	into :is_base_producao
	from parametro_loja
	where cd_parametro = 'ID_BASE_PRODUCAO' ;
	
	if sqlca.sqlcode = -1 then
		ps_log =  is_objeto + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_carregar_parametros ~nErro: ' + sqlca.sqlerrtext
		return false
	end if
	
	If trim(is_base_producao) = '' Then is_base_producao = 'S'
		
	//Busca o par$$HEX1$$e200$$ENDHEX$$metro que habilita a gera$$HEX2$$e700e300$$ENDHEX$$o de NFSE para a filial.
	select vl_parametro
	into :ls_id_emite_nfse
	from parametro_loja
	where cd_parametro = 'ID_NFSE_EMITE' ;
	
	if sqlca.sqlcode = -1 then
		ps_log =  is_objeto + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_carregar_parametros ~nErro: ' + sqlca.sqlerrtext
		return false
	end if
		
	//Busca o Token necess$$HEX1$$e100$$ENDHEX$$rio para acessar o webservice.
	select vl_parametro
	into :is_token
	from parametro_loja
	where cd_parametro = 'ID_NFSE_TOKEN' ;
	
	if sqlca.sqlcode = -1 then
		ps_log =  is_objeto + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_carregar_parametros ~nErro: ' + sqlca.sqlerrtext
		return false
	end if
	
	//Busca o Endpoint (URL) necess$$HEX1$$e100$$ENDHEX$$rio para acessar o webservice.
	select vl_parametro
	into :is_url
	from parametro_loja
	where cd_parametro = 'ID_NFSE_ENDPOINT' ;
	
	if sqlca.sqlcode = -1 then
		ps_log =  is_objeto + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_carregar_parametros ~nErro: ' + sqlca.sqlerrtext
		return false
	end if
	
	//Busca o n$$HEX1$$fa00$$ENDHEX$$mero da inscri$$HEX2$$e700e300$$ENDHEX$$o municipal.
	select vl_parametro
	into :is_inscricao_municipal
	from parametro_loja
	where cd_parametro = 'NR_INSCRICAO_MUNICIPAL' ;
	
	if sqlca.sqlcode = -1 then
		ps_log =  is_objeto + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_carrega_dados_prestador ~nErro: ' + sqlca.sqlerrtext
		return false
	end if
	
End if

if ls_id_emite_nfse = '' or isnull(ls_id_emite_nfse) or ls_id_emite_nfse <> 'S' Then
	ps_log = 'A filial ' + string(il_cd_filial) + ' n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ habilitada para emiss$$HEX1$$e300$$ENDHEX$$o de Nfs-e.'
	return false
End if

if is_token = '' or isnull(is_token) Then
	ps_log = 'O par$$HEX1$$e200$$ENDHEX$$metro ID_NFSE_TOKEN n$$HEX1$$e300$$ENDHEX$$o foi localizado.'
	return false
End if

if is_url = '' or isnull(is_url) Then
	ps_log = 'O par$$HEX1$$e200$$ENDHEX$$metro ID_NFSE_ENDPOINT n$$HEX1$$e300$$ENDHEX$$o foi localizado.'
	return false
End if

If Not pb_impressao Then
	if is_inscricao_municipal = '' or isnull(is_inscricao_municipal) Then
		ps_log = 'O n$$HEX1$$fa00$$ENDHEX$$mero da inscri$$HEX2$$e700e300$$ENDHEX$$o municipal n$$HEX1$$e300$$ENDHEX$$o foi localizado.'
		return false
	end if
End If

// Valida ambiente da tecnospeed
If (is_base_producao = 'S' and is_url = 'https://api.sandbox.plugnotas.com.br') or (is_base_producao = 'N' and is_url <> 'https://api.sandbox.plugnotas.com.br') Then
	ps_log = 'Ambiente :' + iif(is_base_producao = 'S', 'PRODU$$HEX2$$c700c300$$ENDHEX$$O', 'HOMOLOGA$$HEX2$$c700c300$$ENDHEX$$O') +  '.~r~rA URL [' + is_url + '] da Tecnospeed esta inv$$HEX1$$e100$$ENDHEX$$lida para este ambiente.'
	return false
End If

Return true
end function

public function boolean of_cancelar_nfse_consulta (string ps_nr_protocolo, string ps_id_chave_nf_servico, long pl_cd_filial, ref string ps_log);string ls_retorno
string ls_erro
boolean lb_sucesso = false
	
il_cd_filial = pl_cd_filial

Try

	if is_token = '' or isnull(is_token) or is_url = '' or isnull(is_url) then
		If Not this.of_carregar_parametros( ref ps_log, False) then return false
	end if
			
	//Realiza a consulta da NFS-e:
	If Not this.of_comunicacao_api( 'GET', '', is_id_interface + '/cancelar/status/' + ps_nr_protocolo, ref ls_retorno, ref ps_log ) then return false
	
	if ps_log <> '' and not isnull(ps_log) Then
		ls_retorno = ps_log
		ps_log = ''
		If Not this.of_tratar_retorno( 'ERRO', ls_retorno, ref ps_log ) then return false
		return false
	end if		
			
	If Not this.of_tratar_retorno( 'X', ls_retorno, ref ps_log ) then return false
	
	if ps_id_chave_nf_servico <> '' and not isnull(ps_id_chave_nf_servico) Then
		this.is_chave_nf_servico = ps_id_chave_nf_servico
	end if
	
	//Atualiza o status da nota conforme o retorno:
	Choose Case is_status 
			
		Case 'CONCLUIDO' 
			
			//Atualiza$$HEX2$$e700e300$$ENDHEX$$o situa$$HEX2$$e700e300$$ENDHEX$$o para Cancelada:
			If Not this.of_atualiza_nf_servico( 'X', '', ref ps_log ) then return false
		
		Case 'REJEITADO'
			
			//Atualiza$$HEX2$$e700e300$$ENDHEX$$o situa$$HEX2$$e700e300$$ENDHEX$$o para Rejeitado:
			If Not this.of_atualiza_nf_servico( 'CR', '', ref ps_log ) then return false
		
		Case Else
		
	End Choose
	
	lb_sucesso = true
	
Finally
	
	If lb_sucesso = True Then
		SQLCA.of_commit( )
	else
		SQLCA.of_rollback( )	
		
		//Muda situa$$HEX2$$e700e300$$ENDHEX$$o para erro e grava Log:
		if is_chave_nf_servico <> '' and not isnull(is_chave_nf_servico) Then		
			ls_erro = ps_log
			If Not this.of_atualiza_nf_servico( 'E', ls_erro, ref ps_log ) then
				SQLCA.of_rollback( )
			else
				SQLCA.of_commit( )
			end if
		else
			//Se ainda n$$HEX1$$e300$$ENDHEX$$o existe registro na tabela, exibe mensagem de erro para o usu$$HEX1$$e100$$ENDHEX$$rio:
			if ib_exibe_msg Then
				Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', ps_log)
				ps_log = '-1'
			end if
		end if
		
	end if
	
End Try

return true
end function

public function datetime of_transforma_data (datetime pdt_data);string ls_data
datetime ldh_retorno

if ib_base_matriz Then
	//Sybase
	//TRansaforma pro hor$$HEX1$$e100$$ENDHEX$$rio de Brasilia ( GMT -3 )
	Select dateadd( HOUR, -3, :pdt_data )
	Into :ldh_retorno
	From parametro;
	
else
	//PostgreSql
	//TRansaforma pro hor$$HEX1$$e100$$ENDHEX$$rio de Brasilia ( GMT -3 )
	ls_data = String(pdt_data, 'dd/mm/yyyy hh:mm:ss')

	Select to_timestamp(:ls_data, 'dd/mm/yyyy hh24:mi:ss') - interval '3 hours'
	Into :ldh_retorno
	From parametro;

end if

return ldh_retorno
end function

public function boolean of_cancelar_nfse (long pl_cd_filial, string ps_nr_protocolo, string ps_id_nfse, boolean pb_exibe_msg, ref string ps_log);string ls_retorno
boolean lb_sucesso=false
string ls_erro
long ll_for

il_cd_filial = pl_cd_filial
	
Try	
	
	if ps_nr_protocolo = '' or isnull(ps_nr_protocolo) then
		ps_log = 'N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel cancelar a NFSe. Informa$$HEX2$$e700e300$$ENDHEX$$o faltando: N$$HEX1$$fa00$$ENDHEX$$mero do Protocolo'
		return false
	end if
		
	if is_token = '' or isnull(is_token) or is_url = '' or isnull(is_url) then
		If Not this.of_carregar_parametros( ref ps_log, False) then return false
	end if
	
	if ps_id_nfse <> '' and not isnull(ps_id_nfse) Then
		this.is_chave_nf_servico = ps_id_nfse
	end if
	
	//Solicita o cancelamento da nota:
	If Not this.of_comunicacao_api( 'POST', '', is_id_interface + '/cancelar/' + ps_nr_protocolo, ref ls_retorno, ref ps_log ) then return false
	
	if ps_log <> '' and not isnull(ps_log) Then
		ls_retorno = ps_log
		ps_log = ''
		If Not this.of_tratar_retorno( 'ERRO', ls_retorno, ref ps_log ) then return false
		return false
	end if
	
	If Not this.of_tratar_retorno( 'S', ls_retorno, ref ps_log ) then return false
	
	if is_nr_protocolo_canc <> '' and not isnull(is_nr_protocolo_canc) Then
		
		if Not this.of_atualiza_nf_servico( 'C', '',  ref ps_log ) then return false
		
		SQLCA.of_commit( )
		
		Sleep(5)
		
		For ll_for = 1 to 3
			
			if Not this.of_cancelar_nfse_consulta( is_nr_protocolo_canc, ps_id_nfse, pl_cd_filial, ref ps_log ) Then return false
			
			if is_status = 'CONCLUIDO' or is_status = 'REJEITADA' then EXIT
			
			if ll_for < 3 then
				sleep(5)
			end if
			
		Next
	
	end if
	
	lb_sucesso = true
Finally
	
	If lb_sucesso = True Then
		SQLCA.of_commit( )
	else
		SQLCA.of_rollback( )	
		
		//Muda situa$$HEX2$$e700e300$$ENDHEX$$o para erro e grava Log:
		if is_chave_nf_servico <> '' and not isnull(is_chave_nf_servico) Then		
			ls_erro = ps_log
			If Not this.of_atualiza_nf_servico( 'E', ls_erro, ref ps_log ) then
				SQLCA.of_rollback( )
			else
				SQLCA.of_commit( )
			end if
		else
			//Se ainda n$$HEX1$$e300$$ENDHEX$$o existe registro na tabela, exibe mensagem de erro para o usu$$HEX1$$e100$$ENDHEX$$rio:
			if pb_exibe_msg Then
				Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', ps_log)
				ps_log = '-1'
			end if
		end if
		
	end if
	
End Try

return true
end function

public function boolean of_imprimir_nfse (string ps_url_impressao);string ls_url

Try
	dc_uo_api luo_api
	
	luo_api = create dc_uo_api
	
	luo_api.of_Shell_Execute(ps_url_impressao, '')
	
Catch(RuntimeError lvo_Erro)
	MessageBox("Erro",lvo_Erro.GetMessage(), StopSign!)
	Return False
	
Finally
	If IsValid(luo_api) Then Destroy(luo_api)
End Try

Return True
end function

on uo_ge524_nfse.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge524_nfse.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;is_objeto = 'Objeto: ' + this.classname()

//Liberar loja nova:
//
//https://app.plugnotas.com.br/#/login
//Login: fernando.correa@clamed.com.br
//
//1 - cadastrar a empresa


//********************
//HOMOLOGACAO - INICIO
//********************

//**********************
// Configura$$HEX2$$e700f500$$ENDHEX$$es NFSe
// Dever$$HEX1$$e100$$ENDHEX$$ ser alterado no cadastro da empresa no https://app.plugnotas.com.br/ para o ambiente de HOMOLOGACAO
//**********************

//--PARA HOMOLOGAR
//1 - CRIA UM PEDIDO DROGAEXPRESS
//2 - COLOCAR O CD_FILIAL (CODIGO DA FILIAL ECOMMERCE) E O NR_PEDIDO_ECOMMERCE (FICTICIO)
//3 - LOCALIZA UM CUPOM CANCELADO
//4 - COLOCA O NR_PEDIDO_ECOMMERCE E O CD_FILIAL_ECOMMERCE
//5 - ALTERAR DW_GE524_CONSULTA_NFSE_LISTA PARA DEIXAR SELECIONR NOTA CANCELADA

//select nr_cpf_cheque, 
//			nm_cliente_entrega, 
//			de_endereco_entrega, 
//			nr_endereco_entrega, 
//			nr_cep_entrega, 
//			nm_cidade_entrega,
//			nr_telefone_entrega, 
//			de_endereco_email, 
//* from pedido_drogaexpress
//where dh_emissao >= '2021-04-28'
//;

//********************
//HOMOLOGACAO - TERMINO
//********************

end event

