HA$PBExportHeader$w_ge399_perfil_temporario.srw
forward
global type w_ge399_perfil_temporario from dc_w_response_ok_cancela
end type
end forward

global type w_ge399_perfil_temporario from dc_w_response_ok_cancela
integer width = 2066
integer height = 844
string title = "GE399 - Conceder Perfil de Acesso Tempor$$HEX1$$e100$$ENDHEX$$rio"
end type
global w_ge399_perfil_temporario w_ge399_perfil_temporario

type variables
uo_usuario						io_colaborador
uo_filial						io_filial	
dc_uo_odbc						io_Odbc
uo_ge136_transacao_remota	itr_Filial
Boolean ivb_PDV_Java
Long il_filial
end variables

forward prototypes
public function boolean wf_verifica_perfil (string ps_matricula, ref long pl_perfil, ref string ps_desc_perfil)
public function boolean wf_verifica_vigentes (string ps_matricula, datetime pdh_inicio, datetime pdh_termino)
public function boolean wf_valida_grava_filial ()
public function boolean wf_valida_grava_matriz ()
public function boolean wf_conecta_filial (long pl_filial)
public function boolean wf_proximo_sequencial_matriz (string as_parametro, ref long al_proximo)
public function string wf_retorna_diferenca_tempo_extenso (datetime pdh_inicio, datetime pdh_termino)
public function string wf_retorna_tempo_extenso (longlong pl_segundos)
public subroutine wf_envia_email (string ps_matricula, string ps_nome, datetime pdh_inicio, datetime pdh_fim, string ps_motivo, string ps_ip, string ps_pdv, long pl_recorrencia, longlong pl_segundos, long pl_usuarios_temporarios)
public function boolean wf_valida_usuarios_liberados (datetime adt_inicio, datetime adt_fim)
end prototypes

public function boolean wf_verifica_perfil (string ps_matricula, ref long pl_perfil, ref string ps_desc_perfil);Boolean lb_perfil_valido = False

Long ll_perfil
Long ll_Count
Long ll_Filial

String ls_desc_perfil

If gvo_parametro.cd_filial <> gvo_parametro.cd_filial_matriz Then
	Select u.cd_perfil_usuario, p.de_perfil_usuario
	Into :ll_perfil, :ls_desc_perfil
	from usuario_sistema u 
	inner join perfil_usuario p on p.cd_sistema = u.cd_sistema
						and p.cd_perfil_usuario = u.cd_perfil_usuario
	where u.cd_sistema = 'RL' 
		and u.nr_matricula = :ps_matricula
	Using SqlCa;
Else
	Select us.cd_perfil_usuario, p.de_perfil_usuario
	Into :ll_perfil, :ls_desc_perfil
	from usuario u
	inner join usuario_sistema_filial us
		on us.nr_matricula = u.nr_matricula
		and us.cd_filial = u.cd_filial
	inner join perfil_usuario p on p.cd_sistema = us.cd_sistema
						and p.cd_perfil_usuario = us.cd_perfil_usuario
	where us.cd_sistema = 'RL' 
		and u.nr_matricula = :ps_matricula
	Using SqlCa;
End if

Choose Case SqlCa.SqlCode
	Case 0		
		
		// Esta regra n$$HEX1$$e300$$ENDHEX$$o se aplica para o sistema SA.
		If gvo_aplicacao.ivo_seguranca.cd_sistema <> "SA" Then 
			//Perfil Gerente e Farmac$$HEX1$$ea00$$ENDHEX$$utico j$$HEX1$$e100$$ENDHEX$$ possuem permiss$$HEX1$$f500$$ENDHEX$$es acima do usu$$HEX1$$e100$$ENDHEX$$rio tempor$$HEX1$$e100$$ENDHEX$$rio
			Choose Case ll_perfil 
				Case 1,2,8
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Perfil atual do usu$$HEX1$$e100$$ENDHEX$$rio n$$HEX1$$e300$$ENDHEX$$o permite esse tipo de libera$$HEX2$$e700e300$$ENDHEX$$o.~rPerfil atual: "+String(ll_perfil) + ' - ' + ls_desc_perfil, StopSign!)
					Return lb_perfil_valido
			End Choose
		End If
		
		If ll_perfil <> 3 and gvo_aplicacao.ivo_seguranca.cd_sistema <> "SA" Then		
			lb_perfil_valido = True
			pl_perfil = ll_perfil
			ps_desc_perfil = ls_desc_perfil
			//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Perfil atual do usu$$HEX1$$e100$$ENDHEX$$rio n$$HEX1$$e300$$ENDHEX$$o permite esse tipo de libera$$HEX2$$e700e300$$ENDHEX$$o. Perfil: "+String(ll_perfil) + ' - ' + ls_desc_perfil, StopSign!)
		Else
			lb_perfil_valido = True
			pl_perfil = ll_perfil
			ps_desc_perfil = ls_desc_perfil
		End If
		
	Case -1
		SqlCa.of_MsgdbError("Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do perfil.")
		
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Perfil do usu$$HEX1$$e100$$ENDHEX$$rio n$$HEX1$$e300$$ENDHEX$$o localizado.", StopSign!)
		
End Choose





/*
If lb_perfil_valido Then
	lb_perfil_valido = False
	
	SELECT COUNT(*)
	INTO :ll_Countf
	FROM usuario_sistema_temporario
	WHERE cd_sistema = 'RL'
	AND nr_matricula = :ps_matricula
	AND dh_termino_vigencia > now( )
	USING SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgdbError("Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do usuario_sistema_temporario.")
	Else
		If ll_Count = 0 Then
			lb_perfil_valido = True
		Else
			MessageBox( "OPERA$$HEX2$$c700c300$$ENDHEX$$O N$$HEX1$$c300$$ENDHEX$$O PERMITIDA", "Este colaborador j$$HEX1$$e100$$ENDHEX$$ possui um PERFIL 'USU$$HEX1$$c100$$ENDHEX$$RIO RESPONS$$HEX1$$c100$$ENDHEX$$VEL - TEMPOR$$HEX1$$c100$$ENDHEX$$RIO' programado e/ou vigente.", StopSign! )
		End If
	End If
End If
*/

Return lb_perfil_valido
end function

public function boolean wf_verifica_vigentes (string ps_matricula, datetime pdh_inicio, datetime pdh_termino);Long ll_Linhas
Boolean lb_sem_vigencia

dc_uo_ds_Base lvds_vigencias
lvds_vigencias = Create dc_uo_ds_Base

If Not lvds_vigencias.of_ChangeDataObject("ds_ge399_verifica_vigente") Then
	Destroy(lvds_vigencias)
	Return False
End If

ll_Linhas = lvds_vigencias.Retrieve( 'RL', ps_matricula )	

Choose Case ll_Linhas
	Case 0
		lb_sem_vigencia = True
		
	Case 1
		Messagebox("OPERA$$HEX2$$c700c300$$ENDHEX$$O N$$HEX1$$c300$$ENDHEX$$O PERMITIDA","A matr$$HEX1$$ed00$$ENDHEX$$cula " + ps_matricula + " possui libera$$HEX2$$e700e300$$ENDHEX$$o vigente dentro do per$$HEX1$$ed00$$ENDHEX$$odo informado. ~n" + &
									  "Per$$HEX1$$ed00$$ENDHEX$$odo vigente: " + String(lvds_vigencias.object.dh_inicio_vigencia[1], 'dd/mm/yyyy hh:mm') + ' at$$HEX1$$e900$$ENDHEX$$ ' + String(lvds_vigencias.object.dh_termino_vigencia[1],'dd/mm/yyyy hh:mm'), Exclamation!)
		lb_sem_vigencia = False
		
	Case Else
		Messagebox("OPERA$$HEX2$$c700c300$$ENDHEX$$O N$$HEX1$$c300$$ENDHEX$$O PERMITIDA","A matr$$HEX1$$ed00$$ENDHEX$$cula " + ps_matricula + " j$$HEX1$$e100$$ENDHEX$$ possui libera$$HEX2$$e700f500$$ENDHEX$$es vigentes para o per$$HEX1$$ed00$$ENDHEX$$odo informado.", Exclamation!)	
		lb_sem_vigencia = False
