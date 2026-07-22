HA$PBExportHeader$w_ge388_gera_token.srw
forward
global type w_ge388_gera_token from window
end type
type st_3 from statictext within w_ge388_gera_token
end type
type st_validade from statictext within w_ge388_gera_token
end type
type st_usuario from statictext within w_ge388_gera_token
end type
type st_2 from statictext within w_ge388_gera_token
end type
type st_1 from statictext within w_ge388_gera_token
end type
type cb_1 from commandbutton within w_ge388_gera_token
end type
type dw_1 from datawindow within w_ge388_gera_token
end type
type st_token from statictext within w_ge388_gera_token
end type
type gb_2 from groupbox within w_ge388_gera_token
end type
type gb_1 from groupbox within w_ge388_gera_token
end type
type gb_3 from groupbox within w_ge388_gera_token
end type
end forward

global type w_ge388_gera_token from window
integer width = 1207
integer height = 1268
boolean titlebar = true
string title = "GE388 - Gera$$HEX2$$e700e300$$ENDHEX$$o Token"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 67108864
string icon = "AppIcon!"
boolean center = true
st_3 st_3
st_validade st_validade
st_usuario st_usuario
st_2 st_2
st_1 st_1
cb_1 cb_1
dw_1 dw_1
st_token st_token
gb_2 gb_2
gb_1 gb_1
gb_3 gb_3
end type
global w_ge388_gera_token w_ge388_gera_token

type variables
Private:
dc_uo_encript	ivo_encript
uo_smtp 			ivo_smtp
dc_uo_api		ivo_api

Integer ivi_Arquivo

Constant Long 		Validade_Token_Usuario = 330
Constant String		Log_Nome = "C:\Temp\log_cl534.log"
end variables

forward prototypes
public function datetime wf_getserverdate ()
public function string wf_gera_token_usuario (string ps_matricula)
public function boolean wf_valida_usuario (string ps_matricula)
public function boolean wf_valida_data_hora ()
end prototypes

public function datetime wf_getserverdate ();DateTime lvdh_Servidor

If SqlCa.Dbhandle( ) <> 0 Then
	Select getdate() Into :lvdh_Servidor
	From parametro
	Where id_parametro = '1'
	Using SqlCa;
	
	If SQLCa.SQLCode <> 0 Then
		lvdh_Servidor = Datetime(Today(),Now())
	End If
Else
	lvdh_Servidor = Datetime(Today(),Now())
End If

Return lvdh_Servidor
end function

public function string wf_gera_token_usuario (string ps_matricula);Datetime lvdh_Data

String lvs_Token
String lvs_Mensagem

ivo_encript.of_set_mapas( {"0","1","2","3","4","5","6","7","8","9"}, &
								   {"5","2","0","3","9","8","4","7","6","1"})


lvdh_Data = wf_getserverdate()
lvdh_Data = gf_relative_datetime(lvdh_Data, Validade_Token_Usuario)
 
lvs_Token = Mid(String(lvdh_Data, "DDMMYYYY"),1,2)+String(lvdh_Data, "HHMM") 
st_validade.Text = '* At$$HEX1$$e900$$ENDHEX$$ '+String(lvdh_Data, "HH:MM") 

lvs_Token = ivo_encript.of_encripta( lvs_Token,Mid(String(lvdh_Data, "HHMMSS"),5,2) , False)
lvs_Token = Mid(lvs_Token, 1, 1)+Mid(String(lvdh_Data, "HHMMSS"),5,1)+ Mid(lvs_Token, 2, 2)+Mid(String(lvdh_Data, "HHMMSS"),6,1)+ Mid(lvs_Token, 4)
lvs_Token = ivo_encript.of_encripta( lvs_Token, ps_matricula, False)

ivo_smtp.ib_grava_log_db = False

lvs_Mensagem =	'Caro(a) Usu$$HEX1$$e100$$ENDHEX$$rio(a),<br>'+&
						'<br>'+&
						'Novo Token para redefini$$HEX2$$e700e300$$ENDHEX$$o de senha de usu$$HEX1$$e100$$ENDHEX$$rio gerado em '+String(Datetime(Today(),Now()))+': <br><br>'+ &
						'<b>Aplica$$HEX2$$e700e300$$ENDHEX$$o: </b>'+ivo_api.of_application_path()+'<br>'+ &
						'<b>M$$HEX1$$e100$$ENDHEX$$quina: </b>'+ivo_api.Of_Get_Host()+'<br>'+ &
						'<b>MAC: </b>'+ivo_api.Of_GetMac()+'<br>'+ &
						'<b>Usu$$HEX1$$e100$$ENDHEX$$rio: </b>'+ivo_api.Of_get_User_Name()+'<br>'+ &
						'<b>Token: </b>'+lvs_Token+'<br>'+ &
						'<b>Matr$$HEX1$$ed00$$ENDHEX$$cula: </b>'+ps_matricula+'<br>'+ &
						'<b>Validade Token: </b>'+String(lvdh_Data,"DD/MM/YYYY HH:MM:SS")
						
