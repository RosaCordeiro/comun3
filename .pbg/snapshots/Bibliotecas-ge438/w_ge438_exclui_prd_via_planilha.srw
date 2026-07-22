HA$PBExportHeader$w_ge438_exclui_prd_via_planilha.srw
forward
global type w_ge438_exclui_prd_via_planilha from dc_w_response_ok_cancela
end type
type cb_importa from commandbutton within w_ge438_exclui_prd_via_planilha
end type
type gb_2 from groupbox within w_ge438_exclui_prd_via_planilha
end type
type dw_2 from dc_uo_dw_base within w_ge438_exclui_prd_via_planilha
end type
end forward

global type w_ge438_exclui_prd_via_planilha from dc_w_response_ok_cancela
integer width = 3045
integer height = 2152
string title = "GE438 - Exclui Produto via Planilha"
cb_importa cb_importa
gb_2 gb_2
dw_2 dw_2
end type
global w_ge438_exclui_prd_via_planilha w_ge438_exclui_prd_via_planilha

type variables
Boolean ivb_Check
end variables

forward prototypes
public function boolean wf_localiza_produto (long al_produto, ref string as_produto, ref boolean ab_achou)
public function long wf_le_dados_planilha ()
public function boolean wf_localiza_filial (long al_filial, ref string as_nome_fantasia, ref string as_uf, ref boolean ab_achou)
public function boolean wf_localiza_preco (long al_filial, long al_produto, string as_uf, ref decimal adc_preco_atual_uf, ref decimal adc_preco_atual_re, ref decimal adc_preco_futuro, ref boolean ab_achou)
end prototypes

public function boolean wf_localiza_produto (long al_produto, ref string as_produto, ref boolean ab_achou);Select de_produto + ' : ' + de_apresentacao_estoque
	Into: as_Produto
From produto_geral
Where cd_produto = :al_Produto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		ab_Achou = True
		
	Case 100
		ab_Achou = False
		
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao consultar o produto '" + String(al_Produto) + ".' " + SqlCa.SqlErrText, StopSign!)
		Return False
End Choose

Return True
end function

public function long wf_le_dados_planilha ();Any la_Dado

Boolean lb_Achou = False

Decimal ldc_Preco_Atual_UF
Decimal ldc_Preco_Atual_RE
Decimal ldc_Preco_Futuro

Integer li_Index

Long ll_Linha
Long ll_Linhas
Long ll_Filial
Long ll_Produto
Long ll_Sucesso = 1

String ls_Arquivo
String ls_Nome_Fantasia
String ls_Produto
String ls_Uf
String ls_Nulo[]

