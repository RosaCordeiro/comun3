HA$PBExportHeader$w_ge126_selecao_cliente_cpf.srw
forward
global type w_ge126_selecao_cliente_cpf from dc_w_selecao_generica
end type
end forward

global type w_ge126_selecao_cliente_cpf from dc_w_selecao_generica
integer x = 379
integer y = 436
integer width = 2830
integer height = 1532
string title = "GE126 - Sele$$HEX2$$e700e300$$ENDHEX$$o de Clientes CPF"
end type
global w_ge126_selecao_cliente_cpf w_ge126_selecao_cliente_cpf

type variables
uo_ge126_cpf ivo_cliente_cpf
end variables

on w_ge126_selecao_cliente_cpf.create
call super::create
end on

on w_ge126_selecao_cliente_cpf.destroy
call super::destroy
end on

event open;call super::open;String lvs_Cliente

ivo_cliente_cpf = Message.PowerObjectParm

lvs_Cliente = ivo_cliente_cpf.ivs_Parametro

If lvs_Cliente <> "" Then
	dw_1.Object.Nm_Cliente[1] = lvs_Cliente
	This.ivb_Pesquisa_Direta = True
End If
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge126_selecao_cliente_cpf
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge126_selecao_cliente_cpf
integer y = 288
integer width = 2752
integer height = 1008
long backcolor = 80269524
string text = "Lista de Clientes"
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge126_selecao_cliente_cpf
integer y = 16
integer width = 1573
integer height = 260
long backcolor = 80269524
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge126_selecao_cliente_cpf
integer x = 46
integer width = 1545
integer height = 184
string dataobject = "dw_ge126_selecao"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge126_selecao_cliente_cpf
integer x = 55
integer y = 340
integer width = 2706
integer height = 936
string dataobject = "dw_ge126_lista"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;Boolean lvb_Filtro = False

String lvs_Nome, &
		 lvs_CPF
		 
dw_1.AcceptText()

lvs_Nome 	= dw_1.Object.Nm_Cliente[1]
lvs_CPF  		= dw_1.Object.Nr_CPF    [1]

If Not IsNull(lvs_Nome) and Trim(lvs_Nome) <> "" Then
	This.of_AppendWhere("nm_cliente like '" + lvs_Nome + "%'", 1)
	This.of_AppendWhere("nm_conveniado like '" + lvs_Nome + "%'", 2)
	This.of_AppendWhere("nm_cliente like '" + lvs_Nome + "%'", 3)
	This.of_AppendWhere("nm_cliente like '" + lvs_Nome + "%'", 4)	
	lvb_Filtro = True
End If

If Not IsNull(lvs_CPF) and Trim(lvs_CPF) <> "" Then
	This.of_AppendWhere("nr_cpf_cgc like '" + lvs_CPF + "%'", 1)
	This.of_AppendWhere("nr_cpf like '" + lvs_CPF + "%'", 2)
	This.of_AppendWhere("nr_cpf like '" + lvs_CPF + "%'", 3)
	This.of_AppendWhere("nr_cpf like '" + lvs_CPF + "%'", 4)	
	lvb_Filtro = True	
End If

If lvb_Filtro = False Then
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Nenhum param$$HEX1$$ea00$$ENDHEX$$tro foi informado. Deseja prosseguir com a consulta?", Exclamation!, YesNo!,2) = 2 Then
		dw_1.Event ue_Pos(1,'nm_cliente')
		Return -1
	End If
End If

Return 1
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge126_selecao_cliente_cpf
integer x = 2016
end type

event cb_selecionar::clicked;call super::clicked;Long lvl_Linha

String lvs_Nr_CPF

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	lvs_Nr_CPF = dw_2.Object.Nr_CPF[lvl_Linha]
	CloseWithReturn(Parent, lvs_Nr_CPF)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Selecione um cliente.", Exclamation!)
	dw_2.SetFocus()
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge126_selecao_cliente_cpf
integer x = 2414
end type

event cb_cancelar::clicked;call super::clicked;String lvs_Cd_Cliente

SetNull(lvs_Cd_Cliente)

CloseWithReturn(Parent, lvs_Cd_Cliente)
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge126_selecao_cliente_cpf
integer x = 1545
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge126_selecao_cliente_cpf
integer x = 41
integer y = 1328
integer width = 1477
long backcolor = 80269524
end type

