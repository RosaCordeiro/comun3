HA$PBExportHeader$w_ge108_painel_senha.srw
forward
global type w_ge108_painel_senha from window
end type
type cb_troca_depto from commandbutton within w_ge108_painel_senha
end type
type cb_ajusta_horario from commandbutton within w_ge108_painel_senha
end type
type dw_1 from datawindow within w_ge108_painel_senha
end type
type cb_3 from commandbutton within w_ge108_painel_senha
end type
type cb_repetir from commandbutton within w_ge108_painel_senha
end type
type cb_proxima from commandbutton within w_ge108_painel_senha
end type
type gb_1 from groupbox within w_ge108_painel_senha
end type
type gb_2 from groupbox within w_ge108_painel_senha
end type
end forward

global type w_ge108_painel_senha from window
integer width = 1627
integer height = 1000
boolean titlebar = true
string title = "GE108 - Painel Senha"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
cb_troca_depto cb_troca_depto
cb_ajusta_horario cb_ajusta_horario
dw_1 dw_1
cb_3 cb_3
cb_repetir cb_repetir
cb_proxima cb_proxima
gb_1 gb_1
gb_2 gb_2
end type
global w_ge108_painel_senha w_ge108_painel_senha

type variables
OleObject ole_painel_senha
OleObject ole_painel_senha_2

uo_parametro_pdv io_parametro_pdv

Long il_Caixa

srt_ge108_painel_senha istr_Painel_Senha

CONSTANT STRING STATUS_NENHUM_TICKET_NA_FILA = 'N$$HEX1$$c300$$ENDHEX$$O TEM NENHUM TICKET NA FILA.'
end variables

forward prototypes
public function integer wf_chama_proxima (integer pl_pdv)
public function integer wf_troca_depto (boolean pb_pergunta)
public function boolean wf_grava_log (string ps_mensagem)
end prototypes

public function integer wf_chama_proxima (integer pl_pdv);Boolean lb_Retorno = False

String ls_Senha

If pl_Pdv = 0 Then
	MessageBox( "Guich$$HEX1$$ea00$$ENDHEX$$", "N$$HEX1$$fa00$$ENDHEX$$mero do Guich$$HEX1$$ea00$$ENDHEX$$ n$$HEX1$$e300$$ENDHEX$$o configurado." , Exclamation! )
	Return -1
End If

ole_painel_senha._userNum = pl_Pdv

lb_Retorno = ole_painel_senha.GetNextTicket( ) //Chamada de pr$$HEX1$$f300$$ENDHEX$$ximo ticket

ls_Senha = Trim( String( ole_painel_senha._activeTicket ) )

If ls_Senha <> '0' Then
	ls_Senha = CharA( ole_painel_senha._activeAlphaTicket ) + ls_Senha
End If

dw_1.Object.Senha[ 1 ] = ls_Senha

wf_Grava_Log( 'Guich$$HEX1$$ea00$$ENDHEX$$: ' + String( pl_Pdv ) + ' | Senha: ' + ls_Senha + ' | Status: ' + String( ole_painel_senha._status ) + ' :: Fun$$HEX2$$e700e300$$ENDHEX$$o: GetNextTicket' )

If Not lb_Retorno Then
	If Upper( String( ole_painel_senha._status ) ) <> STATUS_NENHUM_TICKET_NA_FILA Then
		MessageBox( "Guich$$HEX1$$ea00$$ENDHEX$$", String( ole_painel_senha._status ), Exclamation! )
	End If
End If

Return 1
end function

public function integer wf_troca_depto (boolean pb_pergunta);Return 1


Byte lby_UserDepto_Para = 1

Boolean lb_Retorno = False

String ls_Depto_Para = "PRIORIT$$HEX1$$c100$$ENDHEX$$RIO"

If ole_painel_senha_2._userDep = 1 Then
	lby_UserDepto_Para	= 2
	ls_Depto_Para			= "NORMAL"
End If

If pb_Pergunta Then
	If MessageBox( "Painel de Senha", "O departamento deste guich$$HEX1$$ea00$$ENDHEX$$ passar$$HEX1$$e100$$ENDHEX$$ ao atendimento " + ls_Depto_Para + ".~r~rConfirma a altera$$HEX2$$e700e300$$ENDHEX$$o?", Question!, YesNo!, 2 ) = 2 Then Return -1
End If

lb_Retorno = ole_painel_senha_2.SetDepUser( This.il_Caixa, lby_UserDepto_Para )

