HA$PBExportHeader$w_ge423_posicao_estoque_sintetico_categ.srw
forward
global type w_ge423_posicao_estoque_sintetico_categ from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge423_posicao_estoque_sintetico_categ from dc_w_selecao_lista_relatorio
integer width = 3634
integer height = 1908
string title = "GE423 - Relat$$HEX1$$f300$$ENDHEX$$rio de Posi$$HEX2$$e700e300$$ENDHEX$$o de Estoque Sint$$HEX1$$e900$$ENDHEX$$tico por Categoria"
long backcolor = 80269524
end type
global w_ge423_posicao_estoque_sintetico_categ w_ge423_posicao_estoque_sintetico_categ

forward prototypes
public function boolean wf_atualiza_totais ()
public function long wf_find (string ps_categoria)
public function boolean wf_posicao_estoque_central (date pdt_periodo, integer pi_mes, string ps_grupo_almoxarifado)
public function boolean wf_posicao_filiais (date pdt_periodo, integer pi_mes, string ps_grupo_almoxarifado)
public function boolean wf_vendas (date pdt_periodo, integer pi_mes, string ps_grupo_almoxarifado)
end prototypes

public function boolean wf_atualiza_totais ();Long lvl_Row
	  
Decimal{2} lvdc_Estoque, &
           lvdc_Filial, &
			  lvdc_Vendas

For lvl_Row = 1 To dw_2.RowCount()
	
	lvdc_Estoque = 0.00
	lvdc_Filial  = 0.00
	lvdc_Vendas  = 0.00
	
	// Atualiza informa$$HEX2$$e700f500$$ENDHEX$$es do 1 m$$HEX1$$ea00$$ENDHEX$$s
	lvdc_Estoque = dw_2.Object.Vl_Central1[lvl_Row]
	lvdc_Filial  = dw_2.Object.Vl_Filial1 [lvl_Row]
	lvdc_Vendas  = dw_2.Object.Vl_Vendas1 [lvl_Row]
	
	If lvdc_Vendas > 0 Then			
		dw_2.Object.Vl_Dias_Central1[lvl_Row] = lvdc_Estoque / (lvdc_Vendas / 30)
		dw_2.Object.Vl_Dias_Filial1 [lvl_Row] = lvdc_Filial / (lvdc_Vendas / 30)
	End If	

	dw_2.Object.Vl_Total1[lvl_Row]      = lvdc_Estoque + lvdc_Filial
	dw_2.Object.Vl_Total_Dias1[lvl_Row] = dw_2.Object.Vl_Dias_Central1[lvl_Row] + dw_2.Object.Vl_Dias_Filial1[lvl_Row]

	// Atualiza informa$$HEX2$$e700f500$$ENDHEX$$es do 2 m$$HEX1$$ea00$$ENDHEX$$s	
	lvdc_Estoque = 0.00
	lvdc_Filial  = 0.00
	lvdc_Vendas  = 0.00

	lvdc_Estoque = dw_2.Object.Vl_Central2[lvl_Row]
	lvdc_Filial  = dw_2.Object.Vl_Filial2[lvl_Row]
	lvdc_Vendas  = dw_2.Object.Vl_Vendas2[lvl_Row]
	
	If lvdc_Vendas > 0 Then
		dw_2.Object.Vl_Dias_Central2[lvl_Row] = lvdc_Estoque / (lvdc_Vendas / 30)
		dw_2.Object.Vl_Dias_Filial2 [lvl_Row] = lvdc_Filial / (lvdc_Vendas / 30)
	End If
	
	dw_2.Object.Vl_Total2[lvl_Row]      = lvdc_Estoque + lvdc_Filial
	dw_2.Object.Vl_Total_Dias2[lvl_Row] = dw_2.Object.Vl_Dias_Central2[lvl_Row] + dw_2.Object.Vl_Dias_Filial2[lvl_Row]		
	
	// Atualiza varia$$HEX2$$e700f500$$ENDHEX$$es
	dw_2.Object.Vl_Variacao[lvl_Row] = dw_2.Object.Vl_Total2[lvl_Row] - dw_2.Object.Vl_Total1[lvl_Row]
	
	If dw_2.Object.Vl_Total2[lvl_Row] > 0 Then
		dw_2.Object.Perc_Variacao[lvl_Row] = (dw_2.Object.Vl_Variacao[lvl_Row] / dw_2.Object.Vl_Total2[lvl_Row]) * 100
	End If

Next	

Return True
end function

public function long wf_find (string ps_categoria);Long lvl_Find

lvl_Find = dw_2.Find("cd_categoria = '" + ps_categoria + "'", 1, dw_2.RowCount())

If lvl_Find < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no find ao verificar a categoria: '" + ps_categoria + "'",StopSign!)
End If

Return lvl_Find
end function

