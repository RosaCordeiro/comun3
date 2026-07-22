HA$PBExportHeader$w_ge161_consulta_filial_distribuidora_response.srw
forward
global type w_ge161_consulta_filial_distribuidora_response from dc_w_response_ok_cancela
end type
end forward

global type w_ge161_consulta_filial_distribuidora_response from dc_w_response_ok_cancela
integer width = 5714
integer height = 1676
string title = "GE161 - Consulta de Filial na Distribuidora (Response)"
boolean controlmenu = true
end type
global w_ge161_consulta_filial_distribuidora_response w_ge161_consulta_filial_distribuidora_response

on w_ge161_consulta_filial_distribuidora_response.create
call super::create
end on

on w_ge161_consulta_filial_distribuidora_response.destroy
call super::destroy
end on

event open;call super::open;Boolean lb_Dist_Conveniencia

Long ll_Filial
Long ll_Resultado

String ls_Distribuidora
String ls_Erro
String ls_Parametro

dw_1.AcceptText()

ls_Parametro = Message.StringParm

ll_Filial = Long(ls_Parametro)

dw_1.of_AppendWhere_SubQuery("fi.cd_filial = " + String(ll_Filial) + "and fd.id_situacao = 'A'", 3)

ll_Resultado = dw_1.Retrieve()

Choose Case ll_Resultado
		
	Case 0
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existe nenhuma distribuidora ativa para esta filial.", Exclamation!)
		cb_Ok.Event Clicked()
		
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no retrieve da dw_1.", StopSign!)
		cb_Ok.Event Clicked()
		
	Case Else
		dw_1.Object.Cd_Filial_Distribuidora.Protect	= 1
		dw_1.Object.Id_Situacao.Protect				= 1
		dw_1.Object.nr_gln.Protect                        = 1
		dw_1.Object.vl_Minimo_Pedido.Protect		= 1
		dw_1.Object.nr_Prazo_Entrega.Protect		= 1
		dw_1.Object.dh_Horario_Corte.Protect		= 1
		
End Choose
end event

event ue_postopen;//OverRide

dw_1.SetFocus()
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge161_consulta_filial_distribuidora_response
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge161_consulta_filial_distribuidora_response
integer width = 5650
integer height = 1456
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge161_consulta_filial_distribuidora_response
integer y = 76
integer width = 5586
integer height = 1364
string dataobject = "dw_ge161_lista_filial"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event dw_1::ue_postretrieve;call super::ue_postretrieve;Long ll_Find

If pl_Linhas > 0 Then
	ll_Find = This.Find("id_conveniencia > 0", 1, This.RowCount()) 
	
	If ll_Find > 0 Then
		Return ll_Find
	Else
		If ll_Find < 0 Then
			This.Object.nr_gln_t.Visible = 0
			This.Object.nr_gln.Visible    = 0
			This.Object.l_7.Visible 		= 0
		Else
			ll_Find = 0
		End If
	End If
End If

Return pl_Linhas
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge161_consulta_filial_distribuidora_response
integer x = 5362
integer y = 1472
end type

event cb_ok::clicked;call super::clicked;String lvs_Retorno

SetNull(lvs_Retorno)
CloseWithReturn(Parent, lvs_Retorno)
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge161_consulta_filial_distribuidora_response
boolean visible = false
integer x = 4027
integer y = 1476
end type

