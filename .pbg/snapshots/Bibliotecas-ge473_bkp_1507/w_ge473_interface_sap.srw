HA$PBExportHeader$w_ge473_interface_sap.srw
forward
global type w_ge473_interface_sap from dc_w_2tab_consulta_selecao_lista_det
end type
type cb_1 from commandbutton within tabpage_1
end type
type gb_4 from groupbox within tabpage_1
end type
type dw_4 from dc_uo_dw_base within tabpage_1
end type
type cb_cancelamento from commandbutton within tabpage_1
end type
end forward

global type w_ge473_interface_sap from dc_w_2tab_consulta_selecao_lista_det
integer width = 3858
integer height = 2416
string title = "GE473 - Interface SAP [DESCIDA]"
end type
global w_ge473_interface_sap w_ge473_interface_sap

type variables
Integer ii_Empresa = 1000

boolean ivb_check
end variables

forward prototypes
public function boolean wf_processa ()
public function boolean wf_inclusao_alteracao (string as_codigo_sap, string as_cgc_cpf, ref string as_codigo_legado, ref boolean ab_inclusao_alteracao)
public function boolean wf_atualiza_cliente (long al_controle, long al_tabela, ref string as_log)
public function boolean wf_grava_historico (dc_uo_ds_base ads_cliente, string as_tabela, string as_coluna, string as_chave, ref string as_log)
public function boolean wf_retorna_cidade (string as_codigo_ibge, ref long al_cidade, ref string as_log)
public function boolean wf_retorna_estado_civil (string as_estado_de, ref string as_estado_para)
public function integer wf_retorna_telefones (string as_residencial, string as_celular, string as_residencial_ret, string as_celular_ret)
public function boolean wf_verifica_codigo_de_para (long al_controle, string as_cd_tabela, string as_coluna, string as_cd_chave_sap, ref string as_cd_chave_legado, ref string as_log)
public function boolean wf_verifica_obrigatoriedade_campo (long al_controle, string as_campo, string as_obrigatoriedade, string as_valor, ref string as_log)
public subroutine wf_grava_erro (long al_controle, string as_erro)
public function boolean wf_contato_cliente (ref dc_uo_ds_base ads_cli, long al_row_cli, string as_pessoa_fisica_juridica, string as_tipo_cliente, long al_tabela, long al_controle, ref string as_log)
end prototypes

public function boolean wf_processa ();String ls_Log, ls_Chave

Long ll_Linhas, ll_Linha, ll_Controle, ll_Tabela

int  li_ret

try

	ll_Linhas = tab_1.TabPage_1.dw_2.RowCount()
	
	If ll_Linhas > 0 Then 
		
		Open(w_Aguarde_2)
		
		w_aguarde_2.uo_progress.of_setmax(ll_Linhas)		
		
		For ll_Linha =1 To ll_Linhas
			If tab_1.TabPage_1.dw_2.Object.id_processa[ll_Linha] = 'S' and (tab_1.TabPage_1.dw_2.Object.id_situacao[ll_Linha]  = 'C' or tab_1.TabPage_1.dw_2.Object.id_situacao[ll_Linha]  = 'E') Then
				ll_Controle	= tab_1.TabPage_1.dw_2.Object.nr_controle		[ll_Linha]
				ll_Tabela		= tab_1.TabPage_1.dw_2.Object.cd_tabela			[ll_Linha]
				ls_Chave		= tab_1.TabPage_1.dw_2.Object.de_chave_sap	[ll_Linha]
				
				Choose Case ll_Tabela
					Case 1	//Produto / Material
						
						// Para n$$HEX1$$e300$$ENDHEX$$o ficar gerando erro de conex$$HEX1$$e300$$ENDHEX$$o com a mult
						gvb_Carrega_Contas_Mult = False
						
						uo_ge473_produto_sap lo_Produto_SAP
						 
						 Try
							lo_Produto_SAP	= Create uo_ge473_produto_sap
							
							If Not lo_Produto_SAP.of_atualiza_produto( ll_Controle)	Then
								//wf_Grava_Erro(ll_Controle, ls_Log)
							End If						
						Finally
							Destroy(lo_Produto_SAP)
						End Try
						
					Case 20	//Cliente
						If wf_Atualiza_Cliente(ll_Controle, ll_Tabela, Ref ls_Log) Then
							SqlCa.of_Commit()
						Else
							SqlCa.of_Rollback()
							
							wf_Grava_Erro(ll_Controle, ls_Log)
						End If
					
					Case 24	//PRECO_UF
						uo_ge473_produto_uf_sap lo_Produto_Uf_SAP
						 
						 Try
							lo_Produto_Uf_SAP	= Create uo_ge473_produto_uf_sap
							
							lo_Produto_Uf_SAP.of_atualiza_produto_uf( ll_Controle)
						
						Finally
							Destroy(lo_Produto_Uf_SAP)
						End Try
						
					Case 25	//PRECO_REGIONALIZADO
						uo_ge473_preco_regionalizado_sap	lo_Preco_Regionalizado_SAP
						 
						 Try
							lo_Preco_Regionalizado_SAP	= Create uo_ge473_preco_regionalizado_sap
							
							lo_Preco_Regionalizado_SAP.of_atualiza_preco_regionalizado( ll_Controle)
						
						Finally
							Destroy(lo_Preco_Regionalizado_SAP)
						End Try
					Case 27	//Saldo Estoque SAP 
							  uo_ge473_saldo_estoque_sap lo_saldo_estoque_sap
							Try
													lo_saldo_estoque_sap = create  uo_ge473_saldo_estoque_sap
													
													lo_saldo_estoque_sap.of_atualiza_saldo_estoque_sap( ll_Controle )
	
								  Finally
											 If isvalid ( lo_saldo_estoque_sap ) then  Destroy ( lo_saldo_estoque_sap )
							  End Try 
						
					Case 28	//Planejamento Estoque SAP 
							  uo_ge473_planejamento_estoque_sap lo_planejamento_estoque_sap
							Try
													lo_planejamento_estoque_sap = create  uo_ge473_planejamento_estoque_sap
													If lo_planejamento_estoque_sap.of_atualiza_planejamento_estoque_sap( ll_Controle ) then
											Messagebox ( "Interface Planejamento Estoque SAP", "Controle: " + trim(string( ll_Controle ) )+ " Termino OK")			
										Else
												 Messagebox ( "Interface Planejamento Estoque SAP", " Controle: " + string(  ll_Controle ) + " ~n " + &
																		"Termino com erro!",  StopSign!)
										End IF
								  Finally
											 If isvalid ( lo_planejamento_estoque_sap ) then  Destroy ( lo_planejamento_estoque_sap )
							  End Try
					Case 29	//Requisi$$HEX2$$e700e300$$ENDHEX$$o MRP SAP 
							uo_ge473_requisicao_mrp_sap_nova lo_requisicao_mrp_sap
							Try
									lo_requisicao_mrp_sap = create  uo_ge473_requisicao_mrp_sap_nova
								lo_requisicao_mrp_sap.of_atualiza_requisicao_mrp_sap( ll_Controle, ls_Chave)
							  Finally
								 If isvalid ( lo_requisicao_mrp_sap ) then  Destroy ( lo_requisicao_mrp_sap )
							  End Try						  
				
					Case 31	//PRECO_TRANSFERENCIA_ESTOQUE_CENTRAL 
							  uo_ge473_preco_transferencia lo_preco_tranferencia
							Try
													lo_preco_tranferencia = create  uo_ge473_preco_transferencia
													
													lo_preco_tranferencia.of_atualiza_preco_transferencia( ll_Controle )
	
								  Finally
											 If isvalid ( lo_saldo_estoque_sap ) then  Destroy ( lo_saldo_estoque_sap )
							  End Try 
					
					Case 32	//BLOQUEIO_PEDIDO_FILIAL
						uo_ge473_pedido_filial_bloqueio_sap	lo_Pedido_Filial_Bloqueio_SAP
						 
						 Try
							lo_Pedido_Filial_Bloqueio_SAP	= Create uo_ge473_pedido_filial_bloqueio_sap
							
							lo_Pedido_Filial_Bloqueio_SAP.of_atualiza_pedido_filial_bloqueio( ll_Controle)
						
						Finally
							Destroy(lo_Pedido_Filial_Bloqueio_SAP)
						End Try
						
					Case 33	// PROMOCAO_SOS_ESTOQUE_MINIMO / RESUMO_REPOSICAO_ESTOQUE
						uo_ge473_resumo_repos_estoque_sos_estoque_minimo_sap	lo_Estoque
						 
						 Try
							lo_Estoque	= Create uo_ge473_resumo_repos_estoque_sos_estoque_minimo_sap
							
							lo_Estoque.of_atualiza_resumo_repos_est_sos_est_min( ll_Controle)
						
						Finally
							Destroy(lo_Estoque)
						End Try
						
					Case 34	// PROMOCAO NORMAL - VINCULADA
						uo_ge473_promocao_sap	lo_promocao
						 
						 Try
							lo_promocao	= Create uo_ge473_promocao_sap
							
							lo_promocao.of_atualiza_promocao( ll_Controle, ll_Tabela )
						
						Finally
							Destroy(lo_promocao)
						End Try
						
						
						Case 36	// Preparar o sistema da CLAMED para receber de libera$$HEX2$$e700e300$$ENDHEX$$o de pedido para loja nova.
							uo_ge473_pedido_liberacao_loja_nova lo_pedido_liberacao_loja_nova
							Try
								lo_pedido_liberacao_loja_nova = create  uo_ge473_pedido_liberacao_loja_nova
								lo_pedido_liberacao_loja_nova.of_atualiza_pedido_liberacao_loja_nova( ll_Controle,  ll_Tabela)
							 Finally
								 If isvalid ( lo_pedido_liberacao_loja_nova ) then  Destroy ( lo_pedido_liberacao_loja_nova )
							End Try	
						  
						Case 37
							uo_ge473_pedido_liberacao_loja_ba lo_pedido_liberacao_loja_ba
							Try
								lo_pedido_liberacao_loja_ba = create  uo_ge473_pedido_liberacao_loja_ba
								lo_pedido_liberacao_loja_ba.of_atualiza_pedido_liberacao_loja_ba( ll_Controle)
							 Finally
								 If isvalid ( lo_pedido_liberacao_loja_ba ) then  Destroy ( lo_pedido_liberacao_loja_ba)
							 End Try		
						
						Case 41
							uo_ge473_comissao_produto lo_comissao_produto
							Try
								lo_comissao_produto = create  uo_ge473_comissao_produto
								lo_comissao_produto.of_atualiza_comissao( ll_Controle,  ls_Chave)
							 Finally
								 If isvalid ( lo_comissao_produto ) then  Destroy ( lo_comissao_produto )
							End Try	
						
										
						Case 42
							uo_ge473_fornecedor_conexao lo_fornecedor_conexao
							Try
								lo_fornecedor_conexao = create  uo_ge473_fornecedor_conexao
								lo_fornecedor_conexao.of_executa_fornecedor_conexao( ll_Controle,  ll_Tabela)
							 Finally
								 If isvalid ( lo_fornecedor_conexao ) then  Destroy ( lo_fornecedor_conexao)
							 End Try											
										
										
					Case Else
						MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Tabela n$$HEX1$$e300$$ENDHEX$$o prevista para a atualiza$$HEX2$$e700e300$$ENDHEX$$o.', StopSign!)
						Return False
				End Choose
		 
			End If
			
