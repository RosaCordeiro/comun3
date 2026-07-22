HA$PBExportHeader$w_ge108_consulta_preco_paf.srw
forward
global type w_ge108_consulta_preco_paf from dc_w_sheet
end type
type st_12 from statictext within w_ge108_consulta_preco_paf
end type
type tab_1 from tab within w_ge108_consulta_preco_paf
end type
type tabpage_1 from userobject within tab_1
end type
type gb_2 from groupbox within tabpage_1
end type
type gb_7 from groupbox within tabpage_1
end type
type gb_4 from groupbox within tabpage_1
end type
type dw_5 from dc_uo_dw_base within tabpage_1
end type
type dw_7 from dc_uo_dw_base within tabpage_1
end type
type dw_8 from dc_uo_dw_base within tabpage_1
end type
type dw_2 from dc_uo_dw_base within tabpage_1
end type
type dw_1 from dc_uo_dw_base within tabpage_1
end type
type gb_1 from groupbox within tabpage_1
end type
type tabpage_1 from userobject within tab_1
gb_2 gb_2
gb_7 gb_7
gb_4 gb_4
dw_5 dw_5
dw_7 dw_7
dw_8 dw_8
dw_2 dw_2
dw_1 dw_1
gb_1 gb_1
end type
type tabpage_2 from userobject within tab_1
end type
type gb_5 from groupbox within tabpage_2
end type
type gb_6 from groupbox within tabpage_2
end type
type dw_3 from dc_uo_dw_base within tabpage_2
end type
type dw_4 from dc_uo_dw_base within tabpage_2
end type
type tabpage_2 from userobject within tab_1
gb_5 gb_5
gb_6 gb_6
dw_3 dw_3
dw_4 dw_4
end type
type tab_1 from tab within w_ge108_consulta_preco_paf
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
end forward

global type w_ge108_consulta_preco_paf from dc_w_sheet
integer x = 215
integer y = 220
integer width = 3602
integer height = 1800
string title = "GE108 - Consulta de Pre$$HEX1$$e700$$ENDHEX$$os"
boolean resizable = false
long backcolor = 80269524
event ud_addrow ( )
st_12 st_12
tab_1 tab_1
end type
global w_ge108_consulta_preco_paf w_ge108_consulta_preco_paf

type variables
uo_produto				ivo_produto
uo_vendedor			ivo_vendedor
uo_parametro_filial	ivo_parametro
uo_cliente				ivo_cliente

Decimal idc_Pontos_Cliente

DateTime ivdh_Data_Movimentacao
DateTime idh_Atualizacao_Fase_Cliente
DateTime idh_Solicitou_Atualizacao_Cliente

String	ivs_controla_psico
String	ivs_Captura_Controle_Venda
String	is_Rede_Filial
String is_Fase_Atualizacao_Cliente
String	is_Cliente_Possui_Campanha

boolean	ivb_pedido_pendente,&
			ivb_lancamento_psico_pendente,&
			ivb_pedido_ecommerce_pendente

Boolean ib_Produto_Vencido = False

Integer	ivi_dias_pedido_pendente
Integer	ivi_pedidos_ecommerce_pendente

long ivl_produto_busca_facil

String is_cliente

dc_uo_dw_base dw_1
dc_uo_dw_base dw_2
dc_uo_dw_base dw_5
end variables

forward prototypes
public function boolean wf_localiza_produto ()
public subroutine wf_localiza_vendedor ()
public function long wf_saldo_produto (long pl_produto)
public function string wf_verifica_local_estocagem (long pl_produto)
public function string wf_verifica_situacao (long pl_produto)
public function boolean wf_comissao_extra (ref integer ai_contador, long al_linha)
public subroutine wf_verifica_confirmacao_pedido_pendente ()
public function boolean wf_verifica_lancamento_psico_pendente ()
public subroutine wf_inclui_produto ()
public subroutine wf_muda_figura ()
public subroutine wf_verifica_pedido_ecommerce_pendente ()
public subroutine wf_verifica_vidalink (long pl_produto, long pl_linha)
public function decimal wf_promocao_sos_farm_popular ()
public subroutine wf_verifica_pbm (long pl_produto, long pl_linha)
public subroutine wf_localiza_cliente ()
public subroutine wf_conclui_venda ()
public subroutine wf_cadastra_cliente ()
public subroutine wf_inicia_atendimento ()
public subroutine wf_atualiza_cliente (string ps_fase)
public subroutine wf_atualiza_cliente ()
public subroutine wf_localiza_dependente ()
public function boolean wf_verifica_fase_atualizacao (ref string ps_fase)
public function boolean wf_imprimir_orcamento (boolean pb_imeditato)
public subroutine wf_inicia_agendador_tarefas ()
public function boolean wf_registra_produto_sem_saldo (integer pl_linha)
public function boolean wf_verifica_se_possui_cartao (string ps_cliente)
public function boolean wf_localiza_dados_distribuido ()
public function boolean wf_imprime_orcamento_judicial (boolean pb_imeditato)
public function decimal wf_localiza_desconto_produto ()
public function boolean wf_existe_produto_orcamento (decimal pdc_desconto_produto)
public function integer wf_localiza_produto_prestes ()
end prototypes

event ud_addrow();Tab_1.TabPage_1.dw_2.Event ue_AddRow()

ivm_Menu.mf_Confirmar(False)
ivm_Menu.mf_Cancelar(False)
end event

public function boolean wf_localiza_produto ();Integer lvi_Contador

Long	lvl_Linha, &
		lvl_Saldo, &
		lvl_Filial, &
		lvl_Saldo_Pendente

String	lvs_Produto, &
		lvs_Situacao, &
		lvs_Local, &
		lvs_Indicador_Comissao

Decimal lvdc_Desconto_SOS
Decimal ldc_Desconto_Produto

Tab_1.TabPage_1.dw_2.AcceptText()

If IsNull(ivl_Produto_Busca_Facil) Then
	lvs_Produto = Tab_1.TabPage_1.dw_2.GetText()
Else
	// Se o produto for selecionado atrav$$HEX1$$e900$$ENDHEX$$s do F6 manda direto o c$$HEX1$$f300$$ENDHEX$$digo do produto 
	lvs_Produto = String(ivl_Produto_Busca_Facil)
End If

SetNull(ivl_Produto_Busca_Facil)

ivo_Produto.of_Localiza_Produto(lvs_Produto)

If ivo_Produto.Localizado Then
	
	If This.wf_Localiza_Produto_Prestes( ) < 1 Then Return True
	
	lvl_Filial = gvo_Parametro.of_Filial()
	
	ldc_Desconto_Produto = This.wf_Localiza_Desconto_Produto( )
	
	If This.ib_Produto_Vencido Then Return False
	
	If wf_Existe_Produto_Orcamento( ldc_Desconto_Produto ) Then
		Tab_1.TabPage_1.dw_2.Object.De_Produto[Tab_1.TabPage_1.dw_2.GetRow()] = ""
		Tab_1.TabPage_1.dw_2.SetColumn("de_produto")
		Return False
	End If		

	lvl_Saldo   		 = wf_Saldo_Produto(ivo_Produto.Cd_Produto)	
	lvs_Situacao		 = wf_Verifica_Situacao(ivo_Produto.Cd_Produto)	
	lvs_Local   		 = wf_Verifica_Local_Estocagem(ivo_Produto.Cd_Produto)
	
	lvl_linha = tab_1.tabpage_1.dw_2.GetRow()
	
	wf_Verifica_Vidalink(ivo_Produto.Cd_Produto, lvl_linha)
	wf_Verifica_Pbm(ivo_Produto.Cd_Produto, lvl_linha)
	
	lvdc_Desconto_SOS = ivo_Produto.of_Desconto_SOS()
	
	If lvdc_Desconto_SOS < 0 Then lvdc_Desconto_SOS = 0
			
	tab_1.tabpage_1.dw_2.SetReDraw(False)
	tab_1.tabpage_1.dw_2.Object.cd_produto [lvl_linha] = ivo_produto.cd_produto
	
	// Verifica se o produto tem comiss$$HEX1$$e300$$ENDHEX$$o extra
	If Not wf_Comissao_Extra(Ref lvi_Contador, lvl_Linha) Then Return False
	
	tab_1.tabpage_1.dw_2.Object.de_produto 					[lvl_linha] = ivo_produto.ivs_descricao_apresentacao_venda
	tab_1.tabpage_1.dw_2.Object.qt_orcada	   					[lvl_linha] = 1
	tab_1.tabpage_1.dw_2.Object.qt_estoque	   				[lvl_linha] = lvl_Saldo
	tab_1.tabpage_1.dw_2.Object.id_situacao					[lvl_linha] = lvs_Situacao
	tab_1.tabpage_1.dw_2.Object.local      						[lvl_linha] = "Local: " + lvs_Local
	tab_1.tabpage_1.dw_2.Object.vl_preco_unitario			[lvl_linha] = ivo_Produto.of_Preco_Venda_Filial()
	tab_1.tabpage_1.dw_2.Object.pc_desconto_fixo			[lvl_linha] = ldc_Desconto_Produto
	tab_1.tabpage_1.dw_2.Object.pc_desconto_negociavel	[lvl_linha] = ivo_Produto.of_Desconto_Negociavel()
	tab_1.tabpage_1.dw_2.Object.Pc_Desconto_SOS  		[lvl_linha] = lvdc_Desconto_SOS
	tab_1.tabpage_1.dw_2.Object.Pc_Desconto_Clube			[lvl_linha] = ivo_Produto.of_Desconto_Clube()
	tab_1.tabpage_1.dw_2.Object.id_gratis_farm_popular	[lvl_linha] = ivo_Produto.id_gratis_farm_popular
	tab_1.tabpage_1.dw_2.Object.id_farmacia_popular		[lvl_linha] = ivo_Produto.id_farmacia_popular
	tab_1.tabpage_1.dw_2.Object.id_promover_venda		[lvl_linha] = ivo_Produto.id_promover_venda
	tab_1.tabpage_1.dw_2.Object.id_lei_generico				[lvl_linha] = ivo_Produto.id_lei_generico
	tab_1.tabpage_1.dw_2.Object.nr_etiqueta_prestes		[lvl_linha] = ivo_Produto.nr_etiqueta_preste
		
	tab_1.tabpage_1.dw_2.Object.Pc_Desconto_SOS_Farm_Popular[lvl_linha] = wf_Promocao_SOS_Farm_Popular()
	
	wf_Registra_Produto_Sem_Saldo(lvl_Linha)
	
	tab_1.tabpage_1.dw_2.SetReDraw(True)
	
