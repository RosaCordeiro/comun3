HA$PBExportHeader$uo_ge501_ean.sru
forward
global type uo_ge501_ean from nonvisualobject
end type
end forward

global type uo_ge501_ean from nonvisualobject
end type
global uo_ge501_ean uo_ge501_ean

type variables
string is_objeto
string is_id_ecommerce = '2' //VTEX
string is_id_interface = '/api/catalog/pvt/stockkeepingunit'
string is_tabela = 'EAN'
String is_rede_ecommerce
long il_cd_tipo = 6

end variables

forward prototypes
public function boolean of_processa_atualizacao_ean (string ps_rede_filial)
end prototypes

public function boolean of_processa_atualizacao_ean (string ps_rede_filial);long ll_linhas, ll_for
long ll_cd_produto
long ll_cd_filial
long ll_seq_log
longlong ll_nr_atualizacao

String ls_retorno
String ls_cd_ean
String ls_cd_sku
String ls_Chave_Nula
String ls_MSG_Nula
String ls_Log
String ls_Situacao
String ls_tipo_movimento

boolean lb_sucesso=false
DateTime ldt_inicio
DateTime ldh_Data_Nula

dc_uo_ds_base lds_dados
uo_ge501_comum luo_comum_vtex

SetNull(ls_Chave_Nula)
SetNull(ls_MSG_Nula)
SetNull(ldh_Data_Nula)

try 
	
	Open(w_Aguarde)

	is_rede_ecommerce = ps_rede_filial

	luo_comum_vtex = create uo_ge501_comum

	lds_dados = create dc_uo_ds_base
	
	if not lds_dados.of_changedataobject( 'ds_ge501_ean' ) Then
		ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualiza_ean ~n' + 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ds_ge501_ean'
		return false
	end if
	
	If gvo_Aplicacao.ivs_DataSource <> 'central' then
		ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_ean, a atualiza$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o pode ser a partir do HOMOLOGA.'
		return false
	End If
	
	//Carrega os parametros e busca o c$$HEX1$$f300$$ENDHEX$$digo da filial vinculado a rede.
	if Not luo_comum_vtex.of_parametros_ecommerce(is_id_ecommerce, ps_rede_filial, ref ll_cd_filial, ref ls_log ) Then return false
	
	//Altera situacao para pendente
	If not luo_comum_vtex.of_altera_situacao_log_ecommerce( 'P', is_tabela, ll_cd_filial, '', ref ls_log ) Then return false
	
	ll_linhas = lds_dados.retrieve( is_id_ecommerce, ll_cd_filial, is_rede_ecommerce)
	
	if ll_linhas < 0 Then
		ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualiza_ean ~n' + 'Problemas ao consultar o banco de dados na seguinte datawindow: ds_ge501_ean'
		return false
	end if
	
	If ll_Linhas > 0 Then
		luo_comum_vtex.il_qt_item_enviado_site = ll_linhas
         // Grava in$$HEX1$$ed00$$ENDHEX$$cio do processo
		If Not luo_comum_vtex.of_grava_log(ll_cd_filial, il_cd_tipo, ls_Chave_Nula, 'C', ls_MSG_Nula, gf_getserverdate(), gf_getserverdate(), ref ls_Log, ref ll_Seq_Log ) Then Return False
	End If
	
	ls_Situacao = 'P'
	
	w_aguarde.uo_progress.of_setmax(ll_Linhas)
	
	for ll_for = 1 to ll_linhas
		
		w_Aguarde.Title = "Atualizando EAN no eCommerce - [" + ps_rede_filial +  "] - "  + String(ll_for)  + " de " + STring(ll_Linhas)
		
		luo_comum_vtex.of_limpa_variaveis( )
		
		ldt_inicio = gf_getserverdate()
		
		ll_cd_produto = lds_dados.object.cd_produto[ll_for]
		ls_cd_ean = lds_dados.object.cd_ean[ll_for]
		ls_cd_sku = lds_dados.object.cd_sku[ll_for]
		ls_tipo_movimento = lds_dados.object.id_atualizacao[ll_for]
		ll_nr_atualizacao = lds_dados.object.nr_atualizacao[ll_for]
		
		luo_comum_vtex.il_cd_produto = ll_cd_produto
		luo_comum_vtex.is_cd_ean = ls_cd_ean

		if ls_tipo_movimento = 'I' Then //Inclus$$HEX1$$e300$$ENDHEX$$o
			//Inclui o cod EAN.
			luo_comum_vtex.of_post( '', is_id_interface + '/' + ls_cd_sku + '/ean/' + ls_cd_ean, ref ls_retorno, ref ls_log ) 
			
		else //Exclus$$HEX1$$e300$$ENDHEX$$o
			//Exclui o cod EAN.
			luo_comum_vtex.of_delete( '', is_id_interface + '/' + ls_cd_sku + '/ean/' + ls_cd_ean, ref ls_retorno, ref ls_log ) 
			
		end if
		
		If ls_Log <> '' and not isnull(ls_Log) Then
			luo_comum_vtex.of_grava_log_item( ll_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
			ls_Situacao = 'E'
			ls_Log = ''
			Continue
		end if
		
		//Altera situacao para Processado
		If not luo_comum_vtex.of_altera_situacao_log_ecommerce( 'S', ll_nr_atualizacao, ref ls_log ) Then return false
		
		//sqlca.of_commit( )
		If Not gf_ge501_commit(SQLCA) Then Return False
		
		//Grava no log como processado com $$HEX1$$ea00$$ENDHEX$$xito.
		if Not luo_comum_vtex.of_grava_log_item(ll_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log ) Then Return false
		
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
	
	destroy(lds_dados)
	destroy(luo_comum_vtex)
	
	Close(w_Aguarde)
End try

return true
end function

on uo_ge501_ean.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge501_ean.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;is_objeto = 'Objeto: ' + this.classname() + '~n'
end event

