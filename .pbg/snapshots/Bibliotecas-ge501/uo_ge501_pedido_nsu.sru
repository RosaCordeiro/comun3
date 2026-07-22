HA$PBExportHeader$uo_ge501_pedido_nsu.sru
forward
global type uo_ge501_pedido_nsu from nonvisualobject
end type
end forward

global type uo_ge501_pedido_nsu from nonvisualobject
end type
global uo_ge501_pedido_nsu uo_ge501_pedido_nsu

type variables
string is_objeto
string is_id_ecommerce = '2' //VTEX
string is_id_interface = "/api/pvt/transactions/XXX/payments"
string is_tabela = 'SALDO'
string is_DataSource
String is_pedido_debug

long il_cd_tipo = 15

Boolean lb_Desenv = False

dc_uo_ds_base ids_pedido_nsu

s_email ist_email
end variables

forward prototypes
public function boolean of_busca_nsu (string ps_json, ref string ps_nsu, ref datetime pdt_confirmacao, ref string ps_log)
public function boolean of_processa_pedido_nsu (string ps_rede_filial)
end prototypes

public function boolean of_busca_nsu (string ps_json, ref string ps_nsu, ref datetime pdt_confirmacao, ref string ps_log);string ls_nr_nsu, ls_texto
Datetime ldh_conf_fatur
long ll_pos1, ll_pos2, ll_pos3

ll_pos1 = pos( ps_json, 'settlementConnectorResponse' )

//Busca o NSU
ll_pos2 = pos( ps_json, 'hostUSN\":\"' , ll_pos1 )

