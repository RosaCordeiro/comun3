HA$PBExportHeader$w_ge064_selecao_dependente.srw
forward
global type w_ge064_selecao_dependente from dc_w_response_ok_cancela
end type
end forward

global type w_ge064_selecao_dependente from dc_w_response_ok_cancela
integer width = 1440
integer height = 1044
string title = "GE064 - Sele$$HEX2$$e700e300$$ENDHEX$$o de Dependente"
end type
global w_ge064_selecao_dependente w_ge064_selecao_dependente

type variables
String ivs_dependentes
end variables

forward prototypes
public subroutine wf_carrega_dependentes ()
end prototypes

public subroutine wf_carrega_dependentes ();//String lvs_dependentes
//
//Long lvi_row, lvi_inicio 
//
//lvs_dependentes  = Upper(Message.StringParm)
//
//For lvi_inicio = 1 To LenA(lvs_dependentes)
//	lvi_Row = dw_1.InsertRow(0)
//	dw_1.object.dependente[lvi_row] = LeftA(lvs_dependentes,24)
//	lvs_dependentes = MidA(lvs_dependentes, 25)
//Next
//
//SetPointer(Arrow!)
end subroutine

on w_ge064_selecao_dependente.create
call super::create
end on

on w_ge064_selecao_dependente.destroy
call super::destroy
end on

event ue_postopen;//OverRide

Long lvi_row, lvi_inicio 

For lvi_inicio = 1 To LenA(ivs_dependentes)
	lvi_Row = dw_1.InsertRow(0)
	dw_1.object.dependente[lvi_row] = LeftA(ivs_dependentes,24)
	ivs_dependentes = MidA(ivs_dependentes, 25)
Next

dw_1.setfocus( )
dw_1.of_setrowselection( )
end event

event ue_preopen;call super::ue_preopen;ivs_dependentes  = Upper(Message.StringParm)
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge064_selecao_dependente
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge064_selecao_dependente
integer width = 1385
integer height = 752
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge064_selecao_dependente
integer width = 1312
integer height = 632
string dataobject = "dw_ge064_lista_dependetes"
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge064_selecao_dependente
integer x = 754
integer y = 808
end type

event cb_ok::clicked;call super::clicked;String lvs_dependente

lvs_dependente = dw_1.object.dependente[dw_1.GetRow()]

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Confirma sele$$HEX2$$e700e300$$ENDHEX$$o do dependente " + lvs_dependente + "?",Question!,YesNo!,1) = 1 Then 
	CloseWithReturn(Parent, lvs_dependente)
Else
	Return -1
End If
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge064_selecao_dependente
integer x = 1088
integer y = 808
end type

event cb_cancelar::clicked;//OverRide
CloseWithReturn(Parent, 'CANCELAR')
end event

