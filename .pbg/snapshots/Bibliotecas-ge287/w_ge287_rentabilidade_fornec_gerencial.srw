HA$PBExportHeader$w_ge287_rentabilidade_fornec_gerencial.srw
forward
global type w_ge287_rentabilidade_fornec_gerencial from dc_w_selecao_lista_relatorio
end type
type pb_info from picturebutton within w_ge287_rentabilidade_fornec_gerencial
end type
end forward

global type w_ge287_rentabilidade_fornec_gerencial from dc_w_selecao_lista_relatorio
string tag = "w_ge287_rentabilidade_fornec_gerencial"
integer width = 3634
integer height = 1996
string title = "GE287 - Relat$$HEX1$$f300$$ENDHEX$$rio por Fornecedor (Custo Gerencial)"
long backcolor = 80269524
pb_info pb_info
end type
global w_ge287_rentabilidade_fornec_gerencial w_ge287_rentabilidade_fornec_gerencial

type variables
String ivs_filiais
String ivs_Info = '' //Mensagem bot$$HEX1$$e300$$ENDHEX$$o info

uo_ge216_Filiais ivo_Filiais

uo_produto ivo_produto

uo_fornecedor ivo_fornecedor


end variables

forward prototypes
public subroutine wf_seleciona_filiais ()
public function boolean wf_recupera_informacoes (string ps_tipo, date pdt_periodo, string ps_nome_dw)
public function boolean wf_atualiza_informacoes_filiais (datastore pds_1, date pdt_periodo)
public function boolean wf_atualiza_informacoes (datastore pds_1, date pdt_periodo)
public subroutine wf_atualiza_totais ()
public function boolean wf_atualiza_filial (datastore pds_1, date pdt_periodo, long al_filial)
public subroutine wf_seta_mensagem_informacao ()
end prototypes

public subroutine wf_seleciona_filiais ();Integer lvi_Linhas, &
        lvi_Row, &
		  lvi_Filial

ivs_Filiais = "("

ivo_Filiais    = Create uo_ge216_Filiais

OpenWithParm(w_ge216_selecao_filiais, ivo_Filiais)

//ivo_Filiais = Message.PowerObjectParm

lvi_linhas = Message.DoubleParm

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

Long 	lvl_Total, &
     	lvl_Produto,&
   	    lvl_Divisao_Forn
	  
String lvs_Fornecedor

dc_uo_ds_base lvds_1
lvds_1 = Create dc_uo_ds_base

If Not lvds_1.Of_ChangeDataObject(ps_Nome_Dw) Then Return False

dw_1.AcceptText()

lvl_Produto    		= dw_1.Object.Cd_Produto   			[1]
lvs_Fornecedor 	= dw_1.Object.Cd_Fornecedor			[1]
// Adicionado para novo filtro: Divis$$HEX1$$e300$$ENDHEX$$o
lvl_Divisao_Forn	= dw_1.Object.nr_divisao_fornecedor[1]

If Not IsNull(lvl_Produto) Then
	lvds_1.of_AppendWhere("r.cd_produto = " + String(lvl_Produto), 1)
	If pdt_Periodo < date('2007/08/01') Then
		lvds_1.of_AppendWhere("r.cd_produto = " + String(lvl_Produto), 3)
	End If
End If

If Not IsNull(lvs_Fornecedor) and lvs_Fornecedor <> "" Then
	lvds_1.of_AppendWhere("g.cd_fornecedor_usual = '" + lvs_Fornecedor + "'", 1)
	If pdt_Periodo < date('2007/08/01') Then
		lvds_1.of_AppendWhere("g.cd_fornecedor_usual = '" + lvs_Fornecedor + "'", 3)
	End If
End If

// Adicionado para novo filtro: Divis$$HEX1$$e300$$ENDHEX$$o
If Not IsNull(lvl_Divisao_Forn) And lvl_Divisao_Forn > 0 Then
   	lvds_1.Of_appendwhere(" r.cd_produto in ( select cd_produto" + &
									 " from fornecedor_divisao_produto" + &
									 " where cd_fornecedor = '" + string(lvs_Fornecedor) + "'" + &
									 " and nr_divisao = " + String(lvl_Divisao_Forn) + ")")
	
End If

// "C" - conjunto de filiais
If ps_Tipo = "C" Then
	If Not wf_Atualiza_Informacoes_Filiais(lvds_1, pdt_Periodo) Then Return lvb_Sucesso = False
Else	
	If Not wf_Atualiza_Informacoes(lvds_1, pdt_Periodo) Then Return lvb_Sucesso = False
