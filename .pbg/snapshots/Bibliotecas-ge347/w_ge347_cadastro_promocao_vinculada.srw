HA$PBExportHeader$w_ge347_cadastro_promocao_vinculada.srw
forward
global type w_ge347_cadastro_promocao_vinculada from dc_w_sheet
end type
type gb_6 from groupbox within w_ge347_cadastro_promocao_vinculada
end type
type cb_selecao_filiais from commandbutton within w_ge347_cadastro_promocao_vinculada
end type
type gb_2 from groupbox within w_ge347_cadastro_promocao_vinculada
end type
type cb_selecao_filial from commandbutton within w_ge347_cadastro_promocao_vinculada
end type
type dw_4 from dc_uo_dw_base within w_ge347_cadastro_promocao_vinculada
end type
type dw_2 from dc_uo_dw_base within w_ge347_cadastro_promocao_vinculada
end type
type dw_7 from dc_uo_dw_base within w_ge347_cadastro_promocao_vinculada
end type
type dw_3 from dc_uo_dw_base within w_ge347_cadastro_promocao_vinculada
end type
type dw_8 from dc_uo_dw_base within w_ge347_cadastro_promocao_vinculada
end type
type dw_9 from dc_uo_dw_base within w_ge347_cadastro_promocao_vinculada
end type
type gb_3 from groupbox within w_ge347_cadastro_promocao_vinculada
end type
type dw_1 from dc_uo_dw_base within w_ge347_cadastro_promocao_vinculada
end type
type dw_5 from dc_uo_dw_base within w_ge347_cadastro_promocao_vinculada
end type
type cb_1 from commandbutton within w_ge347_cadastro_promocao_vinculada
end type
type cb_2 from commandbutton within w_ge347_cadastro_promocao_vinculada
end type
type cb_3 from commandbutton within w_ge347_cadastro_promocao_vinculada
end type
type st_1 from statictext within w_ge347_cadastro_promocao_vinculada
end type
type st_2 from statictext within w_ge347_cadastro_promocao_vinculada
end type
type st_3 from statictext within w_ge347_cadastro_promocao_vinculada
end type
type st_4 from statictext within w_ge347_cadastro_promocao_vinculada
end type
type st_5 from statictext within w_ge347_cadastro_promocao_vinculada
end type
type st_6 from statictext within w_ge347_cadastro_promocao_vinculada
end type
type cb_4 from commandbutton within w_ge347_cadastro_promocao_vinculada
end type
type gb_4 from groupbox within w_ge347_cadastro_promocao_vinculada
end type
type gb_1 from groupbox within w_ge347_cadastro_promocao_vinculada
end type
end forward

global type w_ge347_cadastro_promocao_vinculada from dc_w_sheet
string accessiblename = "Cadastro de Promo$$HEX2$$e700f500$$ENDHEX$$es (ge347)"
integer width = 4841
integer height = 2360
string title = "GE347 - Cadastro de Promo$$HEX2$$e700f500$$ENDHEX$$es Vinculadas"
boolean resizable = false
long backcolor = 80269524
event ue_simula_precos ( )
event ue_copia_promocao ( )
event ue_salva_produtos_excel ( )
event ue_salva_importa_produtos_xls ( )
event ue_importa_produtos_excel ( )
event ue_exporta_saldo_planilha ( )
event ue_salva_saldo_produto_excel ( )
event ue_seleciona_filial_planilha ( )
gb_6 gb_6
cb_selecao_filiais cb_selecao_filiais
gb_2 gb_2
cb_selecao_filial cb_selecao_filial
dw_4 dw_4
dw_2 dw_2
dw_7 dw_7
dw_3 dw_3
dw_8 dw_8
dw_9 dw_9
gb_3 gb_3
dw_1 dw_1
dw_5 dw_5
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
st_1 st_1
st_2 st_2
st_3 st_3
st_4 st_4
st_5 st_5
st_6 st_6
cb_4 cb_4
gb_4 gb_4
gb_1 gb_1
end type
global w_ge347_cadastro_promocao_vinculada w_ge347_cadastro_promocao_vinculada

type variables
uo_promocao ivo_promocao

uo_produto ivo_produto

dc_uo_ds_base ids

Boolean ivb_Check

Long ivl_linhas
Long il_Ultimo_Vinc = 0

String ivs_Responsavel
String ivs_promocao_sap
end variables

forward prototypes
public function long wf_proxima_promocao ()
public subroutine wf_localiza_produto ()
public subroutine wf_atualiza_produtos_incluidos_alterados (dc_uo_ds_base ads, ref long al_alteracao)
public subroutine wf_atualiza_produtos_excluidos (dc_uo_ds_base ads, ref long al_alteracao)
public function boolean wf_copia_produto (long al_promocao, ref long al_alteracao)
public function boolean wf_copia_filial (long al_promocao, ref long al_alteracao)
public function boolean wf_salva_pendente ()
public function boolean wf_inclui_promocao_sos_produto (long al_produto, decimal adc_desconto, decimal adc_desc_clube)
public function boolean wf_valida_desconto (long pl_row, string ps_dado, ref decimal rdc_desconto)
public function boolean wf_verifica_usuario_alteracao (ref boolean ab_permite_alterar)
public function boolean wf_existe_filiais_desmarcadas ()
public function boolean wf_grava_rede_liberada ()
public function boolean wf_verifica_rede_liberada ()
public function boolean wf_verifica_inclusao_estoque_minimo ()
public function boolean wf_valida_fronteira ()
public function boolean wf_verifica_produto_selecionado ()
public subroutine wf_seleciona_filial_planilha (string as_arquivo)
public function boolean wf_deleta_prd_vinculado (long al_promocao, long al_vinculo)
public subroutine wf_carrega_legenda (string as_tipo)
public function boolean wf_valor_inicial (long al_promocao, long al_vinculo, ref string as_vinculo, ref long al_qtd)
public function boolean wf_proximo_vinculo (long al_promocao)
public subroutine wf_desabilita_controles (string as_tipo)
end prototypes

event ue_simula_precos();Boolean lvb_Continua = True

Long lvl_Alteracao = 0,&
     lvl_Promocao_SOS

String lvs_Retorno
 
dw_1.AcceptText()

lvl_Promocao_SOS = dw_1.Object.cd_promocao_sos[1]

If Not wf_Salva_Pendente() Then
	// Abre a janela de simula$$HEX2$$e700e300$$ENDHEX$$o de pre$$HEX1$$e700$$ENDHEX$$os
	If IsNull(lvl_Promocao_SOS) Or lvl_Promocao_SOS = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma promo$$HEX2$$e700e300$$ENDHEX$$o foi selecionada.")
		Return
	End If
		
	OpenWithParm(w_ge380_Simulacao_Preco, lvl_Promocao_SOS)
	
	lvs_Retorno = Message.StringParm

	// Verifica o retorno da janela
	//If lvs_Retorno = "S" Then
	dw_2.Event ue_Recuperar()
	//End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existem informa$$HEX2$$e700f500$$ENDHEX$$es que ainda n$$HEX1$$e300$$ENDHEX$$o foram salvas.~r~rConfirme antes de continuar")
End If
end event

event ue_copia_promocao();String lvs_Retorno, &
       lvs_Produto, &
		 lvs_Filial

Long lvl_Promocao, &
     lvl_Alteracao

Open(w_ge380_Copia_Promocao)

lvs_Retorno = Message.StringParm

If LeftA(lvs_Retorno, 1) = "S" Then
	lvl_Promocao = Long(MidA(lvs_Retorno, 2, 5))
	lvs_Produto  = MidA(lvs_Retorno, 7, 1)
	lvs_Filial   = MidA(lvs_Retorno, 8, 1)
	
	If lvs_Produto = "S" Then
		wf_Copia_Produto(lvl_Promocao, ref lvl_Alteracao)
	End If
	
	If lvs_Filial = "S" Then
		wf_Copia_Filial(lvl_Promocao, ref lvl_Alteracao)
	End If

	If lvl_Alteracao > 0 Then
		ivb_Valida_Salva = True		
		
		ivm_Menu.mf_Confirmar(True)
		ivm_Menu.mf_Cancelar(True)		
	End If	
End If
end event

event ue_salva_produtos_excel();Long lvl_Linha

If dw_2.RowCount() = 0 Then Return

dc_uo_ds_Base lvds
lvds = Create dc_uo_ds_Base

If Not lvds.of_ChangeDataObject("dw_ge380_salva_produtos_excel") Then
	Destroy(lvds)
	Return
End If

SetPointer(HourGlass!)

Open(w_Aguarde)
w_Aguarde.Title = "Preparando Salva em Excel..."

w_Aguarde.uo_Progress.of_SetMax(dw_2.RowCount())

For lvl_Linha = 1 To dw_2.RowCount()
	lvds.InsertRow(0)
	
	lvds.Object.Cd_Produto 			[lvl_Linha] = dw_2.Object.Cd_Produto 			[lvl_Linha]
	lvds.Object.De_Produto 			[lvl_Linha] = dw_2.Object.De_Produto 			[lvl_Linha]
	lvds.Object.Pc_Desconto			[lvl_Linha] = dw_2.Object.Pc_Desconto			[lvl_Linha]
	lvds.Object.pc_desconto_clube	[lvl_Linha] = dw_2.Object.pc_desconto_clube	[lvl_Linha]
		
	w_Aguarde.uo_Progress.of_SetProgress(lvl_Linha)
Next

Close(w_Aguarde)

lvds.of_SaveAs("")

Destroy(lvds)

SetPointer(Arrow!)
end event

event ue_importa_produtos_excel();String lvs_Nome_Arquivo, &
		 lvs_Arquivo,      &
		 lvs_Dado,         &
		 lvs_Msg,          &
		 lvs_Nulo
		 
Integer lvi_Arquivo

Decimal lvdc_Desconto
Decimal lvdc_Desconto_Clube
Decimal lvdc_Retorno

Long lvl_Linhas,   & 
	  lvl_Linha,    &
	  lvl_Produto,  &
	  lvl_Promocao
	  
Integer lvi_Retorno, &
        lvi_Nulo
		  
dw_1.AcceptText()

lvl_Promocao = dw_1.Object.cd_promocao_sos[1]

If IsNull(lvl_Promocao) Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione a promo$$HEX2$$e700e300$$ENDHEX$$o.")
	dw_1.Event ue_Pos(1, "de_localizacao")
	Return
End If

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Para importar a planilha de produtos os dados devem estar da seguinte forma:~r~r" + &
                     	"Coluna A = Produto.~r" + &
					"Coluna B = Desconto. ~r" + &
					"Coluna C = Desconto do Clube")
			
lvi_Arquivo = GetFileOpenName("Seleciona o arquivo", lvs_Arquivo, lvs_Nome_Arquivo, "XLSX", "Excel 2007 (*.XLSX),*.XLSX, Excel (*.XLS), *.XLS")

If lvi_Arquivo <> 1 Then Return

ivl_Linhas = 0

lvs_Msg = "Importar os produtos com os descontos do arquivo selecionado ?"
		  
If Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvs_Msg, Question!, OkCancel!, 2) = 2 Then Return

dw_2.SetRedRaw(False)

dc_uo_excel lvo_Excel

lvo_Excel = Create dc_uo_excel

Open(w_Aguarde)

// Refer$$HEX1$$ea00$$ENDHEX$$ncia o arquivo 
If ( lvo_Excel.uo_Referencia_Objeto_Excel(lvs_Arquivo) ) Then
	// Coluna de Refer$$HEX1$$ea00$$ENDHEX$$ncia
	lvl_Linhas = lvo_Excel.uo_Verifica_Tamanho_Arquivo("A") 
	
	If lvl_Linhas > 0 Then
		w_Aguarde.uo_Progress.of_SetMax(lvl_Linhas)
	
		For lvl_Linha = 1 To lvl_Linhas
			
			lvdc_Desconto 			= 0.00
			lvdc_Desconto_clube 	= 0.00
			
			lvs_Dado = String(lvo_Excel.uo_Lendo_Dados(lvl_Linha, "A"))
	
			If IsNumber(lvs_Dado) Then
				lvl_Produto = Long(lvs_Dado)
	
				//Desconto
				lvs_Dado = String(lvo_Excel.uo_Lendo_Dados(lvl_Linha, "B"))
				
				If Not wf_valida_desconto( lvl_Linha, lvs_Dado, Ref lvdc_Desconto) Then Exit
						
				//Desconto Clube
				lvs_Dado = String(lvo_Excel.uo_Lendo_Dados(lvl_Linha, "C"))
				
				If Not wf_valida_desconto( lvl_Linha, lvs_Dado, Ref lvdc_Desconto_clube) Then Exit
				
				//Inclui Promocao_SOS_produto
				If Not wf_Inclui_Promocao_SOS_Produto(lvl_Produto, lvdc_Desconto, lvdc_Desconto_Clube) Then
					Exit
				End If
				
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "C$$HEX1$$f300$$ENDHEX$$digo do produto inv$$HEX1$$e100$$ENDHEX$$lido.~rLinha: " + String(lvl_Linha) + "~rValor: " + lvs_Dado)
				Exit
			End If //Produto
			
			w_Aguarde.uo_Progress.of_SetProgress(lvl_Linha)
			
		Next
	
		If ivl_Linhas > 0 Then
			ivm_Menu.mf_Confirmar(True)
			ivm_Menu.mf_Cancelar(True)
			ivb_Valida_Salva = True
		End If

	End If //Linha

End If //Excel

Close(w_Aguarde)

dw_2.SetRedRaw(True)

Destroy(lvo_Excel)

end event

event ue_exporta_saldo_planilha();String lvs_Path,&
		lvs_Arquivo,&
		lvs_Promocao

Long	lvl_Promocao

Integer lvi_Retorno

SetPointer(HourGlass!)

//Retrieve
dw_7.Event ue_Recuperar()

SetPointer(Arrow!)

