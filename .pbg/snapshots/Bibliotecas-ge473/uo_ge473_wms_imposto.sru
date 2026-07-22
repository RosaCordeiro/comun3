HA$PBExportHeader$uo_ge473_wms_imposto.sru
forward
global type uo_ge473_wms_imposto from nonvisualobject
end type
end forward

global type uo_ge473_wms_imposto from nonvisualobject
end type
global uo_ge473_wms_imposto uo_ge473_wms_imposto

type variables
long il_ano_documento
datetime idt_dt_documento
string is_log_criacao_doc
string is_nr_documento
string is_nr_solicitacao

Long il_Tabela[] = {113,114,115,116,117,118}
Long il_nr_requisicao

boolean ib_execucao_simultanea=false

String is_de_chave_acesso_sap
Long 	 il_nr_controle_interface_sap

Constant String IS_ERRO_NAO_ENCONTROU 	= "REGRA NAO ENCONTRADA na log_exportacao_j1btax_item"
Constant String IS_ERRO_ENCONTROU_MAIS	= "REGRA ENCONTRADA MAIS QUE UMA VEZ na log_exportacao_j1btax_item"
end variables

forward prototypes
public function boolean of_atualiza_imposto (long al_controle, long al_tabela)
public subroutine of_processa_atualizacao (long al_tabela)
public function boolean of_insere_pis (uo_ge473_comum acomum, ref string as_log)
public function boolean of_insere_cofins (uo_ge473_comum acomum, ref string as_log)
public function boolean of_insere_icms (uo_ge473_comum acomum, ref string as_log)
public function boolean of_insere_ipi (uo_ge473_comum acomum, ref string as_log)
public function boolean of_insere_iss (uo_ge473_comum acomum, ref string as_log)
public function boolean of_insere_st (uo_ge473_comum acomum, ref string as_log)
public subroutine of_ajusta_zeros_esquerda (ref string ps_value)
public function datetime of_trata_data (string ps_data)
public function boolean of_finaliza_log_exportacao_j1btax (ref string ps_log)
public subroutine of_insere_log_erro (long pl_nr_controle, string ps_erro, string ps_id_imposto, string ps_id_subida_descida, string ps_cd_ambiente_sap, string ps_mandt, string ps_country, string ps_gruop, string ps_land1, string ps_shipfrom, string ps_shipto, string ps_value, string ps_value2, string ps_value3, string ps_stgrp, datetime pdh_validfrom)
end prototypes

public function boolean of_atualiza_imposto (long al_controle, long al_tabela);Boolean 	lb_Sucesso = False
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
	
	il_nr_controle_interface_sap = al_controle

	If Not lo_Comum.of_atualizacao_pendente(al_Controle, Ref ll_Atualizacao_Pend, Ref ls_Log) Then Return False

	//Controle j$$HEX1$$e100$$ENDHEX$$ foi processado
	If ll_Atualizacao_Pend = 0 Then Return True
	
	If Not lo_Comum.of_Muda_Situacao_Interface(al_Controle, Ref ls_Log) Then Return False
	If Not lo_Comum.of_localiza_chave_controle(al_Controle, Ref ls_Chave_Controle, Ref ls_Log) Then Return False
	
	if isvalid(w_aguarde_3) Then
		w_aguarde_3.wf_settext("Iniciando atualiza$$HEX2$$e700e300$$ENDHEX$$o...", 3 )
	end if
	
	If lo_Comum.of_processa_carrega_dados(al_controle , ref ls_Log) Then
		
		ll_Linhas = lo_Comum.ids_lista_registros.RowCount()
		
		if isvalid(w_aguarde_3) Then
			w_aguarde_3.uo_progress_2.of_reset()
			w_aguarde_3.uo_progress_2.of_setmax(ll_linhas)
		end if
		
		choose case al_tabela
			case 113
				lb_Sucesso	= this.of_insere_icms(lo_Comum, Ref ls_Log)
			case 114
				lb_Sucesso	= this.of_insere_st(lo_Comum, Ref ls_Log)
			case 115
				lb_Sucesso	= this.of_insere_pis(lo_Comum, Ref ls_Log)
			case 116
				lb_Sucesso	= this.of_insere_cofins(lo_Comum, Ref ls_Log)
			case 117
				lb_Sucesso	= this.of_insere_iss(lo_Comum, Ref ls_Log)
			case 118
				lb_Sucesso	= this.of_insere_ipi(lo_Comum, Ref ls_Log)
		end choose
		
		// Ao terminar de atualizar, caso a atualiza$$HEX2$$e700e300$$ENDHEX$$o seja originada por uma exporta$$HEX2$$e700e300$$ENDHEX$$o
		// Deve conferir se o log_exportacao_j1btax_item ainda possui pend$$HEX1$$ea00$$ENDHEX$$ncias
		If lb_Sucesso Then
			If Long(is_de_chave_acesso_sap) > 0 Then
				lb_Sucesso = this.of_finaliza_log_exportacao_j1btax(Ref ls_Log)
			End If
		End If
		
		if isvalid(w_aguarde_3) Then
			w_aguarde_3.uo_progress_2.of_setprogress(1)
		end if	
	End If
Catch ( runtimeerror  lo_rte )
	ls_Log = "Objeto [uo_ge473_wms_imposto], fun$$HEX2$$e700e300$$ENDHEX$$o [of_atualiza_imposto]. Erro: "+lo_rte.GetMessage( )
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

public subroutine of_processa_atualizacao (long al_tabela);Long ll_Linhas
Long ll_Linha, ll_nr_controle, ll_controles_gerando

dc_uo_ds_base lds 

try 
	
	lds  = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject('ds_ge473_lista_controles', False) Then 
		gvo_aplicacao.of_grava_log("Interface Imposto - Erro alterar a DW [ds_ge473_lista_controles] - uo_ge473_wms_imposto.of_processa_atualizacao" )
		Return
	End If
	
	ll_Linhas = lds.Retrieve(al_Tabela)
	
	If ll_Linhas > 0 Then
		For ll_Linha = 1 To ll_Linhas
			
			if ib_execucao_simultanea = True Then
				//
			else
			
				uo_ge473_wms_imposto	lo_imposto
				 
				Try
					lo_imposto	= Create uo_ge473_wms_imposto
					lo_imposto.of_atualiza_imposto( lds.Object.nr_controle[ll_Linha],al_tabela )
	
				Finally
					Destroy(lo_imposto)
				End Try			
			
			end if
			
		Next
	ElseIf ll_Linhas < 0 Then
		gvo_aplicacao.of_grava_log("Interface Imposto - Erro ao recuperar os da DW [ds_ge473_lista_controles] - uo_ge473_imposto.of_processa_atualizacao.")
	End If	
	
finally
	Destroy lds
end try
end subroutine

public function boolean of_insere_pis (uo_ge473_comum acomum, ref string as_log);DateTime		ldt_validfrom, ldt_validto
Dec{2}		ldc_rate, ldc_base, ldc_amount, ldc_factor, ldc_minprice_amount
Dec{3}		ldc_minprice_quantity
Dec{4}		ldc_rate4dec, ldc_amount4dec, ldc_factor4dec
Long			ll_exists, ll_for, ll_de_chave_sap, ll_count
String		ls_mandt, ls_country, ls_gruop, ls_value, ls_value2, ls_value3, ls_unit, ls_waers, &
				ls_taxlaw, ls_minprice_currency, ls_minprice_uom, ls_minprice_taxlaw, ls_ambiente_sap, &
				ls_de_chave_sap

String 		ls_land1, ls_shipfrom, ls_shipto, ls_stgrp
		
SetNull(ls_land1)
SetNull(ls_shipfrom)
SetNull(ls_shipto)
SetNull(ls_stgrp)
ll_count = aComum.ids_lista_registros.RowCount()

