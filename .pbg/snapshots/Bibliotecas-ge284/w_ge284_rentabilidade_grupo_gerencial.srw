HA$PBExportHeader$w_ge284_rentabilidade_grupo_gerencial.srw
forward
global type w_ge284_rentabilidade_grupo_gerencial from dc_w_selecao_lista_relatorio
end type
type pb_info from picturebutton within w_ge284_rentabilidade_grupo_gerencial
end type
end forward

global type w_ge284_rentabilidade_grupo_gerencial from dc_w_selecao_lista_relatorio
string tag = "w_ge284_rentabilidade_grupo_gerencial"
integer width = 3634
integer height = 1988
string title = "GE284 - Relat$$HEX1$$f300$$ENDHEX$$rio por Grupo (Custo Gerencial)"
long backcolor = 80269524
pb_info pb_info
end type
global w_ge284_rentabilidade_grupo_gerencial w_ge284_rentabilidade_grupo_gerencial

type variables
Boolean ivb_imprimir_conjunto = False

String ivs_filiais
String ivs_impressao_filial

String ivs_Info = '' //Mensagem bot$$HEX1$$e300$$ENDHEX$$o info

uo_ge216_Filiais	ivo_Filiais
uo_filial			io_Filial
end variables

forward prototypes
public subroutine wf_seleciona_filiais ()
public function boolean wf_recupera_informacoes (string ps_tipo, date pdt_periodo, string ps_nome_dw)
public subroutine wf_atualiza_totais ()
public function boolean wf_atualiza_informacoes_filiais (datastore pds_1, date pdt_periodo)
public function boolean wf_atualiza_informacoes (datastore pds_1, date pdt_periodo)
public function boolean wf_atualiza_filial (datastore pds_1, date pdt_periodo, long al_filial)
public subroutine wf_imprimir_conjunto_filiais ()
public subroutine wf_seta_mensagem_informacao ()
end prototypes

public subroutine wf_seleciona_filiais ();Integer lvi_Linhas, &
        lvi_Row, &
		  lvi_Filial,&
		  lvl_Lojas
		  
ivs_Filiais = "("

ivo_Filiais = Create uo_ge216_Filiais

OpenWithParm(w_ge216_selecao_filiais, ivo_Filiais)

//ivo_Filiais = Message.PowerObjectParm
lvl_Lojas = Message.DoubleParm

If IsNull(ivo_Filiais) Then 
	ivs_Filiais = ""
	Return
End If

lvi_Linhas = UpperBound(ivo_Filiais.Cd_Filial[])

If lvl_Lojas > 0 Then
	io_Filial.of_Inicializa()
			
	dw_1.Object.cd_filial  	[1] = io_Filial.cd_filial
	dw_1.Object.nm_fantasia[1] = io_Filial.nm_fantasia
					
	For lvi_Row = 1 To lvi_Linhas
		
		lvi_Filial = ivo_Filiais.Cd_Filial[lvi_Row]
		
		ivs_Filiais += String(lvi_Filial)
		
		If lvi_Row <> lvi_Linhas Then
			ivs_Filiais += ","
		End If
	Next
End If

ivs_Filiais += ")"

If lvi_Linhas = 0 Then ivs_Filiais = ""
end subroutine

public function boolean wf_recupera_informacoes (string ps_tipo, date pdt_periodo, string ps_nome_dw);Boolean lvb_Sucesso = True

Long lvl_Total

dc_uo_ds_base lvds_1
lvds_1 = Create dc_uo_ds_base

If Not lvds_1.Of_ChangeDataObject(ps_Nome_Dw) Then Return False

// "C" - conjunto de filiais
If ps_Tipo = "C" Then
	If Not wf_Atualiza_Informacoes_Filiais(lvds_1, pdt_Periodo) Then Return lvb_Sucesso = False
Else	
	If Not wf_Atualiza_Informacoes(lvds_1, pdt_Periodo) Then Return lvb_Sucesso = False
End If

Destroy(lvds_1)

Return lvb_Sucesso
end function

public subroutine wf_atualiza_totais ();Long lvl_Row

