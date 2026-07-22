HA$PBExportHeader$w_ge162_motivo_alteracao.srw
forward
global type w_ge162_motivo_alteracao from dc_w_response
end type
type cb_1 from commandbutton within w_ge162_motivo_alteracao
end type
type cb_ok from commandbutton within w_ge162_motivo_alteracao
end type
type dw_1 from dc_uo_dw_base within w_ge162_motivo_alteracao
end type
end forward

global type w_ge162_motivo_alteracao from dc_w_response
integer width = 1431
integer height = 912
string title = "GE162 - Motivo Altera$$HEX2$$e700e300$$ENDHEX$$o da Situa$$HEX2$$e700e300$$ENDHEX$$o"
boolean controlmenu = false
cb_1 cb_1
cb_ok cb_ok
dw_1 dw_1
end type
global w_ge162_motivo_alteracao w_ge162_motivo_alteracao

type variables
String ivs_nova_situacao


end variables

on w_ge162_motivo_alteracao.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_ok=create cb_ok
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.dw_1
end on

on w_ge162_motivo_alteracao.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_ok)
destroy(this.dw_1)
end on

event ue_postopen;call super::ue_postopen;ivs_nova_situacao = Message.StringParm

If ivs_nova_situacao  <> "B" and ivs_nova_situacao  <> "D" Then
	dw_1.Object.dt_termino.Visible = 0
	dw_1.Object.label_t.Visible = 0
Else	
	dw_1.Object.dt_termino.Visible = 1
	dw_1.Object.label_t.Visible = 1
End If	

dw_1.Event ue_AddRow()


end event

type pb_help from dc_w_response`pb_help within w_ge162_motivo_alteracao
integer x = 32
integer y = 228
end type

type cb_1 from commandbutton within w_ge162_motivo_alteracao
integer x = 23
integer y = 716
integer width = 402
integer height = 100
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Cancelar"
end type

event clicked;String ls_Retorno

SetNull(ls_Retorno)

CloseWithReturn(Parent, ls_Retorno )
end event

type cb_ok from commandbutton within w_ge162_motivo_alteracao
integer x = 992
integer y = 712
integer width = 402
integer height = 100
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Confirmar"
end type

event clicked;String ls_Texto

DateTime lvdh_GetDate

dw_1.AcceptText()

ls_Texto = String(dw_1.Object.dt_termino[1] )

lvdh_GetDate = gf_GetServerDate()

If ivs_nova_situacao = 'B' Or ivs_nova_situacao = 'D' Then
	If IsNull(dw_1.Object.dt_termino[1]) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data fim do bloqueio. Data n$$HEX1$$e300$$ENDHEX$$o pode ser Vazia!")
		dw_1.Event ue_Pos(1,"dt_termino")
		Return -1
	End If
	If Date(dw_1.Object.dt_termino[1]) <= Date(lvdh_GetDate) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data do bloqueio n$$HEX1$$e300$$ENDHEX$$o pode  ser igual ou inferior a hoje.")
		dw_1.Event ue_Pos(1,"dt_termino")
		Return -1
	End If
Else
	ls_Texto = '00/00/0000'
End If

ls_Texto = ls_Texto +Trim( dw_1.Object.de_motivo[1] )

If ls_Texto = "" Or IsNull( ls_Texto ) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe o motivo de bloqueio!.")
	dw_1.Event ue_Pos(1, "de_motivo")
	Return -1	
End If

//If LenA( ls_Texto ) < 25 Then
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O motivo informado deve conter pelo menos 15 caract$$HEX1$$e900$$ENDHEX$$res.")
//	dw_1.Event ue_Pos(1, "de_motivo")
//	Return -1
//End If

//If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Deseja aplicar o motivo a todos os produtos com a $$HEX1$$1820$$ENDHEX$$situa$$HEX2$$e700e300$$ENDHEX$$o$$HEX1$$1920$$ENDHEX$$ alterada?", Question!, YesNo!, 1 ) = 2 Then
//	dw_1.Event ue_Pos(1, "de_motivo")
//	Return -1
//End If

CloseWithReturn( Parent, ls_Texto)
end event

type dw_1 from dc_uo_dw_base within w_ge162_motivo_alteracao
integer x = 14
integer y = 16
integer width = 1390
integer height = 672
string dataobject = "dw_ge162_motivo_alteracao"
end type

