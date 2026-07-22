HA$PBExportHeader$w_ge414_agendamento_geracao_pedido.srw
forward
global type w_ge414_agendamento_geracao_pedido from dc_w_sheet
end type
type cb_1 from commandbutton within w_ge414_agendamento_geracao_pedido
end type
type cb_confirmar from commandbutton within w_ge414_agendamento_geracao_pedido
end type
type dw_2 from dc_uo_dw_base within w_ge414_agendamento_geracao_pedido
end type
type dw_1 from dc_uo_dw_base within w_ge414_agendamento_geracao_pedido
end type
type cb_2 from commandbutton within w_ge414_agendamento_geracao_pedido
end type
type gb_1 from groupbox within w_ge414_agendamento_geracao_pedido
end type
type gb_2 from groupbox within w_ge414_agendamento_geracao_pedido
end type
end forward

global type w_ge414_agendamento_geracao_pedido from dc_w_sheet
string accessiblename = "Agendamento da Gera$$HEX2$$e700e300$$ENDHEX$$o do Pedido (GE414)"
integer width = 2034
integer height = 1976
string title = "GE414 - Consulta: Agendamento da Gera$$HEX2$$e700e300$$ENDHEX$$o do Pedido (SAP)"
cb_1 cb_1
cb_confirmar cb_confirmar
dw_2 dw_2
dw_1 dw_1
cb_2 cb_2
gb_1 gb_1
gb_2 gb_2
end type
global w_ge414_agendamento_geracao_pedido w_ge414_agendamento_geracao_pedido

type variables
uo_filial io_filial

Boolean ib_Envia_Email

String is_responsavel
String is_nome_responsavel
String is_Parametro
end variables

forward prototypes
public function boolean wf_valida_parametros ()
public function boolean wf_distribuidoras_ativas (long al_filial, boolean ab_estoque_central)
public function boolean wf_carrega_parametros (long al_filial)
public function boolean wf_salva_parametros ()
public function boolean wf_grava_historico (string as_tabela, string as_chave, string as_coluna, string as_de, string as_para, string as_tipo_alteracao)
public function boolean wf_salva_parametros (long al_filial, date adt_atual, date adt_nova, string as_codigo_parametro)
public function boolean wf_nome_responsavel ()
public subroutine wf_bloqueio (string as_codigo, ref string as_nome)
public function boolean wf_altera_parametro_comunicacao (integer al_filial)
public function boolean wf_envia_email (string as_mensagem, boolean ab_envia_email_todos)
public function boolean wf_verifica_liberacao_ba ()
end prototypes

public function boolean wf_valida_parametros ();Time lt_Agora

Date ldt_Parametro, ldt_Estoque_Central, ldt_Dist, ldt_Estoque_Central_Atual, ldt_Dist_Atual

Long ll_Filial, ll_Pedidos

String  ls_Bloqueio_Controlado, ls_Bloqueio_Controlado_Atual

ldt_Parametro = Date(gf_GetServerDate())

dw_1.AcceptText()

ldt_Estoque_Central 			= dw_1.Object.dt_estoque_central		[1]
ldt_Estoque_Central_Atual	= dw_1.Object.dt_estoque_central_atual	[1]

ldt_Dist			= dw_1.Object.dt_distribuidora				[1]
ldt_Dist_Atual	= dw_1.Object.dt_distribuidora_atual		[1]

ll_Filial								= dw_1.Object.cd_filial								[1]
ls_Bloqueio_Controlado			= dw_1.Object.id_bloqueio_controlado			[1]
ls_Bloqueio_Controlado_Atual	= dw_1.Object.id_bloqueio_controlado_atual	[1]

If Not IsNull(ldt_Estoque_Central) Then
	// S$$HEX1$$f300$$ENDHEX$$ vai entrar se tiver altera$$HEX2$$e700e300$$ENDHEX$$o na data.
	If ldt_Estoque_Central_Atual <> ldt_Estoque_Central Then
		If ldt_Estoque_Central < ldt_Parametro Then 
			MessageBox	("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O in$$HEX1$$ed00$$ENDHEX$$cio da gera$$HEX2$$e700e300$$ENDHEX$$o do pedido para o ESTOQUE CENTRAL n$$HEX1$$e300$$ENDHEX$$o pode ser menor que '" + String(ldt_Parametro, 'dd/mm/yyyy') + "'.", Exclamation!)
			dw_1.Event ue_Pos(1, 'dt_estoque_central')
			Return False
		End If
	End If
	
	// Somente se foi alterado a data
	If ldt_Estoque_Central <> Date('31/12/2099') Then
		If Not wf_distribuidoras_ativas(ll_Filial, True) Then Return False
	End If
Else
	MessageBox	("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Data para o inic$$HEX1$$ed00$$ENDHEX$$o da gera$$HEX2$$e700e300$$ENDHEX$$o do pedido para o ESTOQUE CENTRAL $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lida.", Exclamation!)
	dw_1.Event ue_Pos(1, 'dt_estoque_central')
	Return False
End If

If Not IsNull(ldt_Dist) Then
	If ldt_Dist <> ldt_Dist_Atual Then
		If ldt_Dist < ldt_Estoque_Central Then
			MessageBox	("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O in$$HEX1$$ed00$$ENDHEX$$cio da gera$$HEX2$$e700e300$$ENDHEX$$o do pedido para as DISTRIBUIDORAS deve ser maior ou igual ao in$$HEX1$$ed00$$ENDHEX$$cio do ESTOQUE CENTRAL .", Exclamation!)
			dw_1.Event ue_Pos(1, 'dt_distribuidora')
			Return False
		
		ElseIf ldt_Dist = ldt_Parametro Then 
			
			Select count(*)
			Into :ll_Pedidos
			From pedido_filial
			Where dh_emissao in (select dh_movimentacao from parametro where id_parametro = '1')
			Using Sqlca;
			
			If SqlCa.SqlCode = -1 Then
				SqlCa.of_MsgDbError("Erro ao verificar se j$$HEX1$$e100$$ENDHEX$$ iniciou a gera$$HEX2$$e700e300$$ENDHEX$$o dos pedidos.")
				Return False
			End If
			
			If ll_Pedidos > 0 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel liberar a gera$$HEX2$$e700e300$$ENDHEX$$o do pedido para as DISTRIBUIDORAS, pois j$$HEX1$$e100$$ENDHEX$$ iniciou a gera$$HEX2$$e700e300$$ENDHEX$$o dos pedidos.", Exclamation!)
				dw_1.Event ue_Pos(1, 'dt_distribuidora')
				Return False
			End If
						
