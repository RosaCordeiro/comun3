HA$PBExportHeader$dc_w_configuracao_impressao.srw
forward
global type dc_w_configuracao_impressao from dc_w_response
end type
type dw_1 from dc_uo_dw_base within dc_w_configuracao_impressao
end type
type cb_ok from commandbutton within dc_w_configuracao_impressao
end type
type cb_cancelar from commandbutton within dc_w_configuracao_impressao
end type
type cb_impressora from commandbutton within dc_w_configuracao_impressao
end type
end forward

global type dc_w_configuracao_impressao from dc_w_response
int X=1454
int Y=1236
int Width=1678
int Height=588
boolean TitleBar=true
string Title="Configura$$HEX2$$e700e300$$ENDHEX$$o da Impress$$HEX1$$e300$$ENDHEX$$o"
long BackColor=80269524
boolean ControlMenu=false
dw_1 dw_1
cb_ok cb_ok
cb_cancelar cb_cancelar
cb_impressora cb_impressora
end type
global dc_w_configuracao_impressao dc_w_configuracao_impressao

type variables
dc_uo_parametro_impressao ivo_print
end variables

on dc_w_configuracao_impressao.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_ok=create cb_ok
this.cb_cancelar=create cb_cancelar
this.cb_impressora=create cb_impressora
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.cb_cancelar
this.Control[iCurrent+4]=this.cb_impressora
end on

on dc_w_configuracao_impressao.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_ok)
destroy(this.cb_cancelar)
destroy(this.cb_impressora)
end on

event open;call super::open;ivo_Print = Message.PowerObjectParm
end event

event ue_postopen;call super::ue_postopen;dw_1.Event ue_AddRow()

cb_Ok.SetFocus()
end event

type dw_1 from dc_uo_dw_base within dc_w_configuracao_impressao
int X=5
int Y=0
int Width=1646
int Height=368
boolean BringToTop=true
string DataObject="dc_dw_configuracao_impressao"
end type

event itemchanged;call super::itemchanged;Integer lvi_Nulo

Choose Case dwo.Name 
	Case "id_selecao_paginas"
		If Data = "T" Then
			SetNull(lvi_Nulo)
			
			This.Object.Nr_Pagina_Inicial[1] = lvi_Nulo
			This.Object.Nr_Pagina_Final  [1] = lvi_Nulo

			This.Object.Nr_Pagina_Inicial.Protect = 1
			This.Object.Nr_Pagina_Final.Protect   = 1
		Else
			This.Object.Nr_Pagina_Inicial.Protect = 0
			This.Object.Nr_Pagina_Final.Protect   = 0
			
			This.Event ue_Pos(1, "nr_pagina_inicial")
		End If
End Choose
end event

type cb_ok from commandbutton within dc_w_configuracao_impressao
int X=983
int Y=372
int Width=311
int Height=100
int TabOrder=20
boolean BringToTop=true
string Text="&OK"
boolean Default=true
int TextSize=-8
int Weight=400
string FaceName="Verdana"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event getfocus;This.Weight = 700
end event

event losefocus;This.Weight = 400
end event

event clicked;String lvs_Selecao_Paginas, &
       lvs_Agrupar_Copias

Integer lvi_Pagina_Inicial, &
        lvi_Pagina_Final, &
		  lvi_Qtde_Copias

dw_1.AcceptText()

lvs_Selecao_Paginas = dw_1.Object.Id_Selecao_Paginas[1]
lvi_Pagina_Inicial  = dw_1.Object.Nr_Pagina_Inicial [1]
lvi_Pagina_Final    = dw_1.Object.Nr_Pagina_Final   [1]
lvi_Qtde_Copias     = dw_1.Object.Qt_Copias         [1]
lvs_Agrupar_Copias  = dw_1.Object.Id_Agrupar_Copias [1]

If lvs_Selecao_Paginas = "T" Then
	ivo_Print.ivb_Todas_Paginas = True
Else
	ivo_Print.ivb_Todas_Paginas = False

	If IsNull(lvi_Pagina_Inicial) or lvi_Pagina_Inicial <= 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a p$$HEX1$$e100$$ENDHEX$$gina inicial para impress$$HEX1$$e300$$ENDHEX$$o do intervalo.", StopSign!)
		dw_1.Event ue_Pos(1, "nr_pagina_inicial")
		Return
	End If
	
	If IsNull(lvi_Pagina_Final) or lvi_Pagina_Final <= 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a p$$HEX1$$e100$$ENDHEX$$gina final para impress$$HEX1$$e300$$ENDHEX$$o do intervalo.", StopSign!)
		dw_1.Event ue_Pos(1, "nr_pagina_final")
		Return
	End If
	
	If lvi_Pagina_Final < lvi_Pagina_Inicial Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A p$$HEX1$$e100$$ENDHEX$$gina final deve ser maior ou igual a inicial.", StopSign!)
		dw_1.Event ue_Pos(1, "nr_pagina_final")
		Return
	End If
	
	ivo_Print.ivi_Pagina_Inicial = lvi_Pagina_Inicial
	ivo_Print.ivi_Pagina_Final   = lvi_Pagina_Final
End If

If IsNull(lvi_Qtde_Copias) or lvi_Qtde_Copias < 1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A quantidade de c$$HEX1$$f300$$ENDHEX$$pias deve ser pelo menos 1.", StopSign!)
	dw_1.Event ue_Pos(1, "qt_copias")
	Return
End If

ivo_Print.ivi_Qtde_Copias = lvi_Qtde_Copias

If lvs_Agrupar_Copias = "S" Then
	ivo_Print.ivb_Agrupar_Copias = True
Else
	ivo_Print.ivb_Agrupar_Copias = False
End If

ivo_Print.ivb_Cancelar_Impressao = False

CloseWithReturn(Parent, ivo_Print)
end event

type cb_cancelar from commandbutton within dc_w_configuracao_impressao
int X=1317
int Y=372
int Width=311
int Height=100
int TabOrder=30
boolean BringToTop=true
string Text="&Cancelar"
boolean Cancel=true
int TextSize=-8
int Weight=400
string FaceName="Verdana"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;ivo_Print.ivb_Cancelar_Impressao = True

CloseWithReturn(Parent, ivo_Print)
end event

event getfocus;This.Weight = 700
end event

event losefocus;This.Weight = 400
end event

type cb_impressora from commandbutton within dc_w_configuracao_impressao
int X=23
int Y=372
int Width=448
int Height=100
int TabOrder=30
boolean BringToTop=true
string Text="&Impressora..."
int TextSize=-8
int Weight=400
string FaceName="Verdana"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;PrintSetup()
end event

event getfocus;This.Weight = 700
end event

event losefocus;This.Weight = 400

end event

