HA$PBExportHeader$w_ge132_relatorios_diversos.srw
forward
global type w_ge132_relatorios_diversos from dc_w_response_ok_cancela
end type
type cb_gerar from commandbutton within w_ge132_relatorios_diversos
end type
end forward

global type w_ge132_relatorios_diversos from dc_w_response_ok_cancela
integer width = 1966
integer height = 860
string title = "GE132 - Gera$$HEX2$$e700e300$$ENDHEX$$o de Relat$$HEX1$$f300$$ENDHEX$$rios Diversos"
cb_gerar cb_gerar
end type
global w_ge132_relatorios_diversos w_ge132_relatorios_diversos

type variables
uo_Produto			io_Produto
dc_uo_ds_base		ids_Excel
uo_ge216_filiais	ivo_Selecao_filiais
uo_filial			io_filial
uo_fornecedor		ivo_fornecedor
uo_ge149_Comprador io_Comprador
uo_promocao			io_Promocao

Boolean	ib_Importar_Planilha = False

Date idh_Inicio
Date idh_Termino
Date idh_Data_Estoque

Long il_Qtd_Resultado
Long il_Lojas

String is_estado
String is_arquivo_Produtos
String is_Title
String is_MSG
String ivs_filiais
end variables

forward prototypes
public function integer wf_relatorio_padrao (string as_nome_datastore)
public subroutine wf_gera_excel ()
public subroutine wf_informacoes_filiais_por_produto ()
public function integer wf_fileopen ()
public function boolean wf_importa_excel (ref string ps_produtos_in)
public function boolean wf_filial_horarios (long pl_filial, ref string ps_horario)
public subroutine wf_informacoes_filiais ()
public function boolean wf_verifica_nome_procedimento (string as_relatorio)
public function boolean wf_carrega_dados_hist_alter_eb ()
public function boolean wf_hist_alter_promocao (long al_filial, long al_produto, dc_uo_ds_base ads_hist_promo, ref string as_matricula, ref string as_nome, ref datetime adh_alteracao, ref long al_minimo)
public function boolean wf_info_estoque_eb (long al_filial, long al_produto, dc_uo_ds_base ads_hist_eb, ref long al_qt_estoque_calc_dia, ref decimal adc_demanda_diaria_dia, ref long al_qt_dias_cobertura_dia, ref long al_qt_eb_atual_dia)
public function boolean wf_qt_dias_ultima_entrada (string as_relatorio)
public function long wf_relatorio_hist_alteracao_eb (string as_produtos, string as_alteracao_atual)
public subroutine _documentacao ()
public function boolean wf_importa_filial_produto_promocao (ref st_ge132_filial_produto_promocao ast_ge132_filial_produto_promocao[])
end prototypes

public function integer wf_relatorio_padrao (string as_nome_datastore);Date ldt_Resumo, ldt_Mes_Ant, ldt_Saldo
Date ldt_Ini_vcto , ldt_Fim_vcto

DateTime ldh_Termino_EB

Decimal ldc_pc_Desconto, ldc_preco_bruto, ldc_vl_Desconto

Integer li_Retorno

Long	ll_Row, ll_Mes, ll_Ano, &
		ll_filial, ll_produto, ll_promocao
			
String ls_ID_Produtos, ls_Produtos_In, ls_alteracao_atual, ls_Comprador, ls_Fornecedor

st_ge132_filial_produto_promocao			lst_filial_produto_promocao []
uo_ge132_periodo_movimentacao_produto	lo_ge132_periodo_movimentacao_produto
	
Try
	
	dw_1.AcceptText()

	ids_Excel.Reset()
	
	//passa o nome da dataStore referente ao relatorio
	If Not ids_Excel.of_ChangeDataObject( as_nome_datastore ) Then Return -1
	
	Open(w_Aguarde)
	w_Aguarde.Title = "Gerando relat$$HEX1$$f300$$ENDHEX$$rio. Aguarde..."
	
	//Colocar appendWhere se necess$$HEX1$$e100$$ENDHEX$$rio
	
	Choose Case as_nome_datastore
		Case 'ds_ge132_consulta_historico_eb_loja'
			ldt_Resumo = Date("01/" + MidA(String(idh_Inicio), 4))
			
			ll_Mes = Month(ldt_Resumo)
			ll_Ano = Year(ldt_Resumo)
			
			If ll_Mes = 1 Then
				ll_Mes = 12
				ll_Ano = ll_Ano -1
			Else
				ll_Mes = ll_Mes - 1
			End If
			
			ldt_Mes_Ant = Date("01/" + String(ll_Mes) + "/" + String(ll_Ano))

			//Filtra as filiais
			If dw_1.Object.Id_Conjunto_Filial[1] = "C" Then
				If ivs_filiais <> "" And Not IsNull(ivs_filiais) Then
					ids_Excel.of_AppendWhere_SubQuery("r.cd_filial in (" + ivs_Filiais + ")", 2)
				Else
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma filial foi selecionada.")
					Return -1
				End If
			End If
			

			
			ids_Excel.Retrieve( ldt_Resumo, idh_Inicio, ldt_Mes_Ant)
			il_Qtd_Resultado = ids_Excel.rowcount( )
			
			If il_Qtd_Resultado < 0 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar a ds 'ds_ge132_consulta_historico_eb_loja'.", StopSign!)
				Return -1
			End If
			
			If il_Qtd_Resultado > 0 Then
				If Not wf_Carrega_Dados_Hist_Alter_EB() Then Return -1
			End If
			
		Case 'ds_ge132_desconto_gam'
			
			ids_Excel.Retrieve( idh_Inicio, idh_Termino )
			il_Qtd_Resultado = ids_Excel.rowcount( )
			For ll_Row = 1 To ids_Excel.RowCount()
				ldc_pc_Desconto	= 0.00
				ldc_preco_bruto	= 0.00
				ldc_vl_Desconto	= 0.00
				
				ldc_preco_bruto	= ids_Excel.Object.preco_bruto_pedido	[ ll_Row ]
				ldc_vl_Desconto	= ids_Excel.Object.valor_desconto			[ ll_Row ]
				
				ldc_pc_Desconto = Round( (( ldc_vl_Desconto / ldc_preco_bruto ) * 100) , 2)
				
				ids_Excel.Object.pc_desconto [ ll_Row ] = ldc_pc_Desconto
				
			Next
					
		Case 'ds_ge132_desconto_generico'
			ids_Excel.Retrieve( idh_Inicio, idh_Termino )
			il_Qtd_Resultado = ids_Excel.rowcount( )
		
		Case 'ds_ge132_informacoes_estoque'
				ls_ID_Produtos 	= dw_1.Object.id_produtos	[ 1 ]
				ls_Comprador = dw_1.Object.Nr_Matricula [1]
				ls_Fornecedor = dw_1.Object.Cd_Fornecedor [1]

				//Captura o primeiro dia do m$$HEX1$$ea00$$ENDHEX$$s corrente
				ldt_Resumo = Date("01/" + MidA(String(gf_GetServerDate()), 4))
				
				If ls_ID_Produtos = 'C' Then
					 If Not wf_Importa_excel( Ref ls_Produtos_In ) Then Return -2 //Retorna -2 pra n$$HEX1$$e300$$ENDHEX$$o dar mensagem de erro no evento clicked do bot$$HEX1$$e300$$ENDHEX$$o Gerar Planilha
					 ids_Excel.of_appendwhere_subquery( "f.cd_produto in ( "+ls_Produtos_In+")", 5)
				End If
				
				If ivs_filiais <> "" And Not IsNull(ivs_filiais) Then
					ids_Excel.of_AppendWhere_SubQuery("r.cd_filial in (" + ivs_Filiais + ")", 5)
				End If
				
				If ls_Comprador <> "" And Not IsNull(ls_Comprador) Then
					ids_Excel.of_AppendWhere_SubQuery("p.nr_matricula_comprador = ('" + ls_Comprador + "')", 5)
				End If
				
				If ls_Fornecedor <> "" And Not IsNull(ls_Fornecedor) Then
					ids_Excel.of_AppendWhere_SubQuery("p.cd_fornecedor = ('" + ls_Fornecedor + "')", 5)
				End If
				
				// Carrega os dados SaldoProduto
				ids_Excel.Retrieve(ldt_Resumo)
				il_Qtd_Resultado = ids_Excel.rowcount()
								
				If il_Qtd_Resultado < 0 Then
					Return -1
				ElseIf il_Qtd_Resultado = 0 Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Os produtos informados n$$HEX1$$e300$$ENDHEX$$o possuem saldo.", Exclamation!)
					Return 0
				Else 
					wf_Qt_Dias_Ultima_Entrada(as_nome_datastore)
				End If

			Case 'ds_ge132_informacoes_estoque_remaneja'
				ls_ID_Produtos = dw_1.Object.id_produtos		[1]
				ls_Comprador 	= dw_1.Object.Nr_Matricula 		[1]
				ls_Fornecedor 	= dw_1.Object.Cd_Fornecedor	[1]

				//Captura o primeiro dia do m$$HEX1$$ea00$$ENDHEX$$s corrente
				ldt_Resumo = Date("01/" + MidA(String(gf_GetServerDate()), 4))
				
				If ls_ID_Produtos = 'C' Then
					 If Not wf_Importa_excel( Ref ls_Produtos_In ) Then Return -2 //Retorna -2 pra n$$HEX1$$e300$$ENDHEX$$o dar mensagem de erro no evento clicked do bot$$HEX1$$e300$$ENDHEX$$o Gerar Planilha
					 ids_Excel.of_appendwhere_subquery( "f.cd_produto in ( "+ls_Produtos_In+")", 1)
				End If
				
				If ivs_filiais <> "" And Not IsNull(ivs_filiais) Then
					ids_Excel.of_AppendWhere_SubQuery("r.cd_filial in (" + ivs_Filiais + ")", 1)
				End If
				
				If ls_Comprador <> "" And Not IsNull(ls_Comprador) Then
					ids_Excel.of_AppendWhere_SubQuery("p.nr_matricula_comprador = ('" + ls_Comprador + "')", 1)
				End If
				
				If ls_Fornecedor <> "" And Not IsNull(ls_Fornecedor) Then
					ids_Excel.of_AppendWhere_SubQuery("p.cd_fornecedor = ('" + ls_Fornecedor + "')", 1)
				End If
				
				// Carrega os dados SaldoProduto
				ids_Excel.Retrieve(ldt_Resumo)
				il_Qtd_Resultado = ids_Excel.rowcount()

						
		  Case 'ds_ge132_informacoes_filiais'
			
				If dw_1.Object.Id_Situacao[1] <> "T" Then
				   ids_Excel.of_AppendWhere_SubQuery("f.id_situacao = '" + dw_1.Object.Id_Situacao[1] + "'", 2)
				End If
				
				ids_Excel.Retrieve()
				il_Qtd_Resultado = ids_Excel.rowcount( )
				
				If il_Qtd_Resultado > 0 Then
					wf_Informacoes_Filiais()
				End If
							
		Case	'ds_ge132_excesso_perine', 'ds_ge132_excesso_filial', 'ds_ge132_excesso_produto'
				ids_Excel.Retrieve() 
				il_Qtd_Resultado = ids_Excel.rowcount( )
		
		Case 'ds_ge132_atualizacao_produtos_abcfarma', 'ds_ge132_periodo_compras_material_limpeza'
			ids_Excel.Retrieve( idh_Inicio, idh_Termino )
			il_Qtd_Resultado = ids_Excel.rowcount( )
			
		Case 'ds_ge132_permite_devolucao'
			//Captura o primeiro dia do m$$HEX1$$ea00$$ENDHEX$$s corrente
			ldt_Resumo = Date("01/" + MidA(String(gf_GetServerDate()), 4))
			
			ids_Excel.Retrieve(ldt_Resumo)
			il_Qtd_Resultado = ids_Excel.rowcount( )
	
		Case 'ds_ge132_historico_alteracao_eb'
			
			ls_ID_Produtos		= dw_1.Object.id_produtos			[1]
			ls_alteracao_atual	= dw_1.Object.Id_alteracao_atual	[1]
			
			If wf_relatorio_hist_alteracao_eb(ls_ID_Produtos, ls_alteracao_atual) < 0 Then
				Return -2 //Retorna -2 pra n$$HEX1$$e300$$ENDHEX$$o dar mensagem de erro no evento clicked do bot$$HEX1$$e300$$ENDHEX$$o Gerar Planilha
			End If
			
