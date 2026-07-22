HA$PBExportHeader$w_ge037_relatorio_ajuste_estoque.srw
forward
global type w_ge037_relatorio_ajuste_estoque from dc_w_selecao_lista_relatorio
end type
type dw_4 from dc_uo_dw_base within w_ge037_relatorio_ajuste_estoque
end type
type cb_seguro from commandbutton within w_ge037_relatorio_ajuste_estoque
end type
type cb_importar from commandbutton within w_ge037_relatorio_ajuste_estoque
end type
end forward

global type w_ge037_relatorio_ajuste_estoque from dc_w_selecao_lista_relatorio
integer x = 215
integer y = 220
integer width = 3584
integer height = 1980
string title = "GE037 - Relat$$HEX1$$f300$$ENDHEX$$rio de Ajustes de Estoque"
dw_4 dw_4
cb_seguro cb_seguro
cb_importar cb_importar
end type
global w_ge037_relatorio_ajuste_estoque w_ge037_relatorio_ajuste_estoque

type variables
UO_PRODUTO ivo_produto
UO_FILIAL       ivo_filial
uo_fornecedor ivo_fornecedor

DATAWINDOWCHILD	idwc_motivo

string ivs_filiais, ivs_nulo, is_Produtos
end variables

forward prototypes
public subroutine wf_insere_motivo_default ()
public subroutine wf_localiza_filial ()
public subroutine wf_localiza_produto ()
public function integer of_lastpos (string as_source, string as_target, long al_start)
public function integer wf_le_dados_planilha ()
end prototypes

public subroutine wf_insere_motivo_default ();idwc_motivo  = dw_1.of_InsertRow_DDDW("cd_motivo" )			

idwc_motivo.SetItem(1, "cd_motivo_ajuste", 0		  )
idwc_motivo.SetItem(1, "de_motivo_ajuste", "TODOS")

dw_1.Object.cd_motivo[1] = 0

end subroutine

public subroutine wf_localiza_filial ();String lvs_Filial
Long lvl_nulo

SetNull(lvl_Nulo)

lvs_Filial = dw_1.GetText()

ivo_Filial.Of_localiza_Filial(lvs_Filial)

If ivo_Filial.Localizada Then
	
	dw_1.Object.cd_filial[1] = ivo_filial.cd_filial
	dw_1.Object.nm_filial[1] = ivo_filial.nm_fantasia
	
End If
end subroutine

public subroutine wf_localiza_produto ();String lvs_Produto

dw_1.AcceptText()

lvs_Produto = dw_1.GetText()

ivo_Produto.of_Localiza_Produto(lvs_Produto)

If ivo_Produto.Localizado Then
	dw_1.Object.Cd_Produto[1] = ivo_Produto.Cd_Produto
	dw_1.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
	ivm_Menu.mf_Recuperar(True)
End If

end subroutine

public function integer of_lastpos (string as_source, string as_target, long al_start);Long	ll_Cnt, ll_Pos

//Check for Null Parameters.
IF IsNull(as_source) or IsNull(as_target) or IsNull(al_start) Then
	SetNull(ll_Cnt)
	Return ll_Cnt
End If

//Check for an empty string
If LenA(as_Source) = 0 Then
	Return 0
End If

// Check for the starting position, 0 means start at the end.
If al_start=0 Then  
	al_start=LenA(as_Source)
End If

//Perform find
For ll_Cnt = al_start to 1 Step -1
	ll_Pos = PosA(as_Source, as_Target, ll_Cnt)
	If ll_Pos = ll_Cnt Then 
		//String was found
		Return ll_Cnt
	End If
Next

//String was not found
Return 0
end function

public function integer wf_le_dados_planilha ();Any la_Dado

Long ll_Linha
Long ll_Linhas
Long ll_Sucesso = 1
Long ll_Produto
Long ll_achou1
Long ll_Len

String ls_Arquivo

is_Produtos = ""

