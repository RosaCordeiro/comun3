HA$PBExportHeader$w_ge345_pedido_empurrado_via_excel.srw
forward
global type w_ge345_pedido_empurrado_via_excel from dc_w_cadastro_selecao_lista
end type
type cb_importar from commandbutton within w_ge345_pedido_empurrado_via_excel
end type
type cb_gravar_pedido from commandbutton within w_ge345_pedido_empurrado_via_excel
end type
type dw_3 from dc_uo_dw_base within w_ge345_pedido_empurrado_via_excel
end type
end forward

global type w_ge345_pedido_empurrado_via_excel from dc_w_cadastro_selecao_lista
string accessiblename = "Gera Pedido Almoxarifado (CO017)"
integer width = 3287
integer height = 2644
string title = "GE345 - Pedido Empurrado via Excel"
cb_importar cb_importar
cb_gravar_pedido cb_gravar_pedido
dw_3 dw_3
end type
global w_ge345_pedido_empurrado_via_excel w_ge345_pedido_empurrado_via_excel

type variables
uo_pedido_empurrado io_pedido //CO055

Boolean ivb_Check

Boolean ib_Alteracao = False
end variables

forward prototypes
public function boolean wf_le_dados_planilha ()
public function boolean wf_preenche_custo_unitario (long al_produto, ref decimal ad_custo_unitario)
public function boolean wf_preenche_campos ()
public function boolean wf_localiza_filial (long al_filial, ref string as_nome_fantasia)
public function boolean wf_localiza_produto (long al_produto, ref string as_descricao, ref decimal adc_fat_conv)
public function boolean wf_grava_item_pedido (long al_filial, long al_pedido, long al_produto[], long al_qt_pedida[], string as_atualiza[], ref string as_erro)
public function boolean wf_verifica_resumo_reposicao_estoque (long al_filial, long al_produto, ref long al_achou)
public subroutine wf_insere_motivo_padrao ()
end prototypes

public function boolean wf_le_dados_planilha ();Any la_Dado
Any la_Nulo

Decimal ldc_Custo_Unit
Decimal ldc_Fat_Conv

Long ll_Linha
Long ll_Linhas
Long ll_Produto
Long ll_Qtd_Pedida
Long ll_Achou
Long ll_Find
Long ll_Linha_Dw = 0
Long ll_Filial

String ls_Arquivo
String ls_Descricao_Prod
String ls_Nome_Fantasia

Try

dw_1.AcceptText()

dc_uo_excel lo_Excel
lo_Excel = Create dc_uo_excel

ls_Arquivo = dw_1.Object.De_Arquivo[1]

Open(w_Aguarde)
w_Aguarde.Title = "Importando o Arquivo: " + ls_Arquivo + "..."

SetRedraw(False)

