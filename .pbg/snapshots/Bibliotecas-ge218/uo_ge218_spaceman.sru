HA$PBExportHeader$uo_ge218_spaceman.sru
forward
global type uo_ge218_spaceman from nonvisualobject
end type
end forward

global type uo_ge218_spaceman from nonvisualobject
end type
global uo_ge218_spaceman uo_ge218_spaceman

type variables
dc_uo_transacao spaceman

uo_produto ivo_produto

dc_uo_ds_base ids_desenho_planograma
dc_uo_ds_base ids_desenho_filial
dc_uo_ds_base ids_log

integer ivi_log

string is_chave, ivs_semana, is_Path, is_desenho_in

date ivdt_Movimento, ivdt_data_resumo, ivdt_data_resumo_final,  idt_data_inicial, idt_data_final

date ivdt_data_resumo_novo, ivdt_data_resumo_final_novo

date ivdt_Movimento_Parametro

boolean ib_envia_email = true, ib_atualiaza_informacoes_filiais

Boolean ib_Atualiza_Desenho_por_Produto = False

Boolean ib_processo_automatico_ca = False

Long il_Produtos[]
Long il_Filiais[]
Long il_Estoque_Minimo[]
Long il_Desenhos[]
Long il_Motivo
Long il_Promocao[]
Long il_Canaletas[]
Long il_capacidade[]
end variables

forward prototypes
public function boolean of_conecta_db_spaceman ()
public function boolean of_abre_log ()
public function boolean of_envia_email (string as_assunto, string as_mensagem)
public subroutine of_desconecta_db_spaceman ()
public function boolean of_grava_log (string as_mensagem, boolean ab_envia_email)
public function boolean of_atualiza_desenhos ()
public function boolean of_custo_produto (long al_produto, ref double adc_custo)
public function boolean of_venda_filial (long al_produto, long al_filial, ref double adc_vendas)
public function boolean of_atualiza_produtos ()
public subroutine of_teste ()
public function boolean of_media_vendas (long al_produto, ref double adc_vendas, long al_lojas, string as_filiais_in)
public function boolean of_atualiza_informacoes_filiais (string as_product_id, long al_planograma, double adc_custo)
public function boolean of_filtra_filiais_desenho (long al_desenho)
public function boolean of_filiais_desenho (long al_desenho, ref long al_primeira_filial, ref long al_filiais, ref string as_filiais_in)
public function boolean of_insere_produto_desenho (string as_produto, long al_planograma, string as_inclusao_exclusao)
public function boolean of_atualizacao_financeira ()
public subroutine of_periodo_venda_filial ()
public function integer of_verifica_planograma_desenho (long al_desenho, long al_planograma)
public function boolean of_monta_chave_log (long al_desenho)
public function boolean of_atualiza_log_exportacao (string as_situacao, string as_tabela)
public function boolean of_processa_limpeza_uso_desenhos ()
public function boolean of_limpa_uso_desenhos ()
public function boolean of_processa_atualizacao_produtos ()
public function boolean of_carrega_planogramas_filiais ()
public function boolean of_exclui_desenho_planograma (long al_desenho)
public function boolean of_valida_filiais (string as_filiais, long al_desenho, string as_desenho)
public function boolean of_insere_desenho_filial (long al_desenho, long al_filial, string as_desenho)
public function boolean of_exclui_desenho_filial (long al_desenho)
public function boolean of_grava_historico (long pl_produto, long pl_desenho)
public function boolean of_periodos (string as_semana, date adt_inicio, date adt_termino)
public function boolean of_processa_atualizacao_desenhos (string as_semana, date adt_inicio, date adt_termino)
public function boolean of_processa_atualizacao_financeira (string as_semana, date adt_inicio, date adt_termino)
public function boolean of_atualiza_produtos (long pl_produto)
public function boolean of_atualiza_estoque_minimo ()
public function boolean of_atualiza_desenho_por_produtos ()
public function boolean of_atualiza_produto (string pproduct_id, string pupc, string pprod_name, double pprod_size, string puom, string pmanufacturer, string pspm, string pcategory, ref string psubcategory, decimal pcod_category, string pdesc_a, string pdesc_c, string pdesc_d, string pdesc_e, string pdesc_f, string pdesc_g, string pdesc_h, string pdesc_i, double pheight, double pwidth, double pdepth, decimal ptray_height, decimal ptray_width, decimal ptray_depth, integer punits_case, integer punits_tray, string ppreferred_fixel, decimal pcase_height, decimal pcase_width, decimal pcase_depth, decimal pdisplay_height, decimal pdisplay_width, decimal pdisplay_depth, decimal pmax_horiz_crush, decimal pmax_vert_crush, decimal pmax_depth_crush, string pmodel_sched, string ps_situacao_sybase, string ps_planograma)
public subroutine of_periodo_venda_filial_nova ()
public function long of_retorna_saldo_produto (long al_filial, long al_produto)
public subroutine of_gera_planilha_produto_planograma (ref string ps_msg)
public function boolean of_exclui_produto_desenho (long al_desenho, string as_product_id, string as_tipo_alteracao)
public function boolean of_insere_produto_desenho (long al_desenho, string as_product_id, string as_tipo_operacao, long al_primeira_filial, long al_filiais_desenho, string as_filiais_in, boolean ab_atualizacao_desenhos, double adc_custo_produto)
public subroutine of_envia_email (string as_mensagem)
public subroutine of_separa_filiais (string as_filiais)
public subroutine of_gera_planilha_produto_planograma (string ps_filiais, ref string ps_msg)
public function boolean of_processa_produto_por_analise (long al_filial, long al_produto, string as_alteracao, ref long al_desenho[], ref string as_erro)
public function boolean of_verifica_filial_planograma (long al_planograma, string as_filiais, string as_planogramas, string as_desenho, string as_perfil, string as_regiao)
public function boolean of_atualiza_estoque_minimo_cluster ()
public function boolean of_valida_planogramas (string as_planogramas, long al_desenho, string as_desenho, string as_filiais, string as_perfil, string as_regiao, string as_category, string as_department, string as_subcategory)
public function boolean of_insere_desenho_planograma (long al_desenho, long al_planograma, string as_desenho, string as_planogramas, string as_filiais, string as_perfil, string as_regiao, string as_category, string as_department, string as_subcategory)
public function boolean of_atualiza_desenho (long al_desenho, string as_desenho, long al_linha, long al_linhas)
public function boolean of_atualiza_estoque_minimo_vm ()
public function boolean of_atualiza_promocao_prd_vm (long pl_cd_promocao, long pl_nr_canaleta, long pl_qt_capacidade, long pl_cd_produto, long pl_cd_filial, ref string ps_log)
end prototypes

public function boolean of_conecta_db_spaceman ();SPACEMAN.ivs_database = 'SPACEMAN'

// Se estiver conectado desconecta
If SPACEMAN.of_isConnected() Then SPACEMAN.of_Disconnect()

//// Testa a conexao com o banco de dados da loja
//If Not ivo_ODBC.of_Connect("eCommerce", "farm19br", "11farm46") Then
//	This.of_Grava_Arquivo(ai_Log, "Erro ao conectar ao banco de dados do eCommerce.", True)
//	Return False
//End If

If Not SPACEMAN.of_Connect("SPACEMAN", "CARGA") Then
	// Grava mensagem de erro no log e n$$HEX1$$e300$$ENDHEX$$o continua o processo
	This.of_Grava_Log("Erro ao conectar ao banco de dados do SPACEMAN.", True)
	Return False
End If

Return True
end function

public function boolean of_abre_log ();String	lvs_Path, lvs_Log

//lvs_Path = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "Diretorio", "Diretorio", "")

If Not IsNull(is_path) and is_Path <> "" Then
	lvs_Path = is_Path 
Else
	lvs_Path = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "Diretorio", "Diretorio", "")
End If

If lvs_Path <> "" Then
	
	lvs_Log = lvs_Path + "spaceman.log"
	
	ivi_log = FileOpen(lvs_Log, LineMode!, Write!, LockWrite!)
	
	If ivi_log = -1 Then
		//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao abrir o arquivo de log '" + lvs_Log + "'.", StopSign!)
		of_envia_email("Erro ao abrir o arquivo de log '" + lvs_Log + "'.")
		Return False
	End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Diret$$HEX1$$f300$$ENDHEX$$rio para grava$$HEX2$$e700e300$$ENDHEX$$o do arquivo de log n$$HEX1$$e300$$ENDHEX$$o foi localizado.~r~r" +&
						  "Verifique o INI da aplica$$HEX2$$e700e300$$ENDHEX$$o.", StopSign!)
	Return False
End If

Return True
end function

public function boolean of_envia_email (string as_assunto, string as_mensagem);// Controle para n$$HEX1$$e300$$ENDHEX$$o enviar o e-mail quando o processo for executado pelo compras
// pois assim ter$$HEX1$$e100$$ENDHEX$$ que instalar a conex$$HEX1$$e300$$ENDHEX$$o com o MYSQL por causa  do envio de e-mail
//If Not ib_envia_email Then Return True

//uo_smtp lo_smtp
//lo_smtp = Create uo_smtp
//
//// N$$HEX1$$e300$$ENDHEX$$o ir$$HEX1$$e100$$ENDHEX$$ mais gravar na base MySQL que se tiver com True da erro nos usuarios onde n$$HEX1$$e300$$ENDHEX$$o tem o odbc do mysql...
//lo_smtp.ib_grava_log_db = False
//
//String ls_To[]
//
//ls_To = {"sergio.gol@clamed.com.br","fabio.prado@clamed.com.br","wagner.frasseto@clamed.com.br", "bruno.triani@clamed.com.br"}
//
//lo_smtp.of_envia_email("Spaceman", &
//                       "sergio.gol@cialatinoamericana.com.br", &
//                       as_Assunto, &
//                       "<tag html se precisar>" + as_Mensagem + "</tag html se precisar>", &
//                       ls_To)                                                                                       
//Destroy lo_smtp

String ls_Anexo[]

gf_ge202_envia_email_automatico(71, as_Assunto, as_Mensagem, ls_Anexo)

Return True
end function

public subroutine of_desconecta_db_spaceman ();SPACEMAN.of_disconnect()


end subroutine

public function boolean of_grava_log (string as_mensagem, boolean ab_envia_email);Return gf_grava_log_basico_email(ivi_Log, as_mensagem, ab_envia_email, 14)
end function

public function boolean of_atualiza_desenhos ();Boolean lvb_Sucesso = True
Boolean lb_Atualiza_Estoque_Minimo = False

Long lvl_Linha, lvl_Linhas, lvl_Planograma, ll_Find

String ls_Desenho

dc_uo_ds_base lvds

try 

	lvds = Create dc_uo_ds_base
	
	lvds.Of_SetTransObject(spaceman)
	
	If Not lvds.of_ChangeDataObject("ds_ge218_desenhos") Then
		Destroy(lvds)
		Return False
	End If
	
	w_Aguarde.Title = "Atualizando os desenhos ..."
	
	// Esta vari$$HEX1$$e100$$ENDHEX$$vel $$HEX1$$e900$$ENDHEX$$ populada na chama da fun$$HEX2$$e700e300$$ENDHEX$$o na CO183
	If Not IsNull(is_desenho_in) and Trim(is_desenho_in) <> "" Then
		lvds.of_AppendWhere("pln_id in (" + is_desenho_in + ")")
	End If
	
	If lvds.Retrieve() < 0 Then
		//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar os planogramas na tabela de dados do SPACEMAN." + is_desenho_in)
		of_envia_email("Erro ao localizar os planogramas na tabela de dados do SPACEMAN." + is_desenho_in)
		Destroy(lvds)
		Return False
	End If
	
	lvl_Linhas = lvds.RowCount()
	
	If lvl_Linhas > 0 Then
		
		For lvl_Linha= 1 To lvl_Linhas
			
			lvl_Planograma		= lvds.Object.PLN_id		[lvl_Linha]
			ls_Desenho			= Upper(lvds.Object.planogram[lvl_Linha])	
			
			If lvl_Planograma = 10925 Then
				lvl_Planograma = 10925
			End If
			
			ll_Find = ids_desenho_planograma.Find("nr_desenho = " + string(lvl_Planograma), 1, ids_desenho_planograma.RowCount())
			
			If ll_Find > 0 Then
			
				ib_Atualiaza_Informacoes_Filiais = True
				
				//Chama a fun$$HEX2$$e700e300$$ENDHEX$$o que atualiza os desenhos por produto
	//			If ib_Atualiza_Desenho_por_Produto Then
	//				
	//				If This.of_Atualiza_Desenho_por_Produtos( lvl_Planograma, il_Produtos ) Then
	//					SPACEMAN.of_Commit();
	//					This.of_Grava_Log("O desenho '" + String(lvl_Planograma) + "' foi atualizado com sucesso.", False)
	//					
	//					lb_Atualiza_Estoque_Minimo = True
	//					
	//				Else
	//					SPACEMAN.of_Rollback();
	//				End If
	//				
	//			Else
					
					If This.of_Atualiza_Desenho(lvl_Planograma, ls_Desenho, lvl_Linha, lvl_Linhas) Then
						SPACEMAN.of_Commit();
						This.of_Grava_Log("O desenho '" + String(lvl_Planograma) + "' foi atualizado com sucesso.", False)
					Else
						SPACEMAN.of_Rollback();
					End If
					
			//End If	
			
			End If
			
		Next
		
	Else
		This.of_Grava_Log("Nenhum desenho foi localizado para atualiza$$HEX2$$e700e300$$ENDHEX$$o.", True)
		lvb_Sucesso = False
	End If
	
catch (runtimeerror  lo_rte)
	This.of_Grava_Log("Erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'uo_ge218_spaceman.of_atualiza_desenhos(). " +  lo_rte.GetMessage( ), True)
	lvb_Sucesso = False
finally
	Destroy(lvds)
end try

Return lvb_Sucesso
end function

public function boolean of_custo_produto (long al_produto, ref double adc_custo);Decimal lvdc_Custo

Select vl_custo_gerencial_geral 
Into :lvdc_Custo
From produto_central
Where cd_produto = :al_Produto
Using Sqlca;

Choose Case SqlCa.SqlCode
	Case 0
		If IsNull(lvdc_Custo) Then adc_Custo = 0.00
		
		adc_Custo = lvdc_Custo
		
		Return True
	Case 100
		This.of_Grava_Log("O custo do produto '" + String(al_Produto) + "' n$$HEX1$$e300$$ENDHEX$$o foi localizado .", True)
	Case -1
		This.of_Grava_Log("Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do custo do produto '" + String(al_Produto) + "' . "  + SqlCa.SqlErrText, True)
End Choose

Return False
end function

public function boolean of_venda_filial (long al_produto, long al_filial, ref double adc_vendas);If IsNull(idt_Data_Inicial) or idt_Data_Inicial <= Date("01/01/1900") or IsNull(idt_Data_Final) or idt_Data_Final <= Date("01/01/1900") Then
	//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Data do resumo movto do produto da filial inv$$HEX1$$e100$$ENDHEX$$lido.", StopSign!)
	of_envia_email("Data do resumo movto do produto da filial inv$$HEX1$$e100$$ENDHEX$$lido.")
	Return False
End If

Select sum(qt_venda - qt_devolucao_venda)
Into :adc_vendas
From resumo_movto_estq_prd
Where dh_resumo between :idt_Data_Inicial and :idt_Data_Final
    and cd_produto = :al_Produto
   and cd_filial = :al_Filial
 Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If IsNull(adc_vendas) Then adc_vendas = 0.00
		Return True
	Case 100
		This.of_Grava_Log("Vendas do produto '" + String(al_Produto) + "' n$$HEX1$$e300$$ENDHEX$$o foram localizadas .", True)
	Case -1
		This.of_Grava_Log("Erro das vendas do produto '" + String(al_Produto) + "' . "  + SqlCa.SqlErrText, True)
End Choose

Return False
end function

public function boolean of_atualiza_produtos ();Long ll_Produto

SetNull(ll_Produto)

Return This.of_Atualiza_Produtos( ll_Produto )
end function

public subroutine of_teste ();SetPointer(HourGlass!)

Long lvl_Linha, lvl_Desenho, lvl_Filial, lvl_Planograma

string lvs_UF

If This.of_abre_log() Then
	If This.of_conecta_db_spaceman() Then
		Open(w_Aguarde)
			
		of_carrega_planogramas_filiais()
						
//		For lvl_Linha = 1 To ids_desenho_planograma.RowCount() 
//			lvl_Desenho = ids_desenho_planograma.Object.nr_desenho[lvl_Linha]
//			lvl_Planograma = ids_desenho_planograma.Object.cd_planograma[lvl_Linha]
//		Next
//				
//		For lvl_Linha = 1 To ids_desenho_filial.RowCount() 
//			lvl_Desenho = ids_desenho_filial.Object.nr_desenho[lvl_Linha]
//			lvl_Filial = ids_desenho_filial.Object.cd_filial[lvl_Linha]
//			lvs_UF = ids_desenho_filial.Object.cd_uf[lvl_Linha]
//		Next
					
		This.of_desconecta_db_spaceman()
	End If // Conex$$HEX1$$e300$$ENDHEX$$o BD
	
	FileClose(ivi_Log)
End IF // Log

Close(w_Aguarde)

SetPointer(Arrow!)
end subroutine

public function boolean of_media_vendas (long al_produto, ref double adc_vendas, long al_lojas, string as_filiais_in);Long lvl_Vendas, lvl_Linhas

adc_Vendas = 0.00

If IsNull(ivdt_data_resumo_novo) or ivdt_data_resumo_novo <= Date("01/01/1900") or IsNull(ivdt_data_resumo_final_novo) or ivdt_data_resumo_final_novo <= Date("01/01/1900") Then
	//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Data do resumo do produto da filial inv$$HEX1$$e100$$ENDHEX$$lido.", StopSign!)
	of_envia_email("Data do resumo do produto da filial inv$$HEX1$$e100$$ENDHEX$$lido.")
	Return False
End If

dc_uo_ds_base lvds
lvds = Create dc_uo_ds_base

If Not lvds.of_ChangeDataObject("ds_ge218_vendas") Then
	Destroy(lvds)
	Return False
End If

