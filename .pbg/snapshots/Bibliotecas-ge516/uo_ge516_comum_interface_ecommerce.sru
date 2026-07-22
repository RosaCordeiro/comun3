HA$PBExportHeader$uo_ge516_comum_interface_ecommerce.sru
forward
global type uo_ge516_comum_interface_ecommerce from nonvisualobject
end type
end forward

global type uo_ge516_comum_interface_ecommerce from nonvisualobject
end type
global uo_ge516_comum_interface_ecommerce uo_ge516_comum_interface_ecommerce

type variables
boolean ib_grava_log_historico = false
string is_id_ecommerce
string is_id_interface
long il_cd_tipo
String is_datastore_dados

string is_objeto
String is_objeto_comum
string is_rede_filial
string is_pedido_debug

boolean ib_modo_desenv=false
boolean ib_atualiza_log_exportacao=false
boolean ib_log_individual = false
boolean ib_enviar_email = True

String is_nm_tabela_log

long il_cd_filial
long il_cd_filial_log
long il_filial_disque
long il_filial_desenv
long il_cd_mensagem_email

String is_mensagem_email_1
String is_mensagem_email_2

dc_uo_ds_base ids_dados
uo_ge516_comum_ecommerce iuo_comum

string is_ODBC_Desenv
string is_datasource
uo_transacao_online ivo_Conecta_Odbc
dc_uo_transacao itr_Filial
dc_uo_odbc ivo_Odbc
end variables

forward prototypes
public subroutine of_limpa_variaveis ()
private function boolean of_carrega_dados (ref long pl_linhas, ref string ps_log)
public function boolean of_processa_interface (string ps_rede_filial)
public function boolean of_valida_desenvolvimento (ref string ps_log)
protected function boolean of_conecta_filial (ref string ps_log)
protected function boolean of_desconecta_filial ()
public function boolean of_processa_interface (string ps_rede_filial, long pl_cd_filial)
public function boolean of_processa_interface ()
private function boolean of_processa_interface_itens (long pl_linha, ref boolean pb_gerar_log, ref string ps_log)
public function boolean of_monta_json (ref string ps_json, ref string ps_log)
public function boolean of_processa_interface (string ps_rede_filial, long pl_cd_filial, string ps_id_ecommerce)
public subroutine of_configurar_parametros ()
end prototypes

public subroutine of_limpa_variaveis ();
end subroutine

private function boolean of_carrega_dados (ref long pl_linhas, ref string ps_log);pl_linhas = ids_dados.retrieve( is_id_ecommerce, is_rede_filial )

return true
end function

public function boolean of_processa_interface (string ps_rede_filial);return this.of_processa_interface( ps_rede_filial, 0)
end function

public function boolean of_valida_desenvolvimento (ref string ps_log);//Desenvolvimento
is_ODBC_Desenv = iuo_comum.of_desenvolvimento_odbc_baixa_pedido()
il_Filial_Desenv = iuo_comum.of_desenvolvimento_filial_baixa_pedido()

If (Not IsNull(is_ODBC_Desenv) or Not IsNull(il_Filial_Desenv)) and gvo_Aplicacao.ivs_DataSource = 'central' Then
	ps_Log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_interface. ~n' + ' No INI esta configurado FILIAL ou ODBC de desenvolvimento, no entanto esta gravando no BD CENTRAL.'
	return false
End If

If (IsNull(is_ODBC_Desenv) and IsNull(il_Filial_Desenv)) and gvo_Aplicacao.ivs_DataSource <> 'central' Then
	ps_Log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_interface. ~n' + ' No INI n$$HEX1$$e300$$ENDHEX$$o esta configurado FILIAL e ODBC de desenvolvimento, no entanto esta gravando no BD diferente do CENTRAL.'
	return false
End If

if Not IsNull(is_ODBC_Desenv) and Not IsNull(il_Filial_Desenv) and is_ODBC_Desenv <> '' and il_Filial_Desenv > 0 then
	ib_modo_desenv = True
