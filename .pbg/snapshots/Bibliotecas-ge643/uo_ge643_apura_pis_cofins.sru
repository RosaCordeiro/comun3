HA$PBExportHeader$uo_ge643_apura_pis_cofins.sru
forward
global type uo_ge643_apura_pis_cofins from nonvisualobject
end type
end forward

global type uo_ge643_apura_pis_cofins from nonvisualobject
end type
global uo_ge643_apura_pis_cofins uo_ge643_apura_pis_cofins

type variables
dc_uo_transacao itr_base_historico
end variables

forward prototypes
public function boolean of_processa_nota (date pdt_movimento, long pl_filial, ref string ps_log)
public subroutine of_processa_antigo_nao_usar (date pdt_inicial, date pdt_final, long pl_filial)
public function boolean of_processa (date pdt_inicial, date pdt_final, long pl_filial)
public subroutine of_processa_nao_usar ()
public function boolean of_transforma_excel (string ps_nm_arquivo)
public function boolean of_gera_planilha_completo (string ps_ano_mes, ref string ps_log)
public function boolean of_gera_planilha_resumo (string ps_ano_mes, ref string ps_log)
public function boolean of_processa_individual (string ps_ano_mes, ref string ps_log)
end prototypes

public function boolean of_processa_nota (date pdt_movimento, long pl_filial, ref string ps_log);Long ll_Linha, ll_Linhas, ll_Filial
Long ll_cd_produto, ll_nr_sequencial, ll_cd_natureza_operacao, ll_nr_classificacao_fiscal,  ll_nf_ecf 
Long ll_nr_nf,ll_nr_operacao_ecf, ll_nr_coo_ecf, ll_qt_vendida

String ls_ano_mes, ls_de_especie, ls_de_serie, ls_de_produto, ls_id_pis_cofins_prod, ls_cd_cst_origem, ls_cd_cst_pis    
String ls_cd_unidade_federacao, ls_cd_cst_cofins, ls_de_chave_acesso, ls_nr_serie_ecf,  ls_nr_serie_mfd_ecf, ls_cd_cst_tributacao            

Decimal ldc_vl_total_bruto, ldc_vl_total_liquido,   ldc_vl_bc_pis, ldc_vl_pis, ldc_pc_icms_atual, ldc_pc_fcp_atual, ldc_vl_base_credito_pis, ldc_vl_credito_pis     
Decimal ldc_vl_bc_cofins, ldc_vl_cofins,  ldc_vl_bc_icms, ldc_pc_icms,ldc_pc_fcp,  ldc_vl_icms, ldc_vl_bc_icms_efetivo,   ldc_pc_icms_efetivo, ldc_vl_icms_efetivo 
Decimal ldc_vl_base_credito_cofins, ldc_vl_credito_cofins

Date ldh_Movto_Fim

dc_uo_ds_base lds

