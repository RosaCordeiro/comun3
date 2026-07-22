HA$PBExportHeader$w_ge350_inclui_retirada_via_planilha.srw
forward
global type w_ge350_inclui_retirada_via_planilha from dc_w_response_ok_cancela
end type
type dw_2 from dc_uo_dw_base within w_ge350_inclui_retirada_via_planilha
end type
type cb_importa from commandbutton within w_ge350_inclui_retirada_via_planilha
end type
type gb_2 from groupbox within w_ge350_inclui_retirada_via_planilha
end type
type dw_3 from dc_uo_dw_base within w_ge350_inclui_retirada_via_planilha
end type
type dw_4 from dc_uo_dw_base within w_ge350_inclui_retirada_via_planilha
end type
type gb_3 from groupbox within w_ge350_inclui_retirada_via_planilha
end type
end forward

global type w_ge350_inclui_retirada_via_planilha from dc_w_response_ok_cancela
integer width = 3872
integer height = 2380
string title = "GE350 - Retirada de Estoque via Planilha"
dw_2 dw_2
cb_importa cb_importa
gb_2 gb_2
dw_3 dw_3
dw_4 dw_4
gb_3 gb_3
end type
global w_ge350_inclui_retirada_via_planilha w_ge350_inclui_retirada_via_planilha

type variables
str_ge350_retirada_produto st
//str_ge350_lista_email st_email

// Controle para criar retirada para resolver erro de faturamento do SAP 
Boolean ib_corrigir_faturamento_sap = False
end variables

forward prototypes
public function boolean wf_le_dados_planilha ()
public function boolean wf_salva_retirada ()
public subroutine wf_set_somente_consulta ()
public function boolean wf_localiza_movimento (long al_produto, long al_filial)
public function boolean wf_permite_retirada (longlong al_ncm, string as_dev_transf, string as_situacao_tributaria, string as_uf, ref long al_tipo_produto_fiscal)
public function boolean wf_localiza_filial (long al_filial, ref boolean ab_achou, ref string as_nome_fantasia, ref string as_uf)
public function boolean wf_valida_informacoes ()
public function boolean wf_grava_produto (long al_retirada, ref string as_erro)
public function boolean wf_numero_retirada (long al_filial, ref long al_retirada, ref string as_erro)
public function boolean wf_salva_lista_divergentes (ref string as_mensagem, ref string as_erro)
public subroutine wf_dados_email (long al_filial, long al_retirada, datetime adh_inicio, datetime adh_termino)
public function boolean wf_custo_produto (long al_produto, long al_filial, ref decimal adc_custo)
public function boolean wf_localiza_produto (long al_produto, ref boolean ab_achou, ref string as_de_produto, ref long al_ncm, ref decimal adc_tributacao_icms, ref decimal adc_fator_conversao, ref decimal adc_dimensao_litros, ref decimal adc_peso_produto)
end prototypes

public function boolean wf_le_dados_planilha ();Any la_Dado

Boolean lb_Achou_Prd
Boolean lb_Achou_Fil

Decimal ldc_Fator_Conversao
Decimal ldc_Tributacao_Icms
Decimal ldc_Custo
Decimal ldc_Dimensao_Litros
Decimal ldc_Peso_Produto

Long ll_Linha
Long ll_Linhas
Long ll_Ncm
Long ll_Tipo_Produto_Fiscal
Long ll_Nulo
Long ll_Filial
Long ll_Produto
Long ll_Qtd_Ret

String ls_Arquivo
String ls_Nome_Fantasia
String ls_De_Produto
String ls_Nulo
String ls_Tributacao_Icms
String ls_ID_DEV_TRANS
String ls_Divergencia
String ls_Uf

Try
	
	dw_1.AcceptText()
	dw_2.AcceptText()

	dc_uo_excel lo_Excel
	lo_Excel = Create dc_uo_excel
	
	uo_tratamento_fiscal lo_Tratamento
	lo_Tratamento = Create uo_tratamento_fiscal
	
	ls_Arquivo = dw_1.Object.De_Arquivo[1]
	
	Open(w_Aguarde_1)
	w_Aguarde_1.Title = "Importando planilha..."
	
	w_Aguarde_1.y += 400
	
	SetNull(ls_Nulo)
	SetNull(ll_Nulo)
	
	SetRedraw(False)
	SetPointer(HourGlass!)
	
	// Refer$$HEX1$$ea00$$ENDHEX$$ncia o arquivo 
	If ( lo_Excel.uo_Referencia_Objeto_Excel(ls_Arquivo) ) Then
		
		ll_Linhas = lo_Excel.uo_Verifica_Tamanho_Arquivo("A")
		
		If ll_Linhas > 0 Then
			w_Aguarde_1.uo_Progress.of_SetMax(ll_Linhas)
						
			For ll_Linha = 1 To ll_Linhas
				
				//aqui
				w_aguarde_1.uo_progress.of_setprogress(ll_Linha)
				w_Aguarde_1.Title = "Importando registro " + String(ll_Linha) + " de " + String(ll_Linhas)
				
				ll_Filial 				= ll_Nulo
				ls_Nome_Fantasia	= ls_Nulo
				ll_Produto 			= ll_Nulo
				ls_De_Produto 		= ls_Nulo
				ll_Qtd_Ret 			= ll_Nulo
				
				ls_Divergencia = ""
				lb_Achou_Prd = False
				lb_Achou_Fil = False
				
				//C$$HEX1$$f300$$ENDHEX$$digo da filial
				la_Dado = lo_Excel.uo_Lendo_Dados(ll_Linha, "A")
					
				If Not IsNumber(String(la_Dado)) Or IsNull(String(la_Dado)) Then
					//dw_2.Object.Id_Div_Filial[ll_Linha] = 'S'
					ls_Divergencia = 'Filial inv$$HEX1$$e100$$ENDHEX$$lida. |'
				Else					
					If Not wf_Localiza_Filial(Long(la_Dado), Ref lb_Achou_Fil, Ref ls_Nome_Fantasia, Ref ls_Uf) Then Return False
					
					If Not lb_Achou_Fil Then
						ls_Divergencia = "Filial n$$HEX1$$e300$$ENDHEX$$o localizada. |"
					End If
				End If
				
				ll_Filial = Long(la_Dado)
				
				//C$$HEX1$$f300$$ENDHEX$$digo do produto
				la_Dado = lo_Excel.uo_Lendo_Dados(ll_Linha, "B")
								
				If Not IsNumber(String(la_Dado)) Or IsNull(String(la_Dado)) Then
					//dw_2.Object.Id_Div_Produto[ll_Linha] = 'S'
					ls_Divergencia += 'Produto inv$$HEX1$$e100$$ENDHEX$$lido. |'
				Else					
					If Not wf_Localiza_Produto(	Long(la_Dado),&
														Ref lb_Achou_Prd,&
														Ref ls_De_Produto,&
														Ref ll_Ncm,&
														Ref ldc_Tributacao_Icms,&
														Ref ldc_Fator_Conversao,&
														Ref ldc_Dimensao_Litros,&
														Ref ldc_Peso_Produto) Then
						Return False
					End If
					
					If Not lb_Achou_Prd Then
						ls_Divergencia += 'Produto n$$HEX1$$e300$$ENDHEX$$o localizado. |'
					End If
				End If
				
				ll_Produto = Long(la_Dado)

				//Quantidade de retirada
				la_Dado = lo_Excel.uo_Lendo_Dados(ll_Linha, "C")
				
				If Not IsNumber(String(la_Dado)) Then
					ll_Qtd_Ret = 0
				End If
				
				ll_Qtd_Ret = Long(la_Dado)
				
				If lb_Achou_Prd And lb_Achou_Fil Then
					
					If Not lo_Tratamento.of_Permite_Retirada_Perini( 'E', ll_Filial, ll_Produto, False, Ref ll_Tipo_Produto_Fiscal, Ref ls_ID_DEV_TRANS) Then
						ls_Divergencia += "Produto n$$HEX1$$e300$$ENDHEX$$o pode ser "+ IIF( ls_ID_DEV_TRANS="D", "devolvido", "transferido") + " para o Perini devido $$HEX1$$e000$$ENDHEX$$ regra fiscal. NCM: " + String(ll_Ncm) + ". |"
					End If
					
