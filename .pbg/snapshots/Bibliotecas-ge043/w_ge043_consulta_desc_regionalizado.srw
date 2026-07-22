HA$PBExportHeader$w_ge043_consulta_desc_regionalizado.srw
forward
global type w_ge043_consulta_desc_regionalizado from dc_w_consulta_lista
end type
type dw_2 from dc_uo_dw_base within w_ge043_consulta_desc_regionalizado
end type
end forward

global type w_ge043_consulta_desc_regionalizado from dc_w_consulta_lista
integer width = 3474
integer height = 1888
string title = "GE043 - Consulta de Descontos Regionalizados"
dw_2 dw_2
end type
global w_ge043_consulta_desc_regionalizado w_ge043_consulta_desc_regionalizado

on w_ge043_consulta_desc_regionalizado.create
int iCurrent
call super::create
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
end on

on w_ge043_consulta_desc_regionalizado.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_2)
end on

event ue_postopen;call super::ue_postopen;This.ivm_Menu.ivb_Permite_Imprimir = True
end event

event ue_print;call super::ue_print;dw_2.Event ue_Print()
end event

event ue_printimmediate;call super::ue_printimmediate;dw_2.Event ue_Print()
end event

type dw_1 from dc_w_consulta_lista`dw_1 within w_ge043_consulta_desc_regionalizado
integer y = 64
integer width = 3291
integer height = 1596
string dataobject = "dw_ge043_lista"
end type

event dw_1::ue_recuperar;//OverRide

Long ll_Linha, ll_Filial
String	ls_Datahoje

ll_Filial 			= gvo_parametro.of_filial()
ls_Datahoje  	= String(Today(), "YYYYMMDD")	

ll_linha     = This.Retrieve(ll_Filial, ls_Datahoje)

THIS.ShareData(dw_2)

Return ll_Linha
end event

event dw_1::constructor;call super::constructor;This.of_SetRowSelection()
end event

type gb_1 from dc_w_consulta_lista`gb_1 within w_ge043_consulta_desc_regionalizado
integer width = 3369
integer height = 1672
end type

type dw_2 from dc_uo_dw_base within w_ge043_consulta_desc_regionalizado
integer x = 119
integer y = 840
integer width = 1339
integer height = 668
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge043_relatorio"
end type

