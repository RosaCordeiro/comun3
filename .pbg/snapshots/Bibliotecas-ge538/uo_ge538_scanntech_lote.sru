HA$PBExportHeader$uo_ge538_scanntech_lote.sru
forward
global type uo_ge538_scanntech_lote from nonvisualobject
end type
end forward

global type uo_ge538_scanntech_lote from nonvisualobject
end type
global uo_ge538_scanntech_lote uo_ge538_scanntech_lote

type prototypes

end prototypes

type variables
long il_filial[], il_row, il_qtd_envio = 300, il_qt_cancelada
Date idt_dh_movimentacao_caixa


String is_usuario_homo = 'integrador_test@clamed.com.br'
String is_senha_homo = 'integrador'
String is_base64_homo = 'aW50ZWdyYWRvcl90ZXN0QGNsYW1lZC5jb20uYnI6aW50ZWdyYWRvcg==' 

String is_usuario_prod = 'integrador_prod@clamed.com.br'
String is_senha_prod = 'mwPvGZnF'
String is_base64_producao = 'aW50ZWdyYWRvcl9wcm9kQGNsYW1lZC5jb20uYnI6bXdQdkdabkY='  


String is_protocolo = 'http://'
String is_sufixo_url = '/lotes'

String is_chave_movimento, is_json, ivs_janela_monitoramento
String is_data_processamento[]

dc_uo_ds_base ids_ge538_envio_vendas_lote

dc_uo_ds_base ids_fechamento


integer li_FileNum

Long il_qtd_bloco_filial


/*-- ============================================================
--        Author: Saulo Braga
-- Create date: 20/10/2021
--  Description: Processar Envio de Vendas

REGRA PARA NOTAS CANCELADAS : 
- Para o fechamento Di$$HEX1$$e100$$ENDHEX$$rio, foi incluido somado no totalizado o campo valor do desconto por causa de diferen$$HEX1$$e700$$ENDHEX$$a
  Obs.: Est$$HEX1$$e100$$ENDHEX$$ na datawindow de fechamento di$$HEX1$$e100$$ENDHEX$$rio.
  SUM(vl_total_nf + v.vl_desconto_nf)
	
- Toda nota de CANCELAMENTO dever$$HEX1$$e100$$ENDHEX$$ enviar dois JSON, um positivo e um negativo.
   Exemplo: Negativa - TAG "numero": "-123456"    "cancelacion": true
                 Positivo   - TAG "numero": "123456"      "cancelacion" false
   Existe uma fun$$HEX2$$e700e300$$ENDHEX$$o que monta o JSON positivo - of_gerar_replica_nf	
	
Obs.: Caso ocorra erro de n$$HEX1$$e300$$ENDHEX$$o autoriza$$HEX2$$e700e300$$ENDHEX$$o, favor verificar primeiro se n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ erro na estrutura,
         pois confunde com n$$HEX1$$e300$$ENDHEX$$o autorizado.
      

-- ============================================================  */
end variables

forward prototypes
public function boolean of_processar_scanntech ()
public function boolean of_processa_envio_venda ()
public function boolean of_processar_scanntech_fechamento ()
public function boolean of_processar_bloco_lote (long pl_bloco)
public function boolean of_liberar_registro_processamento_lote (long pl_cd_filial[], datetime pdh_periodo1, datetime pdh_periodo2)
public function boolean of_buscar_controle_caixa_lote (long pl_cd_filial, datetime pdh_data_1, datetime pdh_data_2, ref long pl_nr_controle_caixa, ref string ps_erro)
public function boolean of_reprocessa_envio_vendas (datetime pdh_mov_caixa, long pl_cd_filial, long pl_nr_nf)
public function boolean of_processa_fechamento_diario (date pdh_data_processamento)
public function boolean of_atualiza_log_exportacao_scanntech (long pl_cd_filial, long pl_nr_nf, string ps_de_especie, string ps_de_serie, datetime pdh_movimento_caixa, string ps_id_tipo_envio, string ps_id_situacao, string ps_de_erro, decimal pd_desconto, decimal pd_vl_total_produtos, decimal pd_vl_total_nf, string ps_cd_forma_pagamento, datetime pdh_cancelado, decimal pd_vl_desconto_nf, string ps_id_lote, string ps_cd_chave_movimento, ref string ps_erro)
public function boolean of_atualiza_total_lote (string ps_cd_chave_movimento, string ps_id_lote, datetime pdh_data_1, datetime pdh_data_2, datastore pds_envio_vendas, ref string ps_erro)
public function boolean of_atualizar_nota_erro_lote (long pl_nr_nf, datetime pdh_data_1, datetime pdh_data_2, string ps_cd_chave_movimento, datastore pds_envio_vendas, string ps_id_lote, ref string ps_erro)
public subroutine of_reprocessa_envio_vendas ()
public function boolean of_buscar_bloco_filial_lote (long pl_bloco, ref long pl_bloco_filial[], ref string ps_log)
public function boolean of_atualiza_data_proximo_movimento (datetime dh_proximo_movimento, ref string ps_log)
public function boolean of_atualiza_evento_fechamento (string ps_tipo_envio, string ps_de_erro, long pl_cd_filial, string ps_id_situacao, long pl_nr_controle_caixa, datetime pdh_mov_caixa, ref string ps_log)
public function boolean of_atualiza_evento_venda_lote (string ps_tipo_envio, string ps_de_erro, long pl_cd_filial, long pl_nr_nf, string ps_de_especie, string ps_de_serie, string ps_id_situacao, ref string ps_log)
public function boolean of_atualiza_parcial_lote (datetime pdh_data_1, datetime pdh_data_2, string ps_cd_chave_movimento, string ps_id_lote, ref string ps_log)
public function boolean of_buscar_codigo_loja_lote (integer pl_cd_filial, ref string ps_loja, ref string ps_erro)
public function boolean of_buscar_url_fechamento_diario (string as_tipo, string ps_filial, long pl_nr_caixa, ref string as_url, ref string ps_log)
public function boolean of_codigo_produto_lote (long pl_cd_produto, ref string ps_descricao, ref string ps_erro)
public function boolean of_validar_movimento_pendente (date pdh_data_movimento, ref string ps_log)
public function boolean of_validar_envio_fechamento (datetime pdh_envio_fechamento, ref datetime pdh_data_fechamento, ref string ps_log)
public function boolean of_parametro_geral_url (string ps_vl_parametro, ref string ps_url_retorno, ref string ps_log)
public function boolean of_gerar_replica_nf_lote (string ps_json, ref string ps_replica, long pl_json_cancelado, ref string ps_log)
public function boolean of_gerar_desconto_total (long pl_cd_filial, long pl_nr_nf, string ps_de_especie, string ps_de_serie, ref decimal pd_desconto, ref string ps_log)
public function boolean of_gerar_chave_movimento_lote (ref string ps_chave_movimento, ref string ps_log)
public function boolean of_gera_arquivo_venda_lote (string ps_dh_movimentacao, datetime pdh_cancelado, long pl_nr_nf, string ps_total, string ps_codigo_tipo_pago, string ps_importe, long pl_cd_filial, string ps_de_especie, string ps_de_serie, decimal pd_desconto, decimal pd_vl_total_produtos, ref string ps_json, ref string ps_log)
public function boolean of_buscar_url_envio_vendas_lote (string as_tipo, string ps_filial, long pl_nr_caixa, ref string ps_url, string ps_tipo_envio, ref string ps_log)
public function boolean of_gera_arquivo_fechamento (string ps_valor_venda, string ps_valor_cancelado, date pdh_mov_caixa, integer pi_qt_venda, integer pi_qt_cancelada, ref string ps_json, ref string ps_log)
public function boolean of_autenticar_api_scanntech_lote (string ps_metodo, string ps_url, string ps_json_envio, string ps_autenticacao_key, boolean pb_utiliza_api_key, boolean pb_utiliza_origem, ref string ps_json_retorno, ref string ps_erro, ref long pl_codigo_erro)
public function boolean of_atualiza_envio_vendas_erro_lote (string ps_cd_chave_movimento, datetime pdh_data_1, datetime pdh_data_2, datastore pds_envio_vendas, string ps_id_lote, ref string ps_erro)
public function boolean of_envia_email (string ps_mensagem, ref string ps_log)
public function boolean of_leitura_retorno_json_enviado_lote (string ps_json, string ps_tipo_validacao, ref string ps_id_lote, datetime pdh_data_1, datetime pdh_data_2, datastore pds_envio_vendas, string ps_cd_chave_movimento, ref string ps_log)
public function boolean of_preparar_dados_envio_vendas_lote (date pdh_movim_caixa, long pl_cd_filial, string ps_chave_movimento, ref string ps_log)
public function boolean of_retira_caracteres (ref string as_json, ref string ps_log)
public function boolean of_liberar_movimento_processamento (date pdh_movimento)
public function boolean of_filial_cadastrada_scanntech (integer pl_cd_filial)
public subroutine _documentacao ()
public function boolean of_parametro_geral_url (ref long pl_dias, ref string ps_log)
public function boolean of_atualiza_processamento (date adh_data_processamento, string as_tipo_processamento, string as_identificador, long al_bloco)
public function boolean of_processamento_atrasado (date adh_data_processamento, string as_tipo_processamento, ref string as_mes[], long al_bloco)
public function boolean of_valida_processamento_venda (date adh_movimento)
public function boolean of_envia_email_diario ()
public function boolean of_reprocesar_filiais (long al_cd_filial, datetime adh_processamento)
public function boolean of_liberar_movimento_processamento (date pdh_movimento_inicio, date pdh_movimento_fim, long pl_cd_filial)
end prototypes

public function boolean of_processar_scanntech ();Long ll_row, ll_cont, ll_cont_selec
long ll_existe_vendas, ll_existe_fechamento
Datetime dh_data_envio, dh_data_fechamento
Boolean lb_retorno, ll_ret_arquivo

String ls_parametro_envio, ls_filtrar_filial, ls_nSelecionado, ls_mensagem, ls_erro

Date dh_movimentacao_caixa

dc_uo_ds_base lds_filial

Try	
	
	// Enviar as vendas
    of_processa_envio_venda( )   


Catch (RunTimeError lo_error)
	Return False
Finally
  //
End Try	


Return True
end function

public function boolean of_processa_envio_venda ();
dc_uo_ds_base lds_ge538_envio_venda

Date dh_movimentacao_caixa

Datetime ldh_cancelado

Datetime data_1, data_2

Dec{2} ld_desconto, ld_vl_total_prod, ld_total_cancelado, ld_vl_total_vendas, ld_vl_total_nf

String ps_erro, ls_de_especie, ls_de_serie, ls_tipo_envio, ls_dh_mov_caixa,ls_total,ls_tp_pagamento, ls_importe, ls_json, ls_url, ls_replica, ls_negativo, ls_key, ls_json_retorno, ls_erro, ls_id_cancelado

Long ll_row, ll_cont, ll_filial, ll_nr_nf, ll_row_item, ll_nr_cont_caixa, ll_json_cancelado, ll_json, ll_cont_json, ll_codigo_erro, ll_qt_cancelados, ll_qt_vendas, ll_valida_controle_caixa

Boolean lb_ret


Try

  data_1 =  DateTime(String(dh_movimentacao_caixa) + ' 00:00:00.000')
  data_2 =  DateTime(String(dh_movimentacao_caixa) + ' 23:59:59.000')

  if IsValid(lds_ge538_envio_venda) then
	Destroy lds_ge538_envio_venda
  end if
		
  lds_ge538_envio_venda          = Create dc_uo_ds_base
		
 If Not lds_ge538_envio_venda.of_ChangeDataObject( 'ds_ge538_log_envio_venda' , False) Then 
	gvo_aplicacao.of_grava_log("Erro ao retornar dados do LOG de Envio de Vendas")
	Destroy lds_ge538_envio_venda
	Return False
  End If		

  lds_ge538_envio_venda.retrieve()
	
  ll_row = lds_ge538_envio_venda.rowcount()	

  ll_valida_controle_caixa = 1	
 
  
  If Not IsValid(w_aguarde) then
	Open(w_aguarde)
  End If	
		
  w_aguarde.Title = "Processo Envio Scanntech.."
  w_aguarde.uo_progress.of_reset()
  w_aguarde.uo_progress.Of_SetMax(ll_row)		

	
  for ll_cont = 1 to ll_row
	
      ll_filial                 = lds_ge538_envio_venda.object.cd_filial[ll_cont]
      ls_dh_mov_caixa  =  lds_ge538_envio_venda.object.dh_movimentacao_caixa[ll_cont]
	 w_aguarde.Title = "Envio Scanntech da Loja:"  + String(ll_filial)  + "- Nro:" + String(ll_cont)+" De:"+String(ll_row)				

     lb_ret = of_buscar_controle_caixa_lote( ll_filial , data_1,data_2, ll_nr_cont_caixa , ref ls_erro )
	
	if lb_ret = false then
//	   lb_ret = of_atualiza_evento_venda('V',ls_erro,ll_filial,ll_nr_nf,ls_de_especie,ls_de_serie,'P')	
	 Exit	
   end if		

	
	
	// Quando mudar de filial, retorna para 1, para n$$HEX1$$e300$$ENDHEX$$o ficar buscando para todas as notas da mesma filial
	ll_valida_controle_caixa = 0
	
	
	ls_tipo_envio       =  lds_ge538_envio_venda.object.id_tipo_envio[ll_cont]
     ll_nr_nf               =  lds_ge538_envio_venda.object.nr_nf[ll_cont]  
     ls_de_especie      =  lds_ge538_envio_venda.object.de_especie[ll_cont]
     ls_de_serie          =  lds_ge538_envio_venda.object.de_serie[ll_cont] 
     ls_dh_mov_caixa  =  lds_ge538_envio_venda.object.dh_movimentacao_caixa[ll_cont] 
     ls_total                =  lds_ge538_envio_venda.object.total[ll_cont] 
     ls_tp_pagamento  =  lds_ge538_envio_venda.object.codigoTipoPago[ll_cont] 
     ls_importe            =  lds_ge538_envio_venda.object.importe[ll_cont] 
     ld_desconto          =  lds_ge538_envio_venda.object.pc_desconto[ll_cont] 
     ld_vl_total_prod    =  lds_ge538_envio_venda.object.vl_total_produtos[ll_cont]  
     ld_vl_total_nf        = lds_ge538_envio_venda.object.vl_total_nf[ll_cont]
	ldh_cancelado     = lds_ge538_envio_venda.object.dh_cancelado[ll_cont]  
    
  
     // Buscar URL e Montar
     // 'UEV' = Url Envio Vendas
    If gvo_aplicacao.ivs_datasource = 'homologa' then
       If Not of_buscar_url_envio_vendas_lote('UHEV', string(ll_filial),ll_nr_cont_caixa,ls_url,'H', ref ls_erro)  Then
       		gvo_aplicacao.of_grava_log( ls_erro + " - " + "Data: " + ls_dh_mov_caixa + " Filial: " + string(ll_filial)  )			
	   End If			
    Else
       If Not of_buscar_url_envio_vendas_lote('UPEV', string(ll_filial),ll_nr_cont_caixa,ls_url,'P', ref ls_erro)  Then
			gvo_aplicacao.of_grava_log( ls_erro + " - " + "Data: " + ls_dh_mov_caixa + " Filial: " + string(ll_filial)  )			
	   End If			
    End If	

	lb_ret = of_gera_arquivo_venda_lote(ls_dh_mov_caixa,ldh_cancelado,ll_nr_nf,ls_total,ls_tp_pagamento,ls_importe,ll_filial,ls_de_especie,ls_de_serie,ld_desconto,ld_vl_total_prod,ls_json, ref ls_erro ) 
		
	If Not lb_ret Then
	   gvo_aplicacao.of_grava_log( ls_erro + " - " + "Data: " + ls_dh_mov_caixa + " Filial: " + string(ll_filial)  )	
	   ll_qt_cancelados      = 0
	   ld_total_cancelado   = 0
	   ll_qt_vendas           = 0
	   ld_vl_total_vendas  = 0	
    else
		ll_json = 1
		    
		// Verifica se $$HEX1$$e900$$ENDHEX$$ JSON de Cancelamento e cria a replica dele como positivo
		ll_json_cancelado = Pos( ls_json , '"numero": "')
		ls_negativo = Mid( ls_json , ll_json_cancelado + 11, 1 ) 
	   
	     if ls_negativo = '-' then
		    If Not of_gerar_replica_nf_lote(ls_json,ls_replica,ll_json_cancelado,ref ls_erro) Then
				gvo_aplicacao.of_grava_log(ls_erro + " - " + "Data: " + ls_dh_mov_caixa + " Filial: " + string(ll_filial) + " Nota: " +   String (ll_nr_nf) )
				// N$$HEX1$$e300$$ENDHEX$$o gerou a perna positiva, deixar continuar para gerar a diferen$$HEX1$$e700$$ENDHEX$$a.			
		    End If	
		    ll_json = 2
		end if
				
		for ll_cont_json = 1 to ll_json
			lb_ret = of_autenticar_api_scanntech_lote('POST',ls_url,ls_json,ls_key,true,false,ls_json_retorno, ref ls_erro, ref ll_codigo_erro)
			if ll_json = 2 then
			 ls_json = ls_replica  	
			end if	
		next
		
		// Atualizando o registro do POST enviado
		  if lb_ret then
			  // Sucesso do Envio	
//			 lb_ret = of_atualiza_evento_venda('V','',ll_filial,ll_nr_nf,ls_de_especie,ls_de_serie,'S')	
		 else	 
			// Insere o erro do envio do JSON	
