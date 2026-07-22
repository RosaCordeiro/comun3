HA$PBExportHeader$dc_uo_seguranca.sru
forward
global type dc_uo_seguranca from nonvisualobject
end type
type hostent from structure within dc_uo_seguranca
end type
type wsadata from structure within dc_uo_seguranca
end type
end forward

type hostent from structure
	unsignedlong		h_name
	unsignedlong		h_aliases
	integer		h_addrtype
	integer		h_length
	unsignedlong		h_addr_list
end type

type wsadata from structure
	unsignedinteger	version
	unsignedinteger	highversion
	character			description[257]
	character			systemstatus[129]
	unsignedinteger	maxsockets
	unsignedinteger	maxupddg
	string					vendorinfo
end type

global type dc_uo_seguranca from nonvisualobject
end type
global dc_uo_seguranca dc_uo_seguranca

type prototypes
// User/computer information
Function boolean GetUserNameA(ref string  lpBuffer, ref ulong nSize) library "Advapi32.dll" alias for "GetUserNameA;Ansi"
Function boolean GetComputerNameA(ref string  lpBuffer, ref ulong nSize) library "kernel32.dll" alias for "GetComputerNameA;Ansi"
Function int GetModuleFileNameA(ulong hinstModule, REF string lpszPath, ulong cchPath) LIBRARY "kernel32"  alias for "GetModuleFileNameA;Ansi"

FUNCTION long gethostname (Ref string hostname,long HostLen) Library "wsock32.dll" alias for "gethostname;Ansi"  
FUNCTION long gethostbyname (Ref string hostname) Library "wsock32.dll" alias for "gethostbyname;Ansi" 
Subroutine CopyMemoryIP (	Ref hostent Destination, ulong Source, long Length) Library  "kernel32.dll" Alias For "RtlMoveMemory"
Subroutine CopyMemoryIP (	Ref blob Destination, ulong Source, long Length) Library  "kernel32.dll" Alias For "RtlMoveMemory"
Subroutine CopyMemoryIP (	Ref ulong Destination, ulong Source, 	long Length	) Library  "kernel32.dll" Alias For "RtlMoveMemory"
end prototypes

type variables
CONSTANT long Limite_Tentativa_Login	= 4

Public:
	Boolean	ivb_LogIn, &
				ivb_Controle_Acesso
	
	Boolean	ivb_Usuario_Localizado, &
				ivb_Login_Sucesso, &
				ivb_Habilita_Cancelar = True
	
	String		Cd_Sistema, &
				Nr_Matricula, &
				Nm_Usuario, &
				De_Email, &
				De_Senha, &
				Nr_Cpf, &
				Cd_Procedimento, &
				Id_Isento_Biometria
	
	Boolean  Id_Perfil_Master
	Boolean  Id_Senha_Criptografada = False
	Boolean  Id_Login_Bloqueado = False
	
	Integer Cd_Perfil_Usuario
	
	Date Dt_Ult_Altera_Senha
	Date Dt_Prox_Altera_Senha
	
	Boolean ivb_Coletor = False
	
	Long ivl_Color = 255
	Long il_Filial_Parametro
	Long il_Filial_Matriz
	
	Boolean ivb_liberacao_com_biometria = False
	
Private:
	Boolean Id_Inclusao	= True
	Boolean Id_Alteracao	= True
	Boolean Id_Exclusao	= True
	
	Long Qt_Letra_Senha		= 1
	Long Qt_Numero_Senha	= 1
	Long Qt_Caracter_Senha	= 1
	
	Boolean ib_Persiste_Usuario = False
	Boolean Parametros_Carregados = False
	
	String is_Matricula_Persiste		= ''
	String is_Nm_Usuario_Persiste	= ''
	String is_Host
	String is_IP
	
	String Sistemas_Sem_Bloq_Usuario[] = {'RL','CL','PC','EL','NF'}
	
	Long Impor_Historico_Senha				= 4
	Long Dias_Altera_Senha						= 0
	Long Tamanho_Minimo_Senha				= 6
	Date Data_Alteracao_Politica_Senha
	Long Validade_Token_Usuario				= 300 //Em segundos
	
	dc_uo_encript ivo_Encript
end variables
forward prototypes
public subroutine of_localiza_usuario (string ps_nr_matricula)
public subroutine of_habilita_menu (menu pm_menu)
public function string of_encripta_texto (string ps_texto)
public function string of_desencripta_texto (string ps_texto)
public subroutine of_login_sistema ()
public function boolean of_libera_acesso_procedimento (string as_procedimento, ref string as_matricula)
public function boolean of_libera_acesso_procedimento (string as_procedimento)
public function boolean of_libera_acesso_usuario (ref string as_matricula)
public function boolean of_libera_acesso_procedimento (string as_procedimento, ref string as_matricula, string as_sistema)
public subroutine of_registra_tentativa_login (string ps_matricula, string ps_mensagem, boolean pb_sucesso)
public function boolean of_acesso_procedimento (string ps_procedimento, boolean pb_controle_usuario)
public function boolean of_acesso_procedimento (string ps_procedimento)
public function boolean of_permite_incluir_alterar_excluir (boolean pb_controle_usuario, string ps_procedimento)
public function boolean of_altera_senha (string ps_nova_senha)
public subroutine of_set_id_inclusao (boolean pb_valor)
public subroutine of_set_id_alteracao (boolean pb_valor)
public subroutine of_set_id_exclusao (boolean pb_valor)
public function Boolean of_get_id_alteracao ()
public function boolean of_get_id_inclusao ()
public function boolean of_get_id_exclusao ()
public subroutine of_set_nm_usuario_persiste (string ps_valor)
public subroutine of_set_nr_matricula_persiste (string ps_valor)
public function string of_get_nr_matricula_persiste ()
public function string of_get_nm_usuario_persiste ()
public function boolean of_get_persiste_usuario ()
public subroutine of_set_persiste_usuario (boolean pb_valor)
public function string of_get_nr_matricula_persiste (ref boolean ab_possui_acesso_procedimento)
public function string of_get_ultimo_procedimento ()
public function string of_get_aplicacao ()
public function string of_get_host ()
public function boolean of_bloqueia_usuario (string ps_matricula)
public function string of_get_usuario_windows ()
public subroutine of_set_ultimo_procedimento (string ps_procedimento)
public function string of_get_ip ()
public function long of_get_filial ()
public function long of_get_tentativas_login (string ps_matricula, long pl_segundos)
private function boolean of_grava_historico_senha ()
public function boolean of_get_formatacao_senha (ref long pl_letras, ref long pl_numeros, ref long pl_caracteres_especiais, ref long pl_tamanho_senha, ref long pl_historico_senha)
public function boolean of_carrega_parametros ()
public function date of_get_data_alteracao_politica_senha ()
public subroutine of_get_configuracao_senha (ref date pdt_alteracao_politica_senha, ref long pl_periodicidade_troca_senha, ref long pl_letras, ref long pl_numeros, ref long pl_caracteres_especiais, ref long pl_tamanho_senha, ref long pl_historico_senha)
public function string of_get_descricao_procedimento (boolean pb_mostra_mensagem)
public function string of_get_descricao_procedimento ()
private function date of_get_prox_alteracao_senha ()
public function boolean of_get_senha_expirada (boolean pb_exibe_aberta)
public function boolean of_get_perfil_usuario_matriz (string ps_sistema, long pl_perfil_usuario)
public function boolean of_valida_token_usuario (string ps_token, string ps_matricula)
public function string of_gera_token_usuario (string ps_matricula)
end prototypes

public subroutine of_localiza_usuario (string ps_nr_matricula);String lvs_Id_Perfil_Master, &
		 lvs_Id_Situacao, &
		 lvs_Id_Criptografada

This.of_carrega_parametros()

Select	nr_matricula,
		nm_usuario,
		de_senha,
		coalesce( id_situacao,'A'),
		coalesce( id_senha_criptografada,'N'),
		coalesce( id_isento_biometria, 'N' ),
		coalesce( nr_cpf, '0' ),
		cast(dh_alteracao_senha as date),
		coalesce(de_endereco_email, '')
Into	:Nr_Matricula,
		:Nm_Usuario,
		:De_Senha,
		:lvs_Id_Situacao,
		:lvs_Id_Criptografada,
		:Id_Isento_Biometria,
		:Nr_CPF,
		:Dt_Ult_Altera_Senha,
		:De_Email
From usuario
Where nr_matricula = :ps_Nr_Matricula
Using SQLCa;

Id_Senha_Criptografada = (lvs_Id_Criptografada = 'S')
//Criptografa a senha recuperada do banco, caso ela esteja descriptografada.
If  Not Id_Senha_Criptografada Then
	Id_Senha_Criptografada = True
	De_Senha = ivo_encript.of_encripta( De_Senha )
End If

This.of_Get_Prox_Alteracao_Senha( )

