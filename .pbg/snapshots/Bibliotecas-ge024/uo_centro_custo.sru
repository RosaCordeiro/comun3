HA$PBExportHeader$uo_centro_custo.sru
forward
global type uo_centro_custo from nonvisualobject
end type
end forward

global type uo_centro_custo from nonvisualobject
end type
global uo_centro_custo uo_centro_custo

type variables
Boolean Localizada

Boolean ivb_centro_custo

Long cd_centro_custo

String de_centro_custo,&
          ivs_parametro_selecao, &
		 id_situacao

          
end variables

forward prototypes
public subroutine of_inicializa ()
public subroutine of_localiza_codigo (long pl_centro_custo)
public subroutine of_localiza_centro_custo (string ps_parametro)
public subroutine of_localiza_generica (string ps_parametro)
end prototypes

public subroutine of_inicializa ();SetNull(Cd_Centro_Custo)
De_Centro_Custo 	= ""
ivb_Centro_Custo 	= False
id_situacao			= ""

end subroutine

public subroutine of_localiza_codigo (long pl_centro_custo);
If ivb_Centro_Custo Then
	
	Select c.cd_centro_custo,
		   c.de_centro_custo,
			c.id_situacao
	Into :cd_centro_custo,
		 :de_centro_custo,
		 :id_situacao
	From centro_custo c, parametro p
	Where c.cd_centro_custo = :pl_centro_custo
	   and (c.cd_filial		= p.cd_filial_matriz Or c.id_tipo_centro_custo = 'E');
	  
Else
	
	Select c.cd_centro_custo,
		   c.de_centro_custo,
			c.id_situacao
	Into :cd_centro_custo,
		 :de_centro_custo,
		 :id_situacao
	From centro_custo c
	Where c.cd_centro_custo = :pl_centro_custo;
	
End If

Choose Case SqlCa.SqlCode 
	Case -1
		Sqlca.Of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o centro custo.")
		Localizada = False
	Case 100
		Localizada = False
	Case Else
		Localizada = True
End Choose
end subroutine

public subroutine of_localiza_centro_custo (string ps_parametro);Integer lvi_Tamanho

lvi_Tamanho = LenA(ps_Parametro)

// Verifica se foi recebido algum par$$HEX1$$e200$$ENDHEX$$metro
If lvi_Tamanho > 0 Then
	
	// Verifica o tipo do par$$HEX1$$e200$$ENDHEX$$metro recebido
	If IsNumber(ps_Parametro) Then

		// Localiza$$HEX2$$e700e300$$ENDHEX$$o direta pelo c$$HEX1$$f300$$ENDHEX$$digo da filial
		of_Localiza_Codigo(Long(ps_Parametro))

		If Not Localizada Then

			// Se n$$HEX1$$e300$$ENDHEX$$o localizar pelos m$$HEX1$$e900$$ENDHEX$$todos anteriores
			// Abre a janela de localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica
			of_Localiza_Generica("")
	
		End If
	
	Else
	
		// Localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica conforme o nome do cliente
		of_Localiza_Generica(ps_Parametro)

	End If
	
Else
	
	// Localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica sem par$$HEX1$$e200$$ENDHEX$$metros
	of_Localiza_Generica("")
End If
end subroutine

public subroutine of_localiza_generica (string ps_parametro);STRING lvs_Centro_Custo

This.ivs_Parametro_Selecao = ps_Parametro

OpenWithParm(w_ge024_Selecao_Centro_Custo, This)

lvs_Centro_Custo = Message.StringParm

If Not IsNull(lvs_Centro_Custo) Then
	of_Localiza_Codigo(Long(lvs_Centro_Custo))
Else
	Localizada = False
End If
end subroutine

on uo_centro_custo.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_centro_custo.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;SetNull(This.Cd_Centro_Custo)

This.of_Inicializa()
end event

