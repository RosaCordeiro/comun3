HA$PBExportHeader$uo_ge259_pedido_almoxarifado.sru
forward
global type uo_ge259_pedido_almoxarifado from nonvisualobject
end type
end forward

global type uo_ge259_pedido_almoxarifado from nonvisualobject
end type
global uo_ge259_pedido_almoxarifado uo_ge259_pedido_almoxarifado

type variables
Long il_Pedido[]
end variables

forward prototypes
public function boolean of_gera_pedido_distribuidora ()
public function boolean of_email_log (string as_mensagem)
private function boolean of_muda_situacao_pedido_almoxarifado (long al_filial, long al_pedido_distribuidora)
public function boolean of_centro_custos (long al_filial, long al_pedido, boolean ab_pedido_almoxarifado, ref long al_centro_custos, ref string as_erro)
public function boolean of_localiza_proximo_pedido_almoxarifado (long al_filial, ref long al_pedido, ref string as_erro)
private function boolean of_insere_pedido_distribuidora_almox (long al_filial, long al_pedido_distribuidora, long al_centro_custo, long al_centro_custo_entrega, string as_tipo_pedido)
public function boolean of_insere_pedido_distribuidora_produto (long al_filial, long al_pedido_distribuidora, long al_centro_custo, long al_centro_custo_entrega, string as_tipo_pedido)
public function boolean of_insere_pedido_almoxarifado_falta (long al_filial, long al_pedido, boolean ab_pedido_almoxarifado, ref string as_erro, string as_tipo_pedido, long al_pedido_almox, string as_dados_adicionais)
private function boolean of_insere_pedido_distribuidora (long al_filial, decimal adc_valor_pedido, long al_centro_custo_entrega, ref long al_proximo_pedido)
private function boolean of_insere_pedido_distribuidora_almox_cd (long al_filial, long al_pedido_distribuidora, long al_centro_custo, long al_centro_custo_entrega, string as_tipo_pedido, ref long al_cd_pedido_almox_cd)
public function boolean of_insere_pedido_distribuidora_produt_cd (long al_filial, long al_pedido_distribuidora, long al_centro_custo, long al_centro_custo_entrega, string as_tipo_pedido, long al_cd_pedido_almox_cd)
public function boolean of_grava_log_exp_mov_almox_cd (long al_cd_produto, long al_qt_movto, ref string as_log)
end prototypes

public function boolean of_gera_pedido_distribuidora ();dc_uo_ds_Base				lds_Filiais
dc_uo_ds_Base				lds_Filiais_Cd
dc_uo_ds_Base				lds_Lista_Filiais
uo_ge259_pedido_filial	lo_Pedido_Filial

Long 	ll_Linhas,&
		ll_Linha,&
		ll_Filial,&
		ll_Proximo_Pedido_Distribuidora,&
		ll_Centro_Custo,&
		ll_Centro_Custo_Entrega,&
		ll_Linha_Filial,&
		ll_Linhas_Filial,&
		ll_Filial_Lista,&
		ll_Linha_Pedido,&
		ll_Centro_Custo_Lista,&
		ll_Centro_Custo_Entrega_Lista,&
		ll_Cd_Pedido_Almox_Cd

Long ll_Null[]
		
Decimal ldc_Valor_Pedido

Boolean lb_Sucesso
Boolean lb_Pedido_Almoxarifado 	= True
Boolean lb_Pedido_Controlado 		= False
Boolean lb_Almox_Cd = False
Date ldh_Data_Nula

SetNull(ldh_Data_Nula)

String ls_Tipo_Pedido

