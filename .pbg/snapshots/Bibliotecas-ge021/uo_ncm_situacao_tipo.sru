HA$PBExportHeader$uo_ncm_situacao_tipo.sru
forward
global type uo_ncm_situacao_tipo from nonvisualobject
end type
end forward

global type uo_ncm_situacao_tipo from nonvisualobject
end type
global uo_ncm_situacao_tipo uo_ncm_situacao_tipo

type variables
Long	Cd_Tipo_Situacao_NCM
String	De_Tipo_Situacao_NCM
String	Id_Situacao_Fiscal

Boolean Localizado = False
end variables

forward prototypes
public subroutine of_inicializa ()
public function boolean of_localiza (string ps_parametro)
public function boolean of_localiza_generica (string ps_parametro)
public function boolean of_localiza_codigo (long pl_codigo)
end prototypes

public subroutine of_inicializa ();SetNull(Cd_Tipo_Situacao_NCM)
SetNull(De_Tipo_Situacao_NCM)
SetNull(Id_Situacao_Fiscal)

Localizado = False
end subroutine

public function boolean of_localiza (string ps_parametro);If IsNumber(ps_parametro) Then
	This.Of_localiza_codigo( Long(ps_parametro ))
End If

If Not Localizado Then
	This.Of_localiza_Generica(ps_parametro)
End If

Return Localizado
end function

public function boolean of_localiza_generica (string ps_parametro);String lvs_Retorno

OpenWithParm(w_ge021_selecao_ncm_situacao_tipo, ps_parametro) 

lvs_Retorno = Message.StringParm

If Not IsNull(lvs_Retorno) and (Long(lvs_Retorno) > 0) Then
	This.Of_Localiza_Codigo( Long(lvs_Retorno))
Else
	This.Of_Inicializa( )
End If

Return Localizado
end function

public function boolean of_localiza_codigo (long pl_codigo);This.Of_Inicializa()

Select cd_tipo_situacao_ncm, de_tipo_situacao_ncm, id_situacao_fiscal
Into :Cd_Tipo_Situacao_NCM, :De_Tipo_Situacao_NCM, :Id_Situacao_Fiscal
from ncm_situacao_tipo
Where cd_tipo_situacao_ncm = :pl_codigo
Using SQLCa;

Localizado = (SQLCa.SQLCode = 0)
If SQLCa.SQLCode = -1 Then
	SQLCa.Of_Msgdberror( "Localiza$$HEX2$$e700e300$$ENDHEX$$o lei fiscal SAP." )
End If

Return Localizado
end function

on uo_ncm_situacao_tipo.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ncm_situacao_tipo.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

