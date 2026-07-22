HA$PBExportHeader$w_ge325_rel_dinamico_vendas_item.srw
forward
global type w_ge325_rel_dinamico_vendas_item from dc_w_selecao_lista_dinamica_relatorio
end type
type cb_1 from commandbutton within w_ge325_rel_dinamico_vendas_item
end type
end forward

global type w_ge325_rel_dinamico_vendas_item from dc_w_selecao_lista_dinamica_relatorio
integer width = 4466
integer height = 2108
string title = "GE325 - Relat$$HEX1$$f300$$ENDHEX$$rio Din$$HEX1$$e200$$ENDHEX$$mico de Vendas (Por Item Nota)"
cb_1 cb_1
end type
global w_ge325_rel_dinamico_vendas_item w_ge325_rel_dinamico_vendas_item

type variables
uo_filial 						ivo_filial
uo_natureza_operacao 	ivo_cfop
uo_produto					ivo_produto
uo_cliente					ivo_cliente
uo_convenio					ivo_convenio
uo_vendedor				ivo_vendedor
uo_usuario					ivo_usuario

end variables

forward prototypes
public subroutine wf_insere_padrao ()
public subroutine wf_relatorio_todas_filiais ()
public subroutine wf_relatorio_todas_filiais_2 ()
public subroutine wf_relatorio_todas_filiais_3 ()
public subroutine wf_relatorio_todas_filiais_4 ()
public function boolean wf_transformar_excel (string ps_nm_arquivo)
public subroutine wf_salva_base_historico ()
public subroutine wf_relatorio_resumo ()
end prototypes

public subroutine wf_insere_padrao ();DataWindowChild	ldwc_Child

/*Grupo Produto*/
ldwc_Child  = dw_1.of_InsertRow_DDDW("cd_grupo" )			
ldwc_Child.SetItem(1, "cd_grupo", "")
ldwc_Child.SetItem(1, "de_grupo", "TODOS")
dw_1.Object.cd_grupo[1] = ""

/*Lei Gen$$HEX1$$e900$$ENDHEX$$rico*/
ldwc_Child  = dw_1.of_InsertRow_DDDW("id_lei_generico" )			
ldwc_Child.SetItem(1, "id_lei_generico", "")
ldwc_Child.SetItem(1, "de_lei_generico", "TODAS")
dw_1.Object.id_lei_generico[1] = ""

/*UF Filial*/
ldwc_Child  = dw_1.of_InsertRow_DDDW("cd_uf" )			
ldwc_Child.SetItem(1, "cd_unidade_federacao", "")
ldwc_Child.SetItem(1, "nm_unidade_federacao", "TODAS")
dw_1.Object.cd_uf[1] = ""

/* Tipo Canal de Vendas */
ldwc_Child  = dw_1.of_InsertRow_DDDW("id_tipo_canal" )
ldwc_Child.SetItem(1, "id_tipo_canal_venda", "")
ldwc_Child.SetItem(1, "de_tipo_canal_venda",  "TODOS")
dw_1.Object.id_canal_venda[1] = ""

/* Canal de Vendas */
ldwc_Child  = dw_1.of_InsertRow_DDDW("id_canal_venda" )
ldwc_Child.SetItem(1, "cd_canal_venda", "")
ldwc_Child.SetItem(1, "de_canal_venda",  "TODOS")
dw_1.Object.id_canal_venda[1] = ""

/* Modo de Entrega */
ldwc_Child  = dw_1.of_InsertRow_DDDW("cd_modo_entrega" )
ldwc_Child.SetItem(1, "cd_modo_entrega", "")
ldwc_Child.SetItem(1, "de_modo_entrega",  "TODOS")
dw_1.Object.cd_modo_entrega[1] = ""

/* $$HEX1$$c100$$ENDHEX$$rea de Vendas*/
ldwc_Child  = dw_1.of_InsertRow_DDDW("id_area_vendas" )
ldwc_Child.SetItem(1, "rede", "TODAS")
ldwc_Child.SetItem(1, "vl_parametro",   "")
dw_1.Object.Id_Area_Vendas[1] = ""

/* CST */
ldwc_Child  = dw_1.of_InsertRow_DDDW("cd_cst_tributacao" )
ldwc_Child.SetItem(1, "de_tributacao_icms", "TODAS")
ldwc_Child.SetItem(1, "cd_cst_tributacao",   "")
dw_1.Object.cd_cst_tributacao[1] = ""
end subroutine

public subroutine wf_relatorio_todas_filiais ();long ll_for1, ll_linhas1,ll_count=0, ll_mes, ll_for2, ll_existe
string ls_vl_parametro, ls_erro
datetime ldt_ini, ldt_fim


long ll_cd_filial
string ls_cd_cfop
string ls_id_pis_cofins_prd
long ll_nr_classificacao_fiscal
long ll_cd_produto
string ls_de_produto
decimal{2} ldc_vl_total_bruto
decimal{2} ldc_vl_total_liquido
datetime ldh_movimentacao_caixa
string ls_cd_unidade_federacao
long ll_nr_nf
long ll_qt_vendida
string ls_cd_cst_origem
decimal{2} ldc_vl_base_icms
decimal{2} ldc_pc_icms
decimal{2} ldc_vl_icms
decimal{2} ldc_vl_fcp
decimal{2} ldc_vl_bc_pis
decimal{2} ldc_vl_pis
decimal{2} ldc_vl_bc_cofins
decimal{2} ldc_vl_cofins
decimal{2} ldc_vl_bc_icms_efetivo
decimal{2} ldc_pc_icms_efetivo
decimal{2} ldc_vl_icms_efetivo
string ls_de_chave_acesso
decimal{2} ldc_pc_icms_atual
decimal{2} ldc_pc_fcp_atual
decimal{2} ldc_pc_icms_mes
decimal{2} ldc_pc_fcp_mes

dc_uo_ds_base lds_filiais
dc_uo_ds_base lds_dados, lds_dados_total

lds_filiais = create dc_uo_ds_base
lds_filiais.of_changedataobject( 'ds_ge325_rel_filial' )

lds_dados = create dc_uo_ds_base
lds_dados.of_changedataobject( 'ds_ge325_rel_dinamico_filial' )

lds_dados_total = create dc_uo_ds_base
lds_dados_total.of_changedataobject( 'ds_ge325_rel_dinamico_filial' )

