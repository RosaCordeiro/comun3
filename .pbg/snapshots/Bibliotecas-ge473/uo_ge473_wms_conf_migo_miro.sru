HA$PBExportHeader$uo_ge473_wms_conf_migo_miro.sru
forward
global type uo_ge473_wms_conf_migo_miro from nonvisualobject
end type
end forward

global type uo_ge473_wms_conf_migo_miro from nonvisualobject
end type
global uo_ge473_wms_conf_migo_miro uo_ge473_wms_conf_migo_miro

type variables
String is_de_chave_acesso
String is_de_chave_acesso_sap
string is_chave_movimento_estoque

DateTime idt_dh_lancamento

//*********************
Long il_Tabela = 101

Long 	il_Filial = 534
Long 	il_Nota
Long	il_Lote_Conferencia
Long  il_CX_Padrao = 1 

String is_Fornecedor
String is_Especie
String is_Serie
String is_cd_fornecedor_sap
String is_id_licitacao

String is_Endereco_Segregado
String is_Endereco_Segregado_Avaria

String is_Endereco_Receb_Liberado
String is_Endereco_Segregado_Vencido

String is_Endereco_Segregado_Geladeira
String is_Endereco_Segregado_Excursao_Temp

String is_Endereco_Segregado_Val_Fora_Acordo

String is_Matricula_Entrada
String is_Matricula_default = '14330'
String is_Matricula_conferente

boolean ib_execucao_simultanea=false

boolean ib_nf_servico = false
boolean ib_nf_chave_acesso_remessa = false
boolean ib_Controlado_Endereco_Lote = false
Boolean ib_valida_teste_integrado = False
Boolean ib_Inicio_Controle_Temp_Rdc = False
end variables

forward prototypes
private function boolean of_inicializa_variaveis (ref string as_log)
public subroutine of_processa_atualizacao ()
public function boolean of_atualiza_recebimento_nota_fiscal (long al_controle, long al_tabela)
public function boolean of_confirma_nota (ref string as_log)
public function boolean of_verifica_nota_fiscal_pendente (ref string as_bonificacao, ref string as_tipo_entrada_nfe, ref string as_log)
public function boolean of_verifica_titulo_pagar (ref string as_log)
public function boolean of_confirma_nf_compra (string as_matricula, string as_tipo_entrada_nfe, ref string as_log)
public function boolean of_atualiza_falta (long al_produto, long al_natureza_operacao, string as_lote, date adh_validade, long al_qtde, ref string as_log)
public function boolean of_grava_movimentacao_wms_avariados (ref string as_log)
public function boolean of_grava_movimentacao_wms_vencidos_nova (ref string as_log)
public function boolean of_nr_movimentacao (long al_produto, string as_lote, long al_cx_padrao, datetime adh_validade, string as_responsavel, ref long al_movimentacao, ref string as_log)
public function boolean of_localiza_endereco_segregado (string as_parametro, ref string as_endereco, ref string as_log)
public function boolean of_inclui_segregado_recebimento (string as_endereco, long al_produto, string as_lote, date adh_validade, long al_qtde_lote, ref string as_log)
public function boolean of_grava_movimentacao_wms_segregados_fal (ref string as_log)
public function boolean of_carrega_chave_movimento_estoque (ref string ps_log)
public function boolean of_atualiza_recebimento_nota_loja (string as_log)
public function boolean of_verifica_nota_loja (ref long al_cd_filial, ref string as_log)
public function boolean of_verifica_compra_prd_item (long al_cd_filial, string as_cd_fornecedor, long al_nr_nf, string as_de_especie, string as_de_serie, ref long al_qt_produtos, ref string as_log)
public function boolean of_insere_nf_remessa (long pl_nr_nf, string ps_de_serie, string ps_de_especie, long pl_cd_filial, string ps_cd_fornecedor, string ps_tipo_entrada_nfe, ref string as_log)
public function boolean of_grava_item_nf_compra_prd (long al_cd_filial, string as_cd_fornecedor, long al_nr_nf, string as_de_especie, string as_de_serie, ref string as_log)
public function boolean of_exclui_nota_fiscal (long al_cd_filial, string as_cd_fornecedor, long al_nr_nf, string as_de_especie, string as_de_serie, ref string as_log)
public function boolean of_grava_movimentacao_wms_flow_rack (string as_endereco_receb_liberado, string as_endereco_flow, long al_produto, long al_cx_padrao, string as_lote, date adt_validade, long al_qtde, uo_ge258_movimentacao ao_movimentacao, ref string as_log)
public function boolean of_inclui_segregado_recebimento (string as_endereco, string as_fornecedor, long al_nota, string as_especie, string as_serie, long al_produto, string as_lote, date adh_validade, long al_qtde_lote, ref string as_log)
public function boolean of_verifica_lote_controlado (ref boolean ab_controlado, ref string as_log)
public function boolean of_verifica_validade_lote (string as_endereco, long al_produto, long al_caixa_padrao, string as_lote, date adt_validade, ref date adt_vali_cadastrada, ref string as_erro)
public function boolean of_grava_movimentacao_wms_receb_lib (ref string as_log)
public function boolean of_endereco_licitacao (ref string as_endereco_licitacao, ref string as_log)
public function boolean of_verifica_titulo_acordo (long al_filial, string as_fornecedor, long al_nota, string as_especie, string as_serie, ref string as_aviso, ref string as_nm_fantasia, ref date adt_data, ref decimal ldc_valor, ref long al_pedido, ref string as_email, ref string as_comprador, ref string as_matricula, ref string as_log)
public function boolean of_localiza_email_auxiliar_comprador (string as_comprador, string as_email_auxiliar, ref string as_log)
public function boolean of_envia_email_acordo_titulo (long al_nota, string as_especie, string as_serie, string as_fornecedor, long al_pedido, date adt_emissao, decimal ldc_vl_nota, string as_nm_fantasia, string as_email, string as_comprador, string as_matricula, ref string as_log)
public function boolean of_localiza_endereco_flow (long al_produto, ref string as_endereco, ref string as_subcategoria, string as_nr_lote, ref string as_log)
public function boolean of_finaliza_recebimento (ref string as_log)
public function boolean of_verifica_nota_compra (ref boolean ab_encontrou_nota, ref string as_log)
public function boolean of_localiza_conferente_entrada (long al_produto, string as_lote, date adt_validade, ref string as_matricula_conferente, ref string as_log, long al_caixa_padrao)
public function boolean of_grava_log_exportacao_sap (long acd_produto, ref string ps_log)
public function boolean of_grava_movimentacao_wms_segregados_gel (ref string as_log)
public function boolean of_atualiza_geladeira (long al_produto, long al_natureza_operacao, string as_lote, date adh_validade, long al_qtde, ref string as_log)
public function boolean of_get_ordem_transf (ref long al_nr_transferencia, ref string as_nr_matricula_conferente, ref string as_log)
public function boolean of_confirma_nota_transf_cd (long al_cd_filial_destino, ref string as_log)
public function boolean of_verifica_nota_transf_cd (ref boolean ab_transf_cd, ref long al_cd_filial_destino, ref string as_centro_distribuicao_destino, ref string as_log)
end prototypes

private function boolean of_inicializa_variaveis (ref string as_log);Try
			 
	SetNull(is_de_chave_acesso)
	SetNull(idt_dh_lancamento)
		
Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro ao iniciar as variaveis. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try

Return True
end function

public subroutine of_processa_atualizacao ();Long ll_Linhas
Long ll_Linha, ll_nr_controle, ll_controles_gerando

dc_uo_ds_base lds 

try 
	
	lds  = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject('ds_ge473_lista_controles', False) Then 
		gvo_aplicacao.of_grava_log("Interface Conf. Migo/Miro - Erro alterar a DW [ds_ge473_lista_controles] - uo_ge473_wms_conf_migo_miro.of_processa_atualizacao" )
		Return
	End If
	
	ll_Linhas = lds.Retrieve(il_Tabela)
	
	If ll_Linhas > 0 Then
		For ll_Linha = 1 To ll_Linhas
			
			if ib_execucao_simultanea = True Then
				//
			else
			
				uo_ge473_wms_conf_migo_miro   lo_receb
				 
				Try
					lo_receb	= Create uo_ge473_wms_conf_migo_miro
					lo_receb.of_atualiza_recebimento_nota_fiscal( lds.Object.nr_controle[ll_Linha],this.il_tabela )
	
				Finally
					Destroy(lo_receb)
				End Try			
			
			end if
			
		Next
	ElseIf ll_Linhas < 0 Then
		gvo_aplicacao.of_grava_log("Interface Conf. Migo/Miro - Erro ao recuperar os da DW [ds_ge473_lista_controles] - uo_ge473_wms_conf_migo_miro.of_processa_atualizacao.")
	End If	
	
finally
	Destroy lds
end try
end subroutine

public function boolean of_atualiza_recebimento_nota_fiscal (long al_controle, long al_tabela);Boolean lb_Sucesso = False, lb_existe_nota = False, lb_transf_cd = False
Long ll_Atualizacao_Pend
Long ll_Linhas
Long ll_cd_filial
Long ll_cd_filial_destino
String ls_Log
String ls_Chave_Controle
String ls_centro_distribuicao_destino

Try
	uo_ge473_comum lo_Comum
	lo_Comum = Create uo_ge473_comum
	
	Select de_chave_sap
	Into :is_de_chave_acesso_sap
	From interface_sap  i 
	Where i.cd_tabela = :il_Tabela
		and i.nr_controle = :al_controle
	Using SqlCa;	
	
	If SqlCa.sqlcode = -1 Then
		ls_Log = "Erro ao buscar o controle na tabela interface_sap. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle)+". Erro: "+SqlCa.sqlErrText
		Return False
	End If	
	
	is_de_chave_acesso_sap	= Left(is_de_chave_acesso_sap, 44)
	
	If Not This.of_inicializa_variaveis(Ref ls_Log) Then Return False
	
	If Not lo_Comum.of_atualizacao_pendente(al_Controle, Ref ll_Atualizacao_Pend, Ref ls_Log) Then Return False
	
	//Controle j$$HEX1$$e100$$ENDHEX$$ foi processado
	If ll_Atualizacao_Pend = 0 Then Return True
	
	If Not lo_Comum.of_Muda_Situacao_Interface(al_Controle, Ref ls_Log) Then Return False
	If Not lo_Comum.of_localiza_chave_controle(al_Controle, Ref ls_Chave_Controle, Ref ls_Log) Then Return False
	
	If lo_Comum.of_processa_carrega_dados(al_controle , ref ls_Log) Then
		ll_Linhas = lo_Comum.ids_lista_registros.RowCount()
		
		if isvalid(w_aguarde_3) Then
			w_aguarde_3.uo_progress_2.of_reset()
			w_aguarde_3.uo_progress_2.of_setmax(ll_linhas)
		end if
		
		If ll_Linhas = 1 Then
			is_de_chave_acesso 	= left(lo_Comum.ids_lista_registros.Object.de_chave_acesso[1], 44)
			is_cd_fornecedor_sap	= lo_Comum.ids_lista_registros.Object.cd_fornecedor[1]
			is_serie					= lo_Comum.ids_lista_registros.Object.serie[1]
			il_Nota					= Long(lo_Comum.ids_lista_registros.Object.nr_nota[1])
			
			If Not of_verifica_nota_transf_cd(REF lb_transf_cd, REF ll_cd_filial_destino, REF ls_centro_distribuicao_destino, REF ls_log) Then Return False
				
			if lb_transf_cd then
				if not of_confirma_nota_transf_cd(ll_cd_filial_destino, REF ls_log) then return False
				
				lb_Sucesso = True
			else
				if not of_verifica_nota_compra(ref lb_existe_nota, ref ls_log) then Return False
				
				if not lb_existe_nota then
					If Not lo_Comum.of_date_time(lo_Comum.ids_lista_registros.Object.dh_lancamento[1], 'DH_LANCAMENTO', ref  idt_dh_lancamento, ref ls_Log) Then Return False
		
					if isvalid(w_aguarde_3) Then
						w_aguarde_3.wf_settext('Nota Fiscal: ' + is_de_chave_acesso , 3 )
					end if
					
					if Not this.of_verifica_nota_loja(REF ll_cd_filial, REF ls_log) then Return False
					
					if ls_centro_distribuicao_destino = 'N' then
						If not This.of_atualiza_recebimento_nota_loja(Ref ls_Log ) Then 	
							Return False
						Else
							lb_Sucesso	= True
						End If
					else
						if ll_cd_filial > 0 then
							If This.of_confirma_nota(Ref ls_Log ) Then 	lb_Sucesso	= True
						else
							lb_Sucesso	= True
						end if
					end if
				end if
			end if
			
			if isvalid(w_aguarde_3) Then
				w_aguarde_3.uo_progress_2.of_setprogress(1)
			end if	
		Else
			ls_Log  = "Quantidade de registros recebido na interface esta diferente do esperado 1 para a tabela [interface_sap]. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle)+"."
			Return False
		End If
	End If
Catch ( runtimeerror  lo_rte )
	ls_Log = "Objeto [uo_ge473_wms_conf_migo_miro], fun$$HEX2$$e700e300$$ENDHEX$$o [of_atualiza_recebimento_nota_fiscal]. Erro: "+lo_rte.GetMessage( )
	lb_Sucesso	= True
	SqlCA.of_RollBack()
	lo_Comum.of_grava_erro(al_controle, 179, ls_Log)
	Return False		
Finally
	If lb_Sucesso Then
		SqlCa.of_Commit()
	Else
		SqlCA.of_RollBack()
		lo_Comum.of_grava_erro(al_controle, 179, ls_Log)
	End If
	
	Destroy lo_Comum	
End Try

Return True
end function

public function boolean of_confirma_nota (ref string as_log);String ls_Especie
String ls_Serie
String ls_Matricula
String ls_Fornecedor
String ls_Bonificada
String ls_Tipo_Entrada
String ls_serie_chave
Date		ld_dh_confirmacao_nf
DateTime ldh_Entrada

ib_valida_teste_integrado = gf_valida_teste_integrado()
ib_Inicio_Controle_Temp_Rdc = gf_inicio_controle_temp_rdc()

if ib_nf_servico then
	if ib_nf_chave_acesso_remessa then
		Select top 1 l.cd_fornecedor, 
				 ln.nr_nf, 
				 ln.de_especie, 
				 ln.de_serie, 
				 l.dh_entrada, 
				 ln.nr_lote, 
				 l.nr_matricula_abertura, 
				 l.id_licitacao,
				 l.dh_confirmacao_nf,
				 COALESCE (l.nr_matricula_entrada, :is_Matricula_default)
		  Into :is_Fornecedor, 
		  		 :il_Nota, 
				 :is_Especie, 
				 :is_Serie, 
				 :ldh_Entrada, 
				 :il_Lote_Conferencia, 
				 :ls_Matricula, 
				 :is_id_licitacao, 
				 :ld_dh_confirmacao_nf,
				 :is_Matricula_Entrada
		  From nf_compra_pendente n
		 Inner Join fornecedor f on f.cd_fornecedor = n.cd_fornecedor
		 Inner Join lote_recebimento l on (l.cd_fornecedor = f.cd_fornecedor)
		 Inner Join lote_recebimento_nf ln	on (l.nr_lote = ln.nr_lote and ln.nr_nf = n.nr_nf and ln.de_especie = n.de_especie and ln.de_serie = n.de_serie)
		 Where n.de_chave_acesso_remessa = :is_de_chave_acesso
		Using SqlCa;
	else
		Select top 1 l.cd_fornecedor, 
				 ln.nr_nf, 
				 ln.de_especie, 
				 ln.de_serie, 
				 l.dh_entrada, 
				 ln.nr_lote, 
				 l.nr_matricula_abertura, 
				 l.id_licitacao,
				 l.dh_confirmacao_nf,
				 COALESCE (l.nr_matricula_entrada, :is_Matricula_default)
		  Into :is_Fornecedor, 
		  		 :il_Nota, 
				 :is_Especie, 
				 :is_Serie, 
				 :ldh_Entrada, 
				 :il_Lote_Conferencia, 
				 :ls_Matricula, 
				 :is_id_licitacao, 
				 :ld_dh_confirmacao_nf,
				 :is_Matricula_Entrada
		  From nf_compra_pendente n
		 inner join fornecedor f on f.cd_fornecedor = n.cd_fornecedor
		 inner join lote_recebimento l on (l.cd_fornecedor = f.cd_fornecedor)
		 inner join lote_recebimento_nf ln	on (l.nr_lote = ln.nr_lote and ln.nr_nf = n.nr_nf and ln.de_especie = n.de_especie and ln.de_serie = n.de_serie)
		 where n.nr_nf 			= :il_nota
		   and n.de_serie 		= :is_serie
		   and n.cd_fornecedor 	= :is_fornecedor
		   and n.de_especie		= 'NFS'
		   and n.cd_filial		= :il_Filial
		Using SqlCa;
	end if
elseif ib_valida_teste_integrado then
	ls_serie_chave = Mid(is_de_chave_acesso, 23, 3)
	
	Select l.cd_fornecedor, ln.nr_nf, ln.de_especie, ln.de_serie, l.dh_entrada, ln.nr_lote, l.nr_matricula_abertura, l.id_licitacao,
				 COALESCE (l.nr_matricula_entrada, :is_Matricula_default)
	Into :is_Fornecedor, :il_Nota, :is_Especie, :is_Serie, :ldh_Entrada, :il_Lote_Conferencia, :ls_Matricula, :is_id_licitacao,
				 :is_Matricula_Entrada
	From nf_agendamento_ent n
	inner join fornecedor f on f.nr_cgc = n.nr_cgc_fornecedor 
	inner join lote_recebimento l on (l.cd_fornecedor = f.cd_fornecedor)
	inner join lote_recebimento_nf ln	on (l.nr_lote = ln.nr_lote and ln.nr_nf = n.nr_nf and ln.de_especie = n.de_especie and ln.de_serie = :ls_serie_chave)
	where n.de_chave_acesso = :is_de_chave_acesso
	Using SqlCa;
else
	Select l.cd_fornecedor, ln.nr_nf, ln.de_especie, ln.de_serie, l.dh_entrada, ln.nr_lote, l.nr_matricula_abertura, l.id_licitacao,
				 COALESCE (l.nr_matricula_entrada, :is_Matricula_default)
	Into :is_Fornecedor, :il_Nota, :is_Especie, :is_Serie, :ldh_Entrada, :il_Lote_Conferencia, :ls_Matricula, :is_id_licitacao,
				 :is_Matricula_Entrada
	From nf_agendamento_ent n
	inner join fornecedor f on f.nr_cgc = n.nr_cgc_fornecedor 
	inner join lote_recebimento l on (l.cd_fornecedor = f.cd_fornecedor)
	inner join lote_recebimento_nf ln	on (l.nr_lote = ln.nr_lote and ln.nr_nf = n.nr_nf and ln.de_especie = n.de_especie and ln.de_serie = n.de_serie)
	where n.de_chave_acesso = :is_de_chave_acesso
	Using SqlCa;
End if

Choose Case SqlCa.Sqlcode
	Case 0
		
		If IsNull(il_Nota) Then
			as_Log	= "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel localizar registro na tabela 'LOTE_RECEBIMENTO'. Chave de Acesso [" + this.is_de_chave_acesso +"]."
			Return False
		End If
		
		If IsNull(ldh_Entrada) and not ib_nf_servico Then
			as_Log	= "A ordem do recebimento do WMS [" + String(il_Lote_Conferencia) + "] ainda n$$HEX1$$e300$$ENDHEX$$o foi conferida. Chave de Acesso [" + this.is_de_chave_acesso +"]."
			Return False
		End If
	Case 100
		as_Log	= "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel localizar registro na tabela 'NF_AGENDAMENTO_ENT'. Chave de Acesso [" + this.is_de_chave_acesso +"]."
		Return False
	Case -1 
		as_Log	= "Erro ao localizar registro na tabela 'NF_AGENDAMENTO_ENT'. Chave de Acesso [" + this.is_de_chave_acesso +"]. Erro: "+ SqlCa.SqlErrText
		Return False
End Choose

//if ib_nf_servico then
//	If IsNull(ld_dh_confirmacao_nf) Then
//		as_Log	= "Ordem ainda n$$HEX1$$e300$$ENDHEX$$o confirmada pelo CD"
//		Return False
//	End If
//end if

// Verifica se existe a nota fiscal pendente informada no lote
If Not This.of_verifica_nota_fiscal_pendente(ref ls_Bonificada, ref ls_Tipo_Entrada, ref as_log) Then Return False

If ls_Bonificada = 'N' Then
	If Not This.of_verifica_titulo_pagar(ref as_Log) Then Return False
End If

If Not This.of_confirma_nf_compra(ls_Matricula, ls_Tipo_Entrada, ref as_log) Then Return False

If Not This.of_localiza_endereco_segregado('CD_ENDERECO_SEGREGADO_RECEBIMENTO_FALTA', ref is_Endereco_Segregado, ref as_log) Then Return False
If Not This.of_localiza_endereco_segregado('CD_ENDERECO_SEGREGADO_RECEBIMENTO_AVARIA', ref is_Endereco_Segregado_Avaria, ref as_log) Then Return False
If Not This.of_localiza_endereco_segregado('CD_ENDERECO_RECEBIMENTO_LIBERADO', ref is_Endereco_Receb_Liberado, ref as_log) Then Return False
If Not This.of_localiza_endereco_segregado('CD_ENDERECO_SEGREGADO_RECEBIMENTO_VENCID', ref is_Endereco_Segregado_Vencido, ref as_log) Then Return False
If Not This.of_localiza_endereco_segregado('CD_ENDERECO_SEGREGADO_VAL_FORA_ACORDO', ref is_Endereco_Segregado_Val_Fora_Acordo, ref as_log) Then Return False

