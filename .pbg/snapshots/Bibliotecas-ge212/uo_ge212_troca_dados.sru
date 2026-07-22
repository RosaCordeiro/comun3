HA$PBExportHeader$uo_ge212_troca_dados.sru
forward
global type uo_ge212_troca_dados from nonvisualobject
end type
end forward

global type uo_ge212_troca_dados from nonvisualobject
end type
global uo_ge212_troca_dados uo_ge212_troca_dados

type variables
Long ivl_Sequencial = 1
Long ivl_Filial_Importacao
Long ivl_Limite_Campo_Text = 2000 //Usado para quando o tipo de campo for TEXT, porque seu tamanho $$HEX1$$e900$$ENDHEX$$ de 32766.
Integer ivi_Arquivo
Integer ivi_Log

String ivs_Excessoes_Central[]
String ivs_Excessoes_Loja[]
String ivs_Permite_Exclusao[]
String ivs_Leiaute_Antigo[]
String ivs_Arquivo
String ivs_Log
String ivs_Caminho_Arquivo = 'c:\'
String is_Sql_Banco
String is_Tabela_Consulta_Sql
String is_Loja_SAP

dc_uo_ds_base ivds_Tabelas
dc_uo_ds_base ids_Relacao_Tabelas
dc_uo_ds_base ivds_PK
uo_ge059_Troca_Dados_Comum ivo_Comum
uo_ge073_json io_Json
uo_cartao_produto ivo_cartao //GE574

Constant Integer ICI_DECIMAL	= 36 // Tamanho m$$HEX1$$e100$$ENDHEX$$ximo de um campo decimal.
end variables

forward prototypes
public function string of_coluna_chave (string ps_chave, integer pi_coluna)
public function boolean of_grava_arquivo (string ps_registro)
public function boolean of_fecha_arquivo ()
public function boolean of_abre_arquivo ()
public function boolean of_atualiza_sequencial ()
public function boolean of_carrega_tabelas_loja ()
public function boolean of_abre_log (string ps_arquivo)
public function boolean of_appendwhere_import (string ps_tabela, string ps_registro, ref dc_uo_ds_base pds_datastore, ref string ps_chave_log)
public subroutine of_grava_log (integer pi_arquivo, string ps_mensagem)
public function boolean of_backup_importacao (long pl_filial)
public subroutine _documentacao ()
public function boolean of_loja_grava_registro (string ps_tabela, string ps_chave_log, string ps_atualizacao)
public function boolean of_loja_nome_arquivo ()
public function boolean of_loja_grava_registro_exclusao (string ps_tabela, string ps_cd_tabela, string ps_chave, dc_uo_ds_base pds_datastore)
public function boolean of_central_verifica_ultimo_arquivo_imp (long pl_filial, ref long pl_nr_arquivo)
public function boolean of_central_importa_registro (string ps_cd_tabela, string ps_nm_tabela, string ps_registro, long pl_linha)
public function boolean of_central_atualiza_ultimo_arquivo_imp (long pl_filial)
public function boolean of_campo_chave (string ps_tabela, string ps_campo, ref boolean pb_chave)
public function boolean of_appendselect (ref dc_uo_ds_base pds_datastore, string ps_campo)
public function boolean of_loja_grava_reg_exclusao_sld_prd_lote (string ps_tabela, string ps_cd_tabela, string ps_chave)
public subroutine of_envia_email_erro (string ps_erro, string ps_nome_funcao, long pl_linha)
public function boolean of_loja_exporta_tudo ()
public function boolean of_loja_exporta ()
public function boolean of_loja_exporta_selecionadas (dc_uo_dw_base pds_tabelas)
public function boolean of_loja_exporta_selecionadas (dc_uo_ds_base pds_tabelas)
public function boolean of_central_existe_item_nota (dc_uo_ds_base pds_datastore, string ps_tabela, string ps_chave_log)
public function boolean of_central_importa_cartao_comp_venda (dc_uo_ds_base pds_datastore, long pl_linha, integer pi_log)
public function integer of_appendwhere (string ps_tabela, string ps_chave_log, ref dc_uo_ds_base pds_datastore, string ps_central_ou_loja)
public function boolean of_central_carrega_tabelas ()
public function boolean of_central_appendwhere_export (string ps_tabela, string ps_valores_chave_tabela, ref dc_uo_ds_base pds_datastore, ref string ps_chave_log)
public function boolean of_loja_appendwhere_import (string ps_tabela, string ps_registro, ref dc_uo_ds_base pds_datastore, ref string ps_chave_log)
public function boolean of_loja_exclui_referencia_produto (long al_produto, integer ai_log, string as_chave_log)
public function boolean of_central_grava_registro_exclusao (string ps_tabela, string ps_cd_tabela, string ps_chave, dc_uo_ds_base pds_datastore, ref string ps_registro)
public function boolean of_loja_importa_registro (string ps_cd_tabela, string ps_registro, long pl_linha)
public function boolean of_central_grava_registro (string ps_tabela, string ps_chave_log, string ps_atualizacao, long pl_linha_ds_tabelas, ref string ps_registro)
public function boolean of_central_importa_saldo_produto (dc_uo_ds_base lvds_1, string ps_linha)
public function boolean of_central_importa_promocao_sos_produto (dc_uo_ds_base lvds_1, string ps_linha)
public function boolean of_loja_atualiza_log (string ps_situacao, ref long pl_linhas)
public function boolean of_central_importa (string ps_caminho, string ps_arquivo)
public subroutine of_registra_transferencia_intranet (dc_uo_ds_base pds_transf)
public function boolean of_central_atualiza_produto_pbm (dc_uo_ds_base lvds_1, long pl_linha, ref string ps_id_pbm)
public function boolean of_central_verifica_pedido_almoxarifado (dc_uo_ds_base pds_datastore, long pl_linha, integer pi_log)
public function boolean of_loja_novo_leiaute_item_nf_venda (string ps_tabela)
public function boolean of_carrega_campos_chave (string ps_cd_tabela, string ps_tabela, ref long pl_campos)
public function boolean of_syntaxfromsql (dc_uo_ds_base pds_retrieve, string ps_sql)
public function string of_monta_where_chave_log (string ps_sql, string ps_chave_log)
public function string of_captura_valor_campo_dw (dc_uo_ds_base pds_retrieve, string ps_tipo, string ps_objeto, ref string ps_valor)
public function boolean of_exporta_json (string ps_tabela, string ps_chave_log, string ps_atualizacao)
public function string of_nome_tabela (string ps_sql)
public function string of_escape_single_quote (string ps_texto)
public subroutine of_registra_transferencia_intranet (string ps_json)
public function boolean of_insere_aspas_where ()
public function boolean of_carrega_tabela_json (string ps_tabela)
public function boolean of_get_sql_banco (string ps_tabela_exporta)
public function boolean of_central_importa_movto_titulo_receber (dc_uo_ds_base lvds_1, string ps_linha)
public function boolean of_importa_json (string ps_tabela, string ps_registro, long pl_linha)
public function string of_monta_registro_exclusao (string ps_tabela, string ps_sql, string ps_chave_log)
public function boolean of_central_import_cartao_comp_venda_novo (string ps_registro, long pl_linha)
end prototypes

public function string of_coluna_chave (string ps_chave, integer pi_coluna);String lvs_Coluna

Integer lvi_Contador, &
        lvi_Posicao = -2, &
        lvi_Start

For lvi_Contador = 1 To pi_Coluna
	lvi_Start = lvi_Posicao + 3
	
	lvi_Posicao = PosA(ps_Chave, "@#!", lvi_Start)
Next

If lvi_Posicao = 0 Then
	lvs_Coluna = MidA(ps_Chave, lvi_Start)
Else
	lvs_Coluna = MidA(ps_Chave, lvi_Start, lvi_Posicao - lvi_Start)
End If

Return lvs_Coluna
end function

public function boolean of_grava_arquivo (string ps_registro);Integer li_Write

String ls_Registro

If Trim(ps_Registro) <> "" Then
	ls_Registro = ps_Registro + RightA(String(ivl_Sequencial), 1)
	
	li_Write = FileWrite(ivi_Arquivo, ls_Registro)
	
	If li_Write <> LenA(ls_Registro) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro da tabela '" + Mid(ps_Registro, 2, 3 ) + "' no arquivo." , StopSign!)
		Return False
	End If

	ivl_Sequencial ++
End If

Return True
end function

public function boolean of_fecha_arquivo ();Boolean lb_Sucesso = False

String ls_Registro

ls_Registro = '{"sequencial":"' + String( ivl_Sequencial ) + '","tabela":"registro_finalizador"}'
//ls_Registro = "XTRA" + String( ivl_Sequencial, "000000" )

If Filewrite( ivi_Arquivo, ls_Registro ) = LenA( ls_Registro ) Then
	If FileClose( ivi_Arquivo ) = 1 Then
		lb_Sucesso = True
	End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro '" + ls_Registro + "' no arquivo." , StopSign!)
End If

Return lb_Sucesso
end function

public function boolean of_abre_arquivo ();ivi_Arquivo = FileOpen(ivs_Caminho_Arquivo + ivs_Arquivo, LineMode!, Write!, Shared!, Replace!)

If ivi_Arquivo = -1 Then	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na abertura do arquivo : " + ivs_Caminho_Arquivo + ivs_Arquivo + ".", StopSign!)
	Return False
End If

Return True
end function

public function boolean of_atualiza_sequencial ();Boolean lb_Sucesso = False

Long lvl_Sequencial

uo_Parametro_Filial lvo_Parametro
lvo_Parametro = Create uo_Parametro_Filial

If lvo_Parametro.of_Localiza_Parametro( "NR_ULTIMO_ARQUIVO_TL", ref lvl_Sequencial ) Then
	If lvo_Parametro.of_Atualiza_Parametro( "NR_ULTIMO_ARQUIVO_TL", lvl_Sequencial + 1 ) Then
		lb_Sucesso = true
	End If
End If

Destroy(lvo_Parametro)

Return lb_Sucesso
end function

public function boolean of_carrega_tabelas_loja ();/* Fun$$HEX2$$e700e300$$ENDHEX$$o para carregar as tabelas que 
	- Ser$$HEX1$$e300$$ENDHEX$$o exportadas na loja
	- Ser$$HEX1$$e300$$ENDHEX$$o importadas na matriz
*/

String ls_Tabelas[]

Long ll_Linha
Long ll_Insert

ids_Relacao_Tabelas.of_changedataobject( '_ds_ge212_relacao_tabela' )
This.ids_Relacao_Tabelas.Retrieve( )

ls_Tabelas = {	"003_RECEITA", &
					"004_RECEITA_PRODUTO", &
					"005_NF_VENDA_PAGAMENTO", &
					"006_NF_VENDA_PARCELA_CC", &
					"010_CONTROLE_CAIXA", &
					"011_HISTORICO_CONTROLE_CAIXA", &
					"012_NF_DIVERSA_NFE", &
					"013_UNIMED_VENDA", &
					"015_NF_DEVOLUCAO_COMPRA_NFE", &
					"016_LANCAMENTO_PSICO_PRODUTO", &
					"017_LANCAMENTO_PSICO_PRODUTO_LOTE", &					
					"019_CLIENTE_DEPENDENTE", &					
					"024_NF_VENDA_RENDACARD", &
					"026_PRODUTO_PROCURA_CLIENTE", &
					"027_MAPA_RESUMO", &
					"028_MAPA_RESUMO_ECF", &
					"029_ALIQUOTA_MAPA_RESUMO_ECF", &
					"030_IMPRESSORA_FISCAL", &
					"032_SISTEMA", &
					"034_NF_DEVOLUCAO_VENDA", &			
					"038_NF_DEVOLUCAO_VENDA_LOJA", &					
					"041_COMPROVANTE_CB", &
					"042_NF_VENDA_NFE", &
					"043_PRODUTO_PROCURADO_ZERADO", &
					"046_CONTROLE_LIMPEZA_BANCO", &
					"048_TITULO_PAGAR", &
					"053_AJUSTE_ESTOQUE", &
					"054_SNGPC_HISTORICO_ARQUIVO", &
					"055_LOCAL_ESTOCAGEM", &
					"057_BLOQUEIO", &
					"059_CONFIRMACAO_IMPORTACAO", &
					"062_SALDO_PRODUTO",&
					"066_NF_TRANSFERENCIA_NFE", &
					"068_ITEM_NF_DEVOLUCAO_COMPRA_LOTE", &
					"070_CLIENTE_DROGAEXPRESS", &
					"071_PEDIDO_DROGAEXPRESS", &
					"072_TAXA_ENTREGA_EXTRA", &
					"073_REGISTRO_TRANSFERENCIA_MANIP", &
					"075_LOG_FECHAMENTO_DIARIO", &
					"077_HISTORICO_ALTERACAO_BASE", &
					"078_LANCAMENTO_CAIXA", &
					"079_NF_VENDA_LOJA",&
					"082_CARTAO_CLUBE", &
					"002_PROMOCAO_SOS_ESTOQUE_MINIMO", &
					"009_LANCAMENTO_PSICO", &
					"014_CHEQUE", &
					"044_SORTEIO_NATAL", &					
					"065_ITEM_NF_COMPRA_LOTE", &	
					"107_NF_DIVERSA", &
					"114_REMANEJAMENTO_RESULTADO", &
					"105_NF_DEVOLUCAO_VENDA_NFE", &
					"056_NF_DEVOLUCAO_COMPRA", &		
					"092_CLIENTE_CHEQUE", &
					"093_CARTAO_COMPROVANTE_VENDA", &
					"074_PRESCRITOR_RECEITA", &
					"080_PEDIDO_ALMOXARIFADO", &
					"083_PEDIDO_ALMOXARIFADO_PRODUTO",&
					"025_ITEM_NF_DIVERSA", &
					"099_CAIXA", &
					"120_NF_VENDA", &
					"098_ITEM_NF_VENDA_DESTINO", &
					"398_ITEM_NF_VENDA_DESTINO", &					
					"081_ITEM_NF_VENDA", &
					"381_ITEM_NF_VENDA", &					
					"085_ITEM_NF_DEVOLUCAO_VENDA", &
					"385_ITEM_NF_DEVOLUCAO_VENDA", &					
					"052_ITEM_NF_VENDA_DESCONTO", &
					"352_ITEM_NF_VENDA_DESCONTO", &										
					"040_REGISTRO_DEVOLUCAO_VENDA_MANIP", &
					"340_REGISTRO_DEVOLUCAO_VENDA_MANIP", &					
					"020_REGISTRO_VENDA_MANIP", &
					"320_REGISTRO_VENDA_MANIP", &					
					"037_ITEM_NF_DEVOLUCAO_VENDA_LOTE", &
					"337_ITEM_NF_DEVOLUCAO_VENDA_LOTE", &					
					"001_ITEM_NF_DEV_VENDA_DESTINO", &
					"301_ITEM_NF_DEV_VENDA_DESTINO", &
					"007_CAIXA",&
					"008_NF_DIVERSA_VENDA", &
					"123_NF_COMPRA_PENDENTE", &					
					"123_NF_COMPRA", &					
					"128_LOG_CANCELAMENTO_FISCAL", &
					"133_HIST_CONTROLE_AUDITORIA_PRD", &
					"134_PRODUTO_PRESTE_A_VENCER",&
					"136_USUARIO_LOGIN",&
					"146_ITEM_NF_TRANSFERENCIA", &
					"148_NF_TRANSFERENCIA", &
					"150_NEGOCIACAO_CLIENTE",&
					"152_CLIENTE_CAIXA",&
					"051_ITEM_NF_TRANSFERENCIA_LOTE",&
					"144_RETIRADA_ESTOQUE",&
					"145_RETIRADA_ESTOQUE_PRODUTO",&
					"154_ITEM_NF_TRANSFERENCIA_ENTRADA",&
					"110_VENDA_PBM", &
					"091_VENDA_PBM_PRODUTO", &
					"391_VENDA_PBM_PRODUTO" }


				

//"033_ITEM_NF_DEVOLUCAO_COMPRA", &
//"087_ITEM_NF_TRANSFERENCIA", &
//"113_NF_TRANSFERENCIA", &
//"035_CLIENTE_CAIXA", &
//"126_PRODUTO_PRESTE_A_VENCER", &

// C$$HEX1$$f300$$ENDHEX$$digos das tabelas que ao importar no sybase central, 
// deve ser carregada a datastore '_central'
This.ivs_Excessoes_Central = {"004", &
										"026", &
										"030", &
										"032_sistema_filial", &
										"046", &
										"048", &
										"053", &
										"054_sngpc_historico_arquivo_filial", &
										"055_local_estocagem_filial", &
										"057", &
										"059_confirmacao_importacao_filial", &
										"061", &
										"062", &
										"070", &
										"071", &
										"072", &
										"075_log_fechamento_diario_filial", &
										"077", &
										"002", &
										"107", &
										"080", &
										"083", &
										"120", &
										"128",&
										"152"}
										
// C$$HEX1$$f300$$ENDHEX$$digos das tabelas que ao exportar na filial, 
// pode n$$HEX1$$e300$$ENDHEX$$o existir mais o registro na tabela
This.ivs_Permite_Exclusao = {	"011", &
										"014", &
										"017", &
										"025", &
										"027", &
										"028", &
										"029", &
										"054", &
										"061", &
										"068", &
										"078", &
										"114", &
										"074", &
										"086", &
										"120", &
										"083", &
										"123", &
										"020", &
										"320", &
										"051", &
										"133", &
										"065"}

If Not ivds_Tabelas.of_ChangeDataObject('ds_relacao_tabelas') Then
	Return False
End If

For ll_Linha = 1 To UpperBound(ls_Tabelas)
	
	//Condi$$HEX2$$e700e300$$ENDHEX$$o para tirar da lista de tabelas do TL quando existe mudan$$HEX1$$e700$$ENDHEX$$a de leiaute
	If gvo_Aplicacao.ivo_Seguranca.cd_Sistema = 'TL' Then
		Choose Case ls_Tabelas[ll_Linha]
			Case	"132_ITEM_NF_DEVOLUCAO_COMPRA"
				Continue						
		End Choose
	End If
	
	ll_Insert = ivds_Tabelas.InsertRow(0)
	
	ivds_Tabelas.Object.Nm_Datastore[ll_Insert] = ls_Tabelas[ll_Linha]	
Next

Return True
end function

public function boolean of_abre_log (string ps_arquivo);ivi_Log = FileOpen(ps_Arquivo, LineMode!, Write!, Shared!, Replace!)

If ivi_Log = -1 Then	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na abertura do arquivo : " + ps_Arquivo + ".", StopSign!)
	Return False
End If

Return True
end function

public function boolean of_appendwhere_import (string ps_tabela, string ps_registro, ref dc_uo_ds_base pds_datastore, ref string ps_chave_log);Long ll_Row
Long ll_Rows
Long ll_Coluna
Long ll_Colunas
Long ll_Limit
Long ll_Inicio
Long ll_Where = 0
Long ll_Idx_Tabela

String ls_Objeto
String ls_Tipo
String ls_Valor
String ls_Coluna_Chave

Date ldt_Date

Time lt_Time
		
ll_Rows = ivds_PK.RowCount()

ll_Colunas	= Long( pds_Datastore.Describe( "DataWindow.Column.Count" ) )

ll_Inicio = 5

If ll_Rows > 0 Then
	For ll_Row = 1 To ll_Rows
		If ll_Where = ll_Rows Then Exit
		
		ls_Coluna_Chave 	=	Trim(ivds_PK.Object.Nm_Coluna[ll_Row])
		ls_Valor				=	""			
		
		For ll_Coluna = ll_Row To ll_Colunas
			ls_Objeto	= pds_Datastore.Describe( "#" + String( ll_Coluna ) + ".Name" )
			ls_Tipo		= Upper( pds_Datastore.Describe( ls_Objeto + ".ColType" ) )
								
			If Mid( ls_Tipo, 1, 7 ) = "DECIMAL" Then
				ls_Tipo = "DECIMAL"
			ElseIf Mid( ls_Tipo, 1, 4 ) =  "REAL" Then
				ls_Tipo = "REAL"
			End If
			
			Choose Case ls_Tipo
				Case "DATE"
					ll_Limit = 8
					
				Case "DATETIME", "TIMESTAMP"
					ll_Limit = 14
					
				Case "DECIMAL", "REAL"
					ll_Limit = ICI_DECIMAL
					
				Case "INT", "LONG", "ULONG", "NUMBER"
					ll_Limit = 10
					
				Case "TIME"
					ll_Limit = 6
					
				Case Else
					If Mid( ls_Tipo, 1, 4 ) = "CHAR" Then
						ll_Limit	=	Long( Mid( ls_Tipo, 6, LenA( ls_Tipo ) -6 )  )
						If ll_Limit = 32766 Then
							ll_Limit = ivl_Limite_Campo_Text
						End If										
					End If
			End Choose
			
			If ls_Coluna_Chave <> ls_Objeto Then
				ll_Inicio += ll_Limit
				Continue
			End If
			
			Choose Case ls_Tipo
					
				Case "DECIMAL", "REAL"
					ls_Valor = String(Dec(MidA( ps_Registro, ll_Inicio, ll_Limit )))
					ls_Valor = gf_Replace(ls_Valor, ",", ".", 0)
					
				Case "INT", "LONG", "NUMBER", "ULONG"
					ls_Valor = String(Long(MidA( ps_Registro, ll_Inicio, ll_Limit )))
				
				Case "DATETIME"
					ldt_Date	= Date(MidA( ps_Registro, ll_Inicio, 2) + "/" + MidA( ps_Registro, ll_Inicio + 2, 2) + "/" + MidA( ps_Registro, ll_Inicio + 4, 4))
					lt_Time	= Time(MidA( ps_Registro, ll_Inicio + 8, 2) + ":" + MidA( ps_Registro, ll_Inicio + 10, 2) + ":" + MidA( ps_Registro, ll_Inicio + 12, 2))
					ls_Valor = "'" + String(DateTime(ldt_Date, lt_Time), "YYYY/MM/DD HH:MM:SS") + "'"
				
				Case Else
					ls_Valor = "'" + Trim(MidA( ps_Registro, ll_Inicio, ll_Limit )) + "'"
					
			End Choose
			
			If ll_Where > 0 Then
				ps_Chave_Log += ' - '
			End If
			
			ps_Chave_Log += ls_Valor			
			pds_DataStore.of_AppendWhere( ls_Coluna_Chave + " = " + ls_Valor )
			ll_Inicio += ll_Limit
			ll_Where++
			Exit
			
		Next
		
	Next
	
End If

Return True
end function

public subroutine of_grava_log (integer pi_arquivo, string ps_mensagem);Integer lvi_Status

String lvs_Mensagem 

lvs_Mensagem = String(DateTime(Today(), Now())) + "  " + ps_Mensagem
	
lvi_Status = FileWrite(pi_Arquivo, lvs_Mensagem)

IF lvi_Status <> LenA(lvs_Mensagem) THEN
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro no arquivo '" + ivs_Log + "'~rTexto: " + lvs_Mensagem, StopSign!)
END IF
end subroutine

public function boolean of_backup_importacao (long pl_filial);String lvs_Arquivo_Original, &
       lvs_Arquivo_Backup, &
		 lvs_Arquivo_Log, &
		 lvs_Arquivo

String lvs_Erro_Zip

Integer lvi_Retorno

String ls_Backup_Importacao

ls_Backup_Importacao = ProfileString(gvo_Aplicacao.ivs_Arquivo_Ini, "Diretorio", "Backup_Importacao", "")

If ls_Backup_Importacao = '' Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Diret$$HEX1$$f300$$ENDHEX$$rio de Backup da Importa$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o configurado no arquivo '" + gvo_Aplicacao.ivs_Arquivo_Ini + "'.", StopSign!)
	Return False
End If

lvs_Arquivo		 		=  MidA( ivs_Arquivo, 1, LenA( ivs_Arquivo ) - 4 )
lvs_Arquivo_Original	=	ivs_Caminho_Arquivo + lvs_Arquivo + '.txt'
lvs_Arquivo_Log		=	lvs_Arquivo + '.log'

lvs_Arquivo_Backup = ls_Backup_Importacao + "\" + &
                     String(pl_Filial, "0000") + "\" + lvs_Arquivo + ".zip"

If FileExists(lvs_Arquivo_Backup) Then
	If Not FileDelete(lvs_Arquivo_Backup) Then
		//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na exclus$$HEX1$$e300$$ENDHEX$$o do arquivo de backup '" + lvs_Arquivo_Backup + "'.", StopSign!)
		Return False
	End If
End If

dc_uo_zip lvo_Zip
lvo_Zip = Create dc_uo_zip
lvo_Zip.of_Salva_Estrutura( False )

lvs_Erro_Zip = lvo_Zip.of_Zip( lvs_Arquivo_Original, lvs_Arquivo_Backup )

Destroy lvo_Zip

If  lvs_Erro_Zip = "" Then //Compactou sem erro
	If FileDelete(lvs_Arquivo_Original) Then
		// Se o arquivo de log estiver vazio, exclui o arquivo
		If FileExists(lvs_Arquivo_Log) Then
			If FileLength(lvs_Arquivo_Log) = 0 Then
				If Not FileDelete(lvs_Arquivo_Log) Then
					//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na exclus$$HEX1$$e300$$ENDHEX$$o do arquivo de log '" + lvs_Arquivo_Log + "'.", StopSign!)
					Return False
				End If		
			End If
		End If
	End If
End If

Return True
end function

public subroutine _documentacao ();/* Documenta$$HEX2$$e700e300$$ENDHEX$$o para Exporta$$HEX2$$e700e300$$ENDHEX$$o LOJA -> CENTRAL

IMPORTANTE
	Somente ap$$HEX1$$f300$$ENDHEX$$s o sistema estar atualizado na filial, criar ou alterar a trigger de insert,update ou a trigger de insert, update e delete,
	 caso os dados para update sejam condicionais, para come$$HEX1$$e700$$ENDHEX$$ar a gravar log_exportacao.
--
    Criar DataStore na GE212 ds_ + c$$HEX1$$f300$$ENDHEX$$digo da tabela no log_exportacao + _ + nome da tabela no banco. Ex.: ds_001_nf_venda
	Observa$$HEX2$$e700f500$$ENDHEX$$es: 	- N$$HEX1$$e300$$ENDHEX$$o fazer joins, listar apenas os campos da pr$$HEX1$$f300$$ENDHEX$$xima tabela, sem apelidar.
						- N$$HEX1$$e300$$ENDHEX$$o usar Where, exceto em caso de joins.
						- Dar preferencia em listar os campos que comp$$HEX1$$f500$$ENDHEX$$e a Primary Key no in$$HEX1$$ed00$$ENDHEX$$cio, pois melhora a performance.
						- Verificar e acertar o UPDATE PROPERTIES, Key Columns e Use Update.
						- Caso haja diferen$$HEX1$$e700$$ENDHEX$$a entre a tabela da filial e a do Central, deve-se criar outra DataStore para a importa$$HEX2$$e700e300$$ENDHEX$$o, como o
						  nome _central no final, Ex: ds_001_nf_venda_central, e inserir o c$$HEX1$$f300$$ENDHEX$$digo da tabela em um valor do array ivs_Excessoes_Central
						  na fun$$HEX2$$e700e300$$ENDHEX$$o of_carrega_tabelas_loja deste objeto
						- Para exportacao fazer o mesmo descrito acima, a diferen$$HEX1$$e700$$ENDHEX$$a $$HEX1$$e900$$ENDHEX$$ aque no final do nome vai _loja e o array a ser alimentado $$HEX1$$e900$$ENDHEX$$ o 
						  ivs_Excessoes_Loja na fun$$HEX2$$e700e300$$ENDHEX$$o of_central_carrega_tabelas deste objeto.
						- Caso no central o nome da tabela seja diferenta da loja, e inserir o c$$HEX1$$f300$$ENDHEX$$digo da tabela em um valor do array ivs_Excessoes_Central
						  na fun$$HEX2$$e700e300$$ENDHEX$$o of_carrega_tabelas_loja deste objeto, ao lado do c$$HEX1$$f300$$ENDHEX$$digo separado pelo "_" colocar o nome da tabela no central.
						  Ex.: sistema (Loja) e sistema_filial (Central).
						- Nas triggers de delete, limitar a busca do registro a ser exclu$$HEX1$$ed00$$ENDHEX$$do em alguns meses, a fim de evitar problemas com a 
							limpeza do banco da Loja.
						  Ex.: Trigger "td_item_nf_devolucao_venda_lote".  
						  	SQL: nf_devolucao_venda.dh_movimentacao_caixa >= dateadd(day, -120, getdate())							  
						-	No S:\SistemaPB12\Troca_DaDos_Loja\Documentacao existe o arquivo Relacao_Tabelas_TL.sql, 
							que ordena o envio de tabelas no troca dados, para evitar problemas de FK							  

   Incluir novo valor na fun$$HEX2$$e700e300$$ENDHEX$$o of_carrega_tabelas_loja deste objeto, no array ls_Tabelas, c$$HEX1$$f300$$ENDHEX$$digo da tabela no log_exportacao + nome da tabela
	no banco - Ex.: 001_NF_VENDA
	
  Em caso de exporta$$HEX2$$e700e300$$ENDHEX$$o de tabela completa, Exemplo sistema_pdv, n$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ necessidade de criar trigger, por$$HEX1$$e900$$ENDHEX$$m, incluir o sql que seria da trigger
	na fun$$HEX2$$e700e300$$ENDHEX$$o wf_grava_log_exportacao da biblioteca tl003 na w_calculos_fechamento_diario
	
Caso alguma coluna de alguma tabela possa importar com valor '' (branco) no central, na mesma coluna da datawindow de importa$$HEX2$$e700e300$$ENDHEX$$o,
	deve ser marcada a op$$HEX2$$e700e300$$ENDHEX$$o "Empty String Is NULL", na aba Edit.
	 [ A l$$HEX1$$f300$$ENDHEX$$gica est$$HEX1$$e100$$ENDHEX$$ invertida, por$$HEX1$$e900$$ENDHEX$$m, como $$HEX1$$e900$$ENDHEX$$ mais raro poder importar valor branco, seria mais trabalhoso fazer da forma mais l$$HEX1$$f300$$ENDHEX$$gica ]
	 
	 
Tabelas que exportam central -> loja devem estar no of_central_carrega_tabelas( ) e no CASE do uo_tdc012_troca_dados_central.of_registro_comum( /*string as_tabela*/, /*string as_chave*/, /*string as_operacao*/, /*ref string as_registro*/, /*ref long al_seq_arquivo */)
Tabelas que exportam loja -> central devem estar no of_carrega_tabelas_loja( )
*/

/*
Altera$$HEX2$$e700e300$$ENDHEX$$o de leiaute em tabela existente / adicionar nova coluna no SQL
	Salvar a nova DW com um novo c$$HEX1$$f300$$ENDHEX$$digo
	Incluir a mesma na fun$$HEX2$$e700e300$$ENDHEX$$o of_carrega_tabelas_loja deste objeto, no array ls_Tabelas
	Se for o caso de DW diferente entre central e filial, incluir tamb$$HEX1$$e900$$ENDHEX$$m no ivs_Excessoes_Central  da fun$$HEX2$$e700e300$$ENDHEX$$o of_carrega_tabelas_loja
	Incluir o nome da antiga DW no case de tratamento de altera$$HEX2$$e700e300$$ENDHEX$$o de leiaute no final da fun$$HEX2$$e700e300$$ENDHEX$$o of_carrega_tabelas_loja
	Se existir tratamento para exclus$$HEX1$$e300$$ENDHEX$$o de colunas para a tabela, deixar os campos que s$$HEX1$$e300$$ENDHEX$$o excluidos, sempre por ultimo na consulta da DW.
*/

/*
Altera$$HEX2$$e700e300$$ENDHEX$$o de tabelas para a nova forma do troca dados quando a informa$$HEX2$$e700e300$$ENDHEX$$o for MATRIZ ==> FILIAL
	Se n$$HEX1$$e300$$ENDHEX$$o exisitir a DataStore para tabela criar no mesmo exemplo j$$HEX1$$e100$$ENDHEX$$ citado acima.
	Se existir e os campos atualizados forem diferentes na loja, colocar "_loja" no final do nome da ds e acresentar o codigo no array ivs_Excessoes_Loja
	Depois que o troca dados LOJA estiver em toda a rede
	-retirar da funcao of_registro_comum do uo_tdc012_troca_dados_central as chamadas para as tabelas alteradas e colocar o nome da tabela no case no final da funcao.
	-realizar as altera$$HEX2$$e700e300$$ENDHEX$$o necessarias nas triggers para gravar o log exporta$$HEX2$$e700e300$$ENDHEX$$o. Caso cantrario pode gerar log na MATRIZ de "TABELA NAO PREVISTA"
*/

//TRATAMENTO ESPECIAL para tabela promocao_sos_produto, quando processa na loja, usa ds PROMOCAO_SOS_ESTOQUE_MINIMO(of_loja_grava_registro)

//TRATAMENTO ESPECIAL 2 - tratamentos para processo de NF_COMPRA >> NF_COMPRA_PENDENTE
/*NF_COMPRA 						==> NF_COMPRA_PENDENTE
	ITEM_NF_COMPRA 			==> NF_COMPRA_PENDENTE_PRODUTO
	ITEM_NF_COMPRA_LOTE 	==> NF_COMPRA_PENDENTE_PRD_LOTE
	
	Na loja, o troca_dados_loja dever$$HEX1$$e100$$ENDHEX$$ exportar a nf_compra e suas dependentes e o troca_dados_central ir$$HEX1$$e100$$ENDHEX$$ importar sempre 
	na nf_compra_pendente e suas dependentes.
	Ao importar no central a datastore carregada sera ds_104_nf_compra_pendente
	e a ds_105_nf_compra_pendente_produto, onde far$$HEX1$$e100$$ENDHEX$$ que a atualiza$$HEX2$$e700e300$$ENDHEX$$o ocorra nas tabelas pendentes.
	
	No Central ao exportar para as loja, vai carregar a respectiva datastore, se baseando na tabela do log_exportacao_filial, a diferen$$HEX1$$e700$$ENDHEX$$a $$HEX1$$e900$$ENDHEX$$ na loja que ao importar,
	no caso de NF_COMPRA vai carregar a ds_104_compra_loja e ao exportar da loja tamb$$HEX1$$e900$$ENDHEX$$m.
*/

end subroutine

public function boolean of_loja_grava_registro (string ps_tabela, string ps_chave_log, string ps_atualizacao);Long ll_Loop
Long ll_Colunas
Long ll_Limit
Long ll_Linha
Long ll_Retrieve

String ls_Objetos[]
String ls_Objeto
String ls_Tipo
String ls_Retorno
String ls_Valor
String ls_String
String ls_DataStore
String ls_Cd_Tabela
String ls_Tabela
String ls_Sql_Alterado
String ls_Erro

If Not SqlCa.of_IsConnected( ) Then
	of_Envia_Email_Erro(	"Conex$$HEX1$$e300$$ENDHEX$$o com o banco de dados perdida", 'of_loja_grava_registro()', 20)
	Halt Close
End If

dc_uo_ds_base	lds_Datastore

ls_Tabela = Upper(ps_Tabela)

//If ls_Tabela = 'ITEM_NF_DEVOLUCAO_VENDA' Then
//	ls_Tabela = ls_Tabela
//End If

Choose Case ls_Tabela
	//Devido a particularidade desta tabela, quando vem da loja para o central usa a DS com o nome da tabela que atualiza aqui no central.
	Case 'PROMOCAO_SOS_PRODUTO' 
		ls_Tabela = 'PROMOCAO_SOS_ESTOQUE_MINIMO'		
		
	Case 'CARTAO_COMPROVANTE_VENDA'
		ls_Tabela = ls_Tabela
End Choose



ll_Linha = ivds_Tabelas.Find( "mid(nm_datastore, 5) = '" + ls_Tabela + "'", 1, ivds_Tabelas.RowCount() )

If ll_Linha = 0 Then
	This.of_Envia_Email_Erro( "Tabela '" + ls_Tabela + "' n$$HEX1$$e300$$ENDHEX$$o prevista para exporta$$HEX2$$e700e300$$ENDHEX$$o.", 'of_loja_grava_registro()', 41 )
	Return False
End If

If ll_Linha < 0 Then
	This.of_Envia_Email_Erro( "Erro no Find. Fun$$HEX2$$e700e300$$ENDHEX$$o: of_Grava_Registro(), Tabela: " + ls_Tabela, 'of_loja_grava_registro( )', 46 )
	Return False
End If

ls_Cd_Tabela = LeftA(ivds_Tabelas.Object.Nm_DataStore[ll_Linha], 3)

/**********************************
* Fernando Cambiaghi - 17/05/2016
 Mudan$$HEX1$$e700$$ENDHEX$$a na estrutura da item_nf_venda e suas relacoes ( PODE SER REMOVIDO APOS A ALTERA$$HEX2$$c700c300$$ENDHEX$$O DA ESTRUTURA EM TODAS AS FILIAIS, INCLUSIVE A FUN$$HEX2$$c700c300$$ENDHEX$$O of_Loja_Novo_Leiaute_Item_Nf_Venda( string ) )
  *********************************/
If This.of_Loja_Novo_Leiaute_Item_Nf_Venda( Lower( ps_Tabela ) ) Then
	ls_Cd_Tabela = '3' + Mid( ls_Cd_Tabela, 2 )
End If
/**********************************
 FIM - Mudan$$HEX1$$e700$$ENDHEX$$a na estrutura da item_nf_venda e suas relacoes 
  *********************************/

//Debug
//If ls_Cd_Tabela = '122' or ls_Cd_Tabela = '081' Then
//	ls_Cd_Tabela = ls_Cd_Tabela
//End If

ls_DataStore = 'ds_' + ls_Cd_Tabela + '_' + ps_Tabela

If ls_Tabela = 'PROMOCAO_SOS_ESTOQUE_MINIMO' Then
	ls_DataStore = 'ds_' + ls_Cd_Tabela + '_' + ls_Tabela
End If

If ls_Tabela = 'NF_COMPRA' Then
	ls_DataStore = 'ds_' + ls_Cd_Tabela + '_' + 'NF_COMPRA_LOJA'
End If

