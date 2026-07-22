HA$PBExportHeader$uo_ge252_agrupamento_devolucao_compra.sru
forward
global type uo_ge252_agrupamento_devolucao_compra from nonvisualobject
end type
end forward

global type uo_ge252_agrupamento_devolucao_compra from nonvisualobject
end type
global uo_ge252_agrupamento_devolucao_compra uo_ge252_agrupamento_devolucao_compra

type variables
uo_ge258_movimentacao io_Movimentacao

Boolean	ib_Iniciado_Operacao_SAP	= False

String is_Endereco_Agrupamento =  "B900500A"

String is_Destino_Final


Boolean ivb_Valida_Inventario = False 
Boolean ivb_Endereco_Bloqueado = False

Integer	ii_Limite_Itens_Agrupamento
end variables

forward prototypes
public function boolean of_insere_agrupamento_dev_compra_prd (long al_agrupamento, long al_produto, string as_endereco, string as_lote, datetime adh_validade, decimal adc_preco, decimal adc_desconto_forn, long al_qtde, decimal adc_peso, ref string as_erro)
public function boolean of_localiza_preco_reposicao (long al_produto, ref decimal adc_preco_reposicao, ref decimal adc_desconto_fornecedor, ref decimal adc_peso, ref string as_erro)
public function boolean of_atualiza_reserva_item_nf_compra_lote (long al_filial, string as_fornecedor, long al_nota, string as_especie, string as_serie, long al_natureza_operacao, long al_produto, string as_lote, long al_qt_reserva, ref string as_erro)
public function boolean of_atualiza_valor_agrupamento (long al_agrupamento, string as_destino_final, ref string as_erro)
public function boolean of_localiza_nota_compra_perf_vencido (long al_filial, string as_fornecedor, long al_nota_compra, string as_serie_compra, long al_produto, string as_lote, string as_endereco, long al_motivo_devolucao, ref string as_fornecedor_compra, ref long al_nota, ref string as_especie, ref string as_serie, ref long al_natureza_operacao, ref long al_qt_localizada, ref decimal adc_preco_unitario, ref decimal adc_pc_desconto, ref boolean ab_possui_nota_compra, ref string as_lote_retorno, ref string as_erro)
public function boolean of_localiza_nota_compra_produto (long al_filial, string as_fornecedor, long al_nota_compra, string as_serie_compra, long al_produto, string as_lote, string as_endereco, long al_motivo_devolucao, string as_subcategoria, ref string as_fornecedor_compra, ref long al_nota, ref string as_especie, ref string as_serie, ref long al_natureza_operacao, ref long al_qt_localizada, ref decimal adc_preco_unitario, ref decimal adc_pc_desconto, ref boolean ab_possui_nota_compra, ref string as_lote_retorno, ref string as_erro)
public function boolean of_processa_descarte_nf_entrada (long al_filial, long al_agrupamento, string as_fornecedor, long al_produto, string as_lote, string as_endereco, long al_qtde, string as_destino_final, datetime adh_validade, ref decimal adc_preco_reposicao, ref decimal adc_desconto_fornecedor, ref string as_erro, ref long al_qtde_restante)
public function boolean of_movimenta_produto (long al_produto, string as_endereco_saida, string as_endereco_destino, string as_lote, datetime adh_validade, long al_qtde, string as_matricula, string as_tipo_movimento, long al_agrupamento, ref string as_erro)
public function boolean of_insere_agrupamento_dev_compra_prd_nf (long al_agrupamento, long al_produto, string as_endereco, string as_lote, long al_filial, string as_fornecedor, long al_nota, string as_especie, string as_serie, long al_natureza_operacao, long al_qt_devolver, decimal adc_preco_unitario, decimal adc_pc_desconto, string as_lote_nota, ref string as_erro)
public function boolean of_carrega_parametros (ref string as_erro)
public function boolean of_processa_devolucao_compra (long al_filial, long al_agrupamento, string as_fornecedor, long al_nota, string as_serie, long al_produto, string as_lote, string as_endereco, long al_qtde, string as_destino_final, datetime adh_validade, long al_motivo_devolucao, string as_subcategoria, ref decimal adc_preco_reposicao, ref decimal adc_desconto_fornecedor, ref uo_ge040_args auo_args[], ref string as_erro)
public function boolean of_insere_produto_no_agrupamento (long al_agrupamento, string as_fornecedor, long al_nota, string as_serie, long al_produto, string as_lote, string as_endereco, long al_qtde, string as_destino_final, datetime adh_validade, long al_motivo_devolucao, string as_subcategoria, ref decimal adc_preco_reposicao, ref decimal adc_desconto_fornecedor, ref uo_ge040_args auo_args[], ref string as_erro)
public function boolean of_processa_descarte_nova (long al_filial, long al_agrupamento, string as_fornecedor, long al_nota, string as_serie, long al_produto, string as_lote, string as_endereco, long al_qtde, string as_destino_final, datetime adh_validade, long al_motivo_devolucao, string as_subcategoria, ref decimal adc_preco_reposicao, ref decimal adc_desconto_fornecedor, uo_ge040_args auo_args[], ref string as_erro)
public function boolean of_verificar_novo_agrupamento (long al_nr_agrupamento, ref string al_de_retorno)
public function boolean of_verificar_agrupamento_total_produto (long al_nr_agrupamento, ref string as_erro)
public function boolean of_atualiza_agrupamento_protocolo (st_parametros_protocolo ast_parametros_protocolo, ref string as_erro)
public function boolean of_insere_agrupamento_protocolo (st_parametros_protocolo ast_parametros_protocolo, uo_ge040_args auo_ge040_args[], long al_nr_agrupamento, ref string as_erro)
public function boolean of_insere_produto_no_agrupamento_protoco (long al_agrupamento, string as_fornecedor, long al_nota, string as_serie, long al_produto, string as_lote, string as_endereco, long al_qtde, ref string as_erro)
end prototypes

public function boolean of_insere_agrupamento_dev_compra_prd (long al_agrupamento, long al_produto, string as_endereco, string as_lote, datetime adh_validade, decimal adc_preco, decimal adc_desconto_forn, long al_qtde, decimal adc_peso, ref string as_erro);Long ll_Qtde, ll_contador_produtos_validade_diferente
String ls_Erro


ll_contador_produtos_validade_diferente	= 0

select count(*)
Into :ll_contador_produtos_validade_diferente
from agrupamento_dev_compra_prd
where nr_agrupamento 			= :al_Agrupamento
and cd_produto 					= :al_Produto
and cd_endereco_localizacao 	= :as_Endereco
and nr_lote 						= :as_Lote
and dh_validade					<> :adh_Validade
Using SqlCa;

Choose Case SQLCA.SQLCode
	Case -1
		as_Erro = "Erro ao fazer a contagem do produto dentro do agrupamento com o mesmo lote. "+SqlCa.SqlErrtext
		Return False
End Choose

if ll_contador_produtos_validade_diferente > 0 then
	as_Erro = "Encontrado dentro do agrupamento j$$HEX1$$e100$$ENDHEX$$ registros do produto " + String(al_Produto) + " com o lote " + as_Lote + ", mas, com uma validade diferente de " + &
				 String(adh_Validade, 'dd/mm/yyyy') + ". Por favor ajustar as validades."
	Return False
end if

select qt_devolver
Into :ll_Qtde
from agrupamento_dev_compra_prd
where nr_agrupamento 			= :al_Agrupamento
and cd_produto 					= :al_Produto
and cd_endereco_localizacao 	= :as_Endereco
and nr_lote 							= :as_Lote
and dh_validade					= :adh_Validade
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0			
		Update agrupamento_dev_compra_prd
		Set 	qt_devolver = qt_devolver + :al_Qtde				
		where nr_agrupamento 			= :al_Agrupamento
		and cd_produto 					= :al_Produto
		and cd_endereco_localizacao 	= :as_Endereco
		and nr_lote 							= :as_Lote
		and dh_validade 					= :adh_Validade
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			as_Erro = "Erro ao atualizar a quantidade do produto. "+SqlCa.SqlErrtext
			Return False
		End If
	Case 100
//		//Limitando a quantidade de itens a 300 (chamado 1846433) para evitar exceder o limite na interface com o SAP
//		SELECT COUNT (*)
//		  INTO :ll_Qtde
//		  FROM agrupamento_dev_compra_prd
//		 WHERE nr_agrupamento = :al_Agrupamento
//		 USING SQLCA;
//		
//		If SQLCA.SQLCode < 0 then
//			as_Erro = 'Erro ao verificar a quantidade de itens do agrupamento: ' + SQLCA.SQLErrtext
//			Return False
//		End if
//		
//		If ll_Qtde >= ii_Limite_Itens_Agrupamento then
//			as_Erro = 'Este agrupamento j$$HEX1$$e100$$ENDHEX$$ atingiu o m$$HEX1$$e100$$ENDHEX$$ximo de itens (' + String (ii_Limite_Itens_Agrupamento) + '). N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel incluir mais itens!'
//			Return False
//		End if
		
		Insert Into agrupamento_dev_compra_prd(
			nr_agrupamento,
			cd_produto,
			cd_endereco_localizacao,
			nr_lote,
			qt_devolver,
			vl_preco,
			pc_desconto_forn,
			dh_validade,
			qt_peso_kg)
		Values(
			:al_Agrupamento,
			:al_Produto,
			:as_Endereco,
			:as_Lote,
			:al_Qtde,
			:adc_Preco,
			:adc_Desconto_Forn,
			:adh_Validade,
			:adc_Peso)
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			as_Erro = "Erro ao inserir o produto: "+SqlCa.SqlErrtext
			Return False
		End If
	Case -1 
		as_Erro = "Erro ao localizar o produto: "+SqlCa.SqlErrtext
		Return False
End Choose

//SqlCa.of_Commit()
Return True
end function

public function boolean of_localiza_preco_reposicao (long al_produto, ref decimal adc_preco_reposicao, ref decimal adc_desconto_fornecedor, ref decimal adc_peso, ref string as_erro);Select 	a.vl_preco_reposicao, 
			a.pc_desconto_fornecedor,
			Case When a.qt_peso_kg_estoque is null Then
					b.qt_peso_grama
				Else
					a.qt_peso_kg_estoque
			End as qt_peso
Into :adc_preco_reposicao,
	  :adc_desconto_fornecedor,
	  :adc_Peso
From	produto_central a
Inner Join produto_geral b on b.cd_produto = a.cd_produto
Where a.cd_produto =:al_Produto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If adc_Preco_Reposicao < 0 Then
			as_Erro = "O pre$$HEX1$$e700$$ENDHEX$$o de reposi$$HEX2$$e700e300$$ENDHEX$$o esta com o valor negativo."
			Return False
		End If
	Case 100
		as_Erro = "O pre$$HEX1$$e700$$ENDHEX$$o de reposi$$HEX2$$e700e300$$ENDHEX$$o do produto n$$HEX1$$e300$$ENDHEX$$o foi localizado."
		Return False
	Case -1 
		as_Erro = "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do valor de reposi$$HEX2$$e700e300$$ENDHEX$$o do produto: "+SqlCa.SqlErrText
		Return False
End Choose

Return True
	

end function

public function boolean of_atualiza_reserva_item_nf_compra_lote (long al_filial, string as_fornecedor, long al_nota, string as_especie, string as_serie, long al_natureza_operacao, long al_produto, string as_lote, long al_qt_reserva, ref string as_erro);Decimal 	ldc_Qt_Recebida,&
			ldc_Qt_Reserva
			
//Valida para a quantidade de reserva n$$HEX1$$e300$$ENDHEX$$o ser maior do que a quantidade recebida
Select 	qt_lote,
			isnull(qt_reserva_devolucao, 0) + :al_Qt_Reserva
Into 	:ldc_Qt_Recebida,
		:ldc_Qt_Reserva
From 	item_nf_compra_lote
Where cd_filial 						= :al_Filial
	and cd_fornecedor 			= :as_Fornecedor
	and nr_nf 						= :al_Nota
	and de_especie 				= :as_Especie
	and de_serie 					= :as_Serie
	and cd_natureza_operacao 	= :al_Natureza_Operacao
	and cd_produto 				= :al_Produto
	and nr_lote 						= :as_Lote
Using SqlCa;

If  SqlCa.SqlCode = -1 Then
	as_Erro = "Erro ao validar a quantidade de reserva: "+SqlCa.SqlErrText
	Return False
End If
	
If ldc_Qt_Reserva > ldc_Qt_Recebida Then
	as_Erro = "A quantidade de reserva $$HEX1$$e900$$ENDHEX$$ maior do que a quantidade recebida."
	Return False
End If

//Atualiza a quantidade de reserva
Update item_nf_compra_lote
Set qt_reserva_devolucao = isnull(qt_reserva_devolucao, 0) + :al_Qt_Reserva
Where cd_filial 						= :al_Filial
	and cd_fornecedor 			= :as_Fornecedor
	and nr_nf 						= :al_Nota
	and de_especie 				= :as_Especie
	and de_serie 					= :as_Serie
	and cd_natureza_operacao 	= :al_Natureza_Operacao
	and cd_produto 				= :al_Produto
	and nr_lote 						= :as_Lote
Using SqlCa;

If  SqlCa.SqlCode = -1 Then
	as_Erro = "Erro ao atualizar a reserva de devolu$$HEX2$$e700e300$$ENDHEX$$o na tabela 'item_nf_compra_lote': "+SqlCa.SqlErrText
	Return False
End If

If SqlCa.Sqlnrows < 1 Then
	as_Erro = "N$$HEX1$$e300$$ENDHEX$$o foi atualizado a reserva da nota no agrupamento.~rLinhas alteradas: "+String(SqlCa.Sqlnrows)														
	Return False
End If

Return True
end function

public function boolean of_atualiza_valor_agrupamento (long al_agrupamento, string as_destino_final, ref string as_erro);Decimal{2} lvdc_Valor_Agrupamento