// Insere a quantidade divergerente no endere$$HEX1$$e700$$ENDHEX$$o do segregado do WMS *** faltas
If Not This.of_grava_movimentacao_wms_segregados_fal(ref as_log) Then Return False

// Grava movimento dos produtos avariados
If Not This.of_grava_movimentacao_wms_avariados(ref as_log) Then Return False

// Grava a entrada no recebimento liberado e depois faz a saida e entrada no segregado vencido.
If Not of_grava_movimentacao_wms_vencidos_nova(ref as_log) Then Return False 

If ib_Inicio_Controle_Temp_Rdc Then
	If Not This.of_localiza_endereco_segregado('CD_ENDERECO_SEGREGADO_RECEBIMENTO_GELAD', ref is_Endereco_Segregado_Geladeira, ref as_log) Then Return False
	If Not This.of_localiza_endereco_segregado('CD_ENDERECO_EXCURSAO_TEMPERATURA_NFD', ref is_Endereco_Segregado_Excursao_Temp, ref as_log) Then Return False
	//Grava produtos geladeira 
	If Not This.of_grava_movimentacao_wms_segregados_gel(ref as_log) Then Return False
End If

//Verifica se $$HEX1$$e900$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel finalizar o recebimento e faz as movimenta$$HEX2$$e700f500$$ENDHEX$$es de estoque necess$$HEX1$$e100$$ENDHEX$$rias para o recebimento liberado/licita$$HEX2$$e700e300$$ENDHEX$$o
If Not of_finaliza_recebimento(ref as_log) Then Return False

Return True
end function

public function boolean of_verifica_nota_fiscal_pendente (ref string as_bonificacao, ref string as_tipo_entrada_nfe, ref string as_log);String lvs_Divergencia_Valores

Select id_bonificacao, id_divergencia_valores, id_inclusao_via_arquivo
Into :as_Bonificacao, :lvs_Divergencia_Valores, :as_tipo_entrada_nfe
From nf_compra_pendente
Where cd_filial     = :il_filial
  and cd_fornecedor = :is_fornecedor
  and nr_nf         = :il_nota
  and de_especie    = :is_especie
  and de_serie      = :is_serie
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
		as_Log	= "Nota fiscal de compra pendente n$$HEX1$$e300$$ENDHEX$$o foi localizada Nota/Especie/S$$HEX1$$e900$$ENDHEX$$rie [" + String(il_Nota) + "/" + is_Especie + "/" + is_Serie + "]."
		Return False
	Case -1
		as_Log	= "Erro ao localizar registro na tabela 'NF_COMPRA_PENDENTE'. Chave de Acesso [" + this.is_de_chave_acesso +"]. Erro: "+ SqlCa.SqlErrText
		Return False
End Choose 

If IsNull(lvs_Divergencia_valores) Then lvs_Divergencia_Valores  = "N"

If IsNull(as_tipo_entrada_nfe) or as_tipo_entrada_nfe = 'N' Then
	// Manual
	as_tipo_entrada_nfe = 'M'
End If

If lvs_Divergencia_Valores = 'S' Then
	as_Log	= "Existem diverg$$HEX1$$ea00$$ENDHEX$$ncias entre os valores informados e os calculados pelo sistema, Nota/Especie/S$$HEX1$$e900$$ENDHEX$$rie [" + String(il_Nota) + "/" + is_Especie + "/" + is_Serie + "]."
	Return False
End If

Return True

end function

public function boolean of_verifica_titulo_pagar (ref string as_log);Long lvl_Titulos

If gvo_Aplicacao.ivs_DataSource = 'homologa' then
	Return True
End If

Select count(nr_titulo_pagar)
Into :lvl_Titulos
From titulo_pagar_pendente
Where cd_filial 			=:il_Filial
  	and cd_fornecedor	=:is_Fornecedor
  	and nr_nf			=:il_Nota
  	and de_especie		=:is_Especie
  	and de_serie		=:is_Serie
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_Log	= "Erro ao localizar registro na tabela [TITULO_PAGAR_PENDENTE]. Nota/Especie/S$$HEX1$$e900$$ENDHEX$$rie [" + String(il_Nota) + "/" + is_Especie + "/" + is_Serie + "]. Erro: " + SqlCa.SqlErrText
	Return False
End If

If Isnull(lvl_Titulos) or lvl_Titulos = 0 Then
	as_log = "Os t$$HEX1$$ed00$$ENDHEX$$tulos da nota fiscal '" + String(il_Nota) + "' do fornecedor '" + is_Fornecedor + "' n$$HEX1$$e300$$ENDHEX$$o foram localizados."
	Return False
End If

Return True

end function

public function boolean of_confirma_nf_compra (string as_matricula, string as_tipo_entrada_nfe, ref string as_log);Boolean 	lvb_Sucesso = False
Date		ldt_data
Dec{2}	ldc_valor
Long 		ll_Produtos, ll_Pedido, ll_exists
String	ls_aviso_titulo, ls_nm_fantasia, ls_Email, ls_Comprador, ls_Matricula_Comprador


SetPointer(HourGlass!)

try
	if not of_insere_nf_remessa(il_nota, is_Especie, is_Serie, il_filial, is_Fornecedor, as_tipo_entrada_nfe, REF as_log) Then
		Return False
	end if
	
	// Confirma a inclus$$HEX1$$e300$$ENDHEX$$o da nota fiscal
	Insert Into nf_compra (cd_filial,   
								  cd_fornecedor,   
								  nr_nf,   
								  de_especie,   
								  de_serie,   
								  dh_emissao,   
								  dh_movimentacao_caixa,   
								  vl_bc_icms,   
								  vl_icms,   
								  vl_bc_icms_st,   
								  vl_icms_st,   
								  vl_icms_repassado,   
								  vl_total_produtos,   
								  vl_ipi,   
								  vl_frete,   
								  vl_seguro,   
								  vl_outras_despesas,   
								  vl_desconto,   
								  vl_indenizacao,   
								  vl_total_nf,   
								  nr_pedido_central,   
								  id_bonificacao,
								  cd_condicao_pagamento,
								  dh_registro,
								  nr_matricula_registro,
								  nr_matricula_conferente,
								  de_chave_acesso,
								  id_tipo_entrada_nfe,
								  dh_importacao_xml,
								  dh_recebido_sap,
								  de_chave_acesso_remessa)  
	Select n.cd_filial,
			 n.cd_fornecedor,   
			 n.nr_nf,   
			 n.de_especie,   
			 n.de_serie,
			 n.dh_emissao,   
			 coalesce(:idt_dh_lancamento , p.dh_movimentacao) ,
			 n.vl_bc_icms,   
			 n.vl_icms,   
			 n.vl_bc_icms_st,   
			 n.vl_icms_st,   
			 n.vl_icms_repassado,   
			 n.vl_total_produtos,   
			 n.vl_ipi,   
			 n.vl_frete,   
			 n.vl_seguro,   
			 n.vl_outras_despesas,   
			 n.vl_desconto,   
			 n.vl_indenizacao,   
			 n.vl_total_nf,
			 n.nr_pedido,
			 n.id_bonificacao,
			 n.cd_condicao_pagamento,
			 cast(getdate() as date),
			 '14330',
			 :as_matricula,
			 n.de_chave_acesso,
			 :as_tipo_entrada_nfe,
			 n.dh_importacao_xml,
			 n.dh_recebido_sap,
			 n.de_chave_acesso_remessa
	  From nf_compra_pendente n,
		    parametro p
	 Where n.cd_filial     	= :il_filial
		and n.cd_fornecedor 	= :is_Fornecedor
		and n.nr_nf         	= :il_nota
		and n.de_especie    	= :is_Especie
		and n.de_serie      	= :is_Serie
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		as_Log	= "Erro ao inserir registro na tabela [NF_COMPRA]. Nota/Especie/S$$HEX1$$e900$$ENDHEX$$rie [" + String(il_Nota) + "/" + is_Especie + "/" + is_Serie + "]. Erro: " + SqlCa.SqlErrText
		Return False
	End If	
	
	// Confirma a inclus$$HEX1$$e300$$ENDHEX$$o dos produtos da nota fiscal
	Insert Into item_nf_compra (	cd_filial,   
											cd_fornecedor,   
											nr_nf,   
											de_especie,   
											de_serie,   
											cd_natureza_operacao,   
											cd_produto,   
											cd_situacao_tributaria,   
											qt_faturada,   
											qt_recebida,   
											vl_preco_unitario,   
											pc_desconto,   
											pc_icms,   
											pc_ipi,   
											id_lista_pis_cofins,   
											vl_icms_repassado,
											pc_reducao_base_icms,
											vl_preco_base_icms_st,
											vl_icms_st,
											vl_bc_icms,   
											vl_icms,   
											vl_bc_ipi,   
											vl_ipi,   
											vl_outras_despesas,   
											pc_icms_st,   
											vl_bc_icms_st_total,   
											vl_icms_st_total,
											cd_cst_origem,
											cd_cst_tributacao,
											qt_avariada,
											cd_natureza_operacao_xml,
											nr_classificacao_fiscal,
											id_reducao_base_icms,
											vl_preco_unitario_fiscal,
											cd_mod_bc_icms,
											vl_icms_operacao,
											pc_dif_icms,
											vl_icms_dif,
											vl_bc_icms_antecipacao,
											pc_mva_icms_antecipacao,
											pc_icms_antecipacao,
											vl_icms_antecipacao,
											vl_bc_icms_st_calculado,
											vl_icms_st_calculado,
											vl_bc_icms_st_retido,
											vl_icms_st_retido, 
											nr_sequencial,
											vl_total_item,
											vl_desconto_total, 
											qt_comercial, 
											qt_tributavel, 
											cd_unidade_comercial, 
											cd_unidade_tributavel,
											pc_st_retido,
											vl_icms_retido,
											cd_beneficio,
											cd_mod_bc_st,
											pc_mva,
											cd_cest,
											vl_bc_icms_total,
											vl_icms_total,
											vl_bc_ipi_total,
											vl_ipi_total,
											vl_icms_desonerado,
											id_motivo_desoneracao_icms,
											vl_bc_st_fcp,
											vl_st_fcp,
											cd_cst_pis,
											vl_bc_pis_xml,
											pc_pis_xml,
											vl_pis,
											cd_cst_cofins,
											vl_bc_cofins_xml,
											pc_cofins_xml,
											vl_cofins,
											cd_cst_pis_entrada,
											vl_bc_pis_entrada,
											pc_pis_entrada,
											vl_pis_entrada,
											cd_cst_cofins_entrada,
											vl_bc_cofins_entrada,
											pc_cofins_entrada,
											vl_cofins_entrada
											)
											
	Select	cd_filial,
				cd_fornecedor,   
				nr_nf,   
				de_especie,   
				de_serie,
				cd_natureza_operacao,   
				cd_produto,   
				cd_situacao_tributaria,   
				qt_faturada,   
				qt_recebida,   
				vl_preco_unitario,   
				pc_desconto,   
				pc_icms,   
				pc_ipi,   
				id_lista_pis_cofins,
				vl_icms_repassado,
				pc_reducao_base_icms,
				vl_preco_base_icms_st,
				vl_icms_st,
				vl_bc_icms,   
				vl_icms,   
				vl_bc_ipi,   
				vl_ipi,   
				vl_outras_despesas,   
				pc_icms_st,   
				vl_bc_icms_st_total,   
				vl_icms_st_total,
				cd_cst_origem,
				cd_cst_tributacao,
				qt_avariada,
				cd_natureza_operacao_xml,
				nr_classificacao_fiscal,
				id_reducao_base_icms,
				vl_preco_unitario_fiscal,
				cd_mod_bc_icms,
				vl_icms_operacao,
				pc_dif_icms,
				vl_icms_dif,
				vl_bc_icms_antecipacao,
				pc_mva_icms_antecipacao,
				pc_icms_antecipacao,
				vl_icms_antecipacao,
				vl_bc_icms_st_calculado,
				vl_icms_st_calculado,
				vl_bc_icms_st_retido,
				vl_icms_st_retido,
				nr_sequencial,
				vl_total_item,
				vl_desconto_total, 
				qt_comercial, 
				qt_tributavel, 
				cd_unidade_comercial, 
				cd_unidade_tributavel, 
				pc_st_retido , 
				vl_icms_retido,
				cd_beneficio,
				cd_mod_bc_st,
				pc_mva,
				cd_cest,
				vl_bc_icms_total,
				vl_icms_total,
				vl_bc_ipi_total,
				vl_ipi_total,
				vl_icms_desonerado,
				id_motivo_desoneracao_icms,
				vl_bc_st_fcp,
				vl_st_fcp,
				cd_cst_pis,
				vl_bc_pis_xml,
				pc_pis_xml,
				vl_pis,
				cd_cst_cofins,
				vl_bc_cofins_xml,
				pc_cofins_xml,
				vl_cofins,
				cd_cst_pis_entrada,
				vl_bc_pis_entrada,
				pc_pis_entrada,
				vl_pis_entrada,
				cd_cst_cofins_entrada,
				vl_bc_cofins_entrada,
				pc_cofins_entrada,
				vl_cofins_entrada
	From nf_compra_pendente_produto
	Where cd_filial			= :il_filial
	  and cd_fornecedor	= :is_Fornecedor
	  and nr_nf				= :il_nota
	  and de_especie		= :is_Especie
	  and de_serie			= :is_Serie
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		as_Log	= "Erro ao inserir registro na tabela [ITEM_NF_COMPRA]. Nota/Especie/S$$HEX1$$e900$$ENDHEX$$rie [" + String(il_Nota) + "/" + is_Especie + "/" + is_Serie + "]. Erro: " + SqlCa.SqlErrText
		Return False
	End If

	// Confirma a inclus$$HEX1$$e300$$ENDHEX$$o dos lotes psico dos produtos da nota fiscal
	Insert Into item_nf_compra_lote (	cd_filial,   
												cd_fornecedor,   
												nr_nf,   
												de_especie,   
												de_serie,   
												cd_natureza_operacao,   
												cd_produto,   
												nr_lote,   
												qt_lote,
												qt_avariada,
												dh_validade,
												dh_fabricacao,
												id_vencimento_proximo) 
	Select	cd_filial,
			cd_fornecedor,   
			nr_nf,   
			de_especie,   
			de_serie,
			cd_natureza_operacao,   
			cd_produto,   
			nr_lote,   
			qt_lote,
			qt_avariada,
			dh_validade,
			dh_fabricacao,
			id_vencimento_proximo
	From nf_compra_pendente_prd_lote
	Where cd_filial			= :il_Filial
	  and cd_fornecedor	= :is_Fornecedor
	  and nr_nf				= :il_nota
	  and de_especie		= :is_Especie
	  and de_serie			= :is_Serie
	  and qt_lote			> 0
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		as_Log	= "Erro ao inserir registro na tabela [ITEM_NF_COMPRA_LOTE]. Nota/Especie/S$$HEX1$$e900$$ENDHEX$$rie [" + String(il_Nota) + "/" + is_Especie + "/" + is_Serie + "]. Erro: " + SqlCa.SqlErrText
		Return False
	End If
	
	if ib_valida_teste_integrado then
		update pedido_central
			set id_situacao = 'A'
		  From nf_compra n
		 Where n.cd_filial     		= :il_filial
			and n.cd_fornecedor 		= :is_Fornecedor
			and n.nr_nf         		= :il_nota
			and n.nr_pedido_central	= pedido_central.nr_pedido
		Using SqlCa;
		
		Choose Case SqlCa.SqlCode
			Case -1
				as_Log	= "Erro ao atualizar registro na tabela [PEDIDO_CENTRAL]. Nota/Especie/S$$HEX1$$e900$$ENDHEX$$rie [" + String(il_Nota) + "/" + is_Especie + "/" + is_Serie + "]. Erro: " + SqlCa.SqlErrText
				Return False
			Case 100
				as_Log	= "N$$HEX1$$e300$$ENDHEX$$o encontrado registro na tabela [PEDIDO_CENTRAL]. Nota/Especie/S$$HEX1$$e900$$ENDHEX$$rie [" + String(il_Nota) + "/" + is_Especie + "/" + is_Serie + "]. Erro: " + SqlCa.SqlErrText
				Return False
		End Choose
	else
		update pedido_central
			set id_situacao = 'A'
		  From nf_compra n
		 Where n.cd_filial     		= :il_filial
			and n.cd_fornecedor 		= :is_Fornecedor
			and n.nr_nf         		= :il_nota
			and n.de_especie    		= :is_Especie
			and n.de_serie      		= :is_Serie
			and n.nr_pedido_central	= pedido_central.nr_pedido
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			as_Log	= "Erro ao atualizar registro na tabela [PEDIDO_CENTRAL]. Nota/Especie/S$$HEX1$$e900$$ENDHEX$$rie [" + String(il_Nota) + "/" + is_Especie + "/" + is_Serie + "]. Erro: " + SqlCa.SqlErrText
			Return False
		End If
	end if
		
	select Top 1 1
	  into :ll_exists
	  from titulo_pagar t
	 Where t.cd_filial		= :il_filial
	   and t.cd_fornecedor	= :is_Fornecedor
	   and t.nr_nf				= :il_nota
	   and t.de_especie		= :is_Especie
	   and t.de_serie			= :is_Serie
	Using SqlCa;
	
	Choose Case SQLCA.SQLCode
		Case -1
			as_Log	= "Erro ao localizar registro na tabela [TITULO_PAGAR_PENDENTE]. Nota/Especie/S$$HEX1$$e900$$ENDHEX$$rie [" + String(il_Nota) + "/" + is_Especie + "/" + is_Serie + "]. Erro: " + SqlCa.SqlErrText
			Return False
		Case 100
			if ib_valida_teste_integrado then
				delete from titulo_pagar
				 where exists (select 1
				 					  from titulo_pagar_pendente tpp
									 where tpp.cd_filial		= :il_filial
										and tpp.cd_fornecedor	= :is_Fornecedor
										and tpp.nr_nf				= :il_nota
										and tpp.de_especie		= :is_Especie
										and tpp.de_serie			= :is_Serie
										and tpp.nr_titulo_pagar	= titulo_pagar.nr_titulo_pagar);
										
				If SqlCa.SqlCode = -1 Then
					as_Log	= "Erro ao deletar registro na tabela [TITULO_PAGAR]. Nota/Especie/S$$HEX1$$e900$$ENDHEX$$rie [" + String(il_Nota) + "/" + is_Especie + "/" + is_Serie + "]. Erro: " + SqlCa.SqlErrText
					Return False
				End If
			end if
			
			// Confirma a inclus$$HEX1$$e300$$ENDHEX$$o dos t$$HEX1$$ed00$$ENDHEX$$tulos a pagar
			Insert Into titulo_pagar(cd_filial,   
											 cd_fornecedor,   
											 nr_titulo_pagar,   
											 dh_movimentacao_caixa,   
											 dh_emissao,   
											 dh_vencimento,   
											 vl_pagar,   
											 nr_nf,   
											 de_especie,   
											 de_serie)  
			Select distinct t.cd_filial,   
					 t.cd_fornecedor,   
					 t.nr_titulo_pagar,   
					 coalesce (:idt_dh_lancamento,getdate()),
					 t.dh_emissao,   
					 t.dh_vencimento,   
					 t.vl_pagar,   
					 t.nr_nf,   
					 t.de_especie,   
					 t.de_serie
			  From titulo_pagar_pendente t
			 Where t.cd_filial		= :il_filial
			   and t.cd_fornecedor	= :is_Fornecedor
			   and t.nr_nf				= :il_nota
			   and t.de_especie		= :is_Especie
			   and t.de_serie			= :is_Serie
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				as_Log	= "Erro ao inserir registro na tabela [TITULO_PAGAR]. Nota/Especie/S$$HEX1$$e900$$ENDHEX$$rie [" + String(il_Nota) + "/" + is_Especie + "/" + is_Serie + "]. Erro: " + SqlCa.SqlErrText
				Return False
			End If
		Case 0
			update titulo_pagar
				set nr_titulo_pagar 			= t.nr_titulo_pagar,   
					 dh_movimentacao_caixa 	= coalesce(:idt_dh_lancamento, p.dh_movimentacao) ,   
					 dh_emissao 				= t.dh_emissao,   
					 dh_vencimento 			= t.dh_vencimento,
					 vl_pagar 					= t.vl_pagar
			  From titulo_pagar_pendente t,
					 parametro p
			 Where t.cd_filial						= :il_filial
			   and t.cd_fornecedor					= :is_Fornecedor
			   and t.nr_nf								= :il_nota
			   and t.de_especie						= :is_Especie
			   and t.de_serie							= :is_Serie
				and titulo_pagar.cd_filial			= t.cd_filial
			   and titulo_pagar.cd_fornecedor	= t.cd_fornecedor
			   and titulo_pagar.nr_nf				= t.nr_nf
			   and titulo_pagar.de_especie		= t.de_especie
			   and titulo_pagar.de_serie			= t.de_serie
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				as_Log	= "Erro ao atualizar o registro na tabela [TITULO_PAGAR]. Nota/Especie/S$$HEX1$$e900$$ENDHEX$$rie [" + String(il_Nota) + "/" + is_Especie + "/" + is_Serie + "]. Erro: " + SqlCa.SqlErrText
				Return False
			End If
	End Choose
								
	// Insere Itens na Tabela Auxiliar  :  item_nf_compra_prd : DRCST
	// Grava :  nf_compra_pendente_prd_item :  Antes de Apagar os Registros
	If Not This.of_verifica_compra_prd_item(il_filial, is_Fornecedor, il_nota, is_Especie, is_Serie, ref ll_Produtos, ref as_Log) Then  Return False

	If ll_Produtos > 0 Then
		If Not This.of_grava_item_nf_compra_prd(il_filial, is_Fornecedor, il_nota, is_Especie, is_Serie, ref as_Log) Then Return False
	End If

	// Verifica se tem aviso de Titulo
	If	of_verifica_titulo_acordo(il_filial,&
										  is_Fornecedor,&
										  il_nota,&
										  is_Especie,& 
										  is_Serie,&
										  Ref ls_aviso_titulo, & 
										  Ref ls_nm_fantasia, &
										  Ref ldt_data, &
										  Ref ldc_valor, &
										  Ref ll_Pedido, &
										  Ref ls_Email, &
										  Ref ls_Comprador, &
										  Ref ls_Matricula_Comprador, &
										  Ref as_Log) Then
		// Aviso do Titulo: Se Tem Envia Email
		If ls_aviso_titulo = "S" Then 
			If Not of_envia_email_acordo_titulo (il_nota,&
															 is_Especie,&
															 is_Serie,&
															 is_Fornecedor,&
															 ll_Pedido,&
															 ldt_data,&
															 ldc_valor,&
															 ls_nm_fantasia,&
															 ls_Email,&
															 ls_Comprador,&
															 ls_Matricula_Comprador,&
															 Ref as_Log)  Then 
				Return False
			End If 
		End If 
	End If

	// Exclui a nota fiscal, os produtos e os t$$HEX1$$ed00$$ENDHEX$$tulos a pagar pendentes
	If Not This.of_exclui_nota_fiscal(il_filial, is_Fornecedor, il_nota, is_Especie, is_Serie, ref as_Log) Then Return False
	
