HA$PBExportHeader$dc_w_inicial.srw
forward
global type dc_w_inicial from window
end type
type dw_1 from datawindow within dc_w_inicial
end type
end forward

global type dc_w_inicial from window
integer x = 215
integer y = 220
integer width = 2354
integer height = 1320
windowtype windowtype = popup!
long backcolor = 79741120
dw_1 dw_1
end type
global dc_w_inicial dc_w_inicial

type variables
Private:
uo_windows_version ivo_SO
end variables

on dc_w_inicial.create
this.dw_1=create dw_1
this.Control[]={this.dw_1}
end on

on dc_w_inicial.destroy
destroy(this.dw_1)
end on

event open;X = 650
Y = 550


String lvs_Versao
String lvs_version
String lvs_edition
String lvs_csd
Integer lvi_OS_Version

lvs_Versao = "Vers$$HEX1$$e300$$ENDHEX$$o " + gvo_Aplicacao.ivs_Versao + &
             " de " + String(gvo_Aplicacao.ivdt_Data_Versao, "dd/mm/yyyy")

ivo_SO.of_GetOSVersion(lvi_OS_Version, lvs_version, lvs_edition, lvs_csd)

dw_1.InsertRow(0)

dw_1.Object.Nome  	[1] = gvo_Aplicacao.iapp_Aplicacao.DisplayName
dw_1.Object.Versao	[1] = lvs_Versao
dw_1.Object.So		[1] = lvs_version+" - "+lvs_edition+" - "+lvs_csd+ " - "+String(ivo_SO.of_GetOSBits())+"bits"
end event

type dw_1 from datawindow within dc_w_inicial
integer width = 2354
integer height = 1320
integer taborder = 10
string dataobject = "dc_dw_inicial"
boolean border = false
boolean livescroll = true
end type