//			 lb_ret = of_atualiza_evento_venda('V',ls_erro,ll_filial,ll_nr_nf,ls_de_especie,ls_de_serie,'P')
		 end if
		
		
		if lb_ret = false then
			// Caso tenha log inserir aqui...	
			ll_qt_cancelados      = 0
			ld_total_cancelado   = 0
			ll_qt_vendas           = 0
			ld_vl_total_vendas  = 0
		elseif  ll_row = ll_cont then 
			ll_qt_cancelados      = 0
			ld_total_cancelado   = 0
			ll_qt_vendas           = 0
			ld_vl_total_vendas  = 0
			
			ll_valida_controle_caixa = 1	
			  // Insere um evento de fechamento diario ------------------------------------------------------------------------------------------------------------------------------------
			lb_ret = of_atualiza_evento_fechamento('F','Evento de Fechamento Di$$HEX1$$e100$$ENDHEX$$rio',ll_filial,'P',ll_nr_cont_caixa,DateTime(Date(ls_dh_mov_caixa)), ref ls_erro)

			If not lb_ret Then
				gvo_aplicacao.of_grava_log( ls_erro + " - " + "Data: " + ls_dh_mov_caixa + " Filial: " + string(ll_filial)  )	
			End If

		elseif 	ll_cont < ll_row then 
			if (  ll_filial = lds_ge538_envio_venda.object.cd_filial[ll_cont + 1 ]  and + &
			   Date(lds_ge538_envio_venda.object.dh_movimentacao_caixa[ll_cont]) <> Date(lds_ge538_envio_venda.object.dh_movimentacao_caixa[ll_cont + 1])  ) OR +&
			   (  ll_filial <> lds_ge538_envio_venda.object.cd_filial[ll_cont + 1 ]  and + &
			   Date(lds_ge538_envio_venda.object.dh_movimentacao_caixa[ll_cont]) <> Date(lds_ge538_envio_venda.object.dh_movimentacao_caixa[ll_cont + 1]) ) OR +&
				(  ll_filial <> lds_ge538_envio_venda.object.cd_filial[ll_cont + 1 ]  and + &
			   Date(lds_ge538_envio_venda.object.dh_movimentacao_caixa[ll_cont]) = Date(lds_ge538_envio_venda.object.dh_movimentacao_caixa[ll_cont + 1])  )then
			   ll_qt_cancelados      = 0
			   ld_total_cancelado   = 0
			   ll_qt_vendas           = 0
			   ld_vl_total_vendas  = 0
			  			
			   // Insere um evento de fechamento diario ------------------------------------------------------------------------------------------------------------------------------------
			   lb_ret = of_atualiza_evento_fechamento('F','Evento de Fechamento Di$$HEX1$$e100$$ENDHEX$$rio',ll_filial,'P',ll_nr_cont_caixa,DateTime(Date(ls_dh_mov_caixa)), ref ls_erro)
			
			   If not lb_ret Then
			   	  gvo_aplicacao.of_grava_log( ls_erro + " - " + "Data: " + ls_dh_mov_caixa + " Filial: " + string(ll_filial)  )	
			   End If					
			End if
		end if
    end if
	

	
	ls_json = ''
	ls_replica = ''
	w_aguarde.uo_progress.Of_SetProgress(ll_cont)					
next

Catch (RunTimeError lo_error)
	ps_erro = lo_error.GetMessage( )
	Return False
Finally
	  Close(w_Aguarde)
End Try	


return true
end function

public function boolean of_processar_scanntech_fechamento ();DateTime dh_data_envio
DateTime dh_data_fechamento
Boolean lb_retorno
String lvs_erro
Date dh_mov_atraso

String lvs_erro_retorno

dh_data_envio = gf_GetServerDate()

of_reprocessa_envio_vendas()
	 
Try	
	dh_data_fechamento = DateTime(RelativeDate( Today(), -  1 ))

	lb_retorno = of_processa_fechamento_diario(Date(dh_data_fechamento))
		
	If Not lb_retorno Then 
		lvs_erro = "Data: " + String(dh_data_fechamento,"dd/mm/yy hh:mm:ss.") + " Favor verificar na tabela de processamento Scanntech: LOG_SCANNTECH_PROC"
		If Not of_envia_email( "Aten$$HEX2$$e700e300$$ENDHEX$$o - " + lvs_erro, lvs_erro_retorno)	Then
			gvo_aplicacao.of_grava_log(lvs_erro_retorno)
		End if	
	End if 
Catch (RunTimeError lo_error)
	Return False
Finally

End Try	

Return True 
end function

public function boolean of_processar_bloco_lote (long pl_bloco);Boolean lb_retorno
String ls_erro, ls_dh_mov_caixa,  ls_de_especie, ls_de_serie, ls_total, ls_tp_pagamento, ls_importe, ls_url, ls_json, ls_negativo, ls_replica, ls_json_lote
String ls_key, ls_json_retorno, ls_id_lote
Long ll_cd_filial[], ll_cont, ll_filial, ll_valida_controle_caixa, ll_nr_cont_caixa, ll_nr_nf, ll_json, ll_json_cancelado, ll_codigo_erro, ll_cont_ate,ll_filial_sel
Date ldh_movim_caixa
Boolean lb_ret
Dec{2} ld_desconto, ld_vl_total_prod, ld_vl_total_nf
Long ll_limitador, ll_row_filial
DateTime ldh_cancelado, ldh_data_1, ldh_data_2
Long lvl_dias, ll_cont_proc


dc_uo_ds_base lds_ge538_selecao_filial
lds_ge538_selecao_filial	           = create dc_uo_ds_base

ids_ge538_envio_vendas_lote	  = create dc_uo_ds_base	 
 

Try

	If Not of_parametro_geral_url(lvl_dias,ls_erro) Then
    		gvo_aplicacao.of_grava_log(ls_erro)	
		Return False 
  	End If
  
 	lb_retorno = of_buscar_bloco_filial_lote(pl_bloco, ll_cd_filial[], ref ls_erro)
	
 	If lb_retorno = false then
		gvo_aplicacao.of_grava_log(ls_erro)
	 	Destroy lds_ge538_selecao_filial
	 	Destroy ids_ge538_envio_vendas_lote
		Return False
  	End If

  	// Busca a chave do movimento para atualizar os 300 registros retornados
  	lb_retorno = of_gerar_chave_movimento_lote(is_chave_movimento, ref ls_erro)
  
  	If lb_retorno = false then
		gvo_aplicacao.of_grava_log(ls_erro)
		Destroy lds_ge538_selecao_filial
		Destroy ids_ge538_envio_vendas_lote
		Return False
  	End If
	
 	If Not ids_ge538_envio_vendas_lote.of_ChangeDataObject( 'ds_ge538_envio_venda_lote' , False) Then 
		gvo_aplicacao.of_grava_log("Erro ao retornar dados do LOG de Envio de Vendas")
		Destroy lds_ge538_selecao_filial
		Destroy ids_ge538_envio_vendas_lote
		Return False
  	End If	
	  
  	If Not lds_ge538_selecao_filial.of_ChangeDataObject( 'ds_ge538_sel_log_filial' , False) Then 
		gvo_aplicacao.of_grava_log("Erro ao retornar dados das filiais.")
		Destroy lds_ge538_selecao_filial
	  	Destroy ids_ge538_envio_vendas_lote
		Return False
  	End If		

	ldh_movim_caixa = RelativeDate( Today(), - lvl_dias )  // D - Quantidade de dias cadastrado
  	
	// If pl_bloco = 1 Then
		If Not of_processamento_atrasado(ldh_movim_caixa,'V',is_data_processamento[],pl_bloco) Then
			gvo_aplicacao.of_grava_log("Erro ao validar datas Processamento!")
			Destroy lds_ge538_selecao_filial
			Destroy ids_ge538_envio_vendas_lote
			Return False
		End  If
	//End If
	
	For ll_cont_proc = 1 To UpperBound(is_data_processamento)
		
		//ll_row_filial = lds_ge538_selecao_filial.retrieve(107,107)
		ll_row_filial = lds_ge538_selecao_filial.retrieve(ll_cd_filial[1],ll_cd_filial[2])
				
		ldh_movim_caixa = Date(is_data_processamento[ll_cont_proc])
	
	 //   If pl_bloco = 1 Then
			If Not of_atualiza_processamento(ldh_movim_caixa,'V','I', pl_bloco) Then
				gvo_aplicacao.of_grava_log("Erro ao validar datas Processamento!")
				Destroy lds_ge538_selecao_filial
				Destroy ids_ge538_envio_vendas_lote
				Return False
			End If	
	//	End If
		
		ldh_data_1 =  DateTime(String(ldh_movim_caixa) + ' 00:00:00.000')
		ldh_data_2 =  DateTime(String(ldh_movim_caixa) + ' 23:59:59.000')
	
//		ldh_data_1 =  DateTime( "30/03/2022" + ' 00:00:00.000')
//		ldh_data_2 =  DateTime( "30/03/2022"  + ' 23:59:59.000')
//         ldh_movim_caixa = date(ldh_data_1)
			
		// Vai processar enquanto tiver dados no bloco
	    For ll_cont_ate = 1 To ll_row_filial

		
			ll_filial_sel = lds_ge538_selecao_filial.object.cd_filial[ll_cont_ate]
		
			If ll_filial_sel = 26   Then
				ll_filial_sel = ll_filial_sel
			End If
			
			If Not of_filial_cadastrada_scanntech(ll_filial_sel) Then
				Continue
			End If			
		
		 	lb_retorno = of_preparar_dados_envio_vendas_lote(ldh_movim_caixa,ll_filial_sel,is_chave_movimento, ref ls_erro) 
			
		 	If lb_retorno = False Then
				gvo_aplicacao.of_grava_log("Erro ao preparar dados para o Envio de Vendas ou n$$HEX1$$e300$$ENDHEX$$o existe dados para a Filial: " + String(ll_filial_sel) + " - Data: " + String(ldh_movim_caixa,"dd/mm/yyyy"))
				Continue
		 	End If
		
		    If il_row > 0 Then
				// Decrementa 1 para ficar processando a filial at$$HEX1$$e900$$ENDHEX$$ acabar
				ll_cont_ate = ll_cont_ate - 1
			End If
		
		  	If Not IsValid(w_aguarde) then
				Open(w_aguarde)
		  	End If	
		  
		  	w_aguarde.Title = "Envio Scanntech:"
		  	w_aguarde.uo_progress.of_reset()
		  	w_aguarde.uo_progress.Of_SetMax(il_row + il_qt_cancelada )		
		
		  	ll_valida_controle_caixa = 1
		  
		  	is_json = ''
		
		  	For ll_cont = 1 To il_row
		
				ll_filial               	= ids_ge538_envio_vendas_lote.object.cd_filial[ll_cont]
			  	ls_dh_mov_caixa  	= ids_ge538_envio_vendas_lote.object.dh_movimentacao_caixa[ll_cont]
			  	ll_nr_nf               	=  ids_ge538_envio_vendas_lote.object.nr_nf[ll_cont]  
			  	ls_de_especie      	=  ids_ge538_envio_vendas_lote.object.de_especie[ll_cont]
			  	ls_de_serie          	=  ids_ge538_envio_vendas_lote.object.de_serie[ll_cont] 
			  	ls_total                	=  ids_ge538_envio_vendas_lote.object.total[ll_cont] 
			  	ls_tp_pagamento  	=  ids_ge538_envio_vendas_lote.object.codigoTipoPago[ll_cont] 
			  	ls_importe            =  ids_ge538_envio_vendas_lote.object.importe[ll_cont] 
			  	ld_desconto          =  ids_ge538_envio_vendas_lote.object.pc_desconto[ll_cont] 
			  	ld_vl_total_prod    =  ids_ge538_envio_vendas_lote.object.vl_total_produtos[ll_cont]  
			  	ld_vl_total_nf       	= ids_ge538_envio_vendas_lote.object.vl_total_nf[ll_cont]
			  	ldh_cancelado      	= ids_ge538_envio_vendas_lote.object.dh_cancelamento[ll_cont]  
		
			  	// Todos s$$HEX1$$e300$$ENDHEX$$o atualizados com Sucesso, ao retorna algum com erro $$HEX1$$e900$$ENDHEX$$ atualizado somente o que estiver com erro.
			  	// ids_ge538_envio_vendas_lote.object.id_situacao[ll_cont] = 'S'
			 	w_aguarde.Title   = "Envio Scanntech: Bloco:"+String(pl_bloco)+"->Loja:"  + String(ll_filial)  + "->Nro:" + String(ll_cont)+" De:"+String(il_row)
			
			 	If ll_valida_controle_caixa = 1 Then
					lb_ret = of_buscar_controle_caixa_lote( ll_filial , ldh_data_1,ldh_data_2, ll_nr_cont_caixa , ref ls_erro )
			
					If lb_ret = False Then
				  		gvo_aplicacao.of_grava_log("Erro ao gerar o numero do caixa. "  + "Data: " + ls_dh_mov_caixa + " Filial: " + string(ll_filial)  )
				  		Continue
					End If	 
				
				 	// Buscar URL e Montar
				  	// 'UEV' = Url Envio Vendas
				  	If gvo_aplicacao.ivs_datasource = 'homologa' then
						lb_ret = of_buscar_url_envio_vendas_lote('UHEV', string(ll_filial),ll_nr_cont_caixa,ls_url,'P', ref ls_erro)  
						If Not lb_ret Then
							gvo_aplicacao.of_grava_log( ls_erro +" - "  + "Data: " + ls_dh_mov_caixa + " Filial: " + string(ll_filial)  )
							// Registra e deixa continuar para pegar o erro envio
						End If	
				  	Else
						lb_ret = of_buscar_url_envio_vendas_lote('UPEV', string(ll_filial),ll_nr_cont_caixa,ls_url,'P', ref ls_erro)  
						If Not lb_ret Then
							gvo_aplicacao.of_grava_log( ls_erro +" - "  + "Data: " + ls_dh_mov_caixa + " Filial: " + string(ll_filial)  )
							// Registra e deixa continuar para pegar o erro envio
						End If	
				  	End If	
				  	// Quando mudar de filial, retorna para 1, para n$$HEX1$$e300$$ENDHEX$$o ficar buscando para todas as notas da mesma filial
				 	ll_valida_controle_caixa = 0	 
			  	End If
			 
			  	If ll_cont = 299 Then
					ll_cont = 299 
				End If	
		
			  	lb_ret = of_gera_arquivo_venda_lote(ls_dh_mov_caixa,ldh_cancelado,ll_nr_nf,ls_total,ls_tp_pagamento,ls_importe,ll_filial,ls_de_especie,ls_de_serie,ld_desconto,ld_vl_total_prod,ls_json, ref ls_erro)
	
		
			  	// VerIfica se $$HEX1$$e900$$ENDHEX$$ uma nota cancelada e gera a replica positiva dela
			 	If lb_ret = false then
					gvo_aplicacao.of_grava_log( ls_erro + " Data: " + ls_dh_mov_caixa + " Filial: " + string(ll_filial) )		
					Continue	
			 	Else
					ll_json = 1
					 
					// VerIfica se $$HEX1$$e900$$ENDHEX$$ JSON de Cancelamento e cria a replica dele como positivo
					ll_json_cancelado = Pos( ls_json , '"numero": "')
					ls_negativo          = Mid( ls_json , ll_json_cancelado + 11, 1 ) 
				
					If ls_negativo = '-' then
						If Not of_gerar_replica_nf_lote(ls_json,ls_replica,ll_json_cancelado, ref ls_erro) Then
							gvo_aplicacao.of_grava_log(ls_erro + " - " + "Data: " + ls_dh_mov_caixa + " Filial: " + string(ll_filial) + " Nota: " +   String (ll_nr_nf) )					
						End If	
						// Conta a perna gerada para nota cancelada, limitado em 300 por lote
						If ll_cont = il_row then	
					  		is_json = is_json + ls_json + ' , ' + ls_replica			
						Else	  
					 		is_json = is_json + ls_json + ' , ' +  ls_replica + ' , ' 
						End If	
					Else	
				
					If ll_cont = il_row then	
						is_json = is_json + ls_json			
					Else
						is_json = is_json + ls_json + ' , ' 				
				 	End If
			  	End If	
			End If
			
			ls_json_lote = ls_json_lote + '~n' + is_json
		
			is_json = ''
			
			If ll_cont = il_row then
			  
				ls_json_lote = ' [ ' + ls_json_lote + ' ] ' 
				ls_json = ls_json_lote 	
					 // Loop at$$HEX1$$e900$$ENDHEX$$ finalizar blco
				ll_valida_controle_caixa = 1 
					
				If of_retira_caracteres(ls_json,ls_erro) Then
				  gvo_aplicacao.of_grava_log( ls_erro + "Data: " + ls_dh_mov_caixa + " Filial: " + string(ll_filial) )	 
				End if		
			
				// Insere um evento de fechamento diario ------------------------------------------------------------------------------------------------------------------------------------
				lb_ret = of_atualiza_evento_fechamento('F','Evento de Fechamento Di$$HEX1$$e100$$ENDHEX$$rio',ll_filial,'P',ll_nr_cont_caixa,DateTime(Date(ls_dh_mov_caixa)), ref ls_erro)
			
				If lb_ret = false then
					gvo_aplicacao.of_grava_log( ls_erro + " - " + "Data: " + ls_dh_mov_caixa + " Filial: " + string(ll_filial)  )	
					Continue 
				End If
			
			  	lb_ret = of_autenticar_api_scanntech_lote('POST',ls_url,ls_json,ls_key,true,false, ref ls_json_retorno, ref ls_erro, ref ll_codigo_erro)
				
				// tirar - para teste sem enviar
			    // lb_ret= true
			
				ls_json_lote = ''
				ls_json = ''	
			
				// Atualizando o registro do POST enviado
				If lb_ret then
					
				 	// Sucesso do Envio
					lb_ret = of_leitura_retorno_json_enviado_lote(ls_json_retorno, 'S' , ls_id_lote,ldh_data_1,ldh_data_2, ids_ge538_envio_vendas_lote, is_chave_movimento, ref ls_erro )
					
					If lb_retorno = false then
				  		gvo_aplicacao.of_grava_log("Erro ao retorna idLote enviado em Lotes sem erros. "  + "Data: " + ls_dh_mov_caixa + " Filial: " + string(ll_filial) )
				  		Continue
					End If  
						 
					lb_ret = of_atualiza_total_lote(is_chave_movimento, ls_id_lote, ldh_data_1,ldh_data_2, ids_ge538_envio_vendas_lote, ref ls_erro )	
				
					If lb_retorno = false then
						gvo_aplicacao.of_grava_log("Erro ao atualizar notas v$$HEX1$$e100$$ENDHEX$$lidas em Lotes sem erros. "  + "Data: " + ls_dh_mov_caixa + " Filial: " + string(ll_filial))
						Continue
					End If 
			  	Else	 
				
					If Mid(ls_erro,1,14) <> 'ScannTechErro' Then
				
						ls_id_lote = ''
					
						// Se n$$HEX1$$e300$$ENDHEX$$o retorna um id_lote, entra nesse primeiro erro.
						of_leitura_retorno_json_enviado_lote(ls_json_retorno, 'S' , ls_id_lote,ldh_data_1,ldh_data_2, ids_ge538_envio_vendas_lote, is_chave_movimento, ref ls_erro  )
					
						If  IsNull(ls_id_lote) or ls_id_lote = '' Then
							// Lote $$HEX1$$e900$$ENDHEX$$ branco porque o tipo de erro que n$$HEX1$$e300$$ENDHEX$$o retorna valor algum de lote	
							lb_ret = of_atualiza_envio_vendas_erro_lote(is_chave_movimento, ldh_data_1,ldh_data_2,ids_ge538_envio_vendas_lote,'', ref ls_erro)	
							If lb_retorno = false then
						 		gvo_aplicacao.of_grava_log( ls_erro  + "Data: " + ls_dh_mov_caixa + " Filial: " + string(ll_filial))
						 		Continue
					  		End If 	
						Else
							// Insere o erro do envio do JSON	
							// a variavel ll_lote s$$HEX1$$f300$$ENDHEX$$ ser$$HEX1$$e100$$ENDHEX$$ preenchida no retorno do sucesso do lote na fun$$HEX2$$e700e300$$ENDHEX$$o acima.
							lb_retorno = of_leitura_retorno_json_enviado_lote(ls_json_retorno, 'E' , ls_id_lote, ldh_data_1,ldh_data_2, ids_ge538_envio_vendas_lote, is_chave_movimento, ref ls_erro)
							If lb_retorno = false then
						  		gvo_aplicacao.of_grava_log( ls_erro  + "Data: " + ls_dh_mov_caixa + " Filial: " + string(ll_filial))
						  		Continue
							End If 
					 	End If
				  	End If
				End If
			End If	 
			
			w_aguarde.uo_progress.Of_SetProgress(ll_cont)	
		  Next	
		Next
		
	//	If pl_bloco =  il_qtd_bloco_filial Then
			// F - Final processamento
			// V - Vendas
			If Not of_atualiza_processamento(ldh_movim_caixa,'V','F',pl_bloco) Then
				gvo_aplicacao.of_grava_log("Erro ao validar datas Processamento!")
				Destroy lds_ge538_selecao_filial
				Destroy ids_ge538_envio_vendas_lote
				Return False
			End If	
	//	End If		
	Next
