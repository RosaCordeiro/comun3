HA$PBExportHeader$w_ge101_analise_compra.srw
forward
global type w_ge101_analise_compra from dc_w_sheet
end type
type gb_3 from groupbox within w_ge101_analise_compra
end type
type gb_1 from groupbox within w_ge101_analise_compra
end type
type dw_1 from dc_uo_dw_base within w_ge101_analise_compra
end type
type dw_3 from dc_uo_dw_base within w_ge101_analise_compra
end type
type gb_4 from groupbox within w_ge101_analise_compra
end type
type dw_2 from dc_uo_dw_base within w_ge101_analise_compra
end type
type st_1 from statictext within w_ge101_analise_compra
end type
type st_2 from statictext within w_ge101_analise_compra
end type
type st_3 from statictext within w_ge101_analise_compra
end type
type st_4 from statictext within w_ge101_analise_compra
end type
type st_5 from statictext within w_ge101_analise_compra
end type
type st_6 from statictext within w_ge101_analise_compra
end type
type st_7 from statictext within w_ge101_analise_compra
end type
type gb_2 from groupbox within w_ge101_analise_compra
end type
end forward

global type w_ge101_analise_compra from dc_w_sheet
integer width = 4704
integer height = 2164
string title = "GE101 - An$$HEX1$$e100$$ENDHEX$$lise de Compra"
boolean controlmenu = false
long backcolor = 80269524
event ue_addrow ( )
event ue_deleterow ( )
event ue_consulta_estoque ( )
event ue_consulta_vendas ( )
event ue_inclui_produto_fornecedor ( )
event ue_consulta_pedido ( )
event ue_consulta_distribuidoras ( )
event ue_inclui_produto_via_excel ( )
event ue_excel_produtos_almoxarifado ( )
event ue_simula_preco_compra ( )
event ue_consulta_minimo_planograma ( )
gb_3 gb_3
gb_1 gb_1
dw_1 dw_1
dw_3 dw_3
gb_4 gb_4
dw_2 dw_2
st_1 st_1
st_2 st_2
st_3 st_3
st_4 st_4
st_5 st_5
st_6 st_6
st_7 st_7
gb_2 gb_2
end type
global w_ge101_analise_compra w_ge101_analise_compra

type variables
uo_fornecedor ivo_fornecedor

uo_condicao_pagamento ivo_condicao

uo_produto ivo_produto

uo_simula_pedido ivo_simula

uo_Filial ivo_Filial

String ivs_Matricula_Liberacao

date ivdt_parametro

dc_uo_ds_base ivds_consulta

dc_uo_ds_Base ids_PRD

long ivl_parametros[]

boolean lvb_atualizacao = false

decimal 	ivdc_PC_Juros_Diario_Pedido_Eletronico,&
			ivdc_pc_custo_adm_logistica
			
//Para controlar produtos Inativos ao alterar um pedido			
Boolean ivb_Verifica_Inativos = True, ivb_Bloqueia_Compra_Produto_Sem_Dimensao = False
end variables

forward prototypes
public function boolean wf_localiza_parametro ()
public subroutine wf_atualiza_totais ()
public function boolean wf_consulta_produto_pedido (long al_pedido)
public function boolean wf_proximo_pedido (ref long al_pedido)
public function boolean wf_exclui_produto_pedido (long al_pedido)
public function boolean wf_inclui_produto_fornecedor (string as_codigo)
public function boolean wf_saldo_estoque (long al_produto, ref long al_saldo, long al_filial)
public function boolean wf_saldo_filiais (long al_produto, ref long al_saldo)
public function boolean wf_venda_diaria (long al_produto, ref decimal adc_venda)
public function boolean wf_venda_diaria_filial (long al_filial, long al_produto, ref decimal adc_venda)
public function boolean wf_produto_distribuidora (long al_produto, long al_filial)
public subroutine wf_localiza_uf_filial ()
public function long wf_localiza_dias_pagto (long al_condicao_pagto)
public subroutine wf_simula_preco ()
public subroutine wf_executa_simulacao ()
public function boolean wf_localiza_simulacao (long al_pedido, ref long al_simulacao)
public function boolean wf_proxima_simulacao (ref long al_simulacao)
public function boolean wf_verifica_produto_simulacao (long al_simulacao, long al_produto, ref boolean ab_produto_cadastrado)
public function boolean wf_exclui_produto_simulacao (long al_simulacao)
public function boolean wf_inclui_simulacao (long al_pedido, long al_filial, string as_fornecedor, long al_condicao_pagamento, decimal adc_desconto, decimal adc_valor_total_pedido, decimal adc_valor_compra_distribuidora, decimal adc_valor_compra_fornecedor, ref long al_simulacao, decimal adc_taxa_logistica, string as_observacao)
public function boolean wf_libera_procedimento (string as_procedimento, ref string as_responsavel)
public function string wf_situacao_atual_pedido ()
public function boolean wf_valida_uf_filial_fornecedor ()
public function boolean wf_grava_simulacao_pedido (long al_pedido, string as_observacao)
public function boolean wf_grava_simulacao_nova (string as_observacao)
public function boolean wf_inclui_produtos_simulacao (long al_simulacao, long al_pedido, ref decimal adc_preco_final_fab, ref decimal adc_preco_final_dist)
public function boolean wf_existe_recarga_online ()
public function long wf_minimo_planograma (long al_produto, decimal adc_fator_conversao)
public function boolean wf_localiza_estoque_base (long al_filial, long al_produto, string as_grupo, ref long al_estoque_base)
public subroutine wf_atualiza_valores_simulacao (string as_ipi)
public function boolean wf_venda_diaria_almoxarifado (long al_produto, ref decimal adc_media_diaria)
public subroutine wf_melhor_preco_distribuidora (long al_linha, string as_icms_st)
public function boolean wf_inclui_produtos (string as_fornecedor, string as_divisoes, long al_produto, string as_condicao_pagto, long al_qtde_planilha, decimal adc_preco_planilha, decimal adc_desconto_planilha, long al_linha_atual_dw2)
public function boolean wf_verifica_fornecedor_agendamento ()
public function boolean wf_verifica_pbm (long pl_produto, long pl_linha)
public function boolean wf_verifica_produto_manipulado (long al_produto, long al_linha)
public function boolean wf_verifica_dermaclub (long pl_produto, long pl_linha)
end prototypes

event ue_addrow;dw_2.Event ue_AddRow()
end event

event ue_deleterow();dw_2.Event ue_DeleteRow()

ivm_Menu.mf_Confirmar(False)
end event

event ue_consulta_estoque();Long lvl_Linha, &
     lvl_Produto,&
	 lvl_Filial

String lvs_Descricao

dw_1.AcceptText()
dw_2.AcceptText()

lvl_Linha = dw_2.GetRow() 

If lvl_Linha > 0 Then
	lvl_Produto   = dw_2.Object.Cd_Produto[lvl_Linha]
	lvs_Descricao = dw_2.Object.De_Produto[lvl_Linha]
	
	If Not IsNull(lvl_Produto) and lvl_Produto > 0 Then	
		OpenWithParm(w_ge101_Consulta_Estoque_Produto, String(lvl_Filial, "0000") + String(lvl_Produto, "000000") + lvs_Descricao)
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para consultar o estoque.", Information!)
	End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para consultar o estoque.", Information!)
End If
end event

event ue_consulta_vendas();Long lvl_Linha, &
     lvl_Produto,&
	 lvl_Filial

String lvs_Descricao
String lvs_Grupo
	   
dw_1.AcceptText()

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	lvl_Produto   	= dw_2.Object.Cd_Produto	[lvl_Linha]
	lvs_Descricao 	= dw_2.Object.De_Produto	[lvl_Linha]
	lvs_Grupo		= dw_2.Object.Cd_Grupo	[lvl_Linha]
	
	If Not IsNull(lvl_Produto) and lvl_Produto > 0 Then
		If lvs_Grupo = '5' Then //Grupo Almoxarifado mostra as transferencias
			OpenWithParm(w_ge101_consulta_trans_almoxarifado, String(lvl_Filial, "0000") + String(lvl_Produto, "000000") + lvs_Descricao)
		Else
			OpenWithParm(w_ge101_Consulta_Venda_Produto, String(lvl_Filial, "0000") + String(lvl_Produto, "000000") + lvs_Descricao)
		End If
		
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para consultar as vendas.", Information!)
	End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para consultar as vendas.", Information!)
End If
end event

event ue_inclui_produto_fornecedor();String lvs_Fornecedor

Long lvl_Condicao

dw_1.AcceptText()

lvl_Condicao		= dw_1.Object.Cd_Condicao_Pagamento[1]

If IsNull(lvl_Condicao) or lvl_Condicao = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione a condi$$HEX2$$e700e300$$ENDHEX$$o de pagamento.", Information!)
	dw_1.Event ue_Pos(1, "de_condicao_pagamento")
	Return
End If

uo_Fornecedor lvo_Fornecedor
lvo_Fornecedor = Create uo_Fornecedor
			
lvo_Fornecedor.of_Localiza_Fornecedor("")

If lvo_Fornecedor.Localizado Then
	lvs_Fornecedor = lvo_Fornecedor.Nm_Razao_Social + " (" + lvo_Fornecedor.Cd_Fornecedor + ")"
	
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma inclus$$HEX1$$e300$$ENDHEX$$o dos produtos do fornecedor '" + lvs_Fornecedor + "' ?", Question!, YesNo!, 1) = 1 Then
		wf_Inclui_Produto_Fornecedor(lvo_Fornecedor.Cd_Fornecedor)
	End If
End If

Destroy(lvo_Fornecedor)






end event

event ue_consulta_pedido();Long lvl_Linha, &
     lvl_Produto,&
	 lvl_Filial

String lvs_Descricao
	   
dw_1.AcceptText()

lvl_Filial = 534

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	lvl_Produto   = dw_2.Object.Cd_Produto[lvl_Linha]
	lvs_Descricao = dw_2.Object.De_Produto[lvl_Linha]
	
	If Not IsNull(lvl_Produto) and lvl_Produto > 0 Then	
		OpenWithParm(w_ge101_Consulta_Pedido_Produto, String(lvl_Filial, "0000") + String(ivdt_Parametro, "dd/mm/yyyy") + String(lvl_Produto, "000000") + lvs_Descricao)
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para consultar o estoque.", Information!)
	End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para consultar o estoque.", Information!)
End If
end event

event ue_consulta_distribuidoras();Long lvl_Linha, &
     lvl_Produto

String lvs_Descricao

w_ge162_Cadastro_Produto_Distribuidora lvw

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	lvl_Produto   = dw_2.Object.Cd_Produto[lvl_Linha]
	lvs_Descricao = dw_2.Object.De_Produto[lvl_Linha]
	
	If Not IsNull(lvl_Produto) and lvl_Produto > 0 Then	
		//OpenSheetWithParm(lvw, String(lvl_Produto, "000000"), w_Frame, 0, Original!)
		OpenSheetWithParm(lvw, String(lvl_Produto, "000000" + "SC"), This, 0, Original! )
		
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para consultar as distribuidoras.", Information!)
	End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para consultar as distribuidoras.", Information!)
End If
end event

event ue_inclui_produto_via_excel();Boolean lvb_Sucesso = True

String lvs_Arquivo,&
	   lvs_ClassName,&
	   lvs_Tipo_Arquivo
	   
Long lvl_Linhas,&
	 lvl_Linha,&
	 lvl_Produto,&
	 lvl_Quantidade,&
	 lvl_Find,&
	 lvl_Insert
	 
Decimal{2} lvdc_Desconto,&
		   lvdc_Preco,&
		   lvdc_Nulo

Any lva_Dado

String ls_ICMS_ST

String ls_Nulo
										
SetNull(ls_Nulo)

SetNull(lvdc_Nulo)

Open(w_ge101_importa_produtos_excel)

lvs_Arquivo = Message.StringParm

If IsNull(lvs_Arquivo) or lvs_Arquivo = "" Then Return

// Tipo
// 1 -> SEM COMPLEMENTO (SEM PRE$$HEX1$$c700$$ENDHEX$$O E SEM DESCONTO)
// 2 -> COM PRE$$HEX1$$c700$$ENDHEX$$O
// 3 -> COM DESCONTO
// 4 -> COM PRE$$HEX1$$c700$$ENDHEX$$O + DESCONTO

lvs_Tipo_Arquivo 	= RightA(lvs_Arquivo, 1)

lvs_Arquivo 		= MidA(lvs_Arquivo, 1, LenA(lvs_Arquivo) - 1)

lvdc_Preco 			= lvdc_Nulo
lvdc_Desconto 		= lvdc_Nulo

dc_uo_excel lvo_Excel

lvo_Excel = Create dc_uo_excel

SetPointer(HourGlass!)

Open(w_Aguarde)

// Refer$$HEX1$$ea00$$ENDHEX$$ncia o arquivo 
If ( lvo_Excel.uo_Referencia_Objeto_Excel(lvs_Arquivo) ) Then
	// Coluna de Refer$$HEX1$$ea00$$ENDHEX$$ncia
	lvl_Linhas = lvo_Excel.uo_Verifica_Tamanho_Arquivo("A") 
	
	If lvl_Linhas > 0 Then
		w_Aguarde.uo_Progress.of_SetMax(lvl_Linhas)
		
		dw_2.SetRedraw(False)
				
		For lvl_Linha = 1 To lvl_Linhas
			
			// Produto
			lva_Dado 		= lvo_Excel.uo_Lendo_Dados(lvl_Linha, "A")
			//lvs_ClassName 	= ClassName(lva_Dado)
			
//			If lvs_ClassName <> "double" Then
//				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produto '" + String(lva_Dado) + "' inv$$HEX1$$e100$$ENDHEX$$lido na coluna 'A' da linha '" +&
//						   String(lvl_Linha) + "'.")
//				lvb_Sucesso = False
//				Exit
//			End If

			If Not IsNumber(String(lva_Dado)) Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produto '" + String(lva_Dado) + "' inv$$HEX1$$e100$$ENDHEX$$lido na coluna 'A' da linha '" +&
						   String(lvl_Linha) + "'.")
				lvb_Sucesso = False
				Exit
			End If
		
			lvl_Produto = Long(lva_Dado)
			
			// Quantidade
			lva_Dado 		= lvo_Excel.uo_Lendo_Dados(lvl_Linha, "B")
			lvs_ClassName 	= ClassName(lva_Dado)
			
			If lvs_ClassName <> "double" Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Quantidade '" + String(lva_Dado) + "' inv$$HEX1$$e100$$ENDHEX$$lida na coluna 'B' da linha '" +&
						   String(lvl_Linha) + "'.")
				lvb_Sucesso = False
				Exit
			End If
			
			lvl_Quantidade = Long(lva_Dado)
			
			If lvs_Tipo_Arquivo <> "1" Then
				
				If lvs_Tipo_Arquivo = "2" or lvs_Tipo_Arquivo = "4" Then
				
					// Pre$$HEX1$$e700$$ENDHEX$$o
					lva_Dado 		= lvo_Excel.uo_Lendo_Dados(lvl_Linha, "C")
					lvs_ClassName 	= ClassName(lva_Dado)
					
					If lvs_ClassName <> "double" Then
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Pre$$HEX1$$e700$$ENDHEX$$o '" + String(lva_Dado) + "' inv$$HEX1$$e100$$ENDHEX$$lido na coluna 'C' da linha '" +&
								   String(lvl_Linha) + "'.~r~rVerifique o formado do valor. Exemplo: 0,00 ou 0")
						lvb_Sucesso = False
						Exit
					End If
				
					lvdc_Preco = Dec(lva_Dado)
				End If
				
				If lvs_Tipo_Arquivo = "3" Then
								
					// Desconto
					lva_Dado 		= lvo_Excel.uo_Lendo_Dados(lvl_Linha, "C")
					lvs_ClassName 	= ClassName(lva_Dado)
					
					If lvs_ClassName <> "double" Then
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Desconto '" + String(lva_Dado) + "' inv$$HEX1$$e100$$ENDHEX$$lido na coluna 'C' da linha '" +&
								   String(lvl_Linha) + "'.~r~rVerifique o formado do valor. Exemplo: 0,00 ou 0")
						lvb_Sucesso = False
						Exit
					End If
				
					lvdc_Desconto = Dec(lva_Dado)
				End If
				
				If lvs_Tipo_Arquivo = "4" Then
					// Desconto
					lva_Dado 		= lvo_Excel.uo_Lendo_Dados(lvl_Linha, "D")
					lvs_ClassName 	= ClassName(lva_Dado)
					
					If lvs_ClassName <> "double" Then
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Desconto '" + String(lva_Dado) + "' inv$$HEX1$$e100$$ENDHEX$$lido na coluna 'D' da linha '" +&
								   String(lvl_Linha) + "'.~r~rVerifique o formado do valor. Exemplo: 0,00 ou 0")
						lvb_Sucesso = False
						Exit
					End If
				
					lvdc_Desconto = Dec(lva_Dado)
				End If
			End If
				
			// Verifica se o produto j$$HEX1$$e100$$ENDHEX$$ existe na lista
			lvl_Find = dw_2.Find("cd_produto = " + String(lvl_Produto), 1, dw_2.RowCount())
		
			If lvl_Find < 0 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na verifica$$HEX2$$e700e300$$ENDHEX$$o da exist$$HEX1$$ea00$$ENDHEX$$ncia do produto na datawindow.", StopSign!)
				lvb_Sucesso = False
				Exit			
			End If
					
			If lvl_Find = 0 Then
				// Inclui uma linha na datawindow
				lvl_Insert = dw_2.InsertRow(0)
				
				If lvl_Insert <= 0 Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na inclus$$HEX1$$e300$$ENDHEX$$o da linha na datawidow.", StopSign!)
					lvb_Sucesso = False
					Exit
				End If
			
				// Atualiza os dados do produto
				//If Not wf_Localiza_Produto(lvl_Produto, lvl_Insert, lvl_Quantidade, lvdc_Preco, lvdc_Desconto, ref ls_ICMS_ST) Then
				If Not wf_Inclui_Produtos(ls_Nulo, ls_Nulo, lvl_Produto, ls_Nulo, lvl_Quantidade, lvdc_Preco, lvdc_Desconto, lvl_Insert) Then
					lvb_Sucesso = False
					Exit
				End If
				
				// Verificar se realmente precisa 13/06, esta dentro da fun$$HEX2$$e700e300$$ENDHEX$$o
				//wf_melhor_preco_distribuidora(lvl_Insert, ls_ICMS_ST)
			End If
			
			If lvl_Find > 0 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto '" + String(lvl_Produto) + "' j$$HEX1$$e100$$ENDHEX$$ foi inclu$$HEX1$$ed00$$ENDHEX$$do.")
			End If
									
			w_Aguarde.uo_Progress.of_SetProgress(lvl_Linha)
		Next
		
		dw_2.Event RowFocusChanged(lvl_Insert)	
		
		dw_2.Sort()
		dw_2.GroupCalc()		
		dw_2.SetRedraw(True)
		
		wf_Atualiza_Totais()
		
