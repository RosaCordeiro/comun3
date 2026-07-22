HA$PBExportHeader$w_ge081_relatorio_produto_desc_clube.srw
forward
global type w_ge081_relatorio_produto_desc_clube from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge081_relatorio_produto_desc_clube from dc_w_selecao_lista_relatorio
integer width = 2880
integer height = 2048
string title = "GE081 - Relat$$HEX1$$f300$$ENDHEX$$rio de Produtos com Desconto do Clube"
end type
global w_ge081_relatorio_produto_desc_clube w_ge081_relatorio_produto_desc_clube

type variables
uo_filial ivo_filial
end variables

forward prototypes
public function boolean wf_atualiza_desconto_clube (long pl_linhas)
end prototypes

public function boolean wf_atualiza_desconto_clube (long pl_linhas);Long 	lvl_Filial,&
		lvl_Produto,&
		lvl_Linha

dw_1.AcceptText()

lvl_Filial = dw_1.Object.cd_filial[1]

SetPointer(HourGlass!)

Open(w_Aguarde)

w_Aguarde.Title = "Aguarde atualizando o desconto do clube ..."

w_Aguarde.uo_Progress.of_SetMax(pl_Linhas)

uo_Produto lvo_Produto 

lvo_Produto = Create uo_Produto

For lvl_Linha = 1 To pl_Linhas
	
	lvl_Produto = dw_2.Object.cd_produto[lvl_Linha]
	
	lvo_Produto.of_Localiza_Codigo_Interno(lvl_Produto)
			
	If lvo_Produto.Localizado Then
		dw_2.Object.pc_desconto_clube_atual[lvl_Linha] =  lvo_Produto.of_Desconto_Clube_Filial(lvl_Filial)
	End If
	
	w_Aguarde.uo_Progress.of_SetProgress(lvl_Linha)
	
Next

Destroy(lvo_Produto)

Close(w_Aguarde)

SetPointer(Arrow!)

Return True
end function

on w_ge081_relatorio_produto_desc_clube.create
call super::create
end on

on w_ge081_relatorio_produto_desc_clube.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;Destroy ivo_filial
end event

event ue_postopen;// OverRide

ivo_dbError = Create dc_uo_dbError

dw_1.Event ue_AddRow()
dw_1.SetFocus()

This.ivm_Menu.mf_Recuperar(True)

ivm_Menu.ivb_Permite_Imprimir = True

ivo_filial = Create uo_filial
end event

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge081_relatorio_produto_desc_clube
integer y = 228
integer width = 2770
integer height = 1608
integer weight = 700
string facename = "Verdana"
string text = "Produtos com Desconto no Clube"
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge081_relatorio_produto_desc_clube
integer width = 1641
integer height = 184
integer weight = 700
string facename = "Verdana"
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge081_relatorio_produto_desc_clube
integer x = 55
integer y = 80
integer width = 1609
integer height = 92
string dataobject = "dw_ge081_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;If dwo.Name = "nm_filial" Then
	If Not IsNull(Data) and Trim(Data) <> "" Then
		If Data <> ivo_Filial.nm_fantasia Then
			Return 1
		End If
	Else
		ivo_Filial.of_Inicializa()
		
		This.Object.cd_Filial[1] = ivo_Filial.cd_filial
		This.Object.nm_Filial[1] = ivo_Filial.nm_fantasia
	End If
	
End If
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Filial) Then
	This.Object.Cd_Filial[1] = ivo_Filial.cd_filial
	This.Object.Nm_Filial[1] = ivo_Filial.nm_fantasia
End If
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	If This.GetColumnName() = "nm_filial" Then
		ivo_Filial.of_Localiza_Filial(This.GetText())
		
		If ivo_Filial.Localizada Then
			This.Object.cd_filial[1]  = ivo_Filial.cd_filial
			This.Object.nm_filial[1]  = ivo_Filial.nm_fantasia
		End If
	End If
End If
	
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge081_relatorio_produto_desc_clube
integer x = 78
integer y = 296
integer width = 2706
integer height = 1504
string dataobject = "dw_ge081_lista"
end type

event dw_2::ue_recuperar;// OverRide

Date lvdt_Hoje

String	lvs_DW,&
		lvs_DW_Relatorio

Long lvl_Filial

dw_1.AcceptText()

lvl_Filial = dw_1.Object.cd_filial[1]

If IsNull(lvl_Filial) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a filial.")
	dw_1.Event ue_Pos(1, "nm_filial")
	Return -1
End If

lvdt_Hoje = Date(gf_GetServerDate())

// Desenvolvimento
//lvdt_Hoje = Date("01/09/2013")

If lvdt_Hoje < Date('01/09/2013') Then
	lvs_DW 				= "dw_ge081_lista"
	lvs_DW_Relatorio 	= "dw_ge081_relatorio"
Else
	lvs_DW 				= "dw_ge081_lista_produto_filial"
	lvs_DW_Relatorio 	= "dw_ge081_relatorio_produto_filial"
End If

If This.of_ChangeDataObject(lvs_DW) Then
	dw_3.of_ChangeDataObject(lvs_DW_Relatorio)
	This.ShareData(dw_3)
	This.of_SetRowSelection()
	Return This.Retrieve(lvl_Filial)
Else
	Return -1 
End If


end event

event dw_2::ue_postretrieve;//OverRide
Boolean	lvb_Classificar, &
        		lvb_Filtrar, &
		  	lvb_Localizar, &
		  	lvb_Imprimir

If pl_Linhas > 0 Then
	lvb_Classificar = IsValid(This.ivo_Sort)
	lvb_Filtrar     = IsValid(This.ivo_Filter)
	lvb_Localizar   = IsValid(This.ivo_Find)
	
	If This.DataObject = "dw_ge081_lista_produto_filial" Then
		wf_Atualiza_Desconto_Clube(pl_Linhas)
	End If
	
	lvb_Imprimir = True

	This.Event RowFocusChanged(1)
	This.SetRow(1)
	This.SetFocus()
Else
	If pl_Linhas = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.", Information!)
	End If
End If

Parent.ivm_Menu.mf_Classificar(lvb_Classificar)
Parent.ivm_Menu.mf_Filtrar(lvb_Filtrar)
Parent.ivm_Menu.mf_Localizar(lvb_Localizar)
Parent.ivm_Menu.mf_Imprimir(lvb_Imprimir)
Parent.ivm_Menu.mf_salvarcomo( lvb_Imprimir)

Return pl_Linhas
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge081_relatorio_produto_desc_clube
integer x = 1989
integer y = 28
integer height = 152
string dataobject = "dw_ge081_relatorio"
end type

