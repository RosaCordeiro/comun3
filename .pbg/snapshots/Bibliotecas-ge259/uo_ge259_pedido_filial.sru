HA$PBExportHeader$uo_ge259_pedido_filial.sru
forward
global type uo_ge259_pedido_filial from nonvisualobject
end type
end forward

global type uo_ge259_pedido_filial from nonvisualobject
end type
global uo_ge259_pedido_filial uo_ge259_pedido_filial

type variables
boolean ib_endereco_500

boolean ib_pedido_teste_infra = False

boolean ib_EtiquetaLojaControladoVigiado = False
boolean ib_Filial_Wms_Grupo_Picking		   = False
boolean ib_Controlado_Endereco_Lote 	   = False
boolean ib_Origem_Processo				   = False
boolean ib_EsteiraImprimeEtiqueta  	        = False
Boolean ib_Prox_Filial 						 	= False

decimal idc_capacidade_caixa, idc_capacidade_caixa_estouro, idc_capacidade_caixa_padrao

decimal{3} idc_peso_caixa

Integer ii_Log, ii_Controle, ii_Controle2

Long il_Filial, il_Pedido

Integer ii_Total_Itens, ii_Esteira, ii_total_volumes, ii_Recipiente

String is_Gera_Picking_CX, is_Chave_LOG, is_id_alterna_geracao_pedido

dc_uo_ds_base ids_Etiquetas_Volume

dc_uo_ds_base   ivds_itens 

dc_uo_ds_base   ivds_grupo_atendimento_filial

Integer ii_grupo_picking
Boolean ib_gera_quebra, ib_vol_anterior_grupo

Date idt_data_pedido

end variables

forward prototypes
public function boolean of_localiza_endereco_separacao (long al_produto, ref string as_endereco)
public function boolean of_grava_log (string as_mensagem)
public function boolean of_insere_reserva_pulmao (string as_endereco, long al_produto, long al_etiqueta)
public function boolean of_insere_reserva_flow_rack (string as_endereco, long al_produto, long al_reserva)
public function boolean of_emite_etiqueta (long al_filial, long al_pedido, long al_volume)
public function boolean of_imprime_etiqueta (long al_filial, long al_pedido)
public function boolean of_gera_lista_separacao ()
public function boolean of_rateio_volume ()
public function boolean of_proximo_volume (ref long al_volume, decimal adc_capacidade_produto, decimal adc_peso_produto, long al_qtde)
public function boolean of_insere_lista_separacao_produto (long al_volume, long al_produto, string as_endereco, long al_quantidade, decimal adc_capacidade_litros, long al_caixa_padrao, long al_etiqueta_caixa, boolean ab_pulmao, decimal adc_peso_produto)
public function boolean of_insere_volume_caixa (long al_produto, string as_endereco, long al_caixa_padrao, long al_etiqueta_caixa)
public function boolean of_grava_volume_caixa_padrao ()
public function boolean of_verifica_rateio_volumes ()
public function boolean of_gera_picking ()
public function boolean of_valida_quantidade_pedido ()
public function boolean of_parametro_geracao_cx_padrao ()
public function boolean of_grava_log (string as_mensagem, boolean ab_envia_email)
public function boolean of_imprime_lista_almoxarifado ()
public function long of_pedidos_colocados (string as_tipo)
public subroutine of_gera_barcode (dc_uo_ds_base pds_pedido)
public function boolean of_imprimir_pedidos_almoxarifado (string as_tipo)
public function boolean of_imprimir_pedidos (string as_tipo)
public function boolean of_libera_pedidos_colocados (string as_tipo)
public function boolean of_imprimir_listagem_separacao_nova (string as_tipo)
public function boolean of_retira_produto_sem_saldo ()
public function boolean of_imprime_etiqueta_imp_termica (long al_filial, long al_pedido, long al_volume)
public function boolean of_processa_geracao_picking ()
public subroutine of_leiame ()
public function boolean of_grava_volume_caixa_padrao_almox ()
public function boolean of_imprime_picking_pulmao (long al_filial, long al_pedido, long al_volume)
public function boolean of_tipo_impressora (long ai_esteira, ref string as_impressora, ref string as_parametro)
public function boolean of_filial_liberada_esteira_tracionada (long al_filial, ref boolean ab_filial_liberada)
public function boolean of_altera_situacao_pedido_empurrado ()
private function boolean of_update_pedido_empurrado (long al_filial, long al_pedido, ref string as_erro)
public function boolean of_monta_ordem_separacao_nova (long al_filial, long al_pedido)
public function boolean of_rateio_volume_estourado (long al_filial, long al_pedido, long al_esteira)
public function boolean of_exclui_volume_estourado (long al_filial, long al_pedido, long al_esteira)
public function boolean of_valida_qtde_apos_rateio_estouro (long al_filial, long al_pedido, long al_esteira)
public function boolean of_imprime_picking (long al_filial, long al_pedido, long al_flow_pulmao, long al_volume)
public function boolean of_imprime_picking_flow (long al_filial, long al_pedido, long al_volume)
public function boolean of_finaliza_geracao_cx_fechada (ref string as_erro)
public function boolean of_carrega_parametros_loja (long al_filial)
public function boolean of_gera_lista_separacao (long al_produto, string as_endereco, long al_prioridade, ref long al_qtde_pedida, decimal adc_litros, long al_prioridade_maxima, decimal adc_peso_grama)
public function boolean of_altualiza_picking_controlado (long al_filial, long al_pedido, ref string as_erro)
public function boolean of_verifica_situacao_pedido (long al_tipo_volume, ref boolean ab_continua_geracao, boolean ab_controlado)
public function boolean of_processa_geracao_picking (long al_filial, long al_pedido, boolean ab_pedido_almoxarifado, boolean ab_pedido_controlado, date adt_data_pedido)
private function boolean of_gera_lista_separacao_produto (long al_filial, long al_pedido, long al_produto, long al_prioridade_maxima, decimal adc_peso_grama)
public function boolean of_altera_situacao_pedido (boolean ab_pedido_controlado)
public function boolean of_localiza_endereco_cd (ref string as_cep, ref string as_endereco, ref string as_erro)
public function boolean of_obtem_centro_custo_cd (ref string as_centro_custo_cd, ref string as_erro)
public function boolean of_departamento_pedido (long al_filial, long al_pedido_distribuidora, ref string as_centro_custo, ref boolean ab_centro_custo, ref string as_endereco, ref string as_cep, ref string as_cidade, ref string as_unidade_federacao, ref long al_rota, ref long al_filial_entrega, ref boolean ab_centro_entrega, ref long al_nr_prioridade, ref long al_centro_custo_entrega, ref string as_requisitante)
public function boolean of_verifica_nome_requisitante (long al_filial, long al_pedido, ref string as_nome_requisitante)
public function boolean of_localiza_capacidade_caixa (long al_esteira, long al_recipiente, ref decimal adc_capacidade, ref string as_erro)
public function boolean of_esteira_imprime_picking_etiqueta (long al_esteira)
public function boolean of_verifica_produto_ped_urgente (long al_filial, long al_esteira)
public function boolean of_grava_log_grupo_atendimento (string as_messagem, ref string as_erro)
public function boolean of_verifica_grupo_atendimento_filial (long al_filial, long al_pedido, boolean ab_prox_filial, integer ai_esteira, long al_linhas, ref long al_grupo_atendimento)
public function boolean of_atualiza_grupo_atendimento (long al_cd_grupo_atendimento, integer ai_esteira, ref string as_erro)
public function boolean of_carrega_parametro_filial (ref long al_filial_estoque, ref string as_msg)
end prototypes

public function boolean of_localiza_endereco_separacao (long al_produto, ref string as_endereco);Boolean lb_Sucesso = True

Long ll_Linhas

dc_uo_ds_base lds

lds = Create dc_uo_ds_base

If Not lds.of_ChangeDataObject("ds_ge259_endereco_flow_rack") Then
	Destroy(lds)
	Return False
End If

ll_Linhas = lds.Retrieve(al_Produto)

If ll_Linhas > 0 Then
	as_endereco		= lds.Object.cd_endereco[1]
Else
	If ll_Linhas = 0 Then
		This.of_grava_log("N$$HEX1$$e300$$ENDHEX$$o existe endere$$HEX1$$e700$$ENDHEX$$o cadastrado no flow rack para este produto '" + String(al_Produto) + "'.")
	Else
		This.of_grava_log("Erro ao recuperar o endere$$HEX1$$e700$$ENDHEX$$o do flow rack para o produto '" + String(al_Produto) + "'.")
	End If
End If

Destroy(lds)

Return lb_Sucesso


end function

public function boolean of_grava_log (string as_mensagem);Integer lvi_Status

String ls_Anexo[]

String lvs_Mensagem 

lvs_Mensagem = String(Today(), "dd/mm/yyyy") + " " + 	String(Now(), "hh:mm:ss") + " " + as_Mensagem
	
lvi_Status = FileWrite(ii_Log, lvs_Mensagem)