//	tab_1.tabpage_1.dw_2.SetColumn("qt_orcada")
//	
//	tab_1.tabpage_1.dw_2.Event RowFocusChanged(lvl_linha)
	
	String lvs_Verificacao_Datas

	If Not gf_Data_Pdv_Correta( ref lvs_Verificacao_Datas ) Then
		If Long( String( now(), "hh" ) ) > 2 Then
			 MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", lvs_Verificacao_Datas )
		End If
	End If
	
	SqlCa.of_End_Transaction( ) // Finaliza a transa$$HEX2$$e700e300$$ENDHEX$$o
	
	If ivs_Controla_Psico = "S" Then
		If ivb_Lancamento_Psico_Pendente Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Escritura$$HEX2$$e700e300$$ENDHEX$$o de psicotr$$HEX1$$f300$$ENDHEX$$picos pendentes. Favor verificar.",Exclamation!)
		End If
		
		If ivb_Pedido_Pendente Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existem pedidos n$$HEX1$$e300$$ENDHEX$$o confirmados a mais de '" + String(ivi_dias_Pedido_Pendente) + "' dias.", Exclamation!)
		End If
	End If
	
	If ivb_Pedido_Ecommerce_Pendente Then
		If ivi_Pedidos_Ecommerce_Pendente > 1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existem '" + String(ivi_Pedidos_Ecommerce_Pendente) + "' pedidos do ECOMMERCE que ainda n$$HEX1$$e300$$ENDHEX$$o foram faturados.", Exclamation!)
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existe '" + String(ivi_Pedidos_Ecommerce_Pendente) + "' pedido do ECOMMERCE que ainda n$$HEX1$$e300$$ENDHEX$$o foi faturado.", Exclamation!)
		End If
	End If

	If IsNull( ivo_Produto.Nr_Etiqueta_Preste ) Then
		tab_1.tabpage_1.dw_2.SetColumn("qt_orcada")	
		tab_1.tabpage_1.dw_2.Event RowFocusChanged(lvl_linha)
	Else
		lvl_Linha = dw_2.Event ue_AddRow()
		dw_2.Event ue_Pos( dw_2.RowCount(), 'de_produto' )
	End If
	
	Return True
	
Else
	tab_1.tabpage_1.dw_2.SetColumn("de_produto")
	Return False
End If

end function

public subroutine wf_localiza_vendedor ();String lvs_Vendedor

Tab_1.TabPage_1.dw_1.AcceptText()

lvs_Vendedor = Tab_1.TabPage_1.dw_1.GetText()

ivo_Vendedor.of_localiza_vendedor(lvs_Vendedor)

If ivo_Vendedor.Localizado Then
	
	Tab_1.TabPage_1.dw_1.Object.nm_vendedor				[1] = ivo_Vendedor.nm_usuario
	Tab_1.TabPage_1.dw_1.Object.nr_matricula_vendedor	[1] = ivo_Vendedor.nr_matricula_vendedor
	
End If
end subroutine

public function long wf_saldo_produto (long pl_produto);Long lvl_Saldo

Select qt_saldo_final Into :lvl_Saldo
from vw_saldo_atual_produto
where cd_produto = :pl_produto;

Choose Case SqlCa.SqlCode
	Case 0
		Return lvl_Saldo
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Saldo do produto " + String(pl_Produto) + " n$$HEX1$$e300$$ENDHEX$$o localizado.", Information!)
		Return 0
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do saldo do produto " + String(pl_Produto) + "." + SqlCa.SqlErrText, Information!)		
		Return 0		
End Choose
end function

public function string wf_verifica_local_estocagem (long pl_produto);String lvs_Local

Select local_estocagem.de_local_estocagem
Into :lvs_Local
From produto_loja,
     local_estocagem
where produto_loja.cd_local_estocagem = local_estocagem.cd_local_estocagem
  and produto_loja.cd_produto         = :pl_produto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Produto")		
	Case 100
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto n$$HEX1$$e300$$ENDHEX$$o foi localizado na tabela de produto da loja.")
End Choose

Return lvs_Local
end function

public function string wf_verifica_situacao (long pl_produto);String lvs_Situacao

Select id_situacao
Into :lvs_Situacao
From produto_loja
where cd_produto = :pl_produto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Produto")	
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto n$$HEX1$$e300$$ENDHEX$$o foi localizado na tabela de produto da loja.")
End Choose

Return lvs_Situacao
end function

public function boolean wf_comissao_extra (ref integer ai_contador, long al_linha);Boolean lvb_Sucesso = True

Integer lvi_Contador

Long lvl_Produto

String lvs_Indicador_Comissao
		
SetPointer(HourGlass!)

lvl_Produto = ivo_Produto.cd_produto

Select count(*) 
Into :lvi_Contador
From tipo_comissao_produto
Where cd_produto       =:lvl_Produto 
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da comiss$$HEX1$$e300$$ENDHEX$$o extra do produto '" + String(lvl_Produto) + "'.")
	lvb_Sucesso = False
Else
	If lvi_Contador > 0 Then
		lvs_Indicador_Comissao = "*"
	Else
		lvs_Indicador_Comissao = ""
	End If
	
	Tab_1.Tabpage_1.dw_2.Object.id_comissionado[al_Linha] = lvs_Indicador_Comissao
End If
	
SetPointer(Arrow!)

Return lvb_Sucesso
end function

public subroutine wf_verifica_confirmacao_pedido_pendente ();Date lvdt_Movimentacao,&
	 lvdh_Emissao
	 
Integer lvi_Dias

String lvs_Dia_Semana 

lvdt_Movimentacao = Date(gvo_Parametro.of_DH_Movimentacao())

lvs_Dia_Semana = Upper(DayName(lvdt_Movimentacao))

If Not ivo_Parametro.of_Localiza_Parametro("NR_DIAS_CONFIRMACAO_PEDIDO", Ref ivi_Dias_Pedido_Pendente) Then Return

If ivi_Dias_Pedido_Pendente <= 0 Then Return

// Se for ter$$HEX1$$e700$$ENDHEX$$a-feira n$$HEX1$$e300$$ENDHEX$$o considera o estoque central, pois o pedido de s$$HEX1$$e100$$ENDHEX$$bado vai ser entregue s$$HEX1$$f300$$ENDHEX$$ na ter$$HEX1$$e700$$ENDHEX$$a-feira
If  lvs_Dia_Semana = "TUESDAY" Then
	Select Min(Date(dh_emissao))
	Into :lvdh_Emissao
	From pedido_distribuidora
	Where id_situacao = 'F'
	  and cd_distribuidora not in (Select cd_distribuidora_estoque 
	  							   From parametro
								   Where id_parametro = '1')	 
	Using SqlCa;
Else
	Select Min(Date(dh_emissao))
	Into :lvdh_Emissao
	From pedido_distribuidora
	Where id_situacao = 'F'
	Using SqlCa;
End If

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o dos pedidos n$$HEX1$$e300$$ENDHEX$$o conferidos.")
Else
	lvi_Dias = DaysAfter(lvdh_Emissao, lvdt_Movimentacao)
	
	If lvi_Dias >= ivi_dias_Pedido_Pendente Then
		ivb_Pedido_Pendente = True
	Else
		ivb_Pedido_Pendente = False
	End If
End If




end subroutine

public function boolean wf_verifica_lancamento_psico_pendente ();Long     ll_movimento

String   ls_filial

select vl_parametro Into :ls_filial
  from parametro_loja
 where cd_parametro = 'ID_REDE_FILIAL'
 Using Sqlca;
 
If Sqlca.Sqlcode = -1 Then
   Sqlca.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o Rede Filial")
	Return False
End If

//Filial Manipula$$HEX2$$e700e300$$ENDHEX$$o
If ls_filial <> "MP" Then

	Select count(*) Into :ll_movimento
	 From controle_psico c,
			parametro p
	Where c.dh_movimentacao < p.dh_movimentacao
	  and c.dh_movimentacao >= '2008/01/01'
	  and c.dh_conferencia is null
	Using Sqlca;
	
	If Sqlca.Sqlcode = -1 Then
		Sqlca.of_MsgDbError("lan$$HEX1$$e700$$ENDHEX$$amentos de psicotr$$HEX1$$f300$$ENDHEX$$picos pendentes.")
		Return False
	End If	
	
	If IsNull(ll_movimento) Then ll_movimento = 0
	
	If ll_movimento >= 4 Then
		ivb_Lancamento_Psico_pendente = True
	Else
		ivb_Lancamento_Psico_Pendente = False
	End If	
	
End If	

Return True
end function

public subroutine wf_inclui_produto ();Long lvl_Linha

Tab_1.TabPage_1.dw_2.SetFocus()

If Not IsNull(Tab_1.TabPage_1.dw_2.Object.cd_produto[Tab_1.TabPage_1.dw_2.RowCount()]) Then
	lvl_Linha = Tab_1.TabPage_1.dw_2.InsertRow(0)
Else
	lvl_Linha = Tab_1.TabPage_1.dw_2.RowCount()
End If

If lvl_Linha > 0 Then
	Tab_1.TabPage_1.dw_2.SetRow(lvl_Linha)
	
	wf_Localiza_Produto()
End If
end subroutine

public subroutine wf_muda_figura ();String lvs_Rede

If Not ivo_Parametro.of_Localiza_Parametro("ID_REDE_FILIAL", Ref lvs_Rede) Then Return

Tab_1.Tabpage_1.dw_5.Object.logo_dc.Visible     = 0
Tab_1.Tabpage_1.dw_5.Object.logo_alomed.Visible = 0
Tab_1.Tabpage_1.dw_5.Object.logo_pp.Visible 	= 0

Choose Case lvs_Rede
	Case 'AL' ; Tab_1.Tabpage_1.dw_5.Object.logo_alomed.Visible = 1
	Case 'DC' ; Tab_1.Tabpage_1.dw_5.Object.logo_dc.Visible     = 1
	Case 'PP' ; Tab_1.Tabpage_1.dw_5.Object.logo_pp.Visible 	= 1
	Case 'DP' ; Tab_1.Tabpage_1.dw_5.Object.logo_pp.Visible 	= 1
End Choose 



end subroutine

public subroutine wf_verifica_pedido_ecommerce_pendente ();String lvs_Alerta

ivb_Pedido_Ecommerce_Pendente = False 

// Este par$$HEX1$$e200$$ENDHEX$$metro $$HEX1$$e900$$ENDHEX$$ utilizado somente nas lojas que possuem o disque entrega 
// para alertar quando existir algum pedido do ecommerce que ainda n$$HEX1$$e300$$ENDHEX$$o foi faturado.
If ivo_Parametro.of_Localiza_Parametro("ID_ALERTA_PEDIDO_ECOMMERCE", Ref lvs_Alerta) Then 
	If lvs_Alerta = 'S' Then
		
		Select count(nr_pedido_ecommerce)
		Into :ivi_Pedidos_Ecommerce_Pendente
		From pedido_drogaexpress
		Where id_situacao = 'A'
		  and nr_pedido_ecommerce is not null
	    Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o dos pedidos do eCommerce pendentes")
		Else
			If ivi_Pedidos_Ecommerce_Pendente > 0 Then
				ivb_Pedido_Ecommerce_Pendente = True
			End If
		End If
	End If
