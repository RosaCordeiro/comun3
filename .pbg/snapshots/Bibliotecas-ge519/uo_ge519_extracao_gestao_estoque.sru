HA$PBExportHeader$uo_ge519_extracao_gestao_estoque.sru
forward
global type uo_ge519_extracao_gestao_estoque from nonvisualobject
end type
end forward

global type uo_ge519_extracao_gestao_estoque from nonvisualobject
end type
global uo_ge519_extracao_gestao_estoque uo_ge519_extracao_gestao_estoque

type variables
Date adh_inicio, adh_termino, adh_ontem
Date adt_gera_dados
Datetime  adt_hoje
Datetime  adt_tempo
Date adt_saldo
Date adt_ini_movimento , adt_fim_movimento

Time adt_horario

Boolean lb_geracao_arquivo1 = False 
Boolean lb_geracao_arquivo2 = False 
Boolean lb_geracao_arquivo3 = False 
Boolean lb_geracao_arquivo4 = False 
Boolean lb_geracao_arquivo5 = False 

String is_Dir_Arquivo_Pedido_Distribuidora 
String is_Dir_Arquivo_CompraAcimaAceitavel
String is_Dir_Arquivo_FaltaFilial
String is_Dir_Arquivo_UltimaCompra
String is_Data_Prox_ult_entrada
string is_Dir_Arquivo_Excesso_Estoque

String is_Separador = ";"
String is_Log

uo_pedido_empurrado io_pedido //GE198






end variables

forward prototypes
public function boolean of_busca_datas ()
public function boolean of_atualiza_datas ()
public function boolean of_processa_extracao ()
public function boolean of_gerar_extrair_ped_distrib ()
public function boolean of_gerar_extrair_compras_acima_aceitavel ()
public function boolean of_gerar_faltas_vendas ()
public function boolean of_gerar_ultimas_entradas ()
public function boolean of_carrega_movimentacoes (long al_filial, long al_produto, ref date adt_ultima_entrada, ref string as_tipo, ref string as_motivo_entrada, datastore as_datastore)
public function boolean of_atualiza_tempo (string as_tipo)
public function boolean of_gerar_excesso_estoque ()
public function any of_null (any a_valor, any a_default)
public function boolean of_ultima_entrada_loja_produto (long al_filial, long al_produto, date al_data, ref long al_dias)
public subroutine of_envia_email (string as_tipo)
public function boolean of_gerar_ultimas_entradas_pentaho ()
public function boolean of_gerar_excesso_estoque_pentaho ()
end prototypes

public function boolean of_busca_datas ();Boolean lb_data_inicio = False
Boolean lb_data_termino = False
Boolean lb_data_geracao  = False

adt_hoje	= gvo_Parametro.of_Dh_Movimentacao()
adt_saldo = gf_primeiro_dia_mes(Date(adt_hoje))


// Data de Inicio :  Data do Parametro ou Completa 
Select  vl_parametro
Into 	  :adh_inicio
From    parametro_geral
Where  cd_parametro = 'DH_INICIO_EXTRACAO_GE'
Using SqlCA;
	
If SqlCa.SqlCode = -1 Then
	is_Log	= "Erro ao localizar a proxima data: uo_ge519_extracao_gestao_estoque.of_busca_datas()." + " Erro: "+ SqlCa.SqlErrText
	gvo_aplicacao.of_grava_log(is_Log)			
	lb_data_inicio = False
Else
	lb_data_inicio = true 
End If 


// Data de Termino Carga
Select  vl_parametro
Into 	 :adh_termino
From   parametro_geral
Where cd_parametro = 'DH_TERMINO_EXTRACAO_GE'
Using SqlCA;

If SqlCa.SqlCode = -1 Then
	is_Log	= "Erro ao localizar a proxima data: uo_ge519_extracao_gestao_estoque.of_busca_datas()." + " Erro: "+ SqlCa.SqlErrText
	gvo_aplicacao.of_grava_log(is_Log)			
	lb_data_termino = False
Else
	lb_data_termino = true 
End If 


If lb_data_termino  and lb_data_inicio  Then 
	Return True 
Else 
	Return False
End If 




end function

public function boolean of_atualiza_datas ();String ls_dta_atualiza

ls_dta_atualiza = String ( RelativeDate (     Date (gf_GetServerDate()),-0), "yyyy-mm-dd")

Update parametro_geral
Set  vl_parametro =:ls_dta_atualiza
where cd_parametro  = 'DH_INICIO_EXTRACAO_GE'
Using SqlCA;

If SqlCa.sqlcode = -1 Then
	is_Log	= "Erro na atualizacao parametro :  DH_INICIO_EXTRACAO_GE'. Erro: "+SqlCa.sqlErrText	
	Return False
End If 

Update parametro_geral
Set  vl_parametro =:ls_dta_atualiza
where cd_parametro  = 'DH_TERMINO_EXTRACAO_GE'
Using SqlCA;

If SqlCa.sqlcode = -1 Then
	is_Log	= "Erro na atualizacao parametro :  DH_TERMINO_EXTRACAO_GE'. Erro: "+SqlCa.sqlErrText
	Return False
End If 



SqlCa.of_Commit()	
Return True 


end function

public function boolean of_processa_extracao ();String ls_Carga, &
		ls_Host

// Busca Data Inicial
If Not This.of_busca_datas() Then 
	is_Log = "Erro na busca de Datas:uo_ge519_extracao_gestao_estoque"
	gvo_aplicacao.of_grava_log(is_Log)
	Return False
End If 

dc_uo_api lo_API
lo_API = Create dc_uo_Api

ls_Host = lo_API.of_getip_host( lo_API.of_get_Host())

Destroy(lo_Api )

If ls_Host = "10.0.4.35" or ls_Host = "172.18.15.26" Then
	This.of_gerar_ultimas_entradas_pentaho()
	
//	Altera$$HEX2$$e700e300$$ENDHEX$$o para gera$$HEX2$$e700e300$$ENDHEX$$o di$$HEX1$$e100$$ENDHEX$$ria.. 16-02-2024 - Douglas/chamado: 1730653	
//	//  Sempre PrimeiroDia do M$$HEX1$$ea00$$ENDHEX$$s
//	If Date(adt_hoje)  =  Date(adt_saldo)  Then 
		This.of_gerar_excesso_estoque_pentaho()
//	End If 
	
Else
	//////// Primeiro Extra$$HEX2$$e700e300$$ENDHEX$$o
	If This.of_gerar_extrair_ped_distrib()  Then 
		If This.of_gerar_extrair_compras_acima_aceitavel() Then 
				If This.of_gerar_ultimas_entradas() Then 	
					lb_geracao_arquivo1 = True
				End If			
		End If
	End If 
	
	// Quinta  Extra$$HEX2$$e700e300$$ENDHEX$$o:  Sempre PrimeiroDia do M$$HEX1$$ea00$$ENDHEX$$s
	If Date(adt_hoje)  =  Date(adt_saldo)  Then 
		If  This.of_gerar_excesso_estoque() Then 
			lb_geracao_arquivo2 = True	
		End If 	
	End If 
	
	// Atualiza Data Termino
	If Not This.of_atualiza_datas() Then 
		is_Log = "Erro na atualizacao de Datas:uo_ge519_extracao_gestao_estoque"
		gvo_aplicacao.of_grava_log(is_Log)
		Return False
	End If 
	
	// Envio email
	If lb_geracao_arquivo1 or lb_geracao_arquivo2 Then 
		This.of_envia_email('S')
	Else
		This.of_envia_email('E')
	End If 
End If

Return True 
end function

public function boolean of_gerar_extrair_ped_distrib ();Long ll_Linhas, ll_Linha,  ll_qt_pedida,  ll_qt_atendida,  ll_qt_faturada,  ll_qt_falta, ll_qt_estoque_disponivel_distrib
Long ll_Filial, ll_Nr_pedido,  ll_nr_rodada, li_Retorno, li_Arq, li_Ret, ll_cd_produto, ll_qtd_dias_movto  
String lvs_motivo_rejeicao_pedido, lvs_motivo_rejeicao_produto, lvs_Data_Pedido, lvs_cd_distribuidora, lvs_cd_unidade_federacao
String lvs_Arquivo, lvs_Registro, lvs_situacao, lvs_data
String  lvdh_reinauguracao

lvs_data = String ( RelativeDate (     Date (gf_GetServerDate()),-1), "yyyy-mm-dd")

dc_uo_ds_Base lvds_1