// Refer$$HEX1$$ea00$$ENDHEX$$ncia o arquivo 
If ( lo_Excel.uo_Referencia_Objeto_Excel(ls_Arquivo) ) Then
	
	ll_Linhas = lo_Excel.uo_Verifica_Tamanho_Arquivo("A")
	
	If ll_Linhas > 0 Then
		w_Aguarde.uo_Progress.of_SetMax(ll_Linhas)
		
		SetNull(la_Nulo)
		
		For ll_Linha = 1 To ll_Linhas
			
			// C$$HEX1$$f300$$ENDHEX$$digo da filial
			la_Dado = lo_Excel.uo_Lendo_Dados(ll_Linha, "A")
			
			If Not IsNumber(String(la_Dado)) Or IsNull(String(la_Dado)) Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "C$$HEX1$$f300$$ENDHEX$$digo da filial $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido na linha '" + String(ll_Linha) + "'. ~rN$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ inclu$$HEX1$$ed00$$ENDHEX$$do na lista.", Exclamation!)
				Continue
			End If
			
			ll_Filial = Long(la_Dado)
					
			If Not wf_Localiza_Filial(ll_Filial, Ref ls_Nome_Fantasia) Then Return False
					
			la_Dado = lo_Excel.uo_Lendo_Dados(ll_Linha, "B")
			
			If Not IsNumber(String(la_Dado)) Or IsNull(String(la_Dado)) Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "C$$HEX1$$f300$$ENDHEX$$digo do produto $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido na linha '" + String(ll_Linha) + "'. ~rN$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ inclu$$HEX1$$ed00$$ENDHEX$$do na lista.", Exclamation!)
				Continue
			End If
			
			ll_Produto = Long(la_Dado)
			
			ll_Find = dw_2.Find("cd_produto = " + String(ll_Produto) + " and cd_filial = " + String(ll_Filial), 1, dw_2.RowCount())
					
			If ll_Find > 0 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto '" + String(ll_Produto) + "' foi informado mais de uma vez na planilha para a filial '" + String(ll_Filial) + "'." + &
								"~rSomente o primeiro registro ser$$HEX1$$e100$$ENDHEX$$ considerado.", Exclamation!)
				Continue
			End If
					
			If Not wf_Localiza_Produto(ll_Produto, Ref ls_Descricao_Prod, Ref ldc_Fat_Conv) Then Return False
			
			//Quantidade pedida
			la_Dado = lo_Excel.uo_Lendo_Dados(ll_Linha, "C")
					
			If Not IsNumber(String(la_Dado)) Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Quantidade pedida do produto $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lida na linha '" + String(ll_Linha) + "'. ~rSer$$HEX1$$e100$$ENDHEX$$ inclu$$HEX1$$ed00$$ENDHEX$$do na lista com quantidade nula.")
				la_Dado = la_Nulo
			End If
				
			ll_Qtd_Pedida = Long(la_Dado)
			
			If Not wf_Preenche_Custo_Unitario(ll_Produto, Ref ldc_Custo_Unit) Then Return False
				
			If Not wf_Verifica_Resumo_Reposicao_Estoque(ll_Filial, ll_Produto, Ref ll_Achou) Then Return False

			ll_Linha_Dw++
			
			dw_2.Object.Cd_Produto				[ll_Linha_Dw] = ll_Produto
			dw_2.Object.De_Produto				[ll_Linha_Dw] = ls_Descricao_Prod
			dw_2.Object.Qtd_Pedida				[ll_Linha_Dw] = ll_Qtd_Pedida
			dw_2.Object.Qt_Final					[ll_Linha_Dw] = (ldc_Fat_Conv * ll_Qtd_Pedida)
			dw_2.Object.Vl_Custo				[ll_Linha_Dw] = ldc_Custo_Unit
			dw_2.Object.Cd_Filial					[ll_Linha_Dw] = ll_Filial
			dw_2.Object.Nm_Fantasia			[ll_Linha_Dw] = ls_Nome_Fantasia
			dw_2.Object.Vl_Fator_Conversao	[ll_Linha_Dw] = ldc_Fat_Conv			
			
			If ll_Achou = 0 Then //Produto n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ na resumo_reposicao_estoque
				dw_2.Object.Id_Divergencia		[ll_Linha_Dw] = 1
			Else
				dw_2.Object.Id_Divergencia		[ll_Linha_Dw] = 0
			End If

			dw_2.Object.Id_Selecionado[ll_Linha_Dw] = "S"		
		Next
	End If
End If

//dw_2.of_SetRowSelection("if (id_divergencia > 0, rgb(255, 0, 0), rgb(255, 255, 255))","")

dw_2.of_SetRowSelection( "if(id_divergencia > 0,  if(getrow() = currentrow(), rgb(255, 0, 0), rgb(255,255,255)),  if(getrow() = currentrow(), rgb(0,128,128), rgb(255, 255, 255)) )", "if( id_divergencia > 0, RGB(255,0, 0), RGB(0,0,0))", False )					

dw_2.Sort()
dw_2.GroupCalc()
dw_2.SetFocus()

If dw_2.RowCount() > 0 Then
	Cb_Gravar_Pedido.Enabled = True
End If

ivm_Menu.mf_Recuperar(False)
ivm_Menu.mf_Incluir(False)
ivm_Menu.mf_Excluir(False)

SetRedraw(True)

Finally
	Close(w_Aguarde)
	If IsValid(lo_Excel) Then Destroy(lo_Excel)	
End Try

Return True
end function

public function boolean wf_preenche_custo_unitario (long al_produto, ref decimal ad_custo_unitario);Select Coalesce(vl_custo_gerencial, 0)
	Into :ad_custo_unitario
From vw_saldo_atual_produto
Where cd_filial = 534
   And cd_produto = :al_Produto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	
	Case 100
		ad_custo_unitario = 0
		
	Case -1
		SqlCa.of_MsgdbError("Erro ao localizado custo unit$$HEX1$$e100$$ENDHEX$$rio do produto na vw_saldo_atual_produto")
		Return False		