public function boolean wf_posicao_estoque_central (date pdt_periodo, integer pi_mes, string ps_grupo_almoxarifado);Long lvl_Total, &
     lvl_Row, &
	  lvl_Find, &
	  lvl_Linha_Nova
	  
String lvs_Categoria, &
       lvs_Descricao

Decimal{2} lvdc_Estoque

dc_uo_ds_base lvds_Central
lvds_Central = Create dc_uo_ds_base

If Not lvds_Central.of_ChangeDataObject("ds_ge423_posicao_estoque_central") Then Return False

// Sem o grupo almoxarifado
If ps_Grupo_Almoxarifado = "N" Then 
 	lvds_Central.of_AppendWhere("w.cd_grupo <> '5'",1)
	//lvds_Central.of_AppendWhere("w.cd_grupo <> '5'",3)
End If

lvl_Total = lvds_Central.Retrieve(pdt_Periodo)

If lvl_Total > 0 Then
	
	For lvl_Row = 1 To lvl_Total
		
		lvs_Categoria = lvds_Central.Object.Cd_Categoria[lvl_Row]
		lvs_Descricao = lvds_Central.Object.De_Categoria[lvl_Row]
		lvdc_Estoque  = lvds_Central.Object.Vl_Estoque_Central[lvl_Row]
		
		lvl_Find = wf_Find(lvs_Categoria)
		
		If lvl_Find > 0 Then
			
			If pi_Mes = 1 Then
				dw_2.Object.Vl_Central1[lvl_Find] = lvdc_Estoque
			Else
				dw_2.Object.Vl_Central2[lvl_Find] = lvdc_Estoque
			End If
		ElseIf lvl_Find = 0 Then
			
			lvl_Linha_Nova = dw_2.InsertRow(0)
			
			dw_2.Object.Cd_Categoria[lvl_Linha_Nova] = lvs_Categoria
			dw_2.Object.De_Categoria[lvl_Linha_Nova] = lvs_Descricao
			
			If pi_Mes = 1 Then
				dw_2.Object.Vl_Central1[lvl_Linha_Nova] = lvdc_Estoque
			Else
				dw_2.Object.Vl_Central2[lvl_Linha_Nova] = lvdc_Estoque
			End If
		Else
			Return False
		End If		
	Next	
End If

Destroy(lvds_Central)

Return True
end function

public function boolean wf_posicao_filiais (date pdt_periodo, integer pi_mes, string ps_grupo_almoxarifado);Long lvl_Total, &
     lvl_Row, &
	  lvl_Find, &
	  lvl_Linha_Nova
	  
String lvs_Categoria, &
       lvs_Descricao

Decimal{2} lvdc_Filial, &
           lvdc_Estoque

dc_uo_ds_base lvds_Filiais
lvds_Filiais = Create dc_uo_ds_base

If Not lvds_Filiais.of_ChangeDataObject("ds_ge423_posicao_filiais") Then Return False

// Sem o grupo almoxarifado
If ps_Grupo_Almoxarifado = "N" Then 
 	lvds_Filiais.of_AppendWhere("w.cd_grupo <> '5'",1)
	//lvds_Filiais.of_AppendWhere("w.cd_grupo <> '5'",3)
End If

lvl_Total = lvds_Filiais.Retrieve(pdt_Periodo)

If lvl_Total > 0 Then
	
	For lvl_Row = 1 To lvl_Total
		
		lvs_Categoria = lvds_Filiais.Object.Cd_Categoria[lvl_Row]
		lvs_Descricao = lvds_Filiais.Object.De_Categoria[lvl_Row]
		lvdc_Filial   = lvds_Filiais.Object.Vl_Estoque_Filiais[lvl_Row]
		
		lvl_Find = wf_Find(lvs_Categoria)
		
		If lvl_Find > 0 Then
			
			If pi_Mes = 1 Then
				
				lvdc_Estoque = dw_2.Object.Vl_Central1[lvl_Find]
				
				dw_2.Object.Vl_Filial1[lvl_Find] = lvdc_Filial - lvdc_Estoque
			Else
				lvdc_Estoque = dw_2.Object.Vl_Central2[lvl_Find]
				
				dw_2.Object.Vl_Filial2[lvl_Find] = lvdc_Filial - lvdc_Estoque
			End If
		ElseIf lvl_Find = 0 Then
			
			lvl_Linha_Nova = dw_2.InsertRow(0)
			
			dw_2.Object.Cd_Categoria[lvl_Linha_Nova] = lvs_Categoria
			dw_2.Object.De_Categoria[lvl_Linha_Nova] = lvs_Descricao
			
			If pi_Mes = 1 Then
				dw_2.Object.Vl_Filial1[lvl_Linha_Nova] = lvdc_Filial
			Else
				dw_2.Object.Vl_Filial2[lvl_Linha_Nova] = lvdc_Filial
			End If
		Else
			Return False
		End If
		
	Next	
