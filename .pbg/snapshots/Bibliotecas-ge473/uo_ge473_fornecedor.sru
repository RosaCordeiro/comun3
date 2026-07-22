HA$PBExportHeader$uo_ge473_fornecedor.sru
forward
global type uo_ge473_fornecedor from nonvisualobject
end type
end forward

global type uo_ge473_fornecedor from nonvisualobject
end type
global uo_ge473_fornecedor uo_ge473_fornecedor

type variables
//Boolean 	ib_execucao_simultanea = False

str_fornecedor_contato istr_forn_contato[]

Long 		il_tabela_fornecedor = 10
Long 		il_tabela_fornecedor_email = 11
Long 		il_tabela_fornecedor_telefone = 12
Long 		il_tabela_fornecedor_cond_pagto = 15
Long 		il_cd_filial = 534
String is_id_carregado_as400 = 'N'


String is_id_fornecedor_transportadora
String is_id_fisica_juridica

Boolean ib_pessoa_fisica
Boolean	ib_Fornecedor_Novo

DateTime idh_Situacao

Decimal idc_pc_desconto_financeiro
Decimal idc_pc_desconto_usual
Decimal idc_vl_pedido_minimo

Long il_cd_condicao_pagamento
String is_cd_condicao_pagamento_sap
Long il_cd_condicao_pagamento_legado

Long il_nr_endereco
Long il_cd_cidade
Long il_cd_empresa

String	 is_de_chave_acesso_sap
String is_cd_cidade_ibge
String is_cd_fornecedor_legado
String is_cd_fornecedor_sap
String is_cd_grupo
String is_cd_pais
String is_cd_subgrupo
String is_cd_tipo_pn
String is_cd_uf
String is_de_bairro
String is_de_dados_adicionais
String is_de_endereco
String is_de_endereco_email_envio_xml
String is_de_observacao
String is_de_pedido_edi
String is_id_atividade_economica
String is_id_considera_ipi_pedido
String is_id_importacao
String is_id_parceiro
String is_id_pedido_edi
String is_id_principal
String is_id_recebe_email_xml
String is_id_regime_especial
String is_id_regime_tributario
String is_id_situacao
String is_id_tipo
String is_nm_cidade
String is_nm_contato
String is_nm_fantasia
String is_nm_fornecedor
String is_nm_razao_social
String is_nm_sobrenome
String is_nr_cep
String is_nr_cgc
String is_nr_cpf
String is_nr_inscricao_estadual
String is_nr_matricula_comprador
String is_origem_sap
String is_de_condicao_pagamento

end variables

forward prototypes
public function boolean of_atualiza_fornecedor (long al_controle, long al_tabela)
public subroutine of_processa_atualizacao (long al_tabela)
public function boolean of_inicializa_variaveis (ref string as_log)
public function boolean of_insere_atualiza_fornecedor (boolean ab_fornecedor_novo, ref string as_log)
public function boolean of_proximo_cd_fornecedor (long al_filial, ref string as_cd_fornecedor, ref string as_log)
public function boolean of_verifica_tipo_pn (string as_cd_tipo_pn, ref string as_log)
public function boolean of_verifica_cd_cidade (string as_cd_cidade_ibge, ref long al_cd_cidade, ref string as_log)
public function boolean of_verifica_insere_pedido_edi (string as_id_pedido_edi, string as_de_pedido_edi, ref string as_log)
public function boolean of_deleta_fornecedor_contato (boolean ab_fornecedor_novo, string as_cd_fornecedor, ref string as_log)
public function boolean of_carrega_fornecedor_telefone (string as_cd_fornecedor_legado, long al_controle_pai, ref string as_log)
public function boolean of_carrega_fornecedor_email (string as_fornecedor_legado, long al_controle_pai, ref string as_log)
public function boolean of_verifica_codigo_contato_fornecedor (string as_de_contato_forn, ref long al_cd_contato_forn, ref string as_log)
public function boolean of_verifica_condicao_pagamento (string as_de_contato_forn, ref long al_cd_contato_forn, ref string as_log)
public function boolean of_insere_condicao_pagamento (long al_controle_pai, ref long al_codigo_pagto_legado, ref string as_log)
public function boolean of_valida_carrega_dados (long al_controle, ref string as_log)
public function boolean of_insere_contato_fornecedor (string as_de_contato_fornecedor, ref long al_codigo_contato_forn_legado, ref string as_log)
public function boolean of_insere_integracao_sap (long al_empresa, string as_tabela, string as_cd_legado, string as_cd_sap, string as_matricula, ref string as_log)
public function boolean of_insere_fornecedor_contato (string as_cd_fornecedor_legado, long al_controle_pai, ref string as_log)
public function boolean of_verifica_matricula_comprador (string as_matricula, ref string as_log)
end prototypes

public function boolean of_atualiza_fornecedor (long al_controle, long al_tabela);Boolean	lb_Sucesso

Long	ll_Linhas,&
		ll_Linha,&
		ll_Nulo,&
		ll_Achou, &
		ll_Atualizacao_Pend
		
String	ls_Coluna,&
		ls_Vl_Item,&
		ls_Obrig,&		
		ls_Log,&
		ls_Chave_Controle,&
		ls_cd_fornecedor_legado,&
		ls_novo_cd_fornecedor_legado

lb_Sucesso = False

SetNull(ll_Nulo)

