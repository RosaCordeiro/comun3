HA$PBExportHeader$uo_campo_log.sru
forward
global type uo_campo_log from nonvisualobject
end type
end forward

global type uo_campo_log from nonvisualobject
end type
global uo_campo_log uo_campo_log

type variables
String Campo = ''
String Tabela = ''

Boolean Localizado = False

String Filtro_Campos = ""
end variables

forward prototypes
public subroutine of_inicializa ()
public function string of_localiza (string ps_parametro, string ps_tabela)
public subroutine of_set_filtro (string ps_campos)
end prototypes

public subroutine of_inicializa ();Localizado = False
Campo = ''
Tabela = ''
end subroutine

public function string of_localiza (string ps_parametro, string ps_tabela);String lvs_Campo

This.of_inicializa()

Tabela = ps_tabela

SELECT upper(c.name) as nm_campo
Into :lvs_Campo
FROM        sysobjects o
INNER JOIN  syscolumns c
	ON  o.id = c.id
Where upper(o.name) = :ps_tabela
	And upper(c.name) = :ps_parametro
Using SQLCa;

Choose Case SQLCa.SQLCode
	Case -1
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Erro na tentativa de localiza$$HEX2$$e700e300$$ENDHEX$$o da tabela com par$$HEX1$$e200$$ENDHEX$$metro "'+ps_parametro+'".~r~n'+SQLCa.SQLErrText,Exclamation!)
	Case 100
		Campo = ps_parametro
		OpenWithParm(w_ge321_selecao_campo, This)
		
		lvs_Campo = Message.StringParm
			
		If Trim(lvs_Campo) <> '' Then
			Campo = lvs_Campo
			Localizado = True
			//lvs_Campo = This.Of_Localiza(lvs_Campo,ps_tabela)
		End If
	Case 0
		Campo = lvs_Campo
		Localizado = True
End Choose

Return lvs_Campo
end function

public subroutine of_set_filtro (string ps_campos);If IsNull(ps_campos) Then ps_campos = ""

Filtro_Campos = ps_campos
end subroutine

on uo_campo_log.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_campo_log.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

