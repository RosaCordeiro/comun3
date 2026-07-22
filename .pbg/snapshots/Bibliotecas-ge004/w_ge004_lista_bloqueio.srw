HA$PBExportHeader$w_ge004_lista_bloqueio.srw
forward
global type w_ge004_lista_bloqueio from dc_w_response_ok_cancela
end type
type st_1 from statictext within w_ge004_lista_bloqueio
end type
end forward

global type w_ge004_lista_bloqueio from dc_w_response_ok_cancela
integer x = 690
integer y = 436
integer width = 1902
integer height = 1540
string title = "GE004 - Consulta de Bloqueios"
long backcolor = 80269524
st_1 st_1
end type
global w_ge004_lista_bloqueio w_ge004_lista_bloqueio

type variables
uo_ge004_Parametro_Controle_Bloqueio ivo_Parametro
end variables

forward prototypes
public function boolean wf_permite_liberacao ()
end prototypes

public function boolean wf_permite_liberacao ();Boolean lvb_Liberacao = True

Long lvl_Linha

lvl_Linha = dw_1.Find("id_permite_liberacao = 'N'", 1, dw_1.RowCount())

If lvl_Linha = -1 or lvl_Linha > 0 Then
	If lvl_Linha = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no find da permiss$$HEX1$$e300$$ENDHEX$$o de libera$$HEX2$$e700e300$$ENDHEX$$o.")
	End If
	
	lvb_Liberacao = False
End If

cb_Ok.Enabled = lvb_Liberacao

If cb_Ok.Enabled Then cb_Ok.SetFocus()

Return lvb_Liberacao
end function

on w_ge004_lista_bloqueio.create
int iCurrent
call super::create
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
end on

on w_ge004_lista_bloqueio.destroy
call super::destroy
destroy(this.st_1)
end on

event ue_postopen;// Override

dw_1.SetRedraw(False)

dw_1.Reset()

If ivo_Parametro.ivds_1.RowCount() > 0 Then
	ivo_Parametro.ivds_1.RowsCopy(1, ivo_Parametro.ivds_1.RowCount(), Primary!, dw_1, dw_1.RowCount() + 1, Primary!)
End If

dw_1.Sort()
dw_1.GroupCalc()

dw_1.SetRedraw(True)

wf_Permite_Liberacao()

This.Title += " (" + ivo_Parametro.ivs_Banco + ")"
end event

event open;call super::open;ivo_Parametro = Message.PowerObjectParm
end event

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge004_lista_bloqueio
integer width = 1829
integer height = 1292
integer taborder = 0
integer weight = 700
string facename = "Verdana"
string text = "Lista de Bloqueios"
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge004_lista_bloqueio
integer x = 46
integer y = 56
integer width = 1783
integer height = 1220
integer taborder = 0
string dataobject = "dw_ge004_lista_bloqueio"
boolean vscrollbar = true
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge004_lista_bloqueio
integer x = 1088
integer y = 1324
integer width = 370
integer taborder = 10
string facename = "Verdana"
boolean enabled = false
string text = "&Liberar"
end type

event cb_ok::clicked;String lvs_Matricula

If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("LIBERACAO_BLOQUEIO_CLIENTE", ref lvs_Matricula) Then 
	Return
End If

CloseWithReturn(Parent, lvs_Matricula)


end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge004_lista_bloqueio
integer x = 1481
integer y = 1324
integer width = 370
integer taborder = 20
string facename = "Verdana"
end type

type st_1 from statictext within w_ge004_lista_bloqueio
integer x = 41
integer y = 1340
integer width = 1024
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 255
long backcolor = 67108864
boolean enabled = false
string text = "Bloqueios que n$$HEX1$$e300$$ENDHEX$$o permitem libera$$HEX2$$e700e300$$ENDHEX$$o"
boolean focusrectangle = false
end type

