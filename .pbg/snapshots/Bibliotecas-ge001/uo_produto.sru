HA$PBExportHeader$uo_produto.sru
forward
global type uo_produto from nonvisualobject
end type
end forward

global type uo_produto from nonvisualobject
end type
global uo_produto uo_produto

type variables
Long ivl_Filial_Parametro, &
         ivl_Filial_Matriz

Boolean ivb_inativo_loja				= True
Boolean ivb_nao_liberado_filial		= True
Boolean ivb_produto_resgate_clube	= False
Boolean ib_erro							= False
Boolean ib_movimentacao_bloqueada	= False

// Neste caso o sistema ir$$HEX1$$e100$$ENDHEX$$ considerar todas as promo$$HEX2$$e700f500$$ENDHEX$$es
// Deve ser setado como "S" somente na integra$$HEX2$$e700e300$$ENDHEX$$o com o e-commerce
String is_somente_liberado_ecommerce = 'N'

Constant Long cd_produto_manipulado	= 684431

Constant Long cd_produto_formula		= 577625

Constant Long cd_produto_frete		= 712055

Long cd_promocao_sos
Long nr_campanha
Long cd_promocao_sos_ajuste_preco_pr // Quando for executado pelo sistema carga

Boolean Localizado

Decimal	vl_Preco_Clube,&
			vl_preco_venda


Long	Cd_Produto, &
		Qt_Pontos_Resgate, &
		Nr_Classificacao_Fiscal,&
		cd_tributacao_produto,&
		cd_planograma,&
		qt_unidades_embalagem


String	De_Produto, &
			De_Apresentacao_Venda, &
			De_Apresentacao_Estoque, &
			Cd_Unidade_Medida_Compra, &
			Cd_Unidade_Medida_Venda, &
			Cd_Fornecedor_Usual,&
			Id_Caderno_AbcFarma, &
			Cd_Origem_Produto, &
			Cd_Tributacao_ICMS, &
			de_codigo_barras, &
			id_situacao, &
			cd_grupo_psico, &
			id_preco_bloqueado,&
			id_cartao_genio,&
			id_situacao_pis_cofins, &
			cd_subcategoria, &
			id_utiliza_vale_resgate,&
			cd_linha_produto,&
			id_apresentacao,&
			id_recuperacao_vencido,&
			de_descricao_internet,&
			de_principal_internet,&
			id_liberado_ecommerce, &
			id_lei_generico, &
			id_farmacia_popular,&
			id_gratis_farm_popular, &
			de_registro_ms,&
			cd_st_origem,&
			cd_local_estocagem, &
			id_promover_venda, &
			cd_cest, &
			id_contem_acucar, &
			id_contem_gluten, &
			id_contem_lactose, &
			id_geladeira

String	id_tipo_un_calc_preco

String	id_liberado_ecommerce_DC //Rede DC
String	id_liberado_ecommerce_MP //Rede Manipula$$HEX2$$e700e300$$ENDHEX$$o
String	id_liberado_ecommerce_PP //Rede Pre$$HEX1$$e700$$ENDHEX$$o Popular

String	cd_produto_sap		 
		 
String	id_Permite_Devolucao

String	ivs_Descricao_Apresentacao_Venda, &
			ivs_Descricao_Apresentacao_Estoque, &
			ivs_parametro, &
			ivs_cliente_campanha
		 
/* Tipo de localiza$$HEX2$$e700e300$$ENDHEX$$o utilizado em of_Localiza_Produto( )
 * CODIGO_INTERNO
 * CODIGO_BARRAS
 * ETIQUETA_PRESTES
 * REGISTRO_MS
 * OUTRO
*/
Private string is_Tipo_Localizacao = '' 

//------------------------------------------- Prestes a vencer
Long	cd_filial_inclusao_preste, &
		cd_filial_preste, &
		nr_nf_preste

String nr_lote_preste, &
		nr_etiqueta_preste, &
		id_situacao_preste, &
		id_concede_desconto, &
		de_especie_preste, &
		de_serie_preste, &
		nr_matricula_inclusao_preste, &
		nr_matricula_comprador

DateTime dh_validade_preste
DateTime dh_baixa_preste
DateTime ivdh_data_parametro
//------------------------------------------- Termino Prestes

decimal	pc_reducao_base_icms, &
			pc_comissao_extra, &
			pc_desconto_clube_atual, &
			vl_fator_conversao, &
			vl_preco_venda_maximo, &  
			vl_ponto_clube,&
			pc_imposto_cupom,&
			pc_icms,&
			pc_ipi,&
			vl_reembolso_fpb, &
			vl_preco_medio_ponderado_cf  //Pre$$HEX1$$e700$$ENDHEX$$o M$$HEX1$$e900$$ENDHEX$$dio Ponderado $$HEX1$$e000$$ENDHEX$$ Consumidor Final

decimal vl_volume
Decimal qt_comprimento

decimal{5} qt_concentracao

decimal{3} qt_peso_grama
decimal{3} qt_peso_apresentacao

integer cd_grupo_produto, &
            cd_subgrupo_produto, &
            cd_tipo_icms

datetime dh_preco_venda_atual

Public ProtectedWrite decimal  vl_preco_venda_atual
Public ProtectedWrite decimal  pc_desconto_atual

string  id_tipo_desconto_atual

dc_uo_ds_base ivds_desc_prestes

String	is_Window_Selecao_Generica = "",&
		id_exclusivo_pedido_falta_ba
		
dc_uo_ds_base ids_contratos_bin
STRING nr_cartao_saude_desconto

uo_udi	iuo_udi
end variables

forward prototypes
public subroutine of_localiza_codigo_barras (string ps_codigo_barras)
public subroutine of_localiza_generica (string ps_parametro)
public function boolean of_inativo_loja (long pl_produto)
public function boolean of_inativo_central (long pl_produto)
public function decimal of_preco_padrao ()
public function decimal of_preco_regionalizado ()
public function decimal of_preco_venda_filial ()
public function decimal of_desconto_fixo ()
public function decimal of_desconto_negociavel ()
public function decimal of_desconto_sos ()
public function boolean of_tem_desconto_negociavel ()
public function decimal of_custo_medio ()
public function decimal of_desconto_contrato_convenio (long pl_convenio, long pl_produto, date pdt_inicio)
public function decimal of_desconto_negociado ()
public function boolean of_atualiza_desconto_padrao (date pdt_data_base)
public function decimal of_saldo_produto (long pl_produto)
public subroutine of_inicializa ()
public function boolean of_comissionado ()
protected function boolean of_atualiza_preco_padrao (date pdt_data_base)
public function decimal of_desconto_filial ()
public subroutine of_localiza_produto (string as_parametro)
public subroutine of_localiza_produto (string as_parametro, boolean ab_generica)
public function decimal of_desconto_convenio (long pl_convenio, decimal pdc_desconto_minimo)
public function decimal of_desconto_contrato_convenio (long pl_convenio)
public function decimal of_desconto_contrato_convenio_new (long pl_convenio)
public function decimal of_desconto_clube ()
public function boolean of_atualiza_preco_desconto (date adt_data_base)
public function decimal of_desconto_promocao ()
public function decimal of_desconto_promocao (string as_tipo_promocao, long al_filial)
public function decimal of_desconto_filial (long al_filial)
public function decimal of_desconto_promocao (string as_tipo_promocao)
public function string of_verifica_preco_bloqueado_promocao (long al_produto, date adt_parametro)
protected function boolean of_atualiza_preco_padrao_filial (date pdt_data_base)
protected function boolean of_atualiza_preco_padrao_matriz (date pdt_data_base)
public function decimal of_custo_gerencial ()
public function decimal of_preco_regionalizado (long pl_filial)
public subroutine of_localiza_registro_ms (string ps_registro_ms)
public function long of_valida_lote (long pl_produto, string ps_lote, ref long pl_quantidade, ref DataStore pds_lote)
public function boolean of_verifica_promocao_vencimento ()
public function boolean of_grupo_produto (ref string ps_grupo)
public function boolean of_periodo_promocao_sos (ref datetime adt_inicio, ref datetime adt_fim)
public function decimal of_preco_venda_filial_matriz (long pl_filial)
public function decimal of_preco_padrao_filial_matriz (long pl_filial)
public function decimal of_preco_venda_filial_old (long pl_filial)
public function decimal of_desconto_campanha (string pl_cliente)
public function decimal of_desconto_filial (long al_filial, string as_tipo_promocao)
public function decimal of_desconto_clube_filial (long pl_filial)
protected function boolean of_atualiza_preco_regionalizado (date pdt_data_base)
public function boolean of_atualiza_desconto_promocao (date adt_data_base)
public function boolean of_localiza_codigo_interno (long pl_produto)
public subroutine of_localiza_etiqueta_preste (string ps_etiqueta)
public function decimal of_desconto_etiqueta_preste ()
public function string of_verifica_preco_bloqueado_promocao (long al_produto, date adt_parametro, string as_uf)
public function decimal of_desconto_prestes ()
public function decimal of_desconto_prestes (boolean pb_busca_prod_localizado, boolean pb_busca_prod_semelhantes, string ps_etiqueta_desconsidera[], ref string ps_etiqueta, ref long pl_produto)
public function boolean of_existe_promocao_vinculada ()
public function boolean of_existe_negociacao_cliente (ref decimal as_desconto_maximo, ref decimal as_rentabilidade_minima)
public function boolean of_possui_pbm_clamed ()
public function boolean of_atualiza_desconto_promocao_futuro (date adt_data_base)
public function boolean of_possui_promocao_progressiva ()
public subroutine of_localiza_codigo_barras_like (string as_codigo_barras)
protected function boolean of_exclui_preco_regionalizado (date pdt_data_base)
public function decimal of_desconto_contrato_convenio (long pl_convenio, long pl_contrato)
public function decimal of_desconto_prestes (boolean pb_busca_prod_localizado, boolean pb_busca_prod_semelhantes, string ps_etiqueta_desconsidera[], ref string ps_etiqueta, ref long pl_produto, ref long pl_qt_disponivel_desconto)
public subroutine of_localiza_codigo_sap (string ps_cd_produto_sap)
public function boolean of_possui_dermaclub ()
public function boolean of_existe_negociacao_cliente (long al_filial, ref decimal as_desconto_maximo, ref decimal as_rentabilidade_minima)
public function boolean of_verifica_excecao_pesquisa ()
public function decimal of_desconto_clube_filial_nova (long pl_filial)
public function boolean of_utiliza_novo_calculo_preco_sap (long pl_cd_filial, ref string ps_id_novo_calculo)
public function boolean of_desconto_clube_filial_sap_novo (long pl_cd_filial, ref decimal pdc_valor_desconto)
public function boolean of_atualiza_preco_padrao_matriz_sap (date pdt_data_base)
public function boolean of_preco_venda_filial_matriz_novo (long pl_cd_filial, ref decimal pdc_vl_preco, ref decimal pdc_vl_preco_clube)
end prototypes

public subroutine of_localiza_codigo_barras (string ps_codigo_barras);Long lvl_Produto

Select cd_produto Into :lvl_Produto
From codigo_barras_produto
Where de_codigo_barras = :ps_Codigo_Barras
Using SqlCa;
	
If SqlCa.SqlCode = 100 Then
	iuo_udi = Create uo_udi
	Try
		if iuo_udi.of_parse_udi (ps_Codigo_Barras) then
			If not IsNUll (iuo_udi.is_gtin) then
				of_localiza_codigo_barras_like (iuo_udi.is_gtin)
				Return
			End if
		End if
	Finally
		Destroy iuo_udi
	End try
	
	// Faz mais uma tentativa sem considerar os zeros a esquerda
	//If Mid(ps_Codigo_Barras, 1,1) = '0' Then
		// Sergio - Feito parar tratar EAN onde $$HEX1$$e900$$ENDHEX$$ lido com zeros a esquerda e no cadastro n$$HEX1$$e300$$ENDHEX$$o esta.
		of_localiza_codigo_barras_like(ps_Codigo_Barras)
	//Else
	//	Localizado = False
	//End If
Else
	of_Localiza_Codigo_Interno(lvl_Produto)
End If
end subroutine

public subroutine of_localiza_generica (string ps_parametro);String lvs_Produto

This.ivs_Parametro = ps_Parametro

Choose Case Lower( is_Window_Selecao_Generica )
	Case ""
		If This.ivl_Filial_Parametro <> This.ivl_Filial_Matriz Then
			If gvo_aplicacao.ivo_seguranca.cd_sistema = 'CL' Then
				OpenWithParm(w_ge001_Selecao_Produto_Filial_Paf, This)
			Else
				OpenWithParm(w_ge001_Selecao_Produto_Filial, This)		
			End If
		Else
			If gvo_aplicacao.ivo_seguranca.cd_sistema = 'WS' Then
				OpenWithParm(w_ge001_Selecao_Produto_Matriz_Wms, This)
			Else
				OpenWithParm(w_ge001_Selecao_Produto_Matriz, This)
			End If
		End If
		
	Case "w_ge001_selecao_produto_filial_atendimento" // Exclusiva para a GE108_Consulta_Preco
		//OpenWithParm( w_ge001_selecao_produto_filial_atendimento, This )

	Case "w_ge001_selecao_produto_atendimento_sac" // Exclusiva para a GE103_Consulta_Preco_Filiais - SAC
		OpenWithParm( w_ge001_selecao_produto_atendimento_sac, This )		
		
End Choose

lvs_Produto = Message.StringParm

If IsNull(lvs_Produto) Then
	Localizado = False
Else
	This.of_Localiza_Codigo_Interno(Long(lvs_Produto))
End If
end subroutine

public function boolean of_inativo_loja (long pl_produto);//
String lvs_situacao
//
Select id_situacao
  Into :lvs_situacao
  From produto_loja
 Where cd_produto = :pl_produto ;
//
If SQLCA.SQLCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do produto " + String(pl_produto) + " na tabela produto loja." + SqlCa.SqlErrText, StopSign!)
	Return False
End If
//
If SQLCA.SQLCode = 100 Then
	messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Produto "+String(pl_produto) + " n$$HEX1$$e300$$ENDHEX$$o localizado na tabela produto loja.")
	Return False
End If
//
If Trim(lvs_situacao) = "I" Then
	Return True
Else
	Return False
End IF
//

end function

public function boolean of_inativo_central (long pl_produto);//
If This.cd_produto = pl_produto Then
	If This.id_situacao = "I" Then
		Return True
	Else
		Return False
	End If
End If
//
String lvs_situacao
//
Select id_situacao
  Into :lvs_situacao
  From produto_geral
 Where cd_produto = :pl_produto ;
//
If SQLCA.SQLCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do produto " + String(pl_produto) + " na tabela produto geral." + SqlCa.SqlErrText, StopSign!)
	Return False
End If
//
If SQLCA.SQLCode = 100 Then
	messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Produto "+String(pl_produto) + " n$$HEX1$$e300$$ENDHEX$$o localizado na tabela produto loja.")
	Return False
End If
//
If Trim(lvs_situacao) = "I" Then
	Return True
Else
	Return False
End IF
//


end function

public function decimal of_preco_padrao ();Decimal lvdc_Preco

lvdc_Preco = Round(This.Vl_Preco_Venda_Atual / This.Vl_Fator_Conversao, 2)

Return lvdc_Preco
end function

public function decimal of_preco_regionalizado ();Decimal lvdc_Preco

// Verifica se existe pre$$HEX1$$e700$$ENDHEX$$o regionalizado para o produto na filial
Select pr.vl_preco_venda_atual Into :lvdc_Preco
From preco_regionalizado pr,
     parametro pa
Where pr.cd_filial  = pa.cd_filial
  and pr.cd_produto = :This.Cd_Produto
Using SqlCa;
		
Choose Case SqlCa.SqlCode
	Case 0
		If lvdc_Preco > 0 Then lvdc_Preco = Round(lvdc_Preco / This.Vl_Fator_Conversao, 2)
	Case 100
		lvdc_Preco = -100
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do pre$$HEX1$$e700$$ENDHEX$$o regionalizado.")
		lvdc_Preco = -1
End Choose		

Return lvdc_Preco
end function

public function decimal of_preco_venda_filial ();Decimal lvdc_Preco

lvdc_Preco = This.of_Preco_Regionalizado()

// Verifica se existe pre$$HEX1$$e700$$ENDHEX$$o regionalizado para o produto na filial
If lvdc_Preco <= 0 Then
	lvdc_Preco = This.of_Preco_Padrao()
End If

