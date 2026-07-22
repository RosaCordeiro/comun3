HA$PBExportHeader$uo_ge473_fornecedor_divisao.sru
forward
global type uo_ge473_fornecedor_divisao from nonvisualobject
end type
end forward

global type uo_ge473_fornecedor_divisao from nonvisualobject
end type
global uo_ge473_fornecedor_divisao uo_ge473_fornecedor_divisao

type variables
uo_ge470_sap_comum io_sap_comum

uo_ge473_comum	io_Comum

String				is_cd_fornecedor_sap,&
					is_cd_fornecedor_legado,&
					is_grupo_comprador_sap,&
					is_nr_matricula_comprador,&
					is_nm_divisao,&
					is_cd_condicao_pagamento_sap
					
Long				il_nr_divisao,&
					il_cd_condicao_pagamento

Datetime			idt_dh_inclusao

dc_uo_ds_base ids_produtos

/**/

Boolean 	ib_execucao_simultanea=false
Long 		il_tabela_pai = 149
Long 		il_tabela_filho = 150
Long 		il_nr_requisicao
String	is_de_chave_acesso_sap

end variables

forward prototypes
public subroutine of_processa_atualizacao ()
public function boolean of_atualiza_fornecedor_divisao (long al_controle)
public function boolean of_inicializa_variaveis (ref string as_log)
public function boolean of_insere_fornecedor_divisao (boolean ab_cadastro_novo, ref string as_log)
public function boolean of_verifica_cadastro_novo (ref boolean ab_cadastro_novo, ref string as_log)
public function boolean of_valida_carrega_dados (ref string as_log)
public function boolean of_atualiza_produto_central (long as_produto_legado, ref string as_log)
public function boolean of_atualiza_fornecedor_divisao_produto (long al_controle_pai, ref string as_log)
public function boolean of_atualiza_comprador_agrupamentos (ref string as_log)
public function boolean of_atualiza_produto_geral (long al_produto_legado, string as_fornecedor_legado, ref string as_log)
public function boolean of_existe_controle_filho (long al_controle_pai, ref string as_log)
public function boolean of_atualiza_fornecedor_divisao_sem_prod (long al_controle_pai, ref string as_log)
end prototypes

public subroutine of_processa_atualizacao ();Long ll_Linhas, ll_Linha, ll_nr_controle, ll_controles_gerando

dc_uo_ds_base lds 

Try 
	
	lds  = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject('ds_ge473_lista_forn_div', False) Then 
		gvo_aplicacao.of_grava_log("Interface Fornecedor Divis$$HEX1$$e300$$ENDHEX$$o - Erro alterar a DS [ds_ge473_lista_forn_div] - uo_ge473_fornecedor_divisao.of_processa_atualizacao" )
		Return
	End If
	
	ll_Linhas = lds.Retrieve()
	
	If ll_Linhas > 0 Then
		For ll_Linha = 1 To ll_Linhas
			
			uo_ge473_fornecedor_divisao lo_Fornecedor_Div
			Try
				lo_Fornecedor_Div	= Create uo_ge473_fornecedor_divisao
				lo_Fornecedor_Div.of_atualiza_fornecedor_divisao(lds.Object.nr_controle[ll_Linha])
			Finally
				Destroy(lo_Fornecedor_Div)
			End Try		
			
		Next
	ElseIf ll_Linhas < 0 Then
		gvo_aplicacao.of_grava_log("Interface Fornecedor Divis$$HEX1$$e300$$ENDHEX$$o - Erro ao recuperar os dados da DS [ds_ge473_lista_forn_div] - uo_ge473_fornecedor_divisao.of_processa_atualizacao.")
	End If	

Finally
	Destroy lds
End try
end subroutine

public function boolean of_atualiza_fornecedor_divisao (long al_controle);dc_uo_ds_base lds

Boolean	lb_Sucesso = False
Boolean	lb_Cadastro_Novo

Long	ll_Linhas,&
		ll_Linha
		
