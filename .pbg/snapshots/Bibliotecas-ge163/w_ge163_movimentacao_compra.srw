HA$PBExportHeader$w_ge163_movimentacao_compra.srw
forward
global type w_ge163_movimentacao_compra from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge163_movimentacao_compra from dc_w_selecao_lista_relatorio
integer width = 4361
integer height = 2072
string title = "GE163 - Movimenta$$HEX2$$e700e300$$ENDHEX$$o de Compras"
end type
global w_ge163_movimentacao_compra w_ge163_movimentacao_compra

type variables
uo_produto ivo_Produto //GE001
end variables

on w_ge163_movimentacao_compra.create
call super::create
end on

on w_ge163_movimentacao_compra.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;ivo_Produto = Create uo_Produto

dw_1.Object.dt_periodo_de		[1] = RelativeDate( Today(), -1 )
dw_1.Object.dt_periodo_ate	[1] = Today()

This.ivm_Menu.ivb_Permite_Imprimir = True
end event

event close;call super::close;Destroy ivo_Produto
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge163_movimentacao_compra
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge163_movimentacao_compra
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge163_movimentacao_compra
integer y = 308
integer width = 4247
integer height = 1564
integer weight = 700
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge163_movimentacao_compra
integer width = 2226
integer height = 276
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge163_movimentacao_compra
integer width = 2144
integer height = 180
string dataobject = "dw_ge163_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case "de_produto"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Produto.De_Apresentacao_venda Then
				Return 1
			End If
		Else
			ivo_Produto.of_Inicializa()
			
			This.Object.cd_produto	[1] = ivo_Produto.Cd_Produto
			This.Object.de_produto	[1] = ivo_Produto.De_Apresentacao_Venda
		End If
End Choose
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	
	Choose Case This.GetColumnName()
		Case "de_produto"
			ivo_Produto.of_Localiza_Produto(This.GetText())
			
			If ivo_Produto.Localizado Then
				dw_1.Object.Cd_Produto[1] = ivo_Produto.Cd_Produto
				dw_1.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
			Else
				
				ivo_Produto.Of_Inicializa()
				
				dw_1.Object.Cd_Produto[1] = ivo_Produto.Cd_Produto
				dw_1.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
				
			End If
		
	End Choose
	
End If
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge163_movimentacao_compra
integer y = 384
integer width = 4192
integer height = 1464
string dataobject = "dw_ge163_lista"
end type

event dw_2::ue_recuperar;//OverRide

Date ldh_Inicio
Date ldh_Termino
		
Long ll_Produto
	
dw_1.AcceptText()

ldh_Inicio 			= dw_1.object.dt_periodo_de			[1]
ldh_Termino		= dw_1.Object.dt_periodo_ate			[1]
ll_Produto			= dw_1.Object.cd_produto				[1]

If IsNull(ldh_Inicio) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio.", Information!)
	dw_1.Event ue_Pos(1,"dt_periodo_de")
	Return -1
End If

If IsNull(ldh_Termino) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino.", Information!)
	dw_1.Event ue_Pos(1,"dt_periodo_ate")
	Return -1
End If

If ldh_Inicio > ldh_Termino Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio deve ser menor do que a data de t$$HEX1$$e900$$ENDHEX$$mino.", Information!)
	dw_1.Event ue_Pos(1,"dt_periodo_de")
	Return -1
End If

If IsNull( ll_Produto ) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe um produto.", Information!)
	dw_1.Event ue_Pos(1,"cd_produto")
	Return -1
End If

Return This.Retrieve(ll_Produto, ldh_Inicio, ldh_Termino)
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_linhas > 0 Then
	dw_2.ivo_Controle_Menu.of_SalvarComo(True)
Else
	dw_2.ivo_Controle_Menu.of_SalvarComo(False)
End If

Return pl_linhas
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge163_movimentacao_compra
integer x = 2450
integer y = 56
integer width = 379
integer height = 208
string dataobject = "dw_ge163_relatorio"
end type

event dw_3::ue_preprint;call super::ue_preprint;THIS.Object.periodo_t.Text = STRING(dw_1.Object.dt_periodo_de [1], "DD/MM/YYYY") + " at$$HEX1$$e900$$ENDHEX$$ " + &
									  STRING(dw_1.Object.dt_periodo_ate[1], "DD/MM/YYYY")
//
THIS.Object.cd_produto_t.Text = STRING(dw_1.Object.cd_produto[1])
//
RETURN THIS.Rowcount()
//
end event