try
	lds = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject("ds_ge643_lista_vendas", False) Then 
		ps_log = "Erro ao mudar a data window [ds_ge643_lista_vendas]."
		Return False
	End If
	
	// Acrecenta mais um dia porque no SQL foi considerado dh_movimento < data_fim
	ldh_Movto_Fim = RelativeDate(pdt_movimento, 1)
	
	ll_Linhas = lds.retrieve(pl_filial, pdt_movimento, ldh_Movto_Fim) 

	If ll_Linhas = -1 Then
		ps_log = "Erro ao recuperar os dados da [ds_ge643_lista_vendas]."
		Return False
	End If
	
	if not isvalid(itr_base_historico) Then
		itr_base_historico = create dc_uo_transacao
		
		If Not gf_conecta_banco_historico(ref itr_base_historico, ref ps_log) Then return false
		
	End if
	
	w_aguarde_3.uo_progress_2.of_setstart()
	
	w_Aguarde_3.uo_progress_2.of_setmax(ll_Linhas)
	
	w_Aguarde_3.st_3.text = "Itens das notas ..."
	
	For ll_Linha = 1 To ll_Linhas
		
		w_Aguarde_3.st_4.text = String(ll_Linha) + " de " + String(ll_Linhas)
		
		ls_ano_mes 					= lds.Object.ano_mes					[ll_Linha]
		ls_de_especie 					= lds.Object.de_especie					[ll_Linha]
		ls_de_serie						= lds.Object.de_serie						[ll_Linha]
		ll_cd_produto					= lds.Object.cd_produto					[ll_Linha]
		ll_nr_sequencial 				= lds.Object.nr_sequencial				[ll_Linha]
		ls_de_produto					= lds.Object.de_produto					[ll_Linha]
		ll_cd_natureza_operacao		= long(lds.Object.cd_natureza_operacao[ll_Linha])
		ls_id_pis_cofins_prod			= lds.Object.id_pis_cofins_prod		[ll_Linha]
		ll_nr_classificacao_fiscal 		= lds.Object.nr_classificacao_fiscal	[ll_Linha]
		ldc_vl_total_bruto 				= lds.Object.vl_total_bruto				[ll_Linha]
		ldc_vl_total_liquido 			= lds.Object.vl_total_liquido				[ll_Linha]
		ls_cd_unidade_federacao 	= lds.Object.cd_unidade_federacao	[ll_Linha]	
		ll_nr_nf							= lds.Object.nr_nf							[ll_Linha]	
		ll_qt_vendida					= lds.Object.qt_vendida					[ll_Linha]	
		ls_cd_cst_origem				= lds.Object.cd_cst_origem				[ll_Linha]	
		ls_cd_cst_tributacao			= lds.Object.cd_cst_tributacao			[ll_Linha]	
		ldc_vl_bc_icms					= lds.Object.vl_bc_icms					[ll_Linha]	
		ldc_pc_icms						= lds.Object.pc_icms						[ll_Linha]	
		ldc_pc_fcp 						= lds.Object.pc_fcp						[ll_Linha]	
		ldc_vl_icms						= lds.Object.vl_icms						[ll_Linha]	
		ls_cd_cst_pis					= lds.Object.cd_cst_pis					[ll_Linha]	
		ldc_vl_bc_pis					= lds.Object.vl_bc_pis					[ll_Linha]	
		ldc_vl_pis						= lds.Object.vl_pis							[ll_Linha]	
		ls_cd_cst_cofins 				= lds.Object.cd_cst_cofins				[ll_Linha]	
		ldc_vl_bc_cofins				= lds.Object.vl_bc_cofins					[ll_Linha]	
		ldc_vl_cofins					= lds.Object.vl_cofins						[ll_Linha]	
		ldc_vl_bc_icms_efetivo		= lds.Object.vl_bc_icms_efetivo		[ll_Linha]	
		ldc_vl_icms_efetivo			= lds.Object.vl_icms_efetivo				[ll_Linha]	
		ls_de_chave_acesso			= lds.Object.de_chave_acesso			[ll_Linha]	
		ll_nf_ecf							= lds.Object.nf_ecf						[ll_Linha]	
		ll_nr_operacao_ecf 			= lds.Object.nr_operacao_ecf			[ll_Linha]	
		ll_nr_coo_ecf					= lds.Object.nr_coo_ecf					[ll_Linha]	
		ls_nr_serie_ecf 				= lds.Object.nr_serie_ecf				[ll_Linha]	
		ls_nr_serie_mfd_ecf 			= lds.Object.nr_serie_mfd_ecf			[ll_Linha]	
		ldc_pc_icms_atual 			= lds.Object.pc_icms_atual				[ll_Linha]	
		ldc_pc_fcp_atual				= lds.Object.pc_fcp_atual				[ll_Linha]	
		
		SetNull(ldc_vl_credito_pis)
		SetNull(ldc_vl_credito_cofins)
		SetNull(ldc_vl_base_credito_cofins)
		SetNull(ldc_vl_base_credito_pis)
		
		If ls_cd_cst_pis = '01' or ls_id_pis_cofins_prod = 'TRIBUTADA' Then
			
			// Vendas realizadas com produtos sujeitos a ICMS ST (CFOP 5.405 e 6.405) de produtos sujeitos a tributa$$HEX2$$e700e300$$ENDHEX$$o de PIS/COFINS (CST PIS/COFINS=$$HEX1$$1920$$ENDHEX$$01$$HEX1$$1920$$ENDHEX$$ ou tributa$$HEX2$$e700e300$$ENDHEX$$o/lista PIS = $$HEX1$$1820$$ENDHEX$$T$$HEX1$$1920$$ENDHEX$$)
			If (ll_cd_natureza_operacao = 5405 or ll_cd_natureza_operacao = 6405) Then
				
				//Itens sujeitos a ICMS ST (5405/6405)
				//Nesses itens o valor de ICMS j$$HEX1$$e100$$ENDHEX$$ foi retido anteriormente, na nota de entrada (compra/transfer$$HEX1$$ea00$$ENDHEX$$ncia). Por$$HEX1$$e900$$ENDHEX$$m como a Clamed possui os sistemas de ressarcimento de ICMS, o valor retido na entrada $$HEX1$$e900$$ENDHEX$$ ajustado conforme o valor efetivado na venda. Devido a isso, o valor de ICMS a ser retirado da base do PIS/COFINS ser$$HEX1$$e100$$ENDHEX$$ o valor Efetivo (VL_ICMS_EFETIVO). 
				//[CR$$HEX1$$c900$$ENDHEX$$DITO PIS] 	= ROUND( [VALOR ICMS EFETIVO] * 0.0165, 2)
				//[CR$$HEX1$$c900$$ENDHEX$$DITO COFINS] 	= ROUND( [VALOR ICMS EFETIVO] * 0.076, 2)
				
				ldc_vl_base_credito_cofins	= ldc_vl_icms_efetivo
				ldc_vl_base_credito_pis		= ldc_vl_icms_efetivo
				ldc_vl_credito_pis 				= round(ldc_vl_icms_efetivo * 0.0165, 2)
				ldc_vl_credito_cofins			= round(ldc_vl_icms_efetivo * 0.076, 2)
				
			End If
			
			// Vendas realizadas com produtos sujeitos a ICMS Normal (CFOP 5.102 e 6.102 e CST=00) que sejam sujeitos a PIS/COFINS (CST PIS/COFINS = 01 ou lista PIS = T).
			If (ll_cd_natureza_operacao = 5102 or ll_cd_natureza_operacao = 6102)  and ls_cd_cst_tributacao = '00' Then
				
				//Itens sujeitos a ICMS Normal (5102/6102 com CST=00)
				//Nesses itens o ICMS $$HEX1$$e900$$ENDHEX$$ cobrado na venda atrav$$HEX1$$e900$$ENDHEX$$s do valor praticado, ent$$HEX1$$e300$$ENDHEX$$o para obter o valor de ICMS a ser descontado da base de PIS/COFINS ser$$HEX1$$e100$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio calcular o ICMS:
	
				//[BASE ICMS]    = ROUND( QT_VENDIDA * VL_PRECO_PRATICADO * (1 $$HEX1$$1320$$ENDHEX$$ NF_VENDA.PC_DESCONTO /100), 2)
				//[VALOR ICMS] = ROUND( [BASE ICMS] * PC_ICMS / 100, 2)
	
				//[CR$$HEX1$$c900$$ENDHEX$$DITO PIS] 	= ROUND( [VALOR ICMS] * 0.0165, 2)
				//[CR$$HEX1$$c900$$ENDHEX$$DITO COFINS] 	= ROUND( [VALOR ICMS] * 0.076, 2)

				ldc_vl_base_credito_cofins	= ldc_vl_icms
				ldc_vl_base_credito_pis		= ldc_vl_icms
				ldc_vl_credito_pis 				= round(ldc_vl_icms * 0.0165, 2)
				ldc_vl_credito_cofins			= round(ldc_vl_icms * 0.076, 2)			
				
			End If
			
		End If
	
		
		INSERT INTO credito_pis_cofins  ( ano_mes,   
           cd_filial,   
           de_especie,   
           de_serie,   
           cd_produto,   
           nr_sequencial,   
           de_produto,   
           cd_natureza_operacao,   
           id_lista_pis_cofins,   
           nr_classificacao_fiscal,   
           vl_total_bruto,   
           vl_total_liquido,   
           dh_movimentacao_caixa,   
           cd_unidade_federacao,   
           nr_nf,   
           qt_vendida,   
           cd_cst_origem,   
           cd_cst_icms,   
           cd_cst_pis,   
           vl_bc_pis,   
           vl_pis,   
           cd_cst_cofins,   
           vl_bc_cofins,   
           vl_cofins,   
           vl_bc_icms,   
           pc_icms,   
           pc_fcp,   
           vl_icms,   
           vl_bc_icms_efetivo,   
           pc_icms_efetivo,   
           vl_icms_efetivo,   
           de_chave_acesso,   
           nf_ecf,   
           nr_operacao_ecf,   
           nr_coo_ecf,   
           nr_serie_ecf,   
           nr_serie_mfd_ecf,   
           pc_icms_atual,   
           pc_fcp_atual,   
           vl_base_credito_pis,   
           vl_credito_pis,   
           vl_base_credito_cofins,   
           vl_credito_cofins )  
  VALUES ( :ls_ano_mes,   
           :pl_filial,   
           :ls_de_especie,   
           :ls_de_serie,   
           :ll_cd_produto,   
           :ll_nr_sequencial,   
           :ls_de_produto,   
           :ll_cd_natureza_operacao,   
           :ls_id_pis_cofins_prod,   
           :ll_nr_classificacao_fiscal,   
           :ldc_vl_total_bruto,   
           :ldc_vl_total_liquido,   
           :pdt_movimento,   
           :ls_cd_unidade_federacao,   
           :ll_nr_nf,   
           :ll_qt_vendida,   
           :ls_cd_cst_origem,   
           :ls_cd_cst_tributacao,   
           :ls_cd_cst_pis,   
           :ldc_vl_bc_pis,   
           :ldc_vl_pis,   
           :ls_cd_cst_cofins,   
           :ldc_vl_bc_cofins,   
           :ldc_vl_cofins,   
           :ldc_vl_bc_icms,   
           :ldc_pc_icms,   
           :ldc_pc_fcp,   
           :ldc_vl_icms,   
           :ldc_vl_bc_icms_efetivo,   
           :ldc_pc_icms_efetivo,   
           :ldc_vl_icms_efetivo,   
           :ls_de_chave_acesso,   
           :ll_nf_ecf,   
           :ll_nr_operacao_ecf,   
           :ll_nr_coo_ecf,   
           :ls_nr_serie_ecf,   
           :ls_nr_serie_mfd_ecf,   
           :ldc_pc_icms_atual,   
           :ldc_pc_fcp_atual,   
           :ldc_vl_base_credito_pis,   
           :ldc_vl_credito_pis,   
           :ldc_vl_base_credito_cofins,   
           :ldc_vl_credito_cofins ) 
		Using itr_base_historico;
		
		If itr_base_historico.SqlCode = - 1 Then
			ps_log =  "Erro na inclus$$HEX1$$e300$$ENDHEX$$o do registro na tabela [credito_pis_cofins]. " + itr_base_historico.SqlErrText
			Return False
		End If 
		
		w_aguarde_3.uo_progress_2.of_setprogress(ll_Linha)
	Next 