End If




end subroutine

public subroutine wf_verifica_vidalink (long pl_produto, long pl_linha);//Mostra s$$HEX1$$ed00$$ENDHEX$$mbolo do programa farm$$HEX1$$e100$$ENDHEX$$cia popular em cima do campo descri$$HEX2$$e700e300$$ENDHEX$$o do produto.

String ls_Parametro

If ivo_Produto.Id_Farmacia_Popular = 'S' Then
	
	Tab_1.Tabpage_1.dw_2.Object.Id_Vidalink[pl_Linha] = 'S'
	
End If
end subroutine

public function decimal wf_promocao_sos_farm_popular ();Decimal lvdc_Desconto,&
		lvdc_Nulo

Long lvl_Promocao_SOS

String lvs_Parametro

SetNull(lvdc_Nulo)

lvdc_Desconto = lvdc_Nulo

Select vl_parametro
Into :lvs_Parametro
From parametro_loja
Where cd_parametro = 'CD_PROMOCAO_SOS_FARMACIA_POPULAR'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
				
		If IsNumber(lvs_Parametro) Then
			
			lvl_Promocao_SOS = Long(lvs_Parametro)
			
			Select pc_desconto
			Into :lvdc_Desconto
			From promocao_sos_produto
			Where cd_promocao_sos	= :lvl_Promocao_SOS
			  and cd_produto		= :ivo_Produto.cd_produto
			Using SqlCa;
			
			Choose Case SqlCa.SqlCode
				Case 0
					If IsNull(lvdc_Desconto) or lvdc_Desconto <= 0 Then
						lvdc_Desconto = 0.00
					End If					
				Case 100
					lvdc_Desconto = 0.00
				Case -1
					SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do desconto da promo$$HEX2$$e700e300$$ENDHEX$$o sos '" + String(lvl_Promocao_SOS) + "'")
			End Choose
			
		End If
		
	Case 100
	Case -1
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e300$$ENDHEX$$metro loja 'CD_PROMOCAO_SOS_FARMACIA_POPULAR'")
End Choose

Return lvdc_Desconto
end function

public subroutine wf_verifica_pbm (long pl_produto, long pl_linha);//Mostra s$$HEX1$$ed00$$ENDHEX$$mbolo de PBM em cima do campo descri$$HEX2$$e700e300$$ENDHEX$$o do produto.

Long lvl_Count

Select Count(pp.cd_pbm)
  Into :lvl_Count
  From pbm p, pbm_produto pp
 Where pp.cd_produto = :pl_produto
   and pp.cd_pbm		= p.cd_pbm
 Using SqlCa;
 
If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o dos PBMs do produto '" + String(pl_Produto) + "'.")
	Return
End If

If lvl_Count > 0 Then
	Tab_1.Tabpage_1.dw_2.Object.Id_PBM[pl_Linha] = 'S'
End If
	
end subroutine

public subroutine wf_localiza_cliente ();Boolean lb_Cpf_Valido

Long ll_Produto_Campanha
Long ll_Campanha
Long ll_Saldo
Long ll_Linha

String lvs_Localizacao
String lvs_Fase_Atualizacao
String ls_Produto_Campanha
String ls_Cpf

dw_1.AcceptText()

lvs_Localizacao = Trim(dw_1.Object.localizacao[1])

If LenA( lvs_Localizacao ) = 11 And IsNumber( lvs_Localizacao ) Then
	ivo_Cliente.of_Localiza_Cpf( lvs_Localizacao )
Else		
	ivo_Cliente.of_Localiza_Cliente( lvs_Localizacao )
End If

If ivo_Cliente.Localizado Then
	dw_1.Object.Nm_Cliente			[1] = ivo_Cliente.Nm_Cliente
	dw_1.Object.Cd_Cliente			[1] = ivo_Cliente.Cd_Cliente
	dw_1.Object.Id_Tipo				[1] = ivo_Cliente.Id_Tipo_Cliente
	dw_1.Object.Nr_Cpf				[1]	 = ivo_Cliente.Nr_Cpf_Cgc
	dw_1.Object.Nm_Dependente	[1] = ivo_Cliente.Nm_Dependente
	dw_1.Object.Cd_Dependente	[1] = ivo_Cliente.Cd_Dependente	
	dw_1.Object.De_Endereco		[1] = ivo_Cliente.De_Endereco + ", " + ivo_Cliente.Nr_Endereco + " - " + &
													 ivo_Cliente.De_Bairro
	dw_1.Object.localizacao			[1] = ''
	
	If ivo_Cliente.Id_Fisica_Juridica = 'F' Then
		
		dw_1.Object.Nr_Cpf_t.Text = "CPF:"
		dw_1.Object.Nr_Cpf.Width = 471
		dw_1.Object.Nr_Cpf.Editmask.Mask =  "###.###.###-##"
		
		lb_Cpf_Valido = gf_nr_cpf_valido_sem_mensagem(ivo_Cliente.Nr_Cpf_Cgc)
	
		If wf_Localiza_Dados_Distribuido() Then
		
			// Se for dependente, n$$HEX1$$e300$$ENDHEX$$o solicita atualiza$$HEX2$$e700e300$$ENDHEX$$o
			If IsNull( ivo_Cliente.Cd_Dependente ) Then
				
				If ivs_Captura_Controle_Venda = 'S' Then
			
					If ( is_Fase_Atualizacao_Cliente <> 'N' And IsNull( idh_Atualizacao_Fase_Cliente ) ) Or lb_Cpf_Valido = False Then
						If ( ( Date( idh_Solicitou_Atualizacao_Cliente ) < Date( gvo_Parametro.of_Dh_Movimentacao() ) ) &
							Or IsNull( idh_Solicitou_Atualizacao_Cliente ) ) Or lb_Cpf_Valido = False Then
							
							If Not lb_Cpf_Valido Then is_Fase_Atualizacao_Cliente = '1'
							
							If MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "O cadastro deste cliente precisa ser atualizado.~r" + &
																"Clique em Sim para atualizar agora ou clique em N$$HEX1$$e300$$ENDHEX$$o para atualizar mais tarde.", &
																Question!, YesNo! ) = 1 Then
								OpenWithParm(w_rl001_cadastro_cliente_pf_response, ivo_Cliente.Cd_Cliente + is_Fase_Atualizacao_Cliente)
								
								ls_Cpf = Message.StringParm

								If Not IsNull(ls_Cpf) Or Trim(ls_Cpf) <> "" Then
									dw_1.Object.Localizacao[1] = ls_Cpf
									wf_Localiza_Cliente()
								End If
							Else
								uo_Cliente_Central lo_Cliente_Central
								lo_Cliente_Central = Create uo_Cliente_Central
								lo_Cliente_Central.of_Atualiza_Fase_Atualizacao( ivo_Cliente.Cd_Cliente, False )
								Destroy lo_Cliente_Central
							End If
						End If
					End If
				End If			
			End If	
		End If
	Else
		dw_1.Object.Nr_Cpf_t.Text = "CNPJ:"
		dw_1.Object.Nr_Cpf.Editmask.Mask =  "##.###.###/####-##"
		dw_1.Object.Nr_Cpf.Width = 580
	End If	// If ivo_Cliente.Id_Fisica_Juridica = 'F' Then
	
	dw_2.Event ue_AddRow()
	dw_2.Event ue_Pos( dw_2.GetRow(), 'de_produto' )
End If
end subroutine

public subroutine wf_conclui_venda ();If ivs_Captura_Controle_Venda <> 'S' Then Return

Integer li_Mensagem
Integer li_Qtde_Cestas = 0

Datetime ldt_Movimentacao

If Not ivo_Cliente.Localizado Then
	li_Mensagem = MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "O cliente n$$HEX1$$e300$$ENDHEX$$o foi informado, deseja realmente concluir o atendimento?", Question!, YesNo! )
	
	If li_Mensagem = 2 Then 
		dw_1.Event ue_Pos( 1, 'localizacao' )
		Return
	End If
End If

Long ll_Controle
Long ll_Campanha
Long ll_Produto_Campanha
Long ll_Saldo
Long ll_Linha

String ls_Parametro
String ls_Cliente
String ls_Nome
String ls_Matricula
String ls_Retorno
String ls_Codigo_Dep
String ls_Produto_Campanha

String ls_Codigo_Mensagem
String ls_Titulo_Mensagem
String ls_Texto_Mensagem

If is_Cliente_Possui_Campanha = 'S' Then // Realiza a busca das campanhas somente se na localiza$$HEX2$$e700e300$$ENDHEX$$o do cliente foi identificado que o mesmo possui alguma vigente

	If ivs_Captura_Controle_Venda <> 'S' Then Return
	
	If ivo_Cliente.Localizado Then
		dc_uo_ds_base lds_Campanha
		lds_Campanha = Create dc_uo_ds_base
		
		uo_Cliente_Central lo_Cliente_Central
		lo_Cliente_Central = Create uo_Cliente_Central
		
		lds_Campanha.of_ChangeDataObject( 'ds_ge108_consulta_campanha_cliente' )
		lds_Campanha.of_AppendWhere(   "cf.cd_filial = " + String( gvo_Parametro.Cd_Filial ) )
		lds_Campanha.of_AppendWhere(   "cc.cd_cliente = '" + ivo_Cliente.Cd_Cliente + "'" )
		
		If lo_Cliente_Central.of_Verifica_Mensagem_Campanha(	 lds_Campanha ) Then
			If lds_Campanha.RowCount() > 0 Then
				
				For ll_Linha = 1 To lds_Campanha.RowCount()
					ll_Campanha 			 	= lds_Campanha.Object.Nr_Campanha	[ ll_Linha ]
					ll_Produto_Campanha		= lds_Campanha.Object.Cd_Produto		[ ll_Linha ]
					ls_Produto_Campanha	= lds_Campanha.Object.Desc_Produto	[ ll_Linha ]
					ls_Codigo_Mensagem		= lds_Campanha.Object.Cd_Mensagem	[ ll_Linha ]
					ls_Titulo_Mensagem		= lds_Campanha.Object.De_Titulo			[ ll_Linha ]
					ls_Texto_Mensagem		= lds_Campanha.Object.De_Texto			[ ll_Linha ]
					
					Select qt_saldo_final
						Into :ll_Saldo
					 From vw_saldo_atual_produto
					Where cd_produto = :ll_Produto_Campanha
					  Using SqlCa;
					  
					Choose Case SqlCa.SqlCode
						Case -1
							SqlCa.of_MsgDbError( 'Campanha Cliente' )
							
						Case 100
							
						Case 0
							If ll_Saldo > 0 Then
								
								ivo_Produto.of_Localiza_Codigo_Interno( ll_Produto_Campanha )
								
								uo_ge108_mensagem_campanha lo_Mensagem
								lo_Mensagem = Create uo_ge108_mensagem_campanha
								lo_Mensagem.io_Produto				= ivo_Produto
								lo_Mensagem.io_Cliente					= ivo_Cliente
								lo_Mensagem.is_Codigo_Mensagem	= ls_Codigo_Mensagem
								lo_Mensagem.is_Titulo_Mensagem	= ls_Titulo_Mensagem
								lo_Mensagem.is_Texto_Mensagem	= ls_Texto_Mensagem
								
								OpenWithParm( w_ge108_Mensagem_Campanha_Cliente, lo_Mensagem )
								
								Destroy lo_Mensagem
					
								lo_Cliente_Central.of_Atualiza_Mensagem_Campanha(	ivo_Cliente.Cd_Cliente			, &																				
																										ll_Campanha						, &
																										MidA( Message.StringParm, 2 ), &
																										gvo_Parametro.Cd_Filial	)
																										
								If LeftA( Message.StringParm, 1 ) = 'S' Then
									dw_2.Event ue_AddRow()
									dw_2.Object.de_produto[ dw_2.GetRow() ] = String( ll_Produto_Campanha )
									dw_2.Event ue_Key( KeyEnter!, 1 )
								End If
								
								Exit
							End If // ll_Saldo > 0					
					End Choose // SqlCa.SqlCode
				Next
				
			End If // lds_Campanha.RowCount() > 0
		End If // lo_Cliente_Central.of_Verifica_Mensagem_Campanha
		Destroy lds_Campanha
		Destroy lo_Cliente_Central
	End If
