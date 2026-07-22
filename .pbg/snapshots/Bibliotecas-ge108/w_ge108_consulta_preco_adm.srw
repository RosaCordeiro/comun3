HA$PBExportHeader$w_ge108_consulta_preco_adm.srw
forward
global type w_ge108_consulta_preco_adm from dc_w_lista_relatorio
end type
type st_1 from statictext within w_ge108_consulta_preco_adm
end type
type st_2 from statictext within w_ge108_consulta_preco_adm
end type
type st_3 from statictext within w_ge108_consulta_preco_adm
end type
type st_14 from statictext within w_ge108_consulta_preco_adm
end type
type st_15 from statictext within w_ge108_consulta_preco_adm
end type
type st_10 from statictext within w_ge108_consulta_preco_adm
end type
type st_11 from statictext within w_ge108_consulta_preco_adm
end type
type st_13 from statictext within w_ge108_consulta_preco_adm
end type
type st_9 from statictext within w_ge108_consulta_preco_adm
end type
type st_8 from statictext within w_ge108_consulta_preco_adm
end type
type st_mov_estoque from statictext within w_ge108_consulta_preco_adm
end type
type st_6 from statictext within w_ge108_consulta_preco_adm
end type
type st_7 from statictext within w_ge108_consulta_preco_adm
end type
type dw_saveas from dc_uo_dw_base within w_ge108_consulta_preco_adm
end type
type dw_alerta_reserva from datawindow within w_ge108_consulta_preco_adm
end type
end forward

global type w_ge108_consulta_preco_adm from dc_w_lista_relatorio
string accessiblename = "Consulta Interna de Pre$$HEX1$$e700$$ENDHEX$$os (GE108)"
integer x = 215
integer y = 220
integer width = 3598
integer height = 1884
string title = "GE108 - Consulta Interna de Produtos"
boolean resizable = false
st_1 st_1
st_2 st_2
st_3 st_3
st_14 st_14
st_15 st_15
st_10 st_10
st_11 st_11
st_13 st_13
st_9 st_9
st_8 st_8
st_mov_estoque st_mov_estoque
st_6 st_6
st_7 st_7
dw_saveas dw_saveas
dw_alerta_reserva dw_alerta_reserva
end type
global w_ge108_consulta_preco_adm w_ge108_consulta_preco_adm

type variables
Long il_Caixa

uo_produto				ivo_produto
uo_vendedor			ivo_vendedor
uo_parametro_filial	ivo_parametro
uo_cliente				ivo_cliente

Decimal idc_Pontos_Cliente

DateTime idh_Atualizacao_Fase_Cliente
DateTime idh_Solicitou_Atualizacao_Cliente

String	ivs_controla_psico
String	ivs_Captura_Controle_Venda
String	is_Rede_Filial
String is_Fase_Atualizacao_Cliente
String	is_Cliente_Possui_Campanha
String is_Mostra_Preco
String is_utiliza_lista_tecnica

boolean	ivb_pedido_pendente,&
			ivb_lancamento_psico_pendente,&
			ivb_pedido_ecommerce_pendente,&
			ivb_Dermaclub_ativo

Boolean ib_Produto_Vencido = False

Integer	ivi_dias_pedido_pendente
Integer	ivi_pedidos_ecommerce_pendente

long ivl_produto_busca_facil

String is_cliente
String is_Matricula_Negociacao
String is_Vendedor_Negociacao
String is_Permite_Negociacao = 'N'   //Teclas [Shift] + [END]

uo_parametro_pdv io_parametro_pdv
uo_ge108_reserva_produtos io_ge108_reserva_produtos
end variables

forward prototypes
public function boolean wf_localiza_produto (string ps_parametro)
public function integer wf_localiza_produto_prestes ()
public function decimal wf_localiza_desconto_produto ()
public function boolean wf_existe_produto_orcamento (decimal pdc_desconto_produto)
public function long wf_saldo_produto (long pl_produto)
public function string wf_verifica_situacao (long pl_produto)
public function string wf_verifica_local_estocagem (long pl_produto)
public subroutine wf_verifica_vidalink (long pl_produto, long pl_linha)
public subroutine wf_verifica_pbm (long pl_produto, long pl_linha)
public function boolean wf_comissao_extra (ref integer ai_contador, long al_linha)
public function decimal wf_pc_icms_produto ()
public function decimal wf_promocao_sos_farm_popular ()
public function boolean wf_verifica_lancamento_psico_pendente ()
public subroutine wf_verifica_confirmacao_pedido_pendente ()
public subroutine wf_verifica_pedido_ecommerce_pendente ()
public function integer wf_alerta_reserva_pendente ()
public function integer wf_mensagem_produto_pendente (long ps_produto)
public subroutine wf_consulta_desconto_portal_drogaria (ref boolean ab_produto_portal)
end prototypes

public function boolean wf_localiza_produto (string ps_parametro);Integer lvi_Contador

Long	lvl_Linha, &
		lvl_Saldo, &
		lvl_Filial, &
		lvl_Saldo_Pendente
Long ll_Count_Saldo_Pendente

String	lvs_Produto, &
		lvs_Situacao, &
		lvs_Local, &
		lvs_Indicador_Comissao

Decimal lvdc_Desconto_SOS
Decimal ldc_Desconto_Produto

dw_1.AcceptText()

lvs_Produto = ps_parametro

wf_Alerta_Reserva_Pendente( )

ivo_Produto.of_Localiza_Produto(lvs_Produto)

