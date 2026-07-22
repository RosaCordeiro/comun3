HA$PBExportHeader$w_ge474_integracao_telefone.srw
forward
global type w_ge474_integracao_telefone from dc_w_selecao_lista_relatorio
end type
type cb_gerar_arquivo from commandbutton within w_ge474_integracao_telefone
end type
end forward

global type w_ge474_integracao_telefone from dc_w_selecao_lista_relatorio
integer width = 2437
integer height = 1908
string title = "GE474 - Integra$$HEX2$$e700e300$$ENDHEX$$o - Telefone"
cb_gerar_arquivo cb_gerar_arquivo
end type
global w_ge474_integracao_telefone w_ge474_integracao_telefone

type variables
uo_centro_custo ivo_centro_custo
uo_ge253_mult ivo_mult

String ivs_Conta_Gerencial

Long ivl_Filial
end variables

forward prototypes
public subroutine wf_localiza_centro_custo ()
public subroutine wf_atualiza_linha (integer ai_linha_find, string as_tipo_servico, decimal ad_vlr_servico)
public function boolean wf_verifica_totais_matriz (long pl_centro_custo, ref decimal pdc_total)
public function boolean wf_formata_telefones (long pl_centro_custo, ref string ps_telefones)
public function boolean wf_verifica_linha (string as_dd_atual, string as_telefone_atual, string as_tipo_servico, decimal ad_vlr_servico, long ai_centro_custo_atual, string as_de_centro_custo, long as_filial, string as_conta_contabil, string as_conta_credito, string as_centro_contabil)
public subroutine wf_inserir_linha (integer ai_linha_find, long ai_centro_custo_atual, string as_de_centro_custo, long as_filial, string as_conta_contabil, string as_conta_credito, string as_centro_contabil, string as_dd_atual, string as_telefone_atual, string as_tipo_servico, decimal ad_vlr_servico)
public function boolean wf_verifica_conta_gerencial (long al_filial)
end prototypes

public subroutine wf_localiza_centro_custo ();String lvs_Centro_Custo

// Verifica o par$$HEX1$$e200$$ENDHEX$$metro digitado pelo usu$$HEX1$$e100$$ENDHEX$$rio

lvs_Centro_Custo = dw_1.GetText()
	
ivo_Centro_Custo.of_Localiza_Centro_Custo(lvs_Centro_Custo)

// Verifica se a Filial foi localizada e atualiza a DW
If ivo_Centro_Custo.Localizada Then
	dw_1.Object.Cd_Centro_Custo[1] = ivo_Centro_Custo.Cd_Centro_Custo
  	dw_1.Object.De_Centro_Custo[1] = ivo_Centro_Custo.De_Centro_Custo
Else
	SetNull(ivo_Centro_Custo.Cd_Centro_Custo)
	ivo_Centro_Custo.de_Centro_Custo = ""
	
	dw_1.Object.Cd_Centro_Custo[1] = ivo_Centro_Custo.Cd_Centro_Custo
  	dw_1.Object.De_Centro_Custo[1] = ivo_Centro_Custo.De_Centro_Custo
End If

end subroutine

public subroutine wf_atualiza_linha (integer ai_linha_find, string as_tipo_servico, decimal ad_vlr_servico);// Atualiza a dw_2 conforme parametro (F-Fixo,C-Celular,S-Servico e D-Desconto).				
If as_tipo_servico = "F" Then
	dw_2.Object.vl_fixo[ai_linha_find] = ad_vlr_servico
Else 
	If as_tipo_servico = "C" Then
	   dw_2.Object.vl_celular[ai_linha_find] = ad_vlr_servico
	Else 
	   If as_tipo_servico = "S" Then
		   dw_2.Object.vl_servico[ai_linha_find] = ad_vlr_servico
		Else
		   If as_tipo_servico = "D" Then
		   	dw_2.Object.vl_desconto[ai_linha_find] = ad_vlr_servico
			End If
		End If
	End If
End If
end subroutine

public function boolean wf_verifica_totais_matriz (long pl_centro_custo, ref decimal pdc_total);Long lvl_Row, &
     lvl_Filial, &
	  lvl_Centro_Custo
	  
String lvs_Conta_Gerencial, &
       lvs_Conta_Gerencial_Aux

Decimal{2} lvdc_Valor

