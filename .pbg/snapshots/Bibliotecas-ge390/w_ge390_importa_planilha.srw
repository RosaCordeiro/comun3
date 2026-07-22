HA$PBExportHeader$w_ge390_importa_planilha.srw
forward
global type w_ge390_importa_planilha from dc_w_response_ok_cancela
end type
type dw_2 from dc_uo_dw_base within w_ge390_importa_planilha
end type
type cb_planilha from commandbutton within w_ge390_importa_planilha
end type
type dw_3 from dc_uo_dw_base within w_ge390_importa_planilha
end type
type gb_2 from groupbox within w_ge390_importa_planilha
end type
type gb_3 from groupbox within w_ge390_importa_planilha
end type
end forward

global type w_ge390_importa_planilha from dc_w_response_ok_cancela
integer width = 3483
integer height = 2136
string title = "GE390 - Produto Exclusivo para Bahia via Planilha"
dw_2 dw_2
cb_planilha cb_planilha
dw_3 dw_3
gb_2 gb_2
gb_3 gb_3
end type
global w_ge390_importa_planilha w_ge390_importa_planilha

type variables
Long il_count_produto_retirado
end variables

forward prototypes
public function long wf_le_dados_planilha (string as_arquivo)
public subroutine wf_set_somente_consulta ()
public subroutine wf_grava_produto ()
end prototypes

public function long wf_le_dados_planilha (string as_arquivo);Any la_Dado_coluna_A,la_Dado_coluna_B

Integer li_Index

Long ll_Linha
Long ll_Linhas
Long ll_Sucesso = 1
Long ll_Produto
Long ll_Array
Long i
Long ll_Find

String ls_Divergencia
String ls_Permite
String ls_id_pedido_exclusivo_falta
String ls_Erro
String ls_UF
dw_2.AcceptText()