If lvi_Status <> LenA(lvs_Mensagem) Then	
	gf_ge202_envia_email_automatico(13, " - LOG ", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro no arquivo de log da aplica$$HEX2$$e700e300$$ENDHEX$$o.", ls_Anexo)
End If

Return True
end function

public function boolean of_insere_reserva_pulmao (string as_endereco, long al_produto, long al_etiqueta);Long ll_Achou

Select qt_reserva
Into :ll_Achou
From wms_reserva_pulmao
Where	cd_endereco 		=	:as_Endereco
	and	cd_produto			=	:al_Produto
	and	nr_etiqueta_caixa 	=	:al_etiqueta
Using Sqlca;

Choose Case SqlCa.SqlCode
	Case 0
		
		UPDATE wms_reserva_pulmao  
		SET qt_reserva = qt_reserva + 1
		From wms_reserva_pulmao
		Where	cd_endereco 		=	:as_Endereco
			and	cd_produto			=	:al_Produto
			and	nr_etiqueta_caixa 	=	:al_etiqueta
		Using Sqlca;
			 
		If Sqlca.SqlCode = -1 Then
			SqlCa.of_MsgDbError("Erro ao atualizar reservada do produto '" + STring(al_Produto) + "'")
			Return False
	  	End If	 
		
	Case 100
		
	  INSERT INTO wms_reserva_pulmao	(	cd_endereco,   
																cd_produto,   
																nr_etiqueta_caixa,   
																qt_reserva )  
	  VALUES (:as_Endereco,   
					:al_Produto,   
					:al_etiqueta,  
					1)
	  Using Sqlca;
	  
	  If Sqlca.SqlCode = -1 Then
		SqlCa.of_MsgDbError("Erro ao localizar a quantidade reservada do produto '" + STring(al_Produto) + "'")
		Return False
	  End If
		
	Case -1
		SqlCa.of_MsgDbError("Erro ao localizar a quantidade reservada do produto '" + STring(al_Produto) + "'")
		Return False
End Choose

Return True

end function

public function boolean of_insere_reserva_flow_rack (string as_endereco, long al_produto, long al_reserva);Long ll_Achou

String ls_MSG

Select qt_reserva
Into :ll_Achou
From wms_reserva_flow_rack
Where	cd_endereco 		=	:as_Endereco
	and	cd_produto			=	:al_Produto
Using Sqlca;

Choose Case SqlCa.SqlCode
	Case 0
		
		UPDATE wms_reserva_flow_rack
		SET qt_reserva = qt_reserva + :al_reserva
		Where	cd_endereco 		=	:as_Endereco
			and	cd_produto			=	:al_Produto
		Using Sqlca;
			 
		If Sqlca.SqlCode = -1 Then
			ls_MSG = "Erro ao atualizar reservada no flow flack do produto '" + STring(al_Produto) + "'. " + SqlCa.SqlErrText
			SqlCa.of_RollBack()
			This.of_grava_log(ls_MSG)
			MessageBox("Erro", ls_MSG, StopSign!)
			Return False
	  	End If	 
		
	Case 100
		
	  INSERT INTO wms_reserva_flow_rack	(cd_endereco,   
																cd_produto,   
																qt_reserva )  
	  VALUES (:as_Endereco,   
					:al_Produto,   
					:al_reserva)
	  Using Sqlca;
	  
	  If Sqlca.SqlCode = -1 Then
		ls_MSG = "Erro ao localizar a quantidade reservada no flow flack do produto '" + STring(al_Produto) + "'. " + SqlCa.SqlErrText
		SqlCa.of_RollBack()
		This.of_grava_log(ls_MSG)
		MessageBox("Erro", ls_MSG, StopSign!)
		Return False
	  End If
		
	Case -1
		ls_MSG ="Erro ao localizar a quantidade reservada no flow flack do produto '" + STring(al_Produto) + "'. " + SqlCa.SqlErrText
		SqlCa.of_RollBack()
		This.of_grava_log(ls_MSG)
		MessageBox("Erro", ls_MSG, StopSign!)
		Return False
		
End Choose

Return True

end function

public function boolean of_emite_etiqueta (long al_filial, long al_pedido, long al_volume);Long 	ll_Linhas,&
		ll_Linha,&
		ll_Row,&
		ll_teste,&
		ll_Qt_Prd_Geladeira,&
		ll_Esteira,&
		ll_Rota,&
		ll_Filial,&
		ll_Nr_Ordem_Bacia,&
		ll_Cd_Centro_Custo_Entrega

String 	ls_DS,&
			ls_Id_Rede,&
			ls_Volume_Extra,&
			ls_De_Volume_Extra,&
			ls_Pedido_Almoxarifado,&
			ls_Departamento,&
			ls_Endereco,&
			ls_Cep,&
			ls_Cidade,&
			ls_Unidade_Federacao,&
			ls_Requisitante
			
Boolean 	lb_Departamento = False,&
			lb_Centro_Custo_Entrega = False

dc_uo_ds_base lds
lds = Create dc_uo_ds_base

If Not lds.of_ChangeDataObject("ds_ge259_dados_etiquetas_volumes") Then
	Destroy(lds)
	Return False
End If

ll_Linhas = lds.Retrieve(al_Filial, al_Pedido, al_volume)

If ll_Linhas > 0 Then	
	
	If lds.object.id_pedido_almoxarifado[1] = "S" Then
		If Not of_Departamento_Pedido	(	al_Filial,&
													al_Pedido,&
													Ref ls_Departamento,&
													Ref lb_Departamento,&
													Ref ls_Endereco,&
													Ref ls_Cep,&
													Ref ls_Cidade,&
													Ref ls_Unidade_Federacao,&
													Ref ll_Rota,&
													Ref ll_Filial,&
													Ref lb_Centro_Custo_Entrega,&
													Ref ll_Nr_Ordem_Bacia,&
													Ref ll_Cd_Centro_Custo_Entrega,&
													Ref ls_Requisitante) Then
			Return False
		End If
	End If

	For ll_Linha = 1 To ll_Linhas
		ll_Row = ids_Etiquetas_Volume.RowCount() + 1
		
		If lb_Centro_Custo_Entrega Then	
			ids_Etiquetas_Volume.Object.de_filial						[ll_Row]	= ls_Departamento
			ids_Etiquetas_Volume.Object.cd_filial						[ll_Row]	= ll_Filial
			ids_Etiquetas_Volume.Object.de_endereco				[ll_Row]	= ls_Endereco
			ids_Etiquetas_Volume.Object.nr_cep						[ll_Row]	= ls_Cep
			ids_Etiquetas_Volume.Object.nm_cidade					[ll_Row]	= ls_Cidade
			ids_Etiquetas_Volume.Object.nm_unidade_federacao	[ll_Row]	= ls_Unidade_Federacao
			ids_Etiquetas_Volume.Object.nr_rota						[ll_Row]	= ll_Rota
		Else
			ids_Etiquetas_Volume.Object.de_filial						[ll_Row]	= lds.Object.de_filial						[ll_Linha]
			ids_Etiquetas_Volume.Object.cd_filial						[ll_Row]	= lds.Object.cd_filial						[ll_Linha]
			ids_Etiquetas_Volume.Object.de_endereco				[ll_Row]	= lds.Object.de_endereco				[ll_Linha]
			ids_Etiquetas_Volume.Object.nr_cep						[ll_Row]	= lds.Object.nr_cep						[ll_Linha]
			ids_Etiquetas_Volume.Object.nm_cidade					[ll_Row]	= lds.Object.nm_cidade					[ll_Linha]
			ids_Etiquetas_Volume.Object.nm_unidade_federacao	[ll_Row]	= lds.Object.nm_unidade_federacao	[ll_Linha]
			ids_Etiquetas_Volume.Object.nr_rota						[ll_Row]	= lds.Object.nr_rota_entrega			[ll_Linha]	
		End If
		
		ids_Etiquetas_Volume.Object.nr_ordem_bacia				[ll_Row]	= lds.Object.nr_ordem_bacia			[ll_Linha]
		ids_Etiquetas_Volume.Object.nr_volumes					[ll_Row]	= lds.Object.nr_volumes					[ll_Linha]
		ids_Etiquetas_Volume.Object.total_volumes					[ll_Row]	= lds.Object.total_volumes				[ll_Linha]
		ids_Etiquetas_Volume.Object.id_rede							[ll_Row]	= lds.Object.id_rede						[ll_Linha]		
		ids_Etiquetas_Volume.Object.nr_pedido						[ll_Row]	= lds.Object.nr_pedido_distribuidora	[ll_Linha]	
		
		ids_Etiquetas_Volume.Object.nr_chave_volume			[ll_Row]	= lds.Object.nr_chave_volume			[ll_Linha]	
		
		ll_Qt_Prd_Geladeira 		= lds.Object.qt_produtos_geladeira	[ll_Linha]	
		ls_Volume_Extra			= lds.Object.id_volume_extra			[ll_Linha]	
		ls_Pedido_Almoxarifado	= lds.Object.id_pedido_almoxarifado	[ll_Linha]	
		ll_Esteira						= lds.Object.cd_esteira					[ll_Linha]			
		
		SetNull(ls_De_Volume_Extra)
		
		If ls_Pedido_Almoxarifado = "S" Then  // ALMOXARIFADO
			If ls_Volume_Extra = "S" Then
				ls_De_Volume_Extra = "ALMOXARIFADO / VOL EXTRA"	
			Else
				ls_De_Volume_Extra = "ALMOXARIFADO"	
			End If
			ids_Etiquetas_Volume.Object.nm_requisitante[ll_Row] = "Req.:"+ls_Requisitante
		Else
			If ll_Esteira = 2 Then   // MEDICAMENTO
				If ls_Volume_Extra = "S" Then 
					ls_De_Volume_Extra = "MEDICAMENTO/VOL EXTRA"	
				Else
					ls_De_Volume_Extra = "MEDICAMENTO"
				End If 			
			ElseIf ll_Esteira = 1 Then  // PERFUMARIA
				If ls_Volume_Extra = "S" Then 
					ls_De_Volume_Extra = "PERFUMARIA/VOL EXTRA"	
				Else
					ls_De_Volume_Extra = "PERFUMARIA"
				End If 
			ElseIf ll_Esteira = 3 Then // CONTROLADO
					ls_De_Volume_Extra = "CONFERIR NA LOJA"			
			ElseIf ll_Esteira =7 Then 	// SUPL. INFANTIL 
				If ls_Volume_Extra = "S" Then 
					ls_De_Volume_Extra = "SUPL.INFANTIL/VOL EXTRA"
				Else
					ls_De_Volume_Extra = "SUPL.INFANTIL"	
				End If 				
			Else
				If (ll_Qt_Prd_Geladeira > 0) And (ls_Volume_Extra = "S") Then
					ls_De_Volume_Extra = "TERMOL$$HEX1$$c100$$ENDHEX$$BIL/VOL EXTRA"	
				ElseIf (ll_Qt_Prd_Geladeira < 1) And (ls_Volume_Extra = "S") Then
					ls_De_Volume_Extra = "VOLUME EXTRA"	
				ElseIf (ll_Qt_Prd_Geladeira > 0) And (ls_Volume_Extra <> "S") Then	
					ls_De_Volume_Extra = "TERMOL$$HEX1$$c100$$ENDHEX$$BIL"				
				End If 
			End If
		End If
		
		ids_Etiquetas_Volume.Object.cd_filial_cod_barras	[ll_Row]	= al_Filial
		ids_Etiquetas_Volume.Object.nm_volume_extra	[ll_Row]	= ls_De_Volume_Extra
		
	Next
ElseIf ll_Linhas < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar as informa$$HEX2$$e700f500$$ENDHEX$$es para a impress$$HEX1$$e300$$ENDHEX$$o da etiqueta.")
End If

Destroy(lds)
end function

public function boolean of_imprime_etiqueta (long al_filial, long al_pedido);Long ll_Linha, ll_linhas, ll_Volume

dc_uo_ds_base lds_Pedido_Volume
lds_Pedido_Volume = Create dc_uo_ds_base					
If Not lds_Pedido_Volume.of_ChangeDataObject("ds_ge259_filial_pedido_volume") Then
	Destroy(lds_Pedido_Volume)						
End If 

ll_Linhas = lds_Pedido_Volume.Retrieve(al_Filial, al_Pedido)
If ll_Linhas > 0 Then						
	For ll_Linha  = 1 To ll_Linhas							
		ll_Volume = lds_Pedido_Volume.Object.nr_volume	[ll_Linha]
		If Not IsNull(ll_Volume) Then								
			This.of_emite_etiqueta(al_Filial, al_Pedido, ll_Volume)								
		End If
	Next
End If
Return True
end function

public function boolean of_gera_lista_separacao ();Long 	ll_Linhas,&
		ll_Linha,&
		ll_Produto,&
		ll_Qtde_Pedida,&
		ll_Qtde_Pick,&
		ll_Prioridade,&
		ll_Qtde,&
		ll_Produto_Anterior,&
		ll_Find,&
		ll_Qt_Saldo_CC
		
Long ll_Prioridade_Maxima, ll_Achou

String ls_Endereco, ls_MSG, ls_Endereco_Anterior, ls_Grupo_Psico

Decimal ldc_Capacidade_Litro, ldc_Capacidade_Eco

Decimal {3} ldc_Peso_Grama, ldc_Peso_Grama_Est

dc_uo_ds_base lds

Boolean	lb_Esteira_Tracionada = False

Try
	lds = Create dc_uo_ds_base
	
	//Se for medicamentos, verifica se a filial $$HEX1$$e900$$ENDHEX$$ esteira tracionada
	If ii_Esteira = 2 Then
		If Not of_Filial_Liberada_Esteira_Tracionada(il_Filial, Ref lb_Esteira_Tracionada) Then
			Return False
		End If
	End If
	
	// Aqui s$$HEX1$$f300$$ENDHEX$$ entra quanto a esteira for de MEDICAMENTO
	If lb_Esteira_Tracionada Then
		If Not lds.of_ChangeDataObject("ds_ge259_lista_separacao_esteira_tracionada") Then Return False
		/// Processo para Grupo Picking Na Lista de Separa$$HEX2$$e700e300$$ENDHEX$$o
		If ib_Filial_Wms_Grupo_Picking Then 
			If ii_grupo_picking > 0 Then			
				lds.of_AppendWhere( "  e.cd_produto  in (  select   cd_produto  from  wms_grupo_picking_prd   where  cd_grupo_pick  = "+ String(ii_grupo_picking) + ")")	
			Else 
				lds.of_AppendWhere( "  e.cd_produto not  in (  select  distinct    cd_produto  from  wms_grupo_picking_prd    ) " ) 
			End If
		End If 
		
	Else
		If Not of_Monta_Ordem_Separacao_Nova(il_Filial, il_Pedido) Then Return False
			
		If Not lds.of_ChangeDataObject("ds_ge259_lista_separacao_ordem") Then Return False
		
		/// Processo para Grupo Picking Na Lista de Separa$$HEX2$$e700e300$$ENDHEX$$o
		If ib_Filial_Wms_Grupo_Picking Then 
			If ii_grupo_picking > 0 Then			
				lds.of_AppendWhere( "  c.cd_produto  in (  select   cd_produto  from  wms_grupo_picking_prd   where  cd_grupo_pick  = "+ String(ii_grupo_picking) + ")")	
			Else 
				lds.of_AppendWhere( "  c.cd_produto  not in (  select   cd_produto  from  wms_grupo_picking_prd  ) " )	
			End If		
		End If 		
	End If	
	
	If ib_Filial_Wms_Grupo_Picking  Then 
		If ii_grupo_picking > 0 Then	  
			ib_gera_quebra = True  
		End If 	
	
		 // Merge   
		If ii_grupo_picking = 0 Then
			ib_gera_quebra = ib_vol_anterior_grupo 			
			ib_vol_anterior_grupo = False
			End If
	End If 
	
	
	ll_Linhas = lds.Retrieve(il_Filial, il_Pedido, ii_Esteira)
		
	For ll_Linha = 1 To ll_Linhas
				
		ll_Produto 				= lds.Object.cd_produto								[ll_Linha]
		ls_Endereco				= lds.Object.cd_endereco							[ll_Linha]
		ll_Qtde_Pedida			= lds.Object.qt_atendida								[ll_Linha]
		ll_Qtde_Pick 			= lds.Object.qt_lista_separacao					[ll_Linha]
		ll_Prioridade				= lds.Object.nr_prioridade							[ll_Linha]
		ldc_Capacidade_Litro	= lds.Object.qt_capacidade_litro					[ll_Linha] 	
		ldc_Capacidade_Eco	= lds.Object.qt_capacidade_litro_ecommerce	[ll_Linha] 	
		ldc_Peso_Grama		= lds.Object.qt_peso_kg								[ll_Linha]
		ldc_Peso_Grama_Est	= lds.Object.qt_peso_kg_estoque					[ll_Linha]
		ls_Grupo_Psico			= lds.Object.cd_grupo_psico						[ll_Linha]
				
		If ll_Produto  = 702537 Then
			ll_Produto = 702537
		End If
		
		If ldc_Capacidade_Litro = 0 Then ldc_Capacidade_Litro = ldc_Capacidade_Eco
		
		If ldc_Peso_Grama_Est > 0 Then 
			ldc_Peso_Grama = ldc_Peso_Grama_Est
		End If
		
		// Processo Controlado Lote // Esteira = 3 // Conta Corrente Saldo: Tabela WMS_LOCALIZACAO_PEDIDO_CC
		If (ii_Esteira = 3) and (ib_Controlado_Endereco_Lote) and Not IsNull(ls_Grupo_Psico) Then
			
			// Para os controlados os produtos n$$HEX1$$e300$$ENDHEX$$o estar$$HEX1$$e300$$ENDHEX$$o em ordem de produto, mas sim por endere$$HEX1$$e700$$ENDHEX$$o
			
			Select sum(coalesce(qt_lista_separacao, 0))
			Into :ll_Qtde_Pick
			From pedido_distribuidora_produto
			Where cd_filial = :il_Filial
			    and nr_pedido_distribuidora = :il_Pedido
			    and cd_produto = :ll_Produto
			Using Sqlca;
			
			If SqlCa.SqlCode = - 1 Then
			   ls_MSG =	"Localizar Soma Qtd_Lista_Separacao na pedido_distribuidora_produto para o produto '" + String(ll_Produto) + "'.~r~r" +&
								"Erro: '" + SQLCA.SQLErrText + "'."
			   SqlCa.of_Rollback()	
			   This.of_grava_log(ls_MSG)
			   MessageBox("Erro", ls_MSG, StopSign!)
			   Return False				
			End If
								
			ll_Qtde = ll_Qtde_Pedida - ll_Qtde_Pick
			
			If ll_Qtde > 0 Then 
			
				// Localiza Saldo Nova Tabela: WMS_LOCALIZACAO_PEDIDO_CC
				Select sum(coalesce(qt_saldo - qt_saldo_utilizado, 0))
				Into :ll_Qt_Saldo_CC
				From  wms_localizacao_pedido_cc
				Where dh_pedido =:idt_data_pedido  
				And cd_endereco = :ls_Endereco
				And cd_produto = :ll_Produto
				Using SqlCa;
				
				Choose Case SqlCa.Sqlcode
					Case 0
					Case 100
						ll_Qt_Saldo_CC = 0
					Case -1 
						ls_MSG =	"Localizar ll_Qt_Saldo_CC na Tabela WMS_LOCALIZACAO_PEDIDO_CC para o produto '" + String(ll_Produto) + "'.~r~r" +&
										 "Erro: '" + SQLCA.SQLErrText + "'."
						SqlCa.of_Rollback()	
						This.of_grava_log(ls_MSG)
						MessageBox("Erro", ls_MSG, StopSign!)
						Return False			
				End Choose
				
				If ll_Qt_Saldo_CC > 0  Then
					
					If ll_Qt_Saldo_CC <=  ll_Qtde Then
						ll_Qtde = ll_Qt_Saldo_CC
					End If
					
					Update wms_localizacao_pedido_cc
					Set qt_saldo_utilizado = qt_saldo_utilizado + :ll_Qtde,
						  dh_inclusao = getdate()
					Where dh_pedido =:idt_data_pedido
					And cd_endereco  =:ls_Endereco
					And cd_produto 	=:ll_Produto
					Using SqlCa; 
					
					If SqlCa.SqlCode = - 1 Then
			   			ls_MSG =	"Atualizar SaldoUtilizado na Tabela WMS_LOCALIZACAO_PEDIDO_CC para o produto '" + String(ll_Produto) + "'.~r~r" +&
										 "Erro: '" + SQLCA.SQLErrText + "'."
				   		SqlCa.of_Rollback()	
				   		This.of_grava_log(ls_MSG)
				   		MessageBox("Erro", ls_MSG, StopSign!)
				   		Return False				
					End If
				Else
					ll_Qtde = 0 
				End If				
			End If					
		Else
			If ll_Produto <> ll_Produto_Anterior Then
				ll_Produto_Anterior 	= ll_Produto
				ll_Qtde 					= ll_Qtde_Pedida - ll_Qtde_Pick
			Else
				Continue			
			End If
		End If
		
		If ll_Qtde > 0 Then
			
			If (ii_Esteira = 3) and (ib_Controlado_Endereco_Lote) and Not IsNull(ls_Grupo_Psico) Then
				// Para cada produto controlado haver$$HEX1$$e100$$ENDHEX$$ um endere$$HEX1$$e700$$ENDHEX$$o por lote.
				ll_Achou = 1
			Else
				// Se n$$HEX1$$e300$$ENDHEX$$o for a esteria de controlado verifica se o produto esta em mais de um endere$$HEX1$$e700$$ENDHEX$$o
				Select count(*), max(nr_prioridade)
				Into :ll_Achou, :ll_Prioridade_Maxima
				From wms_endereco_produto a
				Where a.cd_produto= :ll_Produto
				Using SqlCa;
				  
				If SqlCa.SqlCode = -1 Then
					ls_MSG =	"Localizar se existe mais de um endere$$HEX1$$e700$$ENDHEX$$o para o produto '" + String(ll_Produto) + "'.~r~r" +&
									"Erro: '" + SQLCA.SQLErrText + "'."
					SqlCa.of_Rollback()
					This.of_grava_log(ls_MSG)
					MessageBox("Erro", ls_MSG, StopSign!)
					Return False
				End If
			End If
				
			If ll_Achou > 1 Then
				If Not This.of_gera_lista_separacao_produto(il_Filial, il_Pedido,  ll_Produto, ll_Prioridade_Maxima, ldc_Peso_Grama) Then 	Return False
			Else
				If Not This.of_gera_lista_separacao(ll_Produto, ls_Endereco, ll_Prioridade, ref ll_Qtde, ldc_Capacidade_Litro,&
															  ll_Prioridade_Maxima, ldc_Peso_Grama) Then
					Return False
				End If
			End If
	
		End If //  ll_Qtde > 0 Then
		
	Next
		
finally
	Destroy(lds)
end try

Return True
end function

public function boolean of_rateio_volume ();Long	ll_Linhas,&
		ll_Quantidade,&
		ll_Qt_Geladeira,&
		ll_Qt_Vacina,&
		ll_Filial_Estoque
		
String ls_Erro		

Decimal ldc_Litros_Pedido, ldc_Quantidade, ldc_Decimal

dc_uo_ds_base lds

// Novo Para buscar do Cadastro
If Not of_localiza_capacidade_caixa(ii_Esteira, ii_Recipiente, Ref idc_capacidade_caixa, Ref ls_Erro) Then 
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informa$$HEX2$$e700f500$$ENDHEX$$es Bacia:'" + ls_Erro + "'.")
	Return False
End If 

If not of_carrega_parametro_filial(Ref ll_Filial_Estoque,Ref ls_Erro ) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro:'" + ls_Erro + "'.")
	Return False
End if

idc_capacidade_caixa_estouro 	= idc_capacidade_caixa
idc_capacidade_caixa_padrao	= idc_capacidade_caixa

try
	lds = Create dc_uo_ds_base
	If Not lds.of_ChangeDataObject("ds_ge259_produto_pedido") Then Return False

	/// Processo para Grupo Picking Na Lista de Separa$$HEX2$$e700e300$$ENDHEX$$o
	If ib_Filial_Wms_Grupo_Picking Then 
		If ii_grupo_picking > 0 Then
			lds.of_AppendWhere( "  g.cd_produto  in (  select   cd_produto  from  wms_grupo_picking_prd   where  cd_grupo_pick  = "+ String(ii_grupo_picking) + ")")
		Else
			lds.of_AppendWhere( "  g.cd_produto  not  in (  select  distinct  cd_produto  from  wms_grupo_picking_prd  ) " )
		End If
	End If 	
	
	ll_Linhas = lds.Retrieve(il_Filial, il_Pedido, ii_Esteira)
	
	If ll_Linhas > 0 Then
		//ll_Qt_Geladeira		= lds.GetItemNumber(lds.RowCount(), "qt_produtos_geladeira")
		ldc_Litros_Pedido 	= lds.GetItemDecimal(lds.RowCount(), "qt_litro_unitario_total")
		
		//ll_Qt_Vacina			= lds.GetItemNumber(lds.RowCount(), "qt_produtos_vacina")
		
//		// Geladeira : Sem Vacinas
//		If ll_Qt_Geladeira > 0 Then
//			ldc_Litros_Pedido += 9.40
//		End If
//		
//		// Geladeira : Com Vacina
//		If ll_Qt_Vacina > 0 Then
//			ldc_Litros_Pedido += 9.40
//		End If

		//Se for geladeira ou vacina e se a cubagem do pedido for maior que a determinada de 1.5 litros utiliza 3.5 litros, uma caixa de isopor maior
		If (ii_Esteira = 6) Then
			If ldc_Litros_Pedido > idc_capacidade_caixa Then
				idc_capacidade_caixa = 3.5
			End If
		End If

		If ldc_Litros_Pedido > idc_capacidade_caixa Then
			ldc_Quantidade 		=  round(ldc_Litros_Pedido / idc_capacidade_caixa, 2)
								
			ll_Quantidade		= Truncate(ldc_Quantidade, 0)
			ldc_Decimal 	 	= ldc_Quantidade - ll_Quantidade
		
			If ldc_Decimal >= 0.01 Then
				ll_Quantidade = ll_Quantidade + 1
				idc_capacidade_caixa = round(ldc_Litros_Pedido / ll_Quantidade, 2)
			End If
			
			ii_total_volumes = ll_Quantidade		
		Else
			ii_total_volumes = 1
		End If
	End If
		
finally
	Destroy(lds)
end try

Return True
end function

public function boolean of_proximo_volume (ref long al_volume, decimal adc_capacidade_produto, decimal adc_peso_produto, long al_qtde);Boolean lb_Insere_Lote = False

Decimal 	lvdc_Capacidade_Utilizada,&
			ldc_Percentual,&
			ldc_Percentual_Parametro

Decimal{3} 	ldc_Peso_Volume,&
				ldc_Peso_Utilizado

Long	ll_Proximo_Volume,&
		ll_Total_Volumes,&
		ll_Qtde_Volumes
		
Long ll_Chave_Volume

String 	ls_MSG

Select max(nr_volume)
Into :ll_Proximo_Volume
From wms_lista_separacao
Where cd_filial							=:il_Filial
  	and nr_pedido_distribuidora 	=:il_pedido
	and cd_tipo_volume				= 1
	and cd_esteira 						= :ii_Esteira
	and dh_cancelamento is null
Using SqlCa;

/// Processo para Grupo Picking Na Lista de Separa$$HEX2$$e700e300$$ENDHEX$$o
If ib_Filial_Wms_Grupo_Picking Then 
	If ib_gera_quebra Then
		ib_vol_anterior_grupo = ib_gera_quebra
		SetNull(ll_Proximo_Volume) // For$$HEX1$$e700$$ENDHEX$$a quebra para produtos grandes
	End If
	
	ib_gera_quebra = False
End If 



Choose Case SqlCa.SqlCode
	Case 0
		
		If ll_Proximo_Volume = 3 Then
			ll_Proximo_Volume = 3
		End IF
		
		If IsNull(ll_Proximo_Volume) Then
			lb_Insere_Lote = True
		Else
		
			Select coalesce(qt_capacidade_utilizada, 0), coalesce(qt_peso_kg, 0)
			Into :lvdc_Capacidade_Utilizada, :ldc_Peso_Volume
			From wms_lista_separacao
			Where cd_filial							=:il_Filial
				and nr_pedido_distribuidora 	=:il_pedido
				and cd_tipo_volume				= 1
				and nr_volume						= :ll_Proximo_Volume
				and cd_esteira 						= :ii_Esteira
			Using SqlCa;
			
			Choose Case SqlCa.SqlCode 
				Case 0
				Case 100
				Case -1
					ls_MSG = "Localiza$$HEX2$$e700e300$$ENDHEX$$o da Capacidade Utilizada do Volume. " + SqlCa.SqlErrText
					SqlCa.of_RollBack()
					This.of_grava_log(ls_MSG)
					MessageBox("Erro", ls_MSG, StopSign!)
					Return False
			End Choose
					
			lvdc_Capacidade_Utilizada 	= lvdc_Capacidade_Utilizada + round(adc_capacidade_produto * al_qtde, 2)
			
			ldc_Peso_Volume				= ldc_Peso_Volume + round(adc_peso_produto * al_qtde, 3) 
						
			ldc_Percentual = round((lvdc_Capacidade_Utilizada / idc_capacidade_caixa) * 100, 2)
						
			If lvdc_Capacidade_Utilizada <= idc_capacidade_caixa and ldc_Peso_Volume <= idc_peso_caixa Then
				al_volume = ll_Proximo_Volume
				Return True
			Else
				/// Processo para Grupo Picking Na Lista de Separa$$HEX2$$e700e300$$ENDHEX$$o
				If ib_Filial_Wms_Grupo_Picking Then 
					// Se houve a quebra pela capacidade Utilizada e Peso volume, n$$HEX1$$e300$$ENDHEX$$o precisa for$$HEX1$$e700$$ENDHEX$$ar a quebra por n$$HEX1$$e300$$ENDHEX$$o ter atingido os pesos e volumes.
					ib_vol_anterior_grupo = False
				End If 
				
				// S$$HEX1$$f300$$ENDHEX$$ o volume do produto j$$HEX1$$e100$$ENDHEX$$ ultrapassar o volume m$$HEX1$$e900$$ENDHEX$$dio calculado
				//If al_qtde = 1 and lvdc_Capacidade_Utilizada < idc_capacidade_caixa_padrao and ldc_Peso_Volume <= 14 Then
				If al_qtde = 1 and lvdc_Capacidade_Utilizada < idc_capacidade_caixa_padrao and ldc_Peso_Volume <= idc_peso_caixa Then
					// For$$HEX1$$e700$$ENDHEX$$ar o sistema colocar no mesmo volume, pois o volume de um $$HEX1$$fa00$$ENDHEX$$nico produto n$$HEX1$$e300$$ENDHEX$$o ultrapassar o volume e o peso limite
					ldc_Percentual_Parametro = 105
				Else
				
					Select count(nr_volume)
					Into :ll_Total_Volumes
					From wms_lista_separacao
					Where cd_filial							=:il_Filial
						and nr_pedido_distribuidora 	=:il_pedido
						and cd_tipo_volume				= 1
						and cd_esteira 						= :ii_Esteira
					Using SqlCa;
					
					If SqlCa.Sqlcode = -1 Then
						ls_MSG = "Localiza$$HEX2$$e700e300$$ENDHEX$$o da quantidade de volumes. " + SqlCa.SqlErrText
						SqlCa.of_RollBack()
						This.of_grava_log(ls_MSG)
						MessageBox("Erro", ls_MSG, StopSign!)
						Return False
					Else
						// Neste caso esta no ultimo volume
						If ll_Total_Volumes = ii_total_volumes Then
							ldc_Percentual_Parametro = 105
						Else
							ldc_Percentual_Parametro = 103
						End If
					End If
				End If
								
				If ldc_Percentual > ldc_Percentual_Parametro or ldc_Peso_Volume > idc_peso_caixa Then
					lb_Insere_Lote = True
				Else
					al_volume = ll_Proximo_Volume
					Return True
				End If
			End If
			
		End If
		
	Case 100
		lb_Insere_Lote = True
		
	Case -1
		ls_MSG = "Localiza$$HEX2$$e700e300$$ENDHEX$$o do Pr$$HEX1$$f300$$ENDHEX$$ximo Pedido. " + SqlCa.SqlErrText
		SqlCa.of_RollBack()
		This.of_grava_log(ls_MSG)
		MessageBox("Erro", ls_MSG, StopSign!)
		Return False
End Choose 

If lb_Insere_Lote Then
	
	Select COALESCE(max(nr_volume), 0) + 1
	Into :ll_Proximo_Volume
	From wms_lista_separacao
	Where cd_filial							=:il_Filial
		and nr_pedido_distribuidora 	=:il_pedido
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		ls_MSG = "Erro ao localizar o pr$$HEX1$$f300$$ENDHEX$$ximo volume. " + SqlCa.SqlErrText
		SqlCa.of_RollBack()
		This.of_grava_log(ls_MSG)
		MessageBox("Erro", ls_MSG, StopSign!)
		Return False
	Else
		al_volume = ll_Proximo_Volume
		
		If Not gf_ge259_proxima_chave_volume_wms(Ref ll_Chave_Volume, Ref ls_MSG) Then
			SqlCa.of_RollBack()
			This.of_grava_log(ls_MSG)
			MessageBox("Erro", ls_MSG, StopSign!)
			Return False
		End If
		
		INSERT INTO wms_lista_separacao ( cd_filial, nr_pedido_distribuidora, nr_volume, cd_tipo_volume, cd_esteira, dh_geracao, nr_chave_volume )  
		VALUES ( :il_Filial, :il_pedido,  :ll_Proximo_Volume, 1, :ii_Esteira, getdate(), :ll_Chave_Volume)
		Using Sqlca;
		
		If SqlCa.SqlCode = -1 Then
			ls_MSG = "Inclus$$HEX1$$e300$$ENDHEX$$o do volume. " + SqlCa.SqlErrText
			This.of_grava_log(ls_MSG)
			SqlCa.of_RollBack()
			MessageBox("Erro", ls_MSG, StopSign!)
			Return False
		End If	
		
		//Verifica quantos volumes j$$HEX1$$e100$$ENDHEX$$ forma inseridos na esteira
		Select count(*)
		Into :ll_Qtde_Volumes
		From wms_lista_separacao
		Where cd_filial							=:il_Filial
			and nr_pedido_distribuidora 	=:il_pedido
			and cd_tipo_volume				= 1
			and cd_esteira 						= :ii_Esteira
			and dh_cancelamento is null
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			ls_MSG = "Erro ao localizar a quantidade de volumes. " + SqlCa.SqlErrText
			This.of_grava_log(ls_MSG)
			SqlCa.of_RollBack()
			MessageBox("Erro", ls_MSG, StopSign!)
			Return False
		End If	
		
		//Se a quantidade de volumes for maior do que a quantidade rateada $$HEX1$$e900$$ENDHEX$$ estouro de volume
		If ll_Qtde_Volumes > ii_total_volumes Then
			
			Update wms_lista_separacao set id_estouro_volume = 'S'
			Where cd_filial = :il_Filial
				and nr_pedido_distribuidora = :il_pedido
				and nr_volume = :ll_Proximo_Volume
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				ls_MSG = "Erro no update de estouro de volume. " + SqlCa.SqlErrText
				This.of_grava_log(ls_MSG)
				SqlCa.of_RollBack()
				MessageBox("Erro", ls_MSG, StopSign!)
				Return False
			End If	
			
		End If
		
	End If
		
End If

Return True

end function

public function boolean of_insere_lista_separacao_produto (long al_volume, long al_produto, string as_endereco, long al_quantidade, decimal adc_capacidade_litros, long al_caixa_padrao, long al_etiqueta_caixa, boolean ab_pulmao, decimal adc_peso_produto);Long ll_Quantidade, ll_Achou

String ls_MSG

Decimal ldc_Capacidade_Litros

Select w.cd_filial
Into :ll_Achou
From wms_lista_separacao_produto w 
Where w.cd_filial								= :il_filial
	and w.nr_pedido_distribuidora		= :il_Pedido
	and w.nr_volume						= :al_Volume
	and w.cd_produto						= :al_Produto
	and w.cd_endereco_localizacao  	= :as_Endereco
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		
		Update wms_lista_separacao_produto
		Set qt_pedida = qt_pedida + :al_quantidade
		Where cd_filial								= :il_filial
			and nr_pedido_distribuidora		= :il_Pedido
			and nr_volume						= :al_Volume
			and cd_produto						= :al_Produto
			and cd_endereco_localizacao  	= :as_Endereco
		Using SqlCa;
		
		If Sqlca.SqlCode = -1 Then
			ls_MSG = "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o da quantidade pedida do produto na lista de separa$$HEX2$$e700e300$$ENDHEX$$o. " + SqlCa.SqlErrText
			SqlCa.of_RollBack()
			This.of_grava_log(ls_MSG)
			MessageBox("Erro", ls_MSG, StopSign!)
			Return False
		End If
				
	Case 100
		
		ldc_Capacidade_Litros = Round(adc_capacidade_litros, 2)
		
		INSERT INTO wms_lista_separacao_produto	(	cd_filial,   
																	  	nr_pedido_distribuidora,   
																	  	nr_volume,   
																	  	cd_produto,   
																	  	cd_endereco_localizacao,   
																	  	qt_pedida,
																		qt_caixa_padrao,
																		nr_etiqueta_caixa,
																		qt_peso_kg,
																		qt_capacidade_litros)  
		VALUES (:il_filial,   
					  :il_Pedido,   
					  :al_volume,   
					  :al_produto,   
					  :as_endereco,   
					  :al_quantidade,
					  :al_caixa_padrao,
					  :al_etiqueta_caixa,
					  :adc_peso_produto,
					  :ldc_Capacidade_Litros) 
		Using SqlCa;
		
		If Sqlca.SqlCode = -1 Then
			ls_MSG = "Erro na inclus$$HEX1$$e300$$ENDHEX$$o do produto na lista de separa$$HEX2$$e700e300$$ENDHEX$$o. " + SqlCa.SqlErrText
			SqlCa.of_RollBack()
			This.of_grava_log(ls_MSG)
			MessageBox("Erro", ls_MSG, StopSign!)
			Return False
		End If
				
	Case -1
		ls_MSG = "Erro ao localizar o produto na lista de separa$$HEX2$$e700e300$$ENDHEX$$o. " + SqlCa.SqlErrText
		SqlCa.of_RollBack()
		This.of_grava_log(ls_MSG)
		MessageBox("Erro", ls_MSG, StopSign!)
		Return False
End Choose

ll_Quantidade = al_quantidade * al_caixa_padrao

UPDATE pedido_distribuidora_produto 
  SET qt_lista_separacao = isnull(qt_lista_separacao, 0) + :ll_Quantidade
Where cd_filial 							= :il_filial
	and nr_pedido_distribuidora 	= :il_Pedido
	and cd_produto						= :al_produto
Using Sqlca;

If SqlCa.SqlCode = -1 Then
	ls_MSG = "Erro da quantidade da lista de separacao. " + SqlCa.SqlErrText
	SqlCa.of_RollBack()
	This.of_grava_log(ls_MSG)
	MessageBox("Erro", ls_MSG, StopSign!)
	Return False
End If

adc_capacidade_litros = round(adc_capacidade_litros * al_quantidade,2)
adc_peso_produto = round(adc_peso_produto * al_quantidade,3)

UPDATE wms_lista_separacao  
  SET qt_capacidade_utilizada = isnull(qt_capacidade_utilizada, 0) + :adc_capacidade_litros,  
  		qt_peso_kg = isnull(qt_peso_kg, 0) + :adc_peso_produto
Where cd_filial = :il_filial
	 and nr_pedido_distribuidora = :il_Pedido
	 and nr_volume = :al_Volume
Using Sqlca;

If SqlCa.SqlCode = -1 Then
	ls_MSG = "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o da lista de separa$$HEX2$$e700e300$$ENDHEX$$o. " + SqlCa.SqlErrText
	SqlCa.of_RollBack()
	This.of_grava_log(ls_MSG, True)
	//MessageBox("Erro", ls_MSG, StopSign!)
	Return False
End If

If ab_Pulmao Then
	If al_etiqueta_caixa > 0 Then
		If Not This.of_insere_reserva_pulmao(as_endereco, al_produto, al_etiqueta_caixa) Then
			Return False
		End If
	End IF
Else
	If Not This.of_insere_reserva_flow_rack(as_endereco, al_produto, al_quantidade) Then
		Return False
	End If
End If

Return True

end function

public function boolean of_insere_volume_caixa (long al_produto, string as_endereco, long al_caixa_padrao, long al_etiqueta_caixa);Long ll_Proximo_Volume
Long ll_Chave_Volume

String ls_MSG

Decimal{3} ldc_Peso_Grama

Select COALESCE(max(nr_volume), 0) + 1
Into :ll_Proximo_Volume
From wms_lista_separacao
Where cd_filial							=:il_Filial
  	and nr_pedido_distribuidora 	=:il_Pedido
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	This.of_grava_log("Localiza$$HEX2$$e700e300$$ENDHEX$$o do pr$$HEX1$$f300$$ENDHEX$$ximo volume. " + SqlCa.SqlErrText)
	Return False
End If

If Not gf_ge259_proxima_chave_volume_wms(Ref ll_Chave_Volume, Ref ls_MSG) Then
	This.of_grava_log(ls_MSG)
	Return False
End If

INSERT INTO wms_lista_separacao ( cd_filial, nr_pedido_distribuidora, nr_volume, cd_tipo_volume, cd_esteira, dh_geracao, nr_chave_volume )  
VALUES ( :il_Filial, :il_Pedido,  :ll_Proximo_Volume, 2, :ii_Esteira, getdate(), :ll_Chave_Volume)
Using Sqlca;

If SqlCa.SqlCode = -1 Then
	This.of_grava_log("Inclus$$HEX1$$e300$$ENDHEX$$o do volume em caixa. " + SqlCa.SqlErrText)
	Return False
End If	

If Not of_insere_lista_separacao_produto(ll_Proximo_Volume, al_produto, as_endereco, 1, 0, al_caixa_padrao, al_etiqueta_caixa, true, ldc_Peso_Grama) Then
	Return False
End If

REturn true
end function

public function boolean of_grava_volume_caixa_padrao ();Boolean lb_Sucesso = True

DateTime ldh_Validade

String	ls_Endereco,&
		ls_Lote,&
		ls_msg

Long	ll_Qtde_Caixa,&
		ll_Linha,&
		ll_Linhas,&
		ll_Etiqueta_Caixa,&
		ll_Saldo,&
		ll_Reserva,&
		ll_Produto,&
		ll_QT_Pedida,&
		ll_Linhas_Produto,&
		ll_Linha_Produto,&
		ll_Cx_Padrao_Wms,&
		ll_Filial_Estoque

try
	
 	If not of_carrega_parametro_filial(Ref ll_Filial_Estoque,Ref ls_msg ) Then Return False
	
	dc_uo_ds_base lds
	lds = Create dc_uo_ds_base
	If Not lds.of_ChangeDataObject("ds_ge259_produto_pulmao") Then Return False
	
	dc_uo_ds_base lds_Produto_Pedido
	lds_Produto_Pedido = Create dc_uo_ds_base
	If Not lds_Produto_Pedido.of_ChangeDataObject("ds_ge259_produto_pedido") Then Return False
	
	lds_Produto_Pedido.of_AppendWhere(" exists (select * from wms_localizacao l " +&
						" inner join vw_wms_endereco v on v.cd_endereco = l.cd_endereco " +&
						" where l.cd_produto 				= p.cd_produto " +&
						" and p.qt_atendida 				>= coalesce(p.qt_caixa_padrao_wms, (select max(qt_caixa_padrao) from wms_localizacao x where x.cd_produto = p.cd_produto) ) " +&
						"  and (l.qt_caixa_padrao			> 1 or COALESCE(g.id_picking_pulmao, 'N') = 'S') " +&
						"  and v.id_flow_rack				= 'N' " +&
						"  and v.id_flow_rack_bairro 	= 'N' " +&
						"  and v.id_utiliza_saldo			= 'S') " +&
						"  and (c.id_separacao_cx 		= 'S' or c.id_separacao_cx is null) ", 1)

	
	ll_Linhas_Produto = lds_Produto_Pedido.Retrieve(il_Filial, il_Pedido, ii_Esteira)
	
	If ll_Linhas_Produto < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar os produtos do pedido para gerar o volume de caixa fechada.", StopSign!)
		Return False
	End If
	
	// Lista todos os produtos do pedido
	For ll_Linha_Produto = 1 To ll_Linhas_Produto
		
		ll_Produto 				= lds_Produto_Pedido.Object.cd_produto				[ll_Linha_Produto]
		ll_QT_Pedida			= lds_Produto_Pedido.Object.qt_pedida					[ll_Linha_Produto]
		ll_Cx_Padrao_Wms	= lds_Produto_Pedido.Object.qt_caixa_padrao_wms	[ll_Linha_Produto]
		
		lds.of_restoresqloriginal()
			
		If Not IsNull(ll_Cx_Padrao_Wms) Then
			lds.of_AppendWhere("w.qt_caixa_padrao = "+String(ll_Cx_Padrao_Wms))
		End If
		
		ll_Linhas = lds.Retrieve(ll_Produto,ll_Filial_Estoque)
		
		// Se existir saldo no pulm$$HEX1$$e300$$ENDHEX$$o
		If ll_Linhas > 0 Then
			
			For ll_Linha = 1 To ll_Linhas
				
				ll_Qtde_Caixa		= lds.Object.qt_caixa_padrao	[ll_Linha]
				ls_Endereco			= lds.Object.cd_endereco		[ll_Linha]
				ls_Lote				= lds.Object.nr_lote				[ll_Linha]
				ldh_Validade		= lds.Object.dh_validade			[ll_Linha]
				ll_Saldo				= lds.Object.qt_saldo				[ll_Linha]
								
				Select coalesce(max(nr_etiqueta), 0)
				Into :ll_Etiqueta_Caixa
				From wms_etiqueta_produto 
				Where cd_produto 		= :ll_Produto
					and qt_caixa_padrao	= :ll_Qtde_Caixa
					and nr_lote				= :ls_Lote
					and dh_validade 		= :ldh_Validade
				Using Sqlca;
				  
				If SqlCa.SqlCode = -1 Then
					SqlCa.of_MsgDbError("Erro ao localizar a etiqueta da caixa do produto '" + String(ll_Produto) + "'")
					Return False
				Else
					If ll_Etiqueta_Caixa = 0 Then
						SetNull(ll_Etiqueta_Caixa)
					Else
						
						Select qt_reserva
						Into :ll_Reserva
						From wms_reserva_pulmao
						Where	cd_endereco 		=	:ls_Endereco
							and	cd_produto			=	:ll_Produto
							and	nr_etiqueta_caixa 	=	:ll_Etiqueta_Caixa
						Using Sqlca;
						
						Choose Case SqlCa.SqlCode
							Case 0
								ll_Saldo = ll_Saldo - ll_Reserva
								
								If ll_Saldo < 0 Then ll_Saldo = 0
							Case 100
							Case -1
								SqlCa.of_MsgDbError("Erro ao localizar a quantidade reservada do produto '" + STring(ll_Produto) + "'")
								Return False
						End Choose
					End If
				End If
				
				Do While ll_Saldo > 0
										
					If ll_QT_Pedida > 0  Then
						If Mod(ll_QT_Pedida, ll_Qtde_Caixa) = 0  or ll_QT_Pedida > ll_Qtde_Caixa Then 
							If Not of_Insere_Volume_Caixa(ll_Produto, ls_Endereco, ll_Qtde_Caixa, ll_Etiqueta_Caixa) Then
								Return False
							End If
						
							ll_QT_Pedida = ll_QT_Pedida - ll_Qtde_Caixa
							
							// -1 porque $$HEX1$$e900$$ENDHEX$$ uma caixa
							ll_Saldo = ll_Saldo - 1
							
							If ll_QT_Pedida = 0 Then Exit
						Else
							Exit
						End If		
					End If
					
				Loop
				
				If ll_QT_Pedida = 0 Then Exit
			Next
			
		End If
		// Termino - Se existir saldo no pulm$$HEX1$$e300$$ENDHEX$$o
		
	Next
	// Termino - lista dos produtos do pedido

finally
	Destroy(lds)
	Destroy(lds_Produto_Pedido)
end try

Return True
end function

public function boolean of_verifica_rateio_volumes ();Long ll_Linhas, ll_Linha, ll_Produto, ll_Qtde_Pedida, ll_Qtde_Pick, ll_Qtde
Long ll_Contador, ll_Qtde_Pulmao

Decimal ldc_Capacidade_Litro, ldc_Capacidade_Eco, ldc_Capacidade

Decimal {3} ldc_Peso_Grama, ldc_Capacidade_Peso

String ls_MSG

dc_uo_ds_base lds

try
		
	lds = Create dc_uo_ds_base
	If Not lds.of_ChangeDataObject("ds_ge259_lista_separacao_ordem") Then Return False
			
	ll_Linhas = lds.Retrieve(il_Filial, il_Pedido, ii_Esteira)
		
	For ll_Linha = 1 To ll_Linhas
				
		ll_Produto 					= lds.Object.cd_produto								[ll_Linha]
		ll_Qtde_Pedida			= lds.Object.qt_atendida								[ll_Linha]
		ll_Qtde_Pick 				= lds.Object.qt_lista_separacao					[ll_Linha]
		ldc_Capacidade_Litro	= lds.Object.qt_capacidade_litro					[ll_Linha] 	
		ldc_Capacidade_Eco	= lds.Object.qt_capacidade_litro_ecommerce	[ll_Linha] 	
		ldc_Peso_Grama			= lds.Object.qt_peso_kg								[ll_Linha]
			
		If ldc_Capacidade_Litro = 0 Then ldc_Capacidade_Litro = ldc_Capacidade_Eco
		
		Select sum(qt_pedida * qt_caixa_padrao)
		Into :ll_Qtde_Pulmao
		from wms_lista_separacao a
		inner join wms_lista_separacao_produto b on b.cd_filial = a.cd_filial
																	 and b.nr_pedido_distribuidora = a.nr_pedido_distribuidora
																	 and b.nr_volume					= a.nr_volume
		where a.cd_filial = :il_Filial
			and a.nr_pedido_distribuidora =:il_Pedido
			and a.cd_esteira				= :ii_Esteira
			and b.cd_produto			= :ll_Produto
		using Sqlca;
		
		Choose Case SqlCa.SqlCode
			Case 0
			Case 100
				ll_Qtde_Pulmao = 0
			Case -1
				ls_MSG =	"Localizar se existe volume de pulm$$HEX1$$e300$$ENDHEX$$o do produto '" + String(ll_Produto) + "'.~r~r" +&
								"Erro: '" + SQLCA.SQLErrText + "'."
				SqlCa.of_Rollback()
				This.of_grava_log(ls_MSG)
				MessageBox("Erro", ls_MSG, StopSign!)
				Return False
		End Choose
		
		ll_Qtde = ll_Qtde_Pedida - ll_Qtde_Pulmao
						
		If ll_Qtde > 0 Then
			
			For ll_Contador = 1 To ll_Qtde
				ldc_Capacidade = ldc_Capacidade + ldc_Capacidade_Litro
				
				If ldc_Capacidade >= idc_capacidade_caixa Then
					
				End If
			Next
									
		End If
		
	Next
		
finally
	Destroy(lds)
end try

Return True
end function

public function boolean of_gera_picking ();try
	Open(w_ge259_aguarde)
	SetPointer(HourGlass!)
	
	if IsValid(w_ge259_aguarde) then
		w_ge259_aguarde.Title = "Gerando Picking da Filial '" + String(il_Filial) + "' da Esteira '" + String(ii_Esteira) +"' ..."
	end if
	
	This.of_grava_log("In$$HEX1$$ed00$$ENDHEX$$cio filial - " + String(il_Filial) + ' Esteira - ' + string(ii_Esteira) )
	
	If Not of_Rateio_Volume() Then Return False
	
	// INICIO RUA 500
	If ii_Esteira = 1 Then
		ib_endereco_500 = True
		// Roda a primeira vez somente com os produtos da pr$$HEX1$$e900$$ENDHEX$$dio maior ou igual 50 (endere$$HEX1$$e700$$ENDHEX$$o 500)
		If Not of_Gera_Lista_Separacao() Then Return False
	End If
	// TERMINO RUA 500
	
	ib_endereco_500 = False
		
	If Not of_Gera_Lista_Separacao() Then Return False
finally
	This.of_grava_log("T$$HEX1$$e900$$ENDHEX$$rmino filial - " + String(il_Filial) + ' Esteira - ' + string(ii_Esteira)  )
	SetPointer(Arrow!)
	
	if IsValid(w_ge259_aguarde) then
		Close(w_ge259_aguarde)
	end if
end try

Return True
end function

public function boolean of_valida_quantidade_pedido ();String ls_MSG

Long ll_Qtde

Select count(*)
Into :ll_Qtde
From pedido_distribuidora_produto
where cd_filial =:il_Filial
	and nr_pedido_distribuidora = :il_Pedido
	and qt_lista_separacao > qt_atendida
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_MSG = 	"Erro na verifica$$HEX2$$e700e300$$ENDHEX$$o da quantidade pedida do pedido '" + String(il_Pedido) + "' da filial '" + String(il_Filial) + "'. '" + SQLCA.SQLErrText + "'."
	SqlCa.of_RollBack()
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_MSG, StopSign!)
	Return False