Try	
	dw_1.AcceptText()
	dw_2.AcceptText()

	dc_uo_excel lo_Excel
	lo_Excel = Create dc_uo_excel
		
	ls_Arquivo = dw_1.Object.De_Arquivo[1]
	
	Open(w_Aguarde)
	w_Aguarde.Title = "Importando planilha..."
	
	SetRedraw(False)
	
	// Refer$$HEX1$$ea00$$ENDHEX$$ncia o arquivo 
	If (lo_Excel.uo_Referencia_Objeto_Excel(ls_Arquivo) ) Then
		
		ll_Linhas = lo_Excel.uo_Verifica_Tamanho_Arquivo("A")
		
		If ll_Linhas > 0 Then
			w_Aguarde.uo_Progress.of_SetMax(ll_Linhas)
						
			For ll_Linha = 1 To ll_Linhas
				w_Aguarde.uo_Progress.of_SetProgress(ll_Linha)
				
				//Dados do Arquivo
				ll_Produto = lo_Excel.uo_Lendo_Dados(ll_Linha, "A")
				
				// Valida Produto
				If IsNull(ll_Produto) Or Not IsNumber(String(ll_Produto)) Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produto n$$HEX1$$e300$$ENDHEX$$o encontrado. Verifique a planilha.",Exclamation!)
					ll_Sucesso = 0
					Exit
				End If				
				
				 //Valida achou Produto
				ll_achou1 = 0
				Select 1 	Into :ll_achou1
				From produto_geral
				Where cd_produto =:ll_Produto
				Using SqlCa;
				
				If SqlCa.SqlCode <> 0 then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produto n$$HEX1$$e300$$ENDHEX$$o encontrado. Verifique a planilha.",Exclamation!)
					ll_Sucesso = 0
					Exit
				End if					
				
				is_Produtos += String(ll_Produto) + ","
				//w_Aguarde.uo_Progress.of_SetProgress(ll_Linhas)
				
			Next			
		Else
			ll_Sucesso = -1
		End If
		
		If is_Produtos <> "" Then
			ll_Len = LenA(is_Produtos)
			is_Produtos = MidA(is_Produtos, 1, ll_Len -1)
		End If		
		//dw_2.Filter( )
	End If
	
Finally
	Close(w_Aguarde)
	SetRedraw(True)
	If IsValid(lo_Excel) Then Destroy(lo_Excel)
	dw_2.Sort()		
	Return ll_Sucesso
End Try

Return ll_Sucesso
end function

on w_ge037_relatorio_ajuste_estoque.create
int iCurrent
call super::create
this.dw_4=create dw_4
this.cb_seguro=create cb_seguro
this.cb_importar=create cb_importar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_4
this.Control[iCurrent+2]=this.cb_seguro
this.Control[iCurrent+3]=this.cb_importar
end on

on w_ge037_relatorio_ajuste_estoque.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_4)
destroy(this.cb_seguro)
destroy(this.cb_importar)
end on

event close;call super::close;Destroy(ivo_produto)
Destroy(ivo_filial)
Destroy(ivo_fornecedor)
end event

event open;call super::open;This.ivm_Menu.ivb_Permite_Imprimir = True

ivo_produto = Create UO_PRODUTO
ivo_filial  = Create UO_FILIAL
ivo_fornecedor = Create uo_fornecedor
ivo_Produto.ivb_nao_liberado_filial = False

cb_Seguro.Visible = False

dw_4.Event ue_AddRow()

end event

event ue_postopen;call super::ue_postopen;dw_1.Object.dt_periodo_de [1] = RelativeDate(Date(gvo_Parametro.of_Dh_Movimentacao()), -30)
dw_1.Object.dt_periodo_ate[1] = Date(gvo_Parametro.of_Dh_Movimentacao())

This.ivm_Menu.mf_Recuperar(True)

Long lvl_Filial

lvl_Filial = gvo_Parametro.Of_Filial()

Wf_Insere_motivo_Default()

If lvl_Filial <> gvo_parametro.Of_filial_matriz() Then
	dw_1.Object.cd_filial[1]       = lvl_Filial
	dw_1.Object.nm_filial[1]       = gvo_parametro.nm_fantasia_filial
	dw_1.Object.nm_filial.Protect  = 1		
		
End If

ivo_filial.cd_filial   = lvl_Filial
ivo_filial.nm_fantasia = gvo_parametro.nm_fantasia_filial
	


end event

event ue_preprint;call super::ue_preprint;String lvs_tipo

lvs_tipo = dw_4.Object.tipo[1] 