//			lt_Agora = Now()
//				
//			If lt_Agora > Time('13:20:00') Then 
//				MessageBox	("Aten$$HEX2$$e700e300$$ENDHEX$$o", "J$$HEX1$$e100$$ENDHEX$$ passou do hor$$HEX1$$e100$$ENDHEX$$rio limite para a libera$$HEX2$$e700e300$$ENDHEX$$o da gera$$HEX2$$e700e300$$ENDHEX$$o para as DISTRIBUIDORAS. H$$HEX1$$f300$$ENDHEX$$r$$HEX1$$e100$$ENDHEX$$rio limite $$HEX1$$e900$$ENDHEX$$ '13:20:00'.", Exclamation!)
//				dw_1.Event ue_Pos(1, 'dt_distribuidora')
//				Return False
//			End If
			
		ElseIf ldt_Dist < ldt_Parametro Then
			MessageBox	("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O in$$HEX1$$ed00$$ENDHEX$$cio da gera$$HEX2$$e700e300$$ENDHEX$$o do pedido para as DISTRIBUIDORAS n$$HEX1$$e300$$ENDHEX$$o pode ser menor que '" + String(ldt_Parametro, 'dd/mm/yyyy') + "'.", Exclamation!)
			dw_1.Event ue_Pos(1, 'dt_distribuidora')
			Return False
		End If
	End If
	
	// Somente se foi alterado a data
	If ldt_Dist <> Date('31/12/2099') Then
		If Not wf_distribuidoras_ativas(ll_Filial, False) Then Return False
	End If
Else
	//MessageBox	("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe data de inic$$HEX1$$ed00$$ENDHEX$$o da gera$$HEX2$$e700e300$$ENDHEX$$o do pedido para as DISTRIBUIDORAS corretamente.", Exclamation!)
	//dw_1.Event ue_Pos(1, 'dt_distribuidora')
	//Return False
End If

If ls_Bloqueio_Controlado = 'X' Then
	MessageBox	("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o tipo do bloqueio do controlado.", Exclamation!)
	dw_1.Event ue_Pos(1, 'id_bloqueio_controlado')
	Return False
End If

If ls_Bloqueio_Controlado <> ls_Bloqueio_Controlado_Atual Then
	If ldt_Estoque_Central = Date('31/12/2099') Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data da gera$$HEX2$$e700e300$$ENDHEX$$o do pedido.")
		dw_1.Event ue_Pos(1, 'dt_estoque_central')
		Return False
	End If
End If

Return True
end function

public function boolean wf_distribuidoras_ativas (long al_filial, boolean ab_estoque_central);Long ll_Distribuidoras

If ab_estoque_central Then
	Select count(*)
	Into :ll_Distribuidoras
	From filial_distribuidora
	where cd_filial = :al_filial
	   and cd_distribuidora = '053404705'
	   and id_situacao = 'A'
	Using SqlCa;
Else
	Select count(*)
	Into :ll_Distribuidoras
	From filial_distribuidora
	where cd_filial = :al_filial
	   and cd_distribuidora <> '053404705'
	   and id_situacao = 'A'
	Using SqlCa;
End If

If SqlCa.SqlCode <> -1 Then
	If ll_Distribuidoras = 0 Then
		If ab_estoque_central Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A distribuidora ESTOQUE CENTRAL n$$HEX1$$e300$$ENDHEX$$o esta ATIVA para o agendamento da gera$$HEX2$$e700e300$$ENDHEX$$o dos pedidos.", Exclamation!)
			Return False
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existem DISTRIBUIDORAS ATIVAS para o agendamento da gera$$HEX2$$e700e300$$ENDHEX$$o dos pedidos.", Exclamation!)
			Return False
		End If
	End If
Else
	SqlCa.of_MsgDbError("Erro ao localizar as distribuidoras ativas.")
	Return False
End If

Return True

end function

public function boolean wf_carrega_parametros (long al_filial);String ls_Data_Inicio_Estoque, ls_Data_Inicio_Dist, ls_Tipo_Bloqueio_Controlado, ls_Pedido_Centralizado, ls_Nulo, ls_Situacao

Date ldh_Reinauguracao, ldh_Pedido_Estoque, ldh_Pedido_Dist, ldt_Nulo

Long ll_Produtos

dw_1.Modify("dt_estoque_central.background.color=16777215")
dw_1.Modify("dt_distribuidora.background.color=16777215")

SetNull(ldt_Nulo)
SetNull(ls_Nulo)

dw_1.Object.id_bloqueio_controlado			[1] = ls_Nulo
dw_1.Object.id_bloqueio_controlado_atual	[1] = ls_Nulo

dw_1.Object.dt_estoque_central				[1] = ldt_Nulo
dw_1.Object.dt_estoque_central_Atual		[1] = ldt_Nulo

dw_1.Object.dt_distribuidora					[1] = ldt_Nulo
dw_1.Object.dt_distribuidora_atual			[1] = ldt_Nulo

dw_1.Object.id_pedido_centralizado			[1]	=	ls_Nulo

dw_1.Object.dt_estoque_central.Protect		= 0
dw_1.Object.dt_distribuidora.Protect			= 0

dw_1.Object.st_Dia_Semana_ec.text = ''
dw_1.Object.st_dia_semana_dist.text = ''

Select count(*) 
Into :ll_Produtos
From resumo_reposicao_estoque
Where cd_filial = :al_Filial
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do resumo reposi$$HEX2$$e700e300$$ENDHEX$$o de estoque.")
	Return False
ElseIf ll_Produtos = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O estoque base da filial '" + String(al_Filial) + "' ainda n$$HEX1$$e300$$ENDHEX$$o foi definido.", Exclamation!)
	Return False
End If

Select id_bloqueia_pedido_psico, dh_reinauguracao, coalesce(id_pedido_centralizado, 'N'), id_situacao
Into :ls_Tipo_Bloqueio_Controlado, :ldh_Reinauguracao, :ls_Pedido_Centralizado, :ls_Situacao
From filial
Where cd_filial = :al_Filial
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		
		If ls_Situacao <> 'A' Then
			Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A filial '" + String(al_Filial) + "' n$$HEX1$$e300$$ENDHEX$$o esta ativa.", Exclamation!)
			Return False
		End If
		
		If IsNull(ls_Tipo_Bloqueio_Controlado) Then
			// Pede para selecionar o tipo de bloqueio
			dw_1.Object.id_bloqueio_controlado			[1] = 'X'
			dw_1.Object.id_bloqueio_controlado_atual	[1] = 'X'
		Else
			dw_1.Object.id_bloqueio_controlado			[1] = ls_Tipo_Bloqueio_Controlado
			dw_1.Object.id_bloqueio_controlado_atual	[1] = ls_Tipo_Bloqueio_Controlado
		End If
		
		dw_1.Object.id_pedido_centralizado	[1] = ls_Pedido_Centralizado
		
	Case 100
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Filial n$$HEX1$$e300$$ENDHEX$$o localizada.")
		Return False
	Case -1
		SqlCa.of_MsgDbError("Erro ao localizar a filial.")
		Return False