//			w_aguarde_2.uo_progress.of_setprogress(ll_Linha)
		Next
			
	End If
	
finally
	If Isvalid(w_Aguarde_2) Then Close(w_Aguarde_2)
end try

Return True
end function

public function boolean wf_inclusao_alteracao (string as_codigo_sap, string as_cgc_cpf, ref string as_codigo_legado, ref boolean ab_inclusao_alteracao);//If Not IsNull(as_codigo_legado) Then
//End If

Return True
end function

public function boolean wf_atualiza_cliente (long al_controle, long al_tabela, ref string as_log);Long ll_Linhas, ll_Linha, ll_Linha_Cli, ll_Cidade, ll_Portador

String ls_Coluna, ls_Vl_Item, ls_Codigo_Legado, ls_Log, ls_Erro, ls_Obrig, ls_Tipo_Resid
String	ls_XML_Item, ls_Data_Nasc, ls_Nat_Ocupacao, ls_Tempo_Empresa, ls_Dia_Vencimento, ls_Registro_SPC, ls_Fone_Comercial
String ls_Tipo_Cliente, ls_Fisica_Juridica, ls_Nome_Cliente, ls_Razao_Social, ls_CPF_CGC, ls_IE, ls_RG, ls_Orgao_Emissor, ls_Fone_Recado
String ls_Sexo, ls_Estado_Civil, ls_Possui_Filhos, ls_Endereco, ls_NR_Endereco, ls_Bairro, ls_CEP, ls_Tempo_Resid, ls_End_Email
String ls_Complemento, ls_NM_Empresa, ls_Profissao, ls_Aut_Comunicacao, ls_Conjuge, ls_Emp_Conv, ls_End_Email_XML, ls_Portador
String ls_Vl_Renda_Mensal, ls_Vl_Capital, ls_Limite_Credito, ls_Taxa_ADM, ls_DT_Aprov_Credito, ls_Fone_Residencial, ls_Celular
String ls_DT_Alt_Venc, ls_Codigo_IBGE, ls_UF_Emissor_RG, ls_Grau_Instrucao, ls_Tipo_Parceiro_Negocio, ls_Sobrenome, ls_Nm_Fantasia
String ls_Dono_Farmacia, ls_Med_Uso_Continuo, ls_Autoriza_Comun, ls_Cliente_SAP

Date ldt_Nascimento, ldt_Inclusao

Datetime ldt_Atualizacao 

dc_uo_ds_base lds 
dc_uo_ds_base lds_Cli
dc_uo_ds_base lds_Cli_Cheque

Boolean	lb_Cliente_Novo

