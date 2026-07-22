HA$PBExportHeader$uo_ge205_cancelamento.sru
forward
global type uo_ge205_cancelamento from nonvisualobject
end type
end forward

global type uo_ge205_cancelamento from nonvisualobject
end type
global uo_ge205_cancelamento uo_ge205_cancelamento

type variables
dc_uo_ds_base ids_Cancelar

String is_data_novas_contas
String is_caixa
Long   il_controle_caixa
end variables

forward prototypes
public function boolean of_cancelar ()
public function boolean of_exclui_titulos_cr (long al_filial, long al_nf, string as_especie, string as_serie)
public function boolean of_estorno_fcerta (long al_filial, long al_nf, string as_especie, string as_serie)
public function boolean of_cancela_venda_poo (long al_filial, long al_nf, string as_especie, string as_serie)
public subroutine of_atualiza_matriz ()
public function boolean of_atualiza_etiqueta_prestes (long al_filial, long al_nf, string as_especie, string as_serie)
public function boolean of_cancela_lancamentos_caixa (long al_filial, long al_nf, string as_especie, string as_serie)
public function boolean of_atualiza_pedido_ecommerce (string ps_pedido)
end prototypes

public function boolean of_cancelar ();Boolean lb_Sucesso = True

Long ll_Linhas
Long ll_Row
Long ll_Filial
Long ll_Filial_log
Long ll_NF
	  
String	ls_Especie
String ls_Serie
String ls_Tipo_Venda
Date	ldt_data_movimentacao
		 
Try
	SetPointer(HourGlass!)
	
	Open(w_Aguarde)
	w_Aguarde.Title = "Cancelando Venda(s), aguarde..."
	
	// ds_dw_ge205_lista usado tamb$$HEX1$$e900$$ENDHEX$$m na Janela
	If Not ids_Cancelar.of_ChangeDataObject( "ds_dw_ge205_lista" ) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no evento of_ChangeDataObject.~rFun$$HEX2$$e700e300$$ENDHEX$$o: of_Cancelar()", Exclamation! )
		Return False
	End If
	
	ll_Linhas = ids_Cancelar.Retrieve()
	
	Choose Case ll_Linhas 
		Case 0
			Return True
		Case -1
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no retrieve. Fun$$HEX2$$e700e300$$ENDHEX$$o: of_Cancelar() ", StopSign! )
			Return False
	End Choose
	
	w_Aguarde.uo_Progress.of_SetMax( ll_Linhas )
	
//	uo_Parametro_Filial lvo_Parametro
//	lvo_Parametro = Create uo_Parametro_Filial	
//	lvo_Parametro.of_Localiza_Parametro("DT_INICIO_VANNON", ref is_data_novas_contas, False)	
//	Destroy(lvo_Parametro)	
	
	For ll_Row = 1 To ll_Linhas
		ll_Filial						= ids_Cancelar.Object.Cd_Filial						[ ll_Row ]
		ll_NF							= ids_Cancelar.Object.Nr_NF						[ ll_Row ]
		ls_Especie					= ids_Cancelar.Object.De_Especie					[ ll_Row ]
		ls_Serie						= ids_Cancelar.Object.De_Serie					[ ll_Row ]
		ls_Tipo_Venda				= ids_Cancelar.Object.Id_Tipo_Venda			[ ll_Row ]
		ldt_data_movimentacao  = ids_Cancelar.Object.dh_movimentacao_caixa[ ll_Row ]

		Update nf_venda
		Set dh_cancelamento		= dh_movimentacao_caixa
		Where cd_filial  	= :ll_Filial
		  and nr_nf      		= :ll_NF
		  and de_especie 	= :ls_Especie
		  and de_serie   	= :ls_Serie
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_Rollback();
			SqlCa.of_MsgdbError("of_Cancelar()")
			lb_Sucesso = False
			Exit
		End If		

		Select Distinct cd_filial INTO :ll_Filial_log
		From log_cancelamento_fiscal
		Where cd_filial  	= :ll_Filial
		  and nr_nf      		= :ll_NF
		  and de_especie 	= :ls_Especie
		  and de_serie   	= :ls_Serie
		  and id_cancelamento = 'ERR'
		Using Sqlca;
		
		Choose Case SqlCa.SqlCode
			Case 100		
				// Registra Produtos Cancelados 
				
				Insert Into log_cancelamento_fiscal(cd_filial,   
																dh_movimentacao_caixa,   
																dh_cancelamento,   
																nr_matricula_operador,
																nr_matricula_responsavel,   
																nr_ecf,   
																nr_coo,   
																cd_caixa,   
																nr_controle_caixa,   
																nr_nf,   
																de_especie,   
																de_serie,
																id_cancelamento,
																cd_produto,   
																qt_cancelada,   
																vl_preco_praticado,   
																id_alteracao_preco,
																vl_preco_bruto)
				Select n.cd_filial,
						 n.dh_movimentacao_caixa,
						 GetDate(),
						 n.nr_matric_operador,
						 n.nr_matricula_cancelamento,
						 n.nr_ecf,
						 n.nr_operacao_ecf,
						 n.cd_caixa,
						 n.nr_controle_caixa,
						 n.nr_nf,
						 n.de_especie,
						 n.de_serie,
						 'F12',
						 i.cd_produto,
						 i.qt_vendida,
						 i.vl_preco_praticado,
						 i.id_alteracao_preco,
						 i.vl_preco_unitario
				From nf_venda n 
					Inner join item_nf_venda i
							On i.cd_filial  		= n.cd_filial
						  and i.nr_nf      		= n.nr_nf
						  and i.de_especie 	= n.de_especie
						  and i.de_serie   		= n.de_serie
				Where n.cd_filial  		= :ll_Filial
				  and n.nr_nf      		= :ll_NF
				  and n.de_especie 	= :ls_Especie
				  and n.de_serie   		= :ls_Serie
				Using SqlCa;
				
				If SqlCa.SqlCode = -1 Then
					SqlCa.of_Rollback();
					SqlCa.of_MsgdbError("of_Cancelar()")
					lb_Sucesso = False
					Exit
				End If
				
			Case -1
				SqlCa.of_Rollback();
				SqlCa.of_MsgdbError("of_Cancelar()")
				lb_Sucesso = False
				Exit								
		
		End Choose 
		
		// Exclui os titulos a receber de credi$$HEX1$$e100$$ENDHEX$$rio
		If ls_Tipo_Venda = "CR" Then
			w_Aguarde.Title = "Excluindo t$$HEX1$$ed00$$ENDHEX$$tulos CR, aguarde..."
			If Not of_Exclui_Titulos_CR(  ll_Filial, ll_NF, ls_Especie, ls_Serie) Then
				lb_Sucesso = False
				Exit
			End If
		End If
			
		w_Aguarde.Title = "Cancelando lan$$HEX1$$e700$$ENDHEX$$amentos Caixa, aguarde..."
		If Not of_cancela_lancamentos_caixa(ll_Filial,ll_NF,ls_Especie,ls_Serie) Then
			lb_Sucesso = False
			Exit
		End If			
		
		If Not of_Cancela_Venda_Poo( ll_Filial, ll_NF, ls_Especie, ls_Serie ) Then 
			lb_Sucesso = False
			Exit
		End If
		
		//Estorna pagamento da requisicao no FCerta
		of_estorno_fcerta(ll_Filial, ll_NF, ls_Especie, ls_Serie)	
		
		//Volta Situa$$HEX2$$e700e300$$ENDHEX$$o etiqueta prestes
		w_Aguarde.Title = "Atualizando preste $$HEX1$$e000$$ENDHEX$$ vencer, aguarde..."
		If Not of_atualiza_etiqueta_prestes( ll_Filial, ll_NF, ls_Especie, ls_Serie ) Then 
			lb_Sucesso = False
			Exit			
		End If
				
		w_Aguarde.uo_Progress.of_SetProgress( ll_Row )	
	Next
	
	If lb_Sucesso Then
		SqlCa.of_Commit()		
		// Atualiza o banco de dados da matriz
		of_Atualiza_Matriz()
		
		Return True
	End If