//					ls_ID_DEV_TRANS = 'D' //DEVOLU$$HEX2$$c700c300$$ENDHEX$$O
//				
//					If Not wf_Localiza_movimento(ll_Produto, ll_Filial) Then
//						ls_ID_DEV_TRANS = 'T'  //TRANSFERENCIA
//					End If
//					
//					//Verifica regras Devolucao / Transferencia
//					If Not wf_Permite_Retirada(ll_Ncm, ls_ID_DEV_TRANS, String(ldc_Tributacao_Icms), ls_Uf, Ref ll_Tipo_Produto_Fiscal) Then
//						ls_Divergencia += "Produto n$$HEX1$$e300$$ENDHEX$$o pode ser "+ IIF( ls_ID_DEV_TRANS="D", "devolvido", "transferido") + " para o Perini devido $$HEX1$$e000$$ENDHEX$$ regra fiscal. NCM: " + String(ll_Ncm) + ". |"
//					End If
				End If
				
				If lb_Achou_Prd Then
					If Not wf_Custo_Produto(ll_Produto, ll_Filial, Ref ldc_Custo) Then Return False
					
					If ldc_Custo = 0.00 Then
						ls_Divergencia += "O custo do produto deve ser maior que zero."
					End If
				End If
				
				If ib_corrigir_faturamento_sap Then
					ls_Divergencia = ""
				End If
							
				dw_2.Object.Cd_Filial						[ll_Linha] = ll_Filial
				dw_2.Object.Nm_Fantasia				[ll_Linha] = ls_Nome_Fantasia
				dw_2.Object.Cd_Produto					[ll_Linha] = ll_Produto
				dw_2.Object.De_Produto					[ll_Linha] = ls_De_Produto
				dw_2.Object.Qt_Retirada				[ll_Linha] = ll_Qtd_Ret
				dw_2.Object.Nr_Classificacao_Fiscal	[ll_Linha] = ll_Ncm
				dw_2.Object.Cd_Tributacao_Icms		[ll_Linha] = ldc_Tributacao_Icms
				dw_2.Object.Vl_Fator_Conversao		[ll_Linha] = ldc_Fator_Conversao
				dw_2.Object.De_Divergencia			[ll_Linha] = ls_Divergencia
				dw_2.Object.Vl_Custo					[ll_Linha] = ldc_Custo
				dw_2.Object.Cd_Tipo_Prd_Fiscal		[ll_Linha] = ll_Tipo_Produto_Fiscal
				dw_2.Object.Id_Dev_Transf				[ll_Linha] = ls_ID_DEV_TRANS
				dw_2.Object.Qt_Dimensao_Litros		[ll_Linha] = ldc_Dimensao_Litros
				dw_2.Object.qt_peso_kg					[ll_Linha] = ldc_Peso_Produto
												
				If ls_Divergencia <> "" Then
					dw_2.Object.Id_Selecionado[ll_Linha] = "N"
				Else
					dw_2.Object.Id_Selecionado[ll_Linha] = "S"
				End If
			
//				w_Aguarde.Title = "Importando registro " + String(ll_Linha) + " de " + String(ll_Linhas)
//				w_aguarde.uo_progress.of_setprogress(ll_Linha)
			Next
			
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existem dados na planilha.")
			Return False
		End If
	End If
	
Finally
	Close(w_Aguarde_1)
	dw_2.Sort()
	dw_2.GroupCalc()
	SetRedraw(True)
	SetPointer(Arrow!)
	If IsValid(lo_Excel) Then Destroy(lo_Excel)
	If IsValid(lo_Tratamento) Then Destroy(lo_Tratamento)
	
	dw_2.Event RowFocusChanged(1)
	dw_2.SetFocus()
End Try
	
Return True
end function

public function boolean wf_salva_retirada ();Boolean lb_Quebra_Retirada

Decimal ldc_Custo

DateTime ldh_Inicio
DateTime ldh_Termino
DateTime ldh_Vencimento

Long ll_Linha
Long ll_Produto
Long ll_Produto_Anterior
Long ll_Tipo_Produto_Fiscal
Long ll_Qtde
Long ll_Retirada
Long ll_Filial
Long ll_Filial_Prox
Long ll_Contador = 0
Long ll_Linhas
Long ll_Linha_Qtd
Long i

