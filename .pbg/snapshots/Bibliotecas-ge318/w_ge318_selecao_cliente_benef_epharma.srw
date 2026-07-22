HA$PBExportHeader$w_ge318_selecao_cliente_benef_epharma.srw
forward
global type w_ge318_selecao_cliente_benef_epharma from dc_w_selecao_generica
end type
end forward

global type w_ge318_selecao_cliente_benef_epharma from dc_w_selecao_generica
integer x = 82
integer y = 376
integer width = 3511
integer height = 1760
string title = "GE318 - Sele$$HEX2$$e700e300$$ENDHEX$$o de Clientes/Benef$$HEX1$$ed00$$ENDHEX$$cios E-Pharma"
end type
global w_ge318_selecao_cliente_benef_epharma w_ge318_selecao_cliente_benef_epharma

type prototypes

end prototypes

type variables

end variables

on w_ge318_selecao_cliente_benef_epharma.create
call super::create
end on

on w_ge318_selecao_cliente_benef_epharma.destroy
call super::destroy
end on

event open;call super::open;String lvs_Cliente

lvs_Cliente = Message.StringParm

If lvs_Cliente <> "" Then
	dw_1.Object.De_Cliente[1] = lvs_Cliente
	ivb_Pesquisa_Direta = True
End If
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge318_selecao_cliente_benef_epharma
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge318_selecao_cliente_benef_epharma
integer x = 23
integer y = 356
integer width = 3433
integer height = 1160
long backcolor = 80269524
string text = "Lista de Clientes/Benef$$HEX1$$ed00$$ENDHEX$$cios"
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge318_selecao_cliente_benef_epharma
integer x = 23
integer y = 4
integer width = 2331
integer height = 344
long backcolor = 80269524
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge318_selecao_cliente_benef_epharma
integer x = 50
integer y = 76
integer width = 2295
integer height = 260
string dataobject = "dw_ge318_selecao_cliente_benef_epharma"
end type

event dw_1::itemchanged;call super::itemchanged;If dwo.Name = "id_fisica_juridica" Then
	
	If This.Object.Id_Fisica_Juridica[1] = "F" Then 		
		This.Object.Nr_CGC[1] = ''		
	Else		
		This.Object.Nr_CPF[1] = ''		
	End If 	
	
End If
end event

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge318_selecao_cliente_benef_epharma
integer x = 46
integer y = 408
integer width = 3387
integer height = 1092
string dataobject = "dw_ge318_lista_cliente_benef_epharma"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String 	lvs_Cliente, &
		 lvs_Beneficio, &
		 lvs_Convenio

Integer lvi_Nr_Dia_Fechamento

dw_1.AcceptText()

lvs_Convenio				= Trim(dw_1.Object.de_convenio[1])
lvs_Cliente      				= Trim(dw_1.Object.de_cliente[1])
lvs_Beneficio				= Trim(dw_1.Object.de_beneficio[1])
lvi_Nr_Dia_Fechamento 	= dw_1.Object.nr_dia_fechamento[1]

//Cancatena Conv$$HEX1$$ea00$$ENDHEX$$nio
If LenA( TRIM( lvs_Convenio) ) > 0 Then
	This.of_AppendWhere("nm_convenio like '" + lvs_Convenio + "%'")
End If

//Cancatena Cliente
If LenA( TRIM( lvs_Cliente) ) > 0 Then
	This.of_AppendWhere("nm_cliente like '" + lvs_Cliente + "%'")
End If
		 
//Concatena Beneficio
If LenA( TRIM( lvs_Beneficio ) ) > 0 Then
	This.of_AppendWhere("nm_beneficio like '" + lvs_Beneficio + "%'")
End If

//Concatena dia fechamento
If lvi_Nr_Dia_Fechamento <> 0 Then
	This.of_AppendWhere("nr_dia_fechamento = " + String(lvi_Nr_Dia_Fechamento))
End If

Return AncestorReturnValue
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge318_selecao_cliente_benef_epharma
integer x = 2688
integer y = 1544
end type

event cb_selecionar::clicked;call super::clicked;Long lvl_Linha

String lvs_Cliente, &
		lvs_Beneficio

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	lvs_Cliente		= String(dw_2.Object.Cd_Cliente[lvl_Linha])
	lvs_Beneficio 	= String(dw_2.Object.Cd_Beneficio[lvl_Linha])
	
	CloseWithReturn(Parent, lvs_Cliente + "|" + lvs_Beneficio)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um cliente.", Information!, Ok!)
	dw_2.SetFocus()
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge318_selecao_cliente_benef_epharma
integer x = 3086
integer y = 1544
end type

event cb_cancelar::clicked;call super::clicked;String lvs_Fornecedor

SetNull(lvs_Fornecedor)

CloseWithReturn(Parent, lvs_Fornecedor)
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge318_selecao_cliente_benef_epharma
integer x = 1952
integer y = 1544
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge318_selecao_cliente_benef_epharma
integer x = 23
integer y = 1556
long backcolor = 80269524
end type

