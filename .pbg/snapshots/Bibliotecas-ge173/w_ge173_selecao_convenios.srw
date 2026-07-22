HA$PBExportHeader$w_ge173_selecao_convenios.srw
forward
global type w_ge173_selecao_convenios from dc_w_response
end type
type gb_1 from groupbox within w_ge173_selecao_convenios
end type
type dw_1 from dc_uo_dw_base within w_ge173_selecao_convenios
end type
type cb_1 from commandbutton within w_ge173_selecao_convenios
end type
type cb_2 from commandbutton within w_ge173_selecao_convenios
end type
type cb_3 from commandbutton within w_ge173_selecao_convenios
end type
type cb_4 from commandbutton within w_ge173_selecao_convenios
end type
end forward

global type w_ge173_selecao_convenios from dc_w_response
string tag = "w_ge173_selecao_convenios"
integer width = 2510
integer height = 1460
string title = "GE173 - Sele$$HEX2$$e700e300$$ENDHEX$$o de Conv$$HEX1$$ea00$$ENDHEX$$nios"
boolean controlmenu = false
long backcolor = 80269524
gb_1 gb_1
dw_1 dw_1
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
cb_4 cb_4
end type
global w_ge173_selecao_convenios w_ge173_selecao_convenios

type variables
uo_Convenio ivo_Convenio
uo_ge289_consulta_rentab_selecao ivo_Selecao
end variables

on w_ge173_selecao_convenios.create
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

on w_ge173_selecao_convenios.destroy
call super::destroy
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_4)
end on

event ue_postopen;call super::ue_postopen;ivo_Convenio	= Create uo_Convenio
ivo_Selecao = Message.PowerObjectParm

Long lvl_Linha, &
	  lvl_Row
	  
String lvs_Id_Tipo_Selecao, &
		 lvs_De_Grupo, &
		 lvs_De_Selecao

For lvl_Linha = 1 To ivo_Selecao.ivds_Selecao.RowCount()
	lvs_Id_Tipo_Selecao = String(ivo_Selecao.ivds_Selecao.Object.Id_Tipo_Selecao[lvl_Linha])
	
	If lvs_Id_Tipo_Selecao = '8' Then
		lvs_De_Selecao = ivo_Selecao.ivds_Selecao.Object.De_Selecao[lvl_Linha]
		ivo_Convenio.of_Localiza_Convenio(lvs_De_Selecao)
		 
		lvl_Row = dw_1.InsertRow(0)
		dw_1.Object.De_Selecao [lvl_Row] = ivo_Convenio.Cd_Convenio
		dw_1.Object.Nm_Fantasia[lvl_Row] = ivo_Convenio.Nm_Fantasia
		dw_1.Object.Cd_Cidade  [lvl_Row] = ivo_Convenio.Cd_Cidade
	End If
Next

dw_1.Event ue_AddRow()
end event

event close;call super::close;Destroy(ivo_Convenio)
end event

