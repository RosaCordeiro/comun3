HA$PBExportHeader$w_ge186_movimentacao_vendas.srw
forward
global type w_ge186_movimentacao_vendas from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge186_movimentacao_vendas from dc_w_selecao_lista_relatorio
integer x = 215
integer y = 220
integer width = 4512
integer height = 2072
string title = "GE186 - Acompanhamento de Vendas com Cart$$HEX1$$f500$$ENDHEX$$es por Condi$$HEX2$$e700e300$$ENDHEX$$o de Pagamento"
long backcolor = 80269524
end type
global w_ge186_movimentacao_vendas w_ge186_movimentacao_vendas

type variables
Uo_Filial ivo_Filial
end variables

forward prototypes
public subroutine wf_localiza_filial ()
public function string wf_dia_semana (string ps_dia)
protected subroutine wf_grava_linha (long lvl_coluna, integer lvi_contador, decimal lvdc_visa, decimal lvdc_redecard, decimal lvdc_goodcard, decimal lvdc_banrisul, decimal lvdc_sicoob, decimal lvdc_senf, decimal lvdc_telenet, decimal lvdc_coopercred, decimal lvdc_verdecard, decimal lvdc_personal, decimal lvdc_policard, decimal lvdc_brasilcard, decimal lvdc_romcard, decimal lvdc_picpay, decimal lvdc_mercadopago, decimal lvdc_pagseguro, decimal lvdc_cielo_new, decimal lvdc_bin)
end prototypes

public subroutine wf_localiza_filial ();STRING lvs_filial, &
       lvs_todas
		 
dw_1.AcceptText()
		 
lvs_filial = dw_1.GetText()

ivo_filial.Of_Localiza_Filial(lvs_filial)

If ivo_filial.Localizada Then	
	dw_1.Object.cd_filial[1] 	= ivo_filial.cd_filial
   	dw_1.Object.filial[1]    		= ivo_filial.nm_fantasia
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

protected subroutine wf_grava_linha (long lvl_coluna, integer lvi_contador, decimal lvdc_visa, decimal lvdc_redecard, decimal lvdc_goodcard, decimal lvdc_banrisul, decimal lvdc_sicoob, decimal lvdc_senf, decimal lvdc_telenet, decimal lvdc_coopercred, decimal lvdc_verdecard, decimal lvdc_personal, decimal lvdc_policard, decimal lvdc_brasilcard, decimal lvdc_romcard, decimal lvdc_picpay, decimal lvdc_mercadopago, decimal lvdc_pagseguro, decimal lvdc_cielo_new, decimal lvdc_bin);If    lvi_contador = 1 Then 							   
	dw_2.Object.adm_1    [lvi_contador]  = 'CIELO'   //VISA	
	dw_2.Object.adm_2    [lvi_contador]  = 'REDECARD'
	dw_2.Object.adm_3    [lvi_contador]  = 'GOODCARD'                      								 						 																		 
	dw_2.Object.adm_4    [lvi_contador]  = 'BANRISUL'                 								 						 				 						 								                								 						 				 						           								 						 				 						 
	dw_2.Object.adm_5    [lvi_contador]  = 'UTILCARD'     //SICOOB         								 						 				 						 
	dw_2.Object.adm_6    [lvi_contador]  = 'SENFFNET' 
	dw_2.Object.adm_7    [lvi_contador]  = 'TELENET' 
	dw_2.Object.adm_8    [lvi_contador]  = 'COOPERCRED' 	
	
	dw_2.Object.adm_9    [lvi_contador]  = 'VERDECARD' 
	dw_2.Object.adm_10    [lvi_contador]  = 'PERSONAL' 
	dw_2.Object.adm_11    [lvi_contador]  = 'POLICARD' 
	dw_2.Object.adm_12    [lvi_contador]  = 'BRASIL CARD' 
	dw_2.Object.adm_13    [lvi_contador]  = 'ROM CARD' 	 
	dw_2.Object.adm_14    [lvi_contador]  = 'PICPAY' 
	dw_2.Object.adm_15    [lvi_contador]  = 'MERC. PAGO' 
	dw_2.Object.adm_16    [lvi_contador]  = 'PAGSEGURO' 	
	dw_2.Object.adm_17    [lvi_contador]  = 'CIELO NEW' 	
	dw_2.Object.adm_18    [lvi_contador]  = 'BIN' 	
	
	dw_2.Object.adm_total[lvi_contador]  = 'TOTAL' 
End If