If as_Destino_Final = "N" Then //Nota de devolu$$HEX2$$e700e300$$ENDHEX$$o

	Update agrupamento_dev_compra
	Set vl_agrupamento = (select sum(round(b.qt_devolver * round(b.vl_preco_unitario * ((100 - b.pc_desconto) / 100), 2), 2))
												From agrupamento_dev_compra_prd_nf  b
												Where b.nr_agrupamento = a.nr_agrupamento)
	From agrupamento_dev_compra a
	Where nr_agrupamento = :al_agrupamento
	Using SqlCa;
	
	If  SqlCa.SqlCode = -1 Then
		as_Erro = "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do volor do agrupamento: "+SqlCa.SqlErrText
		Return False
	End If
	
Else

	Update agrupamento_dev_compra
	Set vl_agrupamento = (select sum(round(b.qt_devolver * round(b.vl_preco * ((100 - b.pc_desconto_forn) / 100), 2), 2))
												From agrupamento_dev_compra_prd b
												Where b.nr_agrupamento = a.nr_agrupamento)
	From agrupamento_dev_compra a
	Where nr_agrupamento = :al_agrupamento
	Using SqlCa;
	
	If  SqlCa.SqlCode = -1 Then
		as_Erro = "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do volor do agrupamento: "+SqlCa.SqlErrText
		Return False
	End If
	
End If

//Atualiza o peso do agrupamento
Update agrupamento_dev_compra
Set qt_peso_kg = (select sum(round(b.qt_devolver * b.qt_peso_kg, 2))
											From agrupamento_dev_compra_prd  b
											Where b.nr_agrupamento = a.nr_agrupamento)
From agrupamento_dev_compra a
Where nr_agrupamento = :al_agrupamento
Using SqlCa;

If  SqlCa.SqlCode = -1 Then
	as_Erro = "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do volor do agrupamento: "+SqlCa.SqlErrText
	Return False
End If


Return True
end function

public function boolean of_localiza_nota_compra_perf_vencido (long al_filial, string as_fornecedor, long al_nota_compra, string as_serie_compra, long al_produto, string as_lote, string as_endereco, long al_motivo_devolucao, ref string as_fornecedor_compra, ref long al_nota, ref string as_especie, ref string as_serie, ref long al_natureza_operacao, ref long al_qt_localizada, ref decimal adc_preco_unitario, ref decimal adc_pc_desconto, ref boolean ab_possui_nota_compra, ref string as_lote_retorno, ref string as_erro);dc_uo_ds_base 	lds_Notas_Origem
	
ab_Possui_Nota_Compra = False
SetNull(as_Erro)
Try
	Try
		lds_Notas_Origem = Create dc_uo_ds_base
		
	
		If Not lds_Notas_Origem.of_ChangeDataObject("ds_ge252_notas_entrada_segregados") Then
			Return False
		End If
		
		lds_Notas_Origem.of_AppendWhere_Subquery("a.cd_fornecedor = '"+as_Fornecedor+"'", 1)
		lds_Notas_Origem.of_AppendWhere_Subquery("a.cd_fornecedor = '"+as_Fornecedor+"'", 2)
		
		//Para perfumaria vencido, localiza as notas com entrada anterior a 12 meses
		lds_Notas_Origem.of_AppendWhere_Subquery("a.dh_entrada <  dateadd(month, 12, cast(getDate() as date))", 1)
		lds_Notas_Origem.of_AppendWhere_Subquery("a.dh_entrada <  dateadd(month, 12, cast(getDate() as date))", 2)
		
		If Not IsNull(al_Nota_Compra) Then
			lds_Notas_Origem.of_AppendWhere_Subquery("a.nr_nf = "+String(al_Nota_Compra), 1)
			lds_Notas_Origem.of_AppendWhere_Subquery("a.nr_nf = "+String(al_Nota_Compra), 2)
		End If
		
		If Not IsNull(as_Serie_Compra) Then
			lds_Notas_Origem.of_AppendWhere_Subquery("a.de_serie = '"+as_Serie_Compra+"'", 1)
			lds_Notas_Origem.of_AppendWhere_Subquery("a.de_serie = '"+as_Serie_Compra+"'", 2)
		End If
		
		lds_Notas_Origem.Retrieve(al_Filial, al_Produto, as_Lote)
		
		If lds_Notas_Origem.RowCount( ) > 0 Then
		
		
			as_Fornecedor_Compra	= lds_Notas_Origem.Object.cd_fornecedor				[1]
			al_Nota						= lds_Notas_Origem.Object.nr_nf							[1]
			as_Especie					= lds_Notas_Origem.Object.de_especie					[1]
			as_Serie						= lds_Notas_Origem.Object.de_serie						[1]
			al_Natureza_Operacao	= lds_Notas_Origem.Object.cd_natureza_operacao	[1]
			al_Qt_Localizada			= lds_Notas_Origem.Object.qt_lote						[1]
			adc_Preco_Unitario		= lds_Notas_Origem.Object.vl_preco_unitario			[1]
			adc_Pc_Desconto			= lds_Notas_Origem.Object.pc_desconto					[1]
			as_Lote_Retorno			= lds_Notas_Origem.Object.nr_lote						[1]
			
			ab_Possui_Nota_Compra = True
		Else
			// Destino Final: Emitir NFD
			If is_Destino_Final = 'N' or is_Destino_Final = 'D' Then
				as_Erro = "N$$HEX1$$e300$$ENDHEX$$o foi localizado nenhuma Nota de Compra para o Fornecedor '"+as_Fornecedor+"' e produto "+String(al_Produto)+"."
				Return False
			End If
		End If
		
	Catch ( runtimeerror  lo_rte )
		as_Erro = "Ocorreu erro ao localizar a nota na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_localiza_nota_compra_perf_vencido' da classe 'uo_ge252_agrupamento_devolucao_compra'. Erro: "+lo_rte.GetMessage( )
		Return False						 
	End Try		

Finally
	Destroy(lds_Notas_Origem)
End Try

Return True

