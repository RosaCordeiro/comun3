HA$PBExportHeader$w_ge416_compras_distribuidoras_detalhes.srw
forward
global type w_ge416_compras_distribuidoras_detalhes from dc_w_response_ok_cancela
end type
type cb_salvar from commandbutton within w_ge416_compras_distribuidoras_detalhes
end type
type cb_imprimir from commandbutton within w_ge416_compras_distribuidoras_detalhes
end type
type dw_2 from dc_uo_dw_base within w_ge416_compras_distribuidoras_detalhes
end type
end forward

global type w_ge416_compras_distribuidoras_detalhes from dc_w_response_ok_cancela
integer width = 3291
integer height = 1372
string title = "GE416 - Detalhes Fornecedor"
long backcolor = 80269524
cb_salvar cb_salvar
cb_imprimir cb_imprimir
dw_2 dw_2
end type
global w_ge416_compras_distribuidoras_detalhes w_ge416_compras_distribuidoras_detalhes

type variables
string ivs_parametro
end variables

on w_ge416_compras_distribuidoras_detalhes.create
int iCurrent
call super::create
this.cb_salvar=create cb_salvar
this.cb_imprimir=create cb_imprimir
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_salvar
this.Control[iCurrent+2]=this.cb_imprimir
this.Control[iCurrent+3]=this.dw_2
end on

on w_ge416_compras_distribuidoras_detalhes.destroy
call super::destroy
destroy(this.cb_salvar)
destroy(this.cb_imprimir)
destroy(this.dw_2)
end on

event ue_postopen;call super::ue_postopen;String lvs_Retorno

ivs_Parametro = Message.StringParm	

If LenA(ivs_Parametro) <> 33 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tamanho do par$$HEX1$$e200$$ENDHEX$$metro inv$$HEX1$$e100$$ENDHEX$$lido.")
	SetNull(lvs_Retorno)
	CloseWithReturn(This, lvs_Retorno)
Else
	dw_1.Event ue_Retrieve()
End If

end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge416_compras_distribuidoras_detalhes
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge416_compras_distribuidoras_detalhes
integer width = 3214
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge416_compras_distribuidoras_detalhes
integer width = 3159
integer height = 1036
integer taborder = 60
string dataobject = "dw_ge416_detalhe"
boolean vscrollbar = true
end type

event dw_1::ue_recuperar;// OverRide

Date lvdt_Inicio,&
	 lvdt_Termino
	 
Long lvl_Filial

String lvs_Fornecedor

lvdt_Inicio    = Date(MidA(ivs_Parametro, 1, 10))
lvdt_Termino   = Date(MidA(ivs_Parametro, 11, 10))
lvl_Filial     = Long(MidA(ivs_Parametro, 21, 4))
lvs_Fornecedor = MidA(ivs_Parametro, 25, 9)

If lvl_Filial > 0 Then
	dw_1.of_AppendWhere("n.cd_filial = " + String(lvl_Filial))
End If

Return dw_1.Retrieve(lvdt_Inicio, lvdt_Termino, lvs_Fornecedor)
end event

event dw_1::ue_postretrieve;call super::ue_postretrieve;Decimal{2} lvdc_Liquido,&
		   lvdc_Bruto,&
		   lvdc_Vl_Desconto
		   
Long lvl_Linha	

cb_salvar.Enabled   = False
cb_imprimir.Enabled = False

If pl_Linhas > 0 Then
	
	cb_salvar.Enabled   = True
	cb_imprimir.Enabled = True

	Open(w_Aguarde)

	w_Aguarde.Title = "Atualizando os Descontos..."

	w_Aguarde.uo_Progress.of_SetMax(pl_Linhas)
	
	For lvl_Linha = 1 To pl_Linhas
					
		lvdc_Liquido = dw_1.Object.vl_liquido[lvl_Linha] 
		lvdc_Bruto   = dw_1.Object.vl_bruto  [lvl_Linha]
	
		lvdc_Vl_Desconto = lvdc_Bruto - lvdc_Liquido
		
		If lvdc_Vl_Desconto < 0 Then lvdc_Vl_Desconto = 0.00
		
		dw_1.Object.pc_desconto[lvl_Linha] = Round(lvdc_Vl_Desconto / lvdc_Bruto * 100, 2)
		dw_1.Object.vl_desconto[lvl_Linha] = lvdc_Vl_Desconto
		
		w_Aguarde.uo_Progress.of_SetProgress(lvl_Linha)
	Next
	
	Close(w_Aguarde)