Decimal{2} lvdc_Vendas, &
           lvdc_Cmv, &
			  lvdc_Comissao, &
			  lvdc_Impostos, &
			  lvdc_Total_Vendas, &
			  lvdc_Rent_Sem_Comissao, &
			  lvdc_Rent_Com_Comissao

lvdc_Total_Vendas = dw_2.Object.Sum_Vl_Vendas[1]

For lvl_Row = 1 To dw_2.RowCount()
	lvdc_Vendas		= dw_2.Object.Vl_Vendas	[lvl_Row]
	lvdc_Cmv		= dw_2.Object.Vl_Cmv		[lvl_Row]
	lvdc_Comissao	= dw_2.Object.Vl_Comissao[lvl_Row]
	lvdc_Impostos	= dw_2.Object.Vl_Impostos	[lvl_Row]
	
	lvdc_Rent_Sem_Comissao = lvdc_Vendas - lvdc_CMV - lvdc_Impostos
	lvdc_Rent_Com_Comissao = lvdc_Vendas - lvdc_CMV - lvdc_Impostos - lvdc_Comissao

	dw_2.Object.Perc_Vendas					[lvl_Row] = Round(lvdc_Vendas / lvdc_Total_Vendas * 100, 2)
	dw_2.Object.Vl_Rentabilidade				[lvl_Row] = lvdc_Rent_Sem_Comissao
	dw_2.Object.Vl_Rentabilidade_Comissao	[lvl_Row] = lvdc_Rent_Com_Comissao
	
	If lvdc_Vendas > 0 Then
		dw_2.Object.Perc_Cmv							[lvl_Row] = Round(lvdc_Cmv               / lvdc_Vendas * 100, 2)
		dw_2.Object.Perc_Comissao					[lvl_Row] = Round(lvdc_Comissao          / lvdc_Vendas * 100, 2)
		dw_2.Object.Perc_Impostos						[lvl_Row] = Round(lvdc_Impostos          / lvdc_Vendas * 100, 2)
		dw_2.Object.Perc_Rentabilidade				[lvl_Row] = Round(lvdc_Rent_Sem_Comissao / lvdc_Vendas * 100, 2)
		dw_2.Object.Perc_Rentabilidade_Comissao	[lvl_Row] = Round(lvdc_Rent_Com_Comissao / lvdc_Vendas * 100, 2)
	Else
		dw_2.Object.Perc_Cmv							[lvl_Row] = 0
		dw_2.Object.Perc_Comissao					[lvl_Row] = 0
		dw_2.Object.Perc_Impostos						[lvl_Row] = 0
		dw_2.Object.Perc_Rentabilidade				[lvl_Row] = 0
		dw_2.Object.Perc_Rentabilidade_Comissao	[lvl_Row] = 0
	End If
Next
end subroutine

public function boolean wf_atualiza_informacoes_filiais (datastore pds_1, date pdt_periodo);Boolean lvb_Sucesso = True

Long lvl_Total
Long lvl_Contador
Long lvl_Filial

String ls_Tipo_Filiais

dw_1.AcceptText()

ls_Tipo_Filiais = dw_1.Object.Filial[1]

Open(w_Aguarde)

If ls_Tipo_Filiais = "C" Then
	lvl_Total = UpperBound(ivo_Filiais.Cd_Filial)
	
	w_Aguarde.uo_Progress.of_SetMax(lvl_Total)
	
	For lvl_Contador = 1 To lvl_Total
		lvl_Filial = ivo_Filiais.Cd_Filial[lvl_Contador]
		
		w_Aguarde.Title = "Atualizando Informa$$HEX2$$e700f500$$ENDHEX$$es da Filial '" + String(lvl_Filial) + "' (" + String(lvl_Contador) + " de " + String(lvl_Total) + ")"
		
		If Not wf_Atualiza_Filial(pds_1, pdt_Periodo, lvl_Filial) Then
			Close(w_Aguarde)
			lvb_Sucesso = False
			Exit
		End If
		
		w_Aguarde.uo_Progress.of_SetProgress(lvl_Contador)
	Next

