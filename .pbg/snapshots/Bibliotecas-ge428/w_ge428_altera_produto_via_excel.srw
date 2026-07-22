HA$PBExportHeader$w_ge428_altera_produto_via_excel.srw
forward
global type w_ge428_altera_produto_via_excel from dc_w_response_ok_cancela
end type
type cb_selecionar from commandbutton within w_ge428_altera_produto_via_excel
end type
end forward

global type w_ge428_altera_produto_via_excel from dc_w_response_ok_cancela
string accessiblename = "Atualiza$$HEX2$$e700e300$$ENDHEX$$o de produtos via excel (GE428)"
integer width = 2194
integer height = 644
string title = "GE428 - Atualiza$$HEX2$$e700e300$$ENDHEX$$o de Produtos via Excel"
long backcolor = 80269524
cb_selecionar cb_selecionar
end type
global w_ge428_altera_produto_via_excel w_ge428_altera_produto_via_excel

type variables
uo_ge149_comprador io_Comprador

dc_uo_ds_base ids_Ean

String is_Usuario
end variables

forward prototypes
public function boolean wf_localiza_produto (long al_produto)
public function boolean wf_localiza_tipo ()
public function boolean wf_update (long al_produto, string as_tipo, any aa_dado)
public function boolean wf_atualiza_produto ()
public function boolean wf_update (long al_produto, decimal adc_altura, decimal adc_largura, decimal adc_profundidade)
public function boolean wf_atualiza_margem_produto (integer al_produto, string as_uf, decimal adc_margem)
public function boolean wf_grava_historico (long al_produto, string as_de, string as_para, string as_tabela, string as_coluna)
public function boolean wf_atualiza_comissao (long al_produto, string as_tipo, any aa_dado)
public function boolean wf_atualiza_fornecedor_produto (long al_produto, string as_fornecedor, long al_divisao)
public function boolean wf_localiza_fornecedor (string as_fornecedor)
public function boolean wf_divisao_fornecedor (string as_fornecedor, long al_divisao, ref boolean ab_achou)
public function boolean wf_localiza_ean (long al_produto, ref long al_produto_abc)
public function boolean wf_update_abcfarma (long al_produto, string as_caderno_abcfarma)
end prototypes

public function boolean wf_localiza_produto (long al_produto);Long lvl_Produto

Select cd_produto
Into :lvl_Produto
From produto_geral
Where cd_produto =:al_Produto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produto n$$HEX1$$e300$$ENDHEX$$o cadastrado '" + String(al_Produto) + "'.")
		Return False
	Case -1
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Produto.")
		Return False
End Choose

Return True

end function

public function boolean wf_localiza_tipo ();String lvs_Tipo, &
		 lvs_Mensagem

// Gloss$$HEX1$$e100$$ENDHEX$$rio de Tipos de Atualiza$$HEX2$$e700f500$$ENDHEX$$es:
// 1 - Embalagem Padr$$HEX1$$e300$$ENDHEX$$o
// 2 - C$$HEX1$$f300$$ENDHEX$$digo de Produtos no Fornecedor
// 3 - Inativar - Deixar o Produto PENDENTE depois o sistema INATIVA automaticamente
// 4 - Origem do Produto
// 5 - Mix do Produto
// 6 - Qtde pontos resgate
// 7 - Atualiza medidas do e-commerce
// 8 - Lei GENERICO
// 9 - Unidade de compra
// 10 - Unidade de venda
// 11 - LINHA PRODUTO
// 12 - ABC Farma
// 13 - Planograma
// 14 - Marca
// 15 - Permite Devolu$$HEX2$$e700e300$$ENDHEX$$o
// 16 - Margem do Produto
// 17 - Comiss$$HEX1$$e300$$ENDHEX$$o Normal
// 18 - Comiss$$HEX1$$e300$$ENDHEX$$o Seletiva
// 19 - Fornecedor por Produto
// 20 - Unidade por Embalagem (Venda)  
// 21 - Cont$$HEX1$$e900$$ENDHEX$$m lactose
// 22 - Cont$$HEX1$$e900$$ENDHEX$$m gluten
// 23 - Cont$$HEX1$$e900$$ENDHEX$$m acucar
// 24 - Desconto do Fornecedor
// 25 - Apres.Compra
// 26 - Apres. Venda
// 27 - Descri$$HEX2$$e700e300$$ENDHEX$$o
// 28 - Tipo Apresenta$$HEX2$$e700e300$$ENDHEX$$o
// 29 - Concentra$$HEX2$$e700e300$$ENDHEX$$o
// 30 - Volume
// 31 - Peso em Gramas - Ecommerce
// 32 - Peso em Gramas - Geral
// ------------------------------------

dw_1.AcceptText()

lvs_Tipo = dw_1.Object.de_tipo[1]

Choose Case lvs_Tipo
	Case "1"
		lvs_Mensagem = "Os dados devem estar da seguinte forma:~r~r" + &
							"Coluna A = C$$HEX1$$f300$$ENDHEX$$digo do Produto~r" + &
							"Coluna B = Quantidade da Embalagem~r"
	Case "2"
		lvs_Mensagem = "Os dados devem estar da seguinte forma:~r~r"+ &
							"Coluna A = C$$HEX1$$f300$$ENDHEX$$digo do Produto~r" + &
							"Coluna B = C$$HEX1$$f300$$ENDHEX$$digo do Produto no Fornecedor~r"
							
	Case "3"
		lvs_Mensagem = "Os dados devem estar da seguinte forma:~r~r"+ &
							"Coluna A = C$$HEX1$$f300$$ENDHEX$$digo do Produto~r"		
							
	Case "4"
		lvs_Mensagem = "Os dados devem estar da seguinte forma:~r~r"+ &
							"Coluna A = C$$HEX1$$f300$$ENDHEX$$digo do Produto~r" + &
							"Coluna B = C$$HEX1$$f300$$ENDHEX$$digo da Origem do Produto~r"							
							
	Case "5"
		lvs_Mensagem = "Os dados devem estar da seguinte forma:~r~r"+ &
							"Coluna A = C$$HEX1$$f300$$ENDHEX$$digo do Produto~r" + &
							"Coluna B = C$$HEX1$$f300$$ENDHEX$$digo do MIX do Produto~r"	

	Case "6"
		lvs_Mensagem = "Os dados devem estar da seguinte forma:~r~r"+ &
							"Coluna A = C$$HEX1$$f300$$ENDHEX$$digo do Produto~r" + &
							"Coluna B = Qtde. de Pontos para o Resgate~r"	
							
	Case "7"
		lvs_Mensagem = "Os dados devem estar da seguinte forma:~r~r"+ &
							"Coluna A = C$$HEX1$$f300$$ENDHEX$$digo do Produto~r" 	+ &
							"Coluna B = Altura (cm)~r"				+ &
							"Coluna C = Largura (cm)~r" 			+ &
							"Coluna D = Profundidade (cm)~r" 
	Case "8"
		lvs_Mensagem = "Os dados devem estar da seguinte forma:~r~r"+ &
							"Coluna A = C$$HEX1$$f300$$ENDHEX$$digo do Produto~r" + &
							"Coluna B = Lei Gen$$HEX1$$e900$$ENDHEX$$rico~r"	
							
	Case "9"
		lvs_Mensagem = "Os dados devem estar da seguinte forma:~r~r"+ &
							"Coluna A = C$$HEX1$$f300$$ENDHEX$$digo do Produto~r" + &
							"Coluna B = Unidade de Compra~r"	
	
	Case "10"
		lvs_Mensagem = "Os dados devem estar da seguinte forma:~r~r"+ &
							"Coluna A = C$$HEX1$$f300$$ENDHEX$$digo do Produto~r" + &
							"Coluna B = Unidade de Venda~r"	
	Case "11"
		lvs_Mensagem = 	"Os dados devem estar da seguinte forma:~r~r"+ &
								"Coluna A = C$$HEX1$$f300$$ENDHEX$$digo do Produto~r" + &
								"Coluna B = Linha~r"	
	Case "12"
		lvs_Mensagem = 	"Os dados devem estar da seguinte forma:~r~r"+ &
								"Coluna A = C$$HEX1$$f300$$ENDHEX$$digo do Produto~r" + &
								"Coluna B = S/N (Faz parte da ABCFARMA)~r"
								
	Case "13"
		lvs_Mensagem = 	"Os dados devem estar da seguinte forma:~r~r"+ &
								"Coluna A = C$$HEX1$$f300$$ENDHEX$$digo do Produto~r" + &
								"Coluna B = C$$HEX1$$f300$$ENDHEX$$digo do Planograma"
																
	Case "14"
		lvs_Mensagem = 	"Os dados devem estar da seguinte forma:~r~r"+ &
								"Coluna A = C$$HEX1$$f300$$ENDHEX$$digo do Produto~r" + &
								"Coluna B = C$$HEX1$$f300$$ENDHEX$$digo do Marca"
								
	Case "15"
		lvs_Mensagem = 	"Os dados devem estar da seguinte forma:~r~r"+ &
								"Coluna A = C$$HEX1$$f300$$ENDHEX$$digo do Produto~r" + &
								"Coluna B = Produto Permite Devolu$$HEX2$$e700e300$$ENDHEX$$o?~r" + &
								"S - Permite Devolu$$HEX2$$e700e300$$ENDHEX$$o | N - N$$HEX1$$e300$$ENDHEX$$o Permite Devolu$$HEX2$$e700e300$$ENDHEX$$o"
								
	Case "16"
		lvs_Mensagem = 	"Os dados devem estar da seguinte forma:~r~r"+ &
								"Coluna A = C$$HEX1$$f300$$ENDHEX$$digo do Produto~r" + &
								"Coluna B = UF: Unidade de Federa$$HEX2$$e700e300$$ENDHEX$$o~r" +&
								"Coluna C = Percentual Margem"
								
	Case "17"
		lvs_Mensagem = 	"Os dados devem estar da seguinte forma:~r~r"+ &
								"Coluna A = C$$HEX1$$f300$$ENDHEX$$digo do Produto~r" + &
								"Coluna B = Percentual de Comiss$$HEX1$$e300$$ENDHEX$$o Normal"
								
	Case "18"
		lvs_Mensagem = 	"Os dados devem estar da seguinte forma:~r~r"+ &
								"Coluna A = C$$HEX1$$f300$$ENDHEX$$digo do Produto~r" + &
								"Coluna B = Percentual de Comiss$$HEX1$$e300$$ENDHEX$$o Seletiva"
								
	Case "19"
		lvs_Mensagem =	"Os dados devem estar da seguinte forma:~r~r" + &
								"Coluna A = C$$HEX1$$f300$$ENDHEX$$digo do Produto~r" + &
								"Coluna B = C$$HEX1$$f300$$ENDHEX$$digo do Fornecedor~r" + &
								"Coluna C = Divis$$HEX1$$e300$$ENDHEX$$o do Fornecedor (se possuir divis$$HEX1$$e300$$ENDHEX$$o)"
	Case "20"
		lvs_Mensagem = "Os dados devem estar da seguinte forma:~r~r" + &
							"Coluna A = C$$HEX1$$f300$$ENDHEX$$digo do Produto~r" + &
							"Coluna B = Unidade por Embalagem(Venda)"
	Case "21"
		lvs_Mensagem = "Os dados devem estar da seguinte forma:~r~r" + &
							"Coluna A = C$$HEX1$$f300$$ENDHEX$$digo do Produto~r" + &
							"Coluna B = Cont$$HEX1$$e900$$ENDHEX$$m lactose (S/N)"
	Case "22"
		lvs_Mensagem = "Os dados devem estar da seguinte forma:~r~r" + &
							"Coluna A = C$$HEX1$$f300$$ENDHEX$$digo do Produto~r" + &
							"Coluna B = Cont$$HEX1$$e900$$ENDHEX$$m glut$$HEX1$$e900$$ENDHEX$$n (S/N)"
	Case "23"
		lvs_Mensagem = "Os dados devem estar da seguinte forma:~r~r" + &
							"Coluna A = C$$HEX1$$f300$$ENDHEX$$digo do Produto~r" + &
							"Coluna B = Cont$$HEX1$$e900$$ENDHEX$$m a$$HEX2$$e700fa00$$ENDHEX$$car (S/N)"
					
	Case "24"
		lvs_Mensagem = "Os dados devem estar da seguinte forma:~r~r" + &
							"Coluna A = C$$HEX1$$f300$$ENDHEX$$digo do Produto~r" + &
							"Coluna B = Desconto do Fornecedor"
	
	Case "25"
		lvs_Mensagem = "Os dados devem estar da seguinte forma:~r~r" + &
							"Coluna A = C$$HEX1$$f300$$ENDHEX$$digo do Produto~r" + &
							"Coluna B = Apresentacao de Compra"
		
	Case "26"
		lvs_Mensagem = "Os dados devem estar da seguinte forma:~r~r" + &
							"Coluna A = C$$HEX1$$f300$$ENDHEX$$digo do Produto~r" + &
							"Coluna B = Apresentacao de Venda"
	
	Case "27"
		lvs_Mensagem = "Os dados devem estar da seguinte forma:~r~r" + &
							"Coluna A = C$$HEX1$$f300$$ENDHEX$$digo do Produto~r" + &
							"Coluna B = Descri$$HEX2$$e700e300$$ENDHEX$$o do Produto"
	
	Case "28"
		lvs_Mensagem = "Os dados devem estar da seguinte forma:~r~r" + &
							"Coluna A = C$$HEX1$$f300$$ENDHEX$$digo do Produto~r" + &
							"Coluna B = Tipo de Apresenta$$HEX2$$e700e300$$ENDHEX$$o~r" + &
							"O texto da coluna TIPO APRESENTACAO, deve ser id$$HEX1$$ea00$$ENDHEX$$ntico ao cadastro de produto"
							
	Case "29"
		lvs_Mensagem = "Os dados devem estar da seguinte forma:~r~r" + &
							"Coluna A = C$$HEX1$$f300$$ENDHEX$$digo do Produto~r" + &
							"Coluna B = Concentra$$HEX2$$e700e300$$ENDHEX$$o (s$$HEX1$$e300$$ENDHEX$$o permitidas at$$HEX1$$e900$$ENDHEX$$ 8 posi$$HEX2$$e700f500$$ENDHEX$$es. Ex: 1000,0000)"
							
	Case "30"
		lvs_Mensagem = "Os dados devem estar da seguinte forma:~r~r" + &
							"Coluna A = C$$HEX1$$f300$$ENDHEX$$digo do Produto~r" + &
							"Coluna B = Informa$$HEX2$$e700e300$$ENDHEX$$o do Volume"

	Case "31"
		lvs_Mensagem = "(E-Commerce) Os dados devem estar da seguinte forma:~r~r" + &
							"Coluna A = C$$HEX1$$f300$$ENDHEX$$digo do Produto~r" + &
							"Coluna B = Peso do Produto (EM GRAMAS)"						
							
	Case "32"
		lvs_Mensagem = "(Aba Geral) Os dados devem estar da seguinte forma:~r~r" + &
						"Coluna A = C$$HEX1$$f300$$ENDHEX$$digo do Produto~r" + &
						"Coluna B = Peso do Produto (EM GRAMAS)"																

	Case Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe corretamente o tipo de atualiza$$HEX2$$e700e300$$ENDHEX$$o.", StopSign!)
		dw_1.Event ue_Pos(1,"de_tipo")
		Return False