End Choose

Destroy(lvds_vigencias)
Return lb_sem_vigencia

end function

public function boolean wf_valida_grava_filial ();Integer li_Cont

Datetime ldh_data_ini, &
			ldh_data_fim, &
			ldh_inclusao, &
			ldh_limite
Long ll_dia, &
	   ll_dia_fim, &
	   ll_sequencial, &
	   ll_filial,&
	   ll_perfil,&
	   ll_perfil_temp,&
	   ll_cont, &
	   ll_cont_Temp,&
	   ll_Perfil_Alterar		
		
Longlong ll_Segundos
		
String ls_motivo, &
		ls_IP, &
		ls_PDV, &
		ls_matricula
String ls_Sistemas[]
String ls_Sistema

ls_Sistemas = {'CL', 'EL', 'RL','SL'}

dw_1.AcceptText()

Try
	
	ll_perfil 		  	= dw_1.Object.cd_perfil_usuario	[ 1 ]
	ll_perfil_temp	= dw_1.Object.cd_perfil_temp		[ 1 ]
	ls_motivo 		= dw_1.Object.de_motivo			[ 1 ]
	ls_matricula		= dw_1.Object.nr_matricula			[ 1 ]
	ldh_data_ini		= dw_1.Object.dh_periodo_ini		[ 1 ]
	ldh_data_fim	= dw_1.Object.dh_periodo_fim		[ 1 ]
	ll_Filial 			= gvo_Parametro.of_Filial()
	ls_PDV			= gvo_aplicacao.of_ComputerName()
	ls_IP				= gvo_aplicacao.ivo_seguranca.of_get_ip( )
	ldh_inclusao 	= gf_getserverdate()
	
	
	//Verifica$$HEX2$$e700e300$$ENDHEX$$o da regra de tempo da libera$$HEX2$$e700e300$$ENDHEX$$o:
	//Dia de semana maximo 24 hrs.
	//Finais de semana: Prazo maximo de 72 horas.
	ll_dia 			= DayNumber(Date(ldh_data_ini))
	ll_dia_fim 	= DayNumber(Date(ldh_data_fim))
	
	If ll_dia <= 5 And ll_dia > 0 Then //De domingo a quinta				
		SELECT CAST(:ldh_data_ini AS TIMESTAMPTZ) + INTERVAL '1 day'
		INTO :ldh_limite
		FROM parametro
		WHERE id_parametro = '1'
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgDbError( )
			dw_1.Event ue_Pos(1, "dh_periodo_ini")
			Return False				
		End If		
	
		If ldh_limite < ldh_data_fim Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Per$$HEX1$$ed00$$ENDHEX$$odo informado deve ser no m$$HEX1$$e100$$ENDHEX$$ximo de 24hrs.", StopSign!)
			dw_1.Event ue_Pos(1, "dh_periodo_ini")
			Return False						
		End If		
	Else
		SELECT min(dias)
		INTO :ldh_limite
		FROM generate_series(CAST(:ldh_data_ini AS TIMESTAMPTZ),
			CAST(:ldh_data_ini AS TIMESTAMPTZ) + INTERVAL'1 week' - INTERVAL'1 day',INTERVAL'1 day') AS dias
		WHERE EXTRACT(ISODOW FROM dias) = 1;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgDbError( )
			dw_1.Event ue_Pos(1, "dh_periodo_ini")
			Return False				
		End If
	
		If ldh_limite < ldh_data_fim Then
			MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Per$$HEX1$$ed00$$ENDHEX$$odo informado deve ser no m$$HEX1$$e100$$ENDHEX$$ximo at$$HEX1$$e900$$ENDHEX$$ " + String( ldh_limite, "dd/mm/yyyy hh:mm" ) + "." , StopSign! )
			dw_1.Event ue_Pos(1, "dh_periodo_fim")
			Return False			
		End If
	End If
	//Fim verifica$$HEX2$$e700e300$$ENDHEX$$o regra datas

	//Verifica se existe libera$$HEX2$$e700e300$$ENDHEX$$o vigente para a matricula
	If Not wf_verifica_vigentes(ls_matricula, ldh_data_ini, ldh_data_fim) Then
		Return False
	End If
	
	//Chamado 1049973 - Controle para n$$HEX1$$e300$$ENDHEX$$o deixar a filial cadastrar mais de dois usuarios responsaveis. //Parametro Loja: 
	If not 	wf_valida_usuarios_liberados(ldh_data_ini, ldh_data_fim ) Then
		Return False
	End If 
	
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a libera$$HEX2$$e700e300$$ENDHEX$$o do perfil tempor$$HEX1$$e100$$ENDHEX$$rio?~r~r~r"+&
						"  Colaborador: "+io_colaborador.nm_usuario+" ("+io_colaborador.nr_matricula+")~r"+ &				
						" Perfil Origem: "+dw_1.Describe("Evaluate('LookUpDisplay(cd_perfil_usuario)',1)")+"~r"+ &
						"Perfil Destino: "+dw_1.Describe("Evaluate('LookUpDisplay(cd_perfil_temp)',1)")+"~r"+ &	
						"         Per$$HEX1$$ed00$$ENDHEX$$odo: "+String(ldh_data_ini, "DD/MM/YYYY HH:MM")+" $$HEX1$$e000$$ENDHEX$$ "+String(ldh_data_fim, "DD/MM/YYYY HH:MM")+"~r"+&	
						"          Motivo: "+ls_motivo, Question!, YesNo!, 2) = 2 Then
		Return False
	End If
	
//	//Busca as libera$$HEX2$$e700f500$$ENDHEX$$es para o beneficiado nos ultimos 30 dias.
//	select count(*) as contador
//	into :ll_cont_Temp
//	from usuario_sistema_temporario
//	where cd_sistema = 'RL'
//	and ((dh_inicio_vigencia between :ldh_data_ini and :ldh_data_fim)
//		or (dh_termino_vigencia between :ldh_data_ini and :ldh_data_fim))
//	and cd_perfil_temporario = :ll_perfil_temp
//	and cd_filial_usuario = :ll_filial
//	and nr_matricula <> :ls_matricula
//	using SqlCa;	
//	
//	If SqlCa.SqlCode = -1 Then
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na contagem de libera$$HEX2$$e700f500$$ENDHEX$$es.", StopSign!)
//		Return False
//	End If		
//	
//	//Busca as libera$$HEX2$$e700f500$$ENDHEX$$es para o beneficiado nos ultimos 30 dias.
//	select count(*) as contador, 
//			TO_NUMBER(TO_CHAR(sum(dh_termino_vigencia - dh_inicio_vigencia  ), 'DD'), '00000') * 86400 +
//			TO_NUMBER(TO_CHAR(sum(dh_termino_vigencia - dh_inicio_vigencia  ), 'HH24'),'0000') * 3600 +
//			TO_NUMBER(TO_CHAR(sum(dh_termino_vigencia - dh_inicio_vigencia  ), 'MI'), '00000') * 60 +
//			TO_NUMBER(TO_CHAR(sum(dh_termino_vigencia - dh_inicio_vigencia  ), 'SS'), '00000') as segundos
//	into :ll_cont, :ll_Segundos
//	from usuario_sistema_temporario
//	where cd_sistema = 'RL'
//	and nr_matricula = :ls_matricula
//	and dh_inclusao >= current_date - INTERVAL '30 DAYS'
//	using SqlCa;
//	
//	If SqlCa.SqlCode = -1 Then
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na contagem de libera$$HEX2$$e700f500$$ENDHEX$$es.", StopSign!)
//		Return False
//	End If		
	
	For li_Cont = 1 To UpperBound( ls_Sistemas )
		ls_Sistema	= ls_Sistemas[ li_Cont ]
		
		uo_parametro_filial lo_Parametro
		lo_Parametro = Create uo_parametro_filial
		
		If lo_Parametro.of_Proximo_Sequencial( 'NR_SEQUENCIAL_LIBERACAO_PERFIL', Ref ll_sequencial ) Then
			If ll_sequencial <= 0 Then 
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao localizar pr$$HEX1$$f300$$ENDHEX$$ximo sequencial libera$$HEX2$$e700e300$$ENDHEX$$o PERFIL.",StopSign!)
				dw_1.Event ue_Pos(1, "dh_periodo_ini")
				Return False									
			End If	
		End If
		
		// Para o EL manter sempre no perfil 3 (padr$$HEX1$$e300$$ENDHEX$$o), pois este sistema n$$HEX1$$e300$$ENDHEX$$o possui todos os perfis dos outros sistemas
		If ls_Sistema = 'EL' Then
		  ll_Perfil_Alterar = 3
		Else
		  ll_Perfil_Alterar = ll_perfil_temp
		End If
		
		//Adicionar para o RL/CL e EL	
		Insert Into usuario_sistema_temporario  (cd_filial_inclusao,   
												nr_sequencial,   
												cd_sistema,   
												nr_matricula,   
												dh_inicio_vigencia,   
												dh_termino_vigencia,   
												cd_perfil_atual,
												cd_perfil_temporario,
												cd_filial_usuario,
												dh_inclusao,
												de_motivo,
												nr_matricula_inclusao,
												de_host,
												de_ip)  
		Values 	(:ll_filial,&
					 :ll_sequencial,&
					 :ls_Sistema,&
					 :ls_matricula,&
					 :ldh_data_ini,&
					 :ldh_data_fim,&
					 :ll_perfil,&
					 :ll_Perfil_Alterar,&
					 :ll_filial,&
					 :ldh_inclusao,&
					 :ls_motivo,&
					 :is_Matricula_Abertura_Tela,&
					 :ls_PDV,&
					 :ls_IP)
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_RollBack()		
			SqlCa.of_MsgdbError("Inclus$$HEX1$$e300$$ENDHEX$$o de Perfil Tempor$$HEX1$$e100$$ENDHEX$$rio - RL.")
			Return False
		End If	
	Next
		
	SqlCa.of_Commit()