//			ldt_Resumo = Date("01/" + MidA(String(idh_Inicio), 4))
//			
//			ll_Mes = Month(ldt_Resumo)
//			ll_Ano = Year(ldt_Resumo)
//			
//			If ll_Mes = 1 Then
//				ll_Mes = 12
//				ll_Ano = ll_Ano -1
//			Else
//				ll_Mes = ll_Mes - 1
//			End If
//			
//			ldt_Mes_Ant = Date("01/" + String(ll_Mes) + "/" + String(ll_Ano))
//			
//			ls_ID_Produtos 	= dw_1.Object.id_produtos	[ 1 ]
//			ls_alteracao_atual = dw_1.Object.Id_alteracao_atual [1]
//									
//			If ls_ID_Produtos = 'C' Then
//				 If Not wf_Importa_excel( Ref ls_Produtos_In ) Then Return -2 //Retorna -2 pra n$$HEX1$$e300$$ENDHEX$$o dar mensagem de erro no evento clicked do bot$$HEX1$$e300$$ENDHEX$$o Gerar Planilha
//				 ids_Excel.of_appendwhere_subquery( "r.cd_produto in ( "+ls_Produtos_In+")", 4)
//			End If
//						
//			If dw_1.Object.Id_Conjunto_Filial[1] = "C" Then
//				If ivs_filiais <> "" And Not IsNull(ivs_filiais) Then
//					ids_Excel.of_AppendWhere_SubQuery("r.cd_filial in (" + ivs_Filiais + ")", 4)
//				End If
//			End If
//			
//			If ls_alteracao_atual <> "T" Then
//				ids_Excel.Of_AppendWhere_SubQuery( "r.id_alteracao_atual = '" + ls_alteracao_atual + "'", 4)
//			End If
//			
//			//O dh_historico $$HEX1$$e900$$ENDHEX$$ datetime e a vari$$HEX1$$e100$$ENDHEX$$vel idh_Termino $$HEX1$$e900$$ENDHEX$$ do tipo date. Para ajustar isso $$HEX1$$e900$$ENDHEX$$ utilizada a vari$$HEX1$$e100$$ENDHEX$$vel ldh_Termino_EB
//			ldh_Termino_EB = DateTime(Date(idh_Termino), Time('23:59:59'))
//			ids_Excel.Retrieve(DateTime(idh_Inicio), ldh_Termino_EB, DateTime(ldt_Mes_Ant), Datetime(ldt_Resumo))
//			
//			il_Qtd_Resultado = ids_Excel.rowcount( )
//						
//			If il_Qtd_Resultado = 0 Then
//				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum dado localizado.~rVerifique os par$$HEX1$$e200$$ENDHEX$$metros informados.", Exclamation!)
//				Return -2 //Retorna -2 pra n$$HEX1$$e300$$ENDHEX$$o dar mensagem de erro no evento clicked do bot$$HEX1$$e300$$ENDHEX$$o Gerar Planilha
//			End If
						
		Case 'ds_ge132_transferencia_ec'			
			If ivs_filiais <> "" And Not IsNull(ivs_filiais) Then
				ids_Excel.of_AppendWhere("n.cd_filial_destino in (" + ivs_Filiais + ")", 1)
				
				If ids_Excel.Retrieve(idh_Inicio, idh_Termino) < 0 Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no retrieve da ds 'ds_ge132_transferencia_ec'.", StopSign!)
					Return -1
				End If
				
				il_Qtd_Resultado = ids_Excel.RowCount()
			End If
			
		Case 'ds_ge132_dados_produtos_lojas_sazonais'
			
			If ivs_filiais <> "" And Not IsNull(ivs_filiais) Then
				ids_Excel.of_AppendWhere("r.cd_filial in (" + ivs_Filiais + ")", 1)
				
				If ids_Excel.Retrieve() < 0 Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no retrieve da ds 'ds_ge132_dados_produtos_lojas_sazonais'.", StopSign!)
					Return -1
				End If
				
				il_Qtd_Resultado = ids_Excel.RowCount()
			End If
			
		Case 'ds_ge132_informacoes_eb'
			ldt_Resumo = Date("01/" + MidA(String(gf_GetServerDate()), 4))
			ls_ID_Produtos 	= dw_1.Object.id_produtos	[ 1 ]
			
			If ivs_filiais <> "" And Not IsNull(ivs_filiais) Then
				ids_Excel.of_AppendWhere_SubQuery("r.cd_filial in (" + ivs_Filiais + ")", 2)
			End If
			
			If ls_ID_Produtos = 'C' Then
				 If Not wf_Importa_excel( Ref ls_Produtos_In ) Then Return -2 //Retorna -2 pra n$$HEX1$$e300$$ENDHEX$$o dar mensagem de erro no evento clicked do bot$$HEX1$$e300$$ENDHEX$$o Gerar Planilha				 
				 ids_Excel.of_AppendWhere_SubQuery("r.cd_produto in ( "+ls_Produtos_In+")", 2)
			End If
			
			If ids_Excel.Retrieve(ldt_Resumo) < 0 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no retrieve da ds 'ds_ge132_informacoes_eb'.", StopSign!)
				Return -1
			End If
			
			il_Qtd_Resultado = ids_Excel.RowCount()
			
		Case 'ds_ge132_excesso_estoque_periodo'			
			ls_ID_Produtos 	= dw_1.Object.id_produtos	[ 1 ]
			
			If ivs_filiais <> "" And Not IsNull(ivs_filiais) Then
				ids_Excel.of_AppendWhere_SubQuery("r.cd_filial in (" + ivs_Filiais + ")", 3)
			End If
			
			If ls_ID_Produtos = 'C' Then
				 If Not wf_Importa_excel( Ref ls_Produtos_In ) Then Return -2 //Retorna -2 pra n$$HEX1$$e300$$ENDHEX$$o dar mensagem de erro no evento clicked do bot$$HEX1$$e300$$ENDHEX$$o Gerar Planilha				 
				 ids_Excel.of_AppendWhere_SubQuery("r.cd_produto in ( "+ls_Produtos_In+")", 3)
			End If
			
			If ids_Excel.Retrieve(idh_Inicio) < 0 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no retrieve da ds 'ds_ge132_excesso_estoque_periodo'.", StopSign!)
				Return -1
			End If
			
			il_Qtd_Resultado = ids_Excel.RowCount()
			
			If il_Qtd_Resultado > 0 Then
				wf_Qt_Dias_Ultima_Entrada(as_nome_datastore)
			End If
			
		Case 'ds_ge132_enderecamento_produto_ec'
			ldt_Resumo = Date("01/" + MidA(String(gf_GetServerDate()), 4))
			
			ids_Excel.Retrieve(ldt_Resumo)
			il_Qtd_Resultado = ids_Excel.rowcount()
			
		Case 'ds_ge132_produtos_sem_venda'
			ldt_Saldo = gf_Primeiro_Dia_Mes(Date(gf_GetServerDate()))
			
			ids_Excel.Retrieve(ldt_Saldo)
			il_Qtd_Resultado = ids_Excel.rowcount()
			
		Case 'ds_ge132_analise_reforco'
			ids_Excel.Retrieve( idh_Inicio, idh_Termino )
			il_Qtd_Resultado = ids_Excel.rowcount( )
			
		Case 'ds_ge132_transferencia_prod_vencidos'
			ids_Excel.of_AppendWhere(" nf.dh_emissao <= '"+ String(idh_Termino,"yyyy/mm/dd")+"'") 
			ids_Excel.of_AppendWhere(" nf.dh_emissao >=  '" + String(idh_Inicio,"yyyy/mm/dd") + "'")
			ids_Excel.Retrieve()
			il_Qtd_Resultado = ids_Excel.rowcount()	
			
		Case 'ds_ge132_dados_compras'
			ldt_Ini_vcto  =  dw_1.Object.dh_inicio_vcto[1]
			ldt_Fim_vcto = dw_1.Object.dh_termino_vcto[1]
			ls_Fornecedor = dw_1.Object.Cd_Fornecedor [1]
			
			// Filial
			If ivs_filiais <> "" And Not IsNull(ivs_filiais) Then
				ids_Excel.of_AppendWhere("r.cd_filial in (" + ivs_Filiais + ")", 1)
			End If
			// Fornecedor
			If ls_Fornecedor <> "" And Not IsNull(ls_Fornecedor) Then
				ids_Excel.of_AppendWhere("f.cd_fornecedor in ('" + ls_Fornecedor + "')", 1)
			End If
			// Tipo Compras
			If dw_1.Object.id_compras[1] <> "T" Then
				If  dw_1.Object.id_compras[1]  = "L" Then 
					ids_Excel.of_AppendWhere("n.cd_filial <> 534",1) 
				Else
					ids_Excel.of_AppendWhere("n.cd_filial  = 534 ", 1)
				End If 
			End If 
			
			// Data de Emissao 
			If Not IsNull( ldt_Ini_vcto )  and  Not IsNull( ldt_Fim_vcto )  Then
				ids_Excel.of_AppendWhere(" cast(n.dh_emissao as date)>='"+String(ldt_Ini_vcto, "dd/mm/yyyy")+"'",1 ) 
				ids_Excel.of_AppendWhere(" cast(n.dh_emissao as date)<='"+String(ldt_Fim_vcto, "dd/mm/yyyy")+"'",1 ) 
			End If
			
			// Execu$$HEX2$$e700e300$$ENDHEX$$o da Consulta
			ids_Excel.Retrieve( idh_Inicio, idh_Termino )
			il_Qtd_Resultado = ids_Excel.rowcount( )	
		
		Case 'ds_ge132_periodo_movimentacao_produto'
			
			If ib_importar_planilha then
				If not wf_importa_filial_produto_promocao (Ref lst_filial_produto_promocao []) then
					Return 0
				End if
			else
				lst_filial_produto_promocao[1].cd_filial       = dw_1.Object.cd_filial       [1]
				lst_filial_produto_promocao[1].cd_produto      = dw_1.Object.cd_produto      [1]
				lst_filial_produto_promocao[1].cd_promocao_sos = dw_1.Object.cd_promocao_sos [1]
			End if
			
			lo_ge132_periodo_movimentacao_produto = Create uo_ge132_periodo_movimentacao_produto
			lo_ge132_periodo_movimentacao_produto.of_recupera_informacoes (io_Promocao.ivs_Tipo, lst_filial_produto_promocao [], Ref ids_Excel)
			
			il_Qtd_Resultado = ids_Excel.RowCount ()
			
			If il_Qtd_Resultado < 1 then
				MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'N$$HEX1$$e300$$ENDHEX$$o foram encontrados dados a exportar!', Exclamation!)
				Return 0
			End if
			
		Case Else
			
			If as_nome_datastore = "ds_ge132_lista_filial_por_produto" Then
				ids_Excel.Retrieve()
				il_Qtd_Resultado = ids_Excel.rowcount( )
				If il_Qtd_Resultado> 0 Then
					wf_Informacoes_Filiais_Por_Produto()
				End If
			
			Else
				ids_Excel.Retrieve()
				il_Qtd_Resultado = ids_Excel.rowcount( )
			End If
				
	End Choose
	
	If as_Nome_Datastore <> "ds_ge132_historico_alteracao_eb" Then
		//Chama a fun$$HEX2$$e700e300$$ENDHEX$$o para salvar em excel
		wf_Gera_Excel()
	End If
	