End If // is_Cliente_Possui_Campanha

ls_Cliente	= ivo_Cliente.Cd_Cliente
ls_Nome		= ivo_Cliente.Nm_Cliente

If ls_Cliente = '' Then SetNull( ls_Cliente )
If ls_Nome = '' Then setNull(ls_Nome)

Do	
	OpenWithParm( w_rl001_controle_venda, ls_Nome )
	
	ls_Retorno	=	Message.StringParm
	ls_Matricula =	Trim( Mid( ls_Retorno, 1, 6 ) )
	ll_Controle 	=	Long( Mid( ls_Retorno, 7 ) )
	
	If Not IsNull( ivo_Cliente.Cd_Dependente ) Then
		ls_Codigo_Dep	= ivo_Cliente.Cd_Dependente
		ls_Nome			= ivo_Cliente.Nm_Dependente
	Else
		SetNull( ls_Codigo_Dep )
	End If
	
	If IsNull( ll_Controle ) Then
		If li_Qtde_Cestas > 0 Then
			wf_Inicia_Atendimento()
		End If
		
		Exit
	End If
	
	If Not IsNull( ll_Controle ) Then
		ivdh_Data_Movimentacao = gvo_Parametro.of_Dh_Movimentacao()
		
		Insert Into cliente_caixa(
			nr_ficha,
			cd_cliente,
			nm_cliente,
			cd_dependente,
			nr_matricula_vendedor,
			id_situacao,
			dh_movimentacao)
		 Values( :ll_Controle,
					 :ls_Cliente,
					 :ls_Nome,
					 :ls_Codigo_Dep,
					 :ls_Matricula,
					 'A',
					 :ivdh_Data_Movimentacao )
		Using SqlCa;
			
		Choose Case SqlCa.SqlCode
			Case -1
				SqlCa.of_RollBack()
				SqlCa.of_MsgDbError()
				Exit
				
			Case Else
				SqlCa.of_Commit()
				li_Qtde_Cestas++
		End Choose
		
		li_Mensagem = MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja cadastrar mais uma cesta para o mesmo cliente?", Question!, YesNo!, 2 )
		
		If li_Mensagem = 2 Then
			wf_Inicia_Atendimento()
		End If	
	End If
	
Loop While li_Mensagem = 1
end subroutine

public subroutine wf_cadastra_cliente ();If ivs_Captura_Controle_Venda <> 'S' Then Return

dw_1.AcceptText()
gvs_Cliente_Cadastro = dw_1.Object.Localizacao[1]

ivm_Menu.mf_Abre_Janela("w_rl001_cadastro_cliente_pf", True)
end subroutine

public subroutine wf_inicia_atendimento ();If ivs_Captura_Controle_Venda <> 'S' Then Return

dw_1.Event ue_Reset()
dw_2.Event ue_Reset()
dw_1.Event ue_AddRow()
dw_2.Event ue_AddRow()

ivo_Cliente.of_Inicializa()
ivo_Vendedor.of_Inicializa()

dw_1.Event ue_Pos( 1, 'localizacao' )
end subroutine

public subroutine wf_atualiza_cliente (string ps_fase);String ls_Cpf

If ivs_Captura_Controle_Venda <> 'S' Then Return

OpenWithParm(w_rl001_cadastro_cliente_pf_response, ivo_Cliente.Cd_Cliente + ps_Fase)

ls_Cpf = Message.StringParm

If Not IsNull(ls_Cpf) Or Trim(ls_Cpf) <> "" Then
	dw_1.Object.Localizacao[1] = ls_Cpf
	wf_Localiza_Cliente()
End If
end subroutine

public subroutine wf_atualiza_cliente ();If ivs_Captura_Controle_Venda <> 'S' Then Return

String lvs_Fase_Atualizacao

If IsNull( ivo_Cliente.Cd_Cliente ) Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "$$HEX1$$c900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio localizar um cliente para poder atualizar.", Information! )	
	Return
End If

If ivo_Cliente.Id_Fisica_Juridica <> 'F' Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "A op$$HEX2$$e700e300$$ENDHEX$$o de atualiza$$HEX2$$e700e300$$ENDHEX$$o pelo atalho s$$HEX1$$f300$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ dispon$$HEX1$$ed00$$ENDHEX$$vel para clientes Pessoa F$$HEX1$$ed00$$ENDHEX$$sica.", Information! )	
	Return
End If

If ivo_Cliente.Id_Tipo_Cliente = 'CC' Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "A op$$HEX2$$e700e300$$ENDHEX$$o de atualiza$$HEX2$$e700e300$$ENDHEX$$o pelo atalho n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ dispon$$HEX1$$ed00$$ENDHEX$$vel para clientes Prazo.", Information! )	
	Return
End If

If This.wf_Verifica_Fase_Atualizacao( ref lvs_Fase_Atualizacao ) Then
	If lvs_Fase_Atualizacao = 'N' Then lvs_Fase_Atualizacao = '1'
	wf_Atualiza_Cliente( lvs_Fase_Atualizacao )
End If
end subroutine

public subroutine wf_localiza_dependente ();String lvs_Localizacao

dw_1.AcceptText()

lvs_Localizacao = dw_1.Object.Nm_Dependente[1]

ivo_Cliente.of_Localiza_Cliente( lvs_Localizacao )

If Not IsNull( ivo_Cliente.Cd_Dependente ) Then
	dw_1.Object.Nm_Dependente	[1] = ivo_Cliente.Nm_Dependente
	dw_1.Object.Cd_Dependente	[1] = ivo_Cliente.Cd_Dependente
End If
end subroutine

public function boolean wf_verifica_fase_atualizacao (ref string ps_fase);//String ls_Rede_Filial

If ivs_Captura_Controle_Venda <> 'S' Then Return False

If ivo_Cliente.Id_Tipo_Cliente = 'CC' Then Return False

//If Not gf_Rede_Filial( ref ls_Rede_Filial ) Then Return False

If IsNull( ivo_Cliente.Cd_Cliente ) Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "$$HEX1$$c900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio localizar um cliente para poder verificar as atualiza$$HEX2$$e700f500$$ENDHEX$$es.", StopSign! )
	dw_1.Event ue_Pos( 1, 'localizacao' )
	Return False
End If

uo_Cliente_Central lvo_Cliente_Central // GE077
lvo_Cliente_Central = Create uo_Cliente_Central
lvo_Cliente_Central.of_Verifica_Fase_Atualizacao( ivo_Cliente.Cd_Cliente, ref ps_Fase )
Destroy lvo_Cliente_Central

If ps_Fase <> 'N' And ps_Fase <> '1' And ps_Fase <> '2' Then
	ps_Fase = '1'
End If

Return True
end function

public function boolean wf_imprimir_orcamento (boolean pb_imeditato);dw_1 = Tab_1.TabPage_1.dw_1
dw_2 = Tab_1.TabPage_1.dw_2
dw_5 = Tab_1.TabPage_1.dw_5

dw_5.Reset()
dw_2.AcceptText()

Long  lvl_ind

If dw_2.RowCount() = 0 Then
	Return False
End If
// Se a $$HEX1$$fa00$$ENDHEX$$ltima linha for nula, exclui.
If IsNull(dw_2.Object.cd_produto [dw_2.RowCount()]) Then
	If dw_2.RowCount() = 1 Then
		Messagebox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o para impress$$HEX1$$e300$$ENDHEX$$o.", Information!)
		Return False
	End If
	dw_2.DeleteRow(dw_2.RowCount())
End If

If dw_2.RowCount() = 0 Then
	Return False
End If

For lvl_ind = 1 To dw_2.RowCount()
	dw_5.InsertRow(0)
	dw_5.Object.cd_filial				[lvl_ind] = gvo_parametro.of_filial()
	dw_5.Object.cd_produto			[lvl_ind] = dw_2.Object.cd_produto			[lvl_ind]
	dw_5.Object.de_produto			[lvl_ind] = dw_2.Object.de_produto			[lvl_ind]
	dw_5.Object.qt_orcada			[lvl_ind] = dw_2.Object.qt_orcada				[lvl_ind]
	dw_5.Object.nm_cliente			[lvl_ind] = dw_1.Object.nm_cliente	[1] + "  CPF: " + &
														  dw_1.Object.Nr_Cpf			[1]
	dw_5.Object.de_endereco		[lvl_ind] = dw_1.Object.de_endereco	[1]
Next

If dw_5.RowCount() = 0 Then Return False
	
dw_5.GroupCalc()

dw_5.of_Print(pb_Imeditato)

Return True
end function

public subroutine wf_inicia_agendador_tarefas ();DateTime ldh_Arquivo
DateTime ldh_Servidor

Long ll_Read

Integer li_File

String ls_Arquivo
String ls_Texto

If Not DirectoryExists( "C:\Sistemas\At" ) Then
	Return
End If

