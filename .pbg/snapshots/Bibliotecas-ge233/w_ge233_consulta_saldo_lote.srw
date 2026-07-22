HA$PBExportHeader$w_ge233_consulta_saldo_lote.srw
forward
global type w_ge233_consulta_saldo_lote from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge233_consulta_saldo_lote from dc_w_selecao_lista_relatorio
integer width = 1769
string title = "GE233 - Consulta Estoque de Lotes de Controlado"
long backcolor = 80269524
end type
global w_ge233_consulta_saldo_lote w_ge233_consulta_saldo_lote

type variables
uo_Produto ivo_Produto
end variables

forward prototypes
public subroutine wf_localiza_produto ()
end prototypes

public subroutine wf_localiza_produto ();dw_1.AcceptText()

ivo_Produto.of_Localiza_Produto(dw_1.GetText())

If ivo_Produto.Localizado Then
	
	dw_1.Object.cd_produto[1] = ivo_Produto.cd_Produto
	dw_1.Object.nm_produto[1] = ivo_Produto.de_Produto + ":" + ivo_Produto.De_Apresentacao_Venda
	
Else
	Long lvl_Nulo
	
	SetNull(lvl_Nulo)
	
	dw_1.Object.cd_produto[1] = lvl_Nulo
	dw_1.Object.nm_produto[1] = ''

End If
end subroutine

on w_ge233_consulta_saldo_lote.create
call super::create
end on

on w_ge233_consulta_saldo_lote.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;Destroy(ivo_Produto)
end event

event ue_postopen;call super::ue_postopen;ivo_Produto = Create uo_Produto
end event

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge233_consulta_saldo_lote
integer y = 184
integer width = 1143
integer height = 1016
integer weight = 700
string facename = "Verdana"
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge233_consulta_saldo_lote
integer width = 1669
integer height = 160
integer weight = 700
string facename = "Verdana"
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge233_consulta_saldo_lote
integer x = 55
integer y = 68
integer width = 1641
integer height = 80
string dataobject = "dw_ge233_selecao"
end type

event dw_1::editchanged;call super::editchanged;dw_2.Event ue_Reset()
end event

event dw_1::itemchanged;call super::itemchanged;Long lvl_Nulo

Choose Case dwo.Name 
	Case "nm_produto"
	
		SetNull(lvl_Nulo)
	
		If Data = "" Or IsNull(Data) Then
			This.Object.Cd_Produto[1] = lvl_nulo
			Return 0
		End If	
		
		If Data <> ivo_Produto.De_Produto Then Return 1
		
End Choose
end event

event dw_1::ue_key;String lvs_Coluna

If key = KeyEnter! Then
	
	lvs_Coluna = This.GetColumnName()
	
	Choose Case lvs_Coluna
		Case 'nm_produto'
			wf_Localiza_Produto()
	End Choose
End If
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge233_consulta_saldo_lote
integer y = 260
integer width = 1074
integer height = 920
string dataobject = "dw_ge233_lista"
end type

event dw_2::ue_addrow;call super::ue_addrow;This.Object.Cd_Produto[GetRow()] = ivo_Produto.Cd_Produto

Return 1
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;Long lvl_Produto

dw_1.AcceptText()

lvl_Produto = dw_1.Object.Cd_Produto[1]

If IsNull(lvl_Produto) Then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Informe o produto.', Information!)
	dw_1.Event ue_Pos(1, "nm_produto")
	Return -1
End If

This.of_AppendWhere('cd_produto = ' + String(lvl_Produto))


Return 1
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge233_consulta_saldo_lote
integer x = 1221
integer y = 312
end type

