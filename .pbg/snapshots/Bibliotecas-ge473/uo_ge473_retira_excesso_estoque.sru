HA$PBExportHeader$uo_ge473_retira_excesso_estoque.sru
forward
global type uo_ge473_retira_excesso_estoque from nonvisualobject
end type
end forward

global type uo_ge473_retira_excesso_estoque from nonvisualobject
end type
global uo_ge473_retira_excesso_estoque uo_ge473_retira_excesso_estoque

type variables
Date		id_dh_inicio_vigencia
Date		id_dh_termino_vigencia
Date		id_dh_vencimento_minimo
Long		il_retirada
String 	is_cd_retirada_estoque_sap
String 	is_de_dados_adicionais
String	is_nr_matricula_responsavel

String	is_de_chave_acesso_sap
String	is_nr_solicitacao
end variables

forward prototypes
public subroutine of_processa_atualizacao (long al_tabela)
public function boolean of_retira_zeros_esquerda_value (string as_gruop, ref string as_value, ref string as_value2, ref string as_value3)
public function boolean of_atualiza_retira_excesso_estoque (long al_controle, long al_tabela)
public function boolean of_numero_retirada (ref long al_retirada, ref string as_erro)
public function boolean of_insere_retira_excesso_estoque_item (ref string as_log, long al_controle_pai)
public function boolean of_custo_produto (long al_filial, long al_produto, ref decimal adc_custo, ref string as_log)
public function boolean of_insere_retira_excesso_estoque (uo_ge473_comum acomum, long al_controle, ref string as_log)
end prototypes

public subroutine of_processa_atualizacao (long al_tabela);Long ll_Linhas
Long ll_Linha, ll_nr_controle, ll_controles_gerando

dc_uo_ds_base lds 

try 
	
	lds  = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject('ds_ge473_lista_controles', False) Then 
		gvo_aplicacao.of_grava_log("Interface Retira Excesso Estoque - Erro alterar a DW [ds_ge473_lista_controles] - uo_ge473_retira_excesso_estoque.of_processa_atualizacao" )
		Return
	End If
	
	ll_Linhas = lds.Retrieve(al_Tabela)
	
	If ll_Linhas > 0 Then
		For ll_Linha = 1 To ll_Linhas
			uo_ge473_retira_excesso_estoque	lo_retira_excesso_estoque
			 
			Try
				lo_retira_excesso_estoque	= Create uo_ge473_retira_excesso_estoque
				lo_retira_excesso_estoque.of_atualiza_retira_excesso_estoque( lds.Object.nr_controle[ll_Linha],al_tabela )

			Finally
				Destroy(lo_retira_excesso_estoque)
			End Try
		Next
	ElseIf ll_Linhas < 0 Then
		gvo_aplicacao.of_grava_log("Interface Retira Excesso Estoque - Erro ao recuperar os da DW [ds_ge473_lista_controles] - uo_ge473_retira_excesso_estoque.of_processa_atualizacao.")
	End If	
	
finally
	Destroy lds
end try
end subroutine

public function boolean of_retira_zeros_esquerda_value (string as_gruop, ref string as_value, ref string as_value2, ref string as_value3);//MATNR MAterial
Choose Case as_gruop
	case '10', '11', '21', '23', '49'
		as_value		= gf_tira_zero_esquerda(as_value)
	case '12', '14', '17', '27', '29', '45'
		as_value2	= gf_tira_zero_esquerda(as_value2)
	case '24', '25'
		as_value3	= gf_tira_zero_esquerda(as_value3)
end choose

//LIFNR Fornecedor
Choose Case as_gruop
	case '12', '14', '15', '17'
		as_value2	= gf_tira_zero_esquerda(as_value)
	case '25', '33'
		as_value3	= gf_tira_zero_esquerda(as_value2)
end choose

return true
end function

public function boolean of_atualiza_retira_excesso_estoque (long al_controle, long al_tabela);Boolean 	lb_Sucesso = False
Long 		ll_Atualizacao_Pend, ll_Linhas, ll_for
String 	ls_Log, ls_Chave_Controle


