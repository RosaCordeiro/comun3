HA$PBExportHeader$w_ge108_desistencia.srw
forward
global type w_ge108_desistencia from dc_w_response_ok_cancela
end type
end forward

global type w_ge108_desistencia from dc_w_response_ok_cancela
integer width = 2245
integer height = 560
string title = "GE108 - Motivo desist$$HEX1$$ea00$$ENDHEX$$ncia"
end type
global w_ge108_desistencia w_ge108_desistencia

on w_ge108_desistencia.create
call super::create
end on

on w_ge108_desistencia.destroy
call super::destroy
end on

event ue_postopen;call super::ue_postopen;String ls_retorno

ls_Retorno = Message.StringParm

If Not IsNull(ls_Retorno) And Trim(ls_Retorno) > '' Then
	This.Title = "GE108 - Motivo desist$$HEX1$$ea00$$ENDHEX$$ncia ( Atendente: " + ls_retorno + " )"	
End If

If gvo_Parametro.id_rede_filial = 'PP' Then
	Long lvl_rc
	DataWindowChild lvdwc_Obj
	
	lvl_rc = dw_1.GetChild('de_motivo', lvdwc_Obj)
	
	If lvl_rc > 0 Then	
		lvl_rc = lvdwc_Obj.find( "x.id_motivo='PC'", 1, lvdwc_Obj.rowcount( )  )
		lvdwc_Obj.deleterow( lvl_rc )
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild.", Information!)	
	End If
End If

dw_1.SetTabOrder('de_justificativa', 0)


end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge108_desistencia
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge108_desistencia
integer width = 2176
integer height = 296
integer taborder = 20
integer weight = 700
fontcharset fontcharset = defaultcharset!
string facename = "Verdana"
string text = "Desist$$HEX1$$ea00$$ENDHEX$$ncia"
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge108_desistencia
integer y = 72
integer width = 2130
integer height = 204
integer taborder = 50
string dataobject = "dw_ge108_desistencia"
end type

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	If This.GetColumnName() = "de_motivo" Then
		If dw_1.Object.de_motivo[1] = 'OT' Then
			//Habilita o campo para digitar a justificativa
			dw_1.Event ue_Pos(1, "de_justificativa")					
		End If
   End If			
End If
end event

event dw_1::itemchanged;call super::itemchanged;If dwo.Name = "de_motivo" Then
	If Trim(Data) <> 'OT' Then
		dw_1.Object.de_justificativa[1] = ''
		dw_1.SetTabOrder('de_justificativa', 0)
	Else
		dw_1.SetTabOrder('de_justificativa', 20)		
		dw_1.Event ue_Pos(1, "de_justificativa")			
	End If
End If
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge108_desistencia
integer x = 1550
integer y = 328
integer taborder = 30
end type

event cb_ok::clicked;call super::clicked;String ls_retorno, ls_motivo
Boolean lb_sair = False

dw_1.AcceptText()

ls_motivo = dw_1.Object.de_motivo[1]

Choose Case dw_1.Object.de_motivo[1]
	Case 'OT'
		If Trim(dw_1.Object.de_justificativa[1]) = '' Or IsNull(dw_1.Object.de_justificativa[1]) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Para esse motivo $$HEX1$$e900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio informar uma justificativa!", Information!)
			lb_sair = False
			dw_1.Event ue_Pos( 1, 'de_justificativa' )
			Return -1
		Else
			ls_retorno = dw_1.Object.de_justificativa[1]
			lb_sair = True
		End If
	Case Else
		ls_retorno = dw_1.Describe("Evaluate('LookUpDisplay(de_motivo)',1)")
		lb_sair = True
		
		If IsNull(ls_motivo) or Trim(ls_motivo) = '' Then lb_sair = False		
End Choose

If lb_sair Then
	CloseWithReturn(Parent, ls_retorno)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o motivo da desist$$HEX1$$ea00$$ENDHEX$$ncia!", Information!)
	Return -1
End If
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge108_desistencia
integer x = 1883
integer y = 328
integer taborder = 40
end type

