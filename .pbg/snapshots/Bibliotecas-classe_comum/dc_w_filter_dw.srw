HA$PBExportHeader$dc_w_filter_dw.srw
forward
global type dc_w_filter_dw from dc_w_response
end type
type gb_2 from groupbox within dc_w_filter_dw
end type
type cb_cancelar from commandbutton within dc_w_filter_dw
end type
type cb_ok from commandbutton within dc_w_filter_dw
end type
type dw_1 from dc_uo_dw_base within dc_w_filter_dw
end type
type cb_excluir from commandbutton within dc_w_filter_dw
end type
end forward

global type dc_w_filter_dw from dc_w_response
integer x = 553
integer y = 524
integer width = 2638
integer height = 1088
string title = "Filtragem de Dados"
boolean controlmenu = false
gb_2 gb_2
cb_cancelar cb_cancelar
cb_ok cb_ok
dw_1 dw_1
cb_excluir cb_excluir
end type
global dc_w_filter_dw dc_w_filter_dw

type variables
dc_uo_filter_dw ivo_filter
end variables

forward prototypes
public subroutine wf_mostra_colunas_disponiveis ()
end prototypes

public subroutine wf_mostra_colunas_disponiveis ();Integer lvi_GetChild
        
Long lvl_Linha

DataWindowChild lvdwc

String lvs_Coluna, &
       lvs_Nome

lvi_GetChild = dw_1.GetChild("coluna", lvdwc)

If lvi_GetChild = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild das colunas.", StopSign!)
Else
	For lvl_Linha = 1 To ivo_Filter.ivds_1.RowCount()		
		lvs_Coluna = ivo_Filter.ivds_1.Object.Coluna[lvl_Linha]
		lvs_Nome   = ivo_Filter.ivds_1.Object.Nome[lvl_Linha]
		
		lvdwc.InsertRow(0)
		
		lvdwc.SetItem(lvl_Linha, "coluna", lvs_Coluna)
		lvdwc.SetItem(lvl_Linha, "nome"  , lvs_Nome)
	Next
End If
end subroutine

on dc_w_filter_dw.create
int iCurrent
call super::create
this.gb_2=create gb_2
this.cb_cancelar=create cb_cancelar
this.cb_ok=create cb_ok
this.dw_1=create dw_1
this.cb_excluir=create cb_excluir
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_2
this.Control[iCurrent+2]=this.cb_cancelar
this.Control[iCurrent+3]=this.cb_ok
this.Control[iCurrent+4]=this.dw_1
this.Control[iCurrent+5]=this.cb_excluir
end on

on dc_w_filter_dw.destroy
call super::destroy
destroy(this.gb_2)
destroy(this.cb_cancelar)
destroy(this.cb_ok)
destroy(this.dw_1)
destroy(this.cb_excluir)
end on

event ue_postopen;call super::ue_postopen;Long lvl_Linha, &
	  lvl_Row, &
	  lvl_Max

If gvo_aplicacao.ivo_Seguranca.Cd_Sistema = 'RL' Then
	pb_Help.Visible = True
End If

wf_Mostra_Colunas_Disponiveis()

lvl_Max = This.ivo_Filter.ivds_2.RowCount()

dw_1.Event ue_Reset()

For lvl_Linha = 1 To lvl_Max
	lvl_Row = dw_1.InsertRow(0)
	dw_1.Object.Coluna  [lvl_Row] = This.ivo_Filter.ivds_2.Object.Coluna  [lvl_Linha]
	dw_1.Object.Operador[lvl_Row] = This.ivo_Filter.ivds_2.Object.Operador[lvl_Linha]
	dw_1.Object.Valor   [lvl_Row] = This.ivo_Filter.ivds_2.Object.Valor   [lvl_Linha]
	dw_1.Object.And_Or  [lvl_Row] = This.ivo_Filter.ivds_2.Object.And_Or  [lvl_Linha]
Next

If dw_1.RowCount() < 1 Then dw_1.Event ue_AddRow()
end event

event open;call super::open;ivo_Filter = Create dc_uo_Filter_DW

ivo_Filter = Message.PowerObjectParm
end event

