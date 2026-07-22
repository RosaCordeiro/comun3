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
		is_matricula_sap = 'SAP001'

DateTime	idh_inicio_promocao,&
				idh_termino_promocao

Long il_codigo_promocao
Long il_codigo_promocao_sap
Boolean ib_promocao_nova

dc_uo_ds_base ids_produto_promocao_cad
dc_uo_ds_base ids_promocao_filial_cad
dc_uo_ds_base ids_promocao_vinculo
dc_uo_ds_base ids_promocao_vinc_prd

end variables

forward prototypes
public function boolean of_valida_dados (ref string as_log)
private function boolean of_inicializa_variaveis (ref string as_log)
public function boolean of_carrega_produto_promocao (long al_controle_pai, ref string as_log)
public function boolean of_promocao_nova (ref long al_promocao, ref boolean ab_promocao_nova, ref string as_log)
public function boolean of_insere_promocao_sos (long al_promocao, boolean ab_promocao_nova, ref string as_log)
public function boolean of_atualiza_promocao (long al_controle, long al_tabela)
public function boolean of_insere_promocao_filial (long al_promocao, boolean ab_promocao_nova, ref string as_log, long al_controle_pai)
public function boolean of_insere_promocao_produto (long al_promocao, boolean ab_promocao_nova, ref string as_log, long al_controle_pai)
public function boolean of_insere_promocao_vinculo_prd (long al_promocao, boolean ab_promocao_nova, ref string as_log, long al_controle_pai)
public function boolean of_insere_promocao_sos_vinculo (long al_promocao, boolean ab_promocao_nova, ref string as_log, long al_controle_pai)
end prototypes

public function boolean of_valida_dados (ref string as_log);Try	
	If IsNull(il_codigo_promocao_sap) Or il_codigo_promocao_sap = 0  Then
		as_Log	= "O valor informado para o campo CD_PROMOCAO_SAP n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ v$$HEX1$$e100$$ENDHEX$$lido."
		Return False
	End If	

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
	
	If IsNull(is_SOS) or Trim(is_SOS) = '' Then
		is_SOS = 'N'
	End If	
	
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
	setNull(il_codigo_promocao_sap)
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

	ib_promocao_nova = False
	
	ids_promocao_vinculo.Reset()	
	ids_promocao_vinc_prd.Reset()
	ids_promocao_filial_cad.Reset()

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
	
	uo_ge473_comum lo_Comum
	lo_Comum = Create uo_ge473_comum
	
	If lo_Comum.of_processa_carrega_dados(ll_Controle_filho, 35, ref as_Log) Then
		ids_produto_promocao_cad.Reset()
		For ll_Linha = 1 To lo_Comum.ids_lista_registros.RowCount()
			
			ll_Insert 		= ids_produto_promocao_cad.InsertRow(0)						

			ls_produto_sap = gf_Tira_Zero_Esquerda(lo_Comum.ids_lista_registros.Object.cd_produto_sap[ll_Linha])
			If IsNull(ls_produto_sap) Then ls_produto_sap = ''
			
			If io_Comum.of_Localiza_Codigo_Produto_Legado(ls_produto_sap, Ref ll_Produto, Ref as_Log) Then
				ids_produto_promocao_cad.Object.cd_produto[ll_Insert] = ll_produto
			Else
				Return False
			End If
			
			If io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.pc_desconto[ll_Linha], 'PC DESCONTO', ref ldc_desconto, ref as_Log) Then
				ids_produto_promocao_cad.Object.pc_desconto[ll_Insert] = ldc_desconto
			Else
				Return False
			End If			

			If io_Comum.of_decimal(lo_Comum.ids_lista_registros.Object.pc_desconto_clube[ll_Linha], 'PC DESCONTO CLUBE', ref ldc_desconto_clube, ref as_Log) Then
				ids_produto_promocao_cad.Object.pc_desconto_clube[ll_Insert] = ldc_desconto_clube
			Else
				Return False
			End If				
						
			If io_Comum.of_date_time(lo_Comum.ids_lista_registros.Object.dh_inicio_validade[ll_Linha], 'DATA INICIO VALIDADE DESCONTO', ref ldt_inicio, ref as_Log) Then 
				ids_produto_promocao_cad.Object.dh_inicio_validade[ll_Insert] = ldt_inicio
			Else
				Return False
			End If					
					
			If io_Comum.of_date_time(lo_Comum.ids_lista_registros.Object.dh_termino_validade[ll_Linha], 'DATA TERMINO VALIDADE DESCONTO', ref ldt_fim, ref as_Log) Then 
				ids_produto_promocao_cad.Object.dh_termino_validade[ll_Insert] = ldt_fim
			Else
				Return False
			End If

		Next
	Else
		as_Log	= "Erro ao recuperar os dados da promocao produto. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle_pai)+"."
		Return False		
	End If		