If dw_7.RowCount() > 0 Then
	
	If Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a exporta$$HEX2$$e700e300$$ENDHEX$$o (XLS) do saldo produtos da promo$$HEX2$$e700e300$$ENDHEX$$o ?", Question!, YesNo!, 2) = 2 Then
		Return
	End If
				
	lvl_Promocao = dw_1.Object.cd_promocao_sos [1]
	
	//Teste
	lvs_Path = 'C:\Sistemas\CO\Arquivos\Saldo_Promocao_' + String(lvl_Promocao) + '.txt'
	
	//Salva em Excel
	If dw_7.SaveAs(lvs_Path, text!, True) = 1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O arquivo foi salvo com sucesso '" + lvs_Path + "'.")
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gerar o arquivo '" + lvs_Path + "'.", StopSign!)
	End If

Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum produto foi localizado.")
End If
end event

event ue_salva_saldo_produto_excel();String lvs_Path,&
		lvs_Arquivo,&
		lvs_Promocao

Long	lvl_Promocao

Integer lvi_Retorno

SetPointer(HourGlass!)

//Retrieve
dw_7.Event ue_Recuperar()

SetPointer(Arrow!)

If dw_7.RowCount() > 0 Then
	
	If Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a exporta$$HEX2$$e700e300$$ENDHEX$$o (XLS) do saldo produtos da promo$$HEX2$$e700e300$$ENDHEX$$o ?", Question!, YesNo!, 2) = 2 Then
		Return
	End If
				
	lvl_Promocao = dw_1.Object.cd_promocao_sos [1]
	
	//lvs_Path = 'C:\Sistemas\CO\Arquivos\Saldo_Promocao_' + String(lvl_Promocao) + '.txt'
	lvs_Path = 'C:\Sistemas\' + gvo_Aplicacao.ivo_Seguranca.Cd_Sistema + '\Arquivos\Saldo_Promocao_' + String(lvl_Promocao) + '.txt'
	
	//Salva em Excel
	If dw_7.SaveAs(lvs_Path, text!, True) = 1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O arquivo foi salvo com sucesso '" + lvs_Path + "'.")
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gerar o arquivo '" + lvs_Path + "'.", StopSign!)
	End If

Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum produto foi localizado.")
End If
end event

event ue_seleciona_filial_planilha();Integer li_Retorno

String ls_Arquivo
String ls_Nome
String ls_Nulo

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Para importar a planilha de filiais os dados devem estar da seguinte forma: (SEM CABE$$HEX1$$c700$$ENDHEX$$ALHO)~r" + &
				"~rColuna A = C$$HEX1$$f300$$ENDHEX$$digo da Filial" )
				
li_Retorno = GetFileOpenName("Seleciona o arquivo", + ls_Arquivo, ls_Nome, "XLSX", "Excel 2007 (*.XLSX),*.XLSX, Excel (*.XLS), *.XLS")

If li_Retorno = 1 Then wf_Seleciona_Filial_Planilha(Upper(ls_Arquivo))

end event

public function long wf_proxima_promocao ();Long lvl_Promocao

Select max(cd_promocao_sos) Into :lvl_Promocao
From promocao_sos
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If Not IsNull(lvl_Promocao) Then
			Return lvl_Promocao + 1
		Else
			Return 1
		End If
	Case 100
		Return 1
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da pr$$HEX1$$f300$$ENDHEX$$xima promo$$HEX2$$e700e300$$ENDHEX$$o.")
		Return -1
End Choose
end function

public subroutine wf_localiza_produto ();Long lvl_Linha

ivo_Produto.of_Localiza_Produto(dw_2.GetText())

If ivo_Produto.Localizado Then
	lvl_Linha = dw_2.Find("cd_produto = " + String(ivo_Produto.Cd_Produto), 1, dw_2.RowCount())

	If lvl_Linha < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do produto selecionado.", StopSign!)
		Return
	End If
	
	If lvl_Linha = 0 Then
		lvl_Linha = dw_2.GetRow()
		
		dw_2.Object.Cd_Produto          [lvl_Linha] = ivo_Produto.Cd_Produto
		dw_2.Object.De_Produto          [lvl_Linha] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
		dw_2.Object.Vl_Preco_Venda_Atual[lvl_Linha] = ivo_Produto.Vl_Preco_Venda_Atual
		
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto '" + String(ivo_Produto.Cd_Produto) + "' j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ selecionado.", Information!)
	End If
	
	dw_2.Post Event ue_Pos(lvl_Linha, "pc_desconto")	
End If
end subroutine

public subroutine wf_atualiza_produtos_incluidos_alterados (dc_uo_ds_base ads, ref long al_alteracao);Long lvl_Linha, &
     lvl_Produto, &
	  lvl_Find
	  
String lvs_Descricao

Decimal lvdc_Desconto, &
        lvdc_Preco, &
		  lvdc_Desconto_Anterior

For lvl_Linha = 1 To ads.RowCount()
	lvl_Produto   = ads.Object.Cd_Produto          [lvl_Linha]
	lvs_Descricao = ads.Object.De_Produto          [lvl_Linha]
	lvdc_Desconto = ads.Object.Pc_Desconto         [lvl_Linha]
	lvdc_Preco    = ads.Object.Vl_Preco_Venda_Atual[lvl_Linha]
	
	// Para cada produto retornado, verifica se existe na lista anterior
	// Se existir, atualiza o desconto alterado, sen$$HEX1$$e300$$ENDHEX$$o inclui
	
	If Not IsNull(lvl_Produto) Then
		lvl_Find = dw_2.Find("cd_produto = " + String(lvl_Produto), 1, dw_2.RowCount())
		
		If lvl_Find < 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do produto '" + String(lvl_Produto) + "'.", StopSign!)
			Exit
		End If
		
		If lvl_Find > 0 Then
			lvdc_Desconto_Anterior = dw_2.Object.Pc_Desconto[lvl_Find]
			
			If lvdc_Desconto <> lvdc_Desconto_Anterior Then
				dw_2.Object.Pc_Desconto[lvl_Find] = lvdc_Desconto
				
				al_Alteracao ++
			End If
		Else
			lvl_Find = dw_2.InsertRow(0)
			
			dw_2.Object.Cd_Produto          [lvl_Find] = lvl_Produto
			dw_2.Object.De_Produto          [lvl_Find] = lvs_Descricao
			dw_2.Object.Pc_Desconto         [lvl_Find] = lvdc_Desconto
			dw_2.Object.Vl_Preco_Venda_Atual[lvl_Find] = lvdc_Preco			
			dw_2.Object.Vl_Preco_Simulado   [lvl_Find] = 0
			
			al_Alteracao ++
		End If
	End If
Next
end subroutine

public subroutine wf_atualiza_produtos_excluidos (dc_uo_ds_base ads, ref long al_alteracao);Long lvl_Linha, &
     lvl_Produto, &
	  lvl_Find
	  
For lvl_Linha = 1 To dw_2.RowCount()
	lvl_Produto = dw_2.Object.Cd_Produto[lvl_Linha]
	
	// Para cada produto da lista anterior, verifica se existe na lista retornada
	// Se n$$HEX1$$e300$$ENDHEX$$o existir, exclui
	
	lvl_Find = ads.Find("cd_produto = " + String(lvl_Produto), 1, ads.RowCount())
	
	If lvl_Find < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do produto '" + String(lvl_Produto) + "'.", StopSign!)
		Exit
	End If
	
	If lvl_Find = 0 Then
		If dw_2.DeleteRow(lvl_Linha) <> 1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na exclus$$HEX1$$e300$$ENDHEX$$o da linha '" + String(lvl_Linha) + "'.", StopSign!)
			Exit
		End If
		
		al_Alteracao ++
		
		// Diminui um do controle do loop devido a linha exclu$$HEX1$$ed00$$ENDHEX$$da da dw
		lvl_Linha --
	End If
Next
end subroutine

public function boolean wf_copia_produto (long al_promocao, ref long al_alteracao);Boolean lvb_Sucesso = True

Long lvl_Total, &
     lvl_Contador, &
	  lvl_Produto, &
	  lvl_Linha
	  
Decimal lvdc_Desconto

dc_uo_ds_Base lvds
lvds = Create dc_uo_ds_Base

If Not lvds.of_ChangeDataObject("dw_ge380_produto_normal") Then
	Destroy(lvds)
	Return False
End If

lvl_Total = lvds.Retrieve(al_Promocao)

If lvl_Total > 0 Then
	uo_Produto lvo_Produto
	lvo_Produto = Create uo_Produto
	
	For lvl_Contador = 1 To lvl_Total
		lvl_Produto   = lvds.Object.Cd_Produto [lvl_Contador]
		lvdc_Desconto = lvds.Object.Pc_Desconto[lvl_Contador]
		
		lvl_Linha = dw_2.Find("cd_produto = " + String(lvl_Produto), 1, dw_2.RowCount())
		
		If lvl_Linha < 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do produto '" + String(lvl_Produto) + "'.")
			lvb_Sucesso = False
			Exit
		End If
		
		If lvl_Linha = 0 Then
		   lvo_Produto.of_Localiza_Codigo_Interno(lvl_Produto)
			
			If lvo_Produto.Localizado Then			
				lvl_Linha = dw_2.InsertRow(0)
				
				dw_2.Object.Cd_Produto [lvl_Linha] = lvl_Produto
				dw_2.Object.Pc_Desconto[lvl_Linha] = lvdc_Desconto
				dw_2.Object.De_Produto [lvl_Linha] = lvo_Produto.ivs_Descricao_Apresentacao_Venda
				
				If lvl_Linha = 1 Then
					dw_2.ivo_Controle_Menu.of_Excluir(True)
				End If
				
				al_Alteracao ++
			End If
		End If
	Next	
	
	Destroy(lvo_Produto)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Os produtos da promo$$HEX2$$e700e300$$ENDHEX$$o '" + String(al_Promocao) + "' n$$HEX1$$e300$$ENDHEX$$o foram localizados para c$$HEX1$$f300$$ENDHEX$$pia.")
End If

Destroy(lvds)

Return lvb_Sucesso
end function

public function boolean wf_copia_filial (long al_promocao, ref long al_alteracao);Boolean lvb_Sucesso = True

Long lvl_Total, &
     lvl_Contador, &
	  lvl_Filial, &
	  lvl_Linha
	  
dc_uo_ds_Base lvds
lvds = Create dc_uo_ds_Base

If Not lvds.of_ChangeDataObject("dw_ge380_filial_cadastrada") Then
	Destroy(lvds)
	Return False
End If

lvl_Total = lvds.Retrieve(al_Promocao)

If lvl_Total > 0 Then
	For lvl_Contador = 1 To lvl_Total
		lvl_Filial = lvds.Object.Cd_Filial[lvl_Contador]
		
		lvl_Linha = dw_3.Find("cd_filial = " + String(lvl_Filial), 1, dw_3.RowCount())
		
		If lvl_Linha < 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o da filial '" + String(lvl_Filial) + "'.")
			lvb_Sucesso = False
			Exit
		End If
		
		If lvl_Linha = 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Filial '" + String(lvl_Filial) + "' n$$HEX1$$e300$$ENDHEX$$o localizada na lista de sele$$HEX2$$e700e300$$ENDHEX$$o de filiais.")
			lvb_Sucesso = False
			Exit			
		End If
		
		If dw_3.Object.Id_Filial[lvl_Linha] = "N" Then
			dw_3.Object.Id_Filial[lvl_Linha] = "S"
			
			dw_3.Event ue_Seleciona_Filial(lvl_Filial, True)			
			
			al_Alteracao ++
		End If
	Next	
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "As filiais da promo$$HEX2$$e700e300$$ENDHEX$$o '" + String(al_Promocao) + "' n$$HEX1$$e300$$ENDHEX$$o foram localizadas para c$$HEX1$$f300$$ENDHEX$$pia.")
End If

Destroy(lvds)

Return lvb_Sucesso
end function

public function boolean wf_salva_pendente ();Long lvl_Modificado

dw_2.AcceptText()

lvl_Modificado = dw_2.ModifiedCount() + dw_2.DeletedCount()
							 
If lvl_Modificado > 0 Then
	Return True
Else
	Return False
End If
end function

public function boolean wf_inclui_promocao_sos_produto (long al_produto, decimal adc_desconto, decimal adc_desc_clube);Long 	lvl_Find, &
     	lvl_Row

lvl_Find = dw_2.Find("cd_produto = " + String(al_produto), 1, dw_2.RowCount())

If lvl_Find = -1 Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no find para o produto '" + String(al_Produto) + "'.", StopSign!)
	Return False
End If 

If lvl_Find = 0 Then
	
	ivo_Produto.of_Localiza_Codigo_Interno(al_Produto)

	If ivo_Produto.Localizado Then
		
		lvl_Row = dw_2.InsertRow(0) 
		
		dw_2.Object.cd_produto          		[ lvl_Row ] = al_Produto
		dw_2.Object.pc_desconto         		[ lvl_Row ] = adc_desconto
		dw_2.Object.pc_desconto_clube 		[ lvl_Row ] = adc_desc_clube
		dw_2.Object.De_Produto          		[ lvl_Row ] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
		dw_2.Object.Vl_Preco_Venda_Atual	[ lvl_Row ] = ivo_Produto.Vl_Preco_Venda_Atual
		
		ivl_Linhas ++
	End If
	
Else
	
   	If dw_2.Object.pc_desconto[ lvl_Find ] <> adc_desconto Then
		dw_2.Object.pc_desconto[ lvl_Find ] = adc_desconto
		ivl_Linhas ++
	End If
	
	If IsNull(dw_2.Object.pc_desconto_Clube[ lvl_Find ]) Then dw_2.Object.pc_desconto_Clube[ lvl_Find ]  = 0.00
	
	If  dw_2.Object.pc_desconto_Clube[ lvl_Find ] <> adc_desc_clube Then
		dw_2.Object.pc_desconto_Clube[ lvl_Find ] = adc_desc_clube
		ivl_Linhas ++
	End If
	
End If

Return True
end function

public function boolean wf_valida_desconto (long pl_row, string ps_dado, ref decimal rdc_desconto);Decimal ldc_Desc

If Not IsNumber( ps_Dado ) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Valor do desconto inv$$HEX1$$e100$$ENDHEX$$lido.~rLinha: " + String( pl_row ) + "~rValor: " + ps_dado)
	Return False
End If

ldc_Desc = Dec(ps_Dado)