//
//
//
//
//Long 	ll_Nota,&
//		ll_Natureza_operacao,&
//		ll_Qt_Lote
//		
//String 	ls_Especie,&
//			ls_Serie,&
//			ls_Fornecedor,&
//			ls_Lote,&
//			ls_Nm_Fantasia,&
//			ls_Distribuidora 
//			
//Decimal 	ldc_Preco_Unitario	,&
//			ldc_Pc_Desconto
//			
//			
////Verifica se $$HEX1$$e900$$ENDHEX$$ distribuidora ou fornecedor
//Select 	nm_fantasia,
//			isnull(id_distribuidora, 'N')
//Into 	:ls_Nm_Fantasia,
//		:ls_Distribuidora
//From fornecedor
//Where cd_fornecedor = :as_Fornecedor
//Using SqlCa;
//
//Choose Case SqlCa.SqlCode
//	Case 100
//		as_Erro = "N$$HEX1$$e300$$ENDHEX$$o foi localizado o Fornecedor/Distribuidora."
//		Return False
//	Case -1	
//		as_Erro = "Erro ao verificar se $$HEX1$$e900$$ENDHEX$$ fornecedor ou distribuidora: "+SqlCa.SqlErrtext
//		Return False	
//End Choose
//
//ab_Possui_Nota_Compra = True			
//
////Primeira Tentativa
////Localiza a nota de compra pelo fornecedor, produto e lote
//select 	Top 1
//			a.cd_fornecedor,
//			a.nr_nf,
//			a.de_especie,
//			a.de_serie,
//			a.cd_natureza_operacao,
//			(b.qt_lote - (isnull(b.qt_devolvida, 0) + isnull(b.qt_reserva_devolucao, 0))) as qt_lote,
//			c.vl_preco_unitario,
//			c.pc_desconto,
//			a.nr_lote
//Into 	:ls_Fornecedor,
//		:ll_Nota,
//		:ls_Especie,
//		:ls_Serie,
//		:ll_Natureza_operacao,
//		:ll_Qt_Lote,
//		:ldc_Preco_Unitario,
//		:ldc_Pc_Desconto,
//		:ls_Lote
//from produto_lote_nf_entrada a
//inner join item_nf_compra_lote b on b.cd_filial 						= a.cd_filial
//											and b.cd_fornecedor 				= a.cd_fornecedor
//											and b.nr_nf 							= a.nr_nf
//											and b.de_especie 					= a.de_especie
//											and b.de_serie 						= a.de_serie
//											and b.cd_natureza_operacao 	= a.cd_natureza_operacao
//											and b.cd_produto 					= a.cd_produto
//											and b.nr_lote 						= a.nr_lote 
//inner join item_nf_compra c on  c.cd_filial 						= b.cd_filial
//									and c.cd_fornecedor 				= b.cd_fornecedor
//									and c.nr_nf 							= b.nr_nf
//									and c.de_especie 					= b.de_especie
//									and c.de_serie 						= b.de_serie
//									and c.cd_natureza_operacao	= b.cd_natureza_operacao
//									and c.cd_produto 					= b.cd_produto	
//inner join fornecedor d on d.cd_fornecedor = a.cd_fornecedor
//where  a.cd_filial 			= :al_Filial
//	and a.cd_fornecedor 	in (select cd_fornecedor from fornecedor where nr_cgc = (select nr_cgc from fornecedor where cd_fornecedor = :as_Fornecedor)) 
//	and a.cd_produto 		= :al_Produto
//	and a.nr_lote 			= :as_Lote	
//	and (d.id_situacao is null or d.id_situacao = 'A')
//	and  a.dh_entrada between  dateadd(year, -3, cast(getDate() as date)) and getDate() 
//	and (b.qt_lote - (isnull(b.qt_devolvida, 0) + isnull(b.qt_reserva_devolucao, 0))) > 0
//order by a.dh_entrada 
//Using SqlCa;
//
//Choose Case SqlCa.SqlCode
//	Case 0
//		as_Fornecedor_Compra	= ls_Fornecedor
//		al_Nota						= ll_Nota
//		as_Especie					= ls_Especie
//		as_Serie						= ls_Serie
//		al_Natureza_Operacao	= ll_Natureza_Operacao
//		al_Qt_Localizada			= ll_Qt_Lote
//		adc_Preco_Unitario		= ldc_Preco_Unitario
//		adc_Pc_Desconto			= ldc_Pc_Desconto
//		as_Lote_Retorno			= ls_Lote
//		Return True
//		
//	Case -1	
//		as_Erro = "Erro ao localizar a nota de compra: "+SqlCa.SqlErrtext
//		Return False
//		
//End Choose
//
//// Nesta tentativa o sistema ir$$HEX1$$e100$$ENDHEX$$ procurar o lote no XML
//select 	Top 1
//			a.cd_fornecedor,
//			a.nr_nf,
//			a.de_especie,
//			a.de_serie,
//			a.cd_natureza_operacao,
//			(b.qt_lote - (isnull(b.qt_devolvida, 0) + isnull(b.qt_reserva_devolucao, 0))) as qt_lote,
//			c.vl_preco_unitario,
//			c.pc_desconto,
//			a.nr_lote
//Into 	:ls_Fornecedor,
//		:ll_Nota,
//		:ls_Especie,
//		:ls_Serie,
//		:ll_Natureza_operacao,
//		:ll_Qt_Lote,
//		:ldc_Preco_Unitario,
//		:ldc_Pc_Desconto,
//		:ls_Lote
//from produto_lote_nf_entrada a
//inner join item_nf_compra_lote b on b.cd_filial 						= a.cd_filial
//											and b.cd_fornecedor 				= a.cd_fornecedor
//											and b.nr_nf 							= a.nr_nf
//											and b.de_especie 					= a.de_especie
//											and b.de_serie 						= a.de_serie
//											and b.cd_natureza_operacao 	= a.cd_natureza_operacao
//											and b.cd_produto 					= a.cd_produto
//											and b.nr_lote 						= a.nr_lote 
//inner join item_nf_compra c on  c.cd_filial 						= b.cd_filial
//									and c.cd_fornecedor 				= b.cd_fornecedor
//									and c.nr_nf 							= b.nr_nf
//									and c.de_especie 					= b.de_especie
//									and c.de_serie 						= b.de_serie
//									and c.cd_natureza_operacao	= b.cd_natureza_operacao
//									and c.cd_produto 					= b.cd_produto	
//
//inner join fornecedor d on d.cd_fornecedor = a.cd_fornecedor
//where  a.cd_filial 			= :al_Filial
//	and a.cd_fornecedor 	in (select cd_fornecedor from fornecedor where nr_cgc = (select nr_cgc from fornecedor where cd_fornecedor = :as_Fornecedor)) 
//	and a.cd_produto 		= :al_Produto
//	and (d.id_situacao is null or d.id_situacao = 'A')
//	and  a.dh_entrada between  dateadd(year, -3, cast(getDate() as date)) and getDate() 
//	and (b.qt_lote - (isnull(b.qt_devolvida, 0) + isnull(b.qt_reserva_devolucao, 0))) > 0
//	and exists (select * from nf_compra_pend_prd_lote_xml x
//					where x.cd_filial 					= a.cd_filial
//					  and x.cd_fornecedor 				= a.cd_fornecedor
//					  and x.nr_nf 							= a.nr_nf
//					  and x.de_especie 					= a.de_especie
//					  and x.cd_produto 					= a.cd_produto
//					  and x.nr_lote 							= :as_Lote)						
//order by a.dh_entrada
//Using SqlCa;
//	
//Choose Case SqlCa.SqlCode
//	Case 0
//		as_Fornecedor_Compra	= ls_Fornecedor
//		al_Nota						= ll_Nota
//		as_Especie					= ls_Especie
//		as_Serie						= ls_Serie
//		al_Natureza_Operacao	= ll_Natureza_Operacao
//		al_Qt_Localizada			= ll_Qt_Lote
//		adc_Preco_Unitario		= ldc_Preco_Unitario
//		adc_Pc_Desconto			= ldc_Pc_Desconto
//		as_Lote_Retorno			= ls_Lote
//		Return True
//		
//	Case -1	
//		as_Erro = "Erro ao localizar a nota de compra: "+SqlCa.SqlErrtext
//		Return False
//End Choose
//// T$$HEX1$$e900$$ENDHEX$$rmino tentativa de verifica$$HEX2$$e700e300$$ENDHEX$$o do lote no XML
//
//
//
////Segunda Tentativa
////Localiza a nota de compra de todos fornecedores, produto e lote
//
//If ls_Distribuidora <> "S" Then //Entra nessa condi$$HEX2$$e700e300$$ENDHEX$$o somente se for fornecedor
//	select 	Top 1
//				a.cd_fornecedor,
//				a.nr_nf,
//				a.de_especie,
//				a.de_serie,
//				a.cd_natureza_operacao,
//				(b.qt_lote - (isnull(b.qt_devolvida, 0) + isnull(b.qt_reserva_devolucao, 0))) as qt_lote,
//				c.vl_preco_unitario,
//				c.pc_desconto,
//				a.nr_lote
//	Into 	:ls_Fornecedor,
//			:ll_Nota,
//			:ls_Especie,
//			:ls_Serie,
//			:ll_Natureza_operacao,
//			:ll_Qt_Lote,
//			:ldc_Preco_Unitario,
//			:ldc_Pc_Desconto,
//			:ls_Lote
//	from produto_lote_nf_entrada a
//	inner join item_nf_compra_lote b on b.cd_filial 						= a.cd_filial
//												and b.cd_fornecedor 				= a.cd_fornecedor
//												and b.nr_nf 							= a.nr_nf
//												and b.de_especie 					= a.de_especie
//												and b.de_serie 						= a.de_serie
//												and b.cd_natureza_operacao 	= a.cd_natureza_operacao
//												and b.cd_produto 					= a.cd_produto
//												and b.nr_lote 						= a.nr_lote 
//	inner join item_nf_compra c on  c.cd_filial 						= b.cd_filial
//										and c.cd_fornecedor 				= b.cd_fornecedor
//										and c.nr_nf 							= b.nr_nf
//										and c.de_especie 					= b.de_especie
//										and c.de_serie 						= b.de_serie
//										and c.cd_natureza_operacao	= b.cd_natureza_operacao
//										and c.cd_produto 					= b.cd_produto	
//	inner join fornecedor d on d.cd_fornecedor = a.cd_fornecedor
//	where  a.cd_filial 		= :al_Filial
//		and a.cd_produto 	= :al_Produto
//		and a.nr_lote 		= :as_Lote
//		and (d.id_situacao is null or d.id_situacao = 'A')
//		and  a.dh_entrada between  dateadd(year, -3, cast(getDate() as date)) and getDate()
//		and (b.qt_lote - (isnull(b.qt_devolvida, 0) + isnull(b.qt_reserva_devolucao, 0))) > 0
//	order by a.dh_entrada
//	Using SqlCa;
//	
//	Choose Case SqlCa.SqlCode
//		Case 0
//			as_Fornecedor_Compra	= ls_Fornecedor
//			al_Nota						= ll_Nota
//			as_Especie					= ls_Especie
//			as_Serie						= ls_Serie
//			al_Natureza_Operacao	= ll_Natureza_Operacao
//			al_Qt_Localizada			= ll_Qt_Lote
//			adc_Preco_Unitario		= ldc_Preco_Unitario
//			adc_Pc_Desconto			= ldc_Pc_Desconto
//			as_Lote_Retorno			= ls_Lote
//			Return True
//			
//		Case -1	
//			as_Erro = "Erro ao localizar a nota de compra: "+SqlCa.SqlErrtext
//			Return False
//			
//	End Choose
//End If
//
////Terceira Tentativa
////Localiza a nota de compra pelo fornecedores, produto e qualquer lote
//select 	Top 1
//			a.cd_fornecedor,
//			a.nr_nf,
//			a.de_especie,
//			a.de_serie,
//			a.cd_natureza_operacao,
//			(b.qt_lote - (isnull(b.qt_devolvida, 0) + isnull(b.qt_reserva_devolucao, 0))) as qt_lote,
//			c.vl_preco_unitario,
//			c.pc_desconto,
//			a.nr_lote
//Into 	:ls_Fornecedor,
//		:ll_Nota,
//		:ls_Especie,
//		:ls_Serie,
//		:ll_Natureza_operacao,
//		:ll_Qt_Lote,
//		:ldc_Preco_Unitario,
//		:ldc_Pc_Desconto,
//		:ls_Lote
//from produto_lote_nf_entrada a
//inner join item_nf_compra_lote b on b.cd_filial 						= a.cd_filial
//											and b.cd_fornecedor 				= a.cd_fornecedor
//											and b.nr_nf 							= a.nr_nf
//											and b.de_especie 					= a.de_especie
//											and b.de_serie 						= a.de_serie
//											and b.cd_natureza_operacao 	= a.cd_natureza_operacao
//											and b.cd_produto 					= a.cd_produto
//											and b.nr_lote 						= a.nr_lote 
//inner join item_nf_compra c on  c.cd_filial 						= b.cd_filial
//									and c.cd_fornecedor 				= b.cd_fornecedor
//									and c.nr_nf 							= b.nr_nf
//									and c.de_especie 					= b.de_especie
//									and c.de_serie 						= b.de_serie
//									and c.cd_natureza_operacao	= b.cd_natureza_operacao
//									and c.cd_produto 					= b.cd_produto		
//inner join fornecedor d on d.cd_fornecedor = a.cd_fornecedor
//where  a.cd_filial 			= :al_Filial
//	and a.cd_fornecedor 	in (select cd_fornecedor from fornecedor where nr_cgc = (select nr_cgc from fornecedor where cd_fornecedor = :as_Fornecedor)) 
//	and a.cd_produto 		= :al_Produto
//	and (d.id_situacao is null or d.id_situacao = 'A')
//	and  a.dh_entrada between  dateadd(year, -3, cast(getDate() as date)) and getDate() 
//	and (b.qt_lote - (isnull(b.qt_devolvida, 0) + isnull(b.qt_reserva_devolucao, 0))) > 0
//order by a.dh_entrada
//Using SqlCa;
//Choose Case SqlCa.SqlCode
//	Case 0
//		as_Fornecedor_Compra	= ls_Fornecedor
//		al_Nota						= ll_Nota
//		as_Especie					= ls_Especie
//		as_Serie						= ls_Serie
//		al_Natureza_Operacao	= ll_Natureza_Operacao
//		al_Qt_Localizada			= ll_Qt_Lote
//		adc_Preco_Unitario		= ldc_Preco_Unitario
//		adc_Pc_Desconto			= ldc_Pc_Desconto
//		as_Lote_Retorno			= ls_Lote
//		Return True
//		
//	Case -1	
//		as_Erro = "Erro ao localizar a nota de compra: "+SqlCa.SqlErrtext
//		Return False
//		
//End Choose
//
////Quarta Tentativa
////Localiza a nota de compra de qualquer fornecedores, produto e qualquer lote
//
//If ls_Distribuidora <> "S" Then //Entra nessa condi$$HEX2$$e700e300$$ENDHEX$$o somente se for fornecedor
//	select 	Top 1
//				a.cd_fornecedor,
//				a.nr_nf,
//				a.de_especie,
//				a.de_serie,
//				a.cd_natureza_operacao,
//				(b.qt_lote - (isnull(b.qt_devolvida, 0) + isnull(b.qt_reserva_devolucao, 0))) as qt_lote,
//				c.vl_preco_unitario,
//				c.pc_desconto,
//				a.nr_lote
//	Into 	:ls_Fornecedor,
//			:ll_Nota,
//			:ls_Especie,
//			:ls_Serie,
//			:ll_Natureza_operacao,
//			:ll_Qt_Lote,
//			:ldc_Preco_Unitario,
//			:ldc_Pc_Desconto,
//			:ls_Lote
//	from produto_lote_nf_entrada a
//	inner join item_nf_compra_lote b on b.cd_filial 						= a.cd_filial
//												and b.cd_fornecedor 				= a.cd_fornecedor
//												and b.nr_nf 							= a.nr_nf
//												and b.de_especie 					= a.de_especie
//												and b.de_serie 						= a.de_serie
//												and b.cd_natureza_operacao 	= a.cd_natureza_operacao
//												and b.cd_produto 					= a.cd_produto
//												and b.nr_lote 						= a.nr_lote 
//	inner join item_nf_compra c on  c.cd_filial 						= b.cd_filial
//										and c.cd_fornecedor 				= b.cd_fornecedor
//										and c.nr_nf 							= b.nr_nf
//										and c.de_especie 					= b.de_especie
//										and c.de_serie 						= b.de_serie
//										and c.cd_natureza_operacao	= b.cd_natureza_operacao
//										and c.cd_produto 					= b.cd_produto	
//	inner join fornecedor d on d.cd_fornecedor = a.cd_fornecedor
//	where  a.cd_filial 			= :al_Filial
//		and a.cd_produto 		= :al_Produto
//		and (d.id_situacao is null or d.id_situacao = 'A')
//		and  a.dh_entrada between  dateadd(year, -3, cast(getDate() as date)) and getDate() 
//		and (b.qt_lote - (isnull(b.qt_devolvida, 0) + isnull(b.qt_reserva_devolucao, 0))) > 0
//	order by a.dh_entrada
//	Using SqlCa;
//	
//	Choose Case SqlCa.SqlCode
//		Case 0
//			as_Fornecedor_Compra	= ls_Fornecedor
//			al_Nota						= ll_Nota
//			as_Especie					= ls_Especie
//			as_Serie						= ls_Serie
//			al_Natureza_Operacao	= ll_Natureza_Operacao
//			al_Qt_Localizada			= ll_Qt_Lote
//			adc_Preco_Unitario		= ldc_Preco_Unitario
//			adc_Pc_Desconto			= ldc_Pc_Desconto
//			as_Lote_Retorno			= ls_Lote
//			Return True
//			
//		Case -1	
//			as_Erro = "Erro ao localizar a nota de compra: "+SqlCa.SqlErrtext
//			Return False
//			
//	End Choose
//End If
//
//ab_Possui_Nota_Compra = False
//
//If ls_Distribuidora = "S" Then
//	as_Erro = "N$$HEX1$$e300$$ENDHEX$$o foi localizada nenhuma nota de compra para a distribuidora "+ls_Nm_Fantasia+"("+as_Fornecedor+") e produto "+String(al_Produto)+"."
//Else
//	as_Erro = "N$$HEX1$$e300$$ENDHEX$$o foi localizado nenhuma nota de compra para o fornecedor "+ls_Nm_Fantasia+"("+as_Fornecedor+") e produto "+String(al_Produto)+"."
//End If
//
//Return True
end function

public function boolean of_localiza_nota_compra_produto (long al_filial, string as_fornecedor, long al_nota_compra, string as_serie_compra, long al_produto, string as_lote, string as_endereco, long al_motivo_devolucao, string as_subcategoria, ref string as_fornecedor_compra, ref long al_nota, ref string as_especie, ref string as_serie, ref long al_natureza_operacao, ref long al_qt_localizada, ref decimal adc_preco_unitario, ref decimal adc_pc_desconto, ref boolean ab_possui_nota_compra, ref string as_lote_retorno, ref string as_erro);dc_uo_ds_base 	lds_Notas_Origem
	
ab_Possui_Nota_Compra = False

Try
	Try
		lds_Notas_Origem = Create dc_uo_ds_base
		
	
		If Not lds_Notas_Origem.of_ChangeDataObject("ds_ge252_notas_entrada_segregados") Then
			Return False
		End If
		
		lds_Notas_Origem.of_AppendWhere_Subquery("a.cd_fornecedor = '"+as_Fornecedor+"'", 1)
		lds_Notas_Origem.of_AppendWhere_Subquery("a.cd_fornecedor = '"+as_Fornecedor+"'", 2)
		
		If Not IsNull(al_Nota_Compra) Then
			lds_Notas_Origem.of_AppendWhere_Subquery("a.nr_nf = "+String(al_Nota_Compra), 1)
			lds_Notas_Origem.of_AppendWhere_Subquery("a.nr_nf = "+String(al_Nota_Compra), 2)
		End If
		
		If Not IsNull(as_Serie_Compra) Then
			lds_Notas_Origem.of_AppendWhere_Subquery("a.de_serie = '"+as_Serie_Compra+"'", 1)
			lds_Notas_Origem.of_AppendWhere_Subquery("a.de_serie = '"+as_Serie_Compra+"'", 2)
		End If
		
		lds_Notas_Origem.Retrieve(al_Filial, al_Produto, as_Lote)
		
		If lds_Notas_Origem.RowCount( ) > 0 Then
		
		
			as_Fornecedor_Compra	= lds_Notas_Origem.Object.cd_fornecedor				[1]
			al_Nota						= lds_Notas_Origem.Object.nr_nf							[1]
			as_Especie					= lds_Notas_Origem.Object.de_especie					[1]
			as_Serie						= lds_Notas_Origem.Object.de_serie						[1]
			al_Natureza_Operacao	= lds_Notas_Origem.Object.cd_natureza_operacao	[1]
			al_Qt_Localizada			= lds_Notas_Origem.Object.qt_lote						[1]
			adc_Preco_Unitario		= lds_Notas_Origem.Object.vl_preco_unitario			[1]
			adc_Pc_Desconto			= lds_Notas_Origem.Object.pc_desconto					[1]
			as_Lote_Retorno			= lds_Notas_Origem.Object.nr_lote						[1]
			
			ab_Possui_Nota_Compra = True
		Else
			// Destino Final: Emitir NFD
			If is_Destino_Final = 'N' Then
				as_Erro = "N$$HEX1$$e300$$ENDHEX$$o foi localizado nenhuma nota de compra para o fornecedor '"+as_Fornecedor+"' e produto "+String(al_Produto)+"."
				Return False
			End If
		End If
		
	Catch ( runtimeerror  lo_rte )
		as_Erro = "Ocorreu erro ao localizar a nota na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_localiza_nota_compra_perf_vencido' da classe 'uo_ge252_agrupamento_devolucao_compra'. Erro: "+lo_rte.GetMessage( )
		Return False						 
	End Try		

Finally
	Destroy(lds_Notas_Origem)
End Try

Return True