Finally
	ivs_filiais = ""
	dw_1.Event ue_Reset()
	dw_1.Event ue_AddRow()
		
	If IsValid (lo_ge132_periodo_movimentacao_produto) then
		Destroy lo_ge132_periodo_movimentacao_produto
	End if
	Close(w_Aguarde)
End Try

Return li_Retorno
end function

public subroutine wf_gera_excel ();//Gera a planilha da DataStore selionada

String lvs_Path,&
		lvs_Arquivo

Integer lvi_Retorno

If (il_Qtd_Resultado>65000) Then 
	lvi_retorno = GetFileSaveName('Arquivo', lvs_Path, lvs_Arquivo, 'txt', 'Arquivo TXT (*.txt),*.txt')
Else
	lvi_retorno = GetFileSaveName('Arquivo', lvs_Path, lvs_Arquivo, 'xls', 'Planilha Excel (*.xls),*.xls')
End If 
	
If lvi_retorno = 1 Then
	
////	lvs_Path = "C:\Sistemas\Co\Arquivos\teste_" + String(Today(), "ddmm") + String(Now(), "hhmm") + ".txt"
	
//	 Verifica se j$$HEX1$$e100$$ENDHEX$$ existe o arquivo
	If FileExists(lvs_Path) Then
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja substituir o arquivo '" + lvs_Path + "' existente ?", Question!, YesNo!, 1) =  1 Then
			If Not FileDelete(lvs_Path) Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na exclus$$HEX1$$e300$$ENDHEX$$o do arquivo '" + lvs_Path + "'.", StopSign!)
				Return
			End If
		Else
			Return
		End If
	End If
	
	If il_Qtd_Resultado>65000  Then 
//		Salva o  no formato Texto
		If ids_Excel.SaveAs(lvs_Path, Text!, True) = 1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O arquivo foi salvo com sucesso '" + lvs_Path + "'.")
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gerar o arquivo '" + lvs_Path + "'.", StopSign!)
		End If
	Else
//		Salva o  no formato Texto
		If ids_Excel.SaveAs(lvs_Path, Excel!, True) = 1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O arquivo foi salvo com sucesso '" + lvs_Path + "'.")
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gerar o arquivo '" + lvs_Path + "'.", StopSign!)
		End If
	End If
	
End If
end subroutine

public subroutine wf_informacoes_filiais_por_produto ();Long ll_Linha
Long ll_Qtd_Maior_PP = 0
Long ll_Qtd_Maior_DC = 0
Long ll_Qtd_Maior_Tot

ids_Excel.AcceptText()

For ll_Linha = 1 To ids_Excel.RowCount()
	ids_Excel.Object.PP[ll_Linha] = ids_Excel.Object.Qt_Filiais[ll_Linha] - ids_Excel.Object.DC[ll_Linha]
	
	If ids_Excel.Object.PP[ll_Linha] > ll_Qtd_Maior_PP Then
		ll_Qtd_Maior_PP = ids_Excel.Object.PP[ll_Linha]
	End If
	
	If ids_Excel.Object.DC[ll_Linha] > ll_Qtd_Maior_DC Then
		ll_Qtd_Maior_DC = ids_Excel.Object.DC[ll_Linha]
	End If
Next

ll_Qtd_Maior_Tot = ids_Excel.Object.Qt_Filiais[1]
ll_Linha = 0

//Preenche os percentuais
For ll_Linha 	= 1 To ids_Excel.RowCount()
	If ll_Qtd_Maior_PP > 0 Then
		ids_Excel.Object.Percent_PP[ll_Linha] = Round((ids_Excel.Object.PP[ll_Linha] / ll_Qtd_Maior_PP) * 100, 2)
	End If
	
	If ll_Qtd_Maior_DC > 0 Then
		ids_Excel.Object.Percent_DC[ll_Linha] = Round((ids_Excel.Object.DC[ll_Linha] / ll_Qtd_Maior_DC) * 100, 2)
	End If
	
	If ll_Qtd_Maior_Tot > 0 Then
		ids_Excel.Object.Percent_Tot[ll_Linha] = Round((ids_Excel.Object.Qt_Filiais[ll_Linha] / ll_Qtd_Maior_Tot) * 100, 2)
	End If
Next
end subroutine

public function integer wf_fileopen ();String ls_Path
String ls_Arquivo
Integer li_arquivo

ib_Importar_Planilha = False

Choose case dw_1.Object.nm_relatorio [1]
	case 'ds_ge132_periodo_movimentacao_produto'
		MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', &
						'Os dados devem estar na seguinte forma:~r~r' + &
						'Coluna A = C$$HEX1$$f300$$ENDHEX$$digo da Filial~r' + &
						'Coluna B = C$$HEX1$$f300$$ENDHEX$$digo do Produto')
		
	case else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Os Dados devem estar da seguinte forma:~r~r" + &
							"Coluna A = C$$HEX1$$f300$$ENDHEX$$digo do Produto.")
End choose

li_arquivo = GetFileOpenName("Selecione o arquivo", &
											ls_Path, &
											ls_Arquivo  , &
											"XLS", &
											+ "Arquivo Excel (*.XLS;*.XLSX),*.XLS;*.XLSX")

dw_1.Object.id_Produtos[1] = 'S'
																
Choose Case li_Arquivo
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Ocorreu um erro ao abrir o arquivo '" + ls_Arquivo + "'.")
		
	Case 0
		
	Case 1
		is_arquivo_Produtos = ls_Path
		dw_1.Object.id_Produtos[1] = 'C'
		ib_Importar_Planilha = True
End Choose

Return li_Arquivo
end function

public function boolean wf_importa_excel (ref string ps_produtos_in);Long ll_Total, ll_Row, ll_Produto

Try

	w_Aguarde.Title = "Lendo dados do arquivo : '" + Upper( is_arquivo_Produtos ) + "'."
	
	dc_uo_Excel lo_Excel
	lo_Excel = Create dc_uo_Excel
	
	lo_Excel.uo_Referencia_Objeto_Excel( is_arquivo_Produtos )
	ll_Total = lo_Excel.uo_Verifica_Tamanho_Arquivo("A")	

	If ll_Total = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A planilha selecionada est$$HEX1$$e100$$ENDHEX$$ vazia.", Exclamation!)
		Return False
	End If

	w_Aguarde.uo_Progress.of_SetMax( ll_Total )
	
	SetPointer(HourGlass!)
	
	For ll_Row = 1 To ll_Total
		w_Aguarde.uo_Progress.of_SetProgress( ll_Row )
		//Leitura da coluna A - Produto
		ll_Produto = Long( lo_Excel.uo_Lendo_Dados( ll_Row, "A") )
		ps_produtos_in += String( ll_Produto ) + ","	
		//Yield()	 			 
	Next
	
	Return True
	
Finally
	ps_produtos_in = Mid( ps_produtos_in, 1, LenA(ps_produtos_in) -1 )
	If IsValid(lo_Excel) Then Destroy lo_Excel	
End Try
end function

public function boolean wf_filial_horarios (long pl_filial, ref string ps_horario);String 	lvs_Cd_Parametro, &
			lvs_Vl_Parametro, &
			lvs_Hora, &
			lvs_Min, &
			lvs_Horario

lvs_Horario = ""

Declare c1 Cursor For Select cd_parametro,
								      vl_parametro
							 From parametro_loja
						 	Where cd_filial = :pl_Filial
							    and cd_parametro like 'DE_HORARIO_%'
						     Order By cd_parametro ASC;
Open c1;