If ivo_Produto.Localizado Then
	wf_verifica_pedido_ecommerce_pendente()
	
	If This.wf_Localiza_Produto_Prestes( ) < 1 Then Return True
	
	lvl_Filial = gvo_Parametro.of_Filial()
	
	ldc_Desconto_Produto = This.wf_Localiza_Desconto_Produto( )
	
	If This.ib_Produto_Vencido Then Return False
	
	If wf_Existe_Produto_Orcamento( ldc_Desconto_Produto ) Then
		dw_1.Object.De_Produto[dw_1.GetRow()] = ""
		dw_1.SetColumn("de_produto")
		Return False
	End If		

	lvl_Saldo   		 = wf_Saldo_Produto(ivo_Produto.Cd_Produto)	
	lvs_Situacao		 = wf_Verifica_Situacao(ivo_Produto.Cd_Produto)
	lvs_Local   		 = wf_Verifica_Local_Estocagem(ivo_Produto.Cd_Produto)
	
	lvl_linha = dw_1.GetRow()

	SELECT COUNT(*)
	INTO :ll_Count_Saldo_Pendente
	FROM vw_saldo_produto_pendente
	WHERE cd_produto = :ivo_Produto.cd_Produto
	USING SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case -1
			SqlCa.of_MsgDbError( )
			dw_1.Object.Id_Saldo_Pendente[lvl_linha] = 'N'
			
		Case 0
			If ll_Count_Saldo_Pendente = 0 Then
				dw_1.Object.Id_Saldo_Pendente[lvl_linha] = 'N'
			Else
				dw_1.Object.Id_Saldo_Pendente[lvl_linha] = 'S'
			End If
	End Choose

	If ivo_Produto.Of_Existe_Promocao_Vinculada() Then
		dw_1.Object.id_promocao_vinculada[ lvl_linha ] = 'S'
	Else
		dw_1.Object.id_promocao_vinculada[ lvl_linha ] = 'N'
	End If	
	
	If ivo_produto.of_possui_pbm_clamed() Then
		dw_1.Object.id_pbm_clamed[ lvl_linha ] = 'S'
	Else
		dw_1.Object.id_pbm_clamed[ lvl_linha ] = 'N'		
	End If	
	
	If ivo_produto.of_possui_promocao_progressiva() Then
		dw_1.Object.id_promocao_progressiva[ lvl_linha ] = 'S'
	Else
		dw_1.Object.id_promocao_progressiva[ lvl_linha ] = 'N'		
	End If	
	
	wf_Verifica_Vidalink(ivo_Produto.Cd_Produto, lvl_linha)
	wf_Verifica_Pbm(ivo_Produto.Cd_Produto, lvl_linha)
		
	lvdc_Desconto_SOS = ivo_Produto.of_Desconto_SOS()
	
	If lvdc_Desconto_SOS < 0 Then lvdc_Desconto_SOS = 0
			
	dw_1.SetReDraw(False)
	dw_1.Object.cd_produto [lvl_linha] = ivo_produto.cd_produto
	
	// Verifica se o produto tem comiss$$HEX1$$e300$$ENDHEX$$o extra
	If Not wf_Comissao_Extra(Ref lvi_Contador, lvl_Linha) Then Return False
	
	dw_1.Object.de_produto 				[lvl_linha] = ivo_produto.ivs_descricao_apresentacao_venda
	dw_1.Object.qt_orcada	   				[lvl_linha] = 1
	dw_1.Object.qt_estoque	   				[lvl_linha] = lvl_Saldo
	dw_1.Object.id_situacao					[lvl_linha] = lvs_Situacao
	dw_1.Object.local      					[lvl_linha] = "Local: " + lvs_Local
	dw_1.Object.id_farmacia_popular		[lvl_linha] = ivo_Produto.id_farmacia_popular
	dw_1.Object.id_promover_venda		[lvl_linha] = ivo_Produto.id_promover_venda
	dw_1.Object.id_lei_generico			[lvl_linha] = ivo_Produto.id_lei_generico
	dw_1.Object.Id_Contem_Acucar		[lvl_linha] = ivo_Produto.Id_Contem_Acucar
	dw_1.Object.Id_Contem_Gluten		[lvl_linha] = ivo_Produto.Id_Contem_Gluten
	dw_1.Object.Id_Contem_Lactose		[lvl_linha] = ivo_Produto.Id_Contem_Lactose
	dw_1.Object.de_codigo_barras			[lvl_linha] = ivo_Produto.de_codigo_barras
	
	
	If IsNull( dw_1.Object.nr_etiqueta_prestes[lvl_linha] ) Then
		dw_1.Object.nr_etiqueta_prestes[lvl_linha] = ivo_Produto.nr_etiqueta_preste
	End If
	
	If This.is_Mostra_Preco = 'S' Then
		dw_1.Object.pc_icms						[lvl_linha] = wf_PC_ICMS_Produto( )
		dw_1.Object.vl_preco_unitario			[lvl_linha] = ivo_Produto.of_Preco_Venda_Filial()
		dw_1.Object.pc_desconto_fixo			[lvl_linha] = ldc_Desconto_Produto
		dw_1.Object.pc_desconto_negociavel	[lvl_linha] = ivo_Produto.of_Desconto_Negociavel()
		dw_1.Object.Pc_Desconto_SOS  		[lvl_linha] = lvdc_Desconto_SOS
		dw_1.Object.Pc_Desconto_Clube		[lvl_linha] = ivo_Produto.of_Desconto_Clube()
		dw_1.Object.id_gratis_farm_popular	[lvl_linha] = ivo_Produto.id_gratis_farm_popular
		dw_1.Object.Pc_Desconto_SOS_Farm_Popular[lvl_linha] = wf_Promocao_SOS_Farm_Popular()	
	End If
	
	dw_1.SetReDraw(True)
	
	wf_mensagem_produto_pendente(ivo_Produto.cd_produto)
	
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
		dw_1.SetColumn("qt_orcada")	
		dw_1.Event RowFocusChanged(lvl_linha)
	Else
		lvl_Linha = dw_1.Event ue_AddRow()
		dw_1.Event ue_Pos( dw_1.RowCount(), 'de_produto' )
	End If
	
	Return True
	
Else
	dw_1.SetColumn("de_produto")
	Return False
End If

end function

public function integer wf_localiza_produto_prestes ();Long ll_Dias_Vencimento

Decimal ldc_Desconto

Long ll_Linha
Long ll_Prod

String ls_Etiquetas_Orcadas[ ]
String ls_Etiqueta
String ls_Mensagem

srt_mensagem_prestes lstr_mensagem_prestes

//If Not IsNull( ivo_Produto.Nr_Etiqueta_Preste ) Then Return 1

If Not IsNull( ivo_Produto.Nr_Etiqueta_Preste ) Then
	If ivo_Produto.id_Situacao_Preste <> 'A' Then // Etiqueta j$$HEX1$$e100$$ENDHEX$$ baixada
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Etiqueta de produto prestes j$$HEX1$$e100$$ENDHEX$$ baixada.", StopSign! )
		Return -1 //N$$HEX1$$e300$$ENDHEX$$o deixa selecionar o produto
	End If	
	Return 1
End If

ls_Etiquetas_Orcadas[ 1 ] = ''

For ll_Linha = 1 To dw_1.RowCount( )
	If Not IsNull( dw_1.Object.Nr_Etiqueta_Prestes[ ll_Linha ] ) Then
		ls_Etiquetas_Orcadas[ UpperBound( ls_Etiquetas_Orcadas ) + 1 ] = dw_1.Object.Nr_Etiqueta_Prestes[ ll_Linha ]
	End If
