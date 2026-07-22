HA$PBExportHeader$w_ge506_selecao_promocao_vencidos.srw
forward
global type w_ge506_selecao_promocao_vencidos from dc_w_response_ok_cancela
end type
type cb_alteracao from commandbutton within w_ge506_selecao_promocao_vencidos
end type
type uo_1 from uo_texto_paf within w_ge506_selecao_promocao_vencidos
end type
end forward

global type w_ge506_selecao_promocao_vencidos from dc_w_response_ok_cancela
integer x = 370
integer y = 476
integer width = 3205
integer height = 1452
string title = "GE506 - Selecione a promo$$HEX2$$e700e300$$ENDHEX$$o desejada:"
long backcolor = 80269524
cb_alteracao cb_alteracao
uo_1 uo_1
end type
global w_ge506_selecao_promocao_vencidos w_ge506_selecao_promocao_vencidos

type variables
Long ivl_Grupo
end variables

on w_ge506_selecao_promocao_vencidos.create
int iCurrent
call super::create
this.cb_alteracao=create cb_alteracao
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_alteracao
this.Control[iCurrent+2]=this.uo_1
end on

on w_ge506_selecao_promocao_vencidos.destroy
call super::destroy
destroy(this.cb_alteracao)
destroy(this.uo_1)
end on

event ue_postopen;// OVERRIDE

dw_1.Event ue_Retrieve()

dw_1.SetFocus()
end event

event open;call super::open;
This.ivl_Grupo = Long(Message.StringParm)

If gvo_Aplicacao.ivo_seguranca.cd_sistema = 'CL' Then
	This.uo_1.visible = True
Else
	This.uo_1.visible = False
End If
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge506_selecao_promocao_vencidos
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge506_selecao_promocao_vencidos
integer width = 3122
integer height = 1212
integer taborder = 0
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge506_selecao_promocao_vencidos
integer y = 52
integer width = 3045
integer height = 1132
integer taborder = 10
string dataobject = "dw_ge506_selecao"
boolean vscrollbar = true
end type

event dw_1::ue_recuperar;// OVERRIDE

Return This.Retrieve(Parent.ivl_Grupo)
end event

event dw_1::constructor;call super::constructor;This.ivb_Selecao_Linhas = True
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge506_selecao_promocao_vencidos
integer x = 2775
integer y = 1228
integer width = 370
integer taborder = 40
end type

event cb_ok::clicked;Long   ll_Linha

String ls_Retorno

ll_Linha = dw_1.GetRow()

If ll_Linha > 0 Then
	
	ls_Retorno = dw_1.object.cd_grupo[ll_Linha] + String(dw_1.object.pc_desconto[ll_Linha])
	
	CloseWithReturn(Parent,ls_Retorno)
	
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione a promo$$HEX2$$e700e300$$ENDHEX$$o desejada.", Information!)
End If
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge506_selecao_promocao_vencidos
integer x = 2391
integer y = 1228
integer width = 370
end type

event cb_cancelar::clicked;CloseWithReturn(Parent,"CANCELAR")
end event

type cb_alteracao from commandbutton within w_ge506_selecao_promocao_vencidos
integer x = 23
integer y = 1228
integer width = 562
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Altera$$HEX2$$e700e300$$ENDHEX$$o de Pre$$HEX1$$e700$$ENDHEX$$o"
boolean cancel = true
end type

event clicked;Boolean lb_Sucesso

String  ls_Liberacao

uo_Parametro_Filial lvo_Parametro
lvo_Parametro = Create uo_Parametro_Filial

lb_Sucesso = lvo_Parametro.of_Localiza_Parametro("ID_ALTERACAO_PRECO_CAIXA", ref ls_Liberacao )

Destroy(lvo_Parametro)

If Not lb_Sucesso Then Return

If ls_Liberacao = 'S' Then
	CloseWithReturn(Parent,"ALTERACAOPRECO")
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Altera$$HEX2$$e700e300$$ENDHEX$$o de pre$$HEX1$$e700$$ENDHEX$$o bloqueada para esta filial.",Exclamation!)	
End If	
end event

type uo_1 from uo_texto_paf within w_ge506_selecao_promocao_vencidos
integer x = 896
integer y = 1248
integer taborder = 50
boolean bringtotop = true
end type

on uo_1.destroy
call uo_texto_paf::destroy
end on

