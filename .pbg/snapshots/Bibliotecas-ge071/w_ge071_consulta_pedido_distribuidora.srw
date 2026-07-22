HA$PBExportHeader$w_ge071_consulta_pedido_distribuidora.srw
forward
global type w_ge071_consulta_pedido_distribuidora from dc_w_2tab_consulta_selecao_lista_2det
end type
type cb_gerar_arquivos from commandbutton within tabpage_1
end type
type st_confirmar from statictext within tabpage_1
end type
type cb_1 from commandbutton within tabpage_1
end type
type dw_5 from dc_uo_dw_base within tabpage_1
end type
type dw_6 from dc_uo_dw_base within tabpage_1
end type
type cb_retorno from commandbutton within tabpage_1
end type
type cb_reenviar_sap from commandbutton within tabpage_1
end type
type cb_3 from commandbutton within tabpage_1
end type
type gb_5 from groupbox within tabpage_2
end type
type dw_7 from dc_uo_dw_base within tabpage_2
end type
type cb_2 from commandbutton within w_ge071_consulta_pedido_distribuidora
end type
end forward

global type w_ge071_consulta_pedido_distribuidora from dc_w_2tab_consulta_selecao_lista_2det
integer width = 5925
integer height = 2376
string title = "GE071 - Consulta de Pedidos por Distribuidora"
long backcolor = 80269524
cb_2 cb_2
end type
global w_ge071_consulta_pedido_distribuidora w_ge071_consulta_pedido_distribuidora

type variables
uo_filial ivo_filial

Boolean ivb_Check, ib_Iniciado_Operacao_SAP = False

String is_Produtos

String ivs_Coluna_Distribuidora[]
String ivs_Nome_Distribuidora[]

String ivs_Coluna_Resumido[]
String ivs_Nome_Resumido[]
end variables

forward prototypes
public function boolean wf_existe_produto_recebido (long pl_pedido)
public function boolean wf_fornecedor_parametro (string ps_fornecedor)
public subroutine wf_localiza_filial ()
public function boolean wf_gerar_arq_retorno ()
public function long wf_abre_arquivo (long pl_nr_pedido, string ps_cd_filial)
public function boolean wf_busca_log_exportacao_pedido (long al_cd_filial, long al_nr_pedido_distribuidora, ref string as_erro)
public function boolean wf_verifica_situacao_pedido (long al_cd_filial, long al_nr_pedido_distribuidora, ref string as_erro)
public function boolean wf_verifica_status_integracao (long al_cd_filial, long al_nr_pedido_distribuidora, ref string as_situacao_log, ref string as_erro)
public function boolean wf_atualiza_pedido_reenvio_sap (long al_cd_filial, long al_nr_pedido_distribuidora, long al_nr_pedido_novo, ref string as_erro)
public function boolean wf_insere_log_exportacao (long al_cd_filial, long al_nr_pedido_distribuidora, long al_nr_pedido_distribuidora_reenvio, ref string as_erro)
public function boolean wf_insere_pedido_distribuidora_novo (long al_cd_filial, long al_nr_pedido_distribuidora, long al_nr_pedido_novo, ref string as_erro)
public function boolean wf_verifica_pedido_reenviado (long al_cd_filial, long al_nr_pedido_distribuidora, ref string as_erro)
end prototypes

public function boolean wf_existe_produto_recebido (long pl_pedido);Long lvl_Total

Select count(*) Into :lvl_Total
From pedido_distribuidora_produto
Where nr_pedido_distribuidora = :pl_Pedido
  and qt_recebida > 0
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If IsNull(lvl_Total) or lvl_Total = 0 Then
			Return False
		Else
			Return True
		End If
	Case 100
		Return False
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na verifica$$HEX2$$e700e300$$ENDHEX$$o da libera$$HEX2$$e700e300$$ENDHEX$$o para o recebimento." + SqlCa.SqlErrText, StopSign!)
		Return False
End Choose
end function

public function boolean wf_fornecedor_parametro (string ps_fornecedor);String lvs_Fornecedor_Parametro


Select cd_distribuidora_estoque Into :lvs_Fornecedor_Parametro
from parametro
where id_parametro = '1'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If ps_Fornecedor = lvs_Fornecedor_Parametro Then
			Return True
		Else
			Return False
		End If
	Case -1
		SqlCa.of_MsgdbError("Erro ao localizar o fornecedor do parametro.")
		Return False
End Choose
end function

public subroutine wf_localiza_filial ();Integer lvi_Nulo

SetNull(lvi_Nulo)

Tab_1.TabPage_1.dw_1.AcceptText()

ivo_Filial.of_Localiza_Filial(Tab_1.TabPage_1.dw_1.GetText())

If ivo_Filial.Localizada Then
	
	Tab_1.TabPage_1.dw_1.Object.Cd_Filial[1]   = ivo_Filial.Cd_Filial
	Tab_1.TabPage_1.dw_1.Object.Nm_Fantasia[1] = ivo_Filial.Nm_Fantasia
Else
	Tab_1.TabPage_1.dw_1.Object.Cd_Filial[1]   = lvi_Nulo
	Tab_1.TabPage_1.dw_1.Object.Nm_Fantasia[1] = ""
	
End If
end subroutine

public function boolean wf_gerar_arq_retorno ();long ll_for, ll_linhas, ll_nr_pedido, ll_cd_filial, ll_Linhas2, ll_for2, ll_file
String ls_tipo_registro, ls_tipo_arquivo, ls_cd_fornecedor, ls_cd_cliente, ls_rejeicao, ls_cgc, ls_tipo_pedido, ls_horario, ls_tipo_det, ls_cd_produto_det, ls_motivo, ls_ean_det, ls_origem_merc, ls_motivo_det
String ls_cabecalho, ls_detalhe, ls_rodape, ls_selecao
long ll_sequencial=0, ll_seq_det, ll_qt_atendida_det
dc_uo_ds_Base lds_dados

ll_linhas = tab_1.tabpage_1.dw_2.rowcount()

if tab_1.tabpage_1.dw_2.find('cbx_selecao = "S"',1,ll_linhas) = 0 Then
	Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Selecione ao menos um pedido para gerar o arquivo de retorno.')
	return false
end if

lds_dados = Create dc_uo_ds_Base

lds_dados.of_ChangeDataObject("ds_ge071_retorno_distribuidora") 

Open(w_Aguarde)
w_aguarde.uo_progress.of_setmax(ll_linhas)
w_Aguarde.Title = "Gerando Arquivo de Retorno..."
	