Try
	lds					= Create dc_uo_ds_base
	lds_Cli			= Create dc_uo_ds_base
	lds_Cli_Cheque	= Create dc_uo_ds_base	
	
	If Not lds.of_ChangeDataObject('ds_ge473_lista_valores', False) Then 
		as_log = "Erro ao alterar a DW [ds_ge473_lista_valores]."
		Return False
	End If
	
	If Not lds_Cli.of_ChangeDataObject('ds_ge473_cliente', False) Then 
		as_log = "Erro ao alterar a DW [ds_ge473_cliente]."
		Return False
	End If
	
	If Not lds_Cli_Cheque.of_ChangeDataObject('ds_ge473_cliente_cheque', False) Then 
		as_log = "Erro ao alterar a DW [ds_ge473_cliente_cheque]."
		Return False
	End If
	
	ll_Linhas = lds.Retrieve(al_controle)
	
	If ll_Linhas > 0 Then
	
		For ll_Linha = 1 To ll_Linhas
			
			ls_Coluna 	= lds.Object.cd_coluna		[ll_Linha]
			ls_Vl_Item	= Upper(lds.Object.vl_item	[ll_Linha])
			ls_Obrig		= lds.Object.id_obrigatorio	[ll_Linha]
			
			If Trim(ls_Vl_Item) = '' Then SetNull(ls_Vl_Item)
						
			Choose Case Lower(ls_Coluna)
				Case 'cd_tipo_pn'
					ls_Tipo_Parceiro_Negocio = ls_Vl_Item
				Case 'cd_cliente_sap'
					ls_Cliente_SAP 			= ls_Vl_Item					
					If Not wf_verifica_obrigatoriedade_campo(al_controle, ls_Coluna, ls_Obrig, ls_VL_Item, ref as_log) Then Return False
				Case 'cd_cliente_legado'
					ls_Codigo_Legado		= ls_Vl_Item	
				Case 'cd_ibge'
						If Not wf_verifica_obrigatoriedade_campo(al_controle, ls_Coluna, ls_Obrig, ls_VL_Item, ref as_log) Then Return False
						If Not wf_retorna_cidade(ls_VL_Item, Ref ll_Cidade, ref as_log) Then Return False
				Case 'de_bairro'
					ls_Bairro = ls_VL_Item	
					If Not wf_verifica_obrigatoriedade_campo(al_controle, ls_Coluna, ls_Obrig, ls_VL_Item, ref as_log) Then Return False
				Case 'de_complemento'
					ls_Complemento 		= ls_VL_Item
				Case 'de_endereco'
					ls_Endereco 			= ls_VL_Item	
					If Not wf_verifica_obrigatoriedade_campo(al_controle, ls_Coluna, ls_Obrig, ls_VL_Item, ref as_log) Then Return False
				Case 'de_orgao_emissor_rg'
					ls_Orgao_Emissor		= ls_VL_Item
				Case 'dh_nascimento'
					ls_VL_Item				= Mid(ls_VL_Item, 1, 4)+"/"+Mid(ls_VL_Item, 5, 2)+"/"+Mid(ls_VL_Item, 7, 2)
					ldt_Nascimento 		= Date(ls_VL_Item)
				Case 'id_estado_civil'
					If Not wf_verifica_codigo_de_para(al_controle, "CLI_ESTADO_CIVIL", ls_Coluna, ls_VL_Item, Ref ls_Estado_Civil, Ref as_log) Then Return False
				Case 'id_fisica_juridica'
					ls_Fisica_Juridica 		= ls_VL_Item
				Case 'id_possui_filhos'
					ls_Possui_Filhos 		= ls_VL_Item
				Case 'id_sexo'
					ls_Sexo 					= ls_VL_Item
				Case 'id_tempo_empresa'
					If Not wf_verifica_codigo_de_para(al_controle, "CLI_TEMPO_EMPRESA", ls_Coluna, ls_VL_Item, Ref ls_Tempo_Empresa, Ref as_log) Then Return False
				Case 'id_tempo_residencia'
					If Not wf_verifica_codigo_de_para(al_controle, "CLI_TEMPO_RESIDENCIA", ls_Coluna, ls_VL_Item, Ref ls_Tempo_Resid, Ref as_log) Then Return False
				Case 'id_tipo_cliente'
					ls_Tipo_Cliente			= ls_VL_Item	
				Case 'nm_cliente'
					ls_Nome_Cliente		= ls_VL_Item
					If Not wf_verifica_obrigatoriedade_campo(al_controle, ls_Coluna, ls_Obrig, ls_VL_Item, ref as_log) Then Return False
				Case 'nm_empresa'
					ls_NM_Empresa 		= ls_VL_Item
				Case 'nm_razao_social'
					ls_Razao_Social		= ls_VL_Item
				Case 'nr_cep'
					ls_CEP					= gf_Replace(ls_VL_Item, "-", "", 0)
					If Not wf_verifica_obrigatoriedade_campo(al_controle, ls_Coluna, ls_Obrig, ls_VL_Item, ref as_log) Then Return False
				Case 'nr_cpf_cgc'
					ls_CPF_CGC				= ls_VL_Item
				Case 'nr_endereco'
					ls_NR_Endereco 		= ls_VL_Item
				Case 'nr_inscricao_estadual'
					ls_IE						= ls_VL_Item
				Case 'nr_rg'
					ls_RG						= ls_VL_Item
				Case 'cd_grau_instrucao'
					ls_Grau_Instrucao		= ls_VL_Item
				Case 'id_natureza_ocupacao'
					If Not wf_verifica_codigo_de_para(al_controle, "CLI_NATUREZA_OCUPACAO", ls_Coluna, ls_VL_Item, Ref ls_Nat_Ocupacao, Ref as_log) Then Return False
				Case 'id_tipo_residencia'
					If Not wf_verifica_codigo_de_para(al_controle, "CLI_TIPO_RESIDENCIA", ls_Coluna, ls_VL_Item, Ref ls_Tipo_Resid, Ref as_log) Then Return False
				Case 'nm_conjuge'
					ls_Conjuge 				= ls_VL_Item
				Case 'nm_sobrenome'
					ls_Sobrenome			= ls_VL_Item
				Case 'nm_fantasia'
					ls_Nm_Fantasia		= ls_Vl_Item
				Case 'cd_portador'
					If Not wf_verifica_codigo_de_para(al_controle, "PORTADOR", ls_Coluna, ls_VL_Item, Ref ls_Portador , Ref as_log) Then Return False
					ll_Portador = Long(ls_Portador)
				Case 'id_dono_farmacia'
					ls_Dono_Farmacia = ls_Vl_Item
				Case 'id_medicamento_uso_continuo'
					ls_Med_Uso_Continuo = ls_Vl_Item
				Case 'id_autoriza_comunicacao'
					ls_Autoriza_Comun	= ls_Vl_Item
			End Choose
			
		Next
				
		//Muda a situacao na interface
		Update interface_sap
			set id_situacao = 'P',
			dh_processamento = getdate(), //Processado
			de_erro = null
		Where nr_controle = :al_controle
		Using SqlCa;
		
		If SqlCa.sqlcode = -1 Then
			as_Log	= "Erro ao mudar a situa$$HEX2$$e700e300$$ENDHEX$$o na tabela interface_sap. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle)+". Erro: "+SqlCa.sqlErrText
			Return False
		End If
	
		If ls_Tipo_Cliente = "EC" Then	//Cliente Ecommerce -> N$$HEX1$$e300$$ENDHEX$$o atualiza no legado
			Return True
			
		ElseIf ls_Tipo_Cliente = "CH" Then  //Cliente Cheque
			If (LenA(Trim(ls_CPF_CGC)) <> 11 and LenA(Trim(ls_CPF_CGC)) <> 14) or Isnull(ls_CPF_CGC) or Trim(ls_CPF_CGC) = ""  Then
				as_Log	= "O campo 'nr_cpf_cgc' est$$HEX1$$e100$$ENDHEX$$ com o tamanho diferente do tamanho esperado de 11 ou de 14 caracteres. N$$HEX1$$fa00$$ENDHEX$$mero de controle "+String(al_controle)+"."
				Return False
			End If
				
			lds_Cli_Cheque.of_AppendWhere("nr_cpf = '" + Trim(ls_CPF_CGC) + "'")
			
			ll_Linha_Cli = lds_Cli_Cheque.Retrieve()
							
			lds_Cli_Cheque.AcceptText()
			
			If ll_Linha_Cli < 0 Then
				as_log = "Erro ao recuperar o cliente cheque com o c$$HEX1$$f300$$ENDHEX$$digo SAP '" + ls_Cliente_SAP + "'"
				Return False
			End If
			
			// Cliente cheque n$$HEX1$$e300$$ENDHEX$$o existe
			If ll_Linha_Cli = 0 Then
				ll_Linha_Cli = lds_Cli_Cheque.InsertRow(0)
				If ll_Linha_Cli = -1 Then
					as_log = "Erro ao inserir uma nova linha na DW para o cliente cheque com o c$$HEX1$$f300$$ENDHEX$$digo SAP '" + ls_Cliente_SAP + "'"
					Return False
				End If
				
				lb_Cliente_Novo	= True
				
			ElseIf ll_Linha_Cli = 1 Then // atualiza$$HEX2$$e700e300$$ENDHEX$$o
				If lds_Cli_Cheque.Object.nr_cpf[1] <> ls_CPF_CGC Then
					as_Log	= "O campo 'nr_cpf_cgc' informado pelo SAP esta diferente do Sybase. N$$HEX1$$fa00$$ENDHEX$$mero de controle "+String(al_controle)+"."
					Return False
				End If
				ls_Codigo_Legado = lds_Cli_Cheque.Object.nr_cpf[ll_Linha_Cli]
				
				lb_Cliente_Novo	= False
				
			End If
			
			If Not wf_Contato_Cliente(lds_Cli_Cheque, ll_Linha_Cli, ls_Fisica_Juridica, ls_Tipo_Cliente, al_Tabela, al_Controle, Ref as_Log) Then
				Return False
			End If
			
			lds_Cli_Cheque.Object.nr_cpf							[ll_Linha_Cli] = ls_CPF_CGC
			If ls_Fisica_Juridica = 'F' Then
				lds_Cli_Cheque.Object.nm_cliente					[ll_Linha_Cli] = ls_Nome_Cliente+" "+ls_Sobrenome
			Else
				lds_Cli_Cheque.Object.nm_cliente					[ll_Linha_Cli] = ls_Razao_Social
			End If
			lds_Cli_Cheque.Object.nr_rg							[ll_Linha_Cli] = ls_RG
			lds_Cli_Cheque.Object.cd_cidade						[ll_Linha_Cli] = ll_Cidade
			lds_Cli_Cheque.Object.de_endereco					[ll_Linha_Cli] = ls_Endereco
			lds_Cli_Cheque.Object.de_bairro						[ll_Linha_Cli] = ls_Bairro
			lds_Cli_Cheque.Object.nr_cep							[ll_Linha_Cli] = ls_CEP
			lds_Cli_Cheque.Object.id_bloqueado					[ll_Linha_Cli] = 'N'
			If lb_Cliente_Novo Then
				lds_Cli_Cheque.Object.cd_filial_inclusao			[ll_Linha_Cli] = 2
			End If
			lds_Cli_Cheque.Object.cd_filial_atualizacao			[ll_Linha_Cli] = 2
			lds_Cli_Cheque.Object.dh_atualizacao				[ll_Linha_Cli] = gf_GetServerDate()
			lds_Cli_Cheque.Object.id_tipo_residencia			[ll_Linha_Cli] = ls_Tipo_Resid
			lds_Cli_Cheque.Object.nm_empresa					[ll_Linha_Cli] = ls_NM_Empresa
			lds_Cli_Cheque.Object.dh_nascimento				[ll_Linha_Cli] = ldt_Nascimento
			lds_Cli_Cheque.Object.nr_endereco					[ll_Linha_Cli] = ls_NR_Endereco
			lds_Cli_Cheque.Object.cd_cliente_sap				[ll_Linha_Cli] = ls_Cliente_SAP
			
			If Not wf_grava_historico(lds_Cli_Cheque, 'CLIENTE_CHEQUE', 'nr_cpf', ls_Codigo_Legado, Ref as_log) Then Return False
			If Not wf_grava_historico(lds_Cli_Cheque, 'CLIENTE_CHEQUE', 'nm_cliente', ls_Codigo_Legado, Ref as_log) Then Return False
			If Not wf_grava_historico(lds_Cli_Cheque, 'CLIENTE_CHEQUE', 'nr_rg', ls_Codigo_Legado, Ref as_log) Then Return False
			If Not wf_grava_historico(lds_Cli_Cheque, 'CLIENTE_CHEQUE', 'cd_cidade', ls_Codigo_Legado, Ref as_log) Then Return False
			If Not wf_grava_historico(lds_Cli_Cheque, 'CLIENTE_CHEQUE', 'de_endereco', ls_Codigo_Legado, Ref as_log) Then Return False
			If Not wf_grava_historico(lds_Cli_Cheque, 'CLIENTE_CHEQUE', 'de_bairro', ls_Codigo_Legado, Ref as_log) Then Return False
			If Not wf_grava_historico(lds_Cli_Cheque, 'CLIENTE_CHEQUE', 'nr_cep', ls_Codigo_Legado, Ref as_log) Then Return False	
			If Not wf_grava_historico(lds_Cli_Cheque, 'CLIENTE_CHEQUE', 'id_bloqueado', ls_Codigo_Legado, Ref as_log) Then Return False
			If Not wf_grava_historico(lds_Cli_Cheque, 'CLIENTE_CHEQUE', 'cd_filial_inclusao', ls_Codigo_Legado, Ref as_log) Then Return False
			If Not wf_grava_historico(lds_Cli_Cheque, 'CLIENTE_CHEQUE', 'cd_filial_atualizacao', ls_Codigo_Legado, Ref as_log) Then Return False
			If Not wf_grava_historico(lds_Cli_Cheque, 'CLIENTE_CHEQUE', 'dh_atualizacao', ls_Codigo_Legado, Ref as_log) Then Return False
			If Not wf_grava_historico(lds_Cli_Cheque, 'CLIENTE_CHEQUE', 'id_tipo_residencia', ls_Codigo_Legado, Ref as_log) Then Return False
			If Not wf_grava_historico(lds_Cli_Cheque, 'CLIENTE_CHEQUE', 'nm_empresa', ls_Codigo_Legado, Ref as_log) Then Return False
			If Not wf_grava_historico(lds_Cli_Cheque, 'CLIENTE_CHEQUE', 'dh_nascimento', ls_Codigo_Legado, Ref as_log) Then Return False
			If Not wf_grava_historico(lds_Cli_Cheque, 'CLIENTE_CHEQUE', 'nr_endereco', ls_Codigo_Legado, Ref as_log) Then Return False
			
			If Not wf_grava_historico(lds_Cli_Cheque, 'CLIENTE_CHEQUE', 'nr_ddd_telefone', ls_Codigo_Legado, Ref as_log) Then Return False
			If Not wf_grava_historico(lds_Cli_Cheque, 'CLIENTE_CHEQUE', 'nr_telefone', ls_Codigo_Legado, Ref as_log) Then Return False
			If Not wf_grava_historico(lds_Cli_Cheque, 'CLIENTE_CHEQUE', 'de_endereco_email', ls_Codigo_Legado, Ref as_log) Then Return False
			If Not wf_grava_historico(lds_Cli_Cheque, 'CLIENTE_CHEQUE', 'nr_ddd_celular', ls_Codigo_Legado, Ref as_log) Then Return False			
			If Not wf_grava_historico(lds_Cli_Cheque, 'CLIENTE_CHEQUE', 'nr_celular', ls_Codigo_Legado, Ref as_log) Then Return False
			If Not wf_grava_historico(lds_Cli_Cheque, 'CLIENTE_CHEQUE', 'nr_ddd_fone_recado', ls_Codigo_Legado, Ref as_log) Then Return False
			If Not wf_grava_historico(lds_Cli_Cheque, 'CLIENTE_CHEQUE', 'nr_fone_recado', ls_Codigo_Legado, Ref as_log) Then Return False
			
			If Not wf_grava_historico(lds_Cli_Cheque, 'CLIENTE_CHEQUE', 'cd_cliente_sap', ls_Codigo_Legado, Ref as_log) Then Return False

			If ll_Linha_Cli = 1 Then
				If lds_Cli_Cheque.Update() = 1  Then
					//Sqlca.of_Commit();
					Return True
				Else
					ls_Erro = SqlCa.SqlErrText
					//SqlCa.of_RollBack();
					as_log = "Erro ao atualizar o cliente cheque com o c$$HEX1$$f300$$ENDHEX$$digo SAP '" + ls_Cliente_SAP + "':" + ls_Erro
					Return False
				End If
			End If	
				
		Else	//Clientes

			If Not IsNull(ls_Codigo_Legado) and ls_Codigo_Legado <> "" Then
				lds_Cli.of_AppendWhere("c.cd_cliente = '" + ls_Codigo_Legado + "'")
			Else
				If (LenA(Trim(ls_CPF_CGC)) <> 11 and LenA(Trim(ls_CPF_CGC)) <> 14) or Isnull(ls_CPF_CGC) or Trim(ls_CPF_CGC) = ""  Then
					as_Log	= "O campo 'nr_cpf_cgc' est$$HEX1$$e100$$ENDHEX$$ com o tamanho diferente do tamanho esperado de 11 ou de 14 caracteres. N$$HEX1$$fa00$$ENDHEX$$mero de controle "+String(al_controle)+"."
					Return False
				End If
				
				lds_Cli.of_AppendWhere("c.nr_cpf_cgc = '" + Trim(ls_CPF_CGC) + "'")
			End If
							
			ll_Linha_Cli = lds_Cli.Retrieve()
							
			lds_Cli.AcceptText()
			
			If ll_Linha_Cli < 0 Then
				as_log = "Erro ao recuperar o cliente com o c$$HEX1$$f300$$ENDHEX$$digo SAP '" + ls_Cliente_SAP + "'"
				Return False
			End If
			
			// Cliente n$$HEX1$$e300$$ENDHEX$$o existe
			If ll_Linha_Cli = 0 Then
				ll_Linha_Cli = lds_Cli.InsertRow(0)
				If ll_Linha_Cli = -1 Then
					as_log = "Erro ao inserir uma nova linha na DW para o cliente com o c$$HEX1$$f300$$ENDHEX$$digo SAP '" + ls_Cliente_SAP + "'"
					Return False
				End If
				
				lb_Cliente_Novo	= True
				
			ElseIf ll_Linha_Cli = 1 Then // atualiza$$HEX2$$e700e300$$ENDHEX$$o
				If lds_Cli.Object.nr_cpf_cgc[1] <> ls_CPF_CGC Then
					as_Log	= "O campo 'nr_cpf_cgc' informado pelo SAP esta diferente do Sybase. N$$HEX1$$fa00$$ENDHEX$$mero de controle "+String(al_controle)+"."
					Return False
				End If
				
				ls_Codigo_Legado = lds_Cli.Object.cd_cliente[ll_Linha_Cli]			
				
				lb_Cliente_Novo	= False
			End If
				
			If Not wf_Contato_Cliente(lds_Cli, ll_Linha_Cli, ls_Fisica_Juridica, ls_Tipo_Cliente, al_Tabela, al_Controle, Ref as_Log) Then
				Return False
			End If
			
