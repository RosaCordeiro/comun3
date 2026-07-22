HA$PBExportHeader$dc_w_login_sistema.srw
forward
global type dc_w_login_sistema from dc_w_response
end type
type cb_ok from commandbutton within dc_w_login_sistema
end type
type cb_cancelar from commandbutton within dc_w_login_sistema
end type
type dw_1 from dc_uo_dw_base within dc_w_login_sistema
end type
type cb_procura_digital from commandbutton within dc_w_login_sistema
end type
end forward

global type dc_w_login_sistema from dc_w_response
integer x = 864
integer y = 852
integer width = 1920
integer height = 628
string title = "Identifica$$HEX2$$e700e300$$ENDHEX$$o do Usu$$HEX1$$e100$$ENDHEX$$rio"
cb_ok cb_ok
cb_cancelar cb_cancelar
dw_1 dw_1
cb_procura_digital cb_procura_digital
end type
global dc_w_login_sistema dc_w_login_sistema

type variables
Integer ivi_Tentativas = 1, &
            ivi_Cd_Perfil

Boolean ivb_Perfil

Boolean ivb_Exige_Cadastro_Biometrico = False

uo_GE040_Leitor_Biometrico ivo_Biometria

dc_uo_encript ivo_encript
end variables

forward prototypes
public function integer wf_senha_biometrica ()
public subroutine wf_mostra_campos_senha (boolean pb_mostra)
public subroutine wf_solicita_cadastro_biometrico ()
public function integer wf_habilita_biometria (boolean pb_habilita)
end prototypes

public function integer wf_senha_biometrica ();String ls_Dedos

Integer li_Retorno

ivo_Biometria.of_Dedos_Cadastrados( gvo_Aplicacao.ivo_Seguranca.Nr_Cpf, ref ls_Dedos )

li_Retorno = ivo_Biometria.of_Identifica( gvo_Aplicacao.ivo_Seguranca.Nr_Cpf )

Choose Case li_Retorno
	Case -1
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na inicializa$$HEX2$$e700e300$$ENDHEX$$o do leitor biom$$HEX1$$e900$$ENDHEX$$trico.", StopSign! )
		gvo_Aplicacao.Event ue_Exit( )
		
	Case 0
		ivo_Biometria.of_Dedos_Cadastrados( gvo_Aplicacao.ivo_Seguranca.Nr_Cpf, ref ls_Dedos)
		
		gvo_Aplicacao.ivo_Seguranca.of_Registra_Tentativa_Login( gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, 'Digital n$$HEX1$$e300$$ENDHEX$$o localizada no cadastro', False )
		
		If MessageBox( 'Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Digital n$$HEX1$$e300$$ENDHEX$$o localizada no cadastro.~r~rOs dedos cadastrados para este usu$$HEX1$$e100$$ENDHEX$$rio s$$HEX1$$e300$$ENDHEX$$o: ' + ls_Dedos + '~r~rTentar novamente?', Question!, YesNo! ) = 1 Then
			wf_Senha_Biometrica()
		Else
			cb_Cancelar.Event Clicked()
		End If
		
	Case 1
		gvo_Aplicacao.ivo_Seguranca.ivb_Login_Sucesso = True
		gvo_Aplicacao.of_SetMicroHelp()
		Close( This )
End Choose

Return li_Retorno
end function

public subroutine wf_mostra_campos_senha (boolean pb_mostra);If Not pb_Mostra Then
	dw_1.Object.de_Senha_t.Visible			= False
	dw_1.Object.de_Senha.Visible				= False
	dw_1.Object.Senha_Biometrica_t.Visible	= True
	cb_OK.Visible									= False
Else
	dw_1.Object.de_Senha_t.Visible			= True
	dw_1.Object.de_Senha.Visible				= True
	dw_1.Object.Senha_Biometrica_t.Visible	= False
	cb_OK.Visible									= True
End If
end subroutine

public subroutine wf_solicita_cadastro_biometrico ();If gvo_Aplicacao.ivo_Seguranca.Nr_Cpf = '0' Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi encontrado CPF para este usu$$HEX1$$e100$$ENDHEX$$rio." )
Else
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "A seguir, o sistema ir$$HEX1$$e100$$ENDHEX$$ solicitar o cadastro biom$$HEX1$$e900$$ENDHEX$$trico, por favor realize-o." )
	If ivo_Biometria.of_Cadastra( gvo_Aplicacao.ivo_Seguranca.Nr_Cpf ) Then
		Messagebox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Digital cadastrada com sucesso." )
		
		gvo_Aplicacao.ivo_Seguranca.ivb_Login_Sucesso = True
		gvo_Aplicacao.of_SetMicroHelp()
		Close(This)		
	Else
		gvo_Aplicacao.ivo_Seguranca.ivb_Login_Sucesso = False
		Halt Close
	End If