finally
	SetPointer(Arrow!)
end try

Return True

end function

public function boolean of_atualiza_falta (long al_produto, long al_natureza_operacao, string as_lote, date adh_validade, long al_qtde, ref string as_log);String ls_MSG

Long ll_Count

SELECT count(cd_produto)
INTO :ll_Count
FROM item_nf_compra_lote   
where  cd_filial 					= :il_filial
	and cd_fornecedor 			= :is_Fornecedor
	and nr_nf 						= :il_Nota
	and de_especie 				= :is_Especie
	and de_serie 					= :is_Serie
	and cd_natureza_operacao 	= :al_natureza_operacao
    and cd_produto 				= :al_Produto
	and nr_lote  					= :as_lote
Using SqlCa;

If SqlCa.SqlCode <> -1 Then
	
	If ll_Count > 0 Then
		
		Update item_nf_compra_lote
		Set qt_lote = qt_lote + :al_qtde, qt_falta = coalesce(qt_falta, 0) + :al_qtde
		where  cd_filial 					= :il_filial
			and cd_fornecedor 			= :is_Fornecedor
			and nr_nf 						= :il_Nota
			and de_especie 				= :is_Especie
			and de_serie 					= :is_Serie
			and cd_natureza_operacao 	= :al_natureza_operacao
			 and cd_produto 				= :al_Produto
			and nr_lote  					= :as_lote
		Using SqlCa;
		
		If Sqlca.SqlCode = -1  Then
			ls_MSG = "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do lote na tabela item_nf_compra_lote '" + SQLCA.SQLErrText + "'."
			SqlCa.of_RollBack()
//			MessageBox("Erro", ls_MSG, StopSign!)
			Return False
		End If
			
	Else
	
		  INSERT INTO item_nf_compra_lote	( cd_filial,   
														  cd_fornecedor,   
														  nr_nf,   
														  de_especie,   
														  de_serie,   
														  cd_natureza_operacao,   
														  cd_produto,   
														  nr_lote,   
														  qt_lote,   
														  dh_validade,   
														  dh_fabricacao,   
														  qt_avariada,   
														  id_vencimento_proximo,   
														  qt_devolvida,   
														  qt_reserva_devolucao,   
														  qt_falta )  
			VALUES (		:il_filial,						//cd_filial,   
								:is_Fornecedor,			//cd_fornecedor,   
								:il_Nota,						//nr_nf,   
								:is_Especie,				//de_especie,   
								:is_Serie,					//de_serie,   
								:al_natureza_operacao, 	//cd_natureza_operacao,   
								:al_Produto,					//cd_produto,   
								:as_lote,						//nr_lote,   
								:al_qtde,						//qt_lote,   
								:adh_validade,				//dh_validade,   
								null, 							//dh_fabricacao,   
								null,							//qt_avariada,   
								'N',							//id_vencimento_proximo,   
								null,							//qt_devolvida,   
								null,							//qt_reserva_devolucao,   
								:al_qtde)						//qt_falta 
			Using SqlCa;
					  
			If Sqlca.SqlCode = -1  Then
				as_log = "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do lote na tabela item_nf_compra_lote '" + SQLCA.SQLErrText + "'."
				Return False
			End If 
	End If
Else
	as_log = "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do lote na tabela item_nf_compra_lote '" + SQLCA.SQLErrText + "'."
	Return False
End If

Return True

end function

public function boolean of_grava_movimentacao_wms_avariados (ref string as_log);String	ls_Lote,&
		ls_Nulo,&
		ls_Erro

Date	ldt_Validade,&
		lvdt_Data_Parametro

Boolean lvb_Sucesso = True

Long	ll_Itens,&
		ll_Item,&
		ll_Produto,&
		ll_Qtde,&
		ll_Nulo,&
		ll_Qtde_Faturada,&
		ll_Nat_Operacao
	
		
Decimal	ldc_bc_Icms_St,&
			ldc_Icms_St,&
			ldc_Custo_Unitario,&
			ldc_Custo_Gerencial		

SetPointer(HourGlass!)

SetNull(ls_Nulo)
Setnull(ll_Nulo)

dc_uo_ds_base lds
uo_ge258_movimentacao lds_Movimentacao 

try
	
	lds						= Create dc_uo_ds_base
	lds_Movimentacao	= Create uo_ge258_movimentacao
	
	lds_Movimentacao.ivb_Commit = False

	if not lds_Movimentacao.of_set_mostra_erro_tela(False) then Return False
	
	//// VERIFICAR - DS ESTA ERRADA
	If Not lds.of_ChangeDataObject("ds_ge473_qtde_avaraida", False) Then
		as_log = "Erro ao mudar a DS [ds_ge473_qtde_avaraida], fun$$HEX2$$e700e300$$ENDHEX$$o [of_grava_movimentacao_wms_avariados]."
		Return False
	End If
	
	ll_Itens = lds.Retrieve(il_Filial, is_Fornecedor, il_Nota, is_especie, is_Serie)
	
	If ll_Itens < 0 Then
		as_log = "Erro ao localizar os dados da DS [ds_ge473_qtde_avaraida], fun$$HEX2$$e700e300$$ENDHEX$$o [of_grava_movimentacao_wms_avariados]."
		Return False
	End If
	
	If ll_Itens > 0 Then
		
		lvdt_Data_Parametro = Date(gf_GetServerDate())
					
		For ll_Item = 1 To ll_Itens
					
			ll_Produto 				= lds.Object.cd_produto					[ll_Item]
			ls_Lote 					= lds.Object.nr_lote						[ll_Item]
			ldt_Validade 			= Date(lds.Object.dh_validade			[ll_Item])
			ll_Qtde 					= lds.Object.qt_avariada					[ll_Item]
			ll_Nat_Operacao		= lds.Object.cd_natureza_operacao	[ll_Item]
			
			//**************************Localiza os cusots do produto***********************
			if not ib_valida_teste_integrado then
				select	top 1
						case when coalesce(i.vl_bc_icms_st_total , 0) = 0 then
							case when coalesce(i.vl_bc_icms_st_calculado , 0) = 0 then
								case when coalesce(i.vl_bc_icms_st_retido , 0) = 0 then
									0
								else
									i.vl_bc_icms_st_retido 
								end
							else
								i.vl_bc_icms_st_calculado
							end
						else
							i.vl_bc_icms_st_total 
						end as vl_bc_icms_st,
						
						case when coalesce(i.vl_icms_st_total, 0) = 0 then
							case when coalesce(i.vl_icms_st_calculado, 0) = 0 then
								case when coalesce(i.vl_icms_st_retido, 0) = 0 then
									0
								else
									i.vl_icms_st_retido
								end
							else
								i.vl_icms_st_calculado
							end
						else
							i.vl_icms_st_total
						end as vl_icms_st,
			
						m.vl_custo_unitario,
						m.vl_custo_gerencial,
						i.qt_faturada
				into	:ldc_bc_Icms_St,
						:ldc_Icms_St,
						:ldc_Custo_Unitario,
						:ldc_Custo_Gerencial,
						:ll_Qtde_Faturada		
				from item_nf_compra i		
				left Join movimento_estoque m	on		m.dh_movimento			= :lvdt_Data_Parametro
															and	m.cd_filial_movimento	= i.cd_filial
															and	m.cd_fornecedor			= i.cd_fornecedor
															and	m.nr_nf						= i.nr_nf
															and	m.de_especie				= i.de_especie
															and	m.de_serie					= i.de_serie
															and	m.cd_produto				= i.cd_produto
				where	i.cd_filial						= :il_Filial
					and	i.cd_fornecedor				= :is_Fornecedor
					and	i.nr_nf						= :il_Nota
					and	i.de_especie					= :is_Especie
					and	i.de_serie					= :is_Serie
					and	i.cd_natureza_operacao	= :ll_Nat_Operacao
					and	i.cd_produto					= :ll_Produto
				Using SqlCa;
				
				Choose Case SqlCa.SqlCode
					Case 0
						
					Case 100
						as_log = "N$$HEX1$$e300$$ENDHEX$$o foram localizados os custos do produto "+String(ll_Produto)+"."
						Return False
	
					Case -1
						as_log = "Erro ao localizados os custos do produto "+String(ll_Produto)+": "+SqlCa.SqlErrText
						Return False
						
				End Choose
				
				ldc_bc_Icms_St		= ldc_bc_Icms_St / ll_Qtde_Faturada
				ldc_Icms_St			= ldc_Icms_St / ll_Qtde_Faturada
			else
				ldc_bc_Icms_St	= 0
				ldc_Icms_St		= 0
			end if
			//**********************************************************************
			
			If Not IsNull(ldt_Validade) Then
				ldt_Validade = Date(String(ldt_Validade, '01/mm/yyyy'))
			End If
			
			If Not of_inclui_segregado_recebimento(is_Endereco_Segregado_Avaria,&
																ll_Produto, ls_Lote, ldt_Validade, ll_Qtde, ref as_log) Then
				Return False																				 
			End If
			
			// In$$HEX1$$ed00$$ENDHEX$$cio - Enviar movimenta$$HEX2$$e700e300$$ENDHEX$$o para o SAP movimentar do deposito livre utiliza$$HEX2$$e700e300$$ENDHEX$$o para segregado (SOMENTE NO SAP)
			If Not This.of_carrega_chave_movimento_estoque(ref as_log) Then Return False
			
			lds_Movimentacao.is_chave_movimento = is_chave_movimento_estoque
			
			If Not This.of_grava_log_exportacao_sap(ll_Produto, ref as_log) Then Return False

			// T$$HEX1$$e900$$ENDHEX$$rmino - Enviar movimenta$$HEX2$$e700e300$$ENDHEX$$o para o SAP movimentar do deposito livre utiliza$$HEX2$$e700e300$$ENDHEX$$o para segregado
			// Localiza Matricula do Conferente			
			If Not This.of_localiza_conferente_entrada(ll_Produto,ls_Lote,ldt_Validade,&
																	Ref is_Matricula_conferente,Ref as_log,&
																	il_CX_Padrao  ) Then Return False 
						
			//  Caso Conferente VAZIO usa o Padrao:14330
			If IsNull (is_Matricula_conferente) or is_Matricula_conferente = '' Then
				is_Matricula_Entrada = is_Matricula_default
			Else				
				is_Matricula_Entrada = is_Matricula_conferente
			End If 	
			
			If Not lds_Movimentacao.of_Insere_Movimentacao(	is_Endereco_Segregado_Avaria,	ls_Nulo,	ll_Produto,	il_CX_Padrao,ls_Lote,ldt_Validade,ll_Qtde,&
																				'S',il_Filial,is_Fornecedor,il_Nota,is_Especie,is_Serie,&
																				is_Matricula_Entrada, ll_Nulo,&
																				Round(ldc_bc_Icms_St * ll_Qtde, 2), Round(ldc_Icms_St * ll_Qtde, 2),	ldc_Custo_Unitario, ldc_Custo_Gerencial ) Then
				as_log = "Erro ao gravar o movimento no WMS [of_grava_movimentacao_wms_avariados]."																				
				Return False																			 
			End If
		
		Next
		
	End If

finally
	
	If IsValid(lds) 						Then Destroy(lds)
	If IsValid(lds_Movimentacao) 	Then Destroy(lds_Movimentacao)
		
	SetPointer(Arrow!)
end try

Return True
end function

public function boolean of_grava_movimentacao_wms_vencidos_nova (ref string as_log);DateTime ldh_Validade

Long	ll_Linhas,&
		ll_Linha,&
		ll_Nulo,&
		ll_Produto,&
		ll_Qtde,&
		ll_Qtde_Lote,&
		ll_Avariada,&
		ll_Nr_Movimentacao,&
		ll_Qtde_Faturada,&
		ll_Nat_Operacao
	

String	ls_Nulo,&
		ls_Lote,&
		ls_Endereco_Entrada,&
		ls_Erro
		
Decimal	ldc_bc_Icms_St,&
			ldc_Icms_St,&
			ldc_Custo_Unitario,&
			ldc_Custo_Gerencial
			
Date	ldt_Movimento		

SetNull(ll_Nulo)
SetNull(ls_Nulo)

uo_ge258_movimentacao 	lo_Movimentacao 
dc_uo_ds_base 				lds

Try

	SetPointer(HourGlass!)

	lds = Create dc_uo_ds_base
	
	lo_Movimentacao = Create uo_ge258_movimentacao
	lo_Movimentacao.ivb_Commit = False
	
	if not lo_Movimentacao.of_set_mostra_erro_tela(False) then Return False
	
	If Not lds.of_ChangeDataObject("ds_ge473_produto_vencimento_proximo", False) Then 
		as_log = "Erro ao mudar a DS [ds_ge473_produto_vencimento_proximo], fun$$HEX2$$e700e300$$ENDHEX$$o [of_grava_movimentacao_wms_vencidos_nova]."
		Return False
	End If
			
	ll_Linhas = lds.Retrieve(il_filial, is_fornecedor, il_nota, is_especie, is_serie )
	
	If ll_Linhas = -1 Then
		as_log = "Erro ao localizar os dados da DS [ds_ge473_produto_vencimento_proximo], fun$$HEX2$$e700e300$$ENDHEX$$o [of_grava_movimentacao_wms_vencidos_nova]."
		Return False
	End If
		
	If ll_Linhas > 0 Then
				
		For ll_Linha = 1 To ll_Linhas
			
			ll_Produto 				= lds.Object.cd_produto					[ll_Linha]
			ls_Lote 					= lds.Object.nr_lote						[ll_Linha]
			ldh_Validade 			= lds.Object.dh_validade					[ll_Linha]
			ll_Qtde_Lote				= lds.Object.qt_lote						[ll_Linha]
			ll_Avariada				= lds.Object.qt_avariada					[ll_Linha]
			ll_Nat_Operacao		= lds.Object.cd_natureza_operacao	[ll_Linha]
			ldt_Movimento			= Date(gf_GetServerDate())
			If gvo_Aplicacao.ivs_DataSource = 'homologa' then
				ldt_Movimento = date(idt_dh_lancamento)
			End If
			
			ll_Qtde 				= ll_Qtde_Lote - ll_Avariada
							
			If ll_Qtde > 0 Then
				
				//**************************Localiza os custos do produto***********************
				select	top 1
						case when coalesce(i.vl_bc_icms_st_total , 0) = 0 then
							case when coalesce(i.vl_bc_icms_st_calculado , 0) = 0 then
								case when coalesce(i.vl_bc_icms_st_retido , 0) = 0 then
									0
								else
									i.vl_bc_icms_st_retido 
								end
							else
								i.vl_bc_icms_st_calculado
							end
						else
							i.vl_bc_icms_st_total 
						end as vl_bc_icms_st,
						
						case when coalesce(i.vl_icms_st_total, 0) = 0 then
							case when coalesce(i.vl_icms_st_calculado, 0) = 0 then
								case when coalesce(i.vl_icms_st_retido, 0) = 0 then
									0
								else
									i.vl_icms_st_retido
								end
							else
								i.vl_icms_st_calculado
							end
						else
							i.vl_icms_st_total
						end as vl_icms_st,
			
						m.vl_custo_unitario,
						m.vl_custo_gerencial,
						i.qt_faturada
				into	:ldc_bc_Icms_St,
						:ldc_Icms_St,
						:ldc_Custo_Unitario,
						:ldc_Custo_Gerencial,
						:ll_Qtde_Faturada		
				from item_nf_compra i		
				left Join movimento_estoque m	on		m.dh_movimento			= :ldt_Movimento
															and	m.cd_filial_movimento	= i.cd_filial
															and	m.cd_fornecedor			= i.cd_fornecedor
															and	m.nr_nf						= i.nr_nf
															and	m.de_especie				= i.de_especie
															and	m.de_serie					= i.de_serie
															and	m.cd_produto				= i.cd_produto
				where	i.cd_filial						= :il_Filial
					and	i.cd_fornecedor				= :is_Fornecedor
					and	i.nr_nf						= :il_Nota
					and	i.de_especie					= :is_Especie
					and	i.de_serie					= :is_Serie
					and	i.cd_natureza_operacao	= :ll_Nat_Operacao
					and	i.cd_produto					= :ll_Produto
				Using SqlCa;
				
				Choose Case SqlCa.SqlCode
					Case 0
					Case 100
						as_log = "N$$HEX1$$e300$$ENDHEX$$o foram localizados os custos do produto "+String(ll_Produto)+"."
						Return False	
						
					Case -1
						as_log = "Erro ao localizados os custos do produto "+String(ll_Produto)+": "+SqlCa.SqlErrText
						Return False				
						
				End Choose
				
				ldc_bc_Icms_St		= ldc_bc_Icms_St / ll_Qtde_Faturada
				ldc_Icms_St			= ldc_Icms_St / ll_Qtde_Faturada
				//**********************************************************************


				// Localiza Matricula do Conferente			
				If Not This.of_localiza_conferente_entrada(ll_Produto,ls_Lote,Date(ldh_Validade),&
																		Ref is_Matricula_conferente,& 
																		Ref as_log, il_CX_Padrao  ) Then Return False 
						
				//  Caso Conferente VAZIO usa o Padrao:14330
				If IsNull (is_Matricula_conferente) or is_Matricula_conferente = '' Then
					is_Matricula_Entrada = is_Matricula_default
				Else				
					is_Matricula_Entrada = is_Matricula_conferente
				End If 	

				If Not lo_Movimentacao.of_insere_movimentacao(	is_Endereco_Receb_Liberado, ls_Nulo, ll_Produto,&
																					il_CX_Padrao,ls_Lote,Date(ldh_Validade),&
																					ll_Qtde, "U", il_filial, is_Fornecedor,&
																					il_Nota, is_Especie, is_Serie, is_Matricula_Entrada) Then
					as_log = "Erro ao gravar o movimento no WMS [of_grava_movimentacao_wms_vencidos_nova] (1)."
					Return False
				End If
				
				// inicio vencido
				
				//Sa$$HEX1$$ed00$$ENDHEX$$da do ENDERECO_LIBERADO
				SetNull(ls_Endereco_Entrada)
				If Not lo_Movimentacao.of_insere_movimentacao(	ls_Endereco_Entrada,&
																					is_Endereco_Receb_Liberado,&
																					ll_Produto,&
																					il_CX_Padrao,&
																					ls_Lote,&
																					Date(ldh_Validade),&
																					ll_Qtde,&
																					"S",&
																					il_filial,&
																					is_Fornecedor,&
																					il_Nota,&
																					is_Especie,&
																					is_Serie,&
																					is_Matricula_Entrada,&
																					ll_Nulo,&
																					Round(ldc_bc_Icms_St * ll_Qtde, 2),&
																					Round(ldc_Icms_St * ll_Qtde, 2),&
																					ldc_Custo_Unitario,&
																					ldc_Custo_Gerencial) Then
					as_log = "Erro ao gravar o movimento no WMS [of_grava_movimentacao_wms_vencidos_nova] (2)."
					Return False
				End If	
			
				If Not of_Nr_Movimentacao(ll_Produto, ls_Lote, il_CX_Padrao, ldh_Validade, is_Matricula_Entrada, Ref ll_Nr_Movimentacao, ref as_log) Then
					Return false
				End If
				
				If date(ldh_Validade) <= date(gf_getserverdate()) Then //usa is_Endereco_Segregado_Vencido
					If Not lo_Movimentacao.of_Atualiza_Movimentacao(	is_Endereco_Segregado_Vencido,&
																						ll_Produto,&
																						ll_Nr_Movimentacao,&
																						ll_Qtde,&
																						ls_Lote,&
																						il_CX_Padrao,&
																						ldh_Validade) Then
						as_log = "Erro ao gravar o movimento no WMS [of_grava_movimentacao_wms_vencidos_nova] (3)."
						Return False
					End If
					
					If Not IsNull(ldh_Validade) Then
						ldh_Validade = DateTime(String(ldh_Validade, '01/mm/yyyy'))
					End If
					
					If Not of_inclui_segregado_recebimento(is_Endereco_Segregado_Vencido, &
																			ll_Produto, ls_Lote, Date(ldh_Validade), ll_Qtde, ref as_log) Then
						Return False																						 
					End If
				Else //usa is_Endereco_Segregado_Val_Fora_Acordo
					If Not lo_Movimentacao.of_Atualiza_Movimentacao(	is_Endereco_Segregado_Val_Fora_Acordo,&
																						ll_Produto,&
																						ll_Nr_Movimentacao,&
																						ll_Qtde,&
																						ls_Lote,&
																						il_CX_Padrao,&
																						ldh_Validade) Then
						as_log = "Erro ao gravar o movimento no WMS [of_grava_movimentacao_wms_vencidos_nova] (4)."
						Return False
					End If
					
					If Not IsNull(ldh_Validade) Then
						ldh_Validade = DateTime(String(ldh_Validade, '01/mm/yyyy'))
					End If
					
					If Not of_inclui_segregado_recebimento(is_Endereco_Segregado_Val_Fora_Acordo, &
																			ll_Produto, ls_Lote, Date(ldh_Validade), ll_Qtde, ref as_log) Then
						Return False																						 
					End If
				End If
				// fim vencido
				
			End If		
					
		Next
				
	End If
	
