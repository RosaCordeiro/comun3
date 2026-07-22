HA$PBExportHeader$uo_ge501_produto.sru
forward
global type uo_ge501_produto from nonvisualobject
end type
end forward

global type uo_ge501_produto from nonvisualobject
end type
global uo_ge501_produto uo_ge501_produto

type variables
string is_objeto
long il_cd_tipo = 2
string is_id_ecommerce = '2' //VTEX
string is_id_interface = 'api/catalog/pvt/product'
string is_id_interface_controlado = 'api/catalog_system/pvt/sku/associateattachments'
string is_id_interface_imagem = '/api/catalog_system/pvt/sku/stockkeepingunitbyid/'
string is_tabela = 'PRODUTO_GERAL'
String is_rede_ecommerce
String is_ds_internet, is_ds_principal_internet, is_ean, is_manipulado, is_tag_presc_medica
String is_de_tag_title, is_de_tag_description, is_de_principal_internet_nova
String is_termolabil
Long il_cd_marca, il_cd_categoria, il_cd_departamento
uo_produto iuo_Produto
end variables

forward prototypes
public function boolean of_valida_produto (long pl_cd_produto, ref string ps_log)
public function boolean of_busca_departamento (long pl_cd_categoria, ref long pl_cd_departamento, ref string ps_log)
public function boolean of_atualiza_produto_ecommerce (long pl_cd_produto, string ps_cd_produto_ecommerce, boolean pb_disponivel_site, boolean pb_existe, ref string ps_log)
public function boolean of_processa_atualizacao_produto (string ps_rede_filial, long pl_produto)
public function boolean of_verifica_liberado_ecommerce (date pdt_saldo, ref boolean pb_liberado, ref string ps_log)
public subroutine of_verifica_saldo_inativo ()
public function boolean of_loja_saldo_produto_inativo (date pdt_saldo, ref long pl_lojas, ref string ps_log)
public function boolean of_busca_grupo_psico_site (long pl_cd_produto, ref string ps_grupo_psico_site, ref string ps_log)
public function boolean of_atualiza_produto_controlado (long pl_cd_produto, string ps_cd_grupo_psico, ref string ps_log)
private function boolean of_monta_json (long pl_cd_produto, string ps_ds_internet, string ps_ds_principal, long pl_cd_marca, long pl_cd_departamento, long pl_cd_categoria, boolean pb_disponivel, ref string ps_json, ref string ps_log)
public function boolean of_atualiza_marca (ref string ps_log)
private function string of_formata_descricao (long pl_tipo, string ps_ds_descricao, long pl_produto)
public function boolean of_atualiza_prd_manipulado_inativar (ref string ps_log)
public function boolean of_verifica_tag_presc_medica (long pl_cd_produto, ref string ps_log)
public function boolean of_busca_nova_descricao_internet (long pl_cd_produto, ref string ps_de_principal_internet, ref string ps_log)
public function boolean of_processa_carga_imagem (string ps_rede_filial)
public function boolean of_valida_retorno_imagem (long pl_cd_produto, string ps_json, boolean pb_gerar_log, ref string ps_log)
end prototypes

public function boolean of_valida_produto (long pl_cd_produto, ref string ps_log);boolean lb_sucesso = true

// Produto Manipulado
If is_manipulado = 'S' Then Return True 

if isnull(il_cd_marca) or il_cd_marca <= 0 Then
//	il_cd_marca = 2410 //Marca Tempor$$HEX1$$e100$$ENDHEX$$ria
	ps_log += 'Falta marca.'
	lb_sucesso = false
end if

if is_ds_internet = '' or isnull(is_ds_internet) Then
	ps_log += 'Falta descri$$HEX2$$e700e300$$ENDHEX$$o internet.'
	lb_sucesso = false
end if

//if is_ds_principal_internet = '' or isnull(is_ds_principal_internet) Then
//	ps_log += 'O campo descri$$HEX2$$e700e300$$ENDHEX$$o principal internet n$$HEX1$$e300$$ENDHEX$$o pode ser nulo.'
//	lb_sucesso = false
//end if

//if il_cd_departamento = 0 or isnull(il_cd_departamento) Then
//	ps_log += 'Departamento n$$HEX1$$e300$$ENDHEX$$o encontrado.'
//	lb_sucesso = false
//end if

if il_cd_categoria = 0 or isnull(il_cd_categoria) Then
	ps_log += 'Falta categoria.'
	lb_sucesso = false
end if

if lb_sucesso = false Then
	return false
else
	return true
end if

end function

public function boolean of_busca_departamento (long pl_cd_categoria, ref long pl_cd_departamento, ref string ps_log);long ll_cd_categoria_pai, ll_cd_categoria

Select cd_categoria_pai, cd_categoria
into :ll_cd_categoria_pai, :ll_cd_categoria
from categoria_ecommerce
where cd_categoria = :pl_cd_categoria;

if sqlca.sqlcode = -1 then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_busca_departamento ~n' + 'Problemas ao consultar a tabela "categoria_ecommerce": ~n' + sqlca.sqlerrtext
	return false
end if

if ll_cd_categoria_pai = 0 Then
	//Se achou a categoria pai = 0 , o cd_categoria $$HEX1$$e900$$ENDHEX$$ o departamento.
	pl_cd_departamento = ll_cd_categoria
else
	//Entra em recursividade at$$HEX1$$e900$$ENDHEX$$ achar o cd_categoria_pai = 0
	if not this.of_busca_departamento( ll_cd_categoria_pai, ref pl_cd_departamento, ref ps_log ) Then return false
end if

return true
end function

public function boolean of_atualiza_produto_ecommerce (long pl_cd_produto, string ps_cd_produto_ecommerce, boolean pb_disponivel_site, boolean pb_existe, ref string ps_log);datetime ldt_data
string ls_id_disponivel

ldt_data = gf_getserverdate()

if pb_disponivel_site = True Then 
	ls_id_disponivel = 'S'
else
	ls_id_disponivel = 'N'
end if

