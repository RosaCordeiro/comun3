HA$PBExportHeader$w_rateio_sybase.srw
forward
global type w_rateio_sybase from dc_w_sheet
end type
type tx_matricula from editmask within w_rateio_sybase
end type
type tx_nome from singlelineedit within w_rateio_sybase
end type
type st_3 from statictext within w_rateio_sybase
end type
type em_1 from editmask within w_rateio_sybase
end type
type st_1 from statictext within w_rateio_sybase
end type
type cb_3 from commandbutton within w_rateio_sybase
end type
type cb_1 from commandbutton within w_rateio_sybase
end type
type cb_2 from commandbutton within w_rateio_sybase
end type
type dw_1 from datawindow within w_rateio_sybase
end type
type gb_2 from groupbox within w_rateio_sybase
end type
end forward

global type w_rateio_sybase from dc_w_sheet
integer x = 1399
integer y = 456
integer width = 4942
integer height = 2476
string title = "GE215 - Rateio no Sybase"
boolean maxbox = true
long backcolor = 82899184
tx_matricula tx_matricula
tx_nome tx_nome
st_3 st_3
em_1 em_1
st_1 st_1
cb_3 cb_3
cb_1 cb_1
cb_2 cb_2
dw_1 dw_1
gb_2 gb_2
end type
global w_rateio_sybase w_rateio_sybase

type variables
uo_ge253_mult ivo_Mult

long ivl_numfolha
string ivs_nome_arquivo

boolean ivb_Check

end variables

forward prototypes
public subroutine wf_verifica_contas (ref long al_filial_retorno, ref string as_cc_retorno)
public subroutine wf_filtro ()
public function boolean wf_conecta_banco ()
public function date wf_monta_data (integer nr_folha)
end prototypes

public subroutine wf_verifica_contas (ref long al_filial_retorno, ref string as_cc_retorno);If al_Filial_retorno = 688 Then 	//Manip. Joinville
	al_Filial_retorno = 534
	as_cc_retorno = "3534"

ElseIf al_Filial_retorno = 723 Then // Manip. Itajai
	al_Filial_retorno = 723
	as_cc_retorno = "999"
	
ElseIf al_Filial_retorno = 695 Then  //DE_joinville
	al_Filial_retorno = 149
	as_cc_retorno = "1149"

ElseIf al_Filial_retorno = 696 Then // DE_JARAGUA
	al_Filial_retorno = 84
	as_cc_retorno	= "1084"
		
ElseIf al_Filial_retorno = 699 Then  // DE_FLORIPA
	al_Filial_retorno = 301
	as_cc_retorno = "1301"
	
ElseIf al_Filial_retorno = 700 Then // DE_BLUMENAU
	al_Filial_retorno = 136
	as_cc_retorno = "1136"

ElseIf al_Filial_retorno = 701 Then //DE_CRICIUMA
	al_Filial_retorno = 107
	as_cc_retorno	= "1107"	
	
ElseIf al_Filial_retorno = 704 Then // DE_ITAJAI 
	al_Filial_retorno = 71
	as_cc_retorno = "1071"
	
ElseIf al_Filial_retorno = 705 Then // DE_LAGES
	al_Filial_retorno = 42
	as_cc_retorno	= "1042"
	
ElseIf al_Filial_retorno = 708 Then // DE_TUBARAO 
	al_Filial_retorno = 550
	as_cc_retorno = "1550"
	
ElseIf al_Filial_retorno = 709 Then // DE_BALNEARIO CAMBORIU 
	al_Filial_retorno = 592
	as_cc_retorno = "1592"
	
ElseIf al_Filial_retorno = 712 Then // DE_CHAPEC$$HEX1$$d300$$ENDHEX$$ 
	al_Filial_retorno = 39
	as_cc_retorno = "1039"

ElseIf al_Filial_retorno = 809 Then //FA Joinville (B Constant)
	al_Filial_retorno = 790
	as_cc_retorno = "2790"

