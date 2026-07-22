HA$PBExportHeader$w_ge185_movimentacao_vendas.srw
forward
global type w_ge185_movimentacao_vendas from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge185_movimentacao_vendas from dc_w_selecao_lista_relatorio
integer x = 215
integer y = 220
integer width = 2898
integer height = 1972
string title = "GE185 - Acompanhamento de Vendas com Cart$$HEX1$$f500$$ENDHEX$$es"
long backcolor = 80269524
end type
global w_ge185_movimentacao_vendas w_ge185_movimentacao_vendas

type variables
Uo_Filial ivo_Filial
end variables

forward prototypes
public subroutine wf_localiza_filial ()
public function string wf_dia_semana (string ps_dia)
public subroutine wf_altera_objeto (string ps_tipo, string ps_data)
public subroutine wf_grava_linha (date lvdt_data, string lvs_dia_semana, long lvl_coluna, integer lvi_contador, decimal lvdc_vd, decimal lvdc_vc, decimal lvdc_rd, decimal lvdc_rc, decimal lvdc_hi, decimal lvdc_am, decimal lvdc_go, decimal lvdc_bad, decimal lvdc_bac, decimal lvdc_ma, decimal lvdc_si, decimal lvdc_ca, decimal lvdc_pleno, decimal lvdc_senf, decimal lvdc_outros, decimal lvdc_pagseguro_deb, decimal lvdc_pagseguro_cred, decimal lvdc_cielo_new_deb, decimal lvdc_cielo_new_cred)
end prototypes

public subroutine wf_localiza_filial ();STRING lvs_filial, &
       lvs_todas
		 
dw_1.AcceptText()
		 
lvs_filial = dw_1.GetText()

ivo_filial.Of_Localiza_Filial(lvs_filial)

If ivo_filial.Localizada Then
	
	dw_1.Object.cd_filial[1] = ivo_filial.cd_filial
   dw_1.Object.filial[1]    = ivo_filial.nm_fantasia

End If

end subroutine

public function string wf_dia_semana (string ps_dia);Choose Case UPPER(ps_dia)
	Case "MONDAY"    ; Return "SEGUNDA FEIRA"
	Case "TUESDAY"   ; Return "TER$$HEX1$$c700$$ENDHEX$$A FEIRA"
	Case "WEDNESDAY" ; Return "QUARTA FEIRA"
	Case "THURSDAY"  ; Return "QUINTA FEIRA" 
	Case "FRIDAY"    ; Return "SEXTA FEIRA"
	Case "SATURDAY"  ; Return "S$$HEX1$$c100$$ENDHEX$$BADO"
	Case "SUNDAY"    ; Return "DOMINGO"
	Case Else        ; Return ''
End Choose 
end function

public subroutine wf_altera_objeto (string ps_tipo, string ps_data);Choose Case ps_tipo
	Case "N"
		If ps_data = "CR" Then
			dw_2.of_changedataobject("dw_ge185_lista_vendas_cred")  
		Else
			dw_2.of_changedataobject("dw_ge185_lista_vendas")  
		End If
	Case "C"
		If ps_data = "CR" Then
			dw_2.of_changedataobject("dw_ge185_cross_credito")  
		Else
			dw_2.of_changedataobject("dw_ge185_cross_operacao")  
		End If		
End Choose

Dw_2.of_SetRowSelection()
end subroutine

public subroutine wf_grava_linha (date lvdt_data, string lvs_dia_semana, long lvl_coluna, integer lvi_contador, decimal lvdc_vd, decimal lvdc_vc, decimal lvdc_rd, decimal lvdc_rc, decimal lvdc_hi, decimal lvdc_am, decimal lvdc_go, decimal lvdc_bad, decimal lvdc_bac, decimal lvdc_ma, decimal lvdc_si, decimal lvdc_ca, decimal lvdc_pleno, decimal lvdc_senf, decimal lvdc_outros, decimal lvdc_pagseguro_deb, decimal lvdc_pagseguro_cred, decimal lvdc_cielo_new_deb, decimal lvdc_cielo_new_cred);lvs_Dia_Semana = Upper(DayName(lvdt_Data))