catch ( runtimeerror  lo_rte )
	ps_log = "Erro ao recuperar os dados da [ds_ge643_lista_vendas]. Erro: " +lo_rte.GetMessage()
	Return False	
finally
	
	destroy lds
end try

Return True
end function

public subroutine of_processa_antigo_nao_usar (date pdt_inicial, date pdt_final, long pl_filial);Boolean lb_Erro = False

String ls_Log

Long ll_Linha, ll_Linhas, ll_Filial

Date ldh_Movto

dc_uo_ds_base lds

try
	lds = Create dc_uo_ds_base
	
	// Lista todas as filiais que tiveram venda no per$$HEX1$$ed00$$ENDHEX$$odo
	If Not lds.of_ChangeDataObject("ds_ge643_lista_filiais", False) Then 
		ls_Log = "Erro ao mudar a data window [ds_ge643_lista_filiais]."
		Return 
	End If
	
	ll_Linhas = lds.retrieve(pdt_inicial,  pdt_final)
	
	If ll_Linhas = -1 Then
		ls_Log = "Erro ao recuperar a lista de filiais."
		Return
	End If
	
	If ll_Linhas = 0 Then Return
	
	Open(w_Aguarde_3)
	
	w_Aguarde_3.uo_progress.of_setmax(ll_Linhas)
	
	If ll_Linhas >= 10 Then
		ll_Linhas = 10
	End If
	
	For ll_Linha = 1 To ll_Linhas
		
		ll_Filial = lds.Object.cd_filial[ll_Linha]
		
		ldh_Movto = pdt_inicial
		
		do while ldh_Movto <= pdt_final
			
			// Carrega as vendas
			If Not This.of_processa_nota(ldh_Movto, ll_filial, Ref ls_Log) Then
				SqlCa.of_Rollback()
				Return 
			End If	
			
			SqlCa.of_Commit()
					
			ldh_Movto = RelativeDate(ldh_Movto, 1)
		Loop
		
		w_aguarde_3.uo_progress.of_setprogress(ll_Linha)
	Next 
		
