HA$PBExportHeader$uo_ge589_importacao_j1btax.sru
forward
global type uo_ge589_importacao_j1btax from nonvisualobject
end type
end forward

global type uo_ge589_importacao_j1btax from nonvisualobject
end type
global uo_ge589_importacao_j1btax uo_ge589_importacao_j1btax

type variables
Boolean ivb_Visual = False
dc_uo_Transacao itr_Trans

Long ivl_Inserts, ivl_Updates, ivl_Invalidos[]
end variables

forward prototypes
public function boolean of_j_1btxpis_verifica (string ps_cd_ambiente, string ps_mandt, string ps_country, string ps_gruop, string ps_value, string ps_value2, string ps_value3, datetime pdh_validfrom, ref boolean pb_existe, ref string ps_msg)
public function boolean of_j_1btxiss_verifica (string ps_cd_ambiente, string ps_mandt, string ps_country, string ps_gruop, string ps_taxjurcode, string ps_value, string ps_value2, string ps_value3, datetime pdh_validfrom, ref boolean pb_existe, ref string ps_msg)
public function boolean of_importar_arquivo (string ps_cd_ambiente, string ps_cd_tabela, string ps_de_arquivo, ref string ps_msg)
public function boolean of_j_1btxpis_importa (string ps_cd_ambiente, long pl_linha, dc_uo_ds_base pds, ref string ps_msg)
public function boolean of_j_1btxcof_importa (string ps_cd_ambiente, long pl_linha, dc_uo_ds_base pds, ref string ps_msg)
public function boolean of_j_1btxcof_verifica (string ps_cd_ambiente, string ps_mandt, string ps_country, string ps_gruop, string ps_value, string ps_value2, string ps_value3, datetime pdh_validfrom, ref boolean pb_existe, ref string ps_msg)
public function string of_get_ordem_colunas (string ps_cd_tabela)
public function boolean of_j_1btxiss_importa (string ps_cd_ambiente, long pl_linha, dc_uo_ds_base pds, ref string ps_msg)
public function boolean of_selecionar_arquivo (string ps_cd_tabela, ref string ps_arquivo)
public function boolean of_j_1btxst3_importa (string ps_cd_ambiente, long pl_linha, dc_uo_ds_base pds, ref string ps_msg)
public function boolean of_j_1btxst3_verifica (string ps_cd_ambiente, string ps_mandt, string ps_land1, string ps_shipfrom, string ps_shipto, string ps_gruop, string ps_value, string ps_value2, string ps_value3, string ps_stgrp, datetime pdh_validfrom, ref boolean pb_existe, ref string ps_msg)
public subroutine _documentacao ()
public function boolean of_j_1btxip3_importa (string ps_cd_ambiente, long pl_linha, dc_uo_ds_base pds, ref string ps_msg)
public function boolean of_j_1btxip3_verifica (string ps_cd_ambiente, string ps_mandt, string ps_gruop, string ps_value, string ps_value2, string ps_value3, datetime pdh_validfrom, ref boolean pb_existe, ref string ps_msg)
public function boolean of_j_1btxic3_importa (string ps_cd_ambiente, long pl_linha, dc_uo_ds_base pds, ref string ps_msg)
public function boolean of_j_1btxic3_verifica (string ps_cd_ambiente, string ps_mandt, string ps_land1, string ps_shipfrom, string ps_shipto, string ps_gruop, string ps_value, string ps_value2, string ps_value3, datetime pdh_validfrom, ref boolean pb_existe, ref string ps_msg)
public subroutine of_ajusta_zeros_esquerda (ref string ps_value)
end prototypes

public function boolean of_j_1btxpis_verifica (string ps_cd_ambiente, string ps_mandt, string ps_country, string ps_gruop, string ps_value, string ps_value2, string ps_value3, datetime pdh_validfrom, ref boolean pb_existe, ref string ps_msg);Long lvl_Count

Select Count(*)
Into :lvl_Count
From	j_1btxpis
Where	
	cd_ambiente	= :ps_cd_ambiente
	and mandt	= :ps_mandt
	and country	= :ps_country
	and gruop	= :ps_gruop
	and value	= :ps_value
	and value2	= :ps_value2
	and value3	= :ps_value3
	and validfrom = :pdh_validfrom
Using itr_Trans;

Choose Case itr_Trans.SqlCode
	Case is < 0
		ps_Msg = "Erro ao verificar os dados da tabela 'j_1btxpis'.~r~r"+itr_Trans.SqlErrText
		Return False
End Choose

pb_Existe = (lvl_Count > 0)

Return True
end function

public function boolean of_j_1btxiss_verifica (string ps_cd_ambiente, string ps_mandt, string ps_country, string ps_gruop, string ps_taxjurcode, string ps_value, string ps_value2, string ps_value3, datetime pdh_validfrom, ref boolean pb_existe, ref string ps_msg);Long lvl_Count

Select Count(*)
Into :lvl_Count
From	j_1btxiss
Where	
	cd_ambiente	= :ps_cd_ambiente
	and mandt	= :ps_mandt
	and country	= :ps_country
	and gruop	= :ps_gruop
	and taxjurcode = :ps_taxjurcode
	and value	= :ps_value
	and value2	= :ps_value2
	and value3	= :ps_value3
	and validfrom = :pdh_validfrom
Using itr_Trans;

Choose Case itr_Trans.SqlCode
	Case is < 0
		ps_Msg = "Erro ao verificar os dados da tabela 'j_1btxiss'.~r~r"+itr_Trans.SqlErrText
		Return False
End Choose

pb_Existe = (lvl_Count > 0)

Return True
end function

public function boolean of_importar_arquivo (string ps_cd_ambiente, string ps_cd_tabela, string ps_de_arquivo, ref string ps_msg);dc_uo_ds_base lds
Boolean lvb_Sucesso = False // Para fazer rollback se precisar
Long lvl_Linhas, lvl_Linha
Long lvl_UmDecimoPorCento
Time lvt_HoraInicio

