HA$PBExportHeader$w_ge001_aguarde.srw
forward
global type w_ge001_aguarde from Window
end type
type uo_progress from uo_progressbar within w_ge001_aguarde
end type
end forward

global type w_ge001_aguarde from Window
int X=974
int Y=1228
int Width=1865
int Height=368
boolean TitleBar=true
string Title="Aguarde ..."
long BackColor=79741120
boolean MinBox=true
WindowType WindowType=popup!
uo_progress uo_progress
end type
global w_ge001_aguarde w_ge001_aguarde

on w_ge001_aguarde.create
this.uo_progress=create uo_progress
this.Control[]={this.uo_progress}
end on

on w_ge001_aguarde.destroy
destroy(this.uo_progress)
end on

type uo_progress from uo_progressbar within w_ge001_aguarde
int X=37
int Y=44
int Height=200
int TabOrder=10
boolean Border=false
BorderStyle BorderStyle=StyleBox!
long BackColor=79741120
end type

on uo_progress.destroy
call uo_progressbar::destroy
end on

