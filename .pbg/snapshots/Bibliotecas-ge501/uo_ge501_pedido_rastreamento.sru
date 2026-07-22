HA$PBExportHeader$uo_ge501_pedido_rastreamento.sru
forward
global type uo_ge501_pedido_rastreamento from nonvisualobject
end type
end forward

global type uo_ge501_pedido_rastreamento from nonvisualobject
end type
global uo_ge501_pedido_rastreamento uo_ge501_pedido_rastreamento

type variables
string is_objeto
string is_id_ecommerce = '2' //VTEX
string is_DataSource
String is_pedido_debug
string is_situacao

long il_cd_tipo = 24
long il_cd_filial_ecommerce
long il_seq_log

dc_uo_ds_base ids_rastreio_total, ids_situacao_entrega, ids_rastreio_jadlog

Boolean lb_Desenv = False

uo_ge501_comum iuo_comum_vtex


end variables

forward prototypes
public function boolean of_processa_pedido_rastreamento (string ps_rede_filial)
public function boolean of_grava_pedido_entrega (long pl_cd_filial, long pl_nr_pedido, string ps_objeto, ref string ps_log)
public function boolean of_disparar_email (long pl_cd_filial, long pl_nr_pedido, long pl_nr_sequencial, ref string ps_log)
public function boolean of_atualizar_entrega (long pl_cd_filial, long pl_nr_pedido, long pl_nr_sequencial, string ps_id_situacao, string ps_id_comunicacao, ref string ps_log)
public function boolean of_grava_rastreio_total (long pl_cd_filial, long pl_nr_pedido, long pl_nr_sequencial, string ps_objeto, string ps_nr_pedido_ecommerce, ref boolean pb_novo_rastreio, ref string ps_log)
public function boolean of_processa_pedido_rastreamento (string ps_rede_filial, long pl_cd_filial)
public function boolean of_verifica_finalizado (long pl_cd_filial, long pl_nr_pedido, long pl_nr_sequencial, string ps_id_tipo_entrega, ref boolean pb_finalizado, ref boolean pb_entregue, ref string ps_log)
public function boolean of_atualizar_pedido_entregue (long pl_cd_filial, long pl_nr_pedido, ref string ps_log)
public function boolean of_grava_rastreio_jadlog (long pl_cd_filial, long pl_nr_pedido, long pl_nr_sequencial, ref boolean pb_novo_rastreio, ref string ps_log)
end prototypes

public function boolean of_processa_pedido_rastreamento (string ps_rede_filial);long ll_linhas, ll_for
long ll_nr_pedido
long ll_cd_filial_hub

string ls_id_registro_log
string ls_log
string ls_situacao_ecommerce
string ls_Chave_Nula
string ls_MSG_Nula
Datetime ldh_log_inicio, ldh_Data_Nula
boolean lb_sucesso = false

uo_ge501_pedido_ecommerce luo_pedido

dc_uo_ds_base lds_filiais

try 
	setnull( ls_Chave_Nula)
	setnull( ls_MSG_Nula )
	setnull(ldh_Data_Nula)
	is_situacao = 'P'
	
	Open(w_Aguarde_3)
	ldh_log_inicio = gf_getserverdate()
	
	iuo_comum_vtex = create uo_ge501_comum
	
	//Carrega os parametros e busca o c$$HEX1$$f300$$ENDHEX$$digo da filial vinculado a rede.
	if Not iuo_comum_vtex.of_parametros_ecommerce(is_id_ecommerce, ps_rede_filial, ref il_cd_filial_ecommerce, ref ls_Log ) Then return false
	
	setnull(ls_id_registro_log)
	iuo_comum_vtex.of_grava_log_historico(ref ls_id_registro_log, il_cd_filial_ecommerce, il_cd_tipo, ldh_log_inicio, ldh_Data_Nula, 'C', 0, ref ls_log )
	
	if Not iuo_comum_vtex.of_situacao_ecommerce( ref ls_situacao_ecommerce, ref ls_log ) Then return false

	if ls_situacao_ecommerce = '' or isnull(ls_situacao_ecommerce) or ls_situacao_ecommerce = 'I' Then
		ls_log = 'O ecommerce ' + is_id_ecommerce + ' est$$HEX1$$e100$$ENDHEX$$ inativo.'
		return false
	end if
	
	lds_filiais = create dc_uo_ds_base
	
	if not lds_filiais.of_changedataobject( 'ds_ge501_filiais_hub_entrega' ) Then
		ls_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel instanciar a seguinte datawindow: ds_ge501_filiais_hub_entrega'
		return false
	end if
	
	ll_linhas = lds_filiais.retrieve(is_id_ecommerce, ps_rede_filial)
	
	if ll_linhas < 0 Then
		ls_log = 'Problemas ao consultar o banco de dados na seguinte datawindow: ds_ge501_filiais_hub_entrega ~nErro: ' + SQLCA.is_lasterrortext
		return false
	Elseif ll_linhas > 0 Then
		If Not iuo_comum_vtex.of_grava_log(il_cd_filial_ecommerce, il_cd_tipo, ls_Chave_Nula, 'C', ls_MSG_Nula, gf_getserverdate(), gf_getserverdate(), ref ls_Log, ref il_Seq_Log ) Then Return False
	end if	
		
	w_aguarde_3.uo_progress.of_setmax(ll_Linhas)
	
	w_aguarde_3.title = 'VTEX - PEDIDO RASTREAMENTO [' + ps_rede_filial +']'
	
	for ll_for = 1 to ll_linhas
		
		ll_cd_filial_hub = lds_filiais.object.cd_filial_hub[ll_for]
	
		w_aguarde_3.wf_settext('Filial HUB: ' + string(ll_cd_filial_hub) + ' [' + string(ll_for) + ' de ' + string(ll_linhas) + ']', 1)
	
		of_processa_pedido_rastreamento( ps_rede_filial, ll_cd_filial_hub) 
		
		w_aguarde_3.uo_progress.of_setprogress(ll_for)
		
	next
	
	lb_sucesso = True
	