for ll_for = 1 to ll_count
	// <DE_CHAVE_SAP> quando informado, $$HEX1$$e900$$ENDHEX$$ o nr_controle da log_exportacao_j1btax da subida
	// Deve sinalizar a regra que subiu como retornada
	ll_de_chave_sap		= Long(is_de_chave_acesso_sap)
	
	if isvalid(w_aguarde_3) Then
		w_aguarde_3.uo_progress_2.of_SetProgress(ll_for)
		w_aguarde_3.wf_settext("Atualizando regras | Controle: "+String(ll_de_chave_sap) + " ("+String(ll_for)+"/"+String(ll_count)+")", 3 )
	end if
	
	ls_mandt					= aComum.ids_lista_registros.Object.mandt[ll_for]
	ls_country					= aComum.ids_lista_registros.Object.country[ll_for]
	ls_gruop						= aComum.ids_lista_registros.Object.gruop[ll_for]
	ls_value						= aComum.ids_lista_registros.Object.value[ll_for]
	ls_value2					= aComum.ids_lista_registros.Object.value2[ll_for]
	ls_value3					= aComum.ids_lista_registros.Object.value3[ll_for]
	ldt_validfrom				= of_trata_data(aComum.ids_lista_registros.Object.validfrom[ll_for])
	ldt_validto					= of_trata_data(aComum.ids_lista_registros.Object.validto[ll_for])
	ldc_rate						= Dec(gf_replace(aComum.ids_lista_registros.Object.rate[ll_for], '.', ',', 0))
	ldc_base						= Dec(gf_replace(aComum.ids_lista_registros.Object.base[ll_for], '.', ',', 0))
	ldc_amount					= Dec(gf_replace(aComum.ids_lista_registros.Object.amount[ll_for], '.', ',', 0))
	ldc_factor					= Dec(gf_replace(aComum.ids_lista_registros.Object.factor[ll_for], '.', ',', 0))
	ls_unit						= aComum.ids_lista_registros.Object.unit[ll_for]
	ls_waers						= aComum.ids_lista_registros.Object.waers[ll_for]
	ls_taxlaw					= aComum.ids_lista_registros.Object.taxlaw[ll_for]
	ldc_rate4dec				= Dec(aComum.ids_lista_registros.Object.rate4dec[ll_for])
	ldc_amount4dec				= Dec(aComum.ids_lista_registros.Object.amount4dec[ll_for])
	ldc_factor4dec				= Dec(aComum.ids_lista_registros.Object.factor4dec[ll_for])
	ldc_minprice_amount		= Dec(aComum.ids_lista_registros.Object.minprice_amount[ll_for])
	ls_minprice_currency		= aComum.ids_lista_registros.Object.minprice_currency[ll_for]
	ldc_minprice_quantity	= Dec(aComum.ids_lista_registros.Object.minprice_quantity[ll_for])
	ls_minprice_uom			= aComum.ids_lista_registros.Object.minprice_uom[ll_for]
	ls_minprice_taxlaw		= aComum.ids_lista_registros.Object.minprice_taxlaw[ll_for]
	ls_ambiente_sap			= aComum.ids_lista_registros.Object.cd_ambiente_sap[ll_for]
	
	If ls_ambiente_sap = 'S4P' then ls_ambiente_sap = 'PRD'
		
	if IsNull(ls_value) then ls_value = ''
	if IsNull(ls_value2) then ls_value2 = ''
	if IsNull(ls_value3) then ls_value3 = ''
	
	
	Choose Case ls_gruop
		Case '49', '65'
			of_Ajusta_Zeros_Esquerda(Ref ls_value)
			
	End Choose

	ls_de_chave_sap 		= "SAP" // Para regras que desceram por altera$$HEX2$$e700e300$$ENDHEX$$o direto no SAP
	If ll_de_chave_sap > 0 Then
		ls_de_chave_sap = String(ll_de_chave_sap) // Se subiu e desceu, vai guardar o controle na tabela btax
		
		update log_exportacao_j1btax_item
		set 		dh_retorno_sap = GetDate()
		where		nr_controle = :ll_de_chave_sap
			and country			= :ls_country and
				 gruop			= :ls_gruop and
				 value			= :ls_value and
				 value2			= :ls_value2 and
				 value3			= :ls_value3
		using SQLCA;
		
		If SqlCa.sqlcode = -1 Then
			as_Log = "Erro ao atualizar dh_retorno_sap da log_exportacao_j1btax_item. Erro: "+SqlCa.sqlErrText
			Return False
		End If

		// Se n$$HEX1$$e300$$ENDHEX$$o atualizou nada ou aualizou mais que 1, gravar um log pra identificar depois
		Choose Case SqlCa.SqlNRows
			Case 0
				of_insere_log_erro(ll_de_chave_sap, IS_ERRO_NAO_ENCONTROU, "PIS", 'D', ls_ambiente_sap, ls_mandt, ls_country, ls_gruop, &
							ls_land1, ls_shipfrom, ls_shipto, ls_value, ls_value2, ls_value3, ls_stgrp, ldt_validfrom)
			Case is > 1
				of_insere_log_erro(ll_de_chave_sap, IS_ERRO_ENCONTROU_MAIS, "PIS", 'D', ls_ambiente_sap, ls_mandt, ls_country, ls_gruop, &
							ls_land1, ls_shipfrom, ls_shipto, ls_value, ls_value2, ls_value3, ls_stgrp, ldt_validfrom)
		End Choose
	End If
	
	// Antes de inserir ou alterar uma nova regra, apagar a mesma regra com data inicial menor, caso exista.
	// Feito isso para n$$HEX1$$e300$$ENDHEX$$o precisar descer o encerramento caso des$$HEX1$$e700$$ENDHEX$$a abertura e manter s$$HEX1$$f300$$ENDHEX$$ as mais recentes no Sybase.
	DELETE FROM j_1btxpis
	WHERE mandt			= :ls_mandt and
		 country			= :ls_country and
		 gruop			= :ls_gruop and
		 value			= :ls_value and
		 value2			= :ls_value2 and
		 value3			= :ls_value3 and
		 validfrom		< :ldt_validfrom and
		 cd_ambiente	= :ls_ambiente_sap;
	
	ll_exists	= 0
	
	select 1
	  into :ll_exists
	  from j_1btxpis
	 where mandt			= :ls_mandt and
			 country			= :ls_country and
			 gruop			= :ls_gruop and
			 value			= :ls_value and
			 value2			= :ls_value2 and
			 value3			= :ls_value3 and
			 validfrom		= :ldt_validfrom and
			 cd_ambiente	= :ls_ambiente_sap;
	
	If SqlCa.sqlcode = -1 Then
		as_Log = "Erro ao verificar existencia de registro na tabela j_1btxpis. Erro: "+SqlCa.sqlErrText
		Return False
	End If	
	
	if ll_exists = 1 then
		update j_1btxpis
			set validto					= :ldt_validto,
				 rate						= :ldc_rate,
				 base						= :ldc_base,
				 amount					= :ldc_amount,
				 factor					= :ldc_factor,
				 unit						= :ls_unit,
				 waers					= :ls_waers,
				 taxlaw					= :ls_taxlaw,
				 rate4dec				= :ldc_rate4dec,
				 amount4dec				= :ldc_amount4dec,
				 factor4dec				= :ldc_factor4dec,
				 minprice_amount		= :ldc_minprice_amount,
				 minprice_currency	= :ls_minprice_currency,
				 minprice_quantity	= :ldc_minprice_quantity,
				 minprice_uom			= :ls_minprice_uom,
				 minprice_taxlaw		= :ls_minprice_taxlaw,
				 dh_alteracao			= GetDate(),
				 de_chave_sap  		= :ls_de_chave_sap,
				 nr_controle_interface_sap = :il_nr_controle_interface_sap
		 where mandt			= :ls_mandt and
				 country			= :ls_country and
				 gruop			= :ls_gruop and
				 value			= :ls_value and
				 value2			= :ls_value2 and
				 value3			= :ls_value3 and
				 validfrom		= :ldt_validfrom and
				 cd_ambiente	= :ls_ambiente_sap;
				 
		If SqlCa.sqlcode = -1 Then
			as_Log = "Erro ao atualizar registro na tabela j_1btxpis. Erro: "+SqlCa.sqlErrText
			Return False
		End If	
	else
		INSERT INTO j_1btxpis  
					( mandt,   
					  country,   
					  gruop,   
					  value,   
					  value2,   
					  value3,   
					  validfrom,   
					  validto,   
					  rate,   
					  base,   
					  amount,   
					  factor,   
					  unit,   
					  waers,   
					  taxlaw,   
					  rate4dec,   
					  amount4dec,   
					  factor4dec,   
					  minprice_amount,   
					  minprice_currency,   
					  minprice_quantity,   
					  minprice_uom,   
					  minprice_taxlaw,   
					  dh_inclusao,   
					  dh_alteracao,
					  cd_ambiente,
				  	  de_chave_sap,
				  	  nr_controle_interface_sap)  
		  VALUES ( :ls_mandt,   
					  :ls_country,
					  :ls_gruop,
					  :ls_value,
					  :ls_value2,
					  :ls_value3,
					  :ldt_validfrom,
					  :ldt_validto,
					  :ldc_rate,
					  :ldc_base,
					  :ldc_amount,
					  :ldc_factor,
					  :ls_unit,
					  :ls_waers,
					  :ls_taxlaw,
					  :ldc_rate4dec,
					  :ldc_amount4dec,
					  :ldc_factor4dec,
					  :ldc_minprice_amount,
					  :ls_minprice_currency,
					  :ldc_minprice_quantity,
					  :ls_minprice_uom,
					  :ls_minprice_taxlaw,
					  GetDate(),
					  GetDate(),
					  :ls_ambiente_sap,
				  	  :ls_de_chave_sap,
				  	  :il_nr_controle_interface_sap);
					  
		If SqlCa.sqlcode = -1 Then
			as_Log = "Erro ao inserir registro na tabela j_1btxpis. Erro: "+SqlCa.sqlErrText
			Return False
		End If	
	end if
