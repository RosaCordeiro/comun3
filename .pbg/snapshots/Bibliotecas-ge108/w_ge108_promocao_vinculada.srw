HA$PBExportHeader$w_ge108_promocao_vinculada.srw
forward
global type w_ge108_promocao_vinculada from dc_w_response
end type
type tab_vinc from tab within w_ge108_promocao_vinculada
end type
type tp_vinc from userobject within tab_vinc
end type
type gb_1 from groupbox within tp_vinc
end type
type gb_4 from groupbox within tp_vinc
end type
type gb_5 from groupbox within tp_vinc
end type
type gb_3 from groupbox within tp_vinc
end type
type gb_2 from groupbox within tp_vinc
end type
type dw_5 from dc_uo_dw_base within tp_vinc
end type
type dw_2 from dc_uo_dw_base within tp_vinc
end type
type dw_4 from dc_uo_dw_base within tp_vinc
end type
type dw_3 from dc_uo_dw_base within tp_vinc
end type
type dw_1 from dc_uo_dw_base within tp_vinc
end type
type tp_vinc from userobject within tab_vinc
gb_1 gb_1
gb_4 gb_4
gb_5 gb_5
gb_3 gb_3
gb_2 gb_2
dw_5 dw_5
dw_2 dw_2
dw_4 dw_4
dw_3 dw_3
dw_1 dw_1
end type
type tp_progressiva from userobject within tab_vinc
end type
type pb_1 from picturebutton within tp_progressiva
end type
type st_1 from statictext within tp_progressiva
end type
type dw_7 from dc_uo_dw_base within tp_progressiva
end type
type dw_6 from dc_uo_dw_base within tp_progressiva
end type
type tp_progressiva from userobject within tab_vinc
pb_1 pb_1
st_1 st_1
dw_7 dw_7
dw_6 dw_6
end type
type tab_vinc from tab within w_ge108_promocao_vinculada
tp_vinc tp_vinc
tp_progressiva tp_progressiva
end type
end forward

global type w_ge108_promocao_vinculada from dc_w_response
integer width = 3483
integer height = 1812
string title = "GE108 - Promo$$HEX2$$e700f500$$ENDHEX$$es Vinculadas ao Produto"
tab_vinc tab_vinc
end type
global w_ge108_promocao_vinculada w_ge108_promocao_vinculada

type variables
Long il_Produto
String is_Tipo
Decimal idc_desconto
end variables

forward prototypes
public subroutine wf_help ()
public subroutine wf_desconto_progressivo ()
end prototypes

public subroutine wf_help ();If is_tipo <> 'C' Then
	ShowHelp( gvo_Aplicacao.ivs_Path_Manual, KeyWord!, "Promo$$HEX2$$e700e300$$ENDHEX$$o Vinculada (GE108)" )
End If
end subroutine

public subroutine wf_desconto_progressivo ();Long ll_linha, ll_find, ll_linha_grid
Boolean lb_ultima_linha
Decimal {2} ldc_Preco_UN, ldc_null

SetNull(ldc_null)

