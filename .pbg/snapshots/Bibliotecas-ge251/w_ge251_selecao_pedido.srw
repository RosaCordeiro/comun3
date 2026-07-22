HA$PBExportHeader$w_ge251_selecao_pedido.srw
forward
global type w_ge251_selecao_pedido from dc_w_selecao_generica
end type
end forward

global type w_ge251_selecao_pedido from dc_w_selecao_generica
integer x = 379
integer y = 436
integer width = 3026
integer height = 1532
string title = "GE251 - Sele$$HEX2$$e700e300$$ENDHEX$$o de Pedido"
end type
global w_ge251_selecao_pedido w_ge251_selecao_pedido

type variables
uo_ge251_licitacao_pedido ivo_pedido
end variables

on w_ge251_selecao_pedido.create
call super::create
end on

on w_ge251_selecao_pedido.destroy
call super::destroy
end on

event open;call super::open;ivo_Pedido = Message.PowerObjectParm

end event

event ue_postopen;call super::ue_postopen;dw_1.Object.Dt_Licitacao_De[1] 	= gf_Primeiro_Dia_Mes(Today())
dw_1.Object.Dt_Licitacao_Ate[1] 	= gf_Retorna_Ultimo_Dia_Mes(Today())
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge251_selecao_pedido
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge251_selecao_pedido
integer y = 188
integer width = 2949
integer height = 1108
long backcolor = 80269524
string text = "Lista de Pedidos"
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge251_selecao_pedido
integer y = 16
integer width = 1362
integer height = 172
long backcolor = 80269524
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge251_selecao_pedido
integer x = 46
integer width = 1335
integer height = 96
string dataobject = "dw_ge251_selecao_pedido"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge251_selecao_pedido
integer x = 55
integer y = 240
integer width = 2903
integer height = 1036
string dataobject = "dw_ge251_lista_pedido"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;Date	lvdt_Dt_Licitacao_De, &
		lvdt_Dt_Licitacao_Ate
		 
dw_1.AcceptText()

lvdt_Dt_Licitacao_De	= dw_1.Object.Dt_Licitacao_De[1]
lvdt_Dt_Licitacao_Ate	= dw_1.Object.Dt_Licitacao_Ate[1]

If Not IsNull(lvdt_Dt_Licitacao_De) Then 
	This.of_AppendWhere(gf_Compara_Data("lp.dh_licitacao", ">=", lvdt_Dt_Licitacao_De) )
End If	

If Not IsNull(lvdt_Dt_Licitacao_Ate) Then 
	This.of_AppendWhere(gf_Compara_Data("lp.dh_licitacao", "<=", lvdt_Dt_Licitacao_Ate) )
End If

Return 1
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge251_selecao_pedido
integer x = 2213
end type

event cb_selecionar::clicked;call super::clicked;Long 	lvl_Linha, &
		lvl_Nr_Pedido

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	lvl_Nr_Pedido = dw_2.Object.Nr_Pedido[lvl_Linha]
	
	CloseWithReturn(Parent, String(lvl_Nr_Pedido))
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Selecione um Pedido.", Information!, Ok!)
	dw_2.SetFocus()
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge251_selecao_pedido
integer x = 2610
end type

event cb_cancelar::clicked;call super::clicked;String lvs_Cd_Cliente

SetNull(lvs_Cd_Cliente)

CloseWithReturn(Parent, lvs_Cd_Cliente)
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge251_selecao_pedido
integer x = 1783
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge251_selecao_pedido
integer x = 41
integer y = 1328
integer width = 1710
long backcolor = 80269524
end type