End If
end subroutine

public function integer wf_habilita_biometria (boolean pb_habilita);If Not ivo_Biometria.ib_Permite_Senha_Digitada Then
	pb_Habilita = True
End If

If pb_Habilita Then
	cb_Ok.Enabled	= False
	dw_1.SetTabOrder( 'de_senha', 0 )
	Return wf_Senha_Biometrica()
Else
	//cb_Ok.Enabled	= True	
	dw_1.SetTabOrder( 'de_senha', 20 )
	dw_1.Event ue_Pos( 1, 'de_senha' )
	Return 1
End If
end function

on dc_w_login_sistema.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
this.cb_cancelar=create cb_cancelar
this.dw_1=create dw_1
this.cb_procura_digital=create cb_procura_digital
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
this.Control[iCurrent+2]=this.cb_cancelar
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.cb_procura_digital
end on

on dc_w_login_sistema.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.cb_cancelar)
destroy(this.dw_1)
destroy(this.cb_procura_digital)
end on

event open;call super::open;This.Center = True
//X = 900
//Y = 750

ivb_Perfil    = gvo_Aplicacao.ivo_Seguranca.id_Perfil_Master
ivi_Cd_Perfil = gvo_Aplicacao.ivo_Seguranca.Cd_Perfil_Usuario
end event

event ue_postopen;call super::ue_postopen;gvo_Aplicacao.ivo_Seguranca.of_Set_Ultimo_Procedimento("")

If gvo_Aplicacao.ivb_Usa_Biometria Then
	ivo_Biometria = Create uo_GE040_Leitor_Biometrico
	ivo_Biometria.of_Permite_Senha_Digitada( )
End If

dw_1.Event ue_AddRow()

If gvo_Aplicacao.ivb_Usa_Biometria Then
	If ProfileString( gvo_Aplicacao.ivs_Arquivo_Ini, "Desenvolvimento", "Procura_Digital", "N" ) = "S" Then
		cb_Procura_Digital.Visible = True
	End If
End If

Choose Case gvo_Aplicacao.ivo_Seguranca.Cd_Sistema
	Case 'EL', 'PC', 'RL', 'TL'
		dw_1.Object.id_persiste_usuario[ 1 ] = 'S'
	Case Else
		dw_1.Object.id_persiste_usuario[ 1 ] = 'N'
End Choose

Try
	If gvo_Aplicacao.ivb_Forca_End_Transaction Then
		SqlCa.of_End_Transaction( )
	End If
Catch( RuntimeError ex )

End Try
end event

event close;call super::close;gvo_Aplicacao.ivo_seguranca.of_set_ultimo_procedimento( "" )

If IsValid(ivo_Biometria) Then
	Destroy(ivo_Biometria)
End If

If Not gvo_Aplicacao.ivo_Seguranca.ivb_Login_Sucesso Then
	gvo_Aplicacao.ivo_Seguranca.id_Perfil_Master  = ivb_Perfil
	gvo_Aplicacao.ivo_Seguranca.cd_Perfil_Usuario = ivi_Cd_Perfil
End If

dw_1.AcceptText( )

If dw_1.Object.id_persiste_usuario[ 1 ] = 'S' Then
	gvo_Aplicacao.ivo_Seguranca.of_Set_Persiste_Usuario( True )
Else
	gvo_Aplicacao.ivo_Seguranca.of_Set_Persiste_Usuario( False )
End If

If IsValid( ivo_encript ) Then Destroy(ivo_encript)
end event

event ue_preopen;call super::ue_preopen;ivo_encript = Create dc_uo_encript

If gvo_Aplicacao.ivb_Usa_Biometria Then
	ivo_Biometria = Create uo_GE040_Leitor_Biometrico
	ivo_Biometria.of_Permite_Senha_Digitada( )
	
//	If ivo_Biometria.ib_Permite_Senha_Digitada Then
//		wf_Mostra_Campos_Senha( True )
//	Else
		wf_Mostra_Campos_Senha( False )
//	End If
Else
	wf_Mostra_Campos_Senha( True )
End If
end event

