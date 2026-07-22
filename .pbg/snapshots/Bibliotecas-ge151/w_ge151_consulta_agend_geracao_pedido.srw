HA$PBExportHeader$w_ge151_consulta_agend_geracao_pedido.srw
forward
global type w_ge151_consulta_agend_geracao_pedido from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge151_consulta_agend_geracao_pedido from dc_w_selecao_lista_relatorio
integer width = 3438
integer height = 1996
string title = "GE151 - Consulta Agendamento de Gera$$HEX2$$e700e300$$ENDHEX$$o de Pedido"
end type
global w_ge151_consulta_agend_geracao_pedido w_ge151_consulta_agend_geracao_pedido

type variables
uo_filial		io_Filial		//ge009
end variables

on w_ge151_consulta_agend_geracao_pedido.create
call super::create
end on

on w_ge151_consulta_agend_geracao_pedido.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;io_Filial = Create uo_filial
end event

event close;call super::close;Destroy(io_Filial)
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge151_consulta_agend_geracao_pedido
integer x = 37
integer y = 800
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge151_consulta_agend_geracao_pedido
integer x = 0
integer y = 728
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge151_consulta_agend_geracao_pedido
integer y = 224
integer width = 3323
integer height = 1556
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge151_consulta_agend_geracao_pedido
integer width = 2798
integer height = 196
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge151_consulta_agend_geracao_pedido
integer width = 2729
integer height = 80
string dataobject = "dw_ge151_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;dw_2.Event ue_Reset()

If dwo.Name = "nm_fantasia" Then
	If Not IsNull(Data) And Trim(Data) <> "" Then
		If Data <> io_Filial.Nm_Fantasia Then
			Return 1
		End If
	Else
		io_Filial.of_Inicializa()
		
		This.Object.Cd_Filial		[1] = io_Filial.Cd_Filial
		This.Object.Nm_Fantasia	[1] = io_Filial.Nm_Fantasia
	End If
End If
end event

event dw_1::editchanged;call super::editchanged;dw_2.Event ue_Reset()

If dwo.Name = "nm_fantasia" Then
	If Not IsNull(Data) And Trim(Data) <> "" Then
		If Data <> io_Filial.Nm_Fantasia Then
			Return 1
		End If
	Else
		io_Filial.of_Inicializa()
		
		This.Object.Cd_Filial		[1] = io_Filial.Cd_Filial
		This.Object.Nm_Fantasia	[1] = io_Filial.Nm_Fantasia
	End If
End If
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	If This.GetColumnName() = "nm_fantasia" Then
		io_Filial.of_Localiza_Filial(This.GetText())
		
		If Not io_Filial.Localizada Then
			io_Filial.of_Inicializa()
		End If
		
		This.Object.Cd_Filial		[1]	= io_Filial.Cd_Filial
		This.Object.Nm_Fantasia	[1]	= io_Filial.Nm_Fantasia
	End If
End If
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge151_consulta_agend_geracao_pedido
integer y = 300
integer width = 3255
integer height = 1456
string dataobject = "dw_ge151_lista"
end type

event dw_2::constructor;call super::constructor;This.ivb_Ordena_Colunas = True
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;Long ll_Filial

String ls_Controlado

dw_1.AcceptText()

ll_Filial			= dw_1.Object.Cd_Filial							[1]	
ls_Controlado	= dw_1.Object.Id_Bloqueia_Pedido_Psico	[1]

If Not IsNull(ll_Filial) And ll_Filial > 0 Then
	This.of_AppendWhere_SubQuery("p.cd_filial = " + String(ll_Filial), 3)
End If

If ls_Controlado = "S" Then
	This.of_AppendWhere_SubQuery("(f.id_bloqueia_pedido_psico Is Not Null And f.id_bloqueia_pedido_psico <> '0')", 3)
End If

Return 1
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	This.ivo_Controle_Menu.of_SalvarComo(True)
Else
	This.ivo_Controle_Menu.of_SalvarComo(False)
End If

Return pl_Linhas
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge151_consulta_agend_geracao_pedido
integer x = 1440
integer y = 980
end type

