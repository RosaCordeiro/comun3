HA$PBExportHeader$w_ge286_rentabilidade_categoria_gerencia.srw
forward
global type w_ge286_rentabilidade_categoria_gerencia from dc_w_selecao_lista_relatorio
end type
type pb_info from picturebutton within w_ge286_rentabilidade_categoria_gerencia
end type
end forward

global type w_ge286_rentabilidade_categoria_gerencia from dc_w_selecao_lista_relatorio
string tag = "w_ge286_rentabilidade_categoria_gerencia"
integer width = 3634
integer height = 1908
string title = "GE286 - Relat$$HEX1$$f300$$ENDHEX$$rio por Categoria (Custo Gerencial)"
long backcolor = 80269524
pb_info pb_info
end type
global w_ge286_rentabilidade_categoria_gerencia w_ge286_rentabilidade_categoria_gerencia

type variables
String ivs_filiais
String ivs_Info = '' //Mensagem bot$$HEX1$$e300$$ENDHEX$$o info

uo_ge216_Filiais ivo_Filiais
end variables

forward prototypes
public subroutine wf_seleciona_filiais ()
public function boolean wf_recupera_informacoes (string ps_tipo, date pdt_periodo, string ps_nome_dw)
public subroutine wf_atualiza_totais ()
public function boolean wf_atualiza_informacoes_filiais (datastore pds_1, date pdt_periodo)
public function boolean wf_atualiza_informacoes (datastore pds_1, date pdt_periodo)
public function boolean wf_atualiza_filial (datastore pds_1, date pdt_periodo, long al_filial)
public subroutine wf_seta_mensagem_informacao ()
end prototypes

public subroutine wf_seleciona_filiais ();Integer lvi_Linhas, &
        lvi_Row, &
		  lvi_Filial

ivs_Filiais = "("

ivo_Filiais = Create uo_ge216_Filiais

OpenWithParm(w_ge216_selecao_filiais, ivo_Filiais)

//ivo_Filiais = Message.PowerObjectParm
lvi_Linhas = Message.DoubleParm	

If IsNull(ivo_Filiais) Then 
	ivs_Filiais = ""
	Return
End If

//lvi_Linhas = UpperBound(ivo_Filiais.Cd_Filial)

For lvi_Row = 1 To lvi_Linhas
	
	lvi_Filial = ivo_Filiais.Cd_Filial[lvi_Row]
	
	ivs_Filiais += String(lvi_Filial)
	
	If lvi_Row <> lvi_Linhas Then
		ivs_Filiais += ","
	End If
Next

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
			  lvdc_Rentabilidade

lvdc_Total_Vendas = dw_2.Object.Sum_Vl_Vendas[1]

For lvl_Row = 1 To dw_2.RowCount()
	lvdc_Vendas		= dw_2.Object.Vl_Vendas	[lvl_Row]
	lvdc_Cmv		= dw_2.Object.Vl_Cmv		[lvl_Row]
	lvdc_Comissao	= dw_2.Object.Vl_Comissao[lvl_Row]
	lvdc_Impostos	= dw_2.Object.Vl_Impostos	[lvl_Row]
	
	lvdc_Rentabilidade = lvdc_Vendas - lvdc_CMV - lvdc_Comissao - lvdc_Impostos

	dw_2.Object.Perc_Vendas		[lvl_Row] = Round(lvdc_Vendas / lvdc_Total_Vendas * 100, 2)
	dw_2.Object.Vl_Rentabilidade	[lvl_Row] = lvdc_Rentabilidade
	
	If lvdc_Vendas > 0 Then
		dw_2.Object.Perc_Cmv				[lvl_Row] = Round(lvdc_Cmv           / lvdc_Vendas * 100, 2)
		dw_2.Object.Perc_Comissao		[lvl_Row] = Round(lvdc_Comissao      / lvdc_Vendas * 100, 2)
		dw_2.Object.Perc_Impostos			[lvl_Row] = Round(lvdc_Impostos      / lvdc_Vendas * 100, 2)
		dw_2.Object.Perc_Rentabilidade	[lvl_Row] = Round(lvdc_Rentabilidade / lvdc_Vendas * 100, 2)
	Else
		dw_2.Object.Perc_Cmv				[lvl_Row] = 0
		dw_2.Object.Perc_Comissao		[lvl_Row] = 0
		dw_2.Object.Perc_Impostos			[lvl_Row] = 0
		dw_2.Object.Perc_Rentabilidade	[lvl_Row] = 0
	End If
Next
end subroutine

public function boolean wf_atualiza_informacoes_filiais (datastore pds_1, date pdt_periodo);Boolean lvb_Sucesso = True

Long lvl_Total, &
     lvl_Contador, &
	  lvl_Filial

lvl_Total = UpperBound(ivo_Filiais.Cd_Filial)

