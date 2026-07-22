HA$PBExportHeader$uo_ge501_integracao_vtex.sru
forward
global type uo_ge501_integracao_vtex from nonvisualobject
end type
end forward

global type uo_ge501_integracao_vtex from nonvisualobject
end type
global uo_ge501_integracao_vtex uo_ge501_integracao_vtex

type variables
string is_rede_ecommerce

end variables

forward prototypes
public function boolean of_processa_marca ()
public function boolean of_processa_preco (long pl_cd_produto)
public function boolean of_processa_produto (long pl_cd_produto)
public function boolean of_processa_sku (long pl_cd_produto)
public function boolean of_processa_integracao_vtex (long pl_tipo_interface, string ps_rede_ecommerce, long pl_cd_produto)
public function boolean of_processa_integracao_vtex (long pl_tipo_interface, string ps_rede_ecommerce)
public function boolean of_processa_saldo_filial ()
public function boolean of_processa_saldo_filial (long pl_cd_filial, string ps_id_rede)
public function boolean of_situacao_ecommerce (ref string ps_situacao, ref string ps_log)
public function boolean of_processa_saldo_principal ()
public function boolean of_processa_integracao_vtex (long pl_tipo_interface)
public function boolean of_processa_ean ()
public function boolean of_atualiza_produtos ()
public function boolean of_processa_pedido_nsu ()
public function boolean of_processa_saldo_site ()
public function boolean of_processa_saldo_site (long pl_cd_filial, string ps_id_rede)
public function boolean of_processa_pedido_feed ()
public function boolean of_processa_pedido_baixa ()
public function boolean of_processa_pedido_status ()
public function boolean of_processa_pedido_rastreio ()
public function boolean of_processa_pedido_filial ()
public function boolean of_atualiza_pedidos ()
public function boolean of_atualiza_filial ()
public function boolean of_atualiza_devolucao ()
public function boolean of_processa_receita ()
public function boolean of_atualiza_pedidos_status ()
private function boolean _of_verifica_executando (string ps_nome_interface, long pl_qt_total, ref long pl_prox_executar, ref string ps_nome_janela)
public function boolean of_atualiza_saldo_rede (long pl_cd_filial, string ps_id_rede)
public function boolean of_processa_pedido_baixa_gototem ()
public function boolean of_processa_pedido_rastreamento ()
public function boolean of_verifica_hora_inicio_integracao (ref boolean pb_valido, ref string ps_log)
public function boolean of_valida_situacao_interface (long pl_cd_interface)
public function boolean of_processa_pedido_status_rapido ()
public function boolean of_atualiza_saldo_rede (string ps_tipo)
public function boolean of_atualiza_saldo_rede ()
public function boolean of_processa_pedido_baixa_memed ()
end prototypes

public function boolean of_processa_marca ();uo_ge501_marca luo_marca

luo_marca = create uo_ge501_marca

If not luo_marca.of_processa_atualizacao_marca( is_rede_ecommerce ) then return false

destroy(luo_marca)

return true
end function

public function boolean of_processa_preco (long pl_cd_produto);long ll_cd_filial, ll_for, ll_linhas
string ls_rede_filial

dc_uo_ds_base lds_filiais

lds_filiais = create dc_uo_ds_base

uo_ge501_preco luo_preco

luo_preco = create uo_ge501_preco

if not lds_filiais.of_changedataobject( 'ds_ge501_filiais_rede' ) Then
	Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_preco ~n' + 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ds_ge501_filiais_rede')
	return false
end if
	
ll_linhas = lds_filiais.retrieve( )
if ll_linhas < 0 Then
	Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_preco ~n' + 'Problemas ao consultar o banco de dados: ~n' + sqlca.is_lasterrortext )
	return false
end if

for ll_for = 1 to ll_linhas
	
	ls_rede_filial = lds_filiais.object.id_rede_filial[ll_for]
	
	If not luo_preco.of_processa_atualizacao_preco( ls_rede_filial, pl_cd_produto ) then return false
	
next

destroy(lds_filiais)
destroy(luo_preco)

Return True
end function

public function boolean of_processa_produto (long pl_cd_produto);uo_ge501_produto luo_produto

luo_produto = create uo_ge501_produto

If not luo_produto.of_processa_atualizacao_produto( is_rede_ecommerce, pl_cd_produto ) then return false

destroy(luo_produto)

return true
end function

public function boolean of_processa_sku (long pl_cd_produto);uo_ge501_sku luo_sku

luo_sku = create uo_ge501_sku

If not luo_sku.of_processa_atualizacao_sku( is_rede_ecommerce, pl_cd_produto ) then return false

destroy(luo_sku)

return true
end function

public function boolean of_processa_integracao_vtex (long pl_tipo_interface, string ps_rede_ecommerce, long pl_cd_produto);string ls_situacao_ecommerce
string ls_log
boolean lb_inicio_integracao

is_rede_ecommerce = ps_rede_ecommerce

