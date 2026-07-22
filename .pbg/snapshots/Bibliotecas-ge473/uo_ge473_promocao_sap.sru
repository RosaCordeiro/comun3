HA$PBExportHeader$uo_ge473_promocao_sap.sru
forward
global type uo_ge473_promocao_sap from nonvisualobject
end type
end forward

global type uo_ge473_promocao_sap from nonvisualobject
end type
global uo_ge473_promocao_sap uo_ge473_promocao_sap

type variables
uo_ge473_comum io_Comum

String	is_cd_produto_sap,&
		is_filial_sap,&
		is_rede_promocao,&
		is_tipo_promocao,&
		is_nome_promocao,&
		is_desc_promocao,&
		is_altera_estoque_minino,&
		is_replicacao,&
		is_pbm,&
		is_SOS,&
		is_UF,&
		is_Domicilio,&
		is_de_etiqueta,&
		is_matricula_sap = 'SAP001', is_chave_sap, is_canal_distribuicao

String is_cd_promocao_profimetrics, is_cd_evento, is_de_evento, is_cd_subevento, is_de_subevento, is_cd_midia, is_cd_motivo_promocao
String is_cd_grupo_cliente, is_cd_tipo_verba

Long il_nr_prioridade

DateTime	idh_inicio_promocao, idh_inicio_promocao_ant, &
				idh_termino_promocao, idh_termino_promocao_ant
				
Long il_Tabela = 34
Long il_codigo_promocao
Long il_controle, il_nr_campanha_legado, il_qt_recorrencia_cpf_cupom
String is_codigo_promocao_sap, is_nr_campanha_sap, is_nr_oferta_sap, is_nm_campanha, is_oferta_txt, is_promocao_coringa, is_cd_tipo_campanha
Boolean ib_promocao_nova, ib_promocao_pdv=false, ib_promocao_vinculada=false, ib_promocao_progressiva = false
datetime idh_atual

//boolean ib_validar_pendente = false

dc_uo_transacao iuo_SqlCa

end variables

forward prototypes
public function boolean of_valida_dados (ref string as_log)
private function boolean of_inicializa_variaveis (ref string as_log)
public function boolean of_carrega_produto_promocao (long al_controle_pai, ref string as_log)
public function boolean of_promocao_nova (ref long al_promocao, ref boolean ab_promocao_nova, ref string as_log)
public function boolean of_insere_promocao_sos (long al_promocao, boolean ab_promocao_nova, ref string as_log)
public function boolean of_atualiza_promocao (long al_controle, long al_tabela)
public function boolean of_insere_promocao_produto (long al_promocao, boolean ab_promocao_nova, ref string as_log, long al_controle_pai)
public function boolean of_insere_promocao_vinculo_prd (long al_promocao, boolean ab_promocao_nova, ref string as_log, long al_controle_pai)
public function boolean of_insere_promocao_sos_vinculo (long al_promocao, boolean ab_promocao_nova, ref string as_log, long al_controle_pai)
public subroutine of_processa_atualizacao ()
public function boolean of_finaliza_promocao (long al_cd_promocao, ref string as_log)
public function boolean of_carrega_chave (long al_controle, ref string as_chave_sap, ref string as_log)
public function boolean of_insere_desconto_prog (datastore pds_dados, ref long pl_cd_desconto, ref string ps_log)
public function boolean of_data_parametro (ref string as_log)
public function boolean of_insere_campanha (string ps_nr_campanha, string ps_nm_campanha, string ps_tipo, ref string ps_log)
public function boolean of_proxima_promocao (ref long al_proximo, ref string as_log)
public function boolean of_abre_conexao (ref string ps_log)
public function boolean of_fecha_conexao ()
public function boolean of_insere_promocao_sos_produto_crm (long pl_cd_promocao_sos, long pl_cd_produto, long pl_nr_nivel_desconto, decimal pdc_vl_preco_promocao, ref string ps_log)
public function boolean of_insere_promocao_filial (long al_promocao, boolean ab_promocao_nova, ref boolean ab_inativacao_loja, ref string as_log, long al_controle_pai)
public function boolean of_insere_promocao_recuperacao_verba (long pl_cd_promocao_sos, long pl_cd_produto, string ps_nm_tipo_recuperacao, decimal pdc_vl_recuperacao, decimal pdc_vl_verba_maximo, string ps_cd_fornecedor_verba, long pl_qt_minima, ref string ps_log)
end prototypes

public function boolean of_valida_dados (ref string as_log);Try	
	If IsNull(is_codigo_promocao_sap) Or Trim(is_codigo_promocao_sap) = ''  Then
		as_Log	= "O valor informado para o campo CD_PROMOCAO_SAP n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ v$$HEX1$$e100$$ENDHEX$$lido."
		Return False
	End If	

	if is_codigo_promocao_sap <> is_chave_sap Then
		as_log = 'O c$$HEX1$$f300$$ENDHEX$$digo da promo$$HEX2$$e700e300$$ENDHEX$$o SAP $$HEX1$$e900$$ENDHEX$$ diferente do c$$HEX1$$f300$$ENDHEX$$digo chave SAP enviado.'
		return false
	end if

	If IsNull(is_rede_promocao) Then
		as_Log	= "Rede(organiza$$HEX1$$e700$$ENDHEX$$ao) da promo$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o pode ser nulo."
		Return False
	End If
	
	If IsNull(is_nome_promocao) Then
		as_Log	= "Nome da promo$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o pode ser nulo."
		Return False
	End If

	If IsNull(is_tipo_promocao) Then
		as_Log	= "Tipo da promo$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o pode ser nulo."
		Return False
	End If	

	If IsNull(is_canal_distribuicao) Then
		as_Log	= "Canal de distribui$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o pode ser nulo."
		Return False
	End If	
	
	If IsNull(is_SOS) or Trim(is_SOS) = '' Then
		is_SOS = 'N'
	End If	
	
	if is_altera_estoque_minino = 'X' Then
		is_altera_estoque_minino = 'S'
	else
		is_altera_estoque_minino = 'N'
	end if
	
	If Not IsNull(is_UF) And Trim(is_UF) <> '' Then
		If LenA(is_UF) <> 2 Then
			as_Log	= "Valor inv$$HEX1$$e100$$ENDHEX$$lido para a UF da promo$$HEX2$$e700e300$$ENDHEX$$o."
			Return False			
		End If
		If Not IsNull(is_Domicilio) And Trim(is_Domicilio) <> '' Then
			as_Log	= "Enviado mais de um tipo de integra$$HEX2$$e700e300$$ENDHEX$$o para promo$$HEX2$$e700e300$$ENDHEX$$o_sos_filial."
			Return False						
		End if
	End If	
	If Not IsNull(is_Domicilio) And Trim(is_Domicilio) <> '' Then
		If Not IsNull(is_UF) And Trim(is_UF) <> '' Then		
			as_Log	= "Enviado mais de um tipo de integra$$HEX2$$e700e300$$ENDHEX$$o para promo$$HEX2$$e700e300$$ENDHEX$$o_sos_filial."
			Return False						
		End If
	End if	

	If is_tipo_promocao <> 'N' &
		and is_tipo_promocao <> 'V' &
		and is_tipo_promocao <> 'Q' &
		and is_tipo_promocao <> 'C' &
		and is_tipo_promocao <> 'S' &
		and is_tipo_promocao <> 'J' &
		and is_tipo_promocao <> 'M' Then
		
		as_log = "O valor [" + is_tipo_promocao + "] informado para o campo CD_CATEGORIA_PROMOCAO n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ v$$HEX1$$e100$$ENDHEX$$lido."
		
		return false
		
	end if

	If (is_tipo_promocao = 'V' or is_tipo_promocao = 'Q') and IsNull(is_replicacao) Then
		as_Log	= "Tipo de replica$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o pode ser nulo."
		Return False
	End If	

	If is_replicacao <> 'M' &
		and is_replicacao <> 'U' &
		and is_replicacao <> 'T' Then
		
		as_log = "O valor [" + is_replicacao + "] informado para o campo ID_TIPO_REPLICACAO n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ v$$HEX1$$e100$$ENDHEX$$lido."
		
		return false
		
	end if

	if is_canal_distribuicao <> 'LF' and is_canal_distribuicao <> 'EC' Then
		as_log = 'Canal de distribui$$HEX2$$e700e300$$ENDHEX$$o ['+ is_canal_distribuicao + '] est$$HEX1$$e100$$ENDHEX$$ diferente do esperado [LF - Loja F$$HEX1$$ed00$$ENDHEX$$sica; EC - eCommerce].'
		return false
	end if

	Choose Case is_rede_promocao
			
		Case 'CP00'
			is_rede_promocao = 'CP'
			
		Case 'DC00'
			is_rede_promocao = 'DC'
			
		Case 'FA00'
			is_rede_promocao = 'FA'
			
		Case 'MP00'
			is_rede_promocao = 'MP'
			
		Case 'PF00'
			is_rede_promocao = 'PF'
			
		Case 'PP00'
			is_rede_promocao = 'PP'
			
		Case Else
			
			as_log = "O valor [" + is_rede_promocao + "] informado para o campo CD_ORGANIZACAO_VENDA n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ v$$HEX1$$e100$$ENDHEX$$lido."	
			return false
			
	End Choose

//	if this.is_canal_distribuicao= 'EC' then
//		
//		if this.is_rede_promocao <> 'FA' Then
//			as_log = 'Rede ECOMMERCE [' + this.is_rede_promocao + '] n$$HEX1$$e300$$ENDHEX$$o prevista na integra$$HEX2$$e700e300$$ENDHEX$$o.'
//			return false
//		End if
//		
//	ENd if

Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_valida_dados'. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try

Return True
end function

private function boolean of_inicializa_variaveis (ref string as_log);Try
	
	setNull(is_cd_produto_sap)
	setNull(is_filial_sap)
	setNull(is_rede_promocao)
	setNull(is_tipo_promocao)
	setNull(is_codigo_promocao_sap)
	setNull(is_nome_promocao)
	setNull(is_desc_promocao)
	setNull(is_altera_estoque_minino)
	setNull(is_replicacao)
	setNull(is_pbm)
	setNull(is_SOS)
	setNull(idh_inicio_promocao)
	setNull(idh_termino_promocao)
	setNull(il_codigo_promocao)
	SetNull(is_UF)
	SetNull(is_Domicilio)
	setnull(is_chave_sap)
	setnull(is_nr_campanha_sap)
	setnull(is_cd_tipo_campanha)
	
	setnull(is_cd_promocao_profimetrics)
	setnull(is_cd_evento)
	setnull(is_de_evento)
	setnull(is_cd_subevento)
	setnull(is_de_subevento)
	setnull(is_cd_midia)
	setnull(is_cd_motivo_promocao)
	setnull(is_cd_grupo_cliente)
	setnull(is_cd_tipo_verba)
	setnull(il_nr_prioridade)
	
	ib_promocao_vinculada = false
	ib_promocao_progressiva = false
	ib_promocao_nova = False

Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro ao ao iniciar as vari$$HEX1$$e100$$ENDHEX$$veis. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try

Return True
end function

public function boolean of_carrega_produto_promocao (long al_controle_pai, ref string as_log);Boolean lb_Sucesso = True

Long ll_Linhas
Long ll_Linha
Long ll_Controle_filho
Long ll_Insert
Long ll_produto

String ls_Coluna
String ls_Vl_Item
String ls_Obrig
String ls_produto_sap

Decimal ldc_desconto
Decimal ldc_desconto_clube

DateTime ldt_inicio
DateTime ldt_fim

dc_uo_ds_base lds_produto_promocao_cad

try

	SELECT nr_controle
	Into :ll_Controle_filho
	FROM interface_sap  i 
	Where i.cd_tabela = 35
		and i.nr_controle_pai = :al_controle_pai
	Using SqlCa;	

	If SqlCa.sqlcode = -1 Then
		as_Log	= "Erro ao buscar o controle na tabela interface_sap. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle_pai)+". Erro: "+SqlCa.sqlErrText
		Return False
	End If
	
	If ll_Controle_filho = 0 Or IsNull(ll_Controle_filho) Then
		as_Log	= "N$$HEX1$$e300$$ENDHEX$$o foi localizado o registro filho promocao produto. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle_pai)+"."
		Return False
	End If	
	
	lds_produto_promocao_cad = Create dc_uo_ds_base
	lds_produto_promocao_cad.of_ChangeDataObject("ds_ge473_produto_promocao_cad")
	
	uo_ge473_comum lo_Comum
	lo_Comum = Create uo_ge473_comum
	
	If lo_Comum.of_processa_carrega_dados_v2(ll_Controle_filho, ref as_Log) Then
		lds_produto_promocao_cad.Reset()
		For ll_Linha = 1 To lo_Comum.ids_lista_registros.RowCount()
			
			ll_Insert 		= lds_produto_promocao_cad.InsertRow(0)						

			ls_produto_sap = gf_Tira_Zero_Esquerda(lo_Comum.ids_lista_registros.Object.cd_produto_sap[ll_Linha])
			If IsNull(ls_produto_sap) Then ls_produto_sap = ''
			
			If io_Comum.of_Localiza_Codigo_Produto_Legado(ls_produto_sap, Ref ll_Produto, Ref as_Log) Then
				lds_produto_promocao_cad.Object.cd_produto[ll_Insert] = ll_produto
			Else
				Return False
			End If
			
			If io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.pc_desconto[ll_Linha], 'PC DESCONTO', ref ldc_desconto, ref as_Log) Then
				lds_produto_promocao_cad.Object.pc_desconto[ll_Insert] = ldc_desconto
			Else
				Return False
			End If			

			If io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.pc_desconto_clube[ll_Linha], 'PC DESCONTO CLUBE', ref ldc_desconto_clube, ref as_Log) Then
				lds_produto_promocao_cad.Object.pc_desconto_clube[ll_Insert] = ldc_desconto_clube
			Else
				Return False
			End If				
						
			If io_Comum.of_date_time(lo_Comum.ids_lista_registros.Object.dh_inicio_validade[ll_Linha], 'DATA INICIO VALIDADE DESCONTO', ref ldt_inicio, ref as_Log) Then 
				lds_produto_promocao_cad.Object.dh_inicio_validade[ll_Insert] = ldt_inicio
			Else
				Return False
			End If					
					
			If io_Comum.of_date_time(lo_Comum.ids_lista_registros.Object.dh_termino_validade[ll_Linha], 'DATA TERMINO VALIDADE DESCONTO', ref ldt_fim, ref as_Log) Then 
				lds_produto_promocao_cad.Object.dh_termino_validade[ll_Insert] = ldt_fim
			Else
				Return False
			End If

		Next
	Else
		as_Log	= "Erro ao recuperar os dados da promocao produto. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle_pai)+"."
		Return False		
	End If		