Try
	
	For ll_for = 1 to ll_linhas
		 
		ls_selecao =  tab_1.tabpage_1.dw_2.object.cbx_selecao[ll_for]
		if ls_selecao <> 'S' Then Continue
		 
		ll_nr_pedido = tab_1.tabpage_1.dw_2.object.nr_pedido_distribuidora[ll_for]
		ll_cd_filial = tab_1.tabpage_1.dw_2.object.cd_filial[ll_for]
	
		ll_linhas2 = lds_dados.retrieve(ll_cd_filial, ll_nr_pedido)
		
		if ll_linhas2 > 0 Then
		
			for ll_for2 = 1 to ll_linhas2
				
				ls_tipo_registro = lds_dados.object.id_tipo_registro[ll_for2]
				ls_tipo_arquivo = lds_dados.object.tipo_arquivo[ll_for2]
				ls_cd_fornecedor = lds_dados.object.cd_fornecedor[ll_for2]
				ls_cd_cliente = lds_dados.object.cd_cliente[ll_for2]
				ls_rejeicao = lds_dados.object.id_rejeicao[ll_for2]
				ls_motivo = lds_dados.object.de_rejeicao[ll_for2]
				ls_cgc = lds_dados.object.nr_cgc[ll_for2]
				ls_tipo_pedido = lds_dados.object.id_tipo_pedido[ll_for2]
				ls_horario = lds_dados.object.de_horario[ll_for2]
				ls_tipo_det = lds_dados.object.id_tipo_det[ll_for2]
				ls_cd_produto_det = lds_dados.object.cd_produto_det[ll_for2]
				ls_motivo_det = lds_dados.object.de_motivo_rejeicao_det[ll_for2]
				ls_ean_det = lds_dados.object.de_ean_det[ll_for2]
				ls_origem_merc = lds_dados.object.cd_origem_merc_det[ll_for2]
		
				ll_seq_det = lds_dados.object.nr_sequencial_det[ll_for2]
				ll_qt_atendida_det = lds_dados.object.qt_atendida_det[ll_for2]
				
				ll_sequencial++
				
				//Monta o cabe$$HEX1$$e700$$ENDHEX$$alho
				if ll_sequencial = 1 Then
					
					//Abre o arquivo
					ll_file = this.wf_abre_arquivo( ll_nr_pedido, ls_cd_cliente)
					
					ls_cabecalho += ls_tipo_registro
					ls_cabecalho += String(ll_sequencial,'00000')
					ls_cabecalho += ls_tipo_arquivo
					ls_cabecalho += ls_cd_fornecedor + Fill(' ', 9 - len(ls_cd_fornecedor) ) 
					
					If Len(ls_cd_cliente) <= 6 Then
						ls_cabecalho += ls_cd_cliente + Fill(' ', 6 - len(ls_cd_cliente) )
					Else
						ls_cabecalho += Fill(' ', 6) // n$$HEX1$$e300$$ENDHEX$$o esta sendo informado porque n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ utilizado, quando for maior que 7
					End If
					
					ls_cabecalho += String(ll_nr_pedido,'0000000000')
					ls_cabecalho += ls_rejeicao
					ls_cabecalho += ls_motivo + Fill(' ', 30 - len(ls_motivo) )
					ls_cabecalho += ls_cgc + Fill(' ', 14 - len(ls_cgc) ) 
					ls_cabecalho += ls_tipo_pedido
					ls_cabecalho += ls_horario
					
					FileWriteEx(ll_file, ls_cabecalho)
					
					ls_cabecalho = ''
					
					ll_sequencial++
					
				end if
				
				ls_detalhe += ls_tipo_det
				ls_detalhe += String(ll_sequencial,'00000')		
				ls_detalhe += ls_cd_produto_det + Fill(' ', 8 - len(ls_cd_produto_det) )
				ls_detalhe += String(ll_qt_atendida_det,'00000')
				ls_detalhe += ls_motivo_det + Fill(' ', 50 - len(ls_motivo_det) )
				ls_detalhe += ls_ean_det + Fill(' ', 13 - len(ls_ean_det) )
				ls_detalhe += ls_origem_merc
				
				FileWriteEx(ll_file, ls_detalhe)
				
				ls_detalhe = ''
				
			next
			
			ll_sequencial++
			
			ls_rodape += '3'
			ls_rodape += String(ll_sequencial,'00000')
			ls_rodape += String(ll_linhas2,'00000')
			ls_rodape += '00000'
			
			FileWriteEx(ll_file, ls_rodape)
			
			ls_rodape = ''
			
			FileClose(ll_file)
			
			ll_sequencial = 0
			
		end if
		
		w_aguarde.uo_progress.of_setprogress(ll_for)	
		
	Next
	
Finally
	if isvalid(w_aguarde) then close(w_aguarde)

End Try

return true

end function

public function long wf_abre_arquivo (long pl_nr_pedido, string ps_cd_filial);string ls_arquivo, ls_diretorio,ls_distribuidora
long ll_file,ll_filial

select cd_distribuidora
into :ls_distribuidora
from pedido_distribuidora
where nr_pedido_distribuidora = :pl_nr_pedido
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o da Situa$$HEX2$$e700e300$$ENDHEX$$o do Pedido Distribuidora")
End If

ls_diretorio = 'C:\Distribuidora\Faltas'

ls_diretorio = ls_diretorio+ "\"+ ls_distribuidora

if Not DirectoryExists(ls_diretorio) Then
	CreateDirectory(ls_diretorio)
end if

// Abrir o arquivo
ls_Arquivo = ls_diretorio + "\" + ps_cd_Filial + '_' + String(pl_nr_pedido,'00000000') + ".RET"

ll_file = FileOpen(ls_Arquivo, LineMode!, Write!, LockWrite!, Replace!)

If ll_file = -1 Then  
   MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na abertura do arquivo '" + ls_Arquivo + "'.", StopSign!)
End If

return ll_file
end function

public function boolean wf_busca_log_exportacao_pedido (long al_cd_filial, long al_nr_pedido_distribuidora, ref string as_erro);String lvs_id_status_integracao

select top 1 id_status_integracao
into :lvs_id_status_integracao
from dbo.log_exportacao_sap
where cd_integer = :al_nr_pedido_distribuidora
and cd_filial = :al_cd_filial
Using SQLCA;

Choose Case SqlCa.SqlCode
	Case is < 0
		as_erro = "Erro ao procurar log_exportacao_sap existente para o reenvio. -> 'wf_busca_log_exportacao_pedido'~r: " + SqlCa.SqlerrText
		Return False
	Case 100
		as_erro = "O pedido " + String(al_nr_pedido_distribuidora) + " da filial " + String(al_cd_filial) + " ainda n$$HEX1$$e300$$ENDHEX$$o foi enviado. -> 'wf_busca_log_exportacao_pedido'"
		Return False
End Choose

If lvs_id_status_integracao = 'C' Then
	as_erro = "O pedido " + String(al_nr_pedido_distribuidora) + " da filial " + String(al_cd_filial) + " n$$HEX1$$e300$$ENDHEX$$o pode ser reenviado. -> 'wf_busca_log_exportacao_pedido'"
	Return False
End If
end function

public function boolean wf_verifica_situacao_pedido (long al_cd_filial, long al_nr_pedido_distribuidora, ref string as_erro);String lvs_situacao_pedido

select id_situacao
  into :lvs_situacao_pedido
  from pedido_distribuidora
 where nr_pedido_distribuidora	= :al_nr_pedido_distribuidora and
		 cd_filial						= :al_cd_filial
using SqlCa;
		  
Choose Case SqlCa.SqlCode
	Case -1 
		as_erro = "Erro ao procurar pedido_distribuidora existente para o reenvio 'wf_verifica_situacao_pedido': " + SqlCa.SqlerrText
		Return False
	Case 100
		as_erro = "N$$HEX1$$e300$$ENDHEX$$o foi encontrado o pedido_distribuidora do pedido: " + String(al_nr_pedido_distribuidora) + " -> 'wf_verifica_situacao_pedido'."
		Return False
End Choose

if lvs_situacao_pedido = 'X' then
	as_erro = "O pedido " + String(al_nr_pedido_distribuidora) + " est$$HEX1$$e100$$ENDHEX$$ cancelado. S$$HEX1$$f300$$ENDHEX$$ $$HEX1$$e900$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel reenviar pedidos em aberto. 'wf_verifica_situacao_pedido': " + SqlCa.SqlerrText
	Return False
end if

Return True
end function

public function boolean wf_verifica_status_integracao (long al_cd_filial, long al_nr_pedido_distribuidora, ref string as_situacao_log, ref string as_erro);Long ll_exists

select top 1 1
  into :ll_exists
  from log_exportacao_sap
 where id_tipo_nf 				= 'WMO'
	and cd_tipo_documento 		= 'WMO'
	and id_tipo_log 				= 72
	and cd_integer					= :al_nr_pedido_distribuidora
	and cd_filial 					= :al_cd_filial
	and id_status_integracao 	= 'C';

Choose Case SqlCa.SqlCode
	Case is < 0 // Erro
		as_erro = "Erro ao procurar log_exportacao_sap existente para o reenvio 'wf_verifica_status_integracao': " + SqlCa.SqlerrText
		Return False
		
	Case 0 // Achou com status C
		as_situacao_log = 'C'
		if ll_exists = 1 then
			as_erro = "O pedido " + String(al_nr_pedido_distribuidora) + " da filial " + String(al_cd_filial) + " j$$HEX1$$e100$$ENDHEX$$ se encontra pendente de reenvio para o SAP."
			Return False
		end if
		
	Case 100 // N$$HEX1$$e300$$ENDHEX$$o achou com status C, buscar outros
		select top 1 id_status_integracao
		  into :as_situacao_log
		  from log_exportacao_sap
		 where id_tipo_nf 				= 'WMO'
			and cd_tipo_documento 		= 'WMO'
			and id_tipo_log 				= 72
			and cd_integer					= :al_nr_pedido_distribuidora
			and cd_filial 					= :al_cd_filial
			and id_status_integracao 	<> 'C';
			
			If sqlca.sqlcode < 0 then
				as_erro = "Erro ao procurar log_exportacao_sap existente para o reenvio 'wf_verifica_status_integracao': " + SqlCa.SqlerrText
				Return False
			end if
			
			// N$$HEX1$$e300$$ENDHEX$$o achou nenhum log, avisar que n$$HEX1$$e300$$ENDHEX$$o foi enviado
			if SqlCa.SqlCode = 100 then
				as_erro = "O pedido " + String(al_nr_pedido_distribuidora) + " da filial " + String(al_cd_filial) + " ainda n$$HEX1$$e300$$ENDHEX$$o foi enviado para o SAP."
				Return False
			end if
			