next

return true
end function

public function boolean of_insere_cofins (uo_ge473_comum acomum, ref string as_log);DateTime		ldt_validfrom, ldt_validto
Dec{2}		ldc_rate, ldc_base, ldc_amount, ldc_factor, ldc_minprice_amount
Dec{3}		ldc_minprice_quantity
Dec{4}		ldc_rate4dec, ldc_amount4dec, ldc_factor4dec
Long			ll_exists, ll_for, ll_de_chave_sap, ll_count
String		ls_mandt, ls_country, ls_gruop, ls_value, ls_value2, ls_value3, ls_unit, ls_waers, &
				ls_taxlaw, ls_minprice_currency, ls_minprice_uom, ls_minprice_taxlaw, ls_ambiente_sap, &
				ls_de_chave_sap

String 		ls_land1, ls_shipfrom, ls_shipto, ls_stgrp
		
SetNull(ls_land1)
SetNull(ls_shipfrom)
SetNull(ls_shipto)
SetNull(ls_stgrp)
ll_count = aComum.ids_lista_registros.RowCount()

for ll_for = 1 to ll_count
	// <DE_CHAVE_SAP> quando informado, $$HEX1$$e900$$ENDHEX$$ o nr_controle da log_exportacao_j1btax da subida
	// Deve sinalizar a regra que subiu como retornada
	ll_de_chave_sap		= Long(is_de_chave_acesso_sap)
	
	if isvalid(w_aguarde_3) Then
		w_aguarde_3.uo_progress_2.of_SetProgress(ll_for)
		w_aguarde_3.wf_settext("Atualizando regras | Controle: "+String(ll_de_chave_sap) + " ("+String(ll_for)+"/"+String(ll_count)+")", 3 )
	end if
	
	ls_mandt						= aComum.ids_lista_registros.Object.mandt[ll_for]
	ls_country					= aComum.ids_lista_registros.Object.country[ll_for]
	ls_gruop						= aComum.ids_lista_registros.Object.gruop[ll_for]
	ls_value						= aComum.ids_lista_registros.Object.value[ll_for]
	ls_value2					= aComum.ids_lista_registros.Object.value2[ll_for]
	ls_value3					= aComum.ids_lista_registros.Object.value3[ll_for]
	ldt_validfrom				= of_trata_data(aComum.ids_lista_registros.Object.validfrom[ll_for])
	ldt_validto					= of_trata_data(aComum.ids_lista_registros.Object.validto[ll_for])
	ldc_rate						= Dec(gf_replace(aComum.ids_lista_registros.Object.rate[ll_for], '.', ',', 0))
	ldc_base						= Dec(gf_replace(aComum.ids_lista_registros.Object.base[ll_for], '.', ',', 0))
	ldc_amount					= Dec(gf_replace(aComum.ids_lista_registros.Object.amount[ll_for], '.', ',', 0))
	ldc_factor					= Dec(gf_replace(aComum.ids_lista_registros.Object.factor[ll_for], '.', ',', 0))
	ls_unit						= aComum.ids_lista_registros.Object.unit[ll_for]
	ls_waers						= aComum.ids_lista_registros.Object.waers[ll_for]
	ls_taxlaw					= aComum.ids_lista_registros.Object.taxlaw[ll_for]
	ldc_rate4dec				= Dec(aComum.ids_lista_registros.Object.rate4dec[ll_for])
	ldc_amount4dec				= Dec(aComum.ids_lista_registros.Object.amount4dec[ll_for])
	ldc_factor4dec				= Dec(aComum.ids_lista_registros.Object.factor4dec[ll_for])
	ldc_minprice_amount		= Dec(aComum.ids_lista_registros.Object.minprice_amount[ll_for])
	ls_minprice_currency		= aComum.ids_lista_registros.Object.minprice_currency[ll_for]
	ldc_minprice_quantity	= Dec(aComum.ids_lista_registros.Object.minprice_quantity[ll_for])
	ls_minprice_uom			= aComum.ids_lista_registros.Object.minprice_uom[ll_for]
	ls_minprice_taxlaw		= aComum.ids_lista_registros.Object.minprice_taxlaw[ll_for]
	ls_ambiente_sap			= aComum.ids_lista_registros.Object.cd_ambiente_sap[ll_for]
	
	If ls_ambiente_sap = 'S4P' then ls_ambiente_sap = 'PRD'
	
	if IsNull(ls_value) then ls_value = ''
	if IsNull(ls_value2) then ls_value2 = ''
	if IsNull(ls_value3) then ls_value3 = ''
	
	Choose Case ls_gruop
		Case '49', '65'
			of_Ajusta_Zeros_Esquerda(Ref ls_value)
			
	End Choose
	
	ls_de_chave_sap 		= "SAP" // Para regras que desceram por altera$$HEX2$$e700e300$$ENDHEX$$o direto no SAP
	If ll_de_chave_sap > 0 Then
		ls_de_chave_sap = String(ll_de_chave_sap) // Se subiu e desceu, vai guardar o controle na tabela btax
		
		update log_exportacao_j1btax_item
		set 		dh_retorno_sap = GetDate()
		where		nr_controle = :ll_de_chave_sap
			and country			= :ls_country and
				 gruop			= :ls_gruop and
				 value			= :ls_value and
				 value2			= :ls_value2 and
				 value3			= :ls_value3
		using SQLCA;
		
		If SqlCa.sqlcode = -1 Then
			as_Log = "Erro ao atualizar dh_retorno_sap da log_exportacao_j1btax_item. Erro: "+SqlCa.sqlErrText
			Return False
		End If
		
		// Se n$$HEX1$$e300$$ENDHEX$$o atualizou nada ou aualizou mais que 1, gravar um log pra identificar depois
		Choose Case SqlCa.SqlNRows
			Case 0
				of_insere_log_erro(ll_de_chave_sap, IS_ERRO_NAO_ENCONTROU, "COFINS", 'D', ls_ambiente_sap, ls_mandt, ls_country, ls_gruop, &
							ls_land1, ls_shipfrom, ls_shipto, ls_value, ls_value2, ls_value3, ls_stgrp, ldt_validfrom)
			Case is > 1
				of_insere_log_erro(ll_de_chave_sap, IS_ERRO_ENCONTROU_MAIS, "COFINS", 'D', ls_ambiente_sap, ls_mandt, ls_country, ls_gruop, &
							ls_land1, ls_shipfrom, ls_shipto, ls_value, ls_value2, ls_value3, ls_stgrp, ldt_validfrom)
		End Choose
		
	End If
	
	// Antes de inserir ou alterar uma nova regra, apagar a mesma regra com data inicial menor, caso exista.
	// Feito isso para n$$HEX1$$e300$$ENDHEX$$o precisar descer o encerramento caso des$$HEX1$$e700$$ENDHEX$$a abertura e manter s$$HEX1$$f300$$ENDHEX$$ as mais recentes no Sybase.
	DELETE FROM j_1btxcof
	WHERE mandt			= :ls_mandt and
		 country			= :ls_country and
		 gruop			= :ls_gruop and
		 value			= :ls_value and
		 value2			= :ls_value2 and
		 value3			= :ls_value3 and
		 validfrom		< :ldt_validfrom and
		 cd_ambiente	= :ls_ambiente_sap;
	
	ll_exists	= 0
	
	select 1
	  into :ll_exists
	  from j_1btxcof
	 where mandt			= :ls_mandt and
			 country			= :ls_country and
			 gruop			= :ls_gruop and
			 value			= :ls_value and
			 value2			= :ls_value2 and
			 value3			= :ls_value3 and
			 validfrom		= :ldt_validfrom and
			 cd_ambiente	= :ls_ambiente_sap;
	
	If SqlCa.sqlcode = -1 Then
		as_Log = "Erro ao verificar existencia de registro na tabela j_1btxcof. Erro: "+SqlCa.sqlErrText
		Return False
	End If	
	
	if ll_exists = 1 then
		update j_1btxcof
			set validto					= :ldt_validto,
				 rate						= :ldc_rate,
				 base						= :ldc_base,
				 amount					= :ldc_amount,
				 factor					= :ldc_factor,
				 unit						= :ls_unit,
				 waers					= :ls_waers,
				 taxlaw					= :ls_taxlaw,
				 rate4dec				= :ldc_rate4dec,
				 amount4dec				= :ldc_amount4dec,
				 factor4dec				= :ldc_factor4dec,
				 minprice_amount		= :ldc_minprice_amount,
				 minprice_currency	= :ls_minprice_currency,
				 minprice_quantity	= :ldc_minprice_quantity,
				 minprice_uom			= :ls_minprice_uom,
				 minprice_taxlaw		= :ls_minprice_taxlaw,
				 dh_alteracao			= GetDate(),
				 de_chave_sap  		= :ls_de_chave_sap,
				 nr_controle_interface_sap = :il_nr_controle_interface_sap
		 where mandt			= :ls_mandt and
				 country			= :ls_country and
				 gruop			= :ls_gruop and
				 value			= :ls_value and
				 value2			= :ls_value2 and
				 value3			= :ls_value3 and
				 validfrom		= :ldt_validfrom and
				 cd_ambiente	= :ls_ambiente_sap;
				 
		If SqlCa.sqlcode = -1 Then
			as_Log = "Erro ao atualizar registro na tabela j_1btxcof. Erro: "+SqlCa.sqlErrText
			Return False
		End If	
	else
		INSERT INTO j_1btxcof  
					( mandt,   
					  country,   
					  gruop,   
					  value,   
					  value2,   
					  value3,   
					  validfrom,   
					  validto,   
					  rate,   
					  base,   
					  amount,   
					  factor,   
					  unit,   
					  waers,   
					  taxlaw,   
					  rate4dec,   
					  amount4dec,   
					  factor4dec,   
					  minprice_amount,   
					  minprice_currency,   
					  minprice_quantity,   
					  minprice_uom,   
					  minprice_taxlaw,   
					  dh_inclusao,   
					  dh_alteracao,
					  cd_ambiente,
				  	  de_chave_sap,
				  	  nr_controle_interface_sap)  
		  VALUES ( :ls_mandt,   
					  :ls_country,
					  :ls_gruop,
					  :ls_value,
					  :ls_value2,
					  :ls_value3,
					  :ldt_validfrom,
					  :ldt_validto,
					  :ldc_rate,
					  :ldc_base,
					  :ldc_amount,
					  :ldc_factor,
					  :ls_unit,
					  :ls_waers,
					  :ls_taxlaw,
					  :ldc_rate4dec,
					  :ldc_amount4dec,
					  :ldc_factor4dec,
					  :ldc_minprice_amount,
					  :ls_minprice_currency,
					  :ldc_minprice_quantity,
					  :ls_minprice_uom,
					  :ls_minprice_taxlaw,
					  GetDate(),
					  GetDate(),
					  :ls_ambiente_sap,
				  	  :ls_de_chave_sap,
				  	  :il_nr_controle_interface_sap);
					  
		If SqlCa.sqlcode = -1 Then
			as_Log = "Erro ao inserir registro na tabela j_1btxcof. Erro: "+SqlCa.sqlErrText
			Return False
		End If	
	end if