finally
	If IsValid(lds_produto_promocao_cad) Then Destroy(lds_produto_promocao_cad)
	If IsValid(lo_Comum) Then Destroy(lo_Comum)
end try

Return True	
end function

public function boolean of_promocao_nova (ref long al_promocao, ref boolean ab_promocao_nova, ref string as_log);Long ll_promocao
string ls_rede_filial, ls_cd_uf, ls_cd_cidade

Try
	
	Select cd_promocao_sos, cd_unidade_federacao, cd_cidade_ibge, id_rede_filial, dh_inicio, dh_termino
	Into	:ll_promocao, :ls_cd_uf, :ls_cd_cidade, :ls_rede_filial, :idh_inicio_promocao_ant, :idh_termino_promocao_ant
	From promocao_sos
	Where cd_promocao_sap = :is_codigo_promocao_sap
	Using SqlCa;
		
	Choose Case SqlCa.sqlcode
		Case 0
			
			if ls_cd_uf = '' then setnull(ls_cd_uf)
			if ls_cd_cidade = '' then setnull(ls_cd_cidade)
			if ls_rede_filial = '' then setnull(ls_rede_filial)
			
			If ( (ls_cd_uf = is_uf) or (isnull(ls_cd_uf) and isnull(is_uf)) ) & 
				And ( (ls_cd_cidade = is_domicilio) or ( isnull(ls_cd_cidade) and isnull(is_domicilio) ) ) & 
				And ( (ls_rede_filial = is_rede_promocao) or (isnull(ls_rede_filial) and isnull(is_rede_promocao)) ) Then 

				ab_Promocao_nova = False
				al_promocao = ll_promocao
				
			else
				
				as_log = 'J$$HEX1$$e100$$ENDHEX$$ existe uma promo$$HEX2$$e700e300$$ENDHEX$$o com o mesmo c$$HEX1$$f300$$ENDHEX$$digo mas com UF, domic$$HEX1$$ed00$$ENDHEX$$lio fiscal ou Rede diferentes.'
				return false
				
			end if
			
		Case 100
			ab_Promocao_nova	= True
			
			setnull(idh_inicio_promocao_ant)
			setnull(idh_termino_promocao_ant)
			
			If Not of_proxima_promocao(ref al_promocao, ref as_Log) Then Return False
			
//			select max(COALESCE(cd_promocao_sos,0)) +1
//				Into :ll_promocao
//			From promocao_sos
//			Using SqlCa;
//		
//			If SqlCa.SqlCode = -1 Then
//				as_Log	= "Erro ao buscar codigo da nova promo$$HEX2$$e700e300$$ENDHEX$$o. Erro: "+SqlCa.sqlErrText
//				Return False				
//			Else
//				al_promocao = ll_promocao
//			End If			
		
		Case -1
			as_Log	= "Erro ao verificar se a promo$$HEX2$$e700e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ nova. Erro: "+SqlCa.sqlErrText
			Return False
	End Choose	
	
Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_promocao_nova'. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try		

Return True

end function

public function boolean of_insere_promocao_sos (long al_promocao, boolean ab_promocao_nova, ref string as_log);date ldt_ini_est_minimo, ldt_fim_est_minimo
datetime ldh_inicio_ant, ldh_termino_ant
String ls_UF,ls_Domicilio,ls_rede_promocao,ls_de_etiqueta
boolean lb_atualizar_data_estoque = false
long ll_nr_diferenca

ls_uf = is_UF
ls_Domicilio = is_Domicilio
ls_rede_promocao = is_rede_promocao
ls_de_etiqueta = is_de_etiqueta

if ls_uf = '' then setnull(ls_uf)
if ls_Domicilio = '' then setnull(ls_Domicilio)
if ls_rede_promocao = '' then setnull(ls_rede_promocao)
if ls_de_etiqueta = '' then setnull(ls_de_etiqueta)

Try
	
	//************************************************************************************//
	//Essa mesma Regra de datas do estoque minimo deve ser aplicada na Interface CAMPANHA SAP.
	//************************************************************************************//
	ldt_ini_est_minimo = relativedate(date(idh_inicio_promocao),-7)
	ldt_fim_est_minimo = relativedate(date(idh_termino_promocao),-7)
	
	//Se a diferen$$HEX1$$e700$$ENDHEX$$a entre o fim do estoque minimo e o inicio da promo$$HEX2$$e700e300$$ENDHEX$$o for menor que 7 dias, o fim do estoque minimo ser$$HEX1$$e100$$ENDHEX$$ igual ao fim da promo$$HEX2$$e700e300$$ENDHEX$$o.
	if ldt_fim_est_minimo < date(idh_inicio_promocao) Then
		ldt_fim_est_minimo = date(idh_termino_promocao)	
	end if
	
	//************************************************************************************//
	
	If ab_Promocao_nova Then
	
		Insert into promocao_sos(	  cd_promocao_sos, 
											  nm_promocao_sos, 
											  id_tipo_promocao, 
											  id_situacao, 
											  dh_inicio, 
											  dh_termino, 
											  id_filial_altera_estoque,
											  id_tipo_replicacao, 
											  nr_matricula_alteracao,
											  de_promocao,
											  cd_promocao_sap,
											  dh_inicio_estoque_minimo,
											  dh_termino_estoque_minimo,
											  cd_unidade_federacao,
											  cd_cidade_ibge,
											  id_rede_filial,
											  de_etiqueta_promocao,
											  nr_campanha_sap,
											  nr_oferta_sap,
											  id_promocao_coringa,
											  dh_atualizacao,
											  cd_promocao_profimetrics,
											  cd_evento,
											  de_evento,
											  cd_subevento,
											  de_subevento,
											  cd_midia,
											  nr_prioridade,
											  cd_motivo_promocao,
											  cd_grupo_cliente)
		Values (	:il_codigo_promocao, 
					:is_nome_promocao, 
					:is_tipo_promocao,
					'L',
					:idh_inicio_promocao,
					:idh_termino_promocao, 
					:is_altera_estoque_minino,
					:is_replicacao, 
					:is_matricula_sap, 
					:is_desc_promocao,
					:is_codigo_promocao_sap,
					:ldt_ini_est_minimo,
					:ldt_fim_est_minimo,
					:is_UF,
					:is_Domicilio,
					:is_rede_promocao,
					:is_de_etiqueta,
					:is_nr_campanha_sap,
					:is_nr_oferta_sap,
					:is_promocao_coringa,
					GetDate(),
					:this.is_cd_promocao_profimetrics,
					:this.is_cd_evento,
					:this.is_de_evento,
					:this.is_cd_subevento,
					:this.is_de_subevento,
					:this.is_cd_midia,
					:this.il_nr_prioridade,
					:this.is_cd_motivo_promocao,
					:this.is_cd_grupo_cliente
					)
		Using SqlCa;
									
		If SqlCa.sqlcode = -1 Then
			as_Log	= "Erro no insert da tabela 'promocao_sos'. Erro: "+SqlCa.sqlErrText
			Return False
		End If
		
	Else
		
		Select dh_inicio, dh_termino
		into :ldh_inicio_ant, :ldh_termino_ant
		from promocao_sos
		where cd_promocao_sos = :il_codigo_promocao;
		
		if sqlca.sqlcode = -1 then 
			as_Log	= "Erro ao consultar a tabela 'promocao_sos'. Erro: " + SqlCa.sqlErrText
			Return False
		end if
		
		//S$$HEX1$$f300$$ENDHEX$$ dar Update se a promocao ainda estiver aberta:
		if date(ldh_termino_ant) >= date(idh_atual) Then
		
			if ( ldh_inicio_ant <> idh_inicio_promocao ) or ( ldh_termino_ant <>  idh_termino_promocao ) Then
				
				Update promocao_sos
				Set	dh_inicio 					= :idh_inicio_promocao,
						dh_termino 					= :idh_termino_promocao,
						dh_inicio_estoque_minimo = :ldt_ini_est_minimo,
						dh_termino_estoque_minimo = :ldt_fim_est_minimo,
						nm_promocao_sos 			= :is_nome_promocao,
						id_filial_altera_estoque = :is_altera_estoque_minino,
						id_tipo_replicacao 		= :is_replicacao,
						de_promocao 				= :is_desc_promocao,
						nr_matricula_alteracao 	= :is_matricula_sap,
						id_promocao_coringa 		= :is_promocao_coringa,
						dh_atualizacao 			= GetDate()
				Where cd_promocao_sos = :il_codigo_promocao
				Using SqlCa;
				
			else
			
				Update promocao_sos
					Set	dh_inicio 					= :idh_inicio_promocao,
							dh_termino 					= :idh_termino_promocao,
							nm_promocao_sos 			= :is_nome_promocao,
							id_filial_altera_estoque = :is_altera_estoque_minino,
							id_tipo_replicacao 		= :is_replicacao,
							de_promocao 				= :is_desc_promocao,
							nr_matricula_alteracao 	= :is_matricula_sap,
							id_promocao_coringa 		= :is_promocao_coringa,
							dh_atualizacao 			= GetDate()
				Where cd_promocao_sos = :il_codigo_promocao
				Using SqlCa;
				
			end if
			
			If SqlCa.sqlcode = -1 Then
				as_Log	= "Erro no update da tabela 'promocao_sos'. Erro: "+SqlCa.sqlErrText
				Return False
			End If	
		End If
		
	ENd if
	
Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_insere_promocao_sos'. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try	

Return True
end function

public function boolean of_atualiza_promocao (long al_controle, long al_tabela);dc_uo_ds_base lds

Long	ll_Linhas,&
		ll_Linha, ll_registro_pendente
		
String	ls_Log, ls_id_finaliza_promocao, ls_id_prioritaria
		
Boolean	lb_Sucesso = True
Boolean lb_inativacao_loja = False

Try
	
	il_controle = al_controle
	
	if Not of_data_parametro(ref ls_log) Then
		lb_sucesso = false
		return false
	end if
	
	if Not io_Comum.of_atualizacao_pendente( al_controle, ref ll_registro_pendente, ref ls_log) Then 
		lb_sucesso = false
		return false
	end if
	
	//Controle j$$HEX1$$e100$$ENDHEX$$ foi processado
	If ll_registro_pendente = 0 Then Return True
		
	If Not io_Comum.of_Muda_Situacao_Interface(al_Controle, Ref ls_Log) Then Return False
	If Not This.of_Inicializa_Variaveis(Ref ls_Log) Then Return False
	
	if Not this.of_carrega_chave( al_controle, ref is_chave_sap, ref ls_log ) Then Return False
	
	/*
	 PROMOCAO (34)
	 PROMOCAO_PRODUTO (35)			
	 PROMOCAO_FILIAL (38)
	 PROMOCAO_VINCULO (39)
	 PROMOCAO_VINCULO_PRD (40)
	*/
	
	uo_ge473_comum lo_Comum
	lo_Comum = Create uo_ge473_comum
	
	If lo_Comum.of_processa_carrega_dados_v2(al_controle, ref ls_Log) Then
		
		ll_linhas = lo_Comum.ids_lista_registros.RowCount()
		
		if isvalid(w_aguarde_3) Then
			w_aguarde_3.uo_progress_2.of_reset()
			w_aguarde_3.uo_progress_2.of_setmax(ll_linhas)
		end if
		
		For ll_Linha = 1 To ll_linhas
			
			ib_promocao_vinculada = false
			
			is_rede_promocao 			= lo_Comum.ids_lista_registros.Object.cd_organizacao_venda[ll_Linha]
			is_tipo_promocao 				= lo_Comum.ids_lista_registros.Object.cd_categoria_promocao[ll_Linha]
			is_codigo_promocao_sap 	= gf_Tira_Zero_Esquerda(lo_Comum.ids_lista_registros.Object.cd_promocao_sap[ll_Linha])
			is_nome_promocao			= lo_Comum.ids_lista_registros.Object.nm_promocao_sos[ll_Linha]
			is_desc_promocao				= lo_Comum.ids_lista_registros.Object.de_promocao[ll_Linha]
			If Not io_Comum.of_date_time(lo_Comum.ids_lista_registros.Object.dh_inicio[ll_Linha], 'DATA INICIO PROMOCAO', ref idh_inicio_promocao, ref ls_Log) Then Return False
			If Not io_Comum.of_date_time(lo_Comum.ids_lista_registros.Object.dh_termino[ll_Linha], 'DATA TERMINO PROMOCAO', ref idh_termino_promocao, ref ls_Log) Then Return False
			is_altera_estoque_minino	= lo_Comum.ids_lista_registros.Object.id_filial_altera_estoque[ll_Linha]
			is_replicacao					= lo_Comum.ids_lista_registros.Object.id_tipo_replicacao[ll_Linha]
			is_SOS							= lo_Comum.ids_lista_registros.Object.id_sos[ll_Linha]
			is_PBM							= lo_Comum.ids_lista_registros.Object.id_pbm[ll_Linha]
			ls_id_prioritaria = lo_Comum.ids_lista_registros.Object.id_prioritaria[ll_Linha]
			
			is_nr_campanha_sap = gf_Tira_Zero_Esquerda(lo_Comum.ids_lista_registros.Object.nr_campanha_sap[ll_Linha])
			is_nm_campanha = lo_Comum.ids_lista_registros.Object.nm_campanha[ll_Linha]
			is_cd_tipo_campanha = lo_Comum.ids_lista_registros.object.cd_tipo_campanha[ll_linha]
			
			is_nr_oferta_sap = gf_Tira_Zero_Esquerda(lo_Comum.ids_lista_registros.Object.oferta[ll_Linha])
			is_oferta_txt = lo_Comum.ids_lista_registros.Object.oferta_txt[ll_Linha]
			is_promocao_coringa = lo_Comum.ids_lista_registros.Object.id_promocao_coringa[ll_Linha]
			il_qt_recorrencia_cpf_cupom = long(lo_Comum.ids_lista_registros.Object.qt_recorrencia_cpf_cupom[ll_Linha])
			
			this.is_cd_promocao_profimetrics = gf_Tira_Zero_Esquerda(lo_Comum.ids_lista_registros.Object.cd_promocao_profimetrics[ll_Linha])
			this.is_cd_evento = lo_Comum.ids_lista_registros.Object.cd_evento[ll_Linha]
			this.is_de_evento = lo_Comum.ids_lista_registros.Object.de_evento[ll_Linha]
			this.is_cd_subevento = lo_Comum.ids_lista_registros.Object.cd_subevento[ll_Linha]
			this.is_de_subevento = lo_Comum.ids_lista_registros.Object.de_subevento[ll_Linha]
			this.is_cd_midia = lo_Comum.ids_lista_registros.Object.cd_midia[ll_Linha]
			this.il_nr_prioridade = long(lo_Comum.ids_lista_registros.Object.nr_prioridade[ll_Linha])
			this.is_cd_motivo_promocao = lo_Comum.ids_lista_registros.Object.cd_motivo_promocao[ll_Linha]
			this.is_cd_grupo_cliente = lo_Comum.ids_lista_registros.Object.cd_grupo_cliente[ll_Linha]
			
			if is_tipo_promocao = '2' Then is_tipo_promocao = 'M'
			
			if is_cd_promocao_profimetrics = '0' or is_cd_promocao_profimetrics = '' then setnull(is_cd_promocao_profimetrics)
		
			if is_promocao_coringa = 'X' or is_promocao_coringa = 'S' Then
				is_promocao_coringa = 'S'
			else
				is_promocao_coringa = 'N'
			end if
			
			if isvalid(w_aguarde_3) Then
				w_aguarde_3.wf_settext('Promo$$HEX2$$e700e300$$ENDHEX$$o: ' + is_codigo_promocao_sap , 3 )
			end if
			
			if ls_id_prioritaria = 'X' Then
				ib_promocao_pdv = True
			end if
			
			if is_tipo_promocao = 'V' or is_tipo_promocao = 'C' Then
				ib_promocao_vinculada = True
				
			elseif is_tipo_promocao = 'Q' or is_tipo_promocao = 'J' then
				ib_promocao_progressiva = True
			end if
			
			//Campanha do C4
			If ( is_nr_campanha_sap <> '' and not isnull(is_nr_campanha_sap) ) or ( is_nr_oferta_sap <> '' and not isnull(is_nr_oferta_sap) ) Then
				
				is_tipo_promocao = 'M'
					
			else
			
				If is_PBM = 'X' Then //PBM Clamed
				
					if is_tipo_promocao = 'N' or is_tipo_promocao = 'Q' Then
						ib_promocao_pdv = True
					end if
				
					is_tipo_promocao = 'C'
				End If
				
				If is_SOS = 'X' Then //SOS - F3
					is_tipo_promocao = 'S'
				End If
				
			End if	
				
			is_UF 								= lo_Comum.ids_lista_registros.Object.cd_uf[ll_Linha]
			is_Domicilio						= lo_Comum.ids_lista_registros.Object.cd_domicilio_fiscal[ll_Linha]
			
			ls_id_finaliza_promocao = lo_Comum.ids_lista_registros.Object.id_finaliza_promocao[ll_Linha]
			is_canal_distribuicao = lo_Comum.ids_lista_registros.Object.cd_canal_distribuicao[ll_Linha]
			is_de_etiqueta = lo_Comum.ids_lista_registros.Object.de_etiqueta[ll_Linha]
			
			if isvalid(w_aguarde_3) Then
				w_aguarde_3.uo_progress_2.of_setprogress(ll_linha)
			end if
			
		Next
		
	Else
		lb_sucesso = false
		Return False
	End If	
	Destroy(lo_comum)	
	
	if ib_promocao_pdv = True Then
		
		Update interface_sap
		set id_situacao = 'P', dh_processamento = getdate(), de_erro = 'Promo$$HEX2$$e700e300$$ENDHEX$$o pertence ao PDV novo.'
		where nr_controle = :al_controle;
		
		if sqlca.sqlcode = -1 then 
			ls_log = 'Erro ao atualizar a tabela "interface_sap": ' + sqlca.sqlerrtext
			lb_sucesso = false
			return false
		end if
		
		lb_sucesso = True
		return lb_sucesso
		
	end if
	
	If Not This.of_Valida_Dados(Ref ls_Log) Then
		lb_sucesso = false
		return false
	end if
		
	If Not This.of_promocao_nova( ref il_codigo_promocao, ref ib_promocao_nova, ref ls_log ) Then
		lb_sucesso = false
		return false
	end if	
		
	//Se a Promo$$HEX1$$e700$$ENDHEX$$ao ja estiver encerrada, finaliza o processo:	
