HA$PBExportHeader$w_lista_barra_selecao_horizontal.srw
forward
global type w_lista_barra_selecao_horizontal from w_sheet
end type
type dw_1 from u_dw within w_lista_barra_selecao_horizontal
end type
type dw_2 from u_dw within w_lista_barra_selecao_horizontal
end type
type dw_3 from u_dw within w_lista_barra_selecao_horizontal
end type
type uo_barra_selecao from uo_barra_selecao_horizontal within w_lista_barra_selecao_horizontal
end type
type gb_3 from groupbox within w_lista_barra_selecao_horizontal
end type
type gb_2 from groupbox within w_lista_barra_selecao_horizontal
end type
type gb_1 from groupbox within w_lista_barra_selecao_horizontal
end type
end forward

global type w_lista_barra_selecao_horizontal from w_sheet
int Width=1175
int Height=1148
dw_1 dw_1
dw_2 dw_2
dw_3 dw_3
uo_barra_selecao uo_barra_selecao
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
end type
global w_lista_barra_selecao_horizontal w_lista_barra_selecao_horizontal

on w_lista_barra_selecao_horizontal.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.dw_2=create dw_2
this.dw_3=create dw_3
this.uo_barra_selecao=create uo_barra_selecao
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.dw_3
this.Control[iCurrent+4]=this.uo_barra_selecao
this.Control[iCurrent+5]=this.gb_3
this.Control[iCurrent+6]=this.gb_2
this.Control[iCurrent+7]=this.gb_1
end on

on w_lista_barra_selecao_horizontal.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.uo_barra_selecao)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
end on

type dw_1 from u_dw within w_lista_barra_selecao_horizontal
int X=69
int Y=84
int TabOrder=10
boolean BringToTop=true
end type

event pfc_retrieve;call super::pfc_retrieve;SetPointer(HourGlass!)

Long lvl_linha

// Chama o evento recuperar da DW

lvl_linha = This.Event Recuperar()

Return lvl_linha
end event

type dw_2 from u_dw within w_lista_barra_selecao_horizontal
int X=87
int Y=652
int Height=252
int TabOrder=60
boolean BringToTop=true
end type

event pfc_retrieve;call super::pfc_retrieve;SetPointer(HourGlass!)

Long lvl_linha

// Chama o evento recuperar da DW

lvl_linha = This.Event Recuperar()

// Chama a fun$$HEX2$$e700e300$$ENDHEX$$o de habilita$$HEX2$$e700e300$$ENDHEX$$o dos bot$$HEX1$$f500$$ENDHEX$$es de sele$$HEX2$$e700e300$$ENDHEX$$o

uo_barra_selecao.of_Habilita()

Return lvl_linha
end event

type dw_3 from u_dw within w_lista_barra_selecao_horizontal
int X=645
int Y=664
int TabOrder=30
boolean BringToTop=true
end type

event pfc_retrieve;call super::pfc_retrieve;SetPointer(HourGlass!)

Long lvl_linha

// Chama o evento recuperar da DW

lvl_linha = This.Event Recuperar()

// Chama a fun$$HEX2$$e700e300$$ENDHEX$$o de habilita$$HEX2$$e700e300$$ENDHEX$$o dos bot$$HEX1$$f500$$ENDHEX$$es de sele$$HEX2$$e700e300$$ENDHEX$$o

uo_barra_selecao.of_Habilita()

Return lvl_linha
end event

type uo_barra_selecao from uo_barra_selecao_horizontal within w_lista_barra_selecao_horizontal
int X=562
int Y=444
int TabOrder=40
boolean BringToTop=true
boolean Border=false
BorderStyle BorderStyle=StyleBox!
long BackColor=79741120
end type

event constructor;SetPointer(HourGlass!)

idw_origem = dw_2
idw_destino = dw_3
end event

on uo_barra_selecao.destroy
call uo_barra_selecao_horizontal::destroy
end on

event deseleciona_todos;call super::deseleciona_todos;If AncestorReturnValue > 0 Then
	// Se for uma DW atualiz$$HEX1$$e100$$ENDHEX$$vel, habilita a valida$$HEX2$$e700e300$$ENDHEX$$o do closequery da janela
	If idw_destino.of_GetUpdateable() Then
		Parent.Post Event Valida_CloseQuery(True)
	End If
End If

Return AncestorReturnValue
end event

event deseleciona_um;call super::deseleciona_um;If AncestorReturnValue > 0 Then
	// Se for uma DW atualiz$$HEX1$$e100$$ENDHEX$$vel, habilita a valida$$HEX2$$e700e300$$ENDHEX$$o do closequery da janela
	If idw_destino.of_GetUpdateable() Then
		Parent.Post Event Valida_CloseQuery(True)
	End If
End If

Return AncestorReturnValue
end event

type gb_3 from groupbox within w_lista_barra_selecao_horizontal
int X=567
int Y=588
int Width=494
int Height=360
int TabOrder=50
string Text="Selecionadas"
BorderStyle BorderStyle=StyleRaised!
long TextColor=8388608
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_2 from groupbox within w_lista_barra_selecao_horizontal
int X=41
int Y=588
int Width=494
int Height=360
int TabOrder=50
string Text="Dispon$$HEX1$$ed00$$ENDHEX$$veis"
BorderStyle BorderStyle=StyleRaised!
long TextColor=8388608
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within w_lista_barra_selecao_horizontal
int X=41
int Y=20
int Width=494
int Height=360
int TabOrder=20
string Text="Lista"
BorderStyle BorderStyle=StyleRaised!
long TextColor=8388608
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