Try

	Do 
	
		select vl_parametro 
		into :ls_vl_parametro
		from parametro_geral
		where cd_parametro = 'DH_ATUALIZACAO_RELATORIO_FISCAL_VENDAS';
		
		if date(ls_vl_parametro) >= date('01/09/2024') Then Exit
		
		ldt_ini = datetime(date(ls_vl_parametro),time('00:00:00'))
		
		ls_vl_parametro = String( relativedate(date(ldt_ini),35), '01/mm/yyyy')
		
		ldt_fim = datetime( relativedate(date(ls_vl_parametro),-1) ,time('23:59:59'))
		
		update parametro_geral 
		set vl_parametro = :ls_vl_parametro
		where cd_parametro = 'DH_ATUALIZACAO_RELATORIO_FISCAL_VENDAS';
		
		Commit;
		
		//Primeiro busca todas as filiais:
		ll_linhas1 = lds_filiais.retrieve(ldt_ini, ldt_fim)
		
		open(w_aguarde)
		
		w_aguarde.uo_progress.of_setmax(ll_linhas1)
		
		w_aguarde.Title = 'Data = ' + string(date(ldt_ini),'dd/mm/yyyy')
	
		for ll_for1 = 1 to ll_linhas1
			
			ll_Cd_filial = lds_filiais.object.cd_filial[ll_for1]
			
			//Executa o relatorio filial por filial:
			lds_dados.retrieve( ll_cd_filial, ldt_ini, ldt_fim )
			
			for ll_for2 = 1 to lds_dados.rowcount()
			
				ls_cd_cfop = lds_dados.object.cd_cfop[ll_for2]
				ls_id_pis_cofins_prd = lds_dados.object.id_pis_cofins_prd[ll_for2]
				ll_nr_classificacao_fiscal = lds_dados.object.nr_classificacao_fiscal[ll_for2]
				ll_cd_produto = lds_dados.object.cd_produto[ll_for2]
				ls_de_produto = lds_dados.object.de_produto[ll_for2]
				ldc_vl_total_bruto = lds_dados.object.vl_total_bruto[ll_for2]
				ldc_vl_total_liquido = lds_dados.object.vl_total_liquido[ll_for2]
				ldh_movimentacao_caixa = lds_dados.object.dh_movimentacao_caixa[ll_for2]
				ls_cd_unidade_federacao = lds_dados.object.cd_unidade_federacao[ll_for2]
				ll_nr_nf = lds_dados.object.nr_nf[ll_for2]
				ll_qt_vendida = lds_dados.object.qt_vendida[ll_for2]
				ls_cd_cst_origem = lds_dados.object.cd_cst_origem[ll_for2]
				ldc_vl_base_icms = lds_dados.object.vl_base_icms[ll_for2]
				ldc_pc_icms = lds_dados.object.pc_icms[ll_for2]
				ldc_vl_icms = lds_dados.object.vl_icms[ll_for2]
				ldc_vl_fcp = lds_dados.object.vl_fcp[ll_for2]
				ldc_vl_bc_pis = lds_dados.object.vl_bc_pis[ll_for2]
				ldc_vl_pis = lds_dados.object.vl_pis[ll_for2]
				ldc_vl_bc_cofins = lds_dados.object.vl_bc_cofins[ll_for2]
				ldc_vl_cofins = lds_dados.object.vl_cofins[ll_for2]
				ldc_vl_bc_icms_efetivo = lds_dados.object.vl_bc_icms_efetivo[ll_for2]
				ldc_pc_icms_efetivo = lds_dados.object.pc_icms_efetivo[ll_for2]
				ldc_vl_icms_efetivo = lds_dados.object.vl_icms_efetivo[ll_for2]
				ls_de_chave_acesso = lds_dados.object.de_chave_acesso[ll_for2]
				ldc_pc_icms_atual = lds_dados.object.pc_icms_atual[ll_for2]
				ldc_pc_fcp_atual = lds_dados.object.pc_fcp_atual[ll_for2]
				ldc_pc_icms_mes = lds_dados.object.pc_icms_mes[ll_for2]
				ldc_pc_fcp_mes = lds_dados.object.pc_fcp_mes[ll_for2]
				
				ll_existe = 0
				
				select count(*)
				into :ll_existe
				from a_nf_venda_cfop
				where cd_filial = :ll_cd_filial
				and cd_produto = :ll_cd_produto
				and nr_nf = :ll_nr_nf;
				
				if ll_existe = 0 or isnull(ll_existe) Then
			
					insert into a_nf_venda_cfop (
						cd_filial,
						cd_cfop,
						id_pis_cofins_prd,
						nr_classificacao_fiscal,
						cd_produto,
						de_produto,
						vl_total_bruto,
						vl_total_liquido,
						dh_movimentacao_caixa,
						cd_unidade_federacao,
						nr_nf,
						qt_vendida,
						cd_cst_origem,
						vl_base_icms,
						pc_icms,
						vl_icms,
						vl_fcp,
						vl_bc_pis,
						vl_pis,
						vl_bc_cofins,
						vl_cofins,
						vl_bc_icms_efetivo,
						pc_icms_efetivo,
						vl_icms_efetivo,
						de_chave_acesso,
						pc_icms_atual,
						pc_fcp_atual,
						pc_icms_mes,
						pc_fcp_mes)
					Values( :ll_cd_filial,
						:ls_cd_cfop,
						:ls_id_pis_cofins_prd,
						:ll_nr_classificacao_fiscal,
						:ll_cd_produto,
						:ls_de_produto,
						:ldc_vl_total_bruto,
						:ldc_vl_total_liquido,
						:ldh_movimentacao_caixa,
						:ls_cd_unidade_federacao,
						:ll_nr_nf,
						:ll_qt_vendida,
						:ls_cd_cst_origem,
						:ldc_vl_base_icms,
						:ldc_pc_icms,
						:ldc_vl_icms,
						:ldc_vl_fcp,
						:ldc_vl_bc_pis,
						:ldc_vl_pis,
						:ldc_vl_bc_cofins,
						:ldc_vl_cofins,
						:ldc_vl_bc_icms_efetivo,
						:ldc_pc_icms_efetivo,
						:ldc_vl_icms_efetivo,
						:ls_de_chave_acesso,
						:ldc_pc_icms_atual,
						:ldc_pc_fcp_atual,
						:ldc_pc_icms_mes,
						:ldc_pc_fcp_mes
					);
				
					if sqlca.sqlcode = -1 then
						ls_erro = sqlca.sqlerrtext
						sqlca.of_rollback()
						messagebox('Atencao', ls_erro)
						Return
					ENd if
				
					ll_count++
					
					if ll_count >= 1000 Then
						ll_count = 0
						
						SQLCA.of_commit( )
					ENd if
					
				End if
			
			Next
			
			w_aguarde.uo_progress.of_setprogress(ll_for1)
			
		Next
		
		SQLCA.of_commit( )
	
		ll_count = 0
	
	Loop While date(ls_vl_parametro) < date('01/09/2024')
	
	Close(w_aguarde)
	
	messagebox('Atencao','Relatorio gerado com sucesso')
	
Finally
	if isvalid(w_aguarde) then Close(w_aguarde)
End Try
end subroutine

public subroutine wf_relatorio_todas_filiais_2 ();long ll_Cd_filial, ll_for1, ll_linhas1,ll_count=0, ll_mes
string ls_vl_parametro, ls_ano_mes, ls_nm_arquivo, ls_erro
datetime ldt_ini, ldt_fim

dc_uo_ds_base lds_filiais
dc_uo_ds_base lds_dados, lds_dados_total
dc_uo_transacao ltr_hist

Try

Do 
	
	ltr_hist = create dc_uo_transacao
	
	If Not gf_conecta_banco_historico(ref ltr_hist, ref ls_erro) Then 
		messagebox('Erro', 'Erro ao tentar conectar na base historico: ' + ls_erro)
		return 
	End if
	
	lds_filiais = create dc_uo_ds_base
	//lds_filiais.of_changedataobject( 'ds_ge325_rel_filial' )
	lds_filiais.dataobject = 'ds_ge325_rel_filial_hist'
	
	
	lds_dados = create dc_uo_ds_base
	//lds_dados.of_changedataobject( 'ds_ge325_rel_dinamico_filial' )
	lds_dados.dataobject = 'ds_ge325_rel_dinamico_filial_hist'
	
	lds_filiais.settransobject( ltr_hist)
	lds_dados.settransobject( ltr_hist)

	select vl_parametro 
	into :ls_vl_parametro
	from parametro_geral
	where cd_parametro = 'DH_ATUALIZACAO_RELATORIO_FISCAL_VENDAS';
	
	if date(ls_vl_parametro) >= date('01/04/2017') Then Exit
	
	ldt_ini = datetime(date(ls_vl_parametro),time('00:00:00'))
	
	ls_vl_parametro = String( relativedate(date(ldt_ini),35), '01/mm/yyyy')
	
	ldt_fim = datetime( relativedate(date(ls_vl_parametro),-1) ,time('23:59:59'))
	
	ls_ano_mes = String( date(ldt_ini), 'yyyy/mm' )
	
	update parametro_geral 
	set vl_parametro = :ls_vl_parametro
	where cd_parametro = 'DH_ATUALIZACAO_RELATORIO_FISCAL_VENDAS';
	
	Commit;
	
	//Primeiro busca todas as filiais:
	ll_linhas1 = lds_filiais.retrieve(ls_ano_mes)
	
	ll_count=0
	
	open(w_aguarde)
	
	w_aguarde.uo_progress.of_setmax(ll_linhas1)
	
	w_aguarde.Title = 'Data = ' + string(date(ldt_ini),'dd/mm/yyyy')

	for ll_for1 = 1 to ll_linhas1
		
		ll_Cd_filial = lds_filiais.object.cd_filial[ll_for1]
		
		if not isvalid(lds_dados) Then
			lds_dados = create dc_uo_ds_base
			lds_dados.dataobject = 'ds_ge325_rel_dinamico_filial_hist'
			lds_dados.settransobject( ltr_hist)
		End if
		
		if not isvalid(lds_dados_total) Then
			lds_dados_total = create dc_uo_ds_base
			lds_dados_total.dataobject = 'ds_ge325_rel_dinamico_filial_hist'
			lds_dados_total.settransobject( ltr_hist)
		End if
		
		//Executa o relatorio filial por filial:
		lds_dados.retrieve( ll_cd_filial, ls_ano_mes )
		
		lds_dados.rowscopy( 1, lds_dados.rowcount(), primary!, lds_dados_total, 1, primary!)
		
		//Tratamento para nao ultrapassar o maximo de linhas permitidas do excel:
		if lds_dados_total.rowcount() > 500000 Then
			ll_count++
			ls_nm_arquivo = "C:\Teste\Relatorio_Fiscal\relatorio_vendas_" + String(year(date(ldt_ini))) + String(date(ldt_ini),'mm') + '_' + string(ll_count) +".txt"
			lds_dados_total.saveas( ls_nm_arquivo, TEXT!, True)
			lds_dados_total.reset()
			
			destroy(lds_dados_total)
			
			GarbageCollect ( )
			
			wf_transformar_excel(ls_nm_arquivo)
			
			filedelete(ls_nm_arquivo)
			
		End if
		
		destroy(lds_dados)
			
		GarbageCollect ( )
		
		w_aguarde.uo_progress.of_setprogress(ll_for1)
		
	Next
	
	if isvalid(lds_dados_total.object) Then
		if lds_dados_total.rowcount() > 0 Then
			ll_count++
			ls_nm_arquivo = "C:\Teste\Relatorio_Fiscal\relatorio_vendas_" + String(year(date(ldt_ini))) + String(date(ldt_ini),'mm') + '_' + string(ll_count) +".txt"
			lds_dados_total.saveas( ls_nm_arquivo, TEXT!, True)
			lds_dados_total.reset()
			
			destroy(lds_dados_total)
			
			GarbageCollect ( )
			
			wf_transformar_excel(ls_nm_arquivo)
			
			filedelete(ls_nm_arquivo)
			
		End if
	End if
	
	Close(w_aguarde)

