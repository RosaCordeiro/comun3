HA$PBExportHeader$uo_condicao_venda_convenio.sru
forward
global type uo_condicao_venda_convenio from nonvisualobject
end type
end forward

global type uo_condicao_venda_convenio from nonvisualobject
end type
global uo_condicao_venda_convenio uo_condicao_venda_convenio

type variables
Boolean Localizado
Boolean Somente_Ativas = False

Decimal vl_subsidio

Long cd_convenio

Integer  cd_condicao_convenio

String  de_condicao_convenio, &
           id_restricao_grupo_produto, &
           id_restricao_produto, &
           id_paga_comissao, &
           id_considera_desc_produto,&
           id_aceita_unimed,&
		  id_exige_receita, &
		  id_controle_sexo

decimal pc_avista, &
             pc_desconto, &
             pc_desconto_minimo
end variables

forward prototypes
public subroutine of_localiza_generica (long pl_convenio, string ps_parametro)
public subroutine of_localiza_condicao (long pl_convenio, string ps_parametro)
public subroutine of_localiza_codigo (long pl_convenio, integer pi_condicao_convenio)
public subroutine of_inicializa ()
end prototypes

public subroutine of_localiza_generica (long pl_convenio, string ps_parametro);uo_Parametro_Selecao_Condicao_Venda_CV lvo_Parametro

String lvs_Condicao

lvo_Parametro = Create uo_Parametro_Selecao_Condicao_Venda_CV

lvo_Parametro.ivl_Convenio = pl_Convenio
lvo_Parametro.ivs_Nome     = ps_Parametro
lvo_Parametro.is_Somente_Ativas = iif( This.somente_ativas = True, 'S', 'N' )

OpenWithParm(w_ge006_Selecao_Condicao_Convenio, lvo_Parametro)

lvs_Condicao = Message.StringParm

If Not IsNull(lvs_Condicao) Then
	of_Localiza_Codigo(pl_Convenio, Integer(lvs_Condicao))
Else
	Localizado = False
End If

Destroy(lvo_Parametro)
end subroutine

public subroutine of_localiza_condicao (long pl_convenio, string ps_parametro);String lvs_Conveniado

Integer lvi_Tamanho

lvi_Tamanho = LenA(ps_Parametro)

// Verifica se foi recebido algum par$$HEX1$$e200$$ENDHEX$$metro
If lvi_Tamanho > 0 Then
	
	// Verifica o tipo do par$$HEX1$$e200$$ENDHEX$$metro recebido
	If IsNumber(ps_Parametro) Then

		// Localiza$$HEX2$$e700e300$$ENDHEX$$o direta pelo c$$HEX1$$f300$$ENDHEX$$digo da cidade
		of_Localiza_Codigo(pl_Convenio, Integer(ps_Parametro))

		If Not Localizado Then

			// Se n$$HEX1$$e300$$ENDHEX$$o localizar pelos m$$HEX1$$e900$$ENDHEX$$todos anteriores
			// Abre a janela de localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica
			of_Localiza_Generica(pl_Convenio, "")
	
		End If
	
	Else
	
		// Localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica conforme o nome do cliente
		of_Localiza_Generica(pl_Convenio, ps_Parametro)

	End If
	
Else	
	// Localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica sem par$$HEX1$$e200$$ENDHEX$$metros
	of_Localiza_Generica(pl_Convenio, "")
End If
end subroutine

public subroutine of_localiza_codigo (long pl_convenio, integer pi_condicao_convenio);Select rcc.cd_convenio,
       cvc.cd_condicao_convenio,
       cvc.de_condicao_convenio,
		 rcc.id_restricao_grupo_produto,
		 rcc.id_restricao_produto,
		 rcc.id_paga_comissao,
		 rcc.pc_avista,
	    rcc.pc_desconto,
		 rcc.id_considera_desc_produto,
		 rcc.pc_desconto_minimo,
		 rcc.id_aceita_unimed,
		 rcc.vl_subsidio,
		 cvc.id_exige_receita,
		 rcc.id_controle_sexo
Into :This.cd_convenio,
     :This.cd_condicao_convenio,
     :This.de_condicao_convenio,
	  :This.id_restricao_grupo_produto,
	  :This.id_restricao_produto,
	  :This.id_paga_comissao,
	  :This.pc_avista,
	  :This.pc_desconto,
	  :This.id_considera_desc_produto,
	  :This.pc_desconto_minimo,
	  :This.id_aceita_unimed,
	  :This.vl_subsidio,
	  :This.id_exige_receita,
	  :This.id_controle_sexo
From condicao_venda_convenio   cvc
Left Outer Join relacao_condicao_convenio rcc 
	on rcc.cd_condicao_convenio = cvc.cd_condicao_convenio
	and rcc.cd_convenio          = :pl_convenio
Where cvc.cd_condicao_convenio = :pi_condicao_convenio;
  
If IsNull(This.pc_desconto_minimo) Then This.pc_desconto_minimo = 000.00

If IsNull(This.id_aceita_unimed) Then This.id_aceita_unimed = 'S'

If IsNull(This.vl_subsidio) Then This.vl_subsidio = 000.00

If IsNull(This.id_exige_receita) Then This.id_exige_receita = 'N'

If IsNull(This.id_controle_sexo) Then This.id_controle_sexo = 'T'

If SqlCa.SqlCode = -1 Then
	Localizado = False
ElseIf Sqlca.SqlCode = 100 Then
	Localizado = False
Else	
	Localizado = True
End If

 
end subroutine

public subroutine of_inicializa ();This.Localizado = False
This.Somente_Ativas = False

SetNull(This.cd_convenio)
SetNull(This.cd_condicao_convenio)
SetNull(This.de_condicao_convenio)
SetNull(This.id_restricao_grupo_produto)
SetNull(This.id_restricao_produto)
SetNull(This.id_paga_comissao)
SetNull(This.pc_avista)
SetNull(This.pc_desconto)
SetNull(This.id_considera_desc_produto)
SetNull(This.pc_desconto_minimo)
SetNull(This.id_aceita_unimed)
SetNull(This.vl_subsidio)
SetNull(This.id_exige_receita)
end subroutine

on uo_condicao_venda_convenio.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_condicao_venda_convenio.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