//		wf_verifica_dimensoes_produtos(False)
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A planilha n$$HEX1$$e300$$ENDHEX$$o possui nenhuma linha.")
		lvb_Sucesso = False
	End If
End If

Close(w_Aguarde)

SetPointer(Arrow!)

Destroy(lvo_Excel)

end event

event ue_excel_produtos_almoxarifado();String ls_Grupo
String ls_Descricao

Long ll_Row
Long ll_Linhas
Long ll_Produto

ll_Linhas = dw_2.RowCount()

If ll_Linhas = 0 Then Return
If ll_Linhas = 1 And IsNull(dw_2.Object.cd_produto	[ 1 ]) Then Return

For ll_Row = 1 To ll_Linhas
	
	ls_Grupo 		= dw_2.Object.cd_grupo		[ ll_Row ]
	ls_Descricao 	= dw_2.Object.de_produto	[ ll_Row ]
	ll_Produto		= dw_2.Object.cd_produto	[ ll_Row ]
	
	If Not IsNull(ll_Produto) And ls_Grupo <> '5' Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto " + ls_Descricao + " n$$HEX1$$e300$$ENDHEX$$o faz parte do grupo ALMOXARIFADO.")
		Return		
	End IF

Next

dw_2.Event ue_Saveas()

end event

event ue_simula_preco_compra();Decimal lvdc_PC_IPI

dw_1.AcceptText()
dw_2.AcceptText()

st_ge101_simula_preco_compra lst

If IsNull(dw_1.Object.cd_fornecedor[1]) Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione o fornecedor.")
	Return
End If

If dw_2.GetRow() = 0 Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione o produto.")
	Return
End If

If IsNull(dw_2.Object.cd_produto[dw_2.GetRow()]) Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione o produto.")
	Return
End If

lst.cd_fornecedor		= dw_1.Object.cd_fornecedor		[1]
lst.nm_razao_social 	= dw_1.Object.nm_fornecedor		[1]
lst.cd_uf_fornecedor	= dw_1.Object.cd_uf_fornecedor	[1]

lst.cd_produto			= dw_2.Object.cd_produto[dw_2.GetRow()]
lst.de_produto			= dw_2.Object.de_produto[dw_2.GetRow()]

If dw_1.Object.id_ipi	[1] = "N" Then
	lvdc_PC_IPI  = 0.00
Else
	lvdc_PC_IPI	= dw_2.Object.pc_ipi[dw_2.GetRow()]
End If

lst.pc_ipi	= lvdc_PC_IPI

OpenWithParm(w_ge101_simula_preco_compra, lst)

end event

event ue_consulta_minimo_planograma();Long lvl_Produto

String lvs_Descricao

dw_2.AcceptText()

If dw_2.GetRow() > 0 Then
	lvl_Produto		= dw_2.Object.Cd_Produto[dw_2.GetRow()]
	lvs_Descricao	= dw_2.Object.De_Produto[dw_2.GetRow()]
	
	If Not IsNull(lvl_Produto) and lvl_Produto > 0 Then	
		OpenWithParm(w_ge101_estoque_minimo_plan_filial, String(lvl_Produto, "000000") + lvs_Descricao)
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para consultar o estoque m$$HEX1$$ed00$$ENDHEX$$nimo de planograma.", Information!)
	End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto para consultar o estoque m$$HEX1$$ed00$$ENDHEX$$nimo de planograma.", Information!)
End If
end event

public function boolean wf_localiza_parametro ();Boolean lvb_Sucesso = False

DateTime lvdh_Data

String lvs_Parametro

Select 	dh_movimentacao, 
			pc_juros_diario_ped_eletronico 
Into 	:lvdh_Data, 
		:ivdc_PC_Juros_Diario_Pedido_Eletronico
From parametro
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		ivdt_Parametro = Date(lvdh_Data)
		If IsNull(ivdc_PC_Juros_Diario_Pedido_Eletronico) Then ivdc_PC_Juros_Diario_Pedido_Eletronico = 0.00
		 lvb_Sucesso = True
	Case 100
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o dos Par$$HEX1$$e200$$ENDHEX$$metros")
End Choose

If  lvb_Sucesso  Then 
	
	lvb_Sucesso = False
	
	Select vl_parametro
	Into :lvs_Parametro
	From parametro_geral
	Where cd_parametro = 'PC_CUSTO_ADM_LOGISTICA'
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			
			If Not IsNull(lvs_Parametro) and lvs_Parametro <> '' Then
				If IsNumber(lvs_Parametro) Then
					ivdc_pc_custo_adm_logistica = Dec(lvs_Parametro)
					lvb_Sucesso = True
				Else
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Par$$HEX1$$e200$$ENDHEX$$metro 'PC_CUSTO_ADM_LOGISTICA' inv$$HEX1$$e100$$ENDHEX$$lido '" + String(ivdc_pc_custo_adm_logistica) + "'.")
				End If
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Par$$HEX1$$e200$$ENDHEX$$metro 'PC_CUSTO_ADM_LOGISTICA' inv$$HEX1$$e100$$ENDHEX$$lido.")	
			End If
					
		Case 100
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Par$$HEX1$$e200$$ENDHEX$$metro 'PC_CUSTO_ADM_LOGISTICA' n$$HEX1$$e300$$ENDHEX$$o foi localizado.")
		Case -1
			SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o dos Par$$HEX1$$e200$$ENDHEX$$metros")
	End Choose
	
End If

If  lvb_Sucesso  Then 
	
	lvb_Sucesso = False
	
	Select coalesce(vl_parametro, 'N')
	Into :lvs_Parametro
	From parametro_geral
	Where cd_parametro = 'ID_BLOQUEIA_COMPRA_PRD_SEM_DIMENSAO'
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			
			If lvs_Parametro <> 'S' and lvs_Parametro <> 'N' Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o",  "Par$$HEX1$$e200$$ENDHEX$$metro 'ID_BLOQUEIA_COMPRA_PRD_SEM_DIMENSAO' inv$$HEX1$$e100$$ENDHEX$$lido (S/N).")
			Else
				If lvs_Parametro = 'S' Then
					ivb_Bloqueia_Compra_Produto_Sem_Dimensao = True
				End If
				lvb_Sucesso = True
			End If
											
		Case 100
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Par$$HEX1$$e200$$ENDHEX$$metro 'ID_BLOQUEIA_COMPRA_PRD_SEM_DIMENSAO' n$$HEX1$$e300$$ENDHEX$$o foi localizado.")
		Case -1
			SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o dos Par$$HEX1$$e200$$ENDHEX$$metros")
	End Choose
		
End If

Return lvb_Sucesso
end function

public subroutine wf_atualiza_totais ();Decimal 	lvdc_Total_Bruto, &
        		lvdc_Total_Liquido, &
	    		lvdc_Desconto,&
			lvdc_Preco_Final,&
			lvdc_Preco_Dist
			
		  
Long 	lvl_Qtde_Produtos, &
     	lvl_Qtde_Pedida
		  
If dw_2.RowCount() > 0 Then
	dw_1.AcceptText()
	dw_2.AcceptText()
	
	lvdc_Desconto      	= dw_1.Object.Pc_Desconto            			[1]
	lvl_Qtde_Produtos 	= dw_2.Object.Qt_Produtos            			[1]
	lvl_Qtde_Pedida    	= dw_2.Object.Qt_Pedida_Total        			[1]
	lvdc_Total_Bruto   	= dw_2.Object.Vl_Total_Pedido_Bruto  		[1]
	lvdc_Total_Liquido	= dw_2.Object.Vl_Total_Pedido_Liquido		[1]
	lvdc_Preco_Final	= dw_2.Object.vl_preco_final_fab_total		[1]
	lvdc_Preco_Dist		= dw_2.Object.vl_preco_compra_dist_tot	[1]
	
	lvdc_Total_Liquido = Round(lvdc_Total_Liquido * ((100 - lvdc_Desconto) / 100), 2)
End If
end subroutine

public function boolean wf_consulta_produto_pedido (long al_pedido);Boolean lvb_Sucesso = True

Long lvl_Total, &
     lvl_Contador, &
     lvl_Linha, &
	  lvl_Produto
	  
String ls_Nulo
Long ll_Nulo
Decimal ldc_Nulo
						
SetNull(ls_Nulo)
SetNull(ll_Nulo)
SetNull(ldc_Nulo)

lvl_Total = ivds_Consulta.Retrieve(al_Pedido)

If lvl_Total <= 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produtos do pedido '" + String(al_Pedido) + "' n$$HEX1$$e300$$ENDHEX$$o localizados.", Information!)	
	Return False
End If

If Not wf_Valida_UF_Filial_Fornecedor() Then Return False

w_Aguarde.uo_Progress.of_SetMax(lvl_Total)

dw_2.SetRedraw(False)
dw_2.Reset()

For lvl_Contador = 1 To lvl_Total
	lvl_Produto = ivds_Consulta.Object.Cd_Produto[lvl_Contador]
	
	// Inclui uma linha na datawindow
	lvl_Linha = dw_2.InsertRow(0)
	
	If lvl_Linha <= 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na inclus$$HEX1$$e300$$ENDHEX$$o da linha na datawidow.", StopSign!)
		lvb_Sucesso = False
		Exit
	End If
	
	// Atualiza os dados do produto
	//If Not wf_Localiza_Produto(lvl_Produto, lvl_Linha) Then
	If Not wf_Inclui_Produtos(ls_Nulo, ls_Nulo, lvl_Produto,  ls_Nulo, ll_Nulo, ldc_Nulo, ldc_Nulo, lvl_Linha ) Then
		lvb_Sucesso = False
		Exit
	End If
	
	dw_2.Object.Qt_Pedida        	[lvl_Linha] = ivds_Consulta.Object.Qt_Pedida        	[lvl_Contador]
	dw_2.Object.Vl_Preco_Unitario	[lvl_Linha] = ivds_Consulta.Object.Vl_Preco_Unitario	[lvl_Contador]
	dw_2.Object.Pc_Desconto      	[lvl_Linha] = ivds_Consulta.Object.Pc_Desconto      	[lvl_Contador]
	
	dw_2.Event ue_Atualiza_Valores(lvl_Contador, 'X')
	
	w_Aguarde.uo_Progress.of_SetProgress(lvl_Contador)
Next

If lvb_Sucesso Then 
	dw_2.Event RowFocusChanged(lvl_Linha)	
	
	dw_2.Sort()
	dw_2.GroupCalc()		
	dw_2.SetRedraw(True)
	
	wf_Atualiza_Totais()
	
	ivm_Menu.mf_Excluir(True)
End If

Return lvb_Sucesso
end function

public function boolean wf_proximo_pedido (ref long al_pedido);Boolean lvb_Sucesso = True

uo_Parametro_Geral lvo_Parametro
lvo_Parametro = Create uo_Parametro_Geral

If Not lvo_Parametro.of_Proximo_Sequencial("NR_ULTIMO_PEDIDO_CENTRAL", ref al_Pedido) Then
	lvb_Sucesso = False
End If

Destroy(lvo_Parametro)

Return lvb_Sucesso
end function

public function boolean wf_exclui_produto_pedido (long al_pedido);Long 	lvl_Total, &
     	lvl_Linha, &
     	lvl_Produto,&
	  	lvl_Linhas,&
	  	lvl_Sequencial

String lvs_Excluir

lvl_Total = ivds_Consulta.RowCount()

For lvl_Linha = 1 To lvl_Total
	lvl_Produto = ivds_Consulta.Object.Cd_Produto[lvl_Linha]
	lvs_Excluir = ivds_Consulta.Object.Id_Excluir[lvl_Linha]

	If lvs_Excluir = "S" Then
		
		Delete From pedido_central_prd_msg_logist 
		Where nr_pedido  = :al_Pedido
		  and cd_produto = :lvl_Produto
		Using SqlCa;   
	
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgdbError("Exclus$$HEX1$$e300$$ENDHEX$$o da Mensagem Log$$HEX1$$ed00$$ENDHEX$$stica")
			Return False
		End If			
		
		Delete From pedido_central_produto 
		Where nr_pedido  = :al_Pedido
		  and cd_produto = :lvl_Produto
		Using SqlCa;   
	
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgdbError("Exclus$$HEX1$$e300$$ENDHEX$$o do Produto")
			Return False
		End If		
		
		lvl_Linhas = UpperBound(ivl_Parametros)
		 
		lvl_Linhas = lvl_Linhas + 1

		ivl_Parametros[lvl_Linhas] = lvl_Sequencial
				
	End If
Next

Return True
end function

public function boolean wf_inclui_produto_fornecedor (string as_codigo);Boolean lvb_Sucesso = True

Long 	lvl_Total, &
     	lvl_Contador, &
     	lvl_Linha, &
	  	lvl_Produto, &
	  	lvl_Find,&
	  	ll_Divisoes, &
		 ll_Aux,&
		 ll_Nulo

String ls_Divisoes_Selecionadas
String ls_Retorno
String ls_Cd_Cond_Pagto
String ls_Nulo

Decimal ldc_Nulo

SetNull(ls_Nulo)

Select count(*) 
Into :ll_Divisoes
From fornecedor_divisao
Where cd_fornecedor = :as_codigo
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Erro ao localizar as divis$$HEX1$$f500$$ENDHEX$$es do fornecedor '" + as_codigo + "'.")
	Return False
End If

If ll_Divisoes > 0 Then
	OpenWithParm(w_ge101_divisoes_fornecedor, as_codigo)
	
	ls_Retorno = Message.StringParm
	
	If IsNull(ls_Retorno) Then Return False
	
	//0044|1, 2
	ls_Cd_Cond_Pagto				= String(Long(MidA(ls_Retorno, 1, 4)))
	
	If ls_Cd_Cond_Pagto = '0000' Then
		ls_Cd_Cond_Pagto = ls_Nulo
	End If
	
	ls_Divisoes_Selecionadas = MidA(ls_Retorno, 6)
End If

SetNull(ll_Nulo)
SetNull(ldc_Nulo)

If Not wf_inclui_produtos(as_codigo, ls_Divisoes_Selecionadas, ll_Nulo, ls_Cd_Cond_Pagto, ll_Nulo, ldc_Nulo, ldc_Nulo, ll_Nulo ) Then Return False

lvl_Linha = dw_2.RowCount()

dw_2.Event RowFocusChanged(lvl_Linha)	
		
dw_2.Sort()
dw_2.GroupCalc()		
	
wf_Atualiza_Totais()
		
Return True
	  	  
