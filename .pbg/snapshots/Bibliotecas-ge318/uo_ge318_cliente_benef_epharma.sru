HA$PBExportHeader$uo_ge318_cliente_benef_epharma.sru
forward
global type uo_ge318_cliente_benef_epharma from nonvisualobject
end type
end forward

global type uo_ge318_cliente_benef_epharma from nonvisualobject
end type
global uo_ge318_cliente_benef_epharma uo_ge318_cliente_benef_epharma

type variables
Boolean Localizado

String  nm_cliente = "", &
           nm_beneficio = "", &
	      id_situacao, &
		 cd_cliente, &
		 cd_beneficio
					
Long	nr_dia_fechamento
end variables

forward prototypes
public subroutine of_localiza_generica (string ps_parametro)
public subroutine of_inicializa ()
public subroutine of_localiza_cliente (string ps_parametro)
public subroutine of_localiza_codigo (string ps_cliente, string ps_beneficio)
end prototypes

public subroutine of_localiza_generica (string ps_parametro);String 	lvs_Cliente, &
			lvs_Beneficio, &
			lvs_Parametro

OpenWithParm(w_ge318_selecao_cliente_benef_epharma, ps_Parametro)

lvs_Parametro = Message.StringParm

lvs_Cliente 		= MidA(lvs_Parametro, 1, PosA(lvs_Parametro, "|") - 1)
lvs_Beneficio 	= MidA(lvs_Parametro, PosA(lvs_Parametro, "|") + 1, LenA(lvs_Parametro))

If Not IsNull(lvs_Cliente) Then
	This.of_Localiza_Codigo(lvs_Cliente, lvs_Beneficio)
Else
	Localizado = False
End If
end subroutine

public subroutine of_inicializa ();SetNull(Cd_Cliente)
Nm_Cliente = ""
Nm_Beneficio = ""
end subroutine

public subroutine of_localiza_cliente (string ps_parametro);Integer lvi_Tamanho

lvi_Tamanho = LenA(ps_Parametro)

// Verifica se foi recebido algum par$$HEX1$$e200$$ENDHEX$$metro
If lvi_Tamanho > 0 Then
	
	// Verifica o tipo do par$$HEX1$$e200$$ENDHEX$$metro recebido
	If IsNumber(ps_Parametro) Then

		// Localiza$$HEX2$$e700e300$$ENDHEX$$o direta pelo c$$HEX1$$f300$$ENDHEX$$digo do cliente
//		of_Localiza_Codigo(Long(ps_Parametro))

		If Not Localizado Then

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

public subroutine of_localiza_codigo (string ps_cliente, string ps_beneficio);Select ceb.cd_cliente,
		ceb.nm_cliente,
		ceb.cd_beneficio,
		ceb.nm_beneficio,
		ce.id_situacao,
		ceb.nr_dia_fechamento
Into 	:cd_cliente,
     	:nm_cliente,
	 	:cd_beneficio,
	 	:nm_beneficio,
	 	:id_situacao,
     	:nr_dia_fechamento
From convenio_epharma_beneficio ceb,
         convenio_epharma ce
Where convert(varchar, ce.cd_convenio)	= ceb.cd_convenio_epharma
     and ceb.cd_cliente 	= :ps_cliente
     and ceb.cd_beneficio = :ps_beneficio;

Choose Case SqlCa.SqlCode
	Case 0
		If IsNull(id_situacao) Then id_situacao = 'A'
		
		Localizado = True
	Case 100
		Localizado = False
		
	Case -1
		Localizado = False
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Cliente e-Pharma")
End Choose
end subroutine

on uo_ge318_cliente_benef_epharma.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge318_cliente_benef_epharma.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;This.of_Inicializa()
end event