End Choose

Return True
end function

public function boolean wf_preenche_campos ();Date ldt_Periodo

Long ll_Linhas

ldt_Periodo = Date(gf_GetServerDate())
ldt_Periodo = RelativeDate(ldt_Periodo, -30)

ll_Linhas = dw_3.Retrieve(ldt_Periodo)

Choose Case ll_Linhas
		
	Case 0
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Filial n$$HEX1$$e300$$ENDHEX$$o possui nenhum pedido com situa$$HEX2$$e700e300$$ENDHEX$$o 'COLOCADO' nos $$HEX1$$fa00$$ENDHEX$$ltimos 30 dias.", Exclamation!)
		Return False
		
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no retrieve. Fun$$HEX2$$e700e300$$ENDHEX$$o wf_preenche_campos", StopSign!)
		Return False
		
	Case Else
		dw_3.GroupCalc()
		dw_3.SetFocus()
		Return True
		
End Choose
end function

public function boolean wf_localiza_filial (long al_filial, ref string as_nome_fantasia);Select nm_fantasia
	Into :as_Nome_Fantasia
From filial
Where cd_filial = :al_Filial
	And id_situacao = 'A'
	And cd_filial Not In(534)
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		Return True
		
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "C$$HEX1$$f300$$ENDHEX$$digo da filial '" + String(al_Filial) + "' $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido ou inativo.", Exclamation!)
		
	Case -1
		SqlCa.of_MsgdbError("Erro ao localizar o nome da filial")

End Choose

Return False
end function

public function boolean wf_localiza_produto (long al_produto, ref string as_descricao, ref decimal adc_fat_conv);String ls_Grupo

Select de_produto + ' : ' + de_apresentacao_estoque, substring(cd_subcategoria, 1, 1), vl_fator_conversao
	Into :as_Descricao, :ls_Grupo, :adc_fat_conv
From produto_geral
Where cd_produto = :al_produto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0			
		If ls_Grupo = '5' Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produto '" + as_Descricao + "' c$$HEX1$$f300$$ENDHEX$$digo '" + String(al_Produto) + "' $$HEX1$$e900$$ENDHEX$$ do grupo almoxarifado.", Exclamation!)
			Return False
		End If
		
		Return True
		
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produto '" + String(al_Produto) + "' n$$HEX1$$e300$$ENDHEX$$o localizado.", Exclamation!)
		
	Case -1
		SqlCa.of_MsgdbError("Erro ao localizar o produto na tabela PRODUTO_GERAL na fun$$HEX2$$e700e300$$ENDHEX$$o wf_localiza_produto")

End Choose

Return False
end function

public function boolean wf_grava_item_pedido (long al_filial, long al_pedido, long al_produto[], long al_qt_pedida[], string as_atualiza[], ref string as_erro);Long ll_Linha
Long ll_Produto
Long ll_Qtde
Long ll_Achou
Long ll_Qtd_Selec
Long ll_Cod_Motivo_Empurrado
DateTime ldt_hoje

String ls_Nulo
String ls_Chave
String ls_Erro
String ls_motivo

SetNull(ls_Nulo)
ldt_hoje = gf_GetServerDate()

ll_Cod_Motivo_Empurrado 	= dw_1.Object.cd_Motivo	[1]

