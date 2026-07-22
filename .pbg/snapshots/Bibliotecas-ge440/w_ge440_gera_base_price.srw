HA$PBExportHeader$w_ge440_gera_base_price.srw
forward
global type w_ge440_gera_base_price from dc_w_response_ok_cancela
end type
type cb_1 from commandbutton within w_ge440_gera_base_price
end type
end forward

global type w_ge440_gera_base_price from dc_w_response_ok_cancela
boolean visible = false
integer width = 1605
integer height = 688
boolean enabled = false
string title = "GE440 - Gera Base de Pre$$HEX1$$e700$$ENDHEX$$os para Analise"
cb_1 cb_1
end type
global w_ge440_gera_base_price w_ge440_gera_base_price

type variables
string is_Filiais, is_produtos
end variables

forward prototypes
public subroutine wf_base_nota (string as_filiais, date adh_inicio, date adh_termino)
public subroutine wf_base_resumida (string as_filiais, date adh_inicio, date adh_termino)
public subroutine wf_base_subcategoria (string as_filiais, date adh_inicio, date adh_termino)
public subroutine wf_lista_produtos ()
public subroutine wf_base_nota_bkp (string as_filiais, date adh_inicio, date adh_termino)
public subroutine wf_base_nota_produtos (string as_filiais, date adh_inicio, date adh_termino)
public subroutine wf_base_nota_promocao (string as_filiais, date adh_inicio, date adh_termino)
public function boolean wf_abre_arquivo (string as_arquivo, ref boolean ab_grava_cabecalho, ref integer ai_arquivo)
public subroutine wf_base_antunes (string as_filiais, date adh_inicio, date adh_termino)
end prototypes

public subroutine wf_base_nota (string as_filiais, date adh_inicio, date adh_termino);Boolean lb_Grava_Cabecalho, lb_Erro = False

String ls_Arquivo, ls_Registro, ls_Hora, ls_Movimento, TAB

String DESC_FIL, CIDADE, UF, BANDEIRA, lvs_SQL, ls_Arquivo2

Integer li_Arq, li_Ret, li_Retorno

Long ll_Filial, NOTA, SEQUENCIAL, COD_SKU, ll_Nota_Anterior, ll_Conta_Nota, ll_Filial_Ant, ll_Cont_Fil

String FABRICANTE, SUBCATEGORIA, CATEGORIA, SUBGRUPO, GRUPO,  DESCRICAO_SKU		

Long QT_VENDIDA, ll_Total_Fil
Decimal PRECO_BRUTO, PC_DESCONTO, PC_DESCONTO_NOTA, PRECO_LIQ, PC_COMISSAO
String TIPO_VENDA, CONVENIO, DESC_PROMOCAO, VENDA_PBM, COD_PROMO

Decimal PC_DESC_UNIMED, PC_DESC_CONVENIO, PC_ICMS, VALOR_IMPOSTO, VALOR_CUSTO, VALOR_COMISSAO, VALOR_RENT_LIQ, PC_MARGEM_LIQ
String VENDA_FARM_GOV, ECOMMERCE
Decimal PC_DESCONTO_PROMO

Date ldt_Movimento

TAB = "	"

dc_uo_ds_base lds_Filial

lb_Grava_Cabecalho = True

ls_Arquivo =  gvo_Aplicacao.ivs_Path_Arquivos  + "BASE_NOTAS_" + string(adh_inicio, "ddmmyyyy") + "_ATE_"+  String(adh_termino, "ddmmyyyy") + ".EXP"
ls_Arquivo2 =  gvo_Aplicacao.ivs_Path_Arquivos  + "BASE_NOTAS_" + string(adh_inicio, "ddmmyyyy") + "_ATE_"+  String(adh_termino, "ddmmyyyy") + ".TXT"

If FileExists (ls_Arquivo) Then
	
	li_Retorno = MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O arquivo '" + ls_Arquivo + "' j$$HEX1$$e100$$ENDHEX$$ existe.~r~rDeseja substitu$$HEX1$$ed00$$ENDHEX$$-lo?~rSIM -> O arquivo antigo ser$$HEX1$$e100$$ENDHEX$$ exclu$$HEX1$$ed00$$ENDHEX$$do e criado um novo.~rNAO -> As novas informa$$HEX2$$e700f500$$ENDHEX$$es ser$$HEX1$$e300$$ENDHEX$$o inclu$$HEX1$$ed00$$ENDHEX$$das no mesmo arquivo.", Question!, YesNoCancel!, 2)
	
	Choose Case li_Retorno
		Case 1
			If Not FileDelete ( ls_Arquivo ) Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao excluir o arquivo '" + ls_Arquivo + "'.", StopSign!)
				Return
			End If
		Case 2
			lb_Grava_Cabecalho = False
		Case 3
			Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O processo foi abortado.", Exclamation!)
			Return
	End Choose
End If
	
li_Arq = FileOpen(ls_Arquivo, LineMode!, Write!, LockReadWrite!, Append!, EncodingANSI!)

If li_Arq = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao abrir o arquivo " + ls_Arquivo )
	Return
End If

try

	Open(w_Aguarde)
				
			
	If lb_Grava_Cabecalho Then
		ls_Registro = 	"VENDA" + TAB +&
							"HORA" + TAB +&
							"COD_FIL" + TAB +&
							"DESC_FIL" + TAB +&
							"CIDADE" + TAB +&
							"UF" + TAB +&
							"BANDEIRA" + TAB +&
							"NOTA" + TAB +&
							"SUBCATEGORIA" + TAB +&
							"CATEGORIA" + TAB +&
							"SUBGRUPO" + TAB +&
							"GRUPO" + TAB +&
							"COD_SKU" + TAB +&
							"DESCRICAO_SKU" + TAB +&
							"QT_VENDIDA" + TAB +&
							"PRECO_BRUTO" + TAB +&
							"PC_DESCONTO" + TAB +&
							"PC_DESCONTO_NOTA" + TAB +&
							"PRECO_LIQ" + TAB +&
							"PC_COMISSAO" + TAB +&
							"TIPO_VENDA" + TAB +&
							"CONVENIO" + TAB +&
							"VENDA_PBM" + TAB +&
							"VENDA_FARM_GOV" + TAB +&
							"VALOR_IMPOSTO" + TAB +&
							"VALOR_CUSTO" + TAB +&
							"VALOR_COMISSAO" + TAB +&
							"VALOR_RENT_LIQ" 
							
		li_Ret = FileWrite(li_Arq, ls_Registro)
		
		If IsNull(li_Ret) or li_Ret <= 0 Then
			lb_Erro = True
			Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gravar o registro cabe$$HEX1$$e700$$ENDHEX$$alho no arquivo TXT.", StopSign!)
			Return
		End If	
	End If
	
	lds_Filial = Create dc_uo_ds_base
	
	If Not lds_Filial.of_ChangeDataObject("ds_ge440_filial") Then 
		lb_Erro = True
		Return
	End If
	
	If as_filiais = 'C' Then
		If Not IsNull(is_Filiais) Then
			lds_Filial.of_AppendWhere("f.cd_filial in (" + is_Filiais + ")")
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma filial foi selecionada.")
			lb_Erro = True
			Return
		End If
	End If
	
	ll_Total_Fil = lds_Filial.Retrieve()
	
	For ll_Cont_Fil = 1 To ll_Total_Fil
		
		ll_Filial = lds_Filial.Object.cd_filial[ll_Cont_Fil]

		ldt_Movimento = adh_inicio
									
		Do While ldt_Movimento <= adh_termino
			
			w_Aguarde.Title = "Filial [" + String(ll_Filial) + "] - Emiss$$HEX1$$e300$$ENDHEX$$o : " + String(ldt_Movimento, "dd/mm/yyyy")
			
			lvs_SQL = 	"select		substring(CONVERT( CHAR(10), n.dh_movimentacao_caixa, 103 ), 1, 10), "+&
							"						convert(char(12), dh_emissao, 18), "+&
							"						n.cd_filial, "+&
							"						f.nm_fantasia,	 "+&
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
							"						(select de_subcategoria 	from subcategoria su where su.cd_subcategoria = g.cd_subcategoria) , "+&
							"						(select de_categoria 		from categoria ca where ca.cd_categoria = substring(g.cd_subcategoria, 1,6)), "+&
							"						(select de_subgrupo 		from subgrupo sub where sub.cd_subgrupo = substring(g.cd_subcategoria, 1,3)) , "+&
							"						(select de_grupo 			from grupo gr where gr.cd_grupo = substring(g.cd_subcategoria, 1,1)), "+&
							"						i.cd_produto, "+&
							"						g.de_produto  + ' : ' + g.de_apresentacao_venda, "+&
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
							"			where n.dh_movimentacao_caixa = '" + string(ldt_Movimento, 'yyyymmdd') + "' "+&
							"			  and n.dh_cancelamento is null "+&
							"			  and n.nr_nf_anexa is null "+&
							"			  and n.nr_pedido_ecommerce is null "+&
							"			  and i.cd_produto <> 684431 "+&
							"			  and substring(g.cd_subcategoria,1,1) = '1'  " +&
							"			  and n.cd_filial = " + string(ll_Filial)
			
			If Not IsNull(is_Produtos) and trim(is_Produtos) <> "" Then
				lvs_SQL += " and i.cd_produto in (" + is_produtos + ")"
			End If
														
			lvs_SQL += "			order by n.cd_filial, n.nr_nf, i.nr_sequencial "
			
			PREPARE SQLSA FROM :lvs_SQL ;
			DESCRIBE SQLSA INTO SQLDA ;
			DECLARE lcu_Notas DYNAMIC CURSOR FOR SQLSA ;
			OPEN DYNAMIC lcu_Notas USING DESCRIPTOR SQLDA ;
			FETCH lcu_Notas INTO :ls_Movimento, :ls_Hora, :ll_Filial,  :DESC_FIL, :CIDADE, :UF, :BANDEIRA, :NOTA, :SEQUENCIAL, :FABRICANTE, :SUBCATEGORIA, :CATEGORIA, :SUBGRUPO, :GRUPO,  :COD_SKU,
										  :DESCRICAO_SKU, :QT_VENDIDA, :PRECO_BRUTO, :PC_DESCONTO, :PC_DESCONTO_NOTA, :PRECO_LIQ, :PC_COMISSAO, :TIPO_VENDA, :CONVENIO, :COD_PROMO, :DESC_PROMOCAO, :PC_DESCONTO_PROMO, :VENDA_PBM,
										  :VENDA_FARM_GOV, :PC_DESC_UNIMED, :PC_DESC_CONVENIO,  :ECOMMERCE,  :PC_ICMS, :VALOR_IMPOSTO, :VALOR_CUSTO, :VALOR_COMISSAO, :VALOR_RENT_LIQ;
		
			If SQLCA.sqlcode = -1 Then
				lb_Erro = True
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao recuperar as informa$$HEX2$$e700f500$$ENDHEX$$es do cursor.", StopSign!)
				Return
			End If
			
			// Repetir Enquanto Houver Linhas
			DO WHILE SQLCA.sqlcode = 0
								
					ls_Registro = 	ls_Movimento + TAB +&
										ls_Hora + TAB +&
										String(ll_Filial) + TAB +&
										DESC_FIL + TAB +&
										CIDADE + TAB +&
										UF + TAB +&
										BANDEIRA + TAB +&
										string(NOTA) + TAB +&
										SUBCATEGORIA + TAB +&
										CATEGORIA + TAB +&
										SUBGRUPO + TAB +&
										GRUPO + TAB +&
										string(COD_SKU) + TAB +&
										DESCRICAO_SKU + TAB +&
										String(QT_VENDIDA) + TAB +&
										String(PRECO_BRUTO) + TAB +&
										String(PC_DESCONTO) + TAB +&
										String(PC_DESCONTO_NOTA) + TAB +&
										String(PRECO_LIQ) + TAB +&
										String(PC_COMISSAO) + TAB +&
										TIPO_VENDA + TAB +&
										CONVENIO + TAB +&
										VENDA_PBM + TAB +&
										VENDA_FARM_GOV + TAB +&
										String(VALOR_IMPOSTO) + TAB +&
										String(VALOR_CUSTO) + TAB +&
										String(VALOR_COMISSAO) + TAB +&
										String(VALOR_RENT_LIQ)
												
					// Cabecalho
					li_Ret = FileWrite(li_Arq, ls_Registro)
					
					//COD_PROMO + TAB +& 
					//DESC_PROMOCAO + TAB +&
					//String(PC_DESCONTO_PROMO) + TAB +&
	
					If IsNull(li_Ret) or li_Ret <= 0 Then
						lb_Erro = True
						Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gravar o registro cabe$$HEX1$$e700$$ENDHEX$$alho no arquivo TXT.", StopSign!)
						Return
					End If	
																	
					//Busca pr$$HEX1$$f300$$ENDHEX$$ximo valor
					FETCH lcu_Notas INTO 	:ls_Movimento, :ls_Hora, :ll_Filial,  :DESC_FIL, :CIDADE, :UF, :BANDEIRA, :NOTA, :SEQUENCIAL, :FABRICANTE, :SUBCATEGORIA, :CATEGORIA, :SUBGRUPO, :GRUPO,  :COD_SKU, 
													:DESCRICAO_SKU, :QT_VENDIDA, :PRECO_BRUTO, :PC_DESCONTO, :PC_DESCONTO_NOTA, :PRECO_LIQ, :PC_COMISSAO, :TIPO_VENDA, :CONVENIO, :COD_PROMO, :DESC_PROMOCAO,:PC_DESCONTO_PROMO, :VENDA_PBM,
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
	
finally
	Destroy(lds_Filial)
	FileClose (li_Arq)
	
	If lb_Erro Then
		FileDelete(ls_arquivo) 
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'O arquivo TXT foi exclu$$HEX1$$ed00$$ENDHEX$$do por conter erros.')
	Else
		If   FileLength(ls_arquivo) = 0 Then
			FileDelete(ls_arquivo) 
		Else	
			If FileExists(ls_Arquivo2) Then
				FileDelete(ls_Arquivo2)
			End If
			FileMove(ls_arquivo,ls_Arquivo2)
		End If
	End If
	
	Close(w_Aguarde)
end try

MessageBox("Aten$$HEX1$$e700$$ENDHEX$$ao", "O arquivo foi gerado com sucesso.~r~Arquivo: " + ls_Arquivo)




end subroutine

public subroutine wf_base_resumida (string as_filiais, date adh_inicio, date adh_termino);Boolean lb_Grava

String ls_Arquivo, ls_Registro, ls_Hora, ls_Movimento, TAB

String DESC_FIL, CIDADE, UF, BANDEIRA

Integer li_Arq, li_Ret

Long ll_Filial, NOTA, SEQUENCIAL, COD_SKU, ll_Nota_Anterior, ll_Conta_Nota, ll_Filial_Ant, ll_Cont_Fil, ll_Nota_Gravada

String FABRICANTE, SUBCATEGORIA, CATEGORIA, SUBGRUPO, GRUPO,  DESCRICAO_SKU, VENDA_PBM

Long QT_VENDIDA, ll_Total_Fil
Decimal PRECO_BRUTO, PC_DESCONTO, PC_DESCONTO_NOTA, PRECO_LIQ, PC_COMISSAO
String TIPO_VENDA, CONVENIO, DESC_PROMOCAO

Decimal PC_DESC_UNIMED, PC_DESC_CONVENIO, PC_ICMS, VALOR_IMPOSTO, VALOR_CUSTO, VALOR_COMISSAO, VALOR_RENT_LIQ, PC_MARGEM_LIQ
String VENDA_FARM_GOV, ECOMMERCE

TAB = "	"

dc_uo_ds_base lds_Filial