try

	If Not this.of_situacao_ecommerce( ref ls_situacao_ecommerce, ref ls_log ) Then return false
		
	if ls_situacao_ecommerce = 'I' or isnull(ls_situacao_ecommerce) or ls_situacao_ecommerce = '' Then
		Return true
	end if

	if pl_tipo_interface > 0 then
		if Not this.of_valida_situacao_interface( pl_tipo_interface ) Then return true
	ENd if
		
	If Not this.of_verifica_hora_inicio_integracao( ref lb_inicio_integracao, ref ls_log) Then return false
	
	if lb_inicio_integracao = false then
		return true
	ENd if

	Choose Case pl_tipo_interface
		
		Case  0 //Atualiza$$HEX2$$e700e300$$ENDHEX$$o de produtos
			if Not this.of_atualiza_produtos( ) Then return false
		
		Case  -1 //Atualiza$$HEX2$$e700e300$$ENDHEX$$o de pedidos
			if Not this.of_atualiza_pedidos( ) Then return false
			
		Case  -2 //Atualiza$$HEX2$$e700e300$$ENDHEX$$o de pedidos - STATUS

			If Not this.of_atualiza_pedidos_status( ) then return false
			
		Case 1 //Marca
			if Not this.of_processa_marca( ) Then return false
			
		Case 2 //Produto
			if Not this.of_processa_produto( pl_cd_produto ) Then return false
			
		Case 3 //SKU
			if Not this.of_processa_sku( pl_cd_produto ) Then return false
			
		Case 4 //Pre$$HEX1$$e700$$ENDHEX$$o
			if Not this.of_processa_preco( pl_cd_produto ) Then return false
		
		Case 5 //Saldo
			if Not this.of_processa_saldo_filial( ) Then return false
		
		Case 6 //Produto - EAN
			if Not this.of_processa_ean( ) Then return false
		
		Case 11 //Saldo Principal
			if Not this.of_processa_saldo_principal( ) Then return false

		Case 16 //Saldo Site
			if Not this.of_processa_saldo_site() Then return false
			
		Case 10 // Saldo rede
			If Not this.of_atualiza_saldo_rede() Then Return False
			
		Case 13 // Nossas Lojas
			If Not This.of_atualiza_filial() Then Return False
			
		Case 17 // Devolu$$HEX2$$e700e300$$ENDHEX$$o
			If Not This.of_atualiza_devolucao() Then Return False
		
		Case 18 // Receita - Manipula$$HEX2$$e700e300$$ENDHEX$$o
			If Not This.of_processa_receita() Then Return False
			
		Case 19 //Rastreamento de Entrega
			If Not this.of_processa_pedido_rastreamento( ) Then return false
			
		Case 22 //Pedido Status - Rapido
			If Not this.of_processa_pedido_status_rapido( ) Then return false
			
		Case 23 // Saldo rede - CD
			If Not this.of_atualiza_saldo_rede('CD') Then Return False	
			
	End Choose

Finally
	
	if ls_log <> '' and not isnull(ls_log) Then
		messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o',ls_log)
	end if
	
End try

return true
end function

public function boolean of_processa_integracao_vtex (long pl_tipo_interface, string ps_rede_ecommerce);return this.of_processa_integracao_vtex( pl_tipo_interface, ps_rede_ecommerce, 0)
end function

public function boolean of_processa_saldo_filial ();long ll_linhas
long ll_total_executando
long ll_cd_filial
long ll_for
long ll_qt_executando
long ll_prox_execucao
long ll_existe
long ll_nr_dia_carga_completa
long ll_contador=0

date ldh_carga_completa
date ldh_prox_carga_completa
date ldh_Atualizacao_Saldo
date ldh_Parametro

string ls_log
string ls_id_rede
string ls_nome_janela
string ls_parametro
string ls_nr_exportacao_saldo
string ls_nome_interface

boolean lb_carga_Completa = false
boolean lb_sleep = false

dc_uo_ds_base lds_filiais

lds_filiais = create dc_uo_ds_base
	
if not lds_filiais.of_changedataobject( 'ds_ge501_filiais_ecommerce' ) Then
	ls_log = this.classname() + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_saldo_filial ~n' + 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ds_ge501_filiais_ecommerce'
	return false
end if

If Not IsNull(gvl_Grupo_Exec_Vtex) and gvl_Grupo_Exec_Vtex > 0 Then
	lds_filiais.of_appendwhere("erf.cd_grupo_execucao_tarefa = '" + string(gvl_Grupo_Exec_Vtex) + "'")
End If

//lds_filiais.of_appendwhere("fl.cd_filial in (select cd_filial from resumo_movimento_estoque r where r.dh_resumo >= (select dh_movimentacao from parametro where id_parametro = '1'))")
	
ll_linhas = lds_filiais.retrieve( )

if ll_linhas < 0 Then
	ls_log = this.classname( ) + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_saldo_filial ~n' + 'Problemas ao consultar o banco de dados na seguinte datawindow: ds_ge501_filiais_ecommerce ~nErro: ' + sqlca.is_lasterrortext
	return false
end if

//lojas simultaneas
Select vl_parametro 
into :ls_nr_exportacao_saldo
from parametro_geral
where cd_parametro = 'NR_EXPORTACAO_VTEX_SALDO';

if sqlca.sqlcode = -1 then
	ls_log = this.classname( ) + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_saldo_filial ~n' + 'Problemas ao consultar a tabela "parametro_geral": ~nErro: ' + sqlca.sqlerrtext
	Return false
