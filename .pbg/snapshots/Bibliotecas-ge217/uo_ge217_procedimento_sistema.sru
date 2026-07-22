HA$PBExportHeader$uo_ge217_procedimento_sistema.sru
forward
global type uo_ge217_procedimento_sistema from nonvisualobject
end type
end forward

global type uo_ge217_procedimento_sistema from nonvisualobject
end type
global uo_ge217_procedimento_sistema uo_ge217_procedimento_sistema

type variables
Boolean Localizado

String cd_sistema, &
          cd_procedimento, &
          de_procedimento
end variables

forward prototypes
public function boolean of_matricula (string ps_conveniado)
public subroutine of_localiza_codigo (string ps_sistema, string ps_procedimento)
public subroutine of_localiza_procedimento (string ps_sistema, string ps_procedimento)
end prototypes

public function boolean of_matricula (string ps_conveniado);Integer lvi_Tamanho, &
        lvi_Contador

String lvs_Char

lvi_Tamanho = Len(ps_Conveniado)

For lvi_Contador = 1 To lvi_Tamanho

	lvs_Char = Mid(ps_Conveniado, lvi_Contador, 1)
	
	If IsNumber(lvs_Char) Then
		Return True
	End If
	
Next	

Return False
end function

public subroutine of_localiza_codigo (string ps_sistema, string ps_procedimento);Select cd_sistema,
       cd_procedimento,
       de_procedimento
Into :cd_sistema,
     :cd_procedimento,
     :de_procedimento
From procedimento_sistema
Where cd_sistema      = :ps_sistema
  and cd_procedimento = :ps_procedimento;

If SqlCa.SqlCode = 100 Then
	Localizado = False
Else
	Localizado = True
End If
end subroutine

public subroutine of_localiza_procedimento (string ps_sistema, string ps_procedimento);String lvs_Sistema, &
		lvs_Procedimento
	
uo_ge217_Parametro_Proc_Sistema lvo_Parametro

lvo_Parametro = Create uo_ge217_Parametro_Proc_Sistema

lvo_Parametro.ivs_Sistema = ps_Sistema

// Verifica o par$$HEX1$$e200$$ENDHEX$$metro recebido

lvo_Parametro.ivs_Procedimento 	= ""
lvo_Parametro.ivs_Nome          	= ps_Procedimento

OpenWithParm(w_ge217_Procedimento_Sistema, lvo_Parametro)

lvs_Procedimento = Message.StringParm

If Not IsNull(lvs_Procedimento) Then
	of_Localiza_Codigo(ps_Sistema, lvs_Procedimento)
Else
	Localizado = False
End If

Destroy(lvo_Parametro)
end subroutine

on uo_ge217_procedimento_sistema.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge217_procedimento_sistema.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