For lvl_Row = 1 To dw_2.RowCount()
	
	lvl_Filial 			  = dw_2.Object.Cd_Filial[lvl_Row]
	lvl_Centro_Custo    = dw_2.Object.Cd_Centro_Custo[lvl_Row]
	lvs_Conta_Gerencial = dw_2.Object.Cd_Centro_Contabil[lvl_Row]
	
	If lvl_Centro_Custo = pl_Centro_Custo Then
		If Not IsNull(lvs_Conta_Gerencial) or lvs_Conta_Gerencial = "" Then
			
			If lvs_Conta_Gerencial_Aux <> lvs_Conta_Gerencial Then
				lvdc_Valor  = dw_2.Object.Total_Geral[lvl_Row]
				pdc_Total += lvdc_Valor
				
				lvs_Conta_Gerencial_Aux = lvs_Conta_Gerencial
			End If
		End If
	End If
Next

Return True
end function

public function boolean wf_formata_telefones (long pl_centro_custo, ref string ps_telefones);Long lvl_Cont = 1, &
	  lvl_Find
	  
String lvs_Nr_DDD, &
       lvs_Telefone

ps_Telefones = "( "

lvl_Find = dw_2.Find("cd_centro_custo = " + String(pl_Centro_Custo), 1, dw_2.RowCount())

Do While lvl_Find > 0

	If lvl_Cont > 1 Then ps_Telefones += " / "
	
	lvs_Nr_DDD   = dw_2.Object.Nr_DDD[lvl_Find]
	lvs_Telefone = dw_2.Object.Nr_Telefone[lvl_Find]
	
	ps_Telefones += lvs_Nr_DDD + "-" + lvs_Telefone
	
	lvl_Cont ++
	
	If lvl_Find + 1 > dw_2.RowCount() Then Exit
	
	lvl_Find = dw_2.Find("cd_centro_custo = " + String(pl_Centro_Custo), lvl_Find + 1, dw_2.RowCount())
		
Loop

ps_Telefones += ")"

Return True
end function

public function boolean wf_verifica_linha (string as_dd_atual, string as_telefone_atual, string as_tipo_servico, decimal ad_vlr_servico, long ai_centro_custo_atual, string as_de_centro_custo, long as_filial, string as_conta_contabil, string as_conta_credito, string as_centro_contabil);Boolean lvb_Retorno = True

Long lvl_Tot_Linha,&
	  lvl_Linha

Integer lvi_Find
 
 
lvl_tot_linha = dw_2.RowCount()
		 
lvi_Find = dw_2.Find("cd_centro_custo ="+string(ai_centro_custo_atual) +&
  						   " and nr_ddd ='"+as_dd_atual + "'"+&
							" and nr_telefone ='"+as_telefone_atual+"'",1,lvl_tot_linha )
		 
If lvi_Find > 0 Then
	//Esta funcao vai atualizar as linhas da dw.
	wf_Atualiza_Linha(lvi_Find, as_tipo_servico, ad_vlr_servico)
   
End If
		 
If lvi_Find = 0 Then
	//Esta funcao vai inserir as linhas na dw.
	wf_Inserir_Linha(lvi_Find, ai_centro_custo_atual, as_de_centro_custo,&
						  as_filial, as_conta_contabil, as_conta_credito, as_centro_contabil,&
						  as_dd_atual, as_telefone_atual, as_tipo_servico, ad_vlr_servico )
End If
		 
If lvi_Find < 0 Then lvb_Retorno = False
			
		 	 
Return lvb_Retorno 		
end function

public subroutine wf_inserir_linha (integer ai_linha_find, long ai_centro_custo_atual, string as_de_centro_custo, long as_filial, string as_conta_contabil, string as_conta_credito, string as_centro_contabil, string as_dd_atual, string as_telefone_atual, string as_tipo_servico, decimal ad_vlr_servico);Long lvl_linha

lvl_linha = dw_2.InsertRow(0)

If ai_centro_custo_atual = 534896 Then
	as_filial = 100
End If			
			