If SqlCa.SqlCode = 0 Then
	
	Choose Case lvs_Id_Situacao
		Case "A"
			ivb_Usuario_Localizado = True
			
		Case "I"
			This.of_Registra_Tentativa_Login( ps_Nr_Matricula, "Usu$$HEX1$$e100$$ENDHEX$$rio " + Nm_Usuario + " est$$HEX1$$e100$$ENDHEX$$ inativo e n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitido o acesso do mesmo a nenhum sistema ou procedimento.", False )			
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Usu$$HEX1$$e100$$ENDHEX$$rio " + Nm_Usuario + " est$$HEX1$$e100$$ENDHEX$$ inativo e n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitido o acesso do mesmo a nenhum sistema.", Exclamation! )
	
			ivb_Usuario_Localizado = False
			Return
		Case "B"
			This.of_Registra_Tentativa_Login( ps_Nr_Matricula, "Usu$$HEX1$$e100$$ENDHEX$$rio " + Nm_Usuario + " est$$HEX1$$e100$$ENDHEX$$ bloqueado e n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitido o acesso do mesmo a nenhum sistema ou procedimento.", False )			
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Usu$$HEX1$$e100$$ENDHEX$$rio " + Nm_Usuario + " foi bloqueado, por efetuar "+String(Limite_Tentativa_Login)+" tentativas de login incorretas, "+ &
											"e n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitido o acesso a nenhum sistema ou procedimento.~r~r"+ &
											"Para desbloqueio contate o setor de inform$$HEX1$$e100$$ENDHEX$$tica.", Exclamation! )
	
			ivb_Usuario_Localizado = False
			Return
		Case "F"
			This.of_Registra_Tentativa_Login( ps_Nr_Matricula, "Usu$$HEX1$$e100$$ENDHEX$$rio " + Nm_Usuario + " est$$HEX1$$e100$$ENDHEX$$ afastado e n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitido o acesso do mesmo a nenhum sistema ou procedimento.", False )			
//			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Usu$$HEX1$$e100$$ENDHEX$$rio " + Nm_Usuario + " est$$HEX1$$e100$$ENDHEX$$ afastado do servi$$HEX1$$e700$$ENDHEX$$o (f$$HEX1$$e900$$ENDHEX$$rias, licen$$HEX1$$e700$$ENDHEX$$a, etc), "+ &
//											"e n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitido o acesso a nenhum sistema ou procedimento.~r~r"+ &
//											"Para alterar a situa$$HEX2$$e700e300$$ENDHEX$$o contate o setor de RH.", Exclamation! )
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Login para o usu$$HEX1$$e100$$ENDHEX$$rio " + Nm_Usuario + " est$$HEX1$$e100$$ENDHEX$$ indispon$$HEX1$$ed00$$ENDHEX$$vel no momento.~r~r"+ &
								"Para ajuda procure seu gestor. ", Exclamation! )
	
			ivb_Usuario_Localizado = False
			Return		
			
		Case Else
			This.of_Registra_Tentativa_Login( ps_Nr_Matricula, "Usu$$HEX1$$e100$$ENDHEX$$rio " + Nm_Usuario + " inacess$$HEX1$$ed00$$ENDHEX$$vel e n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitido o acesso do mesmo a nenhum sistema ou procedimento.", False )	
			ivb_Usuario_Localizado = False
			Return		
			
	End Choose
	
	//Verifica se o usu$$HEX1$$e100$$ENDHEX$$rio est$$HEX1$$e100$$ENDHEX$$ com permiss$$HEX1$$e300$$ENDHEX$$o tempor$$HEX1$$e100$$ENDHEX$$ria, perfil 14.
	SELECT DISTINCT us.cd_perfil_temporario,	'N' AS id_perfil_master
		Into :Cd_Perfil_Usuario,	:lvs_Id_Perfil_Master
	FROM usuario_sistema_temporario us
		INNER JOIN perfil_usuario p
		ON p.cd_sistema = us.cd_sistema
		AND p.cd_perfil_usuario = us.cd_perfil_temporario
	WHERE us.cd_sistema = :Cd_Sistema
		AND us.nr_matricula = :Nr_Matricula
		AND getdate() BETWEEN us.dh_inicio_vigencia AND us.dh_termino_vigencia
		AND us.dh_inicio_vigencia = ( SELECT MAX( dh_inicio_vigencia )
											   FROM usuario_sistema_temporario x
											WHERE x.cd_sistema = us.cd_sistema
											AND x.nr_matricula = us.nr_matricula
											AND getdate() BETWEEN x.dh_inicio_vigencia AND x.dh_termino_vigencia );
	If SqlCa.SqlCode = 100 Or SqlCa.SqlCode = -1 Then			
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgdbError("Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o de perfil tempor$$HEX1$$e100$$ENDHEX$$rio.")			
		End If	
	
		Select	US.cd_perfil_usuario,
				PU.id_perfil_master
		Into	:Cd_Perfil_Usuario,
				:lvs_Id_Perfil_Master
		From usuario_sistema US,
				perfil_usuario PU
		Where US.cd_sistema		= PU.cd_sistema
		  and US.cd_perfil_usuario	= PU.cd_perfil_usuario
		  and US.cd_sistema	= :Cd_Sistema
		  and US.nr_matricula	= :Nr_Matricula;
		  
		If SqlCa.SqlCode = 0 Then
			
			Id_Perfil_Master = (lvs_Id_Perfil_Master = "S")
			
			ivb_Usuario_Localizado = True
			
			//This.of_Registra_Tentativa_Login( ps_Nr_Matricula, "Procedimento liberado.", True )
		Else
			This.of_Registra_Tentativa_Login( ps_Nr_Matricula, "Usu$$HEX1$$e100$$ENDHEX$$rio " + Nm_Usuario + " n$$HEX1$$e300$$ENDHEX$$o possui perfil definido para este sistema.", False )
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Usu$$HEX1$$e100$$ENDHEX$$rio " + Nm_Usuario + " n$$HEX1$$e300$$ENDHEX$$o possui perfil definido para este sistema.", Exclamation!, Ok!)
			ivb_Usuario_Localizado = False	
		End If
	ElseIf SqlCa.SqlCode = 0 Then
		Id_Perfil_Master = (lvs_Id_Perfil_Master = "S")
		
		ivb_Usuario_Localizado = True		
	End If
Else
	This.of_Registra_Tentativa_Login( ps_Nr_Matricula, "Usu$$HEX1$$e100$$ENDHEX$$rio com a matr$$HEX1$$ed00$$ENDHEX$$cula " + ps_Nr_Matricula + " n$$HEX1$$e300$$ENDHEX$$o localizado.", False )
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Usu$$HEX1$$e100$$ENDHEX$$rio com a matr$$HEX1$$ed00$$ENDHEX$$cula " + ps_Nr_Matricula + " n$$HEX1$$e300$$ENDHEX$$o localizado.", Exclamation!, Ok!)
	ivb_Usuario_Localizado = False
End If
end subroutine

public subroutine of_habilita_menu (menu pm_menu);If gvo_Aplicacao.ivo_Seguranca.cd_Sistema = 'RL' Then Return


Integer lvi_contador, lvi_itens, li_Pos
Menu lvm_menu
String lvs_tag

lvi_itens = UpperBound(pm_Menu.Item)

FOR lvi_contador= 1 TO lvi_itens
	lvm_menu = pm_menu.Item[lvi_contador]
	If UpperBound(lvm_menu.Item) > 0 Then
		of_habilita_menu(lvm_menu)
	Else
		lvs_Tag = lvm_Menu.Tag
		
		If LenA(lvs_Tag) > 0 Then
			
			li_Pos =Pos( lvs_Tag, ',')
			
			If li_Pos > 0 Then
				If Upper(Mid(lvs_Tag, li_Pos + 1)) = 'TRUE' Then
					lvm_menu.Enabled = of_Acesso_Procedimento(Mid(lvs_Tag, 1, Len(lvs_Tag) - 5) , True)
				Else
					lvm_menu.Enabled = of_Acesso_Procedimento(lvs_Tag, False)
				End If
			Else
				lvm_menu.Enabled = of_Acesso_Procedimento(lvs_Tag, False)
			End If
		End If
		
	End If
NEXT
end subroutine

public function string of_encripta_texto (string ps_texto);Long lvl_tamanho, lvl_contador
String lvs_parte, lvs_retorno
Integer lvi_caracter

// Verifica o tamnho do string passado como parametro
lvl_tamanho = LenA(ps_texto)

// Loop de convers$$HEX1$$e300$$ENDHEX$$o dos caracteres do string passado como parametro
FOR lvl_contador = 1 TO lvl_tamanho
	lvs_parte = MidA(ps_texto, lvl_contador, 1)
	lvi_caracter = AscA(lvs_parte)
	lvi_caracter = lvi_caracter + 100
	lvs_parte = CharA(lvi_caracter)
	lvs_retorno = lvs_retorno + lvs_parte
NEXT

// Retorna
Return lvs_retorno
end function

public function string of_desencripta_texto (string ps_texto);Long lvl_tamanho, lvl_contador
String lvs_parte, lvs_retorno
Integer lvi_caracter