Try
	
	il_count_produto_retirado = 0
	
	SetRedraw(False)

	dc_uo_excel lo_Excel
	lo_Excel = Create dc_uo_excel
	
	uo_ge390_regras_inclusao lo_Regras
	lo_Regras = Create uo_ge390_regras_inclusao
	
	Open(w_Aguarde)
	w_Aguarde.Title = "Atualizando dados..."
	
	// Refer$$HEX1$$ea00$$ENDHEX$$ncia o arquivo 
	If ( lo_Excel.uo_Referencia_Objeto_Excel(as_Arquivo) ) Then
		// Coluna de Refer$$HEX1$$ea00$$ENDHEX$$ncia
		ll_Linhas = lo_Excel.uo_Verifica_Tamanho_Arquivo("A") 
		
		If ll_Linhas > 0 Then 
			w_Aguarde.uo_Progress.of_SetMax(ll_Linhas)
			
			For ll_Linha = 1 To ll_Linhas
				
				i = 0
				ls_Divergencia = ""
				
				//Produto
				la_Dado_coluna_A = lo_Excel.uo_Lendo_Dados(ll_Linha, "A")
				la_Dado_coluna_B = lo_Excel.uo_Lendo_Dados(ll_Linha, "B")
				
			 	//validar produto e UF
				If Not lo_Regras.of_Valida_Produto(Long(la_Dado_coluna_A)) Then
					
					//Se for nulo atribui branco para mostrar a mensagem
					If IsNull(la_Dado_coluna_A) Then
						la_Dado_coluna_A = ""
					End If
					
					li_Index += 1
					gvs_Log[li_Index] = "Produto '" + String(la_Dado_coluna_A) + "' n$$HEX1$$e300$$ENDHEX$$o localizado ou n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ ativo. Linha '" + String(ll_Linha) + "'.~r~n"
					ll_Sucesso = 0
					Continue
				End If
				
				If Not lo_Regras.of_verifica_uf_habilitada(String(la_Dado_coluna_B),ls_id_pedido_exclusivo_falta,ls_Erro) Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao consultar a UF valida na tabela unidade_federacao:  " + ls_Erro, StopSign!)
					Return 0
				End if
				
				If ls_id_pedido_exclusivo_falta <> 'S' Then
				//	Colocar algum marcardor geral aqui para que no final avise os produtos que n$$HEX1$$e300$$ENDHEX$$o foram inseridos por conta da UF
					il_count_produto_retirado ++
					Continue	
				End if
				
				ll_Produto	= Long(la_Dado_coluna_A)
				ls_UF		 	= String(la_Dado_coluna_B)
				
				If Not lo_Regras.of_Valida_Inclusao(ll_Produto,ls_UF, False) Then
					//Para a execu$$HEX2$$e700e300$$ENDHEX$$o
					Return -2
				End If
				
				ls_Permite = "S"
				
				ll_Array = UpperBound(lo_Regras.Id_Divergencia)
								
				If ll_Array > 0 Then
				
					For i = 1 To ll_Array
						
						//Se ls_Permite for "S" permite a marca$$HEX2$$e700e300$$ENDHEX$$o para atualiza$$HEX2$$e700e300$$ENDHEX$$o. Se ls_Permite for "N" n$$HEX1$$e300$$ENDHEX$$o permite
						
						Choose Case lo_Regras.Id_Divergencia[i]
							Case 1
								 ls_Divergencia += "Produto teve compra no Estoque Central nos $$HEX1$$fa00$$ENDHEX$$ltimos 3 meses | "
							Case 2
								ls_Divergencia += "Produto N$$HEX1$$c300$$ENDHEX$$O CONTROLADO atendido via distribuidora. N$$HEX1$$e300$$ENDHEX$$o poder$$HEX1$$e100$$ENDHEX$$ ser inclu$$HEX1$$ed00$$ENDHEX$$do | "
								ls_Permite = "N"
							Case 3
								ls_Divergencia += "Produto CONTROLADO atendido por distribuidora | "
							Case 4
								ls_Divergencia += "Produto de geladeira. N$$HEX1$$e300$$ENDHEX$$o poder$$HEX1$$e100$$ENDHEX$$ ser inclu$$HEX1$$ed00$$ENDHEX$$do | "
								ls_Permite = "N"
							Case 5
								ls_Divergencia += "Produto de categoria Fraldas. N$$HEX1$$e300$$ENDHEX$$o poder$$HEX1$$e100$$ENDHEX$$ ser inclu$$HEX1$$ed00$$ENDHEX$$do | "
								ls_Permite = "N"
							Case Else
								ls_Divergencia += ""
						End Choose
					Next
					
					//dw_2.Object.Id_Selecionado[ll_Linha] = "N"
				//Else
					//dw_2.Object.Id_Selecionado[ll_Linha] = "S"
				End If

				dw_2.Object.Id_Selecionado[ll_Linha] = "S"
				
				dw_2.Object.Cd_Produto					[ll_Linha] = ll_Produto
				dw_2.Object.De_Produto					[ll_Linha] = lo_Regras.De_Produto
				dw_2.Object.De_Grupo					[ll_Linha] = lo_Regras.De_Grupo
				dw_2.Object.Vl_Fator_Conversao		[ll_Linha] = lo_Regras.Vl_Fator_Conversao
				dw_2.Object.Id_Permite					[ll_Linha] = ls_Permite
				dw_2.Object.De_Divergencia			[ll_Linha] = ls_Divergencia
				dw_2.Object.Cd_unidade_federacao	[ll_Linha] = ls_UF 
				
				lo_Regras.of_Inicializa()
				
				w_Aguarde.uo_Progress.of_SetProgress(ll_Linha)
			Next
			