Try
	uo_ge473_comum lo_Comum
	lo_Comum = Create uo_ge473_comum
				
	Select de_chave_sap
	  into :is_de_chave_acesso_sap
	  from interface_sap  i 
	 where i.cd_tabela 	= :il_tabela_fornecedor
		and i.nr_controle = :al_controle
	Using SqlCa;	
	
	If SqlCa.sqlcode = -1 Then
		ls_Log = "Erro ao buscar o controle na tabela interface_sap. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle)+". Erro: "+SqlCa.sqlErrText
		Return False
	End If	

	If Not lo_Comum.of_atualizacao_pendente(al_Controle, Ref ll_Atualizacao_Pend, Ref ls_Log) Then Return False

	//Controle j$$HEX1$$e100$$ENDHEX$$ foi processado
	If ll_Atualizacao_Pend = 0 Then Return True
	
	If Not lo_Comum.of_Muda_Situacao_Interface(al_Controle, Ref ls_Log) Then Return False
	If Not lo_Comum.of_localiza_chave_controle(al_Controle, Ref ls_Chave_Controle, Ref ls_Log) Then Return False
	
	If lo_Comum.of_processa_carrega_dados(al_controle , ref ls_Log) Then
		
		ll_Linhas = lo_Comum.ids_lista_registros.RowCount()
		
		If isvalid(w_aguarde_3) Then
			w_aguarde_3.uo_progress_2.of_reset()
			w_aguarde_3.uo_progress_2.of_setmax(ll_linhas)
		End if
		
		If ll_Linhas = 1 Then
			If Not This.of_Inicializa_Variaveis(Ref ls_Log) Then Return False
			
			il_cd_empresa = Long(lo_Comum.ids_lista_registros.Object.cd_empresa[1])
			is_origem_sap = lo_Comum.ids_lista_registros.Object.origem_sap[1]
			is_cd_fornecedor_sap = lo_Comum.ids_lista_registros.Object.cd_fornecedor_sap[1]
			is_cd_fornecedor_legado = lo_Comum.ids_lista_registros.Object.cd_fornecedor_legado[1] /*-*/
			is_cd_tipo_pn = Upper(lo_Comum.ids_lista_registros.Object.cd_tipo_pn[1])
			is_id_situacao = Upper(lo_Comum.ids_lista_registros.Object.id_situacao[1])
			is_nm_fornecedor = Upper(lo_Comum.ids_lista_registros.Object.nm_fornecedor[1])
			is_nm_sobrenome = Upper(lo_Comum.ids_lista_registros.Object.nm_sobrenome[1])
			is_nm_fantasia = Upper(lo_Comum.ids_lista_registros.Object.nm_fantasia[1])
			is_nm_razao_social = Upper(lo_Comum.ids_lista_registros.Object.nm_razao_social[1])
			is_nr_cgc = lo_Comum.ids_lista_registros.Object.nr_cgc[1]
			is_nr_cpf = lo_Comum.ids_lista_registros.Object.nr_cpf[1]
			is_id_atividade_economica = lo_Comum.ids_lista_registros.Object.id_atividade_economica[1]
			is_nr_inscricao_estadual = lo_Comum.ids_lista_registros.Object.nr_inscricao_estadual[1]
			is_nr_cep = lo_Comum.ids_lista_registros.Object.nr_cep[1]
			is_de_endereco = Upper(lo_Comum.ids_lista_registros.Object.de_endereco[1])
			il_nr_endereco = Long(lo_Comum.ids_lista_registros.Object.nr_endereco[1])
			is_de_bairro = Upper(lo_Comum.ids_lista_registros.Object.de_bairro[1])
			is_cd_cidade_ibge = lo_Comum.ids_lista_registros.Object.cd_cidade_ibge[1]
			is_nm_cidade = Upper(lo_Comum.ids_lista_registros.Object.nm_cidade[1])
			is_cd_uf = lo_Comum.ids_lista_registros.Object.cd_uf[1]
			is_nr_matricula_comprador = lo_Comum.ids_lista_registros.Object.nr_matricula_comprador[1]
			is_cd_condicao_pagamento_sap = Upper(lo_Comum.ids_lista_registros.Object.cd_condicao_pagamento[1])
			is_id_regime_tributario = lo_Comum.ids_lista_registros.Object.id_regime_tributario[1]
			is_id_regime_especial = lo_Comum.ids_lista_registros.Object.id_regime_especial[1]
			is_id_pedido_edi = Upper(lo_Comum.ids_lista_registros.Object.id_pedido_edi[1])
			is_de_pedido_edi = Upper(lo_Comum.ids_lista_registros.Object.de_pedido_edi[1])
			is_id_considera_ipi_pedido = lo_Comum.ids_lista_registros.Object.id_considera_ipi_pedido[1]
			
			If Not lo_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.vl_pedido_minimo[1], 'VL_PEDIDO_MINIMO', ref idc_vl_pedido_minimo, ref ls_log) Then Return False
			
			is_id_parceiro = lo_Comum.ids_lista_registros.Object.id_parceiro[1]
			is_de_dados_adicionais = Upper(lo_Comum.ids_lista_registros.Object.de_dados_adicionais[1])
			
			If Not lo_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.pc_desconto_financeiro[1], 'PC_DESCONTO_FINANCEIRO', ref idc_pc_desconto_financeiro, ref ls_log) Then Return False
			If Not lo_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.pc_desconto_usual[1], 'PC_DESCONTO_USUAL', ref idc_pc_desconto_usual, ref ls_log) Then Return False
			
			is_id_recebe_email_xml = lo_Comum.ids_lista_registros.Object.id_recebe_email_xml[1]
			is_de_endereco_email_envio_xml = lo_Comum.ids_lista_registros.Object.de_endereco_email_envio_xml[1]
			is_id_importacao = lo_Comum.ids_lista_registros.Object.id_importacao[1]
			is_id_tipo = lo_Comum.ids_lista_registros.Object.id_tipo[1]
			is_cd_grupo = lo_Comum.ids_lista_registros.Object.cd_grupo[1]
			is_cd_subgrupo = lo_Comum.ids_lista_registros.Object.cd_subgrupo[1]
			is_cd_pais = lo_Comum.ids_lista_registros.Object.cd_pais[1]
			is_nm_contato = lo_Comum.ids_lista_registros.Object.nm_contato[1]
			
			If This.of_Valida_Carrega_Dados(al_controle, Ref ls_Log) Then
				
				If This.Of_Insere_Atualiza_Fornecedor(ib_Fornecedor_Novo, Ref ls_Log ) Then
					If This.Of_Deleta_Fornecedor_Contato(ib_Fornecedor_Novo, is_cd_fornecedor_legado, Ref ls_Log) Then
						If This.Of_Insere_Fornecedor_Contato(is_cd_fornecedor_legado, al_controle, Ref ls_Log) Then
							lb_Sucesso	= True
						End If
					End If
				End If
				
			End If
			
			If isvalid(w_aguarde_3) Then
				w_aguarde_3.uo_progress_2.of_setprogress(1)
			End if	
			
		Else
			ls_Log  = "Quantidade de registros recebido na interface esta diferente do esperado 1 para a tabela [interface_sap]. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle)+"."
			Return False
		End If

	End If
	
Catch ( runtimeerror  lo_rte )
	ls_Log = "Objeto [uo_ge473_fornecedor], fun$$HEX2$$e700e300$$ENDHEX$$o [of_atualiza_fornecedor]. Erro: "+lo_rte.GetMessage( )
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

public subroutine of_processa_atualizacao (long al_tabela);Long ll_Linhas
Long ll_Linha

dc_uo_ds_base lds 

Try 
	
	lds  = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject('ds_ge473_lista_controles', False) Then 
		gvo_aplicacao.of_grava_log("Interface Fornecedor - Erro alterar a DW [ds_ge473_lista_controles] - uo_ge473_fornecedor.of_processa_atualizacao" )
		Return
	End If
	
	ll_Linhas = lds.Retrieve(il_tabela_fornecedor)
	
	If ll_Linhas > 0 Then
		For ll_Linha = 1 To ll_Linhas
			uo_ge473_fornecedor luo_ge473_fornecedor
			 
			Try
				luo_ge473_fornecedor = Create uo_ge473_fornecedor
				luo_ge473_fornecedor.of_atualiza_fornecedor( lds.Object.nr_controle[ll_Linha], il_tabela_fornecedor )

			Finally
				Destroy(luo_ge473_fornecedor)
			End Try
		Next
	ElseIf ll_Linhas < 0 Then
		gvo_aplicacao.of_grava_log("Interface Fornecedor - Erro ao recuperar os da DW [ds_ge473_lista_controles] - uo_ge473_fornecedor.of_processa_atualizacao.")
	End If	
	
Finally
	Destroy lds
End try
end subroutine

public function boolean of_inicializa_variaveis (ref string as_log);Try
	SetNull(as_log)
	SetNull(idh_Situacao)

	SetNull(idc_pc_desconto_financeiro)
	SetNull(idc_pc_desconto_usual)
	SetNull(idc_vl_pedido_minimo)
	
	SetNull(il_cd_condicao_pagamento)
	SetNull(is_cd_condicao_pagamento_sap)
	SetNull(il_cd_condicao_pagamento_legado)
	
	SetNull(is_cd_cidade_ibge)
	SetNull(il_nr_endereco)
	SetNull(il_cd_cidade)
	SetNull(il_cd_empresa)
	
	SetNull(is_cd_fornecedor_legado)
	SetNull(is_cd_fornecedor_sap)
	SetNull(is_cd_grupo)
	SetNull(is_cd_pais)
	SetNull(is_cd_subgrupo)
	SetNull(is_cd_tipo_pn)
	SetNull(is_cd_uf)
	SetNull(is_de_bairro)
	SetNull(is_de_dados_adicionais)
	SetNull(is_de_endereco)
	SetNull(is_de_endereco_email_envio_xml)
	SetNull(is_de_observacao)
	SetNull(is_de_pedido_edi)
	SetNull(is_id_atividade_economica)
	SetNull(is_id_considera_ipi_pedido)
	SetNull(is_id_importacao)
	SetNull(is_id_parceiro)
	SetNull(is_id_pedido_edi)
	SetNull(is_id_principal)
	SetNull(is_id_recebe_email_xml)
	SetNull(is_id_regime_especial)
	SetNull(is_id_regime_tributario)
	SetNull(is_id_situacao)
	SetNull(is_id_tipo)
	SetNull(is_nm_cidade)
	SetNull(is_nm_contato)
	SetNull(is_nm_fantasia)
	SetNull(is_nm_fornecedor)
	SetNull(is_nm_razao_social)
	SetNull(is_nm_sobrenome)
	SetNull(is_nr_cep)
	SetNull(is_nr_cgc)
	SetNull(is_nr_cpf)
	SetNull(is_nr_inscricao_estadual)
	SetNull(is_nr_matricula_comprador)
	SetNull(is_origem_sap)

Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro ao ao iniciar as vari$$HEX1$$e100$$ENDHEX$$veis. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try

Return True
end function