//
//
//
//
//
//
//
//Long 	ll_Nota,&
//		ll_Natureza_operacao,&
//		ll_Meses_Entrada_Nota,&
//		ll_Qt_Lote
//		
//String 	ls_Especie,&
//			ls_Serie,&
//			ls_Fornecedor,&
//			ls_Lote,&
//			ls_Nm_Fantasia,&
//			ls_Distribuidora 
//			
//Decimal 	ldc_Preco_Unitario	,&
//			ldc_Pc_Desconto	
//			
////Verifica se $$HEX1$$e900$$ENDHEX$$ distribuidora ou fornecedor
//Select 	nm_fantasia,
//			isnull(id_distribuidora, 'N')
//Into 	:ls_Nm_Fantasia,
//		:ls_Distribuidora
//From fornecedor
//Where cd_fornecedor = :as_Fornecedor
//Using SqlCa;
//
//Choose Case SqlCa.SqlCode
//	Case 100
//		as_Erro = "N$$HEX1$$e300$$ENDHEX$$o foi localizado o Fornecedor/Distribuidora."
//		Return False
//	Case -1	
//		as_Erro = "Erro ao verificar se $$HEX1$$e900$$ENDHEX$$ fornecedor ou distribuidora: "+SqlCa.SqlErrtext
//		Return False	
//End Choose
//
//ab_Possui_Nota_Compra = True			
//
//ll_Meses_Entrada_Nota = -12		
//
//If al_motivo_devolucao = 2 or al_motivo_devolucao = 1 Then //Vencido ou Danificado
//	ll_Meses_Entrada_Nota = -20
//End If
//
////Subcategoria 2 -> Perfumaria
////Subcategoria 3 -> Popular
//If (as_subcategoria = "2") Or (as_subcategoria = "3") Then
//	ll_Meses_Entrada_Nota = -36 //3 anos
//End If
//
////Primeira Tentativa
////Localiza a nota de compra pelo fornecedor, produto e lote
//select 	Top 1
//			a.cd_fornecedor,
//			a.nr_nf,
//			a.de_especie,
//			a.de_serie,
//			a.cd_natureza_operacao,
//			(b.qt_lote - (isnull(b.qt_devolvida, 0) + isnull(b.qt_reserva_devolucao, 0))) as qt_lote,
//			c.vl_preco_unitario,
//			c.pc_desconto,
//			a.nr_lote
//Into 	:ls_Fornecedor,
//		:ll_Nota,
//		:ls_Especie,
//		:ls_Serie,
//		:ll_Natureza_operacao,
//		:ll_Qt_Lote,
//		:ldc_Preco_Unitario,
//		:ldc_Pc_Desconto,
//		:ls_Lote
//from produto_lote_nf_entrada a
//inner join item_nf_compra_lote b on b.cd_filial 						= a.cd_filial
//											and b.cd_fornecedor 				= a.cd_fornecedor
//											and b.nr_nf 							= a.nr_nf
//											and b.de_especie 					= a.de_especie
//											and b.de_serie 						= a.de_serie
//											and b.cd_natureza_operacao 	= a.cd_natureza_operacao
//											and b.cd_produto 					= a.cd_produto
//											and b.nr_lote 						= a.nr_lote 
//inner join item_nf_compra c on  c.cd_filial 						= b.cd_filial
//									and c.cd_fornecedor 				= b.cd_fornecedor
//									and c.nr_nf 							= b.nr_nf
//									and c.de_especie 					= b.de_especie
//									and c.de_serie 						= b.de_serie
//									and c.cd_natureza_operacao	= b.cd_natureza_operacao
//									and c.cd_produto 					= b.cd_produto	
//inner join fornecedor d on d.cd_fornecedor = a.cd_fornecedor
//where  a.cd_filial 			= :al_Filial
//	and a.cd_fornecedor 	in (select cd_fornecedor from fornecedor where nr_cgc = (select nr_cgc from fornecedor where cd_fornecedor = :as_Fornecedor)) 
//	and a.cd_produto 		= :al_Produto
//	and a.nr_lote 			= :as_Lote	
//	and (d.id_situacao is null or d.id_situacao = 'A')
//	//and  a.dh_entrada >= dateadd(month, :ll_Meses_Entrada_Nota, cast(getDate() as date))
//	and (b.qt_lote - (isnull(b.qt_devolvida, 0) + isnull(b.qt_reserva_devolucao, 0))) > 0
//order by a.dh_entrada
//Using SqlCa;
//
//Choose Case SqlCa.SqlCode
//	Case 0
//		as_Fornecedor_Compra	= ls_Fornecedor
//		al_Nota						= ll_Nota
//		as_Especie					= ls_Especie
//		as_Serie						= ls_Serie
//		al_Natureza_Operacao	= ll_Natureza_Operacao
//		al_Qt_Localizada			= ll_Qt_Lote
//		adc_Preco_Unitario		= ldc_Preco_Unitario
//		adc_Pc_Desconto			= ldc_Pc_Desconto
//		as_Lote_Retorno			= ls_Lote
//		Return True
//		
//	Case -1	
//		as_Erro = "Erro ao localizar a nota de compra: "+SqlCa.SqlErrtext
//		Return False
//		
//End Choose
//
//// Nesta tentativa o sistema ir$$HEX1$$e100$$ENDHEX$$ procurar o lote no XML
//select 	Top 1
//			a.cd_fornecedor,
//			a.nr_nf,
//			a.de_especie,
//			a.de_serie,
//			a.cd_natureza_operacao,
//			(b.qt_lote - (isnull(b.qt_devolvida, 0) + isnull(b.qt_reserva_devolucao, 0))) as qt_lote,
//			c.vl_preco_unitario,
//			c.pc_desconto,
//			a.nr_lote
//Into 	:ls_Fornecedor,
//		:ll_Nota,
//		:ls_Especie,
//		:ls_Serie,
//		:ll_Natureza_operacao,
//		:ll_Qt_Lote,
//		:ldc_Preco_Unitario,
//		:ldc_Pc_Desconto,
//		:ls_Lote
//from produto_lote_nf_entrada a
//inner join item_nf_compra_lote b on b.cd_filial 						= a.cd_filial
//											and b.cd_fornecedor 				= a.cd_fornecedor
//											and b.nr_nf 							= a.nr_nf
//											and b.de_especie 					= a.de_especie
//											and b.de_serie 						= a.de_serie
//											and b.cd_natureza_operacao 	= a.cd_natureza_operacao
//											and b.cd_produto 					= a.cd_produto
//											and b.nr_lote 						= a.nr_lote 
//inner join item_nf_compra c on  c.cd_filial 						= b.cd_filial
//									and c.cd_fornecedor 				= b.cd_fornecedor
//									and c.nr_nf 							= b.nr_nf
//									and c.de_especie 					= b.de_especie
//									and c.de_serie 						= b.de_serie
//									and c.cd_natureza_operacao	= b.cd_natureza_operacao
//									and c.cd_produto 					= b.cd_produto	
//
//inner join fornecedor d on d.cd_fornecedor = a.cd_fornecedor
//where  a.cd_filial 			= :al_Filial
//	and a.cd_fornecedor 	in (select cd_fornecedor from fornecedor where nr_cgc = (select nr_cgc from fornecedor where cd_fornecedor = :as_Fornecedor)) 
//	and a.cd_produto 		= :al_Produto
//	and (d.id_situacao is null or d.id_situacao = 'A')
//	and  a.dh_entrada >= dateadd(month, :ll_Meses_Entrada_Nota, cast(getDate() as date))
//	and (b.qt_lote - (isnull(b.qt_devolvida, 0) + isnull(b.qt_reserva_devolucao, 0))) > 0
//	and exists (select * from nf_compra_pend_prd_lote_xml x
//					where x.cd_filial 					= a.cd_filial
//					  and x.cd_fornecedor 				= a.cd_fornecedor
//					  and x.nr_nf 							= a.nr_nf
//					  and x.de_especie 					= a.de_especie
//					  and x.cd_produto 					= a.cd_produto
//					  and x.nr_lote 							= :as_Lote)						
//order by a.dh_entrada
//Using SqlCa;
//	
//Choose Case SqlCa.SqlCode
//	Case 0
//		as_Fornecedor_Compra	= ls_Fornecedor
//		al_Nota						= ll_Nota
//		as_Especie					= ls_Especie
//		as_Serie						= ls_Serie
//		al_Natureza_Operacao	= ll_Natureza_Operacao
//		al_Qt_Localizada			= ll_Qt_Lote
//		adc_Preco_Unitario		= ldc_Preco_Unitario
//		adc_Pc_Desconto			= ldc_Pc_Desconto
//		as_Lote_Retorno			= ls_Lote
//		Return True
//		
//	Case -1	
//		as_Erro = "Erro ao localizar a nota de compra: "+SqlCa.SqlErrtext
//		Return False
//End Choose
//// T$$HEX1$$e900$$ENDHEX$$rmino tentativa de verifica$$HEX2$$e700e300$$ENDHEX$$o do lote no XML
//
////Segunda Tentativa
////Localiza a nota de compra de todos fornecedores, produto e lote
//
//If ls_Distribuidora <> "S" Then //Entra nessa condi$$HEX2$$e700e300$$ENDHEX$$o somente se for fornecedor
//	select 	Top 1
//				a.cd_fornecedor,
//				a.nr_nf,
//				a.de_especie,
//				a.de_serie,
//				a.cd_natureza_operacao,
//				(b.qt_lote - (isnull(b.qt_devolvida, 0) + isnull(b.qt_reserva_devolucao, 0))) as qt_lote,
//				c.vl_preco_unitario,
//				c.pc_desconto,
//				a.nr_lote
//	Into 	:ls_Fornecedor,
//			:ll_Nota,
//			:ls_Especie,
//			:ls_Serie,
//			:ll_Natureza_operacao,
//			:ll_Qt_Lote,
//			:ldc_Preco_Unitario,
//			:ldc_Pc_Desconto,
//			:ls_Lote
//	from produto_lote_nf_entrada a
//	inner join item_nf_compra_lote b on b.cd_filial 						= a.cd_filial
//												and b.cd_fornecedor 				= a.cd_fornecedor
//												and b.nr_nf 							= a.nr_nf
//												and b.de_especie 					= a.de_especie
//												and b.de_serie 						= a.de_serie
//												and b.cd_natureza_operacao 	= a.cd_natureza_operacao
//												and b.cd_produto 					= a.cd_produto
//												and b.nr_lote 						= a.nr_lote 
//	inner join item_nf_compra c on  c.cd_filial 						= b.cd_filial
//										and c.cd_fornecedor 				= b.cd_fornecedor
//										and c.nr_nf 							= b.nr_nf
//										and c.de_especie 					= b.de_especie
//										and c.de_serie 						= b.de_serie
//										and c.cd_natureza_operacao	= b.cd_natureza_operacao
//										and c.cd_produto 					= b.cd_produto	
//	inner join fornecedor d on d.cd_fornecedor = a.cd_fornecedor
//	where  a.cd_filial 		= :al_Filial
//		and a.cd_produto 	= :al_Produto
//		and a.nr_lote 		= :as_Lote
//		and (d.id_situacao is null or d.id_situacao = 'A')
//		and  a.dh_entrada >= dateadd(month, :ll_Meses_Entrada_Nota, cast(getDate() as date))
//		and (b.qt_lote - (isnull(b.qt_devolvida, 0) + isnull(b.qt_reserva_devolucao, 0))) > 0
//	order by a.dh_entrada
//	Using SqlCa;
//	
//	Choose Case SqlCa.SqlCode
//		Case 0
//			as_Fornecedor_Compra	= ls_Fornecedor
//			al_Nota						= ll_Nota
//			as_Especie					= ls_Especie
//			as_Serie						= ls_Serie
//			al_Natureza_Operacao	= ll_Natureza_Operacao
//			al_Qt_Localizada			= ll_Qt_Lote
//			adc_Preco_Unitario		= ldc_Preco_Unitario
//			adc_Pc_Desconto			= ldc_Pc_Desconto
//			as_Lote_Retorno			= ls_Lote
//			Return True
//			
//		Case -1	
//			as_Erro = "Erro ao localizar a nota de compra: "+SqlCa.SqlErrtext
//			Return False
//			
//	End Choose
//End If
//
////Terceira Tentativa
////Localiza a nota de compra pelo fornecedores, produto e qualquer lote
//select 	Top 1
//			a.cd_fornecedor,
//			a.nr_nf,
//			a.de_especie,
//			a.de_serie,
//			a.cd_natureza_operacao,
//			(b.qt_lote - (isnull(b.qt_devolvida, 0) + isnull(b.qt_reserva_devolucao, 0))) as qt_lote,
//			c.vl_preco_unitario,
//			c.pc_desconto,
//			a.nr_lote
//Into 	:ls_Fornecedor,
//		:ll_Nota,
//		:ls_Especie,
//		:ls_Serie,
//		:ll_Natureza_operacao,
//		:ll_Qt_Lote,
//		:ldc_Preco_Unitario,
//		:ldc_Pc_Desconto,
//		:ls_Lote
//from produto_lote_nf_entrada a
//inner join item_nf_compra_lote b on b.cd_filial 						= a.cd_filial
//											and b.cd_fornecedor 				= a.cd_fornecedor
//											and b.nr_nf 							= a.nr_nf
//											and b.de_especie 					= a.de_especie
//											and b.de_serie 						= a.de_serie
//											and b.cd_natureza_operacao 	= a.cd_natureza_operacao
//											and b.cd_produto 					= a.cd_produto
//											and b.nr_lote 						= a.nr_lote 
//inner join item_nf_compra c on  c.cd_filial 						= b.cd_filial
//									and c.cd_fornecedor 				= b.cd_fornecedor
//									and c.nr_nf 							= b.nr_nf
//									and c.de_especie 					= b.de_especie
//									and c.de_serie 						= b.de_serie
//									and c.cd_natureza_operacao	= b.cd_natureza_operacao
//									and c.cd_produto 					= b.cd_produto		
//inner join fornecedor d on d.cd_fornecedor = a.cd_fornecedor
//where  a.cd_filial 			= :al_Filial
//	and a.cd_fornecedor 	in (select cd_fornecedor from fornecedor where nr_cgc = (select nr_cgc from fornecedor where cd_fornecedor = :as_Fornecedor)) 
//	and a.cd_produto 		= :al_Produto
//	and (d.id_situacao is null or d.id_situacao = 'A')
//	and  a.dh_entrada >= dateadd(month, :ll_Meses_Entrada_Nota, cast(getDate() as date))
//	and (b.qt_lote - (isnull(b.qt_devolvida, 0) + isnull(b.qt_reserva_devolucao, 0))) > 0
//order by a.dh_entrada
//Using SqlCa;
//Choose Case SqlCa.SqlCode
//	Case 0
//		as_Fornecedor_Compra	= ls_Fornecedor
//		al_Nota						= ll_Nota
//		as_Especie					= ls_Especie
//		as_Serie						= ls_Serie
//		al_Natureza_Operacao	= ll_Natureza_Operacao
//		al_Qt_Localizada			= ll_Qt_Lote
//		adc_Preco_Unitario		= ldc_Preco_Unitario
//		adc_Pc_Desconto			= ldc_Pc_Desconto
//		as_Lote_Retorno			= ls_Lote
//		Return True
//		
//	Case -1	
//		as_Erro = "Erro ao localizar a nota de compra: "+SqlCa.SqlErrtext
//		Return False
//		
//End Choose
//
////Quarta Tentativa
////Localiza a nota de compra de qualquer fornecedores, produto e qualquer lote
//
//If ls_Distribuidora <> "S" Then //Entra nessa condi$$HEX2$$e700e300$$ENDHEX$$o somente se for fornecedor
//	select 	Top 1
//				a.cd_fornecedor,
//				a.nr_nf,
//				a.de_especie,
//				a.de_serie,
//				a.cd_natureza_operacao,
//				(b.qt_lote - (isnull(b.qt_devolvida, 0) + isnull(b.qt_reserva_devolucao, 0))) as qt_lote,
//				c.vl_preco_unitario,
//				c.pc_desconto,
//				a.nr_lote
//	Into 	:ls_Fornecedor,
//			:ll_Nota,
//			:ls_Especie,
//			:ls_Serie,
//			:ll_Natureza_operacao,
//			:ll_Qt_Lote,
//			:ldc_Preco_Unitario,
//			:ldc_Pc_Desconto,
//			:ls_Lote
//	from produto_lote_nf_entrada a
//	inner join item_nf_compra_lote b on b.cd_filial 						= a.cd_filial
//												and b.cd_fornecedor 				= a.cd_fornecedor
//												and b.nr_nf 							= a.nr_nf
//												and b.de_especie 					= a.de_especie
//												and b.de_serie 						= a.de_serie
//												and b.cd_natureza_operacao 	= a.cd_natureza_operacao
//												and b.cd_produto 					= a.cd_produto
//												and b.nr_lote 						= a.nr_lote 
//	inner join item_nf_compra c on  c.cd_filial 						= b.cd_filial
//										and c.cd_fornecedor 				= b.cd_fornecedor
//										and c.nr_nf 							= b.nr_nf
//										and c.de_especie 					= b.de_especie
//										and c.de_serie 						= b.de_serie
//										and c.cd_natureza_operacao	= b.cd_natureza_operacao
//										and c.cd_produto 					= b.cd_produto	
//	inner join fornecedor d on d.cd_fornecedor = a.cd_fornecedor
//	where  a.cd_filial 			= :al_Filial
//		and a.cd_produto 		= :al_Produto
//		and (d.id_situacao is null or d.id_situacao = 'A')
//		and  a.dh_entrada >= dateadd(month, :ll_Meses_Entrada_Nota, cast(getDate() as date))
//		and (b.qt_lote - (isnull(b.qt_devolvida, 0) + isnull(b.qt_reserva_devolucao, 0))) > 0
//	order by a.dh_entrada
//	Using SqlCa;
//	
//	Choose Case SqlCa.SqlCode
//		Case 0
//			as_Fornecedor_Compra	= ls_Fornecedor
//			al_Nota						= ll_Nota
//			as_Especie					= ls_Especie
//			as_Serie						= ls_Serie
//			al_Natureza_Operacao	= ll_Natureza_Operacao
//			al_Qt_Localizada			= ll_Qt_Lote
//			adc_Preco_Unitario		= ldc_Preco_Unitario
//			adc_Pc_Desconto			= ldc_Pc_Desconto
//			as_Lote_Retorno			= ls_Lote
//			Return True
//			
//		Case -1	
//			as_Erro = "Erro ao localizar a nota de compra: "+SqlCa.SqlErrtext
//			Return False
//			
//	End Choose
//End If
//
//ab_Possui_Nota_Compra = False
//
//If ls_Distribuidora = "S" Then
//	as_Erro = "N$$HEX1$$e300$$ENDHEX$$o foi localizada nenhuma nota de compra para a distribuidora "+ls_Nm_Fantasia+"("+as_Fornecedor+") e produto "+String(al_Produto)+"."
//Else
//	as_Erro = "N$$HEX1$$e300$$ENDHEX$$o foi localizado nenhuma nota de compra para o fornecedor "+ls_Nm_Fantasia+"("+as_Fornecedor+") e produto "+String(al_Produto)+"."
//End If
//
//Return True
end function

