HA$PBExportHeader$w_ge557_rel_analise_venda_det.srw
forward
global type w_ge557_rel_analise_venda_det from dc_w_selecao_lista_relatorio
end type
type pb_info from picturebutton within w_ge557_rel_analise_venda_det
end type
end forward

global type w_ge557_rel_analise_venda_det from dc_w_selecao_lista_relatorio
integer width = 5504
integer height = 2236
string title = "GE557 - Relat$$HEX1$$f300$$ENDHEX$$rio An$$HEX1$$e100$$ENDHEX$$lise de Vendas Detalhado"
pb_info pb_info
end type
global w_ge557_rel_analise_venda_det w_ge557_rel_analise_venda_det

type variables
uo_Filial ivo_Filial

uo_convenio ivo_Convenio

uo_cliente ivo_Cliente

uo_produto ivo_Produto

String ivs_Info = '' //Mensagem bot$$HEX1$$e300$$ENDHEX$$o info
end variables

forward prototypes
public subroutine wf_insere_padrao ()
public subroutine wf_seta_mensagem_informacao ()
end prototypes

public subroutine wf_insere_padrao ();DataWindowChild	ldwc_Child

/*UF Filial*/
ldwc_Child  = dw_1.of_InsertRow_DDDW("cd_uf" )			

ldwc_Child.SetItem(1, "cd_unidade_federacao", "TD")
ldwc_Child.SetItem(1, "nm_unidade_federacao", "TODAS")

dw_1.Object.cd_uf[1] = "TD"
end subroutine

public subroutine wf_seta_mensagem_informacao ();String lvs_Tipo_Calculo
String lvs_Dt_Calc_PIS
String lvs_Calc_PIS
String lvs_Calc_COF

String lvs_Inf_Imposto
String lvs_Inf_CMV

Date lvdt_Mes_Rel

dw_1.AcceptText()
lvdt_Mes_Rel = dw_1.Object.dt_inicio [1]

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
ivs_Info =  "Coluna 'Vl. Custo': ~r~n" + lvs_Inf_CMV + "~r~n~r~n" + &
				"Coluna 'Vl. Imposto': ~r~n"+lvs_Inf_Imposto

dw_2.Object.vl_impostos.Tooltip.Enabled = True
dw_2.Object.vl_impostos.Tooltip.Title = "Valor Imposto"
dw_2.Object.vl_impostos.Tooltip.Tip = lvs_Inf_Imposto

pb_info.Visible = True
end subroutine

on w_ge557_rel_analise_venda_det.create
int iCurrent
call super::create
this.pb_info=create pb_info
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_info
end on

on w_ge557_rel_analise_venda_det.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_info)
end on

event ue_preopen;call super::ue_preopen;ivo_Filial   	= Create uo_Filial
ivo_Convenio	= Create uo_Convenio
ivo_Cliente  	= Create uo_Cliente
ivo_Produto		= Create uo_Produto

MaxWidth	 = 5530
MaxHeight = 9999
end event

event close;call super::close;Destroy(ivo_Filial)
Destroy(ivo_Cliente)
Destroy(ivo_Produto)
Destroy(ivo_Convenio)
end event

event ue_postopen;call super::ue_postopen;Dw_1.Object.dt_inicio	[1] = RelativeDate(Today(),-1)
Dw_1.Object.dt_fim	[1] = RelativeDate(Today(),-1)

ivm_menu.ivb_permite_imprimir = True

wf_insere_padrao()