ls_Arquivo = 'c:\sistemas\verifica_agendador'

dc_uo_Api lo_Api
lo_Api = Create dc_uo_Api
ldh_Arquivo	= lo_Api.of_Data_Arquivo( ls_Arquivo + '.log' )
Destroy lo_Api

ldh_Servidor = gf_GetServerDate()

If DaysAfter( Date( ldh_Servidor ), Date( ldh_Arquivo ) ) = 0 Then
	If SecondsAfter( Time( ldh_Arquivo ), Time( ldh_Servidor ) ) < 300 Then
		Return
	End If
End If

li_File = FileOpen( ls_Arquivo + '.bat', LineMode!, Write!, Shared!, Replace! )
FileWrite( li_File, 'tasklist -FI "IMAGENAME eq at.exe" > ' + ls_Arquivo + '.log' )
FileClose( li_File )

gf_run( ls_Arquivo + '.bat', 2 )

li_File = FileOpen( ls_Arquivo + '.log', LineMode!, Read!, Shared! )

ll_Read = FileRead( li_File, ls_Texto )

Do While ll_Read >= 0
	If PosA( Upper( ls_Texto ), 'AT.EXE' ) > 0 Then
		FileClose( li_File )
		Return
	End If
	
	ll_Read = FileRead( li_File, ls_Texto )
Loop

Run( "c:\sistemas\vv\exe\vv.exe AT" )


end subroutine

public function boolean wf_registra_produto_sem_saldo (integer pl_linha);// N$$HEX1$$c300$$ENDHEX$$O PODE RETORNAR MENSAGEM PARA O USU$$HEX1$$c100$$ENDHEX$$RIO //

Long lvl_Consulta
Long lvl_Tipo
Long ll_Cd_Produto
Long ll_Saldo

DateTime lvdh_Movimento

dw_2.AcceptText()

lvdh_Movimento = gvo_parametro.of_dh_movimentacao()
ll_Cd_Produto 	 = dw_2.Object.Cd_Produto[pl_linha]
ll_Saldo			 = dw_2.Object.Qt_Estoque[pl_linha]

If ll_Saldo > 0 Or ivo_Produto.Id_Situacao <> 'A' Then
	Return True
End If

Select qt_consulta Into :lvl_Consulta
From produto_procurado_zerado
Where cd_filial							= :gvo_parametro.cd_filial
    and cd_produto						= :ll_Cd_Produto
    and dh_movimentacao			= :lvdh_Movimento
    and id_tipo							= 'A'
  Using Sqlca;
  
Choose Case SqlCa.SqlCode
	Case 0
		Update produto_procurado_zerado
		Set qt_consulta = qt_consulta + 1
		Where cd_filial					= :gvo_parametro.cd_filial
		    and cd_produto				= :ll_Cd_Produto
		    and dh_movimentacao	= :lvdh_Movimento
		    and id_tipo					= 'A'
			 Using Sqlca;
			 
		Case 100
			Insert 
			  Into produto_procurado_zerado (cd_filial,
														cd_produto,
														dh_movimentacao,
														id_tipo,
														qt_consulta,
														qt_recebida_outra_filial,
														qt_substituido_generico)
											
												Values (:gvo_parametro.cd_filial,
														  :ll_Cd_Produto,
														  :lvdh_Movimento,
														  'A',
														  1,
														  0,
														  0)
		 Using Sqlca;
		 
	Case -1
		SqlCa.of_RollBack()
		Return False
End Choose

SqlCa.of_Commit()
Return True
end function

public function boolean wf_verifica_se_possui_cartao (string ps_cliente);Long ll_Cartao_Clube

String ls_Rede_Filial

Choose Case is_Rede_Filial
	Case 'MP', 'DC', 'CP'
		ls_Rede_Filial = 'DC'
	Case Else
		ls_Rede_Filial = is_Rede_Filial
End Choose

Select Count(*)
Into	:ll_Cartao_Clube
From cartao_clube ca
Where ca.cd_cliente = :ps_cliente
And	ca.dh_bloqueio Is Null
And	Coalesce(id_rede_cartao, 'DC') = :ls_Rede_Filial
Using SqlCa;

If (ls_Rede_Filial <> 'DC') And (ls_Rede_Filial <> 'PP') Then
	dw_1.Object.Cartao_Clube_t.Visible = False
	Return False
End If

If ll_Cartao_Clube = 0 Then
	dw_1.Object.Cartao_Clube_t.Text = "[F11] Entregar cart$$HEX1$$e300$$ENDHEX$$o"
	dw_1.Object.Cartao_Clube_t.Visible = True	
Else
	dw_1.Object.Cartao_Clube_t.Text = "          Possui cart$$HEX1$$e300$$ENDHEX$$o " + ls_Rede_Filial
	dw_1.Object.Cartao_Clube_t.Visible = True
End If

Return True
end function

public function boolean wf_localiza_dados_distribuido ();Boolean lb_Sucesso = False

uo_Transacao_Remota lo_Conexao
lo_Conexao = Create uo_Transacao_Remota

lo_Conexao.of_BancoProducao()

lo_Conexao.of_Define_Variaveis(True)
lo_Conexao.of_ConverteVirgula(True)

dw_1.Object.Qt_Pontos[ 1 ] = 0.00

lo_Conexao.of_Executa_Rotina("0051", {String( gvo_Parametro.Cd_Filial ), "'" + ivo_Cliente.Cd_Cliente + "'"})

If lo_Conexao.of_Erro_Execucao() Or lo_Conexao.of_Erro_Conexao() Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na consulta dos dados do cliente na MATRIZ.")	
Else
	If lo_Conexao.of_Linhas() > 0 Then
		If lo_Conexao.of_Retorno( "qt_pontos",						Ref idc_Pontos_Cliente )						And &
			lo_Conexao.of_Retorno( "nr_fase_atualizacao",		Ref is_Fase_Atualizacao_Cliente )			And &
			lo_Conexao.of_Retorno( "dh_atualizacao_fase",		Ref idh_Atualizacao_Fase_Cliente )		And &		  	
			lo_Conexao.of_Retorno( "dh_solicitou_atualizacao",	Ref idh_Solicitou_Atualizacao_Cliente )	And &		  	
			lo_Conexao.of_Retorno( "existe_campanha",			Ref is_Cliente_Possui_Campanha ) Then
			
			If IsNull( idc_Pontos_Cliente ) Then idc_Pontos_Cliente = 0.00
			
			dw_1.Object.Qt_Pontos[ 1 ] = idc_Pontos_Cliente
			
			lb_Sucesso = True
		
		End If
	Else
		lb_Sucesso = True
	End If
End If

Destroy lo_Conexao

Return lb_Sucesso
end function

public function boolean wf_imprime_orcamento_judicial (boolean pb_imeditato);Long lvl_ind
Long i

Date dh_Movimento

Integer li_Dia
Integer li_Mes
Integer li_Ano

li_Dia 		= Day(Date(gvo_Parametro.dh_movimentacao)) 
li_Mes	= Month(Date(gvo_Parametro.dh_movimentacao)) 
li_Ano		= Year(Date(gvo_Parametro.dh_movimentacao)) 

Tab_1.TabPage_1.dw_5.Reset()
dw_2.AcceptText()

If dw_2.RowCount() = 0 Then
	Return False
End If
// Se a $$HEX1$$fa00$$ENDHEX$$ltima linha for nula, exclui.
If IsNull(dw_2.Object.cd_produto [dw_2.RowCount()]) Then
	If dw_2.RowCount() = 1 Then
		Messagebox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o para impress$$HEX1$$e300$$ENDHEX$$o.", Information!)
		Return False
	End If
	dw_2.DeleteRow(dw_2.RowCount())
End If

If dw_2.RowCount() = 0 Then
	Return False
End If

Choose Case gvo_Parametro.id_rede_filial
	Case 'DC'
		Tab_1.TabPage_1.dw_5.Object.imagem_t.FileName = "S:\Sistemas_PB12\Comuns\Figuras\logo_dc_rel.png"
	Case 'PP'
		Tab_1.TabPage_1.dw_5.Object.imagem_t.FileName = "S:\Sistemas_PB12\Comuns\Figuras\logo_pp_rel.png"
	Case 'FA'
		Tab_1.TabPage_1.dw_5.Object.imagem_t.FileName = "S:\Sistemas_PB12\Comuns\Figuras\logo_fa_rel.png"
	Case 'PF'
		Tab_1.TabPage_1.dw_5.Object.imagem_t.FileName = "S:\Sistemas_PB12\Comuns\Figuras\logo_proformula_rel.png"
	Case 'MP'
		Tab_1.TabPage_1.dw_5.Object.imagem_t.FileName = "S:\Sistemas_PB12\Comuns\Figuras\logo_manipulacao_rel.png"
	Case 'CP'		
		Tab_1.TabPage_1.dw_5.Object.imagem_t.FileName = "S:\Sistemas_PB12\Comuns\Figuras\Logo_dc_plus_rel.png"		
End Choose


Tab_1.TabPage_1.dw_5.Object.razao_social_t.Text	= gvo_Parametro.nm_razao_social
Tab_1.TabPage_1.dw_5.Object.endereco_t.Text		= gvo_Parametro.de_endereco + ", " + String( gvo_Parametro.nr_endereco )
Tab_1.TabPage_1.dw_5.Object.nr_telefone_t.Text	= gvo_Parametro.nr_ddd + ' ' + gvo_Parametro.nr_telefone
Tab_1.TabPage_1.dw_5.Object.data_t.Text				= gvo_Parametro.nm_cidade_filial + ", " + String( li_Dia ) + " de " + gf_mes_extenso( li_Mes ) + " de " + String( li_Ano )  
Tab_1.TabPage_1.dw_5.Object.vl_total_geral_t.Text	=  String( dw_2.GetItemDecimal(dw_2.RowCount(), "c_total"), "R$ #,##0.00")


For lvl_ind = 1 To dw_2.RowCount()
	i= Tab_1.TabPage_1.dw_5.InsertRow(0)
	Tab_1.TabPage_1.dw_5.Object.qt_orcada			[ i ] = dw_2.Object.qt_orcada				[ lvl_ind ]
	Tab_1.TabPage_1.dw_5.Object.de_produto			[ i ] = String( dw_2.Object.cd_produto 	[ lvl_ind ] ) + "-" + dw_2.Object.de_produto	[ lvl_ind ]
	Tab_1.TabPage_1.dw_5.Object.vl_unitario			[ i ] = dw_2.Object.vl_preco_final			[ lvl_ind ]
	Tab_1.TabPage_1.dw_5.Object.vl_total				[ i ] = dw_2.Object.c_total_produto		[ lvl_ind ]
Next

If Tab_1.TabPage_1.dw_5.RowCount() = 0 Then Return False
	