dw_2.Object.Dia_Semana[lvi_Contador] = wf_Dia_Semana(lvs_Dia_Semana)							 
						
If    lvi_contador = 1 Then  
		dw_2.Object.adm_1			[lvi_contador] = 'CIELO DEB'   														 					 
		dw_2.Object.adm_2			[lvi_contador] = 'CIELO CRED'                     								 						 														 
		dw_2.Object.adm_3			[lvi_contador] = 'REDE DEB'                      								 						 						 
		dw_2.Object.adm_4			[lvi_contador] = 'REDE CRED'                     								 						 																		 
		dw_2.Object.adm_5			[lvi_contador] = 'HIPERCARD'                    								 						 						 						 
		dw_2.Object.adm_6			[lvi_contador] = 'AMEXPRESS'                      								 						 				 						 
		dw_2.Object.adm_7			[lvi_contador] = 'GOODCARD'                      								 						 																		 
		dw_2.Object.adm_8			[lvi_contador] = 'BANRI DEB'                 								 						 				 						 
		dw_2.Object.adm_9			[lvi_contador] = 'BANRI CRED'                 								 						 				 						 
		dw_2.Object.adm_10			[lvi_contador] = 'AGEMED'                   								 						 				 						 
		dw_2.Object.adm_11			[lvi_contador] = 'UTILCARD'                 								 						 				 						 
		dw_2.Object.adm_12			[lvi_contador] = 'CABAL' 
		dw_2.Object.adm_13			[lvi_contador] = 'PLENOCARD' 
		dw_2.Object.adm_14			[lvi_contador] = 'SENFFNET' 
		dw_2.Object.adm_15			[lvi_contador] = 'PAGSEG DEB ' 
		dw_2.Object.adm_16			[lvi_contador] = 'PAGSEG CRED' 		
		dw_2.Object.adm_17			[lvi_contador] = 'CIELO DEB' 		
		dw_2.Object.adm_18			[lvi_contador] = 'CIELO CRED' 				
		dw_2.Object.adm_outros	[lvi_contador] = 'OUTROS' 
		  
		dw_2.Object.adm_total[lvi_contador]  = 'TOTAL'
End If

dw_2.Object.Venda_1		[lvi_Contador] = lvdc_vd						 														 
dw_2.Object.Venda_2		[lvi_Contador] = lvdc_vc						                     								 						 								
dw_2.Object.Venda_3		[lvi_Contador] = lvdc_rd					                       								 						 
dw_2.Object.Venda_4		[lvi_Contador] = lvdc_rc					                     								 						 												
dw_2.Object.Venda_5		[lvi_Contador] = lvdc_hi	                  								 						 						 
dw_2.Object.Venda_6		[lvi_Contador] = lvdc_am				                      								 						 				 
dw_2.Object.Venda_7		[lvi_Contador] = lvdc_go					                    								 						 												
dw_2.Object.Venda_8		[lvi_Contador] = lvdc_bad					                 								 						 				 
dw_2.Object.Venda_9		[lvi_Contador] = lvdc_bac					                 								 						 				 
dw_2.Object.Venda_10		[lvi_Contador] = lvdc_ma				                 								 						 				 
dw_2.Object.Venda_11		[lvi_Contador] = lvdc_si						                 								 						 				 
dw_2.Object.Venda_12		[lvi_Contador] = lvdc_ca
dw_2.Object.Venda_13		[lvi_Contador] = lvdc_pleno
dw_2.Object.Venda_14		[lvi_Contador] = lvdc_senf
dw_2.Object.Venda_15		[lvi_Contador] = lvdc_pagseguro_deb
dw_2.Object.Venda_16		[lvi_Contador] = lvdc_pagseguro_cred
dw_2.Object.Venda_17		[lvi_Contador] = lvdc_cielo_new_deb
dw_2.Object.Venda_18		[lvi_Contador] = lvdc_cielo_new_cred
dw_2.Object.Venda_Outros	[lvi_Contador] = lvdc_outros
																											 
