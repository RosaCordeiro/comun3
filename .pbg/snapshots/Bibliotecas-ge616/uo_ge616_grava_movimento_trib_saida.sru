HA$PBExportHeader$uo_ge616_grava_movimento_trib_saida.sru
forward
global type uo_ge616_grava_movimento_trib_saida from nonvisualobject
end type
end forward

global type uo_ge616_grava_movimento_trib_saida from nonvisualobject
end type
global uo_ge616_grava_movimento_trib_saida uo_ge616_grava_movimento_trib_saida

forward prototypes
public function boolean of_atualiza_nf_transferencia (long al_filial_origem, long al_filial_destino, long al_nota, string as_especie, string as_serie, date adt_data, ref string as_erro)
public function boolean of_processa_atualizacao ()
end prototypes

public function boolean of_atualiza_nf_transferencia (long al_filial_origem, long al_filial_destino, long al_nota, string as_especie, string as_serie, date adt_data, ref string as_erro);
Update 	nf_transferencia
Set		dh_grava_movto_tribut_saida = getdate()
Where	cd_filial_destino =:al_filial_destino
And 	    cd_filial_origem =:al_filial_origem
And		nr_nf=:al_nota
And   	 	de_serie=:as_serie
And 		de_especie=:as_especie 
And        dh_movimentacao_caixa=:adt_data
Using SqlCA;


Choose Case SqlCa.SqlCode
	Case 0		
		SqlCa.of_commit( )
	Case 100
		as_Erro = "N$$HEX1$$e300$$ENDHEX$$o foi alterado nenhum registro ao mudar a situa$$HEX2$$e700e300$$ENDHEX$$o da nota. Filial: "+String(al_filial_destino)+" Nota: "+String(al_nota)+" S$$HEX1$$e900$$ENDHEX$$rie: "+as_serie
		SqlCa.of_Rollback()
		Return False
	Case -1
		as_Erro = "Erro ao mudar a situa$$HEX2$$e700e300$$ENDHEX$$o da nota. Filial: "+String(al_filial_destino)+" Nota: "+String(al_nota)+" S$$HEX1$$e900$$ENDHEX$$rie: "+as_serie+" Erro: " + SqlCa.sqlErrText
		SqlCa.of_Rollback()
		Return False
	End Choose

Return True 
end function

public function boolean of_processa_atualizacao ();Long  ll_Filial_Destino,& 
		ll_Nota, ll_Produto,&
		ll_Qtd, ll_Pedido,&
		ll_Nr_Sequencial,&
		ll_tipo_movimento_saida,&
		ll_Linhas,&
		ll_Linha,&
		ll_Filial_Origem,&
		ll_linhas_ln,& 
		ll_linha_ln
		
Boolean lb_Sucesso = False		
		
String lvs_Especie,&
		lvs_Serie,&
		lvs_Produto,&
		lvs_erro, &
		lvs_Mensagem

DateTime  ldt_emissao  
Date ldt_data 
Date ldt_data_atualiza
Long ll_Cd_Mensagem = 305 

Dec{2}  ldc_bc_st_acumulada,&
			ldc_st_acumulada,&
			ldc_pc_st_acumulada,&
			ldc_icms_acumulada

// Data Execu$$HEX2$$e700e300$$ENDHEX$$o
ldt_data = RelativeDate( Date(gf_getServerDate()),  -1) 
ldt_data_atualiza = Date(gf_getServerDate())