String ls_Erro
String ls_Nulo
String ls_Mensagem
String ls_Dados_Adicionais
String	ls_Id_Dev_Transf
String	ls_Id_Dev_Transf_Prox

Decimal ldc_Dimensao_Litros
Decimal ldc_Dimensao_Total = 0.00
Decimal ldc_Capacidade_Bacia
Decimal ldc_Peso_Produto
Decimal ldc_Peso_Total = 0.00
Decimal ldc_Capacidade_Peso_Bacia

str_ge350_retirada_produto st_nulo
str_ge350_lista_email st_email_nulo

str_ge350_lista_email st_email

dc_uo_ds_base lvds

dw_1.AcceptText()
dw_2.AcceptText()

If Not wf_Valida_Informacoes() Then Return False

Try
	Open(w_Aguarde)
	
	lvds = Create Dc_uo_ds_base
	lvds.of_ChangeDataObject("ds_ge350_retirada_via_planilha_prd")
	
	ldh_Inicio						= dw_1.Object.Dh_Inicio						[1]
	ldh_Termino					= dw_1.Object.Dh_Termino					[1]
	ls_Dados_Adicionais			= dw_1.Object.De_Dados_Adicionais		[1]
	ldh_Vencimento				= dw_1.Object.Dh_Vencimento_Minimo	[1]
	ldc_Capacidade_Bacia		= 32.00 //32 litros
	ldc_Capacidade_Peso_Bacia	= 12.00 //12.00 quilos
	
	SetNull(ls_Nulo)
	
	ll_Linhas =  dw_2.RowCount()
	
	w_aguarde.uo_progress.of_setmax(ll_Linhas)
	
	//***********Coloca os produtos em unidades em um DataWindow para distribuir por bacias******************
	//***********Quando tinha produto com quantidade grande n$$HEX1$$e300$$ENDHEX$$o distribuia a quantidade em bacias**************
		
	For ll_linha = 1 To ll_linhas
		w_Aguarde.Title = "Distribuindo Produtos '" + String(ll_Linha) + "' de '" + String(ll_Linhas) + "'"
		
		If dw_2.Object.Id_Selecionado[ll_Linha] = 'S' Then
			ll_Filial						= dw_2.Object.Cd_Filial					[ll_Linha]
			ll_Produto					= dw_2.Object.Cd_Produto				[ll_Linha]
			ll_Qtde						= dw_2.Object.Qt_Retirada				[ll_Linha]
			ldc_Custo			 		= dw_2.Object.Vl_Custo					[ll_Linha]
			ll_Tipo_Produto_Fiscal	= dw_2.Object.Cd_Tipo_Prd_Fiscal	[ll_Linha]
			ls_Id_Dev_Transf			= dw_2.Object.id_dev_transf			[ll_Linha]
			ldc_Dimensao_Litros		= dw_2.Object.qt_dimensao_litros		[ll_Linha]
			ldc_Peso_Produto			= dw_2.Object.qt_peso_kg				[ll_Linha]
			
			For ll_Linha_Qtd = 1 To ll_Qtde
				
				i = lvds.RowCount() + 1
				lvds.Object.Cd_Filial					[i] = ll_Filial
				lvds.Object.Cd_Produto				[i] = ll_Produto
				lvds.Object.Qt_Retirada				[i] = 1
				lvds.Object.Vl_Custo					[i] = ldc_Custo
				lvds.Object.Cd_Tipo_Prd_Fiscal		[i] = ll_Tipo_Produto_Fiscal
				lvds.Object.id_dev_transf			[i] = ls_Id_Dev_Transf
				lvds.Object.qt_dimensao_litros		[i] = ldc_Dimensao_Litros
				lvds.Object.qt_peso_kg				[i] = ldc_Peso_Produto
			Next
		End If
		w_aguarde.uo_progress.of_setprogress(ll_Linha)
	Next		