lvds.of_AppendWhere("resumo_produto_filial.cd_filial in (" + as_filiais_in + ")")

If lvds.Retrieve(al_Produto, ivdt_data_resumo_novo, ivdt_data_resumo_final_novo) < 0 Then
	//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao recuperar as informa$$HEX2$$e700f500$$ENDHEX$$es de resumo.")
	of_envia_email("Erro ao recuperar as informa$$HEX2$$e700f500$$ENDHEX$$es de resumo.")
	Destroy(lvds)
	Return False
End If

// 3 meses de vendas

lvl_Linhas = lvds.RowCount()

If lvl_Linhas = 1 Then
	lvl_Vendas = lvds.Object.qt_vendas[1]
	
	If lvl_Vendas > 0 Then
		adc_vendas = round(Round(lvl_Vendas / al_Lojas, 4) / 3, 4)
	End If	
Else
	//Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Problema na recupera$$HEX2$$e700e300$$ENDHEX$$o dos valores de resumo do produto '" + String(al_Produto) + "'.")
	of_envia_email( "Problema na recupera$$HEX2$$e700e300$$ENDHEX$$o dos valores de resumo do produto '" + String(al_Produto) + "'.")
	Destroy(lvds)
	Return False
End If

Destroy(lvds)

Return True
end function

public function boolean of_atualiza_informacoes_filiais (string as_product_id, long al_planograma, double adc_custo);Boolean lvb_Sucesso = True

Double lvdc_Preco_Venda, lvdc_Vendas

Long lvl_Linha, lvl_Linhas, lvl_Filial

String lvs_Achou, lvs_Cluster

If IsNull(ivs_Semana) or Trim(ivs_Semana) = "" Then
	//MessageBox("Aten$$HEX1$$e700$$ENDHEX$$ao", "Semana inv$$HEX1$$e100$$ENDHEX$$lida.")
	of_envia_email("Semana inv$$HEX1$$e100$$ENDHEX$$lida.")
	Return False
End If

If Not of_Filtra_Filiais_Desenho(al_Planograma) Then
	Return False
End If

If as_Product_ID = '711118' Then
	as_Product_ID = '711118' 
End If

lvl_Linhas =  ids_Desenho_Filial.RowCount()

For lvl_Linha = 1 To lvl_Linhas
	
	lvl_Filial 		= ids_Desenho_Filial.Object.cd_filial[lvl_Linha]
	lvs_Cluster 	= String(lvl_Filial)
	
	lvdc_Preco_Venda = Double(ivo_Produto.of_Preco_Venda_Filial_Matriz(lvl_Filial))
	
	If Not of_venda_filial(Long(as_product_id), lvl_Filial, Ref lvdc_Vendas) Then
		lvb_Sucesso = False
		Exit
	End If	
	
	Select product_id
	Into :lvs_Achou
	From acn_product_planner
	Where product_id 		= :as_Product_ID
		and num_cluster 	= :lvs_Cluster
		and semana			= :ivs_semana
	Using SPACEMAN;
	
	Choose Case SPACEMAN.SqlCode
		Case 0
			
			Update acn_product_planner
			Set store =:lvl_Filial , price =:lvdc_Preco_Venda,  reg_movement =:lvdc_Vendas, cost =:adc_custo, num_categoria =:al_Planograma
			Where num_cluster 	= :lvs_Cluster
				and product_id 		= :as_Product_ID
				and semana			= :ivs_semana
			Using SPACEMAN;
			
			If SPACEMAN.SqlCode = -1 Then
				This.of_Grava_Log(is_Chave + " - Atualiza$$HEX2$$e700e300$$ENDHEX$$o do produto '" +  as_product_id + "' . "  + SPACEMAN.SqlErrText, True)
				lvb_Sucesso = False
				Exit
			End If
			
		Case 100
			
			Insert into acn_product_planner(product_id, num_cluster, semana, store, price, reg_movement, cost, num_categoria )
			Values (:as_Product_ID, :lvs_Cluster, :ivs_Semana, :lvl_Filial, :lvdc_Preco_Venda, :lvdc_Vendas, :adc_custo, :al_Planograma)
			Using SPACEMAN;
			
			If SPACEMAN.SqlCode = -1 Then
				This.of_Grava_Log(is_Chave + " - Inclus$$HEX1$$e300$$ENDHEX$$o do produto '" +  as_product_id + "' . "  + SPACEMAN.SqlErrText, True)
				lvb_Sucesso = False
				Exit
			End If
			
		Case -1
			This.of_Grava_Log(is_Chave + " - Localiza$$HEX2$$e700e300$$ENDHEX$$o do produto '" +  as_product_id + "' . "  + SPACEMAN.SqlErrText, True)
			lvb_Sucesso = False
			Exit
	End Choose
	
Next

Return lvb_Sucesso
end function

public function boolean of_filtra_filiais_desenho (long al_desenho);Boolean lb_Sucesso = False

// Limpa os filtros anteriores
ids_desenho_Filial.SetFilter("")
ids_desenho_Filial.Filter()

If ids_desenho_Filial.SetFilter("nr_desenho = " + String(al_Desenho)) = 1 Then
	If ids_desenho_Filial.Filter() = 1 Then
		lb_Sucesso = True
	End If
End If

If Not lb_Sucesso Then
	//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao filtrar as filiais do desenho.")
	of_envia_email("Erro ao filtrar as filiais do desenho.")
End If

Return lb_Sucesso
end function

public function boolean of_filiais_desenho (long al_desenho, ref long al_primeira_filial, ref long al_filiais, ref string as_filiais_in);Long ll_Linha, ll_Filial

If Not This.of_Filtra_Filiais_Desenho(al_Desenho) Then
	Return False
End If

al_filiais = ids_desenho_Filial.RowCount()
		
If al_Filiais > 0 Then
	
	al_Primeira_Filial =  ids_desenho_filial.Object.cd_filial[1]
	
	For ll_Linha = 1 To al_Filiais
		
		ll_Filial = ids_Desenho_Filial.Object.cd_filial[ll_Linha]
		
		If ll_Linha = al_Filiais Then
			as_Filiais_IN += String(ll_Filial)
		Else
			as_Filiais_IN += String(ll_Filial) + ','
		End If
									
	Next
	
Else
	//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma filial foi cadastrada no desenho.")
	of_envia_email("Nenhuma filial foi cadastrada no desenho.")
	Return False
End If

Return True
end function

public function boolean of_insere_produto_desenho (string as_produto, long al_planograma, string as_inclusao_exclusao);Boolean lb_Sucesso = True

Long ll_Find, ll_Linha, ll_Linhas, ll_Desenho, ll_Filiais_Desenho, ll_Primeira_Filial, ll_Desenho_Anterior

Double ldc_Custo_Produto

// Limpa os filtros anteriores
ids_desenho_planograma.SetFilter("")
ids_desenho_planograma.Filter()

// Verifica se existe algum desenho utilizando o planograma do produto
ll_Find = ids_desenho_planograma.Find("cd_planograma = " + String(al_Planograma), 1, ids_desenho_planograma.RowCount() )

If ll_Find > 0 Then
	
		
		// Filtra todos os desenhos que utilizam o planograma
		If ids_desenho_planograma.SetFilter("cd_planograma = " + String(al_Planograma)) = 1 Then
			If ids_desenho_planograma.Filter() = 1 Then
				
				ll_Linhas = ids_desenho_planograma.RowCount()
				
				If Not of_Custo_Produto(Long(as_produto), Ref ldc_Custo_Produto) Then
					Return False
				End If	
				
				If ll_Linhas > 0 Then
					
					try
			
						Open(w_Aguarde_1)
						
						w_Aguarde_1.y = 1604
					
						w_Aguarde_1.uo_Progress.of_SetMax(ll_Linhas)	
				
						For ll_Linha = 1 To ll_Linhas
							
							w_Aguarde_1.Title = 'Atualizando Desenho [' + string(ll_Linha) + ' de ' + string(ll_Linhas) + '] ....'
							
							ll_Desenho = ids_desenho_planograma.Object.nr_desenho[ll_Linha]
							
							//S$$HEX1$$f300$$ENDHEX$$ atualiza quando o pr$$HEX1$$f300$$ENDHEX$$ximo desenho for diferente do anterior
							If ll_Desenho_Anterior = ll_Desenho Then
								Continue
							End If
							
							If ll_Desenho = 629 Then
								ll_Desenho = 629
							End If
							
							If Not This.of_Monta_Chave_Log(ll_Desenho) Then Return False
							
							If Not This.of_Insere_Produto_Desenho(	ll_Desenho, as_produto, &
																				as_inclusao_exclusao, 0, 0, '0', &
																				False, ldc_Custo_Produto) Then
								Return False
							End If
							
							ll_Desenho_Anterior = ll_Desenho
							
							w_Aguarde_1.uo_Progress.of_SetProgress(ll_Linha)	
						Next
						
						finally
							Close(w_Aguarde_1)
						end try
				End If
				
			Else
				//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar filtrar o desenho.")
				of_envia_email("Erro ao localizar filtrar o desenho.")
				Return False
			End If
		Else
			//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar filtrar o desenho.")
			of_envia_email("Erro ao localizar filtrar o desenho.")
			Return False
		End If
	
ElseIf ll_Find = -1 Then
	//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o desendo do planograma.")
	of_envia_email("Erro ao localizar o desendo do planograma.")
	Return False
End If

Return lb_Sucesso
end function

public function boolean of_atualizacao_financeira ();Boolean lvb_Sucesso = True

DateTime ldh_Atual

Long ll_Linhas, ll_Linha, ll_Desenho, ll_Desenho_Anterior, ll_Achou, ll_Contador = 0

String ls_Desenho, ls_Erro

// Limpa os filtros anteriores
ids_desenho_planograma.SetFilter("")
ids_desenho_planograma.Filter()

If ids_desenho_planograma.Sort ( ) = -1 Then
	//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao ordenar os desenhos.", StopSign!)
	of_envia_email("Erro ao ordenar os desenhos.")
	Return False
End If

ll_Linhas = ids_Desenho_Planograma.RowCount()

ldh_Atual = DateTime(Date(gf_GetServerDate()))

If ll_Linhas > 0 Then
	
	For ll_Linha = 1 To ll_Linhas
		
		ll_Desenho = ids_Desenho_Planograma.Object.nr_desenho[ll_Linha]
		
//		If ll_Desenho <> 10925 Then
////			lvl_Planograma = 10925
//			continue
//		End If
		
		If ll_Desenho <> ll_Desenho_Anterior Then
			
			ls_Desenho = String(ll_Desenho)
			
			Select Count(*)
				Into :ll_Achou
			From log_exportacao_spaceman
			Where nm_tabela = "ATUALIZACAO_FINANCEIRA"
				And de_chave = :ls_Desenho
				And dh_atualizacao >= :ldh_Atual
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				ls_Erro = SqlCa.SqlErrText
				of_envia_email("Erro ao verificar se j$$HEX1$$e100$$ENDHEX$$ foi executada a atualiza$$HEX2$$e700e300$$ENDHEX$$o financeira para o desenho " + String(ll_Desenho) + ". " + ls_Erro)
				Return False
			End If
			
			//Se j$$HEX1$$e100$$ENDHEX$$ n$$HEX1$$e300$$ENDHEX$$o foi atualizado no dia corrente, executa o processo de atualiza$$HEX2$$e700e300$$ENDHEX$$o
			If ll_Achou = 0 Then
				
				ll_Contador ++
				
				//Desconecta e conecta de novo a cada 100 desenhos
				If ll_Contador >= 100 Then
					This.of_desconecta_db_spaceman()
					
					If Not This.of_conecta_db_spaceman() Then Return False
					
					ll_Contador = 0
				End If
							
				If This.of_Monta_Chave_Log(ll_Desenho) Then
					If This.of_Atualiza_Desenho(ll_Desenho, string(ll_Desenho), ll_Linha, ll_Linhas) Then
						This.of_Grava_Log("O desenho '" + String(ll_Desenho) + "' foi atualizado com sucesso.", False)
						SPACEMAN.of_Commit();
						
						Insert Into log_exportacao_spaceman(nm_tabela, de_chave, dh_atualizacao, id_atualizacao, id_processado)
								Values("ATUALIZACAO_FINANCEIRA", :ls_Desenho, getdate(), "A", "S")
						Using SqlCa;
						
						If SqlCa.SqlCode = -1 Then
							ls_Erro = SqlCa.SqlErrText
							SqlCa.of_Rollback();							
							of_envia_email("Erro no insert do registro de atualiza$$HEX2$$e700e300$$ENDHEX$$o financeira do desenho " + String(ll_Desenho) + " no log_exportacao_spaceman. " + ls_Erro)
						Else
							SqlCa.of_Commit();
						End If
						
					Else
						SPACEMAN.of_Rollback();
					End If
				End If
			End If
			
			ll_Desenho_Anterior = ll_Desenho
		End If

	Next
	
Else
	//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum desenho foi localizado para ser atualizado.", StopSign!)
	of_envia_email("Nenhum desenho foi localizado para ser atualizado.")
	Return False
End If

Return lvb_Sucesso
end function

public subroutine of_periodo_venda_filial ();Date ldt_Termino

String ls_Dia

ls_Dia = Upper(DayName(ivdt_Movimento))

If ls_Dia = 'SUNDAY' Then
	ldt_Termino = RelativeDate(ivdt_Movimento, -7)
Else
	ldt_Termino = ivdt_Movimento
	DO WHILE ls_Dia <> 'SUNDAY' 
   		ldt_Termino = RelativeDate(ldt_Termino, -1)
		ls_Dia = Upper(DayName(ldt_Termino))	
	LOOP	
End If

idt_Data_Inicial	= RelativeDate(ldt_Termino, -6)
idt_Data_Final	= ldt_Termino

ivdt_data_resumo 		= Date("01/" + String(Month(idt_Data_Inicial)) + "/" + String(Year(idt_Data_Inicial)))
ivdt_data_resumo_final 	= Date("01/" + String(Month(idt_Data_Final)) + "/" + String(Year(idt_Data_Final)))





  
end subroutine

public function integer of_verifica_planograma_desenho (long al_desenho, long al_planograma);Long ll_Find

// Limpa os filtros anteriores
ids_desenho_planograma.SetFilter("")
ids_desenho_planograma.Filter()

// Verifica se existe algum desenho utilizando o planograma do produto
ll_Find = ids_desenho_planograma.Find("nr_desenho = "  + String(al_Desenho) + " and cd_planograma = " + String(al_Planograma), 1, ids_desenho_planograma.RowCount() )
	
Return ll_Find
	
end function

public function boolean of_monta_chave_log (long al_desenho);String ls_Desenho, ls_Planogramas, ls_Filiais

Select PLANOGRAM, CODE, FILIAL
Into 	:ls_Desenho, :ls_Planogramas, :ls_Filiais
from  ACN_PLANOGRAMS
where PLN_ID =:al_Desenho
USING SPACEMAN;	

Choose Case SPACEMAN.SqlCode
	Case 0
			is_Chave = "Desenho: '" +  ls_Desenho + " - " + ls_Filiais + " - " + ls_Planogramas + "' - "	
	Case 100
			This.of_Grava_Log("O planograma '"  + String(al_Desenho) + "' n$$HEX1$$e300$$ENDHEX$$o foi localizado.", True)
	Case -1
		This.of_Grava_Log("Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do planograma '"  + String(al_Desenho) + "'."  + SqlCa.SqlErrText, True)
		Return False
End Choose

Return True
end function

public function boolean of_atualiza_log_exportacao (string as_situacao, string as_tabela);String ls_Chave, ls_Chave_Anterior, ls_Aux

Long ll_Linha, ll_Linhas, ll_Atualizacoes, ll_Achou

// Marca como pendentes
If as_Situacao = 'P' Then
	
	try
		
		Select count(*) 
		Into :ll_Achou
		From log_exportacao_spaceman
		Where id_processado = 'P' 
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			This.of_Grava_Log("Localiza$$HEX2$$e700e300$$ENDHEX$$o de atualiza$$HEX2$$e700f500$$ENDHEX$$es  do log_exportacao_spaceman." + SqlCa.SqlErrText, True)
			SqlCa.of_RollBack();
			Return False
		End If
		
		// Caso j$$HEX1$$e100$$ENDHEX$$ exista algum registro como PENDENTE n$$HEX1$$e300$$ENDHEX$$o inclui mais pendentes, caso contr$$HEX1$$e100$$ENDHEX$$rio vai aumentar muito o n$$HEX1$$fa00$$ENDHEX$$mero de produtos para atualizar.
		If ll_Achou = 0 Then
		
			dc_uo_ds_base lds
			lds = Create dc_uo_ds_base
			If Not lds.of_ChangeDataObject("ds_ge218_log_produto") Then Return False
			
			//ls_Aux = '724404'		
			//lds.of_AppendWhere("l.de_chave = '" + ls_Aux + "'")
			//messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Desenvolvimento.")
					
			// Top 500
			ll_Linhas = lds.Retrieve(as_Tabela)
			
			For ll_Linha = 1 To ll_Linhas
				
				ls_Chave = String(lds.Object.cd_produto[ll_Linha])
				
				If ls_Chave_Anterior <> ls_Chave Then
					Update log_exportacao_spaceman
					Set id_processado   = 'P'
					Where id_processado 	= 'N'
						and nm_tabela			= :as_Tabela
						and de_chave 			= :ls_Chave
					Using SqlCa;			
					ls_Chave_Anterior = ls_Chave
					
					ll_Atualizacoes = Sqlca.SQLNRows
				End If
						
			Next 
			
		End If
	
	finally
		Destroy lds
	end try
	
End If

// Marca como j$$HEX1$$e100$$ENDHEX$$ processados
If as_Situacao = 'S' Then
	Update log_exportacao_spaceman
	Set id_processado   = :as_Situacao
	Where id_processado = 'P'
	  and nm_tabela		= :as_Tabela
    Using SqlCa;
End If

If SqlCa.SqlCode = -1 Then
	This.of_Grava_Log("Atualiza$$HEX2$$e700e300$$ENDHEX$$o da situa$$HEX2$$e700e300$$ENDHEX$$o '" + as_Situacao + "' do log_exportacao_spaceman." + SqlCa.SqlErrText, True)
	SqlCa.of_RollBack();
	Return False