If IsNull(ldc_Desc) or ldc_Desc <= 0 Then ldc_Desc = 0

If ldc_Desc > 99 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Valor do desconto maior que o permitido.~rLinha: " + String(pl_row) + "~rValor: " + ps_dado)
	Return False
End If

rdc_desconto = ldc_Desc

Return True
end function

public function boolean wf_verifica_usuario_alteracao (ref boolean ab_permite_alterar);String ls_Inclusao = 'N'
String ls_Alteracao = 'N'
String ls_Exclusao = 'N'

Select p.id_inclusao, p.id_alteracao, p.id_exclusao
	Into: ls_Inclusao, :ls_Alteracao, :ls_Exclusao
From procedimento_perfil_usuario p
	Inner Join usuario_sistema u
		On u.cd_sistema = p.cd_sistema
		And u.cd_perfil_usuario = p.cd_perfil_usuario
Where p.cd_sistema = :gvo_Aplicacao.ivo_Seguranca.Cd_Sistema
	And u.nr_matricula = :gvo_Aplicacao.ivo_seguranca.Nr_matricula
	And p.cd_procedimento = 'GE347_LIBERA_ALTERACAO'
Using SqlCa;

If SqlCa.SqlCode = - 1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar a permiss$$HEX1$$e300$$ENDHEX$$o de altera$$HEX2$$e700e300$$ENDHEX$$o do usu$$HEX1$$e100$$ENDHEX$$rio. " + SqlCa.SqlErrText, StopSign!)
	Return False
End If

If (ls_Inclusao = 'S' And ls_Alteracao = 'S' And ls_Exclusao = 'S') Then
	dw_1.Object.t_msg_usuario.Visible = False
	ab_permite_alterar = True
Else
	dw_1.Object.t_msg_usuario.Visible = True
	ab_permite_alterar = False
End If

Return True
end function

public function boolean wf_existe_filiais_desmarcadas ();String ls_Atual, ls_Anterior
Long ll_Row

For ll_Row = 1 To dw_3.RowCount()
	
	ls_Atual 		= dw_3.Object.id_filial 					[ ll_Row ]
	ls_Anterior	= dw_3.Object.id_marcacao_anterior	[ ll_Row ]
	
	If ls_Atual = 'N' And ls_Anterior = 'S' Then  Return True
	
Next

Return False

end function

public function boolean wf_grava_rede_liberada ();Long ll_Achou, ll_Registros

Select count(*) 
Into :ll_Achou
From promocao_sos_rede_filial
Where cd_promocao_sos = :ivo_Promocao.Cd_Promocao
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da rede liberada para a promo$$HEX2$$e700e300$$ENDHEX$$o.")
	Return False
End If

If ll_Achou = 0 Then
	
	INSERT INTO promocao_sos_rede_filial  ( cd_promocao_sos, id_rede_filial )  
	select distinct p.cd_promocao_sos, v.id_rede
	from promocao_sos_filial p
	inner join vw_filial v on v.cd_filial = p.cd_filial
	where p.cd_promocao_sos = :ivo_Promocao.Cd_Promocao
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgDbError("Inclus$$HEX1$$e300$$ENDHEX$$o da rede liberada para a promo$$HEX2$$e700e300$$ENDHEX$$o.")
		Return False
	End If
	
	ll_Registros = Sqlca.SQLNRows 
	
	SqlCa.of_Commit();
	
End If

Return True

end function

public function boolean wf_verifica_rede_liberada ();Long ll_Linha, ll_Linha2, ll_Find

String ls_Rede, ls_Rede_Filial, ls_Nome_Fant

ll_Find = dw_8.Find("id_rede = 'S'", 1, dw_8.RowCount())

If ll_Find = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existe rede liberada para a promo$$HEX2$$e700e300$$ENDHEX$$o.", Exclamation!)
	Return False
End If

If ll_Find < 0 Then
	MessageBox("Erro", "Erro no find ao localizar a rede liberada para a promo$$HEX2$$e700e300$$ENDHEX$$o.", StopSign!)
	Return False
End If


For ll_Linha = 1 To dw_8.RowCount()
	
	If dw_8.Object.id_rede[ll_Linha] = 'N' Then
		
		ls_Rede = dw_8.Object.id_rede_filial[ll_Linha]
		
		For ll_Linha2 = 1 To dw_3.RowCount()
			
			If dw_3.Object.id_filial[ll_Linha2] = 'S' Then
				ls_Rede_Filial = dw_3.Object.vl_parametro[ll_Linha2]
				
				If ls_Rede = ls_Rede_Filial Then
					
					ls_Nome_Fant = dw_3.Object.nm_fantasia[ll_Linha2] + ' - ' + String(dw_3.Object.cd_filial[ll_Linha2]) + ' (' + ls_Rede_Filial + ')'
				
					//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A rede da filial selecionada esta diferente da rede liberada '" + ls_Rede + "' para a promo$$HEX2$$e700e300$$ENDHEX$$o.~r~r" + "Filial: " + ls_Nome_Fant)
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A rede da filial selecionada n$$HEX1$$e300$$ENDHEX$$o esta liberada para a promo$$HEX2$$e700e300$$ENDHEX$$o.~r~r" + "Filial: " + ls_Nome_Fant, Exclamation!)
					Return False
				End If
			End If
			
		Next 
	End If
	
Next

Return True
end function

public function boolean wf_verifica_inclusao_estoque_minimo ();Long ll_Promocao

String ls_Id_Inclui_Estoque_Min
String ls_SqlErrText

dw_1.AcceptText()

ll_Promocao = dw_1.Object.Cd_Promocao_Sos[1]

Select Coalesce(id_inclui_estoque_minimo, "N")
	Into :ls_Id_Inclui_Estoque_Min
From promocao_sos
Where cd_promocao_sos = :ll_Promocao
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Erro ao localizar a promo$$HEX2$$e700e300$$ENDHEX$$o na fun$$HEX2$$e700e300$$ENDHEX$$o wf_verifica_inclusao_estoque_minimo")
	Return False
End If

//Esta fun$$HEX2$$e700e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ utilizada tamb$$HEX1$$e900$$ENDHEX$$m na CO007

If ls_Id_Inclui_Estoque_Min = "S" Then
	Insert Into promocao_sos_estoque_minimo
				(cd_promocao_sos,
				cd_filial,
				cd_produto,
				qt_estoque_minimo,
				nr_matricula_alteracao)
		Select	v.cd_promocao_sos,
				v.cd_filial,
				v.cd_produto,
				1,
				'14330'
	From vw_promocao_estoque_minimo v
		Inner Join resumo_reposicao_estoque r
			On r.cd_filial		= v.cd_filial
			And r.cd_produto	= v.cd_produto
		Inner Join produto_geral g
			On g.cd_produto = v.cd_produto
	Where v.cd_promocao_sos = :ll_Promocao
		And qt_estoque_base = 0
		And v.cd_filial Not In (Select cd_filial
									From parametro_loja x
									Where x.cd_filial = cd_filial
									    And cd_parametro = 'ID_INCLUI_ESTOQUE_MINIMO_AUTOMATICO'
									    And vl_parametro = 'N')
		And substring(g.cd_subcategoria, 1, 1) <> '1'
		And Not Exists (Select *
							From promocao_sos_estoque_minimo m
							Where m.cd_promocao_sos		= v.cd_promocao_sos
							    And m.cd_filial					= v.cd_filial
							    And m.cd_produto				= v.cd_produto)
	Using SqlCa;
	  
	If SqlCa.SqlCode = -1 Then
		ls_SqlErrText = SqlCa.SqlErrText
		SqlCa.of_Rollback();
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao Incluir o estoque m$$HEX1$$ed00$$ENDHEX$$nimo autom$$HEX1$$e100$$ENDHEX$$tico. Fun$$HEX2$$e700e300$$ENDHEX$$o wf_verifica_inclusao_estoque_minimo " + ls_SqlErrText, StopSign!)
		Return False
	End If
	
	//SqlCa.of_Commit();
End If

Return True
end function

public function boolean wf_valida_fronteira ();Long ll_Find_1
Long ll_Find_2
Long ll_Find_Desc
Long ll_Promocao

String ls_Nome_Fantasia

/*- Antes de salvar.
- Se a filial 805 estiver selecionada e a promo$$HEX2$$e700e300$$ENDHEX$$o for diferente da 860.
- Se existir algum produto com o percentual maior que zero no desconto normal ou clube mostrar a mensagem abaixo:
  "A filial XXXX que $$HEX1$$e900$$ENDHEX$$ uma filial de fronteira~r. Existem produtos com percentual de desconto normal ou clube maior que zero~r~r. Deseja continuar mesmo assim ?"
- Se a resposta for 'N$$HEX1$$c300$$ENDHEX$$O' ent$$HEX1$$e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o salva as altera$$HEX2$$e700f500$$ENDHEX$$es.

- Antes de salvar.
- Se a filial 947 estiver selecionada e a promo$$HEX2$$e700e300$$ENDHEX$$o for diferente da 1415.
- Se existir algum produto com o percentual maior que zero no desconto normal ou clube mostrar a mensagem abaixo:  
"A filial XXXX que $$HEX1$$e900$$ENDHEX$$ uma filial de fronteira~r. Existem produtos com percentual de desconto normal ou clube maior que zero~r~r. Deseja continuar mesmo assim ?"
- Se a resposta for 'N$$HEX1$$c300$$ENDHEX$$O' ent$$HEX1$$e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o salva as altera$$HEX2$$e700f500$$ENDHEX$$es.
*/

dw_1.AcceptText()
dw_2.AcceptText()
dw_3.AcceptText()

ll_Promocao = dw_1.Object.Cd_Promocao_Sos[1]

If ll_Promocao = 860 Or ll_Promocao = 1415 Then Return True

ll_Find_Desc = dw_2.Find("pc_desconto > 0.00 Or pc_desconto_clube > 0.00", 1, dw_2.RowCount())

If ll_Find_Desc > 0 Then
	If ll_Promocao <> 860 Then
		ll_Find_1 = dw_3.Find("id_filial = 'S' And cd_filial = 805", 1, dw_3.RowCount())
		
		If ll_Find_1 > 0 Then
			ls_Nome_Fantasia = dw_3.Object.Nm_Fantasia[ll_Find_1]
		
			If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A filial '" + ls_Nome_Fantasia + " (805)' $$HEX1$$e900$$ENDHEX$$ uma filial de fronteira." + &
								"~rExistem produtos com percentual de desconto normal ou clube maior que zero." + &
								"~rDeseja continuar mesmo assim?", Question!, YesNo!, 2) = 2 Then
				Return False
			End If
		End If
	End If
	
	If ll_Promocao <> 1415 Then
		ll_Find_2 = dw_3.Find("id_filial = 'S' And cd_filial = 947", 1, dw_3.RowCount())
		
		If ll_Find_2 > 0 Then
			ls_Nome_Fantasia = dw_3.Object.Nm_Fantasia[ll_Find_2]
		
			If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A filial '" + ls_Nome_Fantasia + " (947)' $$HEX1$$e900$$ENDHEX$$ uma filial de fronteira." + &
								"~rExistem produtos com percentual de desconto normal ou clube maior que zero." + &
								"~rDeseja continuar mesmo assim?", Question!, YesNo!, 2) = 2 Then
				Return False
			End If
		End If
	End If
End If

Return True
end function

public function boolean wf_verifica_produto_selecionado ();Long lvl_Find

lvl_Find = dw_2.Find("cd_produto > 0", 1,  dw_2.RowCount() )	

If lvl_Find > 0 Then Return True

If lvl_Find = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione pelo menos um produto.")
	Return False
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no find dw_2.")
	Return False
End If
end function

public subroutine wf_seleciona_filial_planilha (string as_arquivo);Any la_Dado

Boolean lb_Selecao
Boolean lb_Sucesso = False

Long ll_Linha
Long ll_Linhas
Long ll_Find
Long ll_Filial

dc_uo_Excel lo_Excel
lo_Excel = Create dc_uo_Excel

dw_3.SetRedRaw(False)

Open(w_Aguarde)
w_Aguarde.Title = "Importando filiais..."

// Refer$$HEX1$$ea00$$ENDHEX$$ncia o arquivo 
If ( lo_Excel.uo_Referencia_Objeto_Excel(as_arquivo)) Then
	// Coluna de Refer$$HEX1$$ea00$$ENDHEX$$ncia
	ll_Linhas = lo_Excel.uo_Verifica_Tamanho_Arquivo("A") 
	
	If ll_Linhas > 0 Then
		w_Aguarde.uo_Progress.of_SetMax(ll_Linhas)
	
		For ll_Linha = 1 To ll_Linhas
			
			//C$$HEX1$$f300$$ENDHEX$$digo da filial
			la_Dado = lo_Excel.uo_Lendo_Dados(ll_Linha, "A")
			
			If Not IsNumber(String(la_Dado)) Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "C$$HEX1$$f300$$ENDHEX$$digo '" + String(la_Dado) + "' da filial inv$$HEX1$$e100$$ENDHEX$$lido.", Exclamation!)
				Continue
			End If
			
			ll_Find = dw_3.Find("cd_filial = " + String(Long(la_Dado)), 1, dw_3.RowCount())
			
			ll_Filial = Long(la_Dado)
			
			If ll_Find > 0 Then
				If dw_3.Object.Id_Filial[ll_Find] = "N"  Then
					dw_3.Event ue_Seleciona_Filial(ll_Filial, True)
					dw_3.Object.Id_Filial[ll_Find] = "S"
					lb_Sucesso = True
				End If
			End If
			
			If ll_Find = 0 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizada a filial na lista de filiais.", Exclamation!)
			End If
			
			If ll_Find < 0 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Find.", StopSign!)
				lb_Sucesso = False
				Exit
			End If
		Next
	End If
End If

If lb_Sucesso Then
	ivb_Valida_Salva = True
	
	ivm_Menu.mf_Confirmar(True)
	ivm_Menu.mf_Cancelar(True)		
End If

Close(w_Aguarde)
dw_3.SetRedRaw(True)
end subroutine

public function boolean wf_deleta_prd_vinculado (long al_promocao, long al_vinculo);Long ll_Linha
Long ll_Produto