End Choose

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvs_Mensagem)

Return True
end function

public function boolean wf_update (long al_produto, string as_tipo, any aa_dado);Boolean lb_Sucesso = True

Decimal	ldc_Desc_Forn_De, &
			ldc_Desc_Forn, &
			ldc_Concentracao, &
			ldc_Concentracao_De, &
			ldc_Volume, &
			ldc_Volume_De, &
			ldc_Peso_Grama_De, &
			ldc_Peso_Grama,&
			ldc_Peso_Grama_Apresentacao_De,&
			ldc_Peso_Grama_Apresentacao			

Long	lvl_Embalagem, &
		lvl_Embalagem_De,&
		lvl_Qt_Pontos_Resgate,&
		lvl_Qt_Pontos_Resgate_De, &
		ll_Planograma, &
		ll_Planograma_De, &
		ll_Marca_De, &
		ll_Marca,&
		ll_EmbalagemVenda,&
		ll_EmbalagemVenda_De, &
		ll_Mix
		
String	lvs_Produto_Fornecedor, &
		lvs_Produto_Fornecedor_De, &
		ls_Nulo,&
		ls_apresentacao, &
		lvs_Situacao, &
		lvs_Situacao_De, &			
		lvs_st_origem, &
		lvs_st_origem_De,&
		ls_Lei_Generico_De,&
		ls_Lei_Generico,&
		ls_Lei_Generico_De_PC,&
		ls_Medida_Compra,&
		ls_Medida_Compra_De,&
		ls_Medida_Venda, &
		ls_Medida_Venda_De,&
		ls_Linha,&
		ls_Linha_De, &
		ls_Possui_Dev, &
		ls_Possui_Dev_De,&
		ls_Lactose,&
		ls_Lactose_De,&
		ls_Gluten,&
		ls_Gluten_De,&
		ls_Acucar,&
		ls_Acucar_De,&
		ls_Desc_Compra_De,&
		ls_Desc_Venda_De,&
		ls_Descricao_De,&
		ls_Desc_Compra,&
		ls_Desc_Venda,&
		ls_Descricao,&
		ls_TipoApresentacao,&
		ls_TipoApresentacao_De, &
		ls_Motivo, &
		ls_Mensagem, &
		ls_Matric_Solic_De, &
		ls_Matric_Solic_Para

dw_1.AcceptText()

SetNull(ls_Nulo)

//**** IMPORTANTE
//***** A coluna produto_geral.dh_atualizacao N$$HEX1$$c300$$ENDHEX$$O PODE SER ATUALIZADA VIA PROGRAMA
Select pc.cd_produto_fornecedor, pg.nr_embalagem_padrao, pg.id_situacao, cd_st_origem,
		qt_pontos_resgate, pg.id_lei_generico, pc.id_lei_generico, pg.cd_unidade_medida_compra,
		pg.cd_unidade_medida_venda, pg.cd_linha_produto, pg.cd_planograma, pg.cd_marca,
		pg.id_permite_devolucao,pg.qt_unidades_embalagem, pg.id_contem_lactose, pg.id_contem_gluten, pg.id_contem_acucar, pc.pc_desconto_fornecedor,
		pg.de_apresentacao_estoque, pg.de_apresentacao_venda, pg.de_produto,
		pg.qt_concentracao, pg.vl_volume, tp.de_apresentacao, pg.qt_peso_grama, pc.nr_matric_solicitacao_alt_sit,
		pc.qt_peso_apresentacao
Into:lvs_Produto_Fornecedor_De, :lvl_Embalagem_De, :lvs_Situacao_De, :lvs_st_origem_De,
	 :lvl_Qt_Pontos_Resgate_De, :ls_Lei_Generico_De, :ls_Lei_Generico_De_PC, :ls_Medida_Compra_De,
	 :ls_Medida_Venda_De, :ls_Linha_De, :ll_Planograma_De, :ll_Marca_De, :ls_Possui_Dev_De, :ll_EmbalagemVenda_De, :ls_Lactose_De, :ls_Gluten_De, :ls_Acucar_De, :ldc_Desc_Forn_De,
	 :ls_Desc_Compra_De,:ls_Desc_Venda_De,:ls_Descricao_De,
	 :ldc_Concentracao_De,:ldc_Volume_De, :ls_TipoApresentacao_De, :ldc_Peso_Grama_De, :ls_Matric_Solic_De, :ldc_Peso_Grama_Apresentacao_De
From produto_geral pg
	Inner Join produto_central pc
		On pc.cd_produto = pg.cd_produto
	Left Join tipo_apresentacao_produto tp
		On tp.id_apresentacao = pg.id_apresentacao
Where pc.cd_produto = :al_produto
Using SqlCa;

