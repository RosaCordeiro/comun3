HA$PBExportHeader$uo_el101_extracao_dados.sru
forward
global type uo_el101_extracao_dados from nonvisualobject
end type
end forward

global type uo_el101_extracao_dados from nonvisualobject
end type
global uo_el101_extracao_dados uo_el101_extracao_dados

type variables
String ls_Log
Date  adh_ultima_carga

String SEPARADOR = ";"

dc_uo_ds_base lds1 

Date adh_inicio, adh_termino
Date ldt_Movimento


String ls_Arquivo_cupons, ls_Arquivo_produtos, is_Dir_Arquivo



end variables

forward prototypes
public function boolean of_busca_datas ()
public function boolean of_atualiza_data ()
public function boolean of_gera_dados_produtos (string as_tipo)
public function boolean of_gera_dados_nota ()
public subroutine of_envia_email (string al_tipo)
public function boolean of_atualiza_log_produtos (long al_produto)
end prototypes

public function boolean of_busca_datas ();
adh_termino = Date (gf_GetServerDate())

Select  vl_parametro
Into 	   :adh_ultima_carga
From    parametro_geral
Where cd_parametro = 'DT_PROX_EXPORTACAO_CLIC'
Using SqlCA;


If SqlCa.SqlCode = -1 Then
	ls_Log	= "Erro ao localizar a proxima data da carga: uo_el101_extracao_dados.of_busca_ultima_carga()." + " Erro: "+ SqlCa.SqlErrText
	gvo_aplicacao.of_grava_log(ls_Log)			
	Return False
Else
	Return True
End If 







end function

public function boolean of_atualiza_data ();
String ls_dta_atualiza

ls_dta_atualiza = String (adh_termino ,  "mm/dd/yyyy" )

Update parametro_geral
Set  vl_parametro =:ls_dta_atualiza
where cd_parametro  = 'DT_PROX_EXPORTACAO_CLIC'
Using SqlCA;


If SqlCa.sqlcode = -1 Then
	ls_Log	= "Erro na atualizacao parametro :  DT_PROX_EXPORTACAO_CLIC'. Erro: "+SqlCa.sqlErrText
	Return False
Else
	SqlCa.of_Commit()
	Return True 	
End If 


Return True 



end function

public function boolean of_gera_dados_produtos (string as_tipo);// TIPOS DE ATUALIZACAO 
//	Tipo  = T - Lista Total de Produtos   A - Lista Produtos Alterados (as_tipo ) 

Boolean lb_Grava_Cabecalho = True 
Boolean lb_Erro = False
Boolean lb_Carga_Produtos = True 

Long ll_Linhas, &
		ll_Linha, &
		ll_Cod_Sku

String  lvs_Desc_sku1,&
		  lvs_Desc_sku2,&
		  lvs_Situacao,&
		  lvs_SubCategoria,&
		  lvs_Categoria,&
		  lvs_SubGrupo,&
		  lvs_Grupo,&
		   ls_Registro
			

Integer li_Arq,&
			li_Ret,&
			li_Retorno