end if

ll_total_executando = long(ls_nr_exportacao_saldo)

ls_nome_interface = Upper('EX - INTERFACE SALDO VTEX - Grupo: (' +String(gvl_Grupo_Exec_Vtex) +  ')')

ldh_Parametro = Date(gf_GetServerDate())

ll_prox_execucao=0

for ll_for = 1 to ll_linhas

	lb_carga_completa = false

	ll_cd_filial 					= lds_filiais.object.cd_filial					[ll_for]	
	ls_id_rede 					= lds_filiais.object.id_rede_filial			[ll_for]	
	ldh_Atualizacao_Saldo 	= date(lds_filiais.object.dh_atualizacao_saldo	[ll_for]	)
	ll_nr_dia_carga_completa = lds_filiais.object.nr_dia_carga_completa[ll_for]
	ldh_carga_completa 		= date(lds_filiais.object.dh_carga_saldo_completa	[ll_for] )
	ldh_prox_carga_completa = date(lds_filiais.object.dh_proxima_carga_saldo_comp[ll_for] )
	
	If Hour(Now()) < 1 Then Continue
	
	//Verificar se vai executar uma carga completa:
	if isnull( ldh_Atualizacao_Saldo ) Then
		lb_carga_completa = True
	End if
	
	if day(ldh_Parametro) = ll_nr_dia_carga_completa and ( ldh_carga_completa <> ldh_Parametro or isnull(ldh_carga_completa) ) Then
		lb_carga_completa = True
	ENd if
	
	if Not isnull( ldh_prox_carga_completa ) and ldh_prox_carga_completa <= ldh_Parametro Then
		lb_carga_completa = True
	ENd if
	
	if lb_carga_completa = false Then
	
		// Verifica se a loja j$$HEX1$$e100$$ENDHEX$$ come$$HEX1$$e700$$ENDHEX$$ou a trabalhar no dia
		select count(*)
		Into :ll_existe
		from resumo_movimento_estoque r 
		where r.dh_resumo >= (select dh_movimentacao from parametro where id_parametro = '1')
			and r.cd_filial = :ll_cd_filial
		Using SqlCa;
		
		if sqlca.sqlcode = -1 then
			ls_log = this.classname( ) + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_saldo_filial ~n' + 'Problemas ao consultar a tabela "parametro_geral": ~nErro: ' + sqlca.sqlerrtext
			Return false
		end if
		
		// Se ainda n$$HEX1$$e300$$ENDHEX$$o come$$HEX1$$e700$$ENDHEX$$ou a efetuar vendas
		If ll_existe = 0 Then
			// S$$HEX1$$f300$$ENDHEX$$ autualiza uma vez caso a loja ainda n$$HEX1$$e300$$ENDHEX$$o esteja aberta
			// Controle feito para atualizar apenas uma vez o saldo caso a loja ainda n$$HEX1$$e300$$ENDHEX$$o tenha come$$HEX1$$e700$$ENDHEX$$ado a vender
			If ldh_Atualizacao_Saldo >= ldh_Parametro Then
				
				//Atualiza a data de execucao para nao ficar como parado no monitor:
				Update ecommerce_log_resumo
				Set dh_inicio = :ldh_Parametro, dh_termino = :ldh_Parametro, id_situacao = 'P', nr_atualizacao_log = 0
				where id_ecommerce = '2'
				and cd_filial = :ll_cd_filial
				and cd_tipo_log = 5;
				
				if sqlca.sqlcode = -1 then
					If Not gf_ge501_rollback(SQLCA) Then Return False
					ls_log = this.classname( ) + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_saldo_filial ~n' + 'Problemas ao atualizar a tabela "ecommerce_log_resumo": ~nErro: ' + sqlca.sqlerrtext
					Return false
				end if
				
				If Not gf_ge501_commit(SQLCA) Then Return False
				
				Continue
			End If
		End If
	
	ENd if
	
	ll_existe = 0
	
	//Verifica se o processo de atualizacao de saldo esta sendo executado para a filial:
	select count(*)
	into :ll_existe
	from ecommerce_log_resumo
	where id_ecommerce = '2'
	and cd_filial = :ll_cd_filial
	and cd_tipo_log = 5
	and id_situacao = 'C';
	
	if sqlca.sqlcode = -1 then
		ls_log = this.classname( ) + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_saldo_filial ~n' + 'Problemas ao consultar a tabela "ecommerce_log_resumo": ~nErro: ' + sqlca.sqlerrtext
		Return false
	end if
	
	if ll_existe > 0 and not isnull(ll_existe) Then
		Continue
	ENd if
	
	if ll_contador >= ll_total_executando Then
		
		Do 
			
			Sleep(5)
				
			this._of_verifica_executando( ls_nome_interface,  ll_total_executando, ref ll_prox_execucao, ref ls_Nome_Janela )
				
		Loop While ll_prox_execucao = 0
		
	Else
		ll_prox_execucao++
		ls_Nome_Janela =  ls_nome_interface + ' - [' + String(ll_prox_execucao) + ']'
	ENd if
	
	if lb_carga_completa = True then
		ls_nome_janela = ls_nome_janela + ' - TOTAL'
	End if
	
	ls_parametro =  String(ll_cd_filial) + '/' + ls_id_rede + '/' + ls_nome_janela

	Run("C:\Sistemas\EX\Exe\ex.exe /AUTO/VXSM/" + ls_parametro  )
	
	ll_contador++
	