//wf_envia_email(ls_matricula, dw_1.Object.nm_colaborador[1], ldh_data_ini, ldh_data_fim, ls_motivo, ls_IP, ls_PDV, ll_cont, ll_Segundos, ll_cont_Temp)
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Perfil tempor$$HEX1$$e100$$ENDHEX$$rio com validade at$$HEX1$$e900$$ENDHEX$$ " + String( ldh_data_fim, "dd/mm/yyyy hh:mm" ) + " criado com sucesso!", Information! )		
	Close( This )

Finally
	Destroy( lo_parametro )
	SetPointer(Arrow!)
End Try
end function

public function boolean wf_valida_grava_matriz ();Integer	li_Cont

Datetime	ldh_data_ini, &
			ldh_data_fim, &
			ldh_inclusao, &
			ldh_limite, &
			ldh_Intervalo

Long	ll_dia, &
		ll_dia_fim, &
		ll_sequencial, &
		ll_filial_Permissao,&
		ll_filial_Inclusao,&
		ll_perfil,&
		ll_perfil_temp,&
		ll_cont,&
		ll_cont_Temp, &
		ll_Chamado,&
		ll_Perfil_Alterar,&
		ll_Qtde
		
Longlong	ll_Segundos
		
String	ls_motivo, &
		ls_IP, &
		ls_PDV, &
		ls_matricula
		
String ls_Sistemas[]
String ls_Sistema

ls_Sistemas = {'CL', 'EL', 'RL','SL'}

dw_1.AcceptText()

Try
	
	ll_perfil 		  		= dw_1.Object.cd_perfil_usuario	[ 1 ]
	ll_perfil_temp		= dw_1.Object.cd_perfil_temp		[ 1 ]
	ls_motivo 			= dw_1.Object.de_motivo			[ 1 ]
	ls_matricula			= dw_1.Object.nr_matricula			[ 1 ]
	ldh_data_ini			= dw_1.Object.dh_periodo_ini		[ 1 ]
	ldh_data_fim		= dw_1.Object.dh_periodo_fim		[ 1 ]
	ll_filial_Permissao	= dw_1.Object.cd_filial				[ 1 ]
	ll_Chamado			= dw_1.Object.nr_chamado			[ 1 ]
	ll_filial_Inclusao	= gvo_Parametro.of_Filial()
	ls_PDV				= gvo_aplicacao.of_ComputerName()
	ls_IP					= gvo_aplicacao.ivo_seguranca.of_get_ip( )
	ldh_inclusao 		= gf_getserverdate()
	ldh_Intervalo 		= DateTime(RelativeDate(Date(ldh_inclusao), -30), Time(ldh_inclusao) )

	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a libera$$HEX2$$e700e300$$ENDHEX$$o do perfil tempor$$HEX1$$e100$$ENDHEX$$rio?~r~r~r"+&
						"  Colaborador: "+io_colaborador.nm_usuario+" ("+io_colaborador.nr_matricula+")~r"+ &				
						" Perfil Origem: "+dw_1.Describe("Evaluate('LookUpDisplay(cd_perfil_usuario)',1)")+"~r"+ &
						"Perfil Destino: "+dw_1.Describe("Evaluate('LookUpDisplay(cd_perfil_temp)',1)")+"~r"+ &	
						"         Per$$HEX1$$ed00$$ENDHEX$$odo: "+String(ldh_data_ini, "DD/MM/YYYY HH:MM")+" $$HEX1$$e000$$ENDHEX$$ "+String(ldh_data_fim, "DD/MM/YYYY HH:MM")+"~r"+&	
						"          Motivo: "+ls_motivo, Question!, YesNo!, 2) = 2 Then
		Return False
	End If
	 
	If Not wf_conecta_filial(ll_filial_Permissao) Then Return False
	
	If ivb_PDV_Java Then
		String ls_Perfil_Usuario
		DateTime ldh_Inicio_Vigencia, ldh_Termino_Vigencia
		
		//ldh_inclusao = data e hota atual
		Select top 1 pu.de_perfil_usuario, ust.dh_inicio_vigencia, ust.dh_termino_vigencia
		Into :ls_Perfil_Usuario, :ldh_Inicio_Vigencia, :ldh_Termino_Vigencia
		From usuario_sistema_temporario ust
		inner join perfil_usuario pu on pu.cd_sistema = ust.cd_sistema and pu.cd_perfil_usuario = ust.cd_perfil_temporario 
		Where	ust.cd_filial_usuario	= :ll_filial_Permissao
			And	ust.nr_matricula		= :ls_matricula
			And	ust.cd_sistema			= 'SL'
			And	ust.dh_inicio_vigencia < :ldh_inclusao And dh_termino_vigencia > :ldh_inclusao
		order by ust.dh_inclusao desc	
		Using SqlCa;
		
		Choose Case SqlCa.SqlCode
			Case  -1
				SqlCa.of_MsgdbError("Erro ao verificar se j$$HEX1$$e100$$ENDHEX$$ existe perfil cadastrado.")
				Return False
			Case 0
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "J$$HEX1$$e100$$ENDHEX$$ existe perfil tempor$$HEX1$$e100$$ENDHEX$$rio vigente para o colaborador " + io_colaborador.nm_usuario+" ("+io_colaborador.nr_matricula+") ~r~r" +&
								"Perfil: "+ ls_Perfil_Usuario + "~r"+&
								"Vig$$HEX1$$ea00$$ENDHEX$$ncia: "+ String(ldh_Inicio_Vigencia) + " at$$HEX1$$e900$$ENDHEX$$ " + String(ldh_Termino_Vigencia))
				Return False
			Case 100
				
		End Choose
	End If
	