Try
	lds_Filiais 			= Create dc_uo_ds_Base
	lds_Lista_Filiais		= Create dc_uo_ds_Base
	lds_Filiais_Cd		= Create dc_uo_ds_Base
	lo_Pedido_Filial 	= Create uo_ge259_pedido_filial
	
	Open(w_aguarde)
	
	If Not lds_Lista_Filiais.of_ChangeDataObject("ds_ge259_filiais_pedido_almox_lista_novo") Then
		of_email_log("Erro no changeDataObject da ds_ge259_filiais_pedido_almox_lista")
		Return False
	End If
	
	If Not lds_Filiais.of_ChangeDataObject("ds_ge259_filiais_com_pedido_almox") Then
		of_email_log("Erro no changeDataObject da ds_ge259_filiais_com_pedido_almox")
		Return False
	End If
	
	//DS especifica para quando for pedido almoxarifado do CD para gerar 1 pedido distribuidora por pedido almox
	If Not lds_Filiais_Cd.of_ChangeDataObject("ds_ge259_filiais_com_pedido_almox_cd") Then
		of_email_log("Erro no changeDataObject da ds_ge259_filiais_com_pedido_almox_cd")
		Return False
	End If
	
	/*Alterado essa fun$$HEX2$$e700e300$$ENDHEX$$o para agrupar os pedidos almoxarifados em um $$HEX1$$fa00$$ENDHEX$$nico pedido distribuidora.
	 *Essa regra n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ utilizada para a filial 2. Essa filial fatura para v$$HEX1$$e100$$ENDHEX$$rios centros de custo impossibilitando o agrupamento.
	 *Tamb$$HEX1$$e900$$ENDHEX$$m foram feitas altera$$HEX2$$e700f500$$ENDHEX$$es nas fun$$HEX2$$e700f500$$ENDHEX$$es of_Insere_Pedido_Distribuidora e of_Insere_Pedido_Distribuidora_Produto. [Nessas fun$$HEX2$$e700f500$$ENDHEX$$es foi criado uma condi$$HEX2$$e700e300$$ENDHEX$$o para n$$HEX1$$e300$$ENDHEX$$o fazer para a filial 2].
	 *Chamado: 474002
	*/
	
	ll_Linhas_Filial = lds_Lista_Filiais.Retrieve()
	
	w_aguarde.uo_Progress.of_SetMax(ll_Linhas_Filial)
	
	If ll_Linhas_Filial > 0 Then
		For ll_Linha_Filial = 1 To ll_Linhas_Filial			
			ll_Filial_Lista						= lds_Lista_Filiais.Object.cd_filial							[ll_Linha_Filial]
			ll_Centro_Custo_Lista				= lds_Lista_Filiais.Object.cd_centro_custo				[ll_Linha_Filial]
			ll_Centro_Custo_Entrega_Lista	= lds_Lista_Filiais.Object.cd_centro_custo_entrega	[ll_Linha_Filial]
			
			//Zera o Array a cada filial
			il_Pedido = ll_Null
			
			w_aguarde.Title = "Filial "+String(ll_Filial_Lista)
			
			//Se for Almolxarifado CD faz retrieve na ds do Cd se n$$HEX1$$e300$$ENDHEX$$o faz retrieve na DS original que ja era usada
			If ll_Filial_Lista = 534 And ll_Centro_Custo_Lista = 100896 And ll_Centro_Custo_Entrega_Lista = 100896 Then 
				ll_Linhas = lds_Filiais_Cd.Retrieve(ll_Filial_Lista)
				//Variavel para controlar os caminhos a seguir se $$HEX1$$e900$$ENDHEX$$ pedido almox cd ou o padr$$HEX1$$e300$$ENDHEX$$o que ja era nas versoes anteriores
				lb_Almox_Cd = True
			Else
				ll_Linhas = lds_Filiais.Retrieve(ll_Filial_Lista)
				lb_Almox_Cd = False
			End If
			
			If ll_Linhas > 0 Then
				For ll_Linha = 1 To ll_Linhas
					If lb_Almox_Cd Then
						ll_Filial						= lds_Filiais_Cd.Object.cd_filial							[ll_Linha]
						ls_Tipo_Pedido				= lds_Filiais_Cd.Object.id_tipo_pedido				[ll_Linha]
						ldc_Valor_Pedido			= lds_Filiais_Cd.Object.vl_total_pedido				[ll_Linha]
						ll_Centro_Custo			= lds_Filiais_Cd.Object.cd_centro_custo				[ll_Linha]
						ll_Centro_Custo_Entrega	= lds_Filiais_Cd.Object.cd_centro_custo_entrega	[ll_Linha]
					Else
						ll_Filial						= lds_Filiais.Object.cd_filial							[ll_Linha]
						ls_Tipo_Pedido				= lds_Filiais.Object.id_tipo_pedido					[ll_Linha]
						ldc_Valor_Pedido			= lds_Filiais.Object.vl_total_pedido				[ll_Linha]
						ll_Centro_Custo			= lds_Filiais.Object.cd_centro_custo				[ll_Linha]
						ll_Centro_Custo_Entrega	= lds_Filiais.Object.cd_centro_custo_entrega	[ll_Linha]
					End If
					
					If IsNull(ldc_Valor_Pedido) Then ldc_Valor_Pedido = 0.00
					
					lb_Sucesso  = False
					
					//Pega o proximo numerto do pedido distribuidora, n$$HEX1$$e300$$ENDHEX$$o depende do numero do pedido almox
					If of_Insere_Pedido_Distribuidora(ll_Filial, ldc_Valor_Pedido, ll_Centro_Custo_Entrega, Ref ll_Proximo_Pedido_Distribuidora) Then
						//Se for pedido almox cd entra nas fun$$HEX2$$e700f500$$ENDHEX$$es novas com _cd onde teve altera$$HEX2$$e700f500$$ENDHEX$$es especificas para tratar cada pedido almox para cada pedido distribuidora 
						If lb_Almox_Cd Then
							SetNull(ll_Cd_Pedido_Almox_Cd)
							If of_Insere_Pedido_Distribuidora_Almox_Cd(ll_Filial, ll_Proximo_Pedido_Distribuidora,ll_Centro_Custo, ll_Centro_Custo_Entrega, ls_Tipo_Pedido, Ref ll_Cd_Pedido_Almox_Cd) Then
								If of_Insere_Pedido_Distribuidora_Produt_Cd(ll_Filial, ll_Proximo_Pedido_Distribuidora, ll_Centro_Custo, ll_Centro_Custo_Entrega, ls_Tipo_Pedido, ll_Cd_Pedido_Almox_Cd) Then
									If of_Muda_Situacao_Pedido_Almoxarifado(ll_Filial, ll_Proximo_Pedido_Distribuidora) Then						
										SqlCa.of_Commit()
										
										lb_Sucesso = True

									End If
								End If
							End If
						//Nao $$HEX1$$e900$$ENDHEX$$ pedido almox do CD, faz o que fazia anteriormente/sem altera$$HEX2$$e700f500$$ENDHEX$$es
						Else
							If of_Insere_Pedido_Distribuidora_Almox(ll_Filial, ll_Proximo_Pedido_Distribuidora,ll_Centro_Custo, ll_Centro_Custo_Entrega, ls_Tipo_Pedido) Then
								If of_Insere_Pedido_Distribuidora_Produto(ll_Filial, ll_Proximo_Pedido_Distribuidora, ll_Centro_Custo, ll_Centro_Custo_Entrega, ls_Tipo_Pedido) Then
									If of_Muda_Situacao_Pedido_Almoxarifado(ll_Filial, ll_Proximo_Pedido_Distribuidora) Then						
										SqlCa.of_Commit()
										
										lb_Sucesso = True
																											
										If ll_Filial = 2 Then
											lo_Pedido_Filial.of_Processa_Geracao_Picking(	ll_Filial, &
																										ll_Proximo_Pedido_Distribuidora, &
														/*Ped. Almox = True*/					lb_Pedido_Almoxarifado, &
														/*Ped. Controlado = False*/			lb_Pedido_Controlado,&
														/*Somente controlado, vai nulo*/		ldh_Data_Nula  ) 
										End If
									End If
								End If
							End If				
						End If
					End If
					
					If Not lb_Sucesso Then Return False
					
				Next
			End If
			
			ll_Proximo_Pedido_Distribuidora = 0
			
			If ll_Filial <> 2 Then
				For ll_Linha_Pedido = 1 To UpperBound(il_Pedido) 
					ll_Proximo_Pedido_Distribuidora = il_Pedido[ ll_Linha_Pedido ]  
					lo_Pedido_Filial.of_Processa_Geracao_Picking(ll_Filial, ll_Proximo_Pedido_Distribuidora, lb_Pedido_Almoxarifado,lb_Pedido_Controlado, ldh_Data_Nula ) 
				Next
			End If
			
			w_aguarde.uo_Progress.of_SetProgress(ll_Linha_Filial)
		Next
	End If
