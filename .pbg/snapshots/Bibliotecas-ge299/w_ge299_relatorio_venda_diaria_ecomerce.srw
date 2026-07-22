HA$PBExportHeader$w_ge299_relatorio_venda_diaria_ecomerce.srw
forward
global type w_ge299_relatorio_venda_diaria_ecomerce from dc_w_selecao_lista_relatorio
end type
type cb_1 from commandbutton within w_ge299_relatorio_venda_diaria_ecomerce
end type
end forward

global type w_ge299_relatorio_venda_diaria_ecomerce from dc_w_selecao_lista_relatorio
string tag = "w_ge299_relatorio_venda_diaria_ecomerce"
integer width = 3712
integer height = 1872
string title = "GE299 - Relat$$HEX1$$f300$$ENDHEX$$rio de Vendas Di$$HEX1$$e100$$ENDHEX$$rias do e-Commerce"
long backcolor = 80269524
cb_1 cb_1
end type
global w_ge299_relatorio_venda_diaria_ecomerce w_ge299_relatorio_venda_diaria_ecomerce

type variables
uo_filial ivo_filial
end variables

forward prototypes
public subroutine wf_localiza_filial ()
end prototypes

public subroutine wf_localiza_filial ();STRING ls_filial	, &
		 lvs_nulo

Long   lvl_nulo

ls_filial = dw_1.GetText()

ivo_filial.Of_Localiza_Filial(ls_filial)

If ivo_filial.Localizada Then
	
	dw_1.Object.cd_filial[1] = ivo_filial.cd_filial
	dw_1.Object.de_filial[1] = ivo_filial.nm_fantasia
	
Else
	SetNull(lvl_nulo)
	SetNull(lvs_nulo)
	dw_1.Object.cd_filial[1] = lvl_nulo
	dw_1.Object.de_filial[1] = lvs_nulo
	
	ivo_filial.cd_filial	    = lvl_nulo
	ivo_filial.nm_fantasia   = lvs_nulo	
	
End If

end subroutine

on w_ge299_relatorio_venda_diaria_ecomerce.create
int iCurrent
call super::create
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
end on

on w_ge299_relatorio_venda_diaria_ecomerce.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
end on

event open;call super::open;ivo_filial = Create uo_filial 
end event

event close;call super::close;Destroy ivo_filial
end event

event ue_postopen;call super::ue_postopen;//This.ivm_Menu.ivb_Permite_Imprimir = True
//
//dw_1.Object.dt_inicio [1] = Today()
//dw_1.Object.dt_termino[1] = Today()
//
Date lvdt_Movimentacao 

This.ivm_Menu.ivb_Permite_Imprimir = True

lvdt_Movimentacao = Date(gvo_Parametro.of_DH_Movimentacao())

dw_1.Object.dt_Inicio [1] = DateTime(gf_Primeiro_Dia_Mes(lvdt_Movimentacao))

If Day(lvdt_Movimentacao) = 1 Then
	dw_1.Object.dt_Termino [1] = gvo_Parametro.of_DH_Movimentacao()
Else
	dw_1.Object.dt_Termino[1] = DateTime(RelativeDate(lvdt_Movimentacao, -1) )	
End If

// exclui o item TODAS
DataWindowChild ldw_Child
dw_1.GetChild("cd_filial_ecommerce", ldw_Child)
ldw_Child.deleterow( 1 ) 


end event

event ue_saveas;call super::ue_saveas;dw_3.Event ue_SaveAs()
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge299_relatorio_venda_diaria_ecomerce
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge299_relatorio_venda_diaria_ecomerce
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge299_relatorio_venda_diaria_ecomerce
integer x = 18
integer y = 376
integer width = 3621
integer height = 1292
integer weight = 700
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge299_relatorio_venda_diaria_ecomerce
integer x = 18
integer width = 1874
integer height = 340
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge299_relatorio_venda_diaria_ecomerce
integer x = 27
integer y = 80
integer width = 1842
integer height = 260
string dataobject = "dw_ge299_selecao"
end type

event dw_1::ue_key;STRING lvs_Coluna

IF Key = KeyEnter! THEN
	
	lvs_Coluna = THIS.GetColumnName()
	
	IF lvs_Coluna = "de_filial" THEN
		
		WF_Localiza_Filial()
	END IF
	
END IF
end event

