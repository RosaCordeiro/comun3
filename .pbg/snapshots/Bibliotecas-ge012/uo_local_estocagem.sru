HA$PBExportHeader$uo_local_estocagem.sru
forward
global type uo_local_estocagem from nonvisualobject
end type
end forward

global type uo_local_estocagem from nonvisualobject
end type
global uo_local_estocagem uo_local_estocagem

type variables
//
BOOLEAN	Localizado
LONG      	cd_local_estocagem
STRING		de_local_estocagem
STRING		id_auto_servico
STRING		id_etiqueta_gondola
//

// FIXO ANTIBIOTICOS
LONG      	cd_local_antibioticos = 0
STRING		de_local_antibioticos = 'ANTIBIOTICOS ( DE TODOS OS LOCAIS )'
//
end variables

forward prototypes
public subroutine of_localiza_generica (string ps_parametro)
public subroutine of_localiza_local (string ps_parametro)
public subroutine of_localiza_codigo (long a_local_estocagem)
public subroutine of_inicializa ()
end prototypes

public subroutine of_localiza_generica (string ps_parametro);LONG lvl_local

OpenWithParm(w_ge012_Selecao_Local_Estocagem, ps_Parametro)

lvl_local = Message.DoubleParm

If Not IsNull(lvl_local) Then
	of_Localiza_Codigo(lvl_local)
Else
	Localizado = False
End If
end subroutine

public subroutine of_localiza_local (string ps_parametro);Integer lvi_Tamanho

lvi_Tamanho = Len(ps_Parametro)

// Verifica se foi recebido algum par$$HEX1$$e200$$ENDHEX$$metro
If lvi_Tamanho > 0 Then
	
	// Verifica o tipo do par$$HEX1$$e200$$ENDHEX$$metro recebido
	If IsNumber(ps_Parametro) Then

		// Localiza$$HEX2$$e700e300$$ENDHEX$$o direta pelo c$$HEX1$$f300$$ENDHEX$$digo do cliente
		of_Localiza_Codigo(Long(ps_Parametro))

		If Not Localizado Then

			// Se n$$HEX1$$e300$$ENDHEX$$o localizar pelos m$$HEX1$$e900$$ENDHEX$$todos anteriores
			// Abre a janela de localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica
			of_Localiza_Generica("")
	
		End If
	
	Else
	
		// Localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica conforme o nome do cliente
		of_Localiza_Generica(ps_Parametro)

	End If
	
Else
	
	// Localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica sem par$$HEX1$$e200$$ENDHEX$$metros
	of_Localiza_Generica("")
End If
end subroutine

public subroutine of_localiza_codigo (long a_local_estocagem);//
If a_local_estocagem = 0 Then
	Localizado 				= TRUE
	cd_local_estocagem	= cd_local_antibioticos
	de_local_estocagem	= de_local_antibioticos
	id_auto_servico			= 'N'
	id_etiqueta_gondola	= 'N'
Else
	SELECT local_estocagem.cd_local_estocagem,   
			 local_estocagem.de_local_estocagem,   
			 local_estocagem.id_auto_servico,
			 local_estocagem.id_etiqueta_gondola
	INTO 	 :cd_local_estocagem,   
			 :de_local_estocagem,   
			 :id_auto_servico,
			 :id_etiqueta_gondola
	FROM local_estocagem  
	WHERE local_estocagem.cd_local_estocagem = :a_local_estocagem;
	//
	IF SqlCa.SqlCode = 100 THEN
		Localizado = FALSE
	ELSE
		Localizado = TRUE
	END IF
	
End If // a_local_estocagem = 0
//
end subroutine

public subroutine of_inicializa ();Localizado = False
SetNull(cd_local_estocagem)
SetNull(de_local_estocagem)
SetNull(id_auto_servico)
SetNull(id_etiqueta_gondola)
end subroutine

on uo_local_estocagem.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_local_estocagem.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

