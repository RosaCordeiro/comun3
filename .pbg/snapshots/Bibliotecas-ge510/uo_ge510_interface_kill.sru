HA$PBExportHeader$uo_ge510_interface_kill.sru
forward
global type uo_ge510_interface_kill from nonvisualobject
end type
end forward

global type uo_ge510_interface_kill from nonvisualobject
end type
global uo_ge510_interface_kill uo_ge510_interface_kill

forward prototypes
public function boolean of_executar ()
public subroutine of_matar_processo (string ps_processo)
public subroutine of_envia_email (long pl_cd_mensagem, string ps_mensagem, long pl_nr_tolerancia, long pl_nr_tempo, long pl_cd_filial, string ps_id_ecommerce)
public function boolean of_verifica_carga_completa (string ps_id_ecommerce, string ps_rede, long pl_cd_filial, ref boolean pb_carga_completa, ref boolean pb_filial_hub, ref string ps_log)
end prototypes

public function boolean of_executar ();long ll_for
long ll_linhas
long ll_nr_tolerancia
long ll_nr_tempo
long ll_cd_filial
long ll_cd_tipo_log

string ls_rede
string ls_processo
string ls_de_interface
string ls_nr_id
string ls_log
string ls_id_ecommerce
string ls_nm_ecommerce
string ls_de_tarefa
boolean lb_sucesso = false
boolean lb_carga_completa = false
boolean lb_filial_hub = false

dc_uo_ds_base lds_dados

Try

	lds_dados = create dc_uo_ds_base
	lds_dados.of_changedataobject( 'ds_ge510_ecommerce_log_historico' )
	lds_dados.of_settransobject( SQLCA )
	
	ll_linhas = lds_dados.retrieve(gvo_aplicacao.is_ComputerName)
	
	if ll_linhas = 0 Then return true
	
	for ll_for = 1 to ll_linhas
		
		lb_filial_hub = false
		lb_carga_completa = false
		
		ls_nr_id = lds_dados.getitemString(ll_for,'nr_id')
		ll_nr_tolerancia = lds_dados.getitemNumber(ll_for,'nr_tolerancia')
		ls_processo = lds_dados.getitemString(ll_for,'de_processo')
		ll_nr_tempo = lds_dados.getitemNumber(ll_for,'nr_tempo')
		ls_de_interface = lds_dados.getitemString(ll_for,'de_tipo')
		ll_cd_filial = lds_dados.getitemNumber(ll_for,'cd_filial')
		ls_de_tarefa = lds_dados.getitemString(ll_for,'de_tarefa')
		ls_rede = lds_dados.getitemString(ll_for,'id_rede_filial')
		ll_cd_tipo_log = lds_dados.getitemNumber(ll_for,'cd_tipo_log')
		
		ls_id_ecommerce = lds_dados.getitemString(ll_for,'id_ecommerce')
		ls_nm_ecommerce = lds_dados.getitemString(ll_for,'nm_ecommerce')
		
		if ll_nr_tolerancia = 0 or isnull(ll_nr_tolerancia) Then Continue
		
		if Not Isnumber(ls_processo) Then Continue
		
		if ll_cd_tipo_log = 5 Then
			if Not this.of_verifica_carga_completa( ls_id_ecommerce, ls_rede, ll_cd_filial, ref lb_carga_completa, ref lb_filial_hub, ref ls_log ) Then return false
		else
			lb_carga_completa = false
		end if
		
		//Se estiver realizando uma carga completa adiciona mais minutos de tolerancia.
		if lb_carga_completa = True Then
			ll_nr_tolerancia = ll_nr_tolerancia + 480
		else
			if lb_filial_hub = True Then
				ll_nr_tolerancia = ll_nr_tolerancia + 60
			end if
		end if
		
		if ll_nr_tempo > ll_nr_tolerancia Then
		
			this.of_matar_processo( ls_processo )	
			
			Update ecommerce_log_historico
			set dh_termino = getdate(),
				de_observacao = 'PROCESSO INTERROMPIDO DE FORMA AUTOMATICA',
				id_situacao = 'P'
			Where nr_id = :ls_nr_id
			Using SQLCA;
			
			if sqlca.sqlcode = -1 then
				ls_log = 'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_executar~nProblemas ao atualizar a tabela "ecommerce_log_historico": ~n' + sqlca.sqlerrtext
				return false
			end if
			
			Update ecommerce_log_resumo
			set id_situacao = 'P'
			Where cd_filial = :ll_cd_filial
				and cd_tipo_log = :ll_cd_tipo_log
				and id_ecommerce = :ls_id_ecommerce
			Using SQLCA;
			
			if sqlca.sqlcode = -1 then
				ls_log = 'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_executar~nProblemas ao atualizar a tabela "ecommerce_log_resumo": ~n' + sqlca.sqlerrtext
				return false
			end if
			
			ls_de_interface = ls_de_interface + ' - ' + ls_de_tarefa
			ls_id_ecommerce = ls_id_ecommerce + ' - ' + ls_nm_ecommerce
			
			//Enviar Email
			this.of_envia_email( 219, ls_de_interface, ll_nr_tolerancia, ll_nr_tempo, ll_cd_filial, ls_id_ecommerce)
			
		end if
		
	next

	lb_sucesso = True
	