Finally
	
	if lb_sucesso = false then
		is_situacao = 'E'
		// Se n$$HEX1$$e300$$ENDHEX$$o tiver log insere um novo com erro
		If IsNull(il_Seq_Log) or il_Seq_Log = 0 Then
			// Grava in$$HEX1$$ed00$$ENDHEX$$cio do processo - chave e mensagem est$$HEX1$$e300$$ENDHEX$$o indo como nulo
			If Not iuo_comum_vtex.of_grava_log(il_cd_filial_ecommerce, il_cd_tipo, ls_Chave_Nula, 'E', ls_Log, ldh_Data_Nula, gf_getserverdate(), ref ls_Log, ref il_Seq_Log ) Then Return False
		Else
			// Atualiza log com erro
			If Not iuo_comum_vtex.of_atualiza_ecommerce_log(il_cd_filial_ecommerce, il_Seq_Log, 'E', ls_Log, gf_getserverdate(), ref ls_Log) Then Return False
		End If	
		
	Else
	
		If ll_Linhas > 0 Then
			// Marca o log como processado
			If Not iuo_comum_vtex.of_atualiza_ecommerce_log(il_cd_filial_ecommerce, il_Seq_Log, is_Situacao, ls_MSG_Nula, gf_getserverdate(), ref ls_Log) Then Return False
		End If	
		
	ENd if
	
	iuo_comum_vtex.of_grava_log_historico(ref ls_id_registro_log, il_cd_filial_ecommerce, il_cd_tipo, ldh_log_inicio, gf_getserverdate(), is_situacao, il_seq_log, ref ls_log )
	
	if isvalid(w_aguarde_3) Then Close(w_aguarde_3)
	
	if isvalid(lds_filiais) tHen destroy(lds_filiais)
	if isvalid(ids_rastreio_total) tHen destroy(ids_rastreio_total)
	if isvalid(iuo_comum_vtex) tHen destroy(iuo_comum_vtex)

End try

return true
end function

public function boolean of_grava_pedido_entrega (long pl_cd_filial, long pl_nr_pedido, string ps_objeto, ref string ps_log);long ll_sequencial
boolean lb_sucesso = false
string ls_nm_transportadora

Try

		ls_nm_transportadora = 'TOTAL EXPRESS'

		Select max(nr_sequencial)
		into :ll_sequencial
		from pedido_ecommerce_entrega
		where cd_filial_ecommerce = :pl_cd_filial
		and nr_pedido = :pl_nr_pedido
		Using sqlca;
		
		if sqlca.sqlcode = -1 then
			ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_entrega ; Problemas ao consultar a tabela "pedido_ecommerce_entrega": ' + sqlca.sqlerrtext
			return false
		end if
		
		if ll_sequencial = 0 or isnull(ll_sequencial) Then
			ll_sequencial = 1
		else
			ll_sequencial ++
		end if
		
		Insert into pedido_ecommerce_entrega( cd_filial_ecommerce,
																nr_pedido,
																nr_sequencial,
																nm_transportadora,
																nr_dias_entrega,
																cd_transportadora,
																id_situacao,
																de_objeto)
		values( :pl_cd_filial,
					:pl_nr_pedido,
					:ll_sequencial,
					:ls_nm_transportadora,
					0,
					:ls_nm_transportadora,
					'A',
					:ps_objeto)
		Using sqlca;
					
		if sqlca.sqlcode = -1 then
			ps_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_pedido_entrega ; Problemas ao inserir registro na tabela "pedido_ecommerce_entrega": ' + sqlca.sqlerrtext
			return false
		end if
		
		lb_sucesso = True
	