Next

return true
end function

public function boolean of_processa_saldo_filial (long pl_cd_filial, string ps_id_rede);uo_ge501_saldo_filial luo_saldo
	
luo_saldo = create uo_ge501_saldo_filial

luo_saldo.of_processa_atualizacao_saldo( ps_id_rede, pl_cd_filial )

destroy(luo_saldo)


return true
end function

public function boolean of_situacao_ecommerce (ref string ps_situacao, ref string ps_log);string ls_retorno

select id_situacao
into :ls_retorno
from ecommerce
where id_ecommerce = '2';

if sqlca.sqlcode = -1 then
	ps_log = 'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_situacao_ecommerce ~n' + 'Problemas ao consultar a tabela "ecommerce": ~n' + sqlca.sqlerrtext
	return false
end if

ps_situacao = ls_retorno

return true
end function

public function boolean of_processa_saldo_principal ();long ll_cd_filial, ll_for, ll_linhas
string ls_rede_filial

uo_ge501_saldo_principal luo_saldo

dc_uo_ds_base lds_filiais

luo_saldo = create uo_ge501_saldo_principal

lds_filiais = create dc_uo_ds_base

if not lds_filiais.of_changedataobject( 'ds_ge501_filiais_rede' ) Then
	Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_saldo_principal ~n' + 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ds_ge501_filiais_rede')
	return false
end if
	
ll_linhas = lds_filiais.retrieve( )
if ll_linhas < 0 Then
	Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_saldo_principal ~n' + 'Problemas ao consultar o banco de dados: ~n' + sqlca.is_lasterrortext )
	return false
end if

for ll_for = 1 to ll_linhas
	
	ll_cd_filial = lds_filiais.object.cd_filial_ecommerce[ll_for]
	ls_rede_filial = lds_filiais.object.id_rede_filial[ll_for]
	
	// FA (Farmagora) n$$HEX1$$e300$$ENDHEX$$o possui lojas franquias ou seller, somente a loja principal
	//if ls_rede_filial = 'FA' Then Continue
	
	luo_saldo.of_processa_atualizacao_saldo( ll_cd_filial, ls_rede_filial )
	
next

destroy(luo_saldo)
end function

public function boolean of_processa_integracao_vtex (long pl_tipo_interface);return this.of_processa_integracao_vtex( pl_tipo_interface, '', 0)
end function

public function boolean of_processa_ean ();uo_ge501_ean luo_ean

luo_ean = create uo_ge501_ean

If not luo_ean.of_processa_atualizacao_ean( is_rede_ecommerce ) then return false

destroy(luo_ean)

return true
end function

public function boolean of_atualiza_produtos ();long ll_cd_filial, ll_for, ll_linhas
string ls_rede_filial

boolean lb_executa_marca=True
boolean lb_executa_produto=True
boolean lb_executa_sku=True
boolean lb_executa_ean=True

dc_uo_ds_base lds_filiais

lds_filiais = create dc_uo_ds_base

if not lds_filiais.of_changedataobject( 'ds_ge501_filiais_rede' ) Then
	Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_produtos ~n' + 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ds_ge501_filiais_rede')
	return false
end if
	
if Not this.of_valida_situacao_interface( 1 ) Then lb_executa_marca = false
if Not this.of_valida_situacao_interface( 2 ) Then lb_executa_produto = false
if Not this.of_valida_situacao_interface( 3 ) Then lb_executa_sku = false
if Not this.of_valida_situacao_interface( 6 ) Then lb_executa_ean = false
	
if lb_executa_marca = false and lb_executa_produto = false and lb_executa_sku = false and lb_executa_ean = false then return true
	
ll_linhas = lds_filiais.retrieve( )
if ll_linhas < 0 Then
	Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_produtos ~n' + 'Problemas ao consultar o banco de dados: ~n' + sqlca.is_lasterrortext )
	return false
end if

for ll_for = 1 to ll_linhas
	
	is_rede_ecommerce = lds_filiais.object.id_rede_filial[ll_for]
	
	if lb_executa_marca = True then
		if Not this.of_processa_marca( ) Then return false
	ENd if
	
	if lb_executa_produto = True then
		if Not this.of_processa_produto( 0 ) Then return false
	End if
	
	if lb_executa_sku = True then
		if Not this.of_processa_sku( 0 ) Then return false
	End if
	
	if lb_executa_ean = True then
		if Not this.of_processa_ean( ) Then return false
	End if
	
next

destroy(lds_filiais)
end function

public function boolean of_processa_pedido_nsu ();uo_ge501_pedido_nsu luo_nsu
luo_nsu = create uo_ge501_pedido_nsu

luo_nsu.of_processa_pedido_nsu( is_rede_ecommerce)
	
destroy(luo_nsu)

Return True
end function

public function boolean of_processa_saldo_site ();long ll_linhas
long ll_total_executando
long ll_cd_filial
long ll_for
long ll_qt_executando
long ll_prox_execucao

