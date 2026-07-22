HA$PBExportHeader$w_ge436_aprovacao_produto.srw
forward
global type w_ge436_aprovacao_produto from dc_w_selecao_lista_detalhe
end type
end forward

global type w_ge436_aprovacao_produto from dc_w_selecao_lista_detalhe
integer width = 4238
integer height = 2240
string title = "GE436 - Aprova$$HEX2$$e700e300$$ENDHEX$$o do Cadastro do Produto"
end type
global w_ge436_aprovacao_produto w_ge436_aprovacao_produto

type variables
uo_produto io_Produto //ge001
end variables

on w_ge436_aprovacao_produto.create
call super::create
end on

on w_ge436_aprovacao_produto.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;dw_1.Object.Dh_Registro_Fim		[1] = Date(gf_GetServerDate())
dw_1.Object.Dh_Registro_Inicio	[1] = RelativeDate(Date(dw_1.Object.Dh_Registro_Fim[1]), -7)
end event

event close;call super::close;Destroy(io_Produto)
end event

event ue_preopen;call super::ue_preopen;io_Produto = Create uo_produto
end event

type dw_visual from dc_w_selecao_lista_detalhe`dw_visual within w_ge436_aprovacao_produto
integer x = 37
integer y = 1008
end type

type gb_aux_visual from dc_w_selecao_lista_detalhe`gb_aux_visual within w_ge436_aprovacao_produto
integer x = 0
integer y = 936
end type

type gb_3 from dc_w_selecao_lista_detalhe`gb_3 within w_ge436_aprovacao_produto
integer y = 1356
integer width = 4110
integer height = 664
integer weight = 700
end type

type gb_1 from dc_w_selecao_lista_detalhe`gb_1 within w_ge436_aprovacao_produto
integer width = 2807
integer height = 340
integer weight = 700
end type

type gb_2 from dc_w_selecao_lista_detalhe`gb_2 within w_ge436_aprovacao_produto
integer y = 376
integer width = 4110
integer height = 972
integer weight = 700
string text = "Produtos"
end type

type dw_1 from dc_w_selecao_lista_detalhe`dw_1 within w_ge436_aprovacao_produto
integer x = 64
integer width = 2752
string dataobject = "dw_ge436_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;dw_2.Event ue_Reset()
dw_3.Event ue_Reset()

Choose Case dwo.Name
	Case "nm_produto"
		If Not IsNull(Data) and Data <> "" Then
			If Data <> io_Produto.ivs_Descricao_Apresentacao_Venda Then
				Return 1
			End If
		Else
			io_Produto.of_Inicializa()
			
			This.Object.Cd_Produto	[1] = io_Produto.Cd_Produto
			This.Object.Nm_Produto	[1] = io_Produto.ivs_Descricao_Apresentacao_Venda
		End If
End Choose
end event

event dw_1::editchanged;call super::editchanged;dw_2.Event ue_Reset()
dw_3.Event ue_Reset()

Choose Case dwo.Name
	Case "nm_produto"
		If Not IsNull(Data) and Data <> "" Then
			If Data <> io_Produto.ivs_Descricao_Apresentacao_Venda Then
				Return 1
			End If
		Else
			io_Produto.of_Inicializa()
			
			This.Object.Cd_Produto	[1] = io_Produto.Cd_Produto
			This.Object.Nm_Produto	[1] = io_Produto.ivs_Descricao_Apresentacao_Venda
		End If
End Choose
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	If GetColumnName() = "nm_produto" Then
		io_Produto.of_Localiza_Produto(This.GetText())
		
		If io_Produto.Localizado Then
			This.Object.Cd_Produto	[1] = io_Produto.Cd_Produto
			This.Object.Nm_Produto	[1] = io_Produto.De_Produto + " : " + io_Produto.De_Apresentacao_Venda
		Else
			io_Produto.of_Inicializa()
		End If
	End If
End If
end event

