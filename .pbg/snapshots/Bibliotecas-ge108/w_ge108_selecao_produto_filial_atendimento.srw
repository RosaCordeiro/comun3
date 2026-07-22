HA$PBExportHeader$w_ge108_selecao_produto_filial_atendimento.srw
forward
global type w_ge108_selecao_produto_filial_atendimento from dc_w_selecao_generica
end type
end forward

global type w_ge108_selecao_produto_filial_atendimento from dc_w_selecao_generica
integer width = 3616
integer height = 1808
string title = "GE108 - Sele$$HEX2$$e700e300$$ENDHEX$$o de Produtos [Atendimento ao Cliente]"
end type
global w_ge108_selecao_produto_filial_atendimento w_ge108_selecao_produto_filial_atendimento

type variables
//uo_Produto ivo_Produto_Parent
uo_ge108_produto ivo_Produto_Parent

uo_categoria io_Categoria_Produto // GE022

uo_condicao_venda_convenio io_condicao_convenio // GE006

uo_parametro_filial	ivo_parametro

String is_utiliza_lista_tecnica

Decimal idc_Rentabilidade_Negativa, idc_Rentabilidade_Positiva

Boolean ib_Dermaclub_ativo						= False
end variables

forward prototypes
public subroutine wf_atualiza_precos ()
public subroutine wf_inclui_produto (long pl_produto)
public function integer wf_verifica_pbm (long pl_produto)
end prototypes

public subroutine wf_atualiza_precos ();Boolean lb_Aplica_Desconto_Convenio = True

Long lvl_Linhas
Long lvl_Contador
Long lvl_Produto
Long lvl_Filial
Long ll_Aux
Long ll_convenio
Long ll_contrato
Long ll_row

Decimal ldc_Preco_Bruto
Decimal ldc_Desconto_Filial
Decimal ldc_Desconto_Clube
Decimal ldc_valor_fpb
Decimal ldc_desconto_plano_saude
Decimal ldc_desconto_plano_aux
Decimal ldc_rentabilidade
Decimal ldc_vl_rentabilidade

String lvs_gratis_popular

uo_Produto lvo_Produto
lvo_Produto = Create uo_Produto

SetPointer(HourGlass!)
Open(w_Aguarde)
w_Aguarde.Title = "Verificando Pre$$HEX1$$e700$$ENDHEX$$os e Descontos..."

lvl_Linhas = dw_2.RowCount()
w_Aguarde.uo_Progress.of_SetMax(lvl_Linhas)

lvl_Filial = gvo_Parametro.of_Filial()

