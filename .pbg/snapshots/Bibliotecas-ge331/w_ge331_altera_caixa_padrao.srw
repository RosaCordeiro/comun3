HA$PBExportHeader$w_ge331_altera_caixa_padrao.srw
forward
global type w_ge331_altera_caixa_padrao from dc_w_base
end type
type cb_3 from commandbutton within w_ge331_altera_caixa_padrao
end type
type cb_2 from commandbutton within w_ge331_altera_caixa_padrao
end type
type cb_1 from commandbutton within w_ge331_altera_caixa_padrao
end type
type dw_1 from dc_uo_dw_base within w_ge331_altera_caixa_padrao
end type
type gb_1 from groupbox within w_ge331_altera_caixa_padrao
end type
end forward

global type w_ge331_altera_caixa_padrao from dc_w_base
integer width = 2075
integer height = 652
string title = "WS103 - Cadastrar Caixa Padr$$HEX1$$e300$$ENDHEX$$o"
boolean controlmenu = false
boolean minbox = false
boolean resizable = false
windowtype windowtype = response!
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
gb_1 gb_1
end type
global w_ge331_altera_caixa_padrao w_ge331_altera_caixa_padrao

type variables
String	is_Chave_Acesso
end variables

on w_ge331_altera_caixa_padrao.create
int iCurrent
call super::create
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_3
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.dw_1
this.Control[iCurrent+5]=this.gb_1
end on

on w_ge331_altera_caixa_padrao.destroy
call super::destroy
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event open;call super::open;st_ge331_parametros lst_Parametros

Long ll_produto

String	ls_Desc_Produto,&
		ls_Fornecedor,&
		ls_Nome_Fornecedor

dw_1.Event ue_AddRow()

lst_Parametros = Message.PowerObjectParm

ll_produto				= lst_Parametros.cd_produto
ls_Desc_Produto		= lst_Parametros.de_produto
ls_Fornecedor			= lst_Parametros.cd_fornecedor
ls_Nome_Fornecedor	= lst_Parametros.nm_fornecedor
is_Chave_Acesso		= lst_Parametros.de_Chave_Acesso

dw_1.Object.cd_produto			[1]	= ll_produto
dw_1.Object.de_produto			[1]	= ls_Desc_Produto
dw_1.Object.cd_fornecedor		[1]	= ls_Fornecedor
dw_1.Object.nm_fornecedor	[1]	= ls_Nome_Fornecedor
end event

type cb_3 from commandbutton within w_ge331_altera_caixa_padrao
integer x = 46
integer y = 440
integer width = 370
integer height = 112
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Excluir"
end type

event clicked;String ls_Parametro,&
		ls_Operacao,&
		ls_Fornecedor,&
		ls_Usuario,&
		ls_Erro

Long	ll_Qtde,&
		ll_Produto
		
If Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja excluir a caixa padr$$HEX1$$e300$$ENDHEX$$o?", Question!, YesNo!, 2) = 2 Then
	Return
End If
		
dw_1.AcceptText()

ll_Produto		= dw_1.Object.cd_produto		[1]
ls_Fornecedor	= dw_1.Object.cd_fornecedor	[1]
ls_Parametro	= "S"

delete from produto_caixa_padrao_forn
where cd_produto		= :ll_Produto
	and cd_fornecedor	= :ls_Fornecedor
Using SqlCa;	

If SqlCa.SqlCode = -1 Then
	ls_Erro = SqlCa.SQLErrText
	SqlCa.of_Rollback()
	MessageBox("Erro", "Erro ao excluir a caixa padr$$HEX1$$e300$$ENDHEX$$o: "+ls_Erro)
	ls_Parametro = "N"
End If

UPDATE nf_agendamento_ent_item  
	SET	qt_caixa_padrao = null,
			id_multiplic_dividir_cx_padrao = null
Where de_chave_acesso =   :is_chave_acesso 
	  and cd_produto = :ll_Produto
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_Erro = SqlCa.SQLErrText
	SqlCa.of_Rollback()
	MessageBox("Erro", "Erro ao excluir a caixa padr$$HEX1$$e300$$ENDHEX$$o no agendamento: "+ls_Erro)
	ls_Parametro = "N"
End If


SqlCa.of_Commit()

CloseWithReturn(Parent, ls_Parametro)
end event

type cb_2 from commandbutton within w_ge331_altera_caixa_padrao
integer x = 1001
integer y = 440
integer width = 416
integer height = 112
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Confirmar"
end type

event clicked;String ls_Parametro,&
		ls_Operacao,&
		ls_Fornecedor,&
		ls_Usuario,&
		ls_Erro

Long	ll_Qtde,&
		ll_Produto

dw_1.AcceptText()

ll_Qtde			= dw_1.Object.nr_qtde			[1]
ls_Operacao		= dw_1.Object.id_operacao		[1]
ll_Produto		= dw_1.Object.cd_produto		[1]
ls_Fornecedor	= dw_1.Object.cd_fornecedor	[1]
ls_Parametro	= "S"
ls_Usuario		= gvo_aplicacao.ivo_seguranca.nr_matricula

If IsNull(ll_Qtde) or ll_Qtde < 1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a quantidade.")
	dw_1.Event ue_Pos(1, "nr_qtde")
	Return 1	
End If

If IsNull(ls_Operacao) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a opera$$HEX2$$e700e300$$ENDHEX$$o.")
	dw_1.Event ue_Pos(1, "id_operacao")
	Return 1	
End If

insert into produto_caixa_padrao_forn(
	cd_produto, 
	cd_fornecedor,
	dh_alteracao,
	qt_caixa_padrao,
	nr_matricula_alteracao,
	id_multiplicar_dividir)
values(	:ll_Produto,
			:ls_Fornecedor,
			GetDate(),
			:ll_Qtde,
			:ls_Usuario,
			:ls_Operacao)
Using SqlCa;	

If SqlCa.SqlCode = -1 Then
	ls_Erro = SqlCa.SQLErrText
	SqlCa.of_Rollback()
	MessageBox("Erro", "Erro ao inserir a caixa padr$$HEX1$$e300$$ENDHEX$$o: "+ls_Erro)
	ls_Parametro = "N"
End If

UPDATE nf_agendamento_ent_item  
	SET	qt_caixa_padrao = :ll_Qtde,
			id_multiplic_dividir_cx_padrao = :ls_Operacao
Where de_chave_acesso =   :is_chave_acesso 
	  and cd_produto = :ll_Produto
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_Erro = SqlCa.SQLErrText
	SqlCa.of_Rollback()
	MessageBox("Erro", "Erro ao inserir a caixa padr$$HEX1$$e300$$ENDHEX$$o no agendamento: "+ls_Erro)
	ls_Parametro = "N"
End If
	  
If ls_Parametro = "S" Then
	SqlCa.of_Commit()
End If

CloseWithReturn(Parent, ls_Parametro)
end event

type cb_1 from commandbutton within w_ge331_altera_caixa_padrao
integer x = 1623
integer y = 440
integer width = 402
integer height = 112
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Sair"
end type

event clicked;CloseWithReturn(Parent, "N")
end event

type dw_1 from dc_uo_dw_base within w_ge331_altera_caixa_padrao
integer x = 55
integer y = 68
integer width = 1929
integer height = 324
integer taborder = 20
string dataobject = "dw_ge331_caixa_padrao"
end type

type gb_1 from groupbox within w_ge331_altera_caixa_padrao
integer x = 27
integer width = 1998
integer height = 408
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Tahoma"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

