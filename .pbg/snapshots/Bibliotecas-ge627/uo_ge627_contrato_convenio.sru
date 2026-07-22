HA$PBExportHeader$uo_ge627_contrato_convenio.sru
forward
global type uo_ge627_contrato_convenio from nonvisualobject
end type
end forward

global type uo_ge627_contrato_convenio from nonvisualobject
end type
global uo_ge627_contrato_convenio uo_ge627_contrato_convenio

type variables
dc_uo_ds_base ids_restricao_contrato //Produtos desta lista n$$HEX1$$e300$$ENDHEX$$o ter$$HEX1$$e300$$ENDHEX$$o o desconto atualizado
end variables

forward prototypes
public function boolean of_atualiza_produtos (dc_uo_ds_base ads_contrato)
public function boolean of_atualiza_contratos ()
public function boolean of_exclui_produtos_nao_atualizados (long al_convenio, long al_contrato, datetime adh_inicio)
public function boolean of_atualiza_data_contrato (long al_convenio, long al_contrato)
public function boolean of_atualiza_produtos_especiais (dc_uo_ds_base ads_contrato)
public function boolean of_atualiza_contratos_vacina ()
public function boolean of_atualiza_produtos_perfumaria (long pl_convenio, long pl_contrato)
public function boolean of_atualiza_contratos (long pl_cd_convenio, long pl_nr_contrato)
public function boolean of_atualiza_produto_contrato (long al_convenio, long al_contrato, long al_produto, decimal adc_desconto, string as_lei_generico, string as_subcategoria, long al_cd_tarja, string as_utiliza_desconto_parametrizado, decimal adc_desconto_parametrizado, string ps_somente_produto_tarjado)
public function boolean of_verifica_desconto_parametro (long pl_convenio, long pl_contrato, string ps_grupo, string ps_lei_generico, ref decimal pdc_desconto, ref string ps_somente_produto_tarjado)
end prototypes

public function boolean of_atualiza_produtos (dc_uo_ds_base ads_contrato);Long lvl_Total, &
	  lvl_Linha_1, &
	  lvl_Linha_2, &
     lvl_Convenio, &
     lvl_Contrato, &
	  lvl_Produto, &
	  ll_cd_tarja

Decimal{2} lvdc_Desconto

String ls_Lei_Generico, ls_subcategoria, ls_id_utiliza_desc_parametrizado, ls_somente_produto_tarjado

Decimal ldc_Desconto_Parm

dc_uo_ds_Base lvds_1

try
	lvds_1 = Create dc_uo_ds_Base
	
	If Not lvds_1.of_ChangeDataObject("dw_ge627_lista_produtos_contrato") Then Return False
	
	Open(w_Aguarde)
	w_Aguarde.Title = "Atualizando Contratos dos Conv$$HEX1$$ea00$$ENDHEX$$nios..."
	
	lvl_Total = lvds_1.Retrieve()
	
	// Lista todos os produtos (MEDICAMENTOS), ATIVOS e PENDENTES
	If lvl_Total > 0 Then
		
		w_Aguarde.uo_Progress.of_SetMax(lvl_Total)
		
		For lvl_Linha_1 = 1 To lvl_Total
			
			lvl_Produto			= lvds_1.Object.Cd_Produto			[lvl_Linha_1]
			lvdc_Desconto		= lvds_1.Object.Pc_Desconto		[lvl_Linha_1]
			ls_Lei_Generico		= lvds_1.Object.Id_Lei_Generico	[lvl_Linha_1]
			ls_subcategoria		= lvds_1.Object.cd_subcategoria 	[lvl_Linha_1]
			ll_cd_tarja			= lvds_1.Object.cd_tarja 			[lvl_Linha_1]
			
			If lvl_Produto = 734892 Then
				lvl_Produto = 734892
			End If
			
			If IsNull(lvdc_Desconto) Then lvdc_Desconto = 0
			
			If lvdc_Desconto > 50 Then lvdc_Desconto = 50  //Antes era 40, alterado para 50 porque $$HEX1$$e900$$ENDHEX$$ o limite existente na tela e estipulado pela $$HEX1$$e100$$ENDHEX$$rea.
			
			//If lvdc_Desconto >= 1 Then
				
				For lvl_Linha_2 = 1 To ads_Contrato.RowCount()
									
					lvl_Convenio 							= ads_Contrato.Object.Cd_Convenio[lvl_Linha_2]
					lvl_Contrato 							= ads_Contrato.Object.Nr_Contrato[lvl_Linha_2]
					ls_id_utiliza_desc_parametrizado 	= ads_Contrato.Object.id_utiliza_desc_parametrizado[lvl_Linha_2]
					
					SetNull(ldc_Desconto_Parm)
					
					// Deve ser "S" se existe desconto cadastrado na contrato_preco_convenio_desc, desconto por grupo e lei generico
					If ls_id_utiliza_desc_parametrizado = 'S' Then
						// Localiza o desconto cadastrado na contrato_preco_convenio_desc
						If Not of_verifica_desconto_parametro (	lvl_Convenio,& 
																			lvl_Contrato,& 
																			mid(ls_subcategoria,1,1), &
																			ls_Lei_Generico, & 
																			Ref ldc_Desconto_Parm,&
																			Ref ls_somente_produto_tarjado) Then
							Return False			
						End If
					End If
					
					If Not This.of_Atualiza_Produto_Contrato(lvl_Convenio, &
																		  lvl_Contrato, &
																		  lvl_Produto, &
																		  lvdc_Desconto, &
																		  ls_Lei_Generico, &
																		  ls_subcategoria, &
																		  ll_cd_tarja,&
																		  ls_id_utiliza_desc_parametrizado,&
																		  ldc_Desconto_Parm,&
																		  ls_somente_produto_tarjado) Then
						Return False
					End If
					
				Next		
				
			//End If		
			
			w_Aguarde.uo_Progress.of_SetProgress(lvl_Linha_1)
		Next
		
	Else
		gvo_Aplicacao.of_Grava_Log("Produtos do Contrato n$$HEX1$$e300$$ENDHEX$$o Localizados")
		Return False
	End If