Post wf_seta_mensagem_informacao()
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge557_rel_analise_venda_det
integer x = 91
integer y = 2284
integer height = 908
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge557_rel_analise_venda_det
integer x = 55
integer y = 2212
integer height = 996
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge557_rel_analise_venda_det
integer x = 32
integer y = 640
integer width = 5403
integer height = 1396
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge557_rel_analise_venda_det
integer x = 32
integer width = 4503
integer height = 620
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge557_rel_analise_venda_det
integer width = 4443
integer height = 528
string dataobject = "dw_ge557_selecao"
end type

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "de_filial"		
			ivo_Filial.of_Localiza_Filial(This.GetText())
			
			If ivo_Filial.Localizada Then
				This.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial
				This.Object.De_Filial[1] = ivo_Filial.Nm_Fantasia
			Else
				ivo_Filial.Of_Inicializa( )
				
				This.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial
				This.Object.De_Filial[1] = ivo_Filial.Nm_Fantasia
			End If
			
		Case "nm_cliente"
			ivo_Cliente.of_Localiza_Cliente(This.GetText())
			
			If ivo_Cliente.Localizado Then
				This.Object.Cd_Cliente	[1] = ivo_Cliente.Cd_Cliente
				This.Object.Nm_Cliente	[1] = ivo_Cliente.Nm_Cliente
			Else
				ivo_Cliente.Of_Inicializa( )
				
				This.Object.Cd_Cliente	[1] = ivo_Cliente.Cd_Cliente
				This.Object.Nm_Cliente	[1] = ivo_Cliente.Nm_Cliente
			End If

		Case "nm_fantasia_convenio"	
			ivo_Convenio.of_Localiza_Convenio(This.GetText())
			
			If ivo_Convenio.Localizado Then
				This.Object.Cd_Convenio					[1] = ivo_Convenio.Cd_Convenio
				This.Object.Nm_Fantasia_Convenio	[1] = ivo_Convenio.Nm_Fantasia
			Else
				ivo_Convenio.Of_Inicializa( )
				
				This.Object.Cd_Convenio					[1] = ivo_Convenio.Cd_Convenio
				This.Object.Nm_Fantasia_Convenio	[1] = ivo_Convenio.Nm_Fantasia
			End If			

		Case "nm_produto"	
			ivo_Produto.of_Localiza_produto(This.GetText())
			
			If ivo_Produto.Localizado Then
				
				This.Object.Cd_Produto	[1] = ivo_Produto.Cd_Produto
				This.Object.Nm_Produto	[1] = ivo_produto.De_produto+': '+ivo_produto.de_apresentacao_venda
			Else
				ivo_Produto.Of_Inicializa( )
				
				This.Object.Cd_Produto	[1] = ivo_Produto.Cd_Produto
				This.Object.Nm_Produto	[1] = ''
			End If			
	End Choose
End If
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Filial) Then 
	This.Object.De_Filial[1] = ivo_Filial.Nm_Fantasia
End If	

If IsValid(ivo_Cliente) Then 
	This.Object.Nm_Cliente[1] = ivo_Cliente.Nm_Cliente
End If	

If IsValid(ivo_Convenio) Then 
	This.Object.Nm_Fantasia_Convenio[1] = ivo_Convenio.Nm_Fantasia
End If	

If IsValid(ivo_Produto) Then 
	If ivo_Produto.Localizado Then
		This.Object.Nm_Produto [1] = ivo_Produto.de_produto+': '+ivo_produto.de_apresentacao_venda
	Else
		This.Object.Nm_Produto [1] = ''	
	End If
End If	
end event

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.name
	Case "de_filial"
		If Trim(Data) <> "" Then
			If Data <> ivo_Filial.nm_Fantasia Then
				Return 1
			End If	
		Else			
			ivo_Filial.Of_inicializa( )
			
			This.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial
			This.Object.De_Filial[1] = ivo_Filial.Nm_Fantasia			
		End If
	Case "nm_cliente"
		If Trim(Data) <> "" Then
			If Data <> ivo_Cliente.Nm_Cliente Then
				Return 1
			End If	
		Else			
			ivo_Cliente.Of_Inicializa( )
			
			This.Object.Cd_Cliente[1] = ivo_Cliente.Cd_Cliente
			This.Object.Nm_Cliente[1] = ivo_Cliente.Nm_Cliente
		End If		
	Case "nm_fantasia_convenio"
		If Trim(Data) <> "" Then
			If Data <> ivo_Convenio.Nm_Fantasia Then
				Return 1
			End If	
		Else			
			ivo_Convenio.Of_inicializa( )
			
			This.Object.Cd_Convenio					[1] = ivo_Convenio.Cd_Convenio
			This.Object.Nm_Fantasia_Convenio	[1] = ivo_Convenio.Nm_Fantasia			
		End If		
	Case "nm_produto"
		If Trim(Data) <> "" Then
			If Data <> (ivo_Produto.De_Produto+': '+ivo_Produto.de_apresentacao_venda) Then
				Return 1
			End If	
		Else			
			ivo_Produto.Of_inicializa( )
			
			This.Object.Cd_Produto 	[1] = ivo_Produto.Cd_Produto
			This.Object.Nm_produto	[1] = ''	
		End If		
