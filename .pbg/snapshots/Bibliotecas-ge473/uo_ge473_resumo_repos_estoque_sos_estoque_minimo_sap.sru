HA$PBExportHeader$uo_ge473_resumo_repos_estoque_sos_estoque_minimo_sap.sru
forward
global type uo_ge473_resumo_repos_estoque_sos_estoque_minimo_sap from nonvisualobject
end type
end forward

global type uo_ge473_resumo_repos_estoque_sos_estoque_minimo_sap from nonvisualobject
end type
global uo_ge473_resumo_repos_estoque_sos_estoque_minimo_sap uo_ge473_resumo_repos_estoque_sos_estoque_minimo_sap

type variables
uo_ge473_comum io_Comum


String	is_cd_filial_sap,&
		is_cd_motivo_alteracao,&
		is_cd_produto_sap,&
		is_cd_promocao_planograma,&
		is_cd_promocao_sap,&
		is_dh_alteracao,&
		is_dh_item_final_vigencia,&
		is_dh_item_inicio_vigencia,&
		is_id_alteracao,&
		is_id_tipo,&
		is_nr_matricula,&
		is_de_motivo_alteracao

Long	il_qt_estoque,&
		il_qt_min_base_planograma,&
		il_cd_promocao
		
Long il_Tabela = 33

DateTime	idh_dh_alteracao,&
				idh_dh_item_final_vigencia,&
				idh_dh_item_inicio_vigencia
end variables

forward prototypes
public function boolean of_inicializa_variaveis (ref string as_log)
public function boolean of_insere_dados (long al_filial, long al_produto, ref string as_log)
public function boolean of_insere_resumo_reposicao_estoque (long al_filial, long al_produto, ref string as_log)
public function boolean of_valida_dados (ref string as_log)
public function boolean of_atualiza_resumo_repos_est_sos_est_min (long al_controle, long al_tabela)
public subroutine of_processa_atualizacao ()
public function boolean wf_filial_administrada_sap (long al_filial, ref string as_erro)
public function boolean of_insere_promocao_sos_estoque_minimo (long al_filial, long al_produto, ref string as_log)
public function boolean of_valida_motivo (long pl_cd_motivo, string ps_descricao, ref string ps_log)
public function boolean of_valida_usuario (ref string as_nr_matricula, ref string as_log)
end prototypes

public function boolean of_inicializa_variaveis (ref string as_log);Try
	
	SetNull(is_cd_filial_sap)
	SetNull(is_cd_motivo_alteracao)
	SetNull(is_cd_produto_sap)
	SetNull(is_cd_promocao_planograma)
	SetNull(is_cd_promocao_sap)
	SetNull(is_dh_alteracao)
	SetNull(is_dh_item_final_vigencia)
	SetNull(is_dh_item_inicio_vigencia)
	SetNull(is_id_alteracao)
	SetNull(is_id_tipo)
	SetNull(is_nr_matricula)
	SetNull(idh_dh_alteracao)
	SetNull(idh_dh_item_final_vigencia)
	SetNull(idh_dh_item_inicio_vigencia)
	SetNull(il_qt_estoque)
	SetNull(il_cd_promocao)

Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro ao ao iniciar as vari$$HEX1$$e100$$ENDHEX$$veis. Erro: "+lo_rte.GetMessage()
	Return False
End Try

Return True
end function

public function boolean of_insere_dados (long al_filial, long al_produto, ref string as_log);Try
	If is_id_tipo = "ESB" Then //RESUMO_REPOSICAO_ESTOQUE
		If Not of_insere_resumo_reposicao_estoque(al_Filial, al_Produto, Ref as_Log) Then 
			Return False
		End If		
	
	ElseIf is_id_tipo = "PRO" or is_id_tipo = "PLA" Then	//PROMOCAO_SOS_ESTOQUE_MINIMO/PLANOGRAMA
		  If Not of_Insere_Promocao_Sos_Estoque_Minimo(al_Filial, al_Produto, Ref as_Log) Then 
				Return False
			End If		
	Else
		as_Log = "Tipo de registro '"+is_id_tipo+"' n$$HEX1$$e300$$ENDHEX$$o esperado."
		Return False	
	End If
Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_grava_historico'. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try		
	