Tab_1.TabPage_1.dw_5.GroupCalc()

Tab_1.TabPage_1.dw_5.of_Print(pb_Imeditato)

Return True
end function

public function decimal wf_localiza_desconto_produto ();Decimal ldc_Desconto_Produto
Decimal ldc_Desconto_Produto_Prestes

ldc_Desconto_Produto			= ivo_Produto.of_Desconto_Filial( )
ldc_Desconto_Produto_Prestes	= ivo_Produto.of_Desconto_Etiqueta_Preste( )

This.ib_Produto_Vencido = False

If Not IsNull( ivo_Produto.nr_Etiqueta_Preste ) And ldc_Desconto_Produto_Prestes = 0 Then
	If gf_Primeiro_Dia_Mes( Date( gvo_Parametro.of_Dh_Movimentacao( ) ) ) > gf_Primeiro_Dia_Mes( Date( ivo_Produto.dh_Validade_Preste ) ) Then
		This.ib_Produto_Vencido = True
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produto vencido, venda n$$HEX1$$e300$$ENDHEX$$o permitida.", Exclamation! )
	End If
End If

If ldc_Desconto_Produto_Prestes > ldc_Desconto_Produto Then Return ldc_Desconto_Produto_Prestes

Return ldc_Desconto_Produto
end function

public function boolean wf_existe_produto_orcamento (decimal pdc_desconto_produto);Long ll_Find_Etiqueta_Prestes
Long lvl_find

lvl_find = tab_1.tabpage_1.dw_2.Find (	"cd_produto = "+String(ivo_produto.cd_produto) + " and pc_desconto_fixo = " + gf_Valor_Com_Ponto( pdc_desconto_produto ), &
													1,	tab_1.tabpage_1.dw_2.RowCount( ) )

If lvl_find = 0 Then Return False

If Not IsNull( ivo_Produto.Nr_Etiqueta_Preste ) Then
	ll_Find_Etiqueta_Prestes =	tab_1.tabpage_1.dw_2.Find (	"nr_etiqueta_prestes = '"+String( ivo_Produto.Nr_Etiqueta_Preste ) + "'", &
										1,	tab_1.tabpage_1.dw_2.RowCount( ) )
										
	If ll_Find_Etiqueta_Prestes > 0 Then
		MessageBox( "OPERA$$HEX2$$c700c300$$ENDHEX$$O N$$HEX1$$c300$$ENDHEX$$O PERMITIDA", "Etiqueta de produto prestes a vencer j$$HEX1$$e100$$ENDHEX$$ utilizada na consulta.~r~rO produto n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ adicionado novamente $$HEX1$$e000$$ENDHEX$$ lista.", Exclamation! )
		Return True
	End If
End If

tab_1.tabpage_1.dw_2.Object.qt_orcada [lvl_find] = tab_1.tabpage_1.dw_2.Object.qt_orcada [lvl_find] + 1

wf_Registra_Produto_Sem_Saldo(lvl_Find)

Return True
end function

public function integer wf_localiza_produto_prestes ();Decimal ldc_Desconto

Long ll_Linha

String ls_Etiquetas_Orcadas[ ]
String ls_Etiqueta

If Not IsNull( ivo_Produto.Nr_Etiqueta_Preste ) Then Return 1

ls_Etiquetas_Orcadas[ 1 ] = ''

For ll_Linha = 1 To dw_2.RowCount( )
	If Not IsNull( dw_2.Object.Nr_Etiqueta_Prestes[ ll_Linha ] ) Then
		ls_Etiquetas_Orcadas[ UpperBound( ls_Etiquetas_Orcadas ) + 1 ] = dw_2.Object.Nr_Etiqueta_Prestes[ ll_Linha ]
	End If
Next

setNull( ls_Etiqueta )

dc_uo_ds_base lds_1
lds_1 = Create dc_uo_ds_base

If Not lds_1.of_ChangeDataObject( 'ds_ge108_localiza_preste_nao_orcado' ) Then
	Destroy lds_1
	Return -1
End If

ll_Linha = lds_1.Retrieve( ivo_Produto.Cd_Produto, ls_Etiquetas_Orcadas )

If ll_Linha < 0 Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", lds_1.ivo_dbError.of_Msg_PostgreSql( ), StopSign! )
	Return -1
End If

If ll_Linha > 0 Then ls_Etiqueta = lds_1.Object.Nr_Etiqueta[ 1 ]

Destroy lds_1

If Not IsNull( ls_Etiqueta ) Then
	uo_Produto lo_Produto_Prestes
	lo_Produto_Prestes = Create uo_Produto
	lo_Produto_Prestes.of_Localiza_Produto( ls_Etiqueta )
	ldc_Desconto = lo_Produto_Prestes.of_Desconto_Etiqueta_Preste( )
	Destroy lo_Produto_Prestes
	
	If ldc_Desconto > 0 Then	
		If MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o",	"Existe " + ivo_Produto.ivs_Descricao_Apresentacao_Venda + &
											" prestes a vencer com desconto de at$$HEX1$$e900$$ENDHEX$$ " + String( ldc_Desconto ) + &
											"%.~r~r DESEJA OFERTAR O PRODUTO PRESTES AO CLIENTE?", Question!, YesNo! ) = 1 Then
			
			Tab_1.TabPage_1.dw_2.Object.De_Produto[ Tab_1.TabPage_1.dw_2.GetRow( ) ] = ls_Etiqueta
			This.wf_Localiza_Produto( )
			Return 0
		End If
	End If
		
End If

Return 1
end function

on w_ge108_consulta_preco_paf.create
int iCurrent
call super::create
this.st_12=create st_12
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_12
this.Control[iCurrent+2]=this.tab_1
end on

on w_ge108_consulta_preco_paf.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_12)
destroy(this.tab_1)
end on

event close;call super::close;If IsValid(ivo_produto)   Then Destroy(ivo_produto)
If IsValid(ivo_vendedor)  Then Destroy(ivo_vendedor)
If IsValid(ivo_Parametro) Then Destroy(ivo_Parametro)

Destroy dw_1

end event

event ue_cancel;call super::ue_cancel;This.SetReDraw(False)

Tab_1.TabPage_2.dw_4.Event ue_Cancel()
Tab_1.TabPage_1.dw_5.Event ue_Cancel()

Tab_1.TabPage_2.dw_3.Event ue_Cancel()
Tab_1.TabPage_1.dw_7.Event ue_Cancel()
Tab_1.TabPage_1.dw_8.Event ue_Cancel()
Tab_1.TabPage_1.dw_1.Event ue_Cancel()
Tab_1.TabPage_1.dw_2.Event ue_Cancel()

This.SetReDraw(True)
end event

event open;call super::open;ivo_produto   = Create uo_produto
ivo_Vendedor  = Create uo_vendedor // GE013
ivo_parametro = Create uo_parametro_filial
ivo_Cliente = Create uo_Cliente
ivo_Cliente.of_Inicializa()

dw_1 = Tab_1.TabPage_1.dw_1
dw_2 = Tab_1.TabPage_1.dw_2

ivo_Produto.ivb_nao_liberado_filial = False

Tab_1.TabPage_1.dw_1.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_1.dw_2.of_SetMenu(This.ivm_Menu)

Tab_1.TabPage_1.dw_5.Visible  = False

ivb_Lancamento_Psico_Pendente = False
ivb_pedido_pendente			  = False

SetNull(ivl_Produto_Busca_Facil)

//wf_Verifica_Lancamento_Psico_Pendente()
//wf_Verifica_Confirmacao_Pedido_Pendente()
//wf_verifica_pedido_ecommerce_pendente()
//wf_Inicia_Agendador_Tarefas()
//
//// A cada 5 minutos atualizar as variav$$HEX1$$e900$$ENDHEX$$is de inst$$HEX1$$e200$$ENDHEX$$ncia que controlam
//// os lan$$HEX1$$e700$$ENDHEX$$amentos dos psicos pendentes e a confirma$$HEX2$$e700e300$$ENDHEX$$o dos pedidos
//Timer(300)
//
end event

event ue_postopen;call super::ue_postopen;Tab_1.TabPage_1.dw_2.ivo_Controle_Menu.of_Incluir(True)
Tab_1.TabPage_1.dw_2.ivo_Controle_Menu.of_Excluir(True)

dw_1.ivo_Controle_Menu.of_Incluir(True)
//Tab_1.TabPage_1.dw_2.ivo_Controle_Menu.of_Excluir(True)

//This.ivm_Menu.ivb_Permite_Imprimir = True

Tab_1.Tabpage_1.dw_1.Event ue_Cancel()
Tab_1.Tabpage_2.dw_3.Event ue_Cancel()
Tab_1.TabPage_1.dw_7.Event ue_Cancel()
Tab_1.TabPage_1.dw_8.Event ue_AddRow()
Tab_1.Tabpage_1.dw_2.Event ue_Cancel()

tab_1.SelectedTab = 1

ivm_Menu.mf_Incluir(True)
ivm_Menu.mf_Confirmar(False)
ivm_Menu.mf_Cancelar(False)

// Par$$HEX1$$e200$$ENDHEX$$metro utilizado para fazer o controle dos produtos controlados.
// At$$HEX1$$e900$$ENDHEX$$ dezembro somente algumas lojas far$$HEX1$$e300$$ENDHEX$$o este controle
If Not ivo_Parametro.of_Localiza_Parametro("ID_CONTROLA_PSICO", Ref ivs_controla_psico) Then Return
//If Not ivo_Parametro.of_Localiza_Parametro('ID_CAPTURA_CONTROLE_VENDA', ref ivs_Captura_Controle_Venda, False ) Then
//	ivs_Captura_Controle_Venda = "N"
//End If
//
//ivdh_Data_Movimentacao = gvo_Parametro.of_Dh_Movimentacao()
//
//If ivs_Captura_Controle_Venda = 'S' Then
//
//	If gf_Rede_Filial( ref is_Rede_Filial ) Then
//		If is_Rede_Filial = 'DC' Or is_Rede_Filial = 'MP' Or is_Rede_Filial = 'CP' Then 
//			dw_1.Object.qt_pontos_t.Visible	= True
//			dw_1.Object.qt_Pontos.Visible		= True
//		End If
//	End If
//		
//	dw_1.Object.F3_t.Visible 			= True
//	dw_1.Object.INS_t.Visible			= True
//	dw_1.Object.END_t.Visible			= True
//	dw_1.Object.ESC_t.Visible			= True
//	dw_1.Event ue_Pos( 1, 'localizacao' )
//Else
//	dw_2.Event ue_Pos( 1, 'de_produto' )
//End If

dw_2.Event ue_Pos( 1, 'de_produto' )

SqlCa.of_End_Transaction( )
end event

