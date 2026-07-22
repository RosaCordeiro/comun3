HA$PBExportHeader$w_ge108_negociacao.srw
forward
global type w_ge108_negociacao from dc_w_response_ok_cancela
end type
type dw_2 from dc_uo_dw_base within w_ge108_negociacao
end type
end forward

global type w_ge108_negociacao from dc_w_response_ok_cancela
integer width = 3575
integer height = 1648
string title = "GE108 - Negocia$$HEX2$$e700e300$$ENDHEX$$o"
dw_2 dw_2
end type
global w_ge108_negociacao w_ge108_negociacao

type variables
dc_uo_ds_base ids_Produtos

uo_Produto	 				io_Produto
uo_ge355_concorrente	io_concorrente 

String is_Vendedor

Decimal idc_vl_tabela_resumo_dia
Decimal idc_vl_liquido_resumo_dia
Decimal idc_vl_tabela_resumo_mes
Decimal idc_vl_liquido_resumo_mes
end variables

forward prototypes
protected function boolean wf_calcula_valores (integer ai_parametro, long row, string data, ref decimal adc_desconto, ref decimal adc_preco, ref decimal adc_rentabilidade)
public function decimal wf_comissao (long as_produto)
public subroutine wf_carrega_valores_resumo ()
public subroutine wf_atualiza_pc_desc_mes_dia ()
end prototypes

protected function boolean wf_calcula_valores (integer ai_parametro, long row, string data, ref decimal adc_desconto, ref decimal adc_preco, ref decimal adc_rentabilidade);Decimal ldc_Valor, ldc_Custo, ldc_Custo_Venda, ldc_Imposto, ldc_Comissao, ldc_Preco, ldc_Preco_UN, ldc_Preco_Tabela
Decimal ldc_PC_ICMS, ldc_Pc_Comissao, ldc_PC_Desconto
Decimal ldc_PC_desc_maximo, ldc_Pc_Rentab_Minima
Decimal ldc_PC_Rentab_Calculada

Long ll_Produto

ldc_Valor = Dec(data)

io_Produto.of_Inicializa()

Choose Case ai_parametro
				
	Case 2 //Preco Final
			
		If ldc_Valor <= 0.00  Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Pre$$HEX1$$e700$$ENDHEX$$o unit$$HEX1$$e100$$ENDHEX$$rio informado $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido.",Exclamation!)
			Return False
		End If
		
		ll_Produto				= dw_1.Object.cd_Produto			[ row ]
		ldc_PC_ICMS			= dw_1.Object.pc_icms 				[ row ]
		ldc_Preco_UN			= dw_1.Object.vl_preco_unitario 	[ row ]
		ldc_Preco_Tabela		= dw_1.Object.vl_preco_tabela 	[ row ]
		ldc_Preco 				= ldc_Valor	
		
		If ldc_preco > ldc_Preco_Tabela Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O pre$$HEX1$$e700$$ENDHEX$$o informado R$ " + String(ldc_Preco, '#,##0.00') + " n$$HEX1$$e300$$ENDHEX$$o pode ser maior que o pre$$HEX1$$e700$$ENDHEX$$o atual de venda R$ " + String(ldc_Preco_Tabela, '#,##0.00') + ".",Exclamation!)
			Return False			
		End If
		
		ldc_PC_Desconto		= round(( (ldc_Preco_UN - ldc_Preco) / ldc_Preco_UN )  * 100 , 2)
			
		io_Produto.of_localiza_codigo_interno( ll_Produto )
		
		If io_Produto.Localizado Then
			If Not io_Produto.of_Existe_Negociacao_Cliente( Ref ldc_PC_desc_maximo, Ref ldc_Pc_Rentab_minima  ) Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Negocia$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o permitida para o produto " +String(ll_Produto) + ".~r~rMotivo: Nenhuma negocia$$HEX2$$e700e300$$ENDHEX$$o vigente no per$$HEX1$$ed00$$ENDHEX$$odo.",Exclamation!)
				Return False
			End If
		End If
		
		//Imposto
		ldc_Custo 			= io_Produto.of_Custo_Medio( )
		
		If ldc_Custo = 0 Then 
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Nenhuma movimenta$$HEX2$$e700e300$$ENDHEX$$o encontrada na filial do produto " +String(ll_Produto) + ".~rProduto com custo ZERO.",Exclamation!)
			Return False
		End If
		
		ldc_Imposto			= Round( ldc_Preco * ( ldc_PC_ICMS / 100 ) , 2)
		
		//Comissao
		ldc_Pc_Comissao	= wf_Comissao( ll_Produto )
		ldc_Comissao		= Round( ldc_Preco * ( ldc_Pc_Comissao / 100 ) , 2)
		
		ldc_PC_Rentab_Calculada = Round( ((  ldc_Valor - ldc_Custo - ldc_Imposto - ldc_Comissao ) / ldc_Valor ) * 100 , 2) 
		
		If ldc_PC_Rentab_Calculada < ldc_PC_Rentab_Minima Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O pre$$HEX1$$e700$$ENDHEX$$o informado $$HEX1$$e900$$ENDHEX$$ menor que o m$$HEX1$$ed00$$ENDHEX$$nimo permitido.", Exclamation! )
			Return False	
		End If
						
		//Verifica a segunda regra para altera$$HEX2$$e700e300$$ENDHEX$$o do pre$$HEX1$$e700$$ENDHEX$$o.
		If Not IsNull( ldc_PC_desc_maximo ) And ldc_PC_desc_maximo > 0.00 Then 
			If ldc_PC_Desconto > ldc_PC_desc_maximo Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O pre$$HEX1$$e700$$ENDHEX$$o informado ultrapassa o % desconto m$$HEX1$$e100$$ENDHEX$$ximo permitido.", Exclamation! )
				Return False
			End If
		End If
		
		adc_preco 		= ldc_Preco
		adc_desconto 	= ldc_PC_Desconto