//			If ls_Fisica_Juridica = 'J' Then
//				If ldt_Nascimento = Date('01/01/1900') Then SetNull(ldt_Nascimento)
//			End If
												
			lds_Cli.Object.cd_cidade								[ll_Linha_Cli] = ll_Cidade
			lds_Cli.Object.cd_cliente								[ll_Linha_Cli] = ls_Codigo_Legado
			lds_Cli.Object.de_bairro								[ll_Linha_Cli] = ls_Bairro
			lds_Cli.Object.de_complemento					[ll_Linha_Cli] = ls_Complemento
			lds_Cli.Object.de_endereco							[ll_Linha_Cli] = ls_Endereco
			lds_Cli.Object.dh_nascimento						[ll_Linha_Cli] = ldt_Nascimento
			lds_Cli.Object.id_estado_civil						[ll_Linha_Cli] = ls_Estado_Civil
			lds_Cli.Object.id_fisica_juridica						[ll_Linha_Cli] = ls_Fisica_Juridica
			lds_Cli.Object.id_possui_filhos						[ll_Linha_Cli] = ls_Possui_Filhos
			lds_Cli.Object.id_sexo									[ll_Linha_Cli] = ls_Sexo
			lds_Cli.Object.id_tempo_empresa					[ll_Linha_Cli] = ls_Tempo_Empresa
			lds_Cli.Object.id_tempo_residencia				[ll_Linha_Cli] = ls_Tempo_Resid
			lds_Cli.Object.id_tipo_cliente						[ll_Linha_Cli] = ls_Tipo_Cliente
			
			If ls_Fisica_Juridica = 'F' Then
				lds_Cli.Object.nm_cliente						[ll_Linha_Cli] = ls_Nome_Cliente+" "+ls_Sobrenome
			Else
				lds_Cli.Object.nm_cliente						[ll_Linha_Cli] = ls_Nm_Fantasia
				lds_Cli.Object.nm_razao_social					[ll_Linha_Cli] = ls_Razao_Social
			End If
			
			lds_Cli.Object.nm_empresa							[ll_Linha_Cli] = ls_NM_Empresa
			lds_Cli.Object.nr_cep									[ll_Linha_Cli] = ls_CEP
			lds_Cli.Object.nr_cpf_cgc							[ll_Linha_Cli] = ls_CPF_CGC
			lds_Cli.Object.nr_endereco							[ll_Linha_Cli] = ls_NR_Endereco	
			lds_Cli.Object.nr_inscricao_estadual				[ll_Linha_Cli] = ls_IE	
			lds_Cli.Object.nr_rg									[ll_Linha_Cli] = ls_RG		
			lds_Cli.Object.id_tipo_residencia					[ll_Linha_Cli] = ls_Tipo_Resid
			
			lds_Cli.Object.cd_portador							[ll_Linha_Cli] = ll_Portador
			lds_Cli.Object.id_dono_farmacia					[ll_Linha_Cli] = ls_Dono_Farmacia
			lds_Cli.Object.id_medicamento_uso_continuo	[ll_Linha_Cli] = ls_Med_Uso_Continuo
			lds_Cli.Object.id_autoriza_comunicacao			[ll_Linha_Cli] = ls_Autoriza_Comun
			lds_Cli.Object.cd_cliente_sap						[ll_Linha_Cli] = ls_Cliente_SAP
			lds_Cli.Object.id_natureza_ocupacao				[ll_Linha_Cli] = ls_Nat_Ocupacao
					
			If lb_Cliente_Novo Then
				lds_Cli.Object.cd_filial_inclusao			[ll_Linha_Cli]	= 2
				lds_Cli.Object.nr_matricula_inclusao	[ll_Linha_Cli]	= '14330'
				lds_Cli.Object.dh_inclusao				[ll_Linha_Cli]	= gf_GetServerDate()				
			End If
			
			lds_Cli.Object.cd_filial_atualizacao			[ll_Linha_Cli] = 2
			lds_Cli.Object.nr_matricula_atualizacao	[ll_Linha_Cli] = '14330'
			lds_Cli.Object.dh_atualizacao				[ll_Linha_Cli] = gf_GetServerDate()
		
			If Not wf_grava_historico(lds_Cli, 'CLIENTE', 'cd_cidade', ls_Codigo_Legado, Ref as_log) Then Return False
			If Not wf_grava_historico(lds_Cli, 'CLIENTE', 'cd_cliente', ls_Codigo_Legado, Ref as_log) Then Return False
			If Not wf_grava_historico(lds_Cli, 'CLIENTE', 'de_bairro', ls_Codigo_Legado, Ref as_log) Then Return False
			If Not wf_grava_historico(lds_Cli, 'CLIENTE', 'de_complemento', ls_Codigo_Legado, Ref as_log) Then Return False
			If Not wf_grava_historico(lds_Cli, 'CLIENTE', 'de_endereco', ls_Codigo_Legado, Ref as_log) Then Return False
			If Not wf_grava_historico(lds_Cli, 'CLIENTE', 'dh_nascimento', ls_Codigo_Legado, Ref as_log) Then Return False
			If Not wf_grava_historico(lds_Cli, 'CLIENTE', 'id_estado_civil', ls_Codigo_Legado, Ref as_log) Then Return False
			If Not wf_grava_historico(lds_Cli, 'CLIENTE', 'id_fisica_juridica', ls_Codigo_Legado, Ref as_log) Then Return False
			If Not wf_grava_historico(lds_Cli, 'CLIENTE', 'id_possui_filhos', ls_Codigo_Legado, Ref as_log) Then Return False
			If Not wf_grava_historico(lds_Cli, 'CLIENTE', 'id_sexo', ls_Codigo_Legado, Ref as_log) Then Return False
			If Not wf_grava_historico(lds_Cli, 'CLIENTE', 'id_tempo_empresa', ls_Codigo_Legado, Ref as_log) Then Return False
			If Not wf_grava_historico(lds_Cli, 'CLIENTE', 'id_tempo_residencia', ls_Codigo_Legado, Ref as_log) Then Return False
			If Not wf_grava_historico(lds_Cli, 'CLIENTE', 'id_tipo_cliente', ls_Codigo_Legado, Ref as_log) Then Return False
			If Not wf_grava_historico(lds_Cli, 'CLIENTE', 'nm_cliente', ls_Codigo_Legado, Ref as_log) Then Return False
			If Not wf_grava_historico(lds_Cli, 'CLIENTE', 'nm_empresa', ls_Codigo_Legado, Ref as_log) Then Return False
			If Not wf_grava_historico(lds_Cli, 'CLIENTE', 'nm_razao_social', ls_Codigo_Legado, Ref as_log) Then Return False
			If Not wf_grava_historico(lds_Cli, 'CLIENTE', 'nr_cep', ls_Codigo_Legado, Ref as_log) Then Return False
			If Not wf_grava_historico(lds_Cli, 'CLIENTE', 'nr_cpf_cgc', ls_Codigo_Legado, Ref as_log) Then Return False
			If Not wf_grava_historico(lds_Cli, 'CLIENTE', 'nr_endereco', ls_Codigo_Legado, Ref as_log) Then Return False
			If Not wf_grava_historico(lds_Cli, 'CLIENTE', 'nr_inscricao_estadual', ls_Codigo_Legado, Ref as_log) Then Return False
			If Not wf_grava_historico(lds_Cli, 'CLIENTE', 'nr_rg', ls_Codigo_Legado, Ref as_log) Then Return False
			If Not wf_grava_historico(lds_Cli, 'CLIENTE', 'id_tipo_residencia', ls_Codigo_Legado, Ref as_log) Then Return False
			
			If Not wf_grava_historico(lds_Cli, 'CLIENTE', 'nr_ddd_fone_residencial', ls_Codigo_Legado, Ref as_log) Then Return False
			If Not wf_grava_historico(lds_Cli, 'CLIENTE', 'nr_fone_residencial', ls_Codigo_Legado, Ref as_log) Then Return False
			If Not wf_grava_historico(lds_Cli, 'CLIENTE', 'de_endereco_email', ls_Codigo_Legado, Ref as_log) Then Return False
			If Not wf_grava_historico(lds_Cli, 'CLIENTE', 'nr_ddd_celular', ls_Codigo_Legado, Ref as_log) Then Return False			
			If Not wf_grava_historico(lds_Cli, 'CLIENTE', 'nr_celular', ls_Codigo_Legado, Ref as_log) Then Return False
			If Not wf_grava_historico(lds_Cli, 'CLIENTE', 'nr_ddd_fone_recado', ls_Codigo_Legado, Ref as_log) Then Return False
			If Not wf_grava_historico(lds_Cli, 'CLIENTE', 'nr_fone_recado', ls_Codigo_Legado, Ref as_log) Then Return False
			
			If Not wf_grava_historico(lds_Cli, 'CLIENTE', 'cd_portador', ls_Codigo_Legado, Ref as_log) Then Return False
			If Not wf_grava_historico(lds_Cli, 'CLIENTE', 'id_dono_farmacia', ls_Codigo_Legado, Ref as_log) Then Return False
			If Not wf_grava_historico(lds_Cli, 'CLIENTE', 'id_medicamento_uso_continuo', ls_Codigo_Legado, Ref as_log) Then Return False
			If Not wf_grava_historico(lds_Cli, 'CLIENTE', 'id_autoriza_comunicacao', ls_Codigo_Legado, Ref as_log) Then Return False
			If Not wf_grava_historico(lds_Cli, 'CLIENTE', 'cd_cliente_sap', ls_Codigo_Legado, Ref as_log) Then Return False
			If Not wf_grava_historico(lds_Cli, 'CLIENTE', 'id_natureza_ocupacao', ls_Codigo_Legado, Ref as_log) Then Return False
						
			If Not wf_grava_historico(lds_Cli, 'CLIENTE', 'cd_filial_inclusao', ls_Codigo_Legado, Ref as_log) Then Return False
			If Not wf_grava_historico(lds_Cli, 'CLIENTE', 'nr_matricula_inclusao', ls_Codigo_Legado, Ref as_log) Then Return False
			If Not wf_grava_historico(lds_Cli, 'CLIENTE', 'dh_inclusao', ls_Codigo_Legado, Ref as_log) Then Return False
						
			If ll_Linha_Cli = 1 Then
				If lds_Cli.Update() = 1  Then
					//Sqlca.of_Commit();
					Return True
				Else
					ls_Erro = SqlCa.SqlErrText
					//SqlCa.of_RollBack();
					as_log = "Erro ao atualizar o cliente com o c$$HEX1$$f300$$ENDHEX$$digo SAP '" + ls_Cliente_SAP + "':" + ls_Erro
					Return False
				End If
			End If
		End If	
	ElseIf ll_Linhas = 0 Then
	Else
	End If
	