Finally
	
	
End Try

return true
end function

public function boolean of_disparar_email (long pl_cd_filial, long pl_nr_pedido, long pl_nr_sequencial, ref string ps_log);string ls_url_padrao
string ls_retorno

boolean lb_erro=false

OleObject loo_xmlhttp

Try

	loo_xmlhttp = CREATE oleobject
	loo_xmlhttp.ConnectToNewObject("WinHTTP.WinHTTPRequest.5.1")
		
	ls_url_padrao = 'http://10.0.0.16/ecommerce/envioEmail/movimentacaoCorreio/movimentacaoCorreioCliente.php?nr_pedido=' + string(pl_nr_pedido) + '&cd_filial_ecommerce=' + string(pl_cd_filial) + '&nr_sequencial=' + string(pl_nr_sequencial)
	
	loo_xmlhttp.open ("GET",ls_url_padrao, false)
	loo_xmlhttp.send()
	
	ls_retorno = upper(loo_xmlhttp.ResponseText)
	
	if isnull(ls_retorno) Then ls_retorno = ''
	
	If ls_retorno <> '1'  Then
		ps_log = is_objeto + '; Fun$$HEX2$$e700e300$$ENDHEX$$o: of_disparar_email ; ' + ' - N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel disparar o email de rastreio: Pedido [' + string(pl_cd_filial) + ' - ' + string(pl_nr_pedido) + ']'
		return false
	end if

Finally 
	
	//loo_xmlhttp.DisconnectObject()
	
	Destroy(loo_xmlhttp)
End Try

return true
end function

public function boolean of_atualizar_entrega (long pl_cd_filial, long pl_nr_pedido, long pl_nr_sequencial, string ps_id_situacao, string ps_id_comunicacao, ref string ps_log);
Update pedido_ecommerce_entrega
set id_comunicacao_pendente = :ps_id_comunicacao,
	id_situacao = :ps_id_situacao
where cd_filial_ecommerce = :pl_cd_filial
	and nr_pedido = :pl_nr_pedido
	and nr_sequencial = :pl_nr_sequencial;

if sqlca.sqlcode = -1 then
	ps_log = 'Problemas ao inserir registro na tabela pedido_ecommerce_entrega_rast: ' + sqlca.sqlerrtext
	return false
ENd if


return true
end function

public function boolean of_grava_rastreio_total (long pl_cd_filial, long pl_nr_pedido, long pl_nr_sequencial, string ps_objeto, string ps_nr_pedido_ecommerce, ref boolean pb_novo_rastreio, ref string ps_log);string ls_retorno
String ls_tipo, ls_status, ls_data, ls_hora, ls_descricao, ls_local, ls_cidade, ls_uf
String ls_de_objeto, ls_de_objeto_ant
String ls_status_finalizado
long ll_for, ll_find
long ll_nr_sequencial
long ll_existe

datetime ldh_status
boolean lb_sucesso= false


