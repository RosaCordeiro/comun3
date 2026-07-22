HA$PBExportHeader$w_cadastro_barra_selecao_vertical.srw
forward
global type w_cadastro_barra_selecao_vertical from w_lista_barra_selecao_vertical
end type
type dw_4 from u_dw within w_cadastro_barra_selecao_vertical
end type
end forward

global type w_cadastro_barra_selecao_vertical from w_lista_barra_selecao_vertical
int Width=3589
int Height=1916
dw_4 dw_4
end type
global w_cadastro_barra_selecao_vertical w_cadastro_barra_selecao_vertical

on w_cadastro_barra_selecao_vertical.create
int iCurrent
call super::create
this.dw_4=create dw_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_4
end on

on w_cadastro_barra_selecao_vertical.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_4)
end on

event pfc_postopen;call super::pfc_postopen;// Coloca o foco na DW de lista

dw_2.SetRow(1)
dw_2.SetFocus()
end event

event cancelar;SetPointer(HourGlass!)

// Chama o evento de cancelamento da DW

dw_2.Event Cancelar()
dw_4.Event Cancelar()
end event

type dw_1 from w_lista_barra_selecao_vertical`dw_1 within w_cadastro_barra_selecao_vertical
int X=23
int Y=64
int Width=1669
int Height=520
boolean BringToTop=true
boolean Border=false
BorderStyle BorderStyle=StyleBox!
end type

event dw_1::getfocus;call super::getfocus;// Desabilita os menus de inclus$$HEX1$$e300$$ENDHEX$$o e exclus$$HEX1$$e300$$ENDHEX$$o

ivm_menu_janela.m_editar.m_incluir.Enabled = False
ivm_menu_janela.m_editar.m_excluir.Enabled = False

end event

event dw_1::rowfocuschanged;call super::rowfocuschanged;SetPointer(HourGlass!)

// Dispara o evento de recupera$$HEX2$$e700e300$$ENDHEX$$o da DW de atualiza$$HEX2$$e700e300$$ENDHEX$$o

dw_4.Event pfc_Retrieve()
end event

type dw_2 from w_lista_barra_selecao_vertical`dw_2 within w_cadastro_barra_selecao_vertical
int X=23
int Y=692
int Width=1504
int Height=1020
int TabOrder=70
boolean BringToTop=true
boolean Border=false
BorderStyle BorderStyle=StyleBox!
end type

event dw_2::recuperar;SetPointer(HourGlass!)

// Recupera as informa$$HEX2$$e700f500$$ENDHEX$$es da DW

Return This.Retrieve()
end event

event dw_2::getfocus;call super::getfocus;// Habilita os menus de inclus$$HEX1$$e300$$ENDHEX$$o e exclus$$HEX1$$e300$$ENDHEX$$o

ivm_menu_janela.m_editar.m_incluir.Enabled = True
ivm_menu_janela.m_editar.m_excluir.Enabled = True

end event

event dw_2::constructor;call super::constructor;SetPointer(HourGlass!)

// Marca a DW como n$$HEX1$$e300$$ENDHEX$$o atualiz$$HEX1$$e100$$ENDHEX$$vel

ib_isupdateable = True
end event

event dw_2::itemchanged;call super::itemchanged;// Habilita os menus de confirma$$HEX2$$e700e300$$ENDHEX$$o e cancelamento

ivm_menu_janela.m_editar.m_confirmaroperacao.Enabled = True
ivm_menu_janela.m_editar.m_cancelaroperacao.Enabled = True
end event

event dw_2::editchanged;call super::editchanged;// Habilita os menus de confirma$$HEX2$$e700e300$$ENDHEX$$o e cancelamento

ivm_menu_janela.m_editar.m_confirmaroperacao.Enabled = True
ivm_menu_janela.m_editar.m_cancelaroperacao.Enabled = True

end event