Else
	SqlCa.of_Commit();
	Return True
End If

end function

public function boolean of_processa_limpeza_uso_desenhos ();Boolean lvb_Sucesso = False

If gvo_Aplicacao.ivs_DataSource <> 'central' Then Return True

If This.of_abre_log() Then
	If This.of_conecta_db_spaceman() Then
		Open(w_Aguarde)
		
		If of_Limpa_Uso_Desenhos() Then
			lvb_Sucesso = True
		End If
	
		This.of_desconecta_db_spaceman()
	End If // Conex$$HEX1$$e300$$ENDHEX$$o BD
	
	FileClose(ivi_Log)
End IF // Log

Close(w_Aguarde)

Return lvb_Sucesso
end function

public function boolean of_limpa_uso_desenhos ();Boolean lvb_Sucesso = True

Long lvl_Linha, lvl_Linhas, lvl_Planograma

dc_uo_ds_base lvds

lvds = Create dc_uo_ds_base

lvds.Of_SetTransObject(spaceman)

If Not lvds.of_ChangeDataObject("ds_ge218_desenhos") Then
	Destroy(lvds)
	Return False
End If

w_Aguarde.Title = "Atualizando os desenhos ..."

// Esta vari$$HEX1$$e100$$ENDHEX$$vel $$HEX1$$e900$$ENDHEX$$ populada na chama da fun$$HEX2$$e700e300$$ENDHEX$$o na CO183
If Not IsNull(is_desenho_in) and Trim(is_desenho_in) <> "" Then
	lvds.of_AppendWhere("pln_id in (" + is_desenho_in + ")")
End If

If lvds.Retrieve() < 0 Then
	//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar os planogramas na tabela de dados do SPACEMAN. " + is_desenho_in)
	of_envia_email("Erro ao localizar os planogramas na tabela de dados do SPACEMAN. " + is_desenho_in)
	Destroy(lvds)
	Return False
End If

lvl_Linhas = lvds.RowCount()

If lvl_Linhas > 0 Then
	
	For lvl_Linha= 1 To lvl_Linhas
		
		lvl_Planograma		=  lvds.Object.PLN_id		[lvl_Linha]
		
		Update acn_planograms
		Set inuseby = null
		Where pln_id 		= :lvl_Planograma
		Using SPACEMAN;
		
		If SPACEMAN.SqlCode = -1 Then
			This.of_Grava_Log("Erro ao limpar o uso do desenho '" + String(lvl_Planograma) + "'."  + SPACEMAN.SqlErrText, True)
			Exit
		Else
			SPACEMAN.of_Commit();
			This.of_Grava_Log("O uso do desenho '" + String(lvl_Planograma) + "' foi limpo com sucesso.", False)
		End If
		
	Next
	
Else
	This.of_Grava_Log("Nenhum desenho foi localizado para atualiza$$HEX2$$e700e300$$ENDHEX$$o.", True)
	lvb_Sucesso = False
End If

Destroy(lvds)

Return lvb_Sucesso
end function

public function boolean of_processa_atualizacao_produtos ();Boolean lb_Sucesso = False

String lvs_Nulo

Date lvdt_Nulo

SetNull(lvs_Nulo)
SetNull(lvdt_Nulo)

SetPointer(HourGlass!)

If gvo_Aplicacao.ivs_DataSource <> 'central' Then Return True

Try

	If Not This.of_abre_log() Then
		Return False
	End If
	
	If Not This.of_conecta_db_spaceman() Then
		Return False
	End If
	
	Open(w_Aguarde)

		Try
						
			This.of_Grava_Log("In$$HEX1$$ed00$$ENDHEX$$cio da Atualiza$$HEX2$$e700e300$$ENDHEX$$o dos Produtos", False)
			
			// Carrega os planogramas e as filiais dos desenhos
			If This.of_Carrega_Planogramas_Filiais() Then
				If This.of_Atualiza_Log_Exportacao("P", "PRODUTO_GERAL") Then 
					If This.of_Periodos(lvs_Nulo, lvdt_Nulo, lvdt_Nulo) Then
						If This.of_Atualiza_Produtos( ) Then
							This.of_Atualiza_Log_Exportacao("S", "PRODUTO_GERAL")
							lb_Sucesso = True
							//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Os produtos foram atualizados com sucesso.")
						End If
					End If
				End If
			End If
			
			This.of_Grava_Log("T$$HEX1$$e900$$ENDHEX$$rmino da Atualiza$$HEX2$$e700e300$$ENDHEX$$o dos Produtos", False)
		
		Catch ( runtimeerror  lo_rte )
			This.of_Grava_Log( "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o dos produtos do Spaceman. Erro: "+lo_rte.GetMessage( ), True)				
			Return False                                                                                    
		End Try
			
Finally
	FileClose(ivi_Log)
	This.of_desconecta_db_spaceman()
	Close(w_Aguarde)
End Try

SetPointer(Arrow!)

// S$$HEX1$$f300$$ENDHEX$$ vai entrar se o processo N$$HEX1$$c300$$ENDHEX$$O for disparado pelo processo automatico do fechamento do carga fun$$HEX2$$e700e300$$ENDHEX$$o wf_atualizacao_spaceman.
If lb_Sucesso and ib_processo_automatico_ca = False Then

	Long  lvl_Registro
	
	Select count(*)
	Into :lvl_Registro
	From log_exportacao_spaceman
	Where nm_tabela = 'PRODUTO_GERAL'
	    and id_processado = 'N'
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o dos registros")
	Else
		If lvl_Registro > 0 Then
			lb_Sucesso  = of_processa_atualizacao_produtos()
		End If
	End If

End If

Return lb_Sucesso 
end function

public function boolean of_carrega_planogramas_filiais ();Boolean lvb_Sucesso = True

Long lvl_Linha, lvl_Linhas, lvl_Desenho

String lvs_Filiais, lvs_Planogramas, ls_Desenho, ls_Perfil, ls_Regiao, ls_Category, ls_Department, Subcategory

dc_uo_ds_base lvds

lvds = Create dc_uo_ds_base

lvds.Of_SetTransObject(spaceman)
	
If Not lvds.of_ChangeDataObject("ds_ge218_desenhos") Then
	Destroy(lvds)
	Return False
End If

w_Aguarde.Title = "Verificando as Filiais e Planogramas ..."

If lvds.Retrieve() < 0 Then
	//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar os planogramas na tabela de dados do SPACEMAN." )
	of_envia_email("Erro ao localizar os planogramas na tabela de dados do SPACEMAN.")
	Destroy(lvds)
	Return False
End If

lvl_Linhas = lvds.RowCount()

If lvl_Linhas > 0 Then
	
	For lvl_Linha= 1 To lvl_Linhas		
		lvs_Filiais 			= lvds.Object.FILIAL			[lvl_Linha]
		lvs_Planogramas 	= lvds.Object.CODE			[lvl_Linha]
		lvl_Desenho			= lvds.Object.PLN_id			[lvl_Linha]
		ls_Desenho			= lvds.Object.PLANOGRAM	[lvl_Linha]
		ls_Perfil				= lvds.Object.perfil			[lvl_Linha]
		ls_Regiao			= lvds.Object.regiao			[lvl_Linha]
		ls_Category			= lvds.Object.Category		[lvl_Linha]
		ls_Department		= lvds.Object.Department	[lvl_Linha]
		Subcategory			= lvds.Object.Subcategory	[lvl_Linha]
		
		is_Chave = ls_Desenho + " - " + lvs_Filiais + " - " + lvs_Planogramas + " - "
						
		If Not IsNull(lvs_Planogramas) and Trim(lvs_Planogramas) <> "" Then 
			If Not This.of_valida_planogramas(lvs_Planogramas, lvl_Desenho, ls_Desenho, lvs_Filiais, ls_Perfil, ls_Regiao, ls_Category, ls_Department, Subcategory) Then
				If of_exclui_desenho_planograma(lvl_Desenho) Then
					// N$$HEX1$$e300$$ENDHEX$$o vai incluir as filiais
					Continue
				Else
					Return False
				End If
			End If
		Else
			This.of_Grava_Log("N$$HEX1$$e300$$ENDHEX$$o existem planogramas definidos para o desenho '" + String(lvl_Desenho) + "' .", True)
			Continue
			//Return False
		End If
		
		If Not IsNull(lvs_Filiais) and Trim(lvs_Filiais) <> "" Then 
			If Not of_Valida_Filiais(lvs_Filiais, lvl_Desenho, ls_Desenho) Then
				of_exclui_desenho_filial(lvl_Desenho)
				of_exclui_desenho_planograma(lvl_Desenho)
			End If
		Else
			of_exclui_desenho_planograma(lvl_Desenho)
			This.of_Grava_Log("N$$HEX1$$e300$$ENDHEX$$o existem filiais definidas para o desenho '" + String(lvl_Desenho) + "' .", True)
			//Return False
		End If
	
	Next
		
//	If ids_desenho_planograma.RowCount() > 0 Then
//		ids_desenho_planograma.SaveAs("D:\TEMP\PLANOGRAMAS.XLS", Excel!, TRUE)
//	End If	
	
Else
	This.of_Grava_Log("Nenhum desenho foi localizado para atualiza$$HEX2$$e700e300$$ENDHEX$$o.", True)
	lvb_Sucesso = False
End If

Destroy(lvds)

Return lvb_Sucesso
end function

public function boolean of_exclui_desenho_planograma (long al_desenho);boolean lv_Sucesso = True

Long lvl_Linhas, lvl_Linha

Long ll_Find

ll_Find = ids_desenho_planograma.Find("nr_desenho = " + string(al_Desenho), 1, ids_desenho_planograma.RowCount())

If ll_Find = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o desenho '" + String(al_Desenho) + "'")
	Return False
End If

do while ll_Find > 0
	
	ids_desenho_planograma.DeleteRow(ll_Find) 
	
	ll_Find = ids_desenho_planograma.Find("nr_desenho = " + string(al_Desenho), 1, ids_desenho_planograma.RowCount())

	If ll_Find = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o desenho '" + String(al_Desenho) + "'")
		lv_Sucesso = False
		exit
	End If
loop


//For lvl_Linha = 1 To ids_desenho_planograma.RowCount()
//	
//	If ids_desenho_planograma.Object.nr_desenho[lvl_Linha] = al_Desenho Then
//		ids_desenho_planograma.DeleteRow(al_Desenho) 
//	End If
//	
//Next

//
//
//ids_desenho_planograma.Object.nr_desenho		[ll_Insert] = al_Desenho
//ids_desenho_planograma.Object.cd_planograma	[ll_Insert] = al_Planograma
//ids_desenho_planograma.Object.de_desenho		[ll_Insert] = as_desenho

Return lv_Sucesso
end function

public function boolean of_valida_filiais (string as_filiais, long al_desenho, string as_desenho);Boolean lvb_Sucesso = True

String lvs_Char, lvs_Filial, lvs_Situacao, lvs_UF, lvs_UF_Anterior, lvs_Mensagem

Long lvl_Filial, lvl_Linha, lvl_Filial_Anterior

Integer lvi_Pos, lvi_Linha, lvi_Controle = 0

For lvi_Linha = 1 To 150
	lvs_Char = MidA(as_Filiais, lvi_Linha, 1)
	
	If lvs_Char = "" Then
		lvi_Controle ++
		
		If Not IsNumber(lvs_Filial) Then
			This.of_Grava_Log("O c$$HEX1$$f300$$ENDHEX$$digo da filial '" + lvs_Filial + "' informada no planograma (desenho) '" +  as_Desenho + "(" + String(al_Desenho) + ")' $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lida.", True)
			lvb_Sucesso = False
			Exit
		End If
		
		//ivl_Array_Filial[lvi_Controle] = Long(lvs_Filial)
		
		If Not of_Insere_Desenho_Filial(al_Desenho, Long(lvs_Filial), as_Desenho) Then
			lvb_Sucesso = False
			Exit
		End If
		
		lvs_Filial = ""
		Exit
		
	Else
		If lvs_Char <> "," Then
			lvs_Filial = lvs_Filial + lvs_Char			
		Else
			lvi_Controle ++
			
			If Not IsNumber(lvs_Filial) Then
				//This.of_Grava_Log("O c$$HEX1$$f300$$ENDHEX$$digo da filial '" + lvs_Filial + "' informada no planograma (desenho) '" + String(al_Desenho) + "' $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lida.", True)
				This.of_Grava_Log("O c$$HEX1$$f300$$ENDHEX$$digo da filial '" + lvs_Filial + "' informada no planograma (desenho) '" +  as_Desenho + "(" + String(al_Desenho) + ")' $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lida.", True)
				lvb_Sucesso = False
				Exit
			End If		
			
			//ivl_Array_Filial[lvi_Controle] = Long(lvs_Filial)
			
			If Not of_Insere_Desenho_Filial(al_Desenho, Long(lvs_Filial), as_Desenho) Then
				lvb_Sucesso = False
				Exit
			End If
						
			lvs_Filial = ""
		End If
	End If
Next

Return lvb_Sucesso


end function

public function boolean of_insere_desenho_filial (long al_desenho, long al_filial, string as_desenho);Long ll_Achou, ll_Insert, ll_Filial_Anterior

String ls_Situacao, ls_UF, ls_UF_Anterior, ls_Mensagem

Select f.id_situacao, c.cd_unidade_federacao
Into :ls_Situacao, :ls_UF
From filial f, cidade c
Where f.cd_filial 		= :al_Filial
	  and c.cd_cidade	= f.cd_cidade
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		
//		If (ls_UF_Anterior = "SC" or ls_UF_Anterior = "RS") and ls_UF = "PR" Then
//			ls_Mensagem = 	"A UF '" + ls_UF_Anterior + "' da filial '" + String(ll_Filial_Anterior, "000") +&
//									"' $$HEX1$$e900$$ENDHEX$$ diferente da UF '" + ls_UF + "' da filial '" + String(al_Filial) +&
//									"' no planograma (desenho) '" + String(al_Desenho) + "'."
//			This.of_Grava_Log(ls_Mensagem, True)
//			Return False
//		End If
//		
//		If (ls_UF = "SC" or ls_UF = "RS") and ls_UF_Anterior = "PR" Then
//			ls_Mensagem =	"A UF '" + ls_UF + "' da filial '" + String(al_Filial, "000") +&
//									"' $$HEX1$$e900$$ENDHEX$$ diferente da UF '" +	ls_UF_Anterior + "' da filial '" +&
//									String(ll_Filial_Anterior) + "' no planograma (desenho) '" + String(al_Desenho) + "'."
//			This.of_Grava_Log(ls_Mensagem, True)
//			Return False
//		End If
//		
//		ls_UF_Anterior 		=	ls_UF 
//		ll_Filial_Anterior	=	al_Filial
						
		If ls_Situacao <> 'A' Then
			//This.of_Grava_Log("A filial '" + String(al_Filial, "000") + "' informada no planograma (desenho) '" + as_Desenho + " (" + String(al_Desenho) + ")' n$$HEX1$$e300$$ENDHEX$$o esta ATIVA.", True)
			//Return False
		End If
		
	Case 100
		This.of_Grava_Log("A filial '" + String(al_Filial, "000") + "' informada no planograma (desenho) '" + as_Desenho + " (" +  String(al_Desenho) + ")' n$$HEX1$$e300$$ENDHEX$$o foi localizada.", True)
		Return False
	Case -1 
		This.of_Grava_Log("Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o da filial '" + String(al_Filial, "000") + "' no planograma (desenho) '" + String(al_Desenho) + "'. "  + SqlCa.SqlErrText, True)
		Return False
End Choose

ll_Insert = ids_desenho_Filial.InsertRow(0) 

ids_desenho_Filial.Object.nr_desenho[ll_Insert] = al_Desenho
ids_desenho_Filial.Object.cd_filial		[ll_Insert] = al_Filial
ids_desenho_Filial.Object.cd_uf		[ll_Insert] = ls_UF

Return True





end function

public function boolean of_exclui_desenho_filial (long al_desenho);boolean lv_Sucesso = True

Long lvl_Linhas, lvl_Linha

Long ll_Find

ll_Find = ids_desenho_filial.Find("nr_desenho = " + string(al_Desenho), 1, ids_desenho_filial.RowCount())

If ll_Find = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o desenho '" + String(al_Desenho) + "'")
	Return False
End If

do while ll_Find > 0
	
	ids_desenho_filial.DeleteRow(ll_Find) 
	
	ll_Find = ids_desenho_filial.Find("nr_desenho = " + string(al_Desenho), 1, ids_desenho_filial.RowCount())

	If ll_Find = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o desenho '" + String(al_Desenho) + "'")
		lv_Sucesso = False
		exit
	End If
loop

Return lv_Sucesso
end function

public function boolean of_grava_historico (long pl_produto, long pl_desenho);Boolean lb_Sucesso = True

Insert Into historico_spaceman(
	cd_produto,
	nr_desenho)
Values(	:pl_Produto,
			:pl_Desenho)
Using SqlCa;

If SqlCa.SqlCode <> 0 Then
	This.of_Grava_Log("Erro ao inserir o produto '" + String(pl_Produto) + "' na tabela historico_spaceman.", False)

	//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao inserir o produto '" + String(pl_Produto) + "' na tabela historico_spaceman.", StopSign!)
	of_envia_email("Erro ao inserir o produto '" + String(pl_Produto) + "' na tabela historico_spaceman.")
	lb_Sucesso = False
End If

Return lb_Sucesso
end function

public function boolean of_periodos (string as_semana, date adt_inicio, date adt_termino);Date lvd_Inicio_Ano
of_Periodo_Venda_Filial_Nova()

If IsNull(as_Semana) Then

	ivdt_Movimento = Date(gf_GetServerDate())
	
	lvd_Inicio_Ano = Date("01/01/" + String(Year(ivdt_Movimento)))
		
	//lvd_Inicio_Ano = RelativeDate(Date(String(ivdt_Movimento, "yyyy") + "/01/01"),3)
	
	ivs_Semana = String(Year(ivdt_Movimento)) + String(Round(DaysAfter(lvd_Inicio_Ano, ivdt_Movimento ) / 7, 0 ), "00")
	
	of_Periodo_Venda_Filial()