End If

Destroy(lvds_1)
Return lvb_Sucesso
end function

public function boolean wf_atualiza_informacoes_filiais (datastore pds_1, date pdt_periodo);Boolean lvb_Sucesso = True

Long lvl_Total, &
     lvl_Contador, &
	  lvl_Filial

lvl_Total = UpperBound(ivo_Filiais.Cd_Filial)

Open(w_Aguarde)

For lvl_Contador = 1 To lvl_Total
	lvl_Filial = ivo_Filiais.Cd_Filial[lvl_Contador]
	
	w_Aguarde.Title = "Atualizando Informa$$HEX2$$e700f500$$ENDHEX$$es da Filial '" + String(lvl_Filial) + "' (" + String(lvl_Contador) + " de " + String(lvl_Total) + ")"
	
	If Not wf_Atualiza_Filial(pds_1, pdt_Periodo, lvl_Filial) Then 
		lvb_Sucesso = False
		Exit
	End If
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

Open(w_Aguarde)
w_Aguarde.Title = "Recuperando Informa$$HEX2$$e700f500$$ENDHEX$$es..."

lvl_Total = pds_1.Retrieve(pdt_Periodo)

If lvl_Total > 0 Then
	w_Aguarde.Title = "Atualizando Informa$$HEX2$$e700f500$$ENDHEX$$es..."
	w_Aguarde.uo_Progress.of_SetMax(lvl_Total)
	
	For lvl_Row = 1 To pds_1.RowCount()
		lvl_Qtde        = pds_1.Object.Qt_Venda     [lvl_Row] 
		lvdc_Vendas     = pds_1.Object.Vl_Venda     [lvl_Row]
		lvdc_CMV        = pds_1.Object.Vl_Cmv       [lvl_Row]
		lvdc_Comissao   = pds_1.Object.Vl_Comissao  [lvl_Row]
		lvdc_ICMS       = pds_1.Object.Vl_ICMS      [lvl_Row]
		lvdc_PIS_COFINS = pds_1.Object.Vl_PIS_COFINS[lvl_Row]
				
		If lvdc_Vendas <> 0 Then
			lvl_Linha_Nova = dw_2.InsertRow(0)
			
			dw_2.Object.Cd_Produto   [lvl_Linha_Nova] = pds_1.Object.Cd_Produto   [lvl_Row]
			dw_2.Object.De_Produto   [lvl_Linha_Nova] = pds_1.Object.De_Produto   [lvl_Row]			
			dw_2.Object.Cd_Fornecedor[lvl_Linha_Nova] = pds_1.Object.Cd_Fornecedor[lvl_Row]			
			dw_2.Object.Nm_Fornecedor[lvl_Linha_Nova] = pds_1.Object.Nm_Fornecedor[lvl_Row]			
			dw_2.Object.Qt_Vendas    [lvl_Linha_Nova] = lvl_Qtde
			dw_2.Object.Vl_Vendas    [lvl_Linha_Nova] = lvdc_Vendas
			dw_2.Object.Vl_Cmv       [lvl_Linha_Nova] = lvdc_CMV
			dw_2.Object.Vl_Comissao  [lvl_Linha_Nova] = lvdc_Comissao
			dw_2.Object.Vl_Impostos  [lvl_Linha_Nova] = lvdc_ICMS + lvdc_PIS_COFINS
		End If		
		
		w_Aguarde.uo_Progress.of_SetProgress(lvl_Row)
	Next
End If

Close(w_Aguarde)
Return True
end function

public subroutine wf_atualiza_totais ();Long lvl_Row

Decimal{2} lvdc_Vendas, &
           lvdc_Cmv, &
			  lvdc_Comissao, &
			  lvdc_Impostos, &
			  lvdc_Total_Vendas, &
			  lvdc_Rentabilidade

Open(w_Aguarde)
w_Aguarde.Title = "Atualizando os Totais..."

w_Aguarde.uo_Progress.of_SetMax(dw_2.RowCount())

lvdc_Total_Vendas = dw_2.Object.Sum_Vl_Vendas[1]