next

return true
end function

public function boolean of_insere_icms (uo_ge473_comum acomum, ref string as_log);DateTime		ldt_validfrom, ldt_validto
Dec{2}		ldc_rate, ldc_base, ldc_specf_rate, ldc_specf_base
Long			ll_exists, ll_for, ll_de_chave_sap, ll_count
String		ls_mandt, ls_land1, ls_shipfrom, ls_shipto, ls_gruop, ls_value, ls_value2, ls_value3, &
				ls_exempt, ls_taxlaw, ls_conven100, ls_partilha_exempt, ls_specf_resale, ls_ambiente_sap, &
				ls_de_chave_sap
				
String		ls_country, ls_stgrp

SetNull(ls_country)
SetNull(ls_stgrp)
ll_count = aComum.ids_lista_registros.RowCount()

for ll_for = 1 to ll_count
	// <DE_CHAVE_SAP> quando informado, $$HEX1$$e900$$ENDHEX$$ o nr_controle da log_exportacao_j1btax da subida
	// Deve sinalizar a regra que subiu como retornada
	ll_de_chave_sap		= Long(is_de_chave_acesso_sap)
	
	if isvalid(w_aguarde_3) Then
		w_aguarde_3.uo_progress_2.of_SetProgress(ll_for)
		w_aguarde_3.wf_settext("Atualizando regras | Controle: "+String(ll_de_chave_sap) + " ("+String(ll_for)+"/"+String(ll_count)+")", 3 )
	end if

	ls_mandt					= aComum.ids_lista_registros.Object.mandt[ll_for]
	ls_land1					= aComum.ids_lista_registros.Object.land1[ll_for]
	ls_shipfrom				= aComum.ids_lista_registros.Object.shipfrom[ll_for]
	ls_shipto				= aComum.ids_lista_registros.Object.shipto[ll_for]
	ls_gruop					= aComum.ids_lista_registros.Object.gruop[ll_for]
	ls_value					= aComum.ids_lista_registros.Object.value[ll_for]
	ls_value2				= aComum.ids_lista_registros.Object.value2[ll_for]
	ls_value3				= aComum.ids_lista_registros.Object.value3[ll_for]
	ldt_validfrom			= of_trata_data(aComum.ids_lista_registros.Object.validfrom[ll_for])
	ldt_validto				= of_trata_data(aComum.ids_lista_registros.Object.validto[ll_for])
	ldc_rate					= Dec(gf_replace(aComum.ids_lista_registros.Object.rate[ll_for], '.', ',', 0))
	ldc_base					= Dec(gf_replace(aComum.ids_lista_registros.Object.base[ll_for], '.', ',', 0))
	ls_exempt				= aComum.ids_lista_registros.Object.exempt[ll_for]
	ls_taxlaw				= aComum.ids_lista_registros.Object.taxlaw[ll_for]
	ls_conven100			= aComum.ids_lista_registros.Object.conven100[ll_for]
	ldc_specf_rate			= Dec(gf_replace(aComum.ids_lista_registros.Object.specf_rate[ll_for], '.', ',', 0))
	ldc_specf_base			= Dec(gf_replace(aComum.ids_lista_registros.Object.specf_base[ll_for], '.', ',', 0))
	ls_partilha_exempt	= aComum.ids_lista_registros.Object.partilha_exempt[ll_for]
	ls_specf_resale		= aComum.ids_lista_registros.Object.specf_resale[ll_for]
	ls_ambiente_sap		= aComum.ids_lista_registros.Object.cd_ambiente_sap[ll_for]
	
	if isnull(ldt_validfrom) then continue
	
	If ls_ambiente_sap = 'S4P' then ls_ambiente_sap = 'PRD'
	
	if IsNull(ls_value2) then ls_value2 = ''
	if IsNull(ls_value3) then ls_value3 = ''
	
	// Tratar chaves dos grupos
	// Obrigat$$HEX1$$f300$$ENDHEX$$rio ter o campo com 18 caracteres nos casos abaixo
	// Inserindo zeros $$HEX1$$e000$$ENDHEX$$ esquerda quando necess$$HEX1$$e100$$ENDHEX$$rio
	Choose Case ls_gruop
		Case '11', '23', '49', '65'
			of_Ajusta_Zeros_Esquerda(Ref ls_value)
			
		Case '12', '14', '27', '29'
			of_Ajusta_Zeros_Esquerda(Ref ls_value2)
		
		Case '24', '25'
			of_Ajusta_Zeros_Esquerda(Ref ls_value3)
			
	End Choose
	
	ls_de_chave_sap 		= "SAP" // Para regras que desceram por altera$$HEX2$$e700e300$$ENDHEX$$o direto no SAP
	If ll_de_chave_sap > 0 Then
		ls_de_chave_sap = String(ll_de_chave_sap) // Se subiu e desceu, vai guardar o controle na tabela btax
		
		update log_exportacao_j1btax_item
		set 		dh_retorno_sap = GetDate()
		where		nr_controle = :ll_de_chave_sap
			and land1			= :ls_land1 and
				 shipfrom		= :ls_shipfrom and
				 shipto			= :ls_shipto and
				 gruop			= :ls_gruop and
				 value			= :ls_value and
				 value2			= :ls_value2 and
				 value3			= :ls_value3
		using SQLCA;
		
		If SqlCa.sqlcode = -1 Then
			as_Log = "Erro ao atualizar dh_retorno_sap da log_exportacao_j1btax_item. Erro: "+SqlCa.sqlErrText
			Return False
		End If
		
		// Se n$$HEX1$$e300$$ENDHEX$$o atualizou nada ou aualizou mais que 1, gravar um log pra identificar depois
		Choose Case SqlCa.SqlNRows
			Case 0
				of_insere_log_erro(ll_de_chave_sap, IS_ERRO_NAO_ENCONTROU, "ICMS", 'D', ls_ambiente_sap, ls_mandt, ls_country, ls_gruop, &
							ls_land1, ls_shipfrom, ls_shipto, ls_value, ls_value2, ls_value3, ls_stgrp, ldt_validfrom)
			Case is > 1
				of_insere_log_erro(ll_de_chave_sap, IS_ERRO_ENCONTROU_MAIS, "ICMS", 'D', ls_ambiente_sap, ls_mandt, ls_country, ls_gruop, &
							ls_land1, ls_shipfrom, ls_shipto, ls_value, ls_value2, ls_value3, ls_stgrp, ldt_validfrom)
		End Choose
	End If
	
	// Antes de inserir ou alterar uma nova regra, apagar a mesma regra com data inicial menor, caso exista.
	// Feito isso para n$$HEX1$$e300$$ENDHEX$$o precisar descer o encerramento caso des$$HEX1$$e700$$ENDHEX$$a abertura e manter s$$HEX1$$f300$$ENDHEX$$ as mais recentes no Sybase.
	DELETE FROM j_1btxic3
	WHERE mandt			= :ls_mandt and
		 land1			= :ls_land1 and
		 shipfrom		= :ls_shipfrom and
		 shipto			= :ls_shipto and
		 gruop			= :ls_gruop and
		 value			= :ls_value and
		 value2			= :ls_value2 and
		 value3			= :ls_value3 and
		 validfrom		< :ldt_validfrom and
		 cd_ambiente	= :ls_ambiente_sap;
	
	ll_exists	= 0
	
	select 1
	  into :ll_exists
	  from j_1btxic3
	 where mandt			= :ls_mandt and
			 land1			= :ls_land1 and
			 shipfrom		= :ls_shipfrom and
			 shipto			= :ls_shipto and
			 gruop			= :ls_gruop and
			 value			= :ls_value and
			 value2			= :ls_value2 and
			 value3			= :ls_value3 and
			 validfrom		= :ldt_validfrom and
			 cd_ambiente	= :ls_ambiente_sap;
	
	If SqlCa.sqlcode = -1 Then
		as_Log = "Erro ao verificar existencia de registro na tabela j_1btxic3. Erro: "+SqlCa.sqlErrText
		Return False
	End If	
	
	if ll_exists = 1 then
		update j_1btxic3
			set validto				= :ldt_validto,
				 rate					= :ldc_rate,
				 base					= :ldc_base,
				 exempt				= :ls_exempt,
				 taxlaw				= :ls_taxlaw,
				 conven100			= :ls_conven100,
				 specf_rate			= :ldc_specf_rate,
				 specf_base			= :ldc_specf_base,
				 partilha_exempt	= :ls_partilha_exempt,
				 specf_resale		= :ls_specf_resale,
				 dh_alteracao		= GetDate(),
				 de_chave_sap		= :ls_de_chave_sap,
				 nr_controle_interface_sap = :il_nr_controle_interface_sap
		 where mandt			= :ls_mandt and
				 land1			= :ls_land1 and
				 shipfrom		= :ls_shipfrom and
				 shipto			= :ls_shipto and
				 gruop			= :ls_gruop and
				 value			= :ls_value and
				 value2			= :ls_value2 and
				 value3			= :ls_value3 and
				 validfrom		= :ldt_validfrom and
				 cd_ambiente	= :ls_ambiente_sap;
				 
		If SqlCa.sqlcode = -1 Then
			as_Log = "Erro ao atualizar registro na tabela j_1btxic3. Erro: "+SqlCa.sqlErrText
			Return False
		End If	
	else
		INSERT INTO j_1btxic3  
				( mandt,   
				  land1,   
				  shipfrom,   
				  shipto,   
				  gruop,   
				  value,   
				  value2,   
				  value3,   
				  validfrom,   
				  validto,   
				  rate,   
				  base,   
				  exempt,   
				  taxlaw,   
				  conven100,   
				  specf_rate,   
				  specf_base,   
				  partilha_exempt,   
				  specf_resale,   
				  dh_inclusao,   
				  dh_alteracao,
				  cd_ambiente,
				  de_chave_sap,
				  nr_controle_interface_sap)  
	  VALUES ( :ls_mandt,   
				  :ls_land1,   
				  :ls_shipfrom,   
				  :ls_shipto,   
				  :ls_gruop,   
				  :ls_value,   
				  :ls_value2,   
				  :ls_value3,   
				  :ldt_validfrom,   
				  :ldt_validto,   
				  :ldc_rate,   
				  :ldc_base,   
				  :ls_exempt,   
				  :ls_taxlaw,   
				  :ls_conven100,   
				  :ldc_specf_rate,   
				  :ldc_specf_base,   
				  :ls_partilha_exempt,   
				  :ls_specf_resale,   
				  GetDate(),   
				  GetDate(),
				  :ls_ambiente_sap,
				  :ls_de_chave_sap,
				  :il_nr_controle_interface_sap);
					  
		If SqlCa.sqlcode = -1 Then
			as_Log = "Erro ao inserir registro na tabela j_1btxic3. Erro: "+SqlCa.sqlErrText
			Return False
		End If	
	end if