If lvi_contador =  1 Then dw_2.Object.condicao_venda [lvi_Contador] = 'VENDA $$HEX1$$c000$$ENDHEX$$ D$$HEX1$$c900$$ENDHEX$$BITO'
If lvi_contador =  2 Then dw_2.Object.condicao_venda [lvi_Contador] = 'CR$$HEX1$$c900$$ENDHEX$$DITO em  1 Parcela'
If lvi_contador =  3 Then dw_2.Object.condicao_venda [lvi_Contador] = '              2 Parcelas'
If lvi_contador =  4 Then dw_2.Object.condicao_venda [lvi_Contador] = '              3 Parcelas'
If lvi_contador =  5 Then dw_2.Object.condicao_venda [lvi_Contador] = '              4 Parcelas'
If lvi_contador =  6 Then dw_2.Object.condicao_venda [lvi_Contador] = '              5 Parcelas'
If lvi_contador =  7 Then dw_2.Object.condicao_venda [lvi_Contador] = '              6 Parcelas'
If lvi_contador =  8 Then dw_2.Object.condicao_venda [lvi_Contador] = '              7 Parcelas'
If lvi_contador =  9 Then dw_2.Object.condicao_venda [lvi_Contador] = '              8 Parcelas'
If lvi_contador = 10 Then dw_2.Object.condicao_venda [lvi_Contador] = '              9 Parcelas'
If lvi_contador = 11 Then dw_2.Object.condicao_venda [lvi_Contador] = '             10 Parcelas'
If lvi_contador = 12 Then dw_2.Object.condicao_venda [lvi_Contador] = '             11 Parcelas'
If lvi_contador = 13 Then dw_2.Object.condicao_venda [lvi_Contador] = '             12 Parcelas'

dw_2.Object.Venda_1  [lvi_contador]  = lvdc_visa
dw_2.Object.Venda_2  [lvi_contador]  = lvdc_redecard
dw_2.Object.Venda_3  [lvi_contador]  = lvdc_goodcard
dw_2.Object.Venda_4  [lvi_contador]  = lvdc_Banrisul				                    								 						 												
dw_2.Object.Venda_5  [lvi_contador]  = lvdc_sicoob					                 								 						 				 
dw_2.Object.Venda_6  [lvi_contador]  = lvdc_senf
dw_2.Object.Venda_7  [lvi_contador]  = lvdc_telenet
dw_2.Object.Venda_8  [lvi_contador]  = lvdc_coopercred
dw_2.Object.Venda_9  [lvi_contador]  = lvdc_verdecard
dw_2.Object.Venda_10  [lvi_contador]  = lvdc_personal					                    								 						 																	                 								 						 				 
dw_2.Object.Venda_11  [lvi_contador]  = lvdc_policard	
dw_2.Object.Venda_12  [lvi_contador]  = lvdc_brasilcard
dw_2.Object.Venda_13  [lvi_contador]  = lvdc_romcard
dw_2.Object.Venda_14  [lvi_contador]  = lvdc_picpay
dw_2.Object.Venda_15  [lvi_contador]  = lvdc_mercadopago
dw_2.Object.Venda_16  [lvi_contador]  = lvdc_pagseguro
dw_2.Object.Venda_17  [lvi_contador]  = lvdc_cielo_new
dw_2.Object.Venda_18  [lvi_contador]  = lvdc_bin

																																	 
dw_2.Object.total    [lvi_contador]  = lvdc_visa + lvdc_redecard + lvdc_goodcard + lvdc_banrisul + lvdc_sicoob + lvdc_senf + lvdc_Telenet + lvdc_Coopercred + &
												lvdc_verdecard + lvdc_personal + lvdc_policard + lvdc_brasilcard + lvdc_romcard + lvdc_picpay + lvdc_mercadopago + lvdc_pagseguro + lvdc_cielo_new + lvdc_bin
end subroutine

on w_ge186_movimentacao_vendas.create
call super::create
end on

on w_ge186_movimentacao_vendas.destroy
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

lvdt_Sistema = Today()
lvdt_inicio  = Today()
lvdt_Final   = Today()

dw_1.Object.pdt_inicial[1] = lvdt_inicio
dw_1.Object.pdt_final[1]   = lvdt_final

lvl_Filial        = gvo_Parametro.of_Filial()
lvl_Filial_Matriz = gvo_Parametro.of_Filial_Matriz()