lds_Datastore = Create dc_uo_ds_base
If Not lds_Datastore.of_ChangeDataObject( ls_DataStore ) Then
	Destroy lds_Datastore
	Return False
End If

If ps_Atualizacao = 'E' Then
	If Upper(ps_Tabela) = 'SALDO_PRODUTO_LOTE' Then // Tratamento especial
		This.of_loja_grava_reg_exclusao_sld_prd_lote( ps_Tabela, ls_Cd_Tabela, ps_Chave_Log )
	Else
		This.of_Loja_Grava_Registro_Exclusao( ps_Tabela, ls_Cd_Tabela, ps_Chave_Log, lds_Datastore )
	End If
	
	Destroy lds_Datastore
	Return True
End If

This.of_AppendWhere( ps_Tabela, ps_Chave_Log, ref lds_Datastore, 'LOJA' )

ll_Retrieve = lds_Datastore.Retrieve()

For ll_Loop = 1 To UpperBound( This.ivs_Permite_Exclusao )
	If Left(This.ivs_Permite_Exclusao[ll_Loop], 3) = ls_Cd_Tabela Then
		If lds_Datastore.RowCount() < 1 Then
			If Upper(ps_Tabela) <> 'SALDO_PRODUTO_LOTE' Then // Tratamento especial
				This.of_Loja_Grava_Registro_Exclusao( ps_Tabela, ls_Cd_Tabela, ps_Chave_Log, lds_Datastore )
			End If
			Destroy lds_Datastore
			Return True
		End If
	End If
Next

If ll_Retrieve < 1 Then
	If Upper( ps_Tabela ) <> 'SISTEMA_PDV' THEN
		If lds_Datastore.RowCount() = 0 Then
			ls_Erro =	"Nenhum registro localizado na tabela '" + ls_DataStore + "'. Chave: " + ps_Chave_Log + &
						"~rImportante, favor abrir um chamado no Service Desk com esta mensagem."

		Else
			ls_Erro =	"Ocorreram erros ao tentar recuperar as informa$$HEX2$$e700f500$$ENDHEX$$es da '" + ls_DataStore + "'. Chave: " + ps_Chave_Log + &
						"~r" + lds_Datastore.ivo_DbError.ivs_Mensagem + &
						"~rImportante, favor abrir um chamado no Service Desk com esta mensagem."
	
			MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Erro, StopSign!)
		End If

		ls_Sql_Alterado = lds_Datastore.Object.DataWindow.Table.Select // Debug
										
		//Envia email com erro ocorrido.
		of_Envia_Email_Erro(	ls_Erro + " ~r~r SQL: " + ls_Sql_Alterado, 'of_loja_grava_registro()', 128 )
		//
	End If
	
	If lds_Datastore.RowCount() = 0 Then
		Destroy lds_Datastore
		Return True
	Else
		Destroy lds_Datastore
		Return False
	End If
End If

ls_String		= ''
ll_Colunas	= Long( lds_Datastore.Describe( "DataWindow.Column.Count" ) )

For ll_Loop = 1 To ll_Colunas
	ls_Objeto	= lds_Datastore.Describe( "#" + String(ll_Loop) + ".Name" )
	ls_Tipo		= Upper( lds_Datastore.Describe( ls_Objeto + ".ColType" ) )

	Choose Case ls_Tipo
		Case "DATE"
			ls_Valor = String(lds_Datastore.GetItemDate( 1, ls_Objeto ) )
			
			If IsNull( ls_Valor ) Then
				ls_Retorno = Space(14)
			Else
				ls_Retorno = LeftA( String(lds_Datastore.GetItemDate( 1, ls_Objeto ), "ddmmyyyy" ), 8)
				ls_Retorno = ls_Retorno + "000000"
			End If
			
		Case "DATETIME", "TIMESTAMP"
			ls_Valor = String(lds_Datastore.GetItemDateTime( 1, ls_Objeto ) )
			
			If IsNull( ls_Valor ) Then
				ls_Retorno = Space(14)
			Else
				ls_Retorno = LeftA( String(lds_Datastore.GetItemDateTime( 1, ls_Objeto ), "ddmmyyyyhhmmss" ), 14)
			End If
			
		Case "DECIMAL", "REAL"
			ls_Valor = String( lds_Datastore.GetItemDecimal( 1, ls_Objeto ) )
			If IsNull( ls_Valor ) Then ls_Valor = ""
			ls_Retorno =  ivo_Comum.of_String( ls_Valor, ICI_DECIMAL )
			
		Case "INT", "LONG", "NUMBER", "ULONG"
			ls_Valor = String(lds_Datastore.GetItemNumber( 1, ls_Objeto ) )
			If IsNull( ls_Valor ) Then ls_Valor = ""
			ls_Retorno = ivo_Comum.of_String( ls_Valor, 10 )
			
		Case "TIME"
			ls_Valor = String(lds_Datastore.GetItemTime( 1, ls_Objeto ) )
			
			If IsNull( ls_Valor ) Then
				ls_Retorno = Space(14)
			Else
				ls_Retorno = LeftA( String(lds_Datastore.GetItemTime( 1, ls_Objeto ), "hhmmss" ), 6)
			End If
			
		Case Else
			If Mid( ls_Tipo, 1, 4 ) = "CHAR" Then
				ls_Valor 		=	String( lds_Datastore.GetItemString( 1, ls_Objeto ) )
				If IsNull( ls_Valor ) Then ls_Valor = ""
				ls_Valor 		=	gf_Replace( ls_Valor, "~r", " ", 0 )
				ls_Valor 		=	gf_Replace( ls_Valor, "~n", " ", 0 )
				ll_Limit		=	Long( Mid( ls_Tipo, 6, LenA( ls_Tipo ) -6 )  )
				//Verifica$$HEX2$$e700e300$$ENDHEX$$o para se o campo for do tipo TEXT(identificacao_biometrica) altera o seu limite
				//Pois o FileWrite grava at$$HEX1$$e900$$ENDHEX$$ 32766 e esse tipo de campo usa todo o limite.
				If ll_Limit = 32766 Then
					ll_Limit = ivl_Limite_Campo_Text
				End If				
				ls_Retorno 	=	LeftA( ls_Valor , ll_Limit ) + Space( ll_Limit - LenA(ls_Valor) )
			End If
			
			If Mid( ls_Tipo, 1, 7 ) = "DECIMAL" Or Mid( ls_Tipo, 1, 4 ) =  "REAL" Then
				ls_Valor = String( lds_Datastore.GetItemDecimal( 1, ls_Objeto ) )
				If IsNull( ls_Valor ) Then ls_Valor = ""
				ls_Retorno = ivo_Comum.of_String( ls_Valor, ICI_DECIMAL )
			End If
			
	End Choose
	
	ls_String += ls_Retorno
Next
	
If Not This.of_Grava_Arquivo( ps_Atualizacao + ls_Cd_Tabela + ls_String ) Then Return False

Destroy lds_Datastore
Return True
end function

public function boolean of_loja_nome_arquivo ();Boolean lb_Sucesso = False

Long lvl_Arquivo
Long ll_Filial
Long ll_Matriz

uo_Parametro_Filial lvo_Parametro
lvo_Parametro = Create uo_Parametro_Filial

gf_Filiais_Parametro( ref ll_Filial, ref ll_Matriz )

If lvo_Parametro.of_Localiza_Parametro("NR_ULTIMO_ARQUIVO_TL", ref lvl_Arquivo) Then
	ivs_Arquivo = "F" + String(ll_Filial, "0000") + "_" + String(lvl_Arquivo + 1, "000000") + ".txt"
	lb_Sucesso = True
End If

Destroy(lvo_Parametro)

Return lb_Sucesso
end function

public function boolean of_loja_grava_registro_exclusao (string ps_tabela, string ps_cd_tabela, string ps_chave, dc_uo_ds_base pds_datastore);Long ll_Rows
Long ll_Coluna
Long ll_Colunas
Long ll_Limit
Long ll_Where = 0

String ls_Objeto
String ls_Tipo
String ls_Valor
String ls_Coluna_Chave
String ls_Registro
String ls_Ds

dc_uo_ds_base lds_PK
lds_PK = Create dc_uo_ds_base

ls_Ds = 'dw_primary_keys'

If SqlCa.of_Dbms_Name() = 'POSTGRESQL' Then
	ls_Ds += '_pg'
End If

If lds_PK.of_ChangeDataObject( ls_Ds ) Then
	ll_Rows		= lds_PK.Retrieve( Lower( ps_Tabela ) )
	ll_Colunas	= Long( lds_PK.Describe( "DataWindow.Column.Count" ) )
	
	If ll_Rows > 0 Then
		For ll_Coluna = 1 To ll_Rows
			ls_Objeto	= pds_Datastore.Describe( "#" + String( ll_Coluna ) + ".Name" )
			ls_Tipo		= Upper( pds_Datastore.Describe( ls_Objeto + ".ColType" ) )				
			ls_Valor 		= This.of_Coluna_Chave( ps_Chave, ll_Coluna )
			
			Choose Case ls_Tipo
				Case "DATE"
					ll_Limit = 14
					
				Case "DATETIME", "TIMESTAMP"
					ll_Limit = 14					
					ls_Valor = String(Datetime(ls_Valor), "ddmmyyyyhhmmss" )
					
				Case "DECIMAL", "REAL"
					ll_Limit = ICI_DECIMAL
					
				Case "INT", "LONG", "ULONG", "NUMBER"
					ll_Limit = 10
					
				Case "TIME"
					ll_Limit = 6
					
				Case Else
					If Mid( ls_Tipo, 1, 4 ) = "CHAR" Then
						ll_Limit	=	Long( Mid( ls_Tipo, 6, LenA( ls_Tipo ) -6 )  )
						If ll_Limit = 32766 Then
							ll_Limit = ivl_Limite_Campo_Text
						End If										
					End If
			End Choose
			
			ls_Valor = ivo_Comum.of_String(ls_Valor, ll_Limit)
			ls_Registro += ls_Valor
			
		Next
	Else
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao recuperar as informa$$HEX2$$e700f500$$ENDHEX$$es da DataStore 'dw_primary_keys'." )
	End If
	
End If

If Not This.of_Grava_Arquivo( 'E' + ps_Cd_Tabela + ls_Registro ) Then Return False		

Destroy lds_PK

Return True
end function

public function boolean of_central_verifica_ultimo_arquivo_imp (long pl_filial, ref long pl_nr_arquivo);Select max( nr_arquivo )
   Into :pl_Nr_Arquivo
  From controle_importacao
Where cd_filial = :pl_filial
  Using SqlCa;
  
Choose Case SqlCa.SqlCode
	Case -1
		SqlCa.of_MsgDbError()
		Return False
		
	Case 0
		If IsNull(pl_Nr_arquivo) Then
			pl_Nr_arquivo = 0
		
			Insert Into controle_importacao
				(cd_filial, nr_arquivo)
			 Values ( :pl_filial, :pl_Nr_arquivo )
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				SqlCa.of_MsgDbError()
				Return False
			End If
			
			SqlCa.of_Commit()
		End If
		
End Choose

Return True
end function

public function boolean of_central_importa_registro (string ps_cd_tabela, string ps_nm_tabela, string ps_registro, long pl_linha);dwItemStatus l_status

Boolean lb_Sucesso = True
Boolean lb_Atualizacao = False
Boolean lb_Chave = False
Boolean lb_Atualiza = True
Boolean lb_SetNull
Boolean lb_Envia_Email_Debug = False

Decimal ldc_Antes
Decimal ldc_Depois
Decimal ldc_Decimal

Long ll_Loop
Long ll_Colunas
Long ll_Limit
Long ll_Linha
Long ll_Insert
Long ll_Inicio = 5
Long ll_Tamanho
Long ll_Chaves
Long ll_Chaves_Localizadas
Long ll_Find
Long ll_Casas_Decimais
Long ll_Estoque
Long ll_Promocao
Long ll_Fil_Promo
Long ll_Produto
Long ll_Filial

String ls_Objetos[]
String ls_Objeto
String ls_Tipo
String ls_Retorno
String ls_Valor
String ls_DataStore
String ls_Id_Atualizacao
String ls_Sql
String ls_Chave_Log
String ls_Mid
String ls_SetNull

/********** ENVIO DE EMAIL (Temporariamente ) ***********/
String ls_Texto_Email = ''
String ls_Texto_Email_Retrieve = ''
String ls_Campo_Email_Retrieve = ''
String ls_Email_Update = ''
/*********************************/

DateTime ldh_Verificacao_1
DateTime ldh_Verificacao_2
DateTime ldh_SetNull

SetNull( ldh_SetNull )
SetNull( ls_SetNull )

dc_uo_ds_base	lds_Datastore
dc_uo_ds_base	lds_Ds_Auxiliar

ls_DataStore = 'ds_'  + ps_Cd_Tabela + '_' + ps_Nm_Tabela

ll_Filial = Long( MidA( ivs_Arquivo, 2, 4 ) ) //F0785_002424

//Tipo de atualiza$$HEX2$$e700e300$$ENDHEX$$o do LOG
ls_Id_Atualizacao = LeftA( ps_Registro, 1 )

/* Transforma$$HEX2$$e700e300$$ENDHEX$$o de NF_COMPRA_PENDENTE */
Boolean lb_Compra_Pendente = False

Choose Case Upper(ps_Nm_Tabela)
	Case	'NF_COMPRA'
		ls_DataStore = 'ds_' + ps_Cd_Tabela + '_nf_compra_pendente'
		lb_Compra_Pendente = True
		
End Choose // Case NF_COMPRA

/* Carrega a datastore diferente para o Central, se for necess$$HEX1$$e100$$ENDHEX$$rio */
For ll_Loop = 1 To UpperBound( This.ivs_Excessoes_Central )
	If Left(This.ivs_Excessoes_Central[ll_Loop], 3) = ps_Cd_Tabela Then
		If Len(This.ivs_Excessoes_Central[ll_Loop]) > 3 Then		
				ps_Nm_Tabela = Lower(Mid(This.ivs_Excessoes_Central[ll_Loop], 5))
		End If
		
		ls_DataStore = 'ds_'  + ps_Cd_Tabela + '_' + ps_Nm_Tabela + '_central'
		Exit
	End If
Next

lds_Datastore = Create dc_uo_ds_base
If Not lds_Datastore.of_ChangeDataObject( ls_DataStore, False ) Then
	This.of_Grava_Log( ivi_Log, "LINHA: " + String( pl_Linha ) + " :: Erro na mudan$$HEX1$$e700$$ENDHEX$$a na DW '" + ls_DataStore + "'." )
	Destroy lds_Datastore
	Return False
End If

//Debug
#IF DEFINED DEBUG THEN
	//If Upper( ps_Nm_Tabela ) = 'ITEM_NF_DEVOLUCAO_VENDA' Then
	If ps_Cd_Tabela = '154' Then
		ps_Nm_Tabela = ps_Nm_Tabela
	End If
#END IF

If Upper( ps_Nm_Tabela ) = 'CARTAO_COMPROVANTE_VENDA' Then
	ll_Linha = 0
Else	
	This.of_Carrega_Campos_Chave( ps_cd_tabela, ps_nm_tabela, Ref ll_Chaves )
	This.of_AppendWhere_Import( ps_Nm_Tabela, ps_Registro, ref lds_Datastore, ref ls_Chave_Log )
	
	ls_Chave_Log = "LINHA: "+ String( pl_Linha ) + " :: " +Upper( ps_Nm_Tabela ) + "(" + ls_Chave_Log + ") :: "	
	ll_Linha = lds_Datastore.Retrieve( )	
End If

ls_Texto_Email += 'Arquivo: ' + ivs_Arquivo + ' | Linha do arquivo: ' + String( pl_Linha ) + ' | Retrieve: ' + String( ll_Linha ) + ' linhas<br />Registro: ' + ps_Registro + '<br />'

Choose Case ll_Linha
	Case 0
		lb_Atualizacao = False
		
		If ls_Id_Atualizacao <> 'E' Then
			ll_Linha = lds_Datastore.Insertrow(0)
		End If
		
		Choose Case Upper( ps_Nm_Tabela )
			Case	'NF_VENDA', &
					'NF_DEVOLUCAO_VENDA', &
					'NF_DEVOLUCAO_COMPRA', &
					'NF_TRANSFERENCIA' 
				/* S$$HEX1$$f300$$ENDHEX$$ importa as colunas referentes ao cancelamento das notas, se for Atualiza$$HEX2$$e700e300$$ENDHEX$$o
					  Necess$$HEX1$$e100$$ENDHEX$$rio para gravar movimenta$$HEX2$$e700e300$$ENDHEX$$o de estoque na Inclus$$HEX1$$e300$$ENDHEX$$o da Nota */
				
				// Destruir interfere na ordem dos campos que existem ap$$HEX1$$f300$$ENDHEX$$s eles
				//lds_Datastore.Modify("destroy column dh_cancelamento") // Remove a coluna da DataWindow/DataStore
				//lds_Datastore.Modify("destroy column nr_matricula_cancelamento")
				
				lds_Datastore.Modify("dh_cancelamento.Update = No")
				lds_Datastore.Modify("nr_matricula_cancelamento.Update = No")
				
			Case 'NF_COMPRA'
				If ls_Id_Atualizacao = 'A' And Not lb_Compra_Pendente Then
					Destroy lds_Datastore
					Return False
				End If
		End Choose
		
	Case 1
		lb_Atualizacao = True
		
		Choose Case Upper( ps_Nm_Tabela )
			Case	'NF_TRANSFERENCIA'			, &
					'ITEM_NF_TRANSFERENCIA', &
					'CONVENIADO'					, &
					'BLOQUEIO'						, &
					'NF_COMPRA'
					
				/* Se a nota de transferencia j$$HEX1$$e100$$ENDHEX$$ estiver cancelada, desabilita o update dos campos de cancelamento */
				If Upper( ps_Nm_Tabela ) = 'NF_TRANSFERENCIA' Then
					ldh_Verificacao_1 = DateTime( lds_Datastore.Object.Dh_Cancelamento[ 1 ] )
					
					If Not IsNull( ldh_Verificacao_1 ) Then
						lds_Datastore.Modify("dh_cancelamento.Update = No")
						lds_Datastore.Modify("nr_matricula_cancelamento.Update = No")
					End If
				End If
				/************************************************************************ */

				
				If ll_Linha > 0 Then
					lds_Ds_Auxiliar = Create dc_uo_ds_base
					lds_Ds_Auxiliar.of_ChangeDataObject( ls_DataStore )
			
					This.of_AppendWhere_Import( ps_Nm_Tabela, ps_Registro, ref lds_Ds_Auxiliar, ref ls_Chave_Log )
					lds_Ds_Auxiliar.Retrieve()
				End If
				
			Case 'NF_DEVOLUCAO_VENDA'
				If Not This.of_Central_Existe_Item_Nota( lds_Datastore, Upper( ps_Nm_Tabela ), ls_Chave_Log ) Then
					Destroy lds_Datastore
					Return lb_Sucesso
				End If
				
			Case 'TITULO_RECEBER'
				Destroy lds_Datastore
				Return lb_Sucesso
		End Choose
		
	Case Else
		If ll_Linha < 0 Then
			This.of_Grava_Log( ivi_Log, ls_Chave_Log + "Ocorreram erros ao tentar recuperar as informa$$HEX2$$e700f500$$ENDHEX$$es da '" + ls_DataStore + "'. " + &
											 			lds_Datastore.ivo_dbError.ivs_Mensagem)
		Else
			This.of_Grava_Log( ivi_Log, ls_Chave_Log + "Foi encontrada mais de uma linha no retrieve da '" + ls_DataStore + "'.")
		End If
		
		Destroy lds_Datastore
		Return False
		
End Choose
		
If ls_Id_Atualizacao <> 'E' Then
	
	ll_Colunas	= Long( lds_Datastore.Describe( "DataWindow.Column.Count" ) )
	
	For ll_Loop = 1 To ll_Colunas
		lb_SetNull = True
		
		ls_Objeto	= lds_Datastore.Describe( "#" + String(ll_Loop) + ".Name" )
		ls_Tipo		= Upper( lds_Datastore.Describe( ls_Objeto + ".ColType" ) )
		
		If Upper( lds_Datastore.Describe( "#" + String(ll_Loop) + ".Edit.NilIsNull" ) ) = "YES" Then
			lb_SetNull = False
		End If
		
		lb_Chave	= False
		
		//Se encontrou todas as chaves da tabela, n$$HEX1$$e300$$ENDHEX$$o precisa verificar os outros campos
		If ll_Chaves_Localizadas < ll_Chaves Then
			//N$$HEX1$$e300$$ENDHEX$$o atualizar o campo chave prim$$HEX1$$e100$$ENDHEX$$ria (lb_Chave = False). Problema no Update da data window no Sybase Central
			//Somente se for Insert (lb_Atualizacao = False).
			This.Of_Campo_Chave(ps_nm_tabela, ls_Objeto, Ref lb_Chave)
			If lb_Chave Then ll_Chaves_Localizadas++
		End If
							
		If Mid( ls_Tipo, 1, 7 ) = "DECIMAL" Then
			ls_Mid					=	MidA( ls_Tipo, 9 )
			ll_Casas_Decimais		=	Long( MidA( ls_Mid, 1, PosA( ls_Mid, ')' ) -1 ) )

			ls_Tipo = "DECIMAL"
		ElseIf Mid( ls_Tipo, 1, 4 ) =  "REAL" Then
			ls_Tipo = "REAL"
		End If
		
		Choose Case ls_Tipo
			Case "DATE"
				ll_Limit 		= 14
				ls_Retorno	= Trim(MidA( ps_Registro , ll_Inicio, ll_Limit ))
				
				If ls_Retorno = '' Then SetNull(ls_Retorno)
				
				/* Tempor$$HEX1$$e100$$ENDHEX$$rio, descobrir porque n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ importando cancelamento de transfer$$HEX1$$ea00$$ENDHEX$$ncia em alguns casos */
				ls_Campo_Email_Retrieve = String( lds_Datastore.GetItemDate( 1, ls_Objeto ) )
				/********************/
				
				If Not lb_Chave Or Not lb_Atualizacao Then
					If Not lb_Atualizacao &
						Or ( lds_Datastore.GetItemDate( 1, ls_Objeto ) <> ivo_Comum.of_Date( ls_Retorno ) ) &
						Or ( IsNull( lds_Datastore.GetItemDate( 1, ls_Objeto ) ) And Not IsNull( ls_Retorno ) ) &
						Or ( Not IsNull( lds_Datastore.GetItemDate( 1, ls_Objeto ) ) And IsNull( ls_Retorno ) ) Then
						
						ll_Insert = lds_Datastore.SetItem( ll_Linha, ls_Objeto, DateTime( ivo_Comum.of_Date( ls_Retorno ) ) )
					End If
				End If
				
			Case "DATETIME", "TIMESTAMP"
				ll_Limit 		= 14
				ls_Retorno	= Trim(MidA( ps_Registro , ll_Inicio, ll_Limit ))
				
				If ls_Retorno = '' Then SetNull(ls_Retorno)
				
				/* Tempor$$HEX1$$e100$$ENDHEX$$rio, descobrir porque n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ importando cancelamento de transfer$$HEX1$$ea00$$ENDHEX$$ncia em alguns casos */
				ls_Campo_Email_Retrieve = String( lds_Datastore.GetItemDateTime( 1, ls_Objeto ) )
				/********************/

				If Not lb_Chave Or Not lb_Atualizacao Then
					If Not lb_Atualizacao &
						Or ( lds_Datastore.GetItemDateTime( 1, ls_Objeto ) <> ivo_Comum.of_DateTime(ls_Retorno) ) &
						Or ( IsNull( lds_Datastore.GetItemDateTime( 1, ls_Objeto ) ) And Not IsNull( ls_Retorno ) ) &
						Or ( Not IsNull( lds_Datastore.GetItemDateTime( 1, ls_Objeto ) ) And IsNull( ls_Retorno ) ) Then
						
						ll_Insert = lds_Datastore.SetItem( ll_Linha, ls_Objeto, ivo_Comum.of_DateTime(ls_Retorno) )
					End If
				End If
				
			Case "DECIMAL", "REAL"
				ll_Limit 		= ICI_DECIMAL
				ls_Retorno	= Trim(MidA( ps_Registro , ll_Inicio, ll_Limit ))
				
				If ls_Retorno = '' Then SetNull(ls_Retorno)				
				ls_Retorno = gf_Replace(ls_Retorno, ",", "", 0)
				ls_Retorno = gf_Replace(ls_Retorno, ".", "", 0)
				
				/* Tempor$$HEX1$$e100$$ENDHEX$$rio, descobrir porque n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ importando cancelamento de transfer$$HEX1$$ea00$$ENDHEX$$ncia em alguns casos */
				ls_Campo_Email_Retrieve = String( lds_Datastore.GetItemDecimal( 1, ls_Objeto ) )
				/********************/

				If Not lb_Chave Or Not lb_Atualizacao Then
					ldc_Decimal	= ivo_Comum.of_Decimal( ls_Retorno, ll_Casas_Decimais )
					
					If Not lb_Atualizacao &
						Or ( lds_Datastore.GetItemDecimal( 1, ls_Objeto ) <> ldc_Decimal ) &
						Or ( IsNull( lds_Datastore.GetItemDecimal( 1, ls_Objeto ) ) And Not IsNull( ls_Retorno ) ) &
						Or ( Not IsNull( lds_Datastore.GetItemDecimal( 1, ls_Objeto ) ) And IsNull( ls_Retorno ) ) Then

						ll_Insert = lds_Datastore.SetItem( ll_Linha, ls_Objeto, ldc_Decimal )
					End If
				End If
				
			Case "INT"
				ll_Limit = 10
				ls_Retorno = Trim(MidA( ps_Registro , ll_Inicio, ll_Limit ))
				
				If ls_Retorno = '' Then SetNull(ls_Retorno)
				
				/* Tempor$$HEX1$$e100$$ENDHEX$$rio, descobrir porque n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ importando cancelamento de transfer$$HEX1$$ea00$$ENDHEX$$ncia em alguns casos */
				ls_Campo_Email_Retrieve = String( lds_Datastore.GetItemNumber( 1, ls_Objeto ) )
				/********************/

				If Not lb_Chave Or Not lb_Atualizacao Then
					If Not lb_Atualizacao &
						Or ( lds_Datastore.GetItemNumber( 1, ls_Objeto ) <> Integer(ls_Retorno) ) &
						Or ( IsNull( lds_Datastore.GetItemNumber( 1, ls_Objeto ) ) And Not IsNull( ls_Retorno ) ) &
						Or ( Not IsNull( lds_Datastore.GetItemNumber( 1, ls_Objeto ) ) And IsNull( ls_Retorno ) ) Then

						ll_Insert = lds_Datastore.SetItem( ll_Linha, ls_Objeto, Integer(ls_Retorno) )
					End If
				End If
			
			Case "LONG", "ULONG"
				ll_Limit = 10
				ls_Retorno = Trim(MidA( ps_Registro , ll_Inicio, ll_Limit ))
				
				If ls_Retorno = '' Then SetNull(ls_Retorno)
				
				/* Tempor$$HEX1$$e100$$ENDHEX$$rio, descobrir porque n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ importando cancelamento de transfer$$HEX1$$ea00$$ENDHEX$$ncia em alguns casos */
				ls_Campo_Email_Retrieve = String( lds_Datastore.GetItemNumber( 1, ls_Objeto ) )
				/********************/
				
				If Not lb_Chave Or Not lb_Atualizacao Then
					If Not lb_Atualizacao &
						Or ( lds_Datastore.GetItemNumber( 1, ls_Objeto ) <> Long(ls_Retorno) ) &
						Or ( IsNull( lds_Datastore.GetItemNumber( 1, ls_Objeto ) ) And Not IsNull( ls_Retorno ) ) &
						Or ( Not IsNull( lds_Datastore.GetItemNumber( 1, ls_Objeto ) ) And IsNull( ls_Retorno ) ) Then

						ll_Insert = lds_Datastore.SetItem( ll_Linha, ls_Objeto, Long(ls_Retorno) )
					End If
				End If
				
			Case  "NUMBER"
				ll_Limit = 10
				ls_Retorno = Trim(MidA( ps_Registro , ll_Inicio, ll_Limit ))
				
				If ls_Retorno = '' Then SetNull(ls_Retorno)

				/* Tempor$$HEX1$$e100$$ENDHEX$$rio, descobrir porque n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ importando cancelamento de transfer$$HEX1$$ea00$$ENDHEX$$ncia em alguns casos */
				ls_Campo_Email_Retrieve = String( lds_Datastore.GetItemNumber( 1, ls_Objeto ) )
				/********************/
				
				If Not lb_Chave Or Not lb_Atualizacao Then
					If Not lb_Atualizacao &
						Or ( lds_Datastore.GetItemNumber( 1, ls_Objeto ) <> Long(ls_Retorno) ) &
						Or ( IsNull( lds_Datastore.GetItemNumber( 1, ls_Objeto ) ) And Not IsNull( ls_Retorno ) ) &
						Or ( Not IsNull( lds_Datastore.GetItemNumber( 1, ls_Objeto ) ) And IsNull( ls_Retorno ) ) Then

						ll_Insert = lds_Datastore.SetItem( ll_Linha, ls_Objeto, Long(ls_Retorno) )
					End If
				End If
				
			Case "TIME"
	//			ll_Limit 		= 6
	//			ls_Retorno	= MidA( ps_Registro , ll_Inicio, ll_Limit )
	//			ll_Insert		= lds_Datastore.SetItem( ll_Linha, ls_Objeto, ivo_Comum.of_Time(ls_Retorno) )
				
			Case Else
				If Mid( ls_Tipo, 1, 4 ) = "CHAR" Then
					ll_Limit		=	Long( Mid( ls_Tipo, 6, LenA( ls_Tipo ) -6 )  )
					//Verifica$$HEX2$$e700e300$$ENDHEX$$o para se o campo for do tipo TEXT(identificacao_biometrica) altera o seu limite
					//Pois o FileWrite grava at$$HEX1$$e900$$ENDHEX$$ 32766 e esse tipo de campo usa todo o limite.
					If ll_Limit = 32766 Then
						ll_Limit = ivl_Limite_Campo_Text
					End If
					ls_Retorno 	=	Trim( MidA( ps_Registro , ll_Inicio, ll_Limit ) )
					
					If ls_Retorno = '' And lb_SetNull Then SetNull(ls_Retorno)

					/* Tempor$$HEX1$$e100$$ENDHEX$$rio, descobrir porque n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ importando cancelamento de transfer$$HEX1$$ea00$$ENDHEX$$ncia em alguns casos */
					ls_Campo_Email_Retrieve = lds_Datastore.GetItemString( 1, ls_Objeto )
					/********************/

					If Not lb_Chave Or Not lb_Atualizacao Then
					If Not lb_Atualizacao &
						Or ( lds_Datastore.GetItemString( 1, ls_Objeto ) <> Trim( ls_Retorno ) ) &
						Or ( IsNull( lds_Datastore.GetItemString( 1, ls_Objeto ) ) And Not IsNull( ls_Retorno ) ) &
						Or ( Not IsNull( lds_Datastore.GetItemString( 1, ls_Objeto ) ) And IsNull( ls_Retorno ) ) Then

							ll_Insert = lds_Datastore.SetItem( ll_Linha, ls_Objeto, Trim(ls_Retorno) )
						End If
					End If
				End If
				
				If Mid( ls_Tipo, 1, 7 ) = "DECIMAL" Or Mid( ls_Tipo, 1, 4 ) = "REAL" Then
					ll_Limit 		= ICI_DECIMAL
					ls_Retorno	= Trim(MidA( ps_Registro , ll_Inicio, ll_Limit ))
					
					If ls_Retorno = '' Then SetNull(ls_Retorno)
					
					/* Tempor$$HEX1$$e100$$ENDHEX$$rio, descobrir porque n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ importando cancelamento de transfer$$HEX1$$ea00$$ENDHEX$$ncia em alguns casos */
					ls_Campo_Email_Retrieve = String( lds_Datastore.GetItemDecimal( 1, ls_Objeto ) )
					/********************/

					If Not lb_Chave Or Not lb_Atualizacao Then
					If Not lb_Atualizacao &
						Or ( lds_Datastore.GetItemDecimal( 1, ls_Objeto ) <> Dec( ls_Retorno ) ) &
						Or ( IsNull( lds_Datastore.GetItemDecimal( 1, ls_Objeto ) ) And Not IsNull( ls_Retorno ) ) &
						Or ( Not IsNull( lds_Datastore.GetItemDecimal( 1, ls_Objeto ) ) And IsNull( ls_Retorno ) ) Then

							ll_Insert	= lds_Datastore.SetItem( ll_Linha, ls_Objeto, Dec( ls_Retorno ) )
						End If
					End If
				End If
		End Choose
		
		/* Tempor$$HEX1$$e100$$ENDHEX$$rio, descobrir porque n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ importando cancelamento de transfer$$HEX1$$ea00$$ENDHEX$$ncia em alguns casos */
		If IsNull( ls_Retorno ) Then
			ls_Texto_Email				+= ', ' + ls_Objeto + ' = NULL'
		Else
			ls_Texto_Email				+= ', ' + ls_Objeto + ' = ' + ls_Retorno
		End If
		
		If IsNull( ls_Campo_Email_Retrieve ) Then
			ls_Texto_Email_Retrieve += ', ' + ls_Objeto + ' = NULL'
		Else
			ls_Texto_Email_Retrieve += ', ' + ls_Objeto + ' = ' + ls_Campo_Email_Retrieve
		End If

		l_status = lds_Datastore.GetItemStatus( 1, ls_Objeto, Primary! )
		
		Choose Case l_Status
			Case NotModified!
				ls_Texto_Email += ' (NotModified!)'
				
			Case DataModified!
				ls_Texto_Email += ' (DataModified!)'
				
			Case New!
				ls_Texto_Email += ' (New!)'
				
			Case NewModified!
				ls_Texto_Email += ' (NewModified!)'
		End Choose
		
		If Upper( ps_Nm_Tabela ) = 'NF_TRANSFERENCIA' And Trim( ls_Objeto ) = 'dh_cancelamento' And Not IsNull( ls_Retorno ) Then
			lb_Envia_Email_Debug = True
		End If
		/*************/
		
		ll_Inicio += ll_Limit
		
		If ll_Insert = -1 Then
			This.of_Grava_Log( ivi_Log, ls_Chave_Log + "Erro ao inserir valor na coluna '" + ls_Objeto + "' da DataStore '" + ls_DataStore + "'.")
			lb_Sucesso = False
			Exit
		End If		
	Next
	
Else	
	If ll_Linha = 1 Then
		
		ls_Sql = lds_Datastore.Object.DataWindow.Table.Select
		
		If lds_Datastore.DeleteRow( ll_Linha ) < 0 Then
			This.of_Grava_Log( ivi_Log, "Erro ao excluir a linha da '" + ls_DataStore + "'.<br />" + ls_Sql )
			lb_Sucesso = False
		End If
	Else
		Destroy lds_Datastore
		Return lb_Sucesso
	End If
End If

