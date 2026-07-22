HA$PBExportHeader$uo_mult_padrao_docto.sru
forward
global type uo_mult_padrao_docto from nonvisualobject
end type
end forward

global type uo_mult_padrao_docto from nonvisualobject
end type
global uo_mult_padrao_docto uo_mult_padrao_docto

type variables
Integer ID

String Descricao
String Base

Boolean Localizado

String ivs_Parametro_Selecao

dc_uo_transacao ivtr_trans
end variables

forward prototypes
public function boolean of_localiza (string ps_filtro)
public subroutine of_inicializa ()
private function boolean of_localiza_generico ()
private function boolean of_localiza_id (long pl_id)
public subroutine of_settrans (ref dc_uo_transacao ptr_trans)
end prototypes

public function boolean of_localiza (string ps_filtro);ivs_Parametro_Selecao = ps_filtro
Localizado = False

If IsNumber(ps_filtro) Then
	Localizado = of_localiza_id(Long(ps_filtro))
End If

If Not Localizado Then
	Localizado = of_localiza_generico()
End If

Return Localizado
end function

public subroutine of_inicializa ();SetNull(ID)
Descricao = ''

Localizado = False
end subroutine

private function boolean of_localiza_generico ();String lvs_Codigo

OpenWithParm(w_ge482_selecao_padrao_docto, This)

lvs_Codigo = Message.StringParm

If (Not IsNull(lvs_Codigo))and(Trim(lvs_Codigo)<>'') Then
	of_Localiza_id(Long(lvs_Codigo))
Else
	Localizado = False
End If

Return True
end function

private function boolean of_localiza_id (long pl_id);select id, upper(nmpadrao)
Into :ID, :Descricao
from m3_padraodoc 
where id = :pl_id
Using ivtr_trans;

Choose Case ivtr_trans.SqlCode 
	Case -1
		ivtr_trans.Of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Padr$$HEX1$$e300$$ENDHEX$$o de Documento.")
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

on uo_mult_padrao_docto.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_mult_padrao_docto.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;of_inicializa()

end event

