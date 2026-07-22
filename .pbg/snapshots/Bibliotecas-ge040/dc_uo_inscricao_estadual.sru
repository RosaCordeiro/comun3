HA$PBExportHeader$dc_uo_inscricao_estadual.sru
forward
global type dc_uo_inscricao_estadual from nonvisualobject
end type
end forward

global type dc_uo_inscricao_estadual from nonvisualobject
end type
global dc_uo_inscricao_estadual dc_uo_inscricao_estadual

type prototypes
Function Integer ConsisteInscricaoEstadual ( String aInscricaoEstadual, string aUF) library "C:\Sistemas\DLL\DllInscE32.Dll" alias for "ConsisteInscricaoEstadual;Ansi"
end prototypes

type variables
Boolean ivb_Exibe_Mensagem = True

String ivs_Erro
end variables

forward prototypes
public function boolean of_valida_inscricao_estadual (string as_uf, string as_inscricao_estadual)
end prototypes

public function boolean of_valida_inscricao_estadual (string as_uf, string as_inscricao_estadual);Integer li_Retorno

li_Retorno = 0
ivs_Erro = ''

Try
	li_Retorno = ConsisteInscricaoEstadual(as_Inscricao_Estadual, as_UF)

	Catch(RunTimeError lo_error)
		If lo_error.Text <> "" Then
			ivs_Erro = "N$$HEX1$$e300$$ENDHEX$$o foi localizado a DLL 'DllInscE32.dll'.~rVoc$$HEX1$$ea00$$ENDHEX$$ pode salvar o Fornecedor/Cliente sem validar a Inscri$$HEX2$$e700e300$$ENDHEX$$o Estadual~rou entre em contato com o CPD para instalar a mesma."
			If ivb_Exibe_Mensagem Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ivs_Erro)
			End If
			Return False
		End If	
	Finally
End Try

If li_Retorno = 0 Then
	Return True
Else
	Return False
End If
end function

event constructor;//..
	
end event

on dc_uo_inscricao_estadual.create
call super::create
TriggerEvent( this, "constructor" )
end on

on dc_uo_inscricao_estadual.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