type pb_help from dc_w_response`pb_help within dc_w_login_sistema
end type

type cb_ok from commandbutton within dc_w_login_sistema
integer x = 1216
integer y = 420
integer width = 311
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "O&K"
boolean default = true
end type

event clicked;String lvs_De_Senha
String lvs_Token
String ls_Senha_Expirada = 'N'

Integer lvi_Retorno

Boolean lvb_Alt_Senha

dw_1.AcceptText()
lvs_De_Senha = Trim(dw_1.Object.De_Senha[1])

If lvs_De_Senha <> "" Then
	//Encripta Senha para compara$$HEX2$$e700e300$$ENDHEX$$o
	If gvo_Aplicacao.ivo_Seguranca.id_senha_criptografada Then lvs_De_Senha = ivo_encript.of_encripta(lvs_De_Senha)
	//Senha diferente da digitada?
	If lvs_De_Senha <> gvo_Aplicacao.ivo_Seguranca.De_Senha Then
		//Se forem apenas n$$HEX1$$fa00$$ENDHEX$$meros verifica se $$HEX1$$e900$$ENDHEX$$ um token v$$HEX1$$e100$$ENDHEX$$lido para redefini$$HEX2$$e700e300$$ENDHEX$$o de senha
		lvs_Token = gf_replace(Trim(dw_1.Object.De_Senha[1])," ","",0)
		If IsNumber(lvs_Token) Then
			If gvo_aplicacao.ivo_seguranca.of_valida_token_usuario( lvs_Token, gvo_Aplicacao.ivo_Seguranca.Nr_Matricula) Then
				OpenWithParm(dc_w_alteracao_senha,lvs_Token)
				lvi_retorno = Message.DoubleParm
				If lvi_Retorno = 0 Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A senha do usu$$HEX1$$e100$$ENDHEX$$rio "+gvo_Aplicacao.ivo_Seguranca.Nm_Usuario+" deve ser alterada para continuar o acesso.", Information!, Ok!)
					gvo_Aplicacao.ivo_Seguranca.ivb_Login_Sucesso = False
					gvo_Aplicacao.Event ue_Exit( )
				Else
					lvb_Alt_Senha = True
			
					If ivb_Exige_Cadastro_Biometrico Then
						wf_Solicita_Cadastro_Biometrico( )
					End If
					
					gvo_Aplicacao.ivo_Seguranca.ivb_Login_Sucesso = True
					gvo_Aplicacao.of_SetMicroHelp()
					gvo_Aplicacao.ivo_Seguranca.of_Registra_Tentativa_Login( gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, 'Login com sucesso', True )		
					Close(Parent)		
				End If	
			End If
		End If
		
		If Not lvb_Alt_Senha Then
			//Desabilita o bot$$HEX1$$e300$$ENDHEX$$o de OK para n$$HEX1$$e300$$ENDHEX$$o haver bloqueio de usu$$HEX1$$e100$$ENDHEX$$rio sem que a senha seja alterada
			cb_ok.Enabled = False
			//Retorna o n$$HEX1$$ba00$$ENDHEX$$ de tentativas incorretas de login para este usu$$HEX1$$e100$$ENDHEX$$rio nos $$HEX1$$fa00$$ENDHEX$$ltimos 3 minutos (180 segundos)
			ivi_Tentativas = gvo_Aplicacao.ivo_Seguranca.Of_Get_Tentativas_Login(gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, 180) + 1
			//Verifica se esta matricula j$$HEX1$$e100$$ENDHEX$$ excedeu o n$$HEX1$$ba00$$ENDHEX$$ de tentativas de login
			If ivi_Tentativas < gvo_Aplicacao.ivo_Seguranca.Limite_Tentativa_Login Then
				//Grava a tentativa de login no banco de dados
				gvo_Aplicacao.ivo_Seguranca.of_Registra_Tentativa_Login( gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, 'Senha incorreta', False )
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Senha incorreta, tente novamente.~r~rTentativa(s) restante(s): "+String(gvo_Aplicacao.ivo_Seguranca.Limite_Tentativa_Login - ivi_Tentativas), Exclamation!, Ok!)
				dw_1.Event ue_Pos(1, "de_senha")
			Else
				//Grava a tentativa de login no banco de dados
				gvo_Aplicacao.ivo_Seguranca.of_Registra_Tentativa_Login( gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, 'Limite de tentativas esgotado', False )
				//Limpa o $$HEX1$$fa00$$ENDHEX$$ltimo procedimento, caso exista
				gvo_Aplicacao.ivo_Seguranca.of_Set_Ultimo_Procedimento("")
				//Bloqueia o usu$$HEX1$$e100$$ENDHEX$$rio
				gvo_Aplicacao.ivo_Seguranca.of_bloqueia_usuario(gvo_Aplicacao.ivo_Seguranca.Nr_Matricula)	
				gvo_Aplicacao.ivo_Seguranca.ivb_Login_Sucesso = False
				gvo_Aplicacao.Event ue_Exit( )
			End If
		End If
	Else
		If (gvo_Aplicacao.ivo_Seguranca.De_Senha = ivo_encript.of_encripta(gvo_Aplicacao.ivo_Seguranca.Nr_Matricula) or &
			(gvo_Aplicacao.ivo_Seguranca.of_get_senha_expirada(True))) Then
			
			If gvo_Aplicacao.ivo_Seguranca.De_Senha = ivo_encript.of_encripta(gvo_Aplicacao.ivo_Seguranca.Nr_Matricula) Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Para o seu primeiro acesso a este sistema ser$$HEX1$$e100$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio alterar a senha.", Information!, Ok!)
			End If
			
			If gvo_Aplicacao.ivo_Seguranca.of_get_senha_expirada(False) Then
				ls_Senha_Expirada = 'S'		
			End If
			
			OpenWithParm( dc_w_alteracao_senha, ls_Senha_Expirada )
			lvi_retorno = Message.DoubleParm
			If lvi_Retorno = 0 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A senha do usu$$HEX1$$e100$$ENDHEX$$rio "+gvo_Aplicacao.ivo_Seguranca.Nm_Usuario+" deve ser alterada para continuar o acesso.", Information!, Ok!)
				gvo_Aplicacao.ivo_Seguranca.ivb_Login_Sucesso = False
				gvo_Aplicacao.Event ue_Exit( )
			End If
			
			gvo_Aplicacao.ivo_Seguranca.of_Registra_Tentativa_Login( gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, 'Altera$$HEX2$$e700e300$$ENDHEX$$o de senha', False )
		End If
		
		If ivb_Exige_Cadastro_Biometrico Then
			wf_Solicita_Cadastro_Biometrico( )
		End If
		
		gvo_Aplicacao.ivo_Seguranca.ivb_Login_Sucesso = True
		gvo_Aplicacao.of_SetMicroHelp()
		gvo_Aplicacao.ivo_Seguranca.of_Registra_Tentativa_Login( gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, 'Login com sucesso', True )		
		Close(Parent)		
	End If
Else
	gvo_Aplicacao.ivo_Seguranca.of_Registra_Tentativa_Login( gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, 'Senha n$$HEX1$$e300$$ENDHEX$$o informada', False )
	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a senha do usu$$HEX1$$e100$$ENDHEX$$rio.", Information!, Ok!)
	dw_1.SetFocus()
	dw_1.SetColumn("de_senha")
End If
end event

type cb_cancelar from commandbutton within dc_w_login_sistema
integer x = 1550
integer y = 420
integer width = 311
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Cancelar"
boolean cancel = true
end type

event clicked;gvo_Aplicacao.ivo_Seguranca.ivb_Login_Sucesso = False

gvo_Aplicacao.Event ue_Exit( )
end event

type dw_1 from dc_uo_dw_base within dc_w_login_sistema
integer x = 5
integer y = 20
integer width = 1865
integer height = 400
string dataobject = "dc_dw_login_sistema"
end type

event itemchanged;call super::itemchanged;String lvs_Nr_Matricula

If Not(SQLCa.of_IsConnected()) Then
	If IsValid(gvo_Aplicacao) then
		If gvo_Aplicacao.ivb_Usa_Timer_Out Then	
			gvo_Aplicacao.of_Connect()
			Idle(gvo_Aplicacao.ivi_Timer_Idle)
		End If
	End If
End If

Choose Case dwo.Name
	Case "nr_matricula"
		// Verifica se o usu$$HEX1$$e100$$ENDHEX$$rio digitado existe
		This.AcceptText()
		lvs_Nr_Matricula = String( This.Object.Nr_Matricula[1] )
		
		gvo_Aplicacao.ivo_Seguranca.of_Localiza_Usuario( lvs_Nr_Matricula )
		
		If Not gvo_Aplicacao.ivo_Seguranca.ivb_Usuario_Localizado Then
			cb_Ok.Enabled = False
			Return 1
		Else
			This.Object.Nm_Usuario[1] = gvo_Aplicacao.ivo_Seguranca.Nm_Usuario
			
			If gvo_Aplicacao.ivb_Usa_Biometria Then
				// Biometria
				
				If gvo_Aplicacao.ivo_Seguranca.Id_Isento_Biometria = 'N' Then
					wf_Mostra_Campos_Senha( False )
					
					If ivo_Biometria.of_Inicializa( ) Then
						If ivo_Biometria.of_Existe_Digital_Cadastrada( gvo_Aplicacao.ivo_Seguranca.Nr_Cpf ) Then
							wf_Habilita_Biometria( True )
						Else
							ivb_Exige_Cadastro_Biometrico	= True
							
							wf_Mostra_Campos_Senha( True)
							cb_Ok.Enabled	= True	
							dw_1.SetTabOrder( 'de_senha', 20 )
							dw_1.Event ue_Pos( 1, 'de_senha' )
						End If
					Else
						wf_Habilita_Biometria( False )
						
						If ivo_Biometria.ib_Permite_Senha_Digitada Then
							wf_Mostra_Campos_Senha( True )
						End If
					End If
				Else
					wf_Mostra_Campos_Senha( True)
					cb_Ok.Enabled	= True	
					dw_1.SetTabOrder( 'de_senha', 20 )
					dw_1.Event ue_Pos( 1, 'de_senha' )
				End If
			Else
				wf_Mostra_Campos_Senha( True)
				cb_Ok.Enabled	= True	
				dw_1.SetTabOrder( 'de_senha', 20 )
				dw_1.Event ue_Pos( 1, 'de_senha' )
			End If
			//	
		End If
End Choose 
end event

event clicked;//OverRide
Try
	If Row > 0 Then This.SetRow(Row)

	String lvs_titulo
	String lvs_coluna
	String lvs_sort_atual
	String lvs_Cabecalho
	
	Integer lvi_tamanho
	
	If This.RowCount() > 0 and ivb_Ordena_Colunas and Row = 0 Then
	
		lvs_titulo 		= This.GetObjectAtPointer()
		lvs_Cabecalho  = This.GetBandAtPointer()
			
		If LeftA(lvs_Cabecalho, 6) = "header" Then
			
			lvi_tamanho = PosA(lvs_titulo,CharA(9))-1
			
			If lvi_tamanho > 0 Then
				
				lvs_titulo = LeftA(lvs_titulo, lvi_tamanho)
				
				This.of_Marca_Coluna_Ativa_Ordenacao(lvs_titulo)
				
				lvs_Coluna = LeftA(lvs_Titulo,lvi_Tamanho -2 )
						
				lvs_sort_atual = This.Object.DataWindow.Table.Sort
				
				lvi_tamanho 	= LenA(lvs_sort_atual) - 2
				lvs_titulo  	= LeftA(lvs_sort_atual, lvi_tamanho)
				
				If lvs_coluna = lvs_titulo Then
					
					lvs_sort_atual = RightA(lvs_sort_atual, 1)
					
					If lvs_sort_atual = "A" Then
						lvs_sort_atual = " D"
					Else
						lvs_sort_atual = " A"
					End If
					
					lvs_coluna = lvs_coluna + lvs_sort_atual
				Else
					lvs_coluna += " A"				
				End If
				
				This.SetSort(lvs_coluna)
				This.Sort()
				
			End If	
			
		End If
		
	End If	
Catch ( runtimeerror  lo_rte )
	//Caso o usu$$HEX1$$e100$$ENDHEX$$rio clique no campo senha, causava erro e fechava o sistema
//	MessageBox (	"Erro", "Ocorreu erro ao clicar na DW. ~r~r"+ &
// 						"Erro: "+lo_rte.GetMessage( ) + "~r~r" + &
//						 "Caso esteja utilizando leitor biom$$HEX1$$e900$$ENDHEX$$trico, ap$$HEX1$$f300$$ENDHEX$$s digitar o n$$HEX1$$fa00$$ENDHEX$$mero da matr$$HEX1$$ed00$$ENDHEX$$cula para liberar um procedimento, " + &
//						 "pressione [TAB] no teclado ao inv$$HEX1$$e900$$ENDHEX$$s de clicar sobre o campo [Senha] com o mouse.", StopSign! )
Finally	
//	Return 1
End Try
end event

event editchanged;call super::editchanged;If Dwo.Name = 'de_senha' Then
	cb_ok.Enabled = True
End If
end event

type cb_procura_digital from commandbutton within dc_w_login_sistema
boolean visible = false
integer x = 32
integer y = 420
integer width = 489
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Procurar Digital"
end type

event clicked;uo_ge040_leitor_biometrico lo_Leitor

lo_Leitor = Create uo_ge040_leitor_biometrico

lo_Leitor.of_Procura_Digital()

Destroy(lo_Leitor)
end event

