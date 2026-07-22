HA$PBExportHeader$w_ge146_rel_venda_diaria_disque.srw
forward
global type w_ge146_rel_venda_diaria_disque from dc_w_selecao_lista_relatorio
end type
type cb_1 from commandbutton within w_ge146_rel_venda_diaria_disque
end type
end forward

global type w_ge146_rel_venda_diaria_disque from dc_w_selecao_lista_relatorio
string tag = "w_ge146_rel_venda_diaria_disque"
integer width = 4283
integer height = 1992
string title = "GE146 - Vendas Di$$HEX1$$e100$$ENDHEX$$rias Disque Entrega"
boolean resizable = false
cb_1 cb_1
end type
global w_ge146_rel_venda_diaria_disque w_ge146_rel_venda_diaria_disque

type variables
uo_filial ivo_filial
end variables

forward prototypes
public subroutine wf_localiza_filial ()
end prototypes

public subroutine wf_localiza_filial ();String ls_Filial

dw_1.AcceptText()

ls_filial = dw_1.GetText()

ivo_filial.Of_Localiza_Filial(ls_filial)

If ivo_filial.Localizada Then
	
	dw_1.Object.cd_filial[1] = ivo_filial.cd_filial
	dw_1.Object.de_filial[1] = ivo_filial.nm_fantasia
	
Else
	ivo_Filial.of_Inicializa()
	
//	SetNull(lvl_nulo)
//	SetNull(lvs_nulo)

	dw_1.Object.cd_filial[1] = ivo_Filial.Cd_Filial
	dw_1.Object.de_filial[1] = ivo_Filial.Nm_Fantasia
	
//	ivo_filial.cd_filial	    = lvl_nulo
//	ivo_filial.nm_fantasia   = lvs_nulo	
	
End If

end subroutine

on w_ge146_rel_venda_diaria_disque.create
int iCurrent
call super::create
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
end on

on w_ge146_rel_venda_diaria_disque.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
end on

event ue_postopen;call super::ue_postopen;ivo_filial = create uo_filial

Date lvdt_Parametro, &
     lvdt_Inicio

lvdt_Parametro = Date(gvo_Parametro.of_Dh_Movimentacao())

lvdt_Inicio = RelativeDate(lvdt_Parametro, -1)

dw_1.Object.Dt_Inicio		[1] = lvdt_Inicio
dw_1.Object.Dt_Termino	[1] = lvdt_Parametro

This.ivm_Menu.ivb_Permite_Imprimir = True
end event

event close;call super::close;Destroy(ivo_filial)
end event

event ue_saveas;call super::ue_saveas;dw_3.Event ue_SaveAs()
end event

event ue_printimmediate;//OverRide

dw_2.Event ue_Imprimir_Relatorio(dw_2.Title, 'DI', True)
end event

event ue_print;//OverRide

dw_2.Event ue_Imprimir_Relatorio(dw_2.Title, 'DI', False)
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge146_rel_venda_diaria_disque
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge146_rel_venda_diaria_disque
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge146_rel_venda_diaria_disque
integer x = 23
integer y = 284
integer width = 4219
integer height = 1516
string text = "Vendas"
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge146_rel_venda_diaria_disque
integer x = 32
integer y = 4
integer width = 2418
integer height = 276
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge146_rel_venda_diaria_disque
integer x = 64
integer y = 60
integer width = 2363
integer height = 188
string dataobject = "dw_ge146_selecao"
end type

event dw_1::ue_key;call super::ue_key;STRING lvs_Coluna

IF Key = KeyEnter! THEN
	
	lvs_Coluna = THIS.GetColumnName()
	
	IF lvs_Coluna = "de_filial" THEN
		
		WF_Localiza_Filial()
	END IF
	
END IF
end event

event dw_1::itemchanged;call super::itemchanged;String ls_Dw

Choose Case Dwo.Name		
	Case 'de_filial' 
		If Data <> ivo_filial.nm_fantasia Then
			If Data <> '' Then
				Return 1
			Else
				ivo_filial.of_inicializa( )
				This.Object.cd_filial[Row] = ivo_filial.cd_filial
				This.Object.de_filial[Row] = ivo_filial.nm_fantasia
			End If
		End If
End Choose
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge146_rel_venda_diaria_disque
integer x = 50
integer y = 356
integer width = 4165
integer height = 1404
string title = "Relat$$HEX1$$f300$$ENDHEX$$rio de Vendas do Disque Entrega"
string dataobject = "dw_ge146_lista_sint_filial"
end type

event dw_2::ue_reset;call super::ue_reset;This.ivm_menu.mf_SalvarComo(False)
end event

event dw_2::ue_retrieve;call super::ue_retrieve;//Override

