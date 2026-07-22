HA$PBExportHeader$uo_ge501_preco.sru
forward
global type uo_ge501_preco from nonvisualobject
end type
end forward

global type uo_ge501_preco from nonvisualobject
end type
global uo_ge501_preco uo_ge501_preco

type variables
string is_objeto
string is_id_ecommerce = '2' //VTEX
string is_id_interface = '/api/pricing/prices'
string is_tabela = 'PRECO'
String is_rede_ecommerce
long il_cd_tipo = 4

decimal idc_preco_normal, idc_preco_liquido
uo_produto iuo_Produto
end variables

forward prototypes
private function boolean of_monta_json (ref string ps_json, ref string ps_log)
public function boolean of_valida_dados (long pl_cd_produto, string ps_cd_produto_ecommerce, string ps_cd_sku, ref string ps_log)
public function boolean of_processa_atualizacao_preco (string ps_rede_filial, long pl_produto)
end prototypes

private function boolean of_monta_json (ref string ps_json, ref string ps_log);
ps_json = '{ ' + &
	'"listPrice": ' + gf_valor_com_ponto(idc_preco_normal) + ', ' + &
	'"costPrice": ' + gf_valor_com_ponto(idc_preco_liquido) + ', ' + &
	'"basePrice": ' + gf_valor_com_ponto(idc_preco_liquido) + &
	'}'

return true
end function

public function boolean of_valida_dados (long pl_cd_produto, string ps_cd_produto_ecommerce, string ps_cd_sku, ref string ps_log);
if isnull(ps_cd_produto_ecommerce) or ps_cd_produto_ecommerce = '' Then
	ps_log = 'Produto [' + string(pl_cd_produto) + ']: Produto ainda n$$HEX1$$e300$$ENDHEX$$o cadastrado no Site.'
	return false
End if

if isnull(ps_cd_sku) or ps_cd_sku = '' Then
	ps_log = 'Produto [' + string(pl_cd_produto) + ']: SKU ainda n$$HEX1$$e300$$ENDHEX$$o cadastrado no Site.'
	return false
End if

return true

end function

public function boolean of_processa_atualizacao_preco (string ps_rede_filial, long pl_produto);long ll_linhas, ll_for
long ll_cd_produto
long ll_cd_filial
long ll_cd_filial_preco
long ll_seq_log
long ll_cd_categoria
long ll_count = 0

String ls_json
String ls_retorno
String ls_cd_produto_ecommerce
String ls_de_produto
String ls_cd_sku
String ls_Chave_Nula
String ls_MSG_Nula
String ls_Log
String ls_Situacao
String ls_id_registro_log
String ls_msg_email
String ls_niveis_categoria
String ls_de_departamento
String ls_de_categoria
String ls_de_subcategoria
String ls_uf_preco

decimal ldc_desconto_filial, ldc_desconto_clube, ldc_desconto_ecommerce, ldc_preco_normal_ant, ldc_preco_liquido_ant
boolean lb_sucesso=false, lb_enviar_email_alteracao=false
DateTime ldt_inicio
DateTime ldh_Data_Nula
DateTime ldh_log_inicio

s_email lst_email

dc_uo_ds_base lds_dados
uo_ge501_comum luo_comum_vtex

SetNull(ls_Chave_Nula)
SetNull(ls_MSG_Nula)
SetNull(ldh_Data_Nula)

