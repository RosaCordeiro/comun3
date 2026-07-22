HA$PBExportHeader$uo_ge505_pedido_status.sru
forward
global type uo_ge505_pedido_status from nonvisualobject
end type
end forward

global type uo_ge505_pedido_status from nonvisualobject
end type
global uo_ge505_pedido_status uo_ge505_pedido_status

type variables
uo_transacao_online ivo_Conecta_Odbc
dc_uo_transacao itr_Filial
dc_uo_odbc ivo_Odbc

string is_datasource

string is_objeto
string is_id_ecommerce = '3' //Ifood
string is_rede_filial
String is_ODBC_Desenv

long il_cd_tipo = 13
long il_cd_filial
long il_Filial_Desenv
long il_cd_mensagem_email = 214
long il_cd_filial_pedido
long il_nr_pedido

Boolean ib_Desenv = False
Boolean ib_usa_pdv_java = False

dc_uo_ds_base ids_pedidos

end variables

forward prototypes
public function boolean of_desconecta_filial ()
public function boolean of_processa_atualizacao_status ()
public function boolean of_busca_status_loja (long pl_cd_filial, string ps_nr_pedido_ecommerce, ref string ps_status, ref string ps_log)
public function boolean of_conecta_filial (long pl_cd_filial, ref string ps_log)
public function boolean of_atualiza_pedido (string ps_status, ref string ps_log)
public function boolean of_processa_atualizacao_status (long pl_cd_filial, string ps_rede)
end prototypes

public function boolean of_desconecta_filial ();if Not isvalid(itr_filial) Then return true

If itr_Filial.of_IsConnected( ) Then
	itr_Filial.of_Disconnect( )
End If

gvo_Aplicacao.ivs_DataSource = is_DataSource

return true
end function

public function boolean of_processa_atualizacao_status ();long ll_cd_filial, ll_for, ll_linhas
string ls_rede

dc_uo_ds_base lds_filiais

lds_filiais = create dc_uo_ds_base

if not lds_filiais.of_changedataobject( 'ds_ge505_pedido_status_filial' ) Then
	Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_status ~n' + 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ds_ge505_pedido_status_filial')
	return false
end if
	
ll_linhas = lds_filiais.retrieve( is_id_ecommerce )
if ll_linhas < 0 Then
	Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_status ~n' + 'Problemas ao consultar o banco de dados: ~n' + sqlca.is_lasterrortext )
	return false
end if

for ll_for = 1 to ll_linhas
	
	ll_cd_filial = lds_filiais.object.cd_filial[ll_for]
	ls_rede = lds_filiais.object.id_rede_filial[ll_for]
	
	this.of_processa_atualizacao_status( ll_cd_filial, ls_rede )
	
next

destroy(lds_filiais)

Return True
end function

public function boolean of_busca_status_loja (long pl_cd_filial, string ps_nr_pedido_ecommerce, ref string ps_status, ref string ps_log);string ls_id_situacao

//If Not this.of_conecta_filial( pl_cd_filial, ref ps_log ) Then Return false

Select id_situacao
into :ls_id_situacao
from pedido_drogaexpress
where nr_pedido_ecommerce_site = :ps_nr_pedido_ecommerce
and id_plataforma_ecommerce = :is_id_ecommerce
Using itr_Filial;

if itr_Filial.sqlcode = -1 then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_busca_status_loja ; Problemas ao consultar a tabela "pedido_drogaexpress": ' + itr_Filial.sqlerrtext
	If Not this.of_desconecta_filial( ) Then Return false
	return false
end if

//If Not this.of_desconecta_filial( ) Then Return false

if ls_id_situacao = '' or isnull(ls_id_situacao) Then
	ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar o pedido [' + ps_nr_pedido_ecommerce + '] na filial [' + string(pl_cd_filial) + '].'
	return false
end if
		
ps_status = ls_id_situacao	
		
return true
end function

public function boolean of_conecta_filial (long pl_cd_filial, ref string ps_log);String ls_Odbc

is_DataSource = gvo_Aplicacao.ivs_DataSource

//gvb_Auto = True

//
if not isvalid(ivo_Odbc) then
	ivo_Odbc = Create dc_uo_odbc
end if

if not isvalid(itr_Filial) Then 
	itr_Filial	= Create dc_uo_Transacao
	itr_Filial.ivs_DataBase = 'ANYWHERE'
end if

if not isvalid(ivo_Conecta_Odbc) Then
	ivo_Conecta_Odbc = Create uo_transacao_online
end if

//Conectar na base da filial
If Not IsNull(is_ODBC_Desenv) and Trim(is_ODBC_Desenv) <> ''  Then
	ls_Odbc =  is_ODBC_Desenv
