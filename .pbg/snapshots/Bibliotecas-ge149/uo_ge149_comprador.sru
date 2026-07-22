HA$PBExportHeader$uo_ge149_comprador.sru
forward
global type uo_ge149_comprador from nonvisualobject
end type
end forward

global type uo_ge149_comprador from nonvisualobject
end type
global uo_ge149_comprador uo_ge149_comprador

type variables
Boolean Localizado

String Nm_Usuario
String Nr_Matricula
String Id_Situacao
String is_Parametro
String De_Endereco_Email
end variables

forward prototypes
public subroutine of_localiza_generica (string ps_parametro)
public subroutine of_localiza_matricula (string ps_usuario)
public subroutine of_inicializa ()
public subroutine of_localiza_comprador (string ps_parametro)
end prototypes

public subroutine of_localiza_generica (string ps_parametro);String ls_Comprador

This.is_Parametro = ps_Parametro

OpenWithParm(w_ge149_Selecao_Comprador, This)

ls_Comprador = Message.StringParm

If Not IsNull(ls_Comprador) Then
	of_Localiza_Matricula(ls_Comprador)
Else
	Localizado = False
End If
end subroutine

public subroutine of_localiza_matricula (string ps_usuario);Select	u.nr_matricula,
		u.nm_usuario,
		c.id_situacao,
		u.de_endereco_email
Into	:Nr_Matricula,
		:Nm_Usuario,
		:Id_situacao,
		:De_Endereco_Email
From usuario u
	Inner Join comprador c
		On c.nr_matricula = u.nr_matricula
Where u.nr_matricula = :ps_usuario
    And coalesce (c.id_auxiliar_comprador, 'N') in ('S','N') 
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		Localizado = True

	Case 100
		Localizado = False
		
	Case -1
		Sqlca.Of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do comprador.")
		Localizado = False
End Choose
end subroutine

public subroutine of_inicializa ();Localizado = False

SetNull(Nr_Matricula)
SetNull(Id_Situacao)
SetNull(Nm_Usuario)
SetNull(De_Endereco_Email)
end subroutine

public subroutine of_localiza_comprador (string ps_parametro);Integer lvi_Tamanho

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
		If LeftA( ps_Parametro, 1 ) = 'E' And IsNumber( MidA( ps_Parametro, 2 ) ) Then
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

on uo_ge149_comprador.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge149_comprador.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;This.of_Inicializa()
end event

