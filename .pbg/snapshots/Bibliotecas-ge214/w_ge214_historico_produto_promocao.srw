HA$PBExportHeader$w_ge214_historico_produto_promocao.srw
forward
global type w_ge214_historico_produto_promocao from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge214_historico_produto_promocao from dc_w_selecao_lista_relatorio
integer width = 3337
string title = "GE214 - Hist$$HEX1$$f300$$ENDHEX$$rico de Produto Promo$$HEX2$$e700e300$$ENDHEX$$o"
end type
global w_ge214_historico_produto_promocao w_ge214_historico_produto_promocao

type variables
uo_Produto	io_Produto	//GE001
uo_Filial		io_Filial		//GE009
end variables

on w_ge214_historico_produto_promocao.create
call super::create
end on

on w_ge214_historico_produto_promocao.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;io_Produto	= Create uo_Produto
io_Filial		= Create uo_Filial
end event

event close;call super::close;Destroy(io_Produto)
Destroy(io_Filial)
end event

event ue_postopen;call super::ue_postopen;DateTime ldh_Periodo

dw_1.AcceptText()

If Not gf_Data_Parametro(Ref ldh_Periodo) Then
	Return
End If

ldh_Periodo = DateTime(RelativeDate(Date(ldh_Periodo), - 30))

dw_1.Object.Dh_Inicio[1] = ldh_Periodo
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge214_historico_produto_promocao
integer x = 37
integer y = 808
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge214_historico_produto_promocao
integer x = 0
integer y = 736
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge214_historico_produto_promocao
integer width = 3227
integer height = 1008
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge214_historico_produto_promocao
integer width = 1920
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge214_historico_produto_promocao
integer width = 1851
string dataobject = "dw_ge214_selecao"
end type

event dw_1::ue_key;call super::ue_key;This.AcceptText( )

If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "de_produto"
			io_Produto.of_Localiza_Produto(This.GetText())
			
			If io_Produto.Localizado Then
				This.Object.Cd_Produto	[1] = io_Produto.Cd_Produto
				This.Object.De_Produto	[1] = io_Produto.ivs_Descricao_Apresentacao_Venda
			Else			
				io_Produto.of_Inicializa()			
				
				This.Object.Cd_Produto	[1] = io_Produto.Cd_Produto
				This.Object.De_Produto	[1] = io_Produto.ivs_Descricao_Apresentacao_Venda
			End If
			
		Case 'nm_fantasia'
			io_Filial.of_Localiza_Filial(This.GetText())
			
			If io_Filial.Localizada Then
				This.Object.Cd_Filial		[1] = io_Filial.Cd_Filial
				This.Object.Nm_Fantasia	[1] = io_Filial.Nm_Fantasia
			Else
				io_Filial.of_Inicializa()
				
				This.Object.Cd_Filial		[1] = io_Filial.Cd_Filial
				This.Object.Nm_Fantasia	[1] = io_Filial.Nm_Fantasia
			End If
	End Choose
End If

dw_2.Event ue_Reset()
end event

event dw_1::editchanged;call super::editchanged;Choose Case dwo.Name
	Case "de_produto"
		If Trim(Data) <> "" Then
			If Data <> io_Produto.ivs_Descricao_Apresentacao_Venda Then
				Return 1
			End If	
		Else			
			io_Produto.of_Inicializa()			
			
			This.Object.Cd_Produto	[1] = io_Produto.Cd_Produto
			This.Object.De_Produto	[1] = io_Produto.ivs_Descricao_Apresentacao_Venda
		End If
		
	Case "nm_fantasia"
		If Trim(Data) <> "" Then
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

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case "de_produto"
		If Trim(Data) <> "" Then
			If Data <> io_Produto.ivs_Descricao_Apresentacao_Venda Then
				Return 1
			End If	
		Else			
			io_Produto.of_Inicializa()			
			
			This.Object.Cd_Produto	[1] = io_Produto.Cd_Produto
			This.Object.De_Produto	[1] = io_Produto.ivs_Descricao_Apresentacao_Venda
		End If
		
	Case "nm_fantasia"			
		If Trim(Data) <> "" Then
			If Data <> io_Filial.Nm_Fantasia Then
				Return 1
			End If	
		Else			
			io_Filial.of_Inicializa()			
			
			This.Object.Cd_Filial		[1] = io_Filial.Cd_Filial
			This.Object.Nm_Fantasia	[1] = io_Filial.Nm_Fantasia
		End If		
End Choose

dw_2.Event ue_Reset()
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge214_historico_produto_promocao
integer width = 3159
integer height = 908
string dataobject = "dw_ge214_lista"
end type

event dw_2::ue_recuperar;//OverRide

DateTime ldh_Inicio

Long ll_Produto
Long ll_Filial

dw_1.AcceptText()

ldh_Inicio	= dw_1.Object.Dh_Inicio		[1]
ll_Produto	= dw_1.Object.Cd_Produto	[1]
ll_Filial		= dw_1.Object.Cd_Filial		[1]

If IsNull(ldh_Inicio) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio.", Exclamation!)
	dw_1.Event ue_Pos(1, "dh_inicio")
	Return -1
End If

If IsNull(ll_Produto) Or ll_Produto = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o produto.", Exclamation!)
	dw_1.Event ue_Pos(1, "de_produto")
	Return -1
End If

If Not IsNull(ll_Filial) And ll_Filial > 0 Then
	This.of_AppendWhere("f.cd_filial = " + String(ll_Filial))
End If

Return This.Retrieve(ll_Produto, ldh_Inicio)
end event

event dw_2::constructor;call super::constructor;This.ivb_Ordena_Colunas = True
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	dw_2.ivo_Controle_Menu.of_SalvarComo(True)
Else
	dw_2.ivo_Controle_Menu.of_SalvarComo(False)
End If

Return pl_Linhas
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge214_historico_produto_promocao
integer x = 2377
integer y = 56
end type

