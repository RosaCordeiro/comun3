HA$PBExportHeader$w_ge162_inclusao_alteracao_produto.srw
forward
global type w_ge162_inclusao_alteracao_produto from dc_w_response
end type
type gb_1 from groupbox within w_ge162_inclusao_alteracao_produto
end type
type dw_1 from dc_uo_dw_base within w_ge162_inclusao_alteracao_produto
end type
type cb_confirmar from commandbutton within w_ge162_inclusao_alteracao_produto
end type
type cb_cancelar from commandbutton within w_ge162_inclusao_alteracao_produto
end type
end forward

global type w_ge162_inclusao_alteracao_produto from dc_w_response
integer width = 3191
integer height = 1860
string title = "GE162 - Inclus$$HEX1$$e300$$ENDHEX$$o / Altera$$HEX2$$e700e300$$ENDHEX$$o de Produtos"
boolean controlmenu = false
long backcolor = 80269524
gb_1 gb_1
dw_1 dw_1
cb_confirmar cb_confirmar
cb_cancelar cb_cancelar
end type
global w_ge162_inclusao_alteracao_produto w_ge162_inclusao_alteracao_produto

type variables
Decimal idc_Vl_Compra

string ivs_distribuidora, &
         ivs_uf

long ivl_produto

uo_produto ivo_produto
end variables

forward prototypes
public subroutine wf_localiza_fornecedor (string as_codigo)
public function boolean wf_existe_codigo_distribuidora (string as_distribuidora, string as_produto, string as_uf)
public function boolean wf_existe_codigo_nosso (string as_distribuidora, long al_produto, string as_uf)
public function boolean wf_valor_caixa_padrao_original (string as_distribuidora, long al_produto, string as_uf, ref long al_qtd_caixa_padrao)
public function boolean wf_valida_valor_caixa_padrao (string as_distribuidora, long al_produto, string as_uf, long al_embalagem_dsitr)
public function integer wf_carrega_ddw ()
end prototypes

public subroutine wf_localiza_fornecedor (string as_codigo);String lvs_Razao

Select nm_razao_social Into :lvs_Razao
From fornecedor
Where cd_fornecedor = :as_Codigo
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		dw_1.Object.Nm_Razao_Social[1] = lvs_Razao
		
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Fornecedor '" + as_Codigo + "' n$$HEX1$$e300$$ENDHEX$$o localizado.")
		
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Fornecedor Usual")
End Choose
end subroutine

public function boolean wf_existe_codigo_distribuidora (string as_distribuidora, string as_produto, string as_uf);Boolean lvb_Retorno = True

Long lvl_Codigo

String lvs_Descricao

Select d.cd_produto,
       g.de_produto + ' : ' + g.de_apresentacao_venda
Into :lvl_Codigo,
     :lvs_Descricao
From distribuidora_produto d,
     produto_geral g
Where d.cd_distribuidora         = :as_Distribuidora
  and d.cd_produto_distribuidora = :as_Produto
  and d.cd_unidade_federacao     = :as_UF
  and g.cd_produto = d.cd_produto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O c$$HEX1$$f300$$ENDHEX$$digo '" + as_Produto + "' da distribuidora j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ relacionado com o nosso c$$HEX1$$f300$$ENDHEX$$digo ~r'" + &
									 String(lvl_Codigo) + " - " + lvs_Descricao + "'.")
		
	Case 100
		lvb_Retorno = False
		
	Case -1
		SqlCa.of_MsgdbError("Verifica$$HEX2$$e700e300$$ENDHEX$$o da Exist$$HEX1$$ea00$$ENDHEX$$ncia do C$$HEX1$$f300$$ENDHEX$$digo do Produto na Distribuidora")
End Choose

Return lvb_Retorno
end function

public function boolean wf_existe_codigo_nosso (string as_distribuidora, long al_produto, string as_uf);Boolean lvb_Retorno = True

String lvs_Distribuidora, &
       lvs_Codigo, &
		 lvs_UF

If as_Distribuidora = "" Then
	dw_1.AcceptText()
	
	lvs_Distribuidora = dw_1.Object.Cd_Distribuidora[1]
	
	If IsNull(lvs_Distribuidora) or Trim(lvs_Distribuidora) = "" Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a distribuidora.")
		dw_1.Event ue_Pos(1, "cd_distribuidora")
		Return True
	End If
Else
	lvs_Distribuidora = as_Distribuidora
End If

