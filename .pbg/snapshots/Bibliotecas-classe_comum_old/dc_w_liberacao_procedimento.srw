HA$PBExportHeader$dc_w_liberacao_procedimento.srw
forward
global type dc_w_liberacao_procedimento from dc_w_response
end type
type cb_ok from commandbutton within dc_w_liberacao_procedimento
end type
type cb_cancelar from commandbutton within dc_w_liberacao_procedimento
end type
type dw_1 from dc_uo_dw_base within dc_w_liberacao_procedimento
end type
end forward

global type dc_w_liberacao_procedimento from dc_w_response
integer x = 873
integer y = 840
integer width = 1925
integer height = 732
string title = "Libera$$HEX2$$e700e300$$ENDHEX$$o de Procedimentos"
boolean controlmenu = false
long backcolor = 80269524
boolean center = true
cb_ok cb_ok
cb_cancelar cb_cancelar
dw_1 dw_1
end type
global dc_w_liberacao_procedimento dc_w_liberacao_procedimento

type variables
Boolean ivb_Exige_Cadastro_Biometrico = False

Integer ivi_Tentativas = 1

dc_uo_seguranca ivo_seguranca

String ivs_retorno

uo_GE040_Leitor_Biometrico ivo_Biometria
dc_uo_encript ivo_encript
end variables

forward prototypes
public function string wf_descricao_procedimento ()
public function integer wf_senha_biometrica ()
public subroutine wf_habilita_biometria (boolean pb_habilita)
public subroutine wf_mostra_campos_senha (boolean pb_mostra)
public subroutine wf_solicita_cadastro_biometrico ()
public function boolean wf_registra_gerente_trainee ()
end prototypes

public function string wf_descricao_procedimento ();String lvs_Descricao

Select de_procedimento Into :lvs_Descricao
From procedimento_sistema
Where cd_sistema      = :This.ivo_Seguranca.Cd_Sistema
  and cd_procedimento = :This.ivo_Seguranca.Cd_Procedimento
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Procedimento '" + This.ivo_Seguranca.Cd_Procedimento + "' do sistema '" + &
		                      This.ivo_Seguranca.Cd_Sistema + "' n$$HEX1$$e300$$ENDHEX$$o localizado.", StopSign!)
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do procedimento '" + This.ivo_Seguranca.Cd_Procedimento + "' do sistema '" + &
		                      This.ivo_Seguranca.Cd_Sistema + "'.", StopSign!)		
End Choose

Return lvs_Descricao
end function

public function integer wf_senha_biometrica ();String ls_Dedos

Integer li_Retorno

ivo_Biometria.of_Dedos_Cadastrados( ivo_Seguranca.Nr_Cpf, ref ls_Dedos )

li_Retorno = ivo_Biometria.of_Identifica( ivo_Seguranca.Nr_Cpf )

Choose Case li_Retorno
	Case -1
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na inicializa$$HEX2$$e700e300$$ENDHEX$$o do leitor biom$$HEX1$$e900$$ENDHEX$$trico.", StopSign! )
		cb_Cancelar.Event Clicked()
		// Erro
		
	Case 0
		ivo_Biometria.of_Dedos_Cadastrados( ivo_Seguranca.Nr_Cpf, ref ls_Dedos)

		ivo_Seguranca.of_Registra_Tentativa_Login( ivo_Seguranca.Nr_Matricula, 'Digital n$$HEX1$$e300$$ENDHEX$$o localizada no cadastro', False, "B" )

		If MessageBox( 'Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Digital n$$HEX1$$e300$$ENDHEX$$o localizada no cadastro.~r~rOs dedos cadastrados para este usu$$HEX1$$e100$$ENDHEX$$rio s$$HEX1$$e300$$ENDHEX$$o: ' + ls_Dedos + '~r~rTentar novamente?', Question!, YesNo!  ) = 1 Then
			wf_Senha_Biometrica()
		Else
			cb_Cancelar.Event Clicked()
		End If
		
	Case 1
		ivo_Seguranca.ivb_Login_Sucesso = True
		gvo_Aplicacao.ivo_Seguranca.ivb_liberacao_com_biometria = True
		ivs_Retorno						=  ivo_Seguranca.Nr_Matricula
		ivo_Seguranca.of_Registra_Tentativa_Login( gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, 'Login com sucesso', True, "B" )
		gvo_Aplicacao.of_SetMicroHelp()
		CloseWithReturn( This, ivs_Retorno )