dw_2.Object.total    [lvi_Contador]  = lvdc_vd + lvdc_vc + lvdc_rd + lvdc_rc + lvdc_hi + lvdc_am + lvdc_go + lvdc_bad + lvdc_bac + lvdc_ma + lvdc_si + lvdc_ca + lvdc_pleno + lvdc_senf + lvdc_outros + lvdc_pagseguro_deb + lvdc_pagseguro_cred + lvdc_cielo_new_deb + lvdc_cielo_new_cred
end subroutine

on w_ge185_movimentacao_vendas.create
call super::create
end on

on w_ge185_movimentacao_vendas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;// Habilita os bot$$HEX1$$f500$$ENDHEX$$es de Impress$$HEX1$$e300$$ENDHEX$$o.
//This.ivm_Menu.ivb_Permite_Imprimir = True

This.ivm_Menu.mf_Recuperar(True)

Date lvdt_Sistema , &
     lvdt_inicio  , &
	  lvdt_final 
	  
Integer lvi_Mes , lvi_ano

Long lvl_Filial, lvl_Filial_Matriz

lvdt_Sistema= Today()
lvdt_inicio	= Today()
lvdt_Final	= Today()

dw_1.Object.pdt_inicial	[1] = lvdt_inicio
dw_1.Object.pdt_final		[1] = lvdt_final

lvl_Filial        = gvo_Parametro.of_Filial()
lvl_Filial_Matriz = gvo_Parametro.of_Filial_Matriz()

If lvl_Filial <> lvl_Filial_Matriz Then

	dw_1.SetReDraw(False)
	dw_1.Object.cd_filial	[1] 		= lvl_Filial
	dw_1.Object.filial		[1] 		= gvo_parametro.nm_fantasia_filial
	dw_1.Object.cd_filial.Protect	= 1
	dw_1.Object.filial.Protect			= 1		
	dw_1.SetReDraw(True)

End If
end event

event ue_preopen;call super::ue_preopen;ivo_Filial = Create Uo_Filial

Maxwidth = 6900
MaxHeight = 9999
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge185_movimentacao_vendas
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge185_movimentacao_vendas
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge185_movimentacao_vendas
integer x = 18
integer y = 352
integer width = 2816
integer height = 1416
long backcolor = 79741120
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge185_movimentacao_vendas
integer x = 18
integer y = 0
integer width = 1970
integer height = 348
long backcolor = 79741120
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge185_movimentacao_vendas
integer x = 50
integer y = 68
integer width = 1920
integer height = 260
string dataobject = "dw_ge185_selecao_vendas"
end type

event dw_1::itemchanged;call super::itemchanged;String lvs_Aux

Choose Case Lower(Dwo.Name)
	Case "filial"
		If Trim(Data) <> "" Then
			If Data <> ivo_Filial.Nm_Fantasia Then
				Return 1
			End If	
		Else	
			SetNull(ivo_Filial.Cd_Filial)
			ivo_Filial.Nm_Fantasia = ""
			
			This.Object.Cd_Filial	[1] = ivo_Filial.Cd_Filial
			This.Object.Filial		[1] = ivo_Filial.Nm_Fantasia
		End If
	Case "id_tipo"
		lvs_Aux = This.Object.tipo_data [1]
		wf_altera_objeto(Data, lvs_Aux)
	
	Case "tipo_data"
		lvs_Aux = This.Object.id_tipo [1]
		wf_altera_objeto(lvs_Aux, Data)
	
End Choose


end event

event dw_1::ue_key;call super::ue_key;STRING	lvs_Coluna

If Key = KeyEnter! Then
	
	lvs_Coluna = This.GetColumnName()
	
	If lvs_Coluna = "filial" Then
		wf_Localiza_Filial()
	End If

End If

end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge185_movimentacao_vendas
integer x = 50
integer y = 412
integer width = 2747
integer height = 1328
string dataobject = "dw_ge185_lista_vendas"
boolean hscrollbar = true
end type