//****************************************************************************************
	
	ll_Linhas =  lvds.RowCount()
	
	w_aguarde.uo_progress.of_setmax(ll_Linhas)
	
	ll_Produto_Anterior = 0
	
	For ll_Linha = 1 To ll_Linhas
		
		w_Aguarde.Title = "Gravando Pedido dos Produtos '" + String(ll_Linha) + "' de '" + String(ll_Linhas) + "'"
		
		ll_Filial						= lvds.Object.Cd_Filial					[ll_Linha]
		ll_Produto					= lvds.Object.Cd_Produto				[ll_Linha]
		ll_Qtde						= lvds.Object.Qt_Retirada				[ll_Linha]
		ldc_Custo			 		= lvds.Object.Vl_Custo					[ll_Linha]
		ll_Tipo_Produto_Fiscal	= lvds.Object.Cd_Tipo_Prd_Fiscal		[ll_Linha]
		ls_Id_Dev_Transf			= lvds.Object.id_dev_transf				[ll_Linha]
		ldc_Dimensao_Litros		= lvds.Object.qt_dimensao_litros		[ll_Linha]
		ldc_Peso_Produto			= lvds.Object.qt_peso_kg				[ll_Linha]
		
		If ll_Linha > 1 Then
			ll_Produto_Anterior		= lvds.Object.Cd_Produto		[ll_Linha - 1]
		End If
		
		If (ll_Produto = ll_Produto_Anterior)  and (ll_Contador > 0) Then
			st.Qt_Solicitada			[ll_Contador] += ll_Qtde
			st.Qt_Aprovada			[ll_Contador] += ll_Qtde
		Else
			ll_Contador++
			//Se passou em todas as valida$$HEX2$$e700f500$$ENDHEX$$es, os valores s$$HEX1$$e300$$ENDHEX$$o atribu$$HEX1$$ed00$$ENDHEX$$dos na estrutura para depois salvar
			st.Cd_Filial				[ll_Contador] = ll_Filial
			st.Cd_Produto			[ll_Contador] = ll_Produto
			st.Qt_Solicitada			[ll_Contador] = ll_Qtde
			st.Qt_Aprovada			[ll_Contador] = ll_Qtde
			st.Vl_Custo_Medio		[ll_Contador] = ldc_Custo
			st.Cd_Tipo_Prd_Fiscal[ll_Contador] = ll_Tipo_Produto_Fiscal
			st.Id_Dev_Transf		[ll_Contador] = ls_Id_Dev_Transf
			st.De_Observacao		[ll_Contador] = ls_Nulo
		End If
		
		If (ll_Linha < ll_Linhas) Then 
			ll_Filial_Prox					= lvds.Object.Cd_Filial			[ll_Linha + 1]
			ls_Id_Dev_Transf_Prox	= lvds.Object.id_dev_transf		[ll_Linha + 1]
		End If
		
		ldc_Dimensao_Total	+= ldc_Dimensao_Litros
		ldc_Peso_Total			+=	 ldc_Peso_Produto
		
		lb_Quebra_Retirada = False
		
		If ib_corrigir_faturamento_sap Then
			If (	(ll_Filial <> ll_Filial_Prox) Or (ll_Linha = ll_Linhas )) and ll_Contador > 0 Then
				lb_Quebra_Retirada = True
				ls_Dados_Adicionais = 'CORRIGIR SALDO SAP V2'
			End If
		Else
			If (	(ll_Filial <> ll_Filial_Prox) Or &
				(ll_Linha = ll_Linhas ) Or &
				(ls_Id_Dev_Transf <> ls_Id_Dev_Transf_Prox) Or &
				(ldc_Dimensao_Total >= ldc_Capacidade_Bacia) Or &
				(ldc_Peso_Total >= ldc_Capacidade_Peso_Bacia)) and ll_Contador > 0 Then
				lb_Quebra_Retirada = True
			End If
		End If
							
		If  lb_Quebra_Retirada Then
							
			If Not wf_Numero_Retirada(ll_Filial, Ref ll_Retirada, Ref ls_Erro) Then 
				SqlCa.Of_RollBack()
				MessageBox("Erro", ls_Erro)
				Return False
			End If	
				
			Insert Into retirada_estoque(	cd_filial, 
													nr_retirada_estoque,
													id_tipo_retirada,
													id_situacao,
													dh_inclusao,
													nr_matricula_responsavel,
													de_observacao,
													dh_inicio,
													dh_termino,
													dh_aprovacao,
													nr_matricula_aprovacao,
													dh_vencimento_minimo,
													de_dados_adicionais)
									Values(	:ll_Filial, 
												:ll_Retirada,
												'E',
												'A',
												GetDate(),
												:gvo_Aplicacao.ivo_Seguranca.Nr_Matricula,
												:ls_Nulo,
												:ldh_Inicio,
												:ldh_Termino,
												GetDate(),
												:gvo_Aplicacao.ivo_Seguranca.Nr_Matricula,
												:ldh_Vencimento,
												:ls_Dados_Adicionais)
			Using SqlCa;
			
			If SqlCa.SqlCode = - 1 Then
				ls_Erro = SqlCa.SqlErrText
				SqlCa.Of_RollBack();
				MessageBox("Erro", "Erro ao gravar a retirada de estoque N$$HEX1$$ba00$$ENDHEX$$ '" + String(ll_Retirada) + "' para a filial '" + String(ll_Filial) + "'. " + ls_Erro, StopSign!)
				Return False
			End If
			
			If Not wf_Grava_Produto(ll_Retirada, Ref ls_Erro) Then
				SqlCa.Of_RollBack()
				MessageBox("Erro",  ls_Erro)
				Return False
			End If
			
			If not ib_corrigir_faturamento_sap Then
				gf_ge350_Dados_Email(Ref st_email, ll_Filial, ll_Retirada, ldh_Inicio, ldh_Termino, 'E', ldh_Vencimento)
			End IF
			
			//Limpa a vari$$HEX1$$e100$$ENDHEX$$vel para a pr$$HEX1$$f300$$ENDHEX$$xima filial
			st							= st_nulo
			ll_Contador				= 0
			ldc_Dimensao_Total	= 0.00
			ldc_Peso_Total			= 0.00
		End If
		
		w_aguarde.uo_progress.of_setprogress(ll_Linha)
	Next
	
	//Se tem diverg$$HEX1$$ea00$$ENDHEX$$ncia para salvar a planilha
	If Not wf_Salva_Lista_Divergentes(Ref ls_Mensagem, Ref ls_Erro) Then
		SqlCa.of_RollBack()
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Erro, StopSign!)
		Return False
	End If
	
	SqlCa.of_Commit();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Retirada realizada com sucesso." + ls_Mensagem)
	
	If Not ib_corrigir_faturamento_sap Then
		gf_ge350_Envia_Email(st_email, 'E', False)
	End If
	
	st_email = st_email_nulo
	
	dw_1.Event ue_Reset()
	dw_2.Event ue_Reset()
	dw_3.Event ue_Reset()
	
	dw_1.Event ue_AddRow()
	dw_3.Event ue_AddRow()
	
	dw_1.Object.Dh_Inicio		[1] = gvo_Parametro.of_Dh_Movimentacao()
	dw_1.Object.Dh_Termino	[1] = gvo_Parametro.of_Dh_Movimentacao()
	dw_1.SetFocus()

Finally	
	Destroy(lvds)
	Close(w_Aguarde)
	st = st_nulo
		
End Try
end function

public subroutine wf_set_somente_consulta ();dw_3.of_Set_Somente_Leitura(False)
end subroutine

public function boolean wf_localiza_movimento (long al_produto, long al_filial);Boolean lvb_Sucesso = False

Date lvdh_Inicio, lvdh_Termino

Try
	//Para n$$HEX1$$e300$$ENDHEX$$o pegar nota pendente do perini que ainda n$$HEX1$$e300$$ENDHEX$$o foi enviada ao sefaz.
	lvdh_Termino 		= RelativeDate( Date (gvo_Parametro.of_dh_movimentacao()), -1 ) 
	
	// $$HEX1$$da00$$ENDHEX$$ltimos 3 anos
	lvdh_Inicio			= RelativeDate(lvdh_Termino, - 1095)
	
	dc_uo_ds_base lvds
	lvds = Create Dc_uo_ds_base
	lvds.of_ChangeDataObject("ds_ge350_nota_fiscal_entrada")
	
	lvds.Reset()
	
	SetPointer(HourGlass!)
	
	lvds.of_AppendWhere("a.cd_filial_movimento = " + String(al_filial))
	lvds.of_AppendWhere("a.cd_produto = " + String(al_produto))
	lvds.of_AppendWhere("cd_filial_movimento = " + String(al_filial),2)
	lvds.of_AppendWhere("cd_produto = " + String(al_produto), 2)
	lvds.of_AppendWhere("dh_movimento between '" + String(lvdh_Inicio,"YYYYMMDD") + "' and '" + String(lvdh_Termino,"YYYYMMDD") + "'", 2)
	
	lvds.Retrieve()
	
	If lvds.RowCount() < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Retrieve da 'ds_ge350_nota_fiscal_entrada'.", StopSign!)
		Return False
	End If
	
	If lvds.RowCount() > 0 Then
		//Se localizou a nota de origem no CD a opera$$HEX2$$e700e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ DEVOLUCAO sen$$HEX1$$e300$$ENDHEX$$o TRANSFERENCIA
		lvb_Sucesso = True
	End If
	
	Return lvb_Sucesso
	
