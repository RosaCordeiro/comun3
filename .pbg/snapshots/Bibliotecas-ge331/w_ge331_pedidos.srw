HA$PBExportHeader$w_ge331_pedidos.srw
forward
global type w_ge331_pedidos from dc_w_base
end type
type dw_4 from dc_uo_dw_base within w_ge331_pedidos
end type
type cb_2 from commandbutton within w_ge331_pedidos
end type
type cb_1 from commandbutton within w_ge331_pedidos
end type
type dw_3 from dc_uo_dw_base within w_ge331_pedidos
end type
type dw_2 from dc_uo_dw_base within w_ge331_pedidos
end type
type dw_1 from dc_uo_dw_base within w_ge331_pedidos
end type
type gb_1 from groupbox within w_ge331_pedidos
end type
type gb_2 from groupbox within w_ge331_pedidos
end type
type gb_3 from groupbox within w_ge331_pedidos
end type
type gb_4 from groupbox within w_ge331_pedidos
end type
end forward

global type w_ge331_pedidos from dc_w_base
integer width = 3634
integer height = 1552
string title = "GE331 - Localizar Pedidos"
boolean controlmenu = false
boolean minbox = false
boolean resizable = false
windowtype windowtype = response!
dw_4 dw_4
cb_2 cb_2
cb_1 cb_1
dw_3 dw_3
dw_2 dw_2
dw_1 dw_1
gb_1 gb_1
gb_2 gb_2
gb_3 gb_3
gb_4 gb_4
end type
global w_ge331_pedidos w_ge331_pedidos

event open;call super::open;Date		ld_dt_inicio_nf_remessa, ld_dt_atual
String	ls_Parametro, ls_Cnpj_Fornecedor, ls_Cnpj_Fornecedor_remessa, ls_Chave_Acesso


ls_Parametro = Message.StringParm

ls_Cnpj_Fornecedor	= Mid(ls_Parametro, 1, 14)
ls_Chave_Acesso		= Mid(ls_Parametro, 15, 44)

select top 1 f2.nr_cgc,
		 f1.dh_inicio_nf_remessa
  into :ls_Cnpj_Fornecedor_remessa,
  		 :ld_dt_inicio_nf_remessa
  from fornecedor f1
  left outer join fornecedor f2 on f1.cd_fornecedor_nf_remessa = f2.cd_fornecedor
 where f1.nr_cgc = :ls_Cnpj_Fornecedor
Using SQLCA;

Choose Case SQLCA.SQLCode
	Case -1
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao buscar o fornecedor do CNPJ: ' + ls_Cnpj_Fornecedor + ' Erro: ' + SQLCA.SQLErrText, StopSign!)
		
		Return -1
	Case 100
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'N$$HEX1$$e300$$ENDHEX$$o foi encontrado o fornecedor do CNPJ: ' + ls_Cnpj_Fornecedor, StopSign!)
		
		Return -1
End Choose

ld_dt_atual = Date(gf_GetServerDate())

/*if IsNull(ld_dt_inicio_nf_remessa) or ld_dt_inicio_nf_remessa > ld_dt_atual Then
	SetNull(ls_Cnpj_Fornecedor_remessa)
End If*/
ls_Cnpj_Fornecedor_remessa = ''

dw_1.Retrieve(ls_Cnpj_Fornecedor, ls_Cnpj_Fornecedor_remessa)
dw_4.Retrieve(ls_Chave_Acesso)
end event

on w_ge331_pedidos.create
int iCurrent
call super::create
this.dw_4=create dw_4
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_3=create dw_3
this.dw_2=create dw_2
this.dw_1=create dw_1
this.gb_1=create gb_1
this.gb_2=create gb_2
this.gb_3=create gb_3
this.gb_4=create gb_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_4
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.dw_3
this.Control[iCurrent+5]=this.dw_2
this.Control[iCurrent+6]=this.dw_1
this.Control[iCurrent+7]=this.gb_1
this.Control[iCurrent+8]=this.gb_2
this.Control[iCurrent+9]=this.gb_3
this.Control[iCurrent+10]=this.gb_4
end on

on w_ge331_pedidos.destroy
call super::destroy
destroy(this.dw_4)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_3)
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.gb_1)
destroy(this.gb_2)
destroy(this.gb_3)
destroy(this.gb_4)
end on

type dw_4 from dc_uo_dw_base within w_ge331_pedidos
integer x = 2432
integer y = 72
integer width = 1143
integer height = 980
integer taborder = 40
string dataobject = "dw_ge331_pedido_produtos_nf"
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.of_SetRowSelection()
end event