event dw_2::constructor;call super::constructor;//This.SetRedraw(False)
//
//String lvs_Coluna[], &
//       lvs_Nome[]
//		 
//lvs_Coluna = {"dh_cota", "dia_semana", "vl_cota_prevista", "venda", "per_venda", "cota_acm",&
//				  "venda_acm", "per_venda_acm"}
//				  
//lvs_Nome = {"dia", "dia semana", "dia cota", "venda", "perc venda", &
//            "cota acumulada", "venda acumulada", "perc venda acumulada"}
//
//This.of_SetSort(lvs_Coluna, lvs_Nome)
//This.of_SetFilter(lvs_Coluna, lvs_Nome)
end event

event dw_2::ue_recuperar;//OverRide
Long lvl_Filial, &
     lvl_filial_ate

Decimal lvdc_Valor_Cota 	  

String  lvs_todas_filiais, &
	      lvs_tipo_data , &
	      lvs_tipo_Valor

Date	lvdt_inicio, &
		lvdt_final

This.Reset()

dw_1.AcceptText()

lvdt_inicio		= dw_1.Object.pdt_inicial[1]
lvdt_final			= dw_1.Object.pdt_final	[1]
lvdt_final			= RelativeDate ( lvdt_final, 1 ) 
lvl_Filial			= dw_1.Object.cd_filial	[1]
lvl_filial_ate		= dw_1.Object.cd_filial	[1]
lvs_tipo_data	= dw_1.Object.tipo_data	[1]
lvs_tipo_Valor	= dw_1.Object.valores	[1]

If isnull(lvl_Filial) Then
   lvl_filial     = 0
	lvl_filial_ate = 999	
End If

This.SetRedraw(False)
Return This.Retrieve(lvl_Filial, lvl_filial_ate, lvdt_inicio, lvdt_final, lvs_tipo_Valor)		
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;SetPointer(HourGlass!)

Integer    lvi_contador   , &
		     lvi_contador2
		  
Decimal{2} lvdc_Vendas_visa_debito			, &
			  lvdc_Vendas_visa_credito			, &
			  lvdc_Vendas_Redecard_debito	, &
			  lvdc_Vendas_Redecard_credito	, &
			  lvdc_Vendas_amex					, &
			  lvdc_Vendas_banrisul_debito		, &
			  lvdc_Vendas_banrisul_credito		, &
			  lvdc_Vendas_goodcard				, &
			  lvdc_Vendas_cabal					, &
			  lvdc_Vendas_hipercard				, &
			  lvdc_Vendas_sicoob					, &	
			  lvdc_Vendas_maxicred				, &
			  lvdc_Vendas_Outros					, &
			  lvdc_vendas 							, &
			  lvdc_Vendas_pleno					, &
			  lvdc_Vendas_senffnet				, &
			  lvdc_comissao, &
			  lvdc_Vendas_PagSeguro_debito, &
			  lvdc_Vendas_PagSeguro_credito, &			  
			  lvdc_vendas_Cielo_New_debito, &
			  lvdc_vendas_Cielo_New_credito &
			  
Long       lvl_filial			, &
              lvl_filial_calc	, &
			lvl_Linha			, &
			lvl_Linhas		, &
			lvl_filial_ate		, &
			lvl_total_filiais	, &
			lvl_coluna		, &
			lvl_colunas		, &
			lvl_col				, &
			lvl_adm			, &
			lvl_qt_parcelas

Date       lvdt_Data		, &
           	lvdt_inicial	, &
			lvdt_final		, &
			lvdt_Data1

String     lvs_Dia_Semana	, &
        		  lvs_todas_filiais	, &
			  lvs_filial				, &
			  lvs_id_vendas		, &
			  lvs_deb_cred		, &
			  lvs_adm			, &
			  lvs_tipo_valor		, &
			  lvs_tipo_data		, &
			  lvs_Tipo_Rel
 
dw_1.AcceptText()

