HA$PBExportHeader$w_ge133_consulta_preco.srw
forward
global type w_ge133_consulta_preco from dc_w_selecao_lista_relatorio
end type
type cb_excel from commandbutton within w_ge133_consulta_preco
end type
end forward

global type w_ge133_consulta_preco from dc_w_selecao_lista_relatorio
string tag = "w_ge133_consulta_preco"
string accessiblename = "Consulta Pre$$HEX1$$e700$$ENDHEX$$o por Filial (GE133)"
integer width = 3173
integer height = 1480
string title = "GE133 - Consulta de Pre$$HEX1$$e700$$ENDHEX$$os"
long backcolor = 80269524
cb_excel cb_excel
end type
global w_ge133_consulta_preco w_ge133_consulta_preco

type variables
uo_filial ivo_filial

uo_produto ivo_produto
end variables

forward prototypes
public function decimal wf_promocao_sos_farm_popular (long al_filial, date adh_parametro, ref string as_mensagem)
end prototypes

public function decimal wf_promocao_sos_farm_popular (long al_filial, date adh_parametro, ref string as_mensagem);Decimal lvdc_Desconto, 	lvdc_Nulo

Long lvl_Promocao_SOS

Date ldh_Inicio, ldh_Termino, ldh_Parametro

String lvs_Parametro

SetNull(lvdc_Nulo)

lvdc_Desconto = lvdc_Nulo

as_mensagem = ""

Select vl_parametro
Into :lvs_Parametro
From parametro_loja
Where cd_filial = :al_filial
	and cd_parametro = 'CD_PROMOCAO_SOS_FARMACIA_POPULAR'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
				
		If IsNumber(lvs_Parametro) Then
			
			lvl_Promocao_SOS = Long(lvs_Parametro)
			
			Select p.pc_desconto, s.dh_inicio, s.dh_termino
			Into :lvdc_Desconto, :ldh_Inicio, :ldh_Termino
			From promocao_sos_produto p
			inner join promocao_sos s
				on s.cd_promocao_sos 		= p.cd_promocao_sos
			Where s.cd_promocao_sos		= :lvl_Promocao_SOS
			  and p.cd_produto				= :ivo_Produto.cd_produto
			  
			Using SqlCa;
			
			Choose Case SqlCa.SqlCode
				Case 0
					If IsNull(lvdc_Desconto) or lvdc_Desconto <= 0 Then
						lvdc_Desconto = 0.00
					End If					
					
					If ldh_inicio > adh_parametro or ldh_termino < adh_parametro Then
						as_mensagem = 'Promo$$HEX2$$e700e300$$ENDHEX$$o: ' + lvs_Parametro + ' - N$$HEX1$$c300$$ENDHEX$$O VIGENTE'
					End If
					
				Case 100
					lvdc_Desconto = 0.00
				Case -1
					SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do desconto da promo$$HEX2$$e700e300$$ENDHEX$$o sos '" + String(lvl_Promocao_SOS) + "'")
			End Choose
			
		End If
		
	Case 100
	Case -1
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e300$$ENDHEX$$metro loja 'CD_PROMOCAO_SOS_FARMACIA_POPULAR'")
End Choose

Return lvdc_Desconto
end function

on w_ge133_consulta_preco.create
int iCurrent
call super::create
this.cb_excel=create cb_excel
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_excel
end on

on w_ge133_consulta_preco.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_excel)
end on

event ue_postopen;// OverRide

ivo_dbError = Create dc_uo_dbError

ivo_Filial 	= Create uo_Filial
ivo_Produto = Create uo_Produto

dw_2.ivo_Controle_Menu.of_Incluir(True)
dw_2.ivo_Controle_Menu.of_Excluir(True)

dw_2.ivo_Controle_Menu.of_SalvarComo(True)

dw_1.InsertRow(1)
dw_1.SetFocus()



end event

event close;call super::close;Destroy(ivo_Filial)
Destroy(ivo_Produto)
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge133_consulta_preco
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge133_consulta_preco
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge133_consulta_preco
integer x = 23
integer y = 212
integer width = 3077
integer height = 1048
integer weight = 700
string text = "Produtos"
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge133_consulta_preco
integer x = 23
integer y = 12
integer width = 1774
integer height = 184
integer weight = 700
string text = "Par$$HEX1$$e200$$ENDHEX$$metro"
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge133_consulta_preco
integer x = 46
integer y = 76
integer width = 1733
integer height = 96
string dataobject = "dw_ge133_selecao"
end type

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	If This.GetColumnName() = "nm_filial" Then
		ivo_Filial.of_Localiza_Filial(This.GetText())
		
		If ivo_Filial.Localizada Then
			This.Object.cd_filial[1]  = ivo_Filial.cd_filial
			This.Object.nm_filial[1]  = ivo_Filial.nm_fantasia
		End If
	End If
