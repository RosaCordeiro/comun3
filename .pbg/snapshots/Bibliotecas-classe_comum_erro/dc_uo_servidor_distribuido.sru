HA$PBExportHeader$dc_uo_servidor_distribuido.sru
forward
global type dc_uo_servidor_distribuido from nonvisualobject
end type
end forward

global type dc_uo_servidor_distribuido from nonvisualobject
end type
global dc_uo_servidor_distribuido dc_uo_servidor_distribuido

type variables


end variables

forward prototypes
public function boolean of_retrieve (ref blob ab_blob, ref string as_mensagem)
end prototypes

public function boolean of_retrieve (ref blob ab_blob, ref string as_mensagem);Long lvl_Total, &
     lvl_Erro

dc_uo_ds_base lvds_1
lvds_1 = Create dc_uo_ds_base

lvl_Erro = lvds_1.SetFullState(ab_Blob)

lvds_1.of_SetTransObject(SQLCA)

If lvl_Erro = -1 Then
	as_Mensagem = "Erro no SetFullState do objeto servidor_distribuido."
	Return False
End If

lvl_Total = lvds_1.Retrieve()

If lvl_Total > 0 Then
	
	lvl_Erro = lvds_1.GetFullState(ab_Blob)
	
	If lvl_Erro = -1 Then
		as_Mensagem = "Erro no GetFullState do objeto servidor distribuido."
		Return False
	End If	
	
ElseIf lvl_Total < 0 Then
	as_Mensagem = "Ocorreram erros na recupera$$HEX2$$e700e300$$ENDHEX$$o das informa$$HEX2$$e700f500$$ENDHEX$$es."
	
	Return False
End If

Destroy(lvds_1)

Return True
end function

on dc_uo_servidor_distribuido.create
TriggerEvent( this, "constructor" )
end on

on dc_uo_servidor_distribuido.destroy
TriggerEvent( this, "destructor" )
end on

