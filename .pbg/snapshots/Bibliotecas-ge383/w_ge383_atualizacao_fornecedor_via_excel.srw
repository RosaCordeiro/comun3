HA$PBExportHeader$w_ge383_atualizacao_fornecedor_via_excel.srw
forward
global type w_ge383_atualizacao_fornecedor_via_excel from dc_w_response_ok_cancela
end type
type cb_selecionar from commandbutton within w_ge383_atualizacao_fornecedor_via_excel
end type
end forward

global type w_ge383_atualizacao_fornecedor_via_excel from dc_w_response_ok_cancela
integer width = 2149
integer height = 500
string title = "GE383 - Atualiza$$HEX2$$e700e300$$ENDHEX$$o de Fornecedor via Excel"
cb_selecionar cb_selecionar
end type
global w_ge383_atualizacao_fornecedor_via_excel w_ge383_atualizacao_fornecedor_via_excel

forward prototypes
public subroutine wf_localiza_tipo (string as_tipo)
public function long wf_le_dados_planilha (string as_tipo, string as_arquivo)
public function boolean wf_valida_fornecedor (string as_fornecedor)
public function boolean wf_valida_comprador (string as_matricula)
public function boolean wf_atualiza (string as_tipo, string as_fornecedor, string as_matricula)
end prototypes

public subroutine wf_localiza_tipo (string as_tipo);/*
1 - Altera Comprador
2 - Inativa Fornecedor
*/

String ls_Mensagem

ls_Mensagem = "Os dados devem estar da seguinte forma: " + &
					 "~r~rColuna A: C$$HEX1$$f300$$ENDHEX$$digo do Fornecedor"

Choose Case as_Tipo
	Case "1"
		ls_Mensagem  += "~rColuna B: Matr$$HEX1$$ed00$$ENDHEX$$cula do Comprador"
	Case "2"
		//Somente o c$$HEX1$$f300$$ENDHEX$$digo do fornecedor
End Choose

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Mensagem)
end subroutine

public function long wf_le_dados_planilha (string as_tipo, string as_arquivo);Any la_Dado

Boolean lb_Altera

Integer li_Index

Long ll_Linha
Long ll_Linhas
Long ll_Sucesso = 1
Long ll_Len

String ls_Fornecedor
String ls_Matricula

/*
1 - Altera Comprador
2 - Inativa Fornecedor
*/

Try

dc_uo_excel lo_Excel
lo_Excel = Create dc_uo_excel

Open(w_Aguarde)
w_Aguarde.Title = "Atualizando dados..."

// Refer$$HEX1$$ea00$$ENDHEX$$ncia o arquivo 
If ( lo_Excel.uo_Referencia_Objeto_Excel(as_Arquivo) ) Then
	// Coluna de Refer$$HEX1$$ea00$$ENDHEX$$ncia
	ll_Linhas = lo_Excel.uo_Verifica_Tamanho_Arquivo("A") 
	
	If ll_Linhas > 0 Then
		w_Aguarde.uo_Progress.of_SetMax(ll_Linhas)
		
		For ll_Linha = 1 To ll_Linhas
			
			lb_Altera = True			
			
			// Fornecedor
			la_Dado = lo_Excel.uo_Lendo_Dados(ll_Linha, "A")
									
			ll_Len = LenA(String(la_Dado))
			
			If ll_Len = 8 Then
				la_Dado = "0" + String(la_Dado)
			End If
			
			If Not wf_Valida_Fornecedor(String(la_Dado)) Then
				//Se for nulo atribui branco para mostrar a mensagem
				If IsNull(la_Dado) Then
					la_Dado = ""
				End If
				
				li_Index += 1
				gvs_Log[li_Index] = "Fornecedor '" + String(la_Dado) + "' inv$$HEX1$$e100$$ENDHEX$$lido na linha '" + String(ll_Linha) + "'.~r~n"
				ll_Sucesso = 0
				lb_Altera = False
			End If
			
			ls_Fornecedor = String(la_Dado)
			
			Choose Case as_Tipo
				Case "1"
					
					// Matr$$HEX1$$ed00$$ENDHEX$$cula Comprador
					la_Dado = lo_Excel.uo_Lendo_Dados(ll_Linha, "B")
					
					If Not wf_Valida_Comprador(String(la_Dado)) Then
						If IsNull(la_Dado) Then
							la_Dado = ""
						End If
						
						li_Index += 1
						gvs_Log[li_Index] = "Matr$$HEX1$$ed00$$ENDHEX$$cula do Comprador '" + String(la_Dado) + "' inv$$HEX1$$e100$$ENDHEX$$lida ou inativa na linha '" + String(ll_Linha) + "'.~r~n"
						ll_Sucesso = 0
						lb_Altera = False
					End If
					
					ls_Matricula = String(la_Dado)
			End Choose
						
			If lb_Altera Then
				If Not wf_Atualiza(as_Tipo, ls_Fornecedor, ls_Matricula) Then Return -2
			End If
			
			w_Aguarde.uo_Progress.of_SetProgress(ll_Linha)
		Next
	Else
		ll_Sucesso = -1
	End If