Try
	
	gvs_Log[] = ls_Nulo[]
	
	dw_1.AcceptText()
	dw_2.AcceptText()

	dc_uo_excel lo_Excel
	lo_Excel = Create dc_uo_excel
	
	ls_Arquivo = dw_1.Object.De_Arquivo[1]
	
	Open(w_Aguarde)
	w_Aguarde.Title = "Importando planilha..."
	
	SetRedraw(False)
	
	// Refer$$HEX1$$ea00$$ENDHEX$$ncia o arquivo 
	If ( lo_Excel.uo_Referencia_Objeto_Excel(ls_Arquivo) ) Then
		
		ll_Linhas = lo_Excel.uo_Verifica_Tamanho_Arquivo("A")
		
		If ll_Linhas > 0 Then
			w_Aguarde.uo_Progress.of_SetMax(ll_Linhas)
						
			For ll_Linha = 1 To ll_Linhas
								
				lb_Achou = False
				
				//C$$HEX1$$f300$$ENDHEX$$digo da filial
				la_Dado = lo_Excel.uo_Lendo_Dados(ll_Linha, "A")
				
				If IsNull(la_Dado) Or Not IsNumber(String(la_Dado)) Then
					//Se for nulo atribui branco para mostrar a mensagem
					If IsNull(la_Dado) Then
						la_Dado = ""
					End If
					
					li_Index += 1
					gvs_Log[li_Index] = "Dado '" + String(la_Dado) + "' inv$$HEX1$$e100$$ENDHEX$$lido. Linha '" + String(ll_Linha) + "'.~r~n"
					ll_Sucesso = 0
					Continue
				End If
				
				If Not wf_Localiza_Filial(Long(la_Dado), Ref ls_Nome_Fantasia, Ref ls_Uf, Ref lb_Achou) Then
					ll_Sucesso = 0
					Exit
				End If
				
				If Not lb_Achou Then
					li_Index += 1
					gvs_Log[li_Index] = "Filial '" + String(la_Dado) + "' n$$HEX1$$e300$$ENDHEX$$o localizada. Linha '" + String(ll_Linha) + "'.~r~n"
					ll_Sucesso = 0
					Continue
				End If
								
				ll_Filial = Long(la_Dado)
				
				lb_Achou = False
				
				//C$$HEX1$$f300$$ENDHEX$$digo do produto
				la_Dado = lo_Excel.uo_Lendo_Dados(ll_Linha, "B")
				
				If IsNull(la_Dado) Or Not IsNumber(String(la_Dado)) Then
					//Se for nulo atribui branco para mostrar a mensagem
					If IsNull(la_Dado) Then
						la_Dado = ""
					End If
					
					li_Index += 1
					gvs_Log[li_Index] = "Dado '" + String(la_Dado) + "' inv$$HEX1$$e100$$ENDHEX$$lido. Linha '" + String(ll_Linha) + "'.~r~n"
					ll_Sucesso = 0
					Continue
				End If
								
				If Not wf_Localiza_Produto(Long(la_Dado), Ref ls_Produto, Ref lb_Achou) Then
					ll_Sucesso = 0
					Exit
				End If
				
				If Not lb_Achou Then
					li_Index += 1
					gvs_Log[li_Index] = "Produto '" + String(la_Dado) + "' n$$HEX1$$e300$$ENDHEX$$o localizado. Linha '" + String(ll_Linha) + "'.~r~n"
					ll_Sucesso = 0
					Continue
				End If
								
				ll_Produto = Long(la_Dado)
				
				lb_Achou = False
				
				ldc_Preco_Atual_UF = 0.00
				ldc_Preco_Atual_RE = 0.00
				ldc_Preco_Futuro = 0.00
				
				If Not wf_Localiza_Preco(ll_Filial, ll_Produto, ls_UF, Ref ldc_Preco_Atual_UF, Ref ldc_Preco_Atual_RE, Ref ldc_Preco_Futuro, Ref lb_Achou) Then
					ll_Sucesso = 0
					Exit
				End If
				
				//Se n$$HEX1$$e300$$ENDHEX$$o achar o produto na produto_regionalizado n$$HEX1$$e300$$ENDHEX$$o mostra o mesmo na tela
				If Not lb_Achou Then
					li_Index += 1
					gvs_Log[li_Index] = "Produto '" + String(la_Dado) + "' e filial '" + String(ll_Filial) + "' n$$HEX1$$e300$$ENDHEX$$o existem na tabela preco_regionalizado. Linha '" + String(ll_Linha) + "'.~r~n"
					ll_Sucesso = 0
					Continue
				End If

				dw_2.Object.Cd_Filial					[ll_Linha] = ll_Filial
				dw_2.Object.Nm_Fantasia			[ll_Linha] = ls_Nome_Fantasia
				dw_2.Object.Cd_Produto				[ll_Linha] = ll_Produto
				dw_2.Object.De_Produto				[ll_Linha] = ls_Produto
				dw_2.Object.Vl_Preco_Atual_UF	[ll_Linha] = ldc_Preco_Atual_UF
				dw_2.Object.Vl_Preco_Atual_RE	[ll_Linha] = ldc_Preco_Atual_RE
				dw_2.Object.Vl_Preco_Futuro		[ll_Linha] = ldc_Preco_Futuro
				
				If ldc_Preco_Atual_UF <> ldc_Preco_Atual_RE Then
					dw_2.Object.Id_Selecionado[ll_Linha] = "N"
				End If
			Next
			
		Else
			ll_Sucesso = -1
		End If
		
		//Desconsidera linhas que estiverem em branco
		dw_2.SetFilter("not isnull(cd_filial)")
		dw_2.Filter( )
	End If
	
Finally		
	Close(w_Aguarde)
	SetRedraw(True)
	If IsValid(lo_Excel) Then Destroy(lo_Excel)
	dw_2.Sort()
	dw_2.GroupCalc()
	dw_2.SetFocus()
	
	Return ll_Sucesso
End Try
end function

public function boolean wf_localiza_filial (long al_filial, ref string as_nome_fantasia, ref string as_uf, ref boolean ab_achou);Select nm_fantasia, cd_uf
	Into :as_Nome_Fantasia, :as_uf