Loop While date(ls_vl_parametro) < date('01/12/2024')

Finally 
	
	if ltr_hist.of_isconnected( ) Then
		ltr_hist.of_disconnect( )
	End if
	
End Try

messagebox('Atencao','Relatorio gerado com sucesso')
end subroutine

public subroutine wf_relatorio_todas_filiais_3 ();long ll_Cd_filial, ll_for1, ll_linhas1,ll_count=1, ll_mes
string ls_vl_parametro
datetime ldt_ini, ldt_fim

dc_uo_ds_base lds_filiais
dc_uo_ds_base lds_dados, lds_dados_total

lds_filiais = create dc_uo_ds_base
lds_filiais.of_changedataobject( 'ds_ge325_rel_filial' )

lds_dados_total = create dc_uo_ds_base
lds_dados_total.of_changedataobject( 'ds_ge325_rel_dinamico_filial' )

lds_dados = create dc_uo_ds_base
lds_dados.of_changedataobject( 'ds_ge325_rel_dinamico_filial' )

ldt_ini = Datetime(date('01/11/2024'),time('00:00'))

//Do 

//	select vl_parametro 
//	into :ls_vl_parametro
//	from parametro_geral
//	where cd_parametro = 'DH_ATUALIZACAO_RELATORIO_FISCAL_VENDAS';
//	
//	if date(ls_vl_parametro) >= date('01/09/2024') Then Exit
//	
//	ldt_ini = datetime(date(ls_vl_parametro),time('00:00:00'))
//	
//	ls_vl_parametro = String( relativedate(date(ldt_ini),35), '01/mm/yyyy')
//	
//	ldt_fim = datetime( relativedate(date(ls_vl_parametro),-1) ,time('23:59:59'))
//	
//	update parametro_geral 
//	set vl_parametro = :ls_vl_parametro
//	where cd_parametro = 'DH_ATUALIZACAO_RELATORIO_FISCAL_VENDAS';
//	
//	Commit;
	
//	Primeiro busca todas as filiais:
	
	
//	ll_linhas1 = lds_filiais.retrieve(ldt_ini, ldt_fim )
	ll_linhas1 = lds_dados_total.retrieve()
	
	open(w_aguarde)
//	
//	w_aguarde.uo_progress.of_setmax(ll_linhas1)
//	
//	w_aguarde.Title = 'Data = ' + string(date(ldt_ini),'dd/mm/yyyy')
//
//	for ll_for1 = 1 to ll_linhas1
//		
//		ll_Cd_filial = lds_filiais.object.cd_filial[ll_for1]
//		
//		//Executa o relatorio filial por filial:
//		lds_dados.retrieve( ll_cd_filial )
//		
//		lds_dados.rowscopy( 1, lds_dados.rowcount(), primary!, lds_dados_total, 1, primary!)
//		
//		//Tratamento para nao ultrapassar o maximo de linhas permitidas do excel:
//		if lds_dados_total.rowcount() > 300000 Then
//			ll_count++
//			lds_dados_total.saveas( "C:\Teste\relatorio_vendas_" + String(year(date(ldt_ini))) + String(month(date(ldt_ini))) + '_' + string(ll_count) +".xlsx", XLSX!, True)
//			lds_dados_total.reset()
//			
//			lds_dados_total.reset()
//			GarbageCollect ( )
//		End if
//		
//		w_aguarde.uo_progress.of_setprogress(ll_for1)
//		
//	Next
	
	if lds_dados_total.rowcount() > 0 Then
		lds_dados_total.saveas( "C:\Teste\relatorio_vendas_" + String(year(date(ldt_ini))) + String(month(date(ldt_ini))) + '_' + string(ll_count) +".xlsx", XLSX!, True)
	End if
	
	GarbageCollect ( )
	
	Close(w_aguarde)

//Loop While date(ls_vl_parametro) < date('01/09/2024')

messagebox('Atencao','Relatorio gerado com sucesso')
end subroutine

public subroutine wf_relatorio_todas_filiais_4 ();long ll_Cd_filial, ll_for1, ll_linhas1,ll_count=15, ll_mes, ll_ini, ll_fim
string ls_vl_parametro
datetime ldt_ini, ldt_fim

dc_uo_ds_base lds_filiais
dc_uo_ds_base lds_dados, lds_dados_total

lds_filiais = create dc_uo_ds_base
lds_filiais.of_changedataobject( 'ds_ge325_rel_filial' )

lds_dados_total = create dc_uo_ds_base
lds_dados_total.of_changedataobject( 'ds_ge325_rel_dinamico_filial' )

lds_dados = create dc_uo_ds_base
lds_dados.of_changedataobject( 'ds_ge325_rel_dinamico_filial' )

ldt_ini = Datetime(date('01/08/2024'),time('00:00'))

open(w_aguarde)
	
//Executa o relatorio:
ll_linhas1 = lds_dados.retrieve()

open(w_aguarde)

w_aguarde.uo_progress.of_setmax(ll_linhas1)

w_aguarde.Title = 'Data = ' + string(date(ldt_ini),'dd/mm/yyyy')

ll_ini = 1
ll_fim = 500000

Do 

	lds_dados_total.reset()

	lds_dados.rowscopy( ll_ini, ll_fim, primary!, lds_dados_total, 1, primary!)

	ll_count++
	lds_dados_total.saveas( "C:\Teste\relatorio_vendas_" + String(year(date(ldt_ini))) + String(month(date(ldt_ini))) + '_' + string(ll_count) +".xlsx", XLSX!, True)
	
	GarbageCollect ( )
	
	ll_ini = ll_fim + 1
	ll_fim = ll_fim + ll_fim

Loop While lds_dados_total.rowcount() = 500000

Close(w_aguarde)

messagebox('Atencao','Relatorio gerado com sucesso')
end subroutine

public function boolean wf_transformar_excel (string ps_nm_arquivo);oleobject lole_book,lole_workbook,lole_sheet

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

public subroutine wf_salva_base_historico ();long ll_Cd_filial, ll_for1, ll_linhas1,ll_count=0, ll_mes, ll_for2, ll_linhas2, ll_count_commit=0
string ls_vl_parametro, ls_ano_mes, ls_nm_arquivo
datetime ldt_ini, ldt_fim

boolean lb_ok = false

long ll_nr_nf
string ls_de_especie
string ls_de_serie
long ll_cd_produto
long ll_nr_sequencial
string ls_de_produto
long ll_cd_natureza_operacao
string ls_id_lista_pis_cofins
long ll_nr_classificacao_fiscal
decimal ld_vl_total_bruto
decimal ld_vl_total_liquido
datetime ldt_dh_movimentacao_caixa
string ls_cd_unidade_federacao
long ll_qt_vendida
string ls_cd_cst_origem
string ls_cd_cst_icms
string ls_cd_cst_pis
decimal ld_vl_bc_pis
decimal ld_vl_pis
string ls_cd_cst_cofins
decimal ld_vl_bc_cofins
decimal ld_vl_cofins
decimal ld_vl_bc_icms
decimal ld_pc_icms
decimal ld_pc_fcp
decimal ld_vl_icms
decimal ld_vl_bc_icms_efetivo
decimal ld_pc_icms_efetivo
decimal ld_vl_icms_efetivo
string ls_de_chave_acesso
long ll_nf_ecf
long ll_nr_operacao_ecf
long ll_nr_coo_ecf
string ls_nr_serie_ecf
string ls_nr_serie_mfd_ecf
decimal ld_pc_icms_atual
decimal ld_pc_fcp_atual
decimal ld_vl_base_credito_pis
decimal ld_vl_credito_pis
decimal ld_vl_base_credito_cofins
decimal ld_vl_credito_cofins
datetime ldt_dh_inclusao
decimal ld_vl_icms_efetivo_calc
string ls_erro

