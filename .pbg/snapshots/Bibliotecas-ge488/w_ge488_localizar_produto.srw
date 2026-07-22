HA$PBExportHeader$w_ge488_localizar_produto.srw
forward
global type w_ge488_localizar_produto from dc_w_response_ok_cancela
end type
type mle_desc_prd_xml from multilineedit within w_ge488_localizar_produto
end type
type gb_2 from groupbox within w_ge488_localizar_produto
end type
end forward

global type w_ge488_localizar_produto from dc_w_response_ok_cancela
integer width = 1906
integer height = 692
string title = "GE488 - Localizar Produto"
mle_desc_prd_xml mle_desc_prd_xml
gb_2 gb_2
end type
global w_ge488_localizar_produto w_ge488_localizar_produto

type variables
uo_produto io_Produto

String ivs_Chave_Acesso
end variables

on w_ge488_localizar_produto.create
int iCurrent
call super::create
this.mle_desc_prd_xml=create mle_desc_prd_xml
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.mle_desc_prd_xml
this.Control[iCurrent+2]=this.gb_2
end on

on w_ge488_localizar_produto.destroy
call super::destroy
destroy(this.mle_desc_prd_xml)
destroy(this.gb_2)
end on

event open;call super::open;String	ls_Parametro


io_Produto = Create uo_produto 


ls_Parametro		= Message.StringParm
ivs_Chave_Acesso = Mid(ls_Parametro, 1, Pos(ls_Parametro, ";")-1)
ls_Parametro		= Mid(ls_Parametro, Pos(ls_Parametro, ";")+1)


This.y = 450
This.x	= 500

mle_Desc_Prd_Xml.Text	= ls_Parametro
end event

event close;call super::close;Destroy(io_Produto)
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge488_localizar_produto
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge488_localizar_produto
integer y = 280
integer width = 1842
integer height = 184
string text = "Produto"
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge488_localizar_produto
integer y = 344
integer width = 1792
integer height = 88
string dataobject = "dw_ge488_filtro_produto"
end type

event dw_1::ue_key;call super::ue_key;Long lvl_Produto

If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "de_produto"
			OpenWithParm(w_ge488_selecao_produto_nf, ivs_Chave_Acesso+";"+This.GetText())
			
			lvl_Produto = Message.DoubleParm
			
			If lvl_Produto > 0 Then
				io_Produto.Of_Localiza_codigo_interno( lvl_Produto)
				If io_Produto.Localizado Then
					This.Object.cd_produto	[1] = io_Produto.cd_produto
					This.Object.de_produto	[1] = io_Produto.ivs_Descricao_Apresentacao_Estoque
					
					cb_ok.Post Event ue_SetDefault(True)
				End If
			End If
	End Choose
End If
end event

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case "de_produto"
		If Not IsNull(Data) and Trim(Data) <> '' Then
			If Data <> io_Produto.ivs_Descricao_Apresentacao_Estoque	Then
				Return 1
			End If
		Else
			cb_ok.Default = False
			io_Produto.of_Inicializa()
			
			This.Object.cd_produto	[1] = io_Produto.cd_produto
			This.Object.de_Produto	[1] = io_Produto.ivs_Descricao_Apresentacao_Estoque		
		End If
			
End Choose

end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge488_localizar_produto
event ue_setdefault ( boolean pb_habilita )
integer x = 1216
integer y = 492
boolean default = false
end type

event cb_ok::ue_setdefault(boolean pb_habilita);This.Default = pb_habilita
end event

event cb_ok::clicked;call super::clicked;Long	ll_Produto

dw_1.AcceptText()

ll_Produto	= dw_1.Object.cd_produto[1]

If IsNull(ll_Produto) or (ll_Produto = 0) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deve ser selecionado um produto.")
	dw_1.SetFocus()
	Return 1
End If


CloseWithReturn(Parent, ll_Produto)

end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge488_localizar_produto
integer x = 1550
integer y = 492
end type

event cb_cancelar::clicked;//OverRide

CloseWithReturn(Parent, -1)
end event

type mle_desc_prd_xml from multilineedit within w_ge488_localizar_produto
integer x = 55
integer y = 72
integer width = 1774
integer height = 160
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "none"
boolean border = false
boolean displayonly = true
end type

type gb_2 from groupbox within w_ge488_localizar_produto
integer x = 27
integer width = 1833
integer height = 260
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Descri$$HEX2$$e700e300$$ENDHEX$$o do Produto no XML"
borderstyle borderstyle = styleraised!
end type