Next
	
setNull( ls_Etiqueta )

uo_Produto lo_Produto_Prestes
lo_Produto_Prestes = Create uo_Produto
lo_Produto_Prestes.Of_Localiza_Produto(String(ivo_Produto.Cd_Produto))

ldc_Desconto = lo_Produto_Prestes.Of_Desconto_prestes( 	True, &
																			True, &
																			ls_Etiquetas_Orcadas, &
																			ls_Etiqueta, &
																			ll_Prod)
																	
If Not IsNull( ls_Etiqueta ) And (ivo_produto.cd_produto = ll_prod) Then

	lo_Produto_Prestes.of_Localiza_Produto( ls_Etiqueta )
		
	If lo_Produto_Prestes.id_Situacao_Preste = "A" Then
		lstr_mensagem_prestes.cd_backcolor = 12639424
		lstr_mensagem_prestes.de_titulo = 'Existe este produto prestes a vencer'

		ll_Dias_Vencimento = DaysAfter( Date( gvo_Parametro.of_Dh_Movimentacao( ) ), Date( lo_Produto_Prestes.dh_validade_preste ) )
		
		If ll_Dias_Vencimento <= 180 Then
			ls_Mensagem = lstr_mensagem_prestes.de_titulo + " em estoque com vencimento em " + String( lo_Produto_Prestes.dh_validade_preste, "mm/yyyy." )
			
			If lstr_mensagem_prestes.cd_backcolor = 65535 Then
				ls_Mensagem += "~r~rVerifique pelo Busca F$$HEX1$$e100$$ENDHEX$$cil [F6]."
			End If
			
			MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Mensagem, Exclamation! )
			
			dw_1.Object.nr_etiqueta_prestes[ dw_1.GetRow( ) ] = '1'
			
		End If
	End If
End If

If IsValid(lo_Produto_Prestes) Then Destroy lo_Produto_Prestes

Return 1
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

If This.is_Mostra_Preco = 'S' Then
	lvl_find = dw_1.Find (	"cd_produto = "+String(ivo_produto.cd_produto) + " and pc_desconto_fixo = " + gf_Valor_Com_Ponto( pdc_desconto_produto ), 1,	dw_1.RowCount( ) )
Else
	lvl_find = dw_1.Find (	"cd_produto = "+String(ivo_produto.cd_produto), 	1,	dw_1.RowCount( ) )
End If

If lvl_find = 0 Then Return False

If Not IsNull( ivo_Produto.Nr_Etiqueta_Preste ) Then
	ll_Find_Etiqueta_Prestes =	dw_1.Find (	"nr_etiqueta_prestes = '"+String( ivo_Produto.Nr_Etiqueta_Preste ) + "'", &
										1,	dw_1.RowCount( ) )
										
	If ll_Find_Etiqueta_Prestes > 0 Then
		MessageBox( "OPERA$$HEX2$$c700c300$$ENDHEX$$O N$$HEX1$$c300$$ENDHEX$$O PERMITIDA", "Etiqueta de produto prestes a vencer j$$HEX1$$e100$$ENDHEX$$ utilizada na consulta.~r~rO produto n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ adicionado novamente $$HEX1$$e000$$ENDHEX$$ lista.", Exclamation! )
		Return True
	End If
End If

dw_1.Object.qt_orcada [lvl_find] = dw_1.Object.qt_orcada [lvl_find] + 1

//wf_Registra_Produto_Sem_Saldo(lvl_Find) - Nesta tela n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ feito o resgitro de produto sem saldo.

Return True
end function

public function long wf_saldo_produto (long pl_produto);Long lvl_Saldo
Long ll_Saldo_Pendente

Select qt_saldo_final Into :lvl_Saldo
from vw_saldo_atual_produto
where cd_produto = :pl_produto;

Choose Case SqlCa.SqlCode
	Case 0
		// Somente transferencias entre filiais tem o saldo j$$HEX1$$e100$$ENDHEX$$ somado
		SELECT COALESCE( SUM( qt_saldo ), 0 )
		INTO :ll_Saldo_Pendente
		FROM vw_saldo_produto_pendente
		WHERE cd_produto = :pl_Produto
		AND ( tipo_movimento = 'TRANSF. FILIAL'     OR
				tipo_movimento = 'RESERVA CLIENTE' OR 
				tipo_movimento = 'RESERVA VEND. MACHINE' OR
				tipo_movimento = 'PEDIDO ECOMMERCE')
		USING SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgDbError( "wf_saldo_produto( long )" )
		Else
			lvl_Saldo = ( lvl_Saldo - ll_Saldo_Pendente )
		End If
		
		Return lvl_Saldo
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Saldo do produto " + String(pl_Produto) + " n$$HEX1$$e300$$ENDHEX$$o localizado.", Information!)
		Return 0
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do saldo do produto " + String(pl_Produto) + "." + SqlCa.SqlErrText, Information!)		
		Return 0		
End Choose
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

public subroutine wf_verifica_vidalink (long pl_produto, long pl_linha);//Mostra s$$HEX1$$ed00$$ENDHEX$$mbolo do programa farm$$HEX1$$e100$$ENDHEX$$cia popular em cima do campo descri$$HEX2$$e700e300$$ENDHEX$$o do produto.

String ls_Parametro

If ivo_Produto.Id_Farmacia_Popular = 'S' Then
	
	dw_1.Object.Id_Vidalink[pl_Linha] = 'S'
	
End If
end subroutine

public subroutine wf_verifica_pbm (long pl_produto, long pl_linha);//Mostra s$$HEX1$$ed00$$ENDHEX$$mbolo de PBM em cima do campo descri$$HEX2$$e700e300$$ENDHEX$$o do produto.

Long lvl_Count

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
	Return
End If

If lvl_Count > 0 Then
	dw_1.Object.Id_PBM[pl_Linha] = 'S'
End If

If ivb_Dermaclub_ativo Then
	//Verifica se tem dermaclub
	Select Count(pp.cd_pbm)
	  Into :lvl_Count
	  From pbm p, pbm_produto pp
	 Where pp.cd_produto = :pl_produto
		and pp.cd_pbm		= p.cd_pbm
		and p.id_tipo = 'D'
	 Using SqlCa;
	 
	 If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o dos PBMs Dermaclub do produto '" + String(pl_Produto) + "'.")
		Return
	End If
	
	If lvl_Count > 0 Then
		dw_1.Object.Id_dermaclub[pl_Linha] = 'S'
	End If
