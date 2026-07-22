HA$PBExportHeader$w_ge178_planilha_analise_geral.srw
forward
global type w_ge178_planilha_analise_geral from dc_w_response
end type
type cb_sair from commandbutton within w_ge178_planilha_analise_geral
end type
type dw_1 from dc_uo_dw_base within w_ge178_planilha_analise_geral
end type
type gb_1 from groupbox within w_ge178_planilha_analise_geral
end type
type cb_gerar from commandbutton within w_ge178_planilha_analise_geral
end type
end forward

global type w_ge178_planilha_analise_geral from dc_w_response
string tag = "w_ge178_planilha_analise_geral"
string accessiblename = "Gera$$HEX2$$e700e300$$ENDHEX$$o de Planilha para An$$HEX1$$e100$$ENDHEX$$lise Geral (GE178)"
integer x = 1312
integer y = 1028
integer width = 2126
integer height = 1204
string title = "GE178 - Gera$$HEX2$$e700e300$$ENDHEX$$o de Planilha para An$$HEX1$$e100$$ENDHEX$$lise Geral de Estoque"
boolean controlmenu = false
long backcolor = 80269524
cb_sair cb_sair
dw_1 dw_1
gb_1 gb_1
cb_gerar cb_gerar
end type
global w_ge178_planilha_analise_geral w_ge178_planilha_analise_geral

type variables
uo_filial 								ivo_filial
uo_fornecedor 					ivo_fornecedor
uo_classificacao_produto 	ivo_classificacao
uo_ge216_filiais 					io_filiais

Boolean ib_Filial_534 = False

Date ivdt_Parametro

Integer ivi_Dia

String is_filiais
String is_nulo

String is_Separador = ";"
end variables

forward prototypes
public function decimal wf_desconto_sos (long al_produto)
public function date wf_mes_anterior (date adt_mes_base, integer ai_numero)
public subroutine wf_localiza_filial ()
public subroutine wf_localiza_fornecedor ()
public function long wf_saldo_matriz (long al_produto, ref dc_uo_ds_base ads)
public subroutine wf_saldo_filiais (long al_produto, ref dc_uo_ds_base ads, ref long al_saldo)
public function long wf_saldo_filial (long al_produto, ref dc_uo_ds_base ads)
public subroutine wf_limpa_campos (string ps_campo)
public subroutine wf_atualiza_campos (string ps_campo)
public function decimal wf_consulta_comissao (long al_produto, integer ai_tipo, datastore ads)
public function boolean wf_verifica_resumo_eb_filiais (long al_produto, ref long al_estoque_base)
public function decimal wf_valor_saldo (long al_produto, dc_uo_ds_base ads)
public function long wf_venda_liquida_filial (long al_produto, ref dc_uo_ds_base ads, ref decimal adc_venda)
public function long wf_venda_liquida (long al_produto, ref dc_uo_ds_base ads, ref decimal adc_venda)
public function decimal wf_rentabilidade (long al_produto, dc_uo_ds_base ads, ref decimal adc_percent_rent)
public subroutine wf_insere_lei_generico_padrao ()
public function boolean wf_saldo_em_transito (dc_uo_ds_base ads)
public function long wf_media_venda (long al_produto, long al_saldo_transito, long al_saldo, dc_uo_ds_base ads)
public subroutine wf_data_venda (ref datetime adh_resumo)
public function boolean wf_verifica_filial_selecionada (string as_filial)
public subroutine wf_gera_analise ()
public function any wf_null (any a_valor, any a_default)
public subroutine wf_gera_analise_exportacao ()
public function string wf_retira_caracteres_especiais (string ps_texto)
end prototypes

public function decimal wf_desconto_sos (long al_produto);Decimal lvdc_Desconto

Select max(b.pc_desconto) Into :lvdc_Desconto 
From promocao_sos a, 
	  promocao_sos_produto b,
	  parametro p
Where a.cd_promocao_sos = b.cd_promocao_sos
  and b.cd_produto = :al_Produto
  and a.dh_inicio <= p.dh_movimentacao
  and (a.dh_termino >= p.dh_movimentacao or a.dh_termino Is Null)
Using SqlCa;
		
Choose Case SqlCa.SqlCode
	Case 0
		If IsNull(lvdc_Desconto) Then lvdc_Desconto = 0
		
	Case 100
		lvdc_Desconto = 0
		
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Desconto SOS - Produto '" + String(al_Produto) + "'")
		lvdc_Desconto = 0
End Choose

Return lvdc_Desconto
end function

public function date wf_mes_anterior (date adt_mes_base, integer ai_numero);Date lvdt_Mes_Anterior

Integer lvi_Mes_Atual, &
        lvi_Ano_Atual, &
		  lvi_Mes_Anterior, &
		  lvi_Ano_Anterior
	  
lvi_Mes_Atual = Month(adt_Mes_Base)
lvi_Ano_Atual = Year(adt_Mes_Base)

lvi_Ano_Anterior = lvi_Ano_Atual
lvi_Mes_Anterior = lvi_Mes_Atual - ai_Numero

If lvi_Mes_Anterior <= 0 Then
	lvi_Ano_Anterior = lvi_Ano_Atual - 1
	lvi_Mes_Anterior = lvi_Mes_Anterior + 12
End If

lvdt_Mes_Anterior = Date("01/" + String(lvi_Mes_Anterior, "00") + "/" + &
                                 String(lvi_Ano_Anterior, "0000"))

Return lvdt_Mes_Anterior
end function

public subroutine wf_localiza_filial ();
STRING ls_filial	, &
		 lvs_nulo

Long   lvl_nulo

ls_filial = dw_1.GetText()

ivo_filial.Of_Localiza_Filial(ls_filial)

If ivo_filial.Localizada Then
	
	dw_1.Object.cd_filial[1] = ivo_filial.cd_filial
	dw_1.Object.de_filial[1] = ivo_filial.nm_fantasia
	
Else
	SetNull(lvl_nulo)
	SetNull(lvs_nulo)
	dw_1.Object.cd_filial[1] = lvl_nulo
	dw_1.Object.de_filial[1] = lvs_nulo
	
	ivo_filial.cd_filial	    = lvl_nulo
	ivo_filial.nm_fantasia   = lvs_nulo	
	
End If

end subroutine

public subroutine wf_localiza_fornecedor ();String lvs_fornecedor

lvs_fornecedor = dw_1.GetText()

ivo_fornecedor.Of_Localiza_fornecedor(lvs_fornecedor)

If ivo_fornecedor.Localizado Then	
	dw_1.Object.cd_fornecedor[1] = ivo_fornecedor.cd_fornecedor
	dw_1.Object.nm_fornecedor[1] = ivo_fornecedor.nm_razao_social
	
	If Not gf_ge003_lista_divisao_fornecedor(dw_1, ivo_Fornecedor.Cd_Fornecedor, 1) Then
		Return
	End If	
End If

end subroutine

public function long wf_saldo_matriz (long al_produto, ref dc_uo_ds_base ads);Long lvl_Linha, &
     lvl_Saldo
	  
lvl_Linha = ads.Find("cd_produto = " + string(al_produto), 1, ads.RowCount())

If lvl_Linha > 0 Then
	lvl_Saldo = ads.Object.Saldo[lvl_Linha]
ElseIf lvl_Linha < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no find da DW Saldo Matriz.", StopSign!)
	lvl_Saldo = 0
Else
	lvl_Saldo = 0
End If

Return lvl_Saldo
end function

public subroutine wf_saldo_filiais (long al_produto, ref dc_uo_ds_base ads, ref long al_saldo);Long lvl_Linha, &
     lvl_Venda, &
	  lvl_Devolucao

lvl_Linha = ads.Find("cd_produto = " + string(al_produto), 1, ads.RowCount())

If lvl_Linha > 0 Then
	al_Saldo = ads.Object.Qt_Saldo[lvl_Linha]
ElseIf lvl_Linha < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no find da DW.", StopSign!)
	al_Saldo = 0
Else
	al_Saldo = 0
End If
end subroutine

public function long wf_saldo_filial (long al_produto, ref dc_uo_ds_base ads);Long lvl_Linha, &
     lvl_Saldo
	  
lvl_Linha = ads.Find("cd_produto = " + string(al_produto), 1, ads.RowCount())

If lvl_Linha > 0 Then
	lvl_Saldo = ads.Object.Saldo[lvl_Linha]
ElseIf lvl_Linha < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no find da DW Saldo Filial.", StopSign!)
	lvl_Saldo = 0
Else
	lvl_Saldo = 0
End If

Return lvl_Saldo
end function

public subroutine wf_limpa_campos (string ps_campo);Choose Case ps_Campo 
	Case "de_grupo"
		dw_1.Object.Cd_SubGrupo[1] = ""
		dw_1.Object.De_SubGrupo[1] = ""
		dw_1.Object.Cd_Categoria[1] = ""
		dw_1.Object.De_Categoria[1] = ""
		dw_1.Object.Cd_SubCategoria[1] = ""
		dw_1.Object.De_SubCategoria[1] = ""
		
	Case "de_subgrupo"
		dw_1.Object.Cd_Categoria[1] = ""
		dw_1.Object.De_Categoria[1] = ""
		dw_1.Object.Cd_SubCategoria[1] = ""
		dw_1.Object.De_SubCategoria[1] = ""
		
	Case "de_categoria"
		dw_1.Object.Cd_SubCategoria[1] = ""
		dw_1.Object.De_SubCategoria[1] = ""
End Choose		
		
end subroutine

public subroutine wf_atualiza_campos (string ps_campo);Choose Case ps_Campo
	Case "de_grupo"
		dw_1.Object.Cd_Grupo[1] = ivo_Classificacao.Cd_Grupo
		dw_1.Object.De_Grupo[1] = ivo_Classificacao.De_Grupo
	Case "de_subgrupo"
		dw_1.Object.Cd_Grupo[1] = ivo_Classificacao.Cd_Grupo
		dw_1.Object.De_Grupo[1] = ivo_Classificacao.De_Grupo
		dw_1.Object.Cd_SubGrupo[1] = ivo_Classificacao.Cd_SubGrupo
		dw_1.Object.De_subGrupo[1] = ivo_Classificacao.De_SubGrupo
	Case "de_categoria"
		dw_1.Object.Cd_Grupo[1] = ivo_Classificacao.Cd_Grupo
		dw_1.Object.De_Grupo[1] = ivo_Classificacao.De_Grupo
		dw_1.Object.Cd_SubGrupo[1] = ivo_Classificacao.Cd_SubGrupo
		dw_1.Object.De_subGrupo[1] = ivo_Classificacao.De_SubGrupo
		dw_1.Object.Cd_Categoria[1] = ivo_Classificacao.Cd_Categoria
		dw_1.Object.De_Categoria[1] = ivo_Classificacao.De_Categoria
	Case "de_subcategoria"
		dw_1.Object.Cd_Grupo[1] = ivo_Classificacao.Cd_Grupo
		dw_1.Object.De_Grupo[1] = ivo_Classificacao.De_Grupo
		dw_1.Object.Cd_SubGrupo[1] = ivo_Classificacao.Cd_SubGrupo
		dw_1.Object.De_subGrupo[1] = ivo_Classificacao.De_SubGrupo
		dw_1.Object.Cd_Categoria[1] = ivo_Classificacao.Cd_Categoria
		dw_1.Object.De_Categoria[1] = ivo_Classificacao.De_Categoria
		dw_1.Object.Cd_SubCategoria[1] = ivo_Classificacao.Cd_SubCategoria
		dw_1.Object.De_SubCategoria[1] = ivo_Classificacao.De_SubCategoria
End Choose

end subroutine

public function decimal wf_consulta_comissao (long al_produto, integer ai_tipo, datastore ads);Decimal ldc_Comissao

Long ll_Linha

ll_Linha = ads.Find("cd_produto = " + string(al_produto) + " and cd_tipo_comissao = " + String(ai_tipo), 1, ads.RowCount())

If ll_Linha > 0 Then
	ldc_Comissao = ads.Object.pc_comissao [ ll_Linha ]
Else
	ldc_Comissao = 0.00
End If

Return ldc_Comissao


//select pc_comissao 
//  Into :ldc_Comissao
//from tipo_comissao_produto a 
//where a.cd_produto 		= :al_produto
//and a.cd_tipo_comissao 	= :ai_tipo
//Using SqlCa;
//
//If SqlCa.SqlCode = -1 Then
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao consultar o pc_comissao do produto " + String(al_Produto))	
//	ldc_Comissao = 0.00
//End If
//
//If IsNull(ldc_Comissao) Then ldc_Comissao = 0.00
//
//Return ldc_Comissao

end function

public function boolean wf_verifica_resumo_eb_filiais (long al_produto, ref long al_estoque_base);Select qt_estoque_base
Into :al_Estoque_Base
From resumo_estoque_base_filiais
Where cd_produto 	= :al_Produto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If al_Estoque_Base = -1 Then al_Estoque_Base = 0
		
		Return True
	Case 100
		
		al_Estoque_Base = 0
		
		Return True
	Case -1
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do estoque base. " + SqlCa.SqlErrText)
		Return False