From vw_filial
Where cd_filial =:al_Filial
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		ab_Achou = True
		
	Case 100	
		ab_Achou = False
		
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar a filial '" + String(al_Filial) + "'. " + SqlCa.SqlErrText, StopSign!)
		Return False
End Choose

Return True
end function

public function boolean wf_localiza_preco (long al_filial, long al_produto, string as_uf, ref decimal adc_preco_atual_uf, ref decimal adc_preco_atual_re, ref decimal adc_preco_futuro, ref boolean ab_achou);Select coalesce(vl_preco_venda_atual, 0.00), coalesce(vl_preco_venda_futuro, 0.00)
	Into: adc_preco_atual_re, :adc_preco_futuro
From preco_regionalizado
Where cd_filial = :al_Filial
	And cd_produto = :al_Produto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		ab_Achou = True
		
	Case 100
		//Se n$$HEX1$$e300$$ENDHEX$$o achou o produto na tabela preco_regionalizado, n$$HEX1$$e300$$ENDHEX$$o mostra o mesmo na tela
		ab_Achou = False
		Return True
		
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao consultar a tabela produto_regionalizado. Filial '" + String(al_Filial) + "', produto '" + String(al_Produto) + "'. " + SqlCa.SqlErrText, StopSign!)
		Return False
End Choose

Select coalesce(vl_preco_venda_atual, 0.00)
	Into: adc_preco_atual_uf
From produto_uf
Where cd_unidade_federacao = :as_UF
	And cd_produto = :al_Produto
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao consultar a tabela produto_uf. Filial '" + String(al_Filial) + "', produto '" + String(al_Produto) + "'. " + SqlCa.SqlErrText, StopSign!)
	Return False
End If

Return True
end function

on w_ge438_exclui_prd_via_planilha.create
int iCurrent
call super::create
this.cb_importa=create cb_importa
this.gb_2=create gb_2
this.dw_2=create dw_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_importa
this.Control[iCurrent+2]=this.gb_2
this.Control[iCurrent+3]=this.dw_2
end on

on w_ge438_exclui_prd_via_planilha.destroy
call super::destroy
destroy(this.cb_importa)
destroy(this.gb_2)
destroy(this.dw_2)
end on

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge438_exclui_prd_via_planilha
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge438_exclui_prd_via_planilha
integer x = 37
integer y = 16
integer width = 2213
integer height = 184
string facename = "Verdana"
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge438_exclui_prd_via_planilha
integer x = 69
integer y = 76
integer width = 2158
integer height = 100
string dataobject = "dw_ge438_selecao_arquivo"
boolean livescroll = false
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge438_exclui_prd_via_planilha
integer x = 2318
integer y = 1940
string text = "&Excluir"
end type

event cb_ok::clicked;call super::clicked;Long ll_Linha
Long ll_Filial
Long ll_Produto
Long ll_Find

String ls_Erro
String ls_Nulo
String ls_Chave

dw_2.AcceptText()

If dw_2.RowCount() = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existe nenhum registro para ser exclu$$HEX1$$ed00$$ENDHEX$$do.", Exclamation!)
	dw_1.SetFocus()
	Return -1
End If

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a exclus$$HEX1$$e300$$ENDHEX$$o dos produtos selecionados?", Question!, YesNo!, 2) = 2 Then Return -1

ll_Find = dw_2.Find("id_selecionado = 'S'", 1, dw_2.RowCount())

If ll_Find < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Find da dw_2.", StopSign!)
	dw_2.SetFocus()
	Return -1
End If

If ll_Find = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum produto foi selecionado para a exclus$$HEX1$$e300$$ENDHEX$$o.", Exclamation!)
	dw_2.SetFocus()
	Return -1
End If

SetNull(ls_Nulo)