Return lvdc_Preco
end function

public function decimal of_desconto_fixo ();Decimal lvdc_Desconto = 0

If This.Id_Tipo_Desconto_Atual <> "N" Then
	lvdc_Desconto = This.Pc_Desconto_Atual		
End If

Return lvdc_Desconto
end function

public function decimal of_desconto_negociavel ();Decimal lvdc_Desconto = 0

If This.Id_Tipo_Desconto_Atual = "N" Then
	lvdc_Desconto = This.Pc_Desconto_Atual		
End If

Return lvdc_Desconto
end function

public function decimal of_desconto_sos ();Decimal {2} lvdc_Desconto

String lvs_SQL, &
		 lvs_Tipo

lvs_Tipo = 'S'

dc_uo_ds_Base lvds_1
lvds_1 = Create dc_uo_ds_Base

If Not lvds_1.of_ChangeDataObject("dw_ge001_desconto_promocao") Then
	Destroy(lvds_1)
	Return -1
End If

If lvds_1.Retrieve(This.Cd_Produto, lvs_Tipo) > 0 Then
	This.Cd_Promocao_SOS = lvds_1.Object.Cd_Promocao_SOS[1]
	lvdc_Desconto        = lvds_1.Object.Pc_Desconto    [1]
Else
	lvdc_Desconto = -100
End If

Destroy(lvds_1)

Return lvdc_Desconto
end function

public function boolean of_tem_desconto_negociavel ();If This.Id_Tipo_Desconto_Atual = "N" Then
	Return True
Else
	Return False
End If
end function

public function decimal of_custo_medio ();Decimal {2} lvdc_Custo

If ivl_Filial_Parametro = ivl_Filial_Matriz Then

	Select vl_custo_medio Into :lvdc_Custo
	From vw_saldo_atual_produto
	Where cd_produto = :This.cd_produto
	  and cd_filial  = :ivl_Filial_Parametro
	Using Sqlca;

Else

	Select vl_custo_medio Into :lvdc_Custo
	From vw_saldo_atual_produto
	Where cd_produto = :This.cd_produto
	Using Sqlca;

End If

If Sqlca.Sqlcode = -1 Then
	Sqlca.of_MsgDbError('Erro ao localizar custo do produto : ' + String(This.cd_produto) )
	lvdc_Custo = 000.00
ElseIf Sqlca.Sqlcode = 100 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o",'Custo do produto : ' + String(This.cd_produto) + ' n$$HEX1$$e300$$ENDHEX$$o localizado.',StopSign!)
	lvdc_Custo = 000.00
Else
	If IsNull(lvdc_Custo) Then	lvdc_Custo = 000.00
End If	

Return lvdc_Custo
end function

public function decimal of_desconto_contrato_convenio (long pl_convenio, long pl_produto, date pdt_inicio);Decimal lvdc_Desconto

Select c2.pc_desconto Into :lvdc_Desconto
From contrato_preco_convenio c1,
     contrato_preco_convenio_prd c2
Where c1.cd_convenio = c2.cd_convenio
  and c1.nr_contrato = c2.nr_contrato
  and c2.cd_convenio = :pl_Convenio
  and c2.cd_produto  = :pl_Produto
  and c1.dh_inicio  <= :pdt_Inicio
  and (c1.dh_termino >= :pdt_Inicio or c1.dh_termino Is Null)
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		Return lvdc_Desconto
	Case 100
		Return -100
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do contrato de pre$$HEX1$$e700$$ENDHEX$$os." + SqlCa.SqlErrText, StopSign!)
		Return -1
End Choose
end function

public function decimal of_desconto_negociado ();Decimal lvdc_Desconto

OpenWithParm(w_ge001_desconto_negociavel, This)

lvdc_Desconto = Dec(Message.StringParm)
	
Return lvdc_Desconto


end function

public function boolean of_atualiza_desconto_padrao (date pdt_data_base);DataStore lds

Long lvl_Total_Registros, &
     lvl_Produto, &
	  lvl_Contador, &
	  lvl_Commit
			  
String lvs_Responsavel, &
       lvs_Tipo_Futuro

Decimal lvdc_Desconto_Futuro
			 
DateTime lvdh_Data_Futuro

Boolean lvb_Erro = False
		  
Open(w_ge001_Aguarde)
w_ge001_Aguarde.Title = "Atualizando Descontos Padr$$HEX1$$e300$$ENDHEX$$o... "

lds = Create DataStore
lds.DataObject = "dw_ge001_alteracao_desconto_padrao"

lds.SetTransObject(SqlCa)

lvl_Total_Registros = lds.Retrieve(pdt_Data_Base)

If lvl_Total_Registros = 0 Then 
	Close(w_ge001_Aguarde)	
	Return True
End If

w_ge001_Aguarde.uo_Progress.of_SetMax(lvl_Total_Registros)

lvl_Commit = 0

For lvl_Contador = 1 To lvl_Total_Registros
	
	lvl_Produto          			= lds.Object.Cd_Produto[lvl_Contador]
    	lvdc_Desconto_Futuro 	= lds.Object.Pc_Desconto_Futuro[lvl_Contador]
	lvdh_Data_Futuro     		= lds.Object.Dh_Desconto_Futuro[lvl_Contador]
	lvs_Responsavel      		= lds.Object.Nr_Matricula_Desconto_Futuro[lvl_Contador]
	lvs_Tipo_Futuro      		= lds.Object.Id_Tipo_Desconto_Futuro[lvl_Contador]
							
	Update produto_geral
	Set pc_desconto_atual             	= :lvdc_Desconto_Futuro,
		dh_desconto_atual 			  	= :pdt_Data_Base,
		nr_matricula_desconto_atual   	= :lvs_Responsavel,
		id_tipo_desconto_atual        	= :lvs_Tipo_Futuro
	Where cd_produto = :lvl_Produto
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro alterando desconto atual produto : " + String(lvl_Produto) + SqlCa.SqlErrText, StopSign!)
		lvb_Erro = True 
		Exit
	Else	
		Update produto_geral 
		Set pc_desconto_futuro           = null,
			 dh_desconto_futuro           = null,
			 nr_matricula_desconto_futuro = null,
			 id_tipo_desconto_futuro      = null
		Where cd_produto = :lvl_Produto
		Using Sqlca;
		
		If Sqlca.SqlCode = -1 Then								
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro alterando desconto futuro produto : " + String(lvl_Produto) + SqlCa.SqlErrText, StopSign!)								
			lvb_Erro = True
			Exit  
		End If	
		
		lvl_Commit ++
		
		IF lvl_Commit = 100 THEN
			
			Commit Using SqlCa;
 
			IF SqlCa.SqlCode = -1 THEN
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no COMMIT." + SqlCa.SqlErrText, StopSign!)
				lvb_Erro = True
				Exit
			END IF
			
			lvl_Commit = 0
			
		END IF	
		
	END IF

	w_ge001_Aguarde.uo_Progress.of_SetProgress(lvl_Contador)			
Next
	  
If Not lvb_Erro Then	
	Commit Using SqlCa;
 
	If SqlCa.SqlCode = -1 Then			
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no COMMIT." + SqlCa.SqlErrText, StopSign!)
		lvb_Erro = True
	End If		
Else	
	Rollback Using SqlCa;
	
	If Sqlca.SqlCode = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no ROLLBACK." + SqlCa.SqlErrText, StopSign!)
	End If
End If
	
Destroy(lds)
Close(w_ge001_Aguarde)

Return Not lvb_Erro
end function

public function decimal of_saldo_produto (long pl_produto);DECIMAL lvdc_Saldo_Atual
//
SELECT vw_saldo_atual_produto.qt_saldo_final  INTO :lvdc_Saldo_Atual
FROM vw_saldo_atual_produto
WHERE vw_saldo_atual_produto.cd_produto = :pl_produto;
//
IF SQLCA.Sqlcode = -1 THEN
	SQLCA.Of_MsgDbError("Saldo do Produto")
END IF	
//
IF IsNull(lvdc_Saldo_Atual) THEN lvdc_Saldo_Atual = 0
//
RETURN lvdc_Saldo_Atual


end function

public subroutine of_inicializa ();Localizado = False
ib_movimentacao_bloqueada = False

SetNull(Cd_Produto)
SetNull(cd_promocao_sos_ajuste_preco_pr)
SetNull(nr_classificacao_fiscal)
SetNull(cd_promocao_sos)
SetNull(cd_cest)
SetNull(id_permite_devolucao)
SetNull(nr_campanha)

De_Produto = ""
De_Apresentacao_Venda = ""
De_Apresentacao_Estoque = "" 
ivs_Descricao_Apresentacao_Venda = ""
ivs_Descricao_Apresentacao_Estoque = ""
De_Registro_Ms = ""
SetNull(vl_fator_conversao)
SetNull(ivs_cliente_campanha)

nr_etiqueta_preste = ""
nr_lote_preste = ""
id_situacao_preste = ""
de_especie_preste = ""
de_serie_preste = ""
nr_matricula_inclusao_preste = ""
SetNull(cd_filial_inclusao_preste)
SetNull(cd_filial_preste)
SetNull(nr_nf_preste)
SetNull(dh_validade_preste)
SetNull(dh_baixa_preste)
SetNull(cd_grupo_psico)
SetNull(qt_unidades_embalagem)
SetNull(nr_cartao_saude_desconto)

SetNull(vl_volume)
SetNull(qt_peso_apresentacao)
id_tipo_un_calc_preco=""

ids_contratos_bin = Create dc_uo_ds_base
ids_contratos_bin.reset( )

end subroutine

public function boolean of_comissionado ();String ls_auto_servico
//
Select local_estocagem.id_auto_servico Into :ls_auto_servico
From produto_loja,
     local_estocagem
Where produto_loja.cd_produto = :cd_produto
  and produto_loja.cd_local_estocagem = local_estocagem.cd_local_estocagem;
//
If SQLCA.SQLCode = -1 Then
	SQLCA.of_MsgDBError("Erro ao verificar local de estocagem do produto.")
	Return False
End If
//
If ls_auto_servico = 'S' Then
	Return False
Else
	Return True
End If


end function

protected function boolean of_atualiza_preco_padrao (date pdt_data_base);If This.ivl_Filial_Parametro = This.ivl_Filial_Matriz Then
	If This.of_Atualiza_Preco_Padrao_Matriz(pdt_Data_Base) Then
		If This.of_atualiza_preco_padrao_matriz_sap( pdt_Data_Base ) Then
			If This.of_exclui_preco_regionalizado(pdt_Data_Base) Then
				Return True
			End If
		ENd if
	End If
Else
	Return This.of_Atualiza_Preco_Padrao_Filial(pdt_Data_Base)
End If
end function

public function decimal of_desconto_filial ();Long lvl_Filial

SetNull(lvl_Filial)

Return This.of_Desconto_Filial(lvl_Filial)
end function

public subroutine of_localiza_produto (string as_parametro);This.of_Localiza_Produto(as_Parametro, True)
end subroutine

public subroutine of_localiza_produto (string as_parametro, boolean ab_generica);Integer lvi_Tamanho, i

Localizado = False

// Retira os espa$$HEX1$$e700$$ENDHEX$$os em branco
as_Parametro = Trim(as_Parametro)

// Verifica o tamanho da string recebida como par$$HEX1$$e200$$ENDHEX$$metro
lvi_Tamanho = LenA(as_Parametro)

// Verifica se foi passado um par$$HEX1$$e200$$ENDHEX$$metro
If lvi_Tamanho > 0 Then
	// Verifica se o par$$HEX1$$e200$$ENDHEX$$metro recebido $$HEX1$$e900$$ENDHEX$$ num$$HEX1$$e900$$ENDHEX$$rico
	If IsNumber(as_Parametro) Then
		If lvi_Tamanho <= 6 Then
			// Localiza$$HEX2$$e700e300$$ENDHEX$$o pelo c$$HEX1$$f300$$ENDHEX$$digo interno
			This.is_Tipo_Localizacao = 'CODIGO_INTERNO'
			This.of_Localiza_Codigo_Interno(Long(as_Parametro))
			
		ElseIf lvi_Tamanho = 8 Then
			// Localiza$$HEX2$$e700e300$$ENDHEX$$o pelo c$$HEX1$$f300$$ENDHEX$$digo de barras
			This.is_Tipo_Localizacao = 'CODIGO_BARRAS'
			This.of_Localiza_Codigo_Barras(as_Parametro)
		
			If Not Localizado Then
				// Localiza$$HEX2$$e700e300$$ENDHEX$$o pelo c$$HEX1$$f300$$ENDHEX$$digo interno
				// Primeiras 6 posi$$HEX2$$e700f500$$ENDHEX$$es
				This.is_Tipo_Localizacao = 'CODIGO_INTERNO'
				This.of_Localiza_Codigo_Interno(Long(LeftA(as_Parametro,6)))
			End If
		ElseIf lvi_Tamanho > 8 Then
			if (lvi_Tamanho = 10 or lvi_Tamanho = 13) and (left(as_parametro, 4) = '1000' or left(as_parametro, 4) = '8000') then
				This.is_Tipo_Localizacao = 'CODIGO_SAP'
				This.of_localiza_codigo_sap(as_Parametro)
			end if
			
			If Not Localizado Then
				If (lvi_Tamanho = 10) And (LeftA(as_Parametro,1) = "9") Then
					//Localiza$$HEX2$$e700e300$$ENDHEX$$o pela etique de prestes a vencer
					This.is_Tipo_Localizacao = 'ETIQUETA_PRESTES'
					This.of_Localiza_etiqueta_preste(as_Parametro)			
				Else			
					// Localiza$$HEX2$$e700e300$$ENDHEX$$o pelo c$$HEX1$$f300$$ENDHEX$$digo de barras
					This.is_Tipo_Localizacao = 'CODIGO_BARRAS'
					This.of_Localiza_Codigo_Barras(as_Parametro)
				End If
			end if
		End If
		
		// Se n$$HEX1$$e300$$ENDHEX$$o localizar pelos m$$HEX1$$e900$$ENDHEX$$todos anteriores
		// Abre a janela de localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica
		If Not Localizado Then
			This.is_Tipo_Localizacao = 'OUTRO'
			If ab_Generica Then This.of_Localiza_Generica("")
		End If
	Else // Par$$HEX1$$e200$$ENDHEX$$metro recebido $$HEX1$$e900$$ENDHEX$$ string
		
		//Registro MS
		If lvi_Tamanho = 17 And LeftA(as_Parametro, 2) = "1." Then
			// As primeiras posi$$HEX2$$e700e300$$ENDHEX$$o "1." identifica registro MS
			This.is_Tipo_Localizacao = 'REGISTRO_MS'
			This.of_Localiza_Registro_MS(as_Parametro)
			
			// Se n$$HEX1$$e300$$ENDHEX$$o localizar pelo c$$HEX1$$f300$$ENDHEX$$digo de barras
			// Abre a janela de localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica
			If Not Localizado Then
				This.is_Tipo_Localizacao = 'OUTRO'
				If ab_Generica Then This.of_Localiza_Generica("")
			End If
		ElseIf LeftA(as_Parametro, 1) = "+" Then
			// A primeira posi$$HEX2$$e700e300$$ENDHEX$$o "+" identifica c$$HEX1$$f300$$ENDHEX$$digos de barras de produtos importados
			// Localiza$$HEX2$$e700e300$$ENDHEX$$o pelo c$$HEX1$$f300$$ENDHEX$$digo de barras
			This.is_Tipo_Localizacao = 'CODIGO_BARRAS'
			This.of_Localiza_Codigo_Barras(as_Parametro)
			
			// Se n$$HEX1$$e300$$ENDHEX$$o localizar pelo c$$HEX1$$f300$$ENDHEX$$digo de barras
			// Abre a janela de localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica
			If Not Localizado Then
				This.is_Tipo_Localizacao = 'OUTRO'
				If ab_Generica Then This.of_Localiza_Generica("")
			End If
		Else
			If Len (as_Parametro) > 20 then
				// Localiza$$HEX2$$e700e300$$ENDHEX$$o pelo c$$HEX1$$f300$$ENDHEX$$digo de barras UDI
				This.is_Tipo_Localizacao = 'CODIGO_BARRAS'
				This.of_Localiza_Codigo_Barras(as_Parametro)
			else
				If not of_verifica_excecao_pesquisa () then
					// Abre a lista de produtos com a descri$$HEX2$$e700e300$$ENDHEX$$o
					// semelhante ao par$$HEX1$$e200$$ENDHEX$$metro recebido
					This.is_Tipo_Localizacao = 'OUTRO'
					This.of_Localiza_Generica(as_Parametro)
				End if
			End if
		End If
	End If
