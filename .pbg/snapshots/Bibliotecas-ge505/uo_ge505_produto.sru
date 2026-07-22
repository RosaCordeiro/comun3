HA$PBExportHeader$uo_ge505_produto.sru
forward
global type uo_ge505_produto from nonvisualobject
end type
end forward

global type uo_ge505_produto from nonvisualobject
end type
global uo_ge505_produto uo_ge505_produto

type variables
string is_objeto
long il_cd_tipo = 2
string is_id_ecommerce = '3' //IFOOD
string is_id_interface = 'api/v1/produtointegracao'
string is_tabela = 'PRODUTO_GERAL'
String is_rede_ecommerce
String is_ean
String is_de_categoria
String is_de_departamento
String is_de_subcategoria
String is_de_marca
String is_descricao
String is_descricao_venda
String is_unidade
String is_situacao
String is_cd_filial_ecommerce
String is_visivel

Long il_cd_mensagem_email = 214
Long il_cd_marca, il_cd_categoria, il_cd_departamento
Long il_qt_estoque
Long il_cd_filial
Long il_cd_produto

Decimal idc_preco
Decimal idc_preco_liquido

long il_total_registros = 10000

uo_produto iuo_produto
end variables

forward prototypes
public function boolean of_valida_produto (long pl_cd_produto, ref string ps_log)
public function boolean of_verifica_liberado_ecommerce ()
private function string of_formata_descricao (long pl_tipo, string ps_ds_descricao)
public function boolean of_processa_atualizacao_produto ()
public function boolean of_processa_atualizacao_produto (long pl_cd_filial, string ps_rede_filial, long pl_produto)
private function boolean of_monta_json (ref string ps_json, ref string ps_log)
public function boolean of_busca_quantidade_estoque (long pl_cd_filial, long pl_cd_produto, ref long pl_qt_estoque, ref string ps_log)
public function boolean of_atualiza_produto_ecommerce (long pl_cd_produto, ref string ps_log)
public function boolean of_valida_retorno (string ps_json, ref string ps_log)
public function boolean of_verifica_executando (long pl_qt_total, ref long pl_prox_executar)
public function boolean of_verifica_produto_exportado (long pl_cd_produto, ref boolean pb_importado, ref string ps_log)
end prototypes

public function boolean of_valida_produto (long pl_cd_produto, ref string ps_log);boolean lb_sucesso = true

if isnull(is_de_departamento) or is_de_departamento = '' Then
	ps_log += 'Falta departamento.'
	lb_sucesso = false
end if

if is_descricao_venda = '' or isnull(is_descricao_venda) Then
	ps_log += 'Falta descri$$HEX2$$e700e300$$ENDHEX$$o de venda.'
	lb_sucesso = false
end if

if is_de_categoria = '' or isnull(is_de_categoria) Then
	ps_log += 'Falta categoria.'
	lb_sucesso = false
end if

//if is_de_subcategoria = '' or isnull(is_de_subcategoria) Then
//	ps_log += 'Falta subcategoria.'
//	lb_sucesso = false
//end if

if lb_sucesso = false Then
	return false
else
	return true
end if

end function

public function boolean of_verifica_liberado_ecommerce ();
//Verifica Produto Liberado Ecommerce
Choose Case is_rede_ecommerce
	Case 'FA'
		if isnull(iuo_Produto.id_liberado_ecommerce) or iuo_Produto.id_liberado_ecommerce <> 'S' Then
			return false
		End if
	Case 'DC'
		if isnull(iuo_Produto.id_liberado_ecommerce_DC) or iuo_Produto.id_liberado_ecommerce_DC <> 'S' Then
			return false
		End if
	Case 'MP'
		if isnull(iuo_Produto.id_liberado_ecommerce_MP) or iuo_Produto.id_liberado_ecommerce_MP <> 'S' Then
			return False
		End if
	Case 'PP'
		if isnull(iuo_Produto.id_liberado_ecommerce_PP) or iuo_Produto.id_liberado_ecommerce_PP <> 'S' Then
			return False
		End if	
		
