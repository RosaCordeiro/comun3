HA$PBExportHeader$uo_cartao_conciliacao.sru
forward
global type uo_cartao_conciliacao from nonvisualobject
end type
end forward

global type uo_cartao_conciliacao from nonvisualobject
end type
global uo_cartao_conciliacao uo_cartao_conciliacao

forward prototypes
public subroutine of_valor_parcela (decimal adc_valor_total, integer ai_qtde_parcelas, ref decimal adc_parcela[])
public subroutine of_conciliacao ()
public function boolean of_avista_rec_parcelada ()
public function boolean of_parcelada_rec_avista ()
public subroutine of_data_parcela (string as_tipo_venda, date adt_venda, integer ai_qtde_parcelas, ref date adt_deposito[], ref date adt_credito[])
public function boolean of_data_estab_cartao_diferente ()
public function boolean of_autorizacao_diferente ()
end prototypes

public subroutine of_valor_parcela (decimal adc_valor_total, integer ai_qtde_parcelas, ref decimal adc_parcela[]);Decimal lvdc_Parcela, &
        lvdc_Total

Integer lvi_Parcela		  
		  
lvdc_Parcela = Truncate(adc_Valor_Total / ai_Qtde_Parcelas, 2)

For lvi_Parcela = ai_Qtde_Parcelas To 1 Step -1
	If lvi_Parcela = 1 Then
		adc_Parcela[lvi_Parcela] = adc_Valor_Total - lvdc_Total
	Else
		adc_Parcela[lvi_Parcela] = lvdc_Parcela
		lvdc_Total += lvdc_Parcela
	End If
Next
end subroutine

public subroutine of_conciliacao ();Boolean lvb_Sucesso = False

If This.of_Avista_Rec_Parcelada() Then
	SqlCa.of_Commit()
	
	If This.of_Parcelada_Rec_Avista() Then
		SqlCa.of_Commit()
		
		If This.of_Data_Estab_Cartao_Diferente() Then
			SqlCa.of_Commit()
			
			If This.of_Autorizacao_Diferente() Then
				lvb_Sucesso = True
			End If
		End If		
	End If
End If

If lvb_Sucesso Then
	SqlCa.of_Commit()
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Concilia$$HEX2$$e700e300$$ENDHEX$$o das vendas realizada com sucesso.", Information!)
Else
	SqlCa.of_RollBack()
End If
end subroutine

public function boolean of_avista_rec_parcelada ();Boolean lvb_Sucesso = True

Long lvl_Total, &
     lvl_Contador, &
	  lvl_Comprovante, &
	  lvl_Administradora, &
	  lvl_Filial, &
	  lvl_NF, &
	  lvl_Controle_Caixa, &
	  lvl_Comprovante_Caixa
	  
String lvs_Tipo_Venda, &
		 lvs_Autorizacao, &
		 lvs_Especie, &
		 lvs_Serie, &
		 lvs_Captura, &
		 lvs_Caixa, &
		 lvs_Estabelecimento, &
		 lvs_Cartao
		 
Integer lvi_Qtde_Parcelas, & 
        lvi_Ultima_Parcela, &
		  lvi_Parcela, &
		  lvi_Parcelas_Incluidas

Decimal lvdc_Total_Parcelas, &
        lvdc_Operacao, &
		  lvdc_Parcela[]
		  
DateTime lvdh_Operacao

Date lvdt_Deposito[], &
	  lvdt_Credito[]

dc_uo_ds_Base lvds
lvds = Create dc_uo_ds_Base

If Not lvds.of_ChangeDataObject("dw_ge028_avista_rec_parcelada") Then
	Destroy(lvds)
	Return False
End If

SetPointer(HourGlass!)
Open(w_Aguarde)
w_Aguarde.Title = "Conciliando Vendas a Vista Recebidas em Parcelas..."

lvl_Total = lvds.Retrieve()