wf_Grava_Log( 'Guich$$HEX1$$ea00$$ENDHEX$$: ' + String( This.il_Caixa ) + ' | Depto de: ' + String( ole_painel_senha_2._userDep ) + ' | Depto para: ' + ls_Depto_Para + '(' + String( lby_UserDepto_Para ) + ') | Status: ' + String( ole_painel_senha._status ) + ' :: Fun$$HEX2$$e700e300$$ENDHEX$$o: SetDepUser' )

If Not lb_Retorno Then
	MessageBox( "Painel de Senha", String( ole_painel_senha_2._status ), StopSign! )
	This.wf_Troca_Depto( pb_pergunta )
End If

If istr_painel_senha.id_painel_senha_auto_troca_dep <> 'S' Then
	gb_1.Text = "Guich$$HEX1$$ea00$$ENDHEX$$ " + ls_Depto_Para
End If

ole_painel_senha_2.GetDepUser( This.il_Caixa )

wf_Grava_Log( 'Guich$$HEX1$$ea00$$ENDHEX$$: ' + String( This.il_Caixa ) + ' | Depto atual: ' + String( ole_painel_senha_2._userDep ) + ' | Status: ' + String( ole_painel_senha._status ) + ' :: Fun$$HEX2$$e700e300$$ENDHEX$$o: GetDepUser' )
end function

public function boolean wf_grava_log (string ps_mensagem);Integer li_Status

String ls_Mensagem

ls_Mensagem = String( Today( ), "dd/mm/yyyy" ) + " " + String( Now( ), "hh:mm:ss" ) + " " + ps_Mensagem
	
li_Status = FileWrite( gvi_Log_Painel_Senha, ls_Mensagem )

If li_Status <> LenA( ls_Mensagem ) Then	
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro no arquivo de log: " + gvs_Log_Painel_Senha + ".~r" + ls_Mensagem, StopSign! )
	Return False
Else
	Return True
End If
end function

on w_ge108_painel_senha.create
this.cb_troca_depto=create cb_troca_depto
this.cb_ajusta_horario=create cb_ajusta_horario
this.dw_1=create dw_1
this.cb_3=create cb_3
this.cb_repetir=create cb_repetir
this.cb_proxima=create cb_proxima
this.gb_1=create gb_1
this.gb_2=create gb_2
this.Control[]={this.cb_troca_depto,&
this.cb_ajusta_horario,&
this.dw_1,&
this.cb_3,&
this.cb_repetir,&
this.cb_proxima,&
this.gb_1,&
this.gb_2}
end on

on w_ge108_painel_senha.destroy
destroy(this.cb_troca_depto)
destroy(this.cb_ajusta_horario)
destroy(this.dw_1)
destroy(this.cb_3)
destroy(this.cb_repetir)
destroy(this.cb_proxima)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event open;Try
	istr_Painel_Senha = Message.PowerObjectParm
	
	ole_painel_senha 		= istr_Painel_Senha.uo_painel_senha
	ole_painel_senha_2	= istr_Painel_Senha.uo_painel_senha_2

	ole_painel_senha_2.GetDepUser( This.il_Caixa )
	ole_painel_senha_2.GetDepName( ole_painel_senha_2._userDep )

	If istr_painel_senha.id_painel_senha_auto_troca_dep = 'S' Then
		gb_1.Text = ""
		cb_troca_depto.Enabled = False
		cb_troca_depto.Text = "Atendimento alternado"
	Else
		If ole_painel_senha_2._userDep = 1 Then
			gb_1.Text = "Guich$$HEX1$$ea00$$ENDHEX$$ PRIORIT$$HEX1$$c100$$ENDHEX$$RIO"
		Else
			gb_1.Text = "Guich$$HEX1$$ea00$$ENDHEX$$ NORMAL"
		End If		
	End If
	
	io_parametro_pdv		= istr_Painel_Senha.uo_parametro_pdv
	il_Caixa					= istr_Painel_Senha.Nr_Caixa	
	
	dw_1.InsertRow( 0 )
	dw_1.Object.caixa[ 1 ] = This.il_Caixa	
	
Catch( RuntimeError ru )
	MessageBox( "RuntimeError", ru.getMessage( ), StopSign! )
End Try
end event

event key;Choose Case Key
	Case KeyF2!
		cb_proxima.event clicked( )
		
	Case KeyF3!
		cb_repetir.event clicked( )
End Choose
end event

type cb_troca_depto from commandbutton within w_ge108_painel_senha
boolean visible = false
integer x = 850
integer y = 732
integer width = 709
integer height = 108
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Trocar departamento"
end type