//Select count(*) 
//Into :ll_Divisoes
//From fornecedor_divisao
//Where cd_fornecedor = :as_codigo
//Using SqlCa;
//
//If SqlCa.SqlCode = -1 Then
//	SqlCa.of_MsgDbError("Erro ao localizar as divis$$HEX1$$f500$$ENDHEX$$es do fornecedor '" + as_codigo + "'.")
//	Return False
//End If
//
//If ll_Divisoes > 0 Then
//	OpenWithParm(w_co040_divisoes_fornecedor, as_codigo)
//	
//	ls_Retorno = Message.StringParm
//	
//	If IsNull(ls_Retorno) Then Return False
//	
//	ls_Divisoes_Selecionadas	= MidA(ls_Retorno, 1, 2)
//	ls_Cd_Cond_Pagto				= MidA(ls_Retorno, 3)
//	
//	ll_Aux = Long(ls_Divisoes_Selecionadas)
//	ls_Divisoes_Selecionadas = String(ll_Aux)
//	
//End If
//
//dc_uo_ds_Base lvds
//lvds = Create dc_uo_ds_Base
//
//If Not lvds.of_ChangeDataObject("dw_co040_produto_fornecedor") Then
//	Destroy(lvds)
//	Return False
//End If
//
//SetPointer(HourGlass!)
//
//Open(w_Aguarde)
//w_Aguarde.Title = "Incluindo Produtos do Fornecedor '" + as_Codigo + "'..."
//
////INCLUIR A FORNECEDOR NO APPENDWHERE
//If Not IsNull(ls_Divisoes_Selecionadas) and ls_Divisoes_Selecionadas <> '' Then
//	lvds.of_AppendWhere("cd_produto in (select cd_produto from fornecedor_divisao_produto" + &
//													" where cd_fornecedor = '" + as_codigo + "' and nr_divisao in (" + ls_Divisoes_Selecionadas + "))")
//Else
//	lvds.of_AppendWhere("cd_fornecedor_usual = '" + as_codigo + "'")
//End If
//
//lvl_Total = lvds.Retrieve()
//
//If lvl_Total > 0 Then
//	
//	If Not IsNull(ls_Cd_Cond_Pagto) And ls_Cd_Cond_Pagto <> "" Then
//		If ivo_Condicao.of_Localiza(ls_Cd_Cond_Pagto, 100, ivdt_Parametro) Then		
//			dw_1.Object.Cd_Condicao_Pagamento[1] = ivo_Condicao.Cd_Condicao
//			dw_1.Object.De_Condicao_Pagamento[1] = ivo_Condicao.De_Condicao
//			wf_atualiza_valores_simulacao('X')
//		End If
//	End If
//	
//	w_Aguarde.uo_Progress.of_SetMax(lvl_Total)
//	
//	dw_2.SetRedraw(False)
//	
//	For lvl_Contador = 1 To lvl_Total
//		lvl_Produto = lvds.Object.Cd_Produto[lvl_Contador]
//
//		// Verifica se o produto j$$HEX1$$e100$$ENDHEX$$ existe na lista
//		lvl_Find = dw_2.Find("cd_produto = " + String(lvl_Produto), 1, dw_2.RowCount())
//		
//		If lvl_Find < 0 Then
//			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na verifica$$HEX2$$e700e300$$ENDHEX$$o da exist$$HEX1$$ea00$$ENDHEX$$ncia do produto na datawindow.", StopSign!)
//			lvb_Sucesso = False
//			Exit			
//		End If
//		
//		If lvl_Find = 0 Then
//			// Inclui uma linha na datawindow
//			lvl_Linha = dw_2.InsertRow(0)
//			
//			If lvl_Linha <= 0 Then
//				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na inclus$$HEX1$$e300$$ENDHEX$$o da linha na datawidow.", StopSign!)
//				lvb_Sucesso = False
//				Exit
//			End If
//			
//			// Atualiza os dados do produto
//			If Not wf_Localiza_Produto(lvl_Produto, lvl_Linha) Then
//				lvb_Sucesso = False
//				Exit
//			End If
//			
//			//wf_melhor_preco_distribuidora(lvl_Linha)
//		End If
//	
//		w_Aguarde.uo_Progress.of_SetProgress(lvl_Contador)
//	Next
//		
//	//If lvb_Sucesso Then 
//		dw_2.Event RowFocusChanged(lvl_Linha)	
//		
//		dw_2.Sort()
//		dw_2.GroupCalc()		
//		dw_2.SetRedraw(True)
//		
//		wf_Atualiza_Totais()
//		
//		wf_verifica_dimensoes_produtos(False)
//	//End If
//Else
//	If IsNull(ls_Divisoes_Selecionadas) Or ls_Divisoes_Selecionadas = "" Then
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existem produtos cadastrados para o fornecedor '" + as_Codigo + "'.", Information!)
//	Else
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existem produtos cadastrados para o fornecedor '" + as_Codigo + "' na divis$$HEX1$$e300$$ENDHEX$$o '" + ls_Divisoes_Selecionadas + "'.", Information!)
//	End If
//	
//	lvb_Sucesso = False
//End If
//
//Destroy(lvds)
//
//Close(w_Aguarde)
//SetPointer(Arrow!)
//
//Return lvb_Sucesso
end function

public function boolean wf_saldo_estoque (long al_produto, ref long al_saldo, long al_filial);Date lvdt_Saldo

lvdt_Saldo = Date("01/" + String(ivdt_Parametro, "mm/yyyy"))

Select qt_saldo_final Into :al_Saldo
From saldo_produto
Where cd_filial  = :al_Filial
  and dh_saldo   = :lvdt_Saldo
  and cd_produto = :al_Produto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Saldo no Estoque Central")
		Return False
End Choose

Return True
end function

public function boolean wf_saldo_filiais (long al_produto, ref long al_saldo);Date lvdt_Resumo

lvdt_Resumo = Date("01/" + String(ivdt_Parametro, "mm/yyyy"))

Select qt_saldo Into :al_Saldo
From resumo_produto
Where cd_produto = :al_Produto
  and dh_resumo  = :lvdt_Resumo
  and id_rede    = "CIA"
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Saldo nas Filiais")
		Return False
End Choose

Return True
end function

public function boolean wf_venda_diaria (long al_produto, ref decimal adc_venda);Long lvl_Venda

Date lvdt_Resumo

Integer lvi_Dia

lvi_Dia = Day(ivdt_Parametro)

lvdt_Resumo = Date("01/" + String(ivdt_Parametro, "mm/yyyy"))

Select sum(qt_venda - qt_devolucao_venda) Into :lvl_Venda
From resumo_produto
Where cd_produto = :al_Produto
  and dh_resumo >= dateadd(month, -2, :lvdt_Resumo)
  and id_rede    = 'CIA' 
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If lvl_Venda > 0 Then
			adc_Venda = Round(lvl_Venda / (60 + lvi_Dia - 1), 2)
		Else
			lvl_Venda = 0
		End If
		
	Case 100
		adc_Venda = 0
		
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o das Vendas do Produto")
		Return False
End Choose

Return True
end function

public function boolean wf_venda_diaria_filial (long al_filial, long al_produto, ref decimal adc_venda);Long lvl_Venda

Date lvdt_Resumo

Integer lvi_Dia

lvi_Dia = Day(ivdt_Parametro)

lvdt_Resumo = Date("01/" + String(ivdt_Parametro, "mm/yyyy"))

Select sum(qt_venda - qt_devolucao_venda) Into :lvl_Venda
From resumo_produto_filial
Where cd_produto = :al_Produto
  and dh_resumo >= dateadd(month, -2, :lvdt_Resumo)
  and cd_filial  = :al_Filial
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If lvl_Venda > 0 Then
			adc_Venda = Round(lvl_Venda / (60 + lvi_Dia - 1), 2)
		Else
			lvl_Venda = 0
		End If
		
	Case 100
		adc_Venda = 0
		
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o das Vendas do Produto")
		Return False
End Choose

If al_Filial = 753 Then
	Select sum(qt_venda - qt_devolucao_venda) Into :lvl_Venda
	From resumo_produto_filial
	Where cd_produto = :al_Produto
	  and dh_resumo >= dateadd(month, -2, :lvdt_Resumo)
	  and cd_filial  = 9
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			If lvl_Venda > 0 Then
				adc_Venda = adc_Venda + Round(lvl_Venda / (60 + lvi_Dia - 1), 2)
			Else
				lvl_Venda = 0
			End If
			
		Case 100
			adc_Venda = 0
			
		Case -1
			SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o das Vendas do Produto")
			Return False
	End Choose	
End If

If al_Filial = 798 Then
	Select sum(qt_venda - qt_devolucao_venda) Into :lvl_Venda
	From resumo_produto_filial
	Where cd_produto = :al_Produto
	  and dh_resumo >= dateadd(month, -2, :lvdt_Resumo)
	  and cd_filial  = 779
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			If lvl_Venda > 0 Then
				adc_Venda = adc_Venda + Round(lvl_Venda / (60 + lvi_Dia - 1), 2)
			Else
				lvl_Venda = 0
			End If
			
		Case 100
			adc_Venda = 0
			
		Case -1
			SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o das Vendas do Produto")
			Return False
	End Choose	
End If

If al_Filial = 797 Then
	Select sum(qt_venda - qt_devolucao_venda) Into :lvl_Venda
	From resumo_produto_filial
	Where cd_produto = :al_Produto
	  and dh_resumo >= dateadd(month, -2, :lvdt_Resumo)
	  and cd_filial  = 780
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			If lvl_Venda > 0 Then
				adc_Venda = adc_Venda + Round(lvl_Venda / (60 + lvi_Dia - 1), 2)
			Else
				lvl_Venda = 0
			End If
			
		Case 100
			adc_Venda = 0
			
		Case -1
			SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o das Vendas do Produto")
			Return False
	End Choose	
End If

If al_Filial = 799 Then
	Select sum(qt_venda - qt_devolucao_venda) Into :lvl_Venda
	From resumo_produto_filial
	Where cd_produto = :al_Produto
	  and dh_resumo >= dateadd(month, -2, :lvdt_Resumo)
	  and cd_filial  = 10
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			If lvl_Venda > 0 Then
				adc_Venda = adc_Venda + Round(lvl_Venda / (60 + lvi_Dia - 1), 2)
			Else
				lvl_Venda = 0
			End If
			
		Case 100
			adc_Venda = 0
			
		Case -1
			SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o das Vendas do Produto")
			Return False
	End Choose	
End If

Return True
end function

public function boolean wf_produto_distribuidora (long al_produto, long al_filial);Long lvl_Total

Select count(*) Into :lvl_Total
From distribuidora_produto d, fornecedor f
Where d.cd_produto = :al_Produto
  and d.cd_unidade_federacao in (Select c.cd_unidade_federacao
  							   From cidade c, filial f
							   Where f.cd_cidade = c.cd_cidade
							     and f.cd_filial = :al_Filial)
  and f.cd_fornecedor    = d.cd_distribuidora
  and f.id_distribuidora = 'S'
  and d.id_situacao      = 'A'
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Verifica$$HEX2$$e700e300$$ENDHEX$$o do Produto Distribuidora")
	Return False
End If

If IsNull(lvl_Total) Then lvl_Total = 0

If lvl_Total > 0 Then
	Return True
Else
	Return False
End If
end function

public subroutine wf_localiza_uf_filial ();dw_1.Object.cd_uf_filial[1] = "SC"
end subroutine

public function long wf_localiza_dias_pagto (long al_condicao_pagto);Long lvl_Dias_Vencimento

Select qt_dias_vencimento 
Into :lvl_Dias_Vencimento
From condicao_pagamento_parcela
Where cd_condicao = :al_Condicao_Pagto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Dias para pagamento da condi$$HEX2$$e700e300$$ENDHEX$$o '" + String(al_Condicao_Pagto) + "' pagamento n$$HEX1$$e300$$ENDHEX$$o foi localizada.")
		lvl_Dias_Vencimento = 0 
	Case -1
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o dos dias para pagamento")
		lvl_Dias_Vencimento = 0 
End Choose

Return lvl_Dias_Vencimento
		

end function

public subroutine wf_simula_preco ();Decimal 	lvdc_Preco_Unitario,&
			lvdc_Desconto,&
			lvdc_PC_ICMS_Venda,&
			lvdc_PC_ICMS_Compra,&
			lvdc_PC_Repasse,&
			lvdc_Repasse,&
			lvdc_ICMS_ST,&
			lvdc_PC_Juros_Compra,&
			lvdc_Valor_Compra,&
			lvdc_PC_IPI
			
Long 	lvl_Produto,&
		lvl_Condicao_Pgto,&
		lvl_Dias_Pgto
		
Long lvl_Linha
		
String	lvs_UF_Fornecedor,&
		lvs_UF_Filial,&
		lvs_Grupo,&
		lvs_ICMS_Normal,&
		ls_IPI
		
dw_1.AcceptText()
dw_2.AcceptText()
dw_3.AcceptText()

lvl_Linha = dw_2.GetRow()

//If dw_3.Object.id_distribuidora[1] = 'N$$HEX1$$c300$$ENDHEX$$O' Then
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A simula$$HEX2$$e700e300$$ENDHEX$$o de compra s$$HEX1$$f300$$ENDHEX$$ $$HEX1$$e900$$ENDHEX$$ permitada para produto relacionado com alguma distribuidora.", Exclamation!)
//	Return
//End If

If Isnull(dw_2.Object.vl_preco_compra_dist[lvl_Linha]) or dw_2.Object.vl_preco_compra_dist[lvl_Linha] = 0.00 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A simula$$HEX2$$e700e300$$ENDHEX$$o de compra s$$HEX1$$f300$$ENDHEX$$ $$HEX1$$e900$$ENDHEX$$ permitada para produto relacionado com alguma distribuidora.", Exclamation!)
	Return
End If

If IsNull(dw_2.Object.cd_produto[lvl_Linha]) Then
	Return
End If

lvdc_PC_IPI 	= dw_2.Object.pc_ipi	[lvl_Linha]

ls_IPI			= dw_1.Object.id_ipi	[1]

If ls_IPI = "N" Then
	lvdc_PC_IPI  = 0.00
End If

ivo_Simula.pc_tx_adm_logistica					= ivdc_pc_custo_adm_logistica
ivo_Simula.pc_juros_diario_Pedido_eletronico	= ivdc_PC_Juros_Diario_Pedido_Eletronico
ivo_Simula.cd_uf_fornecedor						= dw_1.Object.cd_uf_fornecedor			[1]
ivo_Simula.cd_fornecedor							= dw_1.Object.cd_fornecedor				[1]
ivo_Simula.cd_uf_filial								= dw_1.Object.cd_uf_filial					[1]
ivo_Simula.cd_condicao_pagamento					= dw_1.Object.cd_condicao_pagamento		[1]
ivo_Simula.pc_desconto_pedido						= dw_1.Object.pc_desconto					[1]

ivo_Simula.cd_Produto 					= dw_2.Object.cd_produto					[lvl_Linha]
ivo_Simula.de_Produto 					= dw_2.Object.de_produto					[lvl_Linha]
ivo_Simula.vl_Preco_Unitario 			= dw_2.Object.vl_preco_unitario			[lvl_Linha]
ivo_Simula.pc_Desconto					= dw_2.Object.pc_desconto					[lvl_Linha]
ivo_Simula.vl_icms_st					= dw_2.Object.vl_icms_st					[lvl_Linha]
ivo_Simula.pc_repasse					= dw_2.Object.pc_repasse					[lvl_Linha]
ivo_Simula.vl_repasse					= dw_2.Object.vl_repasse					[lvl_Linha]
ivo_Simula.cd_grupo						= dw_2.Object.cd_grupo						[lvl_Linha]
ivo_Simula.id_icms_normal				= dw_2.Object.id_icms_normal				[lvl_Linha]
ivo_Simula.pc_icms						= dw_2.Object.pc_icms						[lvl_Linha]
ivo_Simula.vl_preco_final_fab			= dw_2.Object.vl_preco_final_fab			[lvl_Linha]
ivo_Simula.cd_distribuidora			= dw_2.Object.cd_distribuidora			[lvl_Linha]
ivo_Simula.nm_razao_distribuidora	= dw_2.Object.nm_razao_distribuidora	[lvl_Linha]
ivo_Simula.vl_preco_dist				= dw_2.Object.vl_preco_dist				[lvl_Linha]
ivo_Simula.pc_desc_dist					= dw_2.Object.pc_desc_dist					[lvl_Linha]
ivo_Simula.vl_repasse_dist				= dw_2.Object.vl_repasse_dist				[lvl_Linha]
ivo_Simula.vl_icms_st_dist				= dw_2.Object.vl_icms_st_dist				[lvl_Linha]
ivo_Simula.vl_preco_compra_dist		= dw_2.Object.vl_preco_compra_dist		[lvl_Linha]
ivo_Simula.pc_ipi							= lvdc_PC_IPI
ivo_Simula.vl_ipi							= dw_2.Object.vl_ipi							[lvl_Linha]

ivo_Simula.cd_tributacao_icms			= dw_2.Object.cd_tributacao_icms			[lvl_Linha]
ivo_Simula.cd_tributacao_produto		= dw_2.Object.cd_tributacao_produto		[lvl_Linha]
ivo_Simula.id_caderno_abcfarma		= dw_2.Object.id_caderno_abcfarma		[lvl_Linha]
ivo_Simula.id_lei_generico				= dw_2.Object.id_lei_generico				[lvl_Linha]
ivo_Simula.id_situacao_pis_cofins	= dw_2.Object.id_situacao_pis_cofins	[lvl_Linha]

