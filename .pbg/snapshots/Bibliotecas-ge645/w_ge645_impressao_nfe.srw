HA$PBExportHeader$w_ge645_impressao_nfe.srw
forward
global type w_ge645_impressao_nfe from dc_w_selecao_lista_relatorio
end type
type cb_imprimir from commandbutton within w_ge645_impressao_nfe
end type
type st_1 from statictext within w_ge645_impressao_nfe
end type
type ddlb_impressoras from dropdownlistbox within w_ge645_impressao_nfe
end type
type cb_reenviar_dev from commandbutton within w_ge645_impressao_nfe
end type
type cb_envio_email_forn from commandbutton within w_ge645_impressao_nfe
end type
type cb_imp_etiqueta from commandbutton within w_ge645_impressao_nfe
end type
end forward

global type w_ge645_impressao_nfe from dc_w_selecao_lista_relatorio
string tag = "w_ge645_impressao_nfe"
integer width = 6098
integer height = 2596
string title = "GE645 - Impress$$HEX1$$e300$$ENDHEX$$o DANFE"
cb_imprimir cb_imprimir
st_1 st_1
ddlb_impressoras ddlb_impressoras
cb_reenviar_dev cb_reenviar_dev
cb_envio_email_forn cb_envio_email_forn
cb_imp_etiqueta cb_imp_etiqueta
end type
global w_ge645_impressao_nfe w_ge645_impressao_nfe

type variables
uo_filial		io_Filial
uo_ge473_comum	iuo_ge473_comum
uo_fornecedor ivo_fornecedor

String	is_id_tipo_nf = 'TRA'

uo_Usuario ivo_Usuario

dc_uo_ds_Base ids_Lista_de_Divergencias

boolean ib_Check = False
end variables

forward prototypes
public function boolean wf_filtra_nf ()
public function boolean wf_ajusta_nf_transferencia ()
public function boolean wf_ajusta_nf_sucata ()
public function boolean wf_ajusta_nf_inventario ()
public function boolean wf_validar_xmls ()
public function boolean wf_ajusta_nf_tra_loja ()
public function boolean wf_ajusta_nf_descarte ()
public function boolean wf_filtra_nf_postretrieve ()
public function boolean wf_bloqueia_desbloqueia_filtros ()
public function boolean wf_controle_filtro_post (string as_termo_filtro, ref string as_filtro)
public function boolean wf_ajusta_nf_licitacao ()
public function boolean wf_imprime_etiquetas ()
public subroutine wf_muda_cores_campos_dev (boolean ab_ativo)
end prototypes

public function boolean wf_filtra_nf ();Date		ld_dh_inicio, ld_dh_fim
String	ls_null, ls_id_tipo_devolucao, ls_cd_fornecedor, ls_nr_matricula_responsavel, ls_id_status_receb, &
			ls_id_status_nf, ls_id_status_envio, ls_id_filtra_divergentes

SetNull(ls_null)

dw_1.AcceptText()

if dw_1.GetRow() < 1 Then Return False

ld_dh_inicio						= dw_1.Object.dh_inicio[1]
ld_dh_fim							= dw_1.Object.dh_fim[1]
ls_id_tipo_devolucao				= dw_1.Object.id_tipo_devolucao[1]
ls_cd_fornecedor					= dw_1.Object.cd_fornecedor[1]
ls_nr_matricula_responsavel	= dw_1.Object.nr_matricula[1]
ls_id_status_receb				= dw_1.Object.id_status_receb[1]
ls_id_status_nf					= dw_1.Object.id_status_nf[1]
ls_id_status_envio				= dw_1.Object.id_status_envio[1]
ls_id_filtra_divergentes		= dw_1.Object.id_filtra_divergentes[1]

if IsNull(ld_dh_inicio) then ld_dh_inicio = Date('1900-01-01')
if IsNull(ld_dh_fim) then ld_dh_fim = Date('2500-12-31')

Choose Case is_id_tipo_nf
	Case 'TRA'
		SQLCA_CONSULTA.of_Connect(gvo_Aplicacao.ivs_DataSource, 'SQLCA - Consulta (AutoCommit)')
		SQLCA_CONSULTA.AutoCommit	= true
		
		dw_2.of_settransobject(SQLCA_CONSULTA)
		
		dw_2.Retrieve(ld_dh_inicio, ld_dh_fim)
		
		SQLCA_CONSULTA.of_disconnect()
		
		Return True
	Case 'DEV'
		SQLCA_CONSULTA.of_Connect(gvo_Aplicacao.ivs_DataSource, 'SQLCA - Consulta (AutoCommit)')
		SQLCA_CONSULTA.AutoCommit	= true
		
		dw_2.of_settransobject(SQLCA_CONSULTA)
		dw_2.Retrieve(ld_dh_inicio, ld_dh_fim, ls_id_tipo_devolucao, ls_cd_fornecedor, ls_nr_matricula_responsavel, &
						ls_id_status_envio, ls_id_status_receb, ls_id_status_nf, ls_id_filtra_divergentes)
		
		SQLCA_CONSULTA.of_disconnect()
		
		Return True
	Case 'SUC', 'LIC', 'INV', 'DES'
		dw_2.of_AppendWhere("cast(les.dh_exportacao as date) between '" + String(ld_dh_inicio, 'yyyy-mm-dd') + "' and '" + String(ld_dh_fim, 'yyyy-mm-dd') + "'")
	Case 'TFI'
		dw_2.of_AppendWhere("cast(nt.dh_movimentacao_caixa as date) between '" + String(ld_dh_inicio, 'yyyy-mm-dd') + "' and '" + String(ld_dh_fim, 'yyyy-mm-dd') + "'")
End Choose

dw_2.Retrieve()

Return True
end function

public function boolean wf_ajusta_nf_transferencia ();DateTime	ldt_authdate, ldt_dh_emissao, ldt_dh_exportacao
Long		ll_for, ll_docnum, ll_nr_sequencial, ll_nr_nf, ll_cd_filial_origem, ll_linhas, ll_count, ll_for_items, ll_linha_nova, &
			ll_cd_filial, ll_count_total_produtos, ll_nr_pedido_distribuidora, ll_contador_pedidos
String	ls_id_tipo_nf, ls_solicitacao, ls_mandt, ls_de_especie, ls_de_serie, ls_branch, ls_de_chave_acesso, ls_id_status, &
			ls_id_situacao_nfe, ls_de_erro_autorizacao, ls_de_log, ls_solicitacao_aux, ls_id_status_integracao, ls_nr_solicitacoes[]

dc_uo_ds_base lds_lista_docnum_ped

return true

ll_linhas	= dw_2.RowCount()

SetPointer(HourGlass!)

Open(w_Aguarde)

w_Aguarde.Title = 'Buscando dados...'
w_Aguarde.uo_Progress.of_SetMax(ll_linhas)

ll_contador_pedidos	= 1

dw_2.SetRedraw(False)

for ll_for = 1 to dw_2.RowCount()	
	w_Aguarde.Title = 'Verificando quebra de pedidos... '+String(ll_contador_pedidos)+' de '+String(ll_linhas)
	
	w_Aguarde.uo_Progress.of_SetProgress(ll_contador_pedidos)
	
	ls_solicitacao 			= dw_2.Object.solicitacao[ll_for]
	ls_id_status_integracao	= dw_2.Object.id_status_integracao[ll_for]
	ll_cd_filial				= dw_2.Object.cd_filial[ll_for]
	ldt_dh_exportacao			= dw_2.Object.dh_exportacao[ll_for]
	
	ll_nr_pedido_distribuidora	= Long(ls_solicitacao)
	
	select count(*)
	  into :ll_count_total_produtos
	  from pedido_distribuidora_produto
	 where nr_pedido_distribuidora	= :ll_nr_pedido_distribuidora
	 	and cd_filial						= :ll_cd_filial
		and qt_separada					> 0;
		
	Choose Case SQLCA.SQLCode
		Case -1, 100
			Continue
		Case 0
			ll_count	= Truncate(ll_count_total_produtos / 99, 0)
			
			if mod(ll_count_total_produtos, 99) <> 0 then
				ll_count ++
			end if
	End Choose
	
	For ll_for_items = 1 to ll_count
		if ll_count > 1 then
			if ll_for_items > 1 then
				ll_for = ll_for + 1
				
				ll_linha_nova	= dw_2.InsertRow(ll_for)
			else
				ll_linha_nova	= ll_for
			end if
			
			dw_2.Object.solicitacao[ll_linha_nova]				= '00' + ls_solicitacao + '/' + Right('00' + String(ll_for_items), 2)
			dw_2.Object.id_status_integracao[ll_linha_nova]	= ls_id_status_integracao
			dw_2.Object.cd_filial[ll_linha_nova]				= ll_cd_filial
			dw_2.Object.dh_exportacao[ll_linha_nova]			= ldt_dh_exportacao
		else
			dw_2.Object.solicitacao[ll_for]	= '00' + ls_solicitacao
		end if
	next
	
	ll_contador_pedidos ++
next

dw_2.SetRedraw(True)

ll_linhas	= dw_2.RowCount()
w_Aguarde.uo_Progress.of_SetMax(ll_linhas)

dw_2.SetRedraw(False)

for ll_for = 1 to ll_linhas
	w_Aguarde.Title = 'Buscando dados das notas fiscais... '+String(ll_for)+' de '+String(ll_linhas)
	
	w_Aguarde.uo_Progress.of_SetProgress(ll_for)
	
	ls_solicitacao = dw_2.Object.solicitacao[ll_for]
			
	select top 1 jbdoc.docnum, 
			 jbdoc.mandt,
			 jbdoc.nr_sequencial,
			 jbdoc.authdate,
			 jbdoc.branch,
			 jbdoc.id_status,
			 jbdoc.de_log
	  into :ll_docnum,
			 :ls_mandt,
			 :ll_nr_sequencial,
			 :ldt_authdate,
			 :ls_branch,
			 :ls_id_status,
			 :ls_de_log
	  from dbo.j_1bnflin jblin
	 inner join dbo.j_1bnfdoc_1 jbdoc 
		 on jblin.mandt  			= jbdoc.mandt 
		and jblin.docnum 			= jbdoc.docnum 
		and jblin.nr_sequencial = jbdoc.nr_sequencial 
	 inner join dbo.j_1bnfdoc_2 jbdoc2 
		 on jbdoc.mandt 			= jbdoc2.mandt
		and jbdoc.docnum 			= jbdoc2.docnum
		and jbdoc.nr_sequencial	= jbdoc2.nr_sequencial
	 where jblin.xped 				= :ls_solicitacao
		and jbdoc.id_substituida 	= 'N'
		and jbdoc.authdate 			is not null
		and jbdoc2.nftype				<> 'ZF'
	 group by jbdoc.docnum, 
				 jbdoc.mandt,
				 jbdoc.nr_sequencial,
				 jbdoc.authdate,
				 jbdoc.branch,
				 jbdoc.id_status,
				 jbdoc.de_log
	using SQLCA;
	
	if SQLCA.SQLCode = 100 and pos(ls_solicitacao, '/') = 0 then
		ls_solicitacao	= ls_solicitacao + '/01'
		
		select top 1 jbdoc.docnum, 
				 jbdoc.mandt,
				 jbdoc.nr_sequencial,
				 jbdoc.authdate,
				 jbdoc.branch,
				 jbdoc.id_status,
				 jbdoc.de_log
		  into :ll_docnum,
				 :ls_mandt,
				 :ll_nr_sequencial,
				 :ldt_authdate,
				 :ls_branch,
				 :ls_id_status,
				 :ls_de_log
		  from dbo.j_1bnflin jblin
		 inner join dbo.j_1bnfdoc_1 jbdoc 
			 on jblin.mandt  			= jbdoc.mandt 
			and jblin.docnum 			= jbdoc.docnum 
			and jblin.nr_sequencial = jbdoc.nr_sequencial 
		 inner join dbo.j_1bnfdoc_2 jbdoc2 
			 on jbdoc.mandt 			= jbdoc2.mandt
			and jbdoc.docnum 			= jbdoc2.docnum
			and jbdoc.nr_sequencial	= jbdoc2.nr_sequencial
		 where jblin.xped 				= :ls_solicitacao
			and jbdoc.id_substituida 	= 'N'
			and jbdoc.authdate 			is not null
			and jbdoc2.nftype				<> 'ZF'
		 group by jbdoc.docnum, 
					 jbdoc.mandt,
					 jbdoc.nr_sequencial,
					 jbdoc.authdate,
					 jbdoc.branch,
					 jbdoc.id_status,
					 jbdoc.de_log
		using SQLCA;
	end if
	
	Choose Case SQLCA.SQLCode
		Case -1
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao localizar a j_1bnfdoc_1 da solicita$$HEX2$$e700e300$$ENDHEX$$o ' + ls_solicitacao_aux + '. Erro: ' + SQLCA.SQLErrText, StopSign!)
			Exit
		Case 0
			dw_2.Object.docnum[ll_for]					= ll_docnum
			dw_2.Object.dh_processamento[ll_for]	= ldt_authdate

			If IsNull(ls_id_status) Then ls_id_status = 'C'
		
			dw_2.Object.id_situacao_jdoc[ll_for]		= ls_id_status
			dw_2.Object.de_erro_recebimento[ll_for]	= ls_de_log
	End Choose
	
	select top 1 coalesce(cast(jbdoc2.nfenum as int), jbdoc2.nfnum),
			 coalesce(jbdoc2.series, 'U'),
			 cast('NFE' as char(3))
	  into :ll_nr_nf,
			 :ls_de_serie,
			 :ls_de_especie
	  from dbo.j_1bnfdoc_2 jbdoc2
	 where jbdoc2.docnum 			= :ll_docnum
		and jbdoc2.mandt 				= :ls_mandt
		and jbdoc2.nr_sequencial 	= :ll_nr_sequencial
	using SQLCA;
		
	Choose Case SQLCA.SQLCode
		Case -1
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao localizar a j_1bnfdoc_2 da solicita$$HEX2$$e700e300$$ENDHEX$$o ' + ls_solicitacao_aux + '. Erro: ' + SQLCA.SQLErrText, StopSign!)
			Exit
		Case 100
			Continue
	End Choose
	
	select isap.cd_chave_legado
	  into :ll_cd_filial_origem
	  from integracao_sap isap
	 where isap.cd_tabela		= 'FILIAL'
		and isap.cd_chave_sap	= :ls_branch
	using SQLCA;
	
	Choose Case SQLCA.SQLCode
		Case -1
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao localizar a filial da solicita$$HEX2$$e700e300$$ENDHEX$$o ' + ls_solicitacao_aux + '. Erro: ' + SQLCA.SQLErrText, StopSign!)
			Exit
		Case 100
			Continue
	End Choose
	
	select de_chave_acesso,
			 id_situacao,
			 de_erro_autorizacao
	  into :ls_de_chave_acesso,
			 :ls_id_situacao_nfe,
			 :ls_de_erro_autorizacao
	  from nf_transferencia_nfe ntn
	 where ntn.nr_nf					= :ll_nr_nf
		and ntn.cd_filial_origem	= :ll_cd_filial_origem
		and ntn.de_serie				= :ls_de_serie
		and ntn.de_especie			= :ls_de_especie
	using SQLCA;
	
	Choose Case SQLCA.SQLCode
		Case -1
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao localizar a chave de acesso da solicita$$HEX2$$e700e300$$ENDHEX$$o ' + ls_solicitacao_aux + '. Erro: ' + SQLCA.SQLErrText, StopSign!)
			Exit
		Case 100
			//Continue
			Select jactive.regio || jactive.nfyear || jactive.nfmonth || jactive.stcd1 || cast(jactive.model as char(2)) || jactive.serie || jactive.nfnum9 || jactive.docnum9 || jactive.cdv, action_date, case when jactive.code = '100' then 'P' else '' end
			  into :ls_de_chave_acesso,
			  		:ldt_dh_emissao,
					  :ls_id_situacao_nfe
			  from j_1bnfe_active as jactive
			 where jactive.docnum 			= :ll_docnum
				and jactive.mandt 				= :ls_mandt
				and jactive.nr_sequencial 	= :ll_nr_sequencial
			using SQLCA;
				
			Choose Case SQLCA.SQLCode
				Case -1
					MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao localizar a j_1bnfe_active da solicita$$HEX2$$e700e300$$ENDHEX$$o ' + ls_solicitacao_aux + '. Erro: ' + SQLCA.SQLErrText, StopSign!)
					Exit
				Case 100
					Continue
			End Choose
		Case 0
			if ls_id_situacao_nfe = 'A' then ls_id_situacao_nfe = 'P'
	End Choose
	
	If IsNull(ldt_dh_emissao) Or ldt_dh_emissao = datetime('1900-01-01 00:00:00') Then
		select dh_movimentacao_caixa
		  into :ldt_dh_emissao
		  from nf_transferencia nt
		 where nt.nr_nf				= :ll_nr_nf
			and nt.cd_filial_origem	= :ll_cd_filial_origem
			and nt.de_serie			= :ls_de_serie
			and nt.de_especie			= :ls_de_especie
		using SQLCA;
		
		Choose Case SQLCA.SQLCode
			Case -1
				MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao localizar a emiss$$HEX1$$e300$$ENDHEX$$o da nota da solicita$$HEX2$$e700e300$$ENDHEX$$o ' + ls_solicitacao_aux + '. Erro: ' + SQLCA.SQLErrText, StopSign!)
				Exit
			Case 100
				Continue
		End Choose
	End If
	
	dw_2.Object.nr_nf[ll_for]						= ll_nr_nf
	dw_2.Object.de_serie[ll_for]					= ls_de_serie
	dw_2.Object.de_especie[ll_for]				= ls_de_especie		
	dw_2.Object.de_chave_acesso[ll_for]			= ls_de_chave_acesso
	dw_2.Object.dh_emissao[ll_for]				= ldt_dh_emissao
	dw_2.Object.id_situacao_nf[ll_for]			= ls_id_situacao_nfe
	dw_2.Object.de_erro_criar_nf[ll_for]		= ls_de_erro_autorizacao
	dw_2.Object.cd_filial_origem_nf[ll_for]	= ll_cd_filial_origem
	
	SetNull(ll_nr_nf)
	SetNull(ls_de_serie)
	SetNull(ls_de_especie)
	SetNull(ls_de_chave_acesso)
	SetNull(ldt_dh_emissao)
	SetNull(ls_id_situacao_nfe)
	SetNull(ls_de_erro_autorizacao)
	SetNull(ll_docnum)
	SetNull(ldt_authdate)
	SetNull(ls_id_status)
	SetNull(ls_de_log)
	SetNull(ll_cd_filial_origem)