If tab_vinc.tp_progressiva.dw_6.RowCount() > 0 Then
	tab_vinc.tp_progressiva.visible = True	
	tab_vinc.tp_progressiva.dw_7.Visible		= True
	tab_vinc.tp_progressiva.dw_7.Enabled	= True
	If tab_vinc.tp_vinc.dw_1.RowCount() = 0 Then
		tab_vinc.tp_vinc.Enabled		= False
		tab_vinc.selectedtab = 2
		SetFocus(tab_vinc.tp_progressiva.dw_7)
	End If
	
	uo_produto lo_Produto
	lo_Produto = Create uo_produto	
	
	lo_Produto.of_localiza_codigo_interno( il_Produto )			
	If lo_Produto.Localizado Then
		ldc_Preco_UN		= lo_Produto.of_Preco_Venda_Filial()
	End If
	
	Destroy(lo_produto)
	
	For ll_Linha = 1 To tab_vinc.tp_progressiva.dw_6.RowCount()	
		If ll_Linha = tab_vinc.tp_progressiva.dw_6.RowCount() 	Then	
			lb_ultima_linha = true
		End If
		
		If ll_linha = 1 Then
			tab_vinc.tp_progressiva.dw_7.Object.de_qtd[ll_linha] = String(tab_vinc.tp_progressiva.dw_6.Object.qt_minima[ll_linha])
			If lb_ultima_linha Then
				tab_vinc.tp_progressiva.dw_7.Object.de_qtd[ll_linha] = tab_vinc.tp_progressiva.dw_7.Object.de_qtd[ll_linha] + ' ou mais'
			End If
			If tab_vinc.tp_progressiva.dw_6.Object.tipo[ll_linha] = 'NORMAL' Then
				tab_vinc.tp_progressiva.dw_7.Object.pc_desc_normal[ll_linha] = tab_vinc.tp_progressiva.dw_6.Object.pc_desconto[ll_linha]
				tab_vinc.tp_progressiva.dw_7.Object.vl_desc_normal[ll_linha] = round(ldc_Preco_UN * ((100 - tab_vinc.tp_progressiva.dw_6.Object.pc_desconto[ll_linha]) / 100),2)
				If Not lb_ultima_linha Then
					tab_vinc.tp_progressiva.dw_7.Object.vl_total_normal[ll_linha] = tab_vinc.tp_progressiva.dw_7.Object.vl_desc_normal[ll_linha] * tab_vinc.tp_progressiva.dw_6.Object.qt_minima[ll_linha]
				End If 
			Else
				tab_vinc.tp_progressiva.dw_7.Object.pc_desc_clube[ll_linha] = tab_vinc.tp_progressiva.dw_6.Object.pc_desconto[ll_linha]
				tab_vinc.tp_progressiva.dw_7.Object.vl_desc_clube[ll_linha] = round(ldc_Preco_UN * ((100 - tab_vinc.tp_progressiva.dw_6.Object.pc_desconto[ll_linha]) / 100),2)
				If Not lb_ultima_linha Then				
					tab_vinc.tp_progressiva.dw_7.Object.vl_total_clube[ll_linha] = tab_vinc.tp_progressiva.dw_7.Object.vl_desc_clube[ll_linha] * tab_vinc.tp_progressiva.dw_6.Object.qt_minima[ll_linha]				
				End If
			End If
			tab_vinc.tp_progressiva.dw_7.Object.cd_promocao_progressiva[ll_linha] = tab_vinc.tp_progressiva.dw_6.Object.cd_desc_progressivo[ll_linha]
		Else			
			ll_find    = tab_vinc.tp_progressiva.dw_7.Find ("de_qtd = '" + String(tab_vinc.tp_progressiva.dw_6.Object.qt_minima[ll_linha]) + "'" , 1 ,tab_vinc.tp_progressiva.dw_7.RowCount())
			If ll_find > 0 Then
				If lb_ultima_linha Then
					tab_vinc.tp_progressiva.dw_7.Object.de_qtd[ll_find] = tab_vinc.tp_progressiva.dw_7.Object.de_qtd[ll_find] + ' ou mais'
					//Aqui limpa, porque j$$HEX1$$e100$$ENDHEX$$ pode existir valor nessas colunas
					//tab_vinc.tp_progressiva.dw_7.setvalue( "vl_total_normal", ll_find,"")
					//tab_vinc.tp_progressiva.dw_7.setvalue( "vl_total_clube", ll_find,"")