public function boolean of_insere_atualiza_fornecedor (boolean ab_fornecedor_novo, ref string as_log);Try
	
	If ab_fornecedor_novo Then
		INSERT INTO fornecedor (
				 cd_fornecedor,
				 id_fornecedor_transportadora,
				 cd_filial,
				 nm_fantasia,
				 nm_razao_social,
				 id_fisica_juridica,
				 nr_cgc,
				 nr_cpf,
				 nr_inscricao_estadual,
				 cd_cidade,
				 de_endereco,
				 de_bairro,
				 nr_cep,
				 pc_desconto_usual,
				 nm_contato,
				 id_regime_especial,
				 id_carregado_as400,
				 cd_condicao_pagamento,
				 pc_desconto_financeiro,
				 nr_prioridade_distribuicao,
				 id_situacao,
				 id_recebe_email_xml,
				 de_endereco_email_envio_xml,
				 nr_matricula_comprador,
				 id_considera_ipi_pedido,
				 id_regime_tributario,
				 nr_endereco,
				 id_pedido_edi,
				 de_dados_adicionais,
				 id_atividade_economica,
				 dh_inclusao,
				 id_importacao_nfe,
				 id_parceiro,
				 cd_fornecedor_sap,
				 vl_minimo_pedido
			) VALUES (
				 :is_cd_fornecedor_legado,
				 :is_id_fornecedor_transportadora, 
				 :il_cd_filial,
				 :is_nm_fantasia,
				 :is_nm_razao_social,
				 :is_id_fisica_juridica,
				 :is_nr_cgc,
				 :is_nr_cpf,
				 :is_nr_inscricao_estadual,
				 :il_cd_cidade,
				 :is_de_endereco,
				 :is_de_bairro,
				 :is_nr_cep,
				 :idc_pc_desconto_usual,
				 :is_nm_contato,
				 :is_id_regime_especial,
				 :is_id_carregado_as400,
				 :il_cd_condicao_pagamento_legado,
				 :idc_pc_desconto_financeiro,
				 NULL,
				 :is_id_situacao,
				 :is_id_recebe_email_xml,
				 :is_de_endereco_email_envio_xml,
				 :is_nr_matricula_comprador,
				 :is_id_considera_ipi_pedido,
				 :is_id_regime_tributario,
				 :il_nr_endereco,
				 :is_id_pedido_edi,
				 :is_de_dados_adicionais,
				 :is_id_atividade_economica,
				 getdate(),
				 :is_id_importacao,
				 :is_id_parceiro,
				 :is_cd_fornecedor_sap,
				 :idc_vl_pedido_minimo
			)
		 Using SqlCa;
		 
		 If SqlCa.sqlcode = -1 Then
			as_Log = "Erro ao inserir registro na tabela 'fornecedor'. Fornecedor SAP: "+ This.is_cd_fornecedor_sap + ", Legado: " + this.is_cd_fornecedor_legado + ". Erro: "+ SqlCa.SqlErrText
			Return False
		End If	
		 
	Else
		UPDATE fornecedor SET
			 id_fornecedor_transportadora = :is_id_fornecedor_transportadora,
			 cd_filial = :il_cd_filial,
			 nm_fantasia = :is_nm_fantasia,
			 nm_razao_social = :is_nm_razao_social,
			 id_fisica_juridica = :is_id_fisica_juridica,
			 nr_cgc = :is_nr_cgc,
			 nr_cpf = :is_nr_cpf,
			 nr_inscricao_estadual = :is_nr_inscricao_estadual,
			 cd_cidade = :il_cd_cidade,
			 de_endereco = :is_de_endereco,
			 de_bairro = :is_de_bairro,
			 nr_cep = :is_nr_cep,
			 pc_desconto_usual = :idc_pc_desconto_usual,
			 nm_contato = :is_nm_contato,
			 id_regime_especial = :is_id_regime_especial,
			 id_carregado_as400 = :is_id_carregado_as400,
			 cd_condicao_pagamento = :il_cd_condicao_pagamento_legado,
			 pc_desconto_financeiro = :idc_pc_desconto_financeiro,
			 nr_prioridade_distribuicao = NULL,
			 id_situacao = :is_id_situacao,
			 id_recebe_email_xml = :is_id_recebe_email_xml,
			 de_endereco_email_envio_xml = :is_de_endereco_email_envio_xml,
			 nr_matricula_comprador = :is_nr_matricula_comprador,
			 id_considera_ipi_pedido = :is_id_considera_ipi_pedido,
			 id_regime_tributario = :is_id_regime_tributario,
			 nr_endereco = :il_nr_endereco,
			 id_pedido_edi = :is_id_pedido_edi,
			 de_dados_adicionais = :is_de_dados_adicionais,
			 id_atividade_economica = :is_id_atividade_economica,
			 dh_atualizacao = getdate(), 
			 nr_matricula_atualizacao = '14330', 
			 id_importacao_nfe = :is_id_importacao,
			 id_parceiro = :is_id_parceiro,
			 cd_fornecedor_sap = :is_cd_fornecedor_sap,
			 vl_minimo_pedido = :idc_vl_pedido_minimo
		WHERE
			 cd_fornecedor = :is_cd_fornecedor_legado
		Using SqlCa;
		 
		 If SqlCa.sqlcode = -1 Then
			as_Log = "Erro ao atualizar Fornecedor'. Fornecedor SAP: "+ This.is_cd_fornecedor_sap + ", Legado: " + this.is_cd_fornecedor_legado + ". Erro: "+ SqlCa.SqlErrText
			Return False
		End If	
		
	End If
	
Catch ( runtimeerror  lo_rte )
	as_Log =  "Objeto [uo_ge473_fornecedor], fun$$HEX2$$e700e300$$ENDHEX$$o [of_insere_atualiza_fornecedor]. Erro: "+lo_rte.GetMessage( )
	Return False	
Finally
	//
End Try	

Return True
			
end function

public function boolean of_proximo_cd_fornecedor (long al_filial, ref string as_cd_fornecedor, ref string as_log);String ls_Ultimo_Codigo, ls_Novo_Codigo

SetNull(as_cd_fornecedor)

Try

	Select vl_parametro
	Into :ls_Ultimo_Codigo
	From parametro_geral
	Where cd_parametro = 'CD_FORNECEDOR'
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		as_log = 'Erro ao buscar o $$HEX1$$fa00$$ENDHEX$$ltimo c$$HEX1$$f300$$ENDHEX$$digo do fornecedor na tabela parametro_geral. Erro: ' + Sqlca.sqlerrtext
		Return False
	End If
	
	If Not IsNumber(ls_Ultimo_Codigo) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "$$HEX1$$da00$$ENDHEX$$ltimo c$$HEX1$$f300$$ENDHEX$$digo do fornecedor inv$$HEX1$$e100$$ENDHEX$$lido, n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ um n$$HEX1$$fa00$$ENDHEX$$mero v$$HEX1$$e100$$ENDHEX$$lido.", StopSign!)
		Return False
	End If
	
	ls_Novo_Codigo = String(Long(ls_Ultimo_Codigo) + 1)
	
	as_cd_fornecedor = '0' + string(al_filial) + ls_Novo_Codigo
	
	Update parametro_geral
	Set vl_parametro = :ls_Novo_Codigo
	Where cd_parametro = 'CD_FORNECEDOR'
	  and vl_parametro = :ls_Ultimo_Codigo
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		as_log = 'Erro ao atualizar o parametro CD_FORNECEDOR. Erro: ' + Sqlca.sqlerrtext
		Return False
	End If
	
	If Not This.Of_insere_integracao_sap( il_cd_empresa, 'FORNECEDOR', as_cd_fornecedor, is_cd_fornecedor_sap, '14330', Ref as_log) Then
		Return False
	End If

Catch ( runtimeerror  lo_rte )
	as_Log =  "Objeto [uo_ge473_fornecedor], fun$$HEX2$$e700e300$$ENDHEX$$o [of_proximo_cd_fornecedor]. Erro: "+lo_rte.GetMessage( )
	Return False	
Finally
	//
End Try	

Return True
end function

public function boolean of_verifica_tipo_pn (string as_cd_tipo_pn, ref string as_log);//C$$HEX1$$f300$$ENDHEX$$digo	Parceiro de Neg$$HEX1$$f300$$ENDHEX$$cio
//F001	Fornecedor - Revenda Nacional (PJ)
//F002	Fornecedor - Revenda Nacional (PF)
//F003	Fornecedor - Revenda Importado
//F004	Fornecedor - Imobilizado Nacional (PJ)
//F005	Fornecedor - Imobilizado Importado
//F006	Fornecedor - Uso & Consumo Nacional (PJ)
//F007	Fornecedor - Uso & Consumo Nacional (PF)
//F008	Fornecedor - Uso & Consumo Importado
//F009	Fornecedor - Servi$$HEX1$$e700$$ENDHEX$$o Nacional (PJ)
//F010	Fornecedor - Servi$$HEX1$$e700$$ENDHEX$$o Nacional (PF)
//F011	Fornecedor - Servi$$HEX1$$e700$$ENDHEX$$o Importado
//F012	Transportadora Nacional PJ
//F013	Transportadora Nacional PF
Try
	
	If Not IsNull(as_cd_tipo_pn) then
		If Pos(as_cd_tipo_pn, "F001") > 0 or &
			Pos(as_cd_tipo_pn, "F002") > 0 or &
			Pos(as_cd_tipo_pn, "F003") > 0 or &
			Pos(as_cd_tipo_pn, "F004") > 0 or &
			Pos(as_cd_tipo_pn, "F005") > 0 or &
			Pos(as_cd_tipo_pn, "F006") > 0 or &
			Pos(as_cd_tipo_pn, "F007") > 0 or &
			Pos(as_cd_tipo_pn, "F008") > 0 or &
			Pos(as_cd_tipo_pn, "F009") > 0 or &
			Pos(as_cd_tipo_pn, "F010") > 0 or &
			Pos(as_cd_tipo_pn, "F011") > 0 or &
			Pos(as_cd_tipo_pn, "F012") > 0 or &
			Pos(as_cd_tipo_pn, "F013") > 0 Then
			Return True
		Else
			as_log = 'Aviso: Tipo Parceiro Neg$$HEX1$$f300$$ENDHEX$$cio diferente dos padr$$HEX1$$f500$$ENDHEX$$es CLAMED'
			//Return  //No java nao trava o continuar do cadastro do fornecedor, s$$HEX1$$f300$$ENDHEX$$ deixa registrado este aviso
		End if
	End if
	