If SqlCa.SqlCode = 0 Then
	Choose Case as_Tipo
		Case "1"
			lvl_Embalagem = Long(aa_Dado)
			
			//**** IMPORTANTE
			//***** A coluna produto_geral.dh_atualizacao N$$HEX1$$c300$$ENDHEX$$O PODE SER ATUALIZADA VIA PROGRAMA
			
			Update produto_geral
				Set nr_embalagem_padrao = :lvl_Embalagem
			 Where cd_produto = :al_Produto
			 	and coalesce(nr_embalagem_padrao,0) <> coalesce(:lvl_Embalagem,0)
			 Using SqlCa;
			 
			 If SqlCa.SqlCode = -1 Then
				ls_Mensagem = "Atualiza$$HEX2$$e700e300$$ENDHEX$$o da embalagem padr$$HEX1$$e300$$ENDHEX$$o na tabela 'produto_geral'. " + SQLCA.SQLErrText
				SqlCa.of_RollBack();
				lb_Sucesso = False
			Else
				If Not wf_grava_historico(al_produto, String(lvl_Embalagem_De), String(lvl_Embalagem), 'PRODUTO_GERAL', 'NR_EMBALAGEM_PADRAO') Then
					Return False
			 	End If
			End If
			
		Case "2"
			lvs_Produto_Fornecedor = String(aa_Dado)
			
			//**** IMPORTANTE
			//***** A coluna produto_geral.dh_atualizacao N$$HEX1$$c300$$ENDHEX$$O PODE SER ATUALIZADA VIA PROGRAMA
			
			Update produto_central
				Set cd_produto_fornecedor = :lvs_Produto_Fornecedor
			 Where cd_produto = :al_Produto
			 	and coalesce(cd_produto_fornecedor,'') <> coalesce(:lvs_Produto_Fornecedor,'')
			 Using SqlCa;
			 
			 If SqlCa.SqlCode = -1 Then
				ls_Mensagem = "Atualiza$$HEX2$$e700e300$$ENDHEX$$o do c$$HEX1$$f300$$ENDHEX$$digo do produto fornecedor na tabela 'produto_central'. " + SQLCA.SQLErrText
				SqlCa.of_RollBack();
				lb_Sucesso = False
			Else
				If Not wf_grava_historico(al_produto, lvs_Produto_Fornecedor_De, lvs_Produto_Fornecedor, 'PRODUTO_CENTRAL', 'CD_PRODUTO_FORNECEDOR') Then
					Return False
				End If
			End If

		Case "3"
			
			ls_Motivo 				= dw_1.Object.de_Motivo	[1]
			ls_Matric_Solic_Para 	= dw_1.Object.Nr_Matricula	[1]
			
			//**** IMPORTANTE
			//***** A coluna produto_geral.dh_atualizacao N$$HEX1$$c300$$ENDHEX$$O PODE SER ATUALIZADA VIA PROGRAMA
			
			Update produto_geral
				Set id_situacao = 'P',
					 nr_matricula_atualizacao = :gvo_aplicacao.ivo_seguranca.nr_matricula
			 Where cd_produto = :al_Produto
			     and id_situacao = 'A'
			 Using SqlCa;
			 
			 If SqlCa.SqlCode = -1 Then
				ls_Mensagem = "Atualiza$$HEX2$$e700e300$$ENDHEX$$o da situa$$HEX2$$e700e300$$ENDHEX$$o do produto na tabela 'produto_geral'. " + SQLCA.SQLErrText
				SqlCa.of_RollBack();
				lb_Sucesso = False
			End If
			 
			 If SqlCa.SqlCode = 0 Then			 			 
				 Update produto_central
					Set dh_situacao 						= getdate(),
						 nr_matric_alteracao_situacao	= :is_Usuario,
						 de_alteracao_situacao 			= :ls_Motivo,
						 nr_matric_solicitacao_alt_sit	= :ls_Matric_Solic_Para
				 Where cd_produto = :al_Produto
				 Using SqlCa;
			 
				 If SqlCa.SqlCode = -1 Then
					ls_Mensagem = "Atualiza$$HEX2$$e700e300$$ENDHEX$$o do respons$$HEX1$$e100$$ENDHEX$$vel pela altera$$HEX2$$e700e300$$ENDHEX$$o na situa$$HEX2$$e700e300$$ENDHEX$$o do produto na tabela 'produto_geral'. " + SQLCA.SQLErrText
					SqlCa.of_RollBack();
					lb_Sucesso = False
				End If
				
				If Not wf_grava_historico(al_produto, lvs_situacao_De, 'P', 'PRODUTO_GERAL', 'ID_SITUACAO') Then
					Return False
				End If
				
				If Not wf_grava_historico(al_produto, ls_Matric_Solic_De, ls_Matric_Solic_Para, 'PRODUTO_CENTRAL', 'NR_MATRIC_SOLICITACAO_ALT_SIT') Then
					Return False
				End If				
			 End If
			
		Case "4"	
			lvs_st_origem = String(aa_Dado)
			
			//**** IMPORTANTE
			//***** A coluna produto_geral.dh_atualizacao N$$HEX1$$c300$$ENDHEX$$O PODE SER ATUALIZADA VIA PROGRAMA
			
			Update produto_geral
				Set cd_st_origem  = :lvs_st_origem,
					 nr_matricula_atualizacao = :gvo_aplicacao.ivo_seguranca.nr_matricula
			 Where cd_produto = :al_Produto
			 	And coalesce(cd_st_origem,'')  <> coalesce(:lvs_st_origem,'')
			 Using SqlCa;
			 
			 If SqlCa.SqlCode = -1 Then
				ls_Mensagem = "Atualiza$$HEX2$$e700e300$$ENDHEX$$o da origem do produto na tabela 'produto_geral'. " + SQLCA.SQLErrText
				SqlCa.of_RollBack();
				lb_Sucesso = False
			Else
				If Not wf_grava_historico(al_produto, lvs_st_origem_De, lvs_st_origem, 'PRODUTO_GERAL', 'CD_ST_ORIGEM') Then
					Return False
				End If
			End If
			 
			If lb_Sucesso Then
				If lvs_st_origem_De <> lvs_st_origem Then
					
					Update produto_central
						Set id_revisao_fiscal	= 'P'
					 Where cd_produto    	= :al_Produto
						And coalesce(id_revisao_fiscal,'') <> 'P'
					 Using SqlCa;
					 
					 If SqlCa.SqlCode = -1 Then
						ls_Mensagem = "Atualiza$$HEX2$$e700e300$$ENDHEX$$o revis$$HEX1$$e300$$ENDHEX$$o fiscal na tabela 'produto_central'. " + SQLCA.SQLErrText
						SqlCa.of_RollBack();
						lb_Sucesso = False
					Else
						If Not wf_grava_historico(al_produto, lvs_st_origem_De, lvs_st_origem, 'PRODUTO_CENTRAL', 'ID_REVISAO_FISCAL') Then
							Return False
						End If
					End If
				End If
			End If
			
		Case "5"
			ll_Mix = Long(aa_Dado)
			
			//**** IMPORTANTE
			//***** A coluna produto_geral.dh_atualizacao N$$HEX1$$c300$$ENDHEX$$O PODE SER ATUALIZADA VIA PROGRAMA
			
			Update produto_central
				Set cd_mix_produto  	= :ll_Mix
			 Where cd_produto    	= :al_Produto
			 	And coalesce(cd_mix_produto,0) <> coalesce(:ll_Mix,0)
			 Using SqlCa;
			 
			 If SqlCa.SqlCode = -1 Then
				ls_Mensagem = "Atualiza$$HEX2$$e700e300$$ENDHEX$$o do mix do produto na tabela 'produto_central'. " + SQLCA.SQLErrText
				SqlCa.of_RollBack();
				lb_Sucesso = False
			Else
				If Not wf_grava_historico(al_produto, lvs_st_origem_De, lvs_st_origem, 'PRODUTO_CENTRAL', 'CD_MIX_PRODUTO') Then
					Return False
				End If
			End If

		Case "6"		
			lvl_Qt_Pontos_Resgate = Long(aa_Dado)
			
			//**** IMPORTANTE
			//***** A coluna produto_geral.dh_atualizacao N$$HEX1$$c300$$ENDHEX$$O PODE SER ATUALIZADA VIA PROGRAMA
			
			Update produto_geral
				Set qt_pontos_resgate  			= :lvl_Qt_Pontos_Resgate,
					 nr_matricula_atualizacao	= :gvo_aplicacao.ivo_seguranca.nr_matricula
			 Where cd_produto    				= :al_Produto
			 	And coalesce(qt_pontos_resgate,0)	<> coalesce(:lvl_Qt_Pontos_Resgate,0)
			 Using SqlCa;
			 
			 If SqlCa.SqlCode = -1 Then
				ls_Mensagem = "Atualiza$$HEX2$$e700e300$$ENDHEX$$o da quantidade de pontos para resgate na tabela 'produto_geral'. " + SQLCA.SQLErrText
				SqlCa.of_RollBack();
				lb_Sucesso = False
			Else
				If Not wf_grava_historico(al_produto, String(lvl_Qt_Pontos_Resgate_De), String(lvl_Qt_Pontos_Resgate), 'PRODUTO_GERAL', 'QT_PONTOS_RESGATE') Then
					Return False
				End If
			End If
						
		Case "8"
			ls_Lei_Generico = String(aa_Dado)
			
			//**** IMPORTANTE
			//***** A coluna produto_geral.dh_atualizacao N$$HEX1$$c300$$ENDHEX$$O PODE SER ATUALIZADA VIA PROGRAMA
			
			If IsNull(ls_Lei_Generico) or (ls_Lei_Generico <> 'R' and ls_Lei_Generico <> 'S' and ls_Lei_Generico <> 'G'  and ls_Lei_Generico <> 'E') Then
				Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Atualiza$$HEX2$$e700e300$$ENDHEX$$o do LEI GENERICO diferente do esperado R/S/G/E.", Exclamation!)
				Return False
			End If
			
			Update produto_geral
				Set id_lei_generico  				= :ls_Lei_Generico,
					 nr_matricula_atualizacao	= :gvo_aplicacao.ivo_seguranca.nr_matricula
			 Where cd_produto					= :al_Produto
			 	And coalesce(id_lei_generico,'')<> coalesce(:ls_Lei_Generico,'')
			 Using SqlCa;
			 
			 If SqlCa.SqlCode = -1 Then
				ls_Mensagem = "Atualiza$$HEX2$$e700e300$$ENDHEX$$o da LEI GENERICO 'produto_geral'. " + SQLCA.SQLErrText
				SqlCa.of_RollBack();
				lb_Sucesso = False
			 Else
				 If Not wf_grava_historico(al_produto, ls_Lei_Generico_De, ls_Lei_Generico, 'PRODUTO_GERAL', 'ID_LEI_GENERICO') Then
					Return False
				End If	
			End If
			
			If lb_Sucesso Then
				Update produto_central
					Set id_lei_generico  	= :ls_Lei_Generico,
						 id_revisao_fiscal	= 'P'
				 Where cd_produto    	= :al_Produto
					And coalesce(id_lei_generico,'') <> coalesce(:ls_Lei_Generico,'')
				 Using SqlCa;
				 
				 If SqlCa.SqlCode = -1 Then
					ls_Mensagem = "Atualiza$$HEX2$$e700e300$$ENDHEX$$o da LEI GENERICO 'produto_central'. " + SQLCA.SQLErrText
					SqlCa.of_RollBack();
					lb_Sucesso = False
				 Else
					 If Not wf_grava_historico(al_produto, ls_Lei_Generico_De_PC, ls_Lei_Generico, 'PRODUTO_CENTRAL', 'ID_LEI_GENERICO') Then
						Return False
					End If	
				End If
			End If
			
		Case "9"
			ls_Medida_Compra = String(aa_Dado)
			
			//**** IMPORTANTE
			//***** A coluna produto_geral.dh_atualizacao N$$HEX1$$c300$$ENDHEX$$O PODE SER ATUALIZADA VIA PROGRAMA
			
			Update produto_geral
				Set cd_unidade_medida_compra  	= :ls_Medida_Compra,
					 nr_matricula_atualizacao		= :gvo_aplicacao.ivo_seguranca.nr_matricula
			 Where cd_produto    									= :al_Produto
			 	And coalesce(cd_unidade_medida_compra,'')  	<> coalesce(:ls_Medida_Compra,'')
			 Using SqlCa;
			 
			  If SqlCa.SqlCode = -1 Then
				ls_Mensagem = "Atualiza$$HEX2$$e700e300$$ENDHEX$$o da unidade de compra 'PRODUTO_GERAL'. " + SQLCA.SQLErrText
				SqlCa.of_RollBack();
				lb_Sucesso = False
			 Else
				 If Not wf_grava_historico(al_produto, ls_Medida_Compra_De, ls_Medida_Compra, 'PRODUTO_GERAL', 'CD_UNIDADE_MEDIDA_COMPRA') Then
					Return False
				End If	
			End If
			
		Case "10"
			ls_Medida_Venda = String(aa_Dado)
			
			//**** IMPORTANTE
			//***** A coluna produto_geral.dh_atualizacao N$$HEX1$$c300$$ENDHEX$$O PODE SER ATUALIZADA VIA PROGRAMA
			
			Update produto_geral
				Set cd_unidade_medida_venda  	= :ls_Medida_Venda,
					 nr_matricula_atualizacao		= :gvo_aplicacao.ivo_seguranca.nr_matricula
			 Where cd_produto    								= :al_Produto
			 	And coalesce(cd_unidade_medida_venda, '') <> coalesce(:ls_Medida_Venda,'')
			 Using SqlCa;
			
			 If SqlCa.SqlCode = -1 Then
				ls_Mensagem = "Atualiza$$HEX2$$e700e300$$ENDHEX$$o da unidade de venda 'PRODUTO_GERAL'. " + SQLCA.SQLErrText
				SqlCa.of_RollBack();
				lb_Sucesso = False
			 Else
				If Not wf_grava_historico(al_produto, ls_Medida_Venda_De, ls_Medida_Venda, 'PRODUTO_GERAL', 'CD_UNIDADE_MEDIDA_VENDA') Then
					Return False
				End If	
			End If
		
		Case "11"
			ls_Linha = String(aa_Dado)
			
			//**** IMPORTANTE
			//***** A coluna produto_geral.dh_atualizacao N$$HEX1$$c300$$ENDHEX$$O PODE SER ATUALIZADA VIA PROGRAMA
			
			Update produto_geral
				Set cd_linha_produto  = :ls_Linha,
					 nr_matricula_atualizacao = :gvo_aplicacao.ivo_seguranca.nr_matricula
			 Where cd_produto    	= :al_Produto
			 	And coalesce(cd_linha_produto,'') <> coalesce(:ls_Linha,'')
			 Using SqlCa;
			 
			 If SqlCa.SqlCode = -1 Then
				ls_Mensagem = "Atualiza$$HEX2$$e700e300$$ENDHEX$$o da linha de produto 'PRODUTO_GERAL'. " + SQLCA.SQLErrText
				SqlCa.of_RollBack();
				lb_Sucesso = False
			 Else
				If Not wf_grava_historico(al_produto, ls_Linha_De, ls_Linha, 'PRODUTO_GERAL', 'CD_LINHA_PRODUTO') Then
					Return False
				End If	
			End If
			
		Case "13"
			
			//**** IMPORTANTE
			//***** A coluna produto_geral.dh_atualizacao N$$HEX1$$c300$$ENDHEX$$O PODE SER ATUALIZADA VIA PROGRAMA
			
			ll_Planograma = Long(aa_Dado)
						
			Update produto_geral
				Set cd_planograma = :ll_Planograma,
					 nr_matricula_atualizacao = :gvo_aplicacao.ivo_seguranca.nr_matricula
			Where cd_produto = :al_Produto
				And coalesce(cd_planograma,0) <> coalesce(:ll_Planograma,0)
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				ls_Mensagem = "Atualiza$$HEX2$$e700e300$$ENDHEX$$o do planograma do produto '" + String(al_Produto) + "' 'PRODUTO_GERAL'. " + SQLCA.SQLErrText
				SqlCa.of_RollBack();
				lb_Sucesso = False
			Else
				If IsNull(ll_Planograma_De) Then
					If Not wf_grava_historico(al_produto, ls_Nulo, String(ll_Planograma), 'PRODUTO_GERAL', 'CD_PLANOGRAMA') Then
						Return False
					End If	
				Else
					If ll_Planograma_De <> ll_Planograma Then
						If Not wf_grava_historico(al_produto, String(ll_Planograma_De), String(ll_Planograma), 'PRODUTO_GERAL', 'CD_PLANOGRAMA') Then
							Return False
						End If
					End If
				End If
			End If
			
		Case "14"
			
			ll_Marca = Long(aa_Dado)
			
			//**** IMPORTANTE
			//***** A coluna produto_geral.dh_atualizacao N$$HEX1$$c300$$ENDHEX$$O PODE SER ATUALIZADA VIA PROGRAMA
						
			Update produto_geral
				Set cd_marca = :ll_Marca,
					 nr_matricula_atualizacao = :gvo_aplicacao.ivo_seguranca.nr_matricula
			Where cd_produto = :al_Produto
				And coalesce(cd_marca,0) <> coalesce(:ll_Marca,0)
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				ls_Mensagem = "Atualiza$$HEX2$$e700e300$$ENDHEX$$o da marca do produto '" + String(al_Produto) + "' 'PRODUTO_GERAL'. " + SQLCA.SQLErrText
				SqlCa.of_RollBack();
				lb_Sucesso = False
			Else
				If IsNull(ll_Marca_De) Then
					If Not wf_grava_historico(al_produto, ls_Nulo, String(ll_Marca), 'PRODUTO_GERAL', 'CD_MARCA') Then
						Return False
					End If	
				Else
					If ll_Marca_De <> ll_Marca Then
						If Not wf_grava_historico(al_produto, String(ll_Marca_De), String(ll_Marca), 'PRODUTO_GERAL', 'CD_MARCA') Then
							Return False
						End If
					End If
				End If
			End If
			
		Case "15"
			ls_Possui_Dev = String(aa_Dado)
			
			//**** IMPORTANTE
			//***** A coluna produto_geral.dh_atualizacao N$$HEX1$$c300$$ENDHEX$$O PODE SER ATUALIZADA VIA PROGRAMA
			
			Update produto_geral
				Set id_permite_devolucao = :ls_Possui_Dev,
					 nr_matricula_atualizacao = :gvo_aplicacao.ivo_seguranca.nr_matricula
			Where cd_produto = :al_Produto
				And coalesce(id_permite_devolucao,'') <> coalesce(:ls_Possui_Dev,'')
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				ls_Mensagem = "Atualiza$$HEX2$$e700e300$$ENDHEX$$o do id_permite_devolucao do produto '" + String(al_Produto) + "' 'PRODUTO_GERAL'. " + SQLCA.SQLErrText
				SqlCa.of_RollBack();
				lb_Sucesso = False
			Else
				If IsNull(ls_Possui_Dev_De) Or Trim(ls_Possui_Dev_De) = "" Then
					If Not wf_grava_historico(al_produto, ls_Nulo, ls_Possui_Dev, 'PRODUTO_GERAL', 'ID_PERMITE_DEVOLUCAO') Then
						Return False
					End If	
				Else
					If ls_Possui_Dev_De <> ls_Possui_Dev Then
						If Not wf_grava_historico(al_produto, ls_Possui_Dev_De, ls_Possui_Dev, 'PRODUTO_GERAL', 'ID_PERMITE_DEVOLUCAO') Then
							Return False
						End If
					End If
				End If
			End If					
		
		Case "20"
			ll_EmbalagemVenda = Long(aa_Dado)
			
			//**** IMPORTANTE
			//***** A coluna produto_geral.dh_atualizacao N$$HEX1$$c300$$ENDHEX$$O PODE SER ATUALIZADA VIA PROGRAMA
			
			Update produto_geral
			Set qt_unidades_embalagem = :ll_EmbalagemVenda,
				 nr_matricula_atualizacao = :gvo_aplicacao.ivo_seguranca.nr_matricula
			Where cd_produto = :al_Produto
				And coalesce(qt_unidades_embalagem,0) <> coalesce(:ll_EmbalagemVenda,0)
			Using SqlCa;			 
			
			If SqlCa.SqlCode = -1 Then
				ls_Mensagem = "Atualiza$$HEX2$$e700e300$$ENDHEX$$o de Unidades Embalagem '" + String(al_Produto) + "' 'PRODUTO_GERAL'. " + SQLCA.SQLErrText
				SqlCa.of_RollBack();
				lb_Sucesso = False
			Else
				If IsNull(ll_EmbalagemVenda_De) Then
					If Not wf_grava_historico(al_produto, ls_Nulo, String(ll_EmbalagemVenda), 'PRODUTO_GERAL', 'QT_UNIDADES_EMBALAGEM') Then
						Return False
					End If	
				Else
					If ll_EmbalagemVenda_De <> ll_EmbalagemVenda Then
						If Not wf_grava_historico(al_produto, String(ll_EmbalagemVenda_De), String(ll_EmbalagemVenda), 'PRODUTO_GERAL', 'QT_UNIDADES_EMBALAGEM') Then
							Return False
						End If
					End If
				End If
			End If	
		
		Case '21'
			
			ls_Lactose = String(aa_Dado)
			
			//**** IMPORTANTE
			//***** A coluna produto_geral.dh_atualizacao N$$HEX1$$c300$$ENDHEX$$O PODE SER ATUALIZADA VIA PROGRAMA
						
			Update produto_geral
				Set id_contem_lactose  			= :ls_Lactose,
					 nr_matricula_atualizacao	= :gvo_aplicacao.ivo_seguranca.nr_matricula
			 Where cd_produto					= :al_Produto
			 	And coalesce(id_contem_lactose,'')<> coalesce(:ls_Lactose,'')
			 Using SqlCa;
			 
			 If SqlCa.SqlCode = -1 Then
				ls_Mensagem = "Atualiza$$HEX2$$e700e300$$ENDHEX$$o da CONTEM LACTOSE 'produto_geral'. " + SQLCA.SQLErrText
				SqlCa.of_RollBack();
				lb_Sucesso = False
			 Else
				 If Not wf_grava_historico(al_produto, ls_Lactose_De, ls_Lactose, 'PRODUTO_GERAL', 'ID_CONTEM_LACTOSE') Then
					Return False
				End If	
			End If
		
		Case '22'
			
			ls_Gluten = String(aa_Dado)
			
			//**** IMPORTANTE
			//***** A coluna produto_geral.dh_atualizacao N$$HEX1$$c300$$ENDHEX$$O PODE SER ATUALIZADA VIA PROGRAMA
						
			Update produto_geral
				Set id_contem_gluten  			= :ls_Gluten,
					 nr_matricula_atualizacao	= :gvo_aplicacao.ivo_seguranca.nr_matricula
			 Where cd_produto					= :al_Produto
			 	And coalesce(id_contem_gluten,'')<> coalesce(:ls_Gluten,'')
			 Using SqlCa;
			 
			 If SqlCa.SqlCode = -1 Then
				ls_Mensagem = "Atualiza$$HEX2$$e700e300$$ENDHEX$$o da CONTEM GLUTEN 'produto_geral'. " + SQLCA.SQLErrText
				SqlCa.of_RollBack();
				lb_Sucesso = False
			 Else
				 If Not wf_grava_historico(al_produto, ls_Gluten_De, ls_Gluten, 'PRODUTO_GERAL', 'ID_CONTEM_GLUTEN') Then
					Return False
				End If	
			End If
		
		Case '23'
			
			ls_Acucar = String(aa_Dado)
			
			//**** IMPORTANTE
			//***** A coluna produto_geral.dh_atualizacao N$$HEX1$$c300$$ENDHEX$$O PODE SER ATUALIZADA VIA PROGRAMA
						
			Update produto_geral
				Set id_contem_acucar  			= :ls_Acucar,
					 nr_matricula_atualizacao	= :gvo_aplicacao.ivo_seguranca.nr_matricula
			 Where cd_produto					= :al_Produto
			 	And coalesce(id_contem_acucar,'')<> coalesce(:ls_Acucar,'')
			 Using SqlCa;
			 
			 If SqlCa.SqlCode = -1 Then
				ls_Mensagem = "Atualiza$$HEX2$$e700e300$$ENDHEX$$o da CONTEM ACUCAR 'produto_geral'. " + SQLCA.SQLErrText
				SqlCa.of_RollBack();
				lb_Sucesso = False
			 Else
				 If Not wf_grava_historico(al_produto, ls_Acucar_De, ls_Acucar, 'PRODUTO_GERAL', 'ID_CONTEM_ACUCAR') Then
					Return False
				End If	
			End If
			
		Case '24'
			
			ldc_Desc_Forn = Dec(aa_Dado)
					
			//**** IMPORTANTE
			//***** A coluna produto_geral.dh_atualizacao N$$HEX1$$c300$$ENDHEX$$O PODE SER ATUALIZADA VIA PROGRAMA
			
			Update produto_central
				Set pc_desconto_fornecedor = :ldc_Desc_Forn
			Where cd_produto = :al_Produto
				And coalesce(pc_desconto_fornecedor, 0.00) <> coalesce(:ldc_Desc_Forn, 0.00)
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				ls_Mensagem = "Atualiza$$HEX2$$e700e300$$ENDHEX$$o do pc_desconto_fornecedor do produto '" + String(al_Produto) + "' 'PRODUTO_CENTRAL'. " + SQLCA.SQLErrText
				SqlCa.of_RollBack();
				lb_Sucesso = False
			Else
				If ldc_Desc_Forn_De <> ldc_Desc_Forn Then
					If Not wf_grava_historico(al_produto, String(ldc_Desc_Forn_De), String(ldc_Desc_Forn), 'PRODUTO_CENTRAL', 'PC_DESCONTO_FORNECEDOR') Then
						Return False
					End If
				End If
			End If					
			
		Case '25'
			ls_Desc_Compra = String(aa_Dado)
		
			//**** IMPORTANTE
			//***** A coluna produto_geral.dh_atualizacao N$$HEX1$$c300$$ENDHEX$$O PODE SER ATUALIZADA VIA PROGRAMA
			Update produto_geral
				Set de_apresentacao_estoque	= :ls_Desc_Compra,
					 nr_matricula_atualizacao	= :gvo_aplicacao.ivo_seguranca.nr_matricula
			 Where cd_produto					= :al_Produto
			 	And coalesce(de_apresentacao_estoque,'')<> coalesce(:ls_Desc_Compra,'')
			 Using SqlCa;
			 
			 If SqlCa.SqlCode = -1 Then
				ls_Mensagem = "Atualiza$$HEX2$$e700e300$$ENDHEX$$o da Apresenta$$HEX2$$e700e300$$ENDHEX$$o de Compra 'produto_geral'. " + SQLCA.SQLErrText
				SqlCa.of_RollBack();
				lb_Sucesso = False
			 Else
				 If Not wf_grava_historico(al_produto, ls_Desc_Compra_De, ls_Desc_Compra, 'PRODUTO_GERAL', 'DE_APRESENTACAO_ESTOQUE') Then
					Return False
				End If
			End If
		
		Case '26'
			ls_Desc_Venda = String(aa_Dado)
			
			//**** IMPORTANTE
			//***** A coluna produto_geral.dh_atualizacao N$$HEX1$$c300$$ENDHEX$$O PODE SER ATUALIZADA VIA PROGRAMA
			Update produto_geral
				Set de_apresentacao_venda  	= :ls_Desc_Venda,
					 nr_matricula_atualizacao	= :gvo_aplicacao.ivo_seguranca.nr_matricula
			 Where cd_produto					= :al_Produto
			 	And coalesce(de_apresentacao_venda,'')<> coalesce(:ls_Desc_Venda,'')
			 Using SqlCa;
			 
			 If SqlCa.SqlCode = -1 Then
				ls_Mensagem = "Atualiza$$HEX2$$e700e300$$ENDHEX$$o da Apresentacao Venda 'produto_geral'. " + SQLCA.SQLErrText
				SqlCa.of_RollBack();
				lb_Sucesso = False
			 Else
				 If Not wf_grava_historico(al_produto, ls_Desc_Venda_De, ls_Desc_Venda, 'PRODUTO_GERAL', 'DE_APRESENTACAO_VENDA') Then
					Return False
				End If	
			End If			
				
		Case '27'
			ls_Descricao = String(aa_Dado)
			
			//**** IMPORTANTE
			//***** A coluna produto_geral.dh_atualizacao N$$HEX1$$c300$$ENDHEX$$O PODE SER ATUALIZADA VIA PROGRAMA
			Update produto_geral
				Set de_produto						= :ls_Descricao,
					 nr_matricula_atualizacao	= :gvo_aplicacao.ivo_seguranca.nr_matricula
			 Where cd_produto					= :al_Produto
			 	And coalesce(de_produto,'')<> coalesce(:ls_Descricao,'')
			 Using SqlCa;
			 
			 If SqlCa.SqlCode = -1 Then
				ls_Mensagem = "Atualiza$$HEX2$$e700e300$$ENDHEX$$o da Descricao do Produto 'produto_geral'. " + SQLCA.SQLErrText
				SqlCa.of_RollBack();
				lb_Sucesso = False
			 Else
				 If Not wf_grava_historico(al_produto, ls_Descricao_De, ls_Descricao, 'PRODUTO_GERAL', 'DE_PRODUTO') Then
					Return False
				End If	
			End If		
			
			Case '28'
				ls_TipoApresentacao = String(aa_Dado)
			
				select id_apresentacao
				Into   :ls_apresentacao
				from tipo_apresentacao_produto
				where de_apresentacao = :ls_TipoApresentacao
				Using SqlCA;
			
				If SqlCa.SqlCode = -1 Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na valida$$HEX2$$e700e300$$ENDHEX$$o campo ID_APRESENTACAO 'produto_geral'. " + SQLCA.SQLErrText)
					Return False
				End If
				
				If  (ls_TipoApresentacao_De<>ls_TipoApresentacao)  or IsNull(ls_TipoApresentacao_De) Then 
					//**** IMPORTANTE
					//***** A coluna produto_geral.dh_atualizacao N$$HEX1$$c300$$ENDHEX$$O PODE SER ATUALIZADA VIA PROGRAMA
					Update produto_geral
					Set id_apresentacao				= :ls_apresentacao,
						 nr_matricula_atualizacao	= :gvo_aplicacao.ivo_seguranca.nr_matricula
					Where cd_produto					= :al_Produto
					And coalesce(id_apresentacao,'')<>coalesce(:ls_apresentacao,'')				
					Using SqlCa;
					 
					If SqlCa.SqlCode = -1 Then
						ls_Mensagem = "Atualiza$$HEX2$$e700e300$$ENDHEX$$o da Tipo de Apresenta$$HEX2$$e700e300$$ENDHEX$$o 'produto_geral'. " + SQLCA.SQLErrText
						SqlCa.of_RollBack();
						lb_Sucesso = False
					Else
						If Not wf_grava_historico(al_produto, ls_TipoApresentacao_De, ls_TipoApresentacao, 'PRODUTO_GERAL', 'ID_APRESENTACAO') Then
							Return False
						End If					
					End If 
				End If
			
			Case '29'
				ldc_Concentracao = Dec(aa_Dado)
				
				//**** IMPORTANTE
				//***** A coluna produto_geral.dh_atualizacao N$$HEX1$$c300$$ENDHEX$$O PODE SER ATUALIZADA VIA PROGRAMA
				Update produto_geral
					Set qt_concentracao						= :ldc_Concentracao,
						 nr_matricula_atualizacao			= :gvo_aplicacao.ivo_seguranca.nr_matricula
				 Where cd_produto							= :al_Produto
					And coalesce(qt_concentracao,0.00) <> coalesce(:ldc_Concentracao,0.00)
				 Using SqlCa;
				 
				 If SqlCa.SqlCode = -1 Then
					ls_Mensagem = "Atualiza$$HEX2$$e700e300$$ENDHEX$$o da Quantidade de Concentra$$HEX2$$e700e300$$ENDHEX$$o 'produto_geral'. " + SQLCA.SQLErrText
					SqlCa.of_RollBack();
					lb_Sucesso = False
				 Else
					 If Not wf_grava_historico(al_produto, String(ldc_Concentracao_De), String(ldc_Concentracao), 'PRODUTO_GERAL', 'QT_CONCENTRACAO') Then
						Return False
					End If	
				End If			
			
			Case '30'
				ldc_Volume = Dec(aa_Dado)
				
				//**** IMPORTANTE
				//***** A coluna produto_geral.dh_atualizacao N$$HEX1$$c300$$ENDHEX$$O PODE SER ATUALIZADA VIA PROGRAMA
				Update produto_geral
					Set vl_volume						= :ldc_Volume,
						 nr_matricula_atualizacao	= :gvo_aplicacao.ivo_seguranca.nr_matricula
				 Where cd_produto					= :al_Produto
					And coalesce(vl_volume,0.00) <> coalesce(:ldc_Volume,0.00)
				 Using SqlCa;
				 
				 If SqlCa.SqlCode = -1 Then
					ls_Mensagem = "Atualiza$$HEX2$$e700e300$$ENDHEX$$o da CONTEM GLUTEN 'produto_geral'. " + SQLCA.SQLErrText
					SqlCa.of_RollBack();
					lb_Sucesso = False
				 Else
					 If Not wf_grava_historico(al_produto, String(ldc_Volume_De), String(ldc_Volume), 'PRODUTO_GERAL', 'VL_VOLUME') Then
						Return False
					End If	
				End If
						
			Case '31'
			ldc_Peso_Grama = Dec(aa_Dado)			
			
			If ldc_Peso_Grama>=5 Then 
			   MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existe Produto com Quantidade Peso Grama Maior que 5Kg.")
			   Return False
			End If 
			
			//**** IMPORTANTE
			//***** A coluna produto_geral.dh_atualizacao N$$HEX1$$c300$$ENDHEX$$O PODE SER ATUALIZADA VIA PROGRAMA
			Update produto_geral
				Set qt_peso_grama				= :ldc_Peso_Grama,
					 nr_matricula_atualizacao	= :gvo_aplicacao.ivo_seguranca.nr_matricula
			 Where cd_produto					= :al_Produto
			 	And coalesce(qt_peso_grama,0)<> coalesce(:ldc_Peso_Grama,0)
			 Using SqlCa;
			 
			 If SqlCa.SqlCode = -1 Then
				ls_Mensagem = "Atualiza$$HEX2$$e700e300$$ENDHEX$$o da Quantidade Peso Grama 'produto_geral'. " + SQLCA.SQLErrText
				SqlCa.of_RollBack();
				lb_Sucesso = False
			 Else
				 If Not wf_grava_historico(al_produto, String(ldc_Peso_Grama_De), String(ldc_Peso_Grama), 'PRODUTO_GERAL', 'QT_PESO_GRAMA') Then
					Return False
				End If
			End If

			Case '32'
				ldc_Peso_Grama_Apresentacao = Dec(aa_Dado)			
			
				//**** IMPORTANTE
				//***** A coluna produto_geral.dh_atualizacao N$$HEX1$$c300$$ENDHEX$$O PODE SER ATUALIZADA VIA PROGRAMA
				Update produto_central
				Set qt_peso_apresentacao			= :ldc_Peso_Grama_Apresentacao				
				Where cd_produto						= :al_Produto
			 	And coalesce(qt_peso_apresentacao,0)<> coalesce(:ldc_Peso_Grama_Apresentacao,0)
				Using SqlCa;
			 
				 If SqlCa.SqlCode = -1 Then
					ls_Mensagem = "Atualiza$$HEX2$$e700e300$$ENDHEX$$o da Quantidade Peso Grama (Aba Geral) -> 'produto_central'. " + SQLCA.SQLErrText
					SqlCa.of_RollBack();
					lb_Sucesso = False
				 Else
					 If Not wf_grava_historico(al_produto, String(ldc_Peso_Grama_Apresentacao_De), String(ldc_Peso_Grama_Apresentacao), 'PRODUTO_CENTRAL', 'QT_PESO_APRESENTACAO') Then
						Return False
					End If	
				End If
					
		Case Else
			Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tipo de para atualiza$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o previsto '" + as_Tipo + "'.")
			Return False				
	End Choose

	If lb_Sucesso Then
		SqlCa.of_Commit();
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do produto '" + String(al_Produto) + "'. ~r" + ls_Mensagem, StopSign! )
		Return False
	End If
		