event ue_preopen;call super::ue_preopen;//This.Tab_1.Width  = 3579
//This.Tab_1.Height = 1704
//
//This.Tab_1.X = 8
//This.Tab_1.Y = 8
//
//This.Width  = This.Tab_1.Width  +  40
//This.Height = This.Tab_1.Height + 112
end event

event ue_printimmediate;call super::ue_printimmediate;//If MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "A impress$$HEX1$$e300$$ENDHEX$$o do or$$HEX1$$e700$$ENDHEX$$amento deve ser feita somente mediante a apresenta$$HEX2$$e700e300$$ENDHEX$$o de ordem judicial.~rConfirma a impress$$HEX1$$e300$$ENDHEX$$o?", Question!, YesNo!, 2 ) = 1 Then
//	wf_imprime_orcamento_judicial(True)
//End If


end event

event timer;call super::timer;//wf_Verifica_Lancamento_Psico_Pendente()
//wf_Verifica_Confirmacao_Pedido_Pendente()
//wf_verifica_pedido_ecommerce_pendente()
//wf_Inicia_Agendador_Tarefas()

SqlCa.of_End_Transaction( ) // Fnializa a transa$$HEX2$$e700e300$$ENDHEX$$o
end event

event ue_print;call super::ue_print;//If MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "A impress$$HEX1$$e300$$ENDHEX$$o do or$$HEX1$$e700$$ENDHEX$$amento deve ser feita somente mediante a apresenta$$HEX2$$e700e300$$ENDHEX$$o de ordem judicial.~rConfirma a impress$$HEX1$$e300$$ENDHEX$$o?", Question!, YesNo!, 2 ) = 1 Then
//	wf_imprime_orcamento_judicial(False)
//End If
end event

type dw_visual from dc_w_sheet`dw_visual within w_ge108_consulta_preco_paf
end type

type gb_aux_visual from dc_w_sheet`gb_aux_visual within w_ge108_consulta_preco_paf
end type

type st_12 from statictext within w_ge108_consulta_preco_paf
integer x = 2304
integer y = 1496
integer width = 119
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16776960
long backcolor = 8388608
boolean enabled = false
string text = "F9"
alignment alignment = center!
boolean focusrectangle = false
end type

type tab_1 from tab within w_ge108_consulta_preco_paf
integer x = 14
integer y = 12
integer width = 3575
integer height = 1612
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long backcolor = 79741120
boolean raggedright = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

event selectionchanged;If newindex = 2 Then
	
	This.Width  = 1912
	This.Height = 1696
	This.X = 8
	This.Y = 8
	Parent.Width  = This.Width + 40
	Parent.Height = This.Height + 112
	
	This.Show()
	
	Tab_1.TabPage_1.dw_1.AcceptText()
	Tab_1.TabPage_1.dw_2.AcceptText()
	
	ivm_Menu.mf_Excluir(False)
	ivm_Menu.mf_Incluir(False)
	
	If Tab_1.TabPage_2.dw_3.RowCount() > 0 Then
		Tab_1.TabPage_2.dw_4.Event ue_Retrieve()
	End If
Else
	
//	This.Width  = 3579
//	This.Height = 1704
//	
//	This.X = 8
//	This.Y = 8
//	Parent.Width  = This.Width + 40
//	Parent.Height = This.Height + 112
	This.Show()
	
	If Tab_1.TabPage_1.dw_1.RowCount() > 0 Then ivm_Menu.mf_Excluir(True)
	ivm_Menu.mf_Incluir(True)

	
	Tab_1.TabPage_1.dw_2.SetFocus()
End If
end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3538
integer height = 1496
long backcolor = 79741120
string text = "Consulta"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
gb_2 gb_2
gb_7 gb_7
gb_4 gb_4
dw_5 dw_5
dw_7 dw_7
dw_8 dw_8
dw_2 dw_2
dw_1 dw_1
gb_1 gb_1
end type

on tabpage_1.create
this.gb_2=create gb_2
this.gb_7=create gb_7
this.gb_4=create gb_4
this.dw_5=create dw_5
this.dw_7=create dw_7
this.dw_8=create dw_8
this.dw_2=create dw_2
this.dw_1=create dw_1
this.gb_1=create gb_1
this.Control[]={this.gb_2,&
this.gb_7,&
this.gb_4,&
this.dw_5,&
this.dw_7,&
this.dw_8,&
this.dw_2,&
this.dw_1,&
this.gb_1}
end on

on tabpage_1.destroy
destroy(this.gb_2)
destroy(this.gb_7)
destroy(this.gb_4)
destroy(this.dw_5)
destroy(this.dw_7)
destroy(this.dw_8)
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.gb_1)
end on

type gb_2 from groupbox within tabpage_1
integer x = 23
integer y = 12
integer width = 3497
integer height = 1464
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista de Produtos"
borderstyle borderstyle = styleraised!
end type

type gb_7 from groupbox within tabpage_1
boolean visible = false
integer x = 27
integer y = 1324
integer width = 1289
integer height = 152
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Desconto Clube"
borderstyle borderstyle = styleraised!
end type

type gb_4 from groupbox within tabpage_1
boolean visible = false
integer x = 2249
integer y = 1324
integer width = 1271
integer height = 152
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 79741120
string text = "Desconto SOS"
borderstyle borderstyle = styleraised!
end type

type dw_5 from dc_uo_dw_base within tabpage_1
integer x = 2926
integer y = 76
integer height = 164
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge108_orcamento_judicial"
end type

event constructor;call super::constructor;ivi_Tipo_Cancelar = RESET

//logo_dw




end event

type dw_7 from dc_uo_dw_base within tabpage_1
boolean visible = false
integer x = 2290
integer y = 1376
integer width = 1211
integer height = 76
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge108_desconto_negociavel"
end type

event constructor;call super::constructor;ivi_Tipo_Cancelar = ADDROW
end event

type dw_8 from dc_uo_dw_base within tabpage_1
boolean visible = false
integer x = 69
integer y = 1376
integer width = 1230
integer height = 76
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge108_desconto_negociavel"
end type

type dw_2 from dc_uo_dw_base within tabpage_1
integer x = 46
integer y = 64
integer width = 3465
integer height = 1396
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge108_produtos_paf"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event constructor;call super::constructor;ivb_updateable     = False
ivb_Selecao_Linhas = True
ivi_Tipo_Cancelar  = ADDROW

String lvs_Coluna[], &
       lvs_Nome[]
		 
lvs_Coluna = {	"cd_produto", "de_produto", "qt_orcada", "vl_preco_unitario", "pc_desconto_fixo",&
					"vl_preco_final", "c_total_produto", "qt_estoque",  "id_situacao", "local"}

lvs_Nome = {	"c$$HEX1$$f300$$ENDHEX$$digo", "descri$$HEX2$$e700e300$$ENDHEX$$o", "qtde or$$HEX1$$e700$$ENDHEX$$ada", "preco unit$$HEX1$$e100$$ENDHEX$$rio", "desconto", "pre$$HEX1$$e700$$ENDHEX$$o final", &
					"total", "qtde estoque", "situa$$HEX2$$e700e300$$ENDHEX$$o", "local"}

This.of_SetSort(lvs_Coluna, lvs_Nome)
This.of_SetFilter(lvs_Coluna, lvs_Nome)

//"if(id_situacao = ~"I~", rgb(255,0,0), if(id_situacao = ~"P~", rgb(255,165,0), " + This.ivs_Cor_Linha_Padrao + "))", "", False

//This.of_SetRowSelection(	"if(id_situacao = ~"I~", rgb(255,0,0), if(id_situacao = ~"P~", rgb(0,128,0), " + This.ivs_Cor_Linha_Padrao + "))", &
//									"if(id_situacao = ~"A~", rgb(0,0,0), if(id_situacao = ~"P~", rgb(0,128,0), rgb(255, 0,0)))", &
//									True )
									
This.of_SetRowSelection( )
end event

event getfocus;call super::getfocus;ivm_Menu.mf_Classificar(True)
ivm_Menu.mf_Filtrar(True)
ivm_Menu.mf_Localizar(True)
ivm_Menu.mf_Excluir(True)
ivm_Menu.mf_Incluir(True)
ivm_Menu.mf_SalvarComo(True)
end event

event losefocus;call super::losefocus;ivm_Menu.mf_Classificar(False)
ivm_Menu.mf_Filtrar(False)
ivm_Menu.mf_Localizar(False)
ivm_Menu.mf_SalvarComo(False)
end event

event ue_addrow;call super::ue_addrow;ivm_Menu.mf_Imprimir(True)
ivm_Menu.mf_Excluir(True)
ivm_Menu.mf_Classificar(True)
ivm_Menu.mf_Filtrar(True)
ivm_Menu.mf_Localizar(True)
ivm_Menu.mf_SalvarComo(True)

Tab_1.TabPage_2.Enabled = True

Return 1
end event

event ue_deleterow;call super::ue_deleterow;If RowCount() = 0 Then
	ivm_Menu.mf_Excluir(False)
	ivm_Menu.mf_Confirmar(False)
	ivm_Menu.mf_SalvarComo(False)
	Tab_1.TabPage_2.Enabled = False	
	
	Tab_1.TabPage_1.dw_7.Event ue_Cancel()
	
	Tab_1.TabPage_1.dw_2.Event ue_Cancel()
	
End If

Return True

end event

event ue_preinsertrow;call super::ue_preinsertrow;If RowCount() > 0 Then
	If IsNull(Object.cd_produto [RowCount()]) Then Return -1
End If

Return 1

end event

event rowfocuschanged;call super::rowfocuschanged;Boolean lvb_Visible,&
		lvb_Visible_Gratis

Decimal lvdc_Nulo,&
		lvdc_Preco_Final,&
		lvdc_Desconto_Farm_Pop
		
SetNull(lvdc_Nulo)

String lvs_Nulo
SetNull(lvs_Nulo)