Return True


end function

public function boolean of_insere_resumo_reposicao_estoque (long al_filial, long al_produto, ref string as_log);Long ll_Qtd
Long ll_Motivo_Alteracao

String ls_Motivo

Try
	
	If Not IsNull(is_cd_motivo_alteracao) and is_cd_motivo_alteracao <> '' Then
		If IsNumber(is_cd_motivo_alteracao) Then
			ll_Motivo_Alteracao = Long(is_cd_motivo_alteracao) 
			
			If Not IsNull(is_de_motivo_alteracao) and is_de_motivo_alteracao <> '' Then
				ls_Motivo = String(ll_Motivo_Alteracao, '000') + ' - ' + is_de_motivo_alteracao
			End If
			
		Else
			as_Log	= "C$$HEX1$$f300$$ENDHEX$$digo do motivo da altera$$HEX2$$e700e300$$ENDHEX$$o do estoque base inv$$HEX1$$e100$$ENDHEX$$lido. C$$HEX1$$f300$$ENDHEX$$digo do produto SAP ["+is_cd_produto_sap+"], c$$HEX1$$f300$$ENDHEX$$digo legado ["+String(al_Produto)+"]."
			Return False
		End If
	End If	
	
	Select count(*) 
	Into  :ll_Qtd
	From   resumo_reposicao_estoque
	where cd_filial		= :al_Filial
	And	cd_produto	= :al_Produto
	Using SqlCA;
			
	Choose Case SqlCa.SqlCode
		Case 0
			If ll_Qtd=1 Then 

				Update resumo_reposicao_estoque 
					set		dh_alteracao				= getDate(),
							id_alteracao					= :is_id_alteracao,
							nr_matricula_alteracao	= :is_nr_matricula,
							de_motivo_alteracao		= :ls_Motivo,
							qt_estoque_base			= :il_qt_estoque,
							dh_termino_bloqueio		= :idh_dh_item_final_vigencia,
							cd_motivo_alteracao_sap= :ll_Motivo_Alteracao,
							id_importacao_sap = 'S'
				Where	cd_filial		= :al_Filial
					And	cd_produto	= :al_Produto
				Using SqlCa;
				
				If SqlCa.SqlCode = -1 Then
					as_Log	= "Erro ao atualizar os dados da tabela 'RESUMO_REPOSICAO_ESTOQUE'. C$$HEX1$$f300$$ENDHEX$$digo do produto SAP ["+is_cd_produto_sap+"], c$$HEX1$$f300$$ENDHEX$$digo legado ["+String(al_Produto)+"]. Erro: "+ SqlCa.SqlErrText
					Return False
				End If
				
			ElseIf ll_Qtd=0 Then 
					Insert Into resumo_reposicao_estoque (cd_filial,   
														  cd_produto,   
														  id_tipo_reposicao,   
														  qt_venda_periodo_1,   
														  qt_venda_periodo_2,   
														  qt_venda_periodo_3,   
														  qt_venda_periodo_4,   
														  qt_venda_periodo_5,   
														  qt_venda_periodo_6,   
														  cd_classe_reposicao,   
														  qt_demanda_diaria,   
														  qt_dias_cobertura,
														  qt_estoque_base_inicial,   
														  qt_estoque_base_anterior,   
														  qt_estoque_calculado,   
														  qt_estoque_minimo,   
														  qt_estoque_base,
														  id_nivel_estoque_minimo,   
														  id_geracao_pedido,
														  id_alteracao,
														  qt_estoque_base_definido,
														  qt_dias_venda,
														  nr_matricula_alteracao,
														  de_motivo_alteracao,
														  dh_termino_bloqueio,
														  dh_alteracao, 
														  id_importacao_sap,
														  cd_motivo_alteracao_sap)  
				Values (:al_Filial,   
						  :al_Produto,   
						  :is_id_tipo,   
						  0, 0, 0, 0, 0, 0,   
						  'E',
						  0,
						  0,   
						  0,   
						  0,   
						  0,   
						  0,
						  :il_qt_estoque, 
						  '0',   
						  'S', 
						 :is_id_alteracao,
						  0,
						  0,
						  :is_nr_matricula,
						  :ls_Motivo,
						  :idh_dh_item_final_vigencia,
						  GetDate(),
						  'S',
						  :ll_Motivo_Alteracao)
				Using SqlCa;
			
				If SqlCa.SqlCode = -1 Then
					as_Log	= "Erro no insert da tabela 'RESUMO_REPOSICAO_ESTOQUE'. C$$HEX1$$f300$$ENDHEX$$digo do produto SAP ["+is_cd_produto_sap+"], c$$HEX1$$f300$$ENDHEX$$digo legado ["+String(al_Produto)+"]. Erro: "+ SqlCa.SqlErrText
					Return False
				End If
			End If 
		Case -1
			as_Log	= "Erro ao localizar o c$$HEX1$$f300$$ENDHEX$$digo da promo$$HEX2$$e700e300$$ENDHEX$$o SOS. Erro: "+ SqlCa.SqlErrText
			Return False
	End Choose
	
	
