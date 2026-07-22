HA$PBExportHeader$w_ge108_mensagem_campanha_cliente.srw
forward
global type w_ge108_mensagem_campanha_cliente from window
end type
type dw_1 from dc_uo_dw_base within w_ge108_mensagem_campanha_cliente
end type
type st_valor_por from statictext within w_ge108_mensagem_campanha_cliente
end type
type st_1 from statictext within w_ge108_mensagem_campanha_cliente
end type
type st_valor_de from statictext within w_ge108_mensagem_campanha_cliente
end type
type st_3 from statictext within w_ge108_mensagem_campanha_cliente
end type
type st_texto from statictext within w_ge108_mensagem_campanha_cliente
end type
type st_titulo from statictext within w_ge108_mensagem_campanha_cliente
end type
type gb_1 from groupbox within w_ge108_mensagem_campanha_cliente
end type
end forward

global type w_ge108_mensagem_campanha_cliente from window
integer x = 402
integer y = 1016
integer width = 3013
integer height = 684
windowtype windowtype = response!
long backcolor = 32768
dw_1 dw_1
st_valor_por st_valor_por
st_1 st_1
st_valor_de st_valor_de
st_3 st_3
st_texto st_texto
st_titulo st_titulo
gb_1 gb_1
end type
global w_ge108_mensagem_campanha_cliente w_ge108_mensagem_campanha_cliente

type variables
STRING ivs_mensagem

Long ivl_Produto

String ivs_Operador

uo_ge108_mensagem_campanha io_Mensagem
end variables

forward prototypes
public function string wf_substitui_variaveis (string ps_texto)
end prototypes

public function string wf_substitui_variaveis (string ps_texto);String ls_Retorno

ls_Retorno = ps_Texto

ls_Retorno = gf_Replace( ls_Retorno, '[%CLIENTE.NM_CLIENTE%]'									, gf_Coalesce( io_Mensagem.io_Cliente.Nm_Cliente					, '' ), 0 )
ls_Retorno = gf_Replace( ls_Retorno, '[%CLIENTE.NM_CONJUGE%]'									, gf_Coalesce( io_Mensagem.io_Cliente.nm_Conjuge					, '' ), 0 )
ls_Retorno = gf_Replace( ls_Retorno, '[%PRODUTO_GERAL.DE_PRODUTO%]'						, gf_Coalesce( io_Mensagem.io_Produto.De_Produto					, '' ), 0 )
ls_Retorno = gf_Replace( ls_Retorno, '[%PRODUTO_GERAL.DE_APRESENTACAO_VENDA%]'	, gf_Coalesce( io_Mensagem.io_Produto.De_Apresentacao_Venda	, '' ), 0 )

Return ls_Retorno
end function

on w_ge108_mensagem_campanha_cliente.create
this.dw_1=create dw_1
this.st_valor_por=create st_valor_por
this.st_1=create st_1
this.st_valor_de=create st_valor_de
this.st_3=create st_3
this.st_texto=create st_texto
this.st_titulo=create st_titulo
this.gb_1=create gb_1
this.Control[]={this.dw_1,&
this.st_valor_por,&
this.st_1,&
this.st_valor_de,&
this.st_3,&
this.st_texto,&
this.st_titulo,&
this.gb_1}
end on

on w_ge108_mensagem_campanha_cliente.destroy
destroy(this.dw_1)
destroy(this.st_valor_por)
destroy(this.st_1)
destroy(this.st_valor_de)
destroy(this.st_3)
destroy(this.st_texto)
destroy(this.st_titulo)
destroy(this.gb_1)
end on

event key;Boolean lb_Fechar = False
Boolean lb_Persiste
Long ll_produto

String ls_Retorno

Choose Case Key 
	Case KeySpaceBar!
		ls_Retorno = 'S'
		lb_Fechar = True
		If dw_1.rowcount( ) > 1 Then
			ll_produto = dw_1.object.cd_produto [dw_1.GetRow()]
		Else
			ll_produto = io_Mensagem.io_Produto.cd_produto
		End If
	Case KeyEscape!
		ls_Retorno = 'N'
		lb_Fechar = True
		ll_produto = io_Mensagem.io_Produto.cd_produto
