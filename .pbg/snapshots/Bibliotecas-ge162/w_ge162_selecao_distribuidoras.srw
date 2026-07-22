HA$PBExportHeader$w_ge162_selecao_distribuidoras.srw
forward
global type w_ge162_selecao_distribuidoras from dc_w_response_ok_cancela
end type
type cb_1 from commandbutton within w_ge162_selecao_distribuidoras
end type
type cb_2 from commandbutton within w_ge162_selecao_distribuidoras
end type
type cb_3 from commandbutton within w_ge162_selecao_distribuidoras
end type
end forward

global type w_ge162_selecao_distribuidoras from dc_w_response_ok_cancela
integer width = 2277
integer height = 1360
string title = "GE162 - Seleciona Distribuidora"
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
end type
global w_ge162_selecao_distribuidoras w_ge162_selecao_distribuidoras

type variables
uo_Fornecedor io_Fornecedor_Padrao //GE003
end variables

forward prototypes
public subroutine wf_le_dados_planilha ()
public function long wf_localiza_fornecedor (string as_fornecedor, ref string as_nome_fantasia)
end prototypes

public subroutine wf_le_dados_planilha ();Any la_Dado

Long ll_Find
Long ll_Linha
Long ll_Linhas

String ls_Arquivo
String ls_Fornecedor
String ls_Nome_Fantasia

dw_1.AcceptText()

ls_Arquivo = dw_1.Object.De_Arquivo[1]

dc_uo_excel lo_Excel
lo_Excel = Create dc_uo_excel

Open(w_Aguarde)
w_Aguarde.Title = "Importando o Arquivo..."

// Refer$$HEX1$$ea00$$ENDHEX$$ncia o arquivo 
If ( lo_Excel.uo_Referencia_Objeto_Excel(ls_Arquivo)) Then
	// Coluna de Refer$$HEX1$$ea00$$ENDHEX$$ncia
	ll_Linhas = lo_Excel.uo_Verifica_Tamanho_Arquivo("A")
	
	If ll_Linhas > 0 Then
		w_Aguarde.uo_Progress.of_SetMax(ll_Linhas)
		
		For ll_Linha = 1 To ll_Linhas
					
			la_Dado = lo_Excel.uo_Lendo_Dados(ll_Linha, "A")
			
			ls_Fornecedor = String(la_Dado)
			
			If Len(ls_Fornecedor) = 8 Then
				ls_Fornecedor = '0' + ls_Fornecedor
			End If
			
			If LenA(ls_Fornecedor) <> 9 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Fornecedor '" + ls_Fornecedor + "' n$$HEX1$$e300$$ENDHEX$$o localizado.")
				Continue
			End If
					
			ll_Find = dw_1.Find("cd_fornecedor = '" + ls_Fornecedor + "'", 1, dw_1.RowCount())
			
			//Se j$$HEX1$$e100$$ENDHEX$$ encontrou o fornecedor n$$HEX1$$e300$$ENDHEX$$o insere novamente
			If ll_Find > 0 Then
				Continue
			End If

			If wf_Localiza_Fornecedor(ls_Fornecedor, Ref ls_Nome_Fantasia) <> 1 Then
				Continue
				
			Else
				
				If Not IsNull(dw_1.Object.Cd_Fornecedor[dw_1.RowCount()]) Then
					dw_1.InsertRow(0)					
				End If
												
				dw_1.Object.Cd_Fornecedor[dw_1.RowCount()] = ls_Fornecedor
				dw_1.Object.Nm_Fantasia	[dw_1.RowCount()] = ls_Nome_Fantasia
			End If
		Next
	End If
End If

Close(w_Aguarde)
Destroy(lo_Excel)
end subroutine

public function long wf_localiza_fornecedor (string as_fornecedor, ref string as_nome_fantasia);Select nm_fantasia
	Into :as_Nome_Fantasia
From fornecedor
Where cd_fornecedor = :as_Fornecedor
	and id_distribuidora = 'S'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		Return 1
		
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Distribuidora [" + as_Fornecedor + "] n$$HEX1$$e300$$ENDHEX$$o localizada.", Exclamation!)
		Return 0
		
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar a distribuidora  [" + as_Fornecedor + "].", StopSign!)
		Return -1
End Choose
end function

on w_ge162_selecao_distribuidoras.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_3
end on

on w_ge162_selecao_distribuidoras.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
end on

event ue_postopen;call super::ue_postopen;io_Fornecedor_Padrao	= Create uo_Fornecedor
end event

event close;call super::close;Destroy io_Fornecedor_Padrao
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge162_selecao_distribuidoras
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge162_selecao_distribuidoras
integer x = 27
integer width = 2185
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge162_selecao_distribuidoras
integer x = 59
integer width = 2121
integer height = 1028
string dataobject = "dw_ge162_selecao_distribuidora"
boolean vscrollbar = true
end type

event dw_1::ue_key;call super::ue_key;Long ll_Linha
Long ll_Find