Else
	If ll_Qtde > 0 Then
		ls_MSG = 	"Existem produtos no pedido '" + String(il_Pedido) + "' da filial '" + String(il_Filial) +  "' com quantidade no picking maior que do pedido."
		SqlCa.of_RollBack()
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_MSG, StopSign!)
		Return False
	End If
End If

Return true
end function

public function boolean of_parametro_geracao_cx_padrao ();String ls_Parametro, ls_MSG

Select vl_parametro
Into :ls_Parametro
From wms_parametro
Where cd_parametro = 'ID_GERA_PICKING_CAIXA_PADRAO'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If ls_Parametro <> 'S' and ls_Parametro <> 'N' Then
			ls_MSG = 	"Par$$HEX1$$e200$$ENDHEX$$metro para gera$$HEX2$$e700e300$$ENDHEX$$o de picking de caixa padr$$HEX1$$e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido (S/N)."
			SqlCa.of_RollBack()
			This.of_Grava_Log(ls_MSG)	
			Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_MSG, StopSign!)
			Return False
		Else
			is_Gera_Picking_CX = ls_Parametro
			Return True
		End If
	Case 100
		Return True
	Case -1
		ls_MSG = 	"Erro ao verificar o par$$HEX1$$e200$$ENDHEX$$metro para gerar picking de caixa padr$$HEX1$$e300$$ENDHEX$$o. '" + SQLCA.SQLErrText + "'."
		SqlCa.of_RollBack()
		This.of_Grava_Log(ls_MSG)	
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_MSG, StopSign!)
		Return False
End Choose


end function

public function boolean of_grava_log (string as_mensagem, boolean ab_envia_email);Integer lvi_Status

String lvs_Mensagem 

String ls_Anexo[]
String ls_Mensagem_Email
String ls_Mensagem_Log

lvs_Mensagem = String(Today(), "dd/mm/yyyy") + " " + 	String(Now(), "hh:mm:ss") + " " + as_Mensagem
	
lvi_Status = FileWrite(ii_Log, lvs_Mensagem)

If ab_envia_email Then
	gf_ge202_envia_email_automatico(13, " - LOG ", as_Mensagem, ls_Anexo)
End If