public function boolean of_processa_descarte_nf_entrada (long al_filial, long al_agrupamento, string as_fornecedor, long al_produto, string as_lote, string as_endereco, long al_qtde, string as_destino_final, datetime adh_validade, ref decimal adc_preco_reposicao, ref decimal adc_desconto_fornecedor, ref string as_erro, ref long al_qtde_restante);Date	ldt_server_date, &
		ldt_movto_caixa

Long 	ll_Nota,&
		ll_cd_natureza_operacao,&
		ll_Qt_Localizada,&
		ll_Qt_Segregada,&
		ll_Qt_Localizada_Controle, &
		ll_nr_nf, &
	 	ll_cd_filial_origem
		
String	 	ls_Especie,&
			ls_Serie,&
			ls_Matricula,&
			ls_Fornecedor,&
			ls_de_especie, &
			ls_de_serie, &
			ls_nr_lote

Decimal 	ldc_Preco_Unitario,&
			ldc_Pc_Desconto,&
			ldc_Peso
			
Boolean lb_Possui_Nota_Compra = False

ll_Qt_Localizada				= 0
ll_Qt_Localizada_Controle	= 0
ll_Qt_Segregada 				= al_Qtde

DO
	ldt_server_date	= Date(gf_getserverdate())
	
	if Not gf_dateAdd(ldt_server_date, 'day', -90, ref ldt_movto_caixa) then
		as_erro	= 'Erro ao encontrar a data de movimenta$$HEX2$$e700e300$$ENDHEX$$o de caixa.'
		
		return false
	end if
	
	select top 1 Coalesce(qt_lote, 0) - Coalesce(qt_descartada, 0) - Coalesce(qt_reserva_descarte, 0),
			 n.nr_nf,
			 n.cd_filial_origem,
			 n.de_especie, 
			 n.de_serie,
			 lo.nr_lote,
			 lo.cd_natureza_operacao
	  into :ll_Qt_Localizada,
	  		 :ll_nr_nf,
			 :ll_cd_filial_origem,
			 :ls_de_especie,
			 :ls_de_serie,
			 :ls_nr_lote,
			 :ll_cd_natureza_operacao
	  from nf_transferencia n inner join item_nf_transferencia_lote lo on lo.cd_filial_origem = n.cd_filial_origem and 
	  																						 	 lo.nr_nf 				= n.nr_nf and 
																							    lo.de_especie 		= n.de_especie and 
																								 lo.de_serie 			= n.de_serie   
    where n.cd_filial_destino 		= 534 and
	 		 Coalesce(qt_lote, 0) - Coalesce(qt_descartada, 0) - Coalesce(qt_reserva_descarte, 0) > 0 and
			 n.dh_movimentacao_caixa 	>= :ldt_movto_caixa and
			 lo.cd_produto					= :al_produto and
			 lo.nr_lote						= :as_lote
 	order by n.dh_movimentacao_caixa;
 
	Choose Case SqlCa.SqlCode 
		Case 100
			al_qtde_restante = al_Qtde - ll_Qt_Localizada_Controle
			
			Return True
		Case -1
			as_erro	= 'Erro ao encontrar a nota de transfer$$HEX1$$ea00$$ENDHEX$$ncia.'
			
			return false
	End Choose
	
	If (ll_Qt_Localizada + ll_Qt_Localizada_Controle) >= al_Qtde Then
		ll_Qt_Localizada = al_Qtde - ll_Qt_Localizada_Controle
	End If
	
	If not This.of_Localiza_Preco_Reposicao(al_Produto, Ref adc_Preco_Reposicao, Ref adc_Desconto_Fornecedor, Ref ldc_Peso, Ref as_Erro) Then
		Return False
	End If
							
	If Not This.of_Insere_Agrupamento_Dev_Compra_Prd(	al_Agrupamento,&
																			al_Produto,&
																			as_Endereco,&
																			as_Lote,&
																			adh_Validade,&
																			adc_Preco_Reposicao,&
																			adc_Desconto_Fornecedor,&
																			ll_Qt_Localizada,&
																			ldc_Peso,&
																			Ref as_Erro) Then
		Return False																
	End If	
		
	If Not This.of_Insere_Agrupamento_Dev_Compra_Prd_Nf(	al_Agrupamento,&
																				al_Produto,&																	
																				as_Endereco,&
																				as_Lote,&
																				ll_cd_filial_origem,&
																				'053404705',&
																				ll_nr_nf,&
																				ls_de_Especie,&
																				ls_de_Serie,&
																				ll_cd_natureza_operacao,&
																				ll_Qt_Localizada,&
																				ldc_Preco_Unitario,&
																				ldc_Pc_Desconto,&
																				ls_nr_lote,&
																				Ref as_erro) Then
		Return False																	
	End If		
	
	update item_nf_transferencia_lote
	   set qt_reserva_descarte = coalesce(qt_reserva_descarte, 0) + :ll_Qt_Localizada
	 where nr_nf 					= :ll_nr_nf and
	  		 cd_filial_origem	= :ll_cd_filial_origem and
			 de_especie 		= :ls_de_especie and
			 de_serie 			= :ls_de_serie and
			 cd_produto			= :al_produto and
			 nr_lote				= :ls_nr_lote
	 Using SqlCa;
	 
	ls_Matricula = gvo_aplicacao.ivo_seguranca.nr_matricula
	
	If Not This.of_atualiza_valor_agrupamento(al_Agrupamento, as_destino_final, Ref as_Erro) Then 
		Return False
	End If
	
	If Not This.of_Movimenta_Produto(al_Produto,&
												as_Endereco,&
												is_Endereco_Agrupamento,&
												as_Lote,&
												adh_Validade,&
												ll_Qt_Localizada,&
												ls_Matricula,&
												"I",&
												al_Agrupamento, &
												Ref as_Erro) Then
		Return False
	End If

	ll_Qt_Localizada_Controle = ll_Qt_Localizada_Controle + ll_Qt_Localizada
LOOP WHILE ll_Qt_Localizada_Controle < ll_Qt_Segregada

Return True
end function

public function boolean of_movimenta_produto (long al_produto, string as_endereco_saida, string as_endereco_destino, string as_lote, datetime adh_validade, long al_qtde, string as_matricula, string as_tipo_movimento, long al_agrupamento, ref string as_erro);String 	ls_Endereco_Entrada,&
			ls_Matricula,&
			ls_Nulo
			
Long 	ll_Nr_Movimentacao,&
		ll_Nulo

ls_Matricula = as_Matricula //gvo_aplicacao.ivo_seguranca.nr_matricula
SetNull(ls_Endereco_Entrada)
SetNull(ls_Nulo)
SetNull(ll_Nulo)

If al_Produto = 709276 Then
	al_Produto = 709276
End If

io_Movimentacao.ivb_commit = false
If Not io_Movimentacao.of_insere_movimentacao(	ls_Endereco_Entrada,&
																	as_Endereco_Saida,&
																	al_Produto,&
																	1,&
																	as_Lote,&
																	Date(adh_Validade),&
																	al_Qtde,&
																	as_Tipo_Movimento,&
																	ll_Nulo,&
																	ls_Nulo,&
																	al_agrupamento, &
																	'AGP',          &
																	ls_Nulo,&
																	ls_Matricula) Then
	Return False
End If																		


//Se o tipo de movimento for 'J' AJUSTE DE SAIDA, o produto n$$HEX1$$e300$$ENDHEX$$o fica em movimenta$$HEX2$$e700e300$$ENDHEX$$o
If as_Tipo_Movimento = "J" Then
	Return True
End If

	//Pega o n$$HEX1$$fa00$$ENDHEX$$mero da movimenta$$HEX2$$e700e300$$ENDHEX$$o
select 	nr_movimentacao
Into 		:ll_Nr_Movimentacao
from wms_movimentacao
where cd_produto 						= :al_Produto
and	nr_matricula_responsavel 	= :ls_Matricula
and 	cd_endereco_saida 			= :as_Endereco_Saida
and 	nr_lote							= :as_Lote
and	qt_caixa_padrao 				= 1
and 	dh_validade 					= :adh_Validade
and id_tipo_movimento = :as_Tipo_Movimento // Tipo 'I' Movimento para agrupamento segregado
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case -1		
		as_Erro = "Erro selecionar dados do produto: "+ SqlCa.SQLErrText	
		Return False
		
	Case 100
		as_Erro = "Produto n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ em movimenta$$HEX2$$e700e300$$ENDHEX$$o."	
		Return False	
End Choose

If Not io_Movimentacao.of_Atualiza_Movimentacao(	as_Endereco_Destino,&
																	al_Produto,&
																	ll_Nr_Movimentacao,&
																	al_Qtde,&
																	as_Lote,&
																	1,&
																	adh_Validade) Then
	Return False
End If
	
Return True
end function

public function boolean of_insere_agrupamento_dev_compra_prd_nf (long al_agrupamento, long al_produto, string as_endereco, string as_lote, long al_filial, string as_fornecedor, long al_nota, string as_especie, string as_serie, long al_natureza_operacao, long al_qt_devolver, decimal adc_preco_unitario, decimal adc_pc_desconto, string as_lote_nota, ref string as_erro);Long ll_Qtde

