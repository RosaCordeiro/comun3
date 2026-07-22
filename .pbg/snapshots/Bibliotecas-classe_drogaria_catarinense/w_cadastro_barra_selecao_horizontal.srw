HA$PBExportHeader$w_cadastro_barra_selecao_horizontal.srw
forward
global type w_cadastro_barra_selecao_horizontal from w_sheet
end type
type gb_3 from groupbox within w_cadastro_barra_selecao_horizontal
end type
type gb_2 from groupbox within w_cadastro_barra_selecao_horizontal
end type
type gb_1 from groupbox within w_cadastro_barra_selecao_horizontal
end type
type dw_1 from u_dw within w_cadastro_barra_selecao_horizontal
end type
type dw_2 from u_dw within w_cadastro_barra_selecao_horizontal
end type
type dw_3 from u_dw within w_cadastro_barra_selecao_horizontal
end type
type uo_barra_selecao from uo_barra_selecao_horizontal within w_cadastro_barra_selecao_horizontal
end type
end forward

global type w_cadastro_barra_selecao_horizontal from w_sheet
int Width=2688
int Height=1760
boolean TitleBar=true
string Title="Cadastro de Dependentes de Clientes de Clubes"
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
dw_1 dw_1
dw_2 dw_2
dw_3 dw_3
uo_barra_selecao uo_barra_selecao
end type
global w_cadastro_barra_selecao_horizontal w_cadastro_barra_selecao_horizontal

type variables

end variables

on w_cadastro_barra_selecao_horizontal.create
int iCurrent
call super::create
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.dw_1=create dw_1
this.dw_2=create dw_2
this.dw_3=create dw_3
this.uo_barra_selecao=create uo_barra_selecao
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_3
this.Control[iCurrent+2]=this.gb_2
this.Control[iCurrent+3]=this.gb_1
this.Control[iCurrent+4]=this.dw_1
this.Control[iCurrent+5]=this.dw_2
this.Control[iCurrent+6]=this.dw_3
this.Control[iCurrent+7]=this.uo_barra_selecao
end on

on w_cadastro_barra_selecao_horizontal.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.uo_barra_selecao)
end on

event pfc_postopen;call super::pfc_postopen;dw_1.Event pfc_AddRow()
end event

type gb_3 from groupbox within w_cadastro_barra_selecao_horizontal
int X=27
int Y=956
int Width=2597
int Height=600
int TabOrder=50
string Text="Dependentes Autorizados"
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

type gb_2 from groupbox within w_cadastro_barra_selecao_horizontal
int X=27
int Y=264
int Width=2597
int Height=600
int TabOrder=10
string Text="Dependentes do Cliente"
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

type gb_1 from groupbox within w_cadastro_barra_selecao_horizontal
int X=27
int Y=8
int Width=1778
int Height=252
int TabOrder=60
string Text="Par$$HEX1$$e200$$ENDHEX$$metros de Sele$$HEX2$$e700e300$$ENDHEX$$o"
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

type dw_1 from u_dw within w_cadastro_barra_selecao_horizontal
int X=50
int Y=72
int Width=1733
int Height=168
int TabOrder=20
boolean BringToTop=true
boolean Border=false
BorderStyle BorderStyle=StyleBox!
boolean VScrollBar=false
end type

event constructor;call super::constructor;of_SetRowSelect(False)
ib_IsUpdateAble = False
end event

event pfc_retrieve;call super::pfc_retrieve;dw_2.Event pfc_Retrieve()
dw_3.Event pfc_Retrieve()

Return 1
end event

type dw_2 from u_dw within w_cadastro_barra_selecao_horizontal
int X=55
int Y=316
int Width=2537
int Height=528
int TabOrder=30
boolean BringToTop=true
boolean Border=false
BorderStyle BorderStyle=StyleBox!
end type

event constructor;call super::constructor;of_SetRowSelect(True)
ib_IsUpdateAble = False
end event

event pfc_retrieve;call super::pfc_retrieve;Boolean lvb_Habilita

Long lvl_Linhas

SetPointer(HourGlass!)

lvl_Linhas = This.Event Recuperar()

If lvl_Linhas > 0 Then
	lvb_Habilita = True
Else
	lvb_Habilita = False
End If

ivm_Menu_Janela.m_Editar.m_Classificar.Enabled = lvb_Habilita
ivm_Menu_Janela.m_Editar.m_Filtrar.Enabled = lvb_Habilita
ivm_Menu_Janela.m_Editar.m_Localizar.Enabled = lvb_Habilita

// Habilita os bot$$HEX1$$f500$$ENDHEX$$es da barra de sele$$HEX2$$e700e300$$ENDHEX$$o
uo_Barra_Selecao.of_Habilita()

Return lvl_Linhas
end event

type dw_3 from u_dw within w_cadastro_barra_selecao_horizontal
int X=55
int Y=1008
int Width=2537
int Height=528
int TabOrder=40
boolean BringToTop=true
boolean Border=false
BorderStyle BorderStyle=StyleBox!
end type

event constructor;call super::constructor;of_SetRowSelect(True)
ib_IsUpdateAble = True
end event

event pfc_retrieve;call super::pfc_retrieve;Boolean lvb_Habilita

Long lvl_Linhas

SetPointer(HourGlass!)

lvl_Linhas = This.Event Recuperar()

If lvl_Linhas > 0 Then
	lvb_Habilita = True
Else
	lvb_Habilita = False
End If

ivm_Menu_Janela.m_Editar.m_Classificar.Enabled = lvb_Habilita
ivm_Menu_Janela.m_Editar.m_Filtrar.Enabled = lvb_Habilita
ivm_Menu_Janela.m_Editar.m_Localizar.Enabled = lvb_Habilita

// Habilita os bot$$HEX1$$f500$$ENDHEX$$es da barra de sele$$HEX2$$e700e300$$ENDHEX$$o
uo_Barra_Selecao.of_Habilita()

Return lvl_Linhas
end event

type uo_barra_selecao from uo_barra_selecao_horizontal within w_cadastro_barra_selecao_horizontal
int X=2080
int Y=876
int Height=92
int TabOrder=40
boolean BringToTop=true
boolean Border=false
BorderStyle BorderStyle=StyleBox!
long BackColor=79741120
end type

event constructor;idw_Origem = dw_2
idw_Destino = dw_3
end event

on uo_barra_selecao.destroy
call uo_barra_selecao_horizontal::destroy
end on

event deseleciona_um;call super::deseleciona_um;If AncestorReturnValue > 0 Then
	// Se for uma DW atualiz$$HEX1$$e100$$ENDHEX$$vel, habilita a valida$$HEX2$$e700e300$$ENDHEX$$o do closequery da janela
	If idw_destino.of_GetUpdateable() Then
		Parent.Post Event Valida_CloseQuery(True)
	End If
End If

Return AncestorReturnValue
end event

event deseleciona_todos;call super::deseleciona_todos;If AncestorReturnValue > 0 Then
	// Se for uma DW atualiz$$HEX1$$e100$$ENDHEX$$vel, habilita a valida$$HEX2$$e700e300$$ENDHEX$$o do closequery da janela
	If idw_destino.of_GetUpdateable() Then
		Parent.Post Event Valida_CloseQuery(True)
	End If
End If

Return AncestorReturnValue
end event

