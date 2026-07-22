HA$PBExportHeader$uo_tarefa.sru
forward
global type uo_tarefa from nonvisualobject
end type
end forward

global type uo_tarefa from nonvisualobject
end type
global uo_tarefa uo_tarefa

type variables
Long Codigo
String Descricao
String Situacao

Boolean Localizado = False


Boolean Mostra_Mensagem = False

Private:
dc_uo_ds_base ivds_1
uo_transacao_remota ivo_intranet

CONSTANT Long EMAIL_PADRAO 				= 79		//C$$HEX1$$f300$$ENDHEX$$digo email padr$$HEX1$$e300$$ENDHEX$$o para envio de notifica$$HEX2$$e700f500$$ENDHEX$$es, utilizado quando n$$HEX1$$e300$$ENDHEX$$o houver um c$$HEX1$$f300$$ENDHEX$$digo 
																	//                                                configurado no campo cd_mensagem da tabela tarefa.
CONSTANT Long TEMPO_SMS 					= 3600	//Qtde em segundos para nova notifica$$HEX2$$e700e300$$ENDHEX$$o de SMS
CONSTANT Long TEMPO_EMAIL 				= 1800	//Qtde em segundos para nova notifica$$HEX2$$e700e300$$ENDHEX$$o de email
CONSTANT Long TEMPO_LOG 					= 900		//Qtde em segundos para nova notifica$$HEX2$$e700e300$$ENDHEX$$o de log (grava$$HEX2$$e700e300$$ENDHEX$$o na tabela log_tarefa)
CONSTANT Long EMAILS_SMS_HORA_1		= 4     	//N$$HEX1$$ba00$$ENDHEX$$ de emails necess$$HEX1$$e100$$ENDHEX$$rios terem sido disparados para o envio do SMS em hor$$HEX1$$e100$$ENDHEX$$rio comercial
CONSTANT Long EMAILS_SMS_HORA_2		= 2     	//N$$HEX1$$ba00$$ENDHEX$$ de emails necess$$HEX1$$e100$$ENDHEX$$rios terem sido disparados para o envio do SMS fora de hor$$HEX1$$e100$$ENDHEX$$rio comercial
end variables

forward prototypes
public subroutine of_inicializa ()
private function boolean of_localiza_codigo (long pl_tarefa)
public function boolean of_localiza (string ps_filtro)
private function boolean of_localiza_generica (string ps_filtro)
private subroutine of_erro (string ps_erro)
private function boolean of_recupera_tarefas (boolean pb_retrieve)
public function boolean of_verifica_tarefas (long pl_tarefa)
public function boolean of_verifica_tarefas ()
private function boolean of_notifica_tarefa (long pl_tarefa)
private function boolean of_grava_log (long pl_tarefa, string ps_tipo, string ps_log)
private function boolean of_reenvia_notificacao (long pl_tarefa, string ps_tipo)
end prototypes

public subroutine of_inicializa ();SetNull(Codigo)
SetNull(Descricao)

Localizado = False
end subroutine

private function boolean of_localiza_codigo (long pl_tarefa);Select 	cd_tarefa,
			de_tarefa,
			id_situacao
Into	:Codigo,
		:Descricao,
		:Situacao
From tarefa
Where cd_tarefa = :pl_tarefa
Using SQLCa;

Localizado = (SQLCa.SQLCode = 0)

If SQLCa.SQLCode = -1 Then
	If Mostra_Mensagem Then MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Erro ao localizar a tarefa.~r'+SQLCa.SQLErrText,StopSign!)
End If

Return Localizado
end function

public function boolean of_localiza (string ps_filtro);This.Of_inicializa( )

If IsNumber(ps_Filtro) Then
	If This.Of_Localiza_codigo(Long(ps_filtro)) Then
		Return Localizado
	End If
End If

Return This.Of_Localiza_generica(ps_filtro)
end function

private function boolean of_localiza_generica (string ps_filtro);String lvs_Tarefa