Catch ( runtimeerror  lo_rte )
	as_Log =  "Objeto [uo_ge473_fornecedor], fun$$HEX2$$e700e300$$ENDHEX$$o [of_verifica_tipo_pn]. Erro: "+lo_rte.GetMessage( )
	Return False	
Finally
	//
End Try	

Return True

end function

public function boolean of_verifica_cd_cidade (string as_cd_cidade_ibge, ref long al_cd_cidade, ref string as_log);Try
	
	Select  min(a.cd_cidade)
	Into :al_cd_cidade
	from cidade a
	inner join ect_localidade b on b.nr_localidade = a.nr_localidade_ect
	where b.cd_cidade_ibge = :as_cd_cidade_ibge
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case -1
			as_Log = "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o da cidade com o c$$HEX1$$f300$$ENDHEX$$digo IBGE '"+as_cd_cidade_ibge+"' " + SqlCa.SqlerrText
			Return False
	End Choose
	
	if IsNull(al_cd_cidade) or al_cd_cidade <= 0 then
		Select  min(cd_cidade)
		Into :al_cd_cidade 
		from cidade
		where cd_cidade_ibge = :as_cd_cidade_ibge
		Using SqlCa;
		
		Choose Case SqlCa.SqlCode
			Case 100
				as_Log = "N$$HEX1$$e300$$ENDHEX$$o foi localizado nenhuma cidade com c$$HEX1$$f300$$ENDHEX$$digo IBGE '"+as_cd_cidade_ibge+"'."
				Return False
			Case -1
				as_Log = "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o da cidade com c$$HEX1$$f300$$ENDHEX$$digo IBGE '"+as_cd_cidade_ibge+"' " + SqlCa.SqlerrText
				Return False
		End Choose
	end if
Catch ( runtimeerror  lo_rte )
	as_Log =  "Objeto [uo_ge473_fornecedor], fun$$HEX2$$e700e300$$ENDHEX$$o [of_verifica_cd_cidade]. Erro: "+lo_rte.GetMessage( )
	Return False	
Finally
	//
End Try	

Return True




end function

public function boolean of_verifica_insere_pedido_edi (string as_id_pedido_edi, string as_de_pedido_edi, ref string as_log);Long ll_achou

Try

	Select count(*)
	Into :ll_achou
	From tipo_pedido_edi
	Where id_pedido_edi = :as_id_pedido_edi
			And de_pedido_edi = :as_de_pedido_edi
	Using SqlCa;
	
	If SqlCa.sqlcode = -1 Then
		as_log = 'Erro ao procurar o tipo_pedido_edi. Erro: ' + sqlca.sqlerrtext
		Return False
	End If
	
	If IsNull(ll_achou) Or ll_achou = 0 Then
		INSERT INTO tipo_pedido_edi
				(id_pedido_edi, 
				de_pedido_edi, 
				id_situacao)
		VALUES(
					:as_id_pedido_edi, 
					:as_de_pedido_edi, 
					'A')
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			as_log = 'Erro ao inserir tipo_pedido_edi. Erro: ' + SqlCa.sqlerrtext
			Return False
		End If
		
		If Not This.Of_insere_integracao_sap( il_cd_empresa, 'TIPO_PEDIDO_EDI', as_id_pedido_edi, as_id_pedido_edi, '14330', Ref as_log) Then
			Return False
		End If
		
	End If		
	
Catch ( runtimeerror  lo_rte )
	as_Log =  "Objeto [uo_ge473_fornecedor], fun$$HEX2$$e700e300$$ENDHEX$$o [of_verifica_insere_pedido_edi]. Erro: "+lo_rte.GetMessage( )
	Return False	
Finally
	//
End Try	

Return True

end function

public function boolean of_deleta_fornecedor_contato (boolean ab_fornecedor_novo, string as_cd_fornecedor, ref string as_log);Try

	If ab_fornecedor_novo Then
		Return True
	Else
		Delete From fornecedor_contato
		Where cd_fornecedor = :as_cd_fornecedor
		And nr_divisao_fornecedor is null
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			as_log = 'Erro ao deletar dados de contatos do fornecedor na tabela fornecedor_contato. Erro: ' + Sqlca.sqlerrtext
			Return False
		End If
	End If

Catch ( runtimeerror  lo_rte )
	as_Log =  "Objeto [uo_ge473_fornecedor], fun$$HEX2$$e700e300$$ENDHEX$$o [of_deleta_fornecedor_contato]. Erro: "+lo_rte.GetMessage( )
	Return False	
Finally
	//
End Try	

Return True
end function

public function boolean of_carrega_fornecedor_telefone (string as_cd_fornecedor_legado, long al_controle_pai, ref string as_log);Long ll_Controle_filho, ll_Linha, ll_Linhas, ll_Pos, ll_str_linha, ll_str_linhas, ll_Codigo_Tipo_Contato

String ls_Requisicao_Chave, &
			ls_nm_contato, &
			ls_de_contato_fornecedor, &
			ls_ddd_telefone,&
			ls_de_observacao_forn_tel,&
			ls_id_principal_forn_tel,&
			ls_nr_telefone	,&
			ls_nr_telefone_extensao