Try

	If ivb_Visual Then SetPointer(HourGlass!)
	If ivb_Visual Then Open(w_Aguarde)
	If ivb_Visual Then w_Aguarde.Title = "Importando arquivo..."
	
	lds = Create dc_uo_ds_base
	If Not lds.of_ChangeDataObject("ds_ge589_"+ps_cd_tabela, False) Then
		ps_Msg = "N$$HEX1$$e300$$ENDHEX$$o encontrada a datastore 'ds_ge589_"+ps_cd_tabela+"'!"
		Return False
	End If
	
	lvl_Linhas = lds.ImportFile(ps_de_arquivo, 2) // Dados a partir da linha 2
	
	Choose Case lvl_Linhas
		Case -15
			ps_Msg = "O tamanho do arquivo excedeu o limite (500 mil linhas)."
			Return False
			
	End Choose
	
	If lvl_Linhas <= 0 Then
		ps_Msg = "O arquivo n$$HEX1$$e300$$ENDHEX$$o possui dados v$$HEX1$$e100$$ENDHEX$$lidos. (ImportFile = "+String(lvl_Linhas)+")"
		Return False
	End If
		
	If ivb_Visual Then w_Aguarde.uo_Progress.of_SetMax(lvl_Linhas)
	
	lvl_UmDecimoPorCento = Long(lvl_Linhas*0.1/100)
	if lvl_UmDecimoPorCento = 0 Then lvl_UmDecimoPorCento = 1
	lvt_HoraInicio = Now()
	
	For lvl_Linha = 1 To lvl_Linhas
		
		If ivb_Visual Then
			If Mod(lvl_Linha, lvl_UmDecimoPorCento) = 0 Then
				w_Aguarde.Title = "Importando tabela '"+ps_cd_tabela+"'... ("+String(lvl_Linha)+"/"+String(lvl_Linhas)+") " +&
										"Tempo restante: "+gf_Tempo_Restante(lvl_Linha, lvl_Linhas, lvt_HoraInicio)
				w_Aguarde.uo_Progress.of_SetProgress(lvl_Linha)
				Yield()
			End If
		End If
		
		Choose Case ps_cd_tabela
			Case "J_1BTXPIS"
		 		If Not of_j_1btxpis_importa(ps_cd_ambiente, lvl_Linha, lds, ref ps_Msg) Then Return False

			Case "J_1BTXCOF"
				If Not of_j_1btxcof_importa(ps_cd_ambiente, lvl_Linha, lds, ref ps_Msg) Then Return False
				
			Case "J_1BTXISS"
				If Not of_j_1btxiss_importa(ps_cd_ambiente, lvl_Linha, lds, ref ps_Msg) Then Return False
				
			Case "J_1BTXIC3"
				If Not of_j_1btxic3_importa(ps_cd_ambiente, lvl_Linha, lds, ref ps_Msg) Then Return False
				
			Case "J_1BTXST3"
				If Not of_j_1btxst3_importa(ps_cd_ambiente, lvl_Linha, lds, ref ps_Msg) Then Return False
				
			Case "J_1BTXIP3"
				If Not of_j_1btxip3_importa(ps_cd_ambiente, lvl_Linha, lds, ref ps_Msg) Then Return False
				
		End Choose
		
		// Commit a cada 500 ou quando terminar.
		If Mod(lvl_Linha, 500) = 0 Or lvl_Linha = lvl_Linhas Then
			If itr_Trans.of_Commit() < 0 Then
				ps_Msg = "Erro ao efetuar Commit.~r~r"+itr_Trans.SqlErrText
				Return False
			End If
		End If
		
	Next
	
	If ivb_Visual Then w_Aguarde.uo_Progress.of_SetProgress(lvl_Linhas)
	
	ps_Msg = "Tabela '"+ps_cd_tabela+"' importada com sucesso!~r"
	ps_Msg += "~rInseridos: "+String(ivl_Inserts)
	ps_Msg += "~rAtualizados: "+String(ivl_Updates)
	ps_Msg += "~rIgnorados (dados inv$$HEX1$$e100$$ENDHEX$$lidos): "+String(UpperBound(ivl_Invalidos))
	ps_Msg += "~r~rTempo percorrido: "+gf_Tempo_Percorrido(lvt_HoraInicio)
	
	lvb_Sucesso = True
	Return lvb_Sucesso
	
Finally
	If Not lvb_Sucesso Then itr_Trans.of_RollBack()
	
	If ivb_Visual Then SetPointer(Arrow!)
	If ivb_Visual And isValid(w_Aguarde) Then Close(w_Aguarde)
	
	Destroy lds
End Try
end function

public function boolean of_j_1btxpis_importa (string ps_cd_ambiente, long pl_linha, dc_uo_ds_base pds, ref string ps_msg);Boolean lvb_Existe

// Chave
String lvs_cd_ambiente 
String lvs_mandt
String lvs_country
String lvs_gruop
String lvs_value
String lvs_value2
String lvs_value3
DateTime lvdh_validfrom

// Dados
DateTime lvdh_validto
Decimal{2} lvdc_rate
Decimal{2} lvdc_base
Decimal{2} lvdc_amount
Decimal{2} lvdc_factor
String lvs_unit
String lvs_waers
String lvs_taxlaw
Decimal{4} lvdc_rate4dec
Decimal{4} lvdc_amount4dec
Decimal{2} lvdc_factor4dec
Decimal{2} lvdc_minprice_amount
String lvs_minprice_currency
Decimal{3} lvdc_minprice_quantity
String lvs_minprice_uom
String lvs_minprice_taxlaw

// Chave prim$$HEX1$$e100$$ENDHEX$$ria
lvs_cd_ambiente = ps_cd_ambiente
lvs_mandt 		 = '500'

lvs_country 	= gf_Coalesce(pds.GetItemString(pl_Linha, "country"), '')
lvs_gruop 		= gf_Coalesce(pds.GetItemString(pl_Linha, "gruop"), '')
lvs_value 		= gf_Coalesce(pds.GetItemString(pl_Linha, "value"), '')
lvs_value2 		= gf_Coalesce(pds.GetItemString(pl_Linha, "value2"), '')
lvs_value3 		= gf_Coalesce(pds.GetItemString(pl_Linha, "value3"), '')
lvdh_validfrom = pds.GetItemDateTime(pl_Linha, "validfrom")

// Ignorar registros inv$$HEX1$$e100$$ENDHEX$$lidos
If lvs_country = '' or lvs_gruop = '' Or isNull(lvdh_validfrom) Then
	ivl_Invalidos[UpperBound(ivl_Invalidos)+1] = pl_Linha
	Return True
End If

// Tratar chaves dos grupos
// Obrigat$$HEX1$$f300$$ENDHEX$$rio ter o campo com 18 caracteres nos casos abaixo
// Inserindo zeros $$HEX1$$e000$$ENDHEX$$ esquerda quando necess$$HEX1$$e100$$ENDHEX$$rio
Choose Case lvs_gruop
	Case '49', '65'
		of_Ajusta_Zeros_Esquerda(Ref lvs_value)
		
//	Case ''
//		of_Ajusta_Zeros_Esquerda(Ref lvs_value2)
	
//	Case ''
//		of_Ajusta_Zeros_Esquerda(Ref lvs_value3)
		
End Choose

// Dados
lvdh_validto 	= pds.GetItemDateTime(pl_Linha, "validto")
lvdc_rate 		= pds.GetItemNumber(pl_Linha, "rate")
lvdc_base 		= pds.GetItemNumber(pl_Linha, "base")
lvdc_amount 	= pds.GetItemNumber(pl_Linha, "amount")
lvdc_factor 	= pds.GetItemNumber(pl_Linha, "factor")
lvs_unit 		= pds.GetItemString(pl_Linha, "unit")
lvs_waers 		= pds.GetItemString(pl_Linha, "waers")
lvs_taxlaw 		= pds.GetItemString(pl_Linha, "taxlaw")
lvdc_rate4dec 	= pds.GetItemNumber(pl_Linha, "rate4dec")
lvdc_amount4dec = pds.GetItemNumber(pl_Linha, "amount4dec")
lvdc_factor4dec = pds.GetItemNumber(pl_Linha, "factor4dec")
lvdc_minprice_amount 	= pds.GetItemNumber(pl_Linha, "minprice_amount")
lvs_minprice_currency 	= pds.GetItemString(pl_Linha, "minprice_currency")
lvdc_minprice_quantity 	= pds.GetItemNumber(pl_Linha, "minprice_quantity")
lvs_minprice_uom 			= pds.GetItemString(pl_Linha, "minprice_uom")
lvs_minprice_taxlaw 		= pds.GetItemString(pl_Linha, "minprice_taxlaw")