if pb_existe = False Then
	
	If is_manipulado = 'S' Then
		
		// Manipulado fica com o c$$HEX1$$f300$$ENDHEX$$digo negativo
		pl_cd_produto = pl_cd_produto * -1
		
		Update ecommerce_prd
		set dh_atualizacao_prd = :ldt_data,  id_visivel_prd = :ls_id_disponivel, cd_produto_ecommerce = :ps_cd_produto_ecommerce, dh_inclusao_prd = :ldt_data
		where cd_produto = :pl_cd_produto
			and id_ecommerce = :is_id_ecommerce
			and id_rede_filial = :is_rede_ecommerce;
		
		if sqlca.sqlcode = -1 then
			ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_produto_ecommerce ~n' + 'Problemas ao atualizar registro na tabela "produto_central": ~n' + sqlca.sqlerrtext
			return false
		end if
		
	Else
		Insert into ecommerce_prd(id_ecommerce, id_rede_filial, cd_produto, cd_produto_ecommerce, dh_inclusao_prd, id_visivel_prd)
		values( :is_id_ecommerce, :is_rede_ecommerce, :pl_cd_produto, :ps_cd_produto_ecommerce, :ldt_data, :ls_id_disponivel);
	
		if sqlca.sqlcode = -1 then
			ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_produto_ecommerce ~n' + 'Problemas ao atualizar registro na tabela "produto_central": ~n' + sqlca.sqlerrtext
			return false
		end if
	End If

else
	
	If is_manipulado = 'S' Then
		// Manipulado fica com o c$$HEX1$$f300$$ENDHEX$$digo negativo
		pl_cd_produto = pl_cd_produto * -1
	End If

	Update ecommerce_prd
	set dh_atualizacao_prd = :ldt_data,  id_visivel_prd = :ls_id_disponivel
	where cd_produto = :pl_cd_produto
		and id_ecommerce = :is_id_ecommerce
		and id_rede_filial = :is_rede_ecommerce;
	
	if sqlca.sqlcode = -1 then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_produto_ecommerce ~n' + 'Problemas ao atualizar registro na tabela "produto_central": ~n' + sqlca.sqlerrtext
		return false
	end if

End if

return true
end function

public function boolean of_processa_atualizacao_produto (string ps_rede_filial, long pl_produto);long ll_linhas, ll_for
long ll_nr_atualizacao, ll_cd_produto, ll_cd_filial
long ll_seq_log
long ll_Lojas_Com_Saldo

String ls_json, ls_retorno, ls_cd_produto_ecommerce
String ls_Chave_Nula
String ls_MSG_Nula
String ls_Log
String ls_Situacao
String ls_Situacao_Log
String ls_id_registro_log
String ls_grupo_psico_site
String ls_json_controlado
string ls_tipo_controlado
string ls_cd_sku
String ls_Desc_Manip
String ls_Chave_Log

boolean lb_existe_movimento
boolean lb_sucesso=false
boolean lb_disponivel
boolean lb_envia_controlado=false
boolean lb_possui_imagem = false
boolean lb_produto_ativo = false

datetime ldt_inicio, ldh_Data_Nula
datetime ldh_log_inicio

Date ldt_saldo

dc_uo_ds_base lds_dados
uo_ge501_comum luo_comum_vtex

SetNull(ls_Chave_Nula)
SetNull(ls_MSG_Nula)
SetNull(ldh_Data_Nula)

