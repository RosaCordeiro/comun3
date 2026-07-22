HA$PBExportHeader$uo_tipo_icms.sru
forward
global type uo_tipo_icms from nonvisualobject
end type
end forward

global type uo_tipo_icms from nonvisualobject
end type
global uo_tipo_icms uo_tipo_icms

type variables
Long	Cd_Tipo_ICMS
String	De_Tipo_ICMS

Decimal{2} Pc_ICMS
Decimal{2} Pc_FCP
Decimal{2} Pc_ICMS_CD

String Cd_UF

Boolean Localizado = False
end variables

forward prototypes
public subroutine of_inicializa ()
public function boolean of_localiza (string ps_parametro)
public function boolean of_localiza_codigo (long pl_tipo_icms)
public function boolean of_localiza_generica (string ps_parametro)
public function boolean of_localiza (string ps_parametro, string ps_uf)
end prototypes

public subroutine of_inicializa ();SetNull(Cd_Tipo_ICMS)
SetNull(De_Tipo_ICMS)
SetNull(Pc_ICMS)
SetNull(Pc_FCP)
SetNull(Cd_UF)
SetNull(Pc_ICMS_CD)

Localizado = False
end subroutine

public function boolean of_localiza (string ps_parametro);Return This.Of_Localiza(ps_parametro,"")
end function

public function boolean of_localiza_codigo (long pl_tipo_icms);This.Of_Inicializa()

Select cd_tipo_icms, de_tipo_icms, cd_unidade_federacao, pc_icms, pc_fcp , pc_icms_cd
Into :Cd_Tipo_ICMS, :De_Tipo_ICMS, :Cd_UF, :Pc_ICMS, :Pc_FCP, :Pc_ICMS_CD
from tipo_icms
Where cd_tipo_icms = :pl_tipo_icms
Using SQLCa;

Localizado = (SQLCa.SQLCode = 0)
If SQLCa.SQLCode = -1 Then
	SQLCa.Of_Msgdberror( "Localiza$$HEX2$$e700e300$$ENDHEX$$o tipo icms." )
End If

Return Localizado
end function

public function boolean of_localiza_generica (string ps_parametro);String lvs_Retorno

OpenWithParm(w_ge021_selecao_tipo_icms, ps_parametro) 

lvs_Retorno = Message.StringParm

If Not IsNull(lvs_Retorno) and IsNumber(lvs_Retorno) Then
	This.Of_Localiza_Codigo( Long(lvs_Retorno) )
Else
	This.Of_Inicializa( )
End If

Return Localizado
end function

public function boolean of_localiza (string ps_parametro, string ps_uf);If IsNumber(Trim(ps_parametro)) Then
	This.Of_localiza_codigo( Long(ps_parametro) )
End If

If Not Localizado Then
	This.Of_localiza_generica(ps_parametro+";"+ps_uf)
End If

Return Localizado
end function

on uo_tipo_icms.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_tipo_icms.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