Try 
	
	If Not IsValid(w_aguarde) then
			Open(w_aguarde)
	End If	
		
	//  Local Onde Grava
	is_Dir_Arquivo_Pedido_Distribuidora = ProfileString(gvo_aplicacao.ivs_arquivo_ini,"GE", "Arquivos_GE", gvo_aplicacao.ivs_path_arquivos+"\Arquivos_GE")
	If Not DirectoryExists(is_Dir_Arquivo_Pedido_Distribuidora) Then CreateDirectory(is_Dir_Arquivo_Pedido_Distribuidora)
	// Nome do Arquivo
	lvs_Arquivo =  is_Dir_Arquivo_Pedido_Distribuidora + "\PEDIDO_"+  lvs_data  + ".txt"

	
	If FileExists (lvs_Arquivo) Then
		li_Retorno = 1 
		Choose Case li_Retorno
			Case 1
				If Not FileDelete ( lvs_Arquivo ) Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao excluir o arquivo '" + lvs_Arquivo + "'.", StopSign!)
					gvo_aplicacao.of_grava_log("GE - Extra$$HEX2$$e700e300$$ENDHEX$$o Pedidos - Erro ao excluir o arquivo")
					Return False
				End If
			Case 2
				Return True
			Case 3
				gvo_aplicacao.of_grava_log("GE - Extra$$HEX2$$e700e300$$ENDHEX$$o Pedidos - Erro ao excluir o arquivo")
				Return False
		End Choose
	End If
	
	li_Arq = FileOpen(lvs_Arquivo, LineMode!, Write!, LockReadWrite!, Append!, EncodingANSI!)
	
	If li_Arq = -1 Then
		gvo_aplicacao.of_grava_log("GE - Extra$$HEX2$$e700e300$$ENDHEX$$o Pedidos - Erro ao abrir o arquivo")
		Return False
	End If
	
	// Dados Consulta
	lvds_1 = Create dc_uo_ds_Base
	If Not lvds_1.of_ChangeDataObject("ds_ge519_extracao_ped_distrib", False) Then 
		is_Log = "Extra$$HEX2$$e700e300$$ENDHEX$$o Gestao Estoque - Erro na ds_ge519_extracao_ped_distrib"
		gvo_aplicacao.of_grava_log(is_Log)
		Return False	
	End If 
	
	
	// Recuperar Dados
	lvds_1.Retrieve( adh_inicio , adh_termino   )
	ll_Linhas = lvds_1.rowcount( )
	
	Choose case ll_Linhas
		case is > 0
			// Cabe$$HEX1$$e700$$ENDHEX$$alho do Arquivo
			lvs_Registro = 	"ID"+ is_Separador +&
								"CD_DISTRIBUIDORA" + is_Separador +&
								"CD_FILIAL" + is_Separador +&
								"CD_PRODUTO" + is_Separador +&
								"NR_PEDIDO" + is_Separador +&
								"DATA" + is_Separador +&
								"QT_PEDIDA" + is_Separador +&						
								"QT_ATENDIDA" + is_Separador +&						
								"QT_FATURADA" + is_Separador +&						
								"QT_FALTA" + is_Separador +&						
								"QT_ESTOQUE_DISP_DISTRIB" + is_Separador +&						
								"REJEICAO_PEDIDO"  + is_Separador +&						
								"REJEICAO_PRODUTO" + is_Separador +&
								"NR_RODADA"  + is_Separador +&
								"CD_UF" + is_Separador +&
								"DATA_INAUGURA"
															
			li_Ret = FileWrite(li_Arq, lvs_Registro)
				
			If IsNull(li_Ret) or li_Ret <= 0 Then
				gvo_aplicacao.of_grava_log("CLIC - Extra$$HEX2$$e700e300$$ENDHEX$$o Pedidos - Erro ao gravar registro cabe$$HEX1$$e700$$ENDHEX$$alho")
				Return False			
			End If		
		
			/// Aguarde...	
			w_aguarde.Title = "[GE] - Extra$$HEX2$$e700e300$$ENDHEX$$oDadosPedido :"
			w_aguarde.uo_progress.of_reset()
			w_aguarde.uo_progress.Of_SetMax(ll_Linhas)			
	
			// Lopp para Montar Arquivo
			For ll_Linha  = 1 To ll_Linhas  
				
				// Campos o Arquivo
				ll_cd_produto							= lvds_1.object.cd_produto[ll_Linha]
				ll_Filial 									= lvds_1.object.cd_filial[ll_Linha]
				ll_Nr_pedido 							= lvds_1.object.nr_pedido_distribuidora[ll_Linha]
				ll_nr_rodada 							= lvds_1.object.nr_rodada[ll_Linha]
				ll_qt_pedida								= lvds_1.object.qt_pedida[ll_Linha]
				ll_qt_atendida  							= lvds_1.object.qt_atendida[ll_Linha]
				ll_qt_faturada 							= lvds_1.object.qt_faturada[ll_Linha]
				ll_qt_falta  								= lvds_1.object.qt_falta[ll_Linha]
				ll_qt_estoque_disponivel_distrib	= lvds_1.object.qt_estoque_disponivel_distrib[ll_Linha]
				lvs_cd_distribuidora 					= Trim(lvds_1.object.cd_distribuidora[ll_Linha])

				// Trataivas
				lvs_motivo_rejeicao_pedido 		= Trim(lvds_1.object.de_motivo_rejeicao_pedido[ll_Linha])
				lvs_motivo_rejeicao_produto 		= Trim(lvds_1.object.de_motivo_rejeicao_produto[ll_Linha])
				lvs_motivo_rejeicao_pedido  		=  gf_retira_caracteres_especiais(gf_retira_acentos(lvs_motivo_rejeicao_pedido))
				lvs_motivo_rejeicao_produto		=  gf_retira_caracteres_especiais(gf_retira_acentos(lvs_motivo_rejeicao_produto))
				
				
				lvs_Data_Pedido 						=	Trim(String(Date(lvds_1.object.dh_emissao[ll_Linha]))) 
				lvs_cd_unidade_federacao			=	lvds_1.object.cd_unidade_federacao[ll_Linha]	
				lvdh_reinauguracao   					=	Trim(String(Date(lvds_1.object.dh_reinauguracao[ll_Linha])))
				If IsNull(lvdh_reinauguracao) then lvdh_reinauguracao =""
								
				w_aguarde.Title =  "[GE] - Extra$$HEX2$$e700e300$$ENDHEX$$oDadosPedidos: Linha: " + String(ll_Linha)+" De:"+String(ll_Linhas)				
			
				// Linhas do Arquivo
				lvs_Registro =  String(ll_Linha) + is_Separador +& 
									String(lvs_cd_distribuidora) + is_Separador +&
									String(ll_filial)  + is_Separador +&
									String(ll_cd_produto)  + is_Separador +&
									String(ll_Nr_pedido) + is_Separador +&
									String(lvs_Data_Pedido) + is_Separador +&
									String(ll_qt_pedida)	+ is_Separador +&
									String(ll_qt_atendida)  + is_Separador +&	
									String(ll_qt_faturada) 	 + is_Separador +&						
									String(ll_qt_falta)  + is_Separador +&								
									String(ll_qt_estoque_disponivel_distrib)+ is_Separador +&								
									String(lvs_motivo_rejeicao_pedido)+ is_Separador +&								
									String(lvs_motivo_rejeicao_produto)+ is_Separador +&								
									String(ll_nr_rodada) + is_Separador +&								
									String(lvs_cd_unidade_federacao)+ is_Separador +&								
									String(lvdh_reinauguracao)
									
					// Dados dos Produtos
					li_Ret = FileWrite(li_Arq, lvs_Registro)					
							
					If IsNull(li_Ret) or li_Ret <= 0 Then
						gvo_aplicacao.of_grava_log("GE - Extra$$HEX2$$e700e300$$ENDHEX$$o Dados Pedidos - Erro no Arquivo")
						Return False
					End If								
				w_aguarde.uo_progress.Of_SetProgress(ll_Linha)					
			Next 	
		case 0
			gvo_aplicacao.of_grava_log("GE - Extra$$HEX2$$e700e300$$ENDHEX$$o Dados Pedido - Sem Registro")
		case is < 0
			gvo_aplicacao.of_grava_log("GE - Extra$$HEX2$$e700e300$$ENDHEX$$o Dados Pedido - Erro no retrieve do datastore")
	End Choose
Finally		
	FileClose (li_Arq)
	If IsValid(w_aguarde) then Close(w_aguarde)
	Destroy (lvds_1)
	Return True 	
End Try
end function

public function boolean of_gerar_extrair_compras_acima_aceitavel ();String lvs_dh_emissao, &
		lvs_id_bloq_compra_maior_limite,&
		lvs_de_produto,&
		lvs_Registro,&
		lvs_Arquivo,&
		lvs_cd_distribuidora,&		
		lvs_data
		

Long  ll_cd_produto,&
		ll_cd_filial,&
		ll_cd_filial_ref_preco_venda, &
		ll_qt_pedida,&
		ll_qt_faturada,&
		ll_nr_prioridade, &		
		ll_Linhas,&
		ll_Linha,&
		li_Retorno, &
		li_Arq,&
		li_Ret

Decimal {2} ldc_vl_fator_conversao
Decimal {2} ldc_vl_preco
Decimal {2} ldc_pc_desconto
Decimal {2} ldc_pc_repasse_icms
Decimal {2} ldc_vl_icms_st
Decimal {2} ldc_vl_preco_compra
Decimal {2} ldc_preco_venda_filial
Decimal {2} ldc_pc_diferenca
Decimal {2} ldc_Preco_Liquido

dc_uo_ds_Base lvds_1

lvs_data = String ( RelativeDate (     Date (gf_GetServerDate()),-1), "yyyy-mm-dd")

