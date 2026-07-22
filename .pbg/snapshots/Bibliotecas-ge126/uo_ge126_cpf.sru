HA$PBExportHeader$uo_ge126_cpf.sru
forward
global type uo_ge126_cpf from nonvisualobject
end type
end forward

global type uo_ge126_cpf from nonvisualobject
end type
global uo_ge126_cpf uo_ge126_cpf

type variables
Boolean Localizado

String   nr_cpf, &
           cd_cliente, &
           nm_cliente, &
		  ivs_Parametro
end variables

forward prototypes
public subroutine of_inicializa ()
public subroutine of_localiza_generica (string ps_parametro)
public subroutine of_localiza_cliente (string ps_parametro)
public subroutine of_localiza_codigo (string ps_cpf_codigo)
end prototypes

public subroutine of_inicializa ();Localizado = False
SetNull(Nr_CPF)
Nm_Cliente = ""
SetNull(Cd_Cliente)

end subroutine

public subroutine of_localiza_generica (string ps_parametro);String lvs_CPF

This.ivs_Parametro = ps_Parametro

OpenWithParm(w_ge126_Selecao_Cliente_CPF, This)

lvs_CPF = Message.StringParm

If Not IsNull(lvs_CPF) Then
	of_Localiza_Codigo(lvs_CPF)
Else
	Localizado = False
End If
end subroutine

public subroutine of_localiza_cliente (string ps_parametro);Integer lvi_Tamanho

This.Localizado = False

ps_Parametro = Trim(ps_Parametro)

lvi_Tamanho = LenA(ps_Parametro)

// Verifica se foi recebido algum par$$HEX1$$e200$$ENDHEX$$metro
If lvi_Tamanho > 0 Then		
	// Verifica o tipo do par$$HEX1$$e200$$ENDHEX$$metro recebido	
	If IsNumber(ps_Parametro) Then

		If lvi_Tamanho = 12 Then
			ps_Parametro = LeftA(ps_Parametro, 11)
		End If
		
		If Not This.Localizado Then
			// Localiza$$HEX2$$e700e300$$ENDHEX$$o direta pelo c$$HEX1$$f300$$ENDHEX$$digo do cliente
			of_Localiza_Codigo(ps_Parametro)
		End If	
		
		If Not This.Localizado Then
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

public subroutine of_localiza_codigo (string ps_cpf_codigo);Select max(a.nr_cpf) as nr_cpf,
        max(a.cd_cliente) as cd_cliente,
        max(a.nm_cliente) as nm_cliente
 Into 	:nr_cpf
      	,:cd_cliente
       	,:nm_cliente
From (
	select nr_cpf_cgc as nr_cpf
	         ,cd_cliente as cd_cliente
			 ,nm_cliente as nm_cliente
	from cliente
	where id_fisica_juridica = 'F'
	  and coalesce(nr_cpf_cgc, 'NULO') <> 'NULO' 
	union all
	select nr_cpf
	          ,null
			 ,nm_conveniado
	from conveniado
	where nr_cpf is not null
		 and rtrim(nr_cpf) <> ''
	union all
	select nr_cpf
	         ,null
			 ,nm_cliente
	from cliente_cheque
	where coalesce(nr_cpf, 'NULO') <> 'NULO'
	  and coalesce(nr_cpf_dependente, 'NULO') <> 'NULO'
	union all
	select nr_cpf
	         ,null
			 ,nm_cliente
	from cliente_cheque
	where coalesce(nr_cpf, 'NULO') <> 'NULO'
	  and coalesce(nr_cpf_dependente, 'NULO') = 'NULO'
) a	
Where (a.nr_cpf = :ps_cpf_codigo or a.cd_cliente = :ps_cpf_codigo)
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0	
		Localizado = True
	Case 100
		Localizado = False
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Cliente com o CPF: '" + ps_cpf_codigo + "'")
		Localizado = False	
End Choose
end subroutine

on uo_ge126_cpf.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge126_cpf.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