String ls_Erro
String ls_Nulo
String ls_Chave

Try

dc_uo_ds_base lds
lds = Create dc_uo_ds_base

If Not lds.of_ChangeDataObject("dw_ge347_lista_produto_vinculado") Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar o data store 'dw_ge347_lista_produto_vinculado'.", StopSign!)
	Return False
End If

If lds.Retrieve(al_Promocao, al_Vinculo) > 0 Then
	
	SetNull(ls_Nulo)
		
	For ll_Linha = 1 To lds.RowCount()
		
		ll_Produto = lds.Object.Cd_Produto[ll_Linha] 
		
		Delete From promocao_sos_vinculo_prd
		Where cd_promocao_sos = :al_Promocao
			And nr_vinculo = :al_Vinculo
			And cd_produto = :ll_Produto
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			ls_Erro = SqlCa.SqlErrText
			SqlCa.of_Rollback();
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao deletar os produtos que est$$HEX1$$e300$$ENDHEX$$o vinculados. " + ls_Erro, StopSign!)
			Return False
		End If
		
		ls_Chave = MidA(String(al_Promocao) + Space(5), 1, 5) + "@#!" + String(al_Vinculo) + "@#!" + MidA(String(ll_Produto) + Space(6), 1, 6)
	
		If Not gf_Grava_Historico_Alteracao_Tabela('PROMOCAO_SOS_VINCULO_PRD', ls_Chave, 'CD_PRODUTO', String(ll_Produto), ls_Nulo, gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, 'E', Ref ls_Erro, True) Then
			Return False
		End If
	Next
End If

Return True

Finally
	If IsValid(lds) Then Destroy(lds)
End Try
end function

public subroutine wf_carrega_legenda (string as_tipo);Choose Case as_Tipo
	Case "U"
		dw_1.Modify("p_3.Tooltip.Tip='$$HEX1$$da00$$ENDHEX$$nica. Desconto ser$$HEX1$$e100$$ENDHEX$$ aplicado apenas para um produto.'")
			
	Case "M"
		dw_1.Modify("p_3.Tooltip.Tip='M$$HEX1$$fa00$$ENDHEX$$ltipla. Ser$$HEX1$$e100$$ENDHEX$$ aplicado o desconto em um produto conforme as m$$HEX1$$fa00$$ENDHEX$$ltiplas condi$$HEX2$$e700f500$$ENDHEX$$es forem se repetir.'")
		
	Case "T"
		dw_1.Modify("p_3.Tooltip.Tip='Todos. Ser$$HEX1$$e100$$ENDHEX$$ aplicado o desconto para todos os produtos desta promo$$HEX2$$e700e300$$ENDHEX$$o.'")
End Choose
end subroutine

public function boolean wf_valor_inicial (long al_promocao, long al_vinculo, ref string as_vinculo, ref long al_qtd);Select de_vinculo, qt_vinculo
	Into :as_Vinculo, :al_Qtd
From promocao_sos_vinculo
Where  cd_promocao_sos = :al_Promocao
	And nr_vinculo = :al_Vinculo
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		
	Case 100
		
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao consultar as altera$$HEX2$$e700f500$$ENDHEX$$es")
		Return False
End Choose

Return True
end function

public function boolean wf_proximo_vinculo (long al_promocao);Select Coalesce(max(nr_vinculo), 0)
	Into :il_Ultimo_Vinc
From promocao_sos_vinculo
Where cd_promocao_sos = :al_Promocao
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		Return True
	
	Case 100

	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do pr$$HEX1$$f300$$ENDHEX$$ximo v$$HEX1$$ed00$$ENDHEX$$nculo.")
		
End Choose

Return False
end function

public subroutine wf_desabilita_controles (string as_tipo);If as_tipo = 'S' Then 

	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Esta promocao foi cadastrada no SAP. N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitido realizar altera$$HEX2$$e700f500$$ENDHEX$$es, somente no SAP!.", Information!)
	
	cb_selecao_filial.enabled = False
	cb_selecao_filiais.enabled = False
	cb_1.enabled = False
	
	//Permitir que o usu$$HEX1$$e100$$ENDHEX$$rio visualize os produtos.
	//cb_2.enabled = False
	
	cb_3.enabled = False
	

	dw_3.Object.imagem.visible = False
	
	dw_1.ivo_Controle_Menu.of_Incluir(False)
	dw_1.ivm_menu.mf_Confirmar(False)
	dw_1.ivm_Menu.mf_Cancelar(False)		
	dw_1.ivo_Controle_Menu.of_Excluir(False)
	dw_1.ivm_Menu.mf_excluir(False)
	
	dw_2.ivo_Controle_Menu.of_Incluir(False)
	dw_2.ivm_menu.mf_Confirmar(False)
	dw_2.ivm_Menu.mf_Cancelar(False)		
	dw_2.ivo_Controle_Menu.of_excluir( False)
	dw_2.ivm_Menu.mf_Excluir(False)		
	
	dw_3.ivo_Controle_Menu.of_Incluir(False)
	dw_3.ivm_menu.mf_Confirmar(False)
	dw_3.ivm_Menu.mf_Cancelar(False)		
	dw_3.ivo_Controle_Menu.of_excluir( False)
	dw_3.ivm_Menu.mf_Excluir(False)		

	dw_5.ivo_Controle_Menu.of_Incluir(False)
	dw_5.ivm_menu.mf_Confirmar(False)
	dw_5.ivm_Menu.mf_Cancelar(False)		
	dw_5.ivo_Controle_Menu.of_excluir( False)
	dw_5.ivm_Menu.mf_Excluir(False)		

	dw_8.ivm_menu.mf_Confirmar(False)
	dw_8.ivo_Controle_Menu.of_Incluir(False)
	dw_8.ivm_Menu.mf_Cancelar(False)	
	dw_8.ivo_Controle_Menu.of_excluir( False)
	dw_8.ivm_Menu.mf_Excluir(False)		
	
Else
	
	cb_selecao_filial.enabled = True
	cb_selecao_filiais.enabled = True
	cb_1.enabled = True
	cb_2.enabled = True
	cb_3.enabled = True
	

	dw_3.Object.imagem.visible = True
	
	dw_1.ivo_Controle_Menu.of_Incluir(True)
	dw_1.ivm_menu.mf_Confirmar(True)
	dw_1.ivm_Menu.mf_Cancelar(True)		
	dw_1.ivo_Controle_Menu.of_Excluir(True)
	dw_1.ivm_Menu.mf_excluir(True)
	
	dw_2.ivo_Controle_Menu.of_Incluir(True)
	dw_2.ivm_menu.mf_Confirmar(True)
	dw_2.ivm_Menu.mf_Cancelar(True)		
	dw_2.ivm_Menu.mf_Excluir(True)		
	dw_2.ivo_Controle_Menu.of_excluir( True)
	dw_2.ivm_Menu.mf_excluir(True)
	
	dw_3.ivo_Controle_Menu.of_Incluir(True)
	dw_3.ivm_menu.mf_Confirmar(True)
	dw_3.ivm_Menu.mf_Cancelar(True)		
	dw_3.ivo_Controle_Menu.of_excluir( True)
	dw_3.ivm_Menu.mf_excluir(True)

	dw_5.ivo_Controle_Menu.of_Incluir(True)
	dw_5.ivm_menu.mf_Confirmar(True)
	dw_5.ivm_Menu.mf_Cancelar(True)		
	dw_5.ivo_Controle_Menu.of_excluir( True)
	dw_5.ivm_Menu.mf_excluir(True)

	dw_8.ivm_menu.mf_Confirmar(True)
	dw_8.ivo_Controle_Menu.of_Incluir(True)
	dw_8.ivm_Menu.mf_Cancelar(True)	
	dw_8.ivo_Controle_Menu.of_excluir( True)
	dw_8.ivm_Menu.mf_excluir(True)
End If 
end subroutine

on w_ge347_cadastro_promocao_vinculada.create
int iCurrent
call super::create
this.gb_6=create gb_6
this.cb_selecao_filiais=create cb_selecao_filiais
this.gb_2=create gb_2
this.cb_selecao_filial=create cb_selecao_filial
this.dw_4=create dw_4
this.dw_2=create dw_2
this.dw_7=create dw_7
this.dw_3=create dw_3
this.dw_8=create dw_8
this.dw_9=create dw_9
this.gb_3=create gb_3
this.dw_1=create dw_1
this.dw_5=create dw_5
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.st_1=create st_1
this.st_2=create st_2
this.st_3=create st_3
this.st_4=create st_4
this.st_5=create st_5
this.st_6=create st_6
this.cb_4=create cb_4
this.gb_4=create gb_4
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_6
this.Control[iCurrent+2]=this.cb_selecao_filiais
this.Control[iCurrent+3]=this.gb_2
this.Control[iCurrent+4]=this.cb_selecao_filial
this.Control[iCurrent+5]=this.dw_4
this.Control[iCurrent+6]=this.dw_2
this.Control[iCurrent+7]=this.dw_7
this.Control[iCurrent+8]=this.dw_3
this.Control[iCurrent+9]=this.dw_8
this.Control[iCurrent+10]=this.dw_9
this.Control[iCurrent+11]=this.gb_3
this.Control[iCurrent+12]=this.dw_1
this.Control[iCurrent+13]=this.dw_5
this.Control[iCurrent+14]=this.cb_1
this.Control[iCurrent+15]=this.cb_2
this.Control[iCurrent+16]=this.cb_3
this.Control[iCurrent+17]=this.st_1
this.Control[iCurrent+18]=this.st_2
this.Control[iCurrent+19]=this.st_3
this.Control[iCurrent+20]=this.st_4
this.Control[iCurrent+21]=this.st_5
this.Control[iCurrent+22]=this.st_6
this.Control[iCurrent+23]=this.cb_4
this.Control[iCurrent+24]=this.gb_4
this.Control[iCurrent+25]=this.gb_1
end on

on w_ge347_cadastro_promocao_vinculada.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_6)
destroy(this.cb_selecao_filiais)
destroy(this.gb_2)
destroy(this.cb_selecao_filial)
destroy(this.dw_4)
destroy(this.dw_2)
destroy(this.dw_7)
destroy(this.dw_3)
destroy(this.dw_8)
destroy(this.dw_9)
destroy(this.gb_3)
destroy(this.dw_1)
destroy(this.dw_5)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.st_1)
destroy(this.st_2)
destroy(this.st_3)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.st_6)
destroy(this.cb_4)
destroy(this.gb_4)
destroy(this.gb_1)
end on

event ue_postopen;call super::ue_postopen;dc_uo_dw_Base lvo_Update[]

lvo_Update = {dw_1, dw_2, dw_4, dw_9, dw_5}

This.wf_SetUpdate_DW(lvo_Update)
	
ivo_Promocao = Create uo_Promocao
ivo_Produto  = Create uo_Produto

dw_1.Event ue_AddRow()
dw_2.Event ue_AddRow()
dw_8.Event ue_Recuperar()

//dw_1.Object.id_retira_venda_calculo_eb.Visible = 1

dw_1.SetFocus()

dw_1.ivo_Controle_Menu.of_Incluir(True)
dw_2.ivo_Controle_Menu.of_Incluir(True)

ivo_Promocao.ivs_Tipo = "V"
end event

event close;call super::close;Destroy(ivo_Promocao)
Destroy(ivo_Produto)
Destroy(ids)
end event

event ue_cancel;call super::ue_cancel;SqlCa.of_Rollback();

dw_1.Event ue_AddRow()

dw_1.Object.t_msg_usuario.Visible = False
end event

event ue_preopen;call super::ue_preopen;dw_4.Visible = False
end event

event ue_preupdate;call super::ue_preupdate;DateTime lvdh_Parametro, &
        		 lvdh_Inicio, &
	      	lvdh_Termino, &
			lvdh_Inicio_Estoque, &
			lvdh_Termino_Estoque, &
			lvdh_Inicio_Anterior,&
			ldt_Minimo_Inicio_DE,&
			ldt_Minimo_Inicio_Ate,&
			ldt_Minimo_Termino_DE			
			
Long 	lvl_Promocao, &
		lvl_Linhas, &
		lvl_Resposta, &
		lvl_Find
	
Long ll_Row

String lvs_Terminada, &
		 lvs_Promocao_Linha, &
		 ls_Nome_Promocao

Boolean lb_Permite_Alterar

//If dw_2.RowCount() = 0 Then
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione pelo menos um produto.", Information!)
//	Return False
//End If

dw_1.AcceptText()

If Not wf_Verifica_Usuario_Alteracao(Ref lb_Permite_Alterar) Then Return False

If Not lb_Permite_Alterar Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Usu$$HEX1$$e100$$ENDHEX$$rio sem permiss$$HEX1$$e300$$ENDHEX$$o de altera$$HEX2$$e700e300$$ENDHEX$$o.")
	Return False
End If

//If Not lb_Permite_Alterar Then
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A matricula '" + ivs_Responsavel + "' n$$HEX1$$e300$$ENDHEX$$o tem permiss$$HEX1$$e300$$ENDHEX$$o para realizar altera$$HEX2$$e700f500$$ENDHEX$$es.", Information!)
//	Return False
//End If

If wf_existe_filiais_desmarcadas() Then
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Existem filiais que foram desmarcadas e ao continuar o estoque m$$HEX1$$ed00$$ENDHEX$$nimo ser$$HEX1$$e100$$ENDHEX$$ perdido.~r~r" + &
										"Deseja continuar?", Question!, YesNo!, 2 ) = 2 Then Return False
End If

lvdh_Parametro = gvo_Parametro.of_Dh_Movimentacao()

lvl_Promocao         			= dw_1.Object.Cd_Promocao_SOS          		[ 1 ]
lvdh_Inicio          				= dw_1.Object.Dh_Inicio             					[ 1 ]
lvdh_Termino         			= dw_1.Object.Dh_Termino               			[ 1 ]
lvdh_Inicio_Estoque  			= dw_1.Object.Dh_Inicio_Estoque_Minimo 		[ 1 ]
lvdh_Termino_Estoque 		= dw_1.Object.Dh_Termino_Estoque_Minimo	[ 1 ]
lvs_Terminada        			= dw_1.Object.Id_Terminada             			[ 1 ]
lvdh_Inicio_Anterior 			= dw_1.Object.Dh_Inicio_Anterior       			[ 1 ]
ls_Nome_Promocao			= dw_1.Object.Nm_Promocao_Sos				[ 1 ]
	