ivo_Simula.vl_juros_decrescimo		= dw_2.Object.vl_juros_decrescimo		[lvl_Linha]
ivo_Simula.vl_juros_decrescimo_dist	= dw_2.Object.vl_juros_decrescimo_dist	[lvl_Linha]
ivo_Simula.vl_acrescimo_logistica	= dw_2.Object.vl_acrescimo_logistica	[lvl_Linha]
ivo_Simula.vl_preco_venda_maximo		= dw_2.Object.vl_preco_venda_maximo		[lvl_Linha]
ivo_Simula.nr_classificacao_fiscal	= dw_2.Object.nr_classificacao_fiscal	[lvl_Linha]
ivo_Simula.pc_repasse_icms_dist		= dw_2.Object.pc_repasse_icms_dist		[lvl_Linha]


ivo_Simula.qt_embalagem_padrao_distrib = dw_2.Object.qt_embalagem_padrao_distrib	[lvl_Linha]
ivo_Simula.pc_midia_calculada				= dw_2.Object.pc_midia_calculada				[lvl_Linha]
ivo_Simula.pc_juros							= dw_2.Object.pc_juros							[lvl_Linha]
ivo_Simula.vl_juros							= dw_2.Object.vl_juros							[lvl_Linha]

OpenWithParm(w_ge101_simula_pedido, ivo_Simula)

ivo_simula = Message.PowerObjectParm

If ivo_simula.id_alteracao_pedido = 'S' Then
	dw_2.Object.vl_preco_unitario			[lvl_Linha] = ivo_Simula.vl_Preco_Unitario
	dw_2.Object.pc_desconto					[lvl_Linha] = ivo_Simula.pc_Desconto
	dw_2.Object.vl_icms_st					[lvl_Linha] = ivo_Simula.vl_icms_st
	dw_2.Object.vl_ipi						[lvl_Linha] = ivo_Simula.vl_ipi
	dw_2.Object.vl_repasse					[lvl_Linha] = ivo_Simula.vl_repasse
	dw_2.Object.vl_preco_final_fab		[lvl_Linha] = ivo_Simula.vl_preco_final_fab
	
	wf_atualiza_totais()
End If


end subroutine

public subroutine wf_executa_simulacao ();//w_co040_simula_pedido()
end subroutine

public function boolean wf_localiza_simulacao (long al_pedido, ref long al_simulacao);Long lvl_Nulo

SetNull(lvl_Nulo)

Select nr_simulacao
Into :al_Simulacao
From simulacao_pedido_central
Where nr_pedido =:al_Pedido
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
		al_Simulacao = lvl_Nulo
	Case -1 
		Sqlca.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da simula$$HEX2$$e700e300$$ENDHEX$$o do pedido")
		Return False
End Choose


end function

public function boolean wf_proxima_simulacao (ref long al_simulacao);//wf_proxima_simulacao
Long lvl_Proxima_Simulacao

Select max(nr_simulacao)
Into :lvl_Proxima_Simulacao
From simulacao_pedido_central
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
	Case -1
		SqlCa.of_MsgDBError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da $$HEX1$$fa00$$ENDHEX$$ltima simula$$HEX2$$e700e300$$ENDHEX$$o.")
		Return False
End Choose

If IsNull(lvl_Proxima_Simulacao) Then lvl_Proxima_Simulacao = 0

lvl_Proxima_Simulacao = lvl_Proxima_Simulacao + 1

al_Simulacao = lvl_Proxima_Simulacao

Return True


end function

public function boolean wf_verifica_produto_simulacao (long al_simulacao, long al_produto, ref boolean ab_produto_cadastrado);Integer lvi_Achou

Select count(cd_produto)
Into :lvi_Achou
From simulacao_pedido_central_prd
Where nr_simulacao 	=: al_Simulacao
	and cd_produto		=: al_Produto
Using SqlCA;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do produto na simula$$HEX2$$e700e300$$ENDHEX$$o")
	Return False
End If

If lvi_Achou = 1 Then
	ab_produto_cadastrado = True
Else
	ab_produto_cadastrado = False
End If

Return True

end function

public function boolean wf_exclui_produto_simulacao (long al_simulacao);Boolean lvb_Sucesso = True

Long 	lvl_Linha,&
		lvl_Linhas,&
		lvl_Produto,&
		lvl_Find

dc_uo_ds_base lvds

lvds = Create dc_uo_ds_base

If Not lvds.of_ChangeDataObject("ds_ge101_lista_produto_simulacao") Then
	Destroy(lvds)
	Return False
End If

lvds.Retrieve(al_Simulacao)

lvl_Linhas = lvds.RowCount()

For lvl_Linha = 1 To lvl_Linhas

	lvl_Produto = lvds.Object.cd_produto[lvl_Linha]
	
	lvl_Find = dw_2.Find("cd_produto = " + String(lvl_Produto), 1, dw_2.RowCount())
	
	If lvl_Find = 0 Then
		Delete From simulacao_pedido_central_prd
		Where nr_simulacao 	=:al_Simulacao
			and cd_produto		=:lvl_Produto
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgDbError("Exclus$$HEX1$$e300$$ENDHEX$$o do produto da simulacao.")
			lvb_Sucesso = False
			Exit
		End If
	Else
		If lvl_Find < 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o produto no pedido 'Find'.")
			lvb_Sucesso = False
			Exit
		End If
	End If
Next

Destroy(lvds)

Return True
end function

public function boolean wf_inclui_simulacao (long al_pedido, long al_filial, string as_fornecedor, long al_condicao_pagamento, decimal adc_desconto, decimal adc_valor_total_pedido, decimal adc_valor_compra_distribuidora, decimal adc_valor_compra_fornecedor, ref long al_simulacao, decimal adc_taxa_logistica, string as_observacao);Boolean lvb_Sucesso = False

If Not Isnull(al_Pedido) Then
	If Not wf_Localiza_Simulacao(al_Pedido, ref al_Simulacao) Then
		Return False
	Else
		// o sitema ir$$HEX1$$e100$$ENDHEX$$ excluir o produto foi excluido do pedido
		If Not wf_Exclui_Produto_Simulacao(al_Simulacao) Then
			Return False
		End If
	End If
End If

If IsNull(al_simulacao) or al_simulacao = 0 Then
	If Not wf_Proxima_Simulacao(al_Simulacao) Then
		Return False
	End If
	
	INSERT INTO simulacao_pedido_central  ( nr_simulacao,   
														  nr_pedido, 
														  cd_filial,
														  dh_simulacao,   
														  dh_emissao,
														  cd_fornecedor,   
														  cd_condicao_pagamento,   
														  pc_desconto,   
														  vl_pedido,   
														  vl_compra_distribuidora,   
														  vl_compra_fornecedor,   
														  nr_matricula_comprador,
														  nr_matricula_liberacao,
														  pc_taxa_logistica,
														  pc_juros_diario_ped_eletronico,
														  de_observacao)  
	  VALUES ( 	:al_Simulacao,   
						:al_Pedido,  
						:al_Filial,
						:ivdt_Parametro,   
						getdate(),
						:as_Fornecedor,   
						:al_Condicao_Pagamento,   
						:adc_Desconto ,   
						:adc_Valor_Total_Pedido,   
						:adc_Valor_Compra_Distribuidora,
						:adc_Valor_Compra_Fornecedor,
						:gvo_Aplicacao.ivo_Seguranca.Nr_Matricula,
						:ivs_matricula_liberacao,
						:adc_taxa_logistica,
						:ivdc_PC_Juros_Diario_Pedido_Eletronico,
						:as_observacao)
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgDbError("Inclus$$HEX1$$e300$$ENDHEX$$o da simula$$HEX2$$e700e300$$ENDHEX$$o de compra do produto.")
		Return False
	End If
		
Else
	// Atualizacao
	 UPDATE simulacao_pedido_central  
     SET 		cd_filial 						= :al_Filial,   
				dh_simulacao 				= :ivdt_Parametro,   
				dh_emissao 				= getdate(),   
				cd_fornecedor 				= :as_Fornecedor,   
				cd_condicao_pagamento = :al_Condicao_Pagamento,   
				pc_desconto 				= :adc_Desconto,   
				vl_pedido 					= :adc_valor_total_pedido,   
				vl_compra_distribuidora 	= :adc_valor_compra_distribuidora,   
				vl_compra_fornecedor 	= :adc_valor_compra_fornecedor,   
				nr_matricula_comprador = :gvo_Aplicacao.ivo_Seguranca.Nr_Matricula,   
				nr_matricula_liberacao 	= :ivs_matricula_liberacao,
				de_observacao				= :as_observacao
	Where nr_simulacao =: al_simulacao
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgDbError("Altera$$HEX2$$e700e300$$ENDHEX$$o da simula$$HEX2$$e700e300$$ENDHEX$$o de compra do produto.")
		Return False
	End If
		
End If

Return True
end function

public function boolean wf_libera_procedimento (string as_procedimento, ref string as_responsavel);If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento(as_Procedimento, ref as_responsavel) Then 
	Return False
End If

Return True
end function

public function string wf_situacao_atual_pedido ();String lvs_Situacao

dw_1.AcceptText()

lvs_Situacao = dw_1.Object.id_situacao_atual[1]

If IsNull(lvs_Situacao) Then lvs_Situacao = ""

Return lvs_Situacao
end function

public function boolean wf_valida_uf_filial_fornecedor ();String lvs_UF_Fornecedor, lvs_UF_Filial

dw_1.AcceptText()

lvs_UF_Fornecedor		= dw_1.Object.cd_uf_fornecedor			[1]
lvs_UF_Filial					= dw_1.Object.cd_uf_filial					[1]

If IsNull(lvs_UF_Fornecedor) or Trim(lvs_UF_Fornecedor) = "" Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A UF do fornecedor $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lida.", StopSign!)
	Return False
End If

If IsNull(lvs_UF_Filial) or Trim(lvs_UF_Filial) = "" Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A UF da filial $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lida.", StopSign!)
	Return False
End If

Return True
end function

public function boolean wf_grava_simulacao_pedido (long al_pedido, string as_observacao);Boolean lvb_Sucesso = False

String	lvs_Fornecedor, &
		lvs_Responsavel
		
Long	lvl_Condicao,&
		lvl_Filial,&
		lvl_Simulacao,&
		lvl_Find

Decimal 	lvdc_Desconto,&
			lvdc_Valor,&
			lvdc_Total_Pedido,&
			lvdc_Valor_Distribuidora,&
			lvdc_Valor_Fornecedor,&
			lvdc_Taxa_Logistica,&
			lvdc_Valor_Final_Fab,&
			lvdc_Valor_Final_Dist

dw_1.AcceptText()

lvl_Filial	          		= 534
lvs_Fornecedor      	= dw_1.Object.Cd_Fornecedor       		[1]
lvl_Condicao        		= dw_1.Object.Cd_Condicao_Pagamento[1]
lvdc_Desconto       	= dw_1.Object.Pc_Desconto          		[1]
lvdc_Taxa_Logistica	= ivdc_pc_custo_adm_logistica

lvdc_Valor_Final_Fab		= 0.00
lvdc_Valor_Final_Dist		= 0.00

If wf_inclui_simulacao(al_Pedido, lvl_Filial, lvs_Fornecedor, lvl_Condicao, lvdc_Desconto, lvdc_Total_Pedido, lvdc_Valor_Distribuidora, lvdc_Valor_Fornecedor, Ref lvl_Simulacao, lvdc_Taxa_Logistica, as_observacao) Then
	If wf_Inclui_Produtos_Simulacao(lvl_Simulacao, al_pedido, ref lvdc_Valor_Final_Fab, ref lvdc_Valor_Final_Dist ) Then

		  UPDATE simulacao_pedido_central  
		  SET	vl_compra_distribuidora = :lvdc_Valor_Final_Dist, vl_compra_fornecedor = :lvdc_Valor_Final_Fab, vl_pedido = p.vl_total_pedido
		  From simulacao_pedido_central s, pedido_central p
		  Where	s.nr_simulacao	= :lvl_Simulacao
		  	 and	p.nr_pedido		= s.nr_pedido
		  Using SqlCa;
		  
		  If SqlCa.SqlCode = -1 Then 
			SqlCa.of_MsgDbError("Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o da simula$$HEX2$$e700e300$$ENDHEX$$o do pedido '" + String(al_Pedido) +  "'")
		  Else
			lvb_Sucesso = True
		  End If
		  			
	End If
End If

If lvb_Sucesso Then
	SqlCa.of_Commit();
Else
	SqlCa.of_RollBack();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Houve erros na atualiza$$HEX2$$e700e300$$ENDHEX$$o da simula$$HEX2$$e700e300$$ENDHEX$$o do pedido '" + String(al_Pedido) + '.', StopSign!)	
End If

Return True
end function

public function boolean wf_grava_simulacao_nova (string as_observacao);Long lvl_Total_Pedidos, lvl_Linha, lvl_Pedido

// Lista os produtos que podem ser impressos
For lvl_Linha = 1 To lvl_Total_Pedidos
								
	// Grava a simula$$HEX2$$e700e300$$ENDHEX$$o do pedido
	wf_grava_simulacao_Pedido(lvl_Pedido, as_observacao)
			
Next

Return True
end function

public function boolean wf_inclui_produtos_simulacao (long al_simulacao, long al_pedido, ref decimal adc_preco_final_fab, ref decimal adc_preco_final_dist);Boolean 	lvb_Produto_Cadastrado,&
			lvb_Sucesso	 = True

Long 	lvl_Linhas,&
		lvl_Linha,&
		lvl_Produto,&
		lvl_Quantidade,&
		lvl_Dias_Pgto_Dist

Decimal lvdc_Preco_Unitario, lvdc_Desconto, lvdc_IPI, lvdc_ICMS_ST, lvdc_Repasse

Decimal lvdc_Preco_Dist, lvdc_Desc_Dist, lvdc_Repasse_Dist, lvdc_ICMS_ST_Dist, lvdc_Preco_Final_Fab, lvdc_Preco_Final_Dist

String lvs_Distribuidora
		
dw_2.AcceptText()

lvl_Linhas = dw_2.RowCount()

