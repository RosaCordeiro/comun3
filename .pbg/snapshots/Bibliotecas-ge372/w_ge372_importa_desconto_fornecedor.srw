HA$PBExportHeader$w_ge372_importa_desconto_fornecedor.srw
forward
global type w_ge372_importa_desconto_fornecedor from dc_w_response
end type
type gb_1 from groupbox within w_ge372_importa_desconto_fornecedor
end type
type dw_1 from dc_uo_dw_base within w_ge372_importa_desconto_fornecedor
end type
type cb_confirma from commandbutton within w_ge372_importa_desconto_fornecedor
end type
type cb_cancela from commandbutton within w_ge372_importa_desconto_fornecedor
end type
end forward

global type w_ge372_importa_desconto_fornecedor from dc_w_response
integer width = 2505
integer height = 1608
string title = "GE372 - Importa Desconto de Fornecedor"
long backcolor = 80269524
gb_1 gb_1
dw_1 dw_1
cb_confirma cb_confirma
cb_cancela cb_cancela
end type
global w_ge372_importa_desconto_fornecedor w_ge372_importa_desconto_fornecedor

forward prototypes
public function boolean wf_seleciona_arquivo (ref string as_arquivo)
public subroutine wf_importa_arquivo (string as_arquivo)
public function boolean wf_localiza_produto (any an_codigo, ref long al_produto, ref string as_descricao, ref string as_apresentacao, ref string as_mensagem, ref decimal adc_desconto_fornecedor)
public function boolean wf_existe_alteracao ()
end prototypes

public function boolean wf_seleciona_arquivo (ref string as_arquivo);String lvs_Arquivo
		 
Integer lvi_Retorno

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Os Dados devem estar da seguinte forma:~r~r" + &
                     "Coluna A = C$$HEX1$$f300$$ENDHEX$$digo do Produto ou C$$HEX1$$f300$$ENDHEX$$digo de Barras~r"     + &
					 "Coluna B = Desconto~r")

lvi_Retorno = GetFileOpenName("Selecione o Arquivo", as_Arquivo, lvs_Arquivo, "XLS", "Excel (*.XLS),*.XLS,")

If lvi_Retorno = 1 Then	Return True

If lvi_Retorno = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Ocorreu um erro na sele$$HEX2$$e700e300$$ENDHEX$$o do arquivo.", StopSign!)
End If

Return False
end function

public subroutine wf_importa_arquivo (string as_arquivo);Any lva_Dado

String lvs_Descricao, &
	   lvs_Apresentacao,&
	   lvs_Erro,&
	   lvs_Alterar,&
	   lvs_Mensagem

Long lvl_Linha, &
     lvl_Produto,&
	 lvl_Linhas,&
	 lvl_Insert
	  
Decimal{2} lvdc_Desconto_Novo,&
		   lvdc_Desconto_Atual

dw_1.Reset()

dc_uo_excel lvo_Excel

lvo_Excel = Create dc_uo_excel

SetPointer(HourGlass!)
Open(w_Aguarde)
w_Aguarde.Title = "Importando o Arquivo..."

// Refer$$HEX1$$ea00$$ENDHEX$$ncia o arquivo 
If ( lvo_Excel.uo_Referencia_Objeto_Excel(as_Arquivo) ) Then
	// Coluna de Refer$$HEX1$$ea00$$ENDHEX$$ncia
	lvl_Linhas = lvo_Excel.uo_Verifica_Tamanho_Arquivo("A") 
End If
		
