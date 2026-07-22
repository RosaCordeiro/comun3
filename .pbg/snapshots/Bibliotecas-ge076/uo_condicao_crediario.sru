HA$PBExportHeader$uo_condicao_crediario.sru
forward
global type uo_condicao_crediario from nonvisualobject
end type
end forward

global type uo_condicao_crediario from nonvisualobject
end type
global uo_condicao_crediario uo_condicao_crediario

type variables
Boolean Localizada

Long  Cd_Condicao

Decimal Vl_Minimo

String De_Condicao, &
          ivs_Parametro_Selecao
end variables

forward prototypes
public function boolean of_localiza_codigo (integer pl_parametro)
public subroutine of_inicializa ()
public function boolean of_localiza_generica (string ps_parametro)
public subroutine of_localiza (string ps_parametro)
end prototypes

public function boolean of_localiza_codigo (integer pl_parametro);Boolean lvb_Sucesso = False

Select cd_condicao_crediario,
       cd_condicao_crediario,
		 vl_minimo
Into :Cd_Condicao,
     :De_Condicao,
	  :Vl_Minimo
From condicao_venda_crediario
Where cd_condicao_crediario = :pl_Parametro
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		lvb_Sucesso = True
		
	Case 100
		
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da Condi$$HEX2$$e700e300$$ENDHEX$$o de Venda Credi$$HEX1$$e100$$ENDHEX$$rio")
End Choose

Return lvb_Sucesso
end function

public subroutine of_inicializa ();SetNull(Cd_Condicao)
De_Condicao = ""
end subroutine

public function boolean of_localiza_generica (string ps_parametro);STRING lvs_Condicao

This.ivs_Parametro_Selecao = ps_Parametro

OpenWithParm(w_ge076_Selecao_Condicao_Crediario, This)

lvs_Condicao = Message.StringParm

If Not IsNull(lvs_Condicao) Then
	Localizada = of_Localiza_Codigo(Long(lvs_Condicao))
Else
	Localizada = False
End If

Return Localizada
end function

public subroutine of_localiza (string ps_parametro);Integer lvi_Tamanho

lvi_Tamanho = LenA(ps_Parametro)

// Verifica se foi recebido algum par$$HEX1$$e200$$ENDHEX$$metro
If lvi_Tamanho > 0 Then
	
	// Verifica o tipo do par$$HEX1$$e200$$ENDHEX$$metro recebido
	If IsNumber(ps_Parametro) Then

		// Localiza$$HEX2$$e700e300$$ENDHEX$$o direta pelo c$$HEX1$$f300$$ENDHEX$$digo da filial
		of_Localiza_Codigo(Long(ps_Parametro))

		If Not Localizada Then

			// Se n$$HEX1$$e300$$ENDHEX$$o localizar pelos m$$HEX1$$e900$$ENDHEX$$todos anteriores
			// Abre a janela de localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica
			of_Localiza_Generica("")
	
		End If
	
	Else
	
		// Localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica conforme o nome do cliente
		of_Localiza_Generica(ps_Parametro)

	End If
	
Else
	
	// Localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica sem par$$HEX1$$e200$$ENDHEX$$metros
	of_Localiza_Generica("")
End If
end subroutine

on uo_condicao_crediario.create
TriggerEvent( this, "constructor" )
end on

on uo_condicao_crediario.destroy
TriggerEvent( this, "destructor" )
end on