Try
	
	if ps_objeto = '' or isnull(ps_objeto) Then
		ll_find = ids_rastreio_total.find('nr_pedido_ecommerce = "' + ps_nr_pedido_ecommerce + '"', 1, ids_rastreio_total.rowcount() )
		
		if ll_find = 0 then 
			return true
		ENd if
		
		ids_rastreio_total.setfilter('nr_pedido_ecommerce = "' + ps_nr_pedido_ecommerce + '"')
		
	Else	
		ll_find = ids_rastreio_total.find('de_objeto = "' + ps_objeto + '"', 1, ids_rastreio_total.rowcount() )
		
		if ll_find = 0 then return true
		
		ids_rastreio_total.setfilter('de_objeto = "' + ps_objeto + '"')
		
	End if
	
	ids_rastreio_total.filter()
	
	ids_rastreio_total.setsort('de_objeto, dh_status')
	ids_rastreio_total.sort()
	
	ll_nr_sequencial = 0
	
	pb_novo_rastreio = false
	
	for ll_for = 1 to ids_rastreio_total.rowcount( )
		
		ls_status_finalizado = ''
		
		ls_status = ids_rastreio_total.getitemstring(ll_for, 'cd_status' )
		ls_descricao = ids_rastreio_total.getitemstring(ll_for, 'de_status' )
		ls_de_objeto = ids_rastreio_total.getitemstring(ll_for, 'de_objeto' )
		ldh_status = ids_rastreio_total.getitemDatetime(ll_for, 'dh_status' )
		
		if ps_objeto <> '' and not isnull( ps_objeto ) and ps_objeto <> ls_de_objeto Then
			
			Continue
		
		Elseif ( ps_objeto = '' or isnull(ps_objeto) ) then
			
			ll_existe = 0
			
			Select count(*)
			into :ll_existe
			from pedido_ecommerce_entrega
			where  cd_filial_ecommerce = :pl_cd_filial
				and nr_pedido = :pl_nr_pedido
				and de_objeto = :ls_de_objeto;
				
			if sqlca.sqlcode = -1 then
				ps_log = 'Problemas ao consultar a tabela pedido_ecommerce_entrega: ' + sqlca.sqlerrtext
				return false
			ENd if	
				
			if ll_existe > 0 Then Continue	
							
			Update pedido_ecommerce_entrega
			set de_objeto = :ls_de_objeto
			where  cd_filial_ecommerce = :pl_cd_filial
				and nr_pedido = :pl_nr_pedido
				and nr_sequencial = :pl_nr_sequencial;
			
			if sqlca.sqlcode = -1 then
				ps_log = 'Problemas ao atualizar registro na tabela pedido_ecommerce_entrega: ' + sqlca.sqlerrtext
				return false
			ENd if	
			
			ps_objeto = ls_de_objeto
			
		End if

		ll_existe = 0
			
		select count(*)
		into :ll_existe
		from pedido_ecommerce_entrega_rast
		where cd_filial_ecommerce = :pl_cd_filial
			and nr_pedido = :pl_nr_pedido
			and nr_sequencial = :pl_nr_sequencial
			and dh_status = :ldh_status
			and cd_status = :ls_status;
			
		if sqlca.sqlcode = -1 then
			ps_log = 'Problemas ao consultar a tabela pedido_ecommerce_entrega_rast: ' + sqlca.sqlerrtext
			return false
		ENd if	
		
		if isnull(ll_existe) then ll_existe = 0
		
		if ll_existe > 0 Then Continue
		
		Select max(nr_sequencial_rast)
		into :ll_nr_sequencial
		from pedido_ecommerce_entrega_rast
		where cd_filial_ecommerce = :pl_cd_filial
			and nr_pedido = :pl_nr_pedido
			and nr_sequencial = :pl_nr_sequencial;
			
		if ll_nr_sequencial = 0 or isnull(ll_nr_sequencial) Then
			ll_nr_sequencial = 1
		Else
			ll_nr_sequencial++
		ENd if
		
		insert into pedido_ecommerce_entrega_rast (cd_filial_ecommerce, 
																	nr_pedido, 
																	nr_sequencial, 
																	nr_sequencial_rast,
																	cd_status, 
																	de_status,
																	dh_status,
																	dh_inclusao)
			Values (:pl_cd_filial,
						:pl_nr_pedido,
						:pl_nr_sequencial,
						:ll_nr_sequencial,
						:ls_status,
						:ls_descricao,
						:ldh_status,
						getdate() );
						
			if sqlca.sqlcode = -1 then
				ps_log = 'Problemas ao inserir registro na tabela pedido_ecommerce_entrega_rast: ' + sqlca.sqlerrtext
				return false
			ENd if
			
		pb_novo_rastreio = True
			
	next
	
	lb_sucesso = true
	
CATCH (runtimeerror er)   
	ps_log = er.GetMessage()
	return false 
Finally
	ids_rastreio_total.setfilter('')
	ids_rastreio_total.filter()
	ids_rastreio_total.setsort('')
	ids_rastreio_total.sort()
End Try

return true
end function

public function boolean of_processa_pedido_rastreamento (string ps_rede_filial, long pl_cd_filial);string ls_objeto
string ls_de_cod_rast_correio
string ls_rastreio
string ls_id_tipo_entrega
string ls_nr_pedido_ecommerce
string ls_comunicacao_pendente
string ls_id_situacao
string ls_log
string ls_tipo_pedido

long ll_linhas, ll_for
long ll_nr_sequencial
long ll_nr_pedido
long ll_cd_filial_ecommerce

Date ldt_consulta

boolean lb_executar_total = True
boolean lb_sucesso
boolean lb_ok=true
boolean lb_novo_rastreio = false
boolean lb_rastreio_finalizado = false
boolean lb_pedido_entregue = false

uo_ge501_correios luo_correios
uo_ge501_total_express luo_total
uo_ge501_jadlog luo_jadlog

dc_uo_ds_base lds_entrega