Next

dw_2.SetRedraw(True)

Close(w_Aguarde)

SetPointer(Arrow!)

Return True
end function

public function boolean wf_ajusta_nf_sucata ();DateTime	ldt_authdate, ldt_dh_emissao
Long		ll_for, ll_docnum, ll_nr_sequencial, ll_nr_nf, ll_cd_filial_origem, ll_linhas
String	ls_id_tipo_nf, ls_solicitacao, ls_mandt, ls_de_especie, ls_de_serie, ls_branch, ls_de_chave_acesso, ls_id_status, &
			ls_id_situacao_nfe, ls_de_erro_autorizacao, ls_de_log, ls_id_nfe_impressa


ll_linhas	= dw_2.RowCount()

SetPointer(HourGlass!)

Open(w_Aguarde)

w_Aguarde.Title = 'Buscando dados...'
w_Aguarde.uo_Progress.of_SetMax(ll_linhas)

for ll_for = 1 to ll_linhas
	w_Aguarde.Title = 'Buscando dados... '+String(ll_for)+' de '+String(ll_linhas)
	
	w_Aguarde.uo_Progress.of_SetProgress(ll_for)
				
	ls_solicitacao	= Right('0000000' + dw_2.Object.solicitacao[ll_for], 10)
	
	select distinct top 1 jbdoc.docnum, 
			 jbdoc.mandt,
			 jbdoc.nr_sequencial,
			 jbdoc.authdate,
			 jbdoc.branch,
			 jbdoc.id_status,
			 jbdoc.de_log
	  into :ll_docnum,
			 :ls_mandt,
			 :ll_nr_sequencial,
			 :ldt_authdate,
			 :ls_branch,
			 :ls_id_status,
			 :ls_de_log
	  from dbo.j_1bnflin jblin
	 inner join dbo.j_1bnfdoc_1 jbdoc 
		 on jblin.mandt  			= jbdoc.mandt 
		and jblin.docnum 			= jbdoc.docnum 
		and jblin.nr_sequencial = jbdoc.nr_sequencial 
	 where jblin.xped 				like :ls_solicitacao
		and jbdoc.id_substituida 	= 'N'
		and jbdoc.authdate 			is not null
	using SQLCA;
	
	Choose Case SQLCA.SQLCode
		Case -1
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao localizar a j_1bnfdoc_1 da solicita$$HEX2$$e700e300$$ENDHEX$$o ' + ls_solicitacao + '. Erro: ' + SQLCA.SQLErrText, StopSign!)
			Exit
		Case 0
			dw_2.Object.docnum[ll_for]					= ll_docnum
			dw_2.Object.dh_processamento[ll_for]	= ldt_authdate
			
			if IsNull(ls_id_status) then ls_id_status = 'C'
			
			dw_2.Object.id_situacao_jdoc[ll_for]		= ls_id_status
			dw_2.Object.de_erro_recebimento[ll_for]	= ls_de_log
		Case 100
			Continue
	End Choose
	
	select coalesce(cast(jbdoc2.nfenum as int), jbdoc2.nfnum),
			 coalesce(jbdoc2.series, 'U'),
			 cast('NFE' as char(3))
	  into :ll_nr_nf,
			 :ls_de_serie,
			 :ls_de_especie
	  from dbo.j_1bnfdoc_2 jbdoc2
	 where jbdoc2.docnum 			= :ll_docnum
		and jbdoc2.mandt 				= :ls_mandt
		and jbdoc2.nr_sequencial 	= :ll_nr_sequencial
	using SQLCA;
		
	Choose Case SQLCA.SQLCode
		Case -1
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao localizar a j_1bnfdoc_2 da solicita$$HEX2$$e700e300$$ENDHEX$$o ' + ls_solicitacao + '. Erro: ' + SQLCA.SQLErrText, StopSign!)
			Exit
		Case 100
			Continue
	End Choose
	
	select isap.cd_chave_legado
	  into :ll_cd_filial_origem
	  from integracao_sap isap
	 where isap.cd_tabela		= 'FILIAL'
		and isap.cd_chave_sap	= :ls_branch
	using SQLCA;
	
	Choose Case SQLCA.SQLCode
		Case -1
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao localizar a filial da solicita$$HEX2$$e700e300$$ENDHEX$$o ' + ls_solicitacao + '. Erro: ' + SQLCA.SQLErrText, StopSign!)
			Exit
		Case 100
			Continue
	End Choose
	
	select de_chave_acesso,
			 id_situacao,
			 coalesce(id_nfe_impressa, 'N')
	  into :ls_de_chave_acesso,
			 :ls_id_situacao_nfe,
			 :ls_id_nfe_impressa
	  from nf_diversa_nfe ndn
	 where ndn.nr_nf					= :ll_nr_nf
		and ndn.cd_filial_origem	= :ll_cd_filial_origem
		and ndn.de_serie				= :ls_de_serie
		and ndn.de_especie			= :ls_de_especie
	using SQLCA;
	
	Choose Case SQLCA.SQLCode
		Case -1
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao localizar a chave de acesso da solicita$$HEX2$$e700e300$$ENDHEX$$o ' + ls_solicitacao + '. Erro: ' + SQLCA.SQLErrText, StopSign!)
			Exit
		Case 100
			Continue
		Case 0
			if ls_id_situacao_nfe = 'A' then ls_id_situacao_nfe = 'P'
	End Choose
	
	if ls_id_situacao_nfe = 'E' then
		ls_de_erro_autorizacao = 'Erro ao autorizar NF-e'
	end if
	
	select dh_emissao
	  into :ldt_dh_emissao
	  from nf_diversa nd
	 where nd.nr_nf				= :ll_nr_nf
		and nd.cd_filial_origem	= :ll_cd_filial_origem
		and nd.de_serie			= :ls_de_serie
		and nd.de_especie			= :ls_de_especie
	using SQLCA;
	
	Choose Case SQLCA.SQLCode
		Case -1
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao localizar a emiss$$HEX1$$e300$$ENDHEX$$o da nota da solicita$$HEX2$$e700e300$$ENDHEX$$o ' + ls_solicitacao + '. Erro: ' + SQLCA.SQLErrText, StopSign!)
			Exit
		Case 100
			Continue
	End Choose
			
	dw_2.Object.nr_nf[ll_for]						= ll_nr_nf
	dw_2.Object.de_serie[ll_for]					= ls_de_serie
	dw_2.Object.de_especie[ll_for]				= ls_de_especie		
	dw_2.Object.de_chave_acesso[ll_for]			= ls_de_chave_acesso
	dw_2.Object.dh_emissao[ll_for]				= ldt_dh_emissao
	dw_2.Object.id_situacao_nf[ll_for]			= ls_id_situacao_nfe
	dw_2.Object.de_erro_criar_nf[ll_for]		= ls_de_erro_autorizacao
	dw_2.Object.cd_filial_origem_nf[ll_for]	= ll_cd_filial_origem
	dw_2.Object.id_nfe_impressa[ll_for]	= ls_id_nfe_impressa
	
	SetNull(ll_nr_nf)
	SetNull(ls_de_serie)
	SetNull(ls_de_especie)
	SetNull(ls_de_chave_acesso)
	SetNull(ldt_dh_emissao)
	SetNull(ls_id_situacao_nfe)
	SetNull(ls_de_erro_autorizacao)
	SetNull(ll_docnum)
	SetNull(ldt_authdate)
	SetNull(ls_id_status)
	SetNull(ls_de_log)
	SetNull(ll_cd_filial_origem)
	SetNull(ls_id_nfe_impressa)
Next

Close(w_Aguarde)

SetPointer(Arrow!)

Return True
end function

public function boolean wf_ajusta_nf_inventario ();DateTime	ldt_authdate, ldt_dh_emissao
Long		ll_for, ll_docnum, ll_nr_sequencial, ll_nr_nf, ll_cd_filial, ll_cd_fornecedor, ll_linhas
String	ls_id_tipo_nf, ls_solicitacao, ls_mandt, ls_de_especie, ls_de_serie, ls_branch, ls_de_chave_acesso, ls_id_status, &
			ls_id_situacao_nfe, ls_de_erro_autorizacao, ls_de_log, ls_parid, ls_log, ls_cd_varchar, ls_id_nfe_impressa


ll_linhas	= dw_2.RowCount()

SetPointer(HourGlass!)

Open(w_Aguarde)

w_Aguarde.Title = 'Buscando dados...'
w_Aguarde.uo_Progress.of_SetMax(ll_linhas)

