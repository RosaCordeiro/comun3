HA$PBExportHeader$w_ge361_motivo_ultima_entrada_gest_estq.srw
forward
global type w_ge361_motivo_ultima_entrada_gest_estq from w_ge361_motivo_ultima_entrada
end type
type cb_1 from commandbutton within w_ge361_motivo_ultima_entrada_gest_estq
end type
type dw_4 from dc_uo_dw_base within w_ge361_motivo_ultima_entrada_gest_estq
end type
end forward

global type w_ge361_motivo_ultima_entrada_gest_estq from w_ge361_motivo_ultima_entrada
string title = "GE361 - Motivo das $$HEX1$$da00$$ENDHEX$$ltimas Entradas (Gest$$HEX1$$e300$$ENDHEX$$o de Estoques)"
cb_1 cb_1
dw_4 dw_4
end type
global w_ge361_motivo_ultima_entrada_gest_estq w_ge361_motivo_ultima_entrada_gest_estq

on w_ge361_motivo_ultima_entrada_gest_estq.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.dw_4=create dw_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.dw_4
end on

on w_ge361_motivo_ultima_entrada_gest_estq.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
destroy(this.dw_4)
end on

event ue_postopen;call super::ue_postopen;dw_1.Object.Dh_Fim_Mov[1] = gvo_Parametro.of_Dh_Movimentacao()
end event

type dw_visual from w_ge361_motivo_ultima_entrada`dw_visual within w_ge361_motivo_ultima_entrada_gest_estq
end type

type gb_aux_visual from w_ge361_motivo_ultima_entrada`gb_aux_visual within w_ge361_motivo_ultima_entrada_gest_estq
end type

type gb_2 from w_ge361_motivo_ultima_entrada`gb_2 within w_ge361_motivo_ultima_entrada_gest_estq
end type

type gb_1 from w_ge361_motivo_ultima_entrada`gb_1 within w_ge361_motivo_ultima_entrada_gest_estq
end type

type dw_1 from w_ge361_motivo_ultima_entrada`dw_1 within w_ge361_motivo_ultima_entrada_gest_estq
string dataobject = "dw_ge361_selecao_hist"
end type

type dw_2 from w_ge361_motivo_ultima_entrada`dw_2 within w_ge361_motivo_ultima_entrada_gest_estq
string dataobject = "dw_ge361_lista_gestao_est"
end type

event dw_2::ue_preretrieve;//OverRide

If This.ivb_SQL_Alterado Then This.of_RestoreOriginalSQL()

DateTime ldh_Movimento
DateTime ldh_Limite
DateTime ldh_Termino

Long ll_Produto

String ls_Planograma
String ls_Conjunto

dw_1.AcceptText()

dw_4.Event ue_Reset()

ls_Planograma	= dw_1.Object.Id_Planogramas		[1]
ldh_Movimento	= dw_1.Object.Dh_Movimento			[1]
ls_Conjunto		= dw_1.Object.Id_Conjunto_Filial		[1]
ll_Produto		= dw_1.Object.Cd_Produto				[1]
ldh_Termino	= DateTime(Date(dw_1.Object.Dh_Fim_Mov[1]), Time("23:59:59"))

If (IsNull(ldh_Movimento)) Or (ldh_Movimento > gvo_Parametro.of_Dh_Movimentacao()) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe uma data v$$HEX1$$e100$$ENDHEX$$lida.", Exclamation!)
	dw_1.Event ue_Pos(1, "dh_movimento")
	Return -1
End If

If ldh_Movimento > ldh_Termino Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a data de t$$HEX1$$e900$$ENDHEX$$rmino.", Exclamation!)
	dw_1.Event ue_Pos(1, "dh_movimento")
	Return -1
End If

//ldh_Limite = DateTime(RelativeDate(Date(gvo_Parametro.of_Dh_Movimentacao()), -365))

//If ldh_Movimento < ldh_Limite Then
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O per$$HEX1$$ed00$$ENDHEX$$odo limite para consulta $$HEX1$$e900$$ENDHEX$$ de 365 dias.", Exclamation!)
//	dw_1.Event ue_Pos(1, "dh_movimento")
//	Return -1
//End If

If ls_Conjunto = "N" Or (ls_Conjunto = "C" And il_Lojas = 0) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe ao menos uma filial.", Exclamation!)
	dw_1.Event ue_Pos(1, "id_conjunto_filial")
	Return -1
End If

This.of_AppendWhere("m.dh_movimento <= '" + String(ldh_Termino, "yyyymmdd hh:mm:ss") + "'", 5)

If ls_Conjunto = "C" And il_Lojas > 0 Then
	This.of_AppendWhere_SubQuery("s.cd_filial in (" + ivs_Filiais + ")", 4)
End If

If ls_Planograma = "C" Then	
	This.of_AppendWhere_SubQuery("g.cd_planograma in (" + io_planogramas.is_Planogramas + ")", 4)
End If

If Not IsNull(ll_Produto) And ll_Produto > 0 Then
	This.of_AppendWhere_SubQuery("s.cd_produto = " + String(ll_Produto), 4)
End If

This.SetSort("")
This.Sort()
	
This.SetSort("cd_filial, cd_produto")
This.Sort()

Return 1
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;dw_2.ivo_Controle_Menu.of_SalvarComo(False)

If This.ShareData(dw_4) = - 1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no share data dw_4.", StopSign!)
	Return -1
End If

Return pl_Linhas
end event

type dw_3 from w_ge361_motivo_ultima_entrada`dw_3 within w_ge361_motivo_ultima_entrada_gest_estq
end type

event dw_3::ue_preretrieve;//OverRide

If This.ivb_SQL_Alterado Then This.of_RestoreOriginalSQL()

DateTime ldh_Termino

dw_1.AcceptText()

ldh_Termino = DateTime(Date(dw_1.Object.Dh_Fim_Mov[1]), Time('23:59:59'))

dw_3.of_AppendWhere("m.dh_movimento <= '" + String(ldh_Termino, "yyyymmdd hh:mm:ss") + "'")
dw_3.of_AppendWhere("m1.dh_movimento <= '" + String(ldh_Termino, "yyyymmdd hh:mm:ss") + "'", 2)

If dw_1.Object.Id_Conjunto_Filial[1] = "C" And il_Lojas > 0 Then
	dw_3.of_AppendWhere("m.cd_filial_movimento in (" + ivs_Filiais + ")")
End If

If dw_1.Object.Id_Planogramas[1] = "C" Then
	dw_3.of_AppendWhere("g.cd_planograma in (" + io_planogramas.is_Planogramas + ")")
End If

If Not IsNull(dw_1.Object.Cd_Produto[1]) And dw_1.Object.Cd_Produto[1] > 0 Then
	dw_3.of_AppendWhere("m.cd_produto = " + String(dw_1.Object.Cd_Produto[1]))
End If

Return 1
end event

type cb_1 from commandbutton within w_ge361_motivo_ultima_entrada_gest_estq
integer x = 3483
integer y = 160
integer width = 498
integer height = 108
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Salvar Arquivo"
end type

event clicked;dw_4.Event ue_SaveAs()
end event

type dw_4 from dc_uo_dw_base within w_ge361_motivo_ultima_entrada_gest_estq
boolean visible = false
integer x = 667
integer y = 1112
integer width = 1358
integer height = 292
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge361_lista_gestao_est_plan"
end type

