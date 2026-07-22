HA$PBExportHeader$uo_processo_alteracao_preco.sru
forward
global type uo_processo_alteracao_preco from nonvisualobject
end type
end forward

global type uo_processo_alteracao_preco from nonvisualobject
end type
global uo_processo_alteracao_preco uo_processo_alteracao_preco

type variables
Boolean Localizado

Long nr_processo

String de_processo,&
          ivs_parametro_selecao,&
			 id_situacao
end variables

forward prototypes
public subroutine of_localiza_generica (string ps_parametro)
public subroutine of_inicializa ()
public subroutine of_localiza_codigo (long pl_processo)
public subroutine of_localiza_processo (string ps_parametro)
end prototypes

public subroutine of_localiza_generica (string ps_parametro);STRING lvs_processo

This.ivs_Parametro_Selecao = ps_Parametro

OpenWithParm(w_ge108_Selecao_Processo_Alteracao_Preco, This)

lvs_processo = Message.StringParm

If Not IsNull(lvs_processo) Then
	of_Localiza_Codigo(Long(lvs_processo))
Else
	Localizado = False
End If
end subroutine

public subroutine of_inicializa ();SetNull(nr_processo)
de_processo = ""

end subroutine

public subroutine of_localiza_codigo (long pl_processo);String lvs_Regional

Select	p.nr_processo,
       	p.de_processo,
		p.id_situacao 
Into	:nr_processo,
     	:de_processo,
		:id_situacao	  
From processo_alteracao_preco p
Where p.nr_processo = :pl_processo;

Choose Case SqlCa.SqlCode 
	Case -1
		Sqlca.Of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do processo.")
		Localizado = False
	Case 100
		Localizado = False
	Case 0
		Localizado = True		
End Choose
end subroutine

public subroutine of_localiza_processo (string ps_parametro);Integer lvi_Tamanho

lvi_Tamanho = LenA(ps_Parametro)

// Verifica se foi recebido algum par$$HEX1$$e200$$ENDHEX$$metro
If lvi_Tamanho > 0 Then
	
	// Verifica o tipo do par$$HEX1$$e200$$ENDHEX$$metro recebido
	If IsNumber(ps_Parametro) Then

		// Localiza$$HEX2$$e700e300$$ENDHEX$$o direta pelo c$$HEX1$$f300$$ENDHEX$$digo do processo
		of_Localiza_Codigo(Long(ps_Parametro))

		If Not Localizado Then

			// Se n$$HEX1$$e300$$ENDHEX$$o localizar pelos m$$HEX1$$e900$$ENDHEX$$todos anteriores
			// Abre a janela de localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica
			of_Localiza_Generica("")
	
		End If
	
	Else
	
		// Localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica conforme o nome do processo
		of_Localiza_Generica(ps_Parametro)

	End If
	
Else
	
	// Localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica sem par$$HEX1$$e200$$ENDHEX$$metros
	of_Localiza_Generica("")
End If
end subroutine

on uo_processo_alteracao_preco.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_processo_alteracao_preco.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;SetNull(This.nr_processo)

This.of_Inicializa()
end event

