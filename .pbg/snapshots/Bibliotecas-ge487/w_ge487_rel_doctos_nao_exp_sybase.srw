HA$PBExportHeader$w_ge487_rel_doctos_nao_exp_sybase.srw
$PBExportComments$Relat$$HEX1$$f300$$ENDHEX$$rio de Documentos n$$HEX1$$e300$$ENDHEX$$o Exportados Sybase
forward
global type w_ge487_rel_doctos_nao_exp_sybase from dc_w_selecao_lista_relatorio
end type
type uo_1 from uo_data_atual within w_ge487_rel_doctos_nao_exp_sybase
end type
end forward

global type w_ge487_rel_doctos_nao_exp_sybase from dc_w_selecao_lista_relatorio
string accessiblename = "GE487 Pendencias Exportacao CAR"
integer x = 215
integer y = 220
integer width = 5659
integer height = 2364
string title = "GE487 - Relat$$HEX1$$f300$$ENDHEX$$rio Pend$$HEX1$$ea00$$ENDHEX$$ncias Exporta$$HEX2$$e700e300$$ENDHEX$$o - CAR"
uo_1 uo_1
end type
global w_ge487_rel_doctos_nao_exp_sybase w_ge487_rel_doctos_nao_exp_sybase

type variables
String ivs_Ambiente
String ivs_Parametros[]

long ivl_altura_1, &
        ivl_altura_2, &
        ivl_largura_1, &
        ivl_largura_2

//datawindowchild dwc_tipo_doc

//Cria$$HEX2$$e700e300$$ENDHEX$$o classes para filtros
uo_Filial							ivo_filial   // uo_mult_filial 

dc_uo_ds_base      ivds_pesquisa

dc_uo_transacao uoi_transacao_multi, &
					   uoi_transacao_SYB
end variables

forward prototypes
public function boolean wf_muda_datastore (string ps_tipodocto)
public function boolean wf_trata_log (integer pi_tpo_exporta, string ps_tipodocto, string ps_ambiente, string ps_situacao)
public function boolean wf_popula_tela (date pdt_inicio, date pdt_fim, integer pl_filial, string ps_tipodocto, string ps_ambiente)
end prototypes

public function boolean wf_muda_datastore (string ps_tipodocto);ivds_pesquisa.reset()

Choose Case ps_tipodocto
     Case 'VD','CV'  /* Vendas ou Cancelamento de Venda  */	
		If Not ivds_pesquisa.Of_ChangeDataObject('ds_ge487_vendas') Then
		   MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Erro ao abrir datastore de Vendas, favor entrar em contato com TI")
  		   Return False
		End If	

	Case 'DV', 'CD'	/* Devolu$$HEX2$$e700e300$$ENDHEX$$o Venda e Devolu$$HEX2$$e700e300$$ENDHEX$$o Venda Cancelamento */	
		If Not ivds_pesquisa.Of_ChangeDataObject('ds_ge487_devolucao') Then
		   MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Erro ao abrir datastore de Devolu$$HEX2$$e700e300$$ENDHEX$$o, favor entrar em contato com TI")
  		   Return False
		End If	
	
	Case 	'AN','CA' /* Anexa e Anexa Cancelamento */
		If Not ivds_pesquisa.Of_ChangeDataObject('ds_ge487_vendas') Then
		   MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Erro ao abrir datastore de Anexa, favor entrar em contato com TI")
  		   Return False
		End If	
	  
	Case 'RZ' 	/* Redu$$HEX2$$e700e300$$ENDHEX$$o Z */
		If Not ivds_pesquisa.Of_ChangeDataObject('ds_ge487_reducaoz') Then
		   MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Erro ao abrir datastore de Redu$$HEX2$$e700e300$$ENDHEX$$o Z, favor entrar em contato com TI")
  		   Return False
		End If	
	
	Case 'RC'	/* Recarga */		
		If Not ivds_pesquisa.Of_ChangeDataObject('ds_ge487_recarga') Then
		   MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Erro ao abrir datastore de Recarga, favor entrar em contato com TI")
  		   Return False
		End If		
					
	Case 'CX'	/*  Caixa  */
		If Not ivds_pesquisa.Of_ChangeDataObject('ds_ge487_caixa') Then
		   MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Erro ao abrir datastore de Caixa, favor entrar em contato com TI")
  		   Return False
		End If	
	
	Case 'POS'  /* Invers$$HEX1$$e300$$ENDHEX$$o Posi$$HEX2$$e700e300$$ENDHEX$$o - Cheque e Cart$$HEX1$$e300$$ENDHEX$$o*/
		If Not ivds_pesquisa.Of_ChangeDataObject('ds_ge487_inversao') Then
		   MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Erro ao abrir datastore de Invers$$HEX1$$e300$$ENDHEX$$o P$$HEX1$$f300$$ENDHEX$$s, favor entrar em contato com TI")
  		   Return False
		End If
						
	Case 'PGT'  /* Pagamento - Cheque/Conta/T$$HEX1$$ed00$$ENDHEX$$tulo	*/
		If Not ivds_pesquisa.Of_ChangeDataObject('ds_ge487_pagtos') Then
		   MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Erro ao abrir datastore de Pagamento, favor entrar em contato com TI")
  		   Return False
		End If
		
	Case 'PED'  /* Pedidos Ecommerce	*/
		If Not ivds_pesquisa.Of_ChangeDataObject('ds_ge487_pedido_ecommerce') Then
		   MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Erro ao abrir datastore de Pedido, favor entrar em contato com TI")
  		   Return False
		End If
		
	Case else
		 MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Item n$$HEX1$$e300$$ENDHEX$$o possui tratamento para este relat$$HEX1$$f300$$ENDHEX$$rio - Favor comunicar a equipe de TI")
  		 Return False
End Choose		
			
ivds_pesquisa.SetTransObject(uoi_transacao_SYB)
ivds_pesquisa.Of_RestoreSQLOriginal( )	            
			
Return true			
end function

public function boolean wf_trata_log (integer pi_tpo_exporta, string ps_tipodocto, string ps_ambiente, string ps_situacao);String lvs_log_recarga, lvs_log_pagto_cheque, lvs_log_pagto_conta, lvs_log_pagto_titulo, lvs_log_caixa, lvs_log_reducaoz
String lvs_SQL, lvs_log_dev_venda, lvs_log_venda, lvs_estilo, lvs_log_inversao_cartao, lvs_log_inversao_cheque, lvs_log_pedidos

lvs_log_dev_venda				= " EXISTS(Select 1 from log_exportacao_docto l1 where  l1.cd_filial = n.cd_filial  and l1.de_especie = n.de_especie and l1.de_serie = n.de_serie and  l1.nr_nf = n.nr_nf ) "
lvs_log_venda					= " EXISTS(Select 1 from log_exportacao_docto l1 where  l1.cd_filial = n.cd_filial  and l1.de_especie = case when nfs.de_especie='RPS' then 'NFS' else n.de_especie end and l1.de_serie = CASE WHEN nfs.de_especie='RPS' THEN coalesce(nfs.de_serie_nfse, 'A1') else n.de_serie END and  l1.nr_nf = n.nr_nf ) "
lvs_log_reducaoz				= " EXISTS(Select 1 from log_exportacao_docto l1 where  l1.cd_filial = n.cd_filial  and l1.de_especie = n.de_especie and l1.de_serie = n.de_serie and  l1.nr_nf = n.nr_ecf ) "
lvs_log_recarga 		 		= " EXISTS(Select 1 from log_exportacao_docto l1 where  l1.cd_filial = cx.cd_filial  and l1.de_especie = 'REC' and l1.de_serie = 'R'  and l1.dh_documento = cc.dh_movimentacao_caixa and  l1.nr_nf = cast(substring(rtrim(lc.de_historico), charindex('NSU:', rtrim(lc.de_historico)) + 4 ,  charindex(' ', rtrim(lc.de_historico)) - charindex('NSU:', rtrim(lc.de_historico)) - 4) as integer) )  "
lvs_log_pagto_cheque 		= " EXISTS(Select 1 from log_exportacao_docto l1 where  l1.cd_filial = ch.cd_filial_atualizacao and  l1.de_serie = cast(ch.nr_agencia as char(3))  and cast(l1.nr_nf as char)	= ch.nr_cheque ) "
lvs_log_pagto_conta  	 	= " EXISTS(Select 1 from log_exportacao_docto l1 where  l1.cd_filial = crm.cd_filial and l1.de_especie = 'CNT'  and  l1.dh_documento = crm.dh_movimento and cast(l1.nr_nf as integer) = cast(str_replace(substring(crm.nr_documento,6,7),'/','') as integer) and l1.de_serie = crm.id_tipo_conta ) "
lvs_log_pagto_titulo   	 	= " EXISTS(Select 1 from log_exportacao_docto l1 where  l1.cd_filial = tr.cd_filial  and l1.nr_nf = tr.nr_nf  and  l1.de_especie = 'TIT' ) " 
lvs_log_inversao_cartao 	= " EXISTS(Select 1 from log_exportacao_docto l1 (index idx_docto_ambiente) where l1.cd_filial = n.cd_filial and l1.nr_nf = n.nr_nf	 and l1.de_especie = 'CRT' and l1.de_serie = n.de_serie and l1.id_tipo_docto = 'POS' /*Cartao*/	and l1.id_situacao_log <> 'X' ) "
lvs_log_inversao_cheque	   = " EXISTS(Select 1 from log_exportacao_docto l1 where  l1.cd_filial = ch.cd_filial_inclusao and cast(l1.nr_nf as char)	= ch.nr_conta 	and l1.de_serie = ch.de_forma_pagamento	and l1.dh_documento = ch.dh_emissao	and l1.id_situacao_log <> 'X')"
lvs_log_caixa					= " EXISTS(Select 1 from log_exportacao_docto l1 where  l1.cd_filial = cx.cd_filial and l1.nr_nf = (Case when (lc.cd_conta_fluxo_caixa <> 84 and lc.cd_conta_fluxo_caixa <> 85) then cast('1901' + cast(cc.nr_controle_caixa as varchar) as decimal (10,0))  else cast(cast(cc.nr_controle_caixa as varchar) + cast(lc.nr_lancamento as varchar) as decimal (10,0))   End)  and  l1.de_serie = RIGHT(cast(cx.cd_caixa as varchar), 2) and l1.dh_documento 	= cc.dh_movimentacao_caixa )"
lvs_log_pedidos				= " EXISTS(Select 1 from log_exportacao_docto l1 where l1.cd_filial = pe.cd_filial and l1.nr_nf  = pe.nr_pedido and l1.de_especie = coalesce(pea.id_rede_ecommerce, 'FA')    )"
  