for ll_for = 1 to ll_linhas
	w_Aguarde.Title = 'Buscando dados... '+String(ll_for)+' de '+String(ll_linhas)
	
	w_Aguarde.uo_Progress.of_SetProgress(ll_for)
	
	ls_id_tipo_nf	= dw_2.Object.id_tipo_nf[ll_for]
	ls_cd_varchar	= dw_2.Object.cd_varchar[ll_for]
	
	if ls_id_tipo_nf = 'WMM' and (ls_cd_varchar = 'SEGREGADO_REVENDA' or ls_cd_varchar = 'REVENDA_SEGREGADO') then
		Continue
	end if
	
	ls_solicitacao	= 'SOLIC|' + dw_2.Object.solicitacao[ll_for]
	
	select distinct top 1 jbdoc.docnum, 
			 jbdoc.mandt,
			 jbdoc.nr_sequencial,
			 jbdoc.authdate,
			 jbdoc.branch,
			 jbdoc.id_status,
			 jbdoc.de_log
	  into :ll_docnum,
			 :ls_mandt,
			 :ll_nr_sequencial,
			 :ldt_authdate,
			 :ls_branch,
			 :ls_id_status,
			 :ls_de_log
	  from dbo.j_1bnflin jblin
	 inner join dbo.j_1bnfdoc_1 jbdoc 
		 on jblin.mandt  											= jbdoc.mandt 
		and jblin.docnum 											= jbdoc.docnum 
		and jblin.nr_sequencial 								= jbdoc.nr_sequencial 
	 where jblin.contrato 										= :ls_solicitacao
		and jbdoc.id_substituida 								= 'N'
		and jbdoc.authdate 										is not null
	using SQLCA;
	
	Choose Case SQLCA.SQLCode
		Case -1
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao localizar a j_1bnfdoc_1 da solicita$$HEX2$$e700e300$$ENDHEX$$o ' + ls_solicitacao + '. Erro: ' + SQLCA.SQLErrText, StopSign!)
			Exit
		Case 100
			ls_solicitacao	= "'SOLIC'" + dw_2.Object.solicitacao[ll_for]
			
			select distinct top 1 jbdoc.docnum, 
					 jbdoc.mandt,
					 jbdoc.nr_sequencial,
					 jbdoc.authdate,
					 jbdoc.branch,
					 jbdoc.id_status,
					 jbdoc.de_log
			  into :ll_docnum,
					 :ls_mandt,
					 :ll_nr_sequencial,
					 :ldt_authdate,
					 :ls_branch,
					 :ls_id_status,
					 :ls_de_log
			  from dbo.j_1bnflin jblin
			 inner join dbo.j_1bnfdoc_1 jbdoc 
				 on jblin.mandt  											= jbdoc.mandt 
				and jblin.docnum 											= jbdoc.docnum 
				and jblin.nr_sequencial 								= jbdoc.nr_sequencial 
			 where jblin.contrato 										= :ls_solicitacao
				and jbdoc.id_substituida 								= 'N'
				and jbdoc.authdate 										is not null
			using SQLCA;
			
			Choose Case SQLCA.SQLCode
				Case -1
					MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao localizar a j_1bnfdoc_1 da solicita$$HEX2$$e700e300$$ENDHEX$$o ' + ls_solicitacao + '. Erro: ' + SQLCA.SQLErrText, StopSign!)
					Exit
				Case 100
					Continue
			End Choose
	End Choose
	
	dw_2.Object.docnum[ll_for]					= ll_docnum
	dw_2.Object.dh_processamento[ll_for]	= ldt_authdate
	
	if IsNull(ls_id_status) then ls_id_status = 'C'
	
	dw_2.Object.id_situacao_jdoc[ll_for]		= ls_id_status
	dw_2.Object.de_erro_recebimento[ll_for]	= ls_de_log
	
	
	
	select coalesce(cast(jbdoc2.nfenum as int), jbdoc2.nfnum),
			 coalesce(jbdoc2.series, 'U'),
			 cast('NFE' as char(3)),
			 jbdoc2.parid
	  into :ll_nr_nf,
			 :ls_de_serie,
			 :ls_de_especie,
			 :ls_parid
	  from dbo.j_1bnfdoc_2 jbdoc2
	 where jbdoc2.docnum 			= :ll_docnum
		and jbdoc2.mandt 				= :ls_mandt
		and jbdoc2.nr_sequencial 	= :ll_nr_sequencial
	using SQLCA;
		
	Choose Case SQLCA.SQLCode
		Case -1
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao localizar a j_1bnfdoc_2 da solicita$$HEX2$$e700e300$$ENDHEX$$o ' + ls_solicitacao + '. Erro: ' + SQLCA.SQLErrText, StopSign!)
			Exit
		Case 100
			Continue
	End Choose
	
	select isap.cd_chave_legado
	  into :ll_cd_filial
	  from integracao_sap isap
	 where isap.cd_tabela		= 'FILIAL'
		and isap.cd_chave_sap	= :ls_branch
	using SQLCA;
	
	Choose Case SQLCA.SQLCode
		Case -1
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao localizar a filial da solicita$$HEX2$$e700e300$$ENDHEX$$o ' + ls_solicitacao + '. Erro: ' + SQLCA.SQLErrText, StopSign!)
			Exit
		Case 100
			Continue
	End Choose
	
	select de_chave_acesso,
			 id_situacao,
			 coalesce(id_nfe_impressa, 'N')
	  into :ls_de_chave_acesso,
			 :ls_id_situacao_nfe,
			 :ls_id_nfe_impressa
	  from nf_diversa_nfe
	 where nr_nf				= :ll_nr_nf
		and cd_filial_origem	= :ll_cd_filial
		and de_serie			= :ls_de_serie
		and de_especie			= :ls_de_especie
	using SQLCA;
	
	Choose Case SQLCA.SQLCode
		Case -1
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao localizar a chave de acesso da solicita$$HEX2$$e700e300$$ENDHEX$$o ' + ls_solicitacao + '. Erro: ' + SQLCA.SQLErrText, StopSign!)
			Exit
		Case 100
			Continue
		Case 0
			if ls_id_situacao_nfe = 'A' then ls_id_situacao_nfe = 'P'
			
			if ls_id_situacao_nfe <> 'P' then ls_de_erro_autorizacao = 'Erro ao autorizar a nota de devolu$$HEX2$$e700e300$$ENDHEX$$o'
	End Choose
	
	select dh_emissao
	  into :ldt_dh_emissao
	  from nf_diversa
	 where nr_nf				= :ll_nr_nf
		and cd_filial_origem	= :ll_cd_filial
		and de_serie			= :ls_de_serie
		and de_especie			= :ls_de_especie
	using SQLCA;
	
	Choose Case SQLCA.SQLCode
		Case -1
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao localizar a emiss$$HEX1$$e300$$ENDHEX$$o da nota da solicita$$HEX2$$e700e300$$ENDHEX$$o ' + ls_solicitacao + '. Erro: ' + SQLCA.SQLErrText, StopSign!)
			Exit
		Case 100
			Continue
	End Choose
			
	dw_2.Object.nr_nf[ll_for]						= ll_nr_nf
	dw_2.Object.de_serie[ll_for]					= ls_de_serie
	dw_2.Object.de_especie[ll_for]				= ls_de_especie		
	dw_2.Object.de_chave_acesso[ll_for]			= ls_de_chave_acesso
	dw_2.Object.dh_emissao[ll_for]				= ldt_dh_emissao
	dw_2.Object.id_situacao_nf[ll_for]			= ls_id_situacao_nfe
	dw_2.Object.de_erro_criar_nf[ll_for]		= ls_de_erro_autorizacao
	dw_2.Object.cd_filial_origem_nf[ll_for]	= ll_cd_filial
	dw_2.Object.id_nfe_impressa[ll_for]	= ls_id_nfe_impressa
	
	SetNull(ll_nr_nf)
	SetNull(ls_de_serie)
	SetNull(ls_de_especie)
	SetNull(ls_de_chave_acesso)
	SetNull(ldt_dh_emissao)
	SetNull(ls_id_situacao_nfe)
	SetNull(ls_de_erro_autorizacao)
	SetNull(ll_docnum)
	SetNull(ldt_authdate)
	SetNull(ls_id_status)
	SetNull(ls_de_log)
	SetNull(ll_cd_filial)
	SetNull(ls_id_nfe_impressa)
Next

Close(w_Aguarde)

SetPointer(Arrow!)

Return True
end function

public function boolean wf_validar_xmls ();Boolean	lb_xml_encontrado = False
Date		ldt_Emissao
Long		ll_Linhas, ll_Linha, ll_Linhas_Selecionadas, ll_Notas_Nao_Autorizadas, ll_Cd_Filial_Origem, &
			ll_Nr_Nf, ll_Qt_Impressa, ll_Chave_Integracao, ll_docnum, ll_nr_sequencial
String	ls_Chave_Acesso, ls_Autorizada, ls_id_xml_valido, ls_Especie, ls_Serie, ls_Erro, ls_id_situacao_nf, ls_mandt
			
			
uo_ge579_imprime_danfe_nfe	lo_ge579_imprime_nfe


Try
	Try
		SetPointer(HourGlass!)

		Open(w_Aguarde)

		w_Aguarde.Title = 'Buscando XMLs...'
		w_Aguarde.uo_Progress.of_SetMax(dw_2.RowCount())

		dw_2.SetRedraw(False)
		
		lo_ge579_imprime_nfe = Create uo_ge579_imprime_danfe_nfe
						
		ll_Linhas = dw_2.RowCount()
		
		For ll_Linha = 1 To ll_linhas
			w_Aguarde.Title = 'Buscando XMLs... '+String(ll_Linha)+' de '+String(ll_linhas)
			
			w_Aguarde.uo_Progress.of_SetProgress(ll_Linha)
			
			lb_xml_encontrado	= False			
			
			ls_Chave_Acesso		= dw_2.Object.de_chave_acesso[ll_Linha]
			
			If Len(ls_Chave_Acesso) = 44 then
				ls_id_xml_valido		= dw_2.Object.id_xml_valido[ll_Linha]
				
				if ls_id_xml_valido = 'S' then
					continue
				end if
				
				ldt_Emissao				= Date(dw_2.Object.dh_emissao[ll_Linha])
				ll_Cd_Filial_Origem	= dw_2.Object.cd_filial_origem_nf[ll_Linha]
				ll_Nr_Nf					= dw_2.Object.nr_nf[ll_Linha]
				ls_Especie				= dw_2.Object.de_especie[ll_Linha]
				ls_Serie					= dw_2.Object.de_serie[ll_Linha]
				ls_id_situacao_nf		= dw_2.Object.id_situacao_nf[ll_Linha]
				ll_docnum				= dw_2.Object.docnum[ll_Linha]
				ls_mandt					= dw_2.Object.mandt[ll_Linha]
				ll_nr_sequencial		= dw_2.Object.nr_sequencial[ll_Linha]
				
				If ls_id_situacao_nf = 'P' or ls_id_situacao_nf = '' then
					If Not lo_ge579_imprime_nfe.of_valida_xml_nfe(ll_Cd_Filial_Origem,&
																				 ll_Nr_Nf, &
																				 ls_Especie, &
																				 ls_Serie, &
																				 ls_Chave_Acesso, &
																				 ldt_Emissao, &
																				 REF ls_Erro, &
																				 lb_xml_encontrado) Then
	
						dw_2.SetRedraw(True)
						Close(w_Aguarde)
						Return False
					End If
				End if			
			End If
			
			if lb_xml_encontrado then
				update j_1bnfe_active
					set source = 'X'
				 where docnum = :ll_docnum
				 	and mandt = :ls_mandt
					and nr_sequencial = :ll_nr_sequencial
				using SQLCA;
				
				Choose Case SQLCA.SQLCode
					Case -1
						ls_Erro	= SQLCA.SQLErrText
						
						SQLCA.of_rollback()
						MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao atualizar a informa$$HEX2$$e700e300$$ENDHEX$$o de XML v$$HEX1$$e100$$ENDHEX$$lido na tabela j_1bnfe_active. ~r~rErro: ' + ls_Erro)
					Case 0
						SQLCA.of_commit()
				End Choose
				
				dw_2.Object.id_xml_valido[ll_Linha]	= 'S'
			end if
		Next
	Finally
		If IsValid(lo_ge579_imprime_nfe) Then Destroy(lo_ge579_imprime_nfe)
	End Try
Catch	( runtimeerror  lo_rte )
	MessageBox("Erro", "Erro ao validar o xml da nota: " + lo_rte.GetMessage())
End Try

dw_2.SetRedraw(True)
Close(w_Aguarde)
end function

public function boolean wf_ajusta_nf_tra_loja ();Boolean	lb_filial_sap
DateTime	ldt_dh_exportacao, ldt_dh_exportacao_conf
Long		ll_linhas, ll_for, ll_nr_nf, ll_cd_filial_origem, ll_cd_natureza_operacao
String	ls_de_especie, ls_de_serie, ls_id_sit_env_nf_transf_sap, ls_de_err_env_nf_transf_sap, ls_log, &
			ls_id_tipo_filial_sap, ls_id_tipo_nf, ls_id_sit_env_conf_receb_cd, ls_de_err_env_conf_receb_cd


ll_linhas	= dw_2.RowCount()

SetPointer(HourGlass!)

Open(w_Aguarde)

w_Aguarde.Title = 'Buscando dados...'
w_Aguarde.uo_Progress.of_SetMax(ll_linhas)