dc_uo_ds_base lds_filiais
dc_uo_ds_base lds_dados, lds_dados_total

dc_uo_transacao ltr_hist

Try

	ltr_hist = create dc_uo_transacao
	
	lds_filiais = create dc_uo_ds_base
	lds_filiais.of_changedataobject( 'ds_ge325_rel_filial' )
	
	lds_dados = create dc_uo_ds_base
	lds_dados.of_changedataobject( 'ds_ge325_rel_dinamico_filial' )
	
	gf_conecta_banco_historico(ref ltr_hist, ref ls_erro)
	
	Do 
	
		select vl_parametro 
		into :ls_vl_parametro
		from parametro_geral
		where cd_parametro = 'DH_ATUALIZACAO_RELATORIO_FISCAL_VENDAS';
		
		if date(ls_vl_parametro) >= date('01/12/2024') Then Exit
		
		ldt_ini = datetime(date(ls_vl_parametro),time('00:00:00'))
		
		ls_vl_parametro = String( relativedate(date(ldt_ini),35), '01/mm/yyyy')
		
		ldt_fim = datetime( relativedate(date(ls_vl_parametro),-1) ,time('23:59:59'))
		
		ls_ano_mes = String( date(ldt_ini), 'yyyy/mm' )
		
		update parametro_geral 
		set vl_parametro = :ls_vl_parametro
		where cd_parametro = 'DH_ATUALIZACAO_RELATORIO_FISCAL_VENDAS';
		
		Commit;
		
		//Primeiro busca todas as filiais:
		ll_linhas1 = lds_filiais.retrieve(ls_ano_mes)
		
		ll_count=0
		
		open(w_aguarde)
		
		w_aguarde.uo_progress.of_setmax(ll_linhas1)
		
		w_aguarde.Title = 'Data = ' + string(date(ldt_ini),'dd/mm/yyyy')
	
		for ll_for1 = 1 to ll_linhas1
			
			ll_Cd_filial = lds_filiais.object.cd_filial[ll_for1]
			
			if not isvalid(lds_dados) Then
				lds_dados = create dc_uo_ds_base
				lds_dados.of_changedataobject( 'ds_ge325_rel_dinamico_filial' )
			End if
			
			if not isvalid(lds_dados_total) Then
				lds_dados_total = create dc_uo_ds_base
				lds_dados_total.of_changedataobject( 'ds_ge325_rel_dinamico_filial' )
			End if
			
			//Executa o relatorio filial por filial:
			ll_linhas2 = lds_dados.retrieve( ll_cd_filial, ls_ano_mes )
			
			for ll_for2 = 1 to ll_linhas2
				
				ls_ano_mes = lds_dados.object.ano_mes[ll_for2]
				ll_cd_filial = lds_dados.object.cd_filial[ll_for2]
				ll_nr_nf = lds_dados.object.nr_nf[ll_for2]
				ls_de_especie = lds_dados.object.de_especie[ll_for2]
				ls_de_serie = lds_dados.object.de_serie[ll_for2]
				ll_cd_produto = lds_dados.object.cd_produto[ll_for2]
				ll_nr_sequencial = lds_dados.object.nr_sequencial[ll_for2]
				ls_de_produto = lds_dados.object.de_produto[ll_for2]
				ll_cd_natureza_operacao = lds_dados.object.cd_natureza_operacao[ll_for2]
				ls_id_lista_pis_cofins = lds_dados.object.id_lista_pis_cofins[ll_for2]
				ll_nr_classificacao_fiscal = lds_dados.object.nr_classificacao_fiscal[ll_for2]
				ld_vl_total_bruto = lds_dados.object.vl_total_bruto[ll_for2]
				ld_vl_total_liquido = lds_dados.object.vl_total_liquido[ll_for2]
				ldt_dh_movimentacao_caixa = lds_dados.object.dh_movimentacao_caixa[ll_for2]
				ls_cd_unidade_federacao = lds_dados.object.cd_unidade_federacao[ll_for2]
				ll_qt_vendida = lds_dados.object.qt_vendida[ll_for2]
				ls_cd_cst_origem = lds_dados.object.cd_cst_origem[ll_for2]
				ls_cd_cst_icms = lds_dados.object.cd_cst_icms[ll_for2]
				ls_cd_cst_pis = lds_dados.object.cd_cst_pis[ll_for2]
				ld_vl_bc_pis = lds_dados.object.vl_bc_pis[ll_for2]
				ld_vl_pis = lds_dados.object.vl_pis[ll_for2]
				ls_cd_cst_cofins = lds_dados.object.cd_cst_cofins[ll_for2]
				ld_vl_bc_cofins = lds_dados.object.vl_bc_cofins[ll_for2]
				ld_vl_cofins = lds_dados.object.vl_cofins[ll_for2]
				ld_vl_bc_icms = lds_dados.object.vl_bc_icms[ll_for2]
				ld_pc_icms = lds_dados.object.pc_icms[ll_for2]
				ld_pc_fcp = lds_dados.object.pc_fcp[ll_for2]
				ld_vl_icms = lds_dados.object.vl_icms[ll_for2]
				ld_vl_bc_icms_efetivo = lds_dados.object.vl_bc_icms_efetivo[ll_for2]
				ld_pc_icms_efetivo = lds_dados.object.pc_icms_efetivo[ll_for2]
				ld_vl_icms_efetivo = lds_dados.object.vl_icms_efetivo[ll_for2]
				ls_de_chave_acesso = lds_dados.object.de_chave_acesso[ll_for2]
				ll_nf_ecf = lds_dados.object.nf_ecf[ll_for2]
				ll_nr_operacao_ecf = lds_dados.object.nr_operacao_ecf[ll_for2]
				ll_nr_coo_ecf = lds_dados.object.nr_coo_ecf[ll_for2]
				ls_nr_serie_ecf = lds_dados.object.nr_serie_ecf[ll_for2]
				ls_nr_serie_mfd_ecf = lds_dados.object.nr_serie_mfd_ecf[ll_for2]
				ld_pc_icms_atual = lds_dados.object.pc_icms_atual[ll_for2]
				ld_pc_fcp_atual = lds_dados.object.pc_fcp_atual[ll_for2]
				ld_vl_base_credito_pis = lds_dados.object.vl_base_credito_pis[ll_for2]
				ld_vl_credito_pis = lds_dados.object.vl_credito_pis[ll_for2]
				ld_vl_base_credito_cofins = lds_dados.object.vl_base_credito_cofins[ll_for2]
				ld_vl_credito_cofins = lds_dados.object.vl_credito_cofins[ll_for2]
				ldt_dh_inclusao = lds_dados.object.dh_inclusao[ll_for2]
				ld_vl_icms_efetivo_calc = lds_dados.object.vl_icms_efetivo_calc[ll_for2]
				
				insert into credito_pis_cofins(ano_mes, cd_filial,
					nr_nf,
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
					vl_credito_cofins,
					dh_inclusao,
					vl_icms_efetivo_calc)
				values(:ls_ano_mes, 
					:ll_cd_filial,
					:ll_nr_nf,
					:ls_de_especie,
					:ls_de_serie,
					:ll_cd_produto,
					:ll_nr_sequencial,
					:ls_de_produto,
					:ll_cd_natureza_operacao,
					:ls_id_lista_pis_cofins,
					:ll_nr_classificacao_fiscal,
					:ld_vl_total_bruto,
					:ld_vl_total_liquido,
					:ldt_dh_movimentacao_caixa,
					:ls_cd_unidade_federacao,
					:ll_qt_vendida,
					:ls_cd_cst_origem,
					:ls_cd_cst_icms,
					:ls_cd_cst_pis,
					:ld_vl_bc_pis,
					:ld_vl_pis,
					:ls_cd_cst_cofins,
					:ld_vl_bc_cofins,
					:ld_vl_cofins,
					:ld_vl_bc_icms,
					:ld_pc_icms,
					:ld_pc_fcp,
					:ld_vl_icms,
					:ld_vl_bc_icms_efetivo,
					:ld_pc_icms_efetivo,
					:ld_vl_icms_efetivo,
					:ls_de_chave_acesso,
					:ll_nf_ecf,
					:ll_nr_operacao_ecf,
					:ll_nr_coo_ecf,
					:ls_nr_serie_ecf,
					:ls_nr_serie_mfd_ecf,
					:ld_pc_icms_atual,
					:ld_pc_fcp_atual,
					:ld_vl_base_credito_pis,
					:ld_vl_credito_pis,
					:ld_vl_base_credito_cofins,
					:ld_vl_credito_cofins,
					:ldt_dh_inclusao,
					:ld_vl_icms_efetivo_calc)
					Using ltr_hist;
				
				if ltr_hist.sqlcode = -1 then
					ls_erro = ltr_hist.sqlerrtext
					ltr_hist.of_rollback( )
					return 
				End if
				
				ll_count_commit++
				If ll_count_commit > 1000 Then
					ll_count_commit = 0
					
					ltr_hist.of_commit( )
				End if
				
			Next
			
			ltr_hist.of_commit( )
			
			destroy(lds_dados)
				
			GarbageCollect ( )
			
			w_aguarde.uo_progress.of_setprogress(ll_for1)
			
		Next
		
		Close(w_aguarde)
	
	Loop While date(ls_vl_parametro) < date('01/12/2024')
	
	lb_ok = True
	
