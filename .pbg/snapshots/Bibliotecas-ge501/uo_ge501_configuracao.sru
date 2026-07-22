HA$PBExportHeader$uo_ge501_configuracao.sru
forward
global type uo_ge501_configuracao from nonvisualobject
end type
end forward

global type uo_ge501_configuracao from nonvisualobject
end type
global uo_ge501_configuracao uo_ge501_configuracao

type variables
string is_objeto
string is_id_ecommerce = '2' //VTEX
string is_id_interface = 'api/catalog_system/pvt/seller/'

string is_rede_filial

long il_cd_tipo = 12
long il_cd_filial



end variables

forward prototypes
public function boolean of_processa_configuracao (string ps_rede_filial)
public function boolean of_processa_configuracao (string ps_rede_filial, long pl_cd_filial)
end prototypes

public function boolean of_processa_configuracao (string ps_rede_filial);return this.of_processa_configuracao( ps_rede_filial, 0 )
end function

public function boolean of_processa_configuracao (string ps_rede_filial, long pl_cd_filial);String ls_json
String ls_retorno
String ls_Chave_Nula
String ls_MSG_Nula
String ls_Log
String ls_Situacao
String ls_situacao_seller
String ls_seller
String ls_parametro
String ls_id_abrangente

Long ll_linhas
Long ll_for
Long ll_Seq_Log
Long ll_existe
Long ll_cd_filial_seller

boolean lb_sucesso=false
boolean lb_alterar_seller=false

datetime ldt_inicio, ldt_termino

DateTime ldh_Data_Nula

uo_ge501_comum luo_comum_vtex
dc_uo_ds_base lds_filiais

SetNull(ls_Chave_Nula)
SetNull(ls_MSG_Nula)
SetNull(ldh_Data_Nula)

is_rede_filial = ps_rede_filial

//Deve executar somente em ambiente de Producao:
If gvo_Aplicacao.ivs_DataSource <> 'central' then
	return True
End If