/* Tratamentos especiais, como compara$$HEX2$$e700f500$$ENDHEX$$es de datas da filial com datas do Central */
If ls_Id_Atualizacao <> 'E' Then
	 /* V$$HEX1$$e100$$ENDHEX$$lido para Inclus$$HEX1$$e300$$ENDHEX$$o ou Altera$$HEX2$$e700e300$$ENDHEX$$o */
	Choose Case Upper( ps_Nm_Tabela )
			
		Case 'LOG_FECHAMENTO_DIARIO' /* Deleta os dados da saldo_produto_lote da filial para reimportar tudo */			
			ll_Filial =  lds_Datastore.Object.Cd_Filial[1]
			
			Delete
			  From saldo_produto_lote
			Where cd_filial = :ll_Filial
			  Using SqlCa;
			  
			If SqlCa.SqlCode = -1 Then
				This.of_Grava_Log( ivi_Log, ls_Chave_Log + lds_Datastore.ivo_dbError.of_Msg_Sybase() + ' :: Exclus$$HEX1$$e300$$ENDHEX$$o da saldo_produto_lote')
				lb_Atualiza = False
			End If
			/**********/
			
		Case 'LANCAMENTO_CAIXA' // Lan$$HEX1$$e700$$ENDHEX$$amento de Caixa **** Alterar modelo de dados do banco de filial para gravar DEFAULT 'N' ****
			String ls_Estorno
			ls_Estorno = lds_Datastore.Object.Id_Estorno[1]			
			If IsNull( ls_Estorno ) Or ls_Estorno = "" Then  lds_Datastore.Object.Id_Estorno[1] = 'N'
			
		Case	'NF_TRANSFERENCIA',&
				'ITEM_NF_TRANSFERENCIA' /* Se for inclus$$HEX1$$e300$$ENDHEX$$o, substitui a filial_destino de 534 por 1 */

			If Upper( ps_Nm_Tabela ) = 'NF_TRANSFERENCIA' Then
				If lds_Datastore.Object.Cd_Filial_Origem	[1] <> 534 Then
					This.of_Registra_Transferencia_Intranet( lds_Datastore )
				End If
			End If

			If Not lb_Atualizacao Then
				If lds_Datastore.Object.Cd_Filial_Destino	[1] = 534 Then
					lds_Datastore.Object.Cd_Filial_Destino[1] = 1
				End If
			Else // Atualiza$$HEX2$$e700e300$$ENDHEX$$o
				If lds_Datastore.Object.Cd_Filial_Destino	[1] = 534 Then
					If lds_Ds_Auxiliar.Object.Cd_Filial_Destino[1] = 1 Then
						lds_Datastore.Object.Cd_Filial_Destino[1] = 1
					End If					
				End If
				
				If Upper( ps_Nm_Tabela ) = 'NF_TRANSFERENCIA' Then // N$$HEX1$$e300$$ENDHEX$$o atualiza o campo para NULL para n$$HEX1$$e300$$ENDHEX$$o sobrescrever uma data j$$HEX1$$e100$$ENDHEX$$ preenchida
					If IsNull( lds_Datastore.Object.dh_recebimento[1] ) Then
						lds_Datastore.Modify("dh_recebimento.Update = No")
					End If
				End If //  Upper( ps_Nm_Tabela ) = 'NF_TRANSFERENCIA'
			End If	
			
		Case	'CONVENIADO', &
				'BLOQUEIO' /* Se existir o conveniado cadastrado, s$$HEX1$$f300$$ENDHEX$$ atualiza se a altera$$HEX2$$e700e300$$ENDHEX$$o mais recente foi feita na filial */
			
			If lb_Atualizacao Then
				
				Choose Case Upper( ps_Nm_Tabela )
					Case 'CONVENIADO' // conveniado
						ldh_Verificacao_1 = lds_Ds_Auxiliar.Object.Dh_Atualizacao	[1]
						ldh_Verificacao_2 = lds_Datastore.Object.Dh_Atualizacao	[1]
				
						If Not IsNull(  Date(ldh_Verificacao_1) ) And Date(ldh_Verificacao_1) > Date(ldh_Verificacao_2) Then
							lb_Atualiza = False
						End If
						
					Case 'BLOQUEIO' // bloqueio
						ldh_Verificacao_1 = lds_Ds_Auxiliar.Object.Dh_Atualizacao_Filial	[1]
						ldh_Verificacao_2 = lds_Datastore.Object.Dh_Atualizacao_Filial	[1]
				
						If Not IsNull(  Date(ldh_Verificacao_1) ) And Date(ldh_Verificacao_1) > Date(ldh_Verificacao_2) Then
							lb_Atualiza = False
						Else
							 lds_Datastore.Modify("dh_atualizacao_filial.Update = Yes")
							 lds_Datastore.Modify("cd_filial_atualizacao.Update = Yes")
						End If
						
				End Choose
				
			End If
			
		Case 'CONFIRMACAO_IMPORTACAO_FILIAL', 'SALDO_PRODUTO_LOTE' // confirmacao_importacao, saldo_produto_lote
			lds_Datastore.Modify("cd_filial.Update = Yes")
			
		Case 'MOVIMENTO_TITULO_RECEBER'
			lb_Atualiza = This.of_Central_Importa_Movto_Titulo_Receber( lds_Datastore, String( pl_Linha ) )
			
		Case 'CARTAO_COMPROVANTE_VENDA'
			lb_Atualiza = This.of_Central_Importa_Cartao_Comp_Venda( lds_Datastore, pl_Linha, ivi_Log )
			
		Case 'NF_COMPRA' // nf_compra
			If ls_Id_Atualizacao = 'A' And ll_Linha = 0 Then
				lb_Atualiza = False
			Else			
				// Data: 14/08/2012
				// S$$HEX1$$e900$$ENDHEX$$rgio: coloquei esta condi$$HEX2$$e700e300$$ENDHEX$$o pois esta fun$$HEX2$$e700e300$$ENDHEX$$o s$$HEX1$$f300$$ENDHEX$$ $$HEX1$$e900$$ENDHEX$$ utilizada
				// quando for uma atualiza$$HEX2$$e700e300$$ENDHEX$$o. 
				If lb_Atualizacao And Not lb_Compra_Pendente Then
					ldh_Verificacao_1 = lds_Ds_Auxiliar.Object.Dh_Movimentacao_Caixa	[1]
					ldh_Verificacao_2 = lds_Datastore.Object.Dh_Movimentacao_Caixa	[1]
					
					ldc_Antes 	= lds_Ds_Auxiliar.Object.vl_Total_NF	[1]
					ldc_Depois	= lds_Datastore.Object.vl_Total_NF	[1]
			
					If ldh_Verificacao_1 <> ldh_Verificacao_2 Or ldc_Antes<> ldc_Depois Then
						This.of_Grava_Log( ivi_Log, ls_Chave_Log + " Nota fiscal j$$HEX1$$e100$$ENDHEX$$ existe com dados divergentes. Verifique antes de atualizar." )
						lb_Atualiza = False
					End If
					
				End If // Fim atualiza$$HEX2$$e700e300$$ENDHEX$$o S$$HEX1$$e900$$ENDHEX$$rgio
				
				//Verfica$$HEX2$$e700e300$$ENDHEX$$o pra NF_compra pendente.
				If lb_Compra_Pendente Then
					If Not IsNull( lds_Datastore.Object.Nr_Pedido[1] ) And lds_Datastore.Object.Nr_Pedido[1] <> 0 Then
						 lds_Datastore.Modify("de_chave_acesso.Update = No")
					End If						
				Else
					If Not IsNull( lds_Datastore.Object.Nr_Pedido_Distribuidora[1] ) Then
						 lds_Datastore.Modify("de_chave_acesso.Update = No")
					End If
				End If
				
			End If  //If ls_Id_Atualizacao = 'A' And ll_Linha = 0 Then
			
		Case 'SALDO_PRODUTO'
			lb_Atualiza = This.of_Central_Importa_Saldo_Produto( lds_Datastore, String( pl_Linha ) )			
			
		Case 'PROMOCAO_SOS_ESTOQUE_MINIMO' //Exclui produto da promocao_sos_estoque_minimo no central, quando a quantidade vier 0(zero) ou menos.
			lb_Atualiza = This.of_Central_Importa_Promocao_sos_Produto( lds_Datastore, String( pl_Linha ) )
		
		Case 'NF_DIVERSA' // Inclui o codigo da filial complementar, essa informa$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ gravada na loja.
			String ls_Nf_Complementrar
			ls_Nf_Complementrar = String(lds_Datastore.Object.Nr_Nf_Complementar[1])
			If Not IsNull( ls_Nf_Complementrar ) And Trim( ls_Nf_Complementrar ) <> "" Then 
				lds_Datastore.Object.Cd_Filial_Complementar[1] = lds_Datastore.Object.Cd_Filial_Origem[1]
			Else
				lds_Datastore.Modify("cd_filial_complementar.Update = No")
			End If
			
		Case 'SORTEIO_NATAL' // quando vem da loja n$$HEX1$$e300$$ENDHEX$$o atualiza este campo.
			lds_Datastore.Modify("cd_filial.Update = No")
			
		Case 'CLIENTE_CHEQUE' //  O motivo de bloqueio n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ para atualizar quando vem da filial
			lds_Datastore.Modify("de_bloqueio.Update = No")
			
		Case 'VENDA_PBM_PRODUTO' //Essa atualiza$$HEX2$$e700e300$$ENDHEX$$o na loja era muito demorada, colocamos aqui.
			String ls_pbm, ls_pbm_retorno
			//ls_pbm = lds_Datastore.Object.id_pbm[1]  /* trecho comentado ref chamado 361740
			//If IsNull( ls_pbm ) Or Trim( ls_pbm ) = "" Then 			
			lb_Atualiza = This.of_Central_Atualiza_Produto_PBM( lds_Datastore, 1, Ref ls_pbm_retorno )				
			If lb_Atualiza Then
				lds_Datastore.Object.id_pbm[1] = ls_pbm_retorno
			End If				
			//End If
			
		Case 'PEDIDO_ALMOXARIFADO_PRODUTO'
			lb_Atualiza = This.of_Central_Verifica_Pedido_Almoxarifado( lds_Datastore, pl_Linha, ivi_Log )			
			
	End Choose	
End If

If IsValid( lds_Ds_Auxiliar ) Then
	Destroy lds_Ds_Auxiliar
End IF

If Not lb_Atualiza Then
	Destroy lds_Datastore
	Return lb_Sucesso
End If
/* Fim dos tratamentos especiais */

If Upper( ps_Nm_Tabela ) <> 'MOVIMENTO_TITULO_RECEBER' And &
   Upper( ps_Nm_Tabela ) <> 'CARTAO_COMPROVANTE_VENDA' And &
   Upper( ps_Nm_Tabela ) <> 'PROMOCAO_SOS_ESTOQUE_MINIMO' And &
   Upper( ps_Nm_Tabela ) <> 'SALDO_PRODUTO'  Then
	If lds_Datastore.Update() = -1 Then
		
		If Upper( ps_Nm_Tabela ) <> 'LOCAL_ESTOCAGEM_FILIAL' And Upper( ps_Nm_Tabela ) <> 'LOCAL_ESTOCAGEM' Then // Para n$$HEX1$$e300$$ENDHEX$$o gravar erro
			This.of_Grava_Log( ivi_Log, ls_Chave_Log + lds_Datastore.ivo_dbError.of_Msg_Sybase() )
		End If
		//Return False
	End If
	
	/* Tempor$$HEX1$$e100$$ENDHEX$$rio, descobrir porque n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ importando cancelamento de transfer$$HEX1$$ea00$$ENDHEX$$ncia em alguns casos */
	If lb_Envia_Email_Debug Then
		ls_Texto_Email_Retrieve += '<br /><br />dh_cancelamento.Update = ' + lds_Datastore.Describe("dh_cancelamento.Update")
		ls_Texto_Email_Retrieve += '<br />nr_matricula_cancelamento.Update = ' + lds_Datastore.Describe("nr_matricula_cancelamento.Update")
		
		ls_Texto_Email_Retrieve += '<br />Novo valor: dh_cancelamento = ' + String( lds_Datastore.Object.dh_cancelamento[ 1 ] )
		ls_Texto_Email_Retrieve += '<br />Novo valor: nr_matricula_cancelamento = ' + String( lds_Datastore.Object.nr_matricula_cancelamento[ 1 ] )
		
//		gf_ge202_envia_email_automatico( 93, '', ls_Texto_Email + '<br /><br />Dados do Retrieve: ' + ls_Texto_Email_Retrieve + '<br /><br />SqlNRows: ' + String( SqlCa.SqlNRows ) )
	End If
	/***********/
End If

SqlCa.of_Commit()

Destroy lds_Datastore

GarbageCollect( )
Yield( )

Return lb_Sucesso
end function

public function boolean of_central_atualiza_ultimo_arquivo_imp (long pl_filial);Update controle_importacao
      Set nr_arquivo = nr_arquivo+1
 Where cd_filial 	 = :pl_filial
   Using SqlCa;
	
Choose Case SqlCa.SqlCode
	Case -1
		SqlCa.of_MsgDbError()
		Return False
		
End Choose

Return True
end function

public function boolean of_campo_chave (string ps_tabela, string ps_campo, ref boolean pb_chave);Long ll_Rows
Long ll_Idx_Tabela
Long ll_Find

pb_chave = False

If ivds_PK.RowCount() > 0 Then
	ll_Find = ivds_PK.Find("trim(nm_coluna) = '" + ps_Campo + "'", 1, ivds_PK.RowCount())
	
	If ll_Find = -1 Then
		This.of_Grava_Log( ivi_Log, "Erro ao realizar o find da chave prim$$HEX1$$e100$$ENDHEX$$ria, tabela: " + ps_Tabela + "." )
		Destroy ivds_PK
		Return False
	ElseIf ll_Find > 0 Then
		pb_chave = True
	End If
End If
	
Return True
end function

public function boolean of_appendselect (ref dc_uo_ds_base pds_datastore, string ps_campo);String lvs_SQL

Long lvl_Posicao

lvs_SQL = pds_DataStore.Object.DataWindow.Table.Select

lvl_Posicao = PosA(Upper(lvs_SQL), "FROM", 1)

lvs_SQL = MidA(lvs_SQL, 1, lvl_Posicao -1) + ", " + ps_Campo + " " + &
          MidA(lvs_SQL, lvl_Posicao)

String lvs_Dw_Syntaxe, &
		 lvs_ERRO

lvs_Dw_Syntaxe   = SqlCa.SyntaxFromSQL(lvs_SQL, "", lvs_ERRO)

If LenA(lvs_ERRO) > 0 Then
	This.of_Grava_Log( ivi_Log, "SyntaxFromSQL causou um erro : " + lvs_ERRO + " of_AppendSelect() 1 " )
	Return False
End If

pds_datastore = Create dc_uo_ds_base
If pds_datastore.Create(lvs_Dw_Syntaxe, lvs_ERRO) = -1 Then
	This.of_Grava_Log( ivi_Log, "Ocorreram erros ao criar o objeto 'DataStore'. of_AppendSelect() 2" )
	Return False
End If

pds_datastore.SetTransObject(SqlCa)

Return True
end function

public function boolean of_loja_grava_reg_exclusao_sld_prd_lote (string ps_tabela, string ps_cd_tabela, string ps_chave);String ls_Registro

ls_Registro = ivo_Comum.of_String( This.of_Coluna_Chave( ps_Chave, 1 ), 10 ) + &
				  ivo_Comum.of_String( This.of_Coluna_Chave( ps_Chave, 2 ), 10 ) + &
				  ivo_Comum.of_String( This.of_Coluna_Chave( ps_Chave, 3 ), 10 )
			

If Not This.of_Grava_Arquivo( 'E' + ps_Cd_Tabela + ls_Registro ) Then Return False		

Return True
end function

public subroutine of_envia_email_erro (string ps_erro, string ps_nome_funcao, long pl_linha);//Envia email com erro ocorrido.
String ls_Argumentos
String ls_Erro

//gvo_Troca.of_Parametro_Filial()

ls_Erro = "Fun$$HEX2$$e700e300$$ENDHEX$$o: " + ps_Nome_Funcao + " - Linha: " + String( pl_Linha ) + "~r~r" + ps_Erro
//
//ls_argumentos = "filial=" + String(gvo_Troca.ivl_filial_parametro) +  "&erro=" + ls_Erro
//
//uo_transacao_remota lo_SD
//lo_SD = Create uo_transacao_remota
//lo_SD.of_executa_rotina_intranet('erro_exportacao_tl', ls_argumentos)
//Destroy lo_SD

gf_ge202_envia_email_log( 93, &
									'LOG - Troca dados. Filial: ' + String(gvo_Troca.ivl_filial_parametro) , &
									"<font color='red' size='4'>ATEN$$HEX2$$c700c300$$ENDHEX$$O</font><br /><br />" + &
									ls_Erro + ".<br />" )
end subroutine

public function boolean of_loja_exporta_tudo ();Boolean lb_Sucesso

Long ll_Registros_Log

Open(w_Aguarde)
w_Aguarde.Title = "Atualizando log de exporta$$HEX2$$e700e300$$ENDHEX$$o..."

lb_Sucesso =  This.of_Loja_Atualiza_Log( 'P', ref ll_Registros_Log )
 
If Not lb_Sucesso Then
	Return False
End If	
	
Close(w_Aguarde)

Return This.of_loja_Exporta()
end function

public function boolean of_loja_exporta ();dc_uo_ds_base	lds_Log

Boolean lb_Sucesso = True
Boolean lb_Exporta_Completas = False

Long ll_Linha
Long ll_Linhas
Long ll_Registros_Log = 0
Long ll_Achou = 0
Long ll_Sequencial

String ls_Tabela
String ls_Atualizacao
String ls_Chave_Log
String ls_Sql

ivl_Sequencial = 1

If Not This.of_Carrega_Tabelas_Loja() Then Return False

If Not This.of_Carrega_Tabela_Json( 'relacao_tabelas_tl' ) Then Return False

If Not This.of_Loja_Nome_Arquivo() Then
	Return False
End If

If Not This.of_Abre_Arquivo() Then
	Return False
End If

Open(w_Aguarde)

w_Aguarde.Title = "Recuperando informa$$HEX2$$e700f500$$ENDHEX$$es do log de exporta$$HEX2$$e700e300$$ENDHEX$$o..."

lds_Log = Create dc_uo_ds_base
lb_Sucesso = lds_Log.of_ChangeDataObject( 'ds_ge212_log_exportacao_loja' )

If lb_Sucesso Then
	ll_Linhas = lds_Log.Retrieve( )
	
	If ll_Linhas < 0 Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Ocorreram erros ao tentar recuperar as informa$$HEX2$$e700f500$$ENDHEX$$es da 'ds_ge212_log_exportacao_loja'.", StopSign!)
		//Envia email com erro ocorrido.
		of_Envia_Email_Erro(	"Ocorreram erros ao tentar recuperar as informa$$HEX2$$e700f500$$ENDHEX$$es da 'ds_ge212_log_exportacao_loja'.", &
									"of_loja_exporta()", 41 )
		lb_Sucesso = False
	End If
End If

If lb_Sucesso Then
	lb_Sucesso =  Not ll_Linhas = 0
End If
	
If lb_Sucesso Then
	
	w_Aguarde.uo_Progress.of_SetMax( ll_Linhas )
	
	For ll_Linha = 1 To ll_Linhas
		w_Aguarde.Title = "Exportando registro " + String(ll_Linha) + " de " + String(ll_Linhas) + " tabela " + ls_Tabela
		
		If Not lb_Sucesso Then Exit
		
		ll_Sequencial	= lds_Log.Object.Nr_Atualizacao	[ll_Linha]
		ls_Tabela		= lds_Log.Object.Nm_Tabela		[ll_Linha]
		ls_Chave_Log	= lds_Log.Object.De_Chave			[ll_Linha]
		ls_Atualizacao	= lds_Log.Object.Id_Atualizacao	[ll_Linha]
		If IsNull(ls_Atualizacao) Then ls_Atualizacao = 'I'
		
		Choose Case ls_Tabela
			Case	'CHEQUE', &
					'SALDO_PRODUTO', &
					'SISTEMA', &
					'SISTEMA_PDV'
					
				SELECT count(*)
					INTO :ll_Achou
				  FROM log_exportacao
				WHERE nr_atualizacao > :ll_Sequencial
					AND id_processado = 'P'
					 AND nm_tabela = :ls_Tabela
					 AND de_chave  = :ls_Chave_Log
				 USING SqlCa;
				 
				Choose Case SqlCa.SqlCode
					Case -1
						of_Envia_Email_Erro(	SqlCa.SqlErrText + "~rTabela: " + ls_Tabela + " - Chave: " + ls_Chave_Log, 'of_loja_exporta()', 90 )
						
					Case 0
						If Not IsNull( ll_Achou ) And ll_Achou > 0 Then
							Continue
						End If
				End Choose
				
			Case 'LOG_FECHAMENTO_DIARIO'
				lb_Exporta_Completas = True
				
			Case 'CARTAO_COMPROVANTE_VENDA'
				ls_Tabela = ls_Tabela
				
		End Choose
	
		This.of_Get_Sql_Banco( ls_Tabela )
			
		ls_Tabela = Lower(lds_Log.Object.Nm_Tabela[ll_Linha])
		
		If Not IsNull( This.is_Sql_Banco ) And Pos( Upper( is_Sql_Banco ), 'SELECT' ) > 0 Then
			lb_Sucesso = This.of_Exporta_Json( ls_Tabela, ls_Chave_Log, ls_Atualizacao )
		Else
			lb_Sucesso = This.of_Loja_Grava_Registro( ls_Tabela, ls_Chave_Log, ls_Atualizacao )
		End If
				
		w_Aguarde.uo_Progress.of_SetProgress( ll_Linha )
		
		GarbageCollect( )
		Yield( )
	Next
End If

// Exporta$$HEX2$$e700e300$$ENDHEX$$o das tabelas completas, que n$$HEX1$$e300$$ENDHEX$$o passam pelo log_exportacao
If lb_Sucesso  And lb_Exporta_Completas Then
	lb_Sucesso = lds_Log.of_ChangeDataObject( 'ds_ge212_log_exportacao_loja_sem_trigger' )
	
	ll_Linhas = lds_Log.Retrieve()
	
	If ll_Linhas < 0 Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Ocorreram erros ao tentar recuperar as informa$$HEX2$$e700f500$$ENDHEX$$es da 'ds_ge212_log_exportacao_loja_sem_trigger'.", StopSign!)
		
		//Envia email com erro ocorrido.
		of_Envia_Email_Erro(	"Ocorreram erros ao tentar recuperar as informa$$HEX2$$e700f500$$ENDHEX$$es da 'ds_ge212_log_exportacao_loja_sem_trigger'.", &
									"of_loja_exporta()", 119 )
		lb_Sucesso = False
	End If
	
	w_Aguarde.uo_Progress.of_SetMax( ll_Linhas )
	
	For ll_Linha = 1 To ll_Linhas
		w_Aguarde.Title = "Exportando registro " + String(ll_Linha) + " de " + String(ll_Linhas) + " tabela " + ls_Tabela
		
		If Not lb_Sucesso Then
			Exit
		End If
	
		ll_Sequencial	= lds_Log.Object.Nr_Atualizacao	[ll_Linha]
		ls_Tabela		= lds_Log.Object.Nm_Tabela		[ll_Linha]
		ls_Chave_Log	= lds_Log.Object.De_Chave			[ll_Linha]
		ls_Atualizacao	= lds_Log.Object.Id_Atualizacao	[ll_Linha]
		If IsNull(ls_Atualizacao) Then ls_Atualizacao = 'I'
		
		ls_Tabela   = Lower(lds_Log.Object.Nm_Tabela[ll_Linha])
			
		lb_Sucesso = This.of_Loja_Grava_Registro( ls_Tabela, ls_Chave_Log, ls_Atualizacao )
		
		w_Aguarde.uo_Progress.of_SetProgress( ll_Linha )
		
		GarbageCollect( )
		Yield( )
	Next
	
	If lb_Sucesso Then
		Update produto_procurado_zerado
			Set id_exportado = 'S'
		Where id_exportado = 'P'
			Using SqlCa;
			
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_RollBack();
			SqlCa.of_LogDbError(gvo_Aplicacao.ivi_Log, "Atualiza$$HEX2$$e700e300$$ENDHEX$$o de procura de produtos por clientes.")
		Else
			SqlCa.of_Commit();
		End If
	End If
End If
// FIM - Exporta$$HEX2$$e700e300$$ENDHEX$$o das tabelas completas, que n$$HEX1$$e300$$ENDHEX$$o passam pelo log_exportacao

If lb_Sucesso Then	
	lb_Sucesso = This.of_Fecha_Arquivo()
Else
	FileClose( ivi_Arquivo )
	FileDelete( ivs_Caminho_Arquivo + ivs_Arquivo )
End If

If lb_Sucesso Then
	lb_Sucesso =  This.of_Loja_Atualiza_Log( 'S', ref ll_Registros_Log )
End If

If lb_Sucesso Then
	lb_Sucesso = This.of_Atualiza_Sequencial()
End If

If lb_Sucesso Then
	SqlCa.of_Commit()
Else
	FileDelete( ivs_Arquivo )
	SqlCa.of_RollBack()
End If

If IsValid( w_Aguarde ) Then
	Close( w_Aguarde )
End If

Destroy lds_Log

Return lb_Sucesso
end function

public function boolean of_loja_exporta_selecionadas (dc_uo_dw_base pds_tabelas);Boolean lb_Sucesso

Long	ll_Linha, &
		ll_Linhas
		
String ls_Tabela

Open(w_Aguarde)
w_Aguarde.Title = "Atualizando log de exporta$$HEX2$$e700e300$$ENDHEX$$o..."

ll_Linhas = pds_Tabelas.RowCount()

For ll_Linha = 1 To ll_Linhas
	
	ls_Tabela = Upper( pds_Tabelas.Object.Nm_Tabela[ ll_Linha ] )

	Update log_exportacao
		  Set id_processado  = 'P'
	 Where id_processado = 'N'
	 	 And nm_tabela = :ls_Tabela
	 Using SqlCa;
	 
	Choose Case SqlCa.SqlCode
		Case -1
			SqlCa.of_MsgDbError()
			SqlCa.of_RollBack()
			Close( w_Aguarde )
			Return False
	End Choose	
	
Next
	
Close(w_Aguarde)

Return This.of_loja_Exporta()
end function

public function boolean of_loja_exporta_selecionadas (dc_uo_ds_base pds_tabelas);Boolean lb_Sucesso

Long	ll_Linha, &
		ll_Linhas
		
String ls_Tabela

Open(w_Aguarde)
w_Aguarde.Title = "Atualizando log de exporta$$HEX2$$e700e300$$ENDHEX$$o..."

ll_Linhas = pds_Tabelas.RowCount()

For ll_Linha = 1 To ll_Linhas
	
	ls_Tabela = Upper( pds_Tabelas.Object.Nm_Tabela[ ll_Linha ] )

	Update log_exportacao
		  Set id_processado  = 'P'
	 Where id_processado = 'N'
	 	 And nm_tabela = :ls_Tabela
	 Using SqlCa;
	 
	Choose Case SqlCa.SqlCode
		Case -1
			SqlCa.of_MsgDbError()
			SqlCa.of_RollBack()
			Close( w_Aguarde )
			Return False
	End Choose	
	
Next
	
Close(w_Aguarde)

Return This.of_loja_Exporta()
end function

public function boolean of_central_existe_item_nota (dc_uo_ds_base pds_datastore, string ps_tabela, string ps_chave_log);Long ll_Find
Long ll_Filial
Long ll_Nf

String ls_Especie
String ls_Serie

ll_Filial		= pds_DataStore.Object.Cd_Filial		[1]
ll_Nf			= pds_DataStore.Object.Nr_Nf			[1]
ls_Especie	= pds_DataStore.Object.De_Especie	[1]
ls_Serie		= pds_DataStore.Object.De_Serie		[1]

Choose Case ps_Tabela
	Case 'NF_DEVOLUCAO_VENDA'
		Select coalesce( count(*), 0 )
		  Into :ll_Find
		 From item_nf_devolucao_venda
		Where cd_filial		= :ll_Filial
		  And nr_nf 			= :ll_Nf
		  And de_especie 	= :ls_Especie
		  And de_serie 		= :ls_Serie
		 Using SqlCa;
		 
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_LogDbError( ivi_Log, ps_Chave_Log )
			Return False
		Else
			If ll_Find = 0 Then
				Return False
			End If
		 End If
End Choose

Return True
end function

public function boolean of_central_importa_cartao_comp_venda (dc_uo_ds_base pds_datastore, long pl_linha, integer pi_log);Boolean lvb_Sucesso = True

Long	lvl_Max, &
     	lvl_Linha, &
		lvl_Filial, &
		lvl_Administradora, &
		lvl_NF, &
		lvl_Controle_Caixa, &
		lvl_Comprovante_Caixa, &
		lvl_Total_Geral, &
		lvl_Total_Situacao, &
		lvl_Achou, &
		lvl_sequencial

String lvs_Arquivo_Dados, &
       lvs_Arquivo_LOG, &
		 lvs_Chave_Log, &
		 lvs_Produto, &
		 lvs_Estabelecimento, &
		 lvs_Cartao, &
		 lvs_Autorizacao, &
		 lvs_NSU, &
		 lvs_Tipo_Venda, &
		 lvs_Especie, &
		 lvs_Serie, &
		 lvs_Deposito, &
		 lvs_Captura, &
		 lvs_Cancelamento, &
		 lvs_Situacao, &
		 lvs_Caixa, &
		 lvs_Parcelamento, &
		 lvs_Recebido, &
		 lvs_Temporario, &
		 lvs_Filial
		 
DateTime lvdh_Venda, &
			 lvdh_Predatado

Date lvdt_Deposito[], &
	  lvdt_Credito[], &
	  lvdt_Ultimo_Dia

Decimal	lvdc_Valor_Total, &
			lvdc_Valor_Parcela[], &
			lvdc_Taxa_Credito, &
			lvdc_Taxa_Debito, &
			lvdc_Comissao, &
			lvdc_Parcela, &
			lvdc_Total

Integer lvi_Qtde_Parcelas, &
		  lvi_Qtde_Parcelas_Gravacao, &
		  lvi_Parcela, &
		  lvi_Dia, &
		  lvi_Mes, &
		  lvi_Ano

lvs_Estabelecimento   = pds_DataStore.Object.Cd_Estabelecimento[1]

// Tempor$$HEX1$$e100$$ENDHEX$$rio - S$$HEX1$$e900$$ENDHEX$$rgio (Para resolver problema da Brasil Telecom)
If lvs_Estabelecimento = 'SU      :' Then 
	SetNull(lvs_Estabelecimento)
End IF

lvs_Produto           		= pds_DataStore.Object.Nm_Produto			[1]
lvs_Cartao            		= pds_DataStore.Object.Nr_Cartao			[1]
lvs_Autorizacao				= pds_DataStore.Object.Nr_Autorizacao		[1]
lvs_NSU						= pds_DataStore.Object.Nr_NSU				[1]
lvdh_Venda					= pds_DataStore.Object.Dh_Venda			[1]
lvdc_Valor_Total			= pds_DataStore.Object.Vl_Venda				[1]
lvi_Qtde_Parcelas			= pds_DataStore.Object.Qt_Parcelas			[1]		
//lvl_Filial						= pds_DataStore.Object.Cd_Filial				[1]
lvl_Filial						= ivl_Filial_Importacao
lvl_NF							= pds_DataStore.Object.Nr_NF					[1]
lvs_Especie					= pds_DataStore.Object.De_Especie			[1]
lvs_Serie						= pds_DataStore.Object.De_Serie				[1]
lvs_Captura					= pds_DataStore.Object.Id_Captura			[1]
lvs_Cancelamento			= pds_DataStore.Object.Id_Cancelamento	[1]
lvs_Caixa						= pds_DataStore.Object.Cd_Caixa				[1]
lvl_Controle_Caixa			= pds_DataStore.Object.Nr_Controle_Caixa	[1]
lvl_Sequencial				= pds_DataStore.Object.Nr_sequencial		[1]
lvl_Comprovante_Caixa	= pds_DataStore.Object.Nr_Lancamento_Caixa	[1]
lvs_Parcelamento      		= pds_DataStore.Object.Id_Parcelamento	[1]
lvdh_Predatado				= pds_DataStore.Object.Dh_Predatado		[1]

lvb_Sucesso = True
	
If IsNull(lvs_Parcelamento) Then lvs_Parcelamento = "E"

If lvs_Parcelamento = "A" Then lvi_Qtde_Parcelas = 1

If lvi_Qtde_Parcelas = 0 Then lvi_Qtde_Parcelas = 1

lvi_Qtde_Parcelas_Gravacao = lvi_Qtde_Parcelas

If lvs_Cancelamento = "S" Then
	lvs_Situacao = "X"
Else
	lvs_Situacao = "A"
End If

//Comentado devido problemas integra$$HEX2$$e700e300$$ENDHEX$$o com o CAR - Admocir 14/04/2020.
//If lvs_Captura = "M" Then
//	lvi_Qtde_Parcelas = 1
//	
//	If lvs_Situacao = "A" Then lvs_Situacao = "T"
//End If

lvs_Autorizacao	= RightA("000000"				+ lvs_Autorizacao, 6)
lvs_NSU			= RightA("000000000000"	+ lvs_NSU, 12)

lvs_Chave_Log = "Linha " + String(pl_Linha, "00000") + " - Produto '" + lvs_Produto + "' - "

/* C$$HEX1$$f300$$ENDHEX$$digo que estava na fun$$HEX2$$e700e300$$ENDHEX$$o of_Valida_Cartao_Comprovante_Venda */
If Not IsNull(lvs_Caixa) Then
	// Verifica se os comprovantes j$$HEX1$$e100$$ENDHEX$$ haviam sido importados
	Select count(*) 
	   Into :lvl_Total_Geral
	 From cartao_comprovante_operacao
    Where cd_caixa						= :lvs_Caixa
	   and nr_controle_caixa			= :lvl_Controle_Caixa
	   and nr_comprovante_caixa	= :lvl_Comprovante_Caixa
	 Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Verifica$$HEX2$$e700e300$$ENDHEX$$o da Exist$$HEX1$$ea00$$ENDHEX$$ncia dos Comprovantes")
		Return False
	End If
	
	If IsNull(lvl_Total_Geral) Then lvl_Total_Geral = 0
	
	If lvl_Total_Geral <> 0 Then
	
		// Se existirem comprovantes, verifica se algum deles foi conciliado
		If lvs_Captura = "T" Then
			lvs_Situacao = "A" // Aberto
		Else
			lvs_Situacao = "T" // Tesouraria - Manual n$$HEX1$$e300$$ENDHEX$$o Depositado
		End If
	
		Select count(1) 
		   Into :lvl_Total_Situacao
	      From cartao_comprovante_operacao
	    Where cd_caixa						= :lvs_Caixa
		    and nr_controle_caixa			= :lvl_Controle_Caixa
		    and nr_comprovante_caixa	= :lvl_Comprovante_Caixa
		    and id_situacao <> :lvs_Situacao
		  Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Verifica$$HEX2$$e700e300$$ENDHEX$$o da Situa$$HEX2$$e700e300$$ENDHEX$$o dos Comprovantes Existentes")
			Return False
		End If	
	
		If IsNull(lvl_Total_Situacao) Then lvl_Total_Situacao = 0
		
		If lvl_Total_Situacao > 0 Then
			//SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Existem Comprovantes Conciliados")
			Return True
		End If
		
		// Se nenhum dos comprovantes existente foi conciliado, exclui todos
		Delete 
		 From cartao_comprovante_operacao
	    Where cd_caixa						= :lvs_Caixa
		    and nr_controle_caixa			= :lvl_Controle_Caixa
		    and nr_comprovante_caixa	= :lvl_Comprovante_Caixa
		  Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Exclus$$HEX1$$e300$$ENDHEX$$o dos Comprovantes Existentes")
			Return False
		End If
		
		If SqlCa.SqlnRows <> lvl_Total_Geral Then
			SqlCa.of_RollBack()
			SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Exclus$$HEX1$$e300$$ENDHEX$$o dos Comprovantes Existentes")
			Return False	
		End If
	End If	
	/* Fim do C$$HEX1$$f300$$ENDHEX$$digo que estava na fun$$HEX2$$e700e300$$ENDHEX$$o of_Valida_Cartao_Comprovante_Venda */
	
	/* In$$HEX1$$ed00$$ENDHEX$$cio do C$$HEX1$$f300$$ENDHEX$$digo que estava na fun$$HEX2$$e700e300$$ENDHEX$$o of_Cartao_Produto */
	Select	  cd_administradora,
			  id_credito_debito
		Into :lvl_Administradora,
			  :lvs_Tipo_Venda
	   From cartao_produto
	 Where nm_produto = :lvs_Produto
	   Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			//lvb_Sucesso = True
		Case 100
			SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Produto '" + lvs_Produto + "' n$$HEX1$$e300$$ENDHEX$$o Localizado")
			Return False
		Case -1
			SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Localiza$$HEX2$$e700e300$$ENDHEX$$o do Produto '" + lvs_Produto + "'")
			Return False
	End Choose
	/* Fim do C$$HEX1$$f300$$ENDHEX$$digo que estava na fun$$HEX2$$e700e300$$ENDHEX$$o of_Cartao_Produto */
	
//	If lvl_Administradora = 2 Then // Vannon
//		lvs_Recebido = lvs_Estabelecimento
//		
//		Select cd_filial,
//				 pc_comissao_venda_credito,
//				 pc_comissao_venda_debito,
//				 cd_estabelecimento_temporario
//		Into :lvl_Filial,
//			  :lvdc_Taxa_Credito, 
//			  :lvdc_Taxa_Debito,
//			  :lvs_Temporario
//		From cartao_estabelecimento
//		Where cd_administradora = :lvl_Administradora
//		  and cd_estabelecimento = :lvs_Estabelecimento
//		  and id_situacao       = 'A'
//		Using SqlCa;
//	Else
		/* In$$HEX1$$ed00$$ENDHEX$$cio do C$$HEX1$$f300$$ENDHEX$$digo que estava na fun$$HEX2$$e700e300$$ENDHEX$$o of_Cartao_Estabelecimento */
		If lvl_Administradora <> 1 Then SetNull(lvs_Estabelecimento)
	
		lvs_Recebido = lvs_Estabelecimento
		
		Select cd_estabelecimento,
				 pc_comissao_venda_credito,
				 pc_comissao_venda_debito,
				 cd_estabelecimento_temporario
		Into :lvs_Estabelecimento,
			  :lvdc_Taxa_Credito, 
			  :lvdc_Taxa_Debito,
			  :lvs_Temporario
		From cartao_estabelecimento
		Where cd_administradora = :lvl_Administradora
		  and cd_filial         = :lvl_Filial
		  and id_situacao       = 'A'
		Using SqlCa;
