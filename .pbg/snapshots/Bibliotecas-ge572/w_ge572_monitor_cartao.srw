HA$PBExportHeader$w_ge572_monitor_cartao.srw
forward
global type w_ge572_monitor_cartao from dc_w_selecao_lista_relatorio
end type
type cb_reprocessar from commandbutton within w_ge572_monitor_cartao
end type
end forward

global type w_ge572_monitor_cartao from dc_w_selecao_lista_relatorio
integer width = 2674
integer height = 1632
string title = "GE572 - Monitor exporta$$HEX2$$e700e300$$ENDHEX$$o cart$$HEX1$$e300$$ENDHEX$$o sa$$HEX1$$fa00$$ENDHEX$$de"
cb_reprocessar cb_reprocessar
end type
global w_ge572_monitor_cartao w_ge572_monitor_cartao

on w_ge572_monitor_cartao.create
int iCurrent
call super::create
this.cb_reprocessar=create cb_reprocessar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_reprocessar
end on

on w_ge572_monitor_cartao.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_reprocessar)
end on

event ue_postopen;call super::ue_postopen;dw_1.Object.Dh_Inicio		[1] = Date(gf_GetServerDate())
dw_1.Object.Dh_Fim			[1] = Date(gf_GetServerDate())
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge572_monitor_cartao
integer y = 932
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge572_monitor_cartao
integer y = 860
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge572_monitor_cartao
integer width = 2569
integer height = 992
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge572_monitor_cartao
integer width = 1509
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge572_monitor_cartao
integer y = 96
integer width = 1385
string dataobject = "dw_ge572_selecao_monitor"
end type

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge572_monitor_cartao
integer width = 2523
integer height = 900
string dataobject = "dw_ge572_lista_monitor"
end type

event dw_2::ue_postretrieve;call super::ue_postretrieve;dw_2.ivo_Controle_Menu.of_SalvarComo(False)

IF AncestorReturnValue > 0 THEN
	cb_Reprocessar.Enabled = TRUE
	THIS.Event RowFocusChanged(1)
ELSE
	cb_Reprocessar.Enabled = FALSE
END IF

RETURN AncestorReturnValue
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;Date ldh_Inicio
Date ldh_Termino

Long lvl_convenio

String lvs_situacao

dw_1.AcceptText()

lvl_convenio		= dw_1.Object.cd_convenio	[1]
ldh_Inicio		= Date(dw_1.Object.Dh_Inicio		[1])
ldh_Termino	= Date(dw_1.Object.Dh_Fim		[1])
lvs_situacao		= dw_1.Object.id_situacao	[1]

If Not IsNull(lvl_convenio) And lvl_convenio > 0 Then
	This.of_AppendWhere("cd_convenio = " + String(lvl_convenio))		
End If

If Not IsNull(ldh_Inicio) And Not IsNull(ldh_Termino) Then
	If Date(ldh_Inicio) > Date(gf_GetServerDate()) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a data atual.")
		dw_1.Event ue_Pos(1, "dh_inicio")
		Return -1
	End If
	
	If Date(ldh_Inicio) > Date(ldh_Termino) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a data de in$$HEX1$$ed00$$ENDHEX$$cio.")
		dw_1.Event ue_Pos(1, "dh_inicio")
		Return -1
	End If

	This.of_AppendWhere("dh_registro >= '" + String(ldh_Inicio, "yyyymmdd") + "' and dh_registro <= '" + String(ldh_Termino, "yyyymmdd") + "'")
End If

If Upper(lvs_situacao) = 'A' Or Upper(lvs_situacao) = 'P' Then
	This.of_AppendWhere("id_situacao = " + Upper(lvs_situacao))
End If

Return 1
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge572_monitor_cartao
boolean visible = false
integer x = 2107
integer y = 112
end type

type cb_reprocessar from commandbutton within w_ge572_monitor_cartao
integer x = 1865
integer y = 176
integer width = 402
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Reprocessar"
end type

event clicked;If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Confirma reprocessamento cart$$HEX1$$e300$$ENDHEX$$o sa$$HEX1$$fa00$$ENDHEX$$de?", Question!, YesNo!) = 1 Then

	uo_ge572_cartao_saude lvo_cartao_saude
	lvo_cartao_saude = Create uo_ge572_cartao_saude
	
	lvo_cartao_saude.of_atualiza_cartao_saude( true )
	
	Destroy(lvo_cartao_saude)	
	
End If
end event