Try
	If Not IsValid(w_aguarde) then
		Open(w_aguarde)
	End If	

	// Data Store
	lds1  = Create dc_uo_ds_base
	If Not lds1.of_ChangeDataObject('ds_el101_produtos', False) Then 
		gvo_aplicacao.of_grava_log("CLIC - Extra$$HEX2$$e700e300$$ENDHEX$$o de Produtos - Erro alterar a DS [ds_el100_produtos] - uo_el100_extracao_dados_produtos.of_gera_dados_produtos")
		lb_Carga_Produtos = False
		Return lb_Carga_Produtos
	End If
	
	// Para Listar produtos alterados
	If as_Tipo = 'A' Then 
		lds1.of_appendwhere_subquery( " g.cd_produto in (select distinct cast (de_chave as int ) as cd_produto  from log_exportacao_clic where id_atualizacao in ('A', 'I') and id_processado = 'N'   )" , 5)		
	End If 	
		
	// Local onde Grava
	is_Dir_Arquivo = ProfileString(gvo_aplicacao.ivs_arquivo_ini,"CLIC", "Arquivos_CLIC", gvo_aplicacao.ivs_path_arquivos+"\Arquivos_CLIC")
	If Not DirectoryExists(is_Dir_Arquivo) Then CreateDirectory(is_Dir_Arquivo)
	
	// Nome do Arquivo e Local
	ls_Arquivo_produtos =  is_Dir_Arquivo + "\PRODUTOS_"+  String( Date (gf_GetServerDate()) , "yyyymmdd") + ".EXP"
	
	
	If FileExists (ls_Arquivo_produtos) Then
		li_Retorno = 1 
		Choose Case li_Retorno
			Case 1
				If Not FileDelete ( ls_Arquivo_produtos ) Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao excluir o arquivo '" + ls_Arquivo_produtos + "'.", StopSign!)
					gvo_aplicacao.of_grava_log("CLIC - Extra$$HEX2$$e700e300$$ENDHEX$$o de Produtos - Erro ao excluir o arquivo: uo_el100_extracao_dados_produtos.of_gera_dados_produtos")
					lb_Carga_Produtos = False
					Return lb_Carga_Produtos
				End If
			Case 2
				lb_Grava_Cabecalho = False
				lb_Carga_Produtos = False
				Return lb_Carga_Produtos
			Case 3
				gvo_aplicacao.of_grava_log("CLIC - Extra$$HEX2$$e700e300$$ENDHEX$$o de Produtos - Erro ao excluir o arquivo: uo_el100_extracao_dados_produtos.of_gera_dados_produtos")
				lb_Carga_Produtos = False
				Return lb_Carga_Produtos
		End Choose
	End If
		
	li_Arq = FileOpen(ls_Arquivo_produtos, LineMode!, Write!, LockReadWrite!, Append!, EncodingANSI!)

	If li_Arq = -1 Then
		gvo_aplicacao.of_grava_log("CLIC - Extra$$HEX2$$e700e300$$ENDHEX$$o de Produtos - Erro ao abrir o arquivo: uo_el100_extracao_dados_produtos.of_gera_dados_produtos")
		lb_Carga_Produtos = False
		Return lb_Carga_Produtos
	End If
		
	If lb_Grava_Cabecalho Then
		ls_Registro = 	"COD_SKU" + SEPARADOR +&
							"DESC_SKU1" + SEPARADOR +&
							"DESC_SKU2" + SEPARADOR +&
							"SITUACAO" + SEPARADOR +&
							"SUBCATEGORIA" + SEPARADOR +&
							"CATEGORIA" + SEPARADOR +&
							"SUBGRUPO" + SEPARADOR +&						
							"GRUPO"
							
		li_Ret = FileWrite(li_Arq, ls_Registro)
		
		If IsNull(li_Ret) or li_Ret <= 0 Then
			lb_Erro = True
			gvo_aplicacao.of_grava_log("CLIC - Extra$$HEX2$$e700e300$$ENDHEX$$o de Produtos - Erro ao gravar registro cabe$$HEX1$$e700$$ENDHEX$$alho: uo_el100_extracao_dados_produtos.of_gera_dados_produtos")
			lb_Carga_Produtos = False
			Return lb_Carga_Produtos
		End If	
	End If	
	
	// Executa DS de Produtos
	ll_Linhas = lds1.Retrieve()
	
	If ll_Linhas >0  and Not lb_Erro Then 
		If Not IsValid(w_aguarde) then
			Open(w_aguarde)
		End If	
		
		w_aguarde.Title = "[CLIC] - Extra$$HEX2$$e700e300$$ENDHEX$$o de Dados dos Produtos :"
		w_aguarde.uo_progress.of_reset()
		w_aguarde.uo_progress.Of_SetMax(ll_Linhas)		
		
		
		For ll_Linha = 1 To ll_Linhas	// Para todas as Lojas			
			
			ll_Cod_Sku 		= lds1.Object.Cod_Sku [ll_Linha]
			lvs_Desc_sku1 	=  lds1.Object.Desc_sku1 [ll_Linha]
			lvs_Desc_sku2 	=  lds1.Object.Desc_sku2 [ll_Linha]
			lvs_Situacao  		=  lds1.Object.Situacao [ll_Linha]
			lvs_SubCategoria  =   lds1.Object.SubCategoria [ll_Linha]
			lvs_Categoria  	=   lds1.Object.Categoria [ll_Linha]
			lvs_SubGrupo  	=   lds1.Object.SubGrupo [ll_Linha]
			lvs_Grupo		= lds1.Object.Grupo [ll_Linha]
			
			w_aguarde.Title =  "[CLIC] - Extra$$HEX2$$e700e300$$ENDHEX$$o de Dados dos Produtos : Linha:" + String(ll_Linha)+" De: "+String(ll_Linhas)				
			
						
			ls_Registro = 	String(ll_Cod_Sku)  + SEPARADOR +&
							lvs_Desc_sku1  + SEPARADOR +&
							lvs_Desc_sku2  + SEPARADOR +&
							lvs_Situacao + SEPARADOR +&
							lvs_SubCategoria  + SEPARADOR +&
							lvs_Categoria + SEPARADOR +&
							lvs_SubGrupo + SEPARADOR +&						
							lvs_Grupo 
												
			// Dados dos Produtos
			li_Ret = FileWrite(li_Arq, ls_Registro)					
					
			If IsNull(li_Ret) or li_Ret <= 0 Then
				lb_Erro = True
				gvo_aplicacao.of_grava_log("CLIC - Extra$$HEX2$$e700e300$$ENDHEX$$o de Produtos - Erro dados produtos: uo_el100_extracao_dados_produtos.of_gera_dados_produtos")
				lb_Carga_Produtos = False
				Return lb_Carga_Produtos				
			End If				
			
			If as_Tipo = 'A' Then
				If Not This.of_atualiza_log_produtos(ll_Cod_Sku) Then 
					gvo_aplicacao.of_grava_log("CLIC - Extra$$HEX2$$e700e300$$ENDHEX$$o de Produtos - Erro na aluliza$$HEX2$$e700e300$$ENDHEX$$o log_exportacao_clic : uo_el100_extracao_dados_produtos.of_gera_dados_produtos")
					lb_Carga_Produtos = False
					Return lb_Carga_Produtos									
				End If
			End If
			
			
			w_aguarde.uo_progress.Of_SetProgress(ll_Linha)					
		Next
	Else
		gvo_aplicacao.of_grava_log("CLIC - Extra$$HEX2$$e700e300$$ENDHEX$$o de Produtos - Sem Atualiza$$HEX2$$e700f500$$ENDHEX$$es: uo_el100_extracao_dados_produtos.of_gera_dados_produtos")		
	End If 