Else
	lvl_Filial = dw_1.Object.Cd_Filial[1]
	
	w_Aguarde.Title = "Atualizando Informa$$HEX2$$e700f500$$ENDHEX$$es da Filial '" + String(lvl_Filial) + "'"
	
	If Not wf_Atualiza_Filial(pds_1, pdt_Periodo, lvl_Filial) Then
		Close(w_Aguarde)
		lvb_Sucesso = False
	End If
End If

Close(w_Aguarde)

Return lvb_Sucesso
end function

public function boolean wf_atualiza_informacoes (datastore pds_1, date pdt_periodo);Long lvl_Linha_Nova, &
     lvl_Row, &
	  lvl_Qtde, &
	  lvl_Total
	  
Decimal{2} lvdc_Vendas, &
			  lvdc_CMV, &
			  lvdc_Comissao, &
			  lvdc_ICMS, &
			  lvdc_PIS_COFINS
			  
lvl_Total = pds_1.Retrieve(pdt_Periodo)

For lvl_Row = 1 To lvl_Total
	lvl_Qtde				= pds_1.Object.Qt_Venda			[lvl_Row] 
	lvdc_Vendas			= pds_1.Object.Vl_Venda			[lvl_Row]
	lvdc_CMV			= pds_1.Object.Vl_Cmv				[lvl_Row]
	lvdc_Comissao		= pds_1.Object.Vl_Comissao		[lvl_Row]
	lvdc_ICMS			= pds_1.Object.Vl_ICMS				[lvl_Row]
	lvdc_PIS_COFINS	= pds_1.Object.Vl_PIS_COFINS	[lvl_Row]
	
	If lvdc_Vendas <> 0 Then
		lvl_Linha_Nova = dw_2.InsertRow(0)
		
		dw_2.Object.Cd_Grupo		[lvl_Linha_Nova] = pds_1.Object.Cd_Grupo[lvl_Row]
		dw_2.Object.De_Grupo		[lvl_Linha_Nova] = pds_1.Object.De_Grupo[lvl_Row]
		dw_2.Object.Qt_Vendas		[lvl_Linha_Nova] = lvl_Qtde
		dw_2.Object.Vl_Vendas		[lvl_Linha_Nova] = lvdc_Vendas
		dw_2.Object.Vl_Cmv			[lvl_Linha_Nova] = lvdc_CMV
		dw_2.Object.Vl_Comissao	[lvl_Linha_Nova] = lvdc_Comissao
		dw_2.Object.Vl_Impostos	[lvl_Linha_Nova] = lvdc_ICMS + lvdc_PIS_COFINS
	End If		
Next

Return True
end function

public function boolean wf_atualiza_filial (datastore pds_1, date pdt_periodo, long al_filial);Boolean lvb_Sucesso = True

Long lvl_Linha_Nova, &
     lvl_Linha, &
	  lvl_Qtde, &
	  lvl_Total, &
	  lvl_Find

Decimal{2} lvdc_Vendas, &
			  lvdc_CMV, &
			  lvdc_Comissao, &
			  lvdc_ICMS, &
			  lvdc_PIS_COFINS
			  
String lvs_Cd_Grupo, &
       lvs_De_Grupo, &
		 lvs_Find
	
lvl_Total = pds_1.Retrieve(pdt_Periodo, al_Filial)

