HA$PBExportHeader$w_ge078_selecao_portador.srw
forward
global type w_ge078_selecao_portador from dc_w_selecao_generica
end type
end forward

global type w_ge078_selecao_portador from dc_w_selecao_generica
integer width = 2071
integer height = 1528
string title = "GE078 - Sele$$HEX2$$e700e300$$ENDHEX$$o do Portador"
long backcolor = 80269524
end type
global w_ge078_selecao_portador w_ge078_selecao_portador

type variables
uo_filial ivo_filial
end variables

on w_ge078_selecao_portador.create
call super::create
end on

on w_ge078_selecao_portador.destroy
call super::destroy
end on

event open;call super::open;String lvs_Parametro

ivo_Filial = Create uo_Filial

lvs_Parametro = Message.StringParm

If lvs_Parametro <> "" Then
	dw_1.Object.de_portador[1] = lvs_Parametro
	ivb_Pesquisa_Direta = True
End IF



end event

event close;call super::close;Destroy(ivo_Filial)
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge078_selecao_portador
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge078_selecao_portador
integer x = 18
integer y = 196
integer width = 2002
integer height = 1104
long backcolor = 80269524
string text = "Lista de Portador"
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge078_selecao_portador
integer x = 23
integer width = 1518
integer height = 164
long backcolor = 80269524
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge078_selecao_portador
integer x = 41
integer y = 68
integer width = 1486
integer height = 88
string dataobject = "dw_ge078_selecao_portador"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge078_selecao_portador
integer x = 55
integer y = 264
integer width = 1920
integer height = 1016
string dataobject = "dw_ge078_lista_portador"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Portador

dw_1.AcceptText()

lvs_Portador = dw_1.Object.de_portador[1] 

If Not IsNull(lvs_Portador) or lvs_Portador <> "" Then
	This.of_AppendWhere("portador.de_portador like '" + lvs_Portador + "%'") 
End If

Return 1
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge078_selecao_portador
integer x = 1262
integer width = 366
end type

event cb_selecionar::clicked;Long lvl_Linha, &
	  lvl_Portador

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	lvl_Portador = dw_2.Object.cd_portador[lvl_Linha]
	CloseWithReturn(Parent, lvl_Portador)
Else 
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione o portador.",Information!, Ok!)
	dw_2.SetFocus()
End If





end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge078_selecao_portador
integer x = 1650
integer width = 366
end type

event cb_cancelar::clicked;String lvs_Portador

SetNull(lvs_Portador)

CloseWithReturn(Parent, lvs_Portador)

end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge078_selecao_portador
integer x = 832
integer width = 366
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge078_selecao_portador
integer width = 782
long backcolor = 80269524
end type