try 
	
	luo_jadlog = create uo_ge501_jadlog
	
	lds_entrega = create dc_uo_ds_base
	ids_rastreio_total = create dc_uo_ds_base
	ids_situacao_entrega = create dc_uo_ds_base
	ids_rastreio_jadlog = create dc_uo_ds_base
	
	lds_entrega.of_changedataobject( 'ds_ge501_pedido_ecommerce_entrega' )
	ids_rastreio_total.of_changedataobject( 'ds_ge501_pedido_ecommerce_rastreio' )
	ids_situacao_entrega.of_changedataobject( 'ds_ge501_pedido_ecommerce_entrega_sit' )
	ids_rastreio_jadlog.of_changedataobject( 'ds_ge501_pedido_ecommerce_entrega_rast' )

	ldt_consulta = date(gf_getserverdate())
	ldt_consulta = relativedate(ldt_consulta, -1)
	
	if lb_executar_total = true Then
		if pl_cd_filial <> 786 Then
			//Primeiro carrega o rastreio da Total Express:
			if not isvalid(luo_total) then luo_total = create uo_ge501_total_express
			
			w_aguarde_3.wf_settext('Carregando rastreio Total Express...', 3)
			
			if Not luo_total.of_rastrear_pedido( pl_cd_filial, ldt_consulta, True, ref ids_rastreio_total, ref ls_log) then return false
			
			w_aguarde_3.wf_settext('Rastreio Total Express carregado com sucesso.', 3)
		End if
	End if
	
	ll_linhas = lds_entrega.retrieve(is_id_ecommerce, pl_cd_filial )
	
	w_aguarde_3.uo_progress_2.of_setmax(ll_Linhas)
	
	for ll_for = 1 to ll_linhas
		
		lb_novo_rastreio = false
		lb_rastreio_finalizado = false
		lb_pedido_entregue = false
		
		ll_cd_filial_ecommerce = lds_entrega.getitemNumber(ll_for, 'cd_filial_ecommerce')
		ll_nr_pedido = lds_entrega.getitemNumber(ll_for, 'nr_pedido')
		ll_nr_sequencial = lds_entrega.getitemNumber(ll_for, 'nr_sequencial')
		ls_objeto = lds_entrega.getitemString(ll_for, 'de_objeto')
		ls_id_tipo_entrega = lds_entrega.getitemString(ll_for, 'id_tipo_entrega')
		ls_nr_pedido_ecommerce = lds_entrega.getitemString(ll_for, 'nr_pedido_ecommerce')
		ls_comunicacao_pendente = lds_entrega.getitemString(ll_for, 'id_comunicacao_pendente')
		ls_id_situacao = lds_entrega.getitemString(ll_for, 'id_situacao')
		ls_de_cod_rast_correio = lds_entrega.getitemString(ll_for, 'de_codigo_rastreamento_correio')
		ls_tipo_pedido = lds_entrega.getitemString(ll_for, 'id_tipo_pedido')
		
		iuo_comum_vtex.is_nr_pedido_ecommerce = ls_nr_pedido_ecommerce
		iuo_comum_vtex.il_cd_filial_pedido = pl_cd_filial
		
		w_aguarde_3.wf_settext('Pedido: ' + ls_nr_pedido_ecommerce + ' [' + string(ll_for) + ' de ' + string(ll_linhas) + ']', 3)
		w_aguarde_3.wf_settext('Objeto: ' + ls_objeto , 4)
		
		if ls_id_situacao = 'A' Then
		
			Choose case ls_id_tipo_entrega
					
				Case 'JAD' //Jadlog
					
					ids_rastreio_jadlog.reset()
					
					if Not luo_jadlog.of_executar( 'RASTREIO', ll_cd_filial_ecommerce, ll_nr_pedido, ref ids_rastreio_jadlog, ref ls_log) Then 
						iuo_comum_vtex.of_grava_log_item( il_cd_filial_ecommerce, il_Seq_Log, ref ls_Log, ls_Log )
						is_Situacao = 'E'
						w_aguarde_3.uo_progress_2.of_setprogress(ll_for)
						ls_Log=''
						Continue
					ENd if
					
					If Not this.of_grava_rastreio_jadlog( ll_cd_filial_ecommerce, ll_nr_pedido, ll_nr_sequencial, ref lb_novo_rastreio, ref ls_log ) then
						iuo_comum_vtex.of_grava_log_item( il_cd_filial_ecommerce, il_Seq_Log, ref ls_Log, ls_Log )
						is_Situacao = 'E'
						w_aguarde_3.uo_progress_2.of_setprogress(ll_for)
						ls_Log=''
						Continue
					ENd if
					
				Case 'ECT' //Correios
			
					if (ls_objeto = '' or isnull(ls_objeto)) and (ls_de_cod_rast_correio = '' or isnull(ls_de_cod_rast_correio)) then
						ls_log = 'C$$HEX1$$f300$$ENDHEX$$digo de rastreamento dos correios n$$HEX1$$e300$$ENDHEX$$o encontrado.'
						iuo_comum_vtex.of_grava_log_item( il_cd_filial_ecommerce, il_Seq_Log, ref ls_Log, ls_Log )
						is_Situacao = 'E'
						w_aguarde_3.uo_progress_2.of_setprogress(ll_for)
						ls_Log=''
						Continue
					ENd if
					
					if (ls_objeto = '' or isnull(ls_objeto)) or ( ls_objeto <> ls_de_cod_rast_correio) Then
						ls_objeto = ls_de_cod_rast_correio
						
						Update pedido_ecommerce_entrega
						set de_objeto = :ls_objeto
						where cd_filial_ecommerce = :ll_cd_filial_ecommerce
							and nr_pedido = :ll_nr_pedido
							and nr_sequencial = :ll_nr_sequencial;
							
							if sqlca.sqlcode = -1 then
								ls_Log = 'Problemas ao atualizar a tabela pedido_eecommerce_entrega: ' + sqlca.sqlerrtext
								gf_ge501_rollback(SQLCA)
								iuo_comum_vtex.of_grava_log_item( il_cd_filial_ecommerce, il_Seq_Log, ref ls_Log, ls_Log )
								is_Situacao = 'E'
								w_aguarde_3.uo_progress_2.of_setprogress(ll_for)
								ls_Log=''
								Continue	
							End if
							
							If Not gf_ge501_commit(SQLCA) Then Return False
						
					End if
			
					if not isvalid(luo_correios) then luo_correios = create uo_ge501_correios
					
					lb_ok = false
					
					if luo_correios.of_consulta_rastreio( ls_objeto, ref ls_rastreio, ref ls_log ) then
						if luo_correios.of_pedido_grava_rastreio( ll_cd_filial_ecommerce, ll_nr_pedido, ll_nr_sequencial, ls_rastreio, ref lb_novo_rastreio, ref ls_log ) then 
							lb_ok = true
						End if
					End if
					
					If lb_ok = false Then
						lb_ok = true
						gf_ge501_rollback(SQLCA)
						iuo_comum_vtex.of_grava_log_item( il_cd_filial_ecommerce, il_Seq_Log, ref ls_Log, ls_Log )
						is_Situacao = 'E'
						w_aguarde_3.uo_progress_2.of_setprogress(ll_for)
						ls_Log=''
						Continue
					End if
					
				Case 'TOT' //Total Express
					
					If Not this.of_grava_rastreio_total( ll_cd_filial_ecommerce, ll_nr_pedido, ll_nr_sequencial, ls_objeto, ls_nr_pedido_ecommerce, ref lb_novo_rastreio, ref ls_log) then 
						gf_ge501_rollback(SQLCA)
						iuo_comum_vtex.of_grava_log_item( il_cd_filial_ecommerce, il_Seq_Log, ref ls_Log, ls_Log )
						is_Situacao = 'E'
						w_aguarde_3.uo_progress_2.of_setprogress(ll_for)
						ls_Log=''
						Continue			
					end if
					
			End Choose
			
			//Verificar se deve finalizar o rastreamento
			if Not this.of_verifica_finalizado(ll_cd_filial_ecommerce, ll_nr_pedido, ll_nr_sequencial, ls_id_tipo_entrega, ref lb_rastreio_finalizado, ref lb_pedido_entregue, ref ls_log ) then 
				gf_ge501_rollback(SQLCA)
				iuo_comum_vtex.of_grava_log_item( il_cd_filial_ecommerce, il_Seq_Log, ref ls_Log, ls_Log )
				is_Situacao = 'E'
				w_aguarde_3.uo_progress_2.of_setprogress(ll_for)
				ls_Log=''
				Continue			
			End if
			
			if lb_rastreio_finalizado = True Then
				ls_id_situacao = 'F'
			ENd if
			
			if lb_pedido_entregue = True Then
				//Alterar situacao do pedido para Entregue:
				if Not this.of_atualizar_pedido_entregue( ll_cd_filial_ecommerce, ll_nr_pedido, ref ls_log) then
					gf_ge501_rollback(SQLCA)
					iuo_comum_vtex.of_grava_log_item( il_cd_filial_ecommerce, il_Seq_Log, ref ls_Log, ls_Log )
					is_Situacao = 'E'
					w_aguarde_3.uo_progress_2.of_setprogress(ll_for)
					ls_Log=''
					Continue			
				End if
				
			ENd if
			
			If Not gf_ge501_commit(SQLCA) Then Return False
			
		End if
		
		if lb_novo_rastreio = True or ls_comunicacao_pendente = 'S' Then
				
			if Not this.of_disparar_email( ll_cd_filial_ecommerce, ll_nr_pedido, ll_nr_sequencial, ref ls_log) Then 
				
				//Grava LOG mas continua o processo:
				iuo_comum_vtex.of_grava_log_item( il_cd_filial_ecommerce, il_Seq_Log, ref ls_Log, ls_Log )
				is_Situacao = 'E'
				ls_Log=''
				
				If Not this.of_atualizar_entrega( ll_cd_filial_ecommerce, ll_nr_pedido, ll_nr_sequencial, ls_id_situacao, 'S' , ref ls_log ) then 
					gf_ge501_rollback(SQLCA)
					iuo_comum_vtex.of_grava_log_item( il_cd_filial_ecommerce, il_Seq_Log, ref ls_Log, ls_Log )
					is_Situacao = 'E'
					w_aguarde_3.uo_progress_2.of_setprogress(ll_for)
					ls_Log=''
					Continue	
				End if
				
				If Not gf_ge501_commit(SQLCA) Then Return False
				
			Else
					
				If Not this.of_atualizar_entrega( ll_cd_filial_ecommerce, ll_nr_pedido, ll_nr_sequencial, ls_id_situacao, 'N' , ref ls_log ) then
					gf_ge501_rollback(SQLCA)
					iuo_comum_vtex.of_grava_log_item( il_cd_filial_ecommerce, il_Seq_Log, ref ls_Log, ls_Log )
					is_Situacao = 'E'
					w_aguarde_3.uo_progress_2.of_setprogress(ll_for)
					ls_Log=''
					Continue	
				End if
				
				If Not gf_ge501_commit(SQLCA) Then Return False
				
			End if
		
		Elseif ls_id_situacao = 'F' Then //Rastreio finalizado
		
			If Not this.of_atualizar_entrega( ll_cd_filial_ecommerce, ll_nr_pedido, ll_nr_sequencial, ls_id_situacao, 'N' , ref ls_log ) then
				gf_ge501_rollback(SQLCA)
				iuo_comum_vtex.of_grava_log_item( il_cd_filial_ecommerce, il_Seq_Log, ref ls_Log, ls_Log )
				is_Situacao = 'E'
				w_aguarde_3.uo_progress_2.of_setprogress(ll_for)
				ls_Log=''
				Continue	
			End if
			
			If Not gf_ge501_commit(SQLCA) Then Return False
				
		End if
		
		if Not iuo_comum_vtex.of_grava_log_item(il_cd_filial_ecommerce, il_Seq_Log, ref ls_Log, ls_Log ) Then Return false
		
		w_aguarde_3.uo_progress_2.of_setprogress(ll_for)
		
	next

	lb_sucesso = True
	
	w_aguarde_3.uo_progress_2.of_reset()