Try
	uo_ge473_comum lo_Comum
	lo_Comum = Create uo_ge473_comum
			
	select de_chave_sap
	  into :is_de_chave_acesso_sap
	  from interface_sap  i 
	 where i.cd_tabela 	= :al_tabela
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

		if isvalid(w_aguarde_3) Then
			w_aguarde_3.uo_progress_2.of_reset()
			w_aguarde_3.uo_progress_2.of_setmax(ll_linhas)
		end if

		if isvalid(w_aguarde_3) Then
			w_aguarde_3.wf_settext('Solicita$$HEX2$$e700e300$$ENDHEX$$o: ' + is_nr_solicitacao , 3 )
		end if

		lb_Sucesso	= this.of_insere_retira_excesso_estoque(lo_Comum, al_controle, Ref ls_Log)

		if isvalid(w_aguarde_3) Then
			w_aguarde_3.uo_progress_2.of_setprogress(1)
		end if	
	End If
Catch ( runtimeerror  lo_rte )
	ls_Log = "Objeto [uo_ge473_retira_excesso_estoque], fun$$HEX2$$e700e300$$ENDHEX$$o [of_atualiza_retira_excesso_estoque]. Erro: "+lo_rte.GetMessage( )
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

public function boolean of_numero_retirada (ref long al_retirada, ref string as_erro);string ls_msg

Declare sp_log Procedure for sp_parametro_prox_seq 'NR_RETIRADA_ESTOQUE'
USING SQLCA;

Execute sp_log;

If sqlca.sqlcode = -1 then 
	as_erro = 'Erro ao executar a procedure "sp_parametro_prox_seq" (of_numero_retirada): ' + sqlca.sqlerrtext 
	return false
end if

Fetch sp_log Into :al_retirada, :ls_msg;

Close sp_log;

if al_retirada = -1 then
	as_erro = 'Erro ao executar a procedure "sp_log_exportacao_prox_seq" (of_numero_retirada): ' + ls_msg
	return false
end if

return True
end function

public function boolean of_insere_retira_excesso_estoque_item (ref string as_log, long al_controle_pai);Dec{2}	ldc_Custo, ldc_Fator_Conversao
Long		ll_Controle_filho, ll_Linha, ll_qt_retirada, ll_cd_Filial, ll_cd_Produto, ll_nr_retirada_estoque, ll_Tipo_Produto_Fiscal, &
			ll_exists
String	ls_Requisicao_Chave, ls_cd_filial_sap, ls_cd_produto_sap, ls_id_devolucao_transferencia, &
			ls_id_dev_trans_aux, ls_null

uo_ge473_comum lo_Comum
uo_tratamento_fiscal lo_Tratamento
	

SetNull(ls_null)