//	End If
	
	Choose Case SqlCa.SqlCode
		Case 0
			If IsNull(lvs_Temporario) Then lvs_Temporario = ""
			
			If Not IsNull(lvs_Recebido) Then
				If lvs_Estabelecimento <> lvs_Recebido Then
					// Somente para tratar a transi$$HEX2$$e700e300$$ENDHEX$$o de mudan$$HEX1$$e700$$ENDHEX$$a de estabelecimentos
					If lvs_Recebido = lvs_Temporario Then				
						lvs_Estabelecimento = lvs_Recebido 
					Else
						SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Estabelecimento recebido '" + lvs_Recebido + "' " + &
															 "diferente do cadastrado para filial '" + lvs_Estabelecimento + "'.")
						Return False
					End If
				End If
			End If
			
		Case 100	
			If lvl_Administradora <> 1 Then
				lvs_Filial = String(lvl_Filial)
				
				Insert Into cartao_estabelecimento (cd_administradora,   
																cd_estabelecimento,   
																id_situacao,   
																cd_filial,   
																cd_banco,   
																nr_agencia,   
																nr_conta,   
																pc_comissao_venda_credito,   
																pc_comissao_venda_debito,   
																cd_conta_venda_credito,   
																cd_conta_venda_debito,   
																cd_conta_banco,   
																cd_conta_comissao,   
																cd_conta_rejeicao,   
																cd_conta_ajuste_debito,   
																cd_conta_ajuste_credito,   
																cd_conta_aluguel_pos)  
				Values (:lvl_Administradora,
						  :lvs_Filial,
						  'A',
						  :lvl_Filial,
						  '237',
						  '358',
						  '1665405',
						  1, 1,
						  '1', '2', '3', '4', '5', '6', '7', '8')
				Using SqlCa;
				
				If SqlCa.SqlCode = -1 Then
					SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Inclus$$HEX1$$e300$$ENDHEX$$o do Estabelecimento")
					Return False
				End If
					
			Else			
				SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Estabelecimento n$$HEX1$$e300$$ENDHEX$$o Localizado")
				Return False
			End If
			
		Case -1
			SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Localiza$$HEX2$$e700e300$$ENDHEX$$o do Estabelecimento")
			Return False
	End Choose
	/* Fim do C$$HEX1$$f300$$ENDHEX$$digo que estava na fun$$HEX2$$e700e300$$ENDHEX$$o of_Cartao_Estabelecimento */
													 
	If lvl_Administradora <> 1 and IsNull(lvs_Cartao) Then
		lvs_Cartao = "1"
	End If
			
	//Para resolver o problema de Codigo de Estabelecimento Nulo nas transa$$HEX2$$e700f500$$ENDHEX$$es de Recarga.
	If IsNull(lvs_Estabelecimento) Then lvs_Estabelecimento = String(lvl_filial)
									
	lvs_Tipo_Venda = "V" + lvs_Tipo_Venda
								
	If lvi_Qtde_Parcelas = 1 Then
		lvdc_Valor_Parcela[1] = lvdc_Valor_Total
	Else
		/* In$$HEX1$$ed00$$ENDHEX$$cio do C$$HEX1$$f300$$ENDHEX$$digo que estava na fun$$HEX2$$e700e300$$ENDHEX$$o of_Parcela_Venda_Cartao */
		lvdc_Parcela = Truncate(lvdc_Valor_Total / lvi_Qtde_Parcelas, 2)

		For lvi_Parcela = lvi_Qtde_Parcelas To 1 Step -1
			If lvi_Parcela = 1 Then
				lvdc_Valor_Parcela[lvi_Parcela] = lvdc_Valor_Total - lvdc_Total
			Else
				lvdc_Valor_Parcela[lvi_Parcela] = lvdc_Parcela
				lvdc_Total += lvdc_Parcela
			End If
		Next
		/* Fim do C$$HEX1$$f300$$ENDHEX$$digo que estava na fun$$HEX2$$e700e300$$ENDHEX$$o of_Parcela_Venda_Cartao */
	End If
	
	/* In$$HEX1$$ed00$$ENDHEX$$cio do C$$HEX1$$f300$$ENDHEX$$digo que estava na fun$$HEX2$$e700e300$$ENDHEX$$o of_Data_Venda_Cartao */
	dc_uo_Data lvo_Data
	lvo_Data = Create dc_uo_Data
	
	lvdt_Deposito[1] = Date(lvdh_Venda)
	
	If lvs_Tipo_Venda = "VD" Then
		lvdt_Credito[1] = RelativeDate(Date(lvdh_Venda), 2)
	Else
		lvdt_Credito[1] = RelativeDate(Date(lvdh_Venda), 30)
	End If
	
	lvi_Dia 	= Day  (Date(lvdh_Venda))
	lvi_Mes 	= Month(Date(lvdh_Venda))
	lvi_Ano 	= Year (Date(lvdh_Venda))
	
	For lvi_Parcela = 2 To lvi_Qtde_Parcelas
		If lvi_Mes = 12 Then
			lvi_Mes = 1
			lvi_Ano ++
		Else
			lvi_Mes ++
		End If
	
		lvdt_Ultimo_Dia = lvo_Data.of_Ultimo_Dia_Mes(lvi_Mes, lvi_Ano)
		
		If Day(lvdt_Ultimo_Dia) > lvi_Dia Then
			lvdt_Deposito[lvi_Parcela] = Date(String(lvi_Dia) + "/" + String(lvdt_Ultimo_Dia, "mm/yyyy"))
		Else
			lvdt_Deposito[lvi_Parcela] = lvdt_Ultimo_Dia
		End If
		
		If lvs_Tipo_Venda = "VD" Then
			lvdt_Credito[lvi_Parcela] = RelativeDate(lvdt_Deposito[lvi_Parcela], 2)
		Else
			lvdt_Credito[lvi_Parcela] = RelativeDate(lvdt_Deposito[lvi_Parcela], 30)
		End If
	Next
	
	Destroy(lvo_Data)
   /* Fim do C$$HEX1$$f300$$ENDHEX$$digo que estava na fun$$HEX2$$e700e300$$ENDHEX$$o of_Data_Venda_Cartao */
			
			
	//Para resolver problemas com Banrisul que trata o d$$HEX1$$e900$$ENDHEX$$bito como Cr$$HEX1$$e900$$ENDHEX$$dito (D$$HEX1$$e900$$ENDHEX$$bito Pr$$HEX1$$e900$$ENDHEX$$datado e parcelado) - Lucian 31/01/2011
	If (Not IsNull(lvdh_Predatado) And lvdh_Predatado <> DateTime('1900/01/01')) 	Then
		lvs_Tipo_Venda = 'VC'
		lvdt_Credito[1] = Date(lvdh_Predatado)
		If lvl_Administradora = 6 Then
			Select pc_comissao_credito_rotativo
				Into :lvdc_Taxa_Credito							  
			  From cartao_estabelecimento
			Where cd_administradora	= :lvl_Administradora
				 and cd_filial				= :lvl_Filial
				 and id_situacao			= 'A'
			  Using SqlCa;
			  
			If SqlCa.SqlCode = -1 Then
				SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + " Localiza$$HEX2$$e700e300$$ENDHEX$$o taxa de cr$$HEX1$$e900$$ENDHEX$$dito rotativo")					
			Else
				If IsNull(lvdc_Taxa_Credito) Then
					lvdc_Taxa_Credito = 0
					//SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + " A taxa de cr$$HEX1$$e900$$ENDHEX$$dito rotativo NULA na tabela 'cartao_estabelecimento'. Administradora: " + string(lvl_Administradora) + " Estabelecimento: " +  lvs_Estabelecimento + ".")
				End If
			End If
		End If						
	ElseIf lvi_Qtde_Parcelas > 1 Then
		lvs_Tipo_Venda = 'VC'
	End If
			
	For lvi_Parcela = 1 To lvi_Qtde_Parcelas
		// Verifica se o comprovante foi inclu$$HEX1$$ed00$$ENDHEX$$do anteriormente pela importa$$HEX2$$e700e300$$ENDHEX$$o dos arquivos (id_captura = 'A')
		// Se for venda a d$$HEX1$$e900$$ENDHEX$$bito, considera tamb$$HEX1$$e900$$ENDHEX$$m o NSU, pois a autoriza$$HEX2$$e700e300$$ENDHEX$$o normalmente $$HEX1$$e900$$ENDHEX$$ a mesma '000000'
		If lvs_Tipo_Venda = "VD" Then
			Select nr_comprovante Into :lvl_Achou
			From cartao_comprovante_operacao
			Where cd_administradora	= :lvl_Administradora
			  and cd_estabelecimento	= :lvs_Estabelecimento
			  and id_tipo_operacao		= :lvs_Tipo_Venda
			  and dh_operacao				= :lvdh_Venda
			  and nr_autorizacao			= :lvs_Autorizacao
			  and nr_nsu					= :lvs_NSU
			  and nr_parcela				= :lvi_Parcela
			  and vl_parcela				= :lvdc_Valor_Parcela[lvi_Parcela]				  
			  and id_captura				= 'A'
			Using SqlCa;
		Else						
			Select nr_comprovante Into :lvl_Achou
			From cartao_comprovante_operacao
			Where cd_administradora	= :lvl_Administradora
			  and cd_estabelecimento	= :lvs_Estabelecimento
			  and id_tipo_operacao		= :lvs_Tipo_Venda
			  and dh_operacao				= :lvdh_Venda
			  and nr_autorizacao			= :lvs_Autorizacao
			  and nr_parcela				= :lvi_Parcela
			  and vl_parcela				= :lvdc_Valor_Parcela[lvi_Parcela]		
			  and id_captura				= 'A'
			Using SqlCa;
		End If
		
		Choose Case SqlCa.SqlCode
			Case 0
				Update cartao_comprovante_operacao
				Set cd_filial						=	:lvl_Filial,
					 nr_nf							=	:lvl_NF,
					 de_especie					=	:lvs_Especie,
					 de_serie						=	:lvs_Serie,
					 vl_operacao				=	:lvdc_Valor_Total,
					 id_captura					=	:lvs_Captura,
					 id_cancelado_filial		=	:lvs_Cancelamento,
					 cd_caixa						=	:lvs_Caixa,
					 nr_controle_caixa			=	:lvl_Controle_Caixa,
					 nr_comprovante_caixa	=	:lvl_Comprovante_Caixa,
					 nr_sequencial				=  :lvl_Sequencial
				Where nr_comprovante = :lvl_Comprovante_Caixa
				Using SqlCa;

				If SqlCa.SqlCode = -1 Then
					SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Atualiza$$HEX2$$e700e300$$ENDHEX$$o do Comprovante")
					lvb_Sucesso = False						
					Exit
				End If				
				
			Case 100
				If lvs_Tipo_Venda = "VC" Then
					lvdc_Comissao = Round(lvdc_Valor_Parcela[lvi_Parcela] * (lvdc_Taxa_Credito / 100), 2)
				Else
					lvdc_Comissao = Round(lvdc_Valor_Parcela[lvi_Parcela] * (lvdc_Taxa_Debito  / 100), 2)
				End If
				
				Insert Into cartao_comprovante_operacao (cd_administradora,   
																	  cd_estabelecimento,   
																	  nr_cartao,   
																	  nr_autorizacao,   
																	  nr_nsu,   
																	  dh_operacao,   
																	  dh_deposito,   
																	  dh_credito,   
																	  id_tipo_operacao,   
																	  vl_operacao,   
																	  qt_parcelas,   
																	  nr_parcela,   
																	  vl_parcela,   
																	  vl_comissao,   
																	  id_captura,
																	  id_situacao,   
																	  cd_filial,   
																	  nr_nf,   
																	  de_especie,   
																	  de_serie,   
																	  nr_lote,   
																	  de_motivo_rejeicao,
																	  cd_caixa,
																	  nr_controle_caixa,
																	  nr_comprovante_caixa,
																	  id_cancelado_filial,
																	  nr_sequencial)  
				Values (:lvl_Administradora,   
						  :lvs_Estabelecimento,   
						  :lvs_Cartao,   
						  :lvs_Autorizacao,   
						  :lvs_NSU,   
						  :lvdh_Venda,   
						  :lvdt_Deposito[lvi_Parcela],   
						  :lvdt_Credito[lvi_Parcela],   
						  :lvs_Tipo_Venda,   
						  :lvdc_Valor_Total,   
						  :lvi_Qtde_Parcelas_Gravacao,   
						  :lvi_Parcela,   
						  :lvdc_Valor_Parcela[lvi_Parcela],   
						  :lvdc_Comissao,   
						  :lvs_Captura,
						  :lvs_Situacao,   
						  :lvl_Filial,   
						  :lvl_NF,   
						  :lvs_Especie,   
						  :lvs_Serie,   
						  null,   
						  null,
						  :lvs_Caixa,
						  :lvl_Controle_Caixa,
						  :lvl_Comprovante_Caixa,
						  :lvs_Cancelamento,
						  :lvl_sequencial)
				Using SqlCa;
				
				If SqlCa.SqlCode = -1 Then
					SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Inclus$$HEX1$$e300$$ENDHEX$$o do Comprovante")
					lvb_Sucesso = False						
					Exit
				End If				
						
			Case -1
				SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Localiza$$HEX2$$e700e300$$ENDHEX$$o do Comprovante")
				lvb_Sucesso = False						
				Exit
		End Choose
	Next

	If lvb_Sucesso Then
		SqlCa.of_Commit()
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Commit")	
		End If
	Else
		 SqlCa.of_RollBack()
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "RollBack")	
		End If
	End If
End If

Return lvb_Sucesso
end function

public function integer of_appendwhere (string ps_tabela, string ps_chave_log, ref dc_uo_ds_base pds_datastore, string ps_central_ou_loja);Long ll_Row
Long ll_Rows
Long ll_Coluna
Long ll_Colunas

String ls_Objeto
String ls_Tipo
String ls_Valor
String ls_Coluna_Chave
String ls_Ds_Pk

dc_uo_ds_base lds_PK
lds_PK = Create dc_uo_ds_base

If ps_Central_Ou_Loja = 'CENTRAL' Then
	ls_Ds_Pk = 'dw_primary_keys_central'
Else
	ls_Ds_Pk = 'dw_primary_keys'
	
	If SqlCa.of_Dbms_Name() = 'POSTGRESQL' Then
		ls_Ds_Pk += '_pg'
	End If
End If

If lds_PK.of_ChangeDataObject( ls_Ds_Pk ) Then
	ll_Rows		= lds_PK.Retrieve( Lower( ps_Tabela ) )
	ll_Colunas	= Long( pds_Datastore.Describe( "DataWindow.Column.Count" ) )
	
	If ll_Rows < 1 Then
		of_Envia_Email_Erro(	"Erro ao recuperar as informa$$HEX2$$e700f500$$ENDHEX$$es da DataStore 'dw_primary_keys'.~r" + &
									"Tabela: " + ps_Tabela + " - Chave: " + ps_Chave_Log, 'of_appendwhere()', 20 )
	End If
	
	If ll_Rows > 0 Then
		For ll_Row = 1 To ll_Rows
			ls_Coluna_Chave 	=	lds_PK.Object.Column_Name[ll_Row]
			ls_Valor				=	""			
			
			For ll_Coluna = 1 To ll_Colunas
				ls_Objeto	= pds_Datastore.Describe( "#" + String( ll_Coluna ) + ".Name" )
				
				If ls_Coluna_Chave <> ls_Objeto Then
					Continue
				End If
				
				ls_Tipo = Upper( pds_Datastore.Describe( ls_Objeto + ".ColType" ) )
			
				Choose Case ls_Tipo
						
					Case "DECIMAL", "REAL", "INT", "LONG", "NUMBER", "ULONG"
						ls_Valor = This.of_Coluna_Chave( ps_Chave_Log, ll_Row )
						
					Case Else
						ls_Valor = "'" + This.of_Coluna_Chave( ps_Chave_Log, ll_Row ) + "'"
						
				End Choose
				
//				If Upper( ps_Tabela ) = 'TITULO_PAGAR' Then
//					pds_DataStore.of_AppendWhere_Subquery( ls_Coluna_Chave + " = " + ls_Valor, 2 )
//				Else
					pds_DataStore.of_AppendWhere( ls_Coluna_Chave + " = " + ls_Valor )
//				End If
				Exit
				
			Next			
		Next		
	Else
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao recuperar as informa$$HEX2$$e700f500$$ENDHEX$$es da DataStore 'dw_primary_keys'.~r" + &
										"Tabela: " + ps_Tabela + " - Chave: " + ps_Chave_Log  )
	End If
	
End If

Destroy lds_PK

Return 1
end function

public function boolean of_central_carrega_tabelas ();/* Fun$$HEX2$$e700e300$$ENDHEX$$o para carregar as tabelas que 
	- Ser$$HEX1$$e300$$ENDHEX$$o exportadas na matriz
	- Ser$$HEX1$$e300$$ENDHEX$$o importadas na loja
*/

Boolean lb_Carrega

String ls_Tabelas[]

Long ll_Linha
Long ll_Antigo
Long ll_Insert

ids_Relacao_Tabelas.of_changedataobject( '_ds_ge212_relacao_tabela' )
This.ids_Relacao_Tabelas.Retrieve( )

ls_Tabelas = {	"011_HISTORICO_CONTROLE_CAIXA", &
					"119_TIPO_ICMS", &
					"095_CST_ORIGEM", &
					"014_CHEQUE", &
					"084_TIPO_DOCUMENTO", &
					"044_SORTEIO_NATAL", &
					"065_ITEM_NF_COMPRA_LOTE", &
					"065_NF_COMPRA_PENDENTE_PRD_LOTE", &
					"082_CARTAO_CLUBE", &
					"102_BINS_GENERICOS", &
					"067_SUBSTANCIA_PRODUTO", &
					"108_CONTA_FLUXO_CAIXA"	, &
					"109_TIPO_CONTA_FLUXO_CAIXA", &
					"112_MOTIVO_REJEICAO_EPHARMA",&
					"114_REMANEJAMENTO_RESULTADO", &
					"092_CLIENTE_CHEQUE", &
					"090_FABRICANTE", &
					"094_DCB_PRODUTO", &
					"074_PRESCRITOR_RECEITA", &
					"050_CONDICAO_VENDA_CONVENIO", &
					"101_CARTAO_PRODUTO", &
					"036_FILIAL_INSCRICAO_ESTADUAL_ST", &
					"122_PEDIDO_DISTRIBUIDORA_ALMOX", &
					"123_NF_COMPRA", &
					"123_NF_COMPRA_PENDENTE", &
					"129_MOTIVO_AJUSTE_EXCECAO", &
					"130_TRIBUTA_PRODUTOS_FARM_MVA", &	
					"140_TIPO_PRODUTO",&				
					"141_TIPO_PRODUTO_FISCAL",&
					"142_TIPO_PRODUTO_FISCAL_NCM",&
					"143_TIPO_PRODUTO_FISCAL_UF",&
					"149_NEGOCIACAO",&
					"152_CLIENTE_CAIXA"}


/*Exportado por json			
"146_ITEM_NF_TRANSFERENCIA",&
"148_NF_TRANSFERENCIA", &
"049_ECT_BAIRRO", &
"137_PROMOCAO_SOS_VINCULO",&
"138_PROMOCAO_SOS_VINCULO_PRD",&
*/
					
// C$$HEX1$$f300$$ENDHEX$$digos para reaproveitamento
//"096_CARTAO_PRODUTO"
//"116_CONVENIADO", &
//"104_NF_COMPRA", &
				
// C$$HEX1$$f300$$ENDHEX$$digos das tabelas que ao IMPORTAR na loja, 
// deve ser carregada a datastore '_loja'
This.ivs_Excessoes_Loja = {"152", &
									"121", &
									"122_PEDIDO_ALMOXARIFADO", &
									"123", &
									"129_MOTIVO_AJUSTE"}
									
// C$$HEX1$$f300$$ENDHEX$$digos das tabelas que ao exportar no central, 
// pode n$$HEX1$$e300$$ENDHEX$$o existir mais o registro na tabela que originou o log exportacao
This.ivs_Permite_Exclusao = {"011", & 
									   "103", &
									   "014", &
									   "114", &
									   "086" }
										
//C$$HEX1$$f300$$ENDHEX$$digos das tabelas no leiaute antigo
//que n$$HEX1$$e300$$ENDHEX$$o precisam ser processadas nas lojas que j$$HEX1$$e100$$ENDHEX$$ tem o TL com o leiaute novo.
//"031"
//"100_PBM", &			

This.ivs_Leiaute_Antigo	= {''}

If Not ivds_Tabelas.of_ChangeDataObject('ds_relacao_tabelas') Then
	Return False
End If

For ll_Linha = 1 To UpperBound(ls_Tabelas)
	lb_Carrega = True
	//Condi$$HEX2$$e700e300$$ENDHEX$$o para tirar da lista de tabelas do TL quando existe mudan$$HEX1$$e700$$ENDHEX$$a de leiaute
	If gvo_Aplicacao.ivo_Seguranca.cd_Sistema = 'TL' Then

		For ll_Antigo = 1 To UpperBound( This.ivs_Leiaute_Antigo )
			If ls_Tabelas[ll_Linha] = This.ivs_Leiaute_Antigo[ ll_Antigo ] Then
				lb_Carrega = False
				Exit
			End If
		Next
	End If
	
	If lb_Carrega Then
		ll_Insert = ivds_Tabelas.InsertRow(0)
		
		ivds_Tabelas.Object.Nm_Datastore[ll_Insert] = ls_Tabelas[ll_Linha]	
	End If
Next

Return True
end function

public function boolean of_central_appendwhere_export (string ps_tabela, string ps_valores_chave_tabela, ref dc_uo_ds_base pds_datastore, ref string ps_chave_log);Long ll_Row
Long ll_Rows
Long ll_Coluna
Long ll_Colunas
Long ll_Limit
Long ll_Inicio
Long ll_Where = 0
Long ll_Idx_Tabela

String ls_Objeto
String ls_Tipo
String ls_Valor
String ls_Coluna_Chave

Date ldt_Date

Time lt_Time
		
ll_Rows = ivds_PK.RowCount()

//Long(ivo_Comum.of_Coluna_Chave_Log(ps_chave_log, 1))

ll_Colunas	= Long( pds_Datastore.Describe( "DataWindow.Column.Count" ) )

If ll_Rows > 0 Then
	For ll_Row = 1 To ll_Rows
		If ll_Where = ll_Rows Then Exit
		
		ls_Coluna_Chave 	=	Trim(ivds_PK.Object.Nm_Coluna[ll_Row])
		ls_Valor				=	ivo_Comum.of_Coluna_Chave_Log( ps_Valores_Chave_Tabela, ll_Row )			
		
		For ll_Coluna = ll_Row To ll_Colunas
			ls_Objeto	= pds_Datastore.Describe( "#" + String( ll_Coluna ) + ".Name" )
			ls_Tipo		= Upper( pds_Datastore.Describe( ls_Objeto + ".ColType" ) )
								
			If Mid( ls_Tipo, 1, 7 ) = "DECIMAL" Then
				ls_Tipo = "DECIMAL"
			ElseIf Mid( ls_Tipo, 1, 4 ) =  "REAL" Then
				ls_Tipo = "REAL"
			End If
			
			Choose Case ls_Tipo
				Case "DATE"
					ll_Limit = 8
					
				Case "DATETIME", "TIMESTAMP"
					ll_Limit = 14
					
				Case "DECIMAL", "REAL"
					ll_Limit = ICI_DECIMAL
					
				Case "INT", "LONG", "ULONG", "NUMBER"
					ll_Limit = 10
					
				Case "TIME"
					ll_Limit = 6
					
				Case Else
					If Mid( ls_Tipo, 1, 4 ) = "CHAR" Then
						ll_Limit	=	Long( Mid( ls_Tipo, 6, LenA( ls_Tipo ) -6 )  )
						If ll_Limit = 32766 Then
							ll_Limit = ivl_Limite_Campo_Text
						End If										
					End If
			End Choose
			
			If ls_Coluna_Chave <> ls_Objeto Then
				ll_Inicio += ll_Limit
				Continue
			End If
			
			Choose Case ls_Tipo
					
				Case "DECIMAL", "REAL"
					//ls_Valor = String(Dec(MidA( ps_Registro, ll_Inicio, ll_Limit )))
					//ls_Valor = gf_Replace(ls_Valor, ",", ".", 0)
					
				Case "INT", "LONG", "NUMBER", "ULONG"
					//ls_Valor = String(Long(MidA( ps_Registro, ll_Inicio, ll_Limit )))
				
				Case "DATETIME"
					//ldt_Date	= Date(MidA( ps_Registro, ll_Inicio, 2) + "/" + MidA( ps_Registro, ll_Inicio + 2, 2) + "/" + MidA( ps_Registro, ll_Inicio + 4, 4))
					//lt_Time	= Time(MidA( ps_Registro, ll_Inicio + 8, 2) + ":" + MidA( ps_Registro, ll_Inicio + 10, 2) + ":" + MidA( ps_Registro, ll_Inicio + 12, 2))
					//ls_Valor = "'" + String(DateTime(ldt_Date, lt_Time), "YYYY/MM/DD HH:MM:SS") + "'"
				
				Case Else
					ls_Valor = "'" + Trim( ls_Valor ) + "'"
					
			End Choose
			
			If ll_Where > 0 Then
				ps_Chave_Log += ' - '
			End If
			
			ps_Chave_Log += ls_Valor

			If Upper( ps_Tabela ) = 'PRODUTO_GERAL' OR Upper( ps_Tabela ) = 'MOTIVO_AJUSTE_EXCECAO' Then
				pds_DataStore.of_AppendWhere_Subquery( ls_Coluna_Chave + " = " + ls_Valor, 2 )
			Else				
				pds_DataStore.of_AppendWhere( ls_Coluna_Chave + " = " + ls_Valor )
			End If
			
			ll_Inicio += ll_Limit
			ll_Where++
			Exit
			
		Next
		
	Next
	
End If

Return True
end function

public function boolean of_loja_appendwhere_import (string ps_tabela, string ps_registro, ref dc_uo_ds_base pds_datastore, ref string ps_chave_log);Long ll_Row
Long ll_Rows
Long ll_Coluna
Long ll_Colunas
Long ll_Limit
Long ll_Inicio
Long ll_Where = 0
Long ll_Idx_Tabela

String ls_Objeto
String ls_Tipo
String ls_Valor
String ls_Coluna_Chave
String ls_Ds

Date ldt_Date

Time lt_Time
		
dc_uo_ds_base lds_PK
lds_PK = Create dc_uo_ds_base

ls_Ds = 'dw_primary_keys'

If SqlCa.of_Dbms_Name() = 'POSTGRESQL' Then
	ls_Ds += '_pg'
End If

If lds_PK.of_ChangeDataObject( ls_Ds ) Then
	ll_Rows		= lds_PK.Retrieve( Lower( ps_Tabela ) )
	ll_Colunas	= Long( pds_Datastore.Describe( "DataWindow.Column.Count" ) )
	
	If ll_Rows < 1 Then
		of_Envia_Email_Erro(	"Erro ao recuperar as informa$$HEX2$$e700f500$$ENDHEX$$es da DataStore 'dw_primary_keys'.~r" + &
									"Tabela: " + ps_Tabela + " - Chave: " + ps_Chave_Log, 'of_loja_appendwhere_import()', 28 )
	End If
End If

ll_Colunas	= Long( pds_Datastore.Describe( "DataWindow.Column.Count" ) )

ll_Inicio = 5

If ll_Rows > 0 Then
	For ll_Row = 1 To ll_Rows
		If ll_Where = ll_Rows Then Exit
		
		ls_Coluna_Chave 	=	Trim(lds_PK.Object.Column_Name[ll_Row])
		ls_Valor				=	""			
		
		For ll_Coluna = ll_Row To ll_Colunas
			ls_Objeto	= pds_Datastore.Describe( "#" + String( ll_Coluna ) + ".Name" )
			ls_Tipo		= Upper( pds_Datastore.Describe( ls_Objeto + ".ColType" ) )
								
			If Mid( ls_Tipo, 1, 7 ) = "DECIMAL" Then
				ls_Tipo = "DECIMAL"
			ElseIf Mid( ls_Tipo, 1, 4 ) =  "REAL" Then
				ls_Tipo = "REAL"
			End If
			
			Choose Case ls_Tipo
				Case "DATE"
					ll_Limit = 8
					
				Case "DATETIME", "TIMESTAMP"
					ll_Limit = 14
					
				Case "DECIMAL", "REAL"
					ll_Limit = ICI_DECIMAL
					
				Case "INT", "LONG", "ULONG", "NUMBER"
					ll_Limit = 10
					
				Case "TIME"
					ll_Limit = 6
					
				Case Else
					If Mid( ls_Tipo, 1, 4 ) = "CHAR" Then
						ll_Limit	=	Long( Mid( ls_Tipo, 6, LenA( ls_Tipo ) -6 )  )
						If ll_Limit = 32766 Then
							ll_Limit = ivl_Limite_Campo_Text
						End If										
					End If
			End Choose
			
			If ls_Coluna_Chave <> ls_Objeto Then
				ll_Inicio += ll_Limit
				Continue
			End If
			
			Choose Case ls_Tipo
					
				Case "DECIMAL", "REAL"
					ls_Valor = String(Dec(MidA( ps_Registro, ll_Inicio, ll_Limit )))
					ls_Valor = gf_Replace(ls_Valor, ",", ".", 0)
					
				Case "INT", "LONG", "NUMBER", "ULONG"
					ls_Valor = String(Long(MidA( ps_Registro, ll_Inicio, ll_Limit )))
				
				Case "DATETIME"
					ldt_Date	= Date(MidA( ps_Registro, ll_Inicio, 2) + "/" + MidA( ps_Registro, ll_Inicio + 2, 2) + "/" + MidA( ps_Registro, ll_Inicio + 4, 4))
					lt_Time	= Time(MidA( ps_Registro, ll_Inicio + 8, 2) + ":" + MidA( ps_Registro, ll_Inicio + 10, 2) + ":" + MidA( ps_Registro, ll_Inicio + 12, 2))
					ls_Valor = "'" + String(DateTime(ldt_Date, lt_Time), "YYYY/MM/DD HH:MM:SS") + "'"
				
				Case Else
					ls_Valor = "'" + Trim(MidA( ps_Registro, ll_Inicio, ll_Limit )) + "'"
					
			End Choose
			
			If ll_Where > 0 Then
				ps_Chave_Log += ' - '
			End If
			
			ps_Chave_Log += ls_Valor
			pds_DataStore.of_AppendWhere( ls_Coluna_Chave + " = " + ls_Valor)
			ll_Inicio += ll_Limit
			ll_Where++
			Exit
			
		Next
		
	Next
	
End If

Destroy lds_PK

Return True
end function

public function boolean of_loja_exclui_referencia_produto (long al_produto, integer ai_log, string as_chave_log);Boolean lvb_Sucesso = False

//Exclui pedido drogaexpress
Delete From produto_pedido_drogaexpress
Where cd_produto = :al_Produto
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_LogdbError(ai_Log, as_Chave_Log + "Exclus$$HEX1$$e300$$ENDHEX$$o do Produto Pedido DrogaExpress")
	Return False
Else
	lvb_Sucesso = True
End If				

//Exclui procura cliente
Delete From produto_procura_cliente
Where cd_produto = :al_Produto
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_LogdbError(ai_Log, as_Chave_Log + "Exclus$$HEX1$$e300$$ENDHEX$$o do Produto Procura Cliente")
	Return False
Else
	lvb_Sucesso = True
End If				

//Exclui Saldo produto
Delete From saldo_produto
Where cd_produto = :al_Produto
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_LogdbError(ai_Log, as_Chave_Log + "Exclus$$HEX1$$e300$$ENDHEX$$o do Saldo do Produto")
	Return False
Else
	lvb_Sucesso = True
End If				

//Exclui produto
Delete From produto_loja
Where cd_produto = :al_Produto
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_LogdbError(ai_Log, as_Chave_Log + "Exclus$$HEX1$$e300$$ENDHEX$$o do Produto Loja")
	Return False
Else
	lvb_Sucesso = True
End If				

Return lvb_Sucesso
end function

public function boolean of_central_grava_registro_exclusao (string ps_tabela, string ps_cd_tabela, string ps_chave, dc_uo_ds_base pds_datastore, ref string ps_registro);Long ll_Row
Long ll_Rows
Long ll_Coluna
Long ll_Colunas
Long ll_Inicio
Long ll_Limit
Long ll_Where = 0

String ls_Objeto
String ls_Tipo
String ls_Valor
String ls_Coluna_Chave
String ls_Registro

ll_Rows = ivds_PK.RowCount()

ll_Colunas	= Long( pds_Datastore.Describe( "DataWindow.Column.Count" ) )

If ll_Rows > 0 Then
	For ll_Row = 1 To ll_Rows
		If ll_Where = ll_Rows Then Exit
		
		ls_Coluna_Chave 	=	Trim(ivds_PK.Object.Nm_Coluna[ll_Row])
		ls_Valor				=	ivo_Comum.of_Coluna_Chave_Log( ps_Chave, ll_Row )			
		
		For ll_Coluna = ll_Row To ll_Colunas
			ls_Objeto	= pds_Datastore.Describe( "#" + String( ll_Coluna ) + ".Name" )
			ls_Tipo		= Upper( pds_Datastore.Describe( ls_Objeto + ".ColType" ) )				
			
			If Mid( ls_Tipo, 1, 7 ) = "DECIMAL" Then
				ls_Tipo = "DECIMAL"
			ElseIf Mid( ls_Tipo, 1, 4 ) =  "REAL" Then
				ls_Tipo = "REAL"
			End If	
			
			Choose Case ls_Tipo
				Case "DATE"
					ll_Limit = 14
					
				Case "DATETIME", "TIMESTAMP"
					ll_Limit = 14					
					ls_Valor = String(Datetime(ls_Valor), "ddmmyyyyhhmmss" )
					
				Case "DECIMAL", "REAL"
					ll_Limit = ICI_DECIMAL
					
				Case "INT", "LONG", "ULONG", "NUMBER"
					ll_Limit = 10
					
				Case "TIME"
					ll_Limit = 6
					
				Case Else
					If Mid( ls_Tipo, 1, 4 ) = "CHAR" Then
						ll_Limit	=	Long( Mid( ls_Tipo, 6, LenA( ls_Tipo ) -6 )  )
						If ll_Limit = 32766 Then
							ll_Limit = ivl_Limite_Campo_Text
						End If										
					End If
			End Choose
			
			If ls_Coluna_Chave <> ls_Objeto Then
				ll_Inicio += ll_Limit
				Continue
			End If
			
			ls_Valor = ivo_Comum.of_String(ls_Valor, ll_Limit)			
			
			ls_Registro += ls_Valor
			
			ll_Inicio += ll_Limit
			ll_Where++
			Exit
			
		Next
	Next	
Else
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao recuperar as informa$$HEX2$$e700f500$$ENDHEX$$es da DataStore 'dw_primary_keys'." )
End If

ps_Registro =  ps_Cd_Tabela + 'E' + ls_Registro

//Destroy lds_PK

Return True
end function

public function boolean of_loja_importa_registro (string ps_cd_tabela, string ps_registro, long pl_linha);Boolean lb_Sucesso = True
Boolean lb_Atualizacao = False
Boolean lb_Chave = False
Boolean lb_Atualiza = True
Boolean lb_SetNull

Decimal ldc_Antes
Decimal ldc_Depois
Decimal ldc_Decimal

Long ll_Loop
Long ll_Colunas
Long ll_Limit
Long ll_Linha
Long ll_Insert
Long ll_Inicio = 5
Long ll_Tamanho
Long ll_Chaves
Long ll_Chaves_Localizadas
Long ll_Find
Long ll_Casas_Decimais
Long ll_Filial_Parametro

String ls_Objetos[]
String ls_Objeto
String ls_Tipo
String ls_Retorno
String ls_Valor
String ls_DataStore
String ls_Id_Atualizacao
String ls_Sql
String ls_Chave_Log
String ls_Mid
String	ls_Nm_Tabela

DateTime ldh_Verificacao_1
DateTime ldh_Verificacao_2

If Not SqlCa.of_IsConnected( ) Then
	of_Envia_Email_Erro(	"Conex$$HEX1$$e300$$ENDHEX$$o com o banco de dados perdida", 'of_loja_importa_registro()', 40)
	Halt Close
End If

dc_uo_ds_base	lds_Datastore
dc_uo_ds_base	lds_Ds_Auxiliar

ll_Find = ivds_Tabelas.Find( "mid( nm_datastore, 1, 3 )  = '" + ps_Cd_Tabela + "'", 1, ivds_Tabelas.RowCount() )
//
If ll_Find > 0 Then
	ls_Nm_Tabela = MidA( ivds_Tabelas.Object.Nm_DataStore[ ll_Find ], 5 )
End If

#IF DEFINED DEBUG THEN
	If ps_Cd_Tabela = '135' Then
		ps_Cd_Tabela = ps_Cd_Tabela
	End If
#END IF

ls_DataStore = 'ds_'  + ps_Cd_Tabela + '_' + ls_Nm_Tabela

//Tipo de atualiza$$HEX2$$e700e300$$ENDHEX$$o do LOG
ls_Id_Atualizacao = MidA( ps_Registro, 4, 1 )

/* Carrega a datastore diferente para a Loja, se for necess$$HEX1$$e100$$ENDHEX$$rio */
For ll_Loop = 1 To UpperBound( This.ivs_Excessoes_Loja )
	If Left(This.ivs_Excessoes_Loja[ll_Loop], 3) = ps_Cd_Tabela Then
		If Len(This.ivs_Excessoes_Loja[ll_Loop]) > 3 Then		
				ls_Nm_Tabela = Lower(Mid(This.ivs_Excessoes_Loja[ll_Loop], 5))
		End If
		
		ls_DataStore = 'ds_'  + ps_Cd_Tabela + '_' + ls_Nm_Tabela + '_loja'
		Exit
	End If
Next
/***/

lds_Datastore = Create dc_uo_ds_base
If Not lds_Datastore.of_ChangeDataObject( ls_DataStore, False ) Then
	This.of_Grava_Log( ivi_Log, "LINHA: " + String( pl_Linha ) + " :: Erro na mudan$$HEX1$$e700$$ENDHEX$$a na DW '" + ls_DataStore + "'." )
	Destroy lds_Datastore
	Return False
End If

This.of_Loja_AppendWhere_Import( ls_Nm_Tabela, ps_Registro, ref lds_Datastore, ref ls_Chave_Log )

ls_Chave_Log = "LINHA: "+ String( pl_Linha + 1 ) + " :: " +Upper( ls_Nm_Tabela ) + "(" + ls_Chave_Log + ") :: "	
ll_Linha = lds_Datastore.Retrieve( )	

Choose Case ll_Linha
	Case 0
		lb_Atualizacao = False
		
		If ls_Id_Atualizacao <> 'E' Then
			ll_Linha = lds_Datastore.Insertrow(0)
		End If
		
	Case 1
		lb_Atualizacao = True
		
	Case Else
		
		If ll_Linha < 0 Then
			This.of_Grava_Log( ivi_Log, ls_Chave_Log + "Ocorreram erros ao tentar recuperar as informa$$HEX2$$e700f500$$ENDHEX$$es da '" + ls_DataStore + "'. " + &
											 			lds_Datastore.ivo_dbError.ivs_Mensagem)
		Else
			This.of_Grava_Log( ivi_Log, ls_Chave_Log + "Foi encontrada mais de uma linha no retrieve da '" + ls_DataStore + "'.")
		End If
		
		Destroy lds_Datastore
		Return False
		
End Choose
		