End Choose
end function

public function decimal wf_valor_saldo (long al_produto, dc_uo_ds_base ads);Decimal ldc_Saldo

Long ll_Linha
Long ll_Qt_Dias_Estoque
	  
ll_Linha = ads.Find("cd_produto = " + String(al_Produto), 1, ads.RowCount())

If ll_Linha > 0 Then
	ldc_Saldo = ads.Object.Vl_Saldo[ll_Linha]
ElseIf ll_Linha < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no find da DW de Venda.", StopSign!)
	ldc_Saldo = 0
Else
	ldc_Saldo = 0
End If

Return ldc_Saldo
end function

public function long wf_venda_liquida_filial (long al_produto, ref dc_uo_ds_base ads, ref decimal adc_venda);Long lvl_Linha, &
     lvl_Venda

lvl_Linha = ads.Find("cd_produto = " + string(al_produto), 1, ads.RowCount())

adc_Venda = 0

If lvl_Linha > 0 Then
	lvl_Venda = ads.Object.Qt_Venda[lvl_linha] - ads.Object.Qt_Devolucao_Venda[lvl_linha]
	adc_Venda = ads.Object.Vl_Venda[lvl_linha]
	
	Return lvl_Venda
Else
	Return 0
End If
end function

public function long wf_venda_liquida (long al_produto, ref dc_uo_ds_base ads, ref decimal adc_venda);Long lvl_Linha, &
     lvl_Venda, &
	  lvl_Devolucao

lvl_Linha = ads.Find("cd_produto = " + string(al_produto), 1, ads.RowCount())

adc_Venda = 0

If lvl_Linha > 0 Then
	lvl_Venda     = ads.Object.Qt_Venda          [lvl_Linha]
	lvl_Devolucao = ads.Object.Qt_Devolucao_Venda[lvl_Linha]
	adc_Venda = ads.Object.Vl_Venda[lvl_Linha]
	
	Return lvl_Venda - lvl_Devolucao
ElseIf lvl_Linha < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no find da DW.", StopSign!)
	Return 0
Else
	Return 0
End If
end function

public function decimal wf_rentabilidade (long al_produto, dc_uo_ds_base ads, ref decimal adc_percent_rent);Decimal ldc_Rentabilidade
Decimal ldc_Venda
Decimal ldc_Cmv
Decimal ldc_Comissao
Decimal ldc_Icms
Decimal ldc_Pis_Cofins

Long ll_Linha

ll_Linha = ads.Find("cd_produto = " + String(al_Produto), 1, ads.RowCount())

adc_Percent_Rent = 0

If ll_Linha > 0 Then
	ldc_Venda		= ads.Object.Vl_Venda		[ll_Linha]
	ldc_Cmv			= ads.Object.Vl_Cmv			[ll_Linha]
	ldc_Comissao	= ads.Object.Vl_Comissao	[ll_Linha]
	ldc_Icms			= ads.Object.Vl_Icms			[ll_Linha]
	ldc_Pis_Cofins	= ads.Object.Vl_Pis_Cofins	[ll_Linha]
	
	ldc_Rentabilidade = ldc_Venda - ldc_CMV - ldc_Comissao - (ldc_Icms + ldc_Pis_Cofins)

	If ldc_Venda > 0 Then
		ads.Object.Vl_Percent_Rent[ll_Linha] = Round(ldc_Rentabilidade / ldc_Venda * 100, 2)
	Else
		ads.Object.Vl_Percent_Rent[ll_Linha] = 0.00
	End If
	
	adc_Percent_Rent = ads.Object.Vl_Percent_Rent[ll_Linha]

ElseIf ll_Linha < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no find da DW de Resumo.", StopSign!)
	ldc_Venda 			= 0.00
	ldc_Cmv				= 0.00
	ldc_Comissao		= 0.00
	ldc_Icms				= 0.00
	ldc_Pis_Cofins 		= 0.00
	ldc_Rentabilidade	= 0.00
	adc_Percent_Rent	= 0.00
Else
	ldc_Venda 			= 0.00
	ldc_Cmv 				= 0.00
	ldc_Comissao		= 0.00
	ldc_Icms				= 0.00
	ldc_Pis_Cofins		= 0.00
	ldc_Rentabilidade	= 0.00
	adc_Percent_Rent	= 0.00
End If

Return ldc_Rentabilidade
end function

public subroutine wf_insere_lei_generico_padrao ();DataWindowChild ldwc_Child

/* Lei Gen$$HEX1$$e900$$ENDHEX$$rico */
ldwc_Child  = dw_1.of_InsertRow_DDDW("id_lei_generico" )			
ldwc_Child.SetItem(1, "id_lei_generico", "T")
ldwc_Child.SetItem(1, "de_lei_generico", "TODOS")
dw_1.Object.id_lei_generico [1] = "T"
end subroutine

public function boolean wf_saldo_em_transito (dc_uo_ds_base ads);Long ll_Linha
Long ll_Linhas
Long ll_Find

st_saldo_transito str

gf_Saldo_em_Transito(Ref str)

ll_Linhas = UpperBound(str.Cd_Produto[])

For ll_Linha = 1 To ll_Linhas
	
	ll_Find = ads.Find("cd_produto = " + String(str.Cd_Produto[ll_Linha]), 1, ads.RowCount())
	
	If ll_Find > 0 Then
		ads.Object.Qt_Saldo_Transito[ll_Find] = str.Qt_Saldo[ll_Linha]
	End If
Next

Return True
end function

public function long wf_media_venda (long al_produto, long al_saldo_transito, long al_saldo, dc_uo_ds_base ads);Double ld_Venda_Diaria

Long ll_Qt_Venda
Long ll_Linha
Long ll_Qt_Dias_Estoque = 0
	  
ll_Linha = ads.Find("cd_produto = " + String(al_Produto), 1, ads.RowCount())

If ll_Linha > 0 Then
	If Not ib_Filial_534 Then
		ll_Qt_Venda 		= ads.Object.Venda					[ll_Linha]
	Else
		//As vendas do estoque central s$$HEX1$$e300$$ENDHEX$$o as transfer$$HEX1$$ea00$$ENDHEX$$ncias de sa$$HEX1$$ed00$$ENDHEX$$da
		ll_Qt_Venda 		= ads.Object.Qt_Transf_Saida		[ll_Linha]
	End If
ElseIf ll_Linha < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no find da DW de Venda.", StopSign!)
	ll_Qt_Venda = 0
Else
	ll_Qt_Venda = 0
End If

//ll_Qt_Venda = Round(ll_Qt_Venda / al_Qt_Dias, 4)

//If ldc_Venda > 0 Then
//	ll_Qt_Dias_Estoque = al_saldo / ldc_Venda
//Else
//	ll_Qt_Dias_Estoque = 0
//End If

If ll_Qt_Venda > 0 Then
	ld_Venda_Diaria = Round(ll_Qt_Venda / (60 + ivi_Dia - 1), 2)

	If ld_Venda_Diaria > 0.00 Then
		ll_Qt_Dias_Estoque = Round((al_Saldo + al_Saldo_Transito) / ld_Venda_Diaria, 0)
	End If
End If

Return ll_Qt_Dias_Estoque
end function

public subroutine wf_data_venda (ref datetime adh_resumo);Date ldt_Dia_Atual

Long ll_Mes
Long ll_Ano

//Date ldt_Periodo
//
//DateTime ldh_Dia_Atual
//
//String ls_Aux
//
//ldh_Dia_Atual	= gf_GetServerDate()
//ldt_Dia_Atual	= Date(ldh_Dia_Atual)
//
//ll_Mes = Month(ldt_Dia_Atual)
//ll_Ano = Year(ldt_Dia_Atual)
//
///*A data $$HEX1$$e900$$ENDHEX$$ considerada a partir do m$$HEX1$$ea00$$ENDHEX$$s anterior mais os dias do m$$HEX1$$ea00$$ENDHEX$$s corrente. Ex: hoje $$HEX1$$e900$$ENDHEX$$ 15/05/2016, a data informada foi 01/05/2016,
//para considerar as vendas o per$$HEX1$$ed00$$ENDHEX$$odo $$HEX1$$e900$$ENDHEX$$ 01/04/2016 at$$HEX1$$e900$$ENDHEX$$ 15/05/2016*/
//
//If ll_Mes = 01 Then
//	ll_Ano = ll_Ano - 1
//	ll_Mes = 12
//Else
//	ll_Mes = ll_Mes - 1
//End If
//
//ls_Aux = "01/" + String(ll_Mes) + "/" + String(ll_Ano)
//ldt_Periodo = Date(ls_Aux)
//
//adh_Periodo = DateTime(ls_Aux)
//al_Qt_Dias = DaysAfter(ldt_Periodo, ldt_Dia_Atual)

ldt_Dia_Atual = Date(ivdt_Parametro)

ll_Mes = Month(ldt_Dia_Atual)
ll_Ano = Year(ldt_Dia_Atual)

If ll_Mes <= 02 Then
	ll_Ano = ll_Ano - 1
	
	If ll_Mes = 1 Then
		ll_Mes = 11
	Else
		ll_Mes = 12
	End If
Else
	ll_Mes = ll_Mes - 2
End If

ivi_Dia = Day(ivdt_Parametro)

adh_Resumo = DateTime("01/" + String(ll_Mes) + "/" + String(ll_Ano))
end subroutine

public function boolean wf_verifica_filial_selecionada (string as_filial);Boolean lb_Achou = False

Long ll_Linha

//Selecionou todas a filiais
If as_Filial = "T" Then Return True

For ll_Linha = 1 To UpperBound(io_filiais.Cd_Filial)
	If io_Filiais.Cd_Filial[ll_Linha] = 534 Then
		lb_Achou = True
	End If
Next

//Filial 534 n$$HEX1$$e300$$ENDHEX$$o pode ser selecionada juntamente com as demais
If lb_Achou Then
	If UpperBound(io_filiais.Cd_Filial) > 1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Filial 534 n$$HEX1$$e300$$ENDHEX$$o pode ser selecionada junto com as demais." + &
											"~r~rSelecione somente a filial 534 ou selecione demais filiais sem a filial 534.", Exclamation!)
		Return False
	Else
		ib_Filial_534 = True
	End If
End If

Return True
end function

public subroutine wf_gera_analise ();Decimal	ldc_Saldo_Fil		, &
			ldc_Saldo_Mat		, &
			ldc_Venda			, &
			ldc_Percent_Rent

Long 	lvl_Contaitem		, &
		lvl_Contames		, &
		lvl_Total				, &
		lvl_Produto			, &
		lvl_Saldo_Matriz	, &
		lvl_Saldo_Filiais	, &
		lvl_Venda_Liquida	, &
		lvl_Mix				, &
		ll_EB_Filiais			, &
		ll_Qt_Dias_Venda	, &
		ll_Qt_Dias_Estoque, &
		ll_Divisao_Forn

Date 	lvdt_Mes_Base	, &
		lvdt_Mes_1		, &
		lvdt_Mes_2		, &
		lvdt_Mes_3		, &
		lvdt_Mes_4		, &
		lvdt_Mes_5		, &
		lvdt_Mes_6		, &
		lvdt_Mes
	  
DateTime	ldh_Mes_Corrente, &
				ldh_Periodo_Venda	
	  
Time	lvt_Inicio		, &
		lvt_Termino

String	lvs_Diretorio			, &
		lvs_Arquivo  		, &
		lvs_Fornecedor		, &
		lvs_Lei				, &
		lvs_Grupo			, &
		lvs_SubGrupo		, &
		lvs_Categoria		, &
		lvs_SubCategoria	, &
		lvs_Situacao			, &
		lvs_Filiais			, &
		ls_Data_Store		, &
		ls_Aux
		