Finally
	
	if Not lb_sucesso then 
		is_situacao = 'E'
		
		gf_ge501_RollBack(SQLCA)
		
		if ls_log <> '' and not isnull(ls_log) Then
			ls_log = is_objeto + 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_pedido_rastreamento ~n' + ls_log
		ENd if
		
		// Atualiza log com erro
		if Not iuo_comum_vtex.of_grava_log_item(il_cd_filial_ecommerce, il_Seq_Log, ref ls_Log, ls_Log) Then Return false
	
	End If
	
	if isvalid(lds_entrega) then destroy(lds_entrega)
	if isvalid(ids_rastreio_total) then destroy(ids_rastreio_total)
	if isvalid(luo_correios) then destroy(luo_correios)
	if isvalid(luo_total) then destroy(luo_total)

End try

return true
end function

public function boolean of_verifica_finalizado (long pl_cd_filial, long pl_nr_pedido, long pl_nr_sequencial, string ps_id_tipo_entrega, ref boolean pb_finalizado, ref boolean pb_entregue, ref string ps_log);string ls_situacao_entrega
long ll_linhas, ll_find

Try

	ll_linhas = ids_situacao_entrega.retrieve( pl_cd_filial, pl_nr_pedido, pl_nr_sequencial , ps_id_tipo_entrega)
	
	if ll_linhas > 0 Then
		pb_finalizado = True
		
		ll_find = ids_situacao_entrega.find('de_situacao_entrega = "ENTREGUE"', 1, ids_situacao_entrega.rowcount( ) )
		
		if ll_find > 0 Then
			pb_entregue = True
		Else
			pb_entregue = false
		End if
		
	elseif ll_linhas < 0 Then
		ps_log = 'Problemas ao consultar a tabela ecommerce_situacao_entrega : ' + sqlca.is_lasterrortext
		return false
		
	Else
		pb_finalizado = false
		pb_entregue = false
	End if

