HA$PBExportHeader$uo_ge510_monitor_ifood.sru
forward
global type uo_ge510_monitor_ifood from userobject
end type
type dw_2 from dc_uo_dw_base within uo_ge510_monitor_ifood
end type
type dw_1 from dc_uo_dw_base within uo_ge510_monitor_ifood
end type
end forward

global type uo_ge510_monitor_ifood from userobject
integer width = 1321
integer height = 1680
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event type long ue_key ( keycode key,  unsignedlong keyflag )
dw_2 dw_2
dw_1 dw_1
end type
global uo_ge510_monitor_ifood uo_ge510_monitor_ifood

forward prototypes
public function boolean of_carrega_interface (string ps_id_ecommerce, long pl_cd_interface, ref string ps_log)
public function boolean of_filtro (string ps_filtro)
public subroutine of_ajusta_tamanho ()
end prototypes

public function boolean of_carrega_interface (string ps_id_ecommerce, long pl_cd_interface, ref string ps_log);
dw_1.retrieve( ps_id_ecommerce, pl_cd_interface )
dw_2.retrieve( ps_id_ecommerce, pl_cd_interface )


return true
end function

public function boolean of_filtro (string ps_filtro);
dw_1.setfilter(ps_filtro)
dw_1.filter()

return true
end function

public subroutine of_ajusta_tamanho ();dw_1.height = this.height - dw_2.height
dw_1.width = this.width
end subroutine

on uo_ge510_monitor_ifood.create
this.dw_2=create dw_2
this.dw_1=create dw_1
this.Control[]={this.dw_2,&
this.dw_1}
end on

on uo_ge510_monitor_ifood.destroy
destroy(this.dw_2)
destroy(this.dw_1)
end on

event constructor;dw_1.settransobject(SQLCA)

post of_ajusta_tamanho()
end event

type dw_2 from dc_uo_dw_base within uo_ge510_monitor_ifood
integer width = 1317
integer height = 264
string dataobject = "dw_ge510_monitor_ifood_lista_cab"
end type

event ue_key;call super::ue_key;return parent.event ue_key(key, keyflags)
end event

type dw_1 from dc_uo_dw_base within uo_ge510_monitor_ifood
integer y = 272
integer width = 1317
integer height = 1392
string dataobject = "dw_ge510_monitor_ifood_lista"
boolean vscrollbar = true
end type

event buttonclicked;call super::buttonclicked;st_ge510_detalhes lst_parametros

if dwo.name = 'b_detalhes' then
	lst_parametros.cd_filial = this.object.cd_filial[row]
	lst_parametros.nr_atualizacao = this.object.nr_atualizacao_log[row]
	lst_parametros.cd_tipo = this.object.cd_tipo_log[row]
	
	OpenWithParm(w_ge510_monitor_interfaces_detalhe, lst_parametros)
	
end if
end event

event ue_key;call super::ue_key;return parent.event ue_key(key, keyflags)
end event

