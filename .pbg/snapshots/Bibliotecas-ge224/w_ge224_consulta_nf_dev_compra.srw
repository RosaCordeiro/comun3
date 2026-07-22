HA$PBExportHeader$w_ge224_consulta_nf_dev_compra.srw
forward
global type w_ge224_consulta_nf_dev_compra from dc_w_2tab_consulta_selecao_lista_2det
end type
type dw_5 from dc_uo_dw_base within tabpage_1
end type
type cb_enviar_xml from picturebutton within tabpage_1
end type
type cb_2 from commandbutton within tabpage_1
end type
type cb_solicita_canc_sap from commandbutton within tabpage_1
end type
type cb_imprimir from commandbutton within tabpage_1
end type
type cb_visualiza_comp_coleta from commandbutton within tabpage_1
end type
type cb_exporta_comp_coleta from commandbutton within tabpage_1
end type
type cb_1 from commandbutton within tabpage_2
end type
end forward

global type w_ge224_consulta_nf_dev_compra from dc_w_2tab_consulta_selecao_lista_2det
string accessiblename = "Consulta Nota Fiscal Devolu$$HEX2$$e700e300$$ENDHEX$$o de Compra (GE224)"
integer width = 3589
integer height = 2188
string title = "GE224 - Consulta Notas Fiscais de Devolu$$HEX2$$e700e300$$ENDHEX$$o de Compra"
boolean resizable = false
end type
global w_ge224_consulta_nf_dev_compra w_ge224_consulta_nf_dev_compra

type variables
uo_fornecedor	ivo_Fornecedor
uo_filial			ivo_Filial
uo_produto		io_Produto

Boolean ib_iniciado_operacao_sap = False
Boolean ib_visualizar_comprovante = false

String is_nota_segregado 

String is_servidor_ftp
String is_usuario_ftp
String is_senha_ftp
String is_Dir
String is_porta_ftp
end variables

forward prototypes
public subroutine wf_verifica_vencimento ()
public function boolean wf_existe_registro_nova_tabela (long al_filial, long al_nota, string as_especie, string as_serie)
public subroutine wf_insere_motivo_devolucao_padrao ()
public function boolean wf_exibe_oculta_botao_solicita_canc_sap ()
public function boolean wf_atualiza_nota_devolucao_compra (long al_filial, long al_nota, string as_especie, string as_serie, string as_operador)
public function boolean wf_busca_datas_nota_devolucao_compra (long al_filial, long al_nota, string as_especie, string as_serie, ref datetime adt_dh_cancelamento, ref datetime adt_dh_solicitacao_canc, ref datetime adt_dh_movimentacao_caixa)
public function boolean wf_busca_nr_documento_sap (long al_nota, string as_especie, string as_serie, ref string as_nr_documento_sap, ref long al_nr_integracao, ref string as_cd_chave_interface, ref string as_log)
public function boolean wf_grava_log_exportacao_sap (long al_filial, long al_nota, string as_especie, string as_serie, string as_cd_fornecedor, string as_cd_chave, string as_nr_documento_sap_estornado, datetime adt_dh_documento, string as_cd_chave_interface)
public function boolean wf_carrega_parametros_ftp (ref string ps_log)
public function boolean wf_exportar_arquivo (ref string ps_log)
public function boolean wf_visualizar_arquivo (ref string ps_log)
end prototypes

public subroutine wf_verifica_vencimento ();String lvs_Especie, &
		 lvs_Serie, &
		 lvs_Fornecedor,&
		 lvs_Vencimento
		 
Long	lvl_Filial, &
		lvl_Nota, &
		lvl_Linha
		
DateTime	lvdt_Vencimento

Try
	
	Open(w_Aguarde)
	w_aguarde.uo_progress.of_setmax(Tab_1.TabPage_1.dw_2.RowCount())
		
	For lvl_Linha = 1 To Tab_1.TabPage_1.dw_2.RowCount()
		
		lvl_Filial			= Tab_1.TabPage_1.dw_2.Object.cd_filial					[lvl_Linha]
		lvs_Fornecedor = Tab_1.TabPage_1.dw_2.Object.cd_fornecedor			[lvl_Linha]
		lvl_Nota 			= Tab_1.TabPage_1.dw_2.Object.nr_nf_compra		 	[lvl_Linha]
		lvs_Especie 		= Tab_1.TabPage_1.dw_2.Object.de_especie_compra	[lvl_Linha]
		lvs_Serie 		= Tab_1.TabPage_1.dw_2.Object.de_serie_compra		[lvl_Linha]
			
		Select Min(dh_vencimento)
		Into :lvdt_Vencimento
		From titulo_pagar
		Where cd_filial 			= :lvl_Filial
		  and cd_fornecedor	= :lvs_Fornecedor
		  and nr_nf				= :lvl_Nota
		  and de_especie		= :lvs_Especie
		  and de_serie			= :lvs_Serie
		Using SqlCa;
		
		Choose Case SqlCa.SqlCode
			Case 0
				lvs_Vencimento = String(Date(lvdt_Vencimento), "dd/mm/yyyy")
			Case 100
				lvs_Vencimento = "00/00/0000"
			Case -1
				SqlCa.of_MsgDBError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do vencimento da nota")
				Exit
		End Choose
		
		Tab_1.TabPage_1.dw_2.Object.dh_vencimento[lvl_Linha] = lvs_Vencimento
		
		w_Aguarde.Title = "Verificando vencimento dos t$$HEX1$$ed00$$ENDHEX$$tulos '" + String(lvl_Linha) + "' at$$HEX1$$e900$$ENDHEX$$ '" + String(Tab_1.TabPage_1.dw_2.RowCount()) + "'"
		w_aguarde.uo_progress.of_setprogress(lvl_Linha)
	Next
	
Finally
	Close(w_Aguarde)
End Try
end subroutine

public function boolean wf_existe_registro_nova_tabela (long al_filial, long al_nota, string as_especie, string as_serie);Long ll_Produtos

Select count(nr_item)
Into :ll_Produtos
From nf_devolucao_compra_produto
Where cd_filial 		= :al_Filial
	and nr_nf			= :al_Nota
	and de_especie	= :as_especie
	and de_serie		= :as_serie
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	Sqlca.of_MsgDbError("Erro ao localizar os produtos na tabela nf_devolucao_compra_produto.")
Else
	If ll_Produtos > 0 Then
		Return True
	End If
End If

Return False

end function

public subroutine wf_insere_motivo_devolucao_padrao ();DataWindowChild lvdwc

Integer 	lvi_Retorno,&
        		lvi_Row

If Tab_1.TabPage_1.dw_1.GetChild("cd_motivo_devolucao", lvdwc) = 1 Then
	lvdwc.InsertRow(1)
	
	lvdwc.SetItem(1, "cd_motivo_devolucao", 0)
	lvdwc.SetItem(1, "de_motivo_devolucao", "NENHUM")
	
	Tab_1.TabPage_1.dw_1.Object.Cd_Motivo_Devolucao [1] = 0
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild do motivo de devolu$$HEX2$$e700e300$$ENDHEX$$o.")
End If
end subroutine

public function boolean wf_exibe_oculta_botao_solicita_canc_sap ();Return (gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = "WS" And ib_iniciado_operacao_sap)
end function

public function boolean wf_atualiza_nota_devolucao_compra (long al_filial, long al_nota, string as_especie, string as_serie, string as_operador);
Update nf_devolucao_compra
Set dh_solicitacao_canc = Getdate(), nr_matricula_solic_canc = :as_operador
Where cd_filial 		= :al_Filial
	and nr_nf			= :al_Nota
	and de_especie	= :as_especie
	and de_serie		= :as_serie
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	Sqlca.of_MsgDbError("Erro ao atualizar a data de cancelamento na tabela nf_devolucao_compra.")
	Return False
End If

Return True

end function

public function boolean wf_busca_datas_nota_devolucao_compra (long al_filial, long al_nota, string as_especie, string as_serie, ref datetime adt_dh_cancelamento, ref datetime adt_dh_solicitacao_canc, ref datetime adt_dh_movimentacao_caixa);SetNull(adt_dh_cancelamento)
SetNull(adt_dh_solicitacao_canc)
SetNull(adt_dh_movimentacao_caixa)

Select dh_cancelamento, dh_solicitacao_canc, dh_movimentacao_caixa
Into :adt_dh_cancelamento, :adt_dh_solicitacao_canc, :adt_dh_movimentacao_caixa
From nf_devolucao_compra
Where cd_filial 		= :al_Filial
	and nr_nf			= :al_Nota
	and de_especie	= :as_especie
	and de_serie		= :as_serie
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	Sqlca.of_MsgDbError("Erro ao buscar as datas de solicita$$HEX2$$e700e300$$ENDHEX$$o e concelamento na tabela nf_devolucao_compra.")
	Return False
End If

Return True

end function

