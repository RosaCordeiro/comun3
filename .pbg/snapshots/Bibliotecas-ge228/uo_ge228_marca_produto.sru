HA$PBExportHeader$uo_ge228_marca_produto.sru
forward
global type uo_ge228_marca_produto from nonvisualobject
end type
end forward

global type uo_ge228_marca_produto from nonvisualobject
end type
global uo_ge228_marca_produto uo_ge228_marca_produto

type variables
Boolean Localizada

Long Cd_marca

String De_marca
String De_SAC
String De_Atendimento
String De_Razao_Social
end variables

forward prototypes
public subroutine of_inicializa ()
public subroutine of_localiza_generica (string ps_parametro)
public subroutine of_localiza_codigo (long pl_marca)
public subroutine of_localiza_marca (string ps_parametro)
end prototypes

public subroutine of_inicializa ();SetNull(Cd_Marca)

De_marca			= ""
De_SAC				= ""
De_Atendimento	= ""
De_Razao_Social	= ""
end subroutine

public subroutine of_localiza_generica (string ps_parametro);String lvs_Marca

OpenWithParm(w_ge228_selecao_marca_produto, ps_Parametro)

lvs_Marca = Message.StringParm

If IsNull(lvs_Marca) Then
	Localizada = False
Else
	of_Localiza_Codigo(Long(lvs_Marca))
End If
end subroutine

public subroutine of_localiza_codigo (long pl_marca);Select 	cd_marca,   
			de_marca,   
			de_sac,   
			de_atendimento,   
			de_razao_social
Into	:cd_marca,
		:de_marca,
		:de_sac,
		:de_atendimento,
		:de_razao_social
From marca_produto  
 Where cd_marca 	= :pl_marca
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		Localizada = True		
		
	Case 100
		Localizada = False
		
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da Marca do Produto")
		Localizada = False
End Choose
end subroutine

public subroutine of_localiza_marca (string ps_parametro);Integer lvi_Tamanho

lvi_Tamanho = Len(ps_Parametro)

If lvi_Tamanho > 0 Then
	If IsNumber(ps_Parametro) Then
		of_Localiza_Codigo(Long(ps_Parametro))

		If Not Localizada Then
			of_Localiza_Generica("")
		End If
	Else
		of_Localiza_Generica(ps_Parametro)
	End If
Else
	of_Localiza_Generica("")
End If
end subroutine

on uo_ge228_marca_produto.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge228_marca_produto.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;This.of_Inicializa()
end event