type cb_2 from commandbutton within w_ge331_pedidos
integer x = 2533
integer y = 1360
integer width = 402
integer height = 92
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Selecionar"
end type

event clicked;Long ll_Pedido

dw_1.AcceptText()

If dw_1.RowCount() > 0 Then
	ll_Pedido = dw_1.Object.nr_pedido[dw_1.GetRow()]
	CloseWithReturn(Parent, ll_Pedido)
Else
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum pedido foi selecionado.")
End If


end event

type cb_1 from commandbutton within w_ge331_pedidos
integer x = 3191
integer y = 1360
integer width = 402
integer height = 92
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Sair"
end type

event clicked;CloseWithReturn(Parent, -1)
end event

type dw_3 from dc_uo_dw_base within w_ge331_pedidos
integer x = 41
integer y = 1152
integer width = 3520
integer height = 168
integer taborder = 50
boolean bringtotop = true
string dataobject = "dw_ge331_pedidos_detalhes"
end type

type dw_2 from dc_uo_dw_base within w_ge331_pedidos
integer x = 1015
integer y = 72
integer width = 1362
integer height = 980
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_ge331_pedido_produtos"
boolean vscrollbar = true
end type

event constructor;call super::constructor;
This.of_SetRowSelection("if(id_possui_prd_nf = ~"S~", if(getrow() = currentrow(), rgb(174, 174, 0), rgb(255, 255, 128)), if(getrow() = currentrow(), rgb(0,128,128), rgb(255,255,255)))", "", false)


end event

type dw_1 from dc_uo_dw_base within w_ge331_pedidos
integer x = 46
integer y = 72
integer width = 910
integer height = 980
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge331_pedidos"
boolean vscrollbar = true
end type

event rowfocuschanged;call super::rowfocuschanged;Long	ll_pedido,&
		ll_Linhas,&
		ll_Linha,&
		ll_Produto_Nota,&
		ll_Find

If currentRow > 0 Then
	dw_1.AcceptText()
	
	dw_3.Object.cd_fornecedor					[1]	=	dw_1.Object.cd_fornecedor					[currentRow]
	dw_3.Object.nm_fornecedor				[1]	=	dw_1.Object.nm_fornecedor				[currentRow]
	dw_3.Object.nm_responsavel				[1]	=	dw_1.Object.nm_usuario						[currentRow]
	dw_3.Object.nr_matricula_responsavel	[1]	=	dw_1.Object.nr_matricula					[currentRow]
	dw_3.Object.de_condicao_pagamento	[1]	=	dw_1.Object.de_condicao					[currentRow]
	dw_3.Object.pc_atendido					[1]	=	dw_1.Object.perc_atendido					[currentRow]
	
	ll_pedido	= 	dw_1.Object.nr_pedido	[currentRow]

	If dw_2.Retrieve(ll_Pedido) > 0 Then
		
		ll_Linhas	= dw_4.RowCount() 
	
		For ll_Linha = 1 To ll_Linhas
			ll_Produto_Nota	= dw_4.Object.cd_produto[ll_Linha]
			
			If Not IsNull(ll_Produto_Nota) Then
				ll_Find = dw_2.Find("cd_produto = "+String(ll_Produto_Nota), 1, dw_2.RowCount())
				
				If ll_Find < 0 Then
					MessageBox("Erro", "Erro no find que localiza o produto na dw_2.")
				End If
				
				If ll_Find > 0 Then
					dw_2.Object.id_possui_prd_nf[ll_Find] = "S"					
				End If
			End If
			
		Next
		
	End If
	
	
End If
end event

event constructor;call super::constructor;This.of_SetRowSelection()
end event

type gb_1 from groupbox within w_ge331_pedidos
integer x = 23
integer y = 24
integer width = 946
integer height = 1036
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Pedidos"
borderstyle borderstyle = styleraised!
end type

type gb_2 from groupbox within w_ge331_pedidos
integer x = 997
integer y = 24
integer width = 1399
integer height = 1036
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Produtos do Pedido"
borderstyle borderstyle = styleraised!
end type

type gb_3 from groupbox within w_ge331_pedidos
integer x = 18
integer y = 1080
integer width = 3570
integer height = 252
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Detalhes do Pedido"
borderstyle borderstyle = styleraised!
end type

type gb_4 from groupbox within w_ge331_pedidos
integer x = 2418
integer y = 24
integer width = 1170
integer height = 1036
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Produtos da Nota"
borderstyle borderstyle = styleraised!
end type