End Choose

Return True
end function

public function boolean wf_atualiza_pedido_reenvio_sap (long al_cd_filial, long al_nr_pedido_distribuidora, long al_nr_pedido_novo, ref string as_erro);Long ll_exists

update pedido_distribuidora
set nr_pedido_distrib_reenvio_sap = :al_nr_pedido_distribuidora
where cd_filial = :al_cd_filial
	and nr_pedido_distribuidora = :al_nr_pedido_novo
using SqlCa;

Choose Case SqlCa.SqlCode
	Case is < 0 // Erro
		as_erro = "Erro ao atualizar nr_pedido_distrib_reenvio_sap da pedido_distribuidora para o pedido "+String(al_nr_pedido_novo)+" -> 'wf_atualiza_pedido_reenvio_sap':~r" + SqlCa.SqlerrText
		Return False
			
End Choose

Return True
end function

public function boolean wf_insere_log_exportacao (long al_cd_filial, long al_nr_pedido_distribuidora, long al_nr_pedido_distribuidora_reenvio, ref string as_erro);Long		ll_exists

st_log_export_sap st_log

//String	ls_id_situacao
//
//select id_situacao
//  into :ls_id_situacao
//  from pedido_distribuidora
// where nr_pedido_distribuidora	= :al_nr_pedido_distribuidora and
// 		 cd_filial						= :al_cd_filial;
//		  
//Choose Case SqlCa.SqlCode
//	Case -1 
//		as_erro = "Erro ao procurar pedido_distribuidora existente para o reenvio 'wf_insere_log_exportacao': " + SqlCa.SqlerrText
//		Return False
//	Case 100
//		as_erro = "N$$HEX1$$e300$$ENDHEX$$o foi encontrado informa$$HEX2$$e700f500$$ENDHEX$$es a respeito do pedido de distribuidora " + String(al_nr_pedido_distribuidora) + " 'wf_insere_log_exportacao': " + SqlCa.SqlerrText
//		Return False
//End Choose
//
//if ls_id_situacao = 'X' then
//	as_erro = "O pedido " + String(al_nr_pedido_distribuidora) + " est$$HEX1$$e100$$ENDHEX$$ cancelado. S$$HEX1$$f300$$ENDHEX$$ $$HEX1$$e900$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel reenviar pedidos em aberto. 'wf_insere_log_exportacao': " + SqlCa.SqlerrText
//	Return False
//end if

//select top 1 1
//  into :ll_exists
//  from log_exportacao_sap
// where id_tipo_nf 				= 'WMO'
//	and cd_tipo_documento 		= 'WMO'
//	and id_tipo_log 				= 72
//	and cd_integer					= :al_nr_pedido_distribuidora
//	and cd_filial 					= :al_cd_filial
//	and id_status_integracao 	= 'C';
//
//Choose Case SqlCa.SqlCode
//	Case -1 
//		as_erro = "Erro ao procurar log_exportacao_sap existente para o reenvio 'wf_insere_log_exportacao': " + SqlCa.SqlerrText
//		Return False
//End Choose
//
//if ll_exists = 1 then
//	as_erro = "O pedido " + String(al_nr_pedido_distribuidora) + " da filial " + String(al_cd_filial) + " j$$HEX1$$e100$$ENDHEX$$ se encontra pendente para reenvio para o SAP."
//	Return False
//end if

st_log.cd_chave 				= String(al_cd_filial, '0000') + '@#!'  + String(al_nr_pedido_distribuidora)
st_log.id_tipo_nf 				= 'WMO'
st_log.cd_tipo_documento   = 'WMO'
st_log.id_tipo_log 				= 72
st_log.cd_filial  					= al_cd_filial
st_log.cd_parametro_geral  = 'DH_INICIO_OPERACAO_SAP'
st_log.cd_integer				= al_nr_pedido_distribuidora
st_log.cd_varchar				= String(al_nr_pedido_distribuidora_reenvio)

If Not gf_insere_log_exportacao_sap(st_log, ref as_erro) then
	Return False
End If

//update log_exportacao_sap
//  set id_reprocessar = 'S'
//where id_tipo_nf				= 'WMO'
//  and cd_tipo_documento	= 'WMO'
//  and id_tipo_log				= 72
//  and id_status_integracao 	= 'C'
//  and cd_filial	 				= :al_cd_filial
//  and cd_integer				= :al_nr_pedido_distribuidora;
//  
//Choose Case SqlCa.SqlCode
//	Case -1 
//		as_erro = "Erro ao atualizar log_exportacao_sap para marcar o id_reprocessar. 'wf_insere_log_exportacao': " + SqlCa.SqlerrText
//		Return False
//End Choose

Return True
end function

public function boolean wf_insere_pedido_distribuidora_novo (long al_cd_filial, long al_nr_pedido_distribuidora, long al_nr_pedido_novo, ref string as_erro);Long ll_exists

Insert Into pedido_distribuidora (cd_filial, nr_pedido_distribuidora, dh_emissao, vl_total_pedido, id_situacao, nr_pedido_filial, cd_distribuidora, dh_falta, dh_nota_fiscal, dh_titulo_pagar, cd_promocao_distribuidora, nr_pedido_conexao, de_motivo_rejeicao, pc_juros_diario, nr_rodada, id_projeto_conexao, nr_volumes, dh_cancelamento, id_pedido_almoxarifado, id_tipo_pedido, pc_desconto_financeiro, dh_exportacao_sap, id_exportacao_sap, de_erro_envio_sap, cd_condicao_pagamento, dh_inclusao, cd_centro_custo, dh_conferencia_finalizada, nr_matricula_cancelamento, dh_picking_controlado, vl_minimo_pedido, nr_pedido_distrib_reenvio_sap)
select
	cd_filial,
	:al_nr_pedido_novo, /*nr_pedido_distribuidora*/
	dh_emissao,
	vl_total_pedido,
	id_situacao,
	nr_pedido_filial,
	cd_distribuidora,
	dh_falta,
	dh_nota_fiscal,
	dh_titulo_pagar,
	cd_promocao_distribuidora,
	nr_pedido_conexao,
	de_motivo_rejeicao,
	pc_juros_diario,
	nr_rodada,
	id_projeto_conexao,
	nr_volumes,
	dh_cancelamento,
	id_pedido_almoxarifado,
	id_tipo_pedido,
	pc_desconto_financeiro,
	dh_exportacao_sap,
	id_exportacao_sap,
	de_erro_envio_sap,
	cd_condicao_pagamento,
	dh_inclusao,
	cd_centro_custo,
	dh_conferencia_finalizada,
	nr_matricula_cancelamento,
	dh_picking_controlado,
	vl_minimo_pedido,
	null /*nr_pedido_distrib_reenvio_sap*/
From pedido_distribuidora
Where cd_filial = :al_cd_filial
	and nr_pedido_distribuidora = :al_nr_pedido_distribuidora
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case is < 0 // Erro
		as_erro = "Erro ao inserir pedido_distribuidora com o novo pedido ("+String(al_nr_pedido_novo)+") para reenviar o pedido original ("+String(al_nr_pedido_distribuidora)+") -> 'wf_insere_pedido_distribuidora_novo':~r" + SqlCa.SqlerrText
		Return False
			
End Choose

Return True
end function

public function boolean wf_verifica_pedido_reenviado (long al_cd_filial, long al_nr_pedido_distribuidora, ref string as_erro);Long lvl_Existe

select count(*)
  into :lvl_Existe
  from pedido_distribuidora
 where nr_pedido_distrib_reenvio_sap	= :al_nr_pedido_distribuidora and
		 cd_filial								= :al_cd_filial
using SqlCa;
		  