If lvl_Filial <> lvl_Filial_Matriz Then

   dw_1.SetReDraw(False)
	dw_1.Object.cd_filial[1]      		= lvl_Filial
	dw_1.Object.filial[1]         		= gvo_parametro.nm_fantasia_filial
	dw_1.Object.cd_filial.Protect 	= 1
	dw_1.Object.filial.Protect    	= 1		
	dw_1.SetReDraw(True)
End If
end event

event ue_preopen;call super::ue_preopen;ivo_Filial = Create Uo_Filial

Maxwidth = 7310
MaxHeight = 1880

ivb_permite_fechar = False
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge186_movimentacao_vendas
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge186_movimentacao_vendas
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge186_movimentacao_vendas
integer x = 18
integer y = 352
integer width = 4443
integer height = 1520
long backcolor = 79741120
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge186_movimentacao_vendas
integer x = 18
integer y = 0
integer width = 1806
integer height = 348
long backcolor = 79741120
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge186_movimentacao_vendas
integer x = 73
integer y = 68
integer width = 1737
integer height = 272
string dataobject = "dw_ge186_selecao_vendas"
end type

event dw_1::itemchanged;call super::itemchanged;If dwo.name = "filial" Then
	If Trim(Data) <> "" Then
		If Data <> ivo_Filial.Nm_Fantasia Then
			Return 1
		End If	
	Else	
		SetNull(ivo_Filial.Cd_Filial)
		ivo_Filial.Nm_Fantasia = ""
		
		This.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial
		This.Object.Filial[1]    = ivo_Filial.Nm_Fantasia
	End If
End If


end event

event dw_1::ue_key;call super::ue_key;STRING	lvs_Coluna

If Key = KeyEnter! Then
	
	lvs_Coluna = This.GetColumnName()
	
	If lvs_Coluna = "filial" Then
		wf_Localiza_Filial()
	End If

End If

end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge186_movimentacao_vendas
integer x = 50
integer y = 412
integer width = 4379
integer height = 1432
string dataobject = "dw_ge186_lista_vendas"
boolean hscrollbar = true
end type

event dw_2::ue_recuperar;//OverRide
Long lvl_Filial, &
        lvl_filial_ate , &
	   lvl_parc_1 , &
	   lvl_parc_2

Decimal lvdc_Valor_Cota 	  

String  lvs_todas_filiais, &
          lvs_tipo_data

Date    lvdt_inicio, &
           lvdt_final

This.Reset()

dw_1.AcceptText()

lvdt_inicio       = dw_1.Object.pdt_inicial[1]
lvdt_final        = dw_1.Object.pdt_final[1]
lvdt_final        = RelativeDate ( lvdt_final, 1 ) 
lvl_Filial          = dw_1.Object.cd_filial[1]
lvl_filial_ate    = dw_1.Object.cd_filial[1]
lvl_parc_1        = 1
lvl_parc_2        = 13 // equivalente a parcelas de 01 a 12.
lvs_tipo_data = dw_1.Object.tipo_data  [1]

Choose Case lvs_tipo_data
	Case "OP"
		dw_2.of_changedataobject("dw_ge186_lista_vendas")  
	Case "CR"
		dw_2.of_changedataobject("dw_ge186_lista_vendas_cred")  
	Case "MV"
		dw_2.of_changedataobject("dw_ge186_lista_vendas_mov")  	
End Choose

If isnull(lvl_Filial) Then
   	lvl_filial     	= 0
	lvl_filial_ate = 9999
End If

This.SetRedraw(False)

Return This.Retrieve(lvl_Filial, lvl_filial_ate, lvdt_inicio, lvdt_final, lvl_parc_1, lvl_parc_2)		
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;SetPointer(HourGlass!)

Integer    lvi_contador          
		  
Decimal{2}   lvdc_vendas               , &
           		  lvdc_Vendas_Visa             , &    
			  lvdc_Vendas_Redecard             , &  
			  lvdc_Vendas_Banrisul   , &   	 
			  lvdc_Vendas_goodcard , &       
			  lvdc_Vendas_sicoob     , &   
			  lvdc_Vendas_senffnet  , &
			  lvdc_comissao, &
			  lvdc_Vendas_Telenet, &
			  lvdc_Vendas_CooperCred, &
			  lvdc_Vendas1, &
			  lvdc_Comissao1, &
			  lvdc_Vendas2, &
			  lvdc_Comissao2, &
			  lvdc_Vendas3, &
			  lvdc_Comissao3
			  