If ls_Id_Atualizacao <> 'E' Then
	
	
	
	ll_Colunas	= Long( lds_Datastore.Describe( "DataWindow.Column.Count" ) )
	
	For ll_Loop = 1 To ll_Colunas
		lb_SetNull = True
		
		ls_Objeto	= lds_Datastore.Describe( "#" + String(ll_Loop) + ".Name" )
		ls_Tipo		= Upper( lds_Datastore.Describe( ls_Objeto + ".ColType" ) )
		
		If Upper( lds_Datastore.Describe( "#" + String(ll_Loop) + ".Edit.NilIsNull" ) ) = "YES" Then
			lb_SetNull = False
		End If
		
		lb_Chave	= False
				
		//Se encontrou todas as chaves da tabela, n$$HEX1$$e300$$ENDHEX$$o precisa verificar os outros campos
		If ll_Chaves_Localizadas < ll_Chaves Then
			//N$$HEX1$$e300$$ENDHEX$$o atualizar o campo chave prim$$HEX1$$e100$$ENDHEX$$ria (lb_Chave = False). Problema no Update da data window no Sybase Central
			//Somente se for Insert (lb_Atualizacao = False).
			This.Of_Campo_Chave(ls_Nm_Tabela, ls_Objeto, Ref lb_Chave)
			If lb_Chave Then ll_Chaves_Localizadas++
		End If
							
		If Mid( ls_Tipo, 1, 7 ) = "DECIMAL" Then
			ls_Mid					=	MidA( ls_Tipo, 9 )
			ll_Casas_Decimais		=	Long( MidA( ls_Mid, 1, PosA( ls_Mid, ')' ) -1 ) )

			ls_Tipo = "DECIMAL"
		ElseIf Mid( ls_Tipo, 1, 4 ) =  "REAL" Then
			ls_Tipo = "REAL"
		End If
		
		Choose Case ls_Tipo
			Case "DATE"
				ll_Limit 		= 14
				ls_Retorno	= Trim(MidA( ps_Registro , ll_Inicio, ll_Limit ))
				
				If ls_Retorno = '' Then SetNull(ls_Retorno)				
				
				If Not lb_Chave Or Not lb_Atualizacao Then
					ll_Insert		= lds_Datastore.SetItem( ll_Linha, ls_Objeto, DateTime(ivo_Comum.of_Date(ls_Retorno)) )					
				End If
				
			Case "DATETIME", "TIMESTAMP"
				ll_Limit 		= 14
				ls_Retorno	= Trim(MidA( ps_Registro , ll_Inicio, ll_Limit ))
				
				If ls_Retorno = '' Then SetNull(ls_Retorno)
				
				If Not lb_Chave Or Not lb_Atualizacao Then
					ll_Insert		= lds_Datastore.SetItem( ll_Linha, ls_Objeto, ivo_Comum.of_DateTime(ls_Retorno) )
				End If
				
			Case "DECIMAL", "REAL"
				ll_Limit 		= ICI_DECIMAL
				ls_Retorno	= Trim(MidA( ps_Registro , ll_Inicio, ll_Limit ))
				
				If ls_Retorno = '' Then SetNull(ls_Retorno)				
				ls_Retorno = gf_Replace(ls_Retorno, ",", "", 0)
				ls_Retorno = gf_Replace(ls_Retorno, ".", "", 0)
				
				If Not lb_Chave Or Not lb_Atualizacao Then
					ldc_Decimal	= ivo_Comum.of_Decimal( ls_Retorno, ll_Casas_Decimais )
					ll_Insert		= lds_Datastore.SetItem( ll_Linha, ls_Objeto, ldc_Decimal )
				End If
				
			Case "INT"
				ll_Limit = 10
				ls_Retorno = Trim(MidA( ps_Registro , ll_Inicio, ll_Limit ))
				
				If ls_Retorno = '' Then SetNull(ls_Retorno)
				
				If Not lb_Chave Or Not lb_Atualizacao Then
					ll_Insert = lds_Datastore.SetItem( ll_Linha, ls_Objeto, Integer(ls_Retorno) )
				End If
			
			Case "LONG", "ULONG"
				ll_Limit = 10
				ls_Retorno = Trim(MidA( ps_Registro , ll_Inicio, ll_Limit ))
				
				If ls_Retorno = '' Then SetNull(ls_Retorno)
				
				If Not lb_Chave Or Not lb_Atualizacao Then
					ll_Insert 	   = lds_Datastore.SetItem( ll_Linha, ls_Objeto, Long(ls_Retorno) )
				End If
				
			Case  "NUMBER"
				ll_Limit = 10
				ls_Retorno = Trim(MidA( ps_Registro , ll_Inicio, ll_Limit ))
				
				If ls_Retorno = '' Then SetNull(ls_Retorno)
				
				If Not lb_Chave Or Not lb_Atualizacao Then
					ll_Insert = lds_Datastore.SetItem( ll_Linha, ls_Objeto, Long(ls_Retorno) )
				End If
				
			Case "TIME"
	//			ll_Limit 		= 6
	//			ls_Retorno	= MidA( ps_Registro , ll_Inicio, ll_Limit )
	//			ll_Insert		= lds_Datastore.SetItem( ll_Linha, ls_Objeto, ivo_Comum.of_Time(ls_Retorno) )
				
			Case Else
				If Mid( ls_Tipo, 1, 4 ) = "CHAR" Then
					ll_Limit		=	Long( Mid( ls_Tipo, 6, LenA( ls_Tipo ) -6 )  )
					//Verifica$$HEX2$$e700e300$$ENDHEX$$o para se o campo for do tipo TEXT(identificacao_biometrica) altera o seu limite
					//Pois o FileWrite grava at$$HEX1$$e900$$ENDHEX$$ 32766 e esse tipo de campo usa todo o limite.
					If ll_Limit = 32766 Then
						ll_Limit = ivl_Limite_Campo_Text
					End If					
					ls_Retorno 	=	Trim( MidA( ps_Registro , ll_Inicio, ll_Limit ) )
					
					If ls_Retorno = '' And lb_SetNull Then SetNull(ls_Retorno)
				
					If Not lb_Chave Or Not lb_Atualizacao Then
						ll_Insert = lds_Datastore.SetItem( ll_Linha, ls_Objeto, Trim(ls_Retorno) )
					End If
				End If
				
				If Mid( ls_Tipo, 1, 7 ) = "DECIMAL" Or Mid( ls_Tipo, 1, 4 ) = "REAL" Then
					ll_Limit 		= ICI_DECIMAL
					ls_Retorno	= Trim(MidA( ps_Registro , ll_Inicio, ll_Limit ))
					
					If ls_Retorno = '' Then SetNull(ls_Retorno)
					
					If Not lb_Chave Or Not lb_Atualizacao Then
						ll_Insert	= lds_Datastore.SetItem( ll_Linha, ls_Objeto, Dec(ls_Retorno) )
					End If
				End If
		End Choose
		
		ll_Inicio += ll_Limit
		
		If ll_Insert = -1 Then
			This.of_Grava_Log( ivi_Log, ls_Chave_Log + "Erro ao inserir valor na coluna '" + ls_Objeto + "' da DataStore '" + ls_DataStore + "'.")
			lb_Sucesso = False
			Exit
		End If
		
	Next
	
Else	
	If ll_Linha = 1 Then
		
		Choose Case ls_Nm_Tabela

			Case "NF_COMPRA"
				Long lvl_Filial, &
						lvl_NF
				String lvs_Fornecedor, &
						lvs_Especie, &
						lvs_Serie
				
				lvl_Filial 				= lds_DataStore.Object.cd_filial[1]
				lvs_Fornecedor		= lds_DataStore.Object.cd_fornecedor[1]
				lvl_NF					= lds_DataStore.Object.nr_nf[1]
				lvs_Especie			= lds_DataStore.Object.de_especie[1]
				lvs_Serie				= lds_DataStore.Object.de_serie[1]
				
				uo_ge059_exclusao_nf_compra lvo_Exclusao_NF
				lvo_Exclusao_NF = Create uo_ge059_exclusao_nf_compra
				
				lb_Sucesso = lvo_Exclusao_NF.of_Exclui_Nota_Fiscal( lvl_Filial, &
																					 lvs_Fornecedor, &
																					 lvl_NF, &
																					 lvs_Especie, &
																					 lvs_Serie, &
																					 ivi_LOG, &
																					 ls_Chave_LOG)
				If lb_Sucesso Then
					SqlCa.of_Commit()
				Else
					SqlCa.of_RollBack()
				End If
				
				Destroy(lvo_Exclusao_NF)	
				lb_Atualiza = False
				
				
			Case Else
				If lb_Sucesso Then
					ls_Sql = lds_Datastore.Object.DataWindow.Table.Select
					
					If lds_Datastore.DeleteRow( ll_Linha ) < 0 Then
						This.of_Grava_Log( ivi_Log, "Erro ao excluir a linha da '" + ls_DataStore + "'.~r" + ls_Sql )
						lb_Sucesso = False
					End If
				End If
		End Choose				
		
	Else
		Destroy lds_Datastore
		Return lb_Sucesso
	End If
End If

/* Tratamentos especiais, como compara$$HEX2$$e700f500$$ENDHEX$$es de datas da filial com datas do Central */
If ls_Id_Atualizacao <> 'E' Then
	
	Choose Case ls_Nm_Tabela
			
		Case 'NF_COMPRA'
			If lb_Atualizacao Then
				 lds_Datastore.Modify("dh_atualizacao_estoque.Update = No")
				 lds_Datastore.Modify("nr_matric_atualizacao_estoque.Update = No")
				 lds_Datastore.Modify("de_chave_acesso.Update = No")
 			End If

		Case	'PRODUTO_GERAL'			
			lds_Datastore.Modify("cd_tipo_icms.Update = No") // Conforme problema identificado no dia 15/02/2016 por Fernando Correa, onde o cd_tipo_icms deve ser atualizado somente atraves da produto_uf
			
			If lb_Atualizacao Then
				 lds_Datastore.Modify("cd_tributacao_icms.Update = No")
				 lds_Datastore.Modify("vl_preco_venda_atual.Update = No")
				 lds_Datastore.Modify("dh_preco_venda_atual.Update = No")
				 lds_Datastore.Modify("nr_matricula_preco_venda_atual.Update = No")
				 lds_Datastore.Modify("vl_preco_venda_futuro.Update = No")
				 lds_Datastore.Modify("dh_preco_venda_futuro.Update = No")
				 lds_Datastore.Modify("nr_matric_preco_venda_futuro.Update = No")
 			End If

		Case	'PEDIDO_DISTRIBUIDORA_PRODUTO'
			If lb_Atualizacao Then
				 lds_Datastore.Modify("qt_faturada.Update = No")
				 lds_Datastore.Modify("qt_recebida.Update = No")
				 lds_Datastore.Modify("id_situacao.Update = No")
			End If			 
			 
		Case 'NF_TRANSFERENCIA'
			lds_Datastore.Modify("destroy column dh_recebimento")	 //coluna estava sendo anulada ap$$HEX1$$f300$$ENDHEX$$s confirma$$HEX2$$e700e300$$ENDHEX$$o na intranet
			
			If ls_Id_Atualizacao = 'I' And not lb_Atualizacao Then
				lds_Datastore.Modify("destroy column dh_cancelamento") // Remove a coluna da DataWindow/DataStore
				lds_Datastore.Modify("destroy column nr_matricula_cancelamento")	
			End If
			
		Case 'CONVENIADO'
			lds_Datastore.Modify("cd_cliente.Update = No")
//			lds_Datastore.Modify("id_bloqueio_unimed.Update = No")
			
	End Choose
	
End If

If IsValid( lds_Ds_Auxiliar ) Then
	Destroy lds_Ds_Auxiliar
End IF

If Not lb_Atualiza Then
	Destroy lds_Datastore
	Return lb_Sucesso
End If
/* Fim dos tratamentos especiais */

//If ll_Linha = 1 Then
If lds_DataStore.RowCount() = 1 Then
	ll_Filial_Parametro = ivo_Comum.of_Filial_Parametro()	

	Choose Case ls_Nm_Tabela
		Case  "CLIENTE_CHEQUE", &
				"IDENTIFICACAO_BIOMETRICA", &
				"PRESCRITOR_RECEITA"
			If lds_Datastore.Object.Cd_Filial_Atualizacao[ll_Linha] =  ll_Filial_Parametro Then				
				Destroy(lds_Datastore)
				Return True	
			End If
		Case "PROMOCAO_SOS_PRODUTO"
			If lds_Datastore.Object.Cd_Filial[ll_Linha] <> ll_Filial_Parametro Then							
				Destroy(lds_Datastore)
				Return True	
			End If			
	End Choose
End If

If lds_Datastore.Update() = -1 Then
	If ( ( Upper( ls_Nm_Tabela ) = 'CONVENIO' ) Or ( Upper( ls_Nm_Tabela ) = 'CLIENTE' ) Or ( Upper( ls_Nm_Tabela ) = 'CONVENIADO' ) ) And &
		lds_Datastore.ivo_dbError.of_Msg_PostgreSQL() = 'Ocorreram altera$$HEX2$$e700f500$$ENDHEX$$es no banco de dados em uma das informa$$HEX2$$e700f500$$ENDHEX$$es modificadas nesta janela. Por favor, recupere os registros novamente e proceda as modifica$$HEX2$$e700f500$$ENDHEX$$es efetuadas.' Then
		SqlCa.of_Commit()
	Else
		This.of_Grava_Log( ivi_Log, ls_Chave_Log + lds_Datastore.ivo_dbError.of_Msg_PostgreSQL() )
		lb_Sucesso = False
	End If
Else
	SqlCa.of_Commit()
End If

Destroy lds_Datastore

GarbageCollect( )
Yield( )

Return lb_Sucesso
end function

public function boolean of_central_grava_registro (string ps_tabela, string ps_chave_log, string ps_atualizacao, long pl_linha_ds_tabelas, ref string ps_registro);Long ll_Loop
Long ll_Colunas
Long ll_Limit
Long ll_Linha
Long ll_Chaves

String ls_Objetos[]
String ls_Objeto
String ls_Tipo
String ls_Retorno
String ls_Valor
String ls_String
String ls_DataStore
String ls_Cd_Tabela
String ls_Tabela
String ls_Sql_Alterado
String ls_Erro
String	ls_Chave_Log
String ls_Chave_Arquivo_Log

dc_uo_ds_base	lds_Datastore
ls_Tabela = Upper(ps_Tabela)

ls_Cd_Tabela = LeftA( ivds_Tabelas.Object.Nm_DataStore[ pl_Linha_Ds_Tabelas ], 3 )

//Debug
If ls_Cd_Tabela = '129' Or ls_Cd_Tabela = '123'  Then
	ls_Cd_Tabela = ls_Cd_Tabela
End If

ls_DataStore = 'ds_' + ls_Cd_Tabela + '_' + ps_Tabela

If ls_Tabela = 'CLIENTE_CAIXA' Then
	ls_DataStore = 'ds_' + ls_Cd_Tabela + '_' + ls_Tabela + '_CENTRAL'
End If

lds_Datastore = Create dc_uo_ds_base
If Not lds_Datastore.of_ChangeDataObject( ls_DataStore ) Then
	Destroy lds_Datastore
	Return False
End If

If ps_Atualizacao = 'E' Then
	This.of_Carrega_Campos_Chave( ls_Cd_Tabela, ps_Tabela, Ref ll_Chaves )
	This.of_Central_Grava_Registro_Exclusao( ps_Tabela, ls_Cd_Tabela, ps_Chave_Log, lds_Datastore, Ref ps_Registro )
	Destroy lds_Datastore
	Return True
End If

This.of_Carrega_Campos_Chave( ls_Cd_Tabela, ps_Tabela, Ref ll_Chaves)
This.of_Central_AppendWhere_Export( ps_Tabela, ref ps_Chave_Log, ref lds_Datastore, ref ls_Chave_Arquivo_Log )

lds_Datastore.Retrieve()

For ll_Loop = 1 To UpperBound( This.ivs_Permite_Exclusao )
	If Left(This.ivs_Permite_Exclusao[ll_Loop], 3) = ls_Cd_Tabela Then
		If lds_Datastore.RowCount() < 1 Then
			This.of_Central_Grava_Registro_Exclusao( ps_Tabela, ls_Cd_Tabela, ps_Chave_Log, lds_Datastore, Ref ps_Registro )
			Destroy lds_Datastore
			Return True
		End If
	End If
Next

If lds_Datastore.RowCount() < 1 Then
	If lds_Datastore.RowCount() = 0 Then
		ls_Erro =	"Nenhum registro localizado na tabela '" + ls_DataStore + "'. Chave: " + ps_Chave_Log
	Else
		ls_Erro =	"Ocorreram erros ao tentar recuperar as informa$$HEX2$$e700f500$$ENDHEX$$es da '" + ls_DataStore + "'. Chave: " + ps_Chave_Log + &
					"~r" + lds_Datastore.ivo_DbError.ivs_Mensagem 
	End If

	ls_Sql_Alterado = lds_Datastore.Object.DataWindow.Table.Select // Debug
									
	//Envia email com erro ocorrido.
	of_Envia_Email_Erro(	ls_Erro + " ~r~r SQL: " + ls_Sql_Alterado, 'of_central_grava_registro()', 99 )
	//
	If lds_Datastore.RowCount() = 0 Then
		Destroy lds_Datastore
		Return True
	Else
		Destroy lds_Datastore
		Return False
	End If
End If

ls_String		= ''
ll_Colunas	= Long( lds_Datastore.Describe( "DataWindow.Column.Count" ) )

For ll_Loop = 1 To ll_Colunas
	ls_Objeto	= lds_Datastore.Describe( "#" + String(ll_Loop) + ".Name" )
	ls_Tipo		= Upper( lds_Datastore.Describe( ls_Objeto + ".ColType" ) )

	Choose Case ls_Tipo
		Case "DATE"
			ls_Valor = String(lds_Datastore.GetItemDate( 1, ls_Objeto ) )
			
			If IsNull( ls_Valor ) Then
				ls_Retorno = Space(14)
			Else
				ls_Retorno = LeftA( String(lds_Datastore.GetItemDate( 1, ls_Objeto ), "ddmmyyyy" ), 8)
				ls_Retorno = ls_Retorno + "000000"
			End If
			
		Case "DATETIME", "TIMESTAMP"
			ls_Valor = String(lds_Datastore.GetItemDateTime( 1, ls_Objeto ) )
			
			If IsNull( ls_Valor ) Then
				ls_Retorno = Space(14)
			Else
				ls_Retorno = LeftA( String(lds_Datastore.GetItemDateTime( 1, ls_Objeto ), "ddmmyyyyhhmmss" ), 14)
			End If
			
		Case "DECIMAL", "REAL"
			ls_Valor = String( lds_Datastore.GetItemDecimal( 1, ls_Objeto ) )
			If IsNull( ls_Valor ) Then ls_Valor = ""
			ls_Retorno =  ivo_Comum.of_String( ls_Valor, ICI_DECIMAL )
			
		Case "INT", "LONG", "NUMBER", "ULONG"
			ls_Valor = String(lds_Datastore.GetItemNumber( 1, ls_Objeto ) )
			If IsNull( ls_Valor ) Then ls_Valor = ""
			ls_Retorno = ivo_Comum.of_String( ls_Valor, 10 )
			
		Case "TIME"
			ls_Valor = String(lds_Datastore.GetItemTime( 1, ls_Objeto ) )
			
			If IsNull( ls_Valor ) Then
				ls_Retorno = Space(14)
			Else
				ls_Retorno = LeftA( String(lds_Datastore.GetItemTime( 1, ls_Objeto ), "hhmmss" ), 6)
			End If
			
		Case Else
			If Mid( ls_Tipo, 1, 4 ) = "CHAR" Then
				ls_Valor 		=	String( lds_Datastore.GetItemString( 1, ls_Objeto ) )
				If IsNull( ls_Valor ) Then ls_Valor = ""
				ls_Valor 		=	gf_Replace( ls_Valor, "~r", " ", 0 )
				ls_Valor 		=	gf_Replace( ls_Valor, "~n", " ", 0 )
				ll_Limit		=	Long( Mid( ls_Tipo, 6, LenA( ls_Tipo ) -6 )  )
				If ll_Limit = 32766 Then
					ll_Limit = ivl_Limite_Campo_Text
				End If								
				ls_Retorno 	=	LeftA( ls_Valor , ll_Limit ) + Space( ll_Limit - LenA(ls_Valor) )
			End If
			
			If Mid( ls_Tipo, 1, 7 ) = "DECIMAL" Or Mid( ls_Tipo, 1, 4 ) =  "REAL" Then
				ls_Valor = String( lds_Datastore.GetItemDecimal( 1, ls_Objeto ) )
				If IsNull( ls_Valor ) Then ls_Valor = ""
				ls_Retorno = ivo_Comum.of_String( ls_Valor, ICI_DECIMAL )
			End If
			
	End Choose
	
	ls_String += ls_Retorno
Next
	
ps_Registro = ls_Cd_Tabela + ps_Atualizacao + ls_String

Destroy lds_Datastore
Return True
end function

public function boolean of_central_importa_saldo_produto (dc_uo_ds_base lvds_1, string ps_linha);Boolean lvb_Commit = True

Long lvl_Filial, &
	   lvl_Produto
	  
String  lvs_Chave_Log
		 
DateTime lvdh_Saldo
			
Decimal lvdc_Custo_Medio, &
        lvdc_Custo_Gerencial
		  
lvl_Filial					= lvds_1.Object.cd_filial				[1]
lvdh_Saldo				= lvds_1.Object.dh_saldo			[1]
lvl_Produto				= lvds_1.Object.cd_produto			[1]
lvdc_Custo_Medio		= lvds_1.Object.vl_custo_medio	[1] 
lvdc_Custo_Gerencial	= lvds_1.Object.vl_custo_gerencial[1]
		
lvs_Chave_Log = "SALDO_PRODUTO (" + String(lvl_Filial,"0000") + "-" +&
							 String(lvl_Produto,"000000") + "-" +&
							 String(lvdh_Saldo, "DD/MM/YYYY")+") "
		
Update saldo_produto
Set vl_custo_medio = :lvdc_Custo_Medio,
	 vl_custo_gerencial = :lvdc_Custo_Gerencial
Where cd_filial    = :lvl_Filial
  and cd_produto   = :lvl_Produto
  and dh_saldo    >= :lvdh_Saldo
Using SqlCa;
		
If SqlCa.SqlCode = -1 Then
	SqlCa.of_LogdbError(ivi_Log, lvs_Chave_Log + "Atualiza$$HEX2$$e700e300$$ENDHEX$$o")
	lvb_Commit = False
Else
	If SqlCa.SqlNRows = 0 Then
		SqlCa.of_LogdbError(ivi_Log, lvs_Chave_Log + "Localiza$$HEX2$$e700e300$$ENDHEX$$o")									  
		lvb_Commit = False
	End If
End If

Return lvb_Commit
end function

public function boolean of_central_importa_promocao_sos_produto (dc_uo_ds_base lvds_1, string ps_linha);Boolean lvb_Commit = True

Long lvl_Filial, &
	   lvl_Produto,&
	   lvl_Estoque,&
	   lvl_Promocao,&
	   lvl_Achou
	  
String  lvs_Chave_Log

lvl_Promocao			= lvds_1.Object.cd_promocao_sos	[1]
lvl_Filial					= lvds_1.Object.cd_filial				[1]
lvl_Produto				= lvds_1.Object.cd_produto			[1]
lvl_Estoque				= lvds_1.Object.qt_estoque_minimo[1]
		
lvs_Chave_Log = "(" + String(lvl_Promocao) + "-" +&
							 String(lvl_Filial) + "-" +&
							 String(lvl_Produto) + ") "

Select cd_produto Into :lvl_Achou
From promocao_sos_estoque_minimo
Where cd_promocao_sos = :lvl_Promocao
  and cd_filial       = :lvl_Filial
  and cd_produto      = :lvl_Produto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If lvl_Estoque > 0 Then
			Update promocao_sos_estoque_minimo
			Set qt_estoque_minimo  = :lvl_Estoque,
				 id_alterado_filial = 'S'
			Where cd_promocao_sos = :lvl_Promocao
			  and cd_filial       = :lvl_Filial
			  and cd_produto      = :lvl_Produto
			Using SqlCa;

			If SqlCa.SqlCode = -1 Then
				SqlCa.of_LogdbError(ivi_Log, lvs_Chave_Log + "Altera$$HEX2$$e700e300$$ENDHEX$$o")
				lvb_Commit = False
			End If
		Else
			Delete From promocao_sos_estoque_minimo
			Where cd_promocao_sos = :lvl_Promocao
			  and cd_filial       = :lvl_Filial
			  and cd_produto      = :lvl_Produto
			Using SqlCa;

			If SqlCa.SqlCode = -1 Then
				SqlCa.of_LogdbError(ivi_Log, lvs_Chave_Log + "Exclus$$HEX1$$e300$$ENDHEX$$o")
				lvb_Commit = False
			End If
		End If
		
	Case 100
		If lvl_Estoque > 0 Then
			Insert Into promocao_sos_estoque_minimo (cd_promocao_sos,
																  cd_filial,   
																  cd_produto,   
																  qt_estoque_minimo,
																  id_alterado_filial)   
			Values (:lvl_Promocao,   
					  :lvl_Filial,   
					  :lvl_Produto,   
					  :lvl_Estoque,
					  'S')
			Using SqlCa;

			If SqlCa.SqlCode = -1 Then
				SqlCa.of_LogdbError(ivi_Log, lvs_Chave_Log + "Inclus$$HEX1$$e300$$ENDHEX$$o")
				lvb_Commit = False
			End If
		End If				
		
	Case -1
		SqlCa.of_LogdbError(ivi_Log, lvs_Chave_Log + "Localiza$$HEX2$$e700e300$$ENDHEX$$o")
		lvb_Commit = False
End Choose		

If lvb_Commit Then
	Commit Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_LogdbError(ivi_Log, lvs_Chave_Log + "Commit")	
	End If
End If

Return lvb_Commit
end function

public function boolean of_loja_atualiza_log (string ps_situacao, ref long pl_linhas);Long ll_Fechamento

String ls_Situacao_Old = 'N'
String ls_Arquivo

If ps_Situacao = 'S' Then ls_Situacao_Old = 'P'
If ps_Situacao = 'P' Then ls_Situacao_Old = 'N'

If ps_Situacao = 'S' Then
	ls_Arquivo = MidA( ivs_Arquivo, 7, 6 )
	
	Update log_exportacao
		Set nr_arquivo			= :ls_Arquivo,
			 id_processado		= :ps_Situacao
	 Where id_processado	= :ls_Situacao_Old
	 Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case -1
			SqlCa.of_MsgDbError()
			Return False
	End Choose
	 
End If

If ps_Situacao = 'P' Then
	Select count(*)
		Into :ll_Fechamento
	 From log_exportacao
	Where id_processado in ( 'N', 'P' )
		And nm_tabela = 'LOG_FECHAMENTO_DIARIO'
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case -1
			SqlCa.of_MsgDbError()
			Return False
			
		Case Else
			If ll_Fechamento > 0 Then
				Update log_exportacao
					Set id_processado  = :ps_Situacao
				Where id_processado = :ls_Situacao_Old
				Using SqlCa;
			Else
				Update log_exportacao
					Set id_processado  = :ps_Situacao
				Where id_processado = :ls_Situacao_Old
					And nm_tabela <> 'SALDO_PRODUTO'
				Using SqlCa;
			End If
	End Choose

 
	Choose Case SqlCa.SqlCode
		Case -1
			SqlCa.of_MsgDbError()
			Return False
	End Choose
	
End If

pl_Linhas = SqlCa.sqlNRows

Return True
end function

public function boolean of_central_importa (string ps_caminho, string ps_arquivo);Boolean lb_Sucesso = True

Integer li_Tentativas

Long li_Read
Long ll_Linha
Long ll_FileLength
Long ll_Progress=0
Long ll_Filial
Long ll_Nr_Arquivo
Long ll_Seq_Arquivo
Long ll_Seq_Lido = 1

DateTime ldh_ServerDate

String ls_Registro
String ls_Tabela
String ls_Nome_Tabela
String ls_Tipo_Registro // Para identificar se eh Json

If Not This.of_Carrega_Tabelas_Loja() Then Return False
If Not This.of_Carrega_Tabela_Json( 'relacao_tabelas_tl' ) Then Return False

ivs_Caminho_Arquivo = ps_Caminho
ivs_Arquivo 				= ps_Arquivo
ivs_Log					= ps_Caminho + MidA( ps_Arquivo, 1, LenA( ps_Arquivo ) -4 ) + '.log'

If FileExists( ivs_Log ) Then
	If FileLength( ivs_Log ) = 0 Then
		FileDelete( ivs_Log )
	End If
	
	//Return False
End If

ll_Filial = Long( MidA( ivs_Arquivo, 2, 4) )
ivl_Filial_Importacao = ll_Filial

If Not This.of_Abre_Log( ivs_Log ) Then
	Return False
End If

If Not This.of_Central_Verifica_Ultimo_Arquivo_Imp( ll_Filial, ref ll_Nr_Arquivo ) Then Return False
ll_Nr_Arquivo++

If ll_Nr_Arquivo <> Long( MidA( ivs_Arquivo, 7, 6 ) ) Then
	If ll_Nr_Arquivo < Long( MidA( ivs_Arquivo, 7, 6 ) ) Then
		This.of_Grava_Log( ivi_Log, "Arquivo recebido '" + ivs_Arquivo + "' n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ esperado.~r" + &
											"Arquivo esperado: '" + String(ll_Filial, "0000") + "_" + String( ll_Nr_Arquivo, "000000" ) + ".txt'" )
	End If
	
	FileClose( ivi_Log )
	This.of_Backup_Importacao( ll_Filial )
	
	If ll_Nr_Arquivo > Long( MidA( ivs_Arquivo, 7, 6 ) ) Then // Quando est$$HEX1$$e100$$ENDHEX$$ pegando um arquivo que j$$HEX1$$e100$$ENDHEX$$ foi importado, retorna TRUE para ir para o pr$$HEX1$$f300$$ENDHEX$$ximo arquivo caso haja
		Return True
	End If
	
	Return False
End If

ll_FileLength	= FileLength( ivs_Caminho_Arquivo + ivs_Arquivo )

/* Tenta realizar a abertura do arquivo por 3 vezes antes de dar erro */
li_Tentativas = 0
Do 
	li_Tentativas++
	ivi_Arquivo	= FileOpen( ivs_Caminho_Arquivo + ivs_Arquivo, LineMode!, Read! )
	
	If ivi_Arquivo = -1 Then gf_Delay( 2 )
	
	If li_Tentativas >= 3 Then Exit
	
Loop While ( ivi_Arquivo = -1 )

If Not FileExists ( ivs_Caminho_Arquivo + ivs_Arquivo ) Then Return False
/****/

If ivi_Arquivo = -1 Then
	This.of_Grava_Log( ivi_Log, "Erro ao tentar abrir o arquivo '" + ivs_Arquivo + "'" )
	Return False
End If

li_Read = FileRead( ivi_Arquivo, ref ls_Registro )

If li_Read = -1 Or li_Read = 0 Then
	This.of_Grava_Log( ivi_Log, "Erro ao tentar ler o arquivo '" + ivs_Arquivo + "'" )
	Return False
End If

Open(w_Aguarde)
w_Aguarde.Title = "Importando arquivo '" + ivs_Arquivo
w_Aguarde.uo_Progress.of_SetMax( ll_FileLength )

ldh_ServerDate = gf_GetServerDate()

Update historico_controle_importacao
	Set dh_inicio	= :ldh_ServerDate
Where cd_filial		= :ll_Filial
	And nr_arquivo	= :ll_Nr_Arquivo
  Using SqlCa;
  
If SqlCa.SqlCode = -1 Then
	This.of_Grava_Log( ivi_Log, SqlCa.sqlerrtext )
	lb_Sucesso = False
Else
	If SqlCa.SqlNRows = 0 Then
		Insert 
		  Into historico_controle_importacao( cd_filial, nr_arquivo, dh_inicio )
			values ( :ll_Filial, :ll_Nr_Arquivo, :ldh_ServerDate )
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			This.of_Grava_Log( ivi_Log, SqlCa.sqlerrtext )
			lb_Sucesso = False
		End If
	End If
End If 

Do While li_Read > 0
	w_Aguarde.Title = "Importando registro " + String( ll_Seq_Lido ) + " do arquivo " + ivs_Arquivo
	
	If Not lb_Sucesso Then Exit

	ls_tipo_registro = MidA( ls_Registro, 1, 2 )

	If ls_tipo_registro = '{"' Then
		ls_Nome_Tabela	= io_Json.of_Busca_Conteudo_Campo( ls_Registro, 'tabela' )
		ll_Seq_Arquivo		= Long( io_Json.of_Busca_Conteudo_Campo( ls_Registro, 'sequencial' ) )
		
		If UPPER(ls_Nome_Tabela) = 'CARTAO_COMPROVANTE_OPERACAO' THEN
			ls_Nome_Tabela = ls_Nome_Tabela
		eND iF

		If ls_Nome_Tabela = 'registro_finalizador' Then
			If ll_Seq_Arquivo <> ll_Seq_Lido Then
				This.of_Grava_Log( ivi_Log, "Total de Registros recebido no arquivo ~r'" + ivs_Arquivo + " est$$HEX1$$e100$$ENDHEX$$ incorreto.")
							 
				lb_Sucesso = False
			End If
			
			Exit		
		End If

		If ll_Seq_Arquivo <> Long( RightA(String( ll_Seq_Lido ), 1) ) Then
			This.of_Grava_Log( ivi_Log, "Sequencial: " + String( ll_Seq_Lido ) + " no arquivo '" + ivs_Arquivo + "' est$$HEX1$$e100$$ENDHEX$$ incorreto.")
			lb_Sucesso = False
			Exit
		End If

		This.of_get_sql_banco( ls_Nome_Tabela )
		This.of_Importa_Json( ls_Nome_Tabela, ls_Registro, ll_Seq_Lido )
	Else
	
		ls_Tabela      		= MidA(ls_Registro, 2, 3)
		ll_Seq_Arquivo		= Long( RightA(ls_Registro, 1) )
		
		If ls_Tabela = '110' Then
			ls_Tabela = ls_tabela
		End If
		
		/*
		"110_VENDA_PBM", &
		"091_VENDA_PBM_PRODUTO", &
		"391_VENDA_PBM_PRODUTO" }
		*/
		If ls_Tabela = "TRA" Then
			ll_Seq_Arquivo	= Long( RightA(ls_Registro, 6) )
			
			If ll_Seq_Arquivo <> ll_Seq_Lido Then
				This.of_Grava_Log( ivi_Log, "Total de Registros recebido no arquivo ~r'" + ivs_Arquivo + " est$$HEX1$$e100$$ENDHEX$$ incorreto.")
							 
				lb_Sucesso = False
			End If
			
			Exit		
		End If
		
		If ll_Seq_Arquivo <> Long( RightA(String(ll_Seq_Lido), 1) ) Then
			This.of_Grava_Log( ivi_Log, "Sequencial: " + String( ll_Seq_Lido ) + " no arquivo '" + ivs_Arquivo + "' est$$HEX1$$e100$$ENDHEX$$ incorreto.")
			lb_Sucesso = False
			Exit
		End If
			
		ll_Linha = ivds_Tabelas.Find( "Left(nm_datastore, 3) = '" + ls_Tabela + "'", 1, ivds_Tabelas.RowCount() )
		
		If ll_Linha = 0 Then
			This.of_Grava_Log( ivi_Log, "Tabela c$$HEX1$$f300$$ENDHEX$$digo '" + ls_Tabela + "' n$$HEX1$$e300$$ENDHEX$$o localizada na lista de tabelas." )
			gf_ge202_envia_email_log( 63, &
											'TC - IMPORTACAO FILIAL - ' +String( ll_Filial ), &
											"<font color='red' size='4'>ATEN$$HEX2$$c700c300$$ENDHEX$$O</font><br /><br />" + &
											"Tabela c$$HEX1$$f300$$ENDHEX$$digo " + ls_Tabela + " n$$HEX1$$e300$$ENDHEX$$o localizada na lista de tabelas." +&
											+ "<br />" )
			lb_Sucesso = False
			Exit
		End If
		
		If ll_Linha < 0 Then
			This.of_Grava_Log( ivi_Log, "Erro no Find. Fun$$HEX2$$e700e300$$ENDHEX$$o: of_Importa(), tabela: " + ls_Tabela + ".")
			lb_Sucesso = False
			Exit
		End If
		
		ls_Nome_Tabela = Mid(ivds_Tabelas.Object.Nm_DataStore[ll_Linha], 5)
		
		This.of_Central_Importa_Registro( ls_Tabela, Lower(ls_Nome_Tabela), ls_Registro, ll_Seq_Lido )
		
	End If // ls_tipo_registro = '{"'
	
	ll_Progress+=li_Read
	
	w_Aguarde.uo_Progress.of_SetProgress( ll_Progress )
	
	If Not FileExists( ivs_Caminho_Arquivo + ivs_Arquivo ) Then
		This.of_Grava_Log( ivi_Log, "Arquivo '" + ivs_Caminho_Arquivo + ivs_Arquivo + "' n$$HEX1$$e300$$ENDHEX$$o localizado durante a importa$$HEX2$$e700e300$$ENDHEX$$o. Poss$$HEX1$$ed00$$ENDHEX$$vel problema de rede ocorrido.")
		lb_Sucesso = False
	End If
	
	li_Read = FileRead(ivi_Arquivo, ref ls_Registro)
	ll_Seq_Lido++
	
	GarbageCollect( )
Loop

If lb_Sucesso Then
	Update historico_controle_importacao
		Set dh_termino	= getdate()
	Where cd_filial 			= :ll_Filial
		And nr_arquivo		= :ll_Nr_Arquivo
		And dh_inicio		= :ldh_serverDate
	  Using SqlCa;
	  
	 If SqlCa.SqlCode = -1 Then
		This.of_Grava_Log( ivi_Log, SqlCa.sqlerrtext )
	End If
End If

FileClose( ivi_Arquivo )
FileClose( ivi_Log )

If lb_Sucesso Then
	lb_Sucesso = This.of_Backup_Importacao( ll_Filial )
End If

If lb_Sucesso Then
	If Not This.of_Central_Atualiza_Ultimo_Arquivo_Imp( ll_Filial ) Then
		lb_Sucesso = False
	End If
End If

If lb_Sucesso Then
	SqlCa.of_Commit()
Else
	SqlCa.of_RollBack()
End If

Close(w_Aguarde)

Return lb_Sucesso
end function

public subroutine of_registra_transferencia_intranet (dc_uo_ds_base pds_transf);DateTime ldh_Emissao

Long ll_Origem
Long ll_Doc
Long ll_Destino

String ls_Especie
String ls_Serie
String ls_Operador
String ls_Argumentos

uo_transacao_remota lo_SD
lo_SD = Create uo_transacao_remota

ll_Origem	= pds_Transf.Object.cd_filial_origem				[1]
ll_Doc    		= pds_Transf.Object.nr_nf							[1]
ls_Especie	= pds_Transf.Object.de_especie					[1]
ls_Serie		= pds_Transf.Object.de_serie						[1]
ll_Destino	= pds_Transf.Object.cd_filial_destino				[1]
ls_Operador	= pds_Transf.Object.Nr_Matricula_Operador	[1]
ldh_Emissao	= pds_Transf.Object.Dh_Emissao					[1]

