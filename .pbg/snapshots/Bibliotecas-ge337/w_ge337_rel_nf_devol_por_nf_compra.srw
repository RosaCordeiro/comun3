HA$PBExportHeader$w_ge337_rel_nf_devol_por_nf_compra.srw
forward
global type w_ge337_rel_nf_devol_por_nf_compra from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge337_rel_nf_devol_por_nf_compra from dc_w_selecao_lista_relatorio
integer width = 3922
integer height = 2052
string title = "GE337 - Consulta Devolu$$HEX2$$e700e300$$ENDHEX$$o de Compra por Notas de Compra"
end type
global w_ge337_rel_nf_devol_por_nf_compra w_ge337_rel_nf_devol_por_nf_compra

type variables
uo_fornecedor io_fornecedor
uo_filial io_filial
end variables

on w_ge337_rel_nf_devol_por_nf_compra.create
call super::create
end on

on w_ge337_rel_nf_devol_por_nf_compra.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;Destroy(io_Fornecedor)
Destroy(io_Filial)
end event

event open;call super::open;io_Fornecedor 	= Create uo_Fornecedor
io_Filial			= Create uo_Filial
end event

event ue_postopen;call super::ue_postopen;io_Filial.of_Localiza_Codigo(534)

dw_1.Object.dh_inicio	[1] = Today()
dw_1.Object.dh_fim		[1] = Today()

If io_Filial.Localizada Then
	dw_1.Object.Cd_Filial	[1]= io_Filial.Cd_filial
	dw_1.Object.de_filial	[1]	= io_Filial.Nm_Fantasia
End If

This.ivm_menu.ivb_Permite_Imprimir = True

end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge337_rel_nf_devol_por_nf_compra
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge337_rel_nf_devol_por_nf_compra
integer x = 123
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge337_rel_nf_devol_por_nf_compra
integer y = 448
integer width = 3808
integer height = 1396
integer weight = 700
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge337_rel_nf_devol_por_nf_compra
integer width = 2030
integer height = 408
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge337_rel_nf_devol_por_nf_compra
integer width = 1957
integer height = 328
string dataobject = "dw_ge337_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;If dwo.Name = "de_fornecedor" Then
	If Not IsNull(Data) and Trim(Data) <> "" Then
		If Data <> io_Fornecedor.Nm_Razao_Social Then
			Return 1
		End If
	Else
		io_Fornecedor.of_Inicializa()
		
		This.Object.Cd_Fornecedor	[1] = io_Fornecedor.Cd_Fornecedor
		This.Object.de_Fornecedor	[1] = io_Fornecedor.Nm_Razao_Social
	End If
End If

If dwo.Name = "de_filial" Then
	If Not IsNull(Data) and Trim(Data) <> "" Then
		If Data <> io_Filial.Nm_Fantasia Then
			Return 1
		End If
	Else
		io_Filial.of_Inicializa()
		
		This.Object.Cd_Filial	[1] = io_Filial.Cd_Filial
		This.Object.de_Filial	[1] = io_Filial.Nm_Fantasia
	End If
End If
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	If This.GetColumnName() = "de_fornecedor" Then
		io_Fornecedor.of_Localiza_Fornecedor(This.GetText())
		
		If io_Fornecedor.Localizado Then
			This.Object.Cd_Fornecedor[1] = io_Fornecedor.Cd_Fornecedor
			This.Object.de_Fornecedor[1] = io_Fornecedor.Nm_Razao_Social
		End If
	ElseIf This.GetColumnName() = "de_filial" Then
		io_Filial.of_Localiza_Filial(This.GetText())
		
		If io_Filial.Localizada Then
			This.Object.Cd_Filial[1] = io_Filial.Cd_filial
			This.Object.de_filial[1] = io_Filial.Nm_Fantasia
		End If
	End If
End If
end event

event dw_1::losefocus;call super::losefocus;If IsValid(io_Fornecedor) Then
	This.Object.Cd_Fornecedor	[1] = io_Fornecedor.Cd_Fornecedor
	This.Object.de_Fornecedor	[1] = io_Fornecedor.Nm_Razao_Social
End If

If IsValid(io_Filial) Then
	This.Object.Cd_Filial	[1] = io_Filial.Cd_Filial
	This.Object.de_Filial	[1] = io_Filial.Nm_Fantasia
End If
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge337_rel_nf_devol_por_nf_compra
integer y = 496
integer width = 3749
integer height = 1336
string dataobject = "dw_ge337_lista"
end type

event dw_2::ue_recuperar;//OverRide

Date	ldh_Inicio,&
		ldh_Fim
				
Long	ll_Filial,&
		ll_Nota

String ls_Fornecedor

dw_1.AcceptText()

ldh_Inicio		= dw_1.Object.dh_inicio			[1]
ldh_Fim			= dw_1.Object.dh_fim			[1]
ll_Filial			= dw_1.Object.cd_filial			[1]
ls_Fornecedor	= dw_1.Object.cd_fornecedor	[1]
ll_Nota			= dw_1.Object.nr_nf				[1]

If IsNull(ldh_Inicio) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o in$$HEX1$$ed00$$ENDHEX$$cio corretamente.")
	dw_1.Event ue_Pos(1, "dh_inicio")
	Return -1
End If

If IsNull(ldh_Fim) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o t$$HEX1$$e900$$ENDHEX$$rmino corretamente.")
	dw_1.Event ue_Pos(1, "dh_fim")
	Return -1
End If

If ldh_Inicio > ldh_Fim Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio n$$HEX1$$e300$$ENDHEX$$o pode ser maior que a de t$$HEX1$$e900$$ENDHEX$$rmino.")
	dw_1.Event ue_Pos(1, "dh_inicio")
	Return -1
End If

If IsNull(ll_Filial) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a filial.")
	dw_1.Event ue_Pos(1, "cd_filial")
	Return -1
End If

If Not IsNull(ls_Fornecedor) and (ls_Fornecedor <> "") Then
	This.of_AppendWhere("a.cd_fornecedor = '"+ls_Fornecedor+"'")
End If

If Not IsNull(ll_Nota) and (ll_Nota <> 0) Then
	This.of_AppendWhere("a.nr_nf = "+String(ll_Nota))	
End If

Return This.Retrieve(ll_Filial, ldh_Inicio, ldh_Fim)

end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge337_rel_nf_devol_por_nf_compra
integer x = 2094
integer y = 44
string dataobject = "dw_ge337_lista_rel"
end type