End If
end subroutine

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
and cd_tipo_comissao <> 3
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
	
	dw_1.Object.id_comissionado[al_Linha] = lvs_Indicador_Comissao
End If
	
SetPointer(Arrow!)

Return lvb_Sucesso
end function

public function decimal wf_pc_icms_produto ();Decimal ldc_PC_ICMS

ldc_PC_ICMS = 0.00

If This.ivo_Produto.cd_tributacao_icms <> '0' And This.ivo_Produto.cd_tributacao_icms <> '2' Then
	Return ldc_PC_ICMS	
End If

select Coalesce(t.pc_icms , 0.00)
	into :ldc_PC_ICMS
from produto_geral g
	left outer join  tipo_icms t
		on t.cd_tipo_icms 					= g.cd_tipo_icms
		and t.cd_unidade_federacao	= :gvo_Parametro.ivs_uf_filial
where g.cd_produto						= :This.ivo_Produto.cd_Produto
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_msgdberror( "Erro ao localizar a al$$HEX1$$ed00$$ENDHEX$$quota ICMS do produto " + String( This.ivo_Produto.cd_Produto ) + "." )
End If

Return ldc_PC_ICMS


end function

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

public subroutine wf_verifica_pedido_ecommerce_pendente ();Integer li_pedido_pendente
String ls_Dias

Date ldt_Limite, ldt_Parametro
Integer li_Count

ldt_Parametro = Date(gvo_parametro.dh_movimentacao)

select vl_parametro 
	into :ls_Dias
from parametro_loja where cd_parametro = 'NR_DIAS_LIMITE_PAUSA_ALERTA_PEDIDO_EC'
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_msgdberror("Erro ao localizar o limite de dias para a pausa do alerta de pedido pendente. ")
	Return
End If

If Trim(ls_Dias) = '' Or IsNull(ls_Dias) Then
	//Padr$$HEX1$$e300$$ENDHEX$$o caso n$$HEX1$$e300$$ENDHEX$$o seja informado no par$$HEX1$$e200$$ENDHEX$$metro
	ls_Dias = '2'
End If

ldt_Limite = RelativeDate( ldt_Parametro, - Integer(ls_Dias) )
	
Select count(nr_pedido_ecommerce)
   Into :ivi_Pedidos_Ecommerce_Pendente
From pedido_drogaexpress
inner join parametro p
	on p.id_parametro 	= '1'
Where id_situacao 		= 'A'
  and nr_pedido_ecommerce is not null
  and p.cd_filial <> 454
  and (dh_pausa_alerta is null OR Cast(dh_pausa_alerta as Date)< :ldt_Limite)
 Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o dos pedidos do eCommerce pendentes")
End If

SqlCa.of_End_Transaction( ) // Finaliza a transa$$HEX2$$e700e300$$ENDHEX$$o

ivb_Pedido_Ecommerce_Pendente = ( ivi_Pedidos_Ecommerce_Pendente > 0 )


end subroutine

public function integer wf_alerta_reserva_pendente ();Integer li_Retorno

li_Retorno = io_ge108_reserva_produtos.of_verifica_pendencia( False )

dw_alerta_reserva.Object.t_alerta_reserva.visible = ( li_Retorno > 0 )

Return li_Retorno
end function

public function integer wf_mensagem_produto_pendente (long ps_produto);String ls_ValorParametro,&
		 ls_MSG
		 
Long ll_Quantidade

ivo_parametro.of_localiza_parametro('ID_FILIAL_HUB_ECOMMERCE', Ref ls_ValorParametro)

If ls_ValorParametro = '' Then ls_ValorParametro = 'N'

If ls_ValorParametro = 'S' Then
	
	Select Sum(pp.qt_pedida)
	Into :ll_Quantidade
	From pedido_drogaexpress p
	Inner join produto_pedido_drogaexpress pp
	On pp.nr_pedido_drogaexpress = p.nr_pedido_drogaexpress
	Where p.id_situacao = 'A'
	And pp.cd_produto = :ps_Produto
	Using SqlCA;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_msgDbError("Erro ao localizar a qtde de produto pendente do ecommerce.")
		Return -1
	End If
	
	SqlCa.of_End_Transaction( ) // Finaliza a transa$$HEX2$$e700e300$$ENDHEX$$o
	
	If ll_Quantidade > 0 Then
		If ll_Quantidade = 1 Then
			ls_MSG = "Existe 1 unidade pendente de faturamento de pedido e-commerce. ~r~rCaso necess$$HEX1$$e100$$ENDHEX$$rio verifique a quantidade que est$$HEX1$$e100$$ENDHEX$$ em separa$$HEX2$$e700e300$$ENDHEX$$o."
		Else
			ls_MSG = "Existem " + String(ll_Quantidade) + " unidades pendentes de faturamento dos pedidos e-commerce. ~r~rCaso necess$$HEX1$$e100$$ENDHEX$$rio verifique as quantidades que est$$HEX1$$e300$$ENDHEX$$o em separa$$HEX2$$e700e300$$ENDHEX$$o."
		End If
		OpenWithParm(w_ge108_alerta_default, ls_MSG)
				
	End If
End if

Return 1
end function

public subroutine wf_consulta_desconto_portal_drogaria (ref boolean ab_produto_portal);String ls_Cod_Barras
String ls_Integra_API

Decimal ldc_Preco_Liquido, ldc_Preco_Bruto
Decimal ldc_Pc_Desc_Fixo

Integer li_Row, li_Linha_Insert, li_Existe

Long ll_Produto, ll_PBM_PORTAL

