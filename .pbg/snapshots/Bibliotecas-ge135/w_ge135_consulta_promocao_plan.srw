HA$PBExportHeader$w_ge135_consulta_promocao_plan.srw
forward
global type w_ge135_consulta_promocao_plan from dc_w_response_ok_cancela
end type
type dw_2 from dc_uo_dw_base within w_ge135_consulta_promocao_plan
end type
type gb_2 from groupbox within w_ge135_consulta_promocao_plan
end type
end forward

global type w_ge135_consulta_promocao_plan from dc_w_response_ok_cancela
integer width = 2053
integer height = 1256
string title = "GE135 - Consulta Promo$$HEX2$$e700e300$$ENDHEX$$o Planograma"
dw_2 dw_2
gb_2 gb_2
end type
global w_ge135_consulta_promocao_plan w_ge135_consulta_promocao_plan

on w_ge135_consulta_promocao_plan.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.gb_2
end on

on w_ge135_consulta_promocao_plan.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.gb_2)
end on

event ue_postopen;//OverRide

dw_1.Event ue_AddRow()
dw_2.Event ue_Retrieve()
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge135_consulta_promocao_plan
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge135_consulta_promocao_plan
integer width = 795
integer height = 184
string facename = "Verdana"
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge135_consulta_promocao_plan
integer x = 69
integer y = 64
integer width = 731
integer height = 84
string dataobject = "dw_ge135_selecao_promocao"
end type

event dw_1::itemchanged;call super::itemchanged;dw_1.AcceptText()

If dwo.Name = "id_vigente" Then
	dw_2.Event ue_Retrieve()
End If
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge135_consulta_promocao_plan
integer x = 1673
integer y = 1048
integer width = 320
string text = "&Fechar"
end type

event cb_ok::clicked;call super::clicked;cb_Cancelar.Event Clicked()
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge135_consulta_promocao_plan
boolean visible = false
integer x = 27
integer y = 1048
integer width = 325
end type

type dw_2 from dc_uo_dw_base within w_ge135_consulta_promocao_plan
integer x = 59
integer y = 268
integer width = 1906
integer height = 732
integer taborder = 20
string dataobject = "dw_ge135_promocao_planograma"
boolean vscrollbar = true
end type

event ue_recuperar;//OverRide

Long ll_Filial, ll_Produto

String ls_Retorno

ls_Retorno = Message.StringParm

ll_Filial			= Long( Mid( ls_Retorno, 1, 4 ) )
ll_Produto		= Long( Mid( ls_Retorno, 11 ) )

Return This.Retrieve( ll_Produto, ll_Filial )
end event

event ue_preretrieve;call super::ue_preretrieve;String lvs_SQL

dw_1.AcceptText()

If dw_1.Object.Id_Vigente[1] <> "T" Then
	lvs_SQL = "(select * from promocao_sos p1, parametro p2 " +&
					  "where p1.dh_inicio <= p2.dh_movimentacao " +& 
					  "		and (p1.dh_termino is null or p1.dh_termino >= p2.dh_movimentacao) " +&
					  "		and p.cd_promocao_sos = p1.cd_promocao_sos)"

	If dw_1.Object.Id_Vigente[1] = "V" Then
		This.of_AppendWhere("exists " + lvs_SQL)
	Else
		This.of_AppendWhere("not exists " + lvs_SQL)
	End If
End If

Return 1
end event

type gb_2 from groupbox within w_ge135_consulta_promocao_plan
integer x = 23
integer y = 200
integer width = 1970
integer height = 824
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Detalhes"
borderstyle borderstyle = styleraised!
end type

