HA$PBExportHeader$w_ge010_selecao_usuario.srw
forward
global type w_ge010_selecao_usuario from dc_w_selecao_generica
end type
end forward

global type w_ge010_selecao_usuario from dc_w_selecao_generica
integer x = 704
integer y = 436
integer width = 2263
integer height = 1528
string title = "GE010 - Sele$$HEX2$$e700e300$$ENDHEX$$o de Usu$$HEX1$$e100$$ENDHEX$$rios"
end type
global w_ge010_selecao_usuario w_ge010_selecao_usuario

type variables
long ivl_filial

Boolean lb_Somente_Estagiarios 	= False
Boolean lb_Somente_Terceiros 	= False
Boolean ib_Mostra_Inativos			= False
end variables

on w_ge010_selecao_usuario.create
call super::create
end on

on w_ge010_selecao_usuario.destroy
call super::destroy
end on

event open;call super::open;String lvs_Usuario, &
       lvs_Nulo

Long lvl_Nulo

uo_Usuario lvo_Usuario
lvo_Usuario = Create uo_Usuario

SetNull(lvs_Nulo)
SetNull(lvl_Nulo)

lvo_Usuario = Message.PowerObjectParm

lvs_Usuario = lvo_Usuario.ivs_Parametro
ivl_Filial  = lvo_Usuario.ivl_Filial
lb_Somente_Estagiarios 	= lvo_Usuario.Somente_Estagiarios
lb_Somente_Terceiros 	= lvo_Usuario.Somente_terceiros
ib_Mostra_Inativos			= lvo_Usuario.Mostra_Inativos



If lvs_Usuario <> "" Then
	dw_1.Object.Nm_usuario[1] = lvs_Usuario
	ivb_Pesquisa_Direta = True
End If
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge010_selecao_usuario
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge010_selecao_usuario
integer x = 18
integer y = 184
integer width = 2194
integer height = 1108
long backcolor = 80269524
string text = "Lista de Usu$$HEX1$$e100$$ENDHEX$$rios"
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge010_selecao_usuario
integer x = 18
integer y = 4
integer width = 1472
integer height = 172
long backcolor = 80269524
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge010_selecao_usuario
integer x = 32
integer y = 64
integer width = 1449
integer height = 104
string dataobject = "dw_ge010_selecao"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge010_selecao_usuario
integer x = 41
integer y = 236
integer width = 2149
integer height = 1032
string dataobject = "dw_ge010_lista"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Usuario

dw_1.AcceptText()

lvs_Usuario = Trim(dw_1.Object.Nm_Usuario[1])

This.of_ChangeDataObject( IIF(ib_Mostra_Inativos, 'dw_ge010_lista_ativos_inativos', 'dw_ge010_lista' ) )

If Not IsNull(lvs_Usuario) Then		
	This.of_AppendWhere("nm_usuario like '" + lvs_Usuario + "%'")
End If

If Not IsNull(ivl_Filial) Then
	This.of_AppendWhere("cd_filial = " + String(ivl_Filial))
End If

If lb_Somente_Estagiarios Then
	This.of_AppendWhere(" substring( nr_matricula, 1, 1 ) = 'E' ")
End If

If lb_Somente_Terceiros Then
	This.of_AppendWhere(" substring( nr_matricula, 1, 1 ) = 'T' ")
End If


Return 1
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge010_selecao_usuario
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
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um Usuario.", Information!, Ok!)
	dw_2.SetFocus()
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge010_selecao_usuario
integer x = 1842
integer y = 1312
end type

event cb_cancelar::clicked;call super::clicked;String lvs_Usuario

SetNull(lvs_Usuario)

CloseWithReturn(Parent, lvs_Usuario)
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge010_selecao_usuario
integer x = 1042
integer y = 1312
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge010_selecao_usuario
integer x = 27
integer y = 1324
integer width = 992
long backcolor = 80269524
end type

