HA$PBExportHeader$w_ge229_sel_produto_personalizado.srw
forward
global type w_ge229_sel_produto_personalizado from dc_w_response
end type
type tab_1 from tab within w_ge229_sel_produto_personalizado
end type
type tabpage_1 from userobject within tab_1
end type
type gb_1 from groupbox within tabpage_1
end type
type gb_2 from groupbox within tabpage_1
end type
type dw_1 from dc_uo_dw_base within tabpage_1
end type
type dw_2 from dc_uo_dw_base within tabpage_1
end type
type tabpage_1 from userobject within tab_1
gb_1 gb_1
gb_2 gb_2
dw_1 dw_1
dw_2 dw_2
end type
type tabpage_2 from userobject within tab_1
end type
type gb_6 from groupbox within tabpage_2
end type
type gb_5 from groupbox within tabpage_2
end type
type dw_3 from dc_uo_dw_base within tabpage_2
end type
type dw_4 from dc_uo_dw_base within tabpage_2
end type
type tabpage_2 from userobject within tab_1
gb_6 gb_6
gb_5 gb_5
dw_3 dw_3
dw_4 dw_4
end type
type tabpage_3 from userobject within tab_1
end type
type gb_4 from groupbox within tabpage_3
end type
type dw_6 from dc_uo_dw_base within tabpage_3
end type
type gb_3 from groupbox within tabpage_3
end type
type dw_5 from dc_uo_dw_base within tabpage_3
end type
type tabpage_3 from userobject within tab_1
gb_4 gb_4
dw_6 dw_6
gb_3 gb_3
dw_5 dw_5
end type
type tabpage_4 from userobject within tab_1
end type
type gb_8 from groupbox within tabpage_4
end type
type dw_8 from dc_uo_dw_base within tabpage_4
end type
type gb_7 from groupbox within tabpage_4
end type
type dw_7 from dc_uo_dw_base within tabpage_4
end type
type tabpage_4 from userobject within tab_1
gb_8 gb_8
dw_8 dw_8
gb_7 gb_7
dw_7 dw_7
end type
type tabpage_5 from userobject within tab_1
end type
type gb_9 from groupbox within tabpage_5
end type
type gb_10 from groupbox within tabpage_5
end type
type dw_9 from dc_uo_dw_base within tabpage_5
end type
type dw_10 from dc_uo_dw_base within tabpage_5
end type
type tabpage_5 from userobject within tab_1
gb_9 gb_9
gb_10 gb_10
dw_9 dw_9
dw_10 dw_10
end type
type tabpage_6 from userobject within tab_1
end type
type gb_12 from groupbox within tabpage_6
end type
type gb_11 from groupbox within tabpage_6
end type
type dw_12 from dc_uo_dw_base within tabpage_6
end type
type dw_11 from dc_uo_dw_base within tabpage_6
end type
type tabpage_6 from userobject within tab_1
gb_12 gb_12
gb_11 gb_11
dw_12 dw_12
dw_11 dw_11
end type
type tab_1 from tab within w_ge229_sel_produto_personalizado
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
end type
type cb_excluir from commandbutton within w_ge229_sel_produto_personalizado
end type
type cb_ok from commandbutton within w_ge229_sel_produto_personalizado
end type
type cb_cancelar from commandbutton within w_ge229_sel_produto_personalizado
end type
type cb_excel from commandbutton within w_ge229_sel_produto_personalizado
end type
end forward

global type w_ge229_sel_produto_personalizado from dc_w_response
integer width = 2066
integer height = 1540
string title = "GE229 - Sele$$HEX2$$e700e300$$ENDHEX$$o de Produtos"
tab_1 tab_1
cb_excluir cb_excluir
cb_ok cb_ok
cb_cancelar cb_cancelar
cb_excel cb_excel
end type
global w_ge229_sel_produto_personalizado w_ge229_sel_produto_personalizado

type variables
uo_classificacao_produto 					ivo_classificacao //GE022
uo_ge229_selecao_prd_personalizado 	ivo_Selecao
uo_ge242_mix_produto 						ivo_Mix
uo_produto 										ivo_produto

Long ivl_Consulta

String ivs_Consulta


end variables

on w_ge229_sel_produto_personalizado.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.cb_excluir=create cb_excluir
this.cb_ok=create cb_ok
this.cb_cancelar=create cb_cancelar
this.cb_excel=create cb_excel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.cb_excluir
this.Control[iCurrent+3]=this.cb_ok
this.Control[iCurrent+4]=this.cb_cancelar
this.Control[iCurrent+5]=this.cb_excel
end on

on w_ge229_sel_produto_personalizado.destroy
call super::destroy
destroy(this.tab_1)
destroy(this.cb_excluir)
destroy(this.cb_ok)
destroy(this.cb_cancelar)
destroy(this.cb_excel)
end on

event open;call super::open;Long lvl_Altura_Total
Long lvl_Largura_Total
Long lvl_Altura_Janela
Long lvl_Largura_Janela

Environment lva

If GetEnvironment(lva) <> 1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na identifica$$HEX2$$e700e300$$ENDHEX$$o do ambiente.", Information!)
	Return
End If

lvl_Altura_Total  		= lva.ScreenHeight
lvl_Largura_Total 	= lva.ScreenWidth

lvl_Altura_Total  		= PixelsToUnits(lvl_Altura_Total,  YPixelsToUnits!)
lvl_Largura_Total 	= PixelsToUnits(lvl_Largura_Total, XPixelsToUnits!)

lvl_Altura_Janela  	= This.Height
lvl_Largura_Janela 	= This.Width

This.X = (lvl_Largura_Total - lvl_Largura_Janela) / 2
This.Y = (lvl_Altura_Total  - lvl_Altura_Janela)  / 2

If Not IsValid(ivo_Selecao) Then
	ivo_Selecao		= Create uo_ge229_selecao_prd_personalizado
End If

ivo_Classificacao 	= Create uo_classificacao_produto
ivo_Mix					= Create uo_ge242_mix_produto 
ivo_Produto			= Create uo_Produto
end event