Finally
	If IsValid( lvds ) Then Destroy( lvds )
End Try
end function

public function boolean wf_permite_retirada (longlong al_ncm, string as_dev_transf, string as_situacao_tributaria, string as_uf, ref long al_tipo_produto_fiscal);String ls_Tipo_Pemissao , ls_Permissao_dev, ls_Permissao_Transf

Long ll_Retrieve

Try
	SetNull(al_tipo_produto_fiscal)
	
	dc_uo_ds_base lo_DS
	lo_DS = Create dc_uo_ds_base
	
	If Not lo_Ds.of_ChangeDataObject( "ds_ge350_tipo_permissao" ) Then
 		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no evento of_ChangeDataObject. Fun$$HEX2$$e700e300$$ENDHEX$$o: wf_permite_retirada(Long, String, String, ref long)", StopSign! )
		Return False	 
	End If

	ll_Retrieve = lo_Ds.Retrieve( al_NCM, as_UF )
	
	If  ll_Retrieve < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no retrieve. Fun$$HEX2$$e700e300$$ENDHEX$$o: wf_permite_retirada(Long, String, String, ref long)" , StopSign!)
		Return False	
	End If
			
	If ll_Retrieve > 0 Then	
		If as_dev_transf = 'D' Then
			ls_Tipo_Pemissao = lo_Ds.Object.id_permissao_devolucao		[ 1 ]  
		Else
			ls_Tipo_Pemissao =  lo_Ds.Object.id_permissao_transferencia	[ 1 ]  
		End If
		
		//Nenhum
		If ls_Tipo_Pemissao = 'N' Then
			Return False
		End If
		
		//Somente sem ST
		If ls_Tipo_Pemissao = 'I' AND as_situacao_tributaria = '1' Then 
			Return False	
		End If	
		
		al_tipo_produto_fiscal	= lo_Ds.Object.cd_tipo_produto_fiscal		[ 1 ]
	End If
	
	Return ( ll_Retrieve > 0 )
Finally
	If IsValid( lo_DS ) Then Destroy lo_DS
End Try
end function

public function boolean wf_localiza_filial (long al_filial, ref boolean ab_achou, ref string as_nome_fantasia, ref string as_uf);Select nm_fantasia, cd_uf
	Into :as_Nome_Fantasia, :as_Uf
From vw_filial
Where cd_filial =:al_Filial
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		ab_Achou = True
		
	Case 100
		
		ab_Achou = False
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar a filial. '" + String(al_Filial) + "'. " + SqlCa.SqlErrText, StopSign!)
		Return False
End Choose

Return True
end function

public function boolean wf_valida_informacoes ();Decimal ldc_Fator

Long ll_Find
Long ll_Linha
Long ll_Produto
Long ll_Filial
Long ll_Qtde

String ls_Selecionado

dw_1.AcceptText()
dw_2.AcceptText()

ll_Find = dw_2.Find("id_selecionado = 'S'", 1, dw_2.RowCount())

If ll_Find = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum registro foi selecionado.")
	Return False
End If

For ll_Linha = 1 To dw_2.RowCount()
	ls_Selecionado	= dw_2.Object.Id_Selecionado[ll_Linha]
	
	If ls_Selecionado = "S" Then
		ll_Produto	= dw_2.Object.Cd_Produto				[ll_Linha]
		ll_Filial		= dw_2.Object.Cd_Filial					[ll_Linha]
		ll_Qtde		= dw_2.Object.Qt_Retirada				[ll_Linha]
		ldc_Fator		= dw_2.Object.Vl_Fator_Conversao	[ll_Linha]
				
		If IsNull(ll_Qtde) Or ll_Qtde = 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A quantidade informada deve ser maior do que zero.")
			dw_2.Event ue_Pos(ll_Linha, "qt_retirada")
			Return False
		End If
		
		If Mod(ll_Qtde, ldc_Fator) <> 0 Then
			Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Quantidade informada para o produto '" + String(ll_Produto) + "' n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ m$$HEX1$$fa00$$ENDHEX$$ltipla do fator de convers$$HEX1$$e300$$ENDHEX$$o utilizado no Estoque Central.")
			dw_2.Event ue_Pos(ll_Linha, "qt_retirada")
			Return False
		End If
	End If
Next

Return True
end function

public function boolean wf_grava_produto (long al_retirada, ref string as_erro);Long ll_Linha
Long ll_Achou

String ls_Erro

Long ll_Filial

For ll_Linha = 1 To UpperBound(st.Cd_Filial[])
	
	ll_Filial = st.Cd_Filial[ll_Linha]
	
	Select Count(*)
		Into: ll_Achou
	From retirada_estoque_produto
	Where cd_filial = :st.Cd_Filial[ll_Linha]
		And nr_retirada_estoque = :al_Retirada
		And cd_produto = :st.Cd_Produto[ll_Linha]
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		as_Erro = "Erro ao consultar se o produto foi informado mais de uma vez. Fun$$HEX2$$e700e300$$ENDHEX$$o wf_grava_produto"
		Return False
	End If
	
	If ll_Achou > 0 Then
		as_Erro = "Produto '" + String(st.Cd_Produto[ll_Linha]) + "' foi informado mais de uma vez para a filial '" + String(ll_Filial) + "'."
		Return False
	End If
	
	Insert Into retirada_estoque_produto(
		cd_filial, 
		nr_retirada_estoque,
		cd_produto,
		qt_solicitada,
		qt_aprovada,
		vl_custo_medio,
		de_observacao,
		cd_tipo_produto_fiscal,
		id_devolucao_transferencia)
	Values(
		:st.Cd_Filial[ll_Linha],
		:al_Retirada,
		:st.Cd_Produto[ll_Linha],
		:st.Qt_Solicitada[ll_Linha],
		:st.Qt_Aprovada[ll_Linha],
		:st.Vl_Custo_Medio[ll_Linha],
		:st.De_Observacao[ll_Linha],
		:st.Cd_Tipo_Prd_Fiscal[ll_Linha],
		:st.Id_Dev_Transf[ll_Linha])
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		as_Erro = "Erro ao incluir o produto '" + String(st.Cd_Produto[ll_Linha]) + "' na retirada de estoque para a filial '" + String(st.Cd_Filial[ll_Linha]) + "'. " + SqlCa.SqlErrText
		Return False
	End If