dw_2.Object.cd_centro_custo		[lvl_linha] = ai_centro_custo_atual
dw_2.Object.de_centro_custo		[lvl_linha] = as_de_centro_custo
dw_2.Object.cd_filial					[lvl_linha] = as_filial
dw_2.Object.cd_conta_contabil		[lvl_linha] = as_conta_contabil
dw_2.Object.cd_centro_contabil	[lvl_linha] = as_centro_contabil
dw_2.Object.cd_conta_credito		[lvl_linha] = as_conta_credito
dw_2.Object.nr_ddd					[lvl_linha] = as_dd_atual
dw_2.Object.nr_telefone				[lvl_linha] = as_telefone_atual
				 
// Atualiza a dw_2 conforme parametro (F-Fixo,C-Celular,S-Servico e D-Desconto).				 
If as_tipo_servico = "F" Then
	dw_2.Object.vl_fixo[lvl_Linha] = ad_vlr_servico
Else
	If as_tipo_servico = "C" Then
     	dw_2.Object.vl_celular[lvl_Linha] = ad_vlr_servico
	Else
		If as_tipo_servico = "S" Then
			dw_2.Object.vl_servico[lvl_Linha] = ad_vlr_servico
		Else
			If as_tipo_servico = "D" Then
				dw_2.Object.vl_desconto[lvl_Linha] = ad_vlr_servico
			End If
		End If
	End If
End If 

//Caso algum campo for null substitui por 0.
If IsNull(dw_2.Object.vl_fixo[lvl_linha]) Then
   dw_2.Object.vl_fixo[lvl_linha] = 0.00
End If
					
If IsNull(dw_2.Object.vl_celular[lvl_linha]) Then
   dw_2.Object.vl_celular[lvl_linha] = 0.00
End If
					
If IsNull(dw_2.Object.vl_servico[lvl_linha]) Then
   dw_2.Object.vl_servico[lvl_linha] = 0.00
End If
					
If IsNull(dw_2.Object.vl_desconto[lvl_linha]) Then
   dw_2.Object.vl_desconto[lvl_linha] = 0.00
End If	
end subroutine

public function boolean wf_verifica_conta_gerencial (long al_filial);Boolean lvb_Alterado = False

Choose Case al_Filial
	//--------------------------------------------Manipulacao---------------------------------
	Case 688
		//ivl_Filial = 534
		//ivs_Conta_Gerencial = "3534"
		ivl_Filial = 534
		ivs_Conta_Gerencial = "3534"
		lvb_Alterado =	True
//	Case 723
//		ivl_Filial = 534
//		ivs_Conta_Gerencial = "3723"
//		lvb_Alterado =	True
//	Case 786
//		ivl_Filial = 534
//		ivs_Conta_Gerencial = "3786"
//		lvb_Alterado =	True
	//-----------------------------------------------Disk Entrega------------------------------	
	Case 695 	//JOINVILLE_DE
		ivl_Filial = 149
		ivs_Conta_Gerencial = "1149"
		lvb_Alterado =	True
	Case 696		//JARAGUA_DE
		ivl_Filial = 84
		ivs_Conta_Gerencial = "1084"
		lvb_Alterado =	True
	Case 700		//BLUMENAU_DE
		ivl_Filial = 136
		ivs_Conta_Gerencial = "1136"
		lvb_Alterado =	True
	Case 701		//CRICIUMA_DE
		ivl_Filial = 107
		ivs_Conta_Gerencial = "1107"
		lvb_Alterado =	True
	Case 704		//ITAJAI_DE
		ivl_Filial = 71
		ivs_Conta_Gerencial = "1071"
		lvb_Alterado =	True
	Case 705 	//LAGES_DE
		ivl_Filial = 42
		ivs_Conta_Gerencial = "1042"
		lvb_Alterado =	True
	Case 708 	//TUBAR$$HEX1$$c300$$ENDHEX$$O_DE
		ivl_Filial = 550
		ivs_Conta_Gerencial = "1550"
		lvb_Alterado =	True
	Case	709	//BALNEARIO CAMBORIU_DE					
		ivl_Filial = 592
		ivs_Conta_Gerencial = "1592"
		lvb_Alterado =	True
	Case 712	  	//CHAPECO_DE
		ivl_Filial = 39
		ivs_Conta_Gerencial = "1039"
		lvb_Alterado =	True
	Case 733	 	//GASPAR_DE
		ivl_Filial = 330
		ivs_Conta_Gerencial = "1330"
		lvb_Alterado =	True
	Case 699		//DE_FLORIPA
		ivl_Filial = 301
		ivs_Conta_Gerencial = "1301"			
		lvb_Alterado =	True