public function boolean wf_busca_nr_documento_sap (long al_nota, string as_especie, string as_serie, ref string as_nr_documento_sap, ref long al_nr_integracao, ref string as_cd_chave_interface, ref string as_log);boolean lb_ret = True
SetNull(as_nr_documento_sap)
SetNull(al_nr_integracao)

Select top 1 nr_documento_sap, 
		 nr_integracao
  Into :as_nr_documento_sap, 
		 :al_nr_integracao
  From wms_int_sap
 Where nr_nf			= :al_Nota
	and de_especie	= :as_especie
	and de_serie	= :as_serie
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case -1
		Sqlca.of_MsgDbError("Erro ao buscar o n$$HEX1$$fa00$$ENDHEX$$mero documento SAP na tabela wms_int_sap.")
		lb_ret = False
	Case 100
		as_log = "Nota fiscal de compra n$$HEX1$$e300$$ENDHEX$$o localizada na tabela de integra$$HEX2$$e700e300$$ENDHEX$$o [wms_int_sap]."
		lb_ret = False
	Case 0
		select cd_chave_interface
		  into :as_cd_chave_interface
		  from log_exportacao_sap
		 where id_tipo_nf = 'WMD'
		 	and cd_chave	= cast(:al_nr_integracao as varchar(15));
			 
		if SqlCa.SqlCode = -1 then
			Sqlca.of_MsgDbError("Erro ao localizar log_exportacao_origem.")
			lb_ret = False
		end if
End Choose

If ( IsNull(as_nr_documento_sap) Or Trim(as_nr_documento_sap)="" ) Then
	as_log = "N$$HEX1$$fa00$$ENDHEX$$mero documento SAP [nr_documento_sap] n$$HEX1$$e300$$ENDHEX$$o informado na tabela de integra$$HEX2$$e700e300$$ENDHEX$$o [wms_int_sap]."
	lb_ret = False
End If

Return lb_ret

end function

public function boolean wf_grava_log_exportacao_sap (long al_filial, long al_nota, string as_especie, string as_serie, string as_cd_fornecedor, string as_cd_chave, string as_nr_documento_sap_estornado, datetime adt_dh_documento, string as_cd_chave_interface);Long ll_nr_atualizacao
String ls_erro

Declare sp_log Procedure for sp_log_exportacao_sap_prox_seq
 @proximo_sequencial_retorno  = :ll_nr_atualizacao OUTPUT,
 @mensagem_retorno = :ls_erro OUTPUT
 USING SQLCA;

 Execute sp_log;

If sqlca.sqlcode = -1 then 
	Sqlca.of_MsgDbError('Erro ao executar a procedure "SP_LOG_EXPORTACAO_SAP_PROX_SEQ" (of_grava_log_exportacao): ')
	return false
end if

Fetch sp_log Into :ll_nr_atualizacao, :ls_erro;

Close sp_log;

if ll_nr_atualizacao = -1 then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Erro ao executar a procedure "sp_log_exportacao_prox_seq" (of_grava_log_exportacao): ' + ls_erro)
	return false
end if

Insert Into log_exportacao_sap (nr_atualizacao,
	cd_filial, 
	nr_nf,
	de_especie,
	de_serie,
	cd_fornecedor,
	id_tipo_nf,
	cd_tipo_documento,
	id_tipo_log,
	dh_exportacao,
	cd_empresa,
	cd_chave,
	id_situacao_docto,
	id_status_integracao,
	cd_ambiente_sap,
	nr_documento_sap_estornado,
	dh_documento,
	cd_chave_interface)
Values (:ll_nr_atualizacao,
	:al_filial, 
	:al_nota,
	:as_especie,
	:as_serie,
	:as_cd_fornecedor,
	'WMX',
	'WMX',
	75,
	getdate(),
	1000,
	:as_cd_chave,
	'C',
	'C',
	'PRD',
	:as_nr_documento_sap_estornado,
	:adt_dh_documento,
	:as_cd_chave_interface)
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	Sqlca.of_MsgDbError("Erro ao gravar na tabela log_exportacao_sap.")
	Return False
End If

Return True

end function

public function boolean wf_carrega_parametros_ftp (ref string ps_log);long ll_pos

select vl_parametro
into :is_servidor_ftp
from parametro_geral 
where cd_parametro = 'DE_SERVIDOR_FTP_COLETA';

if sqlca.sqlcode = -1 then
	ps_log = 'Erro ao consultar a tabela parametro_geral: ' + sqlca.sqlerrtext
	return false
End if

select vl_parametro
into :is_usuario_ftp
from parametro_geral 
where cd_parametro = 'DE_USUARIO_FTP_COLETA';

if sqlca.sqlcode = -1 then
	ps_log = 'Erro ao consultar a tabela parametro_geral: ' + sqlca.sqlerrtext
	return false
End if

select vl_parametro
into :is_senha_ftp
from parametro_geral 
where cd_parametro = 'DE_SENHA_FTP_COLETA';

if sqlca.sqlcode = -1 then
	ps_log = 'Erro ao consultar a tabela parametro_geral: ' + sqlca.sqlerrtext
	return false
End if

if is_servidor_ftp = '' or isnull(is_servidor_ftp) Then
	ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar o servidor de conex$$HEX1$$e300$$ENDHEX$$o com o FTP. N$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel visualizar comprovante de coleta.'
	return false
ENd if

if is_usuario_ftp = '' or isnull(is_usuario_ftp) Then
	ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar o usuario de conex$$HEX1$$e300$$ENDHEX$$o com o FTP. N$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel visualizar comprovante de coleta.'
	return false
ENd if

if is_senha_ftp = '' or isnull(is_senha_ftp) Then
	ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar a senha de conex$$HEX1$$e300$$ENDHEX$$o com o FTP. N$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel visualizar comprovante de coleta.'
	return false
ENd if

ll_pos = pos(is_servidor_ftp,':')

if ll_pos = 0 or isnull(ll_pos) Then
	ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar a porta de conex$$HEX1$$e300$$ENDHEX$$o com o FTP. N$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel visualizar comprovante de coleta.'
	return false
ENd if

is_porta_ftp = mid(is_servidor_ftp, ll_pos + 1)

if is_porta_ftp = '' or isnull(is_porta_ftp) Then
	ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar a porta de conex$$HEX1$$e300$$ENDHEX$$o com o FTP. N$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel visualizar comprovante de coleta.'
	return false
ENd if

is_servidor_ftp = mid(is_servidor_ftp, 1, ll_pos - 1)

ib_visualizar_comprovante = true

is_Dir = ProfileString(gvo_aplicacao.ivs_arquivo_ini, "Diretorio", "Arquivos_Comprovante_Coleta", "")
If Trim(is_Dir) = "" Then
	is_Dir = gvo_aplicacao.ivs_path_arquivos+"Arquivos_Comprovante_Coleta\"
    	SetProfileString(gvo_aplicacao.ivs_arquivo_ini, "Diretorio", "Arquivos_Comprovante_Coleta",is_Dir)
End If
If Not DirectoryExists(is_Dir) then CreateDirectory( is_Dir )

Return true
end function

public function boolean wf_exportar_arquivo (ref string ps_log);Long ll_linha, ll_total_linhas, ll_count=0
Long ll_cd_filial
Long ll_nr_nf
string ls_nm_arquivo
string ls_nome_arquivo_local
string ls_local
string ls_diretorio, ls_diretorio_dir
string ls_mes
string ls_especie, ls_serie

Datetime lvdh_Movimentacao

dc_uo_sftp lvo_ftp

If Tab_1.TabPage_1.dw_2.RowCount() = 0 Then Return True

Tab_1.TabPage_1.dw_2.AcceptText()

ll_total_linhas	= Tab_1.TabPage_1.dw_2.rowcount( )

if ll_total_linhas = 0 then
	messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ registros selecionados para realizar a exporta$$HEX2$$e700e300$$ENDHEX$$o.')
	return true
ENd if

if Tab_1.TabPage_1.dw_2.find("id_imprimir = 'S'",1, ll_total_linhas) = 0 Then
	messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ registros selecionados para realizar a exporta$$HEX2$$e700e300$$ENDHEX$$o.')
	return true
ENd if

if Tab_1.TabPage_1.dw_2.find("id_imprimir = 'S' and id_situacao_coleta = 'C'",1, ll_total_linhas) = 0 Then
	messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ registros selecionados para realizar a exporta$$HEX2$$e700e300$$ENDHEX$$o com a situa$$HEX2$$e700e300$$ENDHEX$$o Coletado.')
	return true
ENd if

if GetFolder('Escolha em qual local os arquivos ser$$HEX1$$e300$$ENDHEX$$o salvos...', ls_diretorio_dir) < 1 then return true

ls_diretorio_dir = ls_diretorio_dir + '\'

