HA$PBExportHeader$w_ge060_produto_procura_cliente.srw
forward
global type w_ge060_produto_procura_cliente from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge060_produto_procura_cliente from dc_w_selecao_lista_relatorio
integer x = 215
integer y = 220
integer width = 3790
integer height = 1900
string title = "GE060 - Relat$$HEX1$$f300$$ENDHEX$$rio de Produtos Procurados pelos Clientes"
long backcolor = 80269524
end type
global w_ge060_produto_procura_cliente w_ge060_produto_procura_cliente

type variables
uo_produto ivo_Produto
uo_filial       ivo_filial
end variables

forward prototypes
public subroutine wf_localiza_filial ()
public subroutine wf_localiza_produto ()
public function boolean wf_calculo_valor_vendas_grupo_todas ()
public subroutine wf_atualiza_ordenamento ()
public function boolean wf_calculo_valor_vendas_grupo_prod ()
public function boolean wf_qtde_vendida_filial ()
end prototypes

public subroutine wf_localiza_filial ();//
STRING ls_filial	, &
		 lvs_nulo
//
Long   lvl_nulo
//
ls_filial = dw_1.GetText()
//
ivo_filial.Of_Localiza_Filial(ls_filial)
//
If ivo_filial.Localizada Then
	//
	dw_1.Object.cd_filial[1] = ivo_filial.cd_filial
	dw_1.Object.de_filial[1] = ivo_filial.nm_fantasia
	//
Else
	SetNull(lvl_nulo)
	SetNull(lvs_nulo)
	dw_1.Object.cd_filial[1] = lvl_nulo
	dw_1.Object.de_filial[1] = lvs_nulo
	//
	ivo_filial.cd_filial	    = lvl_nulo
	ivo_filial.nm_fantasia   = lvs_nulo	
	//
End If
//
end subroutine

public subroutine wf_localiza_produto ();Long lvl_nulo
//
String lvs_Produto , &
		 lvs_nulo
//
lvs_Produto = dw_1.GetText()
//
ivo_Produto.of_Localiza_Produto(lvs_Produto)
//
If ivo_Produto.Localizado Then
	dw_1.Object.Cd_Produto[1] = ivo_Produto.Cd_Produto
	dw_1.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
Else
	//
	SetNull(lvl_nulo)
	SetNull(lvs_nulo)
	dw_1.Object.Cd_Produto[1] = lvl_nulo
	dw_1.Object.De_Produto[1] = lvs_nulo
	//
	ivo_Produto.Cd_Produto								= lvl_nulo
	ivo_Produto.ivs_Descricao_Apresentacao_Venda = lvs_nulo
	//
End If
end subroutine

public function boolean wf_calculo_valor_vendas_grupo_todas ();Decimal{2} lvdc_Vendas, &
           lvdc_Total_Vendas, &
			  lvdc_Total_Geral_Vendas

Date lvdt_periodo_de, &
	  lvdt_periodo_ate

Long lvl_Linha, &
	  lvl_Find, &
	  lvl_Produto, &
	  lvl_Filial, &
	  lvl_Filial_DW2

String lvs_Grupo
String lvs_Grupo_DW2
String lvs_Find
String lvs_Agrupamento

dw_1.AcceptText()

lvdt_periodo_de	= dw_1.Object.dt_periodo_de 		[1]
lvdt_periodo_ate	= dw_1.Object.dt_periodo_ate		[1]
lvl_Produto      		= dw_1.Object.Cd_Produto    		[1]
lvs_Agrupamento	= dw_1.Object.id_agrupamento	[1]
lvl_Filial				= dw_1.Object.cd_filial				[1]

dc_uo_ds_base lvds_Vendas
lvds_Vendas = Create dc_uo_ds_base

If lvs_Agrupamento = "FG" then
	If Not lvds_Vendas.Of_ChangeDataObject("ds_ge060_venda_grupo_filial") Then Return False
