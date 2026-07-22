HA$PBExportHeader$w_2dw_selecao_grafico.srw
forward
global type w_2dw_selecao_grafico from w_sheet
end type
type dw_grafico from u_dw within w_2dw_selecao_grafico
end type
type dw_1 from u_dw within w_2dw_selecao_grafico
end type
end forward

global type w_2dw_selecao_grafico from w_sheet
int X=0
int Y=0
int Width=1829
int Height=616
dw_grafico dw_grafico
dw_1 dw_1
end type
global w_2dw_selecao_grafico w_2dw_selecao_grafico

on w_2dw_selecao_grafico.create
int iCurrent
call super::create
this.dw_grafico=create dw_grafico
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_grafico
this.Control[iCurrent+2]=this.dw_1
end on

on w_2dw_selecao_grafico.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_grafico)
destroy(this.dw_1)
end on

event pfc_postopen;call super::pfc_postopen;This.Width = dw_1.Width + 45
This.Height = dw_1.Height + 110

dw_1.Event pfc_AddRow()
end event

event pfc_print;SetPointer(HourGlass!)

dw_grafico.SetRedraw(False)

// Coloca vis$$HEX1$$ed00$$ENDHEX$$vel os campos de data e logotipo
dw_grafico.Modify("data_corrente_relatorio.Visible=1")
dw_grafico.Modify("logotipo_relatorio.Visible=1")

// Coloca a dw no modo de PrintPreview
dw_grafico.Modify("DataWindow.Print.Preview=Yes")

dw_grafico.Event pfc_print()

dw_grafico.Modify("DataWindow.Print.Preview=No")

// Volta a invis$$HEX1$$ed00$$ENDHEX$$vel os campos de data e logotipo
dw_grafico.Modify("data_corrente_relatorio.Visible=0")
dw_grafico.Modify("logotipo_relatorio.Visible=0")

dw_grafico.SetRedraw(True)

Return 0

end event

event pfc_printimmediate;SetPointer(HourGlass!)

dw_grafico.SetRedraw(False)

// Coloca vis$$HEX1$$ed00$$ENDHEX$$vel os campos de data e logotipo
dw_grafico.Modify("data_corrente_relatorio.Visible=1")
dw_grafico.Modify("logotipo_relatorio.Visible=1")

// Coloca a dw no modo de PrintPreview
dw_grafico.Modify("DataWindow.Print.Preview=Yes")

dw_grafico.Event pfc_printimmediate()

dw_grafico.Modify("DataWindow.Print.Preview=No")

// Volta a invis$$HEX1$$ed00$$ENDHEX$$vel os campos de data e logotipo
dw_grafico.Modify("data_corrente_relatorio.Visible=0")
dw_grafico.Modify("logotipo_relatorio.Visible=0")

dw_grafico.SetRedraw(True)

Return 0
end event

type dw_grafico from u_dw within w_2dw_selecao_grafico
int X=9
int Y=220
int Width=3561
int Height=1484
int TabOrder=10
boolean BringToTop=true
boolean Border=false
BorderStyle BorderStyle=StyleBox!
boolean VScrollBar=false
end type

event constructor;call super::constructor;ib_isupdateable = False
end event

event pfc_printimmediate;Return Parent.Event pfc_printimmediate()
end event

event pfc_print;Return Parent.Event pfc_print()
end event

type dw_1 from u_dw within w_2dw_selecao_grafico
int X=9
int Y=28
int Width=1751
int Height=132
int TabOrder=10
boolean BringToTop=true
boolean Border=false
BorderStyle BorderStyle=StyleBox!
boolean VScrollBar=false
end type

event constructor;call super::constructor;ib_isupdateable = False
end event

event pfc_retrieve;call super::pfc_retrieve;Return dw_grafico.Event pfc_retrieve()
end event

event itemchanged;call super::itemchanged;If dw_grafico.RowCount() > 0 Then
	ivm_menu_janela.m_arquivo.m_imprimir.Enabled = False
	ivm_menu_janela.m_arquivo.m_imprimirimediato.Enabled = False
	Parent.Width = This.Width + 45
	Parent.Height = This.Height + 110
	dw_grafico.Reset()
End If
end event

event pfc_print;Return Parent.Event pfc_print()
end event

event pfc_printimmediate;Return Parent.Event pfc_printimmediate()
end event

event editchanged;call super::editchanged;If dw_grafico.RowCount() > 0 Then
	ivm_menu_janela.m_arquivo.m_imprimir.Enabled = False
	ivm_menu_janela.m_arquivo.m_imprimirimediato.Enabled = False
	Parent.Width = This.Width + 45
	Parent.Height = This.Height + 110
	dw_grafico.Reset()
End If
end event