Try		

	lvs_Diretorio = gvo_Aplicacao.of_GetFromINI("Diretorio", "Diretorio")
	
	dc_uo_ds_Base lvds_1
	lvds_1 = Create dc_uo_ds_Base	
	If Not lvds_1.of_ChangeDataObject("dw_ge178_planilha") Then Return
	
	dc_uo_ds_Base lvds_2
	lvds_2 = Create dc_uo_ds_Base
	If Not lvds_2.of_ChangeDataObject("dw_ge178_resumo_mes") Then Return
	
	dc_uo_ds_Base lvds_3
	lvds_3 = Create dc_uo_ds_Base
	If Not lvds_3.of_ChangeDataObject("dw_ge178_saldo") Then Return
	
	dc_uo_ds_Base lvds_4
	lvds_4 = Create dc_uo_ds_Base
	If Not lvds_4.of_ChangeDataObject("dw_ge178_resumo_mes_filiais") Then Return
	
	dc_uo_ds_Base lvds_5
	lvds_5 = Create dc_uo_ds_Base
	If Not lvds_5.of_ChangeDataObject("dw_ge178_saldo_filiais") Then Return
	
	dc_uo_ds_Base lds_comissao
	lds_comissao = Create dc_uo_ds_Base
	If Not lds_comissao.of_ChangeDataObject("dw_ge178_comissao_produto") Then Return
	
	//dc_uo_ds_Base f_Perini
	//lds_Venda_Perini = Create dc_uo_ds_Base
	//If Not lds_Venda_Perini.of_ChangeDataObject("dw_ge178_venda_perini") Then Return
	
	dc_uo_ds_Base lds_Custo_Perini
	lds_Custo_Perini = Create dc_uo_ds_Base
	If Not lds_Custo_Perini.of_ChangeDataObject("dw_ge178_custo_perini") Then Return
	
	dc_uo_ds_Base lds_Custo_Filiais
	lds_Custo_Filiais = Create dc_uo_ds_Base
	If Not lds_Custo_Filiais.of_ChangeDataObject("dw_ge178_custo_filiais") Then Return
	
	lvt_Inicio = Now()
	
	SetPointer(HourGlass!)
	Open(w_Aguarde)
	w_Aguarde.Title = "Recuperando as informa$$HEX2$$e700f500$$ENDHEX$$es..."
	
	dw_1.AcceptText()
	
	lvdt_Mes_Base    	= dw_1.Object.dt_inicio      					[1]
	lvs_fornecedor		= dw_1.Object.cd_fornecedor  				[1]
	lvs_Filiais			= dw_1.Object.de_filial      					[1]
	lvs_Lei				= dw_1.Object.Id_Lei_Generico			[1]
	lvs_Grupo        		= dw_1.Object.Cd_Grupo     				[1]
	lvs_SubGrupo		= dw_1.Object.Cd_SubGrupo    			[1]
	lvs_Categoria		= dw_1.Object.Cd_Categoria   				[1]
	lvs_SubCategoria 	= dw_1.Object.Cd_SubCategoria			[1]
	lvs_Situacao			= dw_1.Object.Id_Situacao    				[1]
	lvl_Mix				= dw_1.Object.cd_mix         				[1]
	ll_Divisao_Forn		= dw_1.Object.Nr_Divisao_Fornecedor	[1]
	ldh_Mes_Corrente	= gf_GetServerDate()
	
	If IsNull(lvdt_Mes_Base) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Favor informar a data base para gera$$HEX2$$e700e300$$ENDHEX$$o do arquivo.",Information!)
		dw_1.Event ue_Pos(1, "dt_inicio")
		Return
	End If
	
	If Not wf_Verifica_Filial_Selecionada(lvs_Filiais) Then
		Close(w_Aguarde)
		Return
	End If
	
	If Not IsNull(lvs_fornecedor) Then
		lvds_1.Of_appendwhere("pg.cd_fornecedor_usual = '" + lvs_fornecedor + "'")
	End If
	
	//Divis$$HEX1$$e300$$ENDHEX$$o do fornecedor
	If Not IsNull(ll_Divisao_Forn) And ll_Divisao_Forn > 0 Then
		lvds_1.Of_appendwhere(" pg.cd_produto in ( select cd_produto" + &
										 " from vw_divisao_fornecedor_produto" + &
										 " where cd_fornecedor = '" + lvs_Fornecedor + "'" + &
										 " and nr_divisao = " + String(ll_Divisao_Forn) + ")")
	End If
	
	If Not IsNull(lvs_Lei) and lvs_Lei <> "T" Then
		lvds_1.Of_appendwhere("pg.id_lei_generico = '" + lvs_Lei + "'")
	End If
	
	// Grupo
	If Not IsNull(lvs_Grupo) and lvs_Grupo <> "" Then
		lvds_1.of_Appendwhere("cp.cd_grupo = '" + lvs_Grupo + "'")
	End If
	
	// SubGrupo
	If Not IsNull(lvs_SubGrupo) and lvs_SubGrupo <> "" Then
		lvds_1.of_Appendwhere("cp.cd_subgrupo = '" + lvs_SubGrupo + "'")
	End If
	
	// Categoria
	If Not IsNull(lvs_Categoria) and lvs_Categoria <> "" Then
		lvds_1.of_Appendwhere("cp.cd_categoria = '" + lvs_Categoria + "'")
	End If
	
	// SubCategoria
	If Not IsNull(lvs_SubCategoria) and lvs_SubCategoria <> "" Then
		lvds_1.of_Appendwhere("cp.cd_subcategoria = '" + lvs_SubCategoria + "'")
	End If
	
	If lvs_Situacao <> "T" Then
		lvds_1.of_AppendWhere("pg.id_situacao = '" + lvs_Situacao + "'")
	End If
	
	// Mix
	If Not IsNull(lvl_Mix) Then
		lvds_1.of_AppendWhere("pc.cd_mix_produto = " + String(lvl_Mix) )
	End If
	
	lvl_Total = lvds_1.Retrieve()
	
	If lvl_Total > 0 Then
		
		If Not wf_Saldo_Em_Transito(lvds_1) Then Return
		
		w_Aguarde.Title = "Calculando Saldo Matriz..."
		
		lvds_3.Retrieve(lvdt_Mes_Base)
		
		lds_comissao.Retrieve()
	
		If lvs_filiais = 'C' Then
			w_Aguarde.Title = "Calculando Saldo Filial..."
			lvds_5.of_AppendWhere("cd_filial in ( " + is_filiais + " )" )
			lvds_5.Retrieve( lvdt_Mes_Base )
			
			lvds_4.of_AppendWhere("r.cd_filial in ( " + is_filiais + " )" )
		End If
		
		If lvs_Filiais = "C" Then
			ls_Data_Store = "dw_ge178_venda_filial"
		Else
			ls_Data_Store = "dw_ge178_venda_filiais"
		End If
			
		dc_uo_ds_Base lds_Venda
		lds_Venda = Create dc_uo_ds_Base
		If Not lds_Venda.of_ChangeDataObject(ls_Data_Store) Then
			Destroy(lds_Venda)
			Close(w_Aguarde)
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar o data store '" + ls_Data_Store + "'.", StopSign!)
			Return
		End If
		
		If lvs_Filiais = "C" Then
			lds_Venda.of_AppendWhere("cd_filial in ( " + is_filiais + " )")
			lds_Custo_Filiais.of_AppendWhere("s.cd_filial in ( " + is_filiais + " )")
		Else
			lds_Custo_Filiais.of_AppendWhere("s.cd_filial <> 534")
		End If
		
		wf_Data_Venda(Ref ldh_Periodo_Venda)
		
		w_Aguarde.Title = "Calculando M$$HEX1$$e900$$ENDHEX$$dia de Venda..."
		lds_Venda.Retrieve(ldh_Periodo_Venda)
	//	lds_Venda_Perini.Retrieve(ldh_Periodo_Venda)
		
		w_Aguarde.Title = "Calculando Valor de Saldo..."
		ls_Aux = String(ldh_Mes_Corrente)
		
		ls_Aux = "01/" + MidA(ls_Aux, 4, 8) + "00:00:00"
		
		ldh_Mes_Corrente = DateTime(ls_Aux)
		
		lds_Custo_Perini.Retrieve(ldh_Mes_Corrente)
		lds_Custo_Filiais.Retrieve(ldh_Mes_Corrente)
	
		lvdt_Mes_1 = wf_Mes_Anterior(lvdt_Mes_Base, 6)
		lvdt_Mes_2 = wf_Mes_Anterior(lvdt_Mes_Base, 5)
		lvdt_Mes_3 = wf_Mes_Anterior(lvdt_Mes_Base, 4)
		lvdt_Mes_4 = wf_Mes_Anterior(lvdt_Mes_Base, 3)
		lvdt_Mes_5 = wf_Mes_Anterior(lvdt_Mes_Base, 2)
		lvdt_Mes_6 = wf_Mes_Anterior(lvdt_Mes_Base, 1)
		
		For lvl_Contames = 1 to 7
			 
			 If lvl_Contames = 1 Then
				 lvdt_mes = lvdt_mes_1
			 ElseIf lvl_Contames = 2 Then
				 lvdt_mes = lvdt_mes_2
			 ElseIf lvl_Contames = 3 Then
				 lvdt_mes = lvdt_mes_3
			 ElseIf lvl_Contames = 4 Then
				 lvdt_mes = lvdt_mes_4
			 ElseIf lvl_Contames = 5 Then
				 lvdt_mes = lvdt_mes_5
			 ElseIf lvl_Contames = 6 Then
				 lvdt_mes = lvdt_mes_6
			 ElseIf lvl_Contames = 7 Then
				 lvdt_mes = lvdt_mes_base
			 End If
				 
			 w_Aguarde.Title = "Calculando Vendas do M$$HEX1$$ea00$$ENDHEX$$s " + string(lvdt_Mes,"mm/yyyy")
			 w_Aguarde.uo_Progress.of_Reset()
			 w_Aguarde.uo_Progress.of_SetMax(lvl_Total)
	
			If lvs_filiais = 'C' Then
				lvds_4.Retrieve(lvdt_Mes)
			 Else
				 lvds_2.Retrieve(lvdt_Mes)
			 End If
	
			 For lvl_Contaitem = 1 To lvl_Total
				  lvl_Produto = lvds_1.Object.Cd_Produto[lvl_Contaitem]
					
				  If lvl_Contames = 7 Then
					  lvds_1.Object.Pc_Desconto_SOS[lvl_Contaitem] = wf_Desconto_SOS(lvl_Produto)
	
					  lvl_Saldo_Matriz = wf_Saldo_Matriz(lvl_Produto,lvds_3)
					  lvds_1.Object.Qt_Saldo_Matriz[lvl_Contaitem] = lvl_Saldo_Matriz
					  
					 If lvs_filiais = 'C' Then
						  lvl_Saldo_Filiais = wf_saldo_Filial(lvl_Produto,lvds_5)
						  lvds_1.Object.Qt_Saldo_Filiais[lvl_Contaitem] = lvl_Saldo_Filiais
					  Else
						  wf_Saldo_Filiais(lvl_Produto, lvds_2, lvl_Saldo_Filiais)
						  lvds_1.Object.Qt_Saldo_Filiais[lvl_Contaitem] = lvl_Saldo_Filiais - lvl_Saldo_Matriz
					  End If
					  
					  //Tratamento Tipo Comissao
					  lvds_1.Object.pc_comissao_normal		[lvl_Contaitem] = wf_Consulta_Comissao(lvl_Produto, 1, lds_comissao)
					  lvds_1.Object.pc_comissao_seletiva		[lvl_Contaitem] = wf_Consulta_Comissao(lvl_Produto, 2, lds_comissao)
					  
					  //In$$HEX1$$ed00$$ENDHEX$$cio Lima
						
						 lvds_1.Object.Qt_Saldo_Total[lvl_Contaitem] = lvds_1.Object.Qt_Saldo_Matriz[lvl_Contaitem] + lvds_1.Object.Qt_Saldo_Filiais[lvl_Contaitem]	
						
					  //Valor de saldo do Perini
					  ldc_Saldo_Mat = wf_Valor_Saldo(lvl_Produto, lds_Custo_Perini)
					  lvds_1.Object.Vl_Saldo_Matriz[lvl_Contaitem] = ldc_Saldo_Mat
												  
					  //Valor de saldo filiais
					  ldc_Saldo_Fil = wf_Valor_Saldo(lvl_Produto, lds_Custo_Filiais)
					  lvds_1.Object.Vl_Saldo_Filiais[lvl_Contaitem] = ldc_Saldo_Fil
					  
					  lvds_1.Object.Vl_Saldo_Total[lvl_Contaitem]= ldc_Saldo_Mat + ldc_Saldo_Fil
					  
					  //Dias Estoque Perini
					  ll_Qt_Dias_Estoque = wf_Media_Venda(lvl_Produto, lvds_1.Object.Qt_Saldo_Transito[lvl_Contaitem], lvds_1.Object.Qt_Saldo_Matriz[lvl_Contaitem], lds_Venda)
					  lvds_1.Object.Qt_Dias_Estoque_Matriz[lvl_Contaitem] = ll_Qt_Dias_Estoque
								  
					  //Dias Estoque Filiais - Saldo em tr$$HEX1$$e200$$ENDHEX$$nsito $$HEX1$$e900$$ENDHEX$$ somente para o EC
					  ll_Qt_Dias_Estoque = wf_Media_Venda(lvl_Produto, 0, lvds_1.Object.Qt_Saldo_Filiais[lvl_Contaitem], lds_Venda)
					  lvds_1.Object.Qt_Dias_Estoque_Filiais[lvl_Contaitem] = ll_Qt_Dias_Estoque
									  
					  lvds_1.Object.Qt_Dias_Estoque_Geral[lvl_Contaitem] = lvds_1.Object.Qt_Dias_Estoque_Matriz[lvl_Contaitem] + lvds_1.Object.Qt_Dias_Estoque_Filiais[lvl_Contaitem]
					  
					  //Fim Lima
				  End If
									
				  If lvs_filiais = 'C' Then
					  If lvl_Contames = 1 Then
						  lvds_1.Object.Qt_Venda_Mes_1				[lvl_Contaitem] = wf_Venda_Liquida_Filial(lvl_Produto, lvds_4, Ref ldc_Venda)
						  lvds_1.Object.Vl_Venda_Mes_1				[lvl_Contaitem] = ldc_Venda
						  lvds_1.Object.Vl_Rent_Mes_1					[lvl_Contaitem] = wf_Rentabilidade(lvl_Produto, lvds_4, Ref ldc_Percent_Rent)
						  lvds_1.Object.Vl_Percent_Rent_Mes_1		[lvl_Contaitem] = ldc_Percent_Rent
					  ElseIf lvl_Contames = 2 Then
						  lvds_1.Object.Qt_Venda_Mes_2				[lvl_Contaitem] = wf_Venda_Liquida_Filial(lvl_Produto, lvds_4, Ref ldc_Venda)
						  lvds_1.Object.Vl_Venda_Mes_2				[lvl_Contaitem] = ldc_Venda
						  lvds_1.Object.Vl_Rent_Mes_2					[lvl_Contaitem] = wf_Rentabilidade(lvl_Produto, lvds_4, Ref ldc_Percent_Rent)
						  lvds_1.Object.Vl_Percent_Rent_Mes_2		[lvl_Contaitem] = ldc_Percent_Rent
					  ElseIf lvl_Contames = 3 Then
						  lvds_1.Object.Qt_Venda_Mes_3				[lvl_Contaitem] = wf_Venda_Liquida_Filial(lvl_Produto, lvds_4, Ref ldc_Venda)
						  lvds_1.Object.Vl_Venda_Mes_3				[lvl_Contaitem] = ldc_Venda
						  lvds_1.Object.Vl_Rent_Mes_3					[lvl_Contaitem] = wf_Rentabilidade(lvl_Produto, lvds_4, Ref ldc_Percent_Rent)
						  lvds_1.Object.Vl_Percent_Rent_Mes_3		[lvl_Contaitem] = ldc_Percent_Rent
					  ElseIf lvl_Contames = 4 Then
						  lvds_1.Object.Qt_Venda_Mes_4				[lvl_Contaitem] = wf_Venda_Liquida_FIlial(lvl_Produto, lvds_4, Ref ldc_Venda)
						  lvds_1.Object.Vl_Venda_Mes_4				[lvl_Contaitem] = ldc_Venda
						  lvds_1.Object.Vl_Rent_Mes_4					[lvl_Contaitem] = wf_Rentabilidade(lvl_Produto, lvds_4, Ref ldc_Percent_Rent)
						  lvds_1.Object.Vl_Percent_Rent_Mes_4		[lvl_Contaitem] = ldc_Percent_Rent
					  ElseIf lvl_Contames = 5 Then
						  lvds_1.Object.Qt_Venda_Mes_5				[lvl_Contaitem] = wf_Venda_Liquida_Filial(lvl_Produto, lvds_4, Ref ldc_Venda)
						  lvds_1.Object.Vl_Venda_Mes_5				[lvl_Contaitem] = ldc_Venda
						  lvds_1.Object.Vl_Rent_Mes_5					[lvl_Contaitem] = wf_Rentabilidade(lvl_Produto, lvds_4, Ref ldc_Percent_Rent)
						  lvds_1.Object.Vl_Percent_Rent_Mes_5		[lvl_Contaitem] = ldc_Percent_Rent
					  ElseIf lvl_Contames = 6 Then
						  lvds_1.Object.Qt_Venda_Mes_6				[lvl_Contaitem] = wf_Venda_Liquida_Filial(lvl_Produto, lvds_4, Ref ldc_Venda)
						  lvds_1.Object.Vl_Venda_Mes_6				[lvl_Contaitem] = ldc_Venda
						  lvds_1.Object.Vl_Rent_Mes_6					[lvl_Contaitem] = wf_Rentabilidade(lvl_Produto, lvds_4, Ref ldc_Percent_Rent)
						  lvds_1.Object.Vl_Percent_Rent_Mes_6		[lvl_Contaitem] = ldc_Percent_Rent
					  ElseIf lvl_Contames = 7 Then
						  lvds_1.Object.Qt_Venda_Mes_Base			[lvl_Contaitem] = wf_Venda_Liquida_Filial(lvl_Produto, lvds_4, Ref ldc_Venda)
						  lvds_1.Object.Vl_Venda_Mes_Base			[lvl_Contaitem] = ldc_Venda
						  lvds_1.Object.Vl_Rent_Mes_Base				[lvl_Contaitem] = wf_Rentabilidade(lvl_Produto, lvds_4, Ref ldc_Percent_Rent)
						  lvds_1.Object.Vl_Percent_Rent_Mes_Base	[lvl_Contaitem] = ldc_Percent_Rent
					  End If
				  Else
					  If lvl_Contames = 1 Then
						  lvds_1.Object.Qt_Venda_Mes_1				[lvl_Contaitem] = wf_Venda_Liquida(lvl_Produto, lvds_2, Ref ldc_Venda)
						  lvds_1.Object.Vl_Venda_Mes_1				[lvl_Contaitem] = ldc_Venda
						  lvds_1.Object.Vl_Rent_Mes_1					[lvl_Contaitem] = wf_Rentabilidade(lvl_Produto, lvds_2, Ref ldc_Percent_Rent)
						  lvds_1.Object.Vl_Percent_Rent_Mes_1		[lvl_Contaitem] = ldc_Percent_Rent
					  ElseIf lvl_Contames = 2 Then
						  lvds_1.Object.Qt_Venda_Mes_2				[lvl_Contaitem] = wf_Venda_Liquida(lvl_Produto, lvds_2, Ref ldc_Venda)
						  lvds_1.Object.Vl_Venda_Mes_2				[lvl_Contaitem] = ldc_Venda
						  lvds_1.Object.Vl_Rent_Mes_2					[lvl_Contaitem] = wf_Rentabilidade(lvl_Produto, lvds_2, Ref ldc_Percent_Rent)
						  lvds_1.Object.Vl_Percent_Rent_Mes_2		[lvl_Contaitem] = ldc_Percent_Rent
					  ElseIf lvl_Contames = 3 Then
						  lvds_1.Object.Qt_Venda_Mes_3				[lvl_Contaitem] = wf_Venda_Liquida(lvl_Produto, lvds_2, Ref ldc_Venda)
						  lvds_1.Object.Vl_Venda_Mes_3				[lvl_Contaitem] = ldc_Venda
						  lvds_1.Object.Vl_Rent_Mes_3					[lvl_Contaitem] = wf_Rentabilidade(lvl_Produto, lvds_2, Ref ldc_Percent_Rent)
						  lvds_1.Object.Vl_Percent_Rent_Mes_3		[lvl_Contaitem] = ldc_Percent_Rent
					  ElseIf lvl_Contames = 4 Then
						  lvds_1.Object.Qt_Venda_Mes_4				[lvl_Contaitem] = wf_Venda_Liquida(lvl_Produto, lvds_2, Ref ldc_Venda)
						  lvds_1.Object.Vl_Venda_Mes_4				[lvl_Contaitem] = ldc_Venda
						  lvds_1.Object.Vl_Rent_Mes_4					[lvl_Contaitem] = wf_Rentabilidade(lvl_Produto, lvds_2, Ref ldc_Percent_Rent)
						  lvds_1.Object.Vl_Percent_Rent_Mes_4		[lvl_Contaitem] = ldc_Percent_Rent
					  ElseIf lvl_Contames = 5 Then
						  lvds_1.Object.Qt_Venda_Mes_5				[lvl_Contaitem] = wf_Venda_Liquida(lvl_Produto, lvds_2, Ref ldc_Venda)
						  lvds_1.Object.Vl_Venda_Mes_5				[lvl_Contaitem] = ldc_Venda
						  lvds_1.Object.Vl_Rent_Mes_5					[lvl_Contaitem] = wf_Rentabilidade(lvl_Produto, lvds_2, Ref ldc_Percent_Rent)
						  lvds_1.Object.Vl_Percent_Rent_Mes_5		[lvl_Contaitem] = ldc_Percent_Rent
					  ElseIf lvl_Contames = 6 Then
						  lvds_1.Object.Qt_Venda_Mes_6				[lvl_Contaitem] = wf_Venda_Liquida(lvl_Produto, lvds_2, Ref ldc_Venda)
						  lvds_1.Object.Vl_Venda_Mes_6				[lvl_Contaitem] = ldc_Venda
						  lvds_1.Object.Vl_Rent_Mes_6					[lvl_Contaitem] = wf_Rentabilidade(lvl_Produto, lvds_2, Ref ldc_Percent_Rent)
						  lvds_1.Object.Vl_Percent_Rent_Mes_6		[lvl_Contaitem] = ldc_Percent_Rent
					  ElseIf lvl_Contames = 7 Then
						  lvds_1.Object.Qt_Venda_Mes_Base			[lvl_Contaitem] = wf_Venda_Liquida(lvl_Produto, lvds_2, Ref ldc_Venda)
						  lvds_1.Object.Vl_Venda_Mes_Base			[lvl_Contaitem] = ldc_Venda
						  lvds_1.Object.Vl_Rent_Mes_Base				[lvl_Contaitem] = wf_Rentabilidade(lvl_Produto, lvds_2, Ref ldc_Percent_Rent)
						  lvds_1.Object.Vl_Percent_Rent_Mes_Base	[lvl_Contaitem] = ldc_Percent_Rent
					  End If
				  End If
	
				  w_Aguarde.uo_Progress.of_SetProgress(lvl_Contaitem)	
				  
			 Next //Total Planilha
			 
		Next
		
		w_Aguarde.Title = "Salvando Planilha..."
		
		If lvl_Total > 65000 Then
			lvs_Arquivo = lvs_Diretorio + "analise_geral_" + &
													String(Today(), "ddmmyy") + "_" + String(Now(), "hhmm") + ".txt"
													
			If lvds_1.Saveas(lvs_Arquivo, Text!, True) = 1 Then
				lvt_Termino = Now()
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Arquivo '" + lvs_Arquivo + "' gerado com sucesso.~r~r" + &
										 "In$$HEX1$$ed00$$ENDHEX$$cio: "  + String(lvt_Inicio , "hh:mm:ss") + "~r" + &
										 "T$$HEX1$$e900$$ENDHEX$$rmino: " + String(lvt_Termino, "hh:mm:ss"), Information!)
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no saveas do arquivo '" + lvs_Arquivo + "'.", StopSign!)
			End If
		Else
			lvs_Arquivo = lvs_Diretorio + "analise_geral_" + &
													String(Today(), "ddmmyy") + "_" + String(Now(), "hhmm") + ".xls"
			If lvds_1.SaveAs(lvs_Arquivo, Excel8!, True) = 1 Then
				lvt_Termino = Now()
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Planilha '" + lvs_Arquivo + "' gerada com sucesso.~r~r" + &
										 "In$$HEX1$$ed00$$ENDHEX$$cio: "  + String(lvt_Inicio , "hh:mm:ss") + "~r" + &
										 "T$$HEX1$$e900$$ENDHEX$$rmino: " + String(lvt_Termino, "hh:mm:ss"), Information!)
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no saveas da planilha '" + lvs_Arquivo + "'.", StopSign!)
			End If
		End If
		
		dw_1.Reset()
		dw_1.Event ue_AddRow()
		dw_1.Object.Dt_Inicio [1] = Date("01/" + String(Today(), "mm/yyyy"))
		dw_1.SetFocus()
		
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.",Information!)
	End If

