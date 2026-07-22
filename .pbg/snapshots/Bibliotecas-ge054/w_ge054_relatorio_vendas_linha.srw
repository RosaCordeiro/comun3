HA$PBExportHeader$w_ge054_relatorio_vendas_linha.srw
forward
global type w_ge054_relatorio_vendas_linha from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge054_relatorio_vendas_linha from dc_w_selecao_lista_relatorio
integer x = 0
integer y = 0
integer width = 1902
integer height = 1820
string title = "GE054 - Relat$$HEX1$$f300$$ENDHEX$$rio Vendas por Linha"
boolean resizable = false
end type
global w_ge054_relatorio_vendas_linha w_ge054_relatorio_vendas_linha

type variables
uo_Filial ivo_Filial
uo_vendedor   ivo_vendedor
uo_produto ivo_produto
end variables

forward prototypes
public subroutine wf_localiza_filial ()
public subroutine wf_localiza_vendedor (string ps_vendedor)
public subroutine wf_localiza_produto ()
public subroutine wf_verifica_devolucoes ()
end prototypes

public subroutine wf_localiza_filial ();String lvs_Filial
Long lvl_Filial

SetNull(lvl_Filial)
lvs_Filial = dw_1.GetText()

ivo_Filial.of_Localiza_Filial(lvs_Filial)

If ivo_Filial.Localizada Then
	dw_1.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial
	dw_1.Object.De_Filial[1] = ivo_Filial.Nm_Fantasia
Else
	dw_1.Object.Cd_Filial[1] = lvl_Filial
	dw_1.Object.De_Filial[1] = ""
End If
end subroutine

public subroutine wf_localiza_vendedor (string ps_vendedor);String lvs_nulo
ivo_Vendedor.of_Localiza_Vendedor(ps_Vendedor)

If ivo_Vendedor.Localizado Then
	dw_1.Object.Cd_Vendedor[1] = ivo_Vendedor.Nr_Matricula_Vendedor
	dw_1.Object.de_Vendedor[1] = ivo_Vendedor.Nm_Usuario
Else
	SetNull(lvs_nulo)
	dw_1.Object.Cd_Vendedor[1] = lvs_nulo
	dw_1.Object.de_Vendedor[1] = lvs_nulo
End If

This.ivm_Menu.Mf_Recuperar(True)
end subroutine

public subroutine wf_localiza_produto ();String lvs_Produto

lvs_Produto = dw_1.GetText()

ivo_Produto.of_Localiza_Produto(lvs_Produto)

If ivo_Produto.Localizado Then
	dw_1.Object.Cd_Produto[1] = ivo_Produto.Cd_Produto
	dw_1.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
	If IsNull(ivo_Produto.Cd_Linha_Produto) Then
		dw_1.Object.cd_linha  [1] = "0"
	Else	
		dw_1.Object.cd_linha  [1] = ivo_Produto.Cd_Linha_Produto
	End If	
End If
end subroutine

public subroutine wf_verifica_devolucoes ();DateTime lvdt_Inicio, lvdt_Termino, lvdt_Movimento

String lvs_Linha, lvs_Vendedor, lvs_Totalizar, lvs_Parametro, lvs_Nome_Vendedor

Long   lvl_Filial,& 
	   lvl_Produto,& 
	   lvl_Linhas,& 
	   lvl_Linha,& 
	   lvl_Devolucoes,&
	   lvl_Find,&
	   lvl_Insert

Decimal lvdc_Devolucoes

dw_1.AcceptText()

lvdt_Inicio   		= dw_1.Object.dt_Inicio 				[1]
lvdt_Termino  		= dw_1.Object.dt_Termino				[1]
lvs_Linha  			= dw_1.Object.cd_linha   				[1]
lvl_Filial 			= dw_1.Object.cd_filial  				[1]
lvl_Produto	 		= dw_1.Object.cd_produto 				[1]
lvs_Vendedor  		= dw_1.Object.cd_vendedor				[1]
lvs_Totalizar 		= dw_1.Object.id_totalizado_por_vendedor[1]

dc_uo_ds_base lvds
lvds = Create dc_uo_ds_base

If lvs_Totalizar = 'N' Then
	If Not lvds.of_ChangeDataObject("dw_lista_devolucao_vendas_linha") Then
		Destroy(lvds)
		Return 
	End If
Else
	If Not lvds.of_ChangeDataObject("dw_lista_devolucao_vendas_linha_vendedor") Then
		Destroy(lvds)
		Return 
	End If