For lvl_Contador = 1 To lvl_Linhas
	lvl_Produto = dw_2.Object.Cd_Produto[lvl_Contador]	
	
	lvo_Produto.of_Localiza_Codigo_Interno(lvl_Produto)
	
	If lvo_Produto.Localizado Then
		If lvo_produto.of_possui_pbm_clamed() Then
			dw_2.Object.id_pbm_clamed[lvl_Contador] = 'S'
		End If
		If Not ib_Dermaclub_ativo Then
			dw_2.Object.cd_produto_dermaclub[lvl_Contador] = 0
		End If
		
		ldc_Preco_Bruto		= lvo_Produto.of_Preco_Venda_Filial( )
		ldc_Desconto_Clube	= lvo_Produto.of_Desconto_Clube( )
		ldc_Desconto_Filial	= lvo_Produto.of_Desconto_Filial( )
		
		If ldc_Desconto_Filial > ldc_Desconto_Clube Then
			ldc_Desconto_Clube = ldc_Desconto_Filial
		End If
		If IsNull(lvo_produto.vl_reembolso_fpb) or lvo_produto.vl_reembolso_fpb < 0 Then
			ldc_valor_fpb = 0
		Else
			ldc_valor_fpb = lvo_produto.vl_reembolso_fpb
		End If		
			
		If io_condicao_convenio.localizado Then
			/****** TESTE DE RESTRICOES *******/
			If io_condicao_convenio.id_restricao_produto <> "N" Then
				Select cd_produto 
				Into :ll_Aux
				From restricao_convenio_produto
				Where cd_convenio				= :io_condicao_convenio.cd_convenio
					And cd_condicao_convenio	= :io_condicao_convenio.cd_condicao_convenio
					And cd_produto				= :lvo_Produto.cd_Produto
				Using SqlCa;
				
				Choose Case Sqlca.SQLCode
					Case -1
						SqlCa.of_RollBack( )
						Sqlca.of_MsgDBError("Restri$$HEX2$$e700e300$$ENDHEX$$o produto convenio.")
						lb_Aplica_Desconto_Convenio = False
			
					Case 100
						If io_condicao_convenio.id_restricao_produto = "S" Then 
							lb_Aplica_Desconto_Convenio = False
						End If
				
					Case Else
						If io_condicao_convenio.id_restricao_produto = "E" Then
							lb_Aplica_Desconto_Convenio = False
						End If
				End Choose
			End If
			
			If io_condicao_convenio.id_restricao_grupo_produto <> "N" And lb_Aplica_Desconto_Convenio Then	
				Select cd_grupo_produto 
				Into :ll_Aux
				From restricao_convenio_grupo
				Where cd_convenio				= :io_condicao_convenio.cd_convenio
					And cd_condicao_convenio	= :io_condicao_convenio.cd_condicao_convenio
					And cd_grupo_produto		= :lvo_Produto.cd_Grupo_Produto
				Using SqlCa;
			
				Choose Case Sqlca.SQLCode
					Case -1
						SqlCa.of_RollBack( )
						Sqlca.of_MsgDBError("Restri$$HEX2$$e700e300$$ENDHEX$$o grupo convenio.")
						lb_Aplica_Desconto_Convenio = False
			
					Case 100
						If io_condicao_convenio.id_restricao_produto = "S" Then 
							lb_Aplica_Desconto_Convenio = False
						End If
				
					Case Else
						If io_condicao_convenio.id_restricao_produto = "E" Then
							lb_Aplica_Desconto_Convenio = False
						End If
				End Choose	
			End If
			/*************/			
			
			If lb_Aplica_Desconto_Convenio Then
				ldc_Desconto_Filial = io_condicao_convenio.pc_desconto_minimo
		
				If io_condicao_convenio.id_considera_desc_produto = 'S' Then
					ldc_Desconto_Filial = lvo_produto.of_desconto_convenio( io_condicao_convenio.cd_convenio , io_condicao_convenio.pc_desconto_minimo )
				End If
			End If
		End If
		
		//Desconto plano de saude
		If ivo_Produto_Parent.ids_contratos_bin.rowcount( )  > 0 And Not IsNull(ivo_Produto_Parent.nr_cartao_saude_desconto) and Trim(ivo_Produto_Parent.nr_cartao_saude_desconto) <> '' Then
			For ll_row = 1 to ivo_Produto_Parent.ids_contratos_bin.rowcount( )
				ll_convenio = ivo_Produto_Parent.ids_contratos_bin.object.cd_convenio[ll_row]
				ll_contrato  = ivo_Produto_Parent.ids_contratos_bin.object.nr_contrato[ll_row]					
				ldc_desconto_plano_aux = lvo_Produto.of_desconto_contrato_convenio(ll_convenio, ll_contrato)	
				If ldc_desconto_plano_aux > ldc_desconto_plano_saude Then
					ldc_desconto_plano_saude 				= ldc_desconto_plano_aux
				End If	
				ldc_desconto_plano_aux = 000.00
			Next
			If ldc_desconto_plano_saude > ldc_Desconto_Filial Then
				ldc_Desconto_Filial = ldc_desconto_plano_saude
			End If		
		End If				
		
		dw_2.Object.Vl_Preco_Tabela	[lvl_Contador] = ldc_Preco_Bruto
		dw_2.Object.Vl_Preco_Liquido	[lvl_Contador] = Round( ldc_Preco_Bruto * ( ( 100 - ldc_Desconto_Filial ) / 100 ), 2 )
		dw_2.Object.Vl_Preco_Clube	[lvl_Contador] = Round( ldc_Preco_Bruto * ( ( 100 - ldc_Desconto_Clube ) / 100 ), 2 )
		dw_2.Object.pc_desconto_filial	[lvl_Contador] = ldc_Desconto_Filial
		dw_2.Object.pc_desconto_clube[lvl_Contador] = ldc_Desconto_Clube
		lvs_gratis_popular = lvo_Produto.id_gratis_farm_popular
		If IsNull(lvs_gratis_popular) Or Trim(lvs_gratis_popular) = '' Then 
			lvs_gratis_popular = 'N'
		End If			
		If lvs_gratis_popular <> 'S' Then
			If ldc_valor_fpb > 0 Then
				If (dw_2.Object.Vl_Preco_Liquido[lvl_Contador] * 0.9) >= ldc_valor_fpb Then
					dw_2.Object.Vl_Preco_Pago_FPB[lvl_Contador] =  Round( dw_2.Object.Vl_Preco_Liquido[lvl_Contador] - ldc_valor_fpb, 2 )
				Else
					dw_2.Object.Vl_Preco_Pago_FPB[lvl_Contador] = Round( dw_2.Object.Vl_Preco_Liquido[lvl_Contador] * 0.1, 2 )
				End If
			Else
				SetNull(ldc_valor_fpb)
				dw_2.Object.Vl_Preco_Pago_FPB[lvl_Contador] = ldc_valor_fpb
			End If
		Else
			dw_2.Object.Vl_Preco_Pago_FPB[lvl_Contador] = 0
		End If
		
	End If
	
	//Calculo rentabilidade, s$$HEX1$$f300$$ENDHEX$$ faz se o saldo e o custo forem maior que zero.
	If dw_2.Object.vl_custo_gerencial[lvl_Contador] > 0 And (dw_2.Object.qt_saldo_final[lvl_Contador] - dw_2.Object.qt_saldo_pendente[lvl_Contador] > 0 ) Then
		//Nao calcula a rentabilidade para produtos com 100% de desconto, Vl_Preco_Liquido = 0
		If dw_2.Object.Vl_Preco_Liquido[lvl_Contador] > 0 Then
		
			ldc_rentabilidade = Round((((dw_2.Object.Vl_Preco_Liquido[lvl_Contador] - dw_2.Object.vl_custo_gerencial[lvl_Contador] ) / dw_2.Object.Vl_Preco_Liquido[lvl_Contador] ) * 100 ),2)
	
				dw_2.Object.vl_rentabilidade	[lvl_Contador] = Round((dw_2.Object.Vl_Preco_Liquido[lvl_Contador] - dw_2.Object.vl_custo_gerencial[lvl_Contador] ),2)
				dw_2.Object.pc_rentabilidade	[lvl_Contador] = ldc_rentabilidade
						
				If ldc_rentabilidade >= idc_Rentabilidade_Positiva AND ldc_rentabilidade > idc_Rentabilidade_Negativa Then
					dw_2.Object.id_positivo[lvl_Contador] = IIF(idc_Rentabilidade_Positiva > 0, 'S', 'N')
				ElseIF ldc_rentabilidade <= idc_Rentabilidade_Negativa Then
					dw_2.Object.id_negativo[lvl_Contador] = IIF(idc_Rentabilidade_Negativa > 0, 'S', 'N')
				Else	 
					dw_2.Object.id_positivo	[lvl_Contador] = 'N'
					dw_2.Object.id_negativo	[lvl_Contador] = 'N'
				End If		
				
	//			If ldc_rentabilidade > 30 Then
	//				dw_2.Object.id_promover_venda[lvl_Contador] = 'S'
	//				If dw_2.Object.vl_rentabilidade[lvl_Contador] > 9 Then
	//					dw_2.Object.id_positivo[lvl_Contador] = 'S'
	//				Else
	//					dw_2.Object.id_negativo[lvl_Contador] = 'S'
	//				End If		
	//			End If			
			
	//		End If
		End If
	End If
	 
	
	w_Aguarde.uo_Progress.of_SetProgress(lvl_Contador)
