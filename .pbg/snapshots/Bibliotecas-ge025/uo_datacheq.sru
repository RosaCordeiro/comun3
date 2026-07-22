HA$PBExportHeader$uo_datacheq.sru
forward
global type uo_datacheq from nonvisualobject
end type
end forward

global type uo_datacheq from nonvisualobject
end type
global uo_datacheq uo_datacheq

forward prototypes
public function boolean of_cliente_bloqueado_loja (string as_cpf, long al_filial, ref string as_mensagem)
public function boolean of_cliente_bloqueado (string as_cpf, ref string as_mensagem)
public function boolean of_cliente_bloqueado_matriz (string as_cpf)
end prototypes

public function boolean of_cliente_bloqueado_loja (string as_cpf, long al_filial, ref string as_mensagem);Boolean lvb_Bloqueado

String lvs_Bloqueado = "N"

lvb_Bloqueado = This.of_Cliente_Bloqueado(as_CPF, ref as_Mensagem)

If lvb_Bloqueado Then lvs_Bloqueado = "S"

Insert Into consulta_registro_bacen (nr_cpf_cgc,   
											    dh_consulta,   
											    cd_filial,
												 id_bloqueado)  
Values (:as_CPF,
        getdate(),
		  :al_Filial,
		  :lvs_Bloqueado)
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Inclus$$HEX1$$e300$$ENDHEX$$o da Consulta Bacen")
Else
	SqlCa.of_Commit()
End If

Return lvb_Bloqueado
end function

public function boolean of_cliente_bloqueado (string as_cpf, ref string as_mensagem);String lvs_Nome

Select nm_cliente Into :lvs_Nome
From cheque_registro_bacen
Where nr_cpf_cgc = :as_CPF
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		as_Mensagem = "CPF/CGC : '" + as_CPF + "'~rNome : '" + lvs_Nome + "'~r~r"
		
		as_Mensagem += "Existem pend$$HEX1$$ea00$$ENDHEX$$ncias no cadastro.~n~nPor favor, procure o gerente do banco."
		Return True
	Case 100
		Return False
	Case -1
		as_Mensagem = "CPF/CGC : '" + as_CPF + "'~r~r"
		
		as_Mensagem = "Erro na verifica$$HEX2$$e700e300$$ENDHEX$$o do registro BACEN. " + SqlCa.SqlErrText
		Return False
End Choose
end function

public function boolean of_cliente_bloqueado_matriz (string as_cpf);Boolean lvb_Bloqueado

String lvs_Mensagem

lvb_Bloqueado = This.of_Cliente_Bloqueado(as_CPF, ref lvs_Mensagem)

If lvs_Mensagem <> "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvs_Mensagem, Information!)
End If

Return lvb_Bloqueado
end function

on uo_datacheq.create
TriggerEvent( this, "constructor" )
end on

on uo_datacheq.destroy
TriggerEvent( this, "destructor" )
end on