Else
	If ab_Generica Then
		// Abre a janela de localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica
		This.is_Tipo_Localizacao = 'OUTRO'
		This.of_Localiza_Generica("")
	End If
End If	
end subroutine

public function decimal of_desconto_convenio (long pl_convenio, decimal pdc_desconto_minimo);Decimal lvdc_Desconto_Contrato, &
        lvdc_Desconto_Promocao, &
		  lvdc_Desconto_Minimo  , &
        lvdc_Desconto

lvdc_Desconto_Contrato = This.of_Desconto_Contrato_Convenio(pl_Convenio)

If lvdc_Desconto_Contrato > 0 Then

	lvdc_Desconto_Promocao = This.of_Desconto_Promocao('N')
	
	If lvdc_Desconto_Promocao > 0 Then
		
		If lvdc_Desconto_Promocao > lvdc_Desconto_Contrato Then
			lvdc_Desconto = lvdc_Desconto_Promocao
		Else
			lvdc_Desconto = lvdc_Desconto_Contrato
		End If
		
		If This.Pc_Desconto_Atual > lvdc_Desconto Then
			lvdc_Desconto = This.Pc_Desconto_Atual
		End If
		
	Else
		If This.Pc_Desconto_Atual > lvdc_Desconto_Contrato Then
			lvdc_Desconto = This.Pc_Desconto_Atual
		Else
			lvdc_Desconto = lvdc_Desconto_Contrato
		End If
	End If
Else
	lvdc_Desconto = This.of_Desconto_Filial()
End If

If lvdc_Desconto < pdc_desconto_minimo Then
	lvdc_Desconto = pdc_desconto_minimo
End If

Return lvdc_Desconto
end function

public function decimal of_desconto_contrato_convenio (long pl_convenio);Decimal lvdc_Desconto

Select c2.pc_desconto Into :lvdc_Desconto
From contrato_preco_convenio c1,
     contrato_preco_convenio_prd c2,
	  parametro pa
Where c1.cd_convenio = c2.cd_convenio
  and c1.nr_contrato = c2.nr_contrato
  and c2.cd_convenio = :pl_Convenio
  and c2.cd_produto  = :This.Cd_Produto
  and c1.dh_inicio  <= pa.dh_movimentacao
  and (c1.dh_termino >= pa.dh_movimentacao or c1.dh_termino Is Null)
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		Return lvdc_Desconto
	Case 100
		Return -100
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do contrato de pre$$HEX1$$e700$$ENDHEX$$os." + SqlCa.SqlErrText, StopSign!)
		Return -1
End Choose
end function

public function decimal of_desconto_contrato_convenio_new (long pl_convenio);Long lvl_Total, &
     lvl_Contador, &
	  lvl_Contrato

Decimal lvdc_Desconto

dc_uo_ds_Base lvds
lvds = Create dc_uo_ds_Base

If Not lvds.of_ChangeDataObject("dw_ge001_lista_contrato_convenio") Then
	Destroy(lvds)
	Return -1
End If

lvl_Total = lvds.Retrieve(pl_Convenio)

If lvl_Total <= 0 Then
	Destroy(lvds)
	Return -100
End If

For lvl_Contador = 1 To lvl_Total
	lvl_Contrato = lvds.Object.Nr_Contrato[lvl_Contador]
	
	Select pc_desconto Into :lvdc_Desconto
	From contrato_preco_convenio_prd
	Where nr_contrato = :lvl_Contrato
	  and cd_convenio = :pl_Convenio
	  and cd_produto  = :This.Cd_Produto
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			Destroy(lvds)
			Return lvdc_Desconto
			
		Case 100
			
		Case -1
			SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Desconto do Contrato do Conv$$HEX1$$ea00$$ENDHEX$$nio")
			Destroy(lvds)
			Return -1
	End Choose		
Next

Destroy(lvds)
Return -100
end function

public function decimal of_desconto_clube ();DateTime ldh_Hoje

Decimal	lvdc_Desconto, &
			lvdc_Desconto_Clube
			
Long ll_Linhas

String ls_Rede_Filial

lvdc_Desconto_Clube = This.Pc_Desconto_Clube_Atual

If Not gf_Data_Parametro( ref ldh_Hoje ) Then Return 0.00

If Date( ldh_Hoje ) < Date( '01/09/2013' ) Then // Data de implanta$$HEX2$$e700e300$$ENDHEX$$o da nova estrutura
	If Upper( SqlCa.ivs_Database ) = 'ANYWHERE' Then // Para poder testar id_rede_filial sem impactar nos sistema executados no Sybase Central
		If Not gf_Rede_Filial( ref ls_Rede_Filial ) Then Return 0.00
		
		If ls_Rede_Filial <> 'DC' and ls_Rede_Filial <> 'MP' and ls_Rede_Filial <> 'CP' Then			
			lvdc_Desconto_Clube = 0.00
		End If
	End If
	
	Return lvdc_Desconto_Clube
Else
	lvdc_Desconto_Clube = 0.00
End If

dc_uo_ds_Base lvds_1
lvds_1 = Create dc_uo_ds_Base

If Not lvds_1.of_ChangeDataObject("dw_ge001_desconto_clube") Then
	Destroy(lvds_1)
	Return -1
End If

ll_Linhas = lvds_1.Retrieve( This.Cd_Produto )
If  ll_Linhas > 0 Then
	lvdc_Desconto 				= lvds_1.Object.Pc_Desconto_Clube[1]	

	If lvdc_Desconto > lvdc_Desconto_Clube Then
		lvdc_Desconto_Clube = lvdc_Desconto
		This.Cd_Promocao_SOS = lvds_1.Object.Cd_Promocao_SOS[1]		
	End If
End If

Destroy(lvds_1)

Return lvdc_Desconto_Clube
end function

public function boolean of_atualiza_preco_desconto (date adt_data_base);Boolean lvb_Sucesso = False

If This.of_Atualiza_Preco_Padrao(adt_Data_Base) Then
	If This.of_Atualiza_Preco_Regionalizado(adt_Data_Base) Then
		If This.of_Atualiza_Desconto_Padrao(adt_Data_Base) Then
			If This.of_Atualiza_Desconto_Promocao(adt_Data_Base) Then
				lvb_Sucesso = True
			End If
		End If
	End If
End If

Return lvb_Sucesso
end function

public function decimal of_desconto_promocao ();Long lvl_Filial

SetNull(lvl_Filial)

Return This.of_Desconto_Promocao("N", lvl_Filial)
end function

public function decimal of_desconto_promocao (string as_tipo_promocao, long al_filial);Decimal {2} lvdc_Desconto

Long ll_Promocao

String ls_id_novo_calculo_preco

If This.ivl_Filial_Parametro <> This.ivl_Filial_Matriz Then
	
	Select b.cd_promocao_sos, b.pc_desconto
	Into :ll_Promocao, :lvdc_Desconto
	From promocao_sos a
	Inner Join  promocao_sos_produto b 
		on b.cd_promocao_sos = a.cd_promocao_sos
	Where a.id_tipo_promocao 	= :as_tipo_promocao
	   	and a.id_situacao      		= 'L'
		and b.cd_produto			= :This.Cd_Produto
	  	and a.dh_inicio <= (select dh_movimentacao from parametro where id_parametro = '1')
	  	and (a.dh_termino >= (select dh_movimentacao from parametro where id_parametro = '1') or a.dh_termino is null)
	Order by b.pc_desconto desc
	Limit 1
	Using SqlCa;
		
Else
	
	// Utilizado na uo_ge501_preco onde foi inicializado como "S", o objetivo $$HEX1$$e900$$ENDHEX$$ considerar somente as promo$$HEX2$$e700f500$$ENDHEX$$es que podem ser utilizadas no e-commerce
	If is_somente_liberado_ecommerce  = 'S' Then
		
		If Not IsNull(cd_promocao_sos_ajuste_preco_pr) Then
		
			Select top 1 b.cd_promocao_sos, b.pc_desconto
			Into :ll_Promocao, :lvdc_Desconto
			From promocao_sos a
			Inner join promocao_sos_filial f 
				on f.cd_promocao_sos = a.cd_promocao_sos
			Inner Join  promocao_sos_produto b 
				on b.cd_promocao_sos = a.cd_promocao_sos
			Where a.id_tipo_promocao 	= :as_tipo_promocao
				and a.id_situacao      		= 'L'
				and b.cd_produto			= :This.Cd_Produto
				and f.cd_filial				= :al_Filial
				and a.cd_promocao_sos <> :cd_promocao_sos_ajuste_preco_pr
				and a.dh_inicio <= (select dh_movimentacao from parametro where id_parametro = '1')
				and (a.dh_termino >= (select dh_movimentacao from parametro where id_parametro = '1') or a.dh_termino is null)
				and coalesce(a.id_utiliza_ecommerce, 'S') = 'S'
			Order by b.pc_desconto desc
			Using SqlCa;
	
		Else
			
			Select top 1 b.cd_promocao_sos, b.pc_desconto
			Into :ll_Promocao, :lvdc_Desconto
			From promocao_sos a
			Inner join promocao_sos_filial f 
				on f.cd_promocao_sos = a.cd_promocao_sos
			Inner Join  promocao_sos_produto b 
				on b.cd_promocao_sos = a.cd_promocao_sos
			Where a.id_tipo_promocao 	= :as_tipo_promocao
				and a.id_situacao      		= 'L'
				and b.cd_produto			= :This.Cd_Produto
				and f.cd_filial				= :al_Filial
				and a.dh_inicio <= (select dh_movimentacao from parametro where id_parametro = '1')
				and (a.dh_termino >= (select dh_movimentacao from parametro where id_parametro = '1') or a.dh_termino is null)
				and coalesce(a.id_utiliza_ecommerce, 'S') = 'S'
			Order by b.pc_desconto desc
			Using SqlCa;
			
		End If	
		
	Else
		
		If Not IsNull(cd_promocao_sos_ajuste_preco_pr) Then
		
			Select top 1 b.cd_promocao_sos, b.pc_desconto
			Into :ll_Promocao, :lvdc_Desconto
			From promocao_sos a
			Inner join promocao_sos_filial f 
				on f.cd_promocao_sos = a.cd_promocao_sos
			Inner Join  promocao_sos_produto b 
				on b.cd_promocao_sos = a.cd_promocao_sos
			Where a.id_tipo_promocao 	= :as_tipo_promocao
				and a.id_situacao      		= 'L'
				and b.cd_produto			= :This.Cd_Produto
				and f.cd_filial				= :al_Filial
				and a.cd_promocao_sos <> :cd_promocao_sos_ajuste_preco_pr
				and a.dh_inicio <= (select dh_movimentacao from parametro where id_parametro = '1')
				and (a.dh_termino >= (select dh_movimentacao from parametro where id_parametro = '1') or a.dh_termino is null)
			Order by b.pc_desconto desc
			Using SqlCa;
	
		Else
			
			if Not this.of_utiliza_novo_calculo_preco_sap( al_filial, ref ls_id_novo_calculo_preco) then
				ib_erro = True
				Return -100
			End if
			
			if ls_id_novo_calculo_preco = 'S' Then
								
				select coalesce(pc_desconto, 0), cd_promocao  
				into :lvdc_Desconto, :ll_Promocao
				from preco_calculado pc 
				where cd_produto = :This.Cd_Produto 
				and cd_filial = :al_Filial 
				and id_ultimo = 'S';
				
			Else
			
				// Chamado 1636937 - Sistema gest$$HEX1$$e300$$ENDHEX$$o de filiais - busca produtos/lojas travando
				
				Select top 1 b.cd_promocao_sos, b.pc_desconto
				Into :ll_Promocao, :lvdc_Desconto
				From promocao_sos a (index idx_tipo_data_sit)
				Inner join promocao_sos_filial f 
					on f.cd_promocao_sos = a.cd_promocao_sos
				Inner Join  promocao_sos_produto b 
					on b.cd_promocao_sos = a.cd_promocao_sos
				Where a.id_tipo_promocao 	= :as_tipo_promocao
					and a.id_situacao      		= 'L'
					and b.cd_produto			= :This.Cd_Produto
					and f.cd_filial				= :al_Filial
					and a.dh_inicio <= :This.ivdh_data_parametro
					and a.dh_termino >= :This.ivdh_data_parametro
				Order by b.pc_desconto desc
				Using SqlCa;
				
			End if
			
		End If

	End If
			
End If

If SqlCa.SqlCode <> 0 Then
	If SqlCa.SqlCode = -1 Then ib_erro = True
	Return -100
End If

If lvdc_Desconto < 0 Then lvdc_Desconto = 0.00

If lvdc_Desconto > 0 Then
	This.Cd_Promocao_SOS = ll_Promocao	
End If

Return lvdc_Desconto


//dc_uo_ds_Base lvds_1
//lvds_1 = Create dc_uo_ds_Base
//
//If Not lvds_1.of_ChangeDataObject("dw_ge001_desconto_promocao") Then
//	Destroy(lvds_1)
//	Return -1
//End If
//
//If Not IsNull(al_Filial) Then	
//	If Not IsNull(cd_promocao_sos_ajuste_preco_pr) Then
//		lvds_1.of_AppendWhere("a.cd_promocao_sos not in (" + String(cd_promocao_sos_ajuste_preco_pr) +  ")")
// 	End If
//	 
//	lvs_SQL = "exists (select * from promocao_sos_filial c where c.cd_promocao_sos = a.cd_promocao_sos" + &
//							 " and c.cd_filial = " + String(al_Filial) + ")"
//	
//	lvds_1.of_AppendWhere(lvs_SQL)
//End If
//
//If lvds_1.Retrieve(This.Cd_Produto, as_Tipo_Promocao) > 0 Then
//	lvdc_Desconto        = lvds_1.Object.Pc_Desconto    [1]
//	If lvdc_Desconto > 0 Then
//		This.Cd_Promocao_SOS = lvds_1.Object.Cd_Promocao_SOS[1]		
//	End If
//Else
//	lvdc_Desconto = -100
//End If
//
//Destroy(lvds_1)
//
//Return lvdc_Desconto


end function

public function decimal of_desconto_filial (long al_filial);Decimal lvdc_Desconto_Promocao, &
        lvdc_Desconto_Filial

lvdc_Desconto_Filial = This.of_Desconto_Fixo()

lvdc_Desconto_Promocao = This.of_Desconto_Promocao("N", al_Filial)

If lvdc_Desconto_Promocao > lvdc_Desconto_Filial Then
	lvdc_Desconto_Filial = lvdc_Desconto_Promocao
End If

Return lvdc_Desconto_Filial
end function

public function decimal of_desconto_promocao (string as_tipo_promocao);Long lvl_Filial

SetNull(lvl_Filial)

Return This.of_Desconto_Promocao(as_Tipo_Promocao, lvl_Filial)
end function

public function string of_verifica_preco_bloqueado_promocao (long al_produto, date adt_parametro);String ls_Nulo

SetNull(ls_Nulo)

Return of_verifica_preco_bloqueado_promocao(al_produto, adt_parametro, ls_Nulo)


//Long lvl_Count
//
//String lvs_Bloqueado
//
//Select count(p2.cd_produto)
//Into :lvl_Count
//From promocao_sos p1, 
//	  promocao_sos_produto p2
//Where p2.cd_promocao_sos    = p1.cd_promocao_sos
//  and p1.dh_inicio 			<= :adt_parametro
//  and (p1.dh_termino is null or p1.dh_termino >= :adt_parametro)
//  and p1.id_preco_bloqueado = 'S'
//  and p1.id_situacao 		 = 'L'
//  and p2.cd_produto         =:al_produto
//Using SqlCa;
//
//Choose Case SqlCa.SqlCode
//	Case -1
//		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do produto na promo$$HEX2$$e700e300$$ENDHEX$$o")
//		lvs_Bloqueado = 'S'
//	Case  0
//		If lvl_Count > 0 Then
//			lvs_Bloqueado = 'S'
//		Else
//			lvs_Bloqueado = 'N'
//		End If
//End Choose
//
//Return lvs_Bloqueado

end function

protected function boolean of_atualiza_preco_padrao_filial (date pdt_data_base);Boolean lvb_Sucesso = True

Long lvl_Total, &
	  lvl_Contador, &
  	  lvl_Produto, &
	  lvl_Linhas_Atualizadas
			  