Finally
	Close(w_Aguarde)
	SetPointer(Arrow!)
End Try
end function

public function boolean of_exclui_titulos_cr (long al_filial, long al_nf, string as_especie, string as_serie);Boolean lvb_Sucesso = True

Long lvl_Total, &
     lvl_Contador
	  
String lvs_Cupom, &
       lvs_Titulo

Try
	dc_uo_ds_Base lvds_1
	lvds_1 = Create dc_uo_ds_Base

	If Not lvds_1.of_ChangeDataObject("ds_ge205_titulos_crediario") Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no envento of_ChangeDataObject.~rFun$$HEX2$$e700e300$$ENDHEX$$o: of_exclui_titulos_cr(long,long,string,string)")
		Return False
	End If

	lvs_Cupom = String(al_Filial) + "/" + String(al_NF) + "/" + as_Especie + "/" + as_Serie

	If lvds_1.Retrieve(al_Filial, al_NF, as_Especie, as_Serie) < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no Retrieve.~rFun$$HEX2$$e700e300$$ENDHEX$$o: of_exclui_titulos_cr(long,long,string,string) ")
		Return False
	End If

	lvl_Total = lvds_1.RowCount()
	
	If lvl_Total > 0 Then
		For lvl_Contador = 1 To lvl_Total
			lvs_Titulo = lvds_1.Object.Nr_Titulo[ lvl_Contador ] 
			
			Delete From movimento_titulo_receber
			Where nr_titulo = :lvs_Titulo
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				SqlCa.of_RollBack()
				SqlCa.of_MsgdbError("Exclus$$HEX1$$e300$$ENDHEX$$o dos Movimentos do T$$HEX1$$ed00$$ENDHEX$$tulo '" + lvs_Titulo + "' da nota fiscal '" + lvs_Cupom + "'")
				lvb_Sucesso = False
				Exit
			End If
			
			Delete From titulo_receber
			Where nr_titulo = :lvs_Titulo
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				SqlCa.of_RollBack()
				SqlCa.of_MsgdbError("Exclus$$HEX1$$e300$$ENDHEX$$o do T$$HEX1$$ed00$$ENDHEX$$tulo '" + lvs_Titulo + "' da nota fiscal '" + lvs_Cupom + "'")
				lvb_Sucesso = False
				Exit
			End If
		Next
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Os t$$HEX1$$ed00$$ENDHEX$$tulos de credi$$HEX1$$e100$$ENDHEX$$rio referentes a nota fiscal '" + lvs_Cupom + "' n$$HEX1$$e300$$ENDHEX$$o foram localizados.", StopSign!)
		lvb_Sucesso = False
	End If
	
	Return lvb_Sucesso
	
Finally
	If IsValid( lvds_1 ) Then Destroy lvds_1
End Try
	

end function

public function boolean of_estorno_fcerta (long al_filial, long al_nf, string as_especie, string as_serie);Boolean lb_Sucesso = True

Long 	ll_Total, &
     	ll_Contador, &
	 	ll_registro, &
		ll_filial_fcerta, &
		ll_produto, &
		ll_retorno

String ls_integraFC

uo_Parametro_Filial lo_Parametro
lo_Parametro = Create uo_Parametro_Filial
lo_Parametro.of_Localiza_Parametro("ID_PERMITE_INTEGRACAO_FCERTA", ref ls_integraFC, False)
If IsValid( lo_parametro ) Then Destroy lo_parametro

If Trim(ls_integraFC) = 'N' Then Return True

dc_uo_ds_Base lvds_1
lvds_1 = Create dc_uo_ds_Base

If Not lvds_1.of_ChangeDataObject("ds_ge205_registro_manip") Then
	If IsValid( lvds_1 ) Then Destroy lvds_1 
	Return False
End If

ll_Total = lvds_1.Retrieve(al_Filial, al_NF, as_Especie, as_Serie)