Try
	ab_produto_portal = False	
	
	//Verifica se a loja esta fazendo integracao com a API portal drogaria
	ivo_parametro.of_localiza_parametro( 'ID_INTEGRA_PORTAL_DROGARIA', ref ls_Integra_API)
	
	If ls_Integra_API <> 'S' Then
		Return
	End If
	
	ll_PBM_PORTAL = 175
	
	dw_1.AcceptText()
	
	li_Row = dw_1.GetRow()
	
	ll_Produto 			= dw_1.Object.cd_produto			[li_Row]	
	ldc_Preco_Bruto 	= dw_1.Object.vl_preco_unitario 	[li_Row]
	ldc_Preco_Liquido 	= dw_1.Object.vl_preco_final	 	[li_Row]
	ls_Cod_Barras		= dw_1.Object.de_codigo_barras 	[li_Row]
	ldc_Pc_Desc_Fixo	= dw_1.Object.pc_desconto_fixo 	[li_Row]
	
	If IsNull( ll_Produto ) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Nenhum produto selecionado.",Exclamation!)
		Return
	End If

	If IsNull(ls_Cod_Barras) Or Trim(ls_Cod_Barras) = '' Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O produto selecionado n$$HEX1$$e300$$ENDHEX$$o possui c$$HEX1$$f300$$ENDHEX$$digo de barras cadastrado.",Exclamation!)
		Return
	End If
		
	Select Count(cd_produto)
		into :li_Existe
		from pbm_produto
	where cd_pbm 			= :ll_PBM_PORTAL
		and cd_produto 	= :ll_Produto
		Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		gvo_aplicacao.of_grava_log( "Erro na localizacao do produto " + String (ll_Produto) + " na tabela pbm_produto, cd_pbm = " + String(ll_PBM_PORTAL))
		SqlCa.of_msgdberror( "Erro na localizacao do produto " + String (ll_Produto) + " na tabela pbm_produto, cd_pbm = " + String(ll_PBM_PORTAL))
		Return
	End If
	
	ab_Produto_Portal = (li_Existe > 0)
	
	If Not ab_Produto_Portal Then
		Return
	End If
	
	uo_ge570_portal_drogaria_balcao_atendimento lo_Consulta
	lo_Consulta = Create uo_ge570_portal_drogaria_balcao_atendimento
	
	//De acordo com o pessoal da interplayer $$HEX1$$e900$$ENDHEX$$ indicado verificar os produtos individulamente devido ao termo LGPD
	lo_Consulta.ids_produtos_atendimento.Reset()
	
	li_Linha_Insert = lo_Consulta.ids_produtos_atendimento.Insertrow( 0 )
	lo_Consulta.ids_produtos_atendimento.Object.cd_produto			[li_Linha_Insert] = ll_Produto
	lo_Consulta.ids_produtos_atendimento.Object.qt_produto			[li_Linha_Insert] = 1
	lo_Consulta.ids_produtos_atendimento.Object.vl_preco_bruto		[li_Linha_Insert] = ldc_Preco_Bruto
	lo_Consulta.ids_produtos_atendimento.Object.vl_preco_liquido		[li_Linha_Insert] = ldc_Preco_Liquido
	lo_Consulta.ids_produtos_atendimento.Object.de_codigo_barras	[li_Linha_Insert] = ls_Cod_Barras
	lo_Consulta.ids_produtos_atendimento.Object.pc_desconto_loja	[li_Linha_Insert] = ldc_Pc_Desc_Fixo
	
	lo_Consulta.of_consulta_produto( ls_Cod_Barras, ldc_Preco_Bruto, ldc_Preco_Liquido)
	
Finally
	If IsValid(lo_Consulta) Then Destroy lo_Consulta
End Try
end subroutine

on w_ge108_consulta_preco_adm.create
int iCurrent
call super::create
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.st_14=create st_14
this.st_15=create st_15
this.st_10=create st_10
this.st_11=create st_11
this.st_13=create st_13
this.st_9=create st_9
this.st_8=create st_8
this.st_mov_estoque=create st_mov_estoque
this.st_6=create st_6
this.st_7=create st_7
this.dw_saveas=create dw_saveas
this.dw_alerta_reserva=create dw_alerta_reserva
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.st_2
this.Control[iCurrent+3]=this.st_3
this.Control[iCurrent+4]=this.st_14
this.Control[iCurrent+5]=this.st_15
this.Control[iCurrent+6]=this.st_10
this.Control[iCurrent+7]=this.st_11
this.Control[iCurrent+8]=this.st_13
this.Control[iCurrent+9]=this.st_9
this.Control[iCurrent+10]=this.st_8
this.Control[iCurrent+11]=this.st_mov_estoque
this.Control[iCurrent+12]=this.st_6
this.Control[iCurrent+13]=this.st_7
this.Control[iCurrent+14]=this.dw_saveas
this.Control[iCurrent+15]=this.dw_alerta_reserva
end on

on w_ge108_consulta_preco_adm.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_14)
destroy(this.st_15)
destroy(this.st_10)
destroy(this.st_11)
destroy(this.st_13)
destroy(this.st_9)
destroy(this.st_8)
destroy(this.st_mov_estoque)
destroy(this.st_6)
destroy(this.st_7)
destroy(this.dw_saveas)
destroy(this.dw_alerta_reserva)
end on

event open;call super::open;ivo_produto   = Create uo_produto
ivo_parametro = Create uo_parametro_filial

ivo_Produto.ivb_nao_liberado_filial = False

dw_1.of_SetMenu(This.ivm_Menu)

ivb_Lancamento_Psico_Pendente = False
ivb_pedido_pendente			  = False

SetNull(ivl_Produto_Busca_Facil)

wf_Verifica_Lancamento_Psico_Pendente()
wf_Verifica_Confirmacao_Pedido_Pendente()
wf_verifica_pedido_ecommerce_pendente()

ivo_parametro.of_localiza_parametro( 'ID_UTILIZA_LISTA_TECNICA', ref is_utiliza_lista_tecnica)

ivo_parametro.of_localiza_parametro( 'ID_DERMACLUB_ATIVO', ref ivb_Dermaclub_ativo )

// A cada 5 minutos atualizar as variav$$HEX1$$e900$$ENDHEX$$is de inst$$HEX1$$e200$$ENDHEX$$ncia que controlam
// os lan$$HEX1$$e700$$ENDHEX$$amentos dos psicos pendentes e a confirma$$HEX2$$e700e300$$ENDHEX$$o dos pedidos
Timer(300)

end event

event timer;call super::timer;wf_Verifica_Lancamento_Psico_Pendente()
wf_Verifica_Confirmacao_Pedido_Pendente()
wf_verifica_pedido_ecommerce_pendente()

SqlCa.of_End_Transaction( ) // Fnializa a transa$$HEX2$$e700e300$$ENDHEX$$o
end event

event close;call super::close;If IsValid(ivo_produto)   		Then Destroy(ivo_produto)
If IsValid(ivo_vendedor)  	Then Destroy(ivo_vendedor)
If IsValid(ivo_Parametro) 	Then Destroy(ivo_Parametro)
If IsValid( io_ge108_reserva_produtos ) Then Destroy io_ge108_reserva_produtos
end event