If lvl_Total > 0 Then
	w_Aguarde.uo_Progress.of_SetMax(lvl_Total)
	
	For lvl_Contador = 1 To lvl_Total
		lvl_Comprovante       = lvds.Object.Nr_Comprovante      [lvl_Contador]
		lvl_Administradora    = lvds.Object.Cd_Administradora   [lvl_Contador]
		lvs_Tipo_Venda        = lvds.Object.Id_Tipo_Operacao    [lvl_Contador]
		lvs_Autorizacao       = lvds.Object.Nr_Autorizacao      [lvl_Contador]
		lvdh_Operacao		    = lvds.Object.Dh_Operacao         [lvl_Contador]
		lvl_Filial            = lvds.Object.Cd_Filial           [lvl_Contador]
		lvl_NF                = lvds.Object.Nr_NF               [lvl_Contador]
		lvs_Especie           = lvds.Object.De_Especie          [lvl_Contador]
		lvs_Serie             = lvds.Object.De_Serie            [lvl_Contador]
		lvs_Captura           = lvds.Object.Id_Captura          [lvl_Contador]
		lvdc_Operacao		    = lvds.Object.Vl_Operacao         [lvl_Contador]
		lvs_Caixa      	    = lvds.Object.Cd_Caixa            [lvl_Contador]
		lvl_Controle_Caixa    = lvds.Object.Nr_Controle_Caixa   [lvl_Contador]
		lvl_Comprovante_Caixa = lvds.Object.Nr_Comprovante_Caixa[lvl_Contador]
		lvs_Estabelecimento   = lvds.Object.Cd_Estabelecimento  [lvl_Contador]
		lvs_Cartao            = lvds.Object.Nr_Cartao           [lvl_Contador]
		
		lvs_Cartao = LeftA(lvs_Cartao, 16)
		
		// Localiza as parcelas referentes a venda em aberto
		Select qt_parcelas,
				 max(nr_parcela),
				 sum(vl_parcela)
		Into :lvi_Qtde_Parcelas,
		     :lvi_Ultima_Parcela,
			  :lvdc_Total_Parcelas
		From cartao_comprovante_operacao
		Where cd_administradora = :lvl_Administradora
		  and id_tipo_operacao  = :lvs_Tipo_Venda
		  and nr_autorizacao    = :lvs_Autorizacao
		  and (cd_estabelecimento          = :lvs_Estabelecimento or
				 dh_operacao                 = :lvdh_Operacao or
				 substring(nr_cartao, 1, 16) = :lvs_Cartao)
		  and qt_parcelas > 1
		  and id_captura = 'A'
		Group By qt_parcelas
		Using SqlCa;		
		
		Choose Case SqlCa.SqlCode
			Case 0
				lvi_Parcelas_Incluidas = 0
				
				// Verifica se o total das parcelas confere com valor da opera$$HEX2$$e700e300$$ENDHEX$$o a vista
				If lvdc_Total_Parcelas > lvdc_Operacao Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Total das parcelas n$$HEX1$$e300$$ENDHEX$$o pode ser maior que o valor da opera$$HEX2$$e700e300$$ENDHEX$$o a vista.", StopSign!)
					lvb_Sucesso = False
					Exit
				End If
				
				If lvdc_Total_Parcelas < lvdc_Operacao Then
					If lvi_Ultima_Parcela >= lvi_Qtde_Parcelas Then
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A $$HEX1$$fa00$$ENDHEX$$ltima parcela deve ser menor que o total de parcelas.", StopSign!)
						lvb_Sucesso = False
						Exit
					End If

					This.of_Valor_Parcela(lvdc_Operacao, &
											    lvi_Qtde_Parcelas, &
											    ref lvdc_Parcela)
										  
					This.of_Data_Parcela(lvs_Tipo_Venda, &
											   Date(lvdh_Operacao), &
											   lvi_Qtde_Parcelas, &
											   ref lvdt_Deposito, &
											   ref lvdt_Credito)										  
					
					For lvi_Parcela = lvi_Ultima_Parcela + 1 To lvi_Qtde_Parcelas
						Insert Into cartao_comprovante_operacao (cd_administradora,   
																			  cd_estabelecimento,   
																			  nr_cartao,   
																			  nr_autorizacao,   
																			  nr_nsu,   
																			  dh_operacao,   
																			  dh_deposito,   
																			  dh_credito,   
																			  id_tipo_operacao,   
																			  vl_operacao,   
																			  qt_parcelas,   
																			  nr_parcela,   
																			  vl_parcela,   
																			  vl_comissao,   
																			  id_captura,   
																			  id_situacao,   
																			  cd_filial,   
																			  nr_nf,   
																			  de_especie,   
																			  de_serie,   
																			  nr_lote,   
																			  de_motivo_rejeicao,
																			  cd_caixa,
																			  nr_controle_caixa,
																			  nr_comprovante_caixa)  
						Select cd_administradora,   
							    cd_estabelecimento,   
							    nr_cartao,   
							    nr_autorizacao,   
							    nr_nsu,   
							    dh_operacao,   
							    :lvdt_Deposito[lvi_Parcela],   
							    :lvdt_Credito[lvi_Parcela],   
							    id_tipo_operacao,   
							    :lvdc_Operacao,   
							    :lvi_Qtde_Parcelas,   
							    :lvi_Parcela,   
							    :lvdc_Parcela[lvi_Parcela],   
							    vl_comissao,   
							    :lvs_Captura,   
							    'A', 
							    :lvl_Filial,
							    :lvl_NF,
							    :lvs_Especie,   
							    :lvs_Serie,   
							    null,   
							    null,
								 :lvs_Caixa,
								 :lvl_Controle_Caixa,
								 :lvl_Comprovante_Caixa
						From cartao_comprovante_operacao
						Where cd_administradora = :lvl_Administradora
						  and id_tipo_operacao  = :lvs_Tipo_Venda
						  and nr_autorizacao    = :lvs_Autorizacao
						  and (cd_estabelecimento          = :lvs_Estabelecimento or
								 dh_operacao                 = :lvdh_Operacao or
								 substring(nr_cartao, 1, 16) = :lvs_Cartao)
						  and id_captura        = 'A'
						  and nr_parcela        = :lvi_Ultima_Parcela
						Using SqlCa;
																			  
						If SqlCa.SqlCode = -1 Then
							SqlCa.of_MsgdbError("Inclus$$HEX1$$e300$$ENDHEX$$o da Nova Parcela")
							lvb_Sucesso = False
							Exit
						End If
						
						If SqlCa.SqlnRows <> 1 Then
							MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na inclus$$HEX1$$e300$$ENDHEX$$o da nova parcela.~r" + &
														 "N$$HEX1$$fa00$$ENDHEX$$mero de linhas inclu$$HEX1$$ed00$$ENDHEX$$das '" + String(SqlCa.SqlnRows) + "'.", StopSign!)
							lvb_Sucesso = False
							Exit
						End If					
						
						lvdc_Total_Parcelas    += lvdc_Parcela[lvi_Parcela]
						lvi_Parcelas_Incluidas += 1
					Next
					
					If Not lvb_Sucesso Then Exit
				End If
				
				If lvdc_Total_Parcelas <> lvdc_Operacao Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Total das parcelas deve ser igual ao valor da opera$$HEX2$$e700e300$$ENDHEX$$o a vista.", StopSign!)
					lvb_Sucesso = False
					Exit
				End If
				
				If (lvi_Ultima_Parcela + lvi_Parcelas_Incluidas) <> lvi_Qtde_Parcelas Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A $$HEX1$$fa00$$ENDHEX$$ltima parcela deve ser igual ao total de parcelas.", StopSign!)
					lvb_Sucesso = False
					Exit
				End If					
								
				// Atualiza os comprovantes das parcelas
				Update cartao_comprovante_operacao
				Set cd_filial            = :lvl_Filial,
					 nr_nf                = :lvl_NF,
					 de_especie           = :lvs_Especie,
					 de_serie             = :lvs_Serie,
					 id_captura           = :lvs_Captura,
					 vl_operacao          = :lvdc_Operacao,
					 cd_caixa             = :lvs_Caixa,
					 nr_controle_caixa    = :lvl_Controle_Caixa,
					 nr_comprovante_caixa = :lvl_Comprovante_Caixa					 
				Where cd_administradora = :lvl_Administradora
				  and id_tipo_operacao  = :lvs_Tipo_Venda
				  and nr_autorizacao    = :lvs_Autorizacao
				  and (cd_estabelecimento          = :lvs_Estabelecimento or
						 dh_operacao                 = :lvdh_Operacao or
						 substring(nr_cartao, 1, 16) = :lvs_Cartao)
				  and qt_parcelas > 1
				  and id_captura = 'A'
				Using SqlCa;
				
				If SqlCa.SqlCode = -1 Then
					SqlCa.of_MsgdbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o dos Comprovantes das Parcelas")
					lvb_Sucesso = False
					Exit
				End If
		
				If SqlCa.SqlnRows <> lvi_Ultima_Parcela Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o dos comprovantes das parcelas.~r" + &
												 "N$$HEX1$$fa00$$ENDHEX$$mero de linhas atualizadas '" + String(SqlCa.SqlnRows) + "'.", StopSign!)
					lvb_Sucesso = False
					Exit
				End If					

				// Exclui o comprovante de venda
				Delete From cartao_comprovante_operacao
				Where nr_comprovante = :lvl_Comprovante
				Using SqlCa;
				
				If SqlCa.SqlCode = -1 Then
					SqlCa.of_MsgdbError("Exclus$$HEX1$$e300$$ENDHEX$$o do Comprovante de Venda")
					lvb_Sucesso = False
					Exit
				End If
				
				If SqlCa.SqlnRows <> 1 Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na exclus$$HEX1$$e300$$ENDHEX$$o do comprovante de venda.~r" + &
												 "N$$HEX1$$fa00$$ENDHEX$$mero de linhas excluidas '" + String(SqlCa.SqlnRows) + "'.", StopSign!)
					lvb_Sucesso = False
					Exit
				End If					
				
			Case 100
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Parcelas a prazo n$$HEX1$$e300$$ENDHEX$$o foram localizadas.", StopSign!)
				lvb_Sucesso = False
				Exit
				
			Case -1
				SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o das Parcelas a Prazo")
				lvb_Sucesso = False
				Exit
		End Choose
			
		w_Aguarde.uo_Progress.of_SetProgress(lvl_Contador)
	Next