Else
	If Not lvds_Vendas.Of_ChangeDataObject("ds_ge060_venda_grupo") Then Return False
End If

If Not IsNull(lvl_Filial) Then
	lvds_Vendas.of_AppendWhere("rm.cd_filial = " + String(lvl_Filial))
End If

Open(w_Aguarde)

w_Aguarde.Title = "Calculando vendas..."

dw_2.SetRedraw(False)

lvds_Vendas.Retrieve(lvdt_Periodo_De, lvdt_Periodo_Ate)
w_Aguarde.uo_progress.Of_SetMax(dw_2.RowCount())


lvdc_Total_Vendas				= 0.00
lvdc_Total_Geral_Vendas	= 0.00
lvdc_Vendas						= 0.00

For lvl_Linha = 1 To dw_2.RowCount()
	lvs_Grupo_DW2   = dw_2.Object.Cd_Grupo_Produto[lvl_Linha]
	
	If lvs_Agrupamento = "FG" then
		lvl_Filial_DW2 = dw_2.Object.cd_filial	[lvl_Linha]
		lvs_Find = "cd_grupo_produto = '" + lvs_Grupo_DW2 + "' and cd_filial="+String(lvl_Filial_DW2)
	Else
		lvs_Find = "cd_grupo_produto = '" + lvs_Grupo_DW2 + "'"
	End If
	
	If IsNull(lvl_Filial) Then lvl_Filial = 0
	If IsNull(lvl_Filial_DW2) Then lvl_Filial_DW2 = 0
	
	If (lvs_Grupo_DW2 <> lvs_Grupo) or (lvl_Filial <> lvl_Filial_DW2) Then	
		lvl_Find = lvds_Vendas.Find(lvs_Find, 1, lvds_Vendas.RowCount())
		
		If (lvl_Find > 0) Then
			lvs_Grupo	= lvds_Vendas.Object.Cd_Grupo_Produto	[lvl_Find]
			lvdc_Vendas	= lvds_Vendas.Object.Vl_Venda_Grupo		[lvl_Find]
			
			If lvs_Agrupamento = "FG" then
				lvl_Filial = lvds_Vendas.Object.cd_filial	[lvl_Find]
			End If
			
			lvdc_Total_Vendas				+= lvdc_Vendas
			lvdc_Total_Geral_Vendas	+= lvdc_Vendas
		Else
			Continue
		End If
	End If
		
	dw_2.Object.Vl_Venda_Grupo_Geral[lvl_Linha] = lvdc_Vendas	
	
	w_Aguarde.uo_progress.Of_SetProgress(lvl_Linha)
	
	If lvs_Agrupamento = "FG" then
		If lvl_Linha < dw_2.RowCount() Then
			If dw_2.Object.cd_filial [lvl_Linha] <> dw_2.Object.cd_filial [lvl_Linha + 1] Then		
				dw_2.Object.vl_venda_filial_geral[lvl_Linha] = lvdc_Total_Vendas
				lvdc_Total_Vendas	 = 0.00
			End If
		Else
			dw_2.Object.vl_venda_filial_geral[lvl_Linha] = lvdc_Total_Vendas
			lvdc_Total_Vendas	 = 0.00
		End If
	End If
Next

dw_2.Object.vl_total_geral_vendas[dw_2.RowCount()] = lvdc_Total_Geral_Vendas

dw_2.SetRedraw(True)

Destroy(lvds_Vendas)

Close(w_Aguarde)

Return True
end function

public subroutine wf_atualiza_ordenamento ();String lvs_Coluna[], &
       lvs_Nome[], &
       lvs_Protect[]
		 
String lvs_Agrupamento

If dw_1.RowCount() > 0 Then
	dw_1.Accepttext( )
	lvs_Agrupamento = dw_1.Object.id_agrupamento [1]
Else
	lvs_Agrupamento = "FG"
End If