If lvs_Terminada = "S" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Esta promo$$HEX2$$e700e300$$ENDHEX$$o j$$HEX1$$e100$$ENDHEX$$ terminou, portanto nenhuma altera$$HEX2$$e700e300$$ENDHEX$$o poder$$HEX1$$e100$$ENDHEX$$ ser salva.")
	Return False
End If

If IsNull(ls_Nome_Promocao) Or Trim(ls_Nome_Promocao) = "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o nome da promo$$HEX2$$e700e300$$ENDHEX$$o.", Information!)
	dw_1.Event ue_Pos(1, "nm_promocao_sos")
	Return False
End If

If IsNull(lvdh_Inicio) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio da promo$$HEX2$$e700e300$$ENDHEX$$o.", Information!)
	dw_1.Event ue_Pos(1, "dh_inicio")
	Return False
End If	

If IsNull(lvdh_Termino) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino da promo$$HEX2$$e700e300$$ENDHEX$$o.", Information!)
	dw_1.Event ue_Pos(1, "dh_termino")
	Return False
End If

If lvdh_Termino < lvdh_Inicio Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de t$$HEX1$$e900$$ENDHEX$$rmino deve ser maior que a data de in$$HEX1$$ed00$$ENDHEX$$cio da promo$$HEX2$$e700e300$$ENDHEX$$o.", Information!)
	dw_1.Event ue_Pos(1, "dh_termino")
	Return False	
End If
	
If Not IsNull(lvdh_Termino_Estoque) Then
	If IsNull(lvdh_Inicio_Estoque) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio para reposi$$HEX2$$e700e300$$ENDHEX$$o do estoque m$$HEX1$$ed00$$ENDHEX$$nimo.", Information!)
		dw_1.Event ue_Pos(1, "dh_inicio_estoque_minimo")
		Return False
	End If	
End If

If Not IsNull(lvdh_Inicio_Estoque) Then
	If Not IsNull(lvdh_Termino_Estoque) Then
		If lvdh_Termino_Estoque < lvdh_Inicio_Estoque Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de t$$HEX1$$e900$$ENDHEX$$rmino deve ser maior que a data de in$$HEX1$$ed00$$ENDHEX$$cio para reposi$$HEX2$$e700e300$$ENDHEX$$o do estoque m$$HEX1$$ed00$$ENDHEX$$nimo.", Information!)
			dw_1.Event ue_Pos(1, "dh_termino_estoque_minimo")
			Return False	
		End If
	End If
End If 

If Not IsNull(lvdh_Termino) Then
	If Not IsNull(lvdh_Termino_Estoque) Then
		If lvdh_Termino_Estoque > lvdh_Termino Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de t$$HEX1$$e900$$ENDHEX$$rmino para reposi$$HEX2$$e700e300$$ENDHEX$$o do estoque m$$HEX1$$ed00$$ENDHEX$$nimo n$$HEX1$$e300$$ENDHEX$$o pode ser maior que a data de t$$HEX1$$e900$$ENDHEX$$rmino da promo$$HEX2$$e700e300$$ENDHEX$$o.", Information!)
			dw_1.Event ue_Pos(1, "dh_termino_estoque_minimo")
			Return False	
		End If
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de t$$HEX1$$e900$$ENDHEX$$rmino da promo$$HEX2$$e700e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ definida, portanto a data de t$$HEX1$$e900$$ENDHEX$$rmino para reposi$$HEX2$$e700e300$$ENDHEX$$o do estoque m$$HEX1$$ed00$$ENDHEX$$nimo deve ser informada.", Information!)
		dw_1.Event ue_Pos(1, "dh_termino_estoque_minimo")
		Return False	
	End If
End If

If IsNull(lvl_Promocao) or (Not IsNull(lvl_Promocao) and lvdh_Inicio <> lvdh_Inicio_Anterior) Then
	If lvdh_Inicio < lvdh_Parametro Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio deve ser maior ou igual a '" + String(lvdh_Parametro, "dd/mm/yyyy") + "'.", Information!)
		dw_1.Event ue_Pos(1, "dh_inicio")
		Return False	
	End If
End If

If lvdh_Termino < lvdh_Parametro Then
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de t$$HEX1$$e900$$ENDHEX$$rmino deveria ser maior ou igual a '" + String(lvdh_Parametro, "dd/mm/yyyy") + "'. ~r~r" + &
	                         "Confirma grava$$HEX2$$e700e300$$ENDHEX$$o assim mesmo ?", Question!, YesNo!, 2) = 2 Then	
									 
		dw_1.Event ue_Pos(1, "dh_termino")
		Return False	
	End If
End If

ldt_Minimo_Inicio_DE 		= DateTime(RelativeDate (Date(lvdh_Inicio), -7))
ldt_Minimo_Inicio_Ate		= lvdh_Inicio // In$$HEX1$$ed00$$ENDHEX$$cio da promo$$HEX2$$e700e300$$ENDHEX$$o.

If lvdh_Inicio_Estoque < ldt_Minimo_Inicio_DE or lvdh_Inicio_Estoque > ldt_Minimo_Inicio_Ate Then
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data para o in$$HEX1$$ed00$$ENDHEX$$cio da reposi$$HEX2$$e700e300$$ENDHEX$$o do estoque m$$HEX1$$ed00$$ENDHEX$$nimo deve estar entre '" +&
						String(ldt_Minimo_Inicio_DE, 'dd/mm/yyyy') + "' (sete dias antes no in$$HEX1$$ed00$$ENDHEX$$cio da promo$$HEX2$$e700e300$$ENDHEX$$o) at$$HEX1$$e900$$ENDHEX$$ '" +&
						String(ldt_Minimo_Inicio_Ate, 'dd/mm/yyyy') +&
						"' (in$$HEX1$$ed00$$ENDHEX$$cio da promo$$HEX2$$e700e300$$ENDHEX$$o).~r~rDeseja continuar mesmo assim ?", Question!, YesNo!, 2) = 2 Then
		Return False
	End If
End If

ldt_Minimo_Termino_DE 	= DateTime(RelativeDate (Date(lvdh_Termino), -7))

If lvdh_Termino_Estoque >  ldt_Minimo_Termino_DE Then
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O t$$HEX1$$e900$$ENDHEX$$rmino da reposi$$HEX2$$e700e300$$ENDHEX$$o do estoque m$$HEX1$$ed00$$ENDHEX$$nimo deve ser pelo menos sete dias antes do t$$HEX1$$e900$$ENDHEX$$rmino da promo$$HEX2$$e700e300$$ENDHEX$$o.~r~r" +&
						"Deseja continuar mesmo assim ?", Question!, YesNo!, 2)  = 2 Then
		Return False
	End If	
End If

If Not wf_Verifica_Rede_Liberada() Then Return False

lvl_Linhas = dw_4.RowCount()
If lvl_Linhas = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione pelo menos uma filial.", Information!)
	Return False
End If

If Not wf_verifica_produto_selecionado() Then Return False

If IsNull(lvl_Promocao) Then
	lvl_Promocao = wf_Proxima_Promocao()	
	dw_1.Object.Cd_Promocao_SOS[1] = lvl_Promocao
End If

lvl_Find = 0
lvl_Find = dw_5.Find("trim(de_vinculo) = '' or isnull(de_vinculo)", 1, dw_5.RowCount())

If lvl_Find > 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o nome do grupo.", Exclamation!)
	dw_5.Event ue_Pos(lvl_Find, "de_vinculo")
	Return False
End If

lvl_Find = 0
lvl_Find = dw_5.Find("qt_vinculo <= 0 or isnull(qt_vinculo)", 1, dw_5.RowCount())

If lvl_Find > 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A quantidade de produtos vinculados deve ser maior que zero.", Exclamation!)
	dw_5.Event ue_Pos(lvl_Find, "qt_vinculo")
	Return False
End If

If Not wf_Valida_Fronteira() Then Return False
	
//If Not wf_Verifica_Inclusao_Estoque_Minimo() Then Return False

If Not gf_ge065_Historico_Exclusao_Produto(ids, dw_2, "S") Then Return False

Return True
end event

event ue_save;call super::ue_save;If AncestorReturnValue = 1 Then
	dw_1.Event ue_Retrieve()
End If

Return AncestorReturnValue
end event

event open;call super::open;ids = Create dc_uo_ds_base

If Not ids.of_ChangeDataObject("ds_ge347_produto_normal") Then
	Destroy(ids)
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar o data store 'ds_ge347_produto_normal'.", StopSign!)
	Return -1
End If

SetNull(ivs_Responsavel)
Boolean lb_Permite_alterar

If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("GE347_LIBERACAO_PROCEDIMENTO", ref ivs_Responsavel) Then 
	Return Close( This )
End If

//If Not wf_verifica_usuario_alteracao(Ref lb_Permite_alterar) Then Return Close( This )
end event

type dw_visual from dc_w_sheet`dw_visual within w_ge347_cadastro_promocao_vinculada
integer y = 1208
end type

type gb_aux_visual from dc_w_sheet`gb_aux_visual within w_ge347_cadastro_promocao_vinculada
integer y = 1144
end type

type gb_6 from groupbox within w_ge347_cadastro_promocao_vinculada
integer x = 4027
integer y = 48
integer width = 713
integer height = 356
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Rede Libera"
borderstyle borderstyle = styleraised!
end type

type cb_selecao_filiais from commandbutton within w_ge347_cadastro_promocao_vinculada
integer x = 4306
integer y = 532
integer width = 480
integer height = 100
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o de Filiais"
end type

event clicked;Boolean lvb_Sucesso = True

Long	lvl_Lojas,&
		lvl_Linha,&
		lvl_Linhas,&
		lvl_Filial,&
		lvl_Find
		
String ls_Filial_SAP

uo_ge216_filiais uo_filiais

uo_Filiais = Create uo_ge216_filiais

OpenWithParm(w_ge216_selecao_filiais, uo_Filiais)

lvl_Lojas = Message.DoubleParm

//*****************

If lvl_Lojas > 0 Then
	
	lvl_Linhas = UpperBound(uo_Filiais.ivl_filial[])
	
	For lvl_Linha = 1 To lvl_Linhas
		
		lvl_Filial = uo_Filiais.ivl_filial[lvl_Linha]
		
		gf_filial_administrada_sap(lvl_Filial, ls_Filial_SAP)
	
		If ls_Filial_SAP = 'S' Then Continue
		
		lvl_Find = dw_3.Find("cd_filial = " + String(lvl_Filial), 1, dw_3.RowCount())
		
		If lvl_Find > 0 Then
			// Se a filial n$$HEX1$$e300$$ENDHEX$$o tiver marcada o sistema vai marcar
			If dw_3.Object.Id_Filial[lvl_Find] = "N"  Then
				dw_3.Event ue_Seleciona_Filial(lvl_Filial, True)
				dw_3.Object.Id_Filial[lvl_Find] = "S"
			End If
		Else
			If lvl_Find = 0 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A filial '" + String(lvl_Filial) + " selecionada n$$HEX1$$e300$$ENDHEX$$o foi localizada na lista de filiais.")
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar a filial '" + String(lvl_Filial) + "'")
				lvb_Sucesso = False
				Exit
			End If
		End If
		
	Next
		
End If

If lvb_Sucesso Then
	Parent.ivb_Valida_Salva = True
	
	Parent.ivm_Menu.mf_Confirmar(True)
	Parent.ivm_Menu.mf_Cancelar(True)		
End If

//For lvl_Linha = 1 To dw_3.RowCount()
//	If lvb_Selecao Then
//		If dw_3.Object.Id_Filial[lvl_Linha] = "N" Then
//			dw_3.Object.Id_Filial[lvl_Linha] = "S"
//			dw_3.Event ue_Seleciona_Filial(dw_3.Object.Cd_Filial[lvl_Linha], True)
//		End If
//	Else
//		If dw_3.Object.Id_Filial[lvl_Linha] = "S" Then
//			dw_3.Object.Id_Filial[lvl_Linha] = "N"
//			dw_3.Event ue_Seleciona_Filial(dw_3.Object.Cd_Filial[lvl_Linha], False)
//		End If
//	End If
//Next

//*****************


Destroy(uo_Filiais)
end event

type gb_2 from groupbox within w_ge347_cadastro_promocao_vinculada
integer x = 14
integer y = 648
integer width = 2034
integer height = 1344
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Produtos "
borderstyle borderstyle = styleraised!
end type

type cb_selecao_filial from commandbutton within w_ge347_cadastro_promocao_vinculada
boolean visible = false
integer x = 594
integer y = 532
integer width = 480
integer height = 100
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Todas Filiais"
end type

event clicked;Long lvl_Linha

Boolean lvb_Selecao

String lvs_Titulo

String ls_Filial_SAP

If This.Text = "&Todas Filiais" Then
	lvs_Titulo  = "&Nenhuma Filial"
	lvb_Selecao = True
Else
	lvs_Titulo  = "&Todas Filiais"
	lvb_Selecao = False
End If

For lvl_Linha = 1 To dw_3.RowCount()
	
	gf_filial_administrada_sap(dw_3.Object.Id_Filial[lvl_Linha], ls_Filial_SAP)
	
	If ls_Filial_SAP = 'S' Then Continue
	
	If lvb_Selecao Then
		If dw_3.Object.Id_Filial[lvl_Linha] = "N" Then
			dw_3.Object.Id_Filial[lvl_Linha] = "S"
			dw_3.Event ue_Seleciona_Filial(dw_3.Object.Cd_Filial[lvl_Linha], True)
		End If
	Else
		If dw_3.Object.Id_Filial[lvl_Linha] = "S" Then
			dw_3.Object.Id_Filial[lvl_Linha] = "N"
			dw_3.Event ue_Seleciona_Filial(dw_3.Object.Cd_Filial[lvl_Linha], False)
		End If
	End If
Next

This.Text = lvs_Titulo

Parent.ivb_Valida_Salva = True