If Key = KeyEnter! Then
	
	If This.GetColumnName() = "nm_fantasia" Then
		
		ll_Linha = This.GetRow()
	
		io_Fornecedor_Padrao.of_Localiza_Fornecedor(This.GetText())
		
		If io_Fornecedor_Padrao.Localizado Then
			
			If IsNull(io_Fornecedor_Padrao.Id_Distribuidora) Or io_Fornecedor_Padrao.Id_Distribuidora = "N" Or io_Fornecedor_Padrao.Id_Distribuidora = "" Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O c$$HEX1$$f300$$ENDHEX$$digo '" +  io_Fornecedor_Padrao.cd_fornecedor + "' localizado n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ uma distribuidora." )
				Return -1
			End If
			
			ll_Find = Find("cd_fornecedor = '" + io_Fornecedor_Padrao.cd_fornecedor + "'" , 1, This.RowCount() )
			
			If ll_Find > 0 Then 
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A distribuidora '" +  io_Fornecedor_Padrao.cd_fornecedor + "' j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ na lista." )
				Return -1
			Else
				
				This.Object.cd_fornecedor 	[ ll_Linha ] = io_Fornecedor_Padrao.cd_Fornecedor
				This.Object.nm_fantasia		[ ll_Linha ] = io_Fornecedor_Padrao.nm_Fantasia
				
				dw_1.Event ue_AddRow()
			
			End If
			
		Else
			
			io_Fornecedor_Padrao.of_Inicializa()
			
			This.Object.cd_fornecedor 	[ ll_Linha ] = io_Fornecedor_Padrao.cd_fornecedor
			This.Object.nm_fantasia		[ ll_Linha ] = io_Fornecedor_Padrao.nm_Fantasia
			
		End If
		
	End If
	
End If
end event

event dw_1::ue_preinsertrow;call super::ue_preinsertrow;If This.Find("isnull( cd_fornecedor )", 1, This.RowCount()) > 0 Then
	Return -1
Else
	Return 1	
End If
end event

event dw_1::constructor;call super::constructor;This.of_SetRowSelection()
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge162_selecao_distribuidoras
integer x = 1563
integer y = 1152
boolean default = false
end type

event cb_ok::clicked;call super::clicked;Long ll_Fornecedores
Long ll_Linha
Long ll_Contador

String ls_Distribuidoras

ll_Fornecedores = dw_1.GetItemNumber(dw_1.RowCount(), "total_fornecedores")
	
If ll_Fornecedores > 0 Then
		
		For ll_Linha = 1 To dw_1.RowCount()
			
			If Not IsNull( dw_1.Object.cd_fornecedor [ll_Linha] ) Then
				
				ll_Contador ++
								
				If ll_Contador = 1 Then
					ls_Distribuidoras = "'" + dw_1.Object.cd_fornecedor [ll_Linha] + "'"
				Else
					ls_Distribuidoras = ls_Distribuidoras + ", '" + dw_1.Object.cd_fornecedor[ll_Linha] + "'"
				End If
			Else
				dw_1.DeleteRow( ll_Linha )
			End If
			
		Next
		
		CloseWithReturn ( Parent, ls_Distribuidoras )
		
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione pelo menos uma distribuidora.")
End If
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge162_selecao_distribuidoras
integer x = 1897
integer y = 1152
end type

event cb_cancelar::clicked;//OverRide

CloseWithReturn ( Parent, "" )
end event

type cb_1 from commandbutton within w_ge162_selecao_distribuidoras
integer x = 27
integer y = 1152
integer width = 343
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Adic&ionar"
end type

event clicked;dw_1.Event ue_AddRow()
end event

type cb_2 from commandbutton within w_ge162_selecao_distribuidoras
integer x = 1042
integer y = 1152
integer width = 343
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "E&xcluir"
end type

event clicked;Long ll_Linha

dw_1.AcceptText()

ll_Linha = dw_1.GetRow()

dw_1.deleteRow(ll_Linha)
end event

type cb_3 from commandbutton within w_ge162_selecao_distribuidoras
integer x = 398
integer y = 1152
integer width = 622
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Adicionar por Planilha"
end type

event clicked;Integer li_Retorno

String ls_Arquivo
String ls_Nome
String ls_Nulo
String ls_Mensagem

dw_1.AcceptText()

ls_Mensagem = "Os dados devem estar da seguinte forma:~r~r"+ &
						"Coluna A = C$$HEX1$$f300$$ENDHEX$$digo da Distribuidora~r"

Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Mensagem)

li_Retorno = GetFileOpenName("Seleciona o arquivo", + ls_Arquivo, ls_Nome, "XLSX", "Excel 2007 (*.XLSX),*.XLSX, Excel (*.XLS), *.XLS")

If li_Retorno = 1 Then 
	dw_1.Object.De_Arquivo[1] = Upper(ls_Arquivo)
	wf_Le_Dados_Planilha()
Else
	SetNull(ls_Nulo)
	dw_1.Object.De_Arquivo[1] = ls_Nulo
End If
end event

