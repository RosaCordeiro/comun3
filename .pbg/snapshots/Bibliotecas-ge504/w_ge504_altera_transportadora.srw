HA$PBExportHeader$w_ge504_altera_transportadora.srw
forward
global type w_ge504_altera_transportadora from dc_w_response_ok_cancela
end type
end forward

global type w_ge504_altera_transportadora from dc_w_response_ok_cancela
integer width = 1545
integer height = 680
string title = "GE504 - Altera$$HEX2$$e700e300$$ENDHEX$$o de Modalidade de Entrega"
end type
global w_ge504_altera_transportadora w_ge504_altera_transportadora

type variables
Long il_Pedido
Long il_Filial_EC

datawindowchild idwc_transp
end variables

on w_ge504_altera_transportadora.create
call super::create
end on

on w_ge504_altera_transportadora.destroy
call super::destroy
end on

event ue_postopen;call super::ue_postopen;dw_1.Event ue_Retrieve( )
end event

event open;call super::open;String ls_Parametro

ls_Parametro = Message.StringParm

il_Filial_EC	= Long(MID( ls_Parametro, 1, 4 ))
il_Pedido 	= Long(MID( ls_Parametro, 5 ))

dw_1.getchild('cd_tipo_entrega', idwc_transp)

idwc_transp.settransobject( SQLCA )
idwc_transp.retrieve()
idwc_transp.setfilter('cd_tipo_entrega <> 0')
idwc_transp.filter()
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge504_altera_transportadora
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge504_altera_transportadora
integer width = 1467
integer height = 428
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge504_altera_transportadora
integer y = 52
integer width = 1426
integer height = 364
string dataobject = "dw_ge504_altera_transportadora"
end type

event dw_1::ue_recuperar;// OverRide
Return This.Retrieve( il_Pedido, il_Filial_EC )
end event

event dw_1::itemchanged;call super::itemchanged;long ll_find
long ll_cd_tipo
string ls_nm_transportadora

if dwo.name = 'cd_tipo_entrega' then
	ll_cd_tipo = long(data)
	
	ll_find = idwc_transp.find('cd_tipo_entrega = ' + string(ll_cd_tipo), 1, idwc_transp.rowcount() )
	
	if ll_find > 0 Then
		ls_nm_transportadora = idwc_transp.getitemstring(ll_find, 'de_tipo_entrega')
		object.nm_transportadora[1] = ls_nm_transportadora
	end if
	
end if
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge504_altera_transportadora
integer x = 590
integer y = 468
integer width = 526
string text = "&Salvar Altera$$HEX2$$e700e300$$ENDHEX$$o"
end type

event cb_ok::clicked;call super::clicked;Long ll_Retorno

dw_1.accepttext( )

ll_retorno = dw_1.object.cd_tipo_entrega[1]

if ll_retorno = 0 or isnull(ll_retorno) then
	messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Selecione uma modalidade de entrega.')
	return -1
end if

CloseWithReturn(Parent, ll_Retorno)
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge504_altera_transportadora
integer x = 1179
integer y = 472
end type

event cb_cancelar::clicked;// OverRide
CloseWithReturn(Parent, 0) // 0 = OK
end event