End Choose

Select vl_parametro
Into :ls_Data_Inicio_Estoque 
From parametro_loja
Where cd_filial = :al_Filial
	and cd_parametro = 'DT_INICIO_GERACAO_PEDIDO_ESTOQUE'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		
		If IsDate(ls_Data_Inicio_Estoque) Then
			dw_1.Object.dt_estoque_central			[1] = Date(ls_Data_Inicio_Estoque)
			dw_1.Object.dt_estoque_central_Atual	[1] = Date(ls_Data_Inicio_Estoque)
		Else
			Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data para o in$$HEX1$$ed00$$ENDHEX$$cio da gera$$HEX2$$e700e300$$ENDHEX$$o do pedido para o ESTOQUE CENTRAL $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lida.", StopSign!)
			Return False
		End If
		
	Case 100
		
	Case -1
		SqlCa.of_MsgDbError("Erro ao localizar o inicio da gera$$HEX2$$e700e300$$ENDHEX$$o do pedido para o ESTOQUE CENTRAL.")
		Return False
End Choose // DT_INICIO_GERACAO_PEDIDO_ESTOQUE

If IsNull(ldh_Reinauguracao) Then
	Select Max(dh_emissao)
	Into :ldh_Pedido_Estoque
	From pedido_distribuidora
	Where cd_filial 				= :al_Filial
		and cd_distribuidora 	= '053404705'
		and id_pedido_almoxarifado = 'N'
	Using SqlCa;
Else
	Select Max(dh_emissao)
	Into :ldh_Pedido_Estoque
	From pedido_distribuidora
	Where cd_filial 				= :al_Filial
		and cd_distribuidora 	= '053404705'
		and dh_emissao 			>= :ldh_Reinauguracao
		and id_pedido_almoxarifado = 'N'
	Using SqlCa;
End If

Choose Case SqlCa.SqlCode
	Case 0
		If Not IsNull(ldh_Pedido_Estoque) Then
			//dw_1.Object.dt_estoque_central.Protect=1
			
			//dw_1.Modify("dt_estoque_central.background.color=134217750")
			
			//dw_1.Object.dt_estoque_central			[1] = Date(ldh_Pedido_Estoque)
			//dw_1.Object.dt_estoque_central_Atual	[1] = Date(ldh_Pedido_Estoque)			
					
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "J$$HEX1$$e100$$ENDHEX$$ foi gerado pedido do ESTOQUE para esta loja.~r~r" +&
											"$$HEX1$$da00$$ENDHEX$$ltimo pedido gerado '" + String(ldh_Pedido_Estoque, "dd/mm/yyyy") + "'.")
											
			dw_1.Event ue_Pos(1, "dt_distribuidora")
		End If
	Case 100
	Case -1
		SqlCa.of_MsgDbError("Erro ao localizar o $$HEX1$$fa00$$ENDHEX$$ltimo pedido gerado para o ESTOQUE CENTRAL.")
		Return False	
End Choose

Select vl_parametro
Into :ls_Data_Inicio_Dist
From parametro_loja
Where cd_filial = :al_Filial
	and cd_parametro = 'DT_INICIO_GERACAO_PEDIDO_DISTRIBUIDORAS'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If IsDate(ls_Data_Inicio_Dist) Then
			dw_1.Object.dt_distribuidora			[1] = Date(ls_Data_Inicio_Dist)
			dw_1.Object.dt_distribuidora_atual	[1] = Date(ls_Data_Inicio_Dist)
		Else
			Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data para o in$$HEX1$$ed00$$ENDHEX$$cio da gera$$HEX2$$e700e300$$ENDHEX$$o do pedido para as DISTRIBUIDORAS $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lida.", StopSign!)
			Return False
		End If
	Case 100
	Case -1 
		SqlCa.of_MsgDbError("Erro ao localizar o inicio da gera$$HEX2$$e700e300$$ENDHEX$$o do pedido para as DISTRIBUIDORAS.")
		Return False
End Choose

If IsNull(ldh_Reinauguracao) Then
	Select Max(dh_emissao)
	Into :ldh_Pedido_Dist
	From pedido_distribuidora
	Where cd_filial 				= :al_Filial
		and cd_distribuidora 	<> '053404705'
	Using SqlCa;
Else
	Select Max(dh_emissao)
	Into :ldh_Pedido_Dist
	From pedido_distribuidora
	Where cd_filial 				= :al_Filial
		and cd_distribuidora 	<> '053404705'
		and dh_emissao 			>= :ldh_Reinauguracao
	Using SqlCa;
End If

Choose Case SqlCa.SqlCode
	Case 0
		If Not Isnull(ldh_Pedido_Dist) Then
			//dw_1.Object.dt_distribuidora.Protect=1
			
			//dw_1.Modify("dt_distribuidora.background.color=134217750")
			
			//dw_1.Object.dt_distribuidora			[1] = Date(ldh_Pedido_Dist)
			//dw_1.Object.dt_distribuidora_Atual	[1] = Date(ldh_Pedido_Dist)			
			
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "J$$HEX1$$e100$$ENDHEX$$ foi gerado pedido das DISTRIBUIDORAS para esta loja.~r~r" +&
											"$$HEX1$$da00$$ENDHEX$$ltimo pedido gerado '" + String(ldh_Pedido_Dist, "dd/mm/yyyy") + "'.")
			
			dw_1.Event ue_Pos(1, "id_bloqueio_controlado")
		End If
	Case 100
	Case -1
		SqlCa.of_MsgDbError("Erro ao localizar o $$HEX1$$fa00$$ENDHEX$$ltimo pedido gerado para as DISTRIBUIDORAS.")
		Return False	
End Choose

Return True
end function

public function boolean wf_salva_parametros ();Boolean lb_Envia_Email_Todos = True

Date ldt_Estoque_Central, ldt_Estoque_Central_Atual, ldt_Dist, ldt_Dist_Atual

Date ldt_Estoque_Central_Programada, ldt_Dist_Programada, ldt_Nulo

Long ll_Filial, ll_Alteracao

String  ls_Bloqueio_Controlado, ls_Bloqueio_Controlado_Atual, ls_Bloqueio_Controlado_Alterado, ls_Achou, ls_Parametro, ls_Chave 

String ls_Nulo, ls_MSG, ls_Pedido_Centralizado, ls_MSG_Email, ls_Desc_Bloqueio