If SqlCa.SqlCode = -1 Then
	//This.of_Log(10, "Erro na Abertura do Cursor para Verifica$$HEX2$$e700e300$$ENDHEX$$o Hor$$HEX1$$e100$$ENDHEX$$rio Loja da Filial: " + String(pl_Filial) + " Erro:" + SqlCa.SqlErrText )			
	Return False
End If

Fetch c1 Into :lvs_Cd_Parametro,
              	  :lvs_Vl_Parametro;
				  
Do While SqlCa.SqlCode = 0
	
	lvs_Hora = Mid(lvs_Vl_Parametro, 3, 2) + "h"
	If MidA(lvs_Vl_Parametro, 5, 2) <> "00" Then
		lvs_Hora += Mid(lvs_Vl_Parametro, 5, 2) + "min"
	End If
	lvs_Hora += " $$HEX1$$e000$$ENDHEX$$s "  + MidA(lvs_Vl_Parametro, 7, 2) + "h"
	If MidA(lvs_Vl_Parametro, 9, 2) <> "00" Then
		lvs_Hora += MidA(lvs_Vl_Parametro, 9, 2) + "min"
	End If

	Choose Case MidA(lvs_Vl_Parametro, 1, 2) 
		Case '10' 
			lvs_Horario += "24 Horas"
		Case '00' 
			lvs_Horario += "Seg. $$HEX1$$e000$$ENDHEX$$ Sexta: "  + lvs_Hora;
		Case '01' 
			lvs_Horario += "Seg. $$HEX1$$e000$$ENDHEX$$ S$$HEX1$$e100$$ENDHEX$$bado: " + lvs_Hora;
		Case '02'
			lvs_Horario += "Seg. $$HEX1$$e000$$ENDHEX$$ Domingo: " + lvs_Hora;
		Case '03'
			lvs_Horario += "Seg. $$HEX1$$e000$$ENDHEX$$ Dom. e Fer.: " + lvs_Hora;
		Case '04'
			lvs_Horario += "S$$HEX1$$e100$$ENDHEX$$bado: " + lvs_Hora;
		Case '05'
			lvs_Horario += "Domingo: " + lvs_Hora;
		Case '06'
			lvs_Horario += "S$$HEX1$$e100$$ENDHEX$$b./Domingo: " + lvs_Hora;
		Case '07'
			lvs_Horario += "S$$HEX1$$e100$$ENDHEX$$b./Dom./Fer.: " + lvs_Hora;
		Case '08'
			lvs_Horario += "Dom./Feriado: " + lvs_Hora;
		Case '09'
			lvs_Horario += "Feriado: " + lvs_Hora;
		Case '11'
			lvs_Horario += "Seg. $$HEX1$$e000$$ENDHEX$$ Quinta: " + lvs_Hora;
		Case '12'
			lvs_Horario += "Sexta: " + lvs_Hora;
	End Choose
	
	lvs_Horario += " "

	Fetch c1 Into :lvs_Cd_Parametro,
					  :lvs_Vl_Parametro;					  
Loop

If SqlCa.SqlCode = -1 Then
	//This.of_Log(10, "Erro na Sa$$HEX1$$ed00$$ENDHEX$$da do Cursor para Verifica$$HEX2$$e700e300$$ENDHEX$$o Hor$$HEX1$$e100$$ENDHEX$$rio Loja da Filial: " + String(pl_Filial) + " Erro:" + SqlCa.SqlErrText )		
	Return False
End If

Close c1;

ps_Horario = Trim(lvs_Horario)

Return True
end function

public subroutine wf_informacoes_filiais ();Long ll_Linha,&
	   ll_Filial

String lvs_horario
	
ids_Excel.AcceptText()

For ll_Linha = 1 To ids_Excel.RowCount()
	 ll_Filial  =  ids_Excel.Object.Cd_Filial[ll_Linha]
	 wf_filial_horarios(ll_Filial,lvs_horario)

	 If lvs_horario='' Then 
		lvs_horario='Sem a Informa$$HEX2$$e700e300$$ENDHEX$$o'
	 End If 	
	 
	 ids_Excel.Object.horarioloja[ll_Linha] = lvs_horario
Next
end subroutine

public function boolean wf_verifica_nome_procedimento (string as_relatorio);String ls_Procedimento

is_Title = ""
is_MSG = ""

Choose Case as_Relatorio
	Case "ds_ge132_desconto_generico"
		ls_Procedimento = "GE132_COMPRA_GENERICO"
		
	Case "ds_ge132_desconto_gam"
		ls_Procedimento = "GE132_DESCONTO_GAM"
		
	Case "ds_ge132_dimensao_produto_geral"
		ls_Procedimento = "GE132_DIMENSOES_PRODUTO"
		
	Case "ds_ge132_fornecedor_comprador"
		ls_Procedimento = "GE132_FORNECEDOR_POR_COMPRADOR"
		
	Case "ds_ge132_produtos_sem_abcfarma"
		ls_Procedimento = "GE132_PRD_NAO_VINC_ABCFARMA"
		
	Case "ds_ge132_lista_filial_por_produto"
		ls_Procedimento = "GE132_FILIAIS_POR_PRODUTO"
		
	Case "ds_ge132_informacoes_filiais"
		ls_Procedimento = "GE132_INFORMACOES_FILIAIS"
		
	Case "ds_ge132_informacoes_estoque"
		ls_Procedimento = "GE132_INFORMACOES_ESTOQUE"
		
	Case "ds_ge132_informacoes_estoque_remaneja"
		ls_Procedimento = "GE132_INFORMACOES_ESTOQUE_REMANEJA"
		
	Case "ds_ge132_excesso_perine"
		ls_Procedimento = "GE132_ESTOQUE_EXCESSO_PERINI"
		
		is_Title = "ESTOQUE EXCESSO - PERINI"
		is_MSG =	"Informa$$HEX2$$e700f500$$ENDHEX$$es extra$$HEX1$$ed00$$ENDHEX$$das:~r" +&
						"CD_PRODUTO|DE_PRODUTO|GRUPO|VL_ESTOQUE|VL_EXCESSO|DH_SALDO~r~r"+&
						"VL_ESTOQUE => SALDO X VALOR CUSTO~r"+&
						"VL_EXCESSO => (SALDO PERINI- [EB ou M$$HEX1$$ed00$$ENDHEX$$nimo Promo$$HEX2$$e700e300$$ENDHEX$$o] 'todas lojas' ) X VALOR CUSTO"		
		
	Case "ds_ge132_excesso_filial"
		ls_Procedimento = "GE132_ESTOQUE_EXCESSO_FILIAL"
	
		is_Title = "ESTOQUE EXCESSO - FILIAL"
		is_MSG =	"Informa$$HEX2$$e700f500$$ENDHEX$$es extra$$HEX1$$ed00$$ENDHEX$$das:~r" +&
						"UF|CD_FILIAL|NM_FANTASIA|GRUPO|CLASSE|VL_ESTOQUE_BASE|VL_EXCESSO~r~r"+&
						"VL_ESTOQUE_BASE => [EB ou M$$HEX1$$ed00$$ENDHEX$$nimo Promo$$HEX2$$e700e300$$ENDHEX$$o] X VALOR CUSTO~r"+&
						"VL_EXCESSO => (SALDO - [EB ou M$$HEX1$$ed00$$ENDHEX$$nimo Promo$$HEX2$$e700e300$$ENDHEX$$o] ) X VALOR CUSTO"
		
	Case "ds_ge132_excesso_produto"
		ls_Procedimento = "GE132_EST_EXCES_PRD_EXCETO_PERINI"
		
		is_Title = "ESTOQUE EXCESSO - PRODUTO (EXCETO PERINI)"
		is_MSG =	"Informa$$HEX2$$e700f500$$ENDHEX$$es extra$$HEX1$$ed00$$ENDHEX$$das:~r" +&
						"UF|GRUPO|CD_PRODUTO|DE_PRODUTO|VL_ESTOQUE_BASE|VL_EXCESSO~r~r"+&
						"VL_ESTOQUE_BASE => [EB ou M$$HEX1$$ed00$$ENDHEX$$nimo Promo$$HEX2$$e700e300$$ENDHEX$$o] X VALOR CUSTO *** Mant$$HEX1$$e900$$ENDHEX$$m no m$$HEX1$$ed00$$ENDHEX$$nimo 1 unidade de EB~r"+&
						"VL_EXCESSO => (SALDO - [EB ou M$$HEX1$$ed00$$ENDHEX$$nimo Promo$$HEX2$$e700e300$$ENDHEX$$o] ) X VALOR CUSTO"
				
	Case "ds_ge132_codigo_barras"
		ls_Procedimento = "GE132_CODIGO_DE_BARRAS"
		
	Case "ds_ge132_substancias"
		ls_Procedimento = "GE132_SUBSTANCIAS"
		
	Case "ds_ge132_atualizacao_produtos_abcfarma"
		ls_Procedimento = "DS_GE132_ATUALIZACAO_PRODUTOS_ABCFARMA"
		
	Case "ds_ge132_preco_regionalizado"
		ls_Procedimento = "DS_GE132_PRECO_REGIONALIZADO"
		
	Case "ds_ge132_consulta_historico_eb_loja"
		ls_Procedimento = "GE132_CONSULTA_HISTORICO_EB_LOJA"
		
	Case "ds_ge132_permite_devolucao"
		ls_Procedimento = "GE132_PERMITE_DEVOLUCAO"
		
	Case "ds_ge132_informacao_produto"
		ls_Procedimento = "GE132_INFORMACAO_PRODUTO"
		
	Case "ds_ge132_historico_alteracao_eb"
		ls_Procedimento = "GE132_HISTORICO_ALTERACAO_EB"
		
	Case "ds_ge132_transferencia_ec"
		ls_Procedimento = "GE132_TRANSFERENCIA_EC"
		
	Case "ds_ge132_enderecamento_produto_ec"
		ls_Procedimento = "GE132_ENDERECAMENTO_PRD_EC"
	
	Case "ds_ge132_dados_produtos_lojas_sazonais"
		ls_Procedimento = "GE132_DADOS_PRD_LOJAS_SAZONAIS"
		
	Case "ds_ge132_linha_produto"
		ls_Procedimento = "GE132_LINHA_PRODUTO"
		
	Case "ds_ge132_informacoes_eb"
		ls_Procedimento = "GE132_INFORMACOES_ESTOQUE_BASE"
		
	Case "ds_ge132_excesso_estoque_periodo"
		ls_Procedimento = "GE132_EXCESSO_ESTOQUE_PERIODO"
		
	Case "ds_ge132_produtos_sem_venda"
		ls_Procedimento = "GE132_PRODUTOS_SEM_VENDA"
		
	Case "ds_ge132_analise_reforco"
		ls_Procedimento = "GE132_ANALISE_REFORCO"
	
	Case "ds_ge132_transferencia_prod_vencidos"
		ls_Procedimento = "GE132_TRANS_PROD_VENCIDO"
		
	Case "ds_ge132_dados_compras"
		ls_Procedimento = "GE132_DADOS_COMPRAS"		
		
	Case 'ds_ge132_periodo_movimentacao_produto'
		ls_Procedimento = 'GE132_PERIODO_MOVIMENTACAO_PRODUTO'
	
	Case 'ds_ge132_periodo_compras_material_limpeza'
		ls_Procedimento = 'GE132_PERIODO_COMPRAS_MATERIAL_LIMPEZA'
		
	Case Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tipo de relat$$HEX1$$f300$$ENDHEX$$rio n$$HEX1$$e300$$ENDHEX$$o previsto.")
		Return False