lvl_Filial			= dw_1.Object.cd_filial	[1]
lvl_filial_ate		= dw_1.Object.cd_filial	[1]
lvs_tipo_data	= dw_1.Object.tipo_data	[1]
lvs_Tipo_Rel	= dw_1.Object.id_tipo	[1]

If lvs_Tipo_Rel = "N" Then
	If  isNull(lvl_Filial) Then
		 lvl_Filial		= 0
		 lvl_filial_ate	= 999
	End If
	
	This.SetRedraw(False)
	
	lvdt_inicial	= dw_1.Object.pdt_inicial	[1]
	lvdt_final		= dw_1.Object.pdt_final		[1]
	
	
	For   lvi_Contador = 1 To This.Rowcount()
		
		lvdt_Data  = Date(This.Object.Data_operacao[lvi_Contador])      
		lvdt_Data1 = RelativeDate ( lvdt_Data, 1 ) 
		 
		lvdc_Vendas_visa_debito			= 0
		lvdc_Vendas_visa_credito		= 0
		lvdc_Vendas_Redecard_debito	= 0
		lvdc_Vendas_Redecard_credito	= 0
		lvdc_Vendas_amex				= 0
		lvdc_Vendas_banrisul_debito	= 0
		lvdc_Vendas_banrisul_credito	= 0		
		lvdc_Vendas_goodcard			= 0
		lvdc_Vendas_cabal				= 0
		lvdc_Vendas_hipercard			= 0
		lvdc_Vendas_sicoob				= 0		
		lvdc_Vendas_maxicred			= 0	 
		lvdc_Vendas_pleno				= 0
		lvdc_Vendas_senffnet			= 0  
		lvdc_Vendas_PagSeguro_debito	= 0 
		lvdc_Vendas_PagSeguro_credito	= 0 		
		lvdc_Vendas_Cielo_New_debito	= 0
		lvdc_Vendas_Cielo_New_credito	= 0		
	
		lvl_colunas = 19
	
		If    lvl_colunas > 0 Then
			
			For   lvl_coluna = 1 To lvl_colunas	
					
				If   lvl_coluna   = 1  Then   // Visa Debito
					  lvl_adm      = 1
					  lvs_deb_cred = 'VD'
						
				End If
				If   lvl_coluna = 2  Then   // Visa Credito
					  lvl_adm      = 1 
					  lvs_deb_cred = 'VC'
						
				End If						
				If   lvl_coluna = 3  Then   // Redecard Debito
					  lvl_adm = 2
					  lvs_deb_cred = 'VD'
						
				End If						
				If   lvl_coluna = 4  Then   // Redecard Credito
					  lvl_adm = 2
					  lvs_deb_cred = 'VC'
						
				End If						
				If   lvl_coluna = 5  Then   // Hipercard / Unibanco
					  lvl_adm = 12
					  lvs_deb_cred = 'VC'
					  lvs_adm      = 'Hipercard' 
				End If						
				If   lvl_coluna = 6  Then   // Americam Express
					  lvl_adm = 3
					  lvs_deb_cred = 'VC'
					  lvs_adm      = 'Amex' 
				End If						
				If   lvl_coluna = 7  Then   // Goodcard
					  lvl_adm = 7
					  lvs_deb_cred = 'VC'
						
				End If						
				If   lvl_coluna = 8  Then   // Banrisul D$$HEX1$$e900$$ENDHEX$$bito
					  lvl_adm      = 6
					  lvs_deb_cred = 'VD'	
				End If	
				
				If   lvl_coluna = 9  Then   // Banrisul Cr$$HEX1$$e900$$ENDHEX$$dito
					lvl_adm      = 6
				//	  lvs_deb_cred = 'VD'							   
					lvs_deb_cred = 'VC'
				End If	
				If   lvl_coluna = 10  Then   // Maxicred (Agemed)
					  lvl_adm = 14
					  lvs_deb_cred = 'VC'		
				End If						
				If   lvl_coluna = 11 Then   // Sicoob			
					  lvl_adm = 13
					  lvs_deb_cred = 'VC'			
					  
				End If						
				If   lvl_coluna = 12 Then   // Cabal
					  lvl_adm = 9
					  lvs_deb_cred = 'VC'
						
				End If			
					If   lvl_coluna = 13 Then   // Plenocard
					  lvl_adm = 10
					  lvs_deb_cred = 'VC'
						
				End If				
				If   lvl_coluna = 14 Then   // Senffnet
					  lvl_adm = 15
					  lvs_deb_cred = 'VC'
						
				End If
				
				If   lvl_coluna = 15 Then   // PagSeguro D$$HEX1$$e900$$ENDHEX$$bito
					  lvl_adm = 31
					  lvs_deb_cred = 'VD'
				End If					
				
				If   lvl_coluna = 16 Then   // PagSeguro Cr$$HEX1$$e900$$ENDHEX$$dito
					  lvl_adm = 31
					  lvs_deb_cred = 'VC'					  
				End If					
				
				If   lvl_coluna = 17 Then   // Cielo New D$$HEX1$$e900$$ENDHEX$$bito
					  lvl_adm = 32
					  lvs_deb_cred = 'VD'
				End If					
				
				If   lvl_coluna = 18 Then   // Cielo New Cr$$HEX1$$e900$$ENDHEX$$dito
					  lvl_adm = 32
					  lvs_deb_cred = 'VC'					  
				End If					
				
				
				If lvs_tipo_data = "OP" Then
					
					If lvl_coluna = 19 Then
						select sum(vl_parcela), sum(vl_comissao)   	
						  Into :lvdc_vendas, :lvdc_comissao
						  from cartao_comprovante_operacao (index idx_operacao_adm)		
						 where cd_filial   >= :lvl_filial
							and cd_filial   <= :lvl_filial_ate
							and dh_operacao   >= :lvdt_Data
							and dh_operacao   <  :lvdt_Data1     
							and id_situacao in ('A','D','T','C') 
							and isnull(id_cancelado_filial,'N')  <> 'S'
							and cd_administradora not in (1, 2, 12, 3, 7, 6, 14, 13, 9, 10, 15, 31, 32);	
					Else
						select sum(vl_parcela), sum(vl_comissao)   	
						  Into :lvdc_vendas, :lvdc_comissao
						  from cartao_comprovante_operacao 	
						 where cd_filial   >= :lvl_filial
							and cd_filial   <= :lvl_filial_ate
							and dh_operacao   >= :lvdt_Data
							and dh_operacao   <  :lvdt_Data1     
							and id_situacao in ('A','D','T','C') 
							and isnull(id_cancelado_filial,'N')  <> 'S'
							and id_tipo_operacao  = :lvs_deb_cred
							and cd_administradora = :lvl_adm;
					End If
	
				ElseIf lvs_tipo_data = "CR" Then 
					If lvl_coluna = 19 Then
						select sum(vl_parcela), sum(vl_comissao)   	
						  Into :lvdc_vendas, :lvdc_comissao
						  from cartao_comprovante_operacao 	
						 where cd_filial   >= :lvl_filial
							and cd_filial   <= :lvl_filial_ate
							and dh_credito   >= :lvdt_Data
							and dh_credito  <  :lvdt_Data1   
							and id_situacao in ('A','D','T','C') 
							and isnull(id_cancelado_filial,'N')  <> 'S'
							and cd_administradora not in (1, 2, 12, 3, 7, 6, 14, 13, 9, 10, 15, 31, 32);	
					Else
						select sum(vl_parcela), sum(vl_comissao)   	
						  Into :lvdc_vendas, :lvdc_comissao
						  from cartao_comprovante_operacao (index idx_credito_adm)	
						 where cd_filial   >= :lvl_filial
							and cd_filial   <= :lvl_filial_ate
							and dh_credito   >= :lvdt_Data
							and dh_credito  <  :lvdt_Data1     
							and id_situacao in ('A','D','T','C') 
							and isnull(id_cancelado_filial,'N')  <> 'S'
							and id_tipo_operacao  = :lvs_deb_cred
							and cd_administradora = :lvl_adm;
					End If
				End If
			
				If SqlCa.SqlCode =  -1 Then
					messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na verifica$$HEX2$$e700e300$$ENDHEX$$o dos totais do dia " + String(lvdt_Data, "DD/MM/YYYY") + ".", StopSign!)
					Return -1
				End IF
					
				lvs_tipo_valor = dw_1.Object.valores [1]
	 
				If   IsNull(lvdc_Vendas)     Then lvdc_Vendas	= 0
				If   IsNull(lvdc_comissao)  Then lvdc_comissao	= 0
				
				If lvs_tipo_valor = "L" Then	
					lvdc_vendas = lvdc_vendas - lvdc_comissao 
				End If	
					
				If   lvl_coluna = 1  Then lvdc_Vendas_visa_debito			= lvdc_vendas
				If   lvl_coluna = 2  Then lvdc_Vendas_visa_credito		= lvdc_vendas
				If   lvl_coluna = 3  Then lvdc_Vendas_Redecard_debito	= lvdc_vendas
				If   lvl_coluna = 4  Then lvdc_Vendas_Redecard_credito	= lvdc_vendas
				If   lvl_coluna = 5  Then lvdc_Vendas_hipercard			= lvdc_vendas
				If   lvl_coluna = 6  Then lvdc_Vendas_amex					= lvdc_vendas
				If   lvl_coluna = 7  Then lvdc_Vendas_goodcard			= lvdc_vendas						
				If   lvl_coluna = 8  Then lvdc_Vendas_banrisul_debito	= lvdc_vendas
				If   lvl_coluna = 9  Then lvdc_Vendas_banrisul_credito	= lvdc_vendas
				If   lvl_coluna = 10 Then lvdc_Vendas_maxicred			= lvdc_vendas
				If   lvl_coluna = 11 Then lvdc_Vendas_sicoob				= lvdc_vendas						
				If   lvl_coluna = 12 Then lvdc_Vendas_cabal				= lvdc_vendas
				If   lvl_coluna = 13 Then lvdc_Vendas_pleno				= lvdc_vendas
				If   lvl_coluna = 14 Then lvdc_Vendas_senffnet			= lvdc_vendas	
				If   lvl_coluna = 15 Then lvdc_Vendas_PagSeguro_debito= lvdc_vendas	
				If   lvl_coluna = 16 Then lvdc_Vendas_PagSeguro_credito= lvdc_vendas					
				If   lvl_coluna = 17 Then lvdc_Vendas_Cielo_New_debito = lvdc_vendas				         				
				If   lvl_coluna = 18 Then lvdc_Vendas_Cielo_New_credito= lvdc_vendas				         								
				If   lvl_coluna = 19 Then lvdc_Vendas_Outros				= lvdc_vendas				         								
								
			Next
			
			wf_grava_linha (lvdt_Data, lvs_Dia_Semana, lvl_coluna, lvi_Contador, lvdc_Vendas_visa_debito, lvdc_Vendas_visa_credito, lvdc_Vendas_Redecard_debito, lvdc_Vendas_Redecard_credito, lvdc_Vendas_hipercard, lvdc_Vendas_amex, lvdc_Vendas_goodcard, lvdc_Vendas_banrisul_debito, lvdc_Vendas_banrisul_credito, lvdc_Vendas_maxicred, lvdc_Vendas_sicoob, lvdc_Vendas_cabal, lvdc_Vendas_pleno, lvdc_Vendas_senffnet, lvdc_Vendas_Outros, lvdc_Vendas_PagSeguro_debito, lvdc_Vendas_PagSeguro_credito, lvdc_Vendas_Cielo_New_debito, lvdc_Vendas_Cielo_new_credito )
		End If
	Next
End If

This.ivm_Menu.mf_SalvarComo(lvi_contador > 0)	 

This.SetRedraw(True)
SetPointer(Arrow!)

Return AncestorReturnValue
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge185_movimentacao_vendas
integer x = 2990
integer y = 888
integer width = 407
integer height = 196
integer taborder = 50
boolean hscrollbar = true
end type

