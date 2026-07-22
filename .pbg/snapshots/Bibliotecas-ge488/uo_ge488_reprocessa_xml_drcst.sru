HA$PBExportHeader$uo_ge488_reprocessa_xml_drcst.sru
forward
global type uo_ge488_reprocessa_xml_drcst from nonvisualobject
end type
end forward

global type uo_ge488_reprocessa_xml_drcst from nonvisualobject
end type
global uo_ge488_reprocessa_xml_drcst uo_ge488_reprocessa_xml_drcst

type variables
uo_tratamento_fiscal 			ivo_Fiscal		//GE021
uo_atributo_fiscal_item_nf	ivo_atributo		//GE021
uo_produto						ivo_produto		//GE001
uo_tributacao_icms			ivo_trib_icms	//GE021
end variables

forward prototypes
public function boolean of_diretorio_arquivo_xml (ref string as_diretorio_xml, ref string as_erro)
public subroutine of_grava_erro (string as_chave_acesso, string as_erro)
public function boolean of_exclui_arquivo_xml (string as_dir_arquivo_xml, ref string as_erro)
public function boolean of_localiza_codigo_produto (string as_cnpj_emitente, string as_ean, string as_ean_trib, string as_produto_xml, string as_fornecedor, long al_filial, ref long al_produto, ref string as_erro)
public function boolean of_dados_nota (string as_chave_acesso, ref datetime adh_emissao, ref string as_tipo_nota, ref long al_filial, ref string as_fornecedor, ref string as_erro)
public function boolean of_insere_cabecalho (string as_chave_acesso, t_infnfe at_infnfe, datetime adh_emissao, string as_tipo_nf, long al_filial, string as_fornecedor, ref decimal adc_vl_total_produto, ref string as_erro)
public function boolean of_insere_detalhes (t_infnfe at_infnfe, string as_chave_acesso, long al_filial, string as_fornecedor, decimal adc_vl_total_produto, ref string as_erro)
public function boolean of_busca_arquivo_xml (string as_chave_acesso, datetime adh_emissao, string as_diretorio_xml, long al_filial_destino, ref string as_erro)
public function boolean of_localiza_produto_fornecedor (string ps_codigo_barras, string ps_fornecedor, ref long pl_produto)
public subroutine of_reprocessar_xml ()
public subroutine of_reprocessar_xml (string ps_chave_nfe, string ps_arquivo_xml)
public subroutine of_reprocessar_xml (string ps_chave_nfe)
public function boolean of_localiza_natureza_operacao (long al_cfop, ref string as_id_valida_prod_importa_xml, ref string as_erro)
public function boolean of_verifica_destinada (string as_chave_acesso)
public function boolean of_insere_duplicata (t_infnfe at_infnfe, string as_chave_acesso, ref string as_erro)
public function boolean of_insere_emitente (t_infnfe at_infnfe, string as_chave_acesso, ref string as_erro)
end prototypes

public function boolean of_diretorio_arquivo_xml (ref string as_diretorio_xml, ref string as_erro);Try
	as_Diretorio_Xml	= "C:\Sistemas\"+gvo_aplicacao.ivo_seguranca.cd_sistema+"\XML_Notas\"
	
	If Not FileExists(as_Diretorio_Xml) Then
		If CreateDirectory(as_Diretorio_Xml) <> 1 Then
			as_Erro = "Erro ao criar o diret$$HEX1$$f300$$ENDHEX$$rio '"+as_Diretorio_Xml+"'"
			Return False
		End If
	End If
	
Catch ( runtimeerror  lo_rte )
	as_Erro = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_diretorio_arquivo_xml'. Erro: "+lo_rte.GetMessage( )
	Return False		 
End Try	

Return True


end function

public subroutine of_grava_erro (string as_chave_acesso, string as_erro);String	ls_Erro

Try
	update nfe_reprocessada set
		id_status	= 'E',
		de_erro	= :as_Erro
	where de_chave_acesso = :as_Chave_Acesso		
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		ls_Erro = "Erro ao grava o erro: "+SqlCa.SqlErrText
		SqlCa.of_RollBack()
		MessageBox("Erro", ls_Erro)
		Return
	End If
	
	If SqlCa.Sqlnrows <> 1 Then
		as_Erro = "Deveria ter atualizado 1 registro, mas atualizou(zaram) "+String(SqlCa.Sqlnrows)+" ao grava o erro." 
		SqlCa.of_RollBack()
		MessageBox("Erro", ls_Erro)
		Return
	End If
	
	SqlCa.of_Commit()
		
Catch ( runtimeerror  lo_rte )
	as_Erro = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_grava_erro'. Erro: "+lo_rte.GetMessage( )
	MessageBox("Erro", ls_Erro)
	Return		 
End Try


Return
end subroutine

public function boolean of_exclui_arquivo_xml (string as_dir_arquivo_xml, ref string as_erro);If Not FileDelete(as_Dir_Arquivo_Xml) Then
	as_Erro	= "Erro ao excluir o arquivo '"+as_Erro+"'."
	Return False
End If

Return True
end function

public function boolean of_localiza_codigo_produto (string as_cnpj_emitente, string as_ean, string as_ean_trib, string as_produto_xml, string as_fornecedor, long al_filial, ref long al_produto, ref string as_erro);
dc_uo_importa_nf_pedido_eletronico lo_Pedido

Boolean	lb_Erro

Decimal	ldc_Fator_Conversao,&
			ldc_Repasse_Icms,&
			ldc_Icms,&
			ldc_Reducao_Icms,&
			ldc_Pc_Icms_St

Integer	li_Tributacao_Produto

String	ls_Subcategoria,&
		ls_Lei_Generico,&
		ls_Lista_Pis_Cofins,&
		ls_Codigo_SAP

Long	ll_Produto,&
		ll_Qtde
		
Try
	If Mid(as_Cnpj_Emitente, 1, 8) = "84683481" Then
		ll_Produto	= Long(as_Produto_Xml)
	
		select count(1)
		into :ll_Qtde
		from produto_geral
		where cd_produto = :ll_Produto
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			as_Erro	= "Erro ao localizar o c$$HEX1$$f300$$ENDHEX$$digo do produto. "+SqlCa.SqlErrText
			Return False
		End If
		
		If ll_Qtde > 0 Then
			al_Produto	= ll_Produto
			Return True
		End If
	End If
	
	
	lo_Pedido	= Create dc_uo_importa_nf_pedido_eletronico
	
	If (as_Ean<>'SEM GTIN' and as_Ean<>'') or (as_Ean_Trib<>'SEM GTIN' and as_Ean_Trib<>'') Then
		If Not lo_Pedido.of_nosso_codigo_produto("", as_Ean, as_Ean_Trib,as_fornecedor,Ref al_Produto, Ref as_Erro, Ref lb_Erro)	Then
			If lb_Erro Then
				Return False
			End If
		End If
	End If

	//N$$HEX1$$e300$$ENDHEX$$o entrar na fun$$HEX2$$e700e300$$ENDHEX$$o se tiver letra no c$$HEX1$$f300$$ENDHEX$$digo de produto, pois d$$HEX1$$e100$$ENDHEX$$ erro e rollback()
	If gf_coalesce(al_Produto,0)=0 and Trim(as_Produto_Xml)=gf_retorna_so_numeros(as_Produto_Xml) Then
		If Not lo_Pedido.of_nosso_codigo_produto(	as_Produto_Xml,&
																as_Fornecedor,&
																Ref al_Produto,&
																Ref ldc_Fator_Conversao,&
																Ref ldc_Repasse_Icms,&
																Ref ldc_Icms,&
																Ref ldc_Reducao_Icms,&
																al_Filial,&
																Ref li_Tributacao_Produto,&
																Ref ldc_Pc_Icms_St,&
																Ref ls_Subcategoria,&
																Ref ls_Lei_Generico,&
																as_Ean,&
																as_Ean_Trib,&
																Ref ls_Lista_Pis_Cofins,&
																Ref ls_Codigo_SAP,&
																Ref as_Erro) Then
		End If	
	End If
	
	//Existe FK na tabela, n$$HEX1$$e300$$ENDHEX$$o pode inserir com produto = 0, e em erros na fun$$HEX2$$e700e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ retornando zero
	If al_Produto=0 Then SetNull(al_Produto)
	
	//Se n$$HEX1$$e300$$ENDHEX$$o tiver c$$HEX1$$f300$$ENDHEX$$digo de barras v$$HEX1$$e100$$ENDHEX$$lido n$$HEX1$$e300$$ENDHEX$$o adiantar$$HEX1$$e100$$ENDHEX$$ entrar para buscar o produto
	If IsNull(al_Produto) and gf_coalesce(as_Ean_Trib,'')<>'' and Upper(as_Ean_Trib)<>'SEM GTIN' Then
		//Busca se esse c$$HEX1$$f300$$ENDHEX$$digo de barras existe em outras notas reprocessadas com produto preenchido
		This.Of_localiza_produto_fornecedor( as_Ean_Trib, as_Fornecedor, ref al_Produto)
	End If

Catch ( runtimeerror  lo_rte )
	as_Erro = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_localiza_codigo_produto'. Erro: "+lo_rte.GetMessage( )
	Return False	
	
Finally
	If IsValid(lo_Pedido) Then Destroy(lo_Pedido)
End Try	

If IsNull(al_Produto) Then
	as_Erro = "N$$HEX1$$e300$$ENDHEX$$o foi localizado o c$$HEX1$$f300$$ENDHEX$$digo do produto."
	Return False
End If

Return True
end function

public function boolean of_dados_nota (string as_chave_acesso, ref datetime adh_emissao, ref string as_tipo_nota, ref long al_filial, ref string as_fornecedor, ref string as_erro);String	ls_Cnpj_Emitente

Long	ll_Nr_Nf

Date	ldt_Inicio,&
		ldt_Fim