If ll_Total > 0 Then
	uo_ge119_formula_certa lo_FCerta
	lo_FCerta = Create uo_ge119_formula_certa	
	
	For ll_Contador = 1 To ll_Total
		ll_Produto 		= lvds_1.Object.cd_produto		[ll_Contador]		
		ll_Registro		= lvds_1.Object.Nr_registro		[ll_Contador]
		ll_filial_fcerta 	= lvds_1.Object.cd_filial_fcerta	[ll_Contador]	
		
		If Not IsNull(ll_Filial_fcerta) And ll_filial_fcerta > 0 Then	
			If lo_FCerta.of_estornar_pagamento(ll_filial_fcerta, ll_registro, Ref ll_retorno) Then
				If ll_retorno = 0 Then
					gvo_Aplicacao.of_Grava_Log( "CANCELAMENTO CUPOM - Estorno Requis$$HEX2$$e700e300$$ENDHEX$$o FCerta com Sucesso! " + &
														" Requisicao [" + String(ll_registro) + "]" + & 
														", Filia_FCerta [" + String(ll_filial_fcerta) + "]")
				Else
					gvo_Aplicacao.of_Grava_Log( "CANCELAMENTO CUPOM - Erro no Estorno Requis$$HEX2$$e700e300$$ENDHEX$$o FCerta!" + &
														" Requisicao [" + String(ll_registro) + "]" + & 
														", Filia_FCerta [" + String(ll_filial_fcerta) + "]" + &
														", Retorno [" + String(ll_retorno) + "]")
				End If
			Else
				gvo_Aplicacao.of_Grava_Log( "CANCELAMENTO CUPOM - Erro no Estorno Requis$$HEX2$$e700e300$$ENDHEX$$o FCerta!" + &
													" Requisicao [" + String(ll_registro) + "]" + & 
													", Filia_FCerta [" + String(ll_filial_fcerta) + "]" + &
													", Retorno [" + String(ll_retorno) + "]")
			End If	
		Else
			gvo_Aplicacao.of_Grava_Log( "CANCELAMENTO CUPOM - Requisi$$HEX2$$e700e300$$ENDHEX$$o sem Filial FCerta para fazer o Estorno!" + &
												" Requisicao [" + String(ll_registro) + "]")		
		End If
		
	Next
	
	If IsValid( lo_FCerta ) Then Destroy lo_FCerta
End If

If IsValid( lvds_1 ) Then Destroy lvds_1 

Return lb_Sucesso
end function

public function boolean of_cancela_venda_poo (long al_filial, long al_nf, string as_especie, string as_serie);dc_uo_ds_base lds_POO
Long ll_linhas, ll_row
Decimal {2} ldc_pagamento
String ls_pagamento, ls_historico
DateTime ldt_data_registro

lds_POO = Create dc_uo_ds_base
If Not lds_POO.of_ChangeDataObject( "ds_ge205_venda_poo" ) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no evento of_ChangeDataObject.~rFun$$HEX2$$e700e300$$ENDHEX$$o: of_Cancelar()", Exclamation! )
	Return False
End If

ll_Linhas = lds_POO.Retrieve(al_filial,al_nf,as_especie,as_serie)

Choose Case ll_Linhas 
	Case 0
		Destroy(lds_POO)
		Return True
	Case -1
		Destroy(lds_POO)
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no retrieve venda_poo. Fun$$HEX2$$e700e300$$ENDHEX$$o: of_Cancelar() ", StopSign! )
		Return False
End Choose

uo_Controle_Caixa lo_Controle_Caixa
lo_Controle_Caixa = Create uo_Controle_Caixa

For ll_Row = 1 To ll_Linhas	
	ldc_Pagamento	= lds_POO.Object.Vl_Pagamento	[ ll_Row	]
	ls_pagamento	=  lds_POO.Object.cd_forma_Pagamento	[ ll_row	]
	ldt_data_registro = gf_getserverdate()	

	If ls_pagamento = "PC" Then ls_historico = "NF: " + String( al_nf ) + " (CRE)"
	If ls_pagamento = "PD" Then ls_historico = "NF: " + String( al_nf ) + " (DEB)"
	If ls_pagamento = "PX" Then ls_historico = "NF: " + String( al_nf ) + " (CAD)"
	If ls_pagamento = "LP"  Then ls_historico = "NF: " + String( al_nf ) + " (LPG)"

	If Not lo_Controle_Caixa.of_insere_lancamento_caixa(is_Caixa		,&
																		  il_Controle_Caixa	,&
																		  206				,&
																		  ldt_data_registro,&
																		  ldc_Pagamento	,&
																		  ls_historico	,&
																		  ''				,&
																		  'S',&
																		  String(al_nf)) Then
		Destroy(lo_Controle_Caixa)
		Return False
	End If
Next

Destroy(lo_Controle_Caixa)

update nf_venda_poo
	set id_situacao_pagamento 		= 'X'
 where cd_filial 						= :al_Filial
 	and nr_nf 							= :al_Nf
	and de_especie 					= :as_Especie
	and de_serie 						= :as_Serie
	and id_situacao_pagamento 	= 'P'
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_Rollback()
	SqlCa.of_MsgDbError("Erro ao cancelar a venda POO. Chave: " + String(al_Nf) + '-'+as_Especie+'-'+as_Serie +'.')
	Return False
End If

Return True
end function

public subroutine of_atualiza_matriz ();Long	lvl_Total		, &
		lvl_Contador, &
		lvl_Filial		, &
		lvl_NF
	  
String	lvs_Cancelar	, &
		lvs_Especie		, &
		lvs_Serie			, &
		lvs_Tipo_Venda, &
		lvs_Cliente		, &
		lvs_Cartao		, &
		lvs_Dependente, &
		lvs_Documento
		 
Decimal	lvdc_Total_NF, &
			lvdc_Pontos, &
			lvdc_pago_avista

DateTime lvdt_Dh_Movimento

uo_Cliente_Central 	lvo_Cliente
uo_Conveniado 		lvo_Conveniado

lvo_Cliente 			= Create uo_Cliente_Central 	//GE077
lvo_Conveniado 	= Create uo_Conveniado			//GE005

w_Aguarde.Title = "Atualizando Banco de Dados da Matriz..."

lvl_Total = ids_Cancelar.RowCount()

w_Aguarde.uo_Progress.of_SetMax(lvl_Total)

