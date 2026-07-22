HA$PBExportHeader$uo_mult_filial.sru
forward
global type uo_mult_filial from nonvisualobject
end type
end forward

global type uo_mult_filial from nonvisualobject
end type
global uo_mult_filial uo_mult_filial

type variables
Integer ID
Integer IDF_Empresa
Integer Codigo

String Descricao

Boolean Localizado

String ivs_Parametro_Selecao

dc_uo_transacao ivtr_trans
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
SetNull(Codigo)
SetNull(IDF_Empresa)
Descricao = ''

Localizado = False
end subroutine

private function boolean of_localiza_generico ();String lvs_Codigo

OpenWithParm(w_ge484_selecao_filial, This)

lvs_Codigo = Message.StringParm

If (Not IsNull(lvs_Codigo))and(Trim(lvs_Codigo)<>'') Then
	of_Localiza_id(Long(lvs_Codigo))
Else
	Localizado = False
End If

Return True
end function

private function boolean of_localiza_codigo (string ps_codigo);select a.id, upper(a.codigo), upper(c.fantasia)
Into :ID, :Codigo, :Descricao
from m3_filial a
inner join mtmg_papelrel b on b.id = a.ida
inner join mtmg_ident c on c.id = b.idf_ident
where upper(a.codigo) = :ps_codigo
	and a.idf_empresa = :IDF_Empresa
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

private function boolean of_localiza_id (long pl_id);select a.id, upper(a.codigo), upper(c.fantasia)
Into :ID, :Codigo, :Descricao
from m3_filial a
inner join mtmg_papelrel b on b.id = a.ida
inner join mtmg_ident c on c.id = b.idf_ident
where a.id = :pl_id
	and a.idf_empresa = :IDF_Empresa
Using ivtr_trans;

Choose Case ivtr_trans.SqlCode 
	Case -1
		ivtr_trans.Of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da Filial.")
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

If IsNumber(ivs_Parametro_Selecao) Then
	Localizado = of_localiza_codigo(ivs_Parametro_Selecao)
End If

If Not Localizado Then
	Localizado = of_localiza_generico()
End If

Return Localizado
end function

on uo_mult_filial.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_mult_filial.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;of_inicializa()
end event