try

	Open(w_Aguarde)
	
	ls_Arquivo =  gvo_Aplicacao.ivs_Path_Arquivos  + "BASE_CONSOLIDADA_" + string(Day(adh_inicio), '00') + "_" + string(Month(adh_inicio), '00') + "_" + string(Year(adh_inicio), '0000') + "_ATE_"+ string(Day(adh_termino), '00') + "_" + string(Month(adh_termino), '00') + "_" + string(Year(adh_termino), '0000') + ".TXT"
	
	If FileExists (ls_Arquivo) Then
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O arquivo '" + ls_Arquivo + "' j$$HEX1$$e100$$ENDHEX$$ existe.~r~rDeseja substitu$$HEX1$$ed00$$ENDHEX$$-lo?", Question!, YesNo!, 2) = 1 Then
			If Not FileDelete ( ls_Arquivo ) Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao excluir o arquivo '" + ls_Arquivo + "'.", StopSign!)
				Return
			End If
		Else
			Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O processo foi abortado.", Exclamation!)
			Return
		End If
	End If
		
	li_Arq = FileOpen(ls_Arquivo, LineMode!, Write!, LockReadWrite!, Replace!, EncodingANSI!)
	
	If li_Arq = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao abrir o arquivo " + ls_Arquivo )
		Return
	End If
				
	ls_Registro = 	"VENDA" + TAB +&
						"COD_FIL" + TAB +&
						"DESC_FIL" + TAB +&
						"CIDADE" + TAB +&
						"UF" + TAB +&
						"BANDEIRA" + TAB +&
						"FABRICANTE" + TAB +&
						"SUBCATEGORIA" + TAB +&
						"CATEGORIA" + TAB +&
						"SUBGRUPO" + TAB +&
						"GRUPO" + TAB +&
						"COD_SKU" + TAB +&
						"DESCRICAO_SKU" + TAB +&
						"VENDA_PBM" + TAB +&
						"VENDA_FARM_GOV" + TAB +&
						"CONVENIO" + TAB +&
						"QT_VENDIDA" + TAB +&
						"PRECO_BRUTO" + TAB +&
						"PRECO_LIQ" + TAB +&
						"VALOR_IMPOSTO" + TAB +&
						"VALOR_CUSTO" + TAB +&
						"VALOR_COMISSAO" + TAB +&
						"VALOR_RENT_LIQ" 
												
	li_Ret = FileWrite(li_Arq, ls_Registro)
	
	If IsNull(li_Ret) or li_Ret <= 0 Then
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gravar o registro cabe$$HEX1$$e700$$ENDHEX$$alho no arquivo TXT.", StopSign!)
		Return
	End If	
	
	lds_Filial = Create dc_uo_ds_base
	
	If Not lds_Filial.of_ChangeDataObject("ds_ge440_filial") Then Return
	
	If as_filiais = 'C' Then
		If Not IsNull(is_Filiais) Then
			lds_Filial.of_AppendWhere("f.cd_filial in (" + is_Filiais + ")")
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma filial foi selecionada.")
			Return
		End If
	End If
	
	ll_Total_Fil = lds_Filial.Retrieve()
	
	For ll_Cont_Fil = 1 To ll_Total_Fil
		
		ll_Filial = lds_Filial.Object.cd_filial[ll_Cont_Fil]
								
		w_Aguarde.Title = "Filial [" + String(ll_Filial) + "] - Emiss$$HEX1$$e300$$ENDHEX$$o : " + String(adh_inicio, "dd/mm/yyyy")
		
		//try 
		
			/*Utiliza$$HEX2$$e700e300$$ENDHEX$$o do cursor com SQL fixo*/
			DECLARE lcu_Notas CURSOR FOR
			
			select  tudo.VENDA,
					  tudo.COD_FIL,
					  tudo.DESC_FIL,
					  tudo.CIDADE,
					  tudo.UF,
					  tudo.BANDEIRA,
					  tudo.FABRICANTE,
					  tudo.CD_SUBCATEGORIA,
					  tudo.CATEGORIA,
					  tudo.SUBGRUPO,
					  tudo.GRUPO,
					  tudo.COD_SKU,
					  tudo.DESCRICAO_SKU,
					  tudo.VENDA_PBM,
					  tudo.VENDA_FARM_GOV,
					  tudo.ECOMMERCE,
					  tudo.CONVENIO,
					  sum(tudo.QT_VENDIDA),
					  sum(tudo.PRECO_BRUTO),
					  sum(tudo.PRECO_LIQ),
					  sum(tudo.VALOR_IMPOSTO),
					  sum(tudo.VALOR_CUSTO),
					  sum(tudo.VALOR_COMISSAO),
					  sum(tudo.VALOR_RENT_LIQ),
					  cast((round(sum(tudo.VALOR_RENT_LIQ) / sum(tudo.PRECO_LIQ), 6) * 100 ) as decimal(11,2)) as PC_MARGEM_LIQ
					  
			 from
			(select		substring(CONVERT( CHAR(10), n.dh_movimentacao_caixa, 111 ), 1, 7) VENDA,
									n.cd_filial COD_FIL,
									f.nm_fantasia DESC_FIL,	
									ci.nm_cidade CIDADE,
									ci.cd_unidade_federacao UF, 
									( case coalesce(f.id_rede_filial, 'XX')
											when    'AL' then 'ALOMED'
										when    'CP' then 'CATARINENSE PLUS'
										when    'DC' then 'DROGARIA CATARINENSE'
										when    'DP' then 'DROG. PRECO POPULAR'									
										when    'FA' then 'FARMAGORA'
										when    'MP' then 'MANIPULACAO'
										when    'PP' then 'PRECO POPULAR'
										when	'PF' then 'PROFORMULA'
										else 'NAO IDENTIFICADO'
									end ) BANDEIRA,
									fo.nm_razao_social FABRICANTE,
									  subc.de_subcategoria  CD_SUBCATEGORIA ,
									cat.de_categoria CATEGORIA,
									sub.de_subgrupo SUBGRUPO,
									gr.de_grupo GRUPO, 
									  i.cd_produto COD_SKU,
									  g.de_produto  + ' : ' + g.de_apresentacao_venda DESCRICAO_SKU,
									  coalesce(v.id_pbm, 'N') VENDA_PBM,
									  (Case When (	select count(*) 
											from venda_pbm vp 
											WHERE vp.cd_filial = n.cd_filial 
												and vp.nr_nf = n.nr_nf 
												and vp.de_especie = n.de_especie 
												and vp.de_serie = n.de_serie
												AND vp.cd_convenio = 52575 
												and vp.nr_comprovante_venda = 'AVFARPOP') > 0 
											Then 'S' 	else 'N' 
									  END	) VENDA_FARM_GOV,
											  (Case when coalesce(n.nr_pedido_ecommerce, 0) > 0 Then 'S' else 'N' END) ECOMMERCE,
									  (CASE WHEN n.id_tipo_venda = 'CV' THEN 'S' ELSE 'N' END)	  CONVENIO,
									  i.qt_vendida 	QT_VENDIDA,
									  round(i.qt_vendida * i.vl_preco_unitario, 2) PRECO_BRUTO,
									  (CASE WHEN cast(round(i.qt_vendida * round(i.vl_preco_praticado * ((100 - n.pc_desconto) / 100), 2), 2) as decimal(11,2)) < 0.01 THEN 0.01 ELSE cast(round(i.qt_vendida * round(i.vl_preco_praticado * ((100 - n.pc_desconto) / 100), 2), 2) as decimal(11,2)) END) PRECO_LIQ,
									cast(round(i.qt_vendida * round(round(i.vl_preco_praticado * ((100 - n.pc_desconto) / 100), 2) * (i.pc_icms / 100), 2), 2) as decimal(11,2)) VALOR_IMPOSTO,
									round(i.qt_vendida * m.vl_custo_unitario, 2) VALOR_CUSTO,
									cast(round(i.qt_vendida * round(round(i.vl_preco_praticado * ((100 - n.pc_desconto) / 100), 2) * (i.pc_comissao_extra / 100), 2), 2) as decimal(11,2)) VALOR_COMISSAO,
						
									 cast(round(i.qt_vendida * (round(i.vl_preco_praticado * ((100 - n.pc_desconto) / 100), 2) 
									 - m.vl_custo_unitario
									 - round(round(i.vl_preco_praticado * ((100 - n.pc_desconto) / 100), 2) * (i.pc_comissao_extra / 100), 2)
									 - round(round(i.vl_preco_praticado * ((100 - n.pc_desconto) / 100), 2) * (i.pc_icms / 100), 2)), 2)  as decimal(11,2)) VALOR_RENT_LIQ
							from nf_venda n (index idx_data_filial)
							inner join filial f (index pk_filial)
								on f.cd_filial = n.cd_filial
							inner join cidade ci
								on ci.cd_cidade = f.cd_cidade
							inner join item_nf_venda i (index pk_item_nf_venda)
								on i.cd_filial = n.cd_filial
								and i.nr_nf = n.nr_nf
								and i.de_especie = n.de_especie
								and i.de_serie		= n.de_serie
							inner join movimento_estoque m (index idx_nota)
								on m.cd_filial_movimento = i.cd_filial
								and m.nr_nf			= i.nr_nf
								and m.de_especie	= i.de_especie
								and m.de_serie		= i.de_serie
								and m.cd_produto	= i.cd_produto
								and coalesce(m.nr_sequencial, 1) = coalesce(i.nr_sequencial, 1)
							inner join produto_geral g (index pk_produto_geral)
								on g.cd_produto = i.cd_produto
							inner join subcategoria subc
								on subc.cd_subcategoria = g.cd_subcategoria
							inner join categoria cat
								on cat.cd_categoria = substring(g.cd_subcategoria, 1,6)
							inner join subgrupo sub
								on sub.cd_subgrupo = substring(g.cd_subcategoria, 1,3)
							inner join grupo gr
								on gr.cd_grupo = substring(g.cd_subcategoria, 1,1)
							inner join fornecedor fo (index pk_fornecedor)
								on fo.cd_fornecedor = g.cd_fornecedor_usual
							left outer join venda_pbm_produto v
								on v.cd_filial = n.cd_filial
								and v.nr_nf		= n.nr_nf
								and v.de_especie	 = n.de_especie
								and v.de_serie		= n.de_serie
								and v.cd_produto	= i.cd_produto
								and v.nr_sequencial = i.nr_sequencial
							where n.dh_movimentacao_caixa >= :adh_inicio and n.dh_movimentacao_caixa <= :adh_termino
							  and n.dh_cancelamento is null
							  and n.nr_nf_anexa is null
							  and n.nr_pedido_ecommerce is null
							  and i.cd_produto <> 684431
							  and n.cd_filial =:ll_Filial
							  //and i.cd_produto in (select cd_produto from a_sergio_price_prd)
			) as tudo
			group by tudo.VENDA,
					  tudo.COD_FIL,
					  tudo.DESC_FIL,
					  tudo.CIDADE,
					  tudo.UF,
					  tudo.BANDEIRA,
					  tudo.FABRICANTE,
					  tudo.CD_SUBCATEGORIA,
					  tudo.CATEGORIA,
					  tudo.SUBGRUPO,
					  tudo.GRUPO,
					  tudo.COD_SKU,
					  tudo.DESCRICAO_SKU,
					  tudo.VENDA_PBM,
					  tudo.VENDA_FARM_GOV,
					  tudo.ECOMMERCE,
					  tudo.CONVENIO;
			
			// Abrindo o cursor
			OPEN lcu_Notas;
			
			// Buscar a primeira linha do resultado
			FETCH lcu_Notas INTO 	:ls_Movimento, :ll_Filial,  :DESC_FIL, :CIDADE, :UF, :BANDEIRA, :FABRICANTE, :SUBCATEGORIA, :CATEGORIA, :SUBGRUPO, :GRUPO,  :COD_SKU, 
											:DESCRICAO_SKU, :VENDA_PBM, :VENDA_FARM_GOV, :ECOMMERCE, :CONVENIO,  :QT_VENDIDA, :PRECO_BRUTO, :PRECO_LIQ, :VALOR_IMPOSTO, :VALOR_CUSTO, :VALOR_COMISSAO, :VALOR_RENT_LIQ, :PC_MARGEM_LIQ;
			
			If SQLCA.sqlcode = -1 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao recuperar as informa$$HEX2$$e700f500$$ENDHEX$$es do cursor.", StopSign!)
				Return
			End If
			
			//catch ( exception e)
			// MessageBox (	"Erro", "Ocorreu erro ao localizar os itens da nota ~r~r"+ "Erro: "+ e.GetMessage( ))
		//end try
			
			// Repetir Enquanto Houver Linhas
			DO WHILE SQLCA.sqlcode = 0
								
				ls_Registro = 	ls_Movimento + TAB +&
									String(ll_Filial) + TAB +&
									DESC_FIL + TAB +&
									CIDADE + TAB +&
									UF + TAB +&
									BANDEIRA + TAB +&
									FABRICANTE + TAB +&
									SUBCATEGORIA + TAB +&
									CATEGORIA + TAB +&
									SUBGRUPO + TAB +&
									GRUPO + TAB +&
									string(COD_SKU) + TAB +&
									DESCRICAO_SKU + TAB +&
									VENDA_PBM + TAB +&
									VENDA_FARM_GOV + TAB +&
									CONVENIO + TAB +&
									String(QT_VENDIDA) + TAB +&
									String(PRECO_BRUTO) + TAB +&
									String(PRECO_LIQ) + TAB +&
									String(VALOR_IMPOSTO) + TAB +&
									String(VALOR_CUSTO) + TAB +&
									String(VALOR_COMISSAO) + TAB +&
									String(VALOR_RENT_LIQ)
				// Cabecalho
				li_Ret = FileWrite(li_Arq, ls_Registro)
		
				If IsNull(li_Ret) or li_Ret <= 0 Then
					Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gravar o registro cabe$$HEX1$$e700$$ENDHEX$$alho no arquivo TXT.", StopSign!)
					Return
				End If	
	
				FETCH lcu_Notas INTO 	:ls_Movimento, :ll_Filial,  :DESC_FIL, :CIDADE, :UF, :BANDEIRA, :FABRICANTE, :SUBCATEGORIA, :CATEGORIA, :SUBGRUPO, :GRUPO,  :COD_SKU, 
												:DESCRICAO_SKU, :VENDA_PBM, :VENDA_FARM_GOV, :ECOMMERCE, :CONVENIO, :QT_VENDIDA, :PRECO_BRUTO, :PRECO_LIQ, :VALOR_IMPOSTO, :VALOR_CUSTO, :VALOR_COMISSAO, :VALOR_RENT_LIQ, :PC_MARGEM_LIQ;
	
								
			LOOP
			
			CLOSE lcu_Notas;			
				
	Next
	
	FileClose (li_Arq)
finally
	Destroy(lds_Filial)
	FileClose (li_Arq)
	Close(w_Aguarde)
end try
end subroutine

public subroutine wf_base_subcategoria (string as_filiais, date adh_inicio, date adh_termino);String ls_Arquivo, ls_Registro, ls_Hora, ls_Movimento, TAB

String DESC_FIL, CIDADE, UF, BANDEIRA

Integer li_Arq, li_Ret

Long ll_Cont_Fil, ll_Filial, NOTA, ll_Total_Fil

String SUBCATEGORIA

TAB = "	"

dc_uo_ds_base lds_Filial

