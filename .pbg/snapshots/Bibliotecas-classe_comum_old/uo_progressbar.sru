HA$PBExportHeader$uo_progressbar.sru
forward
global type uo_progressbar from userobject
end type
type hpb_1 from hprogressbar within uo_progressbar
end type
type st_percentual from statictext within uo_progressbar
end type
end forward

global type uo_progressbar from userobject
integer width = 1778
integer height = 216
boolean border = true
long backcolor = 67108864
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event ue_atualiza_tela ( )
hpb_1 hpb_1
st_percentual st_percentual
end type
global uo_progressbar uo_progressbar

type variables
Double ivl_Divisor = 1
Long ivl_Max = 30000


end variables

forward prototypes
public subroutine of_setmax (long lvl_max)
public subroutine of_setprogress (long lvl_progress)
public subroutine of_setstart ()
public subroutine of_reset ()
end prototypes

public subroutine of_setmax (long lvl_max);if lvl_max > ivl_Max Then
	ivl_Divisor = lvl_max / ivl_Max
	hpb_1.Maxposition = ivl_max
Else
	hpb_1.Maxposition = lvl_max
End If


end subroutine

public subroutine of_setprogress (long lvl_progress);Integer lvi_Percentual_Atual

lvi_Percentual_Atual   = Integer( ( (lvl_Progress / ivl_Divisor) /  hpb_1.maxposition ) * 100 )

hpb_1.position = Integer(lvl_progress / ivl_Divisor)

st_Percentual.Text = String(lvi_Percentual_Atual) + "%"

//Yield()
This.Event ue_atualiza_tela()
end subroutine

public subroutine of_setstart ();hpb_1.Position = 0
st_Percentual.Text = "0 %"

This.Event ue_atualiza_tela()
end subroutine

public subroutine of_reset ();st_Percentual.Text = "0 %"
hpb_1.Position = 0

This.Event ue_atualiza_tela()
end subroutine

on uo_progressbar.create
this.hpb_1=create hpb_1
this.st_percentual=create st_percentual
this.Control[]={this.hpb_1,&
this.st_percentual}
end on

on uo_progressbar.destroy
destroy(this.hpb_1)
destroy(this.st_percentual)
end on

event constructor;//sle_Progresso.Width = 0
hpb_1.Maxposition = 0
end event

type hpb_1 from hprogressbar within uo_progressbar
integer x = 37
integer y = 20
integer width = 1687
integer height = 92
unsignedinteger maxposition = 100
unsignedinteger position = 50
integer setstep = 10
end type

type st_percentual from statictext within uo_progressbar
integer x = 759
integer y = 124
integer width = 247
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 79741120
boolean enabled = false
string text = "0 %"
alignment alignment = center!
boolean focusrectangle = false
end type