End Choose


Return lvb_Alterado

end function

on w_ge474_integracao_telefone.create
int iCurrent
call super::create
this.cb_gerar_arquivo=create cb_gerar_arquivo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_gerar_arquivo
end on

on w_ge474_integracao_telefone.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_gerar_arquivo)
end on

event ue_postopen;call super::ue_postopen;This.ivm_Menu.ivb_Permite_Imprimir = True

DateTime lvdt_Movimento

If Not gf_Data_Parametro(Ref lvdt_Movimento) Then Return

lvdt_Movimento = DateTime(gf_Primeiro_Dia_Mes(Date(lvdt_Movimento)))

dw_1.Object.Dt_Vencimento[1] = Date(lvdt_Movimento)




end event

event close;call super::close;// Destroi o objeto criado.
Destroy(ivo_centro_custo)
Destroy(ivo_mult)
end event

event ue_saveas;dw_3.Event ue_SaveAs()
end event

event ue_preopen;call super::ue_preopen;ivo_mult = Create uo_ge253_mult
ivo_Centro_Custo  = Create uo_Centro_Custo
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge474_integracao_telefone
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge474_integracao_telefone
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge474_integracao_telefone
integer x = 18
integer y = 256
integer width = 2345
integer height = 1452
integer weight = 700
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge474_integracao_telefone
integer x = 18
integer y = 0
integer width = 1586
integer height = 244
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge474_integracao_telefone
integer x = 37
integer y = 52
integer width = 1527
integer height = 184
string dataobject = "dw_ge474_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;Long lvl_nulo

SetNull(lvl_Nulo)

Choose Case dwo.Name 
	Case "de_centro_custo"
	
		SetNull(lvl_Nulo)
	
		If Data = "" Or IsNull(Data) Then
			This.Object.Cd_Centro_Custo[1] = lvl_nulo
			Return 0
		End If	
		
		If Data <> ivo_Centro_Custo.De_Centro_Custo Then Return 1
End Choose

cb_gerar_arquivo.Enabled = False
end event

event dw_1::ue_key;String lvs_Coluna

If Key = KeyEnter! Then
	
	lvs_Coluna = This.GetColumnName()
	
	If lvs_Coluna = 'de_centro_custo' Then
		
		wf_Localiza_Centro_Custo()
		
	End If
End If
end event

event dw_1::editchanged;call super::editchanged;Long lvl_nulo

SetNull(lvl_Nulo)

Choose Case dwo.Name 
	Case "de_centro_custo"
	
		SetNull(lvl_Nulo)
	
		If Data = "" Or IsNull(Data) Then
			This.Object.Cd_Centro_Custo[1] = lvl_nulo
			Return 0
		End If	
		
		If Data <> ivo_Centro_Custo.De_Centro_Custo Then Return 1
End Choose

cb_gerar_arquivo.Enabled = False
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge474_integracao_telefone
integer x = 46
integer y = 328
integer width = 2295
integer height = 1356
string dataobject = "dw_ge474_lista"
end type

event dw_2::ue_recuperar;//OverRide

Long lvl_Total, &
     lvl_Contador,&
     lvl_tot_linha,&
	  lvl_Filial, &
	  lvl_Centro_Custo_Atual,&
	  lvl_Cd_Centro_Custo
	  
String lvs_nr_DDD_Atual,&
		 lvs_nr_Telefone_Atual,&
		 lvs_Tipo_Servico,&
		 lvs_de_Centro_Custo,&
		 lvs_Conta_Contabil,&
		 lvs_Centro_Contabil, &
		 lvs_Conta_Credito

Date lvdt_vencimento

Decimal lvd_vlr_servico

dw_1.AcceptText()
lvdt_vencimento 		 = dw_1.Object.dt_vencimento		[1]
lvl_Cd_Centro_Custo   = dw_1.Object.cd_centro_custo	[1]

If IsNull(lvdt_Vencimento) or Not IsDate(String(lvdt_vencimento,"DD/MM/YYYY")) Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o.","Favor informar a data do vencimento corretamente.",Information!)
	dw_1.Event ue_Pos(1, "dt_vencimento")
	Return -1
End If 

dc_uo_ds_Base lvds_1
lvds_1 = Create dc_uo_ds_Base