For lvl_Linha = 1 To lvl_Total
	lvs_Cd_Grupo		= pds_1.Object.Cd_Grupo			[lvl_Linha]
	lvs_De_Grupo		= pds_1.Object.De_Grupo			[lvl_Linha]
	lvl_Qtde				= pds_1.Object.Qt_Venda			[lvl_Linha] 
	lvdc_Vendas			= pds_1.Object.Vl_Venda			[lvl_Linha]
	lvdc_CMV			= pds_1.Object.Vl_Cmv				[lvl_Linha]
	lvdc_Comissao		= pds_1.Object.Vl_Comissao		[lvl_Linha]
	lvdc_ICMS			= pds_1.Object.Vl_ICMS				[lvl_Linha]
	lvdc_PIS_COFINS	= pds_1.Object.Vl_PIS_COFINS	[lvl_Linha]

	lvs_Find = "cd_grupo = '" + lvs_Cd_Grupo + "'"
	
	lvl_Find = dw_2.Find(lvs_Find, 1, dw_2.RowCount())
	
	If lvl_Find < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no find ao localizar o grupo: " + lvs_Cd_Grupo + "'", StopSign!)
		lvb_Sucesso = False
		Exit
	End If
	
	If lvl_Find > 0 Then
		dw_2.Object.Qt_Vendas		[lvl_Find] = dw_2.Object.Qt_Vendas		[lvl_Find] + lvl_Qtde
		dw_2.Object.Vl_Vendas		[lvl_Find] = dw_2.Object.Vl_Vendas		[lvl_Find] + lvdc_Vendas
		dw_2.Object.Vl_Cmv			[lvl_Find] = dw_2.Object.Vl_Cmv			[lvl_Find] + lvdc_CMV
		dw_2.Object.Vl_Comissao	[lvl_Find] = dw_2.Object.Vl_Comissao	[lvl_Find] + lvdc_Comissao
		dw_2.Object.Vl_Impostos	[lvl_Find] = dw_2.Object.Vl_Impostos	[lvl_Find] + lvdc_ICMS + lvdc_PIS_COFINS
	Else
		If lvdc_Vendas <> 0 Then
			lvl_Linha_Nova = dw_2.InsertRow(0)
			
			dw_2.Object.Cd_Grupo		[lvl_Linha_Nova] = lvs_Cd_Grupo
			dw_2.Object.De_Grupo		[lvl_Linha_Nova] = lvs_De_Grupo			
			dw_2.Object.Qt_Vendas		[lvl_Linha_Nova] = lvl_Qtde
			dw_2.Object.Vl_Vendas		[lvl_Linha_Nova] = lvdc_Vendas
			dw_2.Object.Vl_Cmv			[lvl_Linha_Nova] = lvdc_CMV
			dw_2.Object.Vl_Comissao	[lvl_Linha_Nova] = lvdc_Comissao
			dw_2.Object.Vl_Impostos	[lvl_Linha_Nova] = lvdc_ICMS + lvdc_PIS_COFINS
		End If				
	End If
Next

Return lvb_Sucesso
end function

public subroutine wf_imprimir_conjunto_filiais ();Integer lvi_Row, &
        lvi_Filial, &
		  lvi_Linhas
		  
String lvs_Fantasia

ivo_Filiais = Create uo_ge216_Filiais
 
uo_ge216_Filiais lvo_Filiais
lvo_Filiais = Create uo_ge216_Filiais

OpenWithParm(w_ge216_selecao_filiais, lvo_Filiais)

//lvo_Filiais = Message.PowerObjectParm
lvi_Linhas = Message.DoubleParm	

If IsNull(lvo_Filiais) Then Return

dw_1.Object.Filial[1] = "C"
ivb_Imprimir_Conjunto = True

//lvi_Linhas = UpperBound(lvo_Filiais.Cd_Filial[])

If lvi_Linhas > 0 Then
	
	io_Filial.of_Inicializa()
			
	dw_1.Object.cd_filial  	[1] = io_Filial.cd_filial
	dw_1.Object.nm_fantasia[1] = io_Filial.nm_fantasia
					
	For lvi_Row = 1 To lvi_Linhas
		
		lvs_Fantasia = ""
		
		lvi_Filial   = lvo_Filiais.Cd_Filial  [lvi_Row]
		lvs_Fantasia = lvo_Filiais.Nm_Fantasia[lvi_Row]
		
		ivs_Filiais = "(" + String(lvi_Filial) + ")"
		
		ivs_Impressao_Filial = String(lvi_Filial) + " - " + lvs_Fantasia
		
		ivo_Filiais.Cd_Filial[1] = lvi_Filial
		
		dw_2.Event ue_Retrieve()
		
		If dw_2.RowCount() > 0 Then
			Event ue_Print()
			
			gf_Delay(3)
		End If	
	Next
End If

Destroy(lvo_Filiais)
end subroutine

public subroutine wf_seta_mensagem_informacao ();String lvs_Tipo_Calculo
String lvs_Dt_Calc_PIS
String lvs_Calc_PIS
String lvs_Calc_COF

String lvs_Inf_Imposto
String lvs_Inf_CMV

Date lvdt_Mes_Rel

dw_1.AcceptText()
lvdt_Mes_Rel = dw_1.Object.mes_ano [1]