End If

If Not IsNull(lvl_produto) Then
	lvds.Of_AppendWhere("i.cd_produto = " + String(lvl_produto))
Else
	lvds.Of_AppendWhere("p.cd_linha_produto = '" + lvs_Linha + "'")
End If	 

If Not IsNull(lvs_Vendedor) Then
	lvds.Of_AppendWhere("n.nr_matricula_vendedor = '" + lvs_Vendedor + "'")
End If

lvl_Linhas  = lvds.Retrieve(lvdt_Inicio, lvdt_Termino, lvl_Filial)

For lvl_Linha = 1 To lvl_Linhas
	
	lvdt_Movimento 	= lvds.Object.dh_movimentacao_caixa	[lvl_Linha]
	lvl_Devolucoes 	= lvds.Object.qt_devolvida			[lvl_Linha]
	lvdc_Devolucoes	= lvds.Object.vl_vendas				[lvl_Linha]
	
	lvl_Devolucoes 	= lvl_Devolucoes * (-1)
	lvdc_Devolucoes = lvdc_Devolucoes * (-1)
	
	lvs_Parametro = String(lvdt_Movimento, "yyyy/mm/dd hh:mm:ss")
	
	If lvs_Totalizar = 'N' Then
		lvl_Find = dw_2.Find("dh_movimentacao_caixa = DateTime('" + lvs_Parametro + "')", 1, dw_2.RowCount())
	Else
		lvs_Vendedor    	= lvds.Object.nr_matricula_vendedor	[lvl_Linha]
		lvs_Nome_Vendedor	= lvds.Object.nm_usuario			[lvl_Linha]
		
		lvl_Find = dw_2.Find("nr_matricula_vendedor =  '" + lvs_Vendedor +&
				   "' and dh_movimentacao_caixa = DateTime('" + lvs_Parametro + "')", 1, dw_2.RowCount())
	End If
	
	If lvl_Find = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar as devolu$$HEX2$$e700f500$$ENDHEX$$es.")
		Exit
	End If 
	
	If lvl_Find > 0 Then
		dw_2.Object.qt_vendida	[lvl_Find] 	= dw_2.Object.qt_vendida	[lvl_Find] + lvl_Devolucoes
		dw_2.Object.vl_vendas	[lvl_Find] 	= dw_2.Object.vl_vendas		[lvl_Find] + lvdc_Devolucoes
	End If
	
	If lvl_Find = 0 Then
		lvl_Insert = dw_2.InsertRow(0) 
		
		If lvs_Totalizar = 'S' Then
			dw_2.Object.nr_matricula_vendedor[lvl_Insert] = lvs_Vendedor
			dw_2.Object.nm_usuario			 [lvl_Insert] = lvs_Nome_Vendedor
		End If
		
		dw_2.Object.dh_movimentacao_caixa	[lvl_Insert] = lvdt_Movimento
		dw_2.Object.qt_vendida			 	[lvl_Insert] = lvl_Devolucoes
		dw_2.Object.vl_vendas				[lvl_Insert] = lvdc_Devolucoes
	End If
		
Next

Destroy(lvds)
end subroutine

on w_ge054_relatorio_vendas_linha.create
call super::create
end on

on w_ge054_relatorio_vendas_linha.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;ivo_Produto 		= Create uo_Produto
ivo_Filial   		= Create uo_Filial
ivo_vendedor 	= Create uo_vendedor

dw_1.Object.dt_inicio		[1] 	= DateTime(gf_primeiro_dia_mes(today()),Time('00:00'))
dw_1.Object.dt_termino	[1] 	= Today()

This.ivm_Menu.ivb_Permite_Imprimir = True

IF gvo_parametro.Of_filial() <> gvo_parametro.Of_filial_matriz() THEN
	dw_1.Object.cd_filial[1] = gvo_parametro.Of_filial()
	dw_1.Object.de_filial[1] = gvo_parametro.nm_fantasia_filial
	dw_1.Object.de_filial.protect = 1

	ivo_filial.cd_filial   		= dw_1.Object.cd_filial[1]
	ivo_filial.nm_fantasia 	= dw_1.Object.de_filial[1]

END IF

DataWindowChild dwc_linha

dwc_linha = dw_1.of_InsertRow_DDDW("cd_linha" )			

dwc_linha.SetItem(1, "cd_linha_produto", "0"  	  )
dwc_linha.SetItem(1, "de_linha_produto", "TODOS"  )