string ls_log
string ls_id_rede
string ls_nome_janela
string ls_parametro
string ls_nr_exportacao_saldo
string ls_nome_interface

dc_uo_ds_base lds_filiais

lds_filiais = create dc_uo_ds_base
	
if not lds_filiais.of_changedataobject( 'ds_ge501_filiais_ecommerce' ) Then
	ls_log = this.classname() + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_saldo_filial ~n' + 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ds_ge501_filiais_ecommerce'
	return false
end if
	
ll_linhas = lds_filiais.retrieve( )

if ll_linhas < 0 Then
	ls_log = this.classname( ) + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_saldo_filial ~n' + 'Problemas ao consultar o banco de dados na seguinte datawindow: ds_ge501_filiais_ecommerce ~nErro: ' + sqlca.is_lasterrortext
	return false
end if

//lojas simultaneas
Select vl_parametro 
into :ls_nr_exportacao_saldo
from parametro_geral
where cd_parametro = 'NR_EXPORTACAO_VTEX_SALDO';

if sqlca.sqlcode = -1 then
	ls_log = this.classname( ) + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_saldo_filial ~n' + 'Problemas ao consultar a tabela "parametro_geral": ~nErro: ' + sqlca.sqlerrtext
	Return false
end if

ll_total_executando = long(ls_nr_exportacao_saldo)

ls_nome_interface = 'EX - INTERFACE SALDO SITE VTEX'

for ll_for = 1 to ll_linhas

	ll_cd_filial = lds_filiais.object.cd_filial[ll_for]	
	ls_id_rede = lds_filiais.object.id_rede_filial[ll_for]	
	
	Do 
		
		Sleep(1)
			
		this._of_verifica_executando( ls_nome_interface, ll_total_executando, ref ll_prox_execucao, ref ls_nome_janela )
			
	Loop While ll_prox_execucao = 0

	ls_parametro =  String(ll_cd_filial) + '/' + ls_id_rede + '/' + ls_nome_janela

	Run("C:\Sistemas\EX\Exe\ex.exe /AUTO/VXSS/" + ls_parametro  )
	
Next

return true
end function

public function boolean of_processa_saldo_site (long pl_cd_filial, string ps_id_rede);uo_ge501_saldo_site luo_saldo
	
luo_saldo = create uo_ge501_saldo_site

If not luo_saldo.of_processa_saldo_site( ps_id_rede, pl_cd_filial ) then return false

destroy(luo_saldo)


return true
end function

public function boolean of_processa_pedido_feed ();boolean lb_encontrou_registros = false

dc_uo_ds_base lds_filiais

uo_ge501_pedido_feed luo_feed
luo_feed = create uo_ge501_pedido_feed
	
//Entra em Loop at$$HEX1$$e900$$ENDHEX$$ n$$HEX1$$e300$$ENDHEX$$o houverem mais pedidos a serem importados.
Do 
	if Not luo_feed.of_processa_atualizacao_pedido( is_rede_ecommerce, ref lb_encontrou_registros ) Then Return False
	
Loop While lb_encontrou_registros = True
	
destroy(luo_feed)

Return True	
end function

public function boolean of_processa_pedido_baixa ();uo_ge501_pedido_ecommerce luo_pedido
luo_pedido = create uo_ge501_pedido_ecommerce

luo_pedido.of_processa_atualizacao_pedido( is_rede_ecommerce )

destroy(luo_pedido)

Return True
end function

public function boolean of_processa_pedido_status ();uo_ge501_pedido_status luo_vtex
luo_vtex = create uo_ge501_pedido_status

luo_vtex.of_processa_atualizacao_status( is_rede_ecommerce)
	
destroy(luo_vtex)

Return True
end function

public function boolean of_processa_pedido_rastreio ();uo_ge501_pedido_status luo_vtex_rast
luo_vtex_rast = create uo_ge501_pedido_status

luo_vtex_rast.of_processa_atualizacao_rastreio( is_rede_ecommerce )

destroy(luo_vtex_rast)

Return True
end function

public function boolean of_processa_pedido_filial ();uo_ge501_pedido_loja luo_loja
luo_loja = create uo_ge501_pedido_loja

luo_loja.of_processa_atualizacao_pedido(is_rede_ecommerce )

destroy(luo_loja)

Return True
end function

public function boolean of_atualiza_pedidos ();long ll_cd_filial, ll_for, ll_linhas
string ls_rede_filial, ls_id_bloquear_feeed_fa

boolean lb_executa_feed=True
boolean lb_executa_baixa=True
boolean lb_executa_filial=True

//dc_uo_ds_base lds_filiais

//lds_filiais = create dc_uo_ds_base

if Not this.of_valida_situacao_interface( 7 ) Then lb_executa_feed = false
if Not this.of_valida_situacao_interface( 8 ) Then lb_executa_baixa = false
if Not this.of_valida_situacao_interface( 9 ) Then lb_executa_filial = false

if lb_executa_feed = false and lb_executa_baixa = false and lb_executa_filial = false then return True