finally
	Destroy(lo_Comum)	
end try

Return True	
end function

public function boolean of_promocao_nova (ref long al_promocao, ref boolean ab_promocao_nova, ref string as_log);Long ll_promocao

Try
	
	Select cd_promocao_sos
	Into	:ll_promocao
	From promocao_sos
	Where cd_promocao_sap = :il_codigo_promocao_sap
	Using SqlCa;
		
	Choose Case SqlCa.sqlcode
		Case 0
			ab_Promocao_nova = False
			al_promocao = ll_promocao
			
		Case 100
			ab_Promocao_nova	= True
			
			select max(COALESCE(cd_promocao_sos,0)) +1
				Into :ll_promocao
			From promocao_sos
			Using SqlCa;
		
			If SqlCa.SqlCode = -1 Then
				as_Log	= "Erro ao buscar codigo da nova promo$$HEX2$$e700e300$$ENDHEX$$o. Erro: "+SqlCa.sqlErrText
				Return False				
			Else
				al_promocao = ll_promocao
			End If			
		
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

public function boolean of_insere_promocao_sos (long al_promocao, boolean ab_promocao_nova, ref string as_log);Try
	
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
											  cd_promocao_sap)
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
					:il_codigo_promocao_sap )
		Using SqlCa;
									
		If SqlCa.sqlcode = -1 Then
			as_Log	= "Erro no insert da tabela 'promocao_sos'. Erro: "+SqlCa.sqlErrText
			Return False
		End If		
	Else		
		Update promocao_sos
			Set	dh_inicio = :idh_inicio_promocao,
					dh_termino = :idh_termino_promocao,
					nm_promocao_sos = :is_nome_promocao,
					id_filial_altera_estoque = :is_altera_estoque_minino,
					id_tipo_replicacao = :is_replicacao,
					de_promocao = :is_desc_promocao,
					nr_matricula_alteracao = :is_matricula_sap
		Where cd_promocao_sos = :il_codigo_promocao
		Using SqlCa;
		
		If SqlCa.sqlcode = -1 Then
			as_Log	= "Erro no update da tabela 'promocao_sos'. Erro: "+SqlCa.sqlErrText
			Return False
		End If	
	End If
	
Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_insere_promocao_sos'. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try	

Return True
end function

public function boolean of_atualiza_promocao (long al_controle, long al_tabela);dc_uo_ds_base lds

Long	ll_Achou,&
		ll_Linhas,&
		ll_Linha
		
String	ls_Log
		
Boolean	lb_Sucesso = False		

Select count(*)
Into :ll_Achou
From 	interface_sap
Where nr_controle = :al_controle
	 and id_situacao in ('C', 'E')
	and dh_processamento is null
Using SqlCa;