If lvi_Status <> LenA(lvs_Mensagem) Then	
	gf_ge202_envia_email_automatico(13, " - LOG ", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do registro no arquivo de log da aplica$$HEX2$$e700e300$$ENDHEX$$o.", ls_Anexo)
End If
	
Return True




end function

public function boolean of_imprime_lista_almoxarifado ();//// Almoxarifado
//		If as_Tipo = 'A' Then
//			// Somente pedidos das filiais
//			ivds_Itens.of_ChangeDataObject('dw_fa002_laser_listagem_separacao_almox')
//		Else
//			// 'D'
//			//Somente departamentos
//			ivds_Itens.of_ChangeDataObject('dw_fa002_laser_listagem_separacao_almox2')
//		End If

Return True
end function

public function long of_pedidos_colocados (string as_tipo);Long lvl_Pedidos,&
	 lvl_Pedidos_Almoxarifado

Choose Case as_Tipo
	Case "E" // Estoque Central
	
		Select count(*) Into :lvl_Pedidos
		 From parametro,   
				pedido_distribuidora,   
				filial  
		Where ( pedido_distribuidora.cd_distribuidora = parametro.cd_distribuidora_estoque ) and  
				( filial.cd_filial = pedido_distribuidora.cd_filial ) and  
				( pedido_distribuidora.id_situacao = 'C' ) 
		Using Sqlca;		
		
		If Sqlca.Sqlcode = - 1 Then
			Sqlca.of_MsgDbError('Verifica$$HEX2$$e700e300$$ENDHEX$$o de pedidos colocados')
			Return -1
		End If 
		
		If IsNull(lvl_Pedidos) Then lvl_Pedidos = 0
		
		lvl_Pedidos = lvl_Pedidos
		
	Case "A" // Almoxarifado Filiais
		
		Select count(*) Into :lvl_Pedidos_Almoxarifado
		 From pedido_almoxarifado
		Where id_situacao = 'C' 
		  and cd_centro_custo is null
		Using Sqlca;		
		
		If Sqlca.Sqlcode = - 1 Then
			Sqlca.of_MsgDbError('Verifica$$HEX2$$e700e300$$ENDHEX$$o de pedidos colocados')
			Return -1
		End If 
		
		If IsNull(lvl_Pedidos_Almoxarifado) Then lvl_Pedidos_Almoxarifado = 0
	
		lvl_Pedidos = lvl_Pedidos_Almoxarifado
		
	Case "D" // Almoxarifado Departamentos
		
		Select count(*) Into :lvl_Pedidos_Almoxarifado
		 From pedido_almoxarifado
		Where id_situacao = 'C' 
		  and cd_centro_custo is not null
		Using Sqlca;		
		
		If Sqlca.Sqlcode = - 1 Then
			Sqlca.of_MsgDbError('Verifica$$HEX2$$e700e300$$ENDHEX$$o de pedidos colocados')
			Return -1
		End If 
		
		If IsNull(lvl_Pedidos_Almoxarifado) Then lvl_Pedidos_Almoxarifado = 0
	
		lvl_Pedidos = lvl_Pedidos_Almoxarifado
		
	Case Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tipo n$$HEX1$$e300$$ENDHEX$$o defenido '" + as_Tipo + "'.")
		Return -1
End Choose

Return lvl_Pedidos

end function

public subroutine of_gera_barcode (dc_uo_ds_base pds_pedido);Return

Long ll_Linha
Long ll_Filial
Long ll_Pedido
Long ll_Filial_Aux    = 0
Long ll_Pedido_Aux = 0

String ls_Rua
String ls_Rua_Aux = '0'
String ls_Argumentos

uo_transacao_remota lo_Intranet
lo_Intranet = Create uo_transacao_remota

For ll_Linha = 1 To pds_pedido.RowCount()
		ll_Filial    = pds_pedido.Object.Cd_Filial	[ll_Linha]
		ll_Pedido = pds_pedido.Object.Nr_Pedido [ll_Linha]
		ls_Rua    = Mid(pds_pedido.Object.De_Rua[ll_Linha], 1, 1)
		
		If (ll_Filial <> ll_Filial_Aux) Or (ll_Pedido <> ll_Pedido_Aux) Or (ls_Rua <> ls_Rua_Aux) Then
			
			ll_Filial_Aux    = ll_Filial
			ll_Pedido_Aux = ll_Pedido
			ls_Rua_Aux    = ls_Rua
			
			ls_Argumentos = "cd_filial=" + String(ll_Filial) + "&nr_pedido=" + String(ll_Pedido) + "&de_rua=" + ls_Rua
			lo_Intranet.of_Executa_Rotina_Intranet("barcode_faturamento",ls_Argumentos)
			
		End If
		
Next

Destroy lo_Intranet
end subroutine

public function boolean of_imprimir_pedidos_almoxarifado (string as_tipo);Long   	lvl_Filial,&
       	lvl_Pedido,&
       	lvl_Linha,&
       	lvl_Item,&
	   	lvl_Itens_Rua,&
	   	lvl_Produto,&
	   	lvl_Quantidade,&
	   	lvl_Prioridade
	  
String 	lvs_Filial,&
       	lvs_Produto,&
  	   	lvs_Barras,&
   		lvs_Quantidade,&
	   	lvs_Rua
		 
Boolean lvb_Quebra_Pagina = False		 
		 
//SetPointer(HourGlass!)		 
//
////Inicializa Objeto de impress$$HEX1$$e300$$ENDHEX$$o
//If Not ivo_Impressao.of_Inicializar(as_Tipo) Then Return False
//
////Habilita uso do Cabecalho Padr$$HEX1$$e300$$ENDHEX$$o
//ivo_Impressao.ivb_usa_cabecalho = True
//
////T$$HEX1$$ed00$$ENDHEX$$tulo do Relat$$HEX1$$f300$$ENDHEX$$rio
//ivo_Impressao.ivs_Titulo_Relatorio = 'RELACAO DE ITENS DO PEDIDO'
//
////Total de Itens da Rua
//lvl_Itens_Rua = 0
//
//Open(w_Aguarde)
//w_Aguarde.Title = 'Gerando listagem de separa$$HEX2$$e700e300$$ENDHEX$$o de pedidos...'
//w_Aguarde.uo_Progress.of_SetMax(ivds_Itens.RowCount())
//
//For lvl_Item = 1 To ivds_Itens.RowCount()
//	
//	w_Aguarde.uo_Progress.of_SetProgress(lvl_Item)
//
//	If ivo_Impressao.of_Linha() = 0 Then
//		
//		lvb_Quebra_Pagina = False		
//		
//		lvl_Filial     = ivds_Itens.object.cd_filial    [lvl_Item]			
//		lvs_Filial     = ivds_Itens.Object.nm_filial    [lvl_Item]
//		lvl_Pedido     = ivds_Itens.object.nr_pedido    [lvl_Item]
//		lvl_Prioridade = ivds_Itens.object.nr_prioridade[lvl_Item]
//						
//		ivo_Impressao.Of_Insere_Linha(Left("FILIAL : " + lvs_Filial + Space(30),30) + "         PEDIDO : " + String(lvl_pedido,'000000') + '         PRIORIDADE : ' + String(lvl_Prioridade,'000'))
//		ivo_Impressao.Of_Insere_Linha(Fill("-",80))
//		
//		ivo_Impressao.of_Insere_Linha("CODIGO PEDIDO DESCRICAO-APRESENTACAO                   RUA ")
//		ivo_Impressao.of_Insere_Linha("------ ------ ---------------------------------------- ----")
//				
//	End If
//	
//	lvl_Produto    = ivds_Itens.Object.cd_produto      [lvl_item]
// 	lvs_Produto    = ivds_Itens.Object.de_produto      [lvl_item]
//	lvs_Barras     = ivds_Itens.Object.de_codigo_barras[lvl_item]
//	lvl_Quantidade = ivds_Itens.Object.qt_pedida       [lvl_item]
//	lvs_Rua        = ivds_Itens.Object.de_rua          [lvl_Item]
//	
//	If IsNull(lvs_Rua) Then lvs_Rua = ''
//	
//	lvs_Rua = Mid(lvs_Rua, 1,1)
//	
//	If IsNull(lvs_Barras) Then lvs_Barras = Space(20)
//	
//	lvs_Produto    = Left(lvs_Produto + Space(40),40)
//	lvs_Barras     = Left(lvs_Barras  + Space(20),20)
//	lvs_Quantidade = Right(space(6)+String(lvl_Quantidade),06)
//	
//	ivo_Impressao.Of_Insere_Linha(String(lvl_Produto,'000000') + " " + lvs_Quantidade + " " + lvs_Produto + "  " + lvs_Rua)
//	
//	lvl_Itens_Rua ++
//	
//	If lvl_Item = ivds_Itens.RowCount() Then
//		
//		lvb_Quebra_Pagina = True
//	
//	ElseIf lvl_Item + 1 <= ivds_Itens.RowCount() Then
//		
//		If lvl_Prioridade <> ivds_Itens.Object.nr_prioridade[lvl_item+1] Then
//			lvb_Quebra_Pagina = True
//		End If	
//		
//		// Se for estoque central quebra o relatorio por rua.
//		If as_Tipo = 'E' Then
//			If lvs_Rua <> ivds_Itens.Object.de_rua[lvl_item+1] Then
//				lvb_Quebra_Pagina = True
//			End If
//		End If
//		
//	End If
//	
//	If lvb_Quebra_Pagina Then
//		ivo_Impressao.of_Salta_Linha()
//		ivo_Impressao.of_Insere_Linha('Total de Produtos : ' + String(lvl_Itens_Rua))
//		ivo_Impressao.of_Salta_Pagina()
//		lvl_Itens_Rua = 0
//	End If
//	
//Next
//
//ivo_Impressao.Of_Salta_Linha()
//ivo_Impressao.Of_Finalizar()
//
//Destroy(ivds_Itens)
//
//Close(w_Aguarde)

Return True
end function

public function boolean of_imprimir_pedidos (string as_tipo);Long   	lvl_Filial,&
       	lvl_Pedido,&
       	lvl_Linha,&
       	lvl_Item,&
	   	lvl_Itens_Rua,&
	   	lvl_Produto,&
	   	lvl_Quantidade,&
	   	lvl_Prioridade
	  
String 	lvs_Filial,&
       	lvs_Produto,&
  	   	lvs_Barras,&
   		lvs_Quantidade,&
	   	lvs_Rua
		 
Boolean lvb_Quebra_Pagina = False		 
		 
//SetPointer(HourGlass!)		 
//
////Inicializa Objeto de impress$$HEX1$$e300$$ENDHEX$$o
//If Not ivo_Impressao.of_Inicializar(as_Tipo) Then Return False
//
////Habilita uso do Cabecalho Padr$$HEX1$$e300$$ENDHEX$$o
//ivo_Impressao.ivb_usa_cabecalho = True
//
////T$$HEX1$$ed00$$ENDHEX$$tulo do Relat$$HEX1$$f300$$ENDHEX$$rio
//ivo_Impressao.ivs_Titulo_Relatorio = 'RELACAO DE ITENS DO PEDIDO'
//
////Total de Itens da Rua
//lvl_Itens_Rua = 0
//
//Open(w_Aguarde)
//w_Aguarde.Title = 'Gerando listagem de separa$$HEX2$$e700e300$$ENDHEX$$o de pedidos...'
//w_Aguarde.uo_Progress.of_SetMax(ivds_Itens.RowCount())
//
//For lvl_Item = 1 To ivds_Itens.RowCount()
//	
//	w_Aguarde.uo_Progress.of_SetProgress(lvl_Item)
//
//	If ivo_Impressao.of_Linha() = 0 Then
//		
//		lvb_Quebra_Pagina = False		
//		
//		lvl_Filial     = ivds_Itens.object.cd_filial    [lvl_Item]			
//		lvs_Filial     = ivds_Itens.Object.nm_filial    [lvl_Item]
//		lvl_Pedido     = ivds_Itens.object.nr_pedido    [lvl_Item]
//		lvs_Rua        = ivds_Itens.Object.de_rua       [lvl_Item]
//		lvl_Prioridade = ivds_Itens.object.nr_prioridade[lvl_Item]
//				
//		If IsNull(lvs_Rua) Then lvs_Rua = ''
//		
//		ivo_Impressao.Of_Insere_Linha(Left("FILIAL : " + lvs_Filial + Space(30),30) + "  PEDIDO : " + String(lvl_pedido,'000000') + ' PRIORIDADE : ' + String(lvl_Prioridade,'000') + ' RUA : "' + lvs_Rua + '"')
//		ivo_Impressao.Of_Insere_Linha(Fill("-",80))
//		
//		ivo_Impressao.of_Insere_Linha("CODIGO PEDIDO DESCRICAO-APRESENTACAO                   COD.BARRAS               ")
//		ivo_Impressao.of_Insere_Linha("------ ------ ---------------------------------------- -------------------------")
//				
//	End If
//	
//	lvl_Produto    = ivds_Itens.Object.cd_produto      [lvl_item]
// 	lvs_Produto    = ivds_Itens.Object.de_produto      [lvl_item]
//	lvs_Barras     = ivds_Itens.Object.de_codigo_barras[lvl_item]
//	lvl_Quantidade = ivds_Itens.Object.qt_pedida       [lvl_item]
//	
//	If IsNull(lvs_Barras) Then lvs_Barras = Space(20)
//	
//	lvs_Produto    = Left(lvs_Produto + Space(40),40)
//	lvs_Barras     = Left(lvs_Barras  + Space(20),20)
//	lvs_Quantidade = Right(space(6)+String(lvl_Quantidade),06)
//	
//	ivo_Impressao.Of_Insere_Linha(String(lvl_Produto,'000000') + " " + lvs_Quantidade + " " + lvs_Produto + " " + lvs_Barras)
//	
//	lvl_Itens_Rua ++
//	
//	If lvl_Item = ivds_Itens.RowCount() Then
//		
//		lvb_Quebra_Pagina = True
//	
//	ElseIf lvl_Item + 1 <= ivds_Itens.RowCount() Then
//		
//		If lvl_Prioridade <> ivds_Itens.Object.nr_prioridade[lvl_item+1] Then
//			lvb_Quebra_Pagina = True
//		End If	
//		
//		// Se for estoque central quebra o relatorio por rua.
//		If as_Tipo = 'E' Then
//			If lvs_Rua <> ivds_Itens.Object.de_rua[lvl_item+1] Then
//				lvb_Quebra_Pagina = True
//			End If
//		End If
//		
//	End If
//	
//	If lvb_Quebra_Pagina Then
//		ivo_Impressao.of_Salta_Linha()
//		ivo_Impressao.of_Insere_Linha('Total da Rua "' + lvs_Rua + '" : ' + String(lvl_Itens_Rua))
//		ivo_Impressao.of_Salta_Pagina()
//		lvl_Itens_Rua = 0
//	End If
//	
//Next
//
//ivo_Impressao.Of_Salta_Linha()
//ivo_Impressao.Of_Finalizar()
//
//Destroy(ivds_Itens)
//
//Close(w_Aguarde)

Return True
end function

public function boolean of_libera_pedidos_colocados (string as_tipo);// Estoque Central 
If as_Tipo = 'E' Then
	Update pedido_distribuidora
	set id_situacao = 'S'
	From pedido_distribuidora,
		  parametro
	where pedido_distribuidora.id_situacao = 'C'
	  and pedido_distribuidora.cd_distribuidora = parametro.cd_distribuidora_estoque 
	Using Sqlca;  
	
	If Sqlca.Sqlcode = -1 Then
		Sqlca.of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o da situa$$HEX2$$e700e300$$ENDHEX$$o dos pedidos")
	Else
		Sqlca.of_Commit();	
	End If
Else
	// Almoxarifado
	If as_Tipo = 'A' Then
		// Somente filiais
		Update pedido_almoxarifado
		Set id_situacao = 'S'
		Where id_situacao = 'C'
		  and cd_centro_custo is null
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			Sqlca.of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o da situa$$HEX2$$e700e300$$ENDHEX$$o dos pedidos de material de expediente")
		Else
			Sqlca.of_Commit();	
		End If
	Else
		// 'D'
		// Somente Departamentos
		Update pedido_almoxarifado
		Set id_situacao = 'S'
		Where id_situacao = 'C'
		  and cd_centro_custo is not null
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			Sqlca.of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o da situa$$HEX2$$e700e300$$ENDHEX$$o dos pedidos de material de expediente")
		Else
			Sqlca.of_Commit();	
		End If
	End If
End If


Return True

end function

public function boolean of_imprimir_listagem_separacao_nova (string as_tipo);SetPointer(HourGlass!)

If as_Tipo = 'A' Then
	// Somente pedidos das filiais
	ivds_Itens.of_ChangeDataObject('dw_ge259_listagem_separacao_almox_fil')
Else
	// 'D'
	//Somente departamentos
	ivds_Itens.of_ChangeDataObject('dw_ge259_listagem_separacao_almox_dep')
End If
		
ivds_Itens.Retrieve()	
	
If ivds_Itens.RowCount() > 0 Then
			
	//If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Confirma a impress$$HEX1$$e300$$ENDHEX$$o da listagem de separa$$HEX2$$e700e300$$ENDHEX$$o ?",Question!,YesNo!,1) = 1 Then
		
		ivds_Itens.Print()
		
	//End If	
	
Else
	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o existem dados para impress$$HEX1$$e300$$ENDHEX$$o.")
	Return False
	
End If	

Return True

end function

public function boolean of_retira_produto_sem_saldo ();String ls_Parametro

Select vl_parametro
Into :ls_Parametro
From wms_parametro
where cd_parametro = 'ID_RETIRA_PICKING_PRODUTO_SEM_SALDO_FLOW'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 100
		Return False
		
	Case -1
		MessageBox("Erro", "Erro ao consultar o par$$HEX1$$e200$$ENDHEX$$metro 'ID_RETIRA_PICKING_PRODUTO_SEM_SALDO_FLOW'" + SQLCA.SQLErrText + "'.")
		Return False
End Choose

If ls_Parametro = "S" Then
	Return True
End If

Return False
end function

public function boolean of_imprime_etiqueta_imp_termica (long al_filial, long al_pedido, long al_volume);Long 	ll_Linhas,&
		ll_Qt_Prd_Geladeira,&
		ll_Esteira,&
		ll_Rota,&
		ll_Filial_Entrega,&
		ll_Nr_Chave_Volume,&
		ll_Nr_Ordem_Bacia,&
		ll_Cd_Centro_Custo_Entrega,&
		ll_Nulo

String 	ls_DS,&
			ls_Id_Rede,&
			ls_EAN128,&
			ls_Volume_Extra,&
			ls_De_Volume_Extra,&
			ls_Pedido_Almoxarifado,&
			ls_Departamento,&
			ls_Endereco,&
			ls_Cep,&
			ls_Cidade,&
			ls_Unidade_Federacao,&
			ls_EAN13
			
String ls_Nm_Requisitante

Boolean 	lb_Departamento = False,&
			lb_Centro_Custo_Entrega = False

dc_uo_ds_base lds

dc_uo_ds_base lds_Etiquetas_Volume

Try
	SetNull(ls_Nm_Requisitante)
	SetNull(ll_Nulo)
	
	lds = Create dc_uo_ds_base
	
	lds_Etiquetas_Volume = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject("ds_ge259_dados_etiquetas_volumes") Then
		Return False
	End If
	
	ll_Linhas = lds.Retrieve(al_Filial, al_Pedido, al_volume)
	ll_Esteira						= lds.Object.cd_esteira					[1]
	
	// Configura$$HEX2$$e700e300$$ENDHEX$$o da Esteira: Imprime ou n$$HEX1$$e300$$ENDHEX$$o Picking + Etiqueta
	If of_esteira_imprime_picking_etiqueta(ll_Esteira) Then 
		ib_EsteiraImprimeEtiqueta = True 
	End If 	
	
	If ib_EsteiraImprimeEtiqueta then
		If Not lds_Etiquetas_Volume.of_ChangeDataObject("ds_ge259_etiqueta_volume_impr_termica") Then
			Return False
		End If
	Else	
		// Usa outra Dw Caso Wms_Esteira.id_conferencia_bip_etiqueta = "N"	
     	If Not lds_Etiquetas_Volume.of_ChangeDataObject("ds_ge259_etiqueta_volume2") Then
			Return False
		End If
	End If 	

	If Not of_carrega_parametros_loja(al_filial) Then Return False
	
	If ll_Linhas > 0 Then	
		
		If lds.object.id_pedido_almoxarifado[1] = "S" Then
			If Not of_Departamento_Pedido	(	al_Filial,&
														al_Pedido,&
														Ref ls_Departamento,&
														Ref lb_Departamento,&
														Ref ls_Endereco,&
														Ref ls_Cep,&
														Ref ls_Cidade,&
														Ref ls_Unidade_Federacao,&
														Ref ll_Rota,&
														Ref ll_Filial_Entrega,&
														Ref lb_Centro_Custo_Entrega,&
														Ref ll_Nr_Ordem_Bacia,&
														Ref ll_Cd_Centro_Custo_Entrega,&
														Ref ls_Nm_Requisitante) Then
				Return False
			End If
		End If


			
		If lb_Centro_Custo_Entrega Then	
			lds_Etiquetas_Volume.Object.de_filial						[1]		= ls_Departamento
			lds_Etiquetas_Volume.Object.cd_filial						[1]		= ll_Filial_Entrega
			lds_Etiquetas_Volume.Object.de_endereco				[1]		= ls_Endereco
			lds_Etiquetas_Volume.Object.nr_cep						[1]		= ls_Cep
			lds_Etiquetas_Volume.Object.nm_cidade					[1]		= ls_Cidade
			lds_Etiquetas_Volume.Object.nm_unidade_federacao	[1]		= ls_Unidade_Federacao
			lds_Etiquetas_Volume.Object.nr_rota						[1]		= ll_Rota
		Else
			lds_Etiquetas_Volume.Object.de_filial						[1]		= lds.Object.de_filial[1]
			lds_Etiquetas_Volume.Object.cd_filial						[1]		= lds.Object.cd_filial[1]
			lds_Etiquetas_Volume.Object.de_endereco				[1]		= lds.Object.de_endereco[1]
			lds_Etiquetas_Volume.Object.nr_cep						[1]		= lds.Object.nr_cep[1]
			lds_Etiquetas_Volume.Object.nm_cidade					[1]		= lds.Object.nm_cidade[1]
			lds_Etiquetas_Volume.Object.nm_unidade_federacao	[1]		= lds.Object.nm_unidade_federacao[1]
			lds_Etiquetas_Volume.Object.nr_rota						[1]		= lds.Object.nr_rota_entrega[1]	
		End If
	
		If lds.object.id_pedido_almoxarifado[1] = 'S' Then //Corre$$HEX2$$e700e300$$ENDHEX$$o para pegar a ordem da bacia correta para pedidos almoxarifados feitos pela matriz
			If  ll_Nr_Ordem_Bacia > 0   Then		
				lds_Etiquetas_Volume.Object.nr_ordem_bacia	[1]	 = ll_Nr_Ordem_Bacia 
			Else
				lds_Etiquetas_Volume.Object.nr_ordem_bacia	[1]	 = lds.Object.nr_ordem_bacia[1] 		
			End If 
			lds_Etiquetas_Volume.Object.nm_requisitante[1] = "Req.:"+ls_Nm_Requisitante			
		Else
			lds_Etiquetas_Volume.Object.nr_ordem_bacia		[1]	= lds.Object.nr_ordem_bacia[1] 
		End If 

		lds_Etiquetas_Volume.Object.nr_volumes				[1]		= lds.Object.nr_volumes[1]
		lds_Etiquetas_Volume.Object.total_volumes				[1]		= lds.Object.total_volumes[1]
		lds_Etiquetas_Volume.Object.id_rede						[1]		= lds.Object.id_rede[1]			
		lds_Etiquetas_Volume.Object.nr_pedido					[1]		= lds.Object.nr_pedido_distribuidora[1]	
		lds_Etiquetas_Volume.Object.nr_chave_volume		[1]		= lds.Object.nr_chave_volume[1]	
		
		ll_Qt_Prd_Geladeira 		= lds.Object.qt_produtos_geladeira	[1]	
		ls_Volume_Extra			= lds.Object.id_volume_extra			[1]	
		ls_Pedido_Almoxarifado	= lds.Object.id_pedido_almoxarifado	[1]	
		ll_Esteira						= lds.Object.cd_esteira					[1]	
		ll_Nr_Chave_Volume 		= lds.Object.nr_chave_volume			[1] 
		
		
		SetNull(ls_De_Volume_Extra)
		
		If ls_Volume_Extra = "S" Then
			ls_De_Volume_Extra = "VOLUME EXTRA"
		End If
		
		If ls_Pedido_Almoxarifado = "S" Then
			If ls_Volume_Extra = "S" Then
				ls_De_Volume_Extra = "ALMOXARIFADO/VOL EXTRA"	
			Else
				ls_De_Volume_Extra = "ALMOXARIFADO"	
			End If
		Else	
			If ll_Esteira = 2 Then//Medicamentos
				If ls_Volume_Extra = "S" Then
					ls_De_Volume_Extra = "MEDICAMENTO/VOL EXTRA"
				Else
					ls_De_Volume_Extra = "MEDICAMENTO"	
				End If
			ElseIf ll_Esteira = 1 Then//Perfumaria
				If ls_Volume_Extra = "S" Then
					ls_De_Volume_Extra = "PERFUMARIA/VOL EXTRA"
				Else
					ls_De_Volume_Extra = "PERFUMARIA"	
				End If				
			ElseIf ll_Esteira = 3 Then // Controlado:  Coloca texto abaixo para identificar confer$$HEX1$$ea00$$ENDHEX$$ncia na loja(somente para loja com parametro SIM)
					If ib_EtiquetaLojaControladoVigiado Then 
						ls_De_Volume_Extra = "CONFERIR NA LOJA"													  
					End If 
			ElseIf ll_Esteira = 7 Then // Esteira de SuplInfantil
					If ls_Volume_Extra = "S" Then
						ls_De_Volume_Extra = "SUPL.INFANTIL/VOL EXTRA"
					Else
						ls_De_Volume_Extra = "SUPL.INFANTIL"	
					End If					
			Else
				If (ll_Qt_Prd_Geladeira > 0) And (ls_Volume_Extra = "S") Then
					ls_De_Volume_Extra = "TERMOL$$HEX1$$c100$$ENDHEX$$BIL / VOL EXTRA"	
				ElseIf (ll_Qt_Prd_Geladeira < 1) And (ls_Volume_Extra = "S") Then
					ls_De_Volume_Extra = "VOLUME EXTRA"	
				ElseIf (ll_Qt_Prd_Geladeira > 0) And (ls_Volume_Extra <> "S") Then	
					ls_De_Volume_Extra = "TERMOL$$HEX1$$c100$$ENDHEX$$BIL"
				End If
			End If
		End If
		
		lds_Etiquetas_Volume.Object.cd_filial_cod_barras	[1]		= al_Filial		
		lds_Etiquetas_Volume.Object.nm_volume_extra	[1]		= ls_De_Volume_Extra			
		
		ls_EAN13 = String(ll_Nr_Chave_Volume,'00000000')		
		lds_Etiquetas_Volume.Object.de_codigo_barras[1]   = "*"+ls_EAN13+"*"		
		
		lds_Etiquetas_Volume.Print()
		Sleep(2)
	ElseIf ll_Linhas = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizado as informa$$HEX2$$e700f500$$ENDHEX$$es da filial "+String(al_Filial)+" pedido "+String(al_Pedido)+" volume "+String(al_volume)+".")
		Return False
	Else // ll_Linhas < 0
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar as informa$$HEX2$$e700f500$$ENDHEX$$es para a impress$$HEX1$$e300$$ENDHEX$$o da etiqueta.")
		Return False
	End If

Finally
	Destroy(lds)
	Destroy(lds_Etiquetas_Volume)
End Try



end function

public function boolean of_processa_geracao_picking ();Long ll_Nulo
Date ldt_data 
Boolean lb_Pedido_Almoxarifado = False
Boolean lb_Pedido_Controlado = False // Vem como true da GE563

SetNull(ll_Nulo)
SetNull(ldt_data)

// Esta func$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ chamada pela RO033.
// Separado Processo de Picking de Controlado, este vem de Tela GE563
Return of_processa_geracao_picking(ll_Nulo, ll_Nulo, lb_Pedido_Almoxarifado, lb_Pedido_Controlado, ldt_data )

Return True 


// Teste de um Pedido: Vem da Tela Nova : Controlado 
//Return of_processa_geracao_picking(149, 17017455 , False, True , ldt_data)








end function

public subroutine of_leiame ();// Liberar a gera$$HEX2$$e700e300$$ENDHEX$$o do picking novamente...

// Mudar a situa$$HEX2$$e700e300$$ENDHEX$$o do pedido para COLOCADO
// QT_LISTA_SEPARACAO da tabela pedido_distribuidora_produto deve ser zerada
// cancelar os volumes
end subroutine

public function boolean of_grava_volume_caixa_padrao_almox ();Boolean lb_Sucesso = True

DateTime ldh_Validade

String ls_Endereco, ls_Lote,ls_msg

Long ll_Qtde_Caixa, ll_Linha, ll_Linhas, ll_Etiqueta_Caixa, ll_Saldo, ll_Reserva

Long ll_Produto, ll_QT_Pedida,  ll_Linhas_Produto,  ll_Linha_Produto,ll_Filial_Estoque

try
	
	If not of_carrega_parametro_filial(Ref ll_Filial_Estoque,Ref ls_msg ) Then Return False
	
	dc_uo_ds_base lds
	lds = Create dc_uo_ds_base
	If Not lds.of_ChangeDataObject("ds_ge259_produto_pulmao_almox") Then Return False
	
	dc_uo_ds_base lds_Produto_Pedido
	lds_Produto_Pedido = Create dc_uo_ds_base
	If Not lds_Produto_Pedido.of_ChangeDataObject("ds_ge259_produto_pedido_almox") Then Return False
	
	lds_Produto_Pedido.of_AppendWhere(" exists (select * from produto_central x where x.cd_produto = p.cd_produto and id_separacao_cx = 'A') ", 1)
	
	ll_Linhas_Produto = lds_Produto_Pedido.Retrieve(il_Filial, il_Pedido)
	
	If ll_Linhas_Produto < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar os produtos do pedido para gerar o volume de caixa fechada do almoxarifado.", StopSign!)
		Return False
	End If
	
	// Lista todos os produtos do pedido
	For ll_Linha_Produto = 1 To ll_Linhas_Produto
		
		ll_Produto 		= lds_Produto_Pedido.Object.cd_produto	[ll_Linha_Produto]
		ll_QT_Pedida	= lds_Produto_Pedido.Object.qt_pedida		[ll_Linha_Produto]
						
		ll_Linhas = lds.Retrieve(ll_Produto,ll_Filial_Estoque)
		
		// Se existir saldo no endere$$HEX1$$e700$$ENDHEX$$o
		If ll_Linhas > 0 Then
			
			For ll_Linha = 1 To ll_Linhas
				
				ll_Qtde_Caixa		= lds.Object.qt_caixa_padrao	[ll_Linha]
				ls_Endereco			= lds.Object.cd_endereco		[ll_Linha]
				ls_Lote				= lds.Object.nr_lote				[ll_Linha]
				ldh_Validade		= lds.Object.dh_validade			[ll_Linha]
				ll_Saldo				= lds.Object.qt_saldo				[ll_Linha]
				
				Select coalesce(max(nr_etiqueta), 0)
				Into :ll_Etiqueta_Caixa
				From wms_etiqueta_produto 
				Where cd_produto 		= :ll_Produto
					and qt_caixa_padrao	= :ll_Qtde_Caixa
					and nr_lote				= :ls_Lote
					and dh_validade 		= :ldh_Validade
				Using Sqlca;
				  
				If SqlCa.SqlCode = -1 Then
					SqlCa.of_MsgDbError("Erro ao localizar a etiqueta da caixa do produto '" + String(ll_Produto) + "'")
					Return False
				Else
					If ll_Etiqueta_Caixa = 0 Then
						SetNull(ll_Etiqueta_Caixa)
					Else
						
						Select qt_reserva
						Into :ll_Reserva
						From wms_reserva_pulmao
						Where	cd_endereco 		=	:ls_Endereco
							and	cd_produto			=	:ll_Produto
							and	nr_etiqueta_caixa 	=	:ll_Etiqueta_Caixa
						Using Sqlca;
						
						Choose Case SqlCa.SqlCode
							Case 0
								ll_Saldo = ll_Saldo - ll_Reserva
								
								If ll_Saldo < 0 Then ll_Saldo = 0
							Case 100
							Case -1
								SqlCa.of_MsgDbError("Erro ao localizar a quantidade reservada do produto '" + STring(ll_Produto) + "'")
								Return False
						End Choose
					End If
				End If
				
				Do While ll_Saldo > 0
										
					If ll_QT_Pedida > 0  Then
						If Mod(ll_QT_Pedida, ll_Qtde_Caixa) = 0  or ll_QT_Pedida > ll_Qtde_Caixa Then 
							If Not of_Insere_Volume_Caixa(ll_Produto, ls_Endereco, ll_Qtde_Caixa, ll_Etiqueta_Caixa) Then
								Return False
							End If
						
							ll_QT_Pedida = ll_QT_Pedida - ll_Qtde_Caixa
							
							// -1 porque $$HEX1$$e900$$ENDHEX$$ uma caixa
							ll_Saldo = ll_Saldo - 1
							
							If ll_QT_Pedida = 0 Then Exit
						Else
							Exit
						End If		
					End If
					
				Loop
				
				If ll_QT_Pedida = 0 Then Exit
			Next
			
		End If
		// Termino - Se existir saldo no endere$$HEX1$$e700$$ENDHEX$$o
		
	Next
	// Termino - lista dos produtos do pedido

finally
	Destroy(lds)
	Destroy(lds_Produto_Pedido)
end try

Return True
end function

public function boolean of_imprime_picking_pulmao (long al_filial, long al_pedido, long al_volume);	Long 	ll_Linhas,&
		ll_Linha,&
		ll_Rota,&
		ll_Filial,&
		ll_Nr_Ordem_Bacia,&
		ll_Nr_Chave_Volume,&
		ll_Cd_Centro_Custo_Entrega
		

String	ls_EAN128,&
		ls_Departamento,&
		ls_Endereco,&
		ls_Cep,&
		ls_Cidade,&
		ls_Unidade_Federacao,&
		ls_EAN13,&
		ls_Nm_Requisitante
			
Boolean 	lb_Departamento = False,&
			lb_Centro_Custo_Entrega = False

dc_uo_ds_base lds

Try
	lds = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject("ds_ge259_picking_vol_caixa_imp_termica") Then
		Return False
	End If
	
	If Not IsNull(al_Volume) Then
		lds.of_appendwhere_subquery( "a.nr_volume = "+String(al_Volume), 3) 
	End If
	
	SetNull(ls_Nm_Requisitante)	
	
	ll_Linhas = lds.Retrieve(al_Filial, al_Pedido)
	
	If ll_Linhas > 0 Then
		
		If lds.object.id_pedido_almoxarifado[1] = "S" Then
			If Not of_Departamento_Pedido	(	al_Filial,&
														al_Pedido,&
														Ref ls_Departamento,&
														Ref lb_Departamento,&
														Ref ls_Endereco,&
														Ref ls_Cep,&
														Ref ls_Cidade,&
														Ref ls_Unidade_Federacao,&
														Ref ll_Rota,&
														Ref ll_Filial,&
														Ref lb_Centro_Custo_Entrega,&
														Ref ll_Nr_Ordem_Bacia,&
														Ref ll_Cd_Centro_Custo_Entrega,&
														Ref ls_Nm_Requisitante) Then
				Return False
			End If
		End If
		
		For ll_Linha = 1 To ll_Linhas		
			//ls_EAN128 = "1"+right("0000" + String(lds.object.cd_filial[ll_Linha]),4) +right("000000000"+String(lds.object.nr_pedido_distribuidora[ll_Linha]),6) + right("000"+String(lds.object.nr_volume[ll_Linha]),3)
			//ls_EAN128 = "1"+right("0000" + String(lds.object.cd_filial[ll_Linha]),4) +right("000000000"+String(lds.object.nr_pedido_distribuidora[ll_Linha]),7) + right("000"+String(lds.object.nr_volume[ll_Linha]),2)
			////Anterior :  ls_EAN128 = "1"+right("0000" + String(lds.object.cd_filial[ll_Linha]),4) +right("0000000000"+String(lds.object.nr_pedido_distribuidora[ll_Linha]),10) + right("000"+String(lds.object.nr_volume[ll_Linha]),3)
			//lds.object.de_codigo_barras[ll_Linha]	= ls_EAN128
			//lds.object.ean_128[ll_Linha] = f_ge259_ean128(ls_EAN128)

			// Novo 			
			ll_Nr_Chave_Volume = lds.Object.nr_chave_volume[ll_Linha]   
			ls_EAN128 = String(ll_Nr_Chave_Volume,'00000000')		
			lds.object.de_codigo_barras[ll_Linha]	= ls_EAN128
			lds.Object.ean_128[ll_Linha]   = "*"+ls_EAN128+"*"		
	
			If lds.object.id_pedido_almoxarifado[1] = "S"   Then 
				lds.Object.nm_requsitante[ll_Linha] = "Req.:"+ls_Nm_Requisitante				
			End If
	
			If lb_Centro_Custo_Entrega Then
				lds.object.nr_rota_entrega[ll_Linha] = ll_Rota
				lds.object.de_filial[ll_Linha] = ls_Departamento
			End If
			
		Next
		
		If lds.Print() = -1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao imprimir o picking da filial '" + String(al_Filial) + "'.")
		End If
	ElseIf ll_Linhas < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar as informa$$HEX2$$e700f500$$ENDHEX$$es para a impress$$HEX1$$e300$$ENDHEX$$o do picking.")
	End If
Finally
	Destroy(lds)
End Try



end function

public function boolean of_tipo_impressora (long ai_esteira, ref string as_impressora, ref string as_parametro);//Verifica em qual impressora vai imprimir
// L -> Lazer
// T -> T$$HEX1$$e900$$ENDHEX$$rmica
Select IsNull(id_impressora_picking, 'L')
Into :as_Impressora
From wms_esteira
Where cd_esteira = :ai_Esteira
Using SqlCa;

Choose Case SqlCa.SqlCode 
	Case 0
	Case 100
		as_Impressora = "L"
	Case -1
		MessageBox("Erro", "Erro ao consultar qual $$HEX1$$e900$$ENDHEX$$ a impressora que ser$$HEX1$$e100$$ENDHEX$$ utilizada para imprimir a lista de separa$$HEX2$$e700e300$$ENDHEX$$o: "+sqlCa.sqlErrText, StopSign!)
		Return False
End Choose


Select vl_parametro
Into :as_Parametro
From wms_parametro
Where cd_parametro = 'ID_IMPRIME_ETIQUETA_IMPRESSORA_TERMICA'
Using SqlCa;

Choose Case SqlCa.SqlCode 
	Case 0
	Case 100
		as_Parametro = "N"
	Case -1
		MessageBox("Erro", "Erro ao consultar o par$$HEX1$$e200$$ENDHEX$$metro 'ID_IMPRIME_ETIQUETA_IMPRESSORA_TERMICA': "+sqlCa.sqlErrText, StopSign!)
		Return False
End Choose

Return True
end function

public function boolean of_filial_liberada_esteira_tracionada (long al_filial, ref boolean ab_filial_liberada);String	ls_Parametro,&
		ls_MSG

//ab_Filial_Liberada = False
//
//select coalesce(vl_parametro, 'N' )
//Into	:ls_Parametro
//from parametro_loja 
//where cd_parametro = 'WMS_UTILIZA_ESTEIRA_TRACIONADA'
//and cd_filial = :al_Filial
//Using SqlCa;
//
//Choose Case SqlCa.SqlCode
//	Case 0
//		If ls_Parametro = "S" Then
//			ab_Filial_Liberada = True
//		End If
//	Case 100
//
//	Case -1
//		ls_MSG = "Arro ao verificar se a filial "+String(al_Filial)+" est$$HEX1$$e100$$ENDHEX$$ liberada para a esteira tracionada.~rErro:"+ SqlCa.SqlErrText
//		SqlCa.of_RollBack()
//		This.of_grava_log(ls_MSG, True)
//		Return False
//End Choose

//Todas as filiais est$$HEX1$$e300$$ENDHEX$$o na esteira tracionada
ab_Filial_Liberada = True

Return True
end function

public function boolean of_altera_situacao_pedido_empurrado ();String ls_MSG

Long ll_Linhas, ll_Linha, ll_Pedido_Empurrado

dc_uo_ds_base lds

try
	lds = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject("ds_ge259_pedido_empurrado", False) Then
		SqlCa.of_RollBack()
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na mudan$$HEX1$$e700$$ENDHEX$$a na DW 'ds_ge259_pedido_empurrado'.", StopSign!)
		Return False
	End If
	
	ll_Linhas = lds.Retrieve(il_Filial, il_Pedido)
		
	If ll_Linhas > 0 Then
		
		For ll_Linha = 1 To ll_Linhas
			ll_Pedido_Empurrado = lds.Object.nr_pedido_empurrado[ll_Linha]
			
			Update pedido_empurrado
			Set id_situacao = 'S'
			Where cd_filial						=	:il_Filial
				and nr_pedido_empurrado 	=	:ll_Pedido_Empurrado
				and id_situacao = 'P'
			Using SqlCa;
			
			If Sqlca.SqlCode = -1 Then
				ls_MSG = 	"Erro ao alterar a situa$$HEX2$$e700e300$$ENDHEX$$o 'EM SEPARACAO' do pedido empurrado '" + String(ll_Pedido_Empurrado) + "' da filial '" + String(il_Filial) + "'. '" + SQLCA.SQLErrText + "'."
				SqlCa.of_RollBack()
				Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_MSG, StopSign!)
				Return False
			End If			
		Next	
		
	ElseIf ll_Linhas < 0 Then
		SqlCa.of_RollBack()
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na mudan$$HEX1$$e700$$ENDHEX$$a na DW 'ds_ge259_pedido_empurrado'.", StopSign!)
		Return False
	End If
	