If lvs_Agrupamento = "FG" Then
	lvs_Coluna = {"nm_fantasia","cd_grupo_produto","cd_classe_reposicao","cd_produto", "produto", "id_situacao", "vl_preco_venda_atual", "qt_consultas", &
					  "qt_recebida_outra_filial"}
	
	lvs_Nome = {"Filial","Grupo Produto","Classe","C$$HEX1$$f300$$ENDHEX$$digo Produto","Descri$$HEX2$$e700e300$$ENDHEX$$o Produto", "Situa$$HEX2$$e700e300$$ENDHEX$$o", "Pre$$HEX1$$e700$$ENDHEX$$o de Venda", "Qtde Venda Perdida", "Qtde Recebida Outra Filial"}
	lvs_Protect = {"S","S","N", "N", "N", "N", "N", "N","N"}
Else
	lvs_Coluna = {"cd_grupo_produto","cd_classe_reposicao","cd_produto", "produto", "id_situacao", "vl_preco_venda_atual", "qt_consultas", &
					  "qt_recebida_outra_filial"}
	
	lvs_Nome = {"Grupo Produto","Classe","C$$HEX1$$f300$$ENDHEX$$digo Produto","Descri$$HEX2$$e700e300$$ENDHEX$$o Produto", "Situa$$HEX2$$e700e300$$ENDHEX$$o", "Pre$$HEX1$$e700$$ENDHEX$$o de Venda", "Qtde Venda Perdida", "Qtde Recebida Outra Filial"}
	lvs_Protect = {"S","N", "N", "N", "N", "N", "N","N"}
End If

dw_2.of_SetSort(lvs_Coluna, lvs_Nome,lvs_Protect)
dw_2.of_SetFilter(lvs_Coluna, lvs_Nome)
end subroutine

public function boolean wf_calculo_valor_vendas_grupo_prod ();Decimal{2}	lvdc_Vendas, &
          		lvdc_Total_Vendas, &
				lvdc_Total_Geral_Vendas

Date	lvdt_periodo_de, &
		lvdt_periodo_ate

Long lvl_Linha, &
	  lvl_Produto, &
	  lvl_Filial, &
	  lvl_Linha_Grupo

String lvs_Grupo
String lvs_Agrupamento

dw_1.AcceptText()

lvdt_periodo_de	= dw_1.Object.dt_periodo_de 		[1]
lvdt_periodo_ate	= dw_1.Object.dt_periodo_ate		[1]
lvl_Produto      		= dw_1.Object.Cd_Produto    		[1]
lvs_Agrupamento	= dw_1.Object.id_agrupamento	[1]
lvl_Filial				= dw_1.Object.cd_filial				[1]

//Cria datastore
dc_uo_ds_base lvds_Vendas
lvds_Vendas = Create dc_uo_ds_base
//Atribui a datawindow ao objeto datastore
If Not lvds_Vendas.Of_ChangeDataObject("ds_ge060_venda_grupo") Then Return False

//Adiciona filtros na datastore
If Not IsNull(lvl_Filial) and (lvl_Filial > 0) Then
	lvds_Vendas.Of_appendwhere( "rm.cd_filial="+String(lvl_Filial))
End If

If Not IsNull(lvl_Produto) and (lvl_Produto > 0) Then
	lvds_Vendas.Of_appendwhere( "rm.cd_produto="+String(lvl_Produto))
End If

//Inicia calculos
Open(w_Aguarde)
w_Aguarde.Title = "Calculando vendas... "
	
lvds_Vendas.Retrieve(lvdt_Periodo_De, lvdt_Periodo_Ate)
w_Aguarde.uo_Progress.Of_SetMax(lvds_Vendas.RowCount())

lvdc_Total_Geral_Vendas = 0.00