If as_UF = "" Then
	dw_1.AcceptText()
	
	lvs_UF = dw_1.Object.Cd_Unidade_Federacao[1]
	
	If IsNull(lvs_UF) or Trim(lvs_UF) = "" Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a U.F..")
		dw_1.Event ue_Pos(1, "cd_unidade_federacao")
		Return True
	End If
Else
	lvs_UF = as_UF
End If

Select cd_produto_distribuidora Into :lvs_Codigo
From distribuidora_produto
Where cd_distribuidora     = :lvs_Distribuidora
  and cd_produto           = :al_Produto
  and cd_unidade_federacao = :lvs_UF
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O nosso c$$HEX1$$f300$$ENDHEX$$digo '" + String(al_Produto) + "' j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ relacionado com o c$$HEX1$$f300$$ENDHEX$$digo '" + &
									 lvs_Codigo + "' da distribuidora.")
		
	Case 100
		lvb_Retorno = False
		
	Case -1
		SqlCa.of_MsgdbError("Verifica$$HEX2$$e700e300$$ENDHEX$$o da Exist$$HEX1$$ea00$$ENDHEX$$ncia do Nosso C$$HEX1$$f300$$ENDHEX$$digo do Produto")
End Choose

Return lvb_Retorno
end function

public function boolean wf_valor_caixa_padrao_original (string as_distribuidora, long al_produto, string as_uf, ref long al_qtd_caixa_padrao);Select Coalesce(qt_embalagem_padrao_distrib, 1)
	Into :al_qtd_caixa_padrao
From distribuidora_produto
Where cd_distribuidora = :as_Distribuidora
	And cd_produto = :al_Produto
	And cd_unidade_federacao = :as_Uf
Using SqlCa;

If SqlCa.SqlCode = - 1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizada a quantidade da caixa padr$$HEX1$$e300$$ENDHEX$$o da distribuidora.")
	Return False
End If
		
Return True
end function

public function boolean wf_valida_valor_caixa_padrao (string as_distribuidora, long al_produto, string as_uf, long al_embalagem_dsitr);Decimal ldc_Med_Distribuidoras
Decimal ldc_Resultado
Decimal ldc_Vl_Compra
Long ll_Pedidos


ldc_Vl_Compra = round(idc_Vl_Compra / al_embalagem_dsitr, 2)

Select 
	count(*) 
Into 
	:ll_Pedidos
From 
	pedido_filial
where 
	dh_emissao in (select dh_movimentacao from parametro where id_parametro = '1')
  	and id_gerado_logistica = 'N'
  	and id_situacao <> 'F'
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Erro ao verificar a gera$$HEX2$$e700e300$$ENDHEX$$o de pedido.")
	Return False
End If

If ll_Pedidos > 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Esta altera$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ permitida pois esta gerando pedido para as distribuidoras.", Exclamation!)
	dw_1.Event ue_Pos(1, "qt_embalagem_padrao_distrib")
	Return False
End If

Select 
	Coalesce(avg( round((round(round(coalesce(d.vl_preco_novo, d.vl_preco_atual) * ((100 - coalesce(d.pc_desconto_novo, d.pc_desconto_atual)) / 100), 2) * ((100 - coalesce(d.pc_repasse_icms, 0)) / 100), 2)   + coalesce(d.vl_icms_st, 0))  / coalesce(d.qt_embalagem_padrao_distrib, 1), 2) ), 0) 
Into 
	:ldc_Med_Distribuidoras
From 
	distribuidora_produto d
Inner Join distribuidora_uf u
	On u.cd_distribuidora = d.cd_distribuidora
	And u.cd_unidade_federacao = d.cd_unidade_federacao
Where 
	d.cd_produto = :al_Produto
	And d.cd_unidade_federacao = :as_Uf
	And d.id_situacao = 'A'
	And d.cd_distribuidora <> :as_Distribuidora
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Erro ao localizar a m$$HEX1$$e900$$ENDHEX$$dia do pre$$HEX1$$e700$$ENDHEX$$o de compra das distribuidoras.")
	Return False
End If