OpenWithParm(w_ge188_selecao_tarefa,ps_filtro)

lvs_Tarefa = Message.StringParm

If lvs_Tarefa = '' Then
	This.Of_Inicializa( )
Else
	This.Of_localiza_codigo(Long(lvs_Tarefa))
End if

Return Localizado
end function

private subroutine of_erro (string ps_erro);If Trim(ps_erro)<>'' Then
	If Mostra_Mensagem Then
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!',ps_erro,Exclamation!)
	Else
		gf_ge202_envia_email_automatico(EMAIL_PADRAO,'ERRO - Verifica$$HEX2$$e700e300$$ENDHEX$$o das Tarefas Autom$$HEX1$$e100$$ENDHEX$$ticas',ps_erro)
	End If
End If
end subroutine

private function boolean of_recupera_tarefas (boolean pb_retrieve);If Not IsValid(ivds_1) Then 
	ivds_1 = Create dc_uo_ds_base
	If Not ivds_1.Of_ChangeDataObject('dw_ge188_lista',False) Then This.Of_Erro('Erro ao alterar a dw_ge188_lista.')
End If

If pb_retrieve Then ivds_1.Retrieve()

Return True
end function

public function boolean of_verifica_tarefas (long pl_tarefa);Long lvl_Linha
Long lvl_Tarefa
Long lvl_Email

Datetime lvdh_Ult_Exec

String lvs_Tarefa
String lvs_Telefone
String lvs_SMS

This.of_Recupera_Tarefas(False)

ivds_1.Of_AppendWhere("dateadd(ss,nr_tolerancia, case when (dh_ultima_exec is null) or (dh_ultima_exec < coalesce(dh_prox_exec,dh_ultima_exec)) then coalesce(dh_prox_exec,coalesce(dh_ultima_exec,dh_cadastro)) else dh_ultima_exec end) < getDate()")
ivds_1.Of_AppendWhere("coalesce(nr_tolerancia,0) > 0")
ivds_1.Of_AppendWhere("cd_tarefa<>19")
ivds_1.Of_AppendWhere("id_situacao='A'")
If (Not IsNull(pl_tarefa)) and (pl_tarefa > 0) Then ivds_1.Of_AppendWhere("cd_tarefa="+String(pl_tarefa))
	
ivds_1.Retrieve()

For lvl_Linha = 1 To ivds_1.RowCount() 
	lvl_Tarefa	= ivds_1.Object.cd_tarefa	[lvl_Linha]
	
	This.Of_Notifica_Tarefa(lvl_Tarefa)
	
	If This.Of_Reenvia_Notificacao(lvl_Tarefa,'X') Then This.of_grava_log(lvl_Tarefa,'X','DATA ULT. EXEC. TAREFA ACIMA DA TOLER$$HEX1$$c200$$ENDHEX$$NCIA.')
Next

Return ivds_1.RowCount() > 0
end function

public function boolean of_verifica_tarefas ();Long lvl_Null

SetNull(lvl_Null)

Return This.of_Verifica_Tarefas(lvl_Null)
end function

private function boolean of_notifica_tarefa (long pl_tarefa);Long lvl_Find = 0
Long lvl_Tarefa
Long lvl_Email

Datetime lvdh_Ult_Exec
Datetime lvdh_Prox_Exec

String lvs_Tarefa
String lvs_SMS
String lvs_Fone
String lvs_Msg
String lvs_parametro
String lvs_Obs

If Not IsValid(ivds_1) Then This.of_Recupera_Tarefas(True)

lvl_Find = ivds_1.Find("cd_tarefa="+String(pl_tarefa),1,ivds_1.RowCount())