Try	

	lvo_ftp	= Create dc_uo_sftp

	Open(w_Aguarde)
	w_Aguarde.Title = "Verificando abertura arquivo..."
	
	w_aguarde.uo_progress.of_setmax(ll_total_linhas)
	
	for ll_linha = 1 to ll_total_linhas
	
		w_aguarde.uo_progress.of_setprogress(ll_linha)
	
		if Tab_1.TabPage_1.dw_2.object.id_imprimir[ll_linha] <> 'S' Then Continue
	
		if Tab_1.TabPage_1.dw_2.object.id_situacao_coleta[ll_linha] <> 'C' Then Continue
		
		ls_nm_arquivo = Tab_1.TabPage_1.dw_2.object.nm_arquivo_comprovante[ll_linha]
		ll_cd_filial = Tab_1.TabPage_1.dw_2.object.cd_filial[ll_linha]
		lvdh_Movimentacao = Tab_1.TabPage_1.dw_2.object.dh_movimentacao_caixa[ll_linha]
		ll_nr_nf = Tab_1.TabPage_1.dw_2.object.nr_nf[ll_linha]
		ls_especie = Tab_1.TabPage_1.dw_2.object.de_especie[ll_linha]
		ls_serie = Tab_1.TabPage_1.dw_2.object.de_serie[ll_linha]
		
		if ls_nm_arquivo = '' or isnull(ls_nm_arquivo) then
			ps_log = 'Filial: ' + string(ll_cd_filial) + ' NFD: ' + string(ll_nr_nf) + '/' + ls_especie + '/' + ls_serie + ' - N$$HEX1$$e300$$ENDHEX$$o foi encontrado comprovante para exportar.'
			return false
		ENd if
		
		ll_count++
		
		//O Mes deve ter sempre dois digitos:
		ls_mes = string(month(date(lvdh_Movimentacao)))
		if len(ls_mes) = 1 then ls_mes = '0' + ls_mes
		
		ls_local = string(ll_cd_filial) + '/' + ls_mes + '-' + string(year(date(lvdh_Movimentacao)))
	
		//O Codigo da filial deve ter sempre quatro digitos:
		if len(string(ll_cd_filial)) = 3 then ls_local = '0' + ls_local
	
		//O Codigo da filial deve ter sempre quatro digitos:
		if len(string(ll_cd_filial)) = 2 then ls_local = '00' + ls_local
	
		//O Codigo da filial deve ter sempre quatro digitos:
		if len(string(ll_cd_filial)) = 1 then ls_local = '000' + ls_local
	
		ls_local = '/DevolucaoCompraColeta/' + ls_local
	
		//ls_diretorio = is_dir + ls_nm_arquivo
		
		ls_diretorio = ls_diretorio_dir + 'NFD_' + string(ll_nr_nf) + '.pdf'
		
		if Not lvo_ftp.of_buscar_arquivo_api( is_servidor_ftp, is_usuario_ftp, is_senha_ftp, long(is_porta_ftp), ls_local, ls_nm_arquivo, ls_diretorio, ref ps_log) then 
			ps_log = 'Filial: ' + string(ll_cd_filial) + ' NFD: ' + string(ll_nr_nf) + '/' + ls_especie + '/' + ls_serie + ' - N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel exportar o comprovante de coleta.'
			return false
		ENd if
		
		If Not FileExists(ls_diretorio) Then
			ps_log = 'Filial: ' + string(ll_cd_filial) + ' NFD: ' + string(ll_nr_nf) + '/' + ls_especie + '/' + ls_serie + ' - N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel exportar o comprovante de coleta: ' + ls_nm_arquivo
			return false
		ENd if
		
	Next
	
	if ll_count = 1 then
		
		If FileExists(ls_diretorio) Then
			gf_Run(ls_diretorio, 1, False)
		Else
			ps_log = 'Filial: ' + string(ll_cd_filial) + ' NFD: ' + string(ll_nr_nf) + '/' + ls_especie + '/' + ls_serie + ' - N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel abrir o comprovante de coleta.'
			return false
		ENd if
		
	ENd if
	
	
Catch (RunTimeError lo_error)
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel abrir o Comprovante. Verifique se os arquivos com extens$$HEX1$$e300$$ENDHEX$$o PDF est$$HEX1$$e300$$ENDHEX$$o configurados para abrirem usando o programa correto (Adobe por exemplo).~n~n' + lo_error.GetMessage( ), StopSign!)
	Return False
	
Finally

		destroy(lvo_ftp)
		
		Close(w_Aguarde)	
	
ENd Try

return true
end function

public function boolean wf_visualizar_arquivo (ref string ps_log);Long ll_linha, ll_count=0
Long ll_cd_filial
Long ll_nr_nf
string ls_nm_arquivo
string ls_nome_arquivo_local
string ls_local
string ls_diretorio, ls_diretorio_dir
string ls_mes
string ls_especie, ls_serie

Datetime lvdh_Movimentacao

dc_uo_sftp lvo_ftp

If Tab_1.TabPage_1.dw_2.Getrow() = 0 Then Return True

Tab_1.TabPage_1.dw_2.AcceptText()

ll_linha	= Tab_1.TabPage_1.dw_2.Getrow( )

if ll_linha = 0 then
	messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ registros selecionados para visualizar.')
	return true
ENd if

ls_diretorio_dir = gvo_aplicacao.ivs_path_arquivos + '\'

Try	

	lvo_ftp	= Create dc_uo_sftp

	Open(w_Aguarde)
	w_Aguarde.Title = "Verificando abertura arquivo..."
	
	w_aguarde.uo_progress.of_setmax(ll_linha)
	
	w_aguarde.uo_progress.of_setprogress(ll_linha)
	
	ls_nm_arquivo = Tab_1.TabPage_1.dw_2.object.nm_arquivo_comprovante[ll_linha]
	ll_cd_filial = Tab_1.TabPage_1.dw_2.object.cd_filial[ll_linha]
	lvdh_Movimentacao = Tab_1.TabPage_1.dw_2.object.dh_movimentacao_caixa[ll_linha]
	ll_nr_nf = Tab_1.TabPage_1.dw_2.object.nr_nf[ll_linha]
	ls_especie = Tab_1.TabPage_1.dw_2.object.de_especie[ll_linha]
	ls_serie = Tab_1.TabPage_1.dw_2.object.de_serie[ll_linha]
	
	if ls_nm_arquivo = '' or isnull(ls_nm_arquivo) then
		ps_log = 'Filial: ' + string(ll_cd_filial) + ' NFD: ' + string(ll_nr_nf) + '/' + ls_especie + '/' + ls_serie + ' - N$$HEX1$$e300$$ENDHEX$$o foi encontrado comprovante para visualizar.'
		return false
	ENd if
		
	//O Mes deve ter sempre dois digitos:
	ls_mes = string(month(date(lvdh_Movimentacao)))
	if len(ls_mes) = 1 then ls_mes = '0' + ls_mes
	
	ls_local = string(ll_cd_filial) + '/' + ls_mes + '-' + string(year(date(lvdh_Movimentacao)))

	//O Codigo da filial deve ter sempre quatro digitos:
	if len(string(ll_cd_filial)) = 3 then ls_local = '0' + ls_local

	//O Codigo da filial deve ter sempre quatro digitos:
	if len(string(ll_cd_filial)) = 2 then ls_local = '00' + ls_local

	//O Codigo da filial deve ter sempre quatro digitos:
	if len(string(ll_cd_filial)) = 1 then ls_local = '000' + ls_local

	ls_local = '/DevolucaoCompraColeta/' + ls_local

	//ls_diretorio = is_dir + ls_nm_arquivo
	
	ls_diretorio = ls_diretorio_dir + 'NFD_VISUALIZACAO.pdf'
	
	if Not lvo_ftp.of_buscar_arquivo_api( is_servidor_ftp, is_usuario_ftp, is_senha_ftp, long(is_porta_ftp), ls_local, ls_nm_arquivo, ls_diretorio, ref ps_log) then 
		ps_log = 'Filial: ' + string(ll_cd_filial) + ' NFD: ' + string(ll_nr_nf) + '/' + ls_especie + '/' + ls_serie + ' - N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel visualizar o comprovante de coleta.'
		return false
	ENd if
	
	If Not FileExists(ls_diretorio) Then
		ps_log = 'Filial: ' + string(ll_cd_filial) + ' NFD: ' + string(ll_nr_nf) + '/' + ls_especie + '/' + ls_serie + ' - N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel visualizar o comprovante de coleta: ' + ls_nm_arquivo
		return false
	ENd if
		
	If FileExists(ls_diretorio) Then
		gf_Run(ls_diretorio, 1, False)
		
	Else
		ps_log = 'Filial: ' + string(ll_cd_filial) + ' NFD: ' + string(ll_nr_nf) + '/' + ls_especie + '/' + ls_serie + ' - N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel abrir o comprovante de coleta.'
		return false
	ENd if
	
Catch (RunTimeError lo_error)
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel abrir o Comprovante. Verifique se os arquivos com extens$$HEX1$$e300$$ENDHEX$$o PDF est$$HEX1$$e300$$ENDHEX$$o configurados para abrirem usando o programa correto (Adobe por exemplo).~n~n' + lo_error.GetMessage( ), StopSign!)
	Return False
	