Try
	select nr_controle, 
			 de_chave_sap
	  Into :ll_Controle_filho, 
	  		 :ls_Requisicao_Chave
	  from interface_sap  i 
	 Where i.cd_tabela = 130
		and i.nr_controle_pai = :al_controle_pai
	Using SqlCa;	

	If SqlCa.sqlcode = -1 Then
		as_Log	= "Erro ao buscar o controle na tabela interface_sap. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle_pai)+". Erro: "+SqlCa.sqlErrText
		Return False
	End If
	
	If IsNull(ls_Requisicao_Chave) Or Trim(ls_Requisicao_Chave)="" Then
		as_Log  = "N$$HEX1$$fa00$$ENDHEX$$mero da chave de acesso informada na INTERFACE_SAP do filho est$$HEX1$$e100$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido."
		Return False
	Else
		If Trim(ls_Requisicao_Chave) <> Trim(This.is_de_chave_acesso_sap ) Then
			as_Log  = "N$$HEX1$$fa00$$ENDHEX$$mero da chave de acesso da INTERFACE_SAP pai e filho est$$HEX1$$e300$$ENDHEX$$o diferentes."
			Return False
		End If
	End If
	
	lo_Comum 		= Create uo_ge473_comum
	lo_Tratamento = Create uo_tratamento_fiscal
			
	If lo_Comum.of_processa_carrega_dados(ll_Controle_filho, ref as_Log) Then		
		For ll_Linha = 1 To lo_Comum.ids_lista_registros.RowCount()	
			ls_cd_filial_sap 					= lo_Comum.ids_lista_registros.Object.cd_filial_sap[ll_Linha]
			ls_cd_produto_sap					= lo_Comum.ids_lista_registros.Object.cd_produto_sap[ll_Linha]
			ls_id_devolucao_transferencia	= lo_Comum.ids_lista_registros.Object.id_devolucao_transferencia[ll_Linha]
			ll_qt_retirada						= Long(gf_replace(lo_Comum.ids_lista_registros.Object.qt_retirada[ll_Linha], '.', ',', 0))

			If Not lo_Comum.of_Localiza_Codigo_Filial_Legado(ls_cd_filial_sap, Ref ll_cd_Filial, Ref as_Log) Then Return False
			
			If IsNull(ls_cd_produto_sap) Then ls_cd_produto_sap = ''
			
			If Not lo_Comum.of_Localiza_Codigo_Produto_Legado(ls_cd_produto_sap, Ref ll_cd_Produto, Ref as_Log) Then
				Return False
			End If
			
			If Not lo_Tratamento.of_Permite_Retirada_Perini( 'E', ll_cd_Filial, ll_cd_Produto, False, Ref ll_Tipo_Produto_Fiscal, Ref ls_id_dev_trans_aux) Then
				as_log	=  "Erro na valida$$HEX2$$e700e300$$ENDHEX$$o de retirada perini (Filial: " + String(ll_cd_Filial)+ " Produto: " + String(ll_cd_produto) +")"
				return False
			End If
			
			If ll_cd_produto > 0 and not IsNull(ll_cd_produto) Then
				If Not of_Custo_Produto(ll_cd_Filial, ll_cd_Produto, Ref ldc_Custo, Ref as_log) Then Return False
				
				If ldc_Custo = 0.00 Then
					as_log	= "O custo do produto deve ser maior que zero. (Filial: " + String(ll_cd_Filial)+ " Produto: " + String(ll_cd_produto) +")"
					return False
				End If
			End If
			
			Select vl_fator_conversao
			  Into :ldc_Fator_Conversao
			  From produto_geral
			 Where cd_produto = :ll_cd_Produto
			 Using SqlCa;

			Choose Case SqlCa.SqlCode
				Case 100
					as_log = "Informa$$HEX2$$e700e300$$ENDHEX$$o do fator de compra n$$HEX1$$e300$$ENDHEX$$o foi localizado."
					Return False
				Case -1
					as_log = "Erro ao consultar fator de compra do produto n$$HEX1$$e300$$ENDHEX$$o foi localizado." + SQLCA.SQLErrText
			End Choose
				
			If IsNull(ll_qt_retirada) Or ll_qt_retirada = 0 Then
				as_log = "A quantidade informada deve ser maior do que zero."
				Return False
			End If
			
			If Mod(ll_qt_retirada, ldc_Fator_Conversao) <> 0 Then
				as_log = "Quantidade informada para o produto '" + String(ll_cd_Produto) + "' n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ m$$HEX1$$fa00$$ENDHEX$$ltipla do fator de convers$$HEX1$$e300$$ENDHEX$$o utilizado no Estoque Central."
				Return False
			End If
			
			If ll_Linha = 1 Then
				select nr_retirada_estoque
				  into :ll_nr_retirada_estoque
				  from retirada_estoque
				 where cd_filial 						= :ll_cd_filial and
						 cd_retirada_estoque_sap 	= :is_cd_retirada_estoque_sap;
						  
				Choose Case SQLCA.SQLCode
					Case -1
						as_log	= "Erro ao consultar a existencia da retirada de estoque. " + SQLCA.SQLErrText
						Return False
					Case 100
						if not of_numero_retirada(REF ll_nr_retirada_estoque, REF as_log) then
							return False
						end if
						
						Insert Into retirada_estoque(	cd_filial, 
																nr_retirada_estoque,
																id_tipo_retirada,
																id_situacao,
																dh_inclusao,
																nr_matricula_responsavel,
																de_observacao,
																dh_inicio,
																dh_termino,
																dh_aprovacao,
																nr_matricula_aprovacao,
																dh_vencimento_minimo,
																de_dados_adicionais,
																cd_retirada_estoque_sap)
												Values(	:ll_cd_Filial, 
															:ll_nr_retirada_estoque,
															'E',
															'A',
															GetDate(),
															:is_nr_matricula_responsavel,
															:ls_null,
															:id_dh_inicio_vigencia,
															:id_dh_termino_vigencia,
															GetDate(),
															:is_nr_matricula_responsavel,
															:id_dh_vencimento_minimo,
															:is_de_dados_adicionais,
															:is_cd_retirada_estoque_sap)
						Using SqlCa;
					
						If SqlCa.SqlCode = - 1 Then
							as_log = "Erro ao gravar a retirada de estoque N$$HEX1$$ba00$$ENDHEX$$ '" + String(il_retirada) + "' para a filial '" + String(ll_cd_Filial) + "'. " + SQLCA.SQLErrText
							Return False
						End If
					Case 0
						update retirada_estoque
							set dh_inicio					= :id_dh_inicio_vigencia,
								 dh_termino					= :id_dh_termino_vigencia,
								 dh_vencimento_minimo	= :id_dh_vencimento_minimo,
								 de_dados_adicionais		= :is_de_dados_adicionais
						 where cd_filial 				= :ll_cd_filial and
								 nr_retirada_estoque = :ll_nr_retirada_estoque;
								 
						If SqlCa.SqlCode = - 1 Then
							as_log = "Erro ao atualizar a retirada de estoque N$$HEX1$$ba00$$ENDHEX$$ '" + String(il_retirada) + "' para a filial '" + String(ll_cd_Filial) + "'. " + SQLCA.SQLErrText
							Return False
						End If
				End Choose
			End If
			
			select nr_retirada_estoque
			  into :ll_nr_retirada_estoque
			  from retirada_estoque_produto
			 where cd_filial 				= :ll_cd_filial and
			 		 nr_retirada_estoque = :ll_nr_retirada_estoque and
					 cd_produto				= :ll_cd_Produto;
					  
			Choose Case SQLCA.SQLCode
				Case -1
					as_log	= "Erro ao consultar a existencia do produto na retirada de estoque. " + SQLCA.SQLErrText
					Return False
				Case 100
					Insert Into retirada_estoque_produto(cd_filial, 
																	 nr_retirada_estoque,
																	 cd_produto,
																	 qt_solicitada,
																	 qt_aprovada,
																	 vl_custo_medio,
																	 de_observacao,
																	 cd_tipo_produto_fiscal,
																	 id_devolucao_transferencia)
															Values(:ll_cd_Filial,
																	 :ll_nr_retirada_estoque,
																	 :ll_cd_Produto,
																	 :ll_qt_retirada,
																	 :ll_qt_retirada,
																	 :ldc_Custo,
																	 null,
																	 :ll_Tipo_Produto_Fiscal,
																	 :ls_id_dev_trans_aux)
					Using SqlCa;
					
					If SqlCa.SqlCode = -1 Then
						as_log = "Erro ao incluir o produto '" + String(ll_cd_Produto) + "' na retirada de estoque para a filial '" + String(ll_cd_Filial) + "'. " + SqlCa.SqlErrText
						Return False
					End If
				Case 0
					update retirada_estoque_produto
						set qt_solicitada						= :ll_qt_retirada,
							 qt_aprovada						= :ll_qt_retirada,
							 vl_custo_medio					= :ldc_Custo,
							 cd_tipo_produto_fiscal			= :ll_Tipo_Produto_Fiscal,
							 id_devolucao_transferencia	= :ls_id_dev_trans_aux
					 where cd_filial 				= :ll_cd_filial and
							 nr_retirada_estoque	= :ll_nr_retirada_estoque and
							 cd_produto				= :ll_cd_Produto;
							 
					If SqlCa.SqlCode = -1 Then
						as_log = "Erro ao atualizar o produto '" + String(ll_cd_Produto) + "' na retirada de estoque para a filial '" + String(ll_cd_Filial) + "'. " + SqlCa.SqlErrText
						Return False
					End If
			End Choose
		Next	
	Else
		Return False				
	End If
	
