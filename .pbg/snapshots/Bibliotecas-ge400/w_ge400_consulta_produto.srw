HA$PBExportHeader$w_ge400_consulta_produto.srw
forward
global type w_ge400_consulta_produto from w_ge400_cadastro_produto
end type
end forward

global type w_ge400_consulta_produto from w_ge400_cadastro_produto
integer width = 3781
string title = "GE400 - Consulta de Produtos"
end type
global w_ge400_consulta_produto w_ge400_consulta_produto

forward prototypes
public subroutine wf_set_somente_consulta ()
end prototypes

public subroutine wf_set_somente_consulta ();// OverRide

//Se passar da valida$$HEX2$$e700e300$$ENDHEX$$o do SAP faz o controle das dws 1, 12 e 14 conforme permiss$$HEX1$$e300$$ENDHEX$$o do usu$$HEX1$$e100$$ENDHEX$$rio

This.ivm_menu.ivb_permite_alterar = False
	
Tab_1.TabPage_1.dw_1.of_Set_Somente_Leitura(This.ivm_menu.ivb_permite_alterar) 	
Tab_1.TabPage_6.dw_12.of_Set_Somente_Leitura(This.ivm_menu.ivb_permite_alterar) 
Tab_1.TabPage_2.dw_14.of_Set_Somente_Leitura(This.ivm_menu.ivb_permite_alterar) 
Tab_1.TabPage_2.dw_2.of_Set_Somente_Leitura(This.ivm_menu.ivb_permite_alterar) 
Tab_1.TabPage_3.dw_3.of_Set_Somente_Leitura(This.ivm_menu.ivb_permite_alterar) 
Tab_1.TabPage_3.dw_4.of_Set_Somente_Leitura(This.ivm_menu.ivb_permite_alterar) 
Tab_1.TabPage_3.dw_5.of_Set_Somente_Leitura(This.ivm_menu.ivb_permite_alterar) 
Tab_1.TabPage_4.dw_6.of_Set_Somente_Leitura(This.ivm_menu.ivb_permite_alterar) 
Tab_1.TabPage_2.dw_7.of_Set_Somente_Leitura(This.ivm_menu.ivb_permite_alterar) 
Tab_1.TabPage_2.dw_8.of_Set_Somente_Leitura(This.ivm_menu.ivb_permite_alterar) 
Tab_1.TabPage_2.dw_9.of_Set_Somente_Leitura(This.ivm_menu.ivb_permite_alterar) 
Tab_1.TabPage_5.dw_10.of_Set_Somente_Leitura(This.ivm_menu.ivb_permite_alterar) 
Tab_1.TabPage_4.dw_15.of_Set_Somente_Leitura(This.ivm_menu.ivb_permite_alterar) 
dw_13.of_Set_Somente_Leitura(This.ivm_menu.ivb_permite_alterar)
end subroutine

on w_ge400_consulta_produto.create
call super::create
end on

on w_ge400_consulta_produto.destroy
call super::destroy
end on

event ue_postopen;// OverRide

ivo_dbError = Create dc_uo_dbError

//Registra Tela para Controle de Inatividade
If (Not(ivb_permite_fechar)) and (IsValid(gvo_Aplicacao)) Then
	If gvo_Aplicacao.ivb_Usa_Timer_Out Then
		gvo_Aplicacao.of_insere_tela(This.Title)
	End If
End If

// Insere a tela response do array de responses abertas
// Necess$$HEX1$$e100$$ENDHEX$$rio a armazenagem para fechar as telas por inatividade
If IsValid(gvo_Aplicacao) Then
	If gvo_Aplicacao.ivb_usa_timer_out Then
		If This.WindowType = Response! Then
			gvo_Aplicacao.of_insere_response(This)
		End if
	End If
End If

//Verifica se no grupo de acesso a tela est$$HEX1$$e100$$ENDHEX$$ sem permiss$$HEX1$$e300$$ENDHEX$$o de altera$$HEX2$$e700e300$$ENDHEX$$o
// e seta como somente leitura os campos
If This.WindowType <> Response! Then
	wf_set_somente_consulta()
End If	

Integer lvl_PxWidth
Integer lvl_PxHeight
Integer lvl_UnWidth
Integer lvl_UnHeight

