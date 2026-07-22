HA$PBExportHeader$w_ge172_selecao_fornecedores.srw
forward
global type w_ge172_selecao_fornecedores from dc_w_response
end type
type gb_1 from groupbox within w_ge172_selecao_fornecedores
end type
type dw_1 from dc_uo_dw_base within w_ge172_selecao_fornecedores
end type
type cb_1 from commandbutton within w_ge172_selecao_fornecedores
end type
type cb_2 from commandbutton within w_ge172_selecao_fornecedores
end type
type cb_3 from commandbutton within w_ge172_selecao_fornecedores
end type
type cb_4 from commandbutton within w_ge172_selecao_fornecedores
end type
end forward

global type w_ge172_selecao_fornecedores from dc_w_response
string tag = "w_ge172_selecao_fornecedores"
integer width = 2510
integer height = 1460
string title = "GE172 - Sele$$HEX2$$e700e300$$ENDHEX$$o de Fornecedores"
boolean controlmenu = false
long backcolor = 80269524
gb_1 gb_1
dw_1 dw_1
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
cb_4 cb_4
end type
global w_ge172_selecao_fornecedores w_ge172_selecao_fornecedores

type variables
uo_Fornecedor ivo_Fornecedor
uo_ge229_selecao_prd_personalizado ivo_Selecao
end variables

on w_ge172_selecao_fornecedores.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.dw_1=create dw_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cb_4=create cb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.cb_3
this.Control[iCurrent+6]=this.cb_4
end on

on w_ge172_selecao_fornecedores.destroy
call super::destroy
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_4)
end on

event ue_postopen;call super::ue_postopen;ivo_Fornecedor	= Create uo_Fornecedor
ivo_Selecao = Message.PowerObjectParm

Long lvl_Linha, &
	  lvl_Row
	  
String lvs_Id_Tipo_Selecao, &
		 lvs_De_Grupo, &
		 lvs_De_Selecao

If IsValid(ivo_Selecao.ivds_Selecao) Then
	For lvl_Linha = 1 To ivo_Selecao.ivds_Selecao.RowCount()
		lvs_Id_Tipo_Selecao = String(ivo_Selecao.ivds_Selecao.Object.Id_Tipo_Selecao[lvl_Linha])
		
		If lvs_Id_Tipo_Selecao = '7' Then
			lvs_De_Selecao = ivo_Selecao.ivds_Selecao.Object.De_Selecao[lvl_Linha]
			ivo_Fornecedor.of_Localiza_Fornecedor(lvs_De_Selecao)
			 
			lvl_Row = dw_1.InsertRow(0)
			dw_1.Object.De_Selecao 		[lvl_Row] = ivo_Fornecedor.Cd_Fornecedor
			dw_1.Object.Nm_Razao_Social[lvl_Row] = ivo_Fornecedor.Nm_Razao_Social
			dw_1.Object.Nr_Cgc 			[lvl_Row] = ivo_Fornecedor.Nr_Cgc
		End If
	Next
End If

dw_1.Event ue_AddRow()
end event

event close;call super::close;Destroy(ivo_Fornecedor)
end event