//Consulta tipo calculo PIS
Select coalesce(vl_parametro,'01/12/2024')
Into :lvs_Dt_Calc_PIS
from parametro_geral
Where cd_parametro = 'DH_INICIO_OPERACAO_PIS_COFINS'
Using SQLCa;

If SQLCa.SQLCode = -1 Then MessageBox('Falha', 'Falha ao buscar o parametro_geral DH_INICIO_OPERACAO_PIS_COFINS.~r~n'+SQLCa.SQLErrText,Exclamation!)
If SQLCa.SQLCode = 100 Then lvs_Dt_Calc_PIS = '01/12/2024'

//Consulta tipo calculo PIS
Select coalesce(vl_parametro,'1')
Into :lvs_Tipo_Calculo
from parametro_geral
Where cd_parametro = 'ID_CALCULO_PIS_COFINS'
Using SQLCa;

If SQLCa.SQLCode = -1 Then MessageBox('Falha', 'Falha ao buscar o parametro_geral ID_CALCULO_PIS_COFINS.~r~n'+SQLCa.SQLErrText,Exclamation!)
If SQLCa.SQLCode = 100 Then lvs_Tipo_Calculo = '1'

If Date(lvs_Dt_Calc_PIS) <= lvdt_Mes_Rel Then
	lvs_Inf_CMV = "$$HEX1$$c900$$ENDHEX$$ considerado o custo m$$HEX1$$e900$$ENDHEX$$dio de entrada da mercadoria, "+&
						"descontado dos impostos creditados (ICMS/PIS/COFINS)."
	
	Choose Case lvs_Tipo_Calculo
		Case '1' //Base PIS = Venda 
			lvs_Calc_PIS = "[ Valor Venda ] x [ Aliq. PIS ]"
			lvs_Calc_COF = "[ Valor Venda ] x [ Aliq. COFINS ]"
		Case '2' //Base PIS = Venda - ICMS
			lvs_Calc_PIS = "( [ Valor Venda ] - [Valor ICMS] ) x [ Aliq. PIS ]"
			lvs_Calc_COF = "( [ Valor Venda ] - [Valor ICMS] ) x [ Aliq. COFINS ]"
		Case '3' //Base PIS = Venda - ICMS
			lvs_Calc_PIS = "[ $$HEX1$$9403$$ENDHEX$$ Valor Agregado (Venda - CMV)] x [ Aliq. PIS ]"
			lvs_Calc_COF = "[ $$HEX1$$9403$$ENDHEX$$ Valor Agregado (Venda - CMV)] x [ Aliq. COFINS ]"
		Case '4' //Base PIS = Venda - CMV - ICMS 
			lvs_Calc_PIS = "( [ $$HEX1$$9403$$ENDHEX$$ Valor Agregado (Venda - CMV)] - [ Valor ICMS ] ) x [ Aliq. PIS ]"
			lvs_Calc_COF = "( [ $$HEX1$$9403$$ENDHEX$$ Valor Agregado (Venda - CMV)] - [ Valor ICMS ] ) x [ Aliq. PIS ]"
		Case '5' //Base PIS = CMV / (1 - % PIS)
			lvs_Calc_PIS = "( [ CMV ] / ( 1 - [ Aliq. PIS ] ) x [ Aliq. PIS ]"
			lvs_Calc_COF = "( [ CMV ] / ( 1 - [ Aliq. PIS ] ) x [ Aliq. PIS ]"
		Case Else //Zero
			lvs_Calc_PIS = ''
			lvs_Calc_COF = ''
	End Choose
Else 
	lvs_Inf_CMV = "$$HEX1$$c900$$ENDHEX$$ considerado o custo m$$HEX1$$e900$$ENDHEX$$dio de entrada da mercadoria, "+&
						"descontado do ICMS apenas. PIS e COFINS est$$HEX1$$e300$$ENDHEX$$o inclusos no CMV."
	lvs_Calc_PIS = ''
	lvs_Calc_COF = ''
End If
	