event dw_1::itemchanged;call super::itemchanged;integer lvi_nulo
Choose Case dwo.Name 
	Case "de_filial"
	
		SetNull(lvi_Nulo)
	
		If Data = "" Or IsNull(Data) Then
			This.Object.cd_filial[1] = lvi_nulo			
			Return 0
		End If	
		
		If Data <> ivo_filial.nm_fantasia Then Return 1
		
End Choose
end event

event dw_1::ue_saveas;// OverRide

dw_2.Event ue_SaveAs()
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge299_relatorio_venda_diaria_ecomerce
integer x = 55
integer y = 456
integer width = 3552
integer height = 1192
string dataobject = "dw_ge299_lista"
end type

event dw_2::ue_retrieve;//Override

Long 	lvl_Max,				&
		lvl_Contador,		&
		lvl_Linha,				&
		lvl_Clientes,          &
		lvl_Find,				&
		lvl_cd_Filial,			&
		lvl_Tipo_Venda,	&
		lvl_Filial_DS,		&
		lvl_Filial_DS_Anterior

Long ll_Filial_EC

Date 	lvdt_Data				, &
		lvdt_Data_Anterior	, &
		lvdt_Inicio			, &
		lvdt_Termino

Decimal lvdc_Total_Venda

string lvs_Nm_Filial

dw_1.AcceptText()

lvdt_Inicio		= dw_1.Object.Dt_Inicio 					[1]
lvdt_Termino	= dw_1.Object.Dt_Termino				[1]
ll_Filial_EC		= dw_1.Object.cd_filial_Ecommerce	[1]

If IsNull(lvdt_Inicio) or Not IsDate(String(lvdt_Inicio)) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio corretamente.", Information!)
	dw_1.Event ue_Pos(1, "dt_inicio")
	Return -1
End If

If IsNull(lvdt_Termino) or Not IsDate(String(lvdt_Termino)) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino corretamente.", Information!)
	dw_1.Event ue_Pos(1, "dt_termino")	
	Return -1
End If

If lvdt_Inicio > lvdt_Termino Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de t$$HEX1$$e900$$ENDHEX$$rmino deve ser maior que a data de in$$HEX1$$ed00$$ENDHEX$$cio.", Information!)
	dw_1.Event ue_Pos(1, "dt_termino")	
	Return -1
End If

dc_uo_ds_Base lvds_1
lvds_1 = Create dc_uo_ds_Base
lvds_1.of_ChangeDataObject("ds_ge299_vendas")

dc_uo_ds_Base lvds_2
lvds_2 = Create dc_uo_ds_Base
lvds_2.of_ChangeDataObject("ds_ge299_devolucoes")

This.Reset()
This.SetRedraw(False)

lvl_cd_Filial = dw_1.Object.cd_Filial[1]

If Not IsNull(lvl_cd_Filial) Then
	lvds_1.of_AppendWhere("nf.cd_filial = " + string(lvl_cd_Filial))
	lvds_2.of_AppendWhere("nf.cd_filial = " + string(lvl_cd_Filial))
End If

Open(w_Aguarde)
w_Aguarde.Title = "Verificando Vendas do Per$$HEX1$$ed00$$ENDHEX$$odo..."
//vendas
lvds_1.Retrieve(lvdt_Inicio, lvdt_Termino, ll_Filial_EC )
//devolucao
lvds_2.Retrieve(lvdt_Inicio, lvdt_Termino, ll_Filial_EC)