//	//Busca as libera$$HEX2$$e700f500$$ENDHEX$$es para o beneficiado nos ultimos 30 dias.
//	select count(*) as contador
//	into :ll_cont_Temp
//	from usuario_sistema_temporario
//	where cd_sistema = 'RL'
//	and ((dh_inicio_vigencia between :ldh_data_ini and :ldh_data_fim)
//		or (dh_termino_vigencia between :ldh_data_ini and :ldh_data_fim))
//	and cd_perfil_temporario = :ll_perfil_temp
//	and cd_filial_usuario = :ll_filial_Permissao	
//	and nr_matricula <> :ls_matricula
//	using itr_Filial;	
//	
//	If SqlCa.SqlCode = -1 Then
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na contagem de libera$$HEX2$$e700f500$$ENDHEX$$es.", StopSign!)
//		Return False
//	End If	
//	
//	//Busca as libera$$HEX2$$e700f500$$ENDHEX$$es para o beneficiado nos ultimos 30 dias.
//	select count(1) as contador, 
//			TO_NUMBER(TO_CHAR(sum(dh_termino_vigencia - dh_inicio_vigencia  ), 'DD'), '00000') * 86400 +
//			TO_NUMBER(TO_CHAR(sum(dh_termino_vigencia - dh_inicio_vigencia  ), 'HH24'),'0000') * 3600 +
//			TO_NUMBER(TO_CHAR(sum(dh_termino_vigencia - dh_inicio_vigencia  ), 'MI'), '00000') * 60 +
//			TO_NUMBER(TO_CHAR(sum(dh_termino_vigencia - dh_inicio_vigencia  ), 'SS'), '00000') as segundos
//	into	:ll_cont, 
//	   		:ll_Segundos
//	from usuario_sistema_temporario
//	where cd_sistema = 'RL'
//	and nr_matricula = :ls_matricula
//	and dh_inclusao >= :ldh_intervalo
//	using itr_Filial;
//	
//	If itr_Filial.SqlCode = -1 Then
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na contagem de libera$$HEX2$$e700f500$$ENDHEX$$es.", StopSign!)
//		Return False
//	End If		
	
	For li_Cont = 1 To UpperBound( ls_Sistemas )
		ls_Sistema	= ls_Sistemas[ li_Cont ]
		
		//PDV Java s$$HEX1$$f300$$ENDHEX$$ tem o sistema SL
		If ls_Sistema <> "SL" and ivb_PDV_Java Then
			Continue;
		End If

		If This.wf_proximo_sequencial_matriz( 'NR_SEQUENCIAL_LIBERACAO_PERFIL', Ref ll_sequencial ) Then
			If ll_sequencial <= 0 Then 
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao localizar pr$$HEX1$$f300$$ENDHEX$$ximo sequencial libera$$HEX2$$e700e300$$ENDHEX$$o PERFIL.",StopSign!)
				dw_1.Event ue_Pos(1, "dh_periodo_ini")
				Return False									
			End If	
		End If
		
		// Para o EL manter sempre no perfil 3 (padr$$HEX1$$e300$$ENDHEX$$o), pois este sistema n$$HEX1$$e300$$ENDHEX$$o possui todos os perfis dos outros sistemas
		If ls_Sistema = 'EL' Then
		  ll_Perfil_Alterar = 3
		Else
		  ll_Perfil_Alterar = ll_perfil_temp
		End If
		
		If Not ivb_PDV_Java Then // 1345675
			//Esse insert grava direto no banco da filial
			//Adicionar para o RL/CL e EL	
			Insert Into usuario_sistema_temporario  (cd_filial_inclusao,   
													nr_sequencial,   
													cd_sistema,   
													nr_matricula,   
													dh_inicio_vigencia,   
													dh_termino_vigencia,   
													cd_perfil_atual,
													cd_perfil_temporario,
													cd_filial_usuario,
													dh_inclusao,
													de_motivo,
													nr_matricula_inclusao,
													de_host,
													de_ip)  
			Values 	(:ll_filial_Inclusao,&
						 :ll_sequencial,&
						 :ls_Sistema,&
						 :ls_matricula,&
						 :ldh_data_ini,&
						 :ldh_data_fim,&
						 :ll_perfil,&
						 :ll_Perfil_Alterar,&
						 :ll_filial_Permissao,&
						 :ldh_inclusao,&
						 :ls_motivo,&
						 :is_Matricula_Abertura_Tela,&
						 :ls_PDV,&
						 :ls_IP)
			Using itr_Filial;
			
			If itr_Filial.SqlCode = -1 Then
				itr_Filial.of_RollBack()		
				itr_Filial.of_MsgdbError("Inclus$$HEX1$$e300$$ENDHEX$$o de Perfil Tempor$$HEX1$$e100$$ENDHEX$$rio - RL. 1")
				Return False
			End If	
	End If
	
	//Campo do chamado n$$HEX1$$e300$$ENDHEX$$o existe na filial, por isso $$HEX1$$e900$$ENDHEX$$ feito um INSERT na loja e outro na matriz.
	//Adicionar para o RL/CL e EL	
	Insert Into usuario_sistema_temporario  (cd_filial_inclusao,   
												nr_sequencial,   
												cd_sistema,   
												nr_matricula,   
												dh_inicio_vigencia,   
												dh_termino_vigencia,   
												cd_perfil_atual,
												cd_perfil_temporario,
												cd_filial_usuario,
												dh_inclusao,
												de_motivo,
												nr_matricula_inclusao,
												de_host,
												de_ip,
												nr_chamado)  
		Values 	(:ll_filial_Inclusao,&
					 :ll_sequencial,&
					 :ls_Sistema,&
					 :ls_matricula,&
					 :ldh_data_ini,&
					 :ldh_data_fim,&
					 :ll_perfil,&
					 :ll_perfil_temp,&
					 :ll_filial_Permissao,&
					 :ldh_inclusao,&
					 :ls_motivo,&
					 :is_Matricula_Abertura_Tela,&
					 :ls_PDV,&
					 :ls_IP, &
					 :ll_Chamado)
		Using SQLCa;
	
		If SQLCa.SqlCode = -1 Then
			SQLCa.of_RollBack()		
			SQLCa.of_MsgdbError("Inclus$$HEX1$$e300$$ENDHEX$$o de Perfil Tempor$$HEX1$$e100$$ENDHEX$$rio - RL. 2")
			Return False
		End If
	Next
	
	SQLCa.Of_Commit( )
	If Not ivb_PDV_Java Then itr_Filial.Of_Commit()
	
	//wf_envia_email(ls_matricula, dw_1.Object.nm_colaborador[1], ldh_data_ini, ldh_data_fim, ls_motivo, ls_IP, ls_PDV, ll_cont, ll_Segundos, ll_cont_Temp) Desativado Chamado 1272324
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Perfil tempor$$HEX1$$e100$$ENDHEX$$rio com validade at$$HEX1$$e900$$ENDHEX$$ " + String( ldh_data_fim, "dd/mm/yyyy hh:mm" ) + " criado com sucesso!", Information! )		
	Close( This )

Finally
	SetPointer(Arrow!)
End Try
end function

public function boolean wf_conecta_filial (long pl_filial);Boolean lvb_Sucesso = False

Datetime lvdh_Server
Long lvl_Feriado

String lvs_Odbc,&
		 ls_Ref

If Not gf_retorna_loja_pdv_novo(pl_filial, ref ivb_PDV_Java, ref ls_Ref ) Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao conferir se a filial $$HEX1$$e900$$ENDHEX$$ PDV Java " + ls_Ref, StopSign!)
 End If

If Not ivb_PDV_Java And pl_filial <> 534 Then
	If IsNull(pl_filial) Then Return False
	
	Try
		dw_1.AcceptText( )
		Open(w_Aguarde_1)
		w_Aguarde_1.Title = "Conectando no banco de dados da filial " + String( pl_filial )
		
		io_Odbc.of_Atualiza_Odbcs( String( pl_filial ) )
		
		If Not IsValid( itr_Filial ) Then itr_Filial = Create uo_ge136_Transacao_Remota
		
		lvs_Odbc = itr_Filial.of_Localiza_DataSource_Filial( pl_Filial )
		
		#IF DEFINED DEBUG THEN
			If SQLCa.Database = "homologa" then
				lvs_Odbc = "0000_Loja"
			else
				If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Voc$$HEX1$$ea00$$ENDHEX$$ deseja conectar no banco loja?", Question!, YesNo!,1) = 1 Then
					lvs_Odbc = "0000_Loja"
				End If
			end If
		#END IF
		
		If itr_Filial.of_IsConnected( ) Then	itr_Filial.of_Disconnect( )
	
		itr_Filial.of_Set_Username( "teste_conexao" )
		
		itr_Filial.of_Set_DataSource( 'POSTGRESQL', lvs_Odbc )
		
		//Nome da aplica$$HEX2$$e700e300$$ENDHEX$$o tl_importacao para n$$HEX1$$e300$$ENDHEX$$o gerar log de exporta$$HEX2$$e700e300$$ENDHEX$$o para matriz
		lvb_Sucesso = itr_Filial.of_Connect( lvs_Odbc, "tl_importacao" )
		
		If lvb_Sucesso Then itr_Filial.of_End_Transaction( )
	
	Catch( Exception ex )
		MessageBox( "Exception", ex.getMessage( ), StopSign! )
		lvb_Sucesso = False		
	Finally
		If IsValid(w_Aguarde_1) Then Close(w_Aguarde_1)
	End Try