For lvl_Linha = 1 To lvl_Linhas
	
	lvl_Produto					= dw_2.Object.cd_produto					[lvl_Linha]
	lvdc_Preco_Unitario		= dw_2.Object.vl_preco_unitario			[lvl_Linha]
	lvdc_Desconto				= dw_2.Object.pc_desconto				[lvl_Linha]
	lvdc_IPI						= dw_2.Object.vl_ipi							[lvl_Linha]
	lvdc_ICMS_ST				= dw_2.Object.vl_icms_st					[lvl_Linha]
	lvdc_Repasse				= dw_2.Object.vl_repasse					[lvl_Linha]
	lvdc_Preco_Dist			= dw_2.Object.vl_preco_dist				[lvl_Linha]
	lvdc_Desc_Dist				= dw_2.Object.pc_desc_dist				[lvl_Linha]
	lvdc_Repasse_Dist		= dw_2.Object.vl_repasse_dist			[lvl_Linha]
	lvdc_ICMS_ST_Dist		= dw_2.Object.vl_icms_st_dist				[lvl_Linha]
	lvl_Dias_Pgto_Dist			= dw_2.Object.nr_dias_pgto_dist			[lvl_Linha]
	lvs_Distribuidora			= dw_2.Object.cd_distribuidora			[lvl_Linha]
	lvdc_Preco_Final_Fab		= dw_2.Object.vl_preco_final_fab		[lvl_Linha]
	lvdc_Preco_Final_Dist		= dw_2.Object.vl_preco_compra_dist	[lvl_Linha]
	
	Select qt_pedida
	Into :lvl_Quantidade
	From pedido_central_produto
	Where	nr_pedido 	= :al_pedido
	    and	cd_produto	= :lvl_Produto
	Using SqlCa;
	
	If Sqlca.SqlCode = -1 Then
		Sqlca.of_MsgDbError("Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o da quantidade pedida do produto")
		lvb_Sucesso = False
		Exit
	End If
	
	If SqlCa.SqlCode = 100 Then
		lvl_Quantidade = 0
	End If
	
	If IsNull(lvl_Quantidade) Then lvl_Quantidade = 0
	
	// S$$HEX1$$f300$$ENDHEX$$ vai somar se o produto estiver relacionado com a distribuidora, por$$HEX1$$e900$$ENDHEX$$m vai gravar na simula$$HEX2$$e700e300$$ENDHEX$$o.
	If Not Isnull(lvs_Distribuidora) Then
		adc_preco_final_fab	= adc_preco_final_fab +  round(lvdc_Preco_Final_Fab * lvl_Quantidade, 2)
		adc_preco_final_dist	= adc_preco_final_dist +  round(lvdc_Preco_Final_Dist * lvl_Quantidade, 2)
	End If
			
	If IsNull(lvl_Dias_Pgto_Dist) Then lvl_Dias_Pgto_Dist = 0
	
	// S$$HEX1$$f300$$ENDHEX$$ vai incluir se o produto estiver relacionado com algum distribuidora
	//If Isnull(lvs_Distribuidora) Then 
	//	Continue
	//End If
	
	If wf_Verifica_Produto_Simulacao(al_Simulacao, lvl_Produto, ref lvb_Produto_Cadastrado) Then
		
		If lvb_Produto_Cadastrado Then
			
			  UPDATE simulacao_pedido_central_prd  
			  SET 	qt_pedida 				= :lvl_Quantidade,   
					vl_preco_unitario 		= :lvdc_Preco_Unitario,
					pc_desconto 			= :lvdc_Desconto,
					vl_ipi 						= :lvdc_IPI,   
					vl_repasse 				= :lvdc_Repasse,   
					vl_icms_st 				= :lvdc_ICMS_ST,   
					cd_distribuidora 		= :lvs_Distribuidora,   
					vl_preco_dist 			= :lvdc_Preco_Dist,   
					pc_desconto_dist 		= :lvdc_Desc_Dist,
					vl_repasse_dist 		= :lvdc_Repasse_Dist,  
					vl_icms_st_dist 		= :lvdc_ICMS_ST_Dist,     
					nr_dias_pagto_dist	= :lvl_Dias_Pgto_Dist,
					vl_preco_final_fab		= :lvdc_Preco_Final_Fab,
					vl_preco_final_dist	= :lvdc_Preco_Final_Dist
			Where nr_simulacao 	= :al_Simulacao
				and cd_produto		= :lvl_Produto
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				Sqlca.of_MsgDbError("Altera$$HEX2$$e700e300$$ENDHEX$$o do produto da simula$$HEX2$$e700e300$$ENDHEX$$o")
				lvb_Sucesso = False
				Exit
			End If
									
		Else
			 INSERT INTO simulacao_pedido_central_prd ( nr_simulacao,   
																		cd_produto,   
																		qt_pedida,   
																		vl_preco_unitario,   
																		pc_desconto,   
																		vl_ipi,   
																		vl_repasse,   
																		cd_distribuidora,
																		vl_icms_st,   
																		vl_preco_dist,   
																		pc_desconto_dist,   
																		vl_repasse_dist,   
																		vl_icms_st_dist,   
																		nr_dias_pagto_dist,
																		vl_preco_final_fab,
																		vl_preco_final_dist)  
  			VALUES (	:al_Simulacao,   
							:lvl_Produto,   
							:lvl_Quantidade,   
							:lvdc_Preco_Unitario,   
							:lvdc_Desconto,   
							:lvdc_IPI	,   
							:lvdc_Repasse,   
							:lvs_Distribuidora,
							:lvdc_ICMS_ST,   
							:lvdc_Preco_Dist,   
							:lvdc_Desc_Dist,   
							:lvdc_Repasse_Dist,   
							:lvdc_ICMS_ST_Dist,   
							:lvl_Dias_Pgto_Dist,
							:lvdc_Preco_Final_Fab,
							:lvdc_Preco_Final_Dist) 
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				Sqlca.of_MsgDbError("Inclus$$HEX1$$e300$$ENDHEX$$o do produto da simula$$HEX2$$e700e300$$ENDHEX$$o")
				lvb_Sucesso = False
				Exit
			End If
		End If
	Else
		lvb_Sucesso = False
		Exit
	End If	
		
Next

// Exclui os produtos com quantidade zerada
//Delete From simulacao_pedido_central_prd
//Where nr_simulacao	= :al_Simulacao
//   and qt_pedida 		= 0 
//Using SqlCa;
//
//If SqlCa.SqlCode = -1 Then
//	SqlCa.of_MsgDbError("Erro ao excluir os produtos com quantidade zerada.")
//	Return False
//End If

//Exclui os produtos que n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e300$$ENDHEX$$o mais no pedido 
Delete From simulacao_pedido_central_prd
Where nr_simulacao = :al_Simulacao
  and	not exists (select * from pedido_central_produto
						 where nr_pedido = :al_pedido
							and cd_produto = simulacao_pedido_central_prd.cd_produto)
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Erro ao excluir os produtos com quantidade zerada.")
	Return False
End If

Return lvb_Sucesso
end function

public function boolean wf_existe_recarga_online ();Integer li_Produtos, li_Produto_Normal

// Verifica se existe produto RECARGA ONLINE 
li_Produtos = dw_2.GetItemNumber(dw_2.RowCount(), "qt_recarga_online_total")

// Verifica se existe produtos normais
li_Produto_Normal = dw_2.GetItemNumber(dw_2.RowCount(), "qt_prd_normal_total")

If li_Produtos > 0 Then
	// Se existir produtos normais e de recarga online o sistema
	// vai fazer todo o processo, que $$HEX1$$e900$$ENDHEX$$ pedir a aprova$$HEX2$$e700e300$$ENDHEX$$o de pedido
	If li_Produto_Normal > 0 Then
		Return False
	Else
		Return True
	End If
Else
	Return False
End If


end function

public function long wf_minimo_planograma (long al_produto, decimal adc_fator_conversao);Long ll_Minimo

//Select coalesce(sum(qt_estoque_minimo), 0)
//Into :ll_Minimo
//From promocao_sos_estoque_minimo m
//Where m.cd_promocao_sos in (select p.cd_promocao_sos from promocao_sos p, parametro r
//										where p.id_tipo_promocao = 'P'
//										  and p.dh_inicio <= r.dh_movimentacao 
//										  and (p.dh_termino is null or p.dh_termino >= r.dh_movimentacao))
//  and m.cd_produto = :al_Produto
//Using SqlCa;

Select coalesce(sum(qt_estoque_minimo), 0)
Into :ll_Minimo
From vw_promocao_estoque_minimo m
Where m.id_tipo_promocao = 'P'
  and m.cd_produto = :al_Produto
Using SqlCa;

Choose Case SqlCa.SqlCode 
	Case -1
		SqlCa.of_MsgDbError("Erro ao localizar o m$$HEX1$$ed00$$ENDHEX$$nimo de planograma")
		Return 0
	Case 0
	Case 100
		Return 0
End Choose

ll_Minimo = Long(round(ll_Minimo / adc_fator_conversao, 0))

Return ll_Minimo


end function

public function boolean wf_localiza_estoque_base (long al_filial, long al_produto, string as_grupo, ref long al_estoque_base);//Somente filial diferente de 534 e produtos que n$$HEX1$$e300$$ENDHEX$$o s$$HEX1$$e300$$ENDHEX$$o do almoxarifado.

If al_Filial = 534 And as_Grupo <> '5' Then
	select qt_estoque_base
		into :al_Estoque_Base
	from resumo_estoque_base_filiais r	
		where r.cd_produto = :al_Produto
	Using SqlCa;
	
Else
	Select qt_estoque_base
	Into :al_Estoque_Base
	From resumo_reposicao_estoque 
	Where cd_filial  	= :al_Filial
	  and cd_produto 	= :al_Produto
	Using SqlCa;
End If

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

public subroutine wf_atualiza_valores_simulacao (string as_ipi);Long lvl_Linha

dw_2.AcceptText()

If dw_2.RowCount() > 0 Then
	
	Open(w_Aguarde)	
		
	w_Aguarde.Title = "Simulando a compra dos produtos ..." 
	
	w_Aguarde.uo_Progress.of_SetMax(dw_2.RowCount())
	
	For lvl_Linha = 1 To dw_2.RowCount()
		
		If Not IsNull(dw_2.Object.cd_produto[lvl_Linha]) Then
			dw_2.Event ue_Atualiza_Valores(lvl_Linha, as_ipi)
		End If
						
		w_Aguarde.uo_Progress.of_SetProgress(lvl_Linha)
	Next
	
	Close(w_Aguarde)
	
End If

end subroutine

public function boolean wf_venda_diaria_almoxarifado (long al_produto, ref decimal adc_media_diaria);Long ll_Transferencia
Long ll_Ajuste_E
Long ll_Ajuste_S
Long ll_Transferencia_Almox

//verificar as transfer$$HEX1$$ea00$$ENDHEX$$ncias do produto nos $$HEX1$$fa00$$ENDHEX$$ltimos 90 dias

select COALESCE(sum(qt_faturada) , 0 )
	Into :ll_Transferencia
from	nf_almoxarifado p  
inner join item_nf_almoxarifado pp 
		on pp.nr_nf = p.nr_nf 
inner join parametro x
		on x.id_parametro = '1' 
where p.dh_cancelamento	is null 
	and p.dh_movimentacao_caixa >= dateadd(day, -91, x.dh_movimentacao)
	and pp.cd_produto = :al_produto
Using SqlCa;
  
If SqlCa.SqlCode = -1 Then
	SqlCa.of_msgDBError("Erro ao localizar a qt transferida do produto " + String(al_produto) + ". " + SqlCa.SQLErrText)
	Return False
End If

//and p.dh_movimentacao_caixa between dateadd(day, -91, x.dh_movimentacao) and dateadd(day, -1, x.dh_movimentacao )

select COALESCE(sum(qt_transferida) , 0 )
	Into :ll_Transferencia_Almox
from	nf_transferencia p  
inner join item_nf_transferencia pp 
		on pp.cd_filial_origem = p.cd_filial_origem
		and pp.nr_nf = p.nr_nf 
		and pp.de_especie = p.de_especie
		and pp.de_serie	= p.de_serie
inner join parametro x
		on x.id_parametro = '1' 
where p.cd_filial_origem = 534
	and p.dh_movimentacao_caixa >= dateadd(day, -91, x.dh_movimentacao)
	and p.id_almoxarifado = 'S'
    and p.dh_cancelamento	is null 
	and pp.cd_produto = :al_produto
Using SqlCa;
  
If SqlCa.SqlCode = -1 Then
	SqlCa.of_msgDBError("Erro ao localizar a qt transferida do produto " + String(al_produto) + ". " + SqlCa.SQLErrText)
	Return False
End If

//and p.dh_movimentacao_caixa between dateadd(day, -91, x.dh_movimentacao) and dateadd(day, -1, x.dh_movimentacao )

ll_Transferencia = ll_Transferencia + ll_Transferencia_Almox
 
//Verificar se houve ajustes de estoques realizados no mesmo per$$HEX1$$ed00$$ENDHEX$$odo que esta sendo verificado as transfer$$HEX1$$ea00$$ENDHEX$$ncias;

select COALESCE( qt_entrada , 0 ), COALESCE( qt_saida , 0 )
	Into :ll_Ajuste_E, :ll_Ajuste_S
From (select Sum(a.qt_ajuste) as qt_entrada
			from ajuste_estoque a, parametro x 
		 Where x.id_parametro = '1' 
			 and a.dh_movimentacao_caixa between dateadd(day, -91, x.dh_movimentacao) and dateadd(day, -1, x.dh_movimentacao )  
			 and a.id_entrada_saida = 'E'
			 and a.cd_produto = :al_produto
			 and a.cd_filial_ajuste = x.cd_filial_matriz ) as entrada,

		 (select Sum(b.qt_ajuste) as qt_saida
			from ajuste_estoque b, parametro x 
		 Where x.id_parametro = '1' 
			 and b.dh_movimentacao_caixa between dateadd(day, -91, x.dh_movimentacao) and dateadd(day, -1, x.dh_movimentacao )  
			 and b.id_entrada_saida = 'S'
			 and b.cd_produto = :al_produto
			 and b.cd_filial_ajuste = x.cd_filial_matriz ) as saida
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_msgDBError("Erro ao localizar os ajustes de estoque do produto " + String(al_produto) + ". " + SqlCa.SQLErrText)
	Return False
End If

//Se o resultado da conta qt_ajuste_saida - qt_ajuste_entrada for maior que zero, este valor ter$$HEX1$$e100$$ENDHEX$$ que ser somado na quantidade transferida;
If (ll_Ajuste_S - ll_Ajuste_E) > 0 Then ll_Transferencia = ll_Transferencia + (ll_Ajuste_S - ll_Ajuste_E)

//4 - M$$HEX1$$e900$$ENDHEX$$dia di$$HEX1$$e100$$ENDHEX$$ria ser$$HEX1$$e100$$ENDHEX$$ o (qt_transferida + resultado da conta do item 3) / 90;
adc_media_diaria = Round(ll_Transferencia / 90, 2)

Return True
end function

public subroutine wf_melhor_preco_distribuidora (long al_linha, string as_icms_st);Long lvl_Produto, ll_Dias,ll_Qt_Embalagem_padrao

Decimal ldc_Preco, ldc_PC_Desc, ldc_PC_ICMS, ldc_PC_Red, ldc_PC_Rep, ldc_ST, ldc_Repasse, ldc_Compra, ldc_Juros_Dec,ldc_Pc_Midia,ldc_Pc_Juros

String ls_Distribuidora, ls_Razao

dw_2.AcceptText()

lvl_Produto = dw_2.Object.cd_produto[al_Linha]

select	top 1 cd_distribuidora,
			nm_fantasia, 
		 	vl_preco_atual, 
		 	pc_desconto_atual,
		 	pc_icms,
			pc_reducao_icms,
			pc_repasse_icms,
			vl_icms_st,
			nr_dias_pagamento,
		 	vl_repasse ,    
			vl_melhor_compra,
			vl_juros_decrescimo_dist,
			qt_embalagem_padrao_distrib,
			pc_midia_calculada,
			pc_juros
Into :ls_Distribuidora, :ls_Razao, :ldc_Preco, :ldc_PC_Desc, :ldc_PC_ICMS, :ldc_PC_Red, :ldc_PC_Rep, :ldc_ST, :ll_Dias, :ldc_Repasse, :ldc_Compra, :ldc_Juros_Dec,:ll_Qt_Embalagem_padrao,:ldc_Pc_Midia,:ldc_Pc_Juros
from vw_preco_distribuidora
where cd_produto = :lvl_Produto
	and cd_filial = 13
order by vl_melhor_compra asc
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		
		dw_2.Object.cd_distribuidora				[al_Linha] = ls_Distribuidora
		dw_2.Object.nm_razao_distribuidora		[al_Linha] = ls_Razao
		dw_2.Object.vl_preco_dist					[al_Linha] = ldc_Preco
		dw_2.Object.pc_desc_dist					[al_Linha] = ldc_PC_Desc
		dw_2.Object.vl_repasse_dist				[al_Linha] = ldc_Repasse
		dw_2.Object.vl_icms_st_dist				[al_Linha] = ldc_ST
		dw_2.Object.nr_dias_pgto_dist				[al_Linha] = ll_Dias
		dw_2.Object.vl_juros_decrescimo_dist	[al_Linha] = ldc_Juros_Dec
		dw_2.Object.vl_preco_compra_dist			[al_Linha] = ldc_Compra
		dw_2.Object.qt_embalagem_padrao_distrib[al_Linha] = ll_Qt_Embalagem_padrao
		dw_2.Object.pc_midia_calculada			[al_Linha] = ldc_Pc_Midia
		dw_2.Object.pc_juros							[al_Linha] = ldc_Pc_Juros
		
	Case 100
		
		dw_2.Object.vl_preco_dist					[al_Linha] = 0.00
		dw_2.Object.pc_desc_dist					[al_Linha] = 0.00
		dw_2.Object.vl_repasse_dist				[al_Linha] = 0.00
		dw_2.Object.vl_icms_st_dist				[al_Linha] = 0.00
		dw_2.Object.vl_preco_compra_dist			[al_Linha] = 0.00
		dw_2.Object.nr_dias_pgto_dist				[al_Linha] = 0.00
		dw_2.Object.vl_juros_decrescimo_dist	[al_Linha] = 0.00	
		dw_2.Object.qt_embalagem_padrao_distrib[al_Linha] = 0
		dw_2.Object.pc_midia_calculada			[al_Linha] = 0.00
		dw_2.Object.pc_juros							[al_Linha] = 0.00
		
	Case -1
		SqlCa.of_MsgDbError("Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o da melhor compra")
End Choose


//
//Return 