If lvl_Find > 0 Then
	lvl_Tarefa		= ivds_1.Object.cd_tarefa 					[lvl_Find]
	lvs_Tarefa		= ivds_1.Object.de_tarefa 					[lvl_Find]
	lvs_SMS			= ivds_1.Object.id_envia_sms 				[lvl_Find]
	lvs_Fone			= ivds_1.Object.de_telefone_sms			[lvl_Find]
	lvdh_Ult_Exec	= ivds_1.Object.dh_ultima_exec			[lvl_Find]
	lvl_Email			= ivds_1.Object.cd_mensagem_email		[lvl_Find]
	lvs_Obs			= ivds_1.Object.de_observacao			[lvl_Find]
	lvdh_Prox_Exec	= ivds_1.Object.dh_prox_exec				[lvl_Find]
	
	If (Not Mostra_Mensagem) and (IsNull(lvl_Email) or (lvl_Email = 0)) Then lvl_Email = EMAIL_PADRAO
	If (Not IsNull(lvl_Email)) and (lvl_Email > 0) Then
		If This.Of_Reenvia_Notificacao(lvl_Tarefa,'E') Then
			lvs_Msg = 	'Caro(a) Usu$$HEX1$$e100$$ENDHEX$$rio,<br><br>'+&
							'Favor verificar a tarefa '+String(lvl_Tarefa)+' - '+lvs_Tarefa+&
							' a $$HEX1$$fa00$$ENDHEX$$ltima execu$$HEX2$$e700e300$$ENDHEX$$o foi dia '+String(lvdh_Ult_Exec,'DD/MM')+' $$HEX1$$e000$$ENDHEX$$s '+String(lvdh_Ult_Exec,'HH:MM')+'.'
			If Not IsNull(lvdh_Prox_Exec) Then lvs_Msg += '<br>Pr$$HEX1$$f300$$ENDHEX$$xima execu$$HEX2$$e700e300$$ENDHEX$$o dia '+String(lvdh_Prox_Exec,'DD/MM')+' $$HEX1$$e000$$ENDHEX$$s '+String(lvdh_Prox_Exec,'HH:MM')+'.'
			If Trim(lvs_Obs)<>'' Then lvs_Msg += '<br><br><b>Observa$$HEX2$$e700f500$$ENDHEX$$es:</b><br>'+lvs_Obs
							
			gf_ge202_envia_email_automatico(lvl_Email,'ATEN$$HEX2$$c700c300$$ENDHEX$$O - Tarefa '+String(lvl_Tarefa)+' Off-Line',lvs_Msg)
			This.of_grava_log(lvl_Tarefa,'E','ENVIO EMAIL')
		End If
	End If
	
	If lvs_SMS = 'S' Then
		If Not IsValid(ivo_intranet) Then ivo_intranet = Create uo_transacao_remota
		
		If Trim(lvs_Fone)<>'' Then
			If This.Of_Reenvia_Notificacao(lvl_Tarefa,'S') Then
				lvs_Msg = 'Favor verificar a tarefa '+String(lvl_Tarefa)+', '+lvs_Tarefa+', a ult. exec. dia '+&
								String(lvdh_Ult_Exec,'DD/MM')+' as '+String(lvdh_Ult_Exec,'HH:MM')+'. '
				If Not IsNull(lvdh_Prox_Exec) Then lvs_Msg += 'Prox. exec. dia '+String(lvdh_Prox_Exec,'DD/MM')+' as '+String(lvdh_Prox_Exec,'HH:MM')+'.'
				lvs_parametro = "telefone=" + lvs_Fone + "&mensagem=" +gf_retira_acentos(lvs_Msg+'. '+lvs_Obs)
				ivo_intranet.of_Executa_Rotina_Intranet('sms_informatica', lvs_parametro )
				This.of_grava_log(lvl_Tarefa,'S','ENVIO SMS para '+lvs_Fone)
			End If
		End If
	End If
	
	If Mostra_Mensagem Then
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','A tarefa '+String(lvl_Tarefa)+' - '+lvs_Tarefa+' executou pela $$HEX1$$fa00$$ENDHEX$$ltima vez dia '+String(Day(Date(lvdh_Ult_Exec)))+&
						' $$HEX1$$e000$$ENDHEX$$s '+String(lvdh_Ult_Exec,'HH:MM')+'.',Exclamation!)
	End If
