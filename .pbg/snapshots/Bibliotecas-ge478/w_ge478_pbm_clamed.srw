HA$PBExportHeader$w_ge478_pbm_clamed.srw
forward
global type w_ge478_pbm_clamed from dc_w_response
end type
type tab_vinc from tab within w_ge478_pbm_clamed
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
type tab_vinc from tab within w_ge478_pbm_clamed
tp_vinc tp_vinc
end type
end forward

global type w_ge478_pbm_clamed from dc_w_response
integer width = 3483
integer height = 1812
string title = "GE478 - Promo$$HEX2$$e700f500$$ENDHEX$$es Vinculadas ao Produto"
tab_vinc tab_vinc
end type
global w_ge478_pbm_clamed w_ge478_pbm_clamed

type variables
Long il_Produto
String is_Tipo
Decimal idc_desconto
end variables

forward prototypes
public subroutine wf_help ()
end prototypes

public subroutine wf_help ();If is_tipo <> 'C' Then
	ShowHelp( gvo_Aplicacao.ivs_Path_Manual, KeyWord!, "Promo$$HEX2$$e700e300$$ENDHEX$$o Vinculada (GE478)" )
End If
end subroutine

on w_ge478_pbm_clamed.create
int iCurrent
call super::create
this.tab_vinc=create tab_vinc
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_vinc
end on

on w_ge478_pbm_clamed.destroy
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
	This.Title = 'GE478 - Promo$$HEX2$$e700e300$$ENDHEX$$o PBM Clamed ao Produto'
	tab_vinc.tp_vinc.dw_1.Object.t_aviso.Visible = False
	tab_vinc.tp_vinc.dw_2.Object.t_4.Visible = False
	tab_vinc.tp_vinc.text = 'PBM Clamed'
	tab_vinc.tp_vinc.picturename = ''
End If

SetPointer(HourGlass!)

tab_vinc.tp_vinc.dw_1.Event ue_Retrieve()

If tab_vinc.tp_vinc.dw_1.RowCount() = 0 Then
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
End If
end event

type pb_help from dc_w_response`pb_help within w_ge478_pbm_clamed
boolean visible = false
integer x = 5
integer y = 1468
end type

type tab_vinc from tab within w_ge478_pbm_clamed
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
end type

on tab_vinc.create
this.tp_vinc=create tp_vinc
this.Control[]={this.tp_vinc}
end on

on tab_vinc.destroy
destroy(this.tp_vinc)
end on

event selectionchanged;//If tab_vinc.tp_progressiva.dw_6.RowCount() > 0 Then
//	SetFocus(tab_vinc.tp_progressiva.dw_7)
//End If	
//
end event

type tp_vinc from userobject within tab_vinc
event create ( )
event destroy ( )
integer x = 18
integer y = 112
integer width = 3406
integer height = 1580
long backcolor = 79741120
string text = "Promo$$HEX2$$e700f500$$ENDHEX$$s Vinculadas"
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
string dataobject = "dw_ge478_obs_promocao_vinculada"
end type

type dw_2 from dc_uo_dw_base within tp_vinc
integer x = 46
integer y = 552
integer width = 1966
integer height = 692
integer taborder = 50
boolean bringtotop = true
string dataobject = "dw_ge478_lista_produtos_promocao"
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
	
	For ll_Row = 1 To This.RowCount()
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
string dataobject = "dw_ge478_lista_promocao_vinculada_prd"
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
string dataobject = "dw_ge478_grupos_promocao_vinculada"
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
integer x = 46
integer y = 64
integer width = 3305
integer height = 420
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_ge478_promocoes"
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