End If

Return ll_Sucesso

Finally
	If IsValid(lo_Excel) Then Destroy(lo_Excel)
	Close(w_Aguarde)
End Try
end function

public function boolean wf_valida_fornecedor (string as_fornecedor);Long ll_Achou

If IsNull(as_Fornecedor) Then Return False

If Not IsNumber(as_Fornecedor) Then Return False

If LenA(as_Fornecedor) <> 9 Then Return False

Select Count(*)
	Into: ll_Achou
From fornecedor
Where cd_fornecedor = :as_Fornecedor
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If ll_Achou > 0 Then
			Return True
		End If
		
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao consultar o fornecedor. " + SqlCa.SqlErrText, StopSign!)
		
End Choose

Return False
end function

public function boolean wf_valida_comprador (string as_matricula);Long ll_Achou

If IsNull(as_Matricula) Then Return False

If Not IsNumber(as_Matricula) Then Return False

Select Count(*)
	Into: ll_Achou
From comprador
Where nr_matricula = :as_Matricula
	And id_situacao = 'A'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If ll_Achou > 0 Then
			Return True
		End If
		
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o comprador. " + SqlCa.SqlErrText, StopSign!)
		
End Choose

Return False
end function

public function boolean wf_atualiza (string as_tipo, string as_fornecedor, string as_matricula);/*
1 - Altera Comprador
2 - Inativa Fornecedor
*/

String ls_Erro
String ls_Matricula
String ls_Situacao
String ls_Responsavel

Select nr_matricula_comprador, id_situacao
	Into :ls_Matricula, :ls_Situacao
From fornecedor
Where cd_fornecedor = :as_Fornecedor
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o fornecedor. " + SqlCa.SqlErrText, StopSign!)
	Return False
End If

ls_Responsavel = gvo_Aplicacao.ivo_Seguranca.Nr_Matricula

Choose Case as_Tipo
		
	Case "1"
		
		//Se o registro a atualizar $$HEX1$$e900$$ENDHEX$$ o mesmo do cadastro, ou seja, se n$$HEX1$$e300$$ENDHEX$$o teve altera$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o faz o update
		If ls_Matricula = as_Matricula Then Return True
		
		Update fornecedor
			Set nr_matricula_comprador = :as_Matricula
		Where cd_fornecedor = :as_Fornecedor
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			ls_Erro = SqlCa.SqlErrText
			SqlCa.of_RollBack();
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao atualizar o comprador do fornecedor '" + as_Fornecedor + "'. " + ls_Erro, StopSign!)
			Return False
		End If
		
		If Not gf_Grava_Historico_Alteracao_Tabela('FORNECEDOR', as_Fornecedor, 'NR_MATRICULA_COMPRADOR', ls_Matricula, as_Matricula, ls_Responsavel, 'A', Ref ls_Erro, True) Then Return False
	
	Case "2"
		
		//Se o registro a atualizar $$HEX1$$e900$$ENDHEX$$ o mesmo do cadastro, ou seja, se n$$HEX1$$e300$$ENDHEX$$o teve altera$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o faz o update
		If ls_Situacao = "I" Then Return True
		
		Update fornecedor
			Set id_situacao = 'I'
		Where cd_fornecedor = :as_Fornecedor
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			ls_Erro = SqlCa.SqlErrText
			SqlCa.of_RollBack();
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao atualizar a situa$$HEX2$$e700e300$$ENDHEX$$o do fornecedor. " + ls_Erro, StopSign!)
			Return False
		End If
		
		If Not gf_Grava_Historico_Alteracao_Tabela('FORNECEDOR', as_Fornecedor, 'ID_SITUACAO', ls_Situacao, 'I', ls_Responsavel, 'A', Ref ls_Erro, True) Then Return False