If Not of_j_1btxpis_verifica(	lvs_cd_ambiente, &
											lvs_mandt, &
											lvs_country, &
											lvs_gruop, &
											lvs_value, &
											lvs_value2, &
											lvs_value3, &
											lvdh_validfrom, &
											ref lvb_Existe, &
											ref ps_Msg) Then Return False
											
If Not lvb_Existe Then
	ivl_Inserts ++
	Insert Into j_1btxpis (	cd_ambiente,
									mandt,
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
									de_chave_sap,
									nr_controle_interface_sap)
	Values(	:lvs_cd_ambiente,
				:lvs_mandt,
				:lvs_country,
				:lvs_gruop,
				:lvs_value,
				:lvs_value2,
				:lvs_value3,
				:lvdh_validfrom,
				:lvdh_validto,
				:lvdc_rate,
				:lvdc_base,
				:lvdc_amount,
				:lvdc_factor,
				:lvs_unit,
				:lvs_waers,
				:lvs_taxlaw,
				:lvdc_rate4dec,
				:lvdc_amount4dec,
				:lvdc_factor4dec,
				:lvdc_minprice_amount,
				:lvs_minprice_currency,
				:lvdc_minprice_quantity,
				:lvs_minprice_uom,
				:lvs_minprice_taxlaw,
				GetDate(),
				GetDate(),
				'CARGA',
				NULL)
	Using itr_Trans;
Else
	ivl_Updates ++
	
	Update j_1btxpis
	Set 	/*cd_ambiente = :lvs_cd_ambiente,
			mandt 		= :lvs_mandt,
			country 		= :lvs_country,
			gruop 		= :lvs_gruop,
			value 		= :lvs_value,
			value2 		= :lvs_value2,
			value3 		= :lvs_value3,
			validfrom 	= :lvdh_validfrom,*/
			validto 		= :lvdh_validto,
			rate 			= :lvdc_rate,
			base  		= :lvdc_base,
			amount  		= :lvdc_amount,
			factor  		= :lvdc_factor,
			unit  		= :lvs_unit,
			waers  		= :lvs_waers,
			taxlaw  		= :lvs_taxlaw,
			rate4dec 	= :lvdc_rate4dec,
			amount4dec 	= :lvdc_amount4dec,
			factor4dec 	= :lvdc_factor4dec,
			minprice_amount 	= :lvdc_minprice_amount,
			minprice_currency = :lvs_minprice_currency,
			minprice_quantity = :lvdc_minprice_quantity,
			minprice_uom 		= :lvs_minprice_uom,
			minprice_taxlaw 	= :lvs_minprice_taxlaw,
			dh_inclusao 		= dh_inclusao,
			dh_alteracao 		= GetDate(),
			de_chave_sap	= 'CARGA',
			nr_controle_interface_sap = NULL
	Where
		cd_ambiente	= :lvs_cd_ambiente
		and mandt	= :lvs_mandt
		and country	= :lvs_country
		and gruop	= :lvs_gruop
		and value	= :lvs_value
		and value2	= :lvs_value2
		and value3	= :lvs_value3
		and validfrom = :lvdh_validfrom
	Using itr_Trans;
End If

Choose Case itr_Trans.SqlCode
	Case is < 0
		ps_Msg = "Erro ao "+iif(lvb_Existe, "atualizar", "inserir")+" os dados na tabela 'j_1btxpis'.~r~r"+itr_Trans.SqlErrText
		Return False
End Choose

Return True
end function

public function boolean of_j_1btxcof_importa (string ps_cd_ambiente, long pl_linha, dc_uo_ds_base pds, ref string ps_msg);Boolean lvb_Existe

// Chave
String lvs_cd_ambiente 
String lvs_mandt
String lvs_country
String lvs_gruop
String lvs_value
String lvs_value2
String lvs_value3
DateTime lvdh_validfrom

// Dados
DateTime lvdh_validto
Decimal{2} lvdc_rate
Decimal{2} lvdc_base
Decimal{2} lvdc_amount
Decimal{2} lvdc_factor
String lvs_unit
String lvs_waers
String lvs_taxlaw
Decimal{4} lvdc_rate4dec
Decimal{4} lvdc_amount4dec
Decimal{2} lvdc_factor4dec
Decimal{2} lvdc_minprice_amount
String lvs_minprice_currency
Decimal{3} lvdc_minprice_quantity
String lvs_minprice_uom
String lvs_minprice_taxlaw

// Chave prim$$HEX1$$e100$$ENDHEX$$ria
lvs_cd_ambiente = ps_cd_ambiente
lvs_mandt 		 = '500'

lvs_country 	= gf_Coalesce(pds.GetItemString(pl_Linha, "country"), '')
lvs_gruop 		= gf_Coalesce(pds.GetItemString(pl_Linha, "gruop"), '')
lvs_value 		= gf_Coalesce(pds.GetItemString(pl_Linha, "value"), '')
lvs_value2 		= gf_Coalesce(pds.GetItemString(pl_Linha, "value2"), '')
lvs_value3 		= gf_Coalesce(pds.GetItemString(pl_Linha, "value3"), '')
lvdh_validfrom = pds.GetItemDateTime(pl_Linha, "validfrom")

// Ignorar registros inv$$HEX1$$e100$$ENDHEX$$lidos
If lvs_country = '' or lvs_gruop = '' Or isNull(lvdh_validfrom) Then
	ivl_Invalidos[UpperBound(ivl_Invalidos)+1] = pl_Linha
	Return True
End If

// Tratar chaves dos grupos
// Obrigat$$HEX1$$f300$$ENDHEX$$rio ter o campo com 18 caracteres nos casos abaixo
// Inserindo zeros $$HEX1$$e000$$ENDHEX$$ esquerda quando necess$$HEX1$$e100$$ENDHEX$$rio
Choose Case lvs_gruop
	Case '49', '65'
		of_Ajusta_Zeros_Esquerda(Ref lvs_value)
		
//	Case ''
//		of_Ajusta_Zeros_Esquerda(Ref lvs_value2)
	
//	Case ''
//		of_Ajusta_Zeros_Esquerda(Ref lvs_value3)
		
End Choose

// Dados
lvdh_validto 	= pds.GetItemDateTime(pl_Linha, "validto")
lvdc_rate 		= pds.GetItemNumber(pl_Linha, "rate")
lvdc_base 		= pds.GetItemNumber(pl_Linha, "base")
lvdc_amount 	= pds.GetItemNumber(pl_Linha, "amount")
lvdc_factor 	= pds.GetItemNumber(pl_Linha, "factor")
lvs_unit 		= pds.GetItemString(pl_Linha, "unit")
lvs_waers 		= pds.GetItemString(pl_Linha, "waers")
lvs_taxlaw 		= pds.GetItemString(pl_Linha, "taxlaw")
lvdc_rate4dec 	= pds.GetItemNumber(pl_Linha, "rate4dec")
lvdc_amount4dec = pds.GetItemNumber(pl_Linha, "amount4dec")
lvdc_factor4dec = pds.GetItemNumber(pl_Linha, "factor4dec")
lvdc_minprice_amount 	= pds.GetItemNumber(pl_Linha, "minprice_amount")
lvs_minprice_currency 	= pds.GetItemString(pl_Linha, "minprice_currency")
lvdc_minprice_quantity 	= pds.GetItemNumber(pl_Linha, "minprice_quantity")
lvs_minprice_uom 			= pds.GetItemString(pl_Linha, "minprice_uom")
lvs_minprice_taxlaw 		= pds.GetItemString(pl_Linha, "minprice_taxlaw")