finally
	Destroy(lds)
end try

Return True
end function

private function boolean of_update_pedido_empurrado (long al_filial, long al_pedido, ref string as_erro);dc_uo_ds_base lds_Pedidos

Long	ll_linha,&
		ll_Linhas,&
		ll_Pedido

Try
	lds_Pedidos = Create dc_uo_ds_base
	If Not lds_Pedidos.of_ChangeDataObject("ds_ge259_pedido_empurrado_update") Then 
		Return False
	End If
	
	ll_linhas	= lds_Pedidos.Retrieve(al_Filial, al_Pedido)
	
	If ll_Linhas < 0 Then
		as_Erro = "Erro no retrieve da ds_ge259_pedido_empurrado_update"
		Return False
	End If
	
	For ll_Linha = 1 To ll_linhas
		
		ll_Pedido	= lds_Pedidos.Object.nr_pedido_empurrado[ll_Linha]
		
		Update pedido_empurrado
		set id_situacao = 'S'
		Where cd_filial						= :al_Filial
			And nr_pedido_empurrado	= :ll_Pedido
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			as_Erro = "Erro no update da tabela PEDIO_EMPURRADO. Filial: "+String(al_Filial)+" Pedido: "+String(al_Pedido)+". " + SqlCa.SqlErrText
			Return False
		End If		
		
	Next
Finally
	Destroy(lds_Pedidos)
End Try

Return True
end function

public function boolean of_monta_ordem_separacao_nova (long al_filial, long al_pedido);Long ll_Linha, ll_Linhas, ll_Produto, ll_Sequencial, ll_Produtos, ll_Achou

String ls_Rua, ls_MSG, ls_Endereco, ls_Grupo_Psico

dc_uo_ds_base lds

Try
	lds = Create dc_uo_ds_base
		
	If Not lds.of_ChangeDataObject("ds_ge259_ordem_separacao") Then Return False
	
	// Somente para a esteira da PERFUMARIA
	If ib_endereco_500 Then
		/// Processo para Grupo Picking Na Lista de Separa$$HEX2$$e700e300$$ENDHEX$$o
		If ib_Filial_Wms_Grupo_Picking Then 
			If ii_grupo_picking > 0 Then
				lds.of_AppendWhere( "  p.cd_produto  in (  select   cd_produto  from  wms_grupo_picking_prd   where  cd_grupo_pick  = "+ String(ii_grupo_picking) + ")")
			Else
				lds.of_AppendWhere( "  p.cd_produto  not  in (  select   distinct  cd_produto  from  wms_grupo_picking_prd  ) " ) 
			End If
		End If 		
		lds.of_AppendWhere("v.cd_endereco in (select x.cd_endereco from wms_endereco x where coalesce(x.id_produto_grande, 'N') = 'S')")
	Else
		/// Processo para Grupo Picking Na Lista de Separa$$HEX2$$e700e300$$ENDHEX$$o
		If ib_Filial_Wms_Grupo_Picking Then 
			If ii_grupo_picking > 0 Then
				lds.of_AppendWhere( "  p.cd_produto  in (  select   cd_produto  from  wms_grupo_picking_prd   where  cd_grupo_pick  = "+ String(ii_grupo_picking) + ")")
			Else
				lds.of_AppendWhere( "  p.cd_produto not  in (  select   distinct  cd_produto  from  wms_grupo_picking_prd )" ) 
			End If
		End If 	
		lds.of_AppendWhere("v.cd_endereco not in (select x.cd_endereco from wms_endereco x where coalesce(x.id_produto_grande, 'N') = 'S')")
	End If
			
	ll_Linhas = lds.Retrieve(al_Filial, al_Pedido, ii_Esteira)
	
	if IsValid(w_ge259_aguarde) then
		w_ge259_aguarde.st_Processo.text = 'Montando a Ordem da Separa$$HEX2$$e700e300$$ENDHEX$$o ...'
		w_ge259_aguarde.uo_Progress.of_setstart()
	end if
	
	If ll_Linhas > 0 Then
		
		Select coalesce(max(nr_ordem_separacao), 0)
		Into :ll_Sequencial
		From wms_lista_separacao_ordem
		Where	cd_filial						= :al_Filial
			And	nr_pedido_distribuidora	= :al_Pedido
			And	cd_esteira					= :ii_Esteira
		Using SqlCa;
		
		Choose Case SqlCa.SqlCode
			Case 0
			Case 100
				ll_Sequencial = 0
			Case -1
				ls_MSG = "Erro ao localizar o sequencial para montar a ordem da separa$$HEX2$$e700e300$$ENDHEX$$o. Fun$$HEX2$$e700e300$$ENDHEX$$o 'of_monta_ordem_separacao_nova'.~rErro: '" + SqlCa.SqlErrText + "'."
				SqlCa.of_RollBack()
				This.of_grava_log(ls_MSG)
				MessageBox("Erro", ls_MSG, StopSign!)
				Return False
		End Choose
			
		if IsValid(w_ge259_aguarde) then
			w_ge259_aguarde.uo_Progress.of_SetMax	(ll_Linhas)
		end if
		
		For ll_Linha = 1 To ll_Linhas
			ll_Produto 		= lds.Object.cd_produto			[ll_Linha]
			ls_Endereco  	=  lds.Object.cd_endereco		[ll_Linha] 		
			ls_Grupo_Psico =  lds.Object.cd_grupo_psico	[ll_Linha] 
						
			ll_Sequencial ++
			
			If (ii_Esteira = 3) and (ib_Controlado_Endereco_Lote) and Not IsNull(ls_Grupo_Psico) Then
				/// Alterado: Processo Controlado/Produto/Lote
				Select cd_produto
				Into :ll_Achou
				From wms_lista_separacao_ordem
				Where cd_filial 						= :al_Filial
					and nr_pedido_distribuidora	= :al_Pedido
					and cd_esteira 					= :ii_Esteira
					and cd_produto 				= :ll_Produto
					and cd_endereco				= :ls_Endereco
				Using SqlCa;
			Else 
				Select cd_produto
				Into :ll_Achou
				From wms_lista_separacao_ordem
				Where cd_filial 						= :al_Filial
					and nr_pedido_distribuidora	= :al_Pedido
					and cd_esteira 					= :ii_Esteira
					and cd_produto 				= :ll_Produto
				Using SqlCa;
			End If
			
			Choose Case SqlCa.SqlCode
				Case 0
					ll_Sequencial --
					
				Case 100
					/// Alterado: Processo Controlado/Produto/Lote
					INSERT INTO wms_lista_separacao_ordem  ( cd_filial, nr_pedido_distribuidora, cd_esteira, cd_produto, nr_ordem_separacao, dh_inclusao, cd_endereco  )  
					VALUES (:al_Filial, :al_Pedido,  :ii_Esteira, :ll_Produto, :ll_sequencial, getdate(), :ls_Endereco )
					Using SqlCa;
					
					If SqlCa.SqlCode = -1 Then
						ls_MSG = "Erro ao incluir o produto '" + String(ll_Produto) + "' para montar a ordem da separa$$HEX2$$e700e300$$ENDHEX$$o. Fun$$HEX2$$e700e300$$ENDHEX$$o 'of_monta_ordem_separacao_nova'.~rErro: '" + SqlCa.SqlErrText + "'."
						SqlCa.of_RollBack()
						This.of_grava_log(ls_MSG)
						MessageBox("Erro", ls_MSG, StopSign!)
						Return False
					End If
				Case -1
					ls_MSG = "Erro ao localizar o produto '" + String(ll_Produto) + "' para montar a ordem da separa$$HEX2$$e700e300$$ENDHEX$$o. Fun$$HEX2$$e700e300$$ENDHEX$$o 'of_monta_ordem_separacao_nova'.~rErro: '" + SqlCa.SqlErrText + "'."
					SqlCa.of_RollBack()
					This.of_grava_log(ls_MSG)
					MessageBox("Erro", ls_MSG, StopSign!)
					Return False
			End Choose
			
			if IsValid(w_ge259_aguarde) then
				w_ge259_aguarde.uo_Progress.of_SetProgress(ll_Linha)
			end if
		Next	
		
	ElseIf ll_Linhas < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar as ruas para montar a ordem de separa$$HEX2$$e700e300$$ENDHEX$$o. Fun$$HEX2$$e700e300$$ENDHEX$$o 'of_monta_ordem_separacao_nova'.")
		Return False
	End If 
	
Finally
	Destroy(lds)
End Try

Return true
end function

public function boolean of_rateio_volume_estourado (long al_filial, long al_pedido, long al_esteira);String 	ls_MSG,&
			ls_Endereco

Long 	ll_Linhas,&
		ll_Linha,&
		ll_Linha_Volume,&
		ll_Linhas_Volume,&
		ll_Linha_Produto,&
		ll_Produto,&
		ll_Qtde_Pedida,&
		ll_Cx_Padrao,&
		ll_Volume,&
		ll_Achou,&
		ll_Find

Decimal	ldc_Capacidade,&
			ldc_Peso_Utilizado,&
			ldc_Litros,&
			ldc_Peso_Grama,&
			ldc_Peso_Volume,&
			ldc_Capacidade_Utilizada
			
dc_uo_ds_base lds_Produto
dc_uo_ds_base lds_Volumes

Try
	lds_Produto		= Create dc_uo_ds_base
	lds_Volumes	= Create dc_uo_ds_base

	If Not lds_Produto.of_ChangeDataObject("ds_ge259_lista_produtos_volume_estouro") Then Return False

	/// Processo para Grupo Picking Na Lista de Separa$$HEX2$$e700e300$$ENDHEX$$o
	If ib_Filial_Wms_Grupo_Picking Then 
		If ii_grupo_picking > 0 Then
			lds_Produto.of_AppendWhere( "  b.cd_produto  in (  select   cd_produto  from  wms_grupo_picking_prd   where  cd_grupo_pick  = "+ String(ii_grupo_picking) + ")")	
		Else
			lds_Produto.of_AppendWhere( "  b.cd_produto  not in (  select  distinct   cd_produto  from  wms_grupo_picking_prd   ) "  ) 
		End If	
	End If		
		
	ll_linhas = lds_Produto.Retrieve(al_Filial, al_pedido, al_Esteira)
	
	// Produtos do volume estourado
	If ll_linhas > 0 Then
		
		If Not lds_Volumes.of_ChangeDataObject("ds_ge259_volumes_nao_estouro") Then Return False

		/// Processo para Grupo Picking Na Lista de Separa$$HEX2$$e700e300$$ENDHEX$$o
		If ib_Filial_Wms_Grupo_Picking  Then 
			If ii_grupo_picking > 0 Then
				lds_Produto.of_AppendWhere( "  b.cd_produto  in (  select   cd_produto  from  wms_grupo_picking_prd   where  cd_grupo_pick  = "+ String(ii_grupo_picking) + ")")
			Else
				lds_Produto.of_AppendWhere( "  b.cd_produto not  in (  select  distinct   cd_produto  from  wms_grupo_picking_prd  ) " ) 
			End If
		End If 		
		
		ll_Linhas_Volume = lds_Volumes.Retrieve(al_Filial, al_pedido, al_Esteira)
		
		// Volumes n$$HEX1$$e300$$ENDHEX$$o estourados
		If ll_Linhas_Volume > 0 Then
			// Produtos do volume estourado
			For ll_Linha = 1 To ll_Linhas
				ll_Produto			= lds_Produto.Object.cd_produto						[ll_linha]
				ldc_Litros			= lds_Produto.Object.qt_capacidade_litros			[ll_linha]
				ll_Cx_Padrao		= lds_Produto.Object.qt_caixa_padrao				[ll_linha]
				ll_Qtde_Pedida		= lds_Produto.Object.qt_pedida						[ll_linha]
				ldc_Peso_Grama	= lds_Produto.Object.qt_peso_kg						[ll_linha]
				ls_Endereco			= lds_Produto.Object.cd_endereco_localizacao		[ll_linha]
				
				ll_Qtde_Pedida = ll_Cx_Padrao * ll_Qtde_Pedida
				
				//Faz uma unidade de produto por vez
				For ll_Linha_Produto = 1 To ll_Qtde_Pedida
					
					// Volumes n$$HEX1$$e300$$ENDHEX$$o estourados
					For ll_Linha_Volume = 1 To ll_Linhas_Volume
						ll_Volume	= lds_Volumes.Object.nr_volume	[ll_Linha_Volume]
						
						//Pega a quantidade j$$HEX1$$e100$$ENDHEX$$ utilizada do volume
						select	qt_capacidade_utilizada,
								qt_peso_kg
						Into	:ldc_Capacidade_Utilizada,
								:ldc_Peso_Volume
						from wms_lista_separacao
						Where cd_filial						= :al_filial
							and nr_pedido_distribuidora = :al_Pedido
							and nr_volume					= :ll_Volume
						Using SqlCa;	
						
						If SqlCa.SqlCode = -1 Then
							ls_MSG = "Erro ao localizar a quantidade j$$HEX1$$e100$$ENDHEX$$ utilizada no volume ao ratear os produtos do volume estourado. " + is_Chave_LOG + SqlCa.SqlErrText
							SqlCa.of_RollBack()
							This.of_grava_log(ls_MSG, True)
							Return False
						End If						
						
						ldc_Capacidade = round(ldc_Capacidade_Utilizada + ldc_Litros, 2)
						
						ldc_Peso_Utilizado = round(ldc_Peso_Volume + ldc_Peso_Grama, 3)
						
						//Alterado a capacidade m$$HEX1$$e100$$ENDHEX$$xima para 14.00 kg para n$$HEX1$$e300$$ENDHEX$$o gerar volumes muito pequenos
						If  (ldc_Capacidade > idc_capacidade_caixa_estouro or ldc_Peso_Utilizado > idc_Peso_Caixa)  Then
						//If  (ldc_Capacidade > idc_capacidade_caixa_estouro or ldc_Peso_Utilizado > 14.00)  Then
							
							//Se percorreu todos os volumes e n$$HEX1$$e300$$ENDHEX$$o encontrou espa$$HEX1$$e700$$ENDHEX$$o de sobra em nenhum volume sai do rateio
							If ll_Linha_Volume = ll_Linhas_Volume Then
								SqlCa.of_RollBack()
								Return False
							End If
							
							//Se ultrapassou a capacidade do volume vai para o pr$$HEX1$$f300$$ENDHEX$$ximo volume
							Continue
						Else
							
							Select w.cd_filial
							Into :ll_Achou
							From wms_lista_separacao_produto w 
							Where w.cd_filial							= :al_filial
								and w.nr_pedido_distribuidora		= :al_Pedido
								and w.nr_volume						= :ll_Volume
								and w.cd_produto						= :ll_Produto
								and w.cd_endereco_localizacao  	= :ls_Endereco
							Using SqlCa;
							
							Choose Case SqlCa.SqlCode
								Case 0
									
									Update wms_lista_separacao_produto
									Set qt_pedida = qt_pedida + 1,
										qt_estouro_volume = coalesce(qt_estouro_volume, 0) + 1
									Where cd_filial							= :al_filial
										and nr_pedido_distribuidora		= :al_Pedido
										and nr_volume						= :ll_Volume
										and cd_produto						= :ll_Produto
										and cd_endereco_localizacao  	= :ls_Endereco
									Using SqlCa;
									
									If Sqlca.SqlCode = -1 Then
										ls_MSG = "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o da quantidade pedida do produto do volume estourado na lista de separa$$HEX2$$e700e300$$ENDHEX$$o. " +is_Chave_LOG +  SqlCa.SqlErrText
										SqlCa.of_RollBack()
										This.of_grava_log(ls_MSG)
										Return False
									End If
											
								Case 100
									
									INSERT INTO wms_lista_separacao_produto	(	cd_filial,   
																									nr_pedido_distribuidora,   
																									nr_volume,   
																									cd_produto,   
																									cd_endereco_localizacao,   
																									qt_pedida,
																									qt_caixa_padrao,
																									qt_peso_kg,
																									qt_capacidade_litros,
																									qt_estouro_volume)  
									VALUES (:al_filial,   
												:al_Pedido,   
												:ll_volume,   
												:ll_produto,   
												:ls_endereco,   
												1,
												:ll_Cx_Padrao,
												:ldc_Peso_Grama,
												:ldc_Litros,
												1) 
									Using SqlCa;
									
									If Sqlca.SqlCode = -1 Then
										ls_MSG = "Erro na inclus$$HEX1$$e300$$ENDHEX$$o do produto do volume estourado na lista de separa$$HEX2$$e700e300$$ENDHEX$$o. " + is_Chave_LOG + SqlCa.SqlErrText
										SqlCa.of_RollBack()
										This.of_grava_log(ls_MSG)
										Return False
									End If
											
								Case -1
									ls_MSG = "Erro ao localizar o produto na lista de separa$$HEX2$$e700e300$$ENDHEX$$o do volume estourado. " + is_Chave_LOG + SqlCa.SqlErrText
									SqlCa.of_RollBack()
									This.of_grava_log(ls_MSG)
									Return False
							End Choose
							
							UPDATE wms_lista_separacao  
							  SET qt_capacidade_utilizada = isnull(qt_capacidade_utilizada, 0) + :ldc_Litros,  
									qt_peso_kg = isnull(qt_peso_kg, 0) + :ldc_Peso_Grama
							Where cd_filial 							= :al_filial
								 and nr_pedido_distribuidora 	= :al_Pedido
								 and nr_volume 					= :ll_Volume
							Using Sqlca;
							
							If SqlCa.SqlCode = -1 Then
								ls_MSG = "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o da lista de separa$$HEX2$$e700e300$$ENDHEX$$o dos produtos do volume estourado. " + is_Chave_LOG + SqlCa.SqlErrText
								SqlCa.of_RollBack()
								This.of_grava_log(ls_MSG, True)
								Return False
							End If
						End If
						
						Exit //Sai do loop porque j$$HEX1$$e100$$ENDHEX$$ inseriu o produto no volume
					Next // volumes n$$HEX1$$e300$$ENDHEX$$o estourados
					
				Next // Qtde do pedida do produto do volume estourado
				
				//Marca o produto para identificar que j$$HEX1$$e100$$ENDHEX$$ rateou para no final do processo verificar se todos os produtos foram rateados
				lds_Produto.Object.id_rateou	[ll_linha] = "S"
			Next // Produtos do volume estourado
			
			ll_Find = lds_Produto.Find("id_rateou <> 'S'", 1, lds_Produto.RowCount())
			
			
			If ll_Find < 0 Then
				ls_MSG = "Erro no find que verifica se todos os produtos do volume estourado foram rateados. " + is_Chave_LOG
				SqlCa.of_RollBack()
				This.of_grava_log(ls_MSG)
				Return False
			End If
			
			//Se todos os produtos foram rateados retorna TRUE para salvar as altera$$HEX2$$e700e300$$ENDHEX$$os nos volumes
			If ll_Find = 0 Then
				//Exclui o volume estourado
				If Not This.of_Exclui_Volume_Estourado(al_filial, al_pedido, al_esteira) Then
					Return False
				End If
				
				Return True
			End If
		Else
			ls_MSG = "N$$HEX1$$e300$$ENDHEX$$o foi localizado nenhum volume n$$HEX1$$e300$$ENDHEX$$o estourado. " + is_Chave_LOG
			SqlCa.of_RollBack()
			This.of_grava_log(ls_MSG)
			Return False
		End If	
		
		//Fun$$HEX2$$e700e300$$ENDHEX$$o para verificar se as quantidades do picking est$$HEX1$$e100$$ENDHEX$$ igual a do pedido 
		If Not of_Valida_Qtde_Apos_Rateio_Estouro(al_filial, al_pedido, al_esteira) Then
			Return False
		End If
	ElseIf ll_Linhas_Volume = 0 Then
		Return True
	Else
		
	End If
Finally
	Destroy(lds_Produto)
	Destroy(lds_Volumes)
End Try

Return False
	

end function

public function boolean of_exclui_volume_estourado (long al_filial, long al_pedido, long al_esteira);Long ll_Volume

String ls_MSG

select max(nr_volume) 
Into :ll_Volume
from wms_lista_separacao 
where cd_filial 							= :al_filial
	and nr_pedido_distribuidora 	= :al_Pedido
	and cd_esteira						= :al_Esteira
	and id_estouro_volume			= 'S'
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_MSG = "Erro ao localizar o volume estourado. (Fun$$HEX2$$e700e300$$ENDHEX$$o 'of_Exclui_Volume_Estourado'). " + is_Chave_LOG + SqlCa.SqlErrText
	SqlCa.of_RollBack()
	This.of_grava_log(ls_MSG, True)
	Return False
End If

delete from wms_lista_separacao_prd_lote
where cd_filial 						= :al_filial
  and nr_pedido_distribuidora 	= :al_Pedido
  and nr_volume 					= :ll_Volume
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_MSG = "Erro ao excluir o volume estourado da tabela 'wms_lista_separacao_prd_lote'. (Fun$$HEX2$$e700e300$$ENDHEX$$o 'of_Exclui_Volume_Estourado'). " + is_Chave_LOG + SqlCa.SqlErrText
	SqlCa.of_RollBack()
	This.of_grava_log(ls_MSG, True)
	Return False
End If

delete from wms_lista_separacao_produto
where cd_filial 						= :al_filial
  and nr_pedido_distribuidora 	= :al_Pedido
  and nr_volume 					= :ll_Volume
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_MSG = "Erro ao excluir o volume estourado da tabela 'wms_lista_separacao_produto'. (Fun$$HEX2$$e700e300$$ENDHEX$$o 'of_Exclui_Volume_Estourado'). " + is_Chave_LOG + SqlCa.SqlErrText
	SqlCa.of_RollBack()
	This.of_grava_log(ls_MSG, True)
	Return False
End If
  
delete from wms_lista_separacao
where cd_filial 						= :al_filial
  and nr_pedido_distribuidora 	= :al_Pedido
  and nr_volume 					= :ll_Volume
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_MSG = "Erro ao excluir o volume estourado da tabela 'wms_lista_separacao'. (Fun$$HEX2$$e700e300$$ENDHEX$$o 'of_Exclui_Volume_Estourado'). " + is_Chave_LOG + SqlCa.SqlErrText
	SqlCa.of_RollBack()
	This.of_grava_log(ls_MSG, True)
	Return False
End If
				
Return True
end function

public function boolean of_valida_qtde_apos_rateio_estouro (long al_filial, long al_pedido, long al_esteira);Long ll_Qtde

String ls_MSG

select count(*)
Into :ll_Qtde
from (
	 select qt_lista_separacao,
	 
	 (select sum(b1.qt_pedida * b1.qt_caixa_padrao)
	 from wms_lista_separacao a1
	 inner join wms_lista_separacao_produto b1 on b1.cd_filial = a1.cd_filial
															and b1.nr_pedido_distribuidora = a1.nr_pedido_distribuidora
															and b1.nr_volume = a1.nr_volume
	 where a1.cd_filial						= a.cd_filial
	 and a1.nr_pedido_distribuidora = a.nr_pedido_distribuidora
	 and a1.cd_esteira = b.cd_esteira
	 and b1.cd_produto = a.cd_produto ) as qt_pedida
	 
	 
	 from pedido_distribuidora_produto a
	 inner join wms_endereco_produto b on b.cd_produto = a.cd_produto
	 where a.cd_filial						= :al_Filial
		and a.nr_pedido_distribuidora	= :al_Pedido
		and b.cd_esteira = :al_Esteira
)as tudo 
where qt_lista_separacao <> qt_pedida
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_MSG = "Erro ao validar as quantidades dos volumes. " + is_Chave_LOG + SqlCa.SqlErrText
	SqlCa.of_RollBack()
	This.of_grava_log(ls_MSG, True)
	Return False
Else
	If ll_Qtde > 0 Then
		ls_MSG = "Existe produto com a quantidade pedida diferente da queantidade do picking. " + is_Chave_LOG + SqlCa.SqlErrText
		SqlCa.of_RollBack()
		This.of_grava_log(ls_MSG, True)
		Return False
		End If
End If

Return True		
end function

