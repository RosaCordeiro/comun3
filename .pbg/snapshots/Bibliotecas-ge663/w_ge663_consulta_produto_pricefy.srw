HA$PBExportHeader$w_ge663_consulta_produto_pricefy.srw
forward
global type w_ge663_consulta_produto_pricefy from dc_w_2tab_consulta_selecao_lista_det
end type
type dw_4 from datawindow within tabpage_1
end type
end forward

global type w_ge663_consulta_produto_pricefy from dc_w_2tab_consulta_selecao_lista_det
integer width = 4507
integer height = 3184
end type
global w_ge663_consulta_produto_pricefy w_ge663_consulta_produto_pricefy

type variables
uo_filial	ivo_filial
uo_produto	ivo_produto

end variables

on w_ge663_consulta_produto_pricefy.create
int iCurrent
call super::create
end on

on w_ge663_consulta_produto_pricefy.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;Destroy(ivo_Filial) 
Destroy(ivo_Produto)

end event

event open;call super::open;ivo_Produto		= Create uo_Produto
ivo_Filial		= Create uo_Filial


end event

type dw_visual from dc_w_2tab_consulta_selecao_lista_det`dw_visual within w_ge663_consulta_produto_pricefy
end type

type gb_aux_visual from dc_w_2tab_consulta_selecao_lista_det`gb_aux_visual within w_ge663_consulta_produto_pricefy
end type

type tab_1 from dc_w_2tab_consulta_selecao_lista_det`tab_1 within w_ge663_consulta_produto_pricefy
integer width = 4361
integer height = 2936
end type

type tabpage_1 from dc_w_2tab_consulta_selecao_lista_det`tabpage_1 within tab_1
integer width = 4325
integer height = 2820
dw_4 dw_4
end type

on tabpage_1.create
this.dw_4=create dw_4
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_4
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_4)
end on

type gb_2 from dc_w_2tab_consulta_selecao_lista_det`gb_2 within tabpage_1
integer y = 320
integer width = 4242
integer height = 2460
end type

type gb_1 from dc_w_2tab_consulta_selecao_lista_det`gb_1 within tabpage_1
integer width = 1975
integer height = 304
end type

type dw_1 from dc_w_2tab_consulta_selecao_lista_det`dw_1 within tabpage_1
integer width = 1906
integer height = 204
string dataobject = "dw_ge663_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case "nm_filial"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Filial.Nm_Fantasia Then
				Return 1
			End If
		Else
			ivo_Filial.of_Inicializa()
			
			This.Object.Cd_Filial[1] = ivo_Filial.cd_Filial
			This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
		End If
		
	Case "nm_fantasia"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Filial.Nm_Fantasia Then
				Return 1
			End If
		Else
			ivo_Filial.of_Inicializa()
			
			This.Object.Cd_Filial[1]	= ivo_Filial.Cd_Filial
			This.Object.Nm_Fantasia[1] = ivo_Filial.Nm_Fantasia
		End If
	
End Choose

dw_2.Event ue_Reset()
end event

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)
end event

event dw_1::editchanged;call super::editchanged;Choose Case dwo.Name
	Case "nm_filial"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Filial.Nm_Fantasia Then
				Return 1
			End If
		Else
			ivo_Filial.of_Inicializa()
			
			This.Object.Cd_Filial[1] = ivo_Filial.cd_Filial
			This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
		End If
		
	Case "nm_fantasia"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Filial.Nm_Fantasia Then
				Return 1
			End If
		Else
			ivo_Filial.of_Inicializa()
			
			This.Object.Cd_Filial[1]	= ivo_Filial.Cd_Filial
			This.Object.Nm_Fantasia[1] = ivo_Filial.Nm_Fantasia
		End If
	
End Choose

dw_2.Event ue_Reset()
end event

event dw_1::ue_key;call super::ue_key;String lvs_Coluna
String ls_Grupo

If Key = KeyEnter! Then
	lvs_Coluna = This.GetColumnName()
	
	Choose Case lvs_Coluna
		Case "nm_fantasia"
			ivo_Filial.of_Localiza_Filial(This.GetText())
			
			If ivo_Filial.Localizada Then
				dw_1.Object.Cd_Filial[1]	= ivo_Filial.Cd_Filial
				dw_1.Object.Nm_Fantasia[1] = ivo_Filial.Nm_Fantasia
			End If
			
		Case "de_produto"
			ivo_Produto.of_Localiza_Produto(This.GetText())
			
			If ivo_Produto.Localizado Then
				dw_1.Object.Cd_Produto				[1] = ivo_Produto.Cd_Produto
				dw_1.Object.De_Produto				[1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
				
			End If
	End Choose
End If

//If Key = KeyF4! Then
//	Event ue_Consulta_Filial()
//End If
end event

type dw_2 from dc_w_2tab_consulta_selecao_lista_det`dw_2 within tabpage_1
integer y = 388
integer width = 3488
integer height = 1088
string dataobject = "dw_ge663_lista_produto_descricao"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;Long	lvl_cd_Produto
Long	lvs_cd_Filial
Long ll_lista_produto[]

dw_1.AcceptText()

lvs_cd_Filial		= dw_1.Object.cd_filial		[1]
lvl_cd_Produto		= dw_1.Object.cd_Produto	[1]

//validar se vai precisar

//If lvs_cd_Filial > 0 Then
//	This.of_appendwhere("xx.cd_filial = " + string(lvs_cd_Filial) + " ")
//Else
//End If

//testar
//If lvl_cd_Produto > 0 Then
//	This.of_appendwhere("pg.cd_produto = " + string(lvl_cd_produto) + " ")
//End If

//If lvl_cd_Produto > 0 Then
//	This.of_appendwhere_subquery("pg.cd_produto = " + string(lvl_cd_produto) + " ",1)
//End If



//
//uo_ge663_api_pricefy = CREATE uo_ge663_api_pricefy
//
//
//If lvl_cd_Produto > 0 Then
////	This.of_appendwhere_subquery("pg.cd_produto = " + string(lvl_cd_produto) + " ",1)
//Else
//	uo_ge663_api_pricefy.of_principal(ref ll_lista_produto)
//End If

Return 1
end event

event dw_2::ue_retrieve;call super::ue_retrieve;	Long ll_lista_produto[]

	uo_ge663_api_pricefy = CREATE uo_ge663_api_pricefy

	uo_ge663_api_pricefy.of_principal(ll_lista_produto)
	
	//Recupera os dados da data source
    dc_uo_ds_base lvds_1
    lvds_1 = Create dc_uo_ds_base
    lvds_1.Of_ChangeDataObject('dw_ge663_lista_produto_descricao')
	// lvds_1.Retrieve(ll_lista_produto)
    lvds_1.Retrieve(748993)
	
	Return 1
end event

type tabpage_2 from dc_w_2tab_consulta_selecao_lista_det`tabpage_2 within tab_1
integer width = 4325
integer height = 2820
end type

type gb_3 from dc_w_2tab_consulta_selecao_lista_det`gb_3 within tabpage_2
integer width = 3721
integer height = 2472
end type

type dw_3 from dc_w_2tab_consulta_selecao_lista_det`dw_3 within tabpage_2
integer width = 3634
integer height = 2340
string dataobject = "dw_ge663_detalhe_produto"
end type

type dw_4 from datawindow within tabpage_1
integer x = 69
integer y = 1648
integer width = 3936
integer height = 624
integer taborder = 40
boolean bringtotop = true
string title = "none"
string dataobject = "dw_ge663_detalhe_promocoes"
boolean livescroll = true
borderstyle borderstyle = styleraised!
end type