Catch (RuntimeError lo_rte)
	as_log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'wf_atualiza_cliente', objeto 'w_l018_carga_sap'. Erro: "+lo_rte.GetMessage()
	Return False
Finally
	If IsValid(lds) Then Destroy lds
	If IsValid(lds_Cli) Then Destroy lds_Cli
	If IsValid(lds_Cli_Cheque) Then Destroy lds_Cli_Cheque
End try

Return True
end function

public function boolean wf_grava_historico (dc_uo_ds_base ads_cliente, string as_tabela, string as_coluna, string as_chave, ref string as_log);String lvs_ValorDe, lvs_ValorPara

as_coluna = Upper(as_coluna)

If gf_Houve_Alteracao_ds(ads_cliente, as_coluna, 1, ref lvs_ValorDe, ref lvs_ValorPara ) Then
	If Not gf_Grava_Historico_Alteracao_Tabela(as_tabela, as_chave, as_coluna, lvs_ValorDe, lvs_ValorPara, 'SAP001', 'A', Ref as_log, True) Then Return False
End If

Return True
end function

public function boolean wf_retorna_cidade (string as_codigo_ibge, ref long al_cidade, ref string as_log);
Select  a.cd_cidade
Into :al_cidade
from cidade a
inner join ect_localidade b on b.nr_localidade = a.nr_localidade_ect
where b.cd_cidade_ibge = :as_codigo_ibge
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
		Select  min(cd_cidade)
		Into :al_cidade 
		from cidade
		where cd_cidade_ibge = :as_codigo_ibge
		Using SqlCa;
		
		Choose Case SqlCa.SqlCode
			Case 0
			Case 100
				as_Log = "N$$HEX1$$e300$$ENDHEX$$o foi localizado nenhuma cidade com o c$$HEX1$$f300$$ENDHEX$$digo IBGE '"+as_codigo_ibge+"'."
				Return False
			Case -1
				as_Log = "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o da cidade com o c$$HEX1$$f300$$ENDHEX$$digo IBGE '"+as_codigo_ibge+"' " + SqlCa.SqlerrText
				Return False
		End Choose
	Case -1
		as_Log = "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o da cidade com o c$$HEX1$$f300$$ENDHEX$$digo IBGE '"+as_codigo_ibge+"' " + SqlCa.SqlerrText
		Return False
End Choose

Return true



