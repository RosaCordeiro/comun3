HA$PBExportHeader$w_ge017_selecao_estabelecimento_cartao.srw
forward
global type w_ge017_selecao_estabelecimento_cartao from dc_w_selecao_generica
end type
end forward

global type w_ge017_selecao_estabelecimento_cartao from dc_w_selecao_generica
integer x = 727
integer y = 376
integer width = 2039
integer height = 1656
string title = "GE005 - Sele$$HEX2$$e700e300$$ENDHEX$$o de Conveniados"
end type
global w_ge017_selecao_estabelecimento_cartao w_ge017_selecao_estabelecimento_cartao

type variables
uo_conveniado ivo_conveniado
end variables

on w_ge017_selecao_estabelecimento_cartao.create
call super::create
end on

on w_ge017_selecao_estabelecimento_cartao.destroy
call super::destroy
end on

event open;call super::open;String lvs_Parametro, &
       lvs_Estabelecimento

Long lvl_Administradora

lvs_Parametro = Message.StringParm

lvl_Administradora  = Long(LeftA(lvs_Parametro, 3))
lvs_Estabelecimento = MidA(lvs_Parametro, 4)

dw_1.Object.Cd_Administradora [1] = lvl_Administradora
dw_1.Object.Nm_Estabelecimento[1] = lvs_Estabelecimento
	
ivb_Pesquisa_Direta = True
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge017_selecao_estabelecimento_cartao
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge017_selecao_estabelecimento_cartao
integer x = 23
integer y = 284
integer width = 1966
integer height = 1128
long backcolor = 80269524
string text = "Lista de Estabelecimentos"
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge017_selecao_estabelecimento_cartao
integer x = 23
integer y = 4
integer width = 1746
integer height = 264
long backcolor = 80269524
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge017_selecao_estabelecimento_cartao
integer x = 41
integer y = 72
integer width = 1710
integer height = 184
string dataobject = "dw_ge017_selecao"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge017_selecao_estabelecimento_cartao
integer x = 50
integer y = 332
integer width = 1915
integer height = 1060
string dataobject = "dw_ge017_lista"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_recuperar;// Override

Long lvl_Administradora

String lvs_Estabelecimento

dw_1.AcceptText()

lvl_Administradora  = dw_1.Object.Cd_Administradora [1]
lvs_Estabelecimento = dw_1.Object.Nm_Estabelecimento[1]

If Not IsNull(lvs_Estabelecimento) and Trim(lvs_Estabelecimento) <> "" Then
	If Not IsNumber(lvs_Estabelecimento) Then
		This.of_AppendWhere("f.nm_fantasia like '" + lvs_Estabelecimento + "%'")
	Else
		If LenA(lvs_Estabelecimento) <= 4 Then
			This.of_AppendWhere("e.cd_filial = " + lvs_Estabelecimento)
		Else
			This.of_AppendWhere("e.cd_estabelecimento like '" + lvs_Estabelecimento + "%'")
		End If
	End If
End If

Return This.Retrieve(lvl_Administradora)
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge017_selecao_estabelecimento_cartao
integer x = 1230
integer y = 1436
end type

event cb_selecionar::clicked;Long lvl_Linha

String lvs_Estabelecimento

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	lvs_Estabelecimento = dw_2.Object.Cd_Estabelecimento[lvl_Linha]
	CloseWithReturn(Parent, lvs_Estabelecimento)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um estabelecimento na lista.", Information!)
	dw_2.SetFocus()
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge017_selecao_estabelecimento_cartao
integer x = 1618
integer y = 1436
end type

event cb_cancelar::clicked;String lvs_Nulo

SetNull(lvs_Nulo)

CloseWithReturn(Parent, lvs_Nulo)
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge017_selecao_estabelecimento_cartao
integer x = 823
integer y = 1436
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge017_selecao_estabelecimento_cartao
integer x = 27
integer y = 1448
integer width = 782
long backcolor = 80269524
end type