End If

Close(w_Aguarde)
SetPointer(Arrow!)
Destroy(lvds)

Return lvb_Sucesso
end function

public function boolean of_parcelada_rec_avista ();Boolean lvb_Sucesso = True

Long lvl_Total, &
     lvl_Contador, &
	  lvl_Comprovante, &
	  lvl_Administradora, &
	  lvl_Filial, &
	  lvl_NF, &
	  lvl_Controle_Caixa, &
	  lvl_Comprovante_Caixa
	  
String lvs_Tipo_Venda, &
		 lvs_Autorizacao, &
		 lvs_Especie, &
		 lvs_Serie, &
		 lvs_Captura, &
		 lvs_Caixa
		 
Integer lvi_Qtde_Parcelas

Decimal lvdc_Operacao
		  
dc_uo_ds_Base lvds
lvds = Create dc_uo_ds_Base

If Not lvds.of_ChangeDataObject("dw_ge028_parcelada_rec_avista") Then
	Destroy(lvds)
	Return False
End If

SetPointer(HourGlass!)
Open(w_Aguarde)
w_Aguarde.Title = "Conciliando Vendas Parceladas Recebidas a Vista..."

lvl_Total = lvds.Retrieve()

If lvl_Total > 0 Then
	w_Aguarde.uo_Progress.of_SetMax(lvl_Total)
	
	For lvl_Contador = 1 To lvl_Total
		lvl_Comprovante    = lvds.Object.Nr_Comprovante   [lvl_Contador]
		lvl_Administradora = lvds.Object.Cd_Administradora[lvl_Contador]
		lvs_Tipo_Venda     = lvds.Object.Id_Tipo_Operacao [lvl_Contador]
		lvs_Autorizacao    = lvds.Object.Nr_Autorizacao   [lvl_Contador]
		lvdc_Operacao      = lvds.Object.Vl_Operacao      [lvl_Contador]
		
		// Localiza as parcelas referentes ao comprovante recebido a vista
		Select cd_filial,
				 nr_nf,
				 de_especie,
				 de_serie,
				 id_captura,
				 cd_caixa,
				 nr_controle_caixa,
				 nr_comprovante_caixa,
 				 count(*)
		Into :lvl_Filial,
		     :lvl_NF, 
			  :lvs_Especie,
			  :lvs_Serie,
			  :lvs_Captura,
			  :lvs_Caixa,
			  :lvl_Controle_Caixa,
			  :lvl_Comprovante_Caixa,
			  :lvi_Qtde_Parcelas
		From cartao_comprovante_operacao
		Where cd_administradora = :lvl_Administradora
		  and id_tipo_operacao  = :lvs_Tipo_Venda
		  and nr_autorizacao    = :lvs_Autorizacao
		  and vl_operacao       = :lvdc_Operacao
		  and qt_parcelas       > 1
		  and id_situacao       = 'A'		  
		Group by cd_filial,
					nr_nf,
					de_especie,
					de_serie,
					id_captura,
				   cd_caixa,
				   nr_controle_caixa,
				   nr_comprovante_caixa					
		Having sum(vl_parcela) = :lvdc_Operacao
		Using SqlCa;

		Choose Case SqlCa.SqlCode
			Case 0
				// Atualiza o comprovante recebido a vista
				Update cartao_comprovante_operacao
				Set cd_filial            = :lvl_Filial,
					 nr_nf                = :lvl_NF,
					 de_especie           = :lvs_Especie,
					 de_serie             = :lvs_Serie,
					 id_captura           = :lvs_Captura,
					 cd_caixa             = :lvs_Caixa,
					 nr_controle_caixa    = :lvl_Controle_Caixa,
					 nr_comprovante_caixa = :lvl_Comprovante_Caixa					 
				Where nr_comprovante = :lvl_Comprovante
				Using SqlCa;
				
				If SqlCa.SqlCode = -1 Then
					SqlCa.of_MsgdbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do Comprovante a Vista")
					lvb_Sucesso = False
					Exit
				End If
		
				If SqlCa.SqlnRows <> 1 Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do comprovante a vista.~r" + &
												 "N$$HEX1$$fa00$$ENDHEX$$mero de linhas atualizadas '" + String(SqlCa.SqlnRows) + "'.", StopSign!)
					lvb_Sucesso = False
					Exit
				End If					
	
				// Exclui o comprovantes recebidos da filial
				Delete From cartao_comprovante_operacao
				Where cd_administradora = :lvl_Administradora
				  and id_tipo_operacao  = :lvs_Tipo_Venda
				  and nr_autorizacao    = :lvs_Autorizacao
				  and vl_operacao       = :lvdc_Operacao
  				  and qt_parcelas       > 1
				  and id_situacao       = 'A'
				Using SqlCa;
				
				If SqlCa.SqlCode = -1 Then
					SqlCa.of_MsgdbError("Exclus$$HEX1$$e300$$ENDHEX$$o do Comprovante de Venda")
					lvb_Sucesso = False
					Exit
				End If
		
				If SqlCa.SqlnRows <> lvi_Qtde_Parcelas Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na exclus$$HEX1$$e300$$ENDHEX$$o do comprovante de venda.~r" + &
												 "N$$HEX1$$fa00$$ENDHEX$$mero de linhas exclu$$HEX1$$ed00$$ENDHEX$$das '" + String(SqlCa.SqlnRows) + "'.", StopSign!)
					lvb_Sucesso = False
					Exit
				End If
	
			Case 100
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Parcelas a prazo n$$HEX1$$e300$$ENDHEX$$o foram localizadas.", StopSign!)
				lvb_Sucesso = False
				Exit
				
			Case -1
				SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o das Parcelas a Prazo")
				lvb_Sucesso = False
				Exit
		End Choose
	
		w_Aguarde.uo_Progress.of_SetProgress(lvl_Contador)
	Next