ElseIf SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o das informa$$HEX2$$e700f500$$ENDHEX$$es atuais do produto '" + String(al_Produto) + "'")
	Return False
End If

Return True
end function

public function boolean wf_atualiza_produto ();Any lva_Dado

Boolean lvb_Sucesso = True
Boolean lb_Achou = False
		
Decimal ldc_Altura
Decimal ldc_Largura
Decimal ldc_Profundidade
Decimal ldc_Margem

Long	lvl_Linhas,&
		lvl_Linha,&
		lvl_Produto, &
		lvl_Embalagem,&
		ll_Produto_ABCFARMA,&
		ll_Null, &
		ll_Len, &
		ll_Divisao

String	lvs_Arquivo, &
		lvs_Produto_Fornecedor, &
		lvs_Tipo, &
		ls_Fornecedor, &
		ls_Caderno_ABCFARMA, &
		ls_Produto_ABCFARMA,&
		ls_DadosProduto

SetNull(ll_Null)

// Gloss$$HEX1$$e100$$ENDHEX$$rio de Tipos de Atualiza$$HEX2$$e700f500$$ENDHEX$$es:
// 1 - Embalagem Padr$$HEX1$$e300$$ENDHEX$$o
// 2 - C$$HEX1$$f300$$ENDHEX$$digo de Produtos no Fornecedor
// 3 - Inativar - Deixar o Produto PENDENTE depois o sistema INATIVA automaticamente
// 4 - Origem do Produto
// 5 - Mix do Produto
// 6 - Qtde pontos resgate
// 7 - Atualiza medidas do e-commerce
// 8 - Lei GENERICO
// 9 - Unidade de compra
// 10 - Unidade de venda
// 11 - LINHA PRODUTO
// 12 - ABC Farma
// 13 - Planograma
// 14 - Marca
// 15 - Permite Devolu$$HEX2$$e700e300$$ENDHEX$$o
// 16 - Percentual Margem Produto por Filial
// 17 - Comiss$$HEX1$$e300$$ENDHEX$$o Normal
// 18 - Comiss$$HEX1$$e300$$ENDHEX$$o Seletiva
// 19 - Fornecedor por Produto
// 20 - Unidade por Embalagem (Venda)
// 21 - Cont$$HEX1$$e900$$ENDHEX$$m lactose
// 22 - Cont$$HEX1$$e900$$ENDHEX$$m glut$$HEX1$$e900$$ENDHEX$$n
// 23 - Cont$$HEX1$$e900$$ENDHEX$$m a$$HEX1$$e700$$ENDHEX$$ucar
// 24 - Desconto do Fornecedor
// 25	- Apres.Compra
// 26	- Apres. Venda
// 27	- Descri$$HEX2$$e700e300$$ENDHEX$$o
// 28 - Tipo Apresenta$$HEX2$$e700e300$$ENDHEX$$o
// 29 - Concentra$$HEX2$$e700e300$$ENDHEX$$o
// 30 - Volume
// 31 - Peso em Gramas : E-Commerce
// 32 - Peso em Gramas : Aba Geral
// ------------------------------------