End If
	
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Filial) Then
	This.Object.Cd_Filial[1] = ivo_Filial.cd_filial
	This.Object.Nm_Filial[1] = ivo_Filial.nm_fantasia
End If
end event

event dw_1::itemchanged;call super::itemchanged;If dwo.Name = "nm_filial" Then
	If Not IsNull(Data) and Trim(Data) <> "" Then
		If Data <> ivo_Filial.nm_fantasia Then
			Return 1
		End If
	Else
		ivo_Filial.of_Inicializa()
		
		This.Object.cd_Filial[1] = ivo_Filial.cd_filial
		This.Object.nm_Filial[1] = ivo_Filial.nm_fantasia
	End If
End If
end event

event dw_1::ue_addrow;// OverRide

dw_2.Event ue_AddRow()


Return 1

end event

event dw_1::editchanged;call super::editchanged;dw_2.Object.st_nome_pmc_farm_popular.Visible 			= False
dw_2.Object.st_nome_preco_final_farm_popular.Visible = False
dw_2.Object.bmp_vidalink2.Visible 							= False
dw_2.Object.st_gratis_farm_popular.Visible					= False
dw_2.Object.st_msg.Visible										= False
dw_2.Object.st_preco_final_farm_popular.Visible	 		= False
dw_2.Object.st_pmc_farm_popular.Visible					= False
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge133_consulta_preco
integer x = 59
integer y = 264
integer width = 3017
integer height = 972
string dataobject = "dw_ge133_lista"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_key;call super::ue_key;Long lvl_Filial,&
	 lvl_Linha,&
	 lvl_Find,&
	 lvl_Nulo

Decimal{2} lvdc_Preco_Padrao,&
		   lvdc_Preco_Filial,&
		   lvdc_Desconto_SOS,&
		   lvdc_Desconto_Clube
			
String ls_msg_promocao

Date ldh_parametro

SetNull(lvl_Nulo)

dw_1.AcceptText()

lvl_Filial = dw_1.Object.cd_filial[1]

If Key = KeyEnter! Then
	If Not IsNull(lvl_Filial) Then
		If This.GetColumnName() = "nm_produto" Then
			ivo_Produto.of_Localiza_Produto(This.GetText())
			
			If ivo_Produto.Localizado Then
				
				lvl_Find = This.Find("cd_produto = " + String(ivo_Produto.cd_produto), 1, This.RowCount())
				
				If lvl_Find = -1 Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o produto da DW")
					Return -1
				ElseIf lvl_Find > 0 Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produto j$$HEX1$$e100$$ENDHEX$$ foi informado.")
					Return -1
				End If
				
				ldh_parametro	= Date( gf_GetServerDate() )
				
				lvl_Linha = This.GetRow()
						
				This.Object.cd_produto								[lvl_Linha] = ivo_Produto.cd_produto
				This.Object.nm_produto								[lvl_Linha] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
				This.Object.vl_preco_unitario						[lvl_Linha] = ivo_Produto.of_Preco_Venda_Filial_Matriz( lvl_Filial )
				This.Object.pc_desconto								[lvl_Linha] = ivo_Produto.Of_Desconto_Filial( lvl_Filial )
				This.Object.Id_Vidalink								[lvl_Linha] = ivo_Produto.Id_Farmacia_Popular
				This.Object.id_gratis_farm_popular				[lvl_Linha] = ivo_Produto.id_gratis_farm_popular
//				This.Object.Pc_Desconto_SOS_Farm_Popular	[lvl_Linha] = wf_Promocao_SOS_Farm_Popular( lvl_Filial, ldh_parametro, Ref ls_msg_promocao )
				This.Object.de_msg_promocao						[lvl_Linha] = ls_msg_promocao
				This.Object.Vl_Preco_Pago_FPB					[lvl_Linha] = ivo_Produto.vl_reembolso_fpb
																
				lvdc_Desconto_Clube = ivo_Produto.of_Desconto_Clube_Filial(lvl_Filial)
				
				If lvdc_Desconto_Clube = 0 Then lvdc_Desconto_Clube = lvl_Nulo 
				
				This.Object.pc_desconto_clube[lvl_Linha] = lvdc_Desconto_Clube
													
				dw_2.Event ue_AddRow()
			End If
		End If
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Informe a filial.", Exclamation!)
		This.DeleteRow(This.GetRow())
		dw_1.Event ue_Pos(1, "nm_filial")
		dw_1.SetFocus()
		Return -1
	End If