For ll_Linha = 1 To UpperBound(al_produto[])
	
	If as_Atualiza[ll_Linha] = "N" Then Continue
	
	ll_Qtd_Selec++
		
	ll_Produto 						= al_produto					[ll_Linha]
	ll_Qtde							= al_qt_pedida					[ll_Linha]
	
	Select cd_produto
		Into :ll_Achou
	From pedido_empurrado_produto
	Where cd_filial = :al_Filial
		And nr_pedido_empurrado = :al_Pedido
		And cd_produto = :ll_Produto
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			
		Case 100
			
			Insert Into pedido_empurrado_produto(cd_filial, nr_pedido_empurrado, cd_produto, qt_empurrada, qt_faturada, id_situacao, nr_matricula_inclusao, cd_motivo_empurrado, qt_aprovada, nr_matricula_aprovacao, dh_aprovacao   )
												Values(:al_Filial, :al_Pedido, :ll_Produto, :ll_Qtde, 0, 'C', :gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, :ll_Cod_Motivo_Empurrado,:ll_Qtde , :gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, :ldt_hoje   )
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				as_Erro = "Erro ao inserir o item no pedido." + SqlCa.SqlErrText
				Return False
			End If
			
			ls_Chave = String(al_Filial) + "@#!" + String(al_Pedido) + "@#!" + String(ll_Produto)
		
			//A fun$$HEX2$$e700e300$$ENDHEX$$o gf_Grava_Historico_Alteracao_Tabela j$$HEX1$$e100$$ENDHEX$$ faz Rollback(); em caso de erro
			If Not gf_Grava_Historico_Alteracao_Tabela('PEDIDO_EMPURRADO_PRODUTO', ls_Chave, 'QT_EMPURRADA', ls_Nulo, String(ll_Qtde), gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, 'I', Ref ls_Erro, True) Then
				Return False
			End If
			
			ib_Alteracao = True
			
		Case -1
			SqlCa.of_MsgdbError("Erro ao incluir o produto no pedido." + SqlCa.SqlErrText)
			Return False
	End Choose
Next

//Se n$$HEX1$$e300$$ENDHEX$$o tem nenhum produto para atualizar faz o RollBack() para deletar o cabe$$HEX1$$e700$$ENDHEX$$alho
If ll_Qtd_Selec = 0 Then
	SqlCa.of_RollBack();
End If

Return True
end function

public function boolean wf_verifica_resumo_reposicao_estoque (long al_filial, long al_produto, ref long al_achou);Select Count(*)
	Into :al_Achou
From resumo_reposicao_estoque
Where cd_filial = :al_Filial
	And cd_produto = :al_Produto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		Return True
 
	Case -1
		SqlCa.of_MsgdbError("Erro ao localizar o produto na RESUMO_REPOSICAO_ESTOQUE")
		Return False
End Choose
end function

public subroutine wf_insere_motivo_padrao ();DataWindowChild lvdwc

Integer lvi_Retorno,&
        lvi_Row

If dw_1.GetChild("cd_motivo", lvdwc) = 1 Then
	lvdwc.InsertRow(1)
	
	lvdwc.SetItem(1, "cd_motivo_empurrado", 0)
	lvdwc.SetItem(1, "de_motivo_empurrado", "NENHUM")
	
	dw_1.Object.Cd_Motivo[1] = 0
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild do Motivo.")
End If
end subroutine

on w_ge345_pedido_empurrado_via_excel.create
int iCurrent
call super::create
this.cb_importar=create cb_importar
this.cb_gravar_pedido=create cb_gravar_pedido
this.dw_3=create dw_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_importar
this.Control[iCurrent+2]=this.cb_gravar_pedido
this.Control[iCurrent+3]=this.dw_3
end on

on w_ge345_pedido_empurrado_via_excel.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_importar)
destroy(this.cb_gravar_pedido)
destroy(this.dw_3)
end on

event ue_postopen;call super::ue_postopen;ivm_Menu.mf_Recuperar(False)
ivm_Menu.mf_Incluir(False)

io_Pedido = Create uo_pedido_empurrado

wf_insere_motivo_padrao()
end event

event close;call super::close;Destroy(io_Pedido)
end event

type dw_visual from dc_w_cadastro_selecao_lista`dw_visual within w_ge345_pedido_empurrado_via_excel
end type

type gb_aux_visual from dc_w_cadastro_selecao_lista`gb_aux_visual within w_ge345_pedido_empurrado_via_excel
end type

type dw_1 from dc_w_cadastro_selecao_lista`dw_1 within w_ge345_pedido_empurrado_via_excel
integer y = 76
integer width = 2213
integer height = 160
string dataobject = "dw_ge345_selecao"
end type

type gb_2 from dc_w_cadastro_selecao_lista`gb_2 within w_ge345_pedido_empurrado_via_excel
integer y = 256
integer width = 3168
integer height = 2044
end type

type gb_1 from dc_w_cadastro_selecao_lista`gb_1 within w_ge345_pedido_empurrado_via_excel
integer width = 2281
integer height = 248
end type

type dw_2 from dc_w_cadastro_selecao_lista`dw_2 within w_ge345_pedido_empurrado_via_excel
integer y = 332
integer width = 3090
integer height = 1932
string dataobject = "dw_ge345_lista"
string ivs_cor_linha_padrao = "if(getrow() = currentrow(), rgb(0,128,128), rgb(255, 255, 255)))"
end type

