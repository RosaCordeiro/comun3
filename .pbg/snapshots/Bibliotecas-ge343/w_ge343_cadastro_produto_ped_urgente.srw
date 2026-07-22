HA$PBExportHeader$w_ge343_cadastro_produto_ped_urgente.srw
forward
global type w_ge343_cadastro_produto_ped_urgente from dc_w_cadastro_lista
end type
end forward

global type w_ge343_cadastro_produto_ped_urgente from dc_w_cadastro_lista
integer width = 2062
string title = "GE343 - Cadastro Produto Bloqueado Pedido Urgente"
end type
global w_ge343_cadastro_produto_ped_urgente w_ge343_cadastro_produto_ped_urgente

type variables
uo_produto ivo_Produto
end variables

on w_ge343_cadastro_produto_ped_urgente.create
call super::create
end on

on w_ge343_cadastro_produto_ped_urgente.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;ivo_Produto = Create uo_produto 

end event

event ue_cancel;//OverRide
This.ivm_Menu.mf_Confirmar(False)
This.ivm_Menu.mf_Cancelar(False)

dw_1.Retrieve()
end event

type dw_visual from dc_w_cadastro_lista`dw_visual within w_ge343_cadastro_produto_ped_urgente
integer x = 137
integer y = 1028
end type

type gb_aux_visual from dc_w_cadastro_lista`gb_aux_visual within w_ge343_cadastro_produto_ped_urgente
integer x = 101
integer y = 956
end type

type dw_1 from dc_w_cadastro_lista`dw_1 within w_ge343_cadastro_produto_ped_urgente
integer x = 59
integer y = 84
integer width = 1879
string dataobject = "dw_ge343_lista"
end type

event dw_1::ue_preupdate;call super::ue_preupdate;Long ll_Produto
Datetime	ldh_Vigencia, ldh_Data
			
Long	ll_Row,&
		ll_Linhas
			
dw_1.AcceptText()
ldh_Data 				=  gf_GetServerDate()
ll_Linhas					= dw_1.RowCount()

For ll_Row = 1 To ll_Linhas
    
	ll_Produto			    =	dw_1.Object.cd_produto[ll_Row]
	ldh_Vigencia			=	dw_1.Object.dh_termino_vigencia[ll_Row]
	
	If IsNull(ll_Produto) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o Codigo do Produto.")
		dw_1.Event ue_Pos(ll_Row, "cd_produto")	
		Return -1
	End If
	
	If IsNull(ldh_Vigencia) or (ldh_Vigencia<ldh_Data) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a Data de Vig$$HEX1$$ea00$$ENDHEX$$ncia Correta!")
		dw_1.Event ue_Pos(ll_Row, "dh_termino_vigencia")	
		Return -1
	End If

Next

Return 1
end event

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case "de_produto"
		If Not IsNull(Data) and Trim(Data) <> '' Then
			If Data <> ivo_Produto.ivs_Descricao_Apresentacao_Estoque	Then
				Return 1
			End If
		Else
			ivo_Produto.of_Inicializa()
			
			This.Object.cd_produto[This.GetRow()] = ivo_Produto.cd_produto
			This.Object.de_Produto[This.GetRow()] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque		
		End If
			
End Choose
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "de_produto"
			ivo_Produto.of_Localiza_Produto(This.GetText())
			
			If ivo_Produto.Localizado Then
				This.Object.cd_produto	[This.GetRow()] = ivo_Produto.cd_produto
				This.Object.de_produto	[This.GetRow()] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque
			End If
	End Choose
End If
end event

event dw_1::ue_addrow;call super::ue_addrow;If AncestorReturnValue > 0 Then
	This.ivm_Menu.mf_Cancelar(True)
End If

Return AncestorReturnValue
end event

event dw_1::ue_postretrieve;call super::ue_postretrieve;
If AncestorReturnValue > 0 Then
	ivm_Menu.mf_Imprimir(True)
Else
	ivm_Menu.mf_Imprimir(False)
End If



Return AncestorReturnValue
end event

type gb_1 from dc_w_cadastro_lista`gb_1 within w_ge343_cadastro_produto_ped_urgente
integer width = 1966
integer weight = 700
string facename = "Verdana"
string text = "Produtos Bloqueados Pedido Urgente"
end type