End Choose

Return True
end function

public function decimal wf_comissao (long as_produto);Decimal ldc_Pc_Comissao

select  p.pc_comissao
	into :ldc_Pc_Comissao
from vendedor v
inner join tipo_comissao t
	on t.cd_tipo_comissao 			= v.cd_tipo_comissao
inner join tipo_comissao_produto p
	on p.cd_tipo_comissao 			= t.cd_tipo_comissao
where v.nr_matricula_vendedor 	= :is_Vendedor
and p.cd_produto 						= :as_produto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case -1
		SqlCa.of_msgdberror( "Erro ao localizar o % comiss$$HEX1$$e300$$ENDHEX$$o do vendedor. Fun$$HEX2$$e700e300$$ENDHEX$$o: wf_comissao()" )
		ldc_Pc_Comissao = 0.00
	Case 100
		ldc_Pc_Comissao = 0.00
End Choose

Return Round(ldc_Pc_Comissao, 2)




end function

public subroutine wf_carrega_valores_resumo ();Decimal ldc_PC_Limite

Date ldt_inicio, ldt_termino

uo_parametro_filial lo
lo = Create uo_parametro_filial
lo.of_localiza_parametro( 'PC_LIMITE_NEGOCIACAO_CLIENTE', ref ldc_PC_Limite )
If IsValid( lo ) Then Destroy lo

ldt_termino 					= Date( gvo_Parametro.dh_movimentacao )
ldt_inicio 					= gf_primeiro_dia_mes( ldt_termino )

dw_2.Object.pc_limite[1] = ldc_PC_Limite

//Dia
select   COALESCE(vl_venda_tabela - vl_devolucao_venda, 0),
		  COALESCE (vl_venda_avista + vl_venda_crediario + vl_venda_convenio + vl_venda_conta_corrente - vl_devolucao_venda, 0)
	into :idc_vl_tabela_resumo_dia,
		  :idc_vl_liquido_resumo_dia
from resumo_movimento_estoque  
where dh_resumo = :ldt_termino
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_msgdbError("Erro ao localizar os valores(dia) do resumo_movimento_estoque. Fun$$HEX2$$e700e300$$ENDHEX$$o: wf_pc_negociacao_mes_dia()")
	Return
End If

