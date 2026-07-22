HA$PBExportHeader$uo_ge503_cartao_gift.sru
forward
global type uo_ge503_cartao_gift from nonvisualobject
end type
end forward

global type uo_ge503_cartao_gift from nonvisualobject
end type
global uo_ge503_cartao_gift uo_ge503_cartao_gift

type variables
Boolean Localizado = False

Integer Cd_Produto_Cartao

Long Cd_Cartao

String Nm_Cartao
String Nm_Categoria
String Nr_Bin
String Nr_Ean_Cartao
String Id_Venda_Pin
String De_Texto_TEF
String De_Faixa_Valores
end variables

forward prototypes
public subroutine of_inicializa ()
public subroutine of_localiza_generica (string ps_parametro)
public subroutine of_localiza_codigo (long pl_cartao)
public subroutine of_localiza_cartao_gift (string ps_parametro)
end prototypes

public subroutine of_inicializa ();Localizado = False

SetNull(Cd_Cartao)
SetNull(Cd_Produto_Cartao)
Nm_Cartao = ""
SetNull(Nm_Categoria)
SetNull(Nr_Bin)
SetNull(Nr_Ean_Cartao)
SetNull(Id_Venda_Pin)
SetNull(De_Texto_TEF)
SetNull(De_Faixa_Valores)
end subroutine

public subroutine of_localiza_generica (string ps_parametro);String ls_Cartao

OpenWithParm(w_ge503_selecao_cartao_gift, ps_Parametro)

ls_Cartao = Message.StringParm

If IsNull(ls_Cartao) Then
	Localizado = False
Else
	of_Localiza_Codigo(Long(ls_Cartao))
End If
end subroutine

public subroutine of_localiza_codigo (long pl_cartao);Select	cd_cartao,
		nm_cartao,
		nm_categoria,
		nr_bin,
		cd_produto_cartao,
		nr_ean_cartao,
		id_venda_pin,
		de_texto_tef,
		de_faixa_valores
Into	:Cd_Cartao,
		:Nm_Cartao,
		:Nm_Categoria,
		:Nr_Bin,
		:Cd_Produto_Cartao,
		:Nr_Ean_Cartao,
		:Id_Venda_Pin,
		:De_Texto_TEF,
		:De_Faixa_Valores
From cartao_gift
Where cd_cartao = :pl_Cartao
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		Localizado = True
		
	Case 100
		Localizado = False
		
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Cart$$HEX1$$e300$$ENDHEX$$o Gift")
		Localizado = False
End Choose
end subroutine

public subroutine of_localiza_cartao_gift (string ps_parametro);Integer lvi_Tamanho

lvi_Tamanho = Len(ps_Parametro)

If lvi_Tamanho > 0 Then
	If IsNumber(ps_Parametro) Then
		of_Localiza_Codigo(Long(ps_Parametro))

		If Not Localizado Then
			of_Localiza_Generica("")
		End If
	Else
		of_Localiza_Generica(ps_Parametro)
	End If
Else
	of_Localiza_Generica("")
End If
end subroutine

on uo_ge503_cartao_gift.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge503_cartao_gift.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;This.of_Inicializa()
end event