If SqlCa.sqlcode = -1 Then
	io_Comum.of_grava_erro(al_controle, 177, "Erro ao mudar a situa$$HEX2$$e700e300$$ENDHEX$$o na tabela interface_sap. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle)+". Erro: "+SqlCa.sqlErrText)
	Return False
End If

If ll_Achou = 0 Then Return True

Try
	
	If Not io_Comum.of_Muda_Situacao_Interface(al_Controle, Ref ls_Log) Then Return False
	If Not This.of_Inicializa_Variaveis(Ref ls_Log) Then Return False
	
	/*
	 PROMOCAO_SOS normal (34)
	 PROMOCAO_SOS_PRODUTO (35)			
	 PROMOCAO_SOS_FILIAL (38)
	 PROMOCAO_SOS_VINCULO(39)
	 PROMOCAO_SOS_VINCULO_PRD(40)
	*/
	
	uo_ge473_comum lo_Comum
	lo_Comum = Create uo_ge473_comum
	
	If lo_Comum.of_processa_carrega_dados(al_controle, al_tabela, ref ls_Log) Then
		
		For ll_Linha = 1 To lo_Comum.ids_lista_registros.RowCount()
			is_rede_promocao 			= lo_Comum.ids_lista_registros.Object.cd_organizacao_venda[ll_Linha]
			is_tipo_promocao 				= lo_Comum.ids_lista_registros.Object.cd_categoria_promocao[ll_Linha]
			il_codigo_promocao_sap 	= Long(gf_Tira_Zero_Esquerda(lo_Comum.ids_lista_registros.Object.cd_promocao_sap[ll_Linha]))
			is_nome_promocao			= lo_Comum.ids_lista_registros.Object.nm_promocao_sos[ll_Linha]
			is_desc_promocao				= lo_Comum.ids_lista_registros.Object.de_promocao[ll_Linha]
			If Not io_Comum.of_date_time(lo_Comum.ids_lista_registros.Object.dh_inicio[ll_Linha], 'DATA INICIO PROMOCAO', ref idh_inicio_promocao, ref ls_Log) Then Return False
			If Not io_Comum.of_date_time(lo_Comum.ids_lista_registros.Object.dh_termino[ll_Linha], 'DATA TERMINO PROMOCAO', ref idh_termino_promocao, ref ls_Log) Then Return False
			is_altera_estoque_minino	= lo_Comum.ids_lista_registros.Object.id_filial_altera_estoque[ll_Linha]
			is_replicacao					= lo_Comum.ids_lista_registros.Object.id_tipo_replicacao[ll_Linha]
			is_SOS							= lo_Comum.ids_lista_registros.Object.id_sos[ll_Linha]
			is_PBM							= lo_Comum.ids_lista_registros.Object.id_pbm[ll_Linha]
			If is_PBM = 'S' Then //PBM Clamed
				is_tipo_promocao = 'C'
			End If
			If is_SOS = 'S' Then //SOS - F3
				is_tipo_promocao = 'S'
			End If
			is_UF 								= lo_Comum.ids_lista_registros.Object.cd_uf[ll_Linha]
			is_Domicilio						= lo_Comum.ids_lista_registros.Object.cd_domicilio_fiscal[ll_Linha]
		Next
		
	Else
		Return False
	End If	
	Destroy(lo_comum)	
	
	If This.of_Valida_Dados(Ref ls_Log) Then
		If This.of_promocao_nova( ref il_codigo_promocao, ref ib_promocao_nova, ref ls_log ) Then
			If This.of_insere_promocao_sos( il_codigo_promocao, ib_promocao_nova, ref ls_log) Then
				If This.of_insere_promocao_filial( il_codigo_promocao, ib_promocao_nova, ref ls_log, al_controle ) Then
					If This.of_insere_promocao_produto( il_codigo_promocao, ib_promocao_nova, ref ls_log, al_controle ) Then
						If This.of_insere_promocao_sos_vinculo( il_codigo_promocao, ib_promocao_nova, ref ls_log, al_controle ) Then
							If This.of_insere_promocao_vinculo_prd( il_codigo_promocao, ib_promocao_nova, ref ls_log, al_controle ) Then
								lb_Sucesso	= True
							End If
						End If
					End If
				End If
			End If
		End If
	End If
			
Finally
	
	If lb_Sucesso Then
		SqlCa.of_Commit()
	Else
		SqlCA.of_RollBack()
		io_Comum.of_grava_erro(al_controle, 177, ls_Log)
	End If
		
	Destroy(lds)
	Destroy(lo_comum)
End Try

Return lb_Sucesso
end function

public function boolean of_insere_promocao_filial (long al_promocao, boolean ab_promocao_nova, ref string as_log, long al_controle_pai);Long ll_linhas
Long ll_linha
Long ll_Filial
Long ll_achou
Long ll_controle_filho
Long ll_contador
Long ll_find

String ls_filial_sap

Boolean lb_Filial = True
Boolean lb_UF = True
Boolean lb_cidade = True
			
Try

	SELECT nr_controle
	Into :ll_Controle_filho
	FROM interface_sap  i 
	Where i.cd_tabela = 38
		and i.nr_controle_pai = :al_controle_pai
	Using SqlCa;	

	If SqlCa.sqlcode = -1 Then
		as_Log	= "Erro ao buscar o controle na tabela interface_sap. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle_pai)+". Erro: "+SqlCa.sqlErrText
		Return False
	End If

	If ll_Controle_filho = 0 Or IsNull(ll_Controle_filho) Then
		lb_Filial = False
	End If		
	
	If IsNull(is_UF) or Trim(is_UF) = "" Then
		lb_UF = False
	End If
	
	If IsNull(is_Domicilio) or Trim(is_Domicilio) = "" Then
		lb_cidade = False
	End If
	
	If lb_Filial = False And lb_UF = False and lb_cidade = False  Then Return True  //Na interface n$$HEX1$$e300$$ENDHEX$$o trouxe altera$$HEX2$$e700f500$$ENDHEX$$es para promocao_sos_filial		
	
	If lb_Filial Then //Promocao por Filial
		If lb_UF or lb_Cidade Then
			as_Log	= "Foi retornado mais de um tipo de integra$$HEX2$$e700e300$$ENDHEX$$o para Promocao_sos_filial(Filial x UF x Domicilio)."
			Return False			
		End If
		
		uo_ge473_comum lo_Comum
		lo_Comum = Create uo_ge473_comum
				
		If lo_Comum.of_processa_carrega_dados(ll_Controle_filho, 38, ref as_Log) Then		
			For ll_Linha = 1 To lo_Comum.ids_lista_registros.RowCount()
				If Not io_Comum.of_Localiza_Codigo_Filial_Legado(lo_Comum.ids_lista_registros.Object.cd_filial_sap[ll_Linha], Ref  ll_Filial, Ref as_Log) Then Return False
				
				Select cd_promocao_sos
				Into :ll_Achou
				from promocao_sos_filial
				where cd_promocao_sos = :il_codigo_promocao
					and cd_filial = :ll_Filial
				Using SqlCa;
				
				Choose Case SqlCa.SqlCode
					Case 0					
						//J$$HEX1$$e100$$ENDHEX$$ existe 					
						Continue
					Case 100
						
						Insert into promocao_sos_filial(  cd_promocao_sos, 
															  cd_filial,
															  nr_matricula_alteracao)
						Values (	:il_codigo_promocao, 
									:ll_Filial,
									:is_matricula_sap  )
						Using SqlCa;
													
						If SqlCa.sqlcode = -1 Then
							as_Log	= "Erro no insert da tabela 'promocao_sos_filial' por filial. Erro: "+SqlCa.sqlErrText
							Return False
						End If
						
					Case -1
						as_Log	= "Erro ao localizar filial na promocao sos. Erro: "+SqlCa.sqlErrText
						Return False
				End Choose							
				
			Next
		Else
			Return False
		End If	
	End if	
	
	If lb_cidade Then

		INSERT INTO promocao_sos_filial  
			( cd_promocao_sos,   
			  cd_filial,   
			  nr_matricula_alteracao) 
		 select :il_codigo_promocao, f.cd_filial, :is_matricula_sap 
					from filial f
						inner join cidade c
						on c.cd_cidade = f.cd_cidade
					where c.cd_cidade_ibge = :is_Domicilio
					and f.id_situacao = 'A'
					 and not exists (select * from promocao_sos_filial p
					  where p.cd_promocao_sos = :il_codigo_promocao
					 and p.cd_filial  = f.cd_filial)
		Using SqlCa;
		
		If SqlCa.sqlcode = -1 Then
			as_Log	= "Erro no insert da tabela 'promocao_sos_filial' por cidade. Erro: "+SqlCa.sqlErrText
			Return False
		End If				
		
	End If
			
	If lb_UF Then //Insere por UF			
		  INSERT INTO promocao_sos_filial  
				( cd_promocao_sos,   
				  cd_filial,   
				  nr_matricula_alteracao) 
			 select :il_codigo_promocao, f.cd_filial, :is_matricula_sap 
						from filial f
							inner join cidade c
							on c.cd_cidade = f.cd_cidade
						where c.cd_unidade_federacao = :is_UF
						and f.id_situacao = 'A'
						 and not exists (select * from promocao_sos_filial p
						  where p.cd_promocao_sos = :il_codigo_promocao
						 and p.cd_filial  = f.cd_filial)
			Using SqlCa;
			
			If SqlCa.sqlcode = -1 Then
				as_Log	= "Erro no insert da tabela 'promocao_sos_filial' por UF. Erro: "+SqlCa.sqlErrText
				Return False
			End If
	End If

	
	If Not ib_promocao_nova Then		
		//Verificar se $$HEX1$$e900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio excluir ou incluir filial????????????
		//N$$HEX1$$e300$$ENDHEX$$o deve vir exclus$$HEX1$$e300$$ENDHEX$$o do SAP de UF ou Domicilio, somente por filial.

		If lb_filial Then
			If lo_Comum.ids_lista_registros.RowCount() > 0 Then			
				ids_promocao_filial_cad.Retrieve(il_codigo_promocao)							
	
				For ll_Linha = 1 To ids_promocao_filial_cad.RowCount()			
					
					If Not io_Comum.of_Localiza_Codigo_Filial_Sap(ids_promocao_filial_cad.Object.cd_filial [ll_LInha], Ref  ls_filial_sap, Ref as_Log) Then Return False
					ll_Filial = ids_promocao_filial_cad.Object.cd_filial [ll_LInha]
					
					ll_find	= lo_Comum.ids_lista_registros.Find ("cd_filial_sap = '" + ls_filial_sap +"'" , 1 , lo_Comum.ids_lista_registros.RowCount())
													 
					If ll_find > 0 Then
						Continue
					Else
						If ll_find < 0 Then
							as_Log	= "Erro no find da promocao sap."
							Return False
						End If	
						If ll_find = 0 Then						
							Delete from promocao_sos_filial
							Where cd_promocao_sos = :il_codigo_promocao
								and cd_filial = :ll_Filial
							Using SqlCa;
														
							If SqlCa.sqlcode = -1 Then
								as_Log	= "Erro delete da tabela 'promocao_sos_filial'. Erro: "+SqlCa.sqlErrText
								Return False
							End If
						End If				
					End If				
				Next
			End If
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

public function boolean of_insere_promocao_produto (long al_promocao, boolean ab_promocao_nova, ref string as_log, long al_controle_pai);Long ll_linhas
Long ll_linha
Long ll_produto
Long ll_achou
Long ll_controle_filho

DateTime ldt_inicio
DateTime ldt_termino
DateTime ldt_alteracao
DateTime ldt_vigencia_futuro

Date ldt_futuro

Decimal ldc_pc_desconto
Decimal ldc_pc_desconto_clube
Decimal ldc_pc_desconto_futuro
Decimal ldc_pc_desconto_clube_futuro

String ls_produto_sap

Try
			
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
	
	uo_ge473_comum lo_Comum
	lo_Comum = Create uo_ge473_comum
			
	If lo_Comum.of_processa_carrega_dados(ll_Controle_filho, 35, ref as_Log) Then		
		For ll_Linha = 1 To lo_Comum.ids_lista_registros.RowCount()
			ldc_pc_desconto_futuro = 0
			ldc_pc_desconto_clube_futuro = 0

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
			If Not io_Comum.of_date_time(lo_Comum.ids_lista_registros.Object.dh_inicio_validade[ll_Linha], 'DATA INICIO VALIDADE DESCONTO', ref ldt_inicio, ref as_Log) Then 
				Return False
			End If										
			If Not io_Comum.of_date_time(lo_Comum.ids_lista_registros.Object.dh_termino_validade[ll_Linha], 'DATA TERMINO VALIDADE DESCONTO', ref ldt_termino, ref as_Log) Then 
				Return False
			End If
			
			ldt_alteracao 				= DateTime(gf_GetServerDate())
			SetNull(ldt_vigencia_futuro)
		
			Select cd_promocao_sos
			Into :ll_Achou
			from promocao_sos_produto
			where cd_promocao_sos = :il_codigo_promocao
				and cd_produto = :ll_produto
			Using SqlCa;

			Choose Case SqlCa.SqlCode
				Case 0
					ldt_vigencia_futuro = ldt_inicio
					ldc_pc_desconto_futuro = ldc_pc_desconto
					ldc_pc_desconto_clube_futuro = ldc_pc_desconto_clube
					If ldt_inicio <= ldt_alteracao Then //Vig$$HEX1$$ea00$$ENDHEX$$ncia menor que a data atual, colocar vig$$HEX1$$ea00$$ENDHEX$$ncia futura para data atual + 1
						If Not gf_DateAdd(Date(ldt_alteracao), "day", 1, Ref ldt_futuro) Then
							as_Log	= "Erro calcular vigencia futura tabela:'PROMOCAO_SOS_PRODUTO' ."
							Return False
						End If
						ldc_pc_desconto_futuro = ldc_pc_desconto
						ldc_pc_desconto_clube_futuro = ldc_pc_desconto_clube						
						ldt_vigencia_futuro = DateTime(ldt_futuro)
					End If					
					If ldt_termino < idh_termino_promocao Then //Termino antes da promocao, zera descontos futuros e coloca vigencia futura para termino + 1
						ldc_pc_desconto_futuro = 0
						ldc_pc_desconto_clube_futuro = 0
						If Not gf_DateAdd(Date(ldt_termino), "day", 1, Ref ldt_futuro) Then
							as_Log	= "Erro calcular vigencia futura tabela:'PROMOCAO_SOS_PRODUTO' ."
							Return False
						End If
						ldt_vigencia_futuro = DateTime(ldt_futuro)												
					End If
			
					Update promocao_sos_produto
					Set pc_desconto_futuro = :ldc_pc_desconto_futuro,
						 pc_desconto_clube_futuro = :ldc_pc_desconto_clube_futuro,
						 dh_alteracao = :ldt_alteracao,
						 nr_matricula_alteracao = :is_matricula_sap,
						 dh_vigencia_futuro = :ldt_vigencia_futuro
					where cd_promocao_sos = :il_codigo_promocao
						and cd_produto = :ll_produto
					Using SqlCa;
					
					If SqlCa.SqlCode = -1 Then
						as_Log	= "Erro ao atualizar produto tabela:'PROMOCAO_SOS_PRODUTO' . Erro: "+SqlCa.sqlErrText
						Return False
					End If
					
				Case 100	
					
					If Date(ldt_inicio) > Date(idh_inicio_promocao) Then //Inicio Maior que o inicio dao promo$$HEX2$$e700e300$$ENDHEX$$o, zerar descontos normaisl, colocar descontos futuros e vig$$HEX1$$ea00$$ENDHEX$$ncia futura.
						//Zerar descontos e grava nos descontos futuros
						ldc_pc_desconto_futuro  			= ldc_pc_desconto
						ldc_pc_desconto_clube_futuro	= ldc_pc_desconto_clube
						ldc_pc_desconto = 0
						ldc_pc_desconto_clube = 0						
						ldt_vigencia_futuro = ldt_inicio
						If Date(ldt_inicio) <= Date(ldt_alteracao) Then
							If Not gf_DateAdd(Date(ldt_alteracao), "day", 1, Ref ldt_futuro) Then
								as_Log	= "Erro calcular vigencia futura tabela:'PROMOCAO_SOS_PRODUTO' ."
								Return False
							End If													
							ldt_vigencia_futuro = DateTime(ldt_futuro)
						End If
					End If					
					
					insert into promocao_sos_produto(
							cd_promocao_sos, 
							cd_produto, 
							pc_desconto, 
							dh_alteracao, 
							nr_matricula_alteracao, 
							pc_desconto_clube,
							pc_desconto_futuro,
							pc_desconto_clube_futuro,
							dh_vigencia_futuro)
					values (	:il_codigo_promocao,  
								:ll_Produto,
								:ldc_pc_desconto, 
								:ldt_alteracao, 
								:is_matricula_sap, 
								:ldc_pc_desconto_clube,
								:ldc_pc_desconto_futuro,
								:ldc_pc_desconto_clube_futuro,
								:ldt_vigencia_futuro)
					Using SqlCA;
						
					If SqlCa.SqlCode = -1 Then
						as_Log	= "Erro no insert da tabela 'PROMOCAO_SOS_PRODUTO'. Erro: "+SqlCa.sqlErrText
						Return False
					End If
					
				Case -1
					as_Log	= "Erro no select da tabela 'PROMOCAO_SOS_PRODUTO'. Erro: "+SqlCa.sqlErrText
					Return False
			End Choose				
			
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

String ls_produto_sap
			
Try

	SELECT nr_controle
	Into :ll_Controle_filho
	FROM interface_sap  i 
	Where i.cd_tabela = 40
		and i.nr_controle_pai = :al_controle_pai
	Using SqlCa;	

	If SqlCa.sqlcode = -1 Then
		as_Log	= "Erro ao buscar o controle na tabela interface_sap. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle_pai)+". Erro: "+SqlCa.sqlErrText
		Return False
	End If	
	
	uo_ge473_comum lo_Comum
	lo_Comum = Create uo_ge473_comum
			
	If lo_Comum.of_processa_carrega_dados(ll_Controle_filho, 40, ref as_Log) Then		
		For ll_Linha = 1 To lo_Comum.ids_lista_registros.RowCount()

			If Not IsNumber(lo_Comum.ids_lista_registros.Object.nr_vinculo[ll_Linha]) Then
				as_Log = "O valor informado para o campo NR_VINCULO n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ v$$HEX1$$e100$$ENDHEX$$lido."
				Return False
			Else
				ll_vinculo = Long(lo_Comum.ids_lista_registros.Object.nr_vinculo[ll_Linha])
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
			
			ls_produto_sap = gf_Tira_Zero_Esquerda(lo_Comum.ids_lista_registros.Object.cd_produto_sap[ll_Linha])
			If IsNull(ls_produto_sap) Then ls_produto_sap = ''
			
			If Not io_Comum.of_Localiza_Codigo_Produto_Legado(ls_produto_sap, Ref ll_Produto, Ref as_Log) Then
				Return False
			End If

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
			
		Next
		
		//Verifica exclusao
		If	lo_Comum.ids_lista_registros.RowCount() > 0 Then
			ids_promocao_vinc_prd.Reset()
			ids_promocao_vinc_prd.Retrieve(il_codigo_promocao)
	
			For ll_linha = 1 To ids_promocao_vinc_prd.RowCount()				
	
				ll_vinculo = ids_promocao_vinc_prd.Object.nr_vinculo [ll_LInha]
				
				ll_find	= lo_Comum.ids_lista_registros.Find ("nr_vinculo = " + String(ll_vinculo) , 1 , lo_Comum.ids_lista_registros.RowCount())
												 
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

String ls_de_vinculo
			
Try

	SELECT nr_controle
	Into :ll_Controle_filho
	FROM interface_sap  i 
	Where i.cd_tabela = 39
		and i.nr_controle_pai = :al_controle_pai
	Using SqlCa;	

	If SqlCa.sqlcode = -1 Then
		as_Log	= "Erro ao buscar o controle na tabela interface_sap. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle_pai)+". Erro: "+SqlCa.sqlErrText
		Return False
	End If	
	
	uo_ge473_comum lo_Comum
	lo_Comum = Create uo_ge473_comum
			
	If lo_Comum.of_processa_carrega_dados(ll_Controle_filho, 39, ref as_Log) Then		
		For ll_Linha = 1 To lo_Comum.ids_lista_registros.RowCount()

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
				ll_quantidade = lo_Comum.ids_lista_registros.Object.qt_vinculo[ll_Linha]
			End If
				
			Select cd_promocao_sos
			Into :ll_Achou
			from promocao_sos_vinculo
			where cd_promocao_sos = :il_codigo_promocao
				and nr_vinculo = :ll_vinculo
			Using SqlCa;

			Choose Case SqlCa.SqlCode
				Case 0
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
					
				Case 100
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

				Case -1	
					as_Log	= "Erro ao localizar promocao_sos_vinculo. Erro: "+SqlCa.sqlErrText
					Return False					
			End Choose										
		Next		
		//Verifica exclusao
		If lo_Comum.ids_lista_registros.RowCount() > 0 Then
			ids_promocao_vinculo.Reset()
			ids_promocao_vinculo.Retrieve(il_codigo_promocao)
	
			For ll_linha = 1 To ids_promocao_vinculo.RowCount()				
	
				ll_vinculo = ids_promocao_vinculo.Object.nr_vinculo [ll_LInha]
				
				ll_find	= lo_Comum.ids_lista_registros.Find ("nr_vinculo = " + String(ll_vinculo) , 1 , lo_Comum.ids_lista_registros.RowCount())
												 
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
	If IsValid(lo_Comum) Then Destroy(lo_Comum)
End Try	

Return True
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

ids_produto_promocao_cad = Create dc_uo_ds_base
ids_produto_promocao_cad.of_ChangeDataObject("ds_ge473_produto_promocao_cad")

ids_promocao_filial_cad = Create dc_uo_ds_base
ids_promocao_filial_cad.of_ChangeDataObject("ds_ge473_promocao_filial")

ids_promocao_vinculo = Create dc_uo_ds_base
ids_promocao_vinculo.of_ChangeDataObject("ds_ge473_promocao_sos_vinculo")

ids_promocao_vinc_prd = Create dc_uo_ds_base
ids_promocao_vinc_prd.of_ChangeDataObject("ds_ge473_promocao_sos_vinculo_prd")

end event

event destructor;Destroy(io_Comum)
Destroy ids_produto_promocao_cad
Destroy ids_promocao_filial_cad
Destroy ids_promocao_vinculo
Destroy ids_promocao_vinc_prd
end event