Finally

		destroy(lvo_ftp)
		
		Close(w_Aguarde)	
	
ENd Try

return true
end function

on w_ge224_consulta_nf_dev_compra.create
int iCurrent
call super::create
end on

on w_ge224_consulta_nf_dev_compra.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;Destroy(ivo_Fornecedor)
Destroy(ivo_Filial)
Destroy(io_Produto)
end event

event ue_postopen;call super::ue_postopen;Long lvl_Filial
String ls_msg, ls_log

ivo_Fornecedor 	= Create uo_fornecedor
ivo_Filial 				= Create uo_filial
io_Produto			= Create uo_produto

lvl_Filial = gvo_Parametro.Of_Filial()

If gvo_Parametro.Of_Filial() <> gvo_parametro.of_filial_matriz() Then	
	tab_1.tabpage_1.dw_1.Object.cd_filial[1]      	= lvl_Filial
	tab_1.tabpage_1.dw_1.Object.de_filial[1]      	= gvo_parametro.nm_fantasia_filial
	tab_1.tabpage_1.dw_1.Object.de_filial.Protect 	= 1	
	ivo_Filial.Nm_Fantasia 								= gvo_parametro.nm_fantasia_filial
End If

wf_Insere_Motivo_Devolucao_Padrao()

gf_ge003_lista_divisao_fornecedor(Tab_1.TabPage_1.dw_1, "",1)

If Not gf_verifica_inicio_operacao_sap('DH_INICIO_OPERACAO_SAP', ref ib_iniciado_operacao_sap, ref ls_msg ) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o",ls_msg,StopSign!)
	Post Event Close(this)
End If

tab_1.tabpage_1.cb_solicita_canc_sap.visible = wf_exibe_oculta_botao_solicita_canc_sap()

if Not this.wf_carrega_parametros_ftp( ref ls_log) then
	messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_log)
ENd if
end event

event ue_preopen;call super::ue_preopen;ivl_Altura_1  	= 1940
ivl_Largura_1 	= 3225
ivl_Altura_2  	= ivl_Altura_1
ivl_Largura_2 	= ivl_Largura_1
end event

event ue_print;//override
Tab_1.TabPage_1.dw_5.Event ue_Print()
end event

event ue_printimmediate;//override
Tab_1.TabPage_1.dw_5.Event ue_PrintImmediate()
end event

event ue_saveas;//override
Tab_1.TabPage_1.dw_2.Event ue_SaveAs()
end event

type dw_visual from dc_w_2tab_consulta_selecao_lista_2det`dw_visual within w_ge224_consulta_nf_dev_compra
end type

type gb_aux_visual from dc_w_2tab_consulta_selecao_lista_2det`gb_aux_visual within w_ge224_consulta_nf_dev_compra
end type

type tab_1 from dc_w_2tab_consulta_selecao_lista_2det`tab_1 within w_ge224_consulta_nf_dev_compra
integer y = 4
integer width = 3566
integer height = 2024
long backcolor = 79741120
end type

event tab_1::selectionchanged;//OverRide

Choose Case NewIndex
	Case 1
		ivm_Menu.mf_SalvarComo(True)
		
		Tab_1.TabPage_1.dw_2.SetFocus()
	Case 2
		ivm_Menu.mf_SalvarComo(False)
		ivm_Menu.ivb_Permite_Imprimir = False	
		
		Tab_1.TabPage_2.dw_3.SetFocus()
End Choose
end event

event tab_1::selectionchanging;call super::selectionchanging;Choose Case NewIndex
	Case 1
		ivm_Menu.ivb_Permite_Imprimir = True
	Case 2
		If Tab_1.TabPage_1.dw_2.GetRow() = 0 Then
			// N$$HEX1$$e300$$ENDHEX$$o permite a troca do folder
			Return 1
		End If
End Choose
end event

type tabpage_1 from dc_w_2tab_consulta_selecao_lista_2det`tabpage_1 within tab_1
integer width = 3529
integer height = 1908
dw_5 dw_5
cb_enviar_xml cb_enviar_xml
cb_2 cb_2
cb_solicita_canc_sap cb_solicita_canc_sap
cb_imprimir cb_imprimir
cb_visualiza_comp_coleta cb_visualiza_comp_coleta
cb_exporta_comp_coleta cb_exporta_comp_coleta
end type

on tabpage_1.create
this.dw_5=create dw_5
this.cb_enviar_xml=create cb_enviar_xml
this.cb_2=create cb_2
this.cb_solicita_canc_sap=create cb_solicita_canc_sap
this.cb_imprimir=create cb_imprimir
this.cb_visualiza_comp_coleta=create cb_visualiza_comp_coleta
this.cb_exporta_comp_coleta=create cb_exporta_comp_coleta
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_5
this.Control[iCurrent+2]=this.cb_enviar_xml
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.cb_solicita_canc_sap
this.Control[iCurrent+5]=this.cb_imprimir
this.Control[iCurrent+6]=this.cb_visualiza_comp_coleta
this.Control[iCurrent+7]=this.cb_exporta_comp_coleta
end on

on tabpage_1.destroy
call super::destroy
destroy(this.dw_5)
destroy(this.cb_enviar_xml)
destroy(this.cb_2)
destroy(this.cb_solicita_canc_sap)
destroy(this.cb_imprimir)
destroy(this.cb_visualiza_comp_coleta)
destroy(this.cb_exporta_comp_coleta)
end on

type gb_2 from dc_w_2tab_consulta_selecao_lista_2det`gb_2 within tabpage_1
integer x = 18
integer y = 592
integer width = 3488
integer height = 1184
long backcolor = 79741120
end type

type gb_1 from dc_w_2tab_consulta_selecao_lista_2det`gb_1 within tabpage_1
integer x = 18
integer width = 3374
integer height = 576
long backcolor = 79741120
end type

type dw_1 from dc_w_2tab_consulta_selecao_lista_2det`dw_1 within tabpage_1
integer x = 37
integer width = 3323
integer height = 484
string dataobject = "dw_ge224_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;String lvs_Nulo

Long lvl_Nulo

Parent.dw_2.Event ue_Reset()

cb_2.Enabled = False

Choose Case dwo.Name
		
	Case 'id_situacao_coleta'	
		
		if data = 'C' Then
			cb_visualiza_comp_coleta.enabled = True
			cb_exporta_comp_coleta.enabled = True
		Else
			cb_visualiza_comp_coleta.enabled = False
			cb_exporta_comp_coleta.enabled = False
		ENd if
		
	Case "nm_razao_social"
		If IsNull(Data) or Trim(Data) = "" Then
			SetNull(lvs_Nulo)
			This.Object.Cd_Fornecedor[1] = lvs_Nulo
			
			SetNull(ivo_Fornecedor.Cd_Fornecedor)
			SetNull(ivo_Fornecedor.Nm_Razao_Social)			
		Else			
			If Data <> ivo_Fornecedor.Nm_Razao_Social Then
				Return 1
			End If
		End If
		
		gf_ge003_lista_divisao_fornecedor(dw_1, ivo_Fornecedor.Cd_Fornecedor, 1)
		
	Case "de_filial"
	  If IsNull(Data) or Trim(Data) <> "" Then
			SetNull(lvl_Nulo)
			This.Object.Cd_Filial[1] = lvl_Nulo
		
			SetNull(ivo_Filial.Cd_Filial)
			SetNull(ivo_Filial.Nm_Fantasia)
	  Else
		  If Data <> ivo_Filial.nm_Fantasia Then
			  Return 1
		  End If
	  End If
	  
	Case "de_produto"
		If Not IsNull(Data) And Trim(Data) <> "" Then
			If Data <> io_Produto.ivs_Descricao_Apresentacao_Venda Then
				Return 1
			End If
		Else
			io_Produto.of_Inicializa()
			
			This.Object.Cd_Produto	[1] = io_Produto.Cd_Produto
			This.Object.De_Produto	[1] = io_Produto.ivs_Descricao_Apresentacao_Venda
		End If

	Case "id_nota_segregado"
		is_nota_segregado = Data
		
		If is_nota_segregado = 'R' Then
			tab_1.tabpage_1.dw_2.of_ChangeDataObject('dw_ge224_lista_recebimento')
			ivb_selecao_linhas = true
		Else
			tab_1.tabpage_1.dw_2.of_ChangeDataObject('dw_ge224_lista')
			ivb_selecao_linhas = true
		End if
End Choose
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Fornecedor) Then
	This.Object.Nm_Razao_Social[1] = ivo_Fornecedor.Nm_Razao_Social
End If
end event

event dw_1::ue_addrow;call super::ue_addrow;This.Object.Dt_Inicio[1] = Today()
This.Object.Dt_Final[1]  = Today()

Return AncestorReturnValue
end event

event dw_1::ue_key;call super::ue_key;String	lvs_Coluna, &
       	lvs_Fornecedor, &
		lvs_Filial

If Key = KeyEnter! Then
	lvs_Coluna = This.GetColumnName()
	
	If lvs_Coluna = "nm_razao_social" Then
		lvs_Fornecedor = This.GetText()
		
		ivo_Fornecedor.of_Localiza_Fornecedor(lvs_Fornecedor)
		
		If ivo_Fornecedor.Localizado Then
			This.Object.Cd_Fornecedor		[1]	 = ivo_Fornecedor.Cd_Fornecedor
			This.Object.Nm_Razao_Social	[1] = ivo_Fornecedor.Nm_Razao_Social
			
			If Not gf_ge003_lista_divisao_fornecedor(dw_1, ivo_Fornecedor.Cd_Fornecedor, 1) Then
				Return
			End If	
		End If
	End If
	
	If lvs_Coluna = "de_filial" Then
		lvs_Filial = This.GetText()

		ivo_filial.of_localiza_filial(lvs_filial)

		If ivo_filial.localizada Then
			This.Object.cd_filial	[1] = ivo_filial.cd_filial 
			This.Object.de_filial	[1] = ivo_filial.nm_fantasia
		End If	
	End If

	If lvs_Coluna = "de_produto" Then
		io_Produto.of_Localiza_Produto(This.GetText())
		
		If io_Produto.Localizado Then
			This.Object.Cd_Produto	[1] = io_Produto.Cd_Produto
			This.Object.De_Produto	[1] = io_Produto.ivs_Descricao_Apresentacao_Venda
		End If
	End If
End If
end event

event dw_1::editchanged;call super::editchanged;Parent.dw_2.Event ue_Reset()

cb_2.Enabled = False
end event

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)
end event

type dw_2 from dc_w_2tab_consulta_selecao_lista_2det`dw_2 within tabpage_1
integer x = 41
integer y = 636
integer width = 3456
integer height = 1116
string dataobject = "dw_ge224_lista"
boolean hscrollbar = true
boolean ivb_selecao_linhas = true
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;Date	lvdt_Inicio, &
		lvdt_Final
		
