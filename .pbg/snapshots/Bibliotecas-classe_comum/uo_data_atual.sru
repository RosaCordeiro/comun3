HA$PBExportHeader$uo_data_atual.sru
forward
global type uo_data_atual from userobject
end type
type st_data from statictext within uo_data_atual
end type
type st_1 from statictext within uo_data_atual
end type
end forward

global type uo_data_atual from userobject
integer width = 475
integer height = 88
long backcolor = 67108864
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
st_data st_data
st_1 st_1
end type
global uo_data_atual uo_data_atual

type variables
uo_timer iuo_timer

datetime idh_data_atual

boolean ib_Ativado = True
end variables

forward prototypes
public subroutine of_iniciar ()
public subroutine of_atualizar ()
end prototypes

public subroutine of_iniciar ();idh_data_atual = gf_getserverdate()

st_data.text = String(idh_data_atual, 'dd/mm/yyyy hh:mm')

iuo_timer = create uo_timer
iuo_timer.iuo_parent = This
iuo_timer.Start(60)
end subroutine

public subroutine of_atualizar ();long ll_dia, ll_mes, ll_ano
time lt_time, lt_time_antes
date ldt_data

lt_time_antes = time(idh_data_atual)

if String(lt_time_antes,'hh:mm') = '23:59' Then
	
	lt_time = Time('00:00')
	ldt_data = RelativeDate(date(idh_data_atual),1)
	
Else
	lt_time = RelativeTime(lt_time_antes,60)
	ldt_data = date(idh_data_atual)
End if

idh_data_atual = datetime(ldt_data, lt_time)

st_data.text = String(idh_data_atual,'dd/mm/yyyy hh:mm')
end subroutine

on uo_data_atual.create
this.st_data=create st_data
this.st_1=create st_1
this.Control[]={this.st_data,&
this.st_1}
end on

on uo_data_atual.destroy
destroy(this.st_data)
destroy(this.st_1)
end on

event constructor;
if ib_Ativado = True Then of_iniciar()
end event

event destructor;
iuo_timer.Stop()
destroy(iuo_timer)
end event

type st_data from statictext within uo_data_atual
integer width = 462
integer height = 52
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "01/01/1900 00:00"
boolean focusrectangle = false
end type

type st_1 from statictext within uo_data_atual
integer width = 489
integer height = 84
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 553648127
boolean focusrectangle = false
end type