//					dw_employee.SetValue("emp_state", 3, "Texas")
					tab_vinc.tp_progressiva.dw_7.Object.vl_total_normal[ll_find] = ldc_null
					tab_vinc.tp_progressiva.dw_7.Object.vl_total_clube[ll_find] = ldc_null
				End If				
				If tab_vinc.tp_progressiva.dw_6.Object.tipo[ll_linha] = 'NORMAL' Then
					tab_vinc.tp_progressiva.dw_7.Object.pc_desc_normal[ll_find] = tab_vinc.tp_progressiva.dw_6.Object.pc_desconto[ll_linha]
					If IsNull(tab_vinc.tp_progressiva.dw_7.Object.vl_desc_normal[ll_find]) Or (tab_vinc.tp_progressiva.dw_7.Object.vl_desc_normal[ll_find]) = 0 Then
						tab_vinc.tp_progressiva.dw_7.Object.vl_desc_normal[ll_find] = round(ldc_Preco_UN * ((100 - tab_vinc.tp_progressiva.dw_6.Object.pc_desconto[ll_linha]) / 100),2)
						If Not lb_ultima_linha Then
							tab_vinc.tp_progressiva.dw_7.Object.vl_total_normal[ll_find] = tab_vinc.tp_progressiva.dw_7.Object.vl_desc_normal[ll_find] * tab_vinc.tp_progressiva.dw_6.Object.qt_minima[ll_linha]
						End If
					End If				
				Else
					tab_vinc.tp_progressiva.dw_7.Object.pc_desc_clube[ll_find] = tab_vinc.tp_progressiva.dw_6.Object.pc_desconto[ll_linha]
					If IsNull(tab_vinc.tp_progressiva.dw_7.Object.vl_desc_clube[ll_find]) Or (tab_vinc.tp_progressiva.dw_7.Object.vl_desc_clube[ll_find]) = 0 Then
						tab_vinc.tp_progressiva.dw_7.Object.vl_desc_clube[ll_find] = round(ldc_Preco_UN * ((100 - tab_vinc.tp_progressiva.dw_6.Object.pc_desconto[ll_linha]) / 100),2)
						If Not lb_ultima_linha Then						
							tab_vinc.tp_progressiva.dw_7.Object.vl_total_clube[ll_find] = tab_vinc.tp_progressiva.dw_7.Object.vl_desc_clube[ll_find] * tab_vinc.tp_progressiva.dw_6.Object.qt_minima[ll_linha]
						End If
					End If									
				End If
			Else
				ll_linha_grid = tab_vinc.tp_progressiva.dw_7.RowCount() + 1
				tab_vinc.tp_progressiva.dw_7.InsertRow(ll_linha_grid)
				
				If lb_ultima_linha Then
					tab_vinc.tp_progressiva.dw_7.Object.de_qtd[ll_linha_grid] = String(tab_vinc.tp_progressiva.dw_6.Object.qt_minima[ll_linha]) + ' ou mais'
				Else
					tab_vinc.tp_progressiva.dw_7.Object.de_qtd[ll_linha_grid] = String(tab_vinc.tp_progressiva.dw_6.Object.qt_minima[ll_linha])
				End If
				If tab_vinc.tp_progressiva.dw_6.Object.tipo[ll_linha] = 'NORMAL' Then
					tab_vinc.tp_progressiva.dw_7.Object.pc_desc_normal[ll_linha_grid] = tab_vinc.tp_progressiva.dw_6.Object.pc_desconto[ll_linha]
					tab_vinc.tp_progressiva.dw_7.Object.vl_desc_normal[ll_linha_grid] = round(ldc_Preco_UN * ((100 - tab_vinc.tp_progressiva.dw_6.Object.pc_desconto[ll_linha]) / 100),2)
					If Not lb_ultima_linha Then					
						tab_vinc.tp_progressiva.dw_7.Object.vl_total_normal[ll_linha_grid] = tab_vinc.tp_progressiva.dw_7.Object.vl_desc_normal[ll_linha_grid] * tab_vinc.tp_progressiva.dw_6.Object.qt_minima[ll_linha]
					End If
				Else
					tab_vinc.tp_progressiva.dw_7.Object.pc_desc_clube[ll_linha_grid] = tab_vinc.tp_progressiva.dw_6.Object.pc_desconto[ll_linha]
					tab_vinc.tp_progressiva.dw_7.Object.vl_desc_clube[ll_linha_grid] = round(ldc_Preco_UN * ((100 - tab_vinc.tp_progressiva.dw_6.Object.pc_desconto[ll_linha]) / 100),2)
					If Not lb_ultima_linha Then					
						tab_vinc.tp_progressiva.dw_7.Object.vl_total_clube[ll_linha_grid] = tab_vinc.tp_progressiva.dw_7.Object.vl_desc_clube[ll_linha_grid] * tab_vinc.tp_progressiva.dw_6.Object.qt_minima[ll_linha]
					End If
				End If
				tab_vinc.tp_progressiva.dw_7.Object.cd_promocao_progressiva[ll_linha_grid] = tab_vinc.tp_progressiva.dw_6.Object.cd_desc_progressivo[ll_linha]
			End If
		End If		
	Next