Long 	lvl_NF	, &
		lvl_Filial, &
		ll_Cd_Motivo_Dev, &
		ll_Divissao_Fornecedor, &
		ll_Produto, &
		ll_nr_agrupamento_dev

String	lvs_Fornecedor, &
		lvs_Especie, &
		lvs_Serie	, &
		lvs_NotaSegregado, &
		lvs_ChaveAcesso, &
		ls_Parametro, &
		ls_id_sit_coleta
		
Parent.dw_1.AcceptText()

lvl_Filial						= Parent.dw_1.Object.Cd_Filial						[1]
lvl_NF							= Parent.dw_1.Object.Nr_NF						[1]
lvs_Especie					= Trim(Parent.dw_1.Object.De_Especie			[1])
lvs_Serie						= Trim(Parent.dw_1.Object.De_Serie				[1])
lvs_NotaSegregado		= Parent.dw_1.Object.id_nota_segregado		[1]
lvs_Fornecedor				= Trim(Parent.dw_1.Object.Cd_Fornecedor		[1])
lvdt_Inicio					= Parent.dw_1.Object.Dt_Inicio						[1]
lvdt_Final					= Parent.dw_1.Object.Dt_Final						[1]
ll_Cd_Motivo_Dev			= Parent.dw_1.Object.Cd_Motivo_Devolucao	[1]
ll_Divissao_Fornecedor	= Parent.dw_1.Object.nr_divisao_fornecedor	[1]
ll_Produto					= Parent.dw_1.Object.Cd_Produto					[1]
ll_nr_agrupamento_dev	= Parent.dw_1.Object.nr_agrupamento_dev	[1]
lvs_ChaveAcesso			= Trim(Parent.dw_1.Object.de_chave			[1])
ls_id_sit_coleta 			= Parent.dw_1.Object.id_situacao_coleta	[1]

If IsNull(lvdt_Inicio) Or IsNull(lvdt_Final) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deve ser informado o per$$HEX1$$ed00$$ENDHEX$$odo para consulta.")
	dw_1.Event ue_Pos(1, "dt_inicio")
	Return -1
End If

If lvdt_Inicio > lvdt_Final Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a data de t$$HEX1$$e900$$ENDHEX$$rmino.")
	dw_1.Event ue_Pos(1, "dt_inicio")
	Return -1
End If

If Not IsNull(lvs_ChaveAcesso) And Trim(lvs_ChaveAcesso) <> "" Then
	If Not gf_valida_chave_nfe( lvs_ChaveAcesso ) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Chave de acesso inv$$HEX1$$e100$$ENDHEX$$lida.")
		dw_1.Event ue_Pos(1, "de_chave")
		Return -1	
	End If
End If

If Not IsNull(lvs_ChaveAcesso) and len( lvs_ChaveAcesso) > 0 Then
	This.of_AppendWhere("e.de_chave_acesso = '" + String(lvs_ChaveAcesso+ "'"), 1) 
	This.of_AppendWhere("e.de_chave_acesso = '" + String(lvs_ChaveAcesso+"'"), 2) 
End If

If Not IsNull(lvs_Fornecedor) and lvs_Fornecedor <> "" Then
	This.of_AppendWhere("n.cd_fornecedor = '" + lvs_Fornecedor + "'", 1)
	This.of_AppendWhere("n.cd_fornecedor = '" + lvs_Fornecedor + "'", 2)
End If

If Not IsNull(lvl_Filial) and lvl_Filial > 0 Then
	This.of_AppendWhere("n.cd_filial = " + String(lvl_Filial), 1)
	This.of_AppendWhere("n.cd_filial = " + String(lvl_Filial), 2)
End If

If Not IsNull(lvl_NF) and lvl_NF > 0 Then
	This.of_AppendWhere("n.nr_nf = " + String(lvl_NF), 1)
	This.of_AppendWhere("n.nr_nf = " + String(lvl_NF), 2)
End If

If Not IsNull(lvs_Especie) and lvs_Especie <> "" Then
	This.of_AppendWhere("n.de_especie = '" + lvs_Especie + "'", 1)
	This.of_AppendWhere("n.de_especie = '" + lvs_Especie + "'", 2)
End If

If Not IsNull(lvs_Serie) and lvs_Serie <> "" Then
	This.of_AppendWhere("n.de_serie = '" + lvs_Serie + "'", 1)
	This.of_AppendWhere("n.de_serie = '" + lvs_Serie + "'", 2)
End If

If Not IsNull(lvdt_Inicio) Then
	This.of_AppendWhere("n.dh_movimentacao_caixa>='"+String(lvdt_Inicio,'YYYY/MM/DD' )+"'", 1)
	This.of_AppendWhere("n.dh_movimentacao_caixa>='"+String(lvdt_Inicio,'YYYY/MM/DD' )+"'", 2)
End If

If Not IsNull(lvdt_Final) Then
	This.of_AppendWhere("n.dh_movimentacao_caixa<='"+String(lvdt_Final,'YYYY/MM/DD' )+"'", 1)
	This.of_AppendWhere("n.dh_movimentacao_caixa<='"+String(lvdt_Final,'YYYY/MM/DD' )+"'", 2)
End If

If ll_Cd_Motivo_Dev > 0 Then
	This.of_AppendWhere("n.cd_motivo_devolucao = " + String(ll_Cd_Motivo_Dev), 1)
	This.of_AppendWhere("n.cd_motivo_devolucao = " + String(ll_Cd_Motivo_Dev), 2)
End If

If Not IsNull(ll_Produto ) And ll_Produto > 0 Then
	This.of_AppendWhere("i.cd_produto = " + String(ll_Produto), 1)
	This.of_AppendWhere("i.cd_produto = " + String(ll_Produto), 2)
End If

// Para Trazer notas de devolu$$HEX2$$e700e300$$ENDHEX$$o : Segregado ou Recebimento
Choose Case lvs_NotaSegregado
	Case "S"
		This.of_AppendWhere("n.nr_agrupamento_dev_compra is not null ", 1)
		This.of_AppendWhere("n.nr_agrupamento_dev_compra is not null ", 2) /*n$$HEX1$$e300$$ENDHEX$$o tinha, estava retornando errado*/
	Case "R"
		This.of_AppendWhere("n.nr_agrupamento_dev_compra is null ", 1) /*n$$HEX1$$e300$$ENDHEX$$o tinha, estava retornando errado*/
		This.of_AppendWhere("n.nr_agrupamento_dev_compra is null ", 2)
End Choose	

If Not IsNull(ll_nr_agrupamento_dev) or ll_nr_agrupamento_dev > 0 Then
	This.of_AppendWhere("n.nr_agrupamento_dev_compra = " + String(ll_nr_agrupamento_dev), 1)
	This.of_AppendWhere("n.nr_agrupamento_dev_compra = " + String(ll_nr_agrupamento_dev), 2)