//M$$HEX1$$ea00$$ENDHEX$$s
select   COALESCE(sum(vl_venda_tabela) - sum(vl_devolucao_venda) , 0),
	 	  COALESCE(sum(vl_venda_avista) + sum(vl_venda_crediario) + sum(vl_venda_convenio) + sum(vl_venda_conta_corrente) - sum(vl_devolucao_venda), 0)
	into :idc_vl_tabela_resumo_mes,
		  :idc_vl_liquido_resumo_mes
from resumo_movimento_estoque  
where dh_resumo between :ldt_inicio and :ldt_termino
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_msgdbError("Erro ao localizar os valores(m$$HEX1$$ea00$$ENDHEX$$s) do resumo_movimento_estoque. Fun$$HEX2$$e700e300$$ENDHEX$$o: wf_pc_negociacao_mes_dia()")
	Return
End If

dw_2.AcceptText()

//A mudan$$HEX1$$e700$$ENDHEX$$a de cor dos campos da dw_2 estao na propriedade background da datawindow








end subroutine

public subroutine wf_atualiza_pc_desc_mes_dia ();Decimal ldc_Desconto
Decimal ldc_PC_Total
Decimal ldc_Total_Negociacao
Decimal ldc_Total_Tabela

Try

	dw_1.AcceptText()
	
	ldc_Total_Negociacao 	= Round( dw_1.GetItemDecimal(dw_1.RowCount(), "total_negociacao") , 2)
	ldc_Total_Tabela 			= Round( dw_1.GetItemDecimal(dw_1.RowCount(), "total_preco_tabela") , 2)
	
	//Mes
	ldc_Desconto 	 	= Round( ( idc_vl_tabela_resumo_mes + ldc_Total_Tabela ) - ( idc_vl_liquido_resumo_mes + ldc_Total_Negociacao ) , 2)
	ldc_PC_Total 		= Round( (ldc_Desconto * 100) / (idc_vl_tabela_resumo_mes + ldc_Total_Tabela) , 4)
	
	dw_2.Object.pc_desconto_mes[1] = ldc_PC_Total
	
	//Dia
	ldc_Desconto 	 	= Round( (idc_vl_tabela_resumo_dia + ldc_Total_Tabela) - (idc_vl_liquido_resumo_dia + ldc_Total_Negociacao) , 2)
	ldc_PC_Total 		= Round( (ldc_Desconto *100) / (idc_vl_tabela_resumo_dia + ldc_Total_Tabela) , 4)
	
	dw_2.Object.pc_desconto_dia[1] = ldc_PC_Total

Catch (RuntimeError lre)
		MessageBox (	"Aten$$HEX2$$e700e300$$ENDHEX$$o", "Ocorreu um erro ao calcular o desconto. ~r~r"+ & 						
 						"Erro: "+lre.GetMessage( ), StopSign!)
						 
		String lvs_Retorno

		SetNull(lvs_Retorno)
		CloseWithReturn(This, lvs_Retorno)					 	
Finally
	Return
End Try
end subroutine

on w_ge108_negociacao.create
int iCurrent
call super::create
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
end on

on w_ge108_negociacao.destroy
call super::destroy
destroy(this.dw_2)
end on

event ue_postopen;call super::ue_postopen;Long ll_Linhas

io_Produto 		= Create uo_Produto
io_concorrente	= Create uo_ge355_concorrente	 

ll_Linhas = ids_Produtos.RowCount()

If ll_Linhas <= 0 Then
	This.il_Retorno = -1
	Return
End if

If ll_Linhas > 0 Then
	If ids_Produtos.Sharedata( dw_1 )	 < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no evento SharData.", Exclamation!)
		This.il_Retorno = -1
		Return
	End If
End If

dw_2.Event ue_AddRow()

pb_Help.Visible = True

wf_Carrega_Valores_Resumo()
wf_Atualiza_Pc_Desc_Mes_Dia()

dw_1.Event ue_Pos( 1, "de_laboratorio" )
end event

event close;call super::close;If IsValid( io_Produto ) 		Then Destroy io_Produto
If IsValid( io_concorrente )	Then Destroy io_concorrente
end event

event ue_preopen;call super::ue_preopen;String ls_Achou

