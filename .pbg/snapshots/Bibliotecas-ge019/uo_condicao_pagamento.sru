HA$PBExportHeader$uo_condicao_pagamento.sru
forward
global type uo_condicao_pagamento from nonvisualobject
end type
end forward

global type uo_condicao_pagamento from nonvisualobject
end type
global uo_condicao_pagamento uo_condicao_pagamento

type variables
long cd_condicao

string de_condicao, id_situacao

Boolean ib_Valida_Situacao = False
end variables

forward prototypes
public subroutine of_inicializa ()
public function boolean of_localiza_codigo (long al_codigo)
public function boolean of_localiza_generica (string as_parametro, decimal adc_valor, date adt_data)
public function boolean of_localiza (string as_parametro, decimal adc_valor, date adt_data)
public function boolean of_localiza (string as_parametro)
end prototypes

public subroutine of_inicializa ();SetNull(Cd_Condicao)
De_Condicao = ""
end subroutine

public function boolean of_localiza_codigo (long al_codigo);Boolean lvb_Sucesso = False

If gvo_Parametro.cd_filial  = gvo_Parametro.cd_filial_matriz Then
	Select cd_condicao,
			 de_condicao,
			 coalesce(id_situacao, 'A')
	Into :Cd_Condicao,
		  :De_Condicao,
		  :id_situacao
	From condicao_pagamento
	Where cd_condicao = :al_Codigo
	Using SqlCa;
Else
	Select cd_condicao,
			 de_condicao
	Into :Cd_Condicao,
		  :De_Condicao
	From condicao_pagamento
	Where cd_condicao = :al_Codigo
	Using SqlCa;
End If

Choose Case SqlCa.SqlCode
	Case 0
		
		If ib_Valida_Situacao and id_situacao = 'I' Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A condi$$HEX2$$e700e300$$ENDHEX$$o '" + De_Condicao + "' esta INATIVA.", Exclamation!)
		Else
			lvb_Sucesso = True
		End If
		
	Case 100
		
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da Condi$$HEX2$$e700e300$$ENDHEX$$o de Pagamento")
End Choose

Return lvb_Sucesso
end function

public function boolean of_localiza_generica (string as_parametro, decimal adc_valor, date adt_data);Long lvl_Inteira, &
     lvl_Decimal

String lvs_Retorno

lvl_Inteira = Long(adc_Valor)
lvl_Decimal = (adc_Valor - lvl_Inteira) * 100

as_Parametro = String(lvl_Inteira, "0000000") + &
               String(lvl_Decimal, "00") + &
					String(adt_Data, "dd/mm/yyyy") + &
					as_Parametro

OpenWithParm(w_ge019_Selecao_Condicao_Pagamento, as_Parametro)

lvs_Retorno = Message.StringParm

If Not IsNull(lvs_Retorno) Then
	Return This.of_Localiza_Codigo(Long(lvs_Retorno))
Else
	Return False
End If
end function

public function boolean of_localiza (string as_parametro, decimal adc_valor, date adt_data);Integer lvi_Tamanho

lvi_Tamanho = LenA(as_Parametro)

If lvi_Tamanho > 0 Then
	If IsNumber(as_Parametro) Then
		If Not This.of_Localiza_Codigo(Long(as_Parametro)) Then
			Return This.of_Localiza_Generica("", adc_Valor, adt_Data)
		Else
			Return True
		End If
	Else
		Return This.of_Localiza_Generica(as_Parametro, adc_Valor, adt_Data)
	End If
Else
	Return This.of_Localiza_Generica("", adc_Valor, adt_Data)
End If
end function

public function boolean of_localiza (string as_parametro);Return This.of_Localiza(as_Parametro, 100, Today())
end function

on uo_condicao_pagamento.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_condicao_pagamento.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;This.of_Inicializa()
end event