/*== Complementa a Query Principal da Datastore   ==*/
/* Insere Filtro de Situa$$HEX2$$e700e300$$ENDHEX$$o T = Todas / S = Canceladas / N = N$$HEX1$$e300$$ENDHEX$$o Canceladas  */
Choose Case ps_tipodocto
	Case 	'VD','CV', 'DV', 'CD', 'AN', 'CA'	 /* Cen$$HEX1$$e100$$ENDHEX$$rios  Venda,Devolu$$HEX2$$e700e300$$ENDHEX$$o,Anexa */ 
		Choose Case  ps_situacao 
			Case 'S'	/* Canceladas */
				ivds_pesquisa.Of_AppendWhere_SubQuery(("n.dh_cancelamento is not null"),2)
			Case 'N'	/* N$$HEX1$$e300$$ENDHEX$$o Canceladas */
				ivds_pesquisa.Of_AppendWhere_SubQuery(("n.dh_cancelamento is null"),2)
			Case 'T'	/* Todos */	
				If ps_tipodocto = 'CV' or  ps_tipodocto = 'CD' or  ps_tipodocto = 'CA' then
					ivds_pesquisa.Of_AppendWhere_SubQuery(("n.dh_cancelamento is not null"),2)
				End If
		End Choose	

	Case 'CX'  /* Cen$$HEX1$$e100$$ENDHEX$$rio Caixa */
		If ps_situacao <> "T"  then  
			If ps_situacao = 'S' then /* Canceladas */
				ivds_pesquisa.Of_AppendWhere_SubQuery(("lc.id_estorno = 'S'"),3)
			Else /* N$$HEX1$$e300$$ENDHEX$$o Canceladas */
				ivds_pesquisa.Of_AppendWhere_SubQuery(("lc.id_estorno <> 'S'"),3)
			End If	
		End If	
		
	Case 'PED'  /* Cen$$HEX1$$e100$$ENDHEX$$rio Pedido Ecommerce */
		If ps_situacao <> "T"  then  
			If ps_situacao = 'S' then /* Canceladas */
				ivds_pesquisa.Of_AppendWhere_SubQuery(("pe.dh_cancelamento is not null"),2)
				ivds_pesquisa.Of_AppendWhere_SubQuery(("pe.dh_cancelamento is not null"),4)
			Else /* N$$HEX1$$e300$$ENDHEX$$o Canceladas */
				ivds_pesquisa.Of_AppendWhere_SubQuery(("pe.dh_cancelamento is null"),2)
				ivds_pesquisa.Of_AppendWhere_SubQuery(("pe.dh_cancelamento is null"),4)
			End If	
		End If	
			
End Choose

/* Caso seja Anexa ou Cancelamento Anexa, usar$$HEX1$$e100$$ENDHEX$$ a mesma DataStore de Vendas	*/
Choose Case ps_tipodocto
	Case 	'VD','CV'   /* Cen$$HEX1$$e100$$ENDHEX$$rios  Venda */ 
		ivds_pesquisa.Of_AppendWhere_SubQuery(("n.nr_nf_anexa is null"),2)			
	Case	'AN', 'CA' /* Cen$$HEX1$$e100$$ENDHEX$$rio Anexa */
		ivds_pesquisa.Of_AppendWhere_SubQuery(("n.nr_nf_anexa is not null"),2)
End Choose

/*== Final Complemento da Query Principal da Datastore   ==*/