finally
	Destroy(lvds_1)
end try

Return True
end function

public function boolean of_atualiza_contratos ();return this.of_atualiza_contratos( 0, 0)
end function

public function boolean of_exclui_produtos_nao_atualizados (long al_convenio, long al_contrato, datetime adh_inicio);String lvs_Chave

lvs_Chave = "(" + String(al_Convenio) + "-" + String(al_Contrato) + ")"

Delete From contrato_preco_convenio_prd
Where cd_convenio = :al_Convenio
  and nr_contrato = :al_Contrato
  and (dh_atualizacao_desconto is null or dh_atualizacao_desconto < :adh_Inicio)
Using SqlCa;
			
If SqlCa.SqlCode = -1 Then
	gvo_Aplicacao.of_Grava_Log("Erro na exclus$$HEX1$$e300$$ENDHEX$$o dos produtos do contrato. " + lvs_Chave + "~r" + SqlCa.SqlErrText)
	Return False
End If			

Return True
end function

public function boolean of_atualiza_data_contrato (long al_convenio, long al_contrato);String lvs_Chave

lvs_Chave = "(" + String(al_Convenio) + "-" + String(al_Contrato) + ")"

Update contrato_preco_convenio
Set dh_atualizacao_desconto = p.dh_movimentacao
From contrato_preco_convenio c,
     parametro p
Where c.cd_convenio = :al_Convenio
  and c.nr_contrato = :al_Contrato
Using SqlCa;
			
If SqlCa.SqlCode = -1 Then
	gvo_Aplicacao.of_Grava_Log("Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o da data do contrato. " + lvs_Chave + "~r" + SqlCa.SqlErrText)
	Return False
End If			

Return True
end function

public function boolean of_atualiza_produtos_especiais (dc_uo_ds_base ads_contrato);Boolean lvb_Sucesso = True

Long lvl_Total, &
	  lvl_Linha_1, &
	  lvl_Linha_2, &	  
     lvl_Convenio, &
     lvl_Contrato, &
	  lvl_Produto
	  
Decimal{2} lvdc_Desconto, &
			    lvdc_desconto_c
				 
String lvs_chave				 

dc_uo_ds_Base lvds_1
lvds_1 = Create dc_uo_ds_Base
//Percentual e produtos est$$HEX1$$e300$$ENDHEX$$o fixos no select da data store.
If Not lvds_1.of_ChangeDataObject("ds_ge627_lista_produtos_especiais") Then
	Destroy(lvds_1)
	Return False
End If

Open(w_Aguarde)
w_Aguarde.Title = "Atualizando Contratos dos Conv$$HEX1$$ea00$$ENDHEX$$nios(Especiais)..."

lvl_Total = lvds_1.Retrieve()