for ll_for = 1 to dw_2.RowCount()
	w_Aguarde.Title = 'Buscando dados... '+String(ll_for)+' de '+String(ll_linhas)
	
	w_Aguarde.uo_Progress.of_SetProgress(ll_for)
	
	ll_nr_nf					= dw_2.Object.nr_nf[ll_for]
	ll_cd_filial_origem	= dw_2.Object.cd_filial_origem[ll_for]
	ls_de_especie			= dw_2.Object.de_especie[ll_for]
	ls_de_serie				= dw_2.Object.de_serie[ll_for]
	
	if not gf_verifica_inicio_operacao_sap_loja(ll_cd_filial_origem, 'DH_INICIO_OPERACAO_SAP', REF lb_filial_sap, REF ls_log) then 
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_log, StopSign!)
		
		continue
	end if
	
	if lb_filial_sap then
		ls_id_tipo_filial_sap	= 'MM'
	else
		ls_id_tipo_filial_sap	= 'SD'
	end if
	
	dw_2.Object.tipo_loja_sap[ll_for]	= ls_id_tipo_filial_sap
	
	select Top 1 cd_natureza_operacao
	  into :ll_cd_natureza_operacao
	  from item_nf_transferencia
	 where nr_nf				= :ll_nr_nf
		and cd_filial_origem	= :ll_cd_filial_origem
		and de_especie			= :ls_de_especie
		and de_serie			= :ls_de_serie
	using SQLCA;
	
	Choose Case SQLCa.SQLCode
		Case -1
			ls_id_sit_env_nf_transf_sap	= 'E'
			ls_de_err_env_nf_transf_sap	= 'Erro ao localizar natureza de opera$$HEX2$$e700e300$$ENDHEX$$o:' + SQLCA.SQLErrText
		Case 100
			ls_id_sit_env_nf_transf_sap	= 'E'
			ls_de_err_env_nf_transf_sap	= 'N$$HEX1$$e300$$ENDHEX$$o foi encontrado os itens da transfer$$HEX1$$ea00$$ENDHEX$$ncia para checar a natureza de opera$$HEX2$$e700e300$$ENDHEX$$o.'
		Case 0
			if ll_cd_natureza_operacao = 6409 or ll_cd_natureza_operacao = 5409 or ll_cd_natureza_operacao = 6152 or ll_cd_natureza_operacao = 5152 then
				ls_id_tipo_nf	= 'TRANSFER$$HEX1$$ca00$$ENDHEX$$NCIA'
			else
				ls_id_tipo_nf	= 'DEVOLU$$HEX2$$c700c300$$ENDHEX$$O'
			end if
	End Choose
	
	dw_2.Object.tipo_nf[ll_for]	= ls_id_tipo_nf

	if ls_id_tipo_filial_sap = 'MM' then
		select id_status_integracao,
				 de_erro,
				 dh_exportacao
		  into :ls_id_sit_env_nf_transf_sap,
				 :ls_de_err_env_nf_transf_sap,
				 :ldt_dh_exportacao
		  from log_exportacao_sap
		 where id_tipo_nf		= '156'
			and id_tipo_log	= 88
			and nr_nf			= :ll_nr_nf
			and cd_filial		= :ll_cd_filial_origem
			and de_especie		= :ls_de_especie
			and de_serie		= :ls_de_serie
		using SQLCA;
		
		Choose Case SQLCa.SQLCode
			Case -1
				ls_id_sit_env_nf_transf_sap	= 'E'
				ls_de_err_env_nf_transf_sap	= 'Erro ao localizar log de envio para o SAP:' + SQLCA.SQLErrText
			Case 100
				ls_id_sit_env_nf_transf_sap	= 'E'
				ls_de_err_env_nf_transf_sap	= 'N$$HEX1$$e300$$ENDHEX$$o foi encontrado log de envio para o SAP'
			Case 0
				//
		End Choose
		
		dw_2.Object.dh_envio_sap[ll_for]	= ldt_dh_exportacao
	else
		ls_id_sit_env_nf_transf_sap	= 'P'
		ls_de_err_env_nf_transf_sap	= ''
	end if
	
	dw_2.Object.id_sit_env_nf_transf_sap[ll_for]	= ls_id_sit_env_nf_transf_sap
	dw_2.Object.de_err_env_nf_transf_sap[ll_for]	= ls_de_err_env_nf_transf_sap
	
	if ls_id_sit_env_nf_transf_sap = 'P' then
		select id_status_integracao,
				 de_erro,
				 dh_exportacao
		  into :ls_id_sit_env_conf_receb_cd,
				 :ls_de_err_env_conf_receb_cd,
				 :ldt_dh_exportacao_conf
		  from log_exportacao_sap
		 where id_tipo_nf		= 'CRN'
			and id_tipo_log	= 93
			and nr_nf			= :ll_nr_nf
			and cd_filial		= :ll_cd_filial_origem
			and de_especie		= :ls_de_especie
			and de_serie		= :ls_de_serie
		using SQLCA;
		
		Choose Case SQLCa.SQLCode
			Case -1
				ls_id_sit_env_conf_receb_cd	= 'E'
				ls_de_err_env_conf_receb_cd	= 'Erro ao localizar log de envio de confirma$$HEX2$$e700e300$$ENDHEX$$o para o SAP:' + SQLCA.SQLErrText
			Case 100
				ls_id_sit_env_conf_receb_cd	= 'E'
				ls_de_err_env_conf_receb_cd	= 'N$$HEX1$$e300$$ENDHEX$$o foi encontrado log de envio de confirma$$HEX2$$e700e300$$ENDHEX$$o para o SAP'
			Case 0
				//
		End Choose
	else
		dw_2.Object.id_sit_env_conf_receb_cd[ll_for]	= ''
		dw_2.Object.de_err_env_conf_receb_cd[ll_for]	= 'Ainda n$$HEX1$$e300$$ENDHEX$$o enviado'
	end if
	
	dw_2.Object.dh_envio_confirmacao_sap[ll_for]	= ldt_dh_exportacao_conf
	
	dw_2.Object.id_sit_env_conf_receb_cd[ll_for]	= ls_id_sit_env_conf_receb_cd
	dw_2.Object.de_err_env_conf_receb_cd[ll_for]	= ls_de_err_env_conf_receb_cd
Next

Close(w_Aguarde)

SetPointer(Arrow!)

Return True
end function

public function boolean wf_ajusta_nf_descarte ();DateTime	ldt_authdate, ldt_dh_emissao
Long		ll_for, ll_docnum, ll_nr_sequencial, ll_nr_nf, ll_cd_filial, ll_cd_fornecedor, ll_linhas, ll_nr_integracao, &
			ll_nr_agrupamento
String	ls_id_tipo_nf, ls_solicitacao, ls_mandt, ls_de_especie, ls_de_serie, ls_branch, ls_de_chave_acesso, ls_id_status, &
			ls_id_situacao_nfe, ls_de_erro_autorizacao, ls_de_log, ls_parid, ls_cd_fornecedor, ls_log, ls_cd_chave, ls_id_nfe_impressa


ll_linhas	= dw_2.RowCount()

SetPointer(HourGlass!)

Open(w_Aguarde)

w_Aguarde.Title = 'Buscando dados...'
w_Aguarde.uo_Progress.of_SetMax(ll_linhas)

for ll_for = 1 to ll_linhas
	w_Aguarde.Title = 'Buscando dados... '+String(ll_for)+' de '+String(ll_linhas)
	
	w_Aguarde.uo_Progress.of_SetProgress(ll_for)
	
	ls_solicitacao	= dw_2.Object.solicitacao[ll_for]
	ls_cd_chave		= dw_2.Object.cd_chave[ll_for]
	
	if IsNumber(ls_cd_chave) then
		ll_nr_integracao = Long(ls_cd_chave)
	else
		SetNull(ll_nr_integracao)
	end if
	
	if ll_nr_integracao > 0 then
		select nr_agrupamento_dev_compra
		  into :ll_nr_agrupamento
		  from wms_int_sap
		 where nr_integracao	= :ll_nr_integracao;
		 
		 Choose Case SQLCA.SQLCode
			Case -1
				MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao localizar a wms_int_sap da solicita$$HEX2$$e700e300$$ENDHEX$$o ' + ls_solicitacao + '. Erro: ' + SQLCA.SQLErrText, StopSign!)
				Exit
		End Choose
		
		if ll_nr_agrupamento > 0 then
			dw_2.Object.nr_agrupamento[ll_for] = ll_nr_agrupamento
		end if
	end if
				
	select distinct top 1 jbdoc.docnum, 
			 jbdoc.mandt,
			 jbdoc.nr_sequencial,
			 jbdoc.authdate,
			 jbdoc.branch,
			 jbdoc.id_status,
			 jbdoc.de_log
	  into :ll_docnum,
			 :ls_mandt,
			 :ll_nr_sequencial,
			 :ldt_authdate,
			 :ls_branch,
			 :ls_id_status,
			 :ls_de_log
	  from dbo.j_1bnflin jblin
	 inner join dbo.j_1bnfdoc_1 jbdoc 
		 on jblin.mandt  				= jbdoc.mandt 
		and jblin.docnum 				= jbdoc.docnum 
		and jblin.nr_sequencial 	= jbdoc.nr_sequencial 
	 where jblin.contrato 			= 'SOLIC|' + :ls_solicitacao
		and jbdoc.id_substituida 	= 'N'
		and jbdoc.authdate 			is not null
	using SQLCA;
	
	Choose Case SQLCA.SQLCode
		Case -1
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao localizar a j_1bnfdoc_1 da solicita$$HEX2$$e700e300$$ENDHEX$$o ' + ls_solicitacao + '. Erro: ' + SQLCA.SQLErrText, StopSign!)
			Exit
		Case 100
			select distinct top 1 jbdoc.docnum, 
					 jbdoc.mandt,
					 jbdoc.nr_sequencial,
					 jbdoc.authdate,
					 jbdoc.branch,
					 jbdoc.id_status,
					 jbdoc.de_log
			  into :ll_docnum,
					 :ls_mandt,
					 :ll_nr_sequencial,
					 :ldt_authdate,
					 :ls_branch,
					 :ls_id_status,
					 :ls_de_log
			  from dbo.j_1bnflin jblin
			 inner join dbo.j_1bnfdoc_1 jbdoc 
				 on jblin.mandt  				= jbdoc.mandt 
				and jblin.docnum 				= jbdoc.docnum 
				and jblin.nr_sequencial 	= jbdoc.nr_sequencial 
			 where jblin.contrato 			= "'SOLIC'" + :ls_solicitacao
				and jbdoc.id_substituida 	= 'N'
				and jbdoc.authdate 			is not null
			using SQLCA;
		
		Choose Case SQLCA.SQLCode
			Case -1
				MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao localizar a j_1bnfdoc_1 da solicita$$HEX2$$e700e300$$ENDHEX$$o ' + ls_solicitacao + '. Erro: ' + SQLCA.SQLErrText, StopSign!)
				Exit
			Case 100
				Continue
		End Choose
	End Choose
	
	dw_2.Object.docnum[ll_for]					= ll_docnum
	dw_2.Object.dh_processamento[ll_for]	= ldt_authdate
	
	if IsNull(ls_id_status) then ls_id_status = 'C'
	
	dw_2.Object.id_situacao_jdoc[ll_for]		= ls_id_status
	dw_2.Object.de_erro_recebimento[ll_for]	= ls_de_log
	
	select coalesce(cast(jbdoc2.nfenum as int), jbdoc2.nfnum),
			 coalesce(jbdoc2.series, 'U'),
			 cast('NFE' as char(3)),
			 jbdoc2.parid
	  into :ll_nr_nf,
			 :ls_de_serie,
			 :ls_de_especie,
			 :ls_parid
	  from dbo.j_1bnfdoc_2 jbdoc2
	 where jbdoc2.docnum 			= :ll_docnum
		and jbdoc2.mandt 				= :ls_mandt
		and jbdoc2.nr_sequencial 	= :ll_nr_sequencial
	using SQLCA;
		
	Choose Case SQLCA.SQLCode
		Case -1
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao localizar a j_1bnfdoc_2 da solicita$$HEX2$$e700e300$$ENDHEX$$o ' + ls_solicitacao + '. Erro: ' + SQLCA.SQLErrText, StopSign!)
			Exit
		Case 100
			Continue
	End Choose
	
	select isap.cd_chave_legado
	  into :ll_cd_filial
	  from integracao_sap isap
	 where isap.cd_tabela		= 'FILIAL'
		and isap.cd_chave_sap	= :ls_branch
	using SQLCA;
	
	Choose Case SQLCA.SQLCode
		Case -1
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao localizar a filial da solicita$$HEX2$$e700e300$$ENDHEX$$o ' + ls_solicitacao + '. Erro: ' + SQLCA.SQLErrText, StopSign!)
			Exit
		Case 100
			Continue
	End Choose
	
	select de_chave_acesso,
			 id_situacao, 
			 coalesce(id_nfe_impressa, 'N')
	  into :ls_de_chave_acesso,
			 :ls_id_situacao_nfe,
			 :ls_id_nfe_impressa
	  from nf_diversa_nfe ndn
	 where nr_nf				= :ll_nr_nf
		and cd_filial_origem	= :ll_cd_filial
		and de_serie			= :ls_de_serie
		and de_especie			= :ls_de_especie
	using SQLCA;
	
	Choose Case SQLCA.SQLCode
		Case -1
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao localizar a nota diversa' + ls_solicitacao + '. Erro: ' + SQLCA.SQLErrText, StopSign!)
			Exit
		Case 100
			Continue
		Case 0
			if ls_id_situacao_nfe = 'A' then ls_id_situacao_nfe = 'P'
			
			if ls_id_situacao_nfe <> 'P' then ls_de_erro_autorizacao = 'Erro ao autorizar a nota de diversa'
	End Choose
	
	select dh_emissao
	  into :ldt_dh_emissao
	  from nf_diversa
	 where nr_nf				= :ll_nr_nf
		and cd_filial_origem	= :ll_cd_filial
		and de_serie			= :ls_de_serie
		and de_especie			= :ls_de_especie
	using SQLCA;
	
	Choose Case SQLCA.SQLCode
		Case -1
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao localizar a emiss$$HEX1$$e300$$ENDHEX$$o da nota da solicita$$HEX2$$e700e300$$ENDHEX$$o ' + ls_solicitacao + '. Erro: ' + SQLCA.SQLErrText, StopSign!)
			Exit
		Case 100
			Continue
	End Choose
			
	dw_2.Object.nr_nf[ll_for]						= ll_nr_nf
	dw_2.Object.de_serie[ll_for]					= ls_de_serie
	dw_2.Object.de_especie[ll_for]				= ls_de_especie		
	dw_2.Object.de_chave_acesso[ll_for]			= ls_de_chave_acesso
	dw_2.Object.dh_emissao[ll_for]				= ldt_dh_emissao
	dw_2.Object.id_situacao_nf[ll_for]			= ls_id_situacao_nfe
	dw_2.Object.de_erro_criar_nf[ll_for]		= ls_de_erro_autorizacao
	dw_2.Object.cd_filial_origem_nf[ll_for]	= ll_cd_filial
	dw_2.Object.id_nfe_impressa[ll_for]	= ls_id_nfe_impressa
	
	SetNull(ll_nr_nf)
	SetNull(ls_de_serie)
	SetNull(ls_de_especie)
	SetNull(ls_de_chave_acesso)
	SetNull(ldt_dh_emissao)
	SetNull(ls_id_situacao_nfe)
	SetNull(ls_de_erro_autorizacao)
	SetNull(ll_docnum)
	SetNull(ldt_authdate)
	SetNull(ls_id_status)
	SetNull(ls_de_log)
	SetNull(ll_cd_filial)
	SetNull(ll_nr_agrupamento)
	SetNull(ls_id_nfe_impressa)
Next

Close(w_Aguarde)

SetPointer(Arrow!)

Return True
end function

public function boolean wf_filtra_nf_postretrieve ();String  ls_Filter = "", &
			ls_de_serie, &
			ls_de_especie, &
			ls_Situacao_Imp
			
Long ll_nr_nf, &
		ll_nr_agrupamento

dw_1.AcceptText()

