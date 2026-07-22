HA$PBExportHeader$uo_cliente_cheque.sru
forward
global type uo_cliente_cheque from nonvisualobject
end type
end forward

global type uo_cliente_cheque from nonvisualobject
end type
global uo_cliente_cheque uo_cliente_cheque

type variables
Boolean Localizado

String ivs_Fisica_Juridica

String nr_cpf,&
		 nr_cpf_dependente, &
		 nr_endereco, &
          nm_cliente, &
          de_endereco, &         
          de_bairro , &
          nr_cep, &
          nr_rg,&
          nr_ddd_telefone,&
          nr_telefone,&
          nm_cidade,&
          id_bloqueado,&   
          de_bloqueio

String ivs_parametro

Long cd_cidade
Long qt_mes_residencia
end variables

forward prototypes
public subroutine of_localiza_generica (string ps_parametro)
public subroutine of_localiza_cliente (string ps_parametro)
public subroutine of_localiza_cpf_cgc (string ps_cpf_cgc)
public subroutine of_consulta_pendencias ()
public function boolean of_cliente_liberado (string ps_cpf_cgc)
public subroutine of_inicializa ()
end prototypes

public subroutine of_localiza_generica (string ps_parametro);String lvs_cliente

This.ivs_Parametro = ps_Parametro

OpenWithParm(w_ge032_selecao_cliente_cheque, This)

lvs_cliente = Message.StringParm

If Not IsNull(lvs_cliente) Then
	of_Localiza_cpf_cgc(lvs_cliente)
Else
	Localizado = False
End If
end subroutine

public subroutine of_localiza_cliente (string ps_parametro);Integer lvi_Tamanho

ps_Parametro = Trim(ps_Parametro)

lvi_Tamanho  = LenA(ps_Parametro)

// Verifica se foi recebido algum par$$HEX1$$e200$$ENDHEX$$metro
If lvi_Tamanho > 0 Then
	
	// Verifica o tipo do par$$HEX1$$e200$$ENDHEX$$metro recebido
	If IsNumber(ps_Parametro) Then

		// Se o tamanho for 11, quer dizer que foi digitado cpf
		of_Localiza_cpf_cgc(ps_Parametro)
			
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

public subroutine of_localiza_cpf_cgc (string ps_cpf_cgc);Select	c.nr_cpf,
		c.nm_cliente,
		c.nr_rg,
		c.cd_cidade,
		c.de_endereco,
		c.de_bairro,
		c.nr_cep,
		c.nr_ddd_telefone,
		c.nr_telefone,
		c.id_bloqueado,
		c.de_bloqueio,
		c.nr_cpf_dependente,
		e.nm_cidade,
		c.nr_endereco,
		c.qt_mes_residencia
Into	:nr_cpf,
		:nm_cliente,
		:nr_rg,
		:cd_cidade,
		:de_endereco,
		:de_bairro,
		:nr_cep,
		:nr_ddd_telefone,
		:nr_telefone,
		:id_bloqueado,
		:de_bloqueio,
		:nr_cpf_dependente,
		:nm_cidade,
		:nr_endereco,
		:qt_mes_residencia
From	cliente_cheque c
	Inner Join cidade e
		On e.cd_cidade = c.cd_cidade
Where c.nr_cpf = :ps_cpf_cgc
Using Sqlca;

Choose Case SqlCa.SqlCode
	Case 100
		Localizado = False
	Case -1
		SqlCa.of_MsgdbError("Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do cliente cheque. CPF/CGC : '" + ps_cpf_cgc + "'.")
		Localizado = False
	Case 0
		
		This.nr_cpf = Trim(This.nr_cpf)
		
		If LenA(Trim(nr_cpf)) = 11  Then ivs_Fisica_Juridica = 'F'
		If LenA(Trim(nr_cpf)) = 14  Then ivs_Fisica_Juridica = 'J'
		
		Localizado = True
		
End Choose
end subroutine

public subroutine of_consulta_pendencias ();SetPointer(HourGlass!)

OpenWithParm(w_ge032_cheque_pendente_cliente,This.nr_cpf)
end subroutine

public function boolean of_cliente_liberado (string ps_cpf_cgc);String ls_bloqueado 

Select id_bloqueado Into :ls_bloqueado
From cliente_cheque
Where nr_cpf = :ps_cpf_cgc
Using Sqlca;

If Sqlca.Sqlcode = -1 Then
	Sqlca.of_MsgDbError('Verifica$$HEX2$$e700e300$$ENDHEX$$o de bloqueios do cliente.')
	Return False
End If	

If IsNull(ls_bloqueado) Then ls_bloqueado = 'N'

If ls_bloqueado = 'N' Then
	Return True
Else
	Return False
End If
end function

public subroutine of_inicializa ();SetNull(nr_cpf)
SetNull(nm_cliente)
SetNull(nr_rg)
SetNull(cd_cidade)
SetNull(de_endereco)
SetNull(de_bairro) 
SetNull(nr_cep)
SetNull(nr_ddd_telefone)
SetNull(nr_telefone)
SetNull(id_bloqueado)
SetNull(de_bloqueio)
SetNull(nm_cidade)
SetNull(nr_cpf_dependente)
SetNull(nr_endereco)
SetNull(qt_mes_residencia)
end subroutine

on uo_cliente_cheque.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_cliente_cheque.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