Else
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.")
End If

Return pl_Linhas

end event

event dw_1::constructor;call super::constructor;This.of_SetRowSelection()

This.ShareData(dw_2)
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge416_compras_distribuidoras_detalhes
integer x = 2912
integer y = 1160
integer width = 325
string text = "&Fechar"
end type

event cb_ok::clicked;call super::clicked;String lvs_Retorno

SetNull(lvs_Retorno)
CloseWithReturn(Parent, lvs_Retorno)
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge416_compras_distribuidoras_detalhes
boolean visible = false
integer x = 2912
integer y = 1160
end type

type cb_salvar from commandbutton within w_ge416_compras_distribuidoras_detalhes
integer x = 23
integer y = 1160
integer width = 553
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Salvar em &Excel"
end type

event clicked;//String lvs_Arquivo, &
//       lvs_Diretorio
//
//Integer lvi_Retorno
//
//
//lvi_Retorno = GetFileSaveName("Selecione o caminho do arquivo", &
//							   lvs_Diretorio, &
//							   lvs_Arquivo, &
//							   "XLS", "Arquivos do Excel (*.XLS),*.XLS,")
//
//If lvi_Retorno = -1 Then
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Ocorreu um erro durante a chamada da janela de sele$$HEX2$$e700e300$$ENDHEX$$o do arquivo.", StopSign!)
//	Return 
//Else
//	If lvi_Retorno = 0 Then Return
//End If
//
//lvs_Diretorio = Upper(lvs_Diretorio)
//
//// Verifica se j$$HEX1$$e100$$ENDHEX$$ existe o arquivo
//If FileExists(lvs_Diretorio) Then
//	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja substituir o arquivo '" + lvs_Diretorio + "' existente ?", Question!, YesNo!, 1) =  1 Then 
//		If Not FileDelete(lvs_Diretorio) Then
//			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na exclus$$HEX1$$e300$$ENDHEX$$o do arquivo '" + lvs_Diretorio + "'.", StopSign!)
//			Return
//		End If
//	Else
//		Return 
//   End If   
//End If
//
//// Salva o arquivo
////lvi_Retorno = This.SaveAs(lvs_Diretorio, Excel!, True)
//
//If lvi_Retorno <> 1 Then
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao salvar o arquivo '" + lvs_Diretorio + "'.", StopSign!)	
//	Return 
//Else
//	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Arquivo '" + lvs_Diretorio + "' salvo com sucesso.", Information!)
//End If



dw_1.Event ue_SaveAs()
end event

type cb_imprimir from commandbutton within w_ge416_compras_distribuidoras_detalhes
integer x = 603
integer y = 1160
integer width = 553
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "&Imprimir Consulta"
end type

event clicked;dw_2.Event ue_Print()
end event

type dw_2 from dc_uo_dw_base within w_ge416_compras_distribuidoras_detalhes
boolean visible = false
integer x = 2149
integer y = 356
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge416_relatorio_detalhe"
end type

event ue_preprint;call super::ue_preprint;
dw_2.Object.Cabecalho_Periodo.text = MidA(ivs_Parametro, 1, 10) + "  at$$HEX1$$e900$$ENDHEX$$  " + MidA(ivs_Parametro, 11, 10)

//dw_3.Object.Vl_Total_Bruto.Text    = String(dw_2.Object.Vl_Total_Bruto   [1], "0,000.00")
//dw_3.Object.Vl_Total_Desconto.Text = String(dw_2.Object.Vl_Total_Desconto[1], "0,000.00")
//dw_3.Object.Pc_Total_Desconto.Text = String(dw_2.Object.Pc_Total_Desconto[1], "0.00")

Return AncestorReturnValue
end event