Next

Destroy(lvo_Produto)

Close(w_Aguarde)
SetPointer(Arrow!)
end subroutine

public subroutine wf_inclui_produto (long pl_produto);Integer li_Row

Decimal ldc_Preco_Bruto
Decimal ldc_Desconto_Clube
Decimal ldc_Desconto_Filial
Decimal ldc_valor_fpb

Try
	This.SetRedraw( False )
	
	uo_produto lo_Produto // GE001
	lo_Produto = Create uo_Produto
	
	lo_Produto.of_Localiza_Codigo_Interno( pl_Produto )
	
	If lo_Produto.Localizado Then
		li_Row = dw_2.InsertRow( 1 )
		
		dw_2.Object.cd_Produto						[li_Row] = lo_Produto.cd_Produto
		dw_2.Object.de_Produto						[li_Row] = lo_Produto.de_Produto
		dw_2.Object.de_Apresentacao_Venda	[li_Row] = lo_Produto.de_Apresentacao_Venda
		dw_2.Object.cd_Grupo_Psico				[li_Row] = lo_Produto.cd_Grupo_Psico
		dw_2.Object.id_Situacao_Filial				[li_Row] = lo_Produto.id_Situacao
		dw_2.Object.id_Lei_Generico				[li_Row] = lo_Produto.id_Lei_Generico
		dw_2.Object.id_Promover_Venda			[li_Row] = lo_Produto.id_Promover_Venda
		dw_2.Object.qt_Saldo_Final					[li_Row] = lo_Produto.of_Saldo_Produto( pl_Produto )
		dw_2.Object.id_Farmacia_Popular			[li_Row] = lo_Produto.id_Farmacia_Popular
		dw_2.Object.id_Situacao						[li_Row] = lo_Produto.id_Situacao
		//dw_2.Object.id_Situacao_Matriz			[li_Row] = '-'
		
		ldc_Preco_Bruto		= lo_Produto.of_Preco_Venda_Filial( )
		ldc_Desconto_Clube	= lo_Produto.of_Desconto_Clube( )
		ldc_Desconto_Filial	= lo_Produto.of_Desconto_Filial( )
		
		If ldc_Desconto_Filial > ldc_Desconto_Clube Then
			ldc_Desconto_Clube = ldc_Desconto_Filial
		End If
		If IsNull(lo_produto.vl_reembolso_fpb) or lo_produto.vl_reembolso_fpb < 0 Then
			ldc_valor_fpb = 0
		Else
			ldc_valor_fpb = lo_produto.vl_reembolso_fpb
		End If
		
		dw_2.Object.Vl_Preco_Tabela	[li_Row] = ldc_Preco_Bruto
		dw_2.Object.Vl_Preco_Liquido	[li_Row] = Round( ldc_Preco_Bruto * ( ( 100 - ldc_Desconto_Filial ) / 100 ), 2 )
		dw_2.Object.Vl_Preco_Clube	[li_Row] = Round( ldc_Preco_Bruto * ( ( 100 - ldc_Desconto_Clube ) / 100 ), 2 )		
		dw_2.Object.cd_Produto_PBM [li_Row] = wf_Verifica_Pbm( pl_Produto )
		If lo_Produto.id_gratis_farm_popular <> 'S' Then
			If ldc_valor_fpb > 0 Then				
				If (dw_2.Object.Vl_Preco_Liquido[li_Row] * 0.9) >= ldc_valor_fpb Then
					dw_2.Object.Vl_Preco_Pago_FPB[li_Row] =  Round( dw_2.Object.Vl_Preco_Liquido[li_Row] - ldc_valor_fpb, 2 )
				Else
					dw_2.Object.Vl_Preco_Pago_FPB[li_Row] = Round( dw_2.Object.Vl_Preco_Liquido[li_Row] * 0.1, 2 )
				End If				
			Else
				SetNull(ldc_valor_fpb)
				dw_2.Object.Vl_Preco_Pago_FPB[li_Row] = ldc_valor_fpb
			End If
		Else
			dw_2.Object.Vl_Preco_Pago_FPB[li_Row] = 0
		End If	
		If lo_produto.of_possui_pbm_clamed() Then
			dw_2.Object.id_pbm_clamed			[li_Row] = 'S'
		End If			

		dw_2.Scrolltorow( li_Row )
	End If
	
