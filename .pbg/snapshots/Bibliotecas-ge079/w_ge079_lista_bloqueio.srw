HA$PBExportHeader$w_ge079_lista_bloqueio.srw
forward
global type w_ge079_lista_bloqueio from dc_w_response_ok_cancela
end type
type st_1 from statictext within w_ge079_lista_bloqueio
end type
end forward

global type w_ge079_lista_bloqueio from dc_w_response_ok_cancela
int X=690
int Y=436
int Width=1902
int Height=1540
boolean TitleBar=true
string Title="GE079 - Consulta de Bloqueios"
long BackColor=80269524
st_1 st_1
end type
global w_ge079_lista_bloqueio w_ge079_lista_bloqueio

type variables
uo_Parametro_Controle_Bloqueio ivo_Parametro
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

on w_ge079_lista_bloqueio.create
int iCurrent
call super::create
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
end on

on w_ge079_lista_bloqueio.destroy
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

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge079_lista_bloqueio
int Width=1829
int Height=1292
int TabOrder=0
string Text="Lista de Bloqueios"
int Weight=700
string FaceName="Verdana"
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge079_lista_bloqueio
int X=46
int Y=56
int Width=1783
int Height=1220
int TabOrder=0
boolean BringToTop=true
string DataObject="dw_ge079_lista_bloqueio"
boolean VScrollBar=true
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge079_lista_bloqueio
int X=1088
int Y=1324
int Width=370
int TabOrder=10
boolean Enabled=false
boolean BringToTop=true
string Text="&Liberar"
string FaceName="Verdana"
end type

event cb_ok::clicked;String lvs_Matricula

If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("LIBERACAO_BLOQUEIO_CLIENTE", ref lvs_Matricula) Then 
	Return
End If

CloseWithReturn(Parent, lvs_Matricula)


end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge079_lista_bloqueio
int X=1481
int Y=1324
int Width=370
int TabOrder=20
boolean BringToTop=true
string FaceName="Verdana"
end type

type st_1 from statictext within w_ge079_lista_bloqueio
int X=41
int Y=1340
int Width=1024
int Height=76
boolean Enabled=false
boolean BringToTop=true
string Text="Bloqueios que n$$HEX1$$e300$$ENDHEX$$o permitem libera$$HEX2$$e700e300$$ENDHEX$$o"
boolean FocusRectangle=false
long TextColor=255
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Verdana"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