type pb_help from dc_w_response`pb_help within w_ge172_selecao_fornecedores
end type

type gb_1 from groupbox within w_ge172_selecao_fornecedores
integer x = 27
integer width = 2414
integer height = 1220
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

type dw_1 from dc_uo_dw_base within w_ge172_selecao_fornecedores
event ue_valida_dados ( )
integer x = 50
integer y = 52
integer width = 2363
integer height = 1144
boolean bringtotop = true
string dataobject = "dw_ge172_fornecedor"
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event ue_valida_dados;Long lvl_Linha
/*
For lvl_Linha = 1 To This.RowCount()
	If IsNull(This.Object.Cd_Convenio[lvl_Linha]) Then
		This.DeleteRow(lvl_Linha)
	End If
Next
*/
end event

event constructor;call super::constructor;This.of_SetRowSelection()
end event

event ue_key;String lvs_Texto

Long lvl_Row, &
	  lvl_Linha, &
	  lvl_Find, &
	  lvl_Rows_Ds

This.AcceptText()

If Key = KeyEnter! Then
	
	lvs_Texto = This.GetText()
	lvl_Row   = This.GetRow()
	
	If This.GetColumnName() = "nm_razao_social" Then
		ivo_Fornecedor.of_Localiza_Fornecedor(lvs_Texto)
		
		If ivo_Fornecedor.Localizado Then
			lvl_Find = This.Find("de_selecao = '" + ivo_Fornecedor.Cd_Fornecedor + "'", 1, This.RowCount() )
			
			If  lvl_Find > 0 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O fornecedor selecionado j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ na rela$$HEX2$$e700e300$$ENDHEX$$o.")
				ivo_Fornecedor.of_Inicializa()
				
				This.Object.Nm_Razao_Social[lvl_Row] = ""
			Else
				This.Object.De_Selecao [lvl_Row] = ivo_Fornecedor.Cd_Fornecedor
				This.Object.Nm_Razao_Social[lvl_Row] = ivo_Fornecedor.Nm_Razao_Social
				This.Object.Nr_Cgc     [lvl_Row] = ivo_Fornecedor.Nr_Cgc
				
				lvl_Rows_Ds = ivo_Selecao.ivds_Selecao.InsertRow(0)
				ivo_Selecao.ivds_Selecao.Object.Cd_Consulta	  [lvl_Rows_Ds] = 0
				ivo_Selecao.ivds_Selecao.Object.Id_Tipo_Selecao[lvl_Rows_Ds] = 7
				ivo_Selecao.ivds_Selecao.Object.De_Selecao	  [lvl_Rows_Ds] = ivo_Fornecedor.Cd_Fornecedor
	
			End If
		End If
	
		This.Event ue_AddRow()

	End If
	
End If
end event

event losefocus;call super::losefocus;Long lvl_Linhas, &
	  lvl_Row

lvl_Linhas = This.RowCount()
lvl_Row 	  = This.GetRow()

If lvl_Linhas = 0 Then Return

//If IsValid(ivo_Fornecedor) Then
//	If IsNull(This.Object.De_Selecao[lvl_Linhas]) And lvl_Row = lvl_Linhas Then
//		This.Object.De_Selecao	   [lvl_Row] = ivo_Fornecedor.Cd_Fornecedor
//		This.Object.Nm_Razao_Social[lvl_Row] = ivo_Fornecedor.Nm_Razao_Social
//		This.Object.Nr_Cgc    		[lvl_Row] = ivo_Fornecedor.Nr_Cgc
//	End If
//End If
end event

event itemchanged;call super::itemchanged;Long lvl_Linha

If dwo.Name = "nm_razao_social" Then
	If Not IsNull(Data) and Trim(Data) <> "" Then
		If Data <> ivo_Fornecedor.Nm_Razao_Social Then
			Return 1
		End If
	Else
		ivo_Fornecedor.of_Inicializa()
		
		This.Object.De_Selecao [GetRow()] = ivo_Fornecedor.Cd_Fornecedor
		This.Object.Nm_Razao_Social[GetRow()] = ivo_Fornecedor.Nm_Razao_Social
		This.Object.Nr_Cgc 	  [GetRow()] = ivo_Fornecedor.Nr_Cgc
				
	End If
End If
end event

event ue_preinsertrow;call super::ue_preinsertrow;If IsValid(ivo_Fornecedor) Then
	ivo_Fornecedor.of_Inicializa()
End If

If This.RowCount() > 0 Then
	If IsNull(This.Object.De_Selecao[RowCount()]) Then Return -1
End If

Return 1
end event

type cb_1 from commandbutton within w_ge172_selecao_fornecedores
integer x = 1778
integer y = 1244
integer width = 325
integer height = 96
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&OK"
end type

event clicked;Long lvl_Linha, &
	  lvl_Rows_Ds, &
	  lvl_InsertRow, &
	  lvl_Find

dc_uo_ds_base lvds_1

lvds_1 = ivo_Selecao.ivds_Selecao

lvl_Rows_Ds = lvds_1.RowCount()

lvl_Find = lvds_1.Find("id_tipo_selecao = 7", 1, lvl_Rows_Ds)

Do While lvl_Find > 0
	lvds_1.DeleteRow(lvl_Find)
	lvl_Find = lvds_1.Find("id_tipo_selecao = 7", lvl_Find, lvl_Rows_Ds)
Loop
	
For lvl_Linha = 1 To dw_1.RowCount()
	
	If Not IsNull(dw_1.Object.De_Selecao[lvl_Linha]) Then
		lvl_InsertRow = lvds_1.InsertRow(0)
		lvds_1.Object.Id_Tipo_Selecao[lvl_InsertRow] = 7
		lvds_1.Object.De_Selecao     [lvl_InsertRow] = dw_1.Object.De_Selecao[lvl_Linha]
	Else
		If dw_1.RowCount() = 1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione pelo menos um fornecedor.")
			dw_1.Event ue_Pos(1, "nm_razao_social")
			Return -1
		End If
	End If
Next

CloseWithReturn(Parent, ivo_Selecao)
end event

event getfocus;dw_1.Event ue_valida_dados()
end event

type cb_2 from commandbutton within w_ge172_selecao_fornecedores
integer x = 1033
integer y = 1244
integer width = 320
integer height = 96
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Incluir"
end type

event clicked;dw_1.Event ue_AddRow()
end event

type cb_3 from commandbutton within w_ge172_selecao_fornecedores
integer x = 1371
integer y = 1244
integer width = 320
integer height = 96
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "E&xcluir"
end type

event clicked;dw_1.DeleteRow(dw_1.GetRow())

If dw_1.RowCount() = 0 Then dw_1.Event ue_AddRow()
end event

type cb_4 from commandbutton within w_ge172_selecao_fornecedores
integer x = 2121
integer y = 1244
integer width = 320
integer height = 96
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Cancelar"
end type

event clicked;CloseWithReturn(Parent, ivo_Selecao)
end event