try 
	Open(w_Aguarde)
	
	ldh_log_inicio = gf_getserverdate()
	ls_Situacao_Log = 'P'
	is_rede_ecommerce = ps_rede_filial
	
	luo_comum_vtex = create uo_ge501_comum
	
	iuo_produto = create uo_produto

	lds_dados = create dc_uo_ds_base
	
	if not lds_dados.of_changedataobject( 'ds_ge501_produto_log' ) Then
		ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_produto ~n' + 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ds_ge501_produto_log'
		return false
	end if
	
	If gvo_Aplicacao.ivs_DataSource <> 'central' then
		ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_produto, a atualiza$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o pode ser a partir do HOMOLOGA.'
		return false
	End If
	
	//Carrega os parametros e busca o c$$HEX1$$f300$$ENDHEX$$digo da filial vinculado a rede.
	if Not luo_comum_vtex.of_parametros_ecommerce(is_id_ecommerce, ps_rede_filial, ref ll_cd_filial, ref ls_log ) Then return false

	setnull(ls_id_registro_log)
	luo_comum_vtex.of_grava_log_historico(ref ls_id_registro_log, ll_cd_filial, il_cd_tipo, ldh_log_inicio, ldh_Data_Nula, 'C', 0, ref ls_log )	

	//Altera situacao para pendente
	If not luo_comum_vtex.of_altera_situacao_log_ecommerce( 'P', is_tabela, ll_cd_filial, '', ref ls_log ) Then return false
	
	If Not IsNull( pl_Produto ) and pl_produto > 0 Then
		lds_dados.of_AppendWhere("de_chave = '" + String( pl_Produto ) + "'" )
	End If
	
	ll_linhas = lds_dados.retrieve( is_id_ecommerce, ll_cd_filial, is_rede_ecommerce)
	
	if ll_linhas < 0 Then
		ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_produto ~n' + 'Problemas ao consultar o banco de dados na seguinte datawindow: ds_ge501_produto_log'
		return false
	end if
	
	If ll_Linhas > 0 Then
		luo_comum_vtex.il_qt_item_enviado_site = ll_linhas
         // Grava in$$HEX1$$ed00$$ENDHEX$$cio do processo
		If Not luo_comum_vtex.of_grava_log(ll_cd_filial, il_cd_tipo, ls_Chave_Nula, 'C', ls_MSG_Nula, gf_getserverdate(), gf_getserverdate(), ref ls_Log, ref ll_Seq_Log ) Then Return False
	End If
	
	ldt_saldo = gf_primeiro_dia_mes(date(gf_getserverdate() ) )
	
	w_aguarde.uo_progress.of_setmax(ll_Linhas)
	
	for ll_for = 1 to ll_linhas
		
		w_Aguarde.Title = "VTEX - [Produto] - [" + ps_rede_filial +  "] - "  + String(ll_for)  + " de " + STring(ll_Linhas)
		
		is_termolabil = 'N'
		is_tag_presc_medica = 'N'
		luo_comum_vtex.of_limpa_variaveis( )
		
		is_de_tag_title = ''
		is_de_tag_description = ''
		is_de_principal_internet_nova = ''
		
		ldt_inicio = gf_getserverdate()
		
		lb_disponivel = True
		
		ll_cd_produto 					= lds_dados.object.cd_produto[ll_for]
		ls_cd_produto_ecommerce 	= lds_dados.object.cd_produto_ecommerce[ll_for]
		il_cd_marca 					= lds_dados.object.cd_marca_ecommerce[ll_for]
		il_cd_categoria 				= lds_dados.object.cd_categoria_ecommerce[ll_for]
		ls_cd_sku						= lds_dados.object.cd_sku[ll_for]
		is_manipulado					= lds_dados.object.id_manipulado[ll_for]
		ls_Desc_Manip					= lds_dados.object.de_descricao_manip[ll_for]
		is_de_tag_title = lds_dados.object.de_tag_title[ll_for]
		is_de_tag_description = lds_dados.object.de_tag_description[ll_for]		
				
		If Trim(ls_cd_produto_ecommerce) = '' Then SetNull(ls_cd_produto_ecommerce)
		
		//26501, 48210)
		
		if Not this.of_busca_departamento( il_cd_categoria, ref il_cd_departamento, ref ls_log ) Then return false
		
		// Produto Manipulado (conforme requisi$$HEX1$$e700$$ENDHEX$$ao de compra do fcerta)
		If is_manipulado = 'S' Then
			ls_Chave_Log = 'OR' + String(ll_cd_produto)
			
			is_ds_internet 				= ls_Desc_Manip
			is_ds_Principal_internet 	= ''
			ls_Situacao					= 'A'
			is_ean 						= ''
		
		Else
			ls_Chave_Log = String(ll_cd_produto)
			
			iuo_Produto.of_Localiza_Codigo_Interno(ll_cd_Produto)
			
			If Not iuo_Produto.Localizado Then 
				w_aguarde.uo_progress.of_setprogress(ll_for)
				Continue
			End If
			
			is_ds_internet 				= iuo_Produto.de_descricao_internet
			is_ds_Principal_internet 	= iif(IsNull(iuo_Produto.de_principal_internet), '', iuo_Produto.de_principal_internet)
			ls_Situacao					= iuo_Produto.id_situacao
			is_ean = iuo_produto.de_codigo_barras
			
			is_ds_internet = trim(is_ds_internet)
			
			if left(iuo_produto.de_produto, 2) = 'ZZ' then
				is_termolabil = 'S'
			else
				is_termolabil = 'N'
			end if
			
		End If
		
		//VErifica se possui descricao exclusiva para a REDE.
		If Not this.of_busca_nova_descricao_internet( ll_cd_produto, ref is_de_principal_internet_nova, ref ls_log ) then return false
		
		If Not isnull(is_de_principal_internet_nova) and is_de_principal_internet_nova <> '' Then
			is_ds_principal_internet = is_de_principal_internet_nova
		End if
		
		if isnull(is_ean) then is_ean = ''
		
		luo_comum_vtex.il_cd_produto 		= ll_cd_produto
		luo_comum_vtex.il_cd_categoria 		= il_cd_categoria
		luo_comum_vtex.il_cd_departamento	= il_cd_departamento
		luo_comum_vtex.il_cd_marca			= il_cd_marca		
		
		// Produto Manipulado (conforme requisi$$HEX1$$e700$$ENDHEX$$ao de compra do fcerta)
		If is_manipulado = 'S' Then
		    lb_disponivel = True
		Else
			//Verifica Produto Liberado Ecommerce 
			if Not this.of_verifica_liberado_ecommerce(ldt_saldo, ref lb_disponivel, ref ls_log) Then Return False
		End If
		
		//Somente produtos ativos
		if isnull(ls_situacao) or ls_situacao <> 'A' Then
			If lb_disponivel Then
				// Verifica se possui estoque em alguma loja
				If Not of_loja_saldo_produto_inativo(ldt_saldo, ref ll_Lojas_Com_Saldo, ref ls_log) Then Return False
				
				If ll_Lojas_Com_Saldo = 0 Then
					lb_disponivel = False
				End If
			End If
		end if
		
		//or ( Mid(iuo_Produto.cd_subcategoria, 1, 1) ) = '4' &
		
		// Produto de dispensa$$HEX2$$e700e300$$ENDHEX$$o
		If is_manipulado = 'N' Then
			//N$$HEX1$$e300$$ENDHEX$$o pode ser produto de almoxarifado
			if   ( Mid(iuo_Produto.cd_subcategoria, 1, 1) ) = '5' &	
				or ( Mid(iuo_Produto.cd_subcategoria, 1, 1) ) = '6' Then
				lb_disponivel = false
			End if
		End If
				
		If Not this.of_valida_produto( ll_cd_produto, ref ls_log ) Then
			luo_comum_vtex.of_grava_log_item( ll_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
			ls_Situacao_Log = 'E'
			ls_Log = ''
			
//			// Se n$$HEX1$$e300$$ENDHEX$$o tiver cadastrado no site marca como processado
			If isnull(ls_cd_produto_ecommerce) Then
				If is_manipulado = 'N' Then 
					//Altera situacao para Processado
					If not luo_comum_vtex.of_altera_situacao_log_ecommerce( 'S', is_tabela, ll_cd_filial, String(ll_cd_produto), ref ls_log ) Then return false
					If Not gf_ge501_commit(SQLCA) Then Return False
				End If
			End If
			
			w_aguarde.uo_progress.of_setprogress(ll_for)
			Continue
		end if
		
		If Not this.of_verifica_tag_presc_medica( ll_Cd_produto, ref ls_log ) Then
			luo_comum_vtex.of_grava_log_item( ll_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
			ls_Situacao = 'E'
			w_aguarde.uo_progress.of_setprogress(ll_for)
			Continue
		end if
		
		//Se for um produto que j$$HEX1$$e100$$ENDHEX$$ foi exportado pro site , verifica a imagem cadastrada:
		if not isnull(ls_cd_produto_ecommerce) Then
			
			if not isnull(ls_cd_sku) and ls_cd_sku <> ''  Then
				//Verificar se a imagem j$$HEX1$$e100$$ENDHEX$$ foi cadastrada:
				luo_comum_vtex.of_get( is_id_interface_imagem + string(ls_cd_sku) , ref ls_retorno, ref ls_log )
				
				if ls_retorno = '' Then //Erro no retorno do webservice
					luo_comum_vtex.of_grava_log_item( ll_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
					ls_Situacao = 'E'
					w_aguarde.uo_progress.of_setprogress(ll_for)
					Continue
				end if
				
				ls_log = ''
				this.of_valida_retorno_imagem( ll_cd_produto, ls_retorno, true, ref ls_log)
				
				if ls_log <> '' and not isnull(ls_log) Then //Erro 
					gf_ge501_RollBack(SQLCA)
					luo_comum_vtex.of_grava_log_item( ll_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
					ls_Situacao = 'E'
					w_aguarde.uo_progress.of_setprogress(ll_for)
					Continue
				end if
				
				ls_retorno = ''
			end if
			
		end if
		
		if Not this.of_monta_json( ll_cd_produto, is_ds_internet, is_ds_principal_internet, il_cd_marca, il_cd_departamento, il_cd_categoria, lb_disponivel, ref ls_json, ref ls_log) Then return false
				
		if lb_disponivel = True Then
			luo_comum_vtex.is_id_visible = 'S'
		else
			luo_comum_vtex.is_id_visible = 'N'
		end if
		
		luo_comum_vtex.is_json = ls_json
		
		if not isnull(ls_cd_produto_ecommerce) Then //Produto j$$HEX1$$e100$$ENDHEX$$ foi exportado pra VTEX
		
			if not luo_comum_vtex.of_put( ls_json, is_id_interface + '/' + ls_cd_produto_ecommerce , ref ls_retorno, ref ls_log ) Then return false
			
			// For$$HEX1$$e700$$ENDHEX$$a envio da marca
			If ls_Log = '{"Message":"Brand not found"}' Then
				If Not This.of_atualiza_marca(ref ls_log) Then Return False
			End If
			
			//Se retornou erro apenas na interface da VTEX, grava log e passa para o proximo registro.
			If ls_Log <> '' and not isnull(ls_Log) Then
				luo_comum_vtex.of_grava_log_item( ll_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
				ls_Situacao_Log = 'E'
				ls_Log = ''
				
				w_aguarde.uo_progress.of_setprogress(ll_for)
				Continue
			end if
				
			//Chama fun$$HEX2$$e700e300$$ENDHEX$$o para gravar no sybase as atualiza$$HEX2$$e700f500$$ENDHEX$$es do produto na VTEX.
			if not this.of_atualiza_produto_ecommerce( ll_cd_produto, ls_retorno,  lb_disponivel, TRUE, ref ls_log ) Then Return false
				
		else //Produto ainda n$$HEX1$$e300$$ENDHEX$$o foi exportado pra VTEX
			
			//Se situacao $$HEX1$$e900$$ENDHEX$$ indisponivel n$$HEX1$$e300$$ENDHEX$$o manda para o site e coloca como processado.
			if lb_disponivel = false Then
				//Altera situacao para Processado
				If not luo_comum_vtex.of_altera_situacao_log_ecommerce( 'S', is_tabela, ll_cd_filial, ls_Chave_Log, ref ls_log ) Then return false
			
				//sqlca.of_commit( )
				If Not gf_ge501_commit(SQLCA) Then Return False
				
				if Not luo_comum_vtex.of_grava_log_item(ll_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log ) Then Return false
				
				w_aguarde.uo_progress.of_setprogress(ll_for)
				Continue
			else
				
				if not luo_comum_vtex.of_post( ls_json, is_id_interface, ref ls_retorno, ref ls_log ) Then return false
				
				// For$$HEX1$$e700$$ENDHEX$$a envio da marca
				If ls_Log = '{"Message":"Brand not found"}' Then
					If Not This.of_atualiza_marca(ref ls_log) Then Return False
				End If
				
				If ls_Log <> '' and not isnull(ls_Log) Then
					luo_comum_vtex.of_grava_log_item( ll_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
					ls_Situacao_Log = 'E'
					ls_Log = ''
					
					w_aguarde.uo_progress.of_setprogress(ll_for)
					Continue
				else
					
					ls_cd_produto_ecommerce = ls_retorno
					
					//Chama fun$$HEX2$$e700e300$$ENDHEX$$o para gravar no sybase o c$$HEX1$$f300$$ENDHEX$$digo do produto criado na VTEX.
					if not this.of_atualiza_produto_ecommerce( ll_cd_produto, ls_cd_produto_ecommerce,  lb_disponivel, FALSE, ref ls_log ) Then Return false
					
				end if
				
			end if
		
		end if	
		
		
		If is_manipulado = 'N' Then
		
			//Tratamento para produtos Controlados
			if Not this.of_busca_grupo_psico_site( ll_cd_produto, ref ls_grupo_psico_site, ref ls_log ) then return false
			
			ls_tipo_controlado = ''
			
			//Se o produto n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ mais controlado, mas no site ainda est$$HEX1$$e100$$ENDHEX$$ como controlado:
			if ( isnull(iuo_Produto.cd_grupo_psico) or iuo_Produto.cd_grupo_psico = '' ) and not isnull(ls_grupo_psico_site) and ls_grupo_psico_site <> '' Then
				 lb_envia_controlado = True
				 ls_tipo_controlado = ''
			//Se o produto $$HEX1$$e900$$ENDHEX$$ controlado mas no site n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ como controlado ou est$$HEX1$$e100$$ENDHEX$$ com configura$$HEX2$$e700e300$$ENDHEX$$o diferente da atual:
			elseif Not isnull( iuo_Produto.cd_grupo_psico ) and iuo_Produto.cd_grupo_psico <> '' and ls_cd_sku <> '' and not isnull(ls_cd_sku) Then
				
				if isnull(ls_grupo_psico_site) or ls_grupo_psico_site = '' or ls_grupo_psico_site <> iuo_Produto.cd_grupo_psico Then
				
					lb_envia_controlado = True
				
					if  iuo_Produto.cd_grupo_psico = 'W' Then
						//Antibiotico
						ls_tipo_controlado = 'Receita Antibiotico'
					elseif  iuo_Produto.cd_grupo_psico <> 'W' Then
						//Psicotropico
						ls_tipo_controlado = 'Receita psicotropico'
					end if
					
				end if
				
			end if
			
			if lb_envia_controlado = True Then
				
				lb_envia_controlado = false
				
				if ls_tipo_controlado = '' Then
					ls_json_controlado = '{"SkuId": ' + ls_cd_sku + ', "AttachmentNames":[] }'
				else
					ls_json_controlado = '{"SkuId": ' + ls_cd_sku + ', "AttachmentNames":["' + ls_tipo_controlado + '"] }'
				end if
					
				ls_retorno = ''
				if not luo_comum_vtex.of_post( ls_json_controlado, is_id_interface_controlado, ref ls_retorno, ref ls_log ) Then return false
				
				If ls_Log <> '' and not isnull(ls_Log) Then
					luo_comum_vtex.of_grava_log_item( ll_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
					ls_Situacao_Log = 'E'
					ls_Log = ''
					
					w_aguarde.uo_progress.of_setprogress(ll_for)
					Continue
				end if
				
				if Not this.of_atualiza_produto_controlado( ll_cd_produto, iuo_Produto.cd_grupo_psico, ref ls_log ) Then return false
					
			End if
		End If //is_manipulado
		
		//Altera situacao para Processado
		If not luo_comum_vtex.of_altera_situacao_log_ecommerce( 'S', is_tabela, ll_cd_filial, ls_Chave_Log, ref ls_log ) Then return false
		
		//sqlca.of_commit( )
		If Not gf_ge501_commit(SQLCA) Then Return False
		
		//Grava no log como processado com $$HEX1$$ea00$$ENDHEX$$xito.
		if Not luo_comum_vtex.of_grava_log_item(ll_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log ) Then Return false
		
		w_aguarde.uo_progress.of_setprogress(ll_for)
	next

	if this.is_rede_ecommerce= 'DC' Then
		//Inativar os produtos manipulados que j$$HEX1$$e100$$ENDHEX$$ foram utilizados.
		If this.of_atualiza_prd_manipulado_inativar( ref ls_log ) Then
			If Not gf_ge501_commit(SQLCA) Then Return False
		else
			gf_ge501_RollBack(SQLCA)
			luo_comum_vtex.of_grava_log_item( ll_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
			ls_Situacao = 'E'
		End If

	ENd if

	lb_sucesso = True
	
Finally
	
	if Not lb_sucesso then
		
		ls_Situacao_Log = 'E'
		
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
			If Not luo_comum_vtex.of_atualiza_ecommerce_log(ll_cd_filial, ll_Seq_Log, ls_Situacao_Log, ls_MSG_Nula, gf_getserverdate(), ref ls_Log) Then Return False
		End If
	End If
	
	luo_comum_vtex.of_grava_log_historico(ref ls_id_registro_log, ll_cd_filial, il_cd_tipo, ldh_log_inicio, gf_getserverdate(), ls_Situacao_Log, ll_Seq_Log, ref ls_log )
	
	destroy(lds_dados)
	destroy(luo_comum_vtex)
	destroy(iuo_Produto)
	
	Close(w_Aguarde)
	
End try

return true
end function

public function boolean of_verifica_liberado_ecommerce (date pdt_saldo, ref boolean pb_liberado, ref string ps_log);Long ll_Lojas

//Verifica Produto Liberado Ecommerce
Choose Case is_rede_ecommerce
	Case 'FA'
		if isnull(iuo_Produto.id_liberado_ecommerce) or iuo_Produto.id_liberado_ecommerce <> 'S' Then
			pb_liberado = false
		End if
	Case 'DC'
		if isnull(iuo_Produto.id_liberado_ecommerce_DC) or iuo_Produto.id_liberado_ecommerce_DC <> 'S' Then
			pb_liberado = false
		End if
	Case 'MP'
		if isnull(iuo_Produto.id_liberado_ecommerce_MP) or iuo_Produto.id_liberado_ecommerce_MP <> 'S' Then
			pb_liberado = false
		End if
	Case 'PP'
		if isnull(iuo_Produto.id_liberado_ecommerce_PP) or iuo_Produto.id_liberado_ecommerce_PP <> 'S' Then
			pb_liberado = false
		End if	
End Choose

Return True
end function

public subroutine of_verifica_saldo_inativo ();
end subroutine

public function boolean of_loja_saldo_produto_inativo (date pdt_saldo, ref long pl_lojas, ref string ps_log);Select count(*) 
Into :pl_lojas
from saldo_produto s
where s.dh_saldo = :pdt_saldo
  and s.cd_produto = :iuo_Produto.cd_produto
  and s.cd_filial in (	select cd_filial 
								from filial 
								where id_rede_filial = :is_rede_ecommerce
								  and id_situacao 	= 'A' 
								  and cd_filial not in (1,2,534)
							)
  and s.qt_saldo_final > 0
  Using Sqlca;
  
  if sqlca.sqlcode = -1 then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_verifica_liberado_ecommerce ~n' + 'Problemas ao consultar a tabela "saldo_produto": ~n' + sqlca.sqlerrtext
	return false
 end if
 
 Return True
	  

end function

public function boolean of_busca_grupo_psico_site (long pl_cd_produto, ref string ps_grupo_psico_site, ref string ps_log);string ls_grupo

Select cd_grupo_psico_site
into :ls_grupo
from ecommerce_prd
where id_ecommerce = :is_id_ecommerce
and id_rede_filial = :is_rede_ecommerce
and cd_produto = :pl_cd_produto;

if sqlca.sqlcode = -1 then
	ps_log = is_objeto + '; Fun$$HEX2$$e700e300$$ENDHEX$$o: of_busca_grupo_psico_site; Problemas ao consultar a tabela "ecommerce_prd": ' + sqlca.sqlerrtext
	return false
end if

ps_grupo_psico_site = ls_grupo

return true
end function

public function boolean of_atualiza_produto_controlado (long pl_cd_produto, string ps_cd_grupo_psico, ref string ps_log);
Update ecommerce_prd 
set cd_grupo_psico_site = :ps_cd_grupo_psico
where id_ecommerce = :is_id_ecommerce
and id_rede_filial = :is_rede_ecommerce
and cd_produto = :pl_cd_produto;

if sqlca.sqlcode= -1 then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_produto_controlado; Problema ao atualizar a tabela "ecommerce_prd": ' + sqlca.sqlerrtext
	return false
end if

return true
end function

private function boolean of_monta_json (long pl_cd_produto, string ps_ds_internet, string ps_ds_principal, long pl_cd_marca, long pl_cd_departamento, long pl_cd_categoria, boolean pb_disponivel, ref string ps_json, ref string ps_log);datetime ldt_data
string ls_visible, ls_data, ls_ativo, ls_title, ls_description, ls_description_meta
string ls_RefID
String ls_KeyWords

if pb_disponivel = True Then
	ls_visible	= '"IsVisible": true, '
	ls_Ativo 	=  '"IsActive": true, '
else
	ls_visible = '"IsVisible": false, '
	ls_Ativo 	=  '"IsActive": false, '
end if

ldt_data = gf_getserverdate()

ls_data = String( ldt_data, 'yyyy-mm-dd hh:mm:ss')

If IsNull(ps_ds_principal) Then ps_ds_principal =  ''
If IsNull(ps_ds_internet) Then ps_ds_internet =  ''

if isnull(is_de_tag_title) then is_de_tag_title = ''
if isnull(is_de_tag_description) then is_de_tag_description = ''
if isnull(is_de_principal_internet_nova) then is_de_principal_internet_nova = ''

If trim(ps_ds_principal) <> '' Then ps_ds_principal += '<br /><br />'

if is_termolabil = 'S' then
	
	ps_ds_principal = "<div style='border: 2px solid #ff7136; padding: 10px; border-radius: 10px; text-align: center;'><span style='font-size: small;'><span><span><b>PRODUTO EXCLUSIVO PARA RETIRADA EM LOJA</b></span></span></span></div></div>" + ps_ds_principal
	
end if

If is_Manipulado = 'N' Then
	ls_RefID        = string(pl_cd_produto)
	ls_KeyWords = string(pl_cd_produto) + ', ' + is_ean
	
	If Mid(iuo_Produto.cd_subcategoria, 1, 1) = '1' and iuo_Produto.id_lei_generico = 'G' Then
		// MIP
		If Mid(iuo_Produto.cd_subcategoria, 1, 3) = '104' Then
			ps_ds_principal += "<div style='border: 1px solid #000000; padding: 10px; border-radius: 10px;  text-align: center;'><span style='font-size: small;'><span><span>MEDICAMENTO GEN$$HEX1$$c900$$ENDHEX$$RICO - LEI N.$$HEX1$$ba00$$ENDHEX$$ 9.787/99.</span></span></span></div></div>"
		Else
			ps_ds_principal += "<div style='border: 1px solid #000000; padding: 10px; border-radius: 10px;  text-align: center;'><span style='font-size: small;'><span><span>VENDA SOB PRESCRI$$HEX2$$c700c300$$ENDHEX$$O M$$HEX1$$c900$$ENDHEX$$DICA. MEDICAMENTO GEN$$HEX1$$c900$$ENDHEX$$RICO - LEI N.$$HEX1$$ba00$$ENDHEX$$ 9.787/99.</span></span></span></div></div>"
		End If
	elseif is_tag_presc_medica = 'S' Then
		ps_ds_principal += "<div style='border: 1px solid #000000; padding: 10px; border-radius: 10px; text-align: center;'><span style='font-size: small;'><span><span>VENDA SOB PRESCRI$$HEX2$$c700c300$$ENDHEX$$O M$$HEX1$$c900$$ENDHEX$$DICA.</span></span></span></div></div>"
	End If
Else
	ps_ds_principal += "<div style='border: 1px solid #000000; padding: 10px; border-radius: 10px;  text-align: center;'><span style='font-size: small;'><span><span>Produto sob encomenda. Produto para or$$HEX1$$e700$$ENDHEX$$amento (com ou sem receita) . Imagem meramente ilustrativa. Somente ap$$HEX1$$f300$$ENDHEX$$s a confirma$$HEX2$$e700e300$$ENDHEX$$o de pagamento seu produto ser$$HEX1$$e100$$ENDHEX$$ produzido (ou colocado em produ$$HEX2$$e700e300$$ENDHEX$$o). O prazo de entrega depende de vari$$HEX1$$e100$$ENDHEX$$veis como localidade, tipo de frete e tempo de produ$$HEX2$$e700e300$$ENDHEX$$o do produto solicitado. Este produto ser$$HEX1$$e100$$ENDHEX$$ feito especialmente para voc$$HEX1$$ea00$$ENDHEX$$ e para atender suas necessidades individuais, portanto arrependimento de compra somente ser$$HEX1$$e100$$ENDHEX$$ aceito antes do produto ser produzido e devolu$$HEX2$$e700f500$$ENDHEX$$es apenas se o produto estiver danificado ou apresentar desvio de qualidade, que neste caso ser$$HEX1$$e100$$ENDHEX$$ primeiramente avaliado pela nossa equipe t$$HEX1$$e900$$ENDHEX$$cnica (farmac$$HEX1$$ea00$$ENDHEX$$uticos).</span></span></span></div></div>"
	
	ls_RefID 			= 'OR' + string(pl_cd_produto)
	ls_KeyWords 	= ls_RefID
End If

if is_de_tag_title <> '' and not isnull(is_de_tag_title) then
	ls_title = this.of_formata_descricao(1,is_de_tag_title, pl_cd_produto)
Else
	ls_title = this.of_formata_descricao(1,ps_ds_internet, pl_cd_produto)
End if

ls_description = this.of_formata_descricao(0,ps_ds_principal, pl_cd_produto)

if is_de_tag_description <> '' and not isnull(is_de_tag_description) then
	ls_description_meta = this.of_formata_descricao(0,is_de_tag_description, pl_cd_produto)
Else
	ls_description_meta = ''
End if

ps_json = '{ ' + &
	'"Name": "' + this.of_formata_descricao(1, ps_ds_internet, pl_cd_produto) + '", ' + & 
	'"DepartmentId": ' + string(pl_cd_departamento) + ', ' + &
	'"CategoryId": ' + string(pl_cd_categoria) + ', ' + &
	'"BrandId": ' + string(pl_cd_marca) + ', ' + &
	'"LinkId": "' + gf_retira_acentos(this.of_formata_descricao(2,ps_ds_internet, pl_cd_produto)) + '", ' + &
	'"RefId": "' + ls_RefID + '", ' + &	
	ls_visible + &
	'"Description": "' +  ls_description + '", ' + &
	'"DescriptionShort": "", ' + &
	'"ReleaseDate": "' + ls_data + '", ' + &
	'"KeyWords": "' + ls_KeyWords + '", ' + &
	'"Title": "' + ls_title + '", ' +&
	ls_Ativo + &
	'"TaxCode": "", ' + &
	'"MetaTagDescription": "' + ls_description_meta + '", ' + &
	'"SupplierId": 1, ' + &
	'"ShowWithoutStock": true, ' + &
	'"AdWordsRemarketingCode": null, ' + &
	'"LomadeeCampaignCode": null, ' + &
	'"Score": 1 ' + &
	'}'

return true
end function

public function boolean of_atualiza_marca (ref string ps_log);//Abre uma nova transa$$HEX2$$e700e300$$ENDHEX$$o com o banco para gravar o registro.
dc_uo_transacao lo_SqlCa

try
	lo_SqlCa = create dc_uo_transacao
	lo_SqlCa.ivs_database = "SYBASE"
	
	If Not lo_SqlCa.of_Connect(gvo_Aplicacao.ivs_DataSource, 'GE501 - Interface VTEX') Then
		ps_log =  'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_marca ~n' + "Erro ao conectar no Sybase."
		Return False
	end if
	
	update marca_ecommerce
	set de_marca = de_marca
	where cd_marca = :il_cd_marca
	Using lo_SqlCa;
	
	if lo_SqlCa.sqlcode= -1 then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_marca": ' + lo_SqlCa.sqlerrtext
		return false
	end if
	
	lo_SqlCa.of_Commit();
finally
	Destroy lo_SqlCa
end try

return true
end function

private function string of_formata_descricao (long pl_tipo, string ps_ds_descricao, long pl_produto);string ls_resultado

//Trata as aspas
ps_ds_descricao = gf_replace(ps_ds_descricao,'"','&quot;',0)

Choose Case pl_tipo
	Case 1
		ls_resultado = wordcap(ps_ds_descricao)
		
		If is_manipulado = 'S' Then
			ls_resultado =  "(OR" + String(pl_produto) + ") " + ls_resultado
		End If

	Case 2
		ls_resultado = wordcap(ps_ds_descricao)
		
		If is_manipulado = 'S' Then
			ls_resultado =  "(OR" + String(pl_produto) + ") " + ls_resultado
		End If
		
		ls_resultado = gf_replace(ls_resultado, ' ', '-', 0)
	Case 3
		ls_resultado = lower(ps_ds_descricao)
	Case Else
		ls_resultado = ps_ds_descricao
End Choose

return ls_resultado
end function

public function boolean of_atualiza_prd_manipulado_inativar (ref string ps_log);Long ll_Linha
Long ll_Linhas
Long ll_Produto
Long ll_Req_Manip

String ls_SKu
String ls_Prd_Eco
STring ls_Descricao
String ls_Json
String ls_retorno

Long ll_cd_filial

//Inativar na VTEX os produtos manipulados que j$$HEX1$$e100$$ENDHEX$$ foram vendidos.

try
	
	is_Manipulado = 'S'
	
	dc_uo_ds_base	lds 
	lds = Create dc_uo_ds_base
	
	uo_ge501_comum luo_comum_vtex
	luo_comum_vtex = create uo_ge501_comum
	
	If IsValid(w_aguarde) Then
		w_aguarde.title = 'Atual. PRD Manipulado [INATIVAR]'
	End If
	
	if not lds.of_changedataobject( 'ds_ge501_produto_manipulado_inativar', False ) Then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_produto_manipulado_inativar ~n' + 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ds_ge501_produto_manipulado_inativar'
		return false
	end if
	
	//Carrega os parametros e busca o c$$HEX1$$f300$$ENDHEX$$digo da filial vinculado a rede.
	if Not luo_comum_vtex.of_parametros_ecommerce(is_id_ecommerce, is_rede_ecommerce, ref ll_cd_filial, ref ps_log ) Then return false
	
	ll_Linhas = lds.Retrieve(is_id_ecommerce, is_rede_ecommerce )
	
	If ll_Linhas > 0 Then
		
		
		If IsValid(w_aguarde) Then 
			w_aguarde.uo_progress.of_reset()
			w_aguarde.uo_progress.of_setmax(ll_Linhas)
		end if
		
		For ll_Linha = 1 To ll_Linhas
			
			ls_Prd_Eco					= lds.Object.cd_produto_ecommerce		[ll_Linha]
			
			ll_Produto					= lds.Object.cd_produto						[ll_Linha] // Mesmo c$$HEX1$$f300$$ENDHEX$$diog da req s$$HEX1$$f300$$ENDHEX$$ que com valor negativo
			ll_Req_Manip				= lds.Object.nr_requisicao_manip			[ll_Linha]
			ls_Descricao				= lds.Object.de_descricao_manip			[ll_Linha]
			il_cd_marca 				= lds.object.cd_marca_manip				[ll_Linha]
			il_cd_categoria 			= lds.object.cd_categoria_manip			[ll_Linha]
		
			if Not this.of_busca_departamento( il_cd_categoria, ref il_cd_departamento, ref ps_log ) Then return false
		
			if Not this.of_monta_json( ll_Produto, ls_descricao, '', il_cd_marca, il_cd_departamento, il_cd_categoria, false, ref ls_json, ref ps_log ) then return false
			
			if not luo_comum_vtex.of_put( ls_json, is_id_interface + '/' + ls_Prd_Eco , ref ls_retorno, ref ps_log ) Then return false
					
			If ps_log <> '' and not isnull(ps_log) Then Return False

			Update ecommerce_prd
			Set id_visivel_prd = 'N'
			Where id_ecommerce 	= :is_id_ecommerce
				and id_rede_filial 		= :is_rede_ecommerce
				and cd_produto			= :ll_Produto
			Using SqlCa;
			
			if sqlca.sqlcode = -1 then
				ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_prd_manipulado_inativar ~n' + 'Problemas ao atualizar registro na tabela "ecommerce_prd": ~n' + sqlca.sqlerrtext
				return false
			end if		
			
			If IsValid(w_aguarde) Then
				w_aguarde.uo_progress.of_setprogress(ll_linha)
			end if
		Next	
	
	ElseIf ll_Linhas  < 0 Then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_prd_manipulado_inativar ~n' + 'Erro ao recuperar os dados da ds_ge501_produto_manipulado_inativar'
		return false
	End If
	
	If IsValid(w_aguarde) Then
		w_aguarde.title = ""
	End If
	
finally
	Destroy lds
	Destroy luo_comum_vtex
end try

Return True
end function

public function boolean of_verifica_tag_presc_medica (long pl_cd_produto, ref string ps_log);long ll_existe

select count(*)
into :ll_existe
from produto_geral g
	inner join vw_classificacao_produto v
	on v.cd_subcategoria = g.cd_subcategoria
where v.cd_subgrupo = '102'
	and cd_tipo_prescricao = 5
	and g.id_situacao = 'A'
	and id_lei_generico <> 'G'
	and g.cd_grupo_psico is null
	and g.cd_produto = :pl_cd_produto;

if sqlca.sqlcode = -1 then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_verifica_tag_presc_medica; Problemas ao consultar a tabela "produto_geral": ' + sqlca.sqlerrtext
	return false
end if

if ll_existe > 0 Then
	is_tag_presc_medica = 'S'
else
	is_tag_presc_medica = 'N'
end if

return true
end function

public function boolean of_busca_nova_descricao_internet (long pl_cd_produto, ref string ps_de_principal_internet, ref string ps_log);string ls_descricao

select de_principal_internet
into :ls_descricao
from ecommerce_prd
where id_ecommerce = '2'
and id_rede_filial = :is_rede_ecommerce
and cd_produto = :pl_cd_produto ;

if sqlca.sqlcode = -1 then
	ps_log = 'Problemas ao consultar a tabela ecommerce_prd: ' + sqlca.sqlerrtext
	return false
end if

ps_de_principal_internet = ls_descricao

return true
end function

public function boolean of_processa_carga_imagem (string ps_rede_filial);long ll_cd_filial, ll_cd_produto, ll_linhas, ll_for
string ls_log
string ls_cd_sku
string ls_url_imagem
string ls_retorno
boolean lb_sucesso=false

dc_uo_ds_base lds_dados
uo_ge501_comum luo_comum_vtex

Try
	
	is_rede_ecommerce = ps_rede_filial
	
	open(w_aguarde)
	
	lds_dados = create dc_uo_ds_base
	
	luo_comum_vtex = create uo_ge501_comum
	
	if not lds_dados.of_changedataobject( 'ds_ge501_produto_ecommerce_prd' ) Then
		ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_produto ~n' + 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ds_ge501_produto_log'
		return false
	end if
	
//	If gvo_Aplicacao.ivs_DataSource <> 'central' then
//		ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_produto, a atualiza$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o pode ser a partir do HOMOLOGA.'
//		return false
//	End If
	
	//Carrega os parametros e busca o c$$HEX1$$f300$$ENDHEX$$digo da filial vinculado a rede.
	if Not luo_comum_vtex.of_parametros_ecommerce(is_id_ecommerce, ps_rede_filial, ref ll_cd_filial, ref ls_log ) Then return false

	lds_dados.of_AppendWhere('cd_url_imagem_produto_2 is null')
	lds_dados.of_AppendWhere('cd_sku is not null')

	ll_linhas = lds_dados.retrieve( is_id_ecommerce, ps_rede_filial )
	
	w_aguarde.uo_progress.of_setmax(ll_Linhas)
	
	for ll_for = 1 to ll_linhas
		
		ll_cd_produto = lds_dados.object.cd_produto[ll_for]
		ls_cd_sku = lds_dados.object.cd_sku[ll_for]
		
		//Verificar se a imagem j$$HEX1$$e100$$ENDHEX$$ foi cadastrada:
		luo_comum_vtex.of_get( is_id_interface_imagem + string(ls_cd_sku) , ref ls_retorno, ref ls_log )
		
		if ls_retorno = '' Then //Erro no retorno do webservice
			w_aguarde.uo_progress.of_setprogress(ll_for)
			Continue
		end if
		
		ls_log = ''
		If Not this.of_valida_retorno_imagem( ll_cd_produto, ls_retorno, false, ref ls_log) Then return false
	
		sqlca.of_commit( )
	
		w_aguarde.uo_progress.of_setprogress(ll_for)
	
	Next
	
	lb_sucesso = True
	
Finally

	if lb_sucesso = false Then
		sqlca.of_rollback( )
	ENd if

	Close(w_aguarde)
	
End Try


return true
end function

public function boolean of_valida_retorno_imagem (long pl_cd_produto, string ps_json, boolean pb_gerar_log, ref string ps_log);string ls_url_1, ls_url_2
string ls_info_imagens, ls_json_original, ls_restante
long ll_cd_filial


uo_ge073_json luo_gera_json

Try
		
	ls_json_original = ps_json	
		
	luo_gera_json = Create uo_ge073_json 
	
	ls_url_1 = luo_gera_json.of_busca_conteudo_campo_vtex(ps_json, 'ImageUrl')
	
	luo_gera_json.of_divide_grupo_json_tag_vtex(ref ls_json_original, 'Images', ref ls_info_imagens, ']')
	
	ls_url_2 = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_imagens, 'ImageUrl')
	
	if ( isnull(ls_url_1) or ls_url_1 = '') and ( isnull(ls_url_2) or ls_url_2 = '') Then
		return true
		
	else
		//Se possuir imagem, atualiza as informa$$HEX2$$e700f500$$ENDHEX$$es na tabela ecommerce_prd e manda rodar a interface de SKU.
		
		update ecommerce_prd
		set id_possui_imagem = 'S', cd_url_imagem_produto = :ls_url_1, cd_url_imagem_produto_2 = :ls_url_2, dh_atualizacao_imagem = getdate()
		where id_ecommerce = :is_id_ecommerce
		and id_rede_filial = :is_rede_ecommerce
		and cd_produto = :pl_cd_produto;
		
		if sqlca.sqlcode = -1 then
			ps_log = 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_valida_retorno_imagem; Problemas ao atualizar a tabela "ecommerce_prd": ' + sqlca.sqlerrtext
			return false
		end if
		
		If pb_gerar_log = True Then
			//Insere LOG para rodar a interface de SKU
			Select cd_filial_ecommerce
			into :ll_cd_filial
			from ecommerce_rede
			where id_ecommerce = :is_id_ecommerce
			and id_rede_filial = :is_rede_ecommerce;
			
			If sqlca.sqlcode = -1 then 
				ps_log = 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_valida_retorno_imagem; Problemas ao consultar a tabela "ecommerce_rede": ' + sqlca.sqlerrtext
				return false
			end if
			
			insert into log_exportacao_ecommerce (  nm_tabela, dh_atualizacao,de_chave,id_atualizacao,id_processado,cd_filial_ecommerce, id_ecommerce, de_origem_inclusao)
			Values ( 'SKU',
						getdate(),
						convert(char(6), :pl_cd_produto),
						'A',
						'N',
						:ll_cd_filial,
						:is_id_ecommerce,
						'UO_GE501_PRODUTO') ;
			
			If sqlca.sqlcode = -1 then 
				ps_log = 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_valida_retorno_imagem; Problemas ao inserir registro na tabela "log_exportacao_ecommerce": ' + sqlca.sqlerrtext
				return false
			end if
			
		End if
		
	end if

Finally
	Destroy(luo_gera_json)
End Try

return true
end function

on uo_ge501_produto.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge501_produto.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;is_objeto = 'Objeto: ' + this.classname() + '~n'
end event