Try
	// Dados das Notas para Envio
	dc_uo_ds_base lds_notas
	lds_notas = create dc_uo_ds_base
	If Not lds_notas.of_changedataobject( 'ds_ge616_notas_transferencia' ) Then		
		lvs_erro 	=	"Erro no ChageDataObject da ds_ge616_notas_transferencia." 
		gf_ge202_envia_email_automatico(ll_Cd_Mensagem,'',lvs_erro,{''})			
		Return False
	End if

	// Dados das Notas para Envio
	dc_uo_ds_base lds_filiais
	lds_filiais = create dc_uo_ds_base
	If Not lds_filiais.of_changedataobject( 'ds_ge616_filiais' ) Then		
		lvs_erro 	=	"Erro no ChageDataObject da ds_ge616_filiais." 
		gf_ge202_envia_email_automatico(ll_Cd_Mensagem,'',lvs_erro,{''})			
		Return False
	End if
	
	// Carrega os dados : Filiais   
	ll_linhas_ln = lds_filiais.retrieve(ldt_data)

	Open(w_Aguarde)
	w_Aguarde.Title = "Processando Movimento Tributa$$HEX2$$e700e300$$ENDHEX$$o Saida..."
	w_Aguarde.uo_Progress.of_setmax(ll_linhas_ln)
	
	
	If ll_linhas_ln  > 0  Then   
		For ll_linha_ln = 1 To   ll_linhas_ln 
			lb_Sucesso	 					= False
			ll_Filial_Destino 				= lds_filiais.object.cd_filial_destino 				 	[ll_linha_ln] 			   
			ll_Nota 							= lds_filiais.object.nr_nf									[ll_linha_ln] 				
			lvs_Especie 						= lds_filiais.object.de_especie							[ll_linha_ln] 				
			lvs_Serie 						= lds_filiais.object.de_serie								[ll_linha_ln] 		
			ll_Filial_Origem					= lds_filiais.object.cd_filial_origem 					[ll_linha_ln] 			
			ldt_emissao 					= lds_filiais.object.dh_movimentacao_caixa			[ll_linha_ln]				
			
			w_Aguarde.Title = "Movimento Tributa$$HEX2$$e700e300$$ENDHEX$$o Saida. Filial:"+String(ll_Filial_Destino)+" Nota:"+String(ll_Nota)+"/"+String(lvs_Especie)+"/"+String(lvs_Serie)
			w_Aguarde.uo_Progress.of_setprogress(ll_linhas_ln)
			
			// Carrega os dados: Notas da Filial 
			ll_linhas = lds_notas.retrieve(ll_Filial_Destino,ll_Nota,lvs_Especie,lvs_Serie)			
				
			// Para listar notas da filial 
			If ll_Linhas >  0 Then 				
				For  ll_Linha   =  1 To ll_Linhas
					// Campos de Produto
					ll_Produto 						= lds_notas.object.cd_produto						[ll_linha] 				
					ll_Nr_Sequencial				= lds_notas.object.nr_sequencial					[ll_linha] 	
					ll_Qtd								= lds_notas.object.qt_transferida					[ll_linha] 								
					ll_tipo_movimento_saida		= lds_notas.object.tipo_movimento_saida		[ll_linha] 			   
					w_Aguarde.Title = "Movimento Tributa$$HEX2$$e700e300$$ENDHEX$$o Saida. Filial:"+String(ll_Filial_Destino)+" Nota:"+String(ll_Nota)+"/"+String(lvs_Especie)+"/"+String(lvs_Serie)+" Seq.:"+String(ll_Nr_Sequencial) 

					
					// Execu$$HEX2$$e700e300$$ENDHEX$$o da Procedure
					 DECLARE sp_movto PROCEDURE FOR sp_grava_movto_tribut_saida
																	@p_filial_movimento  	= :ll_Filial_Origem,
																	@p_produto           		= :ll_Produto, 
																	@p_nota              			= :ll_Nota,
																	@p_filial            			= :ll_Filial_Destino,
																	@p_fornecedor        		= null,
																	@p_especie           		= :lvs_Especie,
																	@p_serie             			= :lvs_Serie,
																	@p_sequencial        		= :ll_Nr_Sequencial,
																	@p_data_movimento    	= :ldt_emissao,
																	@p_qtde_movimento    	= :ll_Qtd,
																	@p_tipo_movimento   	= :ll_tipo_movimento_saida,
																	@p_nota_compra       	= null,
																	@p_fornecedor_compra 	= null,
																	@p_especie_compra    	= null,
																	@p_serie_compra      	= null,
																	@p_bc_st_acumulada   	= 0 output,
																	@p_st_acumulada      	= 0 output,
																	@p_pc_st_acumulada   	= 0 output,
																	@p_icms_acumulada    	= 0 output
					USING SQLCA;
									
					EXECUTE sp_movto;
										
					If SQLCA.SQLCode = -1 then
						 lvs_erro = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_atualizacao' + '~nErro na [sp_grava_movimento_tributacao_saida]: ' + SQLCA.SQLErrText
		 				 gf_ge202_envia_email_automatico(ll_Cd_Mensagem,'',lvs_erro,{''})			
						 Return False
					Else
						w_Aguarde.Title = "Movimento Tributa$$HEX2$$e700e300$$ENDHEX$$o Saida. Executado Com Sucesso.."
						lb_Sucesso	 = True 
					End If 	
										
					FETCH sp_movto
					INTO :ldc_bc_st_acumulada,
							:ldc_st_acumulada,
							:ldc_pc_st_acumulada,
							:ldc_icms_acumulada;
								
					CLOSE sp_movto;
				Next 						
			End If 
			
			
			// Atualzia o Registro de Controla na Nota
			If lb_Sucesso Then 
				w_Aguarde.Title = "Movimento Tributa$$HEX2$$e700e300$$ENDHEX$$o Saida. Atualiza$$HEX2$$e700e300$$ENDHEX$$o da Nota.."
				If Not This.of_atualiza_nf_transferencia(ll_Filial_Origem,&
																	ll_Filial_Destino,&
																	ll_Nota,&
																	lvs_Especie,&
																	lvs_Serie,&
																	ldt_data_atualiza,&
																	Ref lvs_erro) Then 
						lvs_erro = 'Objeto: ' + this.ClassName() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_atualiza_nf_transferencia' + '~nErro na [of_processa_atualizacao]: ' + SQLCA.SQLErrText
						gf_ge202_envia_email_automatico(ll_Cd_Mensagem,'',lvs_erro,{''})			
						Return False
				End If
			Else 
				lvs_erro = "Erro no Processo de Atualiza$$HEX2$$e700e300$$ENDHEX$$o"
				gf_ge202_envia_email_automatico(ll_Cd_Mensagem,'',lvs_erro,{''})			
				Return False
			End If
		Next 	
	End If
Finally		
	Destroy (lds_notas)
	Destroy (lds_filiais) 
	Close(w_Aguarde)
End Try

Return True 
end function

on uo_ge616_grava_movimento_trib_saida.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge616_grava_movimento_trib_saida.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