dw_1.AcceptText()

lvs_Arquivo 	= dw_1.Object.de_arquivo	[1]
lvs_Tipo		= dw_1.Object.de_tipo		[1]

//Se for ABC Farma
If lvs_Tipo = "12" Then	
	ids_Ean.Reset()
	
	If Not ids_Ean.of_ChangeDataObject("dw_ge428_lista_ean") Then
		If IsValid(ids_Ean) Then Destroy(ids_Ean)
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar a data store 'dw_ge428_lista_ean'.", StopSign!)
		Return False
	End If
	
	If ids_Ean.Retrieve() <= 0 Then
		If IsValid(ids_Ean) Then Destroy(ids_Ean)
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar a data store 'dw_ge428_lista_ean'.", StopSign!)
		Return False
	End If
	
	ids_Ean.RowCount()
End If

dc_uo_excel lvo_Excel
lvo_Excel = Create dc_uo_excel

Open(w_Aguarde)
w_Aguarde.Title = "Importando o Arquivo..."

// Refer$$HEX1$$ea00$$ENDHEX$$ncia o arquivo 
If ( lvo_Excel.uo_Referencia_Objeto_Excel(lvs_Arquivo) ) Then
	// Coluna de Refer$$HEX1$$ea00$$ENDHEX$$ncia
	lvl_Linhas = lvo_Excel.uo_Verifica_Tamanho_Arquivo("A") 
	
	If lvl_Linhas > 0 Then
		w_Aguarde.uo_Progress.of_SetMax(lvl_Linhas)
		
		For lvl_Linha = 1 To lvl_Linhas
					
			// Produto
			lva_Dado = lvo_Excel.uo_Lendo_Dados(lvl_Linha, "A")
			
			If Not IsNumber ( String(lva_Dado) ) Then 
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Valor inv$$HEX1$$e100$$ENDHEX$$lido na linha: " + String(lvl_Linha) + ".~rValor: " + String( lva_Dado )) 
				lvb_Sucesso = False
				Exit
			End If
			
			lvl_Produto = Long(lva_Dado)	
			
			// Verifica se o produto $$HEX1$$e900$$ENDHEX$$ v$$HEX1$$e100$$ENDHEX$$lido
			If Not wf_Localiza_Produto(lvl_Produto) Then Continue
			
			Choose Case lvs_Tipo
				Case '12' // 12 - ABC Farma
					
					lva_Dado = lvo_Excel.uo_Lendo_Dados(lvl_Linha, "B")
					ls_Caderno_ABCFARMA = Upper(String(lva_Dado))
					