Finally
	Destroy(lds_Filiais)
	Destroy(lds_Filiais_Cd)
	Destroy(lds_Lista_Filiais)
	Destroy(lo_Pedido_Filial)
	Close(w_aguarde)
End Try

Return True
end function

public function boolean of_email_log (string as_mensagem);String ls_Anexo[]
String ls_Mensagem_Log

If Not gf_ge202_envia_email_automatico(48, "Gera$$HEX2$$e700e300$$ENDHEX$$o Pedido Distribuidora (Impressos)", as_Mensagem, ls_Anexo) Then
	Return False
End If

Return True
end function

private function boolean of_muda_situacao_pedido_almoxarifado (long al_filial, long al_pedido_distribuidora);String ls_Erro

Update pedido_almoxarifado
set id_situacao = 'S'
Where cd_filial = :al_Filial
	and nr_pedido in (select nr_pedido_almoxarifado
							from pedido_distribuidora_almox
							where cd_filial = :al_Filial
								and nr_pedido_distribuidora = :al_Pedido_Distribuidora)
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_Erro = "Filial: "+String(al_Filial)+"~rErro ao mudar a situa$$HEX2$$e700e300$$ENDHEX$$o do pedido almoxarifado para 'Em Separa$$HEX2$$e700e300$$ENDHEX$$o'." + SqlCa.sqlErrText
	SqlCa.of_Rollback()
	//MessageBox("Erro", ls_Erro)
	of_email_log(ls_Erro)
	Return False
End If

Return True
end function

public function boolean of_centro_custos (long al_filial, long al_pedido, boolean ab_pedido_almoxarifado, ref long al_centro_custos, ref string as_erro);
If ab_Pedido_Almoxarifado Then
	select cd_centro_custo
	Into :al_Centro_Custos
	from pedido_almoxarifado
	where cd_filial = :al_Filial
	and nr_pedido = :al_Pedido
	Using SqlCa;
Else
	select top 1 cd_centro_custo
	Into :al_Centro_Custos
	from pedido_almoxarifado
	where cd_filial = :al_Filial
	and nr_pedido in (select nr_pedido_almoxarifado
							from pedido_distribuidora_almox
							where cd_filial = :al_Filial
							and nr_pedido_distribuidora = :al_Pedido)
	Using SqlCa;
End If

Choose Case SqlCa.SqlCode
	Case 100
		as_Erro = "Filial: "+String(al_Filial)+", Pedido: "+String(al_Pedido)+" ~rN$$HEX1$$e300$$ENDHEX$$o foi localizado o centro de custos do pedido almoxarifado ao inserir um novo pedido com as faltas:" + SqlCa.sqlErrText
		SqlCa.of_Rollback()
		Return False
		
	Case -1 
		as_Erro = "Filial: "+String(al_Filial)+", Pedido: "+String(al_Pedido)+" ~rErro ao localizar o centro de custos do pedido almoxarifado ao inserir um novo pedido com as faltas:" + SqlCa.sqlErrText
		SqlCa.of_Rollback()
		Return False
End Choose

Return True
end function

public function boolean of_localiza_proximo_pedido_almoxarifado (long al_filial, ref long al_pedido, ref string as_erro);String ls_Erro

//2		-> MATRIZ - NOVE DE MARCO
//809	-> FARMAGORA
//534 -> CD (novo pedido almoxarifado)

If (al_Filial = 2) or (al_Filial = 809) or (al_Filial = 534) Then
	select coalesce(max(nr_pedido), 0) + 1 
	Into :al_Pedido
	from pedido_almoxarifado 
	where cd_filial = :al_Filial
	Using SqlCa;
Else
	select coalesce(max(nr_pedido), 0) + 1 
	Into :al_Pedido
	from pedido_almoxarifado 
	where  cd_filial 	= :al_Filial
		and nr_pedido	>= 30000
	Using SqlCa;
End If

Choose Case SqlCa.SqlCode
	Case 0
		
	Case 100
		SqlCa.of_Rollback()
		as_Erro = "Filial: "+String(al_Filial)+" Pedido "+String(al_pedido)+" ~rN$$HEX1$$e300$$ENDHEX$$o foi localizado o pr$$HEX1$$f300$$ENDHEX$$ximo pedido almoxarifado que seria criado para inserir as faltas:"
		Return False
	Case -1
		as_Erro = "Filial: "+String(al_Filial)+" Pedido "+String(al_pedido)+" ~rErro ao localizar o pr$$HEX1$$f300$$ENDHEX$$ximo pedido almoxarifado que seria criado para inserir as faltas:" + SqlCa.sqlErrText
		SqlCa.of_Rollback()
		Return False
End Choose

Return True
end function

private function boolean of_insere_pedido_distribuidora_almox (long al_filial, long al_pedido_distribuidora, long al_centro_custo, long al_centro_custo_entrega, string as_tipo_pedido);dc_uo_ds_Base lds_Pedidos_Almox

Long 	ll_Pedido_Almox,&
		ll_Linhas,&
		ll_Linha
		
String ls_Erro		