//Se N$$HEX1$$c300$$ENDHEX$$O encontrar na mesma UF procura em outra UF
If ldc_Med_Distribuidoras = 0 Then
	Select 
		Coalesce(avg( round((round(round(coalesce(d.vl_preco_novo, d.vl_preco_atual) * ((100 - coalesce(d.pc_desconto_novo, d.pc_desconto_atual)) / 100), 2) * ((100 - coalesce(d.pc_repasse_icms, 0)) / 100), 2)   + coalesce(d.vl_icms_st, 0))  / coalesce(d.qt_embalagem_padrao_distrib, 1), 2) ), 0) 
	Into 
		:ldc_Med_Distribuidoras
	From 
		distribuidora_produto d
	Inner Join 
		distribuidora_uf u
		On u.cd_distribuidora = d.cd_distribuidora
		And u.cd_unidade_federacao = d.cd_unidade_federacao
	Where 
		d.cd_produto = :al_Produto
		And d.cd_unidade_federacao <> :as_Uf
		And d.id_situacao = 'A'
		And d.cd_distribuidora <> :as_Distribuidora
	Using SqlCa;
		
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgdbError("Erro ao localizar a m$$HEX1$$e900$$ENDHEX$$dia do pre$$HEX1$$e700$$ENDHEX$$o de compra das distribuidoras.")
		Return False
	End If
End If

If ldc_Med_Distribuidoras > 0 Then
	ldc_Resultado = abs(Round((ldc_Vl_Compra / ldc_Med_Distribuidoras ) * 100, 2))
		
	If ldc_Resultado > 130 Then
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o",	"O valor fracionado '" + String(ldc_Vl_Compra, "#,##0.00") + "' $$HEX1$$e900$$ENDHEX$$ superior a m$$HEX1$$e900$$ENDHEX$$dia '" +&
											String(ldc_Med_Distribuidoras, "#,##0.00") + "' das outras distribuidoras [DIFEREN$$HEX1$$c700$$ENDHEX$$A SUPERIOR A 30%].~r~rDeseja continuar mesmo assim?", Question!, YesNo!, 2) = 2 Then
			dw_1.Event ue_Pos(1, "qt_embalagem_padrao_distrib")
			Return False
		End If
	End If
	
	If ldc_Resultado < 70 Then
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o",	"O valor fracionado '" + String(ldc_Vl_Compra, "#,##0.00") + "' $$HEX1$$e900$$ENDHEX$$ inferior a m$$HEX1$$e900$$ENDHEX$$dia '" +&
							String(ldc_Med_Distribuidoras, "#,##0.00") + "' das outras distribuidoras [DIFEREN$$HEX1$$c700$$ENDHEX$$A SUPERIOR A 30%].~r~rDeseja continuar mesmo assim?", Question!, YesNo!, 2) = 2 Then
		
			dw_1.Event ue_Pos(1, "qt_embalagem_padrao_distrib")
			Return False
		End If
	End If
End If

Return True
end function

public function integer wf_carrega_ddw ();DataWindowChild lvdwc

Integer lvi_Retorno,&
        lvi_Row

If dw_1.GetChild("de_alteracao_situacao", lvdwc) = 1 Then
	lvdwc.InsertRow(1)
	
	lvdwc.SetItem(1, "cd_motivo_bloqueio", 0)
	lvdwc.SetItem(1, "de_motivo_bloqueio", string(dw_1.object.de_alteracao_situacao[1]))
	
	dw_1.Object.de_alteracao_situacao[1] = string(dw_1.object.de_alteracao_situacao[1])
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild do motivo_bloqueio.")
End If

Return 1

end function

on w_ge162_inclusao_alteracao_produto.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.dw_1=create dw_1
this.cb_confirmar=create cb_confirmar
this.cb_cancelar=create cb_cancelar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.cb_confirmar
this.Control[iCurrent+4]=this.cb_cancelar
end on

on w_ge162_inclusao_alteracao_produto.destroy
call super::destroy
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.cb_confirmar)
destroy(this.cb_cancelar)
end on

event open;call super::open;String lvs_Parametro

lvs_Parametro = Message.StringParm

If Not IsNull(lvs_Parametro) and lvs_Parametro <> "" Then
	ivs_Distribuidora	= LeftA(lvs_Parametro, 9)
	ivl_Produto       	= Long(MidA(lvs_Parametro, 10, 6))
	ivs_UF            		= MidA(lvs_Parametro, 16, 2)
	idc_Vl_Compra		= Dec(MidA(lvs_Parametro, 18))
Else
	SetNull(ivs_Distribuidora)
	SetNull(ivl_Produto)
	SetNull(ivs_UF)
	SetNull(idc_Vl_Compra)
End If

ivo_Produto = Create uo_Produto
end event