Else
	Return
End If
end subroutine

on w_ge108_promocao_vinculada.create
int iCurrent
call super::create
this.tab_vinc=create tab_vinc
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_vinc
end on

on w_ge108_promocao_vinculada.destroy
call super::destroy
destroy(this.tab_vinc)
end on

event ue_preopen;call super::ue_preopen;tab_vinc.tp_vinc.dw_1.Event ue_AddRow()
tab_vinc.tp_vinc.dw_2.Event ue_AddRow()
tab_vinc.tp_vinc.dw_3.Event ue_AddRow()
tab_vinc.tp_vinc.dw_4.Event ue_AddRow()
tab_vinc.tp_vinc.dw_5.Event ue_AddRow()

String ls_parametro
//il_Produto  = Message.DoubleParm	
ls_parametro = Message.StringParm

idc_desconto = Dec(Trim(gf_captura_valor(ls_parametro, '|', 1, false)))
is_tipo = Trim(gf_captura_valor(ls_parametro, '|', 2, false))
il_Produto = Long(Trim(gf_captura_valor(ls_parametro, '|', 3, false)))

If is_tipo = 'C' Then
	This.Title = 'GE108 - Promo$$HEX2$$e700e300$$ENDHEX$$o PBM Clamed ao Produto'
	tab_vinc.tp_vinc.dw_1.Object.t_aviso.Visible = True
	tab_vinc.tp_vinc.dw_2.Object.t_4.Visible = False
End If

SetPointer(HourGlass!)

tab_vinc.tp_vinc.dw_1.Event ue_Retrieve()

If is_tipo <> 'C' Then
	tab_vinc.tp_progressiva.dw_6.Event ue_Retrieve()
	wf_desconto_progressivo()
Else
	tab_vinc.tp_vinc.text = 'PBM Clamed'
	tab_vinc.tp_vinc.picturename = ''
End If

If tab_vinc.tp_vinc.dw_1.RowCount() = 0 And tab_vinc.tp_progressiva.dw_6.RowCount() = 0 Then
	MessageBox("Aviso","Desconto atual igual ou superior ao da promo$$HEX2$$e700e300$$ENDHEX$$o!",Information!)
	This.il_retorno = -1
	Return
End If

SetPointer(Arrow!)



end event

event key;call super::key;Choose Case key
		
	Case KeyEscape!
		Close( This )
		
	Case KeyF1!
		wf_Help( )
		
End Choose
end event

event ue_postopen;call super::ue_postopen;If tab_vinc.tp_vinc.dw_1.RowCount() > 0 Then
	tab_vinc.selectedtab = 1
	SetFocus(tab_vinc.tp_vinc.dw_1)
Else
	If tab_vinc.tp_progressiva.dw_6.RowCount() > 0 Then
		tab_vinc.selectedtab = 2
		SetFocus(tab_vinc.tp_progressiva.dw_7)
	End If	
End If
end event

