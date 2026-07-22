HA$PBExportHeader$w_ge149_selecao_comprador.srw
forward
global type w_ge149_selecao_comprador from dc_w_selecao_generica
end type
end forward

global type w_ge149_selecao_comprador from dc_w_selecao_generica
string tag = "w_ge149_selecao_comprador"
integer x = 704
integer y = 436
integer width = 2263
integer height = 1528
string title = "GE149 - Sele$$HEX2$$e700e300$$ENDHEX$$o de Compradores"
end type
global w_ge149_selecao_comprador w_ge149_selecao_comprador

type variables

end variables

on w_ge149_selecao_comprador.create
call super::create
end on

on w_ge149_selecao_comprador.destroy
call super::destroy
end on

event open;call super::open;String lvs_Usuario

uo_ge149_Comprador lo_Comprador
lo_Comprador = Create uo_ge149_Comprador

lo_Comprador = Message.PowerObjectParm

lvs_Usuario = lo_Comprador.is_Parametro

If lvs_Usuario <> "" Then
	dw_1.Object.Nm_usuario[1] = lvs_Usuario
	ivb_Pesquisa_Direta = True
End If
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge149_selecao_comprador
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge149_selecao_comprador
integer x = 18
integer y = 184
integer width = 2194
integer height = 1108
long backcolor = 80269524
string text = "Lista de Compradores"
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge149_selecao_comprador
integer x = 18
integer y = 4
integer width = 2185
integer height = 172
long backcolor = 80269524
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge149_selecao_comprador
integer x = 32
integer y = 64
integer width = 2162
integer height = 104
string dataobject = "dw_ge149_selecao"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge149_selecao_comprador
integer x = 41
integer y = 236
integer width = 2149
integer height = 1032
string dataobject = "dw_ge149_lista"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String ls_Comprador
String ls_Ativo

dw_1.AcceptText()

ls_Comprador	= Trim(dw_1.Object.Nm_Usuario	[1])
ls_Ativo			= dw_1.Object.Id_Ativo				[1]

If Not IsNull(ls_Comprador) Then
	This.of_AppendWhere("u.nm_usuario like '" + ls_Comprador + "%'")
End If

If ls_Ativo = 'S' Then
	This.of_AppendWhere("c.id_situacao = 'A'")
	This.of_AppendWhere("(u.id_situacao in ('A', 'F')  or u.id_situacao is null)")
End If

Return 1
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge149_selecao_comprador
integer x = 1454
integer y = 1312
end type

event cb_selecionar::clicked;call super::clicked;Long lvl_Linha

String lvs_Usuario

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	lvs_Usuario = dw_2.Object.Nr_Matricula[lvl_Linha]
	CloseWithReturn(Parent, lvs_Usuario)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um Comprador.", Information!, Ok!)
	dw_2.SetFocus()
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge149_selecao_comprador
integer x = 1842
integer y = 1312
end type

event cb_cancelar::clicked;call super::clicked;String lvs_Usuario

SetNull(lvs_Usuario)

CloseWithReturn(Parent, lvs_Usuario)
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge149_selecao_comprador
integer x = 1042
integer y = 1312
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge149_selecao_comprador
integer x = 27
integer y = 1324
integer width = 992
long backcolor = 80269524
end type