type dw_2 from dc_w_selecao_lista_detalhe`dw_2 within w_ge436_aprovacao_produto
integer y = 452
integer width = 4046
integer height = 864
string dataobject = "dw_ge436_lista"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;DateTime ldh_Inicio
DateTime ldh_Fim

Long ll_Produto

String ls_Incl_Alter

dw_1.AcceptText()

ldh_Inicio	= Datetime(dw_1.Object.Dh_Registro_Inicio	[1], Time('00:00:00'))
ldh_Fim		= Datetime(dw_1.Object.Dh_Registro_Fim	[1], Time('23:59:59'))
ll_Produto	= dw_1.Object.Cd_Produto						[1]
ls_Incl_Alter	= dw_1.Object.Id_Inclusao_Alteracao			[1]


If IsNull(ldh_Inicio) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio.")
	dw_1.Event ue_Pos(1, "dh_registro_inicio")
	Return -1
End If

If IsNull(ldh_Fim) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino.")
	dw_1.Event ue_Pos(1, "dh_registro_fim")
	Return -1
End If

If ldh_Inicio > ldh_Fim Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a data de t$$HEX1$$e900$$ENDHEX$$rmino.")
	dw_1.Event ue_Pos(1, "dh_registro_inicio")
	Return -1
End If

This.of_AppendWhere("a.dh_registro >= '" + String(ldh_Inicio, "yyyymmdd hh:mm:ss") + "' and a.dh_registro <= '" + String(ldh_Fim, "yyyymmdd hh:mm:ss") + "'")

If ll_Produto > 0 And Not IsNull(ll_Produto) Then
	This.of_AppendWhere("a.cd_produto = " + String(ll_Produto))
End If

If ls_Incl_Alter <> "T" Then
	This.of_AppendWhere("a.id_inclusao_alteracao = '" + ls_Incl_Alter + "'")
End If

This.SetFilter( '' )
This.Filter( )

This.SetRedraw( False )

Return 1
end event

event dw_2::constructor;call super::constructor;This.ivb_Ordena_Colunas = True
end event

event dw_2::editchanged;call super::editchanged;dw_3.Event ue_Reset()
end event

event dw_2::itemchanged;call super::itemchanged;dw_3.Event ue_Reset()
end event

event dw_2::rowfocuschanged;call super::rowfocuschanged;If CurrentRow > 0 Then	
	dw_3.Object.Dh_Registro						[1] = dw_2.Object.Dh_Registro							[CurrentRow]
	dw_3.Object.Nm_Usuario_Registro			[1] = dw_2.Object.Nm_Usuario							[CurrentRow]
	dw_3.Object.Dh_Aprovacao_Ecommerce		[1] = dw_2.Object.Dh_Aprovacao_Ecommerce		[CurrentRow]
	dw_3.Object.Nm_Usuario_Eco					[1] = dw_2.Object.Nm_Usuario_Eco					[CurrentRow]
	dw_3.Object.Dh_Aprovacao_Farmaceutico	[1] = dw_2.Object.Dh_Aprovacao_Farmaceutico	[CurrentRow]
	dw_3.Object.Nm_Usuario_Farm				[1] = dw_2.Object.Nm_Usuario_Farm				[CurrentRow]
	dw_3.Object.Dh_Aprovacao_Fiscal				[1] = dw_2.Object.Dh_Aprovacao_Fiscal				[CurrentRow]
	dw_3.Object.Nm_Usuario_Fiscal				[1] = dw_2.Object.Nm_Usuario_Fiscal				[CurrentRow]
	dw_3.Object.Dh_Aprovacao_Price				[1] = dw_2.Object.Dh_Aprovacao_Price				[CurrentRow]
	dw_3.Object.Nm_Usuario_Price				[1] = dw_2.Object.Nm_Usuario_Price					[CurrentRow]
	
	dw_3.Object.gb_1.Visible = True
	dw_3.Object.gb_2.Visible = True
	dw_3.Object.gb_3.Visible = True
	dw_3.Object.gb_4.Visible = True
	dw_3.Object.gb_5.Visible = True
End If
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;String ls_Tipo

String ls_Filtro

dw_1.AcceptText()

If pl_Linhas > 0 Then
	
	ls_Tipo = dw_1.Object.Id_Tipo[1]
	
	If ls_Tipo = "S" Then

		ls_Filtro = "(id_inclusao_alteracao = 'I' and (isnull(dh_aprovacao_fiscal) or isnull(dh_aprovacao_price) or isnull(dh_aprovacao_farmaceutico) or isnull(dh_aprovacao_ecommerce)))" + &
		" or (id_inclusao_alteracao = 'A' and (isnull(dh_aprovacao_fiscal) or isnull(dh_aprovacao_price)))"
	
		This.SetFilter( ls_Filtro )
		This.Filter( )
		
		dw_3.Event ue_Reset()
		dw_3.Event ue_AddRow()
		dw_3.Event RowFocusChanged(1)
	End If
End If

This.SetRedraw( True )
This.Sort()

Return pl_Linhas
end event

type dw_3 from dc_w_selecao_lista_detalhe`dw_3 within w_ge436_aprovacao_produto
integer y = 1424
integer width = 4050
integer height = 588
string dataobject = "dw_ge436_detalhe"
end type

event dw_3::ue_recuperar;//OverRide

Return 1
end event