Try
	lds_Pedidos_Almox = Create dc_uo_ds_Base
	
	If Not lds_Pedidos_Almox.of_ChangeDataObject("ds_ge259_pedidos_almoxarifado") Then
		SqlCa.of_Rollback()
		//MessageBox("Erro", "Erro no changeDataObject da ds_ws093_pedidos_almoxarifado")
		of_email_log("Filial: "+String(al_Filial)+"~rErro no changeDataObject da ds_ge259_pedidos_almoxarifado")
		Return False
	End If
	
	ll_Linhas = lds_Pedidos_Almox.Retrieve(al_Filial, al_Centro_Custo, al_centro_custo_entrega, as_tipo_pedido)
	
	
	If ll_Linhas > 0 Then
		For ll_Linha = 1 To ll_Linhas
			
			ll_Pedido_Almox	= lds_Pedidos_Almox.Object.nr_pedido[ll_Linha]
			
			Insert Into pedido_distribuidora_almox(
					cd_filial,
					nr_pedido_distribuidora,
					nr_pedido_almoxarifado)
			Values(	:al_Filial,
						:al_Pedido_Distribuidora,
						:ll_Pedido_Almox)
			Using SqlCa;						
					
			If SqlCa.SqlCode = -1 Then
				ls_Erro = "Filial: "+String(al_Filial)+"~rErro no insert da tabela 'pedido_distribuidora_almox'." + SqlCa.sqlErrText
				SqlCa.of_Rollback()
				//MessageBox("Erro", ls_Erro)
				of_email_log(ls_Erro)
				Return False
			End If
		Next
	End If
Finally
	Destroy(lds_Pedidos_Almox)
End Try

Return True
end function

public function boolean of_insere_pedido_distribuidora_produto (long al_filial, long al_pedido_distribuidora, long al_centro_custo, long al_centro_custo_entrega, string as_tipo_pedido);dc_uo_ds_Base lds_Produtos

Long 	ll_Linhas,&
		ll_Linha,&
		ll_Produto,&
		ll_Qtde_Pedida,&
		ll_Qtde_Atendida,&
		ll_Qtde_Faturada,&
		ll_Qtde = 0
		
Decimal ldc_Custo_Unitario		

String ls_Erro

Try
	lds_Produtos = Create dc_uo_ds_Base
	
	If Not lds_Produtos.of_ChangeDataObject("ds_ge259_pedido_almoxarifado_produtos") Then
		SqlCa.of_Rollback()
		//MessageBox("Erro", "Erro no changeDataObject da ds_ws093_pedido_almoxarifado_produtos")
		of_email_log("Filial: "+String(al_Filial)+"~rErro no changeDataObject da ds_ge259_pedido_almoxarifado_produtos")
		Return False
	End If
	
	ll_Linhas = lds_Produtos.Retrieve(al_Filial, al_Centro_Custo, al_centro_custo_entrega, as_tipo_pedido)
	
	
	If ll_Linhas > 0 Then
		For ll_Linha = 1 To ll_Linhas
			
			ll_Produto				= lds_Produtos.Object.cd_produto			[ll_Linha]
			ll_Qtde_Pedida			= lds_Produtos.Object.qt_pedida			[ll_Linha]
			ll_Qtde_Atendida		= lds_Produtos.Object.qt_atendida		[ll_Linha]
			ll_Qtde_Faturada		= lds_Produtos.Object.qt_faturada			[ll_Linha] 
			ldc_Custo_Unitario		= lds_Produtos.Object.vl_custo_unitario	[ll_Linha] 
			
			If al_Filial <> 2 Then
				Select count(*)
				Into	:ll_Qtde
				From pedido_distribuidora_produto
				Where	cd_filial	= :al_Filial
					And	nr_pedido_distribuidora	= :al_Pedido_Distribuidora
					And	cd_produto					= :ll_Produto
					And	qt_faturada					= 0
					And	id_situacao					= 'C'
				Using SqlCa;
				
				If SqlCa.SqlCode = -1 Then
					ls_Erro = "Filial: "+String(al_Filial)+"~rErro ao verificar se j$$HEX1$$e100$$ENDHEX$$ existe o produto na tabela 'pedido_distribuidora_produto'." + SqlCa.sqlErrText
					SqlCa.of_Rollback()
					of_email_log(ls_Erro)
					Return False
				End If
			End If
			
			If ll_Qtde > 0 Then
				Update pedido_distribuidora_produto
				Set	qt_pedida		= Coalesce(qt_pedida, 0) + Coalesce(:ll_Qtde_Atendida, 0),
						qt_atendida		= Coalesce(qt_atendida, 0) + Coalesce(:ll_Qtde_Atendida, 0)
				Where cd_filial	= :al_Filial
				And	nr_pedido_distribuidora	= :al_Pedido_Distribuidora
				And	cd_produto					= :ll_Produto
				And	qt_faturada					= 0
				And	id_situacao					= 'C'
				Using SqlCa;
				
				If SqlCa.SqlCode = -1 Then
					ls_Erro = "Filial: "+String(al_Filial)+"~rErro ao atualizar a qtde pedida da tabela 'pedido_distribuidora_produto'." + SqlCa.sqlErrText
					SqlCa.of_Rollback()
					of_email_log(ls_Erro)
					Return False
				End If
				
			Else
				INSERT INTO pedido_distribuidora_produto(  
						cd_filial,   
						nr_pedido_distribuidora,   
						cd_produto,   
						qt_pedida,   
						qt_atendida,   
						qt_faturada,   
						vl_preco_unitario,   
						id_situacao,   
						qt_separada,   
						nr_pedido_empurrado,   
						vl_preco,   
						pc_desconto,   
						nr_matricula_separador,   
						nr_matricula_conferente,   
						pc_desconto_conexao,   
						vl_icms_st,   
						nr_dias_pagamento,   
						qt_lista_separacao,   
						pc_desconto_conexao_lab,   
						pc_desconto_conexao_adicional,   
						pc_repasse_icms )  
				VALUES ( :al_Filial,   
							:al_Pedido_Distribuidora,   
							:ll_Produto,   
							:ll_Qtde_Atendida,   
							:ll_Qtde_Atendida,   
							0,   
							:ldc_Custo_Unitario,   
							'C',   
							null,   
							null,   
							null,   
							null,   
							null,   
							null,   
							null,   
							null,   
							null,   
							null,   
							null,   
							null,   
							null ) 
				Using SqlCA;
				
				If SqlCa.SqlCode = -1 Then
					ls_Erro = "Filial: "+String(al_Filial)+"~rErro no insert da tabela 'pedido_distribuidora_produto'." + SqlCa.sqlErrText
					SqlCa.of_Rollback()
					//MessageBox("Erro", ls_Erro)
					of_email_log(ls_Erro)
					Return False
				End If
			End If
			
		Next
	End If
