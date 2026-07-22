HA$PBExportHeader$uo_campanha.sru
forward
global type uo_campanha from nonvisualobject
end type
end forward

global type uo_campanha from nonvisualobject
end type
global uo_campanha uo_campanha

type variables
Boolean Localizado

Long nr_campanha

String nm_campanha
        
DateTime 	dh_inicio,      &
				dh_termino, &
               	dh_inicio_estoque_minimo, &
                	dh_termino_estoque_minimo
end variables

forward prototypes
public subroutine of_localiza_codigo (long pl_campanha)
public subroutine of_localiza (string ps_parametro)
public subroutine of_inicializa ()
public subroutine of_localiza_generica (string ps_parametro)
end prototypes

public subroutine of_localiza_codigo (long pl_campanha);Select 	nr_campanha,   
			nm_campanha,   
			dh_termino,   
			dh_inicio,   
			dh_inicio_estq_minimo,   
			dh_termino_estq_minimo
Into	:nr_campanha,
		:nm_campanha,
		:dh_termino,
		:dh_inicio,
		:dh_inicio_estoque_minimo,
		:dh_termino_estoque_minimo
From campanha  
 Where nr_campanha 	= :pl_campanha
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		Localizado = True		
		
	Case 100
		Localizado = False
		
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da Campanha")
		Localizado = False
End Choose
end subroutine

public subroutine of_localiza (string ps_parametro);Integer lvi_Tamanho

lvi_Tamanho = Len(ps_Parametro)

If lvi_Tamanho > 0 Then
	If IsNumber(ps_Parametro) Then
		of_Localiza_Codigo(Long(ps_Parametro))

		If Not Localizado Then
			of_Localiza_Generica("")
		End If
	Else
		of_Localiza_Generica(ps_Parametro)
	End If
Else
	of_Localiza_Generica("")
End If
end subroutine

public subroutine of_inicializa ();SetNull(Nr_Campanha)
Nm_Campanha = ''
SetNull(Dh_Inicio)
SetNull(Dh_Termino)
SetNull(Dh_Inicio_Estoque_Minimo)
SetNull(Dh_Termino_Estoque_Minimo)

end subroutine

public subroutine of_localiza_generica (string ps_parametro);String lvs_Campanha

OpenWithParm(w_ge211_selecao_campanha, ps_Parametro)

lvs_Campanha = Message.StringParm

If IsNull(lvs_Campanha) Then
	Localizado = False
Else
	of_Localiza_Codigo(Long(lvs_Campanha))
End If
end subroutine

on uo_campanha.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_campanha.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;This.of_Inicializa()
end event