Catch ( runtimeerror  lo_rte )
	gvo_aplicacao.of_grava_log("CLIC - Extra$$HEX2$$e700e300$$ENDHEX$$o de Produtos - Erro : uo_el100_extracao_dados_produtos.of_gera_dados_produtos")
	lb_Carga_Produtos = False
	Return lb_Carga_Produtos
Finally		
	FileClose (li_Arq)
	If IsValid(w_aguarde) then Close(w_aguarde)
	Destroy (lds1)
End Try

Return lb_Carga_Produtos
end function

public function boolean of_gera_dados_nota ();Boolean lb_Grava_Cabecalho, lb_Erro = False
Boolean lb_Carga_Cupons = True 

String ls_Registro, ls_Hora, ls_Movimento

String CIDADE, UF, BANDEIRA, lvs_SQL

Integer li_Arq, li_Ret, li_Retorno

Long ll_Filial, NOTA, SEQUENCIAL, COD_SKU, ll_Nota_Anterior, ll_Conta_Nota, ll_Filial_Ant, ll_Cont_Fil

String FABRICANTE, SUBCATEGORIA, CATEGORIA, SUBGRUPO, GRUPO,  DESCRICAO_SKU		

Long QT_VENDIDA, ll_Total_Fil
Decimal PRECO_BRUTO, PC_DESCONTO, PC_DESCONTO_NOTA, PRECO_LIQ, PC_COMISSAO
String TIPO_VENDA, CONVENIO, DESC_PROMOCAO, VENDA_PBM, COD_PROMO

Decimal PC_DESC_UNIMED, PC_DESC_CONVENIO, PC_ICMS, VALOR_IMPOSTO, VALOR_CUSTO, VALOR_COMISSAO, VALOR_RENT_LIQ, PC_MARGEM_LIQ
String VENDA_FARM_GOV, ECOMMERCE
Decimal PC_DESCONTO_PROMO


If Not of_busca_datas( ) Then 
	lb_Carga_Cupons = False
	gvo_aplicacao.of_grava_log("CLIC - Extra$$HEX2$$e700e300$$ENDHEX$$o de Cupons - Erro na busca das datas: uo_el100_extracao_dados_produtos.of_gera_dados_nota")
	Return	lb_Carga_Cupons
Else
	adh_inicio  = adh_ultima_carga
End If 


dc_uo_ds_base lds_Filial

lb_Grava_Cabecalho = True

// Local onde Grava
is_Dir_Arquivo = ProfileString(gvo_aplicacao.ivs_arquivo_ini,"CLIC", "Arquivos_CLIC", gvo_aplicacao.ivs_path_arquivos+"\Arquivos_CLIC")
If Not DirectoryExists(is_Dir_Arquivo) Then CreateDirectory(is_Dir_Arquivo)
	