ll_nr_nf				= dw_1.Object.nr_nf[1]
ls_de_serie			= dw_1.Object.de_serie[1]
ls_de_especie		= dw_1.Object.de_especie[1]
ls_Situacao_Imp 	= dw_1.Object.id_situacao_impressao[1]

If Not IsNull(ll_nr_nf) and ll_nr_nf > 0 Then
	wf_controle_filtro_post( 'nr_nf = ' + string(ll_nr_nf), Ref ls_Filter)
End If

If Not IsNull(ls_de_serie) and ls_de_serie <> "" Then
	wf_controle_filtro_post( "de_serie = '" + ls_de_serie + "'", Ref ls_Filter)
End If

If Not IsNull(ls_de_especie) and ls_de_especie <> "" Then
	wf_controle_filtro_post( "de_especie = '" + ls_de_especie + "'", Ref ls_Filter)
End If

If ls_Situacao_Imp <> "T" Then
	If ls_Situacao_Imp = "S" Then
		wf_controle_filtro_post( " id_nfe_impressa = 'S' " , Ref ls_Filter)
	Else
		wf_controle_filtro_post( "  id_nfe_impressa = 'N' " , Ref ls_Filter)
	End If
End If
		
Choose Case is_id_tipo_nf
	Case 'DEV'
		ll_nr_agrupamento	= dw_1.Object.nr_agrupamento[1]
		
		If Not IsNull(ll_nr_agrupamento) and ll_nr_agrupamento > 0 Then
			wf_controle_filtro_post( 'nr_agrupamento = ' + string(ll_nr_agrupamento), Ref ls_Filter)
		End If
		
	//Case 'TRA'
		//
	//Case 'SUC'
		//
	//Case 'LIC'
		//
	//Case 'INV'
		//
	//Case 'DES'
		//
	//Case 'TFI'
		//
End Choose

If ls_Filter <> "" Then
	dw_2.SetFilter( ls_Filter )
	dw_2.Filter( )
	dw_2.SetRedraw(True)
	dw_2.SetFilter( "" )
End If

Return true
end function

public function boolean wf_bloqueia_desbloqueia_filtros ();If is_id_tipo_nf = "DEV" Then
	This.wf_muda_cores_campos_dev( True )
	
	dw_1.object.id_filtra_divergentes.Protect = 0
	dw_1.object.id_filtra_divergentes.Visible = 1
	
	cb_envio_email_forn.enabled = True
	cb_envio_email_forn.text = "Enviar XML's/DANFE's Para Forn."
	cb_imp_etiqueta.enabled = True
	
ElseIf is_id_tipo_nf = "LIC" Then
	This.wf_muda_cores_campos_dev( False )
	
	dw_1.object.id_filtra_divergentes.Protect = 1
	dw_1.object.id_filtra_divergentes.Visible = 0
	
	cb_envio_email_forn.enabled = True
	cb_envio_email_forn.text = "Enviar XML's/DANFE's Para Transp."
	cb_imp_etiqueta.enabled = False
	
Else
	This.wf_muda_cores_campos_dev( False )
	
	dw_1.object.id_filtra_divergentes.Protect = 1
	dw_1.object.id_filtra_divergentes.Visible = 0
	
	cb_envio_email_forn.enabled = False
	cb_imp_etiqueta.enabled = False
	
End If

Return True
end function

public function boolean wf_controle_filtro_post (string as_termo_filtro, ref string as_filtro);If as_filtro <> "" Then
	as_filtro += " and " + as_termo_filtro
Else
	as_filtro = as_termo_filtro
End If

Return true
end function

public function boolean wf_ajusta_nf_licitacao ();DateTime	ldt_authdate, ldt_dh_emissao, ldt_dh_exportacao
Long		ll_for, ll_docnum, ll_nr_sequencial, ll_nr_nf, ll_cd_filial_origem, ll_linhas, ll_count, ll_for_items, ll_linha_nova, &
			ll_cd_filial, ll_count_total_produtos, ll_nr_pedido_distribuidora, ll_contador_pedidos
String	ls_id_tipo_nf, ls_solicitacao, ls_mandt, ls_de_especie, ls_de_serie, ls_branch, ls_de_chave_acesso, ls_id_status, &
			ls_id_situacao_nfe, ls_de_erro_autorizacao, ls_de_log, ls_solicitacao_aux, ls_id_status_integracao, ls_nr_solicitacoes[], ls_id_nfe_impressa

dc_uo_ds_base lds_lista_docnum_ped


ll_linhas	= dw_2.RowCount()

SetPointer(HourGlass!)

Open(w_Aguarde)

w_Aguarde.Title = 'Buscando dados...'
w_Aguarde.uo_Progress.of_SetMax(ll_linhas)

ll_contador_pedidos	= 1

dw_2.SetRedraw(False)

for ll_for = 1 to ll_linhas
	w_Aguarde.Title = 'Buscando dados das notas fiscais... '+String(ll_for)+' de '+String(ll_linhas)
	
	w_Aguarde.uo_Progress.of_SetProgress(ll_for)
	
	ls_solicitacao = Right(fill('0', 10) + dw_2.Object.solicitacao[ll_for], 10)	
			
	select top 1 jbdoc.docnum, 
			 jbdoc.mandt,
			 jbdoc.nr_sequencial,
			 jbdoc.authdate,
			 jbdoc.branch,
			 jbdoc.id_status,
			 jbdoc.de_log
	  into :ll_docnum,
			 :ls_mandt,
			 :ll_nr_sequencial,
			 :ldt_authdate,
			 :ls_branch,
			 :ls_id_status,
			 :ls_de_log
	  from dbo.j_1bnflin jblin
	 inner join dbo.j_1bnfdoc_1 jbdoc 
		 on jblin.mandt  			= jbdoc.mandt 
		and jblin.docnum 			= jbdoc.docnum 
		and jblin.nr_sequencial = jbdoc.nr_sequencial 
	 inner join dbo.j_1bnfdoc_2 jbdoc2 
		 on jbdoc.mandt 			= jbdoc2.mandt
		and jbdoc.docnum 			= jbdoc2.docnum
		and jbdoc.nr_sequencial	= jbdoc2.nr_sequencial
	inner join nf_venda nv 
		on nv.nr_nf  = cast(jbdoc2.nfenum as int)
		and nv.de_serie = jbdoc2.series
		and nv.de_especie = 'NFE'
	 where jblin.xped 				= :ls_solicitacao
		and jbdoc.id_substituida 	= 'N'
		and jbdoc.authdate 			is not null
		and nv.dh_cancelamento is null
		and jbdoc2.nftype				<> 'ZF'
	 group by jbdoc.docnum, 
				 jbdoc.mandt,
				 jbdoc.nr_sequencial,
				 jbdoc.authdate,
				 jbdoc.branch,
				 jbdoc.id_status,
				 jbdoc.de_log
	using SQLCA;
	
	Choose Case SQLCA.SQLCode
		Case -1
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao localizar a j_1bnfdoc_1 da solicita$$HEX2$$e700e300$$ENDHEX$$o ' + ls_solicitacao_aux + '. Erro: ' + SQLCA.SQLErrText, StopSign!)
			Exit
		Case 100
			Continue
		Case 0
			dw_2.Object.docnum[ll_for]					= ll_docnum
			dw_2.Object.dh_processamento[ll_for]	= ldt_authdate

			If IsNull(ls_id_status) Then ls_id_status = 'C'
		
			dw_2.Object.id_situacao_jdoc[ll_for]		= ls_id_status
			dw_2.Object.de_erro_recebimento[ll_for]	= ls_de_log
	End Choose
	
	select top 1 coalesce(cast(jbdoc2.nfenum as int), jbdoc2.nfnum),
			 coalesce(jbdoc2.series, 'U'),
			 cast('NFE' as char(3))
	  into :ll_nr_nf,
			 :ls_de_serie,
			 :ls_de_especie
	  from dbo.j_1bnfdoc_2 jbdoc2
	 where jbdoc2.docnum 			= :ll_docnum
		and jbdoc2.mandt 				= :ls_mandt
		and jbdoc2.nr_sequencial 	= :ll_nr_sequencial
	using SQLCA;
		
	Choose Case SQLCA.SQLCode
		Case -1
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao localizar a j_1bnfdoc_2 da solicita$$HEX2$$e700e300$$ENDHEX$$o ' + ls_solicitacao_aux + '. Erro: ' + SQLCA.SQLErrText, StopSign!)
			Exit
		Case 100
			Continue
	End Choose
	
	select isap.cd_chave_legado
	  into :ll_cd_filial_origem
	  from integracao_sap isap
	 where isap.cd_tabela		= 'FILIAL'
		and isap.cd_chave_sap	= :ls_branch
	using SQLCA;
	
	Choose Case SQLCA.SQLCode
		Case -1
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao localizar a filial da solicita$$HEX2$$e700e300$$ENDHEX$$o ' + ls_solicitacao_aux + '. Erro: ' + SQLCA.SQLErrText, StopSign!)
			Exit
		Case 100
			Continue
	End Choose
	

	Select jactive.regio || jactive.nfyear || jactive.nfmonth || jactive.stcd1 || cast(jactive.model as char(2)) || jactive.serie || jactive.nfnum9 || jactive.docnum9 || jactive.cdv, action_date, case when jactive.code = '100' then 'P' else '' end
	  into :ls_de_chave_acesso,
			 :ldt_dh_emissao,
			 :ls_id_situacao_nfe
	  from j_1bnfe_active as jactive
	 where jactive.docnum 			= :ll_docnum
		and jactive.mandt 			= :ls_mandt
		and jactive.nr_sequencial 	= :ll_nr_sequencial
	using SQLCA;
		
	Choose Case SQLCA.SQLCode
		Case -1
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao localizar a j_1bnfe_active da solicita$$HEX2$$e700e300$$ENDHEX$$o ' + ls_solicitacao_aux + '. Erro: ' + SQLCA.SQLErrText, StopSign!)
			Exit
		Case 100
			Continue
	End Choose
	
	If IsNull(ldt_dh_emissao) Or ldt_dh_emissao = datetime('1900-01-01 00:00:00') Then
		select dh_movimentacao_caixa
		  into :ldt_dh_emissao
		  from nf_transferencia nt
		 where nt.nr_nf				= :ll_nr_nf
			and nt.cd_filial_origem	= :ll_cd_filial_origem
			and nt.de_serie			= :ls_de_serie
			and nt.de_especie			= :ls_de_especie
		using SQLCA;
		
		Choose Case SQLCA.SQLCode
			Case -1
				MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao localizar a emiss$$HEX1$$e300$$ENDHEX$$o da nota da solicita$$HEX2$$e700e300$$ENDHEX$$o ' + ls_solicitacao_aux + '. Erro: ' + SQLCA.SQLErrText, StopSign!)
				Exit
			Case 100
				Continue
		End Choose
	End If
	
	select coalesce(id_nfe_impressa, 'N')
	  into :ls_id_nfe_impressa
	  from nf_venda nv
	 where nv.nr_nf				= :ll_nr_nf
		and nv.cd_filial				= :ll_cd_filial_origem
		and nv.de_serie			= :ls_de_serie
		and nv.de_especie			= :ls_de_especie
		and cd_canal_venda 		= 'LI'
	using SQLCA;
	
	Choose Case SQLCA.SQLCode
		Case -1
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao localizar status da impress$$HEX1$$e300$$ENDHEX$$o da nota da solicita$$HEX2$$e700e300$$ENDHEX$$o ' + ls_solicitacao_aux + '. Erro: ' + SQLCA.SQLErrText, StopSign!)
			Exit
		Case 100
			Continue
	End Choose
	
	dw_2.Object.nr_nf[ll_for]						= ll_nr_nf
	dw_2.Object.de_serie[ll_for]					= ls_de_serie
	dw_2.Object.de_especie[ll_for]				= ls_de_especie		
	dw_2.Object.de_chave_acesso[ll_for]			= ls_de_chave_acesso
	dw_2.Object.dh_emissao[ll_for]				= ldt_dh_emissao
	dw_2.Object.id_situacao_nf[ll_for]			= ls_id_situacao_nfe
	dw_2.Object.de_erro_criar_nf[ll_for]		= ls_de_erro_autorizacao
	dw_2.Object.cd_filial_origem_nf[ll_for]	= ll_cd_filial_origem
	dw_2.Object.id_nfe_impressa[ll_for]	= ls_id_nfe_impressa
	
	SetNull(ll_nr_nf)
	SetNull(ls_de_serie)
	SetNull(ls_de_especie)
	SetNull(ls_de_chave_acesso)
	SetNull(ldt_dh_emissao)
	SetNull(ls_id_situacao_nfe)
	SetNull(ls_de_erro_autorizacao)
	SetNull(ll_docnum)
	SetNull(ldt_authdate)
	SetNull(ls_id_status)
	SetNull(ls_de_log)
	SetNull(ll_cd_filial_origem)
	SetNull(ls_id_nfe_impressa)
Next

dw_2.SetRedraw(True)

Close(w_Aguarde)

SetPointer(Arrow!)

Return True
end function

public function boolean wf_imprime_etiquetas ();Long 		ll_Volumes,&
			ll_Nota,&
			ll_Linhas_Selecionadas,&
			ll_Qt_Impressa,&
			ll_Linha,&
			ll_Linhas,&
			ll_Nr_Nf, &
			ll_row,&
			ll_Retorno = 0,&
			ll_Notas_Nao_Autorizadas,&
			ll_qt_Volume
String		ls_Especie,&
			ls_Serie,&
			ls_id_situacao_nf,&
			ls_Chave_Acesso,&
			ls_Cd_Fornecedor,&
			ls_Nm_Fornecedor
Datetime ldt_Emissao

dc_uo_ds_Base lds_lista
lds_lista = create dc_uo_ds_Base
lds_lista.Of_ChangeDataObject('dw_ge645_resp_lista_imp_etiqueta')

