HA$PBExportHeader$w_ge433_rel_pedido_atraso_fornecedor.srw
forward
global type w_ge433_rel_pedido_atraso_fornecedor from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge433_rel_pedido_atraso_fornecedor from dc_w_selecao_lista_relatorio
integer width = 6007
integer height = 2344
string title = "GE433 - Relat$$HEX1$$f300$$ENDHEX$$rio de Pedidos em Atraso"
end type
global w_ge433_rel_pedido_atraso_fornecedor w_ge433_rel_pedido_atraso_fornecedor

type variables
uo_Filial						io_Filial			//ge009
uo_Fornecedor				io_Fornecedor	//ge003
uo_ge149_Comprador	io_Comprador
end variables

on w_ge433_rel_pedido_atraso_fornecedor.create
call super::create
end on

on w_ge433_rel_pedido_atraso_fornecedor.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;io_Filial			= Create uo_Filial
io_Fornecedor	= Create uo_Fornecedor
io_Comprador	= Create uo_ge149_Comprador
end event

event close;call super::close;Destroy(io_Filial)
Destroy(io_Fornecedor)
Destroy(io_Comprador)
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge433_rel_pedido_atraso_fornecedor
integer y = 616
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge433_rel_pedido_atraso_fornecedor
integer y = 544
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge433_rel_pedido_atraso_fornecedor
integer y = 356
integer width = 5893
integer height = 1776
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge433_rel_pedido_atraso_fornecedor
integer width = 2011
integer height = 324
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge433_rel_pedido_atraso_fornecedor
integer width = 1943
integer height = 232
string dataobject = "dw_ge433_selecao"
end type

event dw_1::editchanged;call super::editchanged;Choose Case dwo.Name
	Case "nm_fornecedor"
		If Not IsNull(Data) And Trim(Data) <> "" Then
			If Data <> io_Fornecedor.Nm_Razao_Social Then
				Return 1
			End If
		Else
			io_Fornecedor.of_Inicializa()
			
			This.Object.Cd_Fornecedor		[1] = io_Fornecedor.Cd_Fornecedor
			This.Object.Nm_Fornecedor		[1] = io_Fornecedor.Nm_Razao_Social
		End If
		
	Case "nm_usuario"
		If Not IsNull(Data) And Trim(Data) <> "" Then
			If Data <> io_Comprador.Nm_Usuario Then
				Return 1
			End If
		Else
			io_Comprador.of_Inicializa()
			
			This.Object.Nr_Matricula		[1] = io_Comprador.Nr_Matricula
			This.Object.Nm_Usuario		[1] = io_Comprador.Nm_Usuario
		End If
		
	Case "nm_fantasia"
		If Not IsNull(Data) And Trim(Data) <> "" Then
			If Data <> io_Filial.Nm_Fantasia Then
				Return 1
			End If
		Else
			io_Filial.of_Inicializa()
			
			This.Object.Cd_Filial		[1] = io_Filial.Cd_Filial
			This.Object.Nm_Fantasia	[1] = io_Filial.Nm_Fantasia
		End If
End Choose

dw_2.Reset()
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	If This.GetColumnName() = "nm_fornecedor" Then
		io_Fornecedor.of_Localiza_Fornecedor(This.GetText())
		
		If io_Fornecedor.Localizado Then
			This.Object.Cd_Fornecedor		[1]	= io_Fornecedor.Cd_Fornecedor
			This.Object.Nm_Fornecedor		[1]	= io_Fornecedor.Nm_Razao_Social
		Else
			io_Fornecedor.of_Inicializa()
		End If
	End If
	
	If This.GetColumnName() = "nm_usuario" Then
		io_Comprador.of_Localiza_Comprador(This.GetText())
		
		If io_Comprador.Localizado Then
			This.Object.Nr_Matricula	[1]	= io_Comprador.Nr_Matricula
			This.Object.Nm_Usuario	[1]	= io_Comprador.Nm_Usuario
		Else
			io_Comprador.of_Inicializa()
		End If
	End If
	
	If This.GetColumnName() = "nm_fantasia" Then
		io_Filial.of_Localiza_Filial(This.GetText())
		
		If io_Filial.Localizada Then
			This.Object.Cd_Filial		[1] = io_Filial.Cd_Filial
			This.Object.Nm_Fantasia	[1] = io_Filial.Nm_Fantasia
		Else
			io_Filial.of_Inicializa()
		End If
	End If