End If

Destroy(lvds_Filiais)

Return True
end function

public function boolean wf_vendas (date pdt_periodo, integer pi_mes, string ps_grupo_almoxarifado);Long lvl_Total, &
     lvl_Row, &
	  lvl_Find, &
	  lvl_Linha_Nova
	  
String lvs_Categoria, &
       lvs_Descricao

Decimal{2} lvdc_Vendas

DateTime lvdh_Parametro

If Not gf_Data_Parametro(ref lvdh_Parametro) Then Return False

dc_uo_ds_base lvds_Vendas
lvds_Vendas = Create dc_uo_ds_base

If Not lvds_Vendas.of_ChangeDataObject("ds_ge423_vendas") Then 
	Destroy(lvds_Vendas)
	Return False
End If

// Sem o grupo almoxarifado
If ps_Grupo_Almoxarifado = "N" Then 
 	lvds_Vendas.of_AppendWhere("w.cd_grupo <> '5'",1)
	//lvds_Vendas.of_AppendWhere("w.cd_grupo <> '5'",3)
End If

// Se for o m$$HEX1$$ea00$$ENDHEX$$s corrente, verifica as vendas do $$HEX1$$fa00$$ENDHEX$$ltimo m$$HEX1$$ea00$$ENDHEX$$s fechado
If Date("01/" + String(lvdh_Parametro, "mm/yyyy")) = pdt_Periodo Then
	pdt_Periodo = Date("01/" + String(RelativeDate(pdt_Periodo, -1), "mm/yyyy"))
End If	

lvl_Total = lvds_Vendas.Retrieve(pdt_Periodo)

If lvl_Total > 0 Then
	
	For lvl_Row = 1 To lvl_Total
		
		lvs_Categoria = lvds_Vendas.Object.Cd_Categoria[lvl_Row]
		lvs_Descricao = lvds_Vendas.Object.De_Categoria[lvl_Row]
		lvdc_Vendas   = lvds_Vendas.Object.Vl_Venda[lvl_Row]
		
		lvl_Find = wf_Find(lvs_Categoria)
		
		If lvl_Find > 0 Then
			
			If pi_Mes = 1 Then
				dw_2.Object.Vl_Vendas1[lvl_Find] = lvdc_Vendas
			Else
				dw_2.Object.Vl_Vendas2[lvl_Find] = lvdc_Vendas
			End If
		ElseIf lvl_Find = 0 Then
			
			lvl_Linha_Nova = dw_2.InsertRow(0)
			
			dw_2.Object.Cd_Categoria[lvl_Linha_Nova] = lvs_Categoria
			dw_2.Object.De_Categoria[lvl_Linha_Nova] = lvs_Descricao
			
			If pi_Mes = 1 Then
				dw_2.Object.Vl_Vendas1[lvl_Linha_Nova] = lvdc_Vendas
			Else
				dw_2.Object.Vl_Vendas2[lvl_Linha_Nova] = lvdc_Vendas
			End If
		Else
			Return False
		End If		
	Next	
End If

Destroy(lvds_Vendas)

Return True
end function

on w_ge423_posicao_estoque_sintetico_categ.create
call super::create
end on

on w_ge423_posicao_estoque_sintetico_categ.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;DateTime lvdh_1, &
         lvdh_2
	  
Select dateadd(month, -1, dh_movimentacao),
       dh_movimentacao       
Into :lvdh_1,
     :lvdh_2
From parametro
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		dw_1.Object.Mes_Ano1[1] = Date("01/" + String(lvdh_1, "mm/yyyy"))
		dw_1.Object.Mes_Ano2[1] = Date("01/" + String(lvdh_2, "mm/yyyy"))

	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Datas de sele$$HEX2$$e700e300$$ENDHEX$$o default n$$HEX1$$e300$$ENDHEX$$o localizadas.", Information!)
		
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o das Datas de Sele$$HEX2$$e700e300$$ENDHEX$$o Default")
End Choose

This.ivm_Menu.ivb_Permite_Imprimir = True
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge423_posicao_estoque_sintetico_categ
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge423_posicao_estoque_sintetico_categ
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge423_posicao_estoque_sintetico_categ
integer x = 18
integer y = 192
integer width = 3566
integer height = 1520
integer weight = 700
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge423_posicao_estoque_sintetico_categ
integer x = 18
integer y = 4
integer width = 2533
integer height = 176
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge423_posicao_estoque_sintetico_categ
integer x = 46
integer y = 64
integer width = 2487
integer height = 92
string dataobject = "dw_ge423_selecao"
end type

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge423_posicao_estoque_sintetico_categ
integer x = 50
integer y = 252
integer width = 3497
integer height = 1432
string dataobject = "dw_ge423_lista"
boolean hscrollbar = true
boolean hsplitscroll = true
end type