GarbageCollectSetTimeLimit(0)
GarbageCollect()

Catch (RunTimeError lo_error)
	 Destroy (ids_ge538_envio_vendas_lote)
	 Destroy (lds_ge538_selecao_filial)
	 Return False
	 gvo_aplicacao.of_grava_log("Erro no processo Scanntech:"  + "Data: " + ls_dh_mov_caixa)
Finally
	Close(w_Aguarde)
	Destroy (ids_ge538_envio_vendas_lote)
	Destroy (lds_ge538_selecao_filial)
End Try	
	
Return True


end function

public function boolean of_liberar_registro_processamento_lote (long pl_cd_filial[], datetime pdh_periodo1, datetime pdh_periodo2);
UPDATE log_exportacao_scanntech
   SET cd_chave_movimento = null
     , id_lote = null
 WHERE cd_filial BETWEEN :pl_cd_filial[1] AND :pl_cd_filial[2]
   AND dh_movimentacao_caixa BETWEEN :pdh_periodo1 AND :pdh_periodo2
	AND cd_chave_movimento IS NOT NULL
	AND id_situacao = 'P';

if sqlca.sqlcode = -1 then
   gvo_aplicacao.of_Grava_Log("Aten$$HEX2$$e700e300$$ENDHEX$$o - Erro ao alterar CHAVE/LOTE do Envio de Vendas. " + sqlca.sqlerrtext)
   SqlCa.of_rollback( ); 
   Return False
end if	  

SqlCa.of_commit( ); 	 

Return True
end function

public function boolean of_buscar_controle_caixa_lote (long pl_cd_filial, datetime pdh_data_1, datetime pdh_data_2, ref long pl_nr_controle_caixa, ref string ps_erro);/*-- ============================================================
--        Author: Saulo Braga
-- Create date: 20/10/2021
--  Description: Retorna o numero do controle do caixa para montar URL de envio.

-- ============================================================  */

String ls_cd_caixa

ls_cd_caixa =  trim(Fill('0',  4 - Len(String(pl_cd_filial)) ) +  String(pl_cd_filial) + '00')

 SELECT top 1 nr_controle_caixa
    INTO :pl_nr_controle_caixa
  FROM controle_caixa  noholdlock                                             
 WHERE dh_movimentacao_caixa BETWEEN :pdh_data_1 AND :pdh_data_2 
     AND cd_caixa =: ls_cd_caixa
order by nr_controle_caixa desc	  ; 

choose case Sqlca.Sqlcode
	case -1
		ps_erro = 'Erro ao acessar a tabela de Controle Caixa.'	
         Return false
	case 100
		ps_erro = 'Controle de Caixa n$$HEX1$$e300$$ENDHEX$$o retornado, todas as notas dessa FILIAL n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ enviada.'	
         Return false
end choose
	  
	  
if SQLCA.SQLCODE = 100 then
  ps_erro = 'Controle de Caixa n$$HEX1$$e300$$ENDHEX$$o retornado, todas as notas dessa FILIAL n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ enviada...'	
  return false 	
end if	  
	  
return true	  
end function

public function boolean of_reprocessa_envio_vendas (datetime pdh_mov_caixa, long pl_cd_filial, long pl_nr_nf);
dc_uo_ds_base lds_ge538_envio_venda

Date dh_movimentacao_caixa

Datetime ldh_cancelado

Datetime ldh_data_1, ldh_data_2

Dec{2} ld_desconto, ld_vl_total_prod, ld_total_cancelado, ld_vl_total_vendas, ld_vl_total_nf

String ps_erro, ls_de_especie, ls_de_serie, ls_tipo_envio, ls_dh_mov_caixa,ls_total,ls_tp_pagamento, ls_importe, ls_json, ls_url, ls_replica, ls_negativo, ls_key, ls_json_retorno, ls_erro, ls_id_cancelado

Long ll_row, ll_cont, ll_filial, ll_nr_nf, ll_row_item, ll_nr_cont_caixa, ll_json_cancelado, ll_json, ll_cont_json, ll_codigo_erro, ll_qt_cancelados, ll_qt_vendas, ll_valida_controle_caixa

Boolean lb_ret

Garbagecollect()

Try

  ldh_data_1 =  DateTime(String(Date(pdh_mov_caixa)) + ' 00:00:00.000')
  ldh_data_2 =  DateTime(String(Date(pdh_mov_caixa)) + ' 23:59:59.000')

  if IsValid(lds_ge538_envio_venda) then
	Destroy lds_ge538_envio_venda
  end if
		
  lds_ge538_envio_venda          = Create dc_uo_ds_base
		
 If Not lds_ge538_envio_venda.of_ChangeDataObject( 'ds_ge538_log_reprocessa_envio_venda' , False) Then 
	gvo_aplicacao.of_grava_log("Erro ao retornar dados do LOG de Envio de Vendas")
	Destroy lds_ge538_envio_venda
	Return False
  End If		

  lds_ge538_envio_venda.retrieve(ldh_data_1,ldh_data_2,pl_cd_filial,pl_nr_nf)
	
  ll_row = lds_ge538_envio_venda.rowcount()	

  ll_valida_controle_caixa = 1	
 
//  If Not IsValid(w_aguarde) then
//	Open(w_aguarde)
//  End If	
//		
//  w_aguarde.Title = "Processo Envio Scanntech.."
//  w_aguarde.uo_progress.of_reset()
//  w_aguarde.uo_progress.Of_SetMax(ll_row)		
	
  For ll_cont = 1 To ll_row
	

      ll_filial                 = lds_ge538_envio_venda.object.cd_filial[ll_cont]
		
	 if ll_filial = 454 then
		ll_filial = 454
	end if
		
      ls_dh_mov_caixa  =  lds_ge538_envio_venda.object.dh_movimentacao_caixa[ll_cont]
	  //w_aguarde.Title = "Envio Scanntech da Loja:"  + String(ll_filial)  + "- Nro:" + String(ll_cont)+" De:"+String(ll_row)				

    lb_ret = of_buscar_controle_caixa_lote( ll_filial , ldh_data_1,ldh_data_2, ll_nr_cont_caixa , ref ls_erro )
	
	if lb_ret = false then
	    lb_ret = of_buscar_controle_caixa_lote( ll_filial , ldh_data_1,ldh_data_2, ll_nr_cont_caixa , ref ls_erro )
       continue
    end if		

	
	// Quando mudar de filial, retorna para 1, para n$$HEX1$$e300$$ENDHEX$$o ficar buscando para todas as notas da mesma filial
	ll_valida_controle_caixa = 0
	
	
	ls_tipo_envio       =  lds_ge538_envio_venda.object.id_tipo_envio[ll_cont]
     ll_nr_nf               =  lds_ge538_envio_venda.object.nr_nf[ll_cont]  
     ls_de_especie      =  lds_ge538_envio_venda.object.de_especie[ll_cont]
     ls_de_serie          =  lds_ge538_envio_venda.object.de_serie[ll_cont] 
     ls_dh_mov_caixa  =  lds_ge538_envio_venda.object.dh_movimentacao_caixa[ll_cont] 
     ls_total                =  lds_ge538_envio_venda.object.total[ll_cont] 
     ls_tp_pagamento  =  lds_ge538_envio_venda.object.codigoTipoPago[ll_cont] 
     ls_importe            =  lds_ge538_envio_venda.object.importe[ll_cont] 
     ld_desconto          =  lds_ge538_envio_venda.object.pc_desconto[ll_cont] 
     ld_vl_total_prod    =  lds_ge538_envio_venda.object.vl_total_produtos[ll_cont]  
     ld_vl_total_nf        = lds_ge538_envio_venda.object.vl_total_nf[ll_cont]
	ldh_cancelado     = lds_ge538_envio_venda.object.dh_cancelado[ll_cont]  
    
  
     // Buscar URL e Montar
     // 'UEV' = Url Envio Vendas
    if gvo_aplicacao.ivs_datasource = 'homologa' then
       	lb_ret = of_buscar_url_envio_vendas_lote('UHEV', string(ll_filial),ll_nr_cont_caixa,ls_url,'R', ref ls_erro)  
		If Not lb_ret Then
			gvo_aplicacao.of_grava_log( ls_erro + " - " + "Data: " + ls_dh_mov_caixa + " Filial: " + string(ll_filial)  )	
              //  Registra o erro que n$$HEX1$$e300$$ENDHEX$$o tem filial cadastrada e segue para pega o erro do envio
		End If
    else
       	lb_ret = of_buscar_url_envio_vendas_lote('UPEV', string(ll_filial),ll_nr_cont_caixa,ls_url,'R', ref ls_erro)  
		If Not lb_ret Then
			gvo_aplicacao.of_grava_log( ls_erro + " - " + "Data: " + ls_dh_mov_caixa + " Filial: " + string(ll_filial)  )	
 			//continue  Registra o erro que n$$HEX1$$e300$$ENDHEX$$o tem filial cadastrada e segue para pega o erro do envio
		End If		 
    end if	


	lb_ret = of_gera_arquivo_venda_lote(ls_dh_mov_caixa,ldh_cancelado,ll_nr_nf,ls_total,ls_tp_pagamento,ls_importe,ll_filial,ls_de_especie,ls_de_serie,ld_desconto,ld_vl_total_prod,ls_json, ref ls_erro) 
	
	
	if Not lb_ret then
		gvo_aplicacao.of_grava_log( ls_erro + " - " + "Data: " + ls_dh_mov_caixa + " Filial: " + string(ll_filial)  )	
	   	lb_ret = of_atualiza_evento_venda_lote('V','Erro ao validar o JSON',ll_filial,ll_nr_nf,ls_de_especie,ls_de_serie,'P', ref ls_erro)
	  	If Not lb_ret Then
	  		gvo_aplicacao.of_grava_log(ls_erro)
		End If
	   continue	
    else
		ll_json = 1
		    
		// Verifica se $$HEX1$$e900$$ENDHEX$$ JSON de Cancelamento e cria a replica dele como positivo
		ll_json_cancelado = Pos( ls_json , '"numero": "')
		ls_negativo = Mid( ls_json , ll_json_cancelado + 11, 1 ) 
	   
	     If ls_negativo = '-' Then
		    If Not of_gerar_replica_nf_lote(ls_json,ls_replica,ll_json_cancelado, ref ls_erro ) Then
				gvo_aplicacao.of_grava_log(ls_erro + " - " + "Data: " + ls_dh_mov_caixa + " Filial: " + string(ll_filial) + " Nota: " +   String (ll_nr_nf) )
				// Deixa continuar para registrar a diferen$$HEX1$$e700$$ENDHEX$$a, caso tiver.
	      	End If	
		    ll_json = 2
		End If
				
		for ll_cont_json = 1 to ll_json
			lb_ret = of_autenticar_api_scanntech_lote('POST',ls_url,ls_json,ls_key,true,false, ref ls_json_retorno, ref ls_erro, ref ll_codigo_erro)
			if ll_json = 2 then
			 ls_json = ls_replica  	
			end if	
		next
		
		// Atualizando o registro do POST enviado
		  if lb_ret then
			  // Sucesso do Envio	
			 lb_ret = of_atualiza_evento_venda_lote('V','',ll_filial,ll_nr_nf,ls_de_especie,ls_de_serie,'S', ref ls_erro)	
			 If Not lb_ret Then
		  		gvo_aplicacao.of_grava_log(ls_erro)
			End If
		 else	 
			// Insere o erro do envio do JSON	
			 lb_ret = of_atualiza_evento_venda_lote('V',ls_erro,ll_filial,ll_nr_nf,ls_de_especie,ls_de_serie,'P', ref ls_erro)
			 If Not lb_ret Then
		  		gvo_aplicacao.of_grava_log(ls_erro)
			 End If
		 end if
		
		 If  ll_row = ll_cont then 
			
			ll_valida_controle_caixa = 1	
			  // Insere um evento de fechamento diario ------------------------------------------------------------------------------------------------------------------------------------
			lb_ret = of_atualiza_evento_fechamento('F','Evento de Fechamento Di$$HEX1$$e100$$ENDHEX$$rio',ll_filial,'P',ll_nr_cont_caixa,DateTime(Date(ls_dh_mov_caixa)), ref ls_erro)

			If not lb_ret Then
				gvo_aplicacao.of_grava_log( ls_erro + " - " + "Data: " + ls_dh_mov_caixa + " Filial: " + string(ll_filial)   )	
			End If 

		elseif 	ll_cont < ll_row then 
			if (  ll_filial = lds_ge538_envio_venda.object.cd_filial[ll_cont + 1 ]  and + &
			   Date(lds_ge538_envio_venda.object.dh_movimentacao_caixa[ll_cont]) <> Date(lds_ge538_envio_venda.object.dh_movimentacao_caixa[ll_cont + 1])  ) OR +&
			   (  ll_filial <> lds_ge538_envio_venda.object.cd_filial[ll_cont + 1 ]  and + &
			   Date(lds_ge538_envio_venda.object.dh_movimentacao_caixa[ll_cont]) <> Date(lds_ge538_envio_venda.object.dh_movimentacao_caixa[ll_cont + 1]) ) OR +&
				(  ll_filial <> lds_ge538_envio_venda.object.cd_filial[ll_cont + 1 ]  and + &
			   Date(lds_ge538_envio_venda.object.dh_movimentacao_caixa[ll_cont]) = Date(lds_ge538_envio_venda.object.dh_movimentacao_caixa[ll_cont + 1])  )then
			  			
			   // Insere um evento de fechamento diario ------------------------------------------------------------------------------------------------------------------------------------
			   lb_ret = of_atualiza_evento_fechamento('F','Evento de Fechamento Di$$HEX1$$e100$$ENDHEX$$rio',ll_filial,'P',ll_nr_cont_caixa,DateTime(Date(ls_dh_mov_caixa)), ref ls_erro)
				
			   If not lb_ret Then
				 gvo_aplicacao.of_grava_log( ls_erro + " - " + "Data: " + ls_dh_mov_caixa + " Filial: " + string(ll_filial)  )	
  			   End If 	
			
			end if
	    end if
    end if
	

	
	ls_json = ''
	ls_replica = ''
	//w_aguarde.uo_progress.Of_SetProgress(ll_cont)					
Next

Catch (RunTimeError lo_error)
	ps_erro = lo_error.GetMessage( )
	Return False
Finally
	 // Close(w_Aguarde)
End Try	


return true
end function

public function boolean of_processa_fechamento_diario (date pdh_data_processamento);long ll_row, ll_cont, ll_codigo_erro, ll_filial, ll_nr_nf, ll_existe_erro
long ll_row_fech, ll_cont_fech, ll_cd_filial, ll_cont_proc

boolean lb_ret

Date  dh_movimentacao_caixa 
DateTime data_1, data_2, ldh_fechaventas, dh_data1, dh_data2

long ll_cantidadmovimientos, ll_cantidadcancelaciones, ll_nr_controle_caixa

String ls_data_processamento[]
String ls_montoventaliquida,  ls_montocancelaciones

string ls_json, ls_url, ls_key, ls_json_retorno, ls_erro, ls_de_especie, ls_de_serie

dc_uo_ds_base  lds_ge538_fechamento_diario
dc_uo_ds_base  lds_ge538_sel_fechamento_diario

if IsValid(lds_ge538_fechamento_diario) then Destroy lds_ge538_fechamento_diario
if IsValid(lds_ge538_sel_fechamento_diario) then Destroy lds_ge538_sel_fechamento_diario

lds_ge538_fechamento_diario     = Create dc_uo_ds_base	
lds_ge538_sel_fechamento_diario = Create dc_uo_ds_base	