ivo_smtp.of_envia_email(	"SEGURAN$$HEX1$$c700$$ENDHEX$$A", &
									"daniel.segalla@clamed.com.br", + &
									'[GT] - Gera$$HEX2$$e700e300$$ENDHEX$$o Token', + &
									lvs_Mensagem, + &
									{'daniel.segalla@clamed.com.br'}, &
									{'marlon.kniss@clamed.com.br','fernando.correa@clamed.com.br'},{''})			

lvs_Mensagem = 	'========================================~r'+ &
						'Data/Hora: '+String(Datetime(Today(),Now()))+'~r'+ &
						'========================================~r'+ &
						'Aplica$$HEX2$$e700e300$$ENDHEX$$o: '+ivo_api.of_application_path()+'~r'+ &
						'M$$HEX1$$e100$$ENDHEX$$quina: '+ivo_api.Of_Get_Host()+'~r'+ &
						'MAC: '+ivo_api.Of_GetMac()+'~r'+ &
						'Token: '+lvs_Token+'~r'+ &
						'Usu$$HEX1$$e100$$ENDHEX$$rio: '+ivo_api.Of_get_User_Name()+'~r'+ &
						'Matricula: '+ps_matricula+'~r'+ &
						'Validade: '+String(lvdh_Data,"DD/MM/YYYY HH:MM:SS")+'~r'+ &
						'========================================~r'
FileWrite(ivi_Arquivo, lvs_Mensagem)

Return lvs_Token
end function

public function boolean wf_valida_usuario (string ps_matricula);Long lvl_Filial
Long lvl_Filial_Matriz
String lvs_Usuario
String lvs_Situacao

If SqlCa.Dbhandle( ) <> 0 Then
	select cd_filial_matriz
	Into :lvl_Filial_Matriz
	From parametro
	Where id_parametro = '1'
	Using SQLCa;
	
	If SQLCa.SQLCode = 0 Then
		select cd_filial, nm_usuario, id_situacao
		Into :lvl_Filial, :lvs_Usuario, :lvs_Situacao
		From usuario
		Where nr_matricula = :ps_matricula
		Using SQLCa;
		
		Choose Case SQLCa.SQLCode
			Case 0
				If lvl_Filial = lvl_Filial_Matriz Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Usu$$HEX1$$e100$$ENDHEX$$rio da filial matriz n$$HEX1$$e300$$ENDHEX$$o pode ser redefinida a senha.", Exclamation!)
					Return False
				End If
				
				If lvs_Situacao <> "A" Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Usu$$HEX1$$e100$$ENDHEX$$rio informado est$$HEX1$$e100$$ENDHEX$$ inativo ou afastado.", Exclamation!)
					Return False	
				End If
			Case 100
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Usu$$HEX1$$e100$$ENDHEX$$rio n$$HEX1$$e300$$ENDHEX$$o encontrado.", Exclamation!)
				Return False	
			Case -1
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do usu$$HEX1$$e100$$ENDHEX$$rio: ~r"+SQLCa.SQLErrText, StopSign!)
				Return False						
		End Choose
	End If
End If

Return True

end function

public function boolean wf_valida_data_hora ();Datetime lvdh_Data

Long lvs_Feriado

lvdh_Data = wf_getserverdate()
	
If DayNumber(Date(lvdh_Data)) = 1 or DayNumber(Date(lvdh_Data)) = 7 Then Return True
If Time(lvdh_Data) >= Time("17:00") and Time(lvdh_Data) <= Time("07:30") Then Return True

select fe.de_feriado 
Into :lvs_Feriado
from filial f 
inner join feriado fe on fe.cd_grupo_feriado = f.cd_grupo_feriado 
where f.cd_filial = 13
	And fe.dh_feriado = cast(getdate() as date)
Using SQLCa;
	
Return SQLCa.SQLCode = 0
end function

on w_ge388_gera_token.create
this.st_3=create st_3
this.st_validade=create st_validade
this.st_usuario=create st_usuario
this.st_2=create st_2
this.st_1=create st_1
this.cb_1=create cb_1
this.dw_1=create dw_1
this.st_token=create st_token
this.gb_2=create gb_2
this.gb_1=create gb_1
this.gb_3=create gb_3
this.Control[]={this.st_3,&
this.st_validade,&
this.st_usuario,&
this.st_2,&
this.st_1,&
this.cb_1,&
this.dw_1,&
this.st_token,&
this.gb_2,&
this.gb_1,&
this.gb_3}
end on

