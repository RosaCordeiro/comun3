HA$PBExportHeader$dc_w_base.srw
forward
global type dc_w_base from window
end type
end forward

global type dc_w_base from window
integer x = 823
integer y = 360
integer width = 2016
integer height = 1208
boolean titlebar = true
boolean controlmenu = true
boolean minbox = true
boolean resizable = true
long backcolor = 79741120
event ue_postopen ( )
event ue_preopen ( )
event type integer ue_messagerouter ( string ps_mensagem )
event type integer ue_save ( )
event type boolean ue_presave ( )
event type boolean ue_preupdate ( )
event type boolean ue_update ( )
event type boolean ue_begintran ( )
event type boolean ue_endtran ( boolean pb_save )
event type integer ue_dberror ( )
event ue_open ( )
event ue_cancel ( )
event ue_print ( )
event ue_printimmediate ( )
event type integer pfc_messagerouter ( string ps_mensagem )
event ue_saveas ( )
event ue_startchanging ( )
event ue_endchanging ( )
end type
global dc_w_base dc_w_base

type variables
INTEGER CD_PERFIL_USUARIO_RL_MENOR_ACESSO = 3

Public:
dc_uo_dberror ivo_dberror
boolean ivb_valida_salva = false, ivb_salvando = false, ivb_alterando = false
Boolean ib_Solicitou_Liberacao_Procedimento_Base = False

Protected:
dc_uo_dw_base ivo_Update_DW[]
dc_uo_dw_base ivo_UpdatePending_DW[]

// Constantes de retorno da fun$$HEX2$$e700e300$$ENDHEX$$o  WF_CONSISTE_SALVA()
Integer OK_SEM_PENDENCIAS = 1, &
            OK_COM_PENDENCIAS = 2, &
            OK_SUCESSO_UPDATE = 3, &
            OK_SEM_UPDATE = 4, &
            CANCELAR_ERRO_PENDENCIAS = -1, &
            CANCELAR_ERRO_UPDATE = -2, &
            CANCELAR_UPDATE = -3

//Permite o fechamento da tela por inatividade,
//Caso n$$HEX1$$e300$$ENDHEX$$o esteja em altera$$HEX2$$e700e300$$ENDHEX$$o
boolean ivb_permite_fechar = True
//grava log na tabela historico_alteracao_tabela
boolean ivb_grava_log = False

Long il_Retorno = 1 // Utilizado para controle de abertura de tela ( ue_PreOpen, Open, ue_PostOpen )

String is_Matricula_Abertura_Tela = ""
end variables

forward prototypes
public subroutine wf_centraliza_janela ()
public function boolean wf_accepttext ()
public function boolean wf_updatespending ()
public subroutine wf_setupdate_dw (dc_uo_dw_base update_dw[])
public function integer wf_valida_salva ()
public subroutine wf_verifica_versao ()
public subroutine wf_set_somente_consulta ()
end prototypes

event ue_postopen();ivo_dbError = Create dc_uo_dbError

//Registra Tela para Controle de Inatividade
If (Not(ivb_permite_fechar)) and (IsValid(gvo_Aplicacao)) Then
	If gvo_Aplicacao.ivb_Usa_Timer_Out Then
		gvo_Aplicacao.of_insere_tela(This.Title)
	End If
End If

// Insere a tela response do array de responses abertas
// Necess$$HEX1$$e100$$ENDHEX$$rio a armazenagem para fechar as telas por inatividade
If IsValid(gvo_Aplicacao) Then
	If gvo_Aplicacao.ivb_usa_timer_out Then
		If This.WindowType = Response! Then
			gvo_Aplicacao.of_insere_response(This)
		End if
	End If
End If

//Verifica se no grupo de acesso a tela est$$HEX1$$e100$$ENDHEX$$ sem permiss$$HEX1$$e300$$ENDHEX$$o de altera$$HEX2$$e700e300$$ENDHEX$$o
// e seta como somente leitura os campos
If This.WindowType <> Response! Then
	wf_set_somente_consulta()
End If	
end event

event ue_preopen();/********************************
A DC_W_RESPONSE sobrescreve este m$$HEX1$$e900$$ENDHEX$$todo
********************************/
Integer li_Achou

