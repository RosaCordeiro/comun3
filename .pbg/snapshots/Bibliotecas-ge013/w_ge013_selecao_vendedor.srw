HA$PBExportHeader$w_ge013_selecao_vendedor.srw
forward
global type w_ge013_selecao_vendedor from dc_w_selecao_generica
end type
end forward

global type w_ge013_selecao_vendedor from dc_w_selecao_generica
integer x = 704
integer width = 2272
string title = "GE013 - Sele$$HEX2$$e700e300$$ENDHEX$$o de Vendedores"
end type
global w_ge013_selecao_vendedor w_ge013_selecao_vendedor

on w_ge013_selecao_vendedor.create
call super::create
end on

on w_ge013_selecao_vendedor.destroy
call super::destroy
end on

event open;call super::open;String lvs_vendedor, &
       lvs_Nulo
		 
Long lvl_Nulo

SetNull(lvs_Nulo)
SetNull(lvl_Nulo)

lvs_vendedor = Message.StringParm

If gvo_parametro.of_filial() <> gvo_parametro.of_filial_matriz() Then
	dw_1.Object.nm_filial[1] = gvo_parametro.nm_fantasia_filial
	dw_1.Object.cd_filial[1] = gvo_parametro.of_filial()
Else
	dw_1.Object.nm_filial[1] = lvs_Nulo
	dw_1.Object.cd_filial[1] = lvl_Nulo
End If

If lvs_vendedor <> "" Then
	dw_1.Object.de_vendedor[1] = lvs_vendedor
	ivb_Pesquisa_Direta = TRUE
End If
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge013_selecao_vendedor
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge013_selecao_vendedor
integer x = 23
integer y = 280
integer width = 2203
integer height = 1040
long backcolor = 80269524
string text = "Lista de Vendedores"
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge013_selecao_vendedor
integer x = 23
integer y = 4
integer width = 1737
integer height = 264
long backcolor = 80269524
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge013_selecao_vendedor
integer x = 46
integer y = 72
integer width = 1696
integer height = 180
string dataobject = "dw_ge013_selecao"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge013_selecao_vendedor
integer x = 46
integer y = 328
integer width = 2158
integer height = 964
string dataobject = "dw_ge013_lista"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String  lvs_SQL, &
        lvs_Where, &
        lvs_Vendedor

Long lvl_Filial

dw_1.AcceptText()

lvs_Vendedor = Trim(dw_1.Object.de_vendedor[1])
lvl_Filial   = dw_1.Object.cd_filial[1]

// Verifica o SQL atual
lvs_SQL = ivs_SQL_Original

If Not IsNull(lvs_Vendedor) Then		
	This.of_AppendWhere("usuario.nm_usuario like '" + lvs_Vendedor + "%'")
End If

If Not IsNull(lvl_Filial) Then
	This.of_AppendWhere("usuario.cd_filial =" + String(lvl_Filial))
End If

// Concatena o SQL da DW com os par$$HEX1$$e200$$ENDHEX$$metros formulados
If Trim(lvs_Where) <> "" Then
	lvs_SQL = lvs_SQL + lvs_Where
End If

Return AncestorReturnValue
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge013_selecao_vendedor
integer x = 1463
integer y = 1344
end type

event cb_selecionar::clicked;call super::clicked;Long lvl_Linha
String lvs_vendedor

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	lvs_vendedor = dw_2.Object.nr_matricula_vendedor[lvl_Linha]
	CloseWithReturn(Parent, lvs_vendedor)
ELSE
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Selecione um vendedor.", Information!, Ok!)
	dw_2.SetFocus()
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge013_selecao_vendedor
integer x = 1851
integer y = 1344
end type

event cb_cancelar::clicked;call super::clicked;Integer lvi_vendedor

SETNULL(lvi_vendedor)

CloseWithReturn(PARENT, lvi_vendedor)

end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge013_selecao_vendedor
integer x = 1061
integer y = 1344
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge013_selecao_vendedor
integer y = 1356
integer width = 987
long backcolor = 80269524
end type