If CurrentRow > 0 Then
	dw_7.Object.Pc_Desconto	[1] = lvdc_Nulo
	dw_7.Object.Vl_Preco_Final	[1] = lvdc_Nulo
	dw_8.Object.Pc_Desconto	[1] = lvdc_Nulo
	dw_8.Object.Vl_Preco_Final	[1] = lvdc_Nulo
	
	If This.Object.Pc_Desconto_SOS[CurrentRow] > 0 Then
		dw_7.Object.Pc_Desconto	[1] = This.Object.Pc_Desconto_SOS	[CurrentRow]
		dw_7.Object.Vl_Preco_Final	[1] = This.Object.Vl_Preco_SOS		[CurrentRow]
	End If
	
	If This.Object.Pc_Desconto_Clube[CurrentRow] > 0 Then
		dw_8.Object.Pc_Desconto	[1] = This.Object.Pc_Desconto_Clube	[CurrentRow]
		dw_8.Object.Vl_Preco_Final	[1] = This.Object.Vl_Preco_Clube		[CurrentRow]
	End If
	
	// Tratamento Farm$$HEX1$$e100$$ENDHEX$$cia Popular do Brasil
	lvb_Visible 		= False
	lvb_Visible_Gratis 	= False
	
	This.Object.st_pmc_farm_popular.text 			= lvs_Nulo
	This.Object.st_preco_final_farm_popular.text 	= lvs_Nulo
	
	If Not IsNull(This.Object.id_vidalink[CurrentRow]) and This.Object.id_vidalink[CurrentRow] = 'S' Then
		
		If This.Object.pc_desconto_fixo[CurrentRow] > This.Object.Pc_Desconto_SOS_Farm_Popular[CurrentRow] Then
			lvdc_Desconto_Farm_Pop = This.Object.pc_desconto_fixo[CurrentRow]
		Else
			lvdc_Desconto_Farm_Pop = This.Object.Pc_Desconto_SOS_Farm_Popular[CurrentRow]
		End If
		
		//If Not IsNull(This.Object.Pc_Desconto_SOS_Farm_Popular[CurrentRow]) Then
			lvb_Visible = True
			
			lvdc_Preco_Final = Round(This.Object.vl_preco_unitario[CurrentRow] * ((100 - lvdc_Desconto_Farm_Pop) / 100), 2)
			
			This.Object.st_preco_final_farm_popular.text 	= String(lvdc_Preco_Final, "#,##0.00")
			This.Object.st_pmc_farm_popular.text 			= String(This.Object.vl_preco_unitario[CurrentRow], "#,##0.00")
		//End If
		
		If Not IsNull(This.Object.id_gratis_farm_popular[CurrentRow]) and This.Object.id_gratis_farm_popular[CurrentRow] = 'S' Then
			lvb_Visible_Gratis 	= True
		End If						
		
	End If
		
	This.Object.st_nome_pmc_farm_popular.Visible 			= lvb_Visible
	This.Object.st_nome_preco_final_farm_popular.Visible 	= lvb_Visible
	This.Object.bmp_vidalink2.Visible 						= lvb_Visible
	This.Object.st_gratis_farm_popular.Visible				= lvb_Visible_Gratis
		
End If
end event

event ue_key;Long lvl_Produto, &
     lvl_Linha,   &
	 lvl_Saldo
	 
Decimal lvdc_Desconto

Choose Case Key
	Case KeyEnter!
		Choose Case GetColumnName()
			Case "de_produto"
				wf_localiza_produto()
				lvl_Saldo = dw_2.Object.qt_estoque[dw_2.GetRow()]
				
				If lvl_Saldo <= 0 Then
//					OpenWithParm(w_ge108_registro_falta_produtos,Long(dw_2.Object.cd_produto[dw_2.GetRow()]))
				End If
				
			Case "qt_orcada"	
				Event ue_AddRow()
				SetRow(RowCount())
				ScrollToRow(RowCount())
				SetColumn("de_produto")
		End Choose
		
		SqlCa.of_End_Transaction( ) // Fnializa a transa$$HEX2$$e700e300$$ENDHEX$$o
		
End Choose
end event

event itemfocuschanged;call super::itemfocuschanged;Choose Case dwo.Name
	Case "de_produto" ; This.SelectText(1,40)
	Case "qt_orcada"  ; This.SelectText(1,5)
End Choose
end event

event itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case "de_produto"
		If Data <> ivo_Produto.ivs_Descricao_Apresentacao_Venda Then 
			Return 1
		End If
End Choose
end event

event editchanged;call super::editchanged;If Not IsNull( This.Object.nr_etiqueta_prestes[ row ] ) Then
	This.Object.Qt_Orcada[ row ] = 1
	Return -1
End If
end event

type dw_1 from dc_uo_dw_base within tabpage_1
boolean visible = false
integer x = 37
integer y = 52
integer width = 3465
integer taborder = 20
string dataobject = "dw_ge108_cliente_selecionado"
end type

event constructor;call super::constructor;ivb_updateable    = False
ivi_Tipo_Cancelar = ADDROW

SqlCa.of_End_Transaction( )

This.of_SetColSelection(True)

end event

event ue_key;call super::ue_key;String lvs_Coluna

dw_1.AcceptText()

lvs_Coluna = GetColumnName()

Choose Case key

	Case KeyTab!
		If lvs_Coluna = "localizacao" Then
			Tab_1.TabPage_1.dw_2.Event getFocus()
		End If 
		
	Case keyEnter!
		If lvs_Coluna = "nm_vendedor" Then
			wf_localiza_vendedor()
		End If
		
		SqlCa.of_End_Transaction( ) // Fnializa a transa$$HEX2$$e700e300$$ENDHEX$$o
	
		If lvs_Coluna = "localizacao" Then
			wf_localiza_cliente()
			If ivo_Cliente.Localizado Then
				wf_Verifica_se_Possui_Cartao(ivo_Cliente.Cd_Cliente)
			End If
		End If
		
		SqlCa.of_End_Transaction( ) // Fnializa a transa$$HEX2$$e700e300$$ENDHEX$$o

	Case KeyF11!
		If dw_1.Object.Cartao_Clube_t.Text = "[F11] Entregar cart$$HEX1$$e300$$ENDHEX$$o" Then
			OpenWithParm(w_rl088_entrega_cartao_clube, ivo_Cliente.Nr_Cpf_Cgc)
			wf_Verifica_se_Possui_Cartao(ivo_Cliente.Cd_Cliente)
		End If
		
		SqlCa.of_End_Transaction( ) // Fnializa a transa$$HEX2$$e700e300$$ENDHEX$$o

	Case KeyEnd!
		wf_Conclui_Venda()
		
		SqlCa.of_End_Transaction( ) // Fnializa a transa$$HEX2$$e700e300$$ENDHEX$$o
		
	Case KeyInsert!
		wf_Cadastra_Cliente()
		
		SqlCa.of_End_Transaction( ) // Fnializa a transa$$HEX2$$e700e300$$ENDHEX$$o
		
	Case KeyF3!
		wf_Atualiza_Cliente()
		
		SqlCa.of_End_Transaction( ) // Fnializa a transa$$HEX2$$e700e300$$ENDHEX$$o
		
	Case KeyEscape!
		If ivs_Captura_Controle_Venda = 'S' Then
			If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja realmente cancelar o atendimento atual?", Question!, YesNo!, 2) = 1 Then
				wf_Inicia_Atendimento()
			End If
		End If
		
		SqlCa.of_End_Transaction( ) // Fnializa a transa$$HEX2$$e700e300$$ENDHEX$$o
		
End Choose
end event

event getfocus;call super::getfocus;If gvs_Cliente_Cadastro <> '' Then
	dw_1.Object.localizacao[1] = gvs_Cliente_Cadastro
	wf_Localiza_Cliente()
	gvs_Cliente_Cadastro = ''
Else
	This.Event ue_Pos(1, "localizacao")
End If

This.ivm_Menu.mf_Excluir(False)
This.ivm_Menu.mf_Incluir(False)
end event

type gb_1 from groupbox within tabpage_1
boolean visible = false
integer x = 23
integer y = 4
integer width = 3493
integer height = 412
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Cliente"
borderstyle borderstyle = styleraised!
end type

type tabpage_2 from userobject within tab_1
boolean visible = false
integer x = 18
integer y = 100
integer width = 3538
integer height = 1496
boolean enabled = false
long backcolor = 79741120
string text = "Condi$$HEX2$$e700e300$$ENDHEX$$o de Pagamento"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
gb_5 gb_5
gb_6 gb_6
dw_3 dw_3
dw_4 dw_4
end type

on tabpage_2.create
this.gb_5=create gb_5
this.gb_6=create gb_6
this.dw_3=create dw_3
this.dw_4=create dw_4
this.Control[]={this.gb_5,&
this.gb_6,&
this.dw_3,&
this.dw_4}
end on

on tabpage_2.destroy
destroy(this.gb_5)
destroy(this.gb_6)
destroy(this.dw_3)
destroy(this.dw_4)
end on

type gb_5 from groupbox within tabpage_2
integer x = 18
integer y = 48
integer width = 1829
integer height = 192
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Condi$$HEX2$$e700e300$$ENDHEX$$o de Pagamento"
borderstyle borderstyle = styleraised!
end type

type gb_6 from groupbox within tabpage_2
integer x = 18
integer y = 240
integer width = 1829
integer height = 1308
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 8388608
long backcolor = 67108864
string text = "Parcelas"
borderstyle borderstyle = styleraised!
end type

type dw_3 from dc_uo_dw_base within tabpage_2
integer x = 37
integer y = 112
integer width = 1774
integer height = 96
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge108_condicao_pagamento"
end type

event itemchanged;call super::itemchanged;This.AcceptText()

dw_4.Event ue_Retrieve()

end event

event ue_addrow;call super::ue_addrow;String lvs_desc
Long   lvl_null

SetNull(lvl_null)
lvs_desc = "A VISTA"
// Insere um registro no DDDW com a descri$$HEX2$$e700e300$$ENDHEX$$o Nenhuma Condi$$HEX2$$e700e300$$ENDHEX$$o
DataWindowChild lvdw_child
This.GetChild ("cd_condicao", lvdw_child)

If Not IsNull (lvdw_child.GetItemNumber (1, "cd_condicao_crediario")) Then	
	lvdw_child.InsertRow(1)
	lvdw_child.SetItem(1, "cd_condicao_crediario", lvl_null)
	lvdw_child.SetItem(1, "de_condicao_crediario", lvs_desc)
	lvdw_child.SetRow(1)
	lvdw_child.ScrollToRow(1)
End If

This.Object.cd_condicao [1] = lvl_null

Return 1

end event

event constructor;call super::constructor;ivb_updateable    = False
ivi_Tipo_Cancelar = ADDROW

end event

type dw_4 from dc_uo_dw_base within tabpage_2
integer x = 37
integer y = 308
integer width = 1792
integer height = 1180
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge108_parcelas_condicao_pagamento"
end type

event constructor;call super::constructor;ivi_Tipo_Cancelar = RESET
end event

event ue_recuperar;//OverRide
If tab_1.tabpage_2.dw_3.RowCount() = 0 Then
	Return 0
Else
   If IsNull(tab_1.tabpage_2.dw_3.Object.cd_condicao [1]) Then
		This.Reset()
		Return 0
	End If
End If

Return This.Retrieve (dw_3.Object.cd_condicao [1] , &
							 String(tab_1.tabpage_1.dw_2.GetItemDecimal (tab_1.tabpage_1.dw_2.RowCount(), "c_total")), &
							 Today())

end event

