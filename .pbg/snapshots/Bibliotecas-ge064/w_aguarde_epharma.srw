HA$PBExportHeader$w_aguarde_epharma.srw
forward
global type w_aguarde_epharma from dc_w_response
end type
type cb_cancelar from commandbutton within w_aguarde_epharma
end type
type dw_1 from dc_uo_dw_base within w_aguarde_epharma
end type
end forward

global type w_aguarde_epharma from dc_w_response
integer x = 727
integer y = 892
integer width = 2107
integer height = 640
string title = "Comunica$$HEX2$$e700e300$$ENDHEX$$o e-Pharma..."
boolean controlmenu = false
cb_cancelar cb_cancelar
dw_1 dw_1
end type
global w_aguarde_epharma w_aguarde_epharma

type variables
uo_Aguarde_ePharma ivo_aguarde
end variables

forward prototypes
public subroutine wf_atualiza_hora_atual ()
end prototypes

public subroutine wf_atualiza_hora_atual ();Time lvt_Now

Timer(0)

If FileExists(ivo_Aguarde.ivs_Arquivo) Or FileExists(ivo_Aguarde.ivs_Arquivo_dep) Then
	If FileExists(ivo_Aguarde.ivs_Arquivo_dep) Then
		CloseWithReturn(This, "D")
	Else
		CloseWithReturn(This, "S")
	End If	
//If FileExists(ivo_Aguarde.ivs_Arquivo) Then
//	CloseWithReturn(This, "S")
Else
	lvt_Now = Now()
	
	dw_1.Object.Hr_Atual[1] = lvt_Now
	dw_1.SetRedraw(True)
	
	If lvt_Now > ivo_Aguarde.ivt_Limite Then
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tempo de espera de retorno excedido. Deseja continuar aguardando ?" , Question!, YesNo!, 2) = 1 Then
			Yield()
			lvt_Now = Now()
			ivo_Aguarde.ivt_Limite = RelativeTime(lvt_Now, ivo_Aguarde.ivi_Limite)
			
			dw_1.Object.Hr_Inicio  [1] = lvt_Now
			dw_1.Object.Hr_Limite  [1] = ivo_Aguarde.ivt_Limite
			
			SetPointer(HourGlass!)
		Else
			CloseWithReturn(This, "N")
			Return
		End If	
	End If
	
	Timer(1)
End If
end subroutine

on w_aguarde_epharma.create
int iCurrent
call super::create
this.cb_cancelar=create cb_cancelar
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_cancelar
this.Control[iCurrent+2]=this.dw_1
end on

on w_aguarde_epharma.destroy
call super::destroy
destroy(this.cb_cancelar)
destroy(this.dw_1)
end on

event timer;wf_Atualiza_Hora_Atual()
end event

event open;call super::open;Time lvt_Now

String lvs_Mensagem

ivo_Aguarde = Create uo_Aguarde_ePharma

ivo_Aguarde = Message.PowerObjectParm

dw_1.Event ue_AddRow()

lvt_Now = Now()
ivo_Aguarde.ivt_Limite = RelativeTime(lvt_Now, ivo_Aguarde.ivi_Limite)

lvs_Mensagem = ivo_Aguarde.ivs_Mensagem + "~r" + ivo_Aguarde.ivs_Arquivo

dw_1.Object.De_Mensagem[1] = lvs_Mensagem
dw_1.Object.Hr_Inicio  [1] = lvt_Now
dw_1.Object.Hr_Limite  [1] = ivo_Aguarde.ivt_Limite

cb_Cancelar.SetFocus()

wf_Atualiza_Hora_Atual()


end event

event close;call super::close;Destroy(ivo_Aguarde)
end event

type pb_help from dc_w_response`pb_help within w_aguarde_epharma
end type

type cb_cancelar from commandbutton within w_aguarde_epharma
integer x = 837
integer y = 424
integer width = 443
integer height = 100
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Cancelar"
boolean cancel = true
end type

event clicked;Boolean lvb_Sucesso = False

cb_cancelar.Enabled = False

gf_Delay(5)

// Verifica se tem algum arquivo para enviar
If FileExists(ivo_Aguarde.ivs_Arquivo_ENV) Then
	If Not FileDelete(ivo_Aguarde.ivs_Arquivo_ENV) Then
		DO While Not lvb_Sucesso 
			If FileExists(ivo_Aguarde.ivs_Arquivo) Then
				lvb_Sucesso = True
			Else
				gf_Delay(5)
			End If
		Loop
	Else
		lvb_Sucesso = False
	End If
Else
	If FileExists(ivo_Aguarde.ivs_Arquivo) Then lvb_Sucesso = True
End If

If lvb_Sucesso Then
	CloseWithReturn(Parent, "S")
Else
	CloseWithReturn(Parent, "N")
	gvo_Aplicacao.of_Grava_Log("Cancelada - Opera$$HEX2$$e700e300$$ENDHEX$$o foi cancelada pelo operador.")
End If

end event

type dw_1 from dc_uo_dw_base within w_aguarde_epharma
integer y = 8
integer width = 2066
integer height = 420
string dataobject = "dw_aguarde_epharma"
end type