Finally
	ids_situacao_entrega.reset()
	
	if ps_log <> '' and not isnull(ps_log) Then ps_log = 'Fun$$HEX2$$e700e300$$ENDHEX$$o: of_verifica_finalizado; ' + ps_log
	
End Try

return true
end function

public function boolean of_atualizar_pedido_entregue (long pl_cd_filial, long pl_nr_pedido, ref string ps_log);
//Altera situacao para Entregue.
//dh_entrega permanece nulo, pois ser$$HEX1$$e100$$ENDHEX$$ preenchido na interface de status que ir$$HEX1$$e100$$ENDHEX$$ enviar a situacao de entregue para a VTEX.
Update pedido_ecommerce
set id_situacao = 'E'
where cd_filial_ecommerce = :pl_cd_filial
	and nr_pedido = :pl_nr_pedido;

if sqlca.sqlcode = -1 then
	ps_log = 'Problemas ao inserir registro na tabela pedido_ecommerce: ' + sqlca.sqlerrtext
	return false
ENd if

return true
end function

public function boolean of_grava_rastreio_jadlog (long pl_cd_filial, long pl_nr_pedido, long pl_nr_sequencial, ref boolean pb_novo_rastreio, ref string ps_log);string ls_retorno
String ls_tipo, ls_status, ls_data, ls_hora, ls_descricao, ls_local, ls_cidade, ls_uf
String ls_de_local, ls_de_objeto_ant
String ls_status_finalizado
long ll_for, ll_find
long ll_nr_sequencial
long ll_existe