event dw_2::constructor;call super::constructor;This.of_SetRowSelection()
This.ivb_Ordena_Colunas = True
end event

event dw_2::doubleclicked;call super::doubleclicked;If dwo.Name = 'st_selecionado' Then
	
	Long lvl_Row
	
	String lvs_Marcacao
	
	If ivb_Check Then
		lvs_Marcacao = 'N'
		ivb_Check = False
	Else
		lvs_Marcacao = 'S'
		ivb_Check = True
	End If
	
	This.AcceptText()
	
	For lvl_Row = 1 To This.RowCount()
	
		This.Object.Id_Selecionado[lvl_Row] = lvs_Marcacao
	Next
End If
end event

event dw_2::editchanged;call super::editchanged;ivm_Menu.mf_Recuperar(False)
ivm_Menu.mf_Incluir(False)
ivm_Menu.mf_Excluir(False)
ivm_Menu.mf_Confirmar(False)
ivm_Menu.mf_Cancelar(False)

If dwo.Name = "qtd_pedida" Then
	This.Object.Qt_Final[This.GetRow()] = This.Object.Vl_Fator_Conversao[This.GetRow()] * Long(Data)
End If
end event

event dw_2::itemchanged;call super::itemchanged;ivm_Menu.mf_Recuperar(False)
ivm_Menu.mf_Incluir(False)
ivm_Menu.mf_Excluir(False)
ivm_Menu.mf_Confirmar(False)
ivm_Menu.mf_Cancelar(False)

If dwo.Name = "qtd_pedida" Then
	This.Object.Qt_Final[This.GetRow()] = This.Object.Vl_Fator_Conversao[This.GetRow()] * Long(Data)
End If
end event

type cb_importar from commandbutton within w_ge345_pedido_empurrado_via_excel
integer x = 37
integer y = 2324
integer width = 567
integer height = 112
integer taborder = 20
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
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A planilha j$$HEX1$$e100$$ENDHEX$$ foi importada. Deseja desfazer e import$$HEX1$$e100$$ENDHEX$$-la novamente?", Question!, YesNo!, 2) = 2 Then
		Return -1
	Else
		dw_2.Reset()
	End If
End If
	
MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Os dados devem estar da seguinte forma:" + &
							"~rColuna A = C$$HEX1$$f300$$ENDHEX$$digo da filial" + &
							"~rColuna B = C$$HEX1$$f300$$ENDHEX$$digo do produto" + &
							"~rColuna C = Quantidade pedida")
				
li_Retorno = GetFileOpenName("Seleciona o arquivo", + ls_Arquivo, ls_Nome, "XLSX", "Excel 2007 (*.XLSX),*.XLSX, Excel (*.XLS), *.XLS")

If li_Retorno = 1 Then 
	dw_1.Object.De_Arquivo[1] = Upper(ls_Arquivo)
	If Not wf_Le_Dados_Planilha() Then
		Return -1
	End If
Else
	SetNull(ls_Nulo)
	dw_1.Object.De_Arquivo[1] = ls_Nulo
End If
end event

type cb_gravar_pedido from commandbutton within w_ge345_pedido_empurrado_via_excel
integer x = 2747
integer y = 2324
integer width = 457
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Gravar Pedido"
end type

event clicked;Boolean lb_Sucesso = True

Long ll_Pedido
Long ll_Find
Long ll_Filial
Long ll_Qtd_Pedida
Long ll_Linha
Long ll_Fator
Long ll_Produto
Long ll_Nulo
Long ll_Array_Nulo[]
Long ll_Filial_Array[]
Long ll_Contador
Long ll_Filial_Proxima
Long ll_Filial_Produto[]
Long ll_Filial_Qtde[]
Long ll_Motivo_Empurrado

String ls_Erro
String ls_Selecionado
String ls_Atualiza[]
String ls_Array_Nulo[]

dw_2.AcceptText()

ivm_Menu.mf_Confirmar(False)
ivm_Menu.mf_Cancelar(False)
ivm_Menu.mf_Excluir(False)

ll_Find = dw_2.Find("id_selecionado = 'S'", 1, dw_2.RowCount())