event clicked;wf_Troca_Depto( True )
end event

type cb_ajusta_horario from commandbutton within w_ge108_painel_senha
integer x = 64
integer y = 732
integer width = 507
integer height = 108
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Ajustar hor$$HEX1$$e100$$ENDHEX$$rio"
end type

event clicked;Boolean lb_Retorno = False

String ls_Ajuste = ""

ls_Ajuste = String( gf_GetServerDate( ), "dd/mm/yyyy hh:mm:ss" )

If MessageBox( "Painel de Senha", "Confirma o ajuste do hor$$HEX1$$e100$$ENDHEX$$rio da impressora para~r" + ls_Ajuste + " ?~r~rEste hor$$HEX1$$e100$$ENDHEX$$rio $$HEX1$$e900$$ENDHEX$$ do servidor de banco de dados.", Question!, YesNo!, 2 ) = 2 Then Return -1

lb_Retorno = ole_painel_senha_2.SetDateTime( ls_Ajuste )

MessageBox( "Ajuste de hor$$HEX1$$e100$$ENDHEX$$rio", String( ole_painel_senha_2._status ) )

wf_Grava_Log( 'Status: ' + String( ole_painel_senha._status ) + ' :: Fun$$HEX2$$e700e300$$ENDHEX$$o: SetDateTime' )
end event

type dw_1 from datawindow within w_ge108_painel_senha
integer x = 64
integer y = 56
integer width = 713
integer height = 532
boolean enabled = false
string title = "none"
string dataobject = "dw_ge108_painel_senha"
boolean border = false
end type

type cb_3 from commandbutton within w_ge108_painel_senha
integer x = 795
integer y = 476
integer width = 759
integer height = 112
integer taborder = 30
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Fechar [ESC]"
boolean cancel = true
end type

event clicked;CloseWithReturn( Parent,  istr_Painel_Senha )
Return 1
end event

type cb_repetir from commandbutton within w_ge108_painel_senha
integer x = 795
integer y = 284
integer width = 759
integer height = 112
integer taborder = 20
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Repetir chamada [F3]"
end type

event clicked;String ls_Senha

Try
	ole_painel_senha._userNum	 = Byte( Parent.il_Caixa )
	
	If Not ole_painel_senha.GetLastTicket( ) Then
		MessageBox( "Painel Senha", String( ole_painel_senha._status ), Exclamation! )
		Return -1
	End If
		
	ls_Senha = Trim( String( ole_painel_senha._activeTicket ) )
	
	If ls_Senha <> '0' Then
		ls_Senha = CharA( ole_painel_senha._activeAlphaTicket ) + ls_Senha
	End If
	
	dw_1.Object.Senha[ 1 ] = ls_Senha

Catch ( RuntimeError ru )
	MessageBox( "RuntimeError", ru.getMessage( ), StopSign! )
	
Finally
	wf_Grava_Log( 'Guich$$HEX1$$ea00$$ENDHEX$$: ' + String( Parent.il_Caixa ) + ' | Senha: ' + ls_Senha + ' | Status: ' + String( ole_painel_senha._status ) + ' :: Fun$$HEX2$$e700e300$$ENDHEX$$o: GetLastTicket' )
End Try
end event

type cb_proxima from commandbutton within w_ge108_painel_senha
integer x = 795
integer y = 76
integer width = 759
integer height = 112
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Chamar pr$$HEX1$$f300$$ENDHEX$$xima [F2]"
end type

event clicked;Parent.wf_chama_proxima( Parent.il_Caixa )
Parent.wf_Troca_Depto( False )

If Upper( String( ole_painel_senha._status ) ) = STATUS_NENHUM_TICKET_NA_FILA Then
	Parent.wf_chama_proxima( Parent.il_Caixa )
	Parent.wf_Troca_Depto( False )
End If

If Upper( String( ole_painel_senha._status ) ) = STATUS_NENHUM_TICKET_NA_FILA Then
	MessageBox( "Guich$$HEX1$$ea00$$ENDHEX$$", String( ole_painel_senha._status ), Exclamation! )
End If
end event

type gb_1 from groupbox within w_ge108_painel_senha
integer x = 27
integer y = 4
integer width = 1563
integer height = 616
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Atendimento"
borderstyle borderstyle = styleraised!
end type

type gb_2 from groupbox within w_ge108_painel_senha
integer x = 27
integer y = 644
integer width = 1563
integer height = 236
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Configura$$HEX2$$e700f500$$ENDHEX$$es"
borderstyle borderstyle = styleraised!
end type