Finally
	This.SetRedraw( True )
	Destroy lo_Produto
End Try


end subroutine

public function integer wf_verifica_pbm (long pl_produto);//Mostra s$$HEX1$$ed00$$ENDHEX$$mbolo de PBM em cima do campo descri$$HEX2$$e700e300$$ENDHEX$$o do produto.

Long lvl_Count

//Select Count(pp.cd_pbm)
//  Into :lvl_Count
//  From pbm_produto pp
//  inner join pbm p
//	  on p.cd_pbm = pp.cd_pbm
//	 and coalesce (p.id_tipo, '') <> 'D'
// Where pp.cd_produto = :pl_produto
// Using SqlCa;

select sum(qtde) 
 Into :lvl_Count
	from(
	SELECT Count(pro.cd_pbm) as qtde
	FROM		pbm AS pbm
		INNER JOIN pbm_produto AS pro
			ON pro.cd_pbm = pbm.cd_pbm
		LEFT OUTER JOIN parametro_loja p
			ON cd_parametro = 'ID_INTEGRA_PORTAL_DROGARIA'
	WHERE	pro.cd_produto = :pl_produto
	and pbm.cd_convenio = 52568
	and (Case when p.vl_parametro = 'N' Then pbm.cd_pbm <> 175 Else pbm.cd_pbm = 175 end)
	
	Union all
	
	SELECT	Count(pro.cd_pbm) as qtde
	FROM		pbm AS pbm
		INNER JOIN pbm_produto AS pro
			ON pro.cd_pbm = pbm.cd_pbm
	WHERE	pro.cd_produto = :pl_produto
	and (pbm.cd_convenio is null Or pbm.cd_convenio <> '52568')
	and coalesce (pbm.id_tipo, '') <> 'D' 
) as x
Using SqlCa;
 