/*== Inclus$$HEX1$$e300$$ENDHEX$$o na Query Tratamento do LOG por Tipo de Documento  ==*/
Choose Case pi_tpo_exporta
	Case 0 // Documentos Integrados no SAP  
		Choose Case ps_tipodocto
			Case 'RZ' 	/* Redu$$HEX2$$e700e300$$ENDHEX$$o Z */
				ivds_pesquisa.Of_AppendWhere_SubQuery(lvs_log_reducaoz, 2)
				// Insere Filtro Situa$$HEX2$$e700e300$$ENDHEX$$o Log
				ivds_pesquisa.Of_AppendWhere_SubQuery( ("l1.id_situacao_log  IN ('P','A') "),3)					
				// Insere Filtro de Ambiente
				ivds_pesquisa.Of_AppendWhere_SubQuery( ("l1.cd_ambiente_sap = '"+ps_ambiente+"'"),3)							
				// Insere Filtro Tipo Docto
				ivds_pesquisa.Of_AppendWhere_SubQuery( ("l1.id_tipo_docto = '"+ps_tipodocto+"'"),3)	
				
			Case 'RC'	/* Recarga */	
				ivds_pesquisa.Of_AppendWhere_SubQuery(lvs_log_recarga, 2)
				// Insere Filtro Situa$$HEX2$$e700e300$$ENDHEX$$o Log
				ivds_pesquisa.Of_AppendWhere_SubQuery( ("l1.id_situacao_log  IN ('P','A') "),3)					
				// Insere Filtro de Ambiente
				ivds_pesquisa.Of_AppendWhere_SubQuery( ("l1.cd_ambiente_sap = '"+ps_ambiente+"'"),3)							
				// Insere Filtro Tipo Docto
				ivds_pesquisa.Of_AppendWhere_SubQuery( ("l1.id_tipo_docto = '"+ps_tipodocto+"'"),3)		
				
			Case 'PED'	/* Pedidos */	
				ivds_pesquisa.Of_AppendWhere_SubQuery(lvs_log_pedidos, 2)
				// Insere consistencia da s$$HEX1$$e900$$ENDHEX$$rie
				ivds_pesquisa.Of_AppendWhere_SubQuery( (" l1.de_serie = case when lc.cd_conta_fluxo_caixa in (172, 205) then 'A' else 'M' end "),3)	
				// Insere Filtro Situa$$HEX2$$e700e300$$ENDHEX$$o Log
				ivds_pesquisa.Of_AppendWhere_SubQuery( ("l1.id_situacao_log  IN ('P','A') "),3)		
				// Insere Filtro de Ambiente
				ivds_pesquisa.Of_AppendWhere_SubQuery( ("l1.cd_ambiente_sap = '"+ps_ambiente+"'"),3)							
				// Insere Filtro Tipo Docto
				ivds_pesquisa.Of_AppendWhere_SubQuery( ("l1.id_tipo_docto = '"+ps_tipodocto+"'"),3)		
				
				 // Acrescenta para segunda part do Union
				
				ivds_pesquisa.Of_AppendWhere_SubQuery(lvs_log_pedidos, 5)
				// Insere consistencia da s$$HEX1$$e900$$ENDHEX$$rie
				ivds_pesquisa.Of_AppendWhere_SubQuery( (" l1.de_serie =  'A' "),6)	
				// Insere Filtro Situa$$HEX2$$e700e300$$ENDHEX$$o Log
				ivds_pesquisa.Of_AppendWhere_SubQuery( ("l1.id_situacao_log  IN ('P','A') "),6)		
				// Insere Filtro de Ambiente
				ivds_pesquisa.Of_AppendWhere_SubQuery( ("l1.cd_ambiente_sap = '"+ps_ambiente+"'"),6)							
				// Insere Filtro Tipo Docto
				ivds_pesquisa.Of_AppendWhere_SubQuery( ("l1.id_tipo_docto = '"+ps_tipodocto+"'"),6)	
				
				
			Case 	'PGT'	 /* Pagamentos - ter$$HEX1$$e100$$ENDHEX$$ 3 querys na mesma Datastore: Cheque, Conta, T$$HEX1$$ed00$$ENDHEX$$tulo */			
				// Insere Filtro Log - Pagamentos por T$$HEX1$$ed00$$ENDHEX$$tulo
				ivds_pesquisa.Of_AppendWhere_SubQuery(lvs_log_pagto_titulo, 8)
				ivds_pesquisa.Of_AppendWhere_SubQuery( ("l1.id_situacao_log  IN ('P','A') "),9)					
				// Insere Filtro de Ambiente
				ivds_pesquisa.Of_AppendWhere_SubQuery( ("l1.cd_ambiente_sap = '"+ps_ambiente+"'"),9)							
				// Insere Filtro Tipo Docto
				ivds_pesquisa.Of_AppendWhere_SubQuery( ("l1.id_tipo_docto = '"+ps_tipodocto+"'"),9)	
							
				// Insere Filtro Log - Pagamentos por Conta
				ivds_pesquisa.Of_AppendWhere_SubQuery(lvs_log_pagto_conta, 5)
				ivds_pesquisa.Of_AppendWhere_SubQuery( ("l1.id_situacao_log  IN ('P','A') "),6)					
				// Insere Filtro de Ambiente
				ivds_pesquisa.Of_AppendWhere_SubQuery( ("l1.cd_ambiente_sap = '"+ps_ambiente+"'"),6)							
				// Insere Filtro Tipo Docto
				ivds_pesquisa.Of_AppendWhere_SubQuery( ("l1.id_tipo_docto = '"+ps_tipodocto+"'"),6)	
				
				// Insere Filtro Log - Pagamentos por Cheque
				ivds_pesquisa.Of_AppendWhere_SubQuery(lvs_log_pagto_cheque, 2)
				ivds_pesquisa.Of_AppendWhere_SubQuery( ("l1.id_situacao_log  IN ('P','A') "),3)					
				// Insere Filtro de Ambiente
				ivds_pesquisa.Of_AppendWhere_SubQuery( ("l1.cd_ambiente_sap = '"+ps_ambiente+"'"),3)							
				// Insere Filtro Tipo Docto
				ivds_pesquisa.Of_AppendWhere_SubQuery( ("l1.id_tipo_docto = '"+ps_tipodocto+"'"),3)			
				
			Case "POS" 	 /* Invers$$HEX1$$e300$$ENDHEX$$o P$$HEX1$$f300$$ENDHEX$$s - Cheque e Cart$$HEX1$$e300$$ENDHEX$$o - As 2 queries est$$HEX1$$e300$$ENDHEX$$o na mesma Datastore */
				// LOG Query de Cheque 
				//lvs_log =   
				ivds_pesquisa.Of_AppendWhere_SubQuery(lvs_log_inversao_cheque, 6)
				// Insere Filtro de Ambiente
				ivds_pesquisa.Of_AppendWhere_SubQuery( ("l1.cd_ambiente_sap = '"+ps_ambiente+"'"),7)							
				// Insere Filtro Tipo Docto
				ivds_pesquisa.Of_AppendWhere_SubQuery( ("l1.id_tipo_docto = '"+ps_tipodocto+"'"),7)
				
				// LOG Query de Cart$$HEX1$$e300$$ENDHEX$$o
				// N$$HEX1$$e300$$ENDHEX$$o pode existir com a situa$$HEX2$$e700e300$$ENDHEX$$o <> X		
				ivds_pesquisa.Of_AppendWhere_SubQuery(lvs_log_inversao_cartao, 2)
				// Insere Filtro de Ambiente
				ivds_pesquisa.Of_AppendWhere_SubQuery( ("l1.cd_ambiente_sap = '"+ps_ambiente+"'"),3)	
				
			Case "CX"
				ivds_pesquisa.Of_AppendWhere_SubQuery(lvs_log_caixa, 3)	
				// Insere Filtro Situa$$HEX2$$e700e300$$ENDHEX$$o Log
				ivds_pesquisa.Of_AppendWhere_SubQuery( ("l1.id_situacao_log  IN ('P','A') "),4)					
				// Insere Filtro de Ambiente
				ivds_pesquisa.Of_AppendWhere_SubQuery( ("l1.cd_ambiente_sap = '"+ps_ambiente+"'"),4)							
				// Insere Filtro Tipo Docto
				ivds_pesquisa.Of_AppendWhere_SubQuery( ("l1.id_tipo_docto = '"+ps_tipodocto+"'"),4)		 
							
			Case "DV", "CD" /* DV = Dev. Venda e CD = Cancel. Dev. Venda */
				ivds_pesquisa.Of_AppendWhere_SubQuery(lvs_log_dev_venda, 2)
				// Insere Filtro Situa$$HEX2$$e700e300$$ENDHEX$$o Log
				ivds_pesquisa.Of_AppendWhere_SubQuery( ("l1.id_situacao_log  IN ('P','A') "),3)					
				// Insere Filtro de Ambiente
				ivds_pesquisa.Of_AppendWhere_SubQuery( ("l1.cd_ambiente_sap = '"+ps_ambiente+"'"),3)							
				// Insere Filtro Tipo Docto
				ivds_pesquisa.Of_AppendWhere_SubQuery( ("l1.id_tipo_docto = '"+ps_tipodocto+"'"),3)		 

			Case else  /*  'VD', 'CV', 'AN','CA' */
				ivds_pesquisa.Of_AppendWhere_SubQuery(lvs_log_venda, 2)
				// Insere Filtro Situa$$HEX2$$e700e300$$ENDHEX$$o Log
				ivds_pesquisa.Of_AppendWhere_SubQuery( ("l1.id_situacao_log  IN ('P','A') "),3)					
				// Insere Filtro de Ambiente
				ivds_pesquisa.Of_AppendWhere_SubQuery( ("l1.cd_ambiente_sap = '"+ps_ambiente+"'"),3)							
				// Insere Filtro Tipo Docto
				ivds_pesquisa.Of_AppendWhere_SubQuery( ("l1.id_tipo_docto IN ('"+IIF(ps_tipodocto='VD', "VD','NFS", IIF(ps_tipodocto='CV', "CV','CFS",ps_tipodocto) )+"')"),3)		 
		End choose		
		
	Case 1 // Documentos n$$HEX1$$e300$$ENDHEX$$o Integrados no SAP - Garantir que o documento seja Devolu$$HEX2$$e700e300$$ENDHEX$$o e depois que n$$HEX1$$e300$$ENDHEX$$o tenha sido integrado( NOT exist)
		
		Choose Case ps_tipodocto
				
			Case 'RZ' 	/* Redu$$HEX2$$e700e300$$ENDHEX$$o Z */
				ivds_pesquisa.Of_AppendWhere_SubQuery(" NOT " + lvs_log_reducaoz, 2)
				// Insere Filtro Situa$$HEX2$$e700e300$$ENDHEX$$o Log
				ivds_pesquisa.Of_AppendWhere_SubQuery( ("l1.id_situacao_log  IN ('P','A') "),3)					
				// Insere Filtro de Ambiente
				ivds_pesquisa.Of_AppendWhere_SubQuery( ("l1.cd_ambiente_sap = '"+ps_ambiente+"'"),3)							
				// Insere Filtro Tipo Docto
				ivds_pesquisa.Of_AppendWhere_SubQuery( ("l1.id_tipo_docto = '"+ps_tipodocto+"'"),3)	
				
			Case 'RC'	/* Recarga */	
				ivds_pesquisa.Of_AppendWhere_SubQuery(" NOT " + lvs_log_recarga, 2)
				// Insere Filtro Situa$$HEX2$$e700e300$$ENDHEX$$o Log
				ivds_pesquisa.Of_AppendWhere_SubQuery( ("l1.id_situacao_log  IN ('P','A') "),3)					
				// Insere Filtro de Ambiente
				ivds_pesquisa.Of_AppendWhere_SubQuery( ("l1.cd_ambiente_sap = '"+ps_ambiente+"'"),3)							
				// Insere Filtro Tipo Docto
				ivds_pesquisa.Of_AppendWhere_SubQuery( ("l1.id_tipo_docto = '"+ps_tipodocto+"'"),3)				
				
			Case 	'PGT'	 /* Pagamentos - ter$$HEX1$$e100$$ENDHEX$$ 3 querys na mesma Datastore: Cheque, Conta, T$$HEX1$$ed00$$ENDHEX$$tulo */
				// Insere Filtro Situa$$HEX2$$e700e300$$ENDHEX$$o Log - Pagamentos por T$$HEX1$$ed00$$ENDHEX$$tulo
				// N$$HEX1$$e300$$ENDHEX$$o pode existir com a situa$$HEX2$$e700e300$$ENDHEX$$o <P> and <A>		
				ivds_pesquisa.Of_AppendWhere_SubQuery(" NOT " +lvs_log_pagto_titulo, 6)
				 // Insere Filtro Situa$$HEX2$$e700e300$$ENDHEX$$o Log
				ivds_pesquisa.Of_AppendWhere_SubQuery( ("l1.id_situacao_log  IN ('P','A') "),7)	
				// Insere Filtro de Ambiente
				ivds_pesquisa.Of_AppendWhere_SubQuery( ("l1.cd_ambiente_sap = '"+ps_ambiente+"'"),7)								
				// Insere Filtro Tipo Docto
				ivds_pesquisa.Of_AppendWhere_SubQuery( ("l1.id_tipo_docto = '"+ps_tipodocto+"'"),7)	
				
				// Insere Filtro Situa$$HEX2$$e700e300$$ENDHEX$$o Log - Pagamentos por Conta
				// N$$HEX1$$e300$$ENDHEX$$o pode existir com a situa$$HEX2$$e700e300$$ENDHEX$$o <P> and <A>		
				ivds_pesquisa.Of_AppendWhere_SubQuery(" NOT " +lvs_log_pagto_conta,4)
				 // Insere Filtro Situa$$HEX2$$e700e300$$ENDHEX$$o Log
				ivds_pesquisa.Of_AppendWhere_SubQuery( ("l1.id_situacao_log  IN ('P','A') "),5)	
				// Insere Filtro de Ambiente
				ivds_pesquisa.Of_AppendWhere_SubQuery( ("l1.cd_ambiente_sap = '"+ps_ambiente+"'"),5)								
				// Insere Filtro Tipo Docto
				ivds_pesquisa.Of_AppendWhere_SubQuery( ("l1.id_tipo_docto = '"+ps_tipodocto+"'"),5)	
				// Insere Filtro Situa$$HEX2$$e700e300$$ENDHEX$$o Log - Pagamentos por Cheque
				// N$$HEX1$$e300$$ENDHEX$$o pode existir com a situa$$HEX2$$e700e300$$ENDHEX$$o <P> and <A>		
				ivds_pesquisa.Of_AppendWhere_SubQuery(" NOT " +lvs_log_pagto_cheque, 2)
				 // Insere Filtro Situa$$HEX2$$e700e300$$ENDHEX$$o Log
				ivds_pesquisa.Of_AppendWhere_SubQuery( ("l1.id_situacao_log  IN ('P','A') "),3)	
				// Insere Filtro de Ambiente
				ivds_pesquisa.Of_AppendWhere_SubQuery( ("l1.cd_ambiente_sap = '"+ps_ambiente+"'"),3)								
				// Insere Filtro Tipo Docto
				ivds_pesquisa.Of_AppendWhere_SubQuery( ("l1.id_tipo_docto = '"+ps_tipodocto+"'"),3)	
								
			Case "POS" 	 /* Invers$$HEX1$$e300$$ENDHEX$$o P$$HEX1$$f300$$ENDHEX$$s - Cheque e Cart$$HEX1$$e300$$ENDHEX$$o - As 2 queries est$$HEX1$$e300$$ENDHEX$$o na mesma Datastore  */	
				// LOG Query de Cheque 
				ivds_pesquisa.Of_AppendWhere_SubQuery(" NOT " + lvs_log_inversao_cheque, 6)
				// Insere Filtro de Ambiente
				ivds_pesquisa.Of_AppendWhere_SubQuery( ("l1.cd_ambiente_sap = '"+ps_ambiente+"'"),7)							
				// Insere Filtro Tipo Docto
				ivds_pesquisa.Of_AppendWhere_SubQuery( ("l1.id_tipo_docto = '"+ps_tipodocto+"'"),7)
				
				// LOG Query de Cart$$HEX1$$e300$$ENDHEX$$o
				ivds_pesquisa.Of_AppendWhere_SubQuery(" NOT " +lvs_log_inversao_cartao, 2)
				// Insere Filtro de Ambiente
				ivds_pesquisa.Of_AppendWhere_SubQuery( ("l1.cd_ambiente_sap = '"+ps_ambiente+"'"),3)	

			Case "CX"
				ivds_pesquisa.Of_AppendWhere_SubQuery(" NOT " + lvs_log_caixa, 3)	
				// Insere Filtro Situa$$HEX2$$e700e300$$ENDHEX$$o Log
				ivds_pesquisa.Of_AppendWhere_SubQuery( ("l1.id_situacao_log  IN ('P','A') "),4)					
				// Insere Filtro de Ambiente
				ivds_pesquisa.Of_AppendWhere_SubQuery( ("l1.cd_ambiente_sap = '"+ps_ambiente+"'"),4)							
				// Insere Filtro Tipo Docto
				ivds_pesquisa.Of_AppendWhere_SubQuery( ("l1.id_tipo_docto = '"+ps_tipodocto+"'"),4)	
									
			Case 'PED'	/* Pedidos */	
				ivds_pesquisa.Of_AppendWhere_SubQuery(" NOT " + lvs_log_pedidos, 2)
				// Insere consistencia da s$$HEX1$$e900$$ENDHEX$$rie
				ivds_pesquisa.Of_AppendWhere_SubQuery( (" l1.de_serie = case when lc.cd_conta_fluxo_caixa in (172, 205) then 'A' else 'M' end "),3)	
				// Insere Filtro Situa$$HEX2$$e700e300$$ENDHEX$$o Log
				ivds_pesquisa.Of_AppendWhere_SubQuery( ("l1.id_situacao_log  IN ('P','A') "),3)	
				// Insere Filtro de Ambiente
				ivds_pesquisa.Of_AppendWhere_SubQuery( ("l1.cd_ambiente_sap = '"+ps_ambiente+"'"),3)							
				// Insere Filtro Tipo Docto
				ivds_pesquisa.Of_AppendWhere_SubQuery( ("l1.id_tipo_docto = '"+ps_tipodocto+"'"),3)		
				
				// Acrescenta para segunda parte do UNION
				ivds_pesquisa.Of_AppendWhere_SubQuery(" NOT " + lvs_log_pedidos, 5)
				// Insere consistencia da s$$HEX1$$e900$$ENDHEX$$rie
				ivds_pesquisa.Of_AppendWhere_SubQuery( (" l1.de_serie =  'A' "),6)	
				// Insere Filtro Situa$$HEX2$$e700e300$$ENDHEX$$o Log
				ivds_pesquisa.Of_AppendWhere_SubQuery( ("l1.id_situacao_log  IN ('P','A') "),6)	
				// Insere Filtro de Ambiente
				ivds_pesquisa.Of_AppendWhere_SubQuery( ("l1.cd_ambiente_sap = '"+ps_ambiente+"'"),6)							
				// Insere Filtro Tipo Docto
				ivds_pesquisa.Of_AppendWhere_SubQuery( ("l1.id_tipo_docto = '"+ps_tipodocto+"'"),6)	
				
			Case 'DV', 'CD'	/* DV = Dev. Venda e CD = Cancel. Dev. Venda */
				// N$$HEX1$$e300$$ENDHEX$$o pode existir com a situa$$HEX2$$e700e300$$ENDHEX$$o <P> and <A>		
				ivds_pesquisa.Of_AppendWhere_SubQuery(" NOT " +lvs_log_dev_venda, 2)
				 // Insere Filtro Situa$$HEX2$$e700e300$$ENDHEX$$o Log 
				ivds_pesquisa.Of_AppendWhere_SubQuery( ("l1.id_situacao_log  IN ('P','A') "),3)	
				// Insere Filtro de Ambiente 
				ivds_pesquisa.Of_AppendWhere_SubQuery( ("l1.cd_ambiente_sap = '"+ps_ambiente+"'"),3)								
				// Insere Filtro Tipo Docto 
				ivds_pesquisa.Of_AppendWhere_SubQuery( ("l1.id_tipo_docto = '"+ps_tipodocto+"'"),3)		 
	
			Case else	
				// N$$HEX1$$e300$$ENDHEX$$o pode existir com a situa$$HEX2$$e700e300$$ENDHEX$$o <P> and <A>		
				ivds_pesquisa.Of_AppendWhere_SubQuery(" NOT " +lvs_log_venda, 2)
				 // Insere Filtro Situa$$HEX2$$e700e300$$ENDHEX$$o Log 
				ivds_pesquisa.Of_AppendWhere_SubQuery( ("l1.id_situacao_log  IN ('P','A') "),3)	
				// Insere Filtro de Ambiente 
				ivds_pesquisa.Of_AppendWhere_SubQuery( ("l1.cd_ambiente_sap = '"+ps_ambiente+"'"),3)								
				// Insere Filtro Tipo Docto 
				ivds_pesquisa.Of_AppendWhere_SubQuery( ("l1.id_tipo_docto IN ('"+IIF(ps_tipodocto='VD', "VD','NFS", IIF(ps_tipodocto='CV', "CV','CFS",ps_tipodocto) )+"')"),3)		 
			End Choose
		
	Case 2 /* Todos = Doctos Integrados e n$$HEX1$$e300$$ENDHEX$$o Integrados - Neste caso a parte de Log n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ adicionada */ 
		Choose Case ps_tipodocto
			Case 'CV','CD','CA'	  /* Itens que tem cancelamento */
		 		ivds_pesquisa.Of_AppendWhere_SubQuery(" n.dh_cancelamento is not null ", 2)
		End Choose
		
