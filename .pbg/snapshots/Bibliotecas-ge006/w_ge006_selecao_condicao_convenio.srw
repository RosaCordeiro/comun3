HA$PBExportHeader$w_ge006_selecao_condicao_convenio.srw
forward
global type w_ge006_selecao_condicao_convenio from dc_w_selecao_generica
end type
end forward

global type w_ge006_selecao_condicao_convenio from dc_w_selecao_generica
integer width = 2085
integer height = 1536
string title = "GE006 - Sele$$HEX2$$e700e300$$ENDHEX$$o de Condi$$HEX2$$e700f500$$ENDHEX$$es de Venda para Conv$$HEX1$$ea00$$ENDHEX$$nios"
end type
global w_ge006_selecao_condicao_convenio w_ge006_selecao_condicao_convenio

type variables
String is_Somente_Ativas
end variables

on w_ge006_selecao_condicao_convenio.create
call super::create
end on

on w_ge006_selecao_condicao_convenio.destroy
call super::destroy
end on

event open;call super::open;uo_Convenio lvo_Convenio

uo_Parametro_Selecao_Condicao_Venda_cv lvo_Parametro

lvo_Convenio  = Create uo_Convenio
lvo_Parametro = Create uo_Parametro_Selecao_Condicao_Venda_cv

lvo_Parametro = Message.PowerObjectParm

This.is_Somente_Ativas = lvo_Parametro.is_Somente_Ativas

dw_1.Object.Cd_Convenio[1]  = lvo_Parametro.ivl_Convenio

If lvo_Parametro.ivl_Convenio > 0 Then lvo_Convenio.of_Localiza_Convenio(String(lvo_Parametro.ivl_Convenio))

If lvo_Convenio.Localizado Then dw_1.Object.Nm_Convenio[1] = lvo_Convenio.Nm_Fantasia
	
If Trim(lvo_Parametro.ivs_Nome) <> "" Then
	dw_1.Object.De_Condicao[1] = lvo_Parametro.ivs_Nome     
End If

ivb_Pesquisa_Direta = True
	
Destroy(lvo_Parametro)
Destroy(lvo_Convenio)
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge006_selecao_condicao_convenio
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge006_selecao_condicao_convenio
integer x = 23
integer y = 280
integer width = 2007
integer height = 1012
string text = "Lista de Condi$$HEX2$$e700f500$$ENDHEX$$es de Venda"
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge006_selecao_condicao_convenio
integer x = 23
integer y = 4
integer width = 1815
integer height = 260
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge006_selecao_condicao_convenio
integer x = 41
integer y = 68
integer width = 1787
integer height = 184
string dataobject = "dw_ge006_selecao"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge006_selecao_condicao_convenio
integer x = 46
integer y = 328
integer width = 1961
integer height = 944
string dataobject = "dw_ge006_lista"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Descricao
		 
Long lvl_Convenio

dw_1.AcceptText()

lvl_Convenio  = dw_1.Object.Cd_Convenio[1]
lvs_Descricao = dw_1.Object.De_Condicao[1] 

This.of_AppendWhere("relacao_condicao_convenio.cd_convenio = " + String(lvl_Convenio))

If Trim(lvs_Descricao) <> "" Then
	This.of_AppendWhere("condicao_venda_convenio.de_condicao_convenio like '" + lvs_Descricao + "%'")
End If

If is_Somente_Ativas = "S" Then
	This.of_AppendWhere("relacao_condicao_convenio.id_ativa = 'S'")
End If

Return 1
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge006_selecao_condicao_convenio
integer x = 1266
end type

event cb_selecionar::clicked;call super::clicked;Long lvl_Linha

String lvs_Condicao_Venda

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	lvs_Condicao_Venda = String(dw_2.Object.Cd_Condicao_Convenio[lvl_Linha])
	CloseWithReturn(Parent, lvs_Condicao_Venda)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma condi$$HEX2$$e700e300$$ENDHEX$$o de venda.", Information!, Ok!)
	dw_2.SetFocus()
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge006_selecao_condicao_convenio
integer x = 1659
end type

event cb_cancelar::clicked;call super::clicked;String lvs_Conveniado

SetNull(lvs_Conveniado)

CloseWithReturn(Parent, lvs_Conveniado)
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge006_selecao_condicao_convenio
integer x = 864
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge006_selecao_condicao_convenio
integer y = 1328
integer width = 809
end type