Try

	If Not of_processamento_atrasado(pdh_data_processamento,'F',ls_data_processamento[], 0 ) Then
		gvo_aplicacao.of_grava_log("Erro ao validar datas Processamento!")
		Destroy lds_ge538_fechamento_diario
		Destroy lds_ge538_sel_fechamento_diario
		Return False
	End  If

	For ll_cont_proc = 1 To UpperBound(ls_data_processamento)
				
		pdh_data_processamento = Date(ls_data_processamento[ll_cont_proc])
	
		// Movimento Venda estiver aberto ainda, o processamento n$$HEX1$$e300$$ENDHEX$$o inicia	
		If Not of_valida_processamento_venda(pdh_data_processamento) Then
			Continue
         End If
	
	     // 0 - Zero significa o bloco do fechamento na tabela  LOG_SCANNTECH_PROC
	  	If Not of_atualiza_processamento(pdh_data_processamento,'F','I', 0 ) Then
			gvo_aplicacao.of_grava_log("Erro ao validar datas Processamento!")
			Destroy lds_ge538_fechamento_diario
			Destroy lds_ge538_sel_fechamento_diario
			Return False
		End If


		If Not lds_ge538_fechamento_diario.of_ChangeDataObject( 'ds_ge538_log_fechamento' , False) Then 
		 	gvo_aplicacao.of_grava_log("Erro ao retornar dados do LOG de Fechamento")
		 	Destroy lds_ge538_fechamento_diario
		 	Destroy lds_ge538_sel_fechamento_diario
		 	Return False
		End If		

		If Not lds_ge538_sel_fechamento_diario.of_ChangeDataObject( 'ds_ge538_sel_log_fechamento' , False) Then 
		 	gvo_aplicacao.of_grava_log("Erro ao retornar dados da sele$$HEX2$$e700e300$$ENDHEX$$o de filial para processar.")
		 	Destroy lds_ge538_sel_fechamento_diario 
		 	Return False
		End If	

	   	dh_data1 = DateTime(String(pdh_data_processamento) + ' 00:00:00.000')
   		dh_data2 = DateTime(String(pdh_data_processamento) + ' 23:59:59.000') 

   		ll_row_fech = lds_ge538_sel_fechamento_diario.retrieve(dh_data1,dh_data2)
	
		If Not IsValid(w_aguarde) then
			Open(w_aguarde)
		End If	
		
		w_aguarde.Title = "Processo Fechamento Scanntech.."
		w_aguarde.uo_progress.of_reset()
		w_aguarde.uo_progress.Of_SetMax(ll_row_fech )			
		
		for ll_cont_fech = 1 to ll_row_fech
			
			ll_cd_filial        = lds_ge538_sel_fechamento_diario.object.cd_filial[ll_cont_fech]
			dh_movimentacao_caixa = Date(lds_ge538_sel_fechamento_diario.object.dh_movimentacao_caixa[ll_cont_fech])
		
			data_1 =  DateTime(String(dh_movimentacao_caixa) + ' 00:00:00.000')
        	data_2 =  DateTime(String(dh_movimentacao_caixa) + ' 23:59:59.000')

 	    	ll_row = lds_ge538_fechamento_diario.retrieve(ll_cd_filial,data_1,data_2)
    		w_aguarde.Title   = "Envio Scanntech da Loja:"  + String(ll_cd_filial)  + "- Nro:" + String(ll_cont_fech)+" De:"+String(ll_row_fech)
			 
			for ll_cont = 1 to ll_row	
				
				ll_filial                = lds_ge538_fechamento_diario.object.cd_filial[ll_cont]
		   	ls_montoventaliquida     = lds_ge538_fechamento_diario.object.montoventaliquida[ll_cont]
		   	ls_montocancelaciones    = lds_ge538_fechamento_diario.object.montocancelaciones[ll_cont]
		   	ll_cantidadmovimientos   = lds_ge538_fechamento_diario.object.cantidadmovimientos[ll_cont]
		   	ldh_fechaventas          = lds_ge538_fechamento_diario.object.fechaventas[ll_cont]
		   	ll_cantidadcancelaciones = lds_ge538_fechamento_diario.object.cantidadcancelaciones[ll_cont]
		  
	         lb_ret = of_buscar_controle_caixa_lote( ll_filial , data_1, data_2, ll_nr_controle_caixa , ref ls_erro )
				
				If lb_ret = False then
					lb_ret = of_atualiza_evento_fechamento('F','Erro por n$$HEX1$$e300$$ENDHEX$$o encontrar CONTROLE de CAIXA para o Fechamento Di$$HEX1$$e100$$ENDHEX$$rio',ll_filial,'P',ll_nr_controle_caixa,DateTime(dh_movimentacao_caixa), ref ls_erro)
					gvo_aplicacao.of_grava_log( ls_erro + " - " + "Data: " + String(dh_movimentacao_caixa,"dd/mm/yyyy") + " Filial: " + string(ll_filial) )				
			 		Exit	
				End if	
		  
		 		If Not of_gera_arquivo_fechamento(ls_montoventaliquida,ls_montocancelaciones,Date(ldh_fechaventas),ll_cantidadmovimientos,ll_cantidadcancelaciones, ls_json, ref ls_erro ) Then 
		 			gvo_aplicacao.of_grava_log( ls_erro + " - " + "Data: " + String(dh_movimentacao_caixa,"dd/mm/yyyy") + " Filial: " + string(ll_filial)  )	
			 		continue
	     		End If
		 
		 		Select count(1)
				   Into :ll_existe_erro
		  		 From log_exportacao_scanntech
		         Where cd_filial =:ll_filial
			 		And id_tipo_envio = 'V'
			 		And id_situacao = 'S'
					And dh_movimentacao_caixa =:ldh_fechaventas;
			
				If ll_existe_erro = 0 Then
					gvo_aplicacao.of_grava_log( "Para o envio do Fechamento, a nota de envio dever$$HEX1$$e100$$ENDHEX$$ estar com a situa$$HEX2$$e700e300$$ENDHEX$$o igual a 'S'. " + " - " + &
			    			                                      "Data: " + String(dh_movimentacao_caixa,"dd/mm/yyyy") + " Filial: " + string(ll_filial)  )	
					continue
				End If	
		 
		 		Select count(1)
				  Into :ll_existe_erro
		  		  From log_exportacao_scanntech
			    Where cd_filial =:ll_filial
			  	   And id_tipo_envio = 'F'
			      And id_situacao = 'P'
				   And dh_movimentacao_caixa =:ldh_fechaventas;
			
				If ll_existe_erro = 0 Then
					gvo_aplicacao.of_grava_log( "N$$HEX1$$e300$$ENDHEX$$o existe um evento de Fechamento, verifique o que ocorreu no envio das Vendas" + " - " + &
			      			                                  "Data: " + String(dh_movimentacao_caixa,"dd/mm/yyyy") + " Filial: " + string(ll_filial)  )	
					continue
				End If	
		 
		 		// Buscar URL
				// 'UHVP' = Url Verificar Promo$$HEX2$$e700f500$$ENDHEX$$es Homologa$$HEX2$$e700e300$$ENDHEX$$o
				If gvo_aplicacao.ivs_datasource = 'homologa' Then
					of_buscar_url_fechamento_diario('UHFD',string(ll_filial),ll_nr_controle_caixa,ls_url, ref ls_erro)
		  			If Not lb_ret Then
						gvo_aplicacao.of_grava_log( ls_erro + " - " + "Data: " + String(dh_movimentacao_caixa,"dd/mm/yyyy") + " Filial: " + string(ll_filial)  )	
						// Registra e deixa continuar para pegar o erro envio
					End If
				Elseif gvo_aplicacao.ivs_datasource <> 'homologa' then
					of_buscar_url_fechamento_diario('UPFD',string(ll_filial),ll_nr_controle_caixa,ls_url, ref ls_erro)
					if Not lb_ret Then
						gvo_aplicacao.of_grava_log( ls_erro + " - " + "Data: " + String(dh_movimentacao_caixa,"dd/mm/yyyy") + " Filial: " + string(ll_filial)  )	
						// Registra e deixa continuar para pegar o erro envio
					End If
				End if
	  		 
				If ll_existe_erro > 0 then
					lb_ret = of_autenticar_api_scanntech_lote('POST',ls_url,ls_json,ls_key,true,false, ref ls_json_retorno, ref ls_erro, ref ll_codigo_erro)
		 			If lb_ret Then
						// Sucesso do Envio	
						lb_ret = of_atualiza_evento_fechamento('F','',ll_filial,'S',ll_nr_controle_caixa,Datetime(ldh_fechaventas), ref ls_erro)
						If Not lb_ret Then
		    				gvo_aplicacao.of_grava_log( ls_erro + " - " + "Data: " + String(dh_movimentacao_caixa,"dd/mm/yyyy") + " Filial: " + string(ll_filial)  )	
 		    			End If 
		 			Else	 
						// Insere o erro do envio do JSON	
						lb_ret = of_atualiza_evento_fechamento('F',ls_erro,ll_filial,'P',ll_nr_controle_caixa,Datetime(ldh_fechaventas), ref ls_erro)	
							if Not lb_ret Then
								gvo_aplicacao.of_grava_log( ls_erro + " - " + "Data: " + String(dh_movimentacao_caixa,"dd/mm/yyyy") + " Filial: " + string(ll_filial)  )	
							end If
		 			End if  
				End if 
			Next	
			w_aguarde.uo_progress.Of_SetProgress(ll_cont_fech)
		Next
		
		// F - Fechamento
		// F - Final processamento
		// 0 - Zero significa o bloco do fechamento na tabela  LOG_SCANNTECH_PROC
		If Not of_atualiza_processamento(pdh_data_processamento,'F','F', 0 ) Then
			gvo_aplicacao.of_grava_log("Erro ao validar datas Processamento!")
			Destroy lds_ge538_sel_fechamento_diario 
   		Destroy lds_ge538_fechamento_diario
			Return False
		End If	
	next
	
Catch (RunTimeError lo_error)
	Close(w_aguarde)
    	 Destroy lds_ge538_sel_fechamento_diario  
	 Destroy lds_ge538_fechamento_diario
 Return False
Finally
   Close(w_aguarde)
   Destroy lds_ge538_sel_fechamento_diario 
   Destroy lds_ge538_fechamento_diario
End Try		

Return true

end function

public function boolean of_atualiza_log_exportacao_scanntech (long pl_cd_filial, long pl_nr_nf, string ps_de_especie, string ps_de_serie, datetime pdh_movimento_caixa, string ps_id_tipo_envio, string ps_id_situacao, string ps_de_erro, decimal pd_desconto, decimal pd_vl_total_produtos, decimal pd_vl_total_nf, string ps_cd_forma_pagamento, datetime pdh_cancelado, decimal pd_vl_desconto_nf, string ps_id_lote, string ps_cd_chave_movimento, ref string ps_erro);Long lvl_nr_atualizacao

String lvs_cd_chave

Datetime ldh_envio

ldh_envio = DateTime(String( Today() , "dd/mm/yyyy ") + String(Now(), "hh:mm"))
  
lvs_cd_chave = String(pl_cd_filial) + '@#!' + string(pl_nr_nf) + '@#!'  + ps_de_especie + '@#!' + ps_de_serie  
 
INSERT INTO log_exportacao_scanntech  
         ( cd_chave,   
           cd_filial,   
           dh_movimentacao_caixa,   
           id_tipo_envio,   
           dh_envio,   
           id_situacao,   
           de_erro,   
           nr_arquivo,   
           nr_nf,   
           de_especie,   
           de_serie,   
           pc_desconto,   
           vl_total_produtos,   
           vl_total_nf,   
           cd_forma_pagamento,   
           dh_cancelado,   
           vl_desconto_nf,   
           id_lote,   
           cd_chave_movimento )  
VALUES (  :lvs_cd_chave
			, :pl_cd_filial
			, :pdh_movimento_caixa
			, :ps_id_tipo_envio
			, :ldh_envio
			, :ps_id_situacao
			, :ps_de_erro
			, null
			, :pl_nr_nf
			, :ps_de_especie
			, :ps_de_serie
			, :pd_desconto
			, :pd_vl_total_produtos
			, :pd_vl_total_nf
			, :ps_cd_forma_pagamento
			, :pdh_cancelado
			, :pd_vl_desconto_nf
			, :ps_id_lote
			, :ps_cd_chave_movimento    )  ;

If Sqlca.Sqlcode = -1 Then
	ps_erro = "Erro ao incluir dados na LOG_EXPORTACAO_SCANNTECH. " + sqlca.sqlerrtext 
	SqlCa.of_rollback( ); 
	Return False
End If

Sqlca.of_commit( );

Return True
end function

public function boolean of_atualiza_total_lote (string ps_cd_chave_movimento, string ps_id_lote, datetime pdh_data_1, datetime pdh_data_2, datastore pds_envio_vendas, ref string ps_erro);

Long lvl_row, lvl_cont, lvl_cd_filial, lvl_nr_nf

Dec{2} lvd_total, lvd_importe, lvd_pc_desconto, lvd_vl_total_produtos, lvd_vl_total_nf, ld_vl_desconto_nf

DateTime ldh_cancelamento

Date ldh_mov_caixa

string lvs_de_especie, lvs_de_serie, lvs_tipo_pagto, ls_erro, lvs_chave_movimento

lvl_row = pds_envio_vendas.rowCount()

For lvl_cont = 1 To lvl_row

	lvl_cd_filial           		= pds_envio_vendas.object.cd_filial[lvl_cont]
	ldh_mov_caixa  		= Date(pds_envio_vendas.object.dh_movimentacao_caixa[lvl_cont])
	lvl_nr_nf					= pds_envio_vendas.object.nr_nf[lvl_cont]
	lvs_de_especie			= pds_envio_vendas.object.de_especie[lvl_cont]
	lvs_de_serie				= pds_envio_vendas.object.de_serie[lvl_cont]
	lvd_total					= Dec(pds_envio_vendas.object.total[lvl_cont])
	lvs_tipo_pagto			= pds_envio_vendas.object.codigotipopago[lvl_cont]	
	lvd_importe				= Dec(pds_envio_vendas.object.importe[lvl_cont])	
	lvd_pc_desconto        = Dec(pds_envio_vendas.object.pc_desconto[lvl_cont])
	lvd_vl_total_produtos	= Dec(pds_envio_vendas.object.vl_total_produtos[lvl_cont])
	lvd_vl_total_nf			= Dec(pds_envio_vendas.object.vl_total_nf[lvl_cont])
	ldh_cancelamento		= pds_envio_vendas.object.dh_cancelamento[lvl_cont]
	ld_vl_desconto_nf		= Dec(pds_envio_vendas.object.vl_desconto_nf[lvl_cont])
	lvs_chave_movimento= pds_envio_vendas.object.cd_chave_movimento[lvl_cont]	
	
	If lvs_chave_movimento <> '' Then
		If Not Of_atualiza_log_exportacao_scanntech(	lvl_cd_filial,					+ &
																	lvl_nr_nf   ,					+ & 
																	lvs_de_especie,			+ & 
																	lvs_de_serie,				+ & 
																	DateTime(ldh_mov_caixa),				+ & 
																	'V',							+ & 
																	'S',							+ & 
																	'',								+ & 
																	lvd_pc_desconto,			+ & 
																	lvd_vl_total_produtos,		+ &  
																	lvd_vl_total_nf,				+ &
																	lvs_tipo_pagto,				+ &
																	ldh_cancelamento,			+ &
																	ld_vl_desconto_nf,			+ &
																	ps_id_lote,					+ &	
																	ps_cd_chave_movimento,	 ref ls_erro )   Then
			ps_erro = "Erro ao incluir dados na tabela LOG_EXPORTACAO_SCANNTECH. " + sqlca.sqlerrtext
			 Return False				
		End If
	End If    	
	
Next 

return true
end function

public function boolean of_atualizar_nota_erro_lote (long pl_nr_nf, datetime pdh_data_1, datetime pdh_data_2, string ps_cd_chave_movimento, datastore pds_envio_vendas, string ps_id_lote, ref string ps_erro);long ll_existe, ll_nr_atualizacao, ll_existe_fechamento

Long lvl_row, lvl_cont, lvl_cd_filial

Dec{2} lvd_total, lvd_importe, lvd_pc_desconto, lvd_vl_total_produtos, lvd_vl_total_nf, ld_vl_desconto_nf

DateTime ldh_cancelamento, ldh_mov_caixa

string lvs_de_especie, lvs_de_serie, lvs_tipo_pagto, ls_erro, lvs_chave_movimento

DateTime ldt_env

lvl_row = pds_envio_vendas.rowCount()

For lvl_cont = 1 To lvl_row

	lvl_cd_filial           		= pds_envio_vendas.object.cd_filial[lvl_cont]
	ldh_mov_caixa  		= pds_envio_vendas.object.dh_movimentacao_caixa[lvl_cont]
	pl_nr_nf					= pds_envio_vendas.object.nr_nf[lvl_cont]
	lvs_de_especie			= pds_envio_vendas.object.de_especie[lvl_cont]
	lvs_de_serie				= pds_envio_vendas.object.de_serie[lvl_cont]
	lvd_total					= pds_envio_vendas.object.total[lvl_cont]
	lvs_tipo_pagto			= pds_envio_vendas.object.codigotipopago[lvl_cont]	
	lvd_importe				= pds_envio_vendas.object.importe[lvl_cont]	
	lvd_pc_desconto        = pds_envio_vendas.object.pc_desconto[lvl_cont]
	lvd_vl_total_produtos	= pds_envio_vendas.object.vl_total_produtos[lvl_cont]
	lvd_vl_total_nf			= pds_envio_vendas.object.vl_total_nf[lvl_cont]
	ldh_cancelamento		= pds_envio_vendas.object.dh_cancelamento[lvl_cont]
	ld_vl_desconto_nf		= pds_envio_vendas.object.vl_desconto_nf[lvl_cont]
	lvs_chave_movimento= pds_envio_vendas.object.cd_chave_movimento[lvl_cont]	
	
	If lvs_chave_movimento  = '' Then
		If Not Of_atualiza_log_exportacao_scanntech(	lvl_cd_filial,					+ &
																	pl_nr_nf   ,					+ & 
																	lvs_de_especie,			+ & 
																	lvs_de_serie,				+ & 
																	ldh_mov_caixa,				+ & 
																	'V',							+ & 
																	'P',								+ & 
																	ps_erro,						+ & 
																	lvd_pc_desconto,			+ & 
																	lvd_vl_total_produtos,		+ &  
																	lvd_vl_total_nf,				+ &
																	lvs_tipo_pagto,				+ &
																	ldh_cancelamento,			+ &
																	ld_vl_desconto_nf,			+ &
																	ps_id_lote,					+ &	
																	ps_cd_chave_movimento,	 ref ls_erro )   Then
			ps_erro = "Erro ao incluir dados na tabela LOG_EXPORTACAO_SCANNTECH. " + sqlca.sqlerrtext
			 Return False				
		End If
	End If    	
	
Next 

return true
end function

public subroutine of_reprocessa_envio_vendas ();uo_ge538_scanntech_lote uo_ge538_reprocessa_envio

dc_uo_ds_base lds_ge538_vendas
lds_ge538_vendas	           = create dc_uo_ds_base

Boolean lb_ret
Date ldh_movim_caixa
DateTime ldh_data_1, ldh_data_2
String lvs_filter

Long lvl_row, lvl_cont, lvl_cd_filial, lvl_nr_nf

Datetime ldh_mov_caixa

If Not lds_ge538_vendas.of_ChangeDataObject( 'ds_ge538_reprocessamento_vendas' , False) Then 
   gvo_aplicacao.of_grava_log("Erro ao retornar dados do LOG de Envio de Vendas")
   Destroy lds_ge538_vendas
   Return 
End If	

ldh_movim_caixa = RelativeDate( Today(), - 1 )  // D - 1

ldh_data_1 =  DateTime(String(ldh_movim_caixa) + ' 00:00:00.000')
ldh_data_2 =  DateTime(String(ldh_movim_caixa) + ' 23:59:59.000')

lds_ge538_vendas.Retrieve( ldh_data_1, ldh_data_2 )

lvl_row = lds_ge538_vendas.rowcount() 

if lvl_row = 0 then
//  Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o existe envio de Vendas para Reprocessar."	)
  gvo_aplicacao.of_grava_log("N$$HEX1$$e300$$ENDHEX$$o existe envio de Vendas para Reprocessar.")
  return	
end if 

if IsValid(uo_ge538_reprocessa_envio) then
  Destroy uo_ge538_reprocessa_envio	
end if

uo_ge538_reprocessa_envio = create uo_ge538_scanntech_lote

If Not IsValid(w_aguarde) then
	Open(w_aguarde)
End If	
		
w_aguarde.Title = "Processo Envio Scanntech.."
w_aguarde.uo_progress.of_reset()
w_aguarde.uo_progress.Of_SetMax(lvl_row)		

