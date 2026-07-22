HA$PBExportHeader$w_ge038_vendas_periodo.srw
forward
global type w_ge038_vendas_periodo from dc_w_response
end type
type cb_2 from commandbutton within w_ge038_vendas_periodo
end type
type dw_1 from dc_uo_dw_base within w_ge038_vendas_periodo
end type
type cb_1 from commandbutton within w_ge038_vendas_periodo
end type
type gb_1 from groupbox within w_ge038_vendas_periodo
end type
end forward

global type w_ge038_vendas_periodo from dc_w_response
integer width = 1577
integer height = 520
string title = "GE038 - Vendas do Per$$HEX1$$ed00$$ENDHEX$$odo (SPED)"
cb_2 cb_2
dw_1 dw_1
cb_1 cb_1
gb_1 gb_1
end type
global w_ge038_vendas_periodo w_ge038_vendas_periodo

on w_ge038_vendas_periodo.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.dw_1=create dw_1
this.cb_1=create cb_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.gb_1
end on

on w_ge038_vendas_periodo.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.gb_1)
end on

event open;call super::open;dw_1.Event ue_AddRow()
end event

type pb_help from dc_w_response`pb_help within w_ge038_vendas_periodo
end type

type cb_2 from commandbutton within w_ge038_vendas_periodo
integer x = 1161
integer y = 308
integer width = 375
integer height = 112
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Fechar"
end type

event clicked;Close(Parent)
end event

type dw_1 from dc_uo_dw_base within w_ge038_vendas_periodo
integer x = 69
integer y = 88
integer width = 1458
integer height = 176
string dataobject = "dw_ge038_selecao_vendas_periodo"
end type

event ue_key;call super::ue_key;
If This.GetColumnName() = "nm_fantasia" Then
	If Key = KeyEnter! Then
		uo_Filial lvo_Filial
		lvo_Filial = Create uo_Filial
		
		lvo_Filial.of_Localiza_Filial(This.GetText())
		
		If lvo_Filial.localizada Then
			This.Object.nm_fantasia[1] = lvo_Filial.nm_Fantasia
			This.Object.cd_filial[1] 		= lvo_Filial.cd_filial
		End If
	End If
End If

end event

type cb_1 from commandbutton within w_ge038_vendas_periodo
integer x = 558
integer y = 308
integer width = 581
integer height = 112
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Vendas do Per$$HEX1$$ed00$$ENDHEX$$odo"
end type

event clicked;String lvs_File

Date lvdh_Inicial
Date lvdh_Final

Long lvl_Filial

dw_1.AcceptText()

lvdh_Inicial	= dw_1.Object.dh_inicio[1]
lvdh_Final	= dw_1.Object.dh_termino[1]
lvl_Filial		= Long(dw_1.Object.cd_Filial[1])

If IsNull(lvdh_Inicial) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data inicial corretamente.")
	Return -1
End If

If IsNull(lvdh_Final) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data final corretamente.")
	Return -1
End If

If lvdh_Inicial > lvdh_Final Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data final deve ser maior que a data inicial.")
	Return -1
End If

If IsNull(lvl_Filial) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a filial corretamente.")
	Return -1
End If

uo_Menu_Fiscal lvo_Menu
lvo_Menu = Create uo_Menu_Fiscal

lvo_Menu.ivl_Filial = lvl_Filial

SetPointer(HourGlass!)

If lvo_Menu.of_Gera_Vendas_Periodo(Ref lvs_File, lvdh_Inicial, lvdh_Final, False, 0) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Arquivo '"+ lvs_File + "' gerado com sucesso")
End If

SetPointer(Arrow!)
end event

type gb_1 from groupbox within w_ge038_vendas_periodo
integer x = 37
integer y = 16
integer width = 1499
integer height = 264
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
end type

