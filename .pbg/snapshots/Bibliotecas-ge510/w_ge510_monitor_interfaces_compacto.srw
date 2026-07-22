HA$PBExportHeader$w_ge510_monitor_interfaces_compacto.srw
forward
global type w_ge510_monitor_interfaces_compacto from dc_w_lista_relatorio
end type
type dw_4 from dc_uo_dw_base within w_ge510_monitor_interfaces_compacto
end type
type dw_3 from dc_uo_dw_base within w_ge510_monitor_interfaces_compacto
end type
type st_1 from statictext within w_ge510_monitor_interfaces_compacto
end type
type st_data from statictext within w_ge510_monitor_interfaces_compacto
end type
end forward

global type w_ge510_monitor_interfaces_compacto from dc_w_lista_relatorio
integer width = 4850
integer height = 936
string title = "GE510 - Monitor Interfaces"
boolean maxbox = true
boolean resizable = false
dw_4 dw_4
dw_3 dw_3
st_1 st_1
st_data st_data
end type
global w_ge510_monitor_interfaces_compacto w_ge510_monitor_interfaces_compacto

forward prototypes
public subroutine wf_atualizar ()
end prototypes

public subroutine wf_atualizar ();dw_1.event ue_retrieve()
dw_4.event ue_retrieve()
dw_3.event ue_retrieve()

st_data.text = String( gf_getserverdate() , 'dd/mm/yyyy hh:mm' )
end subroutine

on w_ge510_monitor_interfaces_compacto.create
int iCurrent
call super::create
this.dw_4=create dw_4
this.dw_3=create dw_3
this.st_1=create st_1
this.st_data=create st_data
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_4
this.Control[iCurrent+2]=this.dw_3
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_data
end on

on w_ge510_monitor_interfaces_compacto.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_4)
destroy(this.dw_3)
destroy(this.st_1)
destroy(this.st_data)
end on

event open;call super::open;integer li_width, li_height

gvo_aplicacao.of_retorna_resolucao_monitor( ref li_width, ref li_height)

Timer(60)

this.y = (dc_w_mdi.height * 0.85) - this.height

end event

event ue_postopen;call super::ue_postopen;wf_atualizar()

//this.y = (dc_w_mdi.y / 4)
end event

type dw_visual from dc_w_lista_relatorio`dw_visual within w_ge510_monitor_interfaces_compacto
end type

type gb_aux_visual from dc_w_lista_relatorio`gb_aux_visual within w_ge510_monitor_interfaces_compacto
end type

type dw_1 from dc_w_lista_relatorio`dw_1 within w_ge510_monitor_interfaces_compacto
integer y = 80
integer width = 1545
integer height = 608
string dataobject = "dw_ge510_monitor_interface_comp_lista"
boolean border = true
end type

event dw_1::buttonclicked;call super::buttonclicked;st_ge510_detalhes lst_parametros

if dwo.name = 'b_detalhes' then
	lst_parametros.cd_filial = this.object.cd_filial[row]
	lst_parametros.nr_atualizacao = this.object.nr_atualizacao_log[row]
	lst_parametros.cd_tipo = this.object.cd_tipo_log[row]
	
	OpenWithParm(w_ge510_monitor_interfaces_detalhe, lst_parametros)
	
end if
end event

event dw_1::ue_recuperar;//Rede DC
Return This.Retrieve(986)
end event

type gb_1 from dc_w_lista_relatorio`gb_1 within w_ge510_monitor_interfaces_compacto
integer width = 4759
integer height = 748
end type

type dw_2 from dc_w_lista_relatorio`dw_2 within w_ge510_monitor_interfaces_compacto
boolean visible = false
end type

type dw_4 from dc_uo_dw_base within w_ge510_monitor_interfaces_compacto
integer x = 3209
integer y = 80
integer width = 1545
integer height = 608
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_ge510_monitor_interface_comp_lista"
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

event ue_recuperar;//Rede FA
Return This.Retrieve(809)
end event

type dw_3 from dc_uo_dw_base within w_ge510_monitor_interfaces_compacto
integer x = 1646
integer y = 80
integer width = 1545
integer height = 608
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge510_monitor_interface_comp_lista"
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

event ue_recuperar;//Rede PP
Return This.Retrieve(318)
end event

type st_1 from statictext within w_ge510_monitor_interfaces_compacto
integer x = 78
integer y = 692
integer width = 471
integer height = 56
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long backcolor = 67108864
string text = "$$HEX1$$da00$$ENDHEX$$ltima atualiza$$HEX2$$e700e300$$ENDHEX$$o:"
boolean focusrectangle = false
end type

type st_data from statictext within w_ge510_monitor_interfaces_compacto
integer x = 535
integer y = 692
integer width = 567
integer height = 52
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long backcolor = 67108864
boolean focusrectangle = false
end type