//	if idh_termino_promocao_ant < idh_atual then
//		
//		Update interface_sap 
//		set id_situacao = 'X', de_erro = 'REGISTRO CANCELADO AUTOMATICAMENTE: PROMOCAO ENCERRADA' 
//		where nr_controle = :al_controle;
//		
//		if sqlca.sqlcode = -1 then 
//			ls_log = 'Erro ao atualizar a tabela "interface_sap": ' + sqlca.sqlerrtext
//			lb_sucesso = false
//			return false
//		end if
//		
//		lb_sucesso = True
//		return True
//	ENd if
		
	//CAMPANHA	
	if is_nr_campanha_sap	<> '' and not isnull(is_nr_campanha_sap) Then
			
		If Not of_insere_campanha(is_nr_campanha_sap, is_nm_campanha, 'C', ref ls_log ) Then
			lb_sucesso = false
			return false
		end if
		
	end if
		
	//Verifica se a promo$$HEX2$$e700e300$$ENDHEX$$o foi encerrada.	
	if ls_id_finaliza_promocao = 'X' Then
		
		if ib_promocao_nova = False Then
			
			if Not of_finaliza_promocao(il_codigo_promocao, ref ls_log) Then
				lb_sucesso = False
				return False
			end if
			
		End if
		
		lb_sucesso = True
		return True
		
	End if
	
	If Not This.of_insere_promocao_sos( il_codigo_promocao, ib_promocao_nova, ref ls_log) Then
		lb_sucesso = false
		return false
	end if
		
	If Not This.of_insere_promocao_filial( il_codigo_promocao, ib_promocao_nova, ref lb_inativacao_loja, ref ls_log, al_controle ) Then 
		lb_sucesso = false
		return false
	end if
	
	//Se for apenas uma inativacao de loja, nao continua o processo:
	If lb_inativacao_loja = False Then
	
		If Not This.of_insere_promocao_produto( il_codigo_promocao, ib_promocao_nova, ref ls_log, al_controle ) Then
			lb_sucesso = false
			return false
		end if
		
		If Not This.of_insere_promocao_sos_vinculo( il_codigo_promocao, ib_promocao_nova, ref ls_log, al_controle ) Then
			lb_sucesso = false
			return false
		end if
		
		If Not This.of_insere_promocao_vinculo_prd( il_codigo_promocao, ib_promocao_nova, ref ls_log, al_controle ) Then
			lb_Sucesso	= False
			return false
		end if
			
	ENd if
		
Finally
	
	If lb_Sucesso Then
		SqlCa.of_Commit()
	Else
		SqlCA.of_RollBack()
		io_Comum.of_grava_erro(al_controle, 183, ls_Log)
	End If
		
	Destroy(lds)
	Destroy(lo_comum)
	
End Try

Return lb_Sucesso
end function

public function boolean of_insere_promocao_produto (long al_promocao, boolean ab_promocao_nova, ref string as_log, long al_controle_pai);Long ll_linhas
Long ll_linha
Long ll_produto
Long ll_achou
Long ll_controle_filho
Long ll_qt_minimo
Long ll_cd_desconto
Long ll_cd_desconto_clube
Long ll_row
Long ll_find, ll_existe
Long ll_nr_pagina
Long ll_nr_nivel_desconto

DateTime ldt_inicio
DateTime ldt_termino
DateTime ldt_alteracao
DateTime ldt_vigencia_futuro
DateTime ldt_inativacao

Date ldt_futuro

Decimal ldc_pc_desconto
Decimal ldc_pc_desconto_clube
Decimal ldc_pc_desconto_futuro
Decimal ldc_pc_desconto_clube_futuro
Decimal ldc_vl_preco_promocao
Decimal ldc_vl_verba_unitaria
Decimal ldc_vl_verba_maximo
Decimal ldc_vl_preco_clube
Decimal ldc_vl_preco_de
Decimal ldc_nivel_desconto
Decimal ldc_nr_pagina

String ls_produto_sap, ls_chave_sap_prod, ls_cd_promocao_sap, ls_id_finaliza_produto, ls_produto_sap_dw, ls_matricula_futuro, ls_de_etiqueta_promo
String ls_cd_tipo_verba, ls_cd_agrupamento, ls_cd_posicao, ls_cd_fornecedor_verba, ls_id_situacao

Boolean lb_atualizou_campanha_cupom = false

datastore lds_dados, lds_desconto, lds_desconto_clube