If Not lvds_1.of_ChangeDataObject("ds_ge474_lista") Then 
	Destroy(lvds_1)
	Return -1
End If

dw_2.SetRedraw(False)

Open(w_Aguarde)

If Not IsNull(lvl_Cd_Centro_Custo) and lvl_Cd_Centro_Custo <> 0 Then
	lvds_1.of_AppendWhere("t.cd_centro_custo = " + String(lvl_Cd_Centro_Custo))
End If

lvl_Total = lvds_1.Retrieve(lvdt_vencimento)

If lvl_Total > 0 Then

	For lvl_Contador = 1 To lvl_Total
		
	    w_Aguarde.uo_Progress.of_SetMax(lvl_total)	
		 
		 lvs_nr_DDD_Atual			= lvds_1.Object.nr_ddd				[lvl_contador]
		 lvs_nr_telefone_atual	= lvds_1.Object.nr_telefone			[lvl_contador]
		 lvs_tipo_servico			= lvds_1.Object.id_tipo_servico		[lvl_contador]
		 lvd_vlr_servico				= lvds_1.Object.vl_total_servico	[lvl_contador]
		 lvl_Centro_Custo_Atual	= lvds_1.Object.cd_centro_custo	[lvl_contador]
		 lvs_de_Centro_custo		= lvds_1.Object.de_centro_custo	[lvl_contador]
		 lvl_Filial						= lvds_1.Object.cd_filial_debito		[lvl_contador]
		 lvs_Conta_Contabil		= lvds_1.Object.cd_conta_debito	[lvl_contador]
		 lvs_Conta_Credito			= lvds_1.Object.cd_conta_credito	[lvl_contador]
		 
		 
		 If lvl_Filial = 381 Then
			lvl_Filial = 381
		End If
		 
		 //Integracao Mult
		//Respeitar o campo CC debito parametrizado na configura$$HEX2$$e700e300$$ENDHEX$$o Contabiliza$$HEX2$$e700e300$$ENDHEX$$o - Marlon - 03/04/2013
		 //lvs_Centro_Contabil	= lvds_1.Object.cd_centro_credito_m3	[lvl_contador]
		 lvs_Centro_Contabil	= lvds_1.Object.cd_centro_debito	[lvl_contador]
		If IsNull(lvs_Centro_Contabil) Or Trim(lvs_Centro_Contabil) = "" Then lvs_Centro_Contabil = "999"

		 If Not wf_Verifica_Linha(lvs_nr_DDD_Atual,lvs_nr_Telefone_Atual,&
										  lvs_Tipo_Servico,lvd_Vlr_Servico,&
										  lvl_Centro_Custo_Atual,lvs_de_Centro_Custo,&
										  lvl_Filial, lvs_Conta_Contabil,&
										  lvs_Conta_Credito, &
										  lvs_Centro_Contabil) Then Return -1
		 
		 w_Aguarde.uo_Progress.of_SetProgress(lvl_Contador)
		 		 
	Next
	
	This.Sort()
   	This.GroupCalc( )
   	dw_2.SetRedraw(True)
End If

Destroy(lvds_1)
Close(w_Aguarde)

Return This.RowCount()
end event

event dw_2::constructor;call super::constructor;This.of_SetRowSelection("", "if(vlr_total_ligacoes < 0, 255, 0)")
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;//cb_Gerar_Arquivo.Enabled = (pl_Linhas > 0)
ivm_menu.mf_salvarcomo( pl_linhas > 0)

If pl_Linhas > 0 Then
	If gvo_aplicacao.ivo_seguranca.cd_sistema <> "CT" Then
		cb_gerar_arquivo.Enabled = False
	Else
		cb_gerar_arquivo.Enabled = True
	End If
End If

Return pl_Linhas
end event

event dw_2::ue_reset;call super::ue_reset;cb_Gerar_Arquivo.Enabled = (False)
ivm_menu.mf_salvarcomo(False)
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge474_integracao_telefone
integer x = 370
integer y = 1220
integer width = 539
integer height = 220
integer taborder = 60
string dataobject = "dw_ge474_relatorio"
end type

event dw_3::ue_preprint;call super::ue_preprint;String lvs_Vencimento
				  
lvs_Vencimento = MidA(String(dw_1.Object.dt_vencimento[1]),4,7)
dw_3.Object.st_vencimento.text = lvs_Vencimento