Finally
	if lb_ok = false Then
		messagebox('Atencao',ls_erro)		
	Else
		messagebox('Atencao','Relatorio gerado com sucesso')
	End if
	
End Try

end subroutine

public subroutine wf_relatorio_resumo ();
string ls_erro, ls_nm_arquivo
dc_uo_transacao ltr_hist
long ll_count


	ltr_hist = create dc_uo_transacao
	
	
//	gf_conecta_banco_historico(ref ltr_hist, ref ls_erro)

dc_uo_ds_base lds_dados

lds_dados = create dc_uo_ds_base

lds_dados.of_changedataobject( 'ds_ge325_rel_dinamico_filial_dev' )
//lds_dados.settransobject( ltr_hist )

ll_count = lds_dados.retrieve() 

if ll_count > 0 Then

	ls_nm_arquivo = "C:\Teste\Relatorio_Fiscal\devolucoes_2025_02.txt"
	lds_dados.saveas( ls_nm_arquivo, TEXT!, True)
	lds_dados.reset()
	
	destroy(lds_dados)
	
	GarbageCollect ( )
	
	wf_transformar_excel(ls_nm_arquivo)
	
	filedelete(ls_nm_arquivo)
				
	//ltr_hist.of_disconnect( )
	
ENd if
end subroutine

on w_ge325_rel_dinamico_vendas_item.create
int iCurrent
call super::create
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
end on

on w_ge325_rel_dinamico_vendas_item.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
end on

event ue_preopen;call super::ue_preopen;//Instancia Objetos
ivo_filial			= Create uo_filial
ivo_cfop			= Create uo_natureza_operacao
ivo_produto		= Create uo_produto
ivo_cliente		= Create uo_cliente
ivo_convenio	= Create uo_convenio
ivo_vendedor	= Create uo_vendedor
ivo_usuario		= Create uo_usuario

//Dimensionamento de tela
MaxWidth = 4600
MaxHeight = 9999

//SQL Base para formar o grid
ivs_SQLBase = 'from nf_venda n  '														+ &
					' left join nf_venda_nfe nfe (index pk_nf_venda_nfe) '               + &
					'     on nfe.cd_filial = n.cd_filial+0 '                              + &
					'     and nfe.nr_nf = n.nr_nf+0 '                                     + &
					'     and nfe.de_serie = n.de_serie '                                 + &
					'     and nfe.de_especie = n.de_especie '                             + &
					'inner join item_nf_venda i (index pk_item_nf_venda) '		+ &
					'	on i.cd_filial = n.cd_filial+0 '										+ &
					'	and i.nr_nf = n.nr_nf+0 '											+ &
					'	and i.de_serie = n.de_serie '									+ &
					'	and i.de_especie = n.de_especie '								+ &
					'inner join produto_geral p (index pk_produto_geral) '		+ &
					'	on p.cd_produto = i.cd_produto+0 '							+ &
					'Inner Join filial f (index pk_filial) '									+ &
					'	on f.cd_filial = n.cd_filial+0 '									+ &
					'Inner Join cidade cf (index pk_cidade) '							+ &
					'	on cf.cd_cidade = f.cd_cidade+0 '								+ &
					'Left Outer Join cliente cl (index pk_cliente) '					+ &
					"	on cl.cd_cliente = n.cd_cliente||'' "							+ &
					'Left Outer Join convenio cv (index pk_convenio) '				+ &
					'	on cv.cd_convenio = n.cd_convenio+0 '						+ &
					'Left Outer Join conveniado co (index pk_conveniado) '		+ &
					'	on co.cd_convenio = n.cd_convenio+0 '						+ &
					'  and co.cd_conveniado = n.cd_conveniado '					+ &
					'Left Outer Join item_nf_venda_destino id (index pk_item_nf_venda_destino) '		+ &
					'	on id.cd_filial = i.cd_filial+0 '									+ &
					'	and id.nr_nf = i.nr_nf+0 '										+ &
					'	and id.de_serie = i.de_serie '									+ &
					'	and id.de_especie = i.de_especie '							+ &
					'	and id.cd_produto = i.cd_produto '							+ &
					'	and id.nr_sequencial = i.nr_sequencial '						+ &
					'Left Outer Join condicao_venda_convenio cvc (index pk_condicao_venda_convenio) '		+ &
					'  On cvc.cd_condicao_convenio = n.cd_condicao_convenio '+ &
					'Left Outer Join dependente_conveniado dcv (index pk_dependente_conveniado) '		+ &
					'	on dcv.cd_convenio = n.cd_convenio '						+ &
					'  and dcv.cd_conveniado = n.cd_conveniado '					+ &
					'  and dcv.cd_dependente = n.cd_dependente_conveniado '	+ &
					'Left Outer Join usuario uvv (index pk_usuario) '				+ &
					'	on uvv.nr_matricula = n.nr_matricula_vendedor '			+ &		
					'Left Outer Join usuario uov (index pk_usuario) '				+ &
					'	on uov.nr_matricula = n.nr_matric_operador '				+ &		
					'Left Outer Join usuario uav (index pk_usuario) '				+ &
					'	on uav.nr_matricula = n.nr_matric_alteracao_preco '		+ &		
					'Left Outer Join usuario ulbv (index pk_usuario) '				+ &
					'	on ulbv.nr_matricula = n.nr_matric_liberacao_bloqueio '	+ &		
					'Left Outer Join usuario ulrv (index pk_usuario) '				+ &
					'	on ulrv.nr_matricula = n.nr_matric_liberacao_restricao '	+ &		
					'Left Outer Join usuario ulsv (index pk_usuario) '				+ &
					'	on ulsv.nr_matricula = n.nr_matric_liberacao_senha '	+ &		
					'Left Outer Join usuario ucv (index pk_usuario) '				+ &
					'	on ucv.nr_matricula = n.nr_matricula_cancelamento '	+ &
					'Left Outer Join pedido_ecommerce_auxiliar pea (index pk_pedido_ecommerce_auxiliar) '	+ &
					'	on pea.cd_filial_ecommerce = n.cd_filial_ecommerce '	+ &
					'	and pea.nr_pedido = n.nr_pedido_ecommerce '			+ &
					'Left Outer Join pedido_ecommerce pe (index pk_pedido_ecommerce) '	+ &
					'	on pe.cd_filial_ecommerce = n.cd_filial_ecommerce '		+ &
					'	and pe.nr_pedido = n.nr_pedido_ecommerce '				+ &
					'Left Outer Join historico_produto hp (index pk_historico_produto) '	+ &
					'	on hp.cd_produto = p.cd_produto+0 '							+ &
					"	and hp.dh_historico = cast(cast(year(n.dh_movimentacao_caixa) as varchar)||'/'||cast(month(n.dh_movimentacao_caixa) as varchar)||'/01' as datetime)"	+ &
					'Left Outer Join historico_produto_uf hpu (index pk_historico_produto_uf) '		+ &
					'	on hpu.cd_produto = hp.cd_produto+0 '								+ &
					'	and hpu.dh_historico = hp.dh_historico '								+ &
					'	and hpu.cd_unidade_federacao = cf.cd_unidade_federacao '	+ &
					'Left Outer join subcategoria t (index pk_subcategoria) '				+ &
					"	on t.cd_subcategoria = coalesce(hp.cd_subcategoria, p.cd_subcategoria) "	 + &
					'Left Outer Join categoria c (index pk_categoria) '						+ &
					"	on c.cd_categoria = t.cd_categoria||'' "								+ &
					'Left Outer Join subgrupo s (index pk_subgrupo) '						+ &
					"	on s.cd_subgrupo = c.cd_subgrupo||'' "								+ &
					'Left Outer Join grupo g (index pk_grupo) '								+ &
					"	on g.cd_grupo = s.cd_grupo||'' "										+ &
					/* V$$HEX1$$ed00$$ENDHEX$$nculo com tipo icms atual, para buscar a atual al$$HEX1$$ed00$$ENDHEX$$quota ICMS */+ &
					'Left Outer Join produto_uf pu (index pk_produto_uf) '			+ & 
					'	on pu.cd_produto = p.cd_produto+0 '									+ &
					'	and pu.cd_unidade_federacao = cf.cd_unidade_federacao '		+ &
					'Left Outer Join tipo_icms aicms (index pk_tipo_icms) '			+ & 
					"	on aicms.cd_tipo_icms = pu.cd_tipo_icms "							+ &
					/* Fim V$$HEX1$$ed00$$ENDHEX$$nculo ICMS Atual */												+ &
					"Left Outer Join movimento_estoque me (index idx_nota) "			+ &
					"	on me.cd_filial_movimento = i.cd_filial+0 "							+ &
					"	and me.nr_nf = i.nr_nf+0 "												+ &
					"	and me.de_serie = i.de_serie "											+ &
					"	and me.de_especie = i.de_especie "									+ &
					"	and me.cd_produto = i.cd_produto+0 "								+ &
					"	and coalesce(me.nr_sequencial, 1) = i.nr_sequencial "			+ &
					"Left Outer Join canal_venda cnv (index pk_canal_venda) "			+ &
					" 	on cnv.cd_canal_venda = Upper(case when n.dh_movimentacao_caixa >= '2019/01/01' then coalesce(case when pe.de_canal_compra_vtex in ('app_android', 'app_ios', 'app_android_n', 'app_ios_n') then 'AP' else n.cd_canal_venda end, 'LF') else case when n.nr_pedido_ecommerce > 0 then 'EC'  else case when n.nr_pedido_drogaexpress is not null then 'DE' else 'LF' end end end)"

					
					