Catch ( runtimeerror  lo_rte )
	as_Log = "Erro ao atualizar os dados da tabela 'RESUMO_REPOSICAO_ESTOQUE'. Erro: "+lo_rte.GetMessage()
	Return False
End Try	

Return True
end function

public function boolean of_valida_dados (ref string as_log);Long	ll_Qtde
Try
		
	If IsNull(il_qt_estoque) or (il_qt_estoque < 0) Then
		as_Log	= "O Quantidade de Estoque deve ser maio do que zero e n$$HEX1$$e300$$ENDHEX$$o pode ser nula."
		Return False
	End If
	
	Select Count(*)
	Into :ll_Qtde
	From usuario
	Where nr_matricula = :is_nr_matricula
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		as_Log	= "Erro ao verificar se a matr$$HEX1$$ed00$$ENDHEX$$cula existe no Sybase: "+SqlCa.SqlErrText
		Return False
	End If
	
	If ll_Qtde = 0 Then
		as_Log	= "N$$HEX1$$e300$$ENDHEX$$o foi localizado a matr$$HEX1$$ed00$$ENDHEX$$cula '"+is_nr_matricula+"' no Sybase."
		Return False
	End If
	
Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_valida_dados'. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try

Return True
end function

public function boolean of_atualiza_resumo_repos_est_sos_est_min (long al_controle, long al_tabela);Boolean lb_Sucesso, lb_registro_pendente = True

Long	ll_Atualizacao_Pend,&
		ll_Linhas,&
		ll_Linha,&
		ll_Produto,&
		ll_Filial

String ls_Log