Choose Case lvs_tipo 
	Case "1"
	
		dw_3.Object.periodo_t.Text = STRING(dw_1.Object.dt_periodo_de[1], "DD/MM/YYYY") + " at$$HEX1$$e900$$ENDHEX$$ " + STRING(dw_1.Object.dt_periodo_ate[1], "DD/MM/YYYY") 
	
	Case "2"
	
		dw_3.Object.periodo_t.Text = STRING(dw_1.Object.dt_periodo_de [1], "DD/MM/YYYY") + " at$$HEX1$$e900$$ENDHEX$$ " + STRING(dw_1.Object.dt_periodo_ate[1], "DD/MM/YYYY")
	
	Case "3"
	
		dw_3.Object.periodo_t.Text = STRING(dw_1.Object.dt_periodo_de [1], "DD/MM/YYYY") + " at$$HEX1$$e900$$ENDHEX$$ " + STRING(dw_1.Object.dt_periodo_ate[1], "DD/MM/YYYY")
		
End Choose

Return AncestorReturnValue
end event

event ue_preopen;call super::ue_preopen;MaxWidth	= 3650
MAxHeight	= 1800
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge037_relatorio_ajuste_estoque
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge037_relatorio_ajuste_estoque
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge037_relatorio_ajuste_estoque
integer x = 18
integer y = 472
integer width = 3506
integer height = 1324
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge037_relatorio_ajuste_estoque
integer x = 18
integer y = 20
integer width = 2629
integer height = 432
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge037_relatorio_ajuste_estoque
integer x = 55
integer width = 2574
integer height = 336
integer taborder = 40
string dataobject = "dw_ge037_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;Long ll_nulo

Long lvl_Lojas

SetNull(ll_nulo)

If dwo.Name = "de_produto" Then
	
	If Data <> ivo_Produto.ivs_Descricao_Apresentacao_Venda Then
		
		If Data = "" Then
			This.Object.cd_produto[1] = ll_nulo
			ivo_Produto.ivs_Descricao_Apresentacao_Venda = ''
		Else
			Return 1
		End If
		
	End If
	
End If

If dwo.Name = "nm_filial" Then
	
	If Data <> ivo_filial.nm_fantasia Then
		
		If Data = "" Then
			This.Object.cd_filial[1] = ll_nulo
			ivo_Filial.nm_fantasia   = ''
			Return 1
		Else
			Return 1
		End If
		
	End If
	
End If

If dwo.Name = "dt_periodo_de" Then
	If IsNull(Data) Or IsNull(This.Object.dt_periodo_ate[1]) Then
		ivm_Menu.mf_Recuperar(False)
	Else
		ivm_Menu.mf_Recuperar(True)
	End If
End If

If dwo.Name = "dt_periodo_ate" Then
	If ISNull(Data) Or IsNull(This.Object.dt_periodo_de[1]) Then
		ivm_Menu.mf_Recuperar(False)
	Else
		ivm_Menu.mf_Recuperar(True)
	End If
End If

If dwo.Name = "nm_fornecedor" Then
	If Not IsNull(Data) and Trim(Data) <> "" Then
		If Data <> ivo_fornecedor.nm_fantasia Then
			Return 1
		End If
	Else
		ivo_fornecedor.of_Inicializa()
		
		This.Object.cd_fornecedor		[1] = ivo_fornecedor.cd_fornecedor
		This.Object.nm_fornecedor		[1] = ivo_fornecedor.nm_fantasia
	End If
End If

Choose Case dwo.Name
Case "id_filiais"
		
		If Data = 'C' Then
		
			ivs_filiais = ivs_nulo 
			
			uo_ge216_filiais uo_filiais
			
			uo_Filiais = Create uo_ge216_filiais
			
			OpenWithParm(w_ge216_selecao_filiais, uo_Filiais)
			
			lvl_Lojas = Message.DoubleParm
			
			If lvl_Lojas > 0 Then
				ivs_filiais = uo_Filiais.ivs_filiais
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma filial foi selecionada.")
			End If
			
			Destroy(uo_Filiais)
			
		End If

End Choose

dw_2.Event ue_Reset()
end event

event dw_1::ue_key;call super::ue_key;String lvs_Coluna