End If

//This.of_SetRowSelection()
end event

event dw_2::ue_deleterow;//OverRide

Boolean lvb_Retorno = False

SetPointer(HourGlass!)

If This.Event ue_PreDeleteRow() Then
	If This.DeleteRow(0) = 1 Then
		If Not IsNull(ivm_Menu) Then			
			//ivm_Menu.mf_Confirmar(True)
			//ivm_Menu.mf_Cancelar(True)
			
			If This.RowCount() = 0 Then	
				ivm_Menu.mf_Imprimir(False)
				ivm_Menu.mf_Excluir(False)
			ElseIf This.RowCount() = 1 Then
				ivm_Menu.mf_Classificar(False)
				ivm_Menu.mf_Filtrar(False)
				ivm_Menu.mf_Localizar(False)
			End If	
		End If
		
		lvb_Retorno = True
	End If
End If

SetPointer(Arrow!)
Return lvb_Retorno
end event

event dw_2::ue_preinsertrow;call super::ue_preinsertrow;If This.RowCount() > 0 Then
	If IsNull(This.Object.cd_produto[This.RowCount()]) Then
		Return -1
	End If
End If

Return 1

end event

event dw_2::rowfocuschanged;call super::rowfocuschanged;Boolean lvb_Visible, lvb_Visible_Gratis

Decimal 	lvdc_Nulo, &
			lvdc_Preco_Final,	&
			lvdc_Desconto_Farm_Pop, &
			ldc_valor_fpb
		
String lvs_Nulo		
		
SetNull(lvdc_Nulo)
SetNull(lvs_Nulo)

// Tratamento Farm$$HEX1$$e100$$ENDHEX$$cia Popular do Brasil
lvb_Visible 			= False
lvb_Visible_Gratis 	= False

If currentRow > 0 Then

	This.Object.st_pmc_farm_popular.text 			= lvs_Nulo
	This.Object.st_preco_final_farm_popular.text 	= lvs_Nulo
	
	If Not IsNull(This.Object.id_vidalink[CurrentRow]) and This.Object.id_vidalink[CurrentRow] = 'S' Then
		
		lvb_Visible = True
			
		// Altera$$HEX2$$e700e300$$ENDHEX$$o realizada
		ldc_valor_fpb = dw_2.Object.Vl_Preco_Pago_FPB[CurrentRow]

		If ldc_valor_fpb > 0 Then
			If (dw_2.Object.vl_preco_final[CurrentRow] * 0.9) >= ldc_valor_fpb Then
				ldc_valor_fpb =  Round( dw_2.Object.vl_preco_final[CurrentRow] - ldc_valor_fpb, 2 )
			Else
				ldc_valor_fpb = Round( dw_2.Object.vl_preco_final[CurrentRow] * 0.1, 2 )
			End If
		Else
			dw_2.Object.Vl_Preco_Pago_FPB[CurrentRow] = 0.00
		End If

		If ldc_valor_fpb >= 0 Then
			This.Object.st_preco_final_farm_popular.text = String(ldc_valor_fpb, "#,##0.00")
		End If		
		// fim altera$$HEX2$$e700e300$$ENDHEX$$o
		
		This.Object.st_pmc_farm_popular.text = String(This.Object.vl_preco_unitario[CurrentRow], "#,##0.00")
		
		If Not IsNull(This.Object.id_gratis_farm_popular[CurrentRow]) and This.Object.id_gratis_farm_popular[CurrentRow] = 'S' Then
			lvb_Visible_Gratis 	= True
		End If						
		
	End If
		
	This.Object.st_nome_pmc_farm_popular.Visible 			= lvb_Visible
	This.Object.st_nome_preco_final_farm_popular.Visible 	= lvb_Visible
	This.Object.bmp_vidalink2.Visible 								= lvb_Visible
	This.Object.st_gratis_farm_popular.Visible					= lvb_Visible_Gratis
	This.Object.st_msg.Visible										= lvb_Visible
	This.Object.st_preco_final_farm_popular.Visible 			= lvb_Visible
	This.Object.st_pmc_farm_popular.Visible 					= lvb_Visible
	
End if
end event

event dw_2::getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge133_consulta_preco
integer x = 1893
integer y = 44
integer width = 233
integer height = 120
end type

type cb_excel from commandbutton within w_ge133_consulta_preco
integer x = 2318
integer y = 68
integer width = 791
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Importar Produtos via Excel"
end type