Try 
	
	If Not IsValid(w_aguarde) then
			Open(w_aguarde)
	End If	
		
	//  Local Onde Grava
	is_Dir_Arquivo_CompraAcimaAceitavel = ProfileString(gvo_aplicacao.ivs_arquivo_ini,"GE", "Arquivos_GE", gvo_aplicacao.ivs_path_arquivos+"\Arquivos_GE")
	If Not DirectoryExists(is_Dir_Arquivo_CompraAcimaAceitavel) Then CreateDirectory(is_Dir_Arquivo_CompraAcimaAceitavel)
	// Nome do Arquivo
	lvs_Arquivo =  is_Dir_Arquivo_CompraAcimaAceitavel + "\COMPRA_ACIMA_ACEITAVEL_"+ lvs_data  + ".txt"
	
	If FileExists (lvs_Arquivo) Then
		li_Retorno = 1 
		Choose Case li_Retorno
			Case 1
				If Not FileDelete ( lvs_Arquivo ) Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao excluir o arquivo '" + lvs_Arquivo + "'.", StopSign!)
					gvo_aplicacao.of_grava_log("GE - Extra$$HEX2$$e700e300$$ENDHEX$$o Pedidos - Erro ao excluir o arquivo")
					Return False
				End If
			Case 2
				Return True
			Case 3
				gvo_aplicacao.of_grava_log("GE - Extra$$HEX2$$e700e300$$ENDHEX$$o Pedidos - Erro ao excluir o arquivo")
				Return False
		End Choose
	End If
	
	li_Arq = FileOpen(lvs_Arquivo, LineMode!, Write!, LockReadWrite!, Append!, EncodingANSI!)
	
	If li_Arq = -1 Then
		gvo_aplicacao.of_grava_log("GE - Extra$$HEX2$$e700e300$$ENDHEX$$o Pedidos - Erro ao abrir o arquivo")
		Return False
	End If
	
	// Dados Consulta
	lvds_1 = Create dc_uo_ds_Base
	If Not lvds_1.of_ChangeDataObject("ds_ge519_extracao_compra_acim_aceitavel", False) Then 
		is_Log = "Extra$$HEX2$$e700e300$$ENDHEX$$o Gestao Estoque - Erro na ds_ge519_extracao_compra_acim_aceitavel"
		gvo_aplicacao.of_grava_log(is_Log)
		Return False	
	End If 
	
	
	// Recuperar Dados
	lvds_1.Retrieve( adh_inicio, adh_termino)
	ll_Linhas = lvds_1.rowcount( )
	
	Choose case ll_Linhas
		case is > 0
			
			// Cabe$$HEX1$$e700$$ENDHEX$$alho do Arquivo
			lvs_Registro = "DH_EMISSAO" + is_Separador +&
			"ID_BLOQ_COMPRA_MAIOR_LIMITE" + is_Separador +&
			"CD_PRODUTO" + is_Separador +&	
			"VL_FATOR_CONVERSAO" + is_Separador +&
			"CD_FILIAL" + is_Separador +&
			"CD_FILIAL_REF_PRECO_VENDA" + is_Separador +&	
			"QT_PEDIDA" + is_Separador +&	
			"QT_FATURADA" + is_Separador +&	
			"NR_PRIORIDADE" + is_Separador +&	
			"CD_DISTRIBUIDORA" + is_Separador +&		
			"VL_PRECO" + is_Separador +&	
			"PC_DESCONTO" + is_Separador +&	
			"PC_REPASSE_ICMS" + is_Separador +&	
			"VL_ICMS_ST" + is_Separador +&	
			"VL_PRECO_COMPRA" + is_Separador +&	
			"VL_PRECO_VENDA_FILIAL" + is_Separador +&	
			"PC_DIFERENCA"
															
				li_Ret = FileWrite(li_Arq, lvs_Registro)
					
				If IsNull(li_Ret) or li_Ret <= 0 Then
					gvo_aplicacao.of_grava_log("CLIC - Extra$$HEX2$$e700e300$$ENDHEX$$o Pedidos - Erro ao gravar registro cabe$$HEX1$$e700$$ENDHEX$$alho")
					Return False			
				End If		
			
				/// Aguarde...	
				w_aguarde.Title = "[GE] - Extra$$HEX2$$e700e300$$ENDHEX$$oDadosComprasAcimaAceitavel"
				w_aguarde.uo_progress.of_reset()
				w_aguarde.uo_progress.Of_SetMax(ll_Linhas)			
				
				// Lopp para Montar Arquivo
				For ll_Linha  = 1 To ll_Linhas  
					
					lvs_dh_emissao = String(Date(lvds_1.object.dh_emissao[ll_Linha])) 
					lvs_id_bloq_compra_maior_limite = lvds_1.object.id_bloq_compra_maior_limite[ll_Linha]
					
					ll_cd_produto= lvds_1.object.cd_produto[ll_Linha]
					ll_cd_filial= lvds_1.object.cd_filial[ll_Linha]
					ll_cd_filial_ref_preco_venda= lvds_1.object.cd_filial_ref_preco_venda[ll_Linha]
					ll_qt_pedida= lvds_1.object.qt_pedida[ll_Linha]
					ll_qt_faturada= lvds_1.object.qt_faturada[ll_Linha]
					ll_nr_prioridade= lvds_1.object.nr_prioridade[ll_Linha]
					lvs_cd_distribuidora= lvds_1.object.cd_distribuidora[ll_Linha]
		
						 ldc_vl_fator_conversao = lvds_1.object.vl_fator_conversao[ll_Linha] 
					 ldc_vl_preco= lvds_1.object.vl_preco[ll_Linha] 
					ldc_pc_desconto= lvds_1.object.pc_desconto[ll_Linha] 
					ldc_pc_repasse_icms= lvds_1.object.pc_repasse_icms[ll_Linha]
					ldc_vl_icms_st= lvds_1.object.vl_icms_st[ll_Linha]
					ldc_vl_preco_compra= lvds_1.object.vl_preco_compra[ll_Linha]
					ldc_preco_venda_filial= lvds_1.object.vl_preco_venda_filial[ll_Linha]
					ldc_pc_diferenca= lvds_1.object.pc_diferenca[ll_Linha]		
					
					
					w_aguarde.Title =  "[GE] - Extra$$HEX2$$e700e300$$ENDHEX$$oDadosPedidos: Linha: " + String(ll_Linha)+" De:"+String(ll_Linhas)				
				
			
					// Linhas do Arquivo
					lvs_Registro =  String(lvs_dh_emissao) + is_Separador +&
										String(lvs_id_bloq_compra_maior_limite)  + is_Separador +&
										String(ll_cd_produto)  + is_Separador +&
										String(ll_cd_filial) + is_Separador +&
										String(ll_cd_filial_ref_preco_venda) + is_Separador +&							
										String(ll_qt_pedida) + is_Separador +&
										String(ll_qt_faturada) + is_Separador +&
										String(ll_nr_prioridade) + is_Separador +&																
										String(lvs_cd_distribuidora) + is_Separador +&			
										String(ldc_vl_preco) + is_Separador +&																																
										String(ldc_pc_desconto) + is_Separador +&																																
										String(ldc_pc_repasse_icms) + is_Separador +&																																														
										String(ldc_vl_icms_st) + is_Separador +&																																
										String(ldc_vl_preco_compra) + is_Separador +&																																
										String(ldc_preco_venda_filial) + is_Separador +&																																
										String(ldc_pc_diferenca)
										
				
			
										
						// Dados dos Produtos
						li_Ret = FileWrite(li_Arq, lvs_Registro)					
								
						If IsNull(li_Ret) or li_Ret <= 0 Then
							gvo_aplicacao.of_grava_log("GE - Extra$$HEX2$$e700e300$$ENDHEX$$o Dados Pedidos - Erro no Arquivo")
							Return False
						End If				
				
					w_aguarde.uo_progress.Of_SetProgress(ll_Linha)					
				Next 	
		case 0
			gvo_aplicacao.of_grava_log("GE - Extra$$HEX2$$e700e300$$ENDHEX$$o Dados de Compra Acima do Aceit$$HEX1$$e100$$ENDHEX$$vel - Sem Registro")
		case is < 0
			gvo_aplicacao.of_grava_log("GE - Extra$$HEX2$$e700e300$$ENDHEX$$o Dados de Compra Acima do Aceit$$HEX1$$e100$$ENDHEX$$vel - Erro no datastore")
	End choose
Finally		
	FileClose (li_Arq)
	If IsValid(w_aguarde) then Close(w_aguarde)
	Destroy (lvds_1)
	
	Return True 
	
End Try
end function

public function boolean of_gerar_faltas_vendas ();String lvs_cd_curva_abc_filiais,&
		lvs_Arquivo,&
		lvs_Registro,&
		lvs_data

Date  ldt_movimentacao

Long  ll_cd_produto,&
		ll_cd_filial,&
		ll_qt_consulta,&
		ll_qt_venda,&
		ll_Linhas,&
		ll_Linha,&
		li_Retorno, &
		li_Arq,&
		li_Ret

// Conforme Chamado : 1590216 :  Corre$$HEX2$$e700e300$$ENDHEX$$o Extra$$HEX2$$e700e300$$ENDHEX$$o de Dados		
// Solicitado Descontinuar esse processo
Return True		
		

lvs_data = String ( RelativeDate (     Date (gf_GetServerDate()),-1), "yyyy-mm-dd")

dc_uo_ds_Base lvds_1