Try
			
	SELECT nr_controle, de_chave_sap
	Into :ll_Controle_filho, :ls_chave_sap_prod
	FROM interface_sap  i 
	Where i.cd_tabela = 35
		and i.nr_controle_pai = :al_controle_pai
	Using SqlCa;	

	If SqlCa.sqlcode = -1 Then
		as_Log	= "Erro ao buscar o controle na tabela interface_sap. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle_pai)+". Erro: "+SqlCa.sqlErrText
		Return False
	End If
	
	ls_chave_sap_prod = gf_Tira_Zero_Esquerda(ls_chave_sap_prod)
	
	if (ll_controle_filho = 0 or isnull(ll_controle_filho) ) Then
		if ab_promocao_nova = True Then
			as_Log	= "N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ informa$$HEX2$$e700f500$$ENDHEX$$es de produto na tabela interface_sap."
			return false
		end if
	end if
	
	if ls_chave_sap_prod <> is_chave_sap Then
		as_log = 'O c$$HEX1$$f300$$ENDHEX$$digo chave SAP do controle de produto [' + ls_chave_sap_prod + '] $$HEX1$$e900$$ENDHEX$$ diferente do c$$HEX1$$f300$$ENDHEX$$digo chave SAP do controle de promo$$HEX2$$e700e300$$ENDHEX$$o [' + is_chave_sap + '].'
		return false
	end if
	
	uo_ge473_comum lo_Comum
	lo_Comum = Create uo_ge473_comum
			
	If lo_Comum.of_processa_carrega_dados_v2(ll_Controle_filho, ref as_Log) Then	
		
		lds_desconto = create datastore
		lds_desconto.dataobject = 'ds_ge473_desconto_progressivo_qtd'
		
		lds_desconto_clube = create datastore
		lds_desconto_clube.dataobject = 'ds_ge473_desconto_progressivo_qtd'
		
		lo_Comum.ids_lista_registros.setsort('cd_produto_sap')
		lo_Comum.ids_lista_registros.sort()
		
		For ll_Linha = 1 To lo_Comum.ids_lista_registros.RowCount()
			
			ls_cd_promocao_sap = gf_Tira_Zero_Esquerda( lo_Comum.ids_lista_registros.object.cd_promocao_sap[ll_linha] )
			
			if ls_cd_promocao_sap <> is_chave_sap Then
				as_log = 'O c$$HEX1$$f300$$ENDHEX$$digo promo$$HEX2$$e700e300$$ENDHEX$$o SAP do controle de produto [' + ls_cd_promocao_sap + '] $$HEX1$$e900$$ENDHEX$$ diferente do c$$HEX1$$f300$$ENDHEX$$digo chave SAP do controle de promo$$HEX2$$e700e300$$ENDHEX$$o [' + is_chave_sap + '].'
				return false
			end if
			
			ldc_pc_desconto_futuro = 0
			ldc_pc_desconto_clube_futuro = 0
			setnull(ls_matricula_futuro)
			
			//Armazeno o c$$HEX1$$f300$$ENDHEX$$digo do produto como est$$HEX1$$e100$$ENDHEX$$ na DW, para utilizar no FIND mais adiante.
			ls_produto_sap_dw = lo_Comum.ids_lista_registros.Object.cd_produto_sap[ll_Linha]
			
			ls_produto_sap = gf_Tira_Zero_Esquerda(lo_Comum.ids_lista_registros.Object.cd_produto_sap[ll_Linha])
			If IsNull(ls_produto_sap) Then ls_produto_sap = ''
			
			If Not io_Comum.of_Localiza_Codigo_Produto_Legado(ls_produto_sap, Ref ll_Produto, Ref as_Log) Then
				Return False
			End If			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.pc_desconto[ll_Linha], 'PC DESCONTO', ref ldc_pc_desconto, ref as_Log) Then
				Return False
			End If			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.pc_desconto_clube[ll_Linha], 'PC DESCONTO CLUBE', ref ldc_pc_desconto_clube, ref as_Log) Then
				Return False
			End If										
			If Not io_Comum.of_date_time(lo_Comum.ids_lista_registros.Object.dh_inicio_vigencia[ll_Linha], 'DATA INICIO VALIDADE DESCONTO', ref ldt_inicio, ref as_Log) Then 
				Return False
			End If										
			If Not io_Comum.of_date_time(lo_Comum.ids_lista_registros.Object.dh_termino_vigencia[ll_Linha], 'DATA TERMINO VALIDADE DESCONTO', ref ldt_termino, ref as_Log) Then 
				Return False
			End If
			
			ll_qt_minimo = Long(gf_Replace(lo_Comum.ids_lista_registros.Object.qt_minima_desconto_progressivo[ll_Linha], '.', ',', 0))
			
			ls_id_finaliza_produto = lo_Comum.ids_lista_registros.Object.id_finaliza_produto[ll_Linha]
			ls_de_etiqueta_promo = lo_Comum.ids_lista_registros.Object.de_etiqueta_promocao[ll_Linha] 
			
			//????????????
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.vl_preco_promocao[ll_Linha], 'VL PRECO PROMOCAO', ref ldc_vl_preco_promocao, ref as_Log) Then
				Return False
			End If
			
			if ldc_vl_preco_promocao >= 100000 Then
				ldc_vl_preco_promocao = 99999.99
			End if
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.vl_verba_unitaria[ll_Linha], 'VL VERBA UNITARIA', ref ldc_vl_verba_unitaria, ref as_Log) Then
				Return False
			End If
			
			if ldc_vl_verba_unitaria >= 100000 Then
				ldc_vl_verba_unitaria = 99999.99
			End if
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.vl_verba_maximo[ll_Linha], 'VL VERBA MAXIMO', ref ldc_vl_verba_maximo, ref as_Log) Then
				Return False
			End If
			
			if ldc_vl_verba_maximo >= 100000 Then
				ldc_vl_verba_maximo = 99999.99
			End if
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.vl_preco_clube[ll_Linha], 'VL PRECO CLUBE', ref ldc_vl_preco_clube, ref as_Log) Then
				Return False
			End If
			
			if ldc_vl_preco_clube >= 100000 Then
				ldc_vl_preco_clube = 99999.99
			End if
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.vl_preco_de[ll_Linha], 'VL PRECO DE', ref ldc_vl_preco_de, ref as_Log) Then
				Return False
			End If
			
			if ldc_vl_preco_de >= 100000 Then
				ldc_vl_preco_de = 99999.99
			End if
			
			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.nr_nivel_desconto[ll_Linha], 'NR NIVEL DESCONTO', ref ldc_nivel_desconto, ref as_Log) Then
				Return False
			End If
			
			ll_nr_nivel_desconto = long(ldc_nivel_desconto)
			
			ls_cd_tipo_verba = lo_Comum.ids_lista_registros.Object.cd_tipo_verba[ll_Linha]

			If Not io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.nr_pagina[ll_Linha], 'NR PAGINA', ref ldc_nr_pagina, ref as_Log) Then
				Return False
			End If
			ll_nr_pagina = long(ldc_nr_pagina)
			
			ls_cd_agrupamento = lo_Comum.ids_lista_registros.Object.cd_agrupamento[ll_Linha]
			ls_cd_posicao = lo_Comum.ids_lista_registros.Object.cd_posicao[ll_Linha]
			ls_cd_fornecedor_verba = lo_Comum.ids_lista_registros.Object.cd_fornecedor_verba[ll_Linha] 
						
			if isnull(ll_nr_nivel_desconto) Then ll_nr_nivel_desconto = 1
			
			//????????????
			
			ldt_alteracao = idh_atual
			
			SetNull(ldt_vigencia_futuro)
			
			if ls_id_finaliza_produto = 'X' then
				ls_id_situacao = 'I'
				ldt_inativacao = idh_atual
			else
				ls_id_situacao = 'A'
				setnull(ldt_inativacao)
			end if
			
			//Quando for Promo$$HEX2$$e700e300$$ENDHEX$$o progressiva
			if is_tipo_promocao = 'Q' or ib_promocao_progressiva = True Then
				
				if isnull(ll_qt_minimo) or ll_qt_minimo = 0 Then
					as_Log	= "Quantidade m$$HEX1$$ed00$$ENDHEX$$nima do produto n$$HEX1$$e300$$ENDHEX$$o pode ser nula quando a promo$$HEX2$$e700e300$$ENDHEX$$o for do tipo Progressiva."
					Return False
				else
					
					if ll_qt_minimo > 5 Then
						as_Log	= "Quantidade m$$HEX1$$ed00$$ENDHEX$$nima do produto [" + string(ll_qt_minimo) + "] n$$HEX1$$e300$$ENDHEX$$o pode ser superior a 5 quando a promo$$HEX2$$e700e300$$ENDHEX$$o for do tipo Progressiva."
						Return False
					end if
				end if
				
				if ldc_pc_desconto > 0 Then
				
				
					if lds_desconto.find('qt_minima = ' + string(ll_qt_minimo) + ' and String(pc_desconto) = "' + string(ldc_pc_desconto) + '"', 1, lds_desconto.rowcount() ) = 0 Then
				
						ll_row = lds_desconto.insertrow(0)
						
						lds_desconto.object.qt_minima[ll_row] = ll_qt_minimo
						lds_desconto.object.pc_desconto[ll_row] = ldc_pc_desconto
					end if
					
				end if
				
				if ldc_pc_desconto_clube > 0 Then
				
					if lds_desconto_clube.find('qt_minima = ' + string(ll_qt_minimo) + ' and String(pc_desconto) = "' + string(ldc_pc_desconto_clube) + '"', 1, lds_desconto_clube.rowcount() ) = 0 Then
				
						ll_row = lds_desconto_clube.insertrow(0)
						
						lds_desconto_clube.object.qt_minima[ll_row] = ll_qt_minimo
						lds_desconto_clube.object.pc_desconto[ll_row] = ldc_pc_desconto_clube
						
					end if
					
				end if
				
				If Not this.of_insere_promocao_recuperacao_verba( il_codigo_promocao, ll_produto, ls_cd_tipo_verba, ldc_vl_verba_unitaria, ldc_vl_verba_maximo, ls_cd_fornecedor_verba, ll_qt_minimo, ref as_log) then return false
				
				if this.is_tipo_promocao = 'J' Then
					If Not this.of_insere_promocao_sos_produto_crm( il_codigo_promocao, ll_produto, ll_nr_nivel_desconto, ldc_vl_preco_promocao, ref as_log) Then return false
				ENd if
				
				if ll_linha = lo_Comum.ids_lista_registros.rowcount( ) Then
					ll_find = 0 
				else
					//Verifica se o produto aparece novamente na DW. Se aparecer , d$$HEX1$$e100$$ENDHEX$$ um continue para n$$HEX1$$e300$$ENDHEX$$o inserir o produto duas vezes.
					ll_find = lo_Comum.ids_lista_registros.find('cd_produto_sap = "' + ls_produto_sap_dw + '"', ll_linha + 1, lo_Comum.ids_lista_registros.rowcount( ) )
				end if
				
				if ll_find > 0 Then
					Continue
				end if
				
				if lds_desconto.rowcount() > 0 Then
					if Not of_insere_desconto_prog(lds_desconto, ref ll_cd_desconto, ref as_log) Then return false
				else
					setnull(ll_cd_desconto)
				end if
				
				if lds_desconto_clube.rowcount() > 0 Then
					if Not of_insere_desconto_prog(lds_desconto_clube, ref ll_cd_desconto_clube, ref as_log) Then return false
				else
					setnull(ll_cd_desconto_clube)
				end if
				
				lds_desconto.reset()
				lds_desconto_clube.reset()
				
				ldc_pc_desconto = 0
				ldc_pc_desconto_clube = 0
				
			else	
				setnull(ll_cd_desconto)
				setnull(ll_cd_desconto_clube)
			end if
		
			Select cd_promocao_sos
			Into :ll_Achou
			from promocao_sos_produto
			where cd_promocao_sos = :il_codigo_promocao
				and cd_produto = :ll_produto
			Using SqlCa;

			Choose Case SqlCa.SqlCode
				Case 0
					
					if ls_id_finaliza_produto = 'X' Then
					
						ldc_pc_desconto_futuro = 0
						ldc_pc_desconto_clube_futuro = 0
						ldc_pc_desconto = 0
						ldc_pc_desconto_clube = 0
						
						Update promocao_sos_produto
							Set pc_desconto_futuro 				= :ldc_pc_desconto_futuro,
								 pc_desconto_clube_futuro 		= :ldc_pc_desconto_clube_futuro,
								 dh_alteracao 						= :ldt_alteracao,
								 nr_matricula_alteracao 		= :is_matricula_sap,
								 nr_matricula_alteracao_futuro = :ls_matricula_futuro,
								 pc_desconto 						= :ldc_pc_desconto,
								 pc_desconto_clube 				= :ldc_pc_desconto_clube,
								 vl_preco_promocao				= :ldc_vl_preco_de,
								 vl_preco_clube						= :ldc_vl_preco_de,
								 dh_atualizacao 					= GetDate(),
								 id_situacao							= :ls_id_situacao,
								 dh_inativacao						= :ldt_inativacao
							where cd_promocao_sos = :il_codigo_promocao
								and cd_produto = :ll_produto
							Using SqlCa;

							If SqlCa.SqlCode = -1 Then
								as_Log	= "Erro ao atualizar produto tabela:'PROMOCAO_SOS_PRODUTO' . Erro: "+SqlCa.sqlErrText
								Return False
							End If
							
							//CAMPANHA
							if il_nr_campanha_legado > 0 Then
								
								Update campanha_produto
								set pc_desconto = :ldc_pc_desconto
								where nr_campanha = :il_nr_campanha_legado
								and cd_produto = :ll_produto;
							
								If SqlCa.SqlCode = -1 Then
									as_Log	= "Erro ao atualizar produto tabela:'CAMPANHA_PRODUTO' . Erro: "+SqlCa.sqlErrText
									Return False
								End If
							
							end if


					else

						ldt_vigencia_futuro = ldt_inicio
						ldc_pc_desconto_futuro = ldc_pc_desconto
						ldc_pc_desconto_clube_futuro = ldc_pc_desconto_clube
						ls_matricula_futuro = is_matricula_sap
						
						If date(ldt_inicio) <= date(ldt_alteracao) Then //Vig$$HEX1$$ea00$$ENDHEX$$ncia menor ou igual a data atual, colocar vig$$HEX1$$ea00$$ENDHEX$$ncia futura para data atual + 1
						
							ldc_pc_desconto_futuro = 0
							ldc_pc_desconto_clube_futuro = 0
							setnull(ldt_vigencia_futuro)
							setnull(ls_matricula_futuro)
							
							If ldt_termino < idh_termino_promocao Then //Termino antes da promocao, zera descontos futuros e coloca vigencia futura para termino + 1
								If Not gf_DateAdd(Date(ldt_termino), "day", 1, Ref ldt_futuro) Then
									as_Log	= "Erro calcular vigencia futura tabela:'PROMOCAO_SOS_PRODUTO' ."
									Return False
								End If
								ldt_vigencia_futuro = DateTime(ldt_futuro)		
								ls_matricula_futuro = is_matricula_sap
							End If
							
							Update promocao_sos_produto
							Set pc_desconto 					= :ldc_pc_desconto,
								pc_desconto_clube 			= :ldc_pc_desconto_clube,
								pc_desconto_futuro 			= :ldc_pc_desconto_futuro,
								pc_desconto_clube_futuro 	= :ldc_pc_desconto_clube_futuro,
								dh_alteracao 					= :ldt_alteracao,
								nr_matricula_alteracao		= :is_matricula_sap,
								nr_matricula_alteracao_futuro = :ls_matricula_futuro,
								dh_vigencia_futuro 			= :ldt_vigencia_futuro,
								cd_desc_progressivo 			= :ll_cd_desconto,
								cd_desc_progressivo_clube 	= :ll_cd_desconto_clube,
								de_etiqueta_promocao 		= :ls_de_etiqueta_promo,
								dh_atualizacao					= GetDate(),
								vl_preco_promocao 			= :ldc_vl_preco_promocao,
								nr_pagina 						= :ll_nr_pagina,
								cd_agrupamento 				= :ls_cd_agrupamento,
								cd_posicao 						= :ls_cd_posicao,
								vl_preco_clube					= :ldc_vl_preco_clube,
								vl_preco_de						= :ldc_vl_preco_de,
								id_situacao 						= :ls_id_situacao,
								dh_inativacao					= :ldt_inativacao
							where cd_promocao_sos = :il_codigo_promocao
								and cd_produto = :ll_produto
							Using SqlCa;
							
							If SqlCa.SqlCode = -1 Then
								as_Log	= "Erro ao atualizar produto tabela:'PROMOCAO_SOS_PRODUTO' . Erro: "+SqlCa.sqlErrText
								Return False
							End If
							
							if il_nr_campanha_legado > 0 Then
								
								Update campanha_produto
								set pc_desconto = :ldc_pc_desconto, qt_maxima_venda = :il_qt_recorrencia_cpf_cupom
								where nr_campanha = :il_nr_campanha_legado
								and cd_produto = :ll_produto;
							
								If SqlCa.SqlCode = -1 Then
									as_Log	= "Erro ao atualizar produto tabela:'CAMPANHA_PRODUTO' . Erro: "+SqlCa.sqlErrText
									Return False
								End If
							
								if lb_atualizou_campanha_cupom = false Then
									lb_atualizou_campanha_cupom = True
									
									Update campanha
									set de_mensagem_cupom_desconto = :ls_de_etiqueta_promo
									where nr_campanha = :il_nr_campanha_legado;
								
									If SqlCa.SqlCode = -1 Then
										as_Log	= "Erro ao atualizar produto tabela:'CAMPANHA' . Erro: "+SqlCa.sqlErrText
										Return False
									End If
								end if
							
							end if
							
							
						Else 
							
							if ldt_termino < idh_termino_promocao Then //Termino antes da promocao, zera descontos futuros e coloca vigencia futura para termino + 1
								ldc_pc_desconto_futuro = 0
								ldc_pc_desconto_clube_futuro = 0
								setnull(ls_matricula_futuro)
								
								If Not gf_DateAdd(Date(ldt_termino), "day", 1, Ref ldt_futuro) Then
									as_Log	= "Erro calcular vigencia futura tabela:'PROMOCAO_SOS_PRODUTO' ."
									Return False
								End If
								ldt_vigencia_futuro = DateTime(ldt_futuro)	
								ls_matricula_futuro = is_matricula_sap
							End If
						
							Update promocao_sos_produto
							Set pc_desconto 					= :ldc_pc_desconto,
	  							 pc_desconto_clube 			= :ldc_pc_desconto_clube,
								 pc_desconto_futuro 				= :ldc_pc_desconto_futuro,
								 pc_desconto_clube_futuro 		= :ldc_pc_desconto_clube_futuro,
								 dh_alteracao 						= :ldt_alteracao,
								 nr_matricula_alteracao 		= :is_matricula_sap,
								 nr_matricula_alteracao_futuro = :ls_matricula_futuro,
								 dh_vigencia_futuro 				= :ldt_vigencia_futuro,
								 cd_desc_progressivo 			= :ll_cd_desconto,
								 cd_desc_progressivo_clube 	= :ll_cd_desconto_clube,
								 de_etiqueta_promocao 			= :ls_de_etiqueta_promo,
								 dh_atualizacao					= GetDate(),
								 vl_preco_promocao 			= :ldc_vl_preco_promocao,
								nr_pagina 						= :ll_nr_pagina,
								cd_agrupamento 				= :ls_cd_agrupamento,
								cd_posicao 						= :ls_cd_posicao,
								vl_preco_clube					= :ldc_vl_preco_clube,
								vl_preco_de						= :ldc_vl_preco_de,
								id_situacao						= :ls_id_situacao,
								dh_inativacao					= :ldt_inativacao
							where cd_promocao_sos = :il_codigo_promocao
								and cd_produto = :ll_produto
							Using SqlCa;
							
							If SqlCa.SqlCode = -1 Then
								as_Log	= "Erro ao atualizar produto tabela:'PROMOCAO_SOS_PRODUTO' . Erro: "+SqlCa.sqlErrText
								Return False
							End If
							
							//CAMPANHA
							if il_nr_campanha_legado > 0 Then
								
								Update campanha_produto
								set pc_desconto = :ldc_pc_desconto, qt_maxima_venda = :il_qt_recorrencia_cpf_cupom
								where nr_campanha = :il_nr_campanha_legado
								and cd_produto = :ll_produto;
							
								If SqlCa.SqlCode = -1 Then
									as_Log	= "Erro ao atualizar produto tabela:'CAMPANHA_PRODUTO' . Erro: "+SqlCa.sqlErrText
									Return False
								End If
							
								if lb_atualizou_campanha_cupom = false Then
									lb_atualizou_campanha_cupom = True
									
									Update campanha
									set de_mensagem_cupom_desconto = :ls_de_etiqueta_promo
									where nr_campanha = :il_nr_campanha_legado;
								
									If SqlCa.SqlCode = -1 Then
										as_Log	= "Erro ao atualizar produto tabela:'CAMPANHA' . Erro: "+SqlCa.sqlErrText
										Return False
									End If
								end if
							
							end if
							
						End if
					end if
					
				Case 100
												
					if ls_id_finaliza_produto = 'X' Then
						
						ldc_pc_desconto_futuro  			= 0
						ldc_pc_desconto_clube_futuro	= 0
						ldc_pc_desconto = 0
						ldc_pc_desconto_clube = 0	
						ls_matricula_futuro = is_matricula_sap
						
					else
					
						If Date(ldt_inicio) > Date(idh_inicio_promocao) and ldt_inicio > ldt_alteracao Then //Inicio Maior que o inicio dao promo$$HEX2$$e700e300$$ENDHEX$$o, zerar descontos normaisl, colocar descontos futuros e vig$$HEX1$$ea00$$ENDHEX$$ncia futura.
							//Zerar descontos e grava nos descontos futuros
							ldc_pc_desconto_futuro  			= ldc_pc_desconto
							ldc_pc_desconto_clube_futuro	= ldc_pc_desconto_clube
							ls_matricula_futuro = is_matricula_sap
							ldc_pc_desconto = 0
							ldc_pc_desconto_clube = 0						
							ldt_vigencia_futuro = ldt_inicio
							If Date(ldt_inicio) <= Date(ldt_alteracao) Then
								If Not gf_DateAdd(Date(ldt_alteracao), "day", 1, Ref ldt_futuro) Then
									as_Log	= "Erro calcular vigencia futura tabela:'PROMOCAO_SOS_PRODUTO' ."
									Return False
								End If													
								ldt_vigencia_futuro = DateTime(ldt_futuro)
								ls_matricula_futuro = is_matricula_sap
							End If
						End If			
						
					end if
					
					insert into promocao_sos_produto(
							cd_promocao_sos, 
							cd_produto, 
							pc_desconto, 
							dh_alteracao, 
							nr_matricula_alteracao, 
							pc_desconto_clube,
							pc_desconto_futuro,
							pc_desconto_clube_futuro,
							dh_vigencia_futuro,
							cd_desc_progressivo,
							cd_desc_progressivo_clube,
							nr_matricula_alteracao_futuro,
							de_etiqueta_promocao,
							dh_atualizacao,
							vl_preco_promocao,
							nr_pagina,
							cd_agrupamento,
							cd_posicao,
							vl_preco_clube,
							vl_preco_de,
							id_situacao,
							dh_inativacao)
					values (	:il_codigo_promocao,  
								:ll_Produto,
								:ldc_pc_desconto, 
								:ldt_alteracao, 
								:is_matricula_sap, 
								:ldc_pc_desconto_clube,
								:ldc_pc_desconto_futuro,
								:ldc_pc_desconto_clube_futuro,
								:ldt_vigencia_futuro,
								:ll_cd_desconto,
								:ll_cd_desconto_clube,
								:ls_matricula_futuro,
								:ls_de_etiqueta_promo,
								GetDate(),
								:ldc_vl_preco_promocao,
								:ll_nr_pagina,
								:ls_cd_agrupamento,
								:ls_cd_posicao,
								:ldc_vl_preco_clube,
								:ldc_vl_preco_de,
								:ls_id_situacao,
								:ldt_inativacao
								)
					Using SqlCA;
						
					If SqlCa.SqlCode = -1 Then
						as_Log	= "Erro no insert da tabela 'PROMOCAO_SOS_PRODUTO'. Erro: "+SqlCa.sqlErrText
						Return False
					End If
					
					if il_nr_campanha_legado > 0 Then
							
							Select count(*)
							into :ll_existe
							from campanha_produto
							where nr_campanha = :il_nr_campanha_legado
							and cd_produto = :ll_produto;
							
							If SqlCa.SqlCode = -1 Then
								as_Log	= "Erro ao consultar a tabela 'CAMPANHA_PRODUTO'. Erro: "+SqlCa.sqlErrText
								Return False
							End If
							
							if ll_existe = 0 or isnull(ll_existe) Then
							
								insert into campanha_produto (nr_campanha, cd_produto, pc_desconto, qt_maxima_venda)
								values(:il_nr_campanha_legado, :ll_produto, :ldc_pc_desconto, :il_qt_recorrencia_cpf_cupom);
							
								If SqlCa.SqlCode = -1 Then
									as_Log	= "Erro ao inserir produto na tabela:'CAMPANHA_PRODUTO' . Erro: "+SqlCa.sqlErrText
									Return False
								End If
							end if
							
							if lb_atualizou_campanha_cupom = false Then
								lb_atualizou_campanha_cupom = True
								
								Update campanha
								set de_mensagem_cupom_desconto = :ls_de_etiqueta_promo
								where nr_campanha = :il_nr_campanha_legado;
							
								If SqlCa.SqlCode = -1 Then
									as_Log	= "Erro ao atualizar produto tabela:'CAMPANHA' . Erro: "+SqlCa.sqlErrText
									Return False
								End If
							end if
							
							
					end if
					
					
				Case -1
					as_Log	= "Erro no select da tabela 'PROMOCAO_SOS_PRODUTO'. Erro: "+SqlCa.sqlErrText
					Return False
			End Choose				
			
			//??????
			if Not ib_promocao_progressiva then
				If Not this.of_insere_promocao_recuperacao_verba( il_codigo_promocao, ll_produto, ls_cd_tipo_verba, ldc_vl_verba_unitaria, ldc_vl_verba_maximo, ls_cd_fornecedor_verba, ll_qt_minimo, ref as_log) then return false
			end if
			
			if this.is_tipo_promocao = 'J' Then
				If Not this.of_insere_promocao_sos_produto_crm( il_codigo_promocao, ll_produto, ll_nr_nivel_desconto, ldc_vl_preco_promocao, ref as_log) Then return false
			ENd if
			//??????
			
		Next	
	Else
		Return False				
	End If
	
Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_insere_promocao_produto'. Erro: "+lo_rte.GetMessage( )
	Return False	