dw_1.Object.cd_linha[1] = "0"

Timer( 300, This ) // 5 minutos - Chamado 308259
end event

event ue_preprint;call super::ue_preprint;Datetime lvdt_Inicio, &
         lvdt_Termino
	  
String lvs_Linha, lvs_Filial

DATAWINDOWCHILD lvdwc_linha

dw_1.GetChild("cd_linha",lvdwc_linha)

lvs_Linha = lvdwc_linha.GetItemString(lvdwc_linha.GetRow(),"de_linha_produto") + ' (' + dw_1.Object.cd_linha[1] +')'

lvdt_Inicio  = dw_1.Object.Dt_Inicio[1]
lvdt_Termino = dw_1.Object.Dt_Termino[1]

dw_3.Object.Periodo.Text = String(lvdt_Inicio , "dd/mm/yyyy") + " at$$HEX1$$e900$$ENDHEX$$ : " + &
								   String(lvdt_Termino, "dd/mm/yyyy")									
									
dw_3.Object.Linha.Text   = lvs_Linha									

IF NOT IsNull(dw_1.Object.Cd_Filial[1]) THEN
	lvs_Filial = dw_1.Object.De_Filial[1] + '( ' + String(dw_1.Object.Cd_Filial[1]) + ')'
ELSE
	lvs_Filial = "TODAS"
END IF	

dw_3.Object.Filial.Text = lvs_Filial

If dw_1.Object.id_totalizado_por_vendedor[1] = 'N' Then
	If Not IsNull(dw_1.Object.cd_vendedor[1]) Then
		dw_3.Object.st_vendedor.Text = Trim(dw_1.Object.de_vendedor[1]) + ' (' + &
														dw_1.Object.cd_vendedor[1]  + ')'
	Else
		dw_3.Object.st_vendedor.Text = 'TODOS'
	End If
End If

Return AncestorReturnValue
end event

event close;call super::close;If IsValid(ivo_Produto) 	Then Destroy(ivo_Produto)
If IsValid(ivo_Filial) 		Then Destroy(ivo_Filial)
If IsValid(ivo_vendedor) 	Then Destroy(ivo_vendedor)
end event

event timer;call super::timer;Return Close( This )
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge054_relatorio_vendas_linha
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge054_relatorio_vendas_linha
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge054_relatorio_vendas_linha
integer x = 32
integer y = 524
integer width = 1824
integer height = 1112
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge054_relatorio_vendas_linha
integer width = 1824
integer height = 496
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge054_relatorio_vendas_linha
integer x = 55
integer y = 80
integer width = 1792
integer height = 416
string dataobject = "dw_selecao_vendas_linha"
end type

event dw_1::itemchanged;call super::itemchanged;String lvs_nulo
//
LONG  lvl_Nulo
//
SetNull(lvl_Nulo)
//
Choose Case dwo.Name
		
	Case "de_filial"
		
		If Trim(Data) <> "" Then
			If Data <> ivo_Filial.nm_Fantasia Then
				Return 1
			End If
		Else
			This.Object.Cd_Filial[1] = lvl_Nulo
			ivo_Filial.Nm_Fantasia   = ""
		End If
		
	Case "de_vendedor" 

		If Not IsNull(Data) and Trim(Data) <> '' Then
			If Data <> ivo_Vendedor.nm_usuario Then
				Return 1
			End If
		Else
			ivo_Vendedor.of_Inicializa()
			
			This.Object.Cd_Vendedor[1] = ivo_Vendedor.Nr_Matricula_Vendedor
			This.Object.de_Vendedor[1] = ivo_Vendedor.Nm_Usuario
		End If
		
		
	Case "de_produto"
		If Trim(Data) <> "" Then
			If Data <> ivo_Produto.ivs_Descricao_Apresentacao_Venda Then
				Return 1
			Else
				This.Object.Cd_Linha[1] = "0"
			End If
		Else
			This.Object.Cd_Produto[1] = lvl_Nulo
			ivo_Produto.ivs_Descricao_Apresentacao_Venda = ""
		End If	
End Choose
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Filial) Then
	This.Object.de_Filial[1] = ivo_Filial.Nm_Fantasia
End If

If IsValid(ivo_Produto) Then
	dw_1.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
End If

end event

event dw_1::ue_key;String lvs_Coluna