If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o dos PBMs do produto '" + String(pl_Produto) + "'.")
	Return 0
End If

Return lvl_Count
end function

on w_ge108_selecao_produto_filial_atendimento.create
call super::create
end on

on w_ge108_selecao_produto_filial_atendimento.destroy
call super::destroy
end on

event open;call super::open;String lvs_Produto
String lvs_DW

io_Categoria_Produto = Create uo_Categoria
io_condicao_convenio = Create uo_condicao_venda_convenio

//dw_2.Object.t_alerta_produto_busca_facil.Visible = False

ivo_Produto_Parent = Message.PowerObjectParm

lvs_Produto = ivo_Produto_Parent.ivs_Parametro

If lvs_Produto <> "" Then
	dw_1.Object.De_Produto[1] = lvs_Produto
	dw_1.AcceptText()
	
	ivb_Pesquisa_Direta = True	
End If

If Not ivo_Produto_Parent.ivb_Inativo_Loja Then
	dw_1.Object.Id_Inativos[1] = "N"	
	dw_1.Object.Id_Inativos.Protect = 1
End If

If Not IsNull( ivo_Produto_Parent.il_convenio ) And Not IsNull( ivo_Produto_Parent.il_condicao_convenio ) Then
	io_Condicao_Convenio.Somente_Ativas = True
	io_Condicao_Convenio.of_localiza_codigo( ivo_Produto_Parent.il_Convenio, ivo_Produto_Parent.il_condicao_convenio)
	If io_Condicao_Convenio.localizado Then 
		dw_2.Object.vl_preco_liquido_t.Text = "Conv$$HEX1$$ea00$$ENDHEX$$nio"
		dw_2.Modify( "vl_preco_liquido_t.Color='255'")
	End If
	
End If
//
pb_Help.Visible = True

ivo_parametro = Create uo_parametro_filial
ivo_parametro.of_localiza_parametro( 'ID_UTILIZA_LISTA_TECNICA', 						 ref is_utiliza_lista_tecnica)
ivo_parametro.of_localiza_parametro( 'PC_RENTABILIDADE_NEGATIVA_ATENDIMENTO', ref idc_Rentabilidade_Negativa)
ivo_parametro.of_localiza_parametro( 'PC_RENTABILIDADE_POSITIVA_ATENDIMENTO',  ref idc_Rentabilidade_Positiva)
ivo_parametro.of_localiza_parametro( 'ID_DERMACLUB_ATIVO', 								 ref ib_Dermaclub_ativo )
end event

event close;call super::close;If IsValid( io_categoria_produto ) 	Then Destroy io_categoria_produto
If IsValid( io_condicao_convenio ) 	Then Destroy io_condicao_convenio
If IsValid(ivo_Parametro) 			Then Destroy(ivo_Parametro)
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge108_selecao_produto_filial_atendimento
integer x = 3383
integer y = 56
end type

event pb_help::clicked;call super::clicked;wf_Help( "Sele$$HEX2$$e700e300$$ENDHEX$$o de Produtos [Atendimento ao Cliente] (GE001)" )
end event

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge108_selecao_produto_filial_atendimento
integer x = 27
integer y = 364
integer width = 3538
integer height = 1204
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge108_selecao_produto_filial_atendimento
integer x = 27
integer width = 3538
integer height = 348
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge108_selecao_produto_filial_atendimento
integer x = 59
integer y = 64
integer width = 3314
integer height = 268
string dataobject = "dw_ge108_selecao_produto_atendimento"
end type

event dw_1::ue_key;call super::ue_key;Choose Case Key
	Case KeyEnter!
		Choose Case GetColumnName()
			Case "de_categoria"				
				io_Categoria_Produto.of_Localiza( This.GetText( ) )
				
				If Parent.io_Categoria_Produto.Localizado Then
					This.Object.cd_Categoria[1] = Parent.io_Categoria_Produto.cd_Categoria
					This.Object.de_Categoria[1] = Parent.io_Categoria_Produto.de_Categoria
				End If
		End Choose
End Choose
end event

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case "de_categoria"
		
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Trim(Data) <> io_Categoria_Produto.de_Categoria Then
				Return 1
			End If
		Else
			io_Categoria_Produto.Of_Inicializa()
			
			This.Object.cd_Categoria[1] = io_Categoria_Produto.cd_Categoria
			This.Object.de_Categoria[1] = io_Categoria_Produto.de_Categoria
		End If		
