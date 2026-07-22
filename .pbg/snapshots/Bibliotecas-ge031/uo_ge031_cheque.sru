HA$PBExportHeader$uo_ge031_cheque.sru
forward
global type uo_ge031_cheque from nonvisualobject
end type
end forward

global type uo_ge031_cheque from nonvisualobject
end type
global uo_ge031_cheque uo_ge031_cheque

type variables
String		is_cpf_cnpj
String		id_tipo_cheque
String		cd_caixa
String		nr_matricula_operador
String		cd_banco
String		nr_agencia
String		nr_conta
String		nr_cheque
String		nr_cmc7
String		id_tipo_deposito
String		retorno

DateTime dh_emissao
DateTime dh_vencimento

Decimal {2} vl_cheque

Long		nr_controle_caixa
end variables

forward prototypes
public subroutine of_inicializa ()
end prototypes

public subroutine of_inicializa ();SetNull(is_cpf_cnpj)
SetNull(id_tipo_cheque)
SetNull(cd_caixa)
SetNull(nr_matricula_operador)
SetNull(cd_banco)
SetNull(nr_agencia)
SetNull(nr_conta)
SetNull(nr_cheque)
SetNull(nr_cmc7)
SetNull(id_tipo_deposito)
SetNull(retorno)

SetNull(dh_emissao)
SetNull(dh_vencimento)

vl_cheque = 000.00

SetNull(nr_controle_caixa)
end subroutine

on uo_ge031_cheque.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge031_cheque.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