Try
	
	uo_ge473_comum lo_Comum
	lo_Comum = Create uo_ge473_comum
	
	If Not This.of_inicializa_variaveis(Ref ls_Log) Then Return False
	
	If lo_Comum.of_verifica_registro_pendente(al_controle, REF lb_registro_pendente, REF ls_log) Then
		If Not lb_registro_pendente Then
			Return False
		End If
	Else
		Return False
	End If
	
	If Not lo_Comum.of_atualizacao_pendente(al_Controle, Ref ll_Atualizacao_Pend, Ref ls_Log) Then Return False
	
	If Not lo_Comum.of_Muda_Situacao_Interface(al_Controle, Ref ls_Log) Then Return False

	//Controle j$$HEX1$$e100$$ENDHEX$$ foi processado
	If ll_Atualizacao_Pend = 0 Then Return True
	
	If lo_Comum.of_processa_carrega_dados(al_controle, ref ls_Log) Then
		
		ll_Linhas = lo_Comum.ids_lista_registros.RowCount()
		
		If ll_Linhas > 0 Then
		
			if isvalid(w_aguarde_3) Then
				w_aguarde_3.uo_progress_2.of_reset()
				w_aguarde_3.uo_progress_2.of_setmax(ll_linhas)
			end if
			
			For ll_Linha = 1 To ll_Linhas
				
				lb_Sucesso	= False
				
				If Not This.of_inicializa_variaveis(Ref ls_Log) Then Return False
			
				is_cd_filial_sap						= gf_Tira_Zero_Esquerda(lo_Comum.ids_lista_registros.Object.cd_filial_sap[ll_Linha])
				is_cd_motivo_alteracao			= gf_Tira_Zero_Esquerda(lo_Comum.ids_lista_registros.Object.cd_motivo_alteracao[ll_Linha])
				is_cd_produto_sap					= gf_Tira_Zero_Esquerda(lo_Comum.ids_lista_registros.Object.cd_produto_sap[ll_Linha])
				is_cd_promocao_planograma	= gf_Tira_Zero_Esquerda(lo_Comum.ids_lista_registros.Object.cd_promocao_planograma[ll_Linha])
				is_cd_promocao_sap				= gf_Tira_Zero_Esquerda(lo_Comum.ids_lista_registros.Object.cd_promocao_sap[ll_Linha])
				is_dh_alteracao						= lo_Comum.ids_lista_registros.Object.dh_alteracao						[ll_Linha]
				is_dh_item_final_vigencia		= lo_Comum.ids_lista_registros.Object.dh_item_final_vigencia		[ll_Linha]
				is_dh_item_inicio_vigencia		= lo_Comum.ids_lista_registros.Object.dh_item_inicio_vigencia		[ll_Linha]
				is_id_alteracao						= lo_Comum.ids_lista_registros.Object.id_alteracao						[ll_Linha]
				is_id_tipo								= lo_Comum.ids_lista_registros.Object.id_tipo								[ll_Linha]
				is_nr_matricula						= lo_Comum.ids_lista_registros.Object.nr_matricula						[ll_Linha]
				il_qt_estoque						= Long(lo_Comum.ids_lista_registros.Object.qt_estoque				[ll_Linha])
				il_qt_min_base_planograma    = Long(lo_Comum.ids_lista_registros.Object.qt_min_base_planograma	[ll_Linha])
				is_de_motivo_alteracao = lo_Comum.ids_lista_registros.Object.de_motivo_alteracao[ll_Linha]			
					
				// Fazer uma fun$$HEX2$$e700e300$$ENDHEX$$o. Caso n$$HEX1$$e300$$ENDHEX$$o encontre colocar o user do SAP.
				if Not this.of_valida_usuario( ref is_nr_matricula, ref ls_log) Then return False
				
				If Not io_Comum.of_Date_Time(is_dh_alteracao, 'DATA DE ALTERA$$HEX2$$c700c300$$ENDHEX$$O', ref idh_dh_alteracao, ref ls_Log) Then Return False
				If Not io_Comum.of_Date_Time(is_dh_item_final_vigencia, 'DATA FINAL DA VIG$$HEX1$$ca00$$ENDHEX$$NCIA DO ITEM', ref idh_dh_item_final_vigencia, ref ls_Log) Then Return False
				If Not io_Comum.of_Date_Time(is_dh_item_inicio_vigencia, 'DATA INCIAL DA VIG$$HEX1$$ca00$$ENDHEX$$NCIA DO ITEM', ref idh_dh_item_inicio_vigencia, ref ls_Log) Then Return False
				
				if is_id_tipo = 'ESB' Then
					
					if isvalid(w_aguarde_3) Then
						w_aguarde_3.wf_settext('Produto: ' + String(is_cd_produto_sap), 3 )
					end if	
					
//					If is_id_alteracao = 'L' Then 
//						is_id_alteracao  = 'S' 
//					Else 
//						is_id_alteracao  = 'N' 
//					End If	
					
				else
					
					If is_id_alteracao = 'L' Then 
						is_id_alteracao  = 'F' 
					Else 
						is_id_alteracao  = 'N' 
					End If	
					
				end if
				
				If is_id_tipo = 'PRO' Then 
						
					If Not io_Comum.of_localiza_codigo_promocao_legado(is_cd_promocao_sap, ref il_cd_promocao , ref ls_log) Then
						Return False
					End If 
					
					if isvalid(w_aguarde_3) Then
						w_aguarde_3.wf_settext('Promo$$HEX2$$e700e300$$ENDHEX$$o: ' + String(il_cd_promocao), 3 )
					end if	
					
				elseif is_id_tipo = 'PLA'  Then
					
					il_cd_promocao = long(is_cd_promocao_planograma)
					
					if isvalid(w_aguarde_3) Then
						w_aguarde_3.wf_settext('Planograma: ' + String(il_cd_promocao), 3 )
					end if	
					
				End If 
				
				If io_Comum.of_Localiza_Codigo_Produto_Legado(is_cd_produto_sap, Ref ll_Produto, Ref ls_Log) Then
					If io_Comum.of_Localiza_Codigo_Filial_Legado(is_cd_filial_sap, Ref ll_Filial, Ref ls_Log) Then
					//	If wf_Filial_Administrada_SAP(ll_Filial, Ref ls_Log) Then
							If This.of_Insere_Dados(ll_Filial, ll_Produto, Ref ls_Log) Then
								lb_Sucesso	= True
					//		End If
						End If
					End If
				End If
				
				If Not lb_Sucesso Then
					Exit
				End If
				
				if isvalid(w_aguarde_3) Then
					w_aguarde_3.uo_progress_2.of_setprogress(ll_linha)
				end if
				
			Next
		Else
			ls_Log  = "Quantidade de registros recebido na interface deve ser maior do que 1 para a tabela [interface_sap]. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle)+"."
			Return False
		End If
		
	End If
		