Finally
	Destroy(lvds_1)
	Destroy(lvds_2)
	Destroy(lvds_3)
	Destroy(lvds_4)
	Destroy(lvds_5)
	Destroy(lds_comissao)
	//Destroy(lds_Venda_Perini)
	Destroy(lds_Custo_Perini)
	Destroy(lds_Custo_Filiais)
	
	Close(w_Aguarde)	
	SetPointer(Arrow!)

//	cb_Sair.Event Clicked()
End Try
end subroutine

public function any wf_null (any a_valor, any a_default);If IsNull(a_valor) Then
	Return a_default
Else
	Return a_valor
End If
end function

public subroutine wf_gera_analise_exportacao ();Decimal	ldc_Saldo_Fil		, &
			ldc_Saldo_Mat		, &
			ldc_Venda			, &
			ldc_Percent_Rent

Long 	lvl_Contaitem		, &
		lvl_Contames		, &
		lvl_Total				, &
		lvl_Produto			, &
		lvl_Saldo_Matriz	, &
		lvl_Saldo_Filiais	, &
		lvl_Venda_Liquida	, &
		lvl_Mix				, &
		ll_EB_Filiais			, &
		ll_Qt_Dias_Venda	, &
		ll_Qt_Dias_Estoque, &
		ll_Divisao_Forn
		
Integer 	lvi_Retorno, &
			lvi_Arq, &
			lvi_Ret

Date 	lvdt_Mes_Base	, &
		lvdt_Mes_1		, &
		lvdt_Mes_2		, &
		lvdt_Mes_3		, &
		lvdt_Mes_4		, &
		lvdt_Mes_5		, &
		lvdt_Mes_6		, &
		lvdt_Mes
	  