If Key = KeyEnter! Then
	
	lvs_Coluna = This.GetColumnName()
	
	If lvs_Coluna = "de_produto" Then
		wf_Localiza_Produto()
		
		is_Produtos = ""
	End If
	
	If lvs_Coluna = "nm_filial" Then
		wf_localiza_filial()
	End If
	
	If lvs_Coluna = "nm_fornecedor" Then
		ivo_Fornecedor.id_selecao_cadastro = "S"
			
		ivo_Fornecedor.of_Localiza_Fornecedor(This.GetText())
						
		If ivo_Fornecedor.Localizado Then
			This.Object.cd_fornecedor [1] = ivo_Fornecedor.Cd_Fornecedor
			This.Object.nm_fornecedor[1] = ivo_Fornecedor.Nm_Razao_Social
		End If
		
		is_Produtos = ""
	End If
End If
end event

event dw_1::getfocus;call super::getfocus;This.ivm_Menu.mf_SalvarComo(False)

end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_fornecedor) Then
	This.Object.Nm_Fornecedor[1] = ivo_fornecedor.Nm_Razao_Social
End If
end event

event dw_1::editchanged;call super::editchanged;dw_2.Event ue_Reset()
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge037_relatorio_ajuste_estoque
integer x = 55
integer y = 536
integer width = 3433
integer height = 1228
integer taborder = 50
string dataobject = "dw_ge037_lista3"
boolean hscrollbar = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;Long lvl_Linhas, &
     lvl_pos
	  
String lvs_dataini, &
       lvs_datafim, &
		 lvs_where, &
		 lvs_tipo, &
		 lvs_Filial

dw_1.AcceptText()

lvs_dataini = String(dw_1.Object.dt_periodo_de [1], "YYYYMMDD")
lvs_datafim = String(dw_1.Object.dt_periodo_ate[1], "YYYYMMDD")

lvs_tipo = dw_4.Object.tipo[1] 

lvs_Filial						= dw_1.Object.id_filiais[1]

If  lvs_Filial <> 'T' and ivs_Filiais = "" and  lvs_Filial <> 'E' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ filial selecionada.", StopSign!)
	dw_1.Event ue_Pos(1, "id_filiais")
	Return -1
End If

Choose Case lvs_tipo 
		
	Case "1" 	
		If Not dw_2.of_ChangeDataObject("dw_ge037_lista1") Then Return -1	
		If Not dw_3.of_ChangeDataObject("dw_ge037_relatorio1") Then Return -1
		
	Case "2"	
		If Not dw_2.of_ChangeDataObject("dw_ge037_lista2") Then Return -1	
		If Not dw_3.of_ChangeDataObject("dw_ge037_relatorio2") Then Return -1
		
	Case "3"	
		If Not dw_2.of_ChangeDataObject("dw_ge037_lista3") Then Return -1	
		If Not dw_3.of_ChangeDataObject("dw_ge037_relatorio3") Then Return -1
End Choose

This.of_AppendWhere("ajuste_estoque.dh_movimentacao_caixa >= '" + lvs_dataini + "'")
This.of_AppendWhere("ajuste_estoque.dh_movimentacao_caixa <= '" + lvs_datafim + "'")

If Not IsNull(dw_1.Object.cd_produto[1]) Then
	This.of_AppendWhere("ajuste_estoque.cd_produto = " + String(dw_1.Object.cd_produto[1]))
End If

If Not IsNull( is_Produtos ) And is_Produtos <> "" Then
	This.of_AppendWhere(" ajuste_estoque.cd_produto in (" + is_Produtos + ")")
End If

If lvs_Filial = 'C' Then
	If Not IsNull(ivs_Filiais) Then
		This.of_AppendWhere("ajuste_estoque.cd_filial_ajuste in (" + ivs_Filiais + ")")
	End If
ElseIf lvs_Filial = 'E' Then
	This.of_AppendWhere("ajuste_estoque.cd_filial_ajuste = 534")	
End If

If Not IsNull(dw_1.Object.cd_motivo[1]) Then
	If dw_1.Object.cd_motivo[1] <> 0 Then
		This.of_AppendWhere("ajuste_estoque.cd_motivo_ajuste = " + String(dw_1.Object.cd_motivo[1]))
	End If
End If