//if not lds_filiais.of_changedataobject( 'ds_ge501_filiais_rede' ) Then
//	Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_produtos ~n' + 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ds_ge501_filiais_rede')
//	return false
//end if
	
//lds_filiais.of_appendwhere( "er.id_rede_filial = '" + is_rede_ecommerce + "'", 1)	
	
//ll_linhas = lds_filiais.retrieve( )
//if ll_linhas < 0 Then
//	Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_produtos ~n' + 'Problemas ao consultar o banco de dados: ~n' + sqlca.is_lasterrortext )
//	return false
//end if

//for ll_for = 1 to ll_linhas
//	
//	is_rede_ecommerce = lds_filiais.object.id_rede_filial[ll_for]
//	

	if lb_executa_feed = True then
		if is_rede_ecommerce = 'FA' Then
			
			select vl_parametro
			into :ls_id_bloquear_feeed_fa
			from parametro_geral where cd_parametro = 'ID_INTERFACE_ECOMMERCE_BAIXA_FA';
			
			if ls_id_bloquear_feeed_fa <> 'S' or isnull(ls_id_bloquear_feeed_fa) Then
				This.of_processa_pedido_feed()
			ENd if
			
		Else
			This.of_processa_pedido_feed()
		End if
	ENd if
	
	if lb_executa_baixa = True then
		This.of_processa_pedido_baixa()
		//This.of_processa_pedido_baixa_gototem()
	End if
	
	This.of_processa_pedido_baixa_gototem()
	
	if lb_executa_filial = True then
		
		If is_rede_ecommerce = 'DC' Then
			is_rede_ecommerce = 'MP'
			This.of_processa_pedido_filial()
			
			is_rede_ecommerce = 'DC'
			
		End If
		
		This.of_processa_pedido_filial()
		
	ENd if
	
//next

//destroy(lds_filiais)
end function

public function boolean of_atualiza_filial ();long ll_cd_filial, ll_for, ll_linhas

dc_uo_ds_base lds_filiais

lds_filiais = create dc_uo_ds_base

if not lds_filiais.of_changedataobject( 'ds_ge501_filiais_rede' ) Then
	Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_produtos ~n' + 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ds_ge501_filiais_rede')
	return false
end if
	
ll_linhas = lds_filiais.retrieve( )

if ll_linhas < 0 Then
	Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_produtos ~n' + 'Problemas ao consultar o banco de dados: ~n' + sqlca.is_lasterrortext )
	return false
end if

for ll_for = 1 to ll_linhas

	uo_ge501_filial luo
	luo = create uo_ge501_filial
	
	luo.of_processa_atualizacao_filial(lds_filiais.object.id_rede_filial[ll_for])
	
	destroy(luo)
	
next

destroy(lds_filiais)
end function

public function boolean of_atualiza_devolucao ();long ll_cd_filial, ll_for, ll_linhas

dc_uo_ds_base lds_filiais

lds_filiais = create dc_uo_ds_base

if not lds_filiais.of_changedataobject( 'ds_ge501_filiais_rede' ) Then
	Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_devolucao ~n' + 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ds_ge501_filiais_rede')
	return false
end if
	
ll_linhas = lds_filiais.retrieve( )

if ll_linhas < 0 Then
	Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_devolucao ~n' + 'Problemas ao consultar o banco de dados: ~n' + sqlca.is_lasterrortext )
	return false
end if

for ll_for = 1 to ll_linhas

	uo_ge501_pedido_devolucao luo
	luo = create uo_ge501_pedido_devolucao
	
	luo.of_processa_devolucao_pedido(lds_filiais.object.id_rede_filial[ll_for])
	
	destroy(luo)
	
next

destroy(lds_filiais)
end function

public function boolean of_processa_receita ();String ls_Rede

uo_ge501_receita_manip luo_vtex
luo_vtex = create uo_ge501_receita_manip

luo_vtex.of_processa_atualizacao_receita( 'DC' )

destroy(luo_vtex)

return true
end function

public function boolean of_atualiza_pedidos_status ();boolean lb_executa_status=True
boolean lb_executa_rastreio=True
boolean lb_executa_nsu=True

if Not this.of_valida_situacao_interface( 12 ) Then lb_executa_status = false
if Not this.of_valida_situacao_interface( 15 ) Then lb_executa_rastreio = false
if Not this.of_valida_situacao_interface( 14 ) Then lb_executa_nsu = false

if is_rede_ecommerce = 'DC' then
				
	is_rede_ecommerce = 'MP'
	
	if lb_executa_status = True Then
		This.of_processa_pedido_status()
	ENd if
	
	if lb_executa_rastreio = True Then
		This.of_processa_pedido_rastreio()
	ENd if
	
	if lb_executa_nsu = True Then
		This.of_processa_pedido_nsu()
	ENd if
	
	is_rede_ecommerce = 'DC'
	
end if	

if lb_executa_status = True Then
	This.of_processa_pedido_status()
ENd if

if lb_executa_rastreio = True Then
	This.of_processa_pedido_rastreio()
ENd if

if lb_executa_nsu = True Then
	This.of_processa_pedido_nsu()	
End if


return true
end function

private function boolean _of_verifica_executando (string ps_nome_interface, long pl_qt_total, ref long pl_prox_executar, ref string ps_nome_janela);String ls_Janela_Ativa 
long ll_controles_executando, ll_for