Finally
	
	if lb_sucesso = True Then
		SQLCA.of_commit( )
	elseif ll_linhas > 0 then
		SQLCA.of_rollback( )
		
		if ls_log <> '' and not isnull(ls_log) Then
			messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_log)
		end if
		
	end if
	
	destroy(lds_dados)
	
end Try

return true
end function

public subroutine of_matar_processo (string ps_processo);OleObject wsh

wsh = CREATE OleObject
wsh.ConnectToNewObject( "MSScriptControl.ScriptControl" )
wsh.language = "vbscript"
wsh.AddCode('function terminateproc() ~n ' + &
					 'strComputer = "." ~n ' + &
					 'Set objWMIService = GetObject("winmgmts:\\" & strComputer & "\root\cimv2") ~n ' + &
					 'Set colItems = objWMIService.ExecQuery("Select * from Win32_Process where ProcessId = ' + ps_processo + '") ~n ' + &
					 'For Each objItem in colItems ~n ' + &
					 '     objItem.Terminate ~n ' + &
					 'Next ~n ' + &
					 'end function ~n ' )
wsh.executestatement('terminateproc()')
wsh.DisconnectObject()
DESTROY wsh
end subroutine

public subroutine of_envia_email (long pl_cd_mensagem, string ps_mensagem, long pl_nr_tolerancia, long pl_nr_tempo, long pl_cd_filial, string ps_id_ecommerce);String lvs_Mensagem

lvs_Mensagem =	'O seguinte processo foi interrompido de forma autom$$HEX1$$e100$$ENDHEX$$tica: <br>'+ &
						'Interface: <b>' + ps_mensagem +'</b><br>' + &
						'Ecommerce: <b>' + ps_id_ecommerce +'</b><br>' + &
						'Filial: <b>' + String(pl_cd_filial) +'</b><br>' + &
						'Host: <b>'	 + gvo_aplicacao.is_computername +'</b><br>' + &
						'Toler$$HEX1$$e200$$ENDHEX$$ncia: <b>'	 + string(pl_nr_tolerancia) + ' min.' +'</b><br>' + &
						'Tempo parado: <b>' + string(pl_nr_tempo) + ' min.' + '</b>'
						
gf_ge202_envia_email_automatico(	pl_cd_mensagem	, & 	
												''						, &    	
												lvs_Mensagem		, & 
												{''})			
end subroutine

public function boolean of_verifica_carga_completa (string ps_id_ecommerce, string ps_rede, long pl_cd_filial, ref boolean pb_carga_completa, ref boolean pb_filial_hub, ref string ps_log);long ll_existe,ll_cd_filial_hub

Select 1, cd_filial_hub
into :ll_existe, :ll_cd_filial_hub
From ecommerce_rede_filial
where id_ecommerce = :ps_id_ecommerce
    and id_rede_filial  = :ps_rede
    and cd_filial = :pl_cd_filial
    and ( DATEPART(dd,getdate()) = coalesce(nr_dia_carga_completa, 0) or cast(dh_proxima_carga_saldo_comp as date) = cast(getdate() as date) )
    and cast(dh_carga_saldo_completa as date) <> cast(getdate() as date);
	 
If SQLCA.sqlcode = -1 then 
	ps_log = this.classname() + '; Fun$$HEX2$$e700e300$$ENDHEX$$o: of_verifica_carga_completa; Problemas ao consultar a tabela "ecommerce_rede_filial": ' + sqlca.sqlerrtext
	return false
end if

if ll_existe > 0 then
	pb_carga_completa = True
else
	pb_carga_completa = False
end if
if ll_cd_filial_hub > 0 Then
	pb_filial_hub = True
else
	pb_filial_hub = false
end if

return true
end function

on uo_ge510_interface_kill.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge510_interface_kill.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