Select count(*)
Into :ll_Qtde
From agrupamento_dev_compra_prd_nf
Where 	nr_agrupamento				= :al_agrupamento
	and	cd_produto						= :al_Produto
	and	cd_endereco_localizacao		= :as_Endereco
	and	nr_lote							= :as_Lote //Aqui em teoria deveria ser usado o nr_lote_nf
	and	cd_filial						= :al_Filial
	and	cd_fornecedor					= :as_Fornecedor
	and	nr_nf								= :al_Nota
	and	de_especie						= :as_Especie
	and	de_serie							= :as_Serie
	and	cd_natureza_operacao			= :al_Natureza_Operacao
	and 	nr_lote_nf						= :as_lote_nota
Using SqlCa;	

If  SqlCa.SqlCode = -1 Then
	as_Erro = "Erro ao verificar se j$$HEX1$$e100$$ENDHEX$$ existe o registro na tabela 'agrupamento_dev_compra_prd_nf': "+SqlCa.SqlErrText
	Return False
End If

If ll_Qtde = 0 Then
		//Limitando a quantidade de itens por nota (chamado 1887642) para evitar exceder o limite na interface com o SAP
		SELECT COUNT (*)
		  INTO :ll_Qtde
		  FROM agrupamento_dev_compra_prd_nf
		 WHERE nr_agrupamento = :al_Agrupamento
		 	AND cd_filial      = :al_Filial
		 	AND cd_fornecedor  = :as_Fornecedor
		 	AND nr_nf          = :al_Nota
		 	AND de_especie     = :as_Especie
		 	AND de_serie       = :as_Serie
		 USING SQLCA;
		
		If SQLCA.SQLCode < 0 then
			as_Erro = 'Erro ao verificar a quantidade de itens na nota fiscal ' + String (al_Nota) + ' do agrupamento: ' + SQLCA.SQLErrtext
			Return False
		End if
		
		If ll_Qtde >= ii_Limite_Itens_Agrupamento then
			as_Erro = 'Esta nota do agrupamento j$$HEX1$$e100$$ENDHEX$$ atingiu o m$$HEX1$$e100$$ENDHEX$$ximo de itens (' + String (ii_Limite_Itens_Agrupamento) + '). N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel incluir mais itens!'
			Return False
		End if
		
	insert into agrupamento_dev_compra_prd_nf(
		nr_agrupamento,
		cd_produto,
		cd_endereco_localizacao,
		nr_lote,
		cd_filial,
		cd_fornecedor,
		nr_nf,
		de_especie,
		de_serie,
		cd_natureza_operacao,
		qt_devolver,
		vl_preco_unitario,
		pc_desconto,
		nr_lote_nf)
	Values(
		:al_agrupamento,
		:al_Produto,
		:as_Endereco,
		:as_Lote,
		:al_Filial,
		:as_Fornecedor,
		:al_Nota,
		:as_Especie,
		:as_Serie,
		:al_Natureza_Operacao,
		:al_Qt_Devolver,
		:adc_Preco_Unitario,
		:adc_Pc_Desconto,
		:as_Lote_Nota)
	Using SqlCa;
	
	If  SqlCa.SqlCode = -1 Then
		as_Erro = "Erro ao inserir dados na tabela 'agrupamento_dev_compra_prd_nf': "+SqlCa.SqlErrText
		Return False
	End If
Else
	Update agrupamento_dev_compra_prd_nf
	Set qt_devolver = qt_devolver + :al_Qt_Devolver
	Where 	nr_agrupamento					= :al_agrupamento
		and	cd_produto						= :al_Produto
		and	cd_endereco_localizacao		= :as_Endereco
		and	nr_lote							= :as_Lote
		and	cd_filial						= :al_Filial
		and	cd_fornecedor					= :as_Fornecedor
		and	nr_nf								= :al_Nota
		and	de_especie						= :as_Especie
		and	de_serie							= :as_Serie
		and	cd_natureza_operacao			= :al_Natureza_Operacao
		and 	nr_lote_nf						= :as_lote_nota
	Using SqlCa;	
	
	If  SqlCa.SqlCode = -1 Then
		as_Erro = "Erro ao atualizar a coluna 'qt_devolver' da tabela  'agrupamento_dev_compra_prd_nf': "+SqlCa.SqlErrText
		Return False
	End If
End If

Return True
end function

public function boolean of_carrega_parametros (ref string as_erro);String	ls_parametro = 'QT_LIMITE_ITENS_AGRUPAMENTO'

SELECT CAST (vl_parametro AS INTEGER)
  INTO :ii_Limite_Itens_Agrupamento
  FROM wms_parametro
 WHERE cd_parametro = :ls_parametro
 USING SQLCA;

Choose case SQLCA.SQLCode
	case is < 0
		as_erro = 'Erro ao buscar o par$$HEX1$$e200$$ENDHEX$$metro ' + ls_parametro + ': ' + SQLCA.SQLErrText
		Return False
	case 100
		as_erro = 'Par$$HEX1$$e200$$ENDHEX$$metro ' + ls_parametro + ' n$$HEX1$$e300$$ENDHEX$$o cadastrado!' 
		Return False
End choose

Return True
end function

public function boolean of_processa_devolucao_compra (long al_filial, long al_agrupamento, string as_fornecedor, long al_nota, string as_serie, long al_produto, string as_lote, string as_endereco, long al_qtde, string as_destino_final, datetime adh_validade, long al_motivo_devolucao, string as_subcategoria, ref decimal adc_preco_reposicao, ref decimal adc_desconto_fornecedor, ref uo_ge040_args auo_args[], ref string as_erro);Long 	ll_Qtde, &
		ll_Nota,&
		ll_Natureza_Operacao,&
		ll_Qt_Localizada,&
		ll_Qt_Segregada,&
		ll_Qt_Localizada_Controle,&
		ll_index
		
String	 	ls_Especie,&
			ls_Serie,&
			ls_Matricula,&
			ls_Fornecedor,&
			ls_Lote_Nota

Decimal 	ldc_Preco_Unitario,&
			ldc_Pc_Desconto,&
			ldc_Peso
			
Boolean lb_Possui_Nota_Compra = False

ll_Qt_Localizada				= 0
ll_Qt_Localizada_Controle	= 0
ll_Qt_Segregada 	= al_Qtde

DO
	//Subcategoria 2 -> Perfumaria
	//Subcategoria 3 -> Popular
	//al_motivo_devolucao 2 -> Vencido
	
	If (as_subcategoria = "2" Or as_subcategoria = "3") And al_motivo_devolucao = 2 Then
		if not (ib_Iniciado_Operacao_SAP and as_destino_final = 'D') then
			If Not This.of_localiza_nota_compra_perf_vencido(	al_Filial,&
																				as_Fornecedor,&
																				al_Nota,&
																				as_Serie,&
																				al_Produto,&
																				as_Lote,&
																				as_Endereco,&
																				al_motivo_devolucao,&
																				Ref ls_Fornecedor,&
																				Ref ll_Nota,&
																				Ref ls_Especie,&
																				Ref ls_Serie,&
																				Ref ll_Natureza_Operacao,&
																				Ref ll_Qt_Localizada,&
																				Ref ldc_Preco_Unitario,&
																				Ref ldc_Pc_Desconto,&
																				Ref lb_Possui_Nota_Compra,&
																				Ref ls_Lote_Nota,&
																				Ref as_erro) Then
				Return False
			End If
		end if
	Else
		If Not This.of_localiza_nota_compra_produto(	al_Filial,&
																	as_Fornecedor,&
																	al_Nota,&
																	as_Serie,&
																	al_Produto,&
																	as_Lote,&
																	as_Endereco,&
																	al_motivo_devolucao,&
																	as_subcategoria,&
																	Ref ls_Fornecedor,&
																	Ref ll_Nota,&
																	Ref ls_Especie,&
																	Ref ls_Serie,&
																	Ref ll_Natureza_Operacao,&
																	Ref ll_Qt_Localizada,&
																	Ref ldc_Preco_Unitario,&
																	Ref ldc_Pc_Desconto,&
																	Ref lb_Possui_Nota_Compra,&
																	Ref ls_Lote_Nota,&
																	Ref as_erro) Then
			Return False
		End If
	End If	
	
	// Se o destino for para emitir NF fiscal de devolu$$HEX2$$e700e300$$ENDHEX$$o ou se j$$HEX1$$e100$$ENDHEX$$ tiver iniciado a opera$$HEX2$$e700e300$$ENDHEX$$o do SAP
	If as_destino_final = 'N' and ib_Iniciado_Operacao_SAP Then
		If Not lb_Possui_Nota_Compra Then
			SqlCa.of_RollBack()
			If ll_Qt_Localizada_Controle = 0 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", as_erro)
				as_erro = ""
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Foi localizado apenas "+String(ll_Qt_Localizada_Controle)+" itens em notas de compra do produto "+String(al_Produto)+&
												".~rEssa $$HEX1$$e900$$ENDHEX$$ a quantidade que pode ser agrupada." )
			End If
			
			Return False	
		End If
	End If
	
	// Se existir nota de compra e o destino for para DESCARTE
	If lb_Possui_Nota_Compra and as_destino_final = 'D' Then
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Esse $$HEX1$$e900$$ENDHEX$$ um agrupamento de DESCARTE.~r"+&
											"O produto "+String(al_Produto)+" possui nota fiscal de compra.~r"+&
											"Deseja incluir o produto mesmo assim?", Question!, YesNo!, 2) = 2 Then
			SqlCa.of_RollBack()
			
			Return False
		End If
	End If
	
	// Considera tamb$$HEX1$$e900$$ENDHEX$$m se n$$HEX1$$e300$$ENDHEX$$o localizou mais nada, neste caso coloca o
	// saldo no agrupamento sem NF de origem
	If (ll_Qt_Localizada + ll_Qt_Localizada_Controle) >= al_Qtde or ll_Qt_Localizada = 0 Then
		ll_Qt_Localizada = al_Qtde - ll_Qt_Localizada_Controle
	End If
	
	If not This.of_Localiza_Preco_Reposicao(al_Produto, Ref adc_Preco_Reposicao, Ref adc_Desconto_Fornecedor, Ref ldc_Peso, Ref as_Erro) Then
		Return False
	End If
	
	//alteracao
	If not lb_Possui_Nota_Compra then
		//Limitando a quantidade de itens (chamado 1846433) para evitar exceder o limite na interface com o SAP
		SELECT COUNT (*)
		  INTO :ll_Qtde
		  FROM agrupamento_dev_compra_prd adcp
		 WHERE adcp.nr_agrupamento = :al_Agrupamento
		 	AND NOT EXISTS (SELECT 1 
			 						FROM agrupamento_dev_compra_prd_nf adcpn
								  WHERE adcpn.nr_agrupamento          = adcp.nr_agrupamento
								  	 AND adcpn.cd_produto              = adcp.cd_produto
								  	 AND adcpn.cd_endereco_localizacao = adcp.cd_endereco_localizacao
								  	 AND adcpn.nr_lote                 = adcp.nr_lote
								 )
		 USING SQLCA;
		
		If SQLCA.SQLCode < 0 then
			as_Erro = 'Erro ao verificar a quantidade de itens sem nota de origem do agrupamento: ' + SQLCA.SQLErrtext
			Return False
		End if
		
		If ll_Qtde >= ii_Limite_Itens_Agrupamento then
			as_Erro = 'Este agrupamento j$$HEX1$$e100$$ENDHEX$$ atingiu o m$$HEX1$$e100$$ENDHEX$$ximo de itens (' + String (ii_Limite_Itens_Agrupamento) + ') sem nota de origem. N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel incluir mais itens!'
			Return False
		End if
	End if
	//fim alteracao
	If Not This.of_Insere_Agrupamento_Dev_Compra_Prd(	al_Agrupamento,&
																			al_Produto,&
																			as_Endereco,&
																			as_Lote,&
																			adh_Validade,&
																			adc_Preco_Reposicao,&
																			adc_Desconto_Fornecedor,&
																			ll_Qt_Localizada,&
																			ldc_Peso,&
																			Ref as_Erro) Then
		Return False																
	End If	
	
	// Se n$$HEX1$$e300$$ENDHEX$$o possuir NF de compra n$$HEX1$$e300$$ENDHEX$$o insere no agrupamento e n$$HEX1$$e300$$ENDHEX$$o reserva
	If lb_Possui_Nota_Compra Then
		
		If Not This.of_Insere_Agrupamento_Dev_Compra_Prd_Nf(	al_Agrupamento,&
																					al_Produto,&																	
																					as_Endereco,&
																					as_Lote,&
																					al_Filial,&
																					ls_Fornecedor,&
																					ll_Nota,&
																					ls_Especie,&
																					ls_Serie,&
																					ll_Natureza_Operacao,&
																					ll_Qt_Localizada,&
																					ldc_Preco_Unitario,&
																					ldc_Pc_Desconto,&
																					ls_Lote_Nota,&
																					Ref as_erro) Then
			Return False																	
		End If																	
		
		If Not This.of_Atualiza_Reserva_Item_Nf_Compra_Lote(	al_Filial,&
																				ls_Fornecedor,&
																				ll_Nota,&
																				ls_Especie,&
																				ls_Serie,&
																				ll_Natureza_Operacao,&
																				al_Produto,&
																				ls_Lote_Nota,&
																				ll_Qt_Localizada,&
																				Ref as_erro) Then
			Return False																	
		End If
		
		
		ll_index = upperbound(auo_args) + 1
		
		
		auo_args[ll_index].of_add_arg('nr_agrupamento',al_Agrupamento)
		auo_args[ll_index].of_add_arg('cd_produto',al_Produto)
		auo_args[ll_index].of_add_arg('cd_filial',al_Filial)
		auo_args[ll_index].of_add_arg('cd_fornecedor',ls_Fornecedor)
		auo_args[ll_index].of_add_arg('nr_nf',ll_Nota)
		auo_args[ll_index].of_add_arg('de_especie',ls_Especie)
		auo_args[ll_index].of_add_arg('de_serie',ls_Serie)
		auo_args[ll_index].of_add_arg('cd_natureza',ll_Natureza_Operacao)
		auo_args[ll_index].of_add_arg('nr_lote',ls_Lote_Nota)
		auo_args[ll_index].of_add_arg('qt_lote',ll_Qt_Localizada)
	
	End If
	
	ls_Matricula = gvo_aplicacao.ivo_seguranca.nr_matricula
	
	If Not This.of_atualiza_valor_agrupamento(al_Agrupamento, as_destino_final, Ref as_Erro) Then 
		Return False
	End If
	
	If Not This.of_Movimenta_Produto(al_Produto,&
												as_Endereco,&
												is_Endereco_Agrupamento,&
												as_Lote,&
												adh_Validade,&
												ll_Qt_Localizada,&
												ls_Matricula,&
												"I",&
												al_Agrupamento, &
												Ref as_Erro) Then
		Return False
	End If

	ll_Qt_Localizada_Controle = ll_Qt_Localizada_Controle + ll_Qt_Localizada