Try
			
	SELECT nr_controle, de_chave_sap
	Into :ll_Controle_filho, :ls_Requisicao_Chave
	FROM interface_sap  i 
	Where i.cd_tabela = :il_tabela_fornecedor_telefone
		and i.nr_controle_pai = :al_controle_pai
	Using SqlCa;	

	If SqlCa.sqlcode = -1 Then
		as_Log	= "Erro ao buscar o controle filho fornecedor>telefone na tabela interface_sap. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle_pai)+". Erro: "+SqlCa.sqlErrText
		Return False
	End If
	
	If IsNull(ls_Requisicao_Chave) Or Trim(ls_Requisicao_Chave)="" Then
		as_Log  = "" //Caso n$$HEX1$$e300$$ENDHEX$$o tenha nada ignora o fornecedor telefone //"N$$HEX1$$fa00$$ENDHEX$$mero da chave de acesso informada na INTERFACE_SAP do filho est$$HEX1$$e100$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido. Fun$$HEX2$$e700e300$$ENDHEX$$o of_carrega_fornecedor_telefone"
		Return False
	Else
		If Trim(ls_Requisicao_Chave) <> Trim(This.is_de_chave_acesso_sap ) Then
			as_Log  = "N$$HEX1$$fa00$$ENDHEX$$mero da chave de acesso da INTERFACE_SAP pai e filho est$$HEX1$$e300$$ENDHEX$$o diferentes. Fun$$HEX2$$e700e300$$ENDHEX$$o of_carrega_fornecedor_telefone"
			Return False
		End If
	End If
	
	uo_ge473_comum lo_Comum3
	lo_Comum3 = Create uo_ge473_comum
			
	If lo_Comum3.of_processa_carrega_dados(ll_Controle_filho, ref as_Log) Then		
		ll_Linhas = lo_Comum3.ids_lista_registros.RowCount()	
		If ll_Linhas > 0 Then
			For ll_Linha = 1 To ll_Linhas
				
				// fornecedor_telefone
				ls_de_observacao_forn_tel 	= lo_Comum3.ids_lista_registros.Object.de_observacao			[ll_Linha]
				ls_nr_telefone 					= lo_Comum3.ids_lista_registros.Object.nr_telefone				[ll_Linha]
				ls_nr_telefone_extensao 		= lo_Comum3.ids_lista_registros.Object.nr_telefone_extensao	[ll_Linha]
				ls_id_principal_forn_tel 		= lo_Comum3.ids_lista_registros.Object.id_principal				[ll_Linha]
				
				If IsNull(ls_nr_telefone) or Trim(ls_nr_telefone) = "" then
					as_log = "N$$HEX1$$fa00$$ENDHEX$$mero de Telefone est$$HEX1$$e100$$ENDHEX$$ vazio!"
					Return False
				End if
				
				If Not IsNull(ls_id_principal_forn_tel) or Trim(ls_id_principal_forn_tel) <> "" then
					ls_id_principal_forn_tel = 'S'
				End if
				
				If Not IsNull(ls_de_observacao_forn_tel) or Not Trim(ls_de_observacao_forn_tel) = "" then
					ll_Pos = Pos(ls_de_observacao_forn_tel, ":")
				
					ls_de_contato_fornecedor 	= Trim(Left(ls_de_observacao_forn_tel, ll_Pos - 1))
					ls_nm_contato 					= Trim(Mid(ls_de_observacao_forn_tel, ll_Pos + 1))
				End if
				
				If Isnull(ls_de_contato_fornecedor) Or Trim(ls_de_contato_fornecedor) = "" Then ls_de_contato_fornecedor = 'OUTROS'
				
				Setnull(ll_Codigo_Tipo_Contato)
				
				If Not This.of_verifica_codigo_contato_fornecedor( ls_de_contato_fornecedor, Ref ll_Codigo_Tipo_Contato, Ref as_log) Then
					If Not This.of_insere_contato_fornecedor( ls_de_contato_fornecedor, Ref ll_Codigo_Tipo_Contato, Ref as_log) Then
						Return False
					End If
				End If
	
				ls_nr_telefone = gf_retorna_so_numeros(ls_nr_telefone)
				ls_ddd_telefone = Left(ls_nr_telefone, 2)
				ls_nr_telefone = Mid(ls_nr_telefone, 3)
				
				ll_str_linhas = Upperbound(istr_forn_contato[])
				If ll_str_linhas > 0 Then
					For ll_str_linha = 1 To ll_str_linhas
						If istr_forn_contato[ll_str_linha].nm_contato = ls_nm_contato And istr_forn_contato[ll_str_linha].cd_contato = ll_Codigo_Tipo_Contato Then
							istr_forn_contato[ll_str_linha].nr_ddd_telefone = ls_ddd_telefone
							istr_forn_contato[ll_str_linha].nr_telefone 		= ls_nr_telefone
							istr_forn_contato[ll_str_linha].id_principal_tel	= ls_id_principal_forn_tel
						End If
					Next
				Else
					istr_forn_contato[ll_Linha].cd_fornecedor 		= as_cd_fornecedor_legado
					istr_forn_contato[ll_Linha].cd_contato			= ll_Codigo_Tipo_Contato
					istr_forn_contato[ll_Linha].nr_contato 			= ll_Linha
					istr_forn_contato[ll_Linha].nr_ddd_telefone 		= ls_ddd_telefone
					istr_forn_contato[ll_Linha].nr_telefone 			= ls_nr_telefone
					istr_forn_contato[ll_Linha].id_principal_tel		= ls_id_principal_forn_tel
					istr_forn_contato[ll_Linha].nm_contato			= ls_nm_contato
				End If
				
			Next	
		End If
	Else
		Return False				
	End If
	
Catch ( runtimeerror  lo_rte )
	as_Log =  "Objeto [uo_ge473_fornecedor], fun$$HEX2$$e700e300$$ENDHEX$$o [of_carrega_fornecedor_telefone]. Erro: "+lo_rte.GetMessage( )
	Return False	
Finally
	If IsValid(lo_Comum3) Then Destroy(lo_Comum3)
End Try	

Return True
			
end function

public function boolean of_carrega_fornecedor_email (string as_fornecedor_legado, long al_controle_pai, ref string as_log);Long ll_Controle_filho, ll_Linha, ll_Linhas, ll_Pos, ll_Codigo_Tipo_Contato, ll_nr_contato

String ls_Requisicao_Chave, &
		ls_de_contato_fornecedor, &
		ls_nm_contato, &
		ls_de_observacao_forn_email,&
		ls_de_email_forn_email, &
		ls_id_principal_forn_email 

Try
			
	SELECT nr_controle, de_chave_sap
	Into :ll_Controle_filho, :ls_Requisicao_Chave
	FROM interface_sap  i 
	Where i.cd_tabela = :il_tabela_fornecedor_email
		and i.nr_controle_pai = :al_controle_pai
	Using SqlCa;	

	If SqlCa.sqlcode = -1 Then
		as_Log	= "Erro ao buscar o controle filho fornecedor>email na tabela interface_sap. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle_pai)+". Erro: "+SqlCa.sqlErrText
		Return False
	End If
	
	If IsNull(ls_Requisicao_Chave) Or Trim(ls_Requisicao_Chave)="" Then
		as_Log  = "" //Caso n$$HEX1$$e300$$ENDHEX$$o tenha nada ignora o fornecedor email //"N$$HEX1$$fa00$$ENDHEX$$mero da chave de acesso informada na INTERFACE_SAP do filho est$$HEX1$$e100$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido. Fun$$HEX2$$e700e300$$ENDHEX$$o of_carrega_fornecedor_email"
		Return False
	Else
		If Trim(ls_Requisicao_Chave) <> Trim(This.is_de_chave_acesso_sap ) Then
			as_Log  = "N$$HEX1$$fa00$$ENDHEX$$mero da chave de acesso da INTERFACE_SAP pai e filho est$$HEX1$$e300$$ENDHEX$$o diferentes. Fun$$HEX2$$e700e300$$ENDHEX$$o of_carrega_fornecedor_email"
			Return False
		End If
	End If
	
	uo_ge473_comum lo_Comum2
	lo_Comum2 = Create uo_ge473_comum
			
	If lo_Comum2.of_processa_carrega_dados(ll_Controle_filho, ref as_Log) Then		
		ll_Linhas = lo_Comum2.ids_lista_registros.RowCount()	

		If ll_Linhas > 0 Then
			SELECT
				max(nr_contato)
			INTO
				:ll_nr_contato
			FROM
				fornecedor_contato
			WHERE
				cd_fornecedor = :as_fornecedor_legado;
				
			If SQLCA.SQLCode = -1 Then
				as_Log  = "Erro ao buscar o n$$HEX1$$fa00$$ENDHEX$$mero sequencial do contato do fornecedor. Fun$$HEX2$$e700e300$$ENDHEX$$o of_carrega_fornecedor_email. Erro: " + SQLCA.SQLErrText
				Return False
			Else
				if IsNull(ll_nr_contato) then
					ll_nr_contato = 0
				end if
			End If
			
			For ll_Linha = 1 To ll_Linhas
				// fornecedor_email
				ls_de_observacao_forn_email 	= Upper(lo_Comum2.ids_lista_registros.Object.de_observacao	[ll_Linha])
				ls_de_email_forn_email 			= Lower(lo_Comum2.ids_lista_registros.Object.de_email		[ll_Linha])
				ls_id_principal_forn_email 		= Upper(lo_Comum2.ids_lista_registros.Object.id_principal		[ll_Linha])
				
				If IsNull(ls_de_email_forn_email) or Trim(ls_de_email_forn_email) = "" then
					as_log = "Email est$$HEX1$$e100$$ENDHEX$$ vazio!"
					Return False
				End if
				
				If Not IsNull(ls_id_principal_forn_email) Or Trim(ls_id_principal_forn_email) <> "" then
					ls_id_principal_forn_email = 'S'
				End if
				
				If Not IsNull(ls_de_observacao_forn_email) Or Not Trim(ls_de_observacao_forn_email) = "" then
					ll_Pos = Pos(ls_de_observacao_forn_email, ":")
				
					ls_de_contato_fornecedor 	= Trim(Left(ls_de_observacao_forn_email, ll_Pos - 1))
					ls_nm_contato 					= Trim(Mid(ls_de_observacao_forn_email, ll_Pos + 1))
				End if
				
				If Isnull(ls_de_contato_fornecedor) Or Trim(ls_de_contato_fornecedor) = "" Then ls_de_contato_fornecedor = 'OUTROS'
				
				Setnull(ll_Codigo_Tipo_Contato)
				
				If Not This.of_verifica_codigo_contato_fornecedor( ls_de_contato_fornecedor, Ref ll_Codigo_Tipo_Contato, Ref as_log) Then
					If Not This.of_insere_contato_fornecedor( ls_de_contato_fornecedor, Ref ll_Codigo_Tipo_Contato, Ref as_log) Then
						Return False
					End If
				End If
				
				ll_nr_contato ++
	
				istr_forn_contato[ll_Linha].cd_fornecedor 		= as_fornecedor_legado
				istr_forn_contato[ll_Linha].nr_contato 			= ll_nr_contato
				istr_forn_contato[ll_Linha].cd_contato				= ll_Codigo_Tipo_Contato
				istr_forn_contato[ll_Linha].nm_contato				= ls_nm_contato
				istr_forn_contato[ll_Linha].de_email				= ls_de_email_forn_email
				istr_forn_contato[ll_Linha].id_principal_email	= ls_id_principal_forn_email
				
			Next	
		End If
	Else
		Return False				
	End If
	