// Verifica o tamnho do string passado como parametro
lvl_tamanho = LenA(ps_texto)

// Loop de convers$$HEX1$$e300$$ENDHEX$$o dos caracteres do string passado como parametro
FOR lvl_contador = 1 TO lvl_tamanho
	lvs_parte = MidA(ps_texto, lvl_contador, 1)
	lvi_caracter = AscA(lvs_parte)
	lvi_caracter = lvi_caracter - 100
	lvs_parte = CharA(lvi_caracter)
	lvs_retorno = lvs_retorno + lvs_parte
NEXT

// Retorna
Return lvs_retorno
end function

public subroutine of_login_sistema ();Menu lvm_Item

SetPointer(HourGlass!)

Open(dc_w_Login_Sistema)

lvm_item = dc_w_MDI.MenuId

of_Habilita_Menu(lvm_Item)

gvo_Aplicacao.ivo_Seguranca.of_Set_Nr_Matricula_Persiste( This.Nr_Matricula )
gvo_Aplicacao.ivo_Seguranca.of_Set_Nm_Usuario_Persiste( This.Nm_Usuario )				

SetPointer(Arrow!)
end subroutine

public function boolean of_libera_acesso_procedimento (string as_procedimento, ref string as_matricula);Return This.of_libera_acesso_procedimento( as_procedimento, as_matricula, This.Cd_Sistema )
end function

public function boolean of_libera_acesso_procedimento (string as_procedimento);String lvs_Matricula

Return This.of_Libera_Acesso_Procedimento(as_Procedimento, ref lvs_Matricula)


end function

public function boolean of_libera_acesso_usuario (ref string as_matricula);Return This.of_Libera_Acesso_Procedimento("", ref as_Matricula)
end function

public function boolean of_libera_acesso_procedimento (string as_procedimento, ref string as_matricula, string as_sistema);Boolean lvb_Sucesso = False
Boolean lb_Possui_Acesso_Procedimento = False
Boolean lb_Inverte_Resposta_MessageBox = False
Boolean lvb_Cancelar

String lvs_Retorno
String ls_Descricao_Procedimento

String ls_Mensagem_Liberacao
Integer li_Resposta_Liberacao = 0

gvo_Aplicacao.ivo_Seguranca.ivb_liberacao_com_biometria = False

as_Procedimento = Upper(as_Procedimento)

lvb_Cancelar = This.ivb_Habilita_Cancelar
This.cd_Procedimento = as_Procedimento

dc_uo_Seguranca lvo_Seguranca
lvo_Seguranca = Create dc_uo_Seguranca

lvo_Seguranca.Cd_Sistema				= as_sistema
lvo_Seguranca.Cd_Procedimento     	= as_Procedimento
lvo_Seguranca.ivb_Controle_Acesso	= True
lvo_Seguranca.ivb_Habilita_Cancelar	= lvb_Cancelar
lvo_Seguranca.ivl_Color					= ivl_Color

If ivb_Coletor Then
	OpenWithParm(dc_w_Liberacao_Procedimento_Coletor, lvo_Seguranca)	
Else
	If as_Procedimento = "" Then
		OpenWithParm(dc_w_Liberacao_Procedimento, lvo_Seguranca)
	Else
		If gvo_Aplicacao.ivo_Seguranca.of_Get_Persiste_Usuario( ) Then
			
			If gvo_Aplicacao.ivo_Seguranca.of_Get_Nr_Matricula_Persiste( Ref lb_Possui_Acesso_Procedimento ) <> gvo_Aplicacao.ivo_Seguranca.Nr_Matricula Then
				If gvo_Aplicacao.ivo_Seguranca.cd_Sistema <> as_sistema Then
					ls_Mensagem_Liberacao = "Usu$$HEX1$$e100$$ENDHEX$$rio " + gvo_Aplicacao.ivo_Seguranca.nm_Usuario + " n$$HEX1$$e300$$ENDHEX$$o possui acesso ao procedimento.~r~r" + &
														"Acessar com outro usu$$HEX1$$e100$$ENDHEX$$rio ?"
														
					lb_Inverte_Resposta_MessageBox = True
				Else
					ls_Mensagem_Liberacao = "Usu$$HEX1$$e100$$ENDHEX$$rio " + gvo_Aplicacao.ivo_Seguranca.nm_Usuario + " n$$HEX1$$e300$$ENDHEX$$o possui acesso ao procedimento.~r~r" + &
														"Acessar como " + Upper( gvo_Aplicacao.ivo_Seguranca.of_Get_Nm_Usuario_Persiste( ) ) + " ?"
				End If
			Else
				If lb_Possui_Acesso_Procedimento Then
					ls_Descricao_Procedimento = This.of_Get_Descricao_Procedimento()
					ls_Mensagem_Liberacao = ls_Descricao_Procedimento + "~r~r Acessar como " + Upper( gvo_Aplicacao.ivo_Seguranca.nm_Usuario ) + " ?"
				Else			
					ls_Mensagem_Liberacao = "Usu$$HEX1$$e100$$ENDHEX$$rio " + gvo_Aplicacao.ivo_Seguranca.nm_Usuario + " n$$HEX1$$e300$$ENDHEX$$o possui acesso ao procedimento.~r~r" + &
														"Acessar com outro usu$$HEX1$$e100$$ENDHEX$$rio ?"
														
					lb_Inverte_Resposta_MessageBox = True
				End If
			End If
			
			SqlCa.of_End_Transaction( )
			li_Resposta_Liberacao = MessageBox( "LIBERA$$HEX2$$c700c300$$ENDHEX$$O DE PROCEDIMENTO", ls_Mensagem_Liberacao, Question!, YesNoCancel!, 1 )
			
			If lb_Inverte_Resposta_MessageBox Then
				If li_Resposta_Liberacao = 1 Then
					li_Resposta_Liberacao = 2
				ElseIf li_Resposta_Liberacao = 2 Then
					li_Resposta_Liberacao = 1
				End If
			End If
			
			If li_Resposta_Liberacao = 1 Then
				If This.cd_sistema = 'CL' Then
					OpenWithParm(dc_w_Liberacao_Procedimento_Paf, lvo_Seguranca)
				Else
					OpenWithParm(dc_w_Liberacao_Procedimento, lvo_Seguranca)
				End If
			ElseIf li_Resposta_Liberacao = 2 Then
				gvo_Aplicacao.ivo_Seguranca.of_Set_Persiste_Usuario( False )
				
				If This.cd_sistema = 'CL' Then
					OpenWithParm(dc_w_Liberacao_Procedimento_Paf, lvo_Seguranca)
				Else
					OpenWithParm(dc_w_Liberacao_Procedimento, lvo_Seguranca)
				End If
				
				gvo_Aplicacao.ivo_Seguranca.of_Set_Persiste_Usuario( True )
			End If
		Else
			OpenWithParm(dc_w_Liberacao_Procedimento, lvo_Seguranca)
		End If		
	End If
End If

lvs_Retorno = Message.StringParm

If li_Resposta_Liberacao = 3 Then 
	lvs_Retorno = 'CANCEL'
End If

If lvs_Retorno <> "CANCEL" Then
	If Trim(as_Procedimento) <> "" Then
		If lvo_Seguranca.of_Acesso_Procedimento(as_Procedimento, False) Then
			
			If ( gvo_Aplicacao.ivo_Seguranca.of_Get_Nr_Matricula_Persiste( ) <> lvo_Seguranca.Nr_Matricula ) And ( Not lb_Possui_Acesso_Procedimento ) And ( gvo_Aplicacao.ivo_Seguranca.cd_Sistema = as_sistema ) Then
				gvo_Aplicacao.ivo_Seguranca.of_Set_Nr_Matricula_Persiste( lvo_Seguranca.Nr_Matricula )
				gvo_Aplicacao.ivo_Seguranca.of_Set_Nm_Usuario_Persiste( lvo_Seguranca.Nm_Usuario )				
			End If

			gvo_Aplicacao.ivo_Seguranca.of_set_id_alteracao(lvo_Seguranca.of_get_id_alteracao( ))
			gvo_Aplicacao.ivo_Seguranca.of_set_id_inclusao(lvo_Seguranca.of_get_id_inclusao( ))
			gvo_Aplicacao.ivo_Seguranca.of_set_id_exclusao(lvo_Seguranca.of_get_id_exclusao( ))
			
			lvb_Sucesso = True
		Else
			If Not gvo_Aplicacao.ivo_Seguranca.of_Get_Persiste_Usuario( ) Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Usu$$HEX1$$e100$$ENDHEX$$rio n$$HEX1$$e300$$ENDHEX$$o tem permiss$$HEX1$$e300$$ENDHEX$$o para acessar este procedimento.", StopSign!)
			Else
				If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Usu$$HEX1$$e100$$ENDHEX$$rio n$$HEX1$$e300$$ENDHEX$$o tem permiss$$HEX1$$e300$$ENDHEX$$o para acessar este procedimento.~r~rDeseja acessar com usu$$HEX1$$e100$$ENDHEX$$rio diferente?", StopSign! , YesNo! ) = 1 Then
					gvo_Aplicacao.ivo_Seguranca.of_Set_Persiste_Usuario( False )
					lvb_Sucesso = lvo_Seguranca.of_Libera_Acesso_Procedimento( as_procedimento, as_matricula, as_sistema )
					gvo_Aplicacao.ivo_Seguranca.of_Set_Persiste_Usuario( True )
					Return lvb_Sucesso
				End If
			End If
		End If
	Else
		lvb_Sucesso = True
	End If