Else
	
	ivs_Semana = as_Semana
	
	idt_Data_Inicial	= adt_inicio
	idt_Data_Final	= adt_termino

	ivdt_data_resumo 		= Date("01/" + String(Month(idt_Data_Inicial)) + "/" + String(Year(idt_Data_Inicial)))
	ivdt_data_resumo_final 	= Date("01/" + String(Month(idt_Data_Final)) + "/" + String(Year(idt_Data_Final)))
	
End If

Return True
end function

public function boolean of_processa_atualizacao_desenhos (string as_semana, date adt_inicio, date adt_termino);Boolean lvb_Sucesso = False

If gvo_Aplicacao.ivs_DataSource <> 'central' Then Return True

If This.of_abre_log() Then
	If This.of_conecta_db_spaceman() Then
		Open(w_Aguarde)
		
		// Carrega os planogramas e as filiais dos desenhos
		If This.of_Carrega_Planogramas_Filiais() Then
			If of_periodos(as_semana, adt_inicio, adt_termino) Then
				
				If ib_Atualiza_Desenho_por_Produto Then										
					If This.of_Atualiza_Desenho_por_Produtos() Then
						If This.of_Atualiza_Estoque_minimo() Then //Formato antigo (n$$HEX1$$e300$$ENDHEX$$o cluster)
							If This.of_Atualiza_Estoque_minimo_cluster() Then //Formato novo (cluster)
								lvb_Sucesso = True
							End If
						End if
					End If	
				Else
					If of_Atualiza_Desenhos() Then
						lvb_Sucesso = True
						//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Os desenhos foram atualizados com sucesso.")
					End If
				End If
			End If
		End If
						
		This.of_desconecta_db_spaceman()
	End If // Conex$$HEX1$$e300$$ENDHEX$$o BD
	
	FileClose(ivi_Log)
End If // Log

Close(w_Aguarde)

Return lvb_Sucesso
end function

public function boolean of_processa_atualizacao_financeira (string as_semana, date adt_inicio, date adt_termino);Boolean lb_Sucesso = False

If gvo_Aplicacao.ivs_DataSource <> 'central' Then Return True

SetPointer(HourGlass!)

If This.of_abre_log() Then
	If This.of_conecta_db_spaceman() Then
		Open(w_Aguarde)
				
		This.of_Grava_Log("In$$HEX1$$ed00$$ENDHEX$$cio da Atualiza$$HEX2$$e700e300$$ENDHEX$$o Financeira", False)
		
		// Carrega os planogramas e as filiais dos desenhos
		If This.of_Carrega_Planogramas_Filiais() Then
			If This.of_periodos(as_semana, adt_inicio, adt_termino) Then
				If This.of_Atualizacao_Financeira() Then
					lb_Sucesso = True
					//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Os produtos foram atualizados com sucesso.")
				End If
			End If
		End If
		
		This.of_Grava_Log("T$$HEX1$$e900$$ENDHEX$$rmino da Atualiza$$HEX2$$e700e300$$ENDHEX$$o Financeira", False)
						
		This.of_desconecta_db_spaceman()
	End If // Conex$$HEX1$$e300$$ENDHEX$$o BD
	
	FileClose(ivi_Log)
End IF // Log

Close(w_Aguarde)

SetPointer(Arrow!)

Return lb_Sucesso
end function

public function boolean of_atualiza_produtos (long pl_produto);Boolean lvb_Sucesso = True

Double PROD_SIZE, lvd_HEIGHT, lvd_WIDTH, DEPTH

String 	PRODUCT_ID,&
			UPC,&
			PROD_NAME,&      
			UOM,&             
			MANUFACTURER,&    
			SPM,&             
			CATEGORY,&        
			SUBCATEGORY_SPM,& 
			DESC_A,&          
			DESC_C,&          
			DESC_D,&          
			DESC_E,&          
			DESC_F,&          
			DESC_G,&          
			DESC_H,&          
			DESC_I,& 
			MODEL_SCHED,& 
			PREFERRED_FIXEL,&
			ls_Situacao,&
			PLANOGRAMA

decimal 	TRAY_HEIGHT,&     
			TRAY_WIDTH,&      
			TRAY_DEPTH,&
			CASE_HEIGHT,&     
			CASE_WIDTH,&      
			CASE_DEPTH,&      
			DISPLAY_HEIGHT,&  
			DISPLAY_WIDTH,&   
			DISPLAY_DEPTH,&   
			MAX_HORIZ_CRUSH,& 
			MAX_VERT_CRUSH,&  
			MAX_DEPTH_CRUSH 

decimal COD_CATEGORY 

int 	UNITS_CASE,& 
		UNITS_TRAY,&  
		cd_planograma 

long lvl_linha, lvl_linhas, lvl_Contador

dc_uo_ds_base ds_Produtos
ds_Produtos = create dc_uo_ds_base

If Not ds_produtos.of_changedataobject( "ds_ge218_produtos") Then
	Destroy(ds_Produtos)
	Return False
End If

If Not IsNull( pl_Produto ) Then
	//AppenWhere por produto
	ds_produtos.of_AppendWhere( "pg.cd_produto = " + String( pl_Produto ) )	
Else
	//Wagner
	//Retirado do sql original da dw ds_ge218_produtos
	ds_produtos.of_AppendWhere("pg.cd_produto in (select distinct cast(de_chave as int)  from log_exportacao_spaceman " + &
												 " where id_processado = 'P' and nm_tabela = 'PRODUTO_GERAL' ) " )
End If

lvl_Linhas =  ds_produtos.retrieve()

If lvl_Linhas < 0 Then
	//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar os produtos na tabela de dados do SPACEMAN.")
	of_envia_email("Erro ao localizar os produtos na tabela de dados do SPACEMAN.")
	Destroy( ds_Produtos )
	Return False
End If

w_aguarde.uo_progress.of_SetMax(lvl_Linhas)

w_Aguarde.Title = "Atualizando os Produtos no BD do SPACEMAN ..."

For lvl_Linha = 1 to lvl_Linhas
				
		PRODUCT_ID		  	=   String(ds_Produtos.object.product_id				[lvl_linha])
		UPC				  		=   ds_Produtos.object.UPC								[lvl_linha]
		PROD_NAME		  	=   mid(ds_Produtos.object.PROD_NAME				[lvl_linha],1,50)
	 	PROD_SIZE        		=   ds_Produtos.object.PROD_SIZE					[lvl_linha]       
	 	UOM              			=   mid(ds_Produtos.object.UOM						[lvl_linha],1,5)             
		MANUFACTURER     	=   mid(ds_Produtos.object.MANUFACTURER		[lvl_linha],1,32)    
		SPM              			=   mid(ds_Produtos.object.BRAND_SPM				[lvl_linha],1,100)             
		CATEGORY         		=   mid(ds_Produtos.object.CATEGORY				[lvl_linha],1,32)        
		SUBCATEGORY_SPM  = 	mid(string(ds_Produtos.object.SUBCATEGORY_SPM[lvl_linha]),1,100)
		COD_CATEGORY     	=   Dec(ds_Produtos.object.COD_CATEGORY		[lvl_linha])
		DESC_A           		=   mid(String(ds_Produtos.object.DESC_A			[lvl_linha]),1,100)                   
		
		lvd_HEIGHT       		=   ds_Produtos.object.HEIGHT							[lvl_linha]          
		lvd_WIDTH        		=   ds_Produtos.object.WIDTH							[lvl_linha]           
		DEPTH            			=   ds_Produtos.object.DEPTH							[lvl_linha]           
		TRAY_HEIGHT      		=   ds_Produtos.object.tray_height					[lvl_linha]     
		TRAY_WIDTH       		=   ds_Produtos.object.TRAY_WIDTH					[lvl_linha]      
		TRAY_DEPTH       		=   ds_Produtos.object.TRAY_DEPTH					[lvl_linha]      
		UNITS_CASE       		=   ds_Produtos.object.UNITS_CASE					[lvl_linha]     
		UNITS_TRAY       		=   ds_Produtos.object.UNITS_TRAY					[lvl_linha]      
		PREFERRED_FIXEL  	=   String(ds_Produtos.object.PREFERRED_FIXEL	[lvl_linha]) 
		CASE_HEIGHT      		=   ds_Produtos.object.CASE_HEIGHT					[lvl_linha]     
		CASE_WIDTH       		=   ds_Produtos.object.CASE_WIDTH					[lvl_linha]      
		CASE_DEPTH       		=   ds_Produtos.object.CASE_DEPTH					[lvl_linha]      
		DISPLAY_HEIGHT   	=   ds_Produtos.object.DISPLAY_HEIGHT				[lvl_linha]  
		DISPLAY_WIDTH    	=   ds_Produtos.object.DISPLAY_WIDTH				[lvl_linha]   
		DISPLAY_DEPTH    	=   ds_Produtos.object.DISPLAY_DEPTH				[lvl_linha]   
		MAX_HORIZ_CRUSH  	=   ds_Produtos.object.MAX_HORIZ_CRUSH			[lvl_linha] 
		MAX_VERT_CRUSH   	=   ds_Produtos.object.MAX_VERT_CRUSH			[lvl_linha]  
		MAX_DEPTH_CRUSH  =   ds_Produtos.object.MAX_DEPTH_CRUSH		[lvl_linha] 
		MODEL_SCHED      	=   String(ds_Produtos.object.MODEL_SCHED		[lvl_linha])     
		//cd_planograma    	=   ds_Produtos.object.cd_planograma[lvl_linha] 	
		ls_Situacao				= ds_Produtos.object.id_situacao						[lvl_linha] 	
		PLANOGRAMA			= ds_Produtos.object.PLANOGRAMA					[lvl_linha] 
		
		If PRODUCT_ID = '508600' then
			PRODUCT_ID = '508600'
		End If
		
		w_Aguarde.Title = "Atual. Produtos SPACEMAN. Prod. [" + PRODUCT_ID + "].  [ "  + String(lvl_Linha) + ' de ' + String(lvl_Linhas) + " ] ..."
		
		If Not 	This.of_Atualiza_Produto(PRODUCT_ID, UPC, PROD_NAME, PROD_SIZE, UOM,&
												MANUFACTURER,SPM,CATEGORY,SUBCATEGORY_SPM,&
												COD_CATEGORY,DESC_A,DESC_C,DESC_D,DESC_E,&
												DESC_F,DESC_G,DESC_H,DESC_I,lvd_HEIGHT,lvd_WIDTH,&
												DEPTH,TRAY_HEIGHT,TRAY_WIDTH,TRAY_DEPTH,UNITS_CASE,&
												UNITS_TRAY,PREFERRED_FIXEL,CASE_HEIGHT,CASE_WIDTH,&
												CASE_DEPTH,DISPLAY_HEIGHT,DISPLAY_WIDTH,DISPLAY_DEPTH ,&
												MAX_HORIZ_CRUSH,MAX_VERT_CRUSH,MAX_DEPTH_CRUSH,&
												MODEL_SCHED,ls_Situacao, PLANOGRAMA) Then
												
			lvb_Sucesso = False
			Exit
		Else
			lvl_Contador ++
			// o comit esta dentro a fun$$HEX2$$e700e300$$ENDHEX$$o de inclus$$HEX1$$e300$$ENDHEX$$o de produto			
			SPACEMAN.of_Commit();
			
//			If lvl_Contador >= 50 Then
//				SPACEMAN.of_Commit();
//				lvl_Contador = 0
//			End If
		End If
		
		w_aguarde.uo_progress.of_SetProgress(lvl_Linha)
Next

Destroy(ds_Produtos)

//Desenvolvimento
//lvb_Sucesso = False


//Se for atualizacao de desenho por produtos
//o commit ser$$HEX1$$e100$$ENDHEX$$ no termino da funcao of_atualiza_desenho_por_produto()
IF Not ib_Atualiza_Desenho_por_Produto Then
	// Commit
	If lvb_Sucesso Then
		SPACEMAN.of_Commit();
	Else
		SPACEMAN.of_Rollback();
	End If
End If

w_aguarde.uo_progress.of_Reset()

Return lvb_Sucesso
end function

public function boolean of_atualiza_estoque_minimo ();Boolean lb_Sucesso

Long ll_Row
Long ll_Qtde

Long ll_Produto
Long ll_Filial
Long ll_Estoque_Minimo_Atual
Long ll_Promocao_SOS
Long ll_Retorno
Long ll_Estoque_Minimo

String ls_Chave

If This.il_Motivo = 0 Then
	SetNull(This.il_Motivo)
End If

ll_Qtde = UpperBound(  il_Filiais[] )

For ll_Row = 1 To ll_Qtde
	
	lb_Sucesso = False
	
	ll_Filial  							= il_Filiais					[ ll_Row ]
	ll_Produto 						= il_Produtos				[ ll_Row ]
	ll_Estoque_Minimo_Atual		= il_Estoque_Minimo 		[ ll_Row ]
	
	//Se est$$HEX1$$e100$$ENDHEX$$ preenchida a promo$$HEX2$$e700e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ porque a filial est$$HEX1$$e100$$ENDHEX$$ no cluster. A atualiza$$HEX2$$e700e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ realizada na fun$$HEX2$$e700e300$$ENDHEX$$o of_atualiza_estoque_minimo_cluster
	If il_Promocao[ ll_Row ] > 0 Then
		lb_Sucesso = True
		Continue
	End If

	//Ir$$HEX1$$e100$$ENDHEX$$ localizar se o produto esta ativo na promocao_sos
	
	Select count(*), max(p.cd_promocao_sos)
		Into :ll_Retorno, :ll_Promocao_SOS
	From promocao_sos p
	Inner Join promocao_sos_produto pp
			on pp.cd_promocao_sos 	= p.cd_promocao_sos
	Inner Join promocao_sos_filial f
			on f.cd_promocao_sos 	= p.cd_promocao_sos
	Inner Join parametro x
			on x.id_parametro 		= x.id_parametro
	where p.id_tipo_promocao 	= 'P'		
	and p.dh_inicio 		<= x.dh_movimentacao		
	and (p.dh_termino	>= x.dh_movimentacao Or p.dh_termino is null)		
	and pp.cd_produto 	= :ll_Produto
	and f.cd_filial 			= :ll_Filial
	Using SqlCa;
		
	ls_Chave = String(ll_Filial) + " - " + String(ll_Produto) + " - Estoque Minimo: " + String(ll_Estoque_Minimo_Atual)
	
	Choose Case SqlCa.SqlCode
		
		Case -1
			This.of_Grava_Log(is_Chave + "Erro na consulta da promocao SOS: '" +  ls_Chave + "." + SqlCa.SqlErrText, True)
			lb_Sucesso = False	
		Case 0
						
			//-----------------------------------------Incluir o Estoque munimo atraves da promocao ativa da Filial---------------------------
			If ll_Retorno = 0 Then
				
				//Localiza uma promocao ativa na filial 
				Select max(p.cd_promocao_sos)
					Into :ll_Promocao_SOS
				From promocao_sos p 		
				Inner Join promocao_sos_filial f		
						on f.cd_promocao_sos 	= p.cd_promocao_sos
				Inner Join parametro x		
						on x.id_parametro 		= x.id_parametro
				where p.id_tipo_promocao 	= 'P'		
				and p.dh_inicio 		<= x.dh_movimentacao		
				and (p.dh_termino	>= x.dh_movimentacao Or p.dh_termino is null)
				and f.cd_filial 			= :ll_Filial
				Using SqlCa;
				
				Choose Case SqlCa.SqlCode
					
					Case 0
						
						If Not IsNull(ll_Promocao_SOS) Then
													
							//---------------------------Inclui o produto na promocao sos
							//Se localizou a promocao 'P' na filial	
							Insert Into promocao_sos_produto(
								cd_promocao_sos,
								cd_produto,
								pc_desconto) 
							Values(:ll_Promocao_SOS, 
										:ll_Produto, 
										0.00 )
							Using SqlCa;
							
							If SqlCa.SqlCode = 0 Then
								This.of_Grava_Log(is_Chave + "Produto cadastrado com sucesso na promocao_sos_produto: Chave: " + String(ll_Promocao_SOS) + " - " + String(ll_Produto) + ".", False )
								lb_Sucesso = True
							Else
								This.of_Grava_Log(is_Chave + "Erro ao inserir o produto na Promocao SOS Produto: Promocao: " + String(ll_Promocao_SOS) + " Produto: " + String(ll_Produto) + ".", True )
								lb_Sucesso = False	
							End If
						
						Else
							//----Se n$$HEX1$$e300$$ENDHEX$$o achou nenhuma promocao planograma
							This.of_Grava_Log(is_Chave + "Promo$$HEX2$$e700e300$$ENDHEX$$o Planograma n$$HEX1$$e300$$ENDHEX$$o localizada: Filial: " + String(ll_Filial) + ".", True )
							lb_Sucesso = False		
						End If

					Case 100