Choose Case SqlCa.SqlCode
	Case is < 0
		as_erro = "Erro ao validar se o pedido j$$HEX1$$e100$$ENDHEX$$ $$HEX1$$e900$$ENDHEX$$ um pedido reenviado. 'wf_verifica_pedido_reenviado': " + SqlCa.SqlerrText
		Return False
	Case 0
		if lvl_Existe > 0 then
			as_erro = "N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitido reenviar um pedido que j$$HEX1$$e100$$ENDHEX$$ $$HEX1$$e900$$ENDHEX$$ reenvio de outro pedido: " + String(al_nr_pedido_distribuidora)
			Return False
		end if
End Choose

Return True
end function

on w_ge071_consulta_pedido_distribuidora.create
int iCurrent
call super::create
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
end on

on w_ge071_consulta_pedido_distribuidora.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_2)
end on

event ue_postopen;call super::ue_postopen;Date 		lvdt_Parametro
String	ls_msg


if not gf_verifica_inicio_operacao_sap('DH_INICIO_OPERACAO_SAP', ref ib_Iniciado_Operacao_SAP, ref ls_msg ) then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar a data de in$$HEX1$$ed00$$ENDHEX$$cio de opera$$HEX2$$e700e300$$ENDHEX$$o do SAP.', StopSign!)
	Close(this)
end if

//O reenvio n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ mais necess$$HEX1$$e100$$ENDHEX$$rio e seu processamento n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ mais previsto na GE481.
//if ib_Iniciado_Operacao_SAP then
//	Tab_1.TabPage_1.cb_reenviar_sap.Visible = True
//end if

This.ivm_Menu.ivb_Permite_Imprimir = False

lvdt_Parametro = Date(gvo_Parametro.of_Dh_Movimentacao())
 
Tab_1.TabPage_1.dw_1.Object.Dt_Emissao_De [1] = RelativeDate(lvdt_Parametro,-2)
Tab_1.TabPage_1.dw_1.Object.Dt_Emissao_Ate[1] = lvdt_Parametro

DataWindowChild lvdwc_Linha

lvdwc_Linha = Tab_1.TabPage_1.dw_1.of_InsertRow_DDDW("cd_distribuidora")			

lvdwc_Linha.SetItem(1, "cd_fornecedor", "000000000")
lvdwc_Linha.SetItem(1, "nm_fantasia", "TODAS")

Tab_1.TabPage_1.dw_1.Object.Cd_Distribuidora[1] = "000000000"


lvdwc_Linha = Tab_1.TabPage_1.dw_1.of_InsertRow_DDDW("id_tipo_pedido")			

lvdwc_Linha.SetItem(1, "id_tipo", "0")
lvdwc_Linha.SetItem(1, "de_tipo", "TODOS")

Tab_1.TabPage_1.dw_1.Object.id_tipo_pedido[1] = "0"


Tab_1.tabpage_1.cb_gerar_arquivos.Visible = (gvo_aplicacao.ivo_seguranca.cd_sistema = 'RO')

If gvo_Aplicacao.ivs_DataSource = 'homologa' Then
	Tab_1.tabpage_1.cb_retorno.Enabled = True
Else
	Tab_1.tabpage_1.cb_retorno.Enabled = False
End If
end event

event ue_preopen;call super::ue_preopen;// Determina as dimens$$HEX1$$f500$$ENDHEX$$es dos folders

// Sele$$HEX2$$e700e300$$ENDHEX$$o
//ivl_Largura_1 = 5495
//ivl_Altura_1  = 2135

ivl_Largura_1 = 5888
ivl_Altura_1  = 2196


// Detalhes
ivl_Largura_2 = 4850
ivl_Altura_2    = 2000
end event

event close;call super::close;Destroy ivo_Filial
end event

event open;call super::open;ivo_Filial = Create uo_Filial
end event

type dw_visual from dc_w_2tab_consulta_selecao_lista_2det`dw_visual within w_ge071_consulta_pedido_distribuidora
end type

type gb_aux_visual from dc_w_2tab_consulta_selecao_lista_2det`gb_aux_visual within w_ge071_consulta_pedido_distribuidora
end type

type tab_1 from dc_w_2tab_consulta_selecao_lista_2det`tab_1 within w_ge071_consulta_pedido_distribuidora
integer x = 5
integer y = 4
integer width = 5861
integer height = 2176
long backcolor = 80269524
end type

event tab_1::selectionchanging;//OverRide

SetPointer(HourGlass!)

If NewIndex = 2 Then
	If Tab_1.TabPage_1.dw_2.GetRow() > 0 Then
		
		//Altera a dws conforme a distribuidora
		
		String lvs_Fornecedor
		lvs_Fornecedor = Tab_1.TabPage_1.dw_2.Object.Cd_Distribuidora[Tab_1.TabPage_1.dw_2.GetRow()]
		
		If  wf_Fornecedor_Parametro(lvs_Fornecedor) Then
			Tab_1.TabPage_2.dw_4.DataObject = "dw_ge071_detalhe_nf_transferencia"
		Else
			Tab_1.TabPage_2.dw_4.DataObject = "dw_ge071_detalhe_nf_compra"
		End If
		
		Tab_1.TabPage_2.dw_4.SetTransObject(SqlCa)		
		
		// Executa o evento de recupera$$HEX2$$e700e300$$ENDHEX$$o das linhas
		// das DW's de detalhes
		Tab_1.TabPage_2.dw_3.Event ue_Retrieve()
		Tab_1.TabPage_2.dw_4.Event ue_Retrieve()
		
		// Permite a troca do folder
		Return 0
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma linha da lista para visualizar os detalhes.", StopSign!)
		// N$$HEX1$$e300$$ENDHEX$$o permite a troca do folder
		Return 1
	End If
End If		

SetPointer(Arrow!)
end event

event tab_1::selectionchanged;call super::selectionchanged;If oldindex = 1 Then
	ivm_Menu.mf_Classificar(True)
	ivm_Menu.mf_Filtrar(True)
Else
	ivm_Menu.mf_Classificar(False)
	ivm_Menu.mf_Filtrar(False)
End If

ivm_Menu.mf_Localizar(False)
end event

type tabpage_1 from dc_w_2tab_consulta_selecao_lista_2det`tabpage_1 within tab_1
integer width = 5824
integer height = 2060
long backcolor = 80269524
long tabbackcolor = 80269524
long picturemaskcolor = 553648127
cb_gerar_arquivos cb_gerar_arquivos
st_confirmar st_confirmar
cb_1 cb_1
dw_5 dw_5
dw_6 dw_6
cb_retorno cb_retorno
cb_reenviar_sap cb_reenviar_sap
cb_3 cb_3
end type

on tabpage_1.create
this.cb_gerar_arquivos=create cb_gerar_arquivos
this.st_confirmar=create st_confirmar
this.cb_1=create cb_1
this.dw_5=create dw_5
this.dw_6=create dw_6
this.cb_retorno=create cb_retorno
this.cb_reenviar_sap=create cb_reenviar_sap
this.cb_3=create cb_3
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_gerar_arquivos
this.Control[iCurrent+2]=this.st_confirmar
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.dw_5
this.Control[iCurrent+5]=this.dw_6
this.Control[iCurrent+6]=this.cb_retorno
this.Control[iCurrent+7]=this.cb_reenviar_sap
this.Control[iCurrent+8]=this.cb_3
end on

on tabpage_1.destroy
call super::destroy
destroy(this.cb_gerar_arquivos)
destroy(this.st_confirmar)
destroy(this.cb_1)
destroy(this.dw_5)
destroy(this.dw_6)
destroy(this.cb_retorno)
destroy(this.cb_reenviar_sap)
destroy(this.cb_3)
end on

type gb_2 from dc_w_2tab_consulta_selecao_lista_2det`gb_2 within tabpage_1
integer x = 14
integer y = 536
integer width = 5801
integer height = 1500
string text = "Lista de Pedidos"
end type

type gb_1 from dc_w_2tab_consulta_selecao_lista_2det`gb_1 within tabpage_1
integer x = 14
integer y = 0
integer width = 3931
integer height = 468
end type