End If

Return (lvl_Find > 0)
end function

private function boolean of_grava_log (long pl_tarefa, string ps_tipo, string ps_log);insert into log_tarefa (cd_tarefa,dh_execucao,id_status,de_observacao)
values (:pl_tarefa, getDate(),:ps_tipo,:ps_log)
Using SQLCa;

If SQLCa.SQLCode = -1 Then
	//as vezes dois logs gravam no mesmo segundo e viola a PK
	Sleep(2)
	
	insert into log_tarefa (cd_tarefa,dh_execucao,id_status,de_observacao)
	values (:pl_tarefa, getDate(),:ps_tipo,:ps_log)
	Using SQLCa;
	
	If SQLCa.SQLCode = -1 Then
		This.Of_Erro('Falha na inclus$$HEX1$$e300$$ENDHEX$$o log para a tarefa '+String(pl_tarefa)+'.~r~n'+SQLCa.SQLErrText)
		SQLCa.Of_RollBack()
	Else
		SQLCa.Of_Commit()
	End If
Else
	SQLCa.Of_Commit()
End If

Return True
end function

private function boolean of_reenvia_notificacao (long pl_tarefa, string ps_tipo);Long lvl_Reenvio
Long lvl_Result
Long lvl_SMS

Choose Case ps_tipo
	Case 'S'	
		//Em dias da semana no hor$$HEX1$$e100$$ENDHEX$$rio comercial envia primeiro o email
		If (DayNumber(Today())>1) and (DayNumber(Today())<7) and (Now() > Time('07:30')) and (Now() < Time('17:48')) Then 
			lvl_SMS = EMAILS_SMS_HORA_1
		Else
			lvl_SMS = EMAILS_SMS_HORA_2
		End If
			
		//Verifica se j$$HEX1$$e100$$ENDHEX$$ houve ao menos duas notifica$$HEX2$$e700f500$$ENDHEX$$es por email enviada nos $$HEX1$$fa00$$ENDHEX$$ltimos 60 minutos
		select count(1)
		Into :lvl_Result
		From log_tarefa
		Where cd_tarefa = :pl_tarefa
			And id_status = 'E'
			And dateadd(ss,3720, dh_execucao) > getDate()
		Using SQLCa;
		
		If SQLCa.SQLCode = -1 Then
			This.Of_Erro('Falha ao recuperar log da tarefa '+String(pl_tarefa)+'.~r~n'+SQLCa.SQLErrText)
		End If
			
		//N$$HEX1$$e300$$ENDHEX$$o envia SMS se n$$HEX1$$e300$$ENDHEX$$o houve ao menos 4 notifica$$HEX2$$e700f500$$ENDHEX$$es
		If lvl_Result < lvl_SMS Then Return False
		
		lvl_Reenvio = TEMPO_SMS
	Case 'E'
		lvl_Reenvio = TEMPO_EMAIL
	Case Else		
		lvl_Reenvio = TEMPO_LOG
End Choose

select count(1)
Into :lvl_Result
From log_tarefa
Where cd_tarefa = :pl_tarefa
	And id_status = :ps_tipo
	And dateadd(ss,:lvl_Reenvio, dh_execucao) > getDate()
Using SQLCa;

If SQLCa.SQLCode = -1 Then
	This.Of_Erro('Falha ao recuperar log da tarefa '+String(pl_tarefa)+'.~r~n'+SQLCa.SQLErrText)
End If

Return ((SQLCa.SQLCode=100) or (lvl_Result=0))
end function

on uo_tarefa.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_tarefa.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;If IsValid(ivds_1) Then Destroy(ivds_1)
If IsValid(ivo_intranet) Then Destroy(ivo_intranet)
end event