pl_prox_executar=0

for ll_for = 1 to pl_qt_total

	ls_janela_ativa = ps_nome_interface + ' - [' + String(ll_for) + ']'
	
	If Not gvo_aplicacao.of_appisrunning(ls_Janela_Ativa) Then
		pl_prox_executar = ll_for
		ps_nome_janela = ls_Janela_Ativa
		Exit
	End If
	
Next

return true
end function

public function boolean of_atualiza_saldo_rede (long pl_cd_filial, string ps_id_rede);
uo_ge501_saldo_rede luo_interface

luo_interface = create uo_ge501_saldo_rede

luo_interface.of_processa_atualizacao_saldo(pl_cd_filial, ps_id_rede)

Destroy(luo_interface)

return true
end function

public function boolean of_processa_pedido_baixa_gototem ();long ll_linhas, ll_for, ll_cd_filial

uo_ge501_pedido_feed_gototem luo_feed
uo_ge501_pedido_ecommerce luo_pedido
dc_uo_ds_base lds_filiais

lds_filiais = create dc_uo_ds_base

if not lds_filiais.of_changedataobject( 'ds_ge501_filiais_pedido_gototem' ) Then
	Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_pedido_baixa_gototem ~n' + 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ds_ge501_filiais_pedido_gototem')
	return false
end if
	
ll_linhas = lds_filiais.retrieve( is_rede_ecommerce )
if ll_linhas < 0 Then
	Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_pedido_baixa_gototem ~n' + 'Problemas ao consultar o banco de dados: ~n' + sqlca.is_lasterrortext )
	return false
end if

for ll_for = 1 to ll_linhas
	
	ll_cd_filial = lds_filiais.object.cd_filial[ll_for]
	
	//Feed
	luo_feed = create uo_ge501_pedido_feed_gototem
	luo_feed.of_processa_atualizacao_pedido( is_rede_ecommerce, ll_cd_filial, 'GTM')	
	destroy(luo_pedido)
	
	//Baixa de pedidos
	luo_pedido = create uo_ge501_pedido_ecommerce
	luo_pedido.of_processa_atualizacao_pedido( is_rede_ecommerce, 'GTM', ll_cd_filial)
	destroy(luo_pedido)
	
next

destroy(lds_filiais)

return true

end function

public function boolean of_processa_pedido_rastreamento ();long ll_for, ll_linhas
string ls_rede_filial

Try
	
	uo_ge501_pedido_rastreamento luo_rastreio
	dc_uo_ds_base lds_filiais
	
	lds_filiais = create dc_uo_ds_base
	luo_rastreio = create  uo_ge501_pedido_rastreamento
	
	if not lds_filiais.of_changedataobject( 'ds_ge501_filiais_rede' ) Then
		Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', this.classname( ) + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_pedido_rastreamento ~n' + 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ds_ge501_filiais_rede')
		return false
	end if
		
	ll_linhas = lds_filiais.retrieve( )
	if ll_linhas < 0 Then
		Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', this.classname( ) +  'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_pedido_rastreamento ~n' + 'Problemas ao consultar o banco de dados: ~n' + sqlca.is_lasterrortext )
		return false
	end if
	
	for ll_for = 1 to ll_linhas
		
		ls_rede_filial = lds_filiais.object.id_rede_filial[ll_for]
		
		luo_rastreio.of_processa_pedido_rastreamento( ls_rede_filial )
		
	next

Finally	
	destroy(lds_filiais)
End Try

return true
end function

public function boolean of_verifica_hora_inicio_integracao (ref boolean pb_valido, ref string ps_log);string ls_hora
long ll_hora_inicio, ll_hora_atual
Datetime ldt_data

//Verifica a hora de inicio da integracao
Select vl_parametro, getdate()
into :ls_hora, :ldt_data
from parametro_geral
where cd_parametro = 'NR_HORA_INICIO_INTEGRACAO_ECOMMERCE';

if sqlca.sqlcode = -1 then
	ps_log = this.classname( ) + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_verifica_hora_inicio_integracao ~n' + 'Problemas ao consultar a tabela "parametro_geral": ~nErro: ' + sqlca.sqlerrtext
	Return false
end if

ll_hora_inicio = long(ls_hora)
if isnull(ll_hora_inicio) then ll_hora_inicio = 0

ll_hora_atual = hour(time(ldt_data))
if isnull(ll_hora_atual) then ll_hora_atual = 0

if ll_hora_atual >= ll_hora_inicio then
	pb_valido = true
Else
	pb_valido = false
ENd if

return true
end function

public function boolean of_valida_situacao_interface (long pl_cd_interface);long ll_existe

select count(*)
into :ll_existe
from ecommerce_interface ei
	inner join ecommerce_interface_plataforma eip on eip.cd_interface = ei.cd_interface
where ei.id_situacao = 'A'
and eip.id_situacao = 'A'
and eip.id_tecnologia = 'PB'
and ei.cd_interface = :pl_cd_interface
and eip.id_ecommerce = '2';

if ll_existe > 0 and not isnull(ll_existe) then
	Return true
Else
	Return false
End if

end function