End Choose

/*== Final Inclus$$HEX1$$e300$$ENDHEX$$o na Query Tratamento do LOG por Tipo de Documento  ==*/

lvs_SQL = ivds_pesquisa.Object.DataWindow.Table.Select
ClipBoard(lvs_SQL+'/*'+ivds_pesquisa.dataobject+'*/')
Return True			
end function

public function boolean wf_popula_tela (date pdt_inicio, date pdt_fim, integer pl_filial, string ps_tipodocto, string ps_ambiente);Long lvl_TotReg

lvl_TotReg = ivds_pesquisa.retrieve(pdt_Inicio,pdt_Fim,pl_Filial, ps_tipodocto,ps_ambiente)
If lvl_TotReg = -1 then
	     MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Erro ao Recuperar as Informa$$HEX2$$e700f500$$ENDHEX$$es - Tipo Docto:  "+ps_tipodocto + ". Favor informar $$HEX1$$e000$$ENDHEX$$ TI")
		Return False
End If
		
If lvl_TotReg > 0  then 
	If ivds_pesquisa.RowsCopy(1, lvl_TotReg, Primary!, dw_2, 1, Primary!) = -1 then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Erro ao copiar as informa$$HEX2$$e700f500$$ENDHEX$$es para Exibi$$HEX2$$e700e300$$ENDHEX$$o")
		Return False
	End If
	//Limpa obj (Clean memory)
	ivds_pesquisa.rowsdiscard( 1, lvl_TotReg, primary!)