Return dw_3.RowCount()
end event

type cb_gerar_arquivo from commandbutton within w_ge474_integracao_telefone
integer x = 1874
integer y = 132
integer width = 494
integer height = 108
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "&Gerar Lote Mult"
end type

event clicked;Boolean lvb_Sucesso = True

String lvs_Telefones, &
		lvs_Conta_Contabil, &
		lvs_Conta_Credito, &
		lvs_Conta_Gerencial, &
		lvs_Conta_Gerencial_Aux, &
		lvs_Nm_Filial, &
		lvs_Natureza, &
		lvs_Id_Inf_Contabil, &
		lvs_Historico

Decimal{2} lvdc_Valor, &
           lvdc_Total,&
		   lvdc_Total_Geral

Long lvl_Total, &
     lvl_Contador, &
	  lvl_Filial, &
	  lvl_Centro_Custo, &
	  lvl_Centro_Custo_Grupo, &
	  lvl_Exportacao
	  
Date lvdh_Movimento

dw_1.AcceptText()

lvdh_Movimento = dw_1.Object.Dt_Vencimento[1]

lvdh_Movimento = RelativeDate(lvdh_Movimento, -1)

SetPointer(HourGlass!)

lvl_Exportacao = ivo_mult.of_inicia_lote('GE474','TelLctCont', Today())

lvb_Sucesso = (lvl_Exportacao > 0)