ll_pos3 = pos( ps_json, '\' , ll_pos2 + 13 )

if ll_pos1 = 0 or ll_pos2 = 0 or ll_pos3 = 0 Then
	return false
end if

ls_nr_nsu = Mid( ps_json, ll_pos2 + 12, ll_pos3 - ll_pos2 - 12 )

ls_nr_nsu = Trim( ls_nr_nsu ) + ' *'

ll_pos2 = 0
ll_pos3 = 0

//Busca a data de confirmacao
ll_pos2 = pos( ps_json, 'sitefDate\":\"' , ll_pos1 )

ll_pos3 = pos( ps_json, '\' , ll_pos2 + 14 )

if ll_pos1 = 0 or ll_pos2 = 0 or ll_pos3 = 0 Then
	return false
end if

ls_texto = Mid( ps_json, ll_pos2 + 14, ll_pos3 - ll_pos2 - 14 )

ldh_conf_fatur = datetime( date( left(ls_texto,10) ), Time( mid( ls_texto, 12, 8 ) ) )  

//TRansaforma pro hor$$HEX1$$e100$$ENDHEX$$rio de Brasilia ( GMT -3 )
Select dateadd( HOUR, -3, :ldh_conf_fatur )
Into :pdt_confirmacao
From parametro;

ps_nsu = ls_nr_nsu

return true
end function

public function boolean of_processa_pedido_nsu (string ps_rede_filial);long ll_linhas, ll_for
long ll_seq_log
long ll_nr_pedido
long ll_cd_filial_ecommerce
//long ll_cd_filial_seller
long ll_Seller
Long ll_Filial_Fat
Long ll_Filial_Ecommerce
Long ll_nr_transacao=0

String ls_conector
String ls_retorno
String ls_Chave_Nula
String ls_MSG_Nula
String ls_Log
String ls_situacao_ecommerce
String ls_situacao
String ls_nsu[]
String ls_de_transacao
String ls_pedido_ecommerce
String ls_id_registro_log
String ls_Rede_Retrieve
String ls_autorizacao
String ls_id_transacao_conector
string ls_nr_nsu_pre[]
String ls_info_transacao

boolean lb_sucesso=false
boolean lb_manda_email_financ=false
DateTime ldt_inicio
DateTime ldh_Data_Nula
DateTime ldh_conf_fatur
Datetime ldh_log_inicio
Datetime ldh_faturamento
long lvl_cd_filial, lvl_nr_nf
string lvs_de_especie, lvs_de_serie

uo_ge501_pedido_ecommerce luo_pedido
uo_ge501_comum luo_comum_vtex
uo_ge073_json luo_gera_json

SetNull(ls_Chave_Nula)
SetNull(ls_MSG_Nula)
SetNull(ldh_Data_Nula)

//Manipula$$HEX2$$e700e300$$ENDHEX$$o, faz a pesquisa pela MP e retorna para DC pois a venda de manipulado ocorre na DC
If ps_rede_filial = 'MP' Then
	ls_Rede_Retrieve 	= 'MP'
	ps_rede_filial 		= 'DC'
Else
	ls_Rede_Retrieve = ps_rede_filial
End If

try 
	ist_email.ps_to[1] = 'cartao@clamed.com.br'

	Open(w_Aguarde)
	ldh_log_inicio = gf_getserverdate()
	ls_Situacao = 'P'
	
	luo_comum_vtex = create uo_ge501_comum
	luo_gera_json = create uo_ge073_json

	ids_pedido_nsu = create dc_uo_ds_base
	
	//Carrega os parametros e busca o c$$HEX1$$f300$$ENDHEX$$digo da filial vinculado a rede.
	if Not luo_comum_vtex.of_parametros_ecommerce(is_id_ecommerce, ps_rede_filial, ref ll_cd_filial_ecommerce, ref ls_Log ) Then return false

	setnull(ls_id_registro_log)
	luo_comum_vtex.of_grava_log_historico(ref ls_id_registro_log, ll_cd_filial_ecommerce, il_cd_tipo, ldh_log_inicio, ldh_Data_Nula, 'C', 0, ref ls_log )
	
	if Not luo_comum_vtex.of_situacao_ecommerce( ref ls_situacao_ecommerce, ref ls_log ) Then return false

	if ls_situacao_ecommerce = '' or isnull(ls_situacao_ecommerce) or ls_situacao_ecommerce = 'I' Then
		ls_log = 'O ecommerce ' + is_id_ecommerce + ' est$$HEX1$$e100$$ENDHEX$$ inativo.'
		return false
	end if
	
	if not ids_pedido_nsu.of_changedataobject( 'ds_ge501_pedido_nsu' ) Then
		ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_pedido_nsu ~n' + 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ds_ge501_pedido_nsu'
		return false
	end if
	
	If gvo_Aplicacao.ivs_DataSource <> 'central' then
		ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_pedido_nsu, a atualiza$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o pode ser a partir do HOMOLOGA.'
		return false
	End If
	
	ll_linhas = ids_pedido_nsu.retrieve(ls_Rede_Retrieve)
	
	if ll_linhas < 0 Then
		ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_pedido_nsu ~n' + 'Problemas ao consultar o banco de dados na seguinte datawindow: ds_ge501_pedido_nsu ~nErro: ' + SQLCA.is_lasterrortext
		return false
	end if	
		
	w_aguarde.uo_progress.of_setmax(ll_Linhas)
	
	If ll_linhas > 0 Then
		luo_comum_vtex.il_qt_item_enviado_site = ll_linhas
		// Grava in$$HEX1$$ed00$$ENDHEX$$cio do processo
		If Not luo_comum_vtex.of_grava_log(ll_cd_filial_ecommerce, il_cd_tipo, ls_Chave_Nula, 'C', ls_MSG_Nula, gf_getserverdate(), gf_getserverdate(), ref ls_Log, ref ll_Seq_Log ) Then Return False
	End If
	
	for ll_for = 1 to ll_linhas
		
		lb_manda_email_financ = false
		
		luo_comum_vtex.of_limpa_variaveis( )
		
		ll_Filial_Fat 					= ids_pedido_nsu.object.cd_filial						[ll_for]
		ll_nr_pedido 				= ids_pedido_nsu.object.nr_pedido					[ll_for]
		ls_de_transacao 			= ids_pedido_nsu.object.de_codigo_transacao		[ll_for]
		ls_pedido_ecommerce	= ids_pedido_nsu.object.nr_pedido_ecommerce	[ll_for]
		ll_Seller						= ids_pedido_nsu.object.cd_seller						[ll_for]
		ll_Filial_Ecommerce		= ids_pedido_nsu.object.cd_filial_ecommerce		[ll_for]
		ldh_faturamento			= ids_pedido_nsu.object.dh_faturado					[ll_for]
		ls_nr_nsu_pre[1] 			= ids_pedido_nsu.object.nr_comprovante_cartao_credito [ll_for]
		ls_nr_nsu_pre[2] 			= ids_pedido_nsu.object.nr_comp_cartao_credito_2 [ll_for]
		
		// Debug
		If not IsNull(is_pedido_debug) and Trim(is_pedido_debug) <> '' Then
			If ls_pedido_ecommerce <> is_pedido_debug Then
				w_aguarde.uo_progress.of_setprogress(ll_for)
				Continue
			End If
		End If
		
//		if ll_Filial_Fat = 454 then
//			ll_cd_filial_seller = ll_cd_filial_ecommerce
//		else
//			ll_cd_filial_seller = ll_Filial_Fat
//		end if
//		
//		If IsNull(ll_Seller) Then
//			ll_Seller = ll_cd_filial_seller
//		End If
				
		If IsNull(ll_Seller) Then
			ls_Log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao_pedido ~n' + 'N$$HEX1$$e300$$ENDHEX$$o foi localizado o seller no pedido: ' + ls_pedido_ecommerce
			luo_comum_vtex.of_grava_log_item( ll_cd_filial_ecommerce, ll_Seq_Log, ref ls_Log, ls_Log )
			ls_Situacao = 'E'
			ls_Log = ''
			w_Ge501_Aguarde.uo_progress.of_setprogress(ll_for)
			Continue
		End If
				
		w_Aguarde.Title = "VTEX(NSU - CART$$HEX1$$c300$$ENDHEX$$O) - Filial: [" + string(ll_Filial_Fat) +  "] - "  + String(ll_for)  + " de " + STring(ll_Linhas)
		
		//Carrega os parametros e busca o c$$HEX1$$f300$$ENDHEX$$digo da filial vinculado a rede.
		if Not luo_comum_vtex.of_parametros_ecommerce_filial( ll_seller, ps_rede_filial, is_id_ecommerce, ref ls_log ) then return false
		luo_comum_vtex.is_url = gf_replace(luo_comum_vtex.is_url, 'myvtex.com', 'vtexpayments.com.br', 0 )
		
		//Acessa o site para buscar as informa$$HEX2$$e700f500$$ENDHEX$$es de pagamento da transacao
		luo_comum_vtex.of_get( gf_replace( is_id_interface, 'XXX', ls_de_transacao, 0 ) , ref ls_retorno, ref ls_log )
		
		luo_comum_vtex.is_json = ls_retorno
		luo_comum_vtex.il_cd_filial_pedido = ll_seller
		luo_comum_vtex.is_nr_pedido_ecommerce = ls_pedido_ecommerce
		
		If ls_Log <> '' and not isnull(ls_Log) Then
			luo_comum_vtex.of_grava_log_item( ll_cd_filial_ecommerce, ll_Seq_Log, ref ls_Log, ls_Log )
			ls_Situacao = 'E'
			ls_Log = ''
			w_aguarde.uo_progress.of_setprogress(ll_for)
			Continue
		end if
		
		Do While luo_gera_json.of_divide_grupo_json_completo(Ref ls_retorno, Ref ls_info_transacao,'{') 
		
			ll_nr_transacao++
			
			ls_id_transacao_conector = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_transacao, 'tid')
			ls_conector = luo_gera_json.of_busca_conteudo_campo_vtex(ls_info_transacao, 'connector')

			if ls_conector = 'ESITEF' Then
				//Se estiver usando conector ESITEF precisa acessar o webservice da Esitef:
				Try
					
					luo_pedido = create uo_ge501_pedido_ecommerce
					
					luo_pedido.is_url_conector = luo_comum_vtex.is_url_conector
					luo_pedido.is_chave_conector = luo_comum_vtex.is_chave_conector
					luo_pedido.is_token_conector = luo_comum_vtex.is_token_conector
					
					luo_pedido.of_busca_nsu_esitef( 'C', ls_id_transacao_conector, ref ls_nsu[ll_nr_transacao], ref ls_autorizacao, ref ldh_conf_fatur, ref ls_log ) 
					
					if ls_log <> '' and not isnull(ls_log) Then
						luo_comum_vtex.of_grava_log_item( ll_cd_filial_ecommerce, ll_Seq_Log, ref ls_Log, ls_Log )
						ls_Situacao = 'E'
						ls_Log = ''
						w_aguarde.uo_progress.of_setprogress(ll_for)
						Continue
					end if
					
				Finally
					destroy(luo_pedido)
				End Try
			
			else
			
				//Busca o NSU no JSON retornado do site
				this.of_busca_nsu( ls_info_transacao, ref ls_nsu[ll_nr_transacao], ref ldh_conf_fatur, ref ls_log )
				
				if ls_nsu[ll_nr_transacao] = '' or isnull(ls_nsu[ll_nr_transacao]) Then
						
					//Se j$$HEX1$$e100$$ENDHEX$$ passou 5 dias da data do faturamento, preenche o nsu da captura com o nsu da pr$$HEX1$$e900$$ENDHEX$$ e avisa o setor financeiro por email.
					if relativedate(date(ldh_log_inicio),-5) >= date(ldh_faturamento) then
						ls_nsu[ll_nr_transacao] = ls_nr_nsu_pre[ll_nr_transacao]
						ldh_conf_fatur = ldh_log_inicio
					end if
				end if
				
			end if
		
			if ls_nsu[ll_nr_transacao] = '' or isnull(ls_nsu[ll_nr_transacao]) Then
				
				//Se j$$HEX1$$e100$$ENDHEX$$ passou 5 dias da data do faturamento, preenche o nsu da captura com o nsu da pr$$HEX1$$e900$$ENDHEX$$ e avisa o setor financeiro por email.
				if relativedate(date(ldh_log_inicio),-5) >= date(ldh_faturamento) then
					ls_nsu[ll_nr_transacao] = ls_nr_nsu_pre[ll_nr_transacao]
					ldh_conf_fatur = ldh_log_inicio
					lb_manda_email_financ = True
				end if
			end if
		
			if ls_nsu[ll_nr_transacao] = '' or isnull(ls_nsu[ll_nr_transacao]) Then
				ls_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar o c$$HEX1$$f300$$ENDHEX$$digo NSU.'
				luo_comum_vtex.of_grava_log_item( ll_cd_filial_ecommerce, ll_Seq_Log, ref ls_Log, ls_Log )
				ls_Situacao = 'E'
				ls_log = ''
				w_aguarde.uo_progress.of_setprogress(ll_for)
				Continue
			end if

			if date(ldh_conf_fatur) = date('01/01/1900') or isnull(ldh_conf_fatur) Then
				ls_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar a data de confirma$$HEX2$$e700e300$$ENDHEX$$o do faturamento.'
				luo_comum_vtex.of_grava_log_item( ll_cd_filial_ecommerce, ll_Seq_Log, ref ls_Log, ls_Log )
				ls_Situacao = 'E'
				ls_log = ''
				w_aguarde.uo_progress.of_setprogress(ll_for)
				Continue
			end if
		
		Loop
		
		if upperbound(ls_nsu) < 2 then
			setnull(ls_nsu[2])
		End if
		
		//Grava o NSU na tabela pedido_ecommerce_auxiliar		
		UPdate pedido_ecommerce_auxiliar
		set nr_nsu_host = :ls_nsu[1], 
			 nr_nsu_host_2 = :ls_nsu[2],
			 dh_confirmacao_faturamento = :ldh_conf_fatur
		where cd_filial_ecommerce = :ll_Filial_Ecommerce
		and nr_pedido = :ll_nr_pedido;
		
		if sqlca.sqlcode = -1 then
			ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_pedido_nsu; ' + 'Problemas ao atualizar a tabela "pedido_ecommerce_auxiliar": ' + sqlca.sqlerrtext
			return false
		end if
		
		If Sqlca.SQLNRows <> 1 Then
			ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_pedido_nsu; ' + 'N$$HEX1$$e300$$ENDHEX$$o atualizou a quantidade esperada de registros'
			return false
		End If
		
		//Update no log do Exporta$$HEX2$$e700e300$$ENDHEX$$o que envia pro CAR para quando for enviado email, ja acionar e updatar o log para ser reprocessado e enviado para o CAR com NSU da pre captura tela w_el009_exportacao_car		
		if lb_manda_email_financ = True Then
			 
			//Busca com o pedido a nota
			select l.cd_filial, l.nr_nf, l.de_especie,l.de_serie
			into :lvl_cd_filial, :lvl_nr_nf, :lvs_de_especie, :lvs_de_serie
			from log_exportacao_docto l
			where l.cd_ambiente_sap		= 'PRD'	
				and l.id_revisado 				= 'P'
				and l.id_situacao_log			= 'E'
				and l.cd_integracao 			= '1007'
				and l.de_especie 				= 'NFE'
				and l.id_tipo_docto 			= 'VD'
				and exists (select 1 from nf_venda n where n.cd_filial = l.cd_filial and n.nr_nf = l.nr_nf and n.de_especie = l.de_especie and n.de_serie = l.de_serie and n.nr_pedido_ecommerce = :ll_nr_pedido)
			using sqlca;
			
			if sqlca.sqlcode = -1 then
				ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_pedido_nsu; ' + 'Erro na busca da nota utilizando o pedido": ' + sqlca.sqlerrtext
				return false
			end if
					
			if lvl_cd_filial > 0 then
				//Update no registro para reprocessar
				Update top 1 log_exportacao_docto
					set id_situacao_log 			= 'X',
						 nr_matricula_revisao		= 'EX GE501',
						 dh_revisao					= getdate(),
						 dh_exclusao				= getdate(),
						 de_revisao					=	'NSU HOST DA CAPITURA',
						 id_revisado					=	'R'
					Where cd_filial 					= :lvl_cd_filial
						and nr_nf 					= :lvl_nr_nf
						and de_especie 			= :lvs_de_especie
						and de_serie 				= :lvs_de_serie
						and cd_ambiente_sap 	= 'PRD'
						and id_situacao_log		= 'E'
						and id_revisado			= 'P'
				Using sqlca;
				
				if sqlca.sqlcode = -1 then
					ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_pedido_nsu; ' + 'Erro na busca da nota utilizando o pedido": ' + sqlca.sqlerrtext
					return false
				end if
			end if
		end if
		
		If Not gf_ge501_commit(SQLCA) Then Return False
		
		if lb_manda_email_financ = True Then
			ls_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar o c$$HEX1$$f300$$ENDHEX$$digo NSU da captura. Foi utilizada a informa$$HEX2$$e700e300$$ENDHEX$$o da pr$$HEX1$$e900$$ENDHEX$$-autoriza$$HEX2$$e700e300$$ENDHEX$$o.'
			luo_comum_vtex.of_envia_email(261, 'PEDIDO NSU - [' + ps_rede_filial + ']', ll_Seq_Log, 'Pedido: '  + ls_pedido_ecommerce + ' - ' +  ls_Log, ist_email, ls_pedido_ecommerce)
			ls_log = ''
		end if
		
		//Grava no log como processado com $$HEX1$$ea00$$ENDHEX$$xito.
		if Not luo_comum_vtex.of_grava_log_item(ll_cd_filial_ecommerce, ll_Seq_Log, ref ls_Log, ls_Log ) Then Return false
		
		w_aguarde.uo_progress.of_setprogress(ll_for)
		
	next

	if isvalid(w_aguarde) Then Close(w_aguarde)

	lb_sucesso = True

Finally
	
	if Not lb_sucesso then 
		ls_situacao = 'E'
		
		//sqlca.of_rollback( )
		gf_ge501_RollBack(SQLCA)
		
		// J$$HEX1$$e100$$ENDHEX$$ iniciou o envio dos itens
		If ll_for > 0 Then
			// Atualiza log com erro
			If Not luo_comum_vtex.of_atualiza_ecommerce_log(ll_cd_filial_ecommerce, ll_Seq_Log, 'E', ls_Log, gf_getserverdate(), ref ls_Log) Then Return False
			if Not luo_comum_vtex.of_grava_log_item(ll_cd_filial_ecommerce, ll_Seq_Log, ref ls_Log, ls_Log) Then Return false
		Else
			// Se n$$HEX1$$e300$$ENDHEX$$o tiver log insere um novo com erro
			If IsNull(ll_Seq_Log) or ll_Seq_Log = 0 Then
				// Grava in$$HEX1$$ed00$$ENDHEX$$cio do processo - chave e mensagem est$$HEX1$$e300$$ENDHEX$$o indo como nulo
				If Not luo_comum_vtex.of_grava_log(ll_cd_filial_ecommerce, il_cd_tipo, ls_Chave_Nula, 'E', ls_Log, ldh_Data_Nula, gf_getserverdate(), ref ls_Log, ref ll_Seq_Log ) Then Return False
			Else
				// Atualiza log com erro
				If Not luo_comum_vtex.of_atualiza_ecommerce_log(ll_cd_filial_ecommerce, ll_Seq_Log, 'E', ls_Log, gf_getserverdate(), ref ls_Log) Then Return False
			End If		
		End If
	Else
	
		If ll_Linhas > 0 Then
			// Marca o log como processado
			If Not luo_comum_vtex.of_atualiza_ecommerce_log(ll_cd_filial_ecommerce, ll_Seq_Log, ls_Situacao, ls_MSG_Nula, gf_getserverdate(), ref ls_Log) Then Return False
		End If
	End If
	
	luo_comum_vtex.of_grava_log_historico(ref ls_id_registro_log, ll_cd_filial_ecommerce, il_cd_tipo, ldh_log_inicio, gf_getserverdate(), ls_situacao, ll_Seq_Log, ref ls_log )
	
	destroy(ids_pedido_nsu)
	destroy(luo_comum_vtex)
	destroy(luo_gera_json)
	
	if isvalid(w_aguarde) Then Close(w_aguarde)

End try

return true
end function

on uo_ge501_pedido_nsu.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge501_pedido_nsu.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;is_objeto = 'Objeto: ' + this.classname() + '~n'

SetNull(is_pedido_debug)
end event