//			//Deleta as linhas que est$$HEX1$$e300$$ENDHEX$$o em branco
			ll_Find = dw_2.Find("isnull(cd_produto)", 1, dw_2.RowCount())
			
			If ll_Find < 0 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Find da dw_2.", StopSign!)
				Return 0
			End If
			
			Do While ll_Find > 0
				If dw_2.DeleteRow(ll_Find) < 0 Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao excluir a linha em branco.")
					Return 0
				End If
				
				ll_Find = dw_2.Find("isnull(cd_produto)", 1, dw_2.RowCount())
				
				If ll_Find < 0 Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Find da dw_2.", StopSign!)
					Return 0
				End If
			Loop
			
			dw_2.Sort()
			dw_2.Event RowFocusChanged(1)
			dw_2.SetFocus()
		Else
			ll_Sucesso = -1
		End If
	End If	
	
	Return ll_Sucesso
	
Finally
	SetRedraw(True)
	If IsValid(lo_Excel) Then Destroy(lo_Excel)
	If IsValid(lo_Regras) Then Destroy(lo_Regras)
	Close(w_Aguarde)
End Try
end function

public subroutine wf_set_somente_consulta ();dw_3.of_Set_Somente_Leitura(False)
end subroutine

public subroutine wf_grava_produto ();Boolean lb_Sucesso = False

Long ll_Linha
Long ll_Produto

String ls_Selecionado
String ls_UF

dw_2.AcceptText()

Try
	
	uo_ge390_regras_inclusao lo_Regras
	lo_Regras = Create uo_ge390_regras_inclusao
	
	If dw_2.RowCount() > 0 Then

		For ll_Linha = 1 To dw_2.RowCount()
			ls_Selecionado = dw_2.Object.Id_Selecionado[ll_Linha]
			
			If ls_Selecionado = "S" Then
				ll_Produto	= dw_2.Object.Cd_Produto[ll_Linha]
				ls_UF			= dw_2.Object.Cd_Unidade_Federacao[ll_Linha]
				
				//Em caso de erro o rollback() j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ na fun$$HEX2$$e700e300$$ENDHEX$$o
				If Not lo_Regras.of_Grava_Produto(ll_Produto,ls_UF, False) Then
					Return
				End If
			End If
		Next
		
		lb_Sucesso = True
	End If

Finally
	If lb_Sucesso Then
		SqlCa.of_Commit();
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produtos atualizados com sucesso.")
		
		CloseWithReturn(This, "OK")
	End If
	
	Destroy(lo_Regras)
End Try
end subroutine

on w_ge390_importa_planilha.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.cb_planilha=create cb_planilha
this.dw_3=create dw_3
this.gb_2=create gb_2
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.cb_planilha
this.Control[iCurrent+3]=this.dw_3
this.Control[iCurrent+4]=this.gb_2
this.Control[iCurrent+5]=this.gb_3
end on

on w_ge390_importa_planilha.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.cb_planilha)
destroy(this.dw_3)
destroy(this.gb_2)
destroy(this.gb_3)
end on

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge390_importa_planilha
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge390_importa_planilha
integer height = 188
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge390_importa_planilha
integer height = 96
string dataobject = "dw_ge390_selecao_planilha"
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge390_importa_planilha
integer x = 2272
integer y = 1928
integer weight = 700
end type

event cb_ok::clicked;call super::clicked;Long ll_Find

dw_2.AcceptText()

If dw_2.RowCount() = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existem dados para serem atualizados.")
	Return -1
End If

ll_Find = dw_2.Find("id_selecionado = 'S'", 1, dw_2.RowCount())

If ll_Find < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Find da dw_2.", StopSign!)
	Return -1
End If

If ll_Find = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum produto foi selecionado.", Exclamation!)
	Return -1
End If

wf_Grava_Produto()
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge390_importa_planilha
integer x = 2606
integer y = 1928
end type

type dw_2 from dc_uo_dw_base within w_ge390_importa_planilha
integer x = 55
integer y = 260
integer width = 3410
integer height = 1376
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge390_lista_planilha"
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.of_SetRowSelection()
end event

event rowfocuschanged;call super::rowfocuschanged;dw_2.AcceptText()