//					lva_Dado = lvo_Excel.uo_Lendo_Dados(lvl_Linha, "C")
//					ls_Produto_ABCFARMA = String(lva_Dado)
					
					If Not wf_update_abcfarma(lvl_Produto, ls_Caderno_ABCFARMA) Then
						lvb_Sucesso = False
						Exit
					End If
		
				Case '13' // 13 - Planograma
					
					lva_Dado = lvo_Excel.uo_Lendo_Dados(lvl_Linha, "B")
					
					//Planograma
					If Not IsNumber ( String(lva_Dado) ) Then 
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Valor inv$$HEX1$$e100$$ENDHEX$$lido na linha: " + String(lvl_Linha) + ".~rValor: " + String( lva_Dado ) ) 
						lvb_Sucesso = False
						Exit
					End If
									
					If Not wf_Update(lvl_Produto, lvs_Tipo, lva_Dado) Then
						lvb_Sucesso = False
						Exit
					End If
					
				Case '14' // 14 - Marca
					
					lva_Dado = lvo_Excel.uo_Lendo_Dados(lvl_Linha, "B")
					
					//Marca
					If Not IsNumber ( String(lva_Dado) ) Then 
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Valor inv$$HEX1$$e100$$ENDHEX$$lido na linha: " + String(lvl_Linha) + ".~rValor: " + String( lva_Dado ) ) 
						lvb_Sucesso = False
						Exit
					End If
					
					If Not wf_Update(lvl_Produto, lvs_Tipo, lva_Dado) Then
						lvb_Sucesso = False
						Exit
					End If
					
				Case '15' // 15 - Permite Devolu$$HEX2$$e700e300$$ENDHEX$$o
					
					lva_Dado = lvo_Excel.uo_Lendo_Dados(lvl_Linha, "B")
					
					//Permite Devolu$$HEX2$$e700e300$$ENDHEX$$o |'S' ou 'N'
					If IsNumber ( String(lva_Dado) ) Then 
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Valor inv$$HEX1$$e100$$ENDHEX$$lido na linha: " + String(lvl_Linha) + ".~rValor: " + String( lva_Dado ) )
						lvb_Sucesso = False
						Exit
					End If
					
					If Not wf_Update(lvl_Produto, lvs_Tipo, lva_Dado) Then
						lvb_Sucesso = False
						Exit
					End If
										
				Case '16' // 16 - PERC. MARGEM PRODUTO
					
					lva_Dado = lvo_Excel.uo_Lendo_Dados(lvl_Linha, "B")
					ldc_Margem = lvo_Excel.uo_Lendo_Dados(lvl_Linha, "C")
					
					If IsNull(lva_Dado) or (ldc_Margem<0) Then 
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Valor inv$$HEX1$$e100$$ENDHEX$$lido na linha: " + String(lvl_Linha) + ".~rValor: " + String( lva_Dado ) ) 
						lvb_Sucesso = False
						Exit
					End If 					
					
					If Not wf_atualiza_margem_produto (lvl_Produto, lva_Dado, ldc_Margem) Then 
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Valor inv$$HEX1$$e100$$ENDHEX$$lido na linha: " + String(lvl_Linha) + ".~rValor: " + String( lva_Dado ) ) 
						lvb_Sucesso = False
						Exit
					End If
					
				Case '17', '18' // 17 - COMISS$$HEX1$$c300$$ENDHEX$$O NORMAL | 18 - COMISS$$HEX1$$c300$$ENDHEX$$O SELETIVA
					
					lva_Dado = lvo_Excel.uo_Lendo_Dados(lvl_Linha, "B")
					
					If IsNull(lva_Dado) Then lva_Dado = ""
					
					If String(lva_Dado) = "" Or Not IsNumber( String(lva_Dado) ) Then
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Valor inv$$HEX1$$e100$$ENDHEX$$lido na linha: " + String(lvl_Linha) + ".~rValor: " + String( lva_Dado ) )
						lvb_Sucesso = False
						Exit
					End If
					
					If Not wf_Atualiza_Comissao(lvl_Produto, lvs_Tipo, lva_Dado) Then
						lvb_Sucesso = False
						Exit
					End If
					
				Case '19' // 19 - FORNECEDOR POR PRODUTO
					
					lva_Dado = lvo_Excel.uo_Lendo_Dados(lvl_Linha, "B")
					
					If IsNull(lva_Dado) Then lva_Dado = ""
					
					If String(lva_Dado) = "" Or Not IsNumber(String(lva_Dado)) Then
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Valor inv$$HEX1$$e100$$ENDHEX$$lido na linha: " + String(lvl_Linha) + ".~rValor: " + String( lva_Dado ) )
						lvb_Sucesso = False
						Exit
					End If
					
					ll_Len = LenA(String(lva_Dado))
					
					If ll_Len = 8 Then
						lva_Dado = String("0" + String(lva_Dado))
					End If
										
					If Not wf_Localiza_Fornecedor(String(lva_Dado)) Then Continue
										
					ls_Fornecedor = String(lva_Dado)
					
					lb_Achou = False
					
					//Verifica se o fornecedor possui divis$$HEX1$$e300$$ENDHEX$$o
					If Not wf_Divisao_Fornecedor(ls_Fornecedor, 0, Ref lb_Achou) Then
						lvb_Sucesso = False
						Exit
					End If
					
					If lb_Achou Then
						lva_Dado = lvo_Excel.uo_Lendo_Dados(lvl_Linha, "C")
						
						If IsNull(lva_Dado) Then lva_Dado = ""
						
						If String(lva_Dado) = "" Or Not IsNumber(String(lva_Dado)) Then
							MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Valor inv$$HEX1$$e100$$ENDHEX$$lido na linha: " + String(lvl_Linha) + ".~rValor: " + String( lva_Dado ) )
							lvb_Sucesso = False
							Exit
						End If
						
						//Verifica se a divis$$HEX1$$e300$$ENDHEX$$o informada existe
						If Not wf_Divisao_Fornecedor(ls_Fornecedor, Long(lva_Dado), Ref lb_Achou) Then
							lvb_Sucesso = False
							Exit
						End If
						
						ll_Divisao = Long(lva_Dado)
					Else
						ll_Divisao = 0
					End If
					
					If Not wf_Atualiza_Fornecedor_Produto(lvl_Produto, ls_Fornecedor, ll_Divisao) Then
						lvb_Sucesso = False
						Exit
					End If
					
				Case '20'   // 20  - UNIDADE POR EMBALAGEM (VENDA)			
					
					lva_Dado = lvo_Excel.uo_Lendo_Dados(lvl_Linha, "B")					
					If IsNull(lva_Dado) Then lva_Dado = ""
					
					If String(lva_Dado) = "" Or Not IsNumber( String(lva_Dado) ) Then
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Valor inv$$HEX1$$e100$$ENDHEX$$lido na linha: " + String(lvl_Linha) + ".~rValor: " + String( lva_Dado ) )
						lvb_Sucesso = False
						Exit
					End If
										
					If Not wf_Update(lvl_Produto, lvs_Tipo, lva_Dado) Then
						lvb_Sucesso = False
						Exit
					End If		
				
				Case '21', '22', '23' // LACTOSE / GLUTEN / ACUCAR
					
					lva_Dado = lvo_Excel.uo_Lendo_Dados(lvl_Linha, "B")
					
					If IsNull(lva_Dado) Then lva_Dado = "X"
					
					// |'S' ou 'N'
					If IsNumber ( String(lva_Dado) ) Then 
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Valor inv$$HEX1$$e100$$ENDHEX$$lido na linha: " + String(lvl_Linha) + ".~rValor: " + String( lva_Dado ) )
						lvb_Sucesso = False
						Exit
					End If
					
					If String(lva_Dado) <> 'S' and String(lva_Dado) <> 'N' Then 
						If String(lva_Dado) = 'X' Then
							MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Valor inv$$HEX1$$e100$$ENDHEX$$lido na linha: " + String(lvl_Linha) + ".~rValor: Nulo.~rEsperado: 'S/N'")
						Else
							MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Valor inv$$HEX1$$e100$$ENDHEX$$lido na linha: " + String(lvl_Linha) + ".~rValor: " + String( lva_Dado ) + ".~rEsperado: 'S/N'")
						End If
						
						lvb_Sucesso = False
						Exit
					End If
					
					If Not wf_Update(lvl_Produto, lvs_Tipo, lva_Dado) Then
						lvb_Sucesso = False
						Exit
					End If		
					
					
				Case '24' //Desconto do Fornecedor
					
					lva_Dado = lvo_Excel.uo_Lendo_Dados(lvl_Linha, "B")
					
					If IsNull(lva_Dado) Or String(lva_Dado) = "" Or Not IsNumber( String(lva_Dado) ) Then
						If IsNull(lva_Dado) Then						
							lva_Dado = "" // Atribui branco para mostrar a mensagem, se tiver nulo messagebox n$$HEX1$$e300$$ENDHEX$$o mostra mensagem na tela
						End If
						
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Valor inv$$HEX1$$e100$$ENDHEX$$lido na linha: " + String(lvl_Linha) + ".~rValor: " + String( lva_Dado ) )
						lvb_Sucesso = False
						Exit
					End If
					
					If Dec(lva_Dado) > 100.00 Then
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Valor inv$$HEX1$$e100$$ENDHEX$$lido na linha: " + String(lvl_Linha) + ".~rValor: " + String( lva_Dado ) )
						lvb_Sucesso = False
						Exit
					End If
										
					If Not wf_Update(lvl_Produto, lvs_Tipo, lva_Dado) Then
						lvb_Sucesso = False
						Exit
					End If		
					
				Case '25'	,'26','27','28','29','30', '31', '32'
					lva_Dado = lvo_Excel.uo_Lendo_Dados(lvl_Linha, "B")
					
					If IsNull(lva_Dado) Or String(lva_Dado) = ""  Then
						If IsNull(lva_Dado) Then						
							lva_Dado = "" // Atribui branco para mostrar a mensagem, se tiver nulo messagebox n$$HEX1$$e300$$ENDHEX$$o mostra mensagem na tela
						End If
						
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Valor inv$$HEX1$$e100$$ENDHEX$$lido na linha: " + String(lvl_Linha) + ".~rValor: " + String( lva_Dado ) )
						lvb_Sucesso = False
						Exit
					End If
					
					ls_DadosProduto = Upper(String(lva_Dado))
					
					If Not wf_Update(lvl_Produto, lvs_Tipo, ls_DadosProduto) Then
						lvb_Sucesso = False
						Exit
					End If
					
				Case Else
					
					// Carrega o dado do produto que ser$$HEX1$$e100$$ENDHEX$$ atualizado
					If lvs_Tipo <> "3" Then	
						lva_Dado = lvo_Excel.uo_Lendo_Dados(lvl_Linha, "B")
					End If	
					
					If lvs_Tipo = "7" Then
						ldc_Altura 			= 0.00
						ldc_Largura 			= 0.00
						ldc_Profundidade 	= 0.00
						
						//Altura
						If Not IsNumber ( String(lva_Dado) ) Then 
							MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Valor inv$$HEX1$$e100$$ENDHEX$$lido na linha: " + String(lvl_Linha) + ".~rValor: " + String( lva_Dado ) ) 
							lvb_Sucesso = False
							Exit
						End If
						ldc_Altura 		= Round(Dec( lva_Dado ) , 2)
						
						//Largura
						lva_Dado 		= lvo_Excel.uo_Lendo_Dados(lvl_Linha, "C")
						
						If Not IsNumber ( String(lva_Dado) ) Then 
							MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Valor inv$$HEX1$$e100$$ENDHEX$$lido na linha: " + String(lvl_Linha) + ".~rValor: " + String( lva_Dado )) 
							lvb_Sucesso = False
							Exit
						End If
						
						ldc_Largura 	= Round(Dec( lva_Dado ) , 2)
		
						//Profundidade
						lva_Dado 				= lvo_Excel.uo_Lendo_Dados(lvl_Linha, "D")
						
						If Not IsNumber ( String(lva_Dado) ) Then 
							MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Valor inv$$HEX1$$e100$$ENDHEX$$lido na linha: " + String(lvl_Linha) + ".~rValor: " + String( lva_Dado )) 
							lvb_Sucesso = False
							Exit
						End If
						
						ldc_Profundidade 	= Round(Dec( lva_Dado ) , 2)
						
						If Not wf_Update( lvl_Produto, ldc_Altura, ldc_Largura, ldc_Profundidade ) Then
							lvb_Sucesso = False
							Exit
						End If
						
					Else
					
						If Not wf_Update(lvl_Produto, lvs_Tipo, lva_Dado) Then
							lvb_Sucesso = False
							Exit
						End If
					End If
					
			End Choose
																				
			w_Aguarde.uo_Progress.of_SetProgress(lvl_Linha)
		Next
	  
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A planilha n$$HEX1$$e300$$ENDHEX$$o possui nenhuma linha.")
		lvb_Sucesso = False
	End If
End If

If lvb_Sucesso Then
	SqlCa.of_Commit();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produtos atualizados com sucesso.")
	Close(This)
Else
	SqlCa.of_RollBack();
End If

Close(w_Aguarde)

Destroy(lvo_Excel)

Return lvb_Sucesso
end function

public function boolean wf_update (long al_produto, decimal adc_altura, decimal adc_largura, decimal adc_profundidade);Decimal ldc_Altura_De
Decimal ldc_Largura_De
Decimal ldc_Profundidade_De

dw_1.AcceptText()
	
Select pg.qt_altura_cm, pg.qt_largura_cm, pg.qt_profundidade_cm
  Into :ldc_Altura_De, :ldc_Largura_De, :ldc_Profundidade_De
  From produto_geral pg
 Where pg.cd_produto = :al_produto
 Using SqlCa;

If SqlCa.SqlCode = 0 Then
	
	Update produto_geral
		Set qt_altura_cm 			= :adc_altura,
			  qt_largura_cm 			= :adc_largura,
			  qt_profundidade_cm 	= :adc_profundidade
	 Where cd_produto    			= :al_Produto
	 Using SqlCa;
	
	If SqlCa.SqlCode = 0 Then
	
		If Not wf_grava_historico(al_produto, String(ldc_Altura_De), String(adc_altura), 'PRODUTO_GERAL', 'QT_ALTURA_CM') Then
			Return False
		End If	
		
		If Not wf_grava_historico(al_produto, String(ldc_Largura_De), String(adc_largura), 'PRODUTO_GERAL', 'QT_LARGURA_CM') Then
			Return False
		End If	
	
		If Not wf_grava_historico(al_produto, String(ldc_Profundidade_De), String(adc_profundidade), 'PRODUTO_GERAL', 'QT_PROFUNDIDADE_CM') Then
			Return False
		End If	
		
		SqlCa.of_Commit()
		
	ElseIf SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgDbError("Update das medidas do e-commerce '" + String(al_Produto) + "'. " + SqlCa.SqlErrText)
		Return False
	End If
					
ElseIf SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o das informa$$HEX2$$e700f500$$ENDHEX$$es atuais do produto '" + String(al_Produto) + "'")
	Return False
End If

Return True
end function

public function boolean wf_atualiza_margem_produto (integer al_produto, string as_uf, decimal adc_margem);decimal {0} lvdc_margem_de


Select pc_margem_resultado_preco
Into :lvdc_margem_de
from  produto_uf
where cd_produto = :al_Produto
and cd_unidade_federacao=:as_uf
Using SqlCa;

If SqlCa.SqlCode = 0 Then
	
	// Atualiza o valor 
	update  produto_uf
		set	   pc_margem_resultado_preco =:adc_margem
	from  	produto_uf
	where	cd_produto = :al_Produto
		And	cd_unidade_federacao=:as_uf
		And	coalesce(pc_margem_resultado_preco,0) <> coalesce(:adc_margem,0)
	Using SqlCa;

	
	/// Gravar historico
	If SqlCa.SqlCode = 0 Then
		If Not wf_grava_historico(al_produto, string(as_uf)+'@#!'+string( lvdc_margem_de ) , string(adc_margem), 'PRODUTO_UF', 'PC_MARGEM_RESULTADO_PRECO') Then
			Return False
		End If	
	ElseIf SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgDbError("Update do pc_margem_resultado_preco '" + String(al_Produto) + "'. " + SqlCa.SqlErrText)
		Return False
	End If
		
	SqlCa.of_Commit();
					
ElseIf SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o das informa$$HEX2$$e700f500$$ENDHEX$$es atuais do produto '" + String(al_Produto) + "'")
	Return False
End If



Return True 
end function

public function boolean wf_grava_historico (long al_produto, string as_de, string as_para, string as_tabela, string as_coluna);String lvs_Operador, ls_Chave, ls_Mensagem
lvs_Operador = gvo_Aplicacao.ivo_Seguranca.Nr_Matricula