ids_Produtos = Message.PowerObjectParm

//If Not gvo_Aplicacao.ivo_Seguranca.of_libera_acesso_procedimento("W_GE108_PROCEDIMENTO_VENDEDOR_NEGOCIACAO", ref is_Vendedor) Then
//	This.il_Retorno = -1
//	Return
//End If

is_Vendedor = ids_Produtos.Object.nr_matricula_vendedor [ 1 ]

Select nr_matricula
	Into :ls_Achou
 From vw_vendedor_ativo v
	inner join usuario		  u
		on v.nr_matricula_vendedor 	= u.nr_matricula
Where u.cd_filial 							= :gvo_parametro.cd_filial
	And v.nr_matricula_vendedor 		= :is_Vendedor
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case -1
		SqlCa.of_MsgDbError()
		This.il_Retorno = -1
		Return
		
	Case 100
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Matr$$HEX1$$ed00$$ENDHEX$$cula n$$HEX1$$e300$$ENDHEX$$o localizada no cadastro de vendedores desta filial.", Exclamation! )
		This.il_Retorno = -1
		Return
End Choose
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge108_negociacao
integer x = 18
integer y = 1432
integer width = 146
integer height = 116
end type

event pb_help::clicked;call super::clicked;wf_Help( "Negocia$$HEX2$$e700e300$$ENDHEX$$o (GE108)" )
end event

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge108_negociacao
integer x = 14
integer width = 3534
integer height = 1420
integer weight = 700
string facename = "Verdana"
string text = "Lista de Produtos"
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge108_negociacao
integer x = 37
integer y = 64
integer width = 3493
integer height = 1344
string dataobject = "dw_ge108_lista_produto_negociacao"
boolean vscrollbar = true
end type

event dw_1::constructor;call super::constructor;This.of_SetRowSelection( )
end event

event dw_1::itemchanged;call super::itemchanged;Boolean lb_Atualizar = True

Decimal ldc_Anterior, ldc_Vl_Preco_Final, ldc_Desconto, ldc_Rentabilidade

Choose Case dwo.Name
	Case "de_concorrente"
		If Trim(Data) <> "" Then
			If IsNull( io_Concorrente.nm_concorrente ) Or (data <> io_Concorrente.nm_concorrente ) Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Pressione [ENTER] para selecionar o concorrente.", Exclamation!)				
				Return 1			
			End If
		Else		
			io_Concorrente.of_Inicializa()
			
			This.Object.Cd_Concorrente[ row ] = io_Concorrente.cd_Concorrente
			This.Object.de_Concorrente[ row ] = io_Concorrente.nm_Concorrente
		End If

	Case "vl_preco_negociado"
		ldc_Anterior = This.Object.vl_preco_negociado [ row ]
		
		If Not wf_Calcula_Valores(2, row, Data, Ref ldc_Desconto, Ref ldc_Vl_Preco_Final, Ref ldc_Rentabilidade ) Then
			This.Object.vl_preco_negociado [ row ] = ldc_Anterior
			lb_Atualizar = False
			Return 1
		End If	
End Choose

If lb_Atualizar And ( dwo.Name = 'pc_desconto_negociado' OR  dwo.Name = 'vl_preco_negociado' ) Then
	This.Object.pc_desconto_negociado		[ row ] = ldc_Desconto
	This.Object.vl_preco_negociado			[ row ] = ldc_Vl_Preco_Final
	
	wf_Atualiza_Pc_Desc_Mes_Dia()
End If
end event

event dw_1::ue_key;call super::ue_key;Long ll_Row

ll_Row = dw_1.GetRow()

