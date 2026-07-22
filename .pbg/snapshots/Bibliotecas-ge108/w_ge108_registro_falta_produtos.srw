HA$PBExportHeader$w_ge108_registro_falta_produtos.srw
forward
global type w_ge108_registro_falta_produtos from window
end type
type cb_2 from commandbutton within w_ge108_registro_falta_produtos
end type
type cb_estoque from commandbutton within w_ge108_registro_falta_produtos
end type
type cb_cancelar from commandbutton within w_ge108_registro_falta_produtos
end type
type cb_produto_transferido from commandbutton within w_ge108_registro_falta_produtos
end type
type cb_venda_perdida from commandbutton within w_ge108_registro_falta_produtos
end type
type gb_1 from groupbox within w_ge108_registro_falta_produtos
end type
type cb_1 from commandbutton within w_ge108_registro_falta_produtos
end type
end forward

global type w_ge108_registro_falta_produtos from window
integer x = 41
integer y = 976
integer width = 1989
integer height = 292
boolean titlebar = true
string title = "GE108 - Inclus$$HEX1$$e300$$ENDHEX$$o de Faltas de Produtos"
windowtype windowtype = response!
long backcolor = 80269524
cb_2 cb_2
cb_estoque cb_estoque
cb_cancelar cb_cancelar
cb_produto_transferido cb_produto_transferido
cb_venda_perdida cb_venda_perdida
gb_1 gb_1
cb_1 cb_1
end type
global w_ge108_registro_falta_produtos w_ge108_registro_falta_produtos

type variables
Long ivl_produto
end variables

forward prototypes
public function boolean wf_registra_venda_perdida ()
public function boolean wf_registra_produto_transferido ()
public function boolean wf_registra_substituido_generico ()
end prototypes

public function boolean wf_registra_venda_perdida ();Long lvl_Consulta
			
DateTime lvdh_movimento

lvdh_movimento = gvo_parametro.of_dh_movimentacao()

Select qt_consulta Into :lvl_Consulta
From produto_procurado_zerado
Where cd_filial				= :gvo_parametro.cd_filial
  and cd_produto       		= :ivl_Produto
  and dh_movimentacao	= :lvdh_Movimento
  and id_tipo					= 'F'
Using Sqlca;

Choose Case SqlCa.SqlCode
	Case 0
		Update produto_procurado_zerado
		Set qt_consulta       		= qt_consulta + 1
		Where cd_filial				= :gvo_parametro.cd_filial
		  and cd_produto			= :ivl_produto
		  and dh_movimentacao	= :lvdh_movimento
		  and id_tipo					= 'F'
		Using Sqlca;
		
	Case 100
		Insert Into produto_procurado_zerado (cd_produto,
														 cd_filial,
														 id_tipo,
													    	 dh_movimentacao,   													    
														 qt_consulta,
														 qt_recebida_outra_filial,
														 qt_substituido_generico)  
  	   Values (:ivl_Produto,
		  		:gvo_parametro.cd_filial,
				  'F',
		        :lvdh_Movimento,
					1,
					0,
					0)
	  Using SqlCa;
End Choose

If SqlCa.SqlCode = -1 Then
	SqlCa.of_Rollback()
	SqlCa.of_MsgdbError("N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel registrar falta de produtos.")
	Return False
Else
	SqlCa.of_Commit()
	Return True
End If
end function

public function boolean wf_registra_produto_transferido ();Long lvl_Consulta
			
DateTime lvdh_movimento

lvdh_movimento	= gvo_parametro.of_dh_movimentacao()

Select qt_recebida_outra_filial Into :lvl_Consulta
From produto_procurado_zerado
Where cd_filial				= :gvo_parametro.cd_filial
  and cd_produto			= :ivl_Produto
  and dh_movimentacao	= :lvdh_Movimento
  and id_tipo					= 'F'
Using Sqlca;

Choose Case SqlCa.SqlCode
	Case 0
		Update produto_procurado_zerado
			Set qt_recebida_outra_filial = qt_recebida_outra_filial + 1
		Where cd_filial						= :gvo_parametro.cd_filial
			and cd_produto					= :ivl_produto
			and dh_movimentacao		= :lvdh_movimento
			and id_tipo						= 'F'
		Using Sqlca;
		
	Case 100
		Insert Into produto_procurado_zerado(cd_produto,   
														cd_filial,
														id_tipo,
														dh_movimentacao,
														qt_consulta,
														qt_recebida_outra_filial,
														qt_substituido_generico)  
  	   
		  Values (:ivl_Produto,
		  			:gvo_parametro.cd_filial,
					'F',
					:lvdh_Movimento,
					0,
					1,
					0)
	  Using SqlCa;
	  
End Choose

If SqlCa.SqlCode = -1 Then
	SqlCa.of_Rollback()
	SqlCa.of_MsgdbError("N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel registrar falta de produtos.")
	Return False
Else
	SqlCa.of_Commit()
	Return True
End If
end function

public function boolean wf_registra_substituido_generico ();Long lvl_Consulta
Long lvl_Substituido_Generico
			
DateTime lvdh_movimento

lvdh_movimento	= gvo_parametro.of_dh_movimentacao()

