HA$PBExportHeader$w_ge449_precificacao.srw
forward
global type w_ge449_precificacao from dc_w_response
end type
type cb_1 from commandbutton within w_ge449_precificacao
end type
type em_1 from editmask within w_ge449_precificacao
end type
type st_1 from statictext within w_ge449_precificacao
end type
type st_2 from statictext within w_ge449_precificacao
end type
type cb_2 from commandbutton within w_ge449_precificacao
end type
type cb_3 from commandbutton within w_ge449_precificacao
end type
end forward

global type w_ge449_precificacao from dc_w_response
integer width = 2437
integer height = 576
cb_1 cb_1
em_1 em_1
st_1 st_1
st_2 st_2
cb_2 cb_2
cb_3 cb_3
end type
global w_ge449_precificacao w_ge449_precificacao

forward prototypes
public subroutine wf_grava_resumo (date adt_parametro)
end prototypes

public subroutine wf_grava_resumo (date adt_parametro);uo_ge449_precificacao_resumo lo
lo = Create uo_ge449_precificacao_resumo

lo.is_Tipo_Precificacao = '3'

lo.of_Grava_Resumo(adt_parametro)

Destroy lo
end subroutine

on w_ge449_precificacao.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.em_1=create em_1
this.st_1=create st_1
this.st_2=create st_2
this.cb_2=create cb_2
this.cb_3=create cb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.em_1
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.st_2
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.cb_3
end on

on w_ge449_precificacao.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.em_1)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.cb_2)
destroy(this.cb_3)
end on

event ue_preopen;call super::ue_preopen;em_1.SetFocus()
end event

type pb_help from dc_w_response`pb_help within w_ge449_precificacao
integer x = 3557
integer y = 8
end type

type cb_1 from commandbutton within w_ge449_precificacao
integer x = 110
integer y = 324
integer width = 654
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Grava Resumo Mensal"
end type

event clicked;Date ldt_Parametro

ldt_Parametro = Date("01/" + em_1.text)

If ldt_Parametro = Date("01/01/1900") Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data corretamente.")
	Return
End If

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a inclus$$HEX1$$e300$$ENDHEX$$o do resumo '" + String(ldt_Parametro, "dd/mm/yyyy") + "' ?", Question!, YesNo!, 2) = 2 Then Return

uo_ge449_precificacao_resumo lo
lo = Create uo_ge449_precificacao_resumo

lo.is_Tipo_Precificacao = ''

lo.of_Grava_Resumo(ldt_Parametro)

Destroy lo

//wf_grava_resumo(Date("01/01/2017"))
//wf_grava_resumo(Date("01/02/2017"))
//wf_grava_resumo(Date("01/03/2017"))
//wf_grava_resumo(Date("01/04/2017"))
//wf_grava_resumo(Date("01/05/2017"))
//wf_grava_resumo(Date("01/06/2017"))
//wf_grava_resumo(Date("01/07/2017"))
//wf_grava_resumo(Date("01/08/2017"))
//wf_grava_resumo(Date("01/09/2017"))
//wf_grava_resumo(Date("01/10/2017"))
//wf_grava_resumo(Date("01/11/2017"))
//wf_grava_resumo(Date("01/12/2017"))
//wf_grava_resumo(Date("01/01/2018"))
end event

type em_1 from editmask within w_ge449_precificacao
integer x = 421
integer y = 180
integer width = 325
integer height = 72
integer taborder = 70
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
string text = "mm/yyyy"
alignment alignment = center!
borderstyle borderstyle = stylelowered!
maskdatatype maskdatatype = datemask!
string mask = "mm/yyyy"
end type

type st_1 from statictext within w_ge449_precificacao
integer x = 18
integer y = 28
integer width = 1294
integer height = 84
boolean bringtotop = true
integer textsize = -14
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "Grava Resumo Mensal"
boolean focusrectangle = false
end type

type st_2 from statictext within w_ge449_precificacao
integer x = 110
integer y = 184
integer width = 302
integer height = 64
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "M$$HEX1$$ea00$$ENDHEX$$s/Ano:"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_ge449_precificacao
integer x = 1518
integer y = 60
integer width = 681
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Grava Precifica$$HEX2$$e700e300$$ENDHEX$$o"
end type

event clicked;String ls_UF, ls_Rede, ls_SubCategoria

uo_ge450_precificacao_calculo lo
lo = Create uo_ge450_precificacao_calculo

SetNull(ls_UF)
SetNull(ls_Rede)
SetNull(ls_SubCategoria)

ls_UF = 'SC'
ls_Rede  = 'DC' 

// RX - ANLODIPINO
ls_SubCategoria = '102002001'
lo.of_grava_precificacao(1, ls_UF, ls_Rede, ls_SubCategoria, '505100')

// RX - DESLORATADINA
ls_SubCategoria = '102001011'
lo.of_grava_precificacao(1, ls_UF, ls_Rede, ls_SubCategoria, '505100')

// MIP - PARACETAMOL
ls_SubCategoria = '104003021'
lo.of_grava_precificacao(3, ls_UF, ls_Rede, ls_SubCategoria, '505100')

// N$$HEX1$$c300$$ENDHEX$$O MEDICAMENTO - SABONETE
ls_SubCategoria = '303005012'
lo.of_grava_precificacao(2, ls_UF, ls_Rede, ls_SubCategoria, '505100')

Destroy lo
end event

type cb_3 from commandbutton within w_ge449_precificacao
integer x = 1518
integer y = 280
integer width = 681
integer height = 112
integer taborder = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "C$$HEX1$$e100$$ENDHEX$$lculo Precifica$$HEX2$$e700e300$$ENDHEX$$o"
end type

event clicked;uo_ge450_precificacao_calculo lo
lo = Create uo_ge450_precificacao_calculo

lo.of_processa_precificacao()

Destroy lo
end event