Try 
	
	If Not IsValid(w_aguarde) then
			Open(w_aguarde)
	End If	
		
	//  Local Onde Grava
	is_Dir_Arquivo_FaltaFilial = ProfileString(gvo_aplicacao.ivs_arquivo_ini,"GE", "Arquivos_GE", gvo_aplicacao.ivs_path_arquivos+"\Arquivos_GE")
	If Not DirectoryExists(is_Dir_Arquivo_FaltaFilial) Then CreateDirectory(is_Dir_Arquivo_FaltaFilial)
	// Nome do Arquivo
	lvs_Arquivo =  is_Dir_Arquivo_FaltaFilial + "\FALTAS_"+  lvs_data + ".txt"
	
	If FileExists (lvs_Arquivo) Then
		li_Retorno = 1 
		Choose Case li_Retorno
			Case 1
				If Not FileDelete ( lvs_Arquivo ) Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao excluir o arquivo '" + lvs_Arquivo + "'.", StopSign!)
					gvo_aplicacao.of_grava_log("GE - Extra$$HEX2$$e700e300$$ENDHEX$$o Faltas Vendas - Erro ao excluir o arquivo")
					Return False
				End If
			Case 2
				Return True
			Case 3
				gvo_aplicacao.of_grava_log("GE - Extra$$HEX2$$e700e300$$ENDHEX$$o Faltas Vendas - Erro ao excluir o arquivo")
				Return False
		End Choose
	End If
	
	li_Arq = FileOpen(lvs_Arquivo, LineMode!, Write!, LockReadWrite!, Append!, EncodingANSI!)
	
	If li_Arq = -1 Then
		gvo_aplicacao.of_grava_log("GE - Extra$$HEX2$$e700e300$$ENDHEX$$o Faltas Vendas - Erro ao abrir o arquivo")
		Return False
	End If
	

	// Dados Consulta: Vendas
	lvds_1 = Create dc_uo_ds_Base
	If Not lvds_1.of_ChangeDataObject("ds_ge519_extracao_faltas_vendas", False) Then 
		is_Log = "Extra$$HEX2$$e700e300$$ENDHEX$$o Gestao Estoque - Erro na ds_ge519_extracao_faltas_vendas"
		gvo_aplicacao.of_grava_log(is_Log)
		Return False	
	End If 
	
	
	lvds_1.Retrieve( adh_inicio, adh_termino)
	ll_Linhas = lvds_1.rowcount() 
	
	Choose case ll_Linhas
		case is > 0
		
			// Cabe$$HEX1$$e700$$ENDHEX$$alho do Arquivo
			lvs_Registro =	"DH_MOVIMENTO" + is_Separador +&
			"CD_FILIAL" + is_Separador +&
			"CD_PRODUTO" + is_Separador +&	
			"CURVA" + is_Separador +&
			"QT_CONSULTA" + is_Separador +&
			"QT_VENDA"
			
			li_Ret = FileWrite(li_Arq, lvs_Registro)
				
			If IsNull(li_Ret) or li_Ret <= 0 Then
				gvo_aplicacao.of_grava_log("GE - Extra$$HEX2$$e700e300$$ENDHEX$$o Faltas Vendas - Erro ao gravar registro cabe$$HEX1$$e700$$ENDHEX$$alho")
				Return False			
			End If		
		
			/// Aguarde...	
			w_aguarde.Title = "[GE] - Extra$$HEX2$$e700e300$$ENDHEX$$oDadosFaltasVendas"
			w_aguarde.uo_progress.of_reset()
			w_aguarde.uo_progress.Of_SetMax(ll_Linhas)			
			
			// Lopp para Montar Arquivo
			For ll_linha  = 1 To ll_Linhas  				
				w_aguarde.Title =  "[GE] - Extra$$HEX2$$e700e300$$ENDHEX$$oDadosFaltasVendas: Linha: " + String(ll_Linha)+" De:"+String(ll_Linhas)				
			
				ll_cd_produto		= lvds_1.object.cd_produto[ll_Linha]
				ll_cd_filial 			= lvds_1.object.cd_filial[ll_Linha]
				ldt_movimentacao = Date(lvds_1.object.dt_venda[ll_Linha])
				lvs_cd_curva_abc_filiais		= Trim(String(lvds_1.object.cd_curva_abc_filiais[ll_Linha]))
				ll_qt_venda =  lvds_1.object.qt_venda[ll_Linha]
				ll_qt_consulta =  lvds_1.object.qt_consulta [ll_Linha]
			
				//// Linhas do Arquivo
				lvs_Registro =  String(Date(ldt_movimentacao)) + is_Separador +&
									String(ll_cd_filial) + is_Separador +&
									String(ll_cd_produto)  + is_Separador +&
									String(lvs_cd_curva_abc_filiais) + is_Separador +&							
									String(ll_qt_consulta) + is_Separador +&
									String(ll_qt_venda) 
			
					// Dados dos Produtos
					li_Ret = FileWrite(li_Arq, lvs_Registro)					
							
					If IsNull(li_Ret) or li_Ret <= 0 Then
						gvo_aplicacao.of_grava_log("GE - Extra$$HEX2$$e700e300$$ENDHEX$$o Faltas Vendas - Erro no Arquivo")
						Return False
					End If				
			
				w_aguarde.uo_progress.Of_SetProgress(ll_Linha)					
			Next 	
		case 0
			gvo_aplicacao.of_grava_log("GE - Extra$$HEX2$$e700e300$$ENDHEX$$o Faltas Vendas - Sem Registro")
		case is < 0
			gvo_aplicacao.of_grava_log("GE - Extra$$HEX2$$e700e300$$ENDHEX$$o Faltas Vendas - Erro no retrieve do datastore")
	End choose
Finally		
	FileClose (li_Arq)
	If IsValid(w_aguarde) then Close(w_aguarde)
	Destroy (lvds_1)
	Return True 	
End Try
end function

public function boolean of_gerar_ultimas_entradas ();String lvs_Registro,&
		lvs_Arquivo,&	
		lvs_Arquivo_Pentaho, &
		lvs_data,&
		lvs_dh_ultima_entrada,&
		lvs_tipo_entrada,&
		lvs_de_motivo_entrada,&
		lvs_nr_matricula,&
		lvs_nm_responsavel,&
		lvs_de_motivo_alteracao, &
		lvs_Dir_Arquivo_UltimaCompra_Pentaho

Long  ll_cd_produto,&
		ll_cd_filial,&
		ll_qt_saldo,&
		ll_Linhas,&
		ll_Linha,&
		li_Retorno, &
		li_Arq,&
		li_Ret

Date ldt_Ultima_Entrada

dc_uo_ds_Base lvds_1
dc_uo_ds_Base lvds_2

lvs_data = String ( RelativeDate (     Date (gf_GetServerDate()),-1), "yyyy-mm-dd")

Try 
	
	If Not IsValid(w_aguarde) then
			Open(w_aguarde)
	End If	
	
	adh_termino = adh_inicio
	
	//  Local Onde Grava
	is_Dir_Arquivo_UltimaCompra = ProfileString(gvo_aplicacao.ivs_arquivo_ini,"GE", "Arquivos_GE", gvo_aplicacao.ivs_path_arquivos+"\Arquivos_GE")
	If Not DirectoryExists(is_Dir_Arquivo_UltimaCompra) Then CreateDirectory(is_Dir_Arquivo_UltimaCompra)
	// Nome do Arquivo
	lvs_Arquivo =  is_Dir_Arquivo_UltimaCompra + "\ULT_ENTR_PRODUTO_FILIAL_"+ lvs_data  + ".txt"

	If FileExists (lvs_Arquivo) Then
		li_Retorno = 1 
		Choose Case li_Retorno
			Case 1
				If Not FileDelete ( lvs_Arquivo ) Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao excluir o arquivo '" + lvs_Arquivo + "'.", StopSign!)
					gvo_aplicacao.of_grava_log("GE - Ultimas Entradas - Erro ao excluir o arquivo")
					Return False
				End If
			Case 2
				Return True
			Case 3
				gvo_aplicacao.of_grava_log("GE - Ultimas Entradas - Erro ao excluir o arquivo")
				Return False
		End Choose
	End If
	
	li_Arq = FileOpen(lvs_Arquivo, LineMode!, Write!, LockReadWrite!, Append!, EncodingANSI!)
	
	If li_Arq = -1 Then
		gvo_aplicacao.of_grava_log("GE - Ultimas Entradas - Erro ao abrir o arquivo")
		Return False
	End If
	
	// Dados Consulta: Principal
	lvds_1 = Create dc_uo_ds_Base
	If Not lvds_1.of_ChangeDataObject("ds_ge519_lista_gestao_est", False) Then 
		is_Log = "Extra$$HEX2$$e700e300$$ENDHEX$$o Gestao Estoque - Erro na ds_ge519_lista_gestao_est"
		gvo_aplicacao.of_grava_log(is_Log)
		Return False	
	End If 
	
	// Dados Consulta: Movimentos
	lvds_2 = Create dc_uo_ds_Base
	If Not lvds_2.of_ChangeDataObject("ds_ge519_lista_gestao_est_movimento", False) Then 
		is_Log = "Extra$$HEX2$$e700e300$$ENDHEX$$o Gestao Estoque - Erro na ds_ge519_lista_gestao_est_movimento"
		gvo_aplicacao.of_grava_log(is_Log)
		Return False	
	End If 	

	// Recuperar Dados
	lvds_1.Retrieve(adt_saldo,  Datetime(Date(adh_inicio),Time("00:00:00"))  , Datetime(Date(adh_termino),Time("23:59:59")))

	ll_Linhas = lvds_1.rowcount( )
	
	Choose case ll_Linhas
		case is > 0
		
			lvds_2.Retrieve(Datetime(Date(adh_inicio),Time("00:00:00")),    Datetime(Date(adh_termino),Time("23:59:59"))    )
		
			// Cabe$$HEX1$$e700$$ENDHEX$$alho do Arquivo
			lvs_Registro = "CD_FILIAL" + is_Separador +&
			"CD_PRODUTO" + is_Separador +&
			"QT_SALDO" + is_Separador +&	
			"DH_ULTIMA_ENTRADA" + is_Separador +&
			"TIPO_ENTRADA" + is_Separador +&
			"DE_MOTIVO_ENTRADA" + is_Separador +&
			"NR_MATRICULA" + is_Separador +&	
			"NM_RESPONSAVEL" + is_Separador +&	
			"DE_MOTIVO_ALTERACAO"
														
			li_Ret = FileWrite(li_Arq, lvs_Registro)
				
			If IsNull(li_Ret) or li_Ret <= 0 Then
				gvo_aplicacao.of_grava_log("CLIC - Extra$$HEX2$$e700e300$$ENDHEX$$o Ultimas Entradas - Erro ao gravar registro cabe$$HEX1$$e700$$ENDHEX$$alho")
				Return False			
			End If		
		
			/// Aguarde...	
			w_aguarde.Title = "[GE] - Extra$$HEX2$$e700e300$$ENDHEX$$o Ultimas Entradas "
			w_aguarde.uo_progress.of_reset()
			w_aguarde.uo_progress.Of_SetMax(ll_Linhas)			
			
			// Lopp para Montar Arquivo
			For ll_Linha  = 1 To ll_Linhas  
				
				ll_cd_produto= lvds_1.object.cd_produto[ll_Linha]
				ll_cd_filial= lvds_1.object.cd_filial[ll_Linha]
				ll_qt_saldo= lvds_1.object.qt_saldo[ll_Linha]
				lvs_nr_matricula =    lvds_1.object.nr_matricula_alteracao[ll_Linha]
				lvs_nm_responsavel =    lvds_1.object.nm_responsavel[ll_Linha] 
				lvs_de_motivo_alteracao  = lvds_1.object.de_motivo_alteracao[ll_Linha]   
				
				If IsNull(lvs_nr_matricula) then lvs_nr_matricula=""
				If IsNull(lvs_nm_responsavel) then lvs_nm_responsavel=""
				If IsNull(lvs_de_motivo_alteracao) then lvs_de_motivo_alteracao=""		
				
				// Carrega dados Movimento
				If Not This.of_carrega_movimentacoes (ll_cd_filial,& 
															ll_cd_produto,& 
															Ref ldt_Ultima_Entrada,&
															Ref lvs_tipo_entrada,&
															Ref lvs_de_motivo_entrada,&
															lvds_2 ) Then Return False
				
				w_aguarde.Title =   "[GE] - Extra$$HEX2$$e700e300$$ENDHEX$$o Ultimas Entradas : " + String(ll_Linha)+" De:"+String(ll_Linhas)				
			
				If IsNull(ldt_Ultima_Entrada) Then ldt_Ultima_Entrada=1900-01-01
				If IsNull(lvs_de_motivo_entrada) Then lvs_de_motivo_entrada = ""
				If IsNull(lvs_tipo_entrada) Then lvs_tipo_entrada=""
		
				// Linhas do Arquivo
				lvs_Registro =  String(ll_cd_filial) + is_Separador +&
									String(ll_cd_produto)  + is_Separador +&
									String(ll_qt_saldo) + is_Separador +&
									String(ldt_Ultima_Entrada, 'dd/mm/yyyy')+is_Separador + &
									String(lvs_tipo_entrada)+is_Separador+&
									String(lvs_de_motivo_entrada)+is_Separador+&
									String(lvs_nr_matricula)+is_Separador+&
									String(lvs_nm_responsavel)+is_Separador+&
									String(lvs_de_motivo_alteracao)
		
									
					// Dados dos Produtos
					li_Ret = FileWrite(li_Arq, lvs_Registro)					
							
					If IsNull(li_Ret) or li_Ret <= 0 Then
						gvo_aplicacao.of_grava_log("GE - Extra$$HEX2$$e700e300$$ENDHEX$$o Ultimas Entradas - Erro no Arquivo")
						Return False
					End If				
			
				w_aguarde.uo_progress.Of_SetProgress(ll_Linha)					
			Next 	
		case 0
			gvo_aplicacao.of_grava_log("GE - Extra$$HEX2$$e700e300$$ENDHEX$$o Ultimas Entradas - Sem Registro")
		case is < 0
			gvo_aplicacao.of_grava_log("GE - Extra$$HEX2$$e700e300$$ENDHEX$$o Ultimas Entradas - Erro no retrieve do datastore")
	End choose