public function boolean of_processa_pedido_status_rapido ();uo_ge501_pedido_status luo_vtex
luo_vtex = create uo_ge501_pedido_status

luo_vtex.il_cd_tipo = 25

luo_vtex.of_processa_atualizacao_status( is_rede_ecommerce)
	
destroy(luo_vtex)

Return True
end function

public function boolean of_atualiza_saldo_rede (string ps_tipo);long ll_cd_filial, ll_for, ll_linhas, ll_total_executando, ll_prox_execucao
string ls_rede_filial
string ls_nr_exportacao_saldo
string ls_nome_interface, ls_Nome_Janela, ls_parametro
string ls_log 

uo_ge501_saldo_rede luo_saldo_rede

dc_uo_ds_base lds_filiais

//if ps_tipo = 'CD' Then
	
	luo_saldo_rede = create uo_ge501_saldo_rede 
	if Not luo_saldo_rede.of_atualiza_saldo_cd( ref ls_log ) Then 
		Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', this.classname( ) + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_saldo_rede ~n' + ls_log)
		return false
	End if
//End if

lds_filiais = create dc_uo_ds_base

if not lds_filiais.of_changedataobject( 'ds_ge501_filiais_rede_sld_rede' ) Then
	Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', this.classname( ) + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_saldo_rede ~n' + 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ds_ge501_filiais_rede_sld_rede')
	return false
end if
	
//if ps_tipo = 'CD'	Then
//	lds_filiais.of_appendwhere( 'erf.cd_filial_hub is null' )
//Else
//	lds_filiais.of_appendwhere( 'erf.cd_filial_hub is not null' )
//ENd if
	
//lojas simultaneas
Select vl_parametro 
into :ls_nr_exportacao_saldo
from parametro_geral
where cd_parametro = 'NR_EXPORTACAO_VTEX_SALDO';

if sqlca.sqlcode = -1 then
	Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', this.classname( ) + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_saldo_rede ~n' + 'Problemas ao consultar a tabela "parametro_geral": ~nErro: ' + sqlca.sqlerrtext )
	Return false
end if	
	
ll_total_executando = long(ls_nr_exportacao_saldo)

if ps_tipo = 'CD'	Then
	ls_nome_interface = Upper('Interface VTEX - Atualiza$$HEX2$$e700e300$$ENDHEX$$o Saldo Rede - CD')
Else
	ls_nome_interface = Upper('Interface VTEX - Atualiza$$HEX2$$e700e300$$ENDHEX$$o Saldo Rede')
End if
	
ll_linhas = lds_filiais.retrieve( )
if ll_linhas < 0 Then
	Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', this.classname( ) +  'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_saldo_rede ~n' + 'Problemas ao consultar o banco de dados: ~n' + sqlca.is_lasterrortext )
	return false
end if

for ll_for = 1 to ll_linhas
	
	ll_cd_filial = lds_filiais.object.cd_filial_ecommerce[ll_for]
	ls_rede_filial = lds_filiais.object.id_rede_filial[ll_for]
	
	Do 
		
		Sleep(1)
			
		this._of_verifica_executando( ls_nome_interface,  ll_total_executando, ref ll_prox_execucao, ref ls_Nome_Janela )
			
	Loop While ll_prox_execucao = 0
	
	ls_parametro =  String(ll_cd_filial) + '/' + ls_rede_filial + '/' + ls_nome_janela

	Run("C:\Sistemas\EX\Exe\ex.exe /AUTO/VXSE/" + ls_parametro  )
	
next

destroy(lds_filiais)
end function

public function boolean of_atualiza_saldo_rede ();return of_atualiza_saldo_rede('DB')
end function

public function boolean of_processa_pedido_baixa_memed ();long ll_linhas, ll_for, ll_cd_filial

uo_ge501_pedido_feed_gototem luo_feed
uo_ge501_pedido_ecommerce luo_pedido
dc_uo_ds_base lds_filiais

lds_filiais = create dc_uo_ds_base

if not lds_filiais.of_changedataobject( 'ds_ge501_filiais_pedido_memed' ) Then
	Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_pedido_baixa_memed ~n' + 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ds_ge501_filiais_pedido_memed')
	return false
end if
	
ll_linhas = lds_filiais.retrieve( is_rede_ecommerce )
if ll_linhas < 0 Then
	Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_pedido_baixa_memed ~n' + 'Problemas ao consultar o banco de dados: ~n' + sqlca.is_lasterrortext )
	return false
end if

for ll_for = 1 to ll_linhas
	
	ll_cd_filial = lds_filiais.object.cd_filial[ll_for]
	
	//Feed
	luo_feed = create uo_ge501_pedido_feed_gototem
	luo_feed.of_processa_atualizacao_pedido( is_rede_ecommerce, ll_cd_filial, 'MMD')	
	destroy(luo_pedido)
	
	//Baixa de pedidos
	luo_pedido = create uo_ge501_pedido_ecommerce
	luo_pedido.of_processa_atualizacao_pedido( is_rede_ecommerce, 'MMD', ll_cd_filial)
	destroy(luo_pedido)
	
next

destroy(lds_filiais)

return true

end function

on uo_ge501_integracao_vtex.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge501_integracao_vtex.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