Finally
	Destroy(lds_Produtos)
End Try

Return True
end function

public function boolean of_insere_pedido_almoxarifado_falta (long al_filial, long al_pedido, boolean ab_pedido_almoxarifado, ref string as_erro, string as_tipo_pedido, long al_pedido_almox, string as_dados_adicionais);//Gera um novo pedido almoxarifado com as faltas

dc_uo_ds_base	lds_Produtos

Long	ll_linha,&
		ll_Linhas,&
		ll_Proximo_Pedido,&
		ll_Produto,&
		ll_Falta,&
		ll_Centro_Custo,&
		ll_Qtde
		
String	ls_Erro

Decimal	ldc_Custo_Unitario

Date	ldt_Emissao

//Localiza o centro de custos
If Not of_Centro_Custos(al_Filial, al_Pedido, ab_pedido_almoxarifado, Ref ll_Centro_Custo, Ref as_Erro) Then
	Return False
End If

////Ir$$HEX1$$e100$$ENDHEX$$ inserir pedido somente para as filiais 2 e 809 ou para as filiais que tiverem o centro de custos preenchido
//If (al_Filial <> 2) and (al_Filial <> 809) and IsNull(ll_Centro_Custo) Then
//	Return True
//End If

//Ir$$HEX1$$e100$$ENDHEX$$ inserir pedido somente para as filiais 2 e 809 ou para as filiais que tiverem o centro de custos preenchido
If (al_Filial <> 2) and (al_Filial <> 809) and (al_Filial <> 534) and IsNull(ll_Centro_Custo) and (al_pedido_almox < 30000) Then
	Return True
End IF

Try
	lds_Produtos = Create dc_uo_ds_base
	
	If Not lds_Produtos.of_ChangeDataObject("ds_ge259_pedido_almoxarifado_produtos_falta") Then
		as_Erro = "Filial: "+String(al_Filial)+" Pedido: "+String(al_Pedido)+"~rErro no 'ds_ge259_pedido_almoxarifado_produtos_falta' do pedido almoxarifado que seria criado para inserir as faltas:" + SqlCa.sqlErrText
		Return False
	End If
	
	If ab_Pedido_Almoxarifado Then
		lds_Produtos.of_AppendWhere("nr_pedido = "+String(al_Pedido))
	Else
		If al_pedido_almox < 30000 Then
			lds_Produtos.of_AppendWhere("nr_pedido	in (	select nr_pedido_almoxarifado "+&
													"						from pedido_distribuidora_almox "+&
													"						where cd_filial = "+String(al_Filial)+" "+&
													"						and nr_pedido_distribuidora = "+String(al_Pedido)+" "+&
													"                          and nr_pedido_almoxarifado < 30000)") 
		Else
			lds_Produtos.of_AppendWhere("nr_pedido	in (	select nr_pedido_almoxarifado "+&
													"						from pedido_distribuidora_almox "+&
													"						where cd_filial = "+String(al_Filial)+" "+&
													"						and nr_pedido_distribuidora = "+String(al_Pedido)+" "+&
													"                          and nr_pedido_almoxarifado >= 30000)")
		End If
	End If
	
	ll_Linhas = lds_Produtos.Retrieve(al_Filial, al_Pedido)
	
	If ll_Linhas > 0 Then
		If Not This.of_Localiza_Proximo_Pedido_Almoxarifado(al_Filial, Ref ll_Proximo_Pedido, Ref as_Erro) Then
			Return False
		End If
		
		ldt_Emissao	= Date(gf_GetServerDate())
		
		//Insere o pedido
		If ab_Pedido_Almoxarifado Then
			Insert into pedido_almoxarifado(
				cd_filial,
				nr_pedido,
				dh_emissao,
				vl_total_pedido,
				id_situacao,
				nr_matricula_requisitante,
				dh_importacao,
				cd_centro_custo,
				nr_matricula_cadastramento,
				cd_centro_custo_entrega,
				id_tipo_pedido,
				dh_inclusao,
				de_dados_adicionais)
			Select		cd_filial,
						:ll_Proximo_Pedido,
						:ldt_Emissao,
						0,
						'C',
						nr_matricula_requisitante,
						cast(GetDate() as date),
						cd_centro_custo,
						'14330',
						cd_centro_custo_entrega,
						:as_tipo_pedido,
						GetDate(),
						:as_Dados_Adicionais
			From pedido_almoxarifado 
			Where cd_filial		= :al_Filial
			  and nr_pedido	= :al_Pedido
			Using SqlCa; 
		Else
			Insert into pedido_almoxarifado(
				cd_filial,
				nr_pedido,
				dh_emissao,
				vl_total_pedido,
				id_situacao,
				nr_matricula_requisitante,
				dh_importacao,
				cd_centro_custo,
				nr_matricula_cadastramento,
				cd_centro_custo_entrega,
				id_tipo_pedido,
				dh_inclusao,
				de_dados_adicionais)
			Select		cd_filial,
						:ll_Proximo_Pedido,
						:ldt_Emissao,
						0,
						'C',
						nr_matricula_requisitante,
						GetDate(),
						cd_centro_custo,
						'14330',
						cd_centro_custo_entrega,
						:as_tipo_pedido,
						GetDate(),
						:as_Dados_Adicionais
			From pedido_almoxarifado 
			Where cd_filial		= :al_Filial
			  and nr_pedido	=	(select max(nr_pedido_almoxarifado)
										from pedido_distribuidora_almox 
										where cd_filial = :al_Filial
										and nr_pedido_distribuidora = :al_Pedido)
			Using SqlCa; 
		End If
		
		If SqlCa.SqlCode = -1 Then
			as_Erro = "Filial: "+String(al_Filial)+" Pedido "+String(al_Pedido)+" ~rErro ao inserir o pedido almoxarifado que seria criado para inserir as faltas:" + SqlCa.sqlErrText
			SqlCa.of_Rollback()
			Return False
		End If
		
		If SqlCa.sqlnrows	= 0 Then
			SqlCa.of_Rollback()
			as_Erro =  "Filial: "+String(al_Filial)+" Pedido "+String(al_pedido)+" ~rN$$HEX1$$e300$$ENDHEX$$o foi inserido nenhum registro ao criar o pedido almoxarifado para inserir as faltas." 
			Return False
		End If
		
		//Insere os produtos
		For ll_Linha = 1 To ll_Linhas
			ll_produto			= lds_Produtos.Object.cd_produto			[ll_Linha]
			ll_Falta				= lds_Produtos.Object.qt_falta				[ll_Linha]	
			ldc_Custo_Unitario	= lds_Produtos.Object.vl_custo_unitario	[ll_Linha]	
			
			select count(*)
			into :ll_Qtde
			from pedido_almoxarifado_produto
			where cd_filial		= :al_Filial
				and nr_pedido	= :ll_Proximo_Pedido
				and cd_produto	= :ll_Produto
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				as_Erro = "Filial: "+String(al_Filial)+" Pedido "+String(al_pedido)+" ~rErro ao verificar se j$$HEX1$$e100$$ENDHEX$$ tem o produto na tabela 'pedido_almoxarifado_produto':" + SqlCa.sqlErrText
				SqlCa.of_Rollback()
				Return False
			End If
			
			If ll_Qtde > 0 Then
				update pedido_almoxarifado_produto
				set qt_pedida = qt_pedida + :ll_Falta
				where cd_filial		= :al_Filial
					and nr_pedido	= :ll_Proximo_Pedido
					and cd_produto	= :ll_Produto
				Using SqlCa; 
			Else			
				Insert into pedido_almoxarifado_produto(
					cd_filial,
					nr_pedido,
					cd_produto,
					qt_pedida,
					qt_atendida,
					qt_separada,
					qt_faturada,
					vl_custo_unitario)
				Values(	:al_Filial,
							:ll_Proximo_Pedido,
							:ll_Produto,
							:ll_Falta,
							0,
							0,
							0,
							:ldc_Custo_Unitario)
				Using SqlCa;
			End If
			
			If SqlCa.SqlCode = -1 Then
				as_Erro = "Filial: "+String(al_Filial)+" Pedido "+String(al_pedido)+" ~rErro ao inserir o produto "+String(ll_Produto)+" no pedido almoxarifado que seria criado para inserir as faltas:" + SqlCa.sqlErrText
				SqlCa.of_Rollback()
				Return False
			End If
			
			If SqlCa.sqlnrows	= 0 Then
				SqlCa.of_Rollback()
				as_Erro = "Filial: "+String(al_Filial)+" Pedido "+String(al_pedido)+" ~rN$$HEX1$$e300$$ENDHEX$$o foi inserido nenhum registro para o produto "+String(ll_Produto)+" ao criar o pedido almoxarifado para inserir as faltas." 
				Return False
			End If
			
		Next
	End If
	