next

return true


end function

public function boolean of_insere_ipi (uo_ge473_comum acomum, ref string as_log);DateTime		ldt_validfrom
Dec{2}		ldc_rate, ldc_base, ldc_amount, ldc_factor, &
				ldc_minprice_amount
Dec{3}		ldc_minprice_quantity
Long			ll_exists, ll_for, ll_count
String		ls_mandt, ls_gruop, ls_value, ls_value2, ls_value3, &
				ls_exempt, ls_taxlaw, ls_unit, ls_waers, &
				ls_minprice_currency, ls_minprice_uom, ls_ambiente_sap

ll_count = aComum.ids_lista_registros.RowCount()

for ll_for = 1 to ll_count
	if isvalid(w_aguarde_3) Then
		w_aguarde_3.uo_progress_2.of_SetProgress(ll_for)
		w_aguarde_3.wf_settext("Atualizando regras | ("+String(ll_for)+"/"+String(ll_count)+")", 3 )
	end if
	
	ls_mandt						= aComum.ids_lista_registros.Object.mandt[ll_for]
	ls_gruop						= aComum.ids_lista_registros.Object.gruop[ll_for]
	ls_value						= aComum.ids_lista_registros.Object.value[ll_for]
	ls_value2					= aComum.ids_lista_registros.Object.value2[ll_for]
	ls_value3					= aComum.ids_lista_registros.Object.value3[ll_for]
	ldt_validfrom				= of_trata_data(aComum.ids_lista_registros.Object.validfrom[ll_for])
	ldc_rate						= Dec(gf_replace(aComum.ids_lista_registros.Object.rate[ll_for], '.', ',', 0))
	ldc_base						= Dec(gf_replace(aComum.ids_lista_registros.Object.base[ll_for], '.', ',', 0))
	ls_exempt					= aComum.ids_lista_registros.Object.exempt[ll_for]
	ls_taxlaw					= aComum.ids_lista_registros.Object.taxlaw[ll_for]
	ldc_amount					= Dec(gf_replace(aComum.ids_lista_registros.Object.amount[ll_for], '.', ',', 0))
	ldc_factor					= Dec(gf_replace(aComum.ids_lista_registros.Object.factor[ll_for], '.', ',', 0))
	ls_unit						= aComum.ids_lista_registros.Object.unit[ll_for]
	ls_waers						= aComum.ids_lista_registros.Object.waers[ll_for]
	ldc_minprice_amount		= Dec(gf_replace(aComum.ids_lista_registros.Object.minprice_amount[ll_for], '.', ',', 0))
	ls_minprice_currency		= aComum.ids_lista_registros.Object.minprice_currency[ll_for]
	ldc_minprice_quantity	= Dec(gf_replace(aComum.ids_lista_registros.Object.minprice_quantity[ll_for], '.', ',', 0))
	ls_minprice_uom			= aComum.ids_lista_registros.Object.minprice_uom[ll_for]
	ls_ambiente_sap			= aComum.ids_lista_registros.Object.cd_ambiente_sap[ll_for]
	
	If ls_ambiente_sap = 'S4P' then ls_ambiente_sap = 'PRD'
	
	if IsNull(ls_value2) then ls_value2 = ''
	if IsNull(ls_value3) then ls_value3 = ''
	
	Choose Case ls_gruop
		Case '49'
			of_Ajusta_Zeros_Esquerda(Ref ls_value)
			
		Case '14'
			of_Ajusta_Zeros_Esquerda(Ref ls_value2)
			
	End Choose
	
	ll_exists	= 0
	
	select 1
	  into :ll_exists
	  from j_1btxip3
	 where mandt			= :ls_mandt and
			 gruop			= :ls_gruop and
			 value			= :ls_value and
			 value2			= :ls_value2 and
			 value3			= :ls_value3 and
			 validfrom		= :ldt_validfrom and
			 cd_ambiente	= :ls_ambiente_sap;
	
	If SqlCa.sqlcode = -1 Then
		as_Log = "Erro ao verificar existencia de registro na tabela j_1btxip3. Erro: "+SqlCa.sqlErrText
		Return False
	End If	
	
	if ll_exists = 1 then
		update j_1btxip3
			set rate						= :ldc_rate,
				 base						= :ldc_base,
				 exempt					= :ls_exempt,
				 taxlaw					= :ls_taxlaw,
				 amount					= :ldc_amount,
				 factor					= :ldc_factor,
				 unit						= :ls_unit,
				 waers					= :ls_waers,
				 minprice_amount		= :ldc_minprice_amount,
				 minprice_currency	= :ls_minprice_currency,
				 minprice_quantity	= :ldc_minprice_quantity,
				 minprice_uom			= :ls_minprice_uom,
				 dh_alteracao			= GetDate(),
				 nr_controle_interface_sap = :il_nr_controle_interface_sap
		 where mandt			= :ls_mandt and
				 gruop			= :ls_gruop and
				 value			= :ls_value and
				 value2			= :ls_value2 and
				 value3			= :ls_value3 and
				 validfrom		= :ldt_validfrom and
				 cd_ambiente	= :ls_ambiente_sap;
				 
		If SqlCa.sqlcode = -1 Then
			as_Log = "Erro ao atualizar registro na tabela j_1btxip3. Erro: "+SqlCa.sqlErrText
			Return False
		End If	
	else
		INSERT INTO j_1btxip3  
				( mandt,   
				  gruop,   
				  value,   
				  value2,   
				  value3,   
				  validfrom,   
				  rate,   
				  base,   
				  exempt,   
				  taxlaw,   
				  amount,   
				  factor,   
				  unit,   
				  waers,   
				  minprice_amount,   
				  minprice_currency,   
				  minprice_quantity,   
				  minprice_uom,   
				  dh_inclusao,   
				  dh_alteracao,
				  cd_ambiente,
				  nr_controle_interface_sap)  
	  VALUES ( :ls_mandt,   
				  :ls_gruop,   
				  :ls_value,   
				  :ls_value2,   
				  :ls_value3,   
				  :ldt_validfrom,   
				  :ldc_rate,   
				  :ldc_base,   
				  :ls_exempt,   
				  :ls_taxlaw,   
				  :ldc_amount,   
				  :ldc_factor,   
				  :ls_unit,   
				  :ls_waers,   
				  :ldc_minprice_amount,   
				  :ls_minprice_currency,   
				  :ldc_minprice_quantity,   
				  :ls_minprice_uom,   
				  GetDate(),   
				  GetDate(),
				  :ls_ambiente_sap,
				  :il_nr_controle_interface_sap);
					  
		If SqlCa.sqlcode = -1 Then
			as_Log = "Erro ao inserir registro na tabela j_1btxip3. Erro: "+SqlCa.sqlErrText
			Return False
		End If	
	end if