For lvl_Linha_Grupo = 1 To lvds_Vendas.RowCount()
	lvs_Grupo 	= lvds_Vendas.Object.cd_grupo_produto	[lvl_Linha_Grupo]
	lvdc_Vendas	= lvds_Vendas.Object.vl_venda_grupo	[lvl_Linha_Grupo]
	
	For lvl_Linha = 1 To dw_2.RowCount()				
		dw_2.Object.Vl_Venda_Grupo_Geral[lvl_Linha] = lvdc_Vendas	
	Next
	
	lvdc_Total_Geral_Vendas += lvdc_Total_Vendas
	w_Aguarde.uo_Progress.Of_SetProgress(lvl_Linha_Grupo)
Next
		
dw_2.Object.vl_total_geral_vendas[dw_2.RowCount()] = lvdc_Total_Geral_Vendas

Destroy(lvds_Vendas)

Close(w_Aguarde)

Return True
end function

public function boolean wf_qtde_vendida_filial ();Boolean lvb_Sucesso = True

Date lvdt_Inicio,&
	 lvdt_Termino

Long lvl_Find,&
	 lvl_Linha,&
	 lvl_Linha_Filial, &
	 lvl_Produto,&
	 lvl_Filial,&
	 lvl_Qtde
	 
String lvs_Agrupamento
String lvs_Find
	 
dw_1.AcceptText()

lvdt_Inicio  			= dw_1.Object.dt_periodo_de 		[1]
lvdt_Termino 		= dw_1.Object.dt_periodo_ate		[1]
lvl_Produto			= dw_1.Object.cd_produto 			[1]
lvl_Filial				= dw_1.Object.cd_filial	 			[1]
lvs_Agrupamento	= dw_1.Object.id_agrupamento	[1]

dc_uo_ds_base lvds_Produto
lvds_Produto = Create dc_uo_ds_base


If lvs_Agrupamento = "FG" then
	If Not lvds_Produto.Of_ChangeDataObject("ds_ge060_qtde_venda_filial") Then Return False
Else
	If Not lvds_Produto.Of_ChangeDataObject("ds_ge060_qtde_venda") Then Return False
End If

If Not IsNull(lvl_Produto) Then
	lvds_Produto.of_AppendWhere("r.cd_produto = " + String(lvl_Produto))
End If

If Not IsNull(lvl_Filial) and (lvl_Filial > 0) Then
	lvds_Produto.of_AppendWhere("r.cd_filial = " + String(lvl_Filial))
End If

Open(w_Aguarde)

lvds_Produto.Retrieve(lvdt_Inicio, lvdt_Termino)
w_Aguarde.uo_Progress.of_SetMax(lvds_Produto.RowCount())

dw_2.SetRedraw(False)
For lvl_Linha = 1 To lvds_Produto.RowCount()
	
	lvl_Produto 	= lvds_Produto.Object.cd_produto	[lvl_Linha]
	lvl_Qtde		= lvds_Produto.Object.qtde			[lvl_Linha]
	
	If lvs_Agrupamento = "FG" then
		lvl_Filial	= lvds_Produto.Object.cd_filial		[lvl_Linha]
		lvs_Find	= "cd_filial="+String(lvl_Filial)+" and cd_produto = "+String(lvl_Produto)
	Else
		lvs_Find	= "cd_produto = "+String(lvl_Produto)
	End If
	
	lvl_Find = dw_2.Find(lvs_Find,1,dw_2.RowCount())
	
	If lvl_Find > 0 then			
		dw_2.Object.qt_vendida[lvl_Find] = lvl_Qtde
	End If
	
	w_Aguarde.uo_Progress.of_SetProgress(lvl_Linha)
Next
dw_2.SetRedraw(True)

Close(w_Aguarde)

Destroy(lvds_Produto)

Return lvb_Sucesso 
end function

on w_ge060_produto_procura_cliente.create
call super::create
end on

on w_ge060_produto_procura_cliente.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;DESTROY(ivo_produto)
DESTROY(ivo_filial)

end event