End Choose		
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge557_rel_analise_venda_det
integer y = 716
integer width = 5335
integer height = 1288
string dataobject = "dw_ge557_lista"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Especie, &
		 lvs_Serie, &
		 lvs_Situacao, &
		 lvs_Tipo_Venda, &
		 lvs_Agrupa_Filial, &
		 lvs_Cliente, &
		 lvs_Controlado, &
		 lvs_Alt_Preco, &
		 lvs_Abaixo_Custo, &
		 lvs_PBM, &
		 lvs_Manipulado, &
		 lvs_Prestes, &
		 lvs_UF, &
		 lvs_Tipo, &
		 lvs_Forma_Pagto, &
		 lvs_Custo_Zero, &
		 lvs_Frete, &
		 lvs_Promo_Vinc
		 
Decimal {2} lvdc_Valor_de, &
            lvdc_Valor_Ate
		   
Date  lvdt_Inicio
Date  lvdt_Fim

Long	lvl_Filial			, &
     	lvl_Nota_Fiscal	, &
	  	lvl_Convenio		, &
	  	lvl_Produto		, &
	  	lvl_Ecf

dw_1.AcceptText()

lvdt_Inicio		  	= Dw_1.Object.dt_inicio						[1]
lvdt_Fim			 	= Dw_1.Object.dt_fim						[1]
lvl_Filial       		= Dw_1.Object.Cd_Filial						[1]
lvl_Nota_Fiscal  	= Dw_1.Object.Nr_Nf							[1]
lvs_Especie      		= Dw_1.Object.De_Especie					[1] 
lvs_Serie        		= Dw_1.Object.De_Serie						[1]
lvs_Situacao     	= Dw_1.Object.Id_Cancelada				[1]
lvs_Tipo_Venda   	= Dw_1.Object.Id_Tipo_Venda				[1]
lvdc_Valor_de    	= Dw_1.Object.Vl_Valor_de					[1]
lvdc_Valor_Ate   	= Dw_1.Object.Vl_Valor_ate				[1]
lvl_Convenio     	= Dw_1.Object.Cd_Convenio				[1]
lvs_Cliente      		= Dw_1.Object.Cd_Cliente					[1]
lvl_Ecf          		= Dw_1.Object.nr_ecf						[1] 
lvs_Controlado		= Dw_1.Object.id_controlado				[1] 
lvs_Alt_Preco		= Dw_1.Object.id_alteracao_preco		[1] 
lvs_PBM				= Dw_1.Object.id_pbm						[1] 
lvl_Produto			= Dw_1.Object.cd_produto					[1] 
lvs_Abaixo_Custo	= Dw_1.Object.id_abaixo_custo			[1] 
lvs_Manipulado		= Dw_1.Object.id_manipulado				[1] 
lvs_Prestes			= Dw_1.Object.id_prestes					[1] 
lvs_UF				= Dw_1.Object.cd_uf							[1] 
lvs_Tipo				= Dw_1.Object.id_tipo						[1] 
lvs_Forma_Pagto	= Dw_1.Object.cd_forma_pagto			[1] 
lvs_Custo_Zero		= Dw_1.Object.id_custo_zero				[1]
lvs_Frete				= Dw_1.Object.id_frete						[1]
lvs_Promo_Vinc	= Dw_1.Object.id_promocao_vinculada	[1]


If IsNull(lvdt_Inicio) Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Favor informar o In$$HEX1$$ed00$$ENDHEX$$cio do Per$$HEX1$$ed00$$ENDHEX$$odo!")	
	dw_1.SetColumn("dt_inicio")
	Return -1
End If

If IsNull(lvdt_fim) Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Favor informar o Fim do Per$$HEX1$$ed00$$ENDHEX$$odo!")	
	dw_1.SetColumn("dt_fim")
	Return -1