For lvl_cont = 1 To lvl_row
	
	// Somente $$HEX1$$e900$$ENDHEX$$ enviado as vendas, o fechamento $$HEX1$$e900$$ENDHEX$$ processado por agendamento.
	If lds_ge538_vendas.object.id_tipo_envio[lvl_cont] = 'V' and lds_ge538_vendas.object.id_situacao[lvl_cont] = 'P' Then
		ldh_mov_caixa		=  lds_ge538_vendas.object.dh_movimentacao_caixa[lvl_cont]
   		lvl_cd_filial			=  lds_ge538_vendas.object.cd_filial[lvl_cont]	
   		lvl_nr_nf				=  lds_ge538_vendas.object.nr_nf[lvl_cont]
	 
	    w_aguarde.Title = "Envio Scanntech da Loja:"  + String(lvl_cd_filial)  + "- Nro:" + String(lvl_cont)+" De:"+String(lvl_row)				
	 
   		lb_ret = uo_ge538_reprocessa_envio.of_reprocessa_envio_vendas(ldh_mov_caixa, lvl_cd_filial, lvl_nr_nf)
 
	
   		If lb_ret = false then
			// Continua o processamento para ir atualizando os status dos movimentos	
	 		continue		
   		End if	
	End If
	w_aguarde.uo_progress.Of_SetProgress(lvl_cont)	
Next

Close(w_Aguarde)

end subroutine

public function boolean of_buscar_bloco_filial_lote (long pl_bloco, ref long pl_bloco_filial[], ref string ps_log);String ls_bloco_filial1		&
        , ls_bloco_filial2		&
	   ,  ls_bloco_filial3 	&
	   ,	  ls_bloco_filial	  	&
	   ,  ls_auxiliar			&
	   ,  ls_bloco[]
		
long ll_cont, ll_pos[], ll_tmh_string
Long ll_qtd_virgulas, ll_pos_virgula, ll_qtd_bloco

//SELECT SUBSTRING(vl_parametro , 1 ,  ( CASE WHEN CHARINDEX(';',vl_parametro) = 3 then 6
//                                               		       ELSE 7 END ) )   bloco1
//         ,  SUBSTRING(vl_parametro , ( CASE WHEN CHARINDEX(';',vl_parametro) = 3 then 8 ELSE 9 END ) , 7 )   bloco2
//         ,  SUBSTRING(vl_parametro ,  ( CASE WHEN CHARINDEX(';',vl_parametro) = 3 then 16 ELSE 17 END ) , 9 ) bloco3
//   INTO :ls_bloco_filial1
//	    ,  :ls_bloco_filial2
//	    ,  :ls_bloco_filial3
//  FROM parametro_geral noholdlock
//WHERE cd_parametro in ( 'ID_FILIAL_SCANNTECH_ENVIO_VENDAS');

SELECT vl_parametro
   INTO :ls_bloco_filial
  FROM parametro_geral noholdlock
WHERE cd_parametro in ( 'ID_FILIAL_SCANNTECH_ENVIO_VENDAS')
Using Sqlca;

choose case Sqlca.Sqlcode 
	case -1
	    ps_log = 'Erro ao acessar a tabela de Par$$HEX1$$e200$$ENDHEX$$metro Geral. ' + sqlca.sqlerrtext	
         Return false
    case 100
		ps_log = 'Aten$$HEX2$$e700e300$$ENDHEX$$o - Filial Scanntech n$$HEX1$$e300$$ENDHEX$$o cadastrada para o parametro - ID_FILIAL_SCANNTECH_ENVIO_VENDAS. ' + sqlca.sqlerrtext	
         Return false
end choose

ll_tmh_string = Len(ls_bloco_filial)

ls_auxiliar = ls_bloco_filial 

For ll_cont = 1 To ll_tmh_string
	
	ll_pos_virgula = Pos(ls_auxiliar,';')
	
	If Pos(ls_auxiliar,';') > 0 Then
		ll_qtd_virgulas++
	Else 	
		ll_qtd_virgulas = 0
	End If	
	
	If ll_qtd_virgulas = 1  Then
		ls_auxiliar = Replace( ls_auxiliar , ll_pos_virgula , 1 , "-")
	Else	
		ll_qtd_bloco++
		If	Pos(ls_auxiliar,'-') > 0 Then
			If Pos(ls_auxiliar,  ';' , Pos(ls_auxiliar,'-') + 1 ) = 0 Then
				ls_bloco[ll_qtd_bloco] = ls_auxiliar
				ls_auxiliar = Mid( ls_auxiliar, Pos(ls_auxiliar,'-') + 1 ,  ll_tmh_string )				
			Else
				ls_bloco[ll_qtd_bloco] = Mid( ls_auxiliar, 1 ,  Pos(ls_auxiliar,';') - 1 )
				ls_auxiliar = Mid( ls_auxiliar, Pos(ls_auxiliar,';') + 1 ,  ll_tmh_string )				
			End If	
		End If	
		ll_qtd_virgulas = 0
	End If
	
	If Pos(ls_auxiliar,';') = 0 And Pos(ls_auxiliar,'-') = 0 Then
		 ll_cont = ll_tmh_string
    End If
Next	

// Separa inicio e o fim do bloco colocando em um vetor de duas posi$$HEX2$$e700f500$$ENDHEX$$es
For ll_cont = 1 To UpperBound(ls_bloco)
	If pl_bloco = ll_cont Then
		pl_bloco_filial[1] = Long(Mid( ls_bloco[ll_cont] , 1 , Pos( ls_bloco[ll_cont] , '-' ) - 1 ))
		pl_bloco_filial[2] = Long(Mid( ls_bloco[ll_cont] ,  Pos( ls_bloco[ll_cont] , '-' ) + 1 , 5 ))
	End If
Next 

// Informa para a fun$$HEX2$$e700e300$$ENDHEX$$o of_processa_bloco_lote, no final dela verficando se $$HEX1$$e900$$ENDHEX$$ o ultimo lote para processar. 
il_qtd_bloco_filial = ll_qtd_bloco 

//// ll_cont identifica a primeira filial e a ultima do bloco.
//for ll_cont = 1 to 2
//   if pl_bloco = 1 then
////	 ll_pos = Pos(ls_bloco_filial,';')	
//	 if ll_cont = 1 then 	
//	   pl_bloco_filial[ll_cont] = Long(MID(ls_bloco_filial1, 1, ll_pos - 1 ))
//	 else
//	   pl_bloco_filial[ll_cont] = Long(MID(ls_bloco_filial1, ll_pos + 1, 3 ))
//	 end if
//   elseif pl_bloco = 2 then
//	 ll_pos = Pos(ls_bloco_filial2,';')	
//	 if ll_cont = 1 then 	
//	   pl_bloco_filial[ll_cont] = Long(MID(ls_bloco_filial2, 1, ll_pos - 1 ))
//	 else
//	   pl_bloco_filial[ll_cont] = Long(MID(ls_bloco_filial2, ll_pos + 1, 3 ))
//	 end if
//   else
//	 ll_pos = Pos(ls_bloco_filial3,';')	
//	 if ll_cont = 1 then 	
//	   pl_bloco_filial[ll_cont] = Long(MID(ls_bloco_filial3, 1, ll_pos - 1 ))
//	 else
//	   pl_bloco_filial[ll_cont] = Long(MID(ls_bloco_filial3, ll_pos + 1, 3 ))
//	 end if
//   end if
//next 

Return true
end function

public function boolean of_atualiza_data_proximo_movimento (datetime dh_proximo_movimento, ref string ps_log);
String lvs_data_parametro

lvs_data_parametro = String(dh_proximo_movimento, "dd/mm/yyyy ") + String(Now(), "hh:mm")

UPDATE  parametro_geral 
      SET vl_parametro =:lvs_data_parametro
where cd_parametro = 'DH_ULTIMO_FECHAMENTO_SCANNTECH';

if sqlca.sqlcode = -1 then
  SqlCa.of_RollBack();
  ps_log = 'Erro ao atualizar a tabela PARAMETRO_GERAL para o parametro - DH_ULTIMO_FECHAMENTO_SCANNTECH. ' + sqlca.sqlerrtext
  Return False
end if
  
Sqlca.of_commit( );

Return True
end function

public function boolean of_atualiza_evento_fechamento (string ps_tipo_envio, string ps_de_erro, long pl_cd_filial, string ps_id_situacao, long pl_nr_controle_caixa, datetime pdh_mov_caixa, ref string ps_log); /*-- ============================================================
--        Author: Saulo Braga
-- Create date: 25/10/2021
--  Description: Atualiza o status do evento de envio ou de fechamento

REGRA : 
-  V = Vendas
   F  = Fechamento

-- ============================================================  */
long ll_existe, ll_nr_atualizacao, ll_existe_fechamento

DateTime ldt_env

String ls_cd_chave, ls_erro

ldt_env = DateTime(String(today(),"DD-MM-YYYY HH:MM:SS"))

SELECT count(1)
  into :ll_existe_fechamento
  FROM log_exportacao_scanntech noholdlock
 WHERE cd_filial             =:pl_cd_filial 
   AND id_tipo_envio         =:ps_tipo_envio
	AND dh_movimentacao_caixa = :pdh_mov_caixa;

if ps_tipo_envio = 'F' and ll_existe_fechamento > 0 then
	
   UPDATE log_exportacao_scanntech
	    SET id_situacao    = :ps_id_situacao
		    , de_erro       = :ps_de_erro
			 , dh_envio      = :ldt_env
      WHERE cd_filial     = :pl_cd_filial 
		  AND id_tipo_envio = :ps_tipo_envio
		  And dh_movimentacao_caixa = :pdh_mov_caixa;	
	
	ls_erro = 'Erro ao atualizar a tabela LOG_EXPORTACAO_SCANNTECH. ' + sqlca.sqlerrtext
	
else 

  // Monta chave	
  ls_cd_chave =  Fill( "0" , 4 - Len(String(pl_cd_filial)) )  + String(pl_cd_filial) + '@#!' + String(pl_nr_controle_caixa) 
   
  INSERT INTO log_exportacao_scanntech 	
            ( cd_chave                        
            , cd_filial                         
            , dh_movimentacao_caixa  
            , id_tipo_envio 	   		      
            , dh_envio                         
            , id_situacao                      
            , de_erro
            , nr_nf
            , de_especie
            , de_serie )
     VALUES ( :ls_cd_chave
            , :pl_cd_filial
            , :pdh_mov_caixa		
		      , :ps_tipo_envio
            , :ldt_env  
		      , :ps_id_situacao
            , :ps_de_erro
            , 0
            , ''
            , '');	
				 
	ls_erro = 'Erro ao incluir dados na tabela LOG_EXPORTACAO_SCANNTECH. ' + sqlca.sqlerrtext			 
				 
end if	

If Sqlca.Sqlcode = -1 Then	
	ps_log = ls_erro    	
   SqlCa.of_RollBack();
   Return False
End If

Sqlca.of_commit( );

Return True
end function

public function boolean of_atualiza_evento_venda_lote (string ps_tipo_envio, string ps_de_erro, long pl_cd_filial, long pl_nr_nf, string ps_de_especie, string ps_de_serie, string ps_id_situacao, ref string ps_log);/*-- ============================================================
--        Author: Saulo Braga
-- Create date: 25/10/2021
--  Description: Atualiza o status do evento de envio ou de fechamento

REGRA : 
-  V = Vendas
   F  = Fechamento

-- ============================================================  */
long ll_existe, ll_nr_atualizacao, ll_existe_fechamento

DateTime ldt_env

ldt_env = DateTime(String(today(),"DD-MM-YYYY HH:MM:SS"))

UPDATE log_exportacao_scanntech
   SET id_situacao   = :ps_id_situacao
     , de_erro       = :ps_de_erro
	  , dh_envio      = :ldt_env
 WHERE cd_filial     = :pl_cd_filial 
   AND nr_nf         = :pl_nr_nf
	AND de_especie    = :ps_de_especie
	AND de_serie      = :ps_de_serie
	AND id_tipo_envio = :ps_tipo_envio;

If Sqlca.Sqlcode = -1 Then	
   ps_log = 'Erro ao atualizar a tabela LOG_EXPORTACAO_SCANNTECH. ' + sqlca.sqlerrtext	
   SqlCa.of_RollBack();
   Return False
End If

Sqlca.of_commit( );

Return True
end function

public function boolean of_atualiza_parcial_lote (datetime pdh_data_1, datetime pdh_data_2, string ps_cd_chave_movimento, string ps_id_lote, ref string ps_log);long ll_existe, ll_nr_atualizacao, ll_existe_fechamento

DateTime ldt_dh_envio


ldt_dh_envio = DateTime(String(today(),"DD-MM-YYYY HH:MM:SS"))

// Atualiza as notas bem sucedidas....
UPDATE log_exportacao_scanntech
      SET id_lote = :ps_id_lote
		  , id_situacao = 'S'
		  , dh_envio = :ldt_dh_envio
  WHERE id_lote IS NULL 
      AND cd_chave_movimento = :ps_cd_chave_movimento
	  AND dh_movimentacao_caixa BETWEEN :pdh_data_1 AND :pdh_data_2;

If Sqlca.Sqlcode = -1 Then	
   ps_log = "Aten$$HEX2$$e700e300$$ENDHEX$$o - Erro ao atualizar a nota do Envio de Vendas. " + sqlca.sqlerrtext
   SqlCa.of_rollback( ); 
   Return False
End If

Sqlca.of_commit( );

Return True
end function

public function boolean of_buscar_codigo_loja_lote (integer pl_cd_filial, ref string ps_loja, ref string ps_erro);string ls_cd_loja

Select  cd_filial_scanntech
   Into :ls_cd_loja
 From log_exportacao_scanntech_loja noholdlock
Where cd_filial =:pl_cd_filial; 

choose case Sqlca.Sqlcode 
	case -1
		ps_erro = 'Erro ao acessar a tabela c$$HEX1$$f300$$ENDHEX$$digo Loja/SCANNTECH.'
	    Return False		
	case 100
		ps_erro = 'Dados n$$HEX1$$e300$$ENDHEX$$o retornado para c$$HEX1$$f300$$ENDHEX$$digo SCANNTECH.'
		Return False
	case else
		If Not IsNumber(ls_cd_loja) Then
			ps_erro = 'Dados inv$$HEX1$$e100$$ENDHEX$$lidos para c$$HEX1$$f300$$ENDHEX$$digo SCANNTECH.'
			Return False	
		End If
end choose


ps_loja = ls_cd_loja

Return True 
end function

public function boolean of_buscar_url_fechamento_diario (string as_tipo, string ps_filial, long pl_nr_caixa, ref string as_url, ref string ps_log);String ls_url, ls_cd_loja
Long ll_posicao
String ls_vl_parametro
Boolean lb_ret
String lvs_erro

if gvo_aplicacao.ivs_datasource = 'homologa' then
   ls_vl_parametro = 'URL_FECHAMENTO_HOMOLOGA'	
   lb_ret = of_buscar_codigo_loja_lote(long(ps_filial),ls_cd_loja,lvs_erro)
   If Not lb_ret Then
		ps_log = lvs_erro	 	
		 // N$$HEX1$$e300$$ENDHEX$$o deixo retornar para pegar a url para enviar e pegar o erro 404
   End If		
else
    ls_vl_parametro = 'URL_FECHAMENTO_PRODUCAO'	
    lb_ret = of_buscar_codigo_loja_lote(long(ps_filial),ls_cd_loja,lvs_erro) 
    If Not lb_ret Then
		ps_log = lvs_erro
		 // N$$HEX1$$e300$$ENDHEX$$o deixo retornar para pegar a url para enviar e pegar o erro 404
   End If	 	
end if 

lb_ret = of_parametro_geral_url(ls_vl_parametro,ls_url,lvs_erro)

if Not lb_ret Then
  ps_log 	= lvs_erro
  Return False
Else

	ls_url = is_protocolo + ls_url  
	
	// C$$HEX1$$f300$$ENDHEX$$digo da Loja	
	ll_posicao = Pos(ls_url,"#")
	ls_url = Mid( ls_url, 1 , ll_posicao -1 )  + ls_cd_loja + Mid( ls_url, ll_posicao +1  , 100 ) 
	// Filial
	ll_posicao = Pos(ls_url,"#") 
	ls_url = Mid( ls_url, 1 , ll_posicao -1 )  + ps_filial + Mid( ls_url, ll_posicao +1  , 100 ) 
	// Caixa
	ll_posicao = Pos(ls_url,"#") 
	ls_url = Mid( ls_url, 1 , ll_posicao -1 )  + string(pl_nr_caixa) + Mid( ls_url, ll_posicao +1  , 100 ) 
	as_url = ls_url
End If

If ps_log <> '' Then
   Return False // Retorna falso para contemplar o erro.
End If

Return True

end function

public function boolean of_codigo_produto_lote (long pl_cd_produto, ref string ps_descricao, ref string ps_erro);String ls_de_produto, ls_de_apresentacao


SELECT IsNull(prg.de_produto,'') 
          , IsNull(prg.de_apresentacao_venda,'')  
   INTO :ls_de_produto
	    , :ls_de_apresentacao
  FROM produto_geral prg  noholdlock
WHERE cd_produto =:pl_cd_produto;

choose case Sqlca.Sqlcode
	case -1
		ps_erro = 'Erro ao acessar a tabela Produto Geral.'	
   		Return False
	case 100
		ps_erro = 'Dados n$$HEX1$$e300$$ENDHEX$$o encontrado para Produto.'	
	   	Return False
end choose

If ( IsNull(ls_de_produto) Or ls_de_produto = '') And ( IsNull(ls_de_apresentacao) or ls_de_apresentacao = '' )  Then
  ps_descricao = 'SEM_DESCRIAO'
Else
  ps_descricao = ls_de_produto + ls_de_apresentacao	
End if

Return True


end function

public function boolean of_validar_movimento_pendente (date pdh_data_movimento, ref string ps_log);Long lvl_existe

Select Count(1)
   Into :lvl_existe
  From log_exportacao_scanntech
Where id_situacao = 'P'
    And dh_movimentacao_caixa >= :pdh_data_movimento;

If lvl_existe > 0 Then
	ps_log = 'Aten$$HEX2$$e700e300$$ENDHEX$$o - Para analisar os erros acesse o monitor Scanntec no Sistema de Compras.'
	Return True
End If

Return False
end function

public function boolean of_validar_envio_fechamento (datetime pdh_envio_fechamento, ref datetime pdh_data_fechamento, ref string ps_log);String dh_parm_envio

Datetime ldh_parametro
String dh_data

Select vl_parametro
Into :dh_parm_envio
From parametro_geral 
Where cd_parametro = 'DH_ULTIMO_FECHAMENTO_SCANNTECH';

dh_data = String(Date(dh_parm_envio),"yyyy/mm/dd")