event ue_postopen;call super::ue_postopen;ivm_Menu.ivb_permite_recuperar = False
ivm_Menu.ivb_permite_alterar = False
ivm_Menu.ivb_permite_classificar = True
ivm_Menu.ivb_permite_filtrar = True
ivm_Menu.ivb_permite_localizar = False

This.ivm_Menu.mf_recuperar( False )
This.ivm_Menu.mf_Classificar(True)
This.ivm_Menu.mf_Filtrar(True)
This.ivm_Menu.mf_Excluir(True)
This.ivm_Menu.mf_Incluir(True)
This.ivm_Menu.mf_SalvarComo(True)	

dw_1.ivo_Controle_Menu.of_Incluir(True)
dw_1.ivo_Controle_Menu.of_Excluir(True)

dw_1.ivm_menu.m_legendas.visible = True

This.ivm_Menu.ivb_Permite_Imprimir = True

dw_1.Event ue_Cancel()

//If Not ivo_Parametro.of_Localiza_Parametro("ID_CONTROLA_PSICO", Ref ivs_controla_psico) Then Return
This.ivs_Controla_Psico = 'S'

dw_1.Event ue_Pos( 1, 'de_produto' )

io_ge108_reserva_produtos = Create uo_ge108_reserva_produtos
wf_Alerta_Reserva_Pendente( )

Try
	uo_Parametro_Filial lo_Parametro_Loja
	lo_Parametro_Loja = Create uo_Parametro_Filial
	lo_Parametro_Loja.of_Localiza_Parametro( 'ID_MOSTRA_PRECO_CONSULTA_INTERNA_GE108', Ref This.is_Mostra_Preco, False )
	
	If IsNull( This.is_Mostra_Preco ) Or Trim( This.is_Mostra_Preco ) = "" Then
		This.is_Mostra_Preco = 'N'
	End If
	
Catch( RuntimeError ru )
	MessageBox( "RuntimeError", ru.getMessage( ) + '~rEvento: ue_postopen( )', StopSign! )
Finally
	Destroy lo_Parametro_Loja
End Try

dw_1.Object.st_preco_final_farm_popular.Visible 			= False
dw_1.Object.st_gratis_farm_popular.Visible 				= False
dw_1.Object.st_nome_preco_final_farm_popular.Visible	= False
dw_1.Object.st_pmc_farm_popular.Visible 					= False
dw_1.Object.st_nome_pmc_farm_popular.Visible 			= False
dw_1.Object.bmp_vidalink2.Visible 							= False
dw_1.Object.st_preco_fpb.Visible 								= False
dw_1.Object.st_nome_preco_fpb.Visible 					= False
dw_1.Object.t_7.Visible 											= False
dw_1.Object.c_total.Visible 										= False
dw_1.Object.t_total_clube.Visible 								= False
dw_1.Object.c_total_clube.Visible 								= False
dw_1.Object.t_total_convenio.Visible 							= False
dw_1.Object.c_total_convenio.Visible 						= False

SqlCa.of_End_Transaction( )


end event

event ue_preprint;call super::ue_preprint;Long lvl_ind, i

dw_2.Reset()
dw_1.AcceptText()

If dw_1.RowCount() = 0 Then
	Return -1
End If
// Se a $$HEX1$$fa00$$ENDHEX$$ltima linha for nula, exclui.
If IsNull(dw_1.Object.cd_produto [dw_1.RowCount()]) Then
	If dw_1.RowCount() = 1 Then
		Messagebox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o para impress$$HEX1$$e300$$ENDHEX$$o.", Information!)
		Return -1
	End If
	dw_1.DeleteRow(dw_1.RowCount())
End If

If dw_1.RowCount() = 0 Then
	Return -1
End If

dw_2.Object.vl_total_geral_t.Text	=  String( dw_1.GetItemDecimal(dw_1.RowCount(), "c_total"), "R$ #,##0.00")

For lvl_ind = 1 To dw_1.RowCount()
	i= dw_2.InsertRow(0)
	dw_2.Object.qt_total				[ i ] = dw_1.Object.qt_orcada				[ lvl_ind ]
	dw_2.Object.de_produto			[ i ] = String( dw_1.Object.cd_produto 	[ lvl_ind ] ) + "-" + dw_1.Object.de_produto	[ lvl_ind ]
	dw_2.Object.vl_unitario			[ i ] = dw_1.Object.vl_preco_final			[ lvl_ind ]
	dw_2.Object.vl_total				[ i ] = dw_1.Object.c_total_produto		[ lvl_ind ]
Next

If dw_2.RowCount() = 0 Then Return -1
	
dw_2.GroupCalc()

dw_2.of_Print(True)


end event

event ue_preopen;call super::ue_preopen;dw_alerta_reserva.InsertRow( 0 )
dw_alerta_reserva.Object.t_alerta_reserva.Visible = False
end event

type dw_visual from dc_w_lista_relatorio`dw_visual within w_ge108_consulta_preco_adm
end type

type gb_aux_visual from dc_w_lista_relatorio`gb_aux_visual within w_ge108_consulta_preco_adm
end type

