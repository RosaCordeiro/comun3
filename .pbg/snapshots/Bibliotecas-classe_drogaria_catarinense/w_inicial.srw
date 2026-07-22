HA$PBExportHeader$w_inicial.srw
$PBExportComments$Janela de abertura dos sistemas
forward
global type w_inicial from w_popup
end type
type dw_1 from u_dw within w_inicial
end type
end forward

global type w_inicial from w_popup
int Width=2354
int Height=1320
boolean TitleBar=false
boolean ControlMenu=false
boolean MinBox=false
boolean MaxBox=false
boolean Resizable=false
dw_1 dw_1
end type
global w_inicial w_inicial

on w_inicial.create
int iCurrent
call super::create
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
end on

on w_inicial.destroy
call super::destroy
destroy(this.dw_1)
end on

event pfc_preopen;SetPointer(HourGlass!)

String lvs_versao
Date lvdt_data_versao

// Carrega as vari$$HEX1$$e100$$ENDHEX$$veis de nome do sistema, vers$$HEX1$$e300$$ENDHEX$$o e data

lvs_versao = gnv_app.of_GetVersion()
lvdt_data_versao = gnv_app.of_Le_Data_Versao()
lvs_versao = "Vers$$HEX1$$e300$$ENDHEX$$o " + lvs_versao + " de " + String(lvdt_data_versao, "dd/mm/yyyy")

dw_1.InsertRow(0)
dw_1.Object.nome[1] = gnv_app.iapp_object.DisplayName
dw_1.Object.versao[1] = lvs_versao
end event

event open;call super::open;SetPointer(HourGlass!)

X = 650
Y = 550

If This.title = gnv_app.iapp_object.DisplayName Then
	This.Title = ""
End If


end event

type dw_1 from u_dw within w_inicial
int X=0
int Y=0
int Width=2354
int Height=1320
int TabOrder=10
boolean BringToTop=true
string DataObject="dw_inicial"
BorderStyle BorderStyle=StyleRaised!
boolean VScrollBar=false
end type

event constructor;SetPointer(HourGlass!)

// Desmarca o flag de atualiza$$HEX2$$e700e300$$ENDHEX$$o da PFC

ib_isupdateable = False
end event