End Choose
end event

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge108_selecao_produto_filial_atendimento
integer x = 64
integer y = 412
integer width = 3479
integer height = 1136
string title = "GE001 - Sele$$HEX2$$e700e300$$ENDHEX$$o de Produtos [Atendimento ao Cliente]"
string dataobject = "dw_ge108_selecao_produto_lista_atendimento"
boolean hscrollbar = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;Integer li_Count = 0

String	lvs_Descricao, &
		lvs_Barras, &
		lvs_Situacao, &
		lvs_Ativo, &
		lvs_Pendente, &
		lvs_Inativo, &
		lvs_Registro_MS, &
		lvs_Descricao_Busca
String ls_Categoria
String ls_SubCategoria
		
Dec ldc_Concentracao

Long ll_Unidades		

dw_1.AcceptText()

lvs_Descricao		= dw_1.Object.De_Produto			[1]
lvs_Ativo				= dw_1.Object.Id_Ativos				[1]
lvs_Pendente		= dw_1.Object.Id_Pendentes		[1]
lvs_Inativo			= dw_1.Object.Id_Inativos			[1]
ls_Categoria			= dw_1.Object.Cd_Categoria 		[1]
ls_SubCategoria	= dw_1.Object.De_SubCategoria 	[1]
ldc_Concentracao	= dw_1.Object.qt_Concentracao	[1]
ll_Unidades			= dw_1.Object.qt_Unidades_Emb 	[1]

If (IsNull(lvs_Descricao) or Trim(lvs_Descricao) = "" or lvs_Descricao = '%' ) and (IsNull(ls_Categoria) or Trim(ls_Categoria) = "") and ( IsNull( ls_SubCategoria ) ) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe algum par$$HEX1$$e200$$ENDHEX$$metro de sele$$HEX2$$e700e300$$ENDHEX$$o.", StopSign!)
	dw_1.Event ue_Pos(1, "de_produto")
	Return -1	
End If

If Not IsNull( ls_Categoria ) Then
	This.of_appendwhere_subquery("left( g.cd_subcategoria, 6 ) = '" + ls_Categoria + "'", 6)
End If

If Not IsNull(lvs_Descricao) and Trim(lvs_Descricao) <> "" Then
	/* Gambiarra - 28/01/2016 - Adapta$$HEX2$$e700e300$$ENDHEX$$o para a busca sempre mostrar tamb$$HEX1$$e900$$ENDHEX$$m os produtos de geladeira que comecem com o texto buscado
		Exemplo: NORIPURUM - ZZNORIPURU
	*/	
	SELECT COUNT(*)
	INTO :li_Count
	FROM produto_geral
	WHERE de_produto = :lvs_Descricao
	USING SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case -1
			SqlCa.of_MsgDbError( "Localiza$$HEX2$$e700e300$$ENDHEX$$o pela descri$$HEX2$$e700e300$$ENDHEX$$o exata do produto" )
			
		Case 0
			If li_Count > 0 Then // Quando houver produto com a descri$$HEX2$$e700e300$$ENDHEX$$o exatamente igual a digitada pelo usu$$HEX1$$e100$$ENDHEX$$rio, procura direto pela descri$$HEX2$$e700e300$$ENDHEX$$o
				lvs_Descricao_Busca = "( g.de_produto LIKE '" + lvs_Descricao + "%' Or g.de_produto LIKE 'ZZ" + lvs_Descricao + "%' )"
			End If
	End Choose
	
	If li_Count = 0 Then
		lvs_Descricao_Busca = lvs_Descricao
		
		If LeftA( lvs_Descricao, 2 ) = 'ZZ' Then
			lvs_Descricao_Busca = MidA( lvs_Descricao, 3 )
		End If
	
		If LeftA( lvs_Descricao, 3 ) = '%ZZ' Then