event close;call super::close;Destroy(ivo_Classificacao)
Destroy(ivo_Mix)
Destroy(ivo_Produto)
end event

type pb_help from dc_w_response`pb_help within w_ge229_sel_produto_personalizado
end type

type tab_1 from tab within w_ge229_sel_produto_personalizado
event create ( )
event destroy ( )
integer y = 4
integer width = 2053
integer height = 1304
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long backcolor = 80269524
boolean raggedright = true
boolean boldselectedtext = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
tabpage_6 tabpage_6
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.tabpage_5=create tabpage_5
this.tabpage_6=create tabpage_6
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4,&
this.tabpage_5,&
this.tabpage_6}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
destroy(this.tabpage_5)
destroy(this.tabpage_6)
end on

event selectionchanged;If tab_1.SelectedTab = 6 Then
	cb_Excel.Visible = True
	cb_Excluir.Text = "E&xcluir Todos"
Else
	cb_Excel.Visible = False
	cb_Excluir.Text = "E&xcluir"
End If
end event

type tabpage_1 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 2016
integer height = 1188
long backcolor = 80269524
string text = "Grupo"
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
gb_1 gb_1
gb_2 gb_2
dw_1 dw_1
dw_2 dw_2
end type

on tabpage_1.create
this.gb_1=create gb_1
this.gb_2=create gb_2
this.dw_1=create dw_1
this.dw_2=create dw_2
this.Control[]={this.gb_1,&
this.gb_2,&
this.dw_1,&
this.dw_2}
end on

on tabpage_1.destroy
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.dw_1)
destroy(this.dw_2)
end on

type gb_1 from groupbox within tabpage_1
integer x = 18
integer width = 1623
integer height = 160
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
borderstyle borderstyle = styleraised!
end type

type gb_2 from groupbox within tabpage_1
integer x = 18
integer y = 164
integer width = 1975
integer height = 1000
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista"
borderstyle borderstyle = styleraised!
end type

type dw_1 from dc_uo_dw_base within tabpage_1
integer x = 46
integer y = 56
integer width = 1577
integer height = 96
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge229_selecao_produto"
end type

event constructor;call super::constructor;This.Insertrow(0)
end event

event losefocus;call super::losefocus;This.Object.Descricao[1] = ""
end event

event ue_key;Long lvl_Row
	  
String lvs_Texto, &
		 lvs_De_Grupo, &
	    lvs_Cd_Grupo

If Key = KeyEnter! Then
	lvs_Texto = This.GetText()
	If Not ivo_Classificacao.of_Localiza_Grupo(lvs_Texto) Then Return

	lvs_Cd_Grupo = ivo_Classificacao.Cd_Grupo
	lvs_De_Grupo = ivo_Classificacao.De_Grupo
	
	If dw_2.Find("de_selecao = '" + lvs_Cd_Grupo + "'", 1, dw_2.RowCount()) > 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O grupo selecionado j$$HEX1$$e100$$ENDHEX$$ se encontra na lista.")
		Return -1
	End If

	
	lvl_Row = dw_2.Event ue_AddRow()
	
	dw_2.Object.De_Selecao[lvl_Row] = lvs_Cd_Grupo
	dw_2.Object.De_Grupo[lvl_Row] = lvs_De_Grupo
	
End If

ivo_Classificacao.of_Inicializa()
end event

type dw_2 from dc_uo_dw_base within tabpage_1
integer x = 46
integer y = 216
integer width = 1925
integer height = 932
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_ge229_lista_produto"
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event constructor;call super::constructor;Long lvl_Linha, &
	  lvl_Row, &
	  lvl_Total
	  
String lvs_Id_Tipo_Selecao, &
		 lvs_De_Grupo, &
		 lvs_De_Selecao

ivo_Selecao = Message.PowerObjectParm

//If ivo_Selecao.ivb_Insere_Array Then
	
//Else
//	
//End If

//If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = "CO" Then

If Not ivo_Selecao.ivb_Insere_Array Then

	lvl_Total = ivo_Selecao.ivds_Selecao.RowCount()
	
	Open(w_Aguarde)
	w_Aguarde.Title = "Recuperando informa$$HEX2$$e700f500$$ENDHEX$$es da sele$$HEX2$$e700e300$$ENDHEX$$o de produtos."
	w_Aguarde.uo_Progress.of_SetMax(lvl_Total)
	
	For lvl_Linha = 1 To lvl_Total
		w_Aguarde.uo_Progress.of_SetProgress(lvl_Linha)
		
		lvs_Id_Tipo_Selecao = String(ivo_Selecao.ivds_Selecao.Object.Id_Tipo_Selecao[lvl_Linha])
		lvs_De_Selecao		  = ivo_Selecao.ivds_Selecao.Object.De_Selecao[lvl_Linha]
		
		If lvs_Id_Tipo_Selecao = '1' Then
			
			Select Distinct de_grupo
			  Into :lvs_De_Grupo
			  From vw_classificacao_produto
			 Where cd_grupo = :lvs_De_Selecao
			 Using SqlCa;
			 
			If SqlCa.SqlCode <> 0 Then
				SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do grupo.")
				Return -1
			End If
			 
			lvl_Row = This.Event ue_AddRow()
			This.Object.De_Selecao[lvl_Row] = ivo_Selecao.ivds_Selecao.Object.De_Selecao[lvl_Linha]
			This.Object.De_Grupo  [lvl_Row]  = lvs_De_Grupo
		End If
	Next
	
	Close(w_Aguarde)
	This.of_SetRowSelection()
	
End If
end event

type tabpage_2 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 2016
integer height = 1188
long backcolor = 80269524
string text = "Subgrupo"
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
gb_6 gb_6
gb_5 gb_5
dw_3 dw_3
dw_4 dw_4
end type

on tabpage_2.create
this.gb_6=create gb_6
this.gb_5=create gb_5
this.dw_3=create dw_3
this.dw_4=create dw_4
this.Control[]={this.gb_6,&
this.gb_5,&
this.dw_3,&
this.dw_4}
end on

on tabpage_2.destroy
destroy(this.gb_6)
destroy(this.gb_5)
destroy(this.dw_3)
destroy(this.dw_4)
end on

type gb_6 from groupbox within tabpage_2
integer x = 18
integer width = 1618
integer height = 160
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
borderstyle borderstyle = styleraised!
end type

type gb_5 from groupbox within tabpage_2
integer x = 18
integer y = 164
integer width = 1979
integer height = 996
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista"
borderstyle borderstyle = styleraised!
end type

type dw_3 from dc_uo_dw_base within tabpage_2
integer x = 46
integer y = 56
integer width = 1577
integer height = 88
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_ge229_selecao_produto"
end type

event constructor;call super::constructor;This.Insertrow(0)
end event

event losefocus;call super::losefocus;This.Object.Descricao[1] = ""
end event

event ue_key;Long lvl_Row, &
	  lvl_Find
	  
String lvs_Texto, &
		 lvs_De_Subgrupo, &
	    lvs_Cd_Subgrupo, &
		 lvs_Encontrado

If Key = KeyEnter! Then
	lvs_Texto = This.GetText()
	If Not ivo_Classificacao.of_Localiza_Subgrupo(lvs_Texto) Then Return

	lvs_Cd_Subgrupo = ivo_Classificacao.Cd_Subgrupo
	lvs_De_Subgrupo = ivo_Classificacao.De_Subgrupo
	
	lvl_Find = Tab_1.TabPage_1.dw_2.Find("de_selecao = '" + MidA(lvs_Cd_Subgrupo, 1, 1) + "'", 1, Tab_1.TabPage_1.dw_2.RowCount())
	
	If  lvl_Find > 0 Then
		lvs_Encontrado = Tab_1.TabPage_1.dw_2.Object.De_Grupo[lvl_Find]
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O grupo " + lvs_Encontrado + " j$$HEX1$$e100$$ENDHEX$$ se encontra na lista e cont$$HEX1$$e900$$ENDHEX$$m o subgrupo selecionado.")
		Return -1
	End If
	
	If dw_4.Find("de_selecao = '" + lvs_Cd_Subgrupo + "'", 1, dw_4.RowCount()) > 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O subgrupo selecionado j$$HEX1$$e100$$ENDHEX$$ se encontra na lista.")
		Return -1
	End If
	
	lvl_Row = dw_4.Event ue_AddRow()
	
	dw_4.Object.De_Selecao[lvl_Row] = lvs_Cd_Subgrupo
	dw_4.Object.De_Grupo  [lvl_Row] = lvs_De_Subgrupo
	
	ivo_Classificacao.of_Inicializa()
	
End If
end event

type dw_4 from dc_uo_dw_base within tabpage_2
integer x = 46
integer y = 216
integer width = 1929
integer height = 920
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_ge229_lista_produto"
end type

event constructor;call super::constructor;Long lvl_Linha, &
	  lvl_Row, &
	  lvl_Total
	  
String lvs_Id_Tipo_Selecao, &
		 lvs_De_SubGrupo, &
		 lvs_De_Selecao
		 
//If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = "CO" Then
If Not ivo_Selecao.ivb_Insere_Array Then

	lvl_Total = ivo_Selecao.ivds_Selecao.RowCount()
	
	Open(w_Aguarde)
	w_Aguarde.Title = "Recuperando informa$$HEX2$$e700f500$$ENDHEX$$es da sele$$HEX2$$e700e300$$ENDHEX$$o de produtos."
	w_Aguarde.uo_Progress.of_SetMax(lvl_Total)
	
	For lvl_Linha = 1 To ivo_Selecao.ivds_Selecao.RowCount()
		w_Aguarde.uo_Progress.of_SetProgress(lvl_Linha)
		lvs_Id_Tipo_Selecao = String(ivo_Selecao.ivds_Selecao.Object.Id_Tipo_Selecao[lvl_Linha])
		lvs_De_Selecao		  = ivo_Selecao.ivds_Selecao.Object.De_Selecao[lvl_Linha]
		
		If lvs_Id_Tipo_Selecao = '2' Then
			
			Select Distinct de_subgrupo
			  Into :lvs_De_SubGrupo
			  From vw_classificacao_produto
			 Where cd_subgrupo = :lvs_De_Selecao
			 Using SqlCa;
			 
			If SqlCa.SqlCode <> 0 Then
				SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do subgrupo.")
				Return -1
			End If
			 
			lvl_Row = This.Event ue_AddRow()
			This.Object.De_Selecao[lvl_Row] = ivo_Selecao.ivds_Selecao.Object.De_Selecao[lvl_Linha]
			This.Object.De_Grupo  [lvl_Row] = lvs_De_SubGrupo
		End If
	Next
	Close(w_Aguarde)
	This.of_SetRowSelection()
	
End If
end event

type tabpage_3 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 2016
integer height = 1188
long backcolor = 80269524
string text = "Categoria"
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
gb_4 gb_4
dw_6 dw_6
gb_3 gb_3
dw_5 dw_5
end type

on tabpage_3.create
this.gb_4=create gb_4
this.dw_6=create dw_6
this.gb_3=create gb_3
this.dw_5=create dw_5
this.Control[]={this.gb_4,&
this.dw_6,&
this.gb_3,&
this.dw_5}
end on

on tabpage_3.destroy
destroy(this.gb_4)
destroy(this.dw_6)
destroy(this.gb_3)
destroy(this.dw_5)
end on

type gb_4 from groupbox within tabpage_3
integer x = 18
integer y = 164
integer width = 1984
integer height = 1000
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista"
borderstyle borderstyle = styleraised!
end type

type dw_6 from dc_uo_dw_base within tabpage_3
integer x = 46
integer y = 216
integer width = 1938
integer height = 920
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_ge229_lista_produto"
end type

event constructor;call super::constructor;Long lvl_Linha, &
	  lvl_Row, &
	  lvl_Total
	  
String lvs_Id_Tipo_Selecao, &
		 lvs_De_Categoria, &
		 lvs_De_Selecao

//If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = "CO" Then
If Not ivo_Selecao.ivb_Insere_Array Then

	lvl_Total = ivo_Selecao.ivds_Selecao.RowCount()
	
	Open(w_Aguarde)
	w_Aguarde.Title = "Recuperando informa$$HEX2$$e700f500$$ENDHEX$$es da sele$$HEX2$$e700e300$$ENDHEX$$o de produtos."
	w_Aguarde.uo_Progress.of_SetMax(lvl_Total)
	
	For lvl_Linha = 1 To ivo_Selecao.ivds_Selecao.RowCount()
		w_Aguarde.uo_Progress.of_SetProgress(lvl_Linha)
		lvs_Id_Tipo_Selecao = String(ivo_Selecao.ivds_Selecao.Object.Id_Tipo_Selecao[lvl_Linha])
		lvs_De_Selecao		  = ivo_Selecao.ivds_Selecao.Object.De_Selecao[lvl_Linha]
		
		If lvs_Id_Tipo_Selecao = '3' Then
			
			Select Distinct de_categoria
			  Into :lvs_De_Categoria
			  From vw_classificacao_produto
			 Where cd_categoria = :lvs_De_Selecao
			 Using SqlCa;
			 
			If SqlCa.SqlCode <> 0 Then
				SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do categoria.")
				Return -1
			End If
			 
			lvl_Row = This.Event ue_AddRow()
			This.Object.De_Selecao[lvl_Row] = ivo_Selecao.ivds_Selecao.Object.De_Selecao[lvl_Linha]
			This.Object.De_Grupo  [lvl_Row]  = lvs_De_Categoria
		End If
	Next
	
	Close(w_Aguarde)
	This.of_SetRowSelection()
	
End If
end event

type gb_3 from groupbox within tabpage_3
integer x = 18
integer width = 1609
integer height = 160
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
borderstyle borderstyle = styleraised!
end type

type dw_5 from dc_uo_dw_base within tabpage_3
integer x = 46
integer y = 56
integer width = 1573
integer height = 88
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_ge229_selecao_produto"
end type

event constructor;call super::constructor;This.Insertrow(0)
end event

event losefocus;call super::losefocus;This.Object.Descricao[1] = ""
end event

event ue_key;Long lvl_Row, &
	  lvl_Find
	  
String lvs_Texto, &
		 lvs_De_Categoria, &
	    lvs_Cd_Categoria, &
		 lvs_Encontrado

If Key = KeyEnter! Then
	lvs_Texto = This.GetText()
	If Not ivo_Classificacao.of_Localiza_Categoria(lvs_Texto) Then Return

	lvs_Cd_Categoria = ivo_Classificacao.Cd_Categoria
	lvs_De_Categoria = ivo_Classificacao.De_Categoria
	
	lvl_Find = Tab_1.TabPage_1.dw_2.Find("de_selecao = '" + MidA(lvs_Cd_Categoria, 1, 1) + "'", 1, Tab_1.TabPage_1.dw_2.RowCount())
	If  lvl_Find > 0 Then
		lvs_Encontrado = Tab_1.TabPage_1.dw_2.Object.De_Grupo[lvl_Find]
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O grupo " + lvs_Encontrado + " j$$HEX1$$e100$$ENDHEX$$ se encontra na lista e cont$$HEX1$$e900$$ENDHEX$$m a categoria selecionada.")
		Return -1
	End If
	
	lvl_Find = Tab_1.TabPage_2.dw_4.Find("de_selecao = '" + MidA(lvs_Cd_Categoria, 1, 3) + "'", 1, Tab_1.TabPage_2.dw_4.RowCount())
	If  lvl_Find > 0 Then
		lvs_Encontrado = Tab_1.TabPage_2.dw_4.Object.De_Grupo[lvl_Find]
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O subgrupo " + lvs_Encontrado + " j$$HEX1$$e100$$ENDHEX$$ se encontra na lista e cont$$HEX1$$e900$$ENDHEX$$m a categoria selecionada.")
		Return -1
	End If
	
	For lvl_Row = 1 To dw_6.RowCount()
		If dw_6.Find("de_selecao = '" + lvs_Cd_Categoria + "'", 1, dw_6.RowCount()) > 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A categoria selecionado j$$HEX1$$e100$$ENDHEX$$ se encontra na lista.")
			Return -1
		End If
	Next
	
	lvl_Row = dw_6.Event ue_AddRow()
	
	dw_6.Object.De_Selecao[lvl_Row] = lvs_Cd_Categoria
	dw_6.Object.De_Grupo  [lvl_Row] = lvs_De_Categoria
	
	ivo_Classificacao.of_Inicializa()
	
End If
end event

type tabpage_4 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 2016
integer height = 1188
long backcolor = 80269524
string text = "Subcategoria"
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
gb_8 gb_8
dw_8 dw_8
gb_7 gb_7
dw_7 dw_7
end type

on tabpage_4.create
this.gb_8=create gb_8
this.dw_8=create dw_8
this.gb_7=create gb_7
this.dw_7=create dw_7
this.Control[]={this.gb_8,&
this.dw_8,&
this.gb_7,&
this.dw_7}
end on

on tabpage_4.destroy
destroy(this.gb_8)
destroy(this.dw_8)
destroy(this.gb_7)
destroy(this.dw_7)
end on

type gb_8 from groupbox within tabpage_4
integer x = 18
integer y = 164
integer width = 1984
integer height = 1000
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista"
borderstyle borderstyle = styleraised!
end type

type dw_8 from dc_uo_dw_base within tabpage_4
integer x = 46
integer y = 216
integer width = 1934
integer height = 920
integer taborder = 50
boolean bringtotop = true
string dataobject = "dw_ge229_lista_produto"
end type

event constructor;call super::constructor;Long lvl_Linha, &
	  lvl_Row, &
	  lvl_Total
	  
String lvs_Id_Tipo_Selecao, &
		 lvs_De_SubCategoria, &
		 lvs_De_Selecao

//If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = "CO" Then
If Not ivo_Selecao.ivb_Insere_Array Then

	lvl_Total = ivo_Selecao.ivds_Selecao.RowCount()
	
	Open(w_Aguarde)
	w_Aguarde.Title = "Recuperando informa$$HEX2$$e700f500$$ENDHEX$$es da sele$$HEX2$$e700e300$$ENDHEX$$o de produtos."
	w_Aguarde.uo_Progress.of_SetMax(lvl_Total)
	
	For lvl_Linha = 1 To ivo_Selecao.ivds_Selecao.RowCount()
		w_Aguarde.uo_Progress.of_SetProgress(lvl_Linha)
		lvs_Id_Tipo_Selecao = String(ivo_Selecao.ivds_Selecao.Object.Id_Tipo_Selecao[lvl_Linha])
		lvs_De_Selecao		  = ivo_Selecao.ivds_Selecao.Object.De_Selecao[lvl_Linha]
		
		If lvs_Id_Tipo_Selecao = '4' Then
			
			Select Distinct de_subcategoria
			  Into :lvs_De_SubCategoria
			  From vw_classificacao_produto
			 Where cd_subcategoria = :lvs_De_Selecao
			 Using SqlCa;
			 
			If SqlCa.SqlCode <> 0 Then
				SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do subcategoria.")
				Return -1
			End If
			 
			lvl_Row = This.Event ue_AddRow()
			This.Object.De_Selecao[lvl_Row] = ivo_Selecao.ivds_Selecao.Object.De_Selecao[lvl_Linha]
			This.Object.De_Grupo  [lvl_Row] = lvs_De_SubCategoria
		End If
	Next
	
	Close(w_Aguarde)
	This.of_SetRowSelection()
	
End If
end event

type gb_7 from groupbox within tabpage_4
integer x = 18
integer width = 1605
integer height = 160
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
borderstyle borderstyle = styleraised!
end type

type dw_7 from dc_uo_dw_base within tabpage_4
integer x = 46
integer y = 56
integer width = 1563
integer height = 84
integer taborder = 50
boolean bringtotop = true
string dataobject = "dw_ge229_selecao_produto"
end type

event constructor;call super::constructor;This.Insertrow(0)
end event

event losefocus;call super::losefocus;This.Object.Descricao[1] = ""
end event

event ue_key;Long lvl_Row, &
	  lvl_Find
	  
String lvs_Texto, &
		 lvs_De_SubCategoria, &
	    lvs_Cd_SubCategoria, &
		 lvs_Encontrado

If Key = KeyEnter! Then
	lvs_Texto = This.GetText()
	If Not ivo_Classificacao.of_Localiza_SubCategoria(lvs_Texto) Then Return

	lvs_Cd_SubCategoria = ivo_Classificacao.Cd_SubCategoria
	lvs_De_SubCategoria = ivo_Classificacao.De_SubCategoria
	
	lvl_Find = Tab_1.TabPage_1.dw_2.Find("de_selecao = '" + MidA(lvs_Cd_SubCategoria, 1, 1) + "'", 1, Tab_1.TabPage_1.dw_2.RowCount())
	If  lvl_Find > 0 Then
		lvs_Encontrado = Tab_1.TabPage_1.dw_2.Object.De_Grupo[lvl_Find]
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O grupo " + lvs_Encontrado + " j$$HEX1$$e100$$ENDHEX$$ se encontra na lista e cont$$HEX1$$e900$$ENDHEX$$m a subcategoria selecionada.")
		Return -1
	End If
	
	lvl_Find = Tab_1.TabPage_2.dw_4.Find("de_selecao = '" + MidA(lvs_Cd_SubCategoria, 1, 3) + "'", 1, Tab_1.TabPage_2.dw_4.RowCount())
	If  lvl_Find > 0 Then
		lvs_Encontrado = Tab_1.TabPage_2.dw_4.Object.De_Grupo[lvl_Find]
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O subgrupo " + lvs_Encontrado + " j$$HEX1$$e100$$ENDHEX$$ se encontra na lista e cont$$HEX1$$e900$$ENDHEX$$m a subcategoria selecionada.")
		Return -1
	End If
	
	lvl_Find = Tab_1.TabPage_3.dw_6.Find("de_selecao = '" + MidA(lvs_Cd_SubCategoria, 1, 6) + "'", 1, Tab_1.TabPage_3.dw_6.RowCount())
	If  lvl_Find > 0 Then
		lvs_Encontrado = Tab_1.TabPage_3.dw_6.Object.De_Grupo[lvl_Find]
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A categoria " + lvs_Encontrado + " j$$HEX1$$e100$$ENDHEX$$ se encontra na lista e cont$$HEX1$$e900$$ENDHEX$$m a subcategoria selecionada.")
		Return -1
	End If
	
	For lvl_Row = 1 To dw_8.RowCount()
		If dw_8.Find("de_selecao = '" + lvs_Cd_SubCategoria + "'", 1, dw_8.RowCount()) > 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A subcategoria selecionada j$$HEX1$$e100$$ENDHEX$$ se encontra na lista.")
			Return -1
		End If
	Next
	
	lvl_Row = dw_8.Event ue_AddRow()
	
	dw_8.Object.De_Selecao[lvl_Row] = lvs_Cd_SubCategoria
	dw_8.Object.De_Grupo  [lvl_Row] = lvs_De_SubCategoria
	
	ivo_Classificacao.of_Inicializa()
	
End If
end event

type tabpage_5 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 2016
integer height = 1188
long backcolor = 80269524
string text = "Mix"
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
gb_9 gb_9
gb_10 gb_10
dw_9 dw_9
dw_10 dw_10
end type

on tabpage_5.create
this.gb_9=create gb_9
this.gb_10=create gb_10
this.dw_9=create dw_9
this.dw_10=create dw_10
this.Control[]={this.gb_9,&
this.gb_10,&
this.dw_9,&
this.dw_10}
end on

on tabpage_5.destroy
destroy(this.gb_9)
destroy(this.gb_10)
destroy(this.dw_9)
destroy(this.dw_10)
end on

type gb_9 from groupbox within tabpage_5
integer x = 18
integer width = 1609
integer height = 160
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
borderstyle borderstyle = styleraised!
end type

type gb_10 from groupbox within tabpage_5
integer x = 18
integer y = 164
integer width = 1979
integer height = 1004
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista"
borderstyle borderstyle = styleraised!
end type

type dw_9 from dc_uo_dw_base within tabpage_5
integer x = 46
integer y = 56
integer width = 1568
integer height = 84
integer taborder = 50
boolean bringtotop = true
string dataobject = "dw_ge229_selecao_produto"
end type

event constructor;call super::constructor;This.Insertrow(0)
end event

event losefocus;call super::losefocus;This.Object.Descricao[1] = ""
end event

event ue_key;If Key = KeyEnter! Then

	Long lvl_Row, &
		  lvl_Cd_Mix
		  
	String lvs_De_Mix
	
	dw_10.AcceptText()
	
	ivo_Mix.ivs_Parametro_Selecao = This.GetText()

	If Not ivo_Mix.of_Localiza() Then Return
	
	lvl_Cd_Mix = ivo_Mix.Cd_Mix_Produto
	lvs_De_Mix = ivo_Mix.De_Mix_Produto
	
	If dw_10.Find("de_selecao = '" + String(lvl_Cd_Mix) + "'", 1, dw_10.RowCount()) > 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O mix selecionado j$$HEX1$$e100$$ENDHEX$$ se encontra na lista.")
		Return -1
	End If

	lvl_Row = dw_10.Event ue_AddRow()
	
	dw_10.Object.De_Selecao[lvl_Row] = String(lvl_Cd_Mix)
	dw_10.Object.De_Grupo  [lvl_Row] = lvs_De_Mix
End If
end event

type dw_10 from dc_uo_dw_base within tabpage_5
integer x = 46
integer y = 216
integer width = 1915
integer height = 920
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_ge229_lista_produto"
end type

event constructor;call super::constructor;Long lvl_Linha, &
	  lvl_Row, &
	  lvl_Total
	  
String lvs_Id_Tipo_Selecao, &
		 lvs_De_Mix, &
		 lvs_De_Selecao

//If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = "CO" Then
If Not ivo_Selecao.ivb_Insere_Array Then

	lvl_Total = ivo_Selecao.ivds_Selecao.RowCount()
	
	Open(w_Aguarde)
	w_Aguarde.Title = "Recuperando informa$$HEX2$$e700f500$$ENDHEX$$es da sele$$HEX2$$e700e300$$ENDHEX$$o de produtos."
	w_Aguarde.uo_Progress.of_SetMax(lvl_Total)
	
	For lvl_Linha = 1 To ivo_Selecao.ivds_Selecao.RowCount()
		w_Aguarde.uo_Progress.of_SetProgress(lvl_Linha)
		lvs_Id_Tipo_Selecao = String(ivo_Selecao.ivds_Selecao.Object.Id_Tipo_Selecao[lvl_Linha])
		lvs_De_Selecao		  = ivo_Selecao.ivds_Selecao.Object.De_Selecao[lvl_Linha]
		
		If lvs_Id_Tipo_Selecao = '6' Then
			
			 Select de_mix_produto
				Into :lvs_De_Mix
				From mix_produto
			  Where cd_mix_produto = Convert(Integer,:lvs_De_Selecao)
			  Using SqlCa;
			 
			If SqlCa.SqlCode <> 0 Then
				SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Mix de produtos.~r C$$HEX1$$f300$$ENDHEX$$digo do mix : " + lvs_De_Selecao )
				Return -1
			End If
			 
			lvl_Row = This.Event ue_AddRow()
			This.Object.De_Selecao[lvl_Row] = ivo_Selecao.ivds_Selecao.Object.De_Selecao[lvl_Linha]
			This.Object.De_Grupo  [lvl_Row] = lvs_De_Mix
		End If
	Next
	
	Close(w_Aguarde)
	This.of_SetRowSelection()
	
End If
end event

type tabpage_6 from userobject within tab_1
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 2016
integer height = 1188
long backcolor = 80269524
string text = "Produto"
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
gb_12 gb_12
gb_11 gb_11
dw_12 dw_12
dw_11 dw_11
end type

on tabpage_6.create
this.gb_12=create gb_12
this.gb_11=create gb_11
this.dw_12=create dw_12
this.dw_11=create dw_11
this.Control[]={this.gb_12,&
this.gb_11,&
this.dw_12,&
this.dw_11}
end on

on tabpage_6.destroy
destroy(this.gb_12)
destroy(this.gb_11)
destroy(this.dw_12)
destroy(this.dw_11)
end on

type gb_12 from groupbox within tabpage_6
integer x = 18
integer y = 164
integer width = 1979
integer height = 1004
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista"
borderstyle borderstyle = styleraised!
end type

type gb_11 from groupbox within tabpage_6
integer x = 18
integer width = 1609
integer height = 160
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
borderstyle borderstyle = styleraised!
end type

type dw_12 from dc_uo_dw_base within tabpage_6
integer x = 46
integer y = 216
integer width = 1915
integer height = 920
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_ge229_lista_produto"
boolean vscrollbar = true
end type

event constructor;call super::constructor;Long lvl_Linha, &
	  lvl_Row, &
	  lvl_Total
	  
String lvs_Id_Tipo_Selecao, &
		 lvs_De_Produto, &
		 lvs_De_Apresentacao_Venda, &
		 lvs_De_Selecao

//If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = "CO" Then

If Not ivo_Selecao.ivb_Insere_Array Then

	lvl_Total = ivo_Selecao.ivds_Selecao.RowCount()
	
	Open(w_Aguarde)
	w_Aguarde.Title = "Recuperando informa$$HEX2$$e700f500$$ENDHEX$$es da sele$$HEX2$$e700e300$$ENDHEX$$o de produtos."
	w_Aguarde.uo_Progress.of_SetMax(lvl_Total)
	
	For lvl_Linha = 1 To ivo_Selecao.ivds_Selecao.RowCount()
		w_Aguarde.uo_Progress.of_SetProgress(lvl_Linha)
		lvs_Id_Tipo_Selecao = String(ivo_Selecao.ivds_Selecao.Object.Id_Tipo_Selecao[lvl_Linha])
		lvs_De_Selecao		  = ivo_Selecao.ivds_Selecao.Object.De_Selecao[lvl_Linha]
		
		If lvs_Id_Tipo_Selecao = '5' Then
			
			 Select de_produto,
					  de_apresentacao_venda
				Into :lvs_De_Produto,
					  :lvs_De_Apresentacao_Venda
				From produto_geral
			  Where cd_produto = Convert(Integer,:lvs_De_Selecao)
			  Using SqlCa;
			 
			If SqlCa.SqlCode <> 0 Then
				SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Produto. ~r Produto : " + lvs_De_Selecao)
				Return -1
			End If
			 
			lvl_Row = This.Event ue_AddRow()
			This.Object.De_Selecao[lvl_Row] = ivo_Selecao.ivds_Selecao.Object.De_Selecao[lvl_Linha]
			This.Object.De_Grupo  [lvl_Row] = lvs_De_Produto + " : " + lvs_De_Apresentacao_Venda
		End If
	Next
	
	Close(w_Aguarde)
	
	This.of_SetRowSelection()
	
End If
end event

type dw_11 from dc_uo_dw_base within tabpage_6
integer x = 46
integer y = 56
integer width = 1568
integer height = 84
integer taborder = 50
boolean bringtotop = true
string dataobject = "dw_ge229_selecao_produto"
end type

event constructor;call super::constructor;This.Insertrow(0)
end event

event losefocus;call super::losefocus;This.Object.Descricao[1] = ""
end event

event ue_key;If Key = KeyEnter! Then

	Long lvl_Row, &
		  lvl_Cd_Produto
		  
	String lvs_De_Produto, &
			 lvs_De_Apresentacao_Venda
	
	dw_12.AcceptText()
	
	ivo_Produto.of_Localiza_Produto(This.GetText())
	
	If Not ivo_Produto.Localizado Then Return

	lvl_Cd_Produto = ivo_Produto.Cd_Produto
	lvs_De_Produto = ivo_Produto.De_Produto
	lvs_De_Apresentacao_Venda = ivo_Produto.De_Apresentacao_Venda
	
	lvl_Row = dw_12.Event ue_AddRow()
	
	dw_12.Object.De_Selecao[lvl_Row] = String(lvl_Cd_Produto)
	dw_12.Object.De_Grupo  [lvl_Row] = lvs_De_Produto + " : " + lvs_De_Apresentacao_Venda
End If
end event

type cb_excluir from commandbutton within w_ge229_sel_produto_personalizado
integer x = 832
integer y = 1324
integer width = 439
integer height = 108
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "E&xcluir"
end type

event clicked;Long lvl_Tab, &
	  lvl_Row, &
	  lvl_Linhas, &
	  lvl_DeleteRow

DataWindow lvdw_Dw
lvl_Tab = Tab_1.SelectedTab

Choose Case lvl_Tab
	Case 1
		lvdw_Dw = Tab_1.TabPage_1.dw_2
	Case 2
		lvdw_Dw = Tab_1.TabPage_2.dw_4
	Case 3
		lvdw_Dw = Tab_1.TabPage_3.dw_6
	Case 4
		lvdw_Dw = Tab_1.TabPage_4.dw_8
	Case 5
		lvdw_Dw = Tab_1.TabPage_5.dw_10
	Case 6
		lvdw_Dw = Tab_1.TabPage_6.dw_12
End Choose

If lvl_Tab = 6 Then
	lvl_Linhas = lvdw_Dw.RowCount()
	For lvl_Row = 1 To lvl_Linhas
		lvl_DeleteRow = lvdw_Dw.DeleteRow(1)
		If lvl_DeleteRow = -1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na exclus$$HEX1$$e300$$ENDHEX$$o dos produtos.")
			Return
		End If
	Next
Else
	lvl_Row = lvdw_Dw.RowCount()
	If lvl_Row > 0 Then
		lvl_Row = lvdw_Dw.GetRow()
		lvdw_Dw.DeleteRow(lvl_Row)	
	End If
End If

Return
end event

type cb_ok from commandbutton within w_ge229_sel_produto_personalizado
integer x = 1317
integer y = 1324
integer width = 347
integer height = 108
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Ok"
end type

event clicked;Long lvl_Linha, &
	  lvl_TabPage, &
	  lvl_InsertRow = 0, &
	  lvl_Find, &
	  lvl_Selecao
	  
String lvs_Aux[]
String lvs_Null[]

//If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = "CO" Then
If Not ivo_Selecao.ivb_Insere_Array Then
	DataWindow lvdw_Dw
	dc_uo_ds_base lvds_1
	
	lvds_1 = ivo_Selecao.ivds_Selecao
	
	lvl_Find = lvds_1.Find("id_tipo_selecao in (1,2,3,5,4,6)", 1, lvds_1.RowCount())
	
	Do While lvl_Find > 0
		If lvl_Find > 0 Then lvds_1.DeleteRow(lvl_Find)
		lvl_Find = lvds_1.Find("id_tipo_selecao in (1,2,3,4,5,6)", 1, lvds_1.RowCount())
	Loop
	
End If

//Loop em todas as abas 
For lvl_TabPage = 1 To 6
	lvl_Selecao = lvl_TabPage
	
	//Zerando o Array
	lvs_Aux[]=lvs_null[]
	
	Choose Case lvl_TabPage
		Case 1; lvdw_Dw = Tab_1.TabPage_1.dw_2
		Case 2; lvdw_Dw = Tab_1.TabPage_2.dw_4
		Case 3; lvdw_Dw = Tab_1.TabPage_3.dw_6	
		Case 4; lvdw_Dw = Tab_1.TabPage_4.dw_8
		Case 5
			lvdw_Dw = Tab_1.TabPage_5.dw_10
			lvl_Selecao = 6
		Case 6
			lvdw_Dw = Tab_1.TabPage_6.dw_12
			lvl_Selecao = 5
	End Choose
	
	If lvdw_Dw.RowCount() > 0 Then
		
		ivo_Selecao.ivs_TabPage_Selecionadas+= String( lvl_TabPage )
		
		//Loop nas linhas de cada DW
		For lvl_Linha = 1 To lvdw_Dw.RowCount()
			
			//Alocando valores das linhas em um array auxiliar
			//Esta Fun$$HEX2$$e700e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ para outro procedimento, ou seja, a consulta ser$$HEX1$$e100$$ENDHEX$$ gravada 
			//em array diferente, separando-os por tipo de sele$$HEX2$$e700e300$$ENDHEX$$o
			lvs_Aux[lvl_Linha] = lvdw_Dw.Object.De_Selecao[lvl_Linha]
			
			//Mantem a estrura normal usada no CO121
			//Salvando a consulta em uma Dw
			//If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = "CO" Then
			If Not ivo_Selecao.ivb_Insere_Array Then
				lvl_InsertRow = lvds_1.InsertRow(0)			
				lvds_1.Object.Id_Tipo_Selecao	[lvl_InsertRow] = lvl_Selecao
				lvds_1.Object.De_Selecao     	[lvl_InsertRow] = lvdw_Dw.Object.De_Selecao[lvl_Linha]
			End If
		Next
		
		//Carregando os valores de cada aba em seu respectivo objeto de instancia.
		Choose Case lvl_TabPage
			Case 1; ivo_Selecao.ivs_Grupo				[] = lvs_Aux[]
 			Case 2; ivo_Selecao.ivs_SubGrupo		[] = lvs_Aux[]
			Case 3; ivo_Selecao.ivs_Categoria		[] = lvs_Aux[]
			Case 4; ivo_Selecao.ivs_SubCategoria	[] = lvs_Aux[]
			Case 5; ivo_Selecao.ivs_Mix					[] = lvs_Aux[]
			Case 6; ivo_Selecao.ivs_Produto			[] = lvs_Aux[]
		End Choose
		
	End If
	
Next

//If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = "CO" Then
If Not ivo_Selecao.ivb_Insere_Array Then
	If lvl_InsertRow = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Insira pelo menos uma sele$$HEX2$$e700e300$$ENDHEX$$o de produtos.")
		Return -1
	End If
End If

CloseWithReturn(Parent, ivo_Selecao)
end event

type cb_cancelar from commandbutton within w_ge229_sel_produto_personalizado
integer x = 1682
integer y = 1324
integer width = 347
integer height = 108
integer taborder = 20
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

type cb_excel from commandbutton within w_ge229_sel_produto_personalizado
integer x = 18
integer y = 1324
integer width = 654
integer height = 108
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Importar arquivo .xls"
end type

event clicked;String lvs_caminho = "C:\", &
       lvs_Nm_Arquivo, &
		 lvs_De_Produto, &
		 lvs_De_Apresentacao_Venda

Integer lvi_arquivo

Long lvl_Row, &
     lvl_Linha_Nova, &
	  lvl_Produto, &
	  lvl_Total, &
	  lvl_Limite

lvi_arquivo = GetFileOpenName("Selecione o arquivo", &
                               + lvs_Caminho     , & 
										   lvs_Nm_Arquivo  , & 
											"XLS"           , &
     	                         + "Arquivo Excel (*.XLS),*.XLS")
											
Setpointer(HourGlass!)
											
Choose Case lvi_Arquivo
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Ocorreu um erro ao abrir o arquivo '" + lvs_Nm_Arquivo + "'.")
		Return -1
	Case 0
		Return 1
End Choose
											
Open(w_Aguarde)
w_Aguarde.Title = "Lendo dados do arquivo : '" + Upper(lvs_Nm_Arquivo) + "'."

dc_uo_Excel lvo_Excel
lvo_Excel = Create dc_uo_Excel

lvo_Excel.uo_Referencia_Objeto_Excel(lvs_Caminho)
lvl_Total = lvo_Excel.uo_Verifica_Tamanho_Arquivo("A")

w_Aguarde.uo_Progress.of_SetMax(lvl_Total)

For lvl_Row = 1 To lvl_Total
	
	w_Aguarde.uo_Progress.of_SetProgress(lvl_Row)
	lvl_Produto = Long(lvo_Excel.uo_Lendo_Dados(lvl_Row, "A"))
	lvl_Linha_Nova = tab_1.tabpage_6.dw_12.Event ue_AddRow()
		
	Select de_produto,
			 de_apresentacao_venda
 	  Into :lvs_De_Produto,
			 :lvs_De_Apresentacao_Venda
	  From produto_geral
	 Where cd_produto = :lvl_Produto
	 Using SqlCa;
	 
	 If SqlCa.SqlCode <> 0 Then
		Destroy(lvo_Excel)
		Close(w_Aguarde)
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do produto da planilha.~r C$$HEX1$$f300$$ENDHEX$$digo do produto : " + String(lvl_Produto))
	 End If
	
	tab_1.tabpage_6.dw_12.Object.De_Selecao[lvl_Linha_Nova] = String(lvl_Produto)
	tab_1.tabpage_6.dw_12.Object.De_Grupo  [lvl_Linha_Nova] = lvs_De_Produto + " : " + lvs_De_Apresentacao_Venda
Next

Destroy(lvo_Excel)
Close(w_Aguarde)
end event