End Choose

SqlCa.of_Commit();

Return True
end function

on w_ge383_atualizacao_fornecedor_via_excel.create
int iCurrent
call super::create
this.cb_selecionar=create cb_selecionar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_selecionar
end on

on w_ge383_atualizacao_fornecedor_via_excel.destroy
call super::destroy
destroy(this.cb_selecionar)
end on

event ue_preopen;call super::ue_preopen;If Not gf_Verifica_Cutover("DH_CUTOVER_FORNECEDOR") Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ mais permitida a atualiza$$HEX2$$e700e300$$ENDHEX$$o dos dados do fornecedor por esta tela.~rUtilize o SAP.")
	This.il_Retorno = -1
End If
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge383_atualizacao_fornecedor_via_excel
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge383_atualizacao_fornecedor_via_excel
integer width = 2080
integer height = 268
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge383_atualizacao_fornecedor_via_excel
integer width = 2021
integer height = 176
string dataobject = "dw_ge383_selecao_arquivo"
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge383_atualizacao_fornecedor_via_excel
integer x = 1458
integer y = 296
integer width = 320
string text = "&Atualizar"
end type

event cb_ok::clicked;call super::clicked;String ls_Tipo
String ls_Arquivo

dw_1.AcceptText()

ls_Tipo		= dw_1.Object.De_Tipo		[1]
ls_Arquivo	= dw_1.Object.De_Arquivo	[1]

If IsNull(ls_Tipo) Or Trim(ls_Tipo) = "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione o tipo de arquivo a ser atualizado.")
	dw_1.Event ue_Pos(1, "de_tipo")
	Return -1
End If

If IsNull(ls_Arquivo) Or Trim(ls_Arquivo) = "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione o arquivo a ser importado.")
	dw_1.SetFocus()
	Return -1
End If

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a atualiza$$HEX2$$e700e300$$ENDHEX$$o?", Question!, YesNo!, 2) = 1 Then
	Choose Case wf_Le_Dados_Planilha(ls_Tipo, ls_Arquivo)
		Case 1
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Todos os dados foram atualizados com sucesso.")
			dw_1.Event ue_Reset()
			dw_1.Event ue_AddRow()
		Case 0
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Alguns dados n$$HEX1$$e300$$ENDHEX$$o foram atualizados.")
			Open(w_ge128_log)
		Case -1
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A planilha n$$HEX1$$e300$$ENDHEX$$o possui nenhuma linha.")
	End Choose
End If
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge383_atualizacao_fornecedor_via_excel
integer x = 1792
integer y = 296
end type

type cb_selecionar from commandbutton within w_ge383_atualizacao_fornecedor_via_excel
integer x = 32
integer y = 296
integer width = 640
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Selecionar Arquivo"
end type

event clicked;Integer li_Retorno 

String ls_Tipo
String ls_Arquivo
String ls_Nome
String ls_Nulo

dw_1.AcceptText()

ls_Tipo = dw_1.Object.De_Tipo[1]

If IsNull(ls_Tipo) Or Trim(ls_Tipo) = "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione o tipo de arquivo a ser atualizado.")
	dw_1.Event ue_Pos(1, "de_tipo")
	Return -1
End If

wf_Localiza_Tipo(ls_Tipo)

li_Retorno = GetFileOpenName("Seleciona o arquivo", + ls_Arquivo, ls_Nome, "XLSX", "Excel 2007 (*.XLSX),*.XLSX, Excel (*.XLS), *.XLS")

If li_Retorno = 1 Then 
	dw_1.Object.De_Arquivo[1] = Upper(ls_Arquivo)
	cb_Ok.Enabled = True
Else
	SetNull(ls_Nulo)
	dw_1.Object.De_Arquivo[1] = ls_Nulo
	cb_Ok.Enabled = False
End If
end event