ElseIf al_Filial_retorno = 915 Then //DE Joinville (B Constant)
	al_Filial_retorno = 790
	as_cc_retorno = "1790"

	
////---------------Contas da MATRIZ - 534
//
//ElseIf al_Filial_retorno = 534821 Then
//	al_Filial_retorno = 534
//	as_cc_retorno = "821" //Diretoria
//	
//ElseIf al_Filial_retorno = 534823 Then
//	al_Filial_retorno = 534
//	as_cc_retorno = "823" //Phenom 100
//
//ElseIf al_Filial_retorno = 534860 Then
//	al_Filial_retorno = 534
//	as_cc_retorno = "860" //Contabilidade
//	
//ElseIf al_Filial_retorno = 534861 Then
//	al_Filial_retorno = 534
//	as_cc_retorno = "861" //Fiscal
//	
//ElseIf al_Filial_retorno = 534862 Then
//	al_Filial_retorno = 534
//	as_cc_retorno = "862" //Contas a Pagar
//
//ElseIf al_Filial_retorno = 534865 Then
//	al_Filial_retorno = 534
//	as_cc_retorno = "865" //Controladoria
//	
//ElseIf al_Filial_retorno = 534870 Then
//	al_Filial_retorno = 534
//	as_cc_retorno = "870" //Ger$$HEX1$$ea00$$ENDHEX$$ncia de Inform$$HEX1$$e100$$ENDHEX$$tica
//	
//ElseIf al_Filial_retorno = 534871 Then
//	al_Filial_retorno = 534
//	as_cc_retorno = "871" //E-Commerce
//
//ElseIf al_Filial_retorno = 534875 Then
//	al_Filial_retorno = 534
//	as_cc_retorno = "875" //ADM PESSOAL
//	
//ElseIf al_Filial_retorno = 534876 Then
//	al_Filial_retorno = 534
//	as_cc_retorno = "876" //Desenv. RH
//
//ElseIf al_Filial_retorno = 534877 Then
//	al_Filial_retorno = 534
//	as_cc_retorno = "877" //Clube Drogaria Cataninense
//	
//ElseIf al_Filial_retorno = 534880 Then
//	al_Filial_retorno = 534
//	as_cc_retorno = "880" //Acionistas
//
//ElseIf al_Filial_retorno = 534881 Then
//	al_Filial_retorno = 534
//	as_cc_retorno = "881" //Recepcao
//	
//ElseIf al_Filial_retorno = 534882 Then
//	al_Filial_retorno = 534
//	as_cc_retorno = "882" //Comunicacao
//	
//ElseIf al_Filial_retorno = 534887 Then
//	al_Filial_retorno = 534
//	as_cc_retorno = "887" //Credito/ Cobran$$HEX1$$e700$$ENDHEX$$a
//
//ElseIf al_Filial_retorno = 534889 Then
//	al_Filial_retorno = 534
//	as_cc_retorno = "889" //TESOURARIA
//	
//ElseIf al_Filial_retorno = 534891 Then
//	al_Filial_retorno = 534
//	as_cc_retorno = "891" //An$$HEX1$$e100$$ENDHEX$$lise de Investimentos
//	
//ElseIf al_Filial_retorno = 534894 Then
//	al_Filial_retorno = 534
//	as_cc_retorno = "894" //Gerencia Comercial 2002
//
//ElseIf al_Filial_retorno = 534895 Then
//	al_Filial_retorno = 534
//	as_cc_retorno = "895" //MANUTEN$$HEX2$$c700c300$$ENDHEX$$O GERAL
//	
//ElseIf al_Filial_retorno = 534896 Then
//	al_Filial_retorno = 534
//	as_cc_retorno = "896" //LOGISTICA
//
//ElseIf al_Filial_retorno = 534897 Then
//	al_Filial_retorno = 534
//	as_cc_retorno = "897" //Marketing
//	
//ElseIf al_Filial_retorno = 534905 Then
//	al_Filial_retorno = 534
//	as_cc_retorno = "905" //Compras Farmacia
End If
end subroutine