Parent.ivm_Menu.mf_Confirmar(True)
Parent.ivm_Menu.mf_Cancelar(True)		
end event

type dw_4 from dc_uo_dw_base within w_ge347_cadastro_promocao_vinculada
boolean visible = false
integer x = 1115
integer y = 536
integer width = 274
integer height = 108
integer taborder = 0
boolean bringtotop = true
string dataobject = "dw_ge347_filial_cadastrada"
end type

event ue_postretrieve;Long lvl_Contador, &
     lvl_Find, &
	  lvl_Filial

For lvl_Contador = 1 To dw_3.RowCount()
	lvl_Filial = dw_3.Object.Cd_Filial[lvl_Contador]
	
	If This.RowCount() > 0 Then
		lvl_Find = This.Find("cd_filial = " + String(lvl_Filial), 1, This.RowCount())
		
		If lvl_Find < 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o da lista das filiais da promo$$HEX2$$e700e300$$ENDHEX$$o.", StopSign!)
			Return pl_Linhas
		End If
	Else
		lvl_Find = 0
	End If
	
	If lvl_Find > 0 Then
		dw_3.Object.Id_Filial						[lvl_Contador] = "S"
		dw_3.Object.Id_marcacao_anterior	[lvl_Contador] = "S"
	Else
		dw_3.Object.Id_Filial						[lvl_Contador] = "N"
		dw_3.Object.Id_marcacao_anterior	[lvl_Contador] = "N"
	End If
Next

Return pl_Linhas
end event

event ue_recuperar;// Override
Long lvl_Promocao

lvl_Promocao = dw_1.Object.Cd_Promocao_SOS[1]

Return This.Retrieve(lvl_Promocao)
end event

event ue_preupdate;call super::ue_preupdate;Long lvl_Linha, &
     lvl_Promocao
	  
lvl_Promocao = dw_1.Object.Cd_Promocao_SOS[1]

For lvl_Linha = 1 To This.RowCount()
	If IsNull(This.Object.Cd_Promocao_SOS[lvl_Linha]) Then
		This.Object.Cd_Promocao_SOS[lvl_Linha] = lvl_Promocao
	End If
Next

Return 1
end event

event constructor;call super::constructor;ivi_Tipo_Cancelar = RETRIEVE
end event

type dw_2 from dc_uo_dw_base within w_ge347_cadastro_promocao_vinculada
integer x = 46
integer y = 692
integer width = 1984
integer height = 1276
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge347_produto_normal"
boolean vscrollbar = true
end type

event ue_recuperar;// Override
Long lvl_Promocao

lvl_Promocao = dw_1.Object.Cd_Promocao_SOS[1]

Return This.Retrieve(lvl_Promocao)
end event

event editchanged;call super::editchanged;//Parent.ivm_Menu.mf_Confirmar(True)
//Parent.ivm_Menu.mf_Cancelar(True)
//Parent.ivm_Menu.mf_Excluir(True)
//
//cb_exportar_saldo.Enabled = False



If gf_promocao_sap ( ivo_Promocao.Cd_Promocao ,  ivs_promocao_sap ) Then 			
	If Long(ivs_promocao_sap)>0 Then 
		ivw_ParentWindow.ivb_Valida_Salva = False
   	   wf_desabilita_controles('S')
	Else
       	ivw_ParentWindow.ivb_Valida_Salva = True
   		wf_desabilita_controles('N')						
	End If
End If 
end event

event ue_preupdate;call super::ue_preupdate;Date lvdt_Alteracao

DateTime lvdh_Atual

Long lvl_Linha
Long lvl_Promocao
	  
dw_1.AcceptText()
dw_2.AcceptText()

lvdh_Atual = gvo_Parametro.of_Dh_Movimentacao()

lvdt_Alteracao = RelativeDate(Date(lvdh_Atual), 1)

lvl_Promocao = dw_1.Object.Cd_Promocao_SOS[1]

For lvl_Linha = 1 To This.RowCount()
	
	If IsNull(This.Object.cd_produto[lvl_Linha]) Then
		This.DeleteRow(lvl_Linha)
		Continue
	End If
	
	If IsNull(This.Object.Cd_Promocao_SOS[lvl_Linha]) Then
		This.Object.Cd_Promocao_SOS		[ lvl_Linha ] = lvl_Promocao
		This.Object.Dh_Alteracao  				[ lvl_Linha ] = lvdt_Alteracao
		This.Object.nr_matricula_alteracao	[ lvl_Linha ] = ivs_Responsavel
	Else
		If (This.Object.Pc_Desconto[lvl_Linha] <> This.Object.Pc_Desconto_Anterior[lvl_Linha]) Or &
			(This.Object.pc_desconto_clube[lvl_Linha] <> This.Object.pc_desconto_clube_anterior[lvl_Linha]) Then
				This.Object.Dh_Alteracao						[ lvl_Linha ] = lvdt_Alteracao
				This.Object.nr_matricula_alteracao			[ lvl_Linha ] = ivs_Responsavel
				This.Object.pc_desconto_clube_anterior		[ lvl_Linha ] = This.Object.pc_desconto_clube	[ lvl_Linha ]
				This.Object.Pc_Desconto_Anterior				[ lvl_Linha ] = This.Object.Pc_Desconto			[ lvl_Linha ]
		End If
	End If
Next

Return 1
end event

event getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
end event

event ue_key;String lvs_Coluna


If gf_promocao_sap ( ivo_Promocao.Cd_Promocao ,  ivs_promocao_sap ) Then 			
		If Long(ivs_promocao_sap)>0 Then 
			ivw_ParentWindow.ivb_Valida_Salva = False
	   	   wf_desabilita_controles('S')
		Else
	       	ivw_ParentWindow.ivb_Valida_Salva = True
	   		wf_desabilita_controles('N')						
				

				
			If Key = KeyEnter! Then
				lvs_Coluna = This.GetColumnName()

				Choose Case lvs_Coluna
					Case "de_produto"		
						wf_Localiza_Produto()	
						
					Case "pc_desconto_clube"
						This.Event ue_AddRow()
				End Choose
			End If
			
			If Key = KeyF2! Then
				Event ue_Simula_Precos()
			End If
			
			If Key = KeyF3! Then
				Event ue_Copia_Promocao()
			End If
			
			If Key = KeyF4! Then
				Event ue_Salva_Produtos_Excel()
			End If
			
			If Key = KeyF5! Then
				Event ue_Importa_Produtos_Excel()
			End If
			
			If Key = KeyF6! Then
				Event ue_Seleciona_Filial_Planilha()
			End If
			
			If Key = KeyF7! Then
				Event ue_Salva_Saldo_Produto_Excel()
			End If
				
		End If
	End If 



end event

event ue_preinsertrow;call super::ue_preinsertrow;If This.Find("isnull(cd_produto)", 1, This.RowCount()) > 0 Then
	Return -1
Else
	Return 1	
End If
end event

event constructor;call super::constructor;String lvs_Coluna[], &
       lvs_Nome[]
		 
lvs_Coluna = {"cd_produto", "de_produto", "pc_desconto"}

lvs_Nome = {"C$$HEX1$$f300$$ENDHEX$$digo", "Descri$$HEX2$$e700e300$$ENDHEX$$o", "Desconto (%)"}

This.of_SetSort(lvs_Coluna, lvs_Nome)

This.of_SetFilter(lvs_Coluna, lvs_Nome)

This.of_SetRowSelection()
end event

event ue_addrow;call super::ue_addrow;If AncestorReturnValue > 0 Then	
	This.ivo_Controle_Menu.of_Excluir(True)	
End If

Return AncestorReturnValue
end event

event ue_deleterow;call super::ue_deleterow;If AncestorReturnValue Then
	If This.RowCount() = 0 Then 
		This.ivo_Controle_Menu.of_Excluir(False)
	End If
End If

Return AncestorReturnValue
end event

event ue_postretrieve;call super::ue_postretrieve;ids.Reset()

If dw_2.RowCount() > 0 Then
	If dw_2.RowsCopy(1, dw_2.RowCount(), Primary!, ids, 1, Primary!) = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no RowsCopy.", StopSign!)
		Return -1
	End If
End If

Return pl_Linhas
end event

event itemchanged;call super::itemchanged;Choose Case dwo.name
	Case "pc_desconto"
		If Dec(data) < 0 Or Dec(data) > 100 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Desconto informado inv$$HEX1$$e100$$ENDHEX$$lido.",Exclamation!)
			This.Object.pc_desconto[ Row ] = 0.00
			Return 1
		End If
		
	Case "pc_desconto_clube"
		If Dec(data) < 0 Or Dec(data) > 100 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Desconto do clube inv$$HEX1$$e100$$ENDHEX$$lido.",Exclamation!)
			This.Object.pc_desconto_clube[ Row ] = 0.00
			Return 1
		End If	
		
End Choose
end event

type dw_7 from dc_uo_dw_base within w_ge347_cadastro_promocao_vinculada
boolean visible = false
integer x = 1723
integer y = 536
integer width = 274
integer height = 108
integer taborder = 60
boolean bringtotop = true
boolean enabled = false
string dataobject = "ds_ge347_saldo_produto"
end type

event ue_recuperar;//OverRide

Long lvl_Promocao

dw_1.AcceptText()

lvl_Promocao = dw_1.Object.cd_promocao_sos	[1]

Return Retrieve(lvl_Promocao)
end event

type dw_3 from dc_uo_dw_base within w_ge347_cadastro_promocao_vinculada
event ue_seleciona_filial ( long pl_filial,  boolean pb_selecao )
event ue_mousemove pbm_mousemove
integer x = 3534
integer y = 708
integer width = 1239
integer height = 1256
integer taborder = 50
string dataobject = "dw_ge347_filial"
boolean vscrollbar = true
end type

event ue_seleciona_filial(long pl_filial, boolean pb_selecao);Long lvl_Linha

lvl_Linha = dw_4.Find("cd_filial = " + String(pl_Filial), 1, dw_4.RowCount())

If lvl_Linha > 0 Then
	If pb_Selecao Then
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Filial '" + String(pl_Filial) + "' j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ selecionada.", StopSign!)
	Else
		dw_4.DeleteRow(lvl_Linha)
	End If
Else
	If pb_Selecao Then
		lvl_Linha = dw_4.InsertRow(0)			
		
		dw_4.Object.Cd_Filial[lvl_Linha] = pl_Filial
	Else
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Filial '" + String(pl_Filial) + "' n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ selecionada.", StopSign!)
	End If
End If

end event

event ue_mousemove;//If This.RowCount() > 0 Then
//	If xpos >= st_confirmar.X and (xpos <= st_confirmar.x + st_confirmar.Width) and &
//		  ypos >= 0 and ypos < 40 Then	 
//		
//		st_confirmar.Visible = True
//		
//		If ivb_Check Then
//			st_confirmar.Text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para desmarcar todos."
//		Else
//			st_confirmar.Text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para marcar todos."
//		End If
//	Else
//		st_confirmar.Visible = False
//	End If
//End If
end event

event itemchanged;call super::itemchanged;Boolean lvb_Selecao

If Data = "S" Then
	lvb_Selecao = True
Else
	lvb_Selecao = False
End If

This.Event ue_Seleciona_Filial(This.Object.Cd_Filial[Row], lvb_Selecao)


//If ivs_promocao_sap >0 Then 
//	Parent.ivb_Valida_Salva = False
//	Parent.ivm_Menu.mf_Confirmar(False)
//	Parent.ivm_Menu.mf_Cancelar(False)
//Else
//	Parent.ivb_Valida_Salva = True
//	Parent.ivm_Menu.mf_Confirmar(True)
//	Parent.ivm_Menu.mf_Cancelar(True)
//	
//End If
//

If gf_promocao_sap ( ivo_Promocao.Cd_Promocao ,  ivs_promocao_sap ) Then 			
	If Long(ivs_promocao_sap)>0 Then 
		ivw_ParentWindow.ivb_Valida_Salva = False
   	   wf_desabilita_controles('S')
	Else
       	ivw_ParentWindow.ivb_Valida_Salva = True
   		wf_desabilita_controles('N')						
	End If
End If 
end event

event getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
end event

event constructor;call super::constructor;ivb_Ordena_Colunas = True
end event

event doubleclicked;call super::doubleclicked;If dwo.Name = 'imagem' Then
	
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
		If This.Object.id_adm_sap[lvl_Row] = "N" Then 
			This.Object.Id_Filial[lvl_Row] = lvs_Marcacao
			 If lvs_Marcacao = "S" Then
				dw_3.Event ue_Seleciona_Filial(dw_3.Object.Cd_Filial[lvl_Row], True)
			Else
				dw_3.Event ue_Seleciona_Filial(dw_3.Object.Cd_Filial[lvl_Row], False)
			End If
		End If 
	Next
	
	Parent.ivb_Valida_Salva = True

	Parent.ivm_Menu.mf_Confirmar(True)
	Parent.ivm_Menu.mf_Cancelar(True)
End If
end event

event ue_key;call super::ue_key;
If gf_promocao_sap ( ivo_Promocao.Cd_Promocao ,  ivs_promocao_sap ) Then 			
	If Long(ivs_promocao_sap)>0 Then 
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Esta promocao foi cadastrada no SAP. N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitido realizar altera$$HEX2$$e700f500$$ENDHEX$$es, somente no SAP!.", Information!)
	Else      
		If Key = KeyF2! Then
			Event ue_Simula_Precos()
		End If
		
		If Key = KeyF3! Then
			Event ue_Copia_Promocao()
		End If
		
		If Key = KeyF4! Then
			Event ue_Salva_Produtos_Excel()
		End If
		
		If Key = KeyF5! Then
			Event ue_Importa_Produtos_Excel()
		End If
		
		If Key = KeyF6! Then
			Event ue_Seleciona_Filial_Planilha()
		End If
		
		If Key = KeyF7! Then
			Event ue_Salva_Saldo_Produto_Excel()
		End If
	End If
End If 
end event

type dw_8 from dc_uo_dw_base within w_ge347_cadastro_promocao_vinculada
event ue_seleciona_rede ( string ps_rede,  boolean pb_selecao )
integer x = 4059
integer y = 112
integer width = 663
integer height = 276
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge347_rede"
boolean vscrollbar = true
end type