event ue_postopen;call super::ue_postopen;If Not IsNull(ivs_Distribuidora) Then
	If dw_1.Retrieve(ivs_Distribuidora, ivl_Produto, ivs_UF) > 0 Then
		ivo_Produto.of_Localiza_Codigo_Interno(ivl_Produto)
		
		dw_1.Object.Cd_Distribuidora.Protect    	 		= 1
		dw_1.Object.De_Produto.Protect					= 1
		dw_1.Object.Cd_Unidade_Federacao.Protect	= 1
		
		dw_1.SetFocus()
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Cadastro do produto n$$HEX1$$e300$$ENDHEX$$o localizado para altera$$HEX2$$e700e300$$ENDHEX$$o.")
		Close(This)
	End If
Else
	dw_1.Event ue_AddRow()
End If

If dw_1.Object.id_situacao[1]  <> "B" and dw_1.Object.id_situacao[1]  <> "D" Then
	dw_1.Object.dh_alteracao_situacao_termino.Visible = 0
	dw_1.Object.termino_bloqueio_t.Visible = 0
Else	
	dw_1.Object.dh_alteracao_situacao_termino.Visible = 1
	dw_1.Object.termino_bloqueio_t.Visible = 1
End If	

//wf_carrega_ddw()
dw_1.Object.De_Alteracao_Situacao.Protect	= 1
If dw_1.Object.id_situacao[1] = "D" Then dw_1.Object.dh_alteracao_situacao_termino.Protect = 1
end event

event close;call super::close;Destroy(ivo_Produto)
end event