event dw_2::ue_recuperar;//OverRide

Boolean lvb_Sucesso = True

Date lvdt_Periodo1, &
     lvdt_Periodo2, &
	  lvdt_Periodo, &
	  lvdt_Data_Atual

Integer lvi_Row

String lvs_Grupo_Almoxarifado

dw_1.AcceptText()

lvdt_Periodo1   		= gf_Primeiro_Dia_Mes(dw_1.Object.Mes_Ano1[1])
lvdt_Periodo2   		= gf_Primeiro_Dia_Mes(dw_1.Object.Mes_Ano2[1])
lvdt_Data_Atual 		= gf_Primeiro_Dia_Mes(Today())
lvs_Grupo_Almoxarifado	= dw_1.Object.grupo_almoxarifado[1]

If lvdt_Periodo1 >= lvdt_Periodo2 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","A data do segundo m$$HEX1$$ea00$$ENDHEX$$s deve ser maior que o primeiro m$$HEX1$$ea00$$ENDHEX$$s.",Information!)
	Return -1
End If

If lvdt_Periodo2 > lvdt_Data_Atual Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","A data do segundo m$$HEX1$$ea00$$ENDHEX$$s deve ser menor ou igual ao m$$HEX1$$ea00$$ENDHEX$$s corrente.",Information!)
	Return -1
End If

This.SetRedraw(False)

Open(w_Aguarde)
w_Aguarde.Title = "Atualizando Informa$$HEX2$$e700f500$$ENDHEX$$es..."

For lvi_Row = 1 To 2	
	
	If lvi_Row = 1 Then
		lvdt_Periodo = lvdt_Periodo1
	Else
		lvdt_Periodo = lvdt_Periodo2
	End If
	
	w_Aguarde.Title = "Atualizando Valores do Estoque Central do M$$HEX1$$ea00$$ENDHEX$$s '" + String(lvdt_Periodo, "mm/yyyy") + "'..."
	// Atualiza valores do Estoque Central
	If wf_Posicao_Estoque_Central(lvdt_Periodo, lvi_Row, lvs_Grupo_Almoxarifado) Then
	
		w_Aguarde.Title = "Atualizando Valores das Filiais do M$$HEX1$$ea00$$ENDHEX$$s '" + String(lvdt_Periodo, "mm/yyyy") + "'..."
		// Atualiza Valores das Filiais
		If wf_Posicao_Filiais(lvdt_Periodo, lvi_Row, lvs_Grupo_Almoxarifado) Then
	
			w_Aguarde.Title = "Atualizando Dias de Estoque do M$$HEX1$$ea00$$ENDHEX$$s '" + String(lvdt_Periodo, "mm/yyyy") + "'..."
			// Atualiza o n$$HEX1$$fa00$$ENDHEX$$mero de Dias de estoque
			If Not wf_Vendas(lvdt_Periodo, lvi_Row, lvs_Grupo_Almoxarifado) Then lvb_Sucesso = False
		Else			
			lvb_Sucesso = False
			Exit
		End If
	Else
		lvb_Sucesso = False
		Exit
	End If
Next

w_Aguarde.Title = "Atualizando Totais do M$$HEX1$$ea00$$ENDHEX$$s '" + String(lvdt_Periodo, "mm/yyyy") + "'..."
// Atualiza os Totais
If Not wf_Atualiza_Totais() Then lvb_Sucesso = False

If Not lvb_Sucesso Then
	Close(W_Aguarde)
	Return -1
End If

Close(w_Aguarde)

This.Object.Mes1_t.Text = "Estoque do M$$HEX1$$ea00$$ENDHEX$$s: " + String(lvdt_Periodo1,"mm/yyyy")
This.Object.Mes2_t.Text = "Estoque do M$$HEX1$$ea00$$ENDHEX$$s: " + String(lvdt_Periodo2,"mm/yyyy")

dw_3.Object.Mes1_t.Text = "Estoque do M$$HEX1$$ea00$$ENDHEX$$s: " + String(lvdt_Periodo1,"mm/yyyy")
dw_3.Object.Mes2_t.Text = "Estoque do M$$HEX1$$ea00$$ENDHEX$$s: " + String(lvdt_Periodo2,"mm/yyyy")

This.SetRedraw(True)
This.Sort()
This.GroupCalc()

Return This.RowCount()
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	
	This.ivm_Menu.mf_SalvarComo(True)
Else
	
	This.ivm_Menu.mf_SalvarComo(False)
End If

Return pl_Linhas
end event

event dw_2::ue_reset;call super::ue_reset;This.ivm_Menu.mf_SalvarComo(False)
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge423_posicao_estoque_sintetico_categ
integer x = 3099
integer y = 48
integer height = 132
integer taborder = 50
string dataobject = "dw_ge423_relatorio"
end type

