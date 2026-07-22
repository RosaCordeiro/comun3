HA$PBExportHeader$uo_grafico_menor.sru
forward
global type uo_grafico_menor from uo_grafico
end type
type st_titulo from statictext within uo_grafico_menor
end type
end forward

global type uo_grafico_menor from uo_grafico
integer width = 695
integer height = 492
st_titulo st_titulo
end type
global uo_grafico_menor uo_grafico_menor

type variables

end variables

forward prototypes
public subroutine of_inicializa ()
public subroutine of_settitulo (string ps_titulo)
public subroutine of_ativa_titulo (boolean pb_ativo)
end prototypes

public subroutine of_inicializa ();ivdc_Minimo = 0
ivdc_Maximo = 200
ivdc_Valor = 0
Margem_X = 50
Margem_Y = 20

st_titulo.Visible = False

of_setvalor(ivdc_Valor)
end subroutine

public subroutine of_settitulo (string ps_titulo);st_titulo.Text = ps_Titulo

st_titulo.Visible = True
end subroutine

public subroutine of_ativa_titulo (boolean pb_ativo);st_titulo.Visible = pb_ativo
end subroutine

on uo_grafico_menor.create
int iCurrent
call super::create
this.st_titulo=create st_titulo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_titulo
end on

on uo_grafico_menor.destroy
call super::destroy
destroy(this.st_titulo)
end on

type dw_grafico from uo_grafico`dw_grafico within uo_grafico_menor
integer y = 80
integer width = 686
integer height = 412
string dataobject = "dw_grafico_menor"
end type

type st_titulo from statictext within uo_grafico_menor
integer x = 5
integer y = 12
integer width = 686
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 553648127
string text = "T$$HEX1$$ed00$$ENDHEX$$tulo"
alignment alignment = center!
boolean focusrectangle = false
end type

event clicked;Parent.Event ue_clicked(0,0,0)
end event