Finally		
	FileClose (li_Arq)
	If IsValid(w_aguarde) then Close(w_aguarde)
	Destroy (lvds_1)
	Destroy (lvds_2)	
	
	Return True 
	
End Try
end function

public function boolean of_carrega_movimentacoes (long al_filial, long al_produto, ref date adt_ultima_entrada, ref string as_tipo, ref string as_motivo_entrada, datastore as_datastore);Long ll_Ped_Dist
Long ll_Nr_Nf
Long ll_Filial
Long ll_Pedido_Dist
Long ll_Pedido_Fil
Long ll_Promocao
Long ll_Ped_Emp
Long ll_Find
Long ll_Tipo

String ls_Especie
String ls_Serie
String ls_Fornecedor
String ls_Promocao
String ls_Motivo_Empurrado
String ls_Id_Tipo_Pedido

SetNull(as_Tipo)
SetNull(adt_ultima_entrada)
SetNull(as_Motivo_Entrada)

ll_Find = as_datastore.Find("cd_filial_movimento = " + String(al_Filial) + " and cd_produto = " + String(al_Produto), 1, as_datastore.RowCount())

If ll_Find < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Find da dw_3 para a filial " + String(al_Filial) + " e produto " + String(al_Produto))
	Return False
End If

If ll_Find > 0 Then
	ll_Filial 					= as_datastore.Object.Cd_Filial					[ll_Find]
	ls_Fornecedor 			= as_datastore.Object.Cd_Fornecedor			[ll_Find]
	ll_Nr_Nf 					= as_datastore.Object.Nr_Nf						[ll_Find]
	ls_Especie 				= as_datastore.Object.De_Especie					[ll_Find]
	ls_Serie 					= as_datastore.Object.De_Serie					[ll_Find]
	adt_Ultima_Entrada	= Date(as_datastore.Object.Dh_Movimento	[ll_Find])
	ll_Tipo 					= as_datastore.Object.Cd_Tipo_Movimento		[ll_Find]
	as_Tipo 					= as_datastore.Object.De_Tipo_Movimento		[ll_Find]
End If

If ll_Find = 0 Then Return True

If ll_Tipo = 3 Then
	
	Select Top 1 b.nr_pedido_empurrado, p.cd_promocao_sos, s.nm_promocao_sos
		Into :ll_Ped_Emp, :ll_Promocao, :ls_Promocao
	from pedido_distribuidora a
	inner join pedido_distribuidora_produto b
		on b.cd_filial = a.cd_filial
		and b.nr_pedido_distribuidora = a.nr_pedido_distribuidora
	inner join pedido_filial_produto p
		on p.cd_filial = a.cd_filial	
		and p.nr_pedido_filial = a.nr_pedido_filial
		and p.cd_produto = b.cd_produto
	left outer join promocao_sos s
		on s.cd_promocao_sos = p.cd_promocao_sos
	where a.cd_filial 						= :al_Filial
	  and b.cd_produto    					= :al_Produto
	  and a.nr_pedido_filial 				in (Select z.nr_pedido_filial
														From nf_compra x
															inner join pedido_distribuidora y
																on y.cd_filial = x.cd_filial
																and y.nr_pedido_distribuidora = x.nr_pedido_distribuidora
															inner join pedido_distribuidora_produto pp
																on pp.cd_filial = a.cd_filial
																and pp.nr_pedido_distribuidora = b.nr_pedido_distribuidora
																and pp.cd_produto = b.cd_produto
															inner join pedido_filial z
																on z.cd_filial = x.cd_filial
																and z.nr_pedido_filial = y.nr_pedido_filial
														Where x.cd_filial = :al_Filial
															And x.cd_fornecedor = :ls_Fornecedor
															And x.nr_nf = :ll_Nr_Nf
															And x.de_especie = :ls_Especie
															And x.de_serie = :ls_Serie)
													Using SqlCa;
													
Else
													
	Select Top 1 b.nr_pedido_empurrado, p.cd_promocao_sos, s.nm_promocao_sos
		Into :ll_Ped_Emp, :ll_Promocao, :ls_Promocao
	from pedido_distribuidora a
	inner join pedido_distribuidora_produto b
		on b.cd_filial = a.cd_filial
		and b.nr_pedido_distribuidora = a.nr_pedido_distribuidora
	inner join pedido_filial_produto p
		on p.cd_filial = a.cd_filial	
		and p.nr_pedido_filial = a.nr_pedido_filial
		and p.cd_produto = b.cd_produto
	left outer join promocao_sos s
		on s.cd_promocao_sos = p.cd_promocao_sos
	where a.cd_filial 						= :al_Filial
	  and b.cd_produto    					= :al_Produto
	  and a.nr_pedido_filial 				in (Select z.nr_pedido_filial
														From nf_transferencia x
															inner join pedido_distribuidora y
																on y.cd_filial = x.cd_filial_destino
																and y.nr_pedido_distribuidora = x.nr_pedido_distribuidora
															inner join pedido_distribuidora_produto pp
																on pp.cd_filial = a.cd_filial
																and pp.nr_pedido_distribuidora = b.nr_pedido_distribuidora
																and pp.cd_produto = b.cd_produto
															inner join pedido_filial z
																on z.cd_filial = x.cd_filial_destino
																and z.nr_pedido_filial = y.nr_pedido_filial
														Where x.cd_filial_origem = :ll_Filial
															And x.nr_nf = :ll_Nr_Nf
															And x.de_especie = :ls_Especie
															And x.de_serie = :ls_Serie
                                                            		And x.cd_filial_destino = :al_Filial)
													Using SqlCa;
													
End If

If SqlCa.SqlCode = - 1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao consultar o c$$HEX1$$f300$$ENDHEX$$digo da promo$$HEX2$$e700e300$$ENDHEX$$o e o n$$HEX1$$fa00$$ENDHEX$$mero do pedido empurrado para o produto " + String(al_Produto) + ". Fun$$HEX2$$e700e300$$ENDHEX$$o wf_preenche_campos. " + SqlCa.SqlErrText, StopSign!)
	Return False
End If

If ll_Ped_Emp > 0 Or ll_Promocao > 0 Then
	If ll_Ped_Emp > 0 Then
		If not io_Pedido.of_localiza_motivo(al_Filial,ll_Ped_Emp, al_produto, Ref ls_Motivo_Empurrado, Ref ls_Id_Tipo_Pedido) Then Return False
			If ls_Id_Tipo_Pedido = 'U' Then
				as_Motivo_Entrada = 'PEDIDO URGENTE'
			Else	
				as_Motivo_Entrada = "PEDIDO EMPURRADO - " + ls_Motivo_Empurrado
			End If
	End If
	
	If ll_Promocao > 0 Then
		as_Motivo_Entrada = "PROMO$$HEX2$$c700c300$$ENDHEX$$O - " + ls_Promocao + " (" + String(ll_Promocao) + ")"
	End If

Else
	as_Motivo_Entrada = "ESTOQUE BASE"
End If
end function

public function boolean of_atualiza_tempo (string as_tipo);adt_tempo  = gf_GetServerDate()

Choose Case as_tipo
	Case 'INICIO'

		Update parametro_geral
		Set vl_parametro = :adt_tempo
		Where cd_parametro = 'DATA_HORA_EXTR_GE_ATUAL'
		Using SqlCA;
		
	Case 'FIM'	

		Update parametro_geral
		Set vl_parametro =  vl_parametro  + "/" + :adt_tempo
		Where cd_parametro = 'DATA_HORA_EXTR_GE_ATUAL'
		Using SqlCA;


End Choose
	

If SqlCa.sqlcode = -1 Then
	is_Log	= "Erro na atualizacao parametro :  DATA_HORA_EXTR_GE_ATUAL'. Erro: "+SqlCa.sqlErrText	
	Return False
End If 

SqlCa.of_Commit()	
Return True 


	

end function

public function boolean of_gerar_excesso_estoque ();DateTime lvdt_dh_pedido
Long lvl_cd_filial
Long lvl_cd_produto
Char lvc_cd_classe_reposicao
Long lvl_linhas
Long lvl_linha
Long lvl_Dias
Decimal lvdc_qt_demanda_diaria
Decimal lvdc_vl_custo_unitario

