HA$PBExportHeader$dc_w_inicial.srw
forward
global type dc_w_inicial from Window
end type
type dw_1 from datawindow within dc_w_inicial
end type
end forward

global type dc_w_inicial from Window
int X=215
int Y=220
int Width=2354
int Height=1320
long BackColor=79741120
WindowType WindowType=popup!
dw_1 dw_1
end type
global dc_w_inicial dc_w_inicial

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

lvs_Versao = "Vers$$HEX1$$e300$$ENDHEX$$o " + gvo_Aplicacao.ivs_Versao + &
             " de " + String(gvo_Aplicacao.ivdt_Data_Versao, "dd/mm/yyyy")

dw_1.InsertRow(0)

dw_1.Object.Nome  [1] = gvo_Aplicacao.iapp_Aplicacao.DisplayName
dw_1.Object.Versao[1] = lvs_Versao
end event

type dw_1 from datawindow within dc_w_inicial
int Width=2354
int Height=1320
int TabOrder=10
string DataObject="dc_dw_inicial"
boolean Border=false
boolean LiveScroll=true
end type