end function

public function boolean wf_retorna_estado_civil (string as_estado_de, ref string as_estado_para);Choose Case as_estado_de
	// SOLTEIRO	
	Case '1' ; as_estado_para = 'S'
	// CASADO	
	Case '2'  ; as_estado_para = 'C'
	// VIUVO	
	Case '3'; as_estado_para = 'V'
	// DIVORCIADO
	Case '4'; as_estado_para = 'D'
	Case '5'; as_estado_para = 'D'
	Case Else
		as_estado_para = 'O'
End Choose

Return True
		

		
		
end function

public function integer wf_retorna_telefones (string as_residencial, string as_celular, string as_residencial_ret, string as_celular_ret);Return 0
end function

public function boolean wf_verifica_codigo_de_para (long al_controle, string as_cd_tabela, string as_coluna, string as_cd_chave_sap, ref string as_cd_chave_legado, ref string as_log);If Trim(as_cd_chave_sap) = "" or IsNull(as_cd_chave_sap) Then
	SetNull(as_cd_chave_legado)
	Return True
End If

Select cd_chave_legado
Into :as_Cd_Chave_Legado
From integracao_sap
Where cd_empresa		= :ii_Empresa
	 and cd_tabela			= :as_Cd_Tabela
	 and cd_chave_sap	= :as_cd_chave_sap
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
		as_Log	= "N$$HEX1$$e300$$ENDHEX$$o foi localizado o [de->para] da empresa:[" + String(ii_Empresa) + "] - tabela:[" + as_Cd_Tabela + "] - chave legado:[" + as_Cd_Chave_Legado + "]. Coluna: "+as_Coluna
		Return False
	Case -1
		as_Log = "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do [de->para] da empresa:[" + String(ii_Empresa) + "] - tabela:[" + as_Cd_Tabela + "] - chave legado:[" + as_Cd_Chave_Legado + "]. Coluna '"+as_Coluna+"': " + SqlCa.SqlerrText
		Return False
End Choose

Return True
end function

public function boolean wf_verifica_obrigatoriedade_campo (long al_controle, string as_campo, string as_obrigatoriedade, string as_valor, ref string as_log);If as_obrigatoriedade = 'S' Then
	If IsNull(as_valor) or Trim(as_valor) = "" Then
		as_log = "Preechimento do campo '"+as_campo+"' $$HEX1$$e900$$ENDHEX$$ obrigat$$HEX1$$f300$$ENDHEX$$rio"
		Return False
	End If
End If

Return True


end function

public subroutine wf_grava_erro (long al_controle, string as_erro);String	ls_Erro

Update interface_sap
Set	de_erro		= :as_erro,
		id_situacao	= 'E' //Erro
Where nr_controle =:al_controle
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_Erro	=  SqlCa.SqlerrText
	MessageBox("Erro", "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do erro na tabela [interface_sap]: " +ls_Erro)
	SqlCa.of_Rollback()
	Return
End If

If SqlCa.SqlnRows = 0 Then 
	MessageBox("Erro", "Nenhum registro foi atualizado na tabela 'interface_sap'. Fun$$HEX2$$e700e300$$ENDHEX$$o 'wf_grava_erro'.")
	SqlCa.of_Rollback()
	Return
End If

If SqlCa.SqlnRows > 1 Then 
	MessageBox("Erro", "Foram encontrados mais de um registro para a atualiza$$HEX2$$e700e300$$ENDHEX$$o de erro para o controle '" + String(al_controle) + "'.")
	SqlCa.of_Rollback()
	Return
End If

SqlCa.of_Commit()
end subroutine

public function boolean wf_contato_cliente (ref dc_uo_ds_base ads_cli, long al_row_cli, string as_pessoa_fisica_juridica, string as_tipo_cliente, long al_tabela, long al_controle, ref string as_log);dc_uo_ds_base lds_Controle_Filho
dc_uo_ds_base	lds_Valores
dc_uo_ds_base	lds_Email
dc_uo_ds_base	lds_Telefone

Long	ll_Linha,&
		ll_Linhas,&
		ll_Tabela,&
		ll_Controle_Filho,&
		ll_Row,&
		ll_Rows,&
		ll_Item,&
		ll_Find
		
String	ls_Coluna,&
		ls_Vl_Item,&
		ls_Obrig,&
		ls_De_Email
		
Boolean	lb_Email_Xml = False		

Try
	lds_Controle_Filho = Create dc_uo_ds_base
	lds_Valores			= Create dc_uo_ds_base
	lds_Email			= Create dc_uo_ds_base
	lds_Telefone		= Create dc_uo_ds_base
	
	If Not lds_Controle_Filho.of_ChangeDataObject('ds_ge473_controle_filho', False) Then 
		as_log = "Erro ao alterar a DW [ds_ge473_controle_filho]."
		Return False
	End If
	
	If Not lds_Valores.of_ChangeDataObject('ds_ge473_lista_valores', False) Then 
		as_log = "Erro ao alterar a DW [ds_ge473_lista_valores]."
		Return False
	End If
	
	If Not lds_Email.of_ChangeDataObject('ds_ge473_email_cliente', False) Then 
		as_log = "Erro ao alterar a DW [ds_ge473_email_cliente]."
		Return False
	End If
	
	If Not lds_Telefone.of_ChangeDataObject('ds_ge473_telefone_cliente', False) Then 
		as_log = "Erro ao alterar a DW [ds_ge473_telefone_cliente]."
		Return False
	End If
	
	ll_Linhas	= lds_Controle_Filho.Retrieve(al_Tabela, al_Controle)
	
	If ll_Linhas < 0 Then
		as_log = "Erro no retrieve da DW [ds_ge473_controle_filho]."
		Return False
	End If
	
	If ll_Linhas > 0 Then
		For ll_Linha = 1 To ll_Linhas
			ll_Tabela				= lds_Controle_Filho.Object.cd_tabela	[ll_Linha]
			ll_Controle_Filho	= lds_Controle_Filho.Object.nr_controle	[ll_Linha]
			
			//Muda a situacao na interface
			Update interface_sap
			set id_situacao = 'P', dh_processamento = getdate() //Processado
			Where nr_controle = :ll_Controle_Filho
			Using SqlCa;
			
			If SqlCa.sqlcode = -1 Then
				as_Log	= "Erro ao mudar a situa$$HEX2$$e700e300$$ENDHEX$$o na tabela interface_sap. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle)+". Erro: "+SqlCa.sqlErrText
				Return False
			End If
						
			Choose Case ll_Tabela
				Case 21	//CLIENTE CARTAO CLUBE
					
				Case 22	//CLIENTE EMAIL
					ll_Rows = lds_Valores.Retrieve(ll_Controle_Filho)
						
					If ll_Rows < 0 Then
						as_log = "Erro no retrieve da DW [ds_ge473_lista_valores]."
						Return False
					End If
					
					If ll_Rows > 0 Then
						For ll_Row = 1 To ll_Rows
							ls_Coluna 	= lds_Valores.Object.cd_coluna				[ll_Row]
							ls_Vl_Item	= Upper(lds_Valores.Object.vl_item			[ll_Row])
							ls_Obrig		= lds_Valores.Object.id_obrigatorio			[ll_Row]
							ll_Item		= Long(lds_Valores.Object.nr_item			[ll_Row])
							
							If Lower(ls_Coluna) = 'de_email'	Then
								If Not wf_verifica_obrigatoriedade_campo(ll_Controle_Filho, ls_Coluna, ls_Obrig, ls_VL_Item, ref as_log) Then Return False
								
								lds_Email.Object.de_email[ll_Item] = Lower(ls_VL_Item)
							End If
							
							If Lower(ls_Coluna) = 'id_principal'	Then								
								lds_Email.Object.id_principal[ll_Item] = ls_VL_Item
							End If
							
							If Lower(ls_Coluna) = 'de_observacao'	Then								
								lds_Email.Object.de_observacao[ll_Item] = ls_VL_Item
							End If
						Next
					End If
					
					If as_Pessoa_Fisica_Juridica = "F" Then	//Pessoa f$$HEX1$$ed00$$ENDHEX$$sica
					
						ads_Cli.Object.de_endereco_email[al_Row_Cli] = lds_Email.Object.de_email[1]
					
					Else	//Pessoa jur$$HEX1$$ed00$$ENDHEX$$dica
						ll_Find	= lds_Email.Find("de_observacao = 'XML'", 1, lds_Email.RowCount())
						
						If ll_Find < 0 Then
							as_log = "Erro no find da 'ds_ge473_email_cliente' [de_observacao = XML]."
							Return False
						End If
						
						If ll_Find > 0 Then
							ads_Cli.Object.de_endereco_email_envio_xml	[al_Row_Cli] = lds_Email.Object.de_email[ll_Find]
						End If
						
						
						ll_Find	= lds_Email.Find("de_observacao <> 'XML'", 1, lds_Email.RowCount())
						
						If ll_Find < 0 Then
							as_log = "Erro no find da 'ds_ge473_email_cliente' [de_observacao = XML]."
							Return False
						End If
						
						If ll_Find > 0 Then
							ads_Cli.Object.de_endereco_email	[al_Row_Cli] = lds_Email.Object.de_email[ll_Find]
						End If						
					End If
					
				Case 23	//CLIENTE TELEFONE
					ll_Rows = lds_Valores.Retrieve(ll_Controle_Filho)
						
					If ll_Rows < 0 Then
						as_log = "Erro no retrieve da DW [ds_ge473_lista_valores]."
						Return False
					End If
					
					If ll_Rows > 0 Then
						For ll_Row = 1 To ll_Rows
							ls_Coluna 	= lds_Valores.Object.cd_coluna				[ll_Row]
							ls_Vl_Item	= Upper(lds_Valores.Object.vl_item			[ll_Row])
							ls_Obrig		= lds_Valores.Object.id_obrigatorio			[ll_Row]
							ll_Item		= Long(lds_Valores.Object.nr_item			[ll_Row])
							
							If Lower(ls_Coluna) = 'nr_telefone'	Then
								If Not wf_verifica_obrigatoriedade_campo(ll_Controle_Filho, ls_Coluna, ls_Obrig, ls_VL_Item, ref as_log) Then Return False
								
								lds_Telefone.Object.nr_telefone[ll_Item] = ls_VL_Item
							End If
							
							If Lower(ls_Coluna) = 'id_principal'	Then								
								lds_Telefone.Object.id_principal[ll_Item] = ls_VL_Item
							End If
							
							If Lower(ls_Coluna) = 'de_observacao'	Then								
								lds_Telefone.Object.de_observacao[ll_Item] = ls_VL_Item
							End If
							
							If Lower(ls_Coluna) = 'nr_telefone_extensao' Then
								lds_Telefone.Object.nr_telefone_extensao[ll_Item] = ls_VL_Item
							End If
							
							If Lower(ls_Coluna) = 'id_tipo' Then
								lds_Telefone.Object.id_tipo[ll_Item] = ls_VL_Item
							End If
						Next
					End If
					
					//Localiza telefone comercial
					ll_Find	= lds_Telefone.Find("de_observacao = 'COMERCIAL'", 1, lds_Telefone.RowCount())
						
					If ll_Find < 0 Then
						as_log = "Erro no find da 'ds_ge473_telefone_cliente' [de_observacao = XML]."
						Return False
					End If
					
					If ll_Find > 0 Then
						ads_Cli.Object.nr_ddd_fone_comercial	[al_Row_Cli] = Mid(lds_Telefone.Object.nr_telefone[ll_Find], 1, 2)
						ads_Cli.Object.nr_fone_comercial			[al_Row_Cli] = Mid(lds_Telefone.Object.nr_telefone[ll_Find], 4)
					End If
					
					//Localiza Celular
					ll_Find	= lds_Telefone.Find("id_tipo = 'C'", 1, lds_Telefone.RowCount())
						
					If ll_Find < 0 Then
						as_log = "Erro no find da 'ds_ge473_telefone_cliente' [de_observacao = XML]."
						Return False
					End If
					
					If ll_Find > 0 Then
						ads_Cli.Object.nr_ddd_celular				[al_Row_Cli] = Mid(lds_Telefone.Object.nr_telefone[ll_Find], 1, 2)
						ads_Cli.Object.nr_celular						[al_Row_Cli] = Mid(lds_Telefone.Object.nr_telefone[ll_Find], 4)
					End If
					
					//Localiza telefone Residencial
					ll_Find	= lds_Telefone.Find("id_tipo <> 'C' and de_observacao <> 'COMERCIAL'", 1, lds_Telefone.RowCount())
						
					If ll_Find < 0 Then
						as_log = "Erro no find da 'ds_ge473_telefone_cliente' [de_observacao = XML]."
						Return False
					End If
					
					If ll_Find > 0 Then
						If as_tipo_cliente = "CH" Then
							ads_Cli.Object.nr_ddd_telefone	[al_Row_Cli] = Mid(lds_Telefone.Object.nr_telefone[ll_Find], 1, 2)
							ads_Cli.Object.nr_telefone		[al_Row_Cli] = Mid(lds_Telefone.Object.nr_telefone[ll_Find], 4)
						Else
							ads_Cli.Object.nr_ddd_fone_residencial	[al_Row_Cli] = Mid(lds_Telefone.Object.nr_telefone[ll_Find], 1, 2)
							ads_Cli.Object.nr_fone_residencial		[al_Row_Cli] = Mid(lds_Telefone.Object.nr_telefone[ll_Find], 4)
						End If
					End If
					
					
					//Localiza telefone de recado
					ll_Find	= lds_Telefone.Find("id_tipo <> 'C' and de_observacao <> 'COMERCIAL'", ll_Find + 1, lds_Telefone.RowCount())
						
					If ll_Find < 0 Then
						as_log = "Erro no find da 'ds_ge473_telefone_cliente' [de_observacao = XML]."
						Return False
					End If
					
					If ll_Find > 0 Then
						ads_Cli.Object.nr_ddd_fone_recado		[al_Row_Cli] = Mid(lds_Telefone.Object.nr_telefone[ll_Find], 1, 2)
						ads_Cli.Object.nr_fone_recado				[al_Row_Cli] = Mid(lds_Telefone.Object.nr_telefone[ll_Find], 4)
					End If

			End Choose
			
			
		Next
	End If
	