type pb_help from dc_w_response`pb_help within w_ge162_inclusao_alteracao_produto
end type

type gb_1 from groupbox within w_ge162_inclusao_alteracao_produto
integer x = 18
integer width = 3127
integer height = 1652
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

type dw_1 from dc_uo_dw_base within w_ge162_inclusao_alteracao_produto
integer x = 59
integer y = 64
integer width = 3063
integer height = 1580
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge162_inclusao_alteracao_produto"
end type

event constructor;call super::constructor;This.of_SetColSelection(True)
end event

event itemchanged;call super::itemchanged;String ls_Situacao

If dwo.Name = "de_produto" Then
	If Data <> ivo_Produto.ivs_Descricao_Apresentacao_Estoque Then
		Return 1
	End If
End If

ls_Situacao = dw_1.Object.id_situacao_alteracao[1]

If dwo.Name = "id_situacao" Then
	If ls_Situacao <> Data Then dw_1.Object.de_alteracao_situacao[1] = ""
	
	If  Data = "B" Then 
		dw_1.Object.dh_alteracao_situacao_termino.Visible = 1
		dw_1.Object.termino_bloqueio_t.Visible = 1
	Else
		dw_1.Object.dh_alteracao_situacao_termino.Visible = 0
		dw_1.Object.termino_bloqueio_t.Visible = 0
	End If	
	
	dw_1.Object.De_Alteracao_Situacao.Protect	= 0
End If
	
end event

event losefocus;call super::losefocus;If IsValid(ivo_Produto) Then
	This.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque
End If
end event

event ue_key;If Key = KeyEnter! Then
	If This.GetColumnName() = "de_produto" Then
		ivo_Produto.of_Localiza_Produto(This.GetText())
		
		If ivo_Produto.Localizado Then
			If Not wf_Existe_Codigo_Nosso("", ivo_Produto.Cd_Produto, "") Then
				This.Object.Cd_Produto         [1] = ivo_Produto.Cd_Produto
				This.Object.De_Produto         [1] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque
				This.Object.Cd_Fornecedor_Usual[1] = ivo_Produto.Cd_Fornecedor_Usual
				
				wf_Localiza_Fornecedor(ivo_Produto.Cd_Fornecedor_Usual)
			Else
				This.Object.De_Produto[1] = ""
			End If
		End If
	End If
End If
end event

type cb_confirmar from commandbutton within w_ge162_inclusao_alteracao_produto
integer x = 2290
integer y = 1664
integer width = 411
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Con&firmar"
end type

event clicked;Boolean lvb_Sucesso, &
			lb_Validada_Caixa_Pad = False

Integer lvi_Dias_Pgto

String lvs_Distribuidora, &
        lvs_Produto_Atual, &
        lvs_Produto_Novo, &		 
	   lvs_Situacao_Atual, &
	   lvs_Situacao_Nova, &
	   lvs_Motivo, &
	   lvs_Matricula_Preco, &
	   lvs_Matricula_Situacao, &
	   lvs_UF,	 &
	   lvs_Motivo_Novo, &
	   ls_ValorPara, &
	   ls_Chave, &
	   ls_Erro, lvs_Motivo_anterior

Long lvl_Produto
Long ll_Qtd_Emb_Padrao
Long ll_De

Decimal lvdc_Preco_Atual, &
        lvdc_Preco_Novo, &
		lvdc_Desconto_Atual, &
		lvdc_Desconto_Novo,&
		lvdc_ICMS_ST
		  
DateTime lvdh_GetDate, &
         lvdh_Preco, &
         lvdh_Situacao,&
		lvdh_Termino_Bloqueio

dw_1.AcceptText()

lvs_Distribuidora      			= dw_1.Object.Cd_Distribuidora            				[1]
lvl_Produto            			= dw_1.Object.Cd_Produto                  				[1]
lvs_UF                 				= dw_1.Object.Cd_Unidade_Federacao       		[1]
lvs_Produto_Atual      		= dw_1.Object.Cd_Produto_Alteracao        			[1]
lvs_Produto_Novo       		= dw_1.Object.Cd_Produto_Distribuidora    			[1]
lvdc_Preco_Atual       			= dw_1.Object.Vl_Preco_Alteracao         	 		[1]
lvdc_Desconto_Atual    		= dw_1.Object.Pc_Desconto_Alteracao       			[1]
lvdc_Preco_Novo        		= dw_1.Object.Vl_Preco_Atual             	 			[1]
lvdc_Desconto_Novo     		= dw_1.Object.Pc_Desconto_Atual           			[1]
lvs_Situacao_Atual     		= dw_1.Object.Id_Situacao_Alteracao       			[1]
lvs_Situacao_Nova      		= dw_1.Object.Id_Situacao                 				[1]
lvs_Matricula_Preco    		= dw_1.Object.Nr_Matric_Alteracao_Preco   		[1]
lvs_Matricula_Situacao		= dw_1.Object.Nr_Matric_Alteracao_Situacao		[1]
lvdh_Preco             			= dw_1.Object.Dh_Alteracao_Preco       				[1]
lvdh_Situacao          			= dw_1.Object.Dh_Alteracao_Situacao  				[1]
lvdh_Termino_Bloqueio		= dw_1.Object.Dh_Alteracao_Situacao_Termino	[1]
lvdc_ICMS_ST		   			= dw_1.Object.Vl_ICMS_ST			         			[1]
lvi_Dias_Pgto		   			= dw_1.Object.Nr_Dias_Pagamento					[1]
lvs_Motivo_Novo    			= dw_1.Object.De_Alteracao_Situacao       			[1]
lvs_Motivo						= dw_1.Object.De_alteracao_situacao_atual		[1]
ll_Qtd_Emb_Padrao			= dw_1.Object.Qt_Embalagem_Padrao_Distrib		[1]
lvs_Motivo_anterior			= dw_1.Object.de_alteracao_situacao_anterior		[1]

lvdh_GetDate = gf_GetServerDate()

If IsNull(lvs_Distribuidora) or Trim(lvs_Distribuidora) = "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a distribuidora.")
	dw_1.Event ue_Pos(1, "cd_distribuidora")
	Return
End If

If IsNull(lvs_UF) or Trim(lvs_UF) = "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a U.F..")
	dw_1.Event ue_Pos(1, "cd_unidade_federacao")
	Return
End If

If IsNull(lvl_Produto) or lvl_Produto = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o produto.")
	dw_1.Event ue_Pos(1, "de_produto")
	Return
End If

If IsNull(lvs_Produto_Novo) or Trim(lvs_Produto_Novo) = "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o c$$HEX1$$f300$$ENDHEX$$digo do produto na distribuidora.")
	dw_1.Event ue_Pos(1, "cd_produto_distribuidora")
	Return
End If

If lvs_Situacao_Nova = 'B' Then
		If IsNull(lvdh_Termino_Bloqueio) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data fim do bloqueio. Data n$$HEX1$$e300$$ENDHEX$$o pode ser Vazia!")
			dw_1.Event ue_Pos(1,"dh_alteracao_situacao_termino")
			Return
		End If
		If Date(lvdh_Termino_Bloqueio) <= Date(lvdh_GetDate) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data do bloqueio n$$HEX1$$e300$$ENDHEX$$o pode  ser igual ou inferior a hoje.")
			dw_1.Event ue_Pos(1,"dh_alteracao_situacao_termino")
			Return
		End If
Else
	SetNull(lvdh_Termino_Bloqueio)	
End If

//If IsNull(lvdc_Preco_Novo) or lvdc_Preco_Novo <= 0 Then
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O pre$$HEX1$$e700$$ENDHEX$$o atual do produto deve ser maior que zero.")
//	dw_1.Event ue_Pos(1, "vl_preco_atual")
//	Return
//End If

//If IsNull(lvdc_ICMS_ST) or lvdc_ICMS_ST <= 0 Then
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O valor do ICMS por ST deve ser maior que zero.")
//	dw_1.Event ue_Pos(1, "vl_icms_st")
//	Return
//End If

//If IsNull(lvi_Dias_Pgto) or lvi_Dias_Pgto < 0 Then
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$fa00$$ENDHEX$$mero de dias para o pagamento.")
//	dw_1.Event ue_Pos(1, "nr_dias_pagamento")
//	Return
//End If

If ll_Qtd_Emb_Padrao < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A quantidade informada para a caixa padr$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lida.")
	dw_1.Event ue_Pos(1, "qt_embalagem_padrao_distrib")
	Return
End If

SetPointer(HourGlass!)

If IsNull(ivs_Distribuidora) Then
	If wf_Existe_Codigo_Nosso(lvs_Distribuidora, lvl_Produto, lvs_UF) Then
		dw_1.Event ue_Pos(1, "de_produto")
		Return
	End If
	
	If wf_Existe_Codigo_Distribuidora(lvs_Distribuidora, lvs_Produto_Novo, lvs_UF) Then
		dw_1.Event ue_Pos(1, "cd_produto_distribuidora")
		Return
	End If
	
		Insert Into distribuidora_produto (cd_distribuidora,   
											  cd_produto,   
											  cd_unidade_federacao,
											  cd_produto_distribuidora,   
											  vl_preco_atual,   
											  pc_desconto_atual,   
											  vl_preco_anterior,   
											  pc_desconto_anterior,   
											  dh_alteracao_preco_desconto,   
											  nr_matric_alteracao_preco,   
											  dh_inclusao,   
											  id_situacao,   
											  dh_alteracao_situacao,
											  dh_alteracao_situacao_termino,
											  nr_matric_alteracao_situacao,
											  vl_icms_st,
											  nr_dias_pagamento,
											  qt_embalagem_padrao_distrib)
											  
		Values (:lvs_Distribuidora,   
				  :lvl_Produto,   
				:lvs_UF, 
				  :lvs_Produto_Novo,   
				  :lvdc_Preco_Novo,   
				  :lvdc_Desconto_Novo,   
				  0,   
				  0,   
				:lvdh_GetDate,
				:gvo_Aplicacao.ivo_Seguranca.Nr_Matricula,
				:lvdh_GetDate,
				:lvs_Situacao_Nova,
				:lvdh_GetDate,
				:lvdh_Termino_Bloqueio,
				:gvo_Aplicacao.ivo_Seguranca.Nr_Matricula,
				:lvdc_ICMS_ST,
				:lvi_Dias_Pgto,
				:ll_Qtd_Emb_Padrao)
		Using SqlCa;
	

	If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgdbError("Inclus$$HEX1$$e300$$ENDHEX$$o do Produto Distribuidora")
	Else
		lvb_Sucesso = True
	End If	
Else
	If lvs_Produto_Novo <> lvs_Produto_Atual Then
		If wf_Existe_Codigo_Distribuidora(lvs_Distribuidora, lvs_Produto_Novo, lvs_UF) Then
			dw_1.Event ue_Pos(1, "cd_produto_distribuidora")
			Return	
		End If
	End If
	
	If lvdc_Preco_Novo <> lvdc_Preco_Atual or lvdc_Desconto_Novo <> lvdc_Desconto_Atual Then
		lvdh_Preco				= lvdh_GetDate
		lvs_Matricula_Preco	= gvo_Aplicacao.ivo_Seguranca.Nr_Matricula
	End If

	If lvs_Situacao_Nova <> 'A' Then
		If lvs_Situacao_Nova <> lvs_Situacao_Atual Then
			If IsNull(lvs_Motivo_Novo) Or Trim(lvs_Motivo_Novo) = "" Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe o motivo da altera$$HEX2$$e700e300$$ENDHEX$$o.")
				dw_1.Event ue_Pos(1, "de_alteracao_situacao")
				Return
			End If
				
			lvdh_Situacao					= lvdh_GetDate
			lvs_Matricula_Situacao		= gvo_Aplicacao.ivo_Seguranca.Nr_Matricula
			lvs_Motivo_anterior			= lvs_Motivo
			lvs_Motivo						= lvs_Motivo_Novo
		End If
	Else
		If IsNull(lvs_Motivo_Novo) Or Trim(lvs_Motivo_Novo) = "" Then
			lvs_Motivo_Novo = "ATIVA$$HEX2$$c700c300$$ENDHEX$$O DO PROD. SEM MOTIVO INF."
		End If
	
		lvdh_Situacao					= lvdh_GetDate
		lvs_Matricula_Situacao		= gvo_Aplicacao.ivo_Seguranca.Nr_Matricula
		lvs_Motivo_anterior			= lvs_Motivo
		lvs_Motivo						= lvs_Motivo_Novo
	End If
		
	ls_Chave = lvs_Distribuidora + '@#!' + String(lvl_Produto) + '@#!' + lvs_UF
	
	If gf_Houve_Alteracao_Dw(dw_1, 'QT_EMBALAGEM_PADRAO_DISTRIB', 1, Ref ls_ValorPara) Then
		If wf_Valor_Caixa_Padrao_Original(lvs_Distribuidora, lvl_Produto, lvs_Uf, Ref ll_De) Then
			If wf_Valida_Valor_Caixa_Padrao(lvs_Distribuidora, lvl_Produto, lvs_Uf, ll_Qtd_Emb_Padrao) Then
				If gf_Grava_Historico_Alteracao_Tabela('DISTRIBUIDORA_PRODUTO', ls_Chave, 'QT_EMBALAGEM_PADRAO_DISTRIB', String(ll_De), ls_ValorPara, String(gvo_Aplicacao.ivo_Seguranca.Nr_Matricula), 'A', Ref ls_Erro, True) Then
					lb_Validada_Caixa_Pad = True
				End If
			End If
		End If
	Else
		lb_Validada_Caixa_Pad = True
	End If
	
	If Not lb_Validada_Caixa_Pad Then
		Return -1
	End If
		
	Update distribuidora_produto
	Set cd_produto_distribuidora		= :lvs_Produto_Novo,
		 vl_preco_atual						= :lvdc_Preco_Novo,
		pc_desconto_atual					= :lvdc_Desconto_Novo,
		dh_alteracao_preco_desconto	= :lvdh_Preco,
		nr_matric_alteracao_preco		= :lvs_Matricula_Preco,
		id_situacao							= :lvs_Situacao_Nova,
		dh_alteracao_situacao			= :lvdh_Situacao,
		nr_matric_alteracao_situacao	= :lvs_Matricula_Situacao,
		de_alteracao_situacao			= :lvs_Motivo,
		vl_icms_st							= :lvdc_ICMS_ST,
		qt_embalagem_padrao_distrib	= :ll_Qtd_Emb_Padrao,
		dh_alteracao_situacao_termino = :lvdh_Termino_Bloqueio,
		de_alteracao_situacao_anterior = :lvs_Motivo_anterior
	Where cd_distribuidora			= :lvs_Distribuidora
	  and cd_produto					= :lvl_Produto
	  and cd_unidade_federacao	= :lvs_UF
	Using SqlCa;
		
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgdbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do Produto Distribuidora")
	Else
		lvb_Sucesso = True		
	End If
End If

If lvb_Sucesso Then
	SqlCa.of_Commit()	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Atualiza$$HEX2$$e700e300$$ENDHEX$$o do cadastro realizada com sucesso.")
	
	If IsNull(ivs_Distribuidora) Then
		dw_1.Reset()
		dw_1.Event ue_AddRow()
		dw_1.Object.Cd_Distribuidora[1] = lvs_Distribuidora
		dw_1.Event ue_Pos(1, "cd_unidade_federacao")
	Else
		CloseWithReturn(Parent, "S")
	End If
End If

SetPointer(Arrow!)
end event

type cb_cancelar from commandbutton within w_ge162_inclusao_alteracao_produto
integer x = 2734
integer y = 1664
integer width = 411
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Cancelar"
boolean cancel = true
end type

event clicked;CloseWithReturn(Parent, "N")
end event