//Essa vari$$HEX1$$e100$$ENDHEX$$vel deve receber somente o texto que ser$$HEX1$$e100$$ENDHEX$$ exibido na coluna imposto
lvs_Inf_Imposto =	" + [ ICMS e ST ] = [ CMV Gerencial ] - [ CMV ]" + &
				IIF(lvs_Calc_PIS<>'', "~r~n + [ PIS ] = "+ lvs_Calc_PIS, '') + &
				IIF(lvs_Calc_PIS<>'', "~r~n + [ COFINS ] = "+ lvs_Calc_COF, '')

//Essa vari$$HEX1$$e100$$ENDHEX$$vel pode receber a explica$$HEX2$$e700e300$$ENDHEX$$o de mais colunas al$$HEX1$$e900$$ENDHEX$$m da coluna imposto
// ele ser$$HEX1$$e100$$ENDHEX$$ exibido no bot$$HEX1$$e300$$ENDHEX$$o de interroga$$HEX2$$e700e300$$ENDHEX$$o
ivs_Info =  "Coluna CMV: ~r~n" + lvs_Inf_CMV + "~r~n~r~n" + &
				"Coluna IMPOSTO: ~r~n"+lvs_Inf_Imposto

dw_2.Object.vl_impostos.Tooltip.Enabled = True
dw_2.Object.vl_impostos.Tooltip.Title = "Valor Imposto"
dw_2.Object.vl_impostos.Tooltip.Tip = lvs_Inf_Imposto

pb_info.Visible = True
end subroutine

on w_ge284_rentabilidade_grupo_gerencial.create
int iCurrent
call super::create
this.pb_info=create pb_info
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_info
end on

on w_ge284_rentabilidade_grupo_gerencial.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_info)
end on

event ue_postopen;call super::ue_postopen;DateTime lvdh_Movimento

gf_Data_Parametro(Ref lvdh_Movimento)

dw_1.Object.Mes_Ano[1] = gf_Primeiro_dia_Mes(Date(lvdh_Movimento))

This.ivm_Menu.ivb_Permite_Imprimir = True

Post wf_seta_mensagem_informacao()
end event

event open;call super::open;//ivo_Filiais = Create uo_ge216_Filiais

io_Filial = Create uo_filial
end event

event close;call super::close;Destroy(ivo_Filiais)
Destroy(io_Filial)
end event

event ue_preopen;call super::ue_preopen;MaxWidth = 5065
MaxHeight = 1725
end event

event ue_printimmediate;//override
dw_3.Event ue_PrintImmediate()
end event

event ue_print;//override
dw_3.Event ue_Print()
end event

event ue_saveas;call super::ue_saveas;dw_3.Event ue_SaveAs()
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge284_rentabilidade_grupo_gerencial
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge284_rentabilidade_grupo_gerencial
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge284_rentabilidade_grupo_gerencial
integer x = 14
integer y = 320
integer width = 3575
integer height = 1464
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge284_rentabilidade_grupo_gerencial
integer x = 14
integer y = 0
integer width = 1710
integer height = 316
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge284_rentabilidade_grupo_gerencial
integer x = 46
integer y = 56
integer height = 248
string dataobject = "dw_ge284_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;dw_2.Event ue_Reset()

If dwo.Name = 'filial' Then
	
	Choose Case Data 
		Case 'C'
			ivb_imprimir_conjunto = false
			wf_Seleciona_Filiais()
		Case 'I'
			Destroy(ivo_Filiais)
			wf_Imprimir_Conjunto_Filiais()
		Case 'T'
			Destroy(ivo_Filiais)
	End Choose	
End If

If dwo.Name = "nm_fantasia" Then
	If Not IsNull(Data) And Trim(Data) <> "" Then
		If Data <> io_Filial.Nm_Fantasia Then
			Return 1
		End If
	Else
		io_Filial.of_Inicializa()
		
		This.Object.Cd_Filial		[1] = io_Filial.Cd_Filial
		This.Object.Nm_Filial		[1] = io_Filial.Nm_Fantasia
	End If
End If
end event

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	If This.GetColumnName() = "nm_fantasia" Then
		io_Filial.of_Localiza_Filial(This.GetText())
		
		If Not io_Filial.Localizada Then
			io_Filial.of_Inicializa()
		End If
		
		This.Object.Cd_Filial			[1]	= io_Filial.Cd_Filial
		This.Object.Nm_Fantasia		[1]	= io_Filial.Nm_Fantasia
		
		This.Object.filial				[1] = "T"
	End If