Try
	ldt_Inicio	= Date("01/"+Mid(as_Chave_Acesso, 5, 2)+"/"+Mid(as_Chave_Acesso, 3, 2))
	
	ldt_Fim	= RelativeDate(ldt_Inicio, 31)
	
	ls_Cnpj_Emitente	= Mid(as_Chave_Acesso, 7, 14)
	
	ll_Nr_Nf	= Long(Mid(as_Chave_Acesso, 26, 9))
	
	select top 1
			id_tipo_nf,
			dh_emissao,
			cd_filial,
			cd_fornecedor
	into	:as_Tipo_Nota,
			:adh_Emissao,
			:al_Filial,
			:as_Fornecedor
	from(
	
		select 'TR' as id_tipo_nf,
				b.dh_emissao,
				a.cd_filial_origem as cd_filial,
				null cd_fornecedor
		from nf_transferencia_nfe a
		inner join nf_transferencia b	on		b.cd_filial_origem	= a.cd_filial_origem
												and	b.nr_nf				= a.nr_nf
												and	b.de_especie		= a.de_especie
												and	b.de_serie			= a.de_serie
		where   a.de_chave_acesso = :as_Chave_Acesso
		
		union
		
		select 'DI' as id_tipo_nf,
				b.dh_emissao,
				a.cd_filial_origem as cd_filial,
				null cd_fornecedor
		from nf_diversa_nfe a
		inner join nf_diversa b	on		b.cd_filial_origem	= a.cd_filial_origem
										and	b.nr_nf				= a.nr_nf
										and	b.de_especie		= a.de_especie
										and	b.de_serie			= a.de_serie
		where   a.de_chave_acesso = :as_Chave_Acesso
		
		union
		
		select 'DC' as id_tipo_nf,
				b.dh_emissao,
				a.cd_filial,
				b.cd_fornecedor
		from nf_devolucao_compra_nfe a
		inner join nf_devolucao_compra b	on		b.cd_filial			= a.cd_filial
													and	b.nr_nf				= a.nr_nf
													and	b.de_especie		= a.de_especie
													and	b.de_serie			= a.de_serie
		where  a.de_chave_acesso = :as_Chave_Acesso
		
		union
		
		select 'DV' as id_tipo_nf,
				b.dh_recebimento as dh_emissao,
				a.cd_filial,
				null cd_fornecedor
		from nf_devolucao_venda_nfe a
		inner join nf_devolucao_venda b	on		b.cd_filial			= a.cd_filial
													and	b.nr_nf				= a.nr_nf
													and	b.de_especie		= a.de_especie
													and	b.de_serie			= a.de_serie
		where  a.de_chave_acesso = :as_Chave_Acesso
		
		union
		
		select 'VD' as id_tipo_nf,
				b.dh_emissao,
				a.cd_filial,
				null cd_fornecedor
		from nf_venda_nfe a
		inner join nf_venda b	on		b.cd_filial				= a.cd_filial
											and	b.nr_nf			= a.nr_nf
											and	b.de_especie	= a.de_especie
											and	b.de_serie		= a.de_serie
		where  a.de_chave_acesso = :as_Chave_Acesso
		and a.cd_filial in (	select x.cd_filial 
								from filial x
								where nr_cgc = :ls_Cnpj_Emitente
								//and id_situacao = 'A'
								and cd_filial <> 2)
		and a.nr_nf  = :ll_Nr_Nf 
		and a.de_especie = 'NFE'
		and b.dh_movimentacao_caixa between :ldt_Inicio and :ldt_Fim
		
		union
		
		select 'CO' as id_tipo_nf,
				a.dh_emissao,
				a.cd_filial,
				a.cd_fornecedor
		from nf_compra a
		where a.de_chave_acesso = :as_Chave_Acesso
		
		union
		
		select top 1
				'' as id_tipo_nf,
				a.dh_emissao, 
				coalesce(f1.cd_filial, f2.cd_filial) as cd_filial,
				coalesce(fo1.cd_fornecedor, fo2.cd_fornecedor) as cd_fornecedor
		From nfe_destinadas a
		Left Outer Join filial f1 on f1.nr_cgc = a.nr_cgc_destino and f1.id_situacao='A'
		Left Outer Join filial f2 on f2.nr_cgc = a.nr_cgc_destino
		Left Outer Join fornecedor fo1 on fo1.nr_cgc = a.nr_cgc_origem and coalesce(fo1.id_situacao,'A')='A'
		Left Outer Join fornecedor fo2 on fo2.nr_cgc = a.nr_cgc_origem
		Where a.de_chave_acesso = :as_Chave_Acesso
	) as tudo
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 100
			as_Erro = "N$$HEX1$$e300$$ENDHEX$$o foi localizado os dados da nota com a chave de acesso '"+as_Chave_Acesso+"'."
			Return False
		Case  -1
			as_Erro = "Erro ao localizar os dados da nota com a chave de acesso '"+as_Chave_Acesso+"': "+SqlCa.SqlErrText
			Return False
	End Choose

Catch ( runtimeerror  lo_rte )
	as_Erro = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_dados_nota'. Erro: "+lo_rte.GetMessage( )
	Return False		 
End Try

Return True
end function

public function boolean of_insere_cabecalho (string as_chave_acesso, t_infnfe at_infnfe, datetime adh_emissao, string as_tipo_nf, long al_filial, string as_fornecedor, ref decimal adc_vl_total_produto, ref string as_erro);String	ls_Cnpj_Emitente,&
		ls_Cnpj_Destino,&
		ls_Serie,&
		ls_Chv_Ref,&
		ls_NF_Compl
		
Long	ll_Nr_Nf

Decimal	ldc_Vl_Produto,&
			ldc_Vl_Frete,&
			ldc_Vl_Seguro,&
			ldc_Vl_Desconto,&
			ldc_Vl_Bc_Icms,&
			ldc_Vl_Icms,&
			ldc_Vl_Fcp,&
			ldc_Vl_Bc_Icms_St,&
			ldc_Vl_Icms_St,&
			ldc_Vl_Fcp_St,&
			ldc_Vl_Fcp_St_Ret,&
			ldc_Vl_Ipi,&
			ldc_Vl_Pis,&
			ldc_Vl_Cofins,&
			ldc_Vl_Outros,&
			ldc_Vl_Tot_Nf,&
			ldc_vl_total_is,&
			ldc_vl_total_bc_cbs_ibs,&
			ldc_vl_total_dif_ibs_uf,&
			ldc_vl_total_dev_ibs_uf,&
			ldc_vl_total_ibs_uf,&
			ldc_vl_total_dif_ibs_mun,&
			ldc_vl_total_dev_ibs_mun,&
			ldc_vl_total_ibs_mun,&
			ldc_vl_total_ibs,&
			ldc_vl_total_cred_pres_ibs,&
			ldc_vl_total_cred_pres_sus_ibs,&
			ldc_vl_total_dif_cbs,&
			ldc_vl_total_dev_cbs,&
			ldc_vl_total_cbs,&
			ldc_vl_total_cred_pres_cbs,&
			ldc_vl_total_cred_pres_sus_cbs

Try
	as_Erro = ""
	
	ls_Cnpj_Emitente		= at_InfNfe.emit.CNPJ
	ls_Cnpj_Destino		= at_InfNfe.dest.CNPJ
	ll_Nr_Nf					= at_InfNfe.ide.nNF
	ls_Serie					= at_InfNfe.ide.serie
	ldc_Vl_Produto			= Round(at_InfNfe.total.ICMSTot.vProd, 2)
	ldc_Vl_Frete			= Round(at_InfNfe.total.ICMSTot.vFrete, 2)
	ldc_Vl_Seguro			= Round(at_InfNfe.total.ICMSTot.vSeg, 2)
	ldc_Vl_Desconto		= Round(at_InfNfe.total.ICMSTot.vDesc, 2)
	ldc_Vl_Bc_Icms			= Round(at_InfNfe.total.ICMSTot.vBC, 2)
	ldc_Vl_Icms				= Round(at_InfNfe.total.ICMSTot.vICMS, 2)
	ldc_Vl_Fcp				= Round(at_InfNfe.total.ICMSTot.vFCP, 2)
	ldc_Vl_Bc_Icms_St		= Round(at_InfNfe.total.ICMSTot.vBCST, 2)
	ldc_Vl_Fcp_St			= Round(at_InfNfe.total.ICMSTot.vFCPST, 2)
	ldc_Vl_Fcp_St_Ret		= Round(at_InfNfe.total.ICMSTot.vFCPSTRet, 2)
	ldc_Vl_Ipi				= Round(at_InfNfe.total.ICMSTot.vIPI, 2)
	ldc_Vl_Pis				= Round(at_InfNfe.total.ICMSTot.vPIS, 2)
	ldc_Vl_Cofins			= Round(at_InfNfe.total.ICMSTot.vCOFINS, 2)
	ldc_Vl_Outros			= Round(at_InfNfe.total.ICMSTot.vOutro, 2)
	ldc_Vl_Tot_Nf			= Round(at_InfNfe.total.ICMSTot.vNF, 2)
	ls_NF_Compl				= IIF(at_InfNfe.ide.finNFe=2, 'S', 'N')
	
	ldc_vl_total_is 				= Round(at_InfNfe.total.istot.vis, 2)
	ldc_vl_total_bc_cbs_ibs 	= Round(at_InfNfe.total.IBSCBSTot.vbcibscbs, 2)
	ldc_vl_total_dif_ibs_uf		= Round(at_InfNfe.total.IBSCBSTot.gibs_tot.gibsuf_tot.vdif, 2)
	ldc_vl_total_dev_ibs_uf		= Round(at_InfNfe.total.IBSCBSTot.gibs_tot.gibsuf_tot.vdevtrib, 2)
	ldc_vl_total_ibs_uf			= Round(at_InfNfe.total.IBSCBSTot.gibs_tot.gibsuf_tot.vibsuf, 2)
	ldc_vl_total_dif_ibs_mun	= Round(at_InfNfe.total.IBSCBSTot.gibs_tot.gibsmun_tot.vdif, 2)
	ldc_vl_total_dev_ibs_mun	= Round(at_InfNfe.total.IBSCBSTot.gibs_tot.gibsmun_tot.vdevtrib, 2)
	ldc_vl_total_ibs_mun			= Round(at_InfNfe.total.IBSCBSTot.gibs_tot.gibsmun_tot.vibsmun, 2)
	ldc_vl_total_ibs				= Round(at_InfNfe.total.IBSCBSTot.gibs_tot.vibs, 2)
	ldc_vl_total_dif_cbs 		= Round(at_InfNfe.total.IBSCBSTot.gcbs_tot.vdif, 2)
	ldc_vl_total_dev_cbs			= Round(at_InfNfe.total.IBSCBSTot.gcbs_tot.vdevtrib, 2)
	ldc_vl_total_cbs				= Round(at_InfNfe.total.IBSCBSTot.gcbs_tot.vcbs, 2)
