HA$PBExportHeader$uo_grafico.sru
forward
global type uo_grafico from userobject
end type
type dw_grafico from dc_uo_dw_base within uo_grafico
end type
end forward

global type uo_grafico from userobject
integer width = 1358
integer height = 668
long backcolor = 16777215
string text = "none"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
event doubleclicked pbm_lbuttondblclk
event ue_doubleclicked pbm_mbuttondblclk
event ue_clicked pbm_lbuttonclk
dw_grafico dw_grafico
end type
global uo_grafico uo_grafico

type variables
Decimal{2} ivdc_Minimo
Decimal{2} ivdc_Maximo
Decimal{2} ivdc_Valor

Long Margem_X
Long Margem_Y

end variables

forward prototypes
public subroutine of_setvalor (decimal pdc_valor)
public subroutine of_setminimo (decimal pdc_minimo)
public subroutine of_setmaximo (decimal pdc_maximo)
public subroutine of_inicializa ()
end prototypes

public subroutine of_setvalor (decimal pdc_valor);Long lvl_Altura 
Long lvl_Largura
Long lvl_X
Long lvl_Y

Double lvdc_Percentual
Double lvdc_Proporcao
Double lvdc_Pi
Double lvdc_Seno
Double lvdc_Cosseno
Double lvdc_Valor

lvl_Largura	= Long(dw_grafico.Object.p_1.Width) + 10
lvl_Altura  	= Long(dw_grafico.Object.p_1.Height) - 15

If pdc_valor > ivdc_Maximo  Then
	lvdc_Percentual = ivdc_Maximo
ElseIf ivdc_Minimo > pdc_valor Then
	lvdc_Percentual = ivdc_Minimo
Else
	lvdc_Percentual = pdc_valor
End If

lvdc_Proporcao =  ((lvdc_Percentual - ivdc_Minimo) / (ivdc_Maximo - ivdc_Minimo))

lvdc_Pi = PI(lvdc_Proporcao)

lvdc_Seno = Sin(lvdc_Pi)
lvdc_Cosseno = 0 - Cos(lvdc_Pi)

lvl_X = Round((lvl_Largura / 2) + (((lvl_Largura / 2) - Margem_X) * lvdc_Cosseno),0)

lvl_Y = Round((lvl_Altura) - ((lvl_Altura - Margem_Y) * lvdc_Seno),0)

dw_grafico.Object.l_1.X1 = lvl_X
dw_grafico.Object.l_1.Y1 = lvl_Y 
dw_grafico.Object.id_valor [1] = pdc_valor

ivdc_Valor = pdc_valor

Yield()
end subroutine

public subroutine of_setminimo (decimal pdc_minimo);ivdc_Minimo = pdc_minimo
end subroutine

public subroutine of_setmaximo (decimal pdc_maximo);ivdc_Maximo = pdc_maximo
end subroutine

public subroutine of_inicializa ();ivdc_Minimo = 0
ivdc_Maximo = 200
ivdc_Valor = 0
Margem_X = 100
Margem_Y = 40

dw_grafico.Object.id_valor [1] = ivdc_Valor
end subroutine

on uo_grafico.create
this.dw_grafico=create dw_grafico
this.Control[]={this.dw_grafico}
end on

on uo_grafico.destroy
destroy(this.dw_grafico)
end on

event constructor;dw_grafico.Event ue_AddRow()

This.of_inicializa()
end event

type dw_grafico from dc_uo_dw_base within uo_grafico
event doublecliked pbm_lbuttondblclk
integer y = 40
integer width = 1362
integer height = 616
string dataobject = "dw_grafico"
end type

event clicked;call super::clicked;Parent.Event ue_clicked(0,0,0)
end event

