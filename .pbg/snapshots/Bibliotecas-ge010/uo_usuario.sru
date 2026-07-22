HA$PBExportHeader$uo_usuario.sru
forward
global type uo_usuario from nonvisualobject
end type
end forward

global type uo_usuario from nonvisualobject
end type
global uo_usuario uo_usuario

type variables
Boolean Localizado
Boolean Somente_Estagiarios = False
Boolean Somente_Terceiros = False
Boolean Mostra_Inativos = False

String Nr_Matricula, &
          Nm_Usuario = "",&
          id_situacao, &
		 Nr_Cpf, &
		 De_Email, &
		 Cd_Cargo_Rh
		 
String id_Isento_Biometria

Long  Cd_Filial

long ivl_filial

string ivs_parametro

end variables

forward prototypes
public subroutine of_localiza_generica (string ps_parametro)
public subroutine of_localiza_usuario (string ps_parametro)
public subroutine of_localiza_matricula (string ps_usuario)
public subroutine of_todos_usuarios ()
public subroutine of_inicializa ()
end prototypes

public subroutine of_localiza_generica (string ps_parametro);String lvs_Usuario

This.ivs_Parametro = ps_Parametro

OpenWithParm(w_ge010_Selecao_Usuario, This)

lvs_Usuario = Message.StringParm

If Not IsNull(lvs_Usuario) Then
	of_Localiza_Matricula(lvs_Usuario)
Else
	Localizado = False
End If
end subroutine

public subroutine of_localiza_usuario (string ps_parametro);Integer lvi_Tamanho

lvi_Tamanho = LenA(ps_Parametro)

// Verifica se foi recebido algum par$$HEX1$$e200$$ENDHEX$$metro
If lvi_Tamanho > 0 Then
	
	// Verifica o tipo do par$$HEX1$$e200$$ENDHEX$$metro recebido
		If IsNumber(ps_Parametro) Then
			
			// Localiza$$HEX2$$e700e300$$ENDHEX$$o direta pelo c$$HEX1$$f300$$ENDHEX$$digo da cidade
			of_Localiza_Matricula(ps_Parametro)
		
			If Not Localizado Then
				
				// Se n$$HEX1$$e300$$ENDHEX$$o localizar pelos m$$HEX1$$e900$$ENDHEX$$todos anteriores
				// Abre a janela de localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica
				of_Localiza_Generica("")
			
			End If
	
	Else
	
		// Para Localiza$$HEX2$$e700e300$$ENDHEX$$o de Estagi$$HEX1$$e100$$ENDHEX$$rio n$$HEX1$$e300$$ENDHEX$$o remunerado, matr$$HEX1$$ed00$$ENDHEX$$cula composta por 'E' + Sequencial num$$HEX1$$e900$$ENDHEX$$rico iniciando em '00001' at$$HEX1$$e900$$ENDHEX$$ '99999'
		// Para Localiza$$HEX2$$e700e300$$ENDHEX$$o de Terceiros n$$HEX1$$e300$$ENDHEX$$o remunerado, matr$$HEX1$$ed00$$ENDHEX$$cula composta por 'E' + Sequencial num$$HEX1$$e900$$ENDHEX$$rico iniciando em '00001' at$$HEX1$$e900$$ENDHEX$$ '99999'
		If (LeftA( ps_Parametro, 1 ) = 'E' And IsNumber(MidA( ps_Parametro,2))) or  (LeftA( ps_Parametro, 1 ) = 'T' And IsNumber(MidA( ps_Parametro,2))) Then
			of_Localiza_Matricula( ps_Parametro )
			
			If Not Localizado Then
				
				// Se n$$HEX1$$e300$$ENDHEX$$o localizar pelos m$$HEX1$$e900$$ENDHEX$$todos anteriores
				// Abre a janela de localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica
				of_Localiza_Generica("")
			
			End If
		Else
			// Localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica conforme o nome do cliente
			of_Localiza_Generica(ps_Parametro)
		End If

	End If
	
Else
	
	// Localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica sem par$$HEX1$$e200$$ENDHEX$$metros
	of_Localiza_Generica("")
End If
end subroutine

public subroutine of_localiza_matricula (string ps_usuario);Select 	nr_matricula,
			nm_usuario,
			cd_filial,
			id_situacao,
			nr_cpf,
			de_endereco_email,
			COALESCE( id_isento_biometria, 'N' ),
			COALESCE(cd_cargo_rh,'000000000')
Into 	:Nr_Matricula,
		:Nm_Usuario,
		:Cd_Filial,
		:Id_situacao,
		:Nr_Cpf,
		:De_Email,
		:Id_Isento_Biometria,
		:Cd_Cargo_Rh
From usuario
Where nr_matricula = :ps_usuario;

If SqlCa.SqlCode = 100 Then
	Localizado = False
Else
	Localizado = True
	
//	If Not IsNull(ivl_Filial) Then
//		If This.Cd_Filial <> This.ivl_Filial Then
//			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O usu$$HEX1$$e100$$ENDHEX$$rio selecionado n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ desta filial.", StopSign!)
//			Localizado = False
//		End If
//	End If
End If
end subroutine

public subroutine of_todos_usuarios ();SetNull(This.ivl_Filial)
end subroutine

public subroutine of_inicializa ();SetNull(Nr_Matricula)
SetNull(Nm_Usuario)
SetNull(Cd_Filial)
SetNull(Nr_Cpf)
SetNull(De_Email)
SetNull(Id_Isento_Biometria)
SetNull(Cd_Cargo_Rh)
end subroutine

on uo_usuario.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_usuario.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;long lvl_Filial_Matriz

gf_Filiais_Parametro( ref This.ivl_Filial, ref lvl_Filial_Matriz )
end event