event ue_seleciona_rede(string ps_rede, boolean pb_selecao);Long lvl_Linha

lvl_Linha = dw_9.Find("id_rede_filial = '" + ps_Rede + "'", 1, dw_9.RowCount())

If lvl_Linha > 0 Then
	If pb_Selecao Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A rede '" + ps_Rede + "' j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ selecionada.", StopSign!)
	Else
		dw_9.DeleteRow(lvl_Linha)
	End If
Else
	If pb_Selecao Then
		lvl_Linha = dw_9.InsertRow(0)			
		
		dw_9.Object.id_rede_filial[lvl_Linha] = ps_Rede
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Rede '" + ps_Rede + "' n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ selecionada.", StopSign!)
	End If
End If
end event

event itemchanged;call super::itemchanged;Boolean lvb_Selecao

If Data = "S" Then
	lvb_Selecao = True
Else
	lvb_Selecao = False
End If

This.Event ue_Seleciona_Rede(This.Object.id_rede_filial[Row], lvb_Selecao)


If gf_promocao_sap ( ivo_Promocao.Cd_Promocao ,  ivs_promocao_sap ) Then 			
	If Long(ivs_promocao_sap)>0 Then 
		ivw_ParentWindow.ivb_Valida_Salva = False
   	   wf_desabilita_controles('S')
	Else
       	ivw_ParentWindow.ivb_Valida_Salva = True
   		wf_desabilita_controles('N')						
	End If
End If 
end event

event ue_addrow;//OverRide

Return 1
end event

event ue_key;call super::ue_key;If gf_promocao_sap ( ivo_Promocao.Cd_Promocao ,  ivs_promocao_sap ) Then 			
	If Long(ivs_promocao_sap)>0 Then 
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Esta promocao foi cadastrada no SAP. N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitido realizar altera$$HEX2$$e700f500$$ENDHEX$$es, somente no SAP!.", Information!)
	Else      
		If Key = KeyF2! Then
			Event ue_Simula_Precos()
		End If
		
		If Key = KeyF3! Then
			Event ue_Copia_Promocao()
		End If
		
		If Key = KeyF4! Then
			Event ue_Salva_Produtos_Excel()
		End If
		
		If Key = KeyF5! Then
			Event ue_Importa_Produtos_Excel()
		End If
		
		If Key = KeyF6! Then
			Event ue_Seleciona_Filial_Planilha()
		End If
		
		If Key = KeyF7! Then
			Event ue_Salva_Saldo_Produto_Excel()
		End If
	End If
End If 
end event

type dw_9 from dc_uo_dw_base within w_ge347_cadastro_promocao_vinculada
boolean visible = false
integer x = 1422
integer y = 536
integer width = 274
integer height = 108
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge347_rede_cadastrada"
end type

event ue_recuperar;// Override
Long lvl_Promocao

lvl_Promocao = dw_1.Object.Cd_Promocao_SOS[1]

Return This.Retrieve(lvl_Promocao)
end event

event ue_preupdate;call super::ue_preupdate;Long lvl_Linha, &
     lvl_Promocao
	  
lvl_Promocao = dw_1.Object.Cd_Promocao_SOS[1]

For lvl_Linha = 1 To This.RowCount()
	If IsNull(This.Object.Cd_Promocao_SOS[lvl_Linha]) Then
		This.Object.Cd_Promocao_SOS[lvl_Linha] = lvl_Promocao
	End If
Next

Return 1
end event

event ue_postretrieve;call super::ue_postretrieve;Long 	lvl_Contador, &
     	lvl_Find
	  
String ls_Rede

For lvl_Contador = 1 To dw_8.RowCount()
	ls_Rede = dw_8.Object.id_rede_filial[lvl_Contador]
	
	If This.RowCount() > 0 Then
		lvl_Find = This.Find("id_rede_filial = '" + ls_Rede + "'", 1, This.RowCount())
		
		If lvl_Find < 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o da lista de redes liberadas.", StopSign!)
			Return pl_Linhas
		End If
	Else
		lvl_Find = 0
	End If
	
	If lvl_Find > 0 Then
		dw_8.Object.id_rede	[lvl_Contador] = "S"
	Else
		dw_8.Object.id_rede	[lvl_Contador] = "N"
	End If
Next

Return pl_Linhas
end event

event constructor;call super::constructor;ivi_Tipo_Cancelar = RETRIEVE
end event

type gb_3 from groupbox within w_ge347_cadastro_promocao_vinculada
integer x = 3502
integer y = 648
integer width = 1298
integer height = 1344
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Filiais"
borderstyle borderstyle = styleraised!
end type

type dw_1 from dc_uo_dw_base within w_ge347_cadastro_promocao_vinculada
integer x = 41
integer y = 64
integer width = 3968
integer height = 412
string dataobject = "dw_ge347_promocao"
end type

event constructor;call super::constructor;This.ivs_Coluna_Sem_Validacao_Salva = {"de_localizacao"}

This.of_SetColSelection(True)
end event

event editchanged;// Override

dw_1.AcceptText()

If Not This.of_Coluna_Sem_Validacao_Salva(dwo.Name) Then
	If ivb_UpdateAble Then
		
		If gf_promocao_sap ( ivo_Promocao.Cd_Promocao ,  ivs_promocao_sap ) Then 			
				If Long(ivs_promocao_sap)>0 Then 
		       	   	ivw_ParentWindow.ivb_Valida_Salva = False
					 wf_desabilita_controles('S')
				Else
				 	ivw_ParentWindow.ivb_Valida_Salva = True
					 wf_desabilita_controles('N')
				End If 
		End If 
		
		
		//Parent.ivm_Menu.mf_Confirmar(True)
		//Parent.ivm_Menu.mf_Cancelar(True)		
		
		//cb_exportar_saldo.Enabled = False
		
	End If
End If

If dwo.Name = "dh_inicio" Then
	If IsNull(dw_1.Object.Cd_Promocao_Sos[1]) Then
		If Not IsNull(Data) And IsDate(Data) Then
			dw_1.Object.Dh_Inicio_Estoque_Minimo		[1] = DateTime(RelativeDate(Date(dw_1.Object.Dh_Inicio		[1]), - 7))
		End If
	End If
End If

If dwo.Name = "dh_termino" Then
	If IsNull(dw_1.Object.Cd_Promocao_Sos[1]) Then
		If Not IsNull(Data) And IsDate(Data) Then
			dw_1.Object.Dh_Inicio_Estoque_Minimo		[1] = DateTime(RelativeDate(Date(dw_1.Object.Dh_Inicio		[1]), - 7))
			dw_1.Object.Dh_Termino_Estoque_Minimo	[1] = DateTime(RelativeDate(Date(dw_1.Object.Dh_Termino	[1]), - 7))
		End If
	End If
End If
end event

event ue_key;Boolean lb_Permite

String lvs_Promocao

If Key = KeyEnter! Then
	If This.GetColumnName() = "de_localizacao" Then
		lvs_Promocao = This.GetText()

		ivo_Promocao.of_Localiza(lvs_Promocao)

		If ivo_Promocao.Localizado Then
			
			// Redes da filial
			dw_8.Reset()
			dw_8.Event ue_Retrieve()
			
			If Not wf_Grava_Rede_liberada() Then Return
			
			This.Object.Cd_Promocao_SOS[1] = ivo_Promocao.Cd_Promocao
			
			If gf_promocao_sap ( ivo_Promocao.Cd_Promocao ,  ivs_promocao_sap ) Then 			
				If Long(ivs_promocao_sap)>0 Then 
					ivw_ParentWindow.ivb_Valida_Salva = False
		       	   wf_desabilita_controles('S')
				Else
		          	ivw_ParentWindow.ivb_Valida_Salva = True
				   wf_desabilita_controles('N')						
				End If
			End If 
			
			// Lista de filiais
			dw_3.Event ue_Retrieve()
						
			This.Event ue_Retrieve()
			
			If Not wf_verifica_usuario_alteracao(Ref lb_Permite) Then Return -1
		End If
	End If
End If

If Key = KeyF2! Then
	Event ue_Simula_Precos()
End If

If Key = KeyF3! Then
	Event ue_Copia_Promocao()
End If

If Key = KeyF4! Then
	Event ue_Salva_Produtos_Excel()
End If

If Key = KeyF5! Then
	Event ue_Importa_Produtos_Excel()
End If

If Key = KeyF6! Then
	Event ue_Seleciona_Filial_Planilha()
End If

If Key = KeyF7! Then
	Event ue_Salva_Saldo_Produto_Excel()
End If
end event

event ue_recuperar;// Override

Long lvl_Promocao

This.AcceptText()

lvl_Promocao = This.Object.Cd_Promocao_SOS[1]

If IsNull(lvl_Promocao) or lvl_Promocao = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione a promo$$HEX2$$e700e300$$ENDHEX$$o para recuperar as informa$$HEX2$$e700f500$$ENDHEX$$es.", Information!)
	Return -1
End If

Return This.Retrieve(lvl_Promocao)
end event

event ue_postretrieve;DateTime lvdh_Atual, &
         lvdh_Inicio, &
			lvdh_Termino

If pl_Linhas > 0 Then
	lvdh_Inicio  = This.Object.Dh_Inicio      			[1]
	lvdh_Termino = This.Object.Dh_Termino    		[1]
	lvdh_Atual   = This.Object.Dh_Movimentacao	[1]
	
	This.ivo_Controle_Menu.of_Excluir(True)
	This.ivo_Controle_Menu.of_Filtrar(True)
	This.ivo_Controle_Menu.of_Classificar(True)
	
	If lvdh_Inicio <= lvdh_Atual Then
		This.Object.Dh_Inicio.Protect = 1
		//dw_3.Object.Id_Filial.Protect = 1
		
		//cb_Selecao_Filial.Enabled = False
	Else
		This.Object.Dh_Inicio.Protect = 0
		dw_3.Object.Id_Filial.Protect = 0
		
		cb_Selecao_Filial.Enabled = True
	End If
	
	il_Ultimo_Vinc = 0
	
	wf_Carrega_Legenda(dw_1.Object.Id_Tipo_Replicacao[1])
	
	// Produtos
	dw_2.Event ue_Retrieve()
	
	// Grupos Vinculados
	dw_5.Event ue_Retrieve()
	
	// Filiais cadastradas
	dw_4.Event ue_Retrieve()
	
	// Rede cadastrada
	dw_9.Event ue_Retrieve()
	
	If This.Object.Id_Inclui_Estoque_Minimo[1] = "S" Then
		This.Object.Estoque_Minimo_t.Visible = True
	Else
		This.Object.Estoque_Minimo_t.Visible = False
	End If
	
	If lvdh_Atual > lvdh_Termino Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Esta promo$$HEX2$$e700e300$$ENDHEX$$o j$$HEX1$$e100$$ENDHEX$$ terminou, portanto nenhuma altera$$HEX2$$e700e300$$ENDHEX$$o poder$$HEX1$$e100$$ENDHEX$$ ser salva.")		
		
		This.Object.Id_Terminada[1] = "S"
	End If
		
	This.SetFocus()
	
Else
	
	This.ivo_Controle_Menu.of_Excluir(False)
	This.ivo_Controle_Menu.of_Filtrar(False)
	This.ivo_Controle_Menu.of_Classificar(False)
End If

Return pl_LInhas
end event

event ue_preretrieve;call super::ue_preretrieve;If wf_Valida_Salva() < 0 Then
	Return -1
Else
	Return 1
End If
end event

event ue_preinsertrow;call super::ue_preinsertrow;If wf_Valida_Salva() < 0 Then
	Return -1
Else
	This.Reset()
	Return 1
End If
end event

event getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
end event

event itemchanged;// Override

If Not This.of_Coluna_Sem_Validacao_Salva(dwo.Name) Then
	
	If gf_promocao_sap ( ivo_Promocao.Cd_Promocao ,  ivs_promocao_sap ) Then 			
		If Long(ivs_promocao_sap)>0 Then 
			ivw_ParentWindow.ivb_Valida_Salva = False
	   	   wf_desabilita_controles('S')
		Else
	       	ivw_ParentWindow.ivb_Valida_Salva = True
	   		wf_desabilita_controles('N')						
		End If
	End If 
	
	//Parent.ivm_Menu.mf_Confirmar(True)
	//Parent.ivm_Menu.mf_Cancelar(True)		
End If

If dwo.Name = 'id_tipo_replicacao' Then
	wf_Carrega_Legenda(Data)
End If
end event

event ue_deleterow;// OverRide

dw_2.SetFocus()

dw_2.Event ue_DeleteRow()

Return True


end event

event ue_preupdate;call super::ue_preupdate;This.Object.Nr_Matricula_Alteracao[1] = ivs_Responsavel

Return AncestorReturnValue
end event

event ue_addrow;call super::ue_addrow;If AncestorReturnValue > 0 Then
	This.Object.Dh_Inicio.Protect  		= 0
	This.Object.Dh_Termino.Protect 	= 0
	//This.Object.id_retira_venda_calculo_eb.Visible = 1
	
	il_Ultimo_Vinc = 0
	
	dw_3.Object.Id_Filial.Protect = 0
		
	cb_Selecao_Filial.Enabled = True
	
	Parent.ivb_Valida_Salva = False
		
	dw_2.Reset()
	dw_2.Event ue_AddRow()
	dw_3.Reset()
	dw_5.Reset()
	dw_3.Event ue_Retrieve()
	dw_8.Event ue_Retrieve()
	dw_4.Reset()
	dw_9.Reset()
	
	This.Object.Estoque_Minimo_t.Visible = False
	
	Parent.ivm_Menu.mf_Confirmar(False)
	Parent.ivm_Menu.mf_Cancelar(False)
	
	wf_Carrega_Legenda(This.Object.Id_Tipo_Replicacao[1])
	
	dw_1.SetFocus()
End If

Return AncestorReturnValue
end event

type dw_5 from dc_uo_dw_base within w_ge347_cadastro_promocao_vinculada
integer x = 2089
integer y = 704
integer width = 1367
integer height = 1276
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge347_grupo_vinculado"
boolean vscrollbar = true
end type

event ue_recuperar;//Override
Long lvl_Promocao