//Tratamento informa$$HEX2$$e700f500$$ENDHEX$$es nulas
If IsNull(as_de) Then as_de = ''
If IsNull(as_para) Then as_para = ''
//Case n$$HEX1$$e300$$ENDHEX$$o haja altera$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o grava hist$$HEX1$$f300$$ENDHEX$$rico
If as_De = as_para  Then Return True

// Para tratamento de Chave
IF Match(as_de, "@#!") Then 
	ls_Chave = as_de +"@#!"+ string(al_produto)
	as_de = Mid(as_de, 6, 6) 
Else
	ls_Chave = String(al_Produto)
End If 

Insert Into historico_alteracao_produto(nm_tabela, cd_produto, nm_coluna, de_alteracao_de, de_alteracao_para, nr_matric_atualizacao,dh_atualizacao)
Values (:as_Tabela, :al_Produto, :as_Coluna, :as_De, :as_Para, :lvs_Operador, GetDate())
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Grava$$HEX2$$e700e300$$ENDHEX$$o do log de atualiza$$HEX2$$e700e300$$ENDHEX$$o do produto '" + String(al_Produto) + "'")
	Return False
End If

Insert Into historico_alteracao_tabela(nm_tabela, de_chave, nm_coluna, de_alteracao_de, de_alteracao_para, nr_matric_alteracao)
Values (:as_Tabela, :ls_Chave, :as_Coluna, :as_De, :as_Para, :lvs_Operador)
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_Mensagem = "Erro ao gravar hist$$HEX1$$f300$$ENDHEX$$rico da tabela. " + SqlCa.SQLErrText 
	SqlCa.of_RollBack()
	Return False
End If

Return True
end function

public function boolean wf_atualiza_comissao (long al_produto, string as_tipo, any aa_dado);Boolean lb_Sucesso = False

Decimal ldc_Comissao
Decimal ldc_Comissao_Nova

Long ll_Comissao

String ls_Erro
String ls_Chave
String ls_Nulo

If as_Tipo = "17" Then
	ll_Comissao = 1
Else
	ll_Comissao = 2
End If

ldc_Comissao_Nova = Round(Dec(aa_Dado), 2)

If ldc_Comissao_Nova > 5.00 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Comiss$$HEX1$$e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que 5%." + &
					"~rProduto '" + String(al_Produto) + "'.", Exclamation!)
	Return False
End If

ls_Chave = MidA(String(al_Produto) + Space(6), 1, 6) + "@#!" + String(ll_Comissao)

SetNull(ls_Nulo)
		
Select pc_comissao
	Into :ldc_Comissao
From tipo_comissao_produto
Where cd_produto = :al_Produto
	And cd_tipo_comissao = :ll_Comissao
Using SqlCa;
	
Choose Case SqlCa.SqlCode
	Case 0

		If ldc_Comissao_Nova <> ldc_Comissao Then
			
			If ldc_Comissao_Nova > 0.00 Then

				Update tipo_comissao_produto
					Set pc_comissao = :ldc_Comissao_Nova
				Where cd_produto = :al_Produto
					And cd_tipo_comissao = :ll_Comissao
					And coalesce(pc_comissao,0) <> coalesce(:ldc_Comissao_Nova,0)
				Using SqlCa;
				
				If SqlCa.SqlCode = -1 Then
					ls_Erro = "Erro ao alterar a comiss$$HEX1$$e300$$ENDHEX$$o. Produto '" + String(al_Produto) + "'. " + SqlCa.SqlErrText
				Else
					lb_Sucesso = True
				End If
				
				If lb_Sucesso Then
					If Not gf_Grava_Historico_Alteracao_Tabela('TIPO_COMISSAO_PRODUTO', ls_Chave, 'PC_COMISSAO', String(ldc_Comissao), String(ldc_Comissao_Nova), gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, "A", Ref ls_Erro, True) Then
						lb_Sucesso = False
					End If
				End If
				
			Else

				//Se a comiss$$HEX1$$e300$$ENDHEX$$o informada na planilha for 0,00 o registro do produto $$HEX1$$e900$$ENDHEX$$ exclu$$HEX1$$ed00$$ENDHEX$$do

				Delete From tipo_comissao_produto
				Where cd_produto = :al_Produto
					And cd_tipo_comissao = :ll_Comissao
				Using SqlCa;
				
				If SqlCa.SqlCode = -1 Then
					ls_Erro = "Erro ao excluir o registro do produto '" + String(al_Produto) + "'. " + SqlCa.SqlErrText
				Else
					lb_Sucesso = True
				End If
				
				If lb_Sucesso Then		
					If Not gf_Grava_Historico_Alteracao_Tabela('TIPO_COMISSAO_PRODUTO', ls_Chave, 'PC_COMISSAO', String(ldc_Comissao), ls_Nulo, gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, "E", Ref ls_Erro, True) Then
						lb_Sucesso = False
					End If
				End If
			End If
		Else
			Return True
		End If
		
	Case 100
		
		//Se o produto n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ na tabela tipo_comissao_produto e se foi informado com percentual 0.00 na planilha, o mesmo n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ inclu$$HEX1$$ed00$$ENDHEX$$do
		If ldc_Comissao_Nova > 0.00 Then
		
			Insert Into tipo_comissao_produto(cd_produto, cd_tipo_comissao, pc_comissao)
				Values(:al_Produto, :ll_Comissao, :ldc_Comissao_Nova)
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				ls_Erro = "Erro ao inserir o produto '" + String(al_Produto) + "'. " + SqlCa.SqlErrText				
			Else
				lb_Sucesso = True
			End If
			
			If lb_Sucesso Then
				If Not gf_Grava_Historico_Alteracao_Tabela('TIPO_COMISSAO_PRODUTO', ls_Chave, 'PC_COMISSAO', ls_Nulo, String(ldc_Comissao_Nova), gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, "I", Ref ls_Erro, True) Then
					lb_Sucesso = False
				End If
			End If
			
		Else			
			Return True
		End If
	
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar a comiss$$HEX1$$e300$$ENDHEX$$o do produto. Produto: " + String(al_Produto) + ". " + SqlCa.SqlErrText, StopSign!)
End Choose
	
If lb_Sucesso Then
	SqlCa.of_Commit();
Else	
	SqlCa.of_RollBack();
	
	If Not IsNull(ls_Erro) And ls_Erro <> "" Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Erro, StopSign!)
	End If
End If

Return lb_Sucesso
end function

public function boolean wf_atualiza_fornecedor_produto (long al_produto, string as_fornecedor, long al_divisao);Long ll_Divisao

String ls_Fornecedor
String ls_Erro
String ls_Chave

Try
	
	Delete From fornecedor_divisao_produto
	Where cd_produto = :al_Produto
	  And cd_fornecedor <> :as_Fornecedor
	Using SqlCa;
	
	If SqlCa.Sqlcode = -1 Then
		ls_Erro = "Erro ao excluir a divis$$HEX1$$e300$$ENDHEX$$o do fornecedor. " + SqlCa.SqlErrText
		Return False
	End If
			
	Select cd_fornecedor_usual
		Into :ls_Fornecedor
	From produto_geral
		Where cd_produto = :al_Produto
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			
		Case 100
			
		Case -1
			ls_Erro = "Erro ao localizar o fornecedor do produto. " + SqlCa.SqlErrText
			Return False
	End Choose
	
	Update produto_geral
		Set cd_fornecedor_usual = :as_Fornecedor
	Where cd_produto = :al_Produto
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		ls_Erro = "Erro ao atualizar o produto do fornecedor. " + SqlCa.SqlErrText
		Return False
	End If
	
	If ls_Fornecedor <> as_Fornecedor Then	
		If Not gf_Grava_Historico_Alteracao_Tabela('FORNECEDOR_DIVISAO_PRODUTO', String(al_Produto), 'CD_FORNECEDOR_USUAL', ls_Fornecedor, as_Fornecedor, gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, 'A', Ref ls_Erro, True) Then Return False
	End If
	
	If al_Divisao > 0 Then
	
		Select nr_divisao
			Into :ll_Divisao
		From fornecedor_divisao_produto
			Where cd_fornecedor = :ls_Fornecedor
				And cd_produto = :al_Produto
		Using SqlCa;
	
		Choose Case SqlCa.SqlCode
			Case 0
				
				Update fornecedor_divisao_produto
					Set	cd_fornecedor = :as_Fornecedor,
							nr_divisao = :al_Divisao
				Where cd_produto = :al_Produto
				Using SqlCa;
							
				If SqlCa.SqlCode = -1 Then
					ls_Erro = "Erro ao atualizar o produto '" + String(al_Produto) + "' para o fornecedor '" + String(as_Fornecedor) + "' na divis$$HEX1$$e300$$ENDHEX$$o."
					Return False
				End If
			Case 100
				
				Insert Into fornecedor_divisao_produto(cd_fornecedor, nr_divisao, cd_produto)
					Values(:as_Fornecedor, :al_Divisao, :al_Produto)
				Using SqlCa;
				
				If SqlCa.SqlCode = -1 Then
					ls_Erro = "Erro ao inserir o fornecedor '" + String(as_Fornecedor) + "' na divis$$HEX1$$e300$$ENDHEX$$o '" + String(al_Divisao) + "' produto '" + String(al_Produto) + "'."
					Return False
				End If
				
			Case -1
				ls_Erro = "Erro ao localizar o produto '" + String(al_Produto) + "' do fornecedor '" + String(ls_Fornecedor) + "' na divis$$HEX1$$e300$$ENDHEX$$o."
				Return False			
		End Choose
	End If
	
Finally
	If ls_Erro = "" Then
		SqlCa.of_Commit();
	Else
		SqlCa.of_RollBack();		
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Erro, StopSign!)
	End If
End Try

Return True
end function

public function boolean wf_localiza_fornecedor (string as_fornecedor);Long ll_Achou = 0

Select Count(*)
	Into :ll_Achou
From fornecedor
Where cd_fornecedor = :as_Fornecedor
	And (id_situacao = 'A' Or id_situacao Is Null)
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o fornecedor. " + SqlCa.SqlErrText, StopSign!)
	Return False
End If

If ll_Achou > 0 Then
	Return True
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Fornecedor '" + as_Fornecedor + "' n$$HEX1$$e300$$ENDHEX$$o localizado ou inativo.")
	Return False
End If
end function

public function boolean wf_divisao_fornecedor (string as_fornecedor, long al_divisao, ref boolean ab_achou);Long ll_Achou = 0

ab_Achou = False

//Verifica se o fornecedor possui divisao
If al_Divisao = 0 Then
	Select Count(*)
		Into: ll_Achou
	From fornecedor_divisao
	Where cd_fornecedor = :as_Fornecedor
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			
		Case 100			
						
		Case -1
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao consultar a divis$$HEX1$$e300$$ENDHEX$$o do fornecedor. " + SqlCa.SqlErrText, StopSign!)
			Return False
	End Choose
		
Else
	
	//Verifica se a divis$$HEX1$$e300$$ENDHEX$$o informada na planilha existe
	Select Count(*)
		Into: ll_Achou
	From fornecedor_divisao
	Where cd_fornecedor = :as_Fornecedor
		And nr_divisao = :al_Divisao
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			
		Case 100			
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizada a divis$$HEX1$$e300$$ENDHEX$$o '" + String(al_Divisao) + "' para o fornecedor '" + String(as_Fornecedor) + ".")
			Return False
			
		Case -1
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao consultar a divis$$HEX1$$e300$$ENDHEX$$o do fornecedor. " + SqlCa.SqlErrText, StopSign!)
			Return False
	End Choose
End If

If ll_Achou > 0 Then
	ab_Achou = True
End If

Return True
end function

public function boolean wf_localiza_ean (long al_produto, ref long al_produto_abc);Long ll_Find

String ls_Ean

ll_Find = ids_Ean.Find("cd_produto = " + String(al_Produto), 1, ids_Ean.RowCount())

Do While ll_Find > 0

	If ll_Find < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Find da ds ids_Ean.", StopSign!)
		Return False
	End If
	
	If ll_Find > 0 Then
		ls_Ean = ids_Ean.Object.De_Codigo_Barras[ll_Find]
		
		Select Top 1 cd_produto_abcfarma
			Into :al_Produto_Abc
		From produto_abcfarma
		Where de_codigo_barras = :ls_Ean
		Using SqlCa;
		
		Choose Case SqlCa.SqlCode
			Case 0
				Return True
				
			Case 100
				
			Case -1
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao consultar o EAN na tabela produto_abcfarma.", StopSign!)
				Return False
		End Choose
	End If
	
	//Retorna True pra n$$HEX1$$e300$$ENDHEX$$o entrar em loop infinito
	If ll_Find = ids_Ean.RowCount() Then
		Return True
	End If
	
	ll_Find = ids_Ean.Find("cd_produto = " + String(al_Produto), ll_Find + 1, ids_Ean.RowCount())	
	
	If ll_Find < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Find da ds ids_Ean.", StopSign!)
		Return False
	End If
Loop

Return True
end function

public function boolean wf_update_abcfarma (long al_produto, string as_caderno_abcfarma);Decimal ldc_Fator_Conversao_ABCFARMA, ldc_Fator_Conversao_ABCFARMA_PARA, ldc_Nulo