Else
	ib_modo_desenv = false
ENd if

return true
end function

protected function boolean of_conecta_filial (ref string ps_log);String ls_Odbc

if isvalid(itr_Filial) then
	If itr_Filial.of_IsConnected( ) Then return true
ENd if

is_DataSource = gvo_Aplicacao.ivs_DataSource

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
	ivo_Conecta_Odbc.of_inclui_odbc( il_Filial_Disque )
	ls_Odbc = ivo_Odbc.of_Localiza( il_Filial_Disque )
end if

If itr_Filial.of_IsConnected( ) Then
	itr_Filial.of_Disconnect( )
End If

if itr_Filial.of_Connect( ls_Odbc, gvo_aplicacao.is_ComputerName , false) = False Then
	iif(IsNull(il_Filial_Disque), 0, il_Filial_Disque)
	ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel estabelecer conex$$HEX1$$e300$$ENDHEX$$o com a Filial: ' + string(il_Filial_Disque) 
	return false
end if

gvo_Aplicacao.ivs_DataSource = is_DataSource

Return True
end function

protected function boolean of_desconecta_filial ();if Not isvalid(itr_filial) Then return true

If itr_Filial.of_IsConnected( ) Then
	itr_Filial.of_Disconnect( )
End If

gvo_Aplicacao.ivs_DataSource = is_DataSource

return true
end function

public function boolean of_processa_interface (string ps_rede_filial, long pl_cd_filial);return this.of_processa_interface( ps_rede_filial, pl_cd_filial, is_id_ecommerce)
end function

public function boolean of_processa_interface ();return this.of_processa_interface( '', 0)
end function

private function boolean of_processa_interface_itens (long pl_linha, ref boolean pb_gerar_log, ref string ps_log);


return true
end function

public function boolean of_monta_json (ref string ps_json, ref string ps_log);return true
end function

public function boolean of_processa_interface (string ps_rede_filial, long pl_cd_filial, string ps_id_ecommerce);String ls_Chave_Nula
String ls_MSG_Nula
String ls_Log
String ls_Situacao
String ls_id_registro_log

long ll_linhas
Long ll_for
Long ll_Seq_Log

boolean lb_sucesso=false
boolean lb_gerar_log = true

DateTime ldh_Data_Nula
Datetime ldh_log_inicio

SetNull(ls_Chave_Nula)
SetNull(ls_MSG_Nula)
SetNull(ldh_Data_Nula)

is_rede_filial = ps_rede_filial
il_cd_filial = pl_cd_filial

