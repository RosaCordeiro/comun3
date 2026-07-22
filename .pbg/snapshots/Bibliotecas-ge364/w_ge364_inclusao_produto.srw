HA$PBExportHeader$w_ge364_inclusao_produto.srw
forward
global type w_ge364_inclusao_produto from dc_w_response
end type
type cb_5 from commandbutton within w_ge364_inclusao_produto
end type
type cb_4 from commandbutton within w_ge364_inclusao_produto
end type
type cb_3 from commandbutton within w_ge364_inclusao_produto
end type
type cb_2 from commandbutton within w_ge364_inclusao_produto
end type
type cb_1 from commandbutton within w_ge364_inclusao_produto
end type
type dw_2 from dc_uo_dw_base within w_ge364_inclusao_produto
end type
type dw_1 from dc_uo_dw_base within w_ge364_inclusao_produto
end type
type gb_1 from groupbox within w_ge364_inclusao_produto
end type
type gb_2 from groupbox within w_ge364_inclusao_produto
end type
end forward

global type w_ge364_inclusao_produto from dc_w_response
string tag = "GE364 - Libera Transfer$$HEX1$$ea00$$ENDHEX$$ncia de Produtos ao Estoque Central"
integer width = 2130
string title = "GE364 - Libera Transfer$$HEX1$$ea00$$ENDHEX$$ncia de Produtos ao Estoque Central"
cb_5 cb_5
cb_4 cb_4
cb_3 cb_3
cb_2 cb_2
cb_1 cb_1
dw_2 dw_2
dw_1 dw_1
gb_1 gb_1
gb_2 gb_2
end type
global w_ge364_inclusao_produto w_ge364_inclusao_produto

type variables
uo_Produto ivo_Produto

Boolean ivb_Existe_Produto
end variables

forward prototypes
public function boolean wf_existe_produto (long pl_produto)
end prototypes

public function boolean wf_existe_produto (long pl_produto);DateTime ldh_Termino
			
Select l.dh_termino_vigencia
 into	:ldh_Termino
From produto_liberado_transf_perini l
Where l.cd_produto = :pl_Produto
Using SqlCa;

Choose Case SqlCa.SqlCode
		
	Case 0
				
		Return True
		
	Case 100
		Return False
	Case -1
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Produto '" + String(pl_Produto) + "'")
		Return False
End Choose
end function

on w_ge364_inclusao_produto.create
int iCurrent
call super::create
this.cb_5=create cb_5
this.cb_4=create cb_4
this.cb_3=create cb_3
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_2=create dw_2
this.dw_1=create dw_1
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_5
this.Control[iCurrent+2]=this.cb_4
this.Control[iCurrent+3]=this.cb_3
this.Control[iCurrent+4]=this.cb_2
this.Control[iCurrent+5]=this.cb_1
this.Control[iCurrent+6]=this.dw_2
this.Control[iCurrent+7]=this.dw_1
this.Control[iCurrent+8]=this.gb_1
this.Control[iCurrent+9]=this.gb_2
end on

on w_ge364_inclusao_produto.destroy
call super::destroy
destroy(this.cb_5)
destroy(this.cb_4)
destroy(this.cb_3)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event ue_postopen;call super::ue_postopen;ivo_Produto = Create uo_Produto 

dc_uo_dw_Base lvo_Update[]
lvo_Update = {dw_2}
This.wf_SetUpdate_DW(lvo_Update)

Dw_1.Event ue_AddRow()
Dw_2.Event ue_AddRow()

dw_1.Object.dt_Inicio 	[1] = gvo_Parametro.of_Dh_Movimentacao()
dw_1.Object.dt_termino 	[1] = DateTime(RelativeDate(Date(gvo_Parametro.of_Dh_Movimentacao()), 2))


end event

event close;call super::close;Destroy (ivo_Produto)
end event