End If

Destroy(lvo_Seguranca)

If lvb_Sucesso Then
	as_Matricula = lvs_Retorno
Else
	SetNull(as_Matricula)
End If

Return lvb_Sucesso
end function

public subroutine of_registra_tentativa_login (string ps_matricula, string ps_mensagem, boolean pb_sucesso);String ls_Mensagem
String ls_Chaves
String ls_Host
String ls_IP
String ls_Sucesso

Long ll_Filial

If pb_Sucesso Then
	UPDATE usuario_sistema
		 SET dh_ultimo_acesso = getdate( )
	WHERE cd_sistema	= :This.cd_Sistema
		AND nr_matricula	= :ps_Matricula
	 USING SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case -1
			SqlCa.of_RollBack( )
		//	SqlCa.of_MsgDbError( )
			
		Case Else
			SqlCa.of_Commit( )
	End Choose
End If

If Not IsNull(This.nr_matricula) and (Trim(This.nr_matricula)<>"") and (ivb_Usuario_Localizado) Then 	
	ls_Host 		= This.Of_Get_Host()
	ls_IP			= This.Of_Get_IP()
	ll_Filial		= This.Of_Get_Filial()	
	ls_Sucesso	= IIF(pb_sucesso, "S", "N")
	
	insert into usuario_login (nr_matricula, dh_tentativa, de_host, de_ip, cd_filial, cd_sistema, cd_procedimento, id_sucesso)
	Values (:This.nr_matricula, getDate(), :ls_Host, :ls_IP, :ll_Filial, :This.Cd_sistema, :This.Cd_Procedimento, :ls_Sucesso)
	Using SQLCa;
	
	If SQLCa.SQLCode = 0 Then
		SQLCa.Of_Commit()
	Else
		SQLCa.Of_RollBack()
	End If
End If

// Sistema Produtos Controlados Clamed
If This.Cd_Sistema = 'PC' Then
	If pb_Sucesso Then
		ls_Mensagem = "mensagem, ACESSO LIBERADO"
	Else
		ls_Mensagem = "mensagem, TENTATIVA DE ACESSO N$$HEX1$$c300$$ENDHEX$$O AUTORIZADO"
	End If
	
	If IsNull( This.cd_Procedimento ) Or Trim( This.cd_Procedimento ) = ""  Then
		ls_Mensagem += ", procedimento, LOGIN NO SISTEMA"
	Else
		ls_Mensagem += ", procedimento, " + This.cd_Procedimento
	End If
	
	If Trim( ps_Mensagem ) <> "" Then
		ls_Mensagem += ", erro, " + UPPER( ps_Mensagem )
	End If
	
	ls_Mensagem = "{" + ls_Mensagem + "}"
	
	INSERT INTO logged_actions ( nm_aplicacao, nm_tabela, nr_matricula, id_acao, de_valor_novo ) 
	  VALUES ( current_setting('application_name'), 'liberacao_procedimento', :ps_Matricula, 'L', json_object(:ls_Mensagem) )
	USING SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case -1
			SqlCa.of_RollBack( )
			SqlCa.of_MsgDbError( )
			
		Case Else
			SqlCa.of_Commit( )
			
	End Choose
End If
end subroutine

public function boolean of_acesso_procedimento (string ps_procedimento, boolean pb_controle_usuario);String lvs_De_Procedimento

// Transforma o par$$HEX1$$e200$$ENDHEX$$metros em UpperCase
ps_Procedimento = Upper(ps_Procedimento)
This.cd_Procedimento = ps_Procedimento

// Se o sistema n$$HEX1$$e300$$ENDHEX$$o utilizar controle de acesso
If Not ivb_Controle_Acesso Then 
	This.of_Set_Id_Inclusao	( True )
	This.of_Set_Id_Alteracao( True )
	This.of_Set_Id_Exclusao	( True )

	Return True
End If

//CHAMADO 240740 - Deve respeitar os procedimentos cadastrados, independentemente se $$HEX1$$e900$$ENDHEX$$ master ou n$$HEX1$$e300$$ENDHEX$$o
//If Not Id_Perfil_Master Then
	// Verifica se o procedimento existe para o sistema
	Select de_procedimento Into :lvs_De_Procedimento
	From procedimento_sistema
	Where cd_sistema      = :Cd_Sistema
	  and cd_procedimento = :ps_Procedimento;
	  
	If SqlCa.SqlCode = 100 Then
		Return False
	End If
//End If

Return This.of_Permite_Incluir_Alterar_Excluir( pb_controle_usuario, ps_Procedimento)
end function

public function boolean of_acesso_procedimento (string ps_procedimento);Return This.of_acesso_procedimento(ps_procedimento, False)
end function

public function boolean of_permite_incluir_alterar_excluir (boolean pb_controle_usuario, string ps_procedimento);String lvs_Id_Inclusao
String lvs_Id_Alteracao
String lvs_Id_Exclusao

// Transforma o par$$HEX1$$e200$$ENDHEX$$metros em UpperCase
ps_Procedimento = Upper(ps_Procedimento)

If pb_controle_usuario Then
	
	// Verifica se o usu$$HEX1$$e100$$ENDHEX$$rio possui acesso ao procedimento
	Select id_inclusao, 
			 id_alteracao,
			 id_exclusao
	Into :lvs_Id_Inclusao,
		  :lvs_Id_Alteracao,
		  :lvs_Id_Exclusao
	From procedimento_sistema_usuario
	Where cd_sistema        	= :Cd_Sistema
	  and cd_procedimento   = :ps_Procedimento
	  and nr_matricula 		= :Nr_Matricula;
	  
	If SqlCa.SqlCode = 100 Then
		This.of_Set_Id_Inclusao	( False )
		This.of_Set_Id_Alteracao( False )
		This.of_Set_Id_Exclusao	( False )
		
		Return False
	Else
		This.of_Set_Id_Inclusao	( lvs_Id_Inclusao	= "S" )
		This.of_Set_Id_Alteracao( lvs_Id_Alteracao	= "S" )
		This.of_Set_Id_Exclusao	( lvs_Id_Exclusao	= "S" )
		
		Return True
	End If
Else
	// Verifica se o usu$$HEX1$$e100$$ENDHEX$$rio possui acesso ao procedimento
	Select id_inclusao, 
			 id_alteracao,
			 id_exclusao
	Into :lvs_Id_Inclusao,
		  :lvs_Id_Alteracao,
		  :lvs_Id_Exclusao
	From procedimento_perfil_usuario
	Where cd_sistema			= :Cd_Sistema
	  and cd_procedimento	= :ps_Procedimento
	  and cd_perfil_usuario	= :Cd_Perfil_Usuario;

	 //Caso tenha o procedimento cadastrado, respeitar$$HEX1$$e100$$ENDHEX$$ o configurado no procedimento
	If SqlCa.SqlCode = 0 Then
		This.of_Set_Id_Inclusao	( lvs_Id_Inclusao	= "S" )
		This.of_Set_Id_Alteracao( lvs_Id_Alteracao	= "S" )
		This.of_Set_Id_Exclusao	( lvs_Id_Exclusao	= "S" )
		
		Return True
	Else //CHAMADO 240740 - Deve respeitar os procedimentos cadastrados, independentemente se $$HEX1$$e900$$ENDHEX$$ master ou n$$HEX1$$e300$$ENDHEX$$o
		This.of_Set_Id_Inclusao	( False )
		This.of_Set_Id_Alteracao( False )
		This.of_Set_Id_Exclusao	( False )
		
		Return False	
	End If
End If
end function

public function boolean of_altera_senha (string ps_nova_senha);Long lvl_Filial

DateTime lvdt_Movimentacao

If Not Parametros_carregados Then This.Of_carrega_parametros( )
select cd_filial, 
       dh_movimentacao
Into :lvl_Filial,
     :lvdt_Movimentacao
from parametro
where id_parametro = '1'
Using SqlCa;

If SqlCa.SqlCode <> 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o dos par$$HEX1$$e200$$ENDHEX$$metros do sistema. " + SqlCa.SqlErrText)
	Return False
End If

dc_uo_encript lvo_encripta
lvo_encripta = Create dc_uo_encript

ps_Nova_Senha = lvo_encripta.of_encripta(ps_nova_senha)

Destroy(lvo_encripta)

Update usuario
Set de_senha = :ps_Nova_Senha,
	cd_filial_atualizacao = :lvl_Filial,
	 dh_atualizacao_filial = getDate(),
	 id_senha_criptografada = 'S',
	 dh_alteracao_senha = getDate()
