HA$PBExportHeader$uo_log_alteracao.sru
forward
global type uo_log_alteracao from nonvisualobject
end type
end forward

global type uo_log_alteracao from nonvisualobject
end type
global uo_log_alteracao uo_log_alteracao

type variables
String Tabelas	//listagem de tabelas separadas por v$$HEX1$$ed00$$ENDHEX$$rgulas
String Campos	//listagem de campos separadas por v$$HEX1$$ed00$$ENDHEX$$rgulas
String Campos_ignorar //listagem de campos a ignorar separadas por v$$HEX1$$ed00$$ENDHEX$$rgulas
String Chave

Datetime Inicio
Datetime Fim
end variables

forward prototypes
public subroutine of_exibe_log (string ps_tabelas, string ps_campos, string ps_chave, string ps_campos_ignorar)
public subroutine of_exibe_log (string ps_tabelas, string ps_campos, string ps_chave)
end prototypes

public subroutine of_exibe_log (string ps_tabelas, string ps_campos, string ps_chave, string ps_campos_ignorar);Tabelas	= ps_tabelas
Campos	= ps_campos
Campos_ignorar	= ps_campos_ignorar
Chave		= ps_chave

If IsNull(Chave) or Trim(Chave)="" Then
	Inicio	= Datetime(RelativeDate(Today(), -31))
	Fim	= Datetime(Today(), Time("23:59:59"))
Else
	Inicio	= Datetime(RelativeDate(Today(), -730))
	Fim	= Datetime(Today(), Time("23:59:59"))
End If

OpenSheetWithParm(w_ge321_consulta_log_alteracao, This, dc_w_mdi, 2, Original!)
end subroutine

public subroutine of_exibe_log (string ps_tabelas, string ps_campos, string ps_chave);of_exibe_log(ps_tabelas,ps_campos,ps_chave,'')
end subroutine

on uo_log_alteracao.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_log_alteracao.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