try

	Open(w_Aguarde)
					
	//ls_Arquivo =  gvo_Aplicacao.ivs_Path_Arquivos  + "BASE_SUBCATEGORIA_" + string(adh_inicio, "ddmmyyyy") + "_ATE_"+  String(adh_termino, "ddmmyyyy") + ".TXT"
	
	ls_Arquivo =  gvo_Aplicacao.ivs_Path_Arquivos  + "BASE_SUBCATEGORIA_" + string(Day(adh_inicio), '00') + "_" + string(Month(adh_inicio), '00') + "_" + string(Year(adh_inicio), '0000') + "_ATE_"+ string(Day(adh_termino), '00') + "_" + string(Month(adh_termino), '00') + "_" + string(Year(adh_termino), '0000') + ".TXT"
	
	If FileExists (ls_Arquivo) Then
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O arquivo '" + ls_Arquivo + "' j$$HEX1$$e100$$ENDHEX$$ existe.~r~rDeseja substitu$$HEX1$$ed00$$ENDHEX$$-lo?", Question!, YesNo!, 2) = 1 Then
			If Not FileDelete ( ls_Arquivo ) Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao excluir o arquivo '" + ls_Arquivo + "'.", StopSign!)
				Return
			End If
		Else
			Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O processo foi abortado.", Exclamation!)
			Return
		End If
	End If
		
	li_Arq = FileOpen(ls_Arquivo, LineMode!, Write!, LockReadWrite!, Replace!, EncodingANSI!)
	
	If li_Arq = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao abrir o arquivo " + ls_Arquivo )
		Return
	End If
				
	ls_Registro = 	"VENDA" + TAB +&
						"HORA" + TAB +&
						"COD_FIL" + TAB +&
						"DESC_FIL" + TAB +&
						"CIDADE" + TAB +&
						"UF" + TAB +&
						"BANDEIRA" + TAB +&
						"NOTA" + TAB +&
						"SUBCATEGORIA"
						
	li_Ret = FileWrite(li_Arq, ls_Registro)
	
	If IsNull(li_Ret) or li_Ret <= 0 Then
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gravar o registro cabe$$HEX1$$e700$$ENDHEX$$alho no arquivo TXT.", StopSign!)
		Return
	End If	
	
	lds_Filial = Create dc_uo_ds_base
	
	If Not lds_Filial.of_ChangeDataObject("ds_ge440_filial") Then Return
	
	If as_filiais = 'C' Then
		If Not IsNull(is_Filiais) Then
			lds_Filial.of_AppendWhere("f.cd_filial in (" + is_Filiais + ")")
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma filial foi selecionada.")
			Return
		End If
	End If
	
	ll_Total_Fil = lds_Filial.Retrieve()
	
	For ll_Cont_Fil = 1 To ll_Total_Fil
		
		ll_Filial = lds_Filial.Object.cd_filial[ll_Cont_Fil]
					
		w_Aguarde.Title = "Filial [" + String(ll_Filial) + "] - Emiss$$HEX1$$e300$$ENDHEX$$o : " + String(adh_inicio, "dd/mm/yyyy")
			
		/*Utiliza$$HEX2$$e700e300$$ENDHEX$$o do cursor com SQL fixo*/
		DECLARE lcu_Notas CURSOR FOR
		select		substring(CONVERT( CHAR(10), n.dh_movimentacao_caixa, 103 ), 1, 10),
					convert(char(12), dh_emissao, 18),
					n.cd_filial COD_FIL,
					f.nm_fantasia DESC_FIL,	
					ci.nm_cidade CIDADE,
					ci.cd_unidade_federacao UF, 
					( case coalesce(f.id_rede_filial, 'XX')
							when    'AL' then 'ALOMED'
						when    'CP' then 'CATARINENSE PLUS'
						when    'DC' then 'DROGARIA CATARINENSE'
						when    'DP' then 'DROG. PRECO POPULAR'									
						when    'FA' then 'FARMAGORA'
						when    'MP' then 'MANIPULACAO'
						when    'PP' then 'PRECO POPULAR'
						when	'PF' then 'PROFORMULA'
						else 'NAO IDENTIFICADO'
					end ) BANDEIRA,
					n.nr_nf NOTA,
					(select de_subcategoria 	from subcategoria su where su.cd_subcategoria = g.cd_subcategoria) SUBCATEGORIA
		from nf_venda n (index idx_data_filial)
		inner join filial f (index pk_filial)
			on f.cd_filial = n.cd_filial
		inner join cidade ci
			on ci.cd_cidade = f.cd_cidade
		inner join item_nf_venda i (index pk_item_nf_venda)
			on i.cd_filial = n.cd_filial
			and i.nr_nf = n.nr_nf
			and i.de_especie = n.de_especie
			and i.de_serie		= n.de_serie
		inner join produto_geral g (index pk_produto_geral)
			on g.cd_produto = i.cd_produto
		where n.dh_movimentacao_caixa between :adh_inicio and :adh_termino
		  and n.dh_cancelamento is null
		  and n.nr_nf_anexa is null
		  and n.nr_pedido_ecommerce is null
		  and i.cd_produto <> 684431
		  and n.cd_filial = :ll_Filial
		  and exists (select * from a_sergio_subcategoria x where x.cd_subcategoria = g.cd_subcategoria)
		order by n.cd_filial, n.nr_nf;
		
		// Abrindo o cursor
		OPEN lcu_Notas;
		
		// Buscar a primeira linha do resultado
		FETCH lcu_Notas INTO 	:ls_Movimento, :ls_Hora, :ll_Filial,  :DESC_FIL, :CIDADE, :UF, :BANDEIRA, :NOTA, :SUBCATEGORIA;
		
		If SQLCA.sqlcode = -1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao recuperar as informa$$HEX2$$e700f500$$ENDHEX$$es do cursor.", StopSign!)
			Return
		End If
		
		// Repetir Enquanto Houver Linhas
		DO WHILE SQLCA.sqlcode = 0
							
				ls_Registro = 	ls_Movimento + TAB +&
									ls_Hora + TAB +&
									String(ll_Filial) + TAB +&
									DESC_FIL + TAB +&
									CIDADE + TAB +&
									UF + TAB +&
									BANDEIRA + TAB +&
									string(NOTA) + TAB +&
									SUBCATEGORIA
											
				// Cabecalho
				li_Ret = FileWrite(li_Arq, ls_Registro)
	
				If IsNull(li_Ret) or li_Ret <= 0 Then
					Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gravar o registro cabe$$HEX1$$e700$$ENDHEX$$alho no arquivo TXT.", StopSign!)
					Return
				End If	
																
				//Busca pr$$HEX1$$f300$$ENDHEX$$ximo valor
				FETCH lcu_Notas INTO 	:ls_Movimento, :ls_Hora, :ll_Filial,  :DESC_FIL, :CIDADE, :UF, :BANDEIRA, :NOTA, :SUBCATEGORIA;
		LOOP
		
		CLOSE lcu_Notas;			
			
	Next
	
finally
	Destroy(lds_Filial)
	FileClose (li_Arq)
	Close(w_Aguarde)
end try

MessageBox("Aten$$HEX1$$e700$$ENDHEX$$ao", "O arquivo foi gerado com sucesso.~r~Arquivo: " + ls_Arquivo)




end subroutine

public subroutine wf_lista_produtos ();Integer li_Retorno

String ls_Diretorio, ls_Arquivo, ls_Nulo

Any la_Dado

Long ll_Linha
Long ll_Linhas, lvl_Contador

SetNull(ls_Nulo)

li_Retorno = GetFileSaveName("Selecione o caminho do arquivo", &
										ls_Diretorio, 	&
										ls_Arquivo, 	&
										"XLSX", "Excel 2007 (*.XLSX),*.XLSX, Excel (*.XLS), *.XLS")

If li_Retorno = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Ocorreu um erro durante a chamada da janela de sele$$HEX2$$e700e300$$ENDHEX$$o do arquivo.", StopSign!)
	Return 
Else
	If li_Retorno = 0 Then 
		dw_1.Object.id_produtos[1] = 'T'
		is_produtos = ls_Nulo
		Return
	End If
End If

Try
	dc_uo_excel lo_Excel
	lo_Excel = Create dc_uo_excel
	
	Open(w_Aguarde)
	w_Aguarde.Title = "Lendo a planilha..."
	
	// Refer$$HEX1$$ea00$$ENDHEX$$ncia o Arquivo 
	If ( lo_Excel.uo_Referencia_Objeto_Excel(ls_Diretorio) ) Then
		// Coluna de Refer$$HEX1$$ea00$$ENDHEX$$ncia
		ll_Linhas = lo_Excel.uo_Verifica_Tamanho_Arquivo("A") 
		
		If ll_Linhas > 0 Then
			w_Aguarde.uo_Progress.of_SetMax(ll_Linhas)
					
			For ll_Linha = 1 To ll_Linhas
				la_Dado = lo_Excel.uo_Lendo_Dados(ll_Linha, "A")
				
				If Not IsNumber(String(la_Dado)) Or IsNull(la_Dado) Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produto inv$$HEX1$$e100$$ENDHEX$$lido na linha: " + String(ll_Linha), Exclamation!)
					Continue
				End If
				
				lvl_Contador ++
				
				If lvl_Contador = 1 Then
					is_produtos =  String(la_Dado)
				Else
					is_produtos =  is_produtos  + ", " + String(la_Dado)
				End If
				
			Next
			
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A planilha est$$HEX1$$e100$$ENDHEX$$ em branco.")
			Return
		End If
	End If
	
Finally
	Close(w_Aguarde)
	If IsValid(lo_Excel) Then Destroy(lo_Excel)
End Try



end subroutine

public subroutine wf_base_nota_bkp (string as_filiais, date adh_inicio, date adh_termino);String ls_Arquivo, ls_Registro, ls_Hora, ls_Movimento, TAB

String DESC_FIL, CIDADE, UF, BANDEIRA

Integer li_Arq, li_Ret

Long ll_Filial, NOTA, SEQUENCIAL, COD_SKU, ll_Nota_Anterior, ll_Conta_Nota, ll_Filial_Ant, ll_Cont_Fil

String FABRICANTE, SUBCATEGORIA, CATEGORIA, SUBGRUPO, GRUPO,  DESCRICAO_SKU		

Long QT_VENDIDA, ll_Total_Fil
Decimal PRECO_BRUTO, PC_DESCONTO, PC_DESCONTO_NOTA, PRECO_LIQ, PC_COMISSAO
String TIPO_VENDA, CONVENIO, DESC_PROMOCAO, VENDA_PBM, COD_PROMO

Decimal PC_DESC_UNIMED, PC_DESC_CONVENIO, PC_ICMS, VALOR_IMPOSTO, VALOR_CUSTO, VALOR_COMISSAO, VALOR_RENT_LIQ, PC_MARGEM_LIQ
String VENDA_FARM_GOV, ECOMMERCE
Decimal PC_DESCONTO_PROMO

Date ldt_Movimento

TAB = "	"

dc_uo_ds_base lds_Filial

try

	Open(w_Aguarde)
					
	ls_Arquivo =  gvo_Aplicacao.ivs_Path_Arquivos  + "BASE_NOTAS_" + string(adh_inicio, "ddmmyyyy") + "_ATE_"+  String(adh_termino, "ddmmyyyy") + ".TXT"
	
	If FileExists (ls_Arquivo) Then
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O arquivo '" + ls_Arquivo + "' j$$HEX1$$e100$$ENDHEX$$ existe.~r~rDeseja substitu$$HEX1$$ed00$$ENDHEX$$-lo?", Question!, YesNo!, 2) = 1 Then
			If Not FileDelete ( ls_Arquivo ) Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao excluir o arquivo '" + ls_Arquivo + "'.", StopSign!)
				Return
			End If
		Else
			Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O processo foi abortado.", Exclamation!)
			Return
		End If
	End If
		
	li_Arq = FileOpen(ls_Arquivo, LineMode!, Write!, LockReadWrite!, Replace!, EncodingANSI!)
	
	If li_Arq = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao abrir o arquivo " + ls_Arquivo )
		Return
	End If
				
	ls_Registro = 	"VENDA" + TAB +&
						"HORA" + TAB +&
						"COD_FIL" + TAB +&
						"DESC_FIL" + TAB +&
						"CIDADE" + TAB +&
						"UF" + TAB +&
						"BANDEIRA" + TAB +&
						"NOTA" + TAB +&
						"SUBCATEGORIA" + TAB +&
						"CATEGORIA" + TAB +&
						"SUBGRUPO" + TAB +&
						"GRUPO" + TAB +&
						"COD_SKU" + TAB +&
						"DESCRICAO_SKU" + TAB +&
						"QT_VENDIDA" + TAB +&
						"PRECO_BRUTO" + TAB +&
						"PC_DESCONTO" + TAB +&
						"PC_DESCONTO_NOTA" + TAB +&
						"PRECO_LIQ" + TAB +&
						"PC_COMISSAO" + TAB +&
						"TIPO_VENDA" + TAB +&
						"CONVENIO" + TAB +&
						"VENDA_PBM" + TAB +&
						"VENDA_FARM_GOV" + TAB +&
						"VALOR_IMPOSTO" + TAB +&
						"VALOR_CUSTO" + TAB +&
						"VALOR_COMISSAO" + TAB +&
						"VALOR_RENT_LIQ" 
						
	li_Ret = FileWrite(li_Arq, ls_Registro)
	
	If IsNull(li_Ret) or li_Ret <= 0 Then
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gravar o registro cabe$$HEX1$$e700$$ENDHEX$$alho no arquivo TXT.", StopSign!)
		Return
	End If	
	
	lds_Filial = Create dc_uo_ds_base
	
	If Not lds_Filial.of_ChangeDataObject("ds_ge440_filial") Then Return
	
	If as_filiais = 'C' Then
		If Not IsNull(is_Filiais) Then
			lds_Filial.of_AppendWhere("f.cd_filial in (" + is_Filiais + ")")
		End If
	End If
	
	ll_Total_Fil = lds_Filial.Retrieve()
	
	For ll_Cont_Fil = 1 To ll_Total_Fil
		
		ll_Filial = lds_Filial.Object.cd_filial[ll_Cont_Fil]
		