public function boolean of_imprime_picking (long al_filial, long al_pedido, long al_flow_pulmao, long al_volume);
If al_flow_pulmao = 1 Then	//Flow
	If Not of_Imprime_Picking_Flow(al_filial, al_pedido, al_volume) Then
		Return False
	End If
Else	//Pulm$$HEX1$$e300$$ENDHEX$$o
	If Not of_Imprime_Picking_Pulmao(al_filial, al_pedido, al_volume) Then
		Return False
	End If
End If

Return True

end function

public function boolean of_imprime_picking_flow (long al_filial, long al_pedido, long al_volume);Long 	ll_Linhas,&
		ll_Rota,&
		ll_Filial,&
		ll_Pedido_Distribuidora,&
		ll_Volume,&
		ll_Linha,&
		ll_Produto,&
		ll_Nr_Ordem_Bacia,&
		ll_Cd_Centro_Custo_Entrega

String 	ls_DS,&
			ls_EAN128,&
			ls_Departamento,&
			ls_Endereco,&
			ls_Cep,&
			ls_Cidade,&
			ls_Unidade_Federacao,&
			ls_Sql_Detalhes,&
			ls_Sql_Cabecalho,&
			ls_Pedido_Almoxarifado,&
			ls_Erro,&
			ls_EnderecoLocalizacao,&
			ls_LoteProdutoGeladeira,&
			ls_Id_Geladeira,&
			ls_Requisitante
		
			
Boolean 	lb_Departamento = False,&
			lb_Centro_Custo_Entrega = False

Boolean lb_Retira_Produto_Sem_Saldo = False

datawindowchild	ldwc_Report_Cabecalho,&
						ldwc_Report_Detalhes
						

dc_uo_ds_base lds

//Retira do picking os produtos que n$$HEX1$$e300$$ENDHEX$$o tem saldo no flow
If of_Retira_Produto_Sem_Saldo() Then			
	lb_Retira_Produto_Sem_Saldo = True
End If
		

Try
	lds = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject("ds_ge259_picking_imp_termica_composite") Then
		Return False
	End If	
	
	//Monta o cabe$$HEX1$$e700$$ENDHEX$$alho
	ls_Sql_Cabecalho	=	"  SELECT 	a.cd_filial, "+&
								"				' (' + LTRIM(str(a.cd_filial)) + ') '+ f.nm_fantasia as de_filial, "+&
								"				a.nr_pedido_distribuidora, "+&
								"				a.nr_volume, "+&
								"				t.de_tipo_volume, "+&
								"				p.dh_emissao, "+&
								"				(select count(nr_volume) from wms_lista_separacao x "+&
								"				where x.cd_filial = a.cd_filial "+&
								"				  and x.nr_pedido_distribuidora = a.nr_pedido_distribuidora) as total_volume, "+&
								"				s.de_esteira, "+&
								"				space(20) ean_128, "+&
								"				f.nr_rota_entrega, "+&
								"				a.cd_esteira, "+&
								"				coalesce(p.id_pedido_almoxarifado, 'N') as id_pedido_almoxarifado, "+&
								"				a.qt_capacidade_utilizada, "+&
								"				(SELECT wr.de_recipiente "+&
								"					FROM parametro_loja pl "+&
								"					INNER JOIN wms_recipiente wr ON wr.cd_recipiente = CAST(vl_parametro AS INT) "+&
								"					WHERE pl.cd_parametro = 'ID_WMS_TIPO_RECIPIENTE_GELADEIRA'"+&
								"					AND pl.cd_filial = a.cd_filial "+&
								"				) AS de_recipiente_geladeira "+&
								" FROM wms_lista_separacao a "+&
								" inner join filial	f	on a.cd_filial	= f.cd_filial "+&
								" inner join wms_tipo_volume t on t.cd_tipo_volume = a.cd_tipo_volume "+&
								" inner join pedido_distribuidora	p on p.cd_filial = a.cd_filial and p.nr_pedido_distribuidora = a.nr_pedido_distribuidora "+&
								" inner join wms_esteira	s on s.cd_esteira = a.cd_esteira "+&
								"  Where a.cd_filial						= "+String(al_Filial)+&
								"  and a.nr_pedido_distribuidora 		= "+String(al_Pedido)+&
								"  and a.cd_esteira						= "+String(ii_Esteira)+&
								"  and a.nr_volume						= "+String(al_Volume)+&
								"  and a.cd_tipo_volume 					= 1 "

	If lds.getchild('dw_1', ldwc_Report_Cabecalho) = -1 Then
		MessageBox("Aviso", "Erro no getchild da 'ldwc_Report_Cabecalho'")
		Return False
	End If
	
	If ldwc_Report_Cabecalho.SetTransObject( SqlCa) = -1 Then
		MessageBox("Aviso", "Erro no settransobject da 'ldwc_Report_Cabecalho'")
		Return False
	End If
	
	If ldwc_Report_Cabecalho.SetSQLSelect(ls_Sql_Cabecalho) = -1 Then
		MessageBox("Aviso", "Erro no setsqlselect da 'ldwc_Report_Cabecalho'")
		Return False
	End If
	
	ll_Linhas = ldwc_Report_Cabecalho.Retrieve()
	
	If ll_Linhas = -1 Then
		MessageBox("Aviso", "Erro no retrieve da 'ldwc_Report_Cabecalho'")
		Return False
	End If		
	
	ls_Pedido_Almoxarifado = ldwc_Report_Cabecalho.GetItemString(1, "id_pedido_almoxarifado");
	
	If ls_Pedido_Almoxarifado = "" Then
		MessageBox("Aviso", "Erro no GetItem da 'id_pedido_almoxarifado'.")
		Return False
	End If
	
	If ls_Pedido_Almoxarifado = "S" Then
		If Not of_Departamento_Pedido	(	al_Filial,&
													al_Pedido,&
													Ref ls_Departamento,&
													Ref lb_Departamento,&
													Ref ls_Endereco,&
													Ref ls_Cep,&
													Ref ls_Cidade,&
													Ref ls_Unidade_Federacao,&
													Ref ll_Rota,&
													Ref ll_Filial,&
													Ref lb_Centro_Custo_Entrega,&
													Ref ll_Nr_Ordem_Bacia,&
													Ref ll_Cd_Centro_Custo_Entrega,&
													Ref ls_Requisitante) Then
			Return False
		End If
	End If
	
	ll_Filial	= ldwc_Report_Cabecalho.GetItemNumber(1, "cd_filial");
	If ll_Filial = -1 Then
		MessageBox("Aviso", "Erro no GetItemNumber da 'cd_filial'.")
		Return False
	End If
	
	ll_Pedido_Distribuidora = ldwc_Report_Cabecalho.GetItemNumber(1, "nr_pedido_distribuidora");
	If ll_Pedido_Distribuidora = -1 Then
		MessageBox("Aviso", "Erro no GetItemNumber da 'nr_pedido_distribuidora'.")
		Return False
	End If
	
	ll_Volume =  ldwc_Report_Cabecalho.GetItemNumber(1, "nr_volume");
	If ll_Volume = -1 Then
		MessageBox("Aviso", "Erro no GetItemNumber da 'nr_volume'.")
		Return False
	End If
			
	ls_EAN128 = '*' + right("0000" + String(ll_Filial),4) +right("000000000"+String(ll_Pedido_Distribuidora),10) + right("000"+String(ll_Volume),3) + '*'
	
	If ldwc_Report_Cabecalho.setitem(1, 'ean_128', ls_EAN128) = -1 Then
		MessageBox("Aviso", "Erro no setitem da coluna 'ean_128'.")
		Return False
	End If
	
	If lb_Centro_Custo_Entrega Then
		If ldwc_Report_Cabecalho.setitem(1, 'nr_rota_entrega', ll_Rota) = -1 Then
			MessageBox("Aviso", "Erro no setitem da coluna 'nr_rota_entrega'.")
			Return False
		End If
		
		If ldwc_Report_Cabecalho.setitem(1, 'de_filial', ls_Departamento) = -1 Then
			MessageBox("Aviso", "Erro no setitem da coluna 'de_filial'.")
			Return False
		End If
	End If
	
	
	If lb_Retira_Produto_Sem_Saldo Then
		ls_Erro = ldwc_Report_Cabecalho.Modify("t_produtos_sem_saldo_flow.Visible = 1")
	Else
		ls_Erro = ldwc_Report_Cabecalho.Modify("t_produtos_sem_saldo_flow.Visible = 0")
	End If
	
	If ls_Erro <> "" Then	
		MessageBox("Erro", "Erro ao alterar a propriedade visible da coluna 't_produtos_sem_saldo_flow': " + ls_Erro)
		Return False
	End If
	
	//Monta os detalhes
	ls_Sql_Detalhes	=	"  SELECT 	a.cd_filial, "+&
								" 				a.nr_volume, "+&
								" 				b.cd_produto, "+&
								" 				g.de_produto + ' : ' + g.de_apresentacao_estoque as de_produto, "+&
								" 				de_endereco_flow_rack, "+&
								"				b.qt_pedida, "+&
								"				b.qt_caixa_padrao, "+&
								"				e.cd_rua, "+&
								"				g.de_codigo_barras, "+&
								"				x.nr_ordem_separacao_flow as nr_ordem_separacao, "+&
								"				e.cd_predio, "+&
								"				e.cd_andar, "+&
								"				g.id_geladeira, "+&
								"				a.cd_esteira, "+&
								"				r.nr_ordem_separacao_flow as nr_ordem_separacao_rua, "+&
								"				coalesce(p.id_pedido_almoxarifado, 'N') as id_pedido_almoxarifado,"+&
								"				'' as nr_lote_produto_geladeira,"+&
								"				e.cd_endereco "+&
								"				FROM wms_lista_separacao a "+&
								"				inner join wms_lista_separacao_produto b on a.cd_filial 							= b.cd_filial "+&
								"  										 							and a.nr_pedido_distribuidora 		= b.nr_pedido_distribuidora "+&
								"  										 							and a.nr_volume						= b.nr_volume "+&
								"  inner join vw_wms_endereco	e	on e.cd_endereco	= b.cd_endereco_localizacao "+&
								"  inner join produto_geral	g	on b.cd_produto	= g.cd_produto "+&
								"  inner join pedido_distribuidora	p on p.cd_filial = a.cd_filial and p.nr_pedido_distribuidora = a.nr_pedido_distribuidora "+&
								"  inner join wms_endereco_produto ep on ep.cd_produto = b.cd_produto and ep.cd_endereco =  b.cd_endereco_localizacao "+&
								"  inner join wms_endereco x on x.cd_endereco = b.cd_endereco_localizacao "+&
								"  inner join wms_rua r on r.cd_rua = x.cd_rua "+&
								"  inner join  vw_classificacao_produto cp on  cp.cd_subcategoria = g.cd_subcategoria  "+&
								"  Where a.cd_filial						= "+String(al_Filial)+&
								"  and a.nr_pedido_distribuidora 		= "+String(al_Pedido)+&
								"  and a.cd_esteira						= "+String(ii_Esteira)+&
								"  and a.nr_volume						= "+String(al_Volume)+&
								"  and a.cd_tipo_volume 					= 1 "	
	
	
	If lb_Retira_Produto_Sem_Saldo Then			
		ls_Sql_Detalhes = ls_Sql_Detalhes +	"	and (	(select isnull(sum(qt_saldo), 0) from wms_localizacao where cd_endereco = b.cd_endereco_localizacao) - "+&
														"	(SELECT isnull(sum(c1.qt_pedida), 0) as qt_saldo "+&
														"	  FROM pedido_distribuidora a1 "+&
														"	  INNER JOIN wms_lista_separacao b1 ON a1.cd_filial = b1.cd_filial AND b1.nr_pedido_distribuidora = a1.nr_pedido_distribuidora "+&
														"	  inner join wms_lista_separacao_produto c1 on c1.cd_filial 	= b1.cd_filial "+&
														"											 and c1.nr_pedido_distribuidora 	= b1.nr_pedido_distribuidora "+&
														"											 and c1.nr_volume						= b1.nr_volume "+&
														"	  WHERE a1.cd_distribuidora = '053404705' "+&
														"		and	a1.dh_emissao >= dateadd(day, -3, getdate()) "+&
														"		and	a1.id_situacao not in ('J', 'X', 'F') "+&
														"		and	b1.dh_cancelamento is null "+&
														"		and	b1.dh_termino_conferencia is null "+&
														"		and	b1.dh_impressao is not null "+&
														"		and	c1.cd_endereco_localizacao = b.cd_endereco_localizacao) ) > 0	"
	End If
	
	If lds.getchild('dw_2', ldwc_Report_Detalhes) = -1 Then
		MessageBox("Aviso", "Erro no getchild da 'report_detalhes'")
		Return False
	End If
	
	If ldwc_Report_Detalhes.SetTransObject( SqlCa) = -1 Then
		MessageBox("Aviso", "Erro no settransobject da 'ldwc_Report_Detalhes'")
		Return False
	End If
	
	If ldwc_Report_Detalhes.SetSQLSelect(ls_Sql_Detalhes) = -1 Then
		MessageBox("Aviso", "Erro no setsqlselect da 'report_detalhes'")
		Return False
	End If
	
	ll_Linhas = ldwc_Report_Detalhes.Retrieve()		
	
	If ll_Linhas = -1 Then
		MessageBox("Aviso", "Erro no retrieve da 'report_detalhes'")
		Return False
	End If


	// Percorre os Registros : Colocar Lote : Produto-a-Produto
//	For ll_Linha =1 to ll_Linhas
//		// Verifica se produto $$HEX1$$e900$$ENDHEX$$ Geladeira
//		ls_Id_Geladeira =  ldwc_Report_Detalhes.GetItemString(ll_Linha, "id_geladeira");
//		
//		If ls_Id_Geladeira='S' Then 
//		   ll_Produto =  ldwc_Report_Detalhes.GetItemNumber(ll_Linha, "cd_produto");
//		   ls_EnderecoLocalizacao =  ldwc_Report_Detalhes.GetItemString(ll_Linha, "cd_endereco");
//		   
//		   // Procura o NrLote do Produto
//		   Select   top 1  nr_lote		 
//		   Into	 :ls_LoteProdutoGeladeira
//		   From   wms_localizacao  
//		   Where  cd_produto= :ll_Produto
//		   And  cd_endereco=:ls_EnderecoLocalizacao
//		   Order by dh_validade
//		   Using SqlCA;		
//			
//			If Today() <> Date("12/04/2021") Then
//				 // Quando n$$HEX1$$e300$$ENDHEX$$o tem Lote
//				If ls_LoteProdutoGeladeira='' Then 
//					Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Para o Produto :" +String(ll_Produto)+ " n$$HEX1$$e300$$ENDHEX$$o encontrado o LOTE no Endereco: "+String (ls_EnderecoLocalizacao) , StopSign!)
//					Return False
//				End If
//			End If
//						
//		   //Atualiza NrLote do Produto	
//		   Choose Case SqlCa.SqlCode
//			Case 0
//				ldwc_Report_Detalhes.SetItem(ll_Linha, "nr_lote_produto_geladeira", ls_LoteProdutoGeladeira  )		
//			Case 100
//				ldwc_Report_Detalhes.SetItem(ll_Linha, "nr_lote_produto_geladeira", " ")		
//			Case -1
//				Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao N$$HEX1$$fa00$$ENDHEX$$mero de Lote: " +SQLCA.SQLErrText + "'.", StopSign!)
//				Return False
//			End Choose
//
//			// Tamano da Altura da DW Quando Geladeira: Coloca Lote Abaixo
//			ldwc_Report_Detalhes.Modify("empname.Height=136")					
//		End If 			
//	Next 

	If ll_Linhas > 0 Then		
		If lds.Print() = -1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao imprimir o picking da filial '" + String(al_Filial) + "'.")
		End If
	ElseIf ll_Linhas < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar as informa$$HEX2$$e700f500$$ENDHEX$$es para a impress$$HEX1$$e300$$ENDHEX$$o do picking.")
	End If
	
Finally
	Destroy(lds)
End Try
end function

public function boolean of_finaliza_geracao_cx_fechada (ref string as_erro);Date	ldt_Atual

ldt_Atual	= Date(gf_GetServerDate())

update controle_geracao_pedido
set dh_termino_geracao_cx_fechada	= GetDate()
where	id_multitask_logistica	= 'S'
	and	dh_pedido				= :ldt_Atual
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_Erro	= "Erro ao gravar o t$$HEX1$$e900$$ENDHEX$$rmino da gera$$HEX2$$e700e300$$ENDHEX$$o do picking de caixa fechada: "+SqlCa.SqlErrText
	Return False
End If

If SqlCa.SqlCode = -1 Then
	as_Erro	= "Erro ao gravar o t$$HEX1$$e900$$ENDHEX$$rmino da gera$$HEX2$$e700e300$$ENDHEX$$o do picking de caixa fechada, deveria ter atualizado 1 linha mas atualizou "+String(SqlCa.SqlCode)+" linhas."
	Return False
End If

Return True
end function

public function boolean of_carrega_parametros_loja (long al_filial);String ls_Msg
String ls_conferencia_loja
String ls_grupo_pick_loja

Select vl_parametro 
Into  :ls_conferencia_loja
From parametro_loja 
Where cd_parametro  = 'ID_FILIAL_NOTA_CONTROLADO'
And   cd_filial  =:al_filial
Using SqlCA;

Choose Case SqlCa.SqlCode
	Case 0
		If ls_conferencia_loja = "S" Then 
			ib_EtiquetaLojaControladoVigiado = True
		Else
			ib_EtiquetaLojaControladoVigiado = False
		End If 					
	Case -1
		ls_MSG = 	"Erro ao verificar o parametro : ID_CONFERENCIA_AUTOMATICA_PEDIDO_CD da filial '" + String(al_filial) + "'. '" + SQLCA.SQLErrText + "'."
		SqlCa.of_RollBack()	
		Return False
End Choose


/// Processo para Grupo Picking Na Lista de Separa$$HEX2$$e700e300$$ENDHEX$$o: Para liberar por Filial
Select vl_parametro 
Into  :ls_grupo_pick_loja
From parametro_loja 
Where cd_parametro  = 'WMS_FILIAL_GRUPO_PICK'
And   cd_filial  =:al_filial
Using SqlCA;

Choose Case SqlCa.SqlCode
	Case 0
		If ls_grupo_pick_loja = "S" Then 
			ib_Filial_Wms_Grupo_Picking = True
		Else
			ib_Filial_Wms_Grupo_Picking = False
		End If 					
	Case -1
		ls_MSG = 	"Erro ao verificar o parametro : WMS_FILIAL_GRUPO_PICK da filial '" + String(al_filial) + "'. '" + SQLCA.SQLErrText + "'."
		SqlCa.of_RollBack()	
		Return False
End Choose













Return True 
end function

public function boolean of_gera_lista_separacao (long al_produto, string as_endereco, long al_prioridade, ref long al_qtde_pedida, decimal adc_litros, long al_prioridade_maxima, decimal adc_peso_grama);Boolean lb_Sucesso = False

Long ll_Linhas, ll_Linha, ll_Produto, ll_Saldo, ll_Qtde_Inserir, ll_Ultimo_Volume

Long ll_Volume, ll_Etiqueta_Caixa, ll_Qtde_Reserva, ll_Nova_Qtde_Pedida, ll_Qtde_Pedida

String ls_Endereco, ls_MSG, ls_Endereco_Anterior

Decimal ldc_Capacidade_Utilizada, ldc_Capacidade, ldc_Percentual

Decimal {3} ldc_Peso_Utilizado, ldc_Peso_Volume

SetNull(ll_Etiqueta_Caixa)

ldc_Capacidade_Utilizada = 0.00
Setnull(ll_Ultimo_Volume)

Select max(nr_volume)
Into :ll_Ultimo_Volume
From wms_lista_separacao
Where cd_filial							= :il_filial
	and nr_pedido_distribuidora 	= :il_pedido
	and cd_tipo_volume				= 1
	and cd_esteira 						= :ii_Esteira
	and dh_cancelamento				is null
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		Select coalesce(qt_capacidade_utilizada, 0), coalesce(qt_peso_kg, 0)
		Into :ldc_Capacidade_Utilizada, :ldc_Peso_Volume
		from wms_lista_separacao
		Where cd_filial							= :il_filial
			and nr_pedido_distribuidora 	= :il_pedido
			and nr_volume 						= :ll_Ultimo_Volume
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			ls_MSG = 	"Erro ao localizar a capacidade m$$HEX1$$e100$$ENDHEX$$xima do volume." +&
							"Erro: '" + SqlCa.SqlErrText + "'"
			SqlCa.of_RollBack()
			This.of_grava_log(ls_MSG)
			MessageBox("Erro", ls_MSG, StopSign!)
			Return False
		End If
	Case 100
	Case -1
		ls_MSG =	"Localiza$$HEX2$$e700e300$$ENDHEX$$o do $$HEX1$$da00$$ENDHEX$$ltimo Volume do Pedido. ~r~r" +&
						"Erro: '" + SqlCa.SqlErrText + "'"
		SqlCa.of_RollBack()
		This.of_grava_log(ls_MSG)
		MessageBox("Erro", ls_MSG, StopSign!)
		Return False
End Choose

ldc_Capacidade = (ldc_Capacidade_Utilizada + round((adc_litros *al_qtde_pedida), 2) )

ldc_Peso_Utilizado = (ldc_Peso_Volume + round((adc_peso_grama *al_qtde_pedida), 3) )


If  (ldc_capacidade > idc_capacidade_caixa or ldc_Peso_Utilizado > idc_peso_caixa) and al_Qtde_Pedida > 1 Then
	ll_Linhas 					= al_Qtde_Pedida
	ll_Nova_Qtde_Pedida 	= 1
Else
	// S$$HEX1$$f300$$ENDHEX$$ vai passar uma vez
	ll_Linhas 					= 1
	ll_Nova_Qtde_Pedida 	= al_qtde_pedida
End If

For ll_Linha = 1 To ll_Linhas
	
	ll_Qtde_Pedida = ll_Nova_Qtde_Pedida
	
	Select coalesce(sum(qt_saldo), 0)
	Into :ll_Saldo
	From wms_localizacao
	where cd_endereco 	= :as_endereco
		and cd_produto 		= :al_produto
	Using Sqlca;
	
	Choose Case Sqlca.SqlCode
		Case 0
		Case 100
			ll_Saldo = 0 
		Case -1
			ls_MSG =	"Erro ao localizar o saldo produto '" + String(al_Produto) + "'.~r~r" +&
							"Erro: '" + SqlCa.SqlErrText + "'"
			SqlCa.of_RollBack()
			This.of_grava_log(ls_MSG)
			MessageBox("Erro", ls_MSG, StopSign!)
			Exit
	End Choose
	
	SELECT qt_reserva  
	Into :ll_Qtde_Reserva
	FROM wms_reserva_flow_rack 
	Where cd_endereco	= :as_endereco
		 and cd_produto	= :al_produto
	Using SqlCa;
	
	If Sqlca.SqlCode = -1 Then
		ls_MSG =	"Erro ao localizar a quantidade reservada do produto '" + String(al_Produto) + "'.~r~r" +&
						"Erro: '" + SqlCa.SqlErrText + "'"
		SqlCa.of_RollBack()
		This.of_grava_log(ls_MSG)
		MessageBox("Erro", ls_MSG, StopSign!)
		Exit
	End If
	
	ll_Saldo = ll_Saldo - ll_Qtde_Reserva
	
	If ll_Saldo < 0 Then ll_Saldo = 0
	
	If ll_Saldo > 0 Then
		
		If ll_Saldo >= ll_Qtde_Pedida Then
			ll_Qtde_Inserir = ll_Qtde_Pedida
			ll_Qtde_Pedida = 0
		Else
			If al_Prioridade = al_prioridade_maxima Then
				ll_Qtde_Inserir = ll_Qtde_Pedida
				ll_Qtde_Pedida = 0
			Else
				ll_Qtde_Inserir 	= ll_Saldo
				ll_Qtde_Pedida  = ll_Qtde_Pedida - ll_Saldo
			End If
		End If
		
	Else
		If al_prioridade = al_prioridade_maxima Then
			ll_Qtde_Inserir = ll_Qtde_Pedida
			ll_Qtde_Pedida = 0
		End If
	End If
	
	If ll_Qtde_Inserir > 0 Then
		
		lb_Sucesso = False
		
		If This.of_Proximo_Volume(Ref ll_Volume, adc_litros, adc_peso_grama, ll_Qtde_Inserir ) Then
			If This.of_insere_lista_separacao_produto(	ll_Volume, al_produto, as_endereco, ll_Qtde_Inserir, adc_litros, 1, ll_Etiqueta_Caixa, False, adc_peso_grama) Then
				lb_Sucesso = True
			End If
		End If
		
		If Not lb_Sucesso Then Exit
	Else
		// Para garantir que o sistema continue o processo pois o produto pode estar em mais de um end
		lb_Sucesso = True
	End If
	
	al_qtde_pedida = al_qtde_pedida - ll_Qtde_Inserir
		
Next

Return lb_Sucesso

end function

public function boolean of_altualiza_picking_controlado (long al_filial, long al_pedido, ref string as_erro);Boolean lb_Atualiza = True


Update  pedido_distribuidora
Set   	   dh_picking_controlado = getdate()
Where  cd_filial  =:al_filial 
And 	  nr_pedido_distribuidora=:al_pedido   
Using SqlCA;

If SqlCa.SqlCode = -1 Then
	lb_Atualiza	 = False
	as_Erro = "Erro no update da tabela PEDIDO_DISTRIBUIDORA. Filial: "+String(al_Filial)+" Pedido: "+String(al_Pedido)+". " + SqlCa.SqlErrText
	Return lb_Atualiza
End If				
		
Return lb_Atualiza		


end function

public function boolean of_verifica_situacao_pedido (long al_tipo_volume, ref boolean ab_continua_geracao, boolean ab_controlado);String ls_MSG

Long ll_Qtde, ll_Picking

String ls_Situacao

ab_continua_geracao = True

// N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio validar porque o processo de gera$$HEX2$$e700e300$$ENDHEX$$o do picking do CONTROLADO $$HEX1$$e900$$ENDHEX$$ feito s$$HEX1$$f300$$ENDHEX$$ depois que $$HEX1$$e900$$ENDHEX$$ gerado o picking pelo processo normal pelo sistema RO
If ab_controlado Then Return True