Choose Case Key
	Case keyEnter!
		If getColumnName() = "de_concorrente" Then
			//Busca somente dos concorrentes locais
			io_concorrente.il_Filial_Retrieve = gvo_Parametro.Cd_Filial
			
			io_concorrente.of_Localiza_concorrente( dw_1.getText() )
					
			If io_Concorrente.Localizado Then
				
				If io_Concorrente.id_situacao <> 'A' Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Concorrente INATIVO.", Exclamation!)
					io_Concorrente.of_Inicializa()
					This.Object.Cd_Concorrente		[ ll_Row ] 	= io_Concorrente.cd_Concorrente
					This.Object.de_Concorrente		[ ll_Row ] 	= io_Concorrente.nm_Concorrente	
					Return -1
				End If
				
				dw_1.Object.cd_concorrente	[ ll_Row ] 	= io_concorrente.Cd_Concorrente
				dw_1.Object.de_concorrente	[ ll_Row ] 	= io_concorrente.Nm_Concorrente
				
				This.Event ue_Pos(ll_Row,"vl_preco_concorrente")
			Else
				io_Concorrente.of_Inicializa()
				
				This.Object.Cd_Concorrente		[ ll_Row ] 	= io_Concorrente.cd_Concorrente
				This.Object.de_Concorrente		[ ll_Row ] 	= io_Concorrente.nm_Concorrente			
			End If
		End If

		Return -1
End Choose

end event

event dw_1::rowfocuschanging;call super::rowfocuschanging;String ls_Null
Decimal ldc_Null

SetNull(ls_Null)
SetNull(ldc_Null)

If currentRow > 0 Then	
	Choose Case getColumnName()
		Case "de_concorrente"
			If IsNull( This.Object.de_concorrente[ currentRow ] ) Or Trim( This.Object.de_concorrente[ currentRow ] ) = "" Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Selecione um concorrente")
				This.Object.de_concorrente[ currentRow ] = ls_Null
				Return -1
			End If
	
		Case "vl_preco_concorrente"
		
			If IsNull( This.Object.vl_preco_concorrente[ currentRow ] ) Or This.Object.vl_preco_concorrente[ currentRow ] = 0 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe o pre$$HEX1$$e700$$ENDHEX$$o unit$$HEX1$$e100$$ENDHEX$$rio do concorrente.")
				This.Object.vl_preco_concorrente[ currentRow ] = ldc_Null
				Return -1
			End If
			
	End Choose
End If
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge108_negociacao
integer x = 2898
integer y = 1440
boolean default = false
end type

event cb_ok::clicked;call super::clicked;String ls_Matricula

Long ll_Concorrente, ll_Row
Decimal ldc_PrecoConcorrente

dw_1.AcceptText()

For ll_Row = 1 To dw_1.RowCount()
	ll_Concorrente 				= dw_1.Object.cd_concorrente			[ ll_Row ] 
	ldc_PrecoConcorrente 	= dw_1.Object.vl_preco_concorrente	[ ll_Row ]
	
	If IsNull(ll_Concorrente) Or ll_Concorrente = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Selecione um concorrente.")
		dw_1.Event ue_Pos(ll_Row, "de_concorrente")
		Return -1
	End If
	
	If IsNull(ldc_PrecoConcorrente) Or ldc_PrecoConcorrente = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe o pre$$HEX1$$e700$$ENDHEX$$o unit$$HEX1$$e100$$ENDHEX$$rio do concorrente.")
		dw_1.Event ue_Pos(ll_Row, "vl_preco_concorrente")
		Return -1
	End If
Next

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Deseja concluir a negocia$$HEX2$$e700e300$$ENDHEX$$o com o cliente ?", Question!, YesNo!, 2 ) = 2 Then
	Return AncestorReturnValue
End If

If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("w_ge108_negociacao", ref ls_Matricula) Then 
	Return AncestorReturnValue
End If

dw_1.Object.nr_matricula_negociacao	[ 1 ] = ls_Matricula
dw_1.Object.nr_matricula_vendedor		[ 1 ] = is_Vendedor 

//ids_Produtos
//Se for aprovada a negociacao
CloseWithReturn(Parent, ids_Produtos)
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge108_negociacao
integer x = 3223
integer y = 1440
integer width = 325
end type

event cb_cancelar::clicked;CloseWithReturn(Parent, ids_Produtos)
end event

type dw_2 from dc_uo_dw_base within w_ge108_negociacao
integer x = 261
integer y = 1460
integer width = 2121
integer height = 76
integer taborder = 20
boolean bringtotop = true
string dataobject = "ds_ge108_pc_negociacao_total_mes_dia"
end type

