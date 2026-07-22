HA$PBExportHeader$w_ge100_autorizacao_trncentre.srw
forward
global type w_ge100_autorizacao_trncentre from dc_w_response
end type
type dw_1 from dc_uo_dw_base within w_ge100_autorizacao_trncentre
end type
type gb_1 from groupbox within w_ge100_autorizacao_trncentre
end type
type cb_ok from commandbutton within w_ge100_autorizacao_trncentre
end type
type st_msg from statictext within w_ge100_autorizacao_trncentre
end type
type cb_cancelar from commandbutton within w_ge100_autorizacao_trncentre
end type
type cb_complemento from commandbutton within w_ge100_autorizacao_trncentre
end type
end forward

global type w_ge100_autorizacao_trncentre from dc_w_response
integer x = 142
integer y = 496
integer width = 3337
integer height = 1300
string title = "GE084 - Pr$$HEX1$$e900$$ENDHEX$$-Autoriza$$HEX2$$e700e300$$ENDHEX$$o TRN-Centre"
boolean controlmenu = false
long backcolor = 80269524
dw_1 dw_1
gb_1 gb_1
cb_ok cb_ok
st_msg st_msg
cb_cancelar cb_cancelar
cb_complemento cb_complemento
end type
global w_ge100_autorizacao_trncentre w_ge100_autorizacao_trncentre

type variables
Decimal {2} vl_desconto

Boolean ivb_Reenvio= False

end variables

forward prototypes
public function boolean wf_dados_complementares ()
public function boolean wf_carrega_produtos ()
end prototypes

public function boolean wf_dados_complementares ();Return True

Long ll_Row

String ls_status
String ls_produto

For ll_Row = 1 To dw_1.RowCount()
	
	ls_status  = dw_1.object.id_erro   [ll_Row]
	ls_produto = dw_1.object.nm_produto[ll_Row]
	
	If ls_status = "21" Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Favor informar os dados complementares para o produto : ~n " + ls_produto , Exclamation!)
		Return False
	End If
	
Next

Return True
end function

public function boolean wf_carrega_produtos ();
Return True

end function

on w_ge100_autorizacao_trncentre.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.gb_1=create gb_1
this.cb_ok=create cb_ok
this.st_msg=create st_msg
this.cb_cancelar=create cb_cancelar
this.cb_complemento=create cb_complemento
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.cb_ok
this.Control[iCurrent+4]=this.st_msg
this.Control[iCurrent+5]=this.cb_cancelar
this.Control[iCurrent+6]=this.cb_complemento
end on

on w_ge100_autorizacao_trncentre.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.gb_1)
destroy(this.cb_ok)
destroy(this.st_msg)
destroy(this.cb_cancelar)
destroy(this.cb_complemento)
end on

event open;call super::open;String  ls_codigo_barras

Long    ll_Row

Decimal {2} ldc_Desconto

This.vl_desconto = 000.00

For ll_row = 1 To Sitef.TrnCentre.ds_Autorizacao.RowCount()

	dw_1.object.cd_produto			[ll_row] = Sitef.TrnCentre.ds_Autorizacao.object.cd_produto			[ll_row]
	dw_1.object.nm_produto			[ll_row] = Sitef.TrnCentre.ds_Autorizacao.object.nm_produto			[ll_row]
	dw_1.object.de_codigo_barras	[ll_row] = Sitef.TrnCentre.ds_Autorizacao.object.de_codigo_barras	[ll_row]
	dw_1.object.qt_autorizada		[ll_row] = Sitef.TrnCentre.ds_Autorizacao.object.qt_autorizada		[ll_row]
	dw_1.object.qt_vendida			[ll_row] = Sitef.TrnCentre.ds_Autorizacao.object.qt_autorizada		[ll_row]
	dw_1.object.vl_preco_farmacia	[ll_row] = Sitef.TrnCentre.ds_Autorizacao.object.vl_preco_farmacia	[ll_row]
	dw_1.object.vl_preco_bruto		[ll_row] = Sitef.TrnCentre.ds_Autorizacao.object.vl_preco_bruto		[ll_row]
	dw_1.object.vl_preco_liquido	[ll_row] = Sitef.TrnCentre.ds_Autorizacao.object.vl_preco_liquido		[ll_row]
	dw_1.object.pc_desconto		[ll_row] = Sitef.TrnCentre.ds_Autorizacao.object.pc_desconto			[ll_row]
	dw_1.object.id_embalagem		[ll_row] = Sitef.TrnCentre.ds_Autorizacao.object.id_embalagem		[ll_row]
	dw_1.object.id_erro				[ll_row] = Sitef.TrnCentre.ds_Autorizacao.object.id_erro				[ll_row]
	dw_1.object.id_complemento	[ll_row] = Sitef.TrnCentre.ds_Autorizacao.object.id_complemento	[ll_row]
	dw_1.object.de_msg_retorno	[ll_row] = Sitef.TrnCentre.ds_Autorizacao.object.de_msg_retorno	[ll_row]
	dw_1.object.pc_desconto_padrao[ll_row] = Sitef.TrnCentre.ds_Autorizacao.object.pc_desconto_padrao[ll_row]
	
	
	If dw_1.object.id_erro[ll_row] = "00" Then
	
		ldc_Desconto += Sitef.TrnCentre.ds_Autorizacao.object.vl_desconto[ll_row]
		
		cb_ok.Enabled = True
		
	End If	
			