For lvl_Row = 1 To dw_2.RowCount()
	lvdc_Vendas   = dw_2.Object.Vl_Vendas  [lvl_Row]
	lvdc_Cmv      = dw_2.Object.Vl_Cmv     [lvl_Row]
	lvdc_Comissao = dw_2.Object.Vl_Comissao[lvl_Row]
	lvdc_Impostos = dw_2.Object.Vl_Impostos[lvl_Row]
	
	lvdc_Rentabilidade = lvdc_Vendas - lvdc_CMV - lvdc_Comissao - lvdc_Impostos

	dw_2.Object.Perc_Vendas     [lvl_Row] = Round(lvdc_Vendas / lvdc_Total_Vendas * 100, 2)
	dw_2.Object.Vl_Rentabilidade[lvl_Row] = lvdc_Rentabilidade
	
	If lvdc_Vendas > 0 Then
		dw_2.Object.Perc_Cmv          [lvl_Row] = Round(lvdc_Cmv           / lvdc_Vendas * 100, 2)
		dw_2.Object.Perc_Comissao     [lvl_Row] = Round(lvdc_Comissao      / lvdc_Vendas * 100, 2)
		dw_2.Object.Perc_Impostos     [lvl_Row] = Round(lvdc_Impostos      / lvdc_Vendas * 100, 2)
		dw_2.Object.Perc_Rentabilidade[lvl_Row] = Round(lvdc_Rentabilidade / lvdc_Vendas * 100, 2)
	Else
		dw_2.Object.Perc_Cmv          [lvl_Row] = 0
		dw_2.Object.Perc_Comissao     [lvl_Row] = 0
		dw_2.Object.Perc_Impostos     [lvl_Row] = 0
		dw_2.Object.Perc_Rentabilidade[lvl_Row] = 0
	End If
		
	w_Aguarde.uo_Progress.of_SetProgress(lvl_Row)
Next

Close(w_Aguarde)
end subroutine

public function boolean wf_atualiza_filial (datastore pds_1, date pdt_periodo, long al_filial);Boolean lvb_Sucesso = True

Long lvl_Linha_Nova, &
     lvl_Contador, &
	  lvl_Qtde, &
	  lvl_Total, &
	  lvl_Find, &
	  lvl_Produto

Decimal{2} lvdc_Vendas, &
			  lvdc_CMV, &
			  lvdc_Comissao, &
			  lvdc_ICMS, &
			  lvdc_PIS_COFINS
			  
String lvs_De_Produto, &
		 lvs_Find

lvl_Total = pds_1.Retrieve(pdt_Periodo, al_Filial)

w_Aguarde.uo_Progress.of_SetMax(lvl_Total)

For lvl_Contador = 1 To lvl_Total
	lvl_Produto     = pds_1.Object.Cd_Produto   [lvl_Contador]
	lvs_De_Produto  = pds_1.Object.De_Produto   [lvl_Contador]
	lvl_Qtde        = pds_1.Object.Qt_Venda     [lvl_Contador] 
	lvdc_Vendas     = pds_1.Object.Vl_Venda     [lvl_Contador]
	lvdc_CMV        = pds_1.Object.Vl_Cmv       [lvl_Contador]
	lvdc_Comissao   = pds_1.Object.Vl_Comissao  [lvl_Contador]
	lvdc_ICMS       = pds_1.Object.Vl_ICMS      [lvl_Contador]
	lvdc_PIS_COFINS = pds_1.Object.Vl_PIS_COFINS[lvl_Contador]
	
	lvs_Find = "cd_produto = " + String(lvl_Produto)
	
	lvl_Find = dw_2.Find(lvs_Find, 1, dw_2.RowCount())
	
	If lvl_Find < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no find ao localizar o produto: " + String(lvl_Produto)+ "'", StopSign!)
		lvb_Sucesso = False
		Exit
	End If
	
	If lvl_Find > 0 Then
		dw_2.Object.Qt_Vendas  [lvl_Find] = dw_2.Object.Qt_Vendas  [lvl_Find] + lvl_Qtde
		dw_2.Object.Vl_Vendas  [lvl_Find] = dw_2.Object.Vl_Vendas  [lvl_Find] + lvdc_Vendas
		dw_2.Object.Vl_Cmv     [lvl_Find] = dw_2.Object.Vl_Cmv     [lvl_Find] + lvdc_CMV
		dw_2.Object.Vl_Comissao[lvl_Find] = dw_2.Object.Vl_Comissao[lvl_Find] + lvdc_Comissao
		dw_2.Object.Vl_Impostos[lvl_Find] = dw_2.Object.Vl_Impostos[lvl_Find] + lvdc_ICMS + lvdc_PIS_COFINS
	Else
		If lvdc_Vendas <> 0 Then
			lvl_Linha_Nova = dw_2.InsertRow(0)
			
			dw_2.Object.Cd_Produto   [lvl_Linha_Nova] = lvl_Produto
			dw_2.Object.De_Produto   [lvl_Linha_Nova] = lvs_De_Produto			
			dw_2.Object.Cd_Fornecedor[lvl_Linha_Nova] = pds_1.Object.Cd_Fornecedor[lvl_Contador]			
			dw_2.Object.Nm_Fornecedor[lvl_Linha_Nova] = pds_1.Object.Nm_Fornecedor[lvl_Contador]						
			dw_2.Object.Qt_Vendas    [lvl_Linha_Nova] = lvl_Qtde
			dw_2.Object.Vl_Vendas    [lvl_Linha_Nova] = lvdc_Vendas
			dw_2.Object.Vl_Cmv       [lvl_Linha_Nova] = lvdc_CMV
			dw_2.Object.Vl_Comissao  [lvl_Linha_Nova] = lvdc_Comissao
			dw_2.Object.Vl_Impostos  [lvl_Linha_Nova] = lvdc_ICMS + lvdc_PIS_COFINS
		End If				
	End If
	
	w_Aguarde.uo_Progress.of_SetProgress(lvl_Contador)
