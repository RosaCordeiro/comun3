HA$PBExportHeader$uo_ge376_alteracao_preco_venda.sru
forward
global type uo_ge376_alteracao_preco_venda from nonvisualobject
end type
end forward

global type uo_ge376_alteracao_preco_venda from nonvisualobject
end type
global uo_ge376_alteracao_preco_venda uo_ge376_alteracao_preco_venda

type variables
Boolean Localizada

Long nr_alteracao

String de_alteracao
String nm_fantasia
String cd_fornecedor_faturamento
String id_situacao

dateTime dh_inclusao
end variables

forward prototypes
public subroutine of_localiza (string ps_parametro)
public subroutine of_inicializa ()
public subroutine of_localiza_generica (string ps_parametro)
public subroutine of_localiza_codigo (long pl_alteracao)
end prototypes

public subroutine of_localiza (string ps_parametro);Integer lvi_Tamanho

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

public subroutine of_inicializa ();SetNull( Nr_Alteracao )

de_alteracao = ''
nm_fantasia = ''
SetNull(cd_fornecedor_faturamento)

id_situacao = ''

SetNull( dh_inclusao )


end subroutine

public subroutine of_localiza_generica (string ps_parametro);String ls_Alteracao

OpenWithParm(w_ge376_selecao_alteracao_preco, ps_Parametro)

ls_Alteracao = Message.StringParm

If IsNull(ls_Alteracao) Then
	Localizada = False
Else
	of_Localiza_Codigo(Long(ls_Alteracao))
End If
end subroutine

public subroutine of_localiza_codigo (long pl_alteracao);Select 	nr_alteracao,   
			de_alteracao,
			dh_inclusao
Into	:nr_alteracao,
		:de_alteracao,
		:dh_inclusao
From alteracao_preco_venda  
 Where nr_alteracao 	= :pl_alteracao
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		Localizada = True		
		
	Case 100
		Localizada = False
		
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da An$$HEX1$$e100$$ENDHEX$$lise Spaceman")
		Localizada = False
End Choose
end subroutine

on uo_ge376_alteracao_preco_venda.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge376_alteracao_preco_venda.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;This.of_Inicializa()
end event

