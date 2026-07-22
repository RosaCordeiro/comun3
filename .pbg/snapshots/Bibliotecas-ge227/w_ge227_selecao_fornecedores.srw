HA$PBExportHeader$w_ge227_selecao_fornecedores.srw
forward
global type w_ge227_selecao_fornecedores from dc_w_response_ok_cancela
end type
type cb_1 from commandbutton within w_ge227_selecao_fornecedores
end type
type cb_2 from commandbutton within w_ge227_selecao_fornecedores
end type
type cb_3 from commandbutton within w_ge227_selecao_fornecedores
end type
end forward

global type w_ge227_selecao_fornecedores from dc_w_response_ok_cancela
integer width = 3182
integer height = 1360
string title = "GE227 - Lista de Fornecedores"
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
end type
global w_ge227_selecao_fornecedores w_ge227_selecao_fornecedores

type variables
uo_Fornecedor					io_Fornecedor_Padrao //GE003
uo_ge227_fornecedores		io_Fornecedores
end variables

forward prototypes
public subroutine wf_lista_divisao_fornecedor ()
public subroutine wf_le_dados_planilha ()
public function long wf_possui_divisao (string as_fornecedor)
public function long wf_localiza_fornecedor (string as_fornecedor, ref string as_nome_fantasia)
end prototypes

public subroutine wf_lista_divisao_fornecedor ();DataWindowChild lvdwc

String ls_SQL, ls_Fornecedor, ls_Teste, ls_SQL_Original

dw_1.AcceptText()

ls_Fornecedor = dw_1.Object.cd_fornecedor[dw_1.GetRow()]
	
If dw_1.GetChild("nr_divisao_fornecedor", lvdwc) = 1 Then
	
	lvdwc.SetTransObject(SQLCA)
	
	ls_SQL = " SELECT 	cast(f.nr_divisao as char(5)) + ' - ' + f.nm_divisao + ' | ' +  u.nm_usuario de_divisao, f.nr_divisao FROM fornecedor_divisao f   " +&
				 " inner join usuario u on u.nr_matricula = f.nr_matricula_comprador " +&
				 " where f.cd_fornecedor = '" + string(ls_Fornecedor) + "'" +&
				 " union " +&
				 " select 'TODAS', null"				 
	
	lvdwc.SetSQLSelect(ls_SQL)
	
	ls_Teste = lvdwc.GetSQLSelect ( ) 
		
	If lvdwc.Retrieve() < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar as divis$$HEX1$$f500$$ENDHEX$$es do fornecedor.")
		Return 
	End If		
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild divis$$HEX1$$e300$$ENDHEX$$o fornecedor.")
End If
end subroutine

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
						
//			io_Fornecedor_Padrao.of_Localiza_Codigo(ls_Fornecedor)
//			
//			If Not io_Fornecedor_Padrao.Localizado Then
//				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "C$$HEX1$$f300$$ENDHEX$$digo fornecedor n$$HEX1$$e300$$ENDHEX$$o encontrado." + &
//								"~rLinha: " + String(ll_Linha) + &
//								"~rFornecedor: " + String(ls_Fornecedor), Exclamation!)
//				Continue
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

public function long wf_possui_divisao (string as_fornecedor);Long ll_Achou

Select Count(*)
	Into: ll_Achou
From fornecedor_divisao
Where cd_fornecedor = :as_Fornecedor
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao consultar se o fornecedor possui divis$$HEX1$$e300$$ENDHEX$$o. " + SqlCa.SqlErrText, StopSign!)
	Return -1	
End If

If ll_Achou > 0 Then
	Return 1
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Fornecedor n$$HEX1$$e300$$ENDHEX$$o possui divis$$HEX1$$e300$$ENDHEX$$o.")
	Return 0 //N$$HEX1$$e300$$ENDHEX$$o possui divis$$HEX1$$e300$$ENDHEX$$o, ent$$HEX1$$e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o abre a tela response w_ge003_divisao_fornecedor
End If
end function

public function long wf_localiza_fornecedor (string as_fornecedor, ref string as_nome_fantasia);Select nm_fantasia
	Into :as_Nome_Fantasia