ls_argumentos =	"cd_filial_origem="	+ String( ll_Origem )	+ &
						"&cd_filial_destino="	+ String( ll_Destino )	+ &
						"&nr_nf="				+ String( ll_Doc )		+ &
						"&de_serie="			+ ls_Serie 				+ &
						"&de_especie="		+ ls_Especie 			+ &
						"&nr_matricula="		+ ls_Operador			+ &
						"&dh_emissao="		+ String( ldh_Emissao, "yyyy-mm-dd hh:mm:ss" )
						
If Lower( SqlCa.DataBase ) = 'central' Then
	lo_SD.of_Executa_Rotina_Intranet( 'registra_saida_transferencia', ls_argumentos )
Else
	lo_SD.of_Executa_Rotina_Intranet( 'registra_saida_transferencia', ls_argumentos, False )
End If

Destroy lo_SD
end subroutine

public function boolean of_central_atualiza_produto_pbm (dc_uo_ds_base lvds_1, long pl_linha, ref string ps_id_pbm);//Fun$$HEX2$$e700e300$$ENDHEX$$o para indicar se o produto vendido fazia parte de algum programa PBM no dia da Venda.
//Essa atualiza$$HEX2$$e700e300$$ENDHEX$$o era feita na loja antes, mas devido a lentid$$HEX1$$e300$$ENDHEX$$o causada, passamos para o TC.
Boolean lb_Sucesso = True

Long lvl_Max, &
     lvl_Linha, &
     lvl_Filial, &
	  lvl_Nota, &
	  lvl_produto, &
	  lvl_Count
	  
String lvs_Especie, &
		lvs_serie, &
		lvs_Chave_Log
		 
Integer lvi_Tipo
		  
lvl_Filial					= lvds_1.Object.cd_filial			[pl_linha]
lvl_Nota					= lvds_1.Object.nr_nf				[pl_linha]
lvs_Especie				= lvds_1.Object.de_especie		[pl_linha]
lvs_Serie					= lvds_1.Object.de_serie			[pl_linha]		
lvl_Produto				= lvds_1.Object.cd_produto		[pl_linha]
	
lvs_Chave_Log = "LINHA: " + String(pl_Linha) + " (" + String(lvl_Filial, "0000") + "-" + &
					 String(lvl_Nota) + "-" + &
					 lvs_Especie + "-" + &
					 lvs_Serie + "-" + &
					 String(lvl_Produto) + ") of_central_atualiza_produto_pbm(dc_uo_ds_base, long, ref string) | "

Select Count(*)
  Into :lvl_Count			
From pbm p 
	INNER JOIN pbm_produto pp
			on pp.cd_pbm = p.cd_pbm	
	INNER JOIN venda_pbm v
			on v.cd_convenio = p.cd_convenio
where pp.cd_produto = :lvl_Produto
and v.cd_filial = :lvl_Filial
and v.nr_nf = :lvl_Nota
and v.de_especie = :lvs_especie
and v.de_serie = :lvs_serie
 Using SqlCa;
 
If SqlCa.SqlCode = -1 Then
	SqlCa.of_LogdbError(ivi_Log, lvs_Chave_Log + "Localiza$$HEX2$$e700e300$$ENDHEX$$o do PBM do Produto.")
	lb_Sucesso = False
End If		

ps_id_PBM = 'N'

If lvl_Count > 0 Then
	ps_id_PBM = 'S'
Else
	//ref chamado 361740
	SELECT COUNT(*)
	INTO :lvl_Count
	FROM promocao_sos ps
		 INNER JOIN promocao_sos_filial psf
			  ON ps.cd_promocao_sos = psf.cd_promocao_sos
		 INNER JOIN promocao_sos_produto psp
			  ON ps.cd_promocao_sos = psp.cd_promocao_sos
		 INNER JOIN venda_pbm v
		 	  ON v.cd_filial			= :lvl_Filial
			 AND v.nr_nf 			= :lvl_Nota
			 AND v.de_especie		= :lvs_especie
			 AND v.de_serie		= :lvs_serie
		 INNER JOIN item_nf_venda i
		 	   ON i.cd_filial			= :lvl_Filial
			 AND i.nr_nf 			= :lvl_Nota
			 AND i.de_especie		= :lvs_especie
			 AND i.de_serie			= :lvs_serie
			 AND i.cd_produto		= :lvl_Produto
	WHERE psf.cd_filial	= :lvl_Filial
	AND psp.cd_produto	= :lvl_Produto
	AND v.cd_convenio 	= 53902
	AND v.dh_venda BETWEEN ps.dh_inicio AND COALESCE( ps.dh_termino, dateadd(day, 1, getdate() ) )
	AND psp.cd_promocao_sos = i.cd_promocao_sos
	AND ps.id_tipo_promocao = 'C'
	USING SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_LogdbError(ivi_Log, lvs_Chave_Log + "Localiza$$HEX2$$e700e300$$ENDHEX$$o do PBM do Produto pela Promocao SOS. ")
		lb_Sucesso = False
	End If		

	If lvl_Count > 0 Then
		ps_id_PBM = 'S'
	End If
End If

Return lb_Sucesso
end function

public function boolean of_central_verifica_pedido_almoxarifado (dc_uo_ds_base pds_datastore, long pl_linha, integer pi_log);Boolean lvb_Sucesso = True

Long	lvl_Filial, &
		lvl_Pedido

String lvs_Arquivo_Dados, &
       	lvs_Arquivo_LOG, &
		 lvs_Chave_Log, &
		 lvs_Situacao		 

lvl_Filial						= ivl_Filial_Importacao
lvl_Pedido					= pds_DataStore.Object.Nr_pedido		[1]

lvs_Chave_Log = "LINHA: " + String(pl_Linha) + " (" +  String(lvl_Filial, "0000") + "-" + &
					 String(lvl_pedido, "000000") + ") "

Select id_situacao
	Into :lvs_Situacao
 From pedido_almoxarifado
 Where cd_filial				= :lvl_Filial
	and nr_pedido			= :lvl_Pedido
 Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If lvs_Situacao = 'C' Then
			lvb_Sucesso = True
		Else
			lvb_Sucesso = False
		End If
	Case 100
		lvb_Sucesso = True		
	Case -1
		SqlCa.of_LogdbError(pi_Log, lvs_Chave_Log + "Localiza$$HEX2$$e700e300$$ENDHEX$$o Situa$$HEX2$$e700e300$$ENDHEX$$o Pedido Almoxarifado '" + String(lvl_Pedido) + "'")
		Return False
End Choose

Return lvb_Sucesso
end function

public function boolean of_loja_novo_leiaute_item_nf_venda (string ps_tabela);/* Consulta se existe o campo nr_sequencial na PK da tabela para utilizar a DS nova */

String ls_Coluna

Choose Case ps_Tabela
	Case	'item_nf_venda', &
			'item_nf_venda_desconto', &
			'item_nf_venda_destino', &
			'registro_venda_manip', &
			'venda_epharma_produto', &
			'venda_pbm_produto', &
			'item_nf_devolucao_venda', &
			'registro_devolucao_venda_manip', &
			'item_nf_devolucao_venda_lote', &
			'item_nf_dev_venda_destino'
			
		SELECT a.attname
		INTO :ls_Coluna
		FROM   pg_index i
		INNER JOIN pg_attribute a 
			  ON a.attrelid = i.indrelid
			AND a.attnum = ANY(i.indkey)
		WHERE i.indrelid = CAST( :ps_Tabela AS regclass )
			AND i.indisprimary
			AND a.attname = 'nr_sequencial'
		USING SqlCa;
		
		Choose Case SqlCa.SqlCode
			Case -1 // False
				//This.of_Grava_Log( ivi_Log, SqlCa.SqlErrText + " :: uo_ge212_troca_dados.of_loja_novo_leiaute_item_nf_venda :: Erro na localizacao do campo nr_sequencial na PK da tabela " + ps_Tabela  )
				
			Case 100 // False
				
			Case 0
				Return True
				
		End Choose
		
End Choose

Return False

end function

public function boolean of_carrega_campos_chave (string ps_cd_tabela, string ps_tabela, ref long pl_campos);Long ll_Rows
Long ll_Idx_Tabela

If Not IsValid( ivds_PK ) Then ivds_PK = Create dc_uo_ds_base

ivds_PK.Reset()

If ivds_PK.of_ChangeDataObject( 'dw_primary_keys_central_idx' ) Then
	
	ll_Rows = ivds_PK.Retrieve( Lower( ps_Tabela ) )
	
	If ll_Rows < 0 Then
		This.of_Grava_Log( ivi_Log, "Erro ao recuperar as informa$$HEX2$$e700f500$$ENDHEX$$es da 'dw_primary_keys_central_idx', tabela: " + ps_Tabela + "." )
		Return False
	End If
	
	If ll_Rows = 0 Then
		This.of_Grava_Log( ivi_Log, "Nenhuma linha recuparada na 'dw_primary_keys_central_idx', tabela: " + ps_Tabela + "." )
		Return False
	End If
	//
	ll_Idx_Tabela = ivds_PK.Object.IndId[1]
	
	//Feito para casos que no Log Exportacao as chaves s$$HEX1$$e300$$ENDHEX$$o diferentes das chaves na filial.
	If ps_Tabela = "PROMOCAO_SOS_PRODUTO" Then
		ll_Idx_Tabela = 3
	End If
	
	/* Recupera o nomes das colunas que comp$$HEX1$$f500$$ENDHEX$$es a chave prim$$HEX1$$e100$$ENDHEX$$ria */
	If ivds_PK.of_ChangeDataObject( 'dw_primary_keys_central' ) Then
		
		
		Choose Case ps_Cd_Tabela
			// ds_301_item_nf_dev_venda_destino
			// ds_352_item_nf_venda_desconto
			// ds_381_item_nf_venda
			// ds_385_item_nf_devolucao_venda
			// ds_391_venda_pbm_produto
			// ds_398_item_nf_venda_destino
			Case '301', '352', '381', '385', '391', '398'
				ll_Idx_Tabela = 0
				ivds_PK.InsertRow( 6 )
				ivds_PK.Object.nm_coluna[1] = 'cd_filial'
				ivds_PK.Object.nm_coluna[2] = 'nr_nf'						
				ivds_PK.Object.nm_coluna[3] = 'de_especie'
				ivds_PK.Object.nm_coluna[4] = 'de_serie'
				ivds_PK.Object.nm_coluna[5] = 'nr_sequencial'
				ivds_PK.Object.nm_coluna[6] = 'cd_produto'
				ll_Rows = ivds_PK.RowCount( )

			Case '320', '340' // ds_320_registro_venda_manip, ds_340_registro_devolucao_venda_manip
				ll_Idx_Tabela = 0
				ivds_PK.InsertRow( 7 )
				ivds_PK.Object.nm_coluna[1] = 'cd_filial'
				ivds_PK.Object.nm_coluna[2] = 'nr_nf'						
				ivds_PK.Object.nm_coluna[3] = 'de_especie'
				ivds_PK.Object.nm_coluna[4] = 'de_serie'
				ivds_PK.Object.nm_coluna[5] = 'nr_sequencial'
				ivds_PK.Object.nm_coluna[6] = 'cd_produto'
				ivds_PK.Object.nm_coluna[7] = 'nr_registro'
				ll_Rows = ivds_PK.RowCount( )
				
			Case '337' // ds_337_item_nf_devolucao_venda_lote
				ll_Idx_Tabela = 0
				ivds_PK.InsertRow( 7 )
				ivds_PK.Object.nm_coluna[1] = 'cd_filial'
				ivds_PK.Object.nm_coluna[2] = 'nr_nf'						
				ivds_PK.Object.nm_coluna[3] = 'de_especie'
				ivds_PK.Object.nm_coluna[4] = 'de_serie'
				ivds_PK.Object.nm_coluna[5] = 'nr_sequencial'
				ivds_PK.Object.nm_coluna[6] = 'cd_produto'
				ivds_PK.Object.nm_coluna[7] = 'nr_lote'
				ll_Rows = ivds_PK.RowCount( )

			Case Else				
				If ps_Tabela = "PROMOCAO_SOS_PRODUTO" Then
					ivds_PK.InsertRow(3)
					ivds_PK.Object.nm_coluna[1] = 'cd_promocao_sos'
					ivds_PK.Object.nm_coluna[2] = 'cd_filial'						
					ivds_PK.Object.nm_coluna[3] = 'cd_produto'			
					ll_Rows = ivds_PK.RowCount( )
				Else
					ll_Rows = ivds_PK.Retrieve( ll_Idx_Tabela, Lower( ps_Tabela ) )
				End If
			
		End Choose

		If ll_Rows < 0 Then
			This.of_Grava_Log( ivi_Log, "Erro ao recuperar as informa$$HEX2$$e700f500$$ENDHEX$$es da 'dw_primary_keys_central', tabela: " + ps_Tabela + "." )
			Return False
		End If
		
		If ll_Rows = 0 Then
			This.of_Grava_Log( ivi_Log, "Nenhuma linha recuparada na 'dw_primary_keys_central', tabela: " + ps_Tabela + "." )
			Return False
		End If
		
		pl_Campos = ll_Rows
	End If
End If

Return True
end function

public function boolean of_syntaxfromsql (dc_uo_ds_base pds_retrieve, string ps_sql);string ERRORS

string dwsyntax_str

Try

	dwsyntax_str = SQLCA.SyntaxFromSQL(	ps_Sql, "style(type=grid)", ERRORS )
	
	IF Len(ERRORS) > 0 THEN
		This.of_Grava_Log( ivi_Log, 'of_SyntaxFromSql( dc_uo_ds_base, string ) - SQLCA.SyntaxFromSQL : ' +  ERRORS + ' : SQL: ' + ps_sql )
		RETURN FALSE
	END IF
	
	pds_Retrieve.Create( dwsyntax_str, ERRORS )
	
	IF Len( ERRORS ) > 0 THEN
		This.of_Grava_Log( ivi_Log, 'of_SyntaxFromSql( dc_uo_ds_base, string ) - pds_Retrieve.Create : ' +  ERRORS + ' : SQL: ' + ps_sql )
		RETURN FALSE
	END IF
	
	pds_Retrieve.of_SetTransObject( SqlCa )
	
	pds_Retrieve.Object.DataWindow.Table.UpdateWhere = 0 // key columns
	pds_Retrieve.Object.DataWindow.Table.UpdateKeyInPlace = 'yes' // use update
	
	Return True
	
Catch( runtimeerror ru )
	This.of_Grava_Log( ivi_Log, ru.getmessage( ) + ' : ' + ps_sql )
	
End Try
end function

public function string of_monta_where_chave_log (string ps_sql, string ps_chave_log);Long ll_Pos
Long ll_Pos_Chave

String ls_Valor

ll_Pos = PosA( ps_Sql, '%VAR%' )

Do While ll_Pos > 0
	ll_Pos_Chave = PosA( ps_Chave_Log, '@#!' ) -1
	
	If ll_Pos_Chave = -1 Then
		ll_Pos_Chave = LenA( ps_Chave_Log )
	End If
	
	ls_Valor = MidA( ps_Chave_Log, 1, ll_Pos_Chave )
	
	ps_Sql = MidA( ps_Sql, 1, ll_Pos -1 ) + ls_Valor + MidA( ps_Sql, ll_Pos + 5 ) // Substitui a vari$$HEX1$$e100$$ENDHEX$$vel pelo valor	
	ll_Pos = PosA( ps_Sql, '%VAR%', ll_Pos )
	
	ps_Chave_Log = MidA( ps_Chave_Log, ll_Pos_Chave + 4 )
Loop

Return ps_Sql // Retorna o sql alterado
end function

public function string of_captura_valor_campo_dw (dc_uo_ds_base pds_retrieve, string ps_tipo, string ps_objeto, ref string ps_valor);Try
	Choose Case ps_Tipo
		Case "DATE"
			ps_Valor = String(pds_Retrieve.GetItemDate( 1, ps_Objeto ) )
			
			If IsNull( ps_Valor ) Then
				ps_Valor = "null"
			Else
				ps_Valor = LeftA( String(pds_Retrieve.GetItemDate( 1, ps_Objeto ), "ddmmyyyy" ), 8)
				ps_Valor = ps_Valor + "00:00:00"
			End If
			
		Case "DATETIME", "TIMESTAMP"
			ps_Valor = String(pds_Retrieve.GetItemDateTime( 1, ps_Objeto ) )
			
		Case "DECIMAL", "REAL"
			ps_Valor = String( pds_Retrieve.GetItemDecimal( 1, ps_Objeto ) )
			ps_Valor = gf_Replace( ps_Valor, ',', '.', 0 )
			
		Case "INT", "LONG", "NUMBER", "ULONG"
			ps_Valor = String(pds_Retrieve.GetItemNumber( 1, ps_Objeto ) )
			
		Case "TIME"
			ps_Valor = String(pds_Retrieve.GetItemTime( 1, ps_Objeto ) )
			
		Case Else
			If Mid( ps_Tipo, 1, 4 ) = "CHAR" Then
				ps_Valor	=	String( pds_Retrieve.GetItemString( 1, ps_Objeto ) )
				ps_Valor	=	gf_Replace( ps_Valor, "~r", " ", 0 )
				ps_Valor	=	gf_Replace( ps_Valor, "~n", " ", 0 )
			End If
			
			If Mid( ps_Tipo, 1, 7 ) = "DECIMAL" Or Mid( ps_Tipo, 1, 4 ) =  "REAL" Then
				ps_Valor = String( pds_Retrieve.GetItemDecimal( 1, ps_Objeto ) )
				ps_Valor = gf_Replace( ps_Valor, ',', '.', 0 )
			End If
	End Choose
	
	If IsNull( ps_Valor ) Then ps_Valor = "null"
	
Catch( RuntimeError ex )
	MessageBox("Ex", ex.getMessage( ) )
End Try

Return ps_Valor
end function

public function boolean of_exporta_json (string ps_tabela, string ps_chave_log, string ps_atualizacao);Long ll_Retrieve
Long ll_Colunas, ll_Loop
Long ll_Pos, ll_ate
Long ll_Find

String ls_tabela
String ls_Sql
String ls_Objeto
String ls_Tipo
String ls_Valor
String ls_Texto
String ls_Aux

String ls_Tabelas_FROM[]

Integer li_Contador_FROM
integer i

Try
	dc_uo_ds_base lds_retrieve
	lds_retrieve = Create dc_uo_ds_base
	lds_retrieve.of_changedataobject( 'ds_ge212_dinamica' )
	
	ps_tabela = Upper( ps_tabela )
	
	ll_Find = This.ids_Relacao_Tabelas.Find( "nm_tabela = '" + ps_Tabela + "'", 1,  This.ids_Relacao_Tabelas.RowCount( ) )
	ls_Sql = This.ids_Relacao_Tabelas.Object.De_Sql[ ll_Find ]
	
	If ps_Atualizacao = 'E' Then
		ls_Texto = of_Monta_Registro_Exclusao( ps_Tabela, ls_Sql, ps_Chave_Log )
	Else
		ls_Sql = of_Monta_Where_Chave_Log( ls_Sql, ps_Chave_Log )	
		
		If Not of_SyntaxFromSQL( lds_retrieve, String( ls_Sql ) ) Then
			Return False
		End If
		
		If PosA( UPPER(ls_Sql), 'JOIN ' ) > 0 Then	
			ls_Aux = ls_sql
			li_Contador_FROM++
		
			Do	
				ll_pos = 0
				ll_ate = 0
				If li_Contador_FROM = 1 Then
					ll_pos = PosA( UPPER(ls_Sql), 'FROM' ) + 5
					ll_ate  = PosA( UPPER(ls_Sql), 'AS ', ll_pos )
					ls_Tabelas_FROM[ li_Contador_FROM ] = mid( ls_sql, ll_pos,  ( (ll_ate - 1) - ll_pos ) )
					ls_Aux = Mid( ls_sql, ll_ate +2 )
				Else			
					ll_pos = PosA( UPPER(ls_Aux), 'JOIN' )
					If ll_pos > 0 Then
						ll_Pos += 5
						
						ll_ate  = PosA( UPPER(ls_Aux), 'AS ', ll_pos )					
						ls_Tabelas_FROM[ li_Contador_FROM ] = mid( ls_Aux, ll_pos,  ( (ll_ate - 1) - ll_pos ) )
						ls_Aux = Mid( ls_Aux, ll_ate +2 )
					End If
				End If
				
				li_Contador_FROM++
				
			LOOP WHILE ll_pos > 0
			
		End If
		
		ll_Retrieve = lds_Retrieve.Retrieve( )
		
		If ll_Retrieve = 0 Then
			// Encontrou no log_exportacao mas n$$HEX1$$e300$$ENDHEX$$o na tabela de origem
			Return True
		Else		
			ll_Colunas	= Long( lds_Retrieve.Describe( "DataWindow.Column.Count" ) )
				
			For ll_Loop = 1 To ll_Colunas
				ls_Objeto	= lds_Retrieve.Describe( "#" + String(ll_Loop) + ".Name" )
				
				ls_Tipo		= Upper( lds_Retrieve.Describe( ls_Objeto + ".ColType" ) )
				
				If ls_Tipo = "!" Then
					If UPPER(gvo_Aplicacao.ivs_database) = 'SYBASE' Then			
						If  UPPERBOUND( ls_Tabelas_FROM[]) > 0 Then
							FOR i = 1 to UPPERBOUND( ls_Tabelas_FROM[] )
								If PosA( ls_Objeto, Lower(ls_Tabelas_FROM[i]) ) = 0 then
									continue
								End if
			
								ls_Objeto 	= gf_Replace( ls_Objeto, Lower(ls_Tabelas_FROM[i]) + "_", '', 1 )
								ls_tabela 	= ls_Tabelas_FROM[ i ]
								
								select	 top 1 t.name
									into :ls_Tipo
									from sysobjects o
									inner join syscolumns c 
											on c.id = o.id
									inner join systypes t 
											on t.usertype = c.usertype
									where o.type = 'U'
									and o.name = :ls_tabela
									and c.name = :ls_Objeto
								Using SqlCa;
								
								If SqlCa.SqlCode = -1 Then 
									SqlCa.of_MsgDbError("Erro ao localizar o tipo da coluna na tabela sysobjects")
									Exit
								End If
								
								If SqlCa.SqlCode = 0 Then Exit
								
							Next
							
						End If  //UPPERBOUND( ls_Tabelas_FROM[]) > 0 Then
					End If	   //If UPPER(gvo_Aplicacao.ivs_database) = 'SYBASE' Then
				End If		//If ls_Tipo = "!" Then
								
				of_Captura_Valor_Campo_DW( lds_Retrieve, ls_Tipo, ls_Objeto, Ref ls_Valor  )
				
				FOR i = 1 to UPPERBOUND( ls_Tabelas_FROM[] )
					ls_Objeto = gf_Replace( ls_Objeto, Lower(ls_Tabelas_FROM[i]) + "_", '', 1 )
				NEXT
				
				ls_Tipo = Upper( ls_Tipo ) 
				
				If ls_Tipo = 'DATE' Then
					If ls_Valor <> 'null' Then
						ls_Valor = Left( ls_Valor, 2 ) + '/' + Mid( ls_Valor, 3, 2 ) + '/' + Mid( ls_Valor, 5, 4 )
					End If
				End If
				
				If Mid( ls_Tipo, 1, 7 ) = "DECIMAL" Or Mid( ls_Tipo, 1, 4 ) = "REAL" Then
					ls_Tipo = "DECIMAL"
				End If
			
				Choose Case ls_Tipo
					Case "DECIMAL", "REAL", "INT", "LONG", "ULONG", "NUMBER"
						ls_Texto += '"' + ls_Objeto + '":' + Trim( ls_Valor ) + ','
						//
					Case Else
						If ls_Valor = 'null' Then
							ls_Texto += '"' + ls_Objeto + '":' + Trim( ls_Valor ) + ','
						Else
							ls_Texto += '"' + ls_Objeto + '":"' + Trim( ls_Valor ) + '",'
						End If
				End Choose				
			Next
		End If
	End If
	
	ps_Tabela = This.of_nome_tabela( ls_Sql )
	
	// Remove o $$HEX1$$fa00$$ENDHEX$$ltimo caracterer
	ls_Texto = Mid( ls_Texto, 1, Len( ls_Texto ) -1 )
	
	ls_Texto = '{"sequencial":"' + RightA( String( ivl_Sequencial ), 1 ) + &
						'","tabela":"' + Lower( ps_Tabela ) + '","atualizacao":"' + &
					ps_Atualizacao + '",' + ls_Texto + '}'
					
	ivl_Sequencial ++				
						
	FileWrite( ivi_Arquivo, ls_Texto )
	
	Return True
	
Catch (runtimeerror ru)
	Messagebox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", ru.getMessage( ), StopSign! )
	
Finally
	If IsValid( lds_Retrieve ) Then Destroy lds_Retrieve
	GarbageCollect( )
End Try
end function

public function string of_nome_tabela (string ps_sql);Long ll_Pos

ps_Sql = Upper( ps_Sql )

// Pega a parte ap$$HEX1$$f300$$ENDHEX$$s o FROM
ll_Pos		= Pos( Upper( ps_Sql ), ' FROM ' )
ps_Sql	= Mid( ps_Sql, ll_Pos + 5 )

// Pega a parte at$$HEX1$$e900$$ENDHEX$$ o primeiro WHERE
ll_Pos = Pos( Upper( ps_Sql ), ' WHERE ' )

If ll_Pos = 0 Then ll_Pos = Len( ps_Sql )

ps_Sql = Trim( Mid( ps_Sql, 1, ll_Pos - 1 ) )

// Procura se h$$HEX1$$e100$$ENDHEX$$ join, se houver, pega somente o que antecede o primeiro Join
ll_Pos = Pos( Upper( ps_Sql ), ' INNER ' )

If ll_Pos = 0 Then
	ll_Pos = Pos( Upper( ps_Sql ), ' LEFT ' )
	
	If ll_Pos = 0 Then
		ll_Pos = Pos( Upper( ps_Sql ), ' RIGHT ' )		
	End If
End If

If ll_Pos > 0 Then
	ps_Sql = Trim( Mid( ps_Sql, 1, ll_Pos - 1 ) )
End If


// Procura se existe apelido
ll_Pos = Pos( Upper( ps_Sql ), ' AS ' )

If ll_Pos > 0 Then
	ps_Sql = Trim( Mid( ps_Sql, ll_Pos + 4 ) )
Else
	ll_Pos = Pos( Upper( ps_Sql ), ' ' )
	
	If ll_Pos > 0 Then
		ps_Sql = Trim( Mid( ps_Sql, ll_Pos ) )
	End If
End If

Return Lower( ps_Sql )
end function

public function string of_escape_single_quote (string ps_texto);Integer li_Pos

ps_Texto = gf_Replace( ps_Texto, "'", "@$&*", 0 )
ps_Texto = gf_Replace( ps_Texto, "@$&*", "''", 0 )


Return ps_Texto
end function

public subroutine of_registra_transferencia_intranet (string ps_json);DateTime ldh_Emissao

Long ll_Origem
Long ll_Doc
Long ll_Destino

String ls_Especie
String ls_Serie
String ls_Operador
String ls_Argumentos

uo_transacao_remota lo_SD
lo_SD = Create uo_transacao_remota

ll_Origem		= Long( io_Json.of_busca_conteudo_campo( ps_Json, 'cd_filial_origem', False ) )
ll_Doc				= Long( io_Json.of_busca_conteudo_campo( ps_Json, 'nr_nf', False ) )
ls_Especie		= io_Json.of_busca_conteudo_campo( ps_Json, 'de_especie', False )
ls_Serie			= io_Json.of_busca_conteudo_campo( ps_Json, 'de_serie', False )
ll_Destino		= Long( io_Json.of_busca_conteudo_campo( ps_Json, 'cd_filial_destino', False ) )
ls_Operador		= io_Json.of_busca_conteudo_campo( ps_Json, 'nr_matricula_operador', False )
ldh_Emissao		= DateTime( io_Json.of_busca_conteudo_campo( ps_Json, 'dh_emissao', False ) )

ls_argumentos =	"cd_filial_origem="	+ String( ll_Origem )	+ &
						"&cd_filial_destino="	+ String( ll_Destino )	+ &
						"&nr_nf="				+ String( ll_Doc )		+ &
						"&de_serie="			+ ls_Serie 				+ &
						"&de_especie="		+ ls_Especie 			+ &
						"&nr_matricula="		+ ls_Operador			+ &
						"&dh_emissao="		+ String( ldh_Emissao, "yyyy-mm-dd hh:mm:ss" )
						
If Lower( SqlCa.DataBase ) = 'central' Then
	lo_SD.of_Executa_Rotina_Intranet( 'registra_saida_transferencia', ls_argumentos )
Else
	lo_SD.of_Executa_Rotina_Intranet( 'registra_saida_transferencia', ls_argumentos, False )
End If

Destroy lo_SD
end subroutine

public function boolean of_insere_aspas_where ();/* Insere aspas simples nos campos da cl$$HEX1$$e100$$ENDHEX$$usula where quando necess$$HEX1$$e100$$ENDHEX$$rio */
Long ll_Retrieve
Long ll_Pos_Where
Long ll_Pos_Var
Long ll_Loop = 1

Long ll_Linha_Rel_Tabela
Long ll_Linhas_Rel_Tabela

String ls_Sql
String ls_Sql_Original
String ls_Tipo
String ls_Coluna_Where

dc_uo_ds_base lds_Datastore

Try
	ll_Linhas_Rel_Tabela = This.ids_Relacao_Tabelas.RowCount( )
	
	For ll_Linha_Rel_Tabela = 1 To ll_Linhas_Rel_Tabela
		
		ls_Sql_Original = String( This.ids_Relacao_Tabelas.GetItemString( ll_Linha_Rel_Tabela, 'de_sql' ) )
				
		//gvo_Aplicacao.of_Grava_Log( "Erro no retrieve of_insere_aspas_where( ). | SQL Inicio: " + ls_Sql_Original + " | Linha DS: " + String( ll_Linha_Rel_Tabela ) ) // DEBUG

		ll_Pos_Where = Pos( ls_Sql_Original, 'WHERE' )
		
		If ll_Pos_Where = 0 Then Continue
		
		lds_Datastore = Create dc_uo_ds_base
	
		ls_Sql = Mid( ls_Sql_Original, 1, ll_Pos_Where -1 ) + ' WHERE 1=2'
		
		If Not of_SyntaxFromSQL( lds_Datastore, String( ls_Sql ) ) Then
			Return False
		End If
		
		ll_Retrieve = lds_Datastore.Retrieve( )
		
		If ll_Retrieve < 0 Then
			This.of_Grava_Log( ivi_Log, "Erro no retrieve of_insere_aspas_where( ).  | SQL: " + ls_Sql )
			Return False
		End If
		
		ll_Pos_Where	= PosA( Upper( ls_Sql_Original ), 'WHERE' ) + 6
		ll_Pos_Var		= PosA( Upper( ls_Sql_Original ), '=', ll_Pos_Where )
		
		Do While ll_Pos_Where > 5
			ls_Coluna_Where	= Trim( MidA( ls_Sql_Original, ll_Pos_Where, ll_Pos_Var - 1 - ( ll_Pos_Where ) ) )
			
			ls_Tipo = Upper( lds_Datastore.Describe( ls_Coluna_Where + ".ColType" ) )
			
			If Mid( ls_Tipo, 1, 7 ) = "DECIMAL" Or Mid( ls_Tipo, 1, 4 ) = "REAL" Then
				ls_Tipo = "DECIMAL"
			End If
		
			Choose Case ls_Tipo
				Case "DECIMAL", "REAL", "INT", "LONG", "ULONG", "NUMBER", "UUID", "!"
					//
				Case Else
					ls_Sql				= Mid( ls_Sql_Original, ll_Pos_Var + 1 )
					ls_Sql_Original	= Mid( ls_Sql_Original, 1, ll_Pos_Var ) + gf_Replace( ls_Sql, '%VAR%', "'%VAR%'", 1 )
			End Choose
			
			ll_Loop ++
			ll_Pos_Where	= PosA( Upper( ls_Sql_Original ), ' AND ', ll_Pos_Where ) + 5
			ll_Pos_Var		= PosA( Upper( ls_Sql_Original ), '=', ll_Pos_Where )
		Loop
		
		This.ids_Relacao_Tabelas.Object.De_Sql[ ll_Linha_Rel_Tabela ] = ls_Sql_Original
		
		//gvo_Aplicacao.of_Grava_Log( "Erro no retrieve of_insere_aspas_where( ). | SQL Fim: " + ls_Sql_Original + " | Linha DS: " + String( ll_Linha_Rel_Tabela ) ) // DEBUG

		Destroy lds_Datastore
	Next
	
	Return True
	
Catch( runtimeerror ru )
	This.of_Grava_Log( ivi_Log, ru.getMessage( ) )
	Return False
Finally
	If IsValid( lds_Datastore ) Then Destroy lds_Datastore
End Try
end function

public function boolean of_carrega_tabela_json (string ps_tabela);Integer li_Linhas_Retrieve

String ls_Sql

Try
	If IsValid( This.ids_Relacao_Tabelas ) Then Destroy This.ids_Relacao_Tabelas
	
	ids_Relacao_Tabelas = Create dc_uo_ds_base
	
	If Not This.ids_Relacao_Tabelas.of_changedataobject( '_ds_ge212_relacao_tabela' ) Then
		This.of_Grava_Log( This.ivi_Log, "Erro no of_changedataobject( '_ds_ge212_relacao_tabela' ) em uo_ge212_troca_dados.of_carrega_tabela_comum()" )
		Return False
	End If
	
	// Quando for importa$$HEX2$$e700e300$$ENDHEX$$o no troca dados loja, carrega todas as tabelas, n$$HEX1$$e300$$ENDHEX$$o importando se $$HEX1$$e900$$ENDHEX$$ arquivo comum ou filial
	If gvo_Aplicacao.ivo_Seguranca.cd_Sistema = 'TL' and Lower( ps_tabela ) <> 'relacao_tabelas_tl' Then
		ls_Sql = "SELECT 'A' as id_tipo, nm_tabela, nr_ordem, de_sql FROM relacao_tabela_comum WHERE de_sql IS NOT NULL AND CHAR_LENGTH( de_sql ) > 6 UNION ALL SELECT 'A' as id_tipo, CASE nm_tabela WHEN 'PRODUTO_GERAL' THEN 'PRODUTO_GERAL_UF' ELSE nm_tabela END AS nm_tabela, nr_ordem, de_sql FROM relacao_tabela_filial WHERE de_sql IS NOT NULL AND CHAR_LENGTH( de_sql ) > 6 ORDER BY nm_tabela ASC;"
	Else
		ls_Sql = "SELECT 'A' as id_tipo, nm_tabela, nr_ordem, de_sql FROM " + ps_tabela + " WHERE de_sql IS NOT NULL AND CHAR_LENGTH( de_sql ) > 6 ORDER BY nm_tabela ASC"
	End If
	//
	
	This.ids_Relacao_Tabelas.of_ChangeSql( ls_Sql )
	
	li_Linhas_Retrieve = This.ids_Relacao_Tabelas.Retrieve( )
	
	//gvo_Aplicacao.of_Grava_Log( "uo_ge212_troca_dados.of_carrega_tabela_json( string ) | SQL: " + ls_Sql + " | Retrieve: " + String( li_Linhas_Retrieve ) + " linhas" ) // DEBUG
	
	If li_Linhas_Retrieve = -1 Then
		This.of_Grava_Log( This.ivi_Log, "Erro no Retrieve da ids_Relacao_Tabelas em uo_ge212_troca_dados.of_carrega_tabela_comum(). ERRO: " + This.ids_Relacao_Tabelas.ivo_dbError.of_Msg_Sybase() + " SQL: " + This.ids_Relacao_Tabelas.of_GetSql( ) )
		Return False
	End If
	
	If Not This.of_Insere_Aspas_Where( ) Then
		Return False
	End If
	
	Return True
	
Catch( runtimeerror ru )
	This.of_Grava_Log( This.ivi_Log, ru.getMessage( ) + " uo_ge212_troca_dados.of_carrega_tabela_json( string )"  )
End Try
end function

public function boolean of_get_sql_banco (string ps_tabela_exporta);Long ll_Find

String ls_Find
String ls_Sql

ps_Tabela_Exporta	= Trim( Upper( ps_Tabela_Exporta ) )

ls_Find = "trim( nm_tabela ) = '" + ps_Tabela_Exporta + "'"

ll_Find = This.ids_Relacao_Tabelas.Find( ls_Find, 1, This.ids_Relacao_Tabelas.RowCount( ) )

If ll_Find = -1 Then
	Sqlca.of_MsgDbError( "Erro no find (" + ls_Find + ") em uo_ge212_troca_dados.of_get_sql_banco( string )" )
	Return False
End If

If ll_Find = 0 Then
	SetNull( This.is_Sql_Banco )
Else
	ls_Sql = String( This.ids_Relacao_Tabelas.GetItemString( ll_Find, 'de_sql' ) )
	This.is_Sql_Banco = ls_Sql
End If

If IsNull( ls_Sql ) Then
	ls_Sql = 'NULL'
End If

//gvo_Aplicacao.of_Grava_Log( "uo_ge212_troca_dados.of_get_sql_banco( string ) | SQL: " + ls_Sql + " | String Find: " + ls_Find + " | Linha Retornada: " + String( ll_Find ) ) // DEBUG

Return True
end function

public function boolean of_central_importa_movto_titulo_receber (dc_uo_ds_base lvds_1, string ps_linha);Boolean lvb_Commit = True

Long lvl_Max, &
     lvl_Linha, &
     lvl_Filial_Movto, &
	  lvl_Movto
	  
String lvs_Arquivo_Dados, &
       lvs_Arquivo_LOG, &
		 lvs_Chave_Log, &
		 lvs_Titulo, &
		 lvs_Estorno, &
		 lvs_Historico, &
		 lvs_Responsavel, &
		 lvs_Liberacao_Juros, &
		 lvs_Recibo, &
		 lvs_Achou, &
		 lvs_Cliente
		 
Integer lvi_Tipo