type dw_1 from dc_w_lista_relatorio`dw_1 within w_ge108_consulta_preco_adm
integer x = 55
integer y = 132
integer width = 3483
integer height = 1460
string dataobject = "dw_ge108_produtos"
end type

event dw_1::ue_key;call super::ue_key;Long lvl_Produto, &
     lvl_Linha,   &
	 lvl_Saldo
	 
Decimal lvdc_Desconto

String ls_Matricula_Negociacao

Boolean lb_Produto_Portal_Drogaria = False

Choose Case Key
	Case KeyEnter!
		Choose Case GetColumnName()
			Case "de_produto"
				wf_localiza_produto(This.GetText())
				lvl_Saldo = dw_1.Object.qt_estoque[dw_1.GetRow()]
				
//				If lvl_Saldo <= 0 Then
//					OpenWithParm(w_ge108_registro_falta_produtos,Long(dw_1.Object.cd_produto[dw_1.GetRow()]))
//				End If
				
			Case "qt_orcada"	
				Event ue_AddRow()
				SetRow(RowCount())
				ScrollToRow(RowCount())
				SetColumn("de_produto")
		End Choose
		
		SqlCa.of_End_Transaction( ) // Finaliza a transa$$HEX2$$e700e300$$ENDHEX$$o
		
	Case KeyEscape!		
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja realmente limpar a consulta atual?", Question!, YesNo!, 2) = 1 Then
			dw_1.Event ue_Reset()
			dw_1.Event ue_AddRow()
			dw_1.Event ue_Pos( 1, 'de_produto' )
		End If

		SqlCa.of_End_Transaction( ) // Finaliza a transa$$HEX2$$e700e300$$ENDHEX$$o

		
	Case KeyF4!
		Open(w_ge107_consulta_posicao_desconto)
		
		SqlCa.of_End_Transaction( ) // Finaliza a transa$$HEX2$$e700e300$$ENDHEX$$o
	
	Case KeyF8!
		OpenWithParm( w_ge108_movimentacao_estoque, Long( dw_1.Object.cd_produto[dw_1.GetRow()] ) )
		
		SqlCa.of_End_Transaction( ) // Finaliza a transa$$HEX2$$e700e300$$ENDHEX$$o
		
	Case KeyF9!
		lvl_Linha = This.GetRow()
		
		lvl_Produto = dw_1.Object.cd_produto[ lvl_linha ]
		
		If Not IsNull( lvl_Produto ) Then
			uo_ge108_parametros lo
			lo = Create uo_ge108_parametros
			
			lo.Produto = lvl_Produto
			lo.habilita_botao_reserva_ge107 = False
			
			OpenWithParm(w_ge107_consulta_saldo_matriz_response, lo)
			
			If IsValid(lo) Then Destroy lo
		End If
		
		SqlCa.of_End_Transaction( ) // Finaliza a transa$$HEX2$$e700e300$$ENDHEX$$o		
		
	Case KeyF7!
		lvl_Linha = This.GetRow()
		
		If lvl_Linha > 0 Then
			lvl_Produto = This.Object.Cd_Produto[lvl_Linha]

			ivo_Produto.of_Localiza_Codigo_Interno(lvl_Produto)
			
			If ivo_Produto.Localizado Then
				If This.Object.id_promocao_vinculada [ lvl_linha ] = 'S' or This.Object.id_promocao_progressiva [ lvl_linha ] = 'S'Then					
					lvdc_Desconto = This.Object.pc_desconto_fixo[This.GetRow()]
					If This.Object.pc_desconto_sos[This.GetRow()] > lvdc_Desconto Then lvdc_Desconto    		= This.Object.pc_desconto_sos[This.GetRow()]
					If This.Object.pc_desconto_clube[This.GetRow()] > lvdc_Desconto Then lvdc_Desconto 		= This.Object.pc_desconto_clube[This.GetRow()]
					If This.Object.pc_desconto_convenio[This.GetRow()] > lvdc_Desconto Then lvdc_Desconto 	= This.Object.pc_desconto_convenio[This.GetRow()]

					OpenWithParm( w_ge108_promocao_vinculada, String(lvdc_Desconto)+'|V|'+String(lvl_Produto) )				
					
					This.event ue_pos(lvl_Linha,"qt_orcada")					

				Else
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto '" + String(lvl_Produto) + "' n$$HEX1$$e300$$ENDHEX$$o possui nenhuma promo$$HEX2$$e700e300$$ENDHEX$$o vinculada.", Information!)
				End If
			End If		
		End If
		
		SqlCa.of_End_Transaction( ) // Finaliza a transa$$HEX2$$e700e300$$ENDHEX$$o
	
	Case KeyF5!
		wf_consulta_desconto_portal_drogaria(Ref lb_Produto_Portal_Drogaria)
		
		If Not lb_Produto_Portal_Drogaria Then
					
			lvl_Linha = This.GetRow()		
		
			lvl_Produto = This.Object.cd_produto[This.GetRow()]
			
			If Not IsNull(lvl_Produto) Then
			
				lvdc_Desconto = This.Object.pc_desconto_fixo[This.GetRow()]
				If This.Object.pc_desconto_sos[This.GetRow()] > lvdc_Desconto Then lvdc_Desconto    		= This.Object.pc_desconto_sos[This.GetRow()]
				If This.Object.pc_desconto_clube[This.GetRow()] > lvdc_Desconto Then lvdc_Desconto 		= This.Object.pc_desconto_clube[This.GetRow()]
				If This.Object.pc_desconto_convenio[This.GetRow()] > lvdc_Desconto Then lvdc_Desconto 	= This.Object.pc_desconto_convenio[This.GetRow()]							
				
				uo_ge108_produto lo_Prd
				lo_Prd = Create uo_ge108_produto
				
				lo_Prd.idc_desconto = lvdc_Desconto			
				lo_Prd.of_localiza_codigo_interno( lvl_Produto )
				
				lo_Prd.of_consulta_regras_pbms_vidalink( )		
				
				If IsValid(lo_Prd) Then Destroy lo_Prd
				
			End If
		End If
		
		SqlCa.of_End_Transaction( ) // Finaliza a transa$$HEX2$$e700e300$$ENDHEX$$o
		
	Case KeyF6!
	 	lvl_Produto = This.Object.cd_produto[This.GetRow()]
		 
		If Not IsNull(lvl_Produto) Then
			
			SetNull(ivl_Produto_Busca_Facil)
			
			if is_utiliza_lista_tecnica = 'S' Then
				OpenWithParm(w_ge001_Busca_Facil_lista_tecnica, lvl_Produto)
			else
				OpenWithParm(w_ge001_Busca_Facil, lvl_Produto)
			end if
						
			ivl_Produto_Busca_Facil = Message.DoubleParm
			
			If Not IsNull(ivl_Produto_Busca_Facil) and ivl_Produto_Busca_Facil > 0 Then
//				wf_Inclui_Produto()
			End If 
		End If
		
		SqlCa.of_End_Transaction( ) // Finaliza a transa$$HEX2$$e700e300$$ENDHEX$$o
		
End Choose
end event

event dw_1::constructor;call super::constructor;ivb_updateable     = False
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

This.of_SetRowSelection( )

//This.of_SetRowSelection( "if(qt_estoque = 0, rgb(255, 0, 0), " + This.ivs_Cor_Linha_Padrao + ")", "", False )
end event

event dw_1::itemchanged;call super::itemchanged;ivm_Menu.mf_recuperar( False )
Choose Case dwo.Name
	Case "de_produto"
		If Data <> ivo_Produto.ivs_Descricao_Apresentacao_Venda Then 
			Return 1
		End If
End Choose
end event

event dw_1::itemfocuschanged;call super::itemfocuschanged;Choose Case dwo.Name
	Case "de_produto" ; This.SelectText(1,40)
	Case "qt_orcada"  ; This.SelectText(1,3)
End Choose
end event

event dw_1::rowfocuschanged;call super::rowfocuschanged;
//*********
//N$$HEX1$$e300$$ENDHEX$$o mostrar valores do FPB. Visivel somente na tela de atendimento
//Campos ocultos no ue_postOpen
//*********

If CurrentRow > 0 Then	
	If This.Object.id_Saldo_Pendente[CurrentRow] = 'S' Then
		st_mov_estoque.Text = 'Mov. Estoque / Saldo Pendente'
	Else
		st_mov_estoque.Text = 'Mov. Estoque'
	End If
End If
end event

event dw_1::ue_addrow;call super::ue_addrow;Try
	ivm_Menu.mf_Imprimir(True)
	ivm_Menu.mf_Excluir(True)
	
	If RowCount() > 0 Then
		If IsNull(Object.cd_produto[RowCount()]) Then			
			dw_1.Object.Id_Saldo_Pendente[ RowCount() ] = 'N'
			st_mov_estoque.Text = 'Mov. Estoque'
		End If
	End If

	Return AncestorReturnValue
	
Catch( RuntimeError ru )
	MessageBox( "RuntimeError", ru.GetMessage( ), StopSign! )
End Try
end event

event dw_1::ue_deleterow;call super::ue_deleterow;If RowCount() = 0 Then
	ivm_Menu.mf_Excluir(False)
	dw_1.Event ue_Cancel()
End If
ivm_Menu.mf_Confirmar(False)
ivm_Menu.mf_Cancelar(False)	

Return True

end event

event dw_1::editchanged;call super::editchanged;If Not IsNull( This.Object.nr_etiqueta_prestes[ row ] ) Then
	This.Object.Qt_Orcada[ row ] = 1
	Return -1
End If
end event

event dw_1::ue_saveas;// OverRide
dw_SaveAs.Event ue_SaveAs( )
end event

event dw_1::ue_preinsertrow;call super::ue_preinsertrow;If RowCount() > 0 Then
	If IsNull(Object.cd_produto[RowCount()]) Then			
		Return -1
	End If
End If

Return 1
end event

type gb_1 from dc_w_lista_relatorio`gb_1 within w_ge108_consulta_preco_adm
integer y = 84
integer width = 3520
integer height = 1516
integer weight = 700
fontcharset fontcharset = defaultcharset!
string text = "Lista de Produtos"
end type