// Nome do Arquivo e Local
ls_Arquivo_cupons = is_Dir_Arquivo  + "\CUPONS_" + string(adh_inicio, "yyyymmdd") + "_ATE_"   + string(adh_termino, "yyyymmdd")    + ".EXP"

If FileExists (ls_Arquivo_cupons) Then
	
	//li_Retorno = MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O arquivo '" + ls_Arquivo + "' j$$HEX1$$e100$$ENDHEX$$ existe.~r~rDeseja substitu$$HEX1$$ed00$$ENDHEX$$-lo?~rSIM -> O arquivo antigo ser$$HEX1$$e100$$ENDHEX$$ exclu$$HEX1$$ed00$$ENDHEX$$do e criado um novo.~rNAO -> As novas informa$$HEX2$$e700f500$$ENDHEX$$es ser$$HEX1$$e300$$ENDHEX$$o inclu$$HEX1$$ed00$$ENDHEX$$das no mesmo arquivo.", Question!, YesNoCancel!, 2)
	li_Retorno = 1 
	Choose Case li_Retorno
		Case 1
			If Not FileDelete ( ls_Arquivo_cupons ) Then
				lb_Carga_Cupons = False
				gvo_aplicacao.of_grava_log("CLIC - Extra$$HEX2$$e700e300$$ENDHEX$$o de Cupons - Erro ao excluir o arquivo: uo_el100_extracao_dados_produtos.of_gera_dados_nota")
				Return lb_Carga_Cupons
			End If
		Case 2
			lb_Grava_Cabecalho = False
		Case 3
			lb_Carga_Cupons = False
			Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O processo foi abortado.", Exclamation!)
			gvo_aplicacao.of_grava_log("CLIC - Extra$$HEX2$$e700e300$$ENDHEX$$o de Cupons - O Processo foi Abortado: uo_el100_extracao_dados_produtos.of_gera_dados_nota")
			Return lb_Carga_Cupons
	End Choose
End If
	
li_Arq = FileOpen(ls_Arquivo_cupons, LineMode!, Write!, LockReadWrite!, Append!, EncodingANSI!)

If li_Arq = -1 Then
	lb_Carga_Cupons = False
	gvo_aplicacao.of_grava_log("CLIC - Extra$$HEX2$$e700e300$$ENDHEX$$o de Cupons - Erro ao abrir o aquivo:" + ls_Arquivo_cupons )
	Return lb_Carga_Cupons
End If