try 
	
	Open(w_Aguarde)

	luo_comum_vtex = create uo_ge501_comum
	lds_filiais = create dc_uo_ds_base

	if not lds_filiais.of_changedataobject( 'ds_ge501_filiais_ecommerce_conf' , false) Then
		ls_Log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_configuracao ~n' + 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ds_ge501_filiais_ecommerce_conf'
		return false
	end if	
	
	lds_filiais.of_appendwhere("erf.id_rede_filial = '" + ps_rede_filial +  "'") 
	
	if not isnull(pl_cd_filial) and pl_cd_filial > 0 Then
		lds_filiais.of_appendwhere("erf.cd_filial = " + string(pl_cd_filial) ) 
	else
		lds_filiais.of_appendwhere("erf.dh_configuracao_seller is null")
	End if
	
	//Carrega os parametros do seller
	if Not luo_comum_vtex.of_parametros_ecommerce(is_id_ecommerce, ps_rede_filial, ref il_cd_filial, ref ls_log ) Then return false
	
	Choose Case ps_rede_filial
		Case 'DC'
			ls_seller = 'drogariacatarinense'
		Case 'FA'
			ls_seller = 'farmagora'
		Case 'PP'
			ls_seller = 'precopopular'
		Case Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Verificar par$$HEX1$$e200$$ENDHEX$$metro")
			Return False
	End Choose

	if Not luo_comum_vtex.of_busca_filial_ecommerce( ps_rede_filial, ref il_cd_filial, ref ls_log) Then return false

	lds_filiais.setfilter('cd_filial <> 454')

	ll_linhas = lds_filiais.retrieve()

	If ll_Linhas > 0 Then
		luo_comum_vtex.il_qt_item_enviado_site = ll_linhas
         // Grava in$$HEX1$$ed00$$ENDHEX$$cio do processo
		If Not luo_comum_vtex.of_grava_log(il_cd_filial, il_cd_tipo, ls_Chave_Nula, 'C', ls_MSG_Nula, gf_getserverdate(), gf_getserverdate(), ref ls_Log, ref ll_Seq_Log ) Then Return False
	End If

	ls_Situacao = 'P'
	
	w_aguarde.uo_progress.of_setmax(ll_Linhas)
	
	for ll_for = 1 to ll_linhas
		
		ls_log = ''
		ll_existe= 0
		
		luo_comum_vtex.of_limpa_variaveis( )
		
		ll_cd_filial_seller = lds_filiais.object.cd_filial[ll_for]
		//ls_situacao_seller = lds_filiais.object.id_situacao[ll_for]
		ls_id_abrangente = lds_filiais.object.id_abrangente[ll_for]
		
		ls_parametro = ls_seller + string(ll_cd_filial_seller)
				
		w_Aguarde.Title = "Configurando filial no Ecommerce - [" + string(ll_cd_filial_seller) +  "] - "  + String(ll_for)  + " de " + STring(ll_Linhas)

		//Busca as informa$$HEX2$$e700f500$$ENDHEX$$es do pedido no Ecommerce.
		luo_comum_vtex.of_get( is_id_interface + ls_parametro, ref ls_retorno, ref ls_log )
		
		if ls_log <> '' and not isnull(ls_log) Then
			luo_comum_vtex.of_grava_log_item( il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
			ls_Situacao = 'E'
			w_aguarde.uo_progress.of_setprogress(ll_for)
			Continue
		end if
		
		if ls_id_abrangente = 'S' and match(ls_retorno, '"IsBetterScope": false') = true Then
			
			ls_json = gf_replace(ls_retorno, '"IsBetterScope": false', '"IsBetterScope": true',0)
			
		elseif ls_id_abrangente = 'S' and	match(ls_retorno, '"IsBetterScope":false') = True Then
			
			ls_json = gf_replace(ls_retorno, '"IsBetterScope":false', '"IsBetterScope": true',0)
			
		elseif ls_id_abrangente = 'N' and match(ls_retorno, '"IsBetterScope": true') = true Then
			
			ls_json = gf_replace(ls_retorno, '"IsBetterScope": true', '"IsBetterScope": false',0)
			
		elseif ls_id_abrangente = 'N' and match(ls_retorno, '"IsBetterScope":true') = True Then
			
			ls_json = gf_replace(ls_retorno, '"IsBetterScope":true', '"IsBetterScope": false',0)
	
		else
			
			update ecommerce_rede_filial
			set dh_configuracao_seller = getdate()
			where id_ecommerce = :is_id_ecommerce
				and id_rede_filial 			= :ps_rede_filial
				and cd_filial 				= :ll_cd_filial_seller
			using Sqlca;
			
			if sqlca.sqlcode = - 1 Then
				ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_configuracao. ' + 'Problemas ao atualizar registro na tabela "ecommerce_rede_filial": ' + sqlca.sqlerrtext
				return false
			end if
			
			SQLCA.of_commit( )
			
			ls_log = 'Par$$HEX1$$e200$$ENDHEX$$metro IsBetterScope j$$HEX1$$e100$$ENDHEX$$ configurado na filial ' + string(ll_cd_filial_seller) + '.'
			luo_comum_vtex.of_grava_log_item( il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
			ls_Situacao = 'E'
			w_aguarde.uo_progress.of_setprogress(ll_for)
			Continue
		end if
		
		//Busca as informa$$HEX2$$e700f500$$ENDHEX$$es do pedido no Ecommerce.
		luo_comum_vtex.of_put(ls_json, is_id_interface + ls_parametro, ref ls_retorno, ref ls_log )
		
		luo_comum_vtex.is_json = ls_json	
		
		if ls_log <> '' and not isnull(ls_log) Then
			luo_comum_vtex.of_grava_log_item( il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log )
			ls_Situacao = 'E'
			w_aguarde.uo_progress.of_setprogress(ll_for)
			Continue
		end if

		update ecommerce_rede_filial
		set dh_configuracao_seller = getdate()
		where id_ecommerce = :is_id_ecommerce
			and id_rede_filial 			= :ps_rede_filial
			and cd_filial 				= :ll_cd_filial_seller
		using Sqlca;
		
		if sqlca.sqlcode = - 1 Then
			ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_configuracao. ' + 'Problemas ao atualizar registro na tabela "ecommerce_rede_filial": ' + sqlca.sqlerrtext
			return false
		end if
		
		SQLCA.of_commit( )
		
		if Not luo_comum_vtex.of_grava_log_item(il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log ) Then Return false
		
		w_aguarde.uo_progress.of_setprogress(ll_for)	
	next
			
	lb_sucesso = True

Finally
	
	if Not lb_sucesso then 

		sqlca.of_rollback( )
		
		// J$$HEX1$$e100$$ENDHEX$$ iniciou o envio dos itens
		If ll_for > 0 Then
			// Atualiza log com erro
			If Not luo_comum_vtex.of_atualiza_ecommerce_log(il_cd_filial, ll_Seq_Log, 'E', ls_Log, gf_getserverdate(), ref ls_Log) Then Return False
			if Not luo_comum_vtex.of_grava_log_item(il_cd_filial, ll_Seq_Log, ref ls_Log, ls_Log) Then Return false
		Else
			// Se n$$HEX1$$e300$$ENDHEX$$o tiver log insere um novo com erro
			If IsNull(ll_Seq_Log) or ll_Seq_Log = 0 Then
				// Grava in$$HEX1$$ed00$$ENDHEX$$cio do processo - chave e mensagem est$$HEX1$$e300$$ENDHEX$$o indo como nulo
				If Not luo_comum_vtex.of_grava_log(il_cd_filial, il_cd_tipo, ls_Chave_Nula, 'E', ls_Log, ldh_Data_Nula, gf_getserverdate(), ref ls_Log, ref ll_Seq_Log ) Then Return False
			Else
				// Atualiza log com erro
				If Not luo_comum_vtex.of_atualiza_ecommerce_log(il_cd_filial, ll_Seq_Log, 'E', ls_Log, gf_getserverdate(), ref ls_Log) Then Return False
			End If		
		End If
	Else
		If ll_Linhas > 0 Then
			// Marca o log como processado
			If Not luo_comum_vtex.of_atualiza_ecommerce_log(il_cd_filial, ll_Seq_Log, ls_Situacao, ls_MSG_Nula, gf_getserverdate(), ref ls_Log) Then Return False
		End If
	End If
		
	destroy(lds_filiais)
	destroy(luo_comum_vtex)
	
	Close(w_Aguarde)
	
End try

return true
end function

on uo_ge501_configuracao.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge501_configuracao.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;is_objeto = 'Objeto: ' + this.classname() + '~n'
end event