From fornecedor
Where cd_fornecedor = :as_Fornecedor
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		Return 1
		
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Fornecedor n$$HEX1$$e300$$ENDHEX$$o localizado.", Exclamation!)
		Return 0
		
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o fornecedor.", StopSign!)
		Return -1
End Choose
end function

on w_ge227_selecao_fornecedores.create
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

on w_ge227_selecao_fornecedores.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
end on

event ue_postopen;call super::ue_postopen;io_Fornecedor_Padrao	= Create uo_Fornecedor
io_Fornecedores 			= Create uo_ge227_fornecedores	

io_Fornecedores = Message.PowerObjectParm	
end event

event close;call super::close;Destroy io_Fornecedor_Padrao
//Destroy io_Fornecedores
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge227_selecao_fornecedores
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge227_selecao_fornecedores
integer x = 27
integer width = 3104
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge227_selecao_fornecedores
integer x = 59
integer width = 3040
integer height = 1024
string dataobject = "dw_ge227_lista"
boolean vscrollbar = true
end type

event dw_1::ue_key;call super::ue_key;Long ll_Linha
Long ll_Find

If Key = KeyEnter! Then
	
	If This.GetColumnName() = "nm_fantasia" Then
		
		ll_Linha = This.GetRow()
	
		io_Fornecedor_Padrao.of_Localiza_Fornecedor(This.GetText())
		
		If io_Fornecedor_Padrao.Localizado Then
			
			ll_Find = Find("cd_fornecedor = '" + io_Fornecedor_Padrao.cd_fornecedor + "'" , 1, This.RowCount() )
			
			If ll_Find > 0 Then 
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O fornecedor '" +  io_Fornecedor_Padrao.cd_fornecedor + "' j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ na lista." )
				Return -1
			Else
				
				This.Object.cd_fornecedor 	[ ll_Linha ] = io_Fornecedor_Padrao.cd_Fornecedor
				This.Object.nm_fantasia		[ ll_Linha ] = io_Fornecedor_Padrao.nm_Fantasia
				//wf_lista_divisao_fornecedor()
				//This.Event ue_AddRow()
			
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

event dw_1::itemchanged;call super::itemchanged;If This.GetColumnName() ='nr_divisao_fornecedor' Then
	
	If Isnull(This.Object.cd_fornecedor[This.GetRow()]) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe um fornecedor para selecionar a divis$$HEX1$$e300$$ENDHEX$$o", Exclamation!)
		Return 1
	End If
	//wf_lista_divisao_fornecedor()
End If

//wf_lista_divisao_fornecedor()
end event

event dw_1::clicked;call super::clicked;Long ll_Nulo
Long ll_Linha
Long ll_Find
Long ll_Insert

dw_1.AcceptText()

SetNull(ll_Nulo)

str_divisao_fornecedor lstr_divisao_fornecedor

