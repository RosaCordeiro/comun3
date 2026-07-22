HA$PBExportHeader$w_ge101_divisoes_fornecedor.srw
forward
global type w_ge101_divisoes_fornecedor from dc_w_response_ok_cancela
end type
type dw_2 from dc_uo_dw_base within w_ge101_divisoes_fornecedor
end type
type gb_2 from groupbox within w_ge101_divisoes_fornecedor
end type
end forward

global type w_ge101_divisoes_fornecedor from dc_w_response_ok_cancela
integer width = 3438
integer height = 988
string title = "GE101 - Lista de Divis$$HEX1$$f500$$ENDHEX$$es"
dw_2 dw_2
gb_2 gb_2
end type
global w_ge101_divisoes_fornecedor w_ge101_divisoes_fornecedor

type variables
String is_fornecedor

Boolean ib_Check
end variables

event open;call super::open;is_fornecedor 	= Mid(Message.StringParm	, 1, 9)
end event

event ue_postopen;call super::ue_postopen;dw_1.Event ue_AddRow()
dw_2.Event ue_AddRow()

dw_1.Event ue_Retrieve()

dw_1.SetFocus()
end event

on w_ge101_divisoes_fornecedor.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.gb_2
end on

on w_ge101_divisoes_fornecedor.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.gb_2)
end on

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge101_divisoes_fornecedor
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge101_divisoes_fornecedor
integer width = 3369
integer height = 732
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge101_divisoes_fornecedor
integer x = 59
integer width = 3305
integer height = 628
string dataobject = "dw_ge101_divisao_fornecedor"
boolean vscrollbar = true
end type

event dw_1::ue_recuperar;// OverRide

Return This.Retrieve(is_Fornecedor)
end event

event dw_1::doubleclicked;call super::doubleclicked;String lvs_Incluir_Excluir, ls_Marcacao

Integer li_Row
		  
If dwo.Name = "p_imagem" Then
	
	If ib_Check Then
		ls_Marcacao = 'N'
		ib_Check 	 = False
	Else
		ls_Marcacao = 'S'
		ib_Check 	 = True
	End If
	
	For li_Row = 1 To This.RowCount()
		This.Object.id_selecionar[li_Row] = ls_Marcacao
	Next
	
End If

end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge101_divisoes_fornecedor
integer x = 2747
integer y = 760
end type

event cb_ok::clicked;call super::clicked;Long ll_Find
Long ll_Linha
Long ll_Cd_Cond_Pagto
Long lvl_Contador

String ls_Lista_Divisoes
String ls_Retorno
String ls_Cond_Forn

dw_1.AcceptText()
dw_2.AcceptText()

ll_Find = dw_1.Find("id_selecionar = 'S'", 1, dw_1.RowCount())

If ll_Find > 0 Then
	
	ls_Cond_Forn = dw_2.Object.Id_Condicao_Div[1]
	
	For ll_Linha = 1 To dw_1.RowCount()
		If dw_1.Object.id_selecionar[ll_Linha] = 'S' Then
			
			If ls_Cond_Forn = "S" Then
				If IsNull(ll_Cd_Cond_Pagto) or ll_Cd_Cond_Pagto = 0 Then
					ll_Cd_Cond_Pagto = dw_1.Object.Cd_Condicao_Pagamento[ll_Linha]
				End If
			Else
				ll_Cd_Cond_Pagto = dw_1.Object.Cd_Condicao_Pagto_Forn[ll_Linha]
			End If
			
			lvl_Contador ++
						
			If lvl_Contador = 1 Then
				ls_Lista_Divisoes =  String(dw_1.Object.nr_divisao[ll_Linha])
			Else
				ls_Lista_Divisoes = ls_Lista_Divisoes + ", " + String(dw_1.Object.nr_divisao[ll_Linha])
			End If
			
		End If
	Next	
	
	If IsNull(ll_Cd_Cond_Pagto) Then ll_Cd_Cond_Pagto = 0
	
	ls_Retorno =  String(ll_Cd_Cond_Pagto, '0000') + "|" + ls_Lista_Divisoes
	
	CloseWithReturn(Parent, ls_Retorno)
	
ElseIf ll_Find = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma divis$$HEX1$$e300$$ENDHEX$$o foi selecionada.", Exclamation!)
Else 
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no find ao localizar se alguma divis$$HEX1$$e300$$ENDHEX$$o foi selecionada.")
	Close(Parent)
End If
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge101_divisoes_fornecedor
integer x = 3081
integer y = 760
end type

type dw_2 from dc_uo_dw_base within w_ge101_divisoes_fornecedor
integer x = 41
integer y = 772
integer width = 1463
integer height = 100
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge101_condicao_pagto_div"
end type

type gb_2 from groupbox within w_ge101_divisoes_fornecedor
integer x = 27
integer y = 736
integer width = 1504
integer height = 144
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
end type