ElseIf gvo_aplicacao.ivo_seguranca.cd_sistema = "SA" Then
	il_Filial = pl_filial
	itr_Filial = SQLCa
	lvb_Sucesso = True
End If

Return lvb_Sucesso
end function

public function boolean wf_proximo_sequencial_matriz (string as_parametro, ref long al_proximo);String lvs_parametro

Try
	select coalesce(vl_parametro,'0')
	into :lvs_parametro
	From parametro_geral
	Where cd_parametro	= :as_Parametro
	Using SQLCa;
	
	If SQLCa.SqlCode = -1 Then
		SQLCa.of_RollBack( )
		SQLCa.of_MsgDbError( "Localiza$$HEX2$$e700e300$$ENDHEX$$o do sequencial do par$$HEX1$$e200$$ENDHEX$$metro '" + as_Parametro + "'.~r uo_parametro_filial.of_proximo_sequencial( string, long )" )
		Return False
	End If
	
	If IsNull(lvs_parametro) Then  lvs_parametro = "0"
	
	Update parametro_geral
		 Set vl_parametro		= CAST( ( CAST( COALESCE( :lvs_parametro, '0' ) AS INTEGER ) + 1 ) AS VARCHAR )
	Where cd_parametro		= :as_Parametro
	 	And vl_parametro 		= :lvs_parametro
	 Using SQLCa;
	
	If SQLCa.SqlCode = -1 Then
		SQLCa.of_RollBack( )
		SQLCa.of_MsgDbError( "Atualiza$$HEX2$$e700e300$$ENDHEX$$o do sequencial do par$$HEX1$$e200$$ENDHEX$$metro '" + as_Parametro + "'.~r wf_proximo_sequencial_matriz( string, long )" )
		Return False
	Else
		If SQLCa.SqlnRows = 0 Then Return This.wf_proximo_sequencial_matriz( as_Parametro, ref al_Proximo )
	End If			
	
	al_proximo = Long(lvs_parametro) + 1
	SQLCa.Of_Commit()
	
	Return True
	
Finally
	
End Try
end function

public function string wf_retorna_diferenca_tempo_extenso (datetime pdh_inicio, datetime pdh_termino);Time lvtm_1
Time lvtm_2

Long lvl_Dias
Long lvl_Horas
Long lvl_Minutos
Long lvl_Segundos

String lvs_Retorno

lvtm_1	= Time(pdh_inicio)
lvtm_2	= Time(pdh_termino)

lvl_Dias	= DaysAfter(Date(pdh_inicio), Date(pdh_termino))

If lvtm_1 > lvtm_2 Then
	lvl_Segundos	= 86400 - SecondsAfter(lvtm_2, lvtm_1)
	lvl_Dias -= 1
Else
	lvl_Segundos	= SecondsAfter(lvtm_1, lvtm_2)
End If

lvl_Horas		= Truncate(lvl_Segundos / 60 / 60, 0)
lvl_Minutos	= Truncate(lvl_Segundos / 60, 0) - lvl_Horas * 60

lvl_Segundos -= lvl_Horas * 60 * 60
lvl_Segundos -= lvl_Minutos * 60

lvs_Retorno = IIF(lvl_Dias > 0, String(lvl_Dias)+IIF(lvl_Dias > 1, " dias", " dia") , "")
lvs_Retorno += IIF(lvl_Horas > 0, " "+String(lvl_Horas)+IIF(lvl_Horas > 1, " horas", " hora") , "")
lvs_Retorno += IIF(lvl_Minutos > 0,  " "+String(lvl_Minutos)+IIF(lvl_Minutos > 1, " minutos", " minuto") , "")
lvs_Retorno += IIF(lvl_Segundos > 0,  " "+String(lvl_Segundos)+IIF(lvl_Segundos > 1, " segundos", " segundo") , "")

Return Trim(lvs_Retorno)

end function

public function string wf_retorna_tempo_extenso (longlong pl_segundos);Long lvl_Dias
Long lvl_Horas
Long lvl_Minutos
Long lvl_Segundos

String lvs_Retorno

lvl_Segundos = pl_segundos

lvl_Dias			= Truncate(lvl_Segundos / 86400, 0)
lvl_Segundos	-= lvl_Dias * 86400

lvl_Horas			= Truncate(lvl_Segundos / 3600, 0)
lvl_Segundos	-= lvl_Horas * 3600

lvl_Minutos		= Truncate(lvl_Segundos / 60, 0)
lvl_Segundos	-= lvl_Minutos * 60

lvs_Retorno = IIF(lvl_Dias > 0, String(lvl_Dias)+IIF(lvl_Dias > 1, " dias", " dia") , "")
lvs_Retorno += IIF(lvl_Horas > 0, " "+String(lvl_Horas)+IIF(lvl_Horas > 1, " horas", " hora") , "")
lvs_Retorno += IIF(lvl_Minutos > 0,  " "+String(lvl_Minutos)+IIF(lvl_Minutos > 1, " minutos", " minuto") , "")
lvs_Retorno += IIF(lvl_Segundos > 0,  " "+String(lvl_Segundos)+IIF(lvl_Segundos > 1, " segundos", " segundo") , "")

Return Trim(lvs_Retorno)
end function

public subroutine wf_envia_email (string ps_matricula, string ps_nome, datetime pdh_inicio, datetime pdh_fim, string ps_motivo, string ps_ip, string ps_pdv, long pl_recorrencia, longlong pl_segundos, long pl_usuarios_temporarios);DateTime  lvdt_Envio

String ls_Cabecalho
String ls_msg
String ls_titulo
String ls_retorno
String ls_To[]
String ls_Cc[]
String ls_Co[]
String ls_select
String ls_mail_regional
String ls_Perfil_Origem
String ls_Perfil_Destino

Long ll_row
Long ll_retorno
Long ll_Ind_To
Long ll_Ind_CC
Long ll_Ind_CO

lvdt_Envio = gf_getserverdate()

io_Colaborador.of_Inicializa( )
If gvo_aplicacao.ivo_seguranca.cd_sistema <> "SA" Then
	io_Colaborador.of_Localiza_Matricula( is_Matricula_Abertura_Tela ) 
Else
	io_Colaborador.of_Localiza_Matricula( gvo_aplicacao.ivo_seguranca.nr_matricula ) 
End If

ls_Cabecalho = "" //"<font face='verdana' size='1' color='red'>'Este $$HEX1$$e900$$ENDHEX$$ um email autom$$HEX1$$e100$$ENDHEX$$tico. Favor n$$HEX1$$e300$$ENDHEX$$o responder esta mensagem.'</font><br /><br />"		 

dw_1.Accepttext( )
ls_Perfil_Origem	 = dw_1.Describe("Evaluate('LookUpDisplay(cd_perfil_usuario)',1)")
ls_Perfil_Destino	=	dw_1.Describe("Evaluate('LookUpDisplay(cd_perfil_temp)',1)")

ls_msg =  	"Caro(a) Usu$$HEX1$$e100$$ENDHEX$$rio, <br /><br />" +& 
				"O(a) "+ls_Perfil_Origem+" "+ps_nome+" foi liberado(a) para o perfil "+ls_Perfil_Destino+", abaixo as informa$$HEX2$$e700f500$$ENDHEX$$es detalhadas.<br />"
				