If Not of_j_1btxcof_verifica(	lvs_cd_ambiente, &
											lvs_mandt, &
											lvs_country, &
											lvs_gruop, &
											lvs_value, &
											lvs_value2, &
											lvs_value3, &
											lvdh_validfrom, &
											ref lvb_Existe, &
											ref ps_Msg) Then Return False
											
If Not lvb_Existe Then
	ivl_Inserts ++
	Insert Into j_1btxcof (	cd_ambiente,
									mandt,
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
									de_chave_sap,
									nr_controle_interface_sap)
	Values(	:lvs_cd_ambiente,
				:lvs_mandt,
				:lvs_country,
				:lvs_gruop,
				:lvs_value,
				:lvs_value2,
				:lvs_value3,
				:lvdh_validfrom,
				:lvdh_validto,
				:lvdc_rate,
				:lvdc_base,
				:lvdc_amount,
				:lvdc_factor,
				:lvs_unit,
				:lvs_waers,
				:lvs_taxlaw,
				:lvdc_rate4dec,
				:lvdc_amount4dec,
				:lvdc_factor4dec,
				:lvdc_minprice_amount,
				:lvs_minprice_currency,
				:lvdc_minprice_quantity,
				:lvs_minprice_uom,
				:lvs_minprice_taxlaw,
				GetDate(),
				GetDate(),
				'CARGA',
				NULL)
	Using itr_Trans;
Else
	ivl_Updates ++
	
	Update j_1btxcof
	Set 	/*cd_ambiente = :lvs_cd_ambiente,
			mandt 		= :lvs_mandt,
			country 		= :lvs_country,
			gruop 		= :lvs_gruop,
			value 		= :lvs_value,
			value2 		= :lvs_value2,
			value3 		= :lvs_value3,
			validfrom 	= :lvdh_validfrom,*/
			validto 		= :lvdh_validto,
			rate 			= :lvdc_rate,
			base  		= :lvdc_base,
			amount  		= :lvdc_amount,
			factor  		= :lvdc_factor,
			unit  		= :lvs_unit,
			waers  		= :lvs_waers,
			taxlaw  		= :lvs_taxlaw,
			rate4dec 	= :lvdc_rate4dec,
			amount4dec 	= :lvdc_amount4dec,
			factor4dec 	= :lvdc_factor4dec,
			minprice_amount 	= :lvdc_minprice_amount,
			minprice_currency = :lvs_minprice_currency,
			minprice_quantity = :lvdc_minprice_quantity,
			minprice_uom 		= :lvs_minprice_uom,
			minprice_taxlaw 	= :lvs_minprice_taxlaw,
			dh_inclusao 		= dh_inclusao,
			dh_alteracao 		= GetDate(),
			de_chave_sap	= 'CARGA',
			nr_controle_interface_sap = NULL
	Where
		cd_ambiente	= :lvs_cd_ambiente
		and mandt	= :lvs_mandt
		and country	= :lvs_country
		and gruop	= :lvs_gruop
		and value	= :lvs_value
		and value2	= :lvs_value2
		and value3	= :lvs_value3
		and validfrom = :lvdh_validfrom
	Using itr_Trans;
End If

Choose Case itr_Trans.SqlCode
	Case is < 0
		ps_Msg = "Erro ao "+iif(lvb_Existe, "atualizar", "inserir")+" os dados na tabela 'j_1btxcof'.~r~r"+itr_Trans.SqlErrText
		Return False
End Choose

Return True
end function

public function boolean of_j_1btxcof_verifica (string ps_cd_ambiente, string ps_mandt, string ps_country, string ps_gruop, string ps_value, string ps_value2, string ps_value3, datetime pdh_validfrom, ref boolean pb_existe, ref string ps_msg);Long lvl_Count

Select Count(*)
Into :lvl_Count
From	j_1btxcof
Where	
	cd_ambiente	= :ps_cd_ambiente
	and mandt	= :ps_mandt
	and country	= :ps_country
	and gruop	= :ps_gruop
	and value	= :ps_value
	and value2	= :ps_value2
	and value3	= :ps_value3
	and validfrom = :pdh_validfrom
Using itr_Trans;

Choose Case itr_Trans.SqlCode
	Case is < 0
		ps_Msg = "Erro ao verificar os dados da tabela 'j_1btxcof'.~r~r"+itr_Trans.SqlErrText
		Return False
End Choose

pb_Existe = (lvl_Count > 0)

Return True
end function

public function string of_get_ordem_colunas (string ps_cd_tabela);dc_uo_ds_base lds
String lvs_Retorno
Long lvl_For, lvl_Colunas

lds = Create dc_uo_ds_base

If lds.of_ChangeDataObject("ds_ge589_"+ps_cd_tabela, False) Then
	lvl_Colunas = Long(lds.Describe("DataWindow.Column.Count"))
	For lvl_For = 1 To lvl_Colunas
		lvs_Retorno += lds.Describe("#"+String(lvl_For)+".name") + "~r~n"
	Next
End If

Destroy lds
Return lvs_Retorno
end function

public function boolean of_j_1btxiss_importa (string ps_cd_ambiente, long pl_linha, dc_uo_ds_base pds, ref string ps_msg);Boolean lvb_Existe

// Chave
String lvs_cd_ambiente 
String lvs_mandt
String lvs_country
String lvs_gruop
String lvs_taxjurcode
String lvs_value
String lvs_value2
String lvs_value3
DateTime lvdh_validfrom

// Dados
DateTime lvdh_validto
Decimal{2} lvdc_rate
Decimal{2} lvdc_base
String lvs_taxlaw
String lvs_taxrelloc
String lvs_withhold
Decimal{2} lvdc_minval_wt
String lvs_waers

// Chave
lvs_cd_ambiente = ps_cd_ambiente
lvs_mandt 		 = '500'

lvs_country 	= gf_Coalesce(pds.GetItemString(pl_Linha, "country"), '')
lvs_gruop 		= gf_Coalesce(pds.GetItemString(pl_Linha, "gruop"), '')
lvs_taxjurcode = gf_Coalesce(pds.GetItemString(pl_Linha, "taxjurcode"), '')
lvs_value 		= gf_Coalesce(pds.GetItemString(pl_Linha, "value"), '')
lvs_value2 		= gf_Coalesce(pds.GetItemString(pl_Linha, "value2"), '')
lvs_value3 		= gf_Coalesce(pds.GetItemString(pl_Linha, "value3"), '')
lvdh_validfrom = pds.GetItemDateTime(pl_Linha, "validfrom")

// Ignorar registros inv$$HEX1$$e100$$ENDHEX$$lidos
If lvs_country = '' or lvs_gruop = '' Or lvs_taxjurcode = '' Or isNull(lvdh_validfrom) Then
	ivl_Invalidos[UpperBound(ivl_Invalidos)+1] = pl_Linha
	Return True
End If

// Dados
lvdh_validto 	= pds.GetItemDateTime(pl_Linha, "validto")
lvdc_rate 		= pds.GetItemNumber(pl_Linha, "rate")
lvdc_base 		= pds.GetItemNumber(pl_Linha, "base")
lvs_taxlaw 		= pds.GetItemString(pl_Linha, "taxlaw")
lvs_taxrelloc	= pds.GetItemString(pl_Linha, "taxrelloc")
lvs_withhold	= pds.GetItemString(pl_Linha, "withhold")
lvdc_minval_wt = pds.GetItemNumber(pl_Linha, "minval_wt")
lvs_waers 		= pds.GetItemString(pl_Linha, "waers")

