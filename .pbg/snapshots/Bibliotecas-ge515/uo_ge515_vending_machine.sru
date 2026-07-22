HA$PBExportHeader$uo_ge515_vending_machine.sru
forward
global type uo_ge515_vending_machine from nonvisualobject
end type
end forward

global type uo_ge515_vending_machine from nonvisualobject
end type
global uo_ge515_vending_machine uo_ge515_vending_machine

type variables
Boolean Localizado

String is_Parametro

String cd_maquina_vmpay
String cd_local_vmpay
String nr_patrimonio
String id_situacao
String nr_serie
String nr_telefone
String de_endereco
String de_complemento
String de_bairro
String nr_cep
String cd_cliente_vmpay
String nm_cidade
String cd_unidade_federacao
 
Datetime dh_atualizacao
 
Long nr_vending_machine
Long cd_filial
Long cd_cidade
Long nr_endereco

//Busca de maquinas VM locais
Long il_Filial_Retrieve
end variables

forward prototypes
public subroutine of_localiza_generica (string ps_parametro)
public subroutine of_inicializa ()
public subroutine of_localiza_codigo (long al_nr_vending_machine)
public subroutine of_localiza_vending_machine (string ps_parametro)
end prototypes

public subroutine of_localiza_generica (string ps_parametro);String ls_Local_VM

This.is_Parametro = ps_Parametro

OpenWithParm(w_ge515_selecao_vending_machine, This)

ls_Local_VM = Message.StringParm

If Not IsNull(ls_Local_VM) Then
	of_Localiza_Codigo(Long(ls_Local_VM))
Else
	Localizado = False
End If
end subroutine

public subroutine of_inicializa ();Localizado = False

SetNull(cd_maquina_vmpay)

SetNull( cd_local_vmpay )
SetNull( nr_patrimonio )
SetNull( id_situacao )
SetNull( nr_serie )
SetNull( nr_telefone )
SetNull( de_endereco )
SetNull( de_complemento )
SetNull( de_bairro )
SetNull( nr_cep )
SetNull( cd_cliente_vmpay )
SetNull( dh_atualizacao )
SetNull( nr_vending_machine )
SetNull( cd_filial )
SetNull( cd_cidade )
SetNull( nr_endereco )
SetNull( nm_cidade )
SetNull( cd_unidade_federacao )


SetNull(il_Filial_Retrieve)


end subroutine

public subroutine of_localiza_codigo (long al_nr_vending_machine);SELECT  v.nr_vending_machine, 
			v.cd_maquina_vmpay, 
			v.cd_local_vmpay, 
			v.cd_filial, 
			v.nr_patrimonio, 
			v.id_situacao, 
			v.nr_serie, 
			v.cd_cidade, 
			v.nr_telefone, 
			v.de_endereco,
			v.nr_endereco, 
			v.de_complemento, 
			v.de_bairro, 
			v.nr_cep, 
			v.dh_atualizacao, 
			v.cd_cliente_vmpay,
			c.nm_cidade,
			c.cd_unidade_federacao
Into 		:nr_vending_machine, 
			:cd_maquina_vmpay, 
			:cd_local_vmpay, 
			:cd_filial, 
			:nr_patrimonio, 
			:id_situacao, 
			:nr_serie, 
			:cd_cidade, 
			:nr_telefone, 
			:de_endereco,
			:nr_endereco, 
			:de_complemento, 
			:de_bairro, 
			:nr_cep, 
			:dh_atualizacao, 
			:cd_cliente_vmpay,
			:nm_cidade,
			:cd_unidade_federacao
FROM vending_machine v
	INNER JOIN cidade c
			ON c.cd_cidade = v.cd_cidade
 WHERE nr_vending_machine = :al_Nr_Vending_Machine
Using SqlCa;


Choose Case SqlCa.SqlCode
	Case 0
		Localizado = True
	Case 100
		Localizado = False
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o da vending machine. " + SqlCa.SqlErrText, StopSign!)
		Localizado = False
End Choose
end subroutine

public subroutine of_localiza_vending_machine (string ps_parametro);Integer lvi_Tamanho

lvi_Tamanho = LenA(ps_Parametro)

// Verifica se foi recebido algum par$$HEX1$$e200$$ENDHEX$$metro
If lvi_Tamanho > 0 Then
	
	// Verifica o tipo do par$$HEX1$$e200$$ENDHEX$$metro recebido
	If IsNumber(ps_Parametro) Then
		
		// Localiza$$HEX2$$e700e300$$ENDHEX$$o direta pelo c$$HEX1$$f300$$ENDHEX$$digo
		of_Localiza_Codigo(Long(ps_Parametro))
	
		If Not Localizado Then
			// Se n$$HEX1$$e300$$ENDHEX$$o localizar pelos m$$HEX1$$e900$$ENDHEX$$todos anteriores abre a janela de localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica
			of_Localiza_Generica("")			
		End If

	Else
		// Localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica conforme o nome
		of_Localiza_Generica(ps_Parametro)
	End If
	
Else	
	// Localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica sem par$$HEX1$$e200$$ENDHEX$$metros
	of_Localiza_Generica("")
End If
end subroutine

on uo_ge515_vending_machine.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge515_vending_machine.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;This.of_Inicializa()
end event