//	ldc_vl_total_cred_pres_cbs
//	ldc_vl_total_cred_pres_sus_cbs
//	ldc_vl_total_cred_pres_ibs
//	ldc_vl_total_cred_pres_sus_ibs

	//Captura a chave referenciada
	If UpperBound(at_InfNfe.ide.nfref.refnfe) > 0 Then
		ls_Chv_Ref = at_InfNfe.ide.nfref.refnfe[1]
	End If
	
	//Seta origem e destino para caso necessite calcular imposto
	ivo_Fiscal.Of_Grava_uf_origem_destino( at_InfNfe.emit.endereco.uf, at_InfNfe.dest.endereco.uf)
	
	update nfe_reprocessada set 
		id_status						= 'P',
		dh_processada					= getDate(),
		dh_emissao						= :adh_Emissao,
		id_tipo_nf						= :as_Tipo_Nf,
		nr_cnpj_cpf_emitente			= :ls_Cnpj_Emitente,
		nr_cnpj_cpf_destino			= :ls_Cnpj_Destino,
		cd_filial						= :al_Filial,
		cd_fornecedor					= :as_Fornecedor,
		nr_nf								= :ll_Nr_Nf,
		de_especie						= 'NFE',
		de_serie							= :ls_Serie,
		vl_produto						= :ldc_Vl_Produto,
		vl_frete							= :ldc_Vl_Frete,
		vl_seguro						= :ldc_Vl_Seguro,
		vl_desconto						= :ldc_Vl_Desconto,
		vl_bc_icms						= :ldc_Vl_Bc_Icms,
		vl_icms							= :ldc_Vl_Icms,
		vl_fcp							= :ldc_Vl_Fcp,
		vl_bc_icms_st					= :ldc_Vl_Bc_Icms_St,
		vl_icms_st						= :ldc_Vl_Icms_St,
		vl_fcp_st						= :ldc_Vl_Fcp_St,
		vl_fcp_st_retido				= :ldc_Vl_Fcp_St_Ret,
		vl_ipi							= :ldc_Vl_Ipi,
		vl_pis							= :ldc_Vl_Pis,
		vl_cofins						= :ldc_Vl_Cofins,
		vl_outros						= :ldc_Vl_Outros,
		vl_total_nf						= :ldc_Vl_Tot_Nf,
		id_nf_complementar			= :ls_NF_Compl,
		de_chave_acesso_ref			= :ls_Chv_Ref,
		de_erro							= null,
		vl_total_is						= :ldc_vl_total_is,
		vl_total_bc_cbs_ibs			= :ldc_vl_total_bc_cbs_ibs,
		vl_total_dif_ibs_uf			= :ldc_vl_total_dif_ibs_uf,
		vl_total_dev_ibs_uf			= :ldc_vl_total_dev_ibs_uf,
		vl_total_ibs_uf				= :ldc_vl_total_ibs_uf,
		vl_total_dif_ibs_mun			= :ldc_vl_total_dif_ibs_mun,
		vl_total_dev_ibs_mun			= :ldc_vl_total_dev_ibs_mun,
		vl_total_ibs_mun				= :ldc_vl_total_ibs_mun,
		vl_total_ibs					= :ldc_vl_total_ibs,
		vl_total_cred_pres_ibs		= :ldc_vl_total_cred_pres_ibs,
		vl_total_cred_pres_sus_ibs = :ldc_vl_total_cred_pres_sus_ibs,
		vl_total_dif_cbs 				= :ldc_vl_total_dif_cbs,
		vl_total_dev_cbs				= :ldc_vl_total_dev_cbs,
		vl_total_cbs					= :ldc_vl_total_cbs,
		vl_total_cred_pres_cbs		= :ldc_vl_total_cred_pres_cbs,
		vl_total_cred_pres_sus_cbs = :ldc_vl_total_cred_pres_sus_cbs
	where de_chave_acesso = :as_Chave_Acesso
				
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		as_Erro = "Erro ao atualizar os dados do cabe$$HEX1$$e700$$ENDHEX$$alho da nota: "+SqlCa.SqlErrText
		Return False
	End If
	
	If SqlCa.Sqlnrows <> 1 Then
		as_Erro = "Deveria ter atualizado 1 registro, mas atualizou(zaram) "+String(SqlCa.Sqlnrows)+" registro(s)." 
		Return False
	End If
	
	adc_vl_Total_Produto	= ldc_Vl_Produto
		
Catch ( runtimeerror  lo_rte )
	as_Erro = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_insere_cabecalho'. Erro: "+lo_rte.GetMessage( )
	Return False		 
End Try

Return True
end function

public function boolean of_insere_detalhes (t_infnfe at_infnfe, string as_chave_acesso, long al_filial, string as_fornecedor, decimal adc_vl_total_produto, ref string as_erro);Long	ll_Item,&
		ll_Linha,&
		ll_Linhas,&
		ll_Nr_Nf,&
		ll_Produto,&
		ll_CFOP, &
		ll_NCM
		
String	ls_Serie,&
		ls_Ean,&
		ls_Ean_Trib,&
		ls_Cd_Prod_Xml,&
		ls_Cod_Barras,&
		ls_De_Produto_Xml,&
		ls_Cest,&
		ls_Unid_Comercial,&
		ls_Cst_Origem,&
		ls_Cst,&
		ls_Cd_Cst_Ipi,&
		ls_Cd_Cst_Pis,&
		ls_Cd_Cst_Cofins,&
		ls_Cnpj_Emitente,&
		ls_Mot_Deson_ICMS,&
		ls_NCM,&
		ls_Erro,&
		ls_Id_Valida_Prod_Importa_Xml,&
		ls_cd_cst_is,&
		ls_cd_classificacao_trib_is,&
		ls_cd_un_trib_is,&
		ls_cd_cst_ibscbs,&
		ls_cd_class_trib_ibscbs,&
		ls_cd_cst_ibscbs_reg,&
		ls_cd_class_trib_ibscbs_reg,&
		ls_cd_class_cred_pres_ibs,&
		ls_cd_class_cred_pres_cbs
		
		
Decimal	ldc_Vl_Produto,&
			ldc_Vl_Desconto,&
			ldc_Vl_Frete,&
			ldc_Vl_Seguro,&
			ldc_Vl_Outras_Desp,&
			ldc_Qt_Comercial,&
			ldc_Pc_Red_Bc,&
			ldc_Vl_Bc_Icms,&
			ldc_Pc_Icms,&
			ldc_Vl_Icms,&
			ldc_Vl_Icms_Deson,&
			ldc_Vl_Bc_Fcp,&
			ldc_Pc_Fcp,&
			ldc_Vl_Fcp,&
			ldc_Pc_Mva_St,&
			ldc_Pc_Red_Icms_St,&
			ldc_Vl_Bc_Icms_St,&
			ldc_Pc_Icms_St,&
			ldc_Vl_Icms_St,&
			ldc_Vl_Bc_Fcp_St,&
			ldc_Pc_Fcp_St,&
			ldc_Vl_Fcp_St,&
			ldc_Vl_Icms_Retido,&
			ldc_Vl_Bc_Icms_St_Retido,&
			ldc_Pc_Icms_St_Retido,&
			ldc_Vl_Icms_St_Retido,&
			ldc_Vl_Bc_Fcp_St_Retido,&
			ldc_Pc_Fcp_St_Retido,&
			ldc_Vl_Fcp_St_Retido,&
			ldc_Vl_Bc_Ipi,&
			ldc_Pc_Ipi,&
			ldc_Vl_Ipi,&
			ldc_Vl_Bc_Pis,&
			ldc_Pc_Pis,&
			ldc_Vl_Pis,&
			ldc_Vl_Bc_Cofins,&
			ldc_Pc_Cofins,&
			ldc_Vl_Cofins,&
			ldc_Vl_Total_Prd_Calculado,&
			ldc_Diferenca_Vl_Produto, &
			ldc_Vl_Bc_St_Calc,&
			ldc_Pc_St_Calc,&
			ldc_Vl_St_Calc,&
			ldc_vl_bc_is,&
			ldc_pc_is,&
			ldc_pc_is_espec,&
			ldc_qt_trib_is,&
			ldc_vl_is,&
			ldc_vl_bc_ibscbs,&
			ldc_vl_ibs,&
			ldc_pc_ibs_uf,&
			ldc_vl_ibs_uf,&
			ldc_pc_dif_ibs_uf,&
			ldc_vl_dif_ibs_uf,&
			ldc_vl_dev_trib_ibs_uf,&
			ldc_pc_reducao_ibs_uf,&
			ldc_pc_efetiva_ibs_uf,&
			ldc_pc_ibs_mun,&
			ldc_vl_ibs_mun,&
			ldc_pc_dif_ibs_mun,&
			ldc_vl_dif_ibs_mun,&
			ldc_vl_dev_trib_ibs_mun,&
			ldc_pc_reducao_ibs_mun,&
			ldc_pc_efetiva_ibs_mun,&
			ldc_pc_cbs,&
			ldc_pc_dif_cbs,&
			ldc_vl_dif_cbs,&
			ldc_vl_dev_trib_cbs,&
			ldc_pc_reducao_cbs,&
			ldc_pc_efetiva_cbs,&
			ldc_vl_cbs,&
			ldc_pc_efetiva_reg_ibs_uf,&
			ldc_vl_trib_reg_ibs_uf,&
			ldc_pc_efetiva_reg_ibs_mun,&
			ldc_vl_trib_reg_ibs_mun,&
			ldc_pc_efetiva_reg_cbs,&
			ldc_vl_trib_reg_cbs,&
			ldc_pc_cred_pres_ibs,&
			ldc_vl_cred_pres_ibs,&
			ldc_vl_cred_pres_ibs_cond_sus,&
			ldc_pc_cred_pres_cbs,&
			ldc_vl_cred_pres_cbs,&
			ldc_vl_cred_pres_cbs_cond_sus

			
Boolean	lb_Produto_Sem_Codigo	= False