Where nr_matricula = :Nr_Matricula
Using SqlCa;
 
If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na altera$$HEX2$$e700e300$$ENDHEX$$o de senha. " + SqlCa.SqlErrText)
	Return False
Else
	This.of_grava_historico_senha()
	
	SqlCa.of_Commit();

	This.De_Senha = ps_Nova_Senha

	Return True	
End If
end function

public subroutine of_set_id_inclusao (boolean pb_valor);This.id_Inclusao = pb_Valor
end subroutine

public subroutine of_set_id_alteracao (boolean pb_valor);This.id_Alteracao = pb_Valor
end subroutine

public subroutine of_set_id_exclusao (boolean pb_valor);This.id_Exclusao = pb_Valor
end subroutine

public function Boolean of_get_id_alteracao ();Return This.id_Alteracao
end function

public function boolean of_get_id_inclusao ();Return This.id_Inclusao
end function

public function boolean of_get_id_exclusao ();Return This.id_Exclusao
end function

public subroutine of_set_nm_usuario_persiste (string ps_valor);This.is_Nm_Usuario_Persiste = ps_Valor
end subroutine

public subroutine of_set_nr_matricula_persiste (string ps_valor);This.is_Matricula_Persiste = ps_Valor
end subroutine

public function string of_get_nr_matricula_persiste ();Boolean lb_Acesso_Procedimento

Return This.of_Get_Nr_Matricula_Persiste( Ref lb_Acesso_Procedimento )
end function

public function string of_get_nm_usuario_persiste ();Boolean lb_Acesso_Procedimento

String ls_Usuario

If Not This.of_Get_Persiste_Usuario( ) Then
		Return This.Nm_Usuario
End If

ls_Usuario = This.Nm_Usuario

If This.is_Nm_Usuario_Persiste = '' Then This.is_Nm_Usuario_Persiste = gvo_Aplicacao.ivo_Seguranca.Nm_Usuario

This.Nm_Usuario = This.is_Nm_Usuario_Persiste

lb_Acesso_Procedimento = This.of_Acesso_Procedimento( This.cd_Procedimento, False )

This.Nm_Usuario = ls_Usuario

If lb_Acesso_Procedimento Then
	Return gvo_Aplicacao.ivo_Seguranca.Nm_Usuario
Else
	Return This.is_Nm_Usuario_Persiste
End If
end function

public function boolean of_get_persiste_usuario ();Return This.ib_Persiste_Usuario
end function

public subroutine of_set_persiste_usuario (boolean pb_valor);This.ib_Persiste_Usuario = pb_Valor
end subroutine

public function string of_get_nr_matricula_persiste (ref boolean ab_possui_acesso_procedimento);String ls_Matricula

If Not This.of_Get_Persiste_Usuario( ) Then
		Return This.nr_Matricula
End If

ls_Matricula = This.nr_Matricula

If This.is_Matricula_Persiste = '' Then This.is_Matricula_Persiste = gvo_Aplicacao.ivo_Seguranca.nr_Matricula

This.nr_Matricula = This.is_Matricula_Persiste

ab_Possui_Acesso_Procedimento = This.of_Acesso_Procedimento( This.cd_Procedimento, False )

This.nr_Matricula = ls_Matricula

If ab_Possui_Acesso_Procedimento Then
	Return gvo_Aplicacao.ivo_Seguranca.nr_Matricula
Else
	Return This.is_Matricula_Persiste
End If
end function

public function string of_get_ultimo_procedimento ();If IsNull(This.Cd_Procedimento) Then This.Cd_Procedimento = ""

Return This.Cd_Procedimento
end function

public function string of_get_aplicacao ();string lvs_Aplicacao
unsignedlong lul_handle

Try 
	lvs_Aplicacao = Space(1024)
	
	lul_handle = Handle(GetApplication())
	GetModuleFileNameA(lul_handle, lvs_Aplicacao, 1024)
	
Catch( Exception Ex )
	MessageBox( "Exception", Ex.getMessage( ), StopSign! )
	
Finally
	If IsNull(lvs_Aplicacao) Then lvs_Aplicacao = ""
End Try

Return lvs_Aplicacao
end function

public function string of_get_host ();ulong 	lul_size = 16 // MAX_COMPUTERNAME_LENGTH + 1

boolean	lb_rc

String lvs_Host

Try
	If Trim(is_Host)="" or IsNull(is_Host) Then	
		lvs_Host = space(lul_size)
		
		lb_rc = GetComputerNameA( lvs_Host, lul_size)
		
		If Not lb_rc Then
			lvs_Host = "ERRO_NM_PDV_" + String( Now(), "mmss" )
			lvs_Host = ""
		End If
		
		is_Host = lvs_Host
	End If
	
Catch( Exception Ex )
	MessageBox( "Exception", Ex.getMessage( ), StopSign! )
	
Finally 
	If IsNull(is_Host) Then is_Host = ""
End Try

Return is_Host
end function

public function boolean of_bloqueia_usuario (string ps_matricula);Boolean lvb_Bloqueia = True

Long lvl_Cursor
Long lvl_Filial
Long lvl_Filial_Matriz

Datetime lvdh_Bloqueio

String lvs_Msg
String lvs_Perfil_Usuario

select cd_filial, 
       	cd_filial_matriz,
		getdate()
Into 	:lvl_Filial,
		:lvl_Filial_Matriz,
		:lvdh_Bloqueio
from parametro
where id_parametro = '1'
Using SqlCa;

//Verifica se o sistema $$HEX1$$e900$$ENDHEX$$ isento dessa restri$$HEX2$$e700e300$$ENDHEX$$o (chamado: 206020)
For lvl_Cursor = 1 To UpperBound(Sistemas_Sem_Bloq_Usuario)
	If This.Cd_Sistema = Sistemas_Sem_Bloq_Usuario[lvl_Cursor] Then
		lvb_Bloqueia = False
		Exit
	End If
Next

select de_perfil_usuario
	Into :lvs_Perfil_Usuario
From perfil_usuario
Where cd_perfil_usuario = :Cd_Perfil_Usuario
	And cd_sistema = :Cd_Sistema
Using SQLCa;

If SQLCa.SQLCode = -1 Then
	SQLCa.Of_MsgDbError( "Localiza$$HEX2$$e700e300$$ENDHEX$$o descri$$HEX2$$e700e300$$ENDHEX$$o perfil usu$$HEX1$$e100$$ENDHEX$$rio" )
End If

//Chamado 208457 - Alertar por Email
lvs_Msg 	= 	"Caro(a) Usu$$HEX1$$e100$$ENDHEX$$rio,<br /><br />"+ &
				"Foram esgotadas as tentativas de acesso de login:<br /><br />"+ &
				"<b>Matr$$HEX1$$ed00$$ENDHEX$$cula: </b>"+This.nr_matricula+"<br />"+ &
				"<b>Nome Usu$$HEX1$$e100$$ENDHEX$$rio: </b>"+This.nm_usuario+"<br />"+ &
				"<b>Procedimento: </b>"+IIF(This.of_Get_Ultimo_Procedimento()<>"",This.of_Get_Descricao_Procedimento(False),"LOGIN")+"<br />"+ &
				IIF(Not IsNull(lvs_Perfil_Usuario) and lvs_Perfil_Usuario<>"","<b>Perfil Usu$$HEX1$$e100$$ENDHEX$$rio: </b>"+String(Cd_Perfil_Usuario)+" - "+lvs_Perfil_Usuario+"<br />","")+ &
				"<b>Data/Hora: </b>"+String(lvdh_Bloqueio,'DD/MM/YYYY HH:MM:SS')+"<br />"+ &
				"<b>Filial: </b>"+String(lvl_Filial)+"<br />"+ &
				"<b>Host: </b>"+This.of_Get_Host()+"<br />"+ &
				"<b>Usu$$HEX1$$e100$$ENDHEX$$rio Windows: </b>"+This.of_Get_Usuario_Windows()+"<br />"+ &
				"<b>Sistema: </b>"+This.Cd_sistema+"<br />"+ &
				"<b>N$$HEX1$$ba00$$ENDHEX$$ Tentativas: </b>"+String(This.Of_Get_Tentativas_Login(This.Nr_Matricula, 180))+" tentativa(s) nos $$HEX1$$fa00$$ENDHEX$$ltimos 3 minutos.<br />"+ &
				"<b>Bloqueado: </b>"+IIF(lvb_Bloqueia,'SIM','N$$HEX1$$c300$$ENDHEX$$O')+"<br />"+ &
				"<br /><b>Database: </b>"+IIF(IsNull(SQLCa.Database),"",SQLCa.Database)+IIF(IsNull(SQlca.ivs_database), "", " ("+SQlca.ivs_Database+")")

If lvl_Filial <> lvl_Filial_Matriz Then
	gf_ge202_envia_email_log(106,'[SA] - Tentativa Acesso Sistema',lvs_Msg,False,True)
Else
	gf_ge202_envia_email_automatico(106,'Tentativa Acesso Sistema',lvs_Msg)