SetNull(ls_Nulo)
Setnull(ldt_Nulo)

ldt_Estoque_Central_Programada 	= ldt_Nulo
ldt_Dist_Programada					= ldt_Nulo

ls_Bloqueio_Controlado_Alterado  	=	ls_Nulo
ls_MSG									=	ls_Nulo

dw_1.AcceptText()

ll_Filial							= dw_1.Object.cd_filial						[1]

ldt_Estoque_Central 			= dw_1.Object.dt_estoque_central		[1]
ldt_Estoque_Central_Atual	= dw_1.Object.dt_estoque_central_atual	[1]

ldt_Dist							=	dw_1.Object.dt_distribuidora				[1]
ldt_Dist_Atual					=	dw_1.Object.dt_distribuidora_atual		[1]

ls_Bloqueio_Controlado			= dw_1.Object.id_bloqueio_controlado			[1]
ls_Bloqueio_Controlado_Atual	= dw_1.Object.id_bloqueio_controlado_atual	[1]

ls_Pedido_Centralizado			= dw_1.Object.id_pedido_centralizado	[1]

If IsNull(ldt_Estoque_Central) 			Then ldt_Estoque_Central 			= Date("01/01/1900")
If IsNull(ldt_Estoque_Central_Atual) 	Then ldt_Estoque_Central_Atual 	= Date("01/01/1900")
If IsNull(ldt_Dist_Atual) 					Then ldt_Dist_Atual 					= Date("01/01/1900")
If IsNull(ldt_Dist) 							Then ldt_Dist 							= Date("01/01/1900")

//If (ldt_Estoque_Central <> ldt_Estoque_Central_Atual) or (Not IsNull(ldt_Estoque_Central) and IsNull(ldt_Estoque_Central_Atual)) Then 
//	ldt_Estoque_Central_Programada = ldt_Estoque_Central
//End If

If (ldt_Estoque_Central <> ldt_Estoque_Central_Atual)  Then 
	ldt_Estoque_Central_Programada = ldt_Estoque_Central
End If

//If (ldt_Dist <> ldt_Dist_Atual) or (Not IsNull(ldt_Dist) and IsNull(ldt_Dist_Atual)) Then 
//	ldt_Dist_Programada = ldt_Dist
//End If

If (ldt_Dist <> ldt_Dist_Atual) Then 
	ldt_Dist_Programada = ldt_Dist
End If

If ls_Bloqueio_Controlado <> ls_Bloqueio_Controlado_Atual Then 
	ls_Bloqueio_Controlado_Alterado = ls_Bloqueio_Controlado
	 wf_bloqueio(ls_Bloqueio_Controlado_Alterado, ref ls_Desc_Bloqueio)
End If

If Not IsNull(ldt_Estoque_Central_Programada) and Not IsNull(ldt_Dist_Programada) and Not IsNull(ls_Bloqueio_Controlado_Alterado) Then
	ls_MSG = "Pedido para o Estoque Central: '"  + String(ldt_Estoque_Central, "dd/mm/yyyy") + "'~r" +&
				  "Pedido para as Distribuidoras: '" + String(ldt_Dist_Programada, "dd/mm/yyyy") + "'~r" +&
				  "Bloqueio dos Produtos Controlados: '" + ls_Desc_Bloqueio  + "'"
ElseIf Not IsNull(ldt_Estoque_Central_Programada) and Not IsNull(ldt_Dist_Programada) and IsNull(ls_Bloqueio_Controlado_Alterado) Then
	ls_MSG = "Pedido para o Estoque Central: '"  + String(ldt_Estoque_Central, "dd/mm/yyyy") + "'~r" +&
				  "Pedido para as Distribuidoras: '" + String(ldt_Dist_Programada, "dd/mm/yyyy") + "'"
ElseIf Not IsNull(ldt_Estoque_Central_Programada) and IsNull(ldt_Dist_Programada) and IsNull(ls_Bloqueio_Controlado_Alterado) Then
	ls_MSG = "Pedido para o Estoque Central: '"  + String(ldt_Estoque_Central, "dd/mm/yyyy") + "'"
ElseIf IsNull(ldt_Estoque_Central_Programada) and Not IsNull(ldt_Dist_Programada) and IsNull(ls_Bloqueio_Controlado_Alterado) Then
	ls_MSG = "Pedido para as Distribuidoras: '" + String(ldt_Dist_Programada, "dd/mm/yyyy") + "'"
ElseIf IsNull(ldt_Estoque_Central_Programada) and IsNull(ldt_Dist_Programada) and Not IsNull(ls_Bloqueio_Controlado_Alterado) Then
	ls_MSG = "Bloqueio dos Produtos Controlados: '" + ls_Desc_Bloqueio  + "'"
ElseIf IsNull(ldt_Estoque_Central_Programada) and Not IsNull(ldt_Dist_Programada) and Not IsNull(ls_Bloqueio_Controlado_Alterado) Then
  	ls_MSG = "Pedido para as Distribuidoras: '" + String(ldt_Dist_Programada, "dd/mm/yyyy") + "'~r" +&
  				 "Bloqueio dos Produtos Controlados: '" + ls_Desc_Bloqueio  + "'"
ElseIf Not IsNull(ldt_Estoque_Central_Programada) and IsNull(ldt_Dist_Programada) and Not IsNull(ls_Bloqueio_Controlado_Alterado) Then
  	ls_MSG = "Pedido para o Estoque Central: '" + String(ldt_Estoque_Central_Programada, "dd/mm/yyyy") + "'~r" +&
  				 "Bloqueio dos Produtos Controlados: '" + ls_Desc_Bloqueio  + "'"
End If

If Not IsNull(ls_MSG) Then
	If Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma as altera$$HEX2$$e700f500$$ENDHEX$$es abaixo ?~r~r" + ls_MSG, Question!, YesNo!, 2) = 2 Then Return False
Else
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existem altera$$HEX2$$e700f500$$ENDHEX$$es para serem salvas.")
	Return False
End If

//Se foi alterado somente o bloqueio de controlado, n$$HEX1$$e300$$ENDHEX$$o envia e-mail para a Log$$HEX1$$ed00$$ENDHEX$$stica, Cobran$$HEX1$$e700$$ENDHEX$$a, Gerenciamento de Categorias e etc...
If ldt_Estoque_Central = ldt_Estoque_Central_Atual Then
	If ldt_Dist = ldt_Dist_Atual Then
		If ls_Bloqueio_Controlado <> ls_Bloqueio_Controlado_Atual Then
			lb_Envia_Email_Todos = False
		End If
	End If
End If