Next

Return True
end function

public function boolean wf_numero_retirada (long al_filial, ref long al_retirada, ref string as_erro);string ls_msg

Declare sp_log Procedure for sp_parametro_prox_seq 'NR_RETIRADA_ESTOQUE'
USING SQLCA;

Execute sp_log;

If sqlca.sqlcode = -1 then 
	as_erro = 'Erro ao executar a procedure "sp_parametro_prox_seq" (wf_numero_retirada): ' + sqlca.sqlerrtext 
	return false
end if

Fetch sp_log Into :al_retirada, :ls_msg;

Close sp_log;

if al_retirada = -1 then
	as_erro = 'Erro ao executar a procedure "sp_log_exportacao_prox_seq" (wf_numero_retirada): ' + ls_msg
	return false
end if

return True
end function

public function boolean wf_salva_lista_divergentes (ref string as_mensagem, ref string as_erro);DateTime ldh_Inicio
DateTime ldh_Termino

Long ll_Linha
Long ll_Produto
Long ll_Filial
Long ll_Qt_Ret
Long ll_Find

String ls_Selecionado
String ls_Divergencia
String ls_Descricao
String ls_Nome_Fantasia
String ls_Arquivo
String ls_Diretorio

dw_2.AcceptText()
dw_4.AcceptText()

dw_4.Reset()

ll_Find = dw_2.Find("id_selecionado = 'N'", 1, dw_2.RowCount())

If ll_Find = 0 Then Return True //N$$HEX1$$e300$$ENDHEX$$o tem produto divergente

For ll_Linha = 1 To dw_2.RowCount()
	ls_Selecionado = dw_2.Object.Id_Selecionado[ll_Linha]
	
	If ls_Selecionado = "N" Then
		ll_Filial		= dw_2.Object.Cd_Filial		[ll_Linha]
		ll_Produto	= dw_2.Object.Cd_Produto	[ll_Linha]
	
		//Significa que $$HEX1$$e900$$ENDHEX$$ diverg$$HEX1$$ea00$$ENDHEX$$ncia fiscal
		If ll_Filial > 0 And ll_Produto > 0 Then
			ls_Divergencia		= dw_2.Object.De_Divergencia	[ll_Linha]
			ls_Nome_Fantasia	= dw_2.Object.Nm_Fantasia	[ll_Linha]
			ls_Descricao			= dw_2.Object.De_Produto		[ll_Linha]
			ll_Qt_Ret				= dw_2.Object.Qt_Retirada		[ll_Linha]
			
			//Verifica se a diverg$$HEX1$$ea00$$ENDHEX$$ncia est$$HEX1$$e100$$ENDHEX$$ preenchida, s$$HEX1$$f300$$ENDHEX$$ por garantia
			If Not IsNull(ls_Divergencia) And Trim(ls_Divergencia) <> "" Then
				dw_4.InsertRow(0)
				dw_4.Object.Cd_Filial				[dw_4.RowCount()] = ll_Filial
				dw_4.Object.Nm_Fantasia		[dw_4.RowCount()] = ls_Nome_Fantasia
				dw_4.Object.Cd_Produto			[dw_4.RowCount()] = ll_Produto
				dw_4.Object.De_Produto			[dw_4.RowCount()] = ls_Descricao
				dw_4.Object.Qt_Retirada		[dw_4.RowCount()] = ll_Qt_Ret
				dw_4.Object.De_Divergencia	[dw_4.RowCount()] = ls_Divergencia
			End If			
		End If
	End If
Next

//dw_4.Event ue_SaveAs()

ldh_Inicio 	= dw_1.Object.Dh_Inicio		[1]
ldh_Termino= dw_1.Object.Dh_Termino	[1]

ls_Diretorio = gvo_Aplicacao.of_GetFromINI("Diretorio", "Diretorio")

ls_Arquivo = ls_Diretorio + "divergencia_retirada_estoque_de_" + String(Date(ldh_Inicio), "ddmmyy") + &
				+ "_ate_" + String(Date(ldh_Termino), "ddmmyy") + "_gerado_as_" + String(Now(), "hhmm") + ".xls"

If dw_4.SaveAs(ls_Arquivo, Excel!, True) = 1 Then
	as_Mensagem = " ~r~rGerada a planilha de diverg$$HEX1$$ea00$$ENDHEX$$ncia: '" + ls_Arquivo + "'."
	Return True
Else
	as_Erro = "Erro ao salvar a planilha de produtos divergentes."
	Return False
End If
end function