String lvs_Responsavel

Decimal lvdc_Preco
			 
dc_uo_ds_Base lvds
lvds = Create dc_uo_ds_Base

If Not lvds.of_ChangeDataObject("dw_ge001_alteracao_preco_padrao_filial") Then
	Destroy(lvds)
	Return False
End If

Open(w_ge001_Aguarde)
w_ge001_Aguarde.Title = "Atualizando Pre$$HEX1$$e700$$ENDHEX$$os de Venda Padr$$HEX1$$e300$$ENDHEX$$o... "

lvl_Total = lvds.Retrieve(pdt_Data_Base)

If lvl_Total = 0 Then 
	Destroy(lvds)
	Close(w_ge001_Aguarde)	
	Return True
End If

w_ge001_Aguarde.uo_Progress.of_SetMax(lvl_Total)

For lvl_Contador = 1 To lvl_Total	
	lvl_Produto     		= lvds.Object.Cd_Produto                  			[lvl_Contador]
	lvdc_Preco      		= lvds.Object.Vl_Preco_Venda_Futuro       		[lvl_Contador]
	lvs_Responsavel 	= lvds.Object.Nr_Matric_Preco_Venda_Futuro	[lvl_Contador]
	
	Update produto_geral
	Set vl_preco_venda_atual           		= :lvdc_Preco,
		 dh_preco_venda_atual 			  	= :pdt_Data_Base,
		 nr_matricula_preco_venda_atual 	= :lvs_Responsavel,
		 vl_preco_venda_futuro       		= null,
		 dh_preco_venda_futuro        		= null,
		 nr_matric_preco_venda_futuro 	= null
	Where cd_produto 						= :lvl_Produto
	Using SqlCa;

	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_RollBack()
		SqlCa.of_MsgdbError("Altera$$HEX2$$e700e300$$ENDHEX$$o do Pre$$HEX1$$e700$$ENDHEX$$o de Venda Atual/Futuro do Produto '" + String(lvl_Produto) + "'")
		gvo_Aplicacao.of_grava_log( "[ATUALIZACAO PRECO] - Erro no udate preco venda atual/futuro. Produto: '" + String(lvl_Produto) + "'" )
		lvb_Sucesso = False
		Exit
	End If

	lvl_Linhas_Atualizadas =  SqlCa.sqlnrows
	
	If lvl_Linhas_Atualizadas > 0 Then
		SqlCa.of_Commit()
	End If
	
	w_ge001_Aguarde.uo_Progress.of_SetProgress(lvl_Contador)
Next
	  
Destroy(lvds)
Close(w_ge001_Aguarde)

Return lvb_Sucesso
end function

protected function boolean of_atualiza_preco_padrao_matriz (date pdt_data_base);Boolean lvb_Sucesso = True

Long lvl_Total, &
	  lvl_Contador, &
  	  lvl_Produto
			  
String lvs_UF, &
       lvs_Responsavel

Decimal lvdc_Preco

Integer lvi_Log

lvi_Log = FileOpen("C:\Sistemas\CA\Arquivos\atualizacao_preco.log", LineMode! , Write!, LockWrite!)

gf_grava_log_basico(lvi_Log, "In$$HEX1$$ed00$$ENDHEX$$cio - " + String(Today(), "dd/mm/yyyy hh:ss"))
			 
dc_uo_ds_Base lvds
lvds = Create dc_uo_ds_Base

If Not lvds.of_ChangeDataObject("dw_ge001_alteracao_preco_padrao_matriz") Then
	Destroy(lvds)
	FileClose(lvi_Log)
	Return False
End If

Open(w_ge001_Aguarde)
w_ge001_Aguarde.Title = "Atualizando Pre$$HEX1$$e700$$ENDHEX$$os de Venda Padr$$HEX1$$e300$$ENDHEX$$o... "

lvl_Total = lvds.Retrieve(pdt_Data_Base)

If lvl_Total = 0 Then 
	
	gf_grava_log_basico(lvi_Log, "Nenhum produto foi localizado para atualiza$$HEX2$$e700e300$$ENDHEX$$o.")
	gf_grava_log_basico (lvi_Log, "T$$HEX1$$e900$$ENDHEX$$rmino - " + String(Today(), "dd/mm/yyyy hh:ss"))
	FileClose(lvi_Log)
	
	Destroy(lvds)
	Close(w_ge001_Aguarde)	
	Return True
End If

w_ge001_Aguarde.uo_Progress.of_SetMax(lvl_Total)

For lvl_Contador = 1 To lvl_Total	
	lvs_UF          = lvds.Object.Cd_Unidade_Federacao        [lvl_Contador]
	lvl_Produto     = lvds.Object.Cd_Produto                  [lvl_Contador]
	lvdc_Preco      = lvds.Object.Vl_Preco_Venda_Futuro       [lvl_Contador]
	lvs_Responsavel = lvds.Object.Nr_Matric_Preco_Venda_Futuro[lvl_Contador]
	
	If IsNull(lvs_Responsavel) Then
		lvs_Responsavel  = 'SAP001'
		gf_grava_log_basico (lvi_Log, "Aten$$HEX2$$e700e300$$ENDHEX$$o - Altera$$HEX2$$e700e300$$ENDHEX$$o do Pre$$HEX1$$e700$$ENDHEX$$o de Venda Atual do Produto '" + String(lvl_Produto) + "' - valor nulo respons$$HEX1$$e100$$ENDHEX$$vel (alterado automat. para SAP001)." )
	End If
	
	Update produto_uf
	Set vl_preco_venda_atual        = :lvdc_Preco,
		 dh_preco_venda_atual 		  = :pdt_Data_Base,
		 nr_matric_preco_venda_atual = :lvs_Responsavel
	Where cd_unidade_federacao = :lvs_UF
	  and cd_produto           = :lvl_Produto
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		gf_grava_log_basico (lvi_Log, "Erro - Altera$$HEX2$$e700e300$$ENDHEX$$o do Pre$$HEX1$$e700$$ENDHEX$$o de Venda Atual do Produto '" + String(lvl_Produto) + "' - " + SQLCA.SQLErrText )
		SqlCa.of_MsgdbError("Altera$$HEX2$$e700e300$$ENDHEX$$o do Pre$$HEX1$$e700$$ENDHEX$$o de Venda Atual do Produto '" + String(lvl_Produto) + "'")
		lvb_Sucesso = False
		Exit
	End If
	
	Update produto_uf 
	Set vl_preco_venda_futuro        = null,
		 dh_preco_venda_futuro        = null,
		 nr_matric_preco_venda_futuro = null
	Where cd_unidade_federacao = :lvs_UF
	  and cd_produto           = :lvl_Produto
	Using Sqlca;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_RollBack()
		gf_grava_log_basico (lvi_Log, "Erro - Altera$$HEX2$$e700e300$$ENDHEX$$o do Pre$$HEX1$$e700$$ENDHEX$$o de Venda Futuro do Produto '" + String(lvl_Produto) + "' - " + SQLCA.SQLErrText )
		SqlCa.of_MsgdbError("Altera$$HEX2$$e700e300$$ENDHEX$$o do Pre$$HEX1$$e700$$ENDHEX$$o de Venda Futuro do Produto '" + String(lvl_Produto) + "'")
		lvb_Sucesso = False
		Exit
	End If

	SqlCa.of_Commit()

	w_ge001_Aguarde.uo_Progress.of_SetProgress(lvl_Contador)
Next

gf_grava_log_basico (lvi_Log, "T$$HEX1$$e900$$ENDHEX$$rmino - " + String(Today(), "dd/mm/yyyy hh:ss"))
FileClose(lvi_Log)
	  	
Destroy(lvds)
Close(w_ge001_Aguarde)

Return lvb_Sucesso
end function

public function decimal of_custo_gerencial ();Decimal {2} lvdc_Custo

If ivl_Filial_Parametro = ivl_Filial_Matriz Then

	Select vl_custo_gerencial Into :lvdc_Custo
	From vw_saldo_atual_produto
	Where cd_produto = :This.cd_produto
	  and cd_filial  = :ivl_Filial_Parametro
	Using Sqlca;

Else

	Select vl_custo_gerencial Into :lvdc_Custo
	From vw_saldo_atual_produto
	Where cd_produto = :This.cd_produto
	Using Sqlca;

End If

If Sqlca.Sqlcode = -1 Then
	Sqlca.of_MsgDbError('Erro ao localizar custo gerencial do produto : ' + String(This.cd_produto) )
	lvdc_Custo = 000.00
ElseIf Sqlca.Sqlcode = 100 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o",'Custo gerencial do produto : ' + String(This.cd_produto) + ' n$$HEX1$$e300$$ENDHEX$$o localizado.',StopSign!)
	lvdc_Custo = 000.00
Else
	If IsNull(lvdc_Custo) Then	lvdc_Custo = 000.00
End If	

Return lvdc_Custo
end function

public function decimal of_preco_regionalizado (long pl_filial);Decimal lvdc_Preco

// Verifica se existe pre$$HEX1$$e700$$ENDHEX$$o regionalizado para o produto na filial
Select pr.vl_preco_venda_atual Into :lvdc_Preco
From preco_regionalizado pr
Where pr.cd_filial  = :pl_filial
  and pr.cd_produto = :This.Cd_Produto
Using SqlCa;
		
Choose Case SqlCa.SqlCode
	Case 0
		If lvdc_Preco > 0 Then lvdc_Preco = Round(lvdc_Preco / This.Vl_Fator_Conversao, 2)
	Case 100
		lvdc_Preco = -100
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do pre$$HEX1$$e700$$ENDHEX$$o regionalizado.")
		lvdc_Preco = -1
End Choose		

Return lvdc_Preco
end function

public subroutine of_localiza_registro_ms (string ps_registro_ms);Long lvl_Produto

String lvs_Registro

lvs_Registro = MidA(ps_Registro_MS, 1, 1) + &
					MidA(ps_Registro_MS, 3, 4) + &
					MidA(ps_Registro_MS, 8, 4) + &
					MidA(ps_Registro_MS, 13, 3) + &
					MidA(ps_Registro_MS, 17, 1)

Select cd_produto
  Into :lvl_Produto
From produto_geral
Where de_registro_ms = :lvs_Registro
Using SqlCa;
	
If SqlCa.SqlCode = 100 Then
	Localizado = False
Else
	of_Localiza_Codigo_Interno(lvl_Produto)
End If
end subroutine

public function long of_valida_lote (long pl_produto, string ps_lote, ref long pl_quantidade, ref DataStore pds_lote);String ls_lote

Long   ll_quantidade
Long   ll_linhas
Long   ll_row

dc_uo_ds_base lds_saldo
lds_Saldo = Create dc_uo_ds_base

If Not lds_Saldo.of_ChangeDataObject("dw_ge001_saldo_produto_lote") Then Return -1

pds_lote = lds_Saldo

ll_linhas = lds_Saldo.Retrieve(pl_produto)

//Nenhum Lote encontrado para o produto
If ll_linhas = 0 Then Return 100

ll_row = lds_Saldo.Find("nr_lote = '" + ps_lote + "'",1,lds_Saldo.RowCount())

If ll_row > 0 Then
	ll_quantidade = lds_Saldo.object.qt_lote[ll_row]
	Return 1
Else
	ll_quantidade = 0
	Return 0
End If
end function

public function boolean of_verifica_promocao_vencimento ();Long ll_Promocao 

Select Count(*) Into :ll_Promocao
  From promocao_vencimento,
       parametro
Where ( parametro.dh_movimentacao >= promocao_vencimento.dh_inicio )
  and ( promocao_vencimento.dh_termino is null or promocao_vencimento.dh_termino <= parametro.dh_movimentacao )
Using Sqlca;

If Sqlca.Sqlcode = -1 Then
	Sqlca.of_MsgDbError("Verifica$$HEX2$$e700e300$$ENDHEX$$o Promo$$HEX2$$e700e300$$ENDHEX$$o Vencimento")
	Return False
End If

If IsNull(ll_Promocao) or ll_Promocao = 0 Then Return False

Return True

end function

public function boolean of_grupo_produto (ref string ps_grupo);
If IsNull(ps_grupo) or Trim(ps_Grupo) = "" Then Return True

String ls_Grupo

Select vw_classificacao_produto.cd_grupo Into :ls_Grupo
 From produto_geral,
		vw_classificacao_produto
Where produto_geral.cd_produto = :This.cd_produto
  and produto_geral.cd_subcategoria = vw_classificacao_produto.cd_subcategoria
Using Sqlca;

If Sqlca.Sqlcode = -1 Then
	Sqlca.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o Grupo Produto")
	Return False
End If

If ls_Grupo <> ps_grupo Then Return False

Return True

end function

public function boolean of_periodo_promocao_sos (ref datetime adt_inicio, ref datetime adt_fim);Select dh_inicio,   
	   dh_termino  
Into :adt_Inicio,
	 :adt_Fim
From promocao_sos
Where cd_promocao_sos = :This.cd_promocao_sos
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Promo$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o cadastrada.")
		Return False
	Case -1
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da promo$$HEX2$$e700e300$$ENDHEX$$o SOS '" + String(This.cd_promocao_sos) + "'")
		Return False
End Choose

Return True
end function

public function decimal of_preco_venda_filial_matriz (long pl_filial);Decimal lvdc_Preco
Decimal lvdc_Preco_Clube

String ls_id_usa_novo_preco

If Not this.of_utiliza_novo_calculo_preco_sap( pl_filial, ref ls_id_usa_novo_preco) Then return -1

If ls_id_usa_novo_preco = 'S' Then

	If Not this.of_preco_venda_filial_matriz_novo( pl_filial, ref lvdc_Preco, ref lvdc_Preco_Clube) Then return -1

Else
	
	lvdc_Preco = This.of_Preco_Regionalizado(pl_filial)
	
	// Verifica se existe pre$$HEX1$$e700$$ENDHEX$$o regionalizado para o produto na filial
	If lvdc_Preco <= 0 Then
		lvdc_Preco = This.of_Preco_Padrao_Filial_Matriz(pl_Filial)
	End If

End if

vl_preco_venda = lvdc_Preco
vl_Preco_Clube = lvdc_Preco_Clube

Return lvdc_Preco

end function

public function decimal of_preco_padrao_filial_matriz (long pl_filial);Decimal lvdc_Preco, lvdc_Preco_Venda_Atual

Select vl_preco_venda_atual
Into :lvdc_Preco_Venda_Atual
From produto_uf
Where cd_produto = :This.cd_produto
  and cd_unidade_federacao in (Select cd_unidade_federacao 
  							   From cidade c, filial f
							   Where f.cd_cidade	= c.cd_cidade
							   	 and f.cd_filial	= :pl_Filial)
Using SqlCa;

Choose Case SqlCa.SqlCode 
	Case 0
		lvdc_Preco = Round(lvdc_Preco_Venda_Atual / This.Vl_Fator_Conversao, 2)
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto uf '" + String(This.cd_produto) + "' n$$HEX1$$e300$$ENDHEX$$o foi localizado.")
		lvdc_Preco = 0
	Case -1
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do produto uf[2]")
		lvdc_Preco = 0
End Choose

Return lvdc_Preco
end function

public function decimal of_preco_venda_filial_old (long pl_filial);Decimal lvdc_Preco

lvdc_Preco = This.of_Preco_Regionalizado(pl_filial)

// Verifica se existe pre$$HEX1$$e700$$ENDHEX$$o regionalizado para o produto na filial
If lvdc_Preco <= 0 Then
	lvdc_Preco = This.of_Preco_Padrao()
End If

Return lvdc_Preco
end function

public function decimal of_desconto_campanha (string pl_cliente);Decimal lvdc_Desconto
Long ll_campanha

//N$$HEX1$$e300$$ENDHEX$$o localizar desconto de campanha do tipo CUPOM DESCONTO ( VALE DESCONTO )

Select max(cp.pc_desconto), cp.nr_campanha Into :lvdc_Desconto, :ll_campanha
From campanha_produto cp
	inner join parametro p on p.id_parametro = '1'
	inner join campanha ca on ca.nr_campanha = cp.nr_campanha
					  and ca.dh_inicio <= p.dh_movimentacao
					  and (ca.dh_termino >= p.dh_movimentacao or ca.dh_termino Is Null)
	inner join campanha_cliente c on c.nr_campanha = ca.nr_campanha
						and c.cd_cliente = :pl_cliente