If lvb_Sucesso Then
	
	Open(w_Aguarde)
	w_Aguarde.Title = "Gerando Arquivo de Custo de Telefone..."
	
	lvl_Total = dw_2.RowCount()
	w_Aguarde.uo_Progress.of_SetMax(lvl_Total)
	
	For lvl_Contador = 1 To lvl_Total
				
		lvl_Centro_Custo = dw_2.Object.Cd_Centro_Custo[lvl_Contador]
		
		If lvl_Centro_Custo <> lvl_Centro_Custo_Grupo Then
			
			lvl_Filial          			= dw_2.Object.Cd_Filial        			[lvl_Contador]
			lvs_Nm_Filial       		= dw_2.Object.De_Centro_Custo   	[lvl_Contador]
			lvs_Conta_Contabil  	= dw_2.Object.Cd_Conta_Contabil 	[lvl_Contador]
			lvs_Conta_Credito   	= dw_2.Object.Cd_Conta_Credito  	[lvl_Contador]
			lvs_Conta_Gerencial 	= dw_2.Object.Cd_Centro_Contabil	[lvl_Contador]
			lvdc_Valor          		= dw_2.Object.Total_Geral       		[lvl_Contador]
			lvs_Id_Inf_Contabil 	= dw_2.Object.id_verifica_inf_contabel[lvl_Contador]
						
			//S$$HEX1$$e900$$ENDHEX$$rgio: 06/05/2010
			//Conforme orienta$$HEX2$$e700f500$$ENDHEX$$es do Corr$$HEX1$$ea00$$ENDHEX$$a a conta cr$$HEX1$$e900$$ENDHEX$$dito vai zerada e
			//no final do processo vai ser inclu$$HEX1$$ed00$$ENDHEX$$do a conta cr$$HEX1$$e900$$ENDHEX$$dito para filial 534 no valor total das contas
			lvs_Conta_Credito = "0"
									
			If lvs_Id_Inf_Contabil <> "" Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Faltam informa$$HEX2$$e700f500$$ENDHEX$$es cont$$HEX1$$e100$$ENDHEX$$beis para gera$$HEX2$$e700e300$$ENDHEX$$o do arquivo.",StopSign!)
				lvb_Sucesso = False
				Exit
			End If
			
			If Not wf_Formata_Telefones(lvl_Centro_Custo, Ref lvs_Telefones) Then 
				lvb_Sucesso = False
				Exit
			End If
			
				
			//Manipulacao tem o mesmo CNPJ das Filiais
			//Recebe o o Valor 534
			//Altera a conta gerencial
			If wf_Verifica_Conta_Gerencial(lvl_Filial) Then
				lvl_Filial	 				= ivl_Filial
				lvs_Conta_Gerencial 	= ivs_Conta_Gerencial
			End If
						
			If lvs_Conta_Gerencial = '896' Then
				lvl_Filial = 100
			End If			
			
			If lvs_Conta_Credito = "0" Then
				lvs_Natureza = "D"
			Else
				lvs_Natureza = "C"
			End If
			
			/* Tratamento CC */
			If lvs_Conta_Gerencial <> lvs_Conta_Gerencial_Aux or &
				lvl_Centro_Custo <> lvl_Centro_Custo_Grupo Then
	
				If Not wf_Verifica_Totais_Matriz(lvl_Centro_Custo, Ref lvdc_Total) Then
					lvb_Sucesso = False
					Exit
				End If
				
				If IsNull(lvs_Conta_Gerencial) Then lvs_Conta_Gerencial = "999"

				lvs_Conta_Gerencial_Aux = lvs_Conta_Gerencial
			End If	
		
			lvl_Centro_Custo_Grupo = lvl_Centro_Custo
			lvs_Historico = "VL. FAT. TELEFONE " + String(lvdh_Movimento, "MM/AAAA") + "FILIAL: " + &
	                    			lvs_Nm_Filial + lvs_Telefones
			
			// Lan$$HEX1$$e700$$ENDHEX$$amento dos Telefones - D$$HEX1$$e900$$ENDHEX$$bito
			If Not ivo_Mult.of_grava_lote_item( 	lvl_Exportacao		, &
															lvl_Filial				, &
															lvdh_Movimento	, &
															Long(lvs_Conta_Contabil) + Long(lvs_Conta_Credito), &
															lvs_Natureza		, &
															lvdc_Valor			, &
															lvs_Historico			, &
															Long(lvs_Conta_Gerencial)) Then
				lvb_Sucesso = False
				Exit
			End If			
		End If	
		
		//No final do arquivo o sistema vai gravar uma linha com o valor total das contas para a filial 534.
		If lvl_Contador = lvl_Total Then
			
			lvs_Conta_Contabil= "0"
			lvs_Conta_Credito 	= "2089"
			lvl_Filial				= 534
			lvs_Nm_Filial		= "CIA LATINO AMERICANA" 
			lvs_Telefones		= " (VALOR TOTAL DOS TELEFONES)"
			lvs_Historico 		= "VL. FAT. TELEFONE " + String(lvdh_Movimento, "MM/AAAA") + "FILIAL: " + &
	                    					lvs_Nm_Filial + lvs_Telefones
			
			lvdc_Total_Geral    = dw_2.GetItemDecimal(dw_2.RowCount(), "total_geral_final")
			
			// Lan$$HEX1$$e700$$ENDHEX$$amento dos Telefones - D$$HEX1$$e900$$ENDHEX$$bito
			If Not ivo_Mult.of_grava_lote_item( 	lvl_Exportacao		, &
															lvl_Filial				, &
															lvdh_Movimento	, &
															Long(lvs_Conta_Contabil) + Long(lvs_Conta_Credito), &
															"C"					, &
															lvdc_Total_Geral	, &
															lvs_Historico		) Then
				lvb_Sucesso = False
				Exit
			End If
		End If
		
		w_Aguarde.uo_Progress.of_SetProgress(lvl_Contador)
	Next
	
	Close(w_Aguarde)
	If lvb_Sucesso Then lvb_Sucesso = ivo_Mult.of_finaliza_lote(lvl_Exportacao) 
End If

SetPointer(Arrow!)

If lvb_Sucesso Then
	SQLCa.Of_Commit()
	//ivo_Mult.of_exporta_lote(lvl_Exportacao,'C:\Users\marlon.kniss\Desktop\TEL_exportacao.txt',False)
	MessageBox("Sucesso!","Registros gravados com sucesso na base.~r~n"+&
					"O arquivo ser$$HEX1$$e100$$ENDHEX$$ importado automaticamente em at$$HEX1$$e900$$ENDHEX$$ 10 minutos.~r~n"+ &
					"Aguarde a importa$$HEX2$$e700e300$$ENDHEX$$o no Mult-M3.") 
Else 
	SQLCa.Of_RollBack()
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Ocorreu uma falha na grava$$HEX2$$e700e300$$ENDHEX$$o do lote ou cancelamento pelo usu$$HEX1$$e100$$ENDHEX$$rio.~r~nTente novamente, caso o erro persistir contate a inform$$HEX1$$e100$$ENDHEX$$tica.", Exclamation!)
End If
end event