//Deduz as devolucoes das vendas
For lvl_Contador = 1 To lvds_2.RowCount()
	lvdt_Data			= Date(lvds_2.Object.Dh_Movimentacao_Caixa[lvl_Contador])
	lvl_Tipo_Venda	= lvds_2.Object.Id_Pagamento		[lvl_Contador]
	lvl_Filial_Ds		= lvds_2.Object.cd_filial				[lvl_Contador]
	
	lvl_Find = lvds_1.Find("string(dh_movimentacao_caixa,'dd/mm/yyyy')='"+String(lvdt_Data,'dd/mm/yyyy')+"' and cd_filial="+String(lvl_Filial_Ds)+" and id_pagamento="+String(lvl_Tipo_Venda),1,lvds_1.RowCount())
	If Not(lvl_Find > 0) Then
		lvl_Find = lvds_1.InsertRow(0)
		
		lvds_1.Object.Dh_Movimentacao_Caixa	[lvl_Find] = lvdt_Data
		lvds_1.Object.Id_Pagamento				[lvl_Find] = lvl_Tipo_Venda
		lvds_1.Object.Vl_Total_Venda				[lvl_Find] = 0.00
		lvds_1.Object.Qt_Clientes					[lvl_Find] = 0
		lvds_1.Object.cd_filial							[lvl_Find] = lvl_Filial_Ds
		lvds_1.Object.nm_fantasia					[lvl_Find] = lvds_2.Object.nm_fantasia		[lvl_Contador]
	End If
	
	lvdc_Total_Venda	= lvds_1.Object.Vl_Total_Venda	[lvl_Find]
	lvl_Clientes			= lvds_1.Object.Qt_Clientes			[lvl_Find]
	
	lvds_1.Object.Vl_Total_Venda	[lvl_Find] = lvdc_Total_Venda 	- lvds_2.Object.Vl_Total_Devolucao	[lvl_Contador]
	lvds_1.Object.Qt_Clientes		[lvl_Find] = lvl_Clientes 			- lvds_2.Object.Qt_Clientes				[lvl_Contador]
Next

lvl_Max = lvds_1.RowCount()
If lvl_Max > 0 Then   

	w_Aguarde.uo_Progress.of_SetMax(lvl_Max)
	
	For lvl_Contador = 1 To lvl_Max
		
		lvdt_Data				= Date(lvds_1.Object.Dh_Movimentacao_Caixa[lvl_Contador])
		lvl_Tipo_Venda		= lvds_1.Object.Id_Pagamento		[lvl_Contador]
		lvdc_Total_Venda	= lvds_1.Object.Vl_Total_Venda	[lvl_Contador]
		lvl_Clientes			= lvds_1.Object.Qt_Clientes			[lvl_Contador]
		lvl_Filial_Ds			= lvds_1.Object.cd_filial				[lvl_Contador]
		lvs_Nm_Filial		= lvds_1.Object.nm_fantasia		[lvl_Contador]
		
		If lvdt_Data <> lvdt_Data_Anterior or lvl_Filial_Ds <> lvl_Filial_Ds_Anterior  Then				
			lvl_Linha = This.InsertRow(0)	
			
			This.Object.Dt_Venda					[lvl_Linha] = lvdt_Data
			This.Object.Vl_Venda_CT			[lvl_Linha] = 0.00
			This.Object.Vl_Venda_BL				[lvl_Linha] = 0.00
			This.Object.Vl_Venda_VL			[lvl_Linha] = 0.00
			This.Object.Vl_Venda_Trans_Elet	[lvl_Linha] = 0.00
			This.Object.nm_fantasia				[lvl_Linha] = lvs_Nm_Filial + " (" + string(lvl_Filial_DS) + ")"
						
			lvdt_Data_Anterior		= lvdt_Data
			lvl_Filial_Ds_Anterior	= lvl_Filial_Ds	
			
		End If
		
		
		Choose Case lvl_Tipo_Venda
			// BOLETO
			Case 3
				This.Object.Vl_Venda_BL		[lvl_Linha] = This.Object.Vl_Venda_BL	[lvl_Linha] + lvdc_Total_Venda
				This.Object.Qt_Cliente_BL	[lvl_Linha] = This.Object.Qt_Cliente_BL	[lvl_Linha] + lvl_Clientes	
				This.Object.cd_filial			[lvl_Linha] = lvl_Filial_Ds	
			// TRANSFERENCIA ELETR$$HEX1$$d400$$ENDHEX$$NICA
			Case 12, 19
				This.Object.vl_venda_trans_elet  	[lvl_Linha] = This.Object.vl_venda_trans_elet	[lvl_Linha] + lvdc_Total_Venda
				This.Object.qt_cliente_elet	 	 	[lvl_Linha] = This.Object.qt_cliente_elet			[lvl_Linha] + lvl_Clientes	
				This.Object.cd_filial			 		[lvl_Linha] = lvl_Filial_Ds	
			// CART$$HEX1$$d500$$ENDHEX$$ES
			Case 6, 7, 8, 24 
				This.Object.Vl_Venda_CT  	[lvl_Linha] = This.Object.Vl_Venda_CT	[lvl_Linha] + lvdc_Total_Venda
				This.Object.Qt_Cliente_CT	[lvl_Linha] = This.Object.Qt_Cliente_CT	[lvl_Linha] + lvl_Clientes	
				This.Object.cd_filial			[lvl_Linha] = lvl_Filial_Ds					
			// VALE COMPRA
			Case 100
				This.Object.Vl_Venda_VL  	[lvl_Linha] = This.Object.Vl_Venda_VL  	[lvl_Linha] + lvdc_Total_Venda
				This.Object.Qt_Cliente_VL	[lvl_Linha] = This.Object.Qt_Cliente_VL	[lvl_Linha] + lvl_Clientes	
				This.Object.cd_filial			[lvl_Linha] = lvl_Filial_Ds
			Case Else
				//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tipo de venda inv$$HEX1$$e100$$ENDHEX$$lida '" + string(lvl_Tipo_Venda) +"'.")
		End Choose
		
		This.Object.Qt_Clientes[lvl_Linha] = This.Object.Qt_Clientes[lvl_Linha] + lvl_Clientes
						
		w_Aguarde.uo_Progress.of_SetProgress(lvl_Contador)
		
	Next
	
	This.GroupCalc()
	
	//Estas linhas foram inseridas para for$$HEX1$$e700$$ENDHEX$$ar a atualiza$$HEX2$$e700e300$$ENDHEX$$o da dw_3 de relat$$HEX1$$f300$$ENDHEX$$rio,
	//visto que a mesma n$$HEX1$$e300$$ENDHEX$$o estava com os totais finais atualizados.
	lvl_Linha = This.InsertRow(0)	
	This.DeleteRow(lvl_Linha)
	/////////////////////////
	
	Parent.ivm_Menu.mf_Imprimir(True)
	//Parent.ivm_Menu.mf_Classificar(True)
	
	This.ivm_Menu.mf_SalvarComo(True)
		
	This.SetRedraw(True)
	This.SetFocus()
	
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.", Information!)
	Parent.ivm_Menu.mf_Imprimir(False)
	This.ivm_Menu.mf_SalvarComo(False)
	dw_1.SetFocus()