Try
	SetNull(as_Erro)
	
	ldc_Vl_Total_Prd_Calculado	= 0.00
	
	ll_Linhas = UpperBound(at_InfNfe.det[])
	
	w_ge488_aguarde.uo_Progress_2.of_setmax(ll_Linhas)
		
	For ll_Linha = 1 to  ll_Linhas
		
		w_ge488_aguarde.st_itens.Text = "Importando itens "+String(ll_Linha)+" de "+String(ll_Linhas)
		w_ge488_aguarde.uo_Progress_2.of_setprogress(ll_Linha)
	
		ll_Item							= Long(at_InfNfe.det[ll_Linha].nItem)
		ll_Nr_Nf							= at_InfNfe.ide.nNF
		ls_Serie							= at_InfNfe.ide.serie
		ls_Cnpj_Emitente				= at_InfNfe.emit.cnpj
		ls_Ean							= at_InfNfe.det[ll_Linha].prod.cEAN
		ls_Ean_Trib						= at_InfNfe.det[ll_Linha].prod.cEANTrib
		ls_Cd_Prod_Xml					= at_InfNfe.det[ll_Linha].prod.cProd
		ls_De_Produto_Xml				= at_InfNfe.det[ll_Linha].prod.xProd
		ll_NCM							= at_InfNfe.det[ll_Linha].prod.ncm
		ls_NCM							= String(ll_NCM, "00000000")
		ls_Cest							= at_InfNfe.det[ll_Linha].prod.CEST
		ldc_Vl_Produto					= Round(at_InfNfe.det[ll_Linha].prod.vProd, 2)
		ldc_Vl_Desconto				= Round(at_InfNfe.det[ll_Linha].prod.vDesc, 2)
		ldc_Vl_Frete					= Round(at_InfNfe.det[ll_Linha].prod.vFrete, 2)
		ldc_Vl_Seguro					= Round(at_InfNfe.det[ll_Linha].prod.vSeg, 2)
		ldc_Vl_Outras_Desp			= Round(at_InfNfe.det[ll_Linha].prod.vOutro, 2)
		ls_Unid_Comercial				= at_InfNfe.det[ll_Linha].prod.uCom
		ldc_Qt_Comercial				= Round(at_InfNfe.det[ll_Linha].prod.qCom, 4)
		ll_CFOP							= Long(at_InfNfe.det[ll_Linha].prod.CFOP)
		ls_Cst_Origem					= String(at_InfNfe.det[ll_Linha].imposto.ICMS.orig)
		ls_Cst							= at_InfNfe.det[ll_Linha].imposto.ICMS.CST
		ldc_Pc_Red_Bc					= Round(at_InfNfe.det[ll_Linha].imposto.ICMS.pRedBC, 4)
		ldc_Vl_Bc_Icms					= Round(at_InfNfe.det[ll_Linha].imposto.ICMS.vBC, 2)
		ldc_Pc_Icms						= Round(at_InfNfe.det[ll_Linha].imposto.ICMS.pICMS, 4)
		ldc_Vl_Icms						= Round(at_InfNfe.det[ll_Linha].imposto.ICMS.vICMS, 2)
		ldc_Vl_Bc_Fcp					= Round(at_InfNfe.det[ll_Linha].imposto.ICMS.vBCFCP, 2)
		ldc_Pc_Fcp						= Round(at_InfNfe.det[ll_Linha].imposto.ICMS.pFCP, 4)
		ldc_Vl_Fcp						= Round(at_InfNfe.det[ll_Linha].imposto.ICMS.vFCP, 2)
		ldc_Pc_Mva_St					= Round(at_InfNfe.det[ll_Linha].imposto.ICMS.pMVAST, 4)
		ldc_Pc_Red_Icms_St			= Round(at_InfNfe.det[ll_Linha].imposto.ICMS.pRedBCST, 4)
		ldc_Vl_Bc_Icms_St				= Round(at_InfNfe.det[ll_Linha].imposto.ICMS.vBCST, 2)
		ldc_Pc_Icms_St					= Round(at_InfNfe.det[ll_Linha].imposto.ICMS.pICMSST, 4)
		ldc_Vl_Icms_St					= Round(at_InfNfe.det[ll_Linha].imposto.ICMS.vICMSST, 2)
		ldc_Vl_Bc_Fcp_St				= Round(at_InfNfe.det[ll_Linha].imposto.ICMS.vBCFCPST, 2)
		ldc_Pc_Fcp_St					= Round(at_InfNfe.det[ll_Linha].imposto.ICMS.pFCPST, 4)
		ldc_Vl_Fcp_St					= Round(at_InfNfe.det[ll_Linha].imposto.ICMS.vFCPST, 2)
		ldc_Vl_Icms_Retido			= Round(at_InfNfe.det[ll_Linha].imposto.ICMS.vICMSSubstituto, 2)
		ldc_Vl_Bc_Icms_St_Retido	= Round(at_InfNfe.det[ll_Linha].imposto.ICMS.vBCSTRet, 2)
		ldc_Pc_Icms_St_Retido		= Round(at_InfNfe.det[ll_Linha].imposto.ICMS.pST, 4)
		ldc_Vl_Icms_St_Retido		= Round(at_InfNfe.det[ll_Linha].imposto.ICMS.vICMSSTRet, 2)
		ldc_Vl_Bc_Fcp_St_Retido		= Round(at_InfNfe.det[ll_Linha].imposto.ICMS.vBCFCPSTRet, 2)
		ldc_Pc_Fcp_St_Retido			= Round(at_InfNfe.det[ll_Linha].imposto.ICMS.pFCPSTRet, 4)
		ldc_Vl_Fcp_St_Retido			= Round(at_InfNfe.det[ll_Linha].imposto.ICMS.vFCPSTRet, 2)
		ldc_Vl_ICMS_Deson				= Round(at_InfNfe.det[ll_Linha].imposto.ICMS.vICMSDeson, 2)
		ls_Mot_Deson_ICMS				= at_InfNfe.det[ll_Linha].imposto.ICMS.motDesICMS
		ls_Cd_Cst_Ipi					= at_InfNfe.det[ll_Linha].imposto.IPI.IPITrib.CST
		ldc_Vl_Bc_Ipi					= Round(at_InfNfe.det[ll_Linha].imposto.IPI.IPITrib.vBC, 2)
		ldc_Pc_Ipi						= Round(at_InfNfe.det[ll_Linha].imposto.IPI.IPITrib.pIPI, 4)
		ldc_Vl_Ipi						= Round(at_InfNfe.det[ll_Linha].imposto.IPI.IPITrib.vIPI, 2)
		SetNull(ldc_Vl_Bc_St_Calc)
		SetNull(ldc_Pc_St_Calc)
		SetNull(ldc_Vl_St_Calc)

		ldc_Vl_Total_Prd_Calculado	+= ldc_Vl_Produto
		
		/* Campos Reforma Tribut$$HEX1$$e100$$ENDHEX$$ria */
		ls_cd_cst_ibscbs			= at_InfNfe.det[ll_Linha].imposto.ibscbs.cst
		ls_cd_class_trib_ibscbs	= at_InfNfe.det[ll_Linha].imposto.ibscbs.cclasstrib
		ldc_vl_bc_ibscbs			= Round(at_InfNfe.det[ll_Linha].imposto.ibscbs.gibscbs.vbc, 2)
		ldc_vl_ibs					= Round(at_InfNfe.det[ll_Linha].imposto.ibscbs.gibscbs.vibs, 2)
		
		//IBS UF
		ldc_pc_ibs_uf				= Round(at_InfNfe.det[ll_Linha].imposto.ibscbs.gibscbs.gibsuf.pibsuf, 4)
		ldc_vl_ibs_uf				= Round(at_InfNfe.det[ll_Linha].imposto.ibscbs.gibscbs.gibsuf.vibsuf, 2)
		ldc_pc_dif_ibs_uf			= Round(at_InfNfe.det[ll_Linha].imposto.ibscbs.gibscbs.gibsuf.gdif.pdif, 4)
		ldc_vl_dif_ibs_uf			= Round(at_InfNfe.det[ll_Linha].imposto.ibscbs.gibscbs.gibsuf.gdif.vdif, 2)
		ldc_pc_reducao_ibs_uf	= Round(at_InfNfe.det[ll_Linha].imposto.ibscbs.gibscbs.gibsuf.gred.predaliq, 4)
		ldc_pc_efetiva_ibs_uf 	= Round(at_InfNfe.det[ll_Linha].imposto.ibscbs.gibscbs.gibsuf.gred.paliqefet, 4)
		ldc_vl_dev_trib_ibs_uf	= Round(at_InfNfe.det[ll_Linha].imposto.ibscbs.gibscbs.gibsuf.gdevtrib.vdevtrib, 2)
		
		//IBS Mun.
		ldc_pc_ibs_mun				= Round(at_InfNfe.det[ll_Linha].imposto.ibscbs.gibscbs.gibsmun.pibsmun, 4)
		ldc_vl_ibs_mun				= Round(at_InfNfe.det[ll_Linha].imposto.ibscbs.gibscbs.gibsmun.vibsmun, 2)
		ldc_pc_dif_ibs_mun		= Round(at_InfNfe.det[ll_Linha].imposto.ibscbs.gibscbs.gibsmun.gdif.pdif, 4)
		ldc_vl_dif_ibs_mun		= Round(at_InfNfe.det[ll_Linha].imposto.ibscbs.gibscbs.gibsmun.gdif.vdif, 2)
		ldc_vl_dev_trib_ibs_mun	= Round(at_InfNfe.det[ll_Linha].imposto.ibscbs.gibscbs.gibsmun.gdevtrib.vdevtrib, 2)
		ldc_pc_reducao_ibs_mun	= Round(at_InfNfe.det[ll_Linha].imposto.ibscbs.gibscbs.gibsmun.gred.predaliq, 4)
		ldc_pc_efetiva_ibs_mun	= Round(at_InfNfe.det[ll_Linha].imposto.ibscbs.gibscbs.gibsmun.gred.paliqefet, 4)
	
		//CBS
		ldc_pc_cbs 				= Round(at_InfNfe.det[ll_Linha].imposto.ibscbs.gibscbs.gcbs.pcbs, 4)
		ldc_pc_dif_cbs			= Round(at_InfNfe.det[ll_Linha].imposto.ibscbs.gibscbs.gcbs.gdif.pdif, 4)
		ldc_vl_dif_cbs 		= Round(at_InfNfe.det[ll_Linha].imposto.ibscbs.gibscbs.gcbs.gdif.vdif, 2)
		ldc_vl_dev_trib_cbs 	= Round(at_InfNfe.det[ll_Linha].imposto.ibscbs.gibscbs.gcbs.gdevtrib.vdevtrib, 2)
		ldc_pc_reducao_cbs	= Round(at_InfNfe.det[ll_Linha].imposto.ibscbs.gibscbs.gcbs.gred.predaliq, 4)
		ldc_pc_efetiva_cbs 	= Round(at_InfNfe.det[ll_Linha].imposto.ibscbs.gibscbs.gcbs.gred.paliqefet, 4)
		ldc_vl_cbs				= Round(at_InfNfe.det[ll_Linha].imposto.ibscbs.gibscbs.gcbs.vcbs, 2)
	
		//Tributa$$HEX2$$e700e300$$ENDHEX$$o Regular
		ls_cd_cst_ibscbs_reg				= at_InfNfe.det[ll_Linha].imposto.ibscbs.gibscbs.gtribregular.cstreg
		ls_cd_class_trib_ibscbs_reg  	= at_InfNfe.det[ll_Linha].imposto.ibscbs.gibscbs.gtribregular.cclasstribreg
		ldc_pc_efetiva_reg_ibs_uf	 	= Round(at_InfNfe.det[ll_Linha].imposto.ibscbs.gibscbs.gtribregular.paliqefetregibsuf, 4)
		ldc_vl_trib_reg_ibs_uf			= Round(at_InfNfe.det[ll_Linha].imposto.ibscbs.gibscbs.gtribregular.vtribregibsuf, 2)
		ldc_pc_efetiva_reg_ibs_mun		= Round(at_InfNfe.det[ll_Linha].imposto.ibscbs.gibscbs.gtribregular.paliqefetregibsmun, 4)
		ldc_vl_trib_reg_ibs_mun			= Round(at_InfNfe.det[ll_Linha].imposto.ibscbs.gibscbs.gtribregular.vtribregibsmun, 2)
		ldc_pc_efetiva_reg_cbs			= Round(at_InfNfe.det[ll_Linha].imposto.ibscbs.gibscbs.gtribregular.paliqefetregcbs, 4)
		ldc_vl_trib_reg_cbs				= Round(at_InfNfe.det[ll_Linha].imposto.ibscbs.gibscbs.gtribregular.vtribregcbs, 2)
		
		//Cr$$HEX1$$e900$$ENDHEX$$dito Presumido