finally
	destroy lds

	If IsValid(w_Aguarde_3) Then Close(w_Aguarde_3)
	
	If Not IsNull(ls_Log)  and Trim(ls_Log) <> '' Then 	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Log, StopSign!)
end try
end subroutine

public function boolean of_processa (date pdt_inicial, date pdt_final, long pl_filial);Date ldh_Movto

Long ll_filial, ll_Linhas, ll_Linha

String ls_Log

dc_uo_ds_base lds

try
	
	lds = Create dc_uo_ds_base
	
	// Lista todas as filiais que tiveram venda no per$$HEX1$$ed00$$ENDHEX$$odo
	If Not lds.of_ChangeDataObject("ds_ge643_lista_filiais", False) Then 
		ls_Log = "Erro ao mudar a data window [ds_ge643_lista_filiais]."
		Return False
	End If
	
	Open(w_Aguarde_3)
	
	if not isvalid(itr_base_historico) Then
		itr_base_historico = create dc_uo_transacao
	End if
	
	If Not gf_conecta_banco_historico(ref itr_base_historico, ref ls_Log) Then return false
	
	ldh_Movto = pdt_inicial
		
	do while ldh_Movto <= pdt_final
		
		w_Aguarde_3.Title = "Movimento: " + String(ldh_Movto, "dd/mm/yyyy") + " - [" + String (pdt_inicial, "dd/mm/yyyy") + " - " + String (pdt_final, "dd/mm/yyyy") + "]"
		
		// Criar par$$HEX1$$e200$$ENDHEX$$metro na PARAMETRO_GERAL - DATA_CREDITO_PIS_COFINS = DD/MM/YYYY
		// Se ldh_Movto for menor ou igual a data do par$$HEX1$$e200$$ENDHEX$$metro ent$$HEX1$$e300$$ENDHEX$$o continue
		
		// Lista as filiais que tiveram venda no dia	
		ll_Linhas = lds.retrieve(ldh_Movto,  ldh_Movto)
		
		If ll_Linhas = -1 Then
			ls_Log = "Erro ao recuperar a lista de filiais."
			Return False
		End If
		
		//Desenvolvimento
