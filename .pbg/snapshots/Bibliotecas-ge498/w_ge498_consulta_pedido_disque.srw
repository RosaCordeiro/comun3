HA$PBExportHeader$w_ge498_consulta_pedido_disque.srw
forward
global type w_ge498_consulta_pedido_disque from dc_w_2tab_consulta_selecao_lista_2det
end type
end forward

global type w_ge498_consulta_pedido_disque from dc_w_2tab_consulta_selecao_lista_2det
integer width = 3410
integer height = 1696
string title = "GE498 - Consulta Pedido Disque Entrega"
end type
global w_ge498_consulta_pedido_disque w_ge498_consulta_pedido_disque

type variables

end variables

forward prototypes
public subroutine wf_alterar_pedido (long pl_row)
end prototypes

public subroutine wf_alterar_pedido (long pl_row);uo_ge498_pedido_disque_entrega luo_pedido

luo_pedido = create uo_ge498_pedido_disque_entrega

luo_pedido.cd_filial	= tab_1.tabpage_1.dw_2.Object.cd_filial[pl_row]
luo_pedido.nr_pedido =  tab_1.tabpage_1.dw_2.Object.nr_pedido_disque[pl_row]
luo_pedido.id_alteracao_pedido = True

OpenWithParm(w_ge498_pedido_disque, luo_pedido)
end subroutine

on w_ge498_consulta_pedido_disque.create
call super::create
end on

on w_ge498_consulta_pedido_disque.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;DateTime lvdh_Parametro

String ls_Rede_Filial

lvdh_Parametro = gvo_Parametro.of_Dh_Movimentacao()

Tab_1.TabPage_1.dw_1.Object.Dt_Inicio	[1] = RelativeDate( Today(), -3)
Tab_1.TabPage_1.dw_1.Object.Dt_Fim	[1] = Today()

end event

type dw_visual from dc_w_2tab_consulta_selecao_lista_2det`dw_visual within w_ge498_consulta_pedido_disque
end type

type gb_aux_visual from dc_w_2tab_consulta_selecao_lista_2det`gb_aux_visual within w_ge498_consulta_pedido_disque
end type

type tab_1 from dc_w_2tab_consulta_selecao_lista_2det`tab_1 within w_ge498_consulta_pedido_disque
integer width = 3333
integer height = 1492
end type

event tab_1::constructor;call super::constructor;ivl_Largura_1 = 3314
ivl_Altura_1  = 1680

ivl_Largura_2 = 3328
ivl_Altura_2  = 1680 
end event

event tab_1::selectionchanged;call super::selectionchanged;long ll_cd_filial
long ll_nr_pedido
long ll_linha

Choose Case NewIndex
	Case 2
		
		ll_linha = tabpage_1.dw_2.getrow()
		
		if ll_linha < 1 Then return 0
		
		ll_cd_filial = tabpage_1.dw_2.object.cd_filial[ll_linha]
		ll_nr_pedido = tabpage_1.dw_2.object.nr_pedido_disque[ll_linha]
		
		tabpage_2.dw_3.retrieve(ll_cd_filial,ll_nr_pedido)
		tabpage_2.dw_4.retrieve(ll_cd_filial,ll_nr_pedido)
		
End Choose
end event

event tab_1::selectionchanging;If NewIndex = 2 and Tab_1.TabPage_1.dw_2.GetRow() < 1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma linha da lista para visualizar os detalhes.", StopSign!)
	// N$$HEX1$$e300$$ENDHEX$$o permite a troca do folder
	Return 1
end if
end event

type tabpage_1 from dc_w_2tab_consulta_selecao_lista_2det`tabpage_1 within tab_1
integer width = 3296
integer height = 1376
end type

type gb_2 from dc_w_2tab_consulta_selecao_lista_2det`gb_2 within tabpage_1
integer width = 3269
integer height = 992
end type

type gb_1 from dc_w_2tab_consulta_selecao_lista_2det`gb_1 within tabpage_1
integer width = 3269
end type

type dw_1 from dc_w_2tab_consulta_selecao_lista_2det`dw_1 within tabpage_1
integer width = 2898
integer height = 268
string dataobject = "dw_ge498_selecao_consulta_pedido"
end type

event dw_1::constructor;call super::constructor;This.of_SetColSelection(TRUE)
end event

type dw_2 from dc_w_2tab_consulta_selecao_lista_2det`dw_2 within tabpage_1
integer y = 436
integer width = 3214
integer height = 920
string dataobject = "dw_ge498_lista_pedido"
end type

event dw_2::ue_key;call super::ue_key;If dw_2.RowCount( ) < 1 Then Return -1

Long ll_Row

dw_2.AcceptText( )

ll_Row = dw_2.GetRow( )

Choose Case Key 
	Case KeySpaceBar!
		wf_alterar_pedido(ll_row)
End Choose
end event

event dw_2::constructor;call super::constructor;This.of_SetRowSelection( "if (id_situacao = ~"X~", rgb(255, 0, 0), If(id_refaturado = ~"S~", rgb(255,165,0), if( not isnull( dh_impressao ), rgb(102, 205, 170), " + This.ivs_Cor_Linha_Padrao + ")))", "", False )
end event

event dw_2::buttonclicked;call super::buttonclicked;if dwo.name = 'b_alterar' then
	wf_alterar_pedido(row)
end if
end event

type tabpage_2 from dc_w_2tab_consulta_selecao_lista_2det`tabpage_2 within tab_1
integer width = 3296
integer height = 1376
end type

type gb_4 from dc_w_2tab_consulta_selecao_lista_2det`gb_4 within tabpage_2
integer y = 636
integer width = 3259
integer height = 712
end type

type gb_3 from dc_w_2tab_consulta_selecao_lista_2det`gb_3 within tabpage_2
integer width = 3259
integer height = 608
string text = "Dados Entrega"
end type

type dw_3 from dc_w_2tab_consulta_selecao_lista_2det`dw_3 within tabpage_2
integer width = 3195
integer height = 516
string dataobject = "dw_ge498_consulta_pedido_entrega"
end type

type dw_4 from dc_w_2tab_consulta_selecao_lista_2det`dw_4 within tabpage_2
integer x = 32
integer y = 704
integer width = 3241
integer height = 612
string dataobject = "dw_ge498_consulta_lista_produtos"
boolean vscrollbar = true
end type