If lvl_Linhas > 0 Then

	w_Aguarde.uo_Progress.of_SetMax(lvl_Linhas)
	
	dw_1.SetRedRaw(False)
	
	For lvl_Linha = 1 To lvl_Linhas
		
		lvs_Alterar  = "N"
		lvs_Erro	 = "N"
		lvs_Mensagem = ""
		
		// Produto
		lva_Dado    = lvo_Excel.uo_Lendo_Dados(lvl_Linha, "A")
					
		If Not wf_Localiza_Produto(lva_Dado,&
								   Ref lvl_Produto,&
								   Ref lvs_Descricao,&
								   Ref lvs_Apresentacao,&
								   Ref lvs_Mensagem,&
								   Ref lvdc_Desconto_Atual) Then
			lvs_Erro = "S"
		Else
			lvs_Alterar = "S"
		End If
								
		// Desconto
		lva_Dado      	   = lvo_Excel.uo_Lendo_Dados(lvl_Linha, "B")
		lvdc_Desconto_Novo = Dec(lva_Dado)
		
		If IsNull(lvdc_Desconto_Novo) Then lvdc_Desconto_Novo = 0

		lvl_Insert = dw_1.InsertRow(0)
		
		If lvs_Mensagem  <> '' Then
			dw_1.Object.de_produto[lvl_Insert] = lvs_Mensagem
		Else
			dw_1.Object.de_produto[lvl_Insert] = lvs_Descricao + " : " + lvs_Apresentacao
		End If
		
		dw_1.Object.Cd_Produto       [lvl_Insert] = lvl_Produto
		dw_1.Object.pc_desconto_atual[lvl_Insert] = lvdc_Desconto_Atual
		dw_1.Object.pc_desconto_novo [lvl_Insert] = lvdc_Desconto_Novo
		dw_1.Object.id_atualizar	 [lvl_Insert] = lvs_Alterar
		dw_1.Object.id_erro			 [lvl_Insert] = lvs_Erro
				
		w_Aguarde.uo_Progress.of_SetProgress(lvl_Linha)
	Next
				
	dw_1.Sort()
	dw_1.GroupCalc()
	
	dw_1.SetRedRaw(True)
End If

Destroy(lvo_Excel)

Close(w_Aguarde)

SetPointer(Arrow!)
end subroutine

public function boolean wf_localiza_produto (any an_codigo, ref long al_produto, ref string as_descricao, ref string as_apresentacao, ref string as_mensagem, ref decimal adc_desconto_fornecedor);Boolean lvb_Sucesso = False

Long lvl_Produto 

String lvs_Barras

// Se for o c$$HEX1$$f300$$ENDHEX$$digo interno
If LenA(String(an_Codigo)) <= 6 Then
	
	lvl_Produto = Long(an_Codigo)
	
	Select g.cd_produto,
		   g.de_produto,
		   g.de_apresentacao_estoque,
		   c.pc_desconto_fornecedor
	Into :al_Produto,
		 :as_Descricao,
		 :as_Apresentacao,
		 :adc_desconto_fornecedor
	From produto_geral g,
		 produto_central c
	Where g.cd_produto = :lvl_Produto
	  and g.cd_produto = c.cd_produto
	Using SqlCa;
Else
	// C$$HEX1$$f300$$ENDHEX$$digo de barras
	lvs_Barras = String(an_Codigo)
	
	Select g.cd_produto,
		   g.de_produto,
		   g.de_apresentacao_estoque,
		   c.pc_desconto_fornecedor
	Into :al_Produto,
		 :as_Descricao,
		 :as_Apresentacao,
		 :adc_desconto_fornecedor
	From produto_geral g,
		 produto_central c
	Where g.cd_produto in (Select cd_produto 
						   From codigo_barras_produto
						   Where de_codigo_barras = :lvs_Barras)
	  and g.cd_produto	= c.cd_produto
	Using SqlCa;
End If

Choose Case SqlCa.SqlCode
	Case 0
		lvb_Sucesso = True
	Case 100
	     as_Mensagem = Upper("Produto '" + String(an_Codigo) + "' n$$HEX1$$e300$$ENDHEX$$o foi localizado.")
	Case -1
		 SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do produto")
End Choose

Return lvb_Sucesso
end function

public function boolean wf_existe_alteracao ();If dw_1.Find("id_atualizar = 'S'", 1, dw_1.RowCount()) > 0 Then
	Return True
Else
	Return False
End If


end function

on w_ge372_importa_desconto_fornecedor.create
int iCurrent
call super::create
this.gb_1=create gb_1
this.dw_1=create dw_1
this.cb_confirma=create cb_confirma
this.cb_cancela=create cb_cancela
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.cb_confirma
this.Control[iCurrent+4]=this.cb_cancela
end on