Finally
	Destroy(lds_Produtos)
End Try

Return True
end function

private function boolean of_insere_pedido_distribuidora (long al_filial, decimal adc_valor_pedido, long al_centro_custo_entrega, ref long al_proximo_pedido);Long ll_Pedido_Filial
Long ll_Teste
		
String ls_Erro		

Date ldt_Data

Integer li_Row

ldt_Data = Date(gf_GetServerDate())

//--------------Verifica se j$$HEX1$$e100$$ENDHEX$$ tem um pedido distribuidora para pedidos de almoxarifado--------------
If al_Filial <> 2 And (IsNull(al_Centro_Custo_Entrega) Or (al_Centro_Custo_Entrega = 0) or al_Centro_Custo_Entrega = al_Filial) Then
	Select nr_pedido_distribuidora
	Into :al_Proximo_Pedido
	From pedido_distribuidora
	Where	cd_filial						= :al_Filial
		And	dh_emissao					= :ldt_Data
		And	id_situacao					= 'C'
		And	cd_distribuidora			= '053404705'
		And	id_pedido_almoxarifado	= 'S'
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 100
			
		Case 0
			Update pedido_distribuidora
			Set vl_total_pedido	= Coalesce(vl_total_pedido, 0) + Coalesce(:adc_Valor_Pedido, 0)
			Where	cd_filial						= :al_Filial
				And	dh_emissao					= :ldt_Data
				And	id_situacao					= 'C'
				And	cd_distribuidora			= '053404705'
				And	id_pedido_almoxarifado	= 'S'
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				ls_Erro = "Filial: "+String(al_Filial)+"~rErro ao atualizar o valor do pedido da tabela 'pedido_distribuidora'." + SqlCa.sqlErrText
				SqlCa.of_Rollback()
				of_email_log(ls_Erro)
				Return False
			End If
			
			If SqlCa.sqlnrows <> 1 Then
				ls_Erro = "Filial: "+String(al_Filial)+"~rErro ao atualizar o valor do pedido da tabela 'pedido_distribuidora'. Deveria ter atualizado 1 linha, mas atualizou "+String(SqlCa.sqlnrows)+" linha(s)."
				SqlCa.of_Rollback()
				of_email_log(ls_Erro)
				Return False
			End If
			
			Return True
			
		Case -1
			ls_Erro = "Filial: "+String(al_Filial)+"~rErro ao verificar se j$$HEX1$$e100$$ENDHEX$$ existe um pedido distribuidora para os pedidos de almoxarifado:" + SqlCa.sqlErrText
			SqlCa.of_Rollback()
			of_email_log(ls_Erro)
			Return False
	End Choose
End If
//---------------------------------------------------------------------------------------------------------------