For lvl_Contador = 1 To lvl_Total
	lvl_Filial     				= ids_Cancelar.Object.Cd_Filial										[lvl_Contador]
	lvl_NF         				= ids_Cancelar.Object.Nr_NF										[lvl_Contador]
	lvs_Especie    			= ids_Cancelar.Object.De_Especie									[lvl_Contador]
	lvs_Serie      			= ids_Cancelar.Object.De_Serie									[lvl_Contador]
	lvs_Tipo_Venda 		= ids_Cancelar.Object.Id_Tipo_Venda							[lvl_Contador]
	lvdt_Dh_Movimento	= DateTime(ids_Cancelar.Object.Dh_Movimentacao_Caixa	[lvl_Contador])
	lvs_Cliente		   		= ids_Cancelar.Object.Cd_Cliente									[lvl_Contador]
	lvs_Dependente		= ids_Cancelar.Object.Cd_Cliente_Dependente					[lvl_Contador]
	lvs_Cartao				= ids_Cancelar.Object.Nr_Cartao_Clube							[lvl_Contador]
	lvdc_Total_NF			= ids_Cancelar.Object.Vl_Total_NF								[lvl_Contador]
	lvdc_Pontos				= ids_Cancelar.Object.Qt_Pontos_Clube							[lvl_Contador]
	lvdc_pago_avista		= ids_Cancelar.Object.Vl_Pago_avista							[lvl_Contador]
		

	If IsNull(lvdc_Pontos) Then lvdc_Pontos = 0 
	If lvs_Dependente 	= "" Then SetNull(lvs_Dependente)
	If lvs_Cartao     	= "" Then SetNull(lvs_Cartao)
	If lvs_Cliente    		= "" Then SetNull(lvs_Cliente)
	
	// Inclui o movimento de cancelamento da devolu$$HEX2$$e700e300$$ENDHEX$$o de venda na matriz
	If Not IsNull(lvs_Cliente) and lvdc_Pontos > 0 Then
		lvo_Cliente.of_Inclui_Movto_Venda_Devolucao(lvl_Filial, &
																  lvl_NF, &
																  lvs_Especie, &
																  lvs_Serie, &
																  lvdt_Dh_Movimento, &
																  lvs_Cliente, &
																  lvs_Dependente,	& 
																  lvs_Cartao, &
																  lvdc_Total_NF, &
																  lvdc_Pontos, &
																  "V", "S")
	End If
	
	// Inclui o movimento para controle do limite de cr$$HEX1$$e900$$ENDHEX$$dito online
	If Not IsNull(lvs_Cliente) and lvs_Tipo_Venda = "CC" Then
		lvs_Documento = String(lvl_Filial) + "/" + String(lvl_NF) + "/" + Trim(lvs_Especie) + "/" + Trim(lvs_Serie)
							 
		lvo_Cliente.of_Inclui_Movto_Credito_Online(lvs_Cliente, &
																 lvl_Filial, &
																 Date(lvdt_Dh_Movimento), &
																 2, &
																 lvdc_Total_NF - lvdc_pago_avista, &
																 lvs_Documento)
	End If
	
	// Cancela a nota fiscal de conv$$HEX1$$ea00$$ENDHEX$$nio online (controle de limite de cr$$HEX1$$e900$$ENDHEX$$dito)
	If lvs_Tipo_Venda = "CV" Then
		lvo_Conveniado.of_Cancela_Venda_OnLine( lvl_Filial, lvl_NF, lvs_Especie, lvs_Serie )
	End If
	
	w_Aguarde.uo_Progress.of_SetProgress( lvl_Contador )	
Next


If IsValid( lvo_Cliente ) 		Then Destroy lvo_Cliente
If IsValid( lvo_Conveniado ) Then Destroy lvo_Conveniado
end subroutine

public function boolean of_atualiza_etiqueta_prestes (long al_filial, long al_nf, string as_especie, string as_serie);update produto_preste_a_vencer
	set id_situacao 				= 'A',
		 cd_filial					= null,
		 nr_nf						= null,
		 de_especie				= null,
		 de_serie					= null,
		 dh_baixa				= null,
		 nr_matricula_baixa	= null,
		 id_tipo_baixa			= null
 where cd_filial		= :al_filial
 	and nr_nf		= :al_nf
	and de_especie	= :as_especie
	and de_serie	= :as_serie
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_rollback( )
	SqlCa.of_MsgDbError("Erro ao atualizar etiqueta prestes. Chave: " + String(al_nf) + '-'+as_Especie+'-'+as_Serie +'.')
	Return False
End If

Return True
end function

public function boolean of_cancela_lancamentos_caixa (long al_filial, long al_nf, string as_especie, string as_serie);Boolean  lb_MF, &
			lb_farmagora, &
			lb_mp_contas_diferentes

Long     ll_filial,&
         ll_lancamento,&
		ll_conta_receita,&
		ll_conta_receb, &
		ll_pag, &
		ll_controle, &
		ll_convenio, &
		ll_pedido_ecommerce,&
		ll_produto_manip

String ls_historico_receita, &
		ls_historico_receb, &
		ls_tipo_venda, &
		ls_caixa, &
		ls_forma_pagamento, &
		ls_convenio_vidalink, &
		ls_pedido, &
		ls_pgto_pedido, &
		ls_situacao_pedido, &
		ls_bandeira_pedido

String ls_Refaturado, &
		 ls_rede_ecommerce, &
		 ls_plataforma
		 
DateTime ldh_movimentacao_caixa

Decimal {2} ldc_valor, &
				ldc_valor_prazo, &
				ldc_valor_avista, &
				ldc_valor_pagamento, &
				ldc_total_nf,&
				ldc_avista_nf,&
				ldc_valor_manip
				
uo_controle_caixa lo_controle_caixa //GE020
lo_controle_caixa = Create uo_controle_caixa
			
select id_tipo_venda, dh_movimentacao_caixa, cd_caixa, nr_controle_caixa, cd_forma_pagamento, &
		vl_total_nf, vl_pago_avista, cd_convenio, nr_pedido_ecommerce, nr_pedido_drogaexpress
  into :ls_tipo_venda, :ldh_movimentacao_caixa, :is_caixa, :il_controle_caixa, :ls_forma_pagamento, &
  		:ldc_total_nf, :ldc_avista_nf, :ll_convenio, :ll_pedido_ecommerce, :ls_pedido
  from nf_venda 