If ll_Find = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum produto foi selecionado.", Exclamation!)
	dw_2.SetFocus()
	Return -1
End If

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a opera$$HEX2$$e700e300$$ENDHEX$$o?", Question!, YesNo!, 2) = 2 Then
	Return -1
End If

SetNull(ll_Nulo)

ll_Find = dw_2.Find("IsNull(qtd_pedida) Or qtd_pedida = 0", 1, dw_2.RowCount())

If ll_Find > 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a quantidade pedida do produto.")
	dw_2.Event ue_Pos(ll_Find, "qtd_pedida")
	Return -1
End If

ib_Alteracao = False

ll_Motivo_Empurrado = dw_1.Object.Cd_Motivo[1]

If ll_Motivo_Empurrado = 0 or isnull(ll_Motivo_Empurrado) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Selecione o motivo do pedido empurrado.",Exclamation!)
	dw_1.Event ue_Pos(1, "cd_motivo")
	Return -1
End If

For ll_Linha = 1 To dw_2.RowCount()
		
	ll_Contador ++
	
	ll_Qtd_Pedida	= dw_2.Object.Qtd_Pedida				[ll_Linha]
	ll_Fator			= dw_2.Object.Vl_Fator_Conversao	[ll_Linha]
	ll_Produto		= dw_2.Object.Cd_Produto				[ll_Linha]
	ls_Selecionado	= dw_2.Object.Id_Selecionado			[ll_Linha]
	ll_Filial			= dw_2.Object.Cd_Filial					[ll_Linha]
	
	If ls_Selecionado = "N" Then
		ls_Atualiza[ll_Contador] = "N"
	Else
		ls_Atualiza[ll_Contador] = "S"
	End If
	
	If ( ll_Linha < dw_2.RowCount() ) Then 	
		ll_Filial_Proxima = dw_2.Object.Cd_Filial [ll_Linha + 1]
	End If

	ll_Filial_Array	[ll_Contador] = ll_Filial
	ll_Filial_Produto[ll_Contador] = ll_Produto
	ll_Filial_Qtde	[ll_Contador] = ll_Qtd_Pedida
	
	If (ll_Filial <> ll_Filial_Proxima) Or (ll_Linha = dw_2.RowCount()) Then
		
		If Not io_Pedido.of_Pedido_Nao_Processado(ll_Filial, Ref ll_Pedido) Then
			lb_Sucesso = False
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Tem Pedido n$$HEX1$$e300$$ENDHEX$$o Processado: A Filial:" + String(ll_Filial) + " e o Produto:"+String(ll_Produto), StopSign!) 
			Exit
		End If
		
		If IsNull(ll_Pedido) Then
			If Not io_Pedido.of_Inclui_Pedido(ll_Filial, Ref ll_Pedido) Then
				lb_Sucesso = False
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o Inserido o Pedido, na Filial:" + String(ll_Filial) + " e o Produto:"+String(ll_Produto), StopSign!)  
				Exit
			End If
			
		End If
				
		If wf_Grava_Item_Pedido(ll_Filial, ll_Pedido, ll_Filial_Produto[], ll_Filial_Qtde[], ls_Atualiza[], Ref ls_Erro) Then
			If ib_Alteracao Then
				SqlCa.of_Commit();
			End If
		Else
			SqlCa.of_RollBack();
	
			If ls_Erro <> "" Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Erro, StopSign!)
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o"," Erro na Filial:" + String(ll_Filial) + " e o Produto:"+String(ll_Produto), StopSign!) 
			End If
		End If
		
		ll_Contador = 0
		ll_Filial_Array	[] = ll_Array_Nulo	[]
		ll_Filial_Produto[] = ll_Array_Nulo	[]
		ll_Filial_Qtde	[] = ll_Array_Nulo	[]
		ls_Atualiza		[] = ls_Array_Nulo	[]
	End If
Next
	
If lb_Sucesso Then
	If ib_Alteracao Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Pedido(s) gravado(s) com sucesso.")
		dw_2.Event ue_Reset()
		ivm_Menu.mf_Excluir(False)
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o houveram altera$$HEX2$$e700f500$$ENDHEX$$es.")
	End If
End If
end event

type dw_3 from dc_uo_dw_base within w_ge345_pedido_empurrado_via_excel
boolean visible = false
integer x = 2185
integer y = 1168
integer taborder = 20
boolean bringtotop = true
end type