type dw_1 from dc_w_2tab_consulta_selecao_lista_2det`dw_1 within tabpage_1
integer x = 37
integer y = 56
integer width = 3881
integer height = 400
string dataobject = "dw_ge071_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;Long lvl_Nulo

String ls_Nulo

dw_2.Event ue_Reset()

If dwo.Name = "nm_fantasia" Then
	
	SetNull(lvl_Nulo)
	
	If Data = "" Or IsNull(Data) Then
			This.Object.Cd_Filial[1] = lvl_nulo
			Return 0
		End If	
		
	If Data <> ivo_Filial.Nm_Fantasia Then Return 1
End if

If dwo.Name = "id_rejei_distrib" Then
	If Data = "S" Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Pedidos com motivo de rejei$$HEX2$$e700e300$$ENDHEX$$o 'DISTRIBUICAO' s$$HEX1$$e300$$ENDHEX$$o pedidos que N$$HEX1$$c300$$ENDHEX$$O foram enviados aos distribuidores.")
	End If
End If

If dwo.Name = "id_planilha" Then
	If Data = "S" Then
		OpenWithParm(w_ge162_filtro_via_planilha, '')
		
		is_Produtos = Message.StringParm
		
		If Trim(is_Produtos) = "" Or IsNull(is_Produtos) Then
			Return 1
		End If
				
	Else
		is_Produtos = ""
	End If
End If
end event

event dw_1::ue_key;String lvs_Coluna

If Key = KeyEnter! Then
	
	lvs_Coluna = This.GetColumnName()
	
	If lvs_Coluna = 'nm_fantasia' Then
		
		wf_Localiza_Filial()
		
	End If
End If
	
end event

event dw_1::editchanged;call super::editchanged;dw_2.Event ue_Reset()
end event

type dw_2 from dc_w_2tab_consulta_selecao_lista_2det`dw_2 within tabpage_1
event ue_mousemove pbm_mousemove
integer x = 37
integer y = 596
integer width = 5751
integer height = 1428
string dataobject = "dw_ge071_lista"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_mousemove;If This.RowCount() > 0 Then
	If xpos >= st_confirmar.X and (xpos <= st_confirmar.x + st_confirmar.Width) and &
		  ypos >= 0 and ypos < 50 Then	 
		
		st_confirmar.Visible = True
		
		If ivb_Check Then
			st_confirmar.Text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para desmarcar todos."
		Else
			st_confirmar.Text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para marcar todos."
		End If
	Else
		st_confirmar.Visible = False
	End If
End If
end event

event dw_2::ue_retrieve;call super::ue_retrieve;If AncestorReturnValue > 0 Then 
	This.Event RowFocusChanged(1)
	
	This.ivm_Menu.mf_Classificar(False)
	This.ivm_Menu.mf_Filtrar(False)
	This.ivm_Menu.mf_Localizar(False)
	
	This.ivo_Controle_Menu.of_SalvarComo(True)
Else
	This.ivo_Controle_Menu.of_SalvarComo(False)	
End If

Return AncestorReturnValue 
end event

event dw_2::rowfocuschanged;call super::rowfocuschanged;String ls_Situacao, ls_Descricao, ls_Motivo_Rejeicao
String lvs_resumido

lvs_resumido = Tab_1.TabPage_1.dw_1.Object.id_resumido[1]

If lvs_resumido = 'N' Then
	
	If Tab_1.TabPage_1.dw_2.RowCount() > 0 Then
		
		ls_Situacao = Tab_1.TabPage_1.dw_2.Object.Id_Situacao[currentrow]
		
		If  ls_Situacao = "F" Then
			This.ivm_Menu.mf_Classificar(False)
			This.ivm_Menu.mf_Filtrar(False)
			This.ivm_Menu.mf_Localizar(False)
		End If
		
		ls_Descricao = ''
		
		If ls_Situacao = "J" or ls_Situacao = "X" Then
			ls_Motivo_Rejeicao = Tab_1.TabPage_1.dw_2.Object.de_motivo_rejeicao[currentrow]
			
			If Not IsNull(ls_Motivo_Rejeicao) and Trim(ls_Motivo_Rejeicao) <> '' Then
				ls_Descricao = 'Motivo Rejei$$HEX2$$e700e300$$ENDHEX$$o: ' + ls_Motivo_Rejeicao
			End If
		End If
		
		This.Object.t_motivo_rejecao.Text = ls_Descricao
		
	End If
End If	

end event

event dw_2::constructor;call super::constructor;This.of_SetRowSelection("", "if(id_situacao = ~"X~", rgb(255,0,0), rgb(0,0,0))")

ivs_Coluna_Distribuidora = {"nr_pedido_distribuidora", &
									 "nm_fantasia", &
									 "cd_filial", &
									 "de_filial", &
									 "dh_emissao", &
									 "nr_rodada", &
									 "vl_total_pedido", &
									 "qt_produtos", &
									 "qt_faturada", &
									 "qt_produtos_separados", &
									 "qtde_divergente",&
									 "id_situacao", &
									 "id_tipo_pedido_desc",&
									 "nr_rota",&
									 "nr_ordem_faturamento" }
							 
ivs_Nome_Distribuidora = {"N$$HEX1$$fa00$$ENDHEX$$mero", &
								  "Distribuidora", &
								  "C$$HEX1$$f300$$ENDHEX$$digo", &
								  "Filial", &
								  "Emiss$$HEX1$$e300$$ENDHEX$$o", &
								  "Rodada", &
								  "Valor", &
								  "Sku", &
								  "Sku Fat", &
								  "Sku Sep", &
								  "Qt Diverg",&
								  "Situa$$HEX2$$e700e300$$ENDHEX$$o", &
								  "Ped. Eletr$$HEX1$$f400$$ENDHEX$$nico",&
								  "Nr Rota",&
								  "Ord.Fat"}		


ivs_Coluna_Resumido = {"cd_distribuidora", &
									 "nm_fantasia", &
									 "qt_pedito"}
							 
ivs_Nome_Resumido = {"Distribuidora", &
								  "Nome Fantasia", &
								  "Qtde. Pedido"}	
								  
								  

end event

event dw_2::doubleclicked;call super::doubleclicked;Integer lvi_Linha

String lvs_Marcacao

Tab_1.TabPage_1.dw_2.AcceptText()		
		  
If dwo.Name = "id_selecionar" Then
		
	If ivb_Check Then
		lvs_Marcacao = 'N'
		ivb_Check 	 = False
	Else
		lvs_Marcacao = 'S'
		ivb_Check 	 = True
	End If
	
	For lvi_Linha = 1 To This.RowCount()
		This.Object.cbx_Selecao[lvi_Linha] = lvs_Marcacao
	Next
	
End If

end event

event dw_2::ue_recuperar;//OverRide

Date	lvdt_Emissao_de, &
		lvdt_Emissao_ate
		 
Long	lvl_Filial, &
		lvl_Pedido, &
		lvl_qtd_where,&
		lvl_Rota

String	lvs_Situacao, &
		lvs_Distribuidora, &
		ls_Tipo_Pedido, &
		ls_Rejei_Distrib, &
		ls_Rodada, &
		lvs_resumido, & 
		lvs_dataobject

String lvs_Coluna[]
String lvs_Nome[]
		
Tab_1.TabPage_1.dw_1.AcceptText()

lvdt_Emissao_de	= Parent.dw_1.Object.Dt_Emissao_de	[1]
lvdt_Emissao_ate	= Parent.dw_1.Object.Dt_Emissao_ate	[1]
lvs_Situacao			= Parent.dw_1.Object.Id_Situacao			[1]
lvs_Distribuidora	= Parent.dw_1.Object.Cd_Distribuidora	[1]
lvl_Filial				= Parent.dw_1.Object.Cd_Filial				[1]
lvl_Pedido			= Parent.dw_1.Object.nr_pedido			[1]
ls_Tipo_Pedido		= Parent.dw_1.Object.Id_Tipo_Pedido	[1]
ls_Rejei_Distrib		= Parent.dw_1.Object.Id_Rejei_Distrib	[1]
ls_Rodada			= Parent.dw_1.Object.Nr_Rodada			[1]
lvs_resumido        = Parent.dw_1.Object.id_resumido		[1]
lvl_Rota				= Parent.dw_1.Object.nr_rota				[1]


If lvs_Resumido = "S" Then
	lvs_dataobject = "dw_ge071_lista_resumo"
	lvl_qtd_where = 1
	dw_2.width		=	2115
	tab_1.tabpage_2.enabled = false
	
	lvs_Coluna = ivs_Coluna_Resumido
	lvs_Nome   = ivs_Nome_Resumido