where (cp.cd_produto = :This.Cd_Produto Or cp.cd_produto = 0)
	and ca.id_tipo_campanha <> 'CD'
  group by cp.nr_campanha
  order by max(cp.pc_desconto) desc
  limit 1
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		This.nr_campanha = ll_campanha
		
	Case 100
		lvdc_Desconto = -100
		SetNull(This.nr_campanha)
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Desconto Campanha.")
		lvdc_Desconto = -1
		SetNull(This.nr_campanha)
End Choose

Return lvdc_Desconto
end function

public function decimal of_desconto_filial (long al_filial, string as_tipo_promocao);Decimal lvdc_Desconto_Promocao, &
        lvdc_Desconto_Filial

lvdc_Desconto_Filial = This.of_Desconto_Fixo()

lvdc_Desconto_Promocao = This.of_Desconto_Promocao(as_tipo_promocao, al_Filial)

If lvdc_Desconto_Promocao > lvdc_Desconto_Filial Then
	lvdc_Desconto_Filial = lvdc_Desconto_Promocao
End If

Return lvdc_Desconto_Filial
end function

public function decimal of_desconto_clube_filial (long pl_filial);String ls_id_usa_novo_preco_sap

DateTime ldh_Hoje

Decimal	lvdc_Perc_Desconto_Clube, lvdc_valor_desconto_clube, lvdc_preco_venda, lvdc_valor_desconto, lvdc_valor_perc_clube
			
Long ll_Linhas

if Not this.of_utiliza_novo_calculo_preco_sap( pl_filial, ref ls_id_usa_novo_preco_sap ) Then return -1

if ls_id_usa_novo_preco_sap = 'S' Then
	
	if Not this.of_Desconto_clube_filial_sap_novo( pl_filial, ref lvdc_Perc_Desconto_Clube) Then return -1
	
Else

	dc_uo_ds_Base lvds_1
	lvds_1 = Create dc_uo_ds_Base
	
	If Not lvds_1.of_ChangeDataObject("dw_ge001_desconto_clube_filial") Then
		Destroy(lvds_1)
		Return -1
	End If
	
	// Utilizado na uo_ge501_preco onde foi inicializado como "S", o objetivo $$HEX1$$e900$$ENDHEX$$ considerar somente as promo$$HEX2$$e700f500$$ENDHEX$$es que podem ser utilizadas no e-commerce
	If is_somente_liberado_ecommerce = 'S' Then
		lvds_1.of_appendwhere("coalesce(p.id_utiliza_ecommerce, 'S') = 'S'")
	End If
	
	ll_Linhas = lvds_1.Retrieve( This.Cd_Produto, pl_Filial )
	
	If  ll_Linhas > 0 Then
		lvdc_Perc_Desconto_Clube =  lvds_1.Object.Pc_Desconto_Clube[1]
		This.Cd_Promocao_SOS = lvds_1.Object.Cd_Promocao_SOS[1]		
	End If
	
	Destroy(lvds_1)

ENd if

Return lvdc_Perc_Desconto_Clube
end function

protected function boolean of_atualiza_preco_regionalizado (date pdt_data_base);Long lvl_Total_Registros, &
  	  lvl_Produto, &
	  lvl_Contador, &
	  lvl_Commit, &
	  lvl_Filial
			  
String lvs_Responsavel

Decimal lvdc_Preco_Futuro
			 
DateTime lvdh_Data_Futuro

Boolean lvb_Erro = False

Open(w_ge001_Aguarde)
w_ge001_Aguarde.Title = "Atualizando Pre$$HEX1$$e700$$ENDHEX$$os de Venda Regionalizados... "

DataStore lds
lds = Create DataStore
lds.DataObject = "dw_ge001_alteracao_preco_regionalizado"

lds.SetTransObject(SqlCa)

lvl_Total_Registros = lds.Retrieve(pdt_Data_Base)

If lvl_Total_Registros = 0 Then 
	Close(w_ge001_Aguarde)	
	Return True
End If

w_ge001_Aguarde.uo_Progress.of_SetMax(lvl_Total_Registros)

lvl_Commit = 0

For lvl_Contador = 1 To lvl_Total_Registros
	
	lvl_Filial        = lds.Object.Cd_Filial[lvl_Contador] 
	lvl_Produto       = lds.Object.Cd_Produto[lvl_Contador]
	lvdc_Preco_Futuro = lds.Object.vl_preco_venda_futuro[lvl_Contador]
	lvdh_Data_Futuro  = lds.Object.dh_preco_venda_futuro[lvl_Contador]
	lvs_Responsavel   = lds.Object.nr_matric_preco_venda_futuro[lvl_Contador]
	
	Update preco_regionalizado
	Set vl_preco_venda_atual        = :lvdc_Preco_Futuro,
		 dh_preco_venda_atual  		  = :pdt_Data_Base,
		 nr_matric_preco_venda_atual = :lvs_Responsavel,
		 vl_preco_clube_atual = vl_preco_clube_futuro
	Where cd_filial = :lvl_Filial
	  And cd_produto = :lvl_Produto
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro alterando pre$$HEX1$$e700$$ENDHEX$$o regionalizado atual do produto : " + String(lvl_Produto) + SqlCa.SqlErrText, StopSign!)
		lvb_Erro = True					
		Exit
	Else
		Update preco_regionalizado
		Set vl_preco_venda_futuro        = null,
			 dh_preco_venda_futuro        = null,
			 nr_matric_preco_venda_futuro = null,
			 vl_preco_clube_futuro = null
		Where cd_filial = :lvl_Filial
		  And cd_produto = :lvl_Produto
		Using Sqlca;
		
		If Sqlca.SqlCode = -1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro alterando pre$$HEX1$$e700$$ENDHEX$$o regionalizado futuro do produto : " + String(lvl_Produto) + SqlCa.SqlErrText, StopSign!)
			lvb_Erro = True
			Exit  
		End If			
		
		lvl_Commit ++
		
		IF lvl_Commit = 100 THEN
			
			Commit Using SqlCa;
 
			IF SqlCa.SqlCode = -1 THEN
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no COMMIT." + SqlCa.SqlErrText, StopSign!)
				lvb_Erro = True
				Exit
			END IF
			
			lvl_Commit = 0
			
		END IF	

	END IF

	w_ge001_Aguarde.uo_Progress.of_SetProgress(lvl_Contador)
Next
	  
If Not lvb_Erro Then	
	Commit Using SqlCa;
 
	If SqlCa.SqlCode = -1 Then			
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no COMMIT." + SqlCa.SqlErrText, StopSign!)
		lvb_Erro = True
	End If		
Else	
	Rollback Using SqlCa;
	
	If Sqlca.SqlCode = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no ROLLBACK." + SqlCa.SqlErrText, StopSign!)
	End If
End If
	
Destroy(lds)
Close(w_ge001_Aguarde)

Return Not lvb_Erro
end function

public function boolean of_atualiza_desconto_promocao (date adt_data_base);Long lvl_Total, &
     lvl_Contador, &
	  lvl_Produto, &
	  lvl_Promocao
	  
Decimal lvdc_Desconto

// Esta rotina deve ser executada somente nas filiais
If ivl_Filial_Parametro = ivl_Filial_Matriz Then Return True

dc_uo_ds_Base lvds
lvds = Create dc_uo_ds_Base

If Not lvds.of_ChangeDataObject("dw_ge001_alteracao_desconto_promocao") Then
	Destroy(lvds)
	Return False
End If

/*
  Esta DW seleciona:
  - primeiramente os produtos com desconto promocional cadastrado 
    que n$$HEX1$$e300$$ENDHEX$$o possuem nenhuma promo$$HEX2$$e700e300$$ENDHEX$$o vigente

  - promo$$HEX2$$e700f500$$ENDHEX$$es vigentes para:
  	 - produtos sem desconto promocional cadastrado
    - produtos cujo desconto promocional cadastrado seja menor que um outro vigente
	 - produtos cujo desconto promocional cadastrado seja maior que um outro vigente
	   mas que a promo$$HEX2$$e700e300$$ENDHEX$$o cadastrada n$$HEX1$$e300$$ENDHEX$$o esteja mais vigente
	 - produtos cujo desconto promocional cadastrado tenha sido alterado para um percentual
	   menor que um outro vigente
*/

Open(w_Aguarde)
w_Aguarde.Title = "Verificando Descontos Promocionais..."

lvl_Total = lvds.Retrieve()

If lvl_Total > 0 Then
	w_Aguarde.Title = "Atualizando Descontos Promocionais..."
	
	w_Aguarde.uo_Progress.of_SetMax(lvl_Total)
	
	For lvl_Contador = 1 To lvl_Total
		lvl_Produto   = lvds.Object.Cd_Produto     [lvl_Contador]	
		lvdc_Desconto = lvds.Object.Pc_Desconto    [lvl_Contador]	
		lvl_Promocao  = lvds.Object.Cd_Promocao_SOS[lvl_Contador]	
		
		If IsNull(lvl_Promocao) Then
			Update produto_loja
			Set pc_desconto_promocao = null,
				 dh_desconto_promocao = :adt_Data_Base,
				 cd_promocao_sos      = null
			Where cd_produto = :lvl_Produto
			Using SqlCa;
		Else
			Update produto_loja
			Set pc_desconto_promocao = :lvdc_Desconto,
				 dh_desconto_promocao = :adt_Data_Base,
				 cd_promocao_sos      = :lvl_Promocao
			Where cd_produto = :lvl_Produto
			Using SqlCa;			
		End If
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgdbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do Desconto Promocional do Produto '" + String(lvl_Produto) + "'")
		Else
			SqlCa.of_Commit()
		End If
		
		w_Aguarde.uo_Progress.of_SetProgress(lvl_Contador)
	Next
End If

Destroy(lvds)
Close(w_Aguarde)

Return True
end function

public function boolean of_localiza_codigo_interno (long pl_produto);Long ll_Categoria_Bloqueada

String lvs_Liberado_Filial
String ls_Categoria

ib_erro = False

If pl_Produto = 0 Then
	Localizado = False		
	Return Localizado
End If

// O select est$$HEX1$$e100$$ENDHEX$$ separado porque somente a filial possui a coluna "vl_preco_venda_maximo"
If This.ivl_Filial_Parametro <> This.ivl_Filial_Matriz Then
	// Filial	
	Select cd_produto,
			 de_produto, 
			 de_apresentacao_venda,
			 de_apresentacao_estoque,
			 cd_unidade_medida_compra,
			 cd_unidade_medida_venda,
			 cd_grupo_produto,
			 cd_subgrupo_produto,
			 id_caderno_abcfarma,
			 cd_origem_produto,			 
			 cd_tributacao_icms,
			 pc_reducao_base_icms,
			 pc_desconto_atual,
			 de_codigo_barras,
			 vl_preco_venda_atual,
			 pc_comissao_extra,
			 vl_fator_conversao,
			 id_situacao,
			 cd_grupo_psico, 
			 id_liberado_filial,
			 id_tipo_desconto_atual,
			 id_preco_bloqueado,
			 id_cartao_genio,
			 id_situacao_pis_cofins,
			 cd_fornecedor_usual,
			 dh_preco_venda_atual, 
			 cd_subcategoria,
			 vl_ponto_clube,
			 qt_pontos_resgate,
			 pc_desconto_clube_atual,
			 id_utiliza_vale_resgate,
			 cd_tipo_icms,
			 vl_preco_venda_maximo,
			 cd_linha_produto,
			 id_apresentacao,
			 qt_concentracao,
			 id_recuperacao_vencido,
			 id_lei_generico,
			 nr_classificacao_fiscal,
			 coalesce(id_farmacia_popular,'N'),
			 pc_imposto_cupom,
			 id_gratis_farm_popular,
			 de_descricao_internet,
			 cd_tributacao_produto,
			 de_registro_ms,
			 coalesce(cd_st_origem, '0'),
			 coalesce(pc_ipi,0.00),
			 id_promover_venda AS id_promover_venda,
			 cd_cest,
			 coalesce( id_permite_devolucao, 'N' ),
			 coalesce(id_contem_acucar, 'N'),
			 coalesce(id_contem_gluten, 'N'),
			 coalesce(id_contem_lactose, 'N'),
			 vl_reembolso_fpb,
			 qt_unidades_embalagem,
			 coalesce(id_geladeira, 'N'),
			 cd_produto_sap,
			 0,
			 vl_volume,
			 qt_peso_apresentacao,
			 id_tipo_un_calc_preco,
			 qt_comprimento
	Into :Cd_Produto,
		  :De_Produto,
		 :De_Apresentacao_Venda,
		 :De_Apresentacao_Estoque,
		 :Cd_Unidade_Medida_Compra,
		 :Cd_Unidade_Medida_Venda,
		 :Cd_Grupo_Produto,
		 :Cd_SubGrupo_Produto,
		 :Id_Caderno_AbcFarma,
		 :Cd_Origem_Produto,		 
		 :Cd_Tributacao_ICMS,
		 :Pc_Reducao_base_ICMS,
		 :pc_desconto_atual,
		 :de_codigo_barras,
		 :vl_preco_venda_atual,
		 :pc_comissao_extra,
		 :vl_fator_conversao,
		 :id_situacao,
		 :cd_grupo_psico, 
		 :lvs_Liberado_Filial,
		 :id_tipo_desconto_atual,
		 :id_preco_bloqueado,
		 :id_cartao_genio,
		 :id_situacao_pis_cofins,
		 :cd_fornecedor_usual,
		 :dh_preco_venda_atual,
		 :cd_subcategoria,
		 :vl_ponto_clube,
		 :qt_pontos_resgate,
		 :pc_desconto_clube_atual,
		 :id_utiliza_vale_resgate,
		 :cd_tipo_icms,
		 :vl_preco_venda_maximo,
		 :cd_linha_produto,
		 :id_apresentacao,
		 :qt_concentracao,
		 :id_recuperacao_vencido,
		 :id_lei_generico,
		 :nr_classificacao_fiscal, &
		 :id_farmacia_popular,
		 :pc_imposto_cupom,
		 :id_gratis_farm_popular,
		 :de_descricao_internet,
		 :cd_tributacao_produto,
		 :de_registro_ms,
		 :cd_st_origem,
		 :pc_ipi,
		 :id_promover_venda,
		 :cd_cest,
		 :id_Permite_Devolucao,
		 :id_contem_acucar,
		 :id_contem_gluten,
		 :id_contem_lactose,
		 :vl_reembolso_fpb,
		 :qt_unidades_embalagem,
		 :id_geladeira,
		 :cd_produto_sap,
		 :vl_preco_medio_ponderado_cf,
		 :vl_volume,
		 :qt_peso_apresentacao,
		 :id_tipo_un_calc_preco,
		 :qt_comprimento
	From produto_geral
	Where cd_produto = :pl_Produto
	and (cd_produto_sap is not null and Trim(cd_produto_sap) <> '')
	Using SqlCa;