type dw_2 from dc_w_lista_relatorio`dw_2 within w_ge108_consulta_preco_adm
integer x = 2962
integer y = 840
integer height = 292
string dataobject = "dw_ge108_consulta_preco"
boolean border = true
end type

type st_1 from statictext within w_ge108_consulta_preco_adm
integer x = 27
integer y = 1608
integer width = 3534
integer height = 88
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 8388608
string text = "z"
alignment alignment = center!
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type st_2 from statictext within w_ge108_consulta_preco_adm
integer x = 210
integer y = 1624
integer width = 128
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
string text = "F4"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_3 from statictext within w_ge108_consulta_preco_adm
integer x = 320
integer y = 1624
integer width = 338
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 8388608
boolean enabled = false
string text = "Desc. M$$HEX1$$e900$$ENDHEX$$dio"
boolean focusrectangle = false
end type

type st_14 from statictext within w_ge108_consulta_preco_adm
integer x = 663
integer y = 1624
integer width = 123
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
string text = "F5"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_15 from statictext within w_ge108_consulta_preco_adm
integer x = 763
integer y = 1624
integer width = 178
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 8388608
boolean enabled = false
string text = "PBMs"
boolean focusrectangle = false
end type

type st_10 from statictext within w_ge108_consulta_preco_adm
integer x = 992
integer y = 1624
integer width = 105
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
string text = "F6"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_11 from statictext within w_ge108_consulta_preco_adm
integer x = 1074
integer y = 1624
integer width = 311
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 8388608
boolean enabled = false
string text = "Busca F$$HEX1$$e100$$ENDHEX$$cil"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_13 from statictext within w_ge108_consulta_preco_adm
integer x = 1454
integer y = 1624
integer width = 78
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
string text = "F7"
boolean focusrectangle = false
end type

type st_9 from statictext within w_ge108_consulta_preco_adm
integer x = 1531
integer y = 1624
integer width = 343
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 8388608
boolean enabled = false
string text = "Promo$$HEX2$$e700e300$$ENDHEX$$o"
boolean focusrectangle = false
end type

type st_8 from statictext within w_ge108_consulta_preco_adm
integer x = 1870
integer y = 1624
integer width = 114
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
string text = "F8"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_mov_estoque from statictext within w_ge108_consulta_preco_adm
integer x = 1979
integer y = 1624
integer width = 782
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 8388608
string text = "Mov. Estoque / Saldo Pendente"
boolean focusrectangle = false
boolean disabledlook = true
end type

type st_6 from statictext within w_ge108_consulta_preco_adm
integer x = 3054
integer y = 1624
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

type st_7 from statictext within w_ge108_consulta_preco_adm
integer x = 3141
integer y = 1624
integer width = 379
integer height = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 16777215
long backcolor = 8388608
boolean enabled = false
string text = "Estoque Filiais"
alignment alignment = right!
boolean focusrectangle = false
end type

type dw_saveas from dc_uo_dw_base within w_ge108_consulta_preco_adm
boolean visible = false
integer x = 663
integer y = 1020
integer width = 1669
integer height = 176
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge108_consulta_interna_saveas"
boolean border = true
end type

event ue_saveas;// OverRide
Long ll_Linha

This.Reset( )

For ll_Linha = 1 To dw_1.RowCount( )
	This.InsertRow( ll_Linha )
	
	This.Object.cd_Produto[ ll_Linha ] = dw_1.Object.cd_Produto[ ll_Linha ]
	This.Object.de_Produto[ ll_Linha ] = dw_1.Object.de_Produto[ ll_Linha ]
Next

SUPER::Event ue_SaveAs( )
end event

type dw_alerta_reserva from datawindow within w_ge108_consulta_preco_adm
integer x = 37
integer y = 12
integer width = 3520
integer height = 72
integer taborder = 10
boolean bringtotop = true
string title = "none"
string dataobject = "dw_ge108_alerta_reserva_pendente"
boolean border = false
boolean livescroll = true
end type

event doubleclicked;If dwo.Name = 't_alerta_reserva' Then
	io_ge108_reserva_produtos.of_verifica_pendencia( True )
End If
end event