event ue_postopen;call super::ue_postopen;//
// Autor	: Eubs Ferreira Ramiro
// Data	: 12/04/2001
//
//ivb_Impressao = True
ivo_produto   = Create uo_produto
ivo_filial	  = Create uo_filial
//
IF gvo_parametro.cd_filial <> gvo_parametro.cd_filial_matriz THEN
	dw_1.Object.cd_filial[1] = gvo_parametro.cd_filial
	dw_1.Object.de_filial[1] = gvo_parametro.nm_fantasia_filial
	dw_1.Object.de_filial.protect = 1
	//
	ivo_filial.cd_filial   = dw_1.Object.cd_filial[1]
	ivo_filial.nm_fantasia = dw_1.Object.de_filial[1]
	//
END IF
//
dw_1.Object.dt_periodo_de [1] = Date('01/'+ String(Month(Today()),'00') + &
												  '/' + String(Year (Today()),'0000'))
dw_1.Object.dt_periodo_ate[1] = Today()

This.ivm_Menu.ivb_Permite_Imprimir = True

end event

event ue_preopen;call super::ue_preopen;MaxHeight = 9999
end event

event ue_saveas;call super::ue_saveas;dw_2.Event ue_SaveAs()
end event

event open;call super::open;
If  gvo_Aplicacao.ivo_Seguranca.Cd_Sistema <> "CO" Then
	dw_1.object.id_zero.visible = False
End If	

end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge060_produto_procura_cliente
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge060_produto_procura_cliente
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge060_produto_procura_cliente
integer x = 14
integer y = 348
integer width = 3717
integer height = 1348
integer weight = 700
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge060_produto_procura_cliente
integer x = 14
integer y = 0
integer width = 3182
integer height = 340
integer weight = 700
long backcolor = 79741120
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge060_produto_procura_cliente
integer x = 41
integer y = 68
integer width = 3136
integer height = 264
string dataobject = "dw_ge060_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;Long	ll_nulo

SetNull(ll_nulo)

Choose case dwo.name 
	Case "de_produto"	
		
		IF Data = "" OR ISNULL(Data) THEN
			THIS.Object.cd_produto[1] 							= ll_nulo
			ivo_Produto.ivs_Descricao_Apresentacao_Venda = ''
			RETURN 0
		END IF		
		
		IF Data <> ivo_Produto.ivs_Descricao_Apresentacao_Venda Then RETURN 1
	Case "de_filial"	
		
		IF Data = "" OR ISNULL(Data) THEN
			THIS.Object.cd_filial[1] = ll_nulo
			ivo_filial.nm_fantasia 	 = ''
			RETURN 0
		END IF		
		
		IF Data <> ivo_filial.nm_fantasia THEN RETURN 1
		
	Case "id_agrupamento"	
		
		If Data = "FG" Then
			dw_2.Of_ChangeDataObject('dw_ge060_lista')			
			dw_3.Of_ChangeDataObject('dw_ge060_relatorio')		
		Else
			dw_2.Of_ChangeDataObject('dw_ge060_lista_produto')
			dw_3.Of_ChangeDataObject('dw_ge060_relatorio_produto')
		End If
		
		wf_atualiza_ordenamento( )
		dw_2.Of_SetRowSelection( )
		dw_2.ShareData( dw_3 )
		
End Choose
end event

event dw_1::losefocus;call super::losefocus;IF IsValid(ivo_produto) THEN
	dw_1.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
END IF

IF IsValid(ivo_filial) THEN
	dw_1.Object.De_filial[1] = ivo_filial.nm_fantasia
END IF
end event

event dw_1::ue_key;call super::ue_key;String lvs_Coluna

If Key = KeyEnter! Then
	
	lvs_Coluna = This.GetColumnName()
		
	Choose Case lvs_Coluna 
		Case "de_produto" ; WF_Localiza_Produto()
		Case "de_filial"  ;  WF_Localiza_Filial()
	End Choose