//dc_uo_ds_base lvds
//
//lvds = Create dc_uo_ds_base
//
//If Not lvds.of_ChangeDataObject("dw_co040_lista_distribuidora")  Then
//	Return
//End If
//
//lvl_Produto = dw_2.Object.cd_produto[al_Linha]
//
//lvds.Retrieve(lvl_Produto)
//
//If lvds.Rowcount() > 0 Then
//	lvs_Distribuidora = lvds.Object.cd_distribuidora[1]
//	
//	dw_2.Object.cd_distribuidora			[al_Linha] = lvds.Object.cd_distribuidora				[1]
//	dw_2.Object.nm_razao_distribuidora	[al_Linha] = lvds.Object.nm_razao_distribuidora	[1]
//	dw_2.Object.vl_preco_dist				[al_Linha] = lvds.Object.vl_preco_atual				[1]
//	dw_2.Object.pc_desc_dist				[al_Linha] = lvds.Object.pc_desconto_atual			[1]
//	dw_2.Object.vl_repasse_dist			[al_Linha] = lvds.Object.vl_repasse					[1]
//	dw_2.Object.vl_icms_st_dist			[al_Linha] = lvds.Object.vl_icms_st					[1]
//	//dw_2.Object.vl_preco_compra_dist	[al_Linha] = lvds.Object.vl_preco_compra			[1] - lvds.Object.vl_juros	[1]
//	dw_2.Object.nr_dias_pgto_dist			[al_Linha] = lvds.Object.nr_dias_pagamento		[1]
//	dw_2.Object.vl_juros_decrescimo_dist[al_Linha] = lvds.Object.vl_juros						[1]
//	
//	dw_2.Object.vl_preco_compra_dist	[al_Linha] = lvds.Object.vl_compra					[1]
//	//
//	
//Else
//	dw_2.Object.vl_preco_dist				[al_Linha] =	0.00
//	dw_2.Object.pc_desc_dist				[al_Linha] = 0.00
//	dw_2.Object.vl_repasse_dist			[al_Linha] = 0.00
//	dw_2.Object.vl_icms_st_dist			[al_Linha] = 0.00
//	dw_2.Object.vl_preco_compra_dist	[al_Linha] = 0.00
//	dw_2.Object.nr_dias_pgto_dist			[al_Linha] = 0.00
//	dw_2.Object.vl_juros_decrescimo_dist[al_Linha] = 0.00
//End If
//
//Destroy(lvds)




end subroutine

public function boolean wf_inclui_produtos (string as_fornecedor, string as_divisoes, long al_produto, string as_condicao_pagto, long al_qtde_planilha, decimal adc_preco_planilha, decimal adc_desconto_planilha, long al_linha_atual_dw2);DateTime ldh_Inicio

Decimal lvdc_Venda_Diaria, ldc_Fat_Conv, lvdc_Preco, lvdc_Desconto

Long ll_Total, ll_Produto, ll_Find, ll_Contador, ll_Linha, ll_Filial, ll_Saldo_Estoque, lvl_Venda_Mensal, lvl_Estoque_Base, lvl_Dias_Estoque, lvl_Qtde_Sugerida, lvl_Dias_Suprimento

Long lvl_Saldo_Filiais, lvl_Qtde_Pedida, ll_Qtde_Distrib, ll_Saldo_Trans = 0, ll_Dias, ll_Dias_Ec_Rede

String ls_Distribuidora, lvs_Grupo, ls_Situacao, ls_Descricao, lvs_Grupo_Psico, ls_Resgate_Clube

try
	dw_1.AcceptText()
	
	// S$$HEX1$$f300$$ENDHEX$$ ir$$HEX1$$e100$$ENDHEX$$ abrir se for uma atualiza$$HEX2$$e700e300$$ENDHEX$$o de fornecedor
	If IsNull(al_produto) or al_produto = 0 Then
		Open(w_Aguarde_1)
		dw_2.SetRedraw(False)
	End If
	
	SetPointer(HourGlass!)
	
	ll_Filial					= 534
	
	If Not wf_Valida_UF_Filial_Fornecedor() Then Return False
	
	ids_PRD.of_restoresqloriginal()
	
	If Not IsNull(as_fornecedor) Then
		w_Aguarde_1.Title = "Incluindo Produtos do Fornecedor '" + as_fornecedor + "'..."
		
		//INCLUIR A FORNECEDOR NO APPENDWHERE
		If Not IsNull(as_divisoes) and as_divisoes <> '' Then
			ids_PRD.of_appendwhere("g.cd_produto in (select cd_produto from fornecedor_divisao_produto" + &
											" where cd_fornecedor = '" + as_fornecedor + "' and nr_divisao in (" + as_divisoes + "))")
		Else
			ids_PRD.of_appendwhere("g.cd_fornecedor_usual = '" + as_fornecedor + "'")
		End If
		
		ids_PRD.of_appendwhere("g.id_situacao = 'A'")
	Else
		If Not IsNull(al_produto) Then
			//w_Aguarde_1.Title = "Incluindo informa$$HEX2$$e700f500$$ENDHEX$$es do produto '" + String(ll_Produto) + "'..."
			ids_PRD.of_appendwhere("g.cd_produto = " + String(al_Produto))
		Else
			Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nennhum par$$HEX1$$e200$$ENDHEX$$metro foi informado para a localiza$$HEX2$$e700e300$$ENDHEX$$o do produto PRODUTO/FORNECEDOR/DIVIS$$HEX1$$c300$$ENDHEX$$O.", StopSign!)
			Return False
		End If
	End If

	ll_Total = ids_PRD.Retrieve(ll_Filial)

	If ll_Total > 0 Then
		
		If Not IsNull(as_condicao_pagto) And as_condicao_pagto <> "" Then
			If ivo_Condicao.of_Localiza(as_condicao_pagto, 100, ivdt_Parametro) Then		
				dw_1.Object.Cd_Condicao_Pagamento[1] = ivo_Condicao.Cd_Condicao
				dw_1.Object.De_Condicao_Pagamento[1] = ivo_Condicao.De_Condicao
				wf_atualiza_valores_simulacao('X')
			End If
		End If
	
		If IsNull(al_produto) or al_produto = 0 Then
			w_Aguarde_1.uo_Progress.of_SetMax(ll_Total)
		End If
			
		For ll_Contador = 1 To ll_Total
			
			lvdc_Venda_Diaria = 0.00
			ll_Saldo_Estoque	= 0
			lvl_Saldo_Filiais	= 0
			
			ll_Produto 			= ids_PRD.Object.Cd_Produto					[ll_Contador]
			ldc_Fat_Conv 		= ids_PRD.Object.vl_fator_conversao			[ll_Contador]
			lvs_Grupo			= ids_PRD.Object.cd_grupo						[ll_Contador]
			ls_Situacao			= ids_PRD.Object.id_situacao					[ll_Contador]
			ls_Descricao			= ids_PRD.Object.de_produto					[ll_Contador]
			lvs_Grupo_Psico	= ids_PRD.Object.cd_grupo_psico				[ll_Contador]
			lvdc_Preco 			= ids_PRD.Object.vl_preco_reposicao			[ll_Contador]
			lvdc_Desconto 		= ids_PRD.Object.pc_desconto_fornecedor	[ll_Contador]
						
			// Verifica se o produto j$$HEX1$$e100$$ENDHEX$$ existe na lista
			ll_Find = dw_2.Find("cd_produto = " + String(ll_Produto), 1, dw_2.RowCount())
			
			If ll_Find < 0 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na verifica$$HEX2$$e700e300$$ENDHEX$$o da exist$$HEX1$$ea00$$ENDHEX$$ncia do produto na datawindow.", StopSign!)
				Return False
			End If
			
			If ll_Find = 0 Then
				// Se a fun$$HEX2$$e700e300$$ENDHEX$$o for chamada no evento ue_key da dw_2
				If Not IsNull(al_linha_atual_dw2) and al_linha_atual_dw2 > 0 Then
					ll_Linha = al_linha_atual_dw2
				Else
					// Inclui uma linha na datawindow
					ll_Linha = dw_2.InsertRow(0)
				
					If ll_Linha <= 0 Then
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na inclus$$HEX1$$e300$$ENDHEX$$o da linha na datawidow.", StopSign!)
						Return False
					End If
				End If
								
				// Se for informado o pre$$HEX1$$e700$$ENDHEX$$o na planilha n$$HEX1$$e300$$ENDHEX$$o utiliza o pre$$HEX1$$e700$$ENDHEX$$o de reposi$$HEX2$$e700e300$$ENDHEX$$o do cadastro do produto
				If Not IsNull(adc_Preco_Planilha) and adc_Preco_Planilha > 0 Then
					lvdc_Preco = adc_Preco_Planilha
				End If

				// Se for informado o desconto na planilha n$$HEX1$$e300$$ENDHEX$$o utiliza o desconto do fornecedor do cadastro do produto
				If Not IsNull(adc_Desconto_Planilha)  and adc_Desconto_Planilha > 0 Then
					lvdc_Desconto = adc_Desconto_Planilha
				End If
								
				// Verifica se o produto $$HEX1$$e900$$ENDHEX$$ atendido por distribuidoras
				If wf_Produto_Distribuidora(ll_Produto, ll_Filial) Then
					ls_Distribuidora = "SIM"
				Else
					ls_Distribuidora = "N$$HEX1$$c300$$ENDHEX$$O"
				End If
				
				// Verifica o saldo no estoque central (em unidade de estoque)
				If Not wf_Saldo_Estoque(ll_Produto, ref ll_Saldo_Estoque, ll_Filial ) Then Return False
				
				ldh_Inicio = gf_GetServerDate()
				ldh_Inicio = DateTime(RelativeDate(Date(ldh_Inicio), -30))
				
				If Not gf_Saldo_Transito_Ec(ldh_Inicio, ll_Produto, Ref ll_Saldo_Trans) Then Return False
								
				// CIA
				If ll_Filial = 534 Then
					// Rede = CIA => Verifica o saldo nas filiais (em unidade de venda, sumarizado inclusive com o estoque central)
					If Not wf_Saldo_Filiais(ll_Produto, ref lvl_Saldo_Filiais) Then Return False
					
					// Faz a convers$$HEX1$$e300$$ENDHEX$$o dos saldos para unidade de estoque
					lvl_Saldo_Filiais = lvl_Saldo_Filiais - Round(ll_Saldo_Estoque * ldc_Fat_Conv, 0)
					
					lvl_Saldo_Filiais = Round(lvl_Saldo_Filiais / ldc_Fat_Conv, 0)
					
					//Almoxarifado
					If lvs_Grupo = '5' Then
						If Not wf_Venda_Diaria_Almoxarifado(ll_Produto, Ref lvdc_Venda_Diaria ) Then Return False
					Else
						 //Verifica a m$$HEX1$$e900$$ENDHEX$$dia di$$HEX1$$e100$$ENDHEX$$ria de venda da CIA
						If Not wf_Venda_Diaria(ll_Produto, ref lvdc_Venda_Diaria) Then Return False
					End If
					
				Else
					ll_Saldo_Estoque = Round(ll_Saldo_Estoque / ldc_Fat_Conv, 0)
					lvl_Saldo_Filiais = ll_Saldo_Estoque
						
					// Verifica a m$$HEX1$$e900$$ENDHEX$$dia di$$HEX1$$e100$$ENDHEX$$ria de venda da DFP
					If Not wf_Venda_Diaria_Filial(ll_Filial, ll_Produto, ref lvdc_Venda_Diaria) Then Return False
				End If
				
				// Verifica o Estoque Base do Produto
				If Not wf_Localiza_Estoque_Base(ll_Filial, ll_Produto, lvs_Grupo, Ref lvl_Estoque_Base) Then Return False
				
				lvdc_Venda_Diaria = Round(lvdc_Venda_Diaria / ldc_Fat_Conv, 2)
				
				// Calcula a m$$HEX1$$e900$$ENDHEX$$dia mensal de venda
				lvl_Venda_Mensal = Round(lvdc_Venda_Diaria * 30, 0)
			
				// Calcula a cobertura de estoque do estoque central
				If lvdc_Venda_Diaria > 0 Then
					lvl_Dias_Estoque = Round((ll_Saldo_Estoque + ll_Saldo_Trans) / lvdc_Venda_Diaria, 0)
					ll_Dias_Ec_Rede = Round((ll_Saldo_Estoque + ll_Saldo_Trans + lvl_Saldo_Filiais) / lvdc_Venda_Diaria, 0)
				Else
					lvl_Dias_Estoque = 0
					ll_Dias_Ec_Rede = 0
				End If
								
				//Calcula a quantidade sugerida
				If ll_Filial = 534 And lvs_Grupo = '5' Then
					//Se o EB for maior que zero o lvl_Qtde_Sugerida = qt_saldo - qt_estoque_base
					If lvl_Estoque_Base > 0 Then
						lvl_Qtde_Sugerida = lvl_Estoque_Base - ll_Saldo_Estoque
					Else
						lvl_Qtde_Sugerida = Round(lvdc_Venda_Diaria * lvl_Dias_Suprimento, 0) - ll_Saldo_Estoque
					End If
				Else
					lvl_Qtde_Sugerida = Round(lvdc_Venda_Diaria * lvl_Dias_Suprimento, 0) - ll_Saldo_Estoque
				End If
				
				If lvl_Qtde_Sugerida < 0 Then lvl_Qtde_Sugerida = 0
				
				// Atualiza a quantidade pedida
				If ls_Situacao = "A" and ls_Distribuidora = "N$$HEX1$$c300$$ENDHEX$$O" Then
					lvl_Qtde_Pedida = lvl_Qtde_Sugerida
				Else
					lvl_Qtde_Pedida = 0
				End If
				
				If Not IsNull(al_qtde_planilha) and al_qtde_planilha > 0 Then
					lvl_Qtde_Pedida = al_qtde_planilha
				End If
				
				If Not IsNull(lvs_Grupo_Psico) Then ls_Descricao += " (" + lvs_Grupo_Psico + ")"
				
//				// Atualiza a datawindow dos produtos do pedido
				dw_2.Object.Cd_Fornecedor      			[ll_Linha] = ids_PRD.Object.cd_fornecedor_usual					[ll_Contador]
				dw_2.Object.Nm_Fornecedor      			[ll_Linha] = ids_PRD.Object.nm_razao_social						[ll_Contador]
				dw_2.Object.Cd_Produto         				[ll_Linha] = ids_PRD.Object.cd_produto								[ll_Contador]
				dw_2.Object.De_Produto         				[ll_Linha] = ls_Descricao
				dw_2.Object.Id_Situacao        				[ll_Linha] = ids_PRD.Object.id_situacao								[ll_Contador]
				dw_2.Object.Vl_Preco_Unitario  			[ll_Linha] = lvdc_Preco
				dw_2.Object.Pc_Desconto        			[ll_Linha] = lvdc_Desconto
				dw_2.Object.Nr_Embalagem_Padrao		[ll_Linha] = ids_PRD.Object.nr_embalagem_padrao				[ll_Contador]
				dw_2.Object.Pc_IPI             				[ll_Linha] = ids_PRD.Object.pc_ipi										[ll_Contador]
				dw_2.Object.Vl_Custo_Medio     			[ll_Linha] = ids_PRD.Object.vl_custo_gerencial						[ll_Contador]
				dw_2.Object.id_icms_normal				[ll_Linha] = ids_PRD.Object.id_icms_normal							[ll_Contador]
				dw_2.Object.pc_icms							[ll_Linha] = ids_PRD.Object.pc_icms									[ll_Contador] 
				dw_2.Object.id_situacao_pis_cofins		[ll_Linha] = ids_PRD.Object.id_situacao_pis_cofins				[ll_Contador] 
				dw_2.Object.cd_tributacao_icms			[ll_Linha] = ids_PRD.Object.cd_tributacao_icms					[ll_Contador] 
				dw_2.Object.cd_tributacao_produto		[ll_Linha] = ids_PRD.Object.cd_tributacao_produto				[ll_Contador] 
				dw_2.Object.id_lei_generico				[ll_Linha] = ids_PRD.Object.id_lei_generico							[ll_Contador] 
				dw_2.Object.id_caderno_abcfarma		[ll_Linha] = ids_PRD.Object.id_caderno_abcfarma					[ll_Contador] 
				dw_2.Object.vl_preco_venda_maximo	[ll_Linha] = ids_PRD.Object.vl_preco_venda_maximo				[ll_Contador] 
				dw_2.Object.cd_subcategoria				[ll_Linha] = ids_PRD.Object.cd_subcategoria						[ll_Contador]
				dw_2.Object.cd_grupo						[ll_Linha] = ids_PRD.Object.cd_grupo									[ll_Contador]
				dw_2.Object.cd_curva_abc_filiais			[ll_Linha] = ids_PRD.Object.cd_curva_abc_filiais					[ll_Contador]
				dw_2.Object.cd_curva_abc_perini			[ll_Linha] = ids_PRD.Object.cd_curva_abc_perini					[ll_Contador]
				dw_2.Object.id_resgate_clube				[ll_Linha] = ids_PRD.Object.id_resgate_clube						[ll_Contador]
				
				dw_2.Object.qt_altura						[ll_Linha]	=  ids_PRD.Object.qt_altura_cm_caixa_estoque		[ll_Contador]
				dw_2.Object.qt_largura						[ll_Linha]	=  ids_PRD.Object.qt_largura_cm_caixa_estoque		[ll_Contador]
				dw_2.Object.qt_profundidade				[ll_Linha]	=  ids_PRD.Object.qt_profund_cm_caixa_estoque		[ll_Contador]
				dw_2.Object.cd_mix_produto				[ll_Linha]	= 	ids_PRD.Object.cd_mix_produto						[ll_Contador]
				dw_2.Object.de_codigo_barras				[ll_Linha]	= 	ids_PRD.Object.de_codigo_barras						[ll_Contador]
				dw_2.Object.nr_classificacao_fiscal		[ll_Linha]	= 	ids_PRD.Object.nr_classificacao_fiscal				[ll_Contador]
				dw_2.Object.id_revisao_fiscal				[ll_Linha]	= 	ids_PRD.Object.id_revisao_fiscal						[ll_Contador]
				
				dw_2.Object.Id_Distribuidora   				[ll_Linha] = ls_Distribuidora
				dw_2.Object.Qt_Estoque_Atual   			[ll_Linha] = ll_Saldo_Estoque
				dw_2.Object.Qt_Est_Trans					[ll_Linha] = ll_Saldo_Trans
				dw_2.Object.Qt_Saldo_Filiais   				[ll_Linha] = lvl_Saldo_Filiais
				dw_2.Object.Qt_Venda_Diaria   			[ll_Linha] = lvdc_Venda_Diaria
				dw_2.Object.Qt_Venda_Mensal    			[ll_Linha] = lvl_Venda_Mensal
				dw_2.Object.Qt_Sugerida        				[ll_Linha] = lvl_Qtde_Sugerida
				dw_2.Object.Qt_Pedida          				[ll_Linha] = lvl_Qtde_Pedida
				dw_2.Object.Qt_Dias_Estoque    			[ll_Linha] = lvl_Dias_Estoque
				dw_2.Object.Qt_Dias_Estoque_Rede		[ll_Linha] = ll_Dias_Ec_Rede
				dw_2.Object.Cd_Grupo_Psico     			[ll_Linha] = lvs_Grupo_Psico
				dw_2.Object.Qt_Estoque_Base    			[ll_Linha] = lvl_Estoque_Base
				dw_2.Object.Cd_Grupo     					[ll_Linha] = lvs_Grupo
				dw_2.Object.Vl_Fator_Conversao 			[ll_Linha] = ldc_Fat_Conv
				
				If Not wf_Verifica_Pbm(ll_Produto, ll_Linha) Then Return False
				
				If Not wf_Verifica_DermaClub(ll_Produto, ll_Linha) Then Return False
								
				If Not wf_Verifica_Produto_Manipulado(ll_Produto, ll_Linha) Then Return False
				
				If ids_PRD.Object.Id_Farmacia_Popular[ll_Contador] = 'S' Then	
					dw_2.Object.Id_Farmacia_Popular[ll_Linha] = 'S'	
				End If
				
				dw_2.Object.qt_minimo_planograma		[ll_Linha] = wf_minimo_planograma(ll_Produto, ldc_Fat_Conv)
				
				wf_melhor_preco_distribuidora(ll_Linha, ids_PRD.Object.id_icms_st[ll_Contador])
				
				dw_2.Event ue_Atualiza_Valores(ll_Linha, 'X')
				
			End If // find = 0
		
			If IsNull(al_produto) or al_produto = 0 Then
				w_Aguarde_1.uo_Progress.of_SetProgress(ll_Contador)
			End If
		Next

	ElseIf ll_Total < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao recuperar os dados dos produtos.", StopSign!)
		Return False
	Else
		If Not IsNull(al_produto) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "As informa$$HEX2$$e700f500$$ENDHEX$$es do produto '"+ String(al_produto) + "' n$$HEX1$$e300$$ENDHEX$$o foram localizadas.", Information!)
		Else
			If IsNull(as_divisoes) Or as_divisoes = "" Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existem produtos cadastrados para o fornecedor '" + as_fornecedor + "'.", Information!)
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existem produtos cadastrados para o fornecedor '" + as_fornecedor + "' na divis$$HEX1$$e300$$ENDHEX$$o '" + as_divisoes + "'.", Information!)
			End If
		End If
		Return False
	End If