public subroutine wf_filtro ();String lvs_Nome
String lvs_Matricula
String lvs_Filtro

lvs_Nome		= Trim(tx_Nome.Text)
lvs_Matricula	= Trim(tx_Matricula.Text)
lvs_Filtro = ""

dw_1.SetRedraw(False)

If Len(lvs_Matricula) > 3 Then
	lvs_Filtro = "nr_matricula = " + lvs_Matricula
End If

If Len(lvs_Nome) > 2 Then
	If lvs_Filtro <> "" Then
		lvs_Filtro += " and "
	End If
	
	lvs_Filtro += "nm_colaborador like '" + lvs_Nome + "%'"	
End If

dw_1.SetFilter(lvs_Filtro)
dw_1.Filter()

dw_1.SetRedraw(True)
end subroutine

public function boolean wf_conecta_banco ();Return gf_conecta_banco_rh(gtr_rh, "vetorh_ti")
end function

public function date wf_monta_data (integer nr_folha);DateTime lvdt_data

SetNull(lvdt_data)

select fimcmp
  into :lvdt_data
  from r044cal
 where numemp = 1 and
       codcal = :nr_folha
using gtr_rh;

if IsNull(lvdt_data) then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao obter data da folha de pagamento", information!, ok!)
end if

Return Date(lvdt_data)
end function

event open;ivo_Mult = Create uo_ge253_mult

x = 0
y = 0

end event

on w_rateio_sybase.create
int iCurrent
call super::create
this.tx_matricula=create tx_matricula
this.tx_nome=create tx_nome
this.st_3=create st_3
this.em_1=create em_1
this.st_1=create st_1
this.cb_3=create cb_3
this.cb_1=create cb_1
this.cb_2=create cb_2
this.dw_1=create dw_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tx_matricula
this.Control[iCurrent+2]=this.tx_nome
this.Control[iCurrent+3]=this.st_3
this.Control[iCurrent+4]=this.em_1
this.Control[iCurrent+5]=this.st_1
this.Control[iCurrent+6]=this.cb_3
this.Control[iCurrent+7]=this.cb_1
this.Control[iCurrent+8]=this.cb_2
this.Control[iCurrent+9]=this.dw_1
this.Control[iCurrent+10]=this.gb_2
end on

on w_rateio_sybase.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tx_matricula)
destroy(this.tx_nome)
destroy(this.st_3)
destroy(this.em_1)
destroy(this.st_1)
destroy(this.cb_3)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.dw_1)
destroy(this.gb_2)
end on

event close;call super::close;Destroy(ivo_Mult)
end event

type dw_visual from dc_w_sheet`dw_visual within w_rateio_sybase
end type

type gb_aux_visual from dc_w_sheet`gb_aux_visual within w_rateio_sybase
end type

type tx_matricula from editmask within w_rateio_sybase
event editchanged pbm_enchange
string tag = "M$$HEX1$$ed00$$ENDHEX$$nimo tr$$HEX1$$ea00$$ENDHEX$$s digitos"
integer x = 1673
integer y = 156
integer width = 279
integer height = 76
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
boolean enabled = false
alignment alignment = right!
textcase textcase = upper!
string mask = "######"
end type

event editchanged;wf_Filtro()

//String lvs_Texto
//
//lvs_Texto = Trim(This.Text)
//
//dw_1.SetRedraw(False)
//
//If Len(lvs_Texto) > 3 Then
//	dw_1.SetFilter("nr_matricula = " + lvs_Texto)
//	dw_1.Filter()
//Else
//	If Len(Trim(sle_2.Text)) < 3 Then
//		dw_1.SetFilter("")
//		dw_1.Filter()
//	End If
//End If
//
//dw_1.SetRedraw(True)
end event

type tx_nome from singlelineedit within w_rateio_sybase
event editchanged pbm_enchange
string tag = "M$$HEX1$$ed00$$ENDHEX$$nimo tr$$HEX1$$ea00$$ENDHEX$$s digitos"
integer x = 599
integer y = 156
integer width = 1061
integer height = 76
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
boolean enabled = false
textcase textcase = upper!
end type