on w_ge372_importa_desconto_fornecedor.destroy
call super::destroy
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.cb_confirma)
destroy(this.cb_cancela)
end on

event ue_postopen;call super::ue_postopen;String lvs_Arquivo

If wf_Seleciona_Arquivo(Ref lvs_Arquivo) Then
	wf_Importa_Arquivo(lvs_Arquivo)
End If
end event

type pb_help from dc_w_response`pb_help within w_ge372_importa_desconto_fornecedor
end type

type gb_1 from groupbox within w_ge372_importa_desconto_fornecedor
integer x = 23
integer y = 12
integer width = 2427
integer height = 1356
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
string text = "Lista de Produtos"
borderstyle borderstyle = styleraised!
end type

type dw_1 from dc_uo_dw_base within w_ge372_importa_desconto_fornecedor
integer x = 55
integer y = 64
integer width = 2373
integer height = 1268
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge372_lista_importacao"
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.of_SetRowSelection("", "if(id_erro = ~"N~", rgb(0,0,0), rgb(255,0,0))")
end event

event itemchanged;call super::itemchanged;String lvs_Erro

If dwo.Name = "id_atualizar" Then
	lvs_Erro = This.Object.Id_Erro[Row]
	
	If Data = "S" and lvs_Erro = "S" Then
		Return 1
	End If
End If

end event

event ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	//dw_1.SetSort("1A")
	dw_1.Sort()
	dw_1.GroupCalc()
End If

Return pl_Linhas
end event

type cb_confirma from commandbutton within w_ge372_importa_desconto_fornecedor
integer x = 1719
integer y = 1392
integer width = 366
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Con&firmar"
end type

event clicked;Boolean lvb_Sucesso = True

Long lvl_Linha,&
	 lvl_Linhas,&
	 lvl_Produto,&
	 lvl_Contador
	 
Decimal{2} lvdc_Desconto_Atual,&
		   lvdc_Desconto_Novo

String lvs_Atualizar

dw_1.AcceptText()

lvl_Linhas = dw_1.RowCount()

If Not wf_Existe_Alteracao() Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione pelo menos um produto.")
	Return
End If

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a altera$$HEX2$$e700e300$$ENDHEX$$o dos descontos ?", Question!, YesNo!, 2) = 2 Then
	Return
End If

SetPointer(HourGlass!)
Open(w_Aguarde)
w_Aguarde.Title = "Alterando os Produtos..."

w_Aguarde.uo_Progress.of_SetMax(lvl_Linhas)

For lvl_Linha = 1 To lvl_Linhas
	
	lvs_Atualizar = dw_1.Object.id_atualizar[lvl_Linha]
	
	If lvs_Atualizar = "S" Then
		
		lvl_Produto 		= dw_1.Object.cd_produto	   [lvl_Linha]
		lvdc_Desconto_Atual = dw_1.Object.pc_desconto_atual[lvl_Linha]
		lvdc_Desconto_Novo  = dw_1.Object.pc_desconto_novo [lvl_Linha]
		
		If lvdc_Desconto_Novo <> lvdc_Desconto_Atual Then
			
			Update produto_central
			Set pc_desconto_fornecedor = :lvdc_Desconto_Novo
			Where cd_produto = :lvl_Produto
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				SqlCa.of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do Desconto do Fornecedor")
				lvb_Sucesso = False
				Exit
			End If
		End If
	End If
	
	w_Aguarde.uo_Progress.of_SetProgress(lvl_Linha)
Next

Close(w_Aguarde)

If lvb_Sucesso Then
	SqlCa.of_Commit();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Os produtos foram alterados com sucesso.")
	SetPointer(Arrow!)
	Close(Parent)
Else
	SqlCa.of_RollBack();
End If

SetPointer(Arrow!)







end event

type cb_cancela from commandbutton within w_ge372_importa_desconto_fornecedor
integer x = 2117
integer y = 1392
integer width = 334
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Cancelar"
end type

event clicked;Close(Parent)
end event