next

return true
end function

public function boolean of_insere_iss (uo_ge473_comum acomum, ref string as_log);DateTime		ldt_validfrom, ldt_validto
Dec{2}		ldc_rate, ldc_base, ldc_minval_wt
Long			ll_exists, ll_for, ll_count
String		ls_mandt, ls_country, ls_gruop, ls_value, ls_value2, ls_value3, &
				ls_taxjurcode, ls_taxlaw, ls_taxrelloc, ls_waers, ls_withhold, &
				ls_ambiente_sap

ll_count = aComum.ids_lista_registros.RowCount()

for ll_for = 1 to ll_count
	if isvalid(w_aguarde_3) Then
		w_aguarde_3.uo_progress_2.of_SetProgress(ll_for)
		w_aguarde_3.wf_settext("Atualizando regras | ("+String(ll_for)+"/"+String(ll_count)+")", 3 )
	end if
	
	ls_mandt				= aComum.ids_lista_registros.Object.mandt[ll_for]
	ls_country			= aComum.ids_lista_registros.Object.country[ll_for]
	ls_gruop				= aComum.ids_lista_registros.Object.gruop[ll_for]
	ls_taxjurcode		= aComum.ids_lista_registros.Object.taxjurcode[ll_for]
	ls_value				= aComum.ids_lista_registros.Object.value[ll_for]
	ls_value2			= aComum.ids_lista_registros.Object.value2[ll_for]
	ls_value3			= aComum.ids_lista_registros.Object.value3[ll_for]
	ldt_validfrom		= of_trata_data(aComum.ids_lista_registros.Object.validfrom[ll_for])
	ldt_validto			= of_trata_data(aComum.ids_lista_registros.Object.validto[ll_for])
	ldc_rate				= Dec(gf_replace(aComum.ids_lista_registros.Object.rate[ll_for], '.', ',', 0))
	ldc_base				= Dec(gf_replace(aComum.ids_lista_registros.Object.base[ll_for], '.', ',', 0))
	ls_taxlaw			= aComum.ids_lista_registros.Object.taxlaw[ll_for]
	ls_taxrelloc		= aComum.ids_lista_registros.Object.taxrelloc[ll_for]
	ls_withhold			= aComum.ids_lista_registros.Object.withhold[ll_for]
	ldc_minval_wt		= Dec(gf_replace(aComum.ids_lista_registros.Object.minval_wt[ll_for], '.', ',', 0))
	ls_waers				= aComum.ids_lista_registros.Object.waers[ll_for]
	ls_ambiente_sap	= aComum.ids_lista_registros.Object.cd_ambiente_sap[ll_for]
	
	If ls_ambiente_sap = 'S4P' then ls_ambiente_sap = 'PRD'
		
	if IsNull(ls_value2) then ls_value2 = ''
	if IsNull(ls_value3) then ls_value3 = ''
	
	ll_exists	= 0
	
	select 1
	  into :ll_exists
	  from j_1btxiss
	 where mandt			= :ls_mandt and
			 country			= :ls_country and
			 gruop			= :ls_gruop and
			 taxjurcode		= :ls_taxjurcode and
			 value			= :ls_value and
			 value2			= :ls_value2 and
			 value3			= :ls_value3 and
			 validfrom		= :ldt_validfrom and
			 cd_ambiente	= :ls_ambiente_sap;
	
	If SqlCa.sqlcode = -1 Then
		as_Log = "Erro ao verificar existencia de registro na tabela j_1btxiss. Erro: "+SqlCa.sqlErrText
		Return False
	End If	
	
	if ll_exists = 1 then
		update j_1btxiss
			set validto			= :ldt_validto,
				 rate				= :ldc_rate,
				 base				= :ldc_base,
				 taxlaw			= :ls_taxlaw,
				 taxrelloc		= :ls_taxrelloc,
				 waers			= :ls_waers,
				 withhold		= :ls_withhold,
				 minval_wt		= :ldc_minval_wt,
				 dh_alteracao	= GetDate(),
				 nr_controle_interface_sap = :il_nr_controle_interface_sap
		 where mandt			= :ls_mandt and
				 country			= :ls_country and
				 gruop			= :ls_gruop and
				 taxjurcode		= :ls_taxjurcode and
				 value			= :ls_value and
				 value2			= :ls_value2 and
				 value3			= :ls_value3 and
				 validfrom		= :ldt_validfrom and
				 cd_ambiente	= :ls_ambiente_sap;
				 
		If SqlCa.sqlcode = -1 Then
			as_Log = "Erro ao atualizar registro na tabela j_1btxiss. Erro: "+SqlCa.sqlErrText
			Return False
		End If	
	else
		INSERT INTO j_1btxiss  
				( mandt,   
				  country,   
				  gruop,   
				  taxjurcode,   
				  value,   
				  value2,   
				  value3,   
				  validfrom,   
				  validto,   
				  rate,   
				  base,   
				  taxlaw,   
				  taxrelloc,   
				  withhold,   
				  minval_wt,   
				  waers,   
				  dh_inclusao,   
				  dh_alteracao,
				  cd_ambiente,
				  nr_controle_interface_sap)  
	  VALUES ( :ls_mandt,   
				  :ls_country,   
				  :ls_gruop,   
				  :ls_taxjurcode,   
				  :ls_value,   
				  :ls_value2,   
				  :ls_value3,   
				  :ldt_validfrom,   
				  :ldt_validto,   
				  :ldc_rate,   
				  :ldc_base,   
				  :ls_taxlaw,   
				  :ls_taxrelloc,   
				  :ls_withhold,   
				  :ldc_minval_wt,   
				  :ls_waers,   
				  GetDate(),   
				  GetDate(),
				  :ls_ambiente_sap,
				  :il_nr_controle_interface_sap);
	
		If SqlCa.sqlcode = -1 Then
			as_Log = "Erro ao inserir registro na tabela j_1btxiss. Erro: "+SqlCa.sqlErrText
			Return False
		End If	
	end if
