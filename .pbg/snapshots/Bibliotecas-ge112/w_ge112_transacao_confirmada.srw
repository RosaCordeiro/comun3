HA$PBExportHeader$w_ge112_transacao_confirmada.srw
forward
global type w_ge112_transacao_confirmada from Window
end type
type st_2 from statictext within w_ge112_transacao_confirmada
end type
type st_1 from statictext within w_ge112_transacao_confirmada
end type
type dw_1 from dc_uo_dw_base within w_ge112_transacao_confirmada
end type
type gb_1 from groupbox within w_ge112_transacao_confirmada
end type
end forward

global type w_ge112_transacao_confirmada from Window
int X=1358
int Y=996
int Width=2030
int Height=1116
boolean TitleBar=true
string Title="Transa$$HEX2$$e700e300$$ENDHEX$$o TEF confirmada"
long BackColor=80269524
WindowType WindowType=response!
st_2 st_2
st_1 st_1
dw_1 dw_1
gb_1 gb_1
end type
global w_ge112_transacao_confirmada w_ge112_transacao_confirmada

type variables
Long Comando
Long TamanhoMinimo
Long TamanhoMaximo
end variables

on w_ge112_transacao_confirmada.create
this.st_2=create st_2
this.st_1=create st_1
this.dw_1=create dw_1
this.gb_1=create gb_1
this.Control[]={this.st_2,&
this.st_1,&
this.dw_1,&
this.gb_1}
end on

on w_ge112_transacao_confirmada.destroy
destroy(this.st_2)
destroy(this.st_1)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event open;
String ls_where
String ls_ecf
String ls_cupom

This.x = ( 3680 - This.Width ) / 2
This.y = ( 2000 - This.Height) / 2

ls_ecf   = String(Long(MidA(Message.StringParm,1,3)))
ls_cupom = String(Long(MidA(Message.StringParm,4,8)))

ls_where = 'nr_ecf = ' + ls_ecf + ' and nr_coo_ecf = ' + ls_cupom

This.Show()

gf_Ativa_Janela(This)

dw_1.of_AppendWhere(ls_Where)

dw_1.Retrieve()

If dw_1.RowCount() = 0 Then 
	Close(This)
Else	
	If IsNull(dw_1.object.de_modalidade[1]) Then 
		Close(This)
	End If
End If	




end event

event key;
Choose Case key
	Case KeyF12!	
		Close(This)			
End Choose

end event

type st_2 from statictext within w_ge112_transacao_confirmada
int X=37
int Y=48
int Width=1934
int Height=76
boolean Enabled=false
string Text=" ~"Transa$$HEX2$$e700e300$$ENDHEX$$o TEF efetuada. Favor re-imprimir $$HEX1$$fa00$$ENDHEX$$ltimo cupom~"."
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=80269524
int TextSize=-9
int Weight=700
string FaceName="Verdana"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type st_1 from statictext within w_ge112_transacao_confirmada
int X=37
int Y=888
int Width=1934
int Height=76
boolean Enabled=false
string Text=".... Pressione tecla [F12] para continuar ..."
Alignment Alignment=Center!
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=80269524
int TextSize=-9
int Weight=700
string FaceName="Verdana"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type dw_1 from dc_uo_dw_base within w_ge112_transacao_confirmada
int X=64
int Y=172
int Width=1883
int Height=664
int TabOrder=20
string DataObject="dw_ge112_transacao_tef"
end type

type gb_1 from groupbox within w_ge112_transacao_confirmada
int X=37
int Y=120
int Width=1934
int Height=740
int TabOrder=10
BorderStyle BorderStyle=StyleRaised!
long TextColor=128
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Verdana"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