For ll_Linha = 1 To dw_2.RowCount()
	If dw_2.Object.Id_Selecionado[ll_Linha] = "S" Then
		ll_Filial		= dw_2.Object.Cd_Filial		[ll_Linha]
		ll_Produto	= dw_2.Object.Cd_Produto	[ll_Linha]	
		
		If IsNull(ll_Filial) Or IsNull(ll_Produto) Then Continue
		
		Delete From preco_regionalizado
		Where cd_filial = :ll_Filial
			And cd_produto = :ll_Produto
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			ls_Erro = SqlCa.SqlErrText
			SqlCa.of_RollBack();
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao excluir o produto '" + String(ll_Produto) + "' da filial '" + String(ll_Filial) + "'. " + ls_Erro, StopSign!)
			Exit
		End If
		
		ls_Chave = MidA(String(ll_Filial) + Space(4), 1, 4) + '@#!' + String(ll_Produto)
		
		If Not gf_Grava_Historico_Alteracao_Tabela('PRECO_REGIONALIZADO', ls_Chave, 'CD_PRODUTO', String(ll_Produto), ls_Nulo, gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, 'E', Ref ls_Erro, True) Then Exit
	End If
Next

SqlCa.of_Commit();
MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Exclus$$HEX1$$e300$$ENDHEX$$o realizada com sucesso.")

CloseWithReturn(Parent, "OK")
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge438_exclui_prd_via_planilha
integer x = 2661
integer y = 1940
end type

type cb_importa from commandbutton within w_ge438_exclui_prd_via_planilha
integer x = 37
integer y = 1940
integer width = 507
integer height = 100
integer taborder = 50
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

dw_2.AcceptText()

If dw_2.RowCount() > 0 Then
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A planilha j$$HEX1$$e100$$ENDHEX$$ foi importada.~rDeseja desfazer e import$$HEX1$$e100$$ENDHEX$$-la novamente?", Question!, YesNo!, 2) = 2 Then
		Return -1
	Else
		dw_2.Event ue_Reset()
	End If
End If	

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Os dados devem estar da seguinte forma:" + &
					"~rColuna A = C$$HEX1$$f300$$ENDHEX$$digo da filial" + &
					"~rColuna B = C$$HEX1$$f300$$ENDHEX$$digo do produto")

li_Retorno = GetFileOpenName("Seleciona o arquivo", + ls_Arquivo, ls_Nome, "XLSX", "Excel 2007 (*.XLSX),*.XLSX, Excel (*.XLS), *.XLS")

If li_Retorno = 1 Then 
	dw_1.Object.De_Arquivo[1] = Upper(ls_Arquivo)
	
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a atualiza$$HEX2$$e700e300$$ENDHEX$$o?", Question!, YesNo!, 2) = 1 Then
		Choose Case wf_Le_Dados_Planilha()
			Case 1
				//A planilha foi importada com sucesso
			Case 0
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Alguns dados n$$HEX1$$e300$$ENDHEX$$o foram importados.")
				Open(w_ge128_log)
			Case -1
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A planilha n$$HEX1$$e300$$ENDHEX$$o possui nenhuma linha.")
		End Choose
	End If
Else
	SetNull(ls_Nulo)
	dw_1.Object.De_Arquivo[1] = ls_Nulo
End If
end event

type gb_2 from groupbox within w_ge438_exclui_prd_via_planilha
integer x = 37
integer y = 220
integer width = 2935
integer height = 1684
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
borderstyle borderstyle = styleraised!
end type

type dw_2 from dc_uo_dw_base within w_ge438_exclui_prd_via_planilha
integer x = 78
integer y = 280
integer width = 2853
integer height = 1588
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge438_lista_planilha"
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.of_SetRowSelection()

This.of_SetRowSelection( "if(vl_preco_atual_uf <> vl_preco_atual_re,  if(getrow() = currentrow(), rgb(255, 0, 0), rgb(255,255,255)),  if(getrow() = currentrow(), rgb(0,128,128), rgb(255, 255, 255)) )", "if( vl_preco_atual_uf <> vl_preco_atual_re, RGB(255,0, 0), RGB(0,0,0))", False )					
end event

event doubleclicked;call super::doubleclicked;If dwo.Name = 'st_selecionado' Then
	
	Long lvl_Row
	
	String lvs_Marcacao
	
	This.AcceptText()
	
	If ivb_Check Then
		lvs_Marcacao = 'N'
		ivb_Check = False
	Else
		lvs_Marcacao = 'S'
		ivb_Check = True
	End If
	
	For lvl_Row = 1 To This.RowCount()
		This.Object.Id_Selecionado[lvl_Row] = lvs_Marcacao
		
		If This.Object.Vl_Preco_Atual_UF[lvl_Row] <> This.Object.Vl_Preco_Atual_RE[lvl_Row] Then
			This.Object.Id_Selecionado[lvl_Row] = "N"
		End If
	Next
End If
end event