Long lvl_qt_dias_cobertura
Long lvl_qt_estoque_base
Long lvl_qt_estoque_minimo
Long lvl_qt_estoque_filial
Long lvdc_qt_dias_sem_venda
Long lvdc_qt_dias_ult_entrada
String lvs_data
String lvs_arquivo
String lvs_registro
Integer lvi_retorno
Integer lvi_arq
Integer lvi_ret

Date lvd_data

lvd_data = RelativeDate (Date (gf_GetServerDate()),-1)
lvs_data = String (lvd_data , "yyyy-mm-dd")

dc_uo_ds_Base lvds_1

Try 
	
	If Not IsValid(w_aguarde) then
			Open(w_aguarde)
	End If	
		
	//  Local Onde Grava
	is_Dir_Arquivo_Excesso_Estoque = ProfileString(gvo_aplicacao.ivs_arquivo_ini,"GE", "Arquivos_GE", gvo_aplicacao.ivs_path_arquivos+"\Arquivos_GE")
	If Not DirectoryExists(is_Dir_Arquivo_Excesso_Estoque) Then CreateDirectory(is_Dir_Arquivo_Excesso_Estoque)
	// Nome do Arquivo
	lvs_Arquivo =  is_Dir_Arquivo_Excesso_Estoque + "\EXCESSO_ESTOQUE_"+  lvs_data  + ".txt"

	
	If FileExists (lvs_Arquivo) Then
		lvi_Retorno = 1 
		Choose Case lvi_Retorno
			Case 1
				If Not FileDelete ( lvs_Arquivo ) Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao excluir o arquivo '" + lvs_Arquivo + "'.", StopSign!)
					gvo_aplicacao.of_grava_log("GE - Extra$$HEX2$$e700e300$$ENDHEX$$o Excesso Estoque - Erro ao excluir o arquivo")
					Return False
				End If
			Case 2
				Return True
			Case 3
				gvo_aplicacao.of_grava_log("GE - Extra$$HEX2$$e700e300$$ENDHEX$$o Excesso Estoque - Erro ao excluir o arquivo")
				Return False
		End Choose
	End If
	
	lvi_Arq = FileOpen(lvs_Arquivo, LineMode!, Write!, LockReadWrite!, Append!, EncodingANSI!)
	
	If lvi_Arq = -1 Then
		gvo_aplicacao.of_grava_log("GE - Extra$$HEX2$$e700e300$$ENDHEX$$o Excesso Estoque - Erro ao abrir o arquivo")
		Return False
	End If
	
	// Dados Consulta
	lvds_1 = Create dc_uo_ds_Base
	If Not lvds_1.of_ChangeDataObject("ds_ge519_extracao_excesso_est_periodo", False) Then 
		is_Log = "Extra$$HEX2$$e700e300$$ENDHEX$$o Gestao Estoque - Erro na ds_ge519_extracao_excesso_est_periodo"
		gvo_aplicacao.of_grava_log(is_Log)
		Return False	
	End If 
	
	
	// Recuperar Dados
	lvds_1.Retrieve( lvd_data  )
	lvl_Linhas = lvds_1.rowcount( )
	
	Choose case lvl_Linhas
		case is > 0
		
					
			// Cabe$$HEX1$$e700$$ENDHEX$$alho do Arquivo
			lvs_Registro ="DH_PEDIDO" + is_Separador +&
							"CD_FILIAL" + is_Separador +&
							"CD_PRODUTO" + is_Separador +&
							"CD_CLASSE_REPOSICAO" + is_Separador +&
							"QT_DEMANDA_DIARIA" + is_Separador +&
							"QT_DIAS_COBERTURA" + is_Separador +&
							"QT_ESTOQUE_BASE" + is_Separador +&
							"QT_ESTOQUE_MINIMO" + is_Separador +&
							"QT_ESTOQUE_FILIAL" + is_Separador +&
							"VL_CUSTO_UNITARIO" + is_Separador +&
							"QT_DIAS_ULT_ENTRADA"
															
			lvi_Ret = FileWrite(lvi_Arq, lvs_Registro)
				
			If IsNull(lvi_Ret) or lvi_Ret <= 0 Then
				gvo_aplicacao.of_grava_log("CLIC - Extra$$HEX2$$e700e300$$ENDHEX$$o Excesso Estoque - Erro ao gravar registro cabe$$HEX1$$e700$$ENDHEX$$alho")
				Return False			
			End If		
		
			/// Aguarde...	
			w_aguarde.Title = "[GE] - Extra$$HEX2$$e700e300$$ENDHEX$$oExcessoEstoque"
			w_aguarde.uo_progress.of_reset()
			w_aguarde.uo_progress.Of_SetMax(lvl_Linhas)			
	
			// Lopp para Montar Arquivo
			For lvl_Linha  = 1 To lvl_Linhas  
				
				// Campos o Arquivo
				lvl_Dias = 0
				lvdt_dh_pedido			   		= lvds_1.object.dh_pedido[lvl_Linha]
				lvl_cd_filial              			= lvds_1.object.cd_filial[lvl_Linha]
				lvl_cd_produto             		= lvds_1.object.cd_produto[lvl_Linha]
				lvc_cd_classe_reposicao    	= lvds_1.object.cd_classe_reposicao[lvl_Linha]
				lvdc_qt_demanda_diaria		= lvds_1.object.qt_demanda_diaria[lvl_Linha]
				lvl_qt_dias_cobertura		= lvds_1.object.qt_dias_cobertura[lvl_Linha]
				lvl_qt_estoque_base   		= lvds_1.object.qt_estoque_base[lvl_Linha]
				lvl_qt_estoque_minimo     	= lvds_1.object.qt_estoque_minimo[lvl_Linha]
				lvl_qt_estoque_filial			= lvds_1.object.qt_estoque_filial[lvl_Linha]
				lvdc_vl_custo_unitario			= lvds_1.object.vl_custo_unitario[lvl_Linha]
				
				// Ultima Entrada Na loja.
				lvdc_qt_dias_ult_entrada		= lvl_Dias
				If Not This.of_ultima_entrada_loja_produto(lvl_cd_filial, lvl_cd_produto, Date(lvdt_dh_pedido), Ref lvl_Dias) Then Return False
				lvdc_qt_dias_ult_entrada		= lvl_Dias			
				
				w_aguarde.Title =  "[GE] - Extra$$HEX2$$e700e300$$ENDHEX$$oExcessoEstoque: Linha: " + String(lvl_Linha)+" De:"+String(lvl_Linhas)				
			
		
				// Linhas do Arquivo
				lvs_Registro =  String(this.of_null(lvdt_dh_pedido,'')) + is_Separador +&
									String(this.of_null(lvl_cd_filial,'')) + is_Separador +&           
									String(this.of_null(lvl_cd_produto,'')) + is_Separador +&
									String(this.of_null(lvc_cd_classe_reposicao,'')) + is_Separador +&
									String(this.of_null(lvdc_qt_demanda_diaria,'')) + is_Separador +&
									String(this.of_null(lvl_qt_dias_cobertura,'')) + is_Separador +&
									String(this.of_null(lvl_qt_estoque_base,'')) + is_Separador +&
									String(this.of_null(lvl_qt_estoque_minimo,'')) + is_Separador +&
									String(this.of_null(lvl_qt_estoque_filial,'')) + is_Separador +&
									String(this.of_null(lvdc_vl_custo_unitario,'')) + is_Separador +&
									String(this.of_null(lvdc_qt_dias_ult_entrada,''))
									
					// Dados dos Produtos
					lvi_Ret = FileWrite(lvi_Arq, lvs_Registro)					
							
					If IsNull(lvi_Ret) or lvi_Ret <= 0 Then
						gvo_aplicacao.of_grava_log("GE - Extra$$HEX2$$e700e300$$ENDHEX$$o Excesso Estoque - Erro no Arquivo")
						Return False
					End If				
			
				w_aguarde.uo_progress.Of_SetProgress(lvl_Linha)					
			Next 	
		case 0
			gvo_aplicacao.of_grava_log("GE - Extra$$HEX2$$e700e300$$ENDHEX$$o Excesso Estoque - Sem Registro")
		case is < 0
			gvo_aplicacao.of_grava_log("GE - Extra$$HEX2$$e700e300$$ENDHEX$$o Excesso Estoque - Erro no retrieve do datastore")
	End choose
Finally		
	FileClose (lvi_Arq)
	If IsValid(w_aguarde) then Close(w_aguarde)
	Destroy (lvds_1)	
	Return True 
	
End Try
end function

public function any of_null (any a_valor, any a_default);If IsNull(a_valor) Then
	Return a_default
Else
	Return a_valor
End If
end function

public function boolean of_ultima_entrada_loja_produto (long al_filial, long al_produto, date al_data, ref long al_dias);

Select  Top 1 datediff(day, dh_resumo, :al_data)
Into :al_dias
From resumo_movto_estq_prd
Where cd_filial =:al_filial 
And cd_produto =:al_produto
And dh_resumo <=:al_data
And (qt_transf_entrada > 0  Or qt_compra > 0 Or qt_ajuste_entrada > 0)
Order By dh_resumo Desc
Using SqlCA;


If SqlCa.SqlCode = - 1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao consultar ultima entrada filial/produto:" + String(al_produto) + ". Fun$$HEX2$$e700e300$$ENDHEX$$o of_ultima_entrada_loja_produto. " + SqlCa.SqlErrText, StopSign!)
	Return False
End If


If al_dias < 0 Then al_dias = 0

Return True 
	
	
	
	
	
end function

public subroutine of_envia_email (string as_tipo);Long  ll_Cod_Msg
String  lvs_data_envio,&
			 lvs_data	
String ls_Texto_email
String ls_Dados_Email
String ls_Extra_Email
String ls_Texto_Email_Extra
String ls_Tipo
String ls_tipo_carga

		 
s_email str //ge202
ll_Cod_Msg = 233