Try

	If Not IsValid(w_aguarde) then
		Open(w_aguarde)
	End If	
				
			
	If lb_Grava_Cabecalho Then
		ls_Registro = 	"VENDA" + SEPARADOR +&
							"HORA" + SEPARADOR +&
							"COD_FIL" + SEPARADOR +&
							"CIDADE" + SEPARADOR +&
							"UF" + SEPARADOR +&
							"BANDEIRA" + SEPARADOR +&
							"NOTA" + SEPARADOR +&						
							"COD_SKU" + SEPARADOR +&
							"QT_VENDIDA" + SEPARADOR +&
							"PRECO_BRUTO" + SEPARADOR +&
							"PC_DESCONTO" + SEPARADOR +&
							"PC_DESCONTO_NOTA" + SEPARADOR +&
							"PRECO_LIQ" + SEPARADOR +&
							"PC_COMISSAO" + SEPARADOR +&
							"TIPO_VENDA" + SEPARADOR +&
							"CONVENIO" + SEPARADOR +&
							"VENDA_PBM" + SEPARADOR +&
							"VENDA_FARM_GOV" + SEPARADOR +&
							"VALOR_IMPOSTO" + SEPARADOR +&
							"VALOR_CUSTO" + SEPARADOR +&
							"VALOR_COMISSAO" + SEPARADOR +&
							"VALOR_RENT_LIQ" 
							
		li_Ret = FileWrite(li_Arq, ls_Registro)
		
		If IsNull(li_Ret) or li_Ret <= 0 Then
			lb_Erro = True
			lb_Carga_Cupons = False
			gvo_aplicacao.of_grava_log("CLIC - Extra$$HEX2$$e700e300$$ENDHEX$$o de Cupons - Erro ao gravar registro cabe$$HEX1$$e700$$ENDHEX$$alho no arquivo")
			Return lb_Carga_Cupons
		End If	
	End If
	
	lds_Filial = Create dc_uo_ds_base
	
	If Not lds_Filial.of_ChangeDataObject("ds_el101_filiais") Then 
		lb_Carga_Cupons= False
		lb_Erro = True
		Return lb_Carga_Cupons
	End If
	
	
	ll_Total_Fil = lds_Filial.Retrieve()
	
	For ll_Cont_Fil = 1 To ll_Total_Fil
		
		ll_Filial = lds_Filial.Object.cd_filial[ll_Cont_Fil]

		ldt_Movimento = adh_inicio
									
		Do While ldt_Movimento < adh_termino  /// Data do Parametro $$HEX1$$e900$$ENDHEX$$ Menor que Data de Hora ( data do dia n$$HEX1$$e300$$ENDHEX$$o entra )
			
			w_Aguarde.Title = "[CLIC] - Extra$$HEX2$$e700e300$$ENDHEX$$o de Dados dos Cupons: Filial [" + String(ll_Filial) + "] - Emiss$$HEX1$$e300$$ENDHEX$$o : " + String(ldt_Movimento, "dd/mm/yyyy")
			
			lvs_SQL = 	"select		substring(CONVERT( CHAR(10), n.dh_movimentacao_caixa, 103 ), 1, 10), "+&
							"						convert(char(12), dh_emissao, 18), "+&
							"						n.cd_filial, "+&
							"						ci.nm_cidade, "+&
							"						ci.cd_unidade_federacao,  "+&
							"						( case coalesce(f.id_rede_filial, 'XX') "+&
							"								when    'AL' then 'ALOMED' "+&
							"							when    'CP' then 'CATARINENSE PLUS' "+&
							"							when    'DC' then 'DROGARIA CATARINENSE' "+&
							"							when    'DP' then 'DROG. PRECO POPULAR'		 "+&							
							"							when    'FA' then 'FARMAGORA' "+&
							"							when    'MP' then 'MANIPULACAO' "+&
							"							when    'PP' then 'PRECO POPULAR' "+&
							"							when	'PF' then 'PROFORMULA' "+&
							"							else 'NAO IDENTIFICADO' "+&
							"						end ), "+&
							"						n.nr_nf, "+&
							"						i.nr_sequencial, "+&
							"						fo.nm_razao_social, "+&
							"						i.cd_produto, "+&						
							"						i.qt_vendida 	, "+&
							"						i.vl_preco_unitario , "+&
							"						i.pc_desconto_tabela , "+&
							"						n.pc_desconto , "+&
							"						round(i.qt_vendida * cast(round(round(i.vl_preco_unitario * ((100 - i.pc_desconto_tabela) / 100), 2) * ((100 - n.pc_desconto) / 100), 2) as decimal(11,2)) ,2), "+&
							"						i.pc_comissao_extra , "+&
							"						 (case n.id_tipo_venda  "+&
							"							when 'AV' THEN 'AVISTA' "+&
							"							when 'CV' THEN 'CONVENIO' "+&
							"							when 'CC' THEN 'CONTA CORRENTE' "+&
							"							when 'CR' THEN 'CREDIARIO' "+&
							"						 END), "+&
							"						coalesce(co.nm_fantasia, '') , "+&
							"						coalesce((CASE WHEN coalesce(v.id_pbm, 'N') = 'S' THEN '' ELSE cast(i.cd_promocao_sos as VARCHAR(6)) END), ''), "+&
							"						coalesce((CASE WHEN coalesce(v.id_pbm, 'N') = 'S' THEN '' ELSE pro.nm_promocao_sos END), ''), "+&
							"						coalesce((CASE WHEN coalesce(v.id_pbm, 'N') = 'S' THEN 0 ELSE prop.pc_desconto END), 0), "+&
							"						coalesce(v.id_pbm, 'N'), "+&
							"						 (Case When (	select count(*)  "+&
							"											from venda_pbm vp  "+&
							"											WHERE vp.cd_filial = n.cd_filial  "+&
							"												and vp.nr_nf = n.nr_nf  "+&
							"												and vp.de_especie = n.de_especie  "+&
							"												and vp.de_serie = n.de_serie "+&
							"												AND vp.cd_convenio = 52575  "+&
							"												and vp.nr_comprovante_venda = 'AVFARPOP') > 0  "+&
							"								Then 'S' 	else 'N' END	), "+&
							"						coalesce(uv.pc_desconto_drogaria  + uv.pc_desconto_unimed, 0), "+&
							"					(CASE WHEN coalesce(uv.pc_desconto_nf, 0) > 0  "+&
							"							 THEN coalesce(uv.pc_desconto_nf, 0)  "+&
							"							  ELSE (CASE WHEN (coalesce(uv.pc_desconto_drogaria, 0) + coalesce(uv.pc_desconto_unimed, 0)) = 0   "+&
							"										THEN n.pc_desconto  "+&
							"										ELSE 0 "+&
							"									  END)  "+&
							"					 END) , "+&
							"					(Case when coalesce(n.nr_pedido_ecommerce, 0) > 0 Then 'S' else 'N' END) , "+&
							"					 i.pc_icms, "+&
							"					 round(i.qt_vendida * cast(round(round(round(i.vl_preco_unitario * ((100 - i.pc_desconto_tabela) / 100), 2) * ((100 - n.pc_desconto) / 100), 2) * (i.pc_icms / 100), 2) as decimal(11,2)) ,2),  "+&
							"					 round(i.qt_vendida * coalesce(m.vl_custo_unitario, 0),2), "+&
							"					 round(i.qt_vendida * cast(round(round(round(i.vl_preco_unitario * ((100 - i.pc_desconto_tabela) / 100), 2) * ((100 - n.pc_desconto) / 100), 2) * (i.pc_comissao_extra / 100), 2) as decimal(11,2)) ,2),  "+&
							"					 round(i.qt_vendida * cast(round(round(i.vl_preco_unitario * ((100 - i.pc_desconto_tabela) / 100), 2) * ((100 - n.pc_desconto) / 100), 2)  "+&
							"					 - m.vl_custo_unitario "+&
							"					 - round(round(round(i.vl_preco_unitario * ((100 - i.pc_desconto_tabela) / 100), 2) * ((100 - n.pc_desconto) / 100), 2) * (i.pc_comissao_extra / 100), 2) "+&
							"					 - round(round(round(i.vl_preco_unitario * ((100 - i.pc_desconto_tabela) / 100), 2) * ((100 - n.pc_desconto) / 100), 2) * (i.pc_icms / 100), 2) as decimal(11,2)) ,2) "+&
							"			from nf_venda n (index idx_data_filial) "+&
							"			inner join filial f (index pk_filial) "+&
							"				on f.cd_filial = n.cd_filial "+&
							"			inner join cidade ci "+&
							"				on ci.cd_cidade = f.cd_cidade "+&
							"			inner join item_nf_venda i (index pk_item_nf_venda) "+&
							"				on i.cd_filial = n.cd_filial "+&
							"				and i.nr_nf = n.nr_nf "+&
							"				and i.de_especie = n.de_especie "+&
							"				and i.de_serie		= n.de_serie "+&
							"			inner join movimento_estoque m (index idx_nota) "+&
							"				on m.cd_filial_movimento = i.cd_filial "+&
							"				and m.nr_nf			= i.nr_nf "+&
							"				and m.de_especie	= i.de_especie "+&
							"				and m.de_serie		= i.de_serie "+&
							"				and m.cd_produto	= i.cd_produto "+&
							"				and coalesce(m.nr_sequencial, 1) = coalesce(i.nr_sequencial, 1) "+&
							"			inner join produto_geral g (index pk_produto_geral) "+&
							"				on g.cd_produto = i.cd_produto "+&
							"			inner join fornecedor fo (index pk_fornecedor) "+&
							"				on fo.cd_fornecedor = g.cd_fornecedor_usual "+&
							"			left outer join convenio co "+&
							"				on co.cd_convenio = n.cd_convenio "+&
							"			left outer join venda_pbm_produto v "+&
							"				on v.cd_filial = n.cd_filial "+&
							"				and v.nr_nf		= n.nr_nf "+&
							"				and v.de_especie	 = n.de_especie "+&
							"				and v.de_serie		= n.de_serie "+&
							"				and v.cd_produto	= i.cd_produto "+&
							"				and v.nr_sequencial = i.nr_sequencial "+&
							"			left outer join promocao_sos pro "+&
							"				on pro.cd_promocao_sos = i.cd_promocao_sos "+&
							"			left outer join promocao_sos_produto prop "+&
							"				on prop.cd_promocao_sos = pro.cd_promocao_sos "+&
							"				and prop.cd_produto = i.cd_produto "+&
							"			left outer join unimed_venda uv "+&
							"				 on uv.cd_filial = n.cd_filial  "+&
							"				and uv.nr_nf = n.nr_nf  "+&
							"				and uv.de_especie = n.de_especie  "+&
							"				and uv.de_serie = n.de_serie "+&
							"			where n.dh_movimentacao_caixa = '"+string(ldt_Movimento, 'yyyymmdd')+"'" +&   
							"			  and n.dh_cancelamento is null "+&
							"			  and n.nr_nf_anexa is null "+&
							"			  and n.nr_pedido_ecommerce is null "+&
							"			  and i.cd_produto <> 684431 "+&
							"			  and substring(g.cd_subcategoria,1,1) = '1'  " +&
							"			  and f.cd_filial  =" + String (ll_Filial ) 
					
														
			lvs_SQL += "			order by   n.dh_movimentacao_caixa   "
			
			PREPARE SQLSA FROM :lvs_SQL ;
			DESCRIBE SQLSA INTO SQLDA ;
			DECLARE lcu_Notas DYNAMIC CURSOR FOR SQLSA ;
			OPEN DYNAMIC lcu_Notas USING DESCRIPTOR SQLDA ;
			FETCH lcu_Notas INTO :ls_Movimento, :ls_Hora, :ll_Filial,  :CIDADE, :UF, :BANDEIRA, :NOTA, :SEQUENCIAL, :FABRICANTE,   :COD_SKU,
										  :QT_VENDIDA, :PRECO_BRUTO, :PC_DESCONTO, :PC_DESCONTO_NOTA, :PRECO_LIQ, :PC_COMISSAO, :TIPO_VENDA, :CONVENIO, :COD_PROMO, :DESC_PROMOCAO, :PC_DESCONTO_PROMO, :VENDA_PBM,
										  :VENDA_FARM_GOV, :PC_DESC_UNIMED, :PC_DESC_CONVENIO,  :ECOMMERCE,  :PC_ICMS, :VALOR_IMPOSTO, :VALOR_CUSTO, :VALOR_COMISSAO, :VALOR_RENT_LIQ;
		
			If SQLCA.sqlcode = -1 Then
				lb_Erro = True
				lb_Carga_Cupons = False
				gvo_aplicacao.of_grava_log("CLIC - Extra$$HEX2$$e700e300$$ENDHEX$$o de Cupons - Erro ao recuperar informa$$HEX2$$e700f500$$ENDHEX$$es do cursor")
				Return lb_Carga_Cupons
			End If
			
			// Repetir Enquanto Houver Linhas
			DO WHILE SQLCA.sqlcode = 0
								
					ls_Registro = ls_Movimento + SEPARADOR +&
										ls_Hora + SEPARADOR +&
										String(ll_Filial) + SEPARADOR +&
										CIDADE + SEPARADOR +&
										UF + SEPARADOR +&
										BANDEIRA + SEPARADOR +&
										string(NOTA) + SEPARADOR +&
										string(COD_SKU) + SEPARADOR +&										
										String(QT_VENDIDA) + SEPARADOR +&
										String(PRECO_BRUTO) + SEPARADOR +&
										String(PC_DESCONTO) + SEPARADOR +&
										String(PC_DESCONTO_NOTA) + SEPARADOR +&
										String(PRECO_LIQ) + SEPARADOR +&
										String(PC_COMISSAO) + SEPARADOR +&
										TIPO_VENDA + SEPARADOR +&
										CONVENIO + SEPARADOR +&
										VENDA_PBM + SEPARADOR +&
										VENDA_FARM_GOV + SEPARADOR +&
										String(VALOR_IMPOSTO) + SEPARADOR +&
										String(VALOR_CUSTO) + SEPARADOR +&
										String(VALOR_COMISSAO) + SEPARADOR +&
										String(VALOR_RENT_LIQ)
												
					// Cabecalho
					li_Ret = FileWrite(li_Arq, ls_Registro)					
					
					If IsNull(li_Ret) or li_Ret <= 0 Then
						lb_Erro = True
						lb_Carga_Cupons = False
						gvo_aplicacao.of_grava_log("CLIC - Extra$$HEX2$$e700e300$$ENDHEX$$o de Cupons - Erro ao gravar registro cabe$$HEX1$$e700$$ENDHEX$$alho no arquivo")
						Return lb_Carga_Cupons
					End If	
																	
					//Busca pr$$HEX1$$f300$$ENDHEX$$ximo valor
					FETCH lcu_Notas INTO 	:ls_Movimento, :ls_Hora, :ll_Filial, :CIDADE, :UF, :BANDEIRA, :NOTA, :SEQUENCIAL, :FABRICANTE, :COD_SKU, 
													:QT_VENDIDA, :PRECO_BRUTO, :PC_DESCONTO, :PC_DESCONTO_NOTA, :PRECO_LIQ, :PC_COMISSAO, :TIPO_VENDA, :CONVENIO, :COD_PROMO, :DESC_PROMOCAO,:PC_DESCONTO_PROMO, :VENDA_PBM,
													:VENDA_FARM_GOV, :PC_DESC_UNIMED, :PC_DESC_CONVENIO,  :ECOMMERCE,  :PC_ICMS, :VALOR_IMPOSTO, :VALOR_CUSTO, :VALOR_COMISSAO, :VALOR_RENT_LIQ;
			LOOP
			
			CLOSE lcu_Notas;			
		
			ldt_Movimento = RelativeDate(ldt_Movimento, 1)
		Loop
		
		GarbageCollect ()
	
	Next