datetime ldh_status
boolean lb_sucesso= false

ids_rastreio_jadlog.setsort( 'dh_status')
ids_rastreio_jadlog.sort( )

for ll_for = 1 to ids_rastreio_jadlog.rowcount()

	//ids_rastreio_jadlog

	ll_nr_sequencial = 0
	
	pb_novo_rastreio = false
		
	ls_status_finalizado = ''
	
	ls_status = ids_rastreio_jadlog.getitemstring(ll_for, 'de_status' )
	ls_descricao = ids_rastreio_jadlog.getitemstring(ll_for, 'de_status' )
	ls_de_local = ids_rastreio_jadlog.getitemstring(ll_for, 'de_local' )
	ldh_status = ids_rastreio_jadlog.getitemDatetime(ll_for, 'dh_status' )
		
	ls_status = mid(ls_status,1,10)	
		
	ll_existe = 0
			
		select count(*)
		into :ll_existe
		from pedido_ecommerce_entrega_rast
		where cd_filial_ecommerce = :pl_cd_filial
			and nr_pedido = :pl_nr_pedido
			and nr_sequencial = :pl_nr_sequencial
			and dh_status = :ldh_status
			and cd_status = :ls_status;
			
		if sqlca.sqlcode = -1 then
			ps_log = 'Problemas ao consultar a tabela pedido_ecommerce_entrega_rast: ' + sqlca.sqlerrtext
			return false
		ENd if	
		
		if isnull(ll_existe) then ll_existe = 0
		
		if ll_existe > 0 Then Continue
		
		Select max(nr_sequencial_rast)
		into :ll_nr_sequencial
		from pedido_ecommerce_entrega_rast
		where cd_filial_ecommerce = :pl_cd_filial
			and nr_pedido = :pl_nr_pedido
			and nr_sequencial = :pl_nr_sequencial;
			
		if ll_nr_sequencial = 0 or isnull(ll_nr_sequencial) Then
			ll_nr_sequencial = 1
		Else
			ll_nr_sequencial++
		ENd if
		
		insert into pedido_ecommerce_entrega_rast (cd_filial_ecommerce, 
																	nr_pedido, 
																	nr_sequencial, 
																	nr_sequencial_rast,
																	cd_status, 
																	de_status,
																	dh_status,
																	dh_inclusao,
																	de_local)
			Values (:pl_cd_filial,
						:pl_nr_pedido,
						:pl_nr_sequencial,
						:ll_nr_sequencial,
						:ls_status,
						:ls_descricao,
						:ldh_status,
						getdate(),
						:ls_de_local);
						
			if sqlca.sqlcode = -1 then
				ps_log = 'Problemas ao inserir registro na tabela pedido_ecommerce_entrega_rast: ' + sqlca.sqlerrtext
				return false
			ENd if
			
	pb_novo_rastreio = True
	
	lb_sucesso = true
	
Next

return true
end function

on uo_ge501_pedido_rastreamento.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge501_pedido_rastreamento.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;is_objeto = 'Objeto: ' + this.classname() + '~n'

SetNull(is_pedido_debug)
end event