//al_Tipo_Volume -> [1 = Flow] [2 = Pulm$$HEX1$$e300$$ENDHEX$$o]
Select count(*)
Into :ll_Picking
From wms_lista_separacao
Where cd_filial 							= :il_Filial
	and nr_pedido_distribuidora 	= :il_Pedido
	and cd_tipo_volume				= :al_Tipo_Volume
Using SqlCa;

If Sqlca.SqlCode = -1 Then
	ls_MSG = 	"Erro ao verificar se j$$HEX1$$e100$$ENDHEX$$ foi gerado picking do pedido '" + String(il_Pedido) + "' da filial '" + String(il_Filial) + "'. '" + SQLCA.SQLErrText + "'."
	SqlCa.of_RollBack()
	This.of_Grava_Log(ls_MSG, True)	
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_MSG, StopSign!)
	Return False
End If

If ll_Picking > 0 Then
	ls_MSG = "J$$HEX1$$e100$$ENDHEX$$ foi gerado picking do pedido '" + String(il_Pedido) + "' da filial '" + String(il_Filial) + "'. '"
	This.of_Grava_Log(ls_MSG, True)	
	ab_continua_geracao = False
	Return True
End If

Select id_situacao
Into :ls_Situacao
From pedido_distribuidora
where cd_filial 							=:il_Filial
	and nr_pedido_distribuidora 	= :il_Pedido
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_MSG = 	"Erro ao verificar a situa$$HEX2$$e700e300$$ENDHEX$$o do pedido '" + String(il_Pedido) + "' da filial '" + String(il_Filial) + "'. '" + SQLCA.SQLErrText + "'."
	SqlCa.of_RollBack()
	This.of_Grava_Log(ls_MSG, True)	
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_MSG, StopSign!)
	Return False
Else
	If (ls_Situacao <> 'C') Then //COLOCADO
		ls_MSG = 	"O pedido '" + String(il_Pedido) + "' da filial '" + String(il_Filial) + "' n$$HEX1$$e300$$ENDHEX$$o esta mais como COLOCADO. '"
		This.of_Grava_Log(ls_MSG, True)	
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_MSG, StopSign!)
		ab_continua_geracao = False
		Return False
	End If
End If

Return true
end function

public function boolean of_processa_geracao_picking (long al_filial, long al_pedido, boolean ab_pedido_almoxarifado, boolean ab_pedido_controlado, date adt_data_pedido);Boolean	lb_Continua_Geracao,&
			lb_Sucesso			

String		ls_Log,&
			ls_Etiqueta,&
			ls_Erro,&
			ls_Situacao, &
			ls_id_alterna_geracao_pedido, &
			ls_Erro_Email, &
			ls_Log_GA

Long	ll_Linha_Pedido,&
		ll_Linhas_Pedido,&
		ll_Linha_Esteira,&
		ll_Linhas_Esteira,&
		ll_Esteira,&
		lvl_row_grupo,&
		lvl_cont_grupo,&
		ll_recipiente,&
		ll_filial_aux = 0, &
		ll_linhas_grupo_atend, &
		ll_cd_grupo_atendimento
		
Integer	li_Esteira	

Date ldt_Hoje

try
	ls_Log = gvo_Aplicacao.ivs_Path_Arquivos + "Picking"
	
	If Not gf_Cria_Logs(ls_Log, 1, ref ii_Log) Then Return False
	
	This.of_grava_log("In$$HEX1$$ed00$$ENDHEX$$cio da Gera$$HEX2$$e700e300$$ENDHEX$$o do Picking.")
	
	ib_Controlado_Endereco_Lote  = gf_pad_picking_lote()
	
	// Se o par$$HEX1$$e200$$ENDHEX$$metro veio como TRUE verifica se o par$$HEX1$$e200$$ENDHEX$$metro j$$HEX1$$e100$$ENDHEX$$ foi alterado DH_INICIO_PADPICKING_LOTE.
	If ab_pedido_controlado Then
		// Assume o valor do par$$HEX1$$e200$$ENDHEX$$metro gf_pad_picking_lote()
		ab_pedido_controlado = ib_Controlado_Endereco_Lote
	End If
		
	idt_data_pedido = adt_data_pedido
	
	dc_uo_ds_base lds_Pedido 
	lds_Pedido = Create dc_uo_ds_base
	If Not lds_Pedido.of_ChangeDataObject("ds_ge259_lista_pedido_colocado") Then Return False
	
	dc_uo_ds_base lds_Esteira
	lds_Esteira = Create dc_uo_ds_base
	If Not lds_Esteira.of_ChangeDataObject("ds_ge259_esteira") Then	Return False

	dc_uo_ds_base lds_grupo_produto 
	lds_grupo_produto = Create dc_uo_ds_base
	If Not lds_grupo_produto.of_ChangeDataObject("ds_ge259_lista_grupo") Then Return False  
	
	ivds_grupo_atendimento_filial = Create dc_uo_ds_base
	If Not ivds_grupo_atendimento_filial.of_ChangeDataObject ('ds_ge259_grupo_atendimento_filial') Then Return False  
	
	ldt_Hoje = date(gf_getserverdate())
	ivds_grupo_atendimento_filial.retrieve(ldt_Hoje)
	//ivds_grupo_atendimento_filial.retrieve(idt_data_pedido)
	ll_linhas_grupo_atend =  ivds_grupo_atendimento_filial.rowcount()
		
	If Not This.of_parametro_geracao_cx_padrao() Then Return False
		
	If Not Isnull(al_filial) and Not Isnull(al_Pedido) Then
		lds_Pedido.of_AppendWhere("p.cd_filial = " + String(al_filial) + " and p.nr_pedido_distribuidora = " + String(al_Pedido))
	Else
		lds_Pedido.of_AppendWhere("(p.id_pedido_almoxarifado = 'N' or p.id_pedido_almoxarifado is null)")
	End If
	
	//ll_Linhas_Pedido = lds_Pedido.Retrieve()

	/// Valida: Controlados como Em Separa$$HEX2$$e700e300$$ENDHEX$$o  /   N$$HEX1$$e300$$ENDHEX$$o Controlados como Colocados
	// A gera$$HEX2$$e700e300$$ENDHEX$$o do picking de controlado foi retirado do processo normal, neste caso o pedido EM SEPARACAO para depois gerar o picking do controlado.
	// O picking de controlado $$HEX1$$e900$$ENDHEX$$ gerado pela GE563.
	If ab_pedido_controlado Then 
		ll_Linhas_Pedido = lds_Pedido.Retrieve('S')		
	Else
		ll_Linhas_Pedido = lds_Pedido.Retrieve('C')				
	End If 
		
	If ll_Linhas_Pedido > 0 Then
		
		If Not ab_pedido_controlado Then 
		
			//*********************************Gera picking de caixa fechada*********************************************
			Try
				Open(w_Aguarde_1)
				w_Aguarde_1.Title = "Gerando Picking do Pulm$$HEX1$$e300$$ENDHEX$$o ..."
				w_Aguarde_1.uo_Progress.of_SetMax(ll_Linhas_Pedido)
				
				For ll_Linha_Pedido = 1 to ll_Linhas_Pedido
					il_Filial 		= lds_Pedido.Object.cd_filial						[ll_Linha_Pedido]
					il_Pedido 	= lds_Pedido.Object.nr_pedido_distribuidora	[ll_Linha_Pedido]
					
					If ll_filial_aux = il_Filial Then
						ib_Prox_Filial = False
					Else
						ib_Prox_Filial = True
					End If
									
					w_Aguarde_1.Title = "Gerando Picking do Pulm$$HEX1$$e300$$ENDHEX$$o ... Filial "+String(il_Filial)
					w_Aguarde_1.uo_Progress.of_SetProgress(ll_Linha_Pedido)
					 
					// Se j$$HEX1$$e100$$ENDHEX$$ tiver sido gerado picking ou o pedido n$$HEX1$$e300$$ENDHEX$$o estiver como COLOCADO n$$HEX1$$e300$$ENDHEX$$o gera e passa para a pr$$HEX1$$f300$$ENDHEX$$xima loja
					If Not This.of_verifica_situacao_pedido(2, Ref lb_Continua_Geracao, ab_pedido_controlado) Then Return False
					
					If Not lb_Continua_Geracao Then Continue
					
					If ib_Prox_Filial Then
						lds_Esteira.Of_RestoreSqlOriginal()
												
						If ab_pedido_almoxarifado Then
							lds_Esteira.of_AppendWhere("we.cd_esteira = 5")
						Else
							lds_Esteira.of_AppendWhere("we.cd_esteira <> 5")
						End If
						
					End If
					
					ll_Linhas_Esteira = lds_Esteira.Retrieve(il_Filial)
					 
					If ll_Linhas_Esteira > 0 Then
						
						For ll_Linha_Esteira = 1 To ll_Linhas_Esteira
							ii_Esteira 		= lds_Esteira.Object.cd_esteira[ll_Linha_Esteira]
							ii_Recipiente	= lds_Esteira.Object.cd_recipiente[ll_Linha_Esteira]
							is_id_alterna_geracao_pedido = lds_Esteira.Object.id_alterna_geracao_pedido[ll_Linha_Esteira]
							
							If Not ab_pedido_controlado and Not ab_pedido_almoxarifado Then 
								If is_id_alterna_geracao_pedido = 'S' Then
									If Not This.of_verifica_produto_ped_urgente(il_Filial, ii_Esteira) Then
										If Not This.of_verifica_grupo_atendimento_filial( il_Filial, il_Pedido, ib_Prox_Filial, ii_Esteira, ll_linhas_grupo_atend, Ref ll_cd_grupo_atendimento ) Then 
											//Nao encontrou pedido urgente com produto da esteira e nem esta no grupo de atendimento do dia, Pula esteira
											ls_Log_GA = "FILIAL CONFIGURADA PARA N$$HEX1$$c300$$ENDHEX$$O GERAR PICKING DE CAIXA FECHADA; FILIAL: " + String(il_Filial) + "; PEDIDO: " + String(il_Pedido)  + "; ESTEIRA: " + string(ii_Esteira) + "; GRUPO: " + string(ll_cd_grupo_atendimento)
											If Not this.of_grava_log_grupo_atendimento(ls_Log_GA, Ref ls_Erro_Email) Then
												This.of_grava_log(ls_Erro_Email, True)
											End If
											Continue
										End if
									End If
								End If
							End If
														
							// Retirado parte Fixa Abaixo. Vem da wms_esteira_recipiente
							SetNull(idc_peso_caixa)
							idc_peso_caixa	= lds_Esteira.Object.vl_peso_cx[ll_Linha_Esteira]   
					
							is_Chave_LOG = "CAIXA FECHADA -> PEDIDO/FILIAL/ESTEIRA/RECIPIENTE (" + String(il_Pedido) + "/" + String(il_Filial) + "/" + String(ii_Esteira) + "/" + String(ii_Recipiente) + ")."
							
							lb_Sucesso = False
							
							If is_Gera_Picking_CX = 'S' Then
								If ii_Esteira = 5 Then //Almoxarifado
									If of_grava_volume_caixa_padrao_almox() Then
										lb_Sucesso	= True
									End If
								Else
									If of_grava_volume_caixa_padrao() Then
										lb_Sucesso	 =True
									End If
								End If
							End If			
							
							If Not lb_Sucesso Then
								SqlCa.of_RollBack()
								This.of_grava_log("Erro ao gerar o PICKING DE CAIXA FECHADA - ESTEIRA/RECIPIENTE/PEDIDO/FILIAL (" + String(ii_Esteira) + "/" + String(ii_Recipiente) + '/' + String(il_Pedido) + "/" + String(il_Filial) + ").", True)
								Return False
							End If
						Next
										
					ElseIf ll_Linhas_Esteira = 0 Then
						This.of_grava_log("N$$HEX1$$e300$$ENDHEX$$o existem esterias ATIVAS para a gera$$HEX2$$e700e300$$ENDHEX$$o do Picking de Caixa Fechada.", True)
						Return False				
					Else
						This.of_grava_log("Erro ao localizar as esteiras ATIVAS para a gera$$HEX2$$e700e300$$ENDHEX$$o do Picking de Caixa Fechada.", True)
						Return False
					End If
					
					If lb_Sucesso Then
						SqlCa.of_Commit()
					End If			
					
					ll_filial_aux = il_Filial
				Next
				
				If Not ab_pedido_almoxarifado Then
					If Not This.of_finaliza_geracao_cx_fechada(Ref ls_Erro) Then
						SqlCa.of_RollBack()
						This.of_grava_log(ls_Erro, True)
						Return False
					Else
						SqlCa.of_Commit()
					End If	
				End If
			Finally
				Close(w_Aguarde_1)
			End Try
			//***************************************************************************************************
			
		End If //If Not ab_pedido_controlado Then 
				
		
		//*****************************************Gera picking do flow rack****************************************
		ll_filial_aux = 0		
		For ll_Linha_Pedido = 1 to ll_Linhas_Pedido
			
			il_Filial 		= lds_Pedido.Object.cd_filial						[ll_Linha_Pedido]
			il_Pedido 	= lds_Pedido.Object.nr_pedido_distribuidora	[ll_Linha_Pedido]
			
			If ll_filial_aux = il_Filial Then
				ib_Prox_Filial = False
			Else
				ib_Prox_Filial = True
			End If

			If Not of_carrega_parametros_loja(il_Filial) Then Return False 
			 
			// Se j$$HEX1$$e100$$ENDHEX$$ tiver sido gerado picking ou o pedido n$$HEX1$$e300$$ENDHEX$$o estiver como COLOCADO n$$HEX1$$e300$$ENDHEX$$o gera e passa
			// para a pr$$HEX1$$f300$$ENDHEX$$xima loja
			If Not This.of_verifica_situacao_pedido(1, Ref lb_Continua_Geracao, ab_pedido_controlado) Then Return False
			
			If Not lb_Continua_Geracao Then Continue
			 
			// Alterar a situa$$HEX2$$e700e300$$ENDHEX$$o para EM SEPARACAO. 
			If Not This.of_altera_situacao_pedido(ab_pedido_controlado) Then Return False
			 
			// Alterar a situa$$HEX2$$e700e300$$ENDHEX$$o para EM SEPARACAO - PEDIDO EMPURRADO
			If Not This.of_altera_situacao_pedido_empurrado() Then Return False
			
			// Valida Se veio da Tela e Se parametro Controlado Lote Ativo
			If ab_pedido_controlado  Then 
				lds_Esteira.Of_RestoreSqlOriginal()
				
				lds_Esteira.of_AppendWhere("we.cd_esteira  = 3")	
			Else
				If ib_Prox_Filial Then
					lds_Esteira.Of_RestoreSqlOriginal()
											
					lds_Esteira.of_AppendWhere("we.cd_esteira <>  3")	
				End If
			End If 
			
			ll_Linhas_Esteira = lds_Esteira.Retrieve(il_Filial)

			If ll_Linhas_Esteira > 0 Then
				
				For ll_Linha_Esteira = 1 To ll_Linhas_Esteira
					ii_Esteira = lds_Esteira.Object.cd_esteira[ll_Linha_Esteira]
					ii_Recipiente = lds_Esteira.Object.cd_recipiente[ll_Linha_Esteira]
					is_id_alterna_geracao_pedido = lds_Esteira.Object.id_alterna_geracao_pedido[ll_Linha_Esteira]
							
					If not ab_pedido_controlado and Not ab_pedido_almoxarifado Then 
						If is_id_alterna_geracao_pedido = 'S' Then
							If Not This.of_verifica_produto_ped_urgente(il_Filial, ii_Esteira) Then
								If Not This.of_verifica_grupo_atendimento_filial( il_Filial, il_Pedido, ib_Prox_Filial, ii_Esteira, ll_linhas_grupo_atend, Ref ll_cd_grupo_atendimento ) Then 
									//Nao encontrou pedido urgente com produto da esteira e nem esta no grupo de atendimento do dia, Pula esteira
									ls_Log_GA = "FILIAL CONFIGURADA PARA N$$HEX1$$c300$$ENDHEX$$O GERAR PICKING; FILIAL: " + String(il_Filial) + "; PEDIDO: " + String(il_Pedido)  + "; ESTEIRA: " + string(ii_Esteira) + "; GRUPO: " + string(ll_cd_grupo_atendimento)
									If Not this.of_grava_log_grupo_atendimento(ls_Log_GA, Ref ls_Erro_Email) Then
										This.of_grava_log(ls_Erro_Email, True)
									End If
									Continue
								End if
							End If
						End If
					End If
					
					is_Chave_LOG = "PEDIDO/FILIAL/ESTEIRA/RECIPIENTE (" + String(il_Pedido) + "/" + String(il_Filial) + "/" + String(ii_Esteira) + "/" + String(ii_Recipiente) + ")."
					lb_Sucesso = False
					
					SetNull(ii_grupo_picking)
					
					If ii_Esteira = 3 Then 
						ii_Esteira = 3 
					End if 
					
					// Retirado parte Fixa Abaixo. Vem da wms_esteira_recipiente
					setnull(idc_peso_caixa)
					idc_peso_caixa	= lds_Esteira.Object.vl_peso_cx[ll_Linha_Esteira]   

					If This.of_gera_picking() Then
						If This.of_valida_quantidade_pedido() Then 
							lb_Sucesso = True
						End If
					End If
																				
					If Not lb_Sucesso Then
						SqlCa.of_RollBack()
						This.of_grava_log("Erro ao gerar o PICKING - ESTEIRA/RECIPIENTE/PEDIDO/FILIAL (" + String(ii_Esteira) + "/" + String(ii_Recipiente) + '/' + String(il_Pedido) + "/" + String(il_Filial) + ").", True)
						Return False
					End If
					
					/// Processo para Grupo Picking Na Lista de Separa$$HEX2$$e700e300$$ENDHEX$$o
					If ib_Filial_Wms_Grupo_Picking Then 
						lvl_row_grupo = lds_grupo_produto.Retrieve(il_Filial,il_Pedido,ii_Esteira)
						For lvl_cont_grupo = 1 To lvl_row_grupo
							ii_grupo_picking = lds_grupo_produto.Object.cd_grupo_pick[lvl_cont_grupo]
							
							If This.of_gera_picking() Then
								If This.of_valida_quantidade_pedido() Then 
									lb_Sucesso = True
								End If
							End If
																		
							If Not lb_Sucesso Then
								SqlCa.of_RollBack()
								This.of_grava_log("Erro ao gerar o GRUPO PICKING - ESTEIRA/RECIPIENTE/PEDIDO/FILIAL (" + String(ii_Esteira) + "/" + String(ii_Recipiente) + '/' + String(il_Pedido) + "/" + String(il_Filial) + ").", True)
								Return False
							End If
						Next
					End If 
				Next
								
			ElseIf ll_Linhas_Esteira = 0 Then
				This.of_grava_log("N$$HEX1$$e300$$ENDHEX$$o existem esterias ATIVAS para a gera$$HEX2$$e700e300$$ENDHEX$$o do Picking.", True)
				Return False				
			Else
				This.of_grava_log("Erro ao localizar as esteiras ATIVAS.", True)
				Return False
			End If
			 
			If lb_Sucesso Then
				If Not This.of_Update_Pedido_Empurrado(il_Filial, il_Pedido, Ref ls_Erro) Then
					lb_Sucesso = False
					SqlCa.of_RollBack()
					This.of_grava_log(ls_Erro, True)
					Return False
				End If
				
				// Atualiza Pedido_Distribuidora Campo DH_PICKING_CONTROLADO
				If ab_pedido_controlado and ib_Controlado_Endereco_Lote Then 
					If Not This.of_altualiza_picking_controlado(il_Filial, il_Pedido, Ref ls_Erro) Then
						lb_Sucesso = False
						SqlCa.of_RollBack()
						This.of_grava_log(ls_Erro, True)
						Return False
					End If
				End If 
				
				SqlCa.of_Commit()
				
				//Percorre todas esteiras novamente para ratear os volumes estourados
				For ll_Linha_Esteira = 1 To ll_Linhas_Esteira
					ll_Esteira = lds_Esteira.Object.cd_esteira[ll_Linha_Esteira]
					ll_recipiente = lds_Esteira.Object.cd_recipiente[ll_Linha_Esteira]
					ls_id_alterna_geracao_pedido = lds_Esteira.Object.id_alterna_geracao_pedido[ll_Linha_Esteira]
					
					//Atentar que a variavel que usa $$HEX1$$e900$$ENDHEX$$ a local em vez da de instancia ****
					If not ab_pedido_controlado and Not ab_pedido_almoxarifado Then 
						If ls_id_alterna_geracao_pedido = 'S' Then
							If Not This.of_verifica_produto_ped_urgente(il_Filial, ll_Esteira) Then
								If Not This.of_verifica_grupo_atendimento_filial( il_Filial, il_Pedido, False, ll_Esteira, ll_linhas_grupo_atend, Ref ll_cd_grupo_atendimento ) Then 
									//Nao encontrou pedido urgente com produto da esteira e nem esta no grupo de atendimento do dia, Pula esteira
									ls_Log_GA = "FILIAL CONFIGURADA PARA N$$HEX1$$c300$$ENDHEX$$O GERAR PICKING ESTOURO; FILIAL: " + String(il_Filial) + "; PEDIDO: " + String(il_Pedido)  + "; ESTEIRA: " + string(ll_Esteira) + "; GRUPO: " + string(ll_cd_grupo_atendimento)
									If Not this.of_grava_log_grupo_atendimento(ls_Log_GA, Ref ls_Erro_Email) Then
										This.of_grava_log(ls_Erro_Email, True)
									End If
									Continue
								End if
							End If
						End If
					End If
					
					setnull(idc_peso_caixa)
					idc_peso_caixa	= lds_Esteira.Object.vl_peso_cx[ll_Linha_Esteira]  
					idc_capacidade_caixa = lds_Esteira.Object.vl_capacidade_cx[ll_Linha_Esteira]  
										
					If This.of_Rateio_Volume_Estourado(il_Filial, il_Pedido, ll_Esteira) Then
						SqlCa.of_Commit()
					End If
				Next
			End If	
			ll_filial_aux = il_Filial
		Next
		//***************************************************************************************************
				
	ElseIf ll_Linhas_Pedido = 0 Then
		If Not Isnull(al_filial) and Not Isnull(al_Pedido) Then
			This.of_grava_log("N$$HEX1$$e300$$ENDHEX$$o existem pedidos COLOCADOS para a gera$$HEX2$$e700e300$$ENDHEX$$o do Picking. Filial ("+String(al_filial)+"), pedido ("+String(al_Pedido)+").", True)
		Else
			This.of_grava_log("N$$HEX1$$e300$$ENDHEX$$o existem pedidos COLOCADOS para a gera$$HEX2$$e700e300$$ENDHEX$$o do Picking.", True)
		End If
	Else
		This.of_grava_log("Erro ao localizar os Pedidos COLOCADOS.", True)
		Return False
	End If
		
Finally
	This.of_grava_log("T$$HEX1$$e900$$ENDHEX$$rmino da Gera$$HEX2$$e700e300$$ENDHEX$$o do Picking.")
	FileClose(ii_Log)
	If IsValid(lds_Pedido) Then Destroy(lds_Pedido)
	If IsValid(lds_Esteira) Then Destroy(lds_Esteira)
	If IsValid(ivds_grupo_atendimento_filial) Then Destroy(ivds_grupo_atendimento_filial)
End Try

Return True
end function

private function boolean of_gera_lista_separacao_produto (long al_filial, long al_pedido, long al_produto, long al_prioridade_maxima, decimal adc_peso_grama);Boolean lb_Sucesso = True


Long ll_Linhas, ll_Linha, ll_Produto, ll_Qtde_Pedida, ll_Qtde_Pick, ll_Prioridade, ll_Qtde, ll_Produto_Anterior

Long ll_Achou

Decimal ldc_Litros, ldc_Capacidade_Litro, ldc_Capacidade_Eco

String ls_Endereco

dc_uo_ds_base lds
lds = Create dc_uo_ds_base

If Not lds.of_ChangeDataObject("ds_ge259_endereco_produto") Then
	Destroy(lds)
	Return False
End If 

ll_Linhas = lds.Retrieve(al_Filial, al_Pedido, al_Produto)

If ll_Linhas > 0 Then
	
	For ll_Linha  = 1 To ll_Linhas
		
		ll_Produto 				= lds.Object.cd_produto									[ll_Linha]
		ls_Endereco				= lds.Object.cd_endereco								[ll_Linha]
		ll_Qtde_Pedida			= lds.Object.qt_pedida									[ll_Linha]
		ll_Qtde_Pick 			= lds.Object.qt_lista_separacao						[ll_Linha]
		ll_Prioridade				= lds.Object.nr_prioridade								[ll_Linha]
		ldc_Capacidade_Litro	= lds.Object.qt_capacidade_litro						[ll_Linha] 	
		ldc_Capacidade_Eco	= lds.Object.qt_capacidade_litro_ecommerce		[ll_Linha] 	
		
		If ldc_Capacidade_Litro = 0 Then ldc_Capacidade_Litro = ldc_Capacidade_Eco
		
		If ll_Produto <> ll_Produto_Anterior Then
			ll_Qtde 						= ll_Qtde_Pedida - ll_Qtde_Pick
			ll_Produto_Anterior 	= ll_Produto
		End If
		
		If ll_Qtde > 0 Then
			If This.of_gera_lista_separacao(	ll_Produto, ls_Endereco, ll_Prioridade,&
															ref ll_Qtde, ldc_Capacidade_Litro, al_prioridade_maxima, adc_peso_grama) Then
				If ll_Qtde = 0 Then
					Exit
				End If
			Else
				lb_Sucesso = False
				Exit
			End If
		End If
									
	Next
	
End If

Destroy(lds)

Return lb_Sucesso
end function

public function boolean of_altera_situacao_pedido (boolean ab_pedido_controlado);String ls_MSG
String ls_Situacao