on w_ge388_gera_token.destroy
destroy(this.st_3)
destroy(this.st_validade)
destroy(this.st_usuario)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.st_token)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.gb_3)
end on

event open;ivo_encript	= Create dc_uo_encript
ivo_smtp		= Create uo_smtp
ivo_api		= Create dc_uo_api

If Not DirectoryExists("C:\Temp") Then
	CreateDirectory("C:\Temp")
End If

ivi_Arquivo = FileOpen(Log_Nome , LineMode!, Write!, LockWrite!, Append!)

dw_1.InsertRow(0)
dw_1.SetFocus()

end event

event close;FileClose(ivi_Arquivo)

Destroy(ivo_encript)
Destroy(ivo_smtp)
end event

type st_3 from statictext within w_ge388_gera_token
integer x = 78
integer y = 668
integer width = 1047
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "* Quando a matriz estiver fechada"
boolean focusrectangle = false
end type

type st_validade from statictext within w_ge388_gera_token
integer x = 78
integer y = 936
integer width = 1088
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "* At$$HEX1$$e900$$ENDHEX$$ HH:MM:SS"
boolean focusrectangle = false
end type

type st_usuario from statictext within w_ge388_gera_token
integer x = 78
integer y = 868
integer width = 1088
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "* Para o usu$$HEX1$$e100$$ENDHEX$$rio XPTO"
boolean focusrectangle = false
end type

type st_2 from statictext within w_ge388_gera_token
integer x = 78
integer y = 804
integer width = 1088
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "* Para redefini$$HEX2$$e700e300$$ENDHEX$$o de Senha"
boolean focusrectangle = false
end type

type st_1 from statictext within w_ge388_gera_token
integer x = 78
integer y = 740
integer width = 1088
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "* Para sistemas de loja"
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_ge388_gera_token
integer x = 375
integer y = 1060
integer width = 389
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Gerar"
boolean default = true
end type

event clicked;String lvs_Matricula
String lvs_Token

dw_1.Accepttext( )

lvs_Matricula = dw_1.Object.nr_matricula [1]
If Not wf_valida_usuario(lvs_Matricula) Then Return -1
If Not wf_valida_data_hora() Then 
	If (ClassName(SQLCa)="transaction" or gvs_Sistema <> "SA") Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Data/Hora n$$HEX1$$e300$$ENDHEX$$o permitida para gera$$HEX2$$e700e300$$ENDHEX$$o de token.", Exclamation!)
		Close(Parent)
		Return -1
	End If
End If

If Not IsNull(lvs_Matricula) and (Len(lvs_Matricula) > 3) And IsNumber(lvs_Matricula) Then
	lvs_Token = wf_gera_token_usuario(lvs_Matricula)
	st_usuario.Text	= '* Para o usu$$HEX1$$e100$$ENDHEX$$rio '+lvs_Matricula
	st_token.Text 	= Mid(lvs_Token,1, 4)+" "+Mid(lvs_Token,5)
	
	//gvo_aplicacao.ivo_seguranca.of_valida_token_usuario( lvs_Token, lvs_Matricula)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe uma matr$$HEX1$$ed00$$ENDHEX$$cula v$$HEX1$$e100$$ENDHEX$$lida!")
	dw_1.SetFocus()
End If

end event

type dw_1 from datawindow within w_ge388_gera_token
event ue_key pbm_dwnkey
integer x = 50
integer y = 84
integer width = 878
integer height = 96
integer taborder = 20
string title = "none"
string dataobject = "dw_ge388_parametro"
boolean border = false
boolean livescroll = true
end type

event ue_key;st_token.Text = ""
end event

type st_token from statictext within w_ge388_gera_token
integer x = 69
integer y = 328
integer width = 1047
integer height = 160
integer textsize = -20
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
alignment alignment = center!
boolean focusrectangle = false
end type

type gb_2 from groupbox within w_ge388_gera_token
integer x = 27
integer y = 220
integer width = 1138
integer height = 336
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
end type

type gb_1 from groupbox within w_ge388_gera_token
integer x = 27
integer y = 4
integer width = 923
integer height = 208
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Par$$HEX1$$e200$$ENDHEX$$metros"
end type

type gb_3 from groupbox within w_ge388_gera_token
integer x = 41
integer y = 588
integer width = 1120
integer height = 440
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Este $$HEX1$$e900$$ENDHEX$$ Token V$$HEX1$$e100$$ENDHEX$$lido Somente"
end type