End Choose

If Not gf_ge132_Verifica_Permissao(ls_Procedimento) Then Return False

Return True
end function

public function boolean wf_carrega_dados_hist_alter_eb ();Date ldt_Resumo

DateTime ldh_Alteracao

Decimal ldc_Demanda_Diaria_Dia

Long ll_Linha
Long ll_Filial
Long ll_Produto
Long ll_Eb_Calc_Dia
Long ll_Qt_Dia_Cober_Dia
Long ll_Est_Min
Long ll_Qt_EB_Atual_Dia

String ls_Nome
String ls_Matric

Try
	//Os campos de hist$$HEX1$$f300$$ENDHEX$$rico s$$HEX1$$e300$$ENDHEX$$o datetime, ent$$HEX1$$e300$$ENDHEX$$o para mostar a altera$$HEX2$$e700e300$$ENDHEX$$o da data corrente $$HEX1$$e900$$ENDHEX$$ adicionado um dia
	ldt_Resumo = RelativeDate(idh_Inicio, 1)
	
	//Hist$$HEX1$$f300$$ENDHEX$$rico EB
	dc_uo_ds_base lds_Hist_EB
	lds_Hist_EB = Create dc_uo_ds_base
	
	If Not lds_Hist_EB.of_ChangeDataObject("ds_ge132_historico_resumo_eb") Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar a ds 'ds_ge132_historico_resumo_eb.", StopSign!)
		Return False
	End If
	
	w_Aguarde.Title = "Carregando hist$$HEX1$$f300$$ENDHEX$$rico de altera$$HEX2$$e700e300$$ENDHEX$$o do estoque base. Aguarde..."
	
	//Filtro de filial
	If dw_1.Object.Id_Conjunto_Filial[1] = "C" Then
		If ivs_filiais <> "" And Not IsNull(ivs_filiais) Then
			lds_Hist_EB.of_AppendWhere("h.cd_filial in (" + ivs_Filiais + ")")
		End If
	End If
	
	If lds_Hist_EB.Retrieve(ldt_Resumo) < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no retrieve da ds 'ds_ge132_historico_resumo_eb'.", StopSign!)
		Return False
	End If
	
	//Hist$$HEX1$$f300$$ENDHEX$$rico Promo$$HEX2$$e700e300$$ENDHEX$$o
	dc_uo_ds_base lds_Hist
	lds_Hist = Create dc_uo_ds_base
		
	If Not lds_Hist.of_ChangeDataObject("ds_ge132_historico_alter_promo") Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar a ds 'ds_ge132_historico_alter_promo.", StopSign!)
		Return False
	End If
	
	w_Aguarde.Title = "Carregando hist$$HEX1$$f300$$ENDHEX$$rico de altera$$HEX2$$e700e300$$ENDHEX$$o de promo$$HEX2$$e700e300$$ENDHEX$$o. Aguarde..."
	
	//Filtro de filial
	If dw_1.Object.Id_Conjunto_Filial[1] = "C" Then
		If ivs_filiais <> "" And Not IsNull(ivs_filiais) Then
			lds_Hist.of_AppendWhere("Cast(substring(h.de_chave, 9, 3) As Integer) in (" + ivs_Filiais + ")")
		End If
	End If
	
	//Por causa do c$$HEX1$$f300$$ENDHEX$$digo da promo$$HEX2$$e700e300$$ENDHEX$$o que mudou de 4 para 5 d$$HEX1$$ed00$$ENDHEX$$gitos, ser$$HEX1$$e100$$ENDHEX$$ considerado o per$$HEX1$$ed00$$ENDHEX$$odo m$$HEX1$$ed00$$ENDHEX$$nimo a partir de 01/07/2018
	If ldt_Resumo < Date("01/07/2018") Then
		ldt_Resumo = Date("01/07/2018")
	End If
	
	If lds_Hist.Retrieve(ldt_Resumo, idh_Inicio) < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no retrieve da ds 'ds_ge132_historico_alter_promo'.", StopSign!)
		Return False
	End If
	
	w_aguarde.uo_progress.of_setmax(ids_Excel.RowCount())
	
	For ll_Linha = 1 To ids_Excel.RowCount()
		ll_Filial		= ids_Excel.Object.Cd_Filial		[ll_Linha]
		ll_Produto	= ids_Excel.Object.Cd_Produto	[ll_Linha]
				
		ll_EB_Calc_Dia = 0
		ldc_Demanda_Diaria_Dia = 0.00
		ll_Qt_Dia_Cober_Dia = 0
		ll_Qt_EB_Atual_Dia = 0
		
		ll_Est_Min = 0
		SetNull(ldh_Alteracao)
		SetNull(ls_Nome)
		SetNull(ls_Matric)
		
		ids_Excel.Object.Dh_Consulta[ll_Linha] = idh_Inicio
				
		If Not wf_Info_Estoque_EB(ll_Filial, ll_Produto, lds_Hist_EB, Ref ll_EB_Calc_Dia, Ref ldc_Demanda_Diaria_Dia, Ref ll_Qt_Dia_Cober_Dia, Ref ll_Qt_EB_Atual_Dia) Then Return False
		
		ids_Excel.Object.Qt_EB_Calculado_Dia		[ll_Linha] = ll_EB_Calc_Dia
		ids_Excel.Object.Qt_Demanda_Diaria_Dia	[ll_Linha] = ldc_Demanda_Diaria_Dia
		ids_Excel.Object.Qt_Dias_Cobertura			[ll_Linha] = ll_Qt_Dia_Cober_Dia
		ids_Excel.Object.Qt_Eb_Dia						[ll_Linha] = ll_Qt_EB_Atual_Dia
		
		If Not wf_Hist_Alter_Promocao(ll_Filial, ll_Produto, lds_Hist, Ref ls_Matric, Ref ls_Nome, Ref ldh_Alteracao, Ref ll_Est_Min) Then Return False
		
		ids_Excel.Object.Nr_Matric_Alteracao	[ll_Linha] = ls_Matric
		ids_Excel.Object.Nm_Alteracao			[ll_Linha] = ls_Nome
		ids_Excel.Object.Dh_Alteracao			[ll_Linha] = ldh_Alteracao
		ids_Excel.Object.Qt_Min_Dia			[ll_Linha] = ll_Est_Min
				
		w_Aguarde.Title = "Filial: [" + String(ll_Filial) + "]. Linha: " + String(ll_Linha) + " at$$HEX1$$e900$$ENDHEX$$: " + String(ids_Excel.RowCount())
		w_aguarde.uo_progress.of_setprogress(ll_Linha)
	Next
	
	Return True
	
Finally
	Destroy(lds_Hist_EB)
	Destroy(lds_Hist)
End Try
end function

public function boolean wf_hist_alter_promocao (long al_filial, long al_produto, dc_uo_ds_base ads_hist_promo, ref string as_matricula, ref string as_nome, ref datetime adh_alteracao, ref long al_minimo);Long ll_Find

ll_Find = ads_hist_promo.Find("cd_filial = " + String(al_Filial) + " and cd_produto = " + String(al_Produto), 1, ads_hist_promo.RowCount())

If ll_Find < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Find da 'ds_ge132_historico_alter_promo'.", StopSign!)
	Return False
End If

If ll_Find > 0 Then
	as_Matricula	= ads_hist_promo.Object.Nr_Matric_Alteracao			[ll_Find]
	as_Nome			= ads_hist_promo.Object.Nm_Usuario					[ll_Find]
	adh_Alteracao	= ads_hist_promo.Object.Dh_Alteracao					[ll_Find]
	al_Minimo		= Long(ads_hist_promo.Object.De_Alteracao_Para	[ll_Find])
End If

Return True
end function

public function boolean wf_info_estoque_eb (long al_filial, long al_produto, dc_uo_ds_base ads_hist_eb, ref long al_qt_estoque_calc_dia, ref decimal adc_demanda_diaria_dia, ref long al_qt_dias_cobertura_dia, ref long al_qt_eb_atual_dia);DateTime ldh_Historico

Long ll_Find

ll_Find = ads_hist_eb.Find("cd_filial = " + String(al_Filial) + " and cd_produto = " + String(al_Produto), 1, ads_hist_eb.RowCount())

If ll_Find < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Find da 'ds_ge132_historico_resumo_eb'.", StopSign!)
	Return False
End If

If ll_Find > 0 Then
	ldh_Historico = ads_Hist_EB.Object.Dta_Maxima[ll_Find]
	
	Select coalesce(qt_estoque_base_anterior, 0), coalesce(qt_demanda_diaria, 0.00), coalesce(qt_dias_cobertura, 0), coalesce(qt_estoque_base_atual, 0)
		Into :al_Qt_Estoque_Calc_Dia, :adc_Demanda_Diaria_Dia, :al_Qt_Dias_Cobertura_Dia, :al_Qt_EB_Atual_Dia
	From resumo_reposicao_estoque_hist
	Where cd_filial = :al_Filial
		And cd_produto = :al_Produto
		And dh_historico = :ldh_Historico
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao consultar o hist$$HEX1$$f300$$ENDHEX$$rico de altera$$HEX2$$e700e300$$ENDHEX$$o do estoque base da filial '" + String(al_Filial) + "' do produto '" + String(al_Produto) + "'.", StopSign!)
		Return False
	End If
End If

Return True
end function

public function boolean wf_qt_dias_ultima_entrada (string as_relatorio);Date ldt_Atual

Long ll_Linha
Long ll_Filial
Long ll_Produto
Long ll_Qtd

ids_Excel.AcceptText()

ldt_Atual = Date(gf_GetServerDate())