End If

if ls_id_sit_coleta <> 'T' Then
	
	if ls_id_sit_coleta = 'P' Then
		
		This.of_AppendWhere("(nc.nr_nf is null or (nc.id_situacao = '" + ls_id_sit_coleta + "'))", 1)
		
		This.of_AppendWhere("(nc.nr_nf is null or (nc.id_situacao = '" + ls_id_sit_coleta + "'))", 2)
		
	Else
	
		This.of_AppendWhere("nc.id_situacao = '" + ls_id_sit_coleta + "'", 1)
		//This.of_AppendWhere("nc.cd_filial <> 534", 1)
		
		This.of_AppendWhere("nc.id_situacao = '" + ls_id_sit_coleta + "'", 2)
		//This.of_AppendWhere("nc.cd_filial <> 534", 2)
		
	ENd if
	
End if

//if ls_id_sit_coleta = 'C' Then
//	cb_visualiza_comp_coleta.enabled = True
//else
//	cb_visualiza_comp_coleta.enabled = False
//End if

//Divis$$HEX1$$e300$$ENDHEX$$o Fornecedor
If Not IsNull(ll_Divissao_Fornecedor) And ll_Divissao_Fornecedor > 0 Then
	This.Of_appendwhere("	exists (select * from nf_devolucao_compra a1 "+&
								"	inner join item_nf_devolucao_compra b1 on b1.cd_filial = a1.cd_filial "+&
								"														and b1.nr_nf  = a1.nr_nf "+&
								"														and b1.de_especie = a1.de_especie "+&
								"														and b1.de_serie = a1.de_serie "+&
								"	inner join fornecedor_divisao_produto c1 on c1.cd_produto = b1.cd_produto "+&
								"															and c1.cd_fornecedor = a1.cd_fornecedor "+&
								"	where a1.cd_filial = n.cd_filial "+&
								"	and a1.nr_nf  = n.nr_nf "+&
								"	and a1.de_especie = n.de_especie "+&
								"	and a1.de_serie = n.de_serie "+&
								"	and c1.cd_fornecedor = n.cd_fornecedor "+&
								"	and c1.nr_divisao = "+String(ll_Divissao_Fornecedor)+")", 1)
								
	This.Of_appendwhere("	exists (select * from nf_devolucao_compra a1 "+&
								"	inner join item_nf_devolucao_compra b1 on b1.cd_filial = a1.cd_filial "+&
								"														and b1.nr_nf  = a1.nr_nf "+&
								"														and b1.de_especie = a1.de_especie "+&
								"														and b1.de_serie = a1.de_serie "+&
								"	inner join fornecedor_divisao_produto c1 on c1.cd_produto = b1.cd_produto "+&
								"															and c1.cd_fornecedor = a1.cd_fornecedor "+&
								"	where a1.cd_filial = n.cd_filial "+&
								"	and a1.nr_nf  = n.nr_nf "+&
								"	and a1.de_especie = n.de_especie "+&
								"	and a1.de_serie = n.de_serie "+&
								"	and c1.cd_fornecedor = n.cd_fornecedor "+&
								"	and c1.nr_divisao = "+String(ll_Divissao_Fornecedor)+")", 3)
End If

If is_nota_segregado = 'R' Then
	Select vl_parametro 
	Into :ls_Parametro
	From wms_parametro
	Where cd_parametro = 'ID_TEMPO_PROTOCOLO_NFD'
	Using SqlCa;
	
	Choose Case Sqlca.SqlCode
		Case -1
			Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Erro ao carregar parametro ID_TEMPO_PROTOCOLO_NFD. ~r'+ sqlca.sqlerrtext )
			Return -1
	End Choose
	
	Return retrieve(long(ls_Parametro))
Else
	Return AncestorReturnValue
End If
end event

event dw_2::constructor;call super::constructor;//SORT E FILTER DA CLASSE NOVA 
//CONSTRUCTOR DA DW_2

String lvs_Coluna[], &
       lvs_Nome[]
		 
lvs_Coluna = {"cd_filial", "de_filial","cd_fornecedor","nm_razao_social","dt_inicio",&
					"dt_final","nr_nf", "de_especie", "de_serie","dh_movimentacao_caixa"}

lvs_Nome = {"C$$HEX1$$f300$$ENDHEX$$digo Filial","Filial","C$$HEX1$$f300$$ENDHEX$$digo Fornecedor","Fornecedor","In$$HEX1$$ed00$$ENDHEX$$cio","T$$HEX1$$e900$$ENDHEX$$rmino", &
				"Nota", "Esp$$HEX1$$e900$$ENDHEX$$cie","S$$HEX1$$e900$$ENDHEX$$rie","Data Movimenta$$HEX2$$e700e300$$ENDHEX$$o"}

This.of_SetSort(lvs_Coluna, lvs_Nome)
This.of_SetFilter(lvs_Coluna, lvs_Nome)		

//This.of_SetRowSelection("", "if(isnull(dh_cancelamento), rgb(0,0,0), rgb(255,0,0))")
This.of_SetRowSelection( "if( not isnull( dh_cancelamento ), rgb(255, 0, 0), " + This.ivs_Cor_Linha_Padrao + ")", "", False )

This.ivb_Ordena_Colunas = True
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;String lvs_Somente_Forn_Protocolo, lvs_Filtro

If pl_linhas > 0 Then
	wf_verifica_vencimento()

	cb_2.Enabled = True
	
	If is_nota_segregado = 'R' Then
		lvs_Somente_Forn_Protocolo = Parent.dw_1.Object.id_filtro_sem_protocolo[1]
		
		If lvs_Somente_Forn_Protocolo = 'S' Then
			lvs_Filtro = "id_protocolo_obrigatorio = 'S' and isnull(id_protocolo_fornecedor) "
			dw_2.SetFilter(lvs_Filtro)
			dw_2.Filter()
			dw_2.SetFilter('')
		End If
		
	End If
	
End If

This.ivo_Controle_Menu.Of_SalvarComo(pl_linhas > 0 )
This.ivo_Controle_Menu.Of_Classificar(pl_linhas > 0 )
This.ivo_Controle_Menu.Of_Filtrar(pl_linhas > 0 )
cb_enviar_xml.Enabled = (pl_linhas > 0 )

This.of_SetRowSelection( "if( not isnull( dh_cancelamento ), rgb(255, 0, 0), " + This.ivs_Cor_Linha_Padrao + ")", "", False )

Return AncestorReturnValue
end event

event dw_2::ue_saveas;call super::ue_saveas;This.ivm_Menu.mf_SalvarComo(True)
end event

event dw_2::ue_reset;call super::ue_reset;This.ivo_Controle_Menu.Of_SalvarComo(False)
This.ivo_Controle_Menu.Of_Classificar(False)
This.ivo_Controle_Menu.Of_Filtrar(False)
cb_enviar_xml.Enabled = (False )
end event

event dw_2::buttonclicked;call super::buttonclicked;String lvs_Matricula
	
If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("GE224_PROTOCOLO_NF_DEV_COMPRA", Ref lvs_Matricula) Then 
	Return -1
End If

If row > 0 and is_nota_segregado= 'R' Then
	
	st_ge224_parametros_protocolo lst_Parametro

	lst_Parametro.cd_fornecedor	= this.object.cd_fornecedor	[row]
	lst_Parametro.nm_razao_social= this.object.nm_razao_social	[row]
	lst_Parametro.nr_nf				= this.object.nr_nf				[row]
	lst_Parametro.de_serie 			= this.object.de_serie			[row]
	lst_Parametro.de_especie		= this.object.de_especie		[row]
	lst_Parametro.de_motivo			= this.object.de_motivo_devolucao[row]
	
	openwithparm(w_ge224_protocolo_nf_dev_compra, lst_Parametro)
	
	if trim(Message.StringParm) = 'ok' then
		this.event ue_preretrieve( )
	end if
	
End if
end event

event dw_2::doubleclicked;call super::doubleclicked;string ls_marcar
long ll_for

if dwo.name = 'p_marcar_todos' Then
	
	if this.find('id_imprimir = "N"',1, this.rowcount()) > 0 then
		ls_marcar = 'S'
	Else
		ls_marcar = 'N'
	End if
	
	for ll_for = 1 to this.rowcount( )
		this.setitem(ll_for, 'id_imprimir', ls_marcar)
	Next

End if
end event

type tabpage_2 from dc_w_2tab_consulta_selecao_lista_2det`tabpage_2 within tab_1
integer width = 3529
integer height = 1908
cb_1 cb_1
end type

on tabpage_2.create
this.cb_1=create cb_1
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
end on

on tabpage_2.destroy
call super::destroy
destroy(this.cb_1)
end on

type gb_4 from dc_w_2tab_consulta_selecao_lista_2det`gb_4 within tabpage_2
integer x = 37
integer y = 872
integer width = 3113
integer height = 892
string text = "Itens"
end type

