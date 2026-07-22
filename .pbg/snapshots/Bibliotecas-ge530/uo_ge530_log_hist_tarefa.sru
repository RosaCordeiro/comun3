HA$PBExportHeader$uo_ge530_log_hist_tarefa.sru
forward
global type uo_ge530_log_hist_tarefa from nonvisualobject
end type
end forward

global type uo_ge530_log_hist_tarefa from nonvisualobject
end type
global uo_ge530_log_hist_tarefa uo_ge530_log_hist_tarefa

type variables
dc_uo_api io_API

Long il_Id_Log

Long il_Processo
end variables

forward prototypes
public function boolean of_proximo_log (ref long al_proximo_sequencial, ref string as_log)
public function boolean of_insere_log_historico_tarefa (integer ai_tarefa)
public function boolean of_atualiza_termino_log_tarefa (long al_id)
public function boolean of_matar_processo (integer pi_tarefa)
end prototypes

public function boolean of_proximo_log (ref long al_proximo_sequencial, ref string as_log);Long ll_Proximo_Seq

Select coalesce(max(nr_id),0)
 Into :ll_Proximo_Seq
From log_historico_tarefa
Using SqlCa;

Choose Case Sqlca.SqlCode
	Case 0
		al_proximo_sequencial = ll_Proximo_Seq + 1
	Case 100
		al_proximo_sequencial = 1
	Case -1
		as_Log = "Erro ao localizar o pr$$HEX1$$f300$$ENDHEX$$ximo sequencial na tabela de log_historico_tarefa."
		Return False
End Choose

Return True
end function

public function boolean of_insere_log_historico_tarefa (integer ai_tarefa);Long 	ll_Nr_Processo
		
String ls_Log, &
		ls_Host

Datetime ldh_Atual

ldh_Atual = gf_GetServerDate()

If This.of_proximo_log( Ref il_Id_Log, Ref ls_Log) Then

	ll_Nr_Processo = io_APi.of_get_idprocess()
	ls_Host			= gvo_aplicacao.is_ComputerName//io_API.of_getip_host( io_API.of_get_Host())

	Insert into log_historico_tarefa(nr_id, cd_tarefa, dh_inicio, nr_processo, de_host)
	Values(:il_Id_Log, :ai_Tarefa, :ldh_Atual, :ll_Nr_Processo, :ls_Host)
	Using SqlCa;
	
	SqlCa.Of_Commit()
End If

il_Processo = ll_Nr_Processo

Return True
end function

public function boolean of_atualiza_termino_log_tarefa (long al_id);DateTime ldth_Termino

ldth_Termino = gf_GetServerDate()

Update log_historico_tarefa
Set dh_termino = :ldth_Termino
Where nr_id = :al_Id
Using SqlCa;

SqlCa.of_Commit()

Return True

end function

public function boolean of_matar_processo (integer pi_tarefa);Boolean lb_Sucesso = False

Long 	ll_Linhas, &
		ll_For, &
		ll_Nr_Tolerancia, &
		ll_Nr_Tempo, &
		ll_nr_id, &
		ll_processo
		
String ls_De_Tarefa, &
		ls_Log

dc_uo_ds_base lds_dados

Try

	lds_dados = create dc_uo_ds_base
	lds_dados.of_changedataobject( 'ds_ge530_log_historico_tarefa' )
	lds_dados.of_settransobject( SQLCA )
	
	ll_linhas = lds_dados.retrieve(gvo_aplicacao.is_ComputerName, pi_Tarefa )
	
	if ll_linhas = 0 Then return true
	
	for ll_for = 1 to ll_linhas
		
		ll_nr_id 				= lds_dados.getitemNumber(ll_for,'nr_id')
		ll_nr_tolerancia 	= lds_dados.getitemNumber(ll_for,'nr_tolerancia')
		ll_processo 			= lds_dados.getitemNumber(ll_for,'nr_processo')
		ll_nr_tempo 			= lds_dados.getitemNumber(ll_for,'nr_tempo')
		ls_de_tarefa 		= lds_dados.getitemString(ll_for,'de_tarefa')
		
		if ll_nr_tolerancia = 0 or isnull(ll_nr_tolerancia) Then Continue
		
		if ll_processo = 0 Then Continue
		

		io_API.of_Kill_Process( String(ll_processo) )	
		
		Update log_historico_tarefa
		set dh_termino = getdate(),
			de_observacao = 'PROCESSO INTERROMPIDO DE FORMA AUTOMATICA'
		Where nr_id = :ll_nr_id
		Using SQLCA;
		
		If sqlca.sqlcode = -1 Then
			ls_log = 'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_executar~nProblemas ao atualizar a tabela "log_historico_tarefa": ~n' + sqlca.sqlerrtext
			Return False
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

on uo_ge530_log_hist_tarefa.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge530_log_hist_tarefa.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;io_API = Create dc_uo_Api
end event

event destructor;If IsValid(io_API) Then Destroy(io_API)
end event