choose case Sqlca.Sqlcode
	case -1
		ps_log = 'Erro ao acessar a tabela de Par$$HEX1$$e200$$ENDHEX$$metro Geral - DH_ULTIMO_FECHAMENTO_SCANNTECH'
	   	Return False
	case 100
		ps_log = 'Dados n$$HEX1$$e300$$ENDHEX$$o encontrado para o Par$$HEX1$$e200$$ENDHEX$$metro Geral - DH_ULTIMO_FECHAMENTO_SCANNTECH'
		Return False
	case else
		If Not IsDate(dh_data) Then
			ps_log = 'Data inv$$HEX1$$e100$$ENDHEX$$lida para o Par$$HEX1$$e200$$ENDHEX$$metro Geral - DH_ULTIMO_FECHAMENTO_SCANNTECH'
			Return False
		End If
end choose

//dh_parm_envio = mid(dh_parm_envio,4,3) + mid(dh_parm_envio,1,3) + mid(dh_parm_envio,6,15)
ldh_parametro =  DateTime(dh_parm_envio)



// vai ter que ter ultimo agendamento para 00:00:00
if Date(ldh_parametro) < Date(pdh_envio_fechamento) then
   pdh_data_fechamento = 	ldh_parametro
   Return True
end if

Return False
end function

public function boolean of_parametro_geral_url (string ps_vl_parametro, ref string ps_url_retorno, ref string ps_log);String ls_url

SELECT de_utilizacao
   INTO :ls_url
 FROM parametro_geral  noholdlock
WHERE vl_parametro =:ps_vl_parametro;   

choose case Sqlca.Sqlcode
	case -1
		 ps_log = 'Erro ao acessar tabela de Par$$HEX1$$e200$$ENDHEX$$metro Geral - ' + ps_vl_parametro + "."	
   		Return False
	case 100
		 ps_log = 'URL n$$HEX1$$e300$$ENDHEX$$o cadastrada.'	
          Return False
end choose

ps_url_retorno = ls_url

Return True
end function

public function boolean of_gerar_replica_nf_lote (string ps_json, ref string ps_replica, long pl_json_cancelado, ref string ps_log);/*-- ============================================================
--        Author: Saulo Braga
-- Create date: 24/10/2021
--  Description: 
--   	
--
-- REGRA : 
              -  Toda nota cancelada $$HEX1$$e900$$ENDHEX$$ gerada com um valor negativo ao lado do numero da nota, exemplo:
              TAG: "numero": "-3564".
              - Essa fun$$HEX2$$e700e300$$ENDHEX$$o gera um par positivo, alterando tamb$$HEX1$$e900$$ENDHEX$$m a TAG "cancelacion": false, pois a TAG negativa
             envia o "cancelacion" = true.
-- ============================================================  */

string ls_replica, ls_replica_aux

long ll_json_cancelado

ll_json_cancelado = pl_json_cancelado

// Altera para positivo
ls_replica =  Mid( ps_json , 1, ll_json_cancelado + 10 )
ls_replica =  ls_replica +  Mid( ps_json, ll_json_cancelado + 12 )
// Altera para true a TAG cancelado
ll_json_cancelado = Pos( ls_replica , "true")
ls_replica_aux =  Mid( ls_replica , 1, ll_json_cancelado - 1 )
ls_replica =  ls_replica_aux +  "false" + Mid( ls_replica, ll_json_cancelado + 4 )
ps_replica = ls_replica

If   IsNull(ps_replica) or ps_replica = '' Then
	ps_log = 'Favor verificar, replica positiva da nota cancelada n$$HEX1$$e300$$ENDHEX$$o gerada.'
	Return False
End If

Return True

end function

public function boolean of_gerar_desconto_total (long pl_cd_filial, long pl_nr_nf, string ps_de_especie, string ps_de_serie, ref decimal pd_desconto, ref string ps_log);decimal ld_descuento_total

SELECT CASE WHEN  pc_desconto > 0 THEN CAST( CAST ( (select abs(round(sum((round(vl_preco_unitario,2) - round(vl_preco_praticado,2)) * round(qt_vendida,2) ),2) )    
                                                                                                                             from item_nf_venda noholdlock
                                                                                                                           where nr_nf = vda.nr_nf
                                                                                                                               and cd_filial = vda.cd_filial
                                                                                                                               and de_especie = vda.de_especie
                                                                                                                               and de_serie     = vda.de_serie
                                                                                                                         group by nr_nf) AS NUMERIC(18,2) )  + CAST(  round( ( round(vl_total_produtos,2) * round(pc_desconto,2) / 100 ),2) AS NUMERIC(18,2) )AS VARCHAR(20) )   
                                                         ELSE CAST( CAST ( (select abs(round(sum( (vl_preco_unitario - vl_preco_praticado) * qt_vendida),2) )
                                                                                         from dbo.item_nf_venda noholdlock
                                                                                       where nr_nf = vda.nr_nf
                                                                                           and cd_filial = vda.cd_filial
                                                                                           and de_especie = vda.de_especie
                                                                                           and de_serie     = vda.de_serie
                                                                                    group by nr_nf ) AS NUMERIC(18,2) ) AS VARCHAR(18) )
                                                 END
      into :ld_descuento_total
FROM ( SELECT   vda.nr_nf, vda.cd_filial, vl_total_produtos , pc_desconto, vda.vl_total_nf
                     , vda.de_especie, vda.de_serie
              FROM nf_venda vda noholdlock
            WHERE vda.de_especie	=:ps_de_especie
			  AND vda.de_serie		=:ps_de_serie		 
         	  AND vda.cd_filial			=:pl_cd_filial  
			  AND  vda.nr_nf			=:pl_nr_nf	) vda;


choose case Sqlca.Sqlcode
	case -1
		ps_log = 'Erro ao calcular desconto total da Venda.'	
   		pd_desconto = 0
   		Return False
	case 100
		ps_log = 'Dados n$$HEX1$$e300$$ENDHEX$$o encontrado para desconto total da Venda.'				
   		pd_desconto = 0
   		Return False
end choose

pd_desconto = ld_descuento_total

Return True
end function

public function boolean of_gerar_chave_movimento_lote (ref string ps_chave_movimento, ref string ps_log);
Select top 1 newid() 
   Into :is_chave_movimento
 From log_exportacao_scanntech noholdlock
 Using sqlca;

If sqlca.sqlcode = - 1 Then
   ps_log = 'Erro a gerar a chave movimento do Lote.'	
   Return False
end if


Return True 
end function

public function boolean of_gera_arquivo_venda_lote (string ps_dh_movimentacao, datetime pdh_cancelado, long pl_nr_nf, string ps_total, string ps_codigo_tipo_pago, string ps_importe, long pl_cd_filial, string ps_de_especie, string ps_de_serie, decimal pd_desconto, decimal pd_vl_total_produtos, ref string ps_json, ref string ps_log);String ls_codigoArticulo,ls_codigoBarras, ls_descripcionArticulo, ls_cantidad, ls_importeUnitario, ls_importe, ls_descuento,ls_erro 
dc_uo_ds_base lds_ge538_envio_venda_item

long ll_row, ll_cont, ll_posicao, ll_cd_filial

Boolean lb_ret

DateTime data_1, data_2

String ls_JSON_cab, ls_nr_nf, ls_cancelada, ls_JSON_rod, ls_JSON_item, ls_json, ls_log

Dec{2} ld_vl_preco_unitario, ld_vl_preco_praticado, ld_descuento_total

if IsValid(lds_ge538_envio_venda_item) then
   Destroy lds_ge538_envio_venda_item
end if
		
lds_ge538_envio_venda_item          = Create dc_uo_ds_base
		
If Not lds_ge538_envio_venda_item.of_ChangeDataObject( 'ds_ge538_item_venda' , False) Then 
  	gvo_aplicacao.of_grava_log("Erro ao retornar dados do Item de Venda")
  Destroy lds_ge538_envio_venda_item
  Return False
End If	

if not IsNull(pdh_cancelado) then
  ls_nr_nf = '-' + String(pl_nr_nf)
  ls_cancelada = 'true'
else  
  ls_nr_nf = String(pl_nr_nf)
  ls_cancelada = 'false'	
end if

ll_row = lds_ge538_envio_venda_item.retrieve(pl_cd_filial[],pl_nr_nf,ps_de_especie,ps_de_serie)

data_1 =  DateTime(String(ps_dh_movimentacao) + ' 00:00:00.000')
data_2 =  DateTime(String(ps_dh_movimentacao) + ' 23:59:59.000')

for ll_cont = 1 to ll_row
	
  if ll_cont = 1 then
	lb_ret = of_gerar_desconto_total(pl_cd_filial,pl_nr_nf,ps_de_especie,ps_de_serie,ld_descuento_total, ref ls_erro)
	if lb_ret = false then
	  ps_log = ls_erro 
	  Return false	  
	end if
 end if

  	
   ls_codigoArticulo        = lds_ge538_envio_venda_item.object.codigoArticulo[ll_cont]
   ls_codigoBarras         =  lds_ge538_envio_venda_item.object.codigoBarras[ll_cont]
   ls_cantidad                = lds_ge538_envio_venda_item.object.cantidad[ll_cont]
   ls_importeUnitario      = lds_ge538_envio_venda_item.object.importeUnitario[ll_cont]
   ls_importe                 = lds_ge538_envio_venda_item.object.importe[ll_cont]
   ls_descuento             = lds_ge538_envio_venda_item.object.descuento[ll_cont]
   ld_vl_preco_unitario   = lds_ge538_envio_venda_item.object.vl_preco_unitario[ll_cont]
   ld_vl_preco_praticado = lds_ge538_envio_venda_item.object.vl_preco_praticado[ll_cont]	
 	
	
   if Isnull(ls_codigoBarras)	or ls_codigoBarras = '' then
	 ls_codigoBarras = ls_codigoArticulo
   end if

   lb_ret = of_codigo_produto_lote(Long(ls_codigoArticulo),ls_descripcionArticulo, ref ls_erro)
  
   if lb_ret = false then
	ps_log =  ls_erro 
     Destroy lds_ge538_envio_venda_item	
	 Return false	
   end if
	
	
      ls_JSON_item = ls_JSON_item +             '{  "codigoArticulo": ' + '"' +ls_codigoArticulo + '", '                     + &
	                                              +             ' "codigoBarras": ' + '"' + ls_codigoBarras + '", '                         + &
	                                 			 +             ' "descripcionArticulo": ' + '"' + ls_descripcionArticulo + '", '        + &
	                                 			 +             ' "cantidad": ' + ls_cantidad  + ', '                                            + &   
                                     			 +             ' "importeUnitario": ' + ls_importeUnitario + ', '                         + &
	                                			 +             ' "importe": ' + ls_importe + ', '                                               + &
	                                			 +             ' "descuento": ' + ls_descuento + ', '                                        + &
                                                  +              ' "recargo":' + '0.00'  +  '	 } ' 
	
	if ll_cont < ll_row then
	   ls_JSON_item = ls_JSON_item + ' , ' 
	end if
	
next	


string ls_valor

ls_valor = String(ld_descuento_total)

if ld_descuento_total > 0  then
  ls_valor =  Replace(ls_valor,Pos(String(ld_descuento_total),','),1,'.')
else  
  ls_valor = "0.00"
end if


ls_JSON_cab = '{' + ' "fecha": '      + '"' + ps_dh_movimentacao                                                                              + '", '    + &
		                  + ' "numero": '  + '"' + ls_nr_nf                                                                                                  + '", '    + &
						+ ' "descuentoTotal": ' +  ls_valor  + ' , '   + &	
						+ ' "recargoTotal": '   +  '0'                                                                                                         + ', '     + &
						+ ' "codigoMoneda": ' + '"986", '                                                                                                             + &
						+ ' "cotizacion": ' + '1.00, '                                                                                                                     + &
                           + ' "total": ' +  ps_total                                                                                                                +  ', '   + &  
                           + ' "cancelacion": '+ ls_cancelada                                                                                                 + ','     + &
                		     + ' "documentoCliente": ' + 'null, '                                                                                                           + &
                		     + ' "codigoCanalVenta": ' + '1, '                                                                                                              + &
                           + ' "detalles": '                                                                                                                                      + &
                           + ' [  '  

ls_JSON_rod = '  ], '                                                                          + &
                      + ' "pagos": '                                                              + &
                      + ' [ { '                                                                       + &
		             + ' "codigoTipoPago": ' + ps_codigo_tipo_pago + ', '       + & 
		             + ' "codigoMoneda": ' + '"986", '                                   + &
            	         + ' "importe": ' + ps_importe + ', '                                + &
                      + ' "cotizacion": ' + '1.00, '                                            + &
		             + ' "documentoCliente": ' + 'null, '                                 + &
                      + ' "bin": ' + 'null, '                                                      + &  
           		    + ' "ultimosDigitosTarjeta": ' + 'null, '                            + &
                      + ' "numeroAutorizacion": ' + 'null, '                              + &
             		    + ' "codigoTarjeta": ' + 'null '                                        + &
                      + ' } ] '                                                                       + &  
                      + ' } '   

ls_json = ls_JSON_cab + ls_JSON_item + ls_JSON_rod
						
// Retirar caracteres diferentes
If Not of_retira_caracteres (  ls_Json , ref ls_Log)  Then 
  ps_log = ls_log	
  Destroy lds_ge538_envio_venda_item
  Return False
End If 

// valida gerou nulo
if IsNull(ls_JSON_cab + ls_JSON_item + ls_JSON_rod) then
  ps_log  = 'Arquivo JSON nulo.'	
  Destroy lds_ge538_envio_venda_item	
  return false	
end if	

ps_json = ls_JSON_cab + ls_JSON_item + ls_JSON_rod

Destroy lds_ge538_envio_venda_item

return true
end function

public function boolean of_buscar_url_envio_vendas_lote (string as_tipo, string ps_filial, long pl_nr_caixa, ref string ps_url, string ps_tipo_envio, ref string ps_log);Boolean lb_ret
String ls_url, ls_cd_loja, ls_vl_parametro, lvs_erro
Long ll_posicao

if gvo_aplicacao.ivs_datasource = 'homologa' then
	ls_vl_parametro = 'URL_VENDA_HOMOLOGA'
    lb_ret  = of_buscar_codigo_loja_lote(long(ps_filial),ls_cd_loja,lvs_erro)
	If Not lb_ret Then
		ps_log = lvs_erro
         // N$$HEX1$$e300$$ENDHEX$$o deixo retornar para pegar a url para enviar e pegar o erro 404
	End If
else
   	ls_vl_parametro = 'URL_VENDA_PRODUCAO'
	lb_ret = of_buscar_codigo_loja_lote(long(ps_filial),ls_cd_loja,lvs_erro) 
	If Not lb_ret Then
		ps_log = lvs_erro
         // N$$HEX1$$e300$$ENDHEX$$o deixo retornar para pegar a url para enviar e pegar o erro 404
	End If
end if 

lb_ret = of_parametro_geral_url(ls_vl_parametro,ls_url,lvs_erro)

If Not lb_ret Then
	ps_log = lvs_erro
	Return False
End If


if ps_tipo_envio = 'P' then
  ls_url = is_protocolo + ls_url  + is_sufixo_url
else
  ls_url = is_protocolo + ls_url	
end if	

ll_posicao = Pos(ls_url,"#")
ls_url = Mid( ls_url, 1 , ll_posicao -1 )  + ls_cd_loja + Mid( ls_url, ll_posicao +1  , 100 ) 
// Filial
ll_posicao = Pos(ls_url,"#") 
ls_url = Mid( ls_url, 1 , ll_posicao -1 )  + ps_filial + Mid( ls_url, ll_posicao +1  , 100 ) 
// Caixa
ll_posicao = Pos(ls_url,"#") 
ls_url = Mid( ls_url, 1 , ll_posicao -1 )  + string(pl_nr_caixa) + Mid( ls_url, ll_posicao +1  , 100 ) 
ps_url = ls_url

If ps_log <> '' Then
   Return False // Retorna falso para contemplar o erro.
End If

Return True
end function

public function boolean of_gera_arquivo_fechamento (string ps_valor_venda, string ps_valor_cancelado, date pdh_mov_caixa, integer pi_qt_venda, integer pi_qt_cancelada, ref string ps_json, ref string ps_log);string ls_mov_caixa, ls_json, ls_log

ls_mov_caixa =  string(pdh_mov_caixa,'yyyy-mm-dd')
	
ls_json =   ' { "montoVentaLiquida": ' + string(ps_valor_venda) + ','    + &
		       '   "montoCancelaciones": '  + string(ps_valor_cancelado) + ',' + &
			  '   "cantidadMovimientos": ' + string( pi_qt_venda )  + ',' + &
          	  '   "fechaVentas":  "' + ls_mov_caixa + '",' + &
			  '   "cantidadCancelaciones": ' + string(pi_qt_cancelada) + ' } ' 
  
// Retirar caracteres especiais
If Not of_retira_caracteres (  ls_Json , ref ls_Log)  Then 
	ps_log = ls_Log	
  	Return False
End If 

// valida se gerou nulo
If IsNull(ls_json) Then
	ps_log = 'Arquivo JSON fechamento nulo.'
  	Return False	
End If				  

ps_json = ls_json		  
			  
Return True			  
end function

public function boolean of_autenticar_api_scanntech_lote (string ps_metodo, string ps_url, string ps_json_envio, string ps_autenticacao_key, boolean pb_utiliza_api_key, boolean pb_utiliza_origem, ref string ps_json_retorno, ref string ps_erro, ref long pl_codigo_erro);/**********************************************************************************************************************************
    Altera$$HEX2$$e700e300$$ENDHEX$$o: 
	  
	              Data                Respons$$HEX1$$e100$$ENDHEX$$vel                                                               Objetivo
				10/08/2021      Saulo Braga                                                                - C$$HEX1$$f300$$ENDHEX$$digo foi copiado do objeto uo_ge512_smart_pricking e adaptado para o envio de vendas ScannTech
				                                                                                                          pelo respons$$HEX1$$e100$$ENDHEX$$vel que construiu essa funcionalidade.	
																																							 
Par$$HEX1$$e200$$ENDHEX$$metros:

as_metodo = 'POST' ou 'GET'...
as_url        = 
																																							 
																																							 

**********************************************************************************************************************************/
String ls_Status_Text, ls_base64
Long ll_Status_Code
Long ll_rtn				
Long		li_rc1,&
			li_rc2

OleObject	lo_Http



if IsValid(lo_Http) then
  Destroy(lo_Http)
end if

lo_Http	= CREATE OleObject


lo_Http.ConnectToNewObject("Msxml2.ServerXMLHTTP.6.0")  // Comentei o parametro, pois estava travando e saindo, nao enviando o json
lo_Http.SetTimeOuts(1000,1000,2000,2000)