If lvl_Total > 0 Then
	w_Aguarde.uo_Progress.of_SetMax(lvl_Total)
	
	For lvl_Linha_1 = 1 To lvl_Total
		lvl_Produto		= lvds_1.Object.Cd_Produto			[lvl_Linha_1]
		lvdc_Desconto	= lvds_1.Object.Pc_Desconto		[lvl_Linha_1]
		
		If IsNull(lvdc_Desconto) Then lvdc_Desconto = 0

		For lvl_Linha_2 = 1 To ads_Contrato.RowCount()
							
			lvl_Convenio = ads_Contrato.Object.Cd_Convenio[lvl_Linha_2]
			lvl_Contrato = ads_Contrato.Object.Nr_Contrato[lvl_Linha_2]
			
			If lvl_Convenio = 54659 Then	continue //clinipam n$$HEX1$$e300$$ENDHEX$$o atualiza
			
			If lvl_contrato = 1 Then //Conforme pedido no chamado 878032, somente atualiza contratos de numero 1.
			
				lvs_Chave = "(" + String(lvl_Convenio) + "-" + String(lvl_Contrato) + "-" + String(lvl_Produto) + ")"				
				
				Select pc_desconto Into :lvdc_Desconto_c
				From contrato_preco_convenio_prd
				Where cd_convenio = :lvl_Convenio
				  and nr_contrato = :lvl_Contrato
				  and cd_produto  = :lvl_Produto
				Using SqlCa;
				
				Choose Case SqlCa.SqlCode
					Case 0
						If lvdc_Desconto_c <> lvdc_Desconto Then
							Update contrato_preco_convenio_prd
							Set pc_desconto = :lvdc_Desconto,
								 dh_atualizacao_desconto = getdate()
							Where cd_convenio = :lvl_Convenio
							  and nr_contrato = :lvl_Contrato
							  and cd_produto  = :lvl_Produto
							Using SqlCa;
						End If
						
						If SqlCa.SqlCode = -1 Then
							gvo_Aplicacao.of_Grava_Log("Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do produto no contrato. " + lvs_Chave + "~r" + SqlCa.SqlErrText)
							lvb_Sucesso = False
						End If			
						
					Case 100
						Insert Into contrato_preco_convenio_prd (cd_convenio,   
																			  nr_contrato,   
																			  cd_produto,   
																			  pc_desconto,   
																			  dh_atualizacao_desconto)  
						Values (:lvl_Convenio,   
								  :lvl_Contrato,   
								  :lvl_Produto,   
								  :lvdc_Desconto,   
								  getdate())
						Using SqlCa;
				
						If SqlCa.SqlCode = -1 Then
							gvo_Aplicacao.of_Grava_Log("Erro na inclus$$HEX1$$e300$$ENDHEX$$o do produto no contrato. " + lvs_Chave + "~r" + SqlCa.SqlErrText)
							lvb_Sucesso = False
						End If			
						
					Case -1
						gvo_Aplicacao.of_Grava_Log("Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do produto no contrato. " + lvs_Chave + "~r" + SqlCa.SqlErrText)
						lvb_Sucesso = False
				End Choose
				
				If Not lvb_Sucesso Then Exit
			End If
		Next
		
		If Not lvb_Sucesso Then Exit
		
		w_Aguarde.uo_Progress.of_SetProgress(lvl_Linha_1)		
	Next
	
Else
	If lvl_Total = 0 Then
		gvo_Aplicacao.of_Grava_Log("Conv$$HEX1$$ea00$$ENDHEX$$nio sem contrato de Produtos (Especiais)")
	Else	
		gvo_Aplicacao.of_Grava_Log("Produtos (Especiais) do Contrato n$$HEX1$$e300$$ENDHEX$$o Localizados")
		lvb_Sucesso = False
	End If
End If

if isvalid(w_Aguarde) then Close(w_Aguarde)

Destroy(lvds_1)

Return lvb_Sucesso
end function

public function boolean of_atualiza_contratos_vacina ();//INSERE CONTRATO 2 PARA CONVENIOS E INCLUI O PRODUTO APLICAC$$HEX1$$c300$$ENDHEX$$O COM O DESCONTO
//PRODUTO APLICACAO 737672
//CHAMADO: 1092791
Boolean lvb_Sucesso = True

Long lvl_Linha, &
	  lvl_Convenio, &
     lvl_Contrato = 2, &
	 lvl_Total, &
	 lvl_produto_vacina
	 
String lvs_chave
	  
DateTime lvdh_Inicio, lvdh_termino
Decimal{2} ldc_pc_desconto

Try
	dc_uo_ds_Base lvds_1
	lvds_1 = Create dc_uo_ds_Base
	
	If Not lvds_1.of_ChangeDataObject("ds_ge627_lista_contrato_vacina") Then
		gvo_Aplicacao.of_Grava_Log("Atualiza$$HEX2$$e700e300$$ENDHEX$$o dos Contratos dos Conv$$HEX1$$ea00$$ENDHEX$$nios Vacina: Erro no of_ChangeDataObject  DS: ds_ge627_lista_contrato_vacina")
		Return False
	End If
			
	gvo_Aplicacao.of_Grava_Log("In$$HEX1$$ed00$$ENDHEX$$cio da Atualiza$$HEX2$$e700e300$$ENDHEX$$o dos Contratos Vacina dos Conv$$HEX1$$ea00$$ENDHEX$$nios")
	
	
	lvl_Total = lvds_1.Retrieve()

	If lvl_Total > 0 Then
		//w_Aguarde.uo_Progress.of_SetMax(lvl_Total)
		
		lvdh_Inicio = gf_GetServerDate()
		lvdh_termino = DateTime('31/12/2030 00:00')
		lvl_produto_vacina = 737672
		ldc_pc_desconto = 95.73	
		
		For lvl_Linha = 1 To lvl_Total
			lvl_convenio = lvds_1.Object.cd_convenio			[lvl_Linha]
			
			lvs_Chave = "(" + String(lvl_convenio) + "-" + String(lvl_Contrato) + "-" + String(lvl_produto_vacina) + ")"					

			Insert Into contrato_preco_convenio (cd_convenio,   
															nr_contrato,   
															dh_inicio,   
															dh_termino,
															de_comentario,
															id_atualiza_sistema_carga)  
			Values (:lvl_convenio,   
					  :lvl_contrato,   
					  :lvdh_Inicio,   
					  :lvdh_termino,   
					  'VACINAS CONVENIOS INTERNOS',
					  'N')
			Using SqlCa;
	
			If SqlCa.SqlCode = -1 Then
				gvo_Aplicacao.of_Grava_Log("Erro na inclus$$HEX1$$e300$$ENDHEX$$o no contrato conv$$HEX1$$ea00$$ENDHEX$$nio vacina. " + lvs_Chave + "~r" + SqlCa.SqlErrText)
				lvb_Sucesso = False
				exit
			End If
			
			Insert Into contrato_preco_convenio_prd (cd_convenio,   
																  nr_contrato,   
																  cd_produto,   
																  pc_desconto,   
																  dh_atualizacao_desconto)  
			Values (:lvl_convenio,   
					  :lvl_contrato,   
					  :lvl_produto_vacina,   
					  :ldc_pc_desconto,   
					  getdate())
			Using SqlCa;
	
			If SqlCa.SqlCode = -1 Then
				gvo_Aplicacao.of_Grava_Log("Erro na inclus$$HEX1$$e300$$ENDHEX$$o do produto no contrato vacina. " + lvs_Chave + "~r" + SqlCa.SqlErrText)
				lvb_Sucesso = False
				exit
			End If				
			
			//w_Aguarde.uo_Progress.of_SetProgress(lvl_Linha)
		Next		
		
		If lvb_Sucesso Then
			SqlCa.of_Commit()
		Else
			SqlCa.of_RollBack()
		End If

	End If	
	gvo_Aplicacao.of_Grava_Log("T$$HEX1$$e900$$ENDHEX$$rmino da Atualiza$$HEX2$$e700e300$$ENDHEX$$o dos Contratos dos Conv$$HEX1$$ea00$$ENDHEX$$nios")
	
	Return lvb_Sucesso