Long	lvl_Max		, &
		lvl_Contador, &
		lvl_Linha		, &
		lvl_Clientes	, &
		lvl_Find		, &
		lvl_Filial		, &
		lvl_Filial_Ant

String lvs_Tipo_Venda, &
		 lvs_Nome_Fantasia, &
		 ls_Tipo, &
		 ls_Dw_Lista, &
		 ls_Ds_Venda, &
		 ls_Ds_Dev

Date	lvdt_Data				, &
		lvdt_Data_Anterior	, &
		lvdt_Inicio			, &
		lvdt_Termino

Decimal lvdc_Total_Venda

dw_1.AcceptText()

//Reinicia o filtro de par$$HEX1$$e200$$ENDHEX$$metros selecionados para gerar o relat$$HEX1$$f300$$ENDHEX$$rio
This.ivs_Filtro_Relatorio = {""}

lvl_Filial			= dw_1.Object.Cd_Filial		[1]
lvdt_Inicio		= dw_1.Object.Dt_Inicio		[1]
lvdt_Termino	= dw_1.Object.Dt_Termino	[1]
ls_Tipo			= dw_1.Object.Id_Tipo		[1]

//If IsNull(lvl_Filial) Then
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Filial n$$HEX1$$e300$$ENDHEX$$o pode ser nula.", Information!)
//	dw_1.Event ue_Pos(1, "de_filial")
//	Return -1
//End If

If IsNull(lvdt_Inicio) or Not IsDate(String(lvdt_Inicio)) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio corretamente.", Exclamation!)
	dw_1.Event ue_Pos(1, "dt_inicio")
	Return -1
End If

If IsNull(lvdt_Termino) or Not IsDate(String(lvdt_Termino)) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino corretamente.", Exclamation!)
	dw_1.Event ue_Pos(1, "dt_termino")	
	Return -1
End If

If lvdt_Inicio > lvdt_Termino Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de t$$HEX1$$e900$$ENDHEX$$rmino deve ser maior que a data de in$$HEX1$$ed00$$ENDHEX$$cio.", Exclamation!)
	dw_1.Event ue_Pos(1, "dt_termino")	
	Return -1
End If

Choose Case ls_Tipo
	Case "A"	//Anal$$HEX1$$ed00$$ENDHEX$$tico
		ls_Dw_Lista = "dw_ge146_lista"
		ls_Ds_Venda = "ds_ge146_venda_diaria"
		ls_Ds_Dev = "ds_ge146_devolucao_diaria"
		This.ivs_Filtro_Relatorio[UpperBound(This.ivs_Filtro_Relatorio)+1] = 'Tipo: ANAL$$HEX1$$cd00$$ENDHEX$$TICO'
		
	Case "D" //Sint$$HEX1$$e900$$ENDHEX$$tico por Datas
		ls_Dw_Lista = "dw_ge146_lista_sintetico"
		ls_Ds_Venda = "ds_ge146_venda_diaria_sintetico"
		ls_Ds_Dev = "ds_ge146_devolucao_diaria_sintetico"		
		This.ivs_Filtro_Relatorio[UpperBound(This.ivs_Filtro_Relatorio)+1] = 'Tipo: SINT$$HEX1$$c900$$ENDHEX$$TICO POR DATA'
		
	Case "F" //Sint$$HEX1$$e900$$ENDHEX$$tico por Filial
		ls_Dw_Lista = "dw_ge146_lista_sint_filial"
		ls_Ds_Venda = "ds_ge146_venda_diaria_sint_filial"
		ls_Ds_Dev = "ds_ge146_devolucao_diaria_sint_filial"		
		This.ivs_Filtro_Relatorio[UpperBound(This.ivs_Filtro_Relatorio)+1] = 'Tipo: SINT$$HEX1$$c900$$ENDHEX$$TICO POR FILIAL'
End Choose

If This.DataObject <> ls_Dw_Lista Then
	If Not This.of_ChangeDataObject(ls_Dw_Lista) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar a dw_2 " + ls_Dw_Lista, StopSign!)
		Return -1
	End If
End If

This.of_SetRowSelection()

dc_uo_ds_Base lvds_1
lvds_1 = Create dc_uo_ds_Base
lvds_1.of_ChangeDataObject(ls_Ds_Venda)

dc_uo_ds_Base lvds_2
lvds_2 = Create dc_uo_ds_Base
lvds_2.of_ChangeDataObject(ls_Ds_Dev)

This.Reset()
This.SetRedraw(False)

If lvl_Filial > 0 Then
	lvds_1.of_AppendWhere("a.cd_filial = " + String(lvl_Filial))
	lvds_2.of_AppendWhere("nf.cd_filial = " + String(lvl_Filial))
	
	This.ivs_Filtro_Relatorio[UpperBound(This.ivs_Filtro_Relatorio)+1] = 'Filial: ' + dw_1.Object.De_Filial[1] + " (" + String(lvl_Filial) + ")"