//		If ll_Linhas >= 3 Then
//			ll_Linhas = 3
//		End If
		
		w_aguarde_3.uo_progress.of_setstart()
		
		w_Aguarde_3.uo_progress.of_setmax(ll_Linhas)
		
		w_Aguarde_3.st_1.text = "Filiais ..." 
		
		For ll_Linha = 1 To ll_Linhas
		
			ll_Filial = lds.Object.cd_filial[ll_Linha]
			
			w_Aguarde_3.st_2.text = "Filial: "  + String(ll_Filial, "000") + " - " + String(ll_Linha) + " de " + String(ll_Linhas)
			
			// Carrega as vendas
			If Not This.of_processa_nota(ldh_Movto, ll_filial, Ref ls_Log) Then
				itr_base_historico.of_Rollback()
				Return False
			End If	
		
			w_aguarde_3.uo_progress.of_setprogress(ll_Linha)
		Next
		
		// Commit por dia
		itr_base_historico.of_Commit()
		
		// UPDATE PARA COLOCAR O PARAMETRO IGUAL A ldh_Movto
				
		ldh_Movto = RelativeDate(ldh_Movto, 1)
	Loop
		
finally
	destroy lds

	itr_base_historico.of_disconnect()
	destroy itr_base_historico

	If IsValid(w_Aguarde_3) Then Close(w_Aguarde_3)
	
	If Not IsNull(ls_Log)  and Trim(ls_Log) <> '' Then 	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Log, StopSign!)
end try

Return True
end function

public subroutine of_processa_nao_usar ();String ls_Ano_Mes

Date ldh_Inicio, ldh_Fim

select top 1 ano_mes Into :ls_Ano_Mes
from dbo.credito_pis_cofins_geracao
where dh_geracao is null
order by ano_mes
Using SqlCa;

Choose Case SqlCa.SqlCode 
	Case 0 
	Case 100
		Return
	Case -1
		Sqlca.of_MsgDbError ("Erro ao localizar o per$$HEX1$$ed00$$ENDHEX$$odo para a gera$$HEX2$$e700e300$$ENDHEX$$o")
		Return 
End Choose

do while not IsNull(ls_Ano_Mes) or trim(ls_Ano_Mes) <> ''
	 
	ldh_Inicio = Date(ls_Ano_Mes + "/01")
	 
	ldh_Fim = gf_retorna_ultimo_dia_mes(ldh_Inicio)
	
	update dbo.credito_pis_cofins_geracao
	set dh_inicio = getdate()
	where ano_mes = :ls_Ano_Mes
	Using SqlCa;
	
	If SqlCa.Sqlcode = - 1 Then
		SqlCa.of_RollBack();
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao atualizar o registro na tabela - dh_inicio - [credito_pis_cofins_geracao].")
		Return
	End If
	
	SqlCa.of_Commit();
	
	If This.of_processa(ldh_Inicio, ldh_Fim, 0 ) Then
		
		update dbo.credito_pis_cofins_geracao
		set dh_fim = getdate()
		where ano_mes = :ls_Ano_Mes
		Using SqlCa;
		
		If SqlCa.Sqlcode = - 1 Then
			SqlCa.of_RollBack();
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao atualizar o registro na tabela - dh_fim - [credito_pis_cofins_geracao].")
			Return
		End If
		
		SqlCa.of_Commit();
		
	End If
	
	select top 1 ano_mes Into :ls_Ano_Mes
	from dbo.credito_pis_cofins_geracao
	where dh_geracao is null
	order by ano_mes
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode 
		Case 0 
		Case 100
			Return
		Case -1
			Sqlca.of_MsgDbError ("Erro ao localizar o per$$HEX1$$ed00$$ENDHEX$$odo para a gera$$HEX2$$e700e300$$ENDHEX$$o")
			Return 
	End Choose
	
loop

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Terminou")


Return
end subroutine

public function boolean of_transforma_excel (string ps_nm_arquivo);oleobject lole_book,lole_workbook,lole_sheet

lole_book = create oleobject
lole_workbook = create oleobject
lole_sheet = create oleobject

// Abrindo objeto na nova Instance. 
lole_book.ConnectToNewObject("excel.application") 
lole_book.Visible = False 
lole_book.workBooks.Open(ps_Nm_Arquivo)

lole_workbook = lole_book.ActiveWorkBook

// Recuperando a referencia da WorkSheet 
lole_sheet = lole_book.ActiveWorkBook.WorkSheets(1)

ps_Nm_Arquivo = gf_replace(ps_Nm_Arquivo, '.txt', '.xlsx',1)

lole_book.ActiveWorkBook.SaveAs( ps_Nm_Arquivo, 51, "" )