//		ls_cd_class_cred_pres_ibs
//		ldc_pc_cred_pres_ibs
//		ldc_vl_cred_pres_ibs
//		ldc_vl_cred_pres_ibs_cond_sus
//		ls_cd_class_cred_pres_cbs
//		ldc_pc_cred_pres_cbs
//		ldc_vl_cred_pres_cbs
//		ldc_vl_cred_pres_cbs_cond_sus
		
		//Imposto Seletivo
		ls_cd_cst_is 						= at_InfNfe.det[ll_Linha].imposto.isel.cstis
		ls_cd_classificacao_trib_is	= at_InfNfe.det[ll_Linha].imposto.isel.cclasstribis
		ldc_vl_bc_is 						= Round(at_InfNfe.det[ll_Linha].imposto.isel.vbcis, 2)
		ldc_pc_is							= Round(at_InfNfe.det[ll_Linha].imposto.isel.pis, 4)
		ldc_pc_is_espec					= Round(at_InfNfe.det[ll_Linha].imposto.isel.pisespec, 4)
		ls_cd_un_trib_is					= at_InfNfe.det[ll_Linha].imposto.isel.utrib
		ldc_qt_trib_is						= Round(at_InfNfe.det[ll_Linha].imposto.isel.qtrib, 4)
		ldc_vl_is							= Round(at_InfNfe.det[ll_Linha].imposto.isel.vis, 2)
		/* Fim Campos Reforma Tribut$$HEX1$$e100$$ENDHEX$$ria */
		
		//PIS
		If at_InfNfe.det[ll_Linha].imposto.PIS.TipoPis	= 'PISAliq'	Then
			ls_Cd_Cst_Pis					= at_InfNfe.det[ll_Linha].imposto.PIS.PISAliq.CST
			ldc_Vl_Bc_Pis					= Round(at_InfNfe.det[ll_Linha].imposto.PIS.PISAliq.vBC, 2)
			ldc_Pc_Pis						= Round(at_InfNfe.det[ll_Linha].imposto.PIS.PISAliq.pPIS, 4)
			ldc_Vl_Pis						= Round(at_InfNfe.det[ll_Linha].imposto.PIS.PISAliq.vPIS, 2)
			
		ElseIf at_InfNfe.det[ll_Linha].imposto.PIS.TipoPis	= 'PISQtde'	Then
			ls_Cd_Cst_Pis					= at_InfNfe.det[ll_Linha].imposto.PIS.PISQtde.CST
			ldc_Vl_Bc_Pis					= Round(at_InfNfe.det[ll_Linha].imposto.PIS.PISQtde.qBCProd, 2)
			ldc_Pc_Pis						= Round(at_InfNfe.det[ll_Linha].imposto.PIS.PISQtde.vAliqProd, 4)
			ldc_Vl_Pis						= Round(at_InfNfe.det[ll_Linha].imposto.PIS.PISQtde.vPIS, 2)

		ElseIf at_InfNfe.det[ll_Linha].imposto.PIS.TipoPis	= 'PISNT'	Then
			ls_Cd_Cst_Pis					= at_InfNfe.det[ll_Linha].imposto.PIS.PISNT.CST
			ldc_Vl_Bc_Pis					= 0.00
			ldc_Pc_Pis						= 0.00
			ldc_Vl_Pis						= 0.00

		ElseIf at_InfNfe.det[ll_Linha].imposto.PIS.TipoPis	= 'PISOutr'	Then
			ls_Cd_Cst_Pis					= at_InfNfe.det[ll_Linha].imposto.PIS.PISOutr.CST
			ldc_Vl_Bc_Pis					= Round(at_InfNfe.det[ll_Linha].imposto.PIS.PISOutr.vBC, 2)
			ldc_Pc_Pis						= Round(at_InfNfe.det[ll_Linha].imposto.PIS.PISOutr.pPIS, 4)
			ldc_Vl_Pis						= Round(at_InfNfe.det[ll_Linha].imposto.PIS.PISOutr.vPIS, 2)	
		End If	
		
		//COFINS
		If at_InfNfe.det[ll_Linha].imposto.COFINS.TipoCofins	= 'COFINSAliq'	Then
			ls_Cd_Cst_Cofins				= at_InfNfe.det[ll_Linha].imposto.COFINS.COFINSAliq.CST
			ldc_Vl_Bc_Cofins				= Round(at_InfNfe.det[ll_Linha].imposto.COFINS.COFINSAliq.vBC, 2)
			ldc_Pc_Cofins					= Round(at_InfNfe.det[ll_Linha].imposto.COFINS.COFINSAliq.pCOFINS, 4)
			ldc_Vl_Cofins					= Round(at_InfNfe.det[ll_Linha].imposto.COFINS.COFINSAliq.vCOFINS, 2)
			
		ElseIf at_InfNfe.det[ll_Linha].imposto.COFINS.TipoCofins	= 'COFINSQtde'	Then
			ls_Cd_Cst_Cofins				= at_InfNfe.det[ll_Linha].imposto.COFINS.COFINSQtde.CST
			ldc_Vl_Bc_Cofins				= Round(at_InfNfe.det[ll_Linha].imposto.COFINS.COFINSQtde.qBCProd, 2)
			ldc_Pc_Cofins					= Round(at_InfNfe.det[ll_Linha].imposto.COFINS.COFINSQtde.vAliqProd, 4)
			ldc_Vl_Cofins					= Round(at_InfNfe.det[ll_Linha].imposto.COFINS.COFINSQtde.vCOFINS, 2)
	
		ElseIf at_InfNfe.det[ll_Linha].imposto.COFINS.TipoCofins	= 'COFINSNT'	Then
			ls_Cd_Cst_Cofins				= at_InfNfe.det[ll_Linha].imposto.COFINS.COFINSNT.CST
			ldc_Vl_Bc_Cofins				= 0.00
			ldc_Pc_Cofins					= 0.00
			ldc_Vl_Cofins					= 0.00
		
		ElseIf at_InfNfe.det[ll_Linha].imposto.COFINS.TipoCofins = 'COFINSOutr'	Then
			ls_Cd_Cst_Cofins				= at_InfNfe.det[ll_Linha].imposto.COFINS.COFINSOutr.CST
			ldc_Vl_Bc_Cofins				= Round(at_InfNfe.det[ll_Linha].imposto.COFINS.COFINSOutr.vBC, 2)
			ldc_Pc_Cofins					= Round(at_InfNfe.det[ll_Linha].imposto.COFINS.COFINSOutr.pCOFINS, 4)
			ldc_Vl_Cofins					= Round(at_InfNfe.det[ll_Linha].imposto.COFINS.COFINSOutr.vCOFINS, 2)			
		End If	
				
		If IsNull(ls_Ean_Trib)	Then ls_Ean_Trib	= ""
		If IsNull(ls_Ean)		Then ls_Ean			= ""
		SetNull(ll_Produto)
				
		If Not This.of_Localiza_Codigo_Produto(ls_Cnpj_Emitente, ls_Ean, ls_Ean_Trib, ls_Cd_Prod_Xml, as_Fornecedor, al_Filial, Ref ll_Produto, Ref ls_Erro) Then
			If Not of_Localiza_Natureza_Operacao(ll_CFOP, ref ls_Id_Valida_Prod_Importa_Xml, ref ls_Erro) then
				If IsNull(as_Erro) Then
					as_Erro	=  "[Item = "+String(ll_Linha)+"] "+ls_Erro
				Else
					as_Erro	= as_Erro + " | " + "[Item = "+String(ll_Linha)+"] "+ls_Erro
				End If
			Else
				//A CFOP do XML $$HEX1$$e900$$ENDHEX$$ de venda ou comercializa$$HEX2$$e700e300$$ENDHEX$$o? Ent$$HEX1$$e300$$ENDHEX$$o deve validar o produto
				If ls_Id_Valida_Prod_Importa_Xml = "S" Then
					//Mesmo que seja CFOP para gravar log de produto (revenda), se veio pelo nfe_destinadas, n$$HEX1$$e300$$ENDHEX$$o deve gravar
					If Not This.of_Verifica_Destinada(as_chave_acesso) Then
						If IsNull(as_Erro) Then
							as_Erro	=  "[Item = "+String(ll_Linha)+"] "+ls_Erro
						Else
							as_Erro	= as_Erro + " | " + "[Item = "+String(ll_Linha)+"] "+ls_Erro
						End If
						
						lb_Produto_Sem_Codigo	= True
					End If
				Else
					lb_Produto_Sem_Codigo	= False
				End If
			End If
			
			SetNull(ll_Produto)
			
			
		End If
		
		
		If ls_Ean_Trib <> "" and ls_Ean_Trib <> "SEM GTIN" Then
			ls_Cod_Barras = ls_Ean_Trib
		Else
			ls_Cod_Barras = ls_Ean
		End If
		
		If ll_Produto>0 and (gf_coalesce(ldc_Vl_Icms_St_Retido,0)+gf_coalesce(ldc_Vl_Icms_St,0) = 0) then
			ivo_produto.Of_localiza_codigo_interno( ll_Produto )
			ivo_atributo = ivo_fiscal.of_atributo_fiscal_produto( ivo_produto )
			ivo_trib_icms.Of_localiza_tributacao( ivo_atributo.cd_tributacao_icms )
			
			If ivo_trib_icms.id_icms_st = 'S' Then
				ivo_fiscal.Of_Grava_icms_produto( ll_Produto, &
															 1, &
															 ldc_Vl_Produto - ldc_Vl_Desconto + ldc_Vl_Frete + ldc_Vl_Seguro + ldc_Vl_Outras_Desp, &
															 0.00, &
															 ivo_atributo.cd_tributacao_icms, &
															 ldc_Pc_Icms)
															 
				ldc_Vl_Bc_St_Calc = Round(ivo_fiscal.ivo_atributo_nf.vl_bc_icms_st_prd, 2)
				ldc_Pc_St_Calc = Round(ivo_fiscal.ivo_atributo_nf.pc_icms_st, 0)
				ldc_Vl_St_Calc = Round(ivo_fiscal.ivo_atributo_nf.vl_icms_st_prd, 2)
			End If
		End If
		
		insert into nfe_reprocessada_item(
			de_chave_acesso,
			nr_item,
			cd_filial,
			cd_fornecedor,
			nr_nf,
			de_especie,
			de_serie,
			cd_produto,
			cd_produto_xml,
			de_produto_xml,
			de_codigo_barras,
			nr_ncm_xml,
			cd_cest,
			vl_produto,
			vl_desconto,
			vl_frete,
			vl_seguro,
			vl_outros,
			cd_unid_comercial,
			qt_comercial,
			cd_cfop,
			cd_cst_origem,
			cd_cst_tributacao,
			pc_reducao_icms,
			vl_bc_icms,
			pc_icms,
			vl_icms,
			vl_bc_fcp,
			pc_fcp,
			vl_fcp,
			pc_mva_st,
			pc_reducao_icms_st,
			vl_bc_icms_st,
			pc_icms_st,
			vl_icms_st,
			vl_bc_fcp_st,
			pc_fcp_st,
			vl_fcp_st,
			vl_icms_retido,
			vl_bc_icms_st_retido,
			pc_icms_st_retido,
			vl_icms_st_retido,
			vl_bc_fcp_st_retido,
			pc_fcp_st_retido,
			vl_fcp_st_retido,
			cd_cst_ipi,
			vl_bc_ipi,
			pc_ipi,
			vl_ipi,
			cd_cst_pis,
			vl_bc_pis,
			pc_pis,
			vl_pis,
			cd_cst_cofins,
			vl_bc_cofins,
			pc_cofins,
			vl_cofins,
			id_motivo_desoneracao_icms,
			vl_icms_desonerado,
			vl_bc_st_calculada,
			pc_st_calculada,
			vl_st_calculada,
			cd_cst_is,
			cd_classificacao_trib_is,
			vl_bc_is,
			pc_is,
			pc_is_espec,
			cd_un_trib_is,
			qt_trib_is,
			vl_is,
			cd_cst_ibscbs,
			cd_class_trib_ibscbs,
			vl_bc_ibscbs,
			vl_ibs,
			pc_ibs_uf,
			vl_ibs_uf,
			pc_dif_ibs_uf,
			vl_dif_ibs_uf,
			vl_dev_trib_ibs_uf,
			pc_reducao_ibs_uf,
			pc_efetiva_ibs_uf,
			pc_ibs_mun,
			vl_ibs_mun,
			pc_dif_ibs_mun,
			vl_dif_ibs_mun,
			vl_dev_trib_ibs_mun,
			pc_reducao_ibs_mun,
			pc_efetiva_ibs_mun,
			pc_cbs,
			pc_dif_cbs,
			vl_dif_cbs,
			vl_dev_trib_cbs,
			pc_reducao_cbs,
			pc_efetiva_cbs,
			vl_cbs,
			cd_cst_ibscbs_reg,
			cd_class_trib_ibscbs_reg,
			pc_efetiva_reg_ibs_uf,
			vl_trib_reg_ibs_uf,
			pc_efetiva_reg_ibs_mun,
			vl_trib_reg_ibs_mun,
			pc_efetiva_reg_cbs,
			vl_trib_reg_cbs,
			cd_class_cred_pres_ibs,
			pc_cred_pres_ibs,
			vl_cred_pres_ibs,
			vl_cred_pres_ibs_cond_sus,
			cd_class_cred_pres_cbs,
			pc_cred_pres_cbs,
			vl_cred_pres_cbs,
			vl_cred_pres_cbs_cond_sus)
		values(
			:as_Chave_Acesso,
			:ll_Item,
			:al_Filial,
			:as_Fornecedor,
			:ll_Nr_Nf,
			'NFE',
			:ls_Serie,
			:ll_Produto,
			:ls_Cd_Prod_Xml,
			:ls_De_Produto_Xml,
			:ls_Cod_Barras,
			:ls_NCM,
			:ls_Cest,
			:ldc_Vl_Produto,
			:ldc_Vl_Desconto,
			:ldc_Vl_Frete,
			:ldc_Vl_Seguro,
			:ldc_Vl_Outras_Desp,
			:ls_Unid_Comercial,
			:ldc_Qt_Comercial,
			:ll_CFOP,
			:ls_Cst_Origem,
			:ls_Cst,
			:ldc_Pc_Red_Bc,
			:ldc_Vl_Bc_Icms,
			:ldc_Pc_Icms,
			:ldc_Vl_Icms,
			:ldc_Vl_Bc_Fcp,
			:ldc_Pc_Fcp,
			:ldc_Vl_Fcp,
			:ldc_Pc_Mva_St,
			:ldc_Pc_Red_Icms_St,
			:ldc_Vl_Bc_Icms_St,
			:ldc_Pc_Icms_St,
			:ldc_Vl_Icms_St,
			:ldc_Vl_Bc_Fcp_St,
			:ldc_Pc_Fcp_St,
			:ldc_Vl_Fcp_St,
			:ldc_Vl_Icms_Retido,
			:ldc_Vl_Bc_Icms_St_Retido,
			:ldc_Pc_Icms_St_Retido,
			:ldc_Vl_Icms_St_Retido,
			:ldc_Vl_Bc_Fcp_St_Retido,
			:ldc_Pc_Fcp_St_Retido,
			:ldc_Vl_Fcp_St_Retido,
			:ls_Cd_Cst_Ipi,
			:ldc_Vl_Bc_Ipi,
			:ldc_Pc_Ipi,
			:ldc_Vl_Ipi,
			:ls_Cd_Cst_Pis,
			:ldc_Vl_Bc_Pis,
			:ldc_Pc_Pis,
			:ldc_Vl_Pis,
			:ls_Cd_Cst_Cofins,
			:ldc_Vl_Bc_Cofins,
			:ldc_Pc_Cofins,
			:ldc_Vl_Cofins,
			:ls_Mot_Deson_ICMS,
			:ldc_Vl_ICMS_Deson,
			:ldc_Vl_Bc_St_Calc,
			:ldc_Pc_St_Calc,
			:ldc_Vl_St_Calc,
			:ls_cd_cst_is,
			:ls_cd_classificacao_trib_is,
			:ldc_vl_bc_is,
			:ldc_pc_is,
			:ldc_pc_is_espec,
			:ls_cd_un_trib_is,
			:ldc_qt_trib_is,
			:ldc_vl_is,
			:ls_cd_cst_ibscbs,
			:ls_cd_class_trib_ibscbs,
			:ldc_vl_bc_ibscbs,
			:ldc_vl_ibs,
			:ldc_pc_ibs_uf,
			:ldc_vl_ibs_uf,
			:ldc_pc_dif_ibs_uf,
			:ldc_vl_dif_ibs_uf ,
			:ldc_vl_dev_trib_ibs_uf,
			:ldc_pc_reducao_ibs_uf,
			:ldc_pc_efetiva_ibs_uf,
			:ldc_pc_ibs_mun,
			:ldc_vl_ibs_mun,
			:ldc_pc_dif_ibs_mun,
			:ldc_vl_dif_ibs_mun,
			:ldc_vl_dev_trib_ibs_mun,
			:ldc_pc_reducao_ibs_mun,
			:ldc_pc_efetiva_ibs_mun,
			:ldc_pc_cbs,
			:ldc_pc_dif_cbs,
			:ldc_vl_dif_cbs,
			:ldc_vl_dev_trib_cbs,
			:ldc_pc_reducao_cbs,
			:ldc_pc_efetiva_cbs,
			:ldc_vl_cbs,
			:ls_cd_cst_ibscbs_reg,
			:ls_cd_class_trib_ibscbs_reg,
			:ldc_pc_efetiva_reg_ibs_uf,
			:ldc_vl_trib_reg_ibs_uf,
			:ldc_pc_efetiva_reg_ibs_mun,
			:ldc_vl_trib_reg_ibs_mun,
			:ldc_pc_efetiva_reg_cbs,
			:ldc_vl_trib_reg_cbs,
			:ls_cd_class_cred_pres_ibs,
			:ldc_pc_cred_pres_ibs,
			:ldc_vl_cred_pres_ibs,
			:ldc_vl_cred_pres_ibs_cond_sus,
			:ls_cd_class_cred_pres_cbs,
			:ldc_pc_cred_pres_cbs,
			:ldc_vl_cred_pres_cbs,
			:ldc_vl_cred_pres_cbs_cond_sus)
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			as_Erro = "Erro ao inserir o produto '"+gf_coalesce(String(ll_Produto),'NULO')+"': "+SqlCa.SqlErrText
			Return False
		End If
		
		If SqlCa.Sqlnrows <> 1 Then
			as_Erro = "Deveria ter inserido 1 registro, mas inseriu "+String(SqlCa.Sqlnrows)+" registro(s). Produto '"+gf_coalesce(String(ll_Produto),'NULO')+"'." 
			Return False
		End If
			
	Next
	
	If adc_Vl_Total_Produto <> ldc_Vl_Total_Prd_Calculado	Then
		ldc_Diferenca_Vl_Produto	= Abs(adc_Vl_Total_Produto - ldc_Vl_Total_Prd_Calculado)
		