// Grava as altera$$HEX2$$e700f500$$ENDHEX$$es
If ldt_Estoque_Central <> ldt_Estoque_Central_Atual Then 
	If Not wf_Altera_Parametro_Comunicacao(ll_Filial) Then Return False
	ll_Alteracao ++
	If Not wf_salva_parametros(ll_Filial, ldt_Estoque_Central_Atual, ldt_Estoque_Central,&
													'DT_INICIO_GERACAO_PEDIDO_ESTOQUE') Then Return False
													
	ls_MSG_Email = "Libera$$HEX2$$e700e300$$ENDHEX$$o da gera$$HEX2$$e700e300$$ENDHEX$$o para o ESTOQUE CENTRAL: '" + String(ldt_Estoque_Central, 'dd/mm/yyyy') + "'<br>"
End If

If ldt_Dist <> ldt_Dist_Atual Then 
	ll_Alteracao ++
	If Not wf_salva_parametros(ll_Filial, ldt_Dist_Atual, ldt_Dist,&
										'DT_INICIO_GERACAO_PEDIDO_DISTRIBUIDORAS') Then Return False
	
	ls_MSG_Email += "Libera$$HEX2$$e700e300$$ENDHEX$$o da gera$$HEX2$$e700e300$$ENDHEX$$o para as DISTRIBUIDORAS: '" + String(ldt_Dist, 'dd/mm/yyyy') + "'<br>"
End If

If ls_Bloqueio_Controlado <> ls_Bloqueio_Controlado_Atual Then 
	
	ll_Alteracao ++
	
	Update filial
	Set id_bloqueia_pedido_psico = :ls_Bloqueio_Controlado
	Where cd_filial = :ll_Filial
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgDbError("Erro ao atualizar o tipo de bloqueio de psico")
		Return False
	End If	
	
	ls_Chave = String(ll_Filial)
	
	If Not wf_grava_historico(	"FILIAL", ls_Chave, 'ID_BLOQUEIA_PEDIDO_PSICO', &
											ls_Nulo, ls_Bloqueio_Controlado, "A") Then Return False
End If

// Houveram altera$$HEX2$$e700f500$$ENDHEX$$es por$$HEX1$$e900$$ENDHEX$$m n$$HEX1$$e300$$ENDHEX$$o esta liberado a gera$$HEX2$$e700e300$$ENDHEX$$o do pedido
If ll_Alteracao > 0 and ls_Pedido_Centralizado = 'N' Then
	Update filial
	Set id_pedido_centralizado = 'S'
	Where cd_filial = :ll_Filial
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgDbError("Erro ao atualizar a libera$$HEX2$$e700e300$$ENDHEX$$o para gera$$HEX2$$e700e300$$ENDHEX$$o dos pedidos.")
		Return False
	End If	
	
	If Not wf_grava_historico(	"FILIAL", String(ll_Filial), 'ID_PEDIDO_CENTRALIZADO', 'N', 'S', "A") Then Return False
End If

If Not IsNull(ls_MSG_Email) Then
	
	wf_nome_responsavel()
	
	wf_bloqueio(ls_Bloqueio_Controlado, ref ls_Desc_Bloqueio)
		
	ls_MSG_Email += "Bloqueio dos Produtos Controlados: '" + ls_Desc_Bloqueio + "'" + "<br><br>"
	ls_MSG_Email += "Respons$$HEX1$$e100$$ENDHEX$$vel: '" + is_Nome_Responsavel + " (" + is_Responsavel + ")"
	wf_envia_email(ls_MSG_Email, lb_Envia_Email_Todos)
End If

// Libera$$HEX2$$e700e300$$ENDHEX$$o ESTOQUE CENTRAL: 
// Libera$$HEX2$$e700e300$$ENDHEX$$o DISTRIBUIDORAS:
// Bloqueio Produtos Controlados:
// Respons$$HEX1$$e100$$ENDHEX$$vel: Sergio Golembiewski

SqlCa.of_Commit();

If io_Filial.Cd_Unidade_Federacao = "BA" Then
	If Not wf_Verifica_Liberacao_Ba() Then Return False
End If

Return True
end function

public function boolean wf_grava_historico (string as_tabela, string as_chave, string as_coluna, string as_de, string as_para, string as_tipo_alteracao);String ls_Mensagem

Insert Into historico_alteracao_tabela(nm_tabela, de_chave, nm_coluna, de_alteracao_de, 
												de_alteracao_para, nr_matric_alteracao, id_alteracao)
Values (:as_Tabela, :as_Chave, :as_Coluna, :as_De, :as_Para, :is_responsavel, :as_tipo_alteracao)
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_Mensagem = "Erro ao gravar hist$$HEX1$$f300$$ENDHEX$$rico da tabela. " + SqlCa.SQLErrText 
	SqlCa.of_RollBack()
	Return False
End If

Return True
end function

public function boolean wf_salva_parametros (long al_filial, date adt_atual, date adt_nova, string as_codigo_parametro);String ls_Chave, ls_Achou, ls_Data_Atual, ls_Data_Nova

ls_Data_Atual	= string(adt_atual, "dd/mm/yyyy")
ls_Data_Nova	= string(adt_nova, "dd/mm/yyyy")
	
ls_Chave = String(al_filial, "0000") + '@#!' + as_codigo_parametro
	
Select vl_parametro
Into :ls_Achou
From parametro_loja
Where cd_filial = :al_filial
	and cd_parametro = :as_codigo_parametro
Using SqlCa;

Choose Case Sqlca.SqlCode
	Case 0
		UPDATE parametro_loja  
		SET vl_parametro = :ls_Data_Nova
		Where cd_filial = :al_filial
			and cd_parametro = :as_codigo_parametro
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgDbError("Erro ao atualizar o par$$HEX1$$e200$$ENDHEX$$metro loja '" + as_codigo_parametro + "'")
			Return False
		End If
		If Not wf_grava_historico(	"PARAMETRO_LOJA", ls_Chave, 'VL_PARAMETRO', &
											ls_Data_Atual, ls_Data_Nova, "A") Then Return False
		
	Case 100
		INSERT INTO parametro_loja  ( cd_filial,  cd_parametro,  vl_parametro )  
		VALUES ( :al_filial,  :as_codigo_parametro, :ls_Data_Nova)
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgDbError("Erro ao incluir o par$$HEX1$$e200$$ENDHEX$$metro loja '" + as_codigo_parametro + "'")
			Return False
		End If
		
		SetNull(ls_Data_Atual)
		
		If Not wf_grava_historico("PARAMETRO_LOJA", ls_Chave, 'VL_PARAMETRO', ls_Data_Atual, ls_Data_Nova, "I") Then Return False

	Case -1
		SqlCa.of_MsgDbError("Erro ao localizar o par$$HEX1$$e200$$ENDHEX$$metro loja '" + String(as_codigo_parametro) + "'")
		Return False