End If
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge060_produto_procura_cliente
integer x = 46
integer y = 396
integer width = 3657
integer height = 1276
string dataobject = "dw_ge060_lista"
end type

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_linhas > 0 Then
	
	dw_1.AcceptText()
	
	Decimal lvdc_Vendas
	
	If dw_1.Object.Id_Valor[1] = "S" Then
					
		If Not wf_Calculo_Valor_Vendas_Grupo_Todas() Then pl_Linhas = -1	
		
		dw_2.Sort()
		dw_2.GroupCalc()
	End If
	
	If Not wf_Qtde_Vendida_filial() Then pl_Linhas = -1
End If

This.ivm_Menu.mf_SalvarComo(pl_Linhas > 0)

This.SetRedraw(True)

This.Sharedata( Dw_3 )

Return pl_Linhas

end event

event dw_2::ue_recuperar;//OverRide

Date lvdt_Inicio,&
	 lvdt_Termino

Long lvl_Filial, &
	 lvl_Produto
	 
String	 lvs_Id_Zero

dw_1.AcceptText()

lvdt_Inicio		= dw_1.Object.dt_periodo_de	[1]
lvdt_Termino	= dw_1.Object.dt_periodo_ate	[1]
lvl_Filial			= dw_1.Object.cd_filial			[1]
lvl_Produto		= dw_1.Object.cd_produto		[1]
lvs_Id_Zero		= dw_1.Object.id_zero            [1] 

If IsNull(lvdt_Inicio) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio corretamente.")
	dw_1.SetFocus()
	dw_1.Event ue_Pos(1, "dt_periodo_de")
	Return -1
End If

If IsNull(lvdt_Termino) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino corretamente.")
	dw_1.SetFocus()
	dw_1.Event ue_Pos(1, "dt_periodo_ate")
	Return -1
End If

If lvdt_Inicio > lvdt_Termino Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio deve ser menor que a de t$$HEX1$$e900$$ENDHEX$$rmino.")
	dw_1.SetFocus()
	dw_1.Event ue_Pos(1, "dt_periodo_de")
	Return -1
End If

If Not IsNull(lvl_Filial) Then
	This.Of_appendwhere("ppc.cd_filial = " + String(lvl_Filial) )
End If

If Not IsNull(lvl_Produto) Then
	This.Of_appendwhere("ppc.cd_produto = " + String(lvl_Produto) )
End If

This.Of_appendWhere("ppc.id_tipo = '"+String(lvs_Id_Zero)+"'")


Return This.Retrieve(lvdt_Inicio, lvdt_Termino)
end event

event dw_2::constructor;call super::constructor;wf_atualiza_ordenamento()
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge060_produto_procura_cliente
integer x = 3214
integer y = 24
integer width = 521
integer height = 312
integer taborder = 50
string dataobject = "dw_ge060_relatorio"
boolean hscrollbar = true
end type

event dw_3::ue_preprint;call super::ue_preprint;Date lvdt_Inicio	, &
     lvdt_Termino

String lvs_filial , &
		 lvs_produto

lvdt_Inicio		= dw_1.Object.dt_periodo_de [1]
lvdt_Termino	= dw_1.Object.dt_periodo_ate[1]

dw_3.Object.st_Periodo.Text = String(lvdt_Inicio , "dd/mm/yyyy") + " $$HEX1$$e000$$ENDHEX$$ " + &
									   String(lvdt_Termino, "dd/mm/yyyy")

If Not IsNull(dw_1.Object.cd_filial) Then
	dw_3.Object.st_filial.Text = dw_1.Object.de_filial[1] + ' (' + &
								 String(dw_1.Object.cd_filial[1])  + ')'
Else
	dw_3.Object.st_filial.Text = 'TODAS'
End If

If Not IsNull(dw_1.Object.cd_produto) Then
	dw_3.Object.st_produto.Text = dw_1.Object.de_produto[1] + ' (' + &
								  String(dw_1.Object.cd_produto[1])  + ')'
Else
	dw_3.Object.st_produto.Text = 'TODOS'
End If

dw_3.Sort()
dw_3.GroupCalc()

Return AncestorReturnValue
end event