Catch ( runtimeerror  lo_rte )
	as_Log =  "Objeto [uo_ge473_wms_nf_compra], fun$$HEX2$$e700e300$$ENDHEX$$o [of_insere_retira_excesso_estoque_item]. Erro: "+lo_rte.GetMessage( )
	Return False	
Finally
	If IsValid(lo_Comum) Then Destroy(lo_Comum)
End Try	

Return True
end function

public function boolean of_custo_produto (long al_filial, long al_produto, ref decimal adc_custo, ref string as_log);Select Coalesce(vl_custo_gerencial, 0.00)
  Into :adc_Custo
  From vw_saldo_atual_produto
 Where cd_filial 	= :al_Filial
	And cd_produto = :al_Produto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 100
		Select Coalesce(vl_custo_gerencial, 0.00)
		  Into :adc_Custo
		  From vw_saldo_atual_produto
		 Where cd_filial = 534
			And cd_produto = :al_Produto
		 Using SqlCa;
		
		Choose Case SqlCa.SqlCode
			Case 100
				as_log = "N$$HEX1$$e300$$ENDHEX$$o foi localizado o custo do produto '" + String(al_Produto) + "' na filial '" + String(al_Filial) + "' e na Matriz."
				Return False
			Case -1
				as_log = "Erro ao consultar o custo do produto na Matriz. " + SqlCa.SqlErrText
				Return False
		End Choose
	Case -1
		as_log = "Erro ao consultar o custo do produto na filial '" + String(al_Filial) + "'. " + SqlCa.SqlErrText
		Return False