End If

Close(w_Aguarde)
SetPointer(Arrow!)
Destroy(lvds)

Return lvb_Sucesso
end function

public subroutine of_data_parcela (string as_tipo_venda, date adt_venda, integer ai_qtde_parcelas, ref date adt_deposito[], ref date adt_credito[]);Integer lvi_Parcela, &
		  lvi_Dia, &
        lvi_Mes, &
		  lvi_Ano

Date lvdt_Ultimo_Dia

dc_uo_Data lvo_Data
lvo_Data = Create dc_uo_Data

adt_Deposito[1] = adt_Venda

If as_Tipo_Venda = "VD" Then
	adt_Credito[1] = RelativeDate(adt_Venda, 2)
Else
	adt_Credito[1] = RelativeDate(adt_Venda, 30)
End If

lvi_Dia = Day  (adt_Venda)
lvi_Mes = Month(adt_Venda)
lvi_Ano = Year (adt_Venda)

For lvi_Parcela = 2 To ai_Qtde_Parcelas
	If lvi_Mes = 12 Then
		lvi_Mes = 1
		lvi_Ano ++
	Else
		lvi_Mes ++
	End If

	lvdt_Ultimo_Dia = lvo_Data.of_Ultimo_Dia_Mes(lvi_Mes, lvi_Ano)
	
	If Day(lvdt_Ultimo_Dia) > lvi_Dia Then
		adt_Deposito[lvi_Parcela] = Date(String(lvi_Dia) + "/" + String(lvdt_Ultimo_Dia, "mm/yyyy"))
	Else
		adt_Deposito[lvi_Parcela] = lvdt_Ultimo_Dia
	End If
	
	If as_Tipo_Venda = "VD" Then
		adt_Credito[lvi_Parcela] = RelativeDate(adt_Deposito[lvi_Parcela], 2)
	Else
		adt_Credito[lvi_Parcela] = RelativeDate(adt_Deposito[lvi_Parcela], 30)
	End If