//C$$HEX1$$f300$$ENDHEX$$digo da Consulta no SybaseCentral
ivl_Consulta = 8

//N$$HEX1$$e300$$ENDHEX$$o fechar a tela
ivb_permite_fechar = False
end event

event close;call super::close;Destroy(ivo_convenio)
Destroy(ivo_produto)
Destroy(ivo_cliente)
Destroy(ivo_cfop)
Destroy(ivo_filial)

Destroy(ivo_vendedor)
Destroy(ivo_usuario)
end event

event ue_postopen;call super::ue_postopen;dw_1.Object.dt_inicio	[1] = RelativeDate(Today(),-1)
dw_1.Object.dt_fim	[1] = RelativeDate(Today(),-1)

wf_insere_padrao()
end event

type dw_visual from dc_w_selecao_lista_dinamica_relatorio`dw_visual within w_ge325_rel_dinamico_vendas_item
end type

type gb_aux_visual from dc_w_selecao_lista_dinamica_relatorio`gb_aux_visual within w_ge325_rel_dinamico_vendas_item
end type

type gb_2 from dc_w_selecao_lista_dinamica_relatorio`gb_2 within w_ge325_rel_dinamico_vendas_item
integer y = 784
integer width = 4352
integer height = 1120
end type

type gb_1 from dc_w_selecao_lista_dinamica_relatorio`gb_1 within w_ge325_rel_dinamico_vendas_item
integer width = 4357
integer height = 752
end type

type dw_1 from dc_w_selecao_lista_dinamica_relatorio`dw_1 within w_ge325_rel_dinamico_vendas_item
integer width = 4288
integer height = 664
string dataobject = "dw_ge325_selecao"
end type

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	
	This.AcceptText( )
	
	Choose Case This.GetColumnName() 
			
		Case "nm_filial"
			ivo_filial.Of_Localiza_Filial(This.GetText()) 
			
			If ivo_filial.Localizada Then
				  
				This.Object.cd_filial	[1] = ivo_filial.cd_filial
				This.Object.nm_filial	[1] = ivo_filial.nm_fantasia
				
			End If
			
		Case "nm_vendedor"
			ivo_vendedor.Of_Localiza_Vendedor( This.GetText())
			
			If ivo_vendedor.Localizado Then
				  
				This.Object.nr_matric_vendedor	[1] = ivo_vendedor.nr_matricula_vendedor
				This.Object.nm_vendedor			[1] = ivo_vendedor.nm_usuario
				
			End If
			
		Case "nm_usuario"
			ivo_usuario.Of_Localiza_usuario(This.GetText()) 
			
			If ivo_usuario.Localizado Then
				  
				This.Object.nr_matricula	[1] = ivo_usuario.nr_matricula
				This.Object.nm_usuario	[1] = ivo_usuario.nm_usuario
				
			End If
			
		Case "nm_cfop"
			ivo_cfop.of_localiza_natureza(This.GetText())
			
			If ivo_cfop.Localizado Then
				  
				This.Object.cd_cfop	[1] = ivo_cfop.cd_natureza_operacao
				This.Object.nm_cfop	[1] = ivo_cfop.de_natureza_operacao
				
			End If
			
		Case "de_produto"
			ivo_produto.of_localiza_produto(This.GetText())
			
			If ivo_produto.Localizado Then
				  
				This.Object.cd_produto	[1] = ivo_produto.cd_produto
				This.Object.de_produto	[1] = ivo_produto.de_produto+': '+ivo_produto.de_apresentacao_estoque
				
			End If
			
		Case "nm_cliente"
			ivo_cliente.of_localiza_cliente(This.GetText())
			
			If ivo_cliente.Localizado Then
				  
				This.Object.cd_cliente	[1] = ivo_cliente.cd_cliente
				This.Object.nm_cliente	[1] = ivo_cliente.nm_cliente
				
			End If
			
		Case "nm_convenio"
			ivo_convenio.of_localiza_convenio(This.GetText())
			
			If ivo_convenio.Localizado Then
				  
				This.Object.cd_convenio	[1] = ivo_convenio.cd_convenio
				This.Object.nm_convenio[1] = ivo_convenio.nm_razao_social
				
			End If

	End Choose
	
End If
end event

event dw_1::itemchanged;call super::itemchanged;DatawindowChild lvdw_Child

Choose Case dwo.Name
		
	Case "nm_filial"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Filial.nm_fantasia Then
				Return 1
			End If	
		Else			
			ivo_Filial.Of_Inicializa()
			
			This.Object.nm_filial	[1] = ivo_Filial.nm_fantasia
			This.Object.cd_filial	[1] = ivo_Filial.cd_filial
			
		End If	
		
	Case "nm_vendedor"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_vendedor.nm_usuario Then
				Return 1
			End If	
		Else			
			ivo_vendedor.Of_Inicializa()
			
			This.Object.nm_vendedor			[1] = ivo_vendedor.nm_usuario
			This.Object.nr_matric_vendedor	[1] = ivo_vendedor.nr_matricula_vendedor
			
		End If	
		
	Case "nm_usuario"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_usuario.nm_usuario Then
				Return 1
			End If	
		Else
			ivo_usuario.Of_Inicializa()
			
			This.Object.nm_usuario	[1] = ivo_usuario.nm_usuario
			This.Object.nr_matricula	[1] = ivo_usuario.nr_matricula
			
		End If	
		
	Case "nm_cfop"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_cfop.de_natureza_operacao Then
				Return 1
			End If	
		Else			
			ivo_cfop.Of_Inicializa()
			
			This.Object.nm_cfop	[1] = ivo_cfop.de_natureza_operacao
			This.Object.cd_cfop		[1] = ivo_cfop.cd_natureza_operacao
			
		End If	
		
	Case "de_produto"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> (ivo_produto.de_produto+': '+ivo_produto.de_apresentacao_estoque) Then
				Return 1
			End If	
		Else			
			ivo_produto.Of_Inicializa()
			
			This.Object.de_produto	[1] = ivo_produto.de_produto
			This.Object.cd_produto	[1] = ivo_produto.cd_produto
			
		End If	
		
	Case "nm_cliente"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_cliente.nm_cliente Then
				Return 1
			End If	
		Else			
			ivo_cliente.Of_Inicializa()
			
			This.Object.nm_cliente	[1] = ivo_cliente.nm_cliente
			This.Object.cd_cliente	[1] = ivo_cliente.cd_cliente
			
		End If	
		
	Case "nm_convenio"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_convenio.nm_razao_social Then
				Return 1
			End If	
		Else			
			ivo_convenio.Of_Inicializa()
			
			This.Object.nm_convenio	[1] = ivo_convenio.nm_razao_social
			This.Object.cd_convenio	[1] = ivo_convenio.cd_convenio
			
		End If	
		
	Case "id_tipo_canal"
		If dw_1.GetChild("id_canal_venda", lvdw_Child) > 0 Then
			lvdw_Child.SetTransObject( SQLCa )
			lvdw_Child.SetFilter("isNull(id_tipo_canal) or id_tipo_canal = '"+Data+"'")
			lvdw_Child.Filter()
		End If
		If dw_1.GetChild("cd_modo_entrega", lvdw_Child) > 0 Then
			lvdw_Child.SetTransObject( SQLCa )
			lvdw_Child.SetFilter("isNull(id_tipo_canal) or id_tipo_canal = '"+Data+"'")
			lvdw_Child.Filter()
		End If
		This.Object.id_canal_venda 		[1] = ""
		This.Object.cd_modo_entrega	[1] = ""
		
	Case "id_canal_venda"
		If dw_1.GetChild("cd_modo_entrega", lvdw_Child) > 0 Then
			lvdw_Child.SetTransObject( SQLCa )
			lvdw_Child.SetFilter("isNull(id_tipo_canal) or id_tipo_canal = '"+This.Object.id_tipo_canal[Row]+"'")
			lvdw_Child.Filter()
		End If
		This.Object.cd_modo_entrega [1] = ""
		
End Choose
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Filial) Then 
	This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
End If

If IsValid(ivo_produto) Then 
	If ivo_produto.Localizado Then	This.Object.de_produto [1] = ivo_produto.de_produto+': '+ivo_produto.de_apresentacao_estoque
End If

If IsValid(ivo_cfop) Then 
	This.Object.nm_cfop [1] = ivo_cfop.de_natureza_operacao
End If

If IsValid(ivo_cliente) Then 
	This.Object.nm_cliente [1] = ivo_cliente.nm_cliente
End If

If IsValid(ivo_convenio) Then 
	This.Object.nm_convenio [1] = ivo_convenio.nm_razao_social
End If

If IsValid(ivo_vendedor) Then 
	This.Object.nm_vendedor [1] = ivo_vendedor.nm_usuario
End If

If IsValid(ivo_convenio) Then 
	This.Object.nm_usuario [1] = ivo_usuario.nm_usuario
End If
end event

type dw_2 from dc_w_selecao_lista_dinamica_relatorio`dw_2 within w_ge325_rel_dinamico_vendas_item
integer y = 860
integer width = 4283
integer height = 1012
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Grupo
String lvs_UF_Fil
String lvs_Cliente
String lvs_Lei_Gen
String lvs_Lista_Pis
String lvs_Tipo_Vd
//String lvs_Tipo
String lvs_Forma_Pagto
String lvs_NCM_Ini
String lvs_NCM_Fim
String lvs_Especie
String lvs_Anexa
String lvs_Vendedor
String lvs_Usuario
String lvs_CST_ICMS
String lvs_Rede
String lvs_Modo_Entrega
String lvs_Canal_Venda
String lvs_Tipo_Canal
String lvs_Indice = "idx_data_filial"
String lvs_Situacao
String lvs_SQL