End If
end event

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case "nm_fornecedor"
		If Not IsNull(Data) And Trim(Data) <> "" Then
			If Data <> io_Fornecedor.Nm_Razao_Social Then
				Return 1
			End If
		Else
			io_Fornecedor.of_Inicializa()
			
			This.Object.Cd_Fornecedor		[1] = io_Fornecedor.Cd_Fornecedor
			This.Object.Nm_Fornecedor		[1] = io_Fornecedor.Nm_Razao_Social
		End If
		
	Case "nm_usuario"
		If Not IsNull(Data) And Trim(Data) <> "" Then
			If Data <> io_Comprador.Nm_Usuario Then
				Return 1
			End If
		Else
			io_Comprador.of_Inicializa()
			
			This.Object.Nr_Matricula		[1] = io_Comprador.Nr_Matricula
			This.Object.Nm_Usuario		[1] = io_Comprador.Nm_Usuario
		End If
		
	Case "nm_fantasia"
		If Not IsNull(Data) And Trim(Data) <> "" Then
			If Data <> io_Filial.Nm_Fantasia Then
				Return 1
			End If
		Else
			io_Filial.of_Inicializa()
			
			This.Object.Cd_Filial		[1] = io_Filial.Cd_Filial
			This.Object.Nm_Fantasia	[1] = io_Filial.Nm_Fantasia
		End If
End Choose
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge433_rel_pedido_atraso_fornecedor
integer y = 432
integer width = 5824
integer height = 1676
string dataobject = "dw_ge433_lista"
boolean hscrollbar = true
end type

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	ivo_Controle_Menu.of_SalvarComo(True)
Else
	ivo_Controle_Menu.of_SalvarComo(False)
End If

Return pl_Linhas
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;Long ll_Filial

String ls_Matricula
String ls_Fornecedor

dw_1.AcceptText()

ls_Fornecedor	= dw_1.Object.Cd_Fornecedor	[1]
ls_Matricula		= dw_1.Object.Nr_Matricula		[1]
ll_Filial			= dw_1.Object.Cd_Filial			[1]

If Not IsNull(ls_Fornecedor) And ls_Fornecedor <> "" Then
	This.of_AppendWhere("f.cd_fornecedor = '" + ls_Fornecedor + "'")
End If

If Not IsNull(ls_Matricula) And ls_Matricula <> "" Then
	This.of_AppendWhere("u.nr_matricula = '" + ls_Matricula + "'")
End If

If Not IsNull(ll_Filial) Then
	This.of_AppendWhere("a.cd_filial = " + String(ll_Filial))
End If

Return 1
end event

event dw_2::constructor;call super::constructor;String ls_Coluna[]
String ls_Nome[]
		 
ls_Coluna = {	"nr_pedido", &
              		"id_pbm", &
              		"dh_emissao", &
			  		"dh_previsao_entrega", &
			  		"cd_fornecedor", &
			  		"nm_razao_social", &
					"total_pedido", &
					"qt_dias_atraso", &
					"nr_matricula", &
					"nm_usuario", &
					"cd_filial", &
					"nm_fantasia"}	
				  
ls_Nome = {	"Pedido", &
            			"PBM", &
            			"Emiss$$HEX1$$e300$$ENDHEX$$o", &
					"Prev. Entrega", &
					"Fornecedor", &
					"Raz$$HEX1$$e300$$ENDHEX$$o Social", &
					"Total Pedido", &
					"Atraso", &
					"Matr$$HEX1$$ed00$$ENDHEX$$cula", &
					"Comprador", &
					"Filial", &
					"Nome Fantasia"}
			
This.of_SetFilter(ls_Coluna, ls_Nome)
This.of_SetSort(ls_Coluna, ls_Nome)

This.ivb_Ordena_Colunas = True
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge433_rel_pedido_atraso_fornecedor
integer x = 809
integer y = 712
end type