End Choose

Return True
end function

private function string of_formata_descricao (long pl_tipo, string ps_ds_descricao);string ls_resultado

Choose Case pl_tipo
	Case 1
		ls_resultado = wordcap(ps_ds_descricao)
	Case 2
		ls_resultado = wordcap(ps_ds_descricao)
		ls_resultado = gf_replace(ls_resultado, ' ', '-', 0)
	Case 3
		ls_resultado = lower(ps_ds_descricao)
End Choose

return ls_resultado
end function

public function boolean of_processa_atualizacao_produto ();long ll_cd_filial, ll_for, ll_linhas, ll_total_executando, ll_prox_execucao
string ls_rede_filial, ls_nr_exportacao_saldo, ls_Nome_Janela, ls_parametro

dc_uo_ds_base lds_filiais

lds_filiais = create dc_uo_ds_base

if not lds_filiais.of_changedataobject( 'ds_ge505_filial_ecommerce' ) Then
	Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_produto ~n' + 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ds_ge505_filial_ecommerce')
	return false
end if
	
ll_linhas = lds_filiais.retrieve( is_id_ecommerce )
if ll_linhas < 0 Then
	Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_produto ~n' + 'Problemas ao consultar o banco de dados: ~n' + sqlca.is_lasterrortext )
	return false
end if

//lojas simultaneas
Select vl_parametro 
into :ls_nr_exportacao_saldo
from parametro_geral
where cd_parametro = 'NR_EXPORTACAO_VTEX_SALDO';

if sqlca.sqlcode = -1 then
	messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o',  this.classname( ) + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_produto ~n' + 'Problemas ao consultar a tabela "parametro_geral": ~nErro: ' + sqlca.sqlerrtext )
	Return false
end if

ll_total_executando = long (ls_nr_exportacao_saldo)

for ll_for = 1 to ll_linhas
	
	ll_cd_filial = lds_filiais.object.cd_filial_ecommerce[ll_for]
	ls_rede_filial = lds_filiais.object.id_rede_filial[ll_for]
	
	Do 
		Sleep(1)
		this.of_verifica_executando(ll_total_executando, ref ll_prox_execucao )
	Loop While ll_prox_execucao = 0
	
	ls_Nome_Janela = "EX - INTERFACE PRODUTO IFOOD - [" + String(ll_prox_execucao) + "]"

	ls_parametro =  String(ll_cd_filial) + '/' + ls_rede_filial + '/' + ls_nome_janela

	Run("C:\Sistemas\EX\Exe\ex.exe /AUTO/IFPR/" + ls_parametro  )
	
next


destroy(lds_filiais)

Return True
end function

public function boolean of_processa_atualizacao_produto (long pl_cd_filial, string ps_rede_filial, long pl_produto);long ll_linhas, ll_for, ll_find
long ll_nr_atualizacao
long ll_seq_log
long ll_contador=0
long ll_linha_aux
long ll_for2
long ll_rows
long ll_for3
long ll_qt_estoque_ant

String ls_json, ls_retorno
String ls_Chave_Nula , ls_chave
String ls_MSG_Nula
String ls_Log
String ls_situacao_log
String ls_niveis
String ls_de_cod_barra
String ls_ean_ant
String ls_cd_unidade_medida_venda

decimal ldc_desconto_filial

boolean lb_existe_movimento
boolean lb_sucesso=false
boolean lb_disponivel
boolean lb_exportado

datetime ldt_inicio, ldh_Data_Nula

dc_uo_ds_base lds_dados, lds_auxiliar, lds_cod_barra
uo_ge505_comum luo_comum

SetNull(ls_Chave_Nula)
SetNull(ls_MSG_Nula)
SetNull(ldh_Data_Nula)