If Not of_j_1btxiss_verifica(	lvs_cd_ambiente, &
											lvs_mandt, &
											lvs_country, &
											lvs_gruop, &
											lvs_taxjurcode, &
											lvs_value, &
											lvs_value2, &
											lvs_value3, &
											lvdh_validfrom, &
											ref lvb_Existe, &
											ref ps_Msg) Then Return False
											
If Not lvb_Existe Then
	ivl_Inserts ++
	Insert Into j_1btxiss (	cd_ambiente,
									mandt,
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
									nr_controle_interface_sap)
	Values(	:lvs_cd_ambiente,
				:lvs_mandt,
				:lvs_country,
				:lvs_gruop,
				:lvs_taxjurcode,
				:lvs_value,
				:lvs_value2,
				:lvs_value3,
				:lvdh_validfrom,
				:lvdh_validto,
				:lvdc_rate,
				:lvdc_base,
				:lvs_taxlaw,
				:lvs_taxrelloc,
				:lvs_withhold,
				:lvdc_minval_wt,
				:lvs_waers,
				GetDate(),
				GetDate(),
				NULL)
	Using itr_Trans;
Else
	ivl_Updates ++
	
	Update j_1btxiss
	Set 	validto 		= :lvdh_validto,
			rate 			= :lvdc_rate,
			base  		= :lvdc_base,
			taxlaw  		= :lvs_taxlaw,
			taxrelloc 	= :lvs_taxrelloc,
			withhold 	= :lvs_withhold,
			minval_wt 	= :lvdc_minval_wt,
			waers  		= :lvs_waers,
			dh_inclusao = dh_inclusao,
			dh_alteracao = GetDate(),
			nr_controle_interface_sap = NULL
	Where
		cd_ambiente	= :lvs_cd_ambiente
		and mandt	= :lvs_mandt
		and country	= :lvs_country
		and gruop	= :lvs_gruop
		and taxjurcode = :lvs_taxjurcode
		and value	= :lvs_value
		and value2	= :lvs_value2
		and value3	= :lvs_value3
		and validfrom = :lvdh_validfrom
	Using itr_Trans;
End If

Choose Case itr_Trans.SqlCode
	Case is < 0
		ps_Msg = "Erro ao "+iif(lvb_Existe, "atualizar", "inserir")+" os dados na tabela 'j_1btxiss'.~r~r"+itr_Trans.SqlErrText
		Return False
End Choose

Return True
end function

public function boolean of_selecionar_arquivo (string ps_cd_tabela, ref string ps_arquivo);Integer lvi_Retorno
String lvs_Nome, lvs_Colunas

lvs_Colunas = of_Get_Ordem_Colunas(ps_cd_tabela)

If lvs_Colunas = '' Then
	MessageBox("ATEN$$HEX2$$c700c300$$ENDHEX$$O", "Erro ao verificar as colunas da tabela '"+ps_cd_tabela+"'.", StopSign!)
	Return False
End If

MessageBox("ATEN$$HEX2$$c700c300$$ENDHEX$$O", "Certifique-se de selecionar um arquivo correspondente $$HEX1$$e000$$ENDHEX$$ tabela '"+ps_cd_tabela+"'!~r" +&
							"Limite de linhas: 500 mil~r~r" +&
							"Os dados devem estar na seguinte ordem:~r~n" + &
							lvs_Colunas)

lvi_Retorno = GetFileOpenName("Selecione o arquivo", + ps_Arquivo, lvs_Nome, "TXT", "Documentos de texto (*.txt),*.txt")

Return True
end function

public function boolean of_j_1btxst3_importa (string ps_cd_ambiente, long pl_linha, dc_uo_ds_base pds, ref string ps_msg);Boolean lvb_Existe

// Chave
String lvs_cd_ambiente 
String lvs_mandt
String lvs_land1
String lvs_shipfrom
String lvs_shipto
String lvs_gruop
String lvs_value
String lvs_value2
String lvs_value3
String lvs_stgrp
DateTime lvdh_validfrom

// Dados
DateTime lvdh_validto
String lvs_sur_type
Decimal{2} lvdc_rate
Decimal{2} lvdc_price
Decimal{2} lvdc_factor
String lvs_unit
Decimal{2} lvdc_basered1
Decimal{2} lvdc_basered2
Decimal{2} lvdc_icmsbaser
Decimal{2} lvdc_minprice
String lvs_waers
Decimal{2} lvdc_minfact
String lvs_surchin
Decimal{2} lvdc_fcp_basered1
Decimal{2} lvdc_fcp_basered2

// Chave
lvs_cd_ambiente = ps_cd_ambiente
lvs_mandt 		 = '500'

lvs_land1 		= gf_Coalesce(pds.GetItemString(pl_Linha, "land1"), '')
lvs_shipfrom	= gf_Coalesce(pds.GetItemString(pl_Linha, "shipfrom"), '')
lvs_shipto 		= gf_Coalesce(pds.GetItemString(pl_Linha, "shipto"), '')
lvs_gruop 		= gf_Coalesce(pds.GetItemString(pl_Linha, "gruop"), '')
lvs_value 		= gf_Coalesce(pds.GetItemString(pl_Linha, "value"), '')
lvs_value2 		= gf_Coalesce(pds.GetItemString(pl_Linha, "value2"), '')
lvs_value3 		= gf_Coalesce(pds.GetItemString(pl_Linha, "value3"), '')
lvs_stgrp 		= gf_Coalesce(pds.GetItemString(pl_Linha, "stgrp"), '')
lvdh_validfrom = pds.GetItemDateTime(pl_Linha, "validfrom")

// Ignorar registros inv$$HEX1$$e100$$ENDHEX$$lidos
If lvs_land1 = '' Or lvs_shipfrom = '' Or lvs_shipto = '' Or lvs_gruop = '' Or isNull(lvdh_validfrom) Then
	ivl_Invalidos[UpperBound(ivl_Invalidos)+1] = pl_Linha
	Return True
End If

// Tratar chaves dos grupos
// Obrigat$$HEX1$$f300$$ENDHEX$$rio ter o campo com 18 caracteres nos casos abaixo
// Inserindo zeros $$HEX1$$e000$$ENDHEX$$ esquerda quando necess$$HEX1$$e100$$ENDHEX$$rio
Choose Case lvs_gruop
	Case '10', '11', '23', '49'
		of_Ajusta_Zeros_Esquerda(Ref lvs_value)
		
	Case '14', '27', '29'
		of_Ajusta_Zeros_Esquerda(Ref lvs_value2)
	
//	Case ''
//		of_Ajusta_Zeros_Esquerda(Ref lvs_value3)
		
End Choose