Open(w_Aguarde)
w_Aguarde.uo_Progress.of_SetMax(lvl_Total)

For lvl_Contador = 1 To lvl_Total
	lvl_Filial = ivo_Filiais.Cd_Filial[lvl_Contador]
	
	w_Aguarde.Title = "Atualizando Informa$$HEX2$$e700f500$$ENDHEX$$es da Filial '" + String(lvl_Filial) + "' (" + String(lvl_Contador) + " de " + String(lvl_Total) + ")"
	
	If Not wf_Atualiza_Filial(pds_1, pdt_Periodo, lvl_Filial) Then 
		lvb_Sucesso = False
		Exit
	End If
	
	w_Aguarde.uo_Progress.of_SetProgress(lvl_Contador)
Next

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
	lvl_Qtde				= pds_1.Object.Qt_Venda		[lvl_Row] 
	lvdc_Vendas			= pds_1.Object.Vl_Venda		[lvl_Row]
	lvdc_CMV			= pds_1.Object.Vl_Cmv			[lvl_Row]
	lvdc_Comissao		= pds_1.Object.Vl_Comissao	[lvl_Row]
	lvdc_ICMS			= pds_1.Object.Vl_ICMS			[lvl_Row]
	lvdc_PIS_COFINS	= pds_1.Object.Vl_PIS_COFINS[lvl_Row]

	If lvdc_Vendas <> 0 Then
		lvl_Linha_Nova = dw_2.InsertRow(0)
		
		dw_2.Object.Cd_Grupo		[lvl_Linha_Nova] = pds_1.Object.Cd_Grupo		[lvl_Row]
		dw_2.Object.De_Grupo		[lvl_Linha_Nova] = pds_1.Object.De_Grupo		[lvl_Row]
		dw_2.Object.Cd_SubGrupo	[lvl_Linha_Nova] = pds_1.Object.Cd_SubGrupo	[lvl_Row]
		dw_2.Object.De_SubGrupo	[lvl_Linha_Nova] = pds_1.Object.De_SubGrupo	[lvl_Row]
		dw_2.Object.Cd_Categoria	[lvl_Linha_Nova] = pds_1.Object.Cd_Categoria	[lvl_Row]
		dw_2.Object.De_Categoria	[lvl_Linha_Nova] = pds_1.Object.De_Categoria	[lvl_Row]						
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
     lvl_Contador, &
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
		 lvs_Cd_SubGrupo, &
		 lvs_De_SubGrupo, &
		 lvs_Cd_Categoria, &
		 lvs_De_Categoria, &
		 lvs_Find

lvl_Total = pds_1.Retrieve(pdt_Periodo, al_Filial)

For lvl_Contador = 1 To pds_1.RowCount()
	lvs_Cd_Grupo		= pds_1.Object.Cd_Grupo			[lvl_Contador]
	lvs_De_Grupo		= pds_1.Object.De_Grupo			[lvl_Contador]
	lvs_Cd_SubGrupo	= pds_1.Object.Cd_SubGrupo       [lvl_Contador]
	lvs_De_SubGrupo	= pds_1.Object.De_SubGrupo       [lvl_Contador]
	lvs_Cd_Categoria	= pds_1.Object.Cd_Categoria		[lvl_Contador]
	lvs_De_Categoria	= pds_1.Object.De_Categoria		[lvl_Contador]
	lvl_Qtde				= pds_1.Object.Qt_Venda			[lvl_Contador] 
	lvdc_Vendas			= pds_1.Object.Vl_Venda			[lvl_Contador]
	lvdc_CMV			= pds_1.Object.Vl_Cmv				[lvl_Contador]
	lvdc_Comissao		= pds_1.Object.Vl_Comissao		[lvl_Contador]
	lvdc_ICMS			= pds_1.Object.Vl_ICMS				[lvl_Contador]
	lvdc_PIS_COFINS	= pds_1.Object.Vl_PIS_COFINS	[lvl_Contador]
	
	lvs_Find = "cd_grupo = '" + lvs_Cd_Grupo + "' and cd_subgrupo = '" + lvs_Cd_SubGrupo + "' and cd_categoria = '" + lvs_Cd_Categoria + "'"
	
	lvl_Find = dw_2.Find(lvs_Find, 1, dw_2.RowCount())
	
	If lvl_Find < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no find ao localizar o grupo: " + lvs_Cd_Grupo + "' , subgrupo: '" + lvs_Cd_SubGrupo + " e categoria: '" + lvs_Cd_Categoria + "'.", StopSign!)
		lvb_Sucesso = False
		Exit
	End If
		
	If lvl_Find > 0 Then
		dw_2.Object.Qt_Vendas		[lvl_Find] = dw_2.Object.Qt_Vendas		[lvl_Find] + lvl_Qtde
		dw_2.Object.Vl_Vendas		[lvl_Find] = dw_2.Object.Vl_Vendas  		[lvl_Find] + lvdc_Vendas
		dw_2.Object.Vl_Cmv			[lvl_Find] = dw_2.Object.Vl_Cmv			[lvl_Find] + lvdc_CMV
		dw_2.Object.Vl_Comissao	[lvl_Find] = dw_2.Object.Vl_Comissao	[lvl_Find] + lvdc_Comissao
		dw_2.Object.Vl_Impostos	[lvl_Find] = dw_2.Object.Vl_Impostos	[lvl_Find] + lvdc_ICMS + lvdc_PIS_COFINS
	Else
		If lvdc_Vendas <> 0 Then
			lvl_Linha_Nova = dw_2.InsertRow(0)
			
			dw_2.Object.Cd_Grupo		[lvl_Linha_Nova] = lvs_Cd_Grupo
			dw_2.Object.De_Grupo		[lvl_Linha_Nova] = lvs_De_Grupo
			dw_2.Object.Cd_SubGrupo	[lvl_Linha_Nova] = lvs_Cd_SubGrupo
			dw_2.Object.De_SubGrupo	[lvl_Linha_Nova] = lvs_De_SubGrupo
			dw_2.Object.Cd_Categoria	[lvl_Linha_Nova] = lvs_Cd_Categoria
			dw_2.Object.De_Categoria	[lvl_Linha_Nova] = lvs_De_Categoria			
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