Try
	string ls_usu, ls_senha
	
	if gvo_aplicacao.ivs_datasource = 'homologa' then
		ls_base64 = is_base64_homo
	else
		ls_base64 = is_base64_producao
	end if 
	
	lo_Http.open (ps_Metodo, ps_Url, False )  
	lo_Http.SetRequestHeader( "Content-Type", "application/json")  
	// * coringa, identifica o que foi enviado e retorna de acordo.
    	lo_Http.SetRequestHeader( "Accept", "*")  
   	lo_Http.SetRequestHeader( "Authorization", "Basic " + ls_base64 ) 
     
	lo_Http.send(ps_Json_Envio)
	
	//Pega a resposta do web service
	ls_Status_Text 	= lo_Http.StatusText
	ll_Status_Code 	= lo_Http.Status
	ps_json_retorno	= lo_Http.ResponseText
	
	pl_codigo_erro = ll_Status_Code
	
	If ll_Status_Code > 201 Then
		ps_Erro = "ScannTech: Erro Processamento : " + String(ll_Status_Code) + ' - ' +String(ps_json_retorno)
	//	messagebox('', ps_Erro)
		Return False
	Else					
		Return True 
	End If
Catch (RuntimeError rte2)
	ps_Erro = "ScannTechErro: Erro Processamento : " + rte2.GetMessage()
//	messagebox('', ps_Erro)
	Return False			
Finally
	lo_Http.DisconnectObject()
	Destroy(lo_Http)
End Try
end function

public function boolean of_atualiza_envio_vendas_erro_lote (string ps_cd_chave_movimento, datetime pdh_data_1, datetime pdh_data_2, datastore pds_envio_vendas, string ps_id_lote, ref string ps_erro);long ll_existe, ll_nr_atualizacao, ll_existe_fechamento

Long lvl_row, lvl_cont, lvl_cd_filial, lvl_nr_nf

Dec{2} lvd_total, lvd_importe, lvd_pc_desconto, lvd_vl_total_produtos, lvd_vl_total_nf, ld_vl_desconto_nf

DateTime ldh_cancelamento

Date ldh_mov_caixa


string lvs_de_especie, lvs_de_serie, lvs_tipo_pagto, ls_erro, lvs_chave_movimento

DateTime ldt_env

lvl_row = pds_envio_vendas.rowCount()

For lvl_cont = 1 To lvl_row

	lvl_cd_filial           		= pds_envio_vendas.object.cd_filial[lvl_cont]
	ldh_mov_caixa  		= Date(pds_envio_vendas.object.dh_movimentacao_caixa[lvl_cont])
	lvl_nr_nf					= pds_envio_vendas.object.nr_nf[lvl_cont]
	lvs_de_especie			= pds_envio_vendas.object.de_especie[lvl_cont]
	lvs_de_serie				= pds_envio_vendas.object.de_serie[lvl_cont]
	lvd_total					= Dec(pds_envio_vendas.object.total[lvl_cont])
	lvs_tipo_pagto			= pds_envio_vendas.object.codigotipopago[lvl_cont]	
	lvd_importe				= Dec(pds_envio_vendas.object.importe[lvl_cont])	
	lvd_pc_desconto        = Dec(pds_envio_vendas.object.pc_desconto[lvl_cont])
	lvd_vl_total_produtos	= Dec(pds_envio_vendas.object.vl_total_produtos[lvl_cont])
	lvd_vl_total_nf			= Dec(pds_envio_vendas.object.vl_total_nf[lvl_cont])
	ldh_cancelamento		= pds_envio_vendas.object.dh_cancelamento[lvl_cont]
	ld_vl_desconto_nf		= Dec(pds_envio_vendas.object.vl_desconto_nf[lvl_cont])
	lvs_chave_movimento= pds_envio_vendas.object.cd_chave_movimento[lvl_cont]	
	
	If lvs_chave_movimento <> '' Then
		If Not Of_atualiza_log_exportacao_scanntech(	lvl_cd_filial,					+ &
																	lvl_nr_nf   ,					+ & 
																	lvs_de_especie,			+ & 
																	lvs_de_serie,				+ & 
																	DateTime(ldh_mov_caixa),				+ & 
																	'V',							+ & 
																	'P',								+ & 
																	ps_erro,						+ & 
																	lvd_pc_desconto,			+ & 
																	lvd_vl_total_produtos,		+ &  
																	lvd_vl_total_nf,				+ &
																	lvs_tipo_pagto,				+ &
																	ldh_cancelamento,			+ &
																	ld_vl_desconto_nf,			+ &
																	ps_id_lote,					+ &	
																	ps_cd_chave_movimento,	 ref ls_erro )   Then
			ps_erro = "Erro ao incluir dados na tabela LOG_EXPORTACAO_SCANNTECH. " + sqlca.sqlerrtext
			Return False				
		End If
	End If    	
	
Next 

return true
end function

public function boolean of_envia_email (string ps_mensagem, ref string ps_log);String lvs_Msg

s_email lst_Email

lvs_Msg = "Aten$$HEX2$$e700e300$$ENDHEX$$o, <br><br>" + &
               "Descri$$HEX2$$e700e300$$ENDHEX$$o: "+ps_mensagem+"<br>"

lst_Email.ps_mensagem = lvs_Msg
lst_Email.pb_assinatura = True

If Not gf_ge202_envia_email_padrao( 272 , lst_Email ) Then
	ps_log = 'Erro ao enviar E-mail.'
   	Return False	
End If

Return True
end function

public function boolean of_leitura_retorno_json_enviado_lote (string ps_json, string ps_tipo_validacao, ref string ps_id_lote, datetime pdh_data_1, datetime pdh_data_2, datastore pds_envio_vendas, string ps_cd_chave_movimento, ref string ps_log);Long lvl_row, lvl_cont, lvl_cd_filial, lvl_nr_nf

Dec{2} lvd_total, lvd_importe, lvd_pc_desconto, lvd_vl_total_produtos, lvd_vl_total_nf, ld_vl_desconto_nf

DateTime ldh_cancelamento

Date ldh_mov_caixa

string lvs_de_especie, lvs_de_serie, lvs_tipo_pagto, ls_erro

Long ll_nr_nota
Long ll_nr_nota_erro
Long ll_cont 
Boolean lb_ret
String ls_erro_nota, ls_error, ls_log, ls_lote, lvs_chave_movimento

DateTime ldh_Conf

Any la_Data, la_Null

// Instaicia Objeto
uo_ge538_Json ln_Json
ln_Json = create uo_ge538_Json

Try
	ls_error = ln_json.parse(ps_json)
	
	// Analisando erro no JSON
	If ls_error <> "" Then
		ls_log = "Parse error: " + ls_error
		Return False
  	End If

	// Sucesso o envio, ent$$HEX1$$e300$$ENDHEX$$o pegar o numero do lote
 
	If Not ln_json.retrieve("idLote", ref la_data) Then
		ls_log = "Retornando 'idLote' (null)"
		Return False
  	Else
		ls_lote = String(la_data)
		ps_id_lote = ls_lote
  	End if
  	  
	If ps_tipo_validacao <> 'S'	Then
	
		// Quantidade de envio s$$HEX1$$e300$$ENDHEX$$o 300
		For ll_cont = 1 To il_qtd_envio
			
	   	// Data Movimento
	   		If Not ln_json.retrieve("errores/" + string(ll_cont) + "/fecha", ref la_data) Then 
 		 		ls_log = "Retornando 'Data Movimento.' (null)"
		 		Continue
	   		Else
	      		ldh_Conf = DateTime(Date(la_data))
	   		End if
	
   	   		// Numero da Nota
	   		If Not ln_json.retrieve("errores/" + string(ll_cont) + "/numero", ref la_data) Then 
 		 		ls_log = "Retornando 'Numero da nota.' (null)"
		 		Continue
		   	Else
	      		ll_nr_nota_erro = Long(la_data)
	   		End if
	
	   		// Mensagem de Erro
    	   		If Not ln_json.retrieve("errores/" + string(ll_cont) + "/error/appErrorCode", ref la_data) Then 
 		 		ls_log = "Retornando 'Mensagem de erro.' (null)"
		 		Continue
	         Else
	      		ls_erro_nota = String(la_data)
	   		End if
		
//	   // Dentro da fun$$HEX2$$e700e300$$ENDHEX$$o j$$HEX1$$e100$$ENDHEX$$ atualiza o log	
//       of_atualizar_nota_erro_lote(ll_nr_nota_erro,pdh_data_1,pdh_data_2,is_chave_movimento,ps_id_lote,ls_erro_nota)

			lvl_cd_filial           		= pds_envio_vendas.object.cd_filial[lvl_cont]
			ldh_mov_caixa  		= Date(pds_envio_vendas.object.dh_movimentacao_caixa[lvl_cont])
			lvl_nr_nf					= pds_envio_vendas.object.nr_nf[lvl_cont]
			lvs_de_especie			= pds_envio_vendas.object.de_especie[lvl_cont]
			lvs_de_serie				= pds_envio_vendas.object.de_serie[lvl_cont]
			lvd_total					= Dec(pds_envio_vendas.object.total[lvl_cont])
			lvs_tipo_pagto			= pds_envio_vendas.object.codigotipopago[lvl_cont]	
			lvd_importe				= Dec(pds_envio_vendas.object.importe[lvl_cont])	
			lvd_pc_desconto        = Dec(pds_envio_vendas.object.pc_desconto[lvl_cont])
			lvd_vl_total_produtos	= Dec(pds_envio_vendas.object.vl_total_produtos[lvl_cont])
			lvd_vl_total_nf			= Dec(pds_envio_vendas.object.vl_total_nf[lvl_cont])
			ldh_cancelamento		= pds_envio_vendas.object.dh_cancelamento[lvl_cont]
			ld_vl_desconto_nf		= Dec(pds_envio_vendas.object.vl_desconto_nf[lvl_cont])
			lvs_chave_movimento= pds_envio_vendas.object.cd_chave_movimento[lvl_cont]	
	
			if ll_nr_nota_erro = lvl_nr_nf and lvs_chave_movimento <> '' Then
	
				If Not Of_atualiza_log_exportacao_scanntech(	lvl_cd_filial,					+ &
																			lvl_nr_nf   ,					+ & 
																			lvs_de_especie,			+ & 
																			lvs_de_serie,				+ & 
																			DateTime(ldh_mov_caixa),				+ & 
																			'V',							+ & 
																			'P',							+ & 
																			'',								+ & 
																			lvd_pc_desconto,			+ & 
																			lvd_vl_total_produtos,		+ &  
																			lvd_vl_total_nf,				+ &
																			lvs_tipo_pagto,				+ &
																			ldh_cancelamento,			+ &
																			ld_vl_desconto_nf,			+ &
																			ps_id_lote,					+ &	
																			ps_cd_chave_movimento,	 ref ls_erro )  Then
					ps_log = "Erro ao incluir dados na tabela LOG_EXPORTACAO_SCANNTECH."
					 Return False				
				End If
			ElseIf lvs_chave_movimento <> '' Then
				If Not Of_atualiza_log_exportacao_scanntech(	lvl_cd_filial,					+ &
																			lvl_nr_nf   ,					+ & 
																			lvs_de_especie,			+ & 
																			lvs_de_serie,				+ & 
																			DateTime(ldh_mov_caixa),				+ & 
																			'V',							+ & 
																			'S',							+ & 
																			'',								+ & 
																			lvd_pc_desconto,			+ & 
																			lvd_vl_total_produtos,		+ &  
																			lvd_vl_total_nf,				+ &
																			lvs_tipo_pagto,				+ &
																			ldh_cancelamento,			+ &
																			ld_vl_desconto_nf,			+ &
																			ps_id_lote,					+ &	
																			ps_cd_chave_movimento,	 ref ls_erro )  Then
					ps_log = "Erro ao incluir dados na tabela LOG_EXPORTACAO_SCANNTECH."
					 Return False				
				End If
			End If
		Next

	End If	

 
 
Catch (RunTimeError lo_error)
	Destroy(ln_json)
	return false
Finally
	
End Try	 
  	

Return True
end function

public function boolean of_preparar_dados_envio_vendas_lote (date pdh_movim_caixa, long pl_cd_filial, string ps_chave_movimento, ref string ps_log);DateTime ldh_data_1, ldh_data_2
Long ll_ret, ll_cont, ll_row, ll_row_diminui
string lvs_campo

Try
 
    ldh_data_1 =  DateTime(String(pdh_movim_caixa) + ' 00:00:00.000')
    ldh_data_2 =  DateTime(String(pdh_movim_caixa) + ' 23:59:59.000')

   il_row = ids_ge538_envio_vendas_lote.retrieve(pl_cd_filial,ldh_data_1,ldh_data_2)
	
  If il_row = 0 or il_row = -1 then
	ps_log = 'Dados n$$HEX1$$e300$$ENDHEX$$o encontrado para Envio Vendas'
	Return False
  End If
  
  // Atualiaza somente o lote para processar
  If il_row = il_qtd_envio Then
	ll_row = il_row
	ll_row_diminui = il_row
  Else	
    ll_row = il_row
  End If
  
   For ll_cont = 1 To ll_row	

     // Se lote for de 300, tira a quantidade que ter$$HEX1$$e100$$ENDHEX$$ que ser acrescentado para as pernas positivas.
     If Not isNULL(ids_ge538_envio_vendas_lote.object.dh_cancelamento[ll_cont] ) and il_row = 300 then
	     il_qt_cancelada = il_qt_cancelada + 1	
          ll_row_diminui = ll_row_diminui -1  // Diminui do top 300 para adicionar as pernas positivas das notas canceladas.
	     ids_ge538_envio_vendas_lote.object.cd_chave_movimento[ll_cont] = ''  // ps_chave_movimento
	 ElseIf Not isNULL(ids_ge538_envio_vendas_lote.object.dh_cancelamento[ll_cont] ) Then
	     ids_ge538_envio_vendas_lote.object.cd_chave_movimento[ll_cont] = ''
      End If
	  
   next	
  
  If il_row >= il_qtd_envio and il_qt_cancelada > 0 Then
	// Tira mais um para + uma para encaixar a perna positiva
    il_row = ll_row_diminui
  End If
  
  For ll_cont = 1 To il_row
	    ids_ge538_envio_vendas_lote.object.cd_chave_movimento[ll_cont] = ps_chave_movimento
  Next	
 
  il_qt_cancelada = 0
 

Catch (RunTimeError lo_error)
	Destroy ids_ge538_envio_vendas_lote
	ps_log = lo_error.GetMessage( )
Finally
	//
End Try	

Return True
end function

public function boolean of_retira_caracteres (ref string as_json, ref string ps_log);Try
	as_json	= gf_Replace(as_json, "'", " ", 0)
	as_json	= gf_Replace(as_json, "&", " ", 0)
	as_json	= gf_Replace(as_json, "	", "", 0)
	as_json	= gf_Replace(as_json, "#", "", 0)
	as_json	= gf_Replace(as_json, "38;", "", 0)		
	as_json	= gf_Replace(as_json, "P/", "", 0)		
	
catch (RuntimeError lo_rte)
	ps_Log	= "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_retira_caracteres_especiais', objeto 'uo_el100_sap_cliente'. Erro: "+lo_rte.GetMessage()
	Return False
End Try

Return True
end function

public function boolean of_liberar_movimento_processamento (date pdh_movimento);Long	ll_null


return of_liberar_movimento_processamento(pdh_movimento, pdh_movimento, ll_null)
end function

public function boolean of_filial_cadastrada_scanntech (integer pl_cd_filial);Long ll_existe

Select cd_filial_scanntech
   Into :ll_existe
 From log_exportacao_scanntech_loja
where cd_filial =:pl_cd_filial
Using Sqlca;

If Sqlca.Sqlcode = -1 Then
	gvo_aplicacao.of_grava_log("Erro ao verificar se filial est$$HEX1$$e100$$ENDHEX$$ cadastrada Scanntech.")
	Return False
End If 

If ll_existe > 0 Then
	Return True
End If

Return False
end function

public subroutine _documentacao ();/*	  Objetivo: Enviar notas fiscais  para promo$$HEX2$$e700f500$$ENDHEX$$es Scanntech que o tipo da ESPECIE seja: CF - NFC - SAT . Notas enviadas todas validas e as canceladas tamb$$HEX1$$e900$$ENDHEX$$m.
                     NFE somente com nr_nf_anexa vazio... 
	Chamado: 
Respons$$HEX1$$e100$$ENDHEX$$vel: Saulo Braga


REGRA PARA NOTAS CANCELADAS : 
- Para o fechamento Di$$HEX1$$e100$$ENDHEX$$rio, foi incluido somado no totalizado o campo valor do desconto por causa de diferen$$HEX1$$e700$$ENDHEX$$a
  Obs.: Est$$HEX1$$e100$$ENDHEX$$ na datawindow de fechamento di$$HEX1$$e100$$ENDHEX$$rio.
  SUM(vl_total_nf + v.vl_desconto_nf)
	
- Toda nota de CANCELAMENTO dever$$HEX1$$e100$$ENDHEX$$ enviar dois JSON, um positivo e um negativo.
   Exemplo: Negativa - TAG "numero": "-123456"    "cancelacion": true
                 Positivo   - TAG "numero": "123456"      "cancelacion" false
   Existe uma fun$$HEX2$$e700e300$$ENDHEX$$o que monta o JSON positivo - of_gerar_replica_nf	
	
Tabelas: 
			-	log_exportacao_scanntech
			-	log_exportacao_scanntech_loja ( lojas com c$$HEX1$$f300$$ENDHEX$$digo scanntech nessa tabela nulo, tem que solicitar o cadastro )
			-	nf_venda
			-	item_nf_venda
			-	codigo_barras_produto
			-	filial
			-	controle_caixa

*/
end subroutine

public function boolean of_parametro_geral_url (ref long pl_dias, ref string ps_log);String ls_dias


 Select  vl_parametro
    Into :ls_dias
  From parametro_geral 
Where cd_parametro = 'ID_DIAS_VENDAS_SCANNTECH'
Using Sqlca;

choose case Sqlca.Sqlcode
	case -1 	
		ps_log = 'Erro ao acessar a tabela de Par$$HEX1$$e200$$ENDHEX$$metro Geral - ID_DIAS_VENDAS_SCANNTECH.'
		Return False
	case 100
		ps_log = 'Dados n$$HEX1$$e300$$ENDHEX$$o cadastrado para o Par$$HEX1$$e200$$ENDHEX$$metro Geral - ID_DIAS_VENDAS_SCANNTECH.'
		Return False
	case 0
		If Not IsNumber(ls_dias) Then 
			ps_log = 'Dados inv$$HEX1$$e100$$ENDHEX$$lidos para o cadastros do Par$$HEX1$$e200$$ENDHEX$$metro Geral - ID_DIAS_VENDAS_SCANNTECH.'
			Return False
		End If	
end choose

pl_dias = long(ls_dias)

Return True
end function

public function boolean of_atualiza_processamento (date adh_data_processamento, string as_tipo_processamento, string as_identificador, long al_bloco);Long ll_existe

DateTime ldh_data_1
DateTime ldh_data_2

