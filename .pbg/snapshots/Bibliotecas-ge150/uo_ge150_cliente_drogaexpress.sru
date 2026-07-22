HA$PBExportHeader$uo_ge150_cliente_drogaexpress.sru
forward
global type uo_ge150_cliente_drogaexpress from nonvisualobject
end type
end forward

global type uo_ge150_cliente_drogaexpress from nonvisualobject
end type
global uo_ge150_cliente_drogaexpress uo_ge150_cliente_drogaexpress

type variables
Boolean Localizado

String	cd_cliente_drogaexpress, &
		nm_cliente, &
		de_endereco, &
		nr_endereco, &
		de_complemento, &
		de_referencia, &
		de_bairro, &
		nr_cep, &
		nr_cgc_cpf, &
		nr_inscricao_estadual, &
		cd_conveniado, &
		cd_cliente,&
		id_fisica_juridica, &
		nr_telefone_principal, &
		nr_telefone_adicional, &
		vl_Frete

String ivs_parametro
       
Long cd_convenio, &
         cd_filial, &
		Nr_Bairro
end variables

forward prototypes
public subroutine of_localiza_codigo (string ps_cliente)
public subroutine of_localiza_cliente (string ps_parametro)
public subroutine of_localiza_generica (string ps_parametro)
public subroutine of_inicializa ()
public subroutine of_localiza_cgc_cpf (string ps_cgc_cpf)
public function boolean of_proximo_codigo (ref string ps_codigo)
public subroutine of_localiza_telefone (string ps_parametro)
end prototypes

public subroutine of_localiza_codigo (string ps_cliente);Select	cd_cliente_drogaexpress,
		nm_cliente,
		de_endereco,
		nr_endereco,
		de_complemento,
		de_referencia,
		de_bairro,
		nr_bairro,
		nr_cep,
		nr_cgc_cpf,
		nr_inscricao_estadual,
		cd_conveniado,
		cd_convenio,
		cd_cliente,
		id_fisica_juridica,
		nr_telefone_principal,
		nr_telefone_adicional
Into	:cd_cliente_drogaexpress,
		:nm_cliente,
		:de_endereco,
		:nr_endereco,
		:de_complemento,
		:de_referencia,
		:de_bairro,
		:nr_bairro,
		:nr_cep,
		:nr_cgc_cpf,
		:nr_inscricao_estadual,
		:cd_conveniado,
		:cd_convenio,
		:cd_cliente,
		:id_fisica_juridica,
		:nr_telefone_principal,
		:nr_telefone_adicional
From cliente_drogaexpress
Where cd_cliente_drogaexpress = :ps_cliente
Using SqlCa;
  
If SqlCa.SqlCode = 100 Then
	Localizado = False
Else
	Localizado = True		
End If
end subroutine

public subroutine of_localiza_cliente (string ps_parametro);Integer lvi_Tamanho

lvi_Tamanho = LenA(ps_Parametro)

// Verifica se foi recebido algum par$$HEX1$$e200$$ENDHEX$$metro
If lvi_Tamanho > 0 Then
	
	// Verifica o tipo do par$$HEX1$$e200$$ENDHEX$$metro recebido
	If IsNumber(ps_Parametro) Then
		
		If lvi_Tamanho = 11 or lvi_Tamanho = 14 Then
			// Localiza$$HEX2$$e700e300$$ENDHEX$$o direta pelo CPF ou CGC
			of_Localiza_cgc_cpf(ps_Parametro)
	
			If Not Localizado Then
	
				// Se n$$HEX1$$e300$$ENDHEX$$o localizar pelos m$$HEX1$$e900$$ENDHEX$$todos anteriores
				// Abre a janela de localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica
				of_Localiza_Generica("")
		
			End If
		Else
			// Localiza$$HEX2$$e700e300$$ENDHEX$$o direta pelo c$$HEX1$$f300$$ENDHEX$$digo do cliente
			of_Localiza_Codigo(ps_Parametro)
	
			If Not Localizado Then
				// Localiza$$HEX2$$e700e300$$ENDHEX$$o direta por um dos telefones do Cliente
				of_Localiza_Telefone(ps_Parametro)
				
				If Not Localizado Then				
	
					// Se n$$HEX1$$e300$$ENDHEX$$o localizar pelos m$$HEX1$$e900$$ENDHEX$$todos anteriores
					// Abre a janela de localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica
					of_Localiza_Generica("")
				End If
			End If
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

public subroutine of_localiza_generica (string ps_parametro);String lvs_Cliente

This.ivs_parametro = ps_Parametro

OpenWithParm(w_ge150_Selecao_Cliente_Droga, This)