String ls_ClassName

If gvo_Aplicacao.ivo_Seguranca.cd_Sistema = 'RL' Then
	ls_ClassName = Upper( This.ClassName( ) )
	
	If ls_ClassName = 'W_RL143_RELATORIO_VENDA_MANIPULADO_VIA_ORCAMENTO' Then
		ls_ClassName = 'W_RL143_REL_VENDA_MANIP_VIA_ORCAMENTO'
	End If
			
	Choose Case ls_ClassName
		Case	'DC_W_MDI', &
				'DC_W_LOGIN_SISTEMA', &
				'DC_W_LIBERACAO_PROCEDIMENTO', &
				'W_RL071_MANUTENCAO_RECEITA_PSICO',&
				'W_RL152_JSON'
			//

		Case Else
			/* Atualmente o perfil com menos acesso $$HEX1$$e900$$ENDHEX$$ o 12 - ESTAGI$$HEX1$$c100$$ENDHEX$$RIO (T$$HEX1$$c900$$ENDHEX$$CNICO EM FARM$$HEX1$$c100$$ENDHEX$$CIA), portanto, se n$$HEX1$$e300$$ENDHEX$$o existir
			 * procedimento cadastrado para o perfil 12, ser$$HEX1$$e100$$ENDHEX$$ exigido login para verificar se o perfil possui acesso ao procedimento.
			 Alterado do perfil 3 para 12 em 26/06/2017 vide chamado 259581
			*/
			SELECT DISTINCT 1
			INTO :li_Achou
			FROM procedimento_perfil_usuario
			WHERE cd_sistema = 'RL'
			AND cd_perfil_usuario IN ( :CD_PERFIL_USUARIO_RL_MENOR_ACESSO )
			AND cd_procedimento = :ls_ClassName
			USING SqlCa;
			
			Choose Case SqlCa.SqlCode
				Case -1
					SqlCa.of_RollBack( )
					SqlCa.of_MsgDbError( 'dc_w_base.event ue_preopen( )' )
					This.il_Retorno = -1
					
				Case 0
					//
					
				Case 100
					ib_Solicitou_Liberacao_Procedimento_Base = True
					
					SetNull( is_Matricula_Abertura_Tela )
					
					If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento( ls_ClassName, ref is_Matricula_Abertura_Tela ) Then 
						This.il_Retorno = -1
					End If
					
			End Choose			
	End Choose
End If
end event

event ue_messagerouter;graphicobject lgo_focus

// Check argument
If IsNull (ps_Mensagem) or LenA (Trim (ps_Mensagem)) = 0 Then
	Return -1
End If

// Try sending the message to this window, if successful exit event.
If This.TriggerEvent(ps_Mensagem) = 1 Then Return 1

// Try sending the message to the current control, if successful exit event.
lgo_focus = GetFocus()
If IsValid (lgo_focus) Then
	If lgo_focus.TriggerEvent (ps_Mensagem) = 1 Then Return 1
End If

// Try sending the message to the last active datawindow, if successful exit event.
//If IsValid (idw_active) Then
//	If idw_active.TriggerEvent (ps_Mensagem) = 1 Then Return 1
//End If

// No objects recognized the message
Return 0
end event

event type integer ue_save();Integer lvi_Retorno = -1

Boolean lvb_Update, &
        lvb_EndTran

SetPointer(HourGlass!)

This.ivb_Salvando = True

If This.Event ue_PreSave() Then 
	If wf_AcceptText() Then 
		If This.Event ue_PreUpdate() Then 
			If wf_UpdatesPending() Then
				If This.Event ue_BeginTran() Then 
					lvb_Update = This.Event ue_Update()
					
					lvb_EndTran = This.Event ue_EndTran(lvb_Update)
					
					If lvb_Update Then 
						If lvb_EndTran Then 
							lvi_Retorno = 1 // Sucesso
							This.ivb_Valida_Salva = False
						End If
					Else
						This.Event ue_dbError()
					End If
				End If
			End If
		End If
	End If
End If

//This.ivb_Valida_Salva = False
This.ivb_Salvando     = False

SetPointer(Arrow!)

Return lvi_Retorno
end event

event ue_presave;Return True
end event

event ue_preupdate;Return True
end event