// Disconectando e fechando 
Try
	lole_sheet.DisconnectObject( )
	lole_workbook.Close()
	lole_workbook.DisconnectObject( )
	lole_book.application.quit()
	lole_book.DisconnectObject() 
Finally
	If IsValid(lole_sheet) Then Destroy(lole_sheet)
	If IsValid(lole_workbook) Then Destroy(lole_workbook) 
	If IsValid(lole_book) Then Destroy(lole_book)
	
     GarbageCollect()
End Try

Return True
end function

public function boolean of_gera_planilha_completo (string ps_ano_mes, ref string ps_log);long ll_Cd_filial, ll_for, ll_linhas, ll_count=0, ll_mes
string ls_ano_mes, ls_nm_arquivo, ls_erro, ls_nm_planilha, ls_diretorio
datetime ldh_geracao

dc_uo_ds_base lds_filiais
dc_uo_ds_base lds_dados, lds_dados_total
dc_uo_transacao ltr_hist

Try

	select dh_fim 
	Into :ldh_geracao
	from dbo.credito_pis_cofins_geracao
	where ano_mes = :ps_ano_mes
	Using SqlCa;

	if sqlca.sqlcode = -1 then
		ps_log = 'Erro ao consultar a tabela [credito_pis_cofins_geracao]: ' + sqlca.sqlerrtext
		Return false
	ENd if

	if isnull(ldh_geracao) or date(ldh_geracao) = date('01/01/1900') Then
		ps_log = 'Primeiramente ser$$HEX1$$e100$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio gerar os dados na base Hist$$HEX1$$f300$$ENDHEX$$rica para o per$$HEX1$$ed00$$ENDHEX$$odo ' + ps_ano_mes + '.'
		return false
	ENd if

	getfolder('Selecione o diret$$HEX1$$f300$$ENDHEX$$rio onde a planilha ser$$HEX1$$e100$$ENDHEX$$ salva:', ls_diretorio)

	if isnull(ls_diretorio) or ls_diretorio = '' Then
		Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Selecione um diret$$HEX1$$f300$$ENDHEX$$rio v$$HEX1$$e100$$ENDHEX$$lido.')
		return false
	End if
	
	ls_nm_arquivo = ls_diretorio + '\PIS_COFINS_' + gf_replace(ps_ano_mes,'/','_',1) 
	ls_nm_planilha = ls_diretorio + '\PIS_COFINS_' + gf_replace(ps_ano_mes,'/','_',1) + '_1' + '.xlsx'

	ltr_hist = create dc_uo_transacao
	
	If Not gf_conecta_banco_historico(ref ltr_hist, ref ls_erro) Then 
		ps_log = 'Erro ao tentar conectar na base historico: ' + ls_erro
		return false
	End if
	
	lds_filiais = create dc_uo_ds_base
	lds_filiais.dataobject = 'ds_ge643_completo_filial'
	
	
	lds_dados = create dc_uo_ds_base
	lds_dados.dataobject = 'ds_ge643_completo'
	
	lds_filiais.settransobject( ltr_hist)
	lds_dados.settransobject( ltr_hist)
	
	//Primeiro busca todas as filiais:
	ll_linhas = lds_filiais.retrieve(ps_ano_mes)
	
	ll_count=0
	
	open(w_aguarde)
	
	w_aguarde.uo_progress.of_setmax(ll_linhas)
	
	w_aguarde.Title = 'Extraindo os dados do per$$HEX1$$ed00$$ENDHEX$$odo ' + ps_ano_mes + '...'

	for ll_for = 1 to ll_linhas
		
		ll_Cd_filial = lds_filiais.object.cd_filial[ll_for]
		
		if not isvalid(lds_dados) Then
			lds_dados = create dc_uo_ds_base
			lds_dados.dataobject = 'ds_ge643_completo'
			lds_dados.settransobject( ltr_hist)
		End if
		
		if not isvalid(lds_dados_total) Then
			lds_dados_total = create dc_uo_ds_base
			lds_dados_total.dataobject = 'ds_ge643_completo'
			lds_dados_total.settransobject( ltr_hist)
		End if
		
		//Executa o relatorio filial por filial:
		lds_dados.retrieve( ll_cd_filial, ps_ano_mes )
		
		lds_dados.rowscopy( 1, lds_dados.rowcount(), primary!, lds_dados_total, 1, primary!)
		
		//Tratamento para nao ultrapassar o maximo de linhas permitidas do excel:
		if lds_dados_total.rowcount() > 500000 Then
			ll_count++
			ls_nm_arquivo = ls_nm_arquivo + '_' + string(ll_count) + ".txt"
			lds_dados_total.saveas( ls_nm_arquivo, TEXT!, True)
			lds_dados_total.reset()
			
			destroy(lds_dados_total)
			
			GarbageCollect ( )
			
			this.of_transforma_excel( ls_nm_arquivo )
			
			filedelete(ls_nm_arquivo)
			
		End if
		
		destroy(lds_dados)
			
		GarbageCollect ( )
		
		w_aguarde.uo_progress.of_setprogress(ll_for)
		
	Next
	
	if isvalid(lds_dados_total.object) Then
		if lds_dados_total.rowcount() > 0 Then
			
			w_aguarde.Title = 'Gerando planilha Excel...'
			
			ll_count++
			ls_nm_arquivo = ls_nm_arquivo + '_' + string(ll_count) + ".txt"
			lds_dados_total.saveas( ls_nm_arquivo, TEXT!, True)
			lds_dados_total.reset()
			
			destroy(lds_dados_total)
			
			GarbageCollect ( )
			
			this.of_transforma_excel( ls_nm_arquivo )
			
			filedelete(ls_nm_arquivo)
			
		End if
	End if

	ps_log = 'Arquivo gerado com sucesso: ' + ls_nm_planilha