DateTime	ldh_Mes_Corrente, &
				ldh_Periodo_Venda	
	  
Time	lvt_Inicio		, &
		lvt_Termino

String	lvs_Diretorio			, &
		lvs_Arquivo  		, &
		lvs_Fornecedor		, &
		lvs_Lei				, &
		lvs_Grupo			, &
		lvs_SubGrupo		, &
		lvs_Categoria		, &
		lvs_SubCategoria	, &
		lvs_Situacao			, &
		lvs_Filiais			, &
		ls_Data_Store		, &
		ls_Aux, &
		is_Dir_Arquivo_Analise_Geral, &
		lvs_Registro
		
Try		

	lvs_Diretorio = gvo_Aplicacao.of_GetFromINI("Diretorio", "Diretorio")
	
	dc_uo_ds_Base lvds_1
	lvds_1 = Create dc_uo_ds_Base	
	If Not lvds_1.of_ChangeDataObject("dw_ge178_planilha_exportacao") Then Return
	
	dc_uo_ds_Base lvds_2
	lvds_2 = Create dc_uo_ds_Base
	If Not lvds_2.of_ChangeDataObject("dw_ge178_resumo_mes") Then Return
	
	dc_uo_ds_Base lvds_3
	lvds_3 = Create dc_uo_ds_Base
	If Not lvds_3.of_ChangeDataObject("dw_ge178_saldo") Then Return
	
	dc_uo_ds_Base lvds_4
	lvds_4 = Create dc_uo_ds_Base
	If Not lvds_4.of_ChangeDataObject("dw_ge178_resumo_mes_filiais") Then Return
	
	dc_uo_ds_Base lvds_5
	lvds_5 = Create dc_uo_ds_Base
	If Not lvds_5.of_ChangeDataObject("dw_ge178_saldo_filiais") Then Return
	
	dc_uo_ds_Base lds_comissao
	lds_comissao = Create dc_uo_ds_Base
	If Not lds_comissao.of_ChangeDataObject("dw_ge178_comissao_produto") Then Return
	
	//dc_uo_ds_Base f_Perini
	//lds_Venda_Perini = Create dc_uo_ds_Base
	//If Not lds_Venda_Perini.of_ChangeDataObject("dw_ge178_venda_perini") Then Return
	
	dc_uo_ds_Base lds_Custo_Perini
	lds_Custo_Perini = Create dc_uo_ds_Base
	If Not lds_Custo_Perini.of_ChangeDataObject("dw_ge178_custo_perini") Then Return
	
	dc_uo_ds_Base lds_Custo_Filiais
	lds_Custo_Filiais = Create dc_uo_ds_Base
	If Not lds_Custo_Filiais.of_ChangeDataObject("dw_ge178_custo_filiais") Then Return
	
	lvt_Inicio = Now()
	
	SetPointer(HourGlass!)
	Open(w_Aguarde)
	w_Aguarde.Title = "Recuperando as informa$$HEX2$$e700f500$$ENDHEX$$es..."
	
	dw_1.AcceptText()
	
	lvdt_Mes_Base    	= dw_1.Object.dt_inicio      					[1]
	lvs_fornecedor		= dw_1.Object.cd_fornecedor  				[1]
	lvs_Filiais			= dw_1.Object.de_filial      					[1]
	lvs_Lei				= dw_1.Object.Id_Lei_Generico			[1]
	lvs_Grupo        		= dw_1.Object.Cd_Grupo     				[1]
	lvs_SubGrupo		= dw_1.Object.Cd_SubGrupo    			[1]
	lvs_Categoria		= dw_1.Object.Cd_Categoria   				[1]
	lvs_SubCategoria 	= dw_1.Object.Cd_SubCategoria			[1]
	lvs_Situacao			= dw_1.Object.Id_Situacao    				[1]
	lvl_Mix				= dw_1.Object.cd_mix         				[1]
	ll_Divisao_Forn		= dw_1.Object.Nr_Divisao_Fornecedor	[1]
	ldh_Mes_Corrente	= gf_GetServerDate()
	
//	If IsNull(lvdt_Mes_Base) Then
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Favor informar a data base para gera$$HEX2$$e700e300$$ENDHEX$$o do arquivo.",Information!)
//		dw_1.Event ue_Pos(1, "dt_inicio")
//		Return
//	End If
//	
	If Not wf_Verifica_Filial_Selecionada(lvs_Filiais) Then
		Close(w_Aguarde)
		Return
	End If
	
	If Not IsNull(lvs_fornecedor) Then
		lvds_1.Of_appendwhere("pg.cd_fornecedor_usual = '" + lvs_fornecedor + "'")
	End If
	
	//Divis$$HEX1$$e300$$ENDHEX$$o do fornecedor
	If Not IsNull(ll_Divisao_Forn) And ll_Divisao_Forn > 0 Then
		lvds_1.Of_appendwhere(" pg.cd_produto in ( select cd_produto" + &
										 " from vw_divisao_fornecedor_produto" + &
										 " where cd_fornecedor = '" + lvs_Fornecedor + "'" + &
										 " and nr_divisao = " + String(ll_Divisao_Forn) + ")")
	End If
	
	If Not IsNull(lvs_Lei) and lvs_Lei <> "T" Then
		lvds_1.Of_appendwhere("pg.id_lei_generico = '" + lvs_Lei + "'")
	End If
	
	// Grupo
	If Not IsNull(lvs_Grupo) and lvs_Grupo <> "" Then
		lvds_1.of_Appendwhere("cp.cd_grupo = '" + lvs_Grupo + "'")
	End If
	
	// SubGrupo
	If Not IsNull(lvs_SubGrupo) and lvs_SubGrupo <> "" Then
		lvds_1.of_Appendwhere("cp.cd_subgrupo = '" + lvs_SubGrupo + "'")
	End If
	
	// Categoria
	If Not IsNull(lvs_Categoria) and lvs_Categoria <> "" Then
		lvds_1.of_Appendwhere("cp.cd_categoria = '" + lvs_Categoria + "'")
	End If
	
	// SubCategoria
	If Not IsNull(lvs_SubCategoria) and lvs_SubCategoria <> "" Then
		lvds_1.of_Appendwhere("cp.cd_subcategoria = '" + lvs_SubCategoria + "'")
	End If
	
	If lvs_Situacao <> "T" Then
		lvds_1.of_AppendWhere("pg.id_situacao = '" + lvs_Situacao + "'")
	End If
	
	// Mix
	If Not IsNull(lvl_Mix) Then
		lvds_1.of_AppendWhere("pc.cd_mix_produto = " + String(lvl_Mix) )
	End If
	
	//  Local Onde Grava
	is_Dir_Arquivo_Analise_Geral = ProfileString(gvo_aplicacao.ivs_arquivo_ini,"GE", "Arquivos_Pentaho", gvo_aplicacao.ivs_path_arquivos+"\Arquivos_Pentaho")
	If Not DirectoryExists(is_Dir_Arquivo_Analise_Geral) Then CreateDirectory(is_Dir_Arquivo_Analise_Geral)
	// Nome do Arquivo
	lvs_Arquivo =  is_Dir_Arquivo_Analise_Geral + "\DBA.ge_analise_geral_ge178.txt"
	
	If FileExists (lvs_Arquivo) Then
		lvi_Retorno = 1 
		Choose Case lvi_Retorno
			Case 1
				If Not FileDelete ( lvs_Arquivo ) Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao excluir o arquivo '" + lvs_Arquivo + "'.", StopSign!)
					gvo_aplicacao.of_grava_log("GE - Extra$$HEX2$$e700e300$$ENDHEX$$o An$$HEX1$$e100$$ENDHEX$$lise Geral - GE178 - Erro ao excluir o arquivo")
					Return
				End If
			Case 2
				Return
			Case 3
				gvo_aplicacao.of_grava_log("GE - Extra$$HEX2$$e700e300$$ENDHEX$$o An$$HEX1$$e100$$ENDHEX$$lise Geral - GE178 - Erro ao excluir o arquivo")
				Return
		End Choose
	End If
	
	lvi_Arq = FileOpen(lvs_Arquivo, LineMode!, Write!, LockReadWrite!, Append!, EncodingUTF8!)
	
	If lvi_Arq = -1 Then
		gvo_aplicacao.of_grava_log("GE - Extra$$HEX2$$e700e300$$ENDHEX$$o An$$HEX1$$e100$$ENDHEX$$lise Geral - GE178 - Erro ao abrir o arquivo")
		Return
	End If
	
	lvl_Total = lvds_1.Retrieve()
	
	If lvl_Total > 0 Then
		
		// Cabe$$HEX1$$e700$$ENDHEX$$alho do Arquivo
		lvs_Registro ="cd_produto" + is_Separador +&
						"de_produto" + is_Separador +&
						"de_apresentacao_venda" + is_Separador +&
						"dh_inclusao_produto" + is_Separador +&
						"qt_venda_mes1" + is_Separador +&
						"qt_venda_mes2" + is_Separador +&
						"qt_venda_mes3" + is_Separador +&
						"qt_venda_mes4" + is_Separador +&
						"qt_venda_mes5" + is_Separador +&
						"qt_venda_mes6" + is_Separador +&
						"id_situacao" + is_Separador +&
						"vl_preco_venda_atual"+ is_Separador +&
						"vl_custo_medio"+ is_Separador +&
						"cd_fornecedor"+ is_Separador +&
						"nm_fornecedor"+ is_Separador +&
						"pc_desconto_sos"+ is_Separador +&
						"qt_saldo_matriz"+ is_Separador +&
						"qt_saldo_filiais"+ is_Separador +&
						"dt_ultima_entrada"+ is_Separador +&
						"id_situacao_pis_cofins"+ is_Separador +&
						"de_grupo"+ is_Separador +&
						"de_subgrupo"+ is_Separador +&
						"de_categoria"+ is_Separador +&
						"de_subcategoria"+ is_Separador +&
						"qt_venda_mes_base"+ is_Separador +&
						"de_mix_produto"+ is_Separador +&
						"vl_preco_reposicao"+ is_Separador +&
						"vl_fator_conversao"+ is_Separador +&
						"de_codigo_barras"+ is_Separador +&
						"vl_custo_gerencial"+ is_Separador +&
						"nr_caixa_embarque"+ is_Separador +&
						"nr_classificacao_fiscal"+ is_Separador +&
						"pc_ipi"+ is_Separador +&
						"cd_st_origem"+ is_Separador +&
						"de_origem_produto"+ is_Separador +&
						"pc_comissao_normal"+ is_Separador +&
						"pc_comissao_seletiva"+ is_Separador +&
						"de_demanda"+ is_Separador +&
						"id_lei_generico"+ is_Separador +&
						"nm_comprador"+ is_Separador +&
						"qt_saldo_total"+ is_Separador +&
						"vl_saldo_matriz"+ is_Separador +&
						"vl_saldo_filiais"+ is_Separador +&
						"vl_saldo_total"+ is_Separador +&
						"qt_dias_estoque_matriz"+ is_Separador +&
						"qt_dias_estoque_filiais"+ is_Separador +&
						"qt_dias_estoque_geral"+ is_Separador +&
						"vl_venda_mes_base"+ is_Separador +&
						"vl_venda_mes_1"+ is_Separador +&
						"vl_venda_mes_2"+ is_Separador +&
						"vl_venda_mes_3"+ is_Separador +&
						"vl_venda_mes_4"+ is_Separador +&
						"vl_venda_mes_5"+ is_Separador +&
						"vl_venda_mes_6"+ is_Separador +&
						"vl_rent_mes_1"+ is_Separador +&
						"vl_rent_mes_2"+ is_Separador +&
						"vl_rent_mes_3"+ is_Separador +&
						"vl_rent_mes_4"+ is_Separador +&
						"vl_rent_mes_5"+ is_Separador +&
						"vl_rent_mes_6"+ is_Separador +&
						"vl_rent_mes_base"+ is_Separador +&
						"vl_percent_rent_mes_1"+ is_Separador +&
						"vl_percent_rent_mes_2"+ is_Separador +&
						"vl_percent_rent_mes_3"+ is_Separador +&
						"vl_percent_rent_mes_4"+ is_Separador +&
						"vl_percent_rent_mes_5"+ is_Separador +&
						"vl_percent_rent_mes_6"+ is_Separador +&
						"vl_percent_rent_mes_base"+ is_Separador +&
						"id_caderno_abcfarma"+ is_Separador +&
						"de_tributacao_icms"+ is_Separador +&
						"nr_divisao"+ is_Separador +&
						"nm_divisao"+ is_Separador +&
						"classe_cd"+ is_Separador +&
						"classe_empresa"+ is_Separador +&
						"cd_grupo_psico"+ is_Separador +&
						"cd_produto_sap"+ is_Separador +&
						"qt_saldo_transito"
														
		lvi_Ret = FileWrite(lvi_Arq, lvs_Registro)
			
		If IsNull(lvi_Ret) or lvi_Ret <= 0 Then
			gvo_aplicacao.of_grava_log("GE - Extra$$HEX2$$e700e300$$ENDHEX$$o An$$HEX1$$e100$$ENDHEX$$lise Geral - GE178 - Erro ao gravar registro cabe$$HEX1$$e700$$ENDHEX$$alho")
			Return
		End If		
		
		If Not wf_Saldo_Em_Transito(lvds_1) Then Return
		
		w_Aguarde.Title = "Calculando Saldo Matriz..."
		
		lvds_3.Retrieve(lvdt_Mes_Base)
		
		lds_comissao.Retrieve()
	
		If lvs_filiais = 'C' Then
			w_Aguarde.Title = "Calculando Saldo Filial..."
			lvds_5.of_AppendWhere("cd_filial in ( " + is_filiais + " )" )
			lvds_5.Retrieve( lvdt_Mes_Base )
			
			lvds_4.of_AppendWhere("r.cd_filial in ( " + is_filiais + " )" )
		End If
		
		If lvs_Filiais = "C" Then
			ls_Data_Store = "dw_ge178_venda_filial"
		Else
			ls_Data_Store = "dw_ge178_venda_filiais"
		End If
			
		dc_uo_ds_Base lds_Venda
		lds_Venda = Create dc_uo_ds_Base
		If Not lds_Venda.of_ChangeDataObject(ls_Data_Store) Then
			Destroy(lds_Venda)
			Close(w_Aguarde)