//		cb_Ok.Event Clicked()
End Choose

Return li_Retorno
end function

public subroutine wf_habilita_biometria (boolean pb_habilita);If Not ivo_Biometria.ib_Permite_Senha_Digitada Then
	pb_Habilita = True
End If

If pb_Habilita Then
	cb_Ok.Enabled	= False
	dw_1.SetTabOrder( 'de_senha', 0 )
	wf_Senha_Biometrica()
Else
	//cb_Ok.Enabled	= True	
	dw_1.SetTabOrder( 'de_senha', 20 )
	dw_1.Event ue_Pos( 1, 'de_senha' )
End If
end subroutine

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
	dw_1.Event ue_Pos( 1, 'de_senha' )
End If
end subroutine

public subroutine wf_solicita_cadastro_biometrico ();If ivo_Seguranca.Nr_Cpf = '0' Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi encontrado CPF para este usu$$HEX1$$e100$$ENDHEX$$rio." )
Else
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "A seguir, o sistema ir$$HEX1$$e100$$ENDHEX$$ solicitar o cadastro biom$$HEX1$$e900$$ENDHEX$$trico, por favor realize-o." )
	If ivo_Biometria.of_Cadastra( ivo_Seguranca.Nr_Cpf ) Then
		Messagebox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Digital cadastrada com sucesso." )
	Else
		ivo_Seguranca.ivb_Login_Sucesso = False
		Halt Close
	End If
End If
end subroutine

public function boolean wf_registra_gerente_trainee ();/* Autor: Fernando Lu$$HEX1$$ed00$$ENDHEX$$s Cambiaghi
 *	Data: 05/11/2015
 *	Fun$$HEX2$$e700e300$$ENDHEX$$o para trocar usu$$HEX1$$e100$$ENDHEX$$rio de filial e enviar email para o gerente regional quando:
 * - O sistema for Retaguarda Loja
 * - O perfil for GERENTE TRAINEE ( cd_perfil_usuario = 8 ) 
 * - O perfil for GERENTE ( cd_perfil_usuario = 1 ) 
 */

Long ll_Filial
Long ll_Filial_Matriz
Long ll_Filial_Usuario

String ls_Retorno_Distribuido
String ls_De_Perfil
String ls_ComputerName
String ls_Procedimento
String ls_Parametros_Script

If This.ivo_Seguranca.Cd_Procedimento <> "" Then
	ls_Procedimento = wf_Descricao_Procedimento()
Else
	ls_Procedimento = "VERIFICA$$HEX2$$c700c300$$ENDHEX$$O DE ACESSO"
End If


// Se n$$HEX1$$e300$$ENDHEX$$o efetuou login com sucesso, n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio registrar nada
If Not ivo_Seguranca.ivb_Login_Sucesso Then Return True

If Trim( ivo_Seguranca.cd_Sistema ) <> 'RL' Then Return True // Somente o Retaguarda registra a troca de filial

If ivo_Seguranca.cd_Perfil_Usuario <> 8 And ivo_Seguranca.cd_Perfil_Usuario <> 1 Then Return True // Somente Gerente / Gerente Trainee registra a troca de filial

If ivo_Seguranca.cd_Perfil_Usuario = 8 Then ls_De_Perfil = 'GERENTE TRAINEE'
If ivo_Seguranca.cd_Perfil_Usuario = 1 Then ls_De_Perfil = 'GERENTE'

If Not gf_Filiais_Parametro( Ref ll_Filial, Ref ll_Filial_Matriz ) Then Return False

SELECT cd_filial
    INTO :ll_filial_usuario
  FROM usuario
WHERE nr_matricula = :ivo_Seguranca.nr_Matricula
 USING SqlCa;
 
If SqlCa.SqlCode = -1 Then
	SqlCa.of_RollBack( )
	SqlCa.of_MsgDbError( "Consulta filial do usu$$HEX1$$e100$$ENDHEX$$rio '" + ivo_Seguranca.nr_Matricula + "'." )
	Return False