If pl_usuarios_temporarios > 0 Then
	ls_msg += "<br />J$$HEX1$$e100$$ENDHEX$$ existe(m) outro(s) <b><font face='verdana' size='2' color='red'>"+String(pl_usuarios_temporarios)+"</font></b> usu$$HEX1$$e100$$ENDHEX$$rios(s) com acesso tempor$$HEX1$$e100$$ENDHEX$$rio a este perfil no mesmo per$$HEX1$$ed00$$ENDHEX$$odo.<br />~n"
End If
				
ls_msg +=  	"<br /><br /><b>BENEFICIADO (SER$$HEX1$$c100$$ENDHEX$$ RESPONS$$HEX1$$c100$$ENDHEX$$VEL PELA LOJA)</b><br /><hr>"+&
			 	"<table border=0 cellpadding=0 cellspacing=0>"+&
					"<tr><td align='right'><b>Filial:</b></td><td>&nbsp;</td><td>" + String(io_filial.cd_filial) + ' - ' + io_filial.nm_fantasia + "</td></tr>~n" + &
					"<tr><td align='right'><b>Usu$$HEX1$$e100$$ENDHEX$$rio:</b></td><td>&nbsp;</td><td>" + ps_matricula + " - " + ps_nome + "</td></tr>~n" + &
					"<tr><td align='right'><b>Per$$HEX1$$ed00$$ENDHEX$$odo:</b></td><td>&nbsp;</td><td>" + wf_retorna_diferenca_tempo_extenso(pdh_inicio, pdh_fim) + "</td></tr>~n" + &
					"<tr><td align='right'><b>De:</b></td><td>&nbsp;</td><td>" + String(pdh_inicio, 'dd/mm/yyyy hh:mm') + "<b> at$$HEX1$$e900$$ENDHEX$$ </b>" + String(pdh_fim, 'dd/mm/yyyy hh:mm')  + "</td></tr>~n" + &
					"<tr><td align='right'><b>Motivo Informado:</b></td><td>&nbsp;</td><td>"+ ps_motivo + "</td></tr>~n"

If pl_recorrencia > 0 Then
	ls_msg += "<tr><td align='right'><b>Total Permiss$$HEX1$$f500$$ENDHEX$$es (30 dias):</b></td><td>&nbsp;</td><td>"+ String(pl_recorrencia) + ".</td></tr>~n"
	ls_msg += "<tr><td align='right'><b>Total Tempo (30 dias):</b></td><td>&nbsp;</td><td>"+ wf_retorna_tempo_extenso(pl_segundos) + ".</td></tr>~n"
End If



ls_msg += "</table>"
			
ls_msg +=  "<br /><br /><br />"+ &
				"<b>INFORMA$$HEX2$$c700d500$$ENDHEX$$ES DESTA LIBERA$$HEX2$$c700c300$$ENDHEX$$O</b><br /><hr>"+&
				"<table border=0 cellpadding=0 cellspacing=0>"+&
					"<tr><td align='right'><b>Respons$$HEX1$$e100$$ENDHEX$$vel:</b></td><td>&nbsp;</td><td>" + is_Matricula_Abertura_Tela + " - " + io_Colaborador.Nm_Usuario + "</td></tr>~n" + &
					"<tr><td align='right'><b>PDV:</b></td><td>&nbsp;</td><td>" + ps_PDV + "</td></tr>~n" + &
					"<tr><td align='right'><b>IP:</b></td><td>&nbsp;</td><td>" + ps_ip + "</td></tr>~n" + &
					"<tr><td align='right'><b>Data Hora:</b></td><td>&nbsp;</td><td>" +  String(lvdt_Envio, 'dd/mm/yyyy hh:mm:ss') + "</td></tr>~n" + &
				"</table>"
			
//Busca e-mail do regional da filial
ls_Select =	"select u.de_endereco_email from filial f " + &
					"join regiao r on r.cd_regiao = f.cd_regiao " + &
					"join usuario u on u.nr_matricula = r.nr_matricula_regional " + &
					"where f.cd_filial = " + String(io_filial.cd_filial)

uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao()

lvo_Conexao.of_Retrieve( ls_Select, Ref ls_Retorno )

If lvo_Conexao.of_Erro_Execucao( ) Or lvo_Conexao.of_Erro_Conexao( ) Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na conex$$HEX1$$e300$$ENDHEX$$o com o servidor distribu$$HEX1$$ed00$$ENDHEX$$do.~rGE399 - wf_envia_email" )
	Return
End If

If Not IsNull(ls_Retorno) And Trim(ls_Retorno) > '' Then
	ls_mail_regional = Trim(ls_retorno)
	ls_mail_regional = gf_replace(ls_mail_regional,Char(13),'',0) 
	ls_mail_regional = gf_replace(ls_mail_regional,Char(10),'',0) 
	ll_Ind_Cc ++
	ls_Cc[ll_Ind_Cc] = ls_mail_regional
End If
//Fim da busca

dc_uo_ds_Base lvds_1
lvds_1 = Create dc_uo_ds_Base

If Not lvds_1.of_ChangeDataObject("ds_ge399_email_envio") Then
	Destroy(lvds_1)
Else
	lvds_1.of_AppendWhere("m.cd_mensagem = 106")	

//	uo_Transacao_Remota lvo_Conexao
//	lvo_Conexao = Create uo_Transacao_Remota
	
	lvo_Conexao.of_BancoProducao()
	
	lvo_Conexao.of_Retrieve(lvds_1.GetSQLSelect(), Ref ls_Retorno)
	
	If lvo_Conexao.of_Erro_Execucao() Or lvo_Conexao.of_Erro_Conexao() Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na conex$$HEX1$$e300$$ENDHEX$$o com o servidor distribu$$HEX1$$ed00$$ENDHEX$$do.")
		ll_Retorno = 0
	Else
		If IsNull(ls_Retorno) Or Trim(ls_Retorno) = '' Then
			ll_Retorno = 0
		Else
			ll_Retorno = lvds_1.ImportString(ls_Retorno)
			
			If ll_Retorno >= 0 Then
				ll_Row = 0
				For ll_Row = 1 To lvds_1.RowCount()
					If IsNull(lvds_1.Object.de_assunto[ll_Row]) Or Trim(lvds_1.Object.de_assunto[ll_Row]) = '' Then
						ls_Titulo = 'Permiss$$HEX1$$e300$$ENDHEX$$o de acesso tempor$$HEX1$$e100$$ENDHEX$$rio a usu$$HEX1$$e100$$ENDHEX$$rio. Filial: ' + String(gvo_parametro.cd_filial) + ' - ' + gvo_parametro.nm_fantasia_filial
					Else
						ls_Titulo = lvds_1.Object.de_assunto[ll_Row] + ": " + String(gvo_parametro.cd_filial)
					End If

					Choose Case lvds_1.Object.id_tipo_envio[ll_Row]
						Case 'TO'
							ll_Ind_To ++
							ls_To[ll_Ind_To] = lvds_1.Object.de_email[ll_Row]							
						Case 'CC'
							ll_Ind_Cc ++
							ls_Cc[ll_Ind_Cc] = lvds_1.Object.de_email[ll_Row]							
						Case 'CO'
							ll_Ind_Co ++
							ls_Co[ll_Ind_Co] = lvds_1.Object.de_email[ll_Row]														
					End Choose						
				Next
				
				uo_smtp lvo_smtp
				lvo_smtp = Create uo_smtp
									
				lvo_Smtp.ib_grava_log_db = False
				
				ls_msg = gf_ge202_formata_email_html(ls_msg, 106, True, '(47) 3461-9836')

				lvo_smtp.of_envia_email("ALERTA DE SISTEMA", &
											  "sistemas@clamed.com.br", + &
											  ls_Titulo, + &
											  ls_cabecalho + ls_Msg, + &
											  ls_To,ls_Cc,ls_Co)			
				
			Else				
				MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na conex$$HEX1$$e300$$ENDHEX$$o com o servidor distribu$$HEX1$$ed00$$ENDHEX$$do.~rGE399 - wf_envia_email" )				
			End If
		End If
	End If		
End If

Destroy(lvo_Conexao)
Destroy(lvds_1)	
Destroy(lvo_smtp)	
end subroutine

public function boolean wf_valida_usuarios_liberados (datetime adt_inicio, datetime adt_fim);Integer li_Qtd_Liberados
Integer li_Linha
Integer li_Linhas
Integer li_Pos 