LOOP WHILE ll_Qt_Localizada_Controle < ll_Qt_Segregada

Return True
end function

public function boolean of_insere_produto_no_agrupamento (long al_agrupamento, string as_fornecedor, long al_nota, string as_serie, long al_produto, string as_lote, string as_endereco, long al_qtde, string as_destino_final, datetime adh_validade, long al_motivo_devolucao, string as_subcategoria, ref decimal adc_preco_reposicao, ref decimal adc_desconto_fornecedor, ref uo_ge040_args auo_args[], ref string as_erro);Long 	ll_Nota,&
		ll_Natureza_Operacao,&
		ll_Qt_Localizada,&
		ll_Filial,&
		ll_Qt_Segregada,&
		ll_Qt_Localizada_Controle,&
		ll_verifica
		
String	 	ls_Especie,&
			ls_Serie
			
Decimal 	ldc_Preco_Unitario,&
			ldc_Pc_Desconto,&
			ldc_Preco_Reposicao,&
			ldc_Desconto_Fornecedor
			
Boolean lb_Possui_Nota_Compra = False

ll_Qt_Segregada = al_Qtde

ll_Filial = 534

// D - DESCARTE
// N - NOTA FISCAL DE DEVOLUCAO
is_Destino_Final = as_Destino_Final

If IsNull(is_Destino_Final) or (is_Destino_Final <> 'D' and is_Destino_Final <> 'N') Then
	as_erro = "Destino final inv$$HEX1$$e100$$ENDHEX$$lido - deve ser D - DESCARTE ou N - NOTA FISCAL DE DEVOLUCAO."
	Return False
End If

If not This.of_carrega_parametros (Ref as_erro) then
	Return False
End if

If as_Destino_Final = 'D' Then//Descarte
	If Not This.of_processa_Descarte_nova(	ll_Filial,&
														al_agrupamento,&
														as_fornecedor,&
														al_nota,&
														as_serie,&
														al_produto,&
														as_lote,&
														as_endereco,&
														al_qtde,&
														as_destino_final,&
														adh_validade,&
														al_motivo_devolucao,&
														as_subcategoria,&
														Ref adc_Preco_Reposicao,&
														Ref adc_Desconto_Fornecedor,&
														Ref auo_args,&
														Ref as_erro) Then
		Return False
	End If							 				
Else
	If Not This.of_Processa_Devolucao_Compra(	ll_Filial,&
																al_agrupamento,&
																as_fornecedor,&
																al_nota,&
																as_serie,&
																al_produto,&
																as_lote,&
																as_endereco,&
																al_qtde,&
																as_destino_final,&
																adh_validade,&
																al_motivo_devolucao,&
																as_subcategoria,&
																Ref adc_Preco_Reposicao,&
																Ref adc_Desconto_Fornecedor,&
																Ref auo_args,&
																Ref as_erro) Then
		Return False
	End If
End If

If as_Destino_Final <> 'D' Then
	SELECT
		count(*)
	INTO
		:ll_verifica
	FROM
		agrupamento_dev_compra adc
	INNER JOIN
		dbo.agrupamento_dev_compra_prd adcp 
		ON adc.nr_agrupamento = adcp.nr_agrupamento 
	WHERE 
		adc.nr_agrupamento = :al_agrupamento
	AND adcp.cd_produto = :al_produto
	AND (	SELECT
				sum(adcpn.qt_devolver) 
			FROM
				agrupamento_dev_compra_prd_nf adcpn
			WHERE
				adcpn.nr_agrupamento = adcp.nr_agrupamento 
				AND adcpn.cd_produto = adcp.cd_produto 
				AND adcpn.nr_lote = adcp.nr_lote 
				AND adcpn.cd_endereco_localizacao = adcp.cd_endereco_localizacao) <> adcp.qt_devolver;
	
	Choose Case SQLCA.SQLCode
		Case 0
			if ll_verifica > 0 then
				as_erro = 'Problema na adi$$HEX2$$e700e300$$ENDHEX$$o do produto ' + String(al_produto) + ' no agrupamento ' + String(al_agrupamento) + '. Favor verificar com a TI.'
				Return False
			end if
		Case -1
			as_erro = 'Erro ao validar a quantidade de produtos na tabela agrupamento_dev_compra_prd_nf. ~r~rErro: ' + SQLCA.SQLErrText
			Return False
	End Choose
End If

Return True
end function

public function boolean of_processa_descarte_nova (long al_filial, long al_agrupamento, string as_fornecedor, long al_nota, string as_serie, long al_produto, string as_lote, string as_endereco, long al_qtde, string as_destino_final, datetime adh_validade, long al_motivo_devolucao, string as_subcategoria, ref decimal adc_preco_reposicao, ref decimal adc_desconto_fornecedor, uo_ge040_args auo_args[], ref string as_erro);Long ll_Qtde_Faltante


If This.of_processa_descarte_nf_entrada(al_filial, &
													 al_agrupamento, &
													 as_fornecedor, &
													 al_produto, &
													 as_lote, &
													 as_endereco, &
													 al_qtde, &
													 as_destino_final, &
													 adh_validade, &
													 adc_preco_reposicao, &
													 adc_desconto_fornecedor, &
													 REF as_erro, &
													 REF ll_Qtde_Faltante) Then
												
	If ll_Qtde_Faltante > 0 Then
		If Not This.of_processa_devolucao_compra(al_filial, &
															  al_agrupamento, &
															  as_fornecedor, &
															  al_nota, &
															  as_serie, &
															  al_produto, &
															  as_lote, &
															  as_endereco, &
															  ll_Qtde_Faltante, &
															  as_destino_final, &
															  adh_validade, &
															  al_motivo_devolucao, &
															  as_subcategoria, &
															  adc_preco_reposicao, &
															  adc_desconto_fornecedor, &
															  REF auo_args,&
															  REF as_erro) Then
			Return False
		End If
	End If
End If

Return True
		
Return True
end function

public function boolean of_verificar_novo_agrupamento (long al_nr_agrupamento, ref string al_de_retorno);String ls_dt_agrupamento

Date ldt_dh_agrupamento

Select 
	vl_parametro
Into :ls_dt_agrupamento
From parametro_geral
Where cd_parametro = 'DH_INICIO_NOVO_FORMATO_AGRUPAMENTO'
Using Sqlca;

If SqlCa.SqlCode = -1 Then
	Sqlca.of_MsgDbError("Erro ao consultar o parametro_geral para o agrupamento novo.")
	Return False
End If

Select
	dh_inclusao
Into :ldt_dh_agrupamento
From agrupamento_dev_compra
Where nr_agrupamento = :al_nr_agrupamento
Using Sqlca;

If SqlCa.SqlCode = -1 Then
	Sqlca.of_MsgDbError("Erro ao consultar a data do agrupamento.")
	Return False
End If

If ldt_dh_agrupamento >= Date(ls_dt_agrupamento) Then
	al_de_retorno = 'S'
Else
	al_de_retorno = 'N'
End If


Return True

end function

public function boolean of_verificar_agrupamento_total_produto (long al_nr_agrupamento, ref string as_erro);Long ll_qt_total_nf,&
     ll_qt_total_compra,&		
     ll_qt_total_compra_nf

// Primeira verifica$$HEX2$$e700e300$$ENDHEX$$o
Select 
    Sum(qt_lote) 
Into
    :ll_qt_total_nf
From agrupamento_dev_com_prd_prt_nf 
Where nr_agrupamento = :al_nr_agrupamento
Using Sqlca;

If SqlCa.SqlCode = -1 Then
    as_erro = "Erro ao consultar quantidade de lotes na NF. Verifique o agrupamento " + String(al_nr_agrupamento) + "."
    Return False
End If

Select 
    Sum(qt_lote)
Into
    :ll_qt_total_compra
From agrupamento_dev_compra_prd_prt 
Where nr_agrupamento = :al_nr_agrupamento
Using Sqlca;

If SqlCa.SqlCode = -1 Then
    as_erro = "Erro ao consultar quantidade de lotes na compra(individual). Verifique o agrupamento " + String(al_nr_agrupamento) + "."
    Return False
End If

If ll_qt_total_nf <> ll_qt_total_compra Then
    as_erro = "Inconsist$$HEX1$$ea00$$ENDHEX$$ncia na quantidade de lotes entre NF (" + String(ll_qt_total_nf) + ") e compra (" + String(ll_qt_total_compra) + ") no agrupamento " + String(al_nr_agrupamento) + "."
    Return False
End If

// Segunda verifica$$HEX2$$e700e300$$ENDHEX$$o
Select
    Sum(qt_devolver)
Into 
    :ll_qt_total_compra_nf
From agrupamento_dev_compra_prd_nf 																						
Where nr_agrupamento = :al_nr_agrupamento	
Using Sqlca;

If SqlCa.SqlCode = -1 Then
    as_erro = "Erro ao consultar quantidade a devolver. Verifique o agrupamento " + String(al_nr_agrupamento) + "."
    Return False
End If

If ll_qt_total_nf <> ll_qt_total_compra_nf Then
    as_erro = "Inconsist$$HEX1$$ea00$$ENDHEX$$ncia entre NF e compra no agrupamento " + String(al_nr_agrupamento) + "."
    Return False
End If

Return True
end function

public function boolean of_atualiza_agrupamento_protocolo (st_parametros_protocolo ast_parametros_protocolo, ref string as_erro);string ls_erro, ls_endereco, ls_lote, ls_protocolo
long ll_count, ll_linha, ll_qtd, ll_linhas, ll_produto, ll_motivo
Boolean lb_sucesso

dc_uo_ds_Base ds_agrupamento

ds_agrupamento = Create dc_uo_ds_base
If Not ds_agrupamento.of_ChangeDataObject('ds_ge252_lista_agrupamento_protocolo') Then
	as_erro = "Erro no changedata da 'ds_ge252_lista_agrupamento_protocolo'"
	Return false
End If

if not Isnull(ast_parametros_protocolo.cd_produto) Then
	ds_agrupamento.of_AppendWhere_Subquery("adc.cd_produto = " + string(ast_parametros_protocolo.cd_produto), 1)
	
	if not Isnull(ast_parametros_protocolo.nr_lote) Then
		ds_agrupamento.of_AppendWhere_Subquery("adc.nr_lote = '" + ast_parametros_protocolo.nr_lote + "'", 1)
	end if
	
	if not Isnull(ast_parametros_protocolo.cd_endereco_wms) Then
		ds_agrupamento.of_AppendWhere_Subquery("adc.cd_endereco_localizacao = '" + ast_parametros_protocolo.cd_endereco_wms + "'", 1)
	end if
end if

ds_agrupamento.retrieve(ast_parametros_protocolo.nr_agrupamento)
ll_linhas = ds_agrupamento.rowcount()

For ll_linha = 1 to ll_linhas
	
	ll_produto 			= ds_agrupamento.object.cd_produto[ll_linha]
	ls_endereco 		= ds_agrupamento.object.cd_endereco_localizacao[ll_linha]
	ls_lote 				= ds_agrupamento.object.nr_lote[ll_linha]
	ls_protocolo 		= ds_agrupamento.object.nr_protocolo[ll_linha]
	ll_qtd 					= ds_agrupamento.object.qt_lote[ll_linha]
	ll_motivo				= ds_agrupamento.object.cd_motivo_defeito[ll_linha]
	
	lb_sucesso = False
	
	// Apaga Registro da Tabela Agrupamento de Produtos Protocolo
	DELETE FROM agrupamento_dev_compra_prd_prt
		 WHERE nr_agrupamento          	= :ast_parametros_protocolo.nr_agrupamento
		 	AND cd_produto              	= :ll_produto
			AND nr_lote	               	= :ls_lote
			AND cd_endereco_localizacao 	= :ls_endereco
			AND nr_protocolo            	= :ls_protocolo
    USING SqlCa;		
	 
	If SqlCa.SqlCode = -1 Then
		Sqlca.of_MsgDbError("Erro ao deleta os produtos no agrupamento protocolo.")
		Return False
	End If		
	
	If ast_parametros_protocolo.de_situacao_exclusao = 'S' Then
		DELETE FROM agrupamento_dev_com_prd_prt_nf
			 WHERE nr_agrupamento          	= :ast_parametros_protocolo.nr_agrupamento
				AND cd_produto              	= :ll_produto
				AND nr_lote	               	= :ls_lote
				AND cd_endereco_localizacao 	= :ls_endereco
				AND nr_protocolo            	= :ls_protocolo
		 USING SqlCa;		
	 
		If SqlCa.SqlCode = -1 Then
			Sqlca.of_MsgDbError("Erro ao deleta os produtos na tabela agrupamento_dev_com_prd_prt_nf.")
			Return False
		Else 
			lb_sucesso = true
		End If	
	Else 
		If Not Isnull(ast_parametros_protocolo.cd_produto) Then
			If ll_motivo = ast_parametros_protocolo.cd_motivo_defeito And ls_protocolo = ast_parametros_protocolo.nr_protocolo Or Isnull(ll_motivo) and  ls_protocolo = ast_parametros_protocolo.nr_protocolo  Then 
				ll_qtd = ast_parametros_protocolo.qtd_protocolo
				ll_motivo = ast_parametros_protocolo.cd_motivo_defeito
				lb_sucesso = True
			End If
		End If
	End If
	
	If lb_sucesso Then 
		// Atualiza Registro da Tabela de Protocolo
		Update	wms_protocolo
		Set 		qt_utilizado 	=qt_utilizado - :ll_qtd
		Where	cd_produto 	=:ll_produto
		And		nr_lote 		=:ls_lote
		And		nr_protocolo=:ls_protocolo
		And 		cd_motivo_defeito = :ll_motivo
		Using SqlCa;		
		 
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgDbError("Erro ao atualizar dados em wms_protocolo.")
			Return False
		End If
	End If