//		If ldc_Diferenca_Vl_Produto > 0.01 Then
//			as_Erro = "O valor total dos produtos n$$HEX1$$e300$$ENDHEX$$o confere. [Total da nota: "+String(adc_Vl_Total_Produto)+"] [Total calculado: "+String(ldc_Vl_Total_Prd_Calculado)+"]"
//			Return False
//		End If
	End If
	
	//Quando n$$HEX1$$e300$$ENDHEX$$o for encontrado o c$$HEX1$$f300$$ENDHEX$$digo do produto, grava os itens mas tab$$HEX1$$e900$$ENDHEX$$m grava o erro. Nesse caso o c$$HEX1$$f300$$ENDHEX$$digo do produto vai ser localizado maualmente.
	If lb_Produto_Sem_Codigo Then
		update nfe_reprocessada
		set	id_status	= 'E',
			de_erro	= :as_Erro
		where de_chave_acesso = :as_Chave_Acesso
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			as_Erro = "Erro ao atualizar a situa$$HEX2$$e700e300$$ENDHEX$$o para 'E': "+SqlCa.SqlErrText
			Return False
		End If
		
		If SqlCa.Sqlnrows <> 1 Then
			as_Erro = "Deveria ter inserido 1 registro, mas inseriu "+String(SqlCa.Sqlnrows)+" registro(s)." 
			Return False
		End If
		
	End If
	
Catch ( runtimeerror  lo_rte )
	as_Erro = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_insere_detalhes'. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try

Return True
end function

public function boolean of_busca_arquivo_xml (string as_chave_acesso, datetime adh_emissao, string as_diretorio_xml, long al_filial_destino, ref string as_erro);Date	ldt_Diretorio_Novo

String	ls_Cnpj_Origem,&
		ls_Ano,&
		ls_Mes,&
		ls_Dia,&
		ls_Erro,&
		ls_Diretorio
		
Boolean	lb_Xml_Localizado = False
		
dc_uo_Ftp lo_Ftp1
dc_uo_Ftp lo_Ftp2
		
uo_ge238_importa_xml	lo_Importa_Xml

