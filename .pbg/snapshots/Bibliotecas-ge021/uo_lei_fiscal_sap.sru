HA$PBExportHeader$uo_lei_fiscal_sap.sru
forward
global type uo_lei_fiscal_sap from nonvisualobject
end type
end forward

global type uo_lei_fiscal_sap from nonvisualobject
end type
global uo_lei_fiscal_sap uo_lei_fiscal_sap

type variables
String	Cd_Lei_Fiscal_SAP
String	De_Lei_Fiscal_SAP
String	Id_Entrada_Saida
String	Cd_Tributacao_ICMS
String Cd_CST
String Cd_UF

Boolean Localizado = False
end variables

forward prototypes
public subroutine of_inicializa ()
public function boolean of_localiza (string ps_parametro)
public function boolean of_localiza_generica (string ps_parametro)
public function boolean of_localiza (string ps_parametro, string ps_uf)
public function boolean of_localiza_codigo (string ps_lei_fiscal)
end prototypes

public subroutine of_inicializa ();SetNull(Cd_Lei_Fiscal_SAP)
SetNull(De_Lei_Fiscal_SAP)
SetNull(Id_Entrada_Saida)
SetNull(Cd_Tributacao_ICMS)
SetNull(Cd_CST)
SetNull(Cd_UF)

Localizado = False
end subroutine

public function boolean of_localiza (string ps_parametro);Return This.Of_Localiza(ps_parametro,"")
end function

public function boolean of_localiza_generica (string ps_parametro);String lvs_Retorno

OpenWithParm(w_ge021_selecao_lei_fiscal, ps_parametro) 

lvs_Retorno = Message.StringParm

If Not IsNull(lvs_Retorno) and (Len(Trim(lvs_Retorno))<=4) and lvs_Retorno<>"" Then
	This.Of_Localiza_Codigo( lvs_Retorno )
Else
	This.Of_Inicializa( )
End If

Return Localizado
end function

public function boolean of_localiza (string ps_parametro, string ps_uf);If Len(Trim(ps_parametro)) <= 4 and Mid(ps_parametro, 1, 1 )='I' Then
	This.Of_localiza_codigo( ps_parametro )
End If

If Not Localizado Then
	This.Of_localiza_Generica(ps_parametro+";"+ps_uf)
End If

Return Localizado
end function

public function boolean of_localiza_codigo (string ps_lei_fiscal);This.Of_Inicializa()

Select lf.cd_lei_fiscal_sap, lf.de_lei_fiscal_sap, lf.id_entrada_saida, lf.cd_tributacao_icms, ti.cd_cst_tributacao, lf.cd_uf
Into :Cd_Lei_Fiscal_SAP, :De_Lei_Fiscal_SAP, :Id_Entrada_Saida, :Cd_Tributacao_ICMS, :Cd_CST, :Cd_UF
from lei_fiscal_sap lf
left outer join tributacao_icms ti
	on ti.cd_tributacao_icms = lf.cd_tributacao_icms
Where cd_lei_fiscal_sap = :ps_lei_fiscal
Using SQLCa;

Localizado = (SQLCa.SQLCode = 0)
If SQLCa.SQLCode = -1 Then
	SQLCa.Of_Msgdberror( "Localiza$$HEX2$$e700e300$$ENDHEX$$o lei fiscal SAP." )
End If

Return Localizado
end function

on uo_lei_fiscal_sap.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_lei_fiscal_sap.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