Else
	lvs_dataobject	=	"dw_ge071_lista"
	lvl_qtd_where	=	6
//	dw_2.width		=	5330
	dw_2.width		=	5751
	tab_1.tabpage_2.enabled = true	
	lvs_Coluna = ivs_Coluna_Distribuidora
	lvs_Nome   = ivs_Nome_Distribuidora
	
End If

If This.DataObject <> lvs_dataobject Then
	If Not This.of_ChangeDataObject(lvs_dataobject) Then	Return -1
	
	This.of_SetSort(lvs_Coluna, lvs_Nome)
	This.of_SetFilter(lvs_Coluna, lvs_Nome)
	
	This.of_SetRowSelection()
	
End If


If IsNull( lvdt_Emissao_de ) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio.")
	dw_1.Event ue_Pos(1,"dt_emissao_de")
	Return -1
End If

If IsNull( lvdt_Emissao_ate ) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino.")
	dw_1.Event ue_Pos(1,"dt_emissao_ate")
	Return -1
End If

If lvs_Situacao <> "T" Then
	If lvs_Situacao = "V" Then // Valor do pedido abaixo do m$$HEX1$$ed00$$ENDHEX$$nimo da distribuidora.
		This.of_AppendWhere_SubQuery("p.vl_total_pedido < coalesce(p.vl_minimo_pedido,0)", lvl_qtd_where)
	Else
		This.of_AppendWhere_SubQuery("p.id_situacao = '" + lvs_Situacao + "'", lvl_qtd_where)
	End If
End If

If Not lvl_Filial = 0 or Not IsNull(lvl_Filial) Then
	This.of_AppendWhere_SubQuery("p.cd_filial = " +  String(lvl_Filial), lvl_qtd_where)
End If

If Not lvl_Pedido = 0 or Not IsNull(lvl_Pedido) Then
	This.of_AppendWhere_SubQuery("p.nr_pedido_distribuidora = " +  String(lvl_Pedido), lvl_qtd_where)
End If

If lvs_Distribuidora <> "000000000" Then 
	This.of_AppendWhere_SubQuery("p.cd_distribuidora = '" + lvs_Distribuidora + "'", lvl_qtd_where )
End If

If lvs_Resumido = 'N' Then
	If Not IsNull( is_Produtos ) And is_Produtos <> "" Then
		This.of_AppendWhere_SubQuery("pp.cd_produto in (" + is_Produtos + ")", lvl_qtd_where )
	End If
End If

If ls_Tipo_Pedido <> "0" Then
	If ls_Tipo_Pedido = "1" Then
		This.of_AppendWhere_SubQuery("(p.id_tipo_pedido = '" + ls_Tipo_Pedido + "' Or p.id_tipo_pedido is null)", lvl_qtd_where )
	Else
		This.of_AppendWhere_SubQuery("p.id_tipo_pedido = '" + ls_Tipo_Pedido + "'", lvl_qtd_where )
	End If
End If

If ls_Rodada <> "T" Then
	This.of_AppendWhere_SubQuery("p.nr_rodada = " + ls_Rodada, lvl_qtd_where )
End If

If ls_Rejei_Distrib = "N" Then
	This.of_AppendWhere_SubQuery("(p.de_motivo_rejeicao <> 'DISTRIBUICAO' Or p.de_motivo_rejeicao Is Null)", lvl_qtd_where )
End If


If lvl_Rota > 0 Then 
	This.of_AppendWhere_SubQuery("a.nr_rota_entrega = " + String(lvl_Rota), lvl_qtd_where )	
End If 	


If lvs_resumido = 'S' Then 
	This.of_AppendWhere("p.dh_emissao >= '" + String(lvdt_Emissao_de,  "yyyy/mm/dd") + "'")
	This.of_AppendWhere("p.dh_emissao <= '" + String(lvdt_Emissao_ate, "yyyy/mm/dd") + "'")
//
string ls_teste
//
ls_teste = this.getsqlselect( )	
	Return This.Retrieve()
Else
	Return This.Retrieve(lvdt_Emissao_de, lvdt_Emissao_ate )
End If	



end event

type tabpage_2 from dc_w_2tab_consulta_selecao_lista_2det`tabpage_2 within tab_1
integer width = 5824
integer height = 2060
gb_5 gb_5
dw_7 dw_7
end type

on tabpage_2.create
this.gb_5=create gb_5
this.dw_7=create dw_7
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_5
this.Control[iCurrent+2]=this.dw_7
end on

on tabpage_2.destroy
call super::destroy
destroy(this.gb_5)
destroy(this.dw_7)
end on

type gb_4 from dc_w_2tab_consulta_selecao_lista_2det`gb_4 within tabpage_2
integer x = 9
integer y = 1208
integer width = 2011
integer height = 636
string text = "Notas Fiscais Faturadas"
end type

type gb_3 from dc_w_2tab_consulta_selecao_lista_2det`gb_3 within tabpage_2
integer x = 14
integer width = 4754
integer height = 1172
string text = "Produtos do Pedido"
end type

type dw_3 from dc_w_2tab_consulta_selecao_lista_2det`dw_3 within tabpage_2
integer x = 37
integer y = 68
integer width = 4690
integer height = 1072
string dataobject = "dw_ge071_detalhe_produto"
boolean vscrollbar = true
end type

event dw_3::constructor;call super::constructor;
String lvs_Coluna[], &
       lvs_Nome[]
		 
lvs_Coluna = {"cd_produto", "produto", "qt_pedida", "qt_faturada", "qt_recebida", "vl_preco_unitario", "qt_produtos", "id_situacao"}

lvs_Nome = {"c$$HEX1$$f300$$ENDHEX$$digo", "descri$$HEX2$$e700e300$$ENDHEX$$o", "qtde pedida", "qtde faturada", "qtde recebida", "pre$$HEX1$$e700$$ENDHEX$$o unit$$HEX1$$e100$$ENDHEX$$rio", "qtde", "situacao"}

This.of_SetSort(lvs_Coluna, lvs_Nome)
This.of_SetFilter(lvs_Coluna, lvs_Nome)

This.of_SetRowSelection()

This.ivb_Ordena_Colunas = True
end event

event dw_3::ue_recuperar;// OverRide

Long lvl_Cd_Filial, &
     lvl_Nr_Pedido
	  
Integer lvi_Linha_Ativa, &
        lvi_Linhas
		  
Tab_1.TabPage_1.dw_2.AcceptText()
lvi_Linha_Ativa = Tab_1.TabPage_1.dw_2.GetRow()

lvl_Cd_Filial = Tab_1.TabPage_1.dw_2.Object.Cd_Filial              [lvi_Linha_Ativa]
lvl_Nr_Pedido = Tab_1.TabPage_1.dw_2.Object.Nr_Pedido_Distribuidora[lvi_Linha_Ativa]

lvi_Linhas = This.Retrieve(lvl_Cd_Filial, lvl_Nr_Pedido)

Return lvi_Linhas
end event

event dw_3::getfocus;//OverRide
This.ivm_Menu.mf_Classificar(True)
This.ivm_Menu.mf_Filtrar(True)
This.ivm_Menu.mf_Localizar(False)
This.ivm_Menu.mf_Recuperar(False)

end event

event dw_3::rowfocuschanged;call super::rowfocuschanged;dw_7.Event ue_Retrieve()
end event