Else
	// Matriz
	Select g.cd_produto,
			 g.de_produto, 
			 g.de_apresentacao_venda,
			 g.de_apresentacao_estoque,
			 g.cd_unidade_medida_compra,
			 g.cd_unidade_medida_venda,
			 g.cd_grupo_produto,
			 g.cd_subgrupo_produto,
			 g.id_caderno_abcfarma,
			 g.cd_origem_produto,
			 g.cd_tributacao_icms,
			 g.pc_reducao_base_icms,
			 g.pc_desconto_atual,
			 g.de_codigo_barras,
			 g.vl_preco_venda_atual,
			 g.pc_comissao_extra,
			 g.vl_fator_conversao,
			 g.id_situacao,
			 g.cd_grupo_psico, 
			 g.id_liberado_filial,
			 g.id_tipo_desconto_atual,
			 g.id_preco_bloqueado,
			 g.id_cartao_genio,
			 g.id_situacao_pis_cofins,
			 g.cd_fornecedor_usual,
			 g.dh_preco_venda_atual, 
			 g.cd_subcategoria,
			 g.vl_ponto_clube,
			 g.qt_pontos_resgate,
			 g.pc_desconto_clube_atual,
			 g.id_utiliza_vale_resgate,
			 g.cd_tipo_icms,
			 g.cd_linha_produto,
			 g.id_apresentacao,
			 g.qt_concentracao,
			 g.de_descricao_internet,
			 g.de_principal_internet,
			 g.qt_peso_grama,
			 g.id_liberado_ecommerce,
			 g.id_liberado_ecommerce_dc,
			 g.id_liberado_ecommerce_mp,
			 g.id_lei_generico,
			 g.nr_classificacao_fiscal,
			 coalesce(g.id_farmacia_popular,'N'),
			 g.pc_imposto_cupom,
			 g.id_gratis_farm_popular,
			 g.cd_tributacao_produto,
			 g.de_registro_ms,
			 g.cd_planograma,
			 coalesce(g.cd_st_origem, '0'),
			 SubString(c.cd_local_estocagem,1,1) cd_local_estocagem,
			 coalesce(g.pc_ipi,0.00),
			 id_promover_venda AS id_promover_venda,
			 g.cd_cest,
			 coalesce( g.id_permite_devolucao, 'N' ),
			 coalesce(id_contem_acucar, 'N'),
			 coalesce(id_contem_gluten, 'N'),
			 coalesce(id_contem_lactose, 'N'),
			 coalesce(c.id_exclusivo_pedido_falta_ba, 'N'),
			 c.nr_matricula_comprador,
			 g.vl_reembolso_fpb,
			 g.qt_unidades_embalagem,
			 coalesce(g.id_geladeira, 'N'),
			 g.cd_produto_sap,
			 g.id_liberado_ecommerce_pp,
			 pu.vl_preco_medio_ponderado_cf,
			 g.vl_volume,
			 c.qt_peso_apresentacao,
			 c.id_tipo_un_calc_preco,
			 g.qt_comprimento
	Into :Cd_Produto,
		 :De_Produto,
		 :De_Apresentacao_Venda,
		 :De_Apresentacao_Estoque,
		 :Cd_Unidade_Medida_Compra,
		 :Cd_Unidade_Medida_Venda,
		 :Cd_Grupo_Produto,
		 :Cd_SubGrupo_Produto,
		 :Id_Caderno_AbcFarma,
		 :Cd_Origem_Produto,
		 :Cd_Tributacao_ICMS,
		 :Pc_Reducao_base_ICMS,
		 :pc_desconto_atual,
		 :de_codigo_barras,
		 :vl_preco_venda_atual,
		 :pc_comissao_extra,
		 :vl_fator_conversao,
		 :id_situacao,
		 :cd_grupo_psico, 
		 :lvs_Liberado_Filial,
		 :id_tipo_desconto_atual,
		 :id_preco_bloqueado,
		 :id_cartao_genio,
		 :id_situacao_pis_cofins,
		 :cd_fornecedor_usual,
		 :dh_preco_venda_atual,
		 :cd_subcategoria,
		 :vl_ponto_clube,
		 :qt_pontos_resgate,
		 :pc_desconto_clube_atual,
		 :id_utiliza_vale_resgate,
		 :cd_tipo_icms,
		 :cd_linha_produto,
		 :id_apresentacao,
		 :qt_concentracao,
		 :de_descricao_internet,
		 :de_principal_internet,
		 :qt_peso_grama,
		 :id_liberado_ecommerce,
		 :id_liberado_ecommerce_dc,
		 :id_liberado_ecommerce_mp,
		 :id_lei_generico,
		 :nr_classificacao_fiscal,
		 :id_farmacia_popular,
		 :pc_imposto_cupom,
		 :id_gratis_farm_popular,
		 :cd_tributacao_produto,
		 :de_registro_ms,
		 :cd_planograma,
		 :cd_st_origem,
		 :cd_local_estocagem,
		 :pc_ipi,
		 :id_promover_venda,
		 :cd_cest,
		 :id_permite_devolucao,
		 :id_contem_acucar,
		 :id_contem_gluten,
		 :id_contem_lactose,
		 :id_exclusivo_pedido_falta_ba,
		 :nr_matricula_comprador,
		 :vl_reembolso_fpb,
		 :qt_unidades_embalagem,
		 :id_geladeira,
		 :cd_produto_sap,
		 :id_liberado_ecommerce_PP,
		 :vl_preco_medio_ponderado_cf,
		 :vl_volume,
		 :qt_peso_apresentacao,
		 :id_tipo_un_calc_preco,
		 :qt_comprimento
	From produto_geral g
		LEFT OUTER JOIN produto_central c
			ON c.cd_produto = g.cd_produto
		LEFT OUTER JOIN produto_uf pu
			ON pu.cd_produto = g.cd_produto
			AND pu.cd_unidade_federacao = 'SC'
	Where  g.cd_produto = :pl_Produto
	Using SqlCa;
End If	

// Foi colocado o inner join porque na base DESENVOLVIMENTO alguns produtos n$$HEX1$$e300$$ENDHEX$$o existem  na produto_central

Choose Case SqlCa.SqlCode	
	Case 100
		Localizado = False
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do produto." + SqlCa.SqlErrText, StopSign!, Ok!)
		Localizado = False
	Case 0
		If This.Vl_Preco_Venda_Maximo = 0 Then SetNull(This.Vl_Preco_Venda_Maximo)
		If This.Vl_Preco_Medio_Ponderado_CF = 0 Then SetNull(This.Vl_Preco_Medio_Ponderado_CF)
		
		If IsNull(This.Id_Tipo_Desconto_Atual) Then This.Id_Tipo_Desconto_Atual = ""
		
		If IsNull(This.Id_Situacao_PIS_COFINS) or This.Id_Situacao_PIS_COFINS = "" Then 
			This.Id_Situacao_PIS_COFINS = "O"
		End If
						
		// Este par$$HEX1$$e200$$ENDHEX$$metro $$HEX1$$e900$$ENDHEX$$ utilizado nas telas onde $$HEX1$$e900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio validar se a movimenta$$HEX2$$e700e300$$ENDHEX$$o esta liberada, por exemplo, tela de or$$HEX1$$e700$$ENDHEX$$amento de venda
		If Not ivb_Nao_Liberado_Filial Then
			// Filial
			If (This.ivl_Filial_Parametro <> This.ivl_Filial_Matriz) and (lvs_Liberado_Filial = 'S') Then 
			
				ls_Categoria =  MidA(cd_subcategoria, 1, 6)
				
				Select count(*)
				Into :ll_Categoria_Bloqueada
				From parametro_loja
				Where cd_parametro = 'CD_CATEGORIA_PRD_MOVIMENTACAO_BLOQUEADA'
					 and vl_parametro like  '%' + :ls_Categoria + '%'
				Using SqlCa;
				
				If SqlCa.SqlCode = -1 Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do produto." + SqlCa.SqlErrText, StopSign!, Ok!)
					Localizado = False
					Return Localizado
				End If
				
				//If ll_Categoria_Bloqueada > 0 Then lvs_Liberado_Filial = 'N'
				
				This.ib_movimentacao_bloqueada = ( ll_Categoria_Bloqueada > 0 )
			End If
			
			/*If lvs_Liberado_Filial = "N" Then
				
				If ll_Categoria_Bloqueada > 0 Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto [" + String(This.Cd_Produto) + "] da categoria [" + ls_Categoria + "] n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ liberado para movimenta$$HEX2$$e700e300$$ENDHEX$$o na filial.", Information!, Ok!)
				Else
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto [" + String(This.Cd_Produto) + "] n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ liberado para movimenta$$HEX2$$e700e300$$ENDHEX$$o na filial.", Information!, Ok!)
				End If
				
				SetNull(This.Cd_Produto)
				Localizado = False		
				Return Localizado
			End If		
			*/
		End If

		If ivb_Produto_Resgate_Clube Then
			If IsNull(This.Qt_Pontos_Resgate) or This.Qt_Pontos_Resgate <= 0  Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto " + String(This.Cd_Produto) + " n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ liberado para resgate do clube.", Information!, Ok!)
				SetNull(This.Cd_Produto)
				Localizado = False		
				Return Localizado
			End If			
		End If
		
		//Chamado 984057
		ivs_Descricao_Apresentacao_Venda   = Trim(De_Produto) + " " + &
														 Trim(De_Apresentacao_Venda)
														 
		IF NOT IsNull(cd_grupo_psico) THEN ivs_Descricao_Apresentacao_Venda += " (" + String(cd_grupo_psico) + ")"
		
		//Chamado 984057
		ivs_Descricao_Apresentacao_Estoque = Trim(De_Produto) + " " + &
														 Trim(De_Apresentacao_Estoque)
			
		Localizado = True
		
		If This.is_Tipo_Localizacao <> 'ETIQUETA_PRESTES' Then
			This.of_Localiza_Etiqueta_Preste( '' )
		End If
		
End Choose

Return Localizado
end function

public subroutine of_localiza_etiqueta_preste (string ps_etiqueta);If This.is_Tipo_Localizacao <> 'ETIQUETA_PRESTES' Then
	SetNull( This.nr_etiqueta_preste )
	SetNull( This.nr_lote_preste )
	SetNull( This.dh_validade_preste )
	SetNull( This.id_situacao_preste )
	SetNull( This.cd_filial_inclusao_preste )
	SetNull( This.cd_filial_preste )
	SetNull( This.nr_nf_preste )
	SetNull( This.de_especie_preste )
	SetNull( This.de_serie_preste )
	SetNull( This.nr_matricula_inclusao_preste )
	SetNull( This.dh_baixa_preste )
	
	Return
End If

Long lvl_Produto

Select nr_etiqueta,
		cd_produto, 
		nr_lote, 
		dh_validade, 
		id_situacao,
		cd_filial_inclusao,
		cd_filial, 
		nr_nf,
		de_especie,
		de_serie,
		nr_matricula_inclusao,
		dh_baixa,
		coalesce(id_concede_desconto,'S')
		Into
		:nr_etiqueta_preste,
		:lvl_Produto,
		:nr_lote_preste,
		:dh_validade_preste,
		:id_situacao_preste,
		:cd_filial_inclusao_preste,
		:cd_filial_preste,
		:nr_nf_preste,
		:de_especie_preste,
		:de_serie_preste,
		:nr_matricula_inclusao_preste,
		:dh_baixa_preste,
		:id_concede_desconto
From produto_preste_a_vencer
Where nr_etiqueta = :ps_etiqueta
Using SqlCa;
	
If SqlCa.SqlCode = 100 Then
	Localizado = False
Else
	of_Localiza_Codigo_Interno(lvl_Produto)
End If
end subroutine

public function decimal of_desconto_etiqueta_preste ();//Fun$$HEX2$$e700e300$$ENDHEX$$o que retorna o percentual de desconto para etiqueta de prestes informada
//Antes de chamar a fun$$HEX2$$e700e300$$ENDHEX$$o, as informa$$HEX2$$e700f500$$ENDHEX$$es de preste da etiqueta j$$HEX1$$e100$$ENDHEX$$ devem estar carregadas no objeto
Decimal {2} lvdc_Desconto = 0.00
 
Datetime ldh_Movto

Date ldt_data
Date ldt_Mes

Long ll_promocao

String ls_grupo
	
//Considerar datas como primeiro dia do m$$HEX1$$ea00$$ENDHEX$$s, instru$$HEX2$$e700e300$$ENDHEX$$o de Marcelo Voos
ldt_data = gf_primeiro_dia_mes(Date(This.dh_validade_preste))
gf_data_parametro(ldh_Movto)
ldt_Mes = gf_primeiro_dia_mes(Date(ldh_Movto))

//Produto Vencido?
If (ldt_data >= ldt_Mes)and(This.id_concede_desconto='S') Then
	ls_grupo = MidA( This.cd_subcategoria, 1, 1 )
	
	select pv.cd_promocao, pv.pc_desconto 
		Into :ll_promocao, :lvdc_desconto
	from promocao_vencimento pv
		WHERE pv.dh_inicio <= :ldh_Movto
		  AND (pv.dh_termino is null or pv.dh_termino >= :ldh_Movto)
		  AND pv.cd_grupo = :ls_grupo
		AND Cast(pv.nm_promocao as Integer) >= ( dbo.diffdate( 'month', :ldt_Mes, :ldt_data) * 30)
	//     AND pv.nm_promocao >= Cast(:ll_dias As Varchar)  
	order by pv.pc_desconto desc
	limit 1
	Using SQLCa;
	 
	Choose Case SQLCa.SQLCode
		Case -1	
			lvdc_Desconto = -100		
		Case 100		
			lvdc_Desconto = 0
	End Choose
else
	lvdc_Desconto = 0
End if

Return lvdc_Desconto
end function

public function string of_verifica_preco_bloqueado_promocao (long al_produto, date adt_parametro, string as_uf);Long lvl_Count

String lvs_Bloqueado

//Select count(p2.cd_produto)
//Into :lvl_Count
//From promocao_sos p1, 
//	  promocao_sos_produto p2
//Where p2.cd_promocao_sos    = p1.cd_promocao_sos
//  and p1.dh_inicio 			<= :adt_parametro
//  and (p1.dh_termino is null or p1.dh_termino >= :adt_parametro)
//  and p1.id_preco_bloqueado = 'S'
//  and p1.id_situacao 		 = 'L'
//  and p2.cd_produto         =:al_produto
//Using SqlCa;

If Not IsNull(as_uf) Then
	Select count(p1.cd_produto)
	Into :lvl_Count
	From vw_promocao_estoque_minimo p1
	Where p1.id_preco_bloqueado = 	'S'
	  and p1.id_situacao 		 		= 	'L'
	  and p1.cd_produto         		=	:al_produto
	  and p1.cd_uf 						=	:as_uf
	Using SqlCa;
Else
	Select count(p1.cd_produto)
	Into :lvl_Count
	From vw_promocao_estoque_minimo p1
	Where p1.id_preco_bloqueado = 	'S'
	  and p1.id_situacao 		 		= 	'L'
	  and p1.cd_produto         		=	:al_produto
	Using SqlCa;
End If

Choose Case SqlCa.SqlCode
	Case -1
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do produto na promo$$HEX2$$e700e300$$ENDHEX$$o")
		lvs_Bloqueado = 'S'
	Case  0
		If lvl_Count > 0 Then
			lvs_Bloqueado = 'S'
		Else
			lvs_Bloqueado = 'N'
		End If
End Choose

Return lvs_Bloqueado
end function

public function decimal of_desconto_prestes ();Long lvl_Prod
String lvs_etiqueta

Return This.of_desconto_prestes(True,False,{''},lvs_etiqueta,lvl_Prod)
end function

public function decimal of_desconto_prestes (boolean pb_busca_prod_localizado, boolean pb_busca_prod_semelhantes, string ps_etiqueta_desconsidera[], ref string ps_etiqueta, ref long pl_produto);Long lvl_Prod
Long ll_Qt_Disponivel_Desconto

String lvs_etiqueta

Return This.of_desconto_prestes( pb_busca_prod_localizado, pb_busca_prod_semelhantes, ps_etiqueta_desconsidera[], Ref ps_etiqueta, Ref pl_Produto, Ref ll_Qt_Disponivel_Desconto )


end function

public function boolean of_existe_promocao_vinculada ();Long ll_Linhas

If This.Localizado Then

	Try
		dc_uo_ds_base lds_Vinculo
		lds_Vinculo = Create dc_uo_ds_base
		
		If Not lds_Vinculo.Of_ChangeDataObject('ds_ge001_promocao_vinculada') Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no evento changeDataObject ds_ge001_promocao_vinculada. Fun$$HEX2$$e700e300$$ENDHEX$$o: of_existe_promocao_vinculada()")
			Return False		
		End If
		
		ll_Linhas = lds_Vinculo.Retrieve( This.Cd_Produto )	
		 
		If ll_Linhas < 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no Retrieve. Fun$$HEX2$$e700e300$$ENDHEX$$o: of_existe_promocao_vinculada()")
			Return False
		End If
		
		Return ( ll_Linhas > 0 )
		
	Finally
		If IsValid( lds_Vinculo ) Then Destroy lds_Vinculo 
	End Try

End If



end function

public function boolean of_existe_negociacao_cliente (ref decimal as_desconto_maximo, ref decimal as_rentabilidade_minima);Long ll_Filial

SetNull(ll_Filial)

Return This.of_Existe_Negociacao_Cliente( ll_Filial, Ref as_desconto_maximo, Ref as_rentabilidade_minima )




end function

public function boolean of_possui_pbm_clamed ();Integer li_Possui

SELECT count(psp.cd_produto)
INTO :li_Possui
	FROM promocao_sos ps
		INNER JOIN promocao_sos_produto psp
			ON psp.cd_promocao_sos = ps.cd_promocao_sos
		INNER JOIN promocao_sos_vinculo psv
			ON psv.cd_promocao_sos = psp.cd_promocao_sos
	WHERE dbo.uf_dh_parametro( ) BETWEEN ps.dh_inicio AND COALESCE( ps.dh_termino, dbo.uf_dh_parametro() )
	AND ps.id_tipo_promocao = 'C'
	AND psp.cd_produto = :This.cd_produto
