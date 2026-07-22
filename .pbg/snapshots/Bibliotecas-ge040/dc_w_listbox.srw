HA$PBExportHeader$dc_w_listbox.srw
forward
global type dc_w_listbox from Window
end type
type lb_1 from listbox within dc_w_listbox
end type
end forward

global type dc_w_listbox from Window
int X=823
int Y=360
int Width=2048
int Height=1220
boolean TitleBar=true
string Title="Limpeza do Backup Anterior"
long BackColor=79741120
boolean ControlMenu=true
boolean MinBox=true
boolean MaxBox=true
boolean Resizable=true
WindowState WindowState=minimized!
lb_1 lb_1
end type
global dc_w_listbox dc_w_listbox

on dc_w_listbox.create
this.lb_1=create lb_1
this.Control[]={this.lb_1}
end on

on dc_w_listbox.destroy
destroy(this.lb_1)
end on

type lb_1 from listbox within dc_w_listbox
int X=32
int Y=32
int Width=1915
int Height=1024
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=33554432
int TextSize=-10
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

