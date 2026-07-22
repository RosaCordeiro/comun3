HA$PBExportHeader$dc_uo_barra_selecao_horizontal.sru
forward
global type dc_uo_barra_selecao_horizontal from UserObject
end type
type cb_seleciona_um from commandbutton within dc_uo_barra_selecao_horizontal
end type
type cb_seleciona_todos from commandbutton within dc_uo_barra_selecao_horizontal
end type
type cb_deseleciona_todos from commandbutton within dc_uo_barra_selecao_horizontal
end type
type cb_deseleciona_um from commandbutton within dc_uo_barra_selecao_horizontal
end type
end forward

global type dc_uo_barra_selecao_horizontal from UserObject
int Width=562
int Height=112
boolean Border=true
long BackColor=67108864
long PictureMaskColor=536870912
long TabTextColor=33554432
long TabBackColor=67108864
event type long deseleciona_um ( )
event type integer deseleciona_todos ( )
event type integer seleciona_todos ( )
event type long seleciona_um ( )
cb_seleciona_um cb_seleciona_um
cb_seleciona_todos cb_seleciona_todos
cb_deseleciona_todos cb_deseleciona_todos
cb_deseleciona_um cb_deseleciona_um
end type
global dc_uo_barra_selecao_horizontal dc_uo_barra_selecao_horizontal

type variables
dc_uo_dw_base idw_Origem, idw_Destino

String ivs_find
end variables

forward prototypes
public subroutine of_habilita ()
public subroutine of_limpa_dw_destino ()
end prototypes

event deseleciona_um;SetPointer(HourGlass!)

Integer lvi_Linha_Ativa

// verifica se h$$HEX1$$e100$$ENDHEX$$ alguma linha selecionada. Sen$$HEX1$$e300$$ENDHEX$$o, mensagem de erro. Se sim, deleta a linha
// ativa da DW de destino e chama a fun$$HEX2$$e700e300$$ENDHEX$$o de habilita$$HEX2$$e700e300$$ENDHEX$$o dos bot$$HEX1$$f500$$ENDHEX$$es de controle

lvi_Linha_Ativa = idw_Destino.GetRow()

If lvi_Linha_Ativa > 0 Then
	idw_Destino.DeleteRow(lvi_Linha_Ativa)
	of_Habilita()
	Return lvi_Linha_Ativa
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma linha.", Information!, Ok!)
	Return -1
End If
end event

event deseleciona_todos;SetPointer(HourGlass!)

// Limpa a DW de destino e chama a fun$$HEX2$$e700e300$$ENDHEX$$o de habilita$$HEX2$$e700e300$$ENDHEX$$o dos bot$$HEX1$$f500$$ENDHEX$$es de controle

of_Limpa_DW_Destino()

of_Habilita()

Return 1
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

event seleciona_um;SetPointer(HourGlass!)

String lvs_Filtro

Integer lvi_Linha_Ativa, &
        lvi_Linha_Destino, &
		  lvi_Linha_Achou, &
		  lvi_rcRowsCopy

// Encontra a linha de origem

idw_Origem.AcceptText()
lvi_Linha_Ativa = idw_Origem.GetRow()

// Sen$$HEX1$$e300$$ENDHEX$$o existir linha selecionada, mensagem de erro. Se sim, insere linha na DW de destino,
// copia a linha e chama a fun$$HEX2$$e700e300$$ENDHEX$$o de habilita$$HEX2$$e700e300$$ENDHEX$$o dos bot$$HEX1$$f500$$ENDHEX$$es de controle

If lvi_Linha_Ativa > 0 Then
	lvi_Linha_Destino = idw_Destino.RowCount() + 1
	lvi_Linha_Achou = idw_Destino.Find(ivs_find, 0, idw_Destino.RowCount())
   If lvi_Linha_Achou = 0 Then
		lvi_rcRowsCopy = idw_Origem.RowsCopy(lvi_Linha_Ativa, lvi_Linha_Ativa, Primary!, idw_Destino, lvi_Linha_destino, Primary!)
		If lvi_rcRowsCopy = 1 Then
			of_Habilita()
			Return lvi_Linha_Destino
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro durante a c$$HEX1$$f300$$ENDHEX$$pia da linha.", Information!, Ok!)
			Return -1
		End If
	Else
		Return 0
	End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma linha.", Information!, Ok!)
	Return -1