End If

If ll_Filial_Usuario = ll_Filial Then Return True

ll_Filial = ll_Filial

DELETE
  FROM usuario_sistema
WHERE nr_matricula = :ivo_Seguranca.nr_Matricula
 USING SqlCa;
 
If SqlCa.SqlCode = -1 Then
	SqlCa.of_RollBack( )
	SqlCa.of_MsgDbError( "Exclus$$HEX1$$e300$$ENDHEX$$o dos perfis do usu$$HEX1$$e100$$ENDHEX$$rio '" + ivo_Seguranca.nr_Matricula + "'." )
	Return False
End If
 
 INSERT
	INTO usuario_sistema (	cd_sistema,
									nr_matricula,
									cd_perfil_usuario )
	SELECT	cd_sistema,
				:ivo_Seguranca.nr_Matricula,
				cd_perfil_usuario
	FROM	perfil_usuario
  WHERE	de_perfil_usuario = :ls_De_Perfil
   USING SqlCa;
					
If SqlCa.SqlCode = -1 Then
	SqlCa.of_RollBack( )
	SqlCa.of_MsgDbError( "Inclus$$HEX1$$e300$$ENDHEX$$o do perfil do usu$$HEX1$$e100$$ENDHEX$$rio '" + ivo_Seguranca.nr_Matricula + "'." )
	Return False
End If

UPDATE usuario
	 SET	cd_filial					= :ll_Filial,
	 		cd_filial_atualizacao	= :ll_Filial,
			dh_atualizacao_filial	= getdate( )
  WHERE nr_matricula =:ivo_Seguranca.nr_Matricula
   USING SqlCa;
	
If SqlCa.SqlCode = -1 Then
	SqlCa.of_RollBack( )
	SqlCa.of_MsgDbError( "Atualiza$$HEX2$$e700e300$$ENDHEX$$o da filial do usu$$HEX1$$e100$$ENDHEX$$rio '" + ivo_Seguranca.nr_Matricula + "'." )
	Return False
End If

// Envia email para o gerente regional comunicando o login na filial
Try
	ls_ComputerName = gvo_Aplicacao.is_ComputerName
	
	If IsNull( ls_Procedimento ) Or Trim( ls_Procedimento ) = "" Then ls_Procedimento = "NI"
	
	uo_transacao_remota lo // GE105
	lo = Create uo_transacao_remota
	
	ls_Parametros_Script = 'cd_filial_atual=' + String( ll_Filial ) + '&nr_matricula=' + ivo_Seguranca.nr_Matricula + '&cd_perfil_usuario=' + String( ivo_Seguranca.cd_Perfil_Usuario ) + '&nm_pdv=' + ls_ComputerName + '&de_procedimento=' + ls_Procedimento
	
	If Not lo.of_executa_rotina_intranet( 'email_trainee_troca_filial',  ls_Parametros_Script ) Then
		SqlCa.of_RollBack( )
		Return True
	End If

	ls_Retorno_Distribuido = lo.of_Retorno_Dados_Intranet( ) 

	If LeftA( ls_Retorno_Distribuido, 7 ) <> 'SUCESSO' Then 
		SqlCa.of_RollBack( )
		Return True
	End If	
	
Finally
	Destroy lo
	
End Try

SqlCa.of_Commit( )

Return True

end function

on dc_w_liberacao_procedimento.create
int iCurrent
call super::create
this.cb_ok=create cb_ok
this.cb_cancelar=create cb_cancelar
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_ok
this.Control[iCurrent+2]=this.cb_cancelar
this.Control[iCurrent+3]=this.dw_1
end on

on dc_w_liberacao_procedimento.destroy
call super::destroy
destroy(this.cb_ok)
destroy(this.cb_cancelar)
destroy(this.dw_1)
end on

event open;call super::open;String lvs_Descricao

SetNull(ivs_Retorno)

ivo_Seguranca = Message.PowerObjectParm

If Not ivo_Seguranca.ivb_Habilita_Cancelar Then
	This.cb_Cancelar.Enabled = False
End If