Finally
	
	If IsValid(lds) 					Then Destroy(lds)
	If IsValid(lo_Movimentacao) Then Destroy(lo_Movimentacao)
	
End try
end function

public function boolean of_nr_movimentacao (long al_produto, string as_lote, long al_cx_padrao, datetime adh_validade, string as_responsavel, ref long al_movimentacao, ref string as_log);//Pega o n$$HEX1$$fa00$$ENDHEX$$mero da movimenta$$HEX2$$e700e300$$ENDHEX$$o
select Top 1	nr_movimentacao
Into 		:al_movimentacao
from wms_movimentacao
where cd_produto 						= :al_Produto
and	nr_matricula_responsavel 		= :as_responsavel
and 	cd_endereco_saida 				= :is_Endereco_Receb_Liberado
and 	nr_lote									= :as_Lote
and	qt_caixa_padrao 					= :al_Cx_Padrao
and 	dh_validade 							= :adh_validade
and id_tipo_movimento in ('S', '7')
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case -1
		as_log = "Erro ao selecionar os dados de movimenta$$HEX2$$e700e300$$ENDHEX$$o do produto '" + string(al_Produto) + "'."
		Return False
		
	Case 100
		as_log = "O Produto '"+String(al_Produto)+ "' n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ em movimenta$$HEX2$$e700e300$$ENDHEX$$o."
		Return False	
		
End Choose

Return True
end function

public function boolean of_localiza_endereco_segregado (string as_parametro, ref string as_endereco, ref string as_log);String ls_Achou

If IsNull(as_parametro) or Trim(as_parametro) = '' Then
	as_log = "Par$$HEX1$$e200$$ENDHEX$$metro informado na [of_localiza_endereco_segregado] $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido."
	Return False
End If

Select vl_parametro
Into :as_endereco
From wms_parametro
Where cd_parametro = :as_parametro
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		
		Select cd_endereco
		Into :ls_Achou
		From wms_endereco
		Where cd_endereco =:as_endereco
		Using SqlCa;
		
		Choose Case SqlCa.SqlCode 
			Case 0
				Return True
			Case 100
				as_log = "Endere$$HEX1$$e700$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o localizado '" + as_endereco + "'"
			Case -1
				as_log = "Erro ao localizar o endere$$HEX1$$e700$$ENDHEX$$o do segregado na tabela [WMS_ENDERECO]."
		End Choose		
		
	Case 100
		as_log = "Par$$HEX1$$e200$$ENDHEX$$metro [" + as_parametro + "] com o endere$$HEX1$$e700$$ENDHEX$$o do segregado n$$HEX1$$e300$$ENDHEX$$o foi localizado."
		
	Case -1
		as_log = "Erro ao localizar o par$$HEX1$$e200$$ENDHEX$$metro [" + as_parametro + "] do endere$$HEX1$$e700$$ENDHEX$$o do segregado."
		
End Choose

Return False
end function

public function boolean of_inclui_segregado_recebimento (string as_endereco, long al_produto, string as_lote, date adh_validade, long al_qtde_lote, ref string as_log);String ls_MSG

 INSERT INTO wms_segregado_recebimento  ( 		cd_endereco,   
																  	cd_fornecedor,   
																  	nr_nf,   
																  	de_especie,   
																  	de_serie,   
																  	cd_produto,   
																  	nr_lote,   
																  	dh_validade,   
																  	qt_lote )  
  VALUES (	:as_endereco,   
           		:is_fornecedor,   
           		:il_nota,   
           		:is_especie,   
           		:is_serie,   
           		:al_produto,   
           		:as_lote,   
           		:adh_validade,   
           		:al_qtde_lote)
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_log = "Inclus$$HEX1$$e300$$ENDHEX$$o do lote na tabela wms_segregado_receb_liberado '" + SQLCA.SQLErrText + "'."
	Return False
End If

Return True
end function

public function boolean of_grava_movimentacao_wms_segregados_fal (ref string as_log);String	ls_Lote,&
		ls_Nulo,&
		ls_Erro

Date	ldt_Validade,&
		lvdt_Data_Parametro,&
		ldt_Movimento

Boolean lvb_Sucesso = True

Long	ll_Itens, &
		ll_Item,&
		ll_Produto,&
		ll_Qtde,&
		ll_Nulo,&
		ll_NatOperacao,&
		ll_Qtde_Faturada
	
				
Decimal	ldc_bc_Icms_St,&
			ldc_Icms_St,&
			ldc_Custo_Unitario,&
			ldc_Custo_Gerencial

SetPointer(HourGlass!)

SetNull(ls_Nulo)
Setnull(ll_Nulo)

dc_uo_ds_base lvds_divergencia
uo_ge258_movimentacao lds_Movimentacao 

try
	lvds_divergencia	= Create dc_uo_ds_base
	lds_Movimentacao = Create uo_ge258_movimentacao
	
	lds_Movimentacao.ivb_Commit = False
	
	if not lds_Movimentacao.of_set_mostra_erro_tela(False) then Return False
	
	If Not lvds_divergencia.of_ChangeDataObject("ds_ge473_divergencia_nota", False) Then
		as_log = "Erro ao mudar a DS [ds_ge473_divergencia_nota], fun$$HEX2$$e700e300$$ENDHEX$$o [of_grava_movimentacao_wms_segregados]."
		Return False
	End If
	
	ll_Itens = lvds_divergencia.Retrieve(il_Filial, is_Fornecedor, il_Nota, is_especie, is_Serie)
	
	If ll_Itens = -1 Then
		as_log = "Erro ao localizar os dados da DS [ds_ge473_divergencia_nota], fun$$HEX2$$e700e300$$ENDHEX$$o [of_grava_movimentacao_wms_segregados]."
		Return False
	End If
	
	If ll_Itens > 0 Then
		
		lvdt_Data_Parametro = Date(gf_GetServerDate())
		
		For ll_Item = 1 To ll_Itens
			
			ll_Produto 				= lvds_divergencia.Object.cd_produto				[ll_Item]
			ll_Qtde 					= lvds_divergencia.Object.qt_divergencia			[ll_Item]
			ll_NatOperacao			= lvds_divergencia.Object.cd_natureza_operacao	[ll_Item]
			ldc_bc_Icms_St			= lvds_divergencia.Object.vl_bc_icms_st				[ll_Item]
			ldc_Icms_St				= lvds_divergencia.Object.vl_icms_st					[ll_Item]
			ll_Qtde_Faturada		= lvds_divergencia.Object.qt_faturada				[ll_Item]
			
			ldc_bc_Icms_St		= ldc_bc_Icms_St / ll_Qtde_Faturada
			ldc_Icms_St			= ldc_Icms_St / ll_Qtde_Faturada
			
			ldt_Movimento	= Date(gf_GetServerDate())
			
			//***************Localiza os custos*************************
			select	top 1 vl_custo_unitario,
					vl_custo_gerencial
			into	:ldc_Custo_Unitario,
					:ldc_Custo_Gerencial
			from	movimento_estoque
			where	cd_filial_movimento	= :il_Filial
				and	cd_fornecedor			= :is_Fornecedor
				and	nr_nf						= :il_Nota
				and	de_especie				= :is_especie
				and	de_serie					= :is_Serie
				and	cd_produto				= :ll_Produto
			Using SqlCa;
			
			Choose Case SqlCa.SqlCode
				Case 0
				Case 100
					as_log = "N$$HEX1$$e300$$ENDHEX$$o foram localizados os custos do produto "+String(ll_Produto)+"."
					Return False
				Case -1
					as_log = "Erro ao localizados os custos do produto "+String(ll_Produto)+": "+SqlCa.SqlErrText
					Return False
			End Choose
			//**********************************************************
			
			Select top 1 
					 nr_lote, 
					 dh_validade
			 Into :ls_Lote, :ldt_Validade
			From nf_compra_pend_prd_lote_xml
			Where cd_filial 		= :il_filial
				and cd_fornecedor	= :is_fornecedor
				and nr_nf			= :il_nota
				and de_especie		= :is_especie
				and de_serie		= :is_serie
				and cd_produto		= :ll_Produto
			Using SqlCa;
			
			Choose Case SqlCa.SqlCode
				Case 0
				Case 100
					ls_Lote 			= 'SEM LOTE'
					ldt_Validade	= lvdt_Data_Parametro			
				Case -1
					lvb_Sucesso = False
					Exit				
			End Choose
	
			If Not IsNull(ldt_Validade) Then
				ldt_Validade = Date(String(ldt_Validade, '01/mm/yyyy'))
			End If
	
			If Not This.of_atualiza_falta(ll_Produto, ll_NatOperacao, ls_Lote, ldt_Validade, ll_Qtde, ref as_log) Then Return False
			
			If Not This.of_inclui_segregado_recebimento(is_Endereco_Segregado, ll_Produto, ls_Lote, ldt_Validade, ll_Qtde, ref as_log) Then Return False
			
			// In$$HEX1$$ed00$$ENDHEX$$cio - Enviar movimenta$$HEX2$$e700e300$$ENDHEX$$o para o SAP movimentar do deposito livre utiliza$$HEX2$$e700e300$$ENDHEX$$o para segregado (SOMENTE NO SAP)
			If Not This.of_carrega_chave_movimento_estoque(ref as_log) Then Return False
			
			lds_Movimentacao.is_chave_movimento = is_chave_movimento_estoque
			
			If Not This.of_grava_log_exportacao_sap(ll_Produto, ref as_log) Then Return False

			// Localiza Matricula do Conferente			
			If Not This.of_localiza_conferente_entrada(ll_Produto,ls_Lote,ldt_Validade, Ref is_Matricula_conferente, Ref as_log, il_CX_Padrao ) Then Return False 
						
			// T$$HEX1$$e900$$ENDHEX$$rmino - Enviar movimenta$$HEX2$$e700e300$$ENDHEX$$o para o SAP movimentar do deposito livre utiliza$$HEX2$$e700e300$$ENDHEX$$o para segregado
			//  Caso Conferente VAZIO usa o Padrao:14330
			If IsNull (is_Matricula_conferente) or is_Matricula_conferente = '' Then
				is_Matricula_Entrada = is_Matricula_default
			Else				
				is_Matricula_Entrada = is_Matricula_conferente
			End If 	
			
			If Not lds_Movimentacao.of_Insere_Movimentacao(is_Endereco_Segregado,	ls_Nulo,	ll_Produto,	il_CX_Padrao ,ls_Lote,ldt_Validade,ll_Qtde,&
			 																'S',il_Filial,is_Fornecedor,il_Nota,is_Especie,is_Serie,&
																			is_Matricula_Entrada, ll_Nulo,&
																			Round(ldc_bc_Icms_St * ll_Qtde, 2), Round(ldc_Icms_St * ll_Qtde, 2), ldc_Custo_Unitario, ldc_Custo_Gerencial) Then
				as_log = "Erro ao gravar o movimento no WMS [of_grava_movimentacao_wms_segregados_fal]."
				Return False																				 
			End If
		
		Next
		
		
	End If

finally
	If IsValid(lvds_divergencia) 		Then Destroy(lvds_divergencia)
	If IsValid(lds_Movimentacao) 	Then Destroy(lds_Movimentacao)
	
	SetPointer(Arrow!)
end try

Return True
end function

public function boolean of_carrega_chave_movimento_estoque (ref string ps_log);select newid()
Into :is_chave_movimento_estoque
from parametro
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ps_log	= "Erro ao localizar a chave do movimento de estoque. Erro: "+ SqlCa.SqlErrText
	Return False
End If

Return True
end function

public function boolean of_atualiza_recebimento_nota_loja (string as_log);Long		ll_nr_nf, ll_cd_filial
String	ls_de_especie, ls_de_serie, ls_cd_fornecedor, ls_id_tipo_nf


select cd_fornecedor, 
		 nr_nf, 
		 de_especie, 
		 de_serie,
		 cd_filial,
		 id_tipo_nf
  Into :ls_cd_fornecedor, 
	    :ll_nr_nf, 
		 :ls_de_especie, 
		 :ls_de_serie,
		 :ll_cd_filial,
		 :ls_id_tipo_nf
 from (select cd_fornecedor, 
				  nr_nf, 
				  de_especie, 
				  de_serie,
				  cd_filial,
				  'NC' as id_tipo_nf
		   from nf_compra
		  where de_chave_acesso = :is_de_chave_acesso
		  
		  union
		  
		  select '' as cd_fornecedor, 
				   nr_nf, 
				   de_especie, 
				   de_serie,
				   cd_filial_origem,
					'NT' as id_tipo_nf
			 from nf_transferencia_nfe
		   where de_chave_acesso = :is_de_chave_acesso) as notas
 Using SQLCA;

choose case sqlca.sqlcode
	case -1
		as_log	= 'Erro ao buscar nf_compra/nf_transferencia pela chave de acesso. Erro: ' + SQLCA.SQLErrText
		return false
	case 100
		as_log	= 'Nota de compra/Transfer$$HEX1$$ea00$$ENDHEX$$ncia n$$HEX1$$e300$$ENDHEX$$o encontrada para atualiza$$HEX2$$e700e300$$ENDHEX$$o como confirmada pelo SAP.'
		return false
end choose

if ls_id_tipo_nf = 'NC' then
	update nf_compra
		set dh_recebido_sap = GetDate()
	 where nr_nf 			= :ll_nr_nf and
			 de_especie		= :ls_de_especie and
			 de_serie		= :ls_de_serie and
			 cd_fornecedor	= :ls_cd_fornecedor and
			 cd_filial		= :ll_cd_filial;
			 
	choose case sqlca.sqlcode
		case -1
			as_log	= 'Erro ao atualizar nf_compra como confirmada pelo SAP. Erro: ' + SQLCA.SQLErrText
			return false
	end choose
else
	update nf_transferencia
		set dh_recebido_sap = GetDate()
	 where nr_nf 				= :ll_nr_nf and
			 de_especie			= :ls_de_especie and
			 de_serie			= :ls_de_serie and
			 cd_filial_origem	= :ll_cd_filial;
			 
	choose case sqlca.sqlcode
		case -1
			as_log	= 'Erro ao atualizar nf_transferencia como confirmada pelo SAP. Erro: ' + SQLCA.SQLErrText
			return false
	end choose
end if

return true
end function

public function boolean of_verifica_nota_loja (ref long al_cd_filial, ref string as_log);boolean 	lb_valida_teste_integrado = False
String	ls_cd_fornecedor

uo_ge473_comum lo_Comum
lo_Comum = Create uo_ge473_comum

lb_valida_teste_integrado	= gf_valida_teste_integrado()

if is_de_chave_acesso = '' or IsNull(is_de_chave_acesso) then
	If Not lo_Comum.of_localiza_codigo_fornecedor_legado(is_cd_fornecedor_sap, Ref is_fornecedor, ref as_log) Then 
		Return False
	End If 
	
	is_serie	= 'U'
	
	select top 1 cd_filial
	  into :al_cd_filial
	  from (select cd_filial
			    from nf_compra_pendente
			   where nr_nf				= :il_nota
				  and de_serie			= :is_serie
				  and cd_filial			= :il_filial
				  and de_especie		= 'NFS'
				  and cd_fornecedor	= :is_fornecedor
				
			  union
	 
	 		  select cd_filial
			    from nf_compra
			   where nr_nf				= :il_nota
				  and de_serie			= :is_serie
				  and cd_filial			= :il_filial
				  and de_especie		= 'NFS'
				  and cd_fornecedor	= :is_fornecedor) as nf_servico
	 using SQLCA;	
else	
	select top 1 cd_filial
	  into :al_cd_filial
	  from nf_compra_pendente
	 where de_chave_acesso_remessa = :is_de_chave_acesso
	 using SQLCA;
	
	ib_nf_chave_acesso_remessa	= true
end if

Choose Case SQLCA.SQLCode
	Case -1
		as_log = 'Erro ao buscar pelo registro na nf_compra como remessa: ' + is_de_chave_acesso + ' Erro: ' + SQLCA.SQLErrText
		return false
	Case 0
		ib_nf_servico = true
		
		return true
	Case 100
		if lb_valida_teste_integrado then
			select top 1 cd_filial,
					 de_chave_acesso
			  into :al_cd_filial,
					 :is_de_chave_acesso
			  from recebimento_sap
			 where (de_chave_acesso_alterada	= :is_de_chave_acesso
			 	 or de_chave_acesso				= :is_de_chave_acesso)
				and id_situacao 					<> 'X'
				and dh_estornado					is null
			 order by dh_inclusao desc
			 Using SqlCa;
		else
			select cd_filial
			  into :al_cd_filial
			  from recebimento_sap
			 where de_chave_acesso			= :is_de_chave_acesso
			   and id_situacao 				<> 'X'
				and dh_solicitacao_estorno	is null
			 Using SqlCa;
		End If
		 
		Choose case SQLCA.SQLCode
			case 100 //N$$HEX1$$e300$$ENDHEX$$o desceu pelo SAP o recebimento, ent$$HEX1$$e300$$ENDHEX$$o deve ser ignorado
				al_cd_filial	= 0
				
				Return True
			case -1
				as_log = 'Erro ao buscar pelo registro na recebimento_sap: ' + is_de_chave_acesso + ' Erro: ' + SQLCA.SQLErrText
				return false
			case 0
				if IsNull(al_cd_filial) or al_cd_filial = 0 then
					as_log = 'N$$HEX1$$e300$$ENDHEX$$o foi encontrado cd_filial no registro da recebimento_sap da nf: ' + is_de_chave_acesso
					return false
				end if
				
				return true
		end choose
end choose
end function

public function boolean of_verifica_compra_prd_item (long al_cd_filial, string as_cd_fornecedor, long al_nr_nf, string as_de_especie, string as_de_serie, ref long al_qt_produtos, ref string as_log);Select count(*)
Into :al_qt_produtos
From nf_compra_pendente_prd_item   
Where cd_filial     		= :al_cd_filial
	And cd_fornecedor		= :as_cd_fornecedor
	And nr_nf         	= :al_nr_nf
	And de_especie    	= :as_de_especie
	And de_serie      	= :as_de_serie 
Using SQLCa;

If SqlCa.SqlCode = -1 Then
	as_Log	= "Erro ao localizar registro na tabela [NF_COMPRA_PENDENTE_PRD_ITEM]. Nota/Especie/S$$HEX1$$e900$$ENDHEX$$rie [" + String(al_nr_nf) + "/" + as_de_especie + "/" + as_de_serie + "]. Erro: " + SqlCa.SqlErrText
	Return False
End If
	
Return True

end function

public function boolean of_insere_nf_remessa (long pl_nr_nf, string ps_de_serie, string ps_de_especie, long pl_cd_filial, string ps_cd_fornecedor, string ps_tipo_entrada_nfe, ref string as_log);Long		ll_cd_natureza_operacao, ll_nr_nf_remessa, ll_cd_filial_remessa, ll_cd_filial_nfe, ll_nr_nf_nfe, &
			ll_qt_volumes_nfe, ll_Exists, ll_qt_produtos
String	ls_de_natureza_operacao, ls_de_chave_acesso_remessa, ls_de_serie_remessa, ls_de_especie_remessa, &
			ls_cd_fornecedor_remessa, ls_de_especie_nfe, ls_de_serie_nfe, ls_de_chave_acesso_nfe, ls_operador = '14330'


select de_chave_acesso_remessa
  into :ls_de_chave_acesso_remessa
  from nf_compra_pendente ncp
 where ncp.nr_nf 				= :pl_nr_nf
   and ncp.de_serie 			= :ps_de_serie
   and ncp.de_especie 		= :ps_de_especie
   and ncp.cd_filial			= :pl_cd_filial
   and ncp.cd_fornecedor 	= :ps_cd_fornecedor;

Choose Case SQLCA.SQLCode
	Case -1
		as_log = "Erro ao buscar chave de acesso da nf_compra_pendente. " + SQLCA.SQLErrText

		Return False	
	Case 100
		Return True
End Choose

if IsNull(ls_de_chave_acesso_remessa) or Trim(ls_de_chave_acesso_remessa) = '' then
	Return True
end if

select top 1 cd_natureza_operacao,
		 ncp.nr_nf,
		 ncp.de_serie,
		 ncp.de_especie,
		 ncp.cd_fornecedor,
		 ncp.cd_filial
  into :ll_cd_natureza_operacao,
  		 :ll_nr_nf_remessa,
		 :ls_de_serie_remessa,
		 :ls_de_especie_remessa,
		 :ls_cd_fornecedor_remessa,
		 :ll_cd_filial_remessa
  from nf_compra_pendente ncp
 inner join nf_compra_pendente_produto ncpp
	 on ncpp.nr_nf 			= ncp.nr_nf
   and ncpp.de_serie 		= ncp.de_serie
   and ncpp.de_especie 		= ncp.de_especie
   and ncpp.cd_filial		= ncp.cd_filial
   and ncpp.cd_fornecedor 	= ncp.cd_fornecedor  
 where ncp.de_chave_acesso	= :ls_de_chave_acesso_remessa;
 