Finally
	If lb_Sucesso Then
		SqlCa.of_Commit()
	Else
		SqlCA.of_RollBack()
		
		If lb_registro_pendente Then
			lo_Comum.of_grava_erro(al_controle, 179, ls_Log)
		End If
	End If
	
	Destroy lo_Comum
End Try

Return True
end function

public subroutine of_processa_atualizacao ();Long ll_Linhas
Long ll_Linha

dc_uo_ds_base lds 

try 
	
	lds  = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject('ds_ge473_lista_controles', False) Then 
		gvo_aplicacao.of_grava_log("Interface ResumoReposEstoqueMinimo - Erro alterar a DW [ds_ge473_lista_controles] - uo_ge473_resumo_repos_estoque_sos_estoque_minimo_sap" )
		Return
	End If
	
	ll_Linhas = lds.Retrieve(il_Tabela)
	
	If ll_Linhas > 0 Then
		For ll_Linha = 1 To ll_Linhas
											
			uo_ge473_resumo_repos_estoque_sos_estoque_minimo_sap  lo_resumo_repos_estoque_sos_estoque_minimo_sap
			 
			Try
				lo_resumo_repos_estoque_sos_estoque_minimo_sap	= Create uo_ge473_resumo_repos_estoque_sos_estoque_minimo_sap
				lo_resumo_repos_estoque_sos_estoque_minimo_sap.of_atualiza_resumo_repos_est_sos_est_min(lds.Object.nr_controle[ll_Linha] ,  il_Tabela )
			Finally
				Destroy(lo_resumo_repos_estoque_sos_estoque_minimo_sap)
			End Try			
			
		Next
	ElseIf ll_Linhas < 0 Then
		gvo_aplicacao.of_grava_log("Interface ResumoReposEstoqueMinimo - Erro ao recuperar os da DW [ds_ge473_lista_controles] - uo_ge473_resumo_repos_estoque_sos_estoque_minimo_sap.of_processa_atualizacao.")
	End If	
	
finally
	Destroy lds
end try
end subroutine

public function boolean wf_filial_administrada_sap (long al_filial, ref string as_erro);String	ls_Vl_Parametro

Select coalesce(vl_parametro,'N')
Into :ls_Vl_Parametro
From parametro_loja  
where	cd_parametro = 'ID_ADM_FILIAL_SAP'
And cd_filial  = :al_Filial 
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		
	Case 100
		ls_Vl_Parametro = "N"
	Case -1
		as_Erro = "Erro ao localizar o par$$HEX1$$e200$$ENDHEX$$metro 'ID_ADM_FILIAL_SAP': "+SqlCa.SqlErrText
		Return False
End Choose

If ls_Vl_Parametro <> "S" Then
	as_Erro = "A filial "+String(al_Filial)+" n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ liberada para operar no SAP."
	Return False
End If

Return True
end function

public function boolean of_insere_promocao_sos_estoque_minimo (long al_filial, long al_produto, ref string as_log);Long	ll_Cd_Promocao,&
		ll_Motivo_Alteracao,&
		ll_Promocao_SAP,&
		ll_Qtd, ll_existe,&
		ll_Minimo_Matriz_Atual