If as_tipo = 'E' Then 
	ls_Tipo = "[GE] Exporta$$HEX2$$e700e300$$ENDHEX$$o de Dados Gest$$HEX1$$e300$$ENDHEX$$o Estoque : Erro Na Gera$$HEX2$$e700e300$$ENDHEX$$o dos Arquivos"	
Else
	ls_Tipo = "[GE] Exporta$$HEX2$$e700e300$$ENDHEX$$o de Dados Gest$$HEX1$$e300$$ENDHEX$$o Estoque : Sucesso na Gera$$HEX2$$e700e300$$ENDHEX$$o dos Arquivos"	
End If 	
		
lvs_data_envio 	= String ( RelativeDate (Date (gf_GetServerDate()),-0), "yyyy-mm-dd")
lvs_data 			= String ( RelativeDate (Date (gf_GetServerDate()),-1), "yyyy-mm-dd")

ls_Texto_Email = 	"<HTML>"+&
										"<BODY>"+&
										"<BR>"+&										
										"<TABLE border=0>"+&
										"<TR>"+& 
										"<TD><B>" + ls_Tipo + " no Envio dos Dados</B></TD>"+&	
										"</TR>"+&
										"<TR>"+& 
										"<TD>Tipo de Carga: Di$$HEX1$$e100$$ENDHEX$$ria </TD>"+&	
										"</TR>"+&
										"<TR>"+& 
										"<TD>Data de Hoje: " +string(lvs_data_envio) + "~n</TD> "+&	
										"</TR>"+&
										"<TD>Data dos Dados:" +string(lvs_data) + "~n</TD> "+&	
										"</TR>"

ls_Texto_Email	= ls_Texto_Email +"</TABLE></BODY></HTML>" 	

If  as_tipo<>"" Then 
	str.ps_Mensagem	= ls_Texto_Email	
	str.pb_Assinatura	= True
	gf_ge202_envia_email_padrao(ll_Cod_Msg, str)
Else
	Return 
End If 
end subroutine

public function boolean of_gerar_ultimas_entradas_pentaho ();String lvs_Registro,&
		lvs_Arquivo_Pentaho, &
		lvs_data,&
		lvs_dh_ultima_entrada,&
		lvs_tipo_entrada,&
		lvs_de_motivo_entrada,&
		lvs_nr_matricula,&
		lvs_nm_responsavel,&
		lvs_de_motivo_alteracao, &
		lvs_Dir_Arquivo_UltimaCompra_Pentaho

Long  ll_cd_produto,&
		ll_cd_filial,&
		ll_qt_saldo,&
		ll_Linhas,&
		ll_Linha,&
		li_Retorno, &
		li_Arq_Pentaho, &
		li_Ret

Date ldt_Ultima_Entrada

dc_uo_ds_Base lvds_1
dc_uo_ds_Base lvds_2

lvs_data = String ( RelativeDate (     Date (gf_GetServerDate()),-1), "yyyy-mm-dd")

Try 
	
	If Not IsValid(w_aguarde) then
			Open(w_aguarde)
	End If	
	
	adh_termino = adh_inicio
	
	//  Local Onde Grava
	lvs_Dir_Arquivo_UltimaCompra_Pentaho = ProfileString(gvo_aplicacao.ivs_arquivo_ini,"GE", "Arquivos_Pentaho", gvo_aplicacao.ivs_path_arquivos+"\Arquivos_Pentaho")
	If Not DirectoryExists(lvs_Dir_Arquivo_UltimaCompra_Pentaho) Then CreateDirectory(lvs_Dir_Arquivo_UltimaCompra_Pentaho)
	// Nome do Arquivo
	lvs_Arquivo_Pentaho = lvs_Dir_Arquivo_UltimaCompra_Pentaho + "\DBA.ge_ult_entr_produto_filial.txt"
	
	If FileExists (lvs_Arquivo_Pentaho) Then
		li_Retorno = 1 
		Choose Case li_Retorno
			Case 1
				If Not FileDelete ( lvs_Arquivo_Pentaho ) Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao excluir o arquivo '" + lvs_Arquivo_Pentaho + "'.", StopSign!)
					gvo_aplicacao.of_grava_log("GE - Ultimas Entradas - Erro ao excluir o arquivo")
					Return False
				End If
			Case 2
				Return True
			Case 3
				gvo_aplicacao.of_grava_log("GE - Ultimas Entradas - Erro ao excluir o arquivo")
				Return False
		End Choose
	End If
	
	li_Arq_Pentaho = FileOpen(lvs_Arquivo_Pentaho, LineMode!, Write!, LockReadWrite!, Append!, EncodingUTF8!)
	
	If li_Arq_Pentaho = -1 Then
		gvo_aplicacao.of_grava_log("GE - Ultimas Entradas - Erro ao abrir o arquivo")
		Return False
	End If
	
	// Dados Consulta: Principal
	lvds_1 = Create dc_uo_ds_Base
	If Not lvds_1.of_ChangeDataObject("ds_ge519_lista_gestao_est", False) Then 
		is_Log = "Extra$$HEX2$$e700e300$$ENDHEX$$o Gestao Estoque - Erro na ds_ge519_lista_gestao_est"
		gvo_aplicacao.of_grava_log(is_Log)
		Return False	
	End If 
	
	// Dados Consulta: Movimentos
	lvds_2 = Create dc_uo_ds_Base
	If Not lvds_2.of_ChangeDataObject("ds_ge519_lista_gestao_est_movimento", False) Then 
		is_Log = "Extra$$HEX2$$e700e300$$ENDHEX$$o Gestao Estoque - Erro na ds_ge519_lista_gestao_est_movimento"
		gvo_aplicacao.of_grava_log(is_Log)
		Return False	
	End If 	

	// Recuperar Dados
	lvds_1.Retrieve(adt_saldo,  Datetime(Date(adh_inicio),Time("00:00:00"))  , Datetime(Date(adh_termino),Time("23:59:59")))

	ll_Linhas = lvds_1.rowcount( )
	
	If ll_Linhas > 0 Then 
	
		lvds_2.Retrieve(Datetime(Date(adh_inicio),Time("00:00:00")),    Datetime(Date(adh_termino),Time("23:59:59"))    )
	
		// Cabe$$HEX1$$e700$$ENDHEX$$alho do Arquivo
		lvs_Registro = "CD_FILIAL" + is_Separador +&
		"CD_PRODUTO" + is_Separador +&
		"QT_SALDO" + is_Separador +&	
		"DH_ULTIMA_ENTRADA" + is_Separador +&
		"TIPO_ENTRADA" + is_Separador +&
		"DE_MOTIVO_ENTRADA" + is_Separador +&
		"NR_MATRICULA" + is_Separador +&	
		"NM_RESPONSAVEL" + is_Separador +&	
		"DE_MOTIVO_ALTERACAO"
													
		li_Ret = FileWrite(li_Arq_Pentaho, lvs_Registro)		
			
		If IsNull(li_Ret) or li_Ret <= 0 Then
			gvo_aplicacao.of_grava_log("CLIC - Extra$$HEX2$$e700e300$$ENDHEX$$o Ultimas Entradas - Erro ao gravar registro cabe$$HEX1$$e700$$ENDHEX$$alho")
			Return False			
		End If		
	
		/// Aguarde...	
		w_aguarde.Title = "[GE] - Extra$$HEX2$$e700e300$$ENDHEX$$o Ultimas Entradas "
		w_aguarde.uo_progress.of_reset()
		w_aguarde.uo_progress.Of_SetMax(ll_Linhas)			
		
		// Lopp para Montar Arquivo
		For ll_Linha  = 1 To ll_Linhas  
			
			ll_cd_produto= lvds_1.object.cd_produto[ll_Linha]
			ll_cd_filial= lvds_1.object.cd_filial[ll_Linha]
			ll_qt_saldo= lvds_1.object.qt_saldo[ll_Linha]
			lvs_nr_matricula =    lvds_1.object.nr_matricula_alteracao[ll_Linha]
			lvs_nm_responsavel =    lvds_1.object.nm_responsavel[ll_Linha] 
			lvs_de_motivo_alteracao  = lvds_1.object.de_motivo_alteracao[ll_Linha]   
			
			If IsNull(lvs_nr_matricula) then lvs_nr_matricula=""
			If IsNull(lvs_nm_responsavel) then lvs_nm_responsavel=""
			If IsNull(lvs_de_motivo_alteracao) then lvs_de_motivo_alteracao=""		
			
			// Carrega dados Movimento
			If Not This.of_carrega_movimentacoes (ll_cd_filial,& 
														ll_cd_produto,& 
														Ref ldt_Ultima_Entrada,&
														Ref lvs_tipo_entrada,&
														Ref lvs_de_motivo_entrada,&
														lvds_2 ) Then Return False
			
			w_aguarde.Title =   "[GE] - Extra$$HEX2$$e700e300$$ENDHEX$$o Ultimas Entradas : " + String(ll_Linha)+" De:"+String(ll_Linhas)				
		
			If IsNull(ldt_Ultima_Entrada) Then ldt_Ultima_Entrada=1900-01-01
			If IsNull(lvs_de_motivo_entrada) Then lvs_de_motivo_entrada = ""
			If IsNull(lvs_tipo_entrada) Then lvs_tipo_entrada=""
	
			// Linhas do Arquivo
			lvs_Registro =  String(ll_cd_filial) + is_Separador +&
								String(ll_cd_produto)  + is_Separador +&
								String(ll_qt_saldo) + is_Separador +&
								String(ldt_Ultima_Entrada, 'dd/mm/yyyy')+is_Separador + &
								String(lvs_tipo_entrada)+is_Separador+&
								String(lvs_de_motivo_entrada)+is_Separador+&
								String(lvs_nr_matricula)+is_Separador+&
								String(lvs_nm_responsavel)+is_Separador+&
								String(lvs_de_motivo_alteracao)
	
								
				// Dados dos Produtos
				li_Ret = FileWrite(li_Arq_Pentaho, lvs_Registro)				
						
				If IsNull(li_Ret) or li_Ret <= 0 Then
					gvo_aplicacao.of_grava_log("GE - Extra$$HEX2$$e700e300$$ENDHEX$$o Ultimas Entradas - Erro no Arquivo")
					Return False
				End If				
		
			w_aguarde.uo_progress.Of_SetProgress(ll_Linha)					
		Next 	
	Else
		gvo_aplicacao.of_grava_log("GE - Extra$$HEX2$$e700e300$$ENDHEX$$o Ultimas Entradas - Sem Registro")
	End If 