type pb_help from dc_w_response`pb_help within w_ge173_selecao_convenios
end type

type gb_1 from groupbox within w_ge173_selecao_convenios
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

type dw_1 from dc_uo_dw_base within w_ge173_selecao_convenios
event ue_valida_dados ( )
integer x = 50
integer y = 52
integer width = 2363
integer height = 1144
boolean bringtotop = true
string dataobject = "dw_ge173_convenio"
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.of_SetRowSelection()
end event

event ue_key;String lvs_Texto, &
		 lvs_Cidade

Long lvl_Row, &
	  lvl_Linha, &
	  lvl_Find, &
	  lvl_Rows_Ds, &
	  lvl_Cidade

This.AcceptText()

If Key = KeyEnter! Then
	
	lvs_Texto = This.GetText()
	lvl_Row   = This.GetRow()
	
	If This.GetColumnName() = "nm_fantasia" Then
		ivo_Convenio.of_Localiza_Convenio(lvs_Texto)
		
		If ivo_Convenio.Localizado Then
			lvl_Find = This.Find("cd_convenio = " + String(ivo_Convenio.Cd_Convenio), 1, This.RowCount() )
			
			If  lvl_Find > 0 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O convenio selecionado j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ na rela$$HEX2$$e700e300$$ENDHEX$$o.")
				ivo_Convenio.of_Inicializa()
				
				This.Object.Nm_Fantasia[lvl_Row] = ""
			Else
				This.Object.Cd_Convenio[lvl_Row] = ivo_Convenio.Cd_Convenio
				This.Object.Nm_Fantasia[lvl_Row] = ivo_Convenio.Nm_Fantasia
				lvl_Cidade = ivo_Convenio.Cd_Cidade
				
				Select nm_cidade
				  Into :lvs_cidade
				  From cidade
				 Where cd_cidade = :lvl_Cidade
				 Using SqlCa;
				 
				 If SqlCa.SqlCode <> 0 Then
					SqlCa.of_MsgDbError("Sele$$HEX2$$e700e300$$ENDHEX$$o de cidade.")
					Return -1
				 End If
				 
				This.Object.Nm_Cidade[lvl_Row] = lvs_Cidade
				
				lvl_Rows_Ds = ivo_Selecao.ivds_Selecao.InsertRow(0)
				ivo_Selecao.ivds_Selecao.Object.Cd_Consulta	  [lvl_Rows_Ds] = 0
				ivo_Selecao.ivds_Selecao.Object.Id_Tipo_Selecao[lvl_Rows_Ds] = 8
				ivo_Selecao.ivds_Selecao.Object.De_Selecao	  [lvl_Rows_Ds] = String(ivo_Convenio.Cd_Convenio)
	
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

If IsValid(ivo_Convenio) Then
	If Not IsNull(This.Object.Cd_Convenio[lvl_Linhas]) And lvl_Row = lvl_Linhas Then
		This.Object.Cd_Convenio[lvl_Row] = ivo_Convenio.Cd_Convenio
		This.Object.Nm_Fantasia[lvl_Row] = ivo_Convenio.Nm_Fantasia
		This.Object.Cd_Cidade  [lvl_Row] = ""
	End If
End If
end event

event itemchanged;call super::itemchanged;Long lvl_Linha

If dwo.Name = "nm_fantasia" Then
	If Not IsNull(Data) and Trim(Data) <> "" Then
		If Data <> ivo_Convenio.Nm_Fantasia Then
			Return 1
		End If
	Else
		ivo_Convenio.of_Inicializa()
		
		This.Object.Cd_Convenio[GetRow()] = ivo_Convenio.Cd_Convenio
		This.Object.Nm_Fantasia[GetRow()] = ivo_Convenio.Nm_Fantasia
		This.Object.Nm_Cidade  [GetRow()] = ""
				
	End If
End If
end event

event ue_preinsertrow;call super::ue_preinsertrow;If IsValid(ivo_Convenio) Then
	ivo_Convenio.of_Inicializa()
End If

If This.RowCount() > 0 Then
	If IsNull(This.Object.Cd_Convenio[RowCount()]) Then Return -1
End If

Return 1
end event

type cb_1 from commandbutton within w_ge173_selecao_convenios
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

lvl_Find = lvds_1.Find("id_tipo_selecao = 8", 1, lvl_Rows_Ds)

Do While lvl_Find > 0
	lvds_1.DeleteRow(lvl_Find)
	lvl_Find = lvds_1.Find("id_tipo_selecao = 8", lvl_Find, lvl_Rows_Ds)
Loop
	
For lvl_Linha = 1 To dw_1.RowCount()
	
	If Not IsNull(dw_1.Object.Cd_Convenio[lvl_Linha]) Then
		lvl_InsertRow = lvds_1.InsertRow(0)
		lvds_1.Object.Id_Tipo_Selecao[lvl_InsertRow] = 8
		lvds_1.Object.De_Selecao     [lvl_InsertRow] = String(dw_1.Object.Cd_Convenio[lvl_Linha])
	Else
		If dw_1.RowCount() = 1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione pelo menos um conv$$HEX1$$ea00$$ENDHEX$$nio.")
			dw_1.Event ue_Pos(1, "nm_fantasia")
			Return -1
		End If
	End If
Next

CloseWithReturn(Parent, ivo_Selecao)
end event

event getfocus;dw_1.Event ue_valida_dados()
end event

type cb_2 from commandbutton within w_ge173_selecao_convenios
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

type cb_3 from commandbutton within w_ge173_selecao_convenios
integer x = 1371
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
string text = "E&xcluir"
end type

event clicked;dw_1.DeleteRow(dw_1.GetRow())

If dw_1.RowCount() = 0 Then dw_1.Event ue_AddRow()
end event

type cb_4 from commandbutton within w_ge173_selecao_convenios
integer x = 2121
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
string text = "&Cancelar"
end type

event clicked;CloseWithReturn(Parent, ivo_Selecao)
end event