If This.ivo_Seguranca.Cd_Procedimento <> "" Then
	lvs_Descricao = wf_Descricao_Procedimento()
Else
	lvs_Descricao = "VERIFICA$$HEX2$$c700c300$$ENDHEX$$O DE ACESSO"
End If

dw_1.InsertRow(0)
dw_1.Object.Cd_Procedimento[1] = This.ivo_Seguranca.Cd_Procedimento

If Trim(lvs_Descricao) <> "" Then
	dw_1.Object.De_Procedimento[1] = lvs_Descricao
	X = 900
	Y = 750	
Else
	SetNull(lvs_Descricao)
	CloseWithReturn(This, lvs_Descricao)
End If
end event

event close;call super::close;If IsValid( ivo_Biometria ) Then Destroy ivo_Biometria

This.wf_Registra_Gerente_Trainee( )

If IsValid( ivo_encript ) Then Destroy(ivo_encript)

CloseWithReturn(This,ivs_Retorno)

end event

event ue_postopen;call super::ue_postopen;ivo_Biometria = Create uo_GE040_Leitor_Biometrico

dw_1.Event ue_Pos( 1, 'nr_matricula' )
wf_Mostra_Campos_Senha( gvo_Aplicacao.ivb_Permite_Senha_Digitada )

//If gvo_Aplicacao.ivb_Usa_Biometria Then
//	ivo_Biometria.of_Permite_Senha_Digitada( )
//End If

If gvo_Aplicacao.ivo_Seguranca.of_Get_Persiste_Usuario( ) Then
	dw_1.Object.Nr_Matricula[ 1 ] = gvo_Aplicacao.ivo_Seguranca.of_Get_Nr_Matricula_Persiste( )
	dw_1.AcceptText( )
	dw_1.Event itemchanged( 1, dw_1.Object.Nr_Matricula, gvo_Aplicacao.ivo_Seguranca.of_Get_Nr_Matricula_Persiste( ) )
	
	If IsValid( This ) Then 
		dw_1.AcceptText()
		dw_1.Event ue_Pos( 1, 'de_senha' )
	End If
Else
	dw_1.Event ue_Pos( 1, 'nr_matricula' )
End If

Try
	If gvo_Aplicacao.ivb_Forca_End_Transaction Then
		SqlCa.of_End_Transaction( )
	End If
Catch( RuntimeError ex )

End Try
end event

event ue_preopen;call super::ue_preopen;ivo_encript = Create dc_uo_encript

//If gvo_Aplicacao.ivb_Usa_Biometria Then
//	ivo_Biometria = Create uo_GE040_Leitor_Biometrico
//	ivo_Biometria.of_Permite_Senha_Digitada( )
//	
////	If ivo_Biometria.ib_Permite_Senha_Digitada Then
////		wf_Mostra_Campos_Senha( True )
////	Else
//		wf_Mostra_Campos_Senha( False )
////	End If
//Else
//	wf_Mostra_Campos_Senha( True )
//End If
end event