event editchanged;wf_Filtro()

//String lvs_Texto
//
//lvs_Texto = Trim(This.Text)
//
//dw_1.SetRedraw(False)
//
//If Len(lvs_Texto) > 2 Then
//	dw_1.SetFilter("nm_colaborador like '" + lvs_Texto + "%'")
//	dw_1.Filter()
//Else
//	If Len(Trim(em_1.Text)) < 4 Then
//		dw_1.SetFilter("")
//		dw_1.Filter()
//	End If
//End If
//
//dw_1.SetRedraw(True)
end event

type st_3 from statictext within w_rateio_sybase
string tag = "M$$HEX1$$ed00$$ENDHEX$$nimo tr$$HEX1$$ea00$$ENDHEX$$s digitos"
integer x = 59
integer y = 160
integer width = 530
integer height = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "Colaborador:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_1 from editmask within w_rateio_sybase
integer x = 599
integer y = 20
integer width = 306
integer height = 76
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
alignment alignment = right!
string mask = "#####"
end type

type st_1 from statictext within w_rateio_sybase
integer x = 59
integer y = 28
integer width = 530
integer height = 80
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "N$$HEX1$$fa00$$ENDHEX$$mero da Folha:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_3 from commandbutton within w_rateio_sybase
integer x = 4393
integer y = 144
integer width = 494
integer height = 104
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "&Gerar Lote Mult"
end type

event clicked;Long lvl_filial_de
Long lvl_filial_para
Long lvl_linha
Long lvl_Lote

Date lvdt_Data

String lvs_adm
String lvs_ccusto_de
String lvs_conta_proventos_de
String lvs_conta_pat_de
String lvs_conta_vt_de
String lvs_conta_inss_de
String lvs_conta_fgts_de
String lvs_conta_ferias_de
String lvs_conta_13_de
String lvs_ccusto_para
String lvs_conta_proventos_para
String lvs_conta_pat_para
String lvs_conta_vt_para
String lvs_conta_inss_para
String lvs_conta_fgts_para
String lvs_conta_ferias_para
String lvs_conta_13_para
String lvs_Historico

Decimal lvdc_valor
Decimal lvdc_diferenca

if Dw_1.RowCount() < 1 then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ registros a exportar.", Information!, Ok!)
	return
end if

lvdt_Data = wf_monta_data(ivl_numfolha)

lvl_Lote = ivo_mult.of_inicia_lote('GE215','FolLctCont', Today())