Finally 
	
	if isvalid(w_aguarde) then Close(w_aguarde)
	
	if isvalid(ltr_hist) Then
		if ltr_hist.of_isconnected( ) Then
			ltr_hist.of_disconnect( )
		End if
	ENd if
	
End Try

return true
end function

public function boolean of_gera_planilha_resumo (string ps_ano_mes, ref string ps_log);
string ls_erro, ls_nm_arquivo, ls_diretorio, ls_nm_planilha
datetime ldh_geracao
dc_uo_transacao ltr_hist
long ll_count

Try
	
	select dh_fim 
	Into :ldh_geracao
	from dbo.credito_pis_cofins_geracao
	where ano_mes = :ps_ano_mes
	Using SqlCa;

	if sqlca.sqlcode = -1 then
		ps_log = 'Erro ao consultar a tabela [credito_pis_cofins_geracao]: ' + sqlca.sqlerrtext
		Return false
	ENd if

	if isnull(ldh_geracao) or date(ldh_geracao) = date('01/01/1900') Then
		ps_log = 'Primeiramente ser$$HEX1$$e100$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio gerar os dados na base Hist$$HEX1$$f300$$ENDHEX$$rica para o per$$HEX1$$ed00$$ENDHEX$$odo ' + ps_ano_mes
		return false
	ENd if
	
	getfolder('Selecione o diret$$HEX1$$f300$$ENDHEX$$rio onde a planilha ser$$HEX1$$e100$$ENDHEX$$ salva:', ls_diretorio)
	
	if isnull(ls_diretorio) or ls_diretorio = '' Then
		ps_log = 'Selecione um diret$$HEX1$$f300$$ENDHEX$$rio v$$HEX1$$e100$$ENDHEX$$lido.'
		return false
	End if
	
	ls_nm_arquivo = ls_diretorio + '\PIS_COFINS_' + gf_replace(ps_ano_mes,'/','_',1) + '_resumo.txt'
	ls_nm_planilha = ls_diretorio + '\PIS_COFINS_' + gf_replace(ps_ano_mes,'/','_',1) + '_resumo.xlsx'
	
	ltr_hist = create dc_uo_transacao	
		
	gf_conecta_banco_historico(ref ltr_hist, ref ls_erro)
	
	dc_uo_ds_base lds_dados
	
	lds_dados = create dc_uo_ds_base
	
	lds_dados.of_changedataobject( 'ds_ge643_resumo' )
	lds_dados.settransobject( ltr_hist )
	
	ll_count = lds_dados.retrieve(ps_ano_mes) 
	
	if ll_count > 0 Then
	
		lds_dados.saveas( ls_nm_arquivo, TEXT!, True)
		lds_dados.reset()
		
		destroy(lds_dados)
		
		GarbageCollect ( )
		
		this.of_transforma_excel( ls_nm_arquivo )
		
		filedelete(ls_nm_arquivo)
		
	Elseif ll_count = 0 Then
		ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foram econtrados registros para o seguinte per$$HEX1$$ed00$$ENDHEX$$odo: ' + ps_ano_mes
		return false
	Else
		ps_log = 'Erro ao consultar a base hist$$HEX1$$f300$$ENDHEX$$rico: ' + ltr_hist.sqlerrtext
		return false
	ENd if
	
	if FileExists(ls_nm_planilha) Then 
		ps_log = 'Arquivo gerado com sucesso:~n~n' + ls_nm_planilha
	End if
	
Finally
	if isvalid(ltr_hist) Then
		if ltr_hist.of_isconnected( ) Then
			ltr_hist.of_disconnect( )
		End if
	ENd if
End Try

return true
end function

public function boolean of_processa_individual (string ps_ano_mes, ref string ps_log);Date ldh_Inicio, ldh_Fim, ldh_geracao