Next

Destroy(lvo_Data)
end subroutine

public function boolean of_data_estab_cartao_diferente ();Boolean lvb_Sucesso = True

Long lvl_Total, &
     lvl_Contador, &
	  lvl_Comprovante_Venda, &
	  lvl_Comprovante_Deposito, &
	  lvl_Filial, &
	  lvl_NF, &
	  lvl_Controle_Caixa, &
	  lvl_Comprovante_Caixa
	  
String lvs_Especie, &
		 lvs_Serie, &
		 lvs_Captura, &
		 lvs_Caixa
		 
Decimal lvdc_Operacao

dc_uo_ds_Base lvds
lvds = Create dc_uo_ds_Base

If Not lvds.of_ChangeDataObject("dw_ge028_data_estab_cartao_diferente") Then
	Destroy(lvds)
	Return False
End If

SetPointer(HourGlass!)
Open(w_Aguarde)
w_Aguarde.Title = "Conciliando Vendas com Data ou Estabelecimento Diferente..."

lvl_Total = lvds.Retrieve()

If lvl_Total > 0 Then
	w_Aguarde.uo_Progress.of_SetMax(lvl_Total)
	
	For lvl_Contador = 1 To lvl_Total
		lvl_Comprovante_Deposito = lvds.Object.Nr_Comprovante_Deposito[lvl_Contador]
		lvl_Comprovante_Venda    = lvds.Object.Nr_Comprovante_Venda   [lvl_Contador]
		lvl_Filial               = lvds.Object.Cd_Filial              [lvl_Contador]
		lvl_NF                   = lvds.Object.Nr_NF                  [lvl_Contador]
		lvs_Especie              = lvds.Object.De_Especie             [lvl_Contador]
		lvs_Serie                = lvds.Object.De_Serie               [lvl_Contador]
		lvs_Captura              = lvds.Object.Id_Captura             [lvl_Contador]
		lvdc_Operacao		       = lvds.Object.Vl_Operacao            [lvl_Contador]
		lvs_Caixa      	       = lvds.Object.Cd_Caixa               [lvl_Contador]
		lvl_Controle_Caixa       = lvds.Object.Nr_Controle_Caixa      [lvl_Contador]
		lvl_Comprovante_Caixa    = lvds.Object.Nr_Comprovante_Caixa   [lvl_Contador]
		
		// Atualiza o comprovante de dep$$HEX1$$f300$$ENDHEX$$sito
		Update cartao_comprovante_operacao
		Set cd_filial            = :lvl_Filial,
			 nr_nf                = :lvl_NF,
			 de_especie           = :lvs_Especie,
			 de_serie             = :lvs_Serie,
			 id_captura           = :lvs_Captura,
			 vl_operacao          = :lvdc_Operacao,
			 cd_caixa             = :lvs_Caixa,
			 nr_controle_caixa    = :lvl_Controle_Caixa,
			 nr_comprovante_caixa = :lvl_Comprovante_Caixa
		Where nr_comprovante = :lvl_Comprovante_Deposito
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgdbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do Comprovante de Dep$$HEX1$$f300$$ENDHEX$$sito")
			lvb_Sucesso = False
			Exit
		End If

		If SqlCa.SqlnRows <> 1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do comprovante de dep$$HEX1$$f300$$ENDHEX$$sito.~r" + &
										 "N$$HEX1$$fa00$$ENDHEX$$mero de linhas atualizadas '" + String(SqlCa.SqlnRows) + "'.", StopSign!)
			lvb_Sucesso = False
			Exit
		End If
	
		// Exclui o comprovante de venda
		Delete From cartao_comprovante_operacao
		Where nr_comprovante = :lvl_Comprovante_Venda
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgdbError("Exclus$$HEX1$$e300$$ENDHEX$$o do Comprovante de Venda")
			lvb_Sucesso = False
			Exit
		End If

		If SqlCa.SqlnRows <> 1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na exclus$$HEX1$$e300$$ENDHEX$$o do comprovante de venda.~r" + &
										 "N$$HEX1$$fa00$$ENDHEX$$mero de linhas exclu$$HEX1$$ed00$$ENDHEX$$das '" + String(SqlCa.SqlnRows) + "'.", StopSign!)
			lvb_Sucesso = False
			Exit
		End If

		w_Aguarde.uo_Progress.of_SetProgress(lvl_Contador)
	Next