Finally
	If IsValid(lo_Comum) Then Destroy(lo_Comum)
End Try	

Return True
end function

public function boolean of_insere_promocao_vinculo_prd (long al_promocao, boolean ab_promocao_nova, ref string as_log, long al_controle_pai);Long ll_linhas
Long ll_linha
Long ll_produto
Long ll_achou
Long ll_controle_filho
Long ll_vinculo
Long ll_find

String ls_produto_sap, ls_chave_sap_prd, ls_cd_promocao_sap

dc_uo_ds_base lds_promocao_vinc_prd
			
Try
	
	//Se n$$HEX1$$e300$$ENDHEX$$o for promo$$HEX2$$e700e300$$ENDHEX$$o vinculada sai da fun$$HEX2$$e700e300$$ENDHEX$$o.
	if is_tipo_promocao <> 'V' and is_tipo_promocao <> 'C' and ib_promocao_vinculada = False Then return True

	SELECT nr_controle, de_chave_sap
	Into :ll_Controle_filho, :ls_chave_sap_prd
	FROM interface_sap  i 
	Where i.cd_tabela = 40
		and i.nr_controle_pai = :al_controle_pai
	Using SqlCa;	

	If SqlCa.sqlcode = -1 Then
		as_Log	= "Erro ao buscar o controle na tabela interface_sap. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle_pai)+". Erro: "+SqlCa.sqlErrText
		Return False
	End If	
	
	ls_chave_sap_prd = gf_Tira_Zero_Esquerda(ls_chave_sap_prd)
	
	if ls_chave_sap_prd <> is_chave_sap Then
		as_log = 'O c$$HEX1$$f300$$ENDHEX$$digo chave SAP do controle de v$$HEX1$$ed00$$ENDHEX$$nculo produto [' + ls_chave_sap_prd + '] $$HEX1$$e900$$ENDHEX$$ diferente do c$$HEX1$$f300$$ENDHEX$$digo chave SAP do controle de promo$$HEX2$$e700e300$$ENDHEX$$o [' + is_chave_sap + '].'
		return false
	end if
	
	lds_promocao_vinc_prd = Create dc_uo_ds_base
	lds_promocao_vinc_prd.of_ChangeDataObject("ds_ge473_promocao_sos_vinculo_prd")
	
	uo_ge473_comum lo_Comum
	lo_Comum = Create uo_ge473_comum
			
	If lo_Comum.of_processa_carrega_dados_v2(ll_Controle_filho, ref as_Log) Then		
		For ll_Linha = 1 To lo_Comum.ids_lista_registros.RowCount()

			ls_cd_promocao_sap =  gf_Tira_Zero_Esquerda(lo_Comum.ids_lista_registros.object.cd_promocao_sap[ll_linha])
			
			if ls_cd_promocao_sap <> is_chave_sap Then
				as_log = 'O c$$HEX1$$f300$$ENDHEX$$digo promo$$HEX2$$e700e300$$ENDHEX$$o SAP do controle de v$$HEX1$$ed00$$ENDHEX$$nculo produto [' + ls_cd_promocao_sap + '] $$HEX1$$e900$$ENDHEX$$ diferente do c$$HEX1$$f300$$ENDHEX$$digo chave SAP do controle de promo$$HEX2$$e700e300$$ENDHEX$$o [' + is_chave_sap + '].'
				return false
			end if

			If Not IsNumber(lo_Comum.ids_lista_registros.Object.nr_vinculo[ll_Linha]) Then
				as_Log = "O valor informado para o campo NR_VINCULO n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ v$$HEX1$$e100$$ENDHEX$$lido."
				Return False
			Else
				ll_vinculo = Long(lo_Comum.ids_lista_registros.Object.nr_vinculo[ll_Linha])
			End If
			
			ls_produto_sap = gf_Tira_Zero_Esquerda(lo_Comum.ids_lista_registros.Object.cd_produto_sap[ll_Linha])
			If IsNull(ls_produto_sap) Then ls_produto_sap = ''
			
			If Not io_Comum.of_Localiza_Codigo_Produto_Legado(ls_produto_sap, Ref ll_Produto, Ref as_Log) Then
				Return False
			End If
			
			Select cd_promocao_sos
			Into :ll_Achou
			from promocao_sos_vinculo
			where cd_promocao_sos = :il_codigo_promocao
				and nr_vinculo = :ll_vinculo
			Using SqlCa;

			Choose Case SqlCa.SqlCode
				Case 100
					as_Log	= "Vinculo n$$HEX1$$e300$$ENDHEX$$o existe na tabela promocao_sos_vinculo."
					Return False										
				Case -1	
					as_Log	= "Erro ao localizar promocao_sos_vinculo. Erro: "+SqlCa.sqlErrText
					Return False					
			End Choose

			Select count(*)
			Into :ll_Achou
			from promocao_sos_vinculo_prd
			where cd_promocao_sos = :il_codigo_promocao
				and nr_vinculo = :ll_vinculo
				and cd_produto = :ll_produto
			Using SqlCa;

			if Sqlca.sqlcode = -1	then
				as_Log	= "Erro ao consultar a tabela 'promocao_sos_vinculo_prd'. Erro: "+SqlCa.sqlErrText
				Return False
			end if

			If ll_achou = 0 or isnull(ll_achou) Then
				
				Insert into promocao_sos_vinculo_prd(	cd_promocao_sos, 
																nr_vinculo,
																cd_produto)
					Values (	:il_codigo_promocao, 
								:ll_vinculo, 
								:ll_produto  )
					Using SqlCa;
												
					If SqlCa.sqlcode = -1 Then
						as_Log	= "Erro no insert da tabela 'promocao_sos_vinculo_prd'. Erro: "+SqlCa.sqlErrText
						Return False
					End If			
				
			else
				Continue
				
			end if
			
		Next
		
		//Verifica exclusao
		If	lo_Comum.ids_lista_registros.RowCount() > 0 Then
			lds_promocao_vinc_prd.Reset()
			lds_promocao_vinc_prd.Retrieve(il_codigo_promocao)
	
			For ll_linha = 1 To lds_promocao_vinc_prd.RowCount()				
	
				ll_vinculo = lds_promocao_vinc_prd.Object.nr_vinculo [ll_LInha]
				
				ll_find	= lo_Comum.ids_lista_registros.Find ("long(nr_vinculo) = " + String(ll_vinculo) , 1 , lo_Comum.ids_lista_registros.RowCount())
												 
				If ll_find > 0 Then
					Continue
				Else
					If ll_find < 0 Then
						as_Log	= "Erro no find da promocao_vinculo_prd sap."
						Return False
					End If	
					If ll_find = 0 Then						
						Delete from promocao_sos_vinculo_prd
						Where cd_promocao_sos = :il_codigo_promocao
							and nr_vinculo = :ll_vinculo
						Using SqlCa;
													
						If SqlCa.sqlcode = -1 Then
							as_Log	= "Erro delete da tabela 'promocao_sos_vinculo_prd'. Erro: "+SqlCa.sqlErrText
							Return False
						End If			
					End If				
				End If			
			Next
			
		End If
		
	Else
		Return False				
	End If			

	
Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_insere_promocao_vinculo_prd'. Erro: "+lo_rte.GetMessage( )
	Return False	
Finally
	If IsValid(lds_promocao_vinc_prd) Then Destroy(lds_promocao_vinc_prd)
	If IsValid(lo_Comum) Then Destroy(lo_Comum)
End Try	

Return True
end function

public function boolean of_insere_promocao_sos_vinculo (long al_promocao, boolean ab_promocao_nova, ref string as_log, long al_controle_pai);Long ll_linhas
Long ll_linha
Long ll_produto
Long ll_achou
Long ll_controle_filho
Long ll_vinculo
Long ll_find
Long ll_quantidade

String ls_de_vinculo, ls_chave_sap_vinc, ls_cd_promocao_sap

dc_uo_ds_base lds_promocao_vinculo
			