String ls_Mensagem
String ls_Usuario
String ls_Matricula
String ls_Qtd_Liberados 

TRY 
	dw_1.AcceptText()
	
	dc_uo_ds_Base lvds_liberados 
	lvds_liberados = CREATE dc_uo_ds_Base 
	
	uo_Parametro_Filial lo_Parametro 
	lo_Parametro = CREATE uo_Parametro_Filial 

	IF NOT lvds_liberados.of_ChangeDataObject("ds_ge399_verifica_qtd_liberados") THEN
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao alterar a DS na Fun$$HEX2$$e700e300$$ENDHEX$$o wf_valida_usuarios_liberados.~rAbra um chamado no ServiceDesk.",Exclamation!)
		RETURN FALSE 
	END IF 
		
	li_Linhas =  lvds_liberados.retrieve( gvo_parametro.cd_filial, adt_inicio ,adt_fim ) 
	
	If li_Linhas < 0 THEN 
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no retrieve da Fun$$HEX2$$e700e300$$ENDHEX$$o wf_valida_usuarios_liberados.~rAbra um chamado no ServiceDesk.",Exclamation!)
		RETURN FALSE 
	END IF 

	If Not lo_Parametro.of_Localiza_Parametro( "QT_USUARIO_TEMPORARIO_SIMULTANEO", REF li_Qtd_Liberados) Then
		Return False
	End If
	
	IF li_Qtd_Liberados = 0 Or isNull(li_Qtd_Liberados) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Parametro n$$HEX1$$e300$$ENDHEX$$o localizado na fun$$HEX2$$e700e300$$ENDHEX$$o wf_valida_usuarios_liberados.~rAbra um chamado no ServiceDesk",Exclamation!)
		RETURN FALSE
	END IF 

	IF li_Linhas >= li_Qtd_Liberados THEN 
		
		FOR li_Linha = 1 TO li_Linhas
			ls_Usuario 	= lvds_liberados.object.nm_usuario 	[li_Linha] 
			ls_Matricula = lvds_liberados.object.nr_matricula 	[li_Linha] 

			li_Pos = PosA(ls_Usuario, " ") 
			ls_Usuario = Trim(MidA( ls_Usuario, 1, li_Pos) ) 

			ls_Mensagem = ls_Mensagem + ls_Usuario + " ("+ ls_Matricula + ") ~r"+& 
			"De: "+ String(lvds_liberados.object.dh_inicio_vigencia [li_Linha], "DD/MM HH:MM") + " $$HEX1$$e000$$ENDHEX$$ "+&
			String(lvds_liberados.object.dh_termino_vigencia [li_Linha], "DD/MM HH:MM") + "~r~r"
		NEXT 

		Messagebox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Total de usu$$HEX1$$e100$$ENDHEX$$rios permitidos simultaneamente: "+ ls_Qtd_Liberados + "~r~rUsu$$HEX1$$e100$$ENDHEX$$rio(s) liberado(s) atualmente: ~r~r"+ ls_Mensagem, Exclamation!)
		RETURN FALSE
	END IF 
	
	RETURN TRUE 
	
FINALLY 
	IF isValid(lvds_liberados) THEN DESTROY(lvds_liberados) 
	IF isValid(lo_Parametro) THEN DESTROY(lo_Parametro) 
END TRY
end function

on w_ge399_perfil_temporario.create
call super::create
end on

on w_ge399_perfil_temporario.destroy
call super::destroy
end on

event close;call super::close;If IsValid(io_Colaborador)	Then Destroy io_Colaborador
If IsValid(io_filial)				Then Destroy(io_filial)
If IsValid(io_Odbc)				Then Destroy(io_Odbc)

If Not ivb_PDV_Java And il_filial <> 534 Then
	If IsValid(itr_Filial)			Then Destroy(itr_Filial)
End If
end event

event ue_postopen;call super::ue_postopen;DateTime ldh_data_fim
Datawindowchild ldwc_Child

pb_Help.Visible = Not(gvo_aplicacao.ivo_seguranca.cd_sistema = "SA")
io_Colaborador	= Create uo_Usuario
io_filial			= Create uo_filial
io_Odbc			= Create dc_uo_odbc
itr_Filial			= Create uo_ge136_transacao_remota

dw_1.AcceptText()

dw_1.Object.dh_periodo_ini		[1] = DateTime(String(gf_getserverdate(), 'dd/mm/yyyy hh:mm'))
dw_1.Object.dh_periodo_ini		[1] = DateTime(String(gf_getserverdate(), 'dd/mm/yyyy hh:mm'))

If dw_1.GetChild("cd_perfil_usuario", ldwc_Child) > 0 Then
	ldwc_Child.SetTrans( SQLCa )
	ldwc_Child.SetTransObject( SQLCa )
	ldwc_Child.Retrieve("RL")
End If

If dw_1.GetChild("cd_perfil_temp", ldwc_Child) > 0 Then
	ldwc_Child.SetTrans( SQLCa )
	ldwc_Child.SetTransObject( SQLCa )
	ldwc_Child.Retrieve("RL")
End If

If gvo_aplicacao.ivo_seguranca.cd_sistema = "SA" Then
	io_colaborador.ivl_filial = 534
	dw_1.Object.nm_filial.TabSequence = 5
	dw_1.Object.nm_filial.Background.Color = 16777215
	dw_1.Object.cd_perfil_temp.TabSequence = 15
	dw_1.Object.cd_perfil_temp.Background.Color = 16777215
Else
	io_colaborador.ivl_filial = gvo_parametro.cd_filial
	io_filial.Of_localiza_codigo( gvo_parametro.cd_filial )
	dw_1.Object.cd_filial				[1] = io_filial.cd_filial
	dw_1.Object.nm_filial				[1] = io_filial.nm_fantasia
	dw_1.Object.cd_perfil_temp		[1] = 14
	dw_1.Object.cd_perfil_temp.TabSequence = 0
	dw_1.Object.cd_perfil_temp.Background.Color = 31383262
	dw_1.Object.nm_filial.TabSequence = 0
	dw_1.Object.nm_filial.Background.Color = 31383262
End If

//ldh_data_fim = gf_getserverdate()
//
//SELECT CAST(tempo AS TIMESTAMPTZ) + INTERVAL '1 DAYS' AS datacalculo
//		 Into :ldh_data_fim
//from ( SELECT CAST( :ldh_data_fim AS TIMESTAMPTZ )	AS tempo
//			FROM parametro WHERE 1 = 1 ) p
//Using SqlCa;
//
//If SqlCa.SqlCode = -1 Then
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no calculo da data final.", StopSign!)
//Else
//	dw_1.Object.dh_periodo_fim		[1] = ldh_data_fim
//End If

dw_1.SetFocus()


end event

event ue_preopen;call super::ue_preopen;If gvo_aplicacao.ivo_seguranca.cd_sistema = "SA" Then
	is_Matricula_Abertura_Tela = gvo_Aplicacao.ivo_Seguranca.Nr_matricula
Else
	If Not This.ib_Solicitou_Liberacao_Procedimento_Base  Then
		If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("W_GE399_PERFIL_TEMPORARIO", Ref is_Matricula_Abertura_Tela) Then 
			This.il_Retorno = -1
		End If
	End If
End If

If gvo_parametro.cd_filial = gvo_parametro.cd_filial_matriz Then
	dw_1.Object.nr_chamado_t.Visible = True
	dw_1.Object.nr_chamado.Visible = True
	dw_1.Height = dw_1.Height + 84
	gb_1.Height	= gb_1.Height + 84
	cb_ok.Y = cb_ok.Y + 80
	cb_cancelar.Y = cb_cancelar.Y + 80
	This.Height = This.Height + 100
	dw_1.Object.DataWindow.Detail.Height=572
Else
	dw_1.Object.DataWindow.Detail.Height=492
End If
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge399_perfil_temporario
integer x = 23
integer y = 620
integer taborder = 0
end type

event pb_help::clicked;call super::clicked;wf_Help( "Conceder Perfil de Acesso Tempor$$HEX1$$e100$$ENDHEX$$rio (GE399)" )
end event

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge399_perfil_temporario
integer width = 2011
integer height = 600
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge399_perfil_temporario
integer width = 1947
integer height = 524
string dataobject = "dw_ge399_selecao"
end type

