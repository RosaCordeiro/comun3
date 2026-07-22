HA$PBExportHeader$uo_perfil_nota_diversa.sru
forward
global type uo_perfil_nota_diversa from nonvisualobject
end type
end forward

global type uo_perfil_nota_diversa from nonvisualobject
end type
global uo_perfil_nota_diversa uo_perfil_nota_diversa

type variables
Boolean Localizado

String ivs_Parametro_Selecao

Long Cd_Perfil_NF
String De_Perfil_NF
String Cd_Unidade_Federacao
Long Cd_CFOP_Estadual
Long Cd_CFOP_Interestadual
end variables

forward prototypes
public subroutine of_inicializa ()
public function boolean of_localiza_generica (string ps_parametro)
public function boolean of_localiza_perfil_nf (string ps_parametro)
public function boolean of_localiza_codigo (long pl_cd_perfil_nf)
end prototypes

public subroutine of_inicializa ();Localizado = False

end subroutine

public function boolean of_localiza_generica (string ps_parametro);Long lvl_Tipo_NF

This.ivs_Parametro_Selecao = ps_Parametro

OpenWithParm(w_ge476_selecao_perfil_nf, ps_Parametro)

lvl_Tipo_NF = Message.DoubleParm

If IsNull(lvl_Tipo_NF) and (lvl_Tipo_NF <= 0) Then
	Localizado = False
Else
	of_Localiza_Codigo(lvl_Tipo_NF)
End If

Return Localizado
end function

public function boolean of_localiza_perfil_nf (string ps_parametro);Integer lvi_Tamanho

lvi_Tamanho = LenA(ps_Parametro)

// Verifica se foi recebido algum par$$HEX1$$e200$$ENDHEX$$metro
If lvi_Tamanho > 0 Then
	
	// Verifica o tipo do par$$HEX1$$e200$$ENDHEX$$metro recebido
	If IsNumber(ps_Parametro) Then

		// Localiza$$HEX2$$e700e300$$ENDHEX$$o direta pelo c$$HEX1$$f300$$ENDHEX$$digo da cidade
		of_Localiza_Codigo(Long(ps_Parametro))

		If Not Localizado Then

			// Se n$$HEX1$$e300$$ENDHEX$$o localizar pelos m$$HEX1$$e900$$ENDHEX$$todos anteriores
			// Abre a janela de localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica
			of_Localiza_Generica("")
	
		End If
	
	Else
	
		// Localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica conforme o nome da cidade
		of_Localiza_Generica(ps_Parametro)

	End If
	
Else
	
	// Localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica sem par$$HEX1$$e200$$ENDHEX$$metros
	of_Localiza_Generica("")
End If

Return Localizado
end function

public function boolean of_localiza_codigo (long pl_cd_perfil_nf);Select cd_perfil_nf,
		de_perfil_nf, 
		cd_unidade_federacao,
		cd_cfop_estadual,
		cd_cfop_interestadual
Into 	:Cd_Perfil_NF,
		:De_Perfil_NF,
		:Cd_Unidade_Federacao,
		:Cd_CFOP_Estadual,
		:Cd_CFOP_Interestadual
From perfil_nota_diversa
Where cd_perfil_nf = :pl_cd_perfil_nf
Using SQLCa;

If SqlCa.SqlCode = 100 Then
	Localizado = False
ElseIf SqlCa.SqlCode = -1 Then
	SQLCa.Of_Msgdberror( "Localiza$$HEX2$$e700e300$$ENDHEX$$o das informa$$HEX2$$e700f500$$ENDHEX$$es perfil_nota_diversa." )
	This.Of_Inicializa()
Else	
	Localizado = True		
End If

Return Localizado
end function

on uo_perfil_nota_diversa.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_perfil_nota_diversa.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