event type boolean ue_update();Integer lvi_Contador, &
        lvi_Update = 1

dc_uo_DW_Base lvo_DW

For lvi_Contador = 1 To UpperBound(ivo_UpdatePending_DW)
	lvo_DW = ivo_UpdatePending_DW[lvi_Contador]
	
	//grava log se parametro ivb_grava_log estiver habilitado na tela
	lvo_DW.of_Grava_Log(ivb_grava_log)
	
	lvi_Update = lvo_DW.Event ue_Update()
	
	If lvi_Update = -1 Then Return False
Next

Return True
end event

event ue_begintran;Return True
end event

event ue_endtran;If pb_Save Then
	If SqlCa.of_Commit() = -1 Then Return False
Else
	If SqlCa.of_Rollback() = -1 Then Return False
End If

Return True
end event

event ue_dberror;ivo_dbError.of_Trata_Erro()

Return 1
end event

event ue_cancel();This.ivb_Valida_Salva = False


end event

event pfc_messagerouter;GraphicObject lgo_Focus

If Upper(LeftA(ps_Mensagem, 3)) = "PFC" Then
	ps_Mensagem = "ue" + MidA(ps_Mensagem, 4)
End If

If Upper(ps_Mensagem) = "CANCELAR" Then
	ps_Mensagem = "ue_cancel"
End If

If Upper(ps_Mensagem) = "UE_SORTDLG" Then
	ps_Mensagem = "ue_sort"
End If

If Upper(ps_Mensagem) = "UE_FILTERDLG" Then
	ps_Mensagem = "ue_filter"
End If

If Upper(ps_Mensagem) = "UE_FINDDLG" Then
	ps_Mensagem = "ue_find"
End If

If Upper(ps_Mensagem) = "LIMPAR_FILTRO" Then
	ps_Mensagem = "ue_clearfilter"
End If

// Tenta executar o evento na janela
If This.TriggerEvent(ps_Mensagem) = 1 Then Return 1

// Tenta executar o evento no objeto que est$$HEX1$$e100$$ENDHEX$$ com o foco
lgo_Focus = GetFocus()

If IsValid (lgo_Focus) Then
	If lgo_Focus.TriggerEvent(ps_Mensagem) = 1 Then Return 1
End If

// Nenhum objeto reconheceu a mensagem
Return 0
end event

event ue_startchanging();//Evento disparado ao Habilitar o bot$$HEX1$$e300$$ENDHEX$$o confirmar das telas em altera$$HEX2$$e700e300$$ENDHEX$$o

If Not(ivb_alterando) Then
	//Registra Tela para Controle de Inatividade
	If (ivb_permite_fechar)and (IsValid(gvo_Aplicacao)) Then
		If gvo_Aplicacao.ivb_Usa_Timer_Out Then
			gvo_Aplicacao.of_insere_tela(This.Title)
		End If
	End If
End if

ivb_alterando = True
end event

event ue_endchanging();//Evento disparado ao desabilitar o bot$$HEX1$$e300$$ENDHEX$$o confirmar das telas em altera$$HEX2$$e700e300$$ENDHEX$$o

If ivb_alterando Then
	//Remove Tela para Controle de Inatividade
	If (ivb_permite_fechar)and (IsValid(gvo_Aplicacao)) Then
		If gvo_Aplicacao.ivb_Usa_Timer_Out Then
			gvo_Aplicacao.of_remove_tela(This.Title)
		End If
	End If
End If

ivb_alterando = False
end event

public subroutine wf_centraliza_janela ();Window w_Parent
w_Parent = ParentWindow()

This.X = (w_Parent.WorkSpaceWidth () - This.Width ) / 2
This.Y = (w_Parent.WorkSpaceHeight() - This.Height) / 2

This.Show()
end subroutine

public function boolean wf_accepttext ();Integer lvi_Contador, &
        lvi_AcceptText, &
        lvi_Retorno = 1

DataWindow lvo_DW

For lvi_Contador = 1 To UpperBound(ivo_Update_DW)
	lvo_DW = ivo_Update_DW[lvi_Contador]
	
	If lvo_DW.RowCount() + lvo_DW.FilteredCount() + lvo_DW.ModifiedCount() + lvo_DW.DeletedCount() > 0 Then						
		lvi_AcceptText = lvo_DW.AcceptText()
		
		If lvi_AcceptText < 0 Then 
			lvo_DW.SetFocus()
			Return False
		End If
	End If	