try 
	ldh_log_inicio = gf_getserverdate()
	ls_situacao = 'P'
	
	Open(w_Aguarde)

	is_rede_ecommerce = ps_rede_filial

	luo_comum_vtex = create uo_ge501_comum

	iuo_produto = create uo_produto
	
	// Considera somente promo$$HEX2$$e700f500$$ENDHEX$$es liberadas para o e-commerce
	iuo_produto.is_somente_liberado_ecommerce = 'S'

	lds_dados = create dc_uo_ds_base
	
	if not lds_dados.of_changedataobject( 'ds_ge501_preco_log' ) Then
		ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualiza_preco ~n' + 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ds_ge501_preco_log'
		return false
	end if
	
	If gvo_Aplicacao.ivs_DataSource <> 'central' then
		ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_preco, a atualiza$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o pode ser a partir do HOMOLOGA.'
		return false
	End If
	
	//Carrega os parametros e busca o c$$HEX1$$f300$$ENDHEX$$digo da filial vinculado a rede.
	if Not luo_comum_vtex.of_parametros_ecommerce(is_id_ecommerce, ps_rede_filial, ref ll_cd_filial, ref ls_log ) Then return false

	setnull(ls_id_registro_log)
	luo_comum_vtex.of_grava_log_historico(ref ls_id_registro_log, ll_cd_filial, il_cd_tipo, ldh_log_inicio, ldh_Data_Nula, 'C', 0, ref ls_log )	

	ll_cd_filial_preco = luo_comum_vtex.il_cd_filial_preco
	
	Select cd_unidade_federacao
	into :ls_uf_preco
	from filial f inner join cidade c on c.cd_cidade = f.cd_cidade
	where f.cd_filial = :ll_cd_filial_preco;
	
	if sqlca.sqlcode = -1 then
		ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_preco; Erro ao consultar a tabela FILIAL: ' + sqlca.sqlerrtext
		return false
	End if
	
	if ps_rede_filial = 'FA' then
		if ls_uf_preco <> 'SP' Then
			ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_preco; UF [' + ls_uf_preco + '] diferente da esperada para a rede Farmagora [SP].'
			return false
		ENd if
	ENd if
	
	//Altera situacao para pendente
	If not luo_comum_vtex.of_altera_situacao_log_ecommerce( 'P', is_tabela, ll_cd_filial, '', ref ls_log ) Then return false
	
	If Not IsNull( pl_Produto ) and pl_produto > 0 Then
		lds_dados.of_AppendWhere("de_chave = '" + String( pl_Produto ) + "'" )
	End If
	
	ll_linhas = lds_dados.retrieve( is_id_ecommerce, ll_cd_filial, is_rede_ecommerce)
	
	if ll_linhas < 0 Then
		ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualiza_preco ~n' + 'Problemas ao consultar o banco de dados na seguinte datawindow: ds_ge501_preco_log'
		return false
	end if
	
	If ll_Linhas > 0 Then
		luo_comum_vtex.il_qt_item_enviado_site = ll_linhas
         // Grava in$$HEX1$$ed00$$ENDHEX$$cio do processo
		If Not luo_comum_vtex.of_grava_log(ll_cd_filial, il_cd_tipo, ls_Chave_Nula, 'C', ls_MSG_Nula, gf_getserverdate(), gf_getserverdate(), ref ls_Log, ref ll_Seq_Log ) Then Return False
	End If
	
	w_aguarde.uo_progress.of_setmax(ll_Linhas)
	
	ls_msg_email='<br>'
	
	for ll_for = 1 to ll_linhas
		
		w_Aguarde.Title = "Atualizando PRE$$HEX1$$c700$$ENDHEX$$O no eCommerce - [" + ps_rede_filial +  "] - "  + String(ll_for)  + " de " + STring(ll_Linhas)
		
		luo_comum_vtex.of_limpa_variaveis( )
		
		ldt_inicio = gf_getserverdate()
		
		ll_cd_produto = lds_dados.object.cd_produto[ll_for]
		ls_cd_produto_ecommerce = lds_dados.object.cd_produto_ecommerce[ll_for]
		ls_cd_sku = lds_dados.object.cd_sku[ll_for]
		ls_de_produto = lds_dados.object.de_descricao_internet[ll_for]
		ldc_preco_normal_ant = lds_dados.object.vl_preco[ll_for]
		ldc_preco_liquido_ant = lds_dados.object.vl_preco_promocao[ll_for]
		ll_cd_categoria = lds_dados.object.cd_categoria_ecommerce[ll_for]
		
		if isnull(ldc_preco_liquido_ant) then ldc_preco_liquido_ant = 0
		
		luo_comum_vtex.il_cd_produto = ll_cd_produto
		
		If Not this.of_valida_dados( ll_cd_produto, ls_cd_produto_ecommerce, ls_cd_sku, ref ls_log ) Then 
			//Grava log de erro.
			luo_comum_vtex.of_grava_log_item( ll_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
			ls_Situacao = 'E'
			ls_Log = ''
			continue
		end if
		
		iuo_Produto.of_Localiza_Codigo_Interno(ll_cd_Produto)
		
		If Not iuo_Produto.Localizado Then 
			ls_log = 'Produto n$$HEX1$$e300$$ENDHEX$$o encontrado na base de dados: ' + string(ll_cd_produto)
			luo_comum_vtex.of_grava_log_item( ll_cd_filial, ll_Seq_Log, ref ls_log, ls_log )
			ls_Situacao = 'E'
			ls_Log = ''
			Continue
		end if
		
		//Busca o pre$$HEX1$$e700$$ENDHEX$$o normal do produto.
		idc_preco_normal = iuo_produto.of_preco_venda_filial_matriz( ll_cd_filial_preco )
		
		//Busca o desconto
		ldc_desconto_filial = iuo_produto.of_desconto_filial( ll_cd_filial_preco )
		
		//Se for rede DC, verifica se tem desconto clube.
		if is_rede_ecommerce = 'DC' or is_rede_ecommerce = 'PP' Then
			ldc_desconto_clube = iuo_produto.of_desconto_clube_filial( ll_cd_filial_preco )
		else
			ldc_desconto_clube = 0
		end if
		
		//Verifica se possui desconto na filial ecommerce.
		ldc_desconto_ecommerce = iuo_produto.of_desconto_filial( ll_cd_filial, 'F')

		//Utiliza o maior desconto
		if ldc_desconto_clube > ldc_desconto_filial Then
			ldc_desconto_filial = ldc_desconto_clube
		end if
		
		if ldc_desconto_ecommerce > ldc_desconto_filial Then
			ldc_desconto_filial = ldc_desconto_ecommerce
		end if
		
		//Calcula o pre$$HEX1$$e700$$ENDHEX$$o l$$HEX1$$ed00$$ENDHEX$$quido.
		if ldc_desconto_filial > 0 Then
			idc_preco_liquido = Round( idc_preco_normal - ( idc_preco_normal * ( ldc_desconto_filial / 100 )), 2)
		else
			idc_preco_liquido = idc_preco_normal
		end if
		
		if not isnull(ldc_preco_liquido_ant) and ldc_preco_liquido_ant > 0 and idc_preco_liquido <> ldc_preco_liquido_ant Then
			lb_enviar_email_alteracao = True
			
			if Not gf_retorna_categoria_ecommerce( ll_cd_categoria, ref ls_niveis_categoria,  ref ls_de_departamento, ref ls_de_categoria, ref ls_de_subcategoria, ref ls_log )  then return false
			ll_count++
			ls_msg_email += string(ll_count) + ') <b>Produto:</b> '  + string(ll_Cd_produto) + ' - ' + ls_de_produto + ' [<b>Pre$$HEX1$$e700$$ENDHEX$$o anterior:</b> ' + string(ldc_preco_liquido_ant) + '] [<b>Pre$$HEX1$$e700$$ENDHEX$$o atual:</b> ' + string(idc_preco_liquido) + '] <br>' + ls_niveis_categoria + '<br><br>'
			
		End if
		
		Update ecommerce_prd
		set vl_preco = :idc_preco_normal, vl_preco_promocao = :idc_preco_liquido
		where id_ecommerce = :is_id_ecommerce
		and id_rede_filial = :is_rede_ecommerce
		and cd_produto = :ll_cd_produto;
		
		if sqlca.sqlcode = -1 then
			gf_ge501_RollBack(SQLCA)
			ls_log = 'Problemas ao atualizar a tabela ecommerce_prd: ' + sqlca.sqlerrtext
			luo_comum_vtex.of_grava_log_item( ll_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
			ls_Situacao = 'E'
			ls_Log = ''
			Continue
		end if
		
		luo_comum_vtex.idc_vl_preco = idc_preco_liquido
		luo_comum_vtex.idc_vl_preco_anterior = ldc_preco_liquido_ant
		luo_comum_vtex.idc_pc_desconto = ldc_desconto_filial
		
		//Monta o JSON de envio para o site.
		if Not this.of_monta_json( ref ls_json, ref ls_log) Then return false
		luo_comum_vtex.is_json = ls_json
		
		//Envia os dados de pre$$HEX1$$e700$$ENDHEX$$o para o site.
		luo_comum_vtex.of_put( ls_json, is_id_interface + '/' + ls_cd_sku , ref ls_retorno, ref ls_log ) 
		
		If ls_Log <> '' and not isnull(ls_Log) Then
			luo_comum_vtex.of_grava_log_item( ll_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
			ls_Situacao = 'E'
			ls_Log = ''
			Continue
		end if
		
		//Altera situacao para Processado
		If not luo_comum_vtex.of_altera_situacao_log_ecommerce( 'S', is_tabela, ll_cd_filial, String(ll_cd_produto), ref ls_log ) Then return false
		
		//sqlca.of_commit( )
		If Not gf_ge501_commit(SQLCA) Then Return False

		//Grava no log como processado com $$HEX1$$ea00$$ENDHEX$$xito.
		if Not luo_comum_vtex.of_grava_log_item(ll_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log ) Then Return false
		
		w_aguarde.uo_progress.of_setprogress(ll_for)
		
	next

	if lb_enviar_email_alteracao = True and ls_msg_email <> '' and not isnull(ls_msg_email) Then
		luo_comum_vtex.of_envia_email(290, 'PRE$$HEX1$$c700$$ENDHEX$$O - [' + ps_rede_filial + ']', ll_Seq_Log, ls_msg_email, string(ll_Seq_Log))
	End if

	lb_sucesso = True

Finally
	
	if Not lb_sucesso then 
		ls_Situacao = 'E'
		
		//sqlca.of_rollback( )
		gf_ge501_RollBack(SQLCA)
		
		// J$$HEX1$$e100$$ENDHEX$$ iniciou o envio dos itens
		If ll_for > 0 Then
			// Atualiza log com erro
			If Not luo_comum_vtex.of_atualiza_ecommerce_log(ll_cd_filial, ll_Seq_Log, 'E', ls_Log, gf_getserverdate(), ref ls_Log) Then Return False
			if Not luo_comum_vtex.of_grava_log_item(ll_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log) Then Return false
		Else
			// Se n$$HEX1$$e300$$ENDHEX$$o tiver log insere um novo com erro
			If IsNull(ll_Seq_Log) or ll_Seq_Log = 0 Then
				// Grava in$$HEX1$$ed00$$ENDHEX$$cio do processo - chave e mensagem est$$HEX1$$e300$$ENDHEX$$o indo como nulo
				If Not luo_comum_vtex.of_grava_log(ll_cd_filial, il_cd_tipo, ls_Chave_Nula, 'E', ls_Log, ldh_Data_Nula, gf_getserverdate(), ref ls_Log, ref ll_Seq_Log ) Then Return False
			Else
				// Atualiza log com erro
				If Not luo_comum_vtex.of_atualiza_ecommerce_log(ll_cd_filial, ll_Seq_Log, 'E', ls_Log, gf_getserverdate(), ref ls_Log) Then Return False
			End If		
		End If
	Else
		If ll_Linhas > 0 Then
			// Marca o log como processado
			If Not luo_comum_vtex.of_atualiza_ecommerce_log(ll_cd_filial, ll_Seq_Log, ls_Situacao, ls_MSG_Nula, gf_getserverdate(), ref ls_Log) Then Return False
		End If
	End If
	
	luo_comum_vtex.of_grava_log_historico(ref ls_id_registro_log, ll_cd_filial, il_cd_tipo, ldh_log_inicio, gf_getserverdate(), ls_situacao, ll_Seq_Log, ref ls_log )
	
	destroy(lds_dados)
	destroy(luo_comum_vtex)
	destroy(iuo_produto)
	
	Close(w_Aguarde)
End try

return true
end function

on uo_ge501_preco.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge501_preco.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;is_objeto = 'Objeto: ' + this.classname() + '~n'
end event