Next

w_Aguarde.uo_Progress.of_Reset()

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

on w_ge287_rentabilidade_fornec_gerencial.create
int iCurrent
call super::create
this.pb_info=create pb_info
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_info
end on

on w_ge287_rentabilidade_fornec_gerencial.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_info)
end on

event ue_postopen;call super::ue_postopen;DateTime lvdh_Movimento

gf_Data_Parametro(Ref lvdh_Movimento)

dw_1.Object.Mes_Ano[1] = gf_Primeiro_dia_Mes(Date(lvdh_Movimento))

gf_ge003_lista_divisao_fornecedor(dw_1, "", 1)

This.ivm_Menu.ivb_Permite_Imprimir = True

This.ivm_Menu.mf_Recuperar(True)

Post wf_seta_mensagem_informacao()


end event

event open;call super::open;//ivo_Filiais    = Create uo_Selecao_Filiais
ivo_Produto    = Create uo_Produto
ivo_Fornecedor = Create uo_Fornecedor

end event

event close;call super::close;Destroy(ivo_Filiais)
Destroy(ivo_Produto)
Destroy(ivo_Fornecedor)
end event

event ue_print;//override
dw_3.Event ue_Print()
end event

event ue_printimmediate;//override
dw_3.Event ue_PrintImmediate()
end event

event ue_preopen;call super::ue_preopen;MaxWidth = 5065
MaxHeight = 9999
end event

event ue_saveas;call super::ue_saveas;dw_3.Event ue_SaveAs()
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge287_rentabilidade_fornec_gerencial
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge287_rentabilidade_fornec_gerencial
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge287_rentabilidade_fornec_gerencial
integer x = 14
integer y = 512
integer width = 3575
integer height = 1284
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge287_rentabilidade_fornec_gerencial
integer x = 14
integer y = 0
integer width = 1970
integer height = 496
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge287_rentabilidade_fornec_gerencial
integer x = 32
integer y = 60
integer width = 1943
integer height = 408
string dataobject = "dw_ge287_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name 
	Case "filial"
		If Data = "C" Then
			wf_Seleciona_Filiais()
		End If
		
		If Data = 'T' Then
			Destroy(ivo_Filiais)
		End If
		
	Case "de_produto"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Produto.ivs_Descricao_Apresentacao_Venda Then
				Return 1
			End If
		Else
			SetNull(ivo_Produto.Cd_Produto)
			ivo_Produto.ivs_Descricao_Apresentacao_Venda = ""
			
			This.Object.Cd_Produto[1] = ivo_Produto.Cd_Produto
			This.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
		End If
		
	Case "nm_fornecedor"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Fornecedor.Nm_Razao_Social Then
				Return 1
			End If
		Else
			ivo_Fornecedor.of_Inicializa()
			
			This.Object.Cd_Fornecedor[1] = ivo_Fornecedor.Cd_Fornecedor
			This.Object.Nm_Fornecedor[1] = ivo_Fornecedor.Nm_Razao_Social
		End If	
		// Adicionado para novo filtro: Divis$$HEX1$$e300$$ENDHEX$$o
		gf_ge003_lista_divisao_fornecedor(dw_1, ivo_Fornecedor.Cd_Fornecedor, 1)

End Choose

This.ivm_Menu.mf_Recuperar(True)
end event

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)


end event

event dw_1::ue_key;String lvs_Coluna