End If

Destroy(lvds_1)
Destroy(lvds_2)

Close(w_Aguarde)

Return 1
end event

event dw_2::ue_print;////OverRide
//Long lvl_Max,               &
//     lvl_Contador,          &
//	 lvl_Linha,             &
//	 lvl_Clientes,          &
//	 lvl_Find,              &
//	 lvl_cd_Filial,         &
//     lvl_Tipo_Venda,		&
//	 lvl_Filial_DS,         &
//	 lvl_Filial_DS_Anterior
//
//Date lvdt_Data,&
//     lvdt_Data_Anterior,&
//	 lvdt_Inicio,&
//	 lvdt_Termino
//
//Decimal lvdc_Total_Venda
//
//dw_1.AcceptText()
//
//lvdt_Inicio  = dw_1.Object.Dt_Inicio [1]
//lvdt_Termino = dw_1.Object.Dt_Termino[1]
//
//dc_uo_ds_Base lvds_1
//lvds_1 = Create dc_uo_ds_Base
//lvds_1.of_ChangeDataObject("dw_auxiliar_relatorio_venda_ecommerce")
//
//dw_3.Reset()
//dw_3.SetRedraw(False)
//
//lvl_cd_Filial = dw_1.Object.cd_Filial[1]
//
//dw_3.Object.t_periodo.Text = string(lvdt_Inicio,"dd/mm/yyyy")+' at$$HEX1$$e900$$ENDHEX$$ '+string(lvdt_Termino,"dd/mm/yyyy")
//dw_3.Object.t_filial.Text  = dw_1.Object.de_Filial[1]
//
//If Not IsNull(lvl_cd_Filial) Then
//	lvds_1.of_AppendWhere("nf.cd_filial = " + string(lvl_cd_Filial))
//End If
//
//lvl_Max = lvds_1.Retrieve(lvdt_Inicio, lvdt_Termino)
//
//If lvl_Max > 0 Then
//	
//	For lvl_Contador = 1 To lvl_Max
//		
//		lvdt_Data        = Date(lvds_1.Object.Dh_Movimentacao_Caixa[lvl_Contador])
//		lvl_Tipo_Venda   = lvds_1.Object.Id_Pagamento   [lvl_Contador]
//		lvdc_Total_Venda = lvds_1.Object.Vl_Total_Venda [lvl_Contador]
//		lvl_Clientes     = lvds_1.Object.Qt_Clientes    [lvl_Contador]
//		lvl_Filial_Ds    = lvds_1.Object.cd_filial      [lvl_Contador]	
//
//		If lvdt_Data <> lvdt_Data_Anterior or lvl_Filial_Ds <> lvl_Filial_Ds_Anterior  Then				
//			lvl_Linha = dw_3.InsertRow(0)			
//			dw_3.Object.Dt_Venda   [lvl_Linha] = lvdt_Data
//			dw_3.Object.Vl_Venda_CT[lvl_Linha] = 0.00
//			dw_3.Object.Vl_Venda_BL[lvl_Linha] = 0.00
//			dw_3.Object.Vl_Venda_VL[lvl_Linha] = 0.00					
//			lvdt_Data_Anterior     = lvdt_Data
//			lvl_Filial_Ds_Anterior = lvl_Filial_Ds				
//		End If		
//		
//		Choose Case lvl_Tipo_Venda
//			Case 3
//				dw_3.Object.Vl_Venda_CT  [lvl_Linha] = lvdc_Total_Venda
//				dw_3.Object.Qt_Cliente_CT[lvl_Linha] = lvl_Clientes	
//				dw_3.Object.cd_filial[lvl_Linha]     = lvl_Filial_Ds
//			Case 6, 7, 8 
//				dw_3.Object.Vl_Venda_BL  [lvl_Linha] = dw_3.Object.Vl_Venda_BL  [lvl_Linha] + lvdc_Total_Venda
//				dw_3.Object.Qt_Cliente_BL[lvl_Linha] = dw_3.Object.Qt_Cliente_BL[lvl_Linha] + lvl_Clientes
//				dw_3.Object.cd_filial[lvl_Linha]     = lvl_Filial_Ds	
//			Case 100
//				dw_3.Object.Vl_Venda_VL  [lvl_Linha] = lvdc_Total_Venda
//				dw_3.Object.Qt_Cliente_VL[lvl_Linha] = lvl_Clientes	
//				dw_3.Object.cd_filial[lvl_Linha]     = lvl_Filial_Ds
//		End Choose
//		
//		dw_3.Object.Qt_Clientes[lvl_Linha] = dw_3.Object.Qt_Clientes[lvl_Linha] + lvl_Clientes
//		
//		dw_3.GroupCalc()
//		
//	Next
//	dw_3.SetRedraw(True)	
//End If
//
//Destroy(lvds_1)
//
//Long lvl_Linhas
//
//SetPointer(HourGlass!)
//
//lvl_Linhas = dw_3.Event ue_PrePrint()
//
//If lvl_Linhas <> -1 Then
//	If lvl_Linhas > 0 Then
//		dw_3.of_Print(False)
//	Else
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existem informa$$HEX2$$e700f500$$ENDHEX$$es para impress$$HEX1$$e300$$ENDHEX$$o.", Information!)
//	End If
//End If
//
//SetPointer(Arrow!)
//
////Return 1
end event