where cd_filial = :al_filial
	and nr_nf = :al_nf
	and de_especie = :as_especie
	and de_serie = :as_serie
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If Not IsNull(ll_pedido_ecommerce) And ll_pedido_ecommerce > 0 Then
			Select cd_forma_pagamento, coalesce(id_refaturado, 'N'), id_rede_ecommerce, id_plataforma_ecommerce, id_situacao, nm_administradora_cartao
				 into :ls_pgto_pedido, :ls_Refaturado, :ls_rede_ecommerce, :ls_plataforma, :ls_situacao_pedido, :ls_bandeira_pedido
				 from pedido_drogaexpress
				 where nr_pedido_drogaexpress = :ls_pedido
			Using SqlCa;
			 
			If SqlCa.SqlCode = -1 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do Pedido." + SqlCa.SqlErrText, StopSign!)
				Return False
			End If
			
			If ls_rede_ecommerce = 'MP' Then //Verifica$$HEX2$$e700e300$$ENDHEX$$o para conta fluxo manipula$$HEX2$$e700e300$$ENDHEX$$o
				uo_Produto lo_Produto
				lo_Produto = Create uo_produto				
				ll_produto_manip = lo_produto.cd_produto_manipulado				
				Destroy(lo_Produto)
				
				Long ll_nota

				select sum(vl_preco_praticado * qt_vendida) as vl_total_manip, nr_nf
					into :ldc_valor_manip, :ll_nota
				from item_nf_venda
				where cd_filial = :al_filial
					and nr_nf = :al_nf
					and de_especie = :as_especie
					and de_serie = :as_serie
					and cd_produto = :ll_produto_manip
				group by nr_nf
				Using SqlCa;		
				
				If SqlCa.SqlCode = -1 Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do Manipulados do Pedido." + SqlCa.SqlErrText, StopSign!)
					Return False
				End If
				
				If ldc_valor_manip > 0 And ldc_valor_manip <> ldc_total_nf Then
					lb_mp_contas_diferentes = True
				End If
				
			End If
			
			//Se situa$$HEX2$$e700e300$$ENDHEX$$o estiver como 'F' - Faturado ou 'P' - Pendente, volta a situa$$HEX2$$e700e300$$ENDHEX$$o para em Aberto.
			If ls_situacao_pedido = 'F' Or ls_situacao_pedido = 'P' Then
				If Not This.of_atualiza_pedido_ecommerce( ls_pedido ) Then
					Return False
				End If
			End If
			
			lb_farmagora = true
			ls_forma_pagamento = ls_pgto_pedido
			If ll_pedido_ecommerce < 600000000 Then //Pedidos VTex n$$HEX1$$e300$$ENDHEX$$o tem lancamento na conta 205.	
				//Lan$$HEX1$$e700$$ENDHEX$$amento caixa para cobrir o lan$$HEX1$$e700$$ENDHEX$$amento de estorno na conta 205.
				If ls_forma_pagamento = 'CP' or ls_forma_pagamento = 'CA' Then
					If Not lo_controle_caixa.of_insere_lancamento_caixa(is_caixa,&
																						  il_controle_caixa,&
																						  205,&
																						  ldh_movimentacao_caixa,&
																						  ldc_total_nf,&
																						  'CANC.VENDA PED:'+String(ll_pedido_ecommerce)+' - ECOMMERCE',&
																						  '', &
																						  String(ll_pedido_ecommerce)) Then				
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel efetuar o lancamento no caixa: " + is_caixa + " controle: " + String(il_controle_caixa) )																													  
						Return False
					End If				
				End If
			End If
			If ls_bandeira_pedido = 'CARTEIRA DIGITAL PIX' Then
				If Not lo_controle_caixa.of_insere_lancamento_caixa(is_caixa,&
																					  il_controle_caixa,&
																					  205,&
																					  ldh_movimentacao_caixa,&
																					  ldc_total_nf,&
																					  'CANC.VENDA PED:'+String(ll_pedido_ecommerce)+' - ECOMMERCE',&
																					  '', &
																					  String(ll_pedido_ecommerce)) Then				
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel efetuar o lancamento no caixa: " + is_caixa + " controle: " + String(il_controle_caixa) )																													  
					Return False
				End If								
			End If
			
			If ls_plataforma = '4' Then // Pedido VM
				If ls_forma_pagamento = 'CP' or ls_forma_pagamento = 'CA' Then
					If Not lo_controle_caixa.of_insere_lancamento_caixa(is_caixa,&
																						  il_controle_caixa,&
																						  256,&
																						  ldh_movimentacao_caixa,&
																						  ldc_total_nf,&
																						  'CANC.VENDA PED:'+String(ll_pedido_ecommerce)+' - VM',&
																						  '', &
																						  String(ll_pedido_ecommerce)) Then				
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel efetuar o lancamento no caixa: " + is_caixa + " controle: " + String(il_controle_caixa) )																													  
						Return False
					End If				
				End If				
			End If
			
			//Pedido Refaturado
			If ls_Refaturado = "S" Then
				If Not lo_controle_caixa.of_insere_lancamento_caixa(is_caixa,&
																					  il_controle_caixa,&
																					  233,&
																					  ldh_movimentacao_caixa,&
																					  ldc_total_nf,&
																					  'CANC.VENDA PED REFATURADO:'+String(ll_pedido_ecommerce)+' - ECOMMERCE',&
																					  '', &
																					  String(ll_pedido_ecommerce)) Then				
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel efetuar o lancamento no caixa: " + is_caixa + " controle: " + String(il_controle_caixa) )																													  
					Return False
				End If				
			End If
			
			If ls_plataforma = '3' Then
				lb_farmagora = False
			End If			
		End If
		
		ldc_valor = ldc_total_nf //- ldc_avista_nf				
	
		If (ls_tipo_venda = 'CC' or ls_tipo_venda = 'CV' or ls_tipo_venda = 'CR') And ldc_valor > 0 Then
			ll_conta_receita = 210
			If lb_farmagora Then
				Choose Case ls_rede_ecommerce
					Case 'FA'; ll_conta_receita = 225
					Case 'DC'
						If ls_plataforma = '4' Then
							ll_conta_receita = 258
						Else
							ll_conta_receita = 247
						End If
					Case 'MP'; 						
						ll_conta_receita = 248
						If Not lb_mp_contas_diferentes Then 
							If ldc_valor_manip > 0 Then 
								ll_conta_receita = 248
							Else
								ll_conta_receita = 247;
							End If
						End If						
						
					Case 'PP'
						If ls_plataforma = '4' Then
							ll_conta_receita = 260
						Else						
							ll_conta_receita = 255
						End If
				End Choose
				If ll_convenio = 54712 Then //Venda MAGALU pelo ecommerce grava nessa conta, quando cancela tem que tirar dessa.
					ll_conta_receita = 210
				End If
			End If			
			ls_historico_receita = 'TOTAL VENDA PRAZO'
			Choose Case ll_convenio
				Case 52349
					ll_conta_receb = 204
					ls_historico_receb = 'TOTAL PRAZO FUNCIONAL'
				Case 52718
					ll_conta_receb = 203
					ls_historico_receb = 'TOTAL PRAZO E-PHARMA'
				Case 52575, 53724, 53725
					//Busca o conv$$HEX1$$ea00$$ENDHEX$$nio Vidalink para venda.
					select nr_comprovante_venda
					  into :ls_convenio_vidalink
					  from venda_pbm 
					where cd_filial = :al_filial
						and nr_nf = :al_nf
						and de_especie = :as_especie
						and de_serie = :as_serie
					Using SqlCa;
					
					If SqlCa.SqlCode = -1 Then
						SqlCa.of_RollBack()
						SqlCa.of_MsgDbError("Erro localiza$$HEX2$$e700e300$$ENDHEX$$o conv$$HEX1$$ea00$$ENDHEX$$nio Vidalink. of_cancela_lancamento_nfce(long,long,string,string)")
						Return False
					End If	  			
					
					If Upper(Trim(ls_convenio_vidalink)) = 'AVFARPOP' Then
						ll_conta_receb = 200
						ls_historico_receb = 'TOTAL PRAZO VIDALINK POPULAR'
					ElseIf (Upper(Trim(ls_convenio_vidalink)) = 'AVFCOPEL') Or (Upper(Trim(ls_convenio_vidalink)) = 'AVCOPMUC') Then
						ll_conta_receb = 201
						ls_historico_receb = 'TOTAL PRAZO VIDALINK COPEL'
					Else
						ll_conta_receb = 202
						ls_historico_receb = 'TOTAL PRAZO VIDALINK'
					End If
				Case Else
					ll_conta_receb = 211
					ls_historico_receb = 'TOTAL A RECEBER CONV/CLIENTE - NFC-e/SAT'						
			End Choose
		Else
			//verifica forma pagamento MF
			If ls_forma_pagamento = 'MF' Then		
				dc_uo_ds_base lds_pgto
				lds_pgto = Create dc_uo_ds_base				
				If Not lds_pgto.of_ChangeDataObject('ds_ge205_formas_pgto') Then Return False
			
				lds_pgto.of_RestoreSqlOriginal()
				lds_pgto.Retrieve(al_filial,al_nf,as_especie,as_serie)				
				If lds_pgto.RowCount() > 0 Then				
					For ll_pag = 1 TO lds_pgto.RowCount()
						Choose Case lds_pgto.Object.cd_forma_pagamento[ll_pag]
							Case 'CP', 'HP'
								ldc_valor_prazo = ldc_valor_prazo + lds_pgto.Object.vl_pagamento[ll_pag]
							Case Else
								ldc_valor_avista = ldc_valor_avista + lds_pgto.Object.vl_pagamento[ll_pag]
						End Choose
					Next
					Destroy(lds_pgto)
				Else
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o foram encontrados as formas de pagamento para Nota!" , StopSign!)			
					Return False
				End If		
			Else
				If ls_forma_pagamento = 'CP'  OR ls_forma_pagamento = 'HP' Then
					ll_conta_receita = 210
					ls_historico_receita = 'TOTAL VENDA PRAZO'
					If lb_farmagora Then
						Choose Case ls_rede_ecommerce
							Case 'FA'; ll_conta_receita = 225
							Case 'DC'
								If ls_plataforma = '4' Then
									ll_conta_receita = 258
								Else
									ll_conta_receita = 247
								End If
							Case 'MP'; 
								ll_conta_receita = 248
								If Not lb_mp_contas_diferentes Then 
									If ldc_valor_manip > 0 Then 
										ll_conta_receita = 248
									Else
										ll_conta_receita = 247;
									End If
								End If								
							Case 'PP'
								If ls_plataforma = '4' Then
									ll_conta_receita = 260
								Else						
									ll_conta_receita = 255
								End If
						End Choose						
					End If					
				Else
					ll_conta_receita = 209
					ls_historico_receita = 'TOTAL VISTA'
					If lb_farmagora Then						
						Choose Case ls_rede_ecommerce
							Case 'FA'; ll_conta_receita = 224
							Case 'DC'
								If ls_plataforma = '4' Then
									ll_conta_receita = 257
								Else
									ll_conta_receita = 245
								End If
							Case 'MP'; 
								ll_conta_receita = 246
								If Not lb_mp_contas_diferentes Then 
									If ldc_valor_manip > 0 Then 
										ll_conta_receita = 246
									Else
										ll_conta_receita = 245;
									End If
								End If														
							Case 'PP'
								If ls_plataforma = '4' Then
									ll_conta_receita = 259
								Else								
									ll_conta_receita = 254
								End If
						End Choose						
					End If					
				End If
			End If
		End If
		
		If ldc_valor_prazo > 0 Or ldc_valor_avista > 0 Then
			If ldc_valor_prazo > 0 Then
				ll_conta_receita = 210
				If lb_farmagora Then
					Choose Case ls_rede_ecommerce
						Case 'FA'; ll_conta_receita = 225
						Case 'DC'
							If ls_plataforma = '4' Then
								ll_conta_receita = 258
							Else
								ll_conta_receita = 247
							End If
						Case 'MP'; 
							ll_conta_receita = 248
							If Not lb_mp_contas_diferentes Then 
								If ldc_valor_manip > 0 Then 
									ll_conta_receita = 248
								Else
									ll_conta_receita = 247;
								End If
							End If
						Case 'PP'
							If ls_plataforma = '4' Then
								ll_conta_receita = 260
							Else						
								ll_conta_receita = 255
							End If
					End Choose					
				End If				
				//Faz o lancamento de caixa do valor em ldc_valor_prazo		
				select nr_lancamento
				  into :ll_lancamento
				  from lancamento_caixa 
				where cd_caixa = :is_caixa
					and nr_controle_caixa = :il_controle_caixa
					and cd_conta_fluxo_caixa = :ll_conta_receita
				Using SqlCa;
				
				Choose Case SqlCa.SqlCode
					Case 0 //Econtrou, vai fazer update				
						Update lancamento_caixa
						Set vl_lancamento = vl_lancamento - :ldc_valor_prazo
						where cd_caixa = :is_caixa
							and nr_controle_caixa = :il_controle_caixa
							and nr_lancamento = :ll_lancamento
							and cd_conta_fluxo_caixa = :ll_conta_receita;
						  
						If SqlCa.SqlCode = -1 Then
							SqlCa.of_RollBack()
							SqlCa.of_MsgDbError("Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do lan$$HEX1$$e700$$ENDHEX$$amento de Caixa. of_cancela_lancamento_nfce(long,long,string,string)")
							Return False
						End If		  				
						
					Case 100 // N$$HEX1$$e300$$ENDHEX$$o encontrou, vai inserir
						If Not lo_controle_caixa.of_insere_lancamento_caixa(is_caixa,&
																							  il_controle_caixa,&
																							  ll_conta_receita,&
																							  ldh_movimentacao_caixa,&
																							  - ldc_valor_prazo,&
																							  ls_historico_receita,&
																							  '') Then				
							MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel efetuar o lancamento no caixa: " + is_caixa + " controle: " + String(il_controle_caixa) )																													  
							Return False
						End If
					Case -1
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do controle do caixa." + SqlCa.SqlErrText, StopSign!)
						Return False
				End Choose	
			End If
			If ldc_valor_avista > 0 Then
				ll_conta_receita = 209
				If lb_farmagora Then
					Choose Case ls_rede_ecommerce
						Case 'FA'; ll_conta_receita = 224
						Case 'DC'
							If ls_plataforma = '4' Then
								ll_conta_receita = 257
							Else
								ll_conta_receita = 245
							End If
						Case 'MP'; 
							ll_conta_receita = 246
							If Not lb_mp_contas_diferentes Then 
								If ldc_valor_manip > 0 Then 
									ll_conta_receita = 246
								Else
									ll_conta_receita = 245;
								End If
							End If						
							
						Case 'PP'
							If ls_plataforma = '4' Then
								ll_conta_receita = 259
							Else								
								ll_conta_receita = 254
							End If
					End Choose
				End If				
				//Faz o lancamento de caixa do valor em ldc_valor_avista
				select nr_lancamento
				  into :ll_lancamento
				  from lancamento_caixa 
				where cd_caixa = :is_caixa
					and nr_controle_caixa = :il_controle_caixa
					and cd_conta_fluxo_caixa = :ll_conta_receita
				Using SqlCa;
				
				Choose Case SqlCa.SqlCode
					Case 0 //Econtrou, vai fazer update				
						Update lancamento_caixa
						Set vl_lancamento = vl_lancamento - :ldc_valor_avista
						where cd_caixa = :is_caixa
							and nr_controle_caixa = :il_controle_caixa
							and nr_lancamento = :ll_lancamento
							and cd_conta_fluxo_caixa = :ll_conta_receita;
						  
						If SqlCa.SqlCode = -1 Then
							SqlCa.of_RollBack()
							SqlCa.of_MsgDbError("Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do lan$$HEX1$$e700$$ENDHEX$$amento de Caixa. of_cancela_lancamento_nfce(long,long,string,string)")
							Return False
						End If		  				
						
					Case 100 // N$$HEX1$$e300$$ENDHEX$$o encontrou, vai inserir
						If Not lo_controle_caixa.of_insere_lancamento_caixa(is_caixa,&
																							  il_controle_caixa,&
																							  ll_conta_receita,&
																							  ldh_movimentacao_caixa,&
																							  - ldc_valor_avista,&
																							  ls_historico_receita,&
																							  '') Then				
							MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel efetuar o lancamento no caixa: " + is_caixa + " controle: " + String(il_controle_caixa) )																													  
							Return False
						End If
					Case -1
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do controle do caixa." + SqlCa.SqlErrText, StopSign!)
						Return False
				End Choose			
			End If	
		Else
			If ldc_valor = 0 Then
				ldc_valor = ldc_total_nf
			End If
			
			//Tratamento para serparar na venda ecommerce MP, valor manipulado e valor revenda.
			If	lb_farmagora And lb_mp_contas_diferentes Then //Primeiro lan$$HEX1$$e700$$ENDHEX$$a o valor de manipulado nas contas especifca, depois do IF o valor de produtos revenda.
				//Vai gravar valores para manipulado
				ldc_valor = ldc_valor_manip	

				If ls_forma_pagamento = 'CP'  OR ls_forma_pagamento = 'HP' OR ls_forma_pagamento = 'PC' Then
					ll_conta_receita = 248
					ls_historico_receita = 'TOTAL VENDA PRAZO' 
				Else
					ll_conta_receita = 246
					ls_historico_receita = 'TOTAL VISTA'
				End If
				
				select nr_lancamento
				  into :ll_lancamento
				  from lancamento_caixa 
				where cd_caixa = :is_caixa
					and nr_controle_caixa = :il_controle_caixa
					and cd_conta_fluxo_caixa = :ll_conta_receita
				Using SqlCa;
				
				Choose Case SqlCa.SqlCode
					Case 0 //Econtrou, vai fazer update				
						Update lancamento_caixa
						Set vl_lancamento = vl_lancamento - :ldc_valor
						where cd_caixa = :is_caixa
							and nr_controle_caixa = :il_controle_caixa
							and nr_lancamento = :ll_lancamento
							and cd_conta_fluxo_caixa = :ll_conta_receita;
						  
						If SqlCa.SqlCode = -1 Then
							SqlCa.of_RollBack()
							SqlCa.of_MsgDbError("Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do lan$$HEX1$$e700$$ENDHEX$$amento de Caixa. of_cancela_lancamento_nfce(long,long,string,string)")
							Return False
						End If		  				
						
					Case 100 // N$$HEX1$$e300$$ENDHEX$$o encontrou, vai inserir				
						If Not gvo_controle_caixa.of_insere_lancamento_caixa(is_caixa,&
																							  il_controle_caixa,&
																							  ll_conta_receita,&
																							  ldh_movimentacao_caixa,&
																							  - ldc_valor,&
																							  ls_historico_receita,&
																							  '') Then
							SqlCa.of_RollBack( )
							MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel efetuar o lancamento no caixa: " + is_caixa + " controle: " + String(il_controle_caixa) )																													  
							Return False
						End If
					Case -1
						SqlCa.of_RollBack( )
						SqlCa.of_MsgDbError("Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do lan$$HEX1$$e700$$ENDHEX$$amento de Caixa. of_cancela_lancamento_nfce(long,long,string,string)")
						Return False
				End Choose				
				
				//Alimenta variaveis para grava valor de produto revenda.
				ldc_valor =  ldc_total_nf - ldc_valor_manip
				If ls_forma_pagamento = 'CP'  OR ls_forma_pagamento = 'HP' OR ls_forma_pagamento = 'PC' Then
					ll_conta_receita = 247
					ls_historico_receita = 'TOTAL VENDA PRAZO'
				Else
					ll_conta_receita = 245
					ls_historico_receita = 'TOTAL VISTA'
				End If
			End If		
			
			//Faz lancamento conta receita com valor
			select nr_lancamento
			  into :ll_lancamento
			  from lancamento_caixa 
			where cd_caixa = :is_caixa
				and nr_controle_caixa = :il_controle_caixa
				and cd_conta_fluxo_caixa = :ll_conta_receita
			Using SqlCa;
			
			Choose Case SqlCa.SqlCode
				Case 0 //Econtrou, vai fazer update				
					Update lancamento_caixa
					Set vl_lancamento = vl_lancamento - :ldc_valor
					where cd_caixa = :is_caixa
						and nr_controle_caixa = :il_controle_caixa
						and nr_lancamento = :ll_lancamento
						and cd_conta_fluxo_caixa = :ll_conta_receita;
					  
					If SqlCa.SqlCode = -1 Then
						SqlCa.of_RollBack()
						SqlCa.of_MsgDbError("Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do lan$$HEX1$$e700$$ENDHEX$$amento de Caixa. of_cancela_lancamento_nfce(long,long,string,string)")
						Return False
					End If		  				
					
				Case 100 // N$$HEX1$$e300$$ENDHEX$$o encontrou, vai inserir
					If Not lo_controle_caixa.of_insere_lancamento_caixa(is_caixa,&
																						  il_controle_caixa,&
																						  ll_conta_receita,&
																						  ldh_movimentacao_caixa,&
																						  - ldc_valor,&
																						  ls_historico_receita,&
																						  '') Then				
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel efetuar o lancamento no caixa: " + is_caixa + " controle: " + String(il_controle_caixa) )
						Return False
					End If
				Case -1
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do controle do caixa." + SqlCa.SqlErrText, StopSign!)
					Return False
			End Choose				
		
			If ll_conta_receb > 0 Then
				//Faz lancamento conta recebimento
				select nr_lancamento
				  into :ll_lancamento
				  from lancamento_caixa 
				where cd_caixa = :is_caixa
					and nr_controle_caixa = :il_controle_caixa
					and cd_conta_fluxo_caixa = :ll_conta_receb
				Using SqlCa;
				
				Choose Case SqlCa.SqlCode
					Case 0 //Econtrou, vai fazer update				
						Update lancamento_caixa
						Set vl_lancamento = vl_lancamento - :ldc_valor
						where cd_caixa = :is_caixa
							and nr_controle_caixa = :il_controle_caixa
							and nr_lancamento = :ll_lancamento
							and cd_conta_fluxo_caixa = :ll_conta_receb;
						  
						If SqlCa.SqlCode = -1 Then
							SqlCa.of_RollBack()
							SqlCa.of_MsgDbError("Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do lan$$HEX1$$e700$$ENDHEX$$amento de Caixa. of_cancela_lancamento_nfce(long,long,string,string)")
							Return False
						End If		  				
						
					Case 100 // N$$HEX1$$e300$$ENDHEX$$o encontrou, vai inserir
						If Not lo_controle_caixa.of_insere_lancamento_caixa(is_caixa,&
																							  il_controle_caixa,&
																							  ll_conta_receb,&
																							  ldh_movimentacao_caixa,&
																							  - ldc_valor,&
																							  ls_historico_receb,&
																							  '') Then				
							MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel efetuar o lancamento no caixa: " + is_caixa + " controle: " + String(il_controle_caixa) )																													  
							Return False
						End If
					Case -1
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do controle do caixa." + SqlCa.SqlErrText, StopSign!)
						Return False
				End Choose					
			End If	
		End If		
		
	Case Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o da Nota." + SqlCa.SqlErrText, StopSign!)
		Return False
End Choose

Destroy(lo_controle_caixa)

Return True
end function

public function boolean of_atualiza_pedido_ecommerce (string ps_pedido);
Update pedido_drogaexpress
Set id_situacao		= 'A'
Where nr_pedido_drogaexpress  	= :ps_pedido
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_Rollback();
	SqlCa.of_MsgdbError("Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o situa$$HEX2$$e700e300$$ENDHEX$$o pedido ecommerce. of_atualiza_pedido_ecommerce()")
	Return False
End If	

//VERIFICAR PARA CASO DE PEDIDO ENTREGUE PARCIAL - caso da Manipula$$HEX2$$e700e300$$ENDHEX$$o quando existir
Update produto_pedido_drogaexpress
Set qt_faturada		= 0
Where nr_pedido_drogaexpress  	= :ps_pedido
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_Rollback();
	SqlCa.of_MsgdbError("Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o produtos pedido ecommerce. of_atualiza_pedido_ecommerce()")
	Return False
End If	

Return True
end function

on uo_ge205_cancelamento.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge205_cancelamento.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ids_Cancelar = Create dc_uo_ds_base
end event

event destructor;If IsValid( ids_Cancelar ) Then Destroy ids_Cancelar
end event

