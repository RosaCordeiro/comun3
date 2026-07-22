HA$PBExportHeader$uo_tabela_log.sru
forward
global type uo_tabela_log from nonvisualobject
end type
end forward

global type uo_tabela_log from nonvisualobject
end type
global uo_tabela_log uo_tabela_log

type variables
String Tabela = ''

Boolean Localizado = False

String Filtro_Tabelas = ""
end variables

forward prototypes
public subroutine of_inicializa ()
public function string of_localiza (string ps_parametro)
public subroutine of_set_filtro (string ps_tabelas)
end prototypes

public subroutine of_inicializa ();Localizado = False
Tabela = ''
end subroutine

public function string of_localiza (string ps_parametro);String lvs_Tabela

This.of_inicializa()

select Upper(o.name) as nm_tabela
Into :lvs_Tabela
from sysobjects o
where upper(o.name) = :ps_parametro
Using SQLCa;

Choose Case SQLCa.SQLCode
	Case -1
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Erro na tentativa de localiza$$HEX2$$e700e300$$ENDHEX$$o da tabela com par$$HEX1$$e200$$ENDHEX$$metro "'+ps_parametro+'".~r~n'+SQLCa.SQLErrText,Exclamation!)
	Case 100
		OpenWithParm(w_ge321_selecao_tabela, ps_parametro+";"+Filtro_Tabelas)
		lvs_Tabela = Message.StringParm
		
		If Trim(lvs_Tabela) <> '' Then
			//lvs_Tabela = This.Of_Localiza(lvs_Tabela)
			
			Tabela = lvs_Tabela
			Localizado = True
		End If
	Case 0
		Tabela = lvs_Tabela
		Localizado = True
End Choose

Return lvs_Tabela
end function

public subroutine of_set_filtro (string ps_tabelas);If IsNull(ps_tabelas) Then ps_tabelas = ""

Filtro_Tabelas = ps_tabelas
end subroutine

on uo_tabela_log.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_tabela_log.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