//			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar o data store '" + ls_Data_Store + "'.", StopSign!)
			Return
		End If
		
		If lvs_Filiais = "C" Then
			lds_Venda.of_AppendWhere("cd_filial in ( " + is_filiais + " )")
			lds_Custo_Filiais.of_AppendWhere("s.cd_filial in ( " + is_filiais + " )")
		Else
			lds_Custo_Filiais.of_AppendWhere("s.cd_filial <> 534")
		End If
		
		wf_Data_Venda(Ref ldh_Periodo_Venda)
		
		w_Aguarde.Title = "Calculando M$$HEX1$$e900$$ENDHEX$$dia de Venda..."
		lds_Venda.Retrieve(ldh_Periodo_Venda)
	//	lds_Venda_Perini.Retrieve(ldh_Periodo_Venda)
		
		w_Aguarde.Title = "Calculando Valor de Saldo..."
		ls_Aux = String(ldh_Mes_Corrente)
		
		ls_Aux = "01/" + MidA(ls_Aux, 4, 8) + "00:00:00"
		
		ldh_Mes_Corrente = DateTime(ls_Aux)
		
		lds_Custo_Perini.Retrieve(ldh_Mes_Corrente)
		lds_Custo_Filiais.Retrieve(ldh_Mes_Corrente)
	
		lvdt_Mes_1 = wf_Mes_Anterior(lvdt_Mes_Base, 6)
		lvdt_Mes_2 = wf_Mes_Anterior(lvdt_Mes_Base, 5)
		lvdt_Mes_3 = wf_Mes_Anterior(lvdt_Mes_Base, 4)
		lvdt_Mes_4 = wf_Mes_Anterior(lvdt_Mes_Base, 3)
		lvdt_Mes_5 = wf_Mes_Anterior(lvdt_Mes_Base, 2)
		lvdt_Mes_6 = wf_Mes_Anterior(lvdt_Mes_Base, 1)
		
		For lvl_Contames = 1 to 7
			 
			 If lvl_Contames = 1 Then
				 lvdt_mes = lvdt_mes_1
			 ElseIf lvl_Contames = 2 Then
				 lvdt_mes = lvdt_mes_2
			 ElseIf lvl_Contames = 3 Then
				 lvdt_mes = lvdt_mes_3
			 ElseIf lvl_Contames = 4 Then
				 lvdt_mes = lvdt_mes_4
			 ElseIf lvl_Contames = 5 Then
				 lvdt_mes = lvdt_mes_5
			 ElseIf lvl_Contames = 6 Then
				 lvdt_mes = lvdt_mes_6
			 ElseIf lvl_Contames = 7 Then
				 lvdt_mes = lvdt_mes_base
			 End If
				 
			 w_Aguarde.Title = "Calculando Vendas do M$$HEX1$$ea00$$ENDHEX$$s " + string(lvdt_Mes,"mm/yyyy")
			 w_Aguarde.uo_Progress.of_Reset()
			 w_Aguarde.uo_Progress.of_SetMax(lvl_Total)
	
			If lvs_filiais = 'C' Then
				lvds_4.Retrieve(lvdt_Mes)
			 Else
				 lvds_2.Retrieve(lvdt_Mes)
			 End If
	
			 For lvl_Contaitem = 1 To lvl_Total
				  lvl_Produto = lvds_1.Object.Cd_Produto[lvl_Contaitem]
					
				  If lvl_Contames = 7 Then
					  lvds_1.Object.Pc_Desconto_SOS[lvl_Contaitem] = wf_Desconto_SOS(lvl_Produto)
	
					  lvl_Saldo_Matriz = wf_Saldo_Matriz(lvl_Produto,lvds_3)
					  lvds_1.Object.Qt_Saldo_Matriz[lvl_Contaitem] = lvl_Saldo_Matriz
					  
					 If lvs_filiais = 'C' Then
						  lvl_Saldo_Filiais = wf_saldo_Filial(lvl_Produto,lvds_5)
						  lvds_1.Object.Qt_Saldo_Filiais[lvl_Contaitem] = lvl_Saldo_Filiais
					  Else
						  wf_Saldo_Filiais(lvl_Produto, lvds_2, lvl_Saldo_Filiais)
						  lvds_1.Object.Qt_Saldo_Filiais[lvl_Contaitem] = lvl_Saldo_Filiais - lvl_Saldo_Matriz
					  End If
					  
					  //Tratamento Tipo Comissao
					  lvds_1.Object.pc_comissao_normal		[lvl_Contaitem] = wf_Consulta_Comissao(lvl_Produto, 1, lds_comissao)
					  lvds_1.Object.pc_comissao_seletiva		[lvl_Contaitem] = wf_Consulta_Comissao(lvl_Produto, 2, lds_comissao)
					  
					  //In$$HEX1$$ed00$$ENDHEX$$cio Lima
						
						 lvds_1.Object.Qt_Saldo_Total[lvl_Contaitem] = lvds_1.Object.Qt_Saldo_Matriz[lvl_Contaitem] + lvds_1.Object.Qt_Saldo_Filiais[lvl_Contaitem]	
						
					  //Valor de saldo do Perini
					  ldc_Saldo_Mat = wf_Valor_Saldo(lvl_Produto, lds_Custo_Perini)
					  lvds_1.Object.Vl_Saldo_Matriz[lvl_Contaitem] = ldc_Saldo_Mat
												  
					  //Valor de saldo filiais
					  ldc_Saldo_Fil = wf_Valor_Saldo(lvl_Produto, lds_Custo_Filiais)
					  lvds_1.Object.Vl_Saldo_Filiais[lvl_Contaitem] = ldc_Saldo_Fil
					  
					  lvds_1.Object.Vl_Saldo_Total[lvl_Contaitem]= ldc_Saldo_Mat + ldc_Saldo_Fil
					  
					  //Dias Estoque Perini
					  ll_Qt_Dias_Estoque = wf_Media_Venda(lvl_Produto, lvds_1.Object.Qt_Saldo_Transito[lvl_Contaitem], lvds_1.Object.Qt_Saldo_Matriz[lvl_Contaitem], lds_Venda)
					  lvds_1.Object.Qt_Dias_Estoque_Matriz[lvl_Contaitem] = ll_Qt_Dias_Estoque
								  
					  //Dias Estoque Filiais - Saldo em tr$$HEX1$$e200$$ENDHEX$$nsito $$HEX1$$e900$$ENDHEX$$ somente para o EC
					  ll_Qt_Dias_Estoque = wf_Media_Venda(lvl_Produto, 0, lvds_1.Object.Qt_Saldo_Filiais[lvl_Contaitem], lds_Venda)
					  lvds_1.Object.Qt_Dias_Estoque_Filiais[lvl_Contaitem] = ll_Qt_Dias_Estoque
									  
					  lvds_1.Object.Qt_Dias_Estoque_Geral[lvl_Contaitem] = lvds_1.Object.Qt_Dias_Estoque_Matriz[lvl_Contaitem] + lvds_1.Object.Qt_Dias_Estoque_Filiais[lvl_Contaitem]
					  
					  //Fim Lima
				  End If
									
				  If lvs_filiais = 'C' Then
					  If lvl_Contames = 1 Then
						  lvds_1.Object.Qt_Venda_Mes_1				[lvl_Contaitem] = wf_Venda_Liquida_Filial(lvl_Produto, lvds_4, Ref ldc_Venda)
						  lvds_1.Object.Vl_Venda_Mes_1				[lvl_Contaitem] = ldc_Venda
						  lvds_1.Object.Vl_Rent_Mes_1					[lvl_Contaitem] = wf_Rentabilidade(lvl_Produto, lvds_4, Ref ldc_Percent_Rent)
						  lvds_1.Object.Vl_Percent_Rent_Mes_1		[lvl_Contaitem] = ldc_Percent_Rent
					  ElseIf lvl_Contames = 2 Then
						  lvds_1.Object.Qt_Venda_Mes_2				[lvl_Contaitem] = wf_Venda_Liquida_Filial(lvl_Produto, lvds_4, Ref ldc_Venda)
						  lvds_1.Object.Vl_Venda_Mes_2				[lvl_Contaitem] = ldc_Venda
						  lvds_1.Object.Vl_Rent_Mes_2					[lvl_Contaitem] = wf_Rentabilidade(lvl_Produto, lvds_4, Ref ldc_Percent_Rent)
						  lvds_1.Object.Vl_Percent_Rent_Mes_2		[lvl_Contaitem] = ldc_Percent_Rent
					  ElseIf lvl_Contames = 3 Then
						  lvds_1.Object.Qt_Venda_Mes_3				[lvl_Contaitem] = wf_Venda_Liquida_Filial(lvl_Produto, lvds_4, Ref ldc_Venda)
						  lvds_1.Object.Vl_Venda_Mes_3				[lvl_Contaitem] = ldc_Venda
						  lvds_1.Object.Vl_Rent_Mes_3					[lvl_Contaitem] = wf_Rentabilidade(lvl_Produto, lvds_4, Ref ldc_Percent_Rent)
						  lvds_1.Object.Vl_Percent_Rent_Mes_3		[lvl_Contaitem] = ldc_Percent_Rent
					  ElseIf lvl_Contames = 4 Then
						  lvds_1.Object.Qt_Venda_Mes_4				[lvl_Contaitem] = wf_Venda_Liquida_FIlial(lvl_Produto, lvds_4, Ref ldc_Venda)
						  lvds_1.Object.Vl_Venda_Mes_4				[lvl_Contaitem] = ldc_Venda
						  lvds_1.Object.Vl_Rent_Mes_4					[lvl_Contaitem] = wf_Rentabilidade(lvl_Produto, lvds_4, Ref ldc_Percent_Rent)
						  lvds_1.Object.Vl_Percent_Rent_Mes_4		[lvl_Contaitem] = ldc_Percent_Rent
					  ElseIf lvl_Contames = 5 Then
						  lvds_1.Object.Qt_Venda_Mes_5				[lvl_Contaitem] = wf_Venda_Liquida_Filial(lvl_Produto, lvds_4, Ref ldc_Venda)
						  lvds_1.Object.Vl_Venda_Mes_5				[lvl_Contaitem] = ldc_Venda
						  lvds_1.Object.Vl_Rent_Mes_5					[lvl_Contaitem] = wf_Rentabilidade(lvl_Produto, lvds_4, Ref ldc_Percent_Rent)
						  lvds_1.Object.Vl_Percent_Rent_Mes_5		[lvl_Contaitem] = ldc_Percent_Rent
					  ElseIf lvl_Contames = 6 Then
						  lvds_1.Object.Qt_Venda_Mes_6				[lvl_Contaitem] = wf_Venda_Liquida_Filial(lvl_Produto, lvds_4, Ref ldc_Venda)
						  lvds_1.Object.Vl_Venda_Mes_6				[lvl_Contaitem] = ldc_Venda
						  lvds_1.Object.Vl_Rent_Mes_6					[lvl_Contaitem] = wf_Rentabilidade(lvl_Produto, lvds_4, Ref ldc_Percent_Rent)
						  lvds_1.Object.Vl_Percent_Rent_Mes_6		[lvl_Contaitem] = ldc_Percent_Rent
					  ElseIf lvl_Contames = 7 Then
						  lvds_1.Object.Qt_Venda_Mes_Base			[lvl_Contaitem] = wf_Venda_Liquida_Filial(lvl_Produto, lvds_4, Ref ldc_Venda)
						  lvds_1.Object.Vl_Venda_Mes_Base			[lvl_Contaitem] = ldc_Venda
						  lvds_1.Object.Vl_Rent_Mes_Base				[lvl_Contaitem] = wf_Rentabilidade(lvl_Produto, lvds_4, Ref ldc_Percent_Rent)
						  lvds_1.Object.Vl_Percent_Rent_Mes_Base	[lvl_Contaitem] = ldc_Percent_Rent
					  End If
				  Else
					  If lvl_Contames = 1 Then
						  lvds_1.Object.Qt_Venda_Mes_1				[lvl_Contaitem] = wf_Venda_Liquida(lvl_Produto, lvds_2, Ref ldc_Venda)
						  lvds_1.Object.Vl_Venda_Mes_1				[lvl_Contaitem] = ldc_Venda
						  lvds_1.Object.Vl_Rent_Mes_1					[lvl_Contaitem] = wf_Rentabilidade(lvl_Produto, lvds_2, Ref ldc_Percent_Rent)
						  lvds_1.Object.Vl_Percent_Rent_Mes_1		[lvl_Contaitem] = ldc_Percent_Rent
					  ElseIf lvl_Contames = 2 Then
						  lvds_1.Object.Qt_Venda_Mes_2				[lvl_Contaitem] = wf_Venda_Liquida(lvl_Produto, lvds_2, Ref ldc_Venda)
						  lvds_1.Object.Vl_Venda_Mes_2				[lvl_Contaitem] = ldc_Venda
						  lvds_1.Object.Vl_Rent_Mes_2					[lvl_Contaitem] = wf_Rentabilidade(lvl_Produto, lvds_2, Ref ldc_Percent_Rent)
						  lvds_1.Object.Vl_Percent_Rent_Mes_2		[lvl_Contaitem] = ldc_Percent_Rent
					  ElseIf lvl_Contames = 3 Then
						  lvds_1.Object.Qt_Venda_Mes_3				[lvl_Contaitem] = wf_Venda_Liquida(lvl_Produto, lvds_2, Ref ldc_Venda)
						  lvds_1.Object.Vl_Venda_Mes_3				[lvl_Contaitem] = ldc_Venda
						  lvds_1.Object.Vl_Rent_Mes_3					[lvl_Contaitem] = wf_Rentabilidade(lvl_Produto, lvds_2, Ref ldc_Percent_Rent)
						  lvds_1.Object.Vl_Percent_Rent_Mes_3		[lvl_Contaitem] = ldc_Percent_Rent
					  ElseIf lvl_Contames = 4 Then
						  lvds_1.Object.Qt_Venda_Mes_4				[lvl_Contaitem] = wf_Venda_Liquida(lvl_Produto, lvds_2, Ref ldc_Venda)
						  lvds_1.Object.Vl_Venda_Mes_4				[lvl_Contaitem] = ldc_Venda
						  lvds_1.Object.Vl_Rent_Mes_4					[lvl_Contaitem] = wf_Rentabilidade(lvl_Produto, lvds_2, Ref ldc_Percent_Rent)
						  lvds_1.Object.Vl_Percent_Rent_Mes_4		[lvl_Contaitem] = ldc_Percent_Rent
					  ElseIf lvl_Contames = 5 Then
						  lvds_1.Object.Qt_Venda_Mes_5				[lvl_Contaitem] = wf_Venda_Liquida(lvl_Produto, lvds_2, Ref ldc_Venda)
						  lvds_1.Object.Vl_Venda_Mes_5				[lvl_Contaitem] = ldc_Venda
						  lvds_1.Object.Vl_Rent_Mes_5					[lvl_Contaitem] = wf_Rentabilidade(lvl_Produto, lvds_2, Ref ldc_Percent_Rent)
						  lvds_1.Object.Vl_Percent_Rent_Mes_5		[lvl_Contaitem] = ldc_Percent_Rent
					  ElseIf lvl_Contames = 6 Then
						  lvds_1.Object.Qt_Venda_Mes_6				[lvl_Contaitem] = wf_Venda_Liquida(lvl_Produto, lvds_2, Ref ldc_Venda)
						  lvds_1.Object.Vl_Venda_Mes_6				[lvl_Contaitem] = ldc_Venda
						  lvds_1.Object.Vl_Rent_Mes_6					[lvl_Contaitem] = wf_Rentabilidade(lvl_Produto, lvds_2, Ref ldc_Percent_Rent)
						  lvds_1.Object.Vl_Percent_Rent_Mes_6		[lvl_Contaitem] = ldc_Percent_Rent
					  ElseIf lvl_Contames = 7 Then
						  lvds_1.Object.Qt_Venda_Mes_Base			[lvl_Contaitem] = wf_Venda_Liquida(lvl_Produto, lvds_2, Ref ldc_Venda)
						  lvds_1.Object.Vl_Venda_Mes_Base			[lvl_Contaitem] = ldc_Venda
						  lvds_1.Object.Vl_Rent_Mes_Base				[lvl_Contaitem] = wf_Rentabilidade(lvl_Produto, lvds_2, Ref ldc_Percent_Rent)
						  lvds_1.Object.Vl_Percent_Rent_Mes_Base	[lvl_Contaitem] = ldc_Percent_Rent
					  End If
				  End If
				  w_Aguarde.uo_Progress.of_SetProgress(lvl_Contaitem)	
			 Next //Total Planilha
		Next
		
		w_Aguarde.Title = "Salvando Planilha..."
		
		lvl_Total = lvds_1.RowCount()
		
		For lvl_Contaitem = 1 To lvl_Total
			 
			// Linhas do Arquivo
			lvs_Registro =  String(this.wf_null(lvds_1.Object.cd_produto[lvl_ContaItem],'')) + is_Separador +&
								String(this.wf_null(lvds_1.Object.de_produto[lvl_ContaItem],'')) + is_Separador +&
								String(this.wf_null(lvds_1.Object.de_apresentacao_venda[lvl_ContaItem],'')) + is_Separador +&
								String(this.wf_null(lvds_1.Object.dh_inclusao_produto[lvl_ContaItem],'')) + is_Separador +&
								String(this.wf_null(lvds_1.Object.qt_venda_mes_1[lvl_ContaItem],'')) + is_Separador +&
								String(this.wf_null(lvds_1.Object.qt_venda_mes_2[lvl_ContaItem],'')) + is_Separador +&
								String(this.wf_null(lvds_1.Object.qt_venda_mes_3[lvl_ContaItem],'')) + is_Separador +&
								String(this.wf_null(lvds_1.Object.qt_venda_mes_4[lvl_ContaItem],'')) + is_Separador +&
								String(this.wf_null(lvds_1.Object.qt_venda_mes_5[lvl_ContaItem],'')) + is_Separador +&
								String(this.wf_null(lvds_1.Object.qt_venda_mes_6[lvl_ContaItem],'')) + is_Separador +&
								String(this.wf_null(lvds_1.Object.id_situacao[lvl_ContaItem],'')) + is_Separador +&
								String(this.wf_null(lvds_1.Object.vl_preco_venda_atual[lvl_ContaItem],'')) + is_Separador +&								
								String(this.wf_null(lvds_1.Object.vl_custo_medio[lvl_ContaItem],'')) + is_Separador +&
								String(this.wf_null(lvds_1.Object.cd_fornecedor[lvl_ContaItem],'')) + is_Separador +&
								String(this.wf_null(lvds_1.Object.nm_fornecedor[lvl_ContaItem],'')) + is_Separador +&
								String(this.wf_null(lvds_1.Object.pc_desconto_sos[lvl_ContaItem],'')) + is_Separador +&
								String(this.wf_null(lvds_1.Object.qt_saldo_matriz[lvl_ContaItem],'')) + is_Separador +&
								String(this.wf_null(lvds_1.Object.qt_saldo_filiais[lvl_ContaItem],'')) + is_Separador +&
								String(this.wf_null(lvds_1.Object.dt_ultima_entrada[lvl_ContaItem],'')) + is_Separador +&
								String(this.wf_null(lvds_1.Object.id_situacao_pis_cofins[lvl_ContaItem],'')) + is_Separador +&
								String(this.wf_null(lvds_1.Object.de_grupo[lvl_ContaItem],'')) + is_Separador +&
								String(this.wf_null(lvds_1.Object.de_subgrupo[lvl_ContaItem],'')) + is_Separador +&
								String(this.wf_null(lvds_1.Object.de_categoria[lvl_ContaItem],'')) + is_Separador +&								
								String(this.wf_null(lvds_1.Object.de_subcategoria[lvl_ContaItem],'')) + is_Separador +&
								String(this.wf_null(lvds_1.Object.qt_venda_mes_base[lvl_ContaItem],'')) + is_Separador +&
								String(this.wf_null(lvds_1.Object.de_mix_produto[lvl_ContaItem],'')) + is_Separador +&
								String(this.wf_null(lvds_1.Object.vl_preco_reposicao[lvl_ContaItem],'')) + is_Separador +&
								String(this.wf_null(lvds_1.Object.vl_fator_conversao[lvl_ContaItem],'')) + is_Separador +&
								String(this.wf_null(lvds_1.Object.de_codigo_barras[lvl_ContaItem],'')) + is_Separador +&
								String(this.wf_null(lvds_1.Object.vl_custo_gerencial[lvl_ContaItem],'')) + is_Separador +&
								String(this.wf_null(lvds_1.Object.nr_caixa_embarque[lvl_ContaItem],'')) + is_Separador +&
								String(this.wf_null(lvds_1.Object.nr_classificacao_fiscal[lvl_ContaItem],'')) + is_Separador +&
								String(this.wf_null(lvds_1.Object.pc_ipi[lvl_ContaItem],'')) + is_Separador +&
								String(this.wf_null(lvds_1.Object.cd_st_origem[lvl_ContaItem],'')) + is_Separador +&								
								String(this.wf_null(lvds_1.Object.de_origem_produto[lvl_ContaItem],'')) + is_Separador +&																
								String(this.wf_null(lvds_1.Object.pc_comissao_normal[lvl_ContaItem],'')) + is_Separador +&
								String(this.wf_null(lvds_1.Object.pc_comissao_seletiva[lvl_ContaItem],'')) + is_Separador +&
								String(this.wf_null(lvds_1.Object.de_demanda[lvl_ContaItem],'')) + is_Separador +&
								String(this.wf_null(lvds_1.Object.id_lei_generico[lvl_ContaItem],'')) + is_Separador +&
								String(this.wf_null(lvds_1.Object.nm_comprador[lvl_ContaItem],'')) + is_Separador +&
								String(this.wf_null(lvds_1.Object.qt_saldo_total[lvl_ContaItem],'')) + is_Separador +&
								String(this.wf_null(lvds_1.Object.vl_saldo_matriz[lvl_ContaItem],'')) + is_Separador +&
								String(this.wf_null(lvds_1.Object.vl_saldo_filiais[lvl_ContaItem],'')) + is_Separador +&
								String(this.wf_null(lvds_1.Object.vl_saldo_total[lvl_ContaItem],'')) + is_Separador +&
								String(this.wf_null(lvds_1.Object.qt_dias_estoque_matriz[lvl_ContaItem],'')) + is_Separador +&
								String(this.wf_null(lvds_1.Object.qt_dias_estoque_filiais[lvl_ContaItem],'')) + is_Separador +&								
								String(this.wf_null(lvds_1.Object.qt_dias_estoque_geral[lvl_ContaItem],'')) + is_Separador +&
								String(this.wf_null(lvds_1.Object.vl_venda_mes_base[lvl_ContaItem],'')) + is_Separador +&
								String(this.wf_null(lvds_1.Object.vl_venda_mes_1[lvl_ContaItem],'')) + is_Separador +&
								String(this.wf_null(lvds_1.Object.vl_venda_mes_2[lvl_ContaItem],'')) + is_Separador +&
								String(this.wf_null(lvds_1.Object.vl_venda_mes_3[lvl_ContaItem],'')) + is_Separador +&
								String(this.wf_null(lvds_1.Object.vl_venda_mes_4[lvl_ContaItem],'')) + is_Separador +&
								String(this.wf_null(lvds_1.Object.vl_venda_mes_5[lvl_ContaItem],'')) + is_Separador +&								
								String(this.wf_null(lvds_1.Object.vl_venda_mes_6[lvl_ContaItem],'')) + is_Separador +&
								String(this.wf_null(lvds_1.Object.vl_rent_mes_1[lvl_ContaItem],'')) + is_Separador +&
								String(this.wf_null(lvds_1.Object.vl_rent_mes_2[lvl_ContaItem],'')) + is_Separador +&
								String(this.wf_null(lvds_1.Object.vl_rent_mes_3[lvl_ContaItem],'')) + is_Separador +&
								String(this.wf_null(lvds_1.Object.vl_rent_mes_4[lvl_ContaItem],'')) + is_Separador +&
								String(this.wf_null(lvds_1.Object.vl_rent_mes_5[lvl_ContaItem],'')) + is_Separador +&
								String(this.wf_null(lvds_1.Object.vl_rent_mes_6[lvl_ContaItem],'')) + is_Separador +&
								String(this.wf_null(lvds_1.Object.vl_rent_mes_base[lvl_ContaItem],'')) + is_Separador +&
								String(this.wf_null(lvds_1.Object.vl_percent_rent_mes_1[lvl_ContaItem],'')) + is_Separador +&
								String(this.wf_null(lvds_1.Object.vl_percent_rent_mes_2[lvl_ContaItem],'')) + is_Separador +&
								String(this.wf_null(lvds_1.Object.vl_percent_rent_mes_3[lvl_ContaItem],'')) + is_Separador +&								
								String(this.wf_null(lvds_1.Object.vl_percent_rent_mes_4[lvl_ContaItem],'')) + is_Separador +&
								String(this.wf_null(lvds_1.Object.vl_percent_rent_mes_5[lvl_ContaItem],'')) + is_Separador +&
								String(this.wf_null(lvds_1.Object.vl_percent_rent_mes_6[lvl_ContaItem],'')) + is_Separador +&
								String(this.wf_null(lvds_1.Object.vl_percent_rent_mes_base[lvl_ContaItem],'')) + is_Separador +&
								String(this.wf_null(lvds_1.Object.id_caderno_abcfarma[lvl_ContaItem],'')) + is_Separador +&
								String(this.wf_null(lvds_1.Object.de_tributacao_icms[lvl_ContaItem],'')) + is_Separador +&
								String(this.wf_null(lvds_1.Object.nr_divisao[lvl_ContaItem],'')) + is_Separador +&
								String(this.wf_null(lvds_1.Object.nm_divisao[lvl_ContaItem],'')) + is_Separador +&
								String(this.wf_null(lvds_1.Object.classe_cd[lvl_ContaItem],'')) + is_Separador +&
								String(this.wf_null(lvds_1.Object.classe_empresa[lvl_ContaItem],'')) + is_Separador +&
								String(this.wf_null(lvds_1.Object.cd_grupo_psico[lvl_ContaItem],'')) + is_Separador +&								
								String(this.wf_null(lvds_1.Object.cd_produto_sap[lvl_ContaItem],'')) + is_Separador +&
								String(this.wf_null(lvds_1.Object.qt_saldo_transito[lvl_ContaItem],''))
								
			  	lvs_Registro = gf_Replace(lvs_Registro, ',','.',0)
				lvs_Registro = wf_retira_caracteres_especiais(lvs_Registro)
								
				// Dados dos Produtos
				lvi_Ret = FileWrite(lvi_Arq, lvs_Registro)					
						
				If IsNull(lvi_Ret) or lvi_Ret <= 0 Then
					gvo_aplicacao.of_grava_log("GE -  Extra$$HEX2$$e700e300$$ENDHEX$$o An$$HEX1$$e100$$ENDHEX$$lise Geral - GE178 - Erro no Arquivo")
					Return
				End If				
			 
		Next // Total Planilha
		
		dw_1.Reset()
		dw_1.Event ue_AddRow()
		dw_1.Object.Dt_Inicio [1] = Date("01/" + String(Today(), "mm/yyyy"))
		dw_1.SetFocus()
		
	Else
		If Not gvb_Auto Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.",Information!)
		End If
	End If