event dw_2::constructor;call super::constructor;This.ivb_Ordena_Colunas = True
end event

event dw_2::clicked;// OverRide

//This.Sort()
//This.GroupCalc()

If Row > 0 Then This.SetRow(Row)

String lvs_titulo
String lvs_coluna
String lvs_sort_atual
String lvs_Cabecalho

Integer lvi_tamanho

If This.RowCount() > 0 and ivb_Ordena_Colunas and Row = 0 Then

	lvs_titulo 		= This.GetObjectAtPointer()
	lvs_Cabecalho  = This.GetBandAtPointer()
		
	If LeftA(lvs_Cabecalho, 6) = "header" Then
		
		lvi_tamanho = PosA(lvs_titulo,CharA(9))-1
		
		If lvi_tamanho > 0 Then
			
			lvs_titulo = LeftA(lvs_titulo, lvi_tamanho)
			
			This.of_Marca_Coluna_Ativa_Ordenacao(lvs_titulo)
			
			lvs_Coluna = LeftA(lvs_Titulo,lvi_Tamanho -2 )
					
			lvs_sort_atual = This.Object.DataWindow.Table.Sort
			
			lvi_tamanho 	= LenA(lvs_sort_atual) - 2
			lvs_titulo  	= LeftA(lvs_sort_atual, lvi_tamanho)
			
			If lvs_coluna = lvs_titulo Then
				
				lvs_sort_atual = RightA(lvs_sort_atual, 1)
				
				If lvs_sort_atual = "A" Then
					lvs_sort_atual = " D"
				Else
					lvs_sort_atual = " A"
				End If
				
				lvs_coluna = lvs_coluna + lvs_sort_atual
			Else
				lvs_coluna += " A"				
			End If
			
			This.SetSort(lvs_coluna)
			This.Sort()
			This.GroupCalc()
		End If	
		
	End If
	