w_Aguarde.Title = "Gerando relat$$HEX1$$f300$$ENDHEX$$rio. Aguarde..."
w_aguarde.uo_progress.of_setmax(ids_Excel.RowCount())

For ll_Linha = 1 To ids_Excel.RowCount()
	ll_Filial 		= ids_Excel.Object.Cd_Filial		[ll_Linha]
	ll_Produto	= ids_Excel.Object.Cd_Produto	[ll_Linha]

	If as_Relatorio = "ds_ge132_excesso_estoque_periodo" Then
		Select Top 1 datediff(day, dh_resumo, :idh_Inicio)
			Into :ll_Qtd
		From resumo_movto_estq_prd
		Where cd_filial = :ll_Filial
			And cd_produto = :ll_Produto
			And dh_resumo <= :idh_Inicio
			And (qt_transf_entrada > 0  Or qt_compra > 0 Or qt_ajuste_entrada > 0)
		Order By dh_resumo Desc
		Using SqlCa;
		
	Else
		
		Select Top 1 datediff(day, dh_resumo, :ldt_Atual)
			Into :ll_Qtd
		From resumo_movto_estq_prd
		Where cd_filial = :ll_Filial
			And cd_produto = :ll_Produto
			And (qt_transf_entrada > 0  Or qt_compra > 0 Or qt_ajuste_entrada > 0)
		Order By dh_resumo Desc
		Using SqlCa;
		
	End If
	
	If SqlCa.SqlCode = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao consultar a quantidade de dias ap$$HEX1$$f300$$ENDHEX$$s a $$HEX1$$fa00$$ENDHEX$$ltima entrada do produto." + SqlCa.SqlErrText + &
										"~rFilial: " + String(ll_Filial) + &
										 "~rProduto: " + String(ll_Produto), StopSign!)
		Return False
	End If
	
	ids_Excel.Object.Qt_Dias_Ult_Entrada[ll_Linha] = ll_Qtd
	
	w_Aguarde.Title = "Quantidade de dias da $$HEX1$$fa00$$ENDHEX$$ltima entrada do produto... Filial: " + String(ll_Filial)
	w_aguarde.uo_progress.of_setprogress(ll_Linha)
Next

Return True
end function

public function long wf_relatorio_hist_alteracao_eb (string as_produtos, string as_alteracao_atual);Date ldt_Resumo
Date ldt_Mes_Ant

DateTime ldh_Termino_EB

Long ll_Mes
Long ll_Ano
Long ll_Linha
Long ll_Total_Linhas

String ls_Produtos_In
String ls_Path_Diretorio
String ls_Nome_Arquivo

dw_1.AcceptText()

//O dh_historico $$HEX1$$e900$$ENDHEX$$ datetime e a vari$$HEX1$$e100$$ENDHEX$$vel idh_Termino $$HEX1$$e900$$ENDHEX$$ do tipo date. Para ajustar isso $$HEX1$$e900$$ENDHEX$$ utilizada a vari$$HEX1$$e100$$ENDHEX$$vel ldh_Termino_EB
ldh_Termino_EB = DateTime(Date(idh_Termino), Time('23:59:59'))

ldt_Resumo = Date("01/" + MidA(String(idh_Inicio), 4))
			
ll_Mes = Month(ldt_Resumo)
ll_Ano = Year(ldt_Resumo)

If ll_Mes = 1 Then
	ll_Mes = 12
	ll_Ano = ll_Ano -1
Else
	ll_Mes = ll_Mes - 1
End If

ldt_Mes_Ant = Date("01/" + String(ll_Mes) + "/" + String(ll_Ano))

ls_Path_Diretorio = gvo_Aplicacao.of_GetFromINI("Diretorio", "Diretorio")

If as_Produtos = 'C' Then
	If Not wf_Importa_excel( Ref ls_Produtos_In ) Then Return -2 //Retorna -2 pra n$$HEX1$$e300$$ENDHEX$$o dar mensagem de erro no evento clicked do bot$$HEX1$$e300$$ENDHEX$$o Gerar Planilha
End If

w_Aguarde.Title = "Gerando arquivo de hist$$HEX1$$f300$$ENDHEX$$rico de altera$$HEX2$$e700e300$$ENDHEX$$o de base. Aguarde..."
w_aguarde.uo_progress.of_setmax(il_Lojas)

For ll_Linha = 1 To il_Lojas	
	ids_Excel.Reset()
	
	If dw_1.Object.Id_Conjunto_Filial[1] = "C" Then
		If ivs_filiais <> "" And Not IsNull(ivs_filiais) Then
			ids_Excel.of_AppendWhere_SubQuery("r.cd_filial in (" + ivs_Filiais + ")", 4)
		End If
	End If
	
	If ls_Produtos_In <> "" Then		 
		 ids_Excel.of_appendwhere_subquery( "r.cd_produto in ( "+ls_Produtos_In+")", 4)
	End If
	
	If as_alteracao_atual <> "T" Then
		ids_Excel.Of_AppendWhere_SubQuery( "r.id_alteracao_atual = '" + as_alteracao_atual + "'", 4)
	End If
	
	ids_Excel.Retrieve(DateTime(idh_Inicio), ldh_Termino_EB, DateTime(ldt_Mes_Ant), Datetime(ldt_Resumo), ivo_Selecao_filiais.Cd_Filial[ll_Linha])
	
	il_Qtd_Resultado = ids_Excel.rowcount( )
	
	If il_Qtd_Resultado < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no retrieve da fiilial " + String(ivo_Selecao_filiais.Cd_Filial[ll_Linha]), StopSign!)
		Return -2
	End If
	
	If il_Qtd_Resultado > 0 Then
		ls_Nome_Arquivo = ls_Path_Diretorio + "historico_de_alteracao_eb_" + String(ivo_Selecao_filiais.Cd_Filial[ll_Linha]) + &
		"_de_" + gf_Replace(String(idh_Inicio), "/", "_", 0) + "_ate_" + gf_Replace(String(idh_Termino), "/", "_", 0) + ".txt"
		
		If ids_Excel.SaveAs(ls_Nome_Arquivo, Text!, True) <> 1 Then			
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gerar o arquivo '" + ls_Path_Diretorio + "'.", StopSign!)
			Return -2
		End If
	End If
	
	w_Aguarde.Title = "Filial: [" + String(ivo_Selecao_filiais.Cd_Filial[ll_Linha]) + "] " + String(ll_Linha) + " at$$HEX1$$e900$$ENDHEX$$ " + String(il_Lojas)
	w_aguarde.uo_progress.of_setprogress(ll_Linha)
	
	ll_Total_Linhas += il_Qtd_Resultado
Next

//Se chegou na $$HEX1$$fa00$$ENDHEX$$ltima linha e teve registros
If (ll_Total_Linhas > 0) And (ll_Linha > il_Lojas) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Arquivos gerados com sucesso.")
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foram localizados dados com os par$$HEX1$$e200$$ENDHEX$$metros selecionados.")
	Return -2
End If

Return 1
end function

public subroutine _documentacao ();/*
	  Objetivo: A funcionalidade tem como objetivo gerar v$$HEX1$$e100$$ENDHEX$$rios relat$$HEX1$$f300$$ENDHEX$$rios no formato Excel, cada um tem sua caracteristica.
	Chamado: 1098359
Respons$$HEX1$$e100$$ENDHEX$$vel: Saulo Braga



Tabelas:

 			- Relat$$HEX1$$f300$$ENDHEX$$rio Subst$$HEX1$$e200$$ENDHEX$$ncia
				- 	composicao_produto
	             	-	substancia_produto
				-	produto_geral
				-	tipo_concentracao tc 
         		-	unidade_medida


*/
end subroutine

public function boolean wf_importa_filial_produto_promocao (ref st_ge132_filial_produto_promocao ast_ge132_filial_produto_promocao[]);Any			la_Filial, la_Produto
dc_uo_Excel	lo_Excel
Long			ll_TotalA, ll_TotalB, ll_Row, ll_linha_st

Try
	If wf_fileOpen () > 0 then
		SetPointer(HourGlass!)
		w_Aguarde.Title = "Lendo dados do arquivo: '" + Upper (is_arquivo_Produtos) + "'."
		
		lo_Excel = Create dc_uo_Excel
		
		lo_Excel.uo_Referencia_Objeto_Excel (is_arquivo_Produtos)
		ll_TotalA = lo_Excel.uo_Verifica_Tamanho_Arquivo ('A')
		ll_TotalB = lo_Excel.uo_Verifica_Tamanho_Arquivo ('B')
		
		If ll_TotalB > ll_TotalA then
			ll_TotalA = ll_TotalB
		End if
		
		If ll_TotalA = 0 Then
			MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'A planilha selecionada est$$HEX1$$e100$$ENDHEX$$ vazia.', Exclamation!)
			Return False
		End If
		
		w_Aguarde.uo_Progress.of_SetMax (ll_TotalA)
		
		For ll_Row = 1 To ll_TotalA
			
			w_Aguarde.uo_Progress.of_SetProgress (ll_Row)
			
			la_Filial  = lo_Excel.uo_Lendo_Dados (ll_Row, 'A')
			la_Produto = lo_Excel.uo_Lendo_Dados (ll_Row, 'B')
			
			If Not IsNumber (String (la_Filial)) or &
				Not IsNumber (String (la_Produto)) then
				Continue
			End if
			
			ll_linha_st ++
			ast_ge132_filial_produto_promocao[ll_linha_st].cd_Filial  = Long (la_Filial)
			ast_ge132_filial_produto_promocao[ll_linha_st].cd_Produto = Long (la_Produto)
		Next
		
		If ll_linha_st = 0 then
			MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'A planilha selecionada n$$HEX1$$e300$$ENDHEX$$o tem dados v$$HEX1$$e100$$ENDHEX$$lidos para a pesquisa.', Exclamation!)
			Return False
		End if
	Else
		Return False
	End if
	
Finally
	If IsValid (lo_Excel) Then Destroy lo_Excel	
End Try

Return True
end function

on w_ge132_relatorios_diversos.create
int iCurrent
call super::create
this.cb_gerar=create cb_gerar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_gerar
end on

on w_ge132_relatorios_diversos.destroy
call super::destroy
destroy(this.cb_gerar)
end on

event open;call super::open;//  Sistema WMS n$$HEX1$$e300$$ENDHEX$$o tem Help
//If  gvo_aplicacao.ivo_seguranca.cd_sistema = 'WS' Then 
//	pb_help.Visible = False
//Else
//	pb_help.Visible = True
//End If 

