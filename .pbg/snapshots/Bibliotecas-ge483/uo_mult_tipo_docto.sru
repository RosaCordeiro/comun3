HA$PBExportHeader$uo_mult_tipo_docto.sru
forward
global type uo_mult_tipo_docto from nonvisualobject
end type
end forward

global type uo_mult_tipo_docto from nonvisualobject
end type
global uo_mult_tipo_docto uo_mult_tipo_docto

type variables
Integer ID
Integer IDF_Padrao
Integer IDF_Empresa

String Codigo
String Descricao

Boolean Localizado

String ivs_Parametro_Selecao

dc_uo_transacao ivtr_trans

String ivs_tipo_dctos

Boolean ib_todos_tipo_dctos = true

Boolean ib_mult_selecao = false
end variables

forward prototypes
public subroutine of_inicializa ()
private function boolean of_localiza_generico ()
private function boolean of_localiza_codigo (string ps_codigo)
private function boolean of_localiza_id (long pl_id)
public subroutine of_settrans (ref dc_uo_transacao ptr_trans)
public function boolean of_localiza (string ps_filtro, integer pl_empresa)
end prototypes

public subroutine of_inicializa ();SetNull(ID)
Codigo = ''
Descricao = ''
SetNull(IDF_Padrao)
SetNull(IDF_Empresa)

Localizado = False

ib_todos_tipo_dctos = true

ib_mult_selecao = false

SetNull(ivs_tipo_dctos)
end subroutine

private function boolean of_localiza_generico ();String lvs_Codigo

OpenWithParm(w_ge483_selecao_tipo_docto, This)

lvs_Codigo = Message.StringParm

If (Not IsNull(lvs_Codigo))and(Trim(lvs_Codigo)<>'') Then
	of_Localiza_id(Long(lvs_Codigo))
Else
	Localizado = False
End If

Return True
end function

private function boolean of_localiza_codigo (string ps_codigo);select id, upper(codtpdocto), upper(descricao), idf_padraodocto
Into :ID, :Codigo, :Descricao, :IDF_Padrao
from m3_tipdoc 
where UPPER(codtpdocto) = :ps_codigo
	and datvalfin >= SysDate
	and situacao = '0'
	and idf_empresa = :IDF_Empresa
	and rownum = 1
Using ivtr_trans;

Choose Case ivtr_trans.SqlCode 
	Case -1
		ivtr_trans.Of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da filial.")
		Localizado = False
	Case 100
		Localizado = False
	Case Else
		Localizado = (Not IsNull(ID))
End Choose

Return Localizado
end function

private function boolean of_localiza_id (long pl_id);select id, upper(codtpdocto), upper(descricao), idf_padraodocto
Into :ID, :Codigo, :Descricao, :IDF_Padrao
from m3_tipdoc 
where id = :pl_id
	and idf_empresa = :IDF_Empresa
Using ivtr_trans;

Choose Case ivtr_trans.SqlCode 
	Case -1
		ivtr_trans.Of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Tipo de Documento.")
		Localizado = False
	Case 100
		Localizado = False
	Case Else
		Localizado = True
End Choose

Return Localizado
end function

public subroutine of_settrans (ref dc_uo_transacao ptr_trans);ivtr_trans = ptr_trans
end subroutine

public function boolean of_localiza (string ps_filtro, integer pl_empresa);ivs_Parametro_Selecao = ps_filtro
IDF_Empresa = pl_empresa
Localizado = False

If IsNumber(ps_filtro) Then
	Localizado = of_localiza_id(Long(ps_filtro))
End If

If Not Localizado Then
	Localizado = of_localiza_codigo(ps_filtro)

	If Not Localizado Then
		Localizado = of_localiza_generico()
	End If
End If

Return Localizado
end function

on uo_mult_tipo_docto.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_mult_tipo_docto.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;of_inicializa()
end event