next

return true
end function

public function boolean of_insere_st (uo_ge473_comum acomum, ref string as_log);DateTime		ldt_validfrom, ldt_validto
Dec{2}		ldc_rate, ldc_price, ldc_factor, ldc_basered1, ldc_basered2, ldc_icmsbaser, &
				ldc_minprice, ldc_minfact, ldc_fcp_basered1, ldc_fcp_basered2
Long			ll_exists, ll_for, ll_de_chave_sap, ll_count
String		ls_mandt, ls_land1, ls_shipfrom, ls_shipto, ls_gruop, ls_value, ls_value2, ls_value3, &
				ls_stgrp, ls_sur_type, ls_unit, ls_waers, ls_surchin, ls_ambiente_sap, &
				ls_de_chave_sap

String		ls_country

SetNull(ls_country)
ll_count = aComum.ids_lista_registros.RowCount()

for ll_for = 1 to ll_count
	// <DE_CHAVE_SAP> quando informado, $$HEX1$$e900$$ENDHEX$$ o nr_controle da log_exportacao_j1btax da subida
	// Deve sinalizar a regra que subiu como retornada
	ll_de_chave_sap		= Long(is_de_chave_acesso_sap)
	
	if isvalid(w_aguarde_3) Then
		w_aguarde_3.uo_progress_2.of_SetProgress(ll_for)
		w_aguarde_3.wf_settext("Atualizando regras | Controle: "+String(ll_de_chave_sap) + " ("+String(ll_for)+"/"+String(ll_count)+")", 3 )
	end if

	ls_mandt					= aComum.ids_lista_registros.Object.mandt[ll_for]
	ls_land1					= aComum.ids_lista_registros.Object.land1[ll_for]
	ls_shipfrom				= aComum.ids_lista_registros.Object.shipfrom[ll_for]
	ls_shipto				= aComum.ids_lista_registros.Object.shipto[ll_for]
	ls_gruop					= aComum.ids_lista_registros.Object.gruop[ll_for]
	ls_value					= aComum.ids_lista_registros.Object.value[ll_for]
	ls_value2				= aComum.ids_lista_registros.Object.value2[ll_for]
	ls_value3				= aComum.ids_lista_registros.Object.value3[ll_for]
	ls_stgrp					= aComum.ids_lista_registros.Object.stgrp[ll_for]
	ldt_validfrom			= of_trata_data(aComum.ids_lista_registros.Object.validfrom[ll_for])
	ldt_validto				= of_trata_data(aComum.ids_lista_registros.Object.validto[ll_for])
	ls_sur_type				= aComum.ids_lista_registros.Object.sur_type[ll_for]
	ldc_rate					= Dec(gf_replace(aComum.ids_lista_registros.Object.rate[ll_for], '.', ',', 0))
	ldc_price				= Dec(gf_replace(aComum.ids_lista_registros.Object.price[ll_for], '.', ',', 0))
	ldc_factor				= Dec(gf_replace(aComum.ids_lista_registros.Object.factor[ll_for], '.', ',', 0))
	ls_unit					= aComum.ids_lista_registros.Object.unit[ll_for]
	ldc_basered1			= Dec(gf_replace(aComum.ids_lista_registros.Object.basered1[ll_for], '.', ',', 0))
	ldc_basered2			= Dec(gf_replace(aComum.ids_lista_registros.Object.basered2[ll_for], '.', ',', 0))
	ldc_icmsbaser			= Dec(gf_replace(aComum.ids_lista_registros.Object.icmsbaser[ll_for], '.', ',', 0))
	ldc_minprice			= Dec(gf_replace(aComum.ids_lista_registros.Object.minprice[ll_for], '.', ',', 0))
	ls_waers					= aComum.ids_lista_registros.Object.waers[ll_for]
	ldc_minfact				= Dec(gf_replace(aComum.ids_lista_registros.Object.minfact[ll_for], '.', ',', 0))
	ls_surchin				= aComum.ids_lista_registros.Object.surchin[ll_for]
	ldc_fcp_basered1		= Dec(gf_replace(aComum.ids_lista_registros.Object.fcp_basered1[ll_for], '.', ',', 0))
	ldc_fcp_basered2		= Dec(gf_replace(aComum.ids_lista_registros.Object.fcp_basered2[ll_for], '.', ',', 0))
	ls_ambiente_sap		= aComum.ids_lista_registros.Object.cd_ambiente_sap[ll_for]
	
	If ls_ambiente_sap = 'S4P' then ls_ambiente_sap = 'PRD'
	
	if IsNull(ls_value2) then ls_value2 = ''
	if IsNull(ls_value3) then ls_value3 = ''
	if IsNull(ls_stgrp) then ls_stgrp = ''
	
	
	Choose Case ls_gruop
		Case '10', '11', '23', '49'
			of_Ajusta_Zeros_Esquerda(Ref ls_value)
			
		Case '14', '27', '29'
			of_Ajusta_Zeros_Esquerda(Ref ls_value2)
			
	End Choose
	
	ls_de_chave_sap 		= "SAP" // Para regras que desceram por altera$$HEX2$$e700e300$$ENDHEX$$o direto no SAP
	If ll_de_chave_sap > 0 Then
		ls_de_chave_sap = String(ll_de_chave_sap) // Se subiu e desceu, vai guardar o controle na tabela btax
		
		update log_exportacao_j1btax_item
		set 		dh_retorno_sap = GetDate()
		where		nr_controle = :ll_de_chave_sap
			and land1			= :ls_land1 and
				 shipfrom		= :ls_shipfrom and
				 shipto			= :ls_shipto and
				 gruop			= :ls_gruop and
				 value			= :ls_value and
				 value2			= :ls_value2 and
				 value3			= :ls_value3 and
				 stgrp			= :ls_stgrp 
		using SQLCA;
		
		If SqlCa.sqlcode = -1 Then
			as_Log = "Erro ao atualizar dh_retorno_sap da log_exportacao_j1btax_item. Erro: "+SqlCa.sqlErrText
			Return False
		End If

		// Se n$$HEX1$$e300$$ENDHEX$$o atualizou nada ou aualizou mais que 1, gravar um log pra identificar depois
		Choose Case SqlCa.SqlNRows
			Case 0
				of_insere_log_erro(ll_de_chave_sap, IS_ERRO_NAO_ENCONTROU, "ST", 'D', ls_ambiente_sap, ls_mandt, ls_country, ls_gruop, &
							ls_land1, ls_shipfrom, ls_shipto, ls_value, ls_value2, ls_value3, ls_stgrp, ldt_validfrom)
			Case is > 1
				of_insere_log_erro(ll_de_chave_sap, IS_ERRO_ENCONTROU_MAIS, "ST", 'D', ls_ambiente_sap, ls_mandt, ls_country, ls_gruop, &
							ls_land1, ls_shipfrom, ls_shipto, ls_value, ls_value2, ls_value3, ls_stgrp, ldt_validfrom)
		End Choose
	End If
	
	// Antes de inserir ou alterar uma nova regra, apagar a mesma regra com data inicial menor, caso exista.
	// Feito isso para n$$HEX1$$e300$$ENDHEX$$o precisar descer o encerramento caso des$$HEX1$$e700$$ENDHEX$$a abertura e manter s$$HEX1$$f300$$ENDHEX$$ as mais recentes no Sybase.
	DELETE FROM j_1btxst3
	WHERE mandt			= :ls_mandt and
			 land1			= :ls_land1 and
			 shipfrom		= :ls_shipfrom and
			 shipto			= :ls_shipto and
			 gruop			= :ls_gruop and
			 value			= :ls_value and
			 value2			= :ls_value2 and
			 value3			= :ls_value3 and
			 stgrp			= :ls_stgrp and
			 validfrom		< :ldt_validfrom and
			 cd_ambiente	= :ls_ambiente_sap;
	
	ll_exists	= 0
	
	select 1
	  into :ll_exists
	  from j_1btxst3
	 where mandt			= :ls_mandt and
			 land1			= :ls_land1 and
			 shipfrom		= :ls_shipfrom and
			 shipto			= :ls_shipto and
			 gruop			= :ls_gruop and
			 value			= :ls_value and
			 value2			= :ls_value2 and
			 value3			= :ls_value3 and
			 stgrp			= :ls_stgrp and
			 validfrom		= :ldt_validfrom and
			 cd_ambiente	= :ls_ambiente_sap;
	
	If SqlCa.sqlcode = -1 Then
		as_Log = "Erro ao verificar existencia de registro na tabela j_1btxst3. Erro: "+SqlCa.sqlErrText
		Return False
	End If	
	
	if ll_exists = 1 then
		update j_1btxst3
			set validto			= :ldt_validto,
				 sur_type		= :ls_sur_type,
				 rate				= :ldc_rate,
				 price			= :ldc_price,
				 factor			= :ldc_factor,
				 unit				= :ls_unit,
				 basered1		= :ldc_basered1,
				 basered2		= :ldc_basered2,
				 icmsbaser		= :ldc_icmsbaser,
				 minprice		= :ldc_minprice,
				 waers			= :ls_waers,
				 minfact			= :ldc_minfact,
				 surchin			= :ls_surchin,
				 fcp_basered1	= :ldc_fcp_basered1,
				 fcp_basered2	= :ldc_fcp_basered2,
				 dh_alteracao	= GetDate(),
				 de_chave_sap  = :ls_de_chave_sap,
				 nr_controle_interface_sap = :il_nr_controle_interface_sap
		 where mandt			= :ls_mandt and
				 land1			= :ls_land1 and
				 shipfrom		= :ls_shipfrom and
				 shipto			= :ls_shipto and
				 gruop			= :ls_gruop and
				 value			= :ls_value and
				 value2			= :ls_value2 and
				 value3			= :ls_value3 and
				 stgrp			= :ls_stgrp and
				 validfrom		= :ldt_validfrom and
				 cd_ambiente	= :ls_ambiente_sap;
				 
		If SqlCa.sqlcode = -1 Then
			as_Log = "Erro ao atualizar registro na tabela j_1btxst3. Erro: "+SqlCa.sqlErrText
			Return False
		End If	
	else
		INSERT INTO j_1btxst3  
				( mandt,   
				  land1,   
				  shipfrom,   
				  shipto,   
				  gruop,   
				  value,   
				  value2,   
				  value3,   
				  stgrp,   
				  validfrom,   
				  validto,   
				  sur_type,   
				  rate,   
				  price,   
				  factor,   
				  unit,   
				  basered1,   
				  basered2,   
				  icmsbaser,   
				  minprice,   
				  waers,   
				  minfact,   
				  surchin,   
				  fcp_basered1,   
				  fcp_basered2,   
				  dh_inclusao,   
				  dh_alteracao,
				  cd_ambiente,
				  de_chave_sap,
				  nr_controle_interface_sap)  
	  VALUES ( :ls_mandt,   
				  :ls_land1,   
				  :ls_shipfrom,   
				  :ls_shipto,   
				  :ls_gruop,   
				  :ls_value,   
				  :ls_value2,   
				  :ls_value3,   
				  :ls_stgrp,   
				  :ldt_validfrom,   
				  :ldt_validto,   
				  :ls_sur_type,   
				  :ldc_rate,   
				  :ldc_price,   
				  :ldc_factor,   
				  :ls_unit,   
				  :ldc_basered1,   
				  :ldc_basered2,   
				  :ldc_icmsbaser,   
				  :ldc_minprice,   
				  :ls_waers,   
				  :ldc_minfact,   
				  :ls_surchin,   
				  :ldc_fcp_basered1,   
				  :ldc_fcp_basered2,   
				  GetDate(),   
				  GetDate(),
				  :ls_ambiente_sap,
				  :ls_de_chave_sap,
				  :il_nr_controle_interface_sap);
		  
		If SqlCa.sqlcode = -1 Then
			as_Log = "Erro ao inserir registro na tabela j_1btxst3. Erro: "+SqlCa.sqlErrText
			Return False
		End If	
	end if