//		If ll_Filial <> 13 Then
//			Continue
//		End If

		ldt_Movimento = adh_inicio
									
		Do While ldt_Movimento <= adh_termino
			
			w_Aguarde.Title = "Filial [" + String(ll_Filial) + "] - Emiss$$HEX1$$e300$$ENDHEX$$o : " + String(ldt_Movimento, "dd/mm/yyyy")
				
			/*Utiliza$$HEX2$$e700e300$$ENDHEX$$o do cursor com SQL fixo*/
			DECLARE lcu_Notas CURSOR FOR
			select		substring(CONVERT( CHAR(10), n.dh_movimentacao_caixa, 103 ), 1, 10),
						convert(char(12), dh_emissao, 18),
						n.cd_filial COD_FIL,
						f.nm_fantasia DESC_FIL,	
						ci.nm_cidade CIDADE,
						ci.cd_unidade_federacao UF, 
						( case coalesce(f.id_rede_filial, 'XX')
								when    'AL' then 'ALOMED'
							when    'CP' then 'CATARINENSE PLUS'
							when    'DC' then 'DROGARIA CATARINENSE'
							when    'DP' then 'DROG. PRECO POPULAR'									
							when    'FA' then 'FARMAGORA'
							when    'MP' then 'MANIPULACAO'
							when    'PP' then 'PRECO POPULAR'
							when	'PF' then 'PROFORMULA'
							else 'NAO IDENTIFICADO'
						end ) BANDEIRA,
						n.nr_nf NOTA,
						i.nr_sequencial SEQUENCIAL,
						fo.nm_razao_social FABRICANTE,
						(select de_subcategoria 	from subcategoria su where su.cd_subcategoria = g.cd_subcategoria) SUBCATEGORIA ,
						(select de_categoria 		from categoria ca where ca.cd_categoria = substring(g.cd_subcategoria, 1,6)) CATEGORIA ,
						(select de_subgrupo 		from subgrupo sub where sub.cd_subgrupo = substring(g.cd_subcategoria, 1,3)) SUBGRUPO ,
						(select de_grupo 			from grupo gr where gr.cd_grupo = substring(g.cd_subcategoria, 1,1)) GRUPO ,
						i.cd_produto COD_SKU,
						g.de_produto  + ' : ' + g.de_apresentacao_venda DESCRICAO_SKU,
						i.qt_vendida 	,
						i.vl_preco_unitario ,
						i.pc_desconto_tabela ,
						n.pc_desconto ,
						round(i.qt_vendida * cast(round(round(i.vl_preco_unitario * ((100 - i.pc_desconto_tabela) / 100), 2) * ((100 - n.pc_desconto) / 100), 2) as decimal(11,2)) ,2),
						i.pc_comissao_extra ,
						 (case n.id_tipo_venda 
							when 'AV' THEN 'AVISTA'
							when 'CV' THEN 'CONVENIO'
							when 'CC' THEN 'CONTA CORRENTE'
							when 'CR' THEN 'CREDIARIO'
						 END),
						coalesce(co.nm_fantasia, '') ,
						coalesce((CASE WHEN coalesce(v.id_pbm, 'N') = 'S' THEN '' ELSE cast(i.cd_promocao_sos as VARCHAR(6)) END), ''),
						coalesce((CASE WHEN coalesce(v.id_pbm, 'N') = 'S' THEN '' ELSE pro.nm_promocao_sos END), ''),
						coalesce((CASE WHEN coalesce(v.id_pbm, 'N') = 'S' THEN 0 ELSE prop.pc_desconto END), 0),
						coalesce(v.id_pbm, 'N'),
						 (Case When (	select count(*) 
											from venda_pbm vp 
											WHERE vp.cd_filial = n.cd_filial 
												and vp.nr_nf = n.nr_nf 
												and vp.de_especie = n.de_especie 
												and vp.de_serie = n.de_serie
												AND vp.cd_convenio = 52575 
												and vp.nr_comprovante_venda = 'AVFARPOP') > 0 
								Then 'S' 	else 'N' END	),
						coalesce(uv.pc_desconto_drogaria  + uv.pc_desconto_unimed, 0),
					(CASE WHEN coalesce(uv.pc_desconto_nf, 0) > 0 
							 THEN coalesce(uv.pc_desconto_nf, 0) 
							  ELSE (CASE WHEN (coalesce(uv.pc_desconto_drogaria, 0) + coalesce(uv.pc_desconto_unimed, 0)) = 0  
										THEN n.pc_desconto 
										ELSE 0
									  END) 
					 END) ,
					(Case when coalesce(n.nr_pedido_ecommerce, 0) > 0 Then 'S' else 'N' END) ,
					 i.pc_icms,
					 round(i.qt_vendida * cast(round(round(round(i.vl_preco_unitario * ((100 - i.pc_desconto_tabela) / 100), 2) * ((100 - n.pc_desconto) / 100), 2) * (i.pc_icms / 100), 2) as decimal(11,2)) ,2), //VALOR_IMPOSTO
					 round(i.qt_vendida * coalesce(m.vl_custo_unitario, 0),2), // VALOR_CUSTO
					 round(i.qt_vendida * cast(round(round(round(i.vl_preco_unitario * ((100 - i.pc_desconto_tabela) / 100), 2) * ((100 - n.pc_desconto) / 100), 2) * (i.pc_comissao_extra / 100), 2) as decimal(11,2)) ,2), // VALOR_COMISSAO
					 round(i.qt_vendida * cast(round(round(i.vl_preco_unitario * ((100 - i.pc_desconto_tabela) / 100), 2) * ((100 - n.pc_desconto) / 100), 2) 
					 - m.vl_custo_unitario
					 - round(round(round(i.vl_preco_unitario * ((100 - i.pc_desconto_tabela) / 100), 2) * ((100 - n.pc_desconto) / 100), 2) * (i.pc_comissao_extra / 100), 2)
					 - round(round(round(i.vl_preco_unitario * ((100 - i.pc_desconto_tabela) / 100), 2) * ((100 - n.pc_desconto) / 100), 2) * (i.pc_icms / 100), 2) as decimal(11,2)) ,2) // VALOR_RENT_LIQ
			from nf_venda n (index idx_data_filial)
			inner join filial f (index pk_filial)
				on f.cd_filial = n.cd_filial
			inner join cidade ci
				on ci.cd_cidade = f.cd_cidade
			inner join item_nf_venda i (index pk_item_nf_venda)
				on i.cd_filial = n.cd_filial
				and i.nr_nf = n.nr_nf
				and i.de_especie = n.de_especie
				and i.de_serie		= n.de_serie
			inner join movimento_estoque m (index idx_nota)
				on m.cd_filial_movimento = i.cd_filial
				and m.nr_nf			= i.nr_nf
				and m.de_especie	= i.de_especie
				and m.de_serie		= i.de_serie
				and m.cd_produto	= i.cd_produto
				and coalesce(m.nr_sequencial, 1) = coalesce(i.nr_sequencial, 1)
			inner join produto_geral g (index pk_produto_geral)
				on g.cd_produto = i.cd_produto
			inner join fornecedor fo (index pk_fornecedor)
				on fo.cd_fornecedor = g.cd_fornecedor_usual
			left outer join convenio co
				on co.cd_convenio = n.cd_convenio
			left outer join venda_pbm_produto v
				on v.cd_filial = n.cd_filial
				and v.nr_nf		= n.nr_nf
				and v.de_especie	 = n.de_especie
				and v.de_serie		= n.de_serie
				and v.cd_produto	= i.cd_produto
				and v.nr_sequencial = i.nr_sequencial
			left outer join promocao_sos pro
				on pro.cd_promocao_sos = i.cd_promocao_sos
			left outer join promocao_sos_produto prop
				on prop.cd_promocao_sos = pro.cd_promocao_sos
				and prop.cd_produto = i.cd_produto
			left outer join unimed_venda uv
				 on uv.cd_filial = n.cd_filial 
				and uv.nr_nf = n.nr_nf 
				and uv.de_especie = n.de_especie 
				and uv.de_serie = n.de_serie
			where n.dh_movimentacao_caixa = :ldt_Movimento
			  and n.dh_cancelamento is null
			  and n.nr_nf_anexa is null
			  and n.nr_pedido_ecommerce is null
			  and g.id_situacao = 'A'
			  and i.cd_produto <> 684431
			  and n.cd_filial = :ll_Filial
			  //and n.nr_nf = 3480648	
			order by n.cd_filial, n.nr_nf, i.nr_sequencial;
			
			// Abrindo o cursor
			OPEN lcu_Notas;
			
			// Buscar a primeira linha do resultado
			FETCH lcu_Notas INTO 	:ls_Movimento, :ls_Hora, :ll_Filial,  :DESC_FIL, :CIDADE, :UF, :BANDEIRA, :NOTA, :SEQUENCIAL, :FABRICANTE, :SUBCATEGORIA, :CATEGORIA, :SUBGRUPO, :GRUPO,  :COD_SKU, 
											:DESCRICAO_SKU, :QT_VENDIDA, :PRECO_BRUTO, :PC_DESCONTO, :PC_DESCONTO_NOTA, :PRECO_LIQ, :PC_COMISSAO, :TIPO_VENDA, :CONVENIO, :COD_PROMO, :DESC_PROMOCAO, :PC_DESCONTO_PROMO, :VENDA_PBM,
											:VENDA_FARM_GOV, :PC_DESC_UNIMED, :PC_DESC_CONVENIO,  :ECOMMERCE,  :PC_ICMS, :VALOR_IMPOSTO, :VALOR_CUSTO, :VALOR_COMISSAO, :VALOR_RENT_LIQ;
			
			If SQLCA.sqlcode = -1 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao recuperar as informa$$HEX2$$e700f500$$ENDHEX$$es do cursor.", StopSign!)
				Return
			End If
			
			// Repetir Enquanto Houver Linhas
			DO WHILE SQLCA.sqlcode = 0
								
					ls_Registro = 	ls_Movimento + TAB +&
										ls_Hora + TAB +&
										String(ll_Filial) + TAB +&
										DESC_FIL + TAB +&
										CIDADE + TAB +&
										UF + TAB +&
										BANDEIRA + TAB +&
										string(NOTA) + TAB +&
										SUBCATEGORIA + TAB +&
										CATEGORIA + TAB +&
										SUBGRUPO + TAB +&
										GRUPO + TAB +&
										string(COD_SKU) + TAB +&
										DESCRICAO_SKU + TAB +&
										String(QT_VENDIDA) + TAB +&
										String(PRECO_BRUTO) + TAB +&
										String(PC_DESCONTO) + TAB +&
										String(PC_DESCONTO_NOTA) + TAB +&
										String(PRECO_LIQ) + TAB +&
										String(PC_COMISSAO) + TAB +&
										TIPO_VENDA + TAB +&
										CONVENIO + TAB +&
										VENDA_PBM + TAB +&
										VENDA_FARM_GOV + TAB +&
										String(VALOR_IMPOSTO) + TAB +&
										String(VALOR_CUSTO) + TAB +&
										String(VALOR_COMISSAO) + TAB +&
										String(VALOR_RENT_LIQ)
												
					// Cabecalho
					li_Ret = FileWrite(li_Arq, ls_Registro)
		
					If IsNull(li_Ret) or li_Ret <= 0 Then
						Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gravar o registro cabe$$HEX1$$e700$$ENDHEX$$alho no arquivo TXT.", StopSign!)
						Return
					End If	
																	
					//Busca pr$$HEX1$$f300$$ENDHEX$$ximo valor
					FETCH lcu_Notas INTO 	:ls_Movimento, :ls_Hora, :ll_Filial,  :DESC_FIL, :CIDADE, :UF, :BANDEIRA, :NOTA, :SEQUENCIAL, :FABRICANTE, :SUBCATEGORIA, :CATEGORIA, :SUBGRUPO, :GRUPO,  :COD_SKU, 
													:DESCRICAO_SKU, :QT_VENDIDA, :PRECO_BRUTO, :PC_DESCONTO, :PC_DESCONTO_NOTA, :PRECO_LIQ, :PC_COMISSAO, :TIPO_VENDA, :CONVENIO, :COD_PROMO, :DESC_PROMOCAO,:PC_DESCONTO_PROMO, :VENDA_PBM,
													:VENDA_FARM_GOV, :PC_DESC_UNIMED, :PC_DESC_CONVENIO,  :ECOMMERCE,  :PC_ICMS, :VALOR_IMPOSTO, :VALOR_CUSTO, :VALOR_COMISSAO, :VALOR_RENT_LIQ;
			LOOP
			
			CLOSE lcu_Notas;			
		
			ldt_Movimento = RelativeDate(ldt_Movimento, 1)
		Loop
	
	Next
	
finally
	Destroy(lds_Filial)
	FileClose (li_Arq)
	Close(w_Aguarde)
end try

MessageBox("Aten$$HEX1$$e700$$ENDHEX$$ao", "O arquivo foi gerado com sucesso.~r~Arquivo: " + ls_Arquivo)




end subroutine

public subroutine wf_base_nota_produtos (string as_filiais, date adh_inicio, date adh_termino);String ls_Arquivo, ls_Registro, ls_Hora, ls_Movimento, TAB

String DESC_FIL, CIDADE, UF, BANDEIRA

Integer li_Arq, li_Ret

Long ll_Filial, NOTA, SEQUENCIAL, COD_SKU, ll_Nota_Anterior, ll_Conta_Nota, ll_Filial_Ant, ll_Cont_Fil

Long ll_Linha_Produto, ll_Linhas_Produto

String FABRICANTE, SUBCATEGORIA, CATEGORIA, SUBGRUPO, GRUPO,  DESCRICAO_SKU		

Long QT_VENDIDA, ll_Total_Fil
Decimal PRECO_BRUTO, PC_DESCONTO, PC_DESCONTO_NOTA, PRECO_LIQ, PC_COMISSAO
String TIPO_VENDA, CONVENIO, DESC_PROMOCAO, VENDA_PBM, COD_PROMO

Decimal PC_DESC_UNIMED, PC_DESC_CONVENIO, PC_ICMS, VALOR_IMPOSTO, VALOR_CUSTO, VALOR_COMISSAO, VALOR_RENT_LIQ, PC_MARGEM_LIQ
String VENDA_FARM_GOV, ECOMMERCE
Decimal PC_DESCONTO_PROMO

Date ldt_Movimento

TAB = "	"

dc_uo_ds_base lds_Filial

try
	
	Open(w_Aguarde)
					
	ls_Arquivo =  gvo_Aplicacao.ivs_Path_Arquivos  + "BASE_NOTAS_" + string(adh_inicio, "ddmmyyyy") + "_ATE_"+  String(adh_termino, "ddmmyyyy") + ".TXT"
	
	If FileExists (ls_Arquivo) Then
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O arquivo '" + ls_Arquivo + "' j$$HEX1$$e100$$ENDHEX$$ existe.~r~rDeseja substitu$$HEX1$$ed00$$ENDHEX$$-lo?", Question!, YesNo!, 2) = 1 Then
			If Not FileDelete ( ls_Arquivo ) Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao excluir o arquivo '" + ls_Arquivo + "'.", StopSign!)
				Return
			End If
		Else
			Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O processo foi abortado.", Exclamation!)
			Return
		End If
	End If
		
	li_Arq = FileOpen(ls_Arquivo, LineMode!, Write!, LockReadWrite!, Replace!, EncodingANSI!)
	
	If li_Arq = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao abrir o arquivo " + ls_Arquivo )
		Return
	End If
				
	ls_Registro = 	"VENDA" + TAB +&
						"HORA" + TAB +&
						"COD_FIL" + TAB +&
						"DESC_FIL" + TAB +&
						"CIDADE" + TAB +&
						"UF" + TAB +&
						"BANDEIRA" + TAB +&
						"NOTA" + TAB +&
						"SUBCATEGORIA" + TAB +&
						"CATEGORIA" + TAB +&
						"SUBGRUPO" + TAB +&
						"GRUPO" + TAB +&
						"COD_SKU" + TAB +&
						"DESCRICAO_SKU" + TAB +&
						"QT_VENDIDA" + TAB +&
						"PRECO_BRUTO" + TAB +&
						"PC_DESCONTO" + TAB +&
						"PC_DESCONTO_NOTA" + TAB +&
						"PRECO_LIQ" + TAB +&
						"PC_COMISSAO" + TAB +&
						"TIPO_VENDA" + TAB +&
						"CONVENIO" + TAB +&
						"VENDA_PBM" + TAB +&
						"VENDA_FARM_GOV" + TAB +&
						"VALOR_IMPOSTO" + TAB +&
						"VALOR_CUSTO" + TAB +&
						"VALOR_COMISSAO" + TAB +&
						"VALOR_RENT_LIQ" 
						
	li_Ret = FileWrite(li_Arq, ls_Registro)
	
	If IsNull(li_Ret) or li_Ret <= 0 Then
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gravar o registro cabe$$HEX1$$e700$$ENDHEX$$alho no arquivo TXT.", StopSign!)
		Return
	End If	
	
	lds_Filial = Create dc_uo_ds_base
	
	If Not lds_Filial.of_ChangeDataObject("ds_ge440_filial") Then Return
	
	If as_filiais = 'C' Then
		If Not IsNull(is_Filiais) Then
			lds_Filial.of_AppendWhere("f.cd_filial in (" + is_Filiais + ")")
		End If
	End If
	
	ll_Total_Fil = lds_Filial.Retrieve()
	
	For ll_Cont_Fil = 1 To ll_Total_Fil
		
		ll_Filial = lds_Filial.Object.cd_filial[ll_Cont_Fil]
		
		ldt_Movimento = adh_inicio
									
		Do While ldt_Movimento <= adh_termino
			
			w_Aguarde.Title = "Filial [" + String(ll_Filial) + "] - Emiss$$HEX1$$e300$$ENDHEX$$o : " + String(ldt_Movimento, "dd/mm/yyyy")
			
			dc_uo_ds_base lds
			lds = Create dc_uo_ds_base
			
			If Not lds.of_ChangeDataObject("ds_ge440_notas") Then Return
									
			If Not IsNull(is_produtos) Then
				lds_Filial.of_AppendWhere("i.cd_produto in (" + is_produtos + ")")
			End If
			
			ll_Linhas_Produto = lds.Retrieve(ldt_Movimento, ll_Filial)
			
			If ll_Linhas_Produto > 0 Then
				
				w_aguarde.uo_progress.of_setmax(ll_Linhas_Produto)
			
				For ll_Linha_Produto = 1 To ll_Linhas_Produto
			
					ls_Movimento 				= lds.Object.de_movimento[ll_Linha_Produto]
					ls_Hora 						= lds.Object.de_hora[ll_Linha_Produto]
					ll_Filial 						= lds.Object.cd_filial[ll_Linha_Produto]
					DESC_FIL 					= lds.Object.de_filial[ll_Linha_Produto]
					CIDADE 						= lds.Object.de_cidade[ll_Linha_Produto]
					UF 							= lds.Object.de_uf[ll_Linha_Produto]
					BANDEIRA 					= lds.Object.de_bandeira[ll_Linha_Produto]
					NOTA 						= lds.Object.nr_nf[ll_Linha_Produto]
					SEQUENCIAL 				= lds.Object.nr_sequencial[ll_Linha_Produto]
					FABRICANTE 				= lds.Object.de_fabricante[ll_Linha_Produto]
					SUBCATEGORIA			= lds.Object.de_subcategoria[ll_Linha_Produto]
					CATEGORIA 				= lds.Object.de_categoria[ll_Linha_Produto]
					SUBGRUPO 					= lds.Object.de_subgrupo[ll_Linha_Produto]
					GRUPO 						= lds.Object.de_grupo[ll_Linha_Produto]
					COD_SKU 					= lds.Object.cd_produto[ll_Linha_Produto]
					DESCRICAO_SKU 			= lds.Object.de_produto[ll_Linha_Produto]
					QT_VENDIDA 				= lds.Object.qt_vendida[ll_Linha_Produto]
					PRECO_BRUTO 			= lds.Object.vl_preco_unitario[ll_Linha_Produto]
					PC_DESCONTO 			= lds.Object.pc_desconto_tabela[ll_Linha_Produto]
					PC_DESCONTO_NOTA 	= lds.Object.pc_desconto[ll_Linha_Produto]
					PRECO_LIQ 					= lds.Object.vl_preco_liquido[ll_Linha_Produto]
					PC_COMISSAO 			= lds.Object.pc_comissao_extra[ll_Linha_Produto]
					TIPO_VENDA 				= lds.Object.id_tipo_venda[ll_Linha_Produto]
					CONVENIO 					= lds.Object.nm_convenio[ll_Linha_Produto]
					COD_PROMO 				= lds.Object.cd_promocao[ll_Linha_Produto]
					DESC_PROMOCAO 		= lds.Object.de_promocao[ll_Linha_Produto]
					PC_DESCONTO_PROMO 	= lds.Object.pc_desconto_promocao[ll_Linha_Produto]
					VENDA_PBM 				= lds.Object.id_venda_pbm[ll_Linha_Produto]
					VENDA_FARM_GOV 		= lds.Object.id_venda_farm_gov[ll_Linha_Produto]
					PC_DESC_UNIMED 		= lds.Object.pc_desconto_unimed[ll_Linha_Produto]
					PC_DESC_CONVENIO 		= lds.Object.pc_desconto_convenio[ll_Linha_Produto]
					ECOMMERCE 				= lds.Object.id_pedido_ecommerce[ll_Linha_Produto]
					PC_ICMS 					= lds.Object.pc_icms[ll_Linha_Produto]
					VALOR_IMPOSTO 			= lds.Object.vl_imposto[ll_Linha_Produto]
					VALOR_CUSTO 			= lds.Object.vl_custo_medio[ll_Linha_Produto]
					VALOR_COMISSAO 		= lds.Object.vl_comissao[ll_Linha_Produto]
					VALOR_RENT_LIQ 			= lds.Object.vl_rentabilidade[ll_Linha_Produto]
					
					ls_Registro = 	ls_Movimento + TAB+&
											ls_Hora + TAB +&
											String(ll_Filial) + TAB +&
											DESC_FIL + TAB +&
											CIDADE + TAB +&
											UF + TAB +&
											BANDEIRA + TAB +&
											string(NOTA) + TAB +&
											SUBCATEGORIA + TAB +&
											CATEGORIA + TAB +&
											SUBGRUPO + TAB +&
											GRUPO + TAB +&
											string(COD_SKU) + TAB +&
											DESCRICAO_SKU + TAB +&
											String(QT_VENDIDA) + TAB +&
											String(PRECO_BRUTO) + TAB +&
											String(PC_DESCONTO) + TAB +&
											String(PC_DESCONTO_NOTA) + TAB +&
											String(PRECO_LIQ) + TAB +&
											String(PC_COMISSAO) + TAB +&
											TIPO_VENDA + TAB +&
											CONVENIO + TAB +&
											VENDA_PBM + TAB +&
											VENDA_FARM_GOV + TAB +&
											String(VALOR_IMPOSTO) + TAB +&
											String(VALOR_CUSTO) + TAB +&
											String(VALOR_COMISSAO) + TAB +&
											String(VALOR_RENT_LIQ)
													
						// Cabecalho
						li_Ret = FileWrite(li_Arq, ls_Registro)
			
						If IsNull(li_Ret) or li_Ret <= 0 Then
							Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gravar o registro cabe$$HEX1$$e700$$ENDHEX$$alho no arquivo TXT.", StopSign!)
							Return
						End If	
																	
						w_aguarde.uo_progress.of_setprogress(ll_Linha_Produto)
				Next
				
				w_aguarde.uo_progress.of_reset()
				
			Else
				If ll_Linhas_Produto < 0 Then
					Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao recuperar as informa$$HEX2$$e700f500$$ENDHEX$$es")
					Return
				End If
			End If
			
			Destroy lds
					
			ldt_Movimento = RelativeDate(ldt_Movimento, 1)
		Loop
	
	Next
	
