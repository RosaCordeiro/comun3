HA$PBExportHeader$uo_ge501_saldo_site.sru
forward
global type uo_ge501_saldo_site from nonvisualobject
end type
end forward

global type uo_ge501_saldo_site from nonvisualobject
end type
global uo_ge501_saldo_site uo_ge501_saldo_site

type variables
string is_objeto
string is_id_ecommerce = '2' //VTEX
string is_id_interface = 'api/logistics/pvt/inventory/skus/'
long il_cd_tipo = 17

end variables

forward prototypes
public function boolean of_busca_saldo (string ps_texto, ref long pl_qt_saldo)
public function boolean of_processa_saldo_site (string ps_rede_filial, long pl_cd_filial, long pl_cd_produto)
public function boolean of_processa_saldo_site (string ps_rede_filial, long pl_cd_filial)
end prototypes

public function boolean of_busca_saldo (string ps_texto, ref long pl_qt_saldo);uo_ge073_json luo_gera_json

luo_gera_json = Create uo_ge073_json 
	
pl_qt_saldo = long(luo_gera_json.of_busca_conteudo_campo_vtex(ps_texto, 'totalQuantity') )

if isnull(pl_qt_saldo) Then pl_qt_saldo = 0

destroy(luo_gera_json)

return true
end function

public function boolean of_processa_saldo_site (string ps_rede_filial, long pl_cd_filial, long pl_cd_produto);String ls_json
String ls_retorno
String ls_Chave_Nula
String ls_MSG_Nula
String ls_Log
String ls_Situacao
String ls_cd_sku
String ls_id_registro_log

long ll_linhas
Long ll_for
Long ll_Seq_Log
Long ll_existe
Long ll_cd_produto
Long ll_qt_saldo
Long ll_cd_filial

boolean lb_sucesso=false
datetime ldt_inicio, ldt_termino, ldt_atual

DateTime ldh_Data_Nula
DateTime ldh_log_inicio

uo_ge501_comum luo_comum_vtex

SetNull(ls_Chave_Nula)
SetNull(ls_MSG_Nula)
SetNull(ldh_Data_Nula)

dc_uo_ds_base lds_produtos

try 

	ll_cd_filial = pl_cd_filial
	
	Open(w_Aguarde)
	
	w_Aguarde.Title = "Vtex - Saldo Site (Site -> ERP) - Filial: " + string(pl_cd_filial)

	luo_comum_vtex = create uo_ge501_comum
	lds_produtos = create dc_uo_ds_base
	
	ldh_log_inicio = gf_getserverdate()
	ls_situacao = 'P'
	
	setnull(ls_id_registro_log)
	luo_comum_vtex.of_grava_log_historico(ref ls_id_registro_log, pl_cd_filial, il_cd_tipo, ldh_log_inicio, ldh_Data_Nula, 'C', 0, ref ls_log )
	
	//Carrega os parametros e busca o c$$HEX1$$f300$$ENDHEX$$digo da filial vinculado a rede.
	if Not luo_comum_vtex.of_parametros_ecommerce_filial( pl_cd_filial, ps_rede_filial, is_id_ecommerce, ref ls_log ) Then return false
	
	if not lds_produtos.of_changedataobject( 'ds_ge501_saldo_site_produto' , false) Then
		ls_Log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_saldo_site ~n' + 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ds_ge501_saldo_site_produto'
		return false
	end if

	//Se foi passado um produto espec$$HEX1$$ed00$$ENDHEX$$fico:
	if pl_cd_produto > 0 Then
		lds_produtos.of_appendwhere( 'a.cd_produto = ' + string(pl_cd_produto) )
	end if

	ll_linhas = lds_produtos.retrieve(is_id_ecommerce, ps_rede_filial)

	w_aguarde.uo_progress.of_setmax(ll_Linhas)

	If ll_linhas > 0 Then
		luo_comum_vtex.il_qt_item_enviado_site = ll_linhas
		// Grava in$$HEX1$$ed00$$ENDHEX$$cio do processo
		If Not luo_comum_vtex.of_grava_log(pl_cd_filial, il_cd_tipo, ls_Chave_Nula, 'C', ls_MSG_Nula, gf_getserverdate(), gf_getserverdate(), ref ls_Log, ref ll_Seq_Log ) Then Return False
	End If

	ldt_atual = gf_getserverdate()

	for ll_for = 1 to ll_linhas
		
		ls_cd_sku = lds_produtos.object.cd_sku[ll_for]
		ll_cd_produto = lds_produtos.object.cd_produto[ll_for]
		