pb_help.Visible = True

ivb_permite_fechar = false
end event

event close;call super::close;Destroy ids_Excel
Destroy io_Produto
Destroy ivo_Selecao_filiais
Destroy ivo_fornecedor
Destroy io_Filial
Destroy io_Comprador
Destroy io_Promocao
end event

event ue_preopen;call super::ue_preopen;ids_Excel				= Create dc_uo_ds_base
io_Produto			   = Create uo_produto
ivo_Selecao_filiais	= Create uo_ge216_filiais
ivo_fornecedor 		= Create uo_fornecedor
io_Filial		      = Create uo_Filial
io_Comprador         = Create uo_ge149_Comprador
io_Promocao          = Create uo_promocao
end event

event ue_postopen;call super::ue_postopen;io_Promocao.ivs_Tipo = 'P'
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge132_relatorios_diversos
integer x = 18
integer y = 644
integer height = 116
end type

event pb_help::clicked;call super::clicked;//wf_Help("Relat$$HEX1$$f300$$ENDHEX$$rios Diversos (GE132)")

If is_Title <> "" Then
	MessageBox(is_Title, is_MSG)
End If

end event

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge132_relatorios_diversos
integer x = 18
integer y = 0
integer width = 1902
integer height = 648
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge132_relatorios_diversos
integer x = 41
integer y = 44
integer width = 1856
integer height = 588
string dataobject = "dw_ge132_lista_relatorios"
end type

event dw_1::itemchanged;call super::itemchanged;Date ldh_Null
Long	ll_Nulo
String ls_Nulo

SetNull( ldh_Null )
SetNull( ll_Nulo )
SetNull( ls_Nulo )

This.AcceptText()

Choose Case dwo.Name
	case "nm_relatorio"

		This.Object.inicio_t.Visible 				= 0
		This.Object.dh_Inicio.Visible 			= 0
		This.Object.termino_t.Visible 			= 0
		This.Object.dh_termino.Visible		 	= 0
		
		This.Object.cd_uf.Visible 				= 0
		This.Object.estado_t.Visible 			= 0
		This.Object.id_produtos.Visible			= 0
		This.Object.produto_t.Visible			= 0
		
		This.Object.Filiais_t.Visible				= 0
		This.Object.Id_Conjunto_Filial.Visible	= 0
		This.Object.Produto_t.Visible			= 0
		This.Object.Id_Produtos.Visible			= 0
		
		This.Object.Alteracao_t.Visible        	 = 0
		This.Object.Id_Alteracao_Atual.Visible = 0
		This.Object.Nm_Fornecedor.Visible 	 = 0
		This.Object.Cd_Fornecedor.Visible		 = 0
		This.Object.Fornecedor_t.Visible		 = 0
		
		This.Object.Nm_Comprador.Visible	 = 0
		This.Object.Nr_Matricula.Visible 		 = 0
		This.Object.Comprador_t.Visible 		 = 0
		
		This.Object.Path_t.Visible				 = 0
		This.Object.id_compras.Visible 		 = 0
		This.Object.tipo_t.Visible					 = 0
		This.Object.vencimento_t.Visible		 = 0	
		This.Object.dh_inicio_vcto.Visible		 =	0	
		This.Object.dh_termino_vcto.Visible	 =	0
		This.Object.ate_vcto_t.Visible			 = 0
		
		This.Object.id_situacao_t.Visible		 = 0
		This.Object.id_situacao.Visible			 = 0
		
		This.Object.id_tipo_filtro.Visible      = 0
		This.Object.nm_promocao_sos_t.Visible   = 0
		This.Object.nm_promocao_sos.Visible     = 0
		This.Object.cd_promocao_sos.Visible     = 0
		This.Object.nm_filial_t.Visible         = 0
		This.Object.nm_filial.Visible	          = 0
		This.Object.cd_filial.Visible	          = 0
		This.Object.Produto_t.Visible			    = 0
		This.Object.de_produto.Visible		  	 = 0
		This.Object.cd_produto.Visible		  	 = 0
		
		Choose Case Data
				
			Case 'ds_ge132_consulta_historico_eb_loja'
				This.Object.dh_Inicio				[1] = ldh_Null
				This.Object.dh_Termino			[1] = ldh_Null
				
				This.Object.inicio_t.Visible 				= 1
				This.Object.dh_Inicio.Visible 			= 1
				This.Object.termino_t.Visible 			= 0
				This.Object.dh_termino.Visible 			= 0
				This.Object.Filiais_t.Visible				= 1
				This.Object.Id_Conjunto_Filial.Visible	= 1
				
			Case 'ds_ge132_desconto_gam', 'ds_ge132_desconto_generico', 'ds_ge132_atualizacao_produtos_abcfarma', 'ds_ge132_analise_reforco','ds_ge132_transferencia_prod_vencidos','ds_ge132_periodo_compras_material_limpeza'
				
				This.Object.dh_Inicio		[1] = ldh_Null
				This.Object.dh_Termino	[1] = ldh_Null
				
				This.Object.inicio_t.Visible 				= 1
				This.Object.dh_Inicio.Visible 			= 1
				This.Object.termino_t.Visible 			= 1
				This.Object.dh_termino.Visible		 	= 1
				This.Object.Filiais_t.Visible				= 0
				This.Object.Id_Conjunto_Filial.Visible	= 0
	
			Case 'ds_ge132_informacoes_estoque', 'ds_ge132_informacoes_estoque_remaneja'	
				This.Object.cd_uf.Visible 				= 0
				This.Object.estado_t.Visible 			= 0
				This.Object.id_produtos.Visible		 	= 1
				This.Object.produto_t.Visible 			= 1
				
				This.Object.inicio_t.Visible 				= 0
				This.Object.dh_Inicio.Visible 			= 0
				This.Object.termino_t.Visible 			= 0
				This.Object.dh_termino.Visible 			= 0
				This.Object.Filiais_t.Visible				= 1
				This.Object.Id_Conjunto_Filial.Visible	= 1
				
				This.Object.Nm_Fornecedor.Visible 	= 1
				This.Object.Cd_Fornecedor.Visible 	= 1
				This.Object.Fornecedor_t.Visible 		= 1
				This.Object.Nm_Comprador.Visible	= 1
				This.Object.Nr_Matricula.Visible 		= 1
				This.Object.Comprador_t.Visible 		= 1
				
			Case 'ds_ge132_transferencia_ec'
				This.Object.dh_Inicio				[1] = ldh_Null
				This.Object.dh_Termino			[1] = ldh_Null
				
				This.Object.inicio_t.Visible 				= 1
				This.Object.dh_Inicio.Visible 			= 1
				This.Object.termino_t.Visible 			= 1
				This.Object.dh_termino.Visible 			= 1
				This.Object.Filiais_t.Visible				= 1
				This.Object.Id_Conjunto_Filial.Visible	= 1
				
			Case 'ds_ge132_historico_alteracao_eb'
				This.Object.dh_Inicio				[1] = ldh_Null
				This.Object.dh_Termino			[1] = ldh_Null
				
				This.Object.inicio_t.Visible 				  = 1
				This.Object.dh_Inicio.Visible 		    	  = 1
				This.Object.termino_t.Visible 		 	  = 1
				This.Object.dh_termino.Visible 			  = 1
				This.Object.Filiais_t.Visible				  = 1
				This.Object.Id_Conjunto_Filial.Visible	  = 1
				This.Object.Produto_t.Visible			  = 1
				This.Object.Id_Produtos.Visible		  	  = 1
				This.Object.Alteracao_t.Visible			  = 1
				This.Object.Id_Alteracao_Atual.Visible  = 1
				This.Object.Path_t.Visible				   = 1
				
				This.Object.Path_t.Text = "Os arquivos ser$$HEX1$$e300$$ENDHEX$$o salvos em " + gvo_Aplicacao.of_GetFromINI("Diretorio", "Diretorio")
				
			Case 'ds_ge132_dados_produtos_lojas_sazonais'
				This.Object.Filiais_t.Visible				= 1
				This.Object.Id_Conjunto_Filial.Visible	= 1
				
			Case 'ds_ge132_informacoes_eb'
				This.Object.Filiais_t.Visible				  = 1
				This.Object.Id_Conjunto_Filial.Visible	  = 1
				This.Object.Produto_t.Visible			  = 1
				This.Object.Id_Produtos.Visible		  	  = 1
				
			Case 'ds_ge132_excesso_estoque_periodo'		
				This.Object.inicio_t.Visible 				= 1
				This.Object.dh_Inicio.Visible 			= 1
				
				This.Object.Filiais_t.Visible				 = 1
				This.Object.Id_Conjunto_Filial.Visible	 = 1
				This.Object.Produto_t.Visible			 = 1
				This.Object.Id_Produtos.Visible		  	 = 1
			
			Case 'ds_ge132_dados_compras'		
				This.Object.dh_Inicio		[1] = ldh_Null
				This.Object.dh_Termino	[1] = ldh_Null
				This.Object.inicio_t.Visible 				= 1
				This.Object.dh_Inicio.Visible 			= 1
				This.Object.termino_t.Visible 			= 1
				This.Object.dh_termino.Visible		 	= 1
				This.Object.Nm_Fornecedor.Visible 	= 1
				This.Object.Cd_Fornecedor.Visible 	= 1
				This.Object.Fornecedor_t.Visible 		= 1
				This.Object.id_compras.Visible 		= 1
				This.Object.tipo_t.Visible				 	= 1
				This.Object.Filiais_t.Visible				= 1
				This.Object.Id_Conjunto_Filial.Visible	= 1
				This.Object.vencimento_t.Visible		= 1	
				This.Object.dh_inicio_vcto.Visible		= 1	
				This.Object.dh_termino_vcto.Visible	= 1
				This.Object.ate_vcto_t.Visible 			= 1
				
			Case 'ds_ge132_informacoes_filiais'
				This.Object.id_situacao_t.Visible		 = 1
				This.Object.id_situacao.Visible			 = 1
				
			Case 'ds_ge132_periodo_movimentacao_produto'
				ib_Importar_Planilha                    = False
				This.Object.id_tipo_filtro [1]          = 'M'
				This.Object.id_tipo_filtro.Visible      = 1
				This.Object.nm_promocao_sos_t.Visible   = 1
				This.Object.nm_promocao_sos.Visible     = 1
				This.Object.cd_promocao_sos.Visible     = 1
				This.Object.nm_filial_t.Visible         = 1
				This.Object.nm_filial.Visible           = 1
				This.Object.cd_filial.Visible           = 1
				This.Object.Produto_t.Visible           = 1
				This.Object.de_produto.Visible          = 1
				This.Object.cd_produto.Visible          = 1
				
		End Choose
		
		If Not wf_Verifica_Nome_Procedimento(Data) Then
			cb_gerar.Enabled = False
			Return 1
		Else
			cb_gerar.Enabled = True
		End If

	Case "nm_fornecedor"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_fornecedor.nm_fantasia Then
				Return 1
			End If
		Else
			ivo_fornecedor.of_Inicializa()
			
			This.Object.cd_fornecedor		[1] = ivo_fornecedor.cd_fornecedor
			This.Object.nm_fornecedor		[1] = ivo_fornecedor.nm_fantasia
		End If
		
		Case "nm_comprador"		
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> io_Comprador.Nm_Usuario Then
				Return 1
			End If
		Else
			io_Comprador.of_Inicializa()
			
			This.Object.Nr_Matricula	[1] = io_Comprador.Nr_Matricula
			This.Object.Nm_Comprador	[1] = io_Comprador.Nm_Usuario
		End If

	Case "id_conjunto_filial"
			
		ivs_filiais = ls_Nulo
		
		If Data = 'C' Then
			OpenWithParm(w_ge216_selecao_filiais, ivo_Selecao_filiais)
			
			il_Lojas = Message.DoubleParm
			
			If il_Lojas > 0 Then
				ivs_filiais = ivo_Selecao_filiais.ivs_filiais
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma filial foi selecionada.")
			End If
		End If
	
	Case "id_produtos"
		If wf_fileOpen() = 0 Then
			 Return 1
		End If						
		
	case 'id_tipo_filtro'
		ib_Importar_Planilha = data = 'P'
		This.Object.nm_filial       [1] = ls_Nulo
		This.Object.cd_filial       [1] = ll_Nulo
		This.Object.de_produto      [1] = ls_Nulo
		This.Object.cd_produto      [1] = ll_Nulo
		This.Object.nm_promocao_sos [1] = ls_Nulo
		This.Object.cd_promocao_sos [1] = ll_Nulo
		
	Case 'nm_filial'
		If Data <> io_Filial.Nm_Fantasia Then
			Return 1
		End If
		
	Case 'de_produto'
		If Data <> io_Produto.ivs_Descricao_Apresentacao_Venda Then
			Return 1
		End If
		
	Case 'nm_promocao_sos'
		If Not IsNull(Data) And Trim(Data) <> '' Then
			If Data <> io_Promocao.Nm_Promocao Then
				Return 1
			End If
		Else
			io_Promocao.of_Inicializa()
			
			This.Object.Cd_Promocao_Sos [1] = io_Promocao.Cd_Promocao
			This.Object.Nm_Promocao_Sos [1] = io_Promocao.Nm_Promocao
		End If