finally
	
	If Isvalid(lds_Filial) Then Destroy(lds_Filial)
	If IsValid(lds) Then Destroy(lds)
	
	FileClose (li_Arq)
	Close(w_Aguarde)
end try

MessageBox("Aten$$HEX1$$e700$$ENDHEX$$ao", "O arquivo foi gerado com sucesso.~r~Arquivo: " + ls_Arquivo)




end subroutine

public subroutine wf_base_nota_promocao (string as_filiais, date adh_inicio, date adh_termino);Boolean lb_Grava_Cabecalho

String ls_Arquivo, ls_Registro, ls_Hora, ls_Movimento, TAB

String DESC_FIL, CIDADE, UF, BANDEIRA, lvs_SQL

Integer li_Arq, li_Ret, li_Retorno

Long ll_Filial, NOTA, SEQUENCIAL, COD_SKU, ll_Nota_Anterior, ll_Conta_Nota, ll_Filial_Ant, ll_Cont_Fil

String FABRICANTE, SUBCATEGORIA, CATEGORIA, SUBGRUPO, GRUPO,  DESCRICAO_SKU		

Long QT_VENDIDA, ll_Total_Fil
Decimal PRECO_BRUTO, PC_DESCONTO, PC_DESCONTO_NOTA, PRECO_LIQ, PC_COMISSAO
String TIPO_VENDA, CONVENIO, DESC_PROMOCAO, VENDA_PBM, COD_PROMO

Decimal PC_DESC_UNIMED, PC_DESC_CONVENIO, PC_ICMS, VALOR_IMPOSTO, VALOR_CUSTO, VALOR_COMISSAO, VALOR_RENT_LIQ, PC_MARGEM_LIQ
String VENDA_FARM_GOV, ECOMMERCE
Decimal PC_DESCONTO_PROMO

Date ldt_Movimento

TAB = "	"

dc_uo_ds_base lds_Filial

try
	Open(w_Aguarde)
					
	ls_Arquivo =  gvo_Aplicacao.ivs_Path_Arquivos  + "BASE_NOTAS_PROMO_" + string(adh_inicio, "ddmmyyyy") + "_ATE_"+  String(adh_termino, "ddmmyyyy") + ".TXT"
	
	If Not wf_abre_arquivo(ls_Arquivo, ref lb_Grava_Cabecalho, ref li_Arq) Then Return
			
	If lb_Grava_Cabecalho Then
		ls_Registro = 	"VENDA" + TAB +&
							"COD_FIL" + TAB +&
							"DESC_FIL" + TAB +&
							"CIDADE" + TAB +&
							"UF" + TAB +&
							"BANDEIRA" + TAB +&
							"SUBCATEGORIA" + TAB +&
							"CATEGORIA" + TAB +&
							"SUBGRUPO" + TAB +&
							"GRUPO" + TAB +&
							"COD_SKU" + TAB +&
							"DESCRICAO_SKU" + TAB +&
							"COD_PROMO" + TAB +&
							"DESC_PROMOCAO" + TAB +&
							"PC_DESCONTO_PROMO" + TAB +&
							"QT_VENDIDA" + TAB +&
							"PRECO_BRUTO" + TAB +&
							"PRECO_LIQ" + TAB +&
							"VALOR_IMPOSTO" + TAB +&
							"VALOR_CUSTO" + TAB +&
							"VALOR_COMISSAO" + TAB +&
							"VALOR_RENT_LIQ" 
							
		li_Ret = FileWrite(li_Arq, ls_Registro)
		
		If IsNull(li_Ret) or li_Ret <= 0 Then
			Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gravar o registro cabe$$HEX1$$e700$$ENDHEX$$alho no arquivo TXT.", StopSign!)
			Return
		End If	
	End If
	
	lds_Filial = Create dc_uo_ds_base
	
	If Not lds_Filial.of_ChangeDataObject("ds_ge440_filial") Then Return
	
	If as_filiais = 'C' Then
		If Not IsNull(is_Filiais) Then
			lds_Filial.of_AppendWhere("f.cd_filial in (" + is_Filiais + ")")
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma filial foi selecionada.")
			Return
		End If
	End If
	
	ll_Total_Fil = lds_Filial.Retrieve()
	
	For ll_Cont_Fil = 1 To ll_Total_Fil
		
		ll_Filial = lds_Filial.Object.cd_filial[ll_Cont_Fil]

		ldt_Movimento = adh_inicio
									
		Do While ldt_Movimento <= adh_termino
			
			w_Aguarde.Title = "Filial [" + String(ll_Filial) + "] - Emiss$$HEX1$$e300$$ENDHEX$$o : " + String(ldt_Movimento, "dd/mm/yyyy")
						
			lvs_SQL = 	" select		substring(CONVERT( CHAR(10), n.dh_movimentacao_caixa, 103 ), 1, 10), "+&
							" 			n.cd_filial, "+&
							" 			f.nm_fantasia,	 "+&
							" 			ci.nm_cidade, "+&
							" 			ci.cd_unidade_federacao,  "+&
							" 			f.id_rede_filial, "+&
							" 			(select de_subcategoria 	from subcategoria su where su.cd_subcategoria = g.cd_subcategoria), "+&
							" 			(select de_categoria 		from categoria ca where ca.cd_categoria = substring(g.cd_subcategoria, 1,6)), "+&
							" 			(select de_subgrupo 		from subgrupo sub where sub.cd_subgrupo = substring(g.cd_subcategoria, 1,3)), "+&
							" 			(select de_grupo 			from grupo gr where gr.cd_grupo = substring(g.cd_subcategoria, 1,1)), "+&
							" 			i.cd_produto, "+&
							" 			g.de_produto  + ' : ' + g.de_apresentacao_venda, "+&
							" 			coalesce((CASE WHEN coalesce(v.id_pbm, 'N') = 'S' THEN '' ELSE cast(i.cd_promocao_sos as VARCHAR(6)) END), '') as cd_promocao, "+&
							" 			coalesce((CASE WHEN coalesce(v.id_pbm, 'N') = 'S' THEN '' ELSE pro.nm_promocao_sos END), '') as nm_promocao, "+&
							" 			coalesce((CASE WHEN coalesce(v.id_pbm, 'N') = 'S' THEN 0 ELSE prop.pc_desconto END), 0) as pc_desconto, "+&
							" 			sum(i.qt_vendida), "+&
							" 			sum(round(i.qt_vendida * i.vl_preco_unitario, 2)), "+&
							" 			sum(round(i.qt_vendida * cast(round(round(i.vl_preco_unitario * ((100 - i.pc_desconto_tabela) / 100), 2) * ((100 - n.pc_desconto) / 100), 2) as decimal(11,2)) ,2)), "+&
							" 			sum(round(i.qt_vendida * cast(round(round(round(i.vl_preco_unitario * ((100 - i.pc_desconto_tabela) / 100), 2) * ((100 - n.pc_desconto) / 100), 2) * (i.pc_icms / 100), 2) as decimal(11,2)) ,2)),  "+&
							" 		 	sum(round(i.qt_vendida * coalesce(m.vl_custo_unitario, 0),2)), "+&
							" 		 	sum(round(i.qt_vendida * cast(round(round(round(i.vl_preco_unitario * ((100 - i.pc_desconto_tabela) / 100), 2) * ((100 - n.pc_desconto) / 100), 2) * (i.pc_comissao_extra / 100), 2) as decimal(11,2)) ,2)),  "+&
							" 		 	sum(round(i.qt_vendida * cast(round(round(i.vl_preco_unitario * ((100 - i.pc_desconto_tabela) / 100), 2) * ((100 - n.pc_desconto) / 100), 2)  "+&
							" 		 	- m.vl_custo_unitario "+&
							" 		 	- round(round(round(i.vl_preco_unitario * ((100 - i.pc_desconto_tabela) / 100), 2) * ((100 - n.pc_desconto) / 100), 2) * (i.pc_comissao_extra / 100), 2) "+&
							" 		 	- round(round(round(i.vl_preco_unitario * ((100 - i.pc_desconto_tabela) / 100), 2) * ((100 - n.pc_desconto) / 100), 2) * (i.pc_icms / 100), 2) as decimal(11,2)) ,2)) "+&
							" from nf_venda n (index idx_data_filial) "+&
							" inner join filial f (index pk_filial) "+&
							" 	on f.cd_filial = n.cd_filial "+&
							" inner join cidade ci "+&
							" 	on ci.cd_cidade = f.cd_cidade "+&
							" inner join item_nf_venda i (index pk_item_nf_venda) "+&
							" 	on i.cd_filial = n.cd_filial "+&
							" 	and i.nr_nf = n.nr_nf "+&
							" 	and i.de_especie = n.de_especie "+&
							" 	and i.de_serie		= n.de_serie "+&
							" inner join movimento_estoque m (index idx_nota) "+&
							" 	on m.cd_filial_movimento = i.cd_filial "+&
							" 	and m.nr_nf			= i.nr_nf "+&
							" 	and m.de_especie	= i.de_especie "+&
							" 	and m.de_serie		= i.de_serie "+&
							" 	and m.cd_produto	= i.cd_produto "+&
							" 	and coalesce(m.nr_sequencial, 1) = coalesce(i.nr_sequencial, 1) "+&
							" inner join produto_geral g (index pk_produto_geral) "+&
							" 	on g.cd_produto = i.cd_produto "+&
							" inner join fornecedor fo (index pk_fornecedor) "+&
							" 	on fo.cd_fornecedor = g.cd_fornecedor_usual "+&
							" left outer join convenio co "+&
							" 	on co.cd_convenio = n.cd_convenio "+&
							" left outer join venda_pbm_produto v "+&
							" 	on v.cd_filial = n.cd_filial "+&
							" 	and v.nr_nf		= n.nr_nf "+&
							" 	and v.de_especie	 = n.de_especie "+&
							" 	and v.de_serie		= n.de_serie "+&
							" 	and v.cd_produto	= i.cd_produto "+&
							" 	and v.nr_sequencial = i.nr_sequencial "+&
							" left outer join promocao_sos pro "+&
							" 	on pro.cd_promocao_sos = i.cd_promocao_sos "+&
							" left outer join promocao_sos_produto prop "+&
							" 	on prop.cd_promocao_sos = pro.cd_promocao_sos "+&
							" 	and prop.cd_produto = i.cd_produto "+&
							" left outer join unimed_venda uv "+&
							" 	 on uv.cd_filial = n.cd_filial "+& 
							" 	and uv.nr_nf = n.nr_nf  "+&
							" 	and uv.de_especie = n.de_especie  "+&
							" 	and uv.de_serie = n.de_serie "+&
							" where n.dh_movimentacao_caixa = '" + string(ldt_Movimento, 'yyyymmdd') + "' "+&
							"   and n.dh_cancelamento is null "+&
							 "  and n.nr_nf_anexa is null "+&
							 "  and n.nr_pedido_ecommerce is null "+&
							  " and coalesce(v.id_pbm, 'N') = 'N' "+&
							  " and not exists (select * from venda_pbm vp "+&
							" 					 WHERE vp.cd_filial = n.cd_filial  "+&
							" 						and vp.nr_nf = n.nr_nf  "+&
							" 						and vp.de_especie = n.de_especie  "+&
							" 						and vp.de_serie = n.de_serie "+&
							" 						AND vp.cd_convenio = 52575  "+&
							" 						and vp.nr_comprovante_venda = 'AVFARPOP') "+&
							 "  and i.cd_produto <> 684431 "
			
			If Not IsNull(is_Produtos) and trim(is_Produtos) <> "" Then lvs_SQL += " and i.cd_produto in (" + is_produtos + ") "
							 
			lvs_SQL +=  "and n.cd_filial = " + string(ll_Filial) +&
							" group by substring(CONVERT( CHAR(10), n.dh_movimentacao_caixa, 103 ), 1, 10), "+&
							" 			n.cd_filial, "+&
							" 			f.nm_fantasia,	 "+&
							" 			ci.nm_cidade, "+&
							" 			ci.cd_unidade_federacao,  "+&
							" 			f.id_rede_filial, "+&
							" 			g.cd_subcategoria, "+&
							" 			substring(g.cd_subcategoria, 1,6), "+&
							" 			substring(g.cd_subcategoria, 1,3), "+&
							" 			substring(g.cd_subcategoria, 1,1), "+&
							" 			i.cd_produto, "+&
							" 			g.de_produto  + ' : ' + g.de_apresentacao_venda, "+&
							" 			coalesce((CASE WHEN coalesce(v.id_pbm, 'N') = 'S' THEN '' ELSE cast(i.cd_promocao_sos as VARCHAR(6)) END), ''), "+&
							" 			coalesce((CASE WHEN coalesce(v.id_pbm, 'N') = 'S' THEN '' ELSE pro.nm_promocao_sos END), ''), "+&
							" 			coalesce((CASE WHEN coalesce(v.id_pbm, 'N') = 'S' THEN 0 ELSE prop.pc_desconto END), 0) "+&
							" order by n.cd_filial, substring(CONVERT( CHAR(10), n.dh_movimentacao_caixa, 103 ), 1, 10) "
			
			PREPARE SQLSA FROM :lvs_SQL ;
			DESCRIBE SQLSA INTO SQLDA ;
			DECLARE lcu_Notas DYNAMIC CURSOR FOR SQLSA ;
			OPEN DYNAMIC lcu_Notas USING DESCRIPTOR SQLDA ;
			FETCH lcu_Notas INTO 	:ls_Movimento, :ll_Filial,  :DESC_FIL, :CIDADE, :UF, :BANDEIRA, :SUBCATEGORIA, :CATEGORIA, :SUBGRUPO, :GRUPO,  :COD_SKU,
							  				:DESCRICAO_SKU, :COD_PROMO, :DESC_PROMOCAO, :PC_DESCONTO_PROMO, :QT_VENDIDA, :PRECO_BRUTO, :PRECO_LIQ, :VALOR_IMPOSTO, 
							  				:VALOR_CUSTO, :VALOR_COMISSAO, :VALOR_RENT_LIQ;
		
			If SQLCA.sqlcode = -1 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao recuperar as informa$$HEX2$$e700f500$$ENDHEX$$es do cursor.", StopSign!)
				Return
			End If
			
			// Repetir Enquanto Houver Linhas
			DO WHILE SQLCA.sqlcode = 0
								
					ls_Registro = 	ls_Movimento + TAB +&
										String(ll_Filial) + TAB +&
										DESC_FIL + TAB +&
										CIDADE + TAB +&
										UF + TAB +&
										BANDEIRA + TAB +&
										SUBCATEGORIA + TAB +&
										CATEGORIA + TAB +&
										SUBGRUPO + TAB +&
										GRUPO + TAB +&
										string(COD_SKU) + TAB +&
										DESCRICAO_SKU + TAB +&
										COD_PROMO + TAB +& 
										DESC_PROMOCAO + TAB +&
										String(PC_DESCONTO_PROMO) + TAB +&
										String(QT_VENDIDA) + TAB +&
										String(PRECO_BRUTO) + TAB +&
										String(PRECO_LIQ) + TAB +&
										String(VALOR_IMPOSTO) + TAB +&
										String(VALOR_CUSTO) + TAB +&
										String(VALOR_COMISSAO) + TAB +&
										String(VALOR_RENT_LIQ)
												
					// Cabecalho
					li_Ret = FileWrite(li_Arq, ls_Registro)
		
					If IsNull(li_Ret) or li_Ret <= 0 Then
						Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gravar o registro cabe$$HEX1$$e700$$ENDHEX$$alho no arquivo TXT.", StopSign!)
						Return
					End If	
																	
					//Busca pr$$HEX1$$f300$$ENDHEX$$ximo valor
					FETCH lcu_Notas INTO 	:ls_Movimento, :ll_Filial,  :DESC_FIL, :CIDADE, :UF, :BANDEIRA, :SUBCATEGORIA, :CATEGORIA, :SUBGRUPO, :GRUPO,  :COD_SKU,
							  						:DESCRICAO_SKU, :COD_PROMO, :DESC_PROMOCAO, :PC_DESCONTO_PROMO, :QT_VENDIDA, :PRECO_BRUTO, :PRECO_LIQ, :VALOR_IMPOSTO, 
							  						:VALOR_CUSTO, :VALOR_COMISSAO, :VALOR_RENT_LIQ;
			LOOP
			
			CLOSE lcu_Notas;			
		
			ldt_Movimento = RelativeDate(ldt_Movimento, 1)
		Loop
		
		GarbageCollect ()
	
	Next