finally
	If IsNull(al_produto) or al_produto = 0 Then
		Close(w_Aguarde_1)
		dw_2.SetRedraw(True)
	End If
	SetPointer(Arrow!)
end try

Return True
end function

public function boolean wf_verifica_fornecedor_agendamento ();String ls_Parametro
String ls_Utiliza_Agend

Select vl_parametro
	Into :ls_Parametro
From parametro_geral
Where cd_parametro = 'ID_UTILIZA_AGENDAMENTO_ENTREGA'
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Erro ao localizar o par$$HEX1$$e200$$ENDHEX$$metro 'ID_UTILIZA_AGENDAMENTO_ENTREGA' do parametro_geral.")
	Return False
End If

//ls_Parametro = "" $$HEX1$$e900$$ENDHEX$$ porque n$$HEX1$$e300$$ENDHEX$$o tem o par$$HEX1$$e200$$ENDHEX$$metro na parametro_geral
If ls_Parametro = "S" Or ls_Parametro = "" Then
	
	Select coalesce(id_utiliza_agendamento_entrega, 'N')
		Into :ls_Utiliza_Agend
	From fornecedor
	Where cd_fornecedor = :ivo_Fornecedor.Cd_Fornecedor
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgdbError("Erro ao localizar o ID_UTILIZA_AGENDAMENTO_ENTREGA da tabela fornecedor")
		Return False
	End If
	
	If ls_Utiliza_Agend = "N" Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Fornecedor '" + ivo_Fornecedor.Nm_Fantasia + " (" + ivo_Fornecedor.Cd_Fornecedor + ")' ainda n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ utilizando o agendamento de entrega.", Exclamation!)
	End If
End If
	
Return True
end function

public function boolean wf_verifica_pbm (long pl_produto, long pl_linha);//Mostra s$$HEX1$$ed00$$ENDHEX$$mbolo de PBM em cima do campo descri$$HEX2$$e700e300$$ENDHEX$$o do produto.

Long lvl_Count

Select Count(pp.cd_pbm)
  Into :lvl_Count
  From pbm p, pbm_produto pp
 Where pp.cd_produto = :pl_produto
   and pp.cd_pbm		= p.cd_pbm
	and p.id_tipo is null or p.id_tipo <> 'D'
 Using SqlCa;
 
If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o dos PBMs do produto '" + String(pl_Produto) + "'.")
	Return False
End If

If lvl_Count > 0 Then
	dw_2.Object.Id_PBM[pl_Linha] = 'S'
End If
end function

public function boolean wf_verifica_produto_manipulado (long al_produto, long al_linha);Long ll_Mix

Select cd_mix_produto
	Into :ll_Mix
From produto_central
Where cd_produto = :al_Produto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If ll_Mix = 20 Then
			dw_2.Object.Id_Manipulado[al_Linha] = 'S'
		End If
		
	Case 100
		dw_2.Object.Id_Manipulado[al_Linha] = 'N'
		
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na verifica$$HEX2$$e700e300$$ENDHEX$$o do produto manipulado.", StopSign!)
		Return False
End Choose

Return True
end function

public function boolean wf_verifica_dermaclub (long pl_produto, long pl_linha);//Mostra s$$HEX1$$ed00$$ENDHEX$$mbolo de PBM em cima do campo descri$$HEX2$$e700e300$$ENDHEX$$o do produto.

Long lvl_Count

Select Count(pp.cd_pbm)
  Into :lvl_Count
  From pbm p, pbm_produto pp
 Where pp.cd_produto = :pl_produto
   and pp.cd_pbm		= p.cd_pbm
	and p.id_tipo = 'D'
 Using SqlCa;
 
If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do DERMACLUB do produto '" + String(pl_Produto) + "'.")
	Return False
End If

If lvl_Count > 0 Then
	dw_2.Object.Id_DermaClub[pl_Linha] = 'S'
End If
end function

on w_ge101_analise_compra.create
int iCurrent
call super::create
this.gb_3=create gb_3
this.gb_1=create gb_1
this.dw_1=create dw_1
this.dw_3=create dw_3
this.gb_4=create gb_4
this.dw_2=create dw_2
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.st_5=create st_5
this.st_6=create st_6
this.st_7=create st_7
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_3
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.dw_3
this.Control[iCurrent+5]=this.gb_4
this.Control[iCurrent+6]=this.dw_2
this.Control[iCurrent+7]=this.st_1
this.Control[iCurrent+8]=this.st_2
this.Control[iCurrent+9]=this.st_3
this.Control[iCurrent+10]=this.st_4
this.Control[iCurrent+11]=this.st_5
this.Control[iCurrent+12]=this.st_6
this.Control[iCurrent+13]=this.st_7
this.Control[iCurrent+14]=this.gb_2
end on

on w_ge101_analise_compra.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_3)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.dw_3)
destroy(this.gb_4)
destroy(this.dw_2)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.st_6)
destroy(this.st_7)
destroy(this.gb_2)
end on

event ue_postopen;call super::ue_postopen;If Not wf_Localiza_Parametro() Then
	Close(This)
	Return
End If

ivo_Fornecedor	= Create uo_Fornecedor
ivo_Condicao   	= Create uo_Condicao_Pagamento
ivo_Produto    	= Create uo_Produto
ivo_Simula 		= Create uo_simula_pedido
ivo_Filial 			= Create uo_Filial

dw_1.Event ue_AddRow()
dw_3.Event ue_AddRow()

dw_1.SetFocus()

ivm_Menu.ivb_Permite_Incluir 		= True
ivm_Menu.ivb_Permite_Excluir 		= True

ivm_Menu.mf_Incluir(True)
ivm_Menu.mf_Cancelar(True)

dw_1.Object.Cd_Uf_Filial[1] = "SC"

dw_1.Event ue_Pos(1, "nm_fornecedor")

If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = "CO" Then
	dw_2.Object.Qt_Pedida.Protect = 0
Else
	dw_2.Object.Qt_Pedida.Protect = 1
End If
end event

event close;call super::close;Destroy(ivo_Fornecedor)
Destroy(ivo_Condicao)
Destroy(ivo_Produto)
Destroy(ivds_Consulta)
Destroy(ivo_Simula)
Destroy(ivo_Filial)
Destroy(ids_PRD)
end event

event open;call super::open;ivds_Consulta 	= Create dc_uo_ds_Base
ids_PRD			= Create dc_uo_ds_Base

//If Not ivds_Consulta.of_ChangeDataObject("dw_co040_consulta_produto_pedido") Then Close(This)

If Not ids_PRD.of_ChangeDataObject("ds_ge101_lista_produtos") Then Close(This)
end event

event ue_cancel;call super::ue_cancel;dw_1.AcceptText()

ivo_Fornecedor.of_Inicializa()
ivo_Condicao.of_Inicializa()

dw_1.Reset()
dw_2.Reset()
dw_3.Reset()

ivds_Consulta.Reset()

dw_1.Event ue_AddRow()
dw_3.Event ue_AddRow()

dw_1.SetFocus()

dw_1.Object.cd_uf_filial	[1] = "SC"

dw_1.Event ue_Pos(1, "nm_fornecedor")

ivm_Menu.mf_Cancelar(True)
end event

event ue_save;call super::ue_save;Return 1
end event

type dw_visual from dc_w_sheet`dw_visual within w_ge101_analise_compra
integer y = 1104
end type

type gb_aux_visual from dc_w_sheet`gb_aux_visual within w_ge101_analise_compra
integer y = 1032
end type

type gb_3 from groupbox within w_ge101_analise_compra
integer x = 14
integer y = 1456
integer width = 2299
integer height = 488
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Detalhes do Produto"
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within w_ge101_analise_compra
integer x = 14
integer y = 4
integer width = 2043
integer height = 352
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Dados do Pedido"
borderstyle borderstyle = styleraised!
end type

type dw_1 from dc_uo_dw_base within w_ge101_analise_compra
integer x = 37
integer y = 64
integer width = 1979
integer height = 260
boolean bringtotop = true
string dataobject = "dw_ge101_selecao_analise_compra"
end type

event itemchanged;call super::itemchanged;dw_1.AcceptText()

Choose Case dwo.Name
	Case "nm_fornecedor"
		If Data <> ivo_Fornecedor.Nm_Razao_Social Then
			Return 1
		End If
		
	Case "de_condicao_pagamento"
		If Data <> ivo_Condicao.De_Condicao Then
			Return 1
		End If			
				
	Case "pc_desconto"
		wf_Atualiza_Totais()
		wf_atualiza_valores_simulacao('X')
		
	Case "id_ipi"
		If Data = "S" Then
			If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Considera o IPI na simula$$HEX2$$e700e300$$ENDHEX$$o de compra ?", Question!, YesNoCancel!, 2) <> 1 Then
				Return 1
			End If
		End If	
		
		wf_atualiza_valores_simulacao(Data)
		
End Choose
end event

event losefocus;call super::losefocus;If IsValid(ivo_Fornecedor) Then
	This.Object.Cd_Fornecedor[1] = ivo_Fornecedor.Cd_Fornecedor
	This.Object.Nm_Fornecedor[1] = ivo_Fornecedor.Nm_Razao_Social
End If

If IsValid(ivo_Condicao) Then
	This.Object.Cd_Condicao_Pagamento[1] = ivo_Condicao.Cd_Condicao
	This.Object.De_Condicao_Pagamento[1] = ivo_Condicao.De_Condicao
End If

wf_Atualiza_Totais()
end event

event ue_key;If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "nm_fornecedor"
			ivo_Fornecedor.of_Localiza_Fornecedor(This.GetText())
			
			If ivo_Fornecedor.Localizado Then
				
				If Not IsNull(ivo_Fornecedor.Cd_Condicao_Pagamento) Then
				
					This.Object.Cd_Fornecedor		[1] = ivo_Fornecedor.Cd_Fornecedor
					This.Object.Nm_Fornecedor		[1] = ivo_Fornecedor.Nm_Razao_Social
					This.Object.Pc_Desconto  		[1] = ivo_Fornecedor.Pc_Desconto_Usual
					This.Object.cd_uf_fornecedor  	[1] = ivo_Fornecedor.cd_unidade_federacao
					
					//ivs_Considera_IPI = ivo_Simula.of_considera_ipi(ivo_Fornecedor.Cd_Fornecedor)
					
					If Not wf_Verifica_Fornecedor_Agendamento() Then Return -1
					
					This.Object.id_ipi[1] =	ivo_Simula.of_considera_ipi(ivo_Fornecedor.Cd_Fornecedor)
					
					ivo_Condicao.of_Inicializa()
	
					This.Object.Cd_Condicao_Pagamento[1] = ivo_Condicao.Cd_Condicao
					This.Object.De_Condicao_Pagamento[1] = ivo_Condicao.De_Condicao
					
					If Not IsNull(ivo_Fornecedor.Cd_Condicao_Pagamento) Then
						If ivo_Condicao.of_Localiza_Codigo(ivo_Fornecedor.Cd_Condicao_Pagamento) Then		
							This.Object.Cd_Condicao_Pagamento[1] = ivo_Condicao.Cd_Condicao
							This.Object.De_Condicao_Pagamento[1] = ivo_Condicao.De_Condicao
						End If
					End If
					
					wf_atualiza_valores_simulacao('X')
					
					If dw_2.RowCount() = 0 Then
						If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja incluir os produtos deste fornecedor ?", Question!, YesNo!, 2) = 1 Then
														
							wf_Inclui_Produto_Fornecedor(ivo_Fornecedor.Cd_Fornecedor)
							Parent.ivm_Menu.mf_Classificar(True)
							dw_2.SetFocus()
						End If
					End If
					
				Else
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existe condi$$HEX2$$e700e300$$ENDHEX$$o de pagamento cadastrada para este fornecedor.")
					
					ivo_Fornecedor.of_Inicializa()
					
					This.Object.Cd_Fornecedor		[1] = ivo_Fornecedor.Cd_Fornecedor
					This.Object.Nm_Fornecedor		[1] = ivo_Fornecedor.Nm_Razao_Social
					
					This.Event ue_Pos(1, "Nm_Fornecedor")
					
					Return -1
				End If
			
			End If
			
		Case "de_condicao_pagamento"
			If ivo_Condicao.of_Localiza(This.GetText(), 100, ivdt_Parametro) Then		
				This.Object.Cd_Condicao_Pagamento[1] = ivo_Condicao.Cd_Condicao
				This.Object.De_Condicao_Pagamento[1] = ivo_Condicao.De_Condicao
				wf_atualiza_valores_simulacao('X')
			End If
			
		Case "nm_filial"
			ivo_Filial.of_Localiza_Filial(This.GetText())
				
			If ivo_Filial.Localizada Then
				
				This.Object.Cd_Filial		[1] = ivo_Filial.cd_Filial
				This.Object.Nm_Filial		[1] = ivo_Filial.Nm_Fantasia
				This.Object.cd_uf_filial	[1] = ivo_Filial.cd_unidade_federacao
				
				//wf_Localiza_UF_Filial()
				wf_atualiza_valores_simulacao('X')
				
			End If
							
	End Choose
End If
end event

event constructor;call super::constructor;This.of_SetColSelection(True)
end event

type dw_3 from dc_uo_dw_base within w_ge101_analise_compra
integer x = 37
integer y = 1512
integer width = 2254
integer height = 424
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_ge101_detalhe_produto"
end type

type gb_4 from groupbox within w_ge101_analise_compra
integer x = 2341
integer y = 1456
integer width = 2267
integer height = 488
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Atalhos"
borderstyle borderstyle = styleraised!
end type

type dw_2 from dc_uo_dw_base within w_ge101_analise_compra
event ue_atualiza_valores ( long al_linha,  string as_ipi )
integer x = 46
integer y = 428
integer width = 4544
integer height = 992
integer taborder = 20
string dataobject = "dw_ge101_pedido_produto"
boolean vscrollbar = true
end type

