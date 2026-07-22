HA$PBExportHeader$w_ge252_ajuste_protocolo.srw
forward
global type w_ge252_ajuste_protocolo from dc_w_base
end type
type cb_2 from commandbutton within w_ge252_ajuste_protocolo
end type
type cb_1 from commandbutton within w_ge252_ajuste_protocolo
end type
type dw_1 from dc_uo_dw_base within w_ge252_ajuste_protocolo
end type
type gb_1 from groupbox within w_ge252_ajuste_protocolo
end type
end forward

global type w_ge252_ajuste_protocolo from dc_w_base
integer width = 1609
integer height = 960
string title = "GE252 - Altera$$HEX2$$e700e300$$ENDHEX$$o/Inclus$$HEX1$$e300$$ENDHEX$$o de Protocolo"
boolean controlmenu = false
boolean minbox = false
boolean resizable = false
windowtype windowtype = response!
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
gb_1 gb_1
end type
global w_ge252_ajuste_protocolo w_ge252_ajuste_protocolo

type variables
st_parametros_protocolo	ist_Parametros

String								is_Perfumaria, is_Vencido_Danificado
end variables

forward prototypes
public function boolean wf_valida_campos (long al_qtde, string as_protocolo, long al_motivo)
end prototypes

public function boolean wf_valida_campos (long al_qtde, string as_protocolo, long al_motivo);If IsNull (al_Qtde) or al_Qtde <= 0 then
	MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Informe a quantidade.')
	dw_1.Event ue_Pos (1, 'qt_movto')
	Return False
End if

If al_qtde > ist_parametros.qtd_lote then
	MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'A quantidade a acrescentar no protocolo n$$HEX1$$e300$$ENDHEX$$o pode ser maior que o saldo no endere$$HEX1$$e700$$ENDHEX$$o!')
	dw_1.Event ue_Pos (1, 'qt_movto')
	Return False
End if

If IsNull (as_protocolo) or Len (as_protocolo) = 0 or Trim (as_protocolo) = '' then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Informe o n$$HEX1$$fa00$$ENDHEX$$mero do protocolo.')
	dw_1.Event ue_Pos (1, 'nr_protocolo')
	Return False
 End if

If IsNull (al_motivo) then
	MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Informe o motivo do protocolo!')
	dw_1.Event ue_Pos (1,'cd_defeito')
	Return False
End if

Return True
end function

on w_ge252_ajuste_protocolo.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.gb_1
end on

on w_ge252_ajuste_protocolo.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event open;call super::open;ist_Parametros = Message.PowerObjectParm

dw_1.Event ue_AddRow ()

dw_1.Object.cd_produto  [1] = ist_Parametros.cd_produto
dw_1.Object.de_produto  [1] = ist_Parametros.de_produto
dw_1.Object.nr_lote     [1] = ist_Parametros.nr_lote
dw_1.Object.dh_validade [1] = ist_Parametros.dh_validade
dw_1.Object.qt_saldo    [1] = ist_Parametros.qtd_lote
end event

event ue_postopen;call super::ue_postopen;DataWindowChild	ldwc_aux

If dw_1.GetChild ('nr_protocolo', ldwc_aux) < 1 then
	Messagebox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro no GetChild da lista de protocolos', StopSign!)
	cb_1.Post Event Clicked ()
End if

ldwc_aux.SetTransObject (SQLCA)

If ldwc_aux.Retrieve (ist_parametros.cd_produto, ist_parametros.nr_lote) < 0 then
	Messagebox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro na leitura da lista de protocolos', StopSign!)
	cb_1.Post Event Clicked ()
End if
end event

type cb_2 from commandbutton within w_ge252_ajuste_protocolo
integer x = 928
integer y = 772
integer width = 311
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Confirmar"
end type

event clicked;String ls_Nr_Protocolo		

Long	ll_qt_movto, &
		ll_Motivo
		
dw_1.AcceptText()

ll_qt_movto     = dw_1.Object.qt_movto     [1]
ls_Nr_Protocolo = dw_1.Object.nr_protocolo [1]
ll_Motivo	    = dw_1.Object.cd_defeito   [1]

If Not wf_Valida_Campos (ll_qt_movto, ls_Nr_Protocolo , ll_Motivo) then Return 1

If Not gf_ge252_ajusta_protocolo (ist_parametros.cd_produto, ist_parametros.nr_lote, ls_Nr_Protocolo, ll_Motivo, ll_qt_movto, 'AJP') then
	SQLCA.of_RollBack ()
	Return 1
End if

SQLCA.of_Commit ()

ist_Parametros.qtd_lote      = ll_qt_movto
ist_Parametros.nr_protocolo  = ls_Nr_Protocolo
ist_Parametros.cd_motivo     = ll_Motivo
ist_Parametros.qtd_protocolo = ll_qt_movto

CloseWithReturn (Parent, ist_Parametros)
end event

type cb_1 from commandbutton within w_ge252_ajuste_protocolo
integer x = 1266
integer y = 772
integer width = 311
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Cancelar"
end type

event clicked;ist_Parametros.qtd_protocolo = -1

CloseWithReturn (Parent, ist_Parametros)
end event

type dw_1 from dc_uo_dw_base within w_ge252_ajuste_protocolo
integer x = 46
integer y = 76
integer width = 1509
integer height = 668
integer taborder = 20
string dataobject = "dw_ge252_ajuste_protocolo"
end type

event itemchanged;call super::itemchanged;DataWindowChild	ldwc_aux

Choose case dwo.Name
	case 'nr_protocolo'
		If This.GetChild ('cd_defeito', ldwc_aux) < 1 then
			Messagebox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro no GetChild da lista de motivos', StopSign!)
			cb_1.Post Event Clicked ()
		End if
		
		ldwc_aux.SetTransObject (SQLCA)
		
		If ldwc_aux.Retrieve (ist_parametros.cd_produto, ist_parametros.nr_lote, data) < 0 then
			Messagebox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro na leitura da lista de motivos', StopSign!)
			cb_1.Post Event Clicked ()
		End if
End choose
end event

type gb_1 from groupbox within w_ge252_ajuste_protocolo
integer x = 9
integer y = 8
integer width = 1577
integer height = 760
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Dados do Produto"
end type