Try
	lo_Ftp1 = Create dc_uo_Ftp

	lo_Importa_Xml	= Create	uo_ge238_importa_xml
	lo_Importa_Xml.of_parametro_conexao_ftp()

	ls_Cnpj_Origem	= Mid(as_Chave_Acesso, 7, 14)
	ls_Ano				= "Ano_"+String(Year(Date(adh_Emissao)))
	ls_Mes				= "Mes_"+Right("0"+String(Month(Date(adh_Emissao))), 2)
	ls_Dia					= "Dia_"+Right("0"+String(Day(Date(adh_Emissao))), 2)
	ls_Diretorio			= ls_Ano+"/"+ls_Mes+"/"+ls_Dia+"/"+ls_Cnpj_Origem
	
	//Diret$$HEX1$$f300$$ENDHEX$$rio Oficial - Notas a partir 2018
	If Not lo_Ftp1.of_Conecta_ftp("GN", lo_Importa_Xml.is_ftp_xml_endereco, lo_Importa_Xml.is_ftp_xml_usuario, lo_Importa_Xml.is_ftp_xml_senha, Ref ls_Erro) Then
		Return False
	End If
	
	If lo_Ftp1.of_Ftp_Set_Dir(ls_Diretorio, Ref ls_Erro) <> -1 Then 
		If lo_Ftp1.of_Ftp_GetFile(as_Chave_Acesso+"-nfe.xml", as_Diretorio_Xml+as_Chave_Acesso+"-nfe.xml", Ref ls_Erro) Then
			lb_Xml_Localizado = True
		End If
	End If

	//Notas de 2017
	If Not lb_Xml_Localizado Then
		lo_Ftp2 = Create dc_uo_Ftp
		If Not lo_Ftp2.of_Conecta_ftp("GN", lo_Importa_Xml.is_ftp_xml_endereco, "caixafilial", "Spum@qa8res#", Ref ls_Erro) Then
			Return False
		End If
		
		If lo_Ftp2.of_Ftp_Set_Dir("bkp-nfe/"+ls_Diretorio, Ref ls_Erro) <> -1 Then 
			If lo_Ftp2.of_Ftp_GetFile(as_Chave_Acesso+"-nfe.xml", as_Diretorio_Xml+as_Chave_Acesso+"-nfe.xml", Ref ls_Erro) Then
				lb_Xml_Localizado = True
			End If
		End If
		
		If Not lb_Xml_Localizado Then
			If lo_Ftp2.of_Ftp_Set_Dir("volta_nfe/"+ls_Diretorio, Ref ls_Erro) <> -1 Then 
				If lo_Ftp2.of_Ftp_GetFile(as_Chave_Acesso+"-nfe.xml", as_Diretorio_Xml+as_Chave_Acesso+"-nfe.xml", Ref ls_Erro) Then
					lb_Xml_Localizado = True
				End If
			End If
		End If
	End If
	
	If Not lb_Xml_Localizado Then
		If Date('20'+Mid(as_Chave_Acesso, 3, 2)+'/'+Mid(as_Chave_Acesso, 5, 2)+'/01') >= gf_primeiro_dia_mes(RelativeDate(Today(), -180)) Then
			dc_uo_importa_nf_pedido_eletronico lo_Aux
			lo_Aux	= Create dc_uo_importa_nf_pedido_eletronico
			
			If Not lo_Aux.of_download_xml_sefaz(as_Chave_Acesso, al_Filial_Destino, as_Erro, as_Diretorio_Xml, as_Diretorio_Xml) Then
				Return False
			End If
		Else
			as_Erro = "Nota n$$HEX1$$e300$$ENDHEX$$o encontrada no FTP e n$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ possibilidade de baix$$HEX1$$e100$$ENDHEX$$-la do SEFAZ automaticamente, pois a mesma foi emitida a mais de 6 meses."
			Return False
		End If
	End If

Catch ( runtimeerror  lo_rte )
	as_Erro = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_busca_arquivo_xml'. Erro: "+lo_rte.GetMessage( )
	Return False	
	
Finally
	If IsValid(lo_Aux) Then Destroy(lo_Aux)
	
	If IsValid(lo_Ftp1) Then
		lo_Ftp1.of_Desconecta_ftp()
		Destroy(lo_Ftp1)
	End If
	
	If IsValid(lo_Ftp2) Then		
		lo_Ftp2.of_Desconecta_ftp()
		Destroy(lo_Ftp2)
	End If
	If IsValid(lo_Importa_Xml) Then Destroy(lo_Importa_Xml)	
End Try

Return True
end function

public function boolean of_localiza_produto_fornecedor (string ps_codigo_barras, string ps_fornecedor, ref long pl_produto);Boolean lvb_Ok

select top 1 i.cd_produto
Into :pl_produto
From nfe_reprocessada_item i
Where i.cd_fornecedor = :ps_fornecedor
	And i.de_codigo_barras = :ps_codigo_barras
	And i.cd_produto > 0 
Using SQLCa;

Choose Case SQLCa.SQLCode
	Case 0
		lvb_Ok = True
		
	Case 100
		SetNull(pl_produto)
		lvb_Ok = True
		
	Case -1
		SetNull(pl_produto)
		lvb_Ok = False
End Choose

Return lvb_Ok
end function

public subroutine of_reprocessar_xml ();This.Of_Reprocessar_XML('')
end subroutine

public subroutine of_reprocessar_xml (string ps_chave_nfe, string ps_arquivo_xml);Integer	li_FileOpen

String	ls_chave_acesso,&
		ls_Diretorio_XML,&
		ls_Dir_Arquivo_XML,&
		ls_Tipo_Nf,&
		ls_Fornecedor,&
		ls_Usuario_Ftp,&
		ls_Senha_Ftp,&
		ls_Xml, &
		ls_Erro, &
		ls_NFe_Compl, &
		ls_Chv_NFe_Ref
		
DateTime	ldt_Emissao, ldt_Emissao_Cpl

Decimal	ldc_Vl_Total_Produto
		
dc_uo_nfe		lo_NFE

t_infnfe	lt_InfNFe,&
			lt_InfNfe_Nulo

dc_uo_ds_Base		lds_Notas

Long	ll_Filia,&
		ll_Linhas,&
		ll_Linha

Boolean	lb_Sucesso = False
		
Try		
	If Not This.of_diretorio_arquivo_xml(Ref ls_Diretorio_XML, Ref ls_Erro) Then
		Return
	End If		
	
	Try
		lds_Notas	= Create dc_uo_ds_Base
		
		Open(w_ge488_aguarde)
		w_ge488_aguarde.Title = 'Reprocessando notas ...'
		
		If Not lds_Notas.of_ChangeDataObject("ds_ge488_nfe_reprocessar") Then
			MessageBox("Erro", "Erro no ChageDataObject da ds_ge488_nfe_reprocessar.")
			Return
		End If
		
		//Se for apenas uma nota
		If Not IsNull(ps_chave_nfe) and (Trim(ps_chave_nfe)<>"") Then
			lds_Notas.Of_AppendWhere("de_chave_acesso='"+ps_chave_nfe+"'")
		End If
		
		ll_Linhas	= lds_Notas.Retrieve()
		
		If ll_Linhas < 0 Then
			MessageBox("Erro", "Erro no Retrieve da ds_ge488_nfe_reprocessar.")
			Return
		End If
		
		If ll_Linhas > 0 Then
			w_ge488_aguarde.uo_Progress_1.of_setmax(ll_Linhas)
			w_ge488_aguarde.uo_Progress_1.of_setprogress(0)
			
			For ll_Linha = 1 To ll_Linhas
				lb_Sucesso	= False
				
				lt_InfNfe	= lt_InfNfe_Nulo //Limpa a estrutura com as informa$$HEX2$$e700f500$$ENDHEX$$es do XML
				
				w_ge488_aguarde.uo_Progress_1.of_setprogress(ll_Linha)
				w_ge488_aguarde.st_notas.Text =  'Reprocessando notas ... '+String(ll_Linha)+' de '+String(ll_Linhas)
				
				w_ge488_aguarde.st_itens.Text	= ""
				w_ge488_aguarde.uo_Progress_2.of_setmax(1)
				w_ge488_aguarde.uo_Progress_2.of_setprogress(1)
				Yield()
				//Pega os valores do datasource de notas a processar
				ls_chave_acesso	= lds_Notas.Object.de_chave_acesso			[ll_Linha]
				ls_NFe_Compl		= lds_Notas.Object.id_nf_complementar		[ll_Linha]
				ls_Chv_NFe_Ref	= lds_Notas.Object.de_chave_acesso_ref	[ll_Linha]
				ls_Tipo_Nf			= ''
				
				//Altera a chave de importa$$HEX2$$e700e300$$ENDHEX$$o para a chave referencia (original) pois a complementar n$$HEX1$$e300$$ENDHEX$$o existe em nossa base
				If Not IsNull(ls_Chv_NFe_Ref) and (Trim(ls_Chv_NFe_Ref)<>"") Then ls_chave_acesso = ls_Chv_NFe_Ref
				
				//Busca dados da nota
				If Not This.of_Dados_Nota(ls_chave_acesso, Ref ldt_Emissao, Ref ls_Tipo_Nf, Ref ll_Filia, Ref ls_Fornecedor, Ref ls_Erro) Then
					If gf_coalesce(ps_arquivo_xml, '')='' Then
						This.of_Grava_Erro(ls_chave_acesso, ls_Erro)
						Continue
					End If
				End If
				
				//Pega a chave a ser processada novamente, pode ter sido alterada se complementar
				If Not IsNull(ls_Chv_NFe_Ref) and (Trim(ls_Chv_NFe_Ref)<>"") Then
					ls_chave_acesso	= lds_Notas.Object.de_chave_acesso			[ll_Linha]
					ldt_Emissao			= lds_Notas.Object.dh_emissao				[ll_Linha]	
				End If
			
				Try
					lo_NFE 	= Create dc_uo_nfe
					
					If gf_coalesce(ps_arquivo_xml, '') = '' Then
						If Not This.of_busca_arquivo_xml(ls_chave_acesso, ldt_emissao, ls_Diretorio_XML, ll_Filia, Ref ls_Erro) Then
							This.of_Grava_Erro(ls_chave_acesso, ls_Erro)
							Continue
						End If
						
						ls_Dir_Arquivo_XML	= ls_Diretorio_XML + ls_chave_acesso + "-nfe.xml"
					Else
						ls_Dir_Arquivo_XML	= ps_arquivo_xml
					End If
					
					li_FileOpen = FileOpen (ls_Dir_Arquivo_XML  , TextMode! , Read!, LockRead! )
					FileReadEx (li_FileOpen, ls_Xml) 
					FileClose (li_FileOpen)
							
					If ls_Xml <> "" Then
						If ps_arquivo_xml='' Then This.of_Exclui_Arquivo_Xml(ls_Dir_Arquivo_XML, Ref ls_Erro)
						If lo_NFE.of_read_xml(ls_Xml, True, Ref lt_InfNFe) Then
							//Se o tipo estiver vazio significa que n$$HEX1$$e300$$ENDHEX$$o localizou a NFe no Sybase
							If ls_Tipo_Nf='' Then
								//Emiss$$HEX1$$e300$$ENDHEX$$o
								ldt_Emissao = Datetime(lt_InfNFe.ide.demi)
								//Emitida pela Clamed, por fora do Sybase
								If Mid(lt_InfNFe.emit.cnpj, 1, 8)='84683481' Then
									//Busca a filial da nota
									Select top 1 cd_filial
									Into :ll_Filia
									from filial
									Where nr_cgc = :lt_InfNFe.emit.cnpj
									order by coalesce(id_situacao, 'A') asc, cd_filial
									Using SQLCa;
									
									//Destino n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ uma filial
									If Mid(lt_InfNFe.dest.cnpj, 1, 8)<>'84683481' Then
										//Verifica se o destino $$HEX1$$e900$$ENDHEX$$ um fornecedor
										Select top 1 cd_fornecedor
										Into :ls_Fornecedor
										From fornecedor
										Where nr_cgc=:lt_InfNFe.dest.cnpj
										order by coalesce(id_situacao, 'A') asc, dh_inclusao desc, dh_atualizacao desc
										Using SQLCa;
										
										If SQLCa.SQLCode=0 Then
											ls_Tipo_NF = 'DC'
										Else 
											ls_Tipo_NF = 'DI'
										End If	
									Else
										ls_Tipo_NF = 'DI'
									End If
								//Emissor n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ a Clamed, mas o destino sim
								ElseIf Mid(lt_InfNFe.dest.cnpj, 1, 8)='84683481' Then
									//Busca a filial destino da nota
									Select top 1 cd_filial
									Into :ll_Filia
									from filial
									Where nr_cgc = :lt_InfNFe.dest.cnpj
									order by coalesce(id_situacao, 'A') asc, cd_filial
									Using SQLCa;
									
									//Verifica se o emissor $$HEX1$$e900$$ENDHEX$$ um fornecedor
									Select top 1 cd_fornecedor
									Into :ls_Fornecedor
									From fornecedor
									Where nr_cgc=:lt_InfNFe.emit.cnpj
									Using SQLCa;
									
									If SQLCa.SQLCode=0 Then
										ls_Tipo_NF = 'CO'
									Else
										ls_Tipo_NF = 'DI'
									End If
								Else
									//Nota n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ para Clamed
									Continue
								End If
							End If
							
							If This.of_Insere_Cabecalho(ls_chave_acesso, lt_InfNFe, ldt_Emissao, ls_Tipo_Nf, ll_Filia, ls_Fornecedor, Ref ldc_Vl_Total_Produto, Ref ls_Erro) Then
								If This.of_Insere_Detalhes(lt_InfNFe, ls_chave_acesso, ll_Filia, ls_Fornecedor, ldc_Vl_Total_Produto, Ref ls_Erro) Then
									If This.Of_Insere_Duplicata(lt_InfNFe, ls_chave_acesso, Ref ls_Erro) Then
										If This.Of_Insere_Emitente(lt_InfNFe, ls_chave_acesso, Ref ls_Erro) Then
											lb_Sucesso = True
										End If
									End If
								End If
							End If
						End If
					End If
					
					If lb_Sucesso Then
						SqlCa.of_Commit()
					Else
						SqlCa.of_RollBack()
						
						This.of_Grava_Erro(ls_chave_acesso, ls_Erro)
					End If
				
				Finally
					Destroy(lo_NFE)
				End Try
			Next
		End If
	Finally
		Close(w_ge488_aguarde)
		Destroy(lds_Notas)
	End Try

