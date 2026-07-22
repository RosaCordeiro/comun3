HA$PBExportHeader$w_ge117_consulta_produto.srw
forward
global type w_ge117_consulta_produto from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge117_consulta_produto from dc_w_selecao_lista_relatorio
string accessiblename = "Consulta Produto (GE117)"
integer width = 2446
integer height = 1148
string title = "GE117 - Consulta Produto"
end type
global w_ge117_consulta_produto w_ge117_consulta_produto

type variables
uo_produto ivo_produto
end variables

on w_ge117_consulta_produto.create
call super::create
end on

on w_ge117_consulta_produto.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;This.ivm_Menu.mf_Recuperar( False )
This.ivm_Menu.ivb_Permite_Recuperar = False

If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento( "W_GE117_CONSULTA_PRODUTO", Ref gvs_Matricula_Farmaceutico ) Then
	Close(This)
	Return -1
End If

ivo_Produto = Create uo_Produto
dw_2.InsertRow( 0 )
end event

event close;call super::close;Destroy(ivo_Produto)
end event

event ue_postopen;call super::ue_postopen;dw_2.Event ue_Pos( 1, 'localizacao' )
end event

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge117_consulta_produto
integer x = 23
integer y = 4
integer width = 2341
integer height = 920
integer weight = 700
string facename = "Verdana"
string text = ""
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge117_consulta_produto
boolean visible = false
integer x = 1504
integer y = 36
integer width = 457
integer height = 140
integer weight = 700
string facename = "Verdana"
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge117_consulta_produto
boolean visible = false
integer x = 1586
integer width = 256
integer height = 76
string dataobject = "dw_ge117_selecao_produto"
end type

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	If This.GetColumnName() = "de_produto" Then
		String lvs_Produto
		
		lvs_Produto = dw_1.GetText()		
		ivo_Produto.of_Localiza_Produto(lvs_Produto)
		
		If ivo_Produto.Localizado Then
			dw_1.Object.Cd_Produto[1] = ivo_Produto.Cd_Produto
			dw_1.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
		End If
	End If
End If
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Produto) Then
	dw_1.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
End If

end event

event dw_1::itemchanged;call super::itemchanged;If dwo.Name = "de_produto" Then
	If Data <> ivo_Produto.ivs_Descricao_Apresentacao_Venda Then
		Return 1
	End If
End If
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge117_consulta_produto
integer x = 55
integer y = 56
integer width = 2286
integer height = 832
string dataobject = "dw_ge117_detalhe"
boolean vscrollbar = false
end type

event dw_2::constructor;// OverRide
String lvs_DataObject

This.of_SetTransObject(SqlCa)

lvs_DataObject = This.DataObject

If Trim(This.DataObject) <> "" Then
	ivs_SQL_Original = This.Object.DataWindow.Table.Select
End If

ivo_Controle_Menu = Create dc_uo_Menu_DW

ivo_Controle_Menu.of_SetDW(This)

SetNull(ivm_Menu)

This.of_GetParentWindow()

This.ShareData(dw_3)



end event

event dw_2::ue_recuperar;// OverRide
If Not ivo_Produto.Localizado Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Favor informar o produto.",Information! )
	dw_1.Event ue_Pos( 1, "de_produto" )
	Return -1
End If

Return This.Retrieve( ivo_Produto.Cd_Produto )
end event

event dw_2::ue_key;call super::ue_key;String lvs_Produto

If Key = KeyEnter! Then
	If This.GetColumnName() = "localizacao" Then
		
		lvs_Produto = This.GetText()		
		ivo_Produto.of_Localiza_Produto(lvs_Produto)
		
		If ivo_Produto.Localizado Then
			This.Event ue_Retrieve( )
		End If
	End If
End If
end event

event dw_2::itemchanged;call super::itemchanged;If dwo.Name = "localizacao" Then
	If Data <> ivo_Produto.ivs_Descricao_Apresentacao_Venda Then
		Return 1
	End If
End If
end event

event dw_2::losefocus;call super::losefocus;If IsValid(ivo_Produto) Then
	dw_1.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
End If
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge117_consulta_produto
integer x = 2034
integer y = 640
integer width = 274
integer height = 172
end type