If Not IsNull(dw_1.Object.cd_fornecedor[1]) Then
	This.of_AppendWhere("fornecedor.cd_fornecedor = '" + String(dw_1.Object.cd_fornecedor[1]) + "'")
End If

This.ShareData(dw_3)

Return AncestorReturnValue
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;This.of_SetRowSelection()
This.ivm_Menu.mf_SalvarComo(pl_Linhas > 0)

Return AncestorReturnValue

end event

event dw_2::getfocus;call super::getfocus;This.ivm_Menu.mf_SalvarComo(This.RowCount() > 0)
end event

event dw_2::ue_saveas;//OverRide

String 	lvs_Arquivo, &
       		lvs_Diretorio, &
		lvs_Aux, &
		lvs_Extensao

Integer lvi_Retorno, &
		lvi_Pos
		
This.SetFocus()		

// Verifica o nome do arquivo
If Trim(This.ivs_Arquivo_SalvarComo) = "" or IsNull(This.ivs_Arquivo_SalvarComo) Then
	lvi_Retorno = GetFileSaveName("Selecione o caminho do arquivo", &
											lvs_Diretorio, &
											lvs_Arquivo, &
											"XLS; XLSX", "Arquivos do Excel (*.XLS; *.XLSX),*.XLS; *.XLSX, Arquivo CSV (*.CSV), *.CSV")
	
	If lvi_Retorno = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Ocorreu um erro durante a chamada da janela de sele$$HEX2$$e700e300$$ENDHEX$$o do arquivo.", StopSign!)
		Return 
	Else
		If lvi_Retorno = 0 Then Return
	End If
Else
	lvs_Diretorio = This.ivs_Arquivo_SalvarComo
End If

// Verifica se j$$HEX1$$e100$$ENDHEX$$ existe o arquivo
If FileExists(lvs_Diretorio) Then
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Deseja substituir o arquivo '" + lvs_Diretorio + "' existente ?", Question!, YesNo!, 1) =  1 Then 
		If Not FileDelete(lvs_Diretorio) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Erro na exclus$$HEX1$$e300$$ENDHEX$$o do arquivo '" + lvs_Diretorio + "'.", StopSign!)
			Return
		End If
	Else
		Return 
   End If   
End If

lvi_Pos = of_LastPos(lvs_Diretorio, ".", LenA(lvs_Diretorio))

If lvi_Pos > 0 Then
	lvs_Aux 		= LeftA(lvs_Diretorio, (lvi_Pos - 1))
	lvs_Extensao 	= Upper(RightA(lvs_Diretorio, (LenA(lvs_Diretorio) - lvi_Pos)))
Else
	lvs_Aux 		= lvs_Diretorio
	lvs_Extensao 	= ""
End if

// Salva o arquivo
Choose Case lvs_Extensao
	Case "XLSX"
		lvi_Retorno = This.SaveAs(lvs_Diretorio, XLSX!, True)
	Case "XLS"
		If (This.RowCount() > 65535) Then
			lvs_Diretorio 	= lvs_Diretorio+"X"		
			lvi_Retorno 	= This.SaveAs(lvs_Diretorio, XLSX!, True)
		Else
			lvi_Retorno = This.SaveAs(lvs_Diretorio, Excel!, True)
		End If
	Case "CSV"
		lvi_Retorno = This.SaveAsFormattedText(lvs_Diretorio, EncodingANSI!, ";")
End Choose

If lvi_Retorno <> 1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Erro ao salvar o arquivo '" + lvs_Diretorio + "'.", StopSign!)	
	Return 
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Arquivo '" + lvs_Diretorio + "' salvo com sucesso.", Information!)
End If
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge037_relatorio_ajuste_estoque
integer x = 987
integer y = 640
integer taborder = 60
string dataobject = "dw_ge037_relatorio3"
end type

type dw_4 from dc_uo_dw_base within w_ge037_relatorio_ajuste_estoque
integer x = 2651
integer y = 20
integer width = 882
integer height = 320
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_ge037_tipo"
end type

type cb_seguro from commandbutton within w_ge037_relatorio_ajuste_estoque
integer x = 2798
integer y = 376
integer width = 562
integer height = 236
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Arquivo Seguro"
end type

event clicked;Long lvl_Total, &
     lvl_Contador, &
	  lvl_Produto, &
	  lvl_Qtde
	  