Finally
	If IsValid( lvds_1 ) Then Destroy lvds_1
End Try
end function

public function boolean of_atualiza_produtos_perfumaria (long pl_convenio, long pl_contrato);Boolean lvb_Sucesso = True

Long lvl_Total, &
	  lvl_Linha_1, &
	  lvl_Linha_2, &	  
     lvl_Convenio, &
     lvl_Contrato, &
	  lvl_Produto
	  
Decimal{2} lvdc_Desconto, &
			    lvdc_desconto_c
				 
String lvs_chave				 

//POR ENQUANTO SOMENTE CLINIPAM TEM DESCONTO POR CONTRATO EM PERFUMARIA
If pl_convenio <> 54659 And pl_convenio <> 55080 And pl_convenio <> 55081 Then
	Return True
End If

dc_uo_ds_Base lvds_1
lvds_1 = Create dc_uo_ds_Base
//Percentual e produtos est$$HEX1$$e300$$ENDHEX$$o fixos no select da data store.
If Not lvds_1.of_ChangeDataObject("ds_ge627_lista_produtos_perfumaria") Then
	Destroy(lvds_1)
	Return False
End If

Open(w_Aguarde)
w_Aguarde.Title = "Atualizando Contratos dos Conv$$HEX1$$ea00$$ENDHEX$$nios(Perfumaria)..."

lvl_Total = lvds_1.Retrieve()

If lvl_Total > 0 Then
	w_Aguarde.uo_Progress.of_SetMax(lvl_Total)
	
	For lvl_Linha_1 = 1 To lvl_Total
		lvl_Produto		= lvds_1.Object.Cd_Produto			[lvl_Linha_1]
		lvdc_Desconto	= lvds_1.Object.Pc_Desconto		[lvl_Linha_1]
		
		If IsNull(lvdc_Desconto) Then lvdc_Desconto = 0
						
		lvl_Convenio = pl_convenio
		lvl_Contrato = pl_contrato

		lvs_Chave = "(" + String(lvl_Convenio) + "-" + String(lvl_Contrato) + "-" + String(lvl_Produto) + ")"				
			
		Select pc_desconto Into :lvdc_Desconto_c
		From contrato_preco_convenio_prd
		Where cd_convenio = :lvl_Convenio
		  and nr_contrato = :lvl_Contrato
		  and cd_produto  = :lvl_Produto
		Using SqlCa;
		
		Choose Case SqlCa.SqlCode
			Case 0
				If lvdc_Desconto_c <> lvdc_Desconto Then
					Update contrato_preco_convenio_prd
					Set pc_desconto = :lvdc_Desconto,
						 dh_atualizacao_desconto = getdate()
					Where cd_convenio = :lvl_Convenio
					  and nr_contrato = :lvl_Contrato
					  and cd_produto  = :lvl_Produto
					Using SqlCa;
				End If
				
				If SqlCa.SqlCode = -1 Then
					gvo_Aplicacao.of_Grava_Log("Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do produto no contrato. " + lvs_Chave + "~r" + SqlCa.SqlErrText)
					lvb_Sucesso = False
				End If			
				
			Case 100
				Insert Into contrato_preco_convenio_prd (cd_convenio,   
																	  nr_contrato,   
																	  cd_produto,   
																	  pc_desconto,   
																	  dh_atualizacao_desconto)  
				Values (:lvl_Convenio,   
						  :lvl_Contrato,   
						  :lvl_Produto,   
						  :lvdc_Desconto,   
						  getdate())
				Using SqlCa;
		
				If SqlCa.SqlCode = -1 Then
					gvo_Aplicacao.of_Grava_Log("Erro na inclus$$HEX1$$e300$$ENDHEX$$o do produto no contrato. " + lvs_Chave + "~r" + SqlCa.SqlErrText)
					lvb_Sucesso = False
				End If			
				
			Case -1
				gvo_Aplicacao.of_Grava_Log("Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do produto no contrato. " + lvs_Chave + "~r" + SqlCa.SqlErrText)
				lvb_Sucesso = False
		End Choose
			
		If Not lvb_Sucesso Then Exit
		
		w_Aguarde.uo_Progress.of_SetProgress(lvl_Linha_1)		
	Next
	