If Key = KeyEnter! Then
	lvs_Coluna = This.GetColumnName()
	
	Choose Case lvs_Coluna 
		Case "de_produto"
			ivo_Produto.of_Localiza_Produto(This.GetText())
			
			If ivo_Produto.Localizado Then
				This.Object.Cd_Produto[1] = ivo_Produto.Cd_Produto
				This.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
			End If
			
		Case "nm_fornecedor"
			ivo_Fornecedor.of_Localiza_Fornecedor(This.GetText())
			
			If ivo_Fornecedor.Localizado Then
				This.Object.Cd_Fornecedor[1] = ivo_Fornecedor.Cd_Fornecedor
				This.Object.Nm_Fornecedor[1] = ivo_Fornecedor.Nm_Razao_Social			
			End If
			
			// Adicionado para novo filtro: Divis$$HEX1$$e300$$ENDHEX$$o
			gf_ge003_lista_divisao_fornecedor(dw_1, ivo_Fornecedor.Cd_Fornecedor, 1)
	End Choose
	This.ivm_Menu.mf_Recuperar(True)
End If
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Produto) Then
	This.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
End If

If IsValid(ivo_Fornecedor) Then
	This.Object.Nm_Fornecedor[1] = ivo_Fornecedor.Nm_Razao_Social
End If
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge287_rentabilidade_fornec_gerencial
integer x = 46
integer y = 564
integer width = 3506
integer height = 1204
string dataobject = "dw_ge287_lista"
boolean hscrollbar = true
end type

event dw_2::ue_recuperar;//OverRide

Date lvdt_Periodo

String lvs_Tipo_Filiais

dw_1.AcceptText()

lvdt_Periodo     = dw_1.Object.Mes_Ano[1]
lvs_Tipo_Filiais = dw_1.Object.Filial[1]

This.SetRedraw(False)
This.Reset()

// T - Todas as Filiais
// C = Conjunto de filiais definido

If lvs_Tipo_Filiais = 'T' Then	
	If Not wf_Recupera_Informacoes(lvs_Tipo_Filiais, lvdt_Periodo, "ds_ge287_produto_geral") Then Return -1
Else
	If ivs_Filiais = "" Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o foi selecionada nenhuma filial.",Information!)
		Return -1
	End If

	If Not wf_Recupera_Informacoes(lvs_Tipo_Filiais, lvdt_Periodo, "ds_ge287_produto_filiais") Then Return -1
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

event dw_2::constructor;call super::constructor;String lvs_Coluna_Produto[], &
       lvs_Nome_Produto[]
		 		 
lvs_Coluna_Produto = {"cd_produto", &
                     			 "de_produto", &
							 "qt_vendas", &
							 "vl_vendas", &
							 "perc_vendas", &
							 "vl_cmv", &
							 "perc_cmv", &
							 "vl_comissao", &
							 "perc_comissao", &
							  "vl_impostos", &
							 "perc_impostos", &
							 "vl_rentabilidade", &
							  "perc_rentabilidade"}
							 
							 
lvs_Nome_Produto = {"C$$HEX1$$f300$$ENDHEX$$digo", &
						  "Descri$$HEX2$$e700e300$$ENDHEX$$o", &
						  "Vendas Unid.", &
						  "Vendas Valor", &
						  "Vendas %", &
						  "CMV Valor", &
						  "CMV %", &
						  "Comiss$$HEX1$$e300$$ENDHEX$$o Valor", &
						 "Comiss$$HEX1$$e300$$ENDHEX$$o %", &			
						  "Impostos Valor", &
						  "Impostos %", &
						  "Rentabilidade Valor", &
						  "Rentabilidade %"}	
						  

This.of_SetSort(lvs_Coluna_Produto, lvs_Nome_Produto)

This.of_SetFilter(lvs_Coluna_Produto, lvs_Nome_Produto)
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge287_rentabilidade_fornec_gerencial
integer x = 3118
integer y = 12
integer height = 164
string dataobject = "dw_ge287_relatorio"
end type

event dw_3::ue_preprint;call super::ue_preprint;dw_1.AccepTtext()

dw_3.Object.Mes_Ano_t.Text = String(dw_1.Object.Mes_Ano[1], "mm/yyyy")

If dw_1.Object.Filial[1] = "T" Then
	dw_3.Object.Filiais_t.Text = "TODAS"	
Else
	dw_3.Object.Filiais_t.Text = ivs_Filiais
End If

Return AncestorReturnValue
end event

type pb_info from picturebutton within w_ge287_rentabilidade_fornec_gerencial
boolean visible = false
integer x = 2011
integer y = 348
integer width = 174
integer height = 148
integer taborder = 60
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

