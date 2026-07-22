HA$PBExportHeader$uo_pessoa_juridica.sru
forward
global type uo_pessoa_juridica from nonvisualobject
end type
end forward

global type uo_pessoa_juridica from nonvisualobject
end type
global uo_pessoa_juridica uo_pessoa_juridica

type variables
String Razao_Social
String Fantasia
String CNPJ
String Rua
String Nro
String Compl
String CEP
String Bairro
String Cidade
String UF
end variables

forward prototypes
public subroutine of_clear ()
end prototypes

public subroutine of_clear ();//Limpa vari$$HEX1$$e100$$ENDHEX$$veis
	Razao_Social = ''
   Fantasia = ''
   Rua =  ''
   Nro = ''
   Compl =  ''
   CEP = ''
   Bairro =  ''
   Cidade =  ''
   UF =  ''
end subroutine

on uo_pessoa_juridica.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_pessoa_juridica.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