Else
	If lvl_Total = 0 Then
		gvo_Aplicacao.of_Grava_Log("Sem contratos de Produtos (Perfumaria) para o conv$$HEX1$$ea00$$ENDHEX$$nio")
	Else
		gvo_Aplicacao.of_Grava_Log("Produtos (Perfumaria) do Contrato n$$HEX1$$e300$$ENDHEX$$o Localizados")
		lvb_Sucesso = False
	End If
End If

Destroy(lvds_1)

Return lvb_Sucesso
end function

public function boolean of_atualiza_contratos (long pl_cd_convenio, long pl_nr_contrato);Boolean lvb_Sucesso = True

Long lvl_Linha, &
	  lvl_Convenio, &
     lvl_Contrato
	  
DateTime lvdh_Inicio

Try
	dc_uo_ds_Base lvds_1
	lvds_1 = Create dc_uo_ds_Base
	
	If Not lvds_1.of_ChangeDataObject("dw_ge627_lista_contrato_convenio") Then
		gvo_Aplicacao.of_Grava_Log("Atualiza$$HEX2$$e700e300$$ENDHEX$$o dos Contratos dos Conv$$HEX1$$ea00$$ENDHEX$$nios: Erro no of_ChangeDataObject  DS: dw_ge627_lista_contrato_convenio")
		Return False
	End If
	
	if pl_cd_convenio > 0 then
		lvds_1.of_appendwhere('cd_convenio = ' + string(pl_cd_convenio) )
	ENd if
	
	if pl_nr_contrato > 0 then
		lvds_1.of_appendwhere('nr_contrato = ' + string(pl_nr_contrato) )
	ENd if
	
	//Restri$$HEX2$$e700e300$$ENDHEX$$o dos produtos do contrato
	ids_restricao_contrato.Reset()	

	If ids_restricao_contrato.Retrieve() < 0 Then
		gvo_Aplicacao.of_Grava_Log("Atualiza$$HEX2$$e700e300$$ENDHEX$$o dos Contratos dos Conv$$HEX1$$ea00$$ENDHEX$$nios: Erro no retrieve ids_restricao_contrato")
		Return False	
	End If
			
	gvo_Aplicacao.of_Grava_Log("In$$HEX1$$ed00$$ENDHEX$$cio da Atualiza$$HEX2$$e700e300$$ENDHEX$$o dos Contratos dos Conv$$HEX1$$ea00$$ENDHEX$$nios")
	
	If lvds_1.Retrieve() > 0 Then
		lvdh_Inicio = gf_GetServerDate()		
		
		If This.of_Atualiza_Produtos(lvds_1) Then			
			If This.of_Atualiza_Produtos_Especiais(lvds_1) Then //Produtos teste covid, chamado 878032
				For lvl_Linha = 1 To lvds_1.RowCount()
					lvl_Convenio 	= lvds_1.Object.Cd_Convenio	[lvl_Linha]
					lvl_Contrato 	= lvds_1.Object.Nr_Contrato	[lvl_Linha]
					
		//			If Not This.of_Exclui_Produtos_Nao_Atualizados(lvl_Convenio, lvl_Contrato, lvdh_Inicio) Then
		//				lvb_Sucesso = False
		//				Exit
		//			End If
		
					//Atualiza perfumaria atualmente somente Clinipam(54659/55080/55081)
					If Not This.of_Atualiza_Produtos_Perfumaria(lvl_Convenio, lvl_Contrato) Then 
						lvb_Sucesso = False
						Exit
					End If					
					
					If Not This.of_Atualiza_Data_Contrato(lvl_Convenio, lvl_Contrato) Then
						lvb_Sucesso = False
						Exit
					End If
				Next		
			Else
				lvb_sucesso = False
			End If
		Else
			lvb_Sucesso = False
		End If	
		
		If lvb_Sucesso Then
			SqlCa.of_Commit()
		Else
			SqlCa.of_RollBack()
		End If
	End If
		
	gvo_Aplicacao.of_Grava_Log("T$$HEX1$$e900$$ENDHEX$$rmino da Atualiza$$HEX2$$e700e300$$ENDHEX$$o dos Contratos dos Conv$$HEX1$$ea00$$ENDHEX$$nios")
	
	Return lvb_Sucesso
Finally
	If IsValid( lvds_1 ) Then Destroy lvds_1
End Try
end function

public function boolean of_atualiza_produto_contrato (long al_convenio, long al_contrato, long al_produto, decimal adc_desconto, string as_lei_generico, string as_subcategoria, long al_cd_tarja, string as_utiliza_desconto_parametrizado, decimal adc_desconto_parametrizado, string ps_somente_produto_tarjado);Boolean lvb_Sucesso = True

Decimal lvdc_Desconto

String lvs_Chave

lvs_Chave = "(" + String(al_Convenio) + "-" + String(al_Contrato) + "-" + String(al_Produto) + ")"