//			This.of_appendwhere_subquery( "( g.de_produto like '%" + MidA( lvs_Descricao, 4 ) + "%' Or g.de_produto like '%ZZ" + MidA( lvs_Descricao, 4 ) + "%' Or g.de_produto_metaphone like '%' || dbo.uf_metaphone( '" + MidA( lvs_Descricao, 4 ) + "' ) || '%' Or g.de_produto_metaphone like '%ZZ' || dbo.uf_metaphone( '" + MidA( lvs_Descricao, 4 ) + "' ) || '%' )", 4)
			This.of_appendwhere_subquery( "( g.de_produto like '%" + MidA( lvs_Descricao, 4 ) + "%' Or g.de_produto like '%ZZ" + MidA( lvs_Descricao, 4 ) + "%' Or  (Case When dbo.uf_metaphone( '" + lvs_Descricao_Busca + "' ) <> '' Then g.de_produto_metaphone like dbo.uf_metaphone( '" + lvs_Descricao_Busca + "' ) || '%' END) Or g.de_produto_metaphone like '%ZZ' || dbo.uf_metaphone( '" + MidA( lvs_Descricao, 4 ) + "' ) || '%' )", 6)
		Else
//			This.of_appendwhere_subquery("( g.de_produto like '" + lvs_Descricao_Busca + "%' Or g.de_produto like 'ZZ" + lvs_Descricao_Busca + "%' Or g.de_produto_metaphone like dbo.uf_metaphone( '" + lvs_Descricao_Busca + "' ) || '%' Or g.de_produto_metaphone like dbo.uf_metaphone( 'ZZ" + lvs_Descricao_Busca + "' ) || '%' )", 4)		
			This.of_appendwhere_subquery("( g.de_produto like '" + lvs_Descricao_Busca + "%' Or g.de_produto like 'ZZ" + lvs_Descricao_Busca + "%' Or (Case When dbo.uf_metaphone( '" + lvs_Descricao_Busca + "' ) <> '' Then g.de_produto_metaphone like dbo.uf_metaphone( '" + lvs_Descricao_Busca + "' ) || '%' END) Or g.de_produto_metaphone like dbo.uf_metaphone( 'ZZ" + lvs_Descricao_Busca + "' ) || '%' )", 6)		
		End If		
	Else
		This.of_appendwhere_subquery( lvs_Descricao_Busca, 6 )
	End If
	
	/***/
End If

// Concentra$$HEX2$$e700e300$$ENDHEX$$o
If Not IsNull( ldc_Concentracao ) Then
	This.of_Appendwhere_Subquery( "g.qt_concentracao = " + gf_Valor_Com_Ponto( ldc_Concentracao ), 6 )
End If

// Unidades por embalagam de venda
If Not IsNull( ll_Unidades ) Then
	// Se estiver preenchido no banco com 0, considera 1
	This.of_Appendwhere_Subquery( "( case qt_unidades_embalagem when 0 then 1 else qt_unidades_embalagem end )  = " + String( ll_Unidades ), 6 )
End If

// Verifica o filtro da situa$$HEX2$$e700e300$$ENDHEX$$o
If lvs_Ativo    = "S" Then	lvs_Situacao  = "A"
If lvs_Pendente = "S" Then	lvs_Situacao += "P"
If lvs_Inativo  = "S" Then	lvs_Situacao += "I"

If LenA(lvs_Situacao) > 0 Then
	If LenA(lvs_Situacao) < 3 Then
		If LenA(lvs_Situacao) = 1 Then
			This.of_appendwhere_subquery("l.id_situacao = '" + lvs_Situacao + "'", 6)
		Else
			This.of_appendwhere_subquery("l.id_situacao in ('" + LeftA(lvs_Situacao, 1) + "', '" + RightA(lvs_Situacao, 1) + "')", 6)
		End If
	End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione pelo menos uma situa$$HEX2$$e700e300$$ENDHEX$$o.")
	dw_1.Event ue_Pos(1, "id_ativos")
	Return -1
End If

If Not IsNull( ls_SubCategoria ) Then
	This.of_appendwhere_subquery("g.cd_subcategoria in ( SELECT cd_subcategoria FROM subcategoria WHERE de_subcategoria LIKE '" + ls_SubCategoria + "%' )", 6)
End If

This.SetRedRaw(False)

Return 1
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;wf_Atualiza_Precos()

//dw_2.SetSort( "pc_rentabilidade d, cpt_qt_saldo_final d, de_descricao_apresentacao d" )
dw_2.SetSort( "vl_rentabilidade d, cpt_qt_saldo_final d, de_descricao_apresentacao d" )
dw_2.Sort()

This.SetRedRaw(True)

Return AncestorReturnValue
end event

event dw_2::ue_key;call super::ue_key;Long ll_Produto
Long ll_Produto_Busca_Facil
Long ll_Find
Decimal lvdc_desconto