Try
	
	ll_Cd_Promocao	= il_cd_promocao
		
	//Verifica se a Promo$$HEX2$$e700e300$$ENDHEX$$o existe na base:
	Select count(*)
	into :ll_existe
	from promocao_sos
	where cd_promocao_sos = :ll_cd_promocao
	Using Sqlca;
	
	if Sqlca.sqlcode = -1 then 
		as_log = 'Erro ao consultar a tabela "promo$$HEX2$$e700e300$$ENDHEX$$o_sos": ' + Sqlca.sqlerrtext
		return false
	end if
		
	if ll_existe = 0 or isnull(ll_existe) Then
		if is_id_tipo = 'PLA' Then
			as_log = 'O Planograma [' + string(ll_cd_promocao) + '] n$$HEX1$$e300$$ENDHEX$$o existe na base de dados.'
		else
			as_log = 'A Promo$$HEX2$$e700e300$$ENDHEX$$o [' + string(ll_cd_promocao) + '] n$$HEX1$$e300$$ENDHEX$$o existe na base de dados.'
		end if
		return false
	end if
		
	// Verifica se Tem ou N$$HEX1$$e300$$ENDHEX$$o o Registro na Tabela
	select count(*) 
	Into :ll_Qtd
	from   promocao_sos_estoque_minimo
	Where	cd_promocao_sos	= :ll_Cd_Promocao
		And	cd_filial					= :al_Filial
		And	cd_produto			= :al_Produto
	Using SqlCa;
	
		
	Choose Case SqlCa.SqlCode
		Case 0
			If ll_Qtd=1 Then 
				
				if this.is_id_tipo = 'PLA' Then
					
					setnull(ll_Motivo_Alteracao)
					
					select  qt_estoque_minimo_matriz 
					Into :ll_Minimo_Matriz_Atual
					from promocao_sos_estoque_minimo
					Where cd_promocao_sos = :ll_Cd_Promocao
						And cd_filial	= :al_Filial
						And cd_produto = :al_Produto
					Using SqlCa;
					
					Choose Case SQLCA.sqlcode
						Case -1
							as_Log = "Erro ao consultar os dados da tabela 'PROMOCAO_SOS_ESTOQUE_MINIMO'. Erro: "+ SqlCa.SqlErrText
							Return False
							
						Case 0
							il_qt_min_base_planograma = ll_Minimo_Matriz_Atual
							
					End Choose
					
				else
					ll_motivo_alteracao = long(is_cd_motivo_alteracao)
					
					if Not of_valida_motivo(ll_motivo_alteracao, is_de_motivo_alteracao, ref as_log) Then return false
					
					Select count(*)
					into :ll_existe
					from motivo_alteracao_estq_minimo
					where cd_motivo = :ll_motivo_alteracao
					Using Sqlca;
					
					If SqlCa.SqlCode = -1 Then
						as_Log	= "Erro ao consultar os dados da tabela 'MOTIVO_ALTERACAO_ESTQ_MINIMO'. Erro: "+ SqlCa.SqlErrText
						Return False
					End If
					
					if ll_existe = 0 or isnull(ll_existe) Then
						as_Log	= "C$$HEX1$$f300$$ENDHEX$$digo [" + string(ll_motivo_alteracao) + "] do motivo de altera$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o cadastrado."
						Return False
					end if
					
				end if
				
				Update promocao_sos_estoque_minimo set
							qt_estoque_minimo		= :il_qt_estoque,
							id_alterado_filial				= :is_id_alteracao, 
							nr_matricula_alteracao	= :is_nr_matricula,
							cd_motivo_alteracao		= :ll_Motivo_Alteracao,
							qt_estoque_minimo_matriz = coalesce( :il_qt_min_base_planograma,0) 
				Where	cd_promocao_sos	= :ll_Cd_Promocao
					And	cd_filial				= :al_Filial
					And	cd_produto			= :al_Produto
				Using SqlCa;
				
				If SqlCa.SqlCode = -1 Then
					as_Log	= "Erro ao atualizar os dados da tabela 'PROMOCAO_SOS_ESTOQUE_MINIMO'. C$$HEX1$$f300$$ENDHEX$$digo do produto SAP ["+is_cd_produto_sap+"], c$$HEX1$$f300$$ENDHEX$$digo legado ["+String(al_Produto)+"]. Erro: "+ SqlCa.SqlErrText
					Return False
				End If
				
				If SqlCa.SqlNRows <> 1 Then
					as_Log	= "Deveria ter atualizado 1 linha na tabela 'PROMOCAO_SOS_ESTOQUE_MINIMO', mas a tentativa de atualizar foi de "+String(SqlCa.SqlNRows)+" linha(s). C$$HEX1$$f300$$ENDHEX$$digo do produto SAP ["+is_cd_produto_sap+"], c$$HEX1$$f300$$ENDHEX$$digo legado ["+String(al_Produto)+"]."
					Return False
				End If				
			ElseIf ll_Qtd=0 Then 
					// Colocado o insert abaixo
					Insert into promocao_sos_estoque_minimo ( cd_promocao_sos, cd_filial, cd_produto, qt_estoque_minimo, nr_matricula_alteracao , id_alterado_filial ,  qt_estoque_minimo_matriz ) 
					Values  ( :ll_Cd_promocao ,  :al_Filial ,  :al_Produto , :il_qt_estoque, :is_nr_matricula, :is_id_alteracao  , coalesce( :il_qt_min_base_planograma, 0)  )
					Using SqlCA;
					
					If SqlCa.SqlCode = -1 Then
						as_Log	= "Erro ao inserir os dados da tabela 'PROMOCAO_SOS_ESTOQUE_MINIMO'. C$$HEX1$$f300$$ENDHEX$$digo do produto SAP ["+is_cd_produto_sap+"], c$$HEX1$$f300$$ENDHEX$$digo legado ["+String(al_Produto)+"]. Erro: "+ SqlCa.SqlErrText
						Return False
					End If	
			End If 
			
		Case -1
			as_Log	= "Erro ao localizar o c$$HEX1$$f300$$ENDHEX$$digo da promo$$HEX2$$e700e300$$ENDHEX$$o SOS. Erro: "+ SqlCa.SqlErrText
			Return False
	End Choose
	