End If
end event

event dw_1::editchanged;call super::editchanged;dw_2.Event ue_Reset()

If dwo.Name = "nm_fantasia" Then
	If Not IsNull(Data) And Trim(Data) <> "" Then
		If Data <> io_Filial.Nm_Fantasia Then
			Return 1
		End If
	Else
		io_Filial.of_Inicializa()
		
		This.Object.Cd_Filial		[1] = io_Filial.Cd_Filial
		This.Object.Nm_Fantasia	[1] = io_Filial.Nm_Fantasia
	End If
End If
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge284_rentabilidade_grupo_gerencial
integer x = 41
integer y = 372
integer width = 3506
integer height = 1384
string dataobject = "dw_ge284_lista"
boolean hscrollbar = true
end type

event dw_2::ue_recuperar;//OverRide

Date lvdt_Periodo

Long ll_Filial

String lvs_Tipo_Filiais

dw_1.AcceptText()

lvdt_Periodo     = dw_1.Object.Mes_Ano	[1]
lvs_Tipo_Filiais = dw_1.Object.Filial		[1]
ll_Filial			= dw_1.Object.Cd_Filial	[1]

This.SetRedraw(False)
This.Reset()

// T - Todas as Filiais
// C = Conjunto de filiais definido

If Not IsNull(ll_Filial) And ll_Filial > 0 Then
	If Not wf_Recupera_Informacoes("C", lvdt_Periodo, "ds_ge284_grupo_filiais") Then Return -1
	
Else

	If lvs_Tipo_Filiais = 'T' Then	
		If Not wf_Recupera_Informacoes("T", lvdt_Periodo, "ds_ge284_grupo_geral") Then Return -1
	Else
		If ivs_Filiais = "" Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o foi selecionada nenhuma filial.",Information!)
			Return -1
		End If
	
		If Not wf_Recupera_Informacoes("C", lvdt_Periodo, "ds_ge284_grupo_filiais") Then Return -1
	End If
End If

Return This.RowCount()
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_linhas > 0 Then
	
	This.ivm_Menu.mf_SalvarComo(True)
	
	wf_Atualiza_Totais()
	
	This.Sort()
	This.GroupCalc()
	
Else
	This.ivm_Menu.mf_SalvarComo(False)
End If

wf_seta_mensagem_informacao()

This.SetRedraw(True)

Return AncestorReturnValue
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge284_rentabilidade_grupo_gerencial
integer x = 2985
integer y = 52
integer height = 164
integer taborder = 50
string dataobject = "dw_ge284_relatorio"
end type

event dw_3::ue_preprint;call super::ue_preprint;Long ll_Filial

dw_1.AccepTtext()

This.Object.Mes_Ano_t.Text = String(dw_1.Object.Mes_Ano[1], "mm/yyyy")

ll_Filial = dw_1.Object.Cd_Filial[1]

If Not IsNull(ll_Filial) And ll_Filial > 0 Then
	If ivb_Imprimir_Conjunto Then
		This.Object.Filiais_t.Text = ivs_Impressao_Filial
	Else
		This.Object.Filiais_t.Text = String(ll_Filial)
	End If
Else
	
	//Todas
	If dw_1.Object.Filial[1] = "T" Then
		This.Object.Filiais_t.Text = "TODAS"
	Else
		//Conjunto
		If ivb_Imprimir_Conjunto Then
			This.Object.Filiais_t.Text = ivs_Impressao_Filial
		Else
			This.Object.Filiais_t.Text = ivs_Filiais
		End If
	End If
End If

Return AncestorReturnValue
end event

type pb_info from picturebutton within w_ge284_rentabilidade_grupo_gerencial
boolean visible = false
integer x = 1746
integer y = 176
integer width = 174
integer height = 148
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\information_1.png"
alignment htextalign = left!
end type

event clicked;If ivs_Info<>'' Then
	MessageBox("Informa$$HEX2$$e700e300$$ENDHEX$$o", ivs_Info)
End If
end event

