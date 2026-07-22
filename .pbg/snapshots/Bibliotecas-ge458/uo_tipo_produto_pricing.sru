HA$PBExportHeader$uo_tipo_produto_pricing.sru
forward
global type uo_tipo_produto_pricing from nonvisualobject
end type
end forward

global type uo_tipo_produto_pricing from nonvisualobject
end type
global uo_tipo_produto_pricing uo_tipo_produto_pricing

type variables
Boolean Localizada = False

Long cd_tipo_produto
String de_tipo_produto
end variables

forward prototypes
public subroutine of_inicializa ()
public function boolean of_localiza_codigo (long pl_codigo)
public function boolean of_localiza (string ps_parametro)
public function boolean of_localiza_generica (string ps_parametro)
end prototypes

public subroutine of_inicializa ();Localizada = False

SetNull( cd_tipo_produto )
SetNull( de_tipo_produto )
end subroutine

public function boolean of_localiza_codigo (long pl_codigo);This.Of_Inicializa( )

select cd_tipo_produto,
		de_tipo_produto
Into :cd_tipo_produto,
	  :de_tipo_produto
From tipo_produto_pricing
Where cd_tipo_produto = :pl_codigo
Using SQLCa;

If SQLCa.SQLCode = -1 Then
	SQLCa.Of_msgdberror( "Localiza$$HEX2$$e700e300$$ENDHEX$$o tipo produto pricing por c$$HEX1$$f300$$ENDHEX$$digo." )
End if

This.Localizada = (SQLCa.SQLCode = 0)

Return This.Localizada
end function

public function boolean of_localiza (string ps_parametro);This.Of_inicializa( )

If IsNumber(ps_parametro) Then
	This.Of_Localiza_Codigo( Long(ps_parametro) )
End If

If Not This.Localizada Then
	This.Of_Localiza_Generica( ps_parametro)
End If

Return This.Localizada
end function

public function boolean of_localiza_generica (string ps_parametro);OpenWithParm(w_ge458_selecao_tipo_prd_pricing, ps_parametro)

If IsNumBer(Message.StringParm) Then
	This.Of_localiza_codigo( Long(Message.StringParm) )
End If

Return This.Localizada
end function

on uo_tipo_produto_pricing.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_tipo_produto_pricing.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