Choose Case SQLCA.SQLCode
	Case -1
		as_log = "Erro ao buscar natureza de opera$$HEX2$$e700e300$$ENDHEX$$o da nf_compra_pendente_produto. " + SQLCA.SQLErrText

		Return False
	Case 100
		as_log = "N$$HEX1$$e300$$ENDHEX$$o foi localizada a natureza de opera$$HEX2$$e700e300$$ENDHEX$$o da nf_compra_pendente_produto."

		Return False
End Choose

if IsNull(ls_de_chave_acesso_remessa) or trim(ls_de_chave_acesso_remessa) = '' or &
	(ll_cd_natureza_operacao <> 6923 and ll_cd_natureza_operacao <> 5923) Then
	Return True
End If
  
select de_natureza_operacao
  into :ls_de_natureza_operacao
  from natureza_operacao
 where cd_natureza_operacao = :ll_cd_natureza_operacao;
 
Choose Case SQLCA.SQLCode
	Case -1
		as_log = "Erro ao buscar descri$$HEX2$$e700e300$$ENDHEX$$o da natureza de opera$$HEX2$$e700e300$$ENDHEX$$o da natureza_operacao. " + SQLCA.SQLErrText
		
		Return False
	Case 100
		as_log = "N$$HEX1$$e300$$ENDHEX$$o foi localizada a descri$$HEX2$$e700e300$$ENDHEX$$o da natureza de opera$$HEX2$$e700e300$$ENDHEX$$o da natureza_operacao."
		
		Return False
End Choose

Insert Into nf_compra (cd_filial,   
							  cd_fornecedor,   
							  nr_nf,   
							  de_especie,   
							  de_serie,   
							  dh_emissao,   
							  dh_movimentacao_caixa,   
							  vl_bc_icms,   
							  vl_icms,   
							  vl_bc_icms_st,   
							  vl_icms_st,   
							  vl_icms_repassado,   
							  vl_total_produtos,   
							  vl_ipi,   
							  vl_frete,   
							  vl_seguro,   
							  vl_outras_despesas,   
							  vl_desconto,   
							  vl_indenizacao,   
							  vl_total_nf,   
							  nr_pedido_central,   
							  id_bonificacao,
							  cd_condicao_pagamento,
							  dh_registro,
							  nr_matricula_registro,
							  nr_matricula_conferente,
							  de_chave_acesso,
							  id_tipo_entrada_nfe,
							  dh_importacao_xml,
							  de_chave_acesso_remessa)  
Select n.cd_filial,
	    n.cd_fornecedor,   
	    n.nr_nf,   
	    n.de_especie,   
	    n.de_serie,
       n.dh_emissao,   
		 p.dh_movimentacao,
	    n.vl_bc_icms,   
	    n.vl_icms,   
	    n.vl_bc_icms_st,   
	    n.vl_icms_st,   
	    n.vl_icms_repassado,   
	    n.vl_total_produtos,   
	    n.vl_ipi,   
	    n.vl_frete,   
	    n.vl_seguro,   
	    n.vl_outras_despesas,   
	    n.vl_desconto,   
	    n.vl_indenizacao,   
	    n.vl_total_nf,
		 n.nr_pedido,
       n.id_bonificacao,
		 n.cd_condicao_pagamento,
		 getdate(),
		 :ls_operador,
		 :ls_operador,
		 n.de_chave_acesso,
		 :ps_tipo_entrada_nfe,
		 n.dh_importacao_xml,
		 n.de_chave_acesso_remessa
From nf_compra_pendente n,
     parametro p
Where n.cd_filial     = :ll_cd_filial_remessa
  and n.cd_fornecedor = :ls_cd_fornecedor_remessa
  and n.nr_nf         = :ll_nr_nf_remessa
  and n.de_especie    = :ls_de_especie_remessa
  and n.de_serie      = :ls_de_serie_remessa
Using SqlCa;

if SQLCA.SqlCode = -1 Then
	as_log = 'Erro ao inserir nota de remessa na nf_compra' + SQLCA.SqlErrText
	
	Return False
end if

Insert Into item_nf_compra (	cd_filial,   
										cd_fornecedor,   
										nr_nf,   
										de_especie,   
										de_serie,   
										cd_natureza_operacao,   
										cd_produto,   
										cd_situacao_tributaria,   
										qt_faturada,   
										qt_recebida,   
										vl_preco_unitario,   
										pc_desconto,   
										pc_icms,   
										pc_ipi,   
										id_lista_pis_cofins,   
										vl_icms_repassado,
										pc_reducao_base_icms,
										vl_preco_base_icms_st,
										vl_icms_st,
										vl_bc_icms,   
										vl_icms,   
										vl_bc_ipi,   
										vl_ipi,   
										vl_outras_despesas,   
										pc_icms_st,   
										vl_bc_icms_st_total,   
										vl_icms_st_total,
										cd_cst_origem,
										cd_cst_tributacao,
										qt_avariada,
										cd_natureza_operacao_xml,
										nr_classificacao_fiscal,
										id_reducao_base_icms,
										vl_preco_unitario_fiscal,
										cd_mod_bc_icms,
										vl_icms_operacao,
										pc_dif_icms,
										vl_icms_dif,
										vl_bc_icms_antecipacao,
										pc_mva_icms_antecipacao,
										pc_icms_antecipacao,
										vl_icms_antecipacao,
										vl_bc_icms_st_calculado,
										vl_icms_st_calculado,
										vl_bc_icms_st_retido,
										vl_icms_st_retido, 
										nr_sequencial,
										vl_total_item,
										vl_desconto_total, 
										qt_comercial, 
										qt_tributavel, 
										cd_unidade_comercial, 
										cd_unidade_tributavel,
										pc_st_retido,
										vl_icms_retido,
										cd_beneficio,
										cd_mod_bc_st,
										pc_mva,
										cd_cest,
										vl_bc_icms_total,
										vl_icms_total,
										vl_bc_ipi_total,
										vl_ipi_total,
										vl_icms_desonerado,
										id_motivo_desoneracao_icms,
										vl_bc_st_fcp,
										vl_st_fcp,
										cd_cst_pis,
										vl_bc_pis_xml,
										pc_pis_xml,
										vl_pis,
										cd_cst_cofins,
										vl_bc_cofins_xml,
										pc_cofins_xml,
										vl_cofins,
										cd_cst_pis_entrada,
										vl_bc_pis_entrada,
										pc_pis_entrada,
										vl_pis_entrada,
										cd_cst_cofins_entrada,
										vl_bc_cofins_entrada,
										pc_cofins_entrada,
										vl_cofins_entrada)
										
Select			cd_filial,
				cd_fornecedor,   
				nr_nf,   
				de_especie,   
				de_serie,
				cd_natureza_operacao,   
				cd_produto,   
				cd_situacao_tributaria,   
				qt_faturada,   
				qt_recebida,   
				vl_preco_unitario,   
				pc_desconto,   
				pc_icms,   
				pc_ipi,   
				id_lista_pis_cofins,
				vl_icms_repassado,
				pc_reducao_base_icms,
				vl_preco_base_icms_st,
				vl_icms_st,
				vl_bc_icms,   
				vl_icms,   
				vl_bc_ipi,   
				vl_ipi,   
				vl_outras_despesas,   
				pc_icms_st,   
				vl_bc_icms_st_total,   
				vl_icms_st_total,
				cd_cst_origem,
				cd_cst_tributacao,
				qt_avariada,
				cd_natureza_operacao_xml,
				nr_classificacao_fiscal,
				id_reducao_base_icms,
				vl_preco_unitario_fiscal,
				cd_mod_bc_icms,
				vl_icms_operacao,
				pc_dif_icms,
				vl_icms_dif,
				vl_bc_icms_antecipacao,
				pc_mva_icms_antecipacao,
				pc_icms_antecipacao,
				vl_icms_antecipacao,
				vl_bc_icms_st_calculado,
				vl_icms_st_calculado,
				vl_bc_icms_st_retido,
				vl_icms_st_retido,
				nr_sequencial,
				vl_total_item,
				vl_desconto_total, 
				qt_comercial, 
				qt_tributavel, 
				cd_unidade_comercial, 
				cd_unidade_tributavel, 
				pc_st_retido , 
				vl_icms_retido,
				cd_beneficio,
				cd_mod_bc_st,
				pc_mva,
				cd_cest,
				vl_bc_icms_total,
				vl_icms_total,
				vl_bc_ipi_total,
				vl_ipi_total,
				vl_icms_desonerado,
				id_motivo_desoneracao_icms,
				vl_bc_st_fcp,
				vl_st_fcp,
				CASE cd_cst_pis WHEN '0' THEN null ELSE cd_cst_pis END,
				vl_bc_pis_xml,
				pc_pis_xml,
				vl_pis,
				CASE cd_cst_cofins WHEN '0' THEN null ELSE cd_cst_cofins END,
				vl_bc_cofins_xml,
				pc_cofins_xml,
				vl_cofins,
				cd_cst_pis_entrada,
				vl_bc_pis_entrada,
				pc_pis_entrada,
				vl_pis_entrada,
				cd_cst_cofins_entrada,
				vl_bc_cofins_entrada,
				pc_cofins_entrada,
				vl_cofins_entrada
From nf_compra_pendente_produto n
Where n.cd_filial     = :ll_cd_filial_remessa
  and n.cd_fornecedor = :ls_cd_fornecedor_remessa
  and n.nr_nf         = :ll_nr_nf_remessa
  and n.de_especie    = :ls_de_especie_remessa
  and n.de_serie      = :ls_de_serie_remessa
Using SqlCa;

if SQLCA.SqlCode = -1 Then
	as_log = 'Erro ao inserir itens da nota de remessa na item_nf_compra' + SQLCA.SqlErrText
	
	Return False
end if

Insert Into item_nf_compra_lote (cd_filial,   
											cd_fornecedor,   
											nr_nf,   
											de_especie,   
											de_serie,   
											cd_natureza_operacao,   
											cd_produto,   
											nr_lote,   
											qt_lote,
											qt_avariada,
											dh_validade,
											dh_fabricacao,
											id_vencimento_proximo) 
Select cd_filial,
		 cd_fornecedor,   
		 nr_nf,   
		 de_especie,   
		 de_serie,
		 cd_natureza_operacao,   
		 cd_produto,   
		 nr_lote,   
		 qt_lote,
		 qt_avariada,
		 dh_validade,
		 dh_fabricacao,
		 id_vencimento_proximo
  From nf_compra_pendente_prd_lote n
 Where n.cd_filial  		= :ll_cd_filial_remessa
  and n.cd_fornecedor 	= :ls_cd_fornecedor_remessa
  and n.nr_nf         	= :ll_nr_nf_remessa
  and n.de_especie    	= :ls_de_especie_remessa
  and n.de_serie      	= :ls_de_serie_remessa
  and qt_lote				> 0
Using SqlCa;

if SQLCA.SqlCode = -1 Then
	as_log = 'Erro ao inserir os lotes dos itens da nota de remessa na item_nf_compra_lote' + SQLCA.SqlErrText
	
	Return False
end if

If of_verifica_compra_prd_item(ll_cd_filial_remessa, ls_cd_fornecedor_remessa, ll_nr_nf_remessa, ls_de_especie_remessa, ls_de_serie_remessa, ll_qt_produtos, as_log) Then 
	if ll_qt_produtos > 0 then
		If not of_grava_item_nf_compra_prd(ll_cd_filial_remessa, ls_cd_fornecedor_remessa, ll_nr_nf_remessa, ls_de_especie_remessa, ls_de_serie_remessa, as_log) Then 
			Return False
		End If
	end if
End If 

if not of_Exclui_Nota_Fiscal(ll_cd_filial_remessa, ls_cd_Fornecedor_remessa, ll_nr_nf_remessa, ls_de_Especie_remessa, ls_de_Serie_remessa, as_log) then
	Return False
end if

Return True
end function

public function boolean of_grava_item_nf_compra_prd (long al_cd_filial, string as_cd_fornecedor, long al_nr_nf, string as_de_especie, string as_de_serie, ref string as_log);// Para gravar os dados na tabela Item_Nf_Compra_Prd, quando tem dados na tabela : Nf_Compra_Pendente_Prd_Item
SetPointer(HourGlass!)

INSERT INTO item_nf_compra_prd  (
				cd_filial,   
				cd_fornecedor,   
				nr_nf,   
				de_especie,   
				de_serie,   
				nr_sequencial,   
				cd_produto,   
				qt_faturada,   
				vl_custo_entrada,   
				vl_preco_unitario,   
				pc_desconto,   
				vl_total_item,   
				vl_desconto_total,   
				cd_cst_origem,   
				cd_cst_tributacao,   
				vl_bc_ipi,   
				pc_ipi,   
				vl_ipi,   
				vl_icms_repassado,   
				pc_reducao_base_icms,   
				vl_bc_icms,   
				pc_icms,   
				vl_icms,   
				vl_bc_icms_st_total,   
				pc_icms_st,   
				vl_icms_st_total,   
				vl_bc_icms_st_calculado,   
				vl_icms_st_calculado,   
				vl_bc_icms_st_retido,   
				vl_icms_st_retido,   
				vl_outras_despesas,   
				vl_bc_icms_antecipacao,   
				pc_mva_icms_antecipacao,   
				pc_icms_antecipacao,   
				vl_icms_antecipacao,   
				vl_bc_fcp,   
				pc_fcp,   
				vl_fcp,   
				vl_bc_st_fcp,   
				pc_st_fcp,   
				vl_st_fcp,   
				vl_bc_ret_fcp,   
				pc_ret_fcp,   
				vl_ret_fcp, 		 
				qt_comercial,
				qt_tributavel,
				cd_unidade_comercial,
				cd_unidade_tributavel ,		 
				pc_st_retido,
				vl_icms_retido,
				cd_beneficio,
				cd_mod_bc_st,
				pc_mva,
				cd_cest,
				vl_bc_pis_xml,
				pc_pis_xml,
				vl_pis,
				vl_bc_cofins_xml,
				pc_cofins_xml,
				vl_cofins,
				cd_cst_pis_entrada,
				vl_bc_pis_entrada,
				pc_pis_entrada,
				vl_pis_entrada,
				cd_cst_cofins_entrada,
				vl_bc_cofins_entrada,
				pc_cofins_entrada,
				vl_cofins_entrada) 
	  select 		cd_filial,   
					cd_fornecedor,   
					nr_nf,   
					de_especie,   
					de_serie,   
					nr_sequencial,   
					cd_produto,   
					qt_faturada,   
					vl_custo_entrada,   
					vl_preco_unitario,   
					pc_desconto,   
					vl_total_item,   
					vl_desconto_total,   
					cd_cst_origem,   
					cd_cst_tributacao,   
					vl_bc_ipi,   
					pc_ipi,   
					vl_ipi,   
					vl_icms_repassado,   
					pc_reducao_base_icms,   
					vl_bc_icms,   
					pc_icms,   
					vl_icms,   
					vl_bc_icms_st_total,   
					pc_icms_st,   
					vl_icms_st_total,   
					vl_bc_icms_st_calculado,   
					vl_icms_st_calculado,   
					vl_bc_icms_st_retido,   
					vl_icms_st_retido,   
					vl_outras_despesas,   
					vl_bc_icms_antecipacao,   
					pc_mva_icms_antecipacao,   
					pc_icms_antecipacao,   
					vl_icms_antecipacao,   
					vl_bc_fcp,   
					pc_fcp,   
					vl_fcp,   
					vl_bc_st_fcp,   
					pc_st_fcp,   
					vl_st_fcp,   
					vl_bc_ret_fcp,   
					pc_ret_fcp,   
					vl_ret_fcp, 
					qt_comercial,
					qt_tributavel,
					cd_unidade_comercial,
					cd_unidade_tributavel,
					pc_st_retido,
					vl_icms_retido,
					cd_beneficio,
					cd_mod_bc_st,
					pc_mva,
					cd_cest,
					vl_bc_pis_xml,
					pc_pis_xml,
					vl_pis,
					vl_bc_cofins_xml,
					pc_cofins_xml,
					vl_cofins,
					cd_cst_pis_entrada,
					vl_bc_pis_entrada,
					pc_pis_entrada,
					vl_pis_entrada,
					cd_cst_cofins_entrada,
					vl_bc_cofins_entrada,
					pc_cofins_entrada,
					vl_cofins_entrada
		 from nf_compra_pendente_prd_item
		where cd_filial		= :al_cd_filial
		  and cd_fornecedor	= :as_cd_fornecedor
		  and nr_nf				= :al_nr_nf
		  and de_especie		= :as_de_especie
		  and de_serie			= :as_de_serie
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_Log	= "Erro ao gravar registro na tabela [ITEM_NF_COMPRA_PRD]. Nota/Especie/S$$HEX1$$e900$$ENDHEX$$rie [" + String(al_nr_nf) + "/" + as_de_especie + "/" + as_de_serie + "]. Erro: " + SqlCa.SqlErrText
	SetPointer(Arrow!)
	Return False
End If 

SetPointer(Arrow!)

Return True
end function

public function boolean of_exclui_nota_fiscal (long al_cd_filial, string as_cd_fornecedor, long al_nr_nf, string as_de_especie, string as_de_serie, ref string as_log);// Exclui os t$$HEX1$$ed00$$ENDHEX$$tulos a pagar
Delete From titulo_pagar_pendente
Where cd_filial     	= :al_cd_filial
  	and cd_fornecedor = :as_cd_fornecedor
  	and nr_nf         = :al_nr_nf
  	and de_especie    = :as_de_especie
  	and de_serie      = :as_de_serie
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_Log	= "Erro ao excluir registro na tabela [TITULO_PAGAR_PENDENTE]. Nota/Especie/S$$HEX1$$e900$$ENDHEX$$rie [" + String(al_nr_nf) + "/" + as_de_especie + "/" + as_de_serie + "]. Erro: " + SqlCa.SqlErrText
	Return False
End If

// Exclui os lotes psico dos produtos da nota fiscal
Delete From nf_compra_pendente_prd_lote
Where cd_filial     	= :al_cd_filial
  	and cd_fornecedor = :as_cd_fornecedor
  	and nr_nf         = :al_nr_nf
  	and de_especie    = :as_de_especie
  	and de_serie      = :as_de_serie
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_Log	= "Erro ao excluir registro na tabela [NF_COMPRA_PENDENTE_PRD_LOTE]. Nota/Especie/S$$HEX1$$e900$$ENDHEX$$rie [" + String(al_nr_nf) + "/" + as_de_especie + "/" + as_de_serie + "]. Erro: " + SqlCa.SqlErrText
	Return False
End If

// Exclui os produtos da nota fiscal
Delete From nf_compra_pendente_produto
Where cd_filial     	= :al_cd_filial
  	and cd_fornecedor = :as_cd_fornecedor
  	and nr_nf         = :al_nr_nf
  	and de_especie    = :as_de_especie
  	and de_serie      = :as_de_serie
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_Log	= "Erro ao excluir registro na tabela [NF_COMPRA_PENDENTE_PRODUTO]. Nota/Especie/S$$HEX1$$e900$$ENDHEX$$rie [" + String(al_nr_nf) + "/" + as_de_especie + "/" + as_de_serie + "]. Erro: " + SqlCa.SqlErrText
	Return False
End If

// Trecho Novo :  Exclui a nota fiscal
Delete From nf_compra_pendente_prd_item
Where cd_filial     = :al_cd_filial
  and cd_fornecedor = :as_cd_fornecedor
  and nr_nf         = :al_nr_nf
  and de_especie    = :as_de_especie
  and de_serie      = :as_de_serie
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_Log	= "Erro ao excluir registro na tabela [NR_COMPRA_PENDENTE_PRD_ITEM]. Nota/Especie/S$$HEX1$$e900$$ENDHEX$$rie [" + String(al_nr_nf) + "/" + as_de_especie + "/" + as_de_serie + "]. Erro: " + SqlCa.SqlErrText
	Return False
End If		

// Exclui a nota fiscal
Delete From nf_compra_pendente
Where cd_filial     = :al_cd_filial
  and cd_fornecedor = :as_cd_fornecedor
  and nr_nf         = :al_nr_nf
  and de_especie    = :as_de_especie
  and de_serie      = :as_de_serie
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_Log	= "Erro ao excluir registro na tabela [NF_COMPRA_PENDENTE]. Nota/Especie/S$$HEX1$$e900$$ENDHEX$$rie [" + String(al_nr_nf) + "/" + as_de_especie + "/" + as_de_serie + "]. Erro: " + SqlCa.SqlErrText
	Return False
End If		

Return True
end function

public function boolean of_grava_movimentacao_wms_flow_rack (string as_endereco_receb_liberado, string as_endereco_flow, long al_produto, long al_cx_padrao, string as_lote, date adt_validade, long al_qtde, uo_ge258_movimentacao ao_movimentacao, ref string as_log);String 	ls_Endereco_Entrada,&
			ls_Erro,&
			ls_Nulo,&
			ls_Geladeira,&
			ls_Controlado,&
			ls_Vigiado,&
			ls_esteira
			
Long 		ll_Nr_Movimentacao,&
			ll_Nulo,&
			ll_Esteira, ll_Achou = 0

SetNull(ls_Endereco_Entrada)
SetNull(ls_Nulo)
SetNull(ll_Nulo)

If ib_Inicio_Controle_Temp_Rdc Then
	SELECT count(*)
	INTO :ll_Achou
	FROM lote_rec_vol_geladeira_prd
	WHERE nr_lote = :il_Lote_Conferencia
		AND cd_produto=:al_produto 
		AND nr_lote_produto=:as_lote
		AND qt_caixa_padrao=:al_cx_padrao
	Using Sqlca;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_Rollback()
		as_log = "Erro selecionar dados do produto: "+ SqlCa.SQLErrText
		Return False
	End If
	
	If ll_Achou > 0 Then
		Return True
	End If
