HA$PBExportHeader$w_ge613_selecao_subgrupo.srw
forward
global type w_ge613_selecao_subgrupo from dc_w_selecao_generica
end type
end forward

global type w_ge613_selecao_subgrupo from dc_w_selecao_generica
integer x = 800
integer y = 436
integer width = 2071
integer height = 1528
string title = "GE613 - Sele$$HEX2$$e700e300$$ENDHEX$$o de SubGrupos de Produtos"
end type
global w_ge613_selecao_subgrupo w_ge613_selecao_subgrupo

type variables
uo_subgrupo	io_subgrupo
end variables

on w_ge613_selecao_subgrupo.create
call super::create
end on

on w_ge613_selecao_subgrupo.destroy
call super::destroy
end on

event open;call super::open;uo_Grupo	lo_Grupo

SetPointer (HourGlass!)

lo_Grupo    = Create uo_Grupo
io_SubGrupo = Create uo_SubGrupo

io_SubGrupo = Message.PowerObjectParm

lo_Grupo.of_Localiza_Codigo (io_SubGrupo.is_Grupo)

If lo_Grupo.Localizado then
	dw_1.Object.Cd_Grupo [1] = lo_Grupo.Cd_Grupo
   dw_1.Object.De_Grupo [1] = lo_Grupo.De_Grupo
End If

If Trim (io_SubGrupo.is_Parametro) <> '' then
	dw_1.Object.De_SubGrupo [1] = io_SubGrupo.is_Parametro
End If

ivb_Pesquisa_Direta = True

Destroy lo_Grupo
SetPointer (Arrow!)
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge613_selecao_subgrupo
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge613_selecao_subgrupo
integer x = 23
integer y = 264
integer width = 1998
integer height = 1024
long backcolor = 80269524
string text = "Lista de SubGrupos"
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge613_selecao_subgrupo
integer x = 23
integer y = 4
integer width = 1591
integer height = 252
long backcolor = 80269524
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge613_selecao_subgrupo
integer x = 37
integer y = 64
integer width = 1563
integer height = 176
string dataobject = "dw_ge613_selecao_subgrupo"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge613_selecao_subgrupo
integer x = 46
integer y = 316
integer width = 1952
integer height = 952
string dataobject = "dw_ge613_lista_subgrupo"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String ls_Descricao
		 
dw_1.AcceptText ()

ls_Descricao = dw_1.Object.De_SubGrupo [1]

If Trim (ls_Descricao) <> '' then
	This.of_AppendWhere ("de_subgrupo like '" + ls_Descricao + "%'")
End If

Return 1
end event

event dw_2::ue_recuperar;// Override

String	ls_Cd_Grupo

ls_Cd_Grupo = dw_1.Object.Cd_Grupo [1]

If IsNull (ls_Cd_Grupo) or ls_Cd_Grupo = '' then
	MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Informe o grupo.', StopSign!)
	dw_1.Event ue_Pos(1, 'de_grupo')
	Return -1
End If

Return This.Retrieve (ls_Cd_Grupo)
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge613_selecao_subgrupo
integer x = 1262
integer y = 1312
end type

event cb_selecionar::clicked;call super::clicked;Long		ll_Linha
String	ls_Cd_SubGrupo

ll_Linha = dw_2.GetRow ()

If ll_Linha > 0 then
	ls_Cd_SubGrupo = dw_2.Object.Cd_SubGrupo [ll_Linha]
	CloseWithReturn (Parent, ls_Cd_SubGrupo)
Else
	MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Selecione um subgrupo na lista.', Information!)
	dw_2.SetFocus ()
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge613_selecao_subgrupo
integer x = 1650
integer y = 1312
end type

event cb_cancelar::clicked;call super::clicked;String	ls_Cd_SubGrupo

SetNull (ls_Cd_SubGrupo)

CloseWithReturn (Parent, ls_Cd_SubGrupo)
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge613_selecao_subgrupo
integer x = 873
integer y = 1312
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge613_selecao_subgrupo
integer x = 37
integer y = 1328
integer width = 809
long backcolor = 80269524
end type

