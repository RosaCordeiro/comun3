HA$PBExportHeader$w_ge032_selecao_cliente_cheque.srw
forward
global type w_ge032_selecao_cliente_cheque from dc_w_selecao_generica
end type
end forward

global type w_ge032_selecao_cliente_cheque from dc_w_selecao_generica
integer x = 379
integer y = 436
integer width = 2962
integer height = 1532
string title = "GE032 - Sele$$HEX2$$e700e300$$ENDHEX$$o de Clientes Cheque"
end type
global w_ge032_selecao_cliente_cheque w_ge032_selecao_cliente_cheque

type variables
uo_cliente_cheque ivo_cliente
end variables

on w_ge032_selecao_cliente_cheque.create
call super::create
end on

on w_ge032_selecao_cliente_cheque.destroy
call super::destroy
end on

event open;call super::open;String lvs_Cliente

ivo_Cliente = Message.PowerObjectParm

lvs_Cliente = ivo_Cliente.ivs_Parametro

If lvs_Cliente <> "" Then
	dw_1.Object.Nm_Cliente[1] = lvs_Cliente
	This.ivb_Pesquisa_Direta  = True
End If
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge032_selecao_cliente_cheque
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge032_selecao_cliente_cheque
integer y = 276
integer width = 2885
integer height = 1008
long backcolor = 80269524
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge032_selecao_cliente_cheque
integer y = 16
integer width = 1481
integer height = 256
long backcolor = 80269524
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge032_selecao_cliente_cheque
integer x = 41
integer width = 1449
integer height = 184
string dataobject = "dw_ge032_selecao"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge032_selecao_cliente_cheque
integer x = 59
integer y = 328
integer width = 2825
integer height = 932
string dataobject = "dw_ge032_lista"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_where, &
       lvs_sql,&
		 lvs_cpf, &
       lvs_Nome

dw_1.AcceptText()

lvs_where = ''

lvs_sql = "select nr_cpf,nm_cliente,nr_rg from cliente_cheque"

lvs_cpf  = Trim(dw_1.Object.nr_cpf[1])
lvs_Nome = Trim(dw_1.Object.nm_Cliente[1])
			 
If Not IsNull(lvs_Nome) and Trim(lvs_Nome) <> "" Then
	lvs_where = "nm_cliente like " + "'" + lvs_Nome + "%'"
End If

If Not IsNull(lvs_cpf) and Trim(lvs_cpf) <> "" Then
	If Trim(lvs_Where) <> '' Then lvs_where += " and "
	lvs_where += "nr_cpf = '" + lvs_cpf + "'"
End If

If Trim(lvs_where) <> '' Then
	lvs_sql   = lvs_sql + " WHERE " + lvs_where
	This.of_ChangeSQL(lvs_sql)
	Return 1	
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe um par$$HEX1$$e200$$ENDHEX$$metro para sele$$HEX2$$e700e300$$ENDHEX$$o.", Information!)
	Return -1
End If
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge032_selecao_cliente_cheque
integer x = 2153
integer y = 1300
end type

event cb_selecionar::clicked;Long   lvl_Linha

String lvs_cpf

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	lvs_cpf = dw_2.Object.nr_cpf[lvl_Linha]
	CloseWithReturn(Parent, lvs_cpf)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um cliente.", Information!, Ok!)
	dw_2.SetFocus()
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge032_selecao_cliente_cheque
integer x = 2542
integer y = 1300
end type

event cb_cancelar::clicked;String lvs_cpf

SetNull(lvs_cpf)

CloseWithReturn(Parent, lvs_cpf)
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge032_selecao_cliente_cheque
integer x = 1765
integer y = 1300
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge032_selecao_cliente_cheque
integer x = 41
integer width = 1568
long backcolor = 80269524
end type

