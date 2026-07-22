HA$PBExportHeader$w_ge192_altera_divisao.srw
forward
global type w_ge192_altera_divisao from dc_w_response_ok_cancela
end type
end forward

global type w_ge192_altera_divisao from dc_w_response_ok_cancela
integer width = 2158
integer height = 408
string title = "GE192 - Altera Divis$$HEX1$$e300$$ENDHEX$$o"
end type
global w_ge192_altera_divisao w_ge192_altera_divisao

type variables
String is_Fornecedor
String is_Divisao
String is_Contato
end variables

on w_ge192_altera_divisao.create
call super::create
end on

on w_ge192_altera_divisao.destroy
call super::destroy
end on

event open;call super::open;DataWindowChild lvdwc

String ls_SQL, ls_Parametro

dw_1.AcceptText()

ls_Parametro = Message.StringParm

is_Fornecedor = MidA(ls_Parametro, 1, 9)
is_Divisao = MidA(ls_Parametro,10, 5)
is_Contato = MidA(ls_Parametro, 15, 2)
	
If dw_1.GetChild("nr_divisao_fornecedor", lvdwc) = 1 Then
	
	lvdwc.SetTransObject(SQLCA)
		
	ls_SQL = " SELECT 	cast(f.nr_divisao as char(5)) + ' - ' + f.nm_divisao + ' | ' +  u.nm_usuario de_divisao, f.nr_divisao FROM fornecedor_divisao f   " +&
				 " inner join usuario u on u.nr_matricula = f.nr_matricula_comprador " +&
				 " where f.cd_fornecedor = '" + is_Fornecedor + "'"
	
	lvdwc.SetSQLSelect(ls_SQL)
		
	If lvdwc.Retrieve() < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar as divis$$HEX1$$f500$$ENDHEX$$es do fornecedor.")
		Return 
	End If		
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild divis$$HEX1$$e300$$ENDHEX$$o fornecedor.")
End If
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge192_altera_divisao
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge192_altera_divisao
integer width = 2066
integer height = 180
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge192_altera_divisao
integer width = 2007
integer height = 88
string dataobject = "dw_ge192_divisao_contato"
end type

event dw_1::doubleclicked;//OverRide
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge192_altera_divisao
integer x = 1449
integer y = 200
end type

event cb_ok::clicked;call super::clicked;Long ll_Divisao_De
Long ll_Divisao_Para
Long ll_Contato

String ls_Erro

dw_1.AcceptText()

ll_Divisao_Para	= dw_1.Object.Nr_Divisao_Fornecedor[1]

If IsNull(ll_Divisao_Para) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma divis$$HEX1$$e300$$ENDHEX$$o.", Exclamation!)
	dw_1.Event ue_Pos(1, "nr_divisao_fornecedor")
	Return -1
End If

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a altera$$HEX2$$e700e300$$ENDHEX$$o da divis$$HEX1$$e300$$ENDHEX$$o?", Question!, YesNo!, 2) = 2 Then
	Return -1
End If

ll_Contato		= Long(is_Contato)
ll_Divisao_De	= Long(is_Divisao)

If ll_Divisao_De <> ll_Divisao_Para Then
	
	If ll_Divisao_De = 0 Then
		SetNull(ll_Divisao_De)
	End If

	Update fornecedor_contato
	Set nr_divisao_fornecedor = :ll_Divisao_Para
	Where cd_fornecedor = :is_Fornecedor
	And nr_contato = :ll_Contato
	And nr_divisao_fornecedor = :ll_Divisao_De
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		ls_Erro = SqlCa.SqlErrText
		SqlCa.of_Rollback();
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao atualizar o contato do fornecedor na tabela fornecedor_contato." + ls_Erro, StopSign!)
		Return -1
	End If
	
	SqlCa.of_Commit();
End If

CloseWithReturn(Parent, "S")
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge192_altera_divisao
integer x = 1783
integer y = 200
end type

event cb_cancelar::clicked;//OverRide

CloseWithReturn(Parent, "N")
end event

