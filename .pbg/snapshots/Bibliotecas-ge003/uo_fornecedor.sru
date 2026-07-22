HA$PBExportHeader$uo_fornecedor.sru
forward
global type uo_fornecedor from nonvisualobject
end type
end forward

global type uo_fornecedor from nonvisualobject
end type
global uo_fornecedor uo_fornecedor

type variables
Boolean Localizado
Boolean ib_Valida_Situacao = True

long cd_cidade

String cd_fornecedor = "", &
          nm_fantasia = "", &
          nm_razao_social = "", &
          cd_unidade_federacao = "", &
          id_regime_especial = "" , &
          nr_cgc , &
          nr_cpf, &
          de_endereco, &
          nr_inscricao_estadual, &
          de_bairro, &
          nm_cidade, &
          nr_cep, &
          nr_endereco, &
          nr_ddd_telefone, &
          nr_telefone,&
          id_situacao,&
          id_selecao_cadastro,&
		 id_recebe_email_xml,&
          de_endereco_email_envio_xml,&
		 cd_fornecedor_sap = "", &
		 id_distribuidora

String id_fornecedor_transportadora

decimal pc_desconto_usual

integer cd_condicao_pagamento
end variables

forward prototypes
public subroutine of_localiza_generica (string ps_parametro)
public subroutine of_localiza_fornecedor (string ps_parametro)
public subroutine of_localiza_codigo (string ps_fornecedor)
public subroutine of_inicializa ()
end prototypes

public subroutine of_localiza_generica (string ps_parametro);String lvs_Fornecedor

OpenWithParm(w_ge003_Selecao_Fornecedor, ps_Parametro)

lvs_Fornecedor = Message.StringParm

If Not IsNull(lvs_Fornecedor) Then
	of_Localiza_Codigo(lvs_Fornecedor)
Else
	Localizado = False
End If
end subroutine

public subroutine of_localiza_fornecedor (string ps_parametro);Integer lvi_Tamanho

lvi_Tamanho = LenA(ps_Parametro)

// Verifica se foi recebido algum par$$HEX1$$e200$$ENDHEX$$metro
If lvi_Tamanho > 0 Then
	
	// Verifica o tipo do par$$HEX1$$e200$$ENDHEX$$metro recebido
	//If IsNumber(ps_Parametro) Then

		// Localiza$$HEX2$$e700e300$$ENDHEX$$o direta pelo c$$HEX1$$f300$$ENDHEX$$digo do cliente
		of_Localiza_Codigo(ps_Parametro)

		If Not Localizado Then

			// Se n$$HEX1$$e300$$ENDHEX$$o localizar pelos m$$HEX1$$e900$$ENDHEX$$todos anteriores
			// Abre a janela de localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica
			of_Localiza_Generica(ps_Parametro)
	
		End If
	
	//Else
	
		// Localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica conforme o nome do cliente
		//of_Localiza_Generica(ps_Parametro)

	//End If
	
Else
	
	// Localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica sem par$$HEX1$$e200$$ENDHEX$$metros
	of_Localiza_Generica("")
End If
end subroutine

public subroutine of_localiza_codigo (string ps_fornecedor);Select f.cd_fornecedor,
       f.nm_fantasia,
       f.nm_razao_social,
	   c.cd_unidade_federacao, 
	   f.id_regime_especial,
	   f.nr_cgc, 
       f.nr_cpf, 
       f.de_endereco, 
       f.nr_inscricao_estadual, 
       f.de_bairro, 
	  f.cd_cidade,
       c.nm_cidade, 
       f.nr_cep, 
       f.nr_endereco, 
       f.nr_ddd_telefone, 
       f.nr_telefone,
	   f.pc_desconto_usual,
	   f.cd_condicao_pagamento,
	   f.id_situacao,
	   f.id_recebe_email_xml,
	   f.de_endereco_email_envio_xml,
	   f.id_fornecedor_transportadora,
	   f.cd_fornecedor_sap,
	   f.id_distribuidora
Into :Cd_Fornecedor,
     :Nm_Fantasia,
	 :Nm_Razao_Social,
	 :Cd_Unidade_Federacao,
	 :Id_Regime_Especial,
     :nr_cgc , 
     :nr_cpf, 
     :de_endereco, 
     :nr_inscricao_estadual, 
     :de_bairro, 
	 :cd_cidade,
     :nm_cidade, 
     :nr_cep, 
     :nr_endereco,
     :nr_ddd_telefone, 
     :nr_telefone, 
	 :pc_desconto_usual,
	 :cd_condicao_pagamento,
	 :id_situacao,
	 :id_recebe_email_xml,
     :de_endereco_email_envio_xml,
	 :id_fornecedor_transportadora,
	 :cd_fornecedor_sap,
	 :id_distribuidora
From fornecedor f,
     cidade c
Where f.cd_cidade     = c.cd_cidade
  and f.cd_fornecedor = :ps_Fornecedor;

Choose Case SqlCa.SqlCode
	Case 0
		If IsNull(id_situacao) Then id_situacao = 'A'
		
		// Filial
		If gvo_Parametro.cd_filial  <> gvo_Parametro.cd_filial_matriz Then
			If id_situacao = 'A' Then
				Localizado = True
			Else
				If ib_Valida_Situacao Then
					This.of_Inicializa()
					
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Este fornecedor esta INATIVO e n$$HEX1$$e300$$ENDHEX$$o pode ser selecionado.", Exclamation!)
													
					Localizado = False
				Else
					Localizado = True
				End If
			End if
		Else
			// Matriz
			// Se a sele$$HEX2$$e700e300$$ENDHEX$$o for chamada pelo cadastro de fornecedor n$$HEX1$$e300$$ENDHEX$$o mostra a mensagem o caso de INATIVO
			If id_selecao_cadastro = "N" Then
				If id_situacao = "I" Then
					If ib_Valida_Situacao Then
						If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O fornecedor '"  + Nm_Razao_Social + "' esta INATIVO. ~r~r" +&
												 "Deseja selecion$$HEX1$$e100$$ENDHEX$$-lo mesmo assim?", Question!, YesNo!, 1) = 1 Then
							Localizado = True
						Else
							Localizado = False
						End If
					Else
						Localizado = True
					End If
				Else
					Localizado = True
				End If
			Else
				Localizado = True
			End If
		End If
		
	Case 100
		Localizado = False
		
	Case -1
		Localizado = False
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Fornecedor")
End Choose
end subroutine

public subroutine of_inicializa ();SetNull(Cd_Fornecedor)
Nm_Fantasia = ""
Nm_Razao_Social = ""
SetNull(Cd_Fornecedor_sap)
SetNull(id_distribuidora)

id_selecao_cadastro = "N"

ib_Valida_Situacao	= True

Localizado = False
end subroutine

on uo_fornecedor.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_fornecedor.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;This.of_Inicializa()
end event