CATCH (runtimeerror er)   
   MessageBox("Exce$$HEX2$$e700e300$$ENDHEX$$o de Erro", er.GetMessage())
	
finally
	Destroy(lds_Filial)
	FileClose (li_Arq)
	Close(w_Aguarde)
end try

MessageBox("Aten$$HEX1$$e700$$ENDHEX$$ao", "O arquivo foi gerado com sucesso.~r~Arquivo: " + ls_Arquivo)




end subroutine

public function boolean wf_abre_arquivo (string as_arquivo, ref boolean ab_grava_cabecalho, ref integer ai_arquivo);Integer li_Retorno

ab_grava_cabecalho = True

If FileExists (as_arquivo) Then
	
	li_Retorno = MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O arquivo '" + as_arquivo + "' j$$HEX1$$e100$$ENDHEX$$ existe.~r~rDeseja substitu$$HEX1$$ed00$$ENDHEX$$-lo?~r" +&
													"SIM -> Ser$$HEX1$$e100$$ENDHEX$$ criado um novo arquivo (o antigo ser$$HEX1$$e100$$ENDHEX$$ exclu$$HEX1$$ed00$$ENDHEX$$do).~r" + &
													"NAO -> As novas informa$$HEX2$$e700f500$$ENDHEX$$es ser$$HEX1$$e300$$ENDHEX$$o inclu$$HEX1$$ed00$$ENDHEX$$das no mesmo arquivo.", Question!, YesNoCancel!, 2)
	
	Choose Case li_Retorno
		Case 1
			If Not FileDelete ( as_arquivo ) Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao excluir o arquivo '" + as_arquivo + "'.", StopSign!)
				Return False
			End If
		Case 2
			ab_grava_cabecalho = False
		Case 3
			Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O processo foi abortado.", Exclamation!)
			Return False
	End Choose
End If
	
ai_arquivo = FileOpen(as_arquivo, LineMode!, Write!, LockReadWrite!, Append!, EncodingANSI!)

If ai_arquivo = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao abrir o arquivo " + as_arquivo )
	Return False
End If

Return True
end function

public subroutine wf_base_antunes (string as_filiais, date adh_inicio, date adh_termino);Boolean lb_Grava_Cabecalho

String ls_Arquivo, ls_arquivo2, ls_Registro, ls_Hora, ls_Movimento, TAB
String lvs_SQL
long ll_total_fil, ll_cont_fil, ll_filial
Integer li_Arq, li_Ret, li_Retorno
long ll_contador=0, ll_dias

long ll_cd_filial  
long ll_nr_nf  
string lds_de_especie  
string lds_de_serie  
string ls_id_revenda
string ls_id_tipo_venda
string ls_cd_forma_pagamento
string ls_nr_matric_operador  
datetime ldh_dh_emissao  
datetime ldh_dh_movimentacao_caixa  
decimal ldc_vl_bc_icms  
decimal ldc_vl_icms  
decimal ldc_vl_bc_icms_st  
decimal ldc_vl_icms_st  
decimal ldc_vl_total_produtos  
decimal ldc_vl_frete  
decimal ldc_vl_outras_despesas  
decimal ldc_pc_desconto  
decimal ldc_vl_total_nf  
decimal ldc_vl_pago_avista  
string ls_nr_matricula_vendedor  
string ls_cd_condicao_crediario  
string ls_cd_condicao_convenio  
string ls_cd_cliente  
string ls_cd_clube_cliente  
long ll_cd_convenio  
string ls_nm_fantasia
string ls_cd_conveniado  
string ls_cd_dependente_cliente  
string ls_cd_dependente_conveniado  
string ls_nr_matric_alteracao_preco  
string ls_nr_matric_liberacao_bloqueio  
string ls_nr_matric_liberacao_restricao  
datetime ldh_dh_cancelamento  
long ll_nr_lote_convenio  
datetime ldh_dh_devolucao  
datetime ldh_dh_cancelamento_impressora  
long ll_nr_ecf  
long ll_nr_operacao_ecf  
long ll_nr_nf_anexa  
string lds_de_especie_anexa  
string lds_de_serie_anexa  
string ls_nr_matricula_cancelamento  
string ls_cd_caixa  
long ll_nr_controle_caixa  
datetime ldh_dh_pagamento_conta  
string ls_nr_pedido_drogaexpress  
datetime ldh_dh_alteracao_central  
decimal ldc_vl_total_nf_bruto  
decimal ldc_vl_taxa_entrega  
decimal ldc_vl_total_nf_tabela  
string ls_nr_cartao_edm  
string ls_id_venda_clube  
string ls_nr_cartao_clube  
long ll_qt_pontos_clube  
string ls_cd_cliente_dependente  
long ll_nr_coo_ecf  
string ls_nr_matric_liberacao_senha  
long ll_nr_nsu  
long ll_nr_pedido_ecommerce  
long ll_nr_ccf  
string ls_cd_filial_ecommerce  
string ls_nr_cpf_cgc  
string ls_id_licitacao  
string ls_nr_matricula_licitacao  
datetime ldh_dh_licitacao  
string ls_id_comprovante_recebido  
datetime ldh_dh_comprovante_recebido  
string ls_nr_matric_comprovante  
long ll_nr_pedido_licitacao  
string lds_de_dados_adicionais  
decimal ldc_vl_desconto_nf  
string ls_id_venda_brinde  
long ll_cd_filial_brinde  
long ll_nr_nf_brinde  
string lds_de_especie_brinde  
string lds_de_serie_brinde
long ll_cd_natureza_operacao  
long ll_cd_produto  
string ls_cd_situacao_tributaria  
long ll_qt_vendida  
decimal ldc_vl_preco_unitario  
decimal ldc_pc_desconto_tabela  
decimal ldc_vl_preco_praticado  
decimal ldc_pc_icms  
decimal ldc_pc_comissao_extra  
decimal ldc_pc_comissao_normal  
string ls_id_alteracao_preco  
string ls_id_restricao_convenio  
string ls_id_comissionado  
long ll_qt_pontos_clube_i
string ls_id_cancelado  
string ls_cd_cst_origem  
string ls_cd_cst_tributacao  
long ll_cd_promocao_sos  
string ls_nm_promocao_sos
string ls_de_tipo_promocao
decimal ldc_vl_preco_unitario_fiscal  
long ll_nr_sequencial  
string ls_cd_cst_pis  
string ls_cd_cst_cofins  
long ll_nr_campanha  
long ll_cd_desc_progressivo_extra  
decimal ldc_pc_red_bc_icms_efetivo  
decimal ldc_vl_bc_icms_efetivo  
decimal ldc_pc_icms_efetivo  
decimal ldc_vl_icms_efetivo  
decimal ldc_vl_bc_icms_st_retido  
decimal ldc_vl_icms_st_retido  
decimal ldc_pc_st_retido  
decimal ldc_vl_icms_retido  
string ls_cd_beneficio  
long ll_nr_item  
long ll_cd_promocao_sap
string ls_nr_cartao  
decimal ldc_vl_base_calculo  
decimal ldc_pc_desconto_drogaria  
decimal ldc_pc_desconto_unimed  
decimal ldc_pc_desconto_nf  

Date ldt_Movimento

TAB = "	"

dc_uo_ds_base lds_Filial

ll_dias = daysafter(adh_inicio, adh_termino)