End If

This.ivs_Filtro_Relatorio[UpperBound(This.ivs_Filtro_Relatorio)+1] = 'Per$$HEX1$$ed00$$ENDHEX$$odo: '+String(dw_1.Object.Dt_Inicio[1],'DD/MM/YYYY')+' $$HEX1$$e000$$ENDHEX$$ '+String(dw_1.Object.Dt_Termino[1],'DD/MM/YYYY')

//vendas
lvds_1.Retrieve(lvdt_Inicio, lvdt_Termino)
//devolucao
lvds_2.Retrieve(lvdt_Inicio, lvdt_Termino)

For lvl_Contador = 1 To lvds_2.RowCount()
	If ls_Tipo <> "F" Then
		lvdt_Data	 = Date(lvds_2.Object.Dh_Movimentacao_Caixa[lvl_Contador])
	End If
	
	If ls_Tipo <> "D" Then
		lvl_Filial = lvds_2.Object.Cd_Filial[lvl_Contador]
	End If
	
	lvs_Tipo_Venda = lvds_2.Object.Id_Tipo_Venda[lvl_Contador]
	
	Choose Case ls_Tipo			
		Case "A"		
			lvl_Find = lvds_1.Find("cd_filial = " + String(lvl_Filial) + " and string(dh_movimentacao_caixa,'dd/mm/yyyy') = '" + String(lvdt_Data,'dd/mm/yyyy') + &
								"' and id_tipo_venda= '" + lvs_Tipo_Venda + "'", 1, lvds_1.RowCount())
		Case "D"
			lvl_Find = lvds_1.Find("string(dh_movimentacao_caixa,'dd/mm/yyyy') = '" + String(lvdt_Data,'dd/mm/yyyy') +	"' and id_tipo_venda= '" + lvs_Tipo_Venda + "'", 1, lvds_1.RowCount())
								
		Case "F"
			lvl_Find = lvds_1.Find("cd_filial = " + String(lvl_Filial) +	" and id_tipo_venda= '" + lvs_Tipo_Venda + "'", 1, lvds_1.RowCount())
	End Choose
	
	If Not(lvl_Find > 0) Then
		lvl_Find = lvds_1.InsertRow(0)
		
		If ls_Tipo <> "F" Then
			lvds_1.Object.Dh_Movimentacao_Caixa[lvl_Find] = lvdt_Data
		End If
		
		lvds_1.Object.Id_Tipo_Venda 				[lvl_Find] = lvs_Tipo_Venda
		lvds_1.Object.Vl_Total_Venda				[lvl_Find] = 0.00
		lvds_1.Object.Qt_Clientes					[lvl_Find] = 0.00
	End If
	
	lvdc_Total_Venda	= lvds_1.Object.Vl_Total_Venda	[lvl_Find]
	lvl_Clientes			= lvds_1.Object.Qt_Clientes			[lvl_Find]
	
	lvds_1.Object.Vl_Total_Venda	[lvl_Find] = lvdc_Total_Venda	- lvds_2.Object.Vl_Total_Devolucao	[lvl_Contador]
	lvds_1.Object.Qt_Clientes		[lvl_Find] = lvl_Clientes			- lvds_2.Object.Qt_Clientes				[lvl_Contador]
Next

lvl_Max = lvds_1.RowCount()