type dw_4 from dc_w_2tab_consulta_selecao_lista_2det`dw_4 within tabpage_2
integer x = 32
integer y = 1260
integer width = 1961
integer height = 560
string dataobject = "dw_ge071_detalhe_nf_compra"
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event dw_4::ue_recuperar;// OverRide
Long lvl_Cd_Filial, &
     lvl_Nr_Pedido, &
	  lvl_Cd_Filial_Origem
	  
Integer lvi_Linha_Ativa, &
        lvi_Linhas

Tab_1.TabPage_1.dw_2.AcceptText()
lvi_Linha_Ativa = Tab_1.TabPage_1.dw_2.GetRow()

lvl_Cd_Filial        = Tab_1.TabPage_1.dw_2.Object.Cd_Filial[lvi_Linha_Ativa]
lvl_Nr_Pedido        = Tab_1.TabPage_1.dw_2.Object.Nr_Pedido_Distribuidora[lvi_Linha_Ativa]
lvl_Cd_Filial_Origem = gvo_Parametro.of_Filial_Matriz()

If This.DataObject = "dw_ge071_detalhe_nf_transferencia" Then
	lvi_Linhas = This.Retrieve(lvl_Cd_Filial, lvl_Nr_Pedido, lvl_Cd_Filial_Origem)
Else
	lvi_Linhas = This.Retrieve(lvl_Cd_Filial, lvl_Nr_Pedido)
End If

Return lvi_Linhas
end event

event dw_4::getfocus;//OverRide
This.ivm_Menu.mf_Classificar(False)
This.ivm_Menu.mf_Filtrar(False)
This.ivm_Menu.mf_Localizar(False)

end event

event dw_4::constructor;call super::constructor;This.of_SetRowSelection()
end event

event dw_4::ue_postretrieve;// Override

Boolean lvb_Habilita = False

If pl_Linhas > 0 Then
	lvb_Habilita = True
End If

This.ivo_Controle_Menu.of_Classificar(lvb_Habilita)
This.ivo_Controle_Menu.of_Filtrar(lvb_Habilita)
This.ivo_Controle_Menu.of_Localizar(lvb_Habilita)

Return pl_Linhas
end event

type cb_gerar_arquivos from commandbutton within tabpage_1
integer x = 2382
integer y = 468
integer width = 640
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Gerar &Arq. de Pedidos"
end type

event clicked;Boolean lvb_Selecao = false

Long lvl_Linha, &
     lvl_Filial, &
     lvl_Pedido
	 
String lvs_Distribuidora, &
       lvs_Arquivo_Gravado

uo_Distribuicao_Pedido lvo_Pedido
lvo_Pedido = Create uo_Distribuicao_Pedido

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma gera$$HEX2$$e700e300$$ENDHEX$$o dos arquivos para os pedidos selecionados ?", Question!, YesNo!, 2) = 1 Then
	
	SetPointer(HourGlass!)
	
	For lvl_Linha = 1 To Tab_1.TabPage_1.dw_2.RowCount()
		
		If Tab_1.TabPage_1.dw_2.Object.cbx_Selecao[lvl_Linha] = "S" Then

			lvb_Selecao = true
			
			lvl_Filial        = Tab_1.TabPage_1.dw_2.Object.Cd_Filial              			[lvl_Linha]
			lvl_Pedido        = Tab_1.TabPage_1.dw_2.Object.Nr_Pedido_Distribuidora	[lvl_Linha]
			lvs_Distribuidora = Tab_1.TabPage_1.dw_2.Object.Cd_Distribuidora       	[lvl_Linha]
			
			If Not lvo_Pedido.of_Grava_Arquivo_Pedido(lvl_Filial, &
															  lvl_Pedido, &
															  lvs_Distribuidora, &
															  lvs_Arquivo_Gravado, &
															  "1") Then
							  
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do arquivo '" + lvs_Arquivo_Gravado + "'.", StopSign!)											  
				Exit
			End If
		End If

	Next
	
	If lvb_Selecao Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Os arquivos foram gerados com sucesso.")
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum pedido selecionado.", StopSign!)
	End If	
	
End If

Destroy(lvo_Pedido)
SetPointer(Arrow!)

end event

type st_confirmar from statictext within tabpage_1
boolean visible = false
integer x = 3739
integer y = 504
integer width = 859
integer height = 56
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 15793151
boolean enabled = false
string text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para marcar todos."
boolean focusrectangle = false
end type

type cb_1 from commandbutton within tabpage_1
integer x = 3063
integer y = 468
integer width = 649
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Planilha Atend. Distrib."
end type

event clicked;Try
	
	Open(w_Aguarde)
	w_Aguarde.Title = "Gerando planilha... Aguarde."
	
	dw_5.Event ue_Retrieve()

Finally
	Close(w_Aguarde)
End Try
end event

type dw_5 from dc_uo_dw_base within tabpage_1
boolean visible = false
integer x = 4699
integer y = 1020
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge071_plan_atend_distrib"
end type

event ue_preretrieve;call super::ue_preretrieve;String	lvs_Situacao, &
		lvs_Distribuidora, &
		ls_Tipo_Pedido
		 
Date	lvdt_Emissao_de, &
		lvdt_Emissao_ate
		 
Long lvl_Filial, lvl_Pedido

Tab_1.TabPage_1.dw_1.AcceptText()

lvdt_Emissao_de	= Parent.dw_1.Object.Dt_Emissao_de	[1]
lvdt_Emissao_ate	= Parent.dw_1.Object.Dt_Emissao_ate	[1]
lvs_Situacao			= Parent.dw_1.Object.Id_Situacao			[1]
lvs_Distribuidora	= Parent.dw_1.Object.Cd_Distribuidora	[1]
lvl_Filial				= Parent.dw_1.Object.Cd_Filial				[1]
lvl_Pedido			= Parent.dw_1.Object.nr_pedido			[1]
ls_Tipo_Pedido		= Parent.dw_1.Object.Id_Tipo_Pedido	[1]

If IsNull( lvdt_Emissao_de ) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio.")
	dw_1.Event ue_Pos(1,"dt_emissao_de")
	Return -1
End If

If IsNull( lvdt_Emissao_ate ) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino.")
	dw_1.Event ue_Pos(1,"dt_emissao_ate")
	Return -1
End If

If lvs_Situacao <> "T" Then
	This.of_AppendWhere("p.id_situacao = '" + lvs_Situacao + "'" )
End If

If Not lvl_Filial = 0 or Not IsNull(lvl_Filial) Then
	This.of_AppendWhere("p.cd_filial = " +  String(lvl_Filial))
End If

If Not lvl_Pedido = 0 or Not IsNull(lvl_Pedido) Then
	This.of_AppendWhere("p.nr_pedido_distribuidora = " +  String(lvl_Pedido))
End If

If lvs_Distribuidora <> "000000000" Then 
	This.of_AppendWhere("p.cd_distribuidora = '" + lvs_Distribuidora + "'")
End If

If Not IsNull( is_Produtos ) And is_Produtos <> "" Then
	This.of_AppendWhere("pp.cd_produto in (" + is_Produtos + ")")
End If

If ls_Tipo_Pedido <> "0" Then
	If ls_Tipo_Pedido = "1" Then
		This.of_AppendWhere("(p.id_tipo_pedido = '" + ls_Tipo_Pedido + "' Or p.id_tipo_pedido is null)")
	Else
		This.of_AppendWhere("p.id_tipo_pedido = '" + ls_Tipo_Pedido + "'")
	End If
End If

Return 1
end event

event ue_recuperar;//OverRide

Return This.Retrieve(dw_1.Object.dt_emissao_de[1], dw_1.Object.dt_emissao_ate[1])
end event

event ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	This.Event ue_SaveAs()
End If

Return pl_Linhas
end event

type dw_6 from dc_uo_dw_base within tabpage_1
boolean visible = false
integer x = 4169
integer y = 1028
integer taborder = 20
boolean bringtotop = true
boolean enabled = false
string dataobject = "ds_ge071_lista_planilha"
end type

event ue_recuperar;//OverRide

Return This.Retrieve(dw_1.Object.dt_emissao_de[1], dw_1.Object.dt_emissao_ate[1])
end event

event ue_preretrieve;call super::ue_preretrieve;
Return 1
end event

event ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	This.Event ue_SaveAs()
End If

Return pl_Linhas
end event

type cb_retorno from commandbutton within tabpage_1
integer x = 3973
integer y = 20
integer width = 494
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Gerar Arq. Retorno"
end type

event clicked;wf_gerar_arq_retorno()
end event

type cb_reenviar_sap from commandbutton within tabpage_1
boolean visible = false
integer x = 3973
integer y = 120
integer width = 494
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "Reenviar SAP"
end type

event clicked;Boolean	lb_sucesso = True
Long		ll_find, ll_for, ll_resposta, ll_cd_filial, ll_nr_pedido_distribuidora, lvl_nr_pedido_novo
String		ls_selecionado, ls_erro, lvs_situacao_log, ls_Operador

// Permiss$$HEX1$$e300$$ENDHEX$$o
If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("GE071_REENVIA_PEDIDO_DIST_SAP", ref ls_Operador) Then
	Return
End If

ll_find	= Tab_1.TabPage_1.dw_2.Find('cbx_selecao = "S"', 0, Tab_1.TabPage_1.dw_2.RowCount())

if ll_find < 0 then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao buscar pedidos selecionados.', StopSign!)
	Return
end if

if ll_find > 0 then
	ll_resposta	= MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Confirma o reenvio dos pedidos selecionados para o SAP?', Question!, YesNo!, 2)
	
	if ll_resposta = 2 then
		Return
	end if
else
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', '$$HEX1$$c900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio selecionar ao menos um pedido para ser reenviado para o SAP.')
	Return
end if

for ll_for = 1 to Tab_1.TabPage_1.dw_2.RowCount()
	ls_selecionado	= Tab_1.TabPage_1.dw_2.GetItemString(ll_for, 'cbx_selecao')
	
	if ls_selecionado = 'S' then
		ll_cd_filial						= Tab_1.TabPage_1.dw_2.GetItemNumber(ll_for, 'cd_filial')
		ll_nr_pedido_distribuidora	= Tab_1.TabPage_1.dw_2.GetItemNumber(ll_for, 'nr_pedido_distribuidora')
		
		if not wf_verifica_pedido_reenviado(ll_cd_filial, ll_nr_pedido_distribuidora, Ref ls_erro) then
			lb_sucesso = false
			exit
		end if
		
		if not wf_verifica_situacao_pedido(ll_cd_filial, ll_nr_pedido_distribuidora, Ref ls_erro) then
			lb_sucesso = false
			exit
		end if
		
		If not wf_verifica_status_integracao(ll_cd_filial, ll_nr_pedido_distribuidora, Ref lvs_situacao_log, Ref ls_erro) Then
			lb_sucesso = false
			exit
		End If
		
		// S$$HEX1$$f300$$ENDHEX$$ chegou at$$HEX1$$e900$$ENDHEX$$ aqui se tiver algum log diferente de C...
		
		// Gerar novo pedido 
		If Not gf_ge040_proximo_pedido_distribuidora(Ref lvl_nr_pedido_novo, Ref ls_erro) Then
			lb_sucesso	= False
			exit
		End If

		// Inserir na pedido_distribuidora
		if not wf_insere_pedido_distribuidora_novo(ll_cd_filial, ll_nr_pedido_distribuidora, lvl_nr_pedido_novo, ref ls_erro) then
			lb_sucesso	= False
			exit
		end if
		
		// Guardar pedido novo na coluna nr_pedido_distrib_reenvio_sap do pedido original
		if not wf_atualiza_pedido_reenvio_sap(ll_cd_filial, ll_nr_pedido_distribuidora, lvl_nr_pedido_novo, ref ls_erro) then
			lb_sucesso	= False
			exit
		end if
		
		if not wf_insere_log_exportacao(ll_cd_filial, ll_nr_pedido_distribuidora, lvl_nr_pedido_novo, REF ls_erro) then
			lb_sucesso	= False
			exit
		end if
	end if
next

if lb_sucesso then
	SqlCa.of_Commit()
	
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Opera$$HEX2$$e700e300$$ENDHEX$$o realizada com sucesso.')
	Tab_1.TabPage_1.dw_2.Trigger Event ue_recuperar()
Else
	Sqlca.of_Rollback()
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_erro, StopSign!)
end if
end event

type cb_3 from commandbutton within tabpage_1
integer x = 3973
integer y = 220
integer width = 494
integer height = 92
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Cancelar Pedido"
end type

event clicked;Boolean	lb_sucesso = True
DateTime	ld_data_atual
Long		ll_row, ll_for, ll_resposta, ll_cd_filial, ll_nr_pedido_distribuidora
String	ls_id_situacao, ls_id_tipo_pedido, ls_id_exportacao_sap


ll_row	= Tab_1.TabPage_1.dw_2.GetRow()

if ll_row > 0 then
	ll_cd_filial					= Tab_1.TabPage_1.dw_2.GetItemNumber(ll_row, 'cd_filial')
	ll_nr_pedido_distribuidora	= Tab_1.TabPage_1.dw_2.GetItemNumber(ll_row, 'nr_pedido_distribuidora')
	
	ll_resposta	= MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Confirma o cancelamento do pedido ' + String(ll_nr_pedido_distribuidora) + '?', Question!, YesNo!, 2)
	
	if ll_resposta = 2 then
		Return
	end if
	
	ls_id_situacao	= Tab_1.TabPage_1.dw_2.GetItemString(ll_row, 'id_situacao')
	
	if ls_id_situacao <> 'P' then
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Apenas pedidos pendentes podem ser cancelados.', StopSign!)
		Return
	end if
	
	ls_id_tipo_pedido	= Tab_1.TabPage_1.dw_2.GetItemString(ll_row, 'id_tipo_pedido')
	
	if ls_id_tipo_pedido <> '5' then
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Apenas pedidos urgentes podem ser cancelados.', StopSign!)
		Return
	end if
	
	ls_id_exportacao_sap	= Tab_1.TabPage_1.dw_2.GetItemString(ll_row, 'id_exportacao_sap')
	
	if ls_id_exportacao_sap = 'I' then
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Esse produto j$$HEX1$$e100$$ENDHEX$$ foi enviado para o SAP e n$$HEX1$$e300$$ENDHEX$$o pode mais ser cancelado por aqui.', StopSign!)
		Return
	end if
	
	ld_data_atual	= gf_getserverdate()
	
	update pedido_distribuidora
	set nr_matricula_cancelamento = :gvo_Aplicacao.ivo_Seguranca.nr_matricula,
		 id_situacao					= 'X',
		 dh_cancelamento				= :ld_data_atual
	where nr_pedido_distribuidora = :ll_nr_pedido_distribuidora and
			cd_filial					= :ll_cd_filial;
			
	Choose Case sqlca.sqlcode
		Case -1
			SQLCA.of_rollback()
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao cancelar o pedido distribuidora [' + String(ll_nr_pedido_distribuidora) + ']' + ' Erro: ' + SQLCA.SQLErrText)
			return -1
	End Choose
else
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', '$$HEX1$$c900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio selecionar um pedido para ser cancelado.')
	Return
end if

if lb_sucesso then
	SqlCa.of_Commit()
	
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Opera$$HEX2$$e700e300$$ENDHEX$$o realizada com sucesso.')
	Tab_1.TabPage_1.dw_2.Trigger Event ue_recuperar()
end if
end event

type gb_5 from groupbox within tabpage_2
integer x = 2057
integer y = 1208
integer width = 2363
integer height = 636
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Log SAP"
end type

type dw_7 from dc_uo_dw_base within tabpage_2
integer x = 2085
integer y = 1260
integer width = 2318
integer height = 560
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge071_detalhe_log_sap"
end type

event ue_recuperar;// OverRide
Long lvl_Cd_Filial, &
     lvl_Nr_Pedido, &
	 lvl_cd_produto
	  
Integer lvi_Linha_Ativa, &
        lvi_Linhas, lvi_Linha_prod

Tab_1.TabPage_1.dw_2.AcceptText()
lvi_Linha_Ativa = Tab_1.TabPage_1.dw_2.GetRow()
lvi_Linha_prod = dw_3.GetRow()

lvl_Cd_Filial = Tab_1.TabPage_1.dw_2.Object.Cd_Filial[lvi_Linha_Ativa]
lvl_Nr_Pedido = Tab_1.TabPage_1.dw_2.Object.Nr_Pedido_Distribuidora[lvi_Linha_Ativa]
lvl_cd_produto = dw_3.Object.cd_produto[lvi_Linha_prod]

lvi_Linhas = This.Retrieve(lvl_Cd_Filial, lvl_Nr_Pedido, lvl_cd_produto)

Return lvi_Linhas
end event

type cb_2 from commandbutton within w_ge071_consulta_pedido_distribuidora
boolean visible = false
integer x = 4014
integer y = 452
integer width = 649
integer height = 92
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Planilha Anal$$HEX1$$ed00$$ENDHEX$$tica Itens"
end type

event clicked;Try
	
	Open(w_Aguarde)
	w_Aguarde.Title = "Gerando planilha anal$$HEX1$$ed00$$ENDHEX$$tica... Aguarde."
	
	tab_1.Tabpage_1.dw_6.Event ue_Retrieve()

Finally
	Close(w_Aguarde)
End Try
end event