try

	Open(w_Aguarde)
					
	ls_Arquivo =  gvo_Aplicacao.ivs_Path_Arquivos  + "BASE_NOTAS_" + string(adh_inicio, "ddmmyyyy") + "_ATE_"+  String(adh_termino, "ddmmyyyy") + ".EXP"
	ls_arquivo2 = gvo_Aplicacao.ivs_Path_Arquivos  + "BASE_NOTAS_" + string(adh_inicio, "ddmmyyyy") + "_ATE_"+  String(adh_termino, "ddmmyyyy") + ".TXT"
	
	lb_Grava_Cabecalho = True
	
	If FileExists (ls_Arquivo) Then
		
		li_Retorno = MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O arquivo '" + ls_Arquivo + "' j$$HEX1$$e100$$ENDHEX$$ existe.~r~rDeseja substitu$$HEX1$$ed00$$ENDHEX$$-lo?~rSIM -> O arquivo antigo ser$$HEX1$$e100$$ENDHEX$$ exclu$$HEX1$$ed00$$ENDHEX$$do e criado um novo.~rNAO -> As novas informa$$HEX2$$e700f500$$ENDHEX$$es ser$$HEX1$$e300$$ENDHEX$$o inclu$$HEX1$$ed00$$ENDHEX$$das no mesmo arquivo.", Question!, YesNoCancel!, 2)
		
		Choose Case li_Retorno
			Case 1
				If Not FileDelete ( ls_Arquivo ) Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao excluir o arquivo '" + ls_Arquivo + "'.", StopSign!)
					Return
				End If
			Case 2
				lb_Grava_Cabecalho = False
			Case 3
				Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O processo foi abortado.", Exclamation!)
				Return
		End Choose
	End If
	
	If FileExists (ls_Arquivo2) Then
		
		li_Retorno = MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O arquivo '" + ls_Arquivo2 + "' j$$HEX1$$e100$$ENDHEX$$ existe.~r~rDeseja substitu$$HEX1$$ed00$$ENDHEX$$-lo?~rSIM -> O arquivo antigo ser$$HEX1$$e100$$ENDHEX$$ exclu$$HEX1$$ed00$$ENDHEX$$do e criado um novo.~rNAO -> As novas informa$$HEX2$$e700f500$$ENDHEX$$es ser$$HEX1$$e300$$ENDHEX$$o inclu$$HEX1$$ed00$$ENDHEX$$das no mesmo arquivo.", Question!, YesNoCancel!, 2)
		
		Choose Case li_Retorno
			Case 1
				If Not FileDelete ( ls_Arquivo2 ) Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao excluir o arquivo '" + ls_Arquivo2 + "'.", StopSign!)
					Return
				End If
			Case 2
				lb_Grava_Cabecalho = False
			Case 3
				Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O processo foi abortado.", Exclamation!)
				Return
		End Choose
	End If
	
	li_Arq = FileOpen(ls_Arquivo, LineMode!, Write!, LockReadWrite!, Append!, EncodingANSI!)
	
	If li_Arq = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao abrir o arquivo " + ls_Arquivo )
		Return
	End If
	
	If lb_Grava_Cabecalho Then
		ls_Registro = "cd_filial" + TAB + &  
							"nr_nf" + TAB + &  
							"de_especie" + TAB + &  
							"de_serie" + TAB + &  
							"id_revenda" + TAB + &
							"id_tipo_venda" + TAB + &
							"cd_forma_pagamento" + TAB + &
							"nr_matric_operador" + TAB + &  
							"dh_emissao" + TAB + &  
							"dh_movimentacao_caixa" + TAB + &  
							"vl_bc_icms" + TAB + &  
							"vl_icms" + TAB + &  
							"vl_bc_icms_st" + TAB + &  
							"vl_icms_st" + TAB + &  
							"vl_total_produtos" + TAB + &  
							"vl_frete" + TAB + &  
							"vl_outras_despesas" + TAB + &  
							"pc_desconto" + TAB + &  
							"vl_total_nf" + TAB + &  
							"vl_pago_avista" + TAB + &  
							"nr_matricula_vendedor" + TAB + &  
							"cd_condicao_crediario" + TAB + &  
							"cd_condicao_convenio" + TAB + &  
							"cd_cliente" + TAB + &  
							"cd_clube_cliente" + TAB + &  
							"cd_convenio" + TAB + &  
							"nm_fantasia" + TAB + &
							"cd_conveniado" + TAB + &  
							"cd_dependente_cliente" + TAB + &  
							"cd_dependente_conveniado" + TAB + &  
							"nr_matric_alteracao_preco" + TAB + &  
							"nr_matric_liberacao_bloqueio" + TAB + &  
							"nr_matric_liberacao_restricao" + TAB + &  
							"dh_cancelamento" + TAB + &  
							"nr_lote_convenio" + TAB + &  
							"dh_devolucao" + TAB + &  
							"dh_cancelamento_impressora" + TAB + &  
							"nr_ecf" + TAB + &  
							"nr_operacao_ecf" + TAB + &  
							"nr_nf_anexa" + TAB + &  
							"de_especie_anexa" + TAB + &  
							"de_serie_anexa" + TAB + &  
							"nr_matricula_cancelamento" + TAB + &  
							"cd_caixa" + TAB + &  
							"nr_controle_caixa" + TAB + &  
							"dh_pagamento_conta" + TAB + &  
							"nr_pedido_drogaexpress" + TAB + &  
							"dh_alteracao_central" + TAB + &  
							"vl_total_nf_bruto" + TAB + &  
							"vl_taxa_entrega" + TAB + &  
							"vl_total_nf_tabela" + TAB + &  
							"nr_cartao_edm" + TAB + &  
							"id_venda_clube" + TAB + &  
							"nr_cartao_clube" + TAB + &  
							"qt_pontos_clube" + TAB + &  
							"cd_cliente_dependente" + TAB + &  
							"nr_coo_ecf" + TAB + &  
							"nr_matric_liberacao_senha" + TAB + &  
							"nr_nsu" + TAB + &  
							"nr_pedido_ecommerce" + TAB + &  
							"nr_ccf" + TAB + &  
							"cd_filial_ecommerce" + TAB + &  
							"nr_cpf_cgc" + TAB + &  
							"id_licitacao" + TAB + &  
							"nr_matricula_licitacao" + TAB + &  
							"dh_licitacao" + TAB + &  
							"id_comprovante_recebido" + TAB + &  
							"dh_comprovante_recebido" + TAB + &  
							"nr_matric_comprovante" + TAB + &  
							"nr_pedido_licitacao" + TAB + &  
							"de_dados_adicionais" + TAB + &  
							"vl_desconto_nf" + TAB + &  
							"id_venda_brinde" + TAB + &  
							"cd_filial_brinde" + TAB + &  
							"nr_nf_brinde" + TAB + &  
							"de_especie_brinde" + TAB + &  
							"de_serie_brinde" + TAB + &
							"cd_natureza_operacao" + TAB + &  
							"cd_produto" + TAB + &  
							"cd_situacao_tributaria" + TAB + &  
							"qt_vendida" + TAB + &  
							"vl_preco_unitario" + TAB + &  
							"pc_desconto_tabela" + TAB + &  
							"vl_preco_praticado" + TAB + &  
							"pc_icms" + TAB + &  
							"pc_comissao_extra" + TAB + &  
							"pc_comissao_normal" + TAB + &  
							"id_alteracao_preco" + TAB + &  
							"id_restricao_convenio" + TAB + &  
							"id_comissionado" + TAB + &  
							"qt_pontos_clube" + TAB + &  
							"id_cancelado" + TAB + &  
							"cd_cst_origem" + TAB + &  
							"cd_cst_tributacao" + TAB + &  
							"cd_promocao_sos" + TAB + &  
							"nm_promocao_sos" + TAB + &
							"de_tipo_promocao" + TAB + &
							"vl_preco_unitario_fiscal" + TAB + &  
							"nr_sequencial" + TAB + &  
							"cd_cst_pis" + TAB + &  
							"cd_cst_cofins" + TAB + &  
							"nr_campanha" + TAB + &  
							"cd_desc_progressivo_extra" + TAB + &  
							"pc_red_bc_icms_efetivo" + TAB + &  
							"vl_bc_icms_efetivo" + TAB + &  
							"pc_icms_efetivo" + TAB + &  
							"vl_icms_efetivo" + TAB + &  
							"vl_bc_icms_st_retido" + TAB + &  
							"vl_icms_st_retido" + TAB + &  
							"pc_st_retido" + TAB + &  
							"vl_icms_retido" + TAB + &  
							"cd_beneficio" + TAB + &  
							"nr_item" + TAB + &  
							"cd_promocao_sap" + TAB + &
							"nr_cartao" + TAB + &  
							"vl_base_calculo" + TAB + &  
							"pc_desconto_drogaria" + TAB + &  
							"pc_desconto_unimed" + TAB + &  
							"pc_desconto_nf"
							
		li_Ret = FileWrite(li_Arq, ls_Registro)
		
		//"COD_PROMO" + TAB +&
		//"DESC_PROMOCAO" + TAB +&
		//"PC_DESCONTO_PROMO" + TAB +&
		
		If IsNull(li_Ret) or li_Ret <= 0 Then
			Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gravar o registro cabe$$HEX1$$e700$$ENDHEX$$alho no arquivo TXT.", StopSign!)
			Return
		End If	
	End If
	
	lds_Filial = Create dc_uo_ds_base
	
	If Not lds_Filial.of_ChangeDataObject("ds_ge440_filial") Then Return
	
	If as_filiais = 'C' Then
		If Not IsNull(is_Filiais) Then
			lds_Filial.of_AppendWhere("f.cd_filial in (" + is_Filiais + ")")
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma filial foi selecionada.")
			Return
		End If
	End If
	
	ll_Total_Fil = lds_Filial.Retrieve()
	
	For ll_Cont_Fil = 1 To ll_Total_Fil
		
		ll_Filial = lds_Filial.Object.cd_filial[ll_Cont_Fil]

		ldt_Movimento = adh_inicio
									
		w_aguarde.uo_progress.of_reset()							
		w_aguarde.uo_progress.of_setmax(ll_dias)
									
		Do While ldt_Movimento <= adh_termino
			
			w_Aguarde.Title = "Filial [" + String(ll_Filial) + "] - Emiss$$HEX1$$e300$$ENDHEX$$o : " + String(ldt_Movimento, "dd/mm/yyyy")
			
			
			lvs_SQL = 	"select   " + & 
							"n.cd_filial,     " + & 
							"n.nr_nf,     " + & 
							"n.de_especie,     " + & 
							"n.de_serie,     " + & 
							"n.id_revenda,   " + & 
							"(CASE n.id_tipo_venda  " + & 
							"	WHEN  'AV' THEN 'AVISTA'  " + & 
								" WHEN 'CV' THEN 'CONVENIO'  " + & 
								" WHEN 'CC' THEN 'CONTA CORRENTE'  " + & 
								" WHEN 'CR' THEN 'CREDIARIO'  " + & 
								" ELSE n.id_tipo_venda  " + & 
							" END) tipo_venda,   " + & 
							" (CASE n.cd_forma_pagamento  " + & 
							"	WHEN  'CP' THEN 'CARTAO CREDITO'  " + & 
							"	WHEN 'CA' THEN 'DEBITO'  " + & 
							"	WHEN 'DI' THEN 'DINHEIRO'	  " + & 
							"	WHEN 'CV' THEN 'CONVENIO'	  " + & 
							"	WHEN 'CC' THEN 'CONTA CORRENTE' 	" + &
							"	WHEN 'MF' THEN 'MULTIPLAS FORMAS '" + &
							"	ELSE n.cd_forma_pagamento  " + & 
							" END) forma_pagamento,   " + & 
							"n.nr_matric_operador,   " + &
							"n.dh_emissao,   " + &
							"n.dh_movimentacao_caixa,   " + &
							"n.vl_bc_icms,   " + &
							"n.vl_icms,   " + &
							"n.vl_bc_icms_st,   " + &
							"n.vl_icms_st,   " + &
							"n.vl_total_produtos,   " + &
							"n.vl_frete,   " + &
							"n.vl_outras_despesas,   " + &
							"n.pc_desconto,   " + &
							"n.vl_total_nf,   " + &
							"n.vl_pago_avista,   " + &
							"n.nr_matricula_vendedor,   " + &
							"n.cd_condicao_crediario,   " + &
							"n.cd_condicao_convenio,   " + &
							"n.cd_cliente,   " + &
							"n.cd_clube_cliente,   " + &
							"n.cd_convenio,  " + &
							"c.nm_fantasia, " + &
							"n.cd_conveniado,   " + &
							"n.cd_dependente_cliente,   " + &
							"n.cd_dependente_conveniado,   " + &
							"n.nr_matric_alteracao_preco,   " + &
							"n.nr_matric_liberacao_bloqueio,   " + &
							"n.nr_matric_liberacao_restricao,   " + &
							"n.dh_cancelamento,   " + &
							"n.nr_lote_convenio,   " + &
							"n.dh_devolucao,   " + &
							"n.dh_cancelamento_impressora,   " + &
							"n.nr_ecf,   " + &
							"n.nr_operacao_ecf,   " + &
							"n.nr_nf_anexa,   " + &
							"n.de_especie_anexa,   " + &
							"n.de_serie_anexa,   " + &
							"n.nr_matricula_cancelamento,   " + &
							"n.cd_caixa,   " + &
							"n.nr_controle_caixa,   " + &
							"n.dh_pagamento_conta,   " + &
							"n.nr_pedido_drogaexpress,   " + &
							"n.dh_alteracao_central,   " + &
							"n.vl_total_nf_bruto,   " + &
							"n.vl_taxa_entrega,   " + &
							"n.vl_total_nf_tabela,   " + &
							"n.nr_cartao_edm,   " + &
							"n.id_venda_clube,   " + &
							"n.nr_cartao_clube,   " + &
							"n.qt_pontos_clube,   " + &
							"n.cd_cliente_dependente,   " + &
							"n.nr_coo_ecf,   " + &
							"n.nr_matric_liberacao_senha,   " + &
							"n.nr_nsu,   " + &
							"n.nr_pedido_ecommerce,  " + & 
							"n.nr_ccf,   " + &
							"n.cd_filial_ecommerce,   " + &
							"n.nr_cpf_cgc,   " + &
							"n.id_licitacao,   " + &
							"n.nr_matricula_licitacao,   " + &
							"n.dh_licitacao,   " + &
							"n.id_comprovante_recebido,   " + &
							"n.dh_comprovante_recebido,   " + &
							"n.nr_matric_comprovante,   " + &
							"n.nr_pedido_licitacao,   " + &
							"n.de_dados_adicionais,   " + &
							"n.vl_desconto_nf,   " + &
							"n.id_venda_brinde,   " + &
							"n.cd_filial_brinde,   " + &
							"n.nr_nf_brinde,   " + &
							"n.de_especie_brinde,   " + &
							"n.de_serie_brinde," + &
							"i.cd_natureza_operacao,  " + & 
							"i.cd_produto,   " + &
							"i.cd_situacao_tributaria,   " + &
							"i.qt_vendida,   " + &
							"i.vl_preco_unitario,   " + &
							"i.pc_desconto_tabela,   " + &
							"i.vl_preco_praticado,   " + &
							"i.pc_icms,   " + &
							"i.pc_comissao_extra,   " + &
							"i.pc_comissao_normal,   " + &
							"i.id_alteracao_preco,   " + &
							"i.id_restricao_convenio,   " + &
							"i.id_comissionado,   " + &
							"i.qt_pontos_clube,  " + & 
							"i.id_cancelado,   " + &
							"i.cd_cst_origem,   " + &
							"i.cd_cst_tributacao,   " + &
							"i.cd_promocao_sos,  " + &
						     "s.nm_promocao_sos, " + &
							"t.de_tipo_promocao," + &
							"i.vl_preco_unitario_fiscal,   " + &
							"i.nr_sequencial,   " + &
							"i.cd_cst_pis,   " + &
							"i.cd_cst_cofins,   " + &
							"i.nr_campanha,   " + &
							"i.cd_desc_progressivo_extra,   " + &
							"i.pc_red_bc_icms_efetivo,   " + &
							"i.vl_bc_icms_efetivo,   " + &
							"i.pc_icms_efetivo,   " + &
							"i.vl_icms_efetivo,   " + &
							"i.vl_bc_icms_st_retido,   " + &
							"i.vl_icms_st_retido,   " + &
							"i.pc_st_retido,   " + &
							"i.vl_icms_retido,   " + &
							"i.cd_beneficio,   " + &
							"i.nr_item,   " + &
							"i.cd_promocao_sap," + &
							"u.nr_cartao,  " + &
							"u.vl_base_calculo, " + &
							"u.pc_desconto_drogaria,  " + &
							"u.pc_desconto_unimed, " + &
							"u.pc_desconto_nf " + &
				" from nf_venda n " + &
				" inner join item_nf_venda i " + &
				"	on i.cd_filial = n.cd_filial " + &
				"	and i.nr_nf	= n.nr_nf " + &
				"	and i.de_especie = n.de_especie " + &
				"	and i.de_serie	 = n.de_serie " + &
				" left outer join promocao_sos s " + &
				"	on s.cd_promocao_sos = i.cd_promocao_sos " + &
				" inner join tipo_promocao t " + &
				"	on t.id_tipo_promocao = s.id_tipo_promocao " + &
				" left outer join convenio c " + &
				"	on c.cd_convenio = n.cd_convenio " + &
				" left outer join cliente cli " + &
				"	on cli.cd_cliente = n.cd_cliente " + &
				" left outer join unimed_venda u " + &
				"	on u.cd_filial = n.cd_filial " + &
				"	and u.nr_nf		= n.nr_nf " + &
				"	and u.de_especie = n.de_especie " + &
				"	and u.de_serie		= n.de_serie " + &
				" where n.cd_filial =  " + string(ll_Filial) + &
				"  and n.dh_movimentacao_caixa =  '" + string(ldt_Movimento, 'yyyymmdd') + "' "+&
				"  and n.dh_cancelamento is null " + &
				"  and n.nr_nf_anexa is null " 
			
			If Not IsNull(is_Produtos) and trim(is_Produtos) <> "" Then
				lvs_SQL += " and i.cd_produto in (" + is_produtos + ")"
			End If
														
			//lvs_SQL += " order by n.cd_filial, n.nr_nf, i.nr_sequencial "
			
		//	lvs_SQL= 'select cd_filial from filial'
			
			PREPARE SQLSA FROM :lvs_SQL ;
			DESCRIBE SQLSA INTO SQLDA ;
			DECLARE lcu_Notas DYNAMIC CURSOR FOR SQLSA ;
			OPEN DYNAMIC lcu_Notas USING DESCRIPTOR SQLDA ;
			
			FETCH lcu_Notas INTO :ll_cd_filial,
											:ll_nr_nf,
											:lds_de_especie,
											:lds_de_serie,
											:ls_id_revenda,
											:ls_id_tipo_venda,
											:ls_cd_forma_pagamento,
											:ls_nr_matric_operador,
											:ldh_dh_emissao,
											:ldh_dh_movimentacao_caixa,
											:ldc_vl_bc_icms,
											:ldc_vl_icms,
											:ldc_vl_bc_icms_st,
											:ldc_vl_icms_st,
											:ldc_vl_total_produtos,
											:ldc_vl_frete,
											:ldc_vl_outras_despesas,
											:ldc_pc_desconto,
											:ldc_vl_total_nf,
											:ldc_vl_pago_avista,
											:ls_nr_matricula_vendedor,
											:ls_cd_condicao_crediario,
											:ls_cd_condicao_convenio,
											:ls_cd_cliente,
											:ls_cd_clube_cliente,
											:ll_cd_convenio,
											:ls_nm_fantasia,
											:ls_cd_conveniado,
											:ls_cd_dependente_cliente,
											:ls_cd_dependente_conveniado,
											:ls_nr_matric_alteracao_preco,
											:ls_nr_matric_liberacao_bloqueio,
											:ls_nr_matric_liberacao_restricao,
											:ldh_dh_cancelamento,
											:ll_nr_lote_convenio,
											:ldh_dh_devolucao,
											:ldh_dh_cancelamento_impressora,
											:ll_nr_ecf,
											:ll_nr_operacao_ecf,
											:ll_nr_nf_anexa,
											:lds_de_especie_anexa,
											:lds_de_serie_anexa,
											:ls_nr_matricula_cancelamento,
											:ls_cd_caixa,
											:ll_nr_controle_caixa,
											:ldh_dh_pagamento_conta,
											:ls_nr_pedido_drogaexpress  ,
											:ldh_dh_alteracao_central,
											:ldc_vl_total_nf_bruto,
											:ldc_vl_taxa_entrega,
											:ldc_vl_total_nf_tabela,
											:ls_nr_cartao_edm,
											:ls_id_venda_clube,
											:ls_nr_cartao_clube,
											:ll_qt_pontos_clube,
											:ls_cd_cliente_dependente,
											:ll_nr_coo_ecf,
											:ls_nr_matric_liberacao_senha,
											:ll_nr_nsu,
											:ll_nr_pedido_ecommerce,
											:ll_nr_ccf,
											:ls_cd_filial_ecommerce,
											:ls_nr_cpf_cgc,
											:ls_id_licitacao,
											:ls_nr_matricula_licitacao,
											:ldh_dh_licitacao,
											:ls_id_comprovante_recebido,
											:ldh_dh_comprovante_recebido,
											:ls_nr_matric_comprovante,
											:ll_nr_pedido_licitacao,
											:lds_de_dados_adicionais,
											:ldc_vl_desconto_nf,
											:ls_id_venda_brinde,
											:ll_cd_filial_brinde,
											:ll_nr_nf_brinde,
											:lds_de_especie_brinde,
											:lds_de_serie_brinde,
											:ll_cd_natureza_operacao,
											:ll_cd_produto,
											:ls_cd_situacao_tributaria,
											:ll_qt_vendida,
											:ldc_vl_preco_unitario,
											:ldc_pc_desconto_tabela,
											:ldc_vl_preco_praticado,
											:ldc_pc_icms,
											:ldc_pc_comissao_extra,
											:ldc_pc_comissao_normal,
											:ls_id_alteracao_preco,
											:ls_id_restricao_convenio,
											:ls_id_comissionado,
											:ll_qt_pontos_clube_i,
											:ls_id_cancelado,
											:ls_cd_cst_origem,
											:ls_cd_cst_tributacao,
											:ll_cd_promocao_sos,
											:ls_nm_promocao_sos,
											:ls_de_tipo_promocao,
											:ldc_vl_preco_unitario_fiscal,
											:ll_nr_sequencial,
											:ls_cd_cst_pis,
											:ls_cd_cst_cofins,
											:ll_nr_campanha,
											:ll_cd_desc_progressivo_extra,
											:ldc_pc_red_bc_icms_efetivo,
											:ldc_vl_bc_icms_efetivo,
											:ldc_pc_icms_efetivo,
											:ldc_vl_icms_efetivo,
											:ldc_vl_bc_icms_st_retido,
											:ldc_vl_icms_st_retido,
											:ldc_pc_st_retido,
											:ldc_vl_icms_retido,
											:ls_cd_beneficio,
											:ll_nr_item,
											:ll_cd_promocao_sap,
											:ls_nr_cartao,
											:ldc_vl_base_calculo,
											:ldc_pc_desconto_drogaria,
											:ldc_pc_desconto_unimed,
											:ldc_pc_desconto_nf;

		
			If SQLCA.sqlcode = -1 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao recuperar as informa$$HEX2$$e700f500$$ENDHEX$$es do cursor: " + sqlca.sqlerrtext, StopSign!)
				Return
			End If
			
			// Repetir Enquanto Houver Linhas
			DO WHILE SQLCA.sqlcode = 0

					ls_Registro = 	gf_set_string( ll_cd_filial) + TAB + &
										gf_set_string( ll_nr_nf) + TAB + &
										gf_set_string( lds_de_especie) + TAB + &
										gf_set_string( lds_de_serie) + TAB + &
										gf_set_string( ls_id_revenda) + TAB + &
										gf_set_string( ls_id_tipo_venda) + TAB + &
										gf_set_string( ls_cd_forma_pagamento) + TAB + &
										gf_set_string( ls_nr_matric_operador) + TAB + &
										gf_set_string( ldh_dh_emissao) + TAB + &
										gf_set_string( ldh_dh_movimentacao_caixa) + TAB + &
										gf_set_string( ldc_vl_bc_icms) + TAB + &
										gf_set_string( ldc_vl_icms) + TAB + &
										gf_set_string( ldc_vl_bc_icms_st) + TAB + &
										gf_set_string( ldc_vl_icms_st) + TAB + &
										gf_set_string( ldc_vl_total_produtos) + TAB + &
										gf_set_string( ldc_vl_frete) + TAB + &
										gf_set_string( ldc_vl_outras_despesas) + TAB + &
										gf_set_string( ldc_pc_desconto) + TAB + &
										gf_set_string( ldc_vl_total_nf) + TAB + &
										gf_set_string( ldc_vl_pago_avista) + TAB + &
										gf_set_string( ls_nr_matricula_vendedor) + TAB + &
										gf_set_string( ls_cd_condicao_crediario) + TAB + &
										gf_set_string( ls_cd_condicao_convenio) + TAB + &
										gf_set_string( ls_cd_cliente) + TAB + &
										gf_set_string( ls_cd_clube_cliente) + TAB + &
										gf_set_string( ll_cd_convenio) + TAB + &
										gf_set_string( ls_nm_fantasia) + TAB + &
										gf_set_string( ls_cd_conveniado) + TAB + &
										gf_set_string( ls_cd_dependente_cliente) + TAB + &
										gf_set_string( ls_cd_dependente_conveniado) + TAB + &
										gf_set_string( ls_nr_matric_alteracao_preco) + TAB + &
										gf_set_string( ls_nr_matric_liberacao_bloqueio) + TAB + &
										gf_set_string( ls_nr_matric_liberacao_restricao) + TAB + &
										gf_set_string( ldh_dh_cancelamento) + TAB + &
										gf_set_string( ll_nr_lote_convenio) + TAB + &
										gf_set_string( ldh_dh_devolucao) + TAB + &
										gf_set_string( ldh_dh_cancelamento_impressora) + TAB + &
										gf_set_string( ll_nr_ecf) + TAB + &
										gf_set_string( ll_nr_operacao_ecf) + TAB + &
										gf_set_string( ll_nr_nf_anexa) + TAB + &
										gf_set_string( lds_de_especie_anexa) + TAB + &
										gf_set_string( lds_de_serie_anexa) + TAB + &
										gf_set_string( ls_nr_matricula_cancelamento) + TAB + &
										gf_set_string( ls_cd_caixa) + TAB + &
										gf_set_string( ll_nr_controle_caixa) + TAB + &
										gf_set_string( ldh_dh_pagamento_conta) + TAB + &
										gf_set_string( ls_nr_pedido_drogaexpress) + TAB + &
										gf_set_string( ldh_dh_alteracao_central) + TAB + &
										gf_set_string( ldc_vl_total_nf_bruto) + TAB + &
										gf_set_string( ldc_vl_taxa_entrega) + TAB + &
										gf_set_string( ldc_vl_total_nf_tabela) + TAB + &
										gf_set_string( ls_nr_cartao_edm) + TAB + &
										gf_set_string( ls_id_venda_clube) + TAB + &
										gf_set_string( ls_nr_cartao_clube) + TAB + &
										gf_set_string( ll_qt_pontos_clube) + TAB + &
										gf_set_string( ls_cd_cliente_dependente) + TAB + &
										gf_set_string( ll_nr_coo_ecf) + TAB + &
										gf_set_string( ls_nr_matric_liberacao_senha) + TAB + &
										gf_set_string( ll_nr_nsu) + TAB + &
										gf_set_string( ll_nr_pedido_ecommerce) + TAB + &
										gf_set_string( ll_nr_ccf) + TAB + &
										gf_set_string( ls_cd_filial_ecommerce) + TAB + &
										gf_set_string( ls_nr_cpf_cgc) + TAB + &
										gf_set_string( ls_id_licitacao) + TAB + &
										gf_set_string( ls_nr_matricula_licitacao) + TAB + &
										gf_set_string( ldh_dh_licitacao) + TAB + &
										gf_set_string( ls_id_comprovante_recebido) + TAB + &
										gf_set_string( ldh_dh_comprovante_recebido) + TAB + &
										gf_set_string( ls_nr_matric_comprovante) + TAB + &
										gf_set_string( ll_nr_pedido_licitacao) + TAB + &
										gf_set_string( lds_de_dados_adicionais) + TAB + &
										gf_set_string( ldc_vl_desconto_nf) + TAB + &
										gf_set_string( ls_id_venda_brinde) + TAB + &
										gf_set_string( ll_cd_filial_brinde) + TAB + &
										gf_set_string( ll_nr_nf_brinde) + TAB + &
										gf_set_string( lds_de_especie_brinde) + TAB + &
										gf_set_string( lds_de_serie_brinde) + TAB + &
										gf_set_string( ll_cd_natureza_operacao) + TAB + &
										gf_set_string( ll_cd_produto) + TAB + &
										gf_set_string( ls_cd_situacao_tributaria) + TAB + &
										gf_set_string( ll_qt_vendida) + TAB + &
										gf_set_string( ldc_vl_preco_unitario) + TAB + &
										gf_set_string( ldc_pc_desconto_tabela) + TAB + &
										gf_set_string( ldc_vl_preco_praticado) + TAB + &
										gf_set_string( ldc_pc_icms) + TAB + &
										gf_set_string( ldc_pc_comissao_extra) + TAB + &
										gf_set_string( ldc_pc_comissao_normal) + TAB + &
										gf_set_string( ls_id_alteracao_preco) + TAB + &
										gf_set_string( ls_id_restricao_convenio) + TAB + &
										gf_set_string( ls_id_comissionado) + TAB + &
										gf_set_string( ll_qt_pontos_clube_i) + TAB + &
										gf_set_string( ls_id_cancelado) + TAB + &
										gf_set_string( ls_cd_cst_origem) + TAB + &
										gf_set_string( ls_cd_cst_tributacao) + TAB + &
										gf_set_string( ll_cd_promocao_sos) + TAB + &
										gf_set_string( ls_nm_promocao_sos) + TAB + &
										gf_set_string( ls_de_tipo_promocao) + TAB + &
										gf_set_string( ldc_vl_preco_unitario_fiscal) + TAB + &
										gf_set_string( ll_nr_sequencial) + TAB + &
										gf_set_string( ls_cd_cst_pis) + TAB + &
										gf_set_string( ls_cd_cst_cofins) + TAB + &
										gf_set_string( ll_nr_campanha) + TAB + &
										gf_set_string( ll_cd_desc_progressivo_extra) + TAB + &
										gf_set_string( ldc_pc_red_bc_icms_efetivo) + TAB + &
										gf_set_string( ldc_vl_bc_icms_efetivo) + TAB + &
										gf_set_string( ldc_pc_icms_efetivo) + TAB + &
										gf_set_string( ldc_vl_icms_efetivo) + TAB + &
										gf_set_string( ldc_vl_bc_icms_st_retido) + TAB + &
										gf_set_string( ldc_vl_icms_st_retido) + TAB + &
										gf_set_string( ldc_pc_st_retido) + TAB + &
										gf_set_string( ldc_vl_icms_retido) + TAB + &
										gf_set_string( ls_cd_beneficio) + TAB + &
										gf_set_string( ll_nr_item) + TAB + &
										gf_set_string( ll_cd_promocao_sap) + TAB + &
										gf_set_string( ls_nr_cartao) + TAB + &
										gf_set_string( ldc_vl_base_calculo) + TAB + &
										gf_set_string( ldc_pc_desconto_drogaria) + TAB + &
										gf_set_string( ldc_pc_desconto_unimed) + TAB + &
										gf_set_string( ldc_pc_desconto_nf)

					if isnull(ls_registro) Then
						messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Registro nulo.')
					end if
			
					// Cabecalho
					li_Ret = FileWrite(li_Arq, ls_Registro)
	
					If IsNull(li_Ret) or li_Ret <= 0 Then
						Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gravar o registro cabe$$HEX1$$e700$$ENDHEX$$alho no arquivo TXT.", StopSign!)
						Return
					End If	
																	
					FETCH lcu_Notas INTO :ll_cd_filial,
											:ll_nr_nf,
											:lds_de_especie,
											:lds_de_serie,
											:ls_id_revenda,
											:ls_id_tipo_venda,
											:ls_cd_forma_pagamento,
											:ls_nr_matric_operador,
											:ldh_dh_emissao,
											:ldh_dh_movimentacao_caixa,
											:ldc_vl_bc_icms,
											:ldc_vl_icms,
											:ldc_vl_bc_icms_st,
											:ldc_vl_icms_st,
											:ldc_vl_total_produtos,
											:ldc_vl_frete,
											:ldc_vl_outras_despesas,
											:ldc_pc_desconto,
											:ldc_vl_total_nf,
											:ldc_vl_pago_avista,
											:ls_nr_matricula_vendedor,
											:ls_cd_condicao_crediario,
											:ls_cd_condicao_convenio,
											:ls_cd_cliente,
											:ls_cd_clube_cliente,
											:ll_cd_convenio,
											:ls_nm_fantasia,
											:ls_cd_conveniado,
											:ls_cd_dependente_cliente,
											:ls_cd_dependente_conveniado,
											:ls_nr_matric_alteracao_preco,
											:ls_nr_matric_liberacao_bloqueio,
											:ls_nr_matric_liberacao_restricao,
											:ldh_dh_cancelamento,
											:ll_nr_lote_convenio,
											:ldh_dh_devolucao,
											:ldh_dh_cancelamento_impressora,
											:ll_nr_ecf,
											:ll_nr_operacao_ecf,
											:ll_nr_nf_anexa,
											:lds_de_especie_anexa,
											:lds_de_serie_anexa,
											:ls_nr_matricula_cancelamento,
											:ls_cd_caixa,
											:ll_nr_controle_caixa,
											:ldh_dh_pagamento_conta,
											:ls_nr_pedido_drogaexpress,
											:ldh_dh_alteracao_central,
											:ldc_vl_total_nf_bruto,
											:ldc_vl_taxa_entrega,
											:ldc_vl_total_nf_tabela,
											:ls_nr_cartao_edm,
											:ls_id_venda_clube,
											:ls_nr_cartao_clube,
											:ll_qt_pontos_clube,
											:ls_cd_cliente_dependente,
											:ll_nr_coo_ecf,
											:ls_nr_matric_liberacao_senha,
											:ll_nr_nsu,
											:ll_nr_pedido_ecommerce,
											:ll_nr_ccf,
											:ls_cd_filial_ecommerce,
											:ls_nr_cpf_cgc,
											:ls_id_licitacao,
											:ls_nr_matricula_licitacao,
											:ldh_dh_licitacao,
											:ls_id_comprovante_recebido,
											:ldh_dh_comprovante_recebido,
											:ls_nr_matric_comprovante,
											:ll_nr_pedido_licitacao,
											:lds_de_dados_adicionais,
											:ldc_vl_desconto_nf,
											:ls_id_venda_brinde,
											:ll_cd_filial_brinde,
											:ll_nr_nf_brinde,
											:lds_de_especie_brinde,
											:lds_de_serie_brinde,
											:ll_cd_natureza_operacao,
											:ll_cd_produto,
											:ls_cd_situacao_tributaria,
											:ll_qt_vendida,
											:ldc_vl_preco_unitario,
											:ldc_pc_desconto_tabela,
											:ldc_vl_preco_praticado,
											:ldc_pc_icms,
											:ldc_pc_comissao_extra,
											:ldc_pc_comissao_normal,
											:ls_id_alteracao_preco,
											:ls_id_restricao_convenio,
											:ls_id_comissionado,
											:ll_qt_pontos_clube_i,
											:ls_id_cancelado,
											:ls_cd_cst_origem,
											:ls_cd_cst_tributacao,
											:ll_cd_promocao_sos,
											:ls_nm_promocao_sos,
											:ls_de_tipo_promocao,
											:ldc_vl_preco_unitario_fiscal,
											:ll_nr_sequencial,
											:ls_cd_cst_pis,
											:ls_cd_cst_cofins,
											:ll_nr_campanha,
											:ll_cd_desc_progressivo_extra,
											:ldc_pc_red_bc_icms_efetivo,
											:ldc_vl_bc_icms_efetivo,
											:ldc_pc_icms_efetivo,
											:ldc_vl_icms_efetivo,
											:ldc_vl_bc_icms_st_retido,
											:ldc_vl_icms_st_retido,
											:ldc_pc_st_retido,
											:ldc_vl_icms_retido,
											:ls_cd_beneficio,
											:ll_nr_item,
											:ll_cd_promocao_sap,
											:ls_nr_cartao,
											:ldc_vl_base_calculo,
											:ldc_pc_desconto_drogaria,
											:ldc_pc_desconto_unimed,
											:ldc_pc_desconto_nf;
											
				If SQLCA.sqlcode = -1 Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao recuperar as informa$$HEX2$$e700f500$$ENDHEX$$es do cursor: " + sqlca.sqlerrtext, StopSign!)
					Return
				End If							
											
			LOOP
			
			CLOSE lcu_Notas;			
		
			ldt_Movimento = RelativeDate(ldt_Movimento, 1)
			ll_contador++
			w_aguarde.uo_progress.of_setprogress(ll_contador)
			
		Loop
		ll_contador =0
		GarbageCollect ()
	
	Next