If as_utiliza_desconto_parametrizado = 'N' Then

	If al_Convenio = 52923 and adc_desconto = 15.00 Then  // Fundo Municipal de Guaramirim
		adc_desconto = 10.00
	End If
	
	If al_Convenio = 53455 and adc_desconto  <> 15.00 Then // Milium
		adc_desconto = 15.00
	End If
	
	//GRUPO ORSEGUPS
	If al_Convenio = 53751 Then adc_desconto = 10.00
	
	// OAB
	If al_Convenio = 53172 Then adc_desconto = 15.00
	
	// CONVENIO DESCONTOS MUTUA-SC.
	If al_Convenio = 53863 Then adc_desconto = 15.00
	
	//53759 $$HEX1$$1320$$ENDHEX$$ SINJUSC SIND DOS SERVIDORES DO PODER JUDICI$$HEX1$$c100$$ENDHEX$$RIO CATARINENSE.
	If al_Convenio = 53759 Then adc_desconto = 15.00
	
	//WHIRLPOOL/EMBRACO
	If al_Convenio = 50139 Or al_Convenio = 52725 Or al_Convenio = 52630 Or al_Convenio = 52462 Or al_Convenio = 53394 Or al_Convenio = 50007 Or al_Convenio = 52279 Or &
		al_Convenio = 52503 Or al_Convenio = 52327 Or al_Convenio = 53223 Then
		
		If as_Lei_Generico = "R"	Then
			adc_desconto = 20.00
		End If
		
		If as_Lei_Generico = "G"	Then
			adc_desconto = 50.00
		End If
	End If
	
	//TUPY
	If al_Convenio = 50717 Or al_Convenio = 53736 Then
		If as_Lei_Generico = "R"	Then
			adc_desconto = 20.00
		End If
		
		If as_Lei_Generico = "G"	Then
			adc_desconto = 40.00
		End If
	End If
	
	
	// SCHNEIDER / CISER
	If al_Convenio = 51365 Or al_Convenio = 50041  Or  al_Convenio = 54018  Or al_Convenio = 50040  Or  al_Convenio = 54019  Or al_Convenio = 54020   Then
		If as_Lei_Generico = "R"	Then
			adc_desconto = 20.00
		End If
		
		If as_Lei_Generico = "G"	Then
			adc_desconto = 40.00
		End If
	End If
	
	
	//GENERAL MOTORS
	If al_Convenio = 53567 Then
		If as_Lei_Generico = "R"	Then
			adc_desconto = 15.00
		End If
		
		If as_Lei_Generico = "G"	Then
			adc_desconto = 40.00
		End If
	End If
	
	//CELOS
	If al_Convenio = 50244 Then
		If as_Lei_Generico = "G"	Then
			adc_desconto = 25.00
		Else
			adc_desconto = 0.00
		End If
	End If
	
	//DESCONTO PLANO DE SAUDE(UNIMED) -- Ativo somente para lojas DC
	If al_Convenio = 54247 Then
		// Verifica se existe algum item que n$$HEX1$$e300$$ENDHEX$$o pode ter desconto no conv$$HEX1$$ea00$$ENDHEX$$nio da UNIMED, se existir zera o desconto;
		// TABELA: restricao_contrato_convenio
		If ids_restricao_contrato.Find( "cd_convenio = " +String(al_convenio) + " and nr_contrato = " +String(al_contrato) + " and cd_produto = " + String(al_produto), 1, ids_restricao_contrato.RowCount() ) > 0 Then
			adc_desconto = 0.00
		Else
			adc_desconto = 0.00
			
			If as_Lei_Generico = "G"	and (al_cd_tarja	= 1 or al_cd_tarja = 2)Then
				adc_desconto = 35.00
			ElseIf as_Lei_Generico <> "G" and (al_cd_tarja	= 1 or al_cd_tarja = 2) Then
				adc_desconto = 20.00
			End If
			
		End If
	End If
	
	//DESCONTO PLANO DE SAUDE(UNIMED) -- Ativo somente para lojas PP
	If al_Convenio = 55054 Then
		// Verifica se existe algum item que n$$HEX1$$e300$$ENDHEX$$o pode ter desconto no conv$$HEX1$$ea00$$ENDHEX$$nio da UNIMED, se existir zera o desconto;
		// TABELA: restricao_contrato_convenio
		If ids_restricao_contrato.Find( "cd_convenio = " +String(al_convenio) + " and nr_contrato = " +String(al_contrato) + " and cd_produto = " + String(al_produto), 1, ids_restricao_contrato.RowCount() ) > 0 Then
			adc_desconto = 0.00
		Else
			adc_desconto = 0.00
			
			If as_Lei_Generico = "G" and (al_cd_tarja	= 1 or al_cd_tarja = 2) Then
				adc_desconto = 40.00
			end if
			
			if as_Lei_Generico <> "G" and (al_cd_tarja	= 1 or al_cd_tarja = 2) Then
				adc_desconto = 15.00
			End If
		End If
	End If
	
	//DESCONTO PLANO DE SAUDE(CLINIPAM)
	If al_Convenio = 54659 or al_Convenio = 55080 or al_Convenio = 55081 Then
		If ids_restricao_contrato.Find( "cd_convenio = " +String(al_convenio) + " and nr_contrato = " +String(al_contrato) + " and cd_produto = " + String(al_produto), 1, ids_restricao_contrato.RowCount() ) > 0 Then
			adc_desconto = 0.00
		Else
			If as_Lei_Generico = "G"	Then
				adc_desconto = 35.00
			Else
				adc_desconto = 20.00
			End If
		End If
	End If
	
	//SCHULZ
	If al_Convenio = 50653 Or al_Convenio = 53826 Or al_Convenio = 54321 Or al_Convenio = 54322 Or + &
		al_Convenio = 54350 Or al_Convenio = 54351 Then
		If as_Lei_Generico = "G"	Then
			adc_desconto = 40.00
		Else
			adc_desconto = 15.00		
		End If
	End If
	
	//PORTOBELLO
	If al_Convenio = 51575 Or al_Convenio = 54477 Or al_Convenio = 54478 Or al_Convenio = 54482 Or al_Convenio = 55026 Or al_Convenio = 55027 Then
		If as_Lei_Generico = "G" Or as_Lei_Generico = "S" Then
			adc_desconto = 30.00
		Else
			adc_desconto = 24.00
		End If
	End If
	
	//CLAMED - QUIMIDROL - INCOR - AB Administra$$HEX2$$e700e300$$ENDHEX$$o de bens
	If al_Convenio = 50805 Or al_Convenio = 50633 Or  al_Convenio = 51135 Or al_Convenio = 54623 Then	
		If as_Lei_Generico = "G"	Then
			adc_desconto = 40.00
		Else
			If LeftA(as_subcategoria,6) = '102016' Then //Anticoncepcionais
				adc_desconto = 35.00			
			Else
				adc_desconto = 20.00
			End If	
		End If
		//VER COMO FAZER COM MANIPULADO	
	End If
	
	//GRUPO KOCK
	If al_Convenio = 53511 Or al_Convenio = 54783 Or al_Convenio = 54784 Or al_Convenio = 54785 Then
		If as_Lei_Generico = "G"	Then
			adc_desconto = 25.00
		Else
			adc_desconto = 10.00
		End If
	End If
	
	//Produto Vacina Gripe 742145 n$$HEX1$$e300$$ENDHEX$$o tem desconto em conv$$HEX1$$ea00$$ENDHEX$$nios internos, ocorre na aplicacao
	If al_produto = 742145 Then
		If al_Convenio <> 50805 And al_Convenio <> 50633 And al_Convenio <> 51135 And al_Convenio <> 54623 Then
			adc_desconto = 0.00	
		End If	
	End If
	
	//conv$$HEX1$$ea00$$ENDHEX$$nios do grupo Fahece
	If al_Convenio = 54753 Or al_Convenio = 54754 Or al_Convenio = 54755 Or al_Convenio = 54756 Or al_Convenio = 54757 Then	
		If as_Lei_Generico = "G"	Then
			adc_desconto = 25.00
		Else
			adc_desconto = 10.00
		End If
	End If
	
	//ASSOC. DE AMIGOS DO LAR ABDON BATISTA
	If al_Convenio = 52539 Then	
		If as_Lei_Generico = "G"	Then
			adc_desconto = 50.00
		Else
			adc_desconto = 20.00
		End If
	End If
	
	//Conselho Regional de Odontologia de Santa Catarina
	If al_Convenio = 54860 Then	
		If as_Lei_Generico = "G"	Then
			adc_desconto = 25.00
		Else
			adc_desconto = 15.00
		End If
	End If
	
	//DESCONTO MEDICOS(ANTIGO)
	If al_Convenio = 52849 Then
		If as_Lei_Generico = "G"	Then
			adc_desconto = 20.00
		Else
			adc_desconto = 15.00
		End If
	End If
	
	//SJM 
	If al_Convenio = 51730 Then
		adc_desconto = 20.00
	End If
	