//						//-------------------------------Se n$$HEX1$$e300$$ENDHEX$$o achou nenhuma promocao planograma
//						This.of_Grava_Log(is_Chave + "Promo$$HEX2$$e700e300$$ENDHEX$$o Planograma n$$HEX1$$e300$$ENDHEX$$o localizada: Filial: " + String(ll_Filial) + ".", True )
						lb_Sucesso = False					
					Case -1
						This.of_Grava_Log(is_Chave + "Erro ao localizar a Promocao SOS: Filial: " + String(ll_Filial) + ".", True )
						lb_Sucesso = False
				End Choose
							
			End If
			
			If ll_Retorno > 1 Then
				This.of_Grava_Log(is_Chave + "Promocao duplicada: " + String(ll_Promocao_SOS) + " - " + ls_Chave + ".", True )
			End If
			
			If ll_Retorno = 1 Then
				lb_Sucesso = True
			End if
			
	End Choose
	
	If lb_Sucesso Then
		
		ls_Chave = String(ll_Promocao_SOS) + " - " + ls_Chave
		
		Select qt_estoque_minimo
			Into :ll_Estoque_Minimo 
		from promocao_sos_estoque_minimo
			Where cd_promocao_sos 		= :ll_Promocao_SOS
				and cd_produto 				= :ll_Produto
				and cd_filial 					= :ll_Filial
		Using SqlCa;		
		
		Choose Case SqlCa.SqlCode
		
			Case 100
				//Se n$$HEX1$$e300$$ENDHEX$$o localizou, ser$$HEX1$$e100$$ENDHEX$$ incluso o produto na promocao_sos
				
				Insert Into promocao_sos_estoque_minimo
					(cd_promocao_sos,
					cd_filial,
					cd_produto,
					qt_estoque_minimo,
					nr_matricula_alteracao,
					cd_motivo_alteracao,
					qt_estoque_minimo_matriz)
				Values(	:ll_Promocao_SOS,
							:ll_Filial,
							:ll_Produto,
							:ll_Estoque_Minimo_Atual,
							:gvo_Aplicacao.ivo_Seguranca.Nr_Matricula,
							:This.il_Motivo,
							:ll_Estoque_Minimo_Atual)
				Using SqlCa;
							
				If SqlCa.SqlCode = 0 Then
					This.of_Grava_Log(is_Chave + "Estoque minimo do produto foi incluido com sucesso. Tabela promocao_sos_estoque_minimo: " + ls_Chave +"'. ", False )
					lb_Sucesso = True
				Else
					This.of_Grava_Log(is_Chave + "Erro no insert do produto na tabela promocao_sos_estoque_minimo. '" +  ls_Chave + "' . "  + SqlCa.SqlErrText, True)
					lb_Sucesso = False
				End If

			Case -1
				This.of_Grava_Log(is_Chave + "Erro no select do qt_estoque minimo da tabela promocao_sos_estoque_minimo: '" +  ls_Chave + "' . "  + SqlCa.SqlErrText, True)
				lb_Sucesso = False	
			Case 0
				
				//Se localizou, ser$$HEX1$$e100$$ENDHEX$$ atribu$$HEX1$$ed00$$ENDHEX$$do o novo valor para o estoque minimo
				If ll_Estoque_Minimo > 0 And ll_Estoque_Minimo <> ll_Estoque_Minimo_Atual Then 
					
					//This.of_Grava_Log(is_Chave + "Estoque Minimo j$$HEX1$$e100$$ENDHEX$$ cadastrado. '" + ls_Chave + "' . ", False)
					//Continue
					
					Update promocao_sos_estoque_minimo
						set qt_estoque_minimo 			= :ll_Estoque_Minimo_Atual,
							 qt_estoque_minimo_matriz	= :ll_Estoque_Minimo_Atual,
							nr_matricula_alteracao		= :gvo_Aplicacao.ivo_Seguranca.Nr_Matricula,
							cd_motivo_alteracao			= :This.il_Motivo
						Where cd_promocao_sos 		= :ll_Promocao_SOS
							and cd_produto 				= :ll_Produto
							and cd_filial 					= :ll_Filial
						Using SqlCa;
						
						If SPACEMAN.SqlCode = -1 Then
							This.of_Grava_Log(is_Chave + "Erro no update da promocao qt_estoque_minimo de: '" +String(ll_Estoque_Minimo) + " para: "+String(ll_Estoque_Minimo_Atual)  + ". Chave: " + ls_Chave + "' . "  + SqlCa.SqlErrText, True)
							lb_Sucesso = False	
						End If
											
				End If
						
		End Choose
		
	End If
	
	If Not lb_Sucesso Then Exit
	
Next

If lb_Sucesso Then
	SqlCa.of_Commit()
Else
	SqlCa.of_Rollback()
End If

Return lb_Sucesso
end function

public function boolean of_atualiza_desenho_por_produtos ();Boolean lb_Sucesso = False

Long ll_Linhas, ll_Linha, ll_Primeira_Filial, ll_Filiais_Desenho

String ls_Produto, ls_Filiais_IN

Long ll_Desenho

Double ldc_Custo_Produto

ll_Linhas = UpperBound( il_Desenhos[] )

If ll_Linhas > 0 Then
	
	SetPointer(HourGlass!)
	
	w_Aguarde.uo_Progress.of_SetMAx( ll_Linhas )
	
	w_Aguarde.Title = "Atualizando os desenhos ..."

	For ll_Linha = 1 To ll_Linhas
		
		ll_Primeira_Filial 		= 0
		ll_Filiais_Desenho 	= 0
		ls_Filiais_IN 			= ""
		
		ll_Desenho =  il_Desenhos[ ll_Linha ]
		
		w_Aguarde.Title = "Atualizando o desenho: '" + String( ll_Desenho ) + "' , aguarde..."
		
		ls_Produto = String( il_Produtos[ ll_Linha ] )
		
		If Not of_Custo_Produto(Long(ls_Produto), Ref ldc_Custo_Produto) Then
			Return False
		End If	
		
		If Not This.of_Filiais_Desenho(ll_Desenho, Ref ll_Primeira_Filial, Ref ll_Filiais_Desenho, Ref ls_Filiais_IN) Then
			Return False	
		End If
		
		If This.of_Atualiza_Produtos( il_Produtos[ ll_Linha ] ) Then	
			If This.of_Insere_Produto_Desenho( ll_Desenho, ls_Produto, 'ADD', ll_Primeira_Filial, ll_Filiais_Desenho, ls_Filiais_IN, False, ldc_Custo_Produto) Then
				lb_Sucesso = True
			End If
		End If
				
		If Not lb_Sucesso Then Exit
		
		This.of_Grava_Log("O desenho '" + String(ll_Desenho) + "' foi atualizado com sucesso.", False)

		w_Aguarde.uo_Progress.of_SetProgress(ll_Linha)
		
	Next
	
	w_Aguarde.uo_Progress.of_Reset()
	
	If lb_Sucesso Then
		SPACEMAN.of_Commit()
	Else
		SPACEMAN.of_Rollback()
	End If
	
	SetPointer(Arrow!)
	
Else
	This.of_Grava_Log("Nenhum produto foi localizado no desenho.", True)
	lb_Sucesso = False
End If

Return lb_Sucesso


end function

public function boolean of_atualiza_produto (string pproduct_id, string pupc, string pprod_name, double pprod_size, string puom, string pmanufacturer, string pspm, string pcategory, ref string psubcategory, decimal pcod_category, string pdesc_a, string pdesc_c, string pdesc_d, string pdesc_e, string pdesc_f, string pdesc_g, string pdesc_h, string pdesc_i, double pheight, double pwidth, double pdepth, decimal ptray_height, decimal ptray_width, decimal ptray_depth, integer punits_case, integer punits_tray, string ppreferred_fixel, decimal pcase_height, decimal pcase_width, decimal pcase_depth, decimal pdisplay_height, decimal pdisplay_width, decimal pdisplay_depth, decimal pmax_horiz_crush, decimal pmax_vert_crush, decimal pmax_depth_crush, string pmodel_sched, string ps_situacao_sybase, string ps_planograma);long 	lvl_Linhas,&
		lvl_Linha
		
Long lvl_Desenho
		
string lvs_product_id, lvs_Categoria_Anterior, lvs_Categoria

String lvs_Situacao_Anterior

Decimal ldc_Categoria_Anterior

SetNull( lvl_Desenho )

lvs_Categoria = String(pcod_category)

ib_Atualiaza_Informacoes_Filiais = False

If pPRODUCT_ID = '717522' Then
	pPRODUCT_ID = '717522'
End if


Select product_id, desc_o, desc_b
Into 	:lvs_product_id, :lvs_Categoria_Anterior, :lvs_Situacao_Anterior
from  SPACEMAN_USER.acn_product
where product_id = :pPRODUCT_ID 
USING SPACEMAN;	

Choose Case SPACEMAN.SqlCode
	Case 0
		
		If IsNull(lvs_Situacao_Anterior) Or lvs_Situacao_Anterior <> ps_situacao_sybase Then
			//Atualiza somente a coluna DESC_B no db_spaceman
			
			Update SPACEMAN_USER.acn_product
				Set DESC_B		=	:ps_situacao_sybase
			Where  product_id 	=	:pPRODUCT_ID			
			Using  SPACEMAN;
			
			If SPACEMAN.Sqlcode = -1 then				
				This.of_Grava_Log("Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o da situacao do produto '" + pproduct_id + "'. "  + SPACEMAN.SqlErrText, True)
				Return False
			End If		
			
		End If
				
		//Se for atualizacao de desenho por produto 
		//N$$HEX1$$e300$$ENDHEX$$o ter$$HEX1$$e100$$ENDHEX$$ update, apenas insert
		//Retorna True porque j$$HEX1$$e100$$ENDHEX$$ localizou o produto na tabela  acn_product
		If ib_Atualiza_Desenho_por_Produto Then
			ib_Atualiaza_Informacoes_Filiais = True	
		Else
			
			If IsNull(lvs_Categoria_Anterior) Then 
				lvs_Categoria_Anterior = '0'
			End If
			
			ldc_Categoria_Anterior = Dec(lvs_Categoria_Anterior)
			
			// Produto INATIVO OU PENDENTE our ATIVO e tiver sem planograma
			If (ps_Situacao_Sybase = 'I' or ps_Situacao_Sybase = 'P') or  (ps_Situacao_Sybase = 'A' and IsNull(pcod_category) ) Then
				
				// Muda o STATUS da coluna DESC_J para "E" na tabela ACN_PRODUCT_PLN
				If Not This.of_Insere_Produto_Desenho(pproduct_id, ldc_Categoria_Anterior, "E") Then
					Return False
				End If
					
			Else
															
				Update SPACEMAN_USER.acn_product
				Set 	UPC				  		=   :pUPC,
						PROD_NAME		  	=   :pPROD_NAME,
						PROD_SIZE        		=   :pPROD_SIZE,
						UOM              			=   :pUOM,
						MANUFACTURER     	=   :pMANUFACTURER,
						BRAND            			=   :pSPM,		
						CATEGORY         		=   :pCATEGORY,
						SUBCATEGORY      	=   :pSUBCATEGORY,	
						//HEIGHT           			=   :pHEIGHT,
						//WIDTH            			=   :pWIDTH,
						//DEPTH            			=   :pDEPTH,
						PREFERRED_FIXEL  	=   :pPREFERRED_FIXEL,				
						DESC_O			 		=	:lvs_Categoria,
						PLANOGRAMA			=  :ps_planograma,
						DESC_A					=	:pDESC_A,
						DESC_B					=	:ps_situacao_sybase
				Where  product_id = :pPRODUCT_ID			
				Using  SPACEMAN;
				
				If SPACEMAN.Sqlcode = -1 then				
					This.of_Grava_Log("Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do '" + pproduct_id + "'. "  + SPACEMAN.SqlErrText, True)
					Return False
				End If		
				
				// Muda o STATUS da coluna DESC_J para "E" na tabela ACN_PRODUCT_PLN no desenho que
				// estiver utilzando o planograma anterior
				If ldc_Categoria_Anterior <> pcod_category Then
					If Not This.of_Insere_Produto_Desenho(pproduct_id, ldc_Categoria_Anterior, "E") Then
						Return False
					End If
					
					ib_Atualiaza_Informacoes_Filiais = True
					
					// Inclui o produto com o STATUS da coluna DESC_J como "I" na tabela ACN_PRODUCT_PLN no desenho que
					// estiver utilzando o planograma atual
					If Not This.of_Insere_Produto_Desenho(pproduct_id, pcod_category, "I") Then
						Return False
					End If
				Else
					// Somente atualiza o produto
					If Not This.of_Insere_Produto_Desenho(pproduct_id, pcod_category, "A") Then
						Return False
					End If
				End If	
				
			End If
				
		End If 
				
	Case 100
		
		// Se o produto for ATIVO e tiver PLANOGRAMA definido
		If ps_Situacao_Sybase = 'A' and Not IsNull(pcod_category) Then
		
			Insert INTO SPACEMAN_USER.acn_product(PRODUCT_ID,
																	UPC,
																	PROD_NAME,
																	PROD_SIZE,
																	UOM,
																	MANUFACTURER, 										
																	BRAND,    
																	CATEGORY,         
																	SUBCATEGORY,										 
																	HEIGHT,          
																	WIDTH,            
																	DEPTH,            
																	PREFERRED_FIXEL, 
																	DESC_O,
																	PLANOGRAMA,
																	DESC_A,
																	DESC_B)
			VALUES   (	:pPRODUCT_ID,
							:pUPC,
							:pPROD_NAME,
							:pPROD_SIZE,
							:pUOM,
							:pMANUFACTURER,										
							:pSPM,
							:pCATEGORY,
							:pSUBCATEGORY,										
							:pHEIGHT,
							:pWIDTH,
							:pDEPTH,
							:pPREFERRED_FIXEL,    
							:lvs_Categoria,
							:ps_planograma,
							:pDESC_A,
							:ps_situacao_sybase)		
			USING SPACEMAN;
			
			//:ps_situacao_sybase
			
			If SPACEMAN.Sqlcode = -1 then 
				This.of_Grava_Log("Erro na inclus$$HEX1$$e300$$ENDHEX$$o do '" + pproduct_id + "'. "  + SPACEMAN.SqlErrText, True)
				Return False
			End If
			
			ib_Atualiaza_Informacoes_Filiais = True
			
			//Atualiza$$HEX2$$e700e300$$ENDHEX$$o por produto n$$HEX1$$e300$$ENDHEX$$o pode inserir produto no desenho
			//a funcao of_atualiza_desenho_por_produtos realizar$$HEX1$$e100$$ENDHEX$$ o insert
			If Not ib_Atualiza_Desenho_por_Produto Then
			
				If Not This.of_Insere_Produto_Desenho(pproduct_id, pcod_category, "I") Then
					Return False
				End If
			
			End If
			
			//Grava hist$$HEX1$$f300$$ENDHEX$$rico na tabela historico_spaceman
			If Not This.of_Grava_Historico(Long(pPRODUCT_ID), lvl_Desenho) Then Return False
						
		End If
				
	Case -1
		This.of_Grava_Log("Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do '" + pproduct_id + "'. "  + SPACEMAN.SqlErrText, True)
		Return False
		
End Choose

Return True
end function

public subroutine of_periodo_venda_filial_nova ();Date lvdt_Inicio, lvdt_Termino, ldt_DATA

Integer li_Contador

ldt_DATA = Date(gf_GetServerDate())

For li_Contador = 1 To 3 
	ldt_DATA = RelativeDate(gf_Primeiro_Dia_Mes(ldt_DATA), -1)
	If li_Contador = 1 Then
		lvdt_Termino = gf_Primeiro_Dia_Mes(ldt_DATA)
	End If
	If li_Contador = 3 Then
		lvdt_Inicio = gf_Primeiro_Dia_Mes(ldt_DATA)
	End If
Next

ivdt_data_resumo_novo 			=	lvdt_Inicio 
ivdt_data_resumo_final_novo 		=	lvdt_Termino





  
end subroutine

public function long of_retorna_saldo_produto (long al_filial, long al_produto);Long ll_Saldo

Select qt_saldo_final 
	Into :ll_Saldo 
From vw_saldo_atual_produto
Where cd_filial = :al_Filial 
And cd_produto = :al_Produto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If ll_Saldo < 0 Then ll_Saldo = 0
	Case 100
		
	Case -1
		of_Grava_Log("Erro na consulta do saldo do produto: " + String(al_Produto) + " na filial: " + String(al_Filial) + " Erro: " + SqlCa.SqlErrText, True)
		
End Choose

Return ll_Saldo
end function

public subroutine of_gera_planilha_produto_planograma (ref string ps_msg);//FUN$$HEX2$$c700c300$$ENDHEX$$O ANTIGA

Long ll_Linha
String ls_Diretorio, ls_Arquivo
Date ldh_Parametro

If This.of_conecta_db_spaceman() Then
	
	Try
	
		Open(w_Aguarde)
		w_Aguarde.Title = "Recuperando informa$$HEX2$$e700f500$$ENDHEX$$es, aguarde..."
		
		dc_uo_ds_base lds_Excel
		lds_Excel = Create dc_uo_ds_base
		
		lds_Excel.Of_SetTransObject(spaceman)
		
		If Not lds_Excel.of_ChangeDataObject( "ds_ge218_prd_plan_db_spaceman" ) Then
			ps_Msg = "Erro no ChangeDataObject ds_ge218_prd_plan_db_spaceman"
			Return
		End If
		
		ll_Linha = lds_Excel.Retrieve()
		
		If ll_Linha = -1 Then
			ps_Msg = "Erro no retrieve 'ds_ge218_prd_plan_db_spaceman'"
			Return
		End If
		
		If ll_Linha > 0 Then
			
			ldh_Parametro 	= Date( gf_getserverdate() ) 
			ls_Diretorio 		= gvo_Aplicacao.of_GetFromINI("Diretorio", "Diretorio")
			ls_Arquivo 			= ls_Diretorio + "ProdutosComPlanograma_" + String( ldh_Parametro, 'ddmmyy' )
			
			If lds_Excel.SaveAs( ls_Arquivo + '.txt', TEXT!, True ) > 0 Then
				ps_Msg = "Arquivo salvo com sucesso.~r~rLocal: " + ls_Arquivo + '.txt'
			Else
				ps_Msg = "Erro ao salvar o arquivo '" + ls_Arquivo + "'.txt"
			End If
		Else
			ps_Msg = "Nenhum produto foi localizado"
		End If
								
	Finally
		Close(w_Aguarde)
		This.of_desconecta_db_spaceman()
		Destroy lds_Excel
	End Try
Else
	ps_Msg = "Erro ao conectar no Banco de Dados do Spaceman"
	
End If // Conex$$HEX1$$e300$$ENDHEX$$o BD


end subroutine

public function boolean of_exclui_produto_desenho (long al_desenho, string as_product_id, string as_tipo_alteracao);//-------as_Tipo_Alteracao--------
//REM - Utilizada na fun$$HEX2$$e700e300$$ENDHEX$$o of_processa_produto_por_analise
//E - Exclusao normal do produto


Update acn_product_pln
Set desc_j = :as_tipo_alteracao
Where pln_id 		= :al_Desenho
	 and product_id	= :as_Product_ID
Using SPACEMAN;

//  and (desc_j <> 'E' or desc_j = null)

If SPACEMAN.SqlCode = -1 Then
	This.of_Grava_Log(is_Chave + "Atualiza$$HEX2$$e700e300$$ENDHEX$$o do produto '" +  as_product_id + "' . "  + SPACEMAN.SqlErrText, True)
	Destroy(ivo_Produto)
	Return False
