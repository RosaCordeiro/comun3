HA$PBExportHeader$w_ge510_monitor_interfaces.srw
forward
global type w_ge510_monitor_interfaces from dc_w_selecao_lista_relatorio
end type
type dw_4 from dc_uo_dw_base within w_ge510_monitor_interfaces
end type
type dw_5 from dc_uo_dw_base within w_ge510_monitor_interfaces
end type
type st_1 from statictext within w_ge510_monitor_interfaces
end type
type st_data from statictext within w_ge510_monitor_interfaces
end type
type st_2 from statictext within w_ge510_monitor_interfaces
end type
end forward

global type w_ge510_monitor_interfaces from dc_w_selecao_lista_relatorio
integer width = 5760
integer height = 2292
string title = "GE510 - Monitor Interfaces"
dw_4 dw_4
dw_5 dw_5
st_1 st_1
st_data st_data
st_2 st_2
end type
global w_ge510_monitor_interfaces w_ge510_monitor_interfaces

type variables
string is_id_ecommerce = '2'

end variables

forward prototypes
public subroutine wf_atualizar ()
end prototypes

public subroutine wf_atualizar ();dw_2.event ue_retrieve()
dw_4.event ue_retrieve()
dw_5.event ue_retrieve()

st_data.text = String( gf_getserverdate() , 'dd/mm/yyyy hh:mm' )
end subroutine

on w_ge510_monitor_interfaces.create
int iCurrent
call super::create
this.dw_4=create dw_4
this.dw_5=create dw_5
this.st_1=create st_1
this.st_data=create st_data
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_4
this.Control[iCurrent+2]=this.dw_5
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_data
this.Control[iCurrent+5]=this.st_2
end on

on w_ge510_monitor_interfaces.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_4)
destroy(this.dw_5)
destroy(this.st_1)
destroy(this.st_data)
destroy(this.st_2)
end on

event ue_postopen;call super::ue_postopen;
wf_atualizar()

//Timer(60)
end event

event timer;call super::timer;wf_atualizar()
end event

event open;call super::open;Timer(180)
end event

event key;call super::key;if key = KeyF5! Then
	wf_atualizar()
end if
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge510_monitor_interfaces
integer x = 1047
integer y = 2132
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge510_monitor_interfaces
integer x = 1010
integer y = 2060
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge510_monitor_interfaces
integer y = 248
integer width = 5655
integer height = 1828
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge510_monitor_interfaces
integer width = 5655
integer height = 220
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge510_monitor_interfaces
integer y = 96
integer height = 112
string dataobject = "dw_ge510_monitor_interface_selecao"
end type

event dw_1::itemchanged;if dwo.name = 'id_exibe_erro' then
	
	if data = 'S' then
		dw_2.setfilter('id_situacao = "E" or c_nivel_alerta < 3')
		dw_4.setfilter('id_situacao = "E" or c_nivel_alerta < 3')
		dw_5.setfilter('id_situacao = "E" or c_nivel_alerta < 3')
	else
		dw_2.setfilter('')
		dw_4.setfilter('')
		dw_5.setfilter('')
	end if
	
	dw_2.filter()
	dw_4.filter()
	dw_5.filter()
	
end if
end event

event dw_1::ue_key;call super::ue_key;if key = KeyF5! Then
	wf_atualizar()
end if
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge510_monitor_interfaces
integer y = 324
integer width = 1847
integer height = 1672
string dataobject = "dw_ge510_monitor_interface_lista"
boolean border = true
end type

event dw_2::buttonclicked;call super::buttonclicked;st_ge510_detalhes lst_parametros

if dwo.name = 'b_detalhes' then
	lst_parametros.cd_filial = this.object.cd_filial[row]
	lst_parametros.nr_atualizacao = this.object.nr_atualizacao_log[row]
	lst_parametros.cd_tipo = this.object.cd_tipo_log[row]
	
	OpenWithParm(w_ge510_monitor_interfaces_detalhe, lst_parametros)
	
end if
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;if dw_1.object.id_exibe_erro[1] = 'S' Then
	setfilter('id_situacao = "E" or c_nivel_alerta < 3')
else
	setfilter('')
end if
filter()

return pl_linhas
end event

event dw_2::ue_recuperar;return retrieve('DC', is_id_ecommerce)
end event

event dw_2::ue_key;call super::ue_key;if key = KeyF5! Then
	wf_atualizar()
end if
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge510_monitor_interfaces
boolean visible = false
integer x = 2181
integer y = 16
end type

type dw_4 from dc_uo_dw_base within w_ge510_monitor_interfaces
integer x = 1934
integer y = 324
integer width = 1847
integer height = 1672
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge510_monitor_interface_lista"
boolean vscrollbar = true
boolean border = true
end type

event buttonclicked;call super::buttonclicked;st_ge510_detalhes lst_parametros

if dwo.name = 'b_detalhes' then
	lst_parametros.cd_filial = this.object.cd_filial[row]
	lst_parametros.nr_atualizacao = this.object.nr_atualizacao_log[row]
	lst_parametros.cd_tipo = this.object.cd_tipo_log[row]
	
	OpenWithParm(w_ge510_monitor_interfaces_detalhe, lst_parametros)
	
end if
end event

event ue_postretrieve;call super::ue_postretrieve;if dw_1.object.id_exibe_erro[1] = 'S' Then
	setfilter('id_situacao = "E" or c_nivel_alerta < 3')
else
	setfilter('')
end if
filter()

return pl_linhas
end event

event ue_recuperar;return retrieve('PP', is_id_ecommerce)
end event

event ue_key;call super::ue_key;if key = KeyF5! Then
	wf_atualizar()
end if
end event

type dw_5 from dc_uo_dw_base within w_ge510_monitor_interfaces
integer x = 3799
integer y = 324
integer width = 1847
integer height = 1672
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge510_monitor_interface_lista"
boolean vscrollbar = true
boolean border = true
end type

event buttonclicked;call super::buttonclicked;st_ge510_detalhes lst_parametros

if dwo.name = 'b_detalhes' then
	lst_parametros.cd_filial = this.object.cd_filial[row]
	lst_parametros.nr_atualizacao = this.object.nr_atualizacao_log[row]
	lst_parametros.cd_tipo = this.object.cd_tipo_log[row]
	
	OpenWithParm(w_ge510_monitor_interfaces_detalhe, lst_parametros)
	
end if
end event

event ue_postretrieve;call super::ue_postretrieve;if dw_1.object.id_exibe_erro[1] = 'S' Then
	setfilter('id_situacao = "E" or c_nivel_alerta < 3')
else
	setfilter('')
end if
filter()

return pl_linhas
end event

event ue_recuperar;return retrieve('FA', is_id_ecommerce)
end event

event ue_key;call super::ue_key;if key = KeyF5! Then
	wf_atualizar()
end if
end event

type st_1 from statictext within w_ge510_monitor_interfaces
integer x = 4686
integer y = 164
integer width = 471
integer height = 52
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "$$HEX1$$da00$$ENDHEX$$ltima Atualiza$$HEX2$$e700e300$$ENDHEX$$o:"
boolean focusrectangle = false
end type

type st_data from statictext within w_ge510_monitor_interfaces
integer x = 5161
integer y = 164
integer width = 498
integer height = 48
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

type st_2 from statictext within w_ge510_monitor_interfaces
integer x = 105
integer y = 2004
integer width = 608
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "<F5> para atualizar"
boolean focusrectangle = false
end type