Next	

This.vl_desconto = ldc_Desconto

st_msg.Text = Sitef.msg_operador + ' : '

If This.vl_desconto > 000.00 Then
	st_msg.Text += "Produtos com desconto aprovado !"
	st_msg.TextColor = rgb(0,121,24)
End If
end event

type pb_help from dc_w_response`pb_help within w_ge100_autorizacao_trncentre
end type

type dw_1 from dc_uo_dw_base within w_ge100_autorizacao_trncentre
integer x = 50
integer y = 56
integer width = 3186
integer height = 968
boolean bringtotop = true
string dataobject = "dw_ge084_autorizacao_trncentre"
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.ivb_Selecao_Linhas = True
end event

type gb_1 from groupbox within w_ge100_autorizacao_trncentre
integer x = 23
integer width = 3255
integer height = 1052
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

type cb_ok from commandbutton within w_ge100_autorizacao_trncentre
integer x = 2907
integer y = 1072
integer width = 370
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "&OK"
boolean default = true
end type

event clicked;String ls_retorno

If Not wf_dados_complementares() Then Return

dw_1.AcceptText()

If ivb_Reenvio Then
	ls_retorno = "REENVIO"
Else
	ls_retorno = "OK"
End If

CloseWithReturn(Parent,ls_retorno)
end event

event getfocus;This.Weight  = 700
This.Default = True
end event

event losefocus;This.Weight  = 400
This.Default = False
end event

type st_msg from statictext within w_ge100_autorizacao_trncentre
integer x = 23
integer y = 1088
integer width = 1989
integer height = 76
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 128
long backcolor = 80269524
boolean enabled = false
boolean focusrectangle = false
end type

type cb_cancelar from commandbutton within w_ge100_autorizacao_trncentre
integer x = 2519
integer y = 1072
integer width = 370
integer height = 100
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

event clicked;
Parent.vl_desconto = 000.00

CloseWithReturn(Parent,'CANCELAR')


end event

event getfocus;This.Weight  = 700
This.Default = True
end event

event losefocus;This.Weight  = 400
This.Default = False
end event

type cb_complemento from commandbutton within w_ge100_autorizacao_trncentre
integer x = 2043
integer y = 1072
integer width = 457
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "&Complemento"
end type

event clicked;//RETIRADO PARA CONVERS$$HEX1$$c300$$ENDHEX$$O DO CAIXA NO PB12, ACHO QUE N$$HEX1$$c300$$ENDHEX$$O $$HEX1$$c900$$ENDHEX$$ MAIS USADO - Admocir 14/11/2013

//If dw_1.object.id_erro[dw_1.GetRow()] <> "21" Then		
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Dados complementares n$$HEX1$$e300$$ENDHEX$$o exigidos para o produto.",Exclamation!)
//	Return 
//End If
//
//String ls_complemento = ''
//
//s_cl008_trncentre ls_trncentre
//	
//ls_trncentre.de_produto     = dw_1.object.nm_produto[dw_1.GetRow()]
//
//ls_trncentre.id_complemento = TEF.trn_complemento_produto
//	
//OpenWithParm(w_cl008_complemento_TRNCentre,ls_trncentre)
//
//ls_complemento = Message.StringParm
//		
//If ls_complemento <> "CANCELAR" Then
//	
//	Long   ll_find
//	String ls_barras 
//	
//	ls_barras = dw_1.object.de_codigo_barras[dw_1.GetRow()]
//	
//	ll_find = w_cl002_venda.dw_itens.find("de_codigo_barras = '" + ls_barras + "'",1,w_cl002_venda.dw_itens.RowCount())
//	
//	If ll_find > 0 Then
//	
//		w_cl002_venda.dw_itens.object.de_trn_complemento[ll_find] = ls_complemento			
//		
//		dw_1.object.de_complemento[dw_1.GetRow()] = ls_complemento
//		dw_1.object.id_erro       [dw_1.GetRow()] = "DC"
//		
//		//Reenvia a transa$$HEX2$$e700e300$$ENDHEX$$o
//		ivb_Reenvio = True
//		
//	Else
//		
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o foi possivel localizar o produto." , StopSign!)
//		
//	End If	
//		
//End If
end event

event getfocus;This.Weight  = 700
This.Default = True
end event

event losefocus;This.Weight  = 400
This.Default = False
end event