If (MaxWidth > 0)or(MaxHeight>0) Then
	gvo_aplicacao.of_retorna_resolucao_monitor(lvl_PxWidth,lvl_PxHeight)
	
	lvl_UnWidth	= PixelsToUnits(lvl_PxWidth,XPixelsToUnits!)
	lvl_UnHeight	= PixelsToUnits(lvl_PxHeight,YPixelsToUnits!)
	
	If (lvl_PxWidth <> 800)and(MaxWidth > 0) Then //Diferente da resolu$$HEX2$$e700e300$$ENDHEX$$o 800 x 600 (Padr$$HEX1$$e300$$ENDHEX$$o Loja)
		If lvl_UnWidth >= MaxWidth Then //Maior que tamanho ideal
			This.Width = MaxWidth
		Else 
			This.Width = lvl_UnWidth - 50
		End If
	End If
	
	If (lvl_PxHeight <> 600)and(MaxHeight > 0) Then //Diferente da resolu$$HEX2$$e700e300$$ENDHEX$$o 800 x 600 (Padr$$HEX1$$e300$$ENDHEX$$o Loja)
		If lvl_UnHeight >= MaxHeight Then //Maior que tamanho ideal
			This.Height = MaxHeight
		Else 
			This.Height = lvl_UnHeight - 650
		End If
	End If
End If

dc_uo_dw_Base lvo_DW[]
lvo_DW = {Tab_1.TabPage_1.dw_1, Tab_1.TabPage_4.dw_6, Tab_1.TabPage_2.dw_7, Tab_1.TabPage_2.dw_9, Tab_1.TabPage_6.dw_12, dw_13 }
This.wf_SetUpdate_DW(lvo_DW)

ivdh_Parametro = gvo_Parametro.of_Dh_Movimentacao()

Tab_1.TabPage_1.dw_1.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_2.dw_2.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_3.dw_3.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_3.dw_4.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_3.dw_5.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_4.dw_6.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_2.dw_7.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_2.dw_8.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_2.dw_9.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_5.dw_10.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_6.dw_12.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_2.dw_14.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_4.dw_15.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_3.dw_16.of_SetMenu(This.ivm_Menu)

Tab_1.TabPage_1.dw_1.ivo_Controle_Menu.of_Incluir(True)
Tab_1.TabPage_4.dw_6.ivo_Controle_Menu.of_Incluir(True)
Tab_1.TabPage_2.dw_9.ivo_Controle_Menu.of_Incluir(True)
Tab_1.TabPage_6.dw_12.ivo_Controle_Menu.of_Incluir(True)
Tab_1.TabPage_2.dw_14.ivo_Controle_Menu.of_Incluir(True)
Tab_1.TabPage_4.dw_15.ivo_Controle_Menu.of_Incluir(True)
Tab_1.TabPage_3.dw_16.ivo_Controle_Menu.of_Incluir(True)

Tab_1.TabPage_1.dw_1.Event ue_AddRow()
Tab_1.TabPage_3.dw_16.Event ue_AddRow()
Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "de_produto_localizacao")

// Localiza o caminho das fotos para o eCommerce e para as Categorias
wf_Localiza_Path_Fotos()

Tab_1.TabPage_1.dw_1.Object.De_Registro_Ms.EditMask.Mask = "#.####.####.###-#"
Tab_1.TabPage_1.dw_1.Object.Cd_Subcategoria.EditMask.Mask = "#.##.###.###"
Tab_1.TabPage_1.dw_1.Object.Cd_Fornecedor_Usual.EditMask.Mask = "####-#####"

If Not wf_Verifica_Permissao() Then Return

wf_Set_Somente_Consulta()


end event

type dw_visual from w_ge400_cadastro_produto`dw_visual within w_ge400_consulta_produto
end type

type gb_aux_visual from w_ge400_cadastro_produto`gb_aux_visual within w_ge400_consulta_produto
end type

type dw_13 from w_ge400_cadastro_produto`dw_13 within w_ge400_consulta_produto
end type

type st_1 from w_ge400_cadastro_produto`st_1 within w_ge400_consulta_produto
end type