Else
	If adc_desconto_parametrizado = -100.00 Then
		// N$$HEX1$$e300$$ENDHEX$$o faz nenhuma autaliza$$HEX2$$e700e300$$ENDHEX$$o
		gvo_Aplicacao.of_Grava_Log("Contrato com o par$$HEX1$$e200$$ENDHEX$$metro para considerar o desconto parametrizado est$$HEX1$$e100$$ENDHEX$$ sem desconto. ")
		Return True
	End If
	
	//DESCONTO PLANO DE SAUDE(UNIMED / CLINIPAM)
	If al_Convenio = 54247 or al_Convenio = 55054 or al_Convenio = 54659 or al_Convenio = 55080 or al_Convenio = 55081 Then
		If ids_restricao_contrato.Find( "cd_convenio = " +String(al_convenio) + " and nr_contrato = " +String(al_contrato) + " and cd_produto = " + String(al_produto), 1, ids_restricao_contrato.RowCount() ) > 0 Then
			adc_desconto = 0.00
		Else		
			adc_Desconto = adc_desconto_parametrizado
		End If
	Else
		adc_Desconto = adc_desconto_parametrizado	
	End If	
	
	//Zera o desconto se for somente no tarjado e o produto n$$HEX1$$e300$$ENDHEX$$o for tarjado
	If ps_somente_produto_tarjado = 'S' and (al_cd_tarja = 4 or Isnull(al_cd_tarja) or al_cd_tarja = 0 ) Then
		adc_Desconto = 0.00
	End If	