Finally
	Destroy(lds_Controle_Filho)
	Destroy(lds_Valores)
	Destroy(lds_Email)
	Destroy(lds_Telefone)
End Try

Return True


end function

on w_ge473_interface_sap.create
int iCurrent
call super::create
end on

on w_ge473_interface_sap.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;DataWindowChild lvdwc

String ls_SQL

Long ll_Tabela_Defaut

Tab_1.TabPage_1.dw_1.AcceptText()

Tab_1.TabPage_1.dw_1.Object.dh_inicio[1] = relativedate(date(gf_GetServerDate()),- 5)
Tab_1.TabPage_1.dw_1.Object.dh_fim[1] = date(gf_GetServerDate())

If  gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = "GC" or gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = "CO" Then
	
	Choose Case gvo_Aplicacao.ivo_Seguranca.Cd_Sistema 
		Case "GC"; ll_Tabela_Defaut = 1 	// Produto
		Case "CO"; ll_Tabela_Defaut = 41 // Comiss$$HEX1$$e300$$ENDHEX$$o
	End Choose
		
	If Tab_1.TabPage_1.dw_1.GetChild("cd_tabela", lvdwc) = 1 Then
		
		lvdwc.SetTransObject(SQLCA)
					 
		ls_SQL	=	"SELECT	tabela_interface_sap.cd_tabela,  " +& 
						"tabela_interface_sap.de_tabela nm_tabela  " +& 
						"FROM tabela_interface_sap  " +& 
						"WHERE id_integra_legado = 'S'  " +& 
						"AND coalesce(id_tabela_pai, 'N') = 'S'  " +& 
					     "and id_subida_descida = 'D' " +&
  					    "and id_situacao = 'A' " +&
						"and cd_sistema in ('"+ gvo_Aplicacao.ivo_Seguranca.Cd_Sistema + "')"
		
		lvdwc.SetSQLSelect(ls_SQL)
			
		lvdwc.Retrieve()
		
		Tab_1.TabPage_1.dw_1.Object.cd_tabela[1] = ll_Tabela_Defaut

	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild tabelas.")
	End If
End If
end event

type dw_visual from dc_w_2tab_consulta_selecao_lista_det`dw_visual within w_ge473_interface_sap
end type

type gb_aux_visual from dc_w_2tab_consulta_selecao_lista_det`gb_aux_visual within w_ge473_interface_sap
end type

type tab_1 from dc_w_2tab_consulta_selecao_lista_det`tab_1 within w_ge473_interface_sap
integer width = 3781
integer height = 2196
end type

event tab_1::selectionchanged;//OverRide
end event

type tabpage_1 from dc_w_2tab_consulta_selecao_lista_det`tabpage_1 within tab_1
integer width = 3744
integer height = 2080
cb_1 cb_1
gb_4 gb_4
dw_4 dw_4
cb_cancelamento cb_cancelamento
end type

on tabpage_1.create
this.cb_1=create cb_1
this.gb_4=create gb_4
this.dw_4=create dw_4
this.cb_cancelamento=create cb_cancelamento
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.gb_4
this.Control[iCurrent+3]=this.dw_4
this.Control[iCurrent+4]=this.cb_cancelamento
end on

on tabpage_1.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.gb_4)
destroy(this.dw_4)
destroy(this.cb_cancelamento)
end on

type gb_2 from dc_w_2tab_consulta_selecao_lista_det`gb_2 within tabpage_1
integer y = 360
integer width = 3698
integer height = 1328
end type

type gb_1 from dc_w_2tab_consulta_selecao_lista_det`gb_1 within tabpage_1
integer width = 3054
integer height = 328
end type

type dw_1 from dc_w_2tab_consulta_selecao_lista_det`dw_1 within tabpage_1
integer x = 59
integer width = 3003
integer height = 244
string dataobject = "dw_ge473_selecao"
end type

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)
end event

type dw_2 from dc_w_2tab_consulta_selecao_lista_det`dw_2 within tabpage_1
integer x = 50
integer y = 432
integer width = 3648
integer height = 1240
string dataobject = "dw_ge473_lista"
end type

event dw_2::ue_recuperar;//OverRide
Long	ll_Tabela,&
		ll_Index_SubQuery,&
		ll_Controle		

String	ls_Situacao
String ls_Ch_Legado
String ls_Ch_SAP

DateTime	ldh_Inicio,&
				ldh_Fim

This.of_RestoreOriginalSQL()