String lvs_Descricao, &
       lvs_Arquivo

Decimal{2} lvdc_Preco_Unitario, &
           lvdc_Preco_Total

dc_uo_ds_Base lvds_1
lvds_1 = Create dc_uo_ds_Base
lvds_1.of_ChangeDataObject("dw_ge037_relatorio_seguro")

dc_uo_ds_Base lvds_2
lvds_2 = Create dc_uo_ds_Base
lvds_2.of_ChangeDataObject("dw_ge037_arquivo_seguro")

SetPointer(HourGlass!)
Open(w_Aguarde)
w_Aguarde.Title = "Gerando Arquivo para Seguradora..."

lvl_Total = lvds_1.Retrieve()

If lvl_Total > 0 Then
	w_Aguarde.uo_Progress.of_SetMax(lvl_Total)
	
	For lvl_Contador = 1 To lvl_Total
		lvl_Produto         = lvds_1.Object.Cd_Produto      [lvl_Contador]
		lvs_Descricao       = lvds_1.Object.Desc_Produto    [lvl_Contador]
		lvl_Qtde            = lvds_1.Object.c_Qt_Estoque    [lvl_Contador]
		lvdc_Preco_Unitario = lvds_1.Object.Ajuste_Estoque_Vl_Custo_Unitario[lvl_Contador]
		lvdc_Preco_Total    = lvds_1.Object.Vl_Total_Produto[lvl_Contador]
		
		lvds_2.InsertRow(0)
		
		lvds_2.Object.Cd_Produto [lvl_Contador] = lvl_Produto
		lvds_2.Object.De_Produto [lvl_Contador] = lvs_Descricao
		lvds_2.Object.Qt_Perdida [lvl_Contador] = lvl_Qtde
		lvds_2.Object.Vl_Unitario[lvl_Contador] = lvdc_Preco_Unitario
		lvds_2.Object.Vl_Total   [lvl_Contador] = lvdc_Preco_Total
		
		w_Aguarde.uo_Progress.of_SetProgress(lvl_Contador)
	Next
	
	lvs_Arquivo = "c:\sistemas\cr\arquivos\seguro_criciuma.txt"
	
	If lvds_2.SaveAs(lvs_Arquivo, Text!, True) = 1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Arquivo '" + lvs_Arquivo + "' gerado com sucesso.", Information!)
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao salvar o arquivo '" + lvs_Arquivo + "'.", StopSign!)
	End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produtos n$$HEX1$$e300$$ENDHEX$$o localizados.", StopSign!)
End If              
				  
Destroy(lvds_1)
Destroy(lvds_2)

Close(w_Aguarde)
SetPointer(Arrow!)
end event

type cb_importar from commandbutton within w_ge037_relatorio_ajuste_estoque
integer x = 2039
integer y = 312
integer width = 539
integer height = 104
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Importar produtos"
end type

event clicked;Integer li_Retorno
Integer ll_ret_excel

String ls_Arquivo
String ls_Nome
String ls_Nulo

dw_2.Event ue_Reset()

If wf_valida_salva() < 0 Then
	Return -1
End If

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Os dados devem estar da seguinte forma:" + &
					"~rColuna A = C$$HEX1$$f300$$ENDHEX$$digo do Produto")							

li_Retorno = GetFileOpenName("Seleciona o arquivo", + ls_Arquivo, ls_Nome, "XLSX", "Excel 2007 (*.XLSX),*.XLSX, Excel (*.XLS), *.XLS")

If li_Retorno = 1 Then 
	dw_1.Object.De_Arquivo[1] = Upper(ls_Arquivo)
	
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a importa$$HEX2$$e700e300$$ENDHEX$$o?", Question!, YesNo!, 2) = 1 Then
	
		ll_ret_excel = wf_Le_Dados_Planilha() 
		Choose Case ll_ret_excel
			Case 1
				//A planilha foi importada com sucesso
				SqlCa.of_commit()
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Planilha importada com Sucesso!")
			Case 0
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Revise a planilha.", Exclamation!)
			Case -1
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na planilha! Verificar as informa$$HEX2$$e700f500$$ENDHEX$$es.", Exclamation!)
				dw_2.Reset()
		End Choose
	End If
Else
	SetNull(ls_Nulo)
End If

Return 1
end event