Catch ( runtimeerror  lo_rte )
	MessageBox("Erro", "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_reprocessar_xml'. Erro: "+lo_rte.GetMessage( ))
	Return		 
End Try	

Return
end subroutine

public subroutine of_reprocessar_xml (string ps_chave_nfe);This.Of_Reprocessar_XML('', '')
end subroutine

public function boolean of_localiza_natureza_operacao (long al_cfop, ref string as_id_valida_prod_importa_xml, ref string as_erro);select id_valida_prod_importa_xml
Into :as_id_valida_prod_importa_xml
From natureza_operacao 
Where cd_natureza_operacao = :al_cfop 
Using SQLCa;

If SqlCa.SqlCode = -1 Then
	as_Erro	= "Erro ao buscar o 'Id_Valida_Prod_Importa_Xml' na tabela natureza_operacao. "+SqlCa.SqlErrText
	Return False
End If

If IsNull(as_id_valida_prod_importa_xml) Then as_id_valida_prod_importa_xml = "S"

Return True
end function

public function boolean of_verifica_destinada (string as_chave_acesso);String lvs_Operacao

Select max(cd_tipo_operacao_mult)
Into :lvs_Operacao
from nfe_destinadas
Where de_chave_acesso=:as_chave_acesso
	and cd_tipo_operacao_mult is not null
Using SQLCa;

If SQLCa.SQLCode=-1 Then
	If gvb_Auto Then
		gvo_aplicacao.Of_Grava_Log("Falha na busca da nota "+as_chave_acesso+" na nfe_destinadas.~rErroBD: "+SQLCa.SQLErrText)
	Else
		MessageBox("Erro","Falha na busca da nota "+as_chave_acesso+" na nfe_destinadas.~rErroBD: "+SQLCa.SQLErrText, StopSign!)
	End If
End If

Return (SQLCa.SQLCode=0 and gf_coalesce(lvs_Operacao,'')<>'')
end function

public function boolean of_insere_duplicata (t_infnfe at_infnfe, string as_chave_acesso, ref string as_erro);Long lvl_Linha
Long lvl_Parc
String lvs_Fatura
Datetime lvdh_Vencto
Decimal{2} lvdc_Parcela

Try
	//Para cada parcela
	For lvl_Linha = 1 To UpperBound(at_infnfe.cobr.dup)
		//Pega/trata os valores do XML
		lvl_Parc		= Long(gf_coalesce(at_infnfe.cobr.dup[lvl_Linha].ndup, String(lvl_Linha)))
		lvs_Fatura	= at_infnfe.cobr.fat.nfat
		lvdh_Vencto	= Datetime(gf_coalesce(at_infnfe.cobr.dup[lvl_Linha].dvenc, at_infnfe.ide.demi))
		lvdc_Parcela= at_infnfe.cobr.dup[lvl_Linha].vdup
		//Insere na base
		Insert Into nfe_reprocessada_duplicata(de_chave_acesso, nr_parcela, nr_fatura, dh_vencimento, vl_parcela)
		Values(:as_chave_acesso, :lvl_Parc, :lvs_Fatura, :lvdh_Vencto, :lvdc_Parcela)
		Using SQLCa;
		
		If SQLCa.SQLCode = -1 Then
			as_erro = "Falha ao inserir duplicatas da nota "+as_chave_acesso+".~rErroDB: "+SQLCa.SQLErrText
			Return False
		End If
	Next
	
Catch ( runtimeerror  lo_rte )
	as_Erro = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_insere_duplicata'. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try

Return True
end function

public function boolean of_insere_emitente (t_infnfe at_infnfe, string as_chave_acesso, ref string as_erro);String lvs_nr_cnpj_cpf
String lvs_nm_razao_social
String lvs_nm_fantasia
String lvs_de_endereco
String lvs_nr_endereco
String lvs_de_complemento
String lvs_de_bairro
String lvs_nr_cep
String lvs_cd_cidade_ibge
String lvs_nm_cidade
String lvs_nr_inscricao_estadual
String lvs_cd_uf
String lvs_nr_telefone
String lvs_de_email

Long lvl_Count

Try
	lvs_nr_cnpj_cpf 				= at_infnfe.emit.cnpj
	lvs_nm_razao_social			= gf_retira_caracteres_especiais(gf_retira_acentos(Upper(at_infnfe.emit.xnome)))
	lvs_nm_fantasia				= gf_retira_caracteres_especiais(gf_retira_acentos(Upper(at_infnfe.emit.xfant)))
	lvs_de_endereco				= gf_retira_caracteres_especiais(gf_retira_acentos(Upper(at_infnfe.emit.endereco.xlgr)))
	lvs_nr_endereco				= gf_retira_caracteres_especiais(gf_retira_acentos(Upper(at_infnfe.emit.endereco.nro)))
	lvs_de_complemento			= gf_retira_caracteres_especiais(gf_retira_acentos(Upper(at_infnfe.emit.endereco.xcpl)))
	lvs_de_bairro					= gf_retira_caracteres_especiais(gf_retira_acentos(Upper(at_infnfe.emit.endereco.xbairro)))
	lvs_nr_cep						= String(at_infnfe.emit.endereco.cep, '00000000')
	lvs_cd_cidade_ibge			= String(at_infnfe.emit.endereco.cmun)
	lvs_nm_cidade					= gf_retira_caracteres_especiais(gf_retira_acentos(Upper(at_infnfe.emit.endereco.xmun)))
	lvs_nr_inscricao_estadual	= at_infnfe.emit.ie
	lvs_cd_uf						= gf_retira_caracteres_especiais(gf_retira_acentos(Upper(at_infnfe.emit.endereco.uf)))
	lvs_nr_telefone				= at_infnfe.emit.endereco.fone
//	lvs_de_email					= at_infnfe.emit.endereco.email
	
	If Mid(lvs_nr_cnpj_cpf,1,8)<>'84683481' Then
		Select count(1)
		Into :lvl_Count
		From nfe_reprocessada_participante
		Where nr_cnpj_cpf = :lvs_nr_cnpj_cpf
		Using SQLCa;
		
		If SQLCa.SQLCode = -1 Then
			as_erro = "Verifica$$HEX2$$e700e300$$ENDHEX$$o se existe o CNPJ  "+lvs_nr_cnpj_cpf+" na nfe_reprocessada_participante.~rErroDB: "+SQLCa.SQLErrText
			Return False
		End If
		
		If SQLCa.SQLCode=100 or lvl_Count = 0 Then
			//Insere na base
			Insert Into nfe_reprocessada_participante(nr_cnpj_cpf, nm_razao_social, nm_fantasia, de_endereco, 
				nr_endereco, de_complemento, de_bairro, nr_cep, cd_cidade_ibge, nm_cidade, nr_inscricao_estadual, 
				cd_uf, nr_telefone, de_email)
			Values(:lvs_nr_cnpj_cpf, :lvs_nm_razao_social, :lvs_nm_fantasia, :lvs_de_endereco, :lvs_nr_endereco,
					 :lvs_de_complemento, :lvs_de_bairro, :lvs_nr_cep, :lvs_cd_cidade_ibge, :lvs_nm_cidade, 
					 :lvs_nr_inscricao_estadual, :lvs_cd_uf, :lvs_nr_telefone, :lvs_de_email)
			Using SQLCa;
			
			If SQLCa.SQLCode = -1 Then
				as_erro = "Falha ao inserir participantes da nota "+as_chave_acesso+".~rErroDB: "+SQLCa.SQLErrText
				Return False
			End If
		End If
	End If
	
Catch ( runtimeerror  lo_rte )
	as_Erro = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_insere_participante'. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try

Return True
end function

on uo_ge488_reprocessa_xml_drcst.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge488_reprocessa_xml_drcst.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ivo_produto		= Create uo_produto
ivo_trib_icms	= Create uo_tributacao_icms
ivo_Fiscal		= Create uo_tratamento_fiscal
ivo_Fiscal.Of_Inicializa( )
ivo_Fiscal.Of_Grava_Contribuinte( True )
ivo_Fiscal.Of_Grava_Precisao( 4 )
ivo_Fiscal.Of_Grava_Operacao( "TR" )
ivo_fiscal.ivl_filial 				= 534
ivo_fiscal.ivl_filial_destino	= 563
ivo_fiscal.ivs_filial_farmacia_popular = "S"


end event

event destructor;If IsValid(ivo_Fiscal) Then Destroy(ivo_Fiscal)
If IsValid(ivo_produto) Then Destroy(ivo_produto)
If IsValid(ivo_trib_icms) Then Destroy(ivo_trib_icms)

end event