// Dados
lvdh_validto 	= pds.GetItemDateTime(pl_Linha, "validto")
lvs_sur_type 	= pds.GetItemString(pl_Linha, "sur_type")
lvdc_rate 		= pds.GetItemNumber(pl_Linha, "rate")
lvdc_price 		= pds.GetItemNumber(pl_Linha, "price")
lvdc_factor 	= pds.GetItemNumber(pl_Linha, "factor")
lvs_unit 		= pds.GetItemString(pl_Linha, "unit")
lvdc_basered1 	= pds.GetItemNumber(pl_Linha, "basered1")
lvdc_basered2 	= pds.GetItemNumber(pl_Linha, "basered2")
lvdc_icmsbaser = pds.GetItemNumber(pl_Linha, "icmsbaser")
lvdc_minprice 	= pds.GetItemNumber(pl_Linha, "minprice")
lvs_waers 		= pds.GetItemString(pl_Linha, "waers")
lvdc_minfact 	= pds.GetItemNumber(pl_Linha, "minfact")
lvs_surchin 	= pds.GetItemString(pl_Linha, "surchin")
lvdc_fcp_basered1	= pds.GetItemNumber(pl_Linha, "fcp_basered1")
lvdc_fcp_basered2	= pds.GetItemNumber(pl_Linha, "fcp_basered2")

If Not of_j_1btxst3_verifica(	lvs_cd_ambiente, &
											lvs_mandt, &
											lvs_land1, &
											lvs_shipfrom, &
											lvs_shipto, &
											lvs_gruop, &
											lvs_value, &
											lvs_value2, &
											lvs_value3, &
											lvs_stgrp, &
											lvdh_validfrom, &
											ref lvb_Existe, &
											ref ps_Msg) Then Return False
											
If Not lvb_Existe Then
	ivl_Inserts ++
	Insert Into j_1btxst3 (	cd_ambiente,
									mandt,
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
									de_chave_sap,
									nr_controle_interface_sap)
	Values(	:lvs_cd_ambiente,
				:lvs_mandt,
				:lvs_land1,
				:lvs_shipfrom,
				:lvs_shipto,
				:lvs_gruop,
				:lvs_value,
				:lvs_value2,
				:lvs_value3,
				:lvs_stgrp,
				:lvdh_validfrom,
				:lvdh_validto,
				:lvs_sur_type,
				:lvdc_rate,
				:lvdc_price,
				:lvdc_factor,
				:lvs_unit,
				:lvdc_basered1,
				:lvdc_basered2,
				:lvdc_icmsbaser,
				:lvdc_minprice,
				:lvs_waers,
				:lvdc_minfact,
				:lvs_surchin,
				:lvdc_fcp_basered1,
				:lvdc_fcp_basered2,
				GetDate(),
				GetDate(),
				'CARGA',
				NULL)
	Using itr_Trans;
Else
	ivl_Updates ++
	
	Update j_1btxst3
	Set 	validto 		= :lvdh_validto,
			sur_type 	= :lvs_sur_type,
			rate 			= :lvdc_rate,
			price 		= :lvdc_price,
			factor 		= :lvdc_factor,
			unit 			= :lvs_unit,
			basered1 	= :lvdc_basered1,
			basered2 	= :lvdc_basered2,
			icmsbaser 	= :lvdc_icmsbaser,
			minprice 	= :lvdc_minprice,
			waers 		= :lvs_waers,
			minfact 		= :lvdc_minfact,
			surchin 		= :lvs_surchin,
			fcp_basered1 	= :lvdc_fcp_basered1,
			fcp_basered2 	= :lvdc_fcp_basered2,
			dh_inclusao 	= dh_inclusao,
			dh_alteracao 	= GetDate(),
			de_chave_sap	= 'CARGA',
			nr_controle_interface_sap = NULL
	Where
		cd_ambiente	= :lvs_cd_ambiente
		and mandt	= :lvs_mandt
		and land1	= :lvs_land1
		and shipfrom = :lvs_shipfrom
		and shipto	= :lvs_shipto
		and gruop	= :lvs_gruop
		and value	= :lvs_value
		and value2	= :lvs_value2
		and value3	= :lvs_value3
		and stgrp	= :lvs_stgrp
		and validfrom = :lvdh_validfrom
	Using itr_Trans;
End If

Choose Case itr_Trans.SqlCode
	Case is < 0
		ps_Msg = "Erro ao "+iif(lvb_Existe, "atualizar", "inserir")+" os dados na tabela 'j_1btxst3'.~r~r"+itr_Trans.SqlErrText
		Return False
End Choose

Return True
end function

public function boolean of_j_1btxst3_verifica (string ps_cd_ambiente, string ps_mandt, string ps_land1, string ps_shipfrom, string ps_shipto, string ps_gruop, string ps_value, string ps_value2, string ps_value3, string ps_stgrp, datetime pdh_validfrom, ref boolean pb_existe, ref string ps_msg);Long lvl_Count

Select Count(*)
Into :lvl_Count
From	j_1btxst3
Where	
	cd_ambiente		= :ps_cd_ambiente
	and mandt		= :ps_mandt
	and land1		= :ps_land1
	and shipfrom	= :ps_shipfrom
	and shipto 		= :ps_shipto
	and gruop		= :ps_gruop
	and value		= :ps_value
	and value2		= :ps_value2
	and value3		= :ps_value3
	and stgrp		= :ps_stgrp
	and validfrom	= :pdh_validfrom
Using itr_Trans;

Choose Case itr_Trans.SqlCode
	Case is < 0
		ps_Msg = "Erro ao verificar os dados da tabela 'j_1btxst3'.~r~r"+itr_Trans.SqlErrText
		Return False
End Choose

pb_Existe = (lvl_Count > 0)

Return True
end function

public subroutine _documentacao ();/*

Para importar uma tabela nova seguir estes passos:

1. ds_ge589_selecao: adicionar a tabela no dropdown


2. Criar uma ds_ge589_X_XXXXXXX onde X_XXXXXXX $$HEX1$$e900$$ENDHEX$$ o nome da tabela
	2.1. Colunas: todas as colunas da tabela, exceto estas (cd_ambiente, mandt, dh_inclusao e dh_alteracao)


3. Duplicar uma das fun$$HEX2$$e700f500$$ENDHEX$$es of_X_XXXXXXX_importa para outra tabela e alterar:
	3.1. Apagar todas vari$$HEX1$$e100$$ENDHEX$$veis exceto lvs_cd_ambiente e lvs_mandt
	3.2. Criar novas vari$$HEX1$$e100$$ENDHEX$$veis com os nomes das colunas e tipos da datastore criada, na mesma ordem para facilitar.
		3.2.1. Aten$$HEX2$$e700e300$$ENDHEX$$o para a quantidade de casas decimais que a coluna do banco aceita.
		3.2.2. Declarar "Decimal{2} lvdc_variavel" para 2 casas decimais.

	Dica: Ctrl+C no DBeaver


3.3. Recriar os GetItem com seus nomes de campos e tipos. (GetItemString, GetItemNumber, GetItemDateTime)

3.4. Duplicar uma das fun$$HEX2$$e700f500$$ENDHEX$$es of_X_XXXXXXX_verifica e alterar os par$$HEX1$$e200$$ENDHEX$$metros e o SELECT, conforme a chave prim$$HEX1$$e100$$ENDHEX$$ria da tabela.

3.5. Recriar o INSERT

3.6. Recriar o UPDATE

3.7. Alterar o nome da tabela na mensagem de erro

4. Adicionar a chamada da nova of_X_XXXXXXX_importa no Choose Case da fun$$HEX2$$e700e300$$ENDHEX$$o of_importa_arquivo.

*/
end subroutine

public function boolean of_j_1btxip3_importa (string ps_cd_ambiente, long pl_linha, dc_uo_ds_base pds, ref string ps_msg);Boolean lvb_Existe

// Chave
String lvs_cd_ambiente 
String lvs_mandt
String lvs_gruop
String lvs_value
String lvs_value2
String lvs_value3
DateTime lvdh_validfrom