If CurrentRow > 0 Then		
	dw_3.Object.De_Divergencia[1] = This.Object.De_Divergencia[CurrentRow]
End If
end event

event itemchanged;call super::itemchanged;//Long ll_Produto
//
//dw_2.AcceptText()
//
//If dwo.Name = "id_selecionado" Then	
//	If Data = "S" Then
//		ll_Produto = dw_2.Object.Cd_Produto[dw_2.GetRow()]
//		
//		uo_ge390_regras_inclusao lo_Regras
//		lo_Regras = Create uo_ge390_regras_inclusao
//			
//		If Not lo_Regras.of_Valida_Produto(ll_Produto) Then
//			Destroy(lo_Regras)
//			Return 1
//		End If
//						
//		If Not lo_Regras.of_Valida_Inclusao(ll_Produto, True) Then
//			Destroy(lo_Regras)
//			Return 1
//		End If
//		
//		Destroy(lo_Regras)
//	End If
//End If
end event

type cb_planilha from commandbutton within w_ge390_importa_planilha
integer x = 27
integer y = 1928
integer width = 526
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Importar Planilha"
end type

event clicked;Integer li_Retorno 

String ls_Arquivo
String ls_Nome
String ls_Nulo

dw_1.AcceptText()

If dw_2.RowCount() > 0 Then
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A planilha j$$HEX1$$e100$$ENDHEX$$ foi importada.~rDeseja desfazer e reimport$$HEX1$$e100$$ENDHEX$$-la novamente?", Question!, YesNo!, 2) = 2 Then
		Return
	Else
		dw_1.Object.De_Arquivo[1] = ls_Nulo
		dw_2.Event ue_Reset()
	End If
End If

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Os dados devem estar da seguinte forma: " + &
							   "~r~rColuna A: C$$HEX1$$f300$$ENDHEX$$digo do produto" + &
							   "~r~rColuna B: UF do Produto(Apenas a Sigla)")
								

li_Retorno = GetFileOpenName("Seleciona o arquivo", + ls_Arquivo, ls_Nome, "XLSX", "Excel 2007 (*.XLSX),*.XLSX, Excel (*.XLS), *.XLS")

If li_Retorno = 1 Then 
	dw_1.Object.De_Arquivo[1] = Upper(ls_Arquivo)
	
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a atualiza$$HEX2$$e700e300$$ENDHEX$$o?", Question!, YesNo!, 2) = 1 Then
		Choose Case wf_Le_Dados_Planilha(ls_Arquivo)
			Case 1
				//A planilha foi importada com sucesso
			Case 0
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Alguns dados n$$HEX1$$e300$$ENDHEX$$o foram importados.")
				Open(w_ge128_log)
			Case -1
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A planilha n$$HEX1$$e300$$ENDHEX$$o possui nenhuma linha.")
		End Choose
		
		If il_count_produto_retirado > 0 Then 
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Alguns dados n$$HEX1$$e300$$ENDHEX$$o foram importados pois a UF n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ ativa para exclusividade dos produtos!!! " + &
			"~r~r Verifique os Estados habilitados no bot$$HEX1$$e300$$ENDHEX$$o 'HABILITAR/DESABILITAR UF'." )
		End if 
		
	End If
Else
	SetNull(ls_Nulo)
	dw_1.Object.De_Arquivo[1] = ls_Nulo
End If
end event

type dw_3 from dc_uo_dw_base within w_ge390_importa_planilha
integer x = 41
integer y = 1736
integer width = 2853
integer height = 148
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge390_divergencia"
end type

type gb_2 from groupbox within w_ge390_importa_planilha
integer x = 23
integer y = 196
integer width = 3429
integer height = 1472
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista"
end type

type gb_3 from groupbox within w_ge390_importa_planilha
integer x = 23
integer y = 1680
integer width = 2894
integer height = 228
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Diverg$$HEX1$$ea00$$ENDHEX$$ncia"
end type