type pb_help from dc_w_response`pb_help within dc_w_liberacao_procedimento
end type

type cb_ok from commandbutton within dc_w_liberacao_procedimento
integer x = 1147
integer y = 504
integer width = 347
integer height = 108
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
Integer lvi_Retorno


dw_1.AcceptText()
lvs_De_Senha = Trim(dw_1.Object.De_Senha[1])

//Grava o procedimento no qual as tentativas foram realizadas
ivo_Seguranca.of_Set_Ultimo_Procedimento(dw_1.Object.cd_procedimento[1])

If lvs_De_Senha <> "" Then
	//Encripta Senha para compara$$HEX2$$e700e300$$ENDHEX$$o
	If ivo_Seguranca.id_senha_criptografada Then lvs_De_Senha = ivo_encript.of_encripta(lvs_De_Senha)
	//Senha diferente da digitada?
	If lvs_De_Senha <> ivo_Seguranca.De_Senha Then
		//Desabilita bot$$HEX1$$e300$$ENDHEX$$o OK para n$$HEX1$$e300$$ENDHEX$$o haver repetidas tentativas sem altera$$HEX2$$e700e300$$ENDHEX$$o da senha
		cb_ok.Enabled = False
		//Retorna o n$$HEX1$$ba00$$ENDHEX$$ de tentativas incorretas de login para este usu$$HEX1$$e100$$ENDHEX$$rio nos $$HEX1$$fa00$$ENDHEX$$ltimos 60 minutos (3600 segundos)
		ivi_Tentativas = ivo_Seguranca.Of_Get_Tentativas_Login(ivo_Seguranca.Nr_Matricula, 3600) + 1
		//Verifica se esta matricula j$$HEX1$$e100$$ENDHEX$$ excedeu o n$$HEX1$$ba00$$ENDHEX$$ de tentativas de login			
		If ivi_Tentativas < ivo_Seguranca.Limite_Tentativa_Login Then
			//Grava a tentativa de login no banco de dados
			ivo_Seguranca.of_Registra_Tentativa_Login( ivo_Seguranca.Nr_Matricula, 'Senha incorreta', False, "D" )
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Senha incorreta, tente novamente.~r~rTentativa(s) restante(s): "+String(ivo_Seguranca.Limite_Tentativa_Login - ivi_Tentativas), Exclamation!, Ok!)
			
			dw_1.Event ue_Pos(1, "de_senha")	
		Else
			//Grava a tentativa de login no banco de dados
			ivo_Seguranca.of_Registra_Tentativa_Login( ivo_Seguranca.Nr_Matricula, 'Limite de tentativas esgotado', False, "D" )
			//Bloqueia o usu$$HEX1$$e100$$ENDHEX$$rio
			ivo_Seguranca.of_bloqueia_usuario(ivo_Seguranca.Nr_Matricula)	
		
			ivs_Retorno = "CANCEL"
			Parent.Event Close( )
		End If
		
	ElseIf Not ivo_seguranca.of_get_senha_expirada(False) or (dw_1.Object.cd_procedimento[1] = "" and dw_1.Object.de_procedimento[1]="VERIFICA$$HEX2$$c700c300$$ENDHEX$$O DE ACESSO") Then
		ivo_Seguranca.ivb_Login_Sucesso = True
		ivs_Retorno = ivo_Seguranca.Nr_Matricula
		ivo_Seguranca.of_Registra_Tentativa_Login( ivo_Seguranca.Nr_Matricula, 'Login com Sucesso', True, "D" )
		
		If  ivb_Exige_Cadastro_Biometrico Then
			wf_Solicita_Cadastro_Biometrico( )
		End If

		Parent.Event Close( )
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Sua senha expirou!~r~rPara definir uma nova senha acesse: 'Arquivo -> Alterar Senha'", Exclamation!, Ok!)
		ivo_Seguranca.ivb_Login_Sucesso = False
		ivs_Retorno = "CANCEL"
		Parent.Event Close( )
	End If
Else
	ivo_Seguranca.of_Registra_Tentativa_Login( ivo_Seguranca.Nr_Matricula, 'Senha n$$HEX1$$e300$$ENDHEX$$o informada', False, "D")
	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a senha do usu$$HEX1$$e100$$ENDHEX$$rio.", Information!, Ok!)
	dw_1.SetFocus()
	dw_1.SetColumn("de_senha")
End If
end event

type cb_cancelar from commandbutton within dc_w_liberacao_procedimento
integer x = 1522
integer y = 504
integer width = 347
integer height = 108
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

event clicked;ivs_Retorno = "CANCEL"

Close(Parent)
end event

type dw_1 from dc_uo_dw_base within dc_w_liberacao_procedimento
integer x = 5
integer y = 4
integer width = 1888
integer height = 496
boolean bringtotop = true
string dataobject = "dc_dw_liberacao_procedimento"
end type

event itemchanged;call super::itemchanged;String lvs_Nr_Matricula

Boolean lb_Leitor_Conectado

Try
	Choose Case dwo.Name
		Case "nr_matricula"
			// Verifica se o usu$$HEX1$$e100$$ENDHEX$$rio digitado existe
			This.AcceptText()
			lvs_Nr_Matricula = String( This.Object.Nr_Matricula[1] )
			
			ivo_Seguranca.of_Localiza_Usuario( lvs_Nr_Matricula )
			
			If Not ivo_Seguranca.ivb_Usuario_Localizado Then
				cb_Ok.Enabled = False
				Return 1
			End If
			
			This.Object.Nm_Usuario[1] = ivo_Seguranca.Nm_Usuario
			
			lb_Leitor_Conectado = ivo_Biometria.of_Inicializa( )
	
			If ( Not gvo_Aplicacao.ivb_Usa_Biometria ) Or ( ivo_Seguranca.Id_Isento_Biometria = 'S' ) &
				Or ( gvo_Aplicacao.ivb_Permite_Senha_Digitada And Not lb_Leitor_Conectado ) Then
				wf_Mostra_Campos_Senha( True )
				Return 0
			End If
				
			If Not gvo_Aplicacao.ivb_Permite_Senha_Digitada Then
				// Se nao permite senha digitada e nao consegue inicializar o leitor, retorna
				wf_Mostra_Campos_Senha( gvo_Aplicacao.ivb_Permite_Senha_Digitada )
	
				If ivo_Biometria.of_Existe_Digital_Cadastrada( ivo_Seguranca.Nr_Cpf ) Then
				// Se possui digital cadastrada, solicita biometria
					wf_Habilita_Biometria( True )
					Return 0
				End If
	
				// nao tem cadastro biometrico, solicita cadastro mediante digitacao de senha
				ivb_Exige_Cadastro_Biometrico	= True
				
				If Not lb_Leitor_Conectado Then
					MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "$$HEX1$$c900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio ter o leitor biom$$HEX1$$e900$$ENDHEX$$trico instalado no computador para prosseguir.", StopSign! )
					gvo_Aplicacao.ivo_Seguranca.ivb_Login_Sucesso = False
					Halt Close
				End If
			
			End If
			
			wf_Mostra_Campos_Senha( True )
			
	End Choose
	
	
	
//	If dwo.Name = "nr_matricula" Then
//		// Verifica se o usu$$HEX1$$e100$$ENDHEX$$rio digitado existe
//		This.AcceptText()
//		lvs_Nr_Matricula = String( This.Object.Nr_Matricula[1] )
//		
//		ivo_Seguranca.of_Localiza_Usuario( lvs_Nr_Matricula )
//		
//		If Not ivo_Seguranca.ivb_Usuario_Localizado Then
//			cb_Ok.Enabled = False
//			Return 1
//		Else
//			This.Object.Nm_Usuario[1] = ivo_Seguranca.Nm_Usuario
//			
//			If gvo_Aplicacao.ivb_Usa_Biometria Then 
//				// Biometria
//				
//				If ivo_Seguranca.Id_Isento_Biometria = 'N' Then
//					wf_Mostra_Campos_Senha( False )
//
//					If ivo_Biometria.of_Inicializa( ) Then
//						If ivo_Biometria.of_Existe_Digital_Cadastrada( ivo_Seguranca.Nr_Cpf ) Then
//							wf_Habilita_Biometria( True )
//						Else
//							ivb_Exige_Cadastro_Biometrico	= True
//							
//							cb_Ok.Enabled	= True	
//							dw_1.SetTabOrder( 'de_senha', 20 )
//							wf_Mostra_Campos_Senha( True )
//							dw_1.Event ue_Pos( 1, 'de_senha' )
//						End If
//					Else
//						wf_Habilita_Biometria( False )
//						
//						If ivo_Biometria.ib_Permite_Senha_Digitada Then
//							wf_Mostra_Campos_Senha( True )
//						End If
//					End If
//				Else
//					cb_Ok.Enabled	= True	
//					dw_1.SetTabOrder( 'de_senha', 20 )
//					wf_Mostra_Campos_Senha( True )
//					dw_1.Event ue_Pos( 1, 'de_senha' )
//				End If
//			Else
//				cb_Ok.Enabled	= True
//				dw_1.SetTabOrder( 'de_senha', 20 )
//				wf_Mostra_Campos_Senha( True )
//				dw_1.Event ue_Pos( 1, 'de_senha' )
//			End If
//			//	
//		End If
//	End If // dwo.Name = "nr_matricula"
	
Catch( RuntimeError ru )
End Try
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
	
Catch ( NullObjectError  lo_noe )
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