next

return true
end function

public subroutine of_ajusta_zeros_esquerda (ref string ps_value);Long lvl_Tamanho

lvl_Tamanho = Len(ps_value)
If lvl_Tamanho < 18 Then
	ps_value = Fill('0', (18 - lvl_Tamanho)) + ps_value
End If
end subroutine

public function datetime of_trata_data (string ps_data);DateTime ldt_Data

ldt_Data = DateTime(ps_data)

// Se n$$HEX1$$e300$$ENDHEX$$o conseguiu transformar a data em datetime, possui 8 caracteres e come$$HEX1$$e700$$ENDHEX$$a com um ANO, interpretar a data.
If isNull(ldt_Data) And Len(ps_data) = 8 And Long(Left(ps_data, 4)) >= 2000 Then
	// Muda para o formato DD.MM.YYYY e transforma em data
	ldt_Data = DateTime(Right(ps_data, 2) + '.' + Mid(ps_data, 5, 2) + '.' + Left(ps_data, 2))
End If

Return ldt_Data
end function

public function boolean of_finaliza_log_exportacao_j1btax (ref string ps_log);Long lvl_nr_controle_exportacao, lvl_qt_pendentes

lvl_nr_controle_exportacao = Long(is_de_chave_acesso_sap)

If lvl_nr_controle_exportacao = 0 Then Return True // Seguran$$HEX1$$e700$$ENDHEX$$a

// Ver se existe pend$$HEX1$$ea00$$ENDHEX$$ncias
select count(*)
into :lvl_qt_pendentes
from log_exportacao_j1btax_item
where nr_controle = :lvl_nr_controle_exportacao
	and dh_retorno_sap is null
	and dh_exportacao is not null
using sqlca;

If SqlCa.sqlcode = -1 Then
	ps_Log = "Erro ao verificar pend$$HEX1$$ea00$$ENDHEX$$ncias do log_exportacao_j1btax_item com nr_controle: "+String(lvl_nr_controle_exportacao)+". Erro: "+SqlCa.sqlErrText
	Return False
End If

// Se tem pend$$HEX1$$ea00$$ENDHEX$$ncias, s$$HEX1$$f300$$ENDHEX$$ continua sem atualizar o log
if lvl_qt_pendentes > 0 Then Return True

// Se n$$HEX1$$e300$$ENDHEX$$o pend$$HEX1$$ea00$$ENDHEX$$ncias, atualiza o log de exporta$$HEX2$$e700e300$$ENDHEX$$o para "FINALIZADO"
update log_exportacao_j1btax
set	id_situacao_exportacao = 'F',
		dh_finalizacao = getdate()
where	nr_controle = :lvl_nr_controle_exportacao
using sqlca;

If SqlCa.sqlcode = -1 Then
	ps_Log = "Erro ao atualizar id_situacao_exportacao da log_exportacao_j1btax para 'F' com nr_controle: "+String(lvl_nr_controle_exportacao)+". Erro: "+SqlCa.sqlErrText
	Return False
End If

Return True
end function

public subroutine of_insere_log_erro (long pl_nr_controle, string ps_erro, string ps_id_imposto, string ps_id_subida_descida, string ps_cd_ambiente_sap, string ps_mandt, string ps_country, string ps_gruop, string ps_land1, string ps_shipfrom, string ps_shipto, string ps_value, string ps_value2, string ps_value3, string ps_stgrp, datetime pdh_validfrom);Long ll_nr_seq_erro

SELECT COALESCE(Max(nr_seq_erro), 0)
INTO	 :ll_nr_seq_erro
FROM	 log_exportacao_j1btax_item_err
WHERE	 nr_controle_j1btax = :pl_nr_controle
USING  SQLCA;

ll_nr_seq_erro ++

INSERT INTO log_exportacao_j1btax_item_err
	(	nr_controle_j1btax,
		nr_controle_interface_sap,
		nr_seq_erro,
		id_imposto,
		id_subida_descida,
		cd_ambiente_sap,
		mandt,
		country,
		gruop,
		land1,
		shipfrom,
		shipto,
		value,
		value2,
		value3,
		stgrp,
		validfrom,
		de_erro,
		dh_erro	)
VALUES
	(	:pl_nr_controle,
		:il_nr_controle_interface_sap,
		:ll_nr_seq_erro,
		:ps_id_imposto,
		:ps_id_subida_descida,
		:ps_cd_ambiente_sap,
		:ps_mandt,
		:ps_country,
		:ps_gruop,
		:ps_land1,
		:ps_shipfrom,
		:ps_shipto,
		:ps_value,
		:ps_value2,
		:ps_value3,
		:ps_stgrp,
		:pdh_validfrom,
		:ps_erro,
		GetDate())
USING SQLCA;
end subroutine

on uo_ge473_wms_imposto.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge473_wms_imposto.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