End Choose

If lb_Fechar Then
	lb_Persiste = gvo_Aplicacao.ivo_Seguranca.of_get_persiste_usuario( )
	
	gvo_Aplicacao.ivo_Seguranca.of_set_persiste_usuario( false )
	
	If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento( "", ref ivs_Operador ) Then 
		gvo_Aplicacao.ivo_Seguranca.of_set_persiste_usuario( lb_Persiste )
		Return -1
	End If
	
	gvo_Aplicacao.ivo_Seguranca.of_set_persiste_usuario( lb_Persiste )
	
	CloseWithReturn( This, ls_Retorno + ivs_Operador + '|'+String(ll_produto) )
End If
end event

event open;Long ll_Produto
Long ll_row
Long ll_row_dw

Decimal ldc_Preco_De
Decimal ldc_Preco_Por
Decimal ldc_Desconto
Decimal ldc_Desconto_Clube
Decimal ldc_Desconto_Campanha

io_Mensagem = Message.PowerObjectParm

If IsNull( io_Mensagem.is_Codigo_Mensagem ) Or IsNull( io_Mensagem.is_Titulo_Mensagem ) Then
	st_Titulo.text = io_Mensagem.io_Produto.ivs_Descricao_Apresentacao_Venda + &
							" (" + String( io_Mensagem.io_Produto.Cd_Produto ) + ") est$$HEX1$$e100$$ENDHEX$$ em promo$$HEX2$$e700e300$$ENDHEX$$o essa semana."
Else
	st_Titulo.text = This.wf_Substitui_Variaveis( io_Mensagem.is_Titulo_Mensagem )
End If

If Not IsNull( io_Mensagem.is_Codigo_Mensagem ) And Not IsNull( io_Mensagem.is_Texto_Mensagem ) Then
	st_Texto.text = This.wf_Substitui_Variaveis( io_Mensagem.is_Texto_Mensagem )
End If

ldc_Preco_De			= io_Mensagem.io_Produto.of_Preco_Venda_Filial()
ldc_Desconto			= io_Mensagem.io_Produto.of_Desconto_Filial()
ldc_Desconto_Clube	= io_Mensagem.io_Produto.of_Desconto_Clube()

If Not IsNull( io_Mensagem.io_Cliente.Cd_Cliente ) Then
	ldc_desconto_campanha = io_Mensagem.io_Produto.Of_Desconto_Campanha( io_Mensagem.io_Cliente.Cd_Cliente )
Else
	ldc_desconto_campanha = 000.00
End If	

If ldc_Desconto_Clube > ldc_Desconto Then
	ldc_Desconto = ldc_Desconto_Clube
End If

If ldc_desconto_campanha > ldc_desconto Then
	ldc_desconto = ldc_desconto_campanha
End If		

ldc_Preco_Por	= Round( ldc_Preco_De * ( (100 - ldc_Desconto ) / 100 ), 2 )

st_Valor_De.Text = String( ldc_Preco_De )
st_Valor_Por.Text = "   Por: R$ " +  String( ldc_Preco_Por )

If io_Mensagem.ids_produtos_campanha.rowcount( ) > 0 Then
	dw_1.visible = True
	dw_1.AcceptText()
	dw_1.Enabled = True
   	dw_1.SetReDraw(True)
	dw_1.SetFocus()
	dw_1.of_setrowselection( )
	