type pb_help from dc_w_response`pb_help within dc_w_filter_dw
integer x = 23
integer y = 864
end type

event pb_help::clicked;call super::clicked;If gvo_aplicacao.ivo_Seguranca.Cd_Sistema = 'RL' Then
	wf_Help( "barra_menu_filtrar" )
End If
end event

type gb_2 from groupbox within dc_w_filter_dw
integer x = 23
integer y = 4
integer width = 2583
integer height = 848
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
borderstyle borderstyle = styleraised!
end type

type cb_cancelar from commandbutton within dc_w_filter_dw
integer x = 2295
integer y = 872
integer width = 311
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Cancelar"
boolean cancel = true
end type

event clicked;String lvs_Filter

SetNull(lvs_Filter)

CloseWithReturn(Parent, lvs_Filter)
end event

event getfocus;This.Weight = 700
This.Default = True
end event

event losefocus;This.Weight = 400
This.Default = False
end event

type cb_ok from commandbutton within dc_w_filter_dw
integer x = 1957
integer y = 872
integer width = 311
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&OK"
boolean default = true
end type

event clicked;Long lvl_Max, &
     lvl_Linha

String lvs_Coluna, &
       lvs_Operador, &
		 lvs_Valor, &
		 lvs_EOU, &
		 lvs_Filter, &
		 lvs_Tipo
		 
dw_1.AcceptText()

lvl_Max = dw_1.RowCount()

For lvl_Linha = 1 To lvl_Max
	lvs_Coluna   	= Trim(dw_1.Object.Coluna		[lvl_Linha])
	lvs_Operador 	= Trim(dw_1.Object.Operador	[lvl_Linha])
	lvs_Valor    		= Trim(dw_1.Object.Valor		[lvl_Linha])
	lvs_EOU      		= Trim(dw_1.Object.And_Or	[lvl_Linha])

	If IsNull(lvs_Coluna) or lvs_Coluna = "" Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a coluna.", StopSign!)
		dw_1.Event ue_Pos(lvl_Linha, "coluna")
		Return
	End If
	
	If IsNull(lvs_Operador) or lvs_Operador = "" Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o operador.", StopSign!)
		dw_1.Event ue_Pos(lvl_Linha, "operador")
		Return
	End If
	
	If IsNull(lvs_Valor) or lvs_Valor = "" Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o valor.", StopSign!)
		dw_1.Event ue_Pos(lvl_Linha, "valor")
		Return
	End If
	
	If lvl_Linha < lvl_Max Then
		If IsNull(lvs_EOU) or lvs_EOU = "" Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o operador l$$HEX1$$f300$$ENDHEX$$gico 'e/ou'.", StopSign!)
			dw_1.Event ue_Pos(lvl_Linha, "and_or")
			Return
		End If
	End If
	
	lvs_Tipo = ivo_Filter.of_ColType(lvs_Coluna)
	
	Choose Case Lower(LeftA(lvs_Tipo, 5))
		Case "char(", "date", "datet", "time", "times"	
			If LeftA(lvs_Valor, 1) <> "'" or RightA(lvs_Valor, 1) <> "'" Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Valores comparados com colunas cujo tipo seja data, hora ou caracter, ~r" + &
				                      "devem estar envolvidos em aspas simples.~r~r" + &
				                      "Exemplo: 'AAA'", StopSign!)
											 
				dw_1.Event ue_Pos(lvl_Linha, "valor")
				Return
			End If
			
		Case "long", "int", "numbe", "real", "ulong", "decim"
			If Not IsNumber(lvs_Valor) Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Valores comparados com colunas cujo tipo seja num$$HEX1$$e900$$ENDHEX$$rico, ~r" + &
				                      "devem possuir somente n$$HEX1$$fa00$$ENDHEX$$meros, n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitido qualquer outro caracter.", + &
											 StopSign!)

				dw_1.Event ue_Pos(lvl_Linha, "valor")
				Return
			End If
	End Choose
Next

ivo_Filter.ivds_2.Reset()
dw_1.RowsCopy(1, dw_1.RowCount(), Primary!, ivo_Filter.ivds_2, 1, Primary!)

CloseWithReturn(Parent, lvs_Filter)
end event

event getfocus;This.Weight = 700
This.Default = True
end event

event losefocus;This.Weight = 400
This.Default = False
end event

type dw_1 from dc_uo_dw_base within dc_w_filter_dw
integer x = 50
integer y = 56
integer width = 2537
integer height = 780
integer taborder = 30
boolean bringtotop = true
string dataobject = "dc_dw_filtro_aplicado"
boolean vscrollbar = true
end type

event itemchanged;call super::itemchanged;Long lvl_Linha

If dwo.Name = "and_or" and Data <> "" and Row = This.RowCount() Then
	lvl_Linha = This.Event ue_AddRow()

	If lvl_Linha > 0 Then
		This.Event ue_Pos(lvl_Linha, "coluna")
	End If
End If
end event

type cb_excluir from commandbutton within dc_w_filter_dw
integer x = 1408
integer y = 872
integer width = 421
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Excluir Linha"
end type

event clicked;dw_1.Event ue_DeleteRow()

If dw_1.RowCount() = 0 Then
	dw_1.Event ue_AddRow()
End If

dw_1.SetColumn("coluna")
dw_1.SetFocus()
end event