Long ll_Produto_ABCFARMA, ll_Produto_ABCFARMA_PARA, ll_Null

String ls_ABCFARMA

SetNull(ll_Null)
SetNull(ldc_Nulo)

dw_1.AcceptText()

If (as_caderno_abcfarma <> 'S' and as_caderno_abcfarma <> 'N') or Isnull(as_caderno_abcfarma) Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O identificador se o produto pertence a lista ABCFARMA do produto '" + String(al_Produto) + "' $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido, deve ser 'S/N'.")
	Return False
End If

//If Not IsNumber(as_produto_abcfarma) Then
//	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O c$$HEX1$$f300$$ENDHEX$$digo da ABCFARMA do produto '" + String(al_Produto) + "' deve conter somente n$$HEX1$$fa00$$ENDHEX$$meros.")
//	Return False
//End If

//Faz a consulta somente se estiver sendo inclu$$HEX1$$ed00$$ENDHEX$$do o produto na ABCFarma
If as_Caderno_Abcfarma = "S" Then
	If Not wf_Localiza_Ean(al_Produto, Ref ll_Produto_ABCFARMA_PARA) Then Return False
	
	//Se n$$HEX1$$e300$$ENDHEX$$o localizou o EAN do produto na produto_abcfarma, n$$HEX1$$e300$$ENDHEX$$o faz nada, vai para o pr$$HEX1$$f300$$ENDHEX$$xima produto da planilha
	If ll_Produto_ABCFARMA_PARA = 0 Then Return True
End If

//ll_Produto_ABCFARMA_PARA = Long(as_produto_abcfarma)
					
If ll_Produto_ABCFARMA_PARA = 0 Then ll_Produto_ABCFARMA_PARA = ll_Null

//If as_caderno_abcfarma = 'N' and Not IsNull(ll_Produto_ABCFARMA_PARA) then
//	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O identificador se o produto pertence a lista ABCFARMA do produto '" + String(al_Produto) + "' esta 'N' por$$HEX1$$e900$$ENDHEX$$m foi informado o c$$HEX1$$f300$$ENDHEX$$digo da ABCFARMA.")
//	Return False
//End If

//If as_caderno_abcfarma = 'S' and IsNull(ll_Produto_ABCFARMA_PARA) then
//	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O identificador se o produto pertence a lista ABCFARMA do produto '" + String(al_Produto) + "' esta 'S' por$$HEX1$$e900$$ENDHEX$$m n$$HEX1$$e300$$ENDHEX$$o foi informado o c$$HEX1$$f300$$ENDHEX$$digo da ABCFARMA.")
//	Return False
//End If

If as_Caderno_ABCFARMA = 'N' Then
	ldc_Fator_Conversao_ABCFARMA_PARA = ldc_Nulo
Else
	ldc_Fator_Conversao_ABCFARMA_PARA = 1.00
End If
	
Select c.cd_produto_abcfarma, g.id_caderno_abcfarma, c.vl_fator_conversao_abcfarma
	Into :ll_Produto_ABCFARMA, :ls_ABCFARMA, :ldc_Fator_Conversao_ABCFARMA
From produto_central c
	Inner Join produto_geral g
		On g.cd_produto = c.cd_produto
Where c.cd_produto = :al_Produto
Using SqlCa;

If SqlCa.SqlCode = 0 Then
			
	Update produto_geral
		Set id_caderno_abcfarma = :as_caderno_abcfarma
	 Where cd_produto  = :al_Produto
	 Using SqlCa;
	
	If SqlCa.SqlCode = 0 Then
		If Not wf_grava_historico(al_produto, ls_ABCFARMA, as_caderno_abcfarma, 'PRODUTO_GERAL', 'ID_CADERNO_ABCFARMA') Then
			Return False
		End If
	ElseIf SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgDbError("Update do ID_CADERNO_ABCFARMA '" + String(al_Produto) + "'. " + SqlCa.SqlErrText)
		Return False
	End If
	
	Update produto_central
		Set 	cd_produto_abcfarma = :ll_Produto_ABCFARMA_PARA,&
				dh_atualizacao_abcfarma = getdate(), &
				vl_fator_conversao_abcfarma = :ldc_Fator_Conversao_ABCFARMA_PARA
	 Where cd_produto  = :al_Produto
	 Using SqlCa;
	
	If SqlCa.SqlCode = 0 Then
		If Not wf_grava_historico(al_produto, string(ll_Produto_ABCFARMA), string(ll_Produto_ABCFARMA_PARA), 'PRODUTO_CENTRAL', 'CD_PRODUTO_ABCFARMA') Then
			Return False
		End If
					
		If Not wf_grava_historico(al_produto, string(ldc_Fator_Conversao_ABCFARMA), string(ldc_Fator_Conversao_ABCFARMA_PARA), 'PRODUTO_CENTRAL', 'VL_FATOR_CONVERSAO_ABCFARMA') Then
			Return False
		End If
	ElseIf SqlCa.SqlCode = -1 Then
		SqlCa.of_Rollback();
		SqlCa.of_MsgDbError("Update do ID_CADERNO_ABCFARMA '" + String(al_Produto) + "'. " + SqlCa.SqlErrText)
		Return False
	End If

	SqlCa.of_Commit();

ElseIf SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o das informa$$HEX2$$e700f500$$ENDHEX$$es atuais do produto '" + String(al_Produto) + "'")
	Return False
End If

Return True
end function

on w_ge428_altera_produto_via_excel.create
int iCurrent
call super::create
this.cb_selecionar=create cb_selecionar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_selecionar
end on

on w_ge428_altera_produto_via_excel.destroy
call super::destroy
destroy(this.cb_selecionar)
end on

event open;call super::open;pb_help.Visible = True
end event

event ue_postopen;call super::ue_postopen;io_Comprador	= Create uo_ge149_comprador
ids_Ean			= Create dc_uo_ds_base

is_Usuario = gvo_Aplicacao.ivo_Seguranca.Nr_Matricula

dw_1.Object.t_Motivo.Visible = 0
dw_1.Object.De_Motivo.Visible = 0

dw_1.Object.t_Solicit.Visible = 0
dw_1.Object.Nm_Usuario.Visible = 0
dw_1.Object.Nr_Matricula.Visible = 0


end event

event close;call super::close;Destroy(io_Comprador)
Destroy(ids_Ean)
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge428_altera_produto_via_excel
integer x = 27
integer y = 420
end type

event pb_help::clicked;call super::clicked;wf_Help("Atualiza$$HEX2$$e700e300$$ENDHEX$$o de produtos via excel (GE428)")
end event

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge428_altera_produto_via_excel
integer width = 2117
integer height = 400
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge428_altera_produto_via_excel
integer x = 41
integer y = 56
integer width = 2085
integer height = 336
integer taborder = 50
string dataobject = "dw_ge428_selecao_arquivo"
end type

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)
end event

event dw_1::itemchanged;call super::itemchanged;String lvs_Nulo

SetNull(lvs_Nulo)

//ATIVAR / INATIVAR Produtos
If dwo.Name = 'de_tipo' Then
	
	This.Object.de_Arquivo[1] = lvs_Nulo
	
	If Data = '3' Then
		
		This.Height 								= 320
		gb_1.Height 							= 400

		This.Object.de_Motivo.Visible		= 1
		This.Object.t_motivo.Visible 		= 1
		
		This.Object.t_Solicit.Visible 			= 1
		This.Object.Nm_Usuario.Visible 	= 1
		This.Object.Nr_Matricula.Visible	= 1
		
		This.Event ue_Pos(Row, 'de_Motivo')
		
	Else
		
		This.Height 								= 196
		gb_1.Height 							= 276

		This.Object.de_Motivo.Visible		= 0
		This.Object.t_motivo.Visible 		= 0
		This.Object.de_Motivo [row] 		= lvs_Nulo
		
		This.Object.t_Solicit.Visible 			= 0
		This.Object.Nm_Usuario.Visible 	= 0
		This.Object.Nr_Matricula.Visible 	= 0
		This.Object.Nr_Matricula[row]		= lvs_Nulo
		This.Object.Nm_Usuario[row] 		= lvs_Nulo
	End If
End If

If dwo.Name = "nm_usuario" Then
	If Not IsNull(Data) and Trim(Data) <> "" Then
		If Data <> io_Comprador.Nm_Usuario Then
			Return 1
		End If
	Else
		io_Comprador.of_Inicializa()
		
		This.Object.Nr_Matricula	[This.GetRow()] = io_Comprador.Nr_Matricula
		This.Object.Nm_Usuario	[This.GetRow()] = io_Comprador.Nm_Usuario
	End If
End If
end event

event dw_1::ue_key;call super::ue_key;If This.GetColumnName() = "nm_usuario" Then
	If Key = KeyEnter! Then
		io_Comprador.of_Localiza_Comprador(This.GetText())
		
		If io_Comprador.Localizado Then
			This.Object.Nr_Matricula	[This.GetRow()] = io_Comprador.Nr_Matricula
			This.Object.Nm_Usuario	[This.GetRow()] = io_Comprador.Nm_Usuario
		End If
	End If
End If
end event

event dw_1::editchanged;call super::editchanged;If dwo.Name = "nm_usuario" Then
	If Not IsNull(Data) and Trim(Data) <> "" Then
		If Data <> io_Comprador.Nm_Usuario Then
			Return 1
		End If
	Else
		io_Comprador.of_Inicializa()
		
		This.Object.Nr_Matricula	[This.GetRow()] = io_Comprador.Nr_Matricula
		This.Object.Nm_Usuario	[This.GetRow()] = io_Comprador.Nm_Usuario
	End If
End If
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge428_altera_produto_via_excel
integer x = 1458
integer y = 432
integer width = 325
boolean enabled = false
string text = "&Alterar"
boolean default = false
end type

event cb_ok::clicked;call super::clicked;Long lvl_Confirma

String	lvs_Arquivo
String	lvs_Tipo
String ls_Motivo
String ls_Matricula

dw_1.AcceptText()

lvs_Arquivo 	= dw_1.Object.de_arquivo	[1]
lvs_Tipo		= dw_1.Object.de_tipo		[1]
ls_Motivo		= dw_1.Object.de_motivo	[1]
ls_Matricula	= dw_1.Object.Nr_Matricula	[1]


// Verifica CutOver Material
If not gf_verifica_cutover('DH_CUTOVER_MATERIAL') Then 
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ mais permitida atualiza$$HEX2$$e700e300$$ENDHEX$$o do produto por esta tela! Utilizar o SAP")
	dw_1.SetFocus()
	Return - 1
End If 

If IsNull(lvs_Tipo) or Trim(lvs_Tipo) = "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione o tipo de atualiza$$HEX2$$e700e300$$ENDHEX$$o.")
	dw_1.SetFocus()
	Return - 1
End If

If IsNull(lvs_Arquivo) or Trim(lvs_Arquivo) = "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione o arquivo a ser importado.")
	dw_1.SetFocus()
	Return -1
End If

If lvs_Tipo = '3' Then
	If IsNull(ls_Motivo) or Trim(ls_Motivo) = "" Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o motivo da altera$$HEX2$$e700e300$$ENDHEX$$o.")
		dw_1.SetFocus()
		Return -1
	End If
	
	If Len(ls_Motivo) < 5 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe pelo menos 5 caract$$HEX1$$e900$$ENDHEX$$res no motivo da altera$$HEX2$$e700e300$$ENDHEX$$o.")
		dw_1.SetFocus()
		Return -1
	End If
	
	If IsNull(ls_Matricula) Or ls_Matricula = "" Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o comprador.")
		dw_1.SetFocus()
		Return -1
	End If
End If

lvl_Confirma = MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a altera$$HEX2$$e700e300$$ENDHEX$$o dos produtos ?", Question! , YesNo!, 2)

If lvl_Confirma = 1 Then	
	If Not wf_Atualiza_Produto() Then
		Return -1
	End If
End If
	
Return 1
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge428_altera_produto_via_excel
integer x = 1815
integer y = 432
integer width = 325
end type

type cb_selecionar from commandbutton within w_ge428_altera_produto_via_excel
integer x = 768
integer y = 432
integer width = 594
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Selecionar Arquivo"
end type

event clicked;String lvs_Arquivo,&
	   lvs_Nome,&
	   lvs_Nulo, &
		lvs_Mensagem

Integer lvi_Retorno 

dw_1.AcceptText()

If Not wf_Localiza_Tipo() Then
	Return -1
End If

//lvi_Retorno = GetFileOpenName("Seleciona o arquivo", + lvs_Arquivo, lvs_Nome, "XLS", "Excel (*.XLS),*.XLS,")
lvi_Retorno = GetFileOpenName("Seleciona o arquivo", + lvs_Arquivo, lvs_Nome, "XLSX", "Excel 2007 (*.XLSX),*.XLSX, Excel (*.XLS), *.XLS")

If lvi_Retorno = 1 Then 
	dw_1.Object.de_arquivo[1] = Upper(lvs_Arquivo)
	cb_ok.Enabled = True
Else
	SetNull(lvs_Nulo)
	dw_1.Object.de_arquivo[1] = lvs_Nulo
	cb_ok.Enabled = False
End If
end event