Long ll_Achou, ll_Nr_Item
		
String	ls_Coluna,&
		ls_Vl_Item,&
		ls_Obrig		
		
String ls_Log

Select count(*)
Into :ll_Achou
From 	interface_sap i
Where i.cd_tabela = :il_Tabela_pai
	and nr_controle = :al_controle
	 and id_situacao in ('C', 'E')
	and dh_processamento is null
Using SqlCa;

If SqlCa.sqlcode = -1 Then
	io_Comum.of_grava_erro(al_controle, 175, "Erro ao verificar controle na tabela interface_sap. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle)+". Erro: "+SqlCa.sqlErrText)
	Return False
End If

If ll_Achou = 0 Then Return True

Try
	lds		= Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject('ds_ge473_lista_valores', False) Then 
		ls_Log = "Erro ao alterar a DW [ds_ge473_lista_valores]. Objeto [uo_ge473_fornecedor_divisao], fun$$HEX2$$e700e300$$ENDHEX$$o [of_atualiza_fornecedor_divisao]."
		Return False
	End If
	
	ll_Linhas = lds.Retrieve(al_controle)
	
	If ll_Linhas < 0 Then
		ls_Log = "Erro no retrieve a DW [ds_ge473_lista_valores]. Objeto [uo_ge473_fornecedor_divisao], fun$$HEX2$$e700e300$$ENDHEX$$o [of_atualiza_fornecedor_divisao]."
		Return False
	End If
	
	If ll_Linhas = 0 Then
		ls_Log = "N$$HEX1$$e300$$ENDHEX$$o foi localizado nenhum registro no retrieve a DW [ds_ge473_lista_valores]. Objeto [uo_ge473_fornecedor_divisao], fun$$HEX2$$e700e300$$ENDHEX$$o [of_atualiza_fornecedor_divisao]."
		Return False
	End If	
	
	If Not This.of_Inicializa_Variaveis(Ref ls_Log) Then Return False

	For ll_Linha = 1 To ll_Linhas
		ls_Coluna 	= lds.Object.cd_coluna		[ll_Linha]
		ls_Vl_Item	= Upper(lds.Object.vl_item	[ll_Linha])
		ls_Obrig		= lds.Object.id_obrigatorio	[ll_Linha]
		ll_Nr_Item 	= lds.Object.nr_item			[ll_Linha]
		
		If ll_Nr_Item > 1 Then
			ls_Log = 'Existe mais de um item para o header do controle.'
			Return False
		End If

		If Trim(ls_Vl_Item) = "" Then
			SetNull(ls_Vl_Item)
		End If
		
		If Not io_Comum.of_verifica_obrigatoriedade_campo(ls_Coluna, ls_Obrig, ls_Vl_Item, Ref ls_Log) Then
			Return False
		End if
		
		Choose Case  Lower(ls_Coluna)
			Case 'cd_fornecedor_sap'
				is_cd_fornecedor_sap = ls_Vl_Item
				
			Case 'nr_subsortimento'
				il_nr_divisao = long(ls_Vl_Item)
				
			Case 'de_subsortimento'
				is_nm_divisao = ls_Vl_Item
				
			Case 'cd_grupo_comprador'
				is_grupo_comprador_sap = ls_Vl_Item
				
			Case 'cd_condicao_pagto'
				is_cd_condicao_pagamento_sap = ls_Vl_Item
				
			Case 'dh_inclusao'
				idt_dh_inclusao = datetime(ls_Vl_Item)
		End Choose
		
	Next
	
	//Se n$$HEX1$$e300$$ENDHEX$$o tiver um numero de divisao, vai considerar somente o apagar 
	If IsNull(il_nr_divisao) Then
		
		If This.of_atualiza_fornecedor_divisao_produto(al_controle, Ref ls_Log) Then
			lb_Sucesso	= True
		End If
		
	Else
	
		If This.of_Valida_Carrega_Dados(Ref ls_Log) Then
			If This.of_verifica_cadastro_novo(Ref lb_Cadastro_Novo, Ref ls_Log) Then
				If This.of_insere_fornecedor_divisao(lb_Cadastro_Novo, Ref ls_Log) Then
					If This.of_existe_controle_filho( al_controle, Ref ls_Log) Then
						If This.of_atualiza_fornecedor_divisao_produto(al_controle, Ref ls_Log) Then
							lb_Sucesso	= True
						End If
					Else						
						If This.of_atualiza_fornecedor_divisao_sem_prod(al_controle, Ref ls_Log) Then
							lb_Sucesso	= True
						End If
					End If
				End if
			End if
		End If
		
	End If
	
	If Not io_Comum.of_Muda_Situacao_Interface(al_Controle, Ref ls_Log) Then 
		lb_Sucesso = False
		Return False
	End If
	
//Catch ( runtimeerror  lo_rte )
//	ls_Log = "Objeto [uo_ge473_fornecedor_divisao], fun$$HEX2$$e700e300$$ENDHEX$$o [of_atualiza_fornecedor_divisao]. Erro: "+lo_rte.GetMessage( )
//	Return False		
	
Finally
	If lb_Sucesso Then
		SqlCa.of_Commit()
	Else
		SqlCA.of_RollBack()
		io_Comum.of_grava_erro(al_controle, 175, ls_Log)
	End If
		
	Destroy(lds)
	
End Try

Return lb_Sucesso
end function

public function boolean of_inicializa_variaveis (ref string as_log);Try

	SetNull(is_cd_fornecedor_sap)
	SetNull(is_cd_fornecedor_legado)
	setNull(is_grupo_comprador_sap)
	setNull(is_nr_matricula_comprador)
	setNull(is_nm_divisao)
	setNull(il_nr_divisao)
	setNull(is_cd_condicao_pagamento_sap)
	setNull(il_cd_condicao_pagamento)
	setNull(idt_dh_inclusao)

Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro ao ao iniciar as vari$$HEX1$$e100$$ENDHEX$$veis. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try

Return True
end function

public function boolean of_insere_fornecedor_divisao (boolean ab_cadastro_novo, ref string as_log);Try	
	If ab_cadastro_novo Then
		Insert Into fornecedor_divisao(	cd_fornecedor,
												nr_divisao,
												nm_divisao,
												nr_matricula_comprador,
												cd_condicao_pagamento,
												dh_inclusao )
		Values(	:is_cd_fornecedor_legado,
					:il_nr_divisao,
					:is_nm_divisao,
					:is_nr_matricula_comprador,
					:il_cd_condicao_pagamento,
					getdate() )
		Using SqlCa;
		
		If SqlCa.sqlcode = -1 Then
			as_Log	= "Erro no insert da tabela 'fornecedor_divisao'. Erro: "+SqlCa.sqlErrText
			Return False
		End If
		
		If SqlCa.sqlnrows <> 1 Then
			as_Log	= "Erro no insert da tabela 'fornecedor_divisao'. Deveria ter inserido um registro mas inseriu "+String(SqlCa.sqlnrows)+" registro(s)."
			Return False
		End If
	Else
		
		If is_nm_divisao = 'NOME DO SUB. NAO INFORMADO.' Then
			
			Select fd.nm_divisao
				Into :is_nm_divisao
			From fornecedor_divisao fd 
				inner join fornecedor f 
			on f.cd_fornecedor = fd.cd_fornecedor
				Where fd.nr_divisao 		= :il_nr_divisao
				and f.cd_fornecedor = :is_cd_fornecedor_legado
			Using SqlCa;			
			
			If SqlCa.sqlcode = -1 Then
				as_Log	= "Erro na consulta da tabela 'fornecedor_divisao'. Erro: "+SqlCa.sqlErrText
				Return False
			End If
		
		End if
		
		Update fornecedor_divisao
		Set	cd_fornecedor 				= :is_cd_fornecedor_legado,
				nr_divisao 					= :il_nr_divisao,
				nm_divisao 					= :is_nm_divisao,
				nr_matricula_comprador 	= :is_nr_matricula_comprador,
				cd_condicao_pagamento = :il_cd_condicao_pagamento
				//dh_inclusao 					= getdate()
		Where cd_fornecedor = :is_cd_fornecedor_legado
					and nr_divisao = :il_nr_divisao
		Using SqlCa;
		
		If SqlCa.sqlcode = -1 Then
			as_Log	= "Erro no update da tabela 'fornecedor_divisao'. Erro: "+SqlCa.sqlErrText
			Return False
		End If
		
		If SqlCa.sqlnrows <> 1 Then
			as_Log	= "Erro no update da tabela 'fornecedor_divisao'. Deveria ter atualizado um registro mas atualizou "+String(SqlCa.sqlnrows)+" registro(s)."
			Return False
		End If
	End If
	
Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_insere_fornecedor_divisao'. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try	

Return True
end function

public function boolean of_verifica_cadastro_novo (ref boolean ab_cadastro_novo, ref string as_log);Long ll_Achou

SELECT count(*) 
INTO :ll_Achou
FROM fornecedor_divisao
WHERE cd_fornecedor = :is_cd_fornecedor_legado
			and nr_divisao = :il_nr_divisao
Using SqlCa;
	
Choose Case SqlCa.SqlCode
	Case 0
		If ll_Achou > 0 Then 
			ab_cadastro_novo = False
		Else
			ab_cadastro_novo = True
		End If

	Case -1
		as_Log = "Erro ao verificar cadastro'. Erro: "+SqlCa.sqlErrText
		Return False
		
End Choose

Return True
end function

public function boolean of_valida_carrega_dados (ref string as_log);uo_ge473_comum lo_comum

Try
	lo_comum	= Create uo_ge473_comum
	
	If IsNull(is_cd_fornecedor_sap) OR (Not IsNull(is_cd_fornecedor_sap) and Trim(is_cd_fornecedor_sap) = "") Then 
		as_log = 'C$$HEX1$$f300$$ENDHEX$$digo fornecedor esta vazio, n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ possivel prosseguir.'
		Return False
	End If
	
	If IsNull(is_grupo_comprador_sap) Then 
		as_log = 'Grupo comprador esta vazio, n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ possivel prosseguir.'
		Return False
	End If
	
//	If IsNull(il_nr_divisao) Then 
//		as_log = 'Numero divis$$HEX1$$e300$$ENDHEX$$o esta vazio, n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ possivel prosseguir.'
//		Return False
//	End If
	
	If IsNull(is_nm_divisao) Or Trim(is_nm_divisao) = "" Then 
		is_nm_divisao = "NOME DO SUB. NAO INFORMADO."
	End If
	
	//Carrega dados legado
	SetNull(is_cd_fornecedor_legado)
	If Not lo_comum.of_localiza_codigo_fornecedor_legado( is_cd_fornecedor_sap, Ref is_cd_fornecedor_legado, Ref as_Log) Then
		Return False
	End If
	
	SetNull(is_nr_matricula_comprador)
	If Not lo_comum.of_localiza_codigo_comprador_legado( is_grupo_comprador_sap, Ref is_nr_matricula_comprador, Ref as_Log) Then
		Return False
	End If
	
	SetNull(il_cd_condicao_pagamento)
	If Not lo_comum.of_localiza_condicao_pagto_legado( is_cd_condicao_pagamento_sap, Ref il_cd_condicao_pagamento, Ref as_Log) Then
		Return False
	End If
	
Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_valida_dados' no objeto uo_ge473_fornecedor_divisao. Erro: "+lo_rte.GetMessage( )
	Return False		
	
Finally 
	Destroy(lo_comum)
End Try

Return True
end function

public function boolean of_atualiza_produto_central (long as_produto_legado, ref string as_log);Try	
	Update produto_central
	Set	nr_matricula_comprador = :is_nr_matricula_comprador
	Where cd_produto = :as_produto_legado
	Using SqlCa;
	
	If SqlCa.sqlcode = -1 Then
		as_Log	= "Erro no update da tabela 'produto_central'. Erro: "+SqlCa.sqlErrText
		Return False
	End If

Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_atualiza_produto_central'. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try	

Return True
end function

public function boolean of_atualiza_fornecedor_divisao_produto (long al_controle_pai, ref string as_log);Long ll_Linhas
Long ll_Linha
Long ll_Controle
Long ll_For
Long ll_Controle_filho

String ls_Coluna
String ls_Vl_Item
String ls_Obrig

Long ll_Produto_Legado
String ls_Produto_Sap
String ls_Id_Apagar

Long ll_Achou, ll_Contador = 0

Try
	
	SELECT nr_controle
	Into  :ll_Controle_filho
	FROM interface_sap  i 
	Where i.cd_tabela = :il_tabela_filho
		and i.cd_tabela_pai = :il_tabela_pai
		and i.nr_controle_pai = :al_controle_pai
	Using SqlCa;
	
	If SqlCa.sqlcode = -1 Then
		as_Log	= "Erro ao verificar o nr controle filho na tabela interface_sap. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle_pai)+". Erro: "+SqlCa.sqlErrText
		Return False
	End If
	
	If ll_Controle_filho < 0 OR isNull(ll_Controle_filho) Then 
		as_Log	= "Numero de controle filho inv$$HEX1$$e100$$ENDHEX$$lido, sem controle filho n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ possivel prosseguir."
		Return False
	End If
	
	uo_ge473_comum lo_Comum2
	lo_Comum2 = Create uo_ge473_comum
	
	If lo_Comum2.of_processa_carrega_dados(ll_Controle_filho , ref as_log) Then
		
		ll_Linhas = lo_Comum2.ids_lista_registros.RowCount()
		
		If isvalid(w_aguarde_3) Then
			w_aguarde_3.uo_progress_2.of_reset()
			w_aguarde_3.uo_progress_2.of_setmax(ll_linhas)
		End if
		
		For ll_for = 1 To ll_linhas
			
			If ll_Contador = 100 Then 
				ll_Contador = 0
				SqlCa.of_commit()
			End If
			
			SetNull(ls_Produto_Sap)
			SetNull(ls_Id_Apagar)
			
			ls_Produto_Sap 	=  lo_Comum2.ids_lista_registros.Object.cd_produto_sap	[ll_for]
			ls_Id_Apagar 		=  lo_Comum2.ids_lista_registros.Object.id_apagar			[ll_for]
			
			SetNull(ll_Produto_Legado)
			If Not lo_Comum2.of_localiza_codigo_produto_legado( ls_Produto_Sap, Ref ll_Produto_Legado, Ref as_Log) Then
				Return False
			End If
			
			If ll_Produto_Legado = 0 Or IsNull(ll_Produto_Legado) Then 
				as_log = 'Produto legado invalido, n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ possivel continuar.'
				Return False
			End If
			
			If Not IsNull(ls_Id_Apagar) Then
				Delete From fornecedor_divisao_produto
				WHERE cd_produto = :ll_Produto_Legado
				Using SqlCa;
				
				If SqlCa.SqlCode <> 0 Then
					as_Log = "Erro ao deletar fornecedor_divisao_produto. Erro: "+SqlCa.sqlErrText
					Return False
				End If
			Else
				If Not IsNull(il_nr_divisao) Then
					SELECT count(*) 
					INTO :ll_Achou
					FROM fornecedor_divisao_produto
					WHERE cd_produto = :ll_Produto_Legado
					Using SqlCa;
						
					Choose Case SqlCa.SqlCode
						Case 0
							If Not of_atualiza_produto_geral(ll_produto_legado, is_cd_fornecedor_legado, REF as_log) Then
								Return False
							End If
				
							If ll_Achou > 0 Then
								Delete From fornecedor_divisao_produto
								WHERE cd_produto = :ll_Produto_Legado
								Using SqlCa;
								
								If SqlCa.SqlCode <> 0 Then
									as_Log = "Erro ao deletar fornecedor_divisao_produto para nova inser$$HEX2$$e700e300$$ENDHEX$$o. Erro: "+SqlCa.sqlErrText
									Return False
								End If
								
								Insert Into fornecedor_divisao_produto(	cd_fornecedor,
														nr_divisao,
														cd_produto,
														dh_inclusao )
								Values(	:is_cd_fornecedor_legado,
											:il_nr_divisao,
											:ll_Produto_Legado,
											getdate() )
								Using SqlCa;
								
								If SqlCa.SqlCode <> 0 Then
									as_Log = "Erro ao inserir fornecedor_divisao_produto . Erro: "+SqlCa.sqlErrText
									Return False
								End If
	
							Else
								Insert Into fornecedor_divisao_produto(	cd_fornecedor,
														nr_divisao,
														cd_produto,
														dh_inclusao )
								Values(	:is_cd_fornecedor_legado,
											:il_nr_divisao,
											:ll_Produto_Legado,
											getdate() )
								Using SqlCa;
								
								If SqlCa.SqlCode <> 0 Then
									as_Log = "Erro ao inserir fornecedor_divisao_produto. Erro: "+SqlCa.sqlErrText
									Return False
								End If
							End If
						
						Case -1
							as_Log = "Erro ao verificar produto na tabela fornecedor_divisao_produto. Erro: "+SqlCa.sqlErrText
							Return False
							
					End Choose
				Else
					//as_Log = "Numero de divis$$HEX1$$e300$$ENDHEX$$o invalido para adi$$HEX2$$e700e300$$ENDHEX$$o de produtos. Fun$$HEX2$$e700e300$$ENDHEX$$o of_atualiza_fornecedor_divisao_produto."
					//Return False
					Continue
				End If
				
				If Not of_atualiza_produto_central(ll_Produto_Legado, Ref as_Log) Then
					Return False
				End If
				
				If Not of_atualiza_comprador_agrupamentos(Ref as_Log) Then
					Return False
				End If
				
			End If
		
			ll_Contador++
		Next	
		
	End If

Catch ( runtimeerror  lo_rte )
	as_Log = "Objeto [uo_ge473_fornecedor_divisao], fun$$HEX2$$e700e300$$ENDHEX$$o [of_atualiza_fornecedor_divisao_produto]. Erro: "+lo_rte.GetMessage( )
	Return False		
	
Finally
	Destroy lo_Comum2
	
End Try

Return True
end function

public function boolean of_atualiza_comprador_agrupamentos (ref string as_log);Try	
	UPDATE agrupamento_dev_compra 
	SET nr_matricula_comprador = :is_nr_matricula_comprador
	where cd_fornecedor = :is_cd_fornecedor_legado
		and nr_divisao_fornecedor = :il_nr_divisao
		and id_situacao = 'A'
	Using SqlCa;
	
	If SqlCa.sqlcode = -1 Then
		as_Log	= "Erro no update da tabela 'agrupamento_dev_compra'. Erro: "+SqlCa.sqlErrText
		Return False
	End If

Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_atualiza_comprador_agrupamentos'. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try	

Return True
end function

public function boolean of_atualiza_produto_geral (long al_produto_legado, string as_fornecedor_legado, ref string as_log);Try	
	Update produto_geral
	Set	cd_fornecedor_usual = :as_fornecedor_legado
	Where cd_produto = :al_produto_legado
	Using SQLCA;
	
	If SqlCa.sqlcode = -1 Then
		as_Log	= "Erro no update da tabela 'produto_geral' para atualizar o fornecedor usual. Erro: "+SqlCa.sqlErrText
		Return False
	End If

Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_atualiza_produto_geral'. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try	

Return True
end function

public function boolean of_existe_controle_filho (long al_controle_pai, ref string as_log);Long ll_Controle_filho

SELECT nr_controle
Into  :ll_Controle_filho
FROM interface_sap  i 
Where i.cd_tabela = :il_tabela_filho
	and i.cd_tabela_pai = :il_tabela_pai
	and i.nr_controle_pai = :al_controle_pai
Using SqlCa;

If SqlCa.sqlcode = -1 Then
	as_Log	= "Erro ao verificar o nr controle filho na tabela interface_sap. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle_pai)+". Erro: "+SqlCa.sqlErrText
	Return False
End If

If ll_Controle_filho <= 0 OR isNull(ll_Controle_filho) Then 
	Return False
Else
	Return True
End If
end function

public function boolean of_atualiza_fornecedor_divisao_sem_prod (long al_controle_pai, ref string as_log);Long ll_Linhas
Long ll_Linha
Long ll_Produto_Legado

dc_uo_ds_base lds_for_prd 

Try 
	
	lds_for_prd  = Create dc_uo_ds_base
	
	If Not lds_for_prd.of_ChangeDataObject('ds_ge473_fornecedor_divisao_produto', False) Then 
		as_log = "Interface Fornecedor Divis$$HEX1$$e300$$ENDHEX$$o - Erro alterar a DS [ds_ge473_fornecedor_divisao_produto] - uo_ge473_fornecedor_divisao.of_atualiza_fornecedor_divisao_sem_prod" 
		Return false
	End If
	
	If il_nr_divisao <= 0 or isnull(il_nr_divisao) Then
		as_log = "Interface Fornecedor Divis$$HEX1$$e300$$ENDHEX$$o - Divis$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ nula, n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ possivel prosseguir."
		Return False
	End If
	
	ll_Linhas = lds_for_prd.Retrieve(is_cd_fornecedor_legado, il_nr_divisao)
	
	For ll_linha = 1 to ll_Linhas
		
		setnull(ll_produto_legado)
		
		ll_produto_legado = lds_for_prd.object.cd_produto[ll_linha]
		
		If isnull(ll_produto_legado) or ll_produto_legado = 0 then
			as_log = 'Erro ao encontrar codigo do produto. Fun$$HEX2$$e700e300$$ENDHEX$$o of_atualiza_fornecedor_divisao_sem_prod.'
			return false
		end if
	
		If Not of_atualiza_produto_central(ll_Produto_Legado, Ref as_Log) Then
			Return False
		End If
		
		If Not of_atualiza_comprador_agrupamentos(Ref as_Log) Then
			Return False
		End If
		
	Next
	
Catch ( runtimeerror  lo_rte )
	as_Log = "Objeto [uo_ge473_fornecedor_divisao], fun$$HEX2$$e700e300$$ENDHEX$$o [of_atualiza_fornecedor_divisao_sem_prod]. Erro: "+lo_rte.GetMessage( )
	Return False		
	
Finally
	if isvalid(lds_for_prd) then destroy (lds_for_prd)
End Try

Return True
end function

on uo_ge473_fornecedor_divisao.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge473_fornecedor_divisao.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;//ids_ean = Create dc_uo_ds_base
//ids_ean.of_ChangeDataObject("ds_ge473_codigo_barras")
//
//ids_ean_cad = Create dc_uo_ds_base
//ids_ean_cad.of_ChangeDataObject("ds_ge473_codigo_barras_cad")
//
//ids_ean_cadastrados = Create dc_uo_ds_base
//ids_ean_cadastrados.of_ChangeDataObject("ds_ge473_codigo_barras_cadastrados")

io_sap_comum = Create uo_ge470_sap_comum

io_Comum	= Create uo_ge473_comum	

// Fecha o arquivo de log para n$$HEX1$$e300$$ENDHEX$$o dar erro quando tela do EX for utilizar o objeto, a abetura esta no construtor.
FileClose (io_sap_comum.ii_log)

end event

event destructor;//Destroy ids_ean
//Destroy ids_ean_cad
//Destroy ids_ean_cadastrados
Destroy io_sap_comum
Destroy io_Comum
end event