Catch ( runtimeerror  lo_rte )
	as_Log =  "Objeto [uo_ge473_fornecedor], fun$$HEX2$$e700e300$$ENDHEX$$o [of_carrega_fornecedor_email]. Erro: "+lo_rte.GetMessage( )
	Return False	
Finally
	If IsValid(lo_Comum2) Then Destroy(lo_Comum2)
End Try	

Return True
			
end function

public function boolean of_verifica_codigo_contato_fornecedor (string as_de_contato_forn, ref long al_cd_contato_forn, ref string as_log);Try
	SELECT cd_contato
	INTO :al_cd_contato_forn
	FROM contato_fornecedor
	WHERE de_contato = :as_de_contato_forn
	Using SqlCa;
	
	If SqlCa.sqlcode = -1 Then
		as_log = 'Erro ao verificar c$$HEX1$$f300$$ENDHEX$$digo do tipo do contato do fornecedor. Erro: ' + sqlca.sqlerrtext
		Return False
	End If
	
	If IsNull(al_cd_contato_forn) Then
		Return False
	End If
	
Catch ( runtimeerror  lo_rte )
	as_Log =  "Objeto [uo_ge473_fornecedor], fun$$HEX2$$e700e300$$ENDHEX$$o [of_verifica_codigo_contato_fornecedor]. Erro: "+lo_rte.GetMessage( )
	Return False	
Finally
	//
End Try	

Return True

end function

public function boolean of_verifica_condicao_pagamento (string as_de_contato_forn, ref long al_cd_contato_forn, ref string as_log);Try
	
	SELECT cd_contato
	INTO :al_cd_contato_forn
	FROM contato_fornecedor
	WHERE de_contato = :as_de_contato_forn
	Using SqlCa;
	
	If SqlCa.sqlcode = -1 Then
		as_log = 'Erro ao verificar c$$HEX1$$f300$$ENDHEX$$digo do tipo do contato do fornecedor. Erro: ' + sqlca.sqlerrtext
		Return False
	End If
	
Catch ( runtimeerror  lo_rte )
	as_Log =  "Objeto [uo_ge473_fornecedor], fun$$HEX2$$e700e300$$ENDHEX$$o [of_verifica_condicao_pagamento]. Erro: "+lo_rte.GetMessage( )
	Return False	
Finally
	//
End Try	

Return True

end function

public function boolean of_insere_condicao_pagamento (long al_controle_pai, ref long al_codigo_pagto_legado, ref string as_log);Long ll_Controle_filho, ll_Linha, ll_Linhas, ll_nr_parcela, ll_nr_dias, ll_condicao_pagto_legado
String ls_Requisicao_Chave, ls_de_condicao_pagamento, ls_cd_condicao_pagamento_sap, ls_pc_valor
Decimal ldc_pc_valor

Try
			
	SELECT nr_controle, de_chave_sap
	Into :ll_Controle_filho, :ls_Requisicao_Chave
	FROM interface_sap  i 
	Where i.cd_tabela = :il_tabela_fornecedor_cond_pagto
		and i.nr_controle_pai = :al_controle_pai
	Using SqlCa;	

	If SqlCa.sqlcode = -1 Then
		as_Log	= "Erro ao buscar o controle filho fornecedor>condicao_pagto na tabela interface_sap. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle_pai)+". Erro: "+SqlCa.sqlErrText
		Return False
	End If
	
	If IsNull(ls_Requisicao_Chave) Or Trim(ls_Requisicao_Chave)="" Then
		as_Log  = "N$$HEX1$$fa00$$ENDHEX$$mero da chave de acesso informada na INTERFACE_SAP do filho est$$HEX1$$e100$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido. Fun$$HEX2$$e700e300$$ENDHEX$$o of_insere_condicao_pagamento"
		Return False
	Else
		If Trim(ls_Requisicao_Chave) <> Trim(This.is_de_chave_acesso_sap ) Then
			as_Log  = "N$$HEX1$$fa00$$ENDHEX$$mero da chave de acesso da INTERFACE_SAP pai e filho est$$HEX1$$e300$$ENDHEX$$o diferentes. Fun$$HEX2$$e700e300$$ENDHEX$$o of_insere_condicao_pagamento"
			Return False
		End If
	End If
	
	uo_ge473_comum lo_Comum4
	lo_Comum4 = Create uo_ge473_comum
			
	If lo_Comum4.of_processa_carrega_dados(ll_Controle_filho, ref as_Log) Then		
		ll_Linhas = lo_Comum4.ids_lista_registros.RowCount()	
		For ll_Linha = 1 To ll_Linhas
			
			ls_cd_condicao_pagamento_sap 	= lo_Comum4.ids_lista_registros.Object.cd_condicao_pagamento			[ll_Linha]
			ls_de_condicao_pagamento 		= lo_Comum4.ids_lista_registros.Object.de_condicao_pagamento			[ll_Linha]
			ll_nr_parcela 							= Long(lo_Comum4.ids_lista_registros.Object.nr_parcela					[ll_Linha])
			ll_nr_dias 								= Long(lo_Comum4.ids_lista_registros.Object.nr_dias						[ll_Linha])
			//ls_pc_valor 								= lo_Comum4.ids_lista_registros.Object.pc_valor								[ll_Linha]
			If Not lo_Comum4.of_decimal(lo_Comum4.ids_lista_registros.Object.pc_valor[ll_Linha], 'PC_VALOR', ref ldc_pc_valor, ref as_log) Then Return False

			If IsNull(ls_de_condicao_pagamento) or Trim(ls_de_condicao_pagamento) = "" then
				as_log = "Descri$$HEX2$$e700e300$$ENDHEX$$o da Condi$$HEX2$$e700e300$$ENDHEX$$o de Pagamento Sap est$$HEX1$$e100$$ENDHEX$$ nula ou vazia!"
				Return False
			End if
		
			If IsNull(ls_cd_condicao_pagamento_sap) or Trim(ls_cd_condicao_pagamento_sap) = "" then
				as_log = "C$$HEX1$$f300$$ENDHEX$$digo de Condi$$HEX2$$e700e300$$ENDHEX$$o de Pagamento Sap est$$HEX1$$e100$$ENDHEX$$ nulo ou vazio!"
				Return False
			End if

			If isNull(ll_nr_dias) or ll_nr_dias = 0 then
				as_log = "N$$HEX1$$fa00$$ENDHEX$$mero de Dias est$$HEX1$$e100$$ENDHEX$$ nulo ou vazio!"
				Return False
			End if
	
			If isNull(ll_nr_parcela) or ll_nr_parcela = 0 then
				as_log = "N$$HEX1$$fa00$$ENDHEX$$mero da Parcela est$$HEX1$$e100$$ENDHEX$$ nulo ou vazio!"
				Return False
			End if
	
			If isNull(ldc_pc_valor) or ldc_pc_valor < 0  then
				as_log = "Percentual (%) do Valor est$$HEX1$$e100$$ENDHEX$$ nulo ou vazio!"
				Return False
			End if
			
			SetNull(ll_condicao_pagto_legado)
			If lo_Comum4.of_localiza_condicao_pagto_legado(ls_cd_condicao_pagamento_sap, Ref ll_condicao_pagto_legado, Ref as_Log) Then
				Return True
			Else
				 SELECT max(cd_condicao) + 1 
				 INTO :ll_condicao_pagto_legado
				 FROM dbo.condicao_pagamento 
				 Using SqlCa;
				
				If SqlCa.Sqlcode = -1 Then
					as_log = 'Erro ao obter pr$$HEX1$$f300$$ENDHEX$$ximo c$$HEX1$$f300$$ENDHEX$$digo da condi$$HEX2$$e700e300$$ENDHEX$$o de pagamento. Erro: ' + sqlca.sqlerrtext
					Return False
				End If
				
				
				INSERT INTO condicao_pagamento
							(cd_condicao, de_condicao, qt_parcelas, id_bonificada, id_situacao)
				VALUES(
							:ll_condicao_pagto_legado, 
							:ls_de_condicao_pagamento, 
							:ll_nr_parcela, 
							'N', 
							'A')
				Using SqlCa;
				
				If SqlCa.Sqlcode = -1 Then
					as_log = 'Erro ao inserir condi$$HEX2$$e700e300$$ENDHEX$$o de pagamento. Erro: ' + sqlca.sqlerrtext
					Return False
				End If
				
				If Not This.Of_insere_integracao_sap( il_cd_empresa, 'CONDICAO_PAGAMENTO', string(ll_condicao_pagto_legado), ls_cd_condicao_pagamento_sap, '14330', Ref as_log) Then
					Return False
				End If

			End If
						
		Next	
	Else
		Return False				
	End If
	
	al_codigo_pagto_legado = ll_condicao_pagto_legado
	