End If
		
//This.of_Grava_Log(is_Chave +  "O produto '" +  as_product_id + "' n$$HEX1$$e300$$ENDHEX$$o foi localizado no Sybase e foi exclu$$HEX1$$ed00$$ENDHEX$$do do desenho. ", True)

Return True
end function

public function boolean of_insere_produto_desenho (long al_desenho, string as_product_id, string as_tipo_operacao, long al_primeira_filial, long al_filiais_desenho, string as_filiais_in, boolean ab_atualizacao_desenhos, double adc_custo_produto);Double lvdc_Media_Vendas, lvdc_Preco_Venda

Long lvl_Linhas, lvl_Linha, ll_Produto, lvl_Achou, lvl_Planograma, ll_Filiais_Desenho, ll_Primeira_Filial, ll_Encontrou_Planograma, ll_Saldo

String ls_Filiais_IN, ls_Status_Atual

If as_Tipo_Operacao = 'E' Or as_Tipo_Operacao = 'REM' Then
	If of_Exclui_Produto_Desenho(al_Desenho, as_Product_ID, as_Tipo_Operacao) Then
		Return True
	Else
		Return False
	End If
End If

// Quando for uma atualiza$$HEX2$$e700e300$$ENDHEX$$o de produto estes par$$HEX1$$e200$$ENDHEX$$metros vem zerados
// Quando for uma atualiza$$HEX2$$e700e300$$ENDHEX$$o de desenho o sistema j$$HEX1$$e100$$ENDHEX$$ informa estes dados
If al_Primeira_Filial = 0 and al_Filiais_Desenho = 0 and as_Filiais_IN = '0' Then
	If Not of_Filiais_Desenho(al_Desenho, Ref ll_Primeira_Filial, Ref ll_Filiais_Desenho, Ref ls_Filiais_IN) Then
		Return False
	End If
Else
	 ll_Primeira_Filial 	= al_Primeira_Filial
	 ll_Filiais_Desenho	= al_Filiais_Desenho
	 ls_Filiais_IN	 		= as_Filiais_IN
End If

ll_Produto = Long(as_Product_ID)
	
ivo_Produto.of_Localiza_Codigo_Interno(ll_Produto)

//as_Tipo_Operacao = I - Inclus$$HEX1$$e300$$ENDHEX$$o, A - Atualiza$$HEX2$$e700e300$$ENDHEX$$o e E - Exclus$$HEX1$$e300$$ENDHEX$$o
	
If ivo_Produto.Localizado Then
	
	//Se for uma atualiza$$HEX2$$e700e300$$ENDHEX$$o de desenhos
	If ab_Atualizacao_Desenhos Then
		//Verifica se o planograma do produto esta sendo utilizado no desenho
		If ivo_Produto.id_situacao = 'A' Then
			ll_Encontrou_Planograma = of_verifica_planograma_desenho	(al_Desenho, ivo_Produto.cd_planograma)
			
			// Se o planograma do produto n$$HEX1$$e300$$ENDHEX$$o estiver relacionado no
			// desenho o sistema vai excluir
			If ll_Encontrou_Planograma = 0 Then
				as_Tipo_Operacao = 'E' 
			ElseIf ll_Encontrou_Planograma = -1 Then
				//Destroy(ivo_Produto)
				Return False
			End If
		Else
			// Pendente ou Inativo 
			as_Tipo_Operacao = 'E' 
		End If
		
		If as_Tipo_Operacao = 'E' Then
			If of_Exclui_Produto_Desenho(al_Desenho, as_Product_ID, as_Tipo_Operacao) Then
				//Solicitacao: Fabio Prado
				//Atualizar o saldo de produtos Inativos
				//Altera$$HEX2$$e700e300$$ENDHEX$$o: 12/02/2015				
				//Return True
			Else
				Return False
			End If
		End If
	End If
	
	lvdc_Preco_Venda = Double(ivo_Produto.of_Preco_Venda_Filial_Matriz(ll_Primeira_Filial))
	
	//Saldo Produto
	ll_Saldo = This.of_Retorna_Saldo_Produto(ll_Primeira_Filial, ll_Produto )
	
	// Vem nulo quando for uma atualiza$$HEX2$$e700e300$$ENDHEX$$o via of_atualiza_desenho
	If IsNull(adc_custo_produto) Then
		If Not of_Custo_Produto(ll_Produto, Ref adc_custo_produto) Then Return False
	End If
	
	If Not of_Media_Vendas(ll_Produto, Ref lvdc_Media_Vendas, ll_Filiais_Desenho, ls_Filiais_IN) Then
		//Destroy(ivo_Produto)
		Return False
	End If		
			
	Select pln_id, DESC_J
	Into :lvl_Achou, :ls_Status_Atual
	From acn_product_pln
	Where pln_id 		= :al_Desenho
		and product_id	= :as_Product_ID
	Using SPACEMAN;
	
	Choose Case SPACEMAN.SqlCode
		Case 0
			//Solcitacao do Fabio
			//As vezes $$HEX1$$e900$$ENDHEX$$ feito alteracao em produtos que j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e300$$ENDHEX$$o no desenho  
			If as_Tipo_Operacao = 'I' Or as_Tipo_Operacao = 'ADD' Then
				Update acn_product_pln
				Set price =:lvdc_Preco_Venda , cost =:adc_custo_produto, reg_movement =:lvdc_Media_Vendas, saldo = :ll_Saldo, desc_j = :as_Tipo_Operacao
				Where pln_id 		= :al_Desenho
					 and product_id	= :as_Product_ID
				Using SPACEMAN;
				
			Else
				Update acn_product_pln
				Set price =:lvdc_Preco_Venda , cost =:adc_custo_produto, reg_movement =:lvdc_Media_Vendas, saldo = :ll_Saldo
				Where pln_id 		= :al_Desenho
					 and product_id	= :as_Product_ID
				Using SPACEMAN;
			End If
			
			If SPACEMAN.SqlCode = -1 Then
				This.of_Grava_Log(is_Chave + "Atualiza$$HEX2$$e700e300$$ENDHEX$$o do produto '" +  as_product_id + "' . "  + SPACEMAN.SqlErrText, True)
				//Destroy(ivo_Produto)
				Return False
			End If
								
		Case 100
						
			If as_Tipo_Operacao = 'I' Or as_Tipo_Operacao = 'ADD' Then
				
				Insert into acn_product_pln(pln_id, product_id, price, cost, reg_movement, desc_j, saldo)
				Values (:al_Desenho, :as_Product_ID, :lvdc_Preco_Venda, :adc_custo_produto, :lvdc_Media_Vendas, :as_Tipo_Operacao, :ll_Saldo)
				Using SPACEMAN;
				
				If SPACEMAN.SqlCode = -1 Then
					This.of_Grava_Log(is_Chave + "Erro na inclus$$HEX1$$e300$$ENDHEX$$o do produto '" +  as_product_id + "' . "  + SPACEMAN.SqlErrText, True)
					//Destroy(ivo_Produto)
					Return False
				End If
				
				//Utilizado para manter informa$$HEX2$$e700f500$$ENDHEX$$es de inclus$$HEX1$$e300$$ENDHEX$$o/altera$$HEX2$$e700e300$$ENDHEX$$o dos produtos nos PLANOGRAMAS
				If Not This.of_grava_historico(Long(as_Product_ID), al_Desenho) Then Return False
				
				This.of_Grava_Log(is_Chave + "O produto '" +  as_product_id + "' foi inclu$$HEX1$$ed00$$ENDHEX$$do no desenho '" + String(al_Desenho) + "'. ", False)
				
			End If
			
		Case -1
			This.of_Grava_Log(is_Chave + "Consulta do produto '" +  as_product_id + "' . "  + SPACEMAN.SqlErrText, True)
			//Destroy(ivo_Produto)
			Return False
	End Choose
	
	// Opera$$HEX2$$e700e300$$ENDHEX$$o diferente de EXCLUS$$HEX1$$c300$$ENDHEX$$O
	If as_Tipo_Operacao <> 'E' Then
		If ib_Atualiaza_Informacoes_Filiais Then
			//ib_Atualiaza_Informacoes_Filiais = False
			If Not of_Atualiza_Informacoes_Filiais(as_product_id, al_Desenho, adc_custo_produto) Then
				//Destroy(ivo_Produto)
				Return False
			End If
		End If
	End If
	
Else
	
	If of_Exclui_Produto_Desenho(al_Desenho, as_Product_ID, as_Tipo_Operacao) Then	
		//Destroy(ivo_Produto)
		Return False
	End If
	
End If

SPACEMAN.of_Commit();

Return True
end function

public subroutine of_envia_email (string as_mensagem);String ls_Anexo[]

gf_ge202_envia_email_automatico(120, "", as_mensagem, ls_Anexo)
end subroutine

public subroutine of_separa_filiais (string as_filiais);Long ll_Linha = 1
Long ll_Posicao = 0
Long ll_Dif
Long ll_Filial
Long ll_Virgula[]

//Inicia o array il_Filiais[]
il_Filiais[] = ll_Virgula[]

If Trim(as_Filiais) = "" Then Return

//Se tem mais de uma filial no par$$HEX1$$e200$$ENDHEX$$metro as_filiais
If PosA(as_filiais, ",", ll_Posicao + 1) > 0 Then

	//Enquanto existir virgula continua
	Do While PosA(as_filiais, ",", ll_Posicao + 1) > 0
		ll_Virgula[ll_Linha] = PosA(as_filiais, ",", ll_Posicao + 1)
		
		ll_Posicao = ll_Virgula[ll_Linha]
		
		ll_Linha ++
	Loop
	
	ll_Linha = 0
	ll_Posicao = 0
	
	//A partir das virgulas quebras as filiais por linha
	//EX: DE 13,26,39
	//PARA
	//13
	//26
	//39
	
	//Captura os c$$HEX1$$f300$$ENDHEX$$digos de filiais que est$$HEX1$$e300$$ENDHEX$$o entre as v$$HEX1$$ed00$$ENDHEX$$rgulas
	For ll_Linha = 1 To UpperBound(ll_Virgula[])
			
		ll_Dif = ll_Virgula[ll_Linha] - (ll_Posicao + 1)
		
		MidA( as_Filiais, ll_Posicao + 1, ll_Dif )
		
		ll_Filial = Long( MidA( as_Filiais, ll_Posicao + 1, ll_Dif ) )
		
		ll_Posicao = ll_Virgula[ll_Linha]
		
		il_Filiais[UpperBound(il_Filiais[]) + 1] = ll_Filial
	Next
	
	//Captura a $$HEX1$$fa00$$ENDHEX$$ltima filial, que est$$HEX1$$e100$$ENDHEX$$ depois da $$HEX1$$fa00$$ENDHEX$$ltima v$$HEX1$$ed00$$ENDHEX$$rgula
	ll_Posicao = ll_Virgula[UpperBound(ll_Virgula[])]
	
	ll_Filial = Long( MidA( as_Filiais, ll_Posicao + 1 ) )
	
	il_Filiais[UpperBound(il_Filiais[]) + 1] = ll_Filial
	
Else
	il_Filiais[UpperBound(il_Filiais[]) + 1] = Long(as_Filiais)
End If
end subroutine

public subroutine of_gera_planilha_produto_planograma (string ps_filiais, ref string ps_msg);//FUN$$HEX2$$c700c300$$ENDHEX$$O NOVA

Date ldh_Parametro

Long ll_Linha
Long ll_Row
Long ll_Planilhao
Long ll_Desenho
Long ll_Desenho_Ant
Long ll_Linha_Prd
Long ll_Insert
Long ll_Line

String ls_Diretorio
String ls_Arquivo

If This.of_conecta_db_spaceman() Then
	
	Try
		
		This.of_Abre_Log()
	
		Open(w_Aguarde)
		w_Aguarde.Title = "Recuperando informa$$HEX2$$e700f500$$ENDHEX$$es, aguarde..."
	
		If Trim(ps_Filiais) = "" Then
			
			dc_uo_ds_base lds_Excel
			lds_Excel = Create dc_uo_ds_base
				
			lds_Excel.Of_SetTransObject(spaceman)
				
			If Not lds_Excel.of_ChangeDataObject( "ds_ge218_prd_plan_db_spaceman" ) Then
				ps_Msg = "Erro no ChangeDataObject ds_ge218_prd_plan_db_spaceman"
				Return
			End If
				
			ll_Linha = lds_Excel.Retrieve()
				
			If ll_Linha = -1 Then
				ps_Msg = "Erro no retrieve 'ds_ge218_prd_plan_db_spaceman'"
				Return
			End If
			
		Else
						
			This.of_Separa_Filiais(ps_Filiais)
			
			If Not This.of_Carrega_Planogramas_Filiais() Then Return
			
			dc_uo_ds_base lds_Final
			lds_Final = Create dc_uo_ds_base
			
			If Not lds_Final.of_ChangeDataObject( "ds_ge218_prd_plan_db_spaceman" ) Then
				ps_Msg = "Erro no ChangeDataObject ds_ge218_prd_plan_db_spaceman"
				Return
			End If
			
			For ll_Row = 1 To UpperBound(il_Filiais)
				ids_desenho_planograma.SetFilter("")
				ids_desenho_planograma.Filter( )
				
				ids_desenho_planograma.SetFilter("cd_filial = " + String(il_Filiais[ll_Row]))
				ids_desenho_planograma.Filter( )
				ids_desenho_planograma.Sort( )
				
				If ids_desenho_planograma.RowCount() > 0 Then
					For ll_Planilhao = 1 To ids_desenho_planograma.RowCount()
						ll_Desenho = ids_desenho_planograma.Object.Nr_Desenho[ll_Planilhao]
												
						If ll_Desenho <> ll_Desenho_Ant Then
							dc_uo_ds_base lds_Excel_1
							lds_Excel_1 = Create dc_uo_ds_base
								
							lds_Excel_1.Of_SetTransObject(spaceman)
								
							If Not lds_Excel_1.of_ChangeDataObject( "ds_ge218_prd_plan_db_spaceman" ) Then
								ps_Msg = "Erro no ChangeDataObject ds_ge218_prd_plan_db_spaceman"
								Return
							End If
							
							lds_Excel_1.of_AppendWhere("ACN_PLANOGRAMS.PLN_ID = " + String(ll_Desenho))
							
							ll_Linha_Prd = lds_Excel_1.Retrieve()
							
							If ll_Linha_Prd = -1 Then
								ps_Msg = "Erro no retrieve 'ds_ge218_prd_plan_db_spaceman'"
								Return
							End If
							
							If ll_Linha_Prd > 0 Then
								For ll_Line = 1 To ll_Linha_Prd
									
									If PosA(lds_Excel_1.Object.Filial[ll_Line], ",") > 0 Then
										lds_Excel_1.Object.Filial[ll_Line] = String(il_Filiais[ll_Row])
									End If
								
									ll_Insert = lds_Final.InsertRow(0)
									lds_Final.Object.Product_Id				[ll_Insert] = lds_Excel_1.Object.Product_Id				[ll_Line]
									lds_Final.Object.Upc						[ll_Insert] = lds_Excel_1.Object.Upc						[ll_Line]
									lds_Final.Object.Prod_Name				[ll_Insert] = lds_Excel_1.Object.Prod_Name				[ll_Line]
									lds_Final.Object.Fixel_Id					[ll_Insert] = lds_Excel_1.Object.Fixel_Id					[ll_Line]
									lds_Final.Object.Fixel_Name				[ll_Insert] = lds_Excel_1.Object.Fixel_Name				[ll_Line]
									lds_Final.Object.Width					[ll_Insert] = lds_Excel_1.Object.Width					[ll_Line]
									lds_Final.Object.Filial						[ll_Insert] = lds_Excel_1.Object.Filial						[ll_Line]
									lds_Final.Object.Nr_Altura				[ll_Insert] = lds_Excel_1.Object.Nr_Altura				[ll_Line]
									lds_Final.Object.Nr_Frentes				[ll_Insert] = lds_Excel_1.Object.Nr_Frentes				[ll_Line]
									lds_Final.Object.Nr_Profundidade		[ll_Insert] = lds_Excel_1.Object.Nr_Profundidade		[ll_Line]
									
									//O total de produtos $$HEX1$$e900$$ENDHEX$$ a m$$HEX1$$fa00$$ENDHEX$$ltiplica$$HEX2$$e700e300$$ENDHEX$$o de Altura * Frentes * Profundidade
									lds_Final.Object.Qt_Total_Produtos	[ll_Insert] = (lds_Excel_1.Object.Nr_Altura[ll_Line] * lds_Excel_1.Object.Nr_Frentes[ll_Line] * lds_Excel_1.Object.Nr_Profundidade[ll_Line])
									lds_Final.Object.Desenho				[ll_Insert] = lds_Excel_1.Object.Desenho					[ll_Line]
									lds_Final.Object.Planograma			[ll_Insert] = lds_Excel_1.Object.Planograma			[ll_Line]
									lds_Final.Object.Id_Situacao			[ll_Insert] = lds_Excel_1.Object.Id_Situacao				[ll_Line]
								Next
							End If
						End If
						
						ll_Desenho_Ant = ll_Desenho
						ll_Line = 0
						
						If IsValid(lds_Excel_1) Then Destroy(lds_Excel_1)
					Next
				End If
			Next
		End If
			
		If ll_Linha > 0 Or ll_Insert > 0 Then
			
			ldh_Parametro 	= Date( gf_getserverdate() ) 
			ls_Diretorio 		= gvo_Aplicacao.of_GetFromINI("Diretorio", "Diretorio")
			ls_Arquivo 		= ls_Diretorio + "ProdutosComPlanograma_" + String( ldh_Parametro, 'ddmmyy' )
			
			If Trim(ps_Filiais) = "" Then
				If lds_Excel.SaveAs( ls_Arquivo + '.txt', TEXT!, True ) > 0 Then
					ps_Msg = "Arquivo salvo com sucesso.~r~rLocal: " + ls_Arquivo + '.txt'
				Else
					ps_Msg = "Erro ao salvar o arquivo '" + ls_Arquivo + "'.txt"
				End If
			Else
				If lds_Final.SaveAs( ls_Arquivo + '.txt', TEXT!, True ) > 0 Then
					ps_Msg = "Arquivo salvo com sucesso.~r~rLocal: " + ls_Arquivo + '.txt'
				Else
					ps_Msg = "Erro ao salvar o arquivo '" + ls_Arquivo + "'.txt"
				End If
			End If
		Else
			ps_Msg = "Nenhum produto foi localizado"
		End If

	Finally
		Close(w_Aguarde)
		FileClose(ivi_log)
		This.of_desconecta_db_spaceman()
		If IsValid(lds_Excel) Then Destroy(lds_Excel)
		If IsValid(lds_Final) Then Destroy(lds_Final)
		If IsValid(lds_Excel_1) Then Destroy(lds_Excel_1)
	End Try