USING SqlCa;

Choose Case SqlCa.SqlCode
	Case -1
		SqlCa.of_RollBack( )
		SqlCa.of_MsgDbError( "uo_produto.of_possui_pbm_clamed( )" )
		Return False
End Choose

Return (li_Possui>0)
end function

public function boolean of_atualiza_desconto_promocao_futuro (date adt_data_base);Boolean lvb_Sucesso = True
Long lvl_Total,&
	  lvl_Contador,&
  	  lvl_Produto,&
	  lvl_Promocao,&	 
	  lvl_Linhas_Atualizadas, ll_existe, ll_nr_campanha_legado
			  
String lvs_Responsavel, ls_nr_campanha_sap
Decimal  lvdc_Desc_Clube_Futuro,&
			lvdc_Desc_Normal_Futuro
Date		lvdt_Hoje

dc_uo_ds_Base lvds
lvds = Create dc_uo_ds_Base

If Not lvds.of_ChangeDataObject("dw_ge001_produtos_sos_futuro") Then
	Destroy(lvds)
	lvb_Sucesso = False
	Return lvb_Sucesso
End If

Open(w_ge001_Aguarde)
w_ge001_Aguarde.Title = "Atualizando Descontos de Promo$$HEX2$$e700e300$$ENDHEX$$o Futuro.... "

lvl_Total = lvds.Retrieve(adt_Data_Base)

If lvl_Total = 0 Then 
	Destroy(lvds)
	Close(w_ge001_Aguarde)	
	Return lvb_Sucesso
End If

w_ge001_Aguarde.uo_Progress.of_SetMax(lvl_Total)

lvdt_Hoje = Date(Today())			 

For lvl_Contador = 1 To lvl_Total	
	lvl_Promocao					= lvds.Object.Cd_Promocao_Sos					[lvl_Contador]
	lvl_Produto     					= lvds.Object.Cd_Produto                  			[lvl_Contador]
	lvs_Responsavel 				= lvds.Object.nr_matricula_alteracao_futuro	[lvl_Contador]
	lvdc_Desc_Normal_Futuro	= lvds.Object.pc_desconto_futuro					[lvl_Contador]
	lvdc_Desc_Clube_Futuro 		= lvds.Object.pc_desconto_clube_futuro			[lvl_Contador]	
	ls_nr_campanha_sap = lvds.Object.nr_campanha_sap[lvl_Contador]	
	
	Update	promocao_sos_produto  
	Set		pc_desconto						=:lvdc_Desc_Normal_Futuro,
				pc_desconto_clube			=:lvdc_Desc_Clube_Futuro,
				nr_matricula_alteracao		=:lvs_Responsavel,
				dh_alteracao					=dh_vigencia_futuro, 
				pc_desconto_futuro			=null ,
				pc_desconto_clube_futuro	=null,
				dh_vigencia_futuro			=null,
				nr_matricula_alteracao_futuro	=null			
	Where cd_promocao_sos 				=:lvl_Promocao
	and     cd_produto							=:lvl_Produto
	Using SqlCA;
	
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_RollBack()
		SqlCa.of_MsgdbError("Altera$$HEX2$$e700e300$$ENDHEX$$o do Desconto Futuro Produto '" + String(lvl_Produto) + "'")
		gvo_Aplicacao.of_grava_log( "[ATUALIZACAO DESCONTO FUTURO] - Erro no udate desconto futuro produto: '" + String(lvl_Produto) + "'" )
		lvb_Sucesso = False
		Exit
	End If

	lvl_Linhas_Atualizadas =  SqlCa.sqlnrows
	
	If ls_nr_campanha_sap <> '' and not isnull(ls_nr_campanha_sap) Then
		
		select nr_campanha
		into :ll_nr_campanha_legado
		from campanha
		where nr_campanha_sap = :ls_nr_campanha_sap;
		
		if sqlca.sqlcode = -1 then
			SqlCa.of_RollBack()
			SqlCa.of_MsgdbError("Altera$$HEX2$$e700e300$$ENDHEX$$o do Desconto Futuro Produto '" + String(lvl_Produto) + "'")
			gvo_Aplicacao.of_grava_log( "[ATUALIZACAO DESCONTO FUTURO] - Erro no udate desconto futuro produto: '" + String(lvl_Produto) + "'" )
			lvb_Sucesso = False
			Exit
		End If	
		
		select count(*)
		into :ll_existe
		from campanha_produto
		where nr_campanha = :ll_nr_campanha_legado
		and cd_produto = :lvl_produto;
		
		if sqlca.sqlcode = -1 then
			SqlCa.of_RollBack()
			SqlCa.of_MsgdbError("Altera$$HEX2$$e700e300$$ENDHEX$$o do Desconto Futuro Produto '" + String(lvl_Produto) + "'")
			gvo_Aplicacao.of_grava_log( "[ATUALIZACAO DESCONTO FUTURO] - Erro no select da tabela campanha_produto: '" + String(lvl_Produto) + "'" )
			lvb_Sucesso = False
			Exit
		End If
		
		if ll_existe > 0 Then
				
			update campanha_produto
			set pc_desconto = :lvdc_Desc_Normal_Futuro
			where nr_campanha = :ll_nr_campanha_legado
			and cd_produto = :lvl_Produto;
			
			if sqlca.sqlcode = -1 then
				SqlCa.of_RollBack()
				SqlCa.of_MsgdbError("Altera$$HEX2$$e700e300$$ENDHEX$$o do Desconto Futuro Produto '" + String(lvl_Produto) + "'")
				gvo_Aplicacao.of_grava_log( "[ATUALIZACAO DESCONTO FUTURO] - Erro no udate da tabela campanha_produto: '" + String(lvl_Produto) + "'" )
				lvb_Sucesso = False
				Exit
			End If
			
		end if
	end if
	
	If lvl_Linhas_Atualizadas > 0 Then
		SqlCa.of_Commit()
	End If
	
	w_ge001_Aguarde.uo_Progress.of_SetProgress(lvl_Contador)
Next
	  
Destroy(lvds)
Close(w_ge001_Aguarde)

Return lvb_Sucesso
end function

public function boolean of_possui_promocao_progressiva ();Integer li_Possui

SELECT count(psp.cd_produto)
INTO :li_Possui
	FROM promocao_sos ps
	INNER JOIN promocao_sos_produto psp
		ON psp.cd_promocao_sos = ps.cd_promocao_sos
WHERE dbo.uf_dh_parametro( ) BETWEEN ps.dh_inicio AND COALESCE( ps.dh_termino, dbo.uf_dh_parametro() )
	AND psp.cd_produto 			= :This.cd_produto
	AND ps.id_tipo_promocao 	= 'Q'
	AND ( COALESCE(psp.cd_desc_progressivo, 0) > 0 OR COALESCE(psp.cd_desc_progressivo_clube, 0) > 0 )
USING SqlCa;

Choose Case SqlCa.SqlCode
	Case -1
		SqlCa.of_RollBack( )
		SqlCa.of_MsgDbError( "uo_produto.of_possui_promocao_progressiva( )" )
		Return False
End Choose

Return (li_Possui>0)
end function

public subroutine of_localiza_codigo_barras_like (string as_codigo_barras);Boolean lb_Continue

Long ll_Linhas
Long ll_Linha
Long ll_Produto
Long ll_Cont

String ls_EAN
String ls_Achou

dc_uo_ds_base lds 

try
	lds = Create dc_uo_ds_base
	If Not lds.of_ChangeDataObject("ds_ge001_codigo_barras") Then
		Localizado = False
		Return
	End If
	
	as_codigo_barras = gf_tira_zero_esquerda(as_codigo_barras)
	
	ll_Linhas = lds.Retrieve(as_codigo_barras)
	
	If ll_Linhas > 0 Then
		
		For ll_Linha = 1 To ll_Linhas
			lb_Continue = True
			
			ls_EAN = lds.Object.de_codigo_barras[ll_Linha]
			//0030768001841
			ls_Achou = Mid(ls_EAN, 1,Pos(ls_EAN, as_codigo_barras) -1)
							
			//00
			For ll_Cont = 1 To Len(ls_Achou)
				// Se encontrar um n$$HEX1$$fa00$$ENDHEX$$mero diferente de zero significa que n$$HEX1$$e300$$ENDHEX$$o encontrou o produto correto
				If Long(Mid(ls_Achou, ll_Cont, 1)) <> 0 Then 
					lb_Continue = False
					Exit
				End If
			Next
			
			If lb_Continue Then
				If ll_Produto > 0 Then
					// Se encontrar mais de um produto com um mesmo c$$HEX1$$f300$$ENDHEX$$digo de barras, retorna falso
					If ll_Produto <> lds.Object.cd_produto[ll_Linha] Then
						SetNull(ll_Produto)
						Exit
					End If
				Else
					ll_Produto =  lds.Object.cd_produto[ll_Linha]
				End If
			End If
						
		Next
		
		If Not IsNull(ll_Produto) and ll_Produto > 0 Then
			of_Localiza_Codigo_Interno(ll_Produto)
		Else
			Localizado = False
		End If
		
	Else
		Localizado = False
	End If
	
finally
	Destroy lds
end try
end subroutine

protected function boolean of_exclui_preco_regionalizado (date pdt_data_base);String ls_MSG

Try
	Open(w_ge001_Aguarde)
	w_ge001_Aguarde.Title = "Excluindo Pre$$HEX1$$e700$$ENDHEX$$os de Venda Regionalizados... "
	
	Delete From preco_regionalizado
	Where dh_fim_preco_venda is not null
		 and dh_fim_preco_venda < :pdt_data_base
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		ls_MSG = "Erro ao excluir os pre$$HEX1$$e700$$ENDHEX$$os regionalizados vencidos. " + SqlCa.SqlErrText
		SqlCa.of_RollBack();
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_MSG , StopSign!)
		Return False
	End If
	
	If Sqlca.SQLNRows > 0 Then
		SqlCa.of_Commit();
	End If
Finally
	Close(w_ge001_Aguarde)	
End Try

Return True




end function

public function decimal of_desconto_contrato_convenio (long pl_convenio, long pl_contrato);Decimal lvdc_Desconto

Select c2.pc_desconto Into :lvdc_Desconto
From contrato_preco_convenio_prd c2
	inner join contrato_preco_convenio c1
		on c1.cd_convenio = c2.cd_convenio
		and c1.nr_contrato = c2.nr_contrato
	inner join  parametro pa
		on c1.dh_inicio  <= pa.dh_movimentacao
	   and (c1.dh_termino >= pa.dh_movimentacao or c1.dh_termino Is Null)
Where c2.cd_convenio = :pl_convenio
 and c2.nr_contrato = :pl_contrato
  and c2.cd_produto  = :This.Cd_Produto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		Return lvdc_Desconto
	Case 100
		Return -100
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do contrato de pre$$HEX1$$e700$$ENDHEX$$os." + SqlCa.SqlErrText, StopSign!)
		Return -1
End Choose
end function

public function decimal of_desconto_prestes (boolean pb_busca_prod_localizado, boolean pb_busca_prod_semelhantes, string ps_etiqueta_desconsidera[], ref string ps_etiqueta, ref long pl_produto, ref long pl_qt_disponivel_desconto);Long lvl_linhas
Long lvl_Item

Integer li_Row

Decimal{2} lvdc_Desconto = 0.00

pl_qt_disponivel_desconto = 0

If This.Localizado Then
	If Not IsValid(ivds_desc_prestes) Then 
		ivds_desc_prestes = Create dc_uo_ds_base
		ivds_desc_prestes.Of_ChangeDataObject('ds_ge001_desconto_prestes')
	Else
		ivds_desc_prestes.Of_RestoreSQLOriginal()
	End If
	
	If pb_busca_prod_semelhantes Then
		If (IsNull(id_apresentacao))or(id_apresentacao='') or IsNull(qt_concentracao) or(qt_concentracao=0) Then
			If pb_busca_prod_localizado Then 
				ivds_desc_prestes.Of_AppendWhere("p.cd_produto = "+String(cd_produto))
			Else
				Return 0.00
			End If
		Else		
			ivds_desc_prestes.Of_AppendWhere("p.cd_subcategoria = '"+cd_subcategoria+"'")
			ivds_desc_prestes.Of_AppendWhere("p.id_apresentacao = '"+id_apresentacao+"'")
			ivds_desc_prestes.Of_AppendWhere("p.qt_concentracao = "+gf_replace(String(qt_concentracao),',','.',0))
		End If
		
		If not pb_busca_prod_localizado Then ivds_desc_prestes.Of_AppendWhere("p.cd_produto <> "+String(cd_produto))
	ElseIf pb_busca_prod_localizado Then
		ivds_desc_prestes.Of_AppendWhere("p.cd_produto = "+String(cd_produto))
	End If
	
	//desconsidera etiquetas
	For lvl_Item = 1 To UpperBound(ps_etiqueta_desconsidera)
		If Trim(ps_etiqueta_desconsidera[lvl_Item])<>'' Then 
			ivds_desc_prestes.Of_AppendWhere("ppv.nr_etiqueta <> '"+ps_etiqueta_desconsidera[lvl_Item]+"'")
		End If
	Next
	
	lvl_linhas = ivds_desc_prestes.Retrieve(This.Cd_Produto)
	
	If lvl_linhas > 0 Then
		ps_etiqueta		= ivds_desc_prestes.Object.nr_etiqueta	[1]
		nr_etiqueta_preste = ps_etiqueta
		pl_produto		= ivds_desc_prestes.Object.cd_produto	[1]
		lvdc_Desconto	= ivds_desc_prestes.Object.pc_desconto	[1]
		
		For li_Row=1 To lvl_Linhas
			If ivds_desc_prestes.Object.pc_desconto	[li_Row] > 0 Then
				pl_qt_disponivel_desconto++
			End If			
		Next
		
		
	ElseIf lvl_linhas = 0 Then 
		SetNull(ps_etiqueta)
		SetNull(pl_produto)
		lvdc_Desconto = 0.00
	Else
		SQLCa.Of_MsgDberror('Localiza$$HEX2$$e700e300$$ENDHEX$$o descontro prestes de produto semelhantes.')
		SetNull(ps_etiqueta)
		SetNull(pl_produto)
		lvdc_Desconto = 0.00
	End If
End If

Return lvdc_Desconto
end function

public subroutine of_localiza_codigo_sap (string ps_cd_produto_sap);Long lvl_Produto

Select cd_produto Into :lvl_Produto
From produto_geral
Where cd_produto_sap = :ps_cd_produto_sap
Using SqlCa;
	
If SqlCa.SqlCode = 0 Then
	of_Localiza_Codigo_Interno(lvl_Produto)
End If
end subroutine

public function boolean of_possui_dermaclub ();Integer li_Possui

Select Count(pp.cd_pbm)
  Into :li_Possui
  From pbm_produto pp
  inner join pbm p
  	on p.cd_pbm = pp.cd_pbm
	 and coalesce (p.id_tipo, '') = 'D'
 Where pp.cd_produto = :This.cd_produto
  
 Using SqlCa;
 
Choose Case SqlCa.SqlCode
	Case -1
		SqlCa.of_RollBack( )
		SqlCa.of_MsgDbError( "uo_produto.of_possui_dermaclub( )" )
		Return False
End Choose

Return (li_Possui>0)
end function

public function boolean of_existe_negociacao_cliente (long al_filial, ref decimal as_desconto_maximo, ref decimal as_rentabilidade_minima);Integer li_Tipo
Long ll_Retrieve

Decimal ldc_Desconto, ldc_Rentabilidade

//Medicamentos
If This.cd_grupo_produto = 1 Then
	Choose Case This.id_lei_generico
		Case 'G'; 		li_Tipo = 1
		Case 'R'; 		li_Tipo = 2	
		Case 'S'; 		li_Tipo = 3
		Case 'E'; 		li_Tipo = 4
		Case 'O'; 		li_Tipo = 6
	End Choose
Else
	//NAO Medicamentos
	li_Tipo = 5
End If
//

If This.ivl_Filial_Parametro <> This.ivl_Filial_Matriz Then
	Select n.pc_desconto_maximo,	n.pc_rentabilidade_minima
		Into :ldc_Desconto, 	:ldc_Rentabilidade
	from negociacao n
		inner join parametro p
			on p.id_parametro = '1'
	where n.cd_tipo 	= :li_Tipo
		and n.dh_inicio <= p.dh_movimentacao and p.dh_movimentacao <= n.dh_termino
		Order by n.cd_negociacao desc
		Limit 1
	Using SqlCa;
	