DateTime lvdh_Movto, &
         lvdh_Credito, &
         lvdh_Sistema
			
Decimal lvdc_Valor_Movto, &
        lvdc_Juros, &
        lvdc_Desconto, &
        lvdc_Despesa
		  
lvs_Titulo				= lvds_1.Object.nr_titulo							[1]
lvl_Filial_Movto			= lvds_1.Object.cd_filial_movimento			[1]
lvl_Movto					= lvds_1.Object.nr_movimento					[1]
lvi_Tipo					= lvds_1.Object.cd_tipo_movimento			[1]
lvs_Responsavel		= lvds_1.Object.nr_matricula_responsavel	[1]		
lvdh_Sistema			= lvds_1.Object.dh_sistema						[1]
lvdh_Movto				= lvds_1.Object.dh_movimento					[1]
lvdh_Credito				= lvds_1.Object.dh_credito						[1]
lvdc_Valor_Movto		= lvds_1.Object.vl_movimento					[1]
lvdc_Juros				= lvds_1.Object.vl_juros_recebidos			[1] 
lvdc_Desconto			= lvds_1.Object.vl_desconto_concedido		[1]
lvdc_Despesa			= lvds_1.Object.vl_despesas_recebidas		[1]
lvs_Estorno				= lvds_1.Object.id_estorno						[1]
lvs_Historico				= lvds_1.Object.de_historico					[1]
lvs_Recibo				= lvds_1.Object.nr_recibo_cobranca			[1]
lvs_Liberacao_Juros	= lvds_1.Object.nr_matric_juros_desconto	[1]
		
// Elimina o hor$$HEX1$$e100$$ENDHEX$$rio da data do movimento
lvdh_Movto = DateTime(Date(lvdh_Movto))
		
lvs_Chave_Log = "LINHA: " + ps_Linha + " (" + lvs_Titulo + "-" + &
					 String(lvl_Filial_Movto, "0000") + "-" + &
					 String(lvl_Movto, "0000") + ") "
		
 Select nr_titulo
   Into :lvs_Achou
  From movimento_titulo_receber
Where nr_titulo           		= :lvs_Titulo
  	and cd_filial_movimento	= :lvl_Filial_Movto
  	and nr_movimento        	= :lvl_Movto
  Using SqlCa;
		
Choose Case SqlCa.SqlCode
	Case 0				
	Case 100
		
		Select cd_cliente Into :lvs_Cliente
		  From titulo_receber
		 Where nr_titulo = :lvs_Titulo
		 Using SqlCa;
		 
		Choose Case SqlCa.SqlCode
			Case 100
				SqlCa.of_LogdbError(ivi_Log, lvs_Chave_Log + "Localiza$$HEX2$$e700e300$$ENDHEX$$o do t$$HEX1$$ed00$$ENDHEX$$tulo a receber")
				lvb_Commit = False
				
			Case -1
				 SqlCa.of_LogdbError(ivi_Log, lvs_Chave_Log + "Localiza$$HEX2$$e700e300$$ENDHEX$$o do movimento de cr$$HEX1$$e900$$ENDHEX$$dito online")

			Case 0
				 If Not IsNull(lvs_Cliente) Then
					 Delete From movimento_credito_online
					  Where cd_cliente 		  = :lvs_Cliente
						 And cd_filial  		  = :lvl_Filial_Movto
						 And dh_movimento		  = :lvdh_Movto
						 And id_tipo_movimento = 4
						 And vl_movimento		  = ( :lvdc_Valor_Movto - :lvdc_Juros - :lvdc_Despesa + :lvdc_Desconto )
						 And nr_documento		  = :lvs_Titulo
					  Using SqlCa;
					  
					 If SqlCa.SqlCode = -1 Then
						 SqlCa.of_LogdbError(ivi_Log, lvs_Chave_Log + "Exclus$$HEX1$$e300$$ENDHEX$$o do movimento de cr$$HEX1$$e900$$ENDHEX$$dito online")
						 lvb_Commit = False
					 End If
				End If
		End Choose
		
		If lvb_Commit Then
			Insert Into movimento_titulo_receber (nr_titulo,   
															  cd_filial_movimento,   
															  nr_movimento,   
															  cd_tipo_movimento,   
															  nr_matricula_responsavel,   
															  dh_sistema,   
															  dh_movimento,   
															  dh_credito,   
															  vl_movimento,   
															  vl_juros_recebidos,   
															  vl_desconto_concedido,   
															  vl_despesas_recebidas,   
															  id_estorno,   
															  de_historico,   
															  nr_recibo_cobranca,   
															  nr_matric_juros_desconto)
			Values (:lvs_Titulo,   
					  :lvl_Filial_Movto,   
					  :lvl_Movto,   
					  :lvi_Tipo,   
					  :lvs_Responsavel,   
					  :lvdh_Sistema,   
					  :lvdh_Movto,   
					  :lvdh_Credito,   
					  :lvdc_Valor_Movto,   
					  :lvdc_Juros,   
					  :lvdc_Desconto,   
					  :lvdc_Despesa,   
					  :lvs_Estorno,   
					  :lvs_Historico,   
					  :lvs_Recibo,   
					  :lvs_Liberacao_Juros)
			Using SqlCa;
	
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_LogdbError(ivi_Log, lvs_Chave_Log + "Inclus$$HEX1$$e300$$ENDHEX$$o")
			lvb_Commit = False
		End If
	End If

	Case -1
		SqlCa.of_LogdbError(ivi_Log, lvs_Chave_Log + "Localiza$$HEX2$$e700e300$$ENDHEX$$o")
End Choose

Return lvb_Commit
end function

public function boolean of_importa_json (string ps_tabela, string ps_registro, long pl_linha);Boolean lb_Sucesso = True
Boolean lb_Atualiza = True
Boolean lb_Campo_Sap = False

/* Transforma$$HEX2$$e700e300$$ENDHEX$$o filial destino de 534 -> 1 */
Boolean lb_Altera_Filial_Destino_Perini = False
/********************************/

Long ll_Loop
Long ll_Colunas
Long ll_Linha
Long ll_Filial
Long ll_Pos_Where
Long ll_Pos_Var
Long ll_Retrieve
Long ll_Pos_Inicio
Long ll_Find

String ls_Objeto
String ls_Tipo
String ls_Valor_Campo
String ls_Valor_Campo_sap
String ls_DataStore
String ls_Id_Atualizacao
String ls_Chave_Log
String ls_Sql
String ls_Sql_Insert
String ls_Sql_Update
String ls_Colunas_Insert = ''
String ls_Valores_Insert = ''
String ls_Campos_Valores_Update = ''
String ls_Where

DateTime ltd_auxiliar, ldt_Data_Registro

long ll_Convenio
long ll_PBM

Integer li_Existe
Integer li_Aux

String ls_Conveniado


ls_DataStore = 'ds_ge212_dinamica'

Try
	
	//A tabela Cart$$HEX1$$e300$$ENDHEX$$o comprovante Opera$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o possui SQL definido na base.
	//IMporta com base nos valores do jason enviados pela loja.
	If IsNull( This.is_Sql_Banco ) Then
		If Upper( ps_Tabela ) <> 'CARTAO_COMPROVANTE_OPERACAO' Then
			This.of_Grava_Log( ivi_Log, "Tabela '" + ps_Tabela + "' n$$HEX1$$e300$$ENDHEX$$o prevista." )
			Return True
		End If		
	End If
	
	 /* Quando vier da produto_geral_uf, s$$HEX1$$f300$$ENDHEX$$ importa o registro se for da UF da filial */
	If ( Upper( ps_Tabela ) = 'PRODUTO_GERAL_UF' OR ( Upper( ps_Tabela ) = 'PRODUTO_GERAL' ) ) And ( gvo_Aplicacao.ivo_Seguranca.cd_Sistema = 'TL' ) Then
		ps_Tabela = 'produto_geral' // DE -> PARA do nome da tabela, produto_geral_uf $$HEX1$$e900$$ENDHEX$$ fict$$HEX1$$ed00$$ENDHEX$$cia
		
		If io_Json.of_Existe_Campo( ps_Registro, 'cd_unidade_federacao' ) Then
			If io_Json.of_Busca_Conteudo_Campo( ps_Registro, 'cd_unidade_federacao', False ) <> gvo_Parametro.ivs_Uf_Filial Then
				Return True
			End If
		End If
	End If
	/* FIM: produto_geral_uf */
	
	/* Quando vier da campanha_produto, s$$HEX1$$f300$$ENDHEX$$ importa o registro se for campanha da filial */
	IF gvo_Aplicacao.ivo_Seguranca.cd_Sistema = 'TL' AND Upper( ps_Tabela ) = 'CAMPANHA_PRODUTO' Then
		If io_Json.of_Existe_Campo( ps_Registro, 'cd_filial' ) Then
			If Long(io_Json.of_Busca_Conteudo_Campo( ps_Registro, 'cd_filial', False )) <> gvo_Parametro.cd_filial Then
				Return True
			Else 
				ps_Tabela = ps_Tabela
			End If
		End If
	End If
	
	//Tratamento TABELA CARTAO_COMPROVANTE_VENDA para CARTAO_COMPROVANTE_OPERACAO
	//Somente Matriz - Sybase Central
	If SqlCa.of_Dbms_Name( ) <> 'POSTGRESQL' Then
		If Upper( ps_Tabela ) = 'CARTAO_COMPROVANTE_OPERACAO' Then
				//lb_Atualiza = This.of_Central_Importa_Cartao_Comp_Venda( lds_Datastore, pl_Linha, ivi_Log )
			Return This.of_central_import_cartao_comp_venda_novo( ps_registro, pl_linha )
		End If
	End If

	dc_uo_ds_base	lds_Datastore
	lds_Datastore = Create dc_uo_ds_base
	lds_DataStore.of_Changedataobject( ls_DataStore )
	lds_Datastore.ivo_dberror.of_set_erro_saida_padrao( 'LOG' )
	
	ps_tabela = Upper( ps_tabela )
	
	ll_Find = This.ids_Relacao_Tabelas.Find( "nm_tabela = '" + ps_Tabela + "'", 1,  This.ids_Relacao_Tabelas.RowCount( ) )
	ls_Sql = This.ids_Relacao_Tabelas.Object.De_Sql[ ll_Find ]
	
	ll_Pos_Where	= PosA( Upper( ls_Sql ), 'WHERE' ) + 6
	ll_Pos_Var		= PosA( Upper( ls_Sql ), '=', ll_Pos_Where )
	
	Do While ll_Pos_Where > 5
		ls_Objeto 			= Trim( MidA( ls_Sql, ll_Pos_Where, ll_Pos_Var - 1 - ( ll_Pos_Where ) ) )
		ls_Valor_Campo 	= io_Json.of_Busca_Conteudo_Campo( ps_Registro, ls_Objeto, False )
		ls_Id_Atualizacao	= io_Json.of_Busca_Conteudo_Campo( ps_Registro, "atualizacao", False )
		
		If IsDate( Mid( ls_Valor_Campo, 1, 10 ) ) And ( Left( Lower( ls_Objeto ), 3 ) = 'dh_'  Or  Left( Lower( ls_Objeto ), 3 ) = 'dt_' ) Then
			If ls_Id_Atualizacao = 'E' Then //No log exportacao deve ser gravada a data no formato 20190502
				ls_Sql = gf_Replace( ls_Sql, '%VAR%', Mid( ls_Valor_Campo, 1, 4 ) + Mid( ls_Valor_Campo, 5, 2 ) + Mid( ls_Valor_Campo, 7, 2 ) + Mid( ls_Valor_Campo, 9 ), 1 )
			Else
				ls_Sql = gf_Replace( ls_Sql, '%VAR%', Mid( ls_Valor_Campo, 7, 4 ) + Mid( ls_Valor_Campo, 4, 2 ) + Mid( ls_Valor_Campo, 1, 2 ) + Mid( ls_Valor_Campo, 11 ), 1 )
			End If
		Else
			ls_Sql = gf_Replace( ls_Sql, '%VAR%', ls_Valor_Campo, 1 )
		End If
		
		If ps_Tabela = 'CONVENIADO' And SqlCa.of_Dbms_Name( ) <> 'POSTGRESQL' Then
			If ls_Objeto = 'cd_convenio' 	Then ll_convenio 			= Long (ls_Valor_Campo)
			If ls_Objeto = 'cd_conveniado'	Then 
				ls_conveniado 		= ls_Valor_Campo
				ldt_Data_Registro 	= DateTime(  io_Json.of_Busca_Conteudo_Campo( ps_Registro, 'dh_atualizacao', False ) )
			End If
		End If
				
		ll_Pos_Where	= PosA( Upper( ls_Sql ), ' AND ', ll_Pos_Where ) + 5
		ll_Pos_Var		= PosA( Upper( ls_Sql ), '=', ll_Pos_Where )
	Loop
	
	ls_Where = " " + Mid( ls_Sql, Pos( Upper( ls_Sql ), 'WHERE' ) )
	
	If ls_Id_Atualizacao = 'E' Then // DELETE	
		ls_Sql = "DELETE FROM " + Lower( ps_Tabela ) + ls_Where
	Else	
		If Not of_SyntaxFromSQL( lds_Datastore, String( ls_Sql ) ) Then
			Return False
		End If
		
		ls_Chave_Log = 'Linha: ' + String( pl_Linha ) + ' : ' + ls_Sql + ' : '
		
		ll_Retrieve = lds_Datastore.Retrieve( )
		
		If ll_Retrieve < 0 Then
			This.of_Grava_Log( ivi_Log, "Erro no retrieve da lds_Datastore em of_importa_json( string, string, long ) : " + lds_Datastore.ivo_dberror.of_msg_postgresql( ) )
			Return False
		End If
		
		//TRATAMENTO ESPECIAL NF COMPRA
		If SqlCa.of_Dbms_Name( ) <> 'POSTGRESQL' Then
			If ps_Tabela = 'NF_COMPRA' AND ll_Retrieve = 0 Then
				ps_Tabela = 'NF_COMPRA_PENDENTE'
				This.of_get_sql_banco( ps_Tabela )
				Return This.of_Importa_Json( ps_Tabela, ps_Registro, pl_Linha )
			End If
		End If
		
		//TRATAMENTO CONVENIADO - Importacao na matriz
		If SqlCa.of_Dbms_Name( ) <> 'POSTGRESQL' Then
			If ps_Tabela = 'CONVENIADO' AND ll_Retrieve = 1 Then //Atualizacao 				
				Select dh_atualizacao
					into :ltd_auxiliar
				from conveniado
					where cd_convenio 		= :ll_Convenio
						and cd_conveniado 	= :ls_Conveniado
				Using SqlCa;
				
				If SqlCa.SqlCode = -1 Then
					This.of_Grava_Log( ivi_Log, "Erro no selec da data de atualizacao do conveniado, of_importa_json( string, string, long ) " + SqlCa.SqlErrText)
					Return False
				End If
				
				If ltd_auxiliar >= ldt_Data_Registro Then
					//N$$HEX1$$e300$$ENDHEX$$o Atualiza o registro caso a data da matriz esteja maior
					Return True
				End If
				
			End If
		End If
		
		//TRAMENTO PRODUTO_PRESTE_A_VENCER
		If SqlCa.of_Dbms_Name( ) = 'POSTGRESQL' Then
			If ps_Tabela = 'PRODUTO_PRESTE_A_VENCER' Then
				If ll_Retrieve = 0 Then
					//Na loja deve apenas atualizar, desconsiderando o insert
					Return True
				End If
			End If
		End If
		
		//TRATAMENTO PBM_PRODUTO **** Dermaclub
		If SqlCa.of_Dbms_Name( ) = 'POSTGRESQL' Then
			If ps_Tabela = 'PBM_PRODUTO' Then
				If PosA(ps_Registro, 'id_tipo') > 0 Then
					ls_Valor_Campo = io_Json.of_Busca_Conteudo_Campo( ps_Registro, 'id_tipo', False )
					
					//Verifica se o produto pbm pertence ao dermaclub, tipo= D
					If ls_Valor_Campo = 'D' Then
						SetNull(li_Existe)
						ll_PBM = Long( io_Json.of_Busca_Conteudo_Campo( ps_Registro, 'cd_pbm', False ))
						
						SELECT count(cd_pbm) 
						INTO :li_Existe
						FROM pbm 
						WHERE cd_pbm 	= :ll_PBM
							AND id_tipo 		= 'D'
							AND ( cd_uf IS NULL OR cd_uf = :gvo_Parametro.ivs_uf_filial)
						Using SqlCa;
						
						If SqlCa.SqlCode = -1 Then
							This.of_Grava_Log( ivi_Log, "Erro no selec do pbm pelo Estado da filial, of_importa_json( string, string, long ) " + SqlCa.SqlErrText)
							Return FALSE
						End If
						
						If li_Existe = 0 Then
							//Nao importa registro pbm_produto se n$$HEX1$$e300$$ENDHEX$$o for da mesma UF ou dermaclub geral(todos os Estados)
							Return True
						End If								
					End If
				End If
			End If
		End If
		
		//TRATAMENTO PBM_PRODUTO_PROGRESSIVO        **** Dermaclub
		If SqlCa.of_Dbms_Name( ) = 'POSTGRESQL' Then
			If ps_Tabela = 'PBM_PRODUTO_PROGRESSIVO' Then
				SetNull(li_Aux)
				ll_PBM = Long( io_Json.of_Busca_Conteudo_Campo( ps_Registro, 'cd_pbm', False ))
					
				SELECT count(cd_pbm) 
				INTO :li_Aux
				FROM pbm 
				WHERE cd_pbm 	= :ll_PBM
					AND id_tipo 		= 'D'
					AND ( cd_uf IS NULL OR cd_uf = :gvo_Parametro.ivs_uf_filial)
				Using SqlCa;
				
				If SqlCa.SqlCode = -1 Then
					This.of_Grava_Log( ivi_Log, "Erro no selec do pbm pelo Estado da filial, of_importa_json( string, string, long ) " + SqlCa.SqlErrText)
					Return FALSE
				End If
				
				If li_Aux = 0 Then
					//Nao importa registro pbm_produto se n$$HEX1$$e300$$ENDHEX$$o for da mesma UF ou dermaclub geral(todos os Estados)
					Return True
				End If								
			End If
		End If
		ls_Valor_Campo = ''
		
		ls_Sql_Update	= 'UPDATE ' + Lower( ps_Tabela ) + ' SET '
		ls_Sql_Insert	= 'INSERT INTO ' + Lower( ps_Tabela )
		
		ll_Colunas	= Long( lds_Datastore.Describe( "DataWindow.Column.Count" ) )
			
		For ll_Loop = 1 To ll_Colunas
			ls_Objeto	= lds_Datastore.Describe( "#" + String(ll_Loop) + ".Name" )
			ls_Tipo		= Upper( lds_Datastore.Describe( ls_Objeto + ".ColType" ) )
			lb_Campo_Sap = False
			ls_Valor_Campo_sap = ''
			
			If Not io_Json.of_Existe_Campo( ps_Registro, ls_Objeto ) Then
				Continue
			End If
			
			// Condi$$HEX2$$e700e300$$ENDHEX$$o para n$$HEX1$$e300$$ENDHEX$$o atualizar coluna quando for update na LOJA
			If gvo_Aplicacao.ivo_Seguranca.cd_Sistema = 'TL' Then
				Choose Case Upper( ps_Tabela ) 
					Case 'PEDIDO_DISTRIBUIDORA_PRODUTO'
						If lds_Datastore.RowCount( ) = 1 Then // Atualizacao
							If ls_Objeto = 'qt_faturada' Or ls_Objeto = 'qt_recebida' Or ls_Objeto = 'id_situacao' Then
								Continue
							End If
						End If	
						
					Case 'PROMOCAO_SOS_PRODUTO'
						//Insert ou Update desconsiderar a coluna cd_filial
						If ls_Objeto = 'cd_filial' Then
							Continue
						End If
					
					Case 'CONVENIADO'
						If lds_Datastore.RowCount( ) = 1 Then // Atualizacao
							If ls_Objeto = 'cd_cliente' Then
								Continue
							End If
						End If					
						
					Case 'PRODUTO_GERAL'  
						If Upper(Trim(This.is_loja_sap)) = 'S' Then //Chamado 500520-2
							If lds_Datastore.RowCount( ) = 1 Then // Atualizacao
								//Veio pela PRODUTO_GERAL_UF - Tratamentos SAP
								
									Choose Case ls_Objeto
										Case 'vl_preco_venda_atual'
											ls_Valor_Campo_sap = io_Json.of_Busca_Conteudo_Campo( ps_Registro, 'vl_preco_venda_atual_sap', False )
										Case 'dh_preco_venda_atual'
											ls_Valor_Campo_sap = io_Json.of_Busca_Conteudo_Campo( ps_Registro, 'dh_preco_venda_atual_sap', False )										
										Case 'vl_preco_venda_futuro'
											ls_Valor_Campo_sap = io_Json.of_Busca_Conteudo_Campo( ps_Registro, 'vl_preco_venda_futuro_sap', False )
										Case 'dh_preco_venda_futuro'
											ls_Valor_Campo_sap = io_Json.of_Busca_Conteudo_Campo( ps_Registro, 'dh_preco_venda_futuro_sap', False )
										Case 'vl_preco_venda_maximo'
											ls_Valor_Campo_sap = io_Json.of_Busca_Conteudo_Campo( ps_Registro, 'vl_preco_venda_maximo_sap', False )												
										Case 'nr_matric_preco_venda_futuro'
											ls_Valor_Campo_sap = io_Json.of_Busca_Conteudo_Campo( ps_Registro, 'nr_matric_preco_venda_fut_sap', False )								
											
									End Choose
									If Trim(ls_Valor_Campo_sap) <> '' And Trim(ls_Valor_Campo_sap) <> "null"  Then
										ls_Valor_Campo = ls_Valor_Campo_sap
										lb_Campo_Sap = True
									End If

							End If
						End If
				End Choose
			End If
			
			If Not lb_Campo_Sap Then
				ls_Valor_Campo = io_Json.of_Busca_Conteudo_Campo( ps_Registro, ls_Objeto, False )
			End If
			
			Choose Case Upper( ps_Tabela )
				Case	'NF_TRANSFERENCIA'	, &
						'ITEM_NF_TRANSFERENCIA'
					If lds_Datastore.RowCount( ) = 0 Then // Inclus$$HEX1$$e300$$ENDHEX$$o
					
						If ls_Objeto = 'dh_cancelamento' Or ls_Objeto = 'nr_matricula_cancelamento' Then
							ls_Valor_Campo = 'null'
						End If
						
					/* Transforma$$HEX2$$e700e300$$ENDHEX$$o filial destino de 534 -> 1 */
						If ( ls_Objeto = 'cd_filial_origem' ) And ( Long( ls_Valor_Campo ) <> 534 ) Then
							lb_Altera_Filial_Destino_Perini = True
						End If
					Else // Atualiza$$HEX2$$e700e300$$ENDHEX$$o
						/* Se for update e a filial de destino gravada no banco for 1, altera a filial de destino para 1 no update */
						If ls_Objeto = 'cd_filial_destino' Then
							If lds_Datastore.Object.cd_Filial_Destino[ 1 ] = 1 Then
								lb_Altera_Filial_Destino_Perini = True
							End If
						End If
					End If
					
					/******************/
					If lb_Altera_Filial_Destino_Perini And ( ls_Objeto = 'cd_filial_destino' ) And ( Long( ls_Valor_Campo ) = 534 ) Then
						ls_Valor_Campo = '1'
					End If
					/********************************/
					
					/* S$$HEX1$$f300$$ENDHEX$$ atualiza o campo dh_recebimento se a filial que est$$HEX1$$e100$$ENDHEX$$ importando $$HEX1$$e900$$ENDHEX$$ a filial destino */
					If ls_Objeto = 'dh_recebimento' Then
						If lds_Datastore.RowCount( ) > 0 Then // Atualiza$$HEX2$$e700e300$$ENDHEX$$o
							If lds_Datastore.Object.cd_Filial_Destino[1] <> This.ivl_Filial_Importacao Then
								Continue
							End If
						End If
					End If
					
					/*Somente a loja origem pode cancelar a nota fiscal, impede que a filial destino anule a data na matriz */
					If SqlCa.of_Dbms_Name( ) <> 'POSTGRESQL' Then
						If ls_Objeto = 'dh_cancelamento' Or ls_Objeto = 'nr_matricula_cancelamento' Then
							If lds_Datastore.RowCount( ) > 0 Then // Atualiza$$HEX2$$e700e300$$ENDHEX$$o
								If lds_Datastore.Object.cd_Filial_Destino[1] = This.ivl_Filial_Importacao Then
									Continue
								End If
							End If
						End If
					End If
					
					
			End Choose
		
			If Mid( ls_Tipo, 1, 7 ) = "DECIMAL" Or Mid( ls_Tipo, 1, 4 ) = "REAL" Then
				ls_Tipo = "DECIMAL"
			End If
			
			ls_Colunas_Insert += ls_Objeto + ', '
			
			Choose Case ls_Tipo
				Case "DECIMAL", "REAL", "INT", "LONG", "ULONG", "NUMBER"
					ls_Valores_Insert += ls_Valor_Campo + ", "

					If Pos( ls_Where, ls_Objeto + ' ' ) = 0 Then // Campos da chave prim$$HEX1$$e100$$ENDHEX$$ria n$$HEX1$$e300$$ENDHEX$$o podem estar no update
						ls_Campos_Valores_Update += ls_Objeto + " = " + ls_Valor_Campo + ", "
					End If
					
				Case "DATE", "DATETIME", "TIMESTAMP"
					If ls_Valor_Campo = 'null' Then
						ls_Valores_Insert += ls_Valor_Campo + ", "
						
						If Pos( ls_Objeto + ' ', ls_Where ) = 0 Then // Campos da chave prim$$HEX1$$e100$$ENDHEX$$ria n$$HEX1$$e300$$ENDHEX$$o podem estar no update
							ls_Campos_Valores_Update += ls_Objeto + " = " + ls_Valor_Campo + ", "
						End If
					Else
					
						ls_Valor_Campo = Mid( ls_Valor_Campo, 7, 4 ) + Mid( ls_Valor_Campo, 4, 2 ) + Mid( ls_Valor_Campo, 1, 2 ) + Mid( ls_Valor_Campo, 11 )
	
						ls_Valores_Insert += "'" + ls_Valor_Campo + "', "

						If Pos( ls_Where, ls_Objeto + ' ' ) = 0 Then // Campos da chave prim$$HEX1$$e100$$ENDHEX$$ria n$$HEX1$$e300$$ENDHEX$$o podem estar no update
							ls_Campos_Valores_Update += ls_Objeto + " = '" + ls_Valor_Campo + "', "
						End If
				End If

				Case Else
					If ls_Valor_Campo = 'null' Then
						ls_Valores_Insert += ls_Valor_Campo + ", "
						ls_Campos_Valores_Update += ls_Objeto + " = " + ls_Valor_Campo + ", "
					Else
						ls_Valor_Campo = This.of_Escape_Single_Quote( ls_Valor_Campo ) // Insere ' antes de ', retornando ''
						
						ls_Valores_Insert += "'" + ls_Valor_Campo + "', "
						
						If Pos( ls_Where, ls_Objeto + ' ' ) = 0 Then // Campos da chave prim$$HEX1$$e100$$ENDHEX$$ria n$$HEX1$$e300$$ENDHEX$$o podem estar no update
							ls_Campos_Valores_Update += ls_Objeto + " = '" + ls_Valor_Campo + "', "
						End If
					End If
			End Choose
		Next
		
		ls_Colunas_Insert				= Mid( ls_Colunas_Insert, 1, Len( ls_Colunas_Insert ) -2 )
		ls_Valores_Insert				= Mid( ls_Valores_Insert	, 1, Len( ls_Valores_Insert ) -2 )
		ls_Campos_Valores_Update	= Mid( ls_Campos_Valores_Update, 1, Len( ls_Campos_Valores_Update ) -2 )
		
		ls_Sql_Update	+= ls_Campos_Valores_Update + ls_Where
		ls_Sql_Insert	+= ' ( ' + ls_Colunas_Insert + ' ) VALUES ( ' + ls_Valores_Insert + ' )'
		
		If lds_DataStore.Rowcount( ) = 0 Then
			ls_Sql = ls_Sql_Insert
		Else
			If Trim(ls_Campos_Valores_Update) = "" Then
				//Tabelas que possuem somente campos PK, como campanha_cliente
				//Devem ser desconsideradas
				Return True
			End If
			ls_Sql = ls_Sql_Update
		End If
		
		/* Tratamentos especiais do Central */
		If SqlCa.of_Dbms_Name( ) <> 'POSTGRESQL' Then
			
			Choose Case Upper( ps_Tabela )
				Case	'NF_TRANSFERENCIA' /* Se for inclus$$HEX1$$e300$$ENDHEX$$o, registra passagem na intranet */
					If Long( io_Json.of_Busca_Conteudo_Campo( ps_Registro, 'cd_filial_origem', False ) ) <> 534 Then
						This.of_Registra_Transferencia_Intranet( ps_Registro )
					End If
					
				Case 'MOVIMENTO_TITULO_RECEBER' /* Somente inclus$$HEX1$$e300$$ENDHEX$$o. Se j$$HEX1$$e100$$ENDHEX$$ existir, n$$HEX1$$e300$$ENDHEX$$o realizada o update */
					If ll_Retrieve > 0 Then Return True
				
			End Choose
			
		End If // IF SqlCa.dbms
	End If // IF DELETE
	
	/* Tabelas com fun$$HEX2$$e700e300$$ENDHEX$$o pr$$HEX1$$f300$$ENDHEX$$pria para importa$$HEX2$$e700e300$$ENDHEX$$o no central */
	If SqlCa.of_Dbms_Name( ) = 'POSTGRESQL' Or &
		( Upper( ps_Tabela ) <> 'CARTAO_COMPROVANTE_VENDA' And &
		Upper( ps_Tabela ) <> 'PROMOCAO_SOS_ESTOQUE_MINIMO' And &
		Upper( ps_Tabela ) <> 'SALDO_PRODUTO' ) Then

		If Not SqlCa.of_isconnected( ) Then
			ls_Chave_Log = 'NAO CONECTADO COM BD - Linha: ' + String( pl_Linha ) + ' : ' + ls_Sql + ' : '
			This.of_Grava_Log( ivi_Log, ls_Chave_Log)
		End If
		
		Execute Immediate :ls_Sql Using SqlCa;
	
		If SqlCa.SqlCode = -1 Then
			ls_Chave_Log = 'Linha: ' + String( pl_Linha ) + ' : ' + ls_Sql + ' : '
			This.of_Grava_Log( ivi_Log, ls_Chave_Log + SqlCa.SqlErrText )
				
			SqlCa.of_RollBack( )
				
			Return False
		End If
		
		If SqlCa.of_Commit() < 0 Then
			ls_Chave_Log = 'ERRO NO COMMIT Linha: ' + String( pl_Linha ) + ' : ' + ls_Sql + ' : '
			This.of_Grava_Log( ivi_Log, ls_Chave_Log + SqlCa.SqlErrText )
		End If
	End If
	
	Return lb_Sucesso
	/* *****************************************/
	
	/* DEVER$$HEX1$$c100$$ENDHEX$$ SER VERIFICADO COMO FUNCIONAR$$HEX1$$c100$$ENDHEX$$ O ESQUEMA ACIMA COM AS TABELAS ABAIXO
		CUIDADO ANTES DE INICIAR AS MESMAS NO MODO NOVO (SQL)
	*/
	
	If Not lb_Sucesso Then Return False
	
	/* Tratamentos especiais, como compara$$HEX2$$e700f500$$ENDHEX$$es de datas da filial com datas do Central */
	If ls_Id_Atualizacao <> 'E' Then
		 /* V$$HEX1$$e100$$ENDHEX$$lido para Inclus$$HEX1$$e300$$ENDHEX$$o ou Altera$$HEX2$$e700e300$$ENDHEX$$o */
		Choose Case Upper( ps_Tabela )
				
			Case 'LOG_FECHAMENTO_DIARIO' /* Deleta os dados da saldo_produto_lote da filial para reimportar tudo */			
				ll_Filial =  lds_Datastore.Object.Cd_Filial[1]
				
				Delete
				  From saldo_produto_lote
				Where cd_filial = :ll_Filial
				  Using SqlCa;
				  
				If SqlCa.SqlCode = -1 Then
					This.of_Grava_Log( ivi_Log, ls_Chave_Log + lds_Datastore.ivo_dbError.of_Msg_Sybase() + ' :: Exclus$$HEX1$$e300$$ENDHEX$$o da saldo_produto_lote')
					lb_Atualiza = False
				End If
				/**********/
				
			Case 'CONFIRMACAO_IMPORTACAO_FILIAL', 'SALDO_PRODUTO_LOTE' // confirmacao_importacao, saldo_produto_lote
				lds_Datastore.Modify("cd_filial.Update = Yes")
				
			Case 'MOVIMENTO_TITULO_RECEBER'
				lb_Atualiza = This.of_Central_Importa_Movto_Titulo_Receber( lds_Datastore, String( pl_Linha ) )
				
			Case 'CARTAO_COMPROVANTE_VENDA'
				lb_Atualiza = This.of_Central_Importa_Cartao_Comp_Venda( lds_Datastore, pl_Linha, ivi_Log )
				
			Case 'NF_COMPRA' // nf_compra
				If ls_Id_Atualizacao = 'A' And ll_Linha = 0 Then
					lb_Atualiza = False
				Else			
					// Data: 14/08/2012
					// S$$HEX1$$e900$$ENDHEX$$rgio: coloquei esta condi$$HEX2$$e700e300$$ENDHEX$$o pois esta fun$$HEX2$$e700e300$$ENDHEX$$o s$$HEX1$$f300$$ENDHEX$$ $$HEX1$$e900$$ENDHEX$$ utilizada
					// quando for uma atualiza$$HEX2$$e700e300$$ENDHEX$$o. 
					
				End If  //If ls_Id_Atualizacao = 'A' And ll_Linha = 0 Then
				
			Case 'SALDO_PRODUTO'
				lb_Atualiza = This.of_Central_Importa_Saldo_Produto( lds_Datastore, String( pl_Linha ) )			
				
			Case 'PROMOCAO_SOS_ESTOQUE_MINIMO' //Exclui produto da promocao_sos_estoque_minimo no central, quando a quantidade vier 0(zero) ou menos.
				lb_Atualiza = This.of_Central_Importa_Promocao_sos_Produto( lds_Datastore, String( pl_Linha ) )
			
			Case 'NF_DIVERSA' // Inclui o codigo da filial complementar, essa informa$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ gravada na loja.
				String ls_Nf_Complementrar
				ls_Nf_Complementrar = String(lds_Datastore.Object.Nr_Nf_Complementar[1])
				If Not IsNull( ls_Nf_Complementrar ) And Trim( ls_Nf_Complementrar ) <> "" Then 
					lds_Datastore.Object.Cd_Filial_Complementar[1] = lds_Datastore.Object.Cd_Filial_Origem[1]
				Else
					lds_Datastore.Modify("cd_filial_complementar.Update = No")
				End If
				
			Case 'SORTEIO_NATAL' // quando vem da loja n$$HEX1$$e300$$ENDHEX$$o atualiza este campo.
				lds_Datastore.Modify("cd_filial.Update = No")
				
			Case 'CLIENTE_CHEQUE' //  O motivo de bloqueio n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ para atualizar quando vem da filial
				lds_Datastore.Modify("de_bloqueio.Update = No")
				
			Case 'VENDA_PBM_PRODUTO' //Essa atualiza$$HEX2$$e700e300$$ENDHEX$$o na loja era muito demorada, colocamos aqui.
				String ls_pbm, ls_pbm_retorno
				ls_pbm = lds_Datastore.Object.id_pbm[1]
				If IsNull( ls_pbm ) Or Trim( ls_pbm ) = "" Then 			
					lb_Atualiza = This.of_Central_Atualiza_Produto_PBM( lds_Datastore, 1, Ref ls_pbm_retorno )				
					If lb_Atualiza Then
						lds_Datastore.Object.id_pbm[1] = ls_pbm_retorno
					End If				
				End If
				
			Case 'PEDIDO_ALMOXARIFADO_PRODUTO'
				lb_Atualiza = This.of_Central_Verifica_Pedido_Almoxarifado( lds_Datastore, pl_Linha, ivi_Log )			
				
		End Choose	
	End If
	
	
	If Not lb_Atualiza Then
		Destroy lds_Datastore
		Return lb_Sucesso
	End If
	/* Fim dos tratamentos especiais */
	
	If Upper( ps_Tabela ) <> 'MOVIMENTO_TITULO_RECEBER' And &
		Upper( ps_Tabela ) <> 'CARTAO_COMPROVANTE_VENDA' And &
		Upper( ps_Tabela ) <> 'PROMOCAO_SOS_ESTOQUE_MINIMO' And &
		Upper( ps_Tabela ) <> 'SALDO_PRODUTO'  Then
		If lds_Datastore.Update() = -1 Then
			
			If Upper( ps_Tabela ) <> 'LOCAL_ESTOCAGEM_FILIAL' And Upper( ps_Tabela ) <> 'LOCAL_ESTOCAGEM' Then // Para n$$HEX1$$e300$$ENDHEX$$o gravar erro
				This.of_Grava_Log( ivi_Log, ls_Chave_Log + lds_Datastore.ivo_dbError.ivs_sqlerrtext )
			End If
			
			SqlCa.of_RollBack( )
			
			Return False
		End If
	End If
	
	SqlCa.of_Commit()
	
	Destroy lds_Datastore
	
	GarbageCollect( )
	Yield( )
	
	Return lb_Sucesso
	
	/********** At$$HEX1$$e900$$ENDHEX$$ aqui o c$$HEX1$$f300$$ENDHEX$$digo est$$HEX1$$e100$$ENDHEX$$ desabilitado. Manter at$$HEX1$$e900$$ENDHEX$$ realizar o tratamento necess$$HEX1$$e100$$ENDHEX$$rios para as tabelas ******/
	
Catch( RuntimeError ru )
	This.of_Grava_Log( ivi_Log, ru.getmessage( ) )
Finally
	If IsValid( lds_Datastore ) Then Destroy lds_Datastore
	GarbageCollect( )
End Try
end function