Finally
	Destroy(lvds_1)
	Destroy(lvds_2)
	Destroy(lvds_3)
	Destroy(lvds_4)
	Destroy(lvds_5)
	Destroy(lds_comissao)
	//Destroy(lds_Venda_Perini)
	Destroy(lds_Custo_Perini)
	Destroy(lds_Custo_Filiais)
	
	FileClose(lvi_Arq)
	
	Close(w_Aguarde)	
	SetPointer(Arrow!)

	cb_Sair.Event Clicked()
End Try
end subroutine

public function string wf_retira_caracteres_especiais (string ps_texto);String ls_Caracteres
String ls_Aux

long ll_Row
Long ll_Total

If ps_texto = "" Then Return ps_texto

ls_Caracteres = "$$HEX1$$1420$$ENDHEX$$'$$HEX2$$e700c700$$ENDHEX$$~^$$HEX1$$b400$$ENDHEX$$`$$HEX55$$a800e200c200e000c000e300c300e900c900ea00ca00e800c800ed00cd00ee00ce00ec00cc00e600c600f400f200fb00f900f800a300d8009201e100c100f300fa00f100d100aa00ba00bf00ae00bd00a700bc00d300df00d400d200f500d500b500fe00da00db00d900fd00dd00$$ENDHEX$$!@#$%$$HEX1$$a800$$ENDHEX$$&*()_=+{}[]?><,\-"
ls_Caracteres += '"'