Long lvl_NCM
Long lvl_CFOP
Long lvl_Filial
Long lvl_Produto
Long lvl_Convenio
Long lvl_NF
Long lvl_SubQuery = 1

Date lvdt_Inicio
Date lvdt_Fim

dw_1.Accepttext( )

lvdt_Inicio				= dw_1.Object.dt_inicio					[1]
lvdt_Fim					= dw_1.Object.dt_fim						[1]
lvl_Filial					= dw_1.Object.cd_filial						[1]
lvl_Convenio			= dw_1.Object.cd_convenio				[1]
lvs_UF_Fil				= dw_1.Object.cd_uf						[1]
lvl_Produto			= dw_1.Object.cd_produto				[1]
lvs_Cliente				= dw_1.Object.cd_cliente					[1]
lvs_Tipo_Vd			= dw_1.Object.id_tipo_venda			[1]
lvs_Forma_Pagto		= dw_1.Object.cd_forma_pagto		[1]
lvl_CFOP					= dw_1.Object.cd_cfop					[1]
lvs_Grupo				= dw_1.Object.cd_grupo					[1]
lvl_NCM					= dw_1.Object.nr_ncm						[1]
lvs_Lista_Pis			= dw_1.Object.id_lista_pis_cofins		[1]
lvs_Lei_Gen			= dw_1.Object.id_lei_generico			[1]
lvs_Especie				= dw_1.Object.de_especie				[1]
lvs_Anexa				= dw_1.Object.id_anexa					[1]
lvs_Vendedor			= dw_1.Object.nr_matric_vendedor	[1] 
lvs_Usuario				= dw_1.Object.nr_matricula				[1] 
lvs_Rede				= dw_1.Object.id_area_vendas			[1]
lvs_Modo_Entrega	= dw_1.Object.cd_modo_entrega		[1]
lvs_Canal_Venda		= dw_1.Object.id_canal_venda			[1]
lvs_Tipo_Canal		= dw_1.Object.id_tipo_canal			[1]
lvs_CST_ICMS			= dw_1.Object.cd_cst_tributacao		[1]
lvs_Situacao			= dw_1.Object.id_situacao				[1]
lvl_NF						= dw_1.Object.nr_nf						[1]

If IsNull(lvdt_Inicio) or (lvdt_Inicio < Date('02/01/1900')) Then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Informe a data inicial para executar o relat$$HEX1$$f300$$ENDHEX$$rio.')
	dw_1.Event ue_Pos(1,'dt_inicio')
	Return -1
Else
	This.Of_AppendWhere("n.dh_movimentacao_caixa>='"+String(lvdt_Inicio,'YYYY/MM/DD')+"'")
End If

If IsNull(lvdt_Fim) or (lvdt_Fim < Date('02/01/1900')) Then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Informe a data final para executar o relat$$HEX1$$f300$$ENDHEX$$rio.')
	dw_1.Event ue_Pos(1,'dt_fim')
	Return -1
Else
	This.Of_AppendWhere("n.dh_movimentacao_caixa<='"+String(lvdt_Fim,'YYYY/MM/DD')+"'")
End If

ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Per$$HEX1$$ed00$$ENDHEX$$odo: '+String(lvdt_Inicio,'DD/MM/YYYY')+' $$HEX1$$e000$$ENDHEX$$ '+String(lvdt_Fim,'DD/MM/YYYY')

If Not IsNull(lvl_Produto) and (lvl_Produto > 0) Then
	This.Of_AppendWhere("i.cd_produto="+String(lvl_Produto))
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Produto: '+ivo_produto.de_produto+' ('+String(lvl_Produto)+')'
End If

If Not IsNull(lvl_Filial) and (lvl_Filial > 0) Then
	This.Of_AppendWhere("n.cd_filial="+String(lvl_Filial))
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Filial: '+ivo_filial.nm_fantasia+' ('+String(lvl_Filial)+')'
Else
	This.Of_AppendWhere("n.cd_filial > 0")
End If

If Not IsNull(lvl_Convenio) and (lvl_Convenio > 0) Then
	lvs_indice = "idx_convenio_data"
	This.Of_AppendWhere("n.cd_convenio="+String(lvl_Convenio))
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Filial: '+ivo_convenio.nm_razao_social+' ('+String(lvl_Convenio)+')'
End If

If lvs_UF_Fil<>'' Then
	This.Of_AppendWhere("cf.cd_unidade_federacao='"+lvs_UF_Fil+"'")
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'UF Destino: '+dw_1.Describe("Evaluate('LookUpDisplay(cd_uf)',1)")+' ('+lvs_UF_Fil+')'
End If

If lvs_Especie<>'' Then
	This.Of_AppendWhere("n.de_especie='"+lvs_Especie+"'")
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Esp$$HEX1$$e900$$ENDHEX$$cie: '+dw_1.Describe("Evaluate('LookUpDisplay(de_especie)',1)")
End If

If lvs_Tipo_Vd<>'' Then
	This.Of_AppendWhere("n.id_tipo_venda='"+lvs_Tipo_Vd+"'")
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Tipo Venda: '+dw_1.Describe("Evaluate('LookUpDisplay(id_tipo_venda)',1)")
	
	If lvs_Tipo_Vd = 'CV' Then
		This.Of_AppendWhere("n.cd_convenio is not null")
	End If	
End If

If lvs_Anexa <> "" Then
	If lvs_Anexa = 'N' Then
		This.Of_AppendWhere("n.nr_nf_anexa is null")
		ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'NF Anexa: DESCONSIDERAR'
	Else
		ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'NF Anexa: CONSIDERAR'
	End If
End If

If lvs_Forma_Pagto<>'' Then
	This.Of_AppendWhere("n.cd_forma_pagamento='"+lvs_Forma_Pagto+"'")
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Forma Pagto: '+dw_1.Describe("Evaluate('LookUpDisplay(cd_forma_pagto)',1)")
End If

If lvl_NF > 0 Then
	If lvl_Filial > 0 Then lvs_Indice = "pk_nf_venda"
	This.Of_AppendWhere("n.nr_nf="+String(lvl_NF))
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Nota: '+String(lvl_NF)
End If