Try
	
	dw_2.AcceptText()
	
	ll_Linhas_Selecionadas = dw_2.GetItemNumber(dw_2.RowCount(), "qt_notas_selecionadas")
	If ll_Linhas_Selecionadas < 1 Then
		MessageBox("Aviso", "N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ nota selecionada para ser impressa.")
		Return false
	End If
	
	ll_Notas_Nao_Autorizadas = dw_2.GetItemNumber(dw_2.RowCount(), "qt_notas_nao_autorizadas")

	If (ll_Notas_Nao_Autorizadas > 0) Then
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existem notam selecionadas que n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e300$$ENDHEX$$o autorizadas.~rEssas notas n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e300$$ENDHEX$$o impressas.~rDeseja continuar?", Question!, YesNo!, 2) = 2 Then
			Return false
		End If	
	End If

	ll_linhas = dw_2.rowcount()
	
	Open(w_Aguarde)
	
	For ll_Linha = 1 To ll_linhas
		If dw_2.Object.id_imprimir[ll_Linha] = 'S' Then
			ls_id_situacao_nf		= dw_2.Object.id_situacao_nf		[ll_Linha]
			ll_Nr_Nf					= dw_2.Object.nr_nf					[ll_Linha]
			ls_Especie				= dw_2.Object.de_especie			[ll_Linha]
			ls_Serie					= dw_2.Object.de_serie				[ll_Linha]
			ls_Cd_Fornecedor		= dw_2.Object.cd_fornecedor		[ll_Linha]
			ls_Nm_Fornecedor		= dw_2.Object.nm_fornecedor		[ll_Linha]
			ldt_Emissao				= Datetime(dw_2.Object.dh_emissao	[ll_Linha])
			ls_Chave_Acesso		= dw_2.Object.de_chave_acesso	[ll_Linha]
			ll_qt_Volume			= dw_2.Object.qt_volume				[ll_Linha]
			//ll_Cd_Filial_Origem	= dw_2.Object.cd_filial_origem_nf[ll_Linha]
			//If isnull(ll_Cd_Filial_Origem) Then	ll_Cd_Filial_Origem	= dw_2.Object.cd_filial[ll_Linha]
			
			If ls_id_situacao_nf = 'P' or ls_id_situacao_nf = '' then
				If is_id_tipo_nf = 'DEV' Then
					
					ll_row = lds_lista.InsertRow(0)
					lds_lista.SetItem(ll_row, "nr_nf", ll_Nr_Nf)
					lds_lista.SetItem(ll_row, "de_especie", ls_Especie)
					lds_lista.SetItem(ll_row, "de_serie", ls_Serie)
					lds_lista.SetItem(ll_row, "cd_fornecedor", ls_Cd_Fornecedor)
					lds_lista.SetItem(ll_row, "nm_fornecedor", ls_Nm_Fornecedor)
					lds_lista.SetItem(ll_row, "de_chave", ls_Chave_Acesso)
					lds_lista.SetItem(ll_row, "dh_emissao", ldt_Emissao)
					lds_lista.SetItem(ll_row, "nr_volumes", ll_qt_Volume)
					//lds_lista.SetItem(ll_row, "id_situacao_nf", ls_id_situacao_nf)
					
				End If
			End if
		End If						
	Next
	
	If lds_lista.rowcount() > 0 Then
		OpenWithParm(w_ge645_response_imp_etiquetas, lds_lista)
		//ll_Retorno = long(Message.StringParm)
	End If
	
Finally
	If isvalid(w_Aguarde) Then close(w_Aguarde)
	Destroy(lds_lista)
End Try

Return True

end function

public subroutine wf_muda_cores_campos_dev (boolean ab_ativo);If ab_ativo Then
	dw_1.object.nm_usuario.Protect = 0
	dw_1.object.nm_usuario.Background.Color = "16777215"
	dw_1.object.nm_usuario.Color = "0"
	
	dw_1.object.nr_matricula.Protect = 0
	dw_1.object.nr_matricula.Background.Color = "16777215"
	dw_1.object.nr_matricula.Color = "0"
	
	dw_1.object.id_status_envio.Protect = 0
	dw_1.object.id_status_envio.Background.Color = "16777215"
	dw_1.object.id_status_envio.Color = "0"
	
	dw_1.object.id_status_nf.Protect = 0
	dw_1.object.id_status_nf.Background.Color = "16777215"
	dw_1.object.id_status_nf.Color = "0"
	
	dw_1.object.id_status_receb.Protect = 0
	dw_1.object.id_status_receb.Background.Color = "16777215"
	dw_1.object.id_status_receb.Color = "0"
	
	dw_1.object.cd_fornecedor.Protect = 0
	dw_1.object.cd_fornecedor.Background.Color = "16777215"
	dw_1.object.cd_fornecedor.Color = "0"
	
	dw_1.object.nm_fornecedor.Protect = 0
	dw_1.object.nm_fornecedor.Background.Color = "16777215"
	dw_1.object.nm_fornecedor.Color = "0"
	
	dw_1.object.id_tipo_devolucao.Protect = 0
	dw_1.object.id_tipo_devolucao.Background.Color = "16777215"
	dw_1.object.id_tipo_devolucao.Color = "0"
	
	dw_1.object.nr_agrupamento.Protect = 0
	dw_1.object.nr_agrupamento.Background.Color = "16777215"
	dw_1.object.nr_agrupamento.Color = "0"
	
Else
	dw_1.object.nm_usuario.Protect = 1
	dw_1.object.nm_usuario.Background.Color = "134217750"
	dw_1.object.nm_usuario.Color = "134217750"
	
	dw_1.object.nr_matricula.Protect = 1
	dw_1.object.nr_matricula.Background.Color = "134217750"
	dw_1.object.nr_matricula.Color = "134217750"
	
	dw_1.object.id_status_envio.Protect = 1
	dw_1.object.id_status_envio.Background.Color = "134217750"
	dw_1.object.id_status_envio.Color = "134217750"
	
	dw_1.object.id_status_nf.Protect = 1
	dw_1.object.id_status_nf.Background.Color = "134217750"
	dw_1.object.id_status_nf.Color = "134217750"
	
	dw_1.object.id_status_receb.Protect = 1
	dw_1.object.id_status_receb.Background.Color = "134217750"
	dw_1.object.id_status_receb.Color = "134217750" //"134217744"
	
	dw_1.object.cd_fornecedor.Protect = 1
	dw_1.object.cd_fornecedor.Background.Color = "134217750"
	dw_1.object.cd_fornecedor.Color = "134217750"
	
	dw_1.object.nm_fornecedor.Protect = 1
	dw_1.object.nm_fornecedor.Background.Color = "134217750"
	dw_1.object.nm_fornecedor.Color = "134217750"

	dw_1.object.id_tipo_devolucao.Protect = 1
	dw_1.object.id_tipo_devolucao.Background.Color = "134217750"
	dw_1.object.id_tipo_devolucao.Color = "134217750"
	
	dw_1.object.nr_agrupamento.Protect = 1
	dw_1.object.nr_agrupamento.Background.Color = "134217750"
	dw_1.object.nr_agrupamento.Color = "134217750"
	
End If

end subroutine

on w_ge645_impressao_nfe.create
int iCurrent
call super::create
this.cb_imprimir=create cb_imprimir
this.st_1=create st_1
this.ddlb_impressoras=create ddlb_impressoras
this.cb_reenviar_dev=create cb_reenviar_dev
this.cb_envio_email_forn=create cb_envio_email_forn
this.cb_imp_etiqueta=create cb_imp_etiqueta
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_imprimir
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.ddlb_impressoras
this.Control[iCurrent+4]=this.cb_reenviar_dev
this.Control[iCurrent+5]=this.cb_envio_email_forn
this.Control[iCurrent+6]=this.cb_imp_etiqueta
end on

on w_ge645_impressao_nfe.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_imprimir)
destroy(this.st_1)
destroy(this.ddlb_impressoras)
destroy(this.cb_reenviar_dev)
destroy(this.cb_envio_email_forn)
destroy(this.cb_imp_etiqueta)
end on

event ue_postopen;call super::ue_postopen;Long 		ll_rc, ll_printerCount, ll_for
String 	ls_printers[] 


dw_1.Object.dh_inicio[1] 	= RelativeDate(Date(gf_GetServerDate()),  -6)
dw_1.Object.dh_fim[1] 		= Date(gf_GetServerDate())

ddlb_impressoras.addItem("")

ll_rc = RegistryValues("HKEY_CURRENT_USER\Software\Microsoft\Windows NT\CurrentVersion\Devices", ls_printers) 

If ll_rc > 0 then 
	ll_printerCount = UpperBound(ls_printers) 
	For ll_for = 1 to ll_printerCount 
		ddlb_impressoras.addItem(ls_printers[ll_for])
	Next 
End If 

ddlb_impressoras.text =  ProfileString(  "c:\sistemas\ws\exe\wms.ini", "Impressora_Danfe", "Impressora_" + gvo_Aplicacao.ivo_seguranca.nr_matricula, "")

iuo_ge473_comum	= Create uo_ge473_comum

ivo_Fornecedor 	= Create uo_Fornecedor

ivo_Usuario = Create uo_Usuario

wf_bloqueia_desbloqueia_filtros()

If not IsValid(SQLCA_CONSULTA) then
	SQLCA_CONSULTA	= create dc_uo_transacao
	SQLCA_CONSULTA.ivs_database = "SYBASE"
End if

If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema	<> "WS" Then	
	cb_imp_etiqueta.visible 		= False
	cb_reenviar_dev.visible 		= False
	cb_envio_email_forn.visible 	= False
End If
end event

event close;call super::close;Destroy(ivo_Fornecedor)
Destroy ivo_Usuario
If isvalid(ids_Lista_de_Divergencias) then destroy(ids_Lista_de_Divergencias)
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge645_impressao_nfe
integer y = 1360
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge645_impressao_nfe
integer y = 1288
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge645_impressao_nfe
integer x = 5
integer y = 472
integer width = 6030
integer height = 1780
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge645_impressao_nfe
integer x = 5
integer y = 0
integer width = 6025
integer height = 448
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge645_impressao_nfe
integer x = 46
integer y = 68
integer width = 5957
integer height = 332
string dataobject = "dw_ge645_parametros"
end type

event dw_1::itemchanged;call super::itemchanged;Long		ll_nulo

SetNull(ll_nulo)

dw_2.Reset()

Choose Case dwo.Name 
	Case "nm_fantasia"
		If data = "" or IsNull(data) Then
			This.Object.cd_filial[1] = ll_nulo
		Else
			If Data <> io_filial.nm_fantasia Then Return 1
		End If
		
	Case "id_tipo_nf"
		is_id_tipo_nf = Data
		wf_bloqueia_desbloqueia_filtros()
		
		dw_2.of_settransobject(SQLCA)
		
		Choose Case is_id_tipo_nf
			Case 'TRA'
				dw_2.of_ChangeDataObject('dw_ge645_lista_nf_transf_cd_sap')
			Case 'DEV'
				dw_2.of_ChangeDataObject('dw_ge645_lista_nf_dev_cd_sap')
			Case 'SUC'
				dw_2.of_ChangeDataObject('dw_ge645_lista_nf_sucata')
			Case 'LIC'
				dw_2.of_ChangeDataObject('dw_ge645_lista_nf_licitacao')
			Case 'INV'
				dw_2.of_ChangeDataObject('dw_ge645_lista_nf_inventario')
			Case 'TFI'
				dw_2.of_ChangeDataObject('dw_ge645_lista_nf_tra_loja')
			Case 'DES'
				dw_2.of_ChangeDataObject('dw_ge645_lista_nf_descarte')
		End Choose
		
	Case "nm_fornecedor"
		If Trim(Data) <> "" Then
			If Data <> ivo_fornecedor.nm_Fantasia Then
				Return 1
			End If	
		Else			
			
			ivo_fornecedor.of_Inicializa()
			
			This.Object.Cd_Fornecedor		[1] = ivo_fornecedor.Cd_Fornecedor
			This.Object.Nm_Fornecedor		[1] = ivo_fornecedor.Nm_Fantasia			
		End If
		
	Case "nm_usuario"
		If Trim(Data) <> "" and Not IsNull(Data) Then
			If Data <> ivo_Usuario.nm_usuario Then
				Return 1
			End If
		Else
			ivo_Usuario.of_Inicializa()
			
			This.Object.Nr_Matricula			 [1] = ivo_Usuario.Nr_Matricula
			This.Object.Nm_Usuario       	 [1] = ivo_Usuario.Nm_Usuario
		End If	
		
End Choose
end event

event dw_1::ue_key;call super::ue_key;String ls_Filial

		
If Key = KeyEnter! Then
	If This.GetColumnName() = "nm_fantasia" Then
		ls_Filial = dw_1.GetText()

		io_Filial.of_Localiza_Filial(ls_Filial)

		If io_Filial.Localizada  Then
			dw_1.Object.cd_filial[1] 	= io_Filial.cd_filial
			dw_1.Object.nm_fantasia[1] = io_Filial.nm_fantasia
		Else
			SetNull(io_Filial.Cd_Filial)
			io_Filial.Nm_Fantasia = ""

			dw_1.Object.cd_filial[1] 	= io_filial.cd_filial
			dw_1.Object.nm_fantasia[1] = io_filial.nm_fantasia
		End If
	End If	
	
	If This.GetColumnName() = "nm_fornecedor" Then
		
		ivo_fornecedor.of_Localiza_Fornecedor(This.GetText())
		
		If ivo_fornecedor.Localizado Then
			This.Object.Cd_fornecedor	[1] = ivo_fornecedor.Cd_Fornecedor
			This.Object.Nm_fornecedor	[1] = ivo_fornecedor.Nm_Fantasia
		End If
	End If
	
	If This.GetColumnName() = "nm_usuario" Then
	
		ivo_Usuario.of_Localiza_Usuario( This.GetText() )
		
		If ivo_Usuario.Localizado Then
			This.Object.Nr_Matricula		[1] = ivo_Usuario.Nr_Matricula
			This.Object.Nm_Usuario		[1] = ivo_Usuario.Nm_Usuario
		End If
		
	End If
End If