Try

	//Se n$$HEX1$$e300$$ENDHEX$$o for promo$$HEX2$$e700e300$$ENDHEX$$o vinculada sai da fun$$HEX2$$e700e300$$ENDHEX$$o.
	if is_tipo_promocao <> 'V' and is_tipo_promocao <> 'C' and ib_promocao_vinculada = False Then return True

	SELECT nr_controle, de_chave_sap
	Into :ll_Controle_filho, :ls_chave_sap_vinc
	FROM interface_sap  i 
	Where i.cd_tabela = 39
		and i.nr_controle_pai = :al_controle_pai
	Using SqlCa;	

	If SqlCa.sqlcode = -1 Then
		as_Log	= "Erro ao buscar o controle na tabela interface_sap. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle_pai)+". Erro: "+SqlCa.sqlErrText
		Return False
	End If	
	
	ls_chave_sap_vinc = gf_Tira_Zero_Esquerda(ls_chave_sap_vinc)
	
	if ls_chave_sap_vinc <> is_chave_sap Then
		as_log = 'O c$$HEX1$$f300$$ENDHEX$$digo chave SAP do controle de v$$HEX1$$ed00$$ENDHEX$$nculo [' + ls_chave_sap_vinc + '] $$HEX1$$e900$$ENDHEX$$ diferente do c$$HEX1$$f300$$ENDHEX$$digo chave SAP do controle de promo$$HEX2$$e700e300$$ENDHEX$$o [' + is_chave_sap + '].'
		return false
	end if
	
	lds_promocao_vinculo = Create dc_uo_ds_base
	lds_promocao_vinculo.of_ChangeDataObject("ds_ge473_promocao_sos_vinculo")
	
	uo_ge473_comum lo_Comum
	lo_Comum = Create uo_ge473_comum
			
	If lo_Comum.of_processa_carrega_dados_v2(ll_Controle_filho, ref as_Log) Then		
		For ll_Linha = 1 To lo_Comum.ids_lista_registros.RowCount()

			ls_cd_promocao_sap = gf_Tira_Zero_Esquerda(lo_Comum.ids_lista_registros.object.cd_promocao_sap[ll_linha])
			
			if ls_cd_promocao_sap <> is_chave_sap Then
				as_log = 'O c$$HEX1$$f300$$ENDHEX$$digo promo$$HEX2$$e700e300$$ENDHEX$$o SAP do controle de v$$HEX1$$ed00$$ENDHEX$$nculo [' + ls_cd_promocao_sap + '] $$HEX1$$e900$$ENDHEX$$ diferente do c$$HEX1$$f300$$ENDHEX$$digo chave SAP do controle de promo$$HEX2$$e700e300$$ENDHEX$$o [' + is_chave_sap + '].'
				return false
			end if

			If Not IsNumber(lo_Comum.ids_lista_registros.Object.nr_vinculo[ll_Linha]) Then
				as_Log = "O valor informado para o campo NR_VINCULO n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ v$$HEX1$$e100$$ENDHEX$$lido."
				Return False
			Else
				ll_vinculo = Long(lo_Comum.ids_lista_registros.Object.nr_vinculo[ll_Linha])
			End If
			
			ls_de_vinculo = lo_Comum.ids_lista_registros.Object.de_vinculo[ll_Linha]
			
			If Not IsNumber(lo_Comum.ids_lista_registros.Object.qt_vinculo[ll_Linha]) Then
				as_Log = "O valor informado para o campo QT_VINCULO n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ v$$HEX1$$e100$$ENDHEX$$lido."
				Return False				
			Else
				ll_quantidade = Long(gf_Replace(lo_Comum.ids_lista_registros.Object.qt_vinculo[ll_Linha], '.', ',', 0))
			End If
				
			Select cd_promocao_sos
			Into :ll_Achou
			from promocao_sos_vinculo
			where cd_promocao_sos = :il_codigo_promocao
				and nr_vinculo = :ll_vinculo
			Using SqlCa;

			Choose Case SqlCa.SqlCode
				Case 0
						
					Update promocao_sos_vinculo
						Set	de_vinculo = :ls_de_vinculo,
								qt_vinculo = :ll_quantidade
					Where cd_promocao_sos = :il_codigo_promocao
						and nr_vinculo = :ll_vinculo
					Using SqlCa;
					
					If SqlCa.sqlcode = -1 Then
						as_Log	= "Erro no update da tabela 'promocao_sos_vinculo'. Erro: "+SqlCa.sqlErrText
						Return False
					End If								
						
					
				Case 100
					
					Insert into promocao_sos_vinculo(	cd_promocao_sos, 
																nr_vinculo,
																de_vinculo,
																qt_vinculo)
					Values (	:il_codigo_promocao, 
								:ll_vinculo, 
								:ls_de_vinculo,
								:ll_quantidade )
					Using SqlCa;
												
					If SqlCa.sqlcode = -1 Then
						as_Log	= "Erro no insert da tabela 'promocao_sos_vinculo'. Erro: "+SqlCa.sqlErrText
						Return False
					End If					

				Case -1	
					as_Log	= "Erro ao localizar promocao_sos_vinculo. Erro: "+SqlCa.sqlErrText
					Return False					
			End Choose										
		Next		
		
		//Verifica exclusao
		If lo_Comum.ids_lista_registros.RowCount() > 0 Then
			lds_promocao_vinculo.Reset()
			lds_promocao_vinculo.Retrieve(il_codigo_promocao)
	
			For ll_linha = 1 To lds_promocao_vinculo.RowCount()				
	
				ll_vinculo = lds_promocao_vinculo.Object.nr_vinculo [ll_LInha]
				
				ll_find	= lo_Comum.ids_lista_registros.Find ("long(nr_vinculo) = " + String(ll_vinculo)  , 1 , lo_Comum.ids_lista_registros.RowCount())
												 
				If ll_find > 0 Then
					Continue
				Else
					If ll_find < 0 Then
						as_Log	= "Erro no find da promocao_vinculo sap."
						Return False
					End If	
					If ll_find = 0 Then						
						//Exclui vinculo PRD primeiro
						Delete from promocao_sos_vinculo_prd
						Where cd_promocao_sos = :il_codigo_promocao
							and nr_vinculo = :ll_vinculo
						Using SqlCa;
													
						If SqlCa.sqlcode = -1 Then
							as_Log	= "Erro delete da tabela 'promocao_sos_vinculo_prd'. Erro: "+SqlCa.sqlErrText
							Return False
						End If			
						//Exclui vinculo
						Delete from promocao_sos_vinculo
						Where cd_promocao_sos = :il_codigo_promocao
							and nr_vinculo = :ll_vinculo
						Using SqlCa;
													
						If SqlCa.sqlcode = -1 Then
							as_Log	= "Erro delete da tabela 'promocao_sos_vinculo'. Erro: "+SqlCa.sqlErrText
							Return False
						End If
					End If				
				End If	
					
			Next									
			
		End If
		
	Else
		Return False				
	End If			

	
Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_insere_promocao_sos_vinculo'. Erro: "+lo_rte.GetMessage( )
	Return False	
Finally
	If IsValid(lds_promocao_vinculo) Then Destroy(lds_promocao_vinculo)
	If IsValid(lo_Comum) Then Destroy(lo_Comum)
End Try	

Return True
end function

public subroutine of_processa_atualizacao ();Long ll_Linhas
Long ll_Linha
Long ll_Hora

dc_uo_ds_base lds 

ll_Hora = hour(Now())

// Controle para n$$HEX1$$e300$$ENDHEX$$o atualizar promo$$HEX2$$e700e300$$ENDHEX$$o entre as 00 horas at$$HEX1$$e900$$ENDHEX$$ 06:00, 
// pois no sistema CARGA existe alguns processos que consomem dados das tabelas de PROMOCAO
If ll_Hora >= 1 and  ll_Hora <= 4 Then Return

try 
	
	lds  = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject('ds_ge473_lista_controles_promo', False) Then 
		gvo_aplicacao.of_grava_log("Interface Produto - Erro alterar a DW [ds_ge473_lista_controles_promo] - uo_ge473_promocao_sap.of_processa_atualizacao" )
		Return
	End If
			
	ll_Linhas = lds.Retrieve(il_Tabela)
	
	If ll_Linhas > 0 Then
				
		If Not IsValid(w_Aguarde) Then Open(w_Aguarde)
		
		w_aguarde.uo_progress.of_setstart()
		
		w_aguarde.uo_progress.of_setmax(ll_Linhas)
				
		w_Aguarde.Title = "Integrando Promo$$HEX2$$e700e300$$ENDHEX$$o do SAP..."
						
		For ll_Linha = 1 To ll_Linhas
											
			uo_ge473_promocao_sap  lo_promocao_sap
			 
			Try
				lo_promocao_sap	= Create uo_ge473_promocao_sap
				lo_promocao_sap.of_atualiza_promocao( lds.Object.nr_controle[ll_Linha] , il_Tabela )
			Finally
				Destroy(lo_promocao_sap)
			End Try			
			
			w_aguarde.uo_progress.of_setprogress(ll_Linha)
		Next
		
		
	ElseIf ll_Linhas < 0 Then
		gvo_aplicacao.of_grava_log("Interface FornecedorConexao - Erro ao recuperar os da DW [ds_ge473_lista_controles] - uo_ge473_fornecedor_conexao.of_processa_atualizacao.")
	End If	
	
finally
	Destroy lds
	
	If IsValid(w_Aguarde) Then	Close(w_Aguarde)	
end try
end subroutine

public function boolean of_finaliza_promocao (long al_cd_promocao, ref string as_log);date ldt_termino

ldt_termino = date(gf_getserverdate())

ldt_termino = relativedate(ldt_termino, -1)

Update promocao_sos
set 	dh_termino 						= :ldt_termino,
		dh_termino_estoque_minimo	= :ldt_termino,
		dh_atualizacao					= GetDate()
where cd_promocao_sos = :al_cd_promocao
Using SQLCA;

if sqlca.sqlcode = -1 then
	as_log = 'Erro ao atualizar registro na tabela "promocao_sos": ' + Sqlca.sqlerrtext
	Return false
end if

return true
end function

public function boolean of_carrega_chave (long al_controle, ref string as_chave_sap, ref string as_log);
select de_chave_sap
into :as_chave_sap
from interface_sap
where nr_controle = :al_controle
Using SQLCA;

if sqlca.sqlcode = -1 then 
	as_log = 'Erro ao consultar a tabela "interface_sap": ' + sqlca.sqlerrtext
	return false
end if

as_chave_sap =  gf_Tira_Zero_Esquerda(as_chave_sap)

return True
end function

public function boolean of_insere_desconto_prog (datastore pds_dados, ref long pl_cd_desconto, ref string ps_log);long ll_cd_desconto, ll_cd_desconto_ant, ll_linha, ll_linhas
long ll_for, ll_qt_minima, ll_find, ll_contador
decimal ldc_desconto
boolean lb_invalido
datastore lds_desconto

lds_desconto = create datastore
lds_desconto.dataobject = 'ds_ge473_desconto_progressivo_qtd'
lds_desconto.settransobject(SQLCA)

ll_linhas = lds_desconto.retrieve( )

ll_cd_desconto_ant = 0

//Verifica se j$$HEX1$$e100$$ENDHEX$$ existe um desconto cadastratado com as mesmas quantidades:
	
ll_contador = 0	
lb_invalido = false
ll_for = 0

Do While True
	
	ll_for++
	
	if ll_for <= ll_linhas Then
		ll_cd_desconto = lds_desconto.object.cd_desconto[ll_for]
	end if
	
	if ll_cd_desconto = ll_cd_desconto_ant and ll_for <= ll_linhas Then
		
		if lb_invalido = True Then
			Continue
		end if
		
	else
		
		//Achou
		if ll_contador = pds_dados.rowcount() and lb_invalido = false Then
			if ll_for <= ll_linhas Then
				ll_cd_desconto = ll_cd_desconto_ant
			end if
			Exit	
		end if
		
		ll_cd_desconto_ant = ll_cd_desconto
		lb_invalido = false
		ll_contador = 0

		//Sai do Loop
		if ll_for > ll_linhas Then
			ll_cd_desconto = 0
			Exit
		end if

	end if	
		
	ll_qt_minima = lds_desconto.object.qt_minima[ll_for]
	ldc_desconto = lds_desconto.object.pc_desconto[ll_for]
		
	ll_find = pds_dados.find('qt_minima = ' + string(ll_qt_minima) + ' and String(pc_desconto) = "' + string(ldc_desconto) + '"', 1, pds_dados.rowcount() )	
		
	if ll_find > 0 Then
		ll_contador++
	else
		lb_invalido = True
	end if
	
Loop

//Se n$$HEX1$$e300$$ENDHEX$$o existir, cria um novo desconto com as quantidades recebidas:
if ll_cd_desconto = 0 or isnull(ll_cd_desconto) then
	
	select max(cd_desconto)
	into :ll_cd_desconto
	from desconto_progressivo;

	If sqlca.sqlcode = -1 then
		ps_log = 'Erro ao consultar a tabela "desconto_progressivo": ' + sqlca.sqlerrtext
		return false
	end if
	
	if isnull(ll_cd_desconto) or ll_cd_desconto = 0 then 
		ll_cd_desconto = 1
	else
		ll_cd_desconto++
	end if
	
	insert into desconto_progressivo(cd_desconto, de_desconto)
	values(:ll_cd_desconto, 'PROGRESSIVA');
	
	If sqlca.sqlcode = -1 then
		ps_log = 'Erro ao inserir registro na tabela "desconto_progressivo": ' + sqlca.sqlerrtext
		return false
	end if
	
	For ll_for = 1 to pds_dados.rowcount()
	
		ll_qt_minima = pds_dados.object.qt_minima[ll_for]
		ldc_desconto = pds_dados.object.pc_desconto[ll_for]
	
		insert into desconto_progressivo_qtd(cd_desconto, qt_minima, pc_desconto)
		values(:ll_cd_desconto, :ll_qt_minima, :ldc_desconto);
		
		If sqlca.sqlcode = -1 then
			ps_log = 'Erro ao inserir registro na tabela "desconto_progressivo_qtd": ' + sqlca.sqlerrtext
			return false
		end if
		
	Next
	
end if

//Retorna o c$$HEX1$$f300$$ENDHEX$$digo do desconto para vincular a promo$$HEX2$$e700e300$$ENDHEX$$o:
pl_cd_desconto = ll_cd_desconto

return true

end function

public function boolean of_data_parametro (ref string as_log);Select dh_movimentacao Into :idh_atual
From parametro 
Where id_parametro = '1'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		Return True
	Case 100
		as_log = "Data de movimenta$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o localizada nos par$$HEX1$$e200$$ENDHEX$$metros."
	Case -1
		as_log = "Localiza$$HEX2$$e700e300$$ENDHEX$$o da Data de Movimenta$$HEX2$$e700e300$$ENDHEX$$o do Par$$HEX1$$e200$$ENDHEX$$metro: "  +  + sqlca.sqlerrtext
End Choose

//idh_atual = gf_getserverdate()

Return False
end function