If (Not IsNull(lvs_Cliente)) and (Trim(lvs_Cliente)<>'') Then
	lvs_Indice = "idx_cd_cliente"
	This.Of_AppendWhere("n.cd_cliente='"+lvs_Cliente+"'")	
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Cliente: '+ivo_cliente.nm_cliente+' ('+lvs_Cliente+')'
End If

If Not IsNull(lvl_CFOP) and (lvl_CFOP > 0) Then
	This.Of_AppendWhere("i.cd_natureza_operacao="+String(lvl_CFOP))
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'CFOP: '+String(lvl_CFOP)
End If

If lvs_Grupo<>'' Then
	This.Of_AppendWhere("substring(coalesce(hp.cd_subcategoria, p.cd_subcategoria),1,1)='"+lvs_Grupo+"'")
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Grupo Prod.: '+dw_1.Describe("Evaluate('LookUpDisplay(cd_grupo)',1)")
End If

If lvs_Lista_Pis<>'' Then
	This.Of_AppendWhere("coalesce(hp.id_situacao_pis_cofins, p.id_situacao_pis_cofins)='"+lvs_Lista_Pis+"'")
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Lista PIS: '+dw_1.Describe("Evaluate('LookUpDisplay(id_lista_pis_cofins)',1)")
End If

If lvs_Lei_Gen<>'' Then
	This.Of_AppendWhere("coalesce(hp.id_lei_generico, p.id_lei_generico)='"+lvs_Lei_Gen+"'")
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Lei Gen$$HEX1$$e900$$ENDHEX$$rico: '+dw_1.Describe("Evaluate('LookUpDisplay(id_lei_generico)',1)")
End If

If Not IsNull(lvs_Vendedor) and (Trim(lvs_Vendedor)<>'') Then
	This.Of_AppendWhere("n.nr_matricula_vendedor='"+lvs_Vendedor+"'")
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Vendedor: '+ivo_vendedor.nm_usuario+' ('+lvs_Vendedor+')'
End If

If Not IsNull(lvs_Usuario) and (Trim(lvs_Usuario)<>'') Then
	This.Of_AppendWhere("(n.nr_matric_operador='"+lvs_Usuario+"' or " + &
									"n.nr_matricula_vendedor = '"+lvs_Usuario+"' or " + &
									"n.nr_matric_alteracao_preco = '"+lvs_Usuario+"' or " + &
									"n.nr_matric_liberacao_bloqueio = '"+lvs_Usuario+"' or " + &
									"n.nr_matric_liberacao_restricao = '"+lvs_Usuario+"' or " + &
									"n.nr_matricula_cancelamento = '"+lvs_Usuario+"' or "+ &
									"n.nr_matric_liberacao_senha = '"+lvs_Usuario+"')")
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'Usu$$HEX1$$e100$$ENDHEX$$rio: '+ivo_usuario.nm_usuario+' ('+lvs_Usuario+')'
End If

If Not IsNull(lvl_NCM) or (lvl_NCM > 0) Then
	lvs_NCM_Ini 	= String(lvl_NCM)
	lvs_NCM_Fim 	= String(lvl_NCM)

	Do While Len(lvs_NCM_Ini) < 8
		lvs_NCM_Ini += '0'
	Loop
	
	Do While Len(lvs_NCM_Fim) < 8
		lvs_NCM_Fim += '9'
	Loop
	
	If lvs_NCM_Fim <> lvs_NCM_Ini Then
		This.Of_AppendWhere("coalesce(hp.nr_classificacao_fiscal, p.nr_classificacao_fiscal) >= "+lvs_NCM_Ini)
		This.Of_AppendWhere("coalesce(hp.nr_classificacao_fiscal, p.nr_classificacao_fiscal) <= "+lvs_NCM_Fim)
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'NCM: '+lvs_NCM_Ini+' $$HEX1$$e000$$ENDHEX$$ '+lvs_NCM_Fim
	Else
		This.Of_AppendWhere("coalesce(hp.nr_classificacao_fiscal, p.nr_classificacao_fiscal) = "+lvs_NCM_Ini)
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = 'NCM: '+lvs_NCM_Ini
	End If
End If

If lvs_Situacao <> "" Then
	If lvs_Situacao = "S" Then
		This.Of_AppendWhere("n.dh_cancelamento is not null")
	Else
		This.Of_AppendWhere("n.dh_cancelamento is null")
	End If
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = "Situa$$HEX2$$e700e300$$ENDHEX$$o: "+dw_1.Describe("Evaluate('LookUpDisplay(id_situacao)',1)")
End If

If lvs_Rede <> "" Then
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = "Rede: " + dw_1.Describe("Evaluate('LookUpDisplay(id_area_vendas)',1)")
	This.Of_AppendWhere("coalesce(pea.id_rede_ecommerce, f.id_rede_filial) = '" + lvs_Rede + "'")
End If

If lvs_Modo_Entrega <> "" Then
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = "Modo Entrega: " + dw_1.Describe("Evaluate('LookUpDisplay(cd_modo_entrega)',1)")
	This.Of_AppendWhere("pe.nm_transportadora = '" + dw_1.Describe("Evaluate('LookUpDisplay(cd_modo_entrega)',1)") + "'")
End If

If lvs_Tipo_Canal <> "" Then
	This.Of_AppendWhere("cnv.id_tipo_canal = '"+lvs_Tipo_Canal+"'")
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = "Tipo Canal de Venda: " + dw_1.Describe("Evaluate('LookUpDisplay(id_tipo_canal)',1)")
	
	//Otimiza$$HEX2$$e700e300$$ENDHEX$$o da gera$$HEX2$$e700e300$$ENDHEX$$o
	Choose Case lvs_Tipo_Canal
		Case "EC"
			lvs_Indice = "idx_data_ped_ecommerce"
			This.Of_AppendWhere("n.nr_pedido_ecommerce > 0") 
			
		Case "LI" //Licita$$HEX2$$e700e300$$ENDHEX$$o
			lvs_Indice = "idx_licitacao"
			This.Of_AppendWhere("n.id_licitacao='S'")
	End Choose
End If

If lvs_Canal_Venda <> "" Then
	If lvs_Canal_Venda = "AP" Then
		This.of_AppendWhere("coalesce(pe.id_ecommerce,'1')='2'") //Todas as vendas VTEX, depois ajustar o filtro quando for poss$$HEX1$$ed00$$ENDHEX$$vel identificar
		This.of_AppendWhere("pe.de_canal_compra_vtex in ('app_android', 'app_ios', 'app_android_n', 'app_ios_n')") 
	Else
		If lvdt_Inicio > Date("2020/10/08") Then This.Of_AppendWhere("n.cd_canal_venda = '"+lvs_Canal_Venda+"'")
		This.Of_AppendWhere("cnv.cd_canal_venda = '"+lvs_Canal_Venda+"'")
		This.of_AppendWhere("coalesce(pe.de_canal_compra_vtex,'') not in ('app_android', 'app_ios', 'app_android_n', 'app_ios_n')") 
	End If	
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = "Canal de Venda: " + dw_1.Describe("Evaluate('LookUpDisplay(id_canal_venda)',1)")
End If

If lvs_CST_ICMS <> "" Then
	This.Of_AppendWhere("coalesce(i.cd_cst_tributacao, substring(i.cd_situacao_tributaria, 2, 1)||'0')='"+lvs_CST_ICMS+"'")
	ivs_Parametros[UpperBound(ivs_Parametros)+1] = "CST ICMS: " + dw_1.Describe("Evaluate('LookUpDisplay(cd_cst_tributacao)',1)")
End If

lvs_SQL = This.GetSQLSelect( )
lvs_SQL = gf_replace(lvs_SQL,'from nf_venda n ','from nf_venda n (index '+lvs_Indice+') ',1)	
This.of_ChangeSQL(lvs_SQL)

Return AncestorReturnValue
end event

type dw_3 from dc_w_selecao_lista_dinamica_relatorio`dw_3 within w_ge325_rel_dinamico_vendas_item
integer x = 1865
integer y = 784
string title = "Relat$$HEX1$$f300$$ENDHEX$$rio Din$$HEX1$$e200$$ENDHEX$$mico de Vendas (Item)"
end type

type dw_campos from dc_w_selecao_lista_dinamica_relatorio`dw_campos within w_ge325_rel_dinamico_vendas_item
integer x = 2533
integer y = 940
end type

type st_dica from dc_w_selecao_lista_dinamica_relatorio`st_dica within w_ge325_rel_dinamico_vendas_item
integer x = 233
integer y = 836
end type

type cb_1 from commandbutton within w_ge325_rel_dinamico_vendas_item
boolean visible = false
integer x = 3963
integer y = 636
integer width = 402
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Executar"
end type

event clicked;wf_relatorio_todas_filiais_2()

//wf_relatorio_resumo()

//wf_salva_base_historico()

end event