End Choose

Return True
end function

public function boolean of_insere_retira_excesso_estoque (uo_ge473_comum acomum, long al_controle, ref string as_log);Long		ll_for, ll_retirada
			

for ll_for = 1 to aComum.ids_lista_registros.RowCount()
	is_cd_retirada_estoque_sap		= aComum.ids_lista_registros.Object.cd_retirada_sap_estoque[ll_for]
	is_de_dados_adicionais			= aComum.ids_lista_registros.Object.de_dados_adicionais[ll_for]
	id_dh_inicio_vigencia			= Date(left(aComum.ids_lista_registros.Object.dh_inicio_vigencia[ll_for], 4) + '-' + mid(aComum.ids_lista_registros.Object.dh_inicio_vigencia[ll_for], 5, 2) + '-' + right(aComum.ids_lista_registros.Object.dh_inicio_vigencia[ll_for], 2))
	id_dh_termino_vigencia			= Date(left(aComum.ids_lista_registros.Object.dh_termino_vigencia[ll_for], 4) + '-' + mid(aComum.ids_lista_registros.Object.dh_termino_vigencia[ll_for], 5, 2) + '-' + right(aComum.ids_lista_registros.Object.dh_termino_vigencia[ll_for], 2))
	id_dh_vencimento_minimo			= Date(left(aComum.ids_lista_registros.Object.dh_vencimento_minimo[ll_for], 4) + '-' + mid(aComum.ids_lista_registros.Object.dh_vencimento_minimo[ll_for], 5, 2) + '-' + right(aComum.ids_lista_registros.Object.dh_vencimento_minimo[ll_for], 2))
	is_nr_matricula_responsavel	= aComum.ids_lista_registros.Object.nr_matricula_responsavel[ll_for]
	
	if not this.of_insere_retira_excesso_estoque_item(REF as_log, al_controle) then
		return False
	end if
next

return true
end function

on uo_ge473_retira_excesso_estoque.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge473_retira_excesso_estoque.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