End If

If lvb_Bloqueia Then
	//Chamado 203117 - Bloqueia Usu$$HEX1$$e100$$ENDHEX$$rio
	update usuario
	set id_situacao = 'B'
	Where nr_matricula = :ps_matricula
	Using SQLCa;
                
	If SQLCa.SQLCode <> -1 Then
		SQLCa.Of_commit( )
	Else
		SQLCa.of_Rollback( )
		SQLCa.of_msgdberror('Falha na tentativa de bloqueio do usu$$HEX1$$e100$$ENDHEX$$rio.')
		Return False
	End If
	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Limite de "+String(This.Limite_Tentativa_Login)+" tentativas esgotado, "+ &
									"o usu$$HEX1$$e100$$ENDHEX$$rio "+This.nm_usuario+" foi bloqueado e n$$HEX1$$e300$$ENDHEX$$o poder$$HEX1$$e100$$ENDHEX$$ mais acessar o sistema.~r~r"+ &
									"Para desbloqueio contate o setor de seguran$$HEX1$$e700$$ENDHEX$$a da informa$$HEX2$$e700e300$$ENDHEX$$o.", Exclamation!)
Else	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Limite de "+String(This.Limite_Tentativa_Login)+" tentativas esgotado.", Exclamation!)	
End If

This.Cd_Procedimento = ""

Return True
end function

public function string of_get_usuario_windows ();//////////////////////////////////////////////////////////////////////////////
//
//	Copyright $$HEX1$$a900$$ENDHEX$$ 1996-1997 Sybase, Inc. and its subsidiaries.  All rights reserved.
//	Any distribution of the PowerBuilder Foundation Classes (PFC)
//	source code by other than Sybase, Inc. and its subsidiaries is prohibited.
//
//////////////////////////////////////////////////////////////////////////////
string 	ls_name
ulong		lul_size = 255
boolean	lb_rc

Try
	ls_name = space(lul_size)
	
	lb_rc = GetUserNameA( ls_name, lul_size)
	
	if not lb_rc THEN
		ls_name = ""
	end if
	
Catch( Exception Ex )
	MessageBox( "Exception", Ex.getMessage( ), StopSign! )
	
Finally
	If IsNull(ls_name) Then ls_name = ""
End try

Return ls_name
end function

public subroutine of_set_ultimo_procedimento (string ps_procedimento);This.Cd_Procedimento = ps_procedimento
end subroutine

public function string of_get_ip ();String ls_ipaddress = ''
String ls_errmsg
Blob lblb_ipaddr
hostent lstr_host
String lvs_Host
ULong lul_ptr, lul_ipaddr

Try
	If Trim(is_IP)="" or IsNull(is_IP) Then
		lvs_Host = This.Of_Get_Host()
		// get information about host
		lul_ptr = gethostbyname(lvs_Host)
		
		If lul_ptr > 0 Then
			// copy structure to local structure
			CopyMemoryIP(lstr_host, lul_ptr, 16)
			// get memory address where ipaddress is located
			CopyMemoryIP(lul_ipaddr, lstr_host.h_addr_list, 4)
			// copy ipaddress to local blob
			lblb_ipaddr = Blob(Space(4),EncodingAnsi!)
			CopyMemoryIP(lblb_ipaddr, lul_ipaddr, 4)
			// convert blob to string ip address
			ls_ipaddress  = String(AscA(String(BlobMid(lblb_ipaddr,1,1),EncodingAnsi!)),"##0") + "."
			ls_ipaddress += String(AscA(String(BlobMid(lblb_ipaddr,2,1),EncodingAnsi!)),"##0") + "."
			ls_ipaddress += String(AscA(String(BlobMid(lblb_ipaddr,3,1),EncodingAnsi!)),"##0") + "."
			ls_ipaddress += String(AscA(String(BlobMid(lblb_ipaddr,4,1),EncodingAnsi!)),"##0")
		End If
		
		is_IP = ls_ipaddress
	End If
		
Catch( Exception Ex )
	MessageBox( "Exception", Ex.getMessage( ), StopSign! )
	
Finally
	If IsNull(is_IP) Then is_IP = ""
End Try

Return is_IP
end function

public function long of_get_filial ();If IsNull(il_Filial_Parametro) or (il_Filial_Parametro = 0) Then
	select cd_filial, cd_filial_matriz
	Into :il_Filial_Parametro, :il_Filial_Matriz
	From parametro
	Where id_parametro = '1'
	Using SQLCa;
	
	If SQLCa.SQLCode = -1 Then
		SQLCa.Of_msgdberror( "Localiza$$HEX2$$e700e300$$ENDHEX$$o filial par$$HEX1$$e200$$ENDHEX$$metro" )
	End If
End If

Return il_Filial_Parametro
end function

public function long of_get_tentativas_login (string ps_matricula, long pl_segundos);Datetime lvdth_Datahora
Long lvl_tentativas

lvdth_Datahora = gf_getserverdate()
lvdth_Datahora = gf_relative_datetime(lvdth_Datahora, 0 - pl_segundos)

Select count(1)
Into :lvl_tentativas
from usuario_login
Where dh_tentativa >= :lvdth_Datahora
 And nr_matricula = :ps_matricula
 And coalesce(id_sucesso,'N') = 'N'
Using SQLCa;

If SQLCa.SQLCode = -1 Then
	SQLCa.Of_Msgdberror("Localiza$$HEX2$$e700e300$$ENDHEX$$o tentativas login.")
	lvl_tentativas = 0
End If

Return lvl_tentativas
end function

private function boolean of_grava_historico_senha ();Long lvl_Total

/* Verifica quantidade de hist$$HEX1$$f300$$ENDHEX$$rico existente */
Select coalesce(count(1),0)
Into :lvl_Total
From usuario_historico_senha
Where nr_matricula = :Nr_Matricula
Using SQLCa;

/* Caso tenha mais que o necess$$HEX1$$e100$$ENDHEX$$rio limpa os registros mais antigos */
If IsNull(lvl_Total) Then lvl_Total = 0 

Do While lvl_Total >= Impor_Historico_Senha 
	delete from usuario_historico_senha
	Where nr_matricula = :Nr_Matricula
		And dh_alteracao_senha = (select min(u1.dh_alteracao_senha) 
											from usuario_historico_senha u1
											Where u1.nr_matricula = usuario_historico_senha.nr_matricula)
	Using SQLCa;
	
	lvl_Total --
Loop

/* Insere senha atual na tabela de historico */
Insert into usuario_historico_senha
select nr_matricula, dh_alteracao_senha, de_senha
From usuario
Where nr_matricula = :Nr_Matricula
Using SQLCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na altera$$HEX2$$e700e300$$ENDHEX$$o de senha. " + SqlCa.SqlErrText)
	Return False
End If

Return True
end function

public function boolean of_get_formatacao_senha (ref long pl_letras, ref long pl_numeros, ref long pl_caracteres_especiais, ref long pl_tamanho_senha, ref long pl_historico_senha);If Not Parametros_Carregados Then This.Of_carrega_parametros( )

pl_letras						= Qt_Letra_Senha
pl_numeros 					= Qt_Numero_Senha
pl_caracteres_especiais	= Qt_Caracter_Senha
pl_tamanho_senha		= Tamanho_Minimo_Senha
pl_historico_senha			= Impor_Historico_Senha

Return True
end function

public function boolean of_carrega_parametros ();String lvs_Aux
String lvs_Formatacao_Senha

/* Valores Padr$$HEX1$$e300$$ENDHEX$$o */
Dias_Altera_Senha 				= 0
Impor_Historico_Senha 			= 4
Tamanho_Minimo_Senha		= 6
Data_Alteracao_Politica_Senha	= Date('2018/01/01')
Qt_Letra_Senha					= 1
Qt_Numero_Senha				= 1
Qt_Caracter_Senha				= 1
lvs_Formatacao_Senha			= "0101010604" // [Qt. Letras=01]+[Qt. Num.=01]+[Qt. Carac.=01]+[Tam. Min. Senha=06]+[Qt. Hist$$HEX1$$f300$$ENDHEX$$rico=04]

/* Identifica se est$$HEX1$$e100$$ENDHEX$$ na matriz ou na filial */
Select cd_filial, cd_filial_matriz
INto :il_Filial_Parametro, :il_Filial_Matriz
From parametro
Where id_parametro = '1'
Using SQLCa;

If SQLCa.SQLCode = -1 Then
	SQLCa.of_MsgDbError( "Localiza$$HEX2$$e700e300$$ENDHEX$$o filial par$$HEX1$$e200$$ENDHEX$$metro." )
	Return False
End If