// Dados
Decimal{2} lvdc_rate
Decimal{2} lvdc_base
String lvs_exempt
String lvs_taxlaw
Decimal{2} lvdc_amount
Decimal{2} lvdc_factor
String lvs_unit
String lvs_waers
Decimal{2} lvdc_minprice_amount
String lvs_minprice_currency
Decimal{3} lvdc_minprice_quantity
String lvs_minprice_uom

// Chave
lvs_cd_ambiente = ps_cd_ambiente
lvs_mandt 		 = '500'

lvs_gruop 		= gf_Coalesce(pds.GetItemString(pl_Linha, "gruop"), '')
lvs_value 		= gf_Coalesce(pds.GetItemString(pl_Linha, "value"), '')
lvs_value2 		= gf_Coalesce(pds.GetItemString(pl_Linha, "value2"), '')
lvs_value3 		= gf_Coalesce(pds.GetItemString(pl_Linha, "value3"), '')
lvdh_validfrom = pds.GetItemDateTime(pl_Linha, "validfrom")

// Ignorar registros inv$$HEX1$$e100$$ENDHEX$$lidos
If lvs_gruop = '' Or isNull(lvdh_validfrom) Then
	ivl_Invalidos[UpperBound(ivl_Invalidos)+1] = pl_Linha
	Return True
End If

// Tratar chaves dos grupos
// Obrigat$$HEX1$$f300$$ENDHEX$$rio ter o campo com 18 caracteres nos casos abaixo
// Inserindo zeros $$HEX1$$e000$$ENDHEX$$ esquerda quando necess$$HEX1$$e100$$ENDHEX$$rio
Choose Case lvs_gruop
	Case '49'
		of_Ajusta_Zeros_Esquerda(Ref lvs_value)
		
	Case '14'
		of_Ajusta_Zeros_Esquerda(Ref lvs_value2)
	
//	Case ''
//		of_Ajusta_Zeros_Esquerda(Ref lvs_value3)
		
End Choose

// Dados
lvdc_rate 					= pds.GetItemNumber(pl_Linha, "rate")
lvdc_base 					= pds.GetItemNumber(pl_Linha, "base")
lvs_exempt 					= pds.GetItemString(pl_Linha, "exempt")
lvs_taxlaw 					= pds.GetItemString(pl_Linha, "taxlaw")
lvdc_amount 				= pds.GetItemNumber(pl_Linha, "amount")
lvdc_factor 				= pds.GetItemNumber(pl_Linha, "factor")
lvs_unit 					= pds.GetItemString(pl_Linha, "unit")
lvs_waers 					= pds.GetItemString(pl_Linha, "waers")
lvdc_minprice_amount 	= pds.GetItemNumber(pl_Linha, "minprice_amount")
lvs_minprice_currency 	= pds.GetItemString(pl_Linha, "minprice_currency")
lvdc_minprice_quantity 	= pds.GetItemNumber(pl_Linha, "minprice_quantity")
lvs_minprice_uom 			= pds.GetItemString(pl_Linha, "minprice_uom")

If Not of_j_1btxip3_verifica(	lvs_cd_ambiente, &
											lvs_mandt, &
											lvs_gruop, &
											lvs_value, &
											lvs_value2, &
											lvs_value3, &
											lvdh_validfrom, &
											ref lvb_Existe, &
											ref ps_Msg) Then Return False
											
If Not lvb_Existe Then
	ivl_Inserts ++
	Insert Into j_1btxip3 (	cd_ambiente,
									mandt,
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
									nr_controle_interface_sap)
	Values(	:lvs_cd_ambiente,
				:lvs_mandt,
				:lvs_gruop,
				:lvs_value,
				:lvs_value2,
				:lvs_value3,
				:lvdh_validfrom,
				:lvdc_rate,
				:lvdc_base,
				:lvs_exempt,
				:lvs_taxlaw,
				:lvdc_amount,
				:lvdc_factor,
				:lvs_unit,
				:lvs_waers,
				:lvdc_minprice_amount,
				:lvs_minprice_currency,
				:lvdc_minprice_quantity,
				:lvs_minprice_uom,
				GetDate(),
				GetDate(),
				NULL)
	Using itr_Trans;
Else
	ivl_Updates ++
	
	Update j_1btxip3
	Set 	rate	= :lvdc_rate,
			base	= :lvdc_base,
			exempt	= :lvs_exempt,
			taxlaw	= :lvs_taxlaw,
			amount	= :lvdc_amount,
			factor	= :lvdc_factor,
			unit	= :lvs_unit,
			waers	= :lvs_waers,
			minprice_amount	= :lvdc_minprice_amount,
			minprice_currency	= :lvs_minprice_currency,
			minprice_quantity	= :lvdc_minprice_quantity,
			minprice_uom	= :lvs_minprice_uom,
			dh_inclusao 	= dh_inclusao,
			dh_alteracao 	= GetDate(),
			nr_controle_interface_sap = NULL
	Where
			cd_ambiente	= :lvs_cd_ambiente
			and mandt	= :lvs_mandt
			and gruop	= :lvs_gruop
			and value	= :lvs_value
			and value2	= :lvs_value2
			and value3	= :lvs_value3
			and validfrom	= :lvdh_validfrom
	Using itr_Trans;
End If

Choose Case itr_Trans.SqlCode
	Case is < 0
		ps_Msg = "Erro ao "+iif(lvb_Existe, "atualizar", "inserir")+" os dados na tabela 'j_1btxip3'.~r~r"+itr_Trans.SqlErrText
		Return False
End Choose

Return True
end function

public function boolean of_j_1btxip3_verifica (string ps_cd_ambiente, string ps_mandt, string ps_gruop, string ps_value, string ps_value2, string ps_value3, datetime pdh_validfrom, ref boolean pb_existe, ref string ps_msg);Long lvl_Count

Select Count(*)
Into :lvl_Count
From	j_1btxip3
Where	
	cd_ambiente		= :ps_cd_ambiente
	and mandt		= :ps_mandt
	and gruop		= :ps_gruop
	and value		= :ps_value
	and value2		= :ps_value2
	and value3		= :ps_value3
	and validfrom	= :pdh_validfrom
Using itr_Trans;

Choose Case itr_Trans.SqlCode
	Case is < 0
		ps_Msg = "Erro ao verificar os dados da tabela 'j_1btxip3'.~r~r"+itr_Trans.SqlErrText
		Return False
End Choose

pb_Existe = (lvl_Count > 0)

Return True
end function

public function boolean of_j_1btxic3_importa (string ps_cd_ambiente, long pl_linha, dc_uo_ds_base pds, ref string ps_msg);Long lvl_Tamanho
Boolean lvb_Existe

// Chave
String lvs_cd_ambiente 
String lvs_mandt
String lvs_land1
String lvs_shipfrom
String lvs_shipto
String lvs_gruop
String lvs_value
String lvs_value2
String lvs_value3
DateTime lvdh_validfrom

// Dados
DateTime lvdh_validto
Decimal{2} lvdc_rate
Decimal{2} lvdc_base
String lvs_exempt
String lvs_taxlaw
String lvs_conven100
Decimal{2} lvdc_specf_rate
Decimal{2} lvdc_specf_base
String lvs_partilha_exempt
String lvs_specf_resale

// Chave
lvs_cd_ambiente = ps_cd_ambiente
lvs_mandt 		 = '500'