event ue_atualiza_valores(long al_linha, string as_ipi);Decimal 	lvdc_Preco_Unitario,&
			lvdc_Desconto,&
			lvdc_PC_ICMS_Venda,&
			lvdc_PC_ICMS_Compra,&
			lvdc_PC_Repasse,&
			lvdc_Repasse,&
			lvdc_ICMS_ST,&
			lvdc_Valor_Compra,&
			lvdc_Juros_Pagto,&
			lvdc_Desconto_Pedido,&
			lvdc_Preco_Liquido,&
			lvdc_Valor_IPI,&
			lvdc_PC_IPI,&
			lvdc_Acrescimo_Logistica,&
			lvdc_Reducao_ICMS,&
			lvdc_Valor_ICMS,&
			lvdc_Preco_Venda_Maximo
			
Long 	lvl_Produto,&
		lvl_Condicao_Pagto,&
		lvl_Tributacao_Produto,&
		ll_Classificacao_Fiscal

String	lvs_UF_Fornecedor,&
		lvs_UF_Filial,&
		lvs_Grupo,&
		lvs_ICMS_Normal,&
		lvs_Tributacao_ICMS,&
		lvs_Caderno_ABCFarma,&
		lvs_Lei_Generico,&
		lvs_Situacao_Pis_Cofins,&
		ls_IPI,&
		ls_Fornecedor
		
dw_1.AcceptText()
dw_2.AcceptText()

ls_Fornecedor					= dw_1.Object.cd_fornecedor				[1]
lvs_UF_Fornecedor			= dw_1.Object.cd_uf_fornecedor			[1]
lvs_UF_Filial						= dw_1.Object.cd_uf_filial					[1]
lvl_Condicao_Pagto			= dw_1.Object.cd_condicao_pagamento	[1]
lvdc_Desconto_Pedido		= dw_1.Object.pc_desconto					[1]
ls_IPI								= dw_1.Object.id_ipi							[1]
lvs_Grupo						= dw_2.Object.cd_grupo						[al_Linha]
lvdc_Preco_Unitario			= dw_2.Object.vl_preco_unitario			[al_Linha]
lvdc_Desconto					= dw_2.Object.pc_desconto					[al_Linha]
lvs_ICMS_Normal				= dw_2.Object.id_icms_normal				[al_Linha]
lvdc_PC_ICMS_Venda			= dw_2.Object.pc_icms						[al_Linha]
lvdc_PC_IPI						= dw_2.Object.pc_ipi							[al_Linha]
lvs_Tributacao_ICMS			= dw_2.Object.cd_tributacao_icms		[al_Linha]
lvl_Tributacao_Produto 		= dw_2.Object.cd_tributacao_produto	[al_Linha]
lvs_Caderno_ABCFarma		= dw_2.Object.id_caderno_abcfarma		[al_Linha]
lvs_Lei_Generico				= dw_2.Object.id_lei_generico				[al_Linha]
lvs_Situacao_Pis_Cofins		= dw_2.Object.id_situacao_pis_cofins	[al_Linha]
lvdc_Preco_Venda_Maximo	= dw_2.Object.vl_preco_venda_maximo	[al_Linha]
ll_Classificacao_Fiscal			= dw_2.Object.nr_classificacao_fiscal		[al_Linha]
lvl_Produto						= dw_2.Object.cd_produto					[al_Linha]

ivo_Produto.of_Localiza_Codigo_Interno(lvl_Produto)

If as_ipi = 'X' Then
	If ls_IPI = "N" Then
		lvdc_PC_IPI  = 0.00
	End If
Else
	If as_ipi = "N" Then
		lvdc_PC_IPI  = 0.00
	End If
End If

// Percentual de ICMS para compras interestaduais
lvdc_Repasse				= 0.00
lvdc_ICMS_ST				= 0.00
lvdc_Valor_IPI				= 0.00	

lvdc_Preco_Liquido = round(round(lvdc_Preco_Unitario * (100 - lvdc_Desconto) / 100, 2) * ((100 - lvdc_Desconto_Pedido) / 100), 2)

//lvdc_Valor_Compra = ivo_Simula.of_Valor_Compra(	lvdc_Preco_Unitario, lvdc_Desconto, lvdc_Desconto_Pedido,&
//																lvdc_PC_ICMS_Venda, lvs_Tributacao_ICMS, &
//																lvl_Tributacao_Produto,&
//																lvs_Caderno_ABCFarma, lvs_Lei_Generico,  &
//																lvs_UF_Filial,  lvs_UF_Fornecedor, lvs_Situacao_Pis_Cofins,&
//																lvdc_Preco_Venda_Maximo, ivo_Produto,lvs_ICMS_Normal, lvdc_PC_IPI,&
//																ll_Classificacao_Fiscal, 0.00)

lvdc_Valor_Compra = ivo_Simula.of_Valor_Compra_Nova(	lvdc_Preco_Unitario,&
																			lvdc_Desconto, &
																			lvdc_Desconto_Pedido,&
																			lvs_UF_Filial, &
																			lvs_UF_Fornecedor,& 
																			ivo_Produto,&
																			lvdc_PC_IPI,&
																			ls_Fornecedor, 0.00)
												
ivo_Simula.of_calcula_juros_diario(lvl_Condicao_Pagto, lvdc_Valor_Compra, Ref lvdc_Juros_Pagto)

// (-) Juros ao contr$$HEX1$$e100$$ENDHEX$$rio
lvdc_Valor_Compra = lvdc_Valor_Compra  - lvdc_Juros_Pagto

lvdc_Acrescimo_Logistica  = round(lvdc_Valor_Compra * (ivdc_pc_custo_adm_logistica / 100),2)

// (+) Custo ADM logistica
lvdc_Valor_Compra = lvdc_Valor_Compra + round(lvdc_Valor_Compra * (ivdc_pc_custo_adm_logistica / 100),2)

dw_2.Object.pc_repasse					[al_Linha] = ivo_Simula.PC_Repasse
dw_2.Object.vl_repasse					[al_Linha] = ivo_Simula.vl_Repasse
dw_2.Object.vl_icms_st					[al_Linha] = ivo_Simula.vl_ICMS_ST
dw_2.Object.vl_preco_final_fab		[al_Linha] = lvdc_Valor_Compra
dw_2.Object.vl_ipi							[al_Linha] = ivo_Simula.vl_IPI
dw_2.Object.vl_juros_decrescimo		[al_Linha] = lvdc_Juros_Pagto
dw_2.Object.vl_acrescimo_logistica	[al_Linha] = lvdc_Acrescimo_Logistica
end event

event constructor;call super::constructor;String lvs_Coluna[], &
       lvs_Nome[], &
		 lvs_Bloqueio[]
		 
lvs_Coluna   = {"nm_fornecedor","de_produto","qt_sugerida"}
lvs_Nome     = {"Fornecedor", "Descri$$HEX2$$e700e300$$ENDHEX$$o","Qtde. Sugerida"}
lvs_Bloqueio = {"S", "N", "N"}

This.of_SetSort(lvs_Coluna, lvs_Nome, lvs_Bloqueio)

//This.of_SetRowSelection("if(pc_variacao < 0 , rgb(255,185,15), rgb(255,255,255))", "if(isnull(cd_grupo_psico), rgb(0,0,0), if (cd_grupo_psico <> ~"W~", rgb(255,0,0),rgb(255,0,0)))")

This.of_SetRowSelection("if(pc_variacao < 0 , rgb(191,205,219), rgb(255,255,255))", "if(isnull(cd_grupo_psico), rgb(0,0,0), if (cd_grupo_psico <> ~"W~", rgb(255,0,0),rgb(255,0,0)))")





end event

event ue_key;Long lvl_Find

String ls_Nulo
Long ll_Nulo
Decimal ldc_Nulo
						
SetNull(ls_Nulo)
SetNull(ll_Nulo)
SetNull(ldc_Nulo)

Choose Case Key
	Case KeyEnter!
		Choose Case This.GetColumnName()
			Case "de_produto"
				ivo_Produto.of_Localiza_Produto(This.GetText())
				
				If ivo_Produto.Localizado Then
					// Verifica se o produto j$$HEX1$$e100$$ENDHEX$$ existe na lista
					lvl_Find = This.Find("cd_produto = " + String(ivo_Produto.Cd_Produto), 1, dw_2.RowCount())
					
					If lvl_Find < 0 Then
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na verifica$$HEX2$$e700e300$$ENDHEX$$o da exist$$HEX1$$ea00$$ENDHEX$$ncia do produto na datawindow.", StopSign!)
						Return
					End If				
					
					If lvl_Find > 0 Then
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto '" + String(ivo_Produto.Cd_Produto) + "' j$$HEX1$$e100$$ENDHEX$$ existe neste pedido.", Information!)
						This.Post Event ue_Pos(lvl_Find, "de_produto")
						This.DeleteRow(This.GetRow())
					Else
						
						If wf_Inclui_Produtos(ls_Nulo, ls_Nulo, ivo_Produto.Cd_Produto, ls_Nulo, ll_Nulo, ldc_Nulo, ldc_Nulo, This.GetRow()) Then
						//If wf_Localiza_Produto(ivo_Produto.Cd_Produto, This.GetRow()) Then
														
							This.Sort()
							This.GroupCalc()

							// Verifica qual a linha para posicionar o cursor, pois o sort mudou as posi$$HEX2$$e700f500$$ENDHEX$$es das linhas
							lvl_Find = This.Find("cd_produto = " + String(ivo_Produto.Cd_Produto), 1, dw_2.RowCount())
							
							If lvl_Find < 0 Then
								MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na verifica$$HEX2$$e700e300$$ENDHEX$$o da exist$$HEX1$$ea00$$ENDHEX$$ncia do produto na datawindow.", StopSign!)
								Return
							End If				
					
							If lvl_Find > 0 Then							
								This.Post Event ue_Pos(lvl_Find, "qt_pedida")
								wf_Atualiza_Totais()
							End If
						End If
					End If
					
					This.Event RowFocusChanged(This.GetRow())
					
				End If
				
			Case "qt_pedida", "vl_preco_unitario", "pc_desconto"
				This.Event ue_AddRow()
		End Choose
		
	Case KeyF2!
		Event ue_Consulta_Vendas()
		
	Case KeyF3!
		Event ue_Consulta_Estoque()
		
	Case KeyF4!
		Event ue_Consulta_Pedido()
		
	Case KeyF5!
		Event ue_Consulta_Distribuidoras()
		
	Case KeyF7!
		Event ue_Inclui_Produto_Fornecedor()
		
	Case KeyF11!
		Event ue_Inclui_Produto_Via_Excel()
		
	Case KeyF12!
		Event ue_Consulta_Minimo_Planograma()
		
End Choose
end event

event rowfocuschanged;call super::rowfocuschanged;If CurrentRow > 0 Then
	dw_3.Object.Nr_Embalagem_Padrao	[1] = This.Object.Nr_Embalagem_Padrao		[CurrentRow]
	dw_3.Object.Vl_Fator_Conversao 		[1] = This.Object.Vl_Fator_Conversao 			[CurrentRow]
	dw_3.Object.Pc_IPI             			[1] = This.Object.Pc_IPI             					[CurrentRow]
	dw_3.Object.Vl_Custo_Medio     		[1] = This.Object.Vl_Custo_Medio     				[CurrentRow]
	dw_3.Object.Id_Distribuidora   			[1] = This.Object.Id_Distribuidora   				[CurrentRow]
	dw_3.Object.Qt_Saldo_Filiais   			[1] = This.Object.Qt_Saldo_Filiais   				[CurrentRow]
	dw_3.Object.Qt_Venda_Diaria    		[1] = This.Object.Qt_Venda_Diaria    				[CurrentRow]
	dw_3.Object.Qt_Venda_Mensal    		[1] = This.Object.Qt_Venda_Mensal   		 	[CurrentRow]
	dw_3.Object.Qt_Dias_Estoque    		[1] = This.Object.Qt_Dias_Estoque    				[CurrentRow]
	dw_3.Object.Qt_Dias_Estoque_Rede	[1] = This.Object.Qt_Dias_Estoque_Rede		[CurrentRow]
	dw_3.Object.Id_Situacao        			[1] = This.Object.Id_Situacao        				[CurrentRow]
	dw_3.Object.Qt_Estoque_Base    		[1] = This.Object.qt_Estoque_Base    			[CurrentRow]
	dw_3.Object.qt_minimo_planograma	[1] = This.Object.qt_minimo_planograma    	[CurrentRow]
	
	If This.Object.id_resgate_clube[CurrentRow]  = 'S' Then
		This.Object.t_troca_pontos.visible = true
	Else
		This.Object.t_troca_pontos.visible = false
	End If
End If
end event

event ue_addrow;call super::ue_addrow;If AncestorReturnValue > 0 Then
	ivm_Menu.mf_Excluir(True)
	
	This.Object.Cd_Fornecedor[AncestorReturnValue] = ""
   This.Object.Nm_Fornecedor[AncestorReturnValue] = "PRODUTOS INCLU$$HEX1$$cd00$$ENDHEX$$DOS"
	
	This.GroupCalc()
	This.Event ue_Pos(AncestorReturnValue, "de_produto")
End If

Return AncestorReturnValue
end event

event ue_preinsertrow;call super::ue_preinsertrow;Long 	lvl_Find,&
		lvl_Condicao
	
String lvs_Fornecedor

dw_1.AcceptText()
				
// Verifica se existe alguma linha com o produto n$$HEX1$$e300$$ENDHEX$$o preenchido
lvl_Find = This.Find("isnull(cd_produto)", 1, dw_2.RowCount())

If lvl_Find < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na verifica$$HEX2$$e700e300$$ENDHEX$$o da exist$$HEX1$$ea00$$ENDHEX$$ncia de produtos n$$HEX1$$e300$$ENDHEX$$o informados.", StopSign!)
	Return 0
End If				

If lvl_Find > 0 Then
	This.Event ue_Pos(lvl_Find, "de_produto")
	Return 0
End If

lvs_Fornecedor	= dw_1.Object.Cd_Fornecedor        			[1]
lvl_Condicao		= dw_1.Object.Cd_Condicao_Pagamento	[1]
						
If IsNull(lvs_Fornecedor) or lvs_Fornecedor = "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione o fornecedor.", Information!)
	dw_1.Event ue_Pos(1, "nm_fornecedor")
	Return 0
End If

If IsNull(lvl_Condicao) or lvl_Condicao = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione a condi$$HEX2$$e700e300$$ENDHEX$$o de pagamento.", Information!)
	dw_1.Event ue_Pos(1, "de_condicao_pagamento")
	Return 0
End If

Return 1
end event

event ue_deleterow;call super::ue_deleterow;If AncestorReturnValue Then
	If This.RowCount() > 0 Then
		wf_Atualiza_Totais()
	End If
End If

Return AncestorReturnValue
end event

event losefocus;call super::losefocus;wf_Atualiza_Totais()
end event

event doubleclicked;call super::doubleclicked;If This.RowCount() > 0 Then
	wf_Simula_Preco()
End If
end event

type st_1 from statictext within w_ge101_analise_compra
integer x = 2437
integer y = 1544
integer width = 814
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 128
long backcolor = 67108864
string text = "Consultar Vendas [F2]"
boolean focusrectangle = false
end type

type st_2 from statictext within w_ge101_analise_compra
integer x = 2437
integer y = 1640
integer width = 814
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 128
long backcolor = 67108864
string text = "Consultar Estoque [F3]"
boolean focusrectangle = false
end type

type st_3 from statictext within w_ge101_analise_compra
integer x = 2437
integer y = 1736
integer width = 814
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 128
long backcolor = 67108864
string text = "Consultar Pedidos [F4]"
boolean focusrectangle = false
end type

type st_4 from statictext within w_ge101_analise_compra
integer x = 3461
integer y = 1544
integer width = 1038
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 128
long backcolor = 67108864
string text = "Consultar Distribuidoras [F5]"
boolean focusrectangle = false
end type

type st_5 from statictext within w_ge101_analise_compra
integer x = 3461
integer y = 1640
integer width = 1038
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 128
long backcolor = 67108864
string text = "Incluir Produtos Fornecedor [F7]"
boolean focusrectangle = false
end type

type st_6 from statictext within w_ge101_analise_compra
integer x = 3461
integer y = 1736
integer width = 1038
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 128
long backcolor = 67108864
string text = "Incluir Produtos via Excel [F11]"
boolean focusrectangle = false
end type

type st_7 from statictext within w_ge101_analise_compra
integer x = 3461
integer y = 1828
integer width = 1038
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 128
long backcolor = 67108864
string text = "Estoque M$$HEX1$$ed00$$ENDHEX$$nimo Planograma [F12]"
boolean focusrectangle = false
end type

type gb_2 from groupbox within w_ge101_analise_compra
integer x = 14
integer y = 376
integer width = 4599
integer height = 1068
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Produtos do Pedido"
borderstyle borderstyle = styleraised!
end type

