HA$PBExportHeader$uo_ge349_tipo_servico.sru
forward
global type uo_ge349_tipo_servico from nonvisualobject
end type
end forward

global type uo_ge349_tipo_servico from nonvisualobject
end type
global uo_ge349_tipo_servico uo_ge349_tipo_servico

type variables
Long Cd_Tipo
String De_Tipo

Boolean Localizado
end variables

forward prototypes
public subroutine of_inicializa ()
public function boolean of_localiza (string ps_parametro)
public function boolean of_localiza_generica (string ps_parametro)
public function boolean of_localiza_codigo (long pl_parametro)
end prototypes

public subroutine of_inicializa ();SetNull(Cd_Tipo)
De_Tipo = ''
end subroutine

public function boolean of_localiza (string ps_parametro);Long lvl_Servico 

Localizado = False

If IsNumber(ps_parametro) Then
	This.Of_Localiza_Codigo(Long(ps_parametro))
End If

If Not(Localizado) Then
	This.of_Localiza_Generica(ps_parametro)
End If
			
Return Localizado
end function

public function boolean of_localiza_generica (string ps_parametro);Long lvl_Tipo

OpenWithParm(w_ge349_selecao_tipo_servico,ps_parametro)

If IsNumber(Message.StringParm) Then
	lvl_Tipo = Long(Message.StringParm)
	
	If (lvl_Tipo > 0) Then
		This.Of_Localiza_Codigo(lvl_Tipo)
	ElseIf Cd_Tipo > 0 Then 
		This.Of_Localiza_Codigo(Cd_Tipo)
	Else
		This.Of_Inicializa()
	End If
End If

Return Localizado
end function

public function boolean of_localiza_codigo (long pl_parametro);String lvs_Tipo

Select de_tipo
Into :lvs_Tipo
From tipo_servico
where cd_tipo = :pl_parametro
Using SQLCa;

Choose Case SqlCa.SqlCode 
	Case 0
		Cd_Tipo	= pl_parametro
		De_Tipo	= lvs_Tipo
		
		Localizado = True
	Case -1 
		MessageBox('Erro','Erro ao recuperar o servi$$HEX1$$e700$$ENDHEX$$o.',StopSign!)		
End Choose

Return Localizado
end function

on uo_ge349_tipo_servico.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge349_tipo_servico.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;of_inicializa()
end event