/*** Filial ***/
If il_Filial_Parametro <> il_Filial_Matriz Then
	//DIAS PARA ALTERAR A SENHA NOVAMENTE
	Select coalesce(vl_parametro,'0')
	Into :lvs_Aux
	From parametro_loja
	Where cd_parametro = 'NR_DIAS_ALTERACAO_SENHA'
	Using SQLCa;

	If SQLCa.SQLCode = -1 Then
		SQLCa.of_MsgDbError( "Localiza$$HEX2$$e700e300$$ENDHEX$$o par$$HEX1$$e200$$ENDHEX$$metro dias altera$$HEX2$$e700e300$$ENDHEX$$o de senha." )
		Return False
	ElseIf SQLCa.SQLCode = 0 and trim(lvs_Aux)<>"" Then
		Dias_Altera_Senha = Long(lvs_Aux)
	End If
	
	//DATA M$$HEX1$$cd00$$ENDHEX$$NIMA $$HEX1$$da00$$ENDHEX$$LTIMA ALTERA$$HEX2$$c700c300$$ENDHEX$$O SENHA
	Select coalesce(vl_parametro,'2018/01/01')
	Into :lvs_Aux
	From parametro_loja
	Where cd_parametro = 'DT_ALTERACAO_POLITICA_SENHA'
	Using SQLCa;

	If SQLCa.SQLCode = -1 Then
		SQLCa.of_MsgDbError( "Localiza$$HEX2$$e700e300$$ENDHEX$$o par$$HEX1$$e200$$ENDHEX$$metro dias altera$$HEX2$$e700e300$$ENDHEX$$o de senha." )
		Return False
	ElseIf SQLCa.SQLCode = 0 and trim(lvs_Aux)<>"" Then
		Data_Alteracao_Politica_Senha = Date(lvs_Aux)
	End If
	
	//FORMATACAO SENHA
	Select coalesce(vl_parametro,:lvs_Formatacao_Senha)
	Into :lvs_Aux
	From parametro_loja
	Where cd_parametro = 'ID_FORMATACAO_SENHA'
	Using SQLCa;

	If SQLCa.SQLCode = -1 Then
		SQLCa.of_MsgDbError( "Localiza$$HEX2$$e700e300$$ENDHEX$$o par$$HEX1$$e200$$ENDHEX$$metro dias altera$$HEX2$$e700e300$$ENDHEX$$o de senha." )
		Return False
	ElseIf SQLCa.SQLCode = 0 and trim(lvs_Aux)<>"" Then
		lvs_Formatacao_Senha = lvs_Aux
	End If	
Else 
	/***** MATRIZ  ****/
	//DIAS PARA ALTERAR A SENHA NOVAMENTE
	Select coalesce(vl_parametro,'0')
	Into :lvs_Aux
	From parametro_geral
	Where cd_parametro = 'NR_DIAS_ALTERACAO_SENHA'
	Using SQLCa;

	If SQLCa.SQLCode = -1 Then
		SQLCa.of_MsgDbError( "Localiza$$HEX2$$e700e300$$ENDHEX$$o par$$HEX1$$e200$$ENDHEX$$metro dias altera$$HEX2$$e700e300$$ENDHEX$$o de senha." )
		Return False
	ElseIf SQLCa.SQLCode = 0 and trim(lvs_Aux)<>"" Then
		Dias_Altera_Senha = Long(lvs_Aux)
	End If
	
	//DATA M$$HEX1$$cd00$$ENDHEX$$NIMA $$HEX1$$da00$$ENDHEX$$LTIMA ALTERA$$HEX2$$c700c300$$ENDHEX$$O SENHA
	Select coalesce(vl_parametro,'2018/01/01')
	Into :lvs_Aux
	From parametro_geral
	Where cd_parametro = 'DT_ALTERACAO_POLITICA_SENHA'
	Using SQLCa;

	If SQLCa.SQLCode = -1 Then
		SQLCa.of_MsgDbError( "Localiza$$HEX2$$e700e300$$ENDHEX$$o par$$HEX1$$e200$$ENDHEX$$metro dias altera$$HEX2$$e700e300$$ENDHEX$$o de senha." )
		Return False
	ElseIf SQLCa.SQLCode = 0 and trim(lvs_Aux)<>"" Then
		Data_Alteracao_Politica_Senha = Date(lvs_Aux)
	End If
	
	//FORMATACAO SENHA
	Select coalesce(vl_parametro,:lvs_Formatacao_Senha)
	Into :lvs_Aux
	From parametro_geral
	Where cd_parametro = 'ID_FORMATACAO_SENHA'
	Using SQLCa;

	If SQLCa.SQLCode = -1 Then
		SQLCa.of_MsgDbError( "Localiza$$HEX2$$e700e300$$ENDHEX$$o par$$HEX1$$e200$$ENDHEX$$metro dias altera$$HEX2$$e700e300$$ENDHEX$$o de senha." )
		Return False
	ElseIf SQLCa.SQLCode = 0 and trim(lvs_Aux)<>"" Then
		lvs_Formatacao_Senha = lvs_Aux
	End If	
End If

Qt_Letra_Senha				= Long(Mid(lvs_Formatacao_Senha, 1, 2))
Qt_Numero_Senha			= Long(Mid(lvs_Formatacao_Senha, 3, 2))
Qt_Caracter_Senha			= Long(Mid(lvs_Formatacao_Senha, 5, 2))
Tamanho_Minimo_Senha	= Long(Mid(lvs_Formatacao_Senha, 7, 2))
Impor_Historico_Senha		= Long(Mid(lvs_Formatacao_Senha, 9, 2)) 

If IsNull(Tamanho_Minimo_Senha) or (Tamanho_Minimo_Senha <= 0) Then Tamanho_Minimo_Senha = 1

Parametros_Carregados 		= True

Return Parametros_Carregados
end function

public function date of_get_data_alteracao_politica_senha ();If Not Parametros_Carregados Then This.Of_carrega_parametros( )

Return Data_Alteracao_Politica_Senha
end function

public subroutine of_get_configuracao_senha (ref date pdt_alteracao_politica_senha, ref long pl_periodicidade_troca_senha, ref long pl_letras, ref long pl_numeros, ref long pl_caracteres_especiais, ref long pl_tamanho_senha, ref long pl_historico_senha);If Not Parametros_Carregados Then This.Of_carrega_parametros( )

pdt_alteracao_politica_senha	= Data_alteracao_politica_senha
pl_periodicidade_troca_senha	= Dias_Altera_Senha

This.Of_get_formatacao_senha( pl_letras		, &
										  pl_numeros	, &
										  pl_caracteres_especiais, &
										  pl_tamanho_senha, &
										  pl_historico_senha)
end subroutine

public function string of_get_descricao_procedimento (boolean pb_mostra_mensagem);String ls_Descricao

Select de_procedimento 
Into :ls_Descricao
From procedimento_sistema
Where cd_sistema      = :This.Cd_Sistema
  and cd_procedimento = :This.Cd_Procedimento
Using SqlCa;

Choose Case SqlCa.SqlCode
                Case 0
                Case 100
                      ls_Descricao = ''
					If pb_mostra_mensagem Then
                               MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Procedimento '" + This.Cd_Procedimento + "' do sistema '" + &
                                                     This.Cd_Sistema + "' n$$HEX1$$e300$$ENDHEX$$o localizado.", StopSign!)
					End If
                Case -1
                      ls_Descricao = ''
					If pb_mostra_mensagem Then
						SqlCa.Of_Msgdberror( "Localiza$$HEX2$$e700e300$$ENDHEX$$o do procedimento '" + This.Cd_Procedimento + "' do sistema '" + This.Cd_Sistema + "'.")
					End If
End Choose

Return ls_Descricao

end function

public function string of_get_descricao_procedimento ();Return This.of_get_descricao_procedimento(True)
end function

private function date of_get_prox_alteracao_senha ();Date lvdh_Usuario
Date lvdh_Politica

lvdh_Usuario	= Date('2099/12/31')
lvdh_Politica 	= Date('2099/12/31')

//Se houver mudan$$HEX1$$e700$$ENDHEX$$a na pol$$HEX1$$ed00$$ENDHEX$$tica de Senha, ou se a data for nula e houver data de pol$$HEX1$$ed00$$ENDHEX$$tica de senha
If Not IsNull(Data_Alteracao_Politica_Senha) Then
	If ((IsNull(Dt_Ult_Altera_Senha)) or (Dt_Ult_Altera_Senha < RelativeDate(Data_Alteracao_Politica_Senha,-7))) Then
		If (Data_Alteracao_Politica_Senha <= Today()) Then
			lvdh_Politica = Today()
		Else
			lvdh_Politica = Data_Alteracao_Politica_Senha
		End If
	End If
End If

//Tem periodicidade de troca de senhas ativada?
If Dias_Altera_Senha > 0 Then
	lvdh_Usuario = RelativeDate(Date(Dt_Ult_Altera_Senha), Dias_Altera_Senha)
End If

Dt_Prox_Altera_Senha = IIF(lvdh_Usuario > lvdh_Politica, lvdh_Politica, lvdh_Usuario)

Return Dt_Prox_Altera_Senha
end function

public function boolean of_get_senha_expirada (boolean pb_exibe_aberta);Datetime lvdh_Data
Long lvl_Dias_Expirar
Long lvl_Linha
Long lvl_Filial
Long lvl_Filial_Matriz

