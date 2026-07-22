HA$PBExportHeader$dc_uo_barra_selecao_vertical.sru
forward
global type dc_uo_barra_selecao_vertical from userobject
end type
type cb_seleciona_um from commandbutton within dc_uo_barra_selecao_vertical
end type
type cb_seleciona_todos from commandbutton within dc_uo_barra_selecao_vertical
end type
type cb_deseleciona_todos from commandbutton within dc_uo_barra_selecao_vertical
end type
type cb_deseleciona_um from commandbutton within dc_uo_barra_selecao_vertical
end type
end forward

global type dc_uo_barra_selecao_vertical from userobject
integer width = 151
integer height = 400
boolean border = true
long backcolor = 67108864
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event type long deseleciona_um ( )
event type integer deseleciona_todos ( )
event type long seleciona_um ( )
event type integer seleciona_todos ( )
event type boolean ue_permite_deselecionar ( integer ai_linha )
event type boolean ue_permite_selecionar ( integer ai_linha )
cb_seleciona_um cb_seleciona_um
cb_seleciona_todos cb_seleciona_todos
cb_deseleciona_todos cb_deseleciona_todos
cb_deseleciona_um cb_deseleciona_um
end type
global dc_uo_barra_selecao_vertical dc_uo_barra_selecao_vertical

type variables
dc_uo_dw_base idw_Origem, idw_Destino

String ivs_find

Protected:
Boolean ivb_Habilitado = True
end variables

forward prototypes
public subroutine of_habilita ()
public subroutine of_limpa_dw_destino ()
public subroutine of_habilita_controle (boolean pb_habilita)
end prototypes

event deseleciona_um;Integer lvi_Linha

lvi_Linha = idw_Destino.GetRow()

If lvi_Linha = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma linha para deselecionar.", Information!)
	Return -1	
End If

If Not This.Event ue_Permite_Deselecionar(lvi_Linha) Then Return -1

idw_Destino.DeleteRow(lvi_Linha)

This.of_Habilita()

Return lvi_Linha

end event

event deseleciona_todos;Integer lvi_Total, &
        lvi_Linha, &
        lvi_Excluidas

lvi_Total = idw_Destino.RowCount()

lvi_Excluidas = 0

For lvi_Linha = 1 To lvi_Total
	If This.Event ue_Permite_Deselecionar(lvi_Linha - lvi_Excluidas) Then
		idw_Destino.DeleteRow(lvi_Linha - lvi_Excluidas)
		
		lvi_Excluidas ++
	End If
Next

This.of_Habilita()

Return 1
end event

event seleciona_um;Integer lvi_Linha_Origem, &
        lvi_Linha_Destino, &
		  lvi_RowsCopy

idw_Origem.AcceptText()

lvi_Linha_Origem = idw_Origem.GetRow()

If lvi_Linha_Origem = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma linha para selecionar.", Information!)
	Return -1	
End If

If Not This.Event ue_Permite_Selecionar(lvi_Linha_Origem) Then Return -1

lvi_Linha_Destino = idw_Destino.RowCount() + 1

lvi_RowsCopy = idw_Origem.RowsCopy(lvi_Linha_Origem, lvi_Linha_Origem, Primary!, idw_Destino, lvi_Linha_destino, Primary!)

If lvi_RowsCopy = 1 Then
	This.of_Habilita()
	Return lvi_Linha_Destino
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro durante a c$$HEX1$$f300$$ENDHEX$$pia da linha.", Information!)
	Return -1
End If
end event

event seleciona_todos;//// Este evento dever$$HEX1$$e100$$ENDHEX$$ ser programado em cada janela uma vez que depende de compara$$HEX2$$e700e300$$ENDHEX$$o entre
//// colunas para copiar somente linhas que j$$HEX1$$e100$$ENDHEX$$ n$$HEX1$$e300$$ENDHEX$$o existam na DW de destino.
Integer lvi_rcRowsCopy