End If

Return True



end function

on w_ge487_rel_doctos_nao_exp_sybase.create
int iCurrent
call super::create
this.uo_1=create uo_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.uo_1
end on

on w_ge487_rel_doctos_nao_exp_sybase.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.uo_1)
end on

event ue_preopen;call super::ue_preopen;String lvs_Datasource
Integer lvi_linhas

//Conex$$HEX1$$e300$$ENDHEX$$o com BD Sybase em producao.
uoi_transacao_SYB = Create dc_uo_transacao
uoi_transacao_SYB = Sqlca

//dw_1.getchild( 'id_tipo_docto', dwc_tipo_doc)
//dwc_tipo_doc.settransobject( uoi_transacao_SYB ) 

//lvi_linhas = dwc_tipo_doc.retrieve(1)

ivo_filial 						= Create uo_filial 		
ivds_pesquisa 				= Create dc_uo_ds_base	

//Dimensionamento de tela
Maxheight = 9999
ivl_largura_1 = 4750
ivl_largura_2 = 3800

This.ivm_Menu.ivb_Permite_Imprimir = True
end event

event close;call super::close;If IsValid(ivo_filial) 					then Destroy ivo_filial
If Isvalid(ivds_pesquisa)				then Destroy(ivds_pesquisa)
If IsValid(dw_3) 	  					then Destroy dw_3


end event

event ue_postopen;call super::ue_postopen;
ivs_Ambiente								= ProfileString(gvo_aplicacao.ivs_arquivo_ini,"TDF", "Ambiente", "XXX")
dw_1.Object.dt_inicio	[1]  				= RelativeDate( Today(), -1)
dw_1.Object.dt_fim[1] 					= Today()
dw_1.Object.id_movimento [1] 		= 'T' 
dw_1.Object.id_situacao	[1]				= 'T'
dw_1.Object.id_exporta 	[1]				= 1    	/* Integrado no SAP / 1 = N$$HEX1$$e300$$ENDHEX$$o Integrado SAP  / 2 = Todos */

//Usar$$HEX1$$e100$$ENDHEX$$ o ambiente em que estiver Logado 
If Lower(SqlCa.DataBase ) = 'central'  then
	dw_1.Object.cd_ambiente_sap	[1] 	= 'PRD' 
else	
     dw_1.Object.cd_ambiente_sap	[1] 	= 'PPR' 	/* Default Ambiente Pr$$HEX1$$e900$$ENDHEX$$-Produ$$HEX2$$e700e300$$ENDHEX$$o //ivs_Ambiente */
End If

dw_1.Object.cd_empresa [1] 			= 2        /* Clamed */
dw_1.Object.id_tipo_docto [1]			= 'VD'

dw_2.SetTransObject(uoi_transacao_SYB)

ivo_filial.of_Inicializa()

dw_2.InsertRow(0)
dw_1.SetFocus()



end event

event ue_saveas;call super::ue_saveas;SetPointer(HourGlass!)

dw_2.Event ue_SaveAs()
		
SetPointer(Arrow!)
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge487_rel_doctos_nao_exp_sybase
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge487_rel_doctos_nao_exp_sybase
integer x = 78
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge487_rel_doctos_nao_exp_sybase
integer x = 23
integer y = 452
integer width = 5563
integer height = 1712
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge487_rel_doctos_nao_exp_sybase
integer x = 23
integer width = 5563
integer height = 436
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge487_rel_doctos_nao_exp_sybase
integer y = 88
integer width = 5179
integer height = 344
string dataobject = "dw_ge487_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;Long lvl_cd_filial

Choose Case dwo.name 
	Case "nm_filial" 
		If Trim(Data) <> "" Then
			If Data <> ivo_filial.Nm_Fantasia Then
				Return 1
			End If	
		Else	
			ivo_filial.of_inicializa()		
			This.Object.Cd_Filial[Row] 	= ivo_Filial.Cd_Filial
			This.Object.nm_filial[Row] 	= ivo_Filial.Nm_Fantasia		

		End If		
	
	Case "id_tipo_docto"
	   Choose Case trim(data)
			Case 'CV','CD', 'CA'   // Cancelamento de Vendas ou Cancelamento de Devolu$$HEX2$$e700e300$$ENDHEX$$o ou Anexa Cancelamento 
				This.Object.id_situacao [Row] = 'S'  // For$$HEX1$$e700$$ENDHEX$$ar$$HEX1$$e100$$ENDHEX$$ itens apenas cancelados
			Case 'RZ', 'RC'
				This.Object.id_situacao [Row] = 'N'  // For$$HEX1$$e700$$ENDHEX$$ar$$HEX1$$e100$$ENDHEX$$ itens N$$HEX1$$e300$$ENDHEX$$o Cancelados - Redu$$HEX2$$e700e300$$ENDHEX$$o Z n$$HEX1$$e300$$ENDHEX$$o tem Cancelamento
	   End Choose 
		