Catch ( runtimeerror  lo_rte )
	as_Log = "Erro ao atualizar os dados da tabela 'PROMOCAO_SOS_ESTOQUE_MINIMO'. Erro: "+lo_rte.GetMessage()
	Return False
End Try	

Return True
end function

public function boolean of_valida_motivo (long pl_cd_motivo, string ps_descricao, ref string ps_log);long ll_existe

select count(*)
into :ll_existe
from motivo_alteracao_estq_minimo
where cd_motivo = :pl_cd_motivo;

if sqlca.sqlcode = -1 then
	ps_log = 'Erro ao consultar a tabela "motivo_alteracao_estq_minimo": '	 + sqlca.sqlerrtext
	return false
end if

if ll_existe = 0 or isnull(ll_existe) Then
	
	Insert into motivo_alteracao_estq_minimo(cd_motivo, de_motivo)
	values(:pl_cd_motivo, :ps_descricao);
	
	if sqlca.sqlcode = -1 then
		ps_log = 'Erro ao inserir registro na tabela "motivo_alteracao_estq_minimo": '	 + sqlca.sqlerrtext
		return false
	end if
	
end if

return true
end function

public function boolean of_valida_usuario (ref string as_nr_matricula, ref string as_log);long ll_existe

Select count(*)
into :ll_existe
from usuario
where nr_matricula = :as_nr_matricula
Using SQLCA;

if SQLCA.sqlcode = -1 then 
	as_log = 'Objeto: ' + this.classname() + '~nM$$HEX1$$e900$$ENDHEX$$todo: of_valida_usuario ~nErro ao consultar a tabela "usuario": ' + sqlca.sqlerrtext
	return false
end if

If ll_existe = 0 or isnull(ll_existe) Then as_nr_matricula = 'SAP001'

return true
end function

on uo_ge473_resumo_repos_estoque_sos_estoque_minimo_sap.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge473_resumo_repos_estoque_sos_estoque_minimo_sap.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;io_Comum	= Create uo_ge473_comum
end event

event destructor;Destroy(io_Comum)
end event