Else
	ps_Msg = "Erro ao conectar no Banco de Dados do Spaceman"
	
End If // Conex$$HEX1$$e300$$ENDHEX$$o BD
end subroutine

public function boolean of_processa_produto_por_analise (long al_filial, long al_produto, string as_alteracao, ref long al_desenho[], ref string as_erro);Boolean lb_Sucesso = True

Long ll_Row
Long ll_Linha = 0

Double ldc_Custo_Produto

If gvo_Aplicacao.ivs_DataSource <> 'central' Then Return True

Try
	
	ivo_produto.of_Localiza_Codigo_Interno( al_produto )
	
	If Not ivo_produto.Localizado Then Return lb_Sucesso = False
	
	ll_Row = ids_desenho_planograma.Find("cd_filial = " + String( al_filial ) + " and cd_planograma = " + String(ivo_produto.cd_planograma) , 1, ids_desenho_planograma.RowCount() )
	
	If ll_Row = 0 Then
		as_erro = "Funcao: Atualizacao por analise. Nenhum desenho encontrado. Prod: " + String(al_produto) +  " - Filial:" + String( al_filial )
		lb_Sucesso = False
	Else
		Do While ll_Row > 0
		
			Choose Case ll_Row
					
				Case is < 0
					as_erro = "Funcao: Atualizacao por analise. Erro no Find. Prod: " + String(al_produto) +  " - Filial:" + String( al_filial )
					lb_Sucesso = False
			
//				Case 0 
//					as_erro = "Funcao: Atualizacao por analise. Nenhum desenho encontrado. Prod: " + String(al_produto) +  " - Filial:" + String( al_filial )
//					lb_Sucesso = False
					
				Case is > 0
					
					ll_Linha++
			
					al_desenho[ll_Linha] = ids_desenho_planograma.Object.nr_desenho [ ll_Row ]
					
					If Not of_Custo_Produto(al_produto, Ref ldc_Custo_Produto) Then
						Return False
					End If	
					
					If Not This.of_Insere_Produto_Desenho(al_Desenho[ll_Linha], String(al_produto), as_alteracao, 0, 0, '0', False, ldc_Custo_Produto) Then
						as_erro = "Funcao: Atualizacao por analise. Erro ao inserir o produto no desenho. " + String(al_Desenho[ll_Linha]) + " - " + String(al_produto)
						lb_Sucesso = False
					End If
					
					If lb_Sucesso Then
						SPACEMAN.of_Commit()
					Else
						SPACEMAN.of_Rollback()
					End If
					
					If ll_Row = ids_desenho_planograma.RowCount() Then
						Exit
					End If
					
					ll_Row = ids_desenho_planograma.Find("de_filiais = '" + String( al_filial ) + "' and cd_planograma = " + String(ivo_produto.cd_planograma) , ll_Row + 1, ids_desenho_planograma.RowCount() )					
			End Choose 
		Loop
	End If
	
Finally
	If Not lb_Sucesso Then This.of_Grava_Log( as_erro  , False)
	
	Return lb_Sucesso
End Try

end function

public function boolean of_verifica_filial_planograma (long al_planograma, string as_filiais, string as_planogramas, string as_desenho, string as_perfil, string as_regiao);If Not IsNull(as_Filiais) and Trim(as_Filiais) <> "" Then 
	If Not of_Valida_Filiais(as_Filiais, al_Planograma, as_Desenho) Then
		Return False
	End If
Else
	This.of_Grava_Log("N$$HEX1$$e300$$ENDHEX$$o existem filiais definidas para o desenho '" + String(al_Planograma) + "' .", True)
	Return False
End If

If Not IsNull(as_Planogramas) and Trim(as_Planogramas) <> "" Then 
	If Not This.of_valida_planogramas(as_Planogramas, al_Planograma, as_desenho, as_filiais, as_perfil, as_regiao, "", "", "") Then
		Return False
	End If
Else
	This.of_Grava_Log("N$$HEX1$$e300$$ENDHEX$$o existem planogramas definidos para o desenho '" + String(al_Planograma) + "' .", True)
	Return False
End If
			
Return True
end function

public function boolean of_atualiza_estoque_minimo_cluster ();Boolean lb_Sucesso

Long ll_Row
Long ll_Qtde
Long ll_Achou
Long ll_Produto
Long ll_Filial
Long ll_Estoque_Minimo_Atual
Long ll_Retorno
Long ll_Estoque_Minimo
Long ll_Promocao

String ls_Chave

If This.il_Motivo = 0 Then
	SetNull(This.il_Motivo)
End If

ll_Qtde = UpperBound( il_Filiais[] )

For ll_Row = 1 To ll_Qtde
	
	lb_Sucesso = False
	
	ll_Filial  							= il_Filiais					[ ll_Row ]
	ll_Produto 						= il_Produtos				[ ll_Row ]
	ll_Estoque_Minimo_Atual		= il_Estoque_Minimo 		[ ll_Row ]
	ll_Promocao						= il_Promocao				[ ll_Row ]
	
	//Se n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ preenchida a promo$$HEX2$$e700e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ porque a filial n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ no cluster. A atualiza$$HEX2$$e700e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ realizada na fun$$HEX2$$e700e300$$ENDHEX$$o of_atualiza_estoque_minimo
	If IsNull(ll_Promocao) Or ll_Promocao = 0 Then
		lb_Sucesso = True
		Continue
	End If

	//Ir$$HEX1$$e100$$ENDHEX$$ localizar se o produto esta ativo na promocao_sos
	
	Select count(*)
		Into :ll_Retorno
	From promocao_sos p
		Inner Join promocao_sos_produto pp
			on pp.cd_promocao_sos 	= p.cd_promocao_sos
		Inner Join promocao_sos_filial f
			on f.cd_promocao_sos = p.cd_promocao_sos
		Inner Join parametro x
			on x.id_parametro = x.id_parametro
	where p.id_tipo_promocao	= 'P'
		and p.dh_inicio 			<= x.dh_movimentacao
		and (p.dh_termino			>= x.dh_movimentacao Or p.dh_termino is null)
		and pp.cd_produto 		= :ll_Produto
		and f.cd_filial 				= :ll_Filial
		and p.cd_promocao_sos	= :ll_Promocao
	Using SqlCa;
		
	ls_Chave = String(ll_Filial) + " - " + String(ll_Produto) + " - Estoque Minimo: " + String(ll_Estoque_Minimo_Atual) + " - Promo$$HEX2$$e700e300$$ENDHEX$$o: " + String(ll_Promocao)
	
	Choose Case SqlCa.SqlCode
		
		Case -1
			This.of_Grava_Log(is_Chave + "Erro na consulta da promocao SOS: '" +  ls_Chave + "." + SqlCa.SqlErrText, True)
			lb_Sucesso = False
			
		Case 0
						
			//-----------------------------------------Incluir o Estoque m$$HEX1$$ed00$$ENDHEX$$nimo atraves da promocao ativa da Filial---------------------------
			If ll_Retorno = 0 Then
				
				If Not IsNull(ll_Promocao) Then
													
					//---------------------------Inclui o produto na promocao sos
					//Se localizou a promocao 'P' na filial	
					Insert Into promocao_sos_produto(
						cd_promocao_sos,
						cd_produto,
						pc_desconto) 
					Values(:ll_Promocao, 
								:ll_Produto, 
								0.00 )
					Using SqlCa;
					
					If SqlCa.SqlCode = 0 Then
						This.of_Grava_Log(is_Chave + "Produto cadastrado com sucesso na promocao_sos_produto: Chave: " + String(ll_Promocao) + " - " + String(ll_Produto) + ".", False )
						lb_Sucesso = True
					Else
						This.of_Grava_Log(is_Chave + "Erro ao inserir o produto na Promocao SOS Produto: Promocao: " + String(ll_Promocao) + " Produto: " + String(ll_Produto) + ".", True )
						lb_Sucesso = False	
					End If
				
				Else
					//----Se n$$HEX1$$e300$$ENDHEX$$o achou nenhuma promocao planograma
					This.of_Grava_Log(is_Chave + "Promo$$HEX2$$e700e300$$ENDHEX$$o Planograma n$$HEX1$$e300$$ENDHEX$$o localizada: Filial: " + String(ll_Filial) + ".", True )
					lb_Sucesso = False		
				End If
			End If
			
			If ll_Retorno = 1 Then
				lb_Sucesso = True
			End if
		End Choose
	
	If lb_Sucesso Then
		
		ls_Chave = String(ll_Promocao) + " - " + ls_Chave
		
		Select qt_estoque_minimo
			Into :ll_Estoque_Minimo 
		From promocao_sos_estoque_minimo
			Where cd_promocao_sos 		= :ll_Promocao
				and cd_produto 				= :ll_Produto
				and cd_filial 					= :ll_Filial
		Using SqlCa;		
		
		Choose Case SqlCa.SqlCode
				
			Case -1
				This.of_Grava_Log(is_Chave + "Erro no select do qt_estoque minimo da tabela promocao_sos_estoque_minimo: '" +  ls_Chave + "' . "  + SqlCa.SqlErrText, True)
				lb_Sucesso = False	
		
			Case 100
				//Se n$$HEX1$$e300$$ENDHEX$$o localizou, ser$$HEX1$$e100$$ENDHEX$$ incluso o produto na promocao_sos
				
				Insert Into promocao_sos_estoque_minimo
					(cd_promocao_sos,
					cd_filial,
					cd_produto,
					qt_estoque_minimo,
					nr_matricula_alteracao,
					cd_motivo_alteracao,
					qt_estoque_minimo_matriz)
				Values(	:ll_Promocao,
							:ll_Filial,
							:ll_Produto,
							:ll_Estoque_Minimo_Atual,
							:gvo_Aplicacao.ivo_Seguranca.Nr_Matricula,
							:This.il_Motivo,
							:ll_Estoque_Minimo_Atual)
				Using SqlCa;
							
				If SqlCa.SqlCode = 0 Then
					This.of_Grava_Log(is_Chave + "Estoque minimo do produto foi inclu$$HEX1$$ed00$$ENDHEX$$do com sucesso. Tabela promocao_sos_estoque_minimo: " + ls_Chave +"'. ", False )
					lb_Sucesso = True
				Else
					This.of_Grava_Log(is_Chave + "Erro no insert do produto na tabela promocao_sos_estoque_minimo. '" +  ls_Chave + "' . "  + SqlCa.SqlErrText, True)
					lb_Sucesso = False
				End If
				
			Case 0
				
				//Se localizou, ser$$HEX1$$e100$$ENDHEX$$ atribu$$HEX1$$ed00$$ENDHEX$$do o novo valor para o estoque minimo
				If ll_Estoque_Minimo > 0 And ll_Estoque_Minimo <> ll_Estoque_Minimo_Atual Then 
					
					//This.of_Grava_Log(is_Chave + "Estoque Minimo j$$HEX1$$e100$$ENDHEX$$ cadastrado. '" + ls_Chave + "' . ", False)
					//Continue
					
					Update promocao_sos_estoque_minimo
						set qt_estoque_minimo 			= :ll_Estoque_Minimo_Atual,
							 qt_estoque_minimo_matriz	= :ll_Estoque_Minimo_Atual,
							nr_matricula_alteracao		= :gvo_Aplicacao.ivo_Seguranca.Nr_Matricula,
							cd_motivo_alteracao			= :This.il_Motivo
						Where cd_promocao_sos 		= :ll_Promocao
							and cd_produto 				= :ll_Produto
							and cd_filial 					= :ll_Filial
						Using SqlCa;
						
					If SPACEMAN.SqlCode = -1 Then
						This.of_Grava_Log(is_Chave + "Erro no update da promocao qt_estoque_minimo de: '" +String(ll_Estoque_Minimo) + " para: "+String(ll_Estoque_Minimo_Atual)  + ". Chave: " + ls_Chave + "' . "  + SqlCa.SqlErrText, True)
						lb_Sucesso = False	
					End If											
				End If
						
		End Choose
		
	End If
	
	If Not lb_Sucesso Then Exit
	
Next

If lb_Sucesso Then
	SqlCa.of_Commit()
Else
	SqlCa.of_Rollback()
End If

Return lb_Sucesso
end function

public function boolean of_valida_planogramas (string as_planogramas, long al_desenho, string as_desenho, string as_filiais, string as_perfil, string as_regiao, string as_category, string as_department, string as_subcategory);Boolean lvb_Sucesso = True

Integer lvi_Linha

String lvs_Char, lvs_Planograma, lvs_Mensagem

For lvi_Linha = 1 To 1000
	
	lvs_Char = MidA(as_Planogramas, lvi_Linha, 1)
	
	If lvs_Char = "" Then
		
		If Not IsNumber(lvs_Planograma) Then
			
			lvs_Mensagem = "O c$$HEX1$$f300$$ENDHEX$$digo do planograma '" +  lvs_Planograma + "' informado no desenho '" + as_Desenho  + " (" + String(al_desenho) + ")' $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido."
						
			This.of_Grava_Log(lvs_Mensagem, True)
			lvb_Sucesso = False
			Exit
		End If
	
		If Not of_insere_desenho_planograma(al_Desenho, Long(lvs_Planograma), as_desenho, as_planogramas, as_filiais, as_perfil, as_regiao, as_Category, as_Department, as_Subcategory) Then
			lvb_Sucesso = False
			Exit
		End If
		
		lvs_Planograma = ""
		Exit
		
	Else
		If lvs_Char <> "," Then
			lvs_Planograma = lvs_Planograma + lvs_Char			
		Else
			
			If Not IsNumber(lvs_Planograma) Then
				
				lvs_Mensagem = "O c$$HEX1$$f300$$ENDHEX$$digo do planograma '" +  lvs_Planograma + "' informado no desenho '" + as_Desenho  + " (" + String(al_desenho) + ")' $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido."
				
				This.of_Grava_Log(lvs_Mensagem, True)
				lvb_Sucesso = False
				Exit
			End If		
			
			If Not of_insere_desenho_planograma(al_Desenho, Long(lvs_Planograma), as_desenho, as_planogramas, as_filiais, as_perfil, as_regiao, as_Category, as_Department, as_Subcategory) Then
				lvb_Sucesso = False
				Exit
			End If
			
			lvs_Planograma = ""
		End If
	End If
Next

Return lvb_Sucesso
end function

public function boolean of_insere_desenho_planograma (long al_desenho, long al_planograma, string as_desenho, string as_planogramas, string as_filiais, string as_perfil, string as_regiao, string as_category, string as_department, string as_subcategory);Long ll_Achou
Long ll_Insert
Long ll_Linha = 1
Long ll_Posicao = 0
Long ll_Dif
Long ll_Filial
Long ll_Virgula[]

Select cd_planograma
Into :ll_Achou
From categoria_planograma
Where cd_planograma	= :al_Planograma
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
		This.of_Grava_Log("O planograma '" + String(al_Planograma) + "' informado desenho '" + as_Desenho + " (" + String(al_desenho) + ")' n$$HEX1$$e300$$ENDHEX$$o foi localizado.", True)
		Return False
	Case -1 
		This.of_Grava_Log("Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do planograma '" + String(al_Planograma) + "' do desenho '" + String(al_desenho) + "'. "  + SqlCa.SqlErrText, True)
		Return False
End Choose

//Se tem mais de uma filial na coluna 'DE_FILIAIS'
If PosA(as_filiais, ",", ll_Posicao + 1) > 0 Then

	//Enquanto tiver virgula continua
	Do While PosA(as_filiais, ",", ll_Posicao + 1) > 0
		ll_Virgula[ll_Linha] = PosA(as_filiais, ",", ll_Posicao + 1)
		
		ll_Posicao = ll_Virgula[ll_Linha]
		
		ll_Linha ++
	Loop
	
	ll_Linha = 0
	ll_Posicao = 0
	
	//A partir das virgulas quebras as filiais por linha.
	//EX: 13,26,39 para
	//13
	//26
	//39
	
	//Captura os c$$HEX1$$f300$$ENDHEX$$digos de filiais que est$$HEX1$$e300$$ENDHEX$$o entre as v$$HEX1$$ed00$$ENDHEX$$rgulas
	For ll_Linha = 1 To UpperBound(ll_Virgula[])
			
		ll_Dif = ll_Virgula[ll_Linha] - (ll_Posicao + 1)
		
		MidA( as_Filiais, ll_Posicao + 1, ll_Dif )
		
		ll_Filial = Long( MidA( as_Filiais, ll_Posicao + 1, ll_Dif ) )
		
		ll_Posicao = ll_Virgula[ll_Linha]
				
		ll_Insert = ids_desenho_planograma.InsertRow(0)
		ids_desenho_planograma.Object.Cd_Filial			[ll_Insert] = ll_Filial
		ids_desenho_planograma.Object.nr_desenho		[ll_Insert] = al_Desenho
		ids_desenho_planograma.Object.cd_planograma	[ll_Insert] = al_Planograma
		ids_desenho_planograma.Object.de_desenho		[ll_Insert] = as_desenho
		ids_desenho_planograma.Object.de_planogramas	[ll_Insert] = as_planogramas
		ids_desenho_planograma.Object.de_filiais			[ll_Insert] = as_filiais
		ids_desenho_planograma.Object.de_perfil			[ll_Insert] = as_perfil
		ids_desenho_planograma.Object.de_regiao			[ll_Insert] = as_regiao
		ids_desenho_planograma.Object.Category			[ll_Insert] = as_Category
		ids_desenho_planograma.Object.Department		[ll_Insert] = as_Department
		ids_desenho_planograma.Object.Subcategory		[ll_Insert] = as_Subcategory
	Next
	
	//Captura a $$HEX1$$fa00$$ENDHEX$$ltima filial, que est$$HEX1$$e100$$ENDHEX$$ despois da $$HEX1$$fa00$$ENDHEX$$ltima v$$HEX1$$ed00$$ENDHEX$$rgula
	ll_Posicao = ll_Virgula[UpperBound(ll_Virgula[])]
	
	ll_Filial = Long( MidA( as_Filiais, ll_Posicao + 1 ) )
	
	ll_Insert = ids_desenho_planograma.InsertRow(0)
	ids_desenho_planograma.Object.Cd_Filial			[ll_Insert] = ll_Filial
	ids_desenho_planograma.Object.nr_desenho		[ll_Insert] = al_Desenho
	ids_desenho_planograma.Object.cd_planograma	[ll_Insert] = al_Planograma
	ids_desenho_planograma.Object.de_desenho		[ll_Insert] = as_desenho
	ids_desenho_planograma.Object.de_planogramas	[ll_Insert] = as_planogramas
	ids_desenho_planograma.Object.de_filiais			[ll_Insert] = as_filiais
	ids_desenho_planograma.Object.de_perfil			[ll_Insert] = as_perfil
	ids_desenho_planograma.Object.de_regiao			[ll_Insert] = as_regiao
	ids_desenho_planograma.Object.Category			[ll_Insert] = as_Category
	ids_desenho_planograma.Object.Department		[ll_Insert] = as_Department
	ids_desenho_planograma.Object.Subcategory		[ll_Insert] = as_Subcategory
	