//	   Case "cd_ambiente_sap "
//			Choose Case trim(data)
//				Case 'PPR'   // Selecionou Homologa$$HEX2$$e700e300$$ENDHEX$$o 
//					If Lower( SqlCa.DataBase ) = 'central' then
//						This.Object.cd_ambiente_sap [Row] = 'PRD'  // For$$HEX1$$e700$$ENDHEX$$ar$$HEX1$$e100$$ENDHEX$$ Ambiente Produ$$HEX2$$e700e300$$ENDHEX$$o
//						MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Voc$$HEX1$$ea00$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ logado em Produ$$HEX1$$e700$$ENDHEX$$ao - ser$$HEX1$$e100$$ENDHEX$$ permitido apenas ~rAmbiente: PRD',StopSign!)
//						Return
//					End If	
//				Case 'PRD'  // Selecionou Produ$$HEX2$$e700e300$$ENDHEX$$o
//					If Lower( SqlCa.DataBase ) = 'homologa' then
//						This.Object.cd_ambiente_sap [Row] = 'PPR'  // For$$HEX1$$e700$$ENDHEX$$ar$$HEX1$$e100$$ENDHEX$$ Ambiente Homologa$$HEX2$$e700e300$$ENDHEX$$o
//						MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Voc$$HEX1$$ea00$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ logado em Homologa$$HEX2$$e700e300$$ENDHEX$$o -  ser$$HEX1$$e100$$ENDHEX$$ permitido apenas ~rAmbiente: PPR',StopSign!)
//						Return
//					End If					
//			End Choose 	
		
	Case 'id_situacao'
		If trim(data) <> 'S' then /* S =  Apenas Canceladas  */
		    Choose Case this.Object.id_tipo_docto [Row] 
				Case   'CV'  // Cancelamento de Vendas
					This.Object.id_situacao [Row] = 'S'  // For$$HEX1$$e700$$ENDHEX$$ar$$HEX1$$e100$$ENDHEX$$ itens apenas cancelados
					MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Para Tipo de Docto =  Venda Cancelamento s$$HEX1$$f300$$ENDHEX$$ ser$$HEX1$$e100$$ENDHEX$$ permitido ~rSitua$$HEX2$$e700e300$$ENDHEX$$o: Cancelada.',StopSign!)
					Return
				Case 'CD'
					This.Object.id_situacao [Row] = 'S'  // For$$HEX1$$e700$$ENDHEX$$ar$$HEX1$$e100$$ENDHEX$$ itens apenas cancelados
					MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Para Tipo de Docto =  Devolu$$HEX2$$e700e300$$ENDHEX$$o Venda Cancelamento s$$HEX1$$f300$$ENDHEX$$ ser$$HEX1$$e100$$ENDHEX$$ permitido ~rSitua$$HEX2$$e700e300$$ENDHEX$$o: Cancelada.',StopSign!)
					Return
				Case 'CA'  
					This.Object.id_situacao [Row] = 'S'  // For$$HEX1$$e700$$ENDHEX$$ar$$HEX1$$e100$$ENDHEX$$ itens apenas cancelados
					MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Para Tipo de Docto =  Anexa Cancelamento s$$HEX1$$f300$$ENDHEX$$ ser$$HEX1$$e100$$ENDHEX$$ permitido ~rSitua$$HEX2$$e700e300$$ENDHEX$$o: Cancelada.',StopSign!)
					Return
				Case 'RZ' , 'RC' 
					If this.Object.id_tipo_docto [Row] = 'T' then
						This.Object.id_situacao [Row] = 'N'  // For$$HEX1$$e700$$ENDHEX$$ar$$HEX1$$e100$$ENDHEX$$ itens N$$HEX1$$e300$$ENDHEX$$o Cancelados
					End If					
			End Choose		
		
		else  /* Canceladas  */
			Choose Case this.Object.id_tipo_docto [Row] 
				Case 'RZ'  /* Redu$$HEX2$$e700e300$$ENDHEX$$o Z n$$HEX1$$e300$$ENDHEX$$o tem Canceladas */
					This.Object.id_situacao [Row] = 'N'  // For$$HEX1$$e700$$ENDHEX$$ar$$HEX1$$e100$$ENDHEX$$ itens apenas N$$HEX1$$e300$$ENDHEX$$o Canceladas
					MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Para Tipo de Docto =  Redu$$HEX2$$e700e300$$ENDHEX$$o Z s$$HEX1$$f300$$ENDHEX$$ ser$$HEX1$$e100$$ENDHEX$$ permitido ~rSitua$$HEX2$$e700e300$$ENDHEX$$o: N$$HEX1$$e300$$ENDHEX$$o Cancelada.',StopSign!)
					Return
				Case 'RC'  /* Recarga n$$HEX1$$e300$$ENDHEX$$o tem Canceladas */
					This.Object.id_situacao [Row] = 'N'  // For$$HEX1$$e700$$ENDHEX$$ar$$HEX1$$e100$$ENDHEX$$ itens apenas N$$HEX1$$e300$$ENDHEX$$o Canceladas
					MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Para Tipo de Docto =  Recarga s$$HEX1$$f300$$ENDHEX$$ ser$$HEX1$$e100$$ENDHEX$$ permitido ~rSitua$$HEX2$$e700e300$$ENDHEX$$o: N$$HEX1$$e300$$ENDHEX$$o Cancelada.',StopSign!)
					Return	
			End Choose				
		End If
		
//	Case "cd_empresa"
//		If not wf_altera_bd(Long(Data)) Then
//			MessageBox('Falha!','N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel conectar o banco de dados da empresa selecionada. ~r~nA tela "'+Parent.Title+'" ser$$HEX1$$e100$$ENDHEX$$ encerrrada.',StopSign!)
//			Close(Parent)
//			Return
//		End if
	
End Choose
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_filial) Then
	This.Object.nm_filial [1]	= ivo_filial.Nm_Fantasia
End If




end event

event dw_1::ue_addrow;Integer lvi_linhas

This.InsertRow(0)

This.Object.dt_inicio	[1] = RelativeDate(Today(),-6)
This.Object.dt_fim		[1] = RelativeDate(Today(),-1)
This.Object.cd_ambiente_sap [1] = 'PPR' // Default Ambiente Pr$$HEX1$$e900$$ENDHEX$$-Produ$$HEX2$$e700e300$$ENDHEX$$o
This.Object.id_exporta [1] = 1  // Default Itens n$$HEX1$$e300$$ENDHEX$$o Exportados

Return 1
end event

event dw_1::ue_key;call super::ue_key;Long   lvl_Empresa
String lvs_Filial

If Key = KeyEnter! Then
	dw_1.Accepttext( )
	lvl_Empresa = dw_1.Object.cd_empresa [1]
	Choose Case This.GetColumnName()
		Case "nm_filial" 
			lvs_filial =dw_1.GetText()
			ivo_filial.of_localiza_filial(lvs_filial)

			If ivo_filial.localizada Then
				
				Choose Case ivo_filial.cd_filial 
					Case 1 	   
						ivo_Filial.Cd_Filial = 100  /* ESTOQUE CENTRAL  */
					Case 534 	
						ivo_Filial.Cd_Filial = 100 /* ESTOQUE CENTRAL  */
					Case 2 		
						ivo_Filial.Cd_Filial = 534 /* MATRIZ E MANIP. JOINVILLE */
					Case 688	
						ivo_Filial.Cd_Filial = 534 // MATRIZ E MANIP. JOINVILLE
					Case 809 	
						ivo_Filial.Cd_Filial = 790 // FARMAGORA
					Case 695 	
						ivo_Filial.Cd_Filial = 149 //JOINVILLE_DE
					Case 696 	
						ivo_Filial.Cd_Filial = 84 //JARAGUA_DE
					Case 699
						ivo_Filial.Cd_Filial = 301 //DE_FLORIPA
					Case 700 	
						ivo_Filial.Cd_Filial = 136 //BLUMENAU_DE
					Case 701 	
						ivo_Filial.Cd_Filial = 107 //CRICIUMA_DE
					Case 704 	
						ivo_Filial.Cd_Filial = 71 //ITAJAI_DE
					Case 705 	
						ivo_Filial.Cd_Filial = 42 //LAGES_DE
					Case 708 	
						ivo_Filial.Cd_Filial = 550 //TUBAR$$HEX1$$c300$$ENDHEX$$O_DE
					Case 709 	
						ivo_Filial.Cd_Filial = 592 //BALNEARIO CAMBORIU_DE     
					Case 712 	
						ivo_Filial.Cd_Filial = 39 //CHAPECO_DE
					Case 733 	
						ivo_Filial.Cd_Filial = 330 //GASPAR_DE					
				End Choose 
						
				dw_1.Object.cd_filial[1]  = ivo_filial.cd_filial 
				dw_1.Object.nm_filial[1] = ivo_filial.nm_fantasia
			End If			
	End Choose
End If
end event

event dw_1::constructor;call super::constructor;dw_1.Reset()
dw_1.Event ue_AddRow()




end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge487_rel_doctos_nao_exp_sybase
integer y = 512
integer width = 5486
integer height = 1612
string dataobject = "dw_ge487_lista"
boolean hscrollbar = true
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;Long lvl_Filial
Long lvl_Padrao
Long lvl_Empresa
Long lvl_Tipodocto
Long lvl_TotReg
Long lvl_Exportacao

String lvs_Movto
String lvs_Ambiente_Sap
String lvs_Situacao
String lvs_tpdocto
String lvs_log
String lvs_log_cte, lvs_Tipo_Doc
String lvs_Parametro

Date lvdt_Inicio
Date lvdt_Fim

dw_1.Accepttext( )

ivs_Parametros 	= {''}
ivs_filtro_relatorio = {''}

lvl_Filial 			= dw_1.Object.cd_filial						[1]
lvs_Tipo_Doc		= dw_1.Object.id_tipo_docto				[1]
lvdt_Inicio			= dw_1.Object.dt_inicio						[1]
lvdt_Fim				= dw_1.Object.dt_fim							[1]
lvl_Empresa			= dw_1.Object.cd_empresa					[1]
lvs_Ambiente_Sap	= dw_1.Object.cd_ambiente_sap 			[1]
lvs_Situacao		= dw_1.Object.id_situacao 					[1]  /* T = Todas / S = Canceladas / N = N$$HEX1$$e300$$ENDHEX$$o Canceladas  */
lvl_Exportacao		= dw_1.Object.id_exporta 					[1]	  /* 0 = Integrado no SAP / 1 = N$$HEX1$$e300$$ENDHEX$$o Integrado SAP  / 2 = Todos */

//Valida par$$HEX1$$e200$$ENDHEX$$metros
If IsNull(lvdt_Inicio) or (lvdt_Inicio <= Date('2000/01/01')) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe uma data de in$$HEX1$$ed00$$ENDHEX$$cio v$$HEX1$$e100$$ENDHEX$$lida", Exclamation!)
	dw_1.Event ue_Pos(1, "dt_inicio")
	Return -1