If Not Parametros_Carregados Then This.Of_carrega_parametros( )

Select getdate(), cd_filial, cd_filial_matriz
Into :lvdh_Data, :lvl_Filial, :lvl_Filial_Matriz
from parametro
Where id_parametro = '1'
Using SQLCa; 

//Usu$$HEX1$$e100$$ENDHEX$$rios sistemas matriz em sistemas de loja
If lvl_Filial <> lvl_Filial_Matriz Then
	If This.of_get_perfil_usuario_matriz(This.Cd_Sistema, This.Cd_Perfil_Usuario) Then Return False
End if

lvl_Dias_Expirar = DaysAfter(Date(lvdh_Data), dt_prox_altera_senha)

If pb_exibe_aberta Then
	If lvl_Dias_Expirar <= 0 Then
		If This.De_senha <> ivo_encript.of_encripta(This.Nr_matricula) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Sua senha expirou.~r~rVoc$$HEX1$$ea00$$ENDHEX$$ precisa definir uma nova senha.",Exclamation!)
		End If
	ElseIf lvl_Dias_Expirar <= 7 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Resta(m) "+String(lvl_Dias_Expirar)+" dia(s) para a expira$$HEX2$$e700e300$$ENDHEX$$o da sua senha.~r~r"+&
						"Para definir uma nova senha acesse: 'Arquivo -> Alterar Senha'",IIF(lvl_Dias_Expirar > 1, Information!, Exclamation!))
	End If
End If

Return lvl_Dias_Expirar <= 0
end function

public function boolean of_get_perfil_usuario_matriz (string ps_sistema, long pl_perfil_usuario);Long lvl_Linha

String lvs_Perfil_Matriz = "S"

Boolean lvb_Sistema_Loja	= False

//Verifica se $$HEX1$$e900$$ENDHEX$$ um sistema de loja com controle de usu$$HEX1$$e100$$ENDHEX$$rio
For lvl_Linha = 1 To UpperBound(Sistemas_Sem_Bloq_Usuario)
	If ps_sistema = Sistemas_Sem_Bloq_Usuario[lvl_Linha] Then
		lvb_Sistema_Loja = True
		Exit
	End If
Next

//Verifica se $$HEX1$$e900$$ENDHEX$$ um perfil da matriz
If lvb_Sistema_Loja Then
	Select coalesce(id_perfil_matriz,'N')
	Into :lvs_Perfil_Matriz
	From perfil_usuario
	Where cd_perfil_usuario = :pl_perfil_usuario
		And cd_sistema = :ps_sistema
	Using SQLCa;
	
	Choose Case SQLCa.SQLCode
		Case -1 
			SQLCa.Of_msgdberror( "Localiza$$HEX2$$e700e300$$ENDHEX$$o perfil_usuario na identifica$$HEX2$$e700e300$$ENDHEX$$o matriz." )
		Case	100
			lvs_Perfil_Matriz = "N"
	End Choose
End If

Return lvs_Perfil_Matriz = "S"
end function

public function boolean of_valida_token_usuario (string ps_token, string ps_matricula);Datetime lvdh_Data_Atual
Datetime lvdh_Data_Validade

Boolean lvb_Valido = False

String lvs_Dia
String lvs_Hora
String lvs_Hora_Atual
String lvs_Minuto
String lvs_Segundo
String lvs_UF

dc_uo_encript lvo_encript
lvo_encript = Create dc_uo_encript
lvo_encript.of_set_mapas( {"0","1","2","3","4","5","6","7","8","9"}, &
								   {"5","2","0","3","9","8","4","7","6","1"})

//Desencripta com a matr$$HEX1$$ed00$$ENDHEX$$cula do usu$$HEX1$$e100$$ENDHEX$$rio como chave
ps_token 	= lvo_encript.of_decripta( ps_token, ps_matricula, False)

//Captura Hora (utilizada como chave para encripta$$HEX2$$e700e300$$ENDHEX$$o)
lvs_Segundo= Mid(ps_token, 2,1) + Mid(ps_token, 5, 1)
ps_token		= Mid(ps_token, 1, 1) + Mid(ps_token, 3, 2) +Mid(ps_token, 6)

//Desencripta com a matr$$HEX1$$ed00$$ENDHEX$$cula do usu$$HEX1$$e100$$ENDHEX$$rio como chave
ps_token 	= lvo_encript.of_decripta( ps_token, lvs_Segundo, False)

//Decomp$$HEX1$$f500$$ENDHEX$$e valores para compara$$HEX2$$e700e300$$ENDHEX$$o de validade
lvs_Dia		= Mid(ps_token, 1, 2)
lvs_Hora		= Mid(ps_token, 3, 2)
lvs_Minuto	= Mid(ps_token, 5, 2)

//Recupera a data/hora do servidor do BD
lvdh_Data_Atual 		= gf_getserverdate()

//Compara$$HEX2$$e700f500$$ENDHEX$$es de Valida$$HEX2$$e700e300$$ENDHEX$$o
//Dia
lvb_Valido = IsDate(lvs_Dia+"/"+String(lvdh_Data_Atual,"MM/YYYY"))
If lvb_Valido Then
	lvb_Valido = (Date(lvdh_Data_Atual) = Date(lvs_Dia+"/"+String(lvdh_Data_Atual,"MM/YYYY")))
	If Not lvb_Valido Then lvb_Valido =  (RelativeDate(Date(lvdh_Data_Atual), 1) = Date(lvs_Dia+"/"+String(lvdh_Data_Atual,"MM/YYYY")))
End If
If Not lvb_Valido Then Return lvb_Valido

//Hora
lvb_Valido = IsTime(lvs_Hora+":"+lvs_Minuto+":"+lvs_Segundo)
If lvb_Valido Then
	lvdh_Data_Validade = Datetime(Date(lvs_Dia+"/"+String(lvdh_Data_Atual,"MM/YYYY")), Time(lvs_Hora+":"+lvs_Minuto+":"+lvs_Segundo))

	lvb_Valido = (lvdh_Data_Atual <= lvdh_Data_Validade) and (gf_relative_datetime(lvdh_Data_Validade, 0 - Validade_Token_Usuario) >= lvdh_Data_Atual)
End If

//Se n$$HEX1$$e300$$ENDHEX$$o for v$$HEX1$$e100$$ENDHEX$$lido verifica hor$$HEX1$$e100$$ENDHEX$$rio de ver$$HEX1$$e300$$ENDHEX$$o e fuso
If Not lvb_Valido Then
	select c.cd_unidade_federacao
	Into :lvs_UF
	From parametro p
	inner join filial f
		on f.cd_filial = p.cd_filial
	inner join cidade c
		on c.cd_cidade = f.cd_cidade
	Where p.id_parametro = '1'
	Using SQLCa;
	
	Choose Case lvs_UF
		Case 'MS' // -1 hora
			lvdh_Data_Atual = gf_relative_datetime(lvdh_Data_Atual, 3600)
			lvb_Valido = (lvdh_Data_Atual <= lvdh_Data_Validade) and (gf_relative_datetime(lvdh_Data_Atual, Validade_Token_Usuario) >= lvdh_Data_Validade)
		Case 'BA'  // +1 hora
			lvdh_Data_Atual = gf_relative_datetime(lvdh_Data_Atual, -3600)
			lvb_Valido = (lvdh_Data_Atual <= lvdh_Data_Validade) and (gf_relative_datetime(lvdh_Data_Atual, Validade_Token_Usuario) >= lvdh_Data_Validade)
	End Choose
End If

Return lvb_Valido
end function

public function string of_gera_token_usuario (string ps_matricula);Datetime lvdh_Data

String lvs_Token

dc_uo_encript lvo_encript
lvo_encript = Create dc_uo_encript
lvo_encript.of_set_mapas( {"0","1","2","3","4","5","6","7","8","9"}, &
								   {"5","2","0","3","9","8","4","7","6","1"})


lvdh_Data = gf_getserverdate()

lvdh_Data = gf_relative_datetime(lvdh_Data, Validade_Token_Usuario)
 
lvs_Token = Mid(String(lvdh_Data, "DDMMYYYY"),1,2)+String(lvdh_Data, "HHMM") 

lvs_Token = lvo_encript.of_encripta( lvs_Token,Mid(String(lvdh_Data, "HHMMSS"),5,2) , False)

lvs_Token = Mid(lvs_Token, 1, 1)+Mid(String(lvdh_Data, "HHMMSS"),5,1)+ Mid(lvs_Token, 2, 2)+Mid(String(lvdh_Data, "HHMMSS"),6,1)+ Mid(lvs_Token, 4)

lvs_Token = lvo_encript.of_encripta( lvs_Token, ps_matricula, False)

Destroy(lvo_encript)

Return lvs_Token
end function

on dc_uo_seguranca.create
call super::create
TriggerEvent( this, "constructor" )
end on

on dc_uo_seguranca.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ivo_Encript = Create dc_uo_encript
end event

event destructor;Destroy(ivo_Encript)
end event