End Choose

Return True
end function

public function boolean wf_nome_responsavel ();select nm_usuario
Into :is_nome_responsavel
From usuario
Where nr_matricula = :is_responsavel
Using SqlCa;

If SqlCa.Sqlcode = -1 Then
	SqlCa.of_MsgDbError("Erro ao localizar o nome do usu$$HEX1$$e100$$ENDHEX$$rio.")
	Return False
End If

Return True
end function

public subroutine wf_bloqueio (string as_codigo, ref string as_nome);select de_bloqueio 
Into :as_nome
from tipo_bloqueia_pedido_psico
where id_bloqueio = :as_codigo
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do nome do bloqueio.")
	Return
End If

end subroutine

public function boolean wf_altera_parametro_comunicacao (integer al_filial);String ls_Vl_Parametro

Select coalesce(vl_parametro, 'N')
	Into :ls_Vl_Parametro
From parametro_loja
Where cd_filial = :al_Filial
    And cd_parametro = 'ID_REALIZA_COMUNICACAO_AUTOMATICA'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If ls_Vl_Parametro = 'S' Then 
			Return True
		Else
			
			Update parametro_loja
			Set vl_parametro = 'S'
			Where cd_filial = :al_Filial
			    And cd_parametro = 'ID_REALIZA_COMUNICACAO_AUTOMATICA'
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao atualizar o par$$HEX1$$e200$$ENDHEX$$metro 'ID_REALIZA_COMUNICACAO_AUTOMATICA'" +  SqlCa.SQLErrText, StopSign!)
				Return False
			End If
		End If
		
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Par$$HEX1$$e200$$ENDHEX$$metro 'ID_REALIZA_COMUNICACAO_AUTOMATICA' n$$HEX1$$e300$$ENDHEX$$o localizado.", Exclamation!)
		Return False
		
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao atualizar o par$$HEX1$$e200$$ENDHEX$$metro 'ID_REALIZA_COMUNICACAO_AUTOMATICA'" +  SqlCa.SQLErrText, StopSign!)
		Return False
End Choose

Return True
end function

public function boolean wf_envia_email (string as_mensagem, boolean ab_envia_email_todos);Long ll_Filial

String ls_Anexo[]
String ls_MSG
String ls_Email_Regional
String ls_Assinatura

dw_1.AcceptText()

//Usu$$HEX1$$e100$$ENDHEX$$rio escolheu n$$HEX1$$e300$$ENDHEX$$o enviar e-mail quando acionou o bot$$HEX1$$e300$$ENDHEX$$o [Suspender a Gera$$HEX2$$e700e300$$ENDHEX$$o do Pedido]
If Not ib_Envia_Email Then Return False

// Desenvolvimento
If gvo_Aplicacao.ivs_DataSource <> 'central' Then Return True

ll_Filial = dw_1.Object.cd_filial[1]

ls_MSG = "Filial: " + dw_1.Object.nm_fantasia[1] + " (" + String(dw_1.Object.cd_filial[1]) + ")" + '<br><br>'
ls_MSG += "Data: " + String(Today(), "dd/mm/yyyy") + " " + 	String(Now(), "hh:mm:ss") + '<br><br>' 
ls_MSG += as_Mensagem

//Monta a estrutura para enviar o e-mail
s_email str

Select u.de_endereco_email
	Into :ls_Email_Regional
From filial f
	Inner Join regiao r
		On r.cd_regiao = f.cd_regiao
	Inner join usuario u
		On u.nr_matricula = r.nr_matricula_regional
Where f.cd_filial = :ll_Filial
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		
		ls_Assinatura =	' <p>'+ &
							'<FONT color=#ff0000 size=1 face=Arial>'+ &
							'	Este &eacute; um email autom&aacute;tico, n&atilde;o deve ser respondido. '+ &
							'    Cod. '+String(50)+'.'+ &
							'</FONT>'
		
		str.ps_mensagem = ls_MSG + ls_Assinatura
		str.ps_cc[1] = ls_Email_Regional
		str.pb_assinatura = False
				
		If ab_Envia_Email_Todos Then
			gf_ge202_envia_email_padrao(50, str, True)
			
			ls_Assinatura =	' <p>'+ &
						'<FONT color=#ff0000 size=1 face=Arial>'+ &
						'	Este &eacute; um email autom&aacute;tico, n&atilde;o deve ser respondido. '+ &
						'    Cod. '+String(70)+'.'+ &
						'</FONT>'
			
			str.ps_mensagem = ''
			str.ps_mensagem = ls_MSG + ls_Assinatura
			str.ps_cc[1] = String(ll_Filial, "0000") + '@drogarialocal.com.br'
		
			//E-mail enviado separado para a filial com c$$HEX1$$f300$$ENDHEX$$pia para os contatos do c$$HEX1$$f300$$ENDHEX$$digo 70
			gf_ge202_envia_email_padrao(70, str, True)

		Else
			
			ls_Assinatura =	' <p>'+ &
						'<FONT color=#ff0000 size=1 face=Arial>'+ &
						'	Este &eacute; um email autom&aacute;tico, n&atilde;o deve ser respondido. '+ &
						'    Cod. '+String(67)+'.'+ &
						'</FONT>'
			
			str.ps_mensagem = ''
			str.ps_mensagem = ls_MSG + ls_Assinatura
			
			str.ps_cc[2] = String(ll_Filial, "0000") + '@drogarialocal.com.br'
			gf_ge202_envia_email_padrao(67, str, True)
		End If
		
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizado o gerente regional da loja. '" + String(ll_Filial) + "'.")
		Return False
		
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o gerente regional. " + SqlCa.SQLErrText, StopSign!)
		Return False		
End Choose

Return True
end function

public function boolean wf_verifica_liberacao_ba ();Date ldt_Estoque_Central

Long ll_Achou

String ls_Parametro

dw_1.AcceptText()

ldt_Estoque_Central = dw_1.Object.Dt_Estoque_Central[1]

//Se foi agendado o Estoque Central
If Not IsNull(ldt_Estoque_Central) And ldt_Estoque_Central <> Date("31/12/2099") Then

	Select Count(*)
		Into :ll_Achou
	From libera_pedido_filial_estoque
		Where cd_filial = :io_Filial.Cd_Filial
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao consultar a libera$$HEX2$$e700e300$$ENDHEX$$o de pedido do Estoque Central para a Bahia.")
		Return False
	End If
	
	If ll_Achou = 0 Then
		st_parametros_agend_ped str
		
		str.Cd_Filial 			= io_Filial.Cd_Filial
		str.Nm_Fantasia	= io_Filial.Nm_Fantasia
		str.id_Tipo 			= "I"
		str.Id_Tela			= "GE414"
		
		OpenWithParm(w_ge363_agenda_liberacao, str)
	End If
