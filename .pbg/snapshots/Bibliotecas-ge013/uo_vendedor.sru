HA$PBExportHeader$uo_vendedor.sru
forward
global type uo_vendedor from nonvisualobject
end type
end forward

global type uo_vendedor from nonvisualobject
end type
global uo_vendedor uo_vendedor

type variables
//
BOOLEAN	Localizado
STRING		nm_usuario   
DEC{2}		pc_comissao
STRING		nr_matricula_vendedor

//
end variables

forward prototypes
public subroutine of_localiza_generica (string ps_parametro)
public subroutine of_localiza_vendedor (string ps_parametro)
public function boolean of_localiza_codigo (string a_vendedor)
public subroutine of_inicializa ()
end prototypes

public subroutine of_localiza_generica (string ps_parametro);String lvs_vendedor

OpenWithParm(w_ge013_Selecao_Vendedor, ps_Parametro)

lvs_vendedor = Message.StringParm

IF NOT ISNULL(lvs_vendedor) THEN
	of_Localiza_Codigo(lvs_vendedor)
ELSE
	Localizado = FALSE
END IF
end subroutine

public subroutine of_localiza_vendedor (string ps_parametro);Integer lvi_Tamanho

lvi_Tamanho = LenA(ps_Parametro)

// Verifica se foi recebido algum par$$HEX1$$e200$$ENDHEX$$metro
If lvi_Tamanho > 0 Then
	// Verifica o tipo do par$$HEX1$$e200$$ENDHEX$$metro recebido
	If IsNumber(ps_Parametro) Then
		// Localiza$$HEX2$$e700e300$$ENDHEX$$o direta pelo c$$HEX1$$f300$$ENDHEX$$digo do cliente
		of_Localiza_Codigo(ps_Parametro)

		If Not Localizado Then
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

public function boolean of_localiza_codigo (string a_vendedor);Select v.nr_matricula_vendedor,   
		 u.nm_usuario,   
       v.pc_comissao
Into :nr_matricula_vendedor,
	  :nm_usuario,
	  :pc_comissao
From vendedor v,
     usuario u
Where v.nr_matricula_vendedor = :a_vendedor
  and u.nr_matricula = v.nr_matricula_vendedor
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		Localizado = True		
	Case 100
		Localizado = False
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Vendedor")
		Localizado = False
End Choose

Return Localizado
end function

public subroutine of_inicializa ();SetNull(This.Nr_Matricula_Vendedor)
This.Nm_Usuario = ""
This.Pc_Comissao = 0
end subroutine

on uo_vendedor.create
TriggerEvent( this, "constructor" )
end on

on uo_vendedor.destroy
TriggerEvent( this, "destructor" )
end on

event constructor;This.of_Inicializa()
end event

