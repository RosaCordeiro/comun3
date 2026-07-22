HA$PBExportHeader$uo_movimento_estoque.sru
forward
global type uo_movimento_estoque from nonvisualobject
end type
end forward

global type uo_movimento_estoque from nonvisualobject
end type
global uo_movimento_estoque uo_movimento_estoque

type variables

 
end variables

forward prototypes
public function integer of_movto_compra ()
public function integer of_tipo_movto (string ps_tipo, string ps_entrada_saida, string ps_cancelamento)
public function integer of_movto_venda ()
public function integer of_movto_devolucao_venda ()
public function integer of_movto_transferencia_entrada ()
public function integer of_movto_transferencia_saida ()
end prototypes

public function integer of_movto_compra ();Return of_Tipo_Movto("C", "E", "N")
end function

public function integer of_tipo_movto (string ps_tipo, string ps_entrada_saida, string ps_cancelamento);Integer lvi_Tipo_Movimento

Select cd_tipo_movimento Into :lvi_Tipo_Movimento
From tipo_movimento_estoque
Where id_tipo_movimento = :ps_Tipo
  and id_entrada_saida  = :ps_Entrada_Saida
  and id_cancelamento   = :ps_Cancelamento;
  
Choose Case SqlCa.SqlCode
	Case 0
		Return lvi_Tipo_Movimento
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tipo de movimento de estoque n$$HEX1$$e300$$ENDHEX$$o localizado.", StopSign!, Ok!)
		Return 0
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na determina$$HEX2$$e700e300$$ENDHEX$$o do tipo de movimento de estoque." + SqlCa.SqlErrText, StopSign!, Ok!)
		Return 0
End Choose
end function

public function integer of_movto_venda ();Return of_Tipo_Movto("V", "S", "N")
end function

public function integer of_movto_devolucao_venda ();Return of_Tipo_Movto("V", "E", "N")
end function

public function integer of_movto_transferencia_entrada ();Return of_Tipo_Movto("T", "E", "N")
end function

public function integer of_movto_transferencia_saida ();Return of_Tipo_Movto("T", "S", "N")
end function

on uo_movimento_estoque.create
TriggerEvent( this, "constructor" )
end on

on uo_movimento_estoque.destroy
TriggerEvent( this, "destructor" )
end on