If (lvl_Max >0) Then
	
	Open(w_Aguarde)
	w_Aguarde.Title = "Verificando Vendas do Per$$HEX1$$ed00$$ENDHEX$$odo..."

	w_Aguarde.uo_Progress.of_SetMax(lvl_Max)
	
	For lvl_Contador = 1 To lvl_Max
		If ls_Tipo <> "D" Then
			lvl_Filial 				= lvds_1.Object.Cd_Filial			[lvl_Contador]
			lvs_Nome_Fantasia= lvds_1.Object.Nm_Fantasia	[lvl_Contador]
		End If		
		
		If ls_Tipo <> "F" Then
			lvdt_Data = Date(lvds_1.Object.Dh_Movimentacao_Caixa[lvl_Contador])
		End If		
		
		lvs_Tipo_Venda	= lvds_1.Object.Id_Tipo_Venda 					[lvl_Contador]
		lvdc_Total_Venda	= lvds_1.Object.Vl_Total_Venda					[lvl_Contador]
		lvl_Clientes			= lvds_1.Object.Qt_Clientes							[lvl_Contador]
		
		If (lvdt_Data <> lvdt_Data_Anterior) Or (lvl_Filial <> lvl_Filial_Ant) Then
			
			lvl_Linha = This.InsertRow(0)	
			
			If ls_Tipo <> "D" Then
				This.Object.Cd_Filial		[lvl_Linha] = lvl_Filial
				This.Object.Nm_Fantasia[lvl_Linha] = lvs_Nome_Fantasia
			End If
			
			If ls_Tipo <> "F" Then
				This.Object.Dt_Venda[lvl_Linha] = lvdt_Data
			End If			
			
			This.Object.Vl_Venda_AV	[lvl_Linha] = 0.00
			This.Object.Vl_Venda_CV	[lvl_Linha] = 0.00
			This.Object.Vl_Venda_CR	[lvl_Linha] = 0.00
			This.Object.Vl_Venda_CC	[lvl_Linha] = 0.00
			This.Object.Qt_Clientes		[lvl_Linha] = 0.00
			
			lvl_Filial_Ant	 		= lvl_Filial
			lvdt_Data_Anterior	= lvdt_Data
		End If
		
		Choose Case lvs_Tipo_Venda
			Case "AV" 
				This.Object.Vl_Venda_AV  	[lvl_Linha] = lvdc_Total_Venda
				This.Object.Qt_Cliente_AV	[lvl_Linha] = lvl_Clientes				
			Case "CV" 
				This.Object.Vl_Venda_CV  	[lvl_Linha] = lvdc_Total_Venda
				This.Object.Qt_Cliente_CV	[lvl_Linha] = lvl_Clientes
			Case "CR"
				This.Object.Vl_Venda_CR  	[lvl_Linha] = lvdc_Total_Venda
				This.Object.Qt_Cliente_CR	[lvl_Linha] = lvl_Clientes
			Case "CC" 
				This.Object.Vl_Venda_CC  	[lvl_Linha] = lvdc_Total_Venda
				This.Object.Qt_Cliente_CC	[lvl_Linha] = lvl_Clientes
		End Choose
		
		This.Object.Qt_Clientes[lvl_Linha] = This.Object.Qt_Clientes[lvl_Linha] + lvl_Clientes
		
		This.GroupCalc()
		
		w_Aguarde.uo_Progress.of_SetProgress(lvl_Contador)
		
	Next
	
	//Estas linhas foram inseridas para for$$HEX1$$e700$$ENDHEX$$ar a atualiza$$HEX2$$e700e300$$ENDHEX$$o da dw_3 de relat$$HEX1$$f300$$ENDHEX$$rio,
	//visto que a mesma n$$HEX1$$e300$$ENDHEX$$o estava com os totais finais atualizados.
	lvl_Linha = This.InsertRow(0)	
	This.DeleteRow(lvl_Linha)
	/////////////////////////
	
	Close(w_Aguarde)

	Parent.ivm_Menu.mf_Imprimir(True)
	
	This.SetRedraw(True)
	This.SetFocus()
	
Else
	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum pedido localizado neste per$$HEX1$$ed00$$ENDHEX$$odo.", Information!)
	Parent.ivm_Menu.mf_Imprimir(False)
	dw_1.SetFocus()
	
End If

Destroy(lvds_2)
Destroy(lvds_1)

Return 1
end event

event dw_2::constructor;call super::constructor;This.ivb_Ordena_Colunas = True
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge146_rel_venda_diaria_disque
integer x = 3049
integer y = 40
integer width = 370
integer height = 148
integer taborder = 50
string dataobject = "dw_ge146_relatorio"
end type

event dw_3::ue_preprint;call super::ue_preprint;Date lvdt_Inicio, &
     lvdt_Termino

String lvs_de_filial, &
		 lvs_cd_filial
		 
lvdt_Inicio   		= dw_1.Object.Dt_Inicio		[1]
lvdt_Termino	= dw_1.Object.Dt_Termino	[1]
lvs_de_filial		= dw_1.Object.De_Filial		[1]
lvs_cd_filial		= String(dw_1.Object.Cd_Filial[1])

This.Object.t_Periodo.Text = String(lvdt_Inicio,  "dd/mm/yyyy") + " $$HEX1$$e000$$ENDHEX$$ " + &
                             String(lvdt_Termino, "dd/mm/yyyy")
									  
This.Object.t_Filial.Text  = lvs_de_filial + " (" + Trim(lvs_cd_filial) + ")"

This.GroupCalc()

Return AncestorReturnValue
end event

event dw_3::ue_saveas;//override
This.Event ue_PrePrint()

SUPER::EVENT ue_SaveAs()
end event

type cb_1 from commandbutton within w_ge146_rel_venda_diaria_disque
integer x = 2482
integer y = 164
integer width = 439
integer height = 104
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Gerar Planilha"
end type

event clicked;dw_2.Event ue_SaveAs()
end event