public function string of_monta_registro_exclusao (string ps_tabela, string ps_sql, string ps_chave_log);//WHERE nr_titulo = '%VAR%' AND cd_filial_atualizacao = %VAR% AND nr_movimento = %VAR%
//0794000948900@#!794 @#!1
//"nr_titulo":"0794000948900","cd_filial_atualizacao":"794","nr_movimento":"1"

Long ll_Pos
Long ll_Pos_Igual
Long ll_Pos_Chave

String ls_Valor
String ls_Coluna
String ls_Retorno
//
String ls_Aux
String ls_Tabelas_FROM[]

Long li_Contador_FROM, ll_ate, i


If UPPER(ps_tabela) = 'PROMOCAO_SOS_PRODUTO' Or UPPER(ps_tabela) = 'CAMPANHA_PRODUTO' Then
	
	//Utilizado nos casos onde $$HEX1$$e000$$ENDHEX$$ exclusao de tabelas que utilizam JOIN
	ls_Aux = ps_sql
	li_Contador_FROM++
			
	Do	
		ll_pos = 0
		ll_ate = 0
		If li_Contador_FROM = 1 Then
			ll_pos = PosA( UPPER(ps_sql), 'FROM' ) + 5
			ll_ate  = PosA( UPPER(ps_sql), 'AS ', ll_pos )
			ls_Tabelas_FROM[ li_Contador_FROM ] = mid( ps_sql, ll_pos,  ( (ll_ate - 1) - ll_pos ) )
			ls_Aux = Mid( ps_sql, ll_ate +2 )
		Else			
			ll_pos = PosA( UPPER(ls_Aux), 'JOIN' )
			If ll_pos > 0 Then
				ll_Pos += 5
				
				ll_ate  = PosA( UPPER(ls_Aux), 'AS ', ll_pos )					
				ls_Tabelas_FROM[ li_Contador_FROM ] = mid( ls_Aux, ll_pos,  ( (ll_ate - 1) - ll_pos ) )
				ls_Aux = Mid( ls_Aux, ll_ate +2 )
			End If
		End If
		
		li_Contador_FROM++
		
	LOOP WHILE ll_pos > 0
	
	ll_Pos = 0

End If

ll_Pos = PosA( ps_Sql, 'WHERE' ) + 5

Do While ll_Pos > 0
	ll_Pos_Igual = PosA( ps_Sql, "=", ll_Pos ) -1
	ls_Coluna	= Trim( MidA( ps_Sql, ll_Pos, ll_Pos_Igual -ll_Pos ) )
	
	FOR i = 1 to UPPERBOUND( ls_Tabelas_FROM[] )
		ls_Coluna = gf_Replace( ls_Coluna, Lower(ls_Tabelas_FROM[i]) + ".", '', 1 )
	NEXT
	
	//
	Choose Case UPPER(ps_tabela)
		Case 'PROMOCAO_SOS_PRODUTO' 
			If ls_Coluna = 'cd_filial' Then
				ps_Sql 			= MidA( ps_Sql, ll_Pos_Igual )
				ll_Pos_Chave = PosA( ps_Chave_Log, '@#!' ) -1
				If ll_Pos_Chave = -1 Then	//Final da Chave
					EXIT
				End If
				ps_Chave_Log 	= MidA( ps_Chave_Log, ll_Pos_Chave + 4 )
				Continue
			End If
	End Choose
	
	ll_Pos_Chave = PosA( ps_Chave_Log, '@#!' ) -1
	
	If ll_Pos_Chave = -1 Then
		ll_Pos_Chave = LenA( ps_Chave_Log )
	End If
	
	ls_Valor = MidA( ps_Chave_Log, 1, ll_Pos_Chave )
	
	ps_Sql 	= MidA( ps_Sql, ll_Pos_Igual )
	ll_Pos 	= PosA( ps_Sql, 'AND' )
	
	If ll_Pos > 0 Then ll_Pos += 4
	
	ps_Chave_Log = MidA( ps_Chave_Log, ll_Pos_Chave + 4 )
	
	ls_Retorno += '"' + ls_Coluna + '":"' + Trim( ls_Valor ) + '",'
Loop

Return ls_Retorno
end function

public function boolean of_central_import_cartao_comp_venda_novo (string ps_registro, long pl_linha);Boolean lvb_Sucesso = True

Long	lvl_Max, &
     	lvl_Linha, &
		lvl_Filial, &
		lvl_Administradora, &
		lvl_NF, &
		lvl_Controle_Caixa, &
		lvl_Comprovante_Caixa, &
		lvl_Total_Geral, &
		lvl_Total_Situacao, &
		lvl_Achou, &
		lvl_sequencial, &
		lvl_Conta_Fluxo

String lvs_Arquivo_Dados, &
       lvs_Arquivo_LOG, &
		 lvs_Chave_Log, &
		 lvs_Produto, &
		 lvs_Estabelecimento, &
		 lvs_Cartao, &
		 lvs_Autorizacao, &
		 lvs_NSU, &
		 lvs_Tipo_Venda, &
		 lvs_Especie, &
		 lvs_Serie, &
		 lvs_Deposito, &
		 lvs_Captura, &
		 lvs_Cancelamento, &
		 lvs_Situacao, &
		 lvs_Caixa, &
		 lvs_Parcelamento, &
		 lvs_Recebido, &
		 lvs_Temporario, &
		 lvs_Filial

String ls_PSP_Recebedor
String ls_Autorizacao_Cd
String ls_Tipo_Uso_Cd
String lvs_Valor
String ls_Autorizacao_Tef

Long ll_Pedido_Ecommerce
Long ll_Bandeira_Cartao	 
		 
DateTime lvdh_Venda, &
			 lvdh_Predatado

Date lvdt_Deposito[], &
	  lvdt_Credito[], &
	  lvdt_Ultimo_Dia

Decimal	lvdc_Valor_Total, &
			lvdc_Valor_Parcela[], &
			lvdc_Taxa_Credito, &
			lvdc_Taxa_Debito, &
			lvdc_Comissao, &
			lvdc_Parcela, &
			lvdc_Total

Integer lvi_Qtde_Parcelas, &
		  lvi_Qtde_Parcelas_Gravacao, &
		  lvi_Parcela, &
		  lvi_Dia, &
		  lvi_Mes, &
		  lvi_Ano

lvdc_Taxa_Credito			= 0
lvdc_Taxa_Debito			= 0
lvl_Filial						= ivl_Filial_Importacao
lvs_Estabelecimento 		= io_Json.of_Busca_Conteudo_Campo( ps_Registro, 'cd_estabelecimento', False )											
lvs_Produto           		= io_Json.of_Busca_Conteudo_Campo( ps_Registro, 'nm_produto', False )								 
lvs_Cartao            		= io_Json.of_Busca_Conteudo_Campo( ps_Registro, 'nr_cartao', False )						
lvs_Autorizacao				= io_Json.of_Busca_Conteudo_Campo( ps_Registro, 'nr_autorizacao', False )					
lvs_NSU						= io_Json.of_Busca_Conteudo_Campo( ps_Registro, 'nr_nsu', False )		
lvdh_Venda					= DateTime(io_Json.of_Busca_Conteudo_Campo( ps_Registro, 'dh_venda', False ))
lvs_Valor						= io_Json.of_Busca_Conteudo_Campo( ps_Registro, 'vl_venda', False )
lvdc_Valor_Total			= Dec( gf_Replace(lvs_Valor, '.', ',', 1) )

lvi_Qtde_Parcelas			= Integer(io_Json.of_Busca_Conteudo_Campo( ps_Registro, 'qt_parcelas', False )	)			
lvl_NF							= Long(io_Json.of_Busca_Conteudo_Campo( ps_Registro, 'nr_nf', False ))					
lvs_Especie					= io_Json.of_Busca_Conteudo_Campo( ps_Registro, 'de_especie', True )				
lvs_Serie						= io_Json.of_Busca_Conteudo_Campo( ps_Registro, 'de_serie', True )				
lvs_Captura					= io_Json.of_Busca_Conteudo_Campo( ps_Registro, 'id_captura', False )				
lvs_Cancelamento			= io_Json.of_Busca_Conteudo_Campo( ps_Registro, 'id_cancelamento', False )			
lvs_Caixa						= io_Json.of_Busca_Conteudo_Campo( ps_Registro, 'cd_caixa', False )				
lvl_Controle_Caixa			= Long(io_Json.of_Busca_Conteudo_Campo( ps_Registro, 'nr_controle_caixa', False ))
lvl_Sequencial				= Long(io_Json.of_Busca_Conteudo_Campo( ps_Registro, 'nr_sequencial', False ))							
lvl_Comprovante_Caixa	= Long(io_Json.of_Busca_Conteudo_Campo( ps_Registro, 'nr_comprovante_caixa', False ))
lvs_Parcelamento      		= io_Json.of_Busca_Conteudo_Campo( ps_Registro, 'id_parcelamento', True )
lvdh_Predatado				= Datetime(io_Json.of_Busca_Conteudo_Campo( ps_Registro, 'dh_credito', True ))
ls_PSP_Recebedor			= io_Json.of_Busca_Conteudo_Campo( ps_Registro, 'cd_psp_recebedor', True )
ls_Autorizacao_Cd			= io_Json.of_Busca_Conteudo_Campo( ps_Registro, 'cd_autorizacao_cd', True )
ls_Tipo_Uso_Cd			= io_Json.of_Busca_Conteudo_Campo( ps_Registro, 'id_tipo_uso_cd', True )
ll_Pedido_Ecommerce		= Long(io_Json.of_Busca_Conteudo_Campo( ps_Registro, 'nr_pedido_ecommerce', True ))

If PosA(ps_Registro, 'cd_bandeira') > 0 Then
	ll_Bandeira_Cartao		= Long(io_Json.of_Busca_Conteudo_Campo( ps_Registro, 'cd_bandeira', True ))
Else
	SetNull(ll_Bandeira_Cartao)
End If

If PosA(ps_Registro, 'nr_autorizacao_tef') > 0 Then
	ls_Autorizacao_Tef		= io_Json.of_Busca_Conteudo_Campo( ps_Registro, 'nr_autorizacao_tef', True )
Else
	SetNull(ls_Autorizacao_Tef)
End If


If lvl_NF 							= 0 Then SetNull(lvl_NF)
If ll_Pedido_Ecommerce		= 0 Then SetNull(ll_Pedido_Ecommerce)
If lvl_Comprovante_Caixa	= 0 Then SetNull(lvl_Comprovante_Caixa)
If ll_Bandeira_Cartao			= 0 Then SetNull(ll_Bandeira_Cartao)


If lvs_Especie 				= '' Then SetNull(lvs_Especie)
If lvs_Serie 					= '' Then SetNull(lvs_Serie)
If ls_PSP_Recebedor 		= '' Then SetNull(ls_PSP_Recebedor)
If ls_Autorizacao_Cd 		= '' Then SetNull(ls_Autorizacao_Cd)
If ls_Tipo_Uso_Cd 			= '' Then SetNull(ls_Tipo_Uso_Cd)
If lvs_Parcelamento		= '' Then SetNull(lvs_Parcelamento)

// Tempor$$HEX1$$e100$$ENDHEX$$rio - S$$HEX1$$e900$$ENDHEX$$rgio (Para resolver problema da Brasil Telecom)
If lvs_Estabelecimento = 'SU      :' Then 
	SetNull(lvs_Estabelecimento)
End IF
	
If IsNull(lvs_Parcelamento) Then lvs_Parcelamento = "E"

If lvs_Parcelamento = "A" Then lvi_Qtde_Parcelas = 1

If lvi_Qtde_Parcelas = 0 Then lvi_Qtde_Parcelas = 1

lvi_Qtde_Parcelas_Gravacao = lvi_Qtde_Parcelas

If lvs_Cancelamento = "S" Then
	lvs_Situacao = "X"
Else
	lvs_Situacao = "A"
End If

lvs_Autorizacao	= RightA("000000"				+ lvs_Autorizacao, 6)
lvs_NSU			= RightA("000000000000"	+ lvs_NSU, 12)

lvs_Chave_Log = "Linha " + String(pl_Linha, "00000") + " - Produto '" + lvs_Produto + "' - "

/* C$$HEX1$$f300$$ENDHEX$$digo que estava na fun$$HEX2$$e700e300$$ENDHEX$$o of_Valida_Cartao_Comprovante_Venda */
If Not IsNull(lvs_Caixa) Then
	// Verifica se os comprovantes j$$HEX1$$e100$$ENDHEX$$ haviam sido importados
//	Select count(*) 
//	   Into :lvl_Total_Geral
//	 From cartao_comprovante_operacao
//    Where cd_caixa						= :lvs_Caixa
//	   and nr_controle_caixa			= :lvl_Controle_Caixa
//	   and nr_comprovante_caixa	= :lvl_Comprovante_Caixa
//	 Using SqlCa;

//Alterada a coluna lvl_Comprovante_Caixa para lvl_Sequencial
	Select count(1) 
	   Into :lvl_Total_Geral
	 From cartao_comprovante_operacao
    Where cd_caixa						= :lvs_Caixa
	   and nr_controle_caixa			= :lvl_Controle_Caixa
	   and nr_sequencial				= :lvl_Sequencial
	 Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_LogdbError(ivi_log, lvs_Chave_Log + "Verifica$$HEX2$$e700e300$$ENDHEX$$o da Exist$$HEX1$$ea00$$ENDHEX$$ncia dos Comprovantes")
		Return False
	End If
	
	If IsNull(lvl_Total_Geral) Then lvl_Total_Geral = 0
	
	If lvl_Total_Geral <> 0 Then
	
		// Se existirem comprovantes, verifica se algum deles foi conciliado
		If lvs_Captura = "T" Then
			lvs_Situacao = "A" // Aberto
		Else
			lvs_Situacao = "T" // Tesouraria - Manual n$$HEX1$$e300$$ENDHEX$$o Depositado
		End If
	
//		Select count(*) 
//		   Into :lvl_Total_Situacao
//	      From cartao_comprovante_operacao
//	    Where cd_caixa						= :lvs_Caixa
//		    and nr_controle_caixa			= :lvl_Controle_Caixa
//		    and nr_comprovante_caixa	= :lvl_Comprovante_Caixa
//		    and id_situacao <> :lvs_Situacao
//		  Using SqlCa;
		  
		  Select count(1) 
		   Into :lvl_Total_Situacao
	      From cartao_comprovante_operacao
	    Where cd_caixa						= :lvs_Caixa
		    and nr_controle_caixa			= :lvl_Controle_Caixa
		    and nr_sequencial				= :lvl_Sequencial
		    and id_situacao <> :lvs_Situacao
		  Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_LogdbError(ivi_log, lvs_Chave_Log + "Verifica$$HEX2$$e700e300$$ENDHEX$$o da Situa$$HEX2$$e700e300$$ENDHEX$$o dos Comprovantes Existentes")
			Return False
		End If	
	
		If IsNull(lvl_Total_Situacao) Then lvl_Total_Situacao = 0
		
		If lvl_Total_Situacao > 0 Then
			Return True
		End If
		
		// Se nenhum dos comprovantes existente foi conciliado, exclui todos
		Delete 
		 From cartao_comprovante_operacao
	    Where cd_caixa						= :lvs_Caixa
		    and nr_controle_caixa			= :lvl_Controle_Caixa
		    and nr_sequencial				= :lvl_Sequencial
		  Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_LogdbError(ivi_log, lvs_Chave_Log + "Exclus$$HEX1$$e300$$ENDHEX$$o dos Comprovantes Existentes")
			Return False
		End If
		
		If SqlCa.SqlnRows <> lvl_Total_Geral Then
			SqlCa.of_RollBack()
			SqlCa.of_LogdbError(ivi_log, lvs_Chave_Log + "Exclus$$HEX1$$e300$$ENDHEX$$o dos Comprovantes Existentes")
			Return False	
		End If
	End If	
	/* Fim do C$$HEX1$$f300$$ENDHEX$$digo que estava na fun$$HEX2$$e700e300$$ENDHEX$$o of_Valida_Cartao_Comprovante_Venda */
	
	/* In$$HEX1$$ed00$$ENDHEX$$cio do C$$HEX1$$f300$$ENDHEX$$digo que estava na fun$$HEX2$$e700e300$$ENDHEX$$o of_Cartao_Produto */
	Select	  cd_administradora,
			  id_credito_debito,
			  cd_conta_fluxo_caixa
		Into :lvl_Administradora,
			  :lvs_Tipo_Venda,
			  :lvl_Conta_Fluxo
	   From cartao_produto
	 Where nm_produto = :lvs_Produto
	   Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 100
			SqlCa.of_LogdbError(ivi_log, lvs_Chave_Log + "Produto '" + lvs_Produto + "' n$$HEX1$$e300$$ENDHEX$$o Localizado")
			Return False
		Case -1
			SqlCa.of_LogdbError(ivi_log, lvs_Chave_Log + "Localiza$$HEX2$$e700e300$$ENDHEX$$o do Produto '" + lvs_Produto + "'")
			Return False
	End Choose
	/* Fim do C$$HEX1$$f300$$ENDHEX$$digo que estava na fun$$HEX2$$e700e300$$ENDHEX$$o of_Cartao_Produto */
	
	/* In$$HEX1$$ed00$$ENDHEX$$cio do C$$HEX1$$f300$$ENDHEX$$digo que estava na fun$$HEX2$$e700e300$$ENDHEX$$o of_Cartao_Estabelecimento */
	If lvl_Administradora <> 1 Then SetNull(lvs_Estabelecimento)

	lvs_Recebido = lvs_Estabelecimento
	
	//Tipo taxa: C - Cart$$HEX1$$e300$$ENDHEX$$o Cr$$HEX1$$e900$$ENDHEX$$dito / D - Cart$$HEX1$$e300$$ENDHEX$$o D$$HEX1$$e900$$ENDHEX$$bito / S - Saldo Conta Digital / F - Fundo Emergencial
	Select dbo.retorna_comissao_cartao(cc.dh_movimentacao_caixa, :lvl_Conta_Fluxo, :lvi_Qtde_Parcelas_Gravacao, coalesce(:ls_Tipo_Uso_Cd, 'D'), :ll_Pedido_Ecommerce) as pc_debito,
			 dbo.retorna_comissao_cartao(cc.dh_movimentacao_caixa, :lvl_Conta_Fluxo, :lvi_Qtde_Parcelas_Gravacao, coalesce(:ls_Tipo_Uso_Cd, 'C'), :ll_Pedido_Ecommerce) as pc_credito
	Into 	:lvdc_Taxa_Debito,
			:lvdc_Taxa_Credito
	From controle_caixa cc
	Where cc.cd_caixa						= :lvs_Caixa
		and cc.nr_controle_caixa			= :lvl_Controle_Caixa
		and :lvl_Conta_Fluxo > 0
	Using SQLCa;
	
	//Se n$$HEX1$$e300$$ENDHEX$$o encontrar pela conta fluxo o percentual, continua pegando da forma antiga
	If SQLCa.SQLCode <> 0 Then
		Select cd_estabelecimento,
				 pc_comissao_venda_credito,
				 pc_comissao_venda_debito,
				 cd_estabelecimento_temporario
		Into :lvs_Estabelecimento,
			  :lvdc_Taxa_Credito, 
			  :lvdc_Taxa_Debito,
			  :lvs_Temporario
		From cartao_estabelecimento
		Where cd_administradora 	= :lvl_Administradora
		  and cd_filial         			= :lvl_Filial
		  and id_situacao       			= 'A'
		Using SqlCa;
	Else
		Select cd_estabelecimento,
				 cd_estabelecimento_temporario
		Into :lvs_Estabelecimento,
			  :lvs_Temporario
		From cartao_estabelecimento
		Where cd_administradora 	= :lvl_Administradora
		  and cd_filial         			= :lvl_Filial
		  and id_situacao       			= 'A'
		Using SqlCa;		
	End If
	
	Choose Case SqlCa.SqlCode
		Case 0
			If IsNull(lvs_Temporario) Then lvs_Temporario = ""
			
			If Not IsNull(lvs_Recebido) Then
				If lvs_Estabelecimento <> lvs_Recebido Then
					// Somente para tratar a transi$$HEX2$$e700e300$$ENDHEX$$o de mudan$$HEX1$$e700$$ENDHEX$$a de estabelecimentos
					If lvs_Recebido = lvs_Temporario Then				
						lvs_Estabelecimento = lvs_Recebido 
					Else
						SqlCa.of_LogdbError(ivi_log, lvs_Chave_Log + "Estabelecimento recebido '" + lvs_Recebido + "' " + &
															 "diferente do cadastrado para filial '" + lvs_Estabelecimento + "'.")
						Return False
					End If
				End If
			End If
			
		Case 100	
			If lvl_Administradora <> 1 Then
				lvs_Filial = String(lvl_Filial)
				If IsNull(lvdc_Taxa_Credito) Then lvdc_Taxa_Credito = 1
				If IsNull(lvdc_Taxa_Debito) Then lvdc_Taxa_Debito = 1
				
				Insert Into cartao_estabelecimento (cd_administradora,   
																cd_estabelecimento,   
																id_situacao,   
																cd_filial,   
																cd_banco,   
																nr_agencia,   
																nr_conta,   
																pc_comissao_venda_credito,   
																pc_comissao_venda_debito,   
																cd_conta_venda_credito,   
																cd_conta_venda_debito,   
																cd_conta_banco,   
																cd_conta_comissao,   
																cd_conta_rejeicao,   
																cd_conta_ajuste_debito,   
																cd_conta_ajuste_credito,   
																cd_conta_aluguel_pos)  
				Values (:lvl_Administradora,
						  :lvs_Filial,
						  'A',
						  :lvl_Filial,
						  '237',
						  '358',
						  '1665405',
						  :lvdc_Taxa_Credito, :lvdc_Taxa_Debito,
						  '1', '2', '3', '4', '5', '6', '7', '8')
				Using SqlCa;
				
				If SqlCa.SqlCode = -1 Then
					SqlCa.of_LogdbError(ivi_log, lvs_Chave_Log + "Inclus$$HEX1$$e300$$ENDHEX$$o do Estabelecimento")
					Return False
				End If
					
			Else			
				SqlCa.of_LogdbError(ivi_log, lvs_Chave_Log + "Estabelecimento n$$HEX1$$e300$$ENDHEX$$o Localizado")
				Return False
			End If
			
		Case -1
			SqlCa.of_LogdbError(ivi_log, lvs_Chave_Log + "Localiza$$HEX2$$e700e300$$ENDHEX$$o do Estabelecimento")
			Return False
	End Choose
	/* Fim do C$$HEX1$$f300$$ENDHEX$$digo que estava na fun$$HEX2$$e700e300$$ENDHEX$$o of_Cartao_Estabelecimento */
													 
	If lvl_Administradora <> 1 and IsNull(lvs_Cartao) Then
		lvs_Cartao = "1"
	End If
			
	//Para resolver o problema de Codigo de Estabelecimento Nulo nas transa$$HEX2$$e700f500$$ENDHEX$$es de Recarga.
	If IsNull(lvs_Estabelecimento) Then lvs_Estabelecimento = String(lvl_filial)
									
	lvs_Tipo_Venda = "V" + lvs_Tipo_Venda
								
	If lvi_Qtde_Parcelas = 1 Then
		lvdc_Valor_Parcela[1] = lvdc_Valor_Total
	Else
		/* In$$HEX1$$ed00$$ENDHEX$$cio do C$$HEX1$$f300$$ENDHEX$$digo que estava na fun$$HEX2$$e700e300$$ENDHEX$$o of_Parcela_Venda_Cartao */
		lvdc_Parcela = Truncate(lvdc_Valor_Total / lvi_Qtde_Parcelas, 2)

		For lvi_Parcela = lvi_Qtde_Parcelas To 1 Step -1
			If lvi_Parcela = 1 Then
				lvdc_Valor_Parcela[lvi_Parcela] = lvdc_Valor_Total - lvdc_Total
			Else
				lvdc_Valor_Parcela[lvi_Parcela] = lvdc_Parcela
				lvdc_Total += lvdc_Parcela
			End If
		Next
		/* Fim do C$$HEX1$$f300$$ENDHEX$$digo que estava na fun$$HEX2$$e700e300$$ENDHEX$$o of_Parcela_Venda_Cartao */
	End If
	
	
	//lvdt_Deposito[1] = Date(lvdh_Venda)

	//Nova fun$$HEX2$$e700e300$$ENDHEX$$o devido as regras diferenciadas do PIX SAQUE, 
	//	se houver novas regras para o campo dh_credito implementar no objeto
//	ivo_Cartao.Of_Retorna_Data_Credito( lvs_Produto, lvs_Tipo_Venda, lvdh_Venda, lvdt_Deposito[1], lvi_Parcela, ref lvdt_Credito[1])
//	
//	//Caso n$$HEX1$$e300$$ENDHEX$$o retorne a data de cr$$HEX1$$e900$$ENDHEX$$dito na fun$$HEX2$$e700e300$$ENDHEX$$o, continua com o m$$HEX1$$e900$$ENDHEX$$todo antigo
//	If lvs_Tipo_Venda = "VD" Then
//		lvdt_Credito[1] = RelativeDate(Date(lvdh_Venda), 2)
//	Else
//		lvdt_Credito[1] = RelativeDate(Date(lvdh_Venda), 30)
//	End If
	
//	lvi_Dia 	= Day  (Date(lvdh_Venda))
//	lvi_Mes 	= Month(Date(lvdh_Venda))
//	lvi_Ano 	= Year (Date(lvdh_Venda))
	
	/* In$$HEX1$$ed00$$ENDHEX$$cio do C$$HEX1$$f300$$ENDHEX$$digo que estava na fun$$HEX2$$e700e300$$ENDHEX$$o of_Data_Venda_Cartao */
	dc_uo_Data lvo_Data
	lvo_Data = Create dc_uo_Data
	
	For lvi_Parcela = 1 To lvi_Qtde_Parcelas
		
		If lvi_Parcela = 1 Then
			lvdt_Deposito[lvi_Parcela] = Date(lvdh_Venda)
			
			lvi_Dia 	= Day  	(Date(lvdh_Venda))
			lvi_Mes 	= Month	(Date(lvdh_Venda))
			lvi_Ano 	= Year 	(Date(lvdh_Venda))
			
		ElseIf lvi_Parcela > 1 Then
			If lvi_Mes = 12 Then
				lvi_Mes = 1
				lvi_Ano ++
			Else
				lvi_Mes ++
			End If
		
			lvdt_Ultimo_Dia = lvo_Data.of_Ultimo_Dia_Mes(lvi_Mes, lvi_Ano)
			
			If Day(lvdt_Ultimo_Dia) > lvi_Dia Then
				lvdt_Deposito[lvi_Parcela] = Date(String(lvi_Dia) + "/" + String(lvdt_Ultimo_Dia, "mm/yyyy"))
			Else
				lvdt_Deposito[lvi_Parcela] = lvdt_Ultimo_Dia
			End If
		End If //Fim parcelas
		
		//Nova fun$$HEX2$$e700e300$$ENDHEX$$o devido as regras diferenciadas do PIX SAQUE, 
		//	se houver novas regras para o campo dh_credito implementar no objeto
		ivo_Cartao.Of_Retorna_Data_Credito( lvs_Produto, lvs_Tipo_Venda, lvdh_Venda, lvdt_Deposito[lvi_Parcela], lvi_Parcela, ref lvdt_Credito[lvi_Parcela])
		
		//Caso n$$HEX1$$e300$$ENDHEX$$o retorne a data de cr$$HEX1$$e900$$ENDHEX$$dito na fun$$HEX2$$e700e300$$ENDHEX$$o, continua com o m$$HEX1$$e900$$ENDHEX$$todo antigo
		If IsNull(lvdt_Credito[lvi_Parcela]) Then
			If lvs_Tipo_Venda = "VD" Then
				lvdt_Credito[lvi_Parcela] = RelativeDate(lvdt_Deposito[lvi_Parcela], 2)
			Else
				lvdt_Credito[lvi_Parcela] = RelativeDate(lvdt_Deposito[lvi_Parcela], 30)
			End If
		End If
	Next
	
	IF IsValid(lvo_Data) Then Destroy(lvo_Data)
   /* Fim do C$$HEX1$$f300$$ENDHEX$$digo que estava na fun$$HEX2$$e700e300$$ENDHEX$$o of_Data_Venda_Cartao */
			
	//Para resolver problemas com Banrisul que trata o d$$HEX1$$e900$$ENDHEX$$bito como Cr$$HEX1$$e900$$ENDHEX$$dito (D$$HEX1$$e900$$ENDHEX$$bito Pr$$HEX1$$e900$$ENDHEX$$datado e parcelado) - Lucian 31/01/2011
	If (Not IsNull(lvdh_Predatado) And lvdh_Predatado <> DateTime('1900/01/01')) 	Then
		lvs_Tipo_Venda = 'VC'
		lvdt_Credito[1] = Date(lvdh_Predatado)
		If lvl_Administradora = 6 Then
			Select pc_comissao_credito_rotativo
				Into :lvdc_Taxa_Credito							  
			  From cartao_estabelecimento
			Where cd_administradora	= :lvl_Administradora
				 and cd_filial				= :lvl_Filial
				 and id_situacao			= 'A'
			  Using SqlCa;
			  
			If SqlCa.SqlCode = -1 Then
				SqlCa.of_LogdbError(ivi_log, lvs_Chave_Log + " Localiza$$HEX2$$e700e300$$ENDHEX$$o taxa de cr$$HEX1$$e900$$ENDHEX$$dito rotativo")					
			Else
				If IsNull(lvdc_Taxa_Credito) Then
					lvdc_Taxa_Credito = 0
				End If
			End If
		End If						
	ElseIf lvi_Qtde_Parcelas > 1 Then
		lvs_Tipo_Venda = 'VC'
	End If
			
	For lvi_Parcela = 1 To lvi_Qtde_Parcelas
		// Verifica se o comprovante foi inclu$$HEX1$$ed00$$ENDHEX$$do anteriormente pela importa$$HEX2$$e700e300$$ENDHEX$$o dos arquivos (id_captura = 'A')
		// Se for venda a d$$HEX1$$e900$$ENDHEX$$bito, considera tamb$$HEX1$$e900$$ENDHEX$$m o NSU, pois a autoriza$$HEX2$$e700e300$$ENDHEX$$o normalmente $$HEX1$$e900$$ENDHEX$$ a mesma '000000'
		If lvs_Tipo_Venda = "VD" Then
			Select nr_comprovante Into :lvl_Achou
			From cartao_comprovante_operacao
			Where cd_administradora	= :lvl_Administradora
			  and cd_estabelecimento	= :lvs_Estabelecimento
			  and id_tipo_operacao		= :lvs_Tipo_Venda
			  and dh_operacao				= :lvdh_Venda
			  and nr_autorizacao			= :lvs_Autorizacao
			  and nr_nsu					= :lvs_NSU
			  and nr_parcela				= :lvi_Parcela
			  and vl_parcela				= :lvdc_Valor_Parcela[lvi_Parcela]				  
			  and id_captura				= 'A'
			Using SqlCa;
		Else						
			Select nr_comprovante Into :lvl_Achou
			From cartao_comprovante_operacao
			Where cd_administradora	= :lvl_Administradora
			  and cd_estabelecimento	= :lvs_Estabelecimento
			  and id_tipo_operacao		= :lvs_Tipo_Venda
			  and dh_operacao				= :lvdh_Venda
			  and nr_autorizacao			= :lvs_Autorizacao
			  and nr_parcela				= :lvi_Parcela
			  and vl_parcela				= :lvdc_Valor_Parcela[lvi_Parcela]		
			  and id_captura				= 'A'
			Using SqlCa;
		End If
		
		Choose Case SqlCa.SqlCode
			Case 0
				Update cartao_comprovante_operacao
				Set cd_filial						=	:lvl_Filial,
					 nr_nf							=	:lvl_NF,
					 de_especie					=	:lvs_Especie,
					 de_serie						=	:lvs_Serie,
					 vl_operacao				=	:lvdc_Valor_Total,
					 id_captura					=	:lvs_Captura,
					 id_cancelado_filial		=	:lvs_Cancelamento,
					 cd_caixa						=	:lvs_Caixa,
					 nr_controle_caixa			=	:lvl_Controle_Caixa,
					 nr_comprovante_caixa	=	:lvl_Comprovante_Caixa,
					 nr_sequencial				=  :lvl_Sequencial,
					 cd_psp_recebedor		=	:ls_PSP_Recebedor,
					 cd_autorizacao_cd		=	:ls_Autorizacao_Cd,
					 id_tipo_uso_cd				=	:ls_Tipo_Uso_Cd, 
					 nr_pedido_ecommerce	=	:ll_Pedido_Ecommerce,
					 cd_bandeira				=  :ll_Bandeira_Cartao,
					 nr_autorizacao_tef		=  :ls_Autorizacao_Tef
				Where nr_comprovante = :lvl_Comprovante_Caixa
				Using SqlCa;

				If SqlCa.SqlCode = -1 Then
					SqlCa.of_RollBack();
					SqlCa.of_LogdbError(ivi_log, lvs_Chave_Log + "Atualiza$$HEX2$$e700e300$$ENDHEX$$o do Comprovante")
					lvb_Sucesso = False						
					Exit
				End If				
				
			Case 100
				If lvs_Tipo_Venda = "VC" Then
					lvdc_Comissao = Round(lvdc_Valor_Parcela[lvi_Parcela] * (lvdc_Taxa_Credito / 100), 2)
				Else
					lvdc_Comissao = Round(lvdc_Valor_Parcela[lvi_Parcela] * (lvdc_Taxa_Debito  / 100), 2)
				End If
				
				Insert Into cartao_comprovante_operacao (cd_administradora,   
																	  cd_estabelecimento,   
																	  nr_cartao,   
																	  nr_autorizacao,   
																	  nr_nsu,   
																	  dh_operacao,   
																	  dh_deposito,   
																	  dh_credito,   
																	  id_tipo_operacao,   
																	  vl_operacao,   
																	  qt_parcelas,   
																	  nr_parcela,   
																	  vl_parcela,   
																	  vl_comissao,   
																	  id_captura,
																	  id_situacao,   
																	  cd_filial,   
																	  nr_nf,   
																	  de_especie,   
																	  de_serie,   
																	  nr_lote,   
																	  de_motivo_rejeicao,
																	  cd_caixa,
																	  nr_controle_caixa,
																	  nr_comprovante_caixa,
																	  id_cancelado_filial,
																	  nr_sequencial,
																	  cd_psp_recebedor,
																	  cd_autorizacao_cd,
																	  id_tipo_uso_cd, 
																	  nr_pedido_ecommerce,
																	  cd_bandeira,
																	  nr_autorizacao_tef)  
				Values (:lvl_Administradora,   
						  :lvs_Estabelecimento,   
						  :lvs_Cartao,   
						  :lvs_Autorizacao,   
						  :lvs_NSU,   
						  :lvdh_Venda,   
						  :lvdt_Deposito[lvi_Parcela],   
						  :lvdt_Credito[lvi_Parcela],   
						  :lvs_Tipo_Venda,   
						  :lvdc_Valor_Total,   
						  :lvi_Qtde_Parcelas_Gravacao,   
						  :lvi_Parcela,   
						  :lvdc_Valor_Parcela[lvi_Parcela],   
						  :lvdc_Comissao,   
						  :lvs_Captura,
						  :lvs_Situacao,   
						  :lvl_Filial,   
						  :lvl_NF,   
						  :lvs_Especie,   
						  :lvs_Serie,   
						  null,   
						  null,
						  :lvs_Caixa,
						  :lvl_Controle_Caixa,
						  :lvl_Comprovante_Caixa,
						  :lvs_Cancelamento,
						  :lvl_sequencial,
						  :ls_PSP_Recebedor,
					 	  :ls_Autorizacao_Cd,
					 	  :ls_Tipo_Uso_Cd, 
						  :ll_Pedido_Ecommerce,
						  :ll_Bandeira_Cartao,
						  :ls_Autorizacao_Tef)
				Using SqlCa;
				
				If SqlCa.SqlCode = -1 Then
					SqlCa.of_RollBack();
					SqlCa.of_LogdbError(ivi_log, lvs_Chave_Log + "Inclus$$HEX1$$e300$$ENDHEX$$o do Comprovante")
					lvb_Sucesso = False						
					Exit
				End If				
						
			Case -1
				SqlCa.of_RollBack();
				SqlCa.of_LogdbError(ivi_log, lvs_Chave_Log + "Localiza$$HEX2$$e700e300$$ENDHEX$$o do Comprovante")
				lvb_Sucesso = False						
				Exit
		End Choose
	Next

	If lvb_Sucesso Then
		SqlCa.of_Commit()
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_LogdbError(ivi_log, lvs_Chave_Log + "Commit")	
		End If
	Else
		 SqlCa.of_RollBack()
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_LogdbError(ivi_log, lvs_Chave_Log + "RollBack")	
		End If
	End If
End If

Return lvb_Sucesso
end function

on uo_ge212_troca_dados.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge212_troca_dados.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ivds_Tabelas			= Create dc_uo_ds_base
ids_Relacao_Tabelas	= Create dc_uo_ds_base
ivo_Comum				= Create uo_ge059_Troca_Dados_Comum
io_Json					= Create uo_ge073_json
ivo_cartao				= Create uo_cartao_produto

If SqlCa.of_IsConnected( ) Then
	gvo_Parametro.of_Carrega_Parametros( )
	SqlCa.of_Set_erro_saida_padrao( 'LOG' )
End If

// Verifica a exist$$HEX1$$ea00$$ENDHEX$$ncia do arquivo INI
If FileExists(gvo_Aplicacao.ivs_Arquivo_INI) Then
	ivs_Caminho_Arquivo = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "Diretorio", "Exportacao", "") + "\"
Else	
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Arquivo de inicializa$$HEX2$$e700e300$$ENDHEX$$o " + gvo_Aplicacao.ivs_Arquivo_INI + " n$$HEX1$$e300$$ENDHEX$$o localizado.", StopSign!)
End If




end event

event destructor;Destroy ivds_Tabelas
Destroy ivds_PK
Destroy ivo_Comum
Destroy io_Json
Destroy ivo_cartao

If IsValid( ids_Relacao_Tabelas ) Then Destroy ids_Relacao_Tabelas
end event