Next

Return True
end function

public function boolean wf_updatespending ();dc_uo_dw_base lvo_DW_Vazio[]

Boolean lvb_UpdatePending

String lvs_UpdateTable

Integer lvi_Contador, &
        lvi_Upper

DataWindow lvo_DW

ivo_UpdatePending_DW = lvo_DW_Vazio

If Not ivb_Valida_Salva Then Return False

For lvi_Contador = 1 To UpperBound(ivo_Update_DW)
	lvo_DW = ivo_Update_DW[lvi_Contador]
	
	lvs_UpdateTable = lvo_DW.Describe("DataWindow.Table.UpdateTable")
	
	If lvs_UpdateTable = "?" Or lvs_UpdateTable = "" Then
		lvb_UpdatePending = False
	Else
		If lvo_DW.ModifiedCount() + lvo_DW.DeletedCount() > 0 Then
			lvb_UpdatePending = True
		Else
			lvb_UpdatePending = False
		End If
	End If
	
	If lvb_UpdatePending Then
		lvi_Upper = UpperBound(ivo_UpdatePending_DW)
		ivo_UpdatePending_DW[lvi_Upper + 1] = lvo_DW
	End If	
Next

lvi_Upper = UpperBound(ivo_UpdatePending_DW)

If lvi_Upper > 0 Then
	Return True
Else
	Return False
End If
end function

public subroutine wf_setupdate_dw (dc_uo_dw_base update_dw[]);Integer lvi_Contador

dc_uo_dw_Base lvo_DW

For lvi_Contador = 1 To UpperBound(Update_DW)
	lvo_DW = Update_DW[lvi_Contador]	
	lvo_DW.of_SetUpdateAble()	
Next

ivo_Update_DW = Update_DW
end subroutine

public function integer wf_valida_salva ();Integer lvi_Retorno_Update, &
        lvi_Retorno_Msg, &
		  lvi_Retorno

If Not This.ivb_Valida_Salva Then Return OK_SEM_PENDENCIAS

SetPointer(HourGlass!)

If wf_AcceptText() Then
	If wf_UpdatesPending() Then
		// Existem updates pendentes
		// Pergunta se o usu$$HEX1$$e100$$ENDHEX$$rio deseja salvar as informa$$HEX2$$e700f500$$ENDHEX$$es
		lvi_Retorno_Msg = MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja salvar as altera$$HEX2$$e700f500$$ENDHEX$$es antes de continuar ?", Question!, YesNoCancel!, 1)
	
		Choose Case lvi_Retorno_Msg
			Case 1
				// YES - Update
				If This.Event ue_Save() = 1 Then
					// Update com sucesso
					// Continua o processo
					lvi_Retorno = OK_SUCESSO_UPDATE
				Else
					// Houve erros durante o udpate
					// Aguarda a resolu$$HEX2$$e700e300$$ENDHEX$$o dos erros
					lvi_Retorno = CANCELAR_ERRO_UPDATE
				End If
			Case 2
				// NO - Continua o processo sem salvar as altera$$HEX2$$e700f500$$ENDHEX$$es
				lvi_Retorno = OK_SEM_UPDATE
				This.ivb_Valida_Salva = False
			Case 3
				// CANCEL - N$$HEX1$$e300$$ENDHEX$$o continua o processo
				lvi_Retorno = CANCELAR_UPDATE
		End Choose		
	Else
		// N$$HEX1$$e300$$ENDHEX$$o existem updates pendentes. Continuar o processo normalmente
		lvi_Retorno = OK_SEM_PENDENCIAS		
	End If