else
	ivo_Conecta_Odbc.of_inclui_odbc( pl_cd_filial )
	ls_Odbc = ivo_Odbc.of_Localiza( pl_cd_filial )
end if

If itr_Filial.of_IsConnected( ) Then
	itr_Filial.of_Disconnect( )
End If

if itr_Filial.of_Connect( ls_Odbc, gvo_aplicacao.is_ComputerName , false) = False Then
	ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel estabelecer conex$$HEX1$$e300$$ENDHEX$$o com a Filial: ' + string(pl_cd_filial) 
	return false
end if

Return True
end function

public function boolean of_atualiza_pedido (string ps_status, ref string ps_log);
//Atualiza na Matriz
If ps_status = 'F' Then
	
	Update pedido_ecommerce
		Set id_situacao = :ps_status, dh_faturado = getdate()
	Where cd_filial_ecommerce =:il_cd_filial
		AND nr_pedido =:il_nr_Pedido
	Using SqlCa;
	
Else
	
	Update pedido_ecommerce
		Set id_situacao = :ps_status
	Where cd_filial_ecommerce =:il_cd_filial
		AND nr_pedido =:il_nr_Pedido
	Using SqlCa;
		
ENd if

If SqlCa.SqlCode = -1 Then
	ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_pedido ; ' + 'Problemas ao atualizar a tabela "pedido_ecommerce": ' + SqlCa.sqlerrtext
	Return False
End If

Return True
end function

public function boolean of_processa_atualizacao_status (long pl_cd_filial, string ps_rede);String ls_Chave_Nula
String ls_MSG_Nula
String ls_Log
String ls_nr_pedido
String ls_id_situacao_pedido
String ls_id_registro_log
String ls_situacao

long ll_linhas
Long ll_for
Long ll_Seq_Log
Long ll_cd_filial_ant
Long ll_cd_filial_site
Long ll_nr_nf_venda

boolean lb_sucesso=false

DateTime ldh_log_inicio
DateTime ldh_Data_Nula

uo_ge505_comum luo_comum

SetNull(ls_Chave_Nula)
SetNull(ls_MSG_Nula)
SetNull(ldh_Data_Nula)