Catch ( runtimeerror  lo_rte )
	as_Log =  "Objeto [uo_ge473_fornecedor], fun$$HEX2$$e700e300$$ENDHEX$$o [of_insere_condicao_pagamento]. Erro: "+lo_rte.GetMessage( )
	Return False	
Finally
	If IsValid(lo_Comum4) Then Destroy(lo_Comum4)
End Try	

Return True
			
end function

public function boolean of_valida_carrega_dados (long al_controle, ref string as_log);String ls_cd_fornecedor_legado, ls_novo_cd_fornecedor_legado, ls_matricula_comprador
Long ll_cd_cidade, ll_cd_condicao_pagto_legado, ll_Pos

uo_ge473_comum lo_Comum1
lo_Comum1 = Create uo_ge473_comum
	
Try
	//Valida$$HEX2$$e700f500$$ENDHEX$$es
	If IsNull(is_cd_fornecedor_sap) or Trim(is_cd_fornecedor_sap) = "" then
	    as_log = "C$$HEX1$$f300$$ENDHEX$$digo Fornecedor SAP est$$HEX1$$e100$$ENDHEX$$ vazio!"
	    Return False
	End if
	
	If IsNull(is_id_situacao) or Trim(is_id_situacao) = "" then
	    as_log = "Situa$$HEX2$$e700e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ vazia!"
	    Return False
	End if
	
	If Not Trim(is_id_situacao) = 'A' And Not Trim(is_id_situacao) = 'I' Then
		as_log = "Situa$$HEX2$$e700e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ diferente de (A) Ativo - (I) Inativo!"
	    Return False
	End If
	
	If IsNull(is_cd_cidade_ibge) or Trim(is_cd_cidade_ibge) = "" Then 
	    as_log = "C$$HEX1$$f300$$ENDHEX$$digo Cidade IBGE est$$HEX1$$e100$$ENDHEX$$ vazia!"
	    Return False
	End if
	
	If IsNull(is_de_endereco) or Trim(is_de_endereco) = "" then
	    as_log = "Endere$$HEX1$$e700$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ vazio!"
	    Return False
	End if
	
	If IsNull(is_de_bairro) or Trim(is_de_bairro) = "" then
	    as_log = "Bairro est$$HEX1$$e100$$ENDHEX$$ vazio!"
	    Return False
	End if
	
	If (IsNull(is_nr_cgc) or Trim(is_nr_cgc) = "") And (IsNull(is_nr_cpf) or Trim(is_nr_cpf) = "") Then
		as_log = "CPF e CNPJ SAP est$$HEX1$$e300$$ENDHEX$$o vazios!"
         Return False
     End if
	  
	If len(Trim(is_nr_cpf)) > 1 Then
		ib_pessoa_fisica = True
	Else
		ib_pessoa_fisica = False
	End If
	
	If ib_pessoa_fisica Then
		is_id_fisica_juridica = 'F'
		
		If Not gf_valida_cpf(is_nr_cpf) then
			
         	as_log = "CPF inv$$HEX1$$e100$$ENDHEX$$lido!"
         	Return False
     	End if
		
		If IsNull(is_nm_fornecedor) or Trim(is_nm_fornecedor) = "" then
			 as_log = "Nome do Fornecedor est$$HEX1$$e100$$ENDHEX$$ vazio!"
			 Return False
		End if
		
		If IsNull(is_nm_sobrenome) or Trim(is_nm_sobrenome) = "" then
			 as_log = "Sobrenome Fornecedor est$$HEX1$$e100$$ENDHEX$$ vazio!"
			 Return False
		End if
		
		is_nm_fantasia 		= is_nm_fornecedor + " " + is_nm_sobrenome
		is_nm_razao_social 	= is_nm_fornecedor + " " + is_nm_sobrenome
		
	Else
		is_id_fisica_juridica = 'J'
		
		If Not gf_cgc_valido(is_nr_cgc, False) then
			as_log = "CNPJ inv$$HEX1$$e100$$ENDHEX$$lido!"
			Return False
		End if
		
		If IsNull(is_nm_fantasia) or Trim(is_nm_fantasia) = "" then
			 as_log = "Nome Fantasia est$$HEX1$$e100$$ENDHEX$$ vazio!"
			 Return False
		End if
		
		If IsNull(is_nm_razao_social) or Trim(is_nm_razao_social) = "" then
			 as_log = "Raz$$HEX1$$e300$$ENDHEX$$o Social est$$HEX1$$e100$$ENDHEX$$ vazia!"
			 Return False
		End if
	End If
	
	If IsNull(is_cd_condicao_pagamento_sap) or Trim(is_cd_condicao_pagamento_sap) = "" then
		as_log = "C$$HEX1$$f300$$ENDHEX$$digo Condi$$HEX2$$e700e300$$ENDHEX$$o de Pagamento do Fornecedor est$$HEX1$$e100$$ENDHEX$$ vazia!"
		Return False
	End if
	
	If Not This.of_verifica_tipo_pn(is_cd_tipo_pn, Ref as_log) Then
		Return False
	End If
	
	//Convers$$HEX1$$e300$$ENDHEX$$o de dados
	If IsNull(is_id_considera_ipi_pedido) or Trim(is_id_considera_ipi_pedido) = "" then
		is_id_considera_ipi_pedido = 'N'
	Else
		is_id_considera_ipi_pedido = 'S'
	End if
	
	If IsNull(is_id_recebe_email_xml) or Trim(is_id_recebe_email_xml) = "" then
		is_id_recebe_email_xml = 'N'
	Else
		is_id_recebe_email_xml = 'S'
	End if
	
	If Not IsNull(is_id_atividade_economica) Or Len(Trim(is_id_atividade_economica)) > 0 Then
		If Not is_id_atividade_economica = '1' Then is_id_atividade_economica = '0'
	End if
	
	If IsNull(is_nr_inscricao_estadual) Then
		is_nr_inscricao_estadual = ""
	End if
	
	If Not IsNull(is_nr_cep) Or Len(Trim(is_nr_cep)) > 0 Then
		is_nr_cep = gf_retorna_so_numeros(is_nr_cep)
	End If
	
	If Not IsNull(is_nr_matricula_comprador) Or Len(Trim(is_nr_matricula_comprador)) > 0 Then
		If Long(is_nr_matricula_comprador) = 0 Then
			setNull(is_nr_matricula_comprador)
		Else
			is_nr_matricula_comprador = String(Long(is_nr_matricula_comprador))
			If Not This.of_verifica_matricula_comprador(is_nr_matricula_comprador, Ref as_Log) Then
				Return False
			End If
		End If
	End If

	If IsNull(is_id_parceiro) or Trim(is_id_parceiro) = "" then
		is_id_parceiro = 'N'
	Else
		is_id_parceiro = 'S'
	End if
	
	If Trim(is_cd_tipo_pn) = "F012" or Trim(is_cd_tipo_pn) = "F013" then
		 is_id_fornecedor_transportadora = "T"
	Else
		 is_id_fornecedor_transportadora = "F"
	End if
	
	If Trim(is_id_regime_tributario) = "1" or Trim(is_id_regime_tributario) = "2" then
		 is_id_regime_tributario = "1"
	Else
		 is_id_regime_tributario = "2"
	End if
	
	If IsNull(is_id_regime_especial) or Trim(is_id_regime_especial) = "" then
		is_id_regime_especial = 'N'
	Else
		is_id_regime_especial = 'S'
	End if
	
	If IsNull(idc_pc_desconto_usual) Then
	    idc_pc_desconto_usual = 0
	Else
		If idc_pc_desconto_usual > double(20) Then
			as_log =  "Desconto Financeiro n$$HEX1$$e300$$ENDHEX$$o pode ser maior que 20%!"
			Return False
		End If
	End if
	
	If Not IsNull(is_nm_contato) Then
		ll_Pos = Pos(is_nm_contato, ":")
		If ll_Pos > 0 Then
			is_nm_contato = Trim(Mid(is_nm_contato, ll_Pos + 1))
		End If
	End If
		
	//Carrega outros dados	
	If Not IsNull(is_id_pedido_edi) Then
		If Len(Trim(is_id_pedido_edi)) > 0 Then
			// Se n$$HEX1$$e300$$ENDHEX$$o existir o registro na tabela INTEGRACAO_SAP, incluir nas tabelas (TIPO_PEDIDO_EDI / INTEGRACAO_SAP)
			If Not This.of_verifica_insere_pedido_edi( is_id_pedido_edi, is_de_pedido_edi, Ref as_log) Then
				Return False
			End If
		End If 
	End If
	
	SetNull(ll_cd_cidade)
	If This.of_verifica_cd_cidade( is_cd_cidade_ibge, Ref ll_cd_cidade, Ref as_log) Then
		il_cd_cidade = ll_cd_cidade
	Else
		Return False
	End If
	
	SetNull(ll_cd_condicao_pagto_legado)
	If Not lo_Comum1.of_localiza_condicao_pagto_legado(is_cd_condicao_pagamento_sap, Ref ll_cd_condicao_pagto_legado, Ref as_Log) Then
		If Not This.of_insere_condicao_pagamento(al_controle, Ref ll_cd_condicao_pagto_legado, Ref as_Log) Then
			Return False
		End If
	End If
	il_cd_condicao_pagamento_legado = ll_cd_condicao_pagto_legado
	
	SetNull(ls_cd_fornecedor_legado)
	If lo_Comum1.of_localiza_codigo_fornecedor_legado( is_cd_fornecedor_sap, Ref ls_cd_fornecedor_legado, True, Ref as_Log) Then
		is_cd_fornecedor_legado = ls_cd_fornecedor_legado
		ib_Fornecedor_Novo = False
	Else
		If This.of_proximo_cd_fornecedor( il_cd_filial, Ref ls_novo_cd_fornecedor_legado, Ref as_Log) Then
			is_cd_fornecedor_legado = ls_novo_cd_fornecedor_legado
			ib_Fornecedor_Novo = True
			setnull(as_Log)
		Else
			Return False
		End If
	End If
	
Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_valida_carrega_dados' do objeto [uo_ge473_fornecedor]. Erro: "+lo_rte.GetMessage( )
	Return False						 