Try

	If IsNull(ps_ano_mes) or trim(ps_ano_mes) = '' Then
		ps_log = "Par$$HEX1$$e200$$ENDHEX$$metro inv$$HEX1$$e100$$ENDHEX$$lido."
		Return False
	End If
	
	select dh_fim 
	Into :ldh_geracao
	from dbo.credito_pis_cofins_geracao
	where ano_mes =:ps_ano_mes
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode 
		Case 0 
			
			If Not IsNull(ldh_geracao) Then
				ps_log = "Per$$HEX1$$ed00$$ENDHEX$$odo [" + ps_ano_mes +  "] j$$HEX1$$e100$$ENDHEX$$ foi gerado em: " + String(ldh_geracao, "dd/mm/yyyy hh:mm:ss") + "."
				Return False
			End If
			
			update dbo.credito_pis_cofins_geracao
			set dh_inicio = getdate()
			where ano_mes = :ps_ano_mes
			Using SqlCa;
			
			If SqlCa.Sqlcode = - 1 Then
				SqlCa.of_RollBack();
				ps_log = "Erro ao atualizar o registro na tabela - dh_inicio - [credito_pis_cofins_geracao]: " + sqlca.sqlerrtext
				Return False
			End If
				
			SqlCa.of_Commit();
			
			ldh_Inicio = Date(ps_ano_mes + "/01")
			 
			ldh_Fim = gf_retorna_ultimo_dia_mes(ldh_Inicio)
			
			If This.of_processa(ldh_Inicio, ldh_Fim, 0 ) Then
			
				update dbo.credito_pis_cofins_geracao
				set dh_fim = getdate()
				where ano_mes = :ps_ano_mes
				Using SqlCa;
				
				If SqlCa.Sqlcode = - 1 Then
					SqlCa.of_RollBack();
					ps_log = "Erro ao atualizar o registro na tabela - dh_fim - [credito_pis_cofins_geracao]: " + sqlca.sqlerrtext
					Return False
				End If
				
				SqlCa.of_Commit();
				
			End If
			
		Case 100
			
			Insert into credito_pis_cofins_geracao(ano_mes)
			values(:ps_ano_mes);
			
			If SqlCa.Sqlcode = - 1 Then
				SqlCa.of_RollBack();
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao inserir registro na tabela [credito_pis_cofins_geracao]: " + sqlca.sqlerrtext)
				Return False
			End If
				
			SqlCa.of_Commit();
			
			//Chama novamente a funcao para agora sim entar no processo de calculo:
			this.of_processa_individual( ps_ano_mes, ref ps_log)
				
		Case -1
			ps_log = "Erro ao localizar o per$$HEX1$$ed00$$ENDHEX$$odo para a gera$$HEX2$$e700e300$$ENDHEX$$o: " + sqlca.sqlerrtext
			Return False
	End Choose
	
Finally	
	
End Try

Return True
end function

on uo_ge643_apura_pis_cofins.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge643_apura_pis_cofins.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;/////////
//////// ATEN$$HEX2$$c700c300$$ENDHEX$$O --- AS TABELAS: CREDITO_PIS_COFINS e CREDITO_PIS_COFINS_GERACAO FORAM EXPORTADA VIA BCP PARA O 
/////// BANCO HISTORICO_2024

///// SER$$HEX1$$c100$$ENDHEX$$ NECESS$$HEX1$$c100$$ENDHEX$$RIO PARA CRIAR UMA CONEX$$HEX1$$c300$$ENDHEX$$O PARA A BASE HISTORICA

// CODIGO ABAIXO FOI TESTADO, S$$HEX1$$d300$$ENDHEX$$ FALTA ALTERAR AQUI NO OBJETO...
/*
1 - Criar uma conex$$HEX1$$e300$$ENDHEX$$o com o banco historico_2024.

Obs.: O objeto j$$HEX1$$e100$$ENDHEX$$ foi preparado para conectar no banco historico_2024, S:\Sistemas_PB12\Comuns\Bibliotecas\PBD\classe_conexao.pbd

dc_uo_transacao lo_Transact

Try
Try
lo_Transact = Create dc_uo_transacao

lo_Transact.ivs_database = "SYBASE"

If Not lo_Transact.of_Connect('historico_2024', "") Then
//as_Erro =  "Erro ao criar uma nova transa$$HEX2$$e700e300$$ENDHEX$$o, fun$$HEX2$$e700e300$$ENDHEX$$o 'gf_ge259_proximo_volume_wms'."
// Return False
End If
Catch ( runtimeerror  lo_rte )
// as_Erro =  "Erro ao localizado ao localizar o pr$$HEX1$$f300$$ENDHEX$$ximo pedido distribuidora', fun$$HEX2$$e700e300$$ENDHEX$$o 'gf_ge259_proximo_volume_wms'."
//lo_Transact.of_RollBack()
// Return False
End Try

Finally
lo_Transact.of_Disconnect()

Destroy(lo_Transact)
End Try

//Return True


*/
end event