lvs_Cliente = Message.StringParm

If Not IsNull(lvs_Cliente) Then
	of_Localiza_Codigo(lvs_Cliente)
Else
	Localizado = False
End If
end subroutine

public subroutine of_inicializa ();String lvs_Nulo

SetNull(lvs_Nulo)

cd_cliente_drogaexpress	= lvs_Nulo
nm_cliente					= ""

Localizado = False
end subroutine

public subroutine of_localiza_cgc_cpf (string ps_cgc_cpf);Select cd_cliente_drogaexpress,
       nm_cliente,
		 de_endereco,
		 nr_endereco,
		 de_complemento,
		 de_referencia,
		 de_bairro,
		 nr_cep,
		 nr_cgc_cpf,
		 nr_inscricao_estadual,
		 cd_conveniado,
		 cd_convenio,
		 cd_cliente,
		 id_fisica_juridica
Into :cd_cliente_drogaexpress,
     :nm_cliente,
	 :de_endereco,
	 :nr_endereco,
	 :de_complemento,
	 :de_referencia,
	 :de_bairro,
	 :nr_cep,
	 :nr_cgc_cpf,
	 :nr_inscricao_estadual,
	 :cd_conveniado,
	 :cd_convenio,
	 :cd_cliente,
	 :id_fisica_juridica
From cliente_drogaexpress
Where nr_cgc_cpf = :ps_cgc_cpf;
  
If SqlCa.SqlCode = 100 Then
	Localizado = False
Else
	Localizado = True		
End If
end subroutine

public function boolean of_proximo_codigo (ref string ps_codigo);String ls_Parametro 

Long ll_Codigo

Select vl_parametro
  Into :ls_Parametro
  From parametro_loja
 Where cd_parametro = 'NR_CLIENTE_DISQUE_ENTREGA'
 Using SqlCa;
 
 
Choose Case SqlCa.SqlCode
	Case -1
		SqlCa.of_MsgDbError()
		Return False
		
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Par$$HEX1$$e200$$ENDHEX$$metro 'NR_CLIENTE_DISQUE_ENTREGA' n$$HEX1$$e300$$ENDHEX$$o localizado na tabela 'PARAMETRO_LOJA'", StopSign!)
		Return False
		
End Choose

ll_Codigo 	 = Long(ls_Parametro) +1
ls_Parametro = String(ll_Codigo)

Update parametro_loja
   Set vl_parametro = :ls_Parametro
 Where cd_parametro = 'NR_CLIENTE_DISQUE_ENTREGA'
 Using SqlCa;
 
If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError()
	SqlCa.of_RollBack()
	Return False
End If

SqlCa.of_Commit()

ps_Codigo = String(gvo_parametro.cd_filial, "0000") + String(ll_Codigo, "000000")

Return True

end function

public subroutine of_localiza_telefone (string ps_parametro);Select cd_cliente_drogaexpress,
       nm_cliente,
		 de_endereco,
 		 nr_endereco,
		 de_complemento,
		 de_referencia,
		 de_bairro,
		 nr_cep,
		 nr_cgc_cpf,
		 nr_inscricao_estadual,
		 cd_conveniado,
		 cd_convenio,
		 cd_cliente,
		 id_fisica_juridica,
		 nr_telefone_principal,
		 nr_telefone_adicional
Into :cd_cliente_drogaexpress,
     :nm_cliente,
	  :de_endereco,
	  :nr_endereco,
	  :de_complemento,
	  :de_referencia,
	  :de_bairro,
	  :nr_cep,
	  :nr_cgc_cpf,
	  :nr_inscricao_estadual,
	  :cd_conveniado,
	  :cd_convenio,
	  :cd_cliente,
	  :id_fisica_juridica,
	  :nr_telefone_principal,
	  :nr_telefone_adicional
From cliente_drogaexpress
Where cd_cliente_drogaexpress = :ps_parametro
   Or nr_telefone_principal 	= :ps_parametro
   Or nr_telefone_adicional 	= :ps_parametro
 Using SqlCa;
  
If SqlCa.SqlCode = 100 Then
	Localizado = False
Else
	If SqlCa.SqlCode = 0 And SqlCa.SqlNRows < 2 Then
		Localizado = True		
	Else
		
		If SqlCa.SqlErrText = "Select returned more than one row" Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Telefone encontrado em mais de um cadastro, tente a busca por nome ou endere$$HEX1$$e700$$ENDHEX$$o.")
		End If
		
		Localizado = False
	End If
End If
end subroutine

on uo_ge150_cliente_drogaexpress.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge150_cliente_drogaexpress.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;This.of_inicializa()
end event