If lvl_Lote > 0 Then
	Open(w_aguarde)
	w_aguarde.Title = 'Gerando registros...'
	w_aguarde.uo_progress.Of_SetMax(dw_1.RowCount())
	
	For lvl_linha = 1 to dw_1.RowCount()
		
		w_aguarde.uo_progress.Of_SetProgress(lvl_linha)
		If dw_1.object.id_gera_mult[lvl_linha] <> 'S' or IsNull(dw_1.object.id_gera_mult[lvl_linha]) then
			Continue
		End If
		
		lvl_filial_de		= dw_1.object.cd_filial_de	[lvl_linha]
		lvl_filial_para	= dw_1.object.cd_filial_para[lvl_linha]
		lvs_adm			= dw_1.object.id_adm		[lvl_linha]
		
		if lvl_filial_de = 534 then
			lvs_ccusto_de = "876"
		else
			lvs_ccusto_de = "999"
		end if
		
		if lvl_filial_para = 534 then
			lvs_ccusto_para = "876"
		else
			lvs_ccusto_para = "999"
		end if
			
		if lvl_filial_de = 534 then   // or lvs_adm = 'S'
			lvs_conta_proventos_de	= '4502'
			lvs_conta_inss_de			= '4505'
			lvs_conta_fgts_de			= '4506'
			lvs_conta_ferias_de		= '4507'
			lvs_conta_13_de			= '4508'
			lvs_conta_pat_de			= '4515'
			lvs_conta_vt_de			= '4509'
		else
			lvs_conta_proventos_de	= '4301'
			lvs_conta_inss_de 			= '4304'
			lvs_conta_fgts_de 			= '4305'
			lvs_conta_ferias_de 		= '4306'
			lvs_conta_13_de 			= '4307'
			lvs_conta_pat_de 			= '4313'
			lvs_conta_vt_de			= '4308'
		end if		
	
		if lvl_filial_para = 534 then   // or lvs_adm = 'S'
			lvs_conta_proventos_para	= '4502'
			lvs_conta_inss_para			= '4505'
			lvs_conta_fgts_para			= '4506'
			lvs_conta_ferias_para			= '4507'
			lvs_conta_13_para				= '4508'
			lvs_conta_pat_para			= '4515'
			lvs_conta_vt_para				= '4509'
		else
			lvs_conta_proventos_para	= '4301'
			lvs_conta_inss_para			= '4304'
			lvs_conta_fgts_para			= '4305'
			lvs_conta_ferias_para			= '4306'
			lvs_conta_13_para				= '4307'
			lvs_conta_pat_para			= '4313'
			lvs_conta_vt_para				= '4308'
		end if		
	
		wf_verifica_contas(Ref lvl_filial_de, Ref lvs_ccusto_de)
		wf_verifica_contas(Ref lvl_filial_para, Ref lvs_ccusto_para)	
		
		// proventos
		lvdc_valor = dw_1.object.vl_total_prov[lvl_linha]
		lvs_Historico = "Vl. ref. substitui$$HEX2$$e700e300$$ENDHEX$$o de funcion$$HEX1$$e100$$ENDHEX$$rios entre filiais m$$HEX1$$ea00$$ENDHEX$$s " + String(lvdt_Data,'MM/YYYY')
		
		ivo_mult.of_grava_lote_item( 	lvl_lote								, &
												lvl_filial_de							, &
												lvdt_Data								, &
												Long(lvs_conta_proventos_de)	, &
												"C"									, &
												lvdc_valor							, &
												lvs_Historico							, &
												Long(lvs_ccusto_de))
		
		ivo_mult.of_grava_lote_item( 	lvl_lote									, &
												lvl_filial_para							, &
												lvdt_Data									, &
												Long(lvs_conta_proventos_para)	, &
												"D"										, &
												lvdc_valor								, &
												lvs_Historico								, &
												Long(lvs_ccusto_para))
		
		 // encargos
		lvdc_diferenca = 0
		// encargos  fgts
		lvdc_valor = round(dw_1.object.vl_encargos[lvl_linha] * 0.1541,2)
		lvdc_diferenca += lvdc_valor
	
		ivo_mult.of_grava_lote_item( 	lvl_lote									, &
												lvl_filial_de								, &
												lvdt_Data									, &
												Long(lvs_conta_fgts_de)				, &
												"C"										, &
												lvdc_valor								, &
												lvs_Historico								, &
												Long(lvs_ccusto_de))
												
		ivo_mult.of_grava_lote_item( 	lvl_lote									, &
												lvl_filial_para							, &
												lvdt_Data									, &
												Long(lvs_conta_fgts_para)			, &
												"D"										, &
												lvdc_valor								, &
												lvs_Historico								, &
												Long(lvs_ccusto_para))

		// encargos  inss
		lvdc_valor = round(dw_1.object.vl_encargos[lvl_linha] * 0.5326,2)
		lvdc_diferenca += lvdc_valor
	
		ivo_mult.of_grava_lote_item( 	lvl_lote									, &
												lvl_filial_de								, &
												lvdt_Data									, &
												Long(lvs_conta_inss_de)				, &
												"C"										, &
												lvdc_valor								, &
												lvs_Historico								, &
												Long(lvs_ccusto_de))
												
		ivo_mult.of_grava_lote_item( 	lvl_lote									, &
												lvl_filial_para							, &
												lvdt_Data									, &
												Long(lvs_conta_inss_para)			, &
												"D"										, &
												lvdc_valor								, &
												lvs_Historico								, &
												Long(lvs_ccusto_para))
		
		// encargos  ferias
		lvdc_valor = round(dw_1.object.vl_encargos[lvl_linha] * 0.179,2)
		lvdc_diferenca += lvdc_valor
	
		ivo_mult.of_grava_lote_item( 	lvl_lote									, &
												lvl_filial_de								, &
												lvdt_Data									, &
												Long(lvs_conta_ferias_de)			, &
												"C"										, &
												lvdc_valor								, &
												lvs_Historico								, &
												Long(lvs_ccusto_de))
												
		ivo_mult.of_grava_lote_item( 	lvl_lote									, &
												lvl_filial_para							, &
												lvdt_Data									, &
												Long(lvs_conta_ferias_para)		, &
												"D"										, &
												lvdc_valor								, &
												lvs_Historico								, &
												Long(lvs_ccusto_para))

		// encargos  13$$HEX1$$ba00$$ENDHEX$$
		lvdc_valor = Round(dw_1.object.vl_encargos[lvl_linha] - lvdc_diferenca,2)
	
		ivo_mult.of_grava_lote_item( 	lvl_lote									, &
												lvl_filial_de								, &
												lvdt_Data									, &
												Long(lvs_conta_13_de)				, &
												"C"										, &
												lvdc_valor								, &
												lvs_Historico								, &
												Long(lvs_ccusto_de))
												
		ivo_mult.of_grava_lote_item( 	lvl_lote									, &
												lvl_filial_para							, &
												lvdt_Data									, &
												Long(lvs_conta_13_para)			, &
												"D"										, &
												lvdc_valor								, &
												lvs_Historico								, &
												Long(lvs_ccusto_para))
	
		// pat
		lvdc_valor = dw_1.object.vl_pat[lvl_linha]
		If lvdc_valor > 0 Then
	
			ivo_mult.of_grava_lote_item( 	lvl_lote								, &
													lvl_filial_de							, &
													lvdt_Data								, &
													Long(lvs_conta_pat_de)			, &
													"C"									, &
													lvdc_valor							, &
													lvs_Historico							, &
													Long(lvs_ccusto_de))
													
			ivo_mult.of_grava_lote_item( 	lvl_lote								, &
													lvl_filial_para						, &
													lvdt_Data								, &
													Long(lvs_conta_pat_para)		, &
													"D"									, &
													lvdc_valor							, &
													lvs_Historico							, &
													Long(lvs_ccusto_para))
		End If
		// vt
		lvdc_valor = dw_1.object.vl_valetransp[lvl_linha]
		If lvdc_valor > 0 Then

			ivo_mult.of_grava_lote_item( 	lvl_lote							, &
													lvl_filial_de						, &
													lvdt_Data							, &
													Long(lvs_conta_vt_de)		, &
													"C"								, &
													lvdc_valor						, &
													lvs_Historico						, &
													Long(lvs_ccusto_de))
													
			ivo_mult.of_grava_lote_item( 	lvl_lote							, &
													lvl_filial_para					, &
													lvdt_Data							, &
													Long(lvs_conta_vt_para)		, &
													"D"								, &
													lvdc_valor						, &
													lvs_Historico						, &
													Long(lvs_ccusto_para))
		End If	
	
	Next
	Close(w_aguarde)
	
	If ivo_mult.Of_finaliza_lote( lvl_Lote) Then
		SQLCa.Of_Commit()
		//ivo_Mult.of_exporta_lote(lvl_Exportacao,'C:\Users\marlon.kniss\Desktop\SQL\FUN_exportacao.txt',False)
		MessageBox("Sucesso!","Registros gravados com sucesso na base.~r~n"+&
						"O arquivo ser$$HEX1$$e100$$ENDHEX$$ gerado importado autom$$HEX1$$e100$$ENDHEX$$ticamente em at$$HEX1$$e900$$ENDHEX$$ 20 minutos.~r~n"+ &
						"Aguarde a importa$$HEX2$$e700e300$$ENDHEX$$o no Mult-M3.") 
	Else 
		SQLCa.Of_RollBack()
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Ocorreu uma falha na grava$$HEX2$$e700e300$$ENDHEX$$o do lote ou cancelamento pelo usu$$HEX1$$e100$$ENDHEX$$rio.~r~nTente novamente, caso o erro persistir contate a inform$$HEX1$$e100$$ENDHEX$$tica.", Exclamation!)
	End If