dw_1.AcceptText()

ldh_Inicio		= dw_1.Object.dh_inicio				[1]
ldh_Fim			= dw_1.Object.dh_fim				[1]
ll_Tabela			= dw_1.Object.cd_tabela			[1]
ls_Situacao		= dw_1.Object.id_situacao			[1]
ls_Ch_Legado	= dw_1.Object.cd_chave_legado	[1]
ls_Ch_SAP		= dw_1.Object.cd_chave_sap		[1]
ll_Controle		= dw_1.Object.nr_controle			[1]

ll_Index_SubQuery	= 22

If IsNull(ll_Tabela)	Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione a tabela.")
	dw_1.SetColumn("cd_tabela")
	Return 1
End If

If Not IsNull(ldh_Inicio) and Not IsNull(ldh_Fim) Then
	If ldh_Inicio > ldh_Fim Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data inicial n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a data final.")
		dw_1.SetColumn("dh_inicio")
		Return 1
	End If
End If

If Not IsNull(ldh_Inicio) Then
	This.of_AppendWhere_SubQuery("i.dh_inclusao >= '"+String(ldh_Inicio, "yyyymmdd")+"'", ll_Index_SubQuery)
End If

If Not IsNull(ldh_Fim) Then
	This.of_AppendWhere_SubQuery("i.dh_inclusao <= '"+String(ldh_Fim, "yyyymmdd 23:59:59")+"'", ll_Index_SubQuery)
End If


If Not IsNull(ll_Tabela) and (ll_Tabela <> 0) Then
	This.of_AppendWhere_SubQuery("i.cd_tabela = "+String(ll_Tabela), ll_Index_SubQuery)
End If

If Not Isnull(ll_Controle) and ll_Controle > 0 Then
	This.of_AppendWhere_SubQuery("i.nr_controle = "+String(ll_Controle), ll_Index_SubQuery)
End If

If ls_Situacao <> "T" Then
	If ls_Situacao = 'CE' Then //COLOCADO ou ERRO
		This.of_AppendWhere_SubQuery("i.id_situacao in ('C', 'E')", ll_Index_SubQuery)
	Else
		This.of_AppendWhere_SubQuery("i.id_situacao = '"+ls_Situacao+"'", ll_Index_SubQuery)
	End If
End If

If Not IsNull(ls_Ch_SAP)  and Trim(ls_Ch_SAP) <> '' Then
	This.of_AppendWhere_SubQuery("i.de_chave_sap like '%"+ ls_Ch_SAP +"'", ll_Index_SubQuery)
End If

If Not IsNull(ls_Ch_Legado)  and Trim(ls_Ch_Legado) <> '' Then
	This.of_AppendWhere_SubQuery(" exists (select * from interface_sap_item it " +&
												"where it.nr_controle = i.nr_controle " +&
												"and it.cd_coluna = 'cd_produto_legado' " +&
												"and cast(it.vl_item as varchar) = '" + ls_Ch_Legado + "')", ll_Index_SubQuery)
End If

//interface_sap

//messagebox("", String(This.Object.Datawindow.Table.Select))
	
Return This.Retrieve()
end event

event dw_2::doubleclicked;call super::doubleclicked;String	lvs_Marcacao

Long	ll_Row

If dwo.Name = 'id_imagem' Then
	If ivb_Check Then
		lvs_Marcacao = 'N'
		ivb_Check = False
	Else
		lvs_Marcacao = 'S'
		ivb_Check = True
	End If
	
	For ll_Row = 1 To This.RowCount()
				
		If lvs_Marcacao = 'S' Then
			If This.Object.id_situacao[ll_Row] = 'C' or This.Object.id_situacao[ll_Row] = 'E'  Then
				This.Object.id_processa[ll_Row] = lvs_Marcacao
			End If
		Else
			This.Object.id_processa[ll_Row] = lvs_Marcacao
		End If
	
	Next
	
End If		
end event

event dw_2::rowfocuschanged;call super::rowfocuschanged;If currentRow > 0 Then
	Tab_1.TabPage_1.dw_4.Object.de_erro[1] = This.Object.de_erro[currentRow]
End If
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 then
	cb_cancelamento.Enabled = True
Else
	cb_cancelamento.Enabled = False
End If

Return pl_Linhas
end event

type tabpage_2 from dc_w_2tab_consulta_selecao_lista_det`tabpage_2 within tab_1
integer width = 3744
integer height = 2080
end type

type gb_3 from dc_w_2tab_consulta_selecao_lista_det`gb_3 within tabpage_2
integer x = 5
integer width = 4014
integer height = 1788
end type

type dw_3 from dc_w_2tab_consulta_selecao_lista_det`dw_3 within tabpage_2
integer x = 41
integer width = 3653
integer height = 1692
string dataobject = "dw_ge473_detalhe"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event dw_3::ue_retrieve;//OverRide

Long	ll_Controle

ll_Controle	= Tab_1.TabPage_1.dw_2.Object.nr_controle	[Tab_1.TabPage_1.dw_2.GetRow()]

Return This.Retrieve(ll_Controle)
end event

type cb_1 from commandbutton within tabpage_1
integer x = 3209
integer y = 236
integer width = 512
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Executar"
end type

event clicked;//id_processa

Long ll_Itens_Selec

ll_Itens_Selec = tab_1.TabPage_1.dw_2.GetItemNumber(tab_1.TabPage_1.dw_2.RowCount(), "qt_total_selecionado")

If ll_Itens_Selec = 0 Then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Nenhum registro foi selecionado.')
	Return
End If

If MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Cofirma a atualiza$$HEX2$$e700e300$$ENDHEX$$o dos itens selecionados ?', Question!, YesNo!, 2) = 2 Then Return 

Open(w_Aguarde)

w_Aguarde.title = 'Atualizando o Sybase...'

wf_processa()

Close(w_Aguarde)

tab_1.TabPage_1.dw_2.Event ue_Recuperar()


end event

type gb_4 from groupbox within tabpage_1
integer x = 23
integer y = 1708
integer width = 3698
integer height = 272
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Erro"
end type

type dw_4 from dc_uo_dw_base within tabpage_1
integer x = 59
integer y = 1776
integer width = 3607
integer height = 156
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge473_erro"
boolean hscrollbar = true
end type

type cb_cancelamento from commandbutton within tabpage_1
integer x = 3209
integer y = 132
integer width = 512
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Cancelar"
end type

event clicked;Long ll_Tabela
Long ll_Linha
Long ll_Linhas
Long ll_Controle

String ls_Situacao
String ls_MSG
String ls_Motivo

tab_1.TabPage_1.dw_2.AcceptText()

ll_Linhas = tab_1.TabPage_1.dw_2.RowCount()

If ll_Linhas = 0 Then Return

ll_Tabela		= tab_1.TabPage_1.dw_1.Object.cd_tabela		[1]
ls_Situacao 	= tab_1.TabPage_1.dw_1.Object.id_situacao	[1]

If ll_Tabela = 0 or IsNull(ll_Tabela) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma tabela.", Exclamation!)
	Return
End If

If ls_Situacao = 'X' or ls_Situacao = 'T' or ls_Situacao = 'P' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione a situa$$HEX2$$e700e300$$ENDHEX$$o COLOCADO ou com ERRO.", Exclamation!)
	Return
End If

If tab_1.TabPage_1.dw_2.GetItemNumber(tab_1.TabPage_1.dw_2.RowCount(), "qt_total_selecionado") = 0 Then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Nenhum registro foi selecionado.')
	Return
End If

If MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Confirma o CANCELAMENTO do processamento dos itens selecionados ?', Question!, YesNo!, 2) = 2 Then Return 

try
		
	OpenWithParm(w_ge473_motivo_cancelamento,"")
	ls_Motivo = Message.StringParm
		
	If IsNull(ls_Motivo) Then Return	
	
	ls_Motivo = ' Motivo Canc.: ' + gvo_Aplicacao.ivo_Seguranca.Nr_Matricula + ' (usu$$HEX1$$e100$$ENDHEX$$rio)  - ' + ls_Motivo
	
	Open(w_Aguarde)
	w_aguarde.uo_progress.of_setmax(ll_Linhas)
	
	w_Aguarde.Title = "Cancelando os itens selecionados..."
	
	For ll_Linha = 1 To ll_Linhas
		
		If tab_1.TabPage_1.dw_2.Object.id_processa[ll_Linha] = 'S' Then
			
			ll_Controle	= tab_1.TabPage_1.dw_2.Object.nr_controle[ll_Linha]
			
			Update interface_sap
			Set id_situacao = 'X', dh_processamento = getdate(), de_erro = (Case when de_erro is null Then :ls_Motivo else de_erro + :ls_Motivo END)
			Where nr_controle = :ll_Controle
				and id_situacao <> 'P'
			Using SqlCa;
			
			If SqlCa.Sqlcode = -1 Then
				ls_MSG = "Erro ao cancelar o processamento do controle [" + String(ll_Controle) + "]. Erro: "+ SqlCa.SqlErrText
				SqlCa.of_Rollback( )
				Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_MSG)
				Return 			
			End If
			
			SqlCa.of_Commit();
			
		End If
	
		w_aguarde.uo_progress.of_setprogress(ll_Linha)
	Next
	
	tab_1.TabPage_1.dw_2.Event ue_Retrieve()

finally
	Close(w_Aguarde)
end try







end event