If Key = KeyEnter! Then
	lvs_Coluna = This.GetColumnName()
	
	Choose Case lvs_Coluna
		Case "de_filial"
			wf_localiza_filial()			
		Case "de_vendedor" 
		   Wf_Localiza_Vendedor(This.GetText())	
		Case "de_produto"
			wf_Localiza_Produto()		
	End Choose
End If
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge054_relatorio_vendas_linha
integer x = 78
integer y = 576
integer width = 1733
integer height = 1044
string dataobject = "dw_lista_vendas_linha"
end type

event dw_2::ue_recuperar;//OVERRIDE
LONG     lvl_Linhas		, &
			lvl_cd_filial
			
DATETIME lvdt_Inicio, lvdt_Termino
//
dw_1.AcceptText()
//
lvdt_Inicio   = dw_1.Object.dt_Inicio [1]
lvdt_Termino  = dw_1.Object.dt_Termino[1]
lvl_cd_filial = dw_1.Object.cd_filial [1]
//
lvl_Linhas    = THIS.Retrieve(lvdt_Inicio,lvdt_Termino,lvl_cd_filial)
//
RETURN lvl_Linhas
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;STRING lvs_Linha			, &	
		 lvs_cd_vendedor	, &
		 lvs_id_totalizado_por_vendedor

LONG   lvl_Filial
LONG   lvl_Produto

THIS.AcceptText()

lvs_Linha  		 					 = dw_1.Object.cd_linha   					  [1]
lvl_Filial 		 					 = dw_1.Object.cd_filial  					  [1]
lvl_Produto							 = dw_1.Object.cd_produto 					  [1]
lvs_cd_vendedor 					 = dw_1.Object.cd_vendedor					  [1]
lvs_id_totalizado_por_vendedor = dw_1.Object.id_totalizado_por_vendedor[1]

IF IsNull(lvl_Filial) THEN
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Favor informar a Filial.",Exclamation!)
	RETURN -1
END IF	

If IsNull(lvl_produto) THEN
	IF IsNull(lvs_Linha) or lvs_Linha = "0" Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Favor informar a Linha ou o Produto para consulta.",Exclamation!)
		RETURN -1
	End If	
End IF	

If lvs_id_totalizado_por_vendedor = 'N' Then
	dw_2.DataObject = 'dw_lista_vendas_linha'
	dw_3.DataObject = 'dw_relatorio_vendas_linha'
Else
	dw_2.DataObject = 'dw_lista_vendas_linha_vendedor'
	dw_3.DataObject = 'dw_relatorio_vendas_linha_vendedor'
End If

dw_2.SetTransObject(SQLCA)
dw_3.SetTransObject(SQLCA)

If Not IsNull(lvl_produto) Then
	THIS.Of_AppendWhere("item_nf_venda.cd_produto = " + String(lvl_produto))
Else
	THIS.Of_AppendWhere("produto_geral.cd_linha_produto = '" + lvs_Linha + "'")
End If	 

If Not IsNull(lvs_cd_vendedor) Then
	THIS.Of_AppendWhere("nf_venda.nr_matricula_vendedor = '" + lvs_cd_vendedor + "'")
End If

//This.ShareData(dw_3)
This.of_SetRowSelection()

RETURN 1
end event

event dw_2::ue_postretrieve;//OverRide

Boolean lvb_Classificar, &
        lvb_Filtrar, &
		  lvb_Localizar, &
		  lvb_Imprimir

If pl_Linhas > 0 Then
	lvb_Classificar = IsValid(This.ivo_Sort)
	lvb_Filtrar     = IsValid(This.ivo_Filter)
	lvb_Localizar   = IsValid(This.ivo_Find)
	
	lvb_Imprimir = True

	This.Event RowFocusChanged(1)
	This.SetRow(1)
	This.SetFocus()
Else
//	If pl_Linhas = 0 Then
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.", Information!)
//	End If
End If

Parent.ivm_Menu.mf_Classificar(lvb_Classificar)
Parent.ivm_Menu.mf_Filtrar(lvb_Filtrar)
Parent.ivm_Menu.mf_Localizar(lvb_Localizar)
Parent.ivm_Menu.mf_Imprimir(lvb_Imprimir)

wf_Verifica_Devolucoes()
This.GroupCalc()

This.ShareData(dw_3)

If dw_2.RowCount() = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.", Information!)
End If	

Return pl_Linhas
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge054_relatorio_vendas_linha
integer x = 1234
integer y = 8
integer width = 183
integer height = 144
integer taborder = 50
string dataobject = "dw_relatorio_vendas_linha"
end type

