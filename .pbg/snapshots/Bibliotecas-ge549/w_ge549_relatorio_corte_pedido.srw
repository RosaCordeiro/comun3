HA$PBExportHeader$w_ge549_relatorio_corte_pedido.srw
forward
global type w_ge549_relatorio_corte_pedido from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge549_relatorio_corte_pedido from dc_w_selecao_lista_relatorio
string tag = "w_ge549_relatorio_corte_pedido"
integer width = 2578
integer height = 1184
string title = "GE549 - Relat$$HEX1$$f300$$ENDHEX$$rio Corte de Pedido"
end type
global w_ge549_relatorio_corte_pedido w_ge549_relatorio_corte_pedido

on w_ge549_relatorio_corte_pedido.create
call super::create
end on

on w_ge549_relatorio_corte_pedido.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;dw_1.Object.dt_Inicio			[1] =  RelativeDate(Date(gvo_Parametro.of_Dh_Movimentacao()), -7)
dw_1.Object.dt_Termino		[1] = Today()
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge549_relatorio_corte_pedido
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge549_relatorio_corte_pedido
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge549_relatorio_corte_pedido
integer y = 216
integer width = 2473
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge549_relatorio_corte_pedido
integer width = 1065
integer height = 176
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge549_relatorio_corte_pedido
integer x = 64
integer width = 1019
integer height = 84
string dataobject = "dw_ge549_selecao"
end type

event dw_1::editchanged;call super::editchanged;dw_2.Reset()
end event

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge549_relatorio_corte_pedido
integer y = 292
integer width = 2405
string dataobject = "dw_ge549_lista"
end type

event dw_2::constructor;call super::constructor;This.of_SetRowSelection()
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;dw_2.ivm_menu.mf_salvarcomo(This.RowCount()>0)
ivm_menu.mf_salvarcomo(True)
This.ivm_Menu.mf_Incluir(False)
This.ivm_Menu.mf_Excluir(False)

Return 1

end event

event dw_2::ue_recuperar;//OverRide

Date ldt_Inicio ,&
	   ldt_Termino
	
dw_1.Accepttext()	
	
ldt_Inicio 	= dw_1.object.dt_inicio		[1] 
ldt_Termino = dw_1.object.dt_termino	[1]

If IsNull(ldt_Inicio) or Not IsDate(String(ldt_Inicio)) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio corretamente.", Information!)
	dw_1.Event ue_Pos(1, "dt_inicio")
	Return -1
End If

dw_1.Rowcount( )

If IsNull(ldt_Termino) or Not IsDate(String(ldt_Termino)) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino corretamente.", Information!)
	dw_1.Event ue_Pos(1, "dt_termino")
	Return -1
End If

Return This.retrieve(ldt_Inicio, ldt_Termino)
end event

event dw_2::getfocus;call super::getfocus;This.ivm_Menu.mf_Incluir(False)
This.ivm_Menu.mf_Excluir(False)

return 1
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge549_relatorio_corte_pedido
integer x = 1349
integer y = 20
integer height = 176
end type