Decimal {2} 	lvdc_Vendas_VerdeCard, &
				lvdc_Vendas_PersonalCard, &
				lvdc_Vendas_PoliCard, &
				lvdc_Vendas_BrasilCard, &			
				lvdc_Vendas_RomCard, &
				lvdc_Vendas_PicPay, &
				lvdc_Vendas_MercadoPago, &
				lvdc_Vendas_PagSeguro, &
				lvdc_Vendas_Cielo_New, &
				lvdc_Vendas_Bin

Long  	lvl_filial           , &            
	    	lvl_filial_ate       , &
	    	lvl_total_filiais     , &
	    	lvl_coluna           , &
	  	lvl_colunas          , &		 
		lvl_adm              , &
		lvl_qt_parcelas

Date 	lvdt_Data          , &
               	lvdt_inicial         , &
		lvdt_final           , &
		lvdt_Data1

String    lvs_deb_cred     , &
		lvs_adm            ,  &
		lvs_tipo_data     , &
		lvs_tipo_valor, &
		lvs_Conciliacao
 
Try 
 
	dw_1.AcceptText()
	
	lvl_Filial        	= dw_1.Object.cd_filial[1]
	lvl_filial_ate   	= dw_1.Object.cd_filial[1]
	lvs_tipo_data 	= dw_1.Object.tipo_data  [1]
	lvs_tipo_valor 	= dw_1.Object.valores  [1]
	lvs_Conciliacao = dw_1.Object.Id_Conciliada[1] 
	
	If  isnull(lvl_Filial) Then
		 lvl_Filial        = 0
		 lvl_filial_ate    = 999
	End If
	
	This.SetRedraw(False)
	
	lvdt_inicial	= dw_1.Object.pdt_inicial [1]
	lvdt_final     = dw_1.Object.pdt_final   [1] 
	
	//For   lvi_Contador = 1 To this.Rowcount()
	Open(w_aguarde)
	w_aguarde.uo_Progress.Of_SetMax(13)
	
	For lvi_Contador = 1 To 13
		
		lvdt_Data  = lvdt_inicial
		lvdt_Data1 = RelativeDate ( lvdt_final, 1 ) 
		
		lvdc_Vendas_Visa         		= 0
		lvdc_Vendas_Redecard = 0
		lvdc_Vendas_Banrisul    		= 0		 
		lvdc_Vendas_goodcard   		= 0
		lvdc_Vendas_sicoob       		= 0		
		lvdc_Vendas_senffnet    		= 0
		lvdc_Vendas_Telenet			= 0
		lvdc_Vendas_CooperCred	= 0
		
		lvdc_Vendas_VerdeCard			= 0
		lvdc_Vendas_PersonalCard		= 0
		lvdc_Vendas_PoliCard			= 0
		lvdc_Vendas_BrasilCard			= 0		
		lvdc_Vendas_RomCard			= 0
		lvdc_Vendas_PicPay				= 0
		lvdc_Vendas_MercadoPago		= 0
		lvdc_Vendas_PagSeguro			= 0
		lvdc_Vendas_Cielo_New 			= 0					
	
		dw_3.DataObject = "dw_filial"
		dw_3.SetTransObject(SqlCa)
			
		lvs_deb_cred      = 'VC'  // Venda a Credito		
		
		If   lvi_Contador =  1  Then lvs_deb_cred = 'VD'   // Venda a Debito
			
		If   lvi_Contador =  1  Then lvl_qt_parcelas = 1   
		If   lvi_Contador =  2  Then lvl_qt_parcelas = 1
		If   lvi_Contador =  3  Then lvl_qt_parcelas = 2
		If   lvi_Contador =  4  Then lvl_qt_parcelas = 3
		If   lvi_Contador =  5  Then lvl_qt_parcelas = 4
		If   lvi_Contador =  6  Then lvl_qt_parcelas = 5
		If   lvi_Contador =  7  Then lvl_qt_parcelas = 6
		If   lvi_Contador =  8  Then lvl_qt_parcelas = 7
		If   lvi_Contador =  9  Then lvl_qt_parcelas = 8
		If   lvi_Contador = 10 Then lvl_qt_parcelas =  9
		If   lvi_Contador = 11 Then lvl_qt_parcelas = 10
		If   lvi_Contador = 12 Then lvl_qt_parcelas = 11
		If   lvi_Contador = 13 Then lvl_qt_parcelas = 12
		
		w_aguarde.Title = "Parcela "+String(lvl_qt_parcelas)+"..."
			
		lvl_colunas = 18
			 
		If lvl_colunas > 0 Then			
			For lvl_coluna = 1 To lvl_colunas	
				
				Choose Case lvl_coluna
					Case 1 // Visa/Cielo  
						lvl_adm      = 21	
					Case 2 // Redecard  
						lvl_adm      = 2
					Case 3 // Goodcard
						lvl_adm      = 7
					Case 4 // Banrisul			
						lvl_adm      = 6
					Case 5  //  Sicoob 						     					
						lvl_adm      = 13			
					Case 6 // Senffnet
						lvl_adm = 15
						lvs_deb_cred = 'VC'
					Case 7 // Telenet
						lvl_adm = 16							 
					Case 8  // CooperCred
						lvl_adm = 17				 
					Case 9 // VerdCard
						lvl_adm = 20 						     
					Case 10 // Personal Card
						lvl_adm = 22
						lvs_deb_cred = 'VC'
					Case 11 // PoliCard
						lvl_adm = 24
						lvs_deb_cred = 'VC'						  						   
					Case 12 // BrasilCard
						lvl_adm = 25
						lvs_deb_cred = 'VC'
					Case 13 // RomCard
						lvl_adm = 26
						lvs_deb_cred = 'VC'
					Case 14 // PicPay
						lvl_adm = 28
						lvs_deb_cred = 'VC'
					Case 15 // Mercado Pago
						lvl_adm = 29
					Case 16 // PagSeguro
						lvl_adm = 31
					Case 17 // Cielo New
						lvl_adm = 32
					Case 18 //BIN
						lvl_adm = 38
					
				End Choose
				
				If lvi_Contador = 1  Then
	//				If lvl_adm = 16 Then 
	//					lvs_deb_cred = 'XX'
	//				Else
						lvs_deb_cred = 'VD'
	//				End If
				Else
	//				If lvl_adm = 16 Then
	//					lvs_deb_cred = 'VD'
	//				Else
						lvs_deb_cred = 'VC'
	//				End If
				End If
							
				Choose Case lvs_tipo_data
					Case "OP"
						If lvs_Conciliacao = 'T' Then
							select  sum(co.vl_parcela),
									sum(co.vl_comissao)  	
							  Into 	:lvdc_vendas, 
									:lvdc_comissao
							  from cartao_comprovante_operacao co							  
							 where co.cd_filial          >= :lvl_filial
								and co.cd_filial          <= :lvl_filial_ate
								and co.dh_operacao        >= :lvdt_Data
								and co.dh_operacao        <  :lvdt_Data1     
								and co.id_situacao in ('A','D','T','C') 
								and isnull(co.id_cancelado_filial, 'N')  <> 'S'
								and co.id_tipo_operacao  = :lvs_deb_cred
								and co.qt_parcelas       = :lvl_qt_parcelas
								and co.cd_administradora = :lvl_adm;
						Else
							select  sum(co.vl_parcela),
									sum(co.vl_comissao)  	
							  Into 	:lvdc_vendas, 
									:lvdc_comissao
							  from cartao_comprovante_operacao co							  
							 where co.cd_filial          >= :lvl_filial
								and co.cd_filial          <= :lvl_filial_ate
								and co.dh_operacao        >= :lvdt_Data
								and co.dh_operacao        <  :lvdt_Data1     
								and co.id_situacao in ('A','D','T','C') 
								and isnull(co.id_cancelado_filial, 'N')  <> 'S'
								and co.id_tipo_operacao  	= :lvs_deb_cred
								and co.qt_parcelas       		= :lvl_qt_parcelas
								and co.cd_administradora 	= :lvl_adm
								and isnull(id_conciliada, 'N') =  case :lvl_adm when 2   then :lvs_Conciliacao
															  when 18 then :lvs_Conciliacao
															  else 'N' end;
						End If
					Case "CR"
						If lvs_Conciliacao = 'T' Then
							select  sum(co.vl_parcela),
									sum(co.vl_comissao)  	
							  Into  :lvdc_vendas, 
									:lvdc_comissao
							  from cartao_comprovante_operacao co
							 where co.cd_filial          >= :lvl_filial
								and co.cd_filial          <= :lvl_filial_ate
								and co.dh_credito        >= :lvdt_Data
								and co.dh_credito        <  :lvdt_Data1     
								and co.id_situacao in ('A','D','T','C') 
								and isnull(co.id_cancelado_filial,'N')  <> 'S'
								and co.id_tipo_operacao  = :lvs_deb_cred
								and co.qt_parcelas       = :lvl_qt_parcelas
								and co.cd_administradora = :lvl_adm;		
						Else
							select  sum(co.vl_parcela),
									sum(co.vl_comissao)  	
							  Into  :lvdc_vendas, 
									:lvdc_comissao
							  from cartao_comprovante_operacao co
							 where co.cd_filial          >= :lvl_filial
								and co.cd_filial          <= :lvl_filial_ate
								and co.dh_credito		>= :lvdt_Data
								and co.dh_credito		<  :lvdt_Data1     
								and co.id_situacao in ('A','D','T','C') 
								and isnull(co.id_cancelado_filial,'N')  <> 'S'
								and co.id_tipo_operacao  	= :lvs_deb_cred
								and co.qt_parcelas       		= :lvl_qt_parcelas
								and co.cd_administradora 	= :lvl_adm
								and isnull(id_conciliada, 'N') =  case :lvl_adm when 2   then :lvs_Conciliacao
															  when 18 then :lvs_Conciliacao
															  else 'N' end;					
						  End If
					Case "MV"
						If lvs_Conciliacao = 'T' Then
							select  sum(co.vl_parcela),
									sum(co.vl_comissao)  	
							  Into  :lvdc_vendas, 
									:lvdc_comissao
							  from cartao_comprovante_operacao co
							 inner join lancamento_caixa lc
							  on lc.cd_caixa = co.cd_caixa
							  and lc.nr_controle_caixa = co.nr_controle_caixa
							  and lc.nr_lancamento + 1 = co.nr_comprovante_caixa
							 inner join controle_caixa cc
							  on cc.cd_caixa = lc.cd_caixa
							  and cc.nr_controle_caixa = lc.nr_controle_caixa
							 inner join nf_venda n
							  on n.cd_filial = co.cd_filial
								 and n.nr_nf = co.nr_nf
								and n.de_especie = co.de_especie
								and n.de_serie = co.de_serie
							 where co.cd_filial          >= :lvl_filial
								and co.cd_filial          <= :lvl_filial_ate
								and cc.dh_movimentacao_caixa between :lvdt_inicial and :lvdt_final
								and isnull(co.id_cancelado_filial,'N')  <> 'S'
								and co.id_tipo_operacao		= :lvs_deb_cred
								and co.qt_parcelas			= :lvl_qt_parcelas
								and co.cd_administradora	= :lvl_adm
								and (co.nr_sequencial > 0 or co.nr_sequencial is not null)
								and n.cd_forma_pagamento = case :lvs_deb_cred when 'VD' then 'CA' when 'VC' then 'CP' end;
								 
							If IsNull(lvdc_vendas) Then lvdc_vendas = 0.00
							If IsNull(lvdc_comissao) Then lvdc_comissao = 0.00
								
							select  sum(co.vl_parcela),
									sum(co.vl_comissao)  	
							  Into  :lvdc_vendas1, 
									:lvdc_comissao1
							  from cartao_comprovante_operacao co
							 inner join lancamento_caixa lc
							  on lc.cd_caixa = co.cd_caixa
							  and lc.nr_controle_caixa = co.nr_controle_caixa
							  and lc.nr_lancamento + 1 = co.nr_comprovante_caixa
							 inner join controle_caixa cc
							  on cc.cd_caixa = lc.cd_caixa
							  and cc.nr_controle_caixa = lc.nr_controle_caixa
							 inner join nf_venda n
							  on n.cd_filial = co.cd_filial
								 and n.nr_nf = co.nr_nf
								and n.de_especie = co.de_especie
								and n.de_serie = co.de_serie
							 where co.cd_filial          >= :lvl_filial
								and co.cd_filial          <= :lvl_filial_ate
								and cc.dh_movimentacao_caixa between :lvdt_inicial and :lvdt_final   
								and co.id_situacao in ('A','D','T','C') 
								and isnull(co.id_cancelado_filial,'N')  <> 'S'
								and co.id_tipo_operacao  = case :lvs_deb_cred when 'VD' then 'VC' else 'VD' end
								and co.qt_parcelas       = :lvl_qt_parcelas
								and co.cd_administradora = :lvl_adm
								and (co.nr_sequencial > 0 or co.nr_sequencial is not null)
								and n.cd_forma_pagamento = case :lvs_deb_cred when 'VD' then 'CA' when 'VC' then 'CP' end;
								
							select  sum(co.vl_parcela),
									sum(co.vl_comissao)  	
							  Into  :lvdc_vendas2, 
									:lvdc_comissao2
							  from cartao_comprovante_operacao co
							 inner join lancamento_caixa lc
							  on lc.cd_caixa = co.cd_caixa
							  and lc.nr_controle_caixa = co.nr_controle_caixa
							  and lc.nr_lancamento + 1 = co.nr_comprovante_caixa
							 inner join controle_caixa cc
							  on cc.cd_caixa = lc.cd_caixa
							  and cc.nr_controle_caixa = lc.nr_controle_caixa
							 inner join nf_venda n
							  on n.cd_filial = co.cd_filial
								 and n.nr_nf = co.nr_nf
								and n.de_especie = co.de_especie
								and n.de_serie = co.de_serie
							 where co.cd_filial          >= :lvl_filial
								and co.cd_filial          <= :lvl_filial_ate
								and cc.dh_movimentacao_caixa between :lvdt_inicial and :lvdt_final
								and isnull(co.id_cancelado_filial,'N')  <> 'S'
								and co.id_tipo_operacao		= :lvs_deb_cred
								and co.qt_parcelas       		= :lvl_qt_parcelas
								and co.cd_administradora	= :lvl_adm
								and (co.nr_sequencial > 0 or co.nr_sequencial is not null)
								and n.cd_forma_pagamento = 'MF';
								
							select  sum(co.vl_parcela),
									sum(co.vl_comissao)  	
							  Into  :lvdc_vendas3, 
									:lvdc_comissao3
							  from cartao_comprovante_operacao co
							 inner join lancamento_caixa lc
							  on lc.cd_caixa = co.cd_caixa
							  and lc.nr_controle_caixa = co.nr_controle_caixa
							  and lc.nr_lancamento + 1 = co.nr_comprovante_caixa
							 inner join controle_caixa cc
							  on cc.cd_caixa = lc.cd_caixa
							  and cc.nr_controle_caixa = lc.nr_controle_caixa
							 where co.cd_filial          >= :lvl_filial
								and co.cd_filial          <= :lvl_filial_ate
								and cc.dh_movimentacao_caixa between :lvdt_inicial and :lvdt_final
								and isnull(co.id_cancelado_filial,'N')  <> 'S'
								and co.id_tipo_operacao  = :lvs_deb_cred
								and co.qt_parcelas       = :lvl_qt_parcelas
								and co.cd_administradora = :lvl_adm
								and (co.nr_sequencial > 0 or co.nr_sequencial is not null)
								and co.nr_nsu not like '%*%'
								and not exists (select 1 
													 from nf_venda n
													where n.cd_filial = co.cd_filial
														 and n.nr_nf = co.nr_nf
														and n.de_especie = co.de_especie
														and n.de_serie = co.de_serie);							
								 
							If IsNull(lvdc_vendas)		Then lvdc_vendas		= 0.00
							If IsNull(lvdc_comissao)	Then lvdc_comissao	= 0.00
							If IsNull(lvdc_vendas1)	Then lvdc_vendas1	= 0.00
							If IsNull(lvdc_comissao1)	Then lvdc_comissao1	= 0.00
							If IsNull(lvdc_vendas2)	Then lvdc_vendas2	= 0.00
							If IsNull(lvdc_comissao2)	Then lvdc_comissao2	= 0.00
							If IsNull(lvdc_vendas3)	Then lvdc_vendas3	= 0.00
							If IsNull(lvdc_comissao3)	Then lvdc_comissao3	= 0.00
								
							lvdc_Vendas 	= lvdc_Vendas + lvdc_Vendas1 + lvdc_Vendas2 + lvdc_Vendas3
							lvdc_Comissao 	= lvdc_Comissao + lvdc_Comissao1 + lvdc_Comissao2 + lvdc_Comissao3
							
						Else
							select  sum(co.vl_parcela),
										sum(co.vl_comissao)  	
							  Into  :lvdc_vendas, 
									:lvdc_comissao
							  from cartao_comprovante_operacao co
							 inner join lancamento_caixa lc
							  on lc.cd_caixa = co.cd_caixa
							  and lc.nr_controle_caixa = co.nr_controle_caixa
							  and lc.nr_lancamento + 1 = co.nr_comprovante_caixa
							 inner join controle_caixa cc
							  on cc.cd_caixa = lc.cd_caixa
							  and cc.nr_controle_caixa = lc.nr_controle_caixa
							 where co.cd_filial          >= :lvl_filial
								and co.cd_filial          <= :lvl_filial_ate
								and cc.dh_movimentacao_caixa between :lvdt_inicial and :lvdt_final  
								and isnull(co.id_cancelado_filial,'N')  <> 'S'
								and co.id_tipo_operacao  = :lvs_deb_cred
								and co.qt_parcelas       = :lvl_qt_parcelas
								and co.cd_administradora = :lvl_adm
								and (co.nr_sequencial > 0 or co.nr_sequencial is not null)
								and isnull(id_conciliada, 'N') =  case :lvl_adm when 2   then :lvs_Conciliacao
															  when 18 then :lvs_Conciliacao
															  else 'N' end;					
						  End If
				End Choose
															 
				If SqlCa.SqlCode =  -1 Then
					Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Erro na verifica$$HEX2$$e700e300$$ENDHEX$$o da condi$$HEX2$$e700e300$$ENDHEX$$o de Venda. " + SqlCa.SqlErrText, StopSign!)
					Return -1
				End IF
							
				If   IsNull(lvdc_Vendas)  Then lvdc_Vendas      = 0
				If   IsNull(lvdc_comissao)  Then lvdc_comissao = 0
							
				 If    lvs_tipo_valor = "L" Then	
					lvdc_vendas = lvdc_vendas - lvdc_comissao 
				End If	
								
				If   lvl_coluna = 1	 Then lvdc_Vendas_visa      			= lvdc_vendas
				If   lvl_coluna = 2	 Then lvdc_Vendas_Redecard     			= lvdc_vendas
				If   lvl_coluna = 3	 Then lvdc_Vendas_goodcard  		= lvdc_vendas						
				If   lvl_coluna = 4	 Then lvdc_Vendas_banrisul  		= lvdc_vendas 					 
				If   lvl_coluna = 5	 Then lvdc_Vendas_sicoob			= lvdc_vendas						
				If   lvl_coluna = 6	 Then lvdc_Vendas_senffnet  	= lvdc_vendas
				If   lvl_coluna = 7	 Then lvdc_Vendas_Telenet  	= lvdc_vendas
				If   lvl_coluna = 8 Then lvdc_Vendas_CooperCred  	= lvdc_vendas
				
				If lvl_coluna = 9 Then lvdc_Vendas_VerdeCard 		= lvdc_vendas
				If lvl_coluna = 10 Then lvdc_Vendas_PersonalCard 	= lvdc_vendas
		
				If lvl_coluna = 11 Then lvdc_Vendas_PoliCard 			= lvdc_vendas
				If lvl_coluna = 12 Then lvdc_Vendas_BrasilCard 		= lvdc_vendas
				If lvl_coluna = 13 Then lvdc_Vendas_RomCard 		= lvdc_vendas
				If lvl_coluna = 14 Then lvdc_Vendas_PicPay 			= lvdc_vendas
				If lvl_coluna = 15 Then lvdc_Vendas_MercadoPago	= lvdc_vendas
				If lvl_coluna = 16 Then lvdc_Vendas_PagSeguro 		= lvdc_vendas
				If lvl_coluna = 17 Then lvdc_Vendas_Cielo_New 		= lvdc_vendas
				If lvl_coluna = 18 Then lvdc_Vendas_Bin 		= lvdc_vendas	
			
			Next
			wf_grava_linha (lvl_coluna, lvi_Contador, lvdc_Vendas_visa, lvdc_Vendas_Redecard, lvdc_Vendas_goodcard, lvdc_Vendas_banrisul, lvdc_Vendas_sicoob, lvdc_Vendas_senffnet, lvdc_Vendas_Telenet, lvdc_Vendas_CooperCred, &
								lvdc_Vendas_VerdeCard, lvdc_Vendas_PersonalCard, lvdc_Vendas_PoliCard,  lvdc_Vendas_BrasilCard, lvdc_Vendas_RomCard, lvdc_Vendas_PicPay, lvdc_Vendas_MercadoPago, lvdc_Vendas_PagSeguro, lvdc_Vendas_Cielo_New,lvdc_Vendas_Bin	)
		End If		
		
		w_aguarde.uo_progress.Of_SetProgress(lvi_contador)
	Next
	
	
	This.ivm_Menu.mf_SalvarComo(lvi_contador > 0)	

	SetPointer(Arrow!)
	This.of_SetRowSelection()

Finally
	Close(w_aguarde)
	This.SetRedraw(True)
End Try

Return AncestorReturnValue
end event

event dw_2::ue_reset;call super::ue_reset;This.ivm_Menu.mf_SalvarComo(False)	
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge186_movimentacao_vendas
integer x = 2747
integer y = 72
integer width = 407
integer height = 196
integer taborder = 50
boolean hscrollbar = true
end type