end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge645_impressao_nfe
integer x = 46
integer y = 520
integer width = 5984
integer height = 1708
string dataobject = "dw_ge645_lista_nf_transf_cd_sap"
boolean hscrollbar = true
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_postretrieve;call super::ue_postretrieve;Choose Case is_id_tipo_nf
	Case 'TRA'
		wf_ajusta_nf_transferencia()
		wf_filtra_nf_postretrieve()
		wf_validar_xmls()
		
	Case 'DEV'
		wf_filtra_nf_postretrieve()
		wf_validar_xmls()
		
	Case 'DES'
		wf_ajusta_nf_descarte()
		wf_filtra_nf_postretrieve()
		wf_validar_xmls()
		
	Case 'SUC'
		wf_ajusta_nf_sucata()
		wf_filtra_nf_postretrieve()
		wf_validar_xmls()
		
	Case 'INV'
		wf_ajusta_nf_inventario()
		wf_filtra_nf_postretrieve()
		wf_validar_xmls()
		
	Case 'TFI'
		wf_ajusta_nf_tra_loja()
		wf_filtra_nf_postretrieve()
		
	Case 'LIC'
		wf_ajusta_nf_licitacao()
		wf_filtra_nf_postretrieve()
		wf_validar_xmls()
		
End Choose

If dw_2.rowcount() > 0 Then dw_2.ivo_Controle_Menu.of_SalvarComo(True)

Return 1
end event

event dw_2::ue_recuperar;wf_filtra_nf()

return 1
end event

event dw_2::buttonclicked;call super::buttonclicked;String ls_Parametro

Choose case dwo.name
	Case "bt_info"
		If is_id_tipo_nf = "DEV" Then MessageBox('Dados Adicionais Solicita$$HEX2$$e700e300$$ENDHEX$$o: ' +string(this.object.solicitacao[row]), string(this.object.de_dados_adicionais [row]) )
		
	Case "bt_nfo"
		If is_id_tipo_nf = "DEV" Then OpenWithParm(w_ge645_response_produtos_nfo, string(this.object.cd_chave[row]))
		
	Case "bt_launch"
		If is_id_tipo_nf = "DEV" Then 
			ls_Parametro = string(this.object.cd_chave[row]) + '@' + string(this.object.nr_nf[row]) + '#' + string(this.object.de_serie[row]) + '$' + string(this.object.de_especie[row]) + '%' + string(this.object.dh_inclusao[row]) //+ string(this.object.de_chave_acesso[row])

			w_ge541_wms_int_sap_monitor lw_ge541
			OpenSheetWithParm(lw_ge541, ls_Parametro,  dc_w_MDI, 2, Original!)
			
		End If
		
End Choose


end event

event dw_2::doubleclicked;call super::doubleclicked;Long ll_Row

String ls_Marcacao

If dwo.Name 			= 'id_imagem' Then
	If ib_Check Then
		ls_Marcacao	= 'N'
		ib_Check		= False
		//st_confirmar.Text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para marcar todos."
	Else
		ls_Marcacao	= 'S'
		ib_Check		= True
		//st_confirmar.Text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para desmarcar todos."
	End If
	
	For ll_Row = 1 To This.RowCount()
		//If This.Object.id_autorizada[ll_Row] = 'S' Then		
			This.Object.id_imprimir[ll_Row] = ls_Marcacao
		//End If
	Next
	
End If
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge645_impressao_nfe
integer x = 2875
integer y = 1012
end type

type cb_imprimir from commandbutton within w_ge645_impressao_nfe
integer x = 4626
integer y = 56
integer width = 402
integer height = 108
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Imprimir NF"
end type

event clicked;Date		ldt_Emissao
Long		ll_Linhas, ll_Linha, ll_Linhas_Selecionadas, ll_Notas_Nao_Autorizadas, ll_Cd_Filial_Origem, &
			ll_Nr_Nf, ll_Qt_Impressa
String	ls_Chave_Acesso, ls_Impressora, ls_Autorizada, ls_Especie, ls_Serie, ls_Erro, ls_id_situacao_nf, ls_solicitacao
Boolean lb_Duas_Vias = False

uo_ge579_imprime_danfe_nfe	lo_ge579_imprime_nfe

dw_2.AcceptText()

ll_Linhas = dw_2.RowCount()

ls_Impressora = Trim(ddlb_impressoras.text)

If ll_Linhas < 1 Then
	MessageBox("Aviso", "N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ registros para ser impresso.")
	Return 1
End If

If ls_Impressora = "" Then
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ nenhuma impressora selecionada.~rDeseja continuar?", Question!, YesNo!, 2) = 2 Then
		ddlb_impressoras.setFocus()
		Return 1
	End If	
End If

ll_Linhas_Selecionadas = dw_2.GetItemNumber(dw_2.RowCount(), "qt_notas_selecionadas")
		
If ll_Linhas_Selecionadas < 1 Then
	MessageBox("Aviso", "N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ nota selecionada para ser impressa.")
	Return 1
End If

ll_Notas_Nao_Autorizadas = dw_2.GetItemNumber(dw_2.RowCount(), "qt_notas_nao_autorizadas")

If (ll_Notas_Nao_Autorizadas > 0) Then
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existem notam selecionadas que n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e300$$ENDHEX$$o autorizadas.~rEssas notas n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e300$$ENDHEX$$o impressas.~rDeseja continuar?", Question!, YesNo!, 2) = 2 Then
		Return 1
	End If	
End If

If is_id_tipo_nf <> 'TRA' then
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja Imprimir Duas Vias de Cada NF?", Question!, YesNo!, 2) = 1 Then
		lb_Duas_Vias = True
	End If	
End if

Try
	Try
		SetPointer(HourGlass!)
		
		lo_ge579_imprime_nfe = Create uo_ge579_imprime_danfe_nfe
		
		lo_ge579_imprime_nfe.ib_imprime_outra_via = lb_Duas_Vias
		
		Open(w_Aguarde)
		
		w_Aguarde.Title = 'Imprimindo...'
		w_Aguarde.uo_Progress.of_SetMax(ll_Linhas_Selecionadas)
		
		ll_Qt_Impressa = 0
		
		For ll_Linha = 1 To ll_linhas
			If dw_2.Object.id_imprimir[ll_Linha] = 'S' Then
				ll_Qt_Impressa ++
				
				w_Aguarde.Title = 'Imprimindo... '+String(ll_Qt_Impressa)+' de '+String(ll_Linhas_Selecionadas)
				w_Aguarde.uo_Progress.of_SetProgress(ll_Qt_Impressa)
					
				ls_solicitacao 			= dw_2.Object.solicitacao			[ll_Linha]
				ls_Chave_Acesso		= dw_2.Object.de_chave_acesso	[ll_Linha]
				ldt_Emissao				= Date(dw_2.Object.dh_emissao	[ll_Linha])
				ll_Cd_Filial_Origem	= dw_2.Object.cd_filial_origem_nf[ll_Linha]
				ll_Nr_Nf					= dw_2.Object.nr_nf					[ll_Linha]
				ls_Especie				= dw_2.Object.de_especie			[ll_Linha]
				ls_Serie					= dw_2.Object.de_serie				[ll_Linha]
				ls_id_situacao_nf		= dw_2.Object.id_situacao_nf		[ll_Linha]
				If isnull(ll_Cd_Filial_Origem) Then	ll_Cd_Filial_Origem	= dw_2.Object.cd_filial[ll_Linha]
				
				if ls_id_situacao_nf = 'P' or ls_id_situacao_nf = '' then
					If is_id_tipo_nf = 'TRA' Then
						If Not lo_ge579_imprime_nfe.of_imprime_danfe_nfe_new(ll_Cd_Filial_Origem,&
																						 ll_Nr_Nf, &
																						 ls_Especie, &
																						 ls_Serie, &
																						 ls_Chave_Acesso, &
																						 ldt_Emissao, &
																						 ls_Impressora, &
																						 Ref ls_Erro, &
																						 is_id_tipo_nf, &
																						 ls_solicitacao ) Then
							MessageBox("Aviso", "Erro ao imprimir a nota "+String(ll_Nr_Nf)+":~r"+ls_Erro)
							Return 1
						End If
					Else
						If Not lo_ge579_imprime_nfe.of_imprime_danfe_nfe(ll_Cd_Filial_Origem,&
																						 ll_Nr_Nf, &
																						 ls_Especie, &
																						 ls_Serie, &
																						 ls_Chave_Acesso, &
																						 ldt_Emissao, &
																						 ls_Impressora, &
																						 Ref ls_Erro, &
																						 is_id_tipo_nf ) Then
							MessageBox("Aviso", "Erro ao imprimir a nota "+String(ll_Nr_Nf)+":~r"+ls_Erro)
							Return 1
						End If
					End If
				end if
			End If						
		Next
		If is_id_tipo_nf = 'DEV' Then
			
			If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja imprimir as etiquetas das NF's marcadas?", Question!, YesNo!, 2) = 2 Then
				Return 1
			End If	
			
			If Not wf_imprime_etiquetas() Then
				Return 1
			End If	
			
		End if
	Finally
		Close(w_Aguarde)
		If IsValid(lo_ge579_imprime_nfe) Then Destroy(lo_ge579_imprime_nfe)
		SetPointer(Arrow!)
	End Try
Catch	( runtimeerror  lo_rte )
	MessageBox("Erro", "Erro ao imprimir a nota: " + lo_rte.GetMessage())
End Try

If is_id_tipo_nf = 'DEV' or is_id_tipo_nf = 'TRA' Then dw_2.event ue_postretrieve(dw_2.event ue_recuperar())
end event

type st_1 from statictext within w_ge645_impressao_nfe
integer x = 3726
integer y = 2292
integer width = 402
integer height = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Impressora:"
alignment alignment = right!
boolean focusrectangle = false
end type

type ddlb_impressoras from dropdownlistbox within w_ge645_impressao_nfe
integer x = 4137
integer y = 2284
integer width = 1897
integer height = 1176
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
boolean vscrollbar = true
end type

event selectionchanged;//lvs_Arquivo_INI = "c:\sistemas\ws\exe\wms.ini"
//
//lvs_Verifica_Versao 	= ProfileString(lvs_Arquivo_INI,"Desenvolvimento", "Verifica_Versao", "")

String ls_Arquivo,&
		ls_Impressora

ls_Arquivo		= "c:\sistemas\ws\exe\wms.ini"
ls_Impressora	= ddlb_impressoras.text

If Not FileExists(ls_Arquivo) Then
	integer li_FileNum
	li_FileNum = FileOpen(ls_Arquivo, LineMode!, Write!, LockWrite!, Append!)
	FileWrite(li_FileNum, "")
	FileClose(li_FileNum)
End If


If SetProfileString(ls_Arquivo, "Impressora_Danfe", "Impressora_" + gvo_Aplicacao.ivo_seguranca.nr_matricula , ls_Impressora) <> 1 Then
	MessageBox("Erro", "Erro ao salvar a impressora como padr$$HEX1$$e300$$ENDHEX$$o.")
	Return 1
End If
end event

type cb_reenviar_dev from commandbutton within w_ge645_impressao_nfe
integer x = 4626
integer y = 180
integer width = 1006
integer height = 108
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Reenviar Devolu$$HEX2$$e700e300$$ENDHEX$$o"
end type

event clicked;DateTime	ldt_dh_reentrada_mercadoria
Long		ll_Linhas, ll_Linha, ll_Linhas_Selecionadas, ll_Notas_Nao_Autorizadas, ll_Cd_Filial_Origem, &
			ll_Nr_Nf, ll_Qt_Impressa, ll_nr_atualizacao
String	ls_solicitacao, ls_Especie, ls_serie, ls_id_situacao_nf, ls_Erro
			
			
dw_2.AcceptText()

ll_Linhas = dw_2.RowCount()

ll_Linhas_Selecionadas = dw_2.GetItemNumber(dw_2.RowCount(), "qt_notas_selecionadas")
		
If ll_Linhas_Selecionadas < 1 Then
	MessageBox("Aviso", "N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ nota selecionada para ser impressa.")
	Return 1
End If

Try
	Try
		SetPointer(HourGlass!)
		
		Open(w_Aguarde)
		
		w_Aguarde.Title = 'Reenviando...'
		w_Aguarde.uo_Progress.of_SetMax(ll_Linhas_Selecionadas)
		
		ll_Qt_Impressa = 0
		
		For ll_Linha = 1 To ll_linhas
			If dw_2.Object.id_imprimir[ll_Linha] = 'S' Then
				ll_Qt_Impressa ++
				
				w_Aguarde.Title = 'Reenviando... '+String(ll_Qt_Impressa)+' de '+String(ll_Linhas_Selecionadas)
				w_Aguarde.uo_Progress.of_SetProgress(ll_Qt_Impressa)
					
				ls_solicitacao 		= dw_2.Object.solicitacao [ll_Linha]
				ll_Cd_Filial_Origem	= dw_2.Object.cd_filial_origem_nf[ll_Linha]
				ll_Nr_Nf					= dw_2.Object.nr_nf [ll_Linha]
				ls_Especie				= dw_2.Object.de_especie [ll_Linha]
				ls_Serie					= dw_2.Object.de_serie [ll_Linha]
				ls_id_situacao_nf		= dw_2.Object.id_situacao_nf [ll_Linha]
				
				if ls_id_situacao_nf <> 'X' then
					MessageBox("Aviso", "N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel fazer o reenvio de uma nota fiscal n$$HEX1$$e300$$ENDHEX$$o cancelada. Solicita$$HEX2$$e700e300$$ENDHEX$$o: "+ls_solicitacao)
					Return 1
				else
					select dh_reentrada_mercadoria
					  into :ldt_dh_reentrada_mercadoria
					  from nf_devolucao_compra
					 where nr_nf	= :ll_Nr_Nf
					 	and de_serie	= :ls_serie
					 	and de_especie	= :ls_especie
						and cd_filial	= :ll_cd_filial_origem
					using SQLCA;
					
					Choose Case SQLCA.SQLCode
						Case -1
							ls_erro	= SQLCA.SQLErrText
							SQLCA.of_rollback()
							MessageBox("Aviso", "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel buscar a data de reentrada da nota cancelada. Solicita$$HEX2$$e700e300$$ENDHEX$$o: "+ls_solicitacao+"~r~rErro: "+ls_Erro)
							Return 1
						Case 0
							if not IsNull(ldt_dh_reentrada_mercadoria) then
								SQLCA.of_rollback()
								MessageBox("Aviso", "A reentrada da mercadoria dessa devolu$$HEX2$$e700e300$$ENDHEX$$o j$$HEX1$$e100$$ENDHEX$$ foi feita e n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel fazer o reenvio da solicita$$HEX2$$e700e300$$ENDHEX$$o. " + &
														  "A devolu$$HEX2$$e700e300$$ENDHEX$$o deve ser refeita a partir das telas de segregado.~r~rSolicita$$HEX2$$e700e300$$ENDHEX$$o: "+ls_solicitacao)
								Return 1
							end if
					End Choose
				End If
				
				select top 1 nr_atualizacao
				  into :ll_nr_atualizacao
				  from log_exportacao_sap
				 where id_tipo_nf	= 'WMD'
				 	and cd_chave_interface	= :ls_solicitacao
				 order by 1 desc;
				 
				Choose Case SQLCA.SQLCode
					Case -1
						ls_erro	= SQLCA.SQLErrText
						SQLCA.of_rollback()
						MessageBox("Aviso", "Erro ao buscar o controle da log_exportacao_sap da solicita$$HEX2$$e700e300$$ENDHEX$$o: "+ls_solicitacao+"~r~rErro: "+ls_Erro)
						Return 1
					Case 100
						SQLCA.of_rollback()
						MessageBox("Aviso", "N$$HEX1$$e300$$ENDHEX$$o foi encontrado o controle da log_exportacao_sap da solicita$$HEX2$$e700e300$$ENDHEX$$o: "+ls_solicitacao)
						Return 1
				End Choose
				
				update log_exportacao_sap
					set id_status_integracao	= 'C',
						 id_reprocessar	= 'S'
				 where id_tipo_nf	= 'WMD'
				 	and nr_atualizacao	= :ll_nr_atualizacao;
				 
				Choose Case SQLCA.SQLCode
					Case -1
						ls_erro	= SQLCA.SQLErrText
						SQLCA.of_rollback()
						MessageBox("Aviso", "Erro ao atualizar o controle da log_exportacao_sap da solicita$$HEX2$$e700e300$$ENDHEX$$o: "+ls_solicitacao+"~r~rErro: "+ls_Erro)
						Return 1
				End Choose
			End If						
		Next
	Finally
		Close(w_Aguarde)
		SQLCA.of_commit()
		
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Opera$$HEX2$$e700e300$$ENDHEX$$o realizada com sucesso.')
		
		SetPointer(Arrow!)
	End Try