ll_Total = LenA( ps_texto )

For ll_Row = 1 To ll_Total
	
	ls_Aux = mid(ps_texto, ll_Row, 1)
	
	If Pos( ls_Caracteres, ls_Aux ) > 0 Then
		ps_texto = gf_Replace( ps_texto, ls_Aux, "", 1 )
		ll_Total 	-= 1
	End If		   
Next

Return ps_texto

end function

on w_ge178_planilha_analise_geral.create
int iCurrent
call super::create
this.cb_sair=create cb_sair
this.dw_1=create dw_1
this.gb_1=create gb_1
this.cb_gerar=create cb_gerar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_sair
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.gb_1
this.Control[iCurrent+4]=this.cb_gerar
end on

on w_ge178_planilha_analise_geral.destroy
call super::destroy
destroy(this.cb_sair)
destroy(this.dw_1)
destroy(this.gb_1)
destroy(this.cb_gerar)
end on

event ue_postopen;call super::ue_postopen;ivo_filial        			= Create uo_filial
ivo_Fornecedor    		= Create uo_fornecedor
ivo_classificacao 		= Create uo_classificacao_produto
io_filiais					= Create uo_ge216_filiais

dw_1.Event ue_AddRow()
dw_1.Object.Dt_Inicio [1] = Date("01/" + String(Today(), "mm/yyyy"))
dw_1.SetFocus()

gf_ge003_lista_divisao_fornecedor(dw_1, "", 1)

wf_insere_lei_generico_padrao()

ivdt_Parametro = Date(gvo_Parametro.of_Dh_Movimentacao())

If gvb_Auto Then
	cb_Gerar.Event Clicked()
End If
end event

event close;call super::close;destroy(ivo_filial)
destroy(ivo_fornecedor)
Destroy(ivo_classificacao)
destroy(io_filiais)
end event

event open;call super::open;pb_help.Visible = True

//gvb_Auto = True


end event

event ue_preopen;call super::ue_preopen;This.ivb_Permite_Fechar = False
end event

type pb_help from dc_w_response`pb_help within w_ge178_planilha_analise_geral
integer x = 23
integer y = 992
end type

event pb_help::clicked;call super::clicked;wf_Help("Gera$$HEX2$$e700e300$$ENDHEX$$o de Planilha para An$$HEX1$$e100$$ENDHEX$$lise Geral (GE178)")
end event

type cb_sair from commandbutton within w_ge178_planilha_analise_geral
integer x = 1696
integer y = 1008
integer width = 379
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Sai&r"
boolean cancel = true
end type

event clicked;Close(Parent)
end event

type dw_1 from dc_uo_dw_base within w_ge178_planilha_analise_geral
integer x = 41
integer y = 52
integer width = 2007
integer height = 904
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge178_selecao"
end type

event ue_key;String lvs_Coluna

IF Key = KeyEnter! Then
	
	lvs_Coluna = This.GetColumnName()
		
	Choose Case lvs_Coluna 
		Case "de_filial" ; WF_Localiza_Filial()
	
		Case "nm_fornecedor"
			wf_Localiza_Fornecedor()
			
		Case "de_grupo"
			
			If ivo_Classificacao.wf_Localiza_Grupo(This.GetText()) Then
				
				wf_Limpa_Campos("de_grupo")
				wf_Atualiza_Campos("de_grupo")
				
			End If
			
		Case "de_subgrupo"
			
			If ivo_Classificacao.wf_Localiza_SubGrupo(This.GetText()) Then
				
				wf_Limpa_Campos("de_subgrupo")
				wf_Atualiza_Campos("de_subgrupo")

			End If
			
		Case "de_categoria"
			
			If ivo_Classificacao.of_Localiza_Categoria(This.GetText()) Then
				
				wf_Limpa_Campos("de_categoria")
				wf_Atualiza_Campos("de_categoria")

			End If
			
		Case "de_subcategoria"
			
			If ivo_Classificacao.of_Localiza_SubCategoria(This.GetText()) Then
				
				wf_Atualiza_Campos("de_subcategoria")
				
			End If

	End Choose
End If
end event

event itemchanged;call super::itemchanged;Long ll_Lojas
Long ll_Nulo[]

Choose Case dwo.Name
	
	Case "de_filial"
		
		If Data = 'C' Then
		
			is_filiais = is_nulo			
			io_Filiais.cd_filial[] = ll_Nulo[]
			
			OpenWithParm(w_ge216_selecao_filiais, io_Filiais)
			
			ll_Lojas = Message.DoubleParm
			
			If ll_Lojas > 0 Then 
				is_filiais = io_Filiais.ivs_filiais				
			Else
				This.Object.de_filial[1] = 'T'
				Return 1
			End If
		
		End If
		

	Case "de_grupo"
		If Trim(Data) <> "" Then
			If Data <> ivo_Classificacao.De_Grupo Then
				Return 1
			End If	
		Else			
			wf_Limpa_Campos("de_grupo")
			
			SetNull(ivo_Classificacao.Cd_Grupo)
			ivo_Classificacao.De_Grupo = ""

			This.Object.Cd_Grupo[1] = ivo_Classificacao.Cd_Grupo
			This.Object.De_Grupo[1] = ivo_Classificacao.De_Grupo	
		End If

	Case "de_subgrupo"
		
		If Trim(Data) <> "" Then
			If Data <> ivo_Classificacao.De_SubGrupo Then
				Return 1
			End If	
		Else			
			wf_Limpa_Campos("de_subgrupo")
			
			SetNull(ivo_Classificacao.Cd_SubGrupo)
			ivo_Classificacao.De_SubGrupo = ""

			This.Object.Cd_SubGrupo[1] = ivo_Classificacao.Cd_SubGrupo
			This.Object.De_SubGrupo[1] = ivo_Classificacao.De_SubGrupo
		End If
		
	Case "de_categoria"
		
		If Trim(Data) <> "" Then
			If Data <> ivo_Classificacao.De_Categoria Then
				Return 1
			End If	
		Else			
			wf_Limpa_Campos("de_categoria")
			
			SetNull(ivo_Classificacao.Cd_Categoria)
			ivo_Classificacao.De_Categoria = ""

			This.Object.Cd_Categoria[1] = ivo_Classificacao.Cd_Categoria
			This.Object.De_Categoria[1] = ivo_Classificacao.De_Categoria
		End If
		
	Case "de_subcategoria"
		
		If Trim(Data) <> "" Then
			If Data <> ivo_Classificacao.De_SubCategoria Then
				Return 1
			End If	
		Else			
			
			SetNull(ivo_Classificacao.Cd_SubCategoria)
			ivo_Classificacao.De_SubCategoria = ""

			This.Object.Cd_SubCategoria[1] = ivo_Classificacao.Cd_SubCategoria
			This.Object.De_SubCategoria[1] = ivo_Classificacao.De_SubCategoria
		End If
		
	Case "nm_fornecedor"
		
		If Trim(Data) <> "" Then
			If Data <> ivo_fornecedor.nm_razao_social Then
				Return 1
			End If	
		Else
			
			ivo_fornecedor.of_Inicializa()			
			
			This.Object.cd_fornecedor[1] 	= ivo_fornecedor.cd_fornecedor
			This.Object.nm_fornecedor[1] 	= ivo_fornecedor.nm_razao_social
		End If
		
		gf_ge003_lista_divisao_fornecedor(dw_1, ivo_Fornecedor.Cd_Fornecedor, 1)
		
End Choose
end event

event constructor;call super::constructor;This.of_SetColSelection(True)
end event

event editchanged;call super::editchanged;Choose Case dwo.Name
	Case "nm_fornecedor"
			
		If Trim(Data) <> "" Then
			If Data <> ivo_fornecedor.nm_razao_social Then
				Return 1
			End If	
		Else
			
			ivo_fornecedor.of_Inicializa()			
			
			This.Object.cd_fornecedor[1] 	= ivo_fornecedor.cd_fornecedor
			This.Object.nm_fornecedor[1] 	= ivo_fornecedor.nm_razao_social
		End If
			
		gf_ge003_lista_divisao_fornecedor(dw_1, ivo_Fornecedor.Cd_Fornecedor, 1)
End Choose
end event

type gb_1 from groupbox within w_ge178_planilha_analise_geral
integer x = 18
integer width = 2057
integer height = 980
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 79741120
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
borderstyle borderstyle = styleraised!
end type

type cb_gerar from commandbutton within w_ge178_planilha_analise_geral
integer x = 1207
integer y = 1008
integer width = 466
integer height = 92
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Gerar Planilha"
end type

event clicked;If gvb_Auto Then
	wf_gera_analise_exportacao()
Else
	wf_gera_analise()
End If
end event