End If	
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge299_relatorio_venda_diaria_ecomerce
integer x = 2967
integer y = 24
integer width = 590
integer taborder = 50
string dataobject = "dw_ge299_relatorio"
end type

event dw_3::ue_preprint;call super::ue_preprint;this.Object.t_periodo.Text = string(dw_1.Object.dt_inicio[1],"dd/mm/yyyy")+&
                             ' $$HEX1$$e000$$ENDHEX$$ '+string(dw_1.Object.dt_termino[1],"dd/mm/yyyy")
this.Object.t_filial.Text  = dw_1.Object.de_Filial[1]

This.Object.t_rede.Text = dw_1.Describe("Evaluate('LookUpDisplay(cd_filial_ecommerce)', 1)")

Return AncestorReturnValue
end event

event dw_3::ue_saveas;call super::ue_saveas;//override
This.Event ue_PrePrint()

SUPER::EVENT ue_SaveAs()
end event

type cb_1 from commandbutton within w_ge299_relatorio_venda_diaria_ecomerce
integer x = 1911
integer y = 260
integer width = 791
integer height = 96
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Exportar Planilha Vendas"
end type

event clicked;// OverRide

String lvs_Arquivo, &
       lvs_Diretorio

Integer lvi_Retorno,&
		lvi_Retrieve

Date lvdt_Inicio,&
	 lvdt_Termino

Long ll_Filial_EC

dw_1.AcceptText()

lvdt_Inicio		= dw_1.Object.Dt_Inicio 		[1]
lvdt_Termino	= dw_1.Object.Dt_Termino	[1]
ll_Filial_EC		= dw_1.Object.cd_filial_ecommerce[1]

dc_uo_ds_base lvds 

lvds = Create dc_uo_ds_base

lvds.of_ChangeDataObject("dw_ge299_excel")

lvi_Retrieve = lvds.Retrieve(lvdt_Inicio, lvdt_Termino, ll_Filial_EC)

If lvi_Retrieve > 0 Then
	
	lvds.Sort()
	lvds.GroupCalc()
	
	// Verifica o nome do arquivo
	lvi_Retorno = GetFileSaveName("Selecione o caminho do arquivo", &
											lvs_Diretorio	, &
											lvs_Arquivo	, &
											"XLS", "Arquivos do Excel (*.XLS),*.XLS,")
	
	If lvi_Retorno = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Ocorreu um erro durante a chamada da janela de sele$$HEX2$$e700e300$$ENDHEX$$o do arquivo.", StopSign!)
		Return 
	Else
		If lvi_Retorno = 0 Then Return
	End If
	
	lvs_Diretorio = Upper(lvs_Diretorio)
	
	// Verifica se j$$HEX1$$e100$$ENDHEX$$ existe o arquivo
	If FileExists(lvs_Diretorio) Then
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja substituir o arquivo '" + lvs_Diretorio + "' existente ?", Question!, YesNo!, 1) =  1 Then 
			If Not FileDelete(lvs_Diretorio) Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na exclus$$HEX1$$e300$$ENDHEX$$o do arquivo '" + lvs_Diretorio + "'.", StopSign!)
				Return
			End If
		Else
			Return 
	   End If   
	End If
	
	// Salva o arquivo
	lvi_Retorno = lvds.SaveAs(lvs_Diretorio, Excel!, True)
	
	If lvi_Retorno <> 1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao salvar o arquivo '" + lvs_Diretorio + "'.", StopSign!)	
		Return 
	Else
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Arquivo '" + lvs_Diretorio + "' salvo com sucesso.", Information!)
	End If
	
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao recuperar as informa$$HEX2$$e700f500$$ENDHEX$$es para salvar a planilha excel.")
	Return
End If
end event