try 

	is_id_ecommerce = ps_id_ecommerce

	ldh_log_inicio = gf_getserverdate()
	ls_situacao = 'P'
	
	Open(w_Aguarde_3)

	iuo_comum = create USING is_objeto_comum

	ids_dados = create dc_uo_ds_base
	
	//Valida$$HEX2$$e700f500$$ENDHEX$$es referentes a base de homologa$$HEX2$$e700e300$$ENDHEX$$o/produ$$HEX2$$e700e300$$ENDHEX$$o
	If Not this.of_valida_desenvolvimento( ref ls_log ) Then Return false
	
	if il_Filial_Desenv > 0 then
		il_filial_disque = il_filial_desenv	
	else
		il_filial_disque = il_cd_filial
	end if
	
	if il_cd_filial > 0 then
		//Carrega os parametros vinculado a filial.
		if Not iuo_comum.of_parametros_ecommerce_filial( il_cd_filial, ps_rede_filial, is_id_ecommerce, ref ls_log) then return false
	
		il_cd_filial_log = il_cd_filial
	
	elseif not isnull(ps_rede_filial) and ps_rede_filial <> '' Then
		//Carrega os parametros e busca o c$$HEX1$$f300$$ENDHEX$$digo da filial vinculado a rede.
		if Not iuo_comum.of_parametros_ecommerce(is_id_ecommerce, ps_rede_filial, ref il_cd_filial_log, ref ls_Log ) Then return false
	else
		iuo_comum.is_id_ecommerce = is_id_ecommerce
	end if
	
	//Se a grava$$HEX2$$e700e300$$ENDHEX$$o de log estiver marcada como individual, nesse momento a filial n$$HEX1$$e300$$ENDHEX$$o importa. A variavel da filial ser$$HEX1$$e100$$ENDHEX$$ preenchida ao processar cada registro.
	if ib_log_individual = True Then il_cd_filial_log = 0
		
	setnull(ls_id_registro_log)
	if ib_grava_log_historico = True then
		iuo_comum.of_grava_log_historico(ref ls_id_registro_log, il_cd_filial_log, il_cd_tipo, ldh_log_inicio, ldh_Data_Nula, 'C', 0, ref ls_log )
	end if
	
	//Configura a datastore respons$$HEX1$$e100$$ENDHEX$$vel por buscar os dados utilizados pela interface
	if not ids_dados.of_changedataobject( is_datastore_dados , false) Then
		ls_Log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_interface. ~n' + ' N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ' + is_datastore_dados
		return false
	end if

	if ib_atualiza_log_exportacao = True Then
		
		if Not iuo_comum.of_altera_situacao_log_ecommerce( 'P', is_nm_tabela_log, il_cd_filial_log, ls_MSG_Nula, ref ls_log ) Then return false
		
	end if

	//Fun$$HEX2$$e700e300$$ENDHEX$$o para dar o retrieve/carregar as informa$$HEX2$$e700f500$$ENDHEX$$es na ids_dados
	if Not this.of_carrega_dados(ref ll_linhas, ref ls_log) Then return false

	If ll_Linhas > 0 and ib_log_individual = false Then
		iuo_comum.il_qt_item_enviado_site = ll_linhas
			// Grava in$$HEX1$$ed00$$ENDHEX$$cio do processo
		If Not iuo_comum.of_grava_log(il_cd_filial_log, il_cd_tipo, ls_Chave_Nula, 'C', ls_MSG_Nula, gf_getserverdate(), gf_getserverdate(), ref ls_Log, ref ll_Seq_Log ) Then Return False
	End If
	
	w_Aguarde_3.uo_progress.of_setmax(ll_Linhas)
	
	//Faz a leitura da ids_dados
	for ll_for = 1 to ll_linhas
		
		SetNull(ls_log)
		
		this.of_limpa_variaveis( )
		
		iuo_comum.of_limpa_variaveis( )
		
		//Executa o processo espec$$HEX1$$ed00$$ENDHEX$$fico para cada interface
		if Not this.of_processa_interface_itens(ll_for, ref lb_gerar_log, ref ls_log ) Then
		
			if ib_log_individual = True Then
				iuo_comum.il_qt_item_enviado_site = 1
				If Not iuo_comum.of_grava_log(il_cd_filial_log, il_cd_tipo, ls_Chave_Nula, 'E', ls_Log, ldh_Data_Nula, gf_getserverdate(), ref ls_Log, ref ll_Seq_Log ) Then Return False
			end if
		
			if ib_enviar_email = True then
				iuo_comum.of_envia_email(il_cd_mensagem_email, is_mensagem_email_1, ll_Seq_Log, is_mensagem_email_2 + ' - ' +  ls_Log)
			End if
			iuo_comum.of_grava_log_item( il_cd_filial_log, ll_Seq_Log, ref ls_Log, ls_Log )
			ls_Situacao = 'E'
			iuo_comum.of_RollBack( SQLCA )
			if isvalid(itr_filial) Then
				iuo_comum.of_rollback( itr_filial )
			end if
			ls_log = ''
			w_Aguarde_3.uo_progress.of_setprogress(ll_for)
			Continue
		End If
		
		if isvalid(itr_filial) Then
			if itr_filial.of_isconnected( ) Then
				If Not iuo_comum.of_commit(itr_filial) Then Return False
			end if
		end if
		
		If Not iuo_comum.of_commit(SQLCA) Then Return False
		
		if lb_gerar_log = True Then
			//Marca log como processado
			if ib_log_individual = True Then
				iuo_comum.il_qt_item_enviado_site = 1
				If Not iuo_comum.of_grava_log(il_cd_filial_log, il_cd_tipo, ls_Chave_Nula, 'P', ls_MSG_Nula, gf_getserverdate(), gf_getserverdate(), ref ls_Log, ref ll_Seq_Log ) Then Return False
			end if
			
			if Not iuo_comum.of_grava_log_item(il_cd_filial_log, ll_Seq_Log, ref ls_Log, ls_Log ) Then Return false
		end if
		
		w_Aguarde_3.uo_progress.of_setprogress(ll_for)	
	next
			
	lb_sucesso = True
	
