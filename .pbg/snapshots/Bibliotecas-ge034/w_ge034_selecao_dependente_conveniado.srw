HA$PBExportHeader$w_ge034_selecao_dependente_conveniado.srw
forward
global type w_ge034_selecao_dependente_conveniado from dc_w_selecao_generica
end type
end forward

global type w_ge034_selecao_dependente_conveniado from dc_w_selecao_generica
integer x = 379
integer width = 2885
integer height = 1528
string title = "GE034 - Sele$$HEX2$$e700e300$$ENDHEX$$o de Dependentes de Conveniados"
end type
global w_ge034_selecao_dependente_conveniado w_ge034_selecao_dependente_conveniado

type variables
uo_dependente_conveniado ivo_dependente
end variables

on w_ge034_selecao_dependente_conveniado.create
call super::create
end on

on w_ge034_selecao_dependente_conveniado.destroy
call super::destroy
end on

event open;call super::open;String lvs_DataObject

SetPointer(HourGlass!)

If gvo_parametro.cd_filial <> gvo_parametro.cd_filial_matriz Then 
	lvs_DataObject = "dw_ge034_lista_filial"
Else
	lvs_DataObject = "dw_ge034_lista_matriz"
End If

dw_2.of_ChangeDataObject(lvs_DataObject)
dw_2.of_SetRowSelection()

uo_Convenio   lvo_Convenio
uo_Conveniado lvo_Conveniado

lvo_Convenio   = Create uo_Convenio
lvo_Conveniado = Create uo_Conveniado
ivo_Dependente = Create uo_Dependente_Conveniado

ivo_Dependente = Message.PowerObjectParm

dw_1.Object.Cd_Convenio[1]   = ivo_Dependente.ivl_Convenio
dw_1.Object.Cd_Conveniado[1] = ivo_Dependente.ivs_Conveniado

// Recupera o nome do conv$$HEX1$$ea00$$ENDHEX$$nio
lvo_Convenio.of_Localiza_Codigo(ivo_Dependente.ivl_Convenio)

If lvo_Convenio.Localizado Then dw_1.Object.Nm_Fantasia[1] = lvo_Convenio.Nm_Fantasia
	
// Recupera o nome do conveniado
lvo_Conveniado.of_Localiza_Codigo(ivo_Dependente.ivl_Convenio, ivo_Dependente.ivs_Conveniado)
If lvo_Conveniado.Localizado Then dw_1.Object.Nm_Conveniado[1] = lvo_Conveniado.Nm_Conveniado

If Trim(ivo_Dependente.ivs_Dependente) <> "" Then
	dw_1.Object.Nm_Dependente[1] = ivo_Dependente.ivs_Dependente
End If

ivb_Pesquisa_Direta = True
	
Destroy(lvo_Convenio)
Destroy(lvo_Conveniado)

SetPointer(Arrow!)
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge034_selecao_dependente_conveniado
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge034_selecao_dependente_conveniado
integer x = 18
integer y = 356
integer width = 2821
integer height = 936
long backcolor = 80269524
string text = "Lista de Dependentes"
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge034_selecao_dependente_conveniado
integer x = 18
integer y = 4
integer width = 2258
integer height = 336
long backcolor = 80269524
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge034_selecao_dependente_conveniado
integer x = 37
integer y = 68
integer width = 2213
integer height = 252
string dataobject = "dw_ge034_selecao"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge034_selecao_dependente_conveniado
integer x = 46
integer y = 408
integer width = 2770
integer height = 860
string dataobject = "dw_ge034_lista_matriz"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Dependente

dw_1.AcceptText()
lvs_Dependente = dw_1.Object.Nm_Dependente[1]

If Not IsNull(lvs_Dependente) and Trim(lvs_Dependente) <> "" Then
	This.of_AppendWhere("nm_dependente like '" + lvs_Dependente + "%'")
End If

Return 1
end event

event dw_2::ue_recuperar;// OVERRIDE

Long lvl_Convenio
String lvs_Conveniado

lvl_Convenio 	= dw_1.Object.Cd_Convenio[1]
lvs_Conveniado = dw_1.Object.Cd_Conveniado[1]

Return This.Retrieve(lvl_Convenio, lvs_Conveniado)
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge034_selecao_dependente_conveniado
integer x = 2075
end type

event cb_selecionar::clicked;call super::clicked;Long lvl_Linha, &
     lvl_Dependente

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	lvl_Dependente = dw_2.Object.Cd_Dependente[lvl_Linha]
	CloseWithReturn(Parent, String(lvl_Dependente))
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um dependente na lista.", Information!)
	dw_2.SetFocus()
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge034_selecao_dependente_conveniado
integer x = 2469
end type

event cb_cancelar::clicked;call super::clicked;String lvs_Dependente

SetNull(lvs_Dependente)
CloseWithReturn(Parent, lvs_Dependente)
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge034_selecao_dependente_conveniado
integer x = 1550
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge034_selecao_dependente_conveniado
integer x = 37
integer y = 1328
long backcolor = 80269524
end type