End If

If IsNull(lvdt_Fim) or (lvdt_Fim <= Date('2000/01/01')) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe uma data de fim v$$HEX1$$e100$$ENDHEX$$lida", Exclamation!)
	dw_1.Event ue_Pos(1, "dt_fim")
	Return -1
End If

If  lvdt_Fim < lvdt_Inicio Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Data Final deve ser Maior do que Data Inicial", Exclamation!)
	dw_1.Event ue_Pos(1, "dt_fim")
	Return -1
End If

//Valida datas anteriores a limpeza do log
uo_Parametro_Geral lvo_Parametro
lvo_Parametro = Create uo_Parametro_Geral
lvo_Parametro.of_localiza_parametro("DH_LIMPA_LOG_EXPORTACAO_DOCTO", ref lvs_Parametro)
Destroy(lvo_Parametro)

If lvdt_Inicio < Date(lvs_Parametro) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Data de in$$HEX1$$ed00$$ENDHEX$$cio n$$HEX1$$e300$$ENDHEX$$o pode ser menor que a data do $$HEX1$$fa00$$ENDHEX$$ltimo expurgo do log de exporta$$HEX2$$e700e300$$ENDHEX$$o de documentos.~r~n~r~n$$HEX1$$da00$$ENDHEX$$ltimo expurgo em: '"+ lvs_Parametro +"'",Exclamation!)
	dw_1.Event ue_Pos(1, "dt_inicio")
	Return -1
End If 

If DaysAfter(lvdt_Inicio,lvdt_Fim) > 31 Then
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O per$$HEX1$$ed00$$ENDHEX$$odo informado $$HEX1$$e900$$ENDHEX$$ superior a 31 dias.~rEssa opera$$HEX2$$e700e300$$ENDHEX$$o poder$$HEX1$$e100$$ENDHEX$$ demorar v$$HEX1$$e100$$ENDHEX$$rias horas.~r~rDeseja continuar?", Exclamation!, YesNo!, 2) = 2 Then 
		dw_1.Event ue_Pos(1, "dt_fim")
		Return -1
	End If
End If	

If  IsNull(lvl_Filial) and DaysAfter(lvdt_Inicio,lvdt_Fim) > 3 Then
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Sele$$HEX2$$e700e300$$ENDHEX$$o de todas as Filiais e Per$$HEX1$$ed00$$ENDHEX$$odo informado superior $$HEX1$$e000$$ENDHEX$$ 3 dias.~rEssa opera$$HEX2$$e700e300$$ENDHEX$$o poder$$HEX1$$e100$$ENDHEX$$ demorar.~r~rDeseja continuar?", Exclamation!, YesNo!, 2) = 2 Then 
		dw_1.Event ue_Pos(1, "cd_filial")
		Return -1
	End If	
End If	
  
 If  IsNull(lvl_Filial)  Then
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi selecionado Filial Espec$$HEX1$$ed00$$ENDHEX$$fica.~rDeseja continuar com extra$$HEX2$$e700e300$$ENDHEX$$o para Todas Filiais ?", Exclamation!, YesNo!, 2) = 2 Then 
		dw_1.Event ue_Pos(1, "cd_filial")
		Return -1
	End If	
End If	 

If lvs_Ambiente_Sap = 'XXX' then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informar o Ambiente onde ser$$HEX1$$e300$$ENDHEX$$o verificadas as Exporta$$HEX2$$e700f500$$ENDHEX$$es.", Exclamation!)
	dw_1.Event ue_Pos(1, "cd_ambiente_sap")
	Return -1
End If	

If isnull(lvs_Tipo_Doc)  then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um tipo de Documento", Exclamation!)
	dw_1.Event ue_Pos(1, "id_tipo_docto")
	Return -1
End If	

 If  lvs_Tipo_Doc = 'TODOS'  Then
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Ser$$HEX1$$e300$$ENDHEX$$o processados TODOS os tipos de Documentos. ~rEste processamento poder$$HEX1$$e100$$ENDHEX$$ demorar. ~rDeseja continuar a extra$$HEX2$$e700e300$$ENDHEX$$o para Todos Documentos ?", Exclamation!, YesNo!, 2) = 2 Then 
			dw_1.Event ue_Pos(1, "id_tipo_docto")
			Return -1
		End If	
  	End If	 

// Atribuindo o texto do filtro de per$$HEX1$$ed00$$ENDHEX$$odo para exibi$$HEX2$$e700e300$$ENDHEX$$o no relat$$HEX1$$f300$$ENDHEX$$rio
This.ivs_filtro_relatorio[UpperBound(This.ivs_filtro_relatorio)+1] = 'Per$$HEX1$$ed00$$ENDHEX$$odo:'+ String(lvdt_Inicio,'DD/MM/YYYY')+ ' $$HEX1$$e000$$ENDHEX$$ ' + String(lvdt_Fim,'DD/MM/YYYY')  

Return AncestorReturnValue
end event

event dw_2::constructor;call super::constructor;
//Compartilha dados com dw de relat$$HEX1$$f300$$ENDHEX$$rio
This.ShareData(dw_3)
This.of_SetRowSelection( '', 'if(  (not isnull( dh_cancelamento )), rgb(255, 0, 0), if( CurrentRow()=GetRow(), rgb(255,255,255), rgb(0,0,0) ))', False )


end event

event dw_2::getfocus;call super::getfocus;If This.RowCount() > 0 Then
	ivm_Menu.mf_SalvarComo(True)
Else
	ivm_Menu.mf_SalvarComo(False)
End If
end event

event dw_2::ue_postretrieve;//Overhide

Boolean lvb_Habilita = False
Long 	   ll_Linhas

this.accepttext()
ll_Linhas = this.RowCount( )

If ll_Linhas > 0 Then
	This.ScrollToRow(1)
	This.Event RowFocusChanged(1)
	This.SetRow(1)
	This.SetFocus()
	
	lvb_Habilita = True
	
ElseIf ll_Linhas = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.", Information!)
End If

This.ivm_menu.mf_imprimir(lvb_Habilita)
This.ivm_Menu.mf_SalvarComo(lvb_Habilita)

This.ShareData(Parent.dw_3)

Return ll_Linhas



end event

event dw_2::ue_recuperar;//OverRide

String lvs_Movto
String lvs_Ambiente_Sap
String lvs_Situacao
String ls_Mensagem
String lvs_Tipodocto
String lvs_situacao_log 
String lvs_SQL, lvs_estilo, lvs_err, lvs_sintaxe, lvs_Erro, lvs_SQL_NOVO

Long lvl_Filial
Long lvl_Padrao
Long lvl_Empresa
Long ll_Retorno
long  lvl_TotReg

Integer lvi_Exportacao 

Date lvdt_Inicio
Date lvdt_Fim

// Verifica quais os par$$HEX1$$e200$$ENDHEX$$metros informados
Parent.dw_1.AcceptText()
this.reset()

lvl_Filial 			= dw_1.Object.cd_filial					[1]
lvs_Tipodocto 		= dw_1.Object.id_tipo_docto			[1]
lvs_Movto 			= dw_1.Object.id_movimento				[1]  /* Entrada = '1' // Sa$$HEX1$$ed00$$ENDHEX$$da = '2'  */
lvdt_Inicio			= dw_1.Object.dt_inicio					[1]
lvdt_Fim				= dw_1.Object.dt_fim						[1]
lvl_Empresa			= dw_1.Object.cd_empresa				[1]
lvs_Ambiente_Sap	= dw_1.Object.cd_ambiente_sap 		[1]
lvs_Situacao		= dw_1.Object.id_situacao 				[1]  /* T = Todas / S = Canceladas / N = N$$HEX1$$e300$$ENDHEX$$o Canceladas  */
lvi_Exportacao		= dw_1.Object.id_exporta 				[1]	  /* 0 = Integrado no SAP / 1 = N$$HEX1$$e300$$ENDHEX$$o Integrado SAP  / 2 = Todos */
		
ivm_menu.mf_imprimir(False)