type tab_1 from w_ge400_cadastro_produto`tab_1 within w_ge400_consulta_produto
end type

event tab_1::selectionchanged;call super::selectionchanged;This.Event Clicked(NewIndex)

If NewIndex = 4 then
	Tab_1.TabPage_2.cb_replica_venda.Visible = False
	Tab_1.TabPage_2.cb_replica_reposicao.Visible = False
End If
end event

type tabpage_1 from w_ge400_cadastro_produto`tabpage_1 within tab_1
end type

type gb_1 from w_ge400_cadastro_produto`gb_1 within tabpage_1
end type

type dw_1 from w_ge400_cadastro_produto`dw_1 within tabpage_1
end type

type tabpage_6 from w_ge400_cadastro_produto`tabpage_6 within tab_1
end type

type gb_12 from w_ge400_cadastro_produto`gb_12 within tabpage_6
end type

type dw_12 from w_ge400_cadastro_produto`dw_12 within tabpage_6
end type

type tabpage_5 from w_ge400_cadastro_produto`tabpage_5 within tab_1
end type

type gb_10 from w_ge400_cadastro_produto`gb_10 within tabpage_5
end type

type dw_10 from w_ge400_cadastro_produto`dw_10 within tabpage_5
end type

type tabpage_2 from w_ge400_cadastro_produto`tabpage_2 within tab_1
end type

type gb_8 from w_ge400_cadastro_produto`gb_8 within tabpage_2
end type

type gb_4 from w_ge400_cadastro_produto`gb_4 within tabpage_2
end type

type gb_14 from w_ge400_cadastro_produto`gb_14 within tabpage_2
end type

type gb_13 from w_ge400_cadastro_produto`gb_13 within tabpage_2
end type

type pb_1 from w_ge400_cadastro_produto`pb_1 within tabpage_2
end type

type dw_7 from w_ge400_cadastro_produto`dw_7 within tabpage_2
end type

type dw_8 from w_ge400_cadastro_produto`dw_8 within tabpage_2
end type

type dw_9 from w_ge400_cadastro_produto`dw_9 within tabpage_2
end type

type dw_14 from w_ge400_cadastro_produto`dw_14 within tabpage_2
end type

type dw_2 from w_ge400_cadastro_produto`dw_2 within tabpage_2
end type

type cb_replica_reposicao from w_ge400_cadastro_produto`cb_replica_reposicao within tabpage_2
end type

type cb_replica_venda from w_ge400_cadastro_produto`cb_replica_venda within tabpage_2
end type

type cb_preco_legado from w_ge400_cadastro_produto`cb_preco_legado within tabpage_2
end type

type tabpage_3 from w_ge400_cadastro_produto`tabpage_3 within tab_1
end type

type gb_2 from w_ge400_cadastro_produto`gb_2 within tabpage_3
end type

type gb_7 from w_ge400_cadastro_produto`gb_7 within tabpage_3
integer width = 3643
end type

type gb_6 from w_ge400_cadastro_produto`gb_6 within tabpage_3
end type

type gb_5 from w_ge400_cadastro_produto`gb_5 within tabpage_3
end type

type dw_3 from w_ge400_cadastro_produto`dw_3 within tabpage_3
end type

type dw_4 from w_ge400_cadastro_produto`dw_4 within tabpage_3
end type

type dw_5 from w_ge400_cadastro_produto`dw_5 within tabpage_3
integer width = 3611
end type

type cbx_mostra_produtos_planograma from w_ge400_cadastro_produto`cbx_mostra_produtos_planograma within tabpage_3
end type

type dw_16 from w_ge400_cadastro_produto`dw_16 within tabpage_3
end type

type tabpage_4 from w_ge400_cadastro_produto`tabpage_4 within tab_1
end type

type gb_11 from w_ge400_cadastro_produto`gb_11 within tabpage_4
end type

type gb_3 from w_ge400_cadastro_produto`gb_3 within tabpage_4
end type

type dw_6 from w_ge400_cadastro_produto`dw_6 within tabpage_4
end type

type dw_15 from w_ge400_cadastro_produto`dw_15 within tabpage_4
end type

type dw_17 from w_ge400_cadastro_produto`dw_17 within tabpage_4
end type