End If // If ls_id_utiliza_desc_parametrizado = 'N' Then

//Produto Vacina Gripe 742145 n$$HEX1$$e300$$ENDHEX$$o tem desconto em conv$$HEX1$$ea00$$ENDHEX$$nios internos, ocorre na aplicacao
If al_produto = 742145 Then
	If al_Convenio <> 50805 And al_Convenio <> 50633 And al_Convenio <> 51135 And al_Convenio <> 54623 Then
		adc_desconto = 0.00	
	End If	
End If

Select pc_desconto Into :lvdc_Desconto
From contrato_preco_convenio_prd
Where cd_convenio = :al_Convenio
  and nr_contrato = :al_Contrato
  and cd_produto  = :al_Produto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		//Chamado: 897102
		//Portobello n$$HEX1$$e300$$ENDHEX$$o atualiza, apenas insere produtos novos
		If (al_Convenio = 51575 Or al_Convenio = 54477 Or al_Convenio = 54478 Or al_Convenio = 54482) Then Return True		
		
		// Se o novo % de desconto for zero, exclui o registro da tabela
		If adc_Desconto = 0.00 Then
			Delete from contrato_preco_convenio_prd
			Where cd_convenio = :al_Convenio
			  and nr_contrato = :al_Contrato
			  and cd_produto  = :al_Produto
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				gvo_Aplicacao.of_Grava_Log("Erro na exclus$$HEX1$$e300$$ENDHEX$$o do produto no contrato. " + lvs_Chave + "~r" + SqlCa.SqlErrText)
				lvb_Sucesso = False
			End If			
		ElseIf lvdc_Desconto <> adc_Desconto Then			
			Update contrato_preco_convenio_prd
			Set pc_desconto = :adc_Desconto,
			    dh_atualizacao_desconto = getdate()
			Where cd_convenio = :al_Convenio
			  and nr_contrato = :al_Contrato
			  and cd_produto  = :al_Produto
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				gvo_Aplicacao.of_Grava_Log("Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do produto no contrato. " + lvs_Chave + "~r" + SqlCa.SqlErrText)
				lvb_Sucesso = False
			End If			
		End If
			
	Case 100
		
		// S$$HEX1$$f300$$ENDHEX$$ vai incluir se o % de desconto for maior que zero
		If adc_desconto > 0 Then
			Insert Into contrato_preco_convenio_prd (cd_convenio,   
																  nr_contrato,   
																  cd_produto,   
																  pc_desconto,   
																  dh_atualizacao_desconto)  
			Values (:al_Convenio,   
					  :al_Contrato,   
					  :al_Produto,   
					  :adc_Desconto,   
					  getdate())
			Using SqlCa;
	
			If SqlCa.SqlCode = -1 Then
				gvo_Aplicacao.of_Grava_Log("Erro na inclus$$HEX1$$e300$$ENDHEX$$o do produto no contrato. " + lvs_Chave + "~r" + SqlCa.SqlErrText)
				lvb_Sucesso = False
			End If	
		End If
		
	Case -1
		gvo_Aplicacao.of_Grava_Log("Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do produto no contrato. " + lvs_Chave + "~r" + SqlCa.SqlErrText)
		lvb_Sucesso = False
End Choose

Return lvb_Sucesso
end function

public function boolean of_verifica_desconto_parametro (long pl_convenio, long pl_contrato, string ps_grupo, string ps_lei_generico, ref decimal pdc_desconto, ref string ps_somente_produto_tarjado);String ls_Chave

ls_Chave = "(" + String(pl_convenio) + "-" + String(pl_contrato) + "-" + ps_grupo + "-" + ps_lei_generico + ")"	

// Script de carga
//INSERT INTO contrato_preco_convenio_desc ( cd_convenio, nr_contrato, cd_grupo, id_lei_generico, pc_desconto )  
//select distinct 54784, 3, '1', id_lei_generico, 10 from produto_geral
//;

Select pc_desconto, coalesce(id_somente_produto_tarjado, 'N')
Into :pdc_desconto, :ps_somente_produto_tarjado
From contrato_preco_convenio_desc
Where cd_convenio 		= :pl_Convenio
  	and nr_contrato 		= :pl_Contrato
  	and cd_grupo 			= :ps_grupo
  	and id_lei_generico	= :ps_lei_generico
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
		// Controle para validar se n$$HEX1$$e300$$ENDHEX$$o tem cadastrado, neste caso grava no log
		pdc_desconto = -100.00
	Case -1
		gvo_Aplicacao.of_Grava_Log("Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o desconto para do contrato. " + ls_Chave + "~r" + SqlCa.SqlErrText)
		Return False
End Choose

Return True
end function

on uo_ge627_contrato_convenio.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge627_contrato_convenio.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ids_restricao_contrato = Create dc_uo_ds_base

If Not ids_restricao_contrato.of_ChangeDataObject("ds_ge627_restricao_contrato_convenio") Then
	gvo_Aplicacao.of_Grava_Log("CONTRATO CONVENIO: Erro no of_ChangeDataObject  DS: ds_ge627_restricao_contrato_convenio")
	Return -1
End If
end event

event destructor;If IsValid( ids_restricao_contrato ) Then Destroy ids_restricao_contrato
end event