//		If ll_cd_produto <> 665868 Then
//			w_aguarde.uo_progress.of_setprogress(ll_for)
//			Continue
//		End If

		luo_comum_vtex.il_cd_produto = ll_cd_produto

		//Busca o saldo no site.
		luo_comum_vtex.of_get( is_id_interface + ls_cd_sku , ref ls_retorno, ref ls_Log )

		If ls_Log <> '' and not isnull(ls_Log) Then
			luo_comum_vtex.of_grava_log_item( pl_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
			ls_Situacao = 'E'
			ls_Log = ''
			w_aguarde.uo_progress.of_setprogress(ll_for)
			Continue
		end if

		//L$$HEX1$$ea00$$ENDHEX$$ a lista de pedidos e salva as informa$$HEX2$$e700f500$$ENDHEX$$es necess$$HEX1$$e100$$ENDHEX$$rias na ids_pedidos.
		of_busca_saldo(ls_retorno, ref ll_qt_saldo)
		
		luo_comum_vtex.idc_qt_saldo = ll_qt_saldo
		
		Select count(*)
		into :ll_existe
		from ecommerce_prd_filial
		where cd_filial = :pl_cd_filial
			and cd_produto = :ll_cd_produto
			and id_ecommerce = :is_id_ecommerce
			and id_rede_filial = :ps_rede_filial;
		
		if sqlca.sqlcode = -1 then
				ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_saldo_site ' + 'Erro: ' + sqlca.sqlerrtext
				return false
			end if
		
		if ll_existe > 0 Then
			
			update ecommerce_prd_filial
			set qt_saldo_site = :ll_qt_saldo, dh_baixa_saldo_site = :ldt_atual
			where cd_filial = :pl_cd_filial
			and cd_produto = :ll_cd_produto
			and id_ecommerce = :is_id_ecommerce
			and id_rede_filial = :ps_rede_filial;
		
			if sqlca.sqlcode = -1 then
				ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_saldo_site ' + 'Erro: ' + sqlca.sqlerrtext
				return false
			end if
		
			//Sqlca.of_commit( )
			If Not gf_ge501_commit(SQLCA) Then Return False
		
		end if
		
		//Grava no log como processado com $$HEX1$$ea00$$ENDHEX$$xito.
		if Not luo_comum_vtex.of_grava_log_item(pl_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log ) Then Return false
		
		w_aguarde.uo_progress.of_setprogress(ll_for)	
	next
			
	
	update ecommerce_rede_filial
	set dh_baixa_saldo_site = :ldt_atual
	where id_ecommerce = :is_id_ecommerce
	and id_rede_filial = :ps_rede_filial
	and cd_filial = :pl_cd_filial;	
	
	if sqlca.sqlcode = -1 then
		ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_saldo_site ' + 'Erro: ' + sqlca.sqlerrtext
		return false
	end if
	
	//Sqlca.of_commit( )
	If Not gf_ge501_commit(SQLCA) Then Return False
	
	lb_sucesso = True

Finally
	
	if Not lb_sucesso then 
		
		ls_situacao = 'E'
		
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
	
	luo_comum_vtex.of_grava_log_historico(ref ls_id_registro_log, pl_cd_filial, il_cd_tipo, ldh_log_inicio, gf_getserverdate(), ls_situacao, ll_Seq_Log, ref ls_log )
	
	destroy(lds_produtos)
	destroy(luo_comum_vtex)
	
	Close(w_Aguarde)
	
End try

return true
end function

public function boolean of_processa_saldo_site (string ps_rede_filial, long pl_cd_filial);return of_processa_saldo_site(ps_rede_filial, pl_cd_filial, 0 )
end function

on uo_ge501_saldo_site.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge501_saldo_site.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;is_objeto = 'Objeto: ' + this.classname() + '~n'
end event