Else
	// Existem updates pendentes, mas foram encontradas entrada de dados com erros
	// Permite que o usu$$HEX1$$e100$$ENDHEX$$rio continue o processo sem salvar
	lvi_Retorno_Msg = MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "As informa$$HEX2$$e700f500$$ENDHEX$$es n$$HEX1$$e300$$ENDHEX$$o passaram nas valida$$HEX2$$e700f500$$ENDHEX$$es e devem " + &
													    "estar corrigidas antes de serem salvas.~r~n~r~n" + &
													    "Continuar sem salvar?", &
													    Question!, YesNo!, 2)
	
	If lvi_Retorno_Msg = 1 Then
		// Continuar o processo sem salvar
		lvi_Retorno = OK_COM_PENDENCIAS
		This.ivb_Valida_Salva = False
	Else
		// N$$HEX1$$e300$$ENDHEX$$o continua o processo e aguarda a resolu$$HEX2$$e700e300$$ENDHEX$$o dos erros
		lvi_Retorno = CANCELAR_ERRO_PENDENCIAS
	End If	
End If

SetPointer(Arrow!)
Return lvi_Retorno
end function

public subroutine wf_verifica_versao ();If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = 'AT' Then Return
If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = 'BL' Then Return
If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = 'CL' Then Return // O sistema Caixa faz uma verifica$$HEX2$$e700e300$$ENDHEX$$o espec$$HEX1$$ed00$$ENDHEX$$fica
If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = 'ML' Then Return
If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = 'TD' Then Return
If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = 'TL' Then Return

If Not IsValid( gvo_Parametro ) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Objeto gvo_Parametro n$$HEX1$$e300$$ENDHEX$$o instanciado. ~rdc_w_base.of_verifica_versao()." )
	Return
End If

If gvo_Parametro.cd_Filial = gvo_Parametro.cd_Filial_Matriz Then
	If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema <> 'RO' &
			And gvo_Aplicacao.ivo_Seguranca.Cd_Sistema <> 'EC' Then
		Return
	End If
End If

String ls_Versao

Select nr_versao
   Into :ls_Versao
  From sistema
Where cd_sistema = :gvo_Aplicacao.ivo_Seguranca.Cd_Sistema
  Using SqlCa;

Choose Case SqlCa.SqlCode
	Case -1
		//
		
	Case 100
		//
		
	Case 0
		If gf_Decimal( ls_Versao, 2 ) > gf_Decimal( gvo_Aplicacao.ivs_Versao, 2 ) Then
			If IsNull( gvo_Aplicacao.idh_Primeiro_Alerta_Versao_Nova ) Then 
				gvo_Aplicacao.idh_Primeiro_Alerta_Versao_Nova = DateTime( Today( ), Now( ) )
			End If
			
			OpenWithParm( w_Msg_Versao_Nova, '' )
			ls_Versao = Message.StringParm
		End If
		
End Choose
end subroutine

public subroutine wf_set_somente_consulta ();
end subroutine

on dc_w_base.create
end on

on dc_w_base.destroy
end on

event open;Try
	SetPointer(HourGlass!)

	This.Event ue_PreOpen()
	
	Choose Case il_Retorno
		Case -1
			Close( This )
	
		Case 1
			This.Post Event ue_PostOpen()
			
			If LenA(This.Title) = 0 Then
				If IsValid(gvo_Aplicacao) Then This.Title = gvo_Aplicacao.iapp_Aplicacao.DisplayName
			End If
	End Choose
	
Catch( Exception ex )
	MessageBox( "Exception", ex.getMessage( ) )
	
Finally
	SetPointer(Arrow!)
	
End Try
end event

event close;Destroy(ivo_dbError)

//Remove Tela para Controle de Inatividade
If (Not(ivb_permite_fechar)) and (IsValid(gvo_Aplicacao)) Then
	If gvo_Aplicacao.ivb_Usa_Timer_Out Then
		gvo_Aplicacao.of_remove_tela(This.Title)
	End If
End If

// Remove a tela response do array de responses abertas
// Necess$$HEX1$$e100$$ENDHEX$$rio a armazenagem para fechar as telas por inatividade
If IsValid(gvo_Aplicacao) Then
	If gvo_Aplicacao.ivb_usa_timer_out Then
		If This.WindowType = Response! Then
			gvo_Aplicacao.of_remove_response(This)
		End If
	End If
End If
end event

event closequery;If KeyDown(KeyF4!) Then 
	Return 1
End If

If Not ivb_Valida_Salva Then Return 0

If wf_Valida_Salva() > 0 Then
	Return 0
Else
	Return 1
End If
end event