Else
	
	If Not IsNull(al_filial) And al_filial > 0 Then
		Select top 1 n.pc_desconto_maximo,	n.pc_rentabilidade_minima
				Into :ldc_Desconto, 	:ldc_Rentabilidade
		from negociacao n
		inner join parametro p
			on p.id_parametro = '1'
			inner join negociacao_filial f
				on f.cd_negociacao = n.cd_negociacao
		where n.cd_tipo 		= :li_Tipo
			and f.cd_filial 		= :al_Filial
			and n.dh_inicio 	<= p.dh_movimentacao and p.dh_movimentacao <= n.dh_termino
			Order by n.cd_negociacao desc
		Using SqlCa;
	Else
		Select top 1 n.pc_desconto_maximo,	n.pc_rentabilidade_minima
				Into :ldc_Desconto, 	:ldc_Rentabilidade
		from negociacao n
			inner join parametro p
				on p.id_parametro = '1'
		where n.cd_tipo 	= :li_Tipo
			and n.dh_inicio <= p.dh_movimentacao and p.dh_movimentacao <= n.dh_termino
			Order by n.cd_negociacao desc
		Using SqlCa;
	End If
End If		
//
Choose Case SqlCa.SqlCode
	Case -1 
		SqlCa.Of_MsgDbError("Erro ao localizar os valores da negocia$$HEX2$$e700e300$$ENDHEX$$o. Produto Geral - Fun$$HEX2$$e700e300$$ENDHEX$$o: of_existe_negociacao_cliente(ref dec, ref dec)")
		Return False
	Case 100
		ldc_Desconto		= 0.00
		ldc_Rentabilidade 	= 0.00
		//Se n$$HEX1$$e300$$ENDHEX$$o localizar nenhum grupo nao deixa negociar
		Return False
		
	Case 0
		as_desconto_maximo			= ldc_Desconto
		as_rentabilidade_minima		= ldc_Rentabilidade
		
		Return True
End Choose

end function

public function boolean of_verifica_excecao_pesquisa ();Boolean	lb_excecao
Integer	li_linha
String	ls_janelas_excecao []
Window	lw_janela_ativa

lb_excecao = False

ls_janelas_excecao [1] = 'w_ws018_conferencia_pedido'

If gvo_Aplicacao.ivo_Seguranca.cd_Sistema = 'WS' then
	If IsValid(dc_w_mdi) then
		lw_janela_ativa = dc_w_mdi.GetActiveSheet()
		If IsValid(lw_janela_ativa) then
			For li_linha = 1 to UpperBound (ls_janelas_excecao[])
				 If lw_janela_ativa.Classname () = ls_janelas_excecao [li_linha] then
					lb_excecao = True
					Exit
				End if
			Next
		End if
	End if
End if

Return lb_excecao
end function

public function decimal of_desconto_clube_filial_nova (long pl_filial);Decimal	lvdc_Desconto_Clube

String ls_id_usa_novo_preco_sap

if Not this.of_utiliza_novo_calculo_preco_sap( pl_filial, ref ls_id_usa_novo_preco_sap ) Then return -1

if ls_id_usa_novo_preco_sap = 'S' Then
	
	if Not this.of_Desconto_clube_filial_sap_novo( pl_filial, ref lvdc_Desconto_Clube) Then return -1
	
Else

	If is_somente_liberado_ecommerce = 'S' Then
		
		select top 1 p.cd_promocao_sos, coalesce( pp.pc_desconto_clube, 0 )
		into :This.Cd_Promocao_SOS, :lvdc_Desconto_Clube
		from	promocao_sos p (index idx_tipo_data_sit)
		inner  join promocao_sos_filial pf
			on pf.cd_promocao_sos 	= p.cd_promocao_sos
			and pf.cd_filial 				= :pl_filial
		inner join promocao_sos_produto pp 
			on pp.cd_promocao_sos 	= p.cd_promocao_sos
			and pp.cd_produto				=  :This.Cd_Produto
		where p.id_tipo_promocao 		= 'N'
			 and p.id_situacao 				= 'L'
			 and p.dh_inicio 					<= :ivdh_data_parametro
			 and p.dh_termino 				>= :ivdh_data_parametro
			 and coalesce(p.id_utiliza_ecommerce, 'S') = 'S'
			 and pp.pc_desconto_clube	> 0
		order by coalesce(pp.pc_desconto_clube, 0 ) desc
		Using Sqlca;
		
	Else
		
		select top 1 p.cd_promocao_sos, coalesce( pp.pc_desconto_clube, 0 )
		into :This.Cd_Promocao_SOS, :lvdc_Desconto_Clube
		from	promocao_sos p (index idx_tipo_data_sit)
		inner  join promocao_sos_filial pf
			on pf.cd_promocao_sos 	= p.cd_promocao_sos
			and pf.cd_filial 				= :pl_filial
		inner join promocao_sos_produto pp 
			on pp.cd_promocao_sos 	= p.cd_promocao_sos
			and pp.cd_produto				=  :This.Cd_Produto
		where p.id_tipo_promocao 		= 'N'
			 and p.id_situacao 				= 'L'
			 and p.dh_inicio 					<= :ivdh_data_parametro
			 and p.dh_termino 				>= :ivdh_data_parametro
			 and pp.pc_desconto_clube	> 0
		order by coalesce(pp.pc_desconto_clube, 0 ) desc
		Using Sqlca;
		
	End If
	
	Choose Case SqlCa.SqlCode
		Case 0
		Case 100
			lvdc_Desconto_Clube = 0
		Case -1 
			SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do desconto do clube.")
			lvdc_Desconto_Clube = 0
	End Choose
	
ENd if

//DateTime ldh_Hoje
//
//Decimal	lvdc_Desconto_Clube
//			
//Long ll_Linhas
//
//dc_uo_ds_Base lvds_1
//lvds_1 = Create dc_uo_ds_Base
//
//If Not lvds_1.of_ChangeDataObject("dw_ge001_desconto_clube_filial") Then
//	Destroy(lvds_1)
//	Return -1
//End If
//
//// Utilizado na uo_ge501_preco onde foi inicializado como "S", o objetivo $$HEX1$$e900$$ENDHEX$$ considerar somente as promo$$HEX2$$e700f500$$ENDHEX$$es que podem ser utilizadas no e-commerce
//If is_somente_liberado_ecommerce = 'S' Then
//	lvds_1.of_appendwhere("coalesce(p.id_utiliza_ecommerce, 'S') = 'S'")
//End If
//
//ll_Linhas = lvds_1.Retrieve( This.Cd_Produto, pl_Filial )
//
//If  ll_Linhas > 0 Then
//	lvdc_Desconto_Clube =  lvds_1.Object.Pc_Desconto_Clube[1]
//	This.Cd_Promocao_SOS = lvds_1.Object.Cd_Promocao_SOS[1]		
//End If
//
//Destroy(lvds_1)

Return lvdc_Desconto_Clube
end function

public function boolean of_utiliza_novo_calculo_preco_sap (long pl_cd_filial, ref string ps_id_novo_calculo);string ls_id_novo_calculo

select vl_parametro
into :ls_id_novo_calculo
from parametro_loja
where cd_parametro = 'ID_UTILIZA_NOVO_CALCULO_PRECO_SAP'
and cd_filial = :pl_cd_filial;

if sqlca.sqlcode = -1 then
	SqlCa.of_MsgdbError("Utiliza novo calculo de Pre$$HEX1$$e700$$ENDHEX$$o SAP.")
	return false
ENd if

if isnull(ls_id_novo_calculo) or trim(ls_id_novo_calculo) = '' Then ls_id_novo_calculo = 'N'

ps_id_novo_calculo = ls_id_novo_calculo

return true
end function

public function boolean of_desconto_clube_filial_sap_novo (long pl_cd_filial, ref decimal pdc_valor_desconto);Decimal	lvdc_Perc_Desconto_Clube, lvdc_preco_clube, lvdc_preco_venda, lvdc_valor_desconto, lvdc_valor_perc_clube
	
//Poder$$HEX1$$e100$$ENDHEX$$ ser usado tanto o Percentual de desconto quanto o preco clube. Retornar o maior desconto:
select coalesce(pc_desconto_clube, 0), coalesce(vl_preco_clube, 0), (Case when vl_pmc > 0 Then vl_pmc Else vl_preco_bruto ENd)
into :lvdc_Perc_Desconto_Clube, :lvdc_preco_clube, :lvdc_preco_venda
from preco_calculado pc 
where cd_produto = :this.cd_produto 
and cd_filial = :pl_cd_filial
and id_ultimo = 'S';

Choose Case sqlca.sqlcode
	Case -1
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do desconto do clube sap Novo.")
		pdc_valor_desconto = 0
		return False
	Case 100
		pdc_valor_desconto = 0
		return True
End Choose

if isnull(lvdc_preco_venda) then lvdc_preco_venda = 0

//Calcula o o valor do desconto utilizando o percentual clube:
lvdc_valor_perc_clube = lvdc_preco_venda * (lvdc_Perc_Desconto_Clube/100)

//Retornar o maior desconto:
if lvdc_valor_perc_clube >= lvdc_preco_clube Then
	
	//retorna o pc_desconto_clube
	pdc_valor_desconto = lvdc_Perc_Desconto_Clube
Else
	
	if lvdc_preco_venda = 0 Then
		
		pdc_valor_desconto = 0
	
	Else
		//Retorna o valor percentual baseado no vl_preco_clube:
		pdc_valor_desconto = round((1 - (lvdc_preco_clube/lvdc_preco_venda)) * 100, 4)
	End if
	
End If
		
Return True
end function

public function boolean of_atualiza_preco_padrao_matriz_sap (date pdt_data_base);Boolean lvb_Sucesso = True

Long lvl_Total, &
	  lvl_Contador, &
  	  lvl_Produto
			  
String lvs_UF, &
       lvs_Responsavel

Integer lvi_Log

lvi_Log = FileOpen("C:\Sistemas\CA\Arquivos\atualizacao_preco_sap.log", LineMode! , Write!, LockWrite!)

gf_grava_log_basico(lvi_Log, "In$$HEX1$$ed00$$ENDHEX$$cio - " + String(Today(), "dd/mm/yyyy hh:ss"))

dc_uo_ds_Base lvds

try

	lvds = Create dc_uo_ds_Base
	
	If Not lvds.of_ChangeDataObject("dw_ge001_alteracao_preco_padrao_matriz_sap") Then Return False
	
	Open(w_ge001_Aguarde)
	w_ge001_Aguarde.Title = "Atualizando Pre$$HEX1$$e700$$ENDHEX$$os de Venda Padr$$HEX1$$e300$$ENDHEX$$o SAP... "
	
	lvl_Total = lvds.Retrieve(pdt_Data_Base)
	
	If lvl_Total > 0 Then
	
		w_ge001_Aguarde.uo_Progress.of_SetMax(lvl_Total)
		
		For lvl_Contador = 1 To lvl_Total	
			lvs_UF          	= lvds.Object.Cd_Unidade_Federacao     	[lvl_Contador]
			lvl_Produto     	= lvds.Object.Cd_Produto            				[lvl_Contador]
			
			Update produto_uf
			Set vl_preco_venda_maximo_sap 			= vl_preco_venda_maximo_fut_sap,
				 dh_preco_venda_maximo_sap 		= dh_preco_venda_maximo_fut_sap,
				 vl_preco_venda_maximo				= vl_preco_venda_maximo_fut_sap,
				 
				 vl_preco_venda_futuro_sap      		= null,
				 dh_preco_venda_futuro_sap      		= null,
				 
				 vl_preco_venda_maximo_fut_sap  	= null,
				 dh_preco_venda_maximo_fut_sap  	= null,
				 nr_matric_preco_venda_fut_sap 		= null
			Where cd_unidade_federacao 	= :lvs_UF
			  and cd_produto           			= :lvl_Produto
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				gf_grava_log_basico (lvi_Log, "Erro - Altera$$HEX2$$e700e300$$ENDHEX$$o do Pre$$HEX1$$e700$$ENDHEX$$o de Venda Atual SAP do Produto '" + String(lvl_Produto) + "' - " + SQLCA.SQLErrText )
				SqlCa.of_MsgdbError("Altera$$HEX2$$e700e300$$ENDHEX$$o do Pre$$HEX1$$e700$$ENDHEX$$o de Venda Atual SAP do Produto '" + String(lvl_Produto) + "'")
				lvb_Sucesso = False
				Exit
			End If
			
			SqlCa.of_Commit()
		
			w_ge001_Aguarde.uo_Progress.of_SetProgress(lvl_Contador)
		Next
		
		gf_grava_log_basico(lvi_Log, "T$$HEX1$$e900$$ENDHEX$$rmino - " + String(Today(), "dd/mm/yyyy hh:ss"))
		FileClose(lvi_Log)
		
	ElseIf lvl_Total = 0 Then
		gf_grava_log_basico(lvi_Log, "Nenhum produto foi localizado para atualiza$$HEX2$$e700e300$$ENDHEX$$o.")
		gf_grava_log_basico(lvi_Log, "T$$HEX1$$e900$$ENDHEX$$rmino - " + String(Today(), "dd/mm/yyyy hh:ss"))
		lvb_Sucesso = True
	Else
		gf_grava_log_basico(lvi_Log, "Erro ao recuperar os produtos para atualizar o pre$$HEX1$$e700$$ENDHEX$$o do SAP.")
		gf_grava_log_basico(lvi_Log, "T$$HEX1$$e900$$ENDHEX$$rmino - " + String(Today(), "dd/mm/yyyy hh:ss"))
		
		lvb_Sucesso = False
	End If
	
finally
	Destroy(lvds)
	FileClose(lvi_Log)
	Close(w_ge001_Aguarde)
end try

Return lvb_Sucesso
end function

public function boolean of_preco_venda_filial_matriz_novo (long pl_cd_filial, ref decimal pdc_vl_preco, ref decimal pdc_vl_preco_clube);decimal ldc_preco
Decimal	ldc_preco_clube


select (Case when vl_pmc > 0 Then vl_pmc Else vl_preco_bruto ENd)
	into :ldc_preco
from dbo.preco_calculado pc
where cd_produto = :This.cd_produto  
    and cd_filial = :pl_cd_filial
    and id_ultimo = 'S';
	 
if sqlca.sqlcode = -1 then
	SqlCa.of_MsgdbError("Preco venda filial novo.")
	return false
End if

select COALESCE(vl_preco_clube,0)
	into :ldc_preco_clube
from dbo.preco_calculado pc
where cd_produto = :This.cd_produto  
    and cd_filial = :pl_cd_filial
    and id_ultimo = 'S'
Using SqlCa;
	 	 
Choose Case SqlCa.SqlCode		  
		  
	Case -1
		SqlCa.of_MsgdbError("Preco venda filial novo (vl_preco_clube).")
		return false
	
	Case 100
		ldc_preco_clube = ldc_preco
	Case 0
		
End choose

if isnull(ldc_preco) then ldc_preco = 0

if isnull(ldc_preco_clube) then ldc_preco_clube = ldc_preco

If ldc_preco_clube <= 0 Then ldc_preco_clube = ldc_preco

pdc_vl_preco = ldc_preco
pdc_vl_preco_clube = ldc_preco_clube
	 
Return True


end function

on uo_produto.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_produto.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;Select	cd_filial, 
       	cd_filial_matriz,
		dh_movimentacao
Into 	:This.ivl_Filial_Parametro,
     	:This.ivl_Filial_Matriz,
	  	:This.ivdh_data_parametro
From parametro
Where id_parametro = '1'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Filial dos par$$HEX1$$e200$$ENDHEX$$metros n$$HEX1$$e300$$ENDHEX$$o localizada.", StopSign!)
		SetNull(This.ivl_Filial_Parametro)		
		SetNull(This.ivl_Filial_Matriz)		
		SetNull(This.ivdh_data_parametro)
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o da filial dos par$$HEX1$$e200$$ENDHEX$$metros." + SqlCa.SqlErrText, StopSign!)
		SetNull(This.ivl_Filial_Parametro)
		SetNull(This.ivl_Filial_Matriz)	
		SetNull(This.ivdh_data_parametro)
End Choose

This.of_Inicializa()
end event

event destructor;If IsValid(ivds_desc_prestes) Then Destroy(ivds_desc_prestes)
If IsValid(ids_contratos_bin) Then Destroy(ids_contratos_bin)

end event