End choose
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "nm_fornecedor"
			ivo_Fornecedor.id_selecao_cadastro = "S"
			
			ivo_Fornecedor.of_Localiza_Fornecedor(This.GetText())
						
			If ivo_Fornecedor.Localizado Then
				This.Object.cd_fornecedor [1] = ivo_Fornecedor.Cd_Fornecedor
				This.Object.nm_fornecedor[1] = ivo_Fornecedor.Nm_Razao_Social
			End If
			
		Case "nm_comprador"
			io_Comprador.of_Localiza_Comprador(This.GetText())
			
			If io_Comprador.Localizado Then
				This.Object.Nr_Matricula		[1] = io_Comprador.Nr_Matricula
				This.Object.Nm_Comprador	[1] = io_Comprador.Nm_Usuario
			Else
				io_Comprador.of_Inicializa()
			End If
			
		Case 'nm_filial'
			io_Filial.of_Localiza_Filial(This.GetText())
			
			If io_Filial.Localizada Then
				This.Object.Cd_Filial[1] = io_Filial.Cd_Filial
				This.Object.Nm_Filial[1] = io_Filial.Nm_Fantasia
			End If
			
		Case 'de_produto'
			io_Produto.of_Localiza_Produto(This.GetText())
			
			If io_Produto.Localizado Then
				This.Object.Cd_Produto[1] = io_Produto.Cd_Produto
				This.Object.De_Produto[1] = io_Produto.ivs_Descricao_Apresentacao_Venda
			End If
			
		Case 'nm_promocao_sos'
		
			io_Promocao.of_Localiza(This.GetText())
			
			If Not io_Promocao.Localizado Then
				io_Promocao.of_Inicializa()
			End If
				
			This.Object.Cd_Promocao_Sos [1] = io_Promocao.Cd_Promocao
			This.Object.Nm_Promocao_Sos [1] = io_Promocao.Nm_Promocao

	End Choose
End If
end event

event dw_1::constructor;call super::constructor;This.of_setcolselection(True)
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge132_relatorios_diversos
boolean visible = false
integer x = 1993
integer y = 1288
integer width = 270
string text = "&Ok"
end type

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge132_relatorios_diversos
integer x = 1605
integer y = 652
end type

type cb_gerar from commandbutton within w_ge132_relatorios_diversos
integer x = 1088
integer y = 652
integer width = 489
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Gerar Planilha"
end type

event clicked;String lvs_Relatorio,&
		 lvs_planilha,&
		 ls_Fornecedor,&
		 ls_Comprador,&
		 lvs_Filiais

dw_1.AcceptText()

lvs_Relatorio = dw_1.Object.nm_relatorio[1]
ls_Fornecedor = dw_1.Object.Cd_Fornecedor [1]
ls_Comprador = dw_1.Object.Nr_Matricula [1]

If lvs_Relatorio = "" Or IsNull(lvs_Relatorio) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um relat$$HEX1$$f300$$ENDHEX$$rio.")
	dw_1.Event ue_Pos(1,"nm_relatorio")
	Return -1
End If

SetPointer(HourGlass!)

If lvs_Relatorio = "ds_ge132_desconto_gam" Or lvs_Relatorio = "ds_ge132_desconto_generico" Or lvs_Relatorio = "ds_ge132_atualizacao_produtos_abcfarma" Or &
	lvs_Relatorio = "ds_ge132_consulta_historico_eb_loja" Or lvs_Relatorio = "ds_ge132_historico_alteracao_eb" Or lvs_Relatorio = "ds_ge132_transferencia_ec" Or &
	lvs_Relatorio = "ds_ge132_excesso_estoque_periodo" Or lvs_Relatorio = "ds_ge132_analise_reforco" or   lvs_Relatorio= "ds_ge132_dados_compras"  Or & 
	lvs_Relatorio = 'ds_ge132_transferencia_prod_vencidos' Or lvs_Relatorio = "ds_ge132_periodo_compras_material_limpeza" Then
	
	idh_Inicio 		= dw_1.Object.dh_inicio		[ 1 ]
	idh_Termino 	= dw_1.Object.dh_termino	[ 1 ]
	
	If IsNull( idh_Inicio ) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio corretamente.")
		dw_1.Event ue_Pos(1,"dh_inicio")
		Return -1
	End If
		
	If lvs_Relatorio <> "ds_ge132_consulta_historico_eb_loja" And lvs_Relatorio <> "ds_ge132_excesso_estoque_periodo" Then
		If IsNull( idh_Termino ) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino corretamente.")
			dw_1.Event ue_Pos(1,"dh_termino")
			Return -1
		End If
		
		If idh_Inicio > idh_Termino Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de t$$HEX1$$e900$$ENDHEX$$rmino deve ser maior do que a data de in$$HEX1$$ed00$$ENDHEX$$cio.")
			dw_1.Event ue_Pos(1,"dh_inicio")
			Return -1
		End If
		
	Else
		
		If idh_Inicio > Date(gf_GetServerDate()) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data informada $$HEX1$$e900$$ENDHEX$$ maior que a data corrente.")
			Return -1
		End If
		
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tem certeza que deseja executar o relat$$HEX1$$f300$$ENDHEX$$rio com os par$$HEX1$$e200$$ENDHEX$$metros informados?", Question!, YesNo!, 2) = 2 Then Return -1
	End If
End If	

If lvs_Relatorio = "ds_ge132_informacoes_estoque" Or  lvs_Relatorio = "ds_ge132_informacoes_estoque_remaneja" Then
//	is_estado 		= dw_1.Object.cd_uf	[1]
	lvs_planilha		= dw_1.Object.	id_produtos[1]

//	If IsNull(is_estado) Then 
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informa o Estado de Pesquisa.")
//		dw_1.Event ue_Pos(1,"cd_uf")
//		Return -1
//	End If

	If lvs_planilha = "S" And IsNull(ls_Fornecedor) And IsNull(ls_Comprador) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Voc$$HEX1$$ea00$$ENDHEX$$ deve realizar algum filtro para continuar.~rInforme alguns produtos, fornecedor ou comprador.", Exclamation!)
		Return -1
	End If
		
	If ivs_filiais = "" Or IsNull(ivs_filiais) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma filial foi selecionada.")
		Return -1
	End If
End If

If lvs_Relatorio = "ds_ge132_historico_alteracao_eb" Or lvs_Relatorio = "ds_ge132_transferencia_ec" or lvs_Relatorio = "ds_ge132_dados_produtos_lojas_sazonais" Then
	If ivs_filiais = "" Or IsNull(ivs_filiais) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma filial foi selecionada.")
		Return -1
	End If
	If lvs_Relatorio = "ds_ge132_historico_alteracao_eb" Then
		If il_Lojas > 100 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Este relat$$HEX1$$f300$$ENDHEX$$rio n$$HEX1$$e300$$ENDHEX$$o permite selecionar mais de 100 filiais.")
			Return -1
		End If
	End If
End If

If lvs_Relatorio = 'ds_ge132_periodo_movimentacao_produto' then
	If not ib_Importar_Planilha then
		If IsNull (dw_1.Object.nm_filial       [1]) and &
			IsNull (dw_1.Object.de_produto      [1]) and &
			IsNull (dw_1.Object.nm_promocao_sos [1]) then
			MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Voc$$HEX1$$ea00$$ENDHEX$$ deve informar filial, produto ou promo$$HEX2$$e700e300$$ENDHEX$$o para continuar.', Exclamation!)
			Return -1
		End if
	End if
End If

If wf_relatorio_padrao( lvs_Relatorio ) = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao gravar a planilha: '" + lvs_Relatorio + "'.", Information!)
End If
	
SetPointer(Arrow!)
end event