End If

Close(w_Aguarde)
SetPointer(Arrow!)
Destroy(lvds)

Return lvb_Sucesso
end function

public function boolean of_autorizacao_diferente ();Boolean lvb_Sucesso = True

Long lvl_Total, &
     lvl_Contador, &
	  lvl_Comprovante_Venda, &
	  lvl_Comprovante_Deposito, &
	  lvl_Filial, &
	  lvl_NF, &
	  lvl_Controle_Caixa, &
	  lvl_Comprovante_Caixa
	  
String lvs_Especie, &
		 lvs_Serie, &
		 lvs_Captura, &
		 lvs_Caixa
		 
Decimal lvdc_Operacao

dc_uo_ds_Base lvds
lvds = Create dc_uo_ds_Base

If Not lvds.of_ChangeDataObject("dw_ge028_autorizacao_diferente") Then
	Destroy(lvds)
	Return False
End If

SetPointer(HourGlass!)
Open(w_Aguarde)
w_Aguarde.Title = "Conciliando Vendas com Autoriza$$HEX2$$e700e300$$ENDHEX$$o Diferente..."

lvl_Total = lvds.Retrieve()

If lvl_Total > 0 Then
	w_Aguarde.uo_Progress.of_SetMax(lvl_Total)
	
	For lvl_Contador = 1 To lvl_Total
		lvl_Comprovante_Deposito = lvds.Object.Nr_Comprovante_Deposito[lvl_Contador]
		lvl_Comprovante_Venda    = lvds.Object.Nr_Comprovante_Venda   [lvl_Contador]
		lvl_Filial               = lvds.Object.Cd_Filial              [lvl_Contador]
		lvl_NF                   = lvds.Object.Nr_NF                  [lvl_Contador]
		lvs_Especie              = lvds.Object.De_Especie             [lvl_Contador]
		lvs_Serie                = lvds.Object.De_Serie               [lvl_Contador]
		lvs_Captura              = lvds.Object.Id_Captura             [lvl_Contador]
		lvdc_Operacao		       = lvds.Object.Vl_Operacao            [lvl_Contador]
		lvs_Caixa      	       = lvds.Object.Cd_Caixa               [lvl_Contador]
		lvl_Controle_Caixa       = lvds.Object.Nr_Controle_Caixa      [lvl_Contador]
		lvl_Comprovante_Caixa    = lvds.Object.Nr_Comprovante_Caixa   [lvl_Contador]
		
		// Atualiza o comprovante de dep$$HEX1$$f300$$ENDHEX$$sito
		Update cartao_comprovante_operacao
		Set cd_filial            = :lvl_Filial,
			 nr_nf                = :lvl_NF,
			 de_especie           = :lvs_Especie,
			 de_serie             = :lvs_Serie,
			 id_captura           = :lvs_Captura,
			 vl_operacao          = :lvdc_Operacao,
			 cd_caixa             = :lvs_Caixa,
			 nr_controle_caixa    = :lvl_Controle_Caixa,
			 nr_comprovante_caixa = :lvl_Comprovante_Caixa
		Where nr_comprovante = :lvl_Comprovante_Deposito
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgdbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do Comprovante de Dep$$HEX1$$f300$$ENDHEX$$sito")
			lvb_Sucesso = False
			Exit
		End If

		If SqlCa.SqlnRows <> 1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do comprovante de dep$$HEX1$$f300$$ENDHEX$$sito.~r" + &
										 "N$$HEX1$$fa00$$ENDHEX$$mero de linhas atualizadas '" + String(SqlCa.SqlnRows) + "'.", StopSign!)
			lvb_Sucesso = False
			Exit
		End If
	
		// Exclui o comprovante de venda
		Delete From cartao_comprovante_operacao
		Where nr_comprovante = :lvl_Comprovante_Venda
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgdbError("Exclus$$HEX1$$e300$$ENDHEX$$o do Comprovante de Venda")
			lvb_Sucesso = False
			Exit
		End If

		If SqlCa.SqlnRows <> 1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na exclus$$HEX1$$e300$$ENDHEX$$o do comprovante de venda '" + String(lvl_Comprovante_Venda) + "'.~r" + &
										 "N$$HEX1$$fa00$$ENDHEX$$mero de linhas exclu$$HEX1$$ed00$$ENDHEX$$das '" + String(SqlCa.SqlnRows) + "'.", StopSign!)
			lvb_Sucesso = False
			Exit
		End If

		w_Aguarde.uo_Progress.of_SetProgress(lvl_Contador)
	Next
End If

Close(w_Aguarde)
SetPointer(Arrow!)
Destroy(lvds)

Return lvb_Sucesso
end function

on uo_cartao_conciliacao.create
TriggerEvent( this, "constructor" )
end on

on uo_cartao_conciliacao.destroy
TriggerEvent( this, "destructor" )
end on

