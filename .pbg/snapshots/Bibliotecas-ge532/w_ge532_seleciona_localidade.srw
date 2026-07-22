HA$PBExportHeader$w_ge532_seleciona_localidade.srw
forward
global type w_ge532_seleciona_localidade from dc_w_response_ok_cancela
end type
type cb_1 from commandbutton within w_ge532_seleciona_localidade
end type
type cb_2 from commandbutton within w_ge532_seleciona_localidade
end type
end forward

global type w_ge532_seleciona_localidade from dc_w_response_ok_cancela
integer width = 1600
integer height = 852
string title = "GE532 - Seleciona Cidade"
cb_1 cb_1
cb_2 cb_2
end type
global w_ge532_seleciona_localidade w_ge532_seleciona_localidade

type variables
uo_cidade ivo_Cidade // GE008

Long il_Filial
end variables

on w_ge532_seleciona_localidade.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
end on

on w_ge532_seleciona_localidade.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_2)
end on

event ue_preopen;call super::ue_preopen;ivo_Cidade = Create uo_Cidade
end event

event close;call super::close;If IsValid(ivo_Cidade) Then Destroy(ivo_Cidade)
end event

event ue_postopen;call super::ue_postopen;Long ll_Cidade

ll_Cidade = Message.DoubleParm

ivo_Cidade.of_localiza_codigo( ll_Cidade )
	
If ivo_Cidade.Localizada Then
	dw_1.Object.cd_cidade		[1] = ivo_Cidade.Cd_Cidade
	dw_1.Object.nm_cidade		[1] = ivo_Cidade.Nm_Cidade
	dw_1.Object.nr_localidade	[1] = ivo_Cidade.Nr_Localidade_Ect
	
	ivo_Cidade.Of_Inicializa()
End If			

dw_1.Event ue_AddRow()
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge532_seleciona_localidade
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge532_seleciona_localidade
integer width = 1527
integer height = 632
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge532_seleciona_localidade
integer width = 1463
integer height = 548
string dataobject = "dw_ge532_selecao_cidade"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event dw_1::ue_key;call super::ue_key;Long ll_Find

If Key = KeyEnter! Then
	Choose Case This.GetColumnName() 
		Case "nm_cidade"
			
			ivo_Cidade.of_Localiza_Cidade(This.GetText())
			
			If ivo_Cidade.Localizada Then
				ll_Find = This.Find("cd_cidade = "	+ String(ivo_cidade.cd_cidade), 1, This.Rowcount())
				
				If ll_Find < 0 Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no Find da dw_1.", Stopsign!)
					Return -1
				End If
				
				If ll_Find > 0 Then 
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Cidade j$$HEX1$$e100$$ENDHEX$$ selecionada.", Exclamation!)
					Return -1
				End If
				
				This.Object.cd_cidade[This.GetRow()] 	= ivo_Cidade.Cd_Cidade
				This.Object.nm_cidade[This.GetRow()] 	= ivo_Cidade.Nm_Cidade
				This.Object.nr_localidade[This.GetRow()] = ivo_Cidade.Nr_Localidade_Ect
				
			End If			
	End Choose
	
End If

end event

event dw_1::ue_preinsertrow;call super::ue_preinsertrow;If This.Find("isnull( cd_cidade )", 1, This.RowCount()) > 0 Then
	Return -1
Else
	Return 1	
End If
end event

event dw_1::constructor;call super::constructor;This.of_SetRowSelection()
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge532_seleciona_localidade
integer x = 919
integer y = 656
integer height = 92
boolean default = false
end type

event cb_ok::clicked;call super::clicked;Long ll_Linha
Long ll_Contador = 0

String ls_Nr_Localidade

If dw_1.RowCount() > 0 Then
	For ll_Linha = 1 To dw_1.RowCount()
		If Not IsNull( dw_1.Object.cd_cidade [ll_Linha] ) Then
			ll_Contador ++
			
			If ll_Contador = 1 Then
				ls_Nr_Localidade = String(dw_1.Object.nr_localidade [ll_Linha])
			Else
				ls_Nr_Localidade = ls_Nr_Localidade + "," + String(dw_1.Object.nr_localidade [ll_Linha])
			End If
			
		Else
			dw_1.DeleteRow( ll_Linha )
		End If		
	Next
	
	CloseWithReturn(Parent, ls_Nr_Localidade)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione pelo menos uma cidade.")
End If
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge532_seleciona_localidade
integer x = 1239
integer y = 656
integer height = 92
end type

type cb_1 from commandbutton within w_ge532_seleciona_localidade
integer x = 37
integer y = 656
integer width = 306
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Incluir"
end type

event clicked;dw_1.Event ue_AddRow()
end event

type cb_2 from commandbutton within w_ge532_seleciona_localidade
integer x = 379
integer y = 656
integer width = 306
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "E&xcluir"
end type

event clicked;Long ll_Linha

dw_1.AcceptText()

ll_Linha = dw_1.GetRow()

dw_1.deleteRow(ll_Linha)
end event