CATCH (runtimeerror er)   
   MessageBox("Exce$$HEX2$$e700e300$$ENDHEX$$o de Erro", er.GetMessage())
	
finally
	
	Destroy(lds_Filial)
	FileClose (li_Arq)
	Close(w_Aguarde)
	
	If   FileLength(ls_arquivo) = 0 Then
		FileDelete(ls_arquivo) 
	Else	
		If FileExists(ls_Arquivo2) Then
			FileDelete(ls_Arquivo2)
		End If
		FileMove(ls_arquivo,ls_Arquivo2)
	End If
	
end try

MessageBox("Aten$$HEX1$$e700$$ENDHEX$$ao", "O arquivo foi gerado com sucesso.~r~Arquivo: " + ls_Arquivo2)




end subroutine

on w_ge440_gera_base_price.create
int iCurrent
call super::create
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
end on

on w_ge440_gera_base_price.destroy
call super::destroy
destroy(this.cb_1)
end on

event ue_postopen;call super::ue_postopen;DateTime ldh_Atual

If Not gf_Data_Parametro(Ref ldh_Atual) Then Return

ldh_Atual = DateTime(RelativeDate(Date(ldh_Atual), -1))

dw_1.Object.Dh_Inicio		[1] = ldh_Atual
dw_1.Object.Dh_Termino	[1] = ldh_Atual
end event

event open;call super::open;ivb_permite_fechar = false
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge440_gera_base_price
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge440_gera_base_price
integer width = 1541
integer height = 452
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge440_gera_base_price
integer x = 73
integer y = 80
integer width = 1463
integer height = 368
string dataobject = "dw_ge440_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;Long ll_Lojas

String ls_Nulo

SetNull(ls_Nulo)

dw_1.AcceptText()

Choose Case dwo.Name
		
	Case 'id_tipo_base'
		This.Object.id_produtos[1] = 'T'
		is_Produtos = ls_Nulo
		
		This.Object.id_produtos.protect = 1
		
		If Data = 'N' or Data = 'P' or Data = 'A' Then
			This.Object.id_produtos.protect = 0
		End If
				
	Case 'id_filiais'
		
		
		
		If Data = 'C' Then
			
			is_Filiais = ls_Nulo
			
			uo_ge216_filiais uo_filiais
			uo_Filiais = Create uo_ge216_filiais
			
			OpenWithParm(w_ge216_selecao_filiais, uo_Filiais)
			
			ll_Lojas = Message.DoubleParm
			
			If ll_Lojas > 0 Then
				is_filiais = uo_Filiais.ivs_filiais
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma filial foi selecionada.")
			End If
			
			Destroy(uo_Filiais)
		End If
	Case 'id_produtos'
		
		is_produtos = ls_Nulo
		
		If Data = 'L' Then
			wf_lista_produtos()
		End If
		
End Choose
end event

event dw_1::constructor;call super::constructor;// Habilitar a coluna de sele$$HEX2$$e700e300$$ENDHEX$$o (freform)
This.of_SetColSelection(True)
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge440_gera_base_price
integer x = 901
integer y = 484
integer weight = 700
end type

event cb_ok::clicked;call super::clicked;String ls_Filiais, ls_Tipo

Date ldh_Inicio, ldh_Termino

dw_1.AcceptText()

ls_Filiais 			= dw_1.Object.id_filiais		[1]
ldh_Inicio		= dw_1.Object.dh_inicio		[1]
ldh_Termino	= dw_1.Object.dh_termino	[1]
ls_Tipo			= dw_1.Object.id_tipo_base	[1]

If IsNull(ldh_Inicio) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio.")
	dw_1.Event ue_Pos(1, "dh_inicio")
	Return
End If

If IsNull(ldh_Termino) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino.")
	dw_1.Event ue_Pos(1, "dh_termino")
	Return
End If

If ldh_Inicio > ldh_Termino Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a data de t$$HEX1$$e900$$ENDHEX$$rmino.")
	dw_1.Event ue_Pos(1, "dh_termino")
	Return
End If

If ls_Filiais = 'N' Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma ou mais filiais.")
	Return
End If

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a gera$$HEX2$$e700e300$$ENDHEX$$o do arquivo ?", Question!, YesNo!, 2) = 2 Then Return

Choose Case ls_Tipo
	Case 'N'; wf_base_nota(ls_Filiais, ldh_Inicio,  ldh_Termino)
	Case 'P'; wf_base_nota_promocao(ls_Filiais, ldh_Inicio,  ldh_Termino)
	Case 'R'; wf_base_resumida(ls_Filiais, ldh_Inicio,  ldh_Termino)
	Case 'A'; wf_base_antunes(ls_Filiais, ldh_Inicio,  ldh_Termino)
	Case 'S'
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "As categorias est$$HEX1$$e300$$ENDHEX$$o fixas dentro do programa.")
		wf_base_subcategoria(ls_Filiais, ldh_Inicio,  ldh_Termino)
	Case Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tipo de base inv$$HEX1$$e100$$ENDHEX$$lida")
End Choose

end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge440_gera_base_price
integer x = 1253
integer y = 484
end type

type cb_1 from commandbutton within w_ge440_gera_base_price
boolean visible = false
integer x = 256
integer y = 492
integer width = 402
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "none"
end type

event clicked;

				//uo_el101_extracao_dados   lo_Clic
			//	lo_Clic = Create uo_el101_extracao_dados
			//	lo_Clic.of_processa_cargas_clic( )				
			///	Destroy(lo_Clic)


			///	gf_atualiza_data_execucao_tarefa(76, True)					


//
//				uo_el102_atualiza_resumo_disqentrega   lo_Disq
//				lo_Disq = Create uo_el102_atualiza_resumo_disqentrega
//				lo_Disq.of_gera_dados_disq_entrega( )
//				Destroy(lo_Disq)
//				gf_atualiza_data_execucao_tarefa(80, True)			
//
//			
//			
		////	uo_el021_rappi lo_Rappi_Loja
			///	lo_Rappi_Loja	= Create uo_el021_rappi
		//		lo_Rappi_Loja.of_gera_dados_rapp()
		///		Destroy lo_Rappi_Loja
//



//String ls_Log
//uo_el100_sap_cliente	lo_Sap_Cliente
//
//Try
//	lo_Sap_Cliente	= Create uo_el100_sap_cliente
//	lo_Sap_Cliente.of_retorna_codigo_sap()
//	
////	lo_Sap_Cliente.of_retorna_codigo_sap('05630000395', '94884757904', ls_Log)
//		
//	
//Finally
//	Destroy(lo_Sap_Cliente)
//End Try

end event