public subroutine wf_dados_email (long al_filial, long al_retirada, datetime adh_inicio, datetime adh_termino);//String ls_Email
//String ls_Mensagem
//
//// Desenvolvimento
//If gvo_Aplicacao.ivs_DataSource = 'central' Then
//	ls_Email = String(al_Filial, "0000") + '@drogarialocal.com.br'
//Else
//	ls_Email = "anderson.lima@clamed.com.br"
//End If
//
//ls_Mensagem = "Retirada de Estoque N$$HEX1$$ba00$$ENDHEX$$ " + String(al_Retirada) + '<br><br>' + &
//+ "Para realizar a retirada de estoque siga atentamente os passos abaixo: " + '<br><br>' + &
//+ "1$$HEX1$$ba00$$ENDHEX$$) No sistema de Retaguarda de Loja acesse o menu [Relat$$HEX1$$f300$$ENDHEX$$rio $$HEX1$$1320$$ENDHEX$$> Estoque $$HEX1$$1320$$ENDHEX$$> Retirada para o Perini]. " + '<br>' + &
//+ "2$$HEX1$$ba00$$ENDHEX$$) No campo [Tipo Retirada] selecione a op$$HEX2$$e700e300$$ENDHEX$$o [Excesso] e no campo [Situa$$HEX2$$e700e300$$ENDHEX$$o] selecione a op$$HEX2$$e700e300$$ENDHEX$$o [Aprovada]." + '<br>' &
//+ "3$$HEX1$$ba00$$ENDHEX$$) Recupere os dados. O per$$HEX1$$ed00$$ENDHEX$$odo da retirada ser$$HEX1$$e100$$ENDHEX$$ " + String(Date(adh_Inicio)) + " $$HEX1$$e000$$ENDHEX$$ " + String(Date(adh_Termino)) + "." + '<br>' &
//+ "4$$HEX1$$ba00$$ENDHEX$$) Na aba [Detalhes] clique no bot$$HEX1$$e300$$ENDHEX$$o [Imprimir Lista de Produtos]. " + '<br>' + &
//+ "5$$HEX1$$ba00$$ENDHEX$$) Separe os produtos. " + '<br>' + &
//+ "6$$HEX1$$ba00$$ENDHEX$$) Acesse o menu [Manuten$$HEX2$$e700e300$$ENDHEX$$o $$HEX1$$1320$$ENDHEX$$> Notas Fiscais $$HEX1$$1320$$ENDHEX$$> Retirada de Estoque para o Perini]. " + '<br>' + &
//+ "7$$HEX1$$ba00$$ENDHEX$$) Localize a retirada atrav$$HEX1$$e900$$ENDHEX$$s do campo [N$$HEX1$$ba00$$ENDHEX$$ Retirada]. O campo [Situa$$HEX2$$e700e300$$ENDHEX$$o] estar$$HEX1$$e100$$ENDHEX$$ como [Aprovada]. " + '<br>' + &
//+ "8$$HEX1$$ba00$$ENDHEX$$) Adicionar os produtos conforme a lista impressa e salve a retirada." + '<br><br>' + String(al_Filial)
//
//st_email.De_Assunto[UpperBound(st_Email.De_Assunto[]) + 1] = "Retirada de Estoque de " + String(Date(adh_Inicio)) + " $$HEX1$$e000$$ENDHEX$$ " + String(Date(adh_Termino))
//st_email.De_Endereco[UpperBound(st_Email.De_Endereco[]) + 1] = ls_Email
//st_email.De_Mensagem[UpperBound(st_Email.De_Mensagem[]) + 1] = ls_Mensagem
end subroutine

public function boolean wf_custo_produto (long al_produto, long al_filial, ref decimal adc_custo);Select Coalesce(vl_custo_gerencial, 0.00)
	Into :adc_Custo
From vw_saldo_atual_produto
Where cd_filial = :al_Filial
	And cd_produto = :al_Produto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		//
		
	Case 100
		Select Coalesce(vl_custo_gerencial, 0.00)
			Into :adc_Custo
		From vw_saldo_atual_produto
		Where cd_filial = 534
			And cd_produto = :al_Produto
		Using SqlCa;
		
		Choose Case SqlCa.SqlCode
			Case 0
				//
				
			Case 100
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizado o custo do produto '" + String(al_Produto) + "' na filial '" + String(al_Filial) + "' e na Matriz.", Exclamation!)
				Return False
				
			Case -1
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao consultar o custo do produto na Matriz. " + SqlCa.SqlErrText, StopSign!)
				Return False
		End Choose
		
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao consultar o custo do produto na filial '" + String(al_Filial) + "'. " + SqlCa.SqlErrText, StopSign!)
		Return False
End Choose

Return True
end function

public function boolean wf_localiza_produto (long al_produto, ref boolean ab_achou, ref string as_de_produto, ref long al_ncm, ref decimal adc_tributacao_icms, ref decimal adc_fator_conversao, ref decimal adc_dimensao_litros, ref decimal adc_peso_produto);Decimal	ldc_Largura,&
			ldc_Altura,&
			ldc_Profundidade
			
			
Select		p.de_produto + ' : ' + p.de_apresentacao_estoque, 
			p.nr_classificacao_fiscal,
			p.cd_tributacao_icms, 
			p.vl_fator_conversao,
			coalesce(pc.qt_largura_cm_caixa_estoque, 0),
			coalesce(pc.qt_altura_cm_caixa_estoque, 0),
			coalesce(pc.qt_profund_cm_caixa_estoque, 0),
		Case when coalesce(qt_peso_kg_estoque, 0) > 0 then coalesce(qt_peso_kg_estoque, 0) else coalesce(qt_peso_grama, 0) end
Into	: as_De_Produto,
		:al_Ncm,
		:adc_Tributacao_Icms,
		:adc_Fator_Conversao,
		:ldc_Largura,
		:ldc_Altura,
		:ldc_Profundidade,
		:adc_Peso_Produto
From produto_geral p
inner join produto_central pc on pc.cd_produto = p.cd_produto
Where p.cd_produto = :al_Produto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		ab_Achou = True
		
		adc_Dimensao_Litros =  round((ldc_Largura * ldc_Altura * ldc_Profundidade) / 1000, 4)
		
	Case 100
		ab_Achou = False
		
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao consultar o produto '" + String(al_Produto) + ".'", StopSign!)
		Return False
End Choose

Return True
end function

on w_ge350_inclui_retirada_via_planilha.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.cb_importa=create cb_importa
this.gb_2=create gb_2
this.dw_3=create dw_3
this.dw_4=create dw_4
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.cb_importa
this.Control[iCurrent+3]=this.gb_2
this.Control[iCurrent+4]=this.dw_3
this.Control[iCurrent+5]=this.dw_4
this.Control[iCurrent+6]=this.gb_3
end on

on w_ge350_inclui_retirada_via_planilha.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.cb_importa)
destroy(this.gb_2)
destroy(this.dw_3)
destroy(this.dw_4)
destroy(this.gb_3)
end on

event ue_postopen;call super::ue_postopen;dw_1.Object.Dh_Inicio		[1] = gvo_Parametro.of_Dh_Movimentacao()
dw_1.Object.Dh_Termino	[1] = gvo_Parametro.of_Dh_Movimentacao()