End If

Return True
end function

on w_ge414_agendamento_geracao_pedido.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_confirmar=create cb_confirmar
this.dw_2=create dw_2
this.dw_1=create dw_1
this.cb_2=create cb_2
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_confirmar
this.Control[iCurrent+3]=this.dw_2
this.Control[iCurrent+4]=this.dw_1
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.gb_1
this.Control[iCurrent+7]=this.gb_2
end on

on w_ge414_agendamento_geracao_pedido.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
destroy(this.cb_confirmar)
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.cb_2)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event ue_postopen;call super::ue_postopen;dw_1.Event ue_AddRow()
dw_2.Event ue_AddRow()
dw_1.SetFocus()

This.ivm_Menu.mf_Recuperar(True)



io_Filial = Create uo_Filial

is_Responsavel = gvo_Aplicacao.ivo_Seguranca.Nr_Matricula


end event

event close;call super::close;Destroy io_Filial
end event

type dw_visual from dc_w_sheet`dw_visual within w_ge414_agendamento_geracao_pedido
end type

type gb_aux_visual from dc_w_sheet`gb_aux_visual within w_ge414_agendamento_geracao_pedido
end type

type cb_1 from commandbutton within w_ge414_agendamento_geracao_pedido
boolean visible = false
integer x = 37
integer y = 1672
integer width = 910
integer height = 100
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Suspender a Gera$$HEX2$$e700e300$$ENDHEX$$o do Pedido"
end type

event clicked;Long ll_Filial, ll_Msg_Box

Date ldt_Estoque_Central, ldt_Data_Padrao, ldt_Dist

String ls_MSG

dw_1.AcceptText()

ll_Filial					= dw_1.Object.cd_filial						[1]
ldt_Estoque_Central 	= dw_1.Object.dt_estoque_central		[1]
ldt_Dist					=	dw_1.Object.dt_distribuidora			[1]

ll_Msg_Box =  MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja ENVIAR e-mail para TODOS os setores envolvidos e para a loja?", Question!, YesNoCancel!, 2)

If ll_Msg_Box = 3 Then Return

If ll_Msg_Box = 1 Then
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Foi escolhida a op$$HEX2$$e700e300$$ENDHEX$$o de ENVIAR e-mail para TODOS os setores envolvidos envolvidos e para a loja.~r~rDeseja continuar mesmo assim?" + &
										"~r~rSIM para continuar" + &
										"~rN$$HEX1$$c300$$ENDHEX$$O para cancelar", + &
										Question!, YesNo!, 2) = 2 Then Return
	ib_Envia_Email = True
Else
		
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Foi escolhida a op$$HEX2$$e700e300$$ENDHEX$$o de N$$HEX1$$c300$$ENDHEX$$O ENVIAR e-mail para os setores envolvidos e para a loja. ~r~rDeseja continuar mesmo assim?" + &
										"~r~rSIM para continuar" + &
										"~rN$$HEX1$$c300$$ENDHEX$$O para cancelar", + &
										Question!, YesNo!, 2) = 2 Then Return
	//N$$HEX1$$e300$$ENDHEX$$o vai enviar e-mail
	ib_Envia_Email = False
End If

ldt_Data_Padrao = Date('31/12/2099')

Update filial
Set id_pedido_centralizado = 'N'
Where cd_filial = :ll_Filial
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Erro ao atualizar cancelamento da libera$$HEX2$$e700e300$$ENDHEX$$o para gera$$HEX2$$e700e300$$ENDHEX$$o dos pedidos.")
	Return
Else
	If wf_grava_historico(	"FILIAL", String(ll_Filial), 'ID_PEDIDO_CENTRALIZADO', 'S', 'N', "A") Then
		If wf_salva_parametros(	ll_Filial, ldt_Estoque_Central, ldt_Data_Padrao,&
										'DT_INICIO_GERACAO_PEDIDO_ESTOQUE') Then 
			If wf_salva_parametros(	ll_Filial, ldt_Dist, ldt_Data_Padrao,&
											'DT_INICIO_GERACAO_PEDIDO_DISTRIBUIDORAS') Then
				SqlCa.of_Commit();
				
				wf_nome_responsavel()
										
				ls_MSG += "A gera$$HEX2$$e700e300$$ENDHEX$$o do pedido foi SUSPENSA." + "<br><br>"
				ls_MSG += "Respons$$HEX1$$e100$$ENDHEX$$vel: '" + is_Nome_Responsavel + " (" + is_Responsavel + ")"
				wf_envia_email(ls_MSG, True)
				
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A gera$$HEX2$$e700e300$$ENDHEX$$o do pedido foi suspensa.", Exclamation!)
				
				Close(Parent)
			End If
		End If
	End If
	SqlCa.of_RollBack();
End If

end event

type cb_confirmar from commandbutton within w_ge414_agendamento_geracao_pedido
boolean visible = false
integer x = 1531
integer y = 1672
integer width = 425
integer height = 100
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Confirmar"
end type

event clicked;If wf_valida_parametros() Then
	ib_Envia_Email = True
	
	If wf_salva_parametros() Then
		
		dw_1.Reset()
		dw_2.Reset()
		
		dw_1.Event ue_AddRow()
		dw_2.Event ue_AddRow()
		dw_1.SetFocus()
		
		Close(Parent)
		
	End If	
End If
end event

type dw_2 from dc_uo_dw_base within w_ge414_agendamento_geracao_pedido
integer x = 59
integer y = 688
integer width = 1865
integer height = 940
integer taborder = 40
string dataobject = "dw_ge414_lista_distribuidora"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event ue_recuperar;// OverRide
Long ll_Filial

dw_1.AcceptText()

ll_Filial = dw_1.Object.cd_filial[1]

Return This.Retrieve(ll_Filial)


end event

type dw_1 from dc_uo_dw_base within w_ge414_agendamento_geracao_pedido
integer x = 50
integer y = 92
integer width = 1888
integer height = 416
integer taborder = 20
string dataobject = "dw_ge414_parametros"
end type

event losefocus;call super::losefocus;If IsValid(io_Filial) Then 
	This.Object.nm_fantasia[1] = io_Filial.nm_fantasia
End If
end event