End If

If lvdt_fim < lvdt_Inicio Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Data Fim do Per$$HEX1$$ed00$$ENDHEX$$odo n$$HEX1$$e300$$ENDHEX$$o pode ser menor que a Data In$$HEX1$$ed00$$ENDHEX$$cio!")	
	dw_1.SetColumn("dt_fim")
	Return -1
End If

If Not IsNull(lvl_Filial) and lvl_Filial <> 0 Then
	This.of_AppendWhere(" n.cd_filial = " + String(lvl_Filial))
End If	

If Not IsNull(lvl_Nota_Fiscal) Then
	This.of_AppendWhere(" n.nr_nf = " + String(lvl_Nota_Fiscal))
End If	

If (Not IsNull(lvs_Especie))and(Trim(lvs_Especie)<>'') Then
	This.of_AppendWhere(" n.de_especie = '" + lvs_Especie + "'")
End If	

If (Not IsNull(lvs_Serie))and(Trim(lvs_Serie)<>'') Then
	This.of_AppendWhere(" n.de_serie = '" + lvs_Serie + "'")
End If

If (Not IsNull(lvl_Ecf)) and (lvl_Ecf > 0) Then
	This.of_AppendWhere(" n.nr_ecf = " + String(lvl_Ecf))
End If	

If lvs_Tipo_Venda <> 'TO' Then
	This.of_AppendWhere(" n.id_tipo_venda = '" + lvs_tipo_venda + "'")
End If


If lvs_Situacao <> "T" Then
   If lvs_Situacao = 'S' Then
		This.of_AppendWhere(" n.dh_cancelamento is not null")
	Else
		This.of_AppendWhere(" n.dh_cancelamento is null")
	End If	
End If	

If Not IsNull(lvl_Convenio) Then
	This.of_AppendWhere(" n.cd_convenio = " + String(lvl_Convenio))
End If

If Not IsNull(lvl_Produto) Then
	If DaysAfter(lvdt_Inicio,lvdt_Fim)  <= 5 Then
		This.of_AppendWhere(" i.cd_produto+0 = " + String(lvl_Produto))
	Else
		This.of_AppendWhere(" i.cd_produto = " + String(lvl_Produto))
	End If
End If

If (Not IsNull(lvs_Cliente))and(Trim(lvs_Cliente)<>'') Then
	This.of_AppendWhere(" n.cd_cliente = '" + lvs_Cliente + "'")
End If

If lvdc_Valor_de <> 0.00 Then
	This.of_AppendWhere(" i.vl_preco_praticado >= " + gf_Valor_Com_Ponto(lvdc_Valor_de))
End If

If lvdc_Valor_ate <> 0.00 Then
	This.of_AppendWhere(" i.vl_preco_praticado <= " + gf_Valor_Com_Ponto(lvdc_Valor_ate))
End If

If lvs_Manipulado = 'N' Then
	This.of_AppendWhere(" i.cd_produto+0 <> 684431")
End If

If lvs_Frete = 'N' Then
	This.of_AppendWhere(" i.cd_produto+0 <> 712055")
End If

If lvs_Abaixo_Custo = 'S' Then
	This.of_AppendWhere("i.vl_preco_praticado < me.vl_custo_unitario")
End If

If lvs_Controlado <> "T" Then
	If lvs_Controlado = 'S' Then
		This.of_AppendWhere("pg.cd_grupo_psico is not null")
	Else
		This.of_AppendWhere("pg.cd_grupo_psico is null")
	End If
End If

If lvs_Alt_Preco <> "T" Then
	If lvs_Alt_Preco = 'S' Then
		This.of_AppendWhere("n.vl_total_nf_tabela > n.vl_total_nf")
		This.of_AppendWhere("coalesce(i.id_alteracao_preco,'N')= 'S'")
	Else
		This.of_AppendWhere("coalesce(i.id_alteracao_preco,'N')= 'N'")
	End If
End If