End If
end event

public subroutine of_habilita ();If idw_Origem.RowCount() > 0 Then
	cb_Seleciona_Um.Enabled = True
	cb_Seleciona_Todos.Enabled = True
Else
	cb_Seleciona_Um.Enabled = False
	cb_Seleciona_Todos.Enabled = False
End If

If idw_Destino.RowCount() > 0 Then
	cb_DeSeleciona_Um.Enabled = True
	cb_DeSeleciona_Todos.Enabled = True
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

on dc_uo_barra_selecao_horizontal.create
this.cb_seleciona_um=create cb_seleciona_um
this.cb_seleciona_todos=create cb_seleciona_todos
this.cb_deseleciona_todos=create cb_deseleciona_todos
this.cb_deseleciona_um=create cb_deseleciona_um
this.Control[]={this.cb_seleciona_um,&
this.cb_seleciona_todos,&
this.cb_deseleciona_todos,&
this.cb_deseleciona_um}
end on

on dc_uo_barra_selecao_horizontal.destroy
destroy(this.cb_seleciona_um)
destroy(this.cb_seleciona_todos)
destroy(this.cb_deseleciona_todos)
destroy(this.cb_deseleciona_um)
end on

type cb_seleciona_um from commandbutton within dc_uo_barra_selecao_horizontal
int X=425
int Y=8
int Width=114
int Height=80
int TabOrder=40
boolean Enabled=false
boolean BringToTop=true
string Text=">"
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//String lvs_Filtro
//
//Integer lvi_Linha_Ativa, lvi_Linha_Destino, lvi_Linha_Achou
//
//lvi_Linha_Ativa = idw_Origem.GetRow()
//lvi_Linha_Destino = idw_Destino.RowCount() + 1
//
//If lvi_Linha_Ativa > 0 Then
//	lvi_Linha_Achou = idw_Destino.Find(ivs_find, 0, idw_Destino.RowCount())
//   If lvi_Linha_Achou = 0 Then
//		idw_Origem.RowsCopy(lvi_Linha_Ativa, lvi_Linha_Ativa, Primary!, idw_Destino, lvi_Linha_destino, Primary!)
//		of_Habilita()
//	End If
//Else
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma linha.", Information!, Ok!)
//End If

Parent.Event seleciona_um()
end event

type cb_seleciona_todos from commandbutton within dc_uo_barra_selecao_horizontal
int X=293
int Y=8
int Width=114
int Height=80
int TabOrder=30
boolean Enabled=false
boolean BringToTop=true
string Text=">>"
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//// Copia todas as linhas da DW
//idw_Destino.Reset()
//idw_Origem.RowsCopy(1, idw_Origem.RowCount(), Primary!, idw_Destino, 1, Primary!)
//
//of_Habilita()

Parent.Event seleciona_todos()
end event

type cb_deseleciona_todos from commandbutton within dc_uo_barra_selecao_horizontal
int X=142
int Y=8
int Width=114
int Height=80
int TabOrder=20
boolean Enabled=false
boolean BringToTop=true
string Text="<<"
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//idw_Destino.Reset()
//
//of_Habilita()

Parent.Event deseleciona_todos()
end event

type cb_deseleciona_um from commandbutton within dc_uo_barra_selecao_horizontal
int X=9
int Y=8
int Width=114
int Height=80
int TabOrder=10
boolean Enabled=false
boolean BringToTop=true
string Text="<"
int TextSize=-8
int Weight=700
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;//Integer lvi_Linha_Ativa
//
//lvi_Linha_Ativa = idw_Destino.GetRow()
//
//If lvi_Linha_Ativa > 0 Then
//	idw_Destino.DeleteRow(lvi_Linha_Ativa)
//	of_Habilita()
//Else
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma linha.", Information!, Ok!)
//End If

Parent.Event deseleciona_um()
end event