lvs_land1 		= gf_Coalesce(pds.GetItemString(pl_Linha, "land1"), '')
lvs_shipfrom	= gf_Coalesce(pds.GetItemString(pl_Linha, "shipfrom"), '')
lvs_shipto 		= gf_Coalesce(pds.GetItemString(pl_Linha, "shipto"), '')
lvs_gruop 		= gf_Coalesce(pds.GetItemString(pl_Linha, "gruop"), '')
lvs_value 		= gf_Coalesce(pds.GetItemString(pl_Linha, "value"), '')
lvs_value2 		= gf_Coalesce(pds.GetItemString(pl_Linha, "value2"), '')
lvs_value3 		= gf_Coalesce(pds.GetItemString(pl_Linha, "value3"), '')
lvdh_validfrom = pds.GetItemDateTime(pl_Linha, "validfrom")

// Ignorar registros inv$$HEX1$$e100$$ENDHEX$$lidos
If lvs_land1 = '' Or lvs_shipfrom = '' Or lvs_shipto = '' Or lvs_gruop = '' Or isNull(lvdh_validfrom) Then
	ivl_Invalidos[UpperBound(ivl_Invalidos)+1] = pl_Linha
	Return True
End If

// Tratar chaves dos grupos
// Obrigat$$HEX1$$f300$$ENDHEX$$rio ter o campo com 18 caracteres nos casos abaixo
// Inserindo zeros $$HEX1$$e000$$ENDHEX$$ esquerda quando necess$$HEX1$$e100$$ENDHEX$$rio
Choose Case lvs_gruop
	Case '11', '23', '49', '65'
		of_Ajusta_Zeros_Esquerda(Ref lvs_value)
		
	Case '12', '14', '27', '29'
		of_Ajusta_Zeros_Esquerda(Ref lvs_value2)
	
	Case '24', '25'
		of_Ajusta_Zeros_Esquerda(Ref lvs_value3)
		
End Choose

// Defensiva (pode haver esses dados errados no SAP)
if lvs_gruop='65' then
	If Trim(lvs_value2) = 'X' Then lvs_value2 = ''
	If Trim(lvs_value3) = 'X' Then lvs_value3 = ''
end if

// Dados
lvdh_validto 			= pds.GetItemDateTime(pl_Linha, "validto")
lvdc_rate 				= pds.GetItemNumber(pl_Linha, "rate")
lvdc_base 				= pds.GetItemNumber(pl_Linha, "base")
lvs_exempt 				= pds.GetItemString(pl_Linha, "exempt")
lvs_taxlaw 				= pds.GetItemString(pl_Linha, "taxlaw")
lvs_conven100 			= pds.GetItemString(pl_Linha, "conven100")
lvdc_specf_rate 		= pds.GetItemNumber(pl_Linha, "specf_rate")
lvdc_specf_base 		= pds.GetItemNumber(pl_Linha, "specf_base")
lvs_partilha_exempt	= pds.GetItemString(pl_Linha, "partilha_exempt")
lvs_specf_resale 		= pds.GetItemString(pl_Linha, "specf_resale")

If Not of_j_1btxic3_verifica(	lvs_cd_ambiente, &
											lvs_mandt, &
											lvs_land1, &
											lvs_shipfrom, &
											lvs_shipto, &
											lvs_gruop, &
											lvs_value, &
											lvs_value2, &
											lvs_value3, &
											lvdh_validfrom, &
											ref lvb_Existe, &
											ref ps_Msg) Then Return False
											
If Not lvb_Existe Then
	ivl_Inserts ++
	Insert Into j_1btxic3 (	cd_ambiente,
									mandt,
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
									de_chave_sap,
									nr_controle_interface_sap)
	Values(	:lvs_cd_ambiente,
				:lvs_mandt,
				:lvs_land1,
				:lvs_shipfrom,
				:lvs_shipto,
				:lvs_gruop,
				:lvs_value,
				:lvs_value2,
				:lvs_value3,
				:lvdh_validfrom,
				:lvdh_validto,
				:lvdc_rate,
				:lvdc_base,
				:lvs_exempt,
				:lvs_taxlaw,
				:lvs_conven100,
				:lvdc_specf_rate,
				:lvdc_specf_base,
				:lvs_partilha_exempt,
				:lvs_specf_resale,
				GetDate(),
				GetDate(),
				'CARGA',
				NULL)
	Using itr_Trans;
Else
	ivl_Updates ++
	
	Update j_1btxic3
	Set 	validto 			= :lvdh_validto,
			rate 				= :lvdc_rate,
			base 				= :lvdc_base,
			exempt 			= :lvs_exempt,
			taxlaw 			= :lvs_taxlaw,
			conven100 		= :lvs_conven100,
			specf_rate 		= :lvdc_specf_rate,
			specf_base 		= :lvdc_specf_base,
			partilha_exempt = :lvs_partilha_exempt,
			specf_resale 	= :lvs_specf_resale,
			dh_inclusao 	= dh_inclusao,
			dh_alteracao 	= GetDate(),
			de_chave_sap	= 'CARGA',
			nr_controle_interface_sap = NULL
	Where
		cd_ambiente	= :lvs_cd_ambiente
		and mandt	= :lvs_mandt
		and land1	= :lvs_land1
		and shipfrom = :lvs_shipfrom
		and shipto	= :lvs_shipto
		and gruop	= :lvs_gruop
		and value	= :lvs_value
		and value2	= :lvs_value2
		and value3	= :lvs_value3
		and validfrom = :lvdh_validfrom
	Using itr_Trans;
End If

Choose Case itr_Trans.SqlCode
	Case is < 0
		ps_Msg = "Erro ao "+iif(lvb_Existe, "atualizar", "inserir")+" os dados na tabela 'j_1btxic3'.~r~r"+itr_Trans.SqlErrText
		Return False
End Choose

Return True
end function

public function boolean of_j_1btxic3_verifica (string ps_cd_ambiente, string ps_mandt, string ps_land1, string ps_shipfrom, string ps_shipto, string ps_gruop, string ps_value, string ps_value2, string ps_value3, datetime pdh_validfrom, ref boolean pb_existe, ref string ps_msg);Long lvl_Count

Select Count(*)
Into :lvl_Count
From	j_1btxic3
Where	
	cd_ambiente		= :ps_cd_ambiente
	and mandt		= :ps_mandt
	and land1		= :ps_land1
	and shipfrom	= :ps_shipfrom
	and shipto 		= :ps_shipto
	and gruop		= :ps_gruop
	and value		= :ps_value
	and value2		= :ps_value2
	and value3		= :ps_value3
	and validfrom	= :pdh_validfrom
Using itr_Trans;

Choose Case itr_Trans.SqlCode
	Case is < 0
		ps_Msg = "Erro ao verificar os dados da tabela 'j_1btxic3'.~r~r"+itr_Trans.SqlErrText
		Return False
End Choose

pb_Existe = (lvl_Count > 0)

Return True
end function

public subroutine of_ajusta_zeros_esquerda (ref string ps_value);Long lvl_Tamanho

lvl_Tamanho = Len(ps_value)
If lvl_Tamanho < 18 Then
	ps_value = Fill('0', (18 - lvl_Tamanho)) + ps_value
End If
end subroutine

on uo_ge589_importacao_j1btax.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge589_importacao_j1btax.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;itr_Trans = SQLCA
end event