CATCH (runtimeerror er)   
	lb_Erro = True
   MessageBox("Exce$$HEX2$$e700e300$$ENDHEX$$o de Erro", er.GetMessage())
Finally
	Destroy(lds_Filial)
	FileClose (li_Arq)
	
	If lb_Erro Then
		FileDelete(ls_Arquivo_cupons) 
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'O arquivo TXT foi exclu$$HEX1$$ed00$$ENDHEX$$do por conter erros.')
		gvo_aplicacao.of_grava_log("CLIC - Extra$$HEX2$$e700e300$$ENDHEX$$o de Cupons - O arquivo excluido por conter erros")
	Else
		If  FileLength(ls_Arquivo_cupons) = 0 Then
			FileDelete(ls_Arquivo_cupons) 
		End If 

		// Atualiza$$HEX2$$e700e300$$ENDHEX$$o de Data do Parametro
		If Not of_atualiza_data() Then 
			lb_Carga_Cupons = False
			Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao atualizar a data do parametro!!.", StopSign!)
			gvo_aplicacao.of_grava_log("CLIC - Extra$$HEX2$$e700e300$$ENDHEX$$o de Cupons - Erro ao atualizar data do parametro")
			Return lb_Carga_Cupons
		End If 		
	End If 

	
	Close(w_Aguarde)