Select qt_substituido_generico Into :lvl_Substituido_Generico
From produto_procurado_zerado
Where cd_filial				= :gvo_parametro.cd_filial
  and cd_produto			= :ivl_produto
  and dh_movimentacao	= :lvdh_Movimento
  and id_tipo					= 'G'
Using Sqlca;

Choose Case SqlCa.SqlCode
	Case 0
		Update produto_procurado_zerado
			Set qt_substituido_generico = qt_substituido_generico + 1
		Where cd_filial						= :gvo_parametro.cd_filial
			and cd_produto					= :ivl_produto
			and dh_movimentacao		= :lvdh_movimento
			and id_tipo						= 'G'
		Using Sqlca;
		
	Case 100
		Insert Into produto_procurado_zerado(cd_produto,   
														cd_filial,
														id_tipo,
														dh_movimentacao,
														qt_consulta,
														qt_substituido_generico,
														qt_recebida_outra_filial)
  	   
		  Values (:ivl_produto,
		  			:gvo_parametro.cd_filial,
					'G',
					:lvdh_Movimento,
					0,
					1,
					0)
	  Using SqlCa;
End Choose

If SqlCa.SqlCode = -1 Then
	SqlCa.of_Rollback()
	SqlCa.of_MsgdbError("N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel gravar o registro do produto.")
	Return False
Else
	SqlCa.of_Commit()
	Return True
End If
end function

on w_ge108_registro_falta_produtos.create
this.cb_2=create cb_2
this.cb_estoque=create cb_estoque
this.cb_cancelar=create cb_cancelar
this.cb_produto_transferido=create cb_produto_transferido
this.cb_venda_perdida=create cb_venda_perdida
this.gb_1=create gb_1
this.cb_1=create cb_1
this.Control[]={this.cb_2,&
this.cb_estoque,&
this.cb_cancelar,&
this.cb_produto_transferido,&
this.cb_venda_perdida,&
this.gb_1,&
this.cb_1}
end on

on w_ge108_registro_falta_produtos.destroy
destroy(this.cb_2)
destroy(this.cb_estoque)
destroy(this.cb_cancelar)
destroy(this.cb_produto_transferido)
destroy(this.cb_venda_perdida)
destroy(this.gb_1)
destroy(this.cb_1)
end on

event open;ivl_Produto = Message.DoubleParm

This.cb_cancelar.SetFocus()
end event

event key;Choose Case Key 
	//Case KeyEscape! ; Close(This)		
	Case KeyP! ; This.cb_venda_perdida.Event Clicked()
	Case KeyR! ; This.cb_produto_transferido.Event Clicked()
End Choose
end event

type cb_2 from commandbutton within w_ge108_registro_falta_produtos
boolean visible = false
integer x = 78
integer y = 60
integer width = 617
integer height = 100
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Substitu$$HEX1$$ed00$$ENDHEX$$do por &Gen$$HEX1$$e900$$ENDHEX$$rico"
end type

event clicked;If wf_Registra_Substituido_Generico() Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Registro inclu$$HEX1$$ed00$$ENDHEX$$do com sucesso.",Information!,OK!)
	Close(Parent)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Problemas na inclus$$HEX1$$e300$$ENDHEX$$o do registro.",StopSign!)
	Close(Parent)
End If
end event

type cb_estoque from commandbutton within w_ge108_registro_falta_produtos
integer x = 914
integer y = 60
integer width = 654
integer height = 100
integer taborder = 40
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Estoque de Outras Filiais"
end type

event clicked;OpenWithParm(w_ge107_consulta_saldo_matriz_response, ivl_produto)

end event

type cb_cancelar from commandbutton within w_ge108_registro_falta_produtos
integer x = 1614
integer y = 60
integer width = 274
integer height = 100
integer taborder = 10
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Cancelar"
end type

event clicked;Close(Parent)
end event

type cb_produto_transferido from commandbutton within w_ge108_registro_falta_produtos
boolean visible = false
integer x = 78
integer y = 60
integer width = 590
integer height = 100
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Recebido de outra Filial"
end type

event clicked;If wf_Registra_Produto_Transferido() Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Registro de Produto Recebido de outra Filial inclu$$HEX1$$ed00$$ENDHEX$$do com sucesso.",Information!,OK!)
	Close(Parent)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Problemas na inclus$$HEX1$$e300$$ENDHEX$$o do produto.",StopSign!)
	Close(Parent)
End If
end event

type cb_venda_perdida from commandbutton within w_ge108_registro_falta_produtos
boolean visible = false
integer x = 78
integer y = 60
integer width = 402
integer height = 100
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Venda &Perdida"
end type

event clicked;If wf_Registra_Venda_Perdida() Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Registro de Venda Perdida inclu$$HEX1$$ed00$$ENDHEX$$do com sucesso.",Information!,OK!)
	Close(Parent)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Problemas na inclus$$HEX1$$e300$$ENDHEX$$o da falta.",StopSign!)
	Close(Parent)
End If
end event

type gb_1 from groupbox within w_ge108_registro_falta_produtos
integer x = 23
integer y = 4
integer width = 1920
integer height = 188
integer taborder = 20
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

type cb_1 from commandbutton within w_ge108_registro_falta_produtos
integer x = 78
integer y = 60
integer width = 791
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Saldo Pendente / Mov. Estoque"
end type

event clicked;OpenWithParm( w_ge108_movimentacao_estoque, ivl_produto )
end event

