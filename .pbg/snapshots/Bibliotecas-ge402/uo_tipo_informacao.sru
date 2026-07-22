HA$PBExportHeader$uo_tipo_informacao.sru
forward
global type uo_tipo_informacao from nonvisualobject
end type
end forward

global type uo_tipo_informacao from nonvisualobject
end type
global uo_tipo_informacao uo_tipo_informacao

type variables
Long	Cd_Tipo_Informacao
String De_Tipo_Informacao

Long Classificacao_Informacao

Boolean Localizado = False
end variables

forward prototypes
public subroutine of_inicializa ()
public function boolean of_localiza (string ps_parametro)
private function boolean of_localiza_generica (string ps_parametro)
public function boolean of_localiza_codigo (long pl_codigo)
end prototypes

public subroutine of_inicializa ();SetNull( Cd_Tipo_Informacao )
SetNull( De_Tipo_Informacao )
SetNull( Classificacao_Informacao )

Localizado = False
end subroutine

public function boolean of_localiza (string ps_parametro);If IsNumber(ps_parametro) Then
	This.Of_Localiza_Codigo( Long(ps_parametro) )
End If

If Not Localizado Then
	This.Of_Localiza_Generica( ps_parametro )
End If

Return Localizado
end function

private function boolean of_localiza_generica (string ps_parametro);OpenWithParm(w_ge402_selecao_tipo_informacao,ps_parametro)

If IsNumber(Message.StringParm) Then
	This.of_Localiza_Codigo( Long(Message.StringParm) )
Else
	This.Of_inicializa( )
End If

Return Localizado

end function

public function boolean of_localiza_codigo (long pl_codigo);//Localiza os valores no banco
SELECT cd_tipo_informacao, de_tipo_informacao, nr_classificacao
Into  :Cd_Tipo_Informacao, :De_Tipo_Informacao, :Classificacao_Informacao
From tipo_informacao
Where cd_tipo_informacao = :pl_codigo
Using SQLCa;

//Trata retorno
Choose Case SQLCa.SQLCode
	Case -1
		This.of_Inicializa()
	Case 0
		Localizado = True
	Case 100
		This.of_Inicializa()
End Choose
	  
Return Localizado
end function

on uo_tipo_informacao.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_tipo_informacao.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