Next

Return True
end function

public function boolean of_insere_agrupamento_protocolo (st_parametros_protocolo ast_parametros_protocolo, uo_ge040_args auo_ge040_args[], long al_nr_agrupamento, ref string as_erro);string ls_nr_protocolo,&
			ls_erro,&
			ls_de_serie,&
			ls_de_especie,&
			ls_agrupamento_novo

long ll_count,&
		ll_linha,&
		ll_qtd,&
		ll_cd_motivo_defeito,& 
		ll_cd_filial,& 
		ll_nr_nf,&
		ll_cd_natureza,&
		ll_count_nf

boolean lb_sucesso = false	  

dc_uo_ds_Base ds_itens_selecionados

/* Datastore que carrega todos os protocolos e quantidades selecionadas */
ds_itens_selecionados = Create dc_uo_ds_base
If Not ds_itens_selecionados.of_ChangeDataObject('ds_ge252_qtd_selecao_protocolo') Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no changedata da 'ds_ge252_qtd_selecao_protocolo'.")
	Return False
End If

ds_itens_selecionados = ast_parametros_protocolo.ds_itens_selecionados

For ll_linha = 1 to ds_itens_selecionados.rowcount()
	
	ls_nr_protocolo 		= ds_itens_selecionados.object.nr_protocolo[ll_linha]
	ll_qtd 					= ds_itens_selecionados.object.qt_lote[ll_linha]
	ll_cd_motivo_defeito = ds_itens_selecionados.object.cd_motivo_defeito [ll_linha]
	
	ll_cd_filial			= auo_ge040_args[1].of_get_arg('cd_filial')
	ll_nr_nf 				= auo_ge040_args[1].of_get_arg('nr_nf')
	ls_de_especie			= auo_ge040_args[1].of_get_arg('de_especie')
	ls_de_serie 			= auo_ge040_args[1].of_get_arg('de_serie')
	ll_cd_natureza			= auo_ge040_args[1].of_get_arg('cd_natureza')
	
	
	If Not this.of_verificar_novo_agrupamento(al_nr_agrupamento, Ref ls_agrupamento_novo) Then Return false
	
	//Verificar se j$$HEX1$$e100$$ENDHEX$$ existe  
	Select 
		COUNT(a.cd_produto) AS count_prd_prt, 
		COUNT(b.cd_produto) AS count_prd_prt_nf
	Into :ll_count, :ll_count_nf
	From agrupamento_dev_compra_prd_prt a
	Left Join agrupamento_dev_com_prd_prt_nf b
		On a.nr_agrupamento          = b.nr_agrupamento
		And a.cd_produto              = b.cd_produto
		And a.cd_endereco_localizacao = b.cd_endereco_localizacao
		And a.nr_lote                 = b.nr_lote
		And a.nr_protocolo            = b.nr_protocolo
		And b.nr_nf_origem            = :ll_nr_nf
		And b.de_serie_origem         = :ls_de_serie
		And b.de_especie_origem       = :ls_de_especie
		And b.cd_natureza_operacao    = :ll_cd_natureza
		And b.cd_motivo_defeito			= :ll_cd_motivo_defeito
	Where a.nr_agrupamento          = :al_nr_agrupamento
		And a.cd_produto              = :ast_parametros_protocolo.cd_produto
		And a.cd_endereco_localizacao = :ast_parametros_protocolo.cd_endereco_wms
		And a.nr_lote                 = :ast_parametros_protocolo.nr_lote
		And a.nr_protocolo            = :ls_nr_protocolo
	Using SqlCa;

	Choose Case SqlCa.SqlCode 
			
		Case 0 /// Atualiza Quantidades

			// Atualiza ou insere na tabela agrupamento_dev_compra_prd_prt
			If ll_count > 0 then
			  Update agrupamento_dev_compra_prd_prt
					Set qt_lote = qt_lote + :ll_qtd
			  Where nr_agrupamento          = :al_nr_agrupamento
					and cd_produto              = :ast_parametros_protocolo.cd_produto
					and cd_endereco_localizacao = :ast_parametros_protocolo.cd_endereco_wms
					and nr_lote                 = :ast_parametros_protocolo.nr_lote
					and nr_protocolo            = :ls_nr_protocolo
			  Using SqlCa;		
			Else
			  Insert into agrupamento_dev_compra_prd_prt
							  ( nr_agrupamento
							  , cd_produto
							  , cd_endereco_localizacao
							  , nr_lote
							  , nr_protocolo
							  , qt_lote
							  ) 
			  Values ( :al_nr_agrupamento
						 , :ast_parametros_protocolo.cd_produto
						 , :ast_parametros_protocolo.cd_endereco_wms
						 , :ast_parametros_protocolo.nr_lote
						 , :ls_nr_protocolo
						 , :ll_qtd
						 )
			  Using SqlCa;		
			End if

			If SqlCa.SqlCode = -1 Then
				Sqlca.of_MsgDbError("Erro ao atualizar o produto no agrupamento." + SqlCa.SqlErrText)
				Return False
			End If

			If ls_agrupamento_novo = 'S' Then
				If ll_count_nf > 0 Then
				  Update agrupamento_dev_com_prd_prt_nf
						Set qt_lote = qt_lote + :ll_qtd
				  Where nr_agrupamento          = :al_nr_agrupamento
						And cd_produto              = :ast_parametros_protocolo.cd_produto
						And cd_endereco_localizacao = :ast_parametros_protocolo.cd_endereco_wms
						And nr_lote                 = :ast_parametros_protocolo.nr_lote
						And nr_protocolo            = :ls_nr_protocolo
						And nr_nf_origem            = :ll_nr_nf
						And de_serie_origem         = :ls_de_serie
						And de_especie_origem       = :ls_de_especie
						And cd_natureza_operacao    = :ll_cd_natureza
						And cd_motivo_defeito		 = :ll_cd_motivo_defeito
				  Using SqlCa;		
				Else
				  Insert Into agrupamento_dev_com_prd_prt_nf
									( nr_agrupamento
									, cd_produto
									, cd_endereco_localizacao
									, nr_lote
									, nr_protocolo
									, qt_lote
									, cd_filial
									, nr_nf_origem
									, de_serie_origem
									, de_especie_origem
									, cd_natureza_operacao
									, cd_motivo_defeito
									) 
						Values ( :al_nr_agrupamento
								  , :ast_parametros_protocolo.cd_produto
								  , :ast_parametros_protocolo.cd_endereco_wms
								  , :ast_parametros_protocolo.nr_lote
								  , :ls_nr_protocolo
								  , :ll_qtd
								  , :ll_cd_filial
								  , :ll_nr_nf
								  , :ls_de_serie
								  , :ls_de_especie
								  , :ll_cd_natureza
								  , :ll_cd_motivo_defeito
								  )
				  Using SqlCa;		
				End If
			End If
			
			If SqlCa.SqlCode = -1 Then
			  as_erro = ("Erro ao atualizar o produto no agrupamento na tabela agrupamento_dev_com_prd_prt_nf." + SqlCa.SqlErrText)
			  Return False
			End If
			
			lb_sucesso = True	  

		Case 100 // Insere o Registro na Tabela
		
			Insert into agrupamento_dev_compra_prd_prt
						 ( nr_agrupamento
						 , cd_produto
						 , cd_endereco_localizacao
						 , nr_lote
						 , nr_protocolo
						 , qt_lote
						 ) 
			Values ( :al_nr_agrupamento
					, :ast_parametros_protocolo.cd_produto
					, :ast_parametros_protocolo.cd_endereco_wms
					, :ast_parametros_protocolo.nr_lote
					, :ls_nr_protocolo
					, :ll_qtd
					)
			Using SqlCa;		
			
			If SqlCa.SqlCode = -1 Then
			  SqlCa.of_MsgDbError("Erro ao inserir dados do protocolo agrupamento." + SqlCa.SqlErrText)
			  Return False
			End If
			
			If ls_agrupamento_novo = 'S' Then
				Insert into agrupamento_dev_com_prd_prt_nf
							 ( nr_agrupamento
							 , cd_produto
							 , cd_endereco_localizacao
							 , nr_lote
							 , nr_protocolo
							 , qt_lote
							 , cd_filial
							 , nr_nf_origem
							 , de_serie_origem
							 , de_especie_origem
							 , cd_natureza_operacao
							 , cd_motivo_defeito
							 ) 
				Values ( :al_nr_agrupamento
						, :ast_parametros_protocolo.cd_produto
						, :ast_parametros_protocolo.cd_endereco_wms
						, :ast_parametros_protocolo.nr_lote
						, :ls_nr_protocolo
						, :ll_qtd
						, :ll_cd_filial
						, :ll_nr_nf
						, :ls_de_serie
						, :ls_de_especie
						, :ll_cd_natureza
						, :ll_cd_motivo_defeito
						)
				Using SqlCa;		
				
				If SqlCa.SqlCode = -1 Then
				  SqlCa.of_MsgDbError("Erro ao inserir dados do protocolo agrupamento na tabela agrupamento_dev_com_prd_prt_nf." + SqlCa.SqlErrText)
				  Return False
				End If
			End If
			
			lb_sucesso = true

		Case -1 	
			ls_erro = SqlCa.SqlErrText
			SqlCa.of_MsgDbError("Erro ao localizar agrupamento do protocolo. " + ls_erro)
			Return False
	End Choose
	
	/* 
	Se n$$HEX1$$e300$$ENDHEX$$o houve erro no processo, atualiza wms_protocolo com qt_utilizado + quantidade usada na opera$$HEX2$$e700e300$$ENDHEX$$o 
	*/
	if lb_sucesso = true then
		Update wms_protocolo
			Set qt_utilizado 		=qt_utilizado + :ll_qtd
		Where cd_produto 		=:ast_parametros_protocolo.cd_produto
		And nr_lote 			=:ast_parametros_protocolo.nr_lote
		And nr_protocolo 		=:ls_nr_protocolo
		And cd_motivo_defeito = :ll_cd_motivo_defeito
		And id_mudou_endereco = 'N'
		Using SqlCa;		
		 
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgDbError("Erro ao atualizar dados em wms_protocolo." + SqlCa.SqlErrText)
			Return False
		End If
	End if
Next

If ls_agrupamento_novo = 'S' Then
	If Not this.of_verificar_agrupamento_total_produto(al_nr_agrupamento, Ref as_erro) Then Return false
End If

Return True
end function

public function boolean of_insere_produto_no_agrupamento_protoco (long al_agrupamento, string as_fornecedor, long al_nota, string as_serie, long al_produto, string as_lote, string as_endereco, long al_qtde, ref string as_erro);string ls_erro, ls_endereco, ls_lote, ls_protocolo
long ll_count, ll_linha, ll_qtd, ll_linhas, ll_produto

dc_uo_ds_Base ds_agrupamento_protocolo

ds_agrupamento_protocolo = Create dc_uo_ds_base

If Not ds_agrupamento_protocolo.of_ChangeDataObject('ds_ge252_lista_agrupamento_protocolo_reinsere') Then
	as_erro = "Erro no changedata da 'ds_ge252_lista_agrupamento_protocolo'"
	Return false
End If

if not Isnull(al_produto) Then
	ds_agrupamento_protocolo.of_AppendWhere_Subquery("cd_produto = " + string(al_produto), 1)
	
	if not Isnull(as_lote) Then
		ds_agrupamento_protocolo.of_AppendWhere_Subquery("nr_lote = '" + as_lote + "'", 1)
	end if
	
	if not Isnull(as_endereco) Then
		ds_agrupamento_protocolo.of_AppendWhere_Subquery("cd_endereco_localizacao = '" + as_endereco + "'", 1)
	end if
end if

ds_agrupamento_protocolo.retrieve(al_agrupamento)
ll_linhas = ds_agrupamento_protocolo.rowcount()

For ll_linha = 1 to ll_linhas
	
	ll_produto 			= ds_agrupamento_protocolo.object.cd_produto		[ll_linha]
	ls_endereco 		= ds_agrupamento_protocolo.object.cd_endereco_localizacao[ll_linha]
	ls_lote 				= ds_agrupamento_protocolo.object.nr_lote			[ll_linha]
	ls_protocolo 		= ds_agrupamento_protocolo.object.nr_protocolo	[ll_linha]
	ll_qtd 				= ds_agrupamento_protocolo.object.qt_lote			[ll_linha]
	
	// Inser$$HEX2$$e700e300$$ENDHEX$$o do registro na tabela agrupamento_dev_compra_prd_prt
	Insert into agrupamento_dev_compra_prd_prt (
		nr_agrupamento,
		cd_produto,
		nr_lote,
		cd_endereco_localizacao,
		nr_protocolo,
		qt_lote
	)
	Values (
		:al_agrupamento,
		:ll_produto,
		:ls_lote,
		:ls_endereco,
		:ls_protocolo,
		:ll_qtd
	)
	Using SqlCa;		
	 
	If SqlCa.SqlCode = -1 Then
		as_erro = ("Erro ao inserir o produto no agrupamento na tabela agrupamento_dev_compra_prd_prt" + SQLCA.SQLErrText)
		Return False
	End If		

Next

Return True

end function

on uo_ge252_agrupamento_devolucao_compra.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge252_agrupamento_devolucao_compra.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor; String	ls_msg
 io_Movimentacao = Create uo_ge258_movimentacao
 
 if not gf_verifica_inicio_operacao_sap('DH_INICIO_OPERACAO_SAP', ref ib_Iniciado_Operacao_SAP, ref ls_msg ) then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar a data de in$$HEX1$$ed00$$ENDHEX$$cio de opera$$HEX2$$e700e300$$ENDHEX$$o do SAP.', StopSign!)
	return -1
end if


end event

event destructor;Destroy(io_Movimentacao)
end event