If dwo.Name = "b_divisao" Then
	If IsNull(dw_1.Object.Cd_Fornecedor[dw_1.GetRow()]) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum fornecedor foi selecionado.")
		Return -1
	End If
	
	If wf_Possui_Divisao(dw_1.Object.Cd_Fornecedor[dw_1.GetRow()]) <> 1 Then Return -1
	
	lstr_divisao_fornecedor.cd_fornecedor 					= dw_1.Object.cd_fornecedor[dw_1.GetRow()]
	lstr_divisao_fornecedor.id_selecao_varias_divisoes 	= 'N'
	
	OpenWithParm(w_ge003_divisao_fornecedor, lstr_divisao_fornecedor)
	
	lstr_divisao_fornecedor = Message.PowerObjectParm	
	
	If IsValid(lstr_divisao_fornecedor) Then		
		For ll_Linha = 1 To UpperBound(lstr_divisao_fornecedor.nr_divisao[])
			ll_Find = dw_1.Find("cd_fornecedor = '" +  lstr_divisao_fornecedor.cd_fornecedor + "'", 1, dw_1.RowCount())
			
			If ll_Find < 0 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Find da dw_1.", StopSign!)
				Return -1
			End If
			
			If ll_Find > 0 Then

				If IsNull(dw_1.Object.nr_divisao_fornecedor	[ll_Find]) Then
					dw_1.Object.cd_fornecedor				[ll_Find] = lstr_divisao_fornecedor.cd_fornecedor
					dw_1.Object.nr_divisao_fornecedor	[ll_Find] = lstr_divisao_fornecedor.nr_divisao		[ll_Linha]
					dw_1.Object.de_divisao					[ll_Find] = lstr_divisao_fornecedor.de_divisao		[ll_Linha]				
					
				Else
					ll_Find = dw_1.Find("cd_fornecedor = '" +  lstr_divisao_fornecedor.cd_fornecedor + "' and nr_divisao_fornecedor = " + String(lstr_divisao_fornecedor.nr_divisao[ll_Linha]), 1, dw_1.RowCount())
					
					If ll_Find < 0 Then
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Find da dw_1.", StopSign!)
						Return -1
					End If
					
					//Se j$$HEX1$$e100$$ENDHEX$$ tem o fornecedor e a divis$$HEX1$$e300$$ENDHEX$$o, n$$HEX1$$e300$$ENDHEX$$o insere novamente
					If ll_Find > 0 Then Continue
					
					ll_Insert = dw_1.InsertRow(0)
					
					dw_1.Object.cd_fornecedor				[ll_Insert] = lstr_divisao_fornecedor.cd_fornecedor
					dw_1.Object.nm_fantasia				[ll_Insert] = lstr_divisao_fornecedor.nm_fantasia
					dw_1.Object.nr_divisao_fornecedor	[ll_Insert] = lstr_divisao_fornecedor.nr_divisao			[ll_Linha]
					dw_1.Object.de_divisao					[ll_Insert] = lstr_divisao_fornecedor.de_divisao		[ll_Linha]
				End If
			End If
		Next
//	Else
//		dw_1.Object.nr_divisao_fornecedor	[dw_1.GetRow()] = ll_Nulo
//		dw_1.Object.de_divisao					[dw_1.GetRow()] = ''
	End If
End If
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge227_selecao_fornecedores
integer x = 2487
integer y = 1152
boolean default = false
end type

event cb_ok::clicked;call super::clicked;Long ll_Fornecedores
Long ll_Linha
Long ll_Contador

ll_Fornecedores = dw_1.GetItemNumber(dw_1.RowCount(), "total_fornecedores")
	
If ll_Fornecedores > 0 Then
		
		dw_1.Sort()
		
		For ll_Linha = 1 To dw_1.RowCount()
			
			If Not IsNull( dw_1.Object.cd_fornecedor [ll_Linha] ) Then
				
				ll_Contador ++
				
				io_Fornecedores.cd_fornecedor	[ll_Contador] = dw_1.Object.cd_Fornecedor			[ll_Linha]
				io_Fornecedores.nm_fantasia		[ll_Contador] = dw_1.Object.nm_fantasia				[ll_Linha]
				io_Fornecedores.nr_divisao			[ll_Contador] = dw_1.Object.nr_divisao_fornecedor	[ll_Linha]
				
				If ll_Contador = 1 Then
					io_Fornecedores.ivs_fornecedores = "'" + dw_1.Object.cd_fornecedor [ll_Linha] + "'"
				Else
					io_Fornecedores.ivs_fornecedores = io_Fornecedores.ivs_fornecedores + ", '" + dw_1.Object.cd_fornecedor[ll_Linha] + "'"
				End If
			Else
				dw_1.DeleteRow( ll_Linha )
			End If
			
		Next
		
		CloseWithReturn ( Parent, dw_1.GetItemNumber(dw_1.RowCount(), "total_fornecedores") )
		
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione pelo menos um fornecedor.")
End If
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge227_selecao_fornecedores
integer x = 2821
integer y = 1152
end type

type cb_1 from commandbutton within w_ge227_selecao_fornecedores
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

type cb_2 from commandbutton within w_ge227_selecao_fornecedores
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

type cb_3 from commandbutton within w_ge227_selecao_fornecedores
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
						"Coluna A = C$$HEX1$$f300$$ENDHEX$$digo do Fabricante~r"

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