End If

If Not ao_Movimentacao.of_insere_movimentacao(ls_Endereco_Entrada,&
															 as_Endereco_Receb_Liberado,&
															 al_Produto,&
															 al_Cx_Padrao,&
															 as_Lote,&
															 adt_Validade,&
															 al_Qtde,&
															 "N",&
															 ll_Nulo,&
															 ls_Nulo,&
															 ll_Nulo,&
															 ls_Nulo,&
															 ls_Nulo,&
															 is_Matricula_Entrada ) Then
															 
	as_log	= ao_Movimentacao.is_log_erro
	
	SqlCa.of_Rollback()
	
	Return False
End If																		

//Pega o n$$HEX1$$fa00$$ENDHEX$$mero da movimenta$$HEX2$$e700e300$$ENDHEX$$o
select Top 1 nr_movimentacao
  Into :ll_Nr_Movimentacao
  from wms_movimentacao
 where cd_produto 					= :al_Produto
   and nr_matricula_responsavel 	= :is_Matricula_Entrada
	and cd_endereco_saida 			= :as_Endereco_Receb_Liberado
	and nr_lote							= :as_Lote
	and qt_caixa_padrao 				= :al_Cx_Padrao
	and dh_validade 					= :adt_Validade
	and id_tipo_movimento 			= 'N' // Tipo 'N' Entrada endere$$HEX1$$e700$$ENDHEX$$o autom$$HEX1$$e100$$ENDHEX$$tico ap$$HEX1$$f300$$ENDHEX$$s recebimento
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case -1
		ls_Erro = SqlCa.SQLErrText
		SqlCa.of_Rollback()
		
		as_log = "Erro selecionar dados do produto: "+ ls_Erro
		
		Return False
	Case 100
		SqlCa.of_Rollback()
		as_log = "Produto n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ em movimenta$$HEX2$$e700e300$$ENDHEX$$o."
		Return False	
End Choose

If Not ao_Movimentacao.of_Atualiza_Movimentacao(as_Endereco_Flow,&
																al_Produto,&
																ll_Nr_Movimentacao,&
																al_Qtde,&
																as_Lote,&
																al_Cx_Padrao,&
																DateTime(adt_Validade)) Then
	as_log	= ao_Movimentacao.is_log_erro
	
	SqlCa.of_Rollback()
	
	Return False
End If

Return True
end function

public function boolean of_inclui_segregado_recebimento (string as_endereco, string as_fornecedor, long al_nota, string as_especie, string as_serie, long al_produto, string as_lote, date adh_validade, long al_qtde_lote, ref string as_log);insert into wms_segregado_recebimento (cd_endereco,
													cd_fornecedor,
													nr_nf,
													de_especie,
													de_serie,
													cd_produto,
													nr_lote,
													dh_validade,
													qt_lote)
  										 values (:as_endereco,
												   :as_fornecedor,
												   :al_nota,
												   :as_especie,
												   :as_serie,
												   :al_produto,
												   :as_lote,
												   :adh_validade,
												   :al_qtde_lote)
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_log = "Inclus$$HEX1$$e300$$ENDHEX$$o do lote na tabela wms_segregado_receb_liberado '" + SQLCA.SQLErrText + "'."
	
	SqlCa.of_RollBack()
	
	Return False
End If

Return True

end function

public function boolean of_verifica_lote_controlado (ref boolean ab_controlado, ref string as_log);Date 		ld_dh_servidor
String 	ls_dh_parametro



ld_dh_servidor = Date(gf_GetServerDate())

select vl_parametro
  into :ls_dh_parametro
  from parametro_geral 
 where cd_parametro = 'DH_INICIO_PADPICKING_LOTE'
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_log = "Erro ao verificar se o padPicking por Lote" + SQLCA.SQLErrText
	Return False
End If

If Date(ld_dh_servidor) >= Date(ls_dh_parametro) Then 
	ab_controlado = True
Else
	ab_controlado = False
End If 
	
Return True
end function

public function boolean of_verifica_validade_lote (string as_endereco, long al_produto, long al_caixa_padrao, string as_lote, date adt_validade, ref date adt_vali_cadastrada, ref string as_erro);Select dh_validade
  Into :adt_Vali_Cadastrada
  From wms_localizacao 
 Where cd_endereco 		= :as_Endereco
	And cd_produto 		= :al_Produto
	And qt_caixa_padrao 	= :al_Caixa_Padrao
	And nr_lote 			= :as_Lote
	And dh_validade 		<> :adt_Validade
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case -1
		as_erro = "Erro ao consultar a validade cadastrada.~r~r"+&
								"Endere$$HEX1$$e700$$ENDHEX$$o: " + as_Endereco + "~r"+&
								"Produto: " + String(al_Produto) + "~r"+&
								"Caixa Padr$$HEX1$$e300$$ENDHEX$$o: " + String(al_Caixa_Padrao) + "~r" + &
								"Lote: "+as_Lote+"~r" + SqlCa.SQLErrText

		SqlCa.of_Rollback()

		Return False			
	Case 100
		SetNull(adt_Vali_Cadastrada)
End Choose

Return True			
end function

public function boolean of_grava_movimentacao_wms_receb_lib (ref string as_log);Boolean 	lb_sucesso = True
Date 		ld_validade, ld_validade_cadastrada
Long 		ll_linhas_produtos, ll_linha, ll_cx_padrao, ll_qtde, ll_produto, ll_nulo, ll_nota, ll_recebida, &
			ll_avariada, ll_esteira, ll_qtde_lote, ll_qtde_coletor, ll_registros_lote, ll_Qt_Rec_Produto_Gel
String 	ls_lote, ls_nulo, ls_grupo_psico, ls_inclui, ls_fornecedor, ls_especie, ls_serie, &
			ls_vencido, ls_vencido_lib, ls_flow_rack, ls_endereco_flow, ls_subcategoria, &
			ls_endereco_recebimento, ls_endereco_licitacao, ls_retorno_paramentro, ls_id_mantem_fracionado_recebimento

uo_ge258_movimentacao luo_ge258_movimentacao


SetNull(ll_nulo)
SetNull(ls_nulo)

SetPointer(HourGlass!)

dc_uo_ds_base lds
lds = Create dc_uo_ds_base

If Not lds.of_ChangeDataObject("dw_ge473_lista_produto") Then
	Destroy(lds)
	Return False
End If

ll_linhas_produtos = lds.Retrieve(il_lote_conferencia)

If ll_linhas_produtos > 0 Then
	
	SELECT
		TOP 1 SUM_LOTE
		INTO :ll_qtde_lote
	FROM
		(
			SELECT
				SUM(p.qt_lote) AS SUM_LOTE
			FROM
				nf_compra_pendente_prd_lote p
			INNER JOIN lote_recebimento_nf n on
				n.nr_nf = p.nr_nf
				AND n.de_especie = p.de_especie
				AND n.de_serie = p.de_serie
			INNER JOIN lote_recebimento l on
				l.nr_lote = n.nr_lote
				AND l.cd_fornecedor = p.cd_fornecedor
			WHERE
				p.cd_filial = :il_filial
				AND l.nr_lote = :il_lote_conferencia
		UNION ALL
			SELECT
				sum(p.qt_lote - Coalesce(p.qt_falta, 0)) AS SUM_LOTE
			FROM
				item_nf_compra_lote p
			INNER JOIN lote_recebimento_nf n on
				n.nr_nf = p.nr_nf
				AND n.de_especie = p.de_especie
				AND n.de_serie = p.de_serie
			INNER JOIN lote_recebimento l on
				l.nr_lote = n.nr_lote
				AND l.cd_fornecedor = p.cd_fornecedor
			WHERE
				p.cd_filial = :il_filial
				AND l.nr_lote = :il_lote_conferencia
		) QT_LOTES
	ORDER BY
		1 DESC
	Using SqlCa;
		
	If SqlCa.SqlCode = -1 Then
		as_log	= "Erro ao buscar quantidade pendente do lote " + SQLCA.SQLErrText
		
		SQLCA.of_rollback()
		
		Destroy(lds)
		
		SetPointer(Arrow!)
		
		Return False
	End If	
	
	ll_qtde_coletor = lds.GetItemNumber(ll_linhas_produtos, "qt_validacao_total")
	
	If ll_qtde_coletor <> ll_qtde_lote Then
		as_log = "A quantidade recebida no coletor '" + String(ll_qtde_coletor) +&
					"' est$$HEX1$$e100$$ENDHEX$$ diferente da quantidade rateada '" + String(ll_qtde_lote) +&
					"' das notas.~r~rMotivo: Erro no rateio."
					
		SQLCA.of_rollback()

		Destroy(lds)
		
		SetPointer(Arrow!)
		
		Return False
	End If
	
	If Not of_endereco_licitacao(REF ls_endereco_licitacao, REF as_log) Then
		SQLCA.of_rollback()
		
		Destroy(lds)
		
		Return False
	End If
	
	luo_ge258_movimentacao	= Create uo_ge258_movimentacao
	
	luo_ge258_movimentacao.ivb_Commit = False
	
	if not luo_ge258_movimentacao.of_set_mostra_erro_tela(False) then Return False
	
	For ll_linha = 1 To ll_linhas_produtos
		ll_produto 			= lds.Object.cd_produto[ll_linha]
		ls_lote 				= lds.Object.nr_lote[ll_linha]
		ll_cx_padrao		= lds.Object.qt_caixa_padrao[ll_linha]
		ld_Validade 			= Date(lds.Object.dh_validade[ll_linha])
		ll_qtde 				= lds.Object.qt_recebida[ll_linha]
		ls_grupo_psico 		= lds.Object.cd_grupo_psico[ll_linha]
		ll_recebida 			= lds.Object.qt_recebida[ll_linha]
		ll_avariada			= lds.Object.qt_avariada[ll_linha]
		ls_vencido			= lds.Object.id_vencimento_proximo[ll_linha]
		ls_vencido_lib		= lds.Object.id_vencimento_proximo_Lib[ll_linha]		
		ll_qtde 				= ll_recebida - ll_avariada
		ls_flow_rack			= lds.Object.id_flow_rack[ll_linha]
		
		If ib_Inicio_Controle_Temp_Rdc Then
			SELECT sum(qt_recebida_produto)
			INTO :ll_Qt_Rec_Produto_Gel
			FROM lote_rec_vol_geladeira_prd
			WHERE nr_lote = :il_lote_conferencia 
				AND cd_produto = :ll_produto 
				AND nr_lote_produto = :ls_lote
				AND qt_caixa_padrao = :ll_cx_padrao
			Using Sqlca;
			
			Choose Case SqlCa.SqlCode 
				Case 0
					If IsNull(ll_Qt_Rec_Produto_Gel) Then ll_Qt_Rec_Produto_Gel = 0
					
					ll_qtde = ll_qtde - ll_Qt_Rec_Produto_Gel
					
					If ll_qtde > 0 and ll_Qt_Rec_Produto_Gel > 0 Then
						as_log = "Verifica a quantidade que foi recebida no recebimento de geladeira."
						SQLCA.of_rollback()
						Destroy(lds)
						lb_sucesso = False
						Exit
					End if
					
				Case -1
					as_log = "Erro ao localizar os dados na lote_rec_vol_geladeira_prd." + SQLCA.SQLErrText
					SQLCA.of_rollback()
					Destroy(lds)
					lb_sucesso = False
					Exit
					
			End Choose
		End If
		
		If Not IsNull(ld_Validade) Then
			ld_Validade = Date(String(ld_Validade, '01/mm/yyyy'))
		End If

		ls_fornecedor	= ls_nulo
		ll_nota			= ll_nulo
		ls_especie		= ls_nulo
		ls_serie			= ls_nulo
		
		SELECT
				cd_fornecedor 
			 , nr_nf
			 , de_especie
			 , de_serie
			 , qt_registros_lote
		INTO :ls_fornecedor
		  	, :ll_nota
		  	, :ls_especie
		  	, :ls_serie
		  	, :ll_registros_lote
		FROM
			(
			SELECT
				TOP 1 p.cd_fornecedor
					 , p.nr_nf
					 , p.de_especie
					 , p.de_serie
					 , (
						SELECT
							COUNT (*)
						FROM
							nf_compra_pendente_prd_lote p
						INNER JOIN lote_recebimento_nf n
								ON  n.nr_nf      = p.nr_nf
								AND n.de_especie = p.de_especie
								AND n.de_serie   = p.de_serie
						INNER JOIN lote_recebimento l
								ON  l.nr_lote       = n.nr_lote
								AND l.cd_fornecedor = p.cd_fornecedor
						WHERE p.cd_filial  = :il_filial
						  AND p.cd_produto = :ll_produto
						  AND p.nr_lote    = :ls_lote
						  AND l.nr_lote    = :il_lote_conferencia) AS qt_registros_lote
			FROM
				nf_compra_pendente_prd_lote p
			INNER JOIN lote_recebimento_nf n
					ON  n.nr_nf      = p.nr_nf
					AND n.de_especie = p.de_especie
					AND n.de_serie   = p.de_serie
			INNER JOIN lote_recebimento l
					ON l.nr_lote        = n.nr_lote
					AND l.cd_fornecedor = p.cd_fornecedor
			WHERE p.cd_filial  = :il_filial
			  AND p.cd_produto = :ll_produto
			  AND p.nr_lote    = :ls_lote
			  AND p.qt_lote    > 0
			  AND l.nr_lote    = :il_lote_conferencia
			GROUP BY
				  p.cd_fornecedor
				, p.nr_nf
				, p.de_especie
				, p.de_serie
			UNION ALL
			SELECT
				TOP 1 p.cd_fornecedor
					 , p.nr_nf
					 , p.de_especie
					 , p.de_serie
					 , (
						SELECT
							COUNT (*)
						FROM
							item_nf_compra_lote p
						INNER JOIN lote_recebimento_nf n
								ON  n.nr_nf      = p.nr_nf
								AND n.de_especie = p.de_especie
								AND n.de_serie   = p.de_serie
						INNER JOIN lote_recebimento l
								ON  l.nr_lote       = n.nr_lote
								AND l.cd_fornecedor = p.cd_fornecedor
						WHERE p.cd_filial  = :il_filial
						  AND p.cd_produto = :ll_produto
						  AND p.nr_lote    = :ls_lote
						  AND l.nr_lote    = :il_lote_conferencia) AS qt_registros_lote
			FROM
				item_nf_compra_lote p
			INNER JOIN lote_recebimento_nf n
					ON  n.nr_nf      = p.nr_nf
					AND n.de_especie = p.de_especie
					AND n.de_serie   = p.de_serie
			INNER JOIN lote_recebimento l
					ON l.nr_lote        = n.nr_lote
					AND l.cd_fornecedor = p.cd_fornecedor
			WHERE p.cd_filial  = :il_filial
			  AND p.cd_produto = :ll_produto
			  AND p.nr_lote    = :ls_lote
			  AND p.qt_lote    > 0
			  AND l.nr_lote    = :il_lote_conferencia
			GROUP BY
				  p.cd_fornecedor
				, p.nr_nf
				, p.de_especie
				, p.de_serie
			) AS dados_fornecedor
		Using SqlCa;
		
		Choose Case SqlCa.SqlCode 
			Case -1
				as_log = "Erro ao localizar os dados do fornecedor." + SQLCA.SQLErrText
				SQLCA.of_rollback()
				Destroy(lds)
				lb_sucesso = False
				Exit
				
		End Choose
				
		If ll_qtde > 0 Then
			// Se o produto estiver prestes a vencer e n$$HEX1$$e300$$ENDHEX$$o tiver sido liberado pelo RESPONS$$HEX1$$c100$$ENDHEX$$VEL o sistema n$$HEX1$$e300$$ENDHEX$$o
			// ir$$HEX1$$e100$$ENDHEX$$ gravar o movimento no recebimento liberado neste momento.
			// *** O movimento para o receb liberado ser$$HEX1$$e100$$ENDHEX$$ gravado na fun$$HEX2$$e700e300$$ENDHEX$$o que grava as notas.
			If ls_vencido = 'S' and ls_vencido_lib = 'N' Then
				Continue
			End If		
			
			
			// T$$HEX1$$e900$$ENDHEX$$rmino - Enviar movimenta$$HEX2$$e700e300$$ENDHEX$$o para o SAP movimentar do deposito livre utiliza$$HEX2$$e700e300$$ENDHEX$$o para segregado
			// Localiza Matricula do Conferente			
			If Not This.of_localiza_conferente_entrada(ll_Produto,ls_Lote,ld_Validade,&
																	Ref is_Matricula_conferente,Ref as_log,&
																	ll_cx_padrao  ) Then Return False 
						
			//  Caso Conferente VAZIO usa o Padrao:14330
			If IsNull (is_Matricula_conferente) or is_Matricula_conferente = '' Then
				is_Matricula_Entrada = is_Matricula_default
			Else				
				is_Matricula_Entrada = is_Matricula_conferente
			End If 	
			
						
			If luo_ge258_movimentacao.of_insere_movimentacao(	is_endereco_receb_liberado, ls_nulo, ll_produto,&
																			 		ll_cx_padrao,ls_lote,ld_Validade,ll_qtde, "U",&
																			 		il_filial, ls_fornecedor, ll_nota, ls_especie,&
																					ls_serie, is_Matricula_Entrada) Then
				If is_id_licitacao = "S" Then
					Sleep (1) //Sleep para n$$HEX1$$e300$$ENDHEX$$o ficar mesmo hor$$HEX1$$e100$$ENDHEX$$rio de movimenta$$HEX2$$e700e300$$ENDHEX$$o da entrada

					//Se for licita$$HEX2$$e700e300$$ENDHEX$$o movimenta de recebimento liberado para o endere$$HEX1$$e700$$ENDHEX$$o de licita$$HEX2$$e700e300$$ENDHEX$$o
					If Not of_grava_movimentacao_wms_flow_rack(is_endereco_receb_liberado, &
																			 ls_endereco_licitacao, &
																			 ll_produto, &
																			 ll_cx_padrao, &
																			 ls_lote, &
																			 ld_Validade, &
																			 ll_qtde, &
																			 luo_ge258_movimentacao, &
																			 REF as_log) Then
						SQLCA.of_rollback()
		
						Destroy(lds)
						
						lb_sucesso = False
						
						Exit
					End If	
					
					If Not of_inclui_segregado_recebimento(ls_endereco_licitacao,& 
																		ls_fornecedor,& 
																		ll_nota,& 
																		ls_especie,& 
																		ls_serie,&
																		ll_produto,& 
																		ls_lote,& 
																		ld_Validade,& 
																		(ll_qtde*ll_cx_padrao),&
																		REF as_log) Then
						SQLCA.of_rollback()
		
						Destroy(lds)
						
						lb_sucesso = False
						
						Exit																					 
					End If		
				Else
					//Se for flow rack j$$HEX1$$e100$$ENDHEX$$ faz o movimento para o flow
					If ls_flow_rack = "S" Then
						select coalesce(vl_parametro, 'N')
						  into :ls_id_mantem_fracionado_recebimento
						  from wms_parametro 
						 where cd_parametro = 'ID_MANTEM_FRACIONADO_RECEBIMENTO'
						Using SqlCa;

						Choose Case SqlCa.SqlCode 
							Case 100
								as_log	= "N$$HEX1$$e300$$ENDHEX$$o foi localizado o parametro: ID_MANTEM_FRACIONADO_RECEBIMENTO."
								
								SQLCA.of_rollback()
		
								Destroy(lds)
								
								lb_sucesso = False
								
								Exit
							Case -1
								as_log = "Erro ao localizar o par$$HEX1$$e200$$ENDHEX$$metro ID_MANTEM_FRACIONADO_RECEBIMENTO: "+ SqlCa.SQLErrText
								
								SQLCA.of_rollback()
								Destroy(lds)
								lb_sucesso = False
								Exit
						End Choose
						
						if ls_id_mantem_fracionado_recebimento = 'S' and ll_Qt_Rec_Produto_Gel > 0 and not IsNull(ll_Qt_Rec_Produto_Gel) then
							as_log = 'O par$$HEX1$$e200$$ENDHEX$$metro ID_MANTEM_FRACIONADO_RECEBIMENTO est$$HEX1$$e100$$ENDHEX$$ habilitado e isso impede o recebimento de material de geladeira. Ajuste o par$$HEX1$$e200$$ENDHEX$$metro ou ent$$HEX1$$e300$$ENDHEX$$o aguarde o processo terminar.'
							Return False
						end if

						If ls_id_mantem_fracionado_recebimento <> "S" Then //Se o par$$HEX1$$e200$$ENDHEX$$metro estiver como 'S' mant$$HEX1$$e900$$ENDHEX$$m os produtos fracionados no recebimento liberado porque o flow est$$HEX1$$e100$$ENDHEX$$ sendo inventari$$HEX1$$e100$$ENDHEX$$do.
							if of_verifica_lote_controlado(REF ib_Controlado_Endereco_Lote, REF as_log) Then
								If of_localiza_endereco_flow(ll_produto, REF ls_endereco_flow, REF ls_subcategoria, ls_lote, REF as_log) Then
									
									If IsNull(ls_endereco_flow) or trim(ls_endereco_flow) = '' Then
										as_log = 'N$$HEX1$$e300$$ENDHEX$$o localizado o endere$$HEX1$$e700$$ENDHEX$$o do flow do produto ' + String(ll_produto) + ' - Verifique se o produto n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ controlado'
										Return False
									End If
									
									If of_verifica_validade_lote(is_endereco_receb_liberado, ll_produto, ll_cx_padrao, ls_lote, ld_Validade, REF ld_Validade_Cadastrada, REF as_log) Then
										//Se j$$HEX1$$e100$$ENDHEX$$ tem validade cadastrada no flow, utilizda a validade j$$HEX1$$e100$$ENDHEX$$ cadastrada
										If Not IsNull(ld_Validade_Cadastrada) Then
											ld_validade = ld_validade_cadastrada
										End If
										
										If Not of_grava_movimentacao_wms_flow_rack(is_endereco_receb_liberado, &
																								 ls_endereco_flow, &
																								 ll_produto, &
																								 ll_cx_padrao, &
																								 ls_lote, &
																								 ld_validade, &
																								 ll_qtde, &
																								 luo_ge258_movimentacao, &
																								 REF as_log) Then
											SQLCA.of_rollback()
											Destroy(lds)
											lb_sucesso = False
											Exit
										End If
									Else
										SQLCA.of_rollback()
										Destroy(lds)
										lb_sucesso = False
										Exit
									End If
								Else
									SQLCA.of_rollback()
									Destroy(lds)
									lb_sucesso = False
									Exit
								End If
							Else
								SQLCA.of_rollback()
								Destroy(lds)
								lb_sucesso = False
								Exit
							End If
						End If
					End If
				End If
			Else																				
				SQLCA.of_rollback()
				
				as_log	= luo_ge258_movimentacao.is_log_erro
				
				Destroy(lds)
				lb_sucesso = False
				Exit
			End If
		End If
	Next

	Destroy(luo_ge258_movimentacao)