End try

Return lb_Carga_Cupons

end function

public subroutine of_envia_email (string al_tipo);DateTime ldh_solicitacao,&
			 ldh_Envio	
String ls_Texto_email
String ls_Dados_Email
Long  ll_Cod_Msg
String ls_Extra_Email
String ls_Texto_Email_Extra
String ls_Tipo
		 
s_email str //ge202
ll_Cod_Msg = 189

If al_tipo = 'E' Then 
	ls_Tipo = "[CLIC] Exporta$$HEX2$$e700e300$$ENDHEX$$o de Dados : Erro Na Gera$$HEX2$$e700e300$$ENDHEX$$o"
Else
	ls_Tipo = "[CLIC] Exporta$$HEX2$$e700e300$$ENDHEX$$o de Dados : Sucesso de Envio"	
End If 	
	
	
ldh_Envio 	= gf_GetServerDate()	

ls_Texto_Email = 	"<HTML>"+&
										"<BODY>"+&
										"<BR>"+&										
										"<TABLE border=0>"+&
										"<TR>"+& 
										"<TD><B>" + ls_Tipo + " no Envio dos Dados</B></TD>"+&	
										"</TR>"+&
										"<TR>"+& 
										"<TD>Tipo de Carga: Cupons/Produtos</TD>"+&	
										"</TR>"+&
										"<TR>"+& 
										"<TD>Data Gera$$HEX2$$e700e300$$ENDHEX$$o/Envio: " +string(ldh_Envio) + "~n</TD> "+&	
										"</TR>"+& 																				
										"<TR>"+& 
										"<TD>Arquivo de Cupom: " +string(ls_Arquivo_cupons) + "~n</TD> "+&	
										"</TR>"+& 																				
										"<TR>"+& 
										"<TD>Arquivo de Produtos: " +string(ls_Arquivo_produtos) + "~n</TD> "+&	
										"</TR>"+& 	
										"</TABLE>"+&
										"</BODY>"+&	
										"</HTML>" 	


If  al_tipo<>"" Then 
	str.ps_Mensagem	= ls_Texto_Email
	//str.ps_to[1] 			= ls_EmailLoja
	str.pb_Assinatura	= True
	gf_ge202_envia_email_padrao(ll_Cod_Msg, str)
Else
	Return 
End If 
end subroutine

public function boolean of_atualiza_log_produtos (long al_produto);
Update  log_exportacao_clic
Set    	 id_processado   = 'P'
Where   id_atualizacao  IN ('A', 'I' ) 
And      cast(de_chave as int ) = :al_produto
Using SqlCA;


If SqlCa.sqlcode = -1 Then
	ls_Log	= "Erro na atualizacao lon : LOG_EXPORTACAO_CLI'. Erro: "+SqlCa.sqlErrText
	Return False
Else
	SqlCa.of_Commit()
	Return True 	
End If 

end function

on uo_el101_extracao_dados.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_el101_extracao_dados.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;
//is_Login_Prod			= "XXXXXX"
//is_Senha_Prod			= "XXXXXXX"




end event