try 
	Open(w_Aguarde)
	
	il_cd_filial = pl_cd_filial
	is_rede_ecommerce = ps_rede_filial

	luo_comum = create uo_ge505_comum
	
	iuo_produto = create uo_produto

	lds_dados = create dc_uo_ds_base
	lds_auxiliar = create dc_uo_ds_base
	lds_cod_barra = create dc_uo_ds_base
	
	if not lds_dados.of_changedataobject( 'ds_ge505_produto' ) Then
		ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_produto ~n' + 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ds_ge505_produto'
		return false
	end if
	
	if not lds_auxiliar.of_changedataobject( 'ds_ge505_log_produto' ) Then
		ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_produto ~n' + 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ds_ge505_log_produto'
		return false
	end if
	
	if not lds_cod_barra.of_changedataobject( 'ds_ge505_produto_cod_barra' ) Then
		ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_produto ~n' + 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ds_ge505_produto_cod_barra'
		return false
	end if
	
	
	//Carrega os parametros e busca o c$$HEX1$$f300$$ENDHEX$$digo da filial vinculado a rede.
	if Not luo_comum.of_parametros_ecommerce_filial( il_cd_filial, is_rede_ecommerce, is_id_ecommerce, ref ls_log ) Then return false
	
	is_cd_filial_ecommerce = luo_comum.is_IdLoja
	
	//Altera situacao para pendente
	if pl_produto = 0 or isnull(pl_produto) Then 
		setnull(ls_chave)
	else
		ls_chave = string(pl_produto)
	end if
	If not luo_comum.of_altera_situacao_log_ecommerce( 'P', is_tabela, il_cd_filial, ls_chave, ref ls_log ) Then return false
	
	If Not IsNull( pl_Produto ) and pl_produto > 0 Then
		lds_dados.of_AppendWhere("l.de_chave = '" + String( pl_Produto ) + "'" )
	End If
	
	ll_linhas = lds_dados.retrieve( is_id_ecommerce, il_cd_filial, is_rede_ecommerce)
	
	if ll_linhas < 0 Then
		ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_produto ~n' + 'Problemas ao consultar o banco de dados na seguinte datawindow: ds_ge505_produto'
		return false
	end if
	
	If ll_Linhas > 0 Then
		
		if ll_linhas > il_total_registros then
			ll_linhas = il_total_registros
		end if
		
		luo_comum.il_qt_item_enviado_site = ll_linhas
         // Grava in$$HEX1$$ed00$$ENDHEX$$cio do processo
		If Not luo_comum.of_grava_log(il_cd_filial, il_cd_tipo, ls_Chave_Nula, 'C', ls_MSG_Nula, gf_getserverdate(), gf_getserverdate(), ref ls_Log, ref ll_Seq_Log ) Then Return False
		
	End If
	
	ls_Situacao_Log = 'P'
	
	w_aguarde.uo_progress.of_setmax(ll_Linhas)
	
	for ll_for = 1 to ll_linhas
		
		w_Aguarde.Title = "Atualizando Produto no eCommerce - Filial: " + string(il_cd_filial) + "[" + ps_rede_filial +  "] - "  + String(ll_for)  + " de " + STring(ll_Linhas)
		
		luo_comum.of_limpa_variaveis( )
		
		ldt_inicio = gf_getserverdate()
		
		lb_disponivel = True
		
		il_cd_produto 					= lds_dados.object.cd_produto[ll_for]
		il_cd_marca 					= lds_dados.object.cd_marca_ecommerce[ll_for]
		il_cd_categoria 				= lds_dados.object.cd_categoria_ecommerce[ll_for]
		is_de_marca 					= lds_dados.object.de_marca[ll_for]
		//is_descricao_venda 			= lds_dados.object.de_apresentacao_venda[ll_for]
		is_unidade 						= lds_dados.object.cd_unidade_medida_venda[ll_for]
		is_visivel							= lds_dados.object.id_visivel_prd					[ll_for]
		
		//Busca informa$$HEX2$$e700f500$$ENDHEX$$es de categoria
		if Not gf_retorna_categoria_ecommerce( il_cd_categoria, ref ls_niveis,  ref is_de_departamento, ref is_de_categoria, ref is_de_subcategoria, ref ls_log ) Then return false
		
		iuo_Produto.of_Localiza_Codigo_Interno(il_cd_produto)
		
		If Not iuo_Produto.Localizado Then 
			w_aguarde.uo_progress.of_setprogress(ll_for)
			Continue
		End If
		
		//N$$HEX1$$e300$$ENDHEX$$o subir saldo de produtos da categoria VACINAS/Teste Covid
		if iuo_produto.cd_subcategoria = '102153003' or iuo_produto.cd_subcategoria = '206027007' then
			il_qt_estoque = 0
			lb_disponivel = false
		else
			
			//Busca o saldo do produto
			if Not this.of_busca_quantidade_estoque( il_cd_filial, il_cd_produto, ref il_qt_estoque, ref ls_log ) Then return false
				
		end if
		
		is_descricao = iuo_Produto.de_descricao_internet
		is_descricao_venda = is_descricao
		is_Situacao	= iuo_Produto.id_situacao
		is_ean = iuo_produto.de_codigo_barras
		ls_cd_unidade_medida_venda = iuo_produto.cd_unidade_medida_venda
		
		idc_preco = iuo_produto.of_preco_venda_filial_matriz(il_cd_filial)
			
		//Busca o desconto
		ldc_desconto_filial = iuo_produto.of_desconto_filial( il_cd_filial )
		
		//Calcula o pre$$HEX1$$e700$$ENDHEX$$o l$$HEX1$$ed00$$ENDHEX$$quido.
		if ldc_desconto_filial > 0 Then
			idc_preco_liquido = Round( idc_preco - ( idc_preco * ( ldc_desconto_filial / 100 )), 2)
		else
			idc_preco_liquido = 0
		end if
		
		luo_comum.idc_vl_preco = idc_preco
		luo_comum.idc_pc_desconto = ldc_desconto_filial
		luo_comum.il_cd_produto = il_cd_produto
		luo_comum.il_cd_categoria = il_cd_categoria
		luo_comum.il_cd_marca = il_cd_marca		
		luo_comum.idc_qt_saldo = il_qt_estoque
		
		//Somente produtos ativos
		if isnull(is_situacao) or is_situacao <> 'A' Then
			lb_disponivel = false
		end if
		
		//Verifica Produto Liberado Ecommerce 
		if Not this.of_verifica_liberado_ecommerce( ) Then
			lb_disponivel = false
		end if
		
		// N$$HEX1$$e300$$ENDHEX$$o pode ser psico // N$$HEX1$$e300$$ENDHEX$$o pode ser geladeira // N$$HEX1$$e300$$ENDHEX$$o pode ser produto de almoxarifado
		if ( not isnull(iuo_Produto.cd_grupo_psico) and iuo_Produto.cd_grupo_psico <> '' ) &
			or ( Mid(iuo_Produto.de_produto, 1, 2) = 'ZZ' ) &
			or ( Mid(iuo_Produto.cd_subcategoria, 1, 1) ) = '5' &	
			or ( Mid(iuo_Produto.cd_subcategoria, 1, 1) ) = '6' Then
			lb_disponivel = false
		End if
		
		If Not this.of_valida_produto( il_cd_produto, ref ls_log ) Then
			luo_comum.of_grava_log_item( il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
			ls_Situacao_Log = 'E'
			ls_Log = ''
			
			//Altera situacao para Processado
			If not luo_comum.of_altera_situacao_log_ecommerce( 'S', is_tabela, il_cd_filial, String(il_cd_produto), ref ls_log ) Then return false
									
			w_aguarde.uo_progress.of_setprogress(ll_for)
			Continue
		end if
		
		//Verifica se o produto j$$HEX1$$e100$$ENDHEX$$ foi exportado pro Ifood.
		if Not this.of_verifica_produto_exportado( il_cd_produto, ref lb_exportado, ref ls_log ) Then return false
			
		
		if lb_disponivel = false Then
			is_situacao = 'I'
			
			if lb_exportado = False Then
				//Altera situacao para Processado
				If not luo_comum.of_altera_situacao_log_ecommerce( 'S', is_tabela, il_cd_filial, String(il_cd_produto), ref ls_log ) Then return false
				
				w_aguarde.uo_progress.of_setprogress(ll_for)
				Continue
			end if
		end if

		if lb_exportado = True Then
			
			//Verificar se existe mais de um codigo de barras para o produto:		
			ll_rows = lds_cod_barra.retrieve(il_cd_produto)
			
			if ll_rows > 0 Then
				
				//Verifica qual EAN deve ser usado na integracao. Devemos usar o configurado para a unidade medidda de venda:
				ll_find = lds_cod_barra.find('cd_unidade_medida_venda = "' + ls_cd_unidade_medida_venda + '"', 1, ll_rows)
				if ll_find > 0 then
					is_ean = lds_cod_barra.object.de_codigo_barras[ll_find]
				elseif ll_find < 0 then
					ls_log = 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_produto ~n' + 'Erro ao realizar find na datastore lds_cod_barra.'
					return false
				ENd if
				
				ll_qt_estoque_ant = il_qt_estoque
				ls_ean_ant = is_ean
			
				//Zerar o estoque dos EAN nao utilizados:
				for ll_for3 = 1 to ll_rows
					ls_de_cod_barra = lds_cod_barra.object.de_codigo_barras[ll_for3]
					
					if ls_de_cod_barra = ls_ean_ant then Continue
					
					//Enviar saldo zero para os cod barra secundarios :
					is_ean = ls_de_cod_barra
					il_qt_estoque = 0
					
					if Not this.of_monta_json(ref ls_json, ref ls_log) Then return false
						
				next
				
				lds_cod_barra.reset()
		
				il_qt_estoque = ll_qt_estoque_ant 
				is_ean = ls_ean_ant
				
			ENd if
			
		End if
		
		if Not this.of_monta_json(ref ls_json, ref ls_log) Then return false
		
		if lb_disponivel = True Then
			luo_comum.is_id_visible = 'S'
		else
			luo_comum.is_id_visible = 'N'
		end if
		
		ll_linha_aux = lds_auxiliar.insertrow(0)
		lds_auxiliar.object.cd_produto[ll_linha_aux] = il_cd_produto
		lds_auxiliar.object.vl_preco[ll_linha_aux] = idc_preco
		lds_auxiliar.object.vl_desconto[ll_linha_aux] = ldc_desconto_filial
		lds_auxiliar.object.cd_categoria[ll_linha_aux] = il_cd_categoria
		lds_auxiliar.object.cd_marca[ll_linha_aux] = il_cd_marca
		lds_auxiliar.object.qt_saldo[ll_linha_aux] = il_qt_estoque
				
		w_aguarde.uo_progress.of_setprogress(ll_for)
	next	
	
	if lds_auxiliar.rowcount( ) > 0 then
			
		ls_json += ']'
	
//		luo_comum.is_json = ls_json
			
		//Gera o token pra conectar no webservice.		
		if Not	 luo_comum.of_gera_token( ref ls_log ) Then return false	
		
		If ls_Log <> '' and not isnull(ls_Log) Then
			luo_comum.of_envia_email(il_cd_mensagem_email, 'PRODUTOS', ll_Seq_Log, 'Interface de Produtos: '  +  ls_Log, string(il_cd_produto))
			ls_Situacao_Log = 'E'
			lds_auxiliar.reset()
			return false
			
		end if
		
		if not luo_comum.of_post( ls_json, is_id_interface, ref ls_retorno, ref ls_log ) Then return false
		
		If ls_Log <> '' and not isnull(ls_Log) Then
			luo_comum.of_envia_email(il_cd_mensagem_email, 'PRODUTOS', ll_Seq_Log, 'Interface de Produtos: '  +  ls_Log, string(il_cd_produto))
			ls_Situacao_Log = 'E'
			lds_auxiliar.reset()
			return false
		end if
		
		ll_linhas = lds_auxiliar.rowcount()
		
		w_aguarde.uo_progress.of_reset()
		w_aguarde.uo_progress.of_setmax(ll_linhas)
		
		for ll_for2 = 1 to ll_linhas
			
			w_Aguarde.Title = "Atualizando situa$$HEX2$$e700e300$$ENDHEX$$o dos produto na matriz - Filial: " + string(il_cd_filial) + "[" + ps_rede_filial +  "] - "  + String(ll_for2)  + " de " + STring(ll_Linhas)
			
			il_cd_produto = lds_auxiliar.object.cd_produto[ll_for2]
			il_qt_estoque =  lds_auxiliar.object.qt_saldo[ll_for2]
			
			luo_comum.idc_vl_preco = lds_auxiliar.object.vl_preco[ll_for2]
			luo_comum.idc_pc_desconto = lds_auxiliar.object.vl_desconto[ll_for2]
			luo_comum.il_cd_produto = lds_auxiliar.object.cd_produto[ll_for2]
			luo_comum.il_cd_categoria = lds_auxiliar.object.cd_categoria[ll_for2]
			luo_comum.il_cd_marca = lds_auxiliar.object.cd_marca[ll_for2]		
			luo_comum.idc_qt_saldo =il_qt_estoque
			
			//Atualiza as tabelas de ecommerce referente ao produto..
			if not this.of_atualiza_produto_ecommerce( il_cd_produto, ref ls_log ) Then Return false
	
			//Altera situacao para Processado
			If not luo_comum.of_altera_situacao_log_ecommerce( 'S', is_tabela, il_cd_filial, String(il_cd_produto), ref ls_log ) Then return false
			
			sqlca.of_commit( )
			
			//Grava no log como processado com $$HEX1$$ea00$$ENDHEX$$xito.
			if Not luo_comum.of_grava_log_item(il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log ) Then Return false
			
			w_aguarde.uo_progress.of_setprogress(ll_for2)
			
		next
		
		lds_auxiliar.reset()
		
	end if
	
	update ecommerce_rede_filial
	set dh_atualizacao_saldo = getdate()
	where id_ecommerce = :is_id_ecommerce
		and id_rede_filial = :is_rede_ecommerce
		and cd_filial = :il_cd_filial
	Using SqlCa;
	
	if sqlca.sqlcode = -1 then
		ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_produto ~n' + 'Problemas ao atualizar a tabela "ecommerce_rede_filial": ~n' + sqlca.sqlerrtext
		return false
	end if
	
	sqlca.of_commit( )
	
	lb_sucesso = True

Finally
	
	if Not lb_sucesso then
		sqlca.of_rollback( )
		
		if isvalid(w_aguarde) Then Close(w_Aguarde)
		
		// J$$HEX1$$e100$$ENDHEX$$ iniciou o envio dos itens
		If ll_for > 0 Then
			// Atualiza log com erro
			If Not luo_comum.of_atualiza_ecommerce_log(il_cd_filial, ll_Seq_Log, 'E', ls_Log, gf_getserverdate(), ref ls_Log) Then Return False
			if Not luo_comum.of_grava_log_item(il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log) Then Return false
		Else
			// Se n$$HEX1$$e300$$ENDHEX$$o tiver log insere um novo com erro
			If IsNull(ll_Seq_Log) or ll_Seq_Log = 0 Then
				// Grava in$$HEX1$$ed00$$ENDHEX$$cio do processo - chave e mensagem est$$HEX1$$e300$$ENDHEX$$o indo como nulo
				If Not luo_comum.of_grava_log(il_cd_filial, il_cd_tipo, ls_Chave_Nula, 'E', ls_Log, ldh_Data_Nula, gf_getserverdate(), ref ls_Log, ref ll_Seq_Log ) Then Return False
			Else
				// Atualiza log com erro
				If Not luo_comum.of_atualiza_ecommerce_log(il_cd_filial, ll_Seq_Log, 'E', ls_Log, gf_getserverdate(), ref ls_Log) Then Return False
			End If		
		End If
	Else
		If ll_Linhas > 0 Then
			// Marca o log como processado
			If Not luo_comum.of_atualiza_ecommerce_log(il_cd_filial, ll_Seq_Log, ls_Situacao_Log, ls_MSG_Nula, gf_getserverdate(), ref ls_Log) Then Return False
		End If
	End If
	
	destroy(lds_dados)
	destroy(luo_comum)
	destroy(iuo_Produto)
	
	if isvalid(w_aguarde) Then Close(w_Aguarde)
	
End try

return true
end function

private function boolean of_monta_json (ref string ps_json, ref string ps_log);string ls_id_ativo


if is_situacao = 'A' Then
	ls_id_ativo = 'true'
else
	ls_id_ativo = 'false'
end if

If il_qt_estoque <= 0 or is_visivel = 'N' Then
	ls_id_ativo = 'false'
End If

if isnull(is_de_categoria) Then is_de_categoria = ''
if isnull(is_de_departamento) Then is_de_departamento = ''
if isnull(is_de_subcategoria) Then is_de_subcategoria = ''
if isnull(is_de_marca) Then is_de_marca = ''
if isnull(is_unidade) Then is_unidade = ''
if isnull(is_ean) Then is_ean = ''
if isnull(is_descricao) Then is_descricao = ''
if isnull(is_descricao_venda) Then is_descricao_venda = ''
if isnull(ls_id_ativo) Then ls_id_ativo = ''

if ps_json = '' or isnull(ps_json) Then
	ps_json = '['
else
	ps_json += ', '
end if

ps_json += '{ ' + &
	'"idLoja": ' + is_cd_filial_ecommerce + ', ' + & 
	'"departamento": "' + is_de_departamento + '", ' + &
	'"categoria": "' + is_de_categoria + '", ' + &
	'"subCategoria": "' + is_de_subcategoria + '", ' + &
	'"marca": "' + is_de_marca + '", ' + &
	'"unidade": "' + is_unidade + '", ' + &
	'"volume": "' + '0' + '", ' + &
	'"codigoBarra": "' + is_ean + '", ' + &	
	'"nome": "' + is_descricao + '", ' + &
	'"valor": ' + gf_valor_com_ponto(idc_preco) + ', ' + &
	'"valorPromocao": ' + gf_valor_com_ponto(idc_preco_liquido) + ', ' + &
	'"valorAtacado": "' + '0' + '", ' + &
	'"valorCompra": "' + '0' + '", ' +&
	'"quantidadeEstoqueAtual": ' + string(il_qt_estoque) + ', ' + &
	'"quantidadeEstoqueMinimo": 0, ' + &
	'"quantidadeAtacado": 0, ' + &
	'"descricao": "' + is_descricao_venda + '", ' + &
	'"ativo": ' + ls_id_ativo + ', ' + &
	'"plu": "' + string(il_cd_produto) + '", ' + &
	'"validadeProxima": false ' + &
	'}'

return true
end function

public function boolean of_busca_quantidade_estoque (long pl_cd_filial, long pl_cd_produto, ref long pl_qt_estoque, ref string ps_log);long ll_qt_estoque=0

Select coalesce(qt_saldo_filial, 0) - coalesce(qt_saldo_pendente, 0) - coalesce(qt_saldo_transferencia, 0) - coalesce(qt_saldo_prestes, 0)
into :ll_qt_estoque
from ecommerce_prd_filial
where id_ecommerce = '2'
and id_rede_filial = :is_rede_ecommerce
and cd_produto = :pl_cd_produto
and cd_filial = :pl_cd_filial ;

if sqlca.sqlcode = -1 then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_busca_quantidade_estoque ; Problemas ao consultar a tabela "ecommerce_prd_filial": ' + sqlca.sqlerrtext
	return false
end if

if isnull(ll_qt_estoque) or ll_qt_estoque < 0 then ll_qt_estoque = 0

pl_qt_estoque = ll_qt_estoque

return true
end function

public function boolean of_atualiza_produto_ecommerce (long pl_cd_produto, ref string ps_log);long ll_existe=0
boolean lb_importado

Select count(*) 
into :ll_existe
from ecommerce_prd
where id_ecommerce = :is_id_ecommerce
and id_rede_filial = :is_rede_ecommerce
and cd_produto = :pl_cd_produto;

if sqlca.sqlcode = -1 then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_produto_ecommerce ~n' + 'Problemas ao consultar a tabela "ecommerce_prd": ~n' + sqlca.sqlerrtext
	return false
end if

if ll_existe = 0 or isnull(ll_existe) Then

	Insert into ecommerce_prd(id_ecommerce, id_rede_filial, cd_produto, dh_inclusao_prd)
	values( :is_id_ecommerce, :is_rede_ecommerce, :pl_cd_produto,  getdate() );

	if sqlca.sqlcode = -1 then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_produto_ecommerce ~n' + 'Problemas ao inserir registro na tabela "ecommerce_prd": ~n' + sqlca.sqlerrtext
		return false
	end if
	
End if

ll_existe = 0

if Not this.of_verifica_produto_exportado( pl_cd_produto, ref lb_importado, ref ps_log ) Then return false

if lb_importado = false Then
	
	Insert into ecommerce_prd_filial(id_ecommerce, id_rede_filial, cd_produto, cd_filial, qt_saldo, dh_atualizacao )
	values( :is_id_ecommerce, :is_rede_ecommerce, :pl_cd_produto, :il_cd_filial, :il_qt_estoque, getdate() );

	if sqlca.sqlcode = -1 then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_produto_ecommerce ~n' + 'Problemas ao inserir registro na tabela "ecommerce_prd_filial": ~n' + sqlca.sqlerrtext
		return false
	end if

else
	
	Update ecommerce_prd_filial
	set qt_saldo = :il_qt_estoque, dh_atualizacao = getdate()
	where id_ecommerce = :is_id_ecommerce
		and id_rede_filial = :is_rede_ecommerce
		and cd_filial = :il_cd_filial
		and cd_produto = :pl_cd_produto;
			
	if sqlca.sqlcode = -1 then
		ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_produto_ecommerce ~n' + 'Problemas ao atualizar registro na tabela "ecommerce_prd_filial": ~n' + sqlca.sqlerrtext
		return false
	end if
			
end if

return true
end function

public function boolean of_valida_retorno (string ps_json, ref string ps_log);






return true
end function

public function boolean of_verifica_executando (long pl_qt_total, ref long pl_prox_executar);String ls_Janela_Ativa 
long ll_controles_executando, ll_for

pl_prox_executar=0

for ll_for = 1 to pl_qt_total

	ls_janela_ativa = "EX - INTERFACE PRODUTO IFOOD - [" + String(ll_for) + "]"
	
	If Not gvo_aplicacao.of_appisrunning(ls_Janela_Ativa) Then
		pl_prox_executar = ll_for
		Exit
	End If
	
Next

return true
end function

public function boolean of_verifica_produto_exportado (long pl_cd_produto, ref boolean pb_importado, ref string ps_log);long ll_existe

Select count(*) 
into :ll_existe
from ecommerce_prd_filial
where id_ecommerce = :is_id_ecommerce
and id_rede_filial = :is_rede_ecommerce
and cd_produto = :pl_cd_produto
and cd_filial = :il_cd_filial;

if sqlca.sqlcode = -1 then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_verifica_produto_exportado ; ' + 'Problemas ao consultar a tabela "ecommerce_prd_filial": ' + sqlca.sqlerrtext
	return false
end if

if ll_existe > 0 Then
	pb_importado = True
else
	pb_importado = false
end if

return true
end function

on uo_ge505_produto.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge505_produto.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;is_objeto = 'Objeto: ' + this.classname() + '~n'
end event