If ab_pedido_controlado Then
		
	Select id_situacao
	Into :ls_Situacao
	From pedido_distribuidora
	where cd_filial 							= :il_Filial
		and nr_pedido_distribuidora 	= :il_Pedido
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		ls_MSG = 	"Erro ao verificar a situa$$HEX2$$e700e300$$ENDHEX$$o do pedido '" + String(il_Pedido) + "' da filial '" + String(il_Filial) + "' - [PEDIDO CONTROLADO]. '" + SQLCA.SQLErrText + "'."
		SqlCa.of_RollBack()
		This.of_Grava_Log(ls_MSG, True)	
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_MSG, StopSign!)
		Return False
	Else
		If (ls_Situacao <> 'S') Then //SEM SEPARACAO
			ls_MSG = 	"O pedido '" + String(il_Pedido) + "' da filial '" + String(il_Filial) + "' n$$HEX1$$e300$$ENDHEX$$o esta EM SEPARA$$HEX2$$c700c300$$ENDHEX$$O - [PEDIDO CONTROLADO] . "
			This.of_Grava_Log(ls_MSG, True)	
			Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_MSG, StopSign!)
			Return False
		End If
	End If
		
Else
	Update pedido_distribuidora
	Set id_situacao = 'S'
	Where cd_filial							=	:il_Filial
		and nr_pedido_distribuidora 	=	:il_Pedido
	Using SqlCa;
	
	If Sqlca.SqlCode = -1 Then
		ls_MSG = 	"Erro ao alterar a situa$$HEX2$$e700e300$$ENDHEX$$o 'EM SEPARACAO' do pedido '" + String(il_Pedido) + "' da filial '" + String(il_Filial) + "'. '" + SQLCA.SQLErrText + "'."
		SqlCa.of_RollBack()
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_MSG, StopSign!)
		Return False
	End If
End If

Return True
end function

public function boolean of_localiza_endereco_cd (ref string as_cep, ref string as_endereco, ref string as_erro);Boolean	lb_Sucesso = False

SELECT
		vl_parametro,
		de_parametro
  INTO
  		:as_cep,
		:as_endereco
  FROM wms_parametro
WHERE cd_parametro = 'CD_ENDERECO_CD_PATROMONIO'
USING sqlca;

Choose case sqlca.SQLCode
	case 0
		lb_Sucesso = True
	case 100
		as_erro = 'Endere$$HEX1$$e700$$ENDHEX$$o do CD n$$HEX1$$e300$$ENDHEX$$o localizado na leitura do par$$HEX1$$e200$$ENDHEX$$metro CD_ENDERECO_CD_PATROMONIO'
	case else
		as_erro = 'Erro ao buscar o endere$$HEX1$$e700$$ENDHEX$$o do CD no par$$HEX1$$e200$$ENDHEX$$metro CD_ENDERECO_CD_PATROMONIO. SQLCA.SQLErrText = ' + SQLCA.SQLErrText
End choose

Return lb_Sucesso
end function

public function boolean of_obtem_centro_custo_cd (ref string as_centro_custo_cd, ref string as_erro);Boolean	lb_Sucesso = False

SELECT
		vl_parametro
  INTO
  		:as_centro_custo_cd
  FROM wms_parametro
WHERE cd_parametro = 'CD_CENTRO_CUSTO_PATRIMONIO'
USING sqlca;

Choose case sqlca.SQLCode
	case 0
		lb_Sucesso = True
	case 100
		as_erro = 'Centro de custo do CD n$$HEX1$$e300$$ENDHEX$$o localizado na leitura do par$$HEX1$$e200$$ENDHEX$$metro CD_CENTRO_CUSTO_PATRIMONIO'
	case else
		as_erro = 'Erro ao buscar o centro de custo do CD no par$$HEX1$$e200$$ENDHEX$$metro CD_CENTRO_CUSTO_PATRIMONIO. SQLCA.SQLErrText = ' + SQLCA.SQLErrText
End choose

Return lb_Sucesso
end function

public function boolean of_departamento_pedido (long al_filial, long al_pedido_distribuidora, ref string as_centro_custo, ref boolean ab_centro_custo, ref string as_endereco, ref string as_cep, ref string as_cidade, ref string as_unidade_federacao, ref long al_rota, ref long al_filial_entrega, ref boolean ab_centro_entrega, ref long al_nr_prioridade, ref long al_centro_custo_entrega, ref string as_requisitante);Long ll_Pedido_Almoxarifado

String ls_Centro_Custo, &
			ls_Centro_Custo_CD, &
			ls_msg
			
select top 1 nr_pedido_almoxarifado 
Into :ll_Pedido_Almoxarifado
from pedido_distribuidora_almox 
where cd_filial = :al_Filial 
and nr_pedido_distribuidora = :al_Pedido_Distribuidora
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		//Verifica se tem centro de custo no pedido
		select b.de_centro_custo
		Into	:as_Centro_Custo
		from pedido_almoxarifado 		a
		inner join centro_custo			b on b.cd_centro_custo			= a.cd_centro_custo
		where a.cd_filial = :al_Filial 
		and a.nr_pedido = :ll_Pedido_Almoxarifado
		and a.cd_centro_custo is not null
		Using SqlCa;
		
		Choose Case SqlCa.SqlCode
			Case 0
				ab_Centro_Custo = True
			Case 100
				ab_Centro_Custo = False
			Case -1
				Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o centro de custo: " +SQLCA.SQLErrText + "'.", StopSign!)
				Return False
		End Choose
		
		//Dados do centro de custo de entrega
		select b.de_centro_custo,
		case when c.cd_filial = 534 then
				  d.de_endereco + '  ' + d.de_bairro
			 else
				  c.de_endereco + '  ' + c.de_bairro
		end as de_endereco,
		case when c.cd_filial = 534 then
				  d.nr_cep
			 else
				  c.nr_cep
		end as nr_cep,
		e.nm_cidade,
		f.nm_unidade_federacao,
//		case when c.cd_filial = 534 then
//				  d.nr_rota_entrega
//			 else
				  c.nr_rota_entrega,
//		end as nr_rota_entrega,
		case when b.cd_filial = 534 and b.cd_centro_custo = 100896 Then
				534
			WHEN b.cd_filial = b.cd_centro_custo THEN 
				b.cd_filial
			Else
				a.cd_filial
		end  as cd_filial,
		c.nr_ordem_bacia,
		a.cd_centro_custo_entrega,
		u.nm_usuario
		Into	:as_Centro_Custo,
				:as_Endereco,
				:as_Cep,
				:as_Cidade,
				:as_Unidade_Federacao,
				:al_Rota,
				:al_Filial_Entrega,
				:al_nr_prioridade,
				:al_centro_custo_entrega,
				:as_requisitante
		from pedido_almoxarifado 		a
		inner join centro_custo 			b on b.cd_centro_custo 			= a.cd_centro_custo_entrega
		inner join filial						c on c.cd_filial						= b.cd_filial
		inner join filial						d on d.cd_filial						= 2
		inner join cidade					e on e.cd_cidade					= c.cd_cidade
		inner join unidade_federacao 	f on f.cd_unidade_federacao	= e.cd_unidade_federacao
		left    join usuario 					u on u.nr_matricula				= a.nr_matricula_requisitante
		where a.cd_filial = :al_Filial 
		and a.nr_pedido = :ll_Pedido_Almoxarifado
		and a.cd_centro_custo_entrega is not null
		//and coalesce(a.cd_centro_custo, 0) <> coalesce(a.cd_centro_custo_entrega, 0)
		Using SqlCa;
		
		Choose Case SqlCa.SqlCode
			Case 0
				ab_Centro_Entrega = True
			Case 100
				ab_Centro_Entrega = False
			Case -1
				Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o dados do centro de custo de entrega: " +SQLCA.SQLErrText + "'.", StopSign!)
				Return False
		End Choose
		
		If ab_Centro_Entrega then
			//Obt$$HEX1$$e900$$ENDHEX$$m centro de custo parametrizado do CD
			
			If not of_obtem_centro_custo_cd (ls_Centro_Custo_CD, ls_msg) then
				MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_msg, Exclamation!)
				Return False
			else
				If al_centro_custo_entrega = Long (ls_Centro_Custo_CD) then
					If not of_localiza_endereco_cd (as_Cep, as_Endereco, ls_msg) then
						MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_msg, Exclamation!)
						Return False
					End if
				End if
			End if
		End if
	Case -1
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o pedido almoxarifado: " +SQLCA.SQLErrText + "'.", StopSign!)
		Return False
End Choose

Return True
end function

public function boolean of_verifica_nome_requisitante (long al_filial, long al_pedido, ref string as_nome_requisitante);String ls_Usuario, ls_Matricula, ls_Erro

//Top 1 definido conforme orienta$$HEX2$$e700e300$$ENDHEX$$o do Sergio em reuni$$HEX1$$e300$$ENDHEX$$o sobre mais de um requisitante em um pedido distribuidora
SELECT Top 1
    pa.nr_matricula_requisitante,
    u.nm_usuario
INTO  :ls_Matricula, :ls_Usuario
FROM
    pedido_almoxarifado pa
    INNER JOIN usuario                    u 
    	ON u.nr_matricula = pa.nr_matricula_requisitante
    INNER JOIN pedido_distribuidora_almox pda 
    	ON pda.nr_pedido_almoxarifado = pa.nr_pedido
		AND pda.cd_filial = pa.cd_filial
WHERE 
	pa.cd_filial = :al_filial
    AND pda.nr_pedido_almoxarifado IN (
	        SELECT nr_pedido_almoxarifado
	        FROM pedido_distribuidora_almox
	        WHERE cd_filial = :al_filial
	            AND nr_pedido_distribuidora = :al_pedido)
Using SqlCa;

as_nome_requisitante = 'Req.:'+ Left(ls_Usuario, 18)

If Sqlca.SqlCode = -1 Then
	ls_Erro = 	"Erro ao verificar requisitante do pedido '" + String(il_Pedido) + "' da filial '" + String(il_Filial) + "'. '" + SQLCA.SQLErrText + "'."
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Erro, StopSign!)
	Return False
End If

Return true
end function

public function boolean of_localiza_capacidade_caixa (long al_esteira, long al_recipiente, ref decimal adc_capacidade, ref string as_erro);// Capacidade total da bacia: 34 x 52 x 29= 51,72 litros   :   ESTAVA FIXO NO FONTE : PASSADO PARA WMS_ESTEIRA
//If ii_Esteira = 2 Then //Medicamentos
//	idc_capacidade_caixa = 30
//ElseIf ii_esteira = 5 Then //Almoxarifado
//	idc_capacidade_caixa = 46
//ElseIf ii_Esteira  = 4 Then //Geladeira -> Utiliza a capacidade da caixinha de isopor.
//	idc_capacidade_caixa = 1.5
//ElseIf ii_Esteira  = 6 Then //Vacinas -> Utiliza a capacidade da caixinha de isopor.
//	idc_capacidade_caixa = 1.5
//Else
//	idc_capacidade_caixa = 34
//End If

Select vl_capacidade_cx       
Into :adc_capacidade
From   wms_esteira_recipiente
Where  id_situacao = 'A'
And    cd_esteira =:al_esteira
And    cd_recipiente =:al_recipiente
Using SqlCA;

If Sqlca.Sqlcode = - 1 Then
	as_erro = "Erro na Localizacao Informa$$HEX2$$e700e300$$ENDHEX$$o Bacia"	
	Return False
Else
	If adc_capacidade<0 Then 
		as_erro = "Erro Na Informa$$HEX2$$e700e300$$ENDHEX$$o Com Valor Inv$$HEX1$$e100$$ENDHEX$$lido"
		Return False
	End If 
End If 
		
Return True
end function

public function boolean of_esteira_imprime_picking_etiqueta (long al_esteira);String lvs_imprime_picking_etiqueta
String lvs_msg
Boolean lb_Retorno = False

Select coalesce(id_conferencia_bip_etiqueta, 'N') 
Into :lvs_imprime_picking_etiqueta
From wms_esteira
Where cd_esteira=:al_esteira
Using SqlCA;

Choose Case SqlCa.SqlCode
	Case 0
		If lvs_imprime_picking_etiqueta = 'S' Then 
			lb_Retorno = True 
		Else
			lb_Retorno = False
		End If 
	Case -1
		lvs_msg = "Arro ao verificar configuracao da esteira.~rErro:"+ SqlCa.SqlErrText
		SqlCa.of_RollBack()
		Return False
End Choose

Return lb_Retorno 











	
	
end function

public function boolean of_verifica_produto_ped_urgente (long al_filial, long al_esteira);Long 		ll_linha, ll_linhas, ll_produto, ll_Esteira, ll_Achou
String 	ls_Erro_Email, ls_MSG 
Boolean 	lb_Achou = False
Date ldt_Hoje

Try
	ldt_Hoje = date(gf_getserverdate())
	
	SELECT COUNT(*)
	INTO :ll_Achou
	FROM pedido_filial pf (index idx_data_filial)
		 INNER JOIN pedido_filial_produto pfp 
			ON pfp.cd_filial = pf.cd_filial 
			AND pfp.nr_pedido_filial = pf.nr_pedido_filial 
	WHERE pf.cd_filial = :al_Filial 
	  AND pf.dh_emissao >= :ldt_Hoje
	  and pf.id_gerado_logistica = 'S'
	  AND pfp.nr_pedido_distribuidora IS NOT NULL
	  and exists (select * from dbo.pedido_filial_prd_empurrado pfpe
					  inner join wms_endereco_produto wep on wep.cd_produto = pfpe.cd_produto 
					  where pfpe.cd_filial = pfp.cd_filial 
						 and pfpe.nr_pedido_filial = pfp.nr_pedido_filial
						 and pfpe.cd_produto = pfp.cd_produto 
						 and wep.cd_esteira = :al_esteira)
	Using sqlca;
	
	
					 
	If SqlCa.SqlCode = -1 Then
		If Not this.of_grava_log_grupo_atendimento('ERRO NA CONSULTA NA of_verifica_produto_ped_urgente; FILIAL: '+ string(al_filial) + '; PEDIDO: '+string(il_Pedido) + '; ESTEIRA: ' + string(al_esteira) + '; GRUPO: 0; ERRO: ' + SQLCa.SQLErrText, Ref ls_Erro_Email) Then
			This.of_grava_log(ls_Erro_Email, True)
		End If
	End If
	
	If ll_Achou > 0 Then
		lb_Achou = True
		If Not this.of_grava_log_grupo_atendimento('PRODUTO DA ESTEIRA EM PEDIDO URGENTE, SER$$HEX1$$c100$$ENDHEX$$ CONSIDERADO NO PEDIDO DE HOJE; FILIAL: ' + string(al_filial) + '; PEDIDO: ' + string(il_Pedido) + '; ESTEIRA: ' + string(al_esteira) + '; GRUPO: 0'  , Ref ls_Erro_Email) Then
			This.of_grava_log(ls_Erro_Email, True)
		End If		
		
	Else
		Return False
		
	End If
	
Catch (RunTimeError RTE)
	This.of_grava_log("Erro na fun$$HEX2$$e700e300$$ENDHEX$$o of_verifica_produto_ped_urgente - FILIAL: " + String(il_Filial) + "; PEDIDO " + String(il_Pedido) + "; ESTEIRA: " + String(ii_Esteira) + 'r~r' + rte.GetMessage(), True)
	
End Try

Return lb_Achou
end function

public function boolean of_grava_log_grupo_atendimento (string as_messagem, ref string as_erro);This.of_grava_log(as_messagem)

Insert into  wms_grupo_atendimento_log (dh_log_execucao, de_log_execucao)
												Values ( getdate(), :as_messagem )
Using sqlca;

If SqlCa.SqlCode = -1 Then
	as_erro = "Problema no Insert into wms_grupo_atendimento_log - FILIAL: "+ String(il_Filial) +"; ESTEIRA: "+ String(ii_Esteira) + "; PEDIDO: " + String(il_Pedido) + "."
	Return False
End If

Return True		


end function

public function boolean of_verifica_grupo_atendimento_filial (long al_filial, long al_pedido, boolean ab_prox_filial, integer ai_esteira, long al_linhas, ref long al_grupo_atendimento);long ll_Find = 0, ll_Cd_Grupo_Atendimento, ll_Achou
String ls_Erro, ls_Erro_Email


Try
	ll_Find = ivds_grupo_atendimento_filial.Find(" cd_filial = " + string(al_Filial) + " and cd_esteira = " + string (ai_Esteira), 1, al_Linhas)
	
	If ll_Find > 0 Then
		ll_Cd_Grupo_Atendimento = ivds_grupo_atendimento_filial.object.cd_grupo_atendimento[ll_find]
		
		If ab_Prox_Filial Then
			If this.of_atualiza_grupo_atendimento(ll_Cd_Grupo_Atendimento, ai_Esteira, Ref ls_Erro ) Then
				If Not this.of_grava_log_grupo_atendimento('CONFIGURADO PARA GERAR; FILIAL: '+ string(al_filial) + '; PEDIDO: '+string(al_pedido) + '; ESTEIRA: ' + string(ai_esteira) + '; GRUPO: ' + string(ll_cd_grupo_atendimento) , Ref ls_Erro_Email) Then
					This.of_grava_log(ls_Erro_Email, True)
				End If
			Else
				If Not this.of_grava_log_grupo_atendimento('ALGUM ERRO OCORREU NO ATUALIZAR GRUPO; FILIAL: '+ string(al_filial) + '; PEDIDO: '+string(al_pedido) + '; ESTEIRA: ' + string(ai_esteira) + '; GRUPO: ' + string(ll_cd_grupo_atendimento) + '. ERRO: '+ ls_Erro, Ref ls_Erro_Email) Then
					This.of_grava_log(ls_Erro_Email, True)
				End If
			End If
		Else
			If Not this.of_grava_log_grupo_atendimento('CONFIGURADO PARA GERAR; FILIAL: '+ string(al_filial) + '; PEDIDO: '+string(al_pedido) + '; ESTEIRA: ' + string(ai_esteira) + '; GRUPO: ' + string(ll_cd_grupo_atendimento) , Ref ls_Erro_Email) Then
				This.of_grava_log(ls_Erro_Email, True)
			End If
		End If
				
		al_Grupo_Atendimento = ll_Cd_Grupo_Atendimento
		
		//Prossegue com o processo de gera$$HEX2$$e700e300$$ENDHEX$$o normal
		Return True
	
	Else 
		al_Grupo_Atendimento = 0
		
		//Se nao encontrou no grupo do dia, verifica se existe em outros grupos, se nao exitir permite gerar o picking normalmente (caso levantado por causa de filiais novas)
		SELECT COUNT(*)
		INTO :ll_Achou
		FROM wms_grupo_atendimento_filial wgaf
		INNER JOIN wms_grupo_atendimento wga ON wga.cd_grupo_atendimento = wgaf.cd_grupo_atendimento
		WHERE wgaf.cd_filial = :al_filial
					AND wga.id_situacao = 'A'
		Using sqlca;
		
		If SqlCa.SqlCode = -1 Then
			If Not this.of_grava_log_grupo_atendimento('ERRO NA CONSULTA SE A FILIAL ESTA EM ALGUM GRUPO; FILIAL: '+ string(al_filial) + '; PEDIDO: '+string(al_pedido) + '; ESTEIRA: ' + string(ai_esteira) + '; GRUPO: ' + string(ll_cd_grupo_atendimento) + ' ERRO: ' + SQLCa.SQLErrText, Ref ls_Erro_Email) Then
				This.of_grava_log(ls_Erro_Email, True)
			End If
		End If
		
		If ll_Achou = 0 Then
			If Not this.of_grava_log_grupo_atendimento('FILIAL N$$HEX1$$c300$$ENDHEX$$O VINCULADA A NENHUM GRUPO, SER$$HEX1$$c100$$ENDHEX$$ CONSIDERADA NO PEDIDO DE HOJE; FILIAL: '+ string(al_filial) + '; PEDIDO: '+string(al_pedido) + '; ESTEIRA: ' + string(ai_esteira) + '; GRUPO: ' + string(ll_cd_grupo_atendimento) , Ref ls_Erro_Email) Then
				This.of_grava_log(ls_Erro_Email, True)
			End If
			//Vai permitir gerar o picking para esses casos, pode ter filiais novas etc
			Return True
		End If
		
		//Pula esteira
		Return False
	End if
Catch (RunTimeError rte)
	This.of_grava_log(rte.GetMessage(), True)
	Return False
End Try

end function

public function boolean of_atualiza_grupo_atendimento (long al_cd_grupo_atendimento, integer ai_esteira, ref string as_erro);Date ldt_Prox_Exec, ldt_Ultima_Atualizacao
Boolean lb_Feriado
Long ll_Check = 0
String ls_Erro_Email

SELECT dt_ult_atualizacao_grupo_atend
INTO :ldt_Ultima_Atualizacao 
FROM wms_esteira
WHERE id_situacao ='A' 
		and cd_esteira = :ai_esteira
		and id_alterna_geracao_pedido = 'S'
Using sqlca;

If SqlCa.SqlCode = -1 Then
	as_erro =  "Erro na consulta para obter a ultima data de atualiza$$HEX2$$e700e300$$ENDHEX$$o do grupo na tabela wms_esteira. Grupo Atendimento: "+String(al_cd_grupo_atendimento)+"; Esteira: " + string(ai_esteira) + ". " + SqlCa.SqlErrText
	Return False
End If

If IsNull(ldt_Ultima_Atualizacao) Or (ldt_Ultima_Atualizacao < date(gf_getserverdate())) Then
	
	SELECT DATEADD(day, 1, max(dt_prev_proxima_execucao) )
	INTO :ldt_Prox_Exec 
	FROM wms_grupo_atendimento 
	WHERE id_situacao ='A' 
			and cd_esteira = :ai_esteira
	Using sqlca;
	
	If SqlCa.SqlCode = -1 Then
		as_erro =  "Erro na consulta para obter data maxima de execu$$HEX2$$e700e300$$ENDHEX$$o. Grupo Atendimento: "+String(al_cd_grupo_atendimento)+"; Esteira: " + string(ai_esteira) + ". " + SqlCa.SqlErrText
		Return False
	End If
	
	If IsNull(ldt_Prox_Exec) or ldt_Prox_Exec < date(gf_getserverdate()) Then
		ldt_Prox_Exec = RelativeDate(date(gf_getserverdate()), 1) 
	End If
	
	Do While ll_Check < 7
		If DayNumber(ldt_Prox_Exec) = 7 Then
			ldt_Prox_Exec = RelativeDate(ldt_Prox_Exec, 2)
		ElseIf DayNumber(ldt_Prox_Exec) = 1 Then
			ldt_Prox_Exec = RelativeDate(ldt_Prox_Exec, 1)
		End If
		
		If gf_verifica_feriado('M', 1, ldt_Prox_Exec, Ref lb_Feriado) Then
			If lb_Feriado Then	
				ldt_Prox_Exec = RelativeDate(ldt_Prox_Exec, 1)
			End If
		Else
			as_erro = "Erro na fun$$HEX2$$e700e300$$ENDHEX$$o de verifica$$HEX2$$e700e300$$ENDHEX$$o de feriado."
			Return False
		End If
		
		ll_Check++
	Loop
	
	UPDATE wms_grupo_atendimento 
	SET dt_prev_proxima_execucao = :ldt_Prox_Exec,
			dt_ultima_execucao = getdate()
	WHERE cd_grupo_atendimento = :al_cd_grupo_atendimento
				AND cd_esteira = :ai_esteira
	Using sqlca;
	
	If SqlCa.SqlCode = -1 Then
		as_erro = "Erro no update da tabela wms_grupo_atendimento. Grupo Atendimento: "+String(al_cd_grupo_atendimento)+" Esteira: " + string(ai_esteira) + ". " + SqlCa.SqlErrText
		Return False
	End If		
	
	UPDATE wms_esteira 
	SET dt_ult_atualizacao_grupo_atend = getdate()
	WHERE id_situacao ='A' 
		and cd_esteira = :ai_esteira
	Using sqlca;
	
	If SqlCa.SqlCode = -1 Then
		as_erro = "Erro no update da tabela wms_esteira. Grupo Atendimento: "+String(al_cd_grupo_atendimento)+" Esteira: " + string(ai_esteira) + ". " + SqlCa.SqlErrText
		Return False
	End If		
		
	If Not this.of_grava_log_grupo_atendimento('PROXIMA DATA DO GRUPO ATENDIMENTO: ' + string(al_cd_grupo_atendimento) + '; ATUALIZADA PARA: ' + string(ldt_Prox_Exec, 'DD/MM/YYYY') + '; ESTEIRA: ' + string(ai_esteira) + '; GRUPO: ' + string(al_cd_grupo_atendimento)  , Ref ls_Erro_Email) Then
		This.of_grava_log(ls_Erro_Email, True)
	End If
	
End If

Return True

end function

public function boolean of_carrega_parametro_filial (ref long al_filial_estoque, ref string as_msg);String ls_filial_estoque

Select vl_parametro 
Into  :ls_filial_estoque
From parametro_geral 
Where cd_parametro  = 'CD_FILIAL_ESTOQUE_GERACAO'
Using SqlCA;

Choose Case SqlCa.SqlCode
	Case 0
		al_filial_estoque = long(ls_filial_estoque)
	Case -1
		as_MSG = 	"Erro ao verificar o parametro : CD_FILIAL_ESTOQUE_GERACAO. " + SQLCA.SQLErrText + "'."	
		Return False
	Case 100
		as_MSG = 	"Parametro CD_FILIAL_ESTOQUE_GERACAO n$$HEX1$$e300$$ENDHEX$$o localizado na tabela parametro_geral"	
		Return False
End Choose

Return True
end function

on uo_ge259_pedido_filial.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge259_pedido_filial.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;//ids_Produtos_Localizacao = Create dc_uo_ds_base
//ids_Produtos_Localizacao.of_ChangeDataObject("ds_ge259_produto_localizacao")
//
//ids_produtos_rua = Create dc_uo_ds_base
//ids_produtos_rua.of_ChangeDataObject("ds_ge259_produtos_rua") 

ids_Etiquetas_Volume = Create dc_uo_ds_base
ids_Etiquetas_Volume.of_ChangeDataObject("ds_ge259_etiqueta_volume")


ivds_Itens    = Create dc_uo_ds_base

//////idc_peso_caixa = 12.000

ib_pedido_teste_infra = False




end event

event destructor;Destroy(ids_Etiquetas_Volume)
Destroy(ivds_Itens)
end event