type gb_3 from dc_w_2tab_consulta_selecao_lista_2det`gb_3 within tabpage_2
integer x = 37
integer y = 16
integer width = 3113
integer height = 856
long backcolor = 79741120
end type

type dw_3 from dc_w_2tab_consulta_selecao_lista_2det`dw_3 within tabpage_2
integer x = 55
integer y = 72
integer width = 3077
integer height = 788
string dataobject = "dw_ge224_det_consulta_nf_dev_compra"
end type

event dw_3::ue_recuperar;// OverRide

Integer lvi_Linha_Ativa, &
        lvi_Linhas

Long lvl_Cd_Filial, &
	  lvl_Nr_NF
	  
String lvs_Cd_Fornecedor, &
       lvs_De_Especie, &
       lvs_De_Serie

lvi_Linha_Ativa = Tab_1.TabPage_1.dw_2.GetRow()

lvl_Cd_Filial				= Tab_1.TabPage_1.dw_2.Object.Cd_Filial			[lvi_Linha_Ativa]
lvs_Cd_Fornecedor	= Tab_1.TabPage_1.dw_2.Object.Cd_Fornecedor	[lvi_Linha_Ativa]
lvl_Nr_NF				= Tab_1.TabPage_1.dw_2.Object.Nr_NF				[lvi_Linha_Ativa]
lvs_De_Especie			= Tab_1.TabPage_1.dw_2.Object.De_Especie		[lvi_Linha_Ativa]
lvs_De_Serie			= Tab_1.TabPage_1.dw_2.Object.De_Serie			[lvi_Linha_Ativa]

lvi_Linhas = This.Retrieve(lvl_Cd_Filial, lvs_Cd_Fornecedor, lvl_Nr_NF, lvs_De_Especie, lvs_De_Serie)

Return lvi_Linhas
end event