ElseIf ll_linhas_produtos = 0 Then
	lb_sucesso = False
	
	as_log = "N$$HEX1$$e300$$ENDHEX$$o existem produtos para movimentar para o  'Recebimento Liberado'."
Else
	lb_sucesso = False
	
	as_log = "Erro ao localizar os produtos para a movimenta$$HEX2$$e700e300$$ENDHEX$$o para o 'Recebimento Liberado'."
End If

Destroy(lds)

SetPointer(Arrow!)

Return lb_sucesso
end function

public function boolean of_endereco_licitacao (ref string as_endereco_licitacao, ref string as_log);Select vl_parametro
Into :as_Endereco_Licitacao
from wms_parametro
where cd_parametro = 'CD_ENDERECO_SEGREGADO_RECEBIMENTO_LICITA'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If Isnull(as_Endereco_Licitacao) or (Trim(as_Endereco_Licitacao) = "") Then
			as_log = "O valor do par$$HEX1$$e200$$ENDHEX$$metro 'CD_ENDERECO_SEGREGADO_RECEBIMENTO_LICITA' est$$HEX1$$e100$$ENDHEX$$ nulo."
			
			Return False
		End If
	Case 100
		as_log = "N$$HEX1$$e300$$ENDHEX$$o foi localizado o valor do par$$HEX1$$e200$$ENDHEX$$metro 'CD_ENDERECO_SEGREGADO_RECEBIMENTO_LICITA'."
		
		Return False
	Case -1
		as_log = "Erro ao localizar o par$$HEX1$$e200$$ENDHEX$$metro 'CD_ENDERECO_SEGREGADO_RECEBIMENTO_LICITA'."
		
		Return False
End Choose


Return True
end function

public function boolean of_verifica_titulo_acordo (long al_filial, string as_fornecedor, long al_nota, string as_especie, string as_serie, ref string as_aviso, ref string as_nm_fantasia, ref date adt_data, ref decimal ldc_valor, ref long al_pedido, ref string as_email, ref string as_comprador, ref string as_matricula, ref string as_log);String lvs_aviso_titulo


SetNull(lvs_aviso_titulo)

as_aviso = "N"

select Coalesce (pc.id_acordo_titulo, "N"),
		 nc.dh_emissao,
		 f.nm_fantasia,
		 nc.vl_total_nf,
		 pc.nr_pedido,
		 u.de_endereco_email,
		 u.nm_usuario,
		 u.nr_matricula
  Into :lvs_aviso_titulo, 
		 :adt_data,
		 :as_nm_fantasia,
		 :ldc_valor,
		 :al_pedido,
		 :as_email,
		 :as_comprador,
		 :as_matricula
  From nf_compra nc
 Inner Join pedido_central	pc on pc.nr_pedido = nc.nr_pedido_central
 Inner Join fornecedor f on f.cd_fornecedor = nc.cd_fornecedor
  Left Join usuario u on u.nr_matricula = pc.nr_matricula_cadastramento
 Where nc.cd_filial		= :al_filial  
	And nc.cd_fornecedor	= :as_fornecedor
	And nc.nr_nf			= :al_nota
	And nc.de_especie		= :as_especie
	And nc.de_serie		= :as_serie
	And pc.id_situacao	<> 'X'
Using SqlCA;

If SqlCa.SqlCode = -1 Then
	as_log = "Atualiza$$HEX2$$e700e300$$ENDHEX$$o da situa$$HEX2$$e700e300$$ENDHEX$$o do pedido " + SQLCA.SQLErrText 

	Return False
Else
	as_aviso = lvs_aviso_titulo

	If IsNull(as_aviso) or as_aviso = "" Then as_aviso = "N"
End If

Return True
end function

public function boolean of_localiza_email_auxiliar_comprador (string as_comprador, string as_email_auxiliar, ref string as_log);String ls_Mensagem


Select u.de_endereco_email
  Into :as_email_auxiliar
  From comprador c
 Inner join usuario u on c.nr_matricula_auxiliar = u.nr_matricula
 Where c.nr_matricula = :as_comprador  
Using SqlCA;

If SqlCa.SqlCode = -1 Then
	as_log = "Erro ao localizar email do auxiliar do comprador '" + SQLCA.SQLErrText + "'."
	
	SqlCa.of_RollBack();
	
	Return False
End If	

Return True 

end function

public function boolean of_envia_email_acordo_titulo (long al_nota, string as_especie, string as_serie, string as_fornecedor, long al_pedido, date adt_emissao, decimal ldc_vl_nota, string as_nm_fantasia, string as_email, string as_comprador, string as_matricula, ref string as_log);Date 		ldt_Aviso
Long 		ll_Cod_Msg  =  244, ll_Linhas, ll_Linha, ll_Produto
String	ls_Msg, lvs_Produto, lvs_email_auxiliar

s_email 			lst_Email
dc_uo_ds_base 	lds_Recebido


lds_Recebido = Create dc_uo_ds_base

If Not lds_Recebido.of_ChangeDataObject( "dw_ge473_lista_produto_faturado_receb" ) Then
	as_log = "Erro no ChangeDataObject da dw_ge473_lista_produto_faturado_receb"
	Return False
End If

lds_Recebido.of_AppendWhere("exists (select * from item_nf_compra i where i.cd_filial = " + String(il_filial) + " and i.cd_fornecedor = '" + as_Fornecedor + "' and i.nr_nf = " + String(al_Nota) + &
										" and i.de_especie = '" + as_Especie + "' and i.de_serie = '" + as_Serie + "' and i.cd_produto = l.cd_produto)")

ll_Linhas = lds_Recebido.Retrieve(il_Lote_Conferencia)

// Qtde de Produtos
If ll_Linhas >  0  Then 
	ldt_Aviso	= Date(gf_GetServerDate())
	
	ls_Msg =	"<b>Motivo: ACORDO NO TITULO</b><br><br>~n"+& 
				"<u>Informa$$HEX2$$e700f500$$ENDHEX$$es Abaixo:</u><br><br>~n"+&
				"Fornecedor: ("+String(as_Fornecedor, "@@@@-@@@@@")+") "+as_Nm_Fantasia+".<br><br>~n"+&
				"Pedido de Compra: "+String(al_Pedido)+"<br>~n"+&
				"Comprador: "+String(as_Comprador)+"<br>~n"+&
				"Nota: "+String(al_Nota)+"<br>~n"+&
				"Especie: "+as_Especie+"<br>~n"+&
				"S$$HEX1$$e900$$ENDHEX$$rie: "+as_Serie+"<br>~n"+&
				"Emiss$$HEX1$$e300$$ENDHEX$$o: "+String(adt_emissao, "dd/mm/yyyy")+"<br>~n"+&
				"Valor Total Nota: "+String(ldc_Vl_Nota, "###,##0.00")+"<br><br>"
	
	// Cabe$$HEX1$$e700$$ENDHEX$$alho da Tabela	
	ls_Msg += "<table border=1   style='font-family:verdana' >"+&
				 "<tr>"+&
				 "<td colspan=2 align='center'>"+&
				 "<b>Lista de Produtos</b>"+&
				 "</td>"+&
				 "</tr>"						
					
	// Loop dos Produtos
	For ll_Linha = 1 To ll_Linhas
		lvs_Produto =	lds_Recebido.object.de_produto[ll_linha] 
		ll_Produto	=	lds_Recebido.object.cd_produto[ll_linha] 	
		
		// Itens da Tabela
		ls_Msg +="<tr>"
		ls_Msg +="<td>"+String(ll_Produto)+"-"+String(lvs_Produto)+"</td>"			
		ls_Msg +="</tr>"
	Next
	
	// Rodap$$HEX1$$e900$$ENDHEX$$ da Tabela
	ls_Msg+="</table>"
	
	If Not of_localiza_email_auxiliar_comprador(as_matricula, Ref lvs_email_auxiliar, Ref as_log ) Then Return False
	
	// Dados para Email
	lst_Email.ps_mensagem	= ls_Msg
	lst_Email.ps_to[1]		= as_email // Email do Comprador

	If Len(lvs_email_auxiliar) > 1 Then 
		lst_Email.ps_cc[1] = lvs_email_auxiliar // Email do Auxiliar do Comprador	
	End If 
	
	lst_Email.pb_assinatura 	= True
	
	// Envia Email
	If Not gf_ge202_envia_email_padrao(ll_Cod_Msg, lst_Email)	Then
		as_log = "Ocorreu erro ao enviar email da diferen$$HEX1$$e700$$ENDHEX$$a das condi$$HEX2$$e700f500$$ENDHEX$$es de pagamento do pedido e nota fiscal."
		
		Return False
	End If
End If

Return True 
end function

public function boolean of_localiza_endereco_flow (long al_produto, ref string as_endereco, ref string as_subcategoria, string as_nr_lote, ref string as_log);String ls_Geladeira
Long 		ll_Esteira
String 	ls_Controlado
String 	ls_Vigiado
String	ls_esteira

SetNull(ls_Controlado)
SetNull(ls_Vigiado)



/// Localiza a Esteira do Produto
If Not gf_wms_Esteira_Produto(al_Produto, &
										Ref ll_Esteira,&
										Ref ls_Geladeira,&
										Ref ls_Controlado,&
										Ref ls_Vigiado,&
										Ref ls_esteira,&
										Ref as_log) Then
//	MessageBox("Erro", as_log  + "Produto:" + String(al_Produto))
	Return False
End If	


If ib_Controlado_Endereco_Lote  and Not IsNull(ls_Controlado) and ll_Esteira = 3 Then 
	// Controlado Vai diretamente para o Pulm$$HEX1$$e300$$ENDHEX$$o
	Return True 
	//Select top 1 b.cd_endereco, substring(a.cd_subcategoria, 1, 1)
	//Into :as_Endereco, :as_Subcategoria
	//From produto_geral a
	//Left join wms_endereco_produto b on b.cd_produto = a.cd_produto
	//Where a.cd_produto =:al_Produto
	//And 	 b.nr_lote=:as_nr_lote   
	//order by b.nr_prioridade desc
	//Using SqlCa;
Else
	Select top 1 b.cd_endereco, substring(a.cd_subcategoria, 1, 1)
	Into :as_Endereco, :as_Subcategoria
	From produto_geral a
	left join wms_endereco_produto b on b.cd_produto = a.cd_produto
	Where a.cd_produto =:al_Produto
	order by b.nr_prioridade desc
	Using SqlCa;
End If 

Choose Case SqlCa.SqlCode 
	Case 0		
		if IsNull(as_Endereco) or as_Endereco = "" Then
			SqlCa.of_Rollback()
			
			as_log = 'N$$HEX1$$e300$$ENDHEX$$o localizado o endere$$HEX1$$e700$$ENDHEX$$o do flow do produto ' + String(al_produto)

			
			Return False
		end if
		
		Return True
	Case 100
		as_log = "N$$HEX1$$e300$$ENDHEX$$o foi localizado o produto."
		
		SqlCa.of_Rollback()
	Case -1
		as_log = "Erro ao localizar o endere$$HEX1$$e700$$ENDHEX$$o do produto no flow: " + SqlCa.SQLErrText
		
		SqlCa.of_Rollback()
End Choose		

Return False
end function

public function boolean of_finaliza_recebimento (ref string as_log);Long	ll_exists,&
		ll_qt_faturada,&
		ll_qt_lote,&
		ll_Count_Divergencia_Avarias

Select
	sum(qt_faturada)
Into
	:ll_qt_faturada
From
	item_nf_compra
Where cd_filial = :il_filial
And cd_fornecedor = :is_Fornecedor
And nr_nf = :il_Nota
And de_especie = :is_Especie
And de_serie = :is_Serie
Using SQLCA;

If SqlCa.SqlCode = -1 Then
	as_Log	= "Erro ao buscar as informa$$HEX2$$e700f500$$ENDHEX$$es da tabela item_nf_compra." + SqlCa.SqlErrText
	Return False
End If

Select
	sum(qt_lote)
Into 
	:ll_qt_lote
From 
	item_nf_compra_lote
Where cd_filial = :il_filial
And cd_fornecedor = :is_fornecedor
And nr_nf = :il_Nota
And de_especie = :is_especie
And de_serie = :is_Serie
Using SQLCA;

If SqlCa.SqlCode = -1 Then
	as_Log	= "Erro ao buscar as informa$$HEX2$$e700f500$$ENDHEX$$es da tabela item_nf_compra_lote." + SqlCa.SqlErrText
	Return False
End If


If ll_qt_faturada = ll_qt_lote then
	Select top 1 1
	Into :ll_exists
	From dbo.lote_recebimento lr
	Inner join dbo.lote_recebimento_nf lrn
				on lrn.nr_lote = lr.nr_lote
	Where lr.id_entrada_nf_via_sap = 'S' 
		and lr.dh_entrada is not null
		and lrn.nr_lote 	= :il_Lote_Conferencia
		and not exists (select 1 
								from nf_compra nc
							  where nc.cd_filial = :il_Filial
								 and nc.cd_fornecedor = lr.cd_fornecedor
								 and nc.nr_nf = lrn.nr_nf
								 and nc.de_especie = lrn.de_especie
								 and nc.de_serie = lrn.de_serie)
	Using SQLCA;
	
	Choose Case SQLCA.SQLCode
		Case -1
			as_Log	= "Erro ao buscar registro pendente na tabela [lote_recebimento_nf]. Ordem [" + String(il_Lote_Conferencia) + "]. Erro: " + SqlCa.SqlErrText
			Return False
		Case 0
			//N$$HEX1$$e300$$ENDHEX$$o deve ter nenhuma a$$HEX2$$e700e300$$ENDHEX$$o, pois, $$HEX1$$e900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio que o sistema aguarde o recebimento de todas as MIGO/MIRO 
			//que est$$HEX1$$e300$$ENDHEX$$o no recebimento para ai sim movimentar os estoques
		Case 100
			///Grava a entrada da mercadoria no segregado (recebimento liberado/licita$$HEX2$$e700e300$$ENDHEX$$o)
			If Not of_grava_movimentacao_wms_receb_lib(ref as_log) Then Return False 
			
			Update lote_recebimento
				Set dh_confirmacao_nf = getdate()
			Where nr_lote = :il_Lote_Conferencia
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				as_Log	= "Erro ao inserir registro na tabela [LOTE_RECEBIMENTO]. Ordem [" + String(il_Lote_Conferencia) + "]. Erro: " + SqlCa.SqlErrText
				Return False
			End If
	End Choose
Else
	as_Log = "Diverg$$HEX1$$ea00$$ENDHEX$$ncia identificada entre as quantidades qt_faturada e qt_lote nas tabelas item_nf_compra e item_nf_compra_lote."
	Return False
End If

SELECT COUNT(*)
Into    :ll_Count_Divergencia_Avarias
FROM (
    SELECT 
        w.cd_produto,
        w.nr_lote
    FROM ( 
    SELECT 
            cd_produto,
            nr_lote,
            SUM(ISNULL(qt_avariada,0) * ISNULL(qt_caixa_padrao,1)) AS qt_wms
        FROM lote_recebimento_produto_wms
        WHERE nr_lote_recebimento = :il_Lote_Conferencia
        GROUP BY cd_produto, nr_lote
    ) w   
    INNER JOIN (     
SELECT 
    x.cd_produto,
    x.nr_lote,
    SUM(ISNULL(x.qt_avariada,0)) AS qt_nf
FROM (  
    SELECT 
        incl.cd_produto,
        incl.nr_lote,
        incl.qt_avariada
    FROM nf_compra_pendente_prd_lote incl
    INNER JOIN lote_recebimento_nf ln
        ON  ln.nr_nf      = incl.nr_nf
        AND ln.de_especie = incl.de_especie
        AND ln.de_serie   = incl.de_serie
    WHERE 
        ln.nr_lote = :il_Lote_Conferencia
        AND incl.cd_filial     = :il_filial
        AND incl.cd_fornecedor = :is_Fornecedor
    UNION ALL
    SELECT 
        incl.cd_produto,
        incl.nr_lote,
        incl.qt_avariada
    FROM item_nf_compra_lote incl
    INNER JOIN lote_recebimento_nf ln
        ON  ln.nr_nf      = incl.nr_nf
        AND ln.de_especie = incl.de_especie
        AND ln.de_serie   = incl.de_serie
    WHERE 
        ln.nr_lote = :il_Lote_Conferencia
        AND incl.cd_filial     = :il_filial
        AND incl.cd_fornecedor = :is_Fornecedor
) x
GROUP BY 
    x.cd_produto, 
    x.nr_lote  
    ) n
        ON  n.cd_produto = w.cd_produto
        AND n.nr_lote    = w.nr_lote
    WHERE w.qt_wms <> n.qt_nf
) X
Using SQLCA;

If SqlCa.SqlCode = -1 Then
	as_Log = "Erro ao buscar as informa$$HEX2$$e700f500$$ENDHEX$$es." + SqlCa.SqlErrText
	Return False
End If

If ll_Count_Divergencia_Avarias > 0 Then
	as_Log = "Existem Divergencias nas quantidades avariadas entre as tabelas item_nf_compra_lote e lote_recebimento_produto_wms "
	Return False
End if

Return True
end function

public function boolean of_verifica_nota_compra (ref boolean ab_encontrou_nota, ref string as_log);Long	ll_exists


if IsNull(is_de_chave_acesso) or Trim(is_de_chave_acesso) = '' Then
	ab_encontrou_nota = false
	Return True
End if

Select top 1 1
Into :ll_exists
From nf_compra
Where de_chave_acesso = :is_de_chave_acesso
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		ab_encontrou_nota	= true
		Return True
	Case 100
		ab_encontrou_nota = false
		Return True
	Case -1
		as_Log	= "Erro ao localizar registro na tabela 'NF_COMPRA_PENDENTE'. Chave de Acesso [" + this.is_de_chave_acesso +"]. Erro: "+ SqlCa.SqlErrText
		Return False
End Choose 

Return True

end function

public function boolean of_localiza_conferente_entrada (long al_produto, string as_lote, date adt_validade, ref string as_matricula_conferente, ref string as_log, long al_caixa_padrao);SetNull(is_Matricula_conferente)


Select nr_matricula_conferente 
Into :is_Matricula_conferente
From   lote_recebimento_produto_wms a
Where  a.cd_produto  			=:al_produto
And    a.nr_lote  	 				=:as_lote
And    a.dh_validade 				=:adt_validade
And    a.nr_lote_recebimento   =:il_Lote_Conferencia
And 	a.qt_caixa_padrao			=:al_caixa_padrao
Using SqlCA;

Choose Case SqlCa.SqlCode 
	Case 0		
		Return True
	Case 100
		SetNull(is_Matricula_conferente)
		Return True		
	Case -1
		as_log = "Erro ao localizar o conferente do produto: " + SqlCa.SQLErrText
		SqlCa.of_Rollback()
End Choose		

Return False
end function

public function boolean of_grava_log_exportacao_sap (long acd_produto, ref string ps_log);st_log_export_sap st_log


st_log.cd_chave 				= is_chave_movimento_estoque
st_log.id_tipo_nf 			= 'WMM'
st_log.cd_tipo_documento   = 'WMM'
st_log.id_tipo_log 			= 73
st_log.cd_filial  			= il_Filial
st_log.cd_parametro_geral  = 'DH_INICIO_OPERACAO_SAP'
st_log.nr_nf					= il_Nota
st_log.cd_fornecedor			= is_Fornecedor
st_log.de_especie				= is_Especie
st_log.de_serie				= is_Serie
st_log.cd_produto				= acd_produto
st_log.cd_varchar				= 'SEGREG RECEB'

If Not gf_insere_log_exportacao_sap(st_log, ref ps_log) then Return False

Return True
end function

public function boolean of_grava_movimentacao_wms_segregados_gel (ref string as_log);String	ls_Lote,&
		ls_Nulo,&
		ls_Erro,&
		ls_Aceite

Date	ldt_Validade,&
		lvdt_Data_Parametro,&
		ldt_Movimento

Boolean lvb_Sucesso = True

Long	ll_Itens, &
		ll_Item,&
		ll_Produto,&
		ll_Qtde,&
		ll_Nulo,&
		ll_NatOperacao,&
		ll_Qtde_Faturada,&
		ll_Qtde_Divergencia,&
		ll_cx_padrao
				