Finally
	Destroy lo_Comum1	
	
End Try

Return True

end function

public function boolean of_insere_contato_fornecedor (string as_de_contato_fornecedor, ref long al_codigo_contato_forn_legado, ref string as_log);Long ll_cd_contato_novo

Try
			
	SELECT max(cd_contato) + 1 
	INTO :ll_cd_contato_novo
	FROM contato_fornecedor 
	Using SqlCa;
	
	If SqlCa.Sqlcode = -1 Then
		as_log = 'Erro ao obter pr$$HEX1$$f300$$ENDHEX$$ximo c$$HEX1$$f300$$ENDHEX$$digo da tabela contato_fornecedor. Erro: ' + sqlca.sqlerrtext
		Return False
	End If
		
	INSERT INTO contato_fornecedor
			(cd_contato, 
			de_contato)
	VALUES (
			:ll_cd_contato_novo, 
			:as_de_contato_fornecedor)
	Using SqlCa;
	
	If SqlCa.Sqlcode = -1 Then
		as_log = 'Erro ao inserir tipo contato fornecedor. Erro: ' + sqlca.sqlerrtext
		Return False
	End If

	al_codigo_contato_forn_legado = ll_cd_contato_novo
	
Catch ( runtimeerror  lo_rte )
	as_Log =  "Objeto [uo_ge473_fornecedor], fun$$HEX2$$e700e300$$ENDHEX$$o [of_insere_contato_fornecedor]. Erro: "+lo_rte.GetMessage( )
	Return False	
Finally
	//
End Try	

Return True
			
end function

public function boolean of_insere_integracao_sap (long al_empresa, string as_tabela, string as_cd_legado, string as_cd_sap, string as_matricula, ref string as_log);Try
			
	INSERT INTO integracao_sap
				(cd_empresa, 
				cd_tabela, 
				cd_chave_legado, 
				cd_chave_sap, 
				dh_inclusao, 
				nr_matricula_inclusao)
	VALUES (
				:al_empresa, 
				:as_tabela, 
				:as_cd_legado, 
				:as_cd_sap, 
				getdate(), 
				:as_matricula)
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		as_log = 'Erro ao inserir integracao_sap. Erro: ' + SqlCa.sqlerrtext
		Return False
	End If
	
Catch ( runtimeerror  lo_rte )
	as_Log =  "Objeto [uo_ge473_fornecedor], fun$$HEX2$$e700e300$$ENDHEX$$o [of_insere_integracao_sap]. Erro: "+lo_rte.GetMessage( )
	Return False	
Finally
	//
End Try	

Return True
			
end function

public function boolean of_insere_fornecedor_contato (string as_cd_fornecedor_legado, long al_controle_pai, ref string as_log);Long ll_Controle_filho
Long ll_str_linhas, ll_str_linha
String ls_Requisicao_Chave

str_fornecedor_contato lstr_null[]

Try
	istr_forn_contato[] = lstr_null[]
		
	If Not This.Of_Carrega_Fornecedor_Email(as_cd_fornecedor_legado, al_controle_pai, Ref as_log ) Then
		If Not Trim(as_log) = "" Then
			Return False
		End If
	End If
	
	If Not This.Of_Carrega_Fornecedor_Telefone(as_cd_fornecedor_legado, al_controle_pai, Ref as_log ) Then
		If Not Trim(as_log) = "" Then
			Return False
		End If
	End If
	
	ll_str_linhas = Upperbound(istr_forn_contato[])
	If ll_str_linhas > 0 Then
		For ll_str_linha = 1 To ll_str_linhas
			
			INSERT INTO fornecedor_contato
						(cd_fornecedor, nr_contato, cd_contato, nm_contato, nr_ddd_telefone, nr_telefone, de_email) 
			VALUES (
						:istr_forn_contato[ll_str_linha].cd_fornecedor, 
						:istr_forn_contato[ll_str_linha].nr_contato,
						:istr_forn_contato[ll_str_linha].cd_contato,
						:istr_forn_contato[ll_str_linha].nm_contato,
						:istr_forn_contato[ll_str_linha].nr_ddd_telefone,
						:istr_forn_contato[ll_str_linha].nr_telefone,
						:istr_forn_contato[ll_str_linha].de_email)	
			Using SqlCa;
			
			If SqlCa.sqlcode = -1 Then
				as_log = "Erro ao inserir contato na tabela fornecedor_contato. Erro: " + sqlca.sqlerrtext
				Return False
			End If
			
			if istr_forn_contato[ll_str_linha].id_principal_email = 'S' then
				UPDATE
					fornecedor
				SET
					de_email = :istr_forn_contato[ll_str_linha].de_email
				WHERE
					cd_fornecedor	= :istr_forn_contato[ll_str_linha].cd_fornecedor;
					
				if SQLCA.SQLCode = -1 then
					as_log = "Erro ao atualizar contato principal na tabela fornecedor. Erro: " + sqlca.sqlerrtext
					Return False
				end if
			end if
		Next
	End If
	
Catch ( runtimeerror  lo_rte )
	as_Log =  "Objeto [uo_ge473_fornecedor], fun$$HEX2$$e700e300$$ENDHEX$$o [of_atualiza_fornecedor_contato]. Erro: "+lo_rte.GetMessage( )
	Return False	
Finally
	//
End Try	

Return True
			
end function

public function boolean of_verifica_matricula_comprador (string as_matricula, ref string as_log);Long ll_Achou

Try
	
	SELECT count(*) 
	INTO :ll_Achou
	FROM usuario 
	Where nr_matricula = :as_matricula
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		as_Log = "Erro ao localizar a matricula do Comprador: '"+as_matricula+"' " + SqlCa.SqlerrText
		Return False
	End If
	
Catch ( runtimeerror  lo_rte )
	as_Log =  "Objeto [uo_ge473_fornecedor], fun$$HEX2$$e700e300$$ENDHEX$$o [of_verifica_matricula_comprador]. Erro: "+lo_rte.GetMessage( )
	Return False	
Finally
	//
End Try	

If ll_Achou > 0 Then
	Return True
Else
	as_Log = "Usu$$HEX1$$e100$$ENDHEX$$rio comprador n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ cadastrado no sybase, matricula: '"+as_matricula+"'."
	Return False
End If




end function

on uo_ge473_fornecedor.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge473_fornecedor.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