public function boolean of_insere_campanha (string ps_nr_campanha, string ps_nm_campanha, string ps_tipo, ref string ps_log);String ls_de_campanha, ls_id_avisa_cliente, ls_tp_campanha
long ll_existe, ll_nr_campanha
Try

	Select nr_campanha
	into :ll_nr_campanha
	from campanha
	where nr_campanha_sap = :ps_nr_campanha;
	
	If sqlca.sqlcode = -1 then
		ps_log = 'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_campanha ~nErro ao consultar a tabela "campanha": ~n' + sqlca.sqlerrtext
		return false
	end if
	
	Choose Case is_cd_tipo_campanha
		Case '118'
			ls_tp_campanha = 'AP'
		Case '119'
			ls_tp_campanha = 'CP'	
		Case '121'
			ls_tp_campanha = 'CD'
		Case '122'
			ls_tp_campanha = 'CE'	
		Case Else
			ps_log = 'Tipo da campanha n$$HEX1$$e300$$ENDHEX$$o informado.'
			return false
		
	End Choose
	
	if ls_tp_campanha = 'CP' or ls_tp_campanha = 'CD' or ls_tp_campanha = 'CE' Then
		ls_id_avisa_cliente = 'N'
	else
		ls_id_avisa_cliente = 'S'
	end if
	
	if ll_nr_campanha = 0 or isnull(ll_nr_campanha) Then
		
		Select max(nr_campanha)
		into :ll_nr_campanha
		from campanha;
		
		If sqlca.sqlcode = -1 then
			ps_log = 'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_campanha ~nErro ao consultar a tabela "campanha": ~n' + sqlca.sqlerrtext
			return false
		end if
		
		if ll_nr_campanha = 0 or isnull(ll_nr_campanha) Then
			ll_nr_campanha = 1
		else
			ll_nr_campanha++
		end if
			
		insert into campanha( nr_campanha, 
									nm_campanha, 
									dh_inicio, 
									dh_termino, 
									id_tipo_campanha,
									nr_campanha_sap,
									id_envia_loja,
									id_avisa_cliente,
									id_envia_bi)
			Values (:ll_nr_campanha,
						:ps_nm_campanha,
						:idh_inicio_promocao,
						:idh_termino_promocao,
						:ls_tp_campanha,
						:ps_nr_campanha,
						'S',
						:ls_id_avisa_cliente,
						'S');
						
		If sqlca.sqlcode = -1 then
			ps_log = 'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_campanha ~nErro ao inserir registro na tabela "campanha": ~n' + sqlca.sqlerrtext
			return false
		end if			

	else
		
		Update campanha
		set nm_campanha = :ps_nm_campanha, dh_inicio = :idh_inicio_promocao, dh_termino = :idh_termino_promocao, 
			id_envia_loja = 'S', id_avisa_cliente = :ls_id_avisa_cliente, id_envia_bi = 'S'
		where nr_campanha = :ll_nr_campanha;
		
		If sqlca.sqlcode = -1 then
			ps_log = 'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_insere_campanha ~nErro ao inserir atualizar na tabela "campanha": ~n' + sqlca.sqlerrtext
			return false
		end if	
		
	end if

	il_nr_campanha_legado = ll_nr_campanha

Catch ( runtimeerror  lo_rte )
	ps_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_insere_promocao_sos'. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try	



return true
end function

public function boolean of_proxima_promocao (ref long al_proximo, ref string as_log);String ls_Ultimo, ls_Proximo

Boolean lb_Sucesso = True

try
	If Not of_Abre_conexao(ref as_log) Then Return False

	Select vl_parametro Into :ls_Ultimo
	From parametro_geral
	Where cd_parametro = 'CD_PROMOCAO_SOS'
	Using iuo_SqlCa;
	
	Choose Case iuo_SqlCa.SqlCode
		Case 0
		Case 100
			as_log = "Par$$HEX1$$e200$$ENDHEX$$metro 'CD_PROMOCAO_SOS' n$$HEX1$$e300$$ENDHEX$$o localizado."
			Return False
		Case -1
			as_log = "Localiza$$HEX2$$e700e300$$ENDHEX$$o do Par$$HEX1$$e200$$ENDHEX$$metro  'CD_PROMOCAO_SOS': " + iuo_SqlCa.SqlerrText
			Return False		
	End Choose
	
	al_Proximo = Long(ls_Ultimo) + 1
	
	ls_Proximo = String(al_Proximo)
	
	Update parametro_geral
	Set vl_parametro = :ls_Proximo
	Where cd_parametro = 'CD_PROMOCAO_SOS'
	  and vl_parametro = :ls_Ultimo
	Using iuo_SqlCa;
	
	If iuo_SqlCa.SqlCode = -1 Then
		as_log = "Atualiza$$HEX2$$e700e300$$ENDHEX$$o do Par$$HEX1$$e200$$ENDHEX$$metro  'CD_PROMOCAO_SOS': " + iuo_SqlCa.SqlerrText
		Return False
	Else	
		If iuo_SqlCa.SqlnRows = 0 Then
			lb_Sucesso = of_proxima_promocao(ref al_Proximo, as_Log)
		End If
	End If
	
	If lb_Sucesso Then
		iuo_SqlCa.of_Commit();
	End If
	
finally
	of_fecha_conexao()
end try

Return lb_Sucesso
end function

public function boolean of_abre_conexao (ref string ps_log);if Not isvalid(iuo_SqlCa) Then
	iuo_SqlCa = create dc_uo_transacao
	iuo_SqlCa.ivs_database = "SYBASE"
end if

if Not iuo_SqlCa.of_isconnected() Then

	If Not iuo_SqlCa.of_Connect(gvo_Aplicacao.ivs_DataSource, 'GE473 - Interface Promo$$HEX2$$e700e300$$ENDHEX$$o SAP') Then
		ps_log =  'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_abre_conexao ~n' + "Erro ao conectar no Sybase."
		Return False
	End If
	
end if

return true
end function

public function boolean of_fecha_conexao ();if isvalid(iuo_SqlCa) Then
	iuo_SqlCa.of_disconnect( )
	destroy(iuo_SqlCa)
end if

return true
end function

public function boolean of_insere_promocao_sos_produto_crm (long pl_cd_promocao_sos, long pl_cd_produto, long pl_nr_nivel_desconto, decimal pdc_vl_preco_promocao, ref string ps_log);long ll_existe
string ls_nm_tipo_promocao

Try
	
	If is_tipo_promocao <> 'J' Then return true
	
	select count(cd_promocao_sos)
	into :ll_existe
	from promocao_sos_produto_crm
	where cd_promocao_sos = :pl_cd_promocao_sos
	and cd_produto = :pl_cd_produto
	and nr_nivel_desconto = :pl_nr_nivel_desconto;
	
	if sqlca.sqlcode = -1 then
		ps_log = 'Erro ao consultar a tabela promocao_sos_produto_crm: ' + sqlca.sqlerrtext
		return false
	End if
	
	if ll_existe = 0 or isnull(ll_existe) Then
		
		insert into promocao_sos_produto_crm(cd_promocao_sos,
															cd_produto,
															nr_nivel_desconto,
															vl_preco_promocao)
			Values(:pl_cd_promocao_sos,
					:pl_cd_produto,
					:pl_nr_nivel_desconto,
					:pdc_vl_preco_promocao
					);

			if sqlca.sqlcode = -1 then
				ps_log = 'Erro ao incluir registro na tabela promocao_sos_produto_crm: ' + sqlca.sqlerrtext
				return false
			End if 

	ELse
		
		update promocao_sos_produto_crm
		set nr_nivel_desconto = :pl_nr_nivel_desconto,
			vl_preco_promocao = :pdc_vl_preco_promocao
		where cd_promocao_sos = :pl_cd_promocao_sos
		and cd_produto = :pl_cd_produto
		and nr_nivel_desconto = :pl_nr_nivel_desconto;
	
		if sqlca.sqlcode = -1 then
			ps_log = 'Erro ao atualizar a tabela promocao_sos_produto_crm: ' + sqlca.sqlerrtext
			return false
		End if 
		
	ENd if
	
Finally
	if ps_log <> '' and not isnull(ps_log) Then ps_log = 'Funcao: of_insere_promocao_sos_produto_crm; ' + ps_log
End Try

return true
end function

public function boolean of_insere_promocao_filial (long al_promocao, boolean ab_promocao_nova, ref boolean ab_inativacao_loja, ref string as_log, long al_controle_pai);Long ll_linhas
Long ll_linha
Long ll_Filial
Long ll_achou
Long ll_controle_filho
Long ll_contador
Long ll_cd_filial_ecommerce
Long ll_find, ll_existe
Long ll_linhas_filial
String ls_filial_sap, ls_Msg_Email
String ls_chave_sap_filial, ls_cd_promocao_sap, ls_adm_sap, ls_lista_filiais
String ls_cd_loja_inativa

Boolean lb_Filial = True
Boolean lb_UF = True
Boolean lb_cidade = True
long ll_codigo	