Else
	SQLCa.Of_RollBack()
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Ocorreu uma falha na grava$$HEX2$$e700e300$$ENDHEX$$o do registro de lote.~r~nTente novamente, caso o erro persistir contate a inform$$HEX1$$e100$$ENDHEX$$tica.", Exclamation!)
End If
end event

type cb_1 from commandbutton within w_rateio_sybase
integer x = 946
integer y = 8
integer width = 352
integer height = 104
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Carregar"
end type

event clicked;long lvl_linha

setpointer(hourglass!)

ivl_numfolha = integer(em_1.text)

if isnull(ivl_numfolha) or ivl_numfolha = 0 then
	messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Favor informar o c$$HEX1$$f300$$ENDHEX$$digo da folha", Information!)
	em_1.setfocus()
	setpointer(arrow!)
	return
end if

lvl_linha = dw_1.retrieve(ivl_numfolha)

if lvl_linha = 0 then
	messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foram encontrados rateios para esta folha", Information!)
	em_1.setfocus()
	setpointer(arrow!)
	return
end if

cb_2.enabled = true
cb_3.enabled = true
this.enabled = false
em_1.enabled = false
tx_nome.enabled = true
tx_matricula.enabled = true

setpointer(arrow!)
end event

type cb_2 from commandbutton within w_rateio_sybase
integer x = 1312
integer y = 8
integer width = 352
integer height = 104
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "&Salvar"
end type