Catch	( runtimeerror  lo_rte )
	SQLCA.of_rollback()
	MessageBox("Erro", "Erro ao imprimir a nota: " + lo_rte.GetMessage())
End Try
end event

type cb_envio_email_forn from commandbutton within w_ge645_impressao_nfe
integer x = 4626
integer y = 304
integer width = 1006
integer height = 108
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Enviar XML~'s/DANFE~'s Para Forn."
end type

event clicked;Integer	li_lin_array

Long	ll_Linhas,&
		ll_Linha,&
		ll_Linhas_Selecionadas,&
		ll_Notas_Nao_Autorizadas,&
		ll_Cd_Filial_Origem,ll_Cd_Filial_Pedido,&
		ll_Nr_Nf,&
		ll_Qt_Enviada,&
		ll_Nr_Pedido,&
		ll_Tipo_envio_arquivo, ll_linhas_fornecedor, ll_linha_fornecedor, ll_for_lista
		
uo_ge579_salva_envia_danfe_nfe	lo_ge579_salva_envia_nfe
uo_ge040_args							luo_args [], luo_args_vazio []

String	ls_Chave_Acesso,&
		ls_Especie,&
		ls_Serie,&
		ls_Erro, ls_Para_Email,&
		ls_nfs_Ignoradas = '',&
		ls_parametro, &
		ls_de_fornecedor,&
		ls_cd_fornecedor, ls_Filtro, ls_fornecedores_enviados[],&
		ls_Xml_Valido

Date	ldt_Emissao

Boolean lb_fornecedor_processado = false

dw_2.AcceptText()

ll_Linhas = dw_2.RowCount()

If ll_Linhas < 1 Then
	MessageBox("Aviso", "N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ registros para serem enviados.")
	Return 1
End If

ll_Linhas_Selecionadas = dw_2.GetItemNumber(dw_2.RowCount(), "qt_notas_selecionadas")
		
If ll_Linhas_Selecionadas < 1 Then
	MessageBox("Aviso", "N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ nota selecionada para ser enviada.")
	Return 1
End If

ll_Notas_Nao_Autorizadas = dw_2.GetItemNumber(dw_2.RowCount(), "qt_notas_nao_autorizadas")

If (ll_Notas_Nao_Autorizadas > 0) Then
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existem notam selecionadas que n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e300$$ENDHEX$$o autorizadas.~rEssas notas n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e300$$ENDHEX$$o enviadas.~rDeseja continuar?", Question!, YesNo!, 2) = 2 Then
		Return 1
	End If	
End If

Try
	Open(w_Aguarde)
	w_aguarde.uo_progress.Of_SetMax(ll_linhas)
	
	lo_ge579_salva_envia_nfe = Create uo_ge579_salva_envia_danfe_nfe
	
	If is_id_tipo_nf = 'DEV' Then
	
		dw_2.SetSort("cd_fornecedor, id_imprimir desc")
		dw_2.Sort()
		
		For ll_linha = 1 to ll_linhas
			w_aguarde.uo_progress.Of_SetProgress(ll_linha)
			
			w_Aguarde.Title = 'Processando...'
			
			If dw_2.object.id_imprimir[ll_linha] = 'S' Then
				Try
					ls_cd_fornecedor = dw_2.object.cd_fornecedor[ll_linha]
					ls_de_fornecedor = dw_2.object.nm_fornecedor[ll_linha]
					
					w_Aguarde.Title = 'Enviando NFs de ' + ls_de_fornecedor
					
					lb_fornecedor_processado = False
					
					for ll_for_lista = 1 to UpperBound(ls_fornecedores_enviados)
						 if ls_fornecedores_enviados[ll_for_lista] = ls_cd_fornecedor then
							lb_fornecedor_processado = true
							exit
						 end if
					next
					
					if lb_fornecedor_processado then continue
					
					OpenwithParm(w_ge645_response_email_forn, ls_cd_fornecedor+';'+ls_de_fornecedor)
					
					//tipo do arquivo pra envio (padrao 1, somente pdf 2, somente xml 3) ! email pra envio
					ls_parametro = Message.StringParm 
					ll_Tipo_envio_arquivo = long(left(ls_parametro, 1))
					ls_Para_Email = right(ls_parametro,len(ls_parametro) - 2)
					
					If IsNull(ls_Para_Email) Or Trim(ls_Para_Email) = '' Or ls_Para_Email = 'N' Then
						ls_nfs_Ignoradas = 'Cancelou do fornecedor ' + ls_cd_fornecedor + ''
						continue
					End If
					
					dw_2.setredraw( false)
					
					ls_Filtro = " cd_fornecedor = '" + ls_cd_fornecedor + "' AND id_imprimir = 'S'"
					dw_2.SetFilter(ls_Filtro)
					dw_2.Filter()
					
					ll_linhas_fornecedor = dw_2.rowcount()
					
					for ll_linha_fornecedor = 1 to ll_linhas_fornecedor
						
						ll_Nr_Nf = dw_2.Object.nr_nf [ll_linha_fornecedor]
						
						If Not dw_2.Object.id_xml_valido[ll_linha_fornecedor] = 'S' Then					
							If ls_nfs_Ignoradas = '' Then
								ls_nfs_Ignoradas = String(ll_Nr_Nf)
							Else
								If Not Match(ls_nfs_Ignoradas, string(ll_Nr_Nf)) Then
									ls_nfs_Ignoradas += ', ' + String(ll_Nr_Nf)
								End If
							End If
							
							Continue
						Else
							ll_Qt_Enviada ++
														
							ls_Chave_Acesso		= dw_2.Object.de_chave_acesso	[ll_linha_fornecedor]
							ldt_Emissao				= Date(dw_2.Object.dh_emissao	[ll_linha_fornecedor])
							ll_Cd_Filial_Pedido	= dw_2.Object.cd_filial			[ll_linha_fornecedor]
							ll_Nr_Nf					= dw_2.Object.nr_nf				[ll_linha_fornecedor]
							ls_Especie				= dw_2.Object.de_especie		[ll_linha_fornecedor]
							ls_Serie					= dw_2.Object.de_serie			[ll_linha_fornecedor]
							
							li_lin_array++
							luo_args[li_lin_array].of_add_arg ('nr_nota',               ll_Nr_Nf)
							luo_args[li_lin_array].of_add_arg ('de_especie',            ls_Especie )
							luo_args[li_lin_array].of_add_arg ('de_serie',              ls_Serie)
							luo_args[li_lin_array].of_add_arg ('de_chave_acesso',       ls_Chave_Acesso)
							luo_args[li_lin_array].of_add_arg ('dh_emissao',            ldt_Emissao)
							luo_args[li_lin_array].of_add_arg ('cd_filial_pedido',      ll_Cd_Filial_Pedido)
							luo_args[li_lin_array].of_add_arg ('de_para_email',         ls_Para_Email)
							luo_args[li_lin_array].of_add_arg ('id_tipo_envio_arquivo', ll_Tipo_envio_arquivo)
							
							If not lb_fornecedor_processado then
								ls_fornecedores_enviados[upperbound(ls_fornecedores_enviados[])+1] = ls_cd_fornecedor
								lb_fornecedor_processado = True
							End if
						End If
						
					next
					
					If ll_Qt_Enviada > 0 then
						If Not lo_ge579_salva_envia_nfe.of_salva_danfe_xml_nfe (luo_args[], Ref ls_nfs_Ignoradas, Ref ls_Erro) Then
							MessageBox ('Aviso', 'Erro ao salvar/enviar a(s) nota(s) abaixo do fornecedor ' + ls_cd_fornecedor + ':~r' + ls_Erro)
						End If
					End if
					
					ls_Filtro= ""
					dw_2.SetFilter(ls_Filtro)
					dw_2.Filter()
					
					dw_2.SetSort("cd_fornecedor, id_imprimir desc")
					dw_2.Sort()
					
				Finally
					luo_args []   = luo_args_vazio []
					li_lin_array  = 0
					ll_Qt_Enviada = 0
				End Try
				
			else
				continue
			end if		
			
		Next
		
	ElseIf is_id_tipo_nf = 'LIC' Then
		
		Open(w_ge645_response_email_manual)
					
		//tipo do arquivo pra envio (padrao 1, somente pdf 2, somente xml 3) ! email pra envio
		ls_parametro = Message.StringParm 
		ll_Tipo_envio_arquivo = long(left(ls_parametro, 1))
		ls_Para_Email = right(ls_parametro,len(ls_parametro) - 2)
		
		If IsNull(ls_Para_Email) Or Trim(ls_Para_Email) = '' Or ls_Para_Email = 'N' Then
			Return -1
		End If
		
		For ll_linha = 1 to ll_linhas
			w_aguarde.uo_progress.Of_SetProgress(ll_linha)
			
			w_Aguarde.Title = 'Processando...'
			
			If dw_2.object.id_imprimir[ll_linha] = 'S' Then
				
				ll_Qt_Enviada ++
													
				ls_Chave_Acesso		= dw_2.Object.de_chave_acesso		[ll_linha]
				ldt_Emissao				= Date(dw_2.Object.dh_emissao		[ll_linha])
				ll_Cd_Filial_Origem	= dw_2.Object.cd_filial_origem_nf		[ll_linha]
				ll_Cd_Filial_Pedido		= dw_2.Object.cd_filial					[ll_linha]
				ll_Nr_Nf					= dw_2.Object.nr_nf						[ll_linha]
				ls_Especie				= dw_2.Object.de_especie				[ll_linha]
				ls_Serie					= dw_2.Object.de_serie					[ll_linha]
				ls_Xml_Valido			= dw_2.Object.id_xml_valido			[ll_linha]
				//ll_Nr_Pedido				= dw_2.Object.solicitacao				[ll_linha]
				
				If ls_Xml_Valido = 'S' Then
					If Not lo_ge579_salva_envia_nfe.of_salva_danfe_xml_nfe(ll_Cd_Filial_Origem,	ll_Nr_Nf, ls_Especie, ls_Serie, &
																								ls_Chave_Acesso, ldt_Emissao, ll_Cd_Filial_Pedido, ll_Nr_Pedido, &
																								ls_Para_Email, ll_Tipo_envio_arquivo, Ref ls_Erro) Then
						MessageBox("Aviso", "Erro ao Salvar/Enviar a nota "+String(ll_Nr_Nf)+":~r"+ls_Erro)
						If ls_nfs_Ignoradas = '' Then
							ls_nfs_Ignoradas = String(ll_Nr_Nf)
						Else
							If Not Match(ls_nfs_Ignoradas, string(ll_Nr_Nf)) Then
								ls_nfs_Ignoradas += ', ' + String(ll_Nr_Nf)
							End If
						End If
						
						Continue
						
					End If
				Else 
					If ls_nfs_Ignoradas = '' Then
						ls_nfs_Ignoradas = String(ll_Nr_Nf)
					Else
						If Not Match(ls_nfs_Ignoradas, string(ll_Nr_Nf)) Then
							ls_nfs_Ignoradas += ', ' + String(ll_Nr_Nf)
						End If
					End If
				End If
							
			Else
				Continue
				
			End if		
			
		Next
		
		dw_2.event ue_postretrieve(dw_2.event ue_recuperar())
		
	End If
	
Finally
	dw_2.setredraw( true )
	Close(w_Aguarde)
	If IsValid(lo_ge579_salva_envia_nfe) Then Destroy(lo_ge579_salva_envia_nfe)
	If ls_nfs_Ignoradas <> '' Then 
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!', 'As NFs abaixo foram ignorados porque tiveram algum erro ou o XML n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ valido:~n'+ ls_nfs_Ignoradas, Exclamation!)
	Else
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Todas NFs foram enviadas com sucesso!')
	End If
End Try

Return 1
end event

type cb_imp_etiqueta from commandbutton within w_ge645_impressao_nfe
integer x = 5070
integer y = 56
integer width = 558
integer height = 108
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Imprimir Etiqueta"
end type

event clicked;If Not wf_imprime_etiquetas() Then
	Return -1
End If	

If is_id_tipo_nf = 'DEV' or is_id_tipo_nf = 'TRA' Then dw_2.event ue_postretrieve(dw_2.event ue_recuperar())
end event

