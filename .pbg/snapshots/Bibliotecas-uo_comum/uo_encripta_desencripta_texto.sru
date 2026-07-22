HA$PBExportHeader$uo_encripta_desencripta_texto.sru
forward
global type uo_encripta_desencripta_texto from nonvisualobject
end type
end forward

global type uo_encripta_desencripta_texto from nonvisualobject
end type
global uo_encripta_desencripta_texto uo_encripta_desencripta_texto

forward prototypes
public function string of_encripta (string pr_string)
public function string of_desencripta (string pr_string)
end prototypes

public function string of_encripta (string pr_string);SetPointer(HourGlass!)

Long lvl_tamanho, lvl_contador
String lvs_parte, lvs_retorno
Integer lvi_caracter

// Verifica o tamnho do string passado como parametro

lvl_tamanho = LenA(pr_string)

// Loop de convers$$HEX1$$e300$$ENDHEX$$o dos caracteres do string passado como parametro

FOR lvl_contador = 1 TO lvl_tamanho
	lvs_parte = MidA(pr_string, lvl_contador, 1)
	lvi_caracter = AscA(lvs_parte)
	lvi_caracter = lvi_caracter + 100
	lvs_parte = CharA(lvi_caracter)
	lvs_retorno = lvs_retorno + lvs_parte
NEXT

// Retorna

Return lvs_retorno
end function

public function string of_desencripta (string pr_string);SetPointer(HourGlass!)

Long lvl_tamanho, lvl_contador
String lvs_parte, lvs_retorno
Integer lvi_caracter

// Verifica o tamnho do string passado como parametro

lvl_tamanho = LenA(pr_string)

// Loop de convers$$HEX1$$e300$$ENDHEX$$o dos caracteres do string passado como parametro

FOR lvl_contador = 1 TO lvl_tamanho
	lvs_parte = MidA(pr_string, lvl_contador, 1)
	lvi_caracter = AscA(lvs_parte)
	lvi_caracter = lvi_caracter - 100
	lvs_parte = CharA(lvi_caracter)
	lvs_retorno = lvs_retorno + lvs_parte
NEXT

// Retorna

Return lvs_retorno
end function

on uo_encripta_desencripta_texto.create
TriggerEvent( this, "constructor" )
end on

on uo_encripta_desencripta_texto.destroy
TriggerEvent( this, "destructor" )
end on

