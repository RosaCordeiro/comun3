HA$PBExportHeader$uo_ge242_mix_produto.sru
forward
global type uo_ge242_mix_produto from nonvisualobject
end type
end forward

global type uo_ge242_mix_produto from nonvisualobject
end type
global uo_ge242_mix_produto uo_ge242_mix_produto

type variables
long cd_mix_produto

string de_mix_produto, &
          ivs_parametro_selecao
end variables

forward prototypes
public subroutine of_inicializa ()
public function boolean of_localiza ()
public function boolean of_localiza_codigo (long pl_parametro)
end prototypes

public subroutine of_inicializa ();SetNull(Cd_Mix_Produto)
De_Mix_Produto = ""
end subroutine

public function boolean of_localiza ();String lvs_Mix

lvs_Mix = This.ivs_Parametro_Selecao

If IsNumber(lvs_Mix) Then
	If of_Localiza_Codigo(Long(lvs_Mix)) Then Return True
End If

OpenWithParm(w_ge242_selecao_mix_produto, This)
	
lvs_Mix = Message.StringParm
	
If IsNull(lvs_Mix) Then
	Return False
Else
	If of_Localiza_Codigo(Long(lvs_Mix)) Then
		Return True
	Else
		Return False
	End If
End If
end function

public function boolean of_localiza_codigo (long pl_parametro);Select cd_mix_produto,
       de_mix_produto
  Into :cd_mix_produto,
       :de_mix_produto
From   mix_produto
Where  cd_mix_produto = :pl_parametro
 Using SqlCa;

If SqlCa.SqlCode = 100 Then
	Return False
ElseIf SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do Mix de Produtos.")
	Return False
Else	
	Return True
End If
end function

on uo_ge242_mix_produto.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge242_mix_produto.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