If lvs_PBM <> "T" Then
	If lvs_PBM = 'S' Then
		This.of_AppendWhere(" exists ( select 1 "+ &
												" from venda_pbm v1 (index pk_venda_pbm) "+ &
												" Where v1.cd_filial = n.cd_filial "+ &
												" And v1.nr_nf = n.nr_nf "+ &
												" And v1.de_especie = n.de_especie "+ &
												" And v1.de_serie = n.de_serie)")
	Else
		This.of_AppendWhere(" not exists ( select 1 "+ &
													" from venda_pbm v1 (index pk_venda_pbm) "+ &
													" Where v1.cd_filial = n.cd_filial "+ &
													" And v1.nr_nf = n.nr_nf "+ &
													" And v1.de_especie = n.de_especie "+ &
													" And v1.de_serie = n.de_serie)")
	End If	
End If	

If lvs_Prestes = 'N' Then
	This.of_AppendWhere(" not exists (select 1 "												+ &
												" from item_nf_venda_desconto ivd1 "			+ &
												" where ivd1.cd_filial = i.cd_filial "					+ &
													" and ivd1.nr_nf = i.nr_nf "						+ &
													" and ivd1.de_especie = i.de_especie "		+ &
													" and ivd1.de_serie = i.de_serie "				+ &
													" and ivd1.cd_produto = i.cd_produto "		+ &
													" and ivd1.nr_sequencial = i.nr_sequencial "+ &
													" and ivd1.id_tipo_desconto = 'PVE')")
End If

If lvs_Custo_Zero = 'S' Then
	This.ivs_filtro_relatorio[UpperBound(This.ivs_filtro_relatorio)+1] = "[ X ] Custo Zerado"
	This.of_AppendWhere("me.vl_custo_unitario = 0.00")
End If

If lvs_UF <> "TD" Then
	This.ivs_filtro_relatorio[UpperBound(This.ivs_filtro_relatorio)+1] = 'Estado: '+dw_1.Describe("Evaluate('LookUpDisplay(cd_uf)',1)")
	This.of_AppendWhere("n.cd_filial in (select f1.cd_filial from filial f1 "+ &
												"  inner join cidade c1 on c1.cd_cidade = f1.cd_cidade "+&
												"  where c1.cd_unidade_federacao = '"+lvs_UF+"')")
End If

If lvs_Forma_Pagto <> "TD" Then
	This.ivs_filtro_relatorio[UpperBound(This.ivs_filtro_relatorio)+1] = 'Forma Pagto: '+dw_1.Describe("Evaluate('LookUpDisplay(cd_forma_pagto)',1)")
	This.of_AppendWhere("n.cd_forma_pagamento = '"+lvs_Forma_Pagto + "'")	
	//This.of_AppendWhere("n.cd_forma_pagamento = '"+lvs_Forma_Pagto+"')")	
End If

If lvs_Tipo<>'TD' Then
	Choose Case lvs_Tipo
		Case 'NO'
			This.Of_AppendWhere("n.nr_nf_anexa is null")
			This.Of_AppendWhere("n.nr_pedido_ecommerce is null")
			This.Of_AppendWhere("coalesce(n.id_licitacao,'N')='N'")			
			This.ivs_filtro_relatorio[UpperBound(This.ivs_filtro_relatorio)+1] = 'Somente do Tipo: NORMAL LOJA'
		Case 'EC'
			This.Of_AppendWhere("n.nr_pedido_ecommerce is not null")
			This.ivs_filtro_relatorio[UpperBound(This.ivs_filtro_relatorio)+1] = 'Somente do Tipo: ECOMMERCE'
		Case 'LI'
			This.Of_AppendWhere("n.id_licitacao='S'")			
			This.ivs_filtro_relatorio[UpperBound(This.ivs_filtro_relatorio)+1] = 'Somente do Tipo: LICITA$$HEX2$$c700c300$$ENDHEX$$O'
	End Choose
End If

If lvs_Promo_Vinc = "N" Then	
	This.of_AppendWhere(" not exists (select 1 "														+ &
												" from promocao_sos p1 "									+ &
												" where p1.cd_promocao_sos = i.cd_promocao_sos "+ &
													" and p1.id_tipo_promocao = 'V')")
End If

//
string ls_teste
//
ls_teste = this.getsqlselect( )


Return AncestorReturnValue
end event