type pb_help from dc_w_response`pb_help within w_ge364_inclusao_produto
end type

type cb_5 from commandbutton within w_ge364_inclusao_produto
integer x = 1824
integer y = 104
integer width = 265
integer height = 100
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "E&xcluir"
end type

event clicked;If dw_2.GetRow() < 1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Selecione uma linha para ser exclu$$HEX1$$ed00$$ENDHEX$$da.")
	Return -1
Else
	Dw_2.DeleteRow(dw_2.GetRow())
End If

end event

type cb_4 from commandbutton within w_ge364_inclusao_produto
integer x = 1550
integer y = 104
integer width = 265
integer height = 100
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Incluir"
end type

event clicked;If dw_2.Find("isnull(cd_produto)", 1, dw_2.RowCount()) > 0 Then
	Return -1
Else
	Dw_2.Event ue_AddRow()
End If
end event

type cb_3 from commandbutton within w_ge364_inclusao_produto
integer x = 1262
integer y = 1140
integer width = 402
integer height = 100
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Confirmar"
end type

event clicked;Long lvl_Linha
Long lvl_Find
Long lvl_Produto

DateTime ldh_Inicio
DateTime ldh_Termino

String ls_Erro
String ls_Nulo

dw_1.AcceptText()
dw_2.AcceptText()

ldh_Inicio		=	dw_1.Object.dt_inicio 	[1] 
ldh_Termino	=	dw_1.Object.dt_termino 	[1]

If IsNull( ldh_Inicio ) Or IsNull( ldh_Termino ) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio e de t$$HEX1$$e900$$ENDHEX$$rmino para a vig$$HEX1$$ea00$$ENDHEX$$ncia do(s) produto(s).")
	dw_1.Event ue_Pos(1,"dt_inicio")
	Return -1
End If

lvl_Find = dw_2.Find("isnull(cd_produto)", 1, dw_2.RowCount())
If lvl_Find > 0 Then dw_2.DeleteRow(lvl_Find)

If dw_2.RowCount() = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum produto informado.")
	Return -1
End If

//Verifica se j$$HEX1$$e100$$ENDHEX$$ esta na tabela "produto_liberado_transf_perini"
For lvl_Linha = 1 To dw_2.RowCount()
					
	lvl_Produto = dw_2.Object.cd_produto[lvl_Linha]

	If wf_Existe_Produto(lvl_Produto) Then
		ivb_Existe_Produto = True
	Else
		ivb_Existe_Produto = False
	End If
	
	If ivb_Existe_Produto = True Then 
		
		Update produto_liberado_transf_perini
			Set dh_inicio_vigencia = :ldh_Inicio,  dh_termino_vigencia = :ldh_Termino
		 Where cd_produto = :lvl_Produto
  		Using SqlCa;
		  
	Else
		
		Insert Into produto_liberado_transf_perini
			Values( :lvl_Produto, :ldh_Inicio, :ldh_Termino )
		 Using SqlCa;
				
	End If
		
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_Rollback();
		SqlCa.of_MsgDbError("Erro ao atualizar o produto '" + String( lvl_Produto ))
		Return -1
	Else
		If ivb_Existe_Produto = True Then
			If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_LIBERADO_TRANSF_PERINI', String(lvl_Produto), 'DH_INICIO_VIGENCIA', ls_Nulo, String(ldh_Inicio), gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, 'A', Ref ls_Erro, True) Then Return -1
			If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_LIBERADO_TRANSF_PERINI', String(lvl_Produto), 'DH_TERMINO_VIGENCIA', ls_Nulo, String(ldh_Termino), gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, 'A', Ref ls_Erro, True) Then Return -1  	
		Else	
			If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_LIBERADO_TRANSF_PERINI', String(lvl_Produto), 'CD_PRODUTO', ls_Nulo, String(lvl_Produto), gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, 'I', Ref ls_Erro, True) Then Return -1	
		End If
		
		SqlCa.of_Commit();
	End If

Next

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produto(s) atualizado(s) com sucesso.")
dw_2.Reset()
end event

type cb_2 from commandbutton within w_ge364_inclusao_produto
integer x = 1687
integer y = 1140
integer width = 402
integer height = 100
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Cancela&r"
end type

event clicked;Close(Parent)
end event

type cb_1 from commandbutton within w_ge364_inclusao_produto
integer x = 23
integer y = 1140
integer width = 507
integer height = 100
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Incluir via &Excel"
end type

event clicked;String 	lvs_Path
String	   	lvs_Nome_Arquivo
String	   	lvs_Nulo
String		lvs_Dado

DateTime	lvdh_Inicio
DateTime	lvdh_Termino

Integer	lvi_Retorno 

Long 		lvl_Linhas
Long 		lvl_Linha
Long		lvl_Produto

If dw_2.RowCount() > 0 Then
    lvl_Produto = dw_2.Object.cd_produto[1]
	
	If Not IsNull(lvl_Produto) Then 
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Existem produtos que n$$HEX1$$e300$$ENDHEX$$o foram liberados. Deseja continuar?", Question!, YesNo!, 2) = 1 Then
			Dw_2.Reset()
			DW_2.Event ue_AddRow()
		Else
			Return -1
		End If
	End If
End If

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Os Dados devem estar da seguinte forma:~r~r" + &
				 "Coluna A = C$$HEX1$$f300$$ENDHEX$$digo do Produto")

lvi_Retorno = GetFileOpenName("Seleciona o arquivo", + lvs_Path, lvs_Nome_Arquivo, "XLS", &
				+ "Excel (*.XLS),*.XLS,")

If lvi_Retorno <> 1 Then Return

dw_1.AcceptText()

lvdh_Inicio 		= dw_1.Object.dt_inicio 		[1]
lvdh_Termino 	= dw_1.Object.dt_termino 	[1]

dw_2.SetRedRaw(False)

Open(w_Aguarde)

dc_uo_excel lvo_Excel
lvo_Excel = Create dc_uo_excel

// Refer$$HEX1$$ea00$$ENDHEX$$ncia o arquivo 
If ( lvo_Excel.uo_Referencia_Objeto_Excel(lvs_Path) ) Then
	// Coluna de Refer$$HEX1$$ea00$$ENDHEX$$ncia
	lvl_Linhas = lvo_Excel.uo_Verifica_Tamanho_Arquivo("A") 
	
	If lvl_Linhas > 0 Then
		w_Aguarde.uo_Progress.of_SetMax(lvl_Linhas)
		
		For lvl_Linha = 1 To lvl_Linhas 
			
			w_Aguarde.uo_Progress.of_SetProgress(lvl_Linha)
			
			lvs_Dado = String(lvo_Excel.uo_Lendo_Dados(lvl_Linha, "A"))		 
			If IsNumber(lvs_Dado) Then
				 lvl_Produto = Long(lvs_Dado)
			End If
			
			ivo_Produto.of_Localiza_Codigo_Interno(lvl_Produto)
			
			If ivo_Produto.Localizado Then
								
				dw_2.Object.Cd_Produto				[lvl_Linha] = ivo_Produto.cd_produto
				dw_2.Object.De_Produto				[lvl_Linha] = ivo_Produto.de_produto	+ " : " + ivo_Produto.de_apresentacao_venda
				
			Else
				
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O produto '" + String( lvl_Produto ) + "' n$$HEX1$$e300$$ENDHEX$$o foi localizado.")
				Exit
				
			End If
				
		Next
					
	End If
		
End If

Destroy lvo_Excel

dw_2.SetSort("de_produto")
dw_2.Sort()

Close(w_Aguarde)

dw_2.SetRedRaw(True)












end event

type dw_2 from dc_uo_dw_base within w_ge364_inclusao_produto
integer x = 50
integer y = 272
integer width = 2016
integer height = 840
integer taborder = 20
string dataobject = "dw_ge364_lista_inclusao"
boolean vscrollbar = true
end type

event ue_key;call super::ue_key;Long ll_Find

DateTime lvdh_Inicio
DateTime lvdh_Termino

If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "de_produto"
			ivo_Produto.of_Localiza_Produto(This.GetText())
								
			If ivo_Produto.Localizado Then
				
				// Verifica se o produto j$$HEX1$$e100$$ENDHEX$$ existe na lista
				ll_Find = This.Find("cd_produto = " + String(ivo_Produto.Cd_Produto), 1, This.RowCount())
				
				If ll_Find < 0 Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na verifica$$HEX2$$e700e300$$ENDHEX$$o da exist$$HEX1$$ea00$$ENDHEX$$ncia do produto na datawindow.", StopSign!)
					Return -1
				End If				
				
				If ll_Find > 0 Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto '" + String(ivo_Produto.Cd_Produto) + "' j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ na lista.", Information!)
					This.Post Event ue_Pos(ll_Find, "de_produto")
					This.DeleteRow(This.GetRow())
				Else
								
					This.Object.Cd_Produto[This.GetRow()] = ivo_Produto.Cd_Produto
					This.Object.De_Produto[This.GetRow()] = ivo_Produto.De_Produto + " : " + ivo_Produto.De_Apresentacao_venda
							
				End If
					
				This.Event ue_AddRow()
				
			End If
			
	End Choose
End If
end event

event constructor;call super::constructor;This.of_SetRowSelection()
end event

type dw_1 from dc_uo_dw_base within w_ge364_inclusao_produto
integer x = 50
integer y = 76
integer width = 1239
integer height = 76
string dataobject = "dw_ge364_selecao_inclusao"
end type

type gb_1 from groupbox within w_ge364_inclusao_produto
integer x = 18
integer y = 8
integer width = 1307
integer height = 184
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Per$$HEX1$$ed00$$ENDHEX$$odo"
end type

type gb_2 from groupbox within w_ge364_inclusao_produto
integer x = 18
integer y = 204
integer width = 2071
integer height = 924
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Produtos"
end type