Choose Case lvs_Tipodocto
	Case 'TODOS'	  /* Executar$$HEX1$$e100$$ENDHEX$$ todas as datastores - Extra$$HEX2$$e700e300$$ENDHEX$$o de Todos os Tipos de Documentos */
		SetPointer(HourGlass!)
		/*Venda - VD */ 
		lvs_Tipodocto = 'VD'
		If not wf_muda_datastore(lvs_Tipodocto) then return -1
		If not wf_trata_log(lvi_Exportacao, lvs_Tipodocto, lvs_Ambiente_Sap, lvs_Situacao) then return -1
		If not wf_popula_tela(lvdt_Inicio,lvdt_Fim,lvl_Filial, lvs_Tipodocto,lvs_Ambiente_Sap) then return -1 
		/* Cancelamento de Venda - CV  */	
		lvs_Tipodocto = 'CV'
		If not wf_muda_datastore(lvs_Tipodocto) then return -1
		If not wf_trata_log(lvi_Exportacao, lvs_Tipodocto, lvs_Ambiente_Sap, lvs_Situacao) then return -1
		If not wf_popula_tela(lvdt_Inicio,lvdt_Fim,lvl_Filial, lvs_Tipodocto,lvs_Ambiente_Sap) then return -1 
		/* Devolu$$HEX2$$e700e300$$ENDHEX$$o Venda - DV */
		lvs_Tipodocto = 'DV'
		If not wf_muda_datastore(lvs_Tipodocto) then return -1
		If not wf_trata_log(lvi_Exportacao, lvs_Tipodocto, lvs_Ambiente_Sap, lvs_Situacao) then return -1
		If not wf_popula_tela(lvdt_Inicio,lvdt_Fim,lvl_Filial, lvs_Tipodocto,lvs_Ambiente_Sap) then return -1 
		/* Devolu$$HEX2$$e700e300$$ENDHEX$$o Venda Cancelamento - CD */	
		lvs_Tipodocto = 'CD'
		If not wf_muda_datastore(lvs_Tipodocto) then return -1
		If not wf_trata_log(lvi_Exportacao, lvs_Tipodocto, lvs_Ambiente_Sap, lvs_Situacao) then return -1
		If not wf_popula_tela(lvdt_Inicio,lvdt_Fim,lvl_Filial, lvs_Tipodocto,lvs_Ambiente_Sap) then return -1 
		/* Anexa - AN */ 
		lvs_Tipodocto = 'AN'
		If not wf_muda_datastore(lvs_Tipodocto) then return -1
		If not wf_trata_log(lvi_Exportacao, lvs_Tipodocto, lvs_Ambiente_Sap, lvs_Situacao) then return -1
		If not wf_popula_tela(lvdt_Inicio,lvdt_Fim,lvl_Filial, lvs_Tipodocto,lvs_Ambiente_Sap) then return -1 
		/* Anexa Cancelamento  - CA */
		lvs_Tipodocto = 'CA'
		If not wf_muda_datastore(lvs_Tipodocto) then return -1
		If not wf_trata_log(lvi_Exportacao, lvs_Tipodocto, lvs_Ambiente_Sap, lvs_Situacao) then return -1
		If not wf_popula_tela(lvdt_Inicio,lvdt_Fim,lvl_Filial, lvs_Tipodocto,lvs_Ambiente_Sap) then return -1 
		/* Redu$$HEX2$$e700e300$$ENDHEX$$o Z - RZ */
		lvs_Tipodocto = 'RZ'
		If not wf_muda_datastore(lvs_Tipodocto) then return -1
		If not wf_trata_log(lvi_Exportacao, lvs_Tipodocto, lvs_Ambiente_Sap, lvs_Situacao) then return -1
		If not wf_popula_tela(lvdt_Inicio,lvdt_Fim,lvl_Filial, lvs_Tipodocto,lvs_Ambiente_Sap) then return -1 
  		/* Recarga - RC */
		 lvs_Tipodocto = 'RC'
		 If not wf_muda_datastore(lvs_Tipodocto) then return -1
		If not wf_trata_log(lvi_Exportacao, lvs_Tipodocto, lvs_Ambiente_Sap, lvs_Situacao) then return -1
		If not wf_popula_tela(lvdt_Inicio,lvdt_Fim,lvl_Filial, lvs_Tipodocto,lvs_Ambiente_Sap) then return -1  
		/*  Caixa - CX */	
		lvs_Tipodocto = 'CX'
		If not wf_muda_datastore(lvs_Tipodocto) then return -1
		If not wf_trata_log(lvi_Exportacao, lvs_Tipodocto, lvs_Ambiente_Sap, lvs_Situacao) then return -1
		If not wf_popula_tela(lvdt_Inicio,lvdt_Fim,lvl_Filial, lvs_Tipodocto,lvs_Ambiente_Sap) then return -1 
         /* Invers$$HEX1$$e300$$ENDHEX$$o Posi$$HEX2$$e700e300$$ENDHEX$$o - Cheque e Cart$$HEX1$$e300$$ENDHEX$$o - POS*/
		lvs_Tipodocto = 'POS'
		If not wf_muda_datastore(lvs_Tipodocto) then return -1
		If not wf_trata_log(lvi_Exportacao, lvs_Tipodocto, lvs_Ambiente_Sap, lvs_Situacao) then return -1
		If not wf_popula_tela(lvdt_Inicio,lvdt_Fim,lvl_Filial, lvs_Tipodocto,lvs_Ambiente_Sap) then return -1 	
        /* Pagamento - Cheque/Conta/T$$HEX1$$ed00$$ENDHEX$$tulo - PGT	*/
		lvs_Tipodocto = 'PGT'
		If not wf_muda_datastore(lvs_Tipodocto) then return -1
		If not wf_trata_log(lvi_Exportacao, lvs_Tipodocto, lvs_Ambiente_Sap, lvs_Situacao) then return -1
		If not wf_popula_tela(lvdt_Inicio,lvdt_Fim,lvl_Filial, lvs_Tipodocto,lvs_Ambiente_Sap) then return -1 
		
		SetPointer(Arrow!)
		
	Case else  /* Sele$$HEX2$$e700e300$$ENDHEX$$o individual por Tipo de Documento */
		// Carregar$$HEX1$$e100$$ENDHEX$$ a datastore referente ao Tipo de Docto selecionado, e copiar$$HEX1$$e100$$ENDHEX$$ as linhas para dw_2
		If not wf_muda_datastore(lvs_Tipodocto) then return -1
		If not wf_trata_log(lvi_Exportacao, lvs_Tipodocto, lvs_Ambiente_Sap,  lvs_Situacao) then return -1
		If not wf_popula_tela(lvdt_Inicio,lvdt_Fim,lvl_Filial, lvs_Tipodocto,lvs_Ambiente_Sap) then return -1 	
End Choose

This.SetRedraw(true)
Return ll_Retorno
end event

event dw_2::ue_printimmediate;
//Override
dw_3.Event ue_Print()


end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge487_rel_doctos_nao_exp_sybase
integer x = 4224
integer y = 968
string dataobject = "dw_ge487_relatorio"
boolean ivb_ordena_colunas = true
end type

event dw_3::constructor;call super::constructor;This.Visible = False
end event

event dw_3::ue_preprint;call super::ue_preprint;Date lvdt_Inicio
Date lvdt_Termino
String lvs_desc_exportacao, lvs_Situacao, lvs_desc_sit, lvs_desc_tpo_docto
Integer lvi_exportacao
		
// Verifica quais os par$$HEX1$$e200$$ENDHEX$$metros informados
Parent.dw_1.AcceptText()

lvdt_Inicio				= 	dw_1.Object.dt_inicio	 	[1]
lvdt_Termino			= 	dw_1.Object.dt_fim	 	[1]
lvs_Situacao				=  dw_1.Object.id_situacao [1]  /* T = Todas / S = Canceladas / N = N$$HEX1$$e300$$ENDHEX$$o Canceladas  */
lvi_Exportacao			=  dw_1.Object.id_exporta  [1]  /* 0 = Integrado no SAP / 1 = N$$HEX1$$e300$$ENDHEX$$o Integrado SAP  / 2 = Todos */
lvs_desc_tpo_docto 	=  dw_1.Describe ("Evaluate('LookupDisplay(id_tipo_docto)', " + String(1) + ")")
lvs_desc_sit				= 	dw_1.Describe ("Evaluate('LookupDisplay(id_situacao)', " + String(1) + ")")
lvs_desc_exportacao	=  dw_1.Describe ("Evaluate('LookupDisplay(id_exporta)', " + String(1) + ")")

This.Object.img_logo.Visible 	= (gvo_parametro.cd_filial = gvo_parametro.cd_filial_matriz)
This.Object.st_periodo.Text 	= "Per$$HEX1$$ed00$$ENDHEX$$odo: "+String(lvdt_Inicio,'dd/mm/yyyy')+' $$HEX1$$e000$$ENDHEX$$ '+String(lvdt_Termino,'dd/mm/yyyy')
This.Object.st_parametros.Text = "Par$$HEX1$$e200$$ENDHEX$$metros: Tipo Docto: "+ lvs_desc_tpo_docto + " / Situa$$HEX2$$e700e300$$ENDHEX$$o Exporta$$HEX2$$e700e300$$ENDHEX$$o: "+lvs_desc_exportacao+" / Situa$$HEX2$$e700e300$$ENDHEX$$o Documento: "+lvs_desc_sit  

Return AncestorReturnValue
end event

event dw_3::ue_saveas;//override

SUPER::EVENT ue_SaveAs()
end event

event dw_3::ue_print;
This.Print()



end event

type uo_1 from uo_data_atual within w_ge487_rel_doctos_nao_exp_sybase
integer x = 5088
integer y = 56
integer taborder = 10
boolean bringtotop = true
end type

on uo_1.destroy
call uo_data_atual::destroy
end on