type dw_3 from w_lista_barra_selecao_vertical`dw_3 within w_cadastro_barra_selecao_vertical
int X=1778
int Y=72
int Width=1746
int Height=1632
int TabOrder=40
boolean BringToTop=true
boolean Border=false
BorderStyle BorderStyle=StyleBox!
end type

event dw_3::getfocus;call super::getfocus;// Desabilita os menus de inclus$$HEX1$$e300$$ENDHEX$$o e exclus$$HEX1$$e300$$ENDHEX$$o

ivm_menu_janela.m_editar.m_incluir.Enabled = False
ivm_menu_janela.m_editar.m_excluir.Enabled = False

end event

event dw_3::constructor;call super::constructor;SetPointer(HourGlass!)

// Marca a DW como n$$HEX1$$e300$$ENDHEX$$o atualiz$$HEX1$$e100$$ENDHEX$$vel

ib_isupdateable = False


end event

event dw_3::editchanged;call super::editchanged;// Habilita os menus de confirma$$HEX2$$e700e300$$ENDHEX$$o e cancelamento

ivm_menu_janela.m_editar.m_confirmaroperacao.Enabled = True
ivm_menu_janela.m_editar.m_cancelaroperacao.Enabled = True
end event

event dw_3::itemchanged;call super::itemchanged;// Habilita os menus de confirma$$HEX2$$e700e300$$ENDHEX$$o e cancelamento

ivm_menu_janela.m_editar.m_confirmaroperacao.Enabled = True
ivm_menu_janela.m_editar.m_cancelaroperacao.Enabled = True
end event

type gb_3 from w_lista_barra_selecao_vertical`gb_3 within w_cadastro_barra_selecao_vertical
int X=1746
int Y=8
int Width=1810
int Height=1724
int TabOrder=50
string Text="Detalhe"
end type

type gb_2 from w_lista_barra_selecao_vertical`gb_2 within w_cadastro_barra_selecao_vertical
int X=0
int Y=624
int Width=1568
int Height=1108
int TabOrder=60
string Text="Lista"
end type

type gb_1 from w_lista_barra_selecao_vertical`gb_1 within w_cadastro_barra_selecao_vertical
int X=5
int Y=8
int Width=1723
int Height=604
int TabOrder=30
string Text="Sele$$HEX2$$e700e300$$ENDHEX$$o"
end type

type uo_barra_selecao from w_lista_barra_selecao_vertical`uo_barra_selecao within w_cadastro_barra_selecao_vertical
int X=1586
int Y=1000
int TabOrder=90
boolean BringToTop=true
end type

event uo_barra_selecao::deseleciona_todos;call super::deseleciona_todos;SetPointer(HourGlass!)

Long lvl_linha, lvl_contador

If AncestorReturnValue = -1 Then
	Return AncestorReturnValue
End If

// Deleta todas as linhas da DW de atualiza$$HEX2$$e700e300$$ENDHEX$$o

lvl_linha = dw_4.RowCount()
FOR lvl_contador = 1 TO lvl_linha
	dw_4.DeleteRow(1)
NEXT

// Se for uma DW atualiz$$HEX1$$e100$$ENDHEX$$vel, habilita a valida$$HEX2$$e700e300$$ENDHEX$$o do closequery da janela
If idw_destino.of_GetUpdateable() Then
	Parent.Post Event Valida_CloseQuery(True)
End If

Return 1
end event

event uo_barra_selecao::deseleciona_um;call super::deseleciona_um;If AncestorReturnValue > 0 Then
	// Se for uma DW atualiz$$HEX1$$e100$$ENDHEX$$vel, habilita a valida$$HEX2$$e700e300$$ENDHEX$$o do closequery da janela
	If idw_destino.of_GetUpdateable() Then
		Parent.Post Event Valida_CloseQuery(True)
	End If
End If

Return AncestorReturnValue
end event

type dw_4 from u_dw within w_cadastro_barra_selecao_vertical
int X=1865
int Y=916
int Width=1522
int Height=504
int TabOrder=20
boolean BringToTop=true
BorderStyle BorderStyle=StyleBox!
end type

event pfc_retrieve;call super::pfc_retrieve;Return This.Event Recuperar()
end event

event retrieveend;call super::retrieveend;SetPointer(HourGlass!)

Long lvl_linha, lvl_linha_dw3, lvl_socio, lvl_acoes_total
String lvs_expressao

// Recupera o n$$HEX1$$fa00$$ENDHEX$$mero total de a$$HEX2$$e700f500$$ENDHEX$$es

lvl_linha = dw_1.GetRow()
lvl_acoes_total = dw_1.Object.qt_acoes_sociedade[lvl_linha]

// Monta a quantidade de a$$HEX2$$e700f500$$ENDHEX$$es e o percentual de cada s$$HEX1$$f300$$ENDHEX$$cio

FOR lvl_linha = 1 TO This.RowCount()
	lvl_socio = This.Object.cd_socio[lvl_linha]
	lvs_expressao = "cd_socio=" + String(lvl_socio)
	lvl_linha_dw3 = dw_3.Find(lvs_expressao, 1, dw_3.RowCount())
	dw_3.Object.acoes[lvl_linha_dw3] = This.Object.qt_acoes[lvl_linha]
	dw_3.Object.acoes_total[lvl_linha_dw3] = lvl_acoes_total
NEXT

end event

event constructor;call super::constructor;// Estabelece o tipo de a$$HEX2$$e700e300$$ENDHEX$$o no cancelamento
ivi_Tipo_Cancelar = RETRIEVE


end event

