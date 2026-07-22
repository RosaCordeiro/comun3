HA$PBExportHeader$w_ge108_mensagem_campanha_cliente_2.srw
forward
global type w_ge108_mensagem_campanha_cliente_2 from window
end type
type st_3 from statictext within w_ge108_mensagem_campanha_cliente_2
end type
type st_texto from statictext within w_ge108_mensagem_campanha_cliente_2
end type
type st_titulo from statictext within w_ge108_mensagem_campanha_cliente_2
end type
type gb_1 from groupbox within w_ge108_mensagem_campanha_cliente_2
end type
end forward

global type w_ge108_mensagem_campanha_cliente_2 from window
integer x = 402
integer y = 1016
integer width = 3013
integer height = 684
windowtype windowtype = response!
long backcolor = 32768
st_3 st_3
st_texto st_texto
st_titulo st_titulo
gb_1 gb_1
end type
global w_ge108_mensagem_campanha_cliente_2 w_ge108_mensagem_campanha_cliente_2

type variables
STRING ivs_mensagem

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
ls_Retorno = gf_Replace( ls_Retorno, '<br />'																	, CHAR(10) + CHAR(13), 0 )

Return ls_Retorno
end function

on w_ge108_mensagem_campanha_cliente_2.create
this.st_3=create st_3
this.st_texto=create st_texto
this.st_titulo=create st_titulo
this.gb_1=create gb_1
this.Control[]={this.st_3,&
this.st_texto,&
this.st_titulo,&
this.gb_1}
end on

on w_ge108_mensagem_campanha_cliente_2.destroy
destroy(this.st_3)
destroy(this.st_texto)
destroy(this.st_titulo)
destroy(this.gb_1)
end on

event key;Boolean lb_Fechar = False
Boolean lb_Persiste

String ls_Retorno

Choose Case Key 
	Case KeySpaceBar!
		ls_Retorno = 'S'
		lb_Fechar = True

	Case KeyEscape!
		ls_Retorno = 'N'
		lb_Fechar = True
End Choose

If lb_Fechar Then
	lb_Persiste = gvo_Aplicacao.ivo_Seguranca.of_get_persiste_usuario( )
	
	gvo_Aplicacao.ivo_Seguranca.of_set_persiste_usuario( false )
	
	If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento( "", ref ivs_Operador ) Then 
		gvo_Aplicacao.ivo_Seguranca.of_set_persiste_usuario( lb_Persiste )
		Return -1
	End If
	
	gvo_Aplicacao.ivo_Seguranca.of_set_persiste_usuario( lb_Persiste )
	
	CloseWithReturn( This, ls_Retorno + ivs_Operador )
End If
end event

event open;Long ll_Produto

Decimal ldc_Preco_De
Decimal ldc_Preco_Por
Decimal ldc_Desconto
Decimal ldc_Desconto_Clube
Decimal ldc_Desconto_Campanha

io_Mensagem = Message.PowerObjectParm

If Not IsNull( io_Mensagem.is_Titulo_Mensagem ) Then
	st_Titulo.text = This.wf_Substitui_Variaveis( io_Mensagem.is_Titulo_Mensagem )
End If

If Not IsNull( io_Mensagem.is_Texto_Mensagem ) Then
	st_Texto.text = This.wf_Substitui_Variaveis( io_Mensagem.is_Texto_Mensagem )
End If

Return
end event

type st_3 from statictext within w_ge108_mensagem_campanha_cliente_2
integer x = 69
integer y = 544
integer width = 2875
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
string text = "[ Espa$$HEX1$$e700$$ENDHEX$$o ] - Fechar"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_texto from statictext within w_ge108_mensagem_campanha_cliente_2
integer x = 69
integer y = 300
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
string text = "texto"
boolean focusrectangle = false
end type

type st_titulo from statictext within w_ge108_mensagem_campanha_cliente_2
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
string text = "titulo"
boolean focusrectangle = false
end type

type gb_1 from groupbox within w_ge108_mensagem_campanha_cliente_2
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