on w_ge286_rentabilidade_categoria_gerencia.create
int iCurrent
call super::create
this.pb_info=create pb_info
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_info
end on

on w_ge286_rentabilidade_categoria_gerencia.destroy
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
end event

event close;call super::close;Destroy(ivo_Filiais)
end event

event ue_print;//override
dw_3.Event ue_Print()
end event

event ue_printimmediate;//override
dw_3.Event ue_PrintImmediate()
end event

event ue_preopen;call super::ue_preopen;MaxWidth = 4855
MaxHeight = 9999
end event

event ue_saveas;call super::ue_saveas;dw_3.Event ue_SaveAs()
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge286_rentabilidade_categoria_gerencia
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge286_rentabilidade_categoria_gerencia
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge286_rentabilidade_categoria_gerencia
integer x = 14
integer y = 256
integer width = 3575
integer height = 1452
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge286_rentabilidade_categoria_gerencia
integer x = 14
integer y = 0
integer width = 1271
integer height = 252
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge286_rentabilidade_categoria_gerencia
integer x = 46
integer y = 56
integer width = 1221
integer height = 184
string dataobject = "dw_ge286_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;If dwo.Name = 'filial' Then
	
	If Data = 'C' Then
		wf_Seleciona_Filiais()
	End If
	
	If Data = 'T' Then
		Destroy(ivo_Filiais)
	End If
	
End If
end event

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge286_rentabilidade_categoria_gerencia
integer x = 50
integer y = 308
integer width = 3506
integer height = 1372
string dataobject = "dw_ge286_lista"
boolean hscrollbar = true
end type

event dw_2::ue_recuperar;//OverRide

Date lvdt_Periodo

String lvs_Tipo_Filiais

dw_1.AcceptText()

lvdt_Periodo     = dw_1.Object.Mes_Ano	[1]
lvs_Tipo_Filiais = dw_1.Object.Filial		[1]

This.SetRedraw(False)
This.Reset()

// T - Todas as Filiais
// C = Conjunto de filiais definido


If lvs_Tipo_Filiais = 'T' Then	
	If Not wf_Recupera_Informacoes(lvs_Tipo_Filiais, lvdt_Periodo, "ds_ge286_categoria_geral") Then Return -1
Else
	If ivs_Filiais = "" Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o foi selecionada nenhuma filial.",Information!)
		Return -1
	End If

	If Not wf_Recupera_Informacoes(lvs_Tipo_Filiais, lvdt_Periodo, "ds_ge286_categoria_filiais") Then Return -1
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

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge286_rentabilidade_categoria_gerencia
integer x = 1371
integer y = 48
integer height = 164
string dataobject = "dw_ge286_relatorio"
end type

event dw_3::ue_preprint;call super::ue_preprint;dw_1.AccepTtext()

This.Object.Mes_Ano_t.Text = String(dw_1.Object.Mes_Ano[1], "mm/yyyy")

If dw_1.Object.Filial[1] = "T" Then
	This.Object.Filiais_t.Text = "TODAS"	
Else
	This.Object.Filiais_t.Text = ivs_Filiais
End If

Return AncestorReturnValue
end event

type pb_info from picturebutton within w_ge286_rentabilidade_categoria_gerencia
boolean visible = false
integer x = 1312
integer y = 100
integer width = 174
integer height = 148
integer taborder = 50
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