Decimal	ldc_bc_Icms_St,&
			ldc_Icms_St,&
			ldc_Custo_Unitario,&
			ldc_Custo_Gerencial

SetPointer(HourGlass!)

SetNull(ls_Nulo)
Setnull(ll_Nulo)

dc_uo_ds_base lvds
uo_ge258_movimentacao lds_Movimentacao 

Try
	lvds	= Create dc_uo_ds_base
	lds_Movimentacao = Create uo_ge258_movimentacao
	
	lds_Movimentacao.ivb_Commit = False
	
	If not lds_Movimentacao.of_set_mostra_erro_tela(False) then Return False
	
	If Not lvds.of_ChangeDataObject("ds_ge473_produto_geladeira", False) Then
		as_log = "Erro ao mudar a DS [ds_ge473_produto_geladeira], fun$$HEX2$$e700e300$$ENDHEX$$o [of_grava_movimentacao_wms_segregados_gel]."
		Return False
	End If
	
	ll_Itens = lvds.Retrieve(il_Filial, is_Fornecedor, il_Nota, is_especie, is_Serie)
	
	If ll_Itens = -1 Then
		as_log = "Erro ao localizar os dados da DS [ds_ge473_produto_geladeira], fun$$HEX2$$e700e300$$ENDHEX$$o [of_grava_movimentacao_wms_segregados_gel]."
		Return False
	End If
	
	If ll_Itens > 0 Then
		
		lvdt_Data_Parametro = Date(gf_GetServerDate())
		
		For ll_Item = 1 To ll_Itens
			
			ll_Produto 				= lvds.Object.cd_produto				[ll_Item]
			ll_Qtde 					= lvds.Object.qt_recebida				[ll_Item]
			ll_Qtde_Faturada		= lvds.Object.qt_faturada				[ll_Item]
			ll_Qtde_Divergencia	= lvds.Object.qt_divergencia			[ll_Item]
			ll_NatOperacao			= lvds.Object.cd_natureza_operacao	[ll_Item]
			ldc_bc_Icms_St			= lvds.Object.vl_bc_icms_st				[ll_Item]
			ldc_Icms_St				= lvds.Object.vl_icms_st					[ll_Item]
			ls_Aceite					= lvds.Object.id_aceite					[ll_Item]
			ll_cx_padrao			= lvds.Object.qt_caixa_padrao			[ll_Item]
			
			ls_lote 				= lvds.Object.nr_lote_produto[ll_Item]
			ldt_Validade			= Date(lvds.Object.dh_validade[ll_Item])
			
			ldc_bc_Icms_St		= ldc_bc_Icms_St / ll_Qtde_Faturada
			ldc_Icms_St			= ldc_Icms_St / ll_Qtde_Faturada
			
			ldt_Movimento	= Date(gf_GetServerDate())
			
			//***************Localiza os custos*************************
			Select	 top 1 vl_custo_unitario,
					vl_custo_gerencial
			Into	:ldc_Custo_Unitario,
					:ldc_Custo_Gerencial
			From	movimento_estoque
			Where	cd_filial_movimento	= :il_Filial
				and	cd_fornecedor			= :is_Fornecedor
				and	nr_nf						= :il_Nota
				and	de_especie				= :is_especie
				and	de_serie					= :is_Serie
				and	cd_produto				= :ll_Produto
			Using SqlCa;
			
			Choose Case SqlCa.SqlCode
				Case 0
				Case 100
					as_log = "N$$HEX1$$e300$$ENDHEX$$o foram localizados os custos do produto "+String(ll_Produto)+"."
					Return False
				Case -1
					as_log = "Erro ao localizados os custos do produto "+String(ll_Produto)+": "+SqlCa.SqlErrText
					Return False
			End Choose
			//**********************************************************
			
			If IsNull(ls_Lote) Then
				Select top 1 nr_lote
				Into :ls_Lote
				From nf_compra_pend_prd_lote_xml
				Where cd_filial 		= :il_filial
					and cd_fornecedor	= :is_fornecedor
					and nr_nf			= :il_nota
					and de_especie		= :is_especie
					and de_serie		= :is_serie
					and cd_produto		= :ll_Produto
				Using SqlCa;
				
				Choose Case SqlCa.SqlCode
					Case 0
					Case 100
						ls_Lote 			= 'SEM LOTE'		
					Case -1
						lvb_Sucesso = False
						Exit				
				End Choose
			End If
			
			If IsNull(ldt_Validade) Then
				Select top 1 dh_validade
				Into :ldt_Validade
				From nf_compra_pend_prd_lote_xml
				Where cd_filial 		= :il_filial
					and cd_fornecedor	= :is_fornecedor
					and nr_nf			= :il_nota
					and de_especie		= :is_especie
					and de_serie		= :is_serie
					and cd_produto		= :ll_Produto
				Using SqlCa;
				
				Choose Case SqlCa.SqlCode
					Case 0
					Case 100
						ldt_Validade	= lvdt_Data_Parametro			
					Case -1
						lvb_Sucesso = False
						Exit				
				End Choose
			End If
			
			If Not IsNull(ldt_Validade) Then
				ldt_Validade = Date(String(ldt_Validade, '01/mm/yyyy'))
			End If
				
			If ls_Aceite = 'N' Then
				If Not This.of_inclui_segregado_recebimento(is_Endereco_Segregado_Excursao_Temp, ll_Produto, ls_Lote, ldt_Validade, ((ll_Qtde * ll_cx_padrao) - ll_Qtde_Divergencia), ref as_log) Then Return False
			End If
			
			// In$$HEX1$$ed00$$ENDHEX$$cio - Enviar movimenta$$HEX2$$e700e300$$ENDHEX$$o para o SAP movimentar do deposito livre utiliza$$HEX2$$e700e300$$ENDHEX$$o para segregado (SOMENTE NO SAP)
			If Not This.of_carrega_chave_movimento_estoque(ref as_log) Then Return False
			
			lds_Movimentacao.is_chave_movimento = is_chave_movimento_estoque
			
			If ls_Aceite = 'N' Then
				If Not This.of_grava_log_exportacao_sap(ll_Produto, ref as_log) Then Return False
			End If
			
			// Localiza Matricula do Conferente			
			If Not This.of_localiza_conferente_entrada(ll_Produto, ls_Lote, ldt_Validade, Ref is_Matricula_conferente, Ref as_log, il_CX_Padrao ) Then Return False 
					
			// T$$HEX1$$e900$$ENDHEX$$rmino - Enviar movimenta$$HEX2$$e700e300$$ENDHEX$$o para o SAP movimentar do deposito livre utiliza$$HEX2$$e700e300$$ENDHEX$$o para segregado
			//  Caso Conferente VAZIO usa o Padrao:14330
			If IsNull (is_Matricula_conferente) or is_Matricula_conferente = '' Then
				is_Matricula_Entrada = is_Matricula_default
			Else				
				is_Matricula_Entrada = is_Matricula_conferente
			End If 	
			
			If ls_Aceite = 'S' Then/*era is_Endereco_Segregado, o segregado geladeira nao seria entrada 'E?'*/
				If Not lds_Movimentacao.of_Insere_Movimentacao(is_Endereco_Segregado_Geladeira, ls_Nulo, ll_Produto, il_CX_Padrao, ls_Lote, ldt_Validade, ll_Qtde,&
																				'S', il_Filial, is_Fornecedor, il_Nota, is_Especie, is_Serie,&
																				is_Matricula_Entrada, ll_Nulo,&
																				Round(ldc_bc_Icms_St * ll_Qtde, 2), Round(ldc_Icms_St * ll_Qtde, 2), ldc_Custo_Unitario, ldc_Custo_Gerencial) Then
					as_log = "Erro ao gravar o movimento no WMS [of_grava_movimentacao_wms_segregados_gel]."
					Return False																				 
				End If
			ElseIf ls_Aceite = 'N' Then
				If Not lds_Movimentacao.of_Insere_Movimentacao(is_Endereco_Segregado_Excursao_Temp, ls_Nulo, ll_Produto, il_CX_Padrao, ls_Lote, ldt_Validade, ll_Qtde,&
																				'S', il_Filial, is_Fornecedor, il_Nota, is_Especie, is_Serie,&
																				is_Matricula_Entrada, ll_Nulo,&
																				Round(ldc_bc_Icms_St * ll_Qtde, 2), Round(ldc_Icms_St * ll_Qtde, 2), ldc_Custo_Unitario, ldc_Custo_Gerencial) Then
					as_log = "Erro ao gravar o movimento no WMS [of_grava_movimentacao_wms_segregados_gel]."
					Return False																				 
				End If
			End If
		
		Next
		
	End If

Finally
	If IsValid(lvds) Then Destroy(lvds)
	If IsValid(lds_Movimentacao) Then Destroy(lds_Movimentacao)
End try

Return True
end function

public function boolean of_atualiza_geladeira (long al_produto, long al_natureza_operacao, string as_lote, date adh_validade, long al_qtde, ref string as_log);String ls_MSG

Long ll_Count

SELECT count(cd_produto)
INTO :ll_Count
FROM item_nf_compra_lote   
where  cd_filial 					= :il_filial
	and cd_fornecedor 			= :is_Fornecedor
	and nr_nf 						= :il_Nota
	and de_especie 				= :is_Especie
	and de_serie 					= :is_Serie
	and cd_natureza_operacao 	= :al_natureza_operacao
    and cd_produto 				= :al_Produto
	and nr_lote  					= :as_lote
Using SqlCa;

If SqlCa.SqlCode <> -1 Then
	
	If Not ll_Count > 0 Then
	
		  INSERT INTO item_nf_compra_lote	( cd_filial,   
														  cd_fornecedor,   
														  nr_nf,   
														  de_especie,   
														  de_serie,   
														  cd_natureza_operacao,   
														  cd_produto,   
														  nr_lote,   
														  qt_lote,   
														  dh_validade,   
														  dh_fabricacao,   
														  qt_avariada,   
														  id_vencimento_proximo,   
														  qt_devolvida,   
														  qt_reserva_devolucao,   
														  qt_falta )  
			VALUES (		:il_filial,						//cd_filial,   
								:is_Fornecedor,			//cd_fornecedor,   
								:il_Nota,						//nr_nf,   
								:is_Especie,				//de_especie,   
								:is_Serie,					//de_serie,   
								:al_natureza_operacao, 	//cd_natureza_operacao,   
								:al_Produto,					//cd_produto,   
								:as_lote,						//nr_lote,   
								:al_qtde,						//qt_lote,   
								:adh_validade,				//dh_validade,   
								null, 							//dh_fabricacao,   
								null,							//qt_avariada,   
								'N',							//id_vencimento_proximo,   
								null,							//qt_devolvida,   
								null,							//qt_reserva_devolucao,   
								:al_qtde)						//qt_falta 
			Using SqlCa;
					  
			If Sqlca.SqlCode = -1  Then
				as_log = "Erro no insert do lote na tabela item_nf_compra_lote '" + SQLCA.SQLErrText + "'."
				Return False
			End If 
	End If
Else
	as_log = "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do lote na tabela item_nf_compra_lote '" + SQLCA.SQLErrText + "'."
	Return False
End If

Return True

end function

public function boolean of_get_ordem_transf (ref long al_nr_transferencia, ref string as_nr_matricula_conferente, ref string as_log);select 
	wte.nr_transferencia,
	wte.nr_matricula_conferente
into
	:al_nr_transferencia,
	:as_nr_matricula_conferente
from 
	wms_transferencia_estoque wte
inner join 
	pedido_distribuidora pd
	on wte.nr_pedido_distribuidora = pd.nr_pedido_distribuidora
	and wte.cd_filial_destino = pd.cd_filial
inner join 
	nf_transferencia nt
	on nt.nr_pedido_distribuidora = pd.nr_pedido_distribuidora
	and nt.cd_filial_destino = pd.cd_filial
inner join 
	nf_transferencia_nfe ntn
	on ntn.cd_filial_origem = nt.cd_filial_origem
	and ntn.nr_nf = nt.nr_nf
	and ntn.de_especie = nt.de_especie
	and ntn.de_serie = nt.de_serie
where 
	ntn.de_chave_acesso = :is_de_chave_acesso;
	
Choose Case SQLCA.SQLCode
	Case -1
		as_log	= 'Erro ao buscar a ordem de transfer$$HEX1$$ea00$$ENDHEX$$ncia da nota fiscal com chave de acesso: ' + is_de_chave_acesso + '.~r~rErro: ' + SQLCA.SQLErrText
		Return False
	Case 100
		as_log	= 'N$$HEX1$$e300$$ENDHEX$$o foi encontrado a ordem de transfer$$HEX1$$ea00$$ENDHEX$$ncia da nota fiscal com chave de acesso: ' + is_de_chave_acesso + '.'
		Return False
End Choose

if IsNull(al_nr_transferencia) or al_nr_transferencia <= 0 then
	as_log	= 'Foi encontrada uma ordem de transfer$$HEX1$$ea00$$ENDHEX$$ncia com c$$HEX1$$f300$$ENDHEX$$digo inv$$HEX1$$e100$$ENDHEX$$lido para a nota fiscal com chave de acesso: ' + is_de_chave_acesso + '.'
	Return False
end if

Return True
end function

public function boolean of_confirma_nota_transf_cd (long al_cd_filial_destino, ref string as_log);Boolean lvb_sucesso = TRUE
Datetime ldh_validade
Datetime ldt_Movimento
Long lvl_linha, lvl_linhas, lvl_produto, lvl_qtde, lvl_qt_caixa_padrao, ll_null, ll_Nr_Movimentacao, &
	ll_nr_transferencia
String ls_lote, ls_null, ls_cd_endereco_entrada, ls_nr_matricula_conferente, &
	ls_endereco_receb_transf, ls_endereco_receb_liberado_destino

uo_ge258_movimentacao lo_movimentacao
dc_uo_ds_base lvds_receb_lib


SetNull(ls_null)
SetNull(ll_null)

TRY
	if not of_get_ordem_transf(REF ll_nr_transferencia, REF ls_nr_matricula_conferente, REF as_log) then Return False
	
	If Not of_localiza_endereco_segregado('CD_ENDERECO_RECEBIMENTO_LIBERADO@' + String(al_cd_filial_destino), ref ls_endereco_receb_liberado_destino, ref as_log) Then Return False
	If Not of_localiza_endereco_segregado('CD_ENDERECO_RECEB_TRANSFERENCIA@' + String(al_cd_filial_destino), ref ls_endereco_receb_transf, ref as_log) Then Return False	
	
	ldt_Movimento = gf_GetServerDate()
	
	is_Endereco_Receb_Liberado	= ls_endereco_receb_transf
	
	lo_movimentacao = CREATE uo_ge258_movimentacao
	lo_movimentacao.ivb_Commit = FALSE
	
	lvds_receb_lib = CREATE dc_uo_ds_base
	
	IF NOT lvds_receb_lib.Of_ChangeDataObject("ds_ws186_lista_produto_recebimento_lib") THEN
		RETURN FALSE
	END IF
	
	lvl_linhas = lvds_receb_lib.Retrieve(ll_nr_transferencia)
	
	IF lvl_linhas > 0 THEN
		If not IsValid(w_aguarde) then Open(w_aguarde)
		
		w_aguarde.uo_progress.Of_SetMax(lvl_linhas)
	
		FOR lvl_linha = 1 TO lvl_linhas
			lvl_produto = lvds_receb_lib.Object.cd_produto[lvl_linha]
			ls_lote = lvds_receb_lib.Object.nr_lote[lvl_linha]
			lvl_qtde = lvds_receb_lib.Object.qt_faturada[lvl_linha]
			ldh_validade = lvds_receb_lib.Object.dh_validade[lvl_linha]
			lvl_qt_caixa_padrao = lvds_receb_lib.Object.qt_caixa_padrao[lvl_linha]
	
			SetNull(ls_cd_endereco_entrada)
			
			If Not lo_Movimentacao.of_insere_movimentacao(	ls_cd_endereco_entrada,&
																			ls_endereco_receb_transf,&
																			lvl_produto,&
																			lvl_qt_caixa_padrao,&
																			ls_lote,&
																			Date(ldh_validade),&
																			lvl_qtde,&
																			"7",&
																			ll_null,&
																			ls_null,&
																			ll_null,&
																			ls_null,&
																			ls_null,&
																			ls_nr_matricula_conferente) Then
				as_log = lo_Movimentacao.is_log_erro
				SqlCa.of_Rollback()
				Return FALSE
			End If	
				
			If Not of_nr_movimentacao(lvl_produto, ls_lote, lvl_qt_caixa_padrao, ldh_validade, ls_nr_matricula_conferente, Ref ll_Nr_Movimentacao, Ref as_log) Then
				SqlCa.of_Rollback()
				Return FALSE
			End If

			If Not lo_Movimentacao.of_Atualiza_Movimentacao(	ls_endereco_receb_liberado_destino,&
																				lvl_produto,&
																				ll_Nr_Movimentacao,&
																				lvl_qtde,&
																				ls_lote,&
																				lvl_qt_caixa_padrao,&
																				ldh_validade) Then
				as_log = lo_Movimentacao.is_log_erro
				SqlCa.of_Rollback()
				Return FALSE
			End If
	
			w_aguarde.uo_progress.Of_SetProgress(lvl_linha)
		NEXT
		
		UPDATE
			wms_transferencia_estoque
		SET
			id_situacao = 'R'
		WHERE
			nr_transferencia = :ll_nr_transferencia;
		
		IF SQLCA.SQLCode = -1 THEN
			as_log	= SQLCA.SQLErrText
			SQLCA.of_rollback()
			Return False
		END IF
		
		UPDATE nf_transferencia
			SET nt.dh_recebimento = :ldt_Movimento	
		FROM nf_transferencia nt
		INNER JOIN nf_transferencia_nfe nfe 
		    ON nfe.cd_filial_origem = nt.cd_filial_origem
		    AND nfe.nr_nf = nt.nr_nf
		    AND nfe.de_especie = nt.de_especie
		    AND nfe.de_serie = nt.de_serie
		WHERE 
		    nfe.de_chave_acesso = :is_de_chave_acesso
		Using SQLCA;
		
		IF SQLCA.SQLCode = -1 THEN
			as_log	= SQLCA.SQLErrText
			SQLCA.of_rollback()
			Return False
		END IF		
		
	ELSE
		SQLCA.of_Rollback()
		as_log = "N$$HEX1$$e300$$ENDHEX$$o existe nenhuma nota fiscal de compra pendente cadastrada para a ordem selecionada."
		lvb_sucesso = FALSE
	END IF
CATCH (RunTimeError RTE)
	SQLCA.of_rollback()
FINALLY	
	DESTROY lvds_receb_lib
	DESTROY lo_movimentacao
END TRY

RETURN lvb_sucesso
end function

public function boolean of_verifica_nota_transf_cd (ref boolean ab_transf_cd, ref long al_cd_filial_destino, ref string as_centro_distribuicao_destino, ref string as_log);Long	ll_exists
String	ls_cnpj, ls_id_centro_distribuicao_origem


ab_transf_cd = False

If isnull(is_de_chave_acesso) or is_de_chave_acesso = '' then
	ab_transf_cd = False //Sem erro, mas, n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ nota de transfer$$HEX1$$ea00$$ENDHEX$$ncia.
	Return True
End if

select
	nt.cd_filial_destino
into
	:al_cd_filial_destino
from 
	nf_transferencia_nfe ntn
inner join
	nf_transferencia nt
	on nt.cd_filial_origem = ntn.cd_filial_origem
	and nt.nr_nf = ntn.nr_nf
	and nt.de_especie = ntn.de_especie
	and nt.de_serie = ntn.de_serie
where
	ntn.de_chave_acesso	= :is_de_chave_acesso;

Choose Case SQLCA.SQLCode
	Case -1
		as_log	= 'Erro ao consultar dados da nota fiscal de transfer$$HEX1$$ea00$$ENDHEX$$ncia. Chave de Acesso: ' + is_de_chave_acesso + '~r~rErro: ' + SQLCA.SQLErrText
		Return False
	Case 100
		ab_transf_cd = False //Sem erro, mas, n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ nota de transfer$$HEX1$$ea00$$ENDHEX$$ncia.
		Return True
End Choose

if not gf_get_nfe_part(is_de_chave_acesso, 'CNPJ', REF ls_cnpj, REF as_log) then
	Return False
end if

select
	Coalesce(id_centro_distribuicao, 'N')
into
	:as_centro_distribuicao_destino
from
	filial
where
	cd_filial = :al_cd_filial_destino
	and cd_filial not in (1);
	
Choose Case SQLCA.SQLCode
	Case -1
		as_log	= 'Erro ao consultar dados da filial ' + String(al_cd_filial_destino) + '~r~rErro: ' + SQLCA.SQLErrText
		Return False
End Choose

If IsNull(as_centro_distribuicao_destino) or Trim(as_centro_distribuicao_destino) = '' then as_centro_distribuicao_destino = 'N'

select
	Coalesce(id_centro_distribuicao, 'N')
into
	:ls_id_centro_distribuicao_origem
from
	filial
where
	nr_cgc = :ls_cnpj
	and id_situacao = 'A'
	and cd_filial not in (1);
	
Choose Case SQLCA.SQLCode
	Case -1
		as_log	= 'Erro ao consultar dados da filial de origem. CNPJ: ' + ls_cnpj + '~r~rErro: ' + SQLCA.SQLErrText
		Return False
End Choose

If IsNull(ls_id_centro_distribuicao_origem) or Trim(ls_id_centro_distribuicao_origem) = '' then ls_id_centro_distribuicao_origem = 'N'

if ls_id_centro_distribuicao_origem = 'S' and as_centro_distribuicao_destino = 'S' then
	ab_transf_cd = True
end if

Return True
end function

on uo_ge473_wms_conf_migo_miro.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge473_wms_conf_migo_miro.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