Choose Case Key
	Case KeyF5!
		ll_Produto = This.Object.cd_produto[ This.GetRow() ]
		
		If Not IsNull(ll_Produto) Then			
			lvdc_Desconto = This.Object.pc_desconto_filial[This.GetRow()]
			If This.Object.pc_desconto_clube[This.GetRow()] > lvdc_Desconto Then lvdc_Desconto = This.Object.pc_desconto_clube[This.GetRow()]			
			
			uo_ge108_produto lo_Prd
			lo_Prd = Create uo_ge108_produto
			
			lo_Prd.idc_desconto = lvdc_Desconto			
			lo_Prd.of_localiza_codigo_interno( ll_Produto )
			
			lo_Prd.of_consulta_regras_pbms_vidalink( )		
			
			If IsValid(lo_Prd) Then Destroy lo_Prd
			
		End If		
		
		/*
		If This.Object.cd_produto_pbm[ This.GetRow() ] = 0 Then
			If This.Object.id_pbm_clamed[ This.GetRow() ] = 'S' Then
				OpenWithParm( w_ge108_promocao_vinculada, 'C|'+String(ll_Produto) )				
			Else				
				MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto '" + String( ll_Produto ) + "' n$$HEX1$$e300$$ENDHEX$$o possui cadastro nos PBMs.", Information! )
			End If
		Else
			If Not IsNull( ll_Produto ) Then
				OpenWithParm( w_ge001_consulta_pbm_produto, ll_Produto )
			End If
		End If
		*/
		
		SqlCa.of_End_Transaction( ) // Finaliza a transa$$HEX2$$e700e300$$ENDHEX$$o		
		
	Case KeyF6!
		
	 	ll_Produto = This.Object.cd_produto[ This.GetRow() ]
		 
		If Not IsNull( ll_Produto ) Then
			
			SetNull( ll_Produto_Busca_Facil )
			
			if is_utiliza_lista_tecnica = 'S' Then
				OpenWithParm(w_ge001_Busca_Facil_lista_tecnica, ll_Produto)
			else
				OpenWithParm(w_ge001_Busca_Facil, ll_Produto)
			end if
			
			ll_Produto_Busca_Facil = Message.DoubleParm
			
			If Not IsNull( ll_Produto_Busca_Facil ) and ll_Produto_Busca_Facil > 0 Then
				ll_Find = This.Find( "cd_produto = " + String( ll_Produto_Busca_Facil ), 1, This.RowCount( ) )
				
				If ll_Find > 0 Then
					This.Scrolltorow( ll_Find )
				Else
					wf_Inclui_Produto( ll_Produto_Busca_Facil )
					
					If This.Rowcount( ) = 1 Then
						Parent.st_Mensagem.Text = "1 registro."
					Else
						Parent.st_Mensagem.Text = String( This.Rowcount( ), "###,###,##0") + " registros."
					End If
					
				End If
			End If 
		End If
		
	Case KeyF8!
		OpenWithParm( w_ge108_movimentacao_estoque, Long( dw_2.Object.cd_produto[ dw_2.GetRow( ) ] ) )
		
		SqlCa.of_End_Transaction( ) // Finaliza a transa$$HEX2$$e700e300$$ENDHEX$$o
		
End Choose
end event

event dw_2::rowfocuschanged;call super::rowfocuschanged;//If currentrow > 0 Then
//	This.Object.t_alerta_produto_busca_facil.Visible = ( This.Object.id_situacao_matriz[ currentrow ] = '-' )
//End If
end event

event dw_2::constructor;call super::constructor;// Quando o produto $$HEX1$$e900$$ENDHEX$$ adicionado pelo [F6], a linha fica com fundo na cor amarela
//This.of_SetRowSelection("if (vl_preco_pago_fpb < vl_preco_clube, rgb(255, 255, 0), rgb(255, 255, 255))","")

This.ivb_Ordena_Colunas = True
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge108_selecao_produto_filial_atendimento
integer x = 2775
integer y = 1592
end type

event cb_selecionar::clicked;call super::clicked;Long lvl_Linha

String lvs_Produto

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	lvs_Produto = String(dw_2.Object.Cd_Produto[lvl_Linha])
	CloseWithReturn(Parent, lvs_Produto)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto na lista.", Information!, Ok!)
	dw_2.SetFocus()
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge108_selecao_produto_filial_atendimento
integer x = 3186
integer y = 1592
end type

event cb_cancelar::clicked;call super::clicked;String lvs_Produto

SetNull(lvs_Produto)

CloseWithReturn(Parent, lvs_Produto)
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge108_selecao_produto_filial_atendimento
integer x = 2368
integer y = 1592
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge108_selecao_produto_filial_atendimento
integer y = 1592
end type

