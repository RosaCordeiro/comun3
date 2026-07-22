HA$PBExportHeader$uo_imposto_cst.sru
forward
global type uo_imposto_cst from nonvisualobject
end type
end forward

global type uo_imposto_cst from nonvisualobject
end type
global uo_imposto_cst uo_imposto_cst

type variables
Long id_imposto_cst
String cd_imposto
String cd_cst_imposto
String de_cst_imposto
String id_normal
String id_monofasico
String id_reducao_aliq
String id_diferimento
String id_transfer_credito
String id_cred_pres_zfm
String id_ajuste_competencia

Boolean Localizado = False
end variables

forward prototypes
public function boolean of_localiza_codigo (long pl_id_imposto_cst)
public subroutine of_inicializa ()
end prototypes

public function boolean of_localiza_codigo (long pl_id_imposto_cst);Try
	Select id_imposto_cst, 
			 cd_imposto,
			 cd_cst_imposto,
			 de_cst_imposto,
			 id_normal,
			 id_monofasico,
			 id_reducao_aliq,
			 id_diferimento,
			 id_transfer_credito,
			 id_cred_pres_zfm,
			 id_ajuste_competencia
	Into 	:This.id_imposto_cst, 
			:This.cd_imposto,
			:This.cd_cst_imposto,
			:This.de_cst_imposto,
			:This.id_normal,
			:This.id_monofasico,
			:This.id_reducao_aliq,
			:This.id_diferimento,
			:This.id_transfer_credito,
			:This.id_cred_pres_zfm,
			:This.id_ajuste_competencia
	From imposto_cst
	Where id_imposto_cst = :pl_id_imposto_cst
	Using SQLCa;
	
	This.Localizado = (SQLCa.SQLCode = 0)
	
	If Not This.Localizado Then This.of_Inicializa()

Catch (RuntimeError lvo_Erro)
	gvo_Aplicacao.Of_Grava_Log(lvo_Erro.GetMessage())
	This.Localizado = False
	Return This.Localizado
	
Finally
	//
End Try

Return This.Localizado
end function

public subroutine of_inicializa ();SetNull(id_imposto_cst)
SetNull(cd_imposto)
SetNull(cd_cst_imposto)
SetNull(de_cst_imposto)
SetNull(id_normal)
SetNull(id_monofasico)
SetNull(id_reducao_aliq)
SetNull(id_diferimento)
SetNull(id_transfer_credito)
SetNull(id_cred_pres_zfm)
SetNull(id_ajuste_competencia)

Localizado = False
end subroutine

on uo_imposto_cst.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_imposto_cst.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;This.Of_Inicializa()
end event