event clicked;Any lva_Produto

String lvs_Arquivo,	 lvs_Nome, ls_Msg_Promocao
		
Decimal 	lvdc_Desconto_Clube, &
			lvdc_Vl_Reembolso

Long lvl_Linhas,&
	 lvl_Linha,&
	 lvl_Filial,&
	 lvl_Nulo
	 
Integer lvi_Retorno

Date ldh_Parametro

dw_2.Reset()

SetNull(lvl_Nulo)

dw_1.acceptText()

lvl_Filial = dw_1.Object.cd_Filial [1]

If IsNUll(lvl_Filial) Then 
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Selecione uma filial.")
	dw_1.Event ue_Pos(1,"cd_filial")
	Return -1
End If

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Os dados devem estar da seguinte forma:~r~r" + &
                     	 "Coluna A = C$$HEX1$$f300$$ENDHEX$$digo do Produto")

lvi_Retorno = GetFileOpenName("Seleciona o arquivo", + lvs_Arquivo, lvs_Nome, "XLS", "Excel (*.XLS;*.XLSX),*.XLS;*.XLSX")

If lvi_Retorno <> 1 Then 
	Return -1
End If

dc_uo_excel lvo_Excel
lvo_Excel = Create dc_uo_excel

dw_2.SetRedRaw(False)

Open(w_Aguarde)
w_Aguarde.Title = "Importando produtos..."

If ( lvo_Excel.uo_Referencia_Objeto_Excel(lvs_Arquivo) ) Then

	lvl_Linhas = lvo_Excel.uo_Verifica_Tamanho_Arquivo("A")
	
	If lvl_Linhas > 0 Then
		w_Aguarde.uo_Progress.of_SetMax(lvl_Linhas)
		
		ldh_Parametro = Date( gf_GetServerDate() )

		For lvl_Linha = 1 To lvl_Linhas
			
			SetPointer (HourGlass!)
			
			w_Aguarde.uo_Progress.of_SetProgress(lvl_Linha)
			
			lva_Produto = lvo_Excel.uo_Lendo_Dados(lvl_Linha, "A")
			
			//Localiza_Produto
			ivo_Produto.of_Localiza_codigo_interno(Long(lva_Produto))
			
			If ivo_Produto.Localizado Then
							
				dw_2.Object.cd_produto								[lvl_Linha] = ivo_Produto.cd_produto
				dw_2.Object.nm_produto							[lvl_Linha] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
				dw_2.Object.vl_preco_unitario						[lvl_Linha] = ivo_Produto.of_Preco_Venda_Filial_Matriz(lvl_Filial)
				dw_2.Object.pc_desconto							[lvl_Linha] = ivo_Produto.Of_Desconto_Filial(lvl_Filial)
				dw_2.Object.Id_Vidalink								[lvl_Linha] = ivo_Produto.Id_Farmacia_Popular
				dw_2.Object.id_gratis_farm_popular				[lvl_Linha] = ivo_Produto.id_gratis_farm_popular
//				dw_2.Object.Pc_Desconto_SOS_Farm_Popular	[lvl_Linha] = wf_Promocao_SOS_Farm_Popular( lvl_Filial, ldh_Parametro, Ref ls_Msg_Promocao )
				dw_2.Object.de_msg_promocao					[lvl_Linha] = ls_Msg_Promocao
				
				lvdc_Vl_Reembolso = ivo_Produto.vl_reembolso_fpb
				If IsNull(lvdc_Vl_Reembolso) Then lvdc_Vl_Reembolso = 0.00
				
				dw_2.Object.Vl_Preco_Pago_FPB [lvl_Linha] = lvdc_Vl_Reembolso
			
				lvdc_Desconto_Clube = ivo_Produto.of_Desconto_Clube_Filial(lvl_Filial)
				
				If lvdc_Desconto_Clube = 0 Then lvdc_Desconto_Clube = lvl_Nulo 
				
				dw_2.Object.pc_desconto_clube[lvl_Linha] = lvdc_Desconto_Clube
				
				dw_2.Event ue_AddRow()
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Produto '" + String(lva_Produto) +  "' n$$HEX1$$e300$$ENDHEX$$o localizado.")
			End If
											
		Next
		 
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "A planilha n$$HEX1$$e300$$ENDHEX$$o possui nenhuma linha.", Exclamation!)
		Close(w_Aguarde)
		Destroy(lvo_Excel)
		Return -1
	End If
End If

SetPointer (Arrow!)

dw_2.SetRedRaw(True) 

Close(w_Aguarde)

Return
end event