try 
	
	ldh_log_inicio = gf_getserverdate()
	ls_situacao = 'P'
	
	il_cd_filial = pl_cd_filial
	
	Open(w_Ge501_Aguarde)
	
	w_Ge501_Aguarde.Title = "Ifood - Atualiza$$HEX2$$e700e300$$ENDHEX$$o status (Loja -> Matriz)"

	luo_comum = create uo_ge505_comum
	ids_pedidos = create dc_uo_ds_base
	
	luo_comum.is_rede_ecommerce = ps_rede
	
	setnull(ls_id_registro_log)
	luo_comum.of_grava_log_historico(ref ls_id_registro_log, il_cd_filial, il_cd_tipo, ldh_log_inicio, ldh_Data_Nula, 'C', 0, ref ls_log )
	
	//Desenvolvimento
	il_Filial_Desenv 	= luo_comum.of_desenvolvimento_filial_baixa_pedido()
	is_ODBC_Desenv 	= luo_comum.of_desenvolvimento_odbc_baixa_pedido()
	
	if not ids_pedidos.of_changedataobject( 'ds_ge505_pedido_status' , false) Then
		ls_Log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_status ; ' + 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ds_ge505_pedido_status'
		return false
	end if

	ll_linhas = ids_pedidos.retrieve(is_id_ecommerce, il_cd_filial)
	
	w_Ge501_Aguarde.uo_progress.of_setmax(ll_Linhas)
	
	if ll_linhas > 0 Then
		
		luo_comum.il_qt_item_enviado_site = ll_linhas
         // Grava in$$HEX1$$ed00$$ENDHEX$$cio do processo
		If Not luo_comum.of_grava_log(il_cd_filial, il_cd_tipo, ls_Chave_Nula, 'C', ls_MSG_Nula, gf_getserverdate(), gf_getserverdate(), ref ls_Log, ref ll_Seq_Log ) Then Return False
		
		If Not IsNull(il_Filial_Desenv) Then
			il_cd_filial_pedido = il_Filial_Desenv
		Else
			il_cd_filial_pedido = il_cd_filial
		End If
		
		if Not gf_retorna_loja_pdv_novo(il_cd_filial_pedido, ref ib_usa_pdv_java, ref ls_log ) then return false
		
		if ib_usa_pdv_java = False then
			If Not this.of_conecta_filial( il_cd_filial_pedido, ref ls_log ) Then Return false
		ENd if
		
	end if
	
	for ll_for = 1 to ll_linhas
		
		luo_comum.of_limpa_variaveis( )
		
		ls_nr_pedido = ids_pedidos.object.nr_pedido_ecommerce[ll_for]
		il_nr_pedido = ids_pedidos.object.nr_pedido[ll_for]
		ll_nr_nf_venda = ids_pedidos.object.nr_nf[ll_for]
		
		luo_comum.il_qt_item_enviado_site = 1
		luo_comum.is_nr_pedido_ecommerce = ls_nr_pedido
		luo_comum.il_cd_filial_pedido = il_cd_filial_pedido
		
		w_Ge501_Aguarde.Title = "Ifood - Atualizando status (Loja -> Matriz) - "  + String(ll_for)  + " de " + STring(ll_Linhas)
		w_Ge501_Aguarde.st_msg.Text = "Pedido: " + ls_nr_pedido + " - Filial:" + String(il_cd_filial_pedido)
		
		if ib_usa_pdv_java = False Then
			
			//Busca a situa$$HEX2$$e700e300$$ENDHEX$$o do pedido na Loja
			this.of_busca_status_loja( il_cd_filial_pedido, ls_nr_pedido, ref ls_id_situacao_pedido, ref ls_log )
		
			If Not isnull(ls_log) and ls_log <> ''  Then
				luo_comum.of_envia_email(il_cd_mensagem_email, 'Status Ifood', ll_Seq_Log, 'Pedido: '  + ls_nr_pedido + ' - ' +  ls_Log, ls_nr_pedido)
				luo_comum.of_grava_log_item( il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
				If Not luo_comum.of_atualiza_ecommerce_log(il_cd_filial, ll_Seq_Log, 'E', ls_Log, gf_getserverdate(), ref ls_Log) Then Return False
				sqlca.of_RollBack( )
				w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
				ls_situacao = 'E'
				ls_log = ''
				Continue
			End If
		Else
			
			ls_id_situacao_pedido = ids_pedidos.object.id_situacao[ll_for]
			
		ENd if
		
		if ls_id_situacao_pedido = 'P' and ll_nr_nf_venda > 0 Then
			ls_id_situacao_pedido = 'F'
		End if
		
		//Se n$$HEX1$$e300$$ENDHEX$$o houve altera$$HEX2$$e700e300$$ENDHEX$$o no status do pedido, passa para o pr$$HEX1$$f300$$ENDHEX$$ximo.
		if ls_id_situacao_pedido = 'A' or ls_id_situacao_pedido = 'P' Then 
			w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
			Continue
		end if
		
		//Atualiza a situa$$HEX2$$e700e300$$ENDHEX$$o do pedido na Matriz
		this.of_atualiza_pedido( ls_id_situacao_pedido, ref ls_log )
		
		If Not isnull(ls_log) and ls_log <> ''  Then
			luo_comum.of_envia_email(il_cd_mensagem_email, 'Status Ifood', ll_Seq_Log, 'Pedido: '  + ls_nr_pedido + ' - ' +  ls_Log, ls_nr_pedido)
			If Not luo_comum.of_atualiza_ecommerce_log(il_cd_filial, ll_Seq_Log, 'E', ls_Log, gf_getserverdate(), ref ls_Log) Then Return False
			luo_comum.of_grava_log_item( il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
			sqlca.of_RollBack( )
			w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
			ls_situacao = 'E'
			ls_log = ''
			Continue
		End If
		
		sqlca.of_commit( )
		
		if Not luo_comum.of_grava_log_item(il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log ) Then Return false
		
		w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
		
	next
			
	lb_sucesso = True

Finally
	
	if Not lb_sucesso then 
		ls_situacao = 'E'
		
		sqlca.of_rollback( )
		if ib_usa_pdv_java = False Then
			itr_filial.of_rollback( )
		ENd if
		
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
			If Not luo_comum.of_atualiza_ecommerce_log(il_cd_filial, ll_Seq_Log, ls_Situacao, ls_MSG_Nula, gf_getserverdate(), ref ls_Log) Then Return False
		End If
	End If
		
	this.of_desconecta_filial( )
		
	luo_comum.of_grava_log_historico(ref ls_id_registro_log, il_cd_filial, il_cd_tipo, ldh_log_inicio, gf_getserverdate(), ls_situacao, ll_Seq_Log, ref ls_log )	
		
	destroy(ids_pedidos)
	destroy(luo_comum)
	
	destroy(ivo_Conecta_Odbc)
	
	if this.ib_usa_pdv_java = false then		
		destroy(itr_Filial)
	ENd if
	
	destroy(ivo_Odbc)
	
	Close(w_Ge501_Aguarde)
	
End try

return true
end function

on uo_ge505_pedido_status.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge505_pedido_status.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;is_objeto = 'Objeto: ' + this.classname() + '~n'
end event