Else
	ll_Filial = Long(as_Filiais)
	
	ll_Insert = ids_desenho_planograma.InsertRow(0)
	ids_desenho_planograma.Object.Cd_Filial			[ll_Insert] = ll_Filial
	ids_desenho_planograma.Object.nr_desenho		[ll_Insert] = al_Desenho
	ids_desenho_planograma.Object.cd_planograma	[ll_Insert] = al_Planograma
	ids_desenho_planograma.Object.de_desenho		[ll_Insert] = as_desenho
	ids_desenho_planograma.Object.de_planogramas	[ll_Insert] = as_planogramas
	ids_desenho_planograma.Object.de_filiais			[ll_Insert] = as_filiais
	ids_desenho_planograma.Object.de_perfil			[ll_Insert] = as_perfil
	ids_desenho_planograma.Object.de_regiao			[ll_Insert] = as_regiao
	ids_desenho_planograma.Object.Category			[ll_Insert] = as_Category
	ids_desenho_planograma.Object.Department		[ll_Insert] = as_Department
	ids_desenho_planograma.Object.Subcategory		[ll_Insert] = as_Subcategory
End If

Return True
end function

public function boolean of_atualiza_desenho (long al_desenho, string as_desenho, long al_linha, long al_linhas);Boolean lb_Sucesso = True

Long ll_Linhas, ll_Linha, ll_Primeira_Filial, ll_Filiais_Desenho

String ls_Produto, ls_Filiais_IN

Double ldc_Nulo

SetNull(ldc_Nulo)

try 

	If Not This.of_Filiais_Desenho(al_Desenho, Ref ll_Primeira_Filial, Ref ll_Filiais_Desenho, Ref ls_Filiais_IN) Then
		Return False	
	End If
	
	dc_uo_ds_base lds
	lds = Create dc_uo_ds_base
	
	lds.Of_SetTransObject(spaceman)
	
	If Not lds.of_ChangeDataObject("ds_ge218_produtos_desenho", False) Then
		This.of_Envia_Email("Erro no change da ds 'ds_ge218_produtos_desenho'. Fun$$HEX2$$e700e300$$ENDHEX$$o uo_ge218_spaceman.of_atualiza_desenho(long, string)")
		Destroy(lds)
		Return False
	End If
	
	w_Aguarde.Title = "SPACEMAN - Atualizando o desenho '" + as_desenho + "' - " + String(al_linha) + ' de '+  String(al_linhas) + '...'
	
	If lds.Retrieve(al_Desenho) < 0 Then
		of_envia_email("Erro ao localizar os desenhos na tabela de dados do SPACEMAN.")
		Destroy(lds)
		Return False
	End If
	
	ll_Linhas = lds.RowCount()
	
	If ll_Linhas > 0 Then
		
		w_Aguarde.uo_Progress.of_SetMax(ll_Linhas)
	
		For ll_Linha= 1 To ll_Linhas
			
			ls_Produto = lds.Object.product_id[ll_Linha]
			
			// Na atualiza$$HEX2$$e700e300$$ENDHEX$$o do desenho $$HEX1$$e900$$ENDHEX$$ informado nulo
			If Not This.of_Insere_Produto_Desenho(al_Desenho, ls_Produto, 'A', ll_Primeira_Filial, ll_Filiais_Desenho, ls_Filiais_IN, True, ldc_Nulo) Then
				lb_Sucesso = True
			End If
					
			If Not lb_Sucesso Then Exit
			
			w_Aguarde.uo_Progress.of_SetProgress(ll_Linha)
		Next
		
		w_Aguarde.Title = "Atualizando os desenhos ..."
		w_Aguarde.uo_Progress.of_Reset()
		
	Else
		This.of_Grava_Log("Nenhum produto foi localizado no desenho.", True)
		lb_Sucesso = False
	End If
	
catch ( runtimeerror  lo_rte )
	This.of_Grava_Log("Erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'uo_ge218_spaceman.of_atualiza_desenho. " +  lo_rte.GetMessage( ), True)
	lb_Sucesso = False	
finally
	Destroy(lds)
end try

Return lb_Sucesso
end function

public function boolean of_atualiza_estoque_minimo_vm ();Boolean lb_Sucesso

Long ll_Row
Long ll_Qtde
Long ll_Achou
Long ll_Produto
Long ll_Filial
Long ll_Estoque_Minimo_Atual
Long ll_Retorno
Long ll_Estoque_Minimo
Long ll_Promocao
Long ll_nr_canaleta
Long ll_qt_capacidade
Long ll_linhas

String ls_log
String ls_Chave

If This.il_Motivo = 0 Then
	SetNull(This.il_Motivo)
End If

ll_Qtde = UpperBound( il_Filiais[] )

For ll_Row = 1 To ll_Qtde
	
	lb_Sucesso = False
	
	ll_Filial  							= il_Filiais					[ ll_Row ]
	ll_Produto 						= il_Produtos				[ ll_Row ]
	ll_Estoque_Minimo_Atual		= il_Estoque_Minimo 		[ ll_Row ]
	ll_Promocao						= il_Promocao				[ ll_Row ]
	ll_nr_canaleta				= il_canaletas[ ll_Row ]
	ll_qt_capacidade = il_capacidade[ ll_Row ]
	
	//Se n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ preenchida a promo$$HEX2$$e700e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ porque a filial n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ no cluster. A atualiza$$HEX2$$e700e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ realizada na fun$$HEX2$$e700e300$$ENDHEX$$o of_atualiza_estoque_minimo
	If IsNull(ll_Promocao) Or ll_Promocao = 0 Then
		lb_Sucesso = True
		Continue
	End If

	//Ir$$HEX1$$e100$$ENDHEX$$ localizar se o produto esta ativo na promocao_sos
	
	Select count(*)
		Into :ll_Retorno
	From promocao_sos p
		Inner Join promocao_sos_produto pp
			on pp.cd_promocao_sos 	= p.cd_promocao_sos
		Inner Join promocao_sos_filial f
			on f.cd_promocao_sos = p.cd_promocao_sos
		Inner Join parametro x
			on x.id_parametro = x.id_parametro
	where p.id_tipo_promocao	= 'P'
		and p.dh_inicio 			<= x.dh_movimentacao
		and (p.dh_termino			>= x.dh_movimentacao Or p.dh_termino is null)
		and pp.cd_produto 		= :ll_Produto
		and f.cd_filial 				= :ll_Filial
		and p.cd_promocao_sos	= :ll_Promocao
	Using SqlCa;
		
	ls_Chave = String(ll_Filial) + " - " + String(ll_Produto) + " - Estoque Minimo: " + String(ll_Estoque_Minimo_Atual) + " - Promo$$HEX2$$e700e300$$ENDHEX$$o: " + String(ll_Promocao)
	
	Choose Case SqlCa.SqlCode
		
		Case -1
			This.of_Grava_Log(is_Chave + "Erro na consulta da promocao SOS: '" +  ls_Chave + "." + SqlCa.SqlErrText, True)
			lb_Sucesso = False
			
		Case 0
						
			//-----------------------------------------Incluir o Estoque m$$HEX1$$ed00$$ENDHEX$$nimo atraves da promocao ativa da Filial---------------------------
			If ll_Retorno = 0 Then
				
				If Not IsNull(ll_Promocao) Then
													
					//---------------------------Inclui o produto na promocao sos
					//Se localizou a promocao 'P' na filial	
					Insert Into promocao_sos_produto(
						cd_promocao_sos,
						cd_produto,
						pc_desconto) 
					Values(:ll_Promocao, 
								:ll_Produto, 
								0.00 )
					Using SqlCa;
					
					If SqlCa.SqlCode = 0 Then
						This.of_Grava_Log(is_Chave + "Produto cadastrado com sucesso na promocao_sos_produto: Chave: " + String(ll_Promocao) + " - " + String(ll_Produto) + ".", False )
						lb_Sucesso = True
					Else
						This.of_Grava_Log(is_Chave + "Erro ao inserir o produto na Promocao SOS Produto: Promocao: " + String(ll_Promocao) + " Produto: " + String(ll_Produto) + ".", True )
						lb_Sucesso = False	
					End If
				
				Else
					//----Se n$$HEX1$$e300$$ENDHEX$$o achou nenhuma promocao planograma
					This.of_Grava_Log(is_Chave + "Promo$$HEX2$$e700e300$$ENDHEX$$o Planograma n$$HEX1$$e300$$ENDHEX$$o localizada: Filial: " + String(ll_Filial) + ".", True )
					lb_Sucesso = False		
				End If
			End If
			
			If ll_Retorno = 1 Then
				lb_Sucesso = True
			End if
		End Choose
	
	If lb_Sucesso Then
		
		ls_Chave = String(ll_Promocao) + " - " + ls_Chave
		
		Select qt_estoque_minimo
			Into :ll_Estoque_Minimo 
		From promocao_sos_estoque_minimo
			Where cd_promocao_sos 		= :ll_Promocao
				and cd_produto 				= :ll_Produto
				and cd_filial 					= :ll_Filial
		Using SqlCa;		
		
		Choose Case SqlCa.SqlCode
				
			Case -1
				This.of_Grava_Log(is_Chave + "Erro no select do qt_estoque minimo da tabela promocao_sos_estoque_minimo: '" +  ls_Chave + "' . "  + SqlCa.SqlErrText, True)
				lb_Sucesso = False	
		
			Case 100
				//Se n$$HEX1$$e300$$ENDHEX$$o localizou, ser$$HEX1$$e100$$ENDHEX$$ incluso o produto na promocao_sos
				
				Insert Into promocao_sos_estoque_minimo
					(cd_promocao_sos,
					cd_filial,
					cd_produto,
					qt_estoque_minimo,
					nr_matricula_alteracao,
					cd_motivo_alteracao,
					qt_estoque_minimo_matriz)
				Values(	:ll_Promocao,
							:ll_Filial,
							:ll_Produto,
							:ll_Estoque_Minimo_Atual,
							:gvo_Aplicacao.ivo_Seguranca.Nr_Matricula,
							:This.il_Motivo,
							:ll_Estoque_Minimo_Atual)
				Using SqlCa;
							
				If SqlCa.SqlCode = 0 Then
					This.of_Grava_Log(is_Chave + "Estoque minimo do produto foi inclu$$HEX1$$ed00$$ENDHEX$$do com sucesso. Tabela promocao_sos_estoque_minimo: " + ls_Chave +"'. ", False )
					lb_Sucesso = True
				Else
					This.of_Grava_Log(is_Chave + "Erro no insert do produto na tabela promocao_sos_estoque_minimo. '" +  ls_Chave + "' . "  + SqlCa.SqlErrText, True)
					lb_Sucesso = False
				End If
				
			Case 0
				
				//Se localizou, ser$$HEX1$$e100$$ENDHEX$$ atribu$$HEX1$$ed00$$ENDHEX$$do o novo valor para o estoque minimo
				If ll_Estoque_Minimo > 0 And ll_Estoque_Minimo <> ll_Estoque_Minimo_Atual Then 
					
					//This.of_Grava_Log(is_Chave + "Estoque Minimo j$$HEX1$$e100$$ENDHEX$$ cadastrado. '" + ls_Chave + "' . ", False)
					//Continue
					
					Update promocao_sos_estoque_minimo
						set qt_estoque_minimo 			= :ll_Estoque_Minimo_Atual,
							 qt_estoque_minimo_matriz	= :ll_Estoque_Minimo_Atual,
							nr_matricula_alteracao		= :gvo_Aplicacao.ivo_Seguranca.Nr_Matricula,
							cd_motivo_alteracao			= :This.il_Motivo
						Where cd_promocao_sos 		= :ll_Promocao
							and cd_produto 				= :ll_Produto
							and cd_filial 					= :ll_Filial
						Using SqlCa;
						
					If SPACEMAN.SqlCode = -1 Then
						This.of_Grava_Log(is_Chave + "Erro no update da promocao qt_estoque_minimo de: '" +String(ll_Estoque_Minimo) + " para: "+String(ll_Estoque_Minimo_Atual)  + ". Chave: " + ls_Chave + "' . "  + SqlCa.SqlErrText, True)
						lb_Sucesso = False	
					End If											
				End If
						
		End Choose
		
	End If

	if Not this.of_atualiza_promocao_prd_vm( ll_promocao, ll_nr_canaleta, ll_qt_capacidade, ll_produto, ll_Filial, ref ls_log) Then
		This.of_Grava_Log(is_Chave + ls_log, True)
		lb_Sucesso = False	
	end if
	
	If Not lb_Sucesso Then Exit
	
Next

If lb_Sucesso Then
	SqlCa.of_Commit()
Else
	SqlCa.of_Rollback()
End If

Return lb_Sucesso
end function

public function boolean of_atualiza_promocao_prd_vm (long pl_cd_promocao, long pl_nr_canaleta, long pl_qt_capacidade, long pl_cd_produto, long pl_cd_filial, ref string ps_log);long ll_existe
long ll_for
long ll_linhas
long ll_nr_vm

dc_uo_ds_base lds_vm

lds_vm = create dc_uo_ds_base
lds_vm.of_changedataobject( 'ds_ge218_promocao_vm' )

ll_linhas = lds_vm.retrieve(pl_cd_promocao, pl_cd_filial)
	
for ll_for = 1 to ll_linhas
		
	ll_nr_vm = lds_vm.object.nr_vending_machine[ll_for]
	
	Select count(*)
	into :ll_existe
	from promocao_sos_vm_prd
	where cd_promocao_sos = :pl_cd_promocao
	and nr_vending_machine = :ll_nr_vm
	and nr_canaleta = :pl_nr_canaleta;
	
	if ll_existe = 0 or isnull(ll_existe) Then
		
		Insert into promocao_sos_vm_prd(cd_promocao_sos, nr_vending_machine, nr_canaleta, cd_produto, qt_capacidade_canaleta)
		values( :pl_cd_promocao, :ll_nr_vm, :pl_nr_canaleta, :pl_cd_produto, :pl_qt_capacidade);
	
		if sqlca.sqlcode = -1 then 
			ps_log = 'Objeto: ' + this.classname() + '; Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_promocao_prd_vm; Problemas ao inserir registro na tabela "promocao_sos_vm_prd": ' + sqlca.sqlerrtext
			return false
		end if
		
	else
	
		delete from promocao_sos_vm_prd 
		where cd_promocao_sos = :pl_cd_promocao
			and nr_vending_machine = :ll_nr_vm
			and nr_canaleta = :pl_nr_canaleta;
		
			if sqlca.sqlcode = -1 then 
				ps_log = 'Objeto: ' + this.classname() + '; Fun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_promocao_prd_vm; Problemas ao excluir registro na tabela "promocao_sos_vm_prd": ' + sqlca.sqlerrtext
				return false
			end if
			
	end if
			
next

return true
end function

event constructor;Spaceman = create dc_uo_transacao

ids_desenho_planograma = Create dc_uo_ds_base
ids_desenho_planograma.of_ChangeDataObject("ds_ge218_desenho_planograma")

ids_desenho_Filial = Create dc_uo_ds_base
ids_desenho_Filial.of_ChangeDataObject("ds_ge218_desenho_filial")

ids_log = Create dc_uo_ds_base
ids_log.of_ChangeDataObject("ds_ge218_log_erros")

//// para reprocessamento
//ivdt_Movimento_Parametro = Date("07/01/2013")
//
//If IsNull(ivdt_Movimento_Parametro) Then
//	ivdt_Movimento = Date(gf_GetServerDate())
//Else
//	If DayNumber(ivdt_Movimento_Parametro) = 2 Then
//		ivdt_Movimento = ivdt_Movimento_Parametro		
//	Else
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data informada '" + string(ivdt_Movimento_Parametro, "dd/mm/yyyy") +"' n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ referente a segunda-feira", StopSign!)	
//	End If
//End If
//
//ivdt_data_resumo = Date("01/" + String(Month(ivdt_Movimento)) + "/" + String(Year(ivdt_Movimento)))
//
//lvd_Inicio_Ano = Date("01/01/" + String(Year(ivdt_Movimento)))
//
//Date lvdt_teste
//	
//lvd_Inicio_Ano = RelativeDate(Date(String(ivdt_Movimento, "yyyy") + "/01/01"),3)
//
//ivs_Semana = String(Year(ivdt_Movimento)) + String(Round(DaysAfter(lvd_Inicio_Ano, ivdt_Movimento ) / 7, 0 ) + 1, "00")
//
//of_Periodo_Venda_Filial()

ivo_Produto = Create uo_Produto





end event

on uo_ge218_spaceman.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge218_spaceman.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;Destroy(Spaceman)
Destroy(ids_Desenho_Planograma)
Destroy(ids_Desenho_Filial)
Destroy(ivo_Produto)
Destroy(ids_log)
end event

