HA$PBExportHeader$uo_grupo_produto_mkt.sru
forward
global type uo_grupo_produto_mkt from nonvisualobject
end type
end forward

global type uo_grupo_produto_mkt from nonvisualobject
end type
global uo_grupo_produto_mkt uo_grupo_produto_mkt

type variables
Boolean Localizado

Long cd_grupo

String de_grupo,&
          ivs_parametro_selecao
end variables

forward prototypes
public subroutine of_localiza_generica (string ps_parametro)
public subroutine of_inicializa ()
public subroutine of_localiza_codigo (long pl_grupo)
public subroutine of_localiza_grupo (string ps_parametro)
end prototypes

public subroutine of_localiza_generica (string ps_parametro);STRING lvs_Grupo

This.ivs_Parametro_Selecao = ps_Parametro

OpenWithParm(w_ge093_Selecao_Grupo_Produto_MKT, This)

lvs_Grupo = Message.StringParm

If Not IsNull(lvs_Grupo) Then
	of_Localiza_Codigo(Long(lvs_Grupo))
Else
	Localizado = False
End If
end subroutine

public subroutine of_inicializa ();SetNull(Cd_Grupo)
de_Grupo = ""

end subroutine

public subroutine of_localiza_codigo (long pl_grupo);String lvs_Regional

Select p.cd_grupo,
       p.de_grupo
Into :cd_grupo,
     :de_grupo
From promocao_mkt_grupo p
Where p.cd_grupo = :pl_Grupo;

Choose Case SqlCa.SqlCode 
	Case -1
		Sqlca.Of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Grupo.")
		Localizado = False
	Case 100
		Localizado = False
	Case 0
		Localizado = True		
End Choose
end subroutine

public subroutine of_localiza_grupo (string ps_parametro);Integer lvi_Tamanho

lvi_Tamanho = LenA(ps_Parametro)

// Verifica se foi recebido algum par$$HEX1$$e200$$ENDHEX$$metro
If lvi_Tamanho > 0 Then
	
	// Verifica o tipo do par$$HEX1$$e200$$ENDHEX$$metro recebido
	If IsNumber(ps_Parametro) Then

		// Localiza$$HEX2$$e700e300$$ENDHEX$$o direta pelo c$$HEX1$$f300$$ENDHEX$$digo do grupo
		of_Localiza_Codigo(Long(ps_Parametro))

		If Not Localizado Then

			// Se n$$HEX1$$e300$$ENDHEX$$o localizar pelos m$$HEX1$$e900$$ENDHEX$$todos anteriores
			// Abre a janela de localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica
			of_Localiza_Generica("")
	
		End If
	
	Else
	
		// Localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica conforme o nome do grupo
		of_Localiza_Generica(ps_Parametro)

	End If
	
Else
	
	// Localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica sem par$$HEX1$$e200$$ENDHEX$$metros
	of_Localiza_Generica("")
End If
end subroutine

on uo_grupo_produto_mkt.create
TriggerEvent( this, "constructor" )
end on

on uo_grupo_produto_mkt.destroy
TriggerEvent( this, "destructor" )
end on

event constructor;SetNull(This.Cd_Grupo)

This.of_Inicializa()
end event