//Select coalesce(Max(nr_pedido_distribuidora), 0) + 1
//Into :al_Proximo_Pedido
//From pedido_distribuidora
//Where cd_filial = :al_Filial
//Using SqlCa;
//
//If SqlCa.SqlCode = -1 Then
//	ls_Erro = "Filial: "+String(al_Filial)+"~rErro ao selecionar o pr$$HEX1$$f300$$ENDHEX$$ximo nr_pedido_distribuidora:" + SqlCa.sqlErrText
//	SqlCa.of_Rollback()
//	//MessageBox("Erro", ls_Erro)
//	of_email_log(ls_Erro)
//	Return False
//End If

If Not gf_ge040_proximo_pedido_distribuidora(Ref al_Proximo_Pedido, Ref ls_Erro) Then
	SqlCa.of_Rollback()
	of_email_log(ls_Erro)
	Return False
End If

li_Row = UpperBound( il_Pedido ) 
li_Row++

il_Pedido[ li_Row ] = al_Proximo_Pedido

select coalesce(max(nr_pedido_filial), 0)
Into :ll_Pedido_Filial
from pedido_filial
where cd_filial = :al_Filial
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_Erro = "Filial: "+String(al_Filial)+"~rErro no select da 'pedido_filial':" + SqlCa.sqlErrText
	SqlCa.of_Rollback()
	//MessageBox("Erro", ls_Erro)
	of_email_log(ls_Erro)
	Return False
End If

  INSERT INTO pedido_distribuidora(
				cd_filial,   
				nr_pedido_distribuidora,   
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
				id_tipo_pedido)  
  VALUES (	:al_Filial,   
				:al_Proximo_Pedido,   
				:ldt_Data,   
				:adc_Valor_Pedido,   
				'C',   
				:ll_Pedido_Filial,   
				'053404705',   
				null,   
				null,   
				null,   
				null,   
				null,   
				null,   
				null,   
				null,   
				null,   
				null,   
				null,   
				'S',
				'4')   
Using SqlCa;	

If SqlCa.SqlCode = -1 Then
	ls_Erro = "Filial: "+String(al_Filial)+"~rErro no insert da tabela 'pedido_distribuidora'." + SqlCa.sqlErrText
	SqlCa.of_Rollback()
	//MessageBox("Erro", ls_Erro)
	of_email_log(ls_Erro)
	Return False
End If

Return True
end function

private function boolean of_insere_pedido_distribuidora_almox_cd (long al_filial, long al_pedido_distribuidora, long al_centro_custo, long al_centro_custo_entrega, string as_tipo_pedido, ref long al_cd_pedido_almox_cd);dc_uo_ds_Base lds_Pedidos_Almox_Cd

Long 	ll_Pedido_Almox,&
		ll_Linhas,&
		ll_Linha
		
String ls_Erro		

Try
	lds_Pedidos_Almox_Cd = Create dc_uo_ds_Base
	
	If Not lds_Pedidos_Almox_Cd.of_ChangeDataObject("ds_ge259_pedidos_almoxarifado_cd") Then
		SqlCa.of_Rollback()
		//MessageBox("Erro", "Erro no changeDataObject da ds_ws093_pedidos_almoxarifado")
		of_email_log("Filial: "+String(al_Filial)+"~rErro no changeDataObject da ds_ge259_pedidos_almoxarifado_cd")
		Return False
	End If
	
	ll_Linhas = lds_Pedidos_Almox_Cd.Retrieve(al_Filial, al_Centro_Custo, al_centro_custo_entrega, as_tipo_pedido)
	
	
	If ll_Linhas > 0 Then
		For ll_Linha = 1 To ll_Linhas
			
			ll_Pedido_Almox	= lds_Pedidos_Almox_Cd.Object.nr_pedido[ll_Linha]
			al_cd_pedido_almox_cd = ll_Pedido_Almox
			
			Insert Into pedido_distribuidora_almox(
					cd_filial,
					nr_pedido_distribuidora,
					nr_pedido_almoxarifado)
			Values(	:al_Filial,
						:al_Pedido_Distribuidora,
						:ll_Pedido_Almox)
			Using SqlCa;						
					
			If SqlCa.SqlCode = -1 Then
				ls_Erro = "Filial: "+String(al_Filial)+"~rErro no insert da tabela 'pedido_distribuidora_almox'." + SqlCa.sqlErrText
				SqlCa.of_Rollback()
				//MessageBox("Erro", ls_Erro)
				of_email_log(ls_Erro)
				Return False
			End If
			
		Next
	End If
Finally
	Destroy(lds_Pedidos_Almox_Cd)
End Try

Return True
end function

public function boolean of_insere_pedido_distribuidora_produt_cd (long al_filial, long al_pedido_distribuidora, long al_centro_custo, long al_centro_custo_entrega, string as_tipo_pedido, long al_cd_pedido_almox_cd);dc_uo_ds_Base lds_Produtos_Cd

Long 	ll_Linhas,&
		ll_Linha,&
		ll_Produto,&
		ll_Qtde_Pedida,&
		ll_Qtde_Atendida,&
		ll_Qtde_Faturada,&
		ll_Qtde = 0
		
Decimal ldc_Custo_Unitario		

String ls_Erro

