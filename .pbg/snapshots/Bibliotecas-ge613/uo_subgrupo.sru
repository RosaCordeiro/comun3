HA$PBExportHeader$uo_subgrupo.sru
forward
global type uo_subgrupo from nonvisualobject
end type
end forward

global type uo_subgrupo from nonvisualobject
end type
global uo_subgrupo uo_subgrupo

type variables
Boolean	Localizado

String	cd_grupo, &
			cd_subgrupo, &
			de_subgrupo, &
			is_grupo, &
			is_parametro
end variables

forward prototypes
public subroutine of_inicializa ()
public subroutine of_localiza_codigo (string ps_cd_grupo, string ps_cd_subgrupo)
public subroutine of_localiza (string ps_cd_grupo, string ps_cd_subgrupo)
public subroutine of_localiza_generica (string ps_cd_grupo, string ps_parametro)
end prototypes

public subroutine of_inicializa ();SetNull (This.Cd_Grupo)
SetNull (This.Cd_SubGrupo)
SetNull (This.De_SubGrupo)
end subroutine

public subroutine of_localiza_codigo (string ps_cd_grupo, string ps_cd_subgrupo);SELECT cd_grupo,
		 cd_subgrupo,
		 de_subgrupo
  INTO :cd_grupo,
		 :cd_subgrupo,
		 :de_subgrupo
  FROM subgrupo
 WHERE cd_grupo    = :ps_Cd_Grupo
	AND cd_subgrupo = :ps_Cd_SubGrupo
 USING SQLCA;

Choose Case SQLCA.SQLCode
	Case -1
		MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do subgrupo: ' + SqlCa.SqlErrText, StopSign!)
		Localizado = False
	Case 100
		Localizado = False
	Case 0
		Localizado = True
End Choose

Return
end subroutine

public subroutine of_localiza (string ps_cd_grupo, string ps_cd_subgrupo);Integer	li_Tamanho

li_Tamanho = LenA (ps_cd_subgrupo)

// Verifica se foi recebido algum par$$HEX1$$e200$$ENDHEX$$metro
If li_Tamanho > 0 then
	
	// Localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica conforme o c$$HEX1$$f300$$ENDHEX$$digo do subgrupo
	of_Localiza_Generica (ps_cd_grupo, ps_cd_subgrupo)
	
else
	
	// Localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica sem par$$HEX1$$e200$$ENDHEX$$metros
	of_Localiza_Generica (ps_cd_grupo,'')
End If

Return
end subroutine

public subroutine of_localiza_generica (string ps_cd_grupo, string ps_parametro);String	ls_cd_SubGrupo

This.is_Grupo     = ps_cd_grupo
This.is_Parametro = ps_Parametro

OpenWithParm (w_ge613_selecao_subgrupo, This)

ls_cd_SubGrupo = Message.StringParm

If Not IsNull(ls_cd_SubGrupo) Then
	of_Localiza_Codigo (ps_cd_grupo, ls_cd_SubGrupo)
Else
	Localizado = False
End If

Return
end subroutine

on uo_subgrupo.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_subgrupo.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;This.of_Inicializa ()
end event