event dw_2::ue_recuperar;//override
Date  lvdt_Inicio
Date  lvdt_Fim

dw_1.AcceptText()

lvdt_Inicio		  	= Dw_1.Object.dt_inicio				[1]
lvdt_Fim			 	= Dw_1.Object.dt_fim				[1]

Return This.Retrieve(lvdt_Inicio,lvdt_Fim)
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;Long lvl_Linha

//Atualiza Margem
Try
	Open(w_aguarde)
	w_aguarde.uo_progress.of_SetMax(pl_Linhas)
	w_aguarde.Title = "Atualizando margem..."
	
	This.SetRedraw(False)
	For lvl_Linha = 1 To pl_Linhas
		This.Object.vl_margem_liquida [lvl_Linha] = This.GetItemDecimal(lvl_Linha, "vl_margem_calculada")
		w_aguarde.uo_progress.of_SetProgress(lvl_Linha)
	Next
	
Catch (RuntimeError lvo_erro)
	MessageBox("Erro", lvo_Erro.GetMessage(), StopSign!)
Finally
	This.Sort()
	wf_seta_mensagem_informacao()
	This.SetRedraw(True)
	
	This.ivm_menu.mf_Imprimir(pl_linhas > 0)
	This.ivm_menu.mf_SalvarComo(pl_linhas > 0)
	
	If IsValid(w_aguarde) Then Close(w_aguarde)
End Try

Return AncestorReturnValue
end event

event dw_2::ue_reset;call super::ue_reset;This.ivm_menu.mf_Imprimir(False)
This.ivm_menu.mf_SalvarComo(False)
end event

event dw_2::constructor;call super::constructor;This.ShareData(dw_3)
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge557_rel_analise_venda_det
integer x = 4558
integer y = 56
string dataobject = "dw_ge557_relatorio"
end type

event dw_3::ue_preprint;call super::ue_preprint;Date lvdt_Inicio
Date lvdt_Fim

String lvs_Filial
String lvs_Manipulado
String lvs_Prestes
String lvs_Abaixo_Custo

dw_1.Accepttext( )
lvdt_Inicio			= dw_1.Object.dt_inicio				[1]
lvdt_Fim				= dw_1.Object.dt_fim					[1]
lvs_Manipulado		= dw_1.Object.id_manipulado		[1]
lvs_Prestes			= dw_1.Object.id_prestes			[1]
lvs_Abaixo_Custo	=  dw_1.Object.id_abaixo_custo	[1]

This.Object.st_periodo.Text			= String(lvdt_Inicio,'DD/MM/YYYY')+' $$HEX1$$e000$$ENDHEX$$ '+String(lvdt_Fim,'DD/MM/YYYY')
This.Object.st_tipo.Text				= dw_1.Describe("Evaluate('LookUpDisplay(id_tipo_venda)',1)")
This.Object.st_controlado.Text		= dw_1.Describe("Evaluate('LookUpDisplay(id_controlado)',1)")
This.Object.st_pbm.Text				= dw_1.Describe("Evaluate('LookUpDisplay(id_pbm)',1)")
This.Object.st_alt_preco.Text		= dw_1.Describe("Evaluate('LookUpDisplay(id_alteracao_preco)',1)")

If ivo_filial.Localizada Then
	This.Object.st_filial.Text				= ivo_filial.nm_fantasia+' ('+String(ivo_filial.cd_Filial)+')'
Else
	This.Object.st_filial.Text				= 'TODAS'	
End If

If lvs_Manipulado = 'S' Then
	This.Object.st_manipulado.Text	= 'X'
Else
	This.Object.st_manipulado.Text	= ''
End If

If lvs_Prestes = 'S' Then
	This.Object.st_prestes.Text			= 'X'
Else
	This.Object.st_prestes.Text			= ''
End If

If lvs_Abaixo_Custo = 'S' Then
	This.Object.st_abaixo_custo.Text	= 'X'
Else
	This.Object.st_abaixo_custo.Text	= ''
End If

Return AncestorReturnValue
end event

type pb_info from picturebutton within w_ge557_rel_analise_venda_det
boolean visible = false
integer x = 4553
integer y = 488
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