event ue_key;call super::ue_key;If dw_1.GetColumnName() = "nm_fantasia" Then
	If Key = KeyEnter! Then
		io_Filial.of_Localiza_Filial(This.GetText())
		
		If io_Filial.Localizada Then
			This.Object.cd_filial  		[1] = io_Filial.cd_filial
			This.Object.nm_fantasia	[1] = io_Filial.nm_fantasia
			
			//Verifica se vai ser atulizado no SAP
			If Not gf_filial_administrada_sap( io_Filial.cd_filial  , Ref is_Parametro) Then
				Return 1
			End If
			
			If is_Parametro = "S" Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Para altera$$HEX2$$e700f500$$ENDHEX$$es da filial "+String( io_Filial.cd_filial )+" deve ser utilizado o SAP.")
			End If 
			
			If Not wf_carrega_parametros(io_Filial.cd_filial) Then
					Close(Parent)
					Return -1
			End If
			
			
			
			dw_2.Event ue_Recuperar()
		End If
	End If
End If
end event

event constructor;call super::constructor;//This.of_SetColSelection(True)
end event

event itemchanged;call super::itemchanged;String ls_Dia_Semana_EC, ls_Dia_Semana_Dist

dw_1.AcceptText()

If This.GetColumnName() <> "nm_fantasia" Then
	ivb_Valida_Salva = True
End If

If This.GetColumnName() = "nm_fantasia"  Then
	If Not IsNull(Data) and Trim(Data) <> "" Then
		If Data <> io_Filial.nm_fantasia Then
			Return 1
		End If
	Else
		io_Filial.of_Inicializa()
		
		dw_1.Object.cd_filial  		[1] = io_Filial.cd_filial
		dw_1.Object.nm_fantasia[1] = io_Filial.nm_fantasia
		
		dw_2.Reset()
	End If
End If

If This.GetColumnName() = "dt_estoque_central" Then
	
	Choose Case DayNumber(dw_1.Object.dt_estoque_central[1])
		Case 1
			ls_Dia_Semana_EC = 'Domingo'	
		Case 2
			ls_Dia_Semana_EC = 'Segunda-feira'
		Case 3
			ls_Dia_Semana_EC = 'Ter$$HEX1$$e700$$ENDHEX$$a-feira'
		Case 4
			ls_Dia_Semana_EC = 'Quarta-feira'
		Case 5
			ls_Dia_Semana_EC = 'Quinta-feira'
		Case 6
			ls_Dia_Semana_EC = 'Sexta-feira'
		Case 7
			ls_Dia_Semana_EC = 'S$$HEX1$$e100$$ENDHEX$$bado'
	End Choose	
	
	dw_1.Object.st_Dia_Semana_ec.text = Upper(ls_Dia_Semana_EC)
End If

If This.GetColumnName() = "dt_distribuidora" Then
	
	Choose Case DayNumber(dw_1.Object.dt_distribuidora[1])
		Case 1
			ls_Dia_Semana_Dist = 'Domingo'	
		Case 2
			ls_Dia_Semana_Dist = 'Segunda-feira'
		Case 3
			ls_Dia_Semana_Dist = 'Ter$$HEX1$$e700$$ENDHEX$$a-feira'
		Case 4
			ls_Dia_Semana_Dist = 'Quarta-feira'
		Case 5
			ls_Dia_Semana_Dist = 'Quinta-feira'
		Case 6
			ls_Dia_Semana_Dist = 'Sexta-feira'
		Case 7
			ls_Dia_Semana_Dist = 'S$$HEX1$$e100$$ENDHEX$$bado'
	End Choose	
	
	dw_1.Object.st_dia_semana_dist.text = Upper(ls_Dia_Semana_Dist)
End If


end event

event editchanged;call super::editchanged;If This.GetColumnName() <> "nm_fantasia" Then
	ivb_Valida_Salva = True
End If
end event

type cb_2 from commandbutton within w_ge414_agendamento_geracao_pedido
boolean visible = false
integer x = 987
integer y = 1672
integer width = 526
integer height = 100
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Reenviar e-Mail"
end type

event clicked;Boolean lb_Envia_Email_Todos = True

String ls_MSG_Email, ls_Bloqueio_Controlado, ls_Desc_Bloqueio

Date ldt_Estoque_Central, ldt_Dist

dw_1.AcceptText()

If ivb_Valida_Salva Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existem altera$$HEX2$$e700f500$$ENDHEX$$es pendentes. Salve as altera$$HEX2$$e700f500$$ENDHEX$$es antes de prosseguir.", Exclamation!)
	Return -1
End If

ib_Envia_Email = True

ls_MSG_Email = ""

ldt_Estoque_Central 			= 	dw_1.Object.dt_estoque_central		[1]
ldt_Dist							=	dw_1.Object.dt_distribuidora			[1]
ls_Bloqueio_Controlado		= 	dw_1.Object.id_bloqueio_controlado	[1]

// Grava as altera$$HEX2$$e700f500$$ENDHEX$$es
If ldt_Estoque_Central <> Date('31/12/2099') Then 
	ls_MSG_Email = "Libera$$HEX2$$e700e300$$ENDHEX$$o da gera$$HEX2$$e700e300$$ENDHEX$$o para o ESTOQUE CENTRAL: '" + String(ldt_Estoque_Central, 'dd/mm/yyyy') + "'<br>"
End If

If ldt_Dist <> Date('31/12/2099') Then 
	ls_MSG_Email += "Libera$$HEX2$$e700e300$$ENDHEX$$o da gera$$HEX2$$e700e300$$ENDHEX$$o para as DISTRIBUIDORAS: '" + String(ldt_Dist, 'dd/mm/yyyy') + "'<br>"
End If

If ls_Bloqueio_Controlado <> "X" Then
	wf_nome_responsavel()
	
	wf_bloqueio(ls_Bloqueio_Controlado, ref ls_Desc_Bloqueio)
		
	ls_MSG_Email += "Bloqueio dos Produtos Controlados: '" + ls_Desc_Bloqueio + "'" + "<br><br>"
	ls_MSG_Email += "Respons$$HEX1$$e100$$ENDHEX$$vel: '" + is_Nome_Responsavel + " (" + is_Responsavel + ")"
End If

If ls_MSG_Email <> ""  Then
	wf_envia_email(ls_MSG_Email, lb_Envia_Email_Todos)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existe informa$$HEX2$$e700f500$$ENDHEX$$es para enviar por e-mail.")
End If
end event

type gb_1 from groupbox within w_ge414_agendamento_geracao_pedido
integer x = 32
integer y = 20
integer width = 1920
integer height = 516
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Agendamento da Gera$$HEX2$$e700e300$$ENDHEX$$o de Pedidos"
borderstyle borderstyle = styleraised!
end type

type gb_2 from groupbox within w_ge414_agendamento_geracao_pedido
integer x = 32
integer y = 600
integer width = 1920
integer height = 1056
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Distribuidoras Ativas"
borderstyle borderstyle = styleraised!
end type