of_Limpa_DW_Destino()

lvi_rcRowsCopy = idw_Origem.RowsCopy(1, idw_Origem.RowCount(), Primary!, idw_Destino, 1, Primary!)

If lvi_rcRowsCopy = 1 Then
	of_Habilita()
	Return 1
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro durante a c$$HEX1$$f300$$ENDHEX$$pia das linhas.", Information!, Ok!)
	Return -1
End If
end event

event ue_permite_deselecionar;Return True
end event

event ue_permite_selecionar;Integer lvi_Find
	
If IsNull(ivs_Find) or Trim(ivs_Find) = "" Then Return True
	
lvi_Find = idw_Destino.Find(ivs_Find, 0, idw_Destino.RowCount())
	
If lvi_Find > 0 Then
	Return False
End If

Return True
end event

public subroutine of_habilita ();If idw_Origem.RowCount() > 0 Then
	If ivb_Habilitado Then
		cb_Seleciona_Um.Enabled = True
		cb_Seleciona_Todos.Enabled = True
	Else
		cb_Seleciona_Um.Enabled = False
		cb_Seleciona_Todos.Enabled = False
	End If
Else
	cb_Seleciona_Um.Enabled = False
	cb_Seleciona_Todos.Enabled = False
End If

If idw_Destino.RowCount() > 0 Then
	If ivb_Habilitado Then
		cb_DeSeleciona_Um.Enabled = True
		cb_DeSeleciona_Todos.Enabled = True
	Else
		cb_DeSeleciona_Um.Enabled = False
		cb_DeSeleciona_Todos.Enabled = False
	End If
Else
	cb_DeSeleciona_Um.Enabled = False
	cb_DeSeleciona_Todos.Enabled = False
End If
end subroutine

public subroutine of_limpa_dw_destino ();Integer lvi_Linhas, &
        lvi_Linha

lvi_Linhas = idw_Destino.RowCount()

For lvi_Linha = 1 To lvi_Linhas
	idw_Destino.DeleteRow(1)
Next
end subroutine

public subroutine of_habilita_controle (boolean pb_habilita);ivb_Habilitado = pb_Habilita

of_Habilita()
end subroutine

on dc_uo_barra_selecao_vertical.create
this.cb_seleciona_um=create cb_seleciona_um
this.cb_seleciona_todos=create cb_seleciona_todos
this.cb_deseleciona_todos=create cb_deseleciona_todos
this.cb_deseleciona_um=create cb_deseleciona_um
this.Control[]={this.cb_seleciona_um,&
this.cb_seleciona_todos,&
this.cb_deseleciona_todos,&
this.cb_deseleciona_um}
end on

on dc_uo_barra_selecao_vertical.destroy
destroy(this.cb_seleciona_um)
destroy(this.cb_seleciona_todos)
destroy(this.cb_deseleciona_todos)
destroy(this.cb_deseleciona_um)
end on

type cb_seleciona_um from commandbutton within dc_uo_barra_selecao_vertical
integer x = 14
integer y = 300
integer width = 114
integer height = 80
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = ">"
end type

event clicked;Parent.Event seleciona_um()
end event

type cb_seleciona_todos from commandbutton within dc_uo_barra_selecao_vertical
integer x = 14
integer y = 208
integer width = 114
integer height = 80
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = ">>"
end type

event clicked;Parent.Event seleciona_todos()
end event

type cb_deseleciona_todos from commandbutton within dc_uo_barra_selecao_vertical
integer x = 14
integer y = 104
integer width = 114
integer height = 80
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "<<"
end type

event clicked;Parent.Event deseleciona_todos()
end event

type cb_deseleciona_um from commandbutton within dc_uo_barra_selecao_vertical
integer x = 14
integer y = 12
integer width = 114
integer height = 80
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "<"
end type

event clicked;Parent.Event deseleciona_um()
end event