dw_1.AcceptText()

lvl_Promocao = dw_1.Object.Cd_Promocao_SOS[1]

Return This.Retrieve(lvl_Promocao)
end event

event ue_preinsertrow;call super::ue_preinsertrow;This.AcceptText()

If This.RowCount() > 0 Then
	If IsNull(This.Object.De_Vinculo[This.RowCount()]) Then
		Return -1
	End If
End If

Return 1
end event

event constructor;call super::constructor;This.of_SetRowSelection()
end event

event ue_predeleterow;call super::ue_predeleterow;Long ll_Promocao
Long ll_Vinculo
Long ll_Qtd
Long ll_Qt_Prd

String ls_Chave
String ls_Nulo
String ls_Erro
String ls_Vinculo

This.AcceptText()

If AncestorReturnValue Then
	If This.RowCount() > 0 Then
		
		ll_Vinculo = This.Object.Nr_Vinculo[This.GetRow()]
		
		If IsNull(ll_Vinculo) Or ll_Vinculo = 0 Then Return AncestorReturnValue
		
		ll_Promocao	= This.Object.Cd_Promocao_Sos	[This.GetRow()]
		ls_Vinculo	= This.Object.De_Vinculo			[This.GetRow()]
		ll_Qtd			= This.Object.Qt_Vinculo				[This.GetRow()]		
		
		Select Count(*)
			Into :ll_Qt_Prd
		From promocao_sos_vinculo_prd
		Where cd_promocao_sos = :ll_Promocao
			And nr_vinculo = :ll_Vinculo
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			ls_Erro = SqlCa.SqlErrText
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao excluir verificar se existem produtos no v$$HEX1$$ed00$$ENDHEX$$nculo. " + ls_Erro, StopSign!)
			Return False
		End If
		
		If ll_Qt_Prd > 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Os produtos devem ser exclu$$HEX1$$ed00$$ENDHEX$$dos antes de excluir o v$$HEX1$$ed00$$ENDHEX$$nculo.~r~rUtilize o bot$$HEX1$$e300$$ENDHEX$$o [Editar Prd.] para excluir os produtos.", Exclamation!)
			This.Event ue_Pos(This.GetRow(), "de_vinculo")
			Return False
		End If
		
		ls_Chave = MidA(String(ll_Promocao) + Space(5), 1, 5) + "@#!" + String(ll_Vinculo)
	
		If Not gf_Grava_Historico_Alteracao_Tabela('PROMOCAO_SOS_VINCULO', ls_Chave, 'DT_VINCULO', ls_Vinculo, ls_Nulo, gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, 'E', Ref ls_Erro, True) Then
			Return False
		End If
		
		If Not gf_Grava_Historico_Alteracao_Tabela('PROMOCAO_SOS_VINCULO', ls_Chave, 'QT_VINCULO', String(ll_Qtd), ls_Nulo, gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, 'E', Ref ls_Erro, True) Then
			Return False
		End If
		
//		If Not wf_Deleta_Prd_Vinculado(ll_Promocao, ll_Vinculo) Then Return False
	End If
End If

Return AncestorReturnValue
end event

event editchanged;call super::editchanged;//Parent.ivm_Menu.mf_Confirmar(True)
//Parent.ivm_Menu.mf_Cancelar(True)
//



If gf_promocao_sap ( ivo_Promocao.Cd_Promocao ,  ivs_promocao_sap ) Then 			
	If Long(ivs_promocao_sap)>0 Then 
		ivw_ParentWindow.ivb_Valida_Salva = False
   	   wf_desabilita_controles('S')
	Else
       	ivw_ParentWindow.ivb_Valida_Salva = True
   		wf_desabilita_controles('N')						
	End If
End If 
end event

event ue_preupdate;call super::ue_preupdate;Long ll_Find
Long ll_Promocao
Long ll_Linha
Long ll_Vinculo
Long ll_De
Long ll_Qtd

String ls_Nulo
String ls_Chave
String ls_Erro
String ls_Para
String ls_De
String ls_Vinculo

dw_1.AcceptText()
This.AcceptText()

ll_Promocao = dw_1.Object.Cd_Promocao_Sos[1]

SetNull(ls_Nulo)

For ll_Linha = 1 To This.RowCount()
	
	If IsNull(This.Object.Cd_Promocao_Sos[ll_Linha]) Then
		This.Object.Cd_Promocao_Sos[ll_Linha] = ll_Promocao
	End If
	
	ll_Vinculo = This.Object.Nr_Vinculo[ll_Linha]
	
	//Inclus$$HEX1$$e300$$ENDHEX$$o
	If IsNull(ll_Vinculo) Or ll_Vinculo = 0 Then
		If il_Ultimo_Vinc = 0 Or IsNull(il_Ultimo_Vinc) Then
			If Not wf_Proximo_Vinculo(ll_Promocao) Then Return -1
		End If
		
		il_Ultimo_Vinc++
		
		ll_Vinculo = il_Ultimo_Vinc
		
		This.Object.Nr_Vinculo[ll_Linha] = ll_Vinculo
		
		ls_Vinculo	= This.Object.De_Vinculo[ll_Linha]
		ll_Qtd			= This.Object.Qt_Vinculo	[ll_Linha]
		
		ls_Chave = MidA(String(ll_Promocao) + Space(5), 1, 5) + "@#!" + String(ll_Vinculo)
		
		If Not gf_Grava_Historico_Alteracao_Tabela('PROMOCAO_SOS_VINCULO', ls_Chave, 'DE_VINCULO', ls_Nulo, ls_Vinculo, gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, 'I', Ref ls_Erro, True) Then
			Return -1
		End If
		
		If Not gf_Grava_Historico_Alteracao_Tabela('PROMOCAO_SOS_VINCULO', ls_Chave, 'QT_VINCULO', ls_Nulo, String(ll_Qtd), gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, 'I', Ref ls_Erro, True) Then
			Return -1
		End If
	End If
	
	//Altera$$HEX2$$e700e300$$ENDHEX$$o
	If Not IsNull(ll_Vinculo) And ll_Vinculo > 0 Then
		If (gf_Houve_Alteracao_Dw(This, 'DE_VINCULO', ll_Linha, Ref ls_Para)) Or (gf_Houve_Alteracao_Dw(This, 'QT_VINCULO', ll_Linha, Ref ls_Para)) Then
					
			ls_Chave = MidA(String(ll_Promocao) + Space(5), 1, 5) + "@#!" + String(ll_Vinculo)
			
			If Not wf_Valor_Inicial(ll_Promocao, ll_Vinculo, Ref ls_De, Ref ll_De) Then Return -1
		
			If gf_Houve_Alteracao_Dw(This, 'DE_VINCULO', ll_Linha, Ref ls_Para) Then
				If Not gf_Grava_Historico_Alteracao_Tabela('PROMOCAO_SOS_VINCULO', ls_Chave, 'DE_VINCULO', ls_De, ls_Para, gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, 'A', Ref ls_Erro, True) Then
					Return -1
				End If
			End If
			
			If gf_Houve_Alteracao_Dw(This, 'QT_VINCULO', ll_Linha, Ref ls_Para) Then
				If Not gf_Grava_Historico_Alteracao_Tabela('PROMOCAO_SOS_VINCULO', ls_Chave, 'QT_VINCULO', String(ll_De), ls_Para, gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, 'A', Ref ls_Erro, True) Then
					Return -1
				End If
			End If
		End If
	End If
Next

Return 1
end event

event ue_key;call super::ue_key;If gf_promocao_sap ( ivo_Promocao.Cd_Promocao ,  ivs_promocao_sap ) Then 			
	If Long(ivs_promocao_sap)>0 Then 
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Esta promocao foi cadastrada no SAP. N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitido realizar altera$$HEX2$$e700f500$$ENDHEX$$es, somente no SAP!.", Information!)
	Else      
		If Key = KeyF2! Then
			Event ue_Simula_Precos()
		End If
		
		If Key = KeyF3! Then
			Event ue_Copia_Promocao()
		End If
		
		If Key = KeyF4! Then
			Event ue_Salva_Produtos_Excel()
		End If
		
		If Key = KeyF5! Then
			Event ue_Importa_Produtos_Excel()
		End If
		
		If Key = KeyF6! Then
			Event ue_Seleciona_Filial_Planilha()
		End If
		
		If Key = KeyF7! Then
			Event ue_Salva_Saldo_Produto_Excel()
		End If
	End If
End If 
end event

type cb_1 from commandbutton within w_ge347_cadastro_promocao_vinculada
integer x = 2089
integer y = 532
integer width = 421
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Inserir Grupo"
end type

event clicked;dw_5.Event ue_AddRow()
end event

type cb_2 from commandbutton within w_ge347_cadastro_promocao_vinculada
integer x = 3054
integer y = 532
integer width = 421
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Editar Prd."
end type

event clicked;Boolean lb_Permite

Long ll_Promocao
Long ll_Vinculo

String ls_Parametro
String ls_Retorno
String ls_Permite

dw_1.AcceptText()
dw_5.AcceptText()

ll_Promocao	= dw_1.Object.Cd_Promocao_Sos[1]

If IsNull(ll_Promocao) Or ll_Promocao = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Salve a promo$$HEX2$$e700e300$$ENDHEX$$o antes de continuar.")
	dw_1.Event ue_Pos(1, "nm_promocao_sos")
	Return -1
End If

If dw_2.RowCount() = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existem produtos para a promo$$HEX2$$e700e300$$ENDHEX$$o.")
	dw_2.SetFocus()
	Return -1
End If

If dw_5.RowCount() = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existe nenhum grupo para ser editado.")
	dw_5.SetFocus()
	Return -1
End If

ll_Vinculo = dw_5.Object.Nr_Vinculo[dw_5.GetRow()]

If dw_5.RowCount() = 0 Or ll_Vinculo = 0 Or IsNull(ll_Vinculo) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Salve a promo$$HEX2$$e700e300$$ENDHEX$$o antes de continuar.")
	dw_5.SetFocus()
	Return -1
End If

If Not wf_Verifica_Usuario_Alteracao(Ref lb_Permite) Then Return -1

If lb_Permite Then
	ls_Permite = "S"
Else
	ls_Permite = "N"
End If

//Se for promo$$HEX2$$e700e300$$ENDHEX$$o SAP permite apenas visualiza$$HEX2$$e700e300$$ENDHEX$$o.
if not isnull(ivs_promocao_sap) and ivs_promocao_sap <> '' Then
	ls_permite = 'N'
end if

If ll_Vinculo > 0 Then
	
	str_ge347_promocao st
	
	st.Id_Permite = ls_Permite
	st.Cd_Promocao_Sos = ll_Promocao
	st.Nr_Vinculo = ll_Vinculo

	//ls_Parametro = ls_Permite + String(ll_Promocao, "00000") + String(ll_Vinculo)
	
	OpenWithParm(w_ge347_produto_vinculado, st)
	
	ls_Retorno = Message.StringParm
	
	If ls_Retorno= "OK" Then
		dw_5.Event ue_Retrieve()
	End If
End If
end event

type cb_3 from commandbutton within w_ge347_cadastro_promocao_vinculada
integer x = 2574
integer y = 532
integer width = 421
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Excluir Grupo"
end type

event clicked;If dw_5.RowCount() = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existe nenhum grupo para ser exclu$$HEX1$$ed00$$ENDHEX$$do.")
	dw_5.SetFocus()
	Return -1
End If

dw_5.Event ue_DeleteRow()
end event

type st_1 from statictext within w_ge347_cadastro_promocao_vinculada
integer x = 87
integer y = 2020
integer width = 992
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 128
long backcolor = 67108864
string text = "Simula Pre$$HEX1$$e700$$ENDHEX$$os dos Produtos [F2]"
boolean focusrectangle = false
end type

type st_2 from statictext within w_ge347_cadastro_promocao_vinculada
integer x = 1285
integer y = 2020
integer width = 914
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 128
long backcolor = 67108864
string text = "Copia de Outra Promo$$HEX2$$e700e300$$ENDHEX$$o [F3]"
boolean focusrectangle = false
end type

type st_3 from statictext within w_ge347_cadastro_promocao_vinculada
integer x = 2624
integer y = 2020
integer width = 896
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 128
long backcolor = 67108864
string text = "Salva Produtos em Excel [F4]"
boolean focusrectangle = false
end type

type st_4 from statictext within w_ge347_cadastro_promocao_vinculada
integer x = 3749
integer y = 2020
integer width = 974
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 128
long backcolor = 67108864
string text = "Importa Produtos via Excel [F5]"
boolean focusrectangle = false
end type

type st_5 from statictext within w_ge347_cadastro_promocao_vinculada
integer x = 87
integer y = 2116
integer width = 933
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 128
long backcolor = 67108864
string text = "Seleciona Filiais via Excel [F6]"
boolean focusrectangle = false
end type

type st_6 from statictext within w_ge347_cadastro_promocao_vinculada
integer x = 1285
integer y = 2116
integer width = 1202
integer height = 64
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 128
long backcolor = 67108864
string text = "Salva Saldo dos Produtos em Excel [F7]"
boolean focusrectangle = false
end type

type cb_4 from commandbutton within w_ge347_cadastro_promocao_vinculada
integer x = 3538
integer y = 532
integer width = 622
integer height = 100
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Cadastrar Promo$$HEX2$$e700f500$$ENDHEX$$es"
end type

event clicked;String ls_Responsavel

If ivb_Valida_Salva Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existem altera$$HEX2$$e700f500$$ENDHEX$$es pendentes. Verifique antes de prosseguir")
	Return -1
End If

If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("GE347_PROMOCAO_AUTOMATICA", Ref ls_Responsavel) Then Return

OpenWithParm(w_ge347_cadastro_promo_automatica, "")
end event

type gb_4 from groupbox within w_ge347_cadastro_promocao_vinculada
integer x = 2066
integer y = 648
integer width = 1413
integer height = 1344
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Grupos Vinculados"
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within w_ge347_cadastro_promocao_vinculada
integer x = 27
integer width = 4773
integer height = 504
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Promo$$HEX2$$e700e300$$ENDHEX$$o"
borderstyle borderstyle = styleraised!
end type

