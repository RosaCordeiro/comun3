HA$PBExportHeader$uo_ge099_bairro.sru
forward
global type uo_ge099_bairro from nonvisualobject
end type
end forward

global type uo_ge099_bairro from nonvisualobject
end type
global uo_ge099_bairro uo_ge099_bairro

type variables
/* Vari$$HEX1$$e100$$ENDHEX$$veis de rela$$HEX2$$e700e300$$ENDHEX$$o com o banco de dados */
Long nr_Bairro
Long cd_Cidade
Long cd_Cidade_Ibge

String de_Bairro
String de_Bairro_Complemento
String de_Bairro_Abreviado
String nm_Cidade
String cd_UF
String de_Complemento

Decimal vl_Frete
/**********/

Boolean Localizado = False

Long ivl_Cidade_Informada

String ivs_Parametro_Selecao
end variables

forward prototypes
public subroutine of_inicializa ()
public subroutine of_localiza_generica (string ps_parametro)
public function boolean of_localiza_codigo (long pl_codigo)
public subroutine of_localiza (string ps_parametro)
end prototypes

public subroutine of_inicializa ();Localizado = False

SetNull( nr_Bairro )
SetNull( cd_Cidade )
SetNull( cd_Cidade_Ibge )

de_Bairro = ''
de_Bairro_Complemento = ''
de_Bairro_Abreviado = ''
nm_Cidade = ''
SetNull( cd_UF )
de_Complemento = ''

SetNull( vl_Frete )
end subroutine

public subroutine of_localiza_generica (string ps_parametro);This.ivs_Parametro_Selecao = ps_Parametro

OpenWithParm( w_ge099_selecao_bairro, This )

ps_Parametro = Message.StringParm

If Not IsNull( ps_Parametro ) Then
	This.of_Localiza_Codigo( Long( ps_Parametro ) )
Else
	Localizado = False
End If
end subroutine

public function boolean of_localiza_codigo (long pl_codigo);Select	nr_bairro,
		de_bairro,
		vl_frete
Into :nr_Bairro,
	  :de_Bairro,
	  :vl_Frete
From ect_bairro
Where nr_bairro = :pl_Codigo
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		Localizado = True
		
	Case 100
		Localizado = False
		
	Case -1
		SqlCa.of_MsgdbError( "Localiza$$HEX2$$e700e300$$ENDHEX$$o do Bairro" )
		Localizado = False
		
End Choose

Return Localizado
end function

public subroutine of_localiza (string ps_parametro);Integer lvi_Tamanho 	    

lvi_Tamanho = LenA( Trim( ps_Parametro ) )

Localizado = False

If lvi_Tamanho > 0 Then	
	If IsNumber( ps_Parametro ) Then
		of_Localiza_Codigo(Long( ps_Parametro ))
	End If

	If Not Localizado Then
		of_Localiza_Generica(ps_Parametro)
	End If
Else
	of_Localiza_Generica(ps_Parametro)
End If
end subroutine

on uo_ge099_bairro.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge099_bairro.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

