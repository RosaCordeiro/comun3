HA$PBExportHeader$uo_grupo.sru
forward
global type uo_grupo from nonvisualobject
end type
end forward

global type uo_grupo from nonvisualobject
end type
global uo_grupo uo_grupo

type variables
Boolean	localizado

String	cd_grupo, &
			de_grupo
end variables

forward prototypes
public subroutine of_localiza_generica (string ps_parametro)
public subroutine of_localiza (string ps_parametro)
public subroutine of_inicializa ()
public subroutine of_localiza_codigo (string ps_grupo)
end prototypes

public subroutine of_localiza_generica (string ps_parametro);String ls_Grupo

OpenWithParm (w_ge613_selecao_grupo, ps_Parametro)

ls_Grupo = Message.StringParm

If Not IsNull (ls_Grupo) then
	of_Localiza_Codigo (ls_Grupo)
Else
	Localizado = False
End If

Return
end subroutine

public subroutine of_localiza (string ps_parametro);Integer li_Tamanho

li_Tamanho = LenA (ps_Parametro)

// Verifica se foi recebido algum par$$HEX1$$e200$$ENDHEX$$metro
If li_Tamanho > 0 Then
	
	// Localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica conforme o c$$HEX1$$f300$$ENDHEX$$digo do grupo
	of_Localiza_Generica (ps_Parametro)
	
else
	
	// Localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica sem par$$HEX1$$e200$$ENDHEX$$metros
	of_Localiza_Generica ('')
End If

Return
end subroutine

public subroutine of_inicializa ();SetNull (This.Cd_Grupo)
SetNull (This.De_Grupo)
end subroutine

public subroutine of_localiza_codigo (string ps_grupo);SELECT cd_grupo,
		 de_grupo
  INTO :cd_grupo,
		 :de_grupo
  FROM grupo
 WHERE cd_grupo = :ps_Grupo
 USING SQLCA;

Choose Case SQLCA.SQLCode
	Case 0
		Localizado = True		
	Case 100
		Localizado = False
	Case -1
		SqlCa.of_MsgdbError ('Localiza$$HEX2$$e700e300$$ENDHEX$$o do Grupo')
		Localizado = False
End Choose

Return
end subroutine

on uo_grupo.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_grupo.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;This.of_Inicializa ()
end event