event dw_1::ue_key;call super::ue_key;Long ll_perfil
String ls_desc_perfil
String ls_null

SetNull(ls_null)

If Key = KeyEnter! Then
	Choose Case This.GetColumnName()		
		Case "nm_filial"
			io_filial.of_inicializa( )
			io_filial.of_Localiza_filial( This.getText() ) 	
			
			This.Object.cd_filial	[1] = io_filial.cd_filial
			This.Object.nm_filial	[1] = io_filial.nm_fantasia	
			
			If io_filial.Localizada Then
				io_colaborador.ivl_filial = io_filial.cd_filial
				This.Event ue_Pos(1, "nm_colaborador")
				
				If io_filial.id_sistema_novo = "S" Then
					Datawindowchild ldwc_Child
					
					If dw_1.GetChild("cd_perfil_usuario", ldwc_Child) > 0 Then
						ldwc_Child.SetTrans( SQLCa )
						ldwc_Child.SetTransObject( SQLCa )
						ldwc_Child.Retrieve("SL")
					End If
					
					If dw_1.GetChild("cd_perfil_temp", ldwc_Child) > 0 Then
						ldwc_Child.SetTrans( SQLCa )
						ldwc_Child.SetTransObject( SQLCa )
						ldwc_Child.Retrieve("SL")
					End If
				End If
			Else
				io_colaborador.ivl_filial = gvo_parametro.cd_filial
			End If
			
		Case "nm_colaborador"
			io_Colaborador.of_Localiza_Usuario( This.getText() ) 
			
			If io_Colaborador.Localizado Then
				If io_Colaborador.Id_Situacao = 'I' Then
					MessageBox( "OPERA$$HEX2$$c700c300$$ENDHEX$$O N$$HEX1$$c300$$ENDHEX$$O PERMITIDA", "O cadastro do(a) colaborador(a) '" + io_Colaborador.Nm_Usuario + "' n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ ativo." )
					io_Colaborador.of_Inicializa( )
					This.Object.nr_matricula [1] = io_Colaborador.Nr_Matricula
					Return -1
				End If
				
				If io_Colaborador.Cd_Filial <> io_colaborador.ivl_filial Then
					If gvo_parametro.cd_filial <> gvo_parametro.cd_filial_matriz Then
						MessageBox( "OPERA$$HEX2$$c700c300$$ENDHEX$$O N$$HEX1$$c300$$ENDHEX$$O PERMITIDA", "Colaborador(a) '" + io_Colaborador.Nm_Usuario + "' n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ cadastrado(a) nesta filial." )
						io_Colaborador.of_Inicializa( )
						This.Object.nr_matricula [1] = io_Colaborador.Nr_Matricula
						Return -1
					ElseIf MessageBox("OPERA$$HEX2$$c700c300$$ENDHEX$$O N$$HEX1$$c300$$ENDHEX$$O PERMITIDA", "Colaborador(a) '" + io_Colaborador.Nm_Usuario + "' n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ na filial informada.~r~n~r~n"+&
											"Deseja continuar mesmo assim?",Question!, YesNo!, 2) = 2 Then
						io_Colaborador.of_Inicializa( )
						This.Object.nr_matricula [1] = io_Colaborador.Nr_Matricula
						Return -1
					End If
				End If
				
				If Not wf_verifica_perfil(io_Colaborador.Nr_Matricula, Ref ll_perfil, Ref ls_desc_perfil) Then
					io_Colaborador.of_Inicializa( )
					This.Object.nr_matricula 		[1] = io_Colaborador.Nr_Matricula
					This.Object.nm_colaborador 	[1] = io_Colaborador.nm_usuario					
					Return -1
				Else
					This.Object.cd_perfil_usuario				[1] = ll_perfil
				End If				
				
				This.Object.nm_colaborador	[1] = io_Colaborador.Nm_Usuario
				This.Object.nr_matricula			[1] = io_Colaborador.Nr_Matricula
								
				This.Event ue_Pos(1, "cd_perfil_temp")
			Else
				io_Colaborador.of_Inicializa( )
				This.Object.nm_colaborador	[1] = ls_null
				This.Object.nr_matricula			[1] = ls_null
			End If						
	End Choose
End If
end event

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case 'nm_colaborador'
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Trim(Data) <> io_colaborador.Nm_Usuario Then
				Return 1
			End If
		Else
			This.Object.nm_colaborador	[1] = io_Colaborador.Nm_Usuario
			This.Object.nr_matricula			[1] = io_Colaborador.Nr_Matricula
		End If	
		
	Case 'nm_filial'
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Trim(Data) <> io_filial.nm_fantasia Then
				Return 1
			End If
		Else
			This.Object.cd_filial	[1] = io_filial.cd_filial
			This.Object.nm_filial	[1] = io_filial.nm_fantasia
		End If	
		
End Choose
end event

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)
end event

event dw_1::losefocus;call super::losefocus;If IsValid(io_filial) Then
	This.Object.nm_filial [1] = io_filial.nm_fantasia
End If
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge399_perfil_temporario
integer x = 1371
integer y = 632
boolean default = false
end type

event cb_ok::clicked;call super::clicked;Datetime ldh_data_ini, &
			ldh_data_fim, &
			ldh_inclusao

Long ll_perfil
Long ll_perfil_temp
		
String ls_motivo, &
		ls_matricula

dw_1.AcceptText()
	
ll_perfil 		  	= dw_1.Object.cd_perfil_usuario	[ 1 ]
ll_perfil_temp	= dw_1.Object.cd_perfil_temp		[ 1 ]
ls_motivo 		= dw_1.Object.de_motivo			[ 1 ]
ls_matricula		= dw_1.Object.nr_matricula			[ 1 ]
ldh_data_ini 	= dw_1.Object.dh_periodo_ini		[ 1 ]
ldh_data_fim 	= dw_1.Object.dh_periodo_fim		[ 1 ]

ldh_inclusao = gf_getserverdate()

If IsNull( ls_matricula ) Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe o colaborador.", Information!)
	dw_1.Event ue_Pos(1, "nm_colaborador")
	Return -1
End If

If IsNull( ls_motivo ) or Trim( ls_motivo ) = '' Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe o motivo da libera$$HEX2$$e700e300$$ENDHEX$$o.", Information!)
	dw_1.Event ue_Pos(1, "de_motivo")
	Return -1
Else
	If Len( ls_motivo ) < 14 Then
		Messagebox( "Aten$$HEX2$$e700e300$$ENDHEX$$o","O motivo da libera$$HEX2$$e700e300$$ENDHEX$$o deve ter no m$$HEX1$$ed00$$ENDHEX$$nimo 15 caracteres.", Information! )
		dw_1.Event ue_Pos(1, "de_motivo")
		Return -1
	End If
End If

If Not IsDate(String(ldh_data_ini, "dd/mm/yyyy")) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe corretamente a data de in$$HEX1$$ed00$$ENDHEX$$cio.", Information!)
	dw_1.Event ue_Pos(1, "dh_periodo_ini")
	Return -1
End If

If Not IsDate(String(ldh_data_fim, "dd/mm/yyyy")) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe corretamente a data de t$$HEX1$$e900$$ENDHEX$$rmino.", Information!)
	dw_1.Event ue_Pos(1, "dh_periodo_fim")
	Return -1
End If

If Date(ldh_data_ini) < Date(Today()) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Data inicial deve ser igual ou maior que a data atual.", Information!)
	dw_1.Event ue_Pos(1, "dh_periodo_ini")
	Return -1		
End If

If ldh_data_ini > ldh_data_fim Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Data inicial n$$HEX1$$e300$$ENDHEX$$o pode ser maior que a data final.", Information!)
	dw_1.Event ue_Pos(1, "dh_periodo_ini")
	Return -1			
End If

If gvo_parametro.cd_filial = gvo_parametro.cd_filial_matriz Then
	wf_valida_grava_matriz()
Else
	wf_valida_grava_filial()
End If
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge399_perfil_temporario
integer x = 1705
integer y = 632
end type