Try
	lds_Produtos_Cd = Create dc_uo_ds_Base
	
	If Not lds_Produtos_Cd.of_ChangeDataObject("ds_ge259_pedido_almoxarifado_produtos_cd") Then
		SqlCa.of_Rollback()
		//MessageBox("Erro", "Erro no changeDataObject da ds_ws093_pedido_almoxarifado_produtos")
		of_email_log("Filial: "+String(al_Filial)+"~rErro no changeDataObject da ds_ge259_pedido_almoxarifado_produtos_cd")
		Return False
	End If
	
	ll_Linhas = lds_Produtos_Cd.Retrieve(al_Filial, al_Centro_Custo, al_centro_custo_entrega, as_tipo_pedido, al_cd_pedido_almox_cd)
	
	
	If ll_Linhas > 0 Then
		For ll_Linha = 1 To ll_Linhas
			
			ll_Produto				= lds_Produtos_Cd.Object.cd_produto			[ll_Linha]
			ll_Qtde_Pedida			= lds_Produtos_Cd.Object.qt_pedida			[ll_Linha]
			ll_Qtde_Atendida		= lds_Produtos_Cd.Object.qt_atendida		[ll_Linha]
			ll_Qtde_Faturada		= lds_Produtos_Cd.Object.qt_faturada			[ll_Linha] 
			ldc_Custo_Unitario		= lds_Produtos_Cd.Object.vl_custo_unitario	[ll_Linha] 
			
			If al_Filial <> 2 Then
				Select count(*)
				Into	:ll_Qtde
				From pedido_distribuidora_produto
				Where	cd_filial	= :al_Filial
					And	nr_pedido_distribuidora	= :al_Pedido_Distribuidora
					And	cd_produto					= :ll_Produto
					And	qt_faturada					= 0
					And	id_situacao					= 'C'
				Using SqlCa;
				
				If SqlCa.SqlCode = -1 Then
					ls_Erro = "Filial: "+String(al_Filial)+"~rErro ao verificar se j$$HEX1$$e100$$ENDHEX$$ existe o produto na tabela 'pedido_distribuidora_produto'." + SqlCa.sqlErrText
					SqlCa.of_Rollback()
					of_email_log(ls_Erro)
					Return False
				End If
			End If
			
//			If Not of_grava_log_exp_mov_almox_cd(ll_produto, ll_qtde_atendida, ls_erro) Then
//				Return False
//			End If
			
			If ll_Qtde > 0 Then
				Update pedido_distribuidora_produto
				Set	qt_pedida		= Coalesce(qt_pedida, 0) + Coalesce(:ll_Qtde_Atendida, 0),
						qt_atendida		= Coalesce(qt_atendida, 0) + Coalesce(:ll_Qtde_Atendida, 0)
				Where cd_filial	= :al_Filial
				And	nr_pedido_distribuidora	= :al_Pedido_Distribuidora
				And	cd_produto					= :ll_Produto
				And	qt_faturada					= 0
				And	id_situacao					= 'C'
				Using SqlCa;
				
				If SqlCa.SqlCode = -1 Then
					ls_Erro = "Filial: "+String(al_Filial)+"~rErro ao atualizar a qtde pedida da tabela 'pedido_distribuidora_produto'." + SqlCa.sqlErrText
					SqlCa.of_Rollback()
					of_email_log(ls_Erro)
					Return False
				End If
				
			Else
				INSERT INTO pedido_distribuidora_produto(  
						cd_filial,   
						nr_pedido_distribuidora,   
						cd_produto,   
						qt_pedida,   
						qt_atendida,   
						qt_faturada,   
						vl_preco_unitario,   
						id_situacao,   
						qt_separada,   
						nr_pedido_empurrado,   
						vl_preco,   
						pc_desconto,   
						nr_matricula_separador,   
						nr_matricula_conferente,   
						pc_desconto_conexao,   
						vl_icms_st,   
						nr_dias_pagamento,   
						qt_lista_separacao,   
						pc_desconto_conexao_lab,   
						pc_desconto_conexao_adicional,   
						pc_repasse_icms )  
				VALUES ( :al_Filial,   
							:al_Pedido_Distribuidora,   
							:ll_Produto,   
							:ll_Qtde_Atendida,   
							:ll_Qtde_Atendida,   
							0,   
							:ldc_Custo_Unitario,   
							'C',   
							null,   
							null,   
							null,   
							null,   
							null,   
							null,   
							null,   
							null,   
							null,   
							null,   
							null,   
							null,   
							null ) 
				Using SqlCA;
				
				If SqlCa.SqlCode = -1 Then
					ls_Erro = "Filial: "+String(al_Filial)+"~rErro no insert da tabela 'pedido_distribuidora_produto'." + SqlCa.sqlErrText
					SqlCa.of_Rollback()
					//MessageBox("Erro", ls_Erro)
					of_email_log(ls_Erro)
					Return False
				End If
			End If
			
		Next
	End If
Finally
	Destroy(lds_Produtos_Cd)
End Try

Return True
end function

public function boolean of_grava_log_exp_mov_almox_cd (long al_cd_produto, long al_qt_movto, ref string as_log);String	ls_nr_exportacao


SELECT
	newid()
INTO
	:ls_nr_exportacao
FROM
	dummy;

If SQLCA.SQLCode = -1 Then
	as_log	= 'Erro ao buscar id para registro na tabela log_exportacao. Erro: ' + SQLCA.SQLErrText
	Return False
End If

INSERT INTO log_exportacao (
	nr_exportacao,
	cd_empresa,
	cd_chave,
	dh_inclusao,
	cd_tipo_exportacao,
	id_situacao_exportacao,
	cd_integer1,
	cd_integer2,
	cd_varchar1,
	cd_varchar2,
	cd_varchar5)
SELECT
 	:ls_nr_exportacao, 
 	1000,
 	CAST(:al_cd_produto as VARCHAR(30)),
 	getdate(),
 	4,
 	'C',
 	:al_cd_produto,
	:al_qt_movto,
 	'201',
	'03',
	'0001'
USING SQLCA;

If SQLCA.SQLCode = -1 Then
	as_log	= 'Erro ao inserir registro na tabela log_exportacao. Erro: ' + SQLCA.SQLErrText
	Return False
End If

INSERT INTO log_exportacao_extra (
	nr_exportacao,
	cd_varchar6,
	cd_varchar7)
SELECT
 	:ls_nr_exportacao, 
 	'1156021',
	'1156'
USING SQLCA;

If SQLCA.SQLCode = -1 Then
	as_log	= 'Erro ao inserir registro na tabela log_exportacao_extra. Erro: ' + SQLCA.SQLErrText
	Return False
End If

Return True
end function

on uo_ge259_pedido_almoxarifado.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge259_pedido_almoxarifado.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

