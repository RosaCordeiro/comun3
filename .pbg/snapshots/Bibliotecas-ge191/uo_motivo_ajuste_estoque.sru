HA$PBExportHeader$uo_motivo_ajuste_estoque.sru
forward
global type uo_motivo_ajuste_estoque from nonvisualobject
end type
end forward

global type uo_motivo_ajuste_estoque from nonvisualobject
end type
global uo_motivo_ajuste_estoque uo_motivo_ajuste_estoque

type variables
Long Codigo
String Descricao

Boolean Liberado_EC
Boolean Liberado_Loja
Boolean Localizado
end variables

forward prototypes
public subroutine of_inicializa ()
public function boolean of_localiza (string ps_parametro)
public function boolean of_localiza_codigo (long pl_codigo)
public function boolean of_localiza_generica (string ps_parametro)
end prototypes

public subroutine of_inicializa ();SetNull(Codigo)
SetNull(Descricao)

Liberado_EC		= False
Liberado_Loja	= False
Localizado 		= False
end subroutine

public function boolean of_localiza (string ps_parametro);This.Of_Inicializa( )

If IsNumber(ps_parametro) Then
	This.Of_Localiza_Codigo(Long(ps_parametro))
End If

If Not Localizado Then
	This.Of_Localiza_Generica(ps_parametro)
End If

Return Localizado
end function

public function boolean of_localiza_codigo (long pl_codigo);String lvs_Permite_Loja
String lvs_Permite_EC

  SELECT cd_motivo_ajuste,   
			de_motivo_ajuste,   
			id_permite_loja,   
			id_permite_ec
	Into 	:Codigo,
		 	:Descricao,
			:lvs_Permite_Loja,
			:lvs_Permite_EC
    FROM motivo_ajuste   
Where cd_motivo_ajuste = :pl_codigo
Using SQLCa;

Localizado = (SQLCa.SQLCode = 0)

If SQLCa.SQLCode = -1 Then
	SQLCa.Of_msgdberror('Localiza$$HEX2$$e700e300$$ENDHEX$$o motivo ajuste.')
End If

If Localizado Then
	Liberado_EC		= (lvs_Permite_EC = 'S')
	Liberado_Loja 	= (lvs_Permite_Loja = 'S') 
Else
	This.Of_inicializa( )
End If

Return Localizado
end function

public function boolean of_localiza_generica (string ps_parametro);String lvs_Motivo

OpenWithParm(w_ge191_selecao_motivo_ajuste, ps_Parametro)

lvs_Motivo = Message.StringParm

If Not IsNull(lvs_Motivo) Then
	This.Of_Localiza_Codigo(LONG(lvs_Motivo))
Else
	This.Of_Inicializa()
End If

Return Localizado
end function

on uo_motivo_ajuste_estoque.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_motivo_ajuste_estoque.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;This.of_inicializa()
end event