//	ll_total_row = dw_1.RowCount()
	For ll_row = 1 To io_Mensagem.ids_produtos_campanha.rowcount( )		
		
		ll_produto = io_Mensagem.ids_produtos_campanha.object.cd_produto [ll_row]
		
		io_Mensagem.io_Produto.of_localiza_codigo_interno( ll_produto )
		ldc_Preco_De			= io_Mensagem.io_Produto.of_Preco_Venda_Filial()
		ldc_Desconto			= io_Mensagem.io_Produto.of_Desconto_Filial()
		ldc_Desconto_Clube	= io_Mensagem.io_Produto.of_Desconto_Clube()

		If Not IsNull( io_Mensagem.io_Cliente.Cd_Cliente ) Then
			ldc_desconto_campanha = io_Mensagem.io_Produto.Of_Desconto_Campanha( io_Mensagem.io_Cliente.Cd_Cliente )
		Else
			ldc_desconto_campanha = 000.00
		End If	
		
		If ldc_Desconto_Clube > ldc_Desconto Then
			ldc_Desconto = ldc_Desconto_Clube
		End If
		
		If ldc_desconto_campanha > ldc_desconto Then
			ldc_desconto = ldc_desconto_campanha
		End If		
		
		If ldc_Preco_De > Round( ldc_Preco_De * ( (100 - ldc_Desconto ) / 100 ), 2 ) Then
			ll_row_dw = dw_1.rowcount( ) + 1
			dw_1.insertrow( ll_row_dw )
			dw_1.object.cd_produto [ll_row_dw] = io_mensagem.io_produto.cd_produto
			dw_1.object.de_produto [ll_row_dw] = io_mensagem.io_produto.de_produto + ' : ' + io_mensagem.io_produto.de_apresentacao_venda
			dw_1.object.vl_preco_de  [ll_row_dw] = ldc_Preco_De
			dw_1.object.vl_preco_por [ll_row_dw] = Round( ldc_Preco_De * ( (100 - ldc_Desconto ) / 100 ), 2 )	
		End If		
	Next	
	
End If	
SqlCa.of_End_Transaction( ) // Finaliza a transa$$HEX2$$e700e300$$ENDHEX$$o

Return
end event

type dw_1 from dc_uo_dw_base within w_ge108_mensagem_campanha_cliente
boolean visible = false
integer x = 50
integer y = 44
integer width = 2889
integer height = 408
string dataobject = "dw_ge108_lista_produtos_campanha"
boolean vscrollbar = true
end type

event ue_key;call super::ue_key;Choose Case Key 
	Case KeySpaceBar!
		Event key(Key, keyflags)
	Case KeyEscape!
		Event key(Key, keyflags)
End Choose
end event

type st_valor_por from statictext within w_ge108_mensagem_campanha_cliente
integer x = 704
integer y = 320
integer width = 1262
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 16777215
long backcolor = 32768
boolean enabled = false
string text = "none"
boolean focusrectangle = false
end type

type st_1 from statictext within w_ge108_mensagem_campanha_cliente
integer x = 69
integer y = 320
integer width = 224
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 16777215
long backcolor = 32768
boolean enabled = false
string text = "De: R$"
boolean focusrectangle = false
end type

type st_valor_de from statictext within w_ge108_mensagem_campanha_cliente
integer x = 297
integer y = 320
integer width = 398
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 16777215
long backcolor = 32768
boolean enabled = false
string text = "text"
boolean focusrectangle = false
end type

type st_3 from statictext within w_ge108_mensagem_campanha_cliente
integer x = 69
integer y = 540
integer width = 2647
integer height = 76
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 16777215
long backcolor = 32768
boolean enabled = false
string text = "O cliente vai aproveitar a oferta?      [ Espa$$HEX1$$e700$$ENDHEX$$o ] - SIM          [ Esc ] - N$$HEX1$$c300$$ENDHEX$$O"
boolean focusrectangle = false
end type

type st_texto from statictext within w_ge108_mensagem_campanha_cliente
integer x = 69
integer y = 448
integer width = 2857
integer height = 76
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 16777215
long backcolor = 32768
boolean enabled = false
string text = "Informe o cliente para aproveitar essa oferta exclusiva!"
boolean focusrectangle = false
end type

type st_titulo from statictext within w_ge108_mensagem_campanha_cliente
integer x = 69
integer y = 60
integer width = 2875
integer height = 228
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 16777215
long backcolor = 32768
boolean enabled = false
string text = "text"
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_ge108_mensagem_campanha_cliente
integer x = 32
integer y = 4
integer width = 2930
integer height = 640
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 32768
borderstyle borderstyle = styleraised!
end type