type pb_help from dc_w_response`pb_help within w_ge108_promocao_vinculada
boolean visible = false
integer x = 5
integer y = 1468
end type

type tab_vinc from tab within w_ge108_promocao_vinculada
event create ( )
event destroy ( )
integer x = 14
integer y = 16
integer width = 3442
integer height = 1708
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long backcolor = 79741120
boolean raggedright = true
boolean focusonbuttondown = true
integer selectedtab = 2
tp_vinc tp_vinc
tp_progressiva tp_progressiva
end type

on tab_vinc.create
this.tp_vinc=create tp_vinc
this.tp_progressiva=create tp_progressiva
this.Control[]={this.tp_vinc,&
this.tp_progressiva}
end on

on tab_vinc.destroy
destroy(this.tp_vinc)
destroy(this.tp_progressiva)
end on

event selectionchanged;If tab_vinc.tp_progressiva.dw_6.RowCount() > 0 Then
	SetFocus(tab_vinc.tp_progressiva.dw_7)
End If	

end event

type tp_vinc from userobject within tab_vinc
event create ( )
event destroy ( )
integer x = 18
integer y = 112
integer width = 3406
integer height = 1580
long backcolor = 79741120
string text = "Promo$$HEX2$$e700f500$$ENDHEX$$es Vinculadas"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\lista_ofertas.ico"
long picturemaskcolor = 536870912
gb_1 gb_1
gb_4 gb_4
gb_5 gb_5
gb_3 gb_3
gb_2 gb_2
dw_5 dw_5
dw_2 dw_2
dw_4 dw_4
dw_3 dw_3
dw_1 dw_1
end type

on tp_vinc.create
this.gb_1=create gb_1
this.gb_4=create gb_4
this.gb_5=create gb_5
this.gb_3=create gb_3
this.gb_2=create gb_2
this.dw_5=create dw_5
this.dw_2=create dw_2
this.dw_4=create dw_4
this.dw_3=create dw_3
this.dw_1=create dw_1
this.Control[]={this.gb_1,&
this.gb_4,&
this.gb_5,&
this.gb_3,&
this.gb_2,&
this.dw_5,&
this.dw_2,&
this.dw_4,&
this.dw_3,&
this.dw_1}
end on

on tp_vinc.destroy
destroy(this.gb_1)
destroy(this.gb_4)
destroy(this.gb_5)
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.dw_5)
destroy(this.dw_2)
destroy(this.dw_4)
destroy(this.dw_3)
destroy(this.dw_1)
end on

type gb_1 from groupbox within tp_vinc
integer x = 2057
integer y = 1008
integer width = 1330
integer height = 568
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Produtos do Grupo"
borderstyle borderstyle = styleraised!
end type

type gb_4 from groupbox within tp_vinc
integer x = 2057
integer y = 504
integer width = 1330
integer height = 504
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Grupos Vinculados / Condi$$HEX2$$e700e300$$ENDHEX$$o"
borderstyle borderstyle = styleraised!
end type

type gb_5 from groupbox within tp_vinc
integer x = 23
integer y = 1272
integer width = 2016
integer height = 304
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Observa$$HEX2$$e700e300$$ENDHEX$$o"
borderstyle borderstyle = styleraised!
end type

type gb_3 from groupbox within tp_vinc
integer x = 23
integer y = 504
integer width = 2016
integer height = 760
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Produtos"
borderstyle borderstyle = styleraised!
end type

type gb_2 from groupbox within tp_vinc
integer x = 32
integer y = 4
integer width = 3369
integer height = 496
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Promo$$HEX2$$e700f500$$ENDHEX$$es"
borderstyle borderstyle = styleraised!
end type

type dw_5 from dc_uo_dw_base within tp_vinc
integer x = 59
integer y = 1336
integer width = 1947
integer height = 216
integer taborder = 70
boolean bringtotop = true
boolean enabled = false
string dataobject = "dw_ge108_obs_promocao_vinculada"
end type

type dw_2 from dc_uo_dw_base within tp_vinc
integer x = 46
integer y = 552
integer width = 1966
integer height = 692
integer taborder = 50
boolean bringtotop = true
string dataobject = "dw_ge108_lista_produtos_promocao"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.of_SetRowSelection( )
end event

event ue_postretrieve;call super::ue_postretrieve;Long ll_Row, ll_Produto

Decimal {2} ldc_Desc_Fixo, ldc_Preco_clube, ldc_Preco_Final,  ldc_Preco_UN, ldc_Desc_Filial, ldc_desc_Clube

Decimal {2} ldc_Desc_SOS_Filial, ldc_Desc_SOS_Clube

Try
	uo_produto lo_Produto
	lo_Produto = Create uo_produto
	
	Open( w_Aguarde )
	w_Aguarde.Title = "Verificando pre$$HEX1$$e700$$ENDHEX$$os, aguarde..."
	
	w_Aguarde.uo_Progress.of_SetMax( This.RowCount() )
	
	For ll_Row = 1 To This.RowCount()
		w_Aguarde.uo_Progress.of_SetProgress( ll_Row )
				
		ll_Produto = This.Object.cd_produto [ ll_Row ]
		
		lo_Produto.of_localiza_codigo_interno( ll_Produto)	
		
		If lo_Produto.Localizado Then
			ldc_Preco_UN		= lo_Produto.of_Preco_Venda_Filial()
			ldc_Desc_Filial		= lo_Produto.of_Desconto_filial()		
			ldc_Desc_Clube		= lo_Produto.of_Desconto_Clube()
			
			//Calculo Desconto SOS
			ldc_Desc_SOS_Filial	 	= This.Object.pc_desconto			[ ll_Row ]
			ldc_Desc_SOS_Clube	 	= This.Object.pc_desconto_Clube	[ ll_Row ]
			
			If ldc_Desc_Filial > ldc_desc_Clube Then
				ldc_Desc_Fixo = ldc_Desc_Filial
			Else
				ldc_Desc_Fixo = ldc_desc_Clube
			End If
								
			If ldc_Desc_Fixo < ldc_Desc_SOS_Filial Then 
				ldc_Desc_Fixo = ldc_Desc_SOS_Filial
			End If
					
			If ldc_Desc_SOS_Clube > ldc_Desc_Fixo Then
				ldc_Desc_Clube = ldc_Desc_SOS_Clube
			Else
				ldc_Desc_Clube = ldc_Desc_Fixo
			End If
			
			If is_Tipo = 'C' Then
				This.Modify("t_2.Text='PBM'")				
				This.Object.vl_preco_final	[ ll_Row ] = round(ldc_Preco_UN,2)
				This.Object.vl_preco_clube	[ ll_Row ] = round(ldc_Preco_UN * ((100 - ldc_Desc_Fixo) / 100),2)
			Else					
				This.Object.vl_preco_final	[ ll_Row ] = round(ldc_Preco_UN * ((100 - ldc_Desc_Fixo) / 100),2)
				This.Object.vl_preco_clube	[ ll_Row ] = round(ldc_Preco_UN * ((100 - ldc_Desc_Clube) / 100),2)
			End If
			
		End If
	Next
Finally
	If IsValid(lo_Produto) Then Destroy lo_Produto
	This.AcceptText()
	If IsValid(w_Aguarde) Then Close( w_Aguarde )
End Try

Return AncestorReturnValue
end event

event ue_key;call super::ue_key;Choose Case Key
	Case KeyF1!
		wf_Help( )
End Choose
end event

type dw_4 from dc_uo_dw_base within tp_vinc
integer x = 2080
integer y = 1068
integer width = 1253
integer height = 492
integer taborder = 60
boolean bringtotop = true
string dataobject = "dw_ge108_lista_promocao_vinculada_prd"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.of_SetRowSelection( )
end event

event ue_key;call super::ue_key;Choose Case Key
	Case KeyF1!
		wf_Help( )
End Choose
end event

type dw_3 from dc_uo_dw_base within tp_vinc
integer x = 2080
integer y = 556
integer width = 1280
integer height = 436
integer taborder = 50
boolean bringtotop = true
string dataobject = "dw_ge108_grupos_promocao_vinculada"
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.of_SetRowSelection( )
end event

event rowfocuschanged;call super::rowfocuschanged;Long ll_Promocao, ll_Vinculo

If currentrow > 0 Then
	long ll
	
	ll = This.Object.cd_promocao_sos[ currentrow ]
	
	
	If Not IsNull (This.Object.cd_promocao_sos[ currentrow ] ) Then
		ll_Promocao 	= This.Object.cd_promocao_sos	[ currentrow ]
		ll_Vinculo 	 	= This.Object.nr_vinculo				[ currentrow ]
			
		dw_4.Retrieve( ll_Promocao, ll_Vinculo )
	End If	
End If
end event

event ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	This.Event RowFocusChanged( 1 )
End If

Return AncestorReturnValue
end event

event ue_key;call super::ue_key;Choose Case Key
	Case KeyF1!
		wf_Help( )
End Choose
end event

type dw_1 from dc_uo_dw_base within tp_vinc
integer x = 55
integer y = 56
integer width = 3305
integer height = 420
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_ge108_promocoes"
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.of_SetRowSelection( )
end event

event rowfocuschanged;call super::rowfocuschanged;Long ll_Promocao

If currentrow > 0 Then
	If Not IsNull (This.Object.cd_promocao_sos[ currentrow ] ) Then
		ll_Promocao 	= This.Object.cd_promocao_sos	[ currentrow ]
		dw_5.Object.de_promocao[ 1 ] = This.Object.de_promocao[ currentrow ]
		
		SetPointer( HourGlass! )
		
		dw_2.SetRedRaw( False )
		If dw_2.Retrieve( ll_Promocao ) > 0 Then
			dw_2.Event ue_PostRetrieve( dw_2.RowCount() )  	
		End If
		dw_2.SetRedRaw( True )
		
		dw_3.SetRedRaw( False )
		If dw_3.Retrieve( ll_Promocao ) > 0 Then
			dw_3.Event ue_PostRetrieve( dw_3.RowCount() )  
		End If
		dw_3.SetRedRaw( True )
		
		SetPointer( Arrow! )
	End If	
End If
end event

event ue_recuperar;//OverRide

Return This.Retrieve( il_Produto, is_tipo , idc_desconto)
end event

event ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	This.Event RowFocusChanged( 1 )
End If

Return AncestorReturnValue
end event

event ue_key;call super::ue_key;Choose Case Key
	Case KeyF1!
		wf_Help( )
End Choose
end event

type tp_progressiva from userobject within tab_vinc
boolean visible = false
integer x = 18
integer y = 112
integer width = 3406
integer height = 1580
boolean enabled = false
long backcolor = 79741120
string text = "Descontos Progressivos"
long tabtextcolor = 8388608
long tabbackcolor = 79741120
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\desconto_progressivo.png"
long picturemaskcolor = 536870912
pb_1 pb_1
st_1 st_1
dw_7 dw_7
dw_6 dw_6
end type

on tp_progressiva.create
this.pb_1=create pb_1
this.st_1=create st_1
this.dw_7=create dw_7
this.dw_6=create dw_6
this.Control[]={this.pb_1,&
this.st_1,&
this.dw_7,&
this.dw_6}
end on

on tp_progressiva.destroy
destroy(this.pb_1)
destroy(this.st_1)
destroy(this.dw_7)
destroy(this.dw_6)
end on

type pb_1 from picturebutton within tp_progressiva
integer x = 1129
integer y = 1472
integer width = 119
integer height = 104
integer taborder = 20
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string picturename = "Compute!"
alignment htextalign = left!
end type

event clicked;Run( "calc" )
end event

type st_1 from statictext within tp_progressiva
integer x = 37
integer y = 1488
integer width = 1097
integer height = 64
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Se necess$$HEX1$$e100$$ENDHEX$$rio use a calculadora:"
boolean focusrectangle = false
end type

type dw_7 from dc_uo_dw_base within tp_progressiva
integer x = 9
integer y = 36
integer width = 3035
integer height = 1428
integer taborder = 50
boolean bringtotop = true
string dataobject = "dw_ge108_lista_progressivas"
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.of_SetRowSelection( )
end event

event ue_recuperar;//OverRide

Return This.Retrieve()
end event

event ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	This.Event RowFocusChanged( 1 )
End If

Return AncestorReturnValue
end event

event ue_key;call super::ue_key;Choose Case Key
	Case KeyF1!
		wf_Help( )
End Choose
end event

type dw_6 from dc_uo_dw_base within tp_progressiva
boolean visible = false
integer x = 2117
integer y = 548
integer width = 1166
integer height = 420
integer taborder = 60
string dataobject = "ds_ge108_promocoes_progressivas"
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.of_SetRowSelection( )
end event

event ue_recuperar;//OverRide

Return This.Retrieve( il_Produto, idc_desconto)
end event

event ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	tab_vinc.tp_progressiva.visible 	= True
	tab_vinc.tp_progressiva.enabled = True
End If

Return AncestorReturnValue
end event

event ue_key;call super::ue_key;Choose Case Key
	Case KeyF1!
		wf_Help( )
End Choose
end event