event clicked;SetPointer(HourGlass!)

dw_1.update()

SetPointer(Arrow!)


end event

type dw_1 from datawindow within w_rateio_sybase
integer x = 55
integer y = 360
integer width = 4809
integer height = 1900
integer taborder = 50
string dataobject = "dw_rateio"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event constructor;If Not wf_conecta_banco() Then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel conectar ao banco de dados do RH.~r~nA tela "'+Parent.Title+'" ser$$HEX1$$e100$$ENDHEX$$ encerrada!',StopSign!)
	Close(Parent)
	Return
Else
	This.SetTransObject(SQLCa)
End If
end event

event updateend;Commit Using SQLCa;
end event

event clicked;// OverRide
If dwo.name = 'id_imagem' Then Return


if this.isselected(row) = true then
	this.selectrow(row, false)
else
	this.selectrow(0, false)
	this.selectrow(row, true)
end if
end event

event rbuttondown;if this.rowcount() > 0 then
	this.saveas("", excel!, true)
end if
end event

event doubleclicked;String lvs_Incluir_Excluir,&
	   lvs_Marcacao

Integer lvi_Row
		  
If dwo.Name = "id_imagem" Then
	
	If ivb_Check Then
		lvs_Marcacao = 'N'
		ivb_Check 	 = False
		// Excluir
		lvs_Incluir_Excluir = "E"
	Else
		lvs_Marcacao = 'S'
		ivb_Check 	 = True
		// Incluir
		lvs_Incluir_Excluir = "I"
	End If
	
	For lvi_Row = 1 To This.RowCount()
		This.Object.Id_Gera_Mult[lvi_Row] = lvs_Marcacao
	Next
	
End If


end event

type gb_2 from groupbox within w_rateio_sybase
integer x = 18
integer y = 284
integer width = 4873
integer height = 1996
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Rateios Selecionados pelo Recursos Humanos"
borderstyle borderstyle = styleraised!
end type