type dw_4 from dc_w_2tab_consulta_selecao_lista_2det`dw_4 within tabpage_2
integer y = 936
integer width = 3049
integer height = 804
string dataobject = "dw_ge224_det_item_nf_dev_compra"
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event dw_4::ue_recuperar;// OverRide

Integer lvi_Linha_Ativa, &
        lvi_Linhas

Long lvl_Cd_Filial, &
	  	lvl_Nr_NF
	  
String	lvs_De_Especie, &
       		lvs_De_Serie,&
		 	ls_DW

lvi_Linha_Ativa = Tab_1.TabPage_1.dw_2.GetRow()

lvl_Cd_Filial     	= Tab_1.TabPage_1.dw_2.Object.Cd_Filial		[lvi_Linha_Ativa]
lvl_Nr_NF		= Tab_1.TabPage_1.dw_2.Object.Nr_NF			[lvi_Linha_Ativa]
lvs_De_Especie	= Tab_1.TabPage_1.dw_2.Object.De_Especie	[lvi_Linha_Ativa]
lvs_De_Serie	= Tab_1.TabPage_1.dw_2.Object.De_Serie		[lvi_Linha_Ativa]

ls_DW = "dw_ge224_det_item_nf_dev_compra"

If lvl_CD_Filial  = 534 Then
	If wf_existe_registro_nova_tabela(lvl_Cd_Filial, lvl_Nr_NF, lvs_De_Especie, lvs_De_Serie) Then
		ls_DW = "dw_ge224_det_nf_dev_compra_produto"
	End If	
End If

If Not This.of_ChangeDataObject(ls_DW) Then	Return -1

This.of_SetRowSelection()

lvi_Linhas = This.Retrieve(lvl_Cd_Filial, lvl_Nr_NF, lvs_De_Especie, lvs_De_Serie)

Return lvi_Linhas
end event

type dw_5 from dc_uo_dw_base within tabpage_1
integer x = 2825
integer y = 880
integer width = 439
integer height = 208
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge224_relatorio"
boolean border = true
borderstyle borderstyle = styleraised!
end type

event ue_recuperar;//OVerRide

Long lvl_Total, &
     lvl_Linhas_Detalhe

Date lvdth_Inicio, &
     lvdth_Termino
	  
lvdth_Inicio		= dw_1.Object.dt_inicio	[1]
lvdth_Termino	= dw_1.Object.dt_final	[1]

Return This.Retrieve(lvdth_Inicio,lvdth_Termino)
end event

event ue_preretrieve;call super::ue_preretrieve;Long lvl_Filial
Long ll_Motivo_Devolucao

String lvs_Fornecedor

dw_1.AcceptText()

lvl_Filial					= dw_1.Object.Cd_Filial					[1]
lvs_Fornecedor			= dw_1.Object.Cd_Fornecedor			[1]
ll_Motivo_Devolucao	= dw_1.Object.Cd_Motivo_Devolucao	[1]

This.Object.st_filial.Text     		= "TODAS"
This.Object.st_fornecedor.Text	= "TODOS"

If Not IsNull(lvl_Filial) Then
	This.of_AppendWhere("n.cd_filial = " + String(lvl_Filial)) 
	This.Object.st_filial.Text = String(lvl_Filial, "0000") + " - " + dw_1.Object.De_Filial[1]
End If

If Not IsNull(lvs_Fornecedor) Then
	This.of_AppendWhere("n.cd_fornecedor = '" + lvs_Fornecedor + "'") 
	This.Object.st_fornecedor.Text = lvs_Fornecedor + " - " + dw_1.Object.Nm_Razao_Social[1]
End If

If ll_Motivo_Devolucao > 0 Then
	This.of_AppendWhere("n.cd_motivo_devolucao = " + String(ll_Motivo_Devolucao))
End If

Return AncestorReturnValue
end event

event ue_postretrieve;call super::ue_postretrieve;If pl_linhas > 0 Then
	
	wf_verifica_vencimento()

End If

Return 1
end event

event constructor;call super::constructor;This.Visible = False
end event

event ue_preprint;call super::ue_preprint;Return This.Event ue_Retrieve()
end event

event ue_saveas;//override
This.Event ue_PrePrint()

SUPER::EVENT ue_SaveAs()
end event

type cb_enviar_xml from picturebutton within tabpage_1
integer x = 9
integer y = 1788
integer width = 457
integer height = 108
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\botao_enviar_xml.png"
string disabledname = "S:\Sistemas_PB12\Comuns\Figuras\botao_enviar_xml_desabilitado.png"
alignment htextalign = left!
boolean map3dcolors = true
long backcolor = 67108864
end type

event clicked;String ls_Chave, ls_msg
Long ll_Row
Date ldt_Emissao

ll_Row = tab_1.TabPage_1.dw_2.GetRow()

If ll_Row = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Selecione uma nota fiscal.", Exclamation!)
	Return -1
End If
	
ls_Chave 	= tab_1.TabPage_1.dw_2.Object.de_chave_acesso	[ ll_Row ]
ldt_Emissao	= Date(tab_1.TabPage_1.dw_2.Object.dh_emissao	[ ll_Row ])

If Not gf_ge202_envia_xml_email(ls_Chave, ldt_Emissao, Ref ls_msg ) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Erro ao enviar email. Motivo: " + ls_msg, StopSign!)
End If
	


end event

type cb_2 from commandbutton within tabpage_1
integer x = 475
integer y = 1788
integer width = 457
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
string text = "Etiqueta Volume"
end type

event clicked;Long 		ll_Volumes,&
			ll_Nota
String	ls_de_serie, &
			ls_de_especie

uo_ge224_etiqueta_vol_dev_compra lo_Etiqueta		


If PrintSetup() = -1 Then
	MessageBox("Aviso", "Impress$$HEX1$$e300$$ENDHEX$$o cancelada.")
	Return -1
End If

Open(w_ge224_qtde_volumes)

ll_Volumes = Message.DoubleParm

If ll_Volumes < 1 Then
	Return -1
End If

Try
	lo_Etiqueta = Create uo_ge224_etiqueta_vol_dev_compra
	
	Tab_1.TabPage_1.dw_2.AcceptText()

	ll_Nota = Tab_1.TabPage_1.dw_2.Object.nr_nf[Tab_1.TabPage_1.dw_2.getRow()]
	ls_de_serie = Tab_1.TabPage_1.dw_2.Object.de_serie[Tab_1.TabPage_1.dw_2.getRow()]
	ls_de_especie = Tab_1.TabPage_1.dw_2.Object.de_especie[Tab_1.TabPage_1.dw_2.getRow()]
	
	lo_Etiqueta.of_emite_etiqueta(ll_Nota, ls_de_serie, ls_de_especie, ll_Volumes)
	
Finally
	Destroy(lo_Etiqueta)
End Try


end event

type cb_solicita_canc_sap from commandbutton within tabpage_1
integer x = 942
integer y = 1788
integer width = 530
integer height = 108
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Solicita Canc. SAP"
end type

event clicked;Boolean lb_sucesso = false
String	ls_Operador,&
		ls_msg, & 
		ls_cd_chave_interface
DateTime ldt_dh_cancelamento, &
			ldt_dh_solicitacao_canc, &
			ldt_dh_movimentacao_caixa
Long 	ll_NF, &
		ll_Filial,&
		ll_nr_integracao,&
		ll_Linha

String	ls_Especie, &
		ls_Serie,&
		ls_nr_documento_sap,&
		ls_Fornecedor
		
If Tab_1.TabPage_1.dw_2.RowCount() = 0 Then Return 
	
If not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("GE224_SOLICITA_CANCELAMENTO", ref ls_Operador) Then return

Tab_1.TabPage_1.dw_2.AcceptText()

ll_Linha			= Tab_1.TabPage_1.dw_2.GetRow( )
ll_Filial		= Tab_1.TabPage_1.dw_2.Object.cd_filial					[ll_Linha]
ls_Fornecedor  = Tab_1.TabPage_1.dw_2.Object.cd_fornecedor			[ll_Linha]
ll_NF 			= Tab_1.TabPage_1.dw_2.Object.nr_nf		 				[ll_Linha]
ls_Especie 		= Tab_1.TabPage_1.dw_2.Object.de_especie				[ll_Linha]
ls_Serie 		= Tab_1.TabPage_1.dw_2.Object.de_serie					[ll_Linha]

If wf_busca_datas_nota_devolucao_compra( ll_Filial, ll_NF, ls_Especie, ls_Serie, ref ldt_dh_cancelamento, ref ldt_dh_solicitacao_canc, ref ldt_dh_movimentacao_caixa ) Then
	If IsNull(ldt_dh_cancelamento) Then
		If IsNull(ldt_dh_solicitacao_canc) Then
			If wf_busca_nr_documento_sap( ll_NF, ls_Especie, ls_Serie, ref ls_nr_documento_sap, ref ll_nr_integracao, ref ls_cd_chave_interface, ref ls_msg ) Then
				If wf_atualiza_nota_devolucao_compra( ll_Filial, ll_NF, ls_Especie, ls_Serie, ls_Operador ) Then
					If wf_grava_log_exportacao_sap( ll_Filial, ll_NF, ls_Especie, ls_Serie, ls_Fornecedor,  String(ll_nr_integracao), ls_nr_documento_sap, ldt_dh_movimentacao_caixa, ls_cd_chave_interface) Then
						lb_sucesso = True
					End If
				End If
			Else
				messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_msg,Exclamation!)
			End if
		Else
			messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","J$$HEX1$$e100$$ENDHEX$$ existe uma solicita$$HEX2$$e700e300$$ENDHEX$$o de cancelamento pendente em: "+String(ldt_dh_solicitacao_canc)+".",Exclamation!)
		End If
	Else
		messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","A nota j$$HEX1$$e100$$ENDHEX$$ foi cancelada no SAP em: " +String(ldt_dh_cancelamento)+".",Exclamation!)
	End If
End If

If Not lb_sucesso Then
	SqlCa.of_Rollback()
Else
	SqlCa.of_Commit()
	messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Solicita$$HEX2$$e700e300$$ENDHEX$$o de cancelamento da NFD no SAP realizada com sucesso.")
End If
end event

type cb_imprimir from commandbutton within tabpage_1
integer x = 3127
integer y = 1788
integer width = 370
integer height = 108
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Imprimir"
end type

event clicked;Date		ldt_Emissao

Long		lvl_qt_notas_selecionadas,& 
			ll_Cd_Filial_Origem,&
			ll_Nr_Nf,& 
			ll_Qt_Impressa,&
			lvl_Find

String	ls_Chave_Acesso,&
			ls_Autorizada,& 
			ls_Especie,& 
			ls_Serie,& 
			ls_Erro,& 
			ls_id_situacao_nf,&
			ls_impressora
			
uo_ge579_imprime_danfe_nfe	lo_ge579_imprime_nfe

dw_2.AcceptText()

If dw_2.RowCount() < 1 Then
	MessageBox("Aviso", "N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ registros para serem impressos.")
	Return 1
End If

lvl_qt_notas_selecionadas = dw_2.GetItemNumber(dw_2.RowCount(), "qt_notas_selecionadas")
		
If lvl_qt_notas_selecionadas < 1 Then
	MessageBox("Aviso", "Selecione as notas para impress$$HEX1$$e300$$ENDHEX$$o.")
	Return 1
End If

Open(w_ge224_selecao_impressora)
		
ls_impressora = Message.stringparm

If Isnull(ls_impressora) or ls_impressora = '' Then 
	Return 1
End If

Try
	Try
		SetPointer(HourGlass!)
		
		lo_ge579_imprime_nfe = Create uo_ge579_imprime_danfe_nfe
		
		Open(w_Aguarde)
		
		w_Aguarde.Title = 'Imprimindo...'
		w_Aguarde.uo_Progress.of_SetMax(lvl_qt_notas_selecionadas)
		
		ll_Qt_Impressa = 0
		lvl_Find = 0
		
		Do 
			lvl_Find = dw_2.Find("id_imprimir = 'S'", lvl_Find+1, dw_2.RowCount())
			If lvl_Find > 0 Then
				ll_Qt_Impressa ++
				
				w_Aguarde.Title = 'Imprimindo... '+String(ll_Qt_Impressa)+' de '+String(lvl_qt_notas_selecionadas)
				w_Aguarde.uo_Progress.of_SetProgress(ll_Qt_Impressa)
					
				ls_Chave_Acesso		= dw_2.Object.de_chave_acesso[lvl_Find]
				ldt_Emissao				= Date(dw_2.Object.dh_emissao[lvl_Find])
				ll_Cd_Filial_Origem	= dw_2.Object.cd_filial[lvl_Find]
				ll_Nr_Nf					= dw_2.Object.nr_nf[lvl_Find]
				ls_Especie				= dw_2.Object.de_especie[lvl_Find]
				ls_Serie					= dw_2.Object.de_serie[lvl_Find]
				ls_id_situacao_nf		= dw_2.Object.id_situacao[lvl_Find]
				
				IF ls_id_situacao_nf = 'A' THEN
					If Not lo_ge579_imprime_nfe.of_imprime_danfe_nfe(ll_Cd_Filial_Origem,&
																					 ll_Nr_Nf, &
																					 ls_Especie, &
																					 ls_Serie, &
																					 ls_Chave_Acesso, &
																					 ldt_Emissao, &
																					 ls_impressora,&
																					 Ref ls_Erro, &
																					 'DEV') Then
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao imprimir a nota "+String(ll_Nr_Nf)+":~r"+ls_Erro)
						Continue
					Else
						dw_2.Object.id_imprimir[lvl_Find] = 'N' // se deu certo, desmarca
					End If // ge579
				end if // situacao
			End If // find > 0
		Loop Until (lvl_Find<=0 or lvl_Find = dw_2.RowCount())
		
	Finally
		Close(w_Aguarde)
		If IsValid(lo_ge579_imprime_nfe) Then Destroy(lo_ge579_imprime_nfe)
		SetPointer(Arrow!)
	End Try
Catch	( runtimeerror  lo_rte )
	MessageBox("Erro", "Erro ao imprimir a nota: " + lo_rte.GetMessage(), StopSign!)
End Try
end event

type cb_visualiza_comp_coleta from commandbutton within tabpage_1
integer x = 1490
integer y = 1788
integer width = 805
integer height = 108
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Visualizar Comp. de Coleta"
end type

event clicked;string ls_log

if ib_visualizar_comprovante = True Then

	if Not wf_visualizar_arquivo(ref ls_log) Then
		if ls_log <> '' and not isnull(ls_log) then
			messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_log)
		ENd if
	End if
	
ENd if
end event

type cb_exporta_comp_coleta from commandbutton within tabpage_1
integer x = 2304
integer y = 1788
integer width = 805
integer height = 108
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Exportar Comp. de Coleta"
end type

event clicked;string ls_log

if ib_visualizar_comprovante = True Then

	if Not wf_exportar_arquivo(ref ls_log) Then
		if ls_log <> '' and not isnull(ls_log) then
			messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_log)
		ENd if
	End if
	
ENd if
end event

type cb_1 from commandbutton within tabpage_2
integer x = 2249
integer y = 692
integer width = 713
integer height = 80
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Copia Chave de Acesso"
end type

event clicked;Integer lvi_Retorno

Tab_1.TabPage_2.dw_3.SelectText(1, 44)

lvi_Retorno = Tab_1.TabPage_2.dw_3.Copy()

Choose Case lvi_Retorno
	Case -1  // Vazio
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o foi selecionada para a c$$HEX1$$f300$$ENDHEX$$pia.")
	Case -2  // Erro na c$$HEX1$$f300$$ENDHEX$$pia
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na c$$HEX1$$f300$$ENDHEX$$pia.")
	Case -9  // Erro na c$$HEX1$$f300$$ENDHEX$$pia
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na c$$HEX1$$f300$$ENDHEX$$pia.")
End Choose
end event