Finally		
	FileClose (li_Arq_Pentaho)	
	If IsValid(w_aguarde) then Close(w_aguarde)
	Destroy (lvds_1)
	Destroy (lvds_2)	
	
	Return True 
	
End Try
end function

public function boolean of_gerar_excesso_estoque_pentaho ();DateTime lvdt_dh_pedido
Long lvl_cd_filial
Long lvl_cd_produto
Char lvc_cd_classe_reposicao
Long lvl_linhas
Long lvl_linha
Long lvl_Dias
Decimal lvdc_qt_demanda_diaria
Decimal lvdc_vl_custo_unitario

Long lvl_qt_dias_cobertura
Long lvl_qt_estoque_base
Long lvl_qt_estoque_minimo
Long lvl_qt_estoque_filial
Long lvdc_qt_dias_sem_venda
Long lvdc_qt_dias_ult_entrada
String lvs_data
String lvs_arquivo
String lvs_registro
Integer lvi_retorno
Integer lvi_arq
Integer lvi_ret
String lvs_qt_demanda_diaria
String lvs_qt_dias_ult_entrada
String lvs_vl_custo_unitario

Date lvd_data

lvd_data = RelativeDate (Date (gf_GetServerDate()),-1)
lvs_data = String (lvd_data , "yyyy-mm-dd")

dc_uo_ds_Base lvds_1

Try 
	
	If Not IsValid(w_aguarde) then
			Open(w_aguarde)
	End If	
		
	//  Local Onde Grava
	is_Dir_Arquivo_Excesso_Estoque = ProfileString(gvo_aplicacao.ivs_arquivo_ini,"GE", "Arquivos_Pentaho", gvo_aplicacao.ivs_path_arquivos+"\Arquivos_Pentaho")
	If Not DirectoryExists(is_Dir_Arquivo_Excesso_Estoque) Then CreateDirectory(is_Dir_Arquivo_Excesso_Estoque)
	// Nome do Arquivo
	lvs_Arquivo =  is_Dir_Arquivo_Excesso_Estoque + "\DBA.ge_excesso_estoque_filiais.txt"

	
	If FileExists (lvs_Arquivo) Then
		lvi_Retorno = 1 
		Choose Case lvi_Retorno
			Case 1
				If Not FileDelete ( lvs_Arquivo ) Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao excluir o arquivo '" + lvs_Arquivo + "'.", StopSign!)
					gvo_aplicacao.of_grava_log("GE - Extra$$HEX2$$e700e300$$ENDHEX$$o Excesso Estoque - Erro ao excluir o arquivo")
					Return False
				End If
			Case 2
				Return True
			Case 3
				gvo_aplicacao.of_grava_log("GE - Extra$$HEX2$$e700e300$$ENDHEX$$o Excesso Estoque - Erro ao excluir o arquivo")
				Return False
		End Choose
	End If
	
	lvi_Arq = FileOpen(lvs_Arquivo, LineMode!, Write!, LockReadWrite!, Append!, EncodingUTF8!)
	
	If lvi_Arq = -1 Then
		gvo_aplicacao.of_grava_log("GE - Extra$$HEX2$$e700e300$$ENDHEX$$o Excesso Estoque - Erro ao abrir o arquivo")
		Return False
	End If
	
	// Dados Consulta
	lvds_1 = Create dc_uo_ds_Base
	If Not lvds_1.of_ChangeDataObject("ds_ge519_extracao_excesso_est_periodo", False) Then 
		is_Log = "Extra$$HEX2$$e700e300$$ENDHEX$$o Gestao Estoque - Erro na ds_ge519_extracao_excesso_est_periodo"
		gvo_aplicacao.of_grava_log(is_Log)
		Return False	
	End If 
	
	
	// Recuperar Dados
	lvds_1.Retrieve( lvd_data  )
	lvl_Linhas = lvds_1.rowcount( )
	
	If lvl_Linhas > 0 Then 
	
				
		// Cabe$$HEX1$$e700$$ENDHEX$$alho do Arquivo
		lvs_Registro ="DH_PEDIDO" + is_Separador +&
						"CD_FILIAL" + is_Separador +&
						"CD_PRODUTO" + is_Separador +&
						"CD_CLASSE_REPOSICAO" + is_Separador +&
						"QT_DEMANDA_DIARIA" + is_Separador +&
						"QT_DIAS_COBERTURA" + is_Separador +&
						"QT_ESTOQUE_BASE" + is_Separador +&
						"QT_ESTOQUE_MINIMO" + is_Separador +&
						"QT_ESTOQUE_FILIAL" + is_Separador +&
						"VL_CUSTO_UNITARIO" + is_Separador +&
						"QT_DIAS_ULT_ENTRADA"
														
		lvi_Ret = FileWrite(lvi_Arq, lvs_Registro)
			
		If IsNull(lvi_Ret) or lvi_Ret <= 0 Then
			gvo_aplicacao.of_grava_log("CLIC - Extra$$HEX2$$e700e300$$ENDHEX$$o Excesso Estoque - Erro ao gravar registro cabe$$HEX1$$e700$$ENDHEX$$alho")
			Return False			
		End If		
	
		/// Aguarde...	
		w_aguarde.Title = "[GE] - Extra$$HEX2$$e700e300$$ENDHEX$$oExcessoEstoque"
		w_aguarde.uo_progress.of_reset()
		w_aguarde.uo_progress.Of_SetMax(lvl_Linhas)			

		// Lopp para Montar Arquivo
		For lvl_Linha  = 1 To lvl_Linhas  
			
			// Campos o Arquivo
			lvl_Dias = 0
			lvdt_dh_pedido			   		= lvds_1.object.dh_pedido[lvl_Linha]
			lvl_cd_filial              			= lvds_1.object.cd_filial[lvl_Linha]
			lvl_cd_produto             		= lvds_1.object.cd_produto[lvl_Linha]
			lvc_cd_classe_reposicao    	= lvds_1.object.cd_classe_reposicao[lvl_Linha]
			lvdc_qt_demanda_diaria		= lvds_1.object.qt_demanda_diaria[lvl_Linha]
			lvl_qt_dias_cobertura			= lvds_1.object.qt_dias_cobertura[lvl_Linha]
			lvl_qt_estoque_base   		= lvds_1.object.qt_estoque_base[lvl_Linha]
			lvl_qt_estoque_minimo     	= lvds_1.object.qt_estoque_minimo[lvl_Linha]
			lvl_qt_estoque_filial			= lvds_1.object.qt_estoque_filial[lvl_Linha]
			lvdc_vl_custo_unitario		= lvds_1.object.vl_custo_unitario[lvl_Linha]
			
			// Ultima Entrada Na loja.
			lvdc_qt_dias_ult_entrada		= lvl_Dias
			If Not This.of_ultima_entrada_loja_produto(lvl_cd_filial, lvl_cd_produto, Date(lvdt_dh_pedido), Ref lvl_Dias) Then Return False
			lvdc_qt_dias_ult_entrada		= lvl_Dias			
			
			w_aguarde.Title =  "[GE] - Extra$$HEX2$$e700e300$$ENDHEX$$oExcessoEstoque: Linha: " + String(lvl_Linha)+" De:"+String(lvl_Linhas)
			
			lvs_qt_demanda_diaria 	= gf_Replace(String(lvdc_qt_demanda_diaria), ',','.',0)
			lvs_qt_dias_ult_entrada 	=  gf_Replace(String(lvdc_qt_dias_ult_entrada), ',','.',0)
			lvs_vl_custo_unitario		= gf_Replace(String(lvdc_vl_custo_unitario), ',','.',0)
	
			// Linhas do Arquivo
			lvs_Registro =  String(this.of_null(lvdt_dh_pedido,'')) + is_Separador +&
								String(this.of_null(lvl_cd_filial,'')) + is_Separador +&           
								String(this.of_null(lvl_cd_produto,'')) + is_Separador +&
								String(this.of_null(lvc_cd_classe_reposicao,'')) + is_Separador +&
								String(this.of_null(lvs_qt_demanda_diaria,'')) + is_Separador +&
								String(this.of_null(lvl_qt_dias_cobertura,'')) + is_Separador +&
								String(this.of_null(lvl_qt_estoque_base,'')) + is_Separador +&
								String(this.of_null(lvl_qt_estoque_minimo,'')) + is_Separador +&
								String(this.of_null(lvl_qt_estoque_filial,'')) + is_Separador +&
								String(this.of_null(lvs_vl_custo_unitario,'')) + is_Separador +&
								String(this.of_null(lvs_qt_dias_ult_entrada,''))
								
				// Dados dos Produtos
				lvi_Ret = FileWrite(lvi_Arq, lvs_Registro)					
						
				If IsNull(lvi_Ret) or lvi_Ret <= 0 Then
					gvo_aplicacao.of_grava_log("GE - Extra$$HEX2$$e700e300$$ENDHEX$$o Excesso Estoque - Erro no Arquivo")
					Return False
				End If				
		
			w_aguarde.uo_progress.Of_SetProgress(lvl_Linha)					
		Next 	
	Else
		gvo_aplicacao.of_grava_log("GE - Extra$$HEX2$$e700e300$$ENDHEX$$o Excesso Estoque - Sem Registro")
	End If 
Finally		
	FileClose (lvi_Arq)
	If IsValid(w_aguarde) then Close(w_aguarde)
	Destroy (lvds_1)	
	Return True 
	
End Try
end function

on uo_ge519_extracao_gestao_estoque.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge519_extracao_gestao_estoque.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;IF IsValid(io_Pedido) Then Destroy(io_Pedido)
end event

event constructor;io_Pedido = Create uo_pedido_empurrado
end event