Finally
	
	if Not lb_sucesso then 
		
		ls_situacao = 'E'
		
		if isvalid(itr_filial) Then
			if itr_filial.of_isconnected( ) Then
				If Not iuo_comum.of_rollback(itr_filial) Then Return False
			end if
		end if
		
		If Not iuo_comum.of_rollback(SQLCA) Then Return False
		
		if ib_log_individual = False Then
		
			// J$$HEX1$$e100$$ENDHEX$$ iniciou o envio dos itens
			If ll_for > 0 Then
				// Atualiza log com erro
				If Not iuo_comum.of_atualiza_ecommerce_log(il_cd_filial_log, ll_Seq_Log, 'E', ls_Log, gf_getserverdate(), ref ls_Log) Then Return False
				if Not iuo_comum.of_grava_log_item(il_cd_filial_log, ll_Seq_Log, ref ls_Log, ls_Log) Then Return false
			Else
				// Se n$$HEX1$$e300$$ENDHEX$$o tiver log insere um novo com erro
				If IsNull(ll_Seq_Log) or ll_Seq_Log = 0 Then
					// Grava in$$HEX1$$ed00$$ENDHEX$$cio do processo - chave e mensagem est$$HEX1$$e300$$ENDHEX$$o indo como nulo
					If Not iuo_comum.of_grava_log(il_cd_filial_log, il_cd_tipo, ls_Chave_Nula, 'E', ls_Log, ldh_Data_Nula, gf_getserverdate(), ref ls_Log, ref ll_Seq_Log ) Then Return False
				Else
					// Atualiza log com erro
					If Not iuo_comum.of_atualiza_ecommerce_log(il_cd_filial_log, ll_Seq_Log, 'E', ls_Log, gf_getserverdate(), ref ls_Log) Then Return False
				End If		
			End If
			
		end if
	Else
		If ll_Linhas > 0 and ib_log_individual = false Then
			//Marca o log como processado
			If Not iuo_comum.of_atualiza_ecommerce_log(il_cd_filial_log, ll_Seq_Log, ls_Situacao, ls_MSG_Nula, gf_getserverdate(), ref ls_Log) Then Return False
		End If
	End If
			
	if ib_grava_log_historico = True Then		
		iuo_comum.of_grava_log_historico(ref ls_id_registro_log, il_cd_filial_log, il_cd_tipo, ldh_log_inicio, gf_getserverdate(), ls_situacao, ll_Seq_Log, ref ls_log )
	end if
		
	this.of_desconecta_filial( )	
		
	destroy(ids_dados)
	destroy(iuo_comum)
	
	Close(w_Aguarde_3)
	
End try

return true
end function

public subroutine of_configurar_parametros ();
end subroutine

on uo_ge516_comum_interface_ecommerce.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge516_comum_interface_ecommerce.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;is_objeto = 'Objeto: ' + this.classname() + '~n'

of_configurar_parametros()
end event