DateTime ldh_corrente

ldh_data_1 =  DateTime(String(adh_data_processamento) + ' 00:00:00.000')
ldh_data_2 =  DateTime(String(adh_data_processamento) + ' 23:59:59.000')

ldh_corrente = DateTime(String(adh_data_processamento) + ' ' + String(now(),"HH:MM:SS"))

Select count(1)
	Into :ll_existe
 From log_scanntech_proc
Where dh_inicio 		Between :ldh_data_1 And :ldh_data_2
	 And id_tipo_envio 	=:as_tipo_processamento
	 And id_bloco			=:al_bloco
Using Sqlca;

If Sqlca.Sqlcode = -1 Then
	Sqlca.of_rollback( );
	gvo_aplicacao.of_grava_log("Erro ao validar dados na tabela LOG_SCANNTECH_PROC!")
	Return False
End If

If ll_existe = 0 Then
	INSERT INTO dbo.log_scanntech_proc
	( id_tipo_envio
	, dh_inicio
	, dh_terminio
	, id_bloco )
	VALUES
	( :as_tipo_processamento
	, :ldh_corrente
	, null 
	, :al_bloco) 
	Using Sqlca;
	
	If Sqlca.Sqlcode = -1 Then
		Sqlca.of_rollback( );
		gvo_aplicacao.of_grava_log("Erro ao incluir Vendas na tabela LOG_SCANNTECH_PROC!")
		Return False
	End If
Else
	// I - Inicio
	If as_identificador = 'I' Then
		Update dbo.log_scanntech_proc
			 Set dh_inicio =:ldh_corrente
		Where dh_inicio Between :ldh_data_1 And :ldh_data_2
			 And  id_tipo_envio 	=:as_tipo_processamento
			 And id_bloco			=:al_bloco
		  Using Sqlca;	
			 
		If Sqlca.Sqlcode = -1 Then
			Sqlca.of_rollback( );
			gvo_aplicacao.of_grava_log("Erro ao atualizar Vendas na tabela LOG_SCANNTECH_PROC!")
			Return False
		End If	 
	Else
		Update log_scanntech_proc
			 Set dh_terminio =:ldh_corrente
		Where dh_inicio Between :ldh_data_1 And :ldh_data_2
			 And  id_tipo_envio 	=:as_tipo_processamento
			 And id_bloco			=:al_bloco
		  Using Sqlca;	
			 
		If Sqlca.Sqlcode = -1 Then
			Sqlca.of_rollback( );
			gvo_aplicacao.of_grava_log("Erro ao atualizar Vendas na tabela LOG_SCANNTECH_PROC!")
			Return False
		End If	 		
	End If	
End If	

Sqlca.of_commit( );

end function

public function boolean of_processamento_atrasado (date adh_data_processamento, string as_tipo_processamento, ref string as_mes[], long al_bloco);Long ll_cont, &
        ll_row, &
  	   ll_dia, & 
	   ll_existe, &
	   ll_cont_vet, &
	   ll_tmh_vet

Date 	ldh_processamento

DateTime ldh_data_null, ldh_data_1, ldh_data_2

String ls_mes[]


ldh_processamento = Date(adh_data_processamento)


Select vl_parametro
Into :ll_dia
From parametro_geral 
Where cd_parametro = 'ID_DIAS_ATRAS_SCANNTECH'
Using SqlCA;

If Sqlca.Sqlcode = -1 Then
	gvo_aplicacao.of_grava_log("Erro ao retornar dias atras parametro Processamento Scanntech")
	Return False	
End If


DO WHILE ll_dia >= 1  // Primeiro dia do M$$HEX1$$ea00$$ENDHEX$$s
	ll_cont = ll_cont + 1
	
	//Limitar inico da implementa$$HEX2$$e700e300$$ENDHEX$$o
	If ldh_processamento >= Date('2022/04/01') Then
		
		ldh_data_1 =  DateTime(String(ldh_processamento) + ' 00:00:00.000')
		ldh_data_2 =  DateTime(String(ldh_processamento) + ' 23:59:59.000')
		
		// Top 1 para somente saber se movimento ja foi inserido
		Select top 1 count(1), dh_terminio
			 Into :ll_existe, :ldh_data_null
		  From log_scanntech_proc 
		Where dh_inicio		Between :ldh_data_1 And :ldh_data_2
			And id_tipo_envio	=:as_tipo_processamento
		//	And id_bloco 		=:al_bloco
		 Group By  dh_terminio
		Using Sqlca;
			
		If Sqlca.Sqlcode = -1 Then
			gvo_aplicacao.of_grava_log("Erro ao retornar dados do LOG Processamento Scanntech")
			Return False	
		End If
	
		If ll_existe = 0 Or ( ll_existe > 0 And IsNull(ldh_data_null) ) Then
			ll_cont_vet++
			ls_mes[ll_cont_vet] = 	String(ldh_processamento,"YYYY/MM/DD")
		End If	
			
	//	End If     
	End If

	ldh_processamento = RelativeDate(Date(ldh_processamento), -1)   
	ll_dia = ll_dia - 1

LOOP

ll_tmh_vet = UpperBound(ls_mes)

For ll_cont = 1 To UpperBound(ls_mes)
	
	as_mes[ll_tmh_vet] = ls_mes[ll_cont]
	ll_tmh_vet = ll_tmh_vet - 1
	
Next	

string ls

ls = ''







end function

public function boolean of_valida_processamento_venda (date adh_movimento);Long ll_existe

Datetime ldh_data_1, ldh_data_2, ldh_data_null

ldh_data_1 =  DateTime(String(adh_movimento) + ' 00:00:00.000')
ldh_data_2 =  DateTime(String(adh_movimento) + ' 23:59:59.000')
			
Select TOP 1 count(1), dh_terminio
   Into :ll_existe, :ldh_data_null
  From log_scanntech_proc 
Where dh_inicio		Between :ldh_data_1 And :ldh_data_2
    And id_tipo_envio	= 'V'
	And dh_terminio  Is Null
Group By  dh_terminio
Using Sqlca;
			
If Sqlca.Sqlcode = -1 Then
	gvo_aplicacao.of_grava_log("Erro ao retornar dados do LOG Processamento Scanntech")
	Return False	
End If


If ll_existe > 0 and IsNull(ldh_data_null) Then
	gvo_aplicacao.of_grava_log("Movimento ainda n$$HEX1$$e300$$ENDHEX$$o finalizado.")
	Return False
End If	

Return True
end function

public function boolean of_envia_email_diario ();Long  ll_Linha,&
	   ll_Linhas,&
	   ll_Bloco,&
	   ll_Qtd_filiais,&
		ll_Qtd_Pendente,&
		ll_qtd

String  ls_Texto_Email,&
		 ls_Tipo,&
		 ls_Dados_Email,&
		 ls_MSG,&
		 ldt_DataIni,&
		 ldt_DataFim,&
		 ls_Texto_Filial,&
		 ls_pendencias = '',&
	    ls_pend_Email = ''

DateTime ldh_DataInicio,&
			ldh_DataTermino,&
			ldt_consulta_log

ll_Qtd_filiais		  = 0 
SetNull(ls_Texto_Filial)

s_email str
dc_uo_ds_base lds_1
dc_uo_ds_base lds_2

lds_1 = Create dc_uo_ds_base
lds_2 = Create dc_uo_ds_base

// Lista com Dados Filiais/Pedidos
If Not lds_1.of_ChangeDataObject("ds_ge538_log_processamento", False) Then
	ls_MSG = "Scanntech.(of_envia_email_diario): Carga ds_ge538_log_processamento"
	gvo_aplicacao.of_grava_log(ls_MSG)		
	Return False
End If 	

// Lista com Dados da tabela log_exportacao_scanntech
If Not lds_2.of_ChangeDataObject("ds_ge538_log_export_scanntech", False) Then
	ls_MSG = "Scanntech.(of_envia_email_diario): Carga ds_ge538_log_export_scanntech"
	gvo_aplicacao.of_grava_log(ls_MSG)		
	Return False
End If 	

ll_Linhas = lds_1.Retrieve()

If ll_Linhas > 0 Then 	
	
	/* 
	Se hover montagem padr$$HEX1$$e300$$ENDHEX$$o do email...
	Consulta se existem dados Pendentes de Processamento na tabela log_exportacao_scanntech 
	Usando a data atual sem horas:minutos:segundos, colocando  no lugar 00:00:00
	*/
	ldt_consulta_log = datetime(date(today()))
	/*
	Armazena a quantidade de linhas com processamento pendente para usar mais tarde com o
	mecanismo (ldt_consulta_log - 5 dias)
	*/
	ll_Qtd_Pendente = lds_2.retrieve(ldt_consulta_log)
	
	/* 
	Motagem padr$$HEX1$$e300$$ENDHEX$$o do email em 06/06/2022 
	*/
	For ll_Linha = 1 to ll_Linhas 
		ls_Tipo				= Trim( lds_1.Object.tipo[ll_Linha])
		ldh_DataInicio		= lds_1.Object.datainicio[ll_Linha]
		ldh_DataTermino	= lds_1.Object.datatermino[ll_Linha]
		ll_Bloco				= lds_1.Object.nr_bloco[ll_Linha]
		ldt_DataIni			= String(ldh_DataInicio, "dd/mm/yyyy hh:mm")
		ldt_DataFim			= String(ldh_DataTermino, "dd/mm/yyyy hh:mm")
		ls_Dados_Email += "<tr>"+&
								"<td >" + string(ls_Tipo) + "~n</td>"+&
								"<td>" + ldt_DataIni+ "~n</td>"+&
								"<td>" + ldt_DataIni+ "~n</td>"+&						
								"<td align='center'>" + String(ll_Bloco) + "~n</td>"+&									
								 "</tr>"
	Next
		
	//// Consulta para verificar se precisa cadastro de filial Scanntech
	SELECT count(*) 
     INTO :ll_Qtd_filiais
     FROM log_exportacao_scanntech_loja a
          INNER JOIN filial b on b.cd_filial  = a.cd_filial 
    WHERE cd_filial_scanntech IS NULL 
      AND a.cd_filial <> 534  
      AND b.id_situacao = 'A'
    USING SqlCA;
	
	If SqlCA.sqlcode = -1 Then
		ls_MSG = 'Objeto: ' + this.classname() + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_envia_email_diario~nProblemas ao consultar a tabela "log_exportacao_scanntech_loja": ~n' + sqlca.sqlerrtext
		gvo_aplicacao.of_grava_log(ls_MSG)		
		Return False
	End if
			
	If ll_Qtd_filiais  > 0  Then 
		ls_Texto_Filial = "Aten$$HEX2$$e700e300$$ENDHEX$$o! Verifique o Cadastro de Filiais Scanntech No Compras. Existem filiais sem associa$$HEX2$$e700e300$$ENDHEX$$o!"		
	Else
		ls_Texto_Filial = "Cadastro de Filiais Scanntech No Compras esta completo!"
	End If 
   
	/* 
	Havendo Pend$$HEX1$$ea00$$ENDHEX$$ncias no Processamento, monta parte correspondete aos detalhes para envio
	do Email
	*/
	if ll_Qtd_Pendente > 0 then
		/* Monta todas as linhas pendentes */
		For ll_Linha = 1 to ll_Qtd_Pendente
			ls_Tipo        = Trim(lds_2.Object.tipo[ll_Linha])
			ldh_DataInicio = lds_2.Object.DataMovimento[ll_Linha]
			ldt_DataIni	   = String(ldh_DataInicio, "DD/MM/YYYY")
			ll_qtd         = lds_2.Object.qtd[ll_Linha]
			
			ls_pendencias += "<tr>"+&
								  "<td >" + string(ls_Tipo) + "~n</td>"+&
								  "<td>" + ldt_DataIni+ "~n</td>"+&
								  "<td align='center'>" + String(ll_qtd) + "~n</td>"+&									
								  "</tr>"
		Next
		
		/* Monta o corpo do email com as pend$$HEX1$$ea00$$ENDHEX$$ncias encontradas */
		ls_pend_Email  = "<BR>"										
	   ls_pend_Email += "<TABLE border=1>"
	   ls_pend_Email += "<TR>" 
	   ls_pend_Email += "<TD colspan = '4' align='center' ><B>Log  de Pend$$HEX1$$ea00$$ENDHEX$$ncias na Exporta$$HEX2$$e700e300$$ENDHEX$$o Scanntech </B></TD>"											
	   ls_pend_Email += "</TR>"
	   ls_pend_Email += "<TR  bgcolor='#ffff66'   >" 
    	ls_pend_Email += "<TD align='center'  ><b>Tipo Envio</b></TD> "	
	   ls_pend_Email += "<TD align='center'  ><b>Data Movimento</b></TD> "	
	   ls_pend_Email += "<TD align='center'  ><b>Quantidade</b></TD> "	
	   ls_pend_Email += "</TR>" 										
	   ls_pend_Email += ls_pendencias
	   ls_pend_Email += "</TABLE>"										
	end if

	/*
	Corpo de mensagem do email com o log di$$HEX1$$e100$$ENDHEX$$rio de processamento
	*/
	ls_Texto_Email =  "<HTML>"
	ls_Texto_Email += "<BODY>"
	ls_Texto_Email += "<BR>"										
	ls_Texto_Email += "<TABLE border=1>"
	ls_Texto_Email += "<TR>" 
	ls_Texto_Email += "<TD colspan = '4' align='center' ><B>Scanntech Processamentos</B></TD>"											
	ls_Texto_Email += "</TR>"
	ls_Texto_Email += "<TR  bgcolor='#ffff66'   >" 
	ls_Texto_Email += "<TD align='center'  ><b>Tipo Envio</b></TD> "	
	ls_Texto_Email += "<TD align='center'  ><b>Inicio</b></TD> "	
	ls_Texto_Email += "<TD align='center'  ><b>T$$HEX1$$e900$$ENDHEX$$rmino</b></TD> "	
	ls_Texto_Email += "<TD align='center'  ><b>N$$HEX1$$fa00$$ENDHEX$$mero Bloco</b></TD> "	
	ls_Texto_Email += "</TR>" 										
	ls_Texto_Email += ls_Dados_Email
	ls_Texto_Email += "</TABLE>"										
	ls_Texto_Email += "<BR>Em caso de n$$HEX1$$e300$$ENDHEX$$o Processado(DataVazia) Acesse o Monitor Scanntech - > Sistema Compras</BR>"									
	ls_Texto_Email += "<BR>Para cada Dia deve ter Envios de Venda e Um Envio de Fechamento</BR>"									
	ls_Texto_Email += "<BR><b>" + String(ls_Texto_Filial) + "</b></BR>"
	ls_Texto_Email += "<BR><b>O prazo para entrega dos dados $$HEX1$$e900$$ENDHEX$$ de 36 horas</b></BR>"
	/*
	Insere aqui (se houver), log com pend$$HEX1$$ea00$$ENDHEX$$ncias de processamento de
	Fechamento e Vendas encontradas na tabela log_exportacao_scanntech
	Coforme regra estabelecidade de (-5) dias e id_situacao = 'P'
	*/
	ls_Texto_Email += ls_pend_Email
	/*
	Faz o fechamento do E-Mail para envio...
	*/ 
	ls_Texto_Email += "</BODY>"
	ls_Texto_Email += "</HTML>" 
		
	str.ps_Mensagem	= ls_Texto_Email 
	str.pb_Assinatura	= True
	gf_ge202_envia_email_padrao(280, str)
End If 

Destroy (lds_1) 
Return True 
end function

public function boolean of_reprocesar_filiais (long al_cd_filial, datetime adh_processamento);datetime ldt_null, ldh_inicio, ldh_fim

/* For$$HEX1$$e700$$ENDHEX$$a Null (Nulo) como valor da vari$$HEX1$$e100$$ENDHEX$$vel */
setnull(ldt_null)

/* Transforma o parametro recebido para conter hora inicial e final para pegar dia cheio */
ldh_inicio = DateTime(String(date(adh_processamento)) + ' 00:00:00.000')
ldh_fim = DateTime(String(date(adh_processamento)) + ' 23:59:59.000')
		
UPDATE log_exportacao_scanntech
   SET id_situacao = 'P'
 WHERE cd_filial = :al_cd_filial
   AND dh_movimentacao_caixa BETWEEN :ldh_inicio AND :ldh_fim
	AND id_tipo_envio = 'F'
	AND id_situacao = 'S'
USING SQLCA;

if sqlca.sqlcode = -1 then
   gvo_aplicacao.of_Grava_Log("Aten$$HEX2$$e700e300$$ENDHEX$$o - Erro ao alterar LOG_EP. " + sqlca.sqlerrtext)
   SqlCa.of_rollback( ); 
   Return False
else
	SqlCa.of_commit( ); 	 
end if

Return True		
		
UPDATE log_scanntech_proc 
   SET dh_terminio = :ldt_null
 WHERE dh_inicio between :ldh_inicio and :ldh_fim
   AND id_bloco = 0
	AND id_tipo_envio = 'F'
   AND dh_terminio is not null
 USING SQLCA;

if sqlca.sqlcode = -1 then
	gvo_aplicacao.of_grava_log("Erro ao Atualizar dados do LOG Processamento Scanntech")
	SqlCa.of_rollback( ); 
	return false
else
	SqlCa.of_commit( ); 	 
end if

return true
end function

public function boolean of_liberar_movimento_processamento (date pdh_movimento_inicio, date pdh_movimento_fim, long pl_cd_filial);DateTime ldh_data_1, &
			ldh_data_2


ldh_data_1 =  DateTime(String(pdh_movimento_inicio) + ' 00:00:00.000')
ldh_data_2 =  DateTime(String(pdh_movimento_fim) + ' 23:59:59.999')

Delete From 
	log_exportacao_scanntech
Where 
	dh_movimentacao_caixa BETWEEN :ldh_data_1 AND :ldh_data_2
	and cd_filial = coalesce(:pl_cd_filial, cd_filial)
Using 
	Sqlca;

If sqlca.sqlcode = -1 Then
   gvo_aplicacao.of_Grava_Log("Aten$$HEX2$$e700e300$$ENDHEX$$o - Erro ao exlcuir movimento Scanntech. " + sqlca.sqlerrtext)
   SqlCa.of_rollback( ); 
   Return False
End if	  

Update 
	log_scanntech_proc
Set 
	dh_terminio = Null
Where 
	dh_inicio BETWEEN :ldh_data_1 AND :ldh_data_2
Using Sqlca;

If sqlca.sqlcode = -1 Then
   gvo_aplicacao.of_Grava_Log("Aten$$HEX2$$e700e300$$ENDHEX$$o - Erro ao atualizar tabela Log Scanntech Processamento. " + sqlca.sqlerrtext)
   SqlCa.of_rollback( ); 
   Return False
End if	  

SqlCa.of_commit( ); 	 

Return True
end function

on uo_ge538_scanntech_lote.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge538_scanntech_lote.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