Try

	ab_inativacao_loja = False

	if this.is_canal_distribuicao= 'EC' then
	
		select cd_filial_ecommerce
		into :ll_cd_filial_ecommerce
		from ecommerce_rede 
		where id_ecommerce = '2' 
		and id_rede_filial = :this.is_rede_promocao;
		
		if sqlca.sqlcode = -1 then
			as_log = 'Erro ao consultar registro na tabela "ECOMMERCE_REDE": ' + sqlca.sqlerrtext
			return false
		end if	
		
		lb_filial = True
		lb_cidade = false
		lb_uf = false
		
	Else

		ll_cd_filial_ecommerce = 0

		SELECT nr_controle, de_chave_sap
		Into :ll_Controle_filho, :ls_chave_sap_filial
		FROM interface_sap  i 
		Where i.cd_tabela = 38
			and i.nr_controle_pai = :al_controle_pai
		Using SqlCa;	
	
		If SqlCa.sqlcode = -1 Then
			as_Log	= "Erro ao buscar o controle na tabela interface_sap. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle_pai)+". Erro: "+SqlCa.sqlErrText
			Return False
		End If
	
		ls_chave_sap_filial = gf_Tira_Zero_Esquerda(ls_chave_sap_filial)
	
		If ll_Controle_filho = 0 Or IsNull(ll_Controle_filho) Then
			lb_Filial = False
		End If		
		
		If IsNull(is_UF) or Trim(is_UF) = "" Then
			lb_UF = False
		End If
		
		If IsNull(is_Domicilio) or Trim(is_Domicilio) = "" Then
			lb_cidade = False
		End If
		
		If lb_Filial = False And lb_UF = False and lb_cidade = False  Then 
			//Na interface n$$HEX1$$e300$$ENDHEX$$o trouxe altera$$HEX2$$e700f500$$ENDHEX$$es para promocao_sos_filial		
			
			if ab_promocao_nova = True Then
				as_log = 'N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ informa$$HEX2$$e700f500$$ENDHEX$$es de filial na tabela interface_sap.'
				Return False
			else
				Return True
			end if
			
		end if

	End if
	
	If lb_Filial Then //Promocao por Filial
	
		if ll_cd_filial_ecommerce = 0 or isnull(ll_cd_filial_ecommerce) Then
			If lb_UF or lb_Cidade Then
				as_Log	= "Foi retornado mais de um tipo de integra$$HEX2$$e700e300$$ENDHEX$$o para Promocao_sos_filial(Filial x UF x Domicilio)."
				Return False			
			End If
			
			if ls_chave_sap_filial <> is_chave_sap Then
				as_log = 'O c$$HEX1$$f300$$ENDHEX$$digo chave SAP do controle de filial [' + ls_chave_sap_filial + '] $$HEX1$$e900$$ENDHEX$$ diferente do c$$HEX1$$f300$$ENDHEX$$digo chave SAP do controle de promo$$HEX2$$e700e300$$ENDHEX$$o [' + is_chave_sap + '].'
				return false
			end if
			
			uo_ge473_comum lo_Comum
			lo_Comum = Create uo_ge473_comum
					
			If Not lo_Comum.of_processa_carrega_dados_v2(ll_Controle_filho, ref as_Log) Then	return false
				
			ll_linhas_filial = lo_Comum.ids_lista_registros.RowCount()	
				
		Else	
			ll_linhas_filial = 1
		End if		
				
		For ll_Linha = 1 To ll_linhas_filial
			
			if ll_cd_filial_ecommerce > 0 Then
			
				ll_filial = ll_cd_filial_ecommerce
				
			Else	
			
				ls_cd_promocao_sap =  gf_Tira_Zero_Esquerda(lo_Comum.ids_lista_registros.object.cd_promocao_sap[ll_linha])
				
				if ls_cd_promocao_sap <> is_chave_sap Then
					as_log = 'O c$$HEX1$$f300$$ENDHEX$$digo da promo$$HEX2$$e700e300$$ENDHEX$$o do controle de filial [' + ls_cd_promocao_sap + '] $$HEX1$$e900$$ENDHEX$$ diferente do c$$HEX1$$f300$$ENDHEX$$digo chave SAP do controle de promo$$HEX2$$e700e300$$ENDHEX$$o [' + is_chave_sap + '].'
					return false
				end if
				
				If Not io_Comum.of_Localiza_Codigo_Filial_Legado(lo_Comum.ids_lista_registros.Object.cd_filial_sap[ll_Linha], Ref  ll_Filial, Ref as_Log) Then Return False
				
				If Not gf_filial_administrada_sap(ll_filial, ref ls_adm_sap) Then return false
				
				////???????????
				ls_cd_loja_inativa = lo_Comum.ids_lista_registros.object.cd_loja_inativa[ll_linha]
				////???????????
				
				
				if ls_adm_sap = 'N' Then
					if ls_lista_filiais = '' or isnull(ls_lista_filiais) Then
						ls_lista_filiais = string(ll_filial)
					else
						ls_lista_filiais += '; ' + string(ll_filial)
					end if
					Continue
				End if
				
			End if
			
			Select cd_promocao_sos
			Into :ll_Achou
			from promocao_sos_filial
			where cd_promocao_sos = :il_codigo_promocao
				and cd_filial = :ll_Filial
			Using SqlCa;
			
			Choose Case SqlCa.SqlCode
				Case 0 //J$$HEX1$$e100$$ENDHEX$$ existe 				
					
					//Verifica se deve excluir o vinculo com a filial:
					if ls_cd_loja_inativa = 'S' or ls_cd_loja_inativa = 'X' Then
						
						ab_inativacao_loja = True
						
						delete from promocao_sos_filial 
						where cd_promocao_sos = :il_codigo_promocao
						and cd_filial = :ll_Filial;
						
						If SqlCa.sqlcode = -1 Then
							as_Log	= "Erro ao excluir registro na tabela 'promocao_sos_filial' por filial. Erro: "+SqlCa.sqlErrText
							Return False
						End If
						
					Else
						Continue	
					ENd if
					
				Case 100
					
					//Verifica se a filial esta inativa, se estiver nao inserir:
					if ls_cd_loja_inativa = 'S' or ls_cd_loja_inativa = 'X' Then 
						ab_inativacao_loja = True
						Continue
					End if
					
					Insert into promocao_sos_filial(  cd_promocao_sos, 
														  cd_filial,
														  nr_matricula_alteracao,
														  dh_atualizacao)
					Values (	:il_codigo_promocao, 
								:ll_Filial,
								:is_matricula_sap,
								GetDate())
					Using SqlCa;
												
					If SqlCa.sqlcode = -1 Then
						as_Log	= "Erro no insert da tabela 'promocao_sos_filial' por filial. Erro: "+SqlCa.sqlErrText
						Return False
					End If
					
	
					Select cd_promocao_sos
					into :ll_codigo
					from promocao_sos_filial
					where cd_promocao_sos = :il_codigo_promocao
					and cd_filial = :ll_Filial;
					
					If SqlCa.sqlcode = -1 Then
						as_Log	= "Erro no insert da tabela 'promocao_sos'. Erro: "+SqlCa.sqlErrText
						Return False
					End If
					
					
					if  il_nr_campanha_legado > 0 Then
					
						Select count(*)
						into :ll_existe
						from campanha_filial
						Where cd_filial = :ll_filial
						and nr_campanha = :il_nr_campanha_legado;
						
						If SqlCa.sqlcode = -1 Then
							as_Log	= "Erro ao consultar a tabela 'campanha_filial': "+SqlCa.sqlErrText
							Return False
						End If
					
						if ll_existe = 0 or isnull(ll_existe) Then
							
							Insert into campanha_filial(cd_filial,
															  nr_campanha)
								Values (	:ll_Filial,
											:il_nr_campanha_legado)
								Using SqlCa;
								
								If SqlCa.sqlcode = -1 Then
									as_Log	= "Erro no insert da tabela 'campanha_filial' por filial. Erro: "+SqlCa.sqlErrText
									Return False
								End If
							
								ll_codigo = 0
								
								Select cd_filial
								into :ll_codigo
								from campanha_filial
								where nr_campanha = :il_nr_campanha_legado
								and cd_filial = :ll_Filial;
								
								If SqlCa.sqlcode = -1 Then
									as_Log	= "Erro no insert da tabela 'promocao_sos'. Erro: "+SqlCa.sqlErrText
									Return False
								End If
							
						end if
						
					end if		
					
				Case -1
					as_Log	= "Erro ao localizar filial na promocao sos. Erro: "+SqlCa.sqlErrText
					Return False
			End Choose							
			
		Next
			
		if ls_lista_filiais <> '' and not isnull(ls_lista_filiais) Then
			
			ls_Msg_Email = 'Houveram problemas na interface de descida do SAP . <br>'+ &
				 'Interface:<b>' + 'PROMOCAO' + '</b><br>'+ &
				 'Controle:' + String(il_Controle) + ' <br>'+ &
				 '</ul></ul>'+&
				 'As seguintes filiais n$$HEX1$$e300$$ENDHEX$$o s$$HEX1$$e300$$ENDHEX$$o administradas pelo SAP: ~n ' + ls_lista_filiais

			gf_ge202_envia_email_automatico(183 , '', ls_Msg_Email, {''})
			
		end if

	End if	
	
	If lb_cidade Then

		if ab_promocao_nova = True Then
			
			select count(*)
				into :ll_achou
				from filial f
					inner join cidade c on (c.cd_cidade = f.cd_cidade)
					Inner join parametro_loja pl on (pl.cd_filial = f.cd_filial and cd_parametro = 'ID_ADM_FILIAL_SAP' and vl_parametro = 'S')
				where c.cd_cidade_ibge = :is_Domicilio
					and f.id_situacao = 'A'
					and f.id_rede_filial = :is_rede_promocao
			Using SqlCa;
		
			If SqlCa.sqlcode = -1 Then
				as_Log	= "Erro ao consultar tabela 'cidade': "+SqlCa.sqlErrText
				Return False
			End If	
			
			If ll_achou = 0 or isnull(ll_achou) Then
				as_log = 'N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ filiais relacionados ao c$$HEX1$$f300$$ENDHEX$$digo IBGE [' + is_domicilio + '] da rede [' + is_rede_promocao + '].'
				return false
			end if
			
		end if
		
		//Insere antes na campanha_filial. - CAMPANHA
		if  il_nr_campanha_legado > 0 Then
							
			Insert into campanha_filial(cd_filial,
											  nr_campanha)
				select f.cd_filial, :il_nr_campanha_legado
					from filial f
						inner join cidade c on (c.cd_cidade = f.cd_cidade)
						Inner join parametro_loja pl on (pl.cd_filial = f.cd_filial and cd_parametro = 'ID_ADM_FILIAL_SAP' and vl_parametro = 'S')
					where c.cd_cidade_ibge = :is_Domicilio
						and f.id_situacao = 'A'
						and f.id_rede_filial = :is_rede_promocao
					 	and not exists (select 1
						 					from promocao_sos_filial p
										  where p.cd_promocao_sos = :il_codigo_promocao
											 and p.cd_filial  = f.cd_filial)
						and not exists (select 1
						 					from campanha_filial x
										  where x.nr_campanha = :il_nr_campanha_legado
											 and x.cd_filial  = f.cd_filial)
			Using SqlCa;
				
				If SqlCa.sqlcode = -1 Then
					as_Log	= "Erro no insert da tabela 'campanha_filial' por cidade. Erro: "+SqlCa.sqlErrText
					Return False
				End If
			
		end if

		INSERT INTO promocao_sos_filial  
			( cd_promocao_sos,   
			  cd_filial,   
			  nr_matricula_alteracao, 
			  dh_atualizacao) 
		 select :il_codigo_promocao, f.cd_filial, :is_matricula_sap, GetDate()
					from filial f
						inner join cidade c on (c.cd_cidade = f.cd_cidade)
						Inner join parametro_loja pl on (pl.cd_filial = f.cd_filial and cd_parametro = 'ID_ADM_FILIAL_SAP' and vl_parametro = 'S')
					where c.cd_cidade_ibge = :is_Domicilio
						and f.id_situacao = 'A'
						and f.id_rede_filial = :is_rede_promocao
					 	and not exists (select 1
						 					from promocao_sos_filial p
										  where p.cd_promocao_sos = :il_codigo_promocao
											 and p.cd_filial  = f.cd_filial)
		Using SqlCa;
		
		If SqlCa.sqlcode = -1 Then
			as_Log	= "Erro no insert da tabela 'promocao_sos_filial' por cidade. Erro: "+SqlCa.sqlErrText
			Return False
		End If
		
		
	End If
			
	If lb_UF Then //Insere por UF
	
		if ab_promocao_nova = True Then
	
			Select Count(*)
			into :ll_achou
					from filial f
					inner join cidade c on (c.cd_cidade = f.cd_cidade)
					Inner join parametro_loja pl on (pl.cd_filial = f.cd_filial and cd_parametro = 'ID_ADM_FILIAL_SAP' and vl_parametro = 'S')
			where c.cd_unidade_federacao = :is_UF
					and f.id_situacao = 'A'
					and f.id_rede_filial = :is_rede_promocao
					using SQLCA;

			If SqlCa.sqlcode = -1 Then
				as_Log	= "Erro ao consultar tabela 'cidade': "+SqlCa.sqlErrText
				Return False
			End If	
			
			If ll_achou = 0 or isnull(ll_achou) Then
				as_log = 'N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ filiais relacionados a UF [' + is_uf + '] da rede [' + is_rede_promocao + '].'
				return false
			end if
			
		end if
		
		//Insere antes na campanha filial. - CAMPANHA
		if il_nr_campanha_legado > 0 Then
							
			Insert into campanha_filial(cd_filial,
											  nr_campanha)
				select f.cd_filial, :il_nr_campanha_legado
				from filial f
						inner join cidade c on (c.cd_cidade = f.cd_cidade)
						Inner join parametro_loja pl on (pl.cd_filial = f.cd_filial and cd_parametro = 'ID_ADM_FILIAL_SAP' and vl_parametro = 'S')
				where c.cd_unidade_federacao = :is_UF
						and f.id_situacao = 'A'
						and f.id_rede_filial = :is_rede_promocao
						and not exists (select 1
												from promocao_sos_filial p
											  where p.cd_promocao_sos = :il_codigo_promocao
												and p.cd_filial  = f.cd_filial)
						and not exists (select 1
						 					from campanha_filial x
										  where x.nr_campanha = :il_nr_campanha_legado
											 and x.cd_filial  = f.cd_filial)
				Using SqlCa;
				
				If SqlCa.sqlcode = -1 Then
					as_Log	= "Erro no insert da tabela 'campanha_filial' por cidade. Erro: "+SqlCa.sqlErrText
					Return False
				End If
			
		end if	
		
		
	  INSERT INTO promocao_sos_filial  
			( cd_promocao_sos,   
			  cd_filial,   
			  nr_matricula_alteracao,
			  dh_atualizacao) 
		 select :il_codigo_promocao, f.cd_filial, :is_matricula_sap, GetDate()
			from filial f
					inner join cidade c on (c.cd_cidade = f.cd_cidade)
					Inner join parametro_loja pl on (pl.cd_filial = f.cd_filial and cd_parametro = 'ID_ADM_FILIAL_SAP' and vl_parametro = 'S')
			where c.cd_unidade_federacao = :is_UF
					and f.id_situacao = 'A'
					and f.id_rede_filial = :is_rede_promocao
					and not exists (select 1
											from promocao_sos_filial p
										  where p.cd_promocao_sos = :il_codigo_promocao
											and p.cd_filial  = f.cd_filial)
			Using SqlCa;
			
			If SqlCa.sqlcode = -1 Then
				as_Log	= "Erro no insert da tabela 'promocao_sos_filial' por UF. Erro: "+SqlCa.sqlErrText
				Return False
			End If
			
			
	End If

	
Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_insere_promocao_filial'. Erro: "+lo_rte.GetMessage( )
	Return False	
Finally
	If IsValid(lo_Comum) Then Destroy(lo_Comum)
End Try	

Return True
end function

public function boolean of_insere_promocao_recuperacao_verba (long pl_cd_promocao_sos, long pl_cd_produto, string ps_nm_tipo_recuperacao, decimal pdc_vl_recuperacao, decimal pdc_vl_verba_maximo, string ps_cd_fornecedor_verba, long pl_qt_minima, ref string ps_log);long ll_existe
long ll_nr_sequencial
string ls_nm_tipo_promocao

Try
	
	Choose Case is_tipo_promocao
		Case 'N'
			ls_nm_tipo_promocao = 'NORMAL'
		Case 'V'
			ls_nm_tipo_promocao = 'VINCULADA'
		Case 'J'
			ls_nm_tipo_promocao = 'JORNADA - PROGRES'
		Case 'Q'		
			ls_nm_tipo_promocao = 'PROGRESSIVA'
	End Choose
	
	select nr_sequencial
	into :ll_nr_sequencial
	from promocao_recuperacao_verba
	where cd_promocao_sos = :pl_cd_promocao_sos
	and cd_produto = :pl_cd_produto
	and qt_minima = :pl_qt_minima;
	
	if sqlca.sqlcode = -1 then
		ps_log = 'Erro ao consultar a tabela promocao_recuperacao_verba: ' + sqlca.sqlerrtext
		return false
	End if
	
	if (ll_nr_sequencial = 0 or isnull(ll_nr_sequencial)) and pdc_vl_recuperacao > 0 Then
		
		select max(nr_sequencial)
		into :ll_nr_sequencial
		from promocao_recuperacao_verba
		where cd_promocao_sos = :pl_cd_promocao_sos
		and cd_produto = :pl_cd_produto;
	
		if sqlca.sqlcode = -1 then
			ps_log = 'Erro ao consultar a tabela promocao_recuperacao_verba: ' + sqlca.sqlerrtext
			return false
		End if
	
		if isnull(ll_nr_sequencial) then ll_nr_sequencial = 0
	
		ll_nr_sequencial++
	
		insert into promocao_recuperacao_verba(cd_promocao_sos,
															cd_produto,
															nr_sequencial,
															nm_tipo_promocao,
															nm_tipo_recuperacao,
															vl_recuperacao,
															dh_inclusao,
															nr_matricula_inclusao,
															vl_verba_maximo,
															cd_fornecedor_verba,
															qt_minima)
			Values(:pl_cd_promocao_sos,
					:pl_cd_produto,
					:ll_nr_sequencial,
					:ls_nm_tipo_promocao,
					:ps_nm_tipo_recuperacao,
					:pdc_vl_recuperacao,
					getdate(),
					:is_matricula_sap,
					:pdc_vl_verba_maximo,
					:ps_cd_fornecedor_verba,
					:pl_qt_minima);

			if sqlca.sqlcode = -1 then
				ps_log = 'Erro ao incluir registro na tabela promocao_recuperacao_verba: ' + sqlca.sqlerrtext
				return false
			End if 

	ELseif pdc_vl_recuperacao > 0 Then
		
		update promocao_recuperacao_verba
		set nm_tipo_recuperacao = :ps_nm_tipo_recuperacao,
			vl_recuperacao = :pdc_vl_recuperacao,
			vl_verba_maximo = :pdc_vl_verba_maximo,
			dh_alteracao = getdate(),
			nr_matricula_alteracao = :is_matricula_sap,
			cd_fornecedor_verba = :ps_cd_fornecedor_verba
		where cd_promocao_sos = :pl_cd_promocao_sos
		and cd_produto = :pl_cd_produto
		and nr_sequencial = :ll_nr_sequencial;
	
		if sqlca.sqlcode = -1 then
			ps_log = 'Erro ao atualizar a tabela promocao_recuperacao_verba: ' + sqlca.sqlerrtext
			return false
		End if 
		
	Elseif ll_nr_sequencial > 0 and pdc_vl_recuperacao = 0 and (is_cd_promocao_profimetrics <> '' and not isnull(is_cd_promocao_profimetrics)) then //Somente se for promocao profimetrics
		
		delete from promocao_recuperacao_verba
		where cd_promocao_sos = :pl_cd_promocao_sos
		and cd_produto = :pl_cd_produto
		and nr_sequencial = :ll_nr_sequencial;
	
		if sqlca.sqlcode = -1 then
			ps_log = 'Erro ao excluir registro da tabela promocao_recuperacao_verba: ' + sqlca.sqlerrtext
			return false
		End if 
		
	ENd if
	
Finally
	if ps_log <> '' and not isnull(ps_log) Then ps_log = 'Funcao: of_insere_promocao_resuperacao_verba; ' + ps_log
End Try

return true
end function

on uo_ge473_promocao_sap.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge473_promocao_sap.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;io_Comum	= Create uo_ge473_comum

end event

event destructor;Destroy(io_Comum)
end event