ib_corrigir_faturamento_sap = False

If ib_corrigir_faturamento_sap Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Flag para gerar retirada para corrigir faturamento errado do SAP - ATIVO", Exclamation!)
End If
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge350_inclui_retirada_via_planilha
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge350_inclui_retirada_via_planilha
integer x = 37
integer width = 3680
integer height = 380
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge350_inclui_retirada_via_planilha
integer x = 69
integer y = 64
integer width = 3625
integer height = 288
string dataobject = "dw_ge350_selecao_planilha"
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge350_inclui_retirada_via_planilha
integer x = 3168
integer y = 2168
string text = "&Salvar"
end type

event cb_ok::clicked;call super::clicked;DateTime ldh_Inicio
DateTime ldh_Termino
DateTime ldh_Atual
DateTime ldh_Vencimento
String ls_Dados_Adicionais

dw_1.AcceptText()

ldh_Inicio				= dw_1.Object.Dh_Inicio						[1]
ldh_Termino			= dw_1.Object.Dh_Termino					[1]
ldh_Vencimento		= dw_1.Object.Dh_Vencimento_Minimo	[1]
ls_Dados_Adicionais 	= dw_1.Object.de_dados_adicionais		[1]

If dw_2.RowCount() = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existe nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o para a retirada de excesso.", Exclamation!)
	dw_1.SetFocus()
	Return -1
End If

If IsNull(ldh_Inicio) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio.", Exclamation!)
	dw_1.Event ue_Pos(1, "dh_inicio")
	Return -1
End If

If IsNull(ldh_Termino) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino.", Exclamation!)
	dw_1.Event ue_Pos(1, "dh_termino")
	Return -1
End If

If ldh_Inicio > ldh_Termino Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a data de t$$HEX1$$e900$$ENDHEX$$rmino.", Exclamation!)
	dw_1.Event ue_Pos(1, "dh_inicio")
	Return -1
End If

If ldh_Inicio < ldh_Atual Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio n$$HEX1$$e300$$ENDHEX$$o pode ser menor que a data corrente.", Exclamation!)
	dw_1.Event ue_Pos(1, "dh_inicio")
	Return -1
End If

If Not IsNull(ldh_Vencimento) Then
	If ldh_Vencimento <= gvo_Parametro.of_Dh_Movimentacao() Then
		 MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O vencimento m$$HEX1$$ed00$$ENDHEX$$nimo deve ser maior do que a data corrente.", Exclamation!)
		 dw_1.Event ue_Pos(1, "dh_vencimento_minimo")
		 Return -1
	End If
End If

If gf_retorna_so_caracteres_especiais(ls_Dados_Adicionais) <> "" or Pos(ls_Dados_Adicionais, '"') > 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o pode ser informado caracteres especiais.", Exclamation!)
	dw_1.Event ue_Pos(1, 'de_dados_adicionais')
	Return -1
End If

If Not wf_Salva_Retirada() Then Return -1
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge350_inclui_retirada_via_planilha
integer x = 3506
integer y = 2168
end type

type dw_2 from dc_uo_dw_base within w_ge350_inclui_retirada_via_planilha
integer x = 73
integer y = 448
integer width = 3717
integer height = 1456
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge350_lista_planilha"
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event constructor;call super::constructor;This.of_SetRowSelection()

//This.ivb_Ordena_Colunas = True

//This.of_SetRowSelection( "if(de_divergencia <> ~"~", if(getrow() = currentrow(), rgb(178,34,34), rgb(255,0,0)), if(getrow() = currentrow(), rgb(0,128,128), rgb(255, 255, 255)) )", "", False )
end event

event rowfocuschanged;call super::rowfocuschanged;dw_2.AcceptText()

If This.RowCount() > 0 Then
	If CurrentRow > 0 Then		
		dw_3.Object.De_Divergencia[1] = This.Object.De_Divergencia[CurrentRow]
	End If
End If
end event

type cb_importa from commandbutton within w_ge350_inclui_retirada_via_planilha
integer x = 37
integer y = 2168
integer width = 507
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Importar Planilha"
end type

event clicked;Integer li_Retorno

String ls_Arquivo
String ls_Nome
String ls_Nulo

If dw_2.RowCount() > 0 Then
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A planilha j$$HEX1$$e100$$ENDHEX$$ foi importada. Deseja desfazer e import$$HEX1$$e100$$ENDHEX$$-la novamente?", Question!, YesNo!, 2) = 2 Then
		Return -1
	Else
		dw_2.Event ue_Reset()
		dw_3.Event ue_Reset()
	End If
End If	

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Os dados devem estar da seguinte forma:" + &
					"~rColuna A = C$$HEX1$$f300$$ENDHEX$$digo da filial" + &
					"~rColuna B = C$$HEX1$$f300$$ENDHEX$$digo do produto" + &
					"~rColuna C = Quantidade retirada")

li_Retorno = GetFileOpenName("Seleciona o arquivo", + ls_Arquivo, ls_Nome, "XLSX", "Excel 2007 (*.XLSX),*.XLSX, Excel (*.XLS), *.XLS")

If li_Retorno = 1 Then 
	dw_1.Object.De_Arquivo[1] = Upper(ls_Arquivo)
	
	If Not wf_Le_Dados_Planilha() Then Return -1
Else
	SetNull(ls_Nulo)
	dw_1.Object.De_Arquivo[1] = ls_Nulo
End If
end event

type gb_2 from groupbox within w_ge350_inclui_retirada_via_planilha
integer x = 37
integer y = 392
integer width = 3781
integer height = 1536
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista"
borderstyle borderstyle = styleraised!
end type

type dw_3 from dc_uo_dw_base within w_ge350_inclui_retirada_via_planilha
integer x = 50
integer y = 1980
integer width = 3744
integer height = 140
integer taborder = 20
string dataobject = "dw_ge350_divergencia"
end type

type dw_4 from dc_uo_dw_base within w_ge350_inclui_retirada_via_planilha
boolean visible = false
integer x = 1929
integer y = 904
integer width = 1285
integer height = 652
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge350_produtos_divergentes"
end type

type gb_3 from groupbox within w_ge350_inclui_retirada_via_planilha
integer x = 37
integer y = 1920
integer width = 3781
integer height = 224
integer taborder = 30
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

