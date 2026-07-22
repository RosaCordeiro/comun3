HA$PBExportHeader$uo_grupo_produto.sru
forward
global type uo_grupo_produto from nonvisualobject
end type
end forward

global type uo_grupo_produto from nonvisualobject
end type
global uo_grupo_produto uo_grupo_produto

type variables
Boolean localizado

Long cd_grupo_produto

String de_grupo_produto
end variables

forward prototypes
public subroutine of_localiza_generica (string ps_parametro)
public subroutine of_localiza (string ps_parametro)
public subroutine of_inicializa ()
public subroutine of_localiza_codigo (long pl_grupo)
end prototypes

public subroutine of_localiza_generica (string ps_parametro);String lvs_Grupo

OpenWithParm(w_ge057_Selecao_Grupo_Produto, ps_Parametro)

lvs_Grupo = Message.StringParm

If Not IsNull(lvs_Grupo) Then
	of_Localiza_Codigo(Long(lvs_Grupo))
Else
	Localizado = False
End If
end subroutine

public subroutine of_localiza (string ps_parametro);Integer lvi_Tamanho

lvi_Tamanho = LenA(ps_Parametro)

// Verifica se foi recebido algum par$$HEX1$$e200$$ENDHEX$$metro
If lvi_Tamanho > 0 Then
	
	// Verifica o tipo do par$$HEX1$$e200$$ENDHEX$$metro recebido
	If IsNumber(ps_Parametro) Then

		// Localiza$$HEX2$$e700e300$$ENDHEX$$o direta pelo c$$HEX1$$f300$$ENDHEX$$digo da cidade
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

public subroutine of_inicializa ();SetNull(This.Cd_Grupo_Produto)
SetNull(This.De_Grupo_Produto)
end subroutine

public subroutine of_localiza_codigo (long pl_grupo);Select cd_grupo_produto,
       de_grupo_produto
Into :cd_grupo_produto,
     :de_grupo_produto
From grupo_produto
Where cd_grupo_produto = :pl_Grupo
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		Localizado = True		
	Case 100
		Localizado = False
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Grupo")
		Localizado = False
End Choose
end subroutine

on uo_grupo_produto.create
TriggerEvent( this, "constructor" )
end on

on uo_grupo_produto.destroy
TriggerEvent( this, "destructor" )
end on

event constructor;This.of_Inicializa()
end event

