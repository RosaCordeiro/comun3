HA$PBExportHeader$w_ge525_inclui_altera_distribuidora.srw
forward
global type w_ge525_inclui_altera_distribuidora from dc_w_response_ok_cancela
end type
type dw_2 from dc_uo_dw_base within w_ge525_inclui_altera_distribuidora
end type
type gb_2 from groupbox within w_ge525_inclui_altera_distribuidora
end type
end forward

global type w_ge525_inclui_altera_distribuidora from dc_w_response_ok_cancela
integer width = 3003
integer height = 2184
string title = "GE525 - Incluir/Alterar Distribuidora"
dw_2 dw_2
gb_2 gb_2
end type
global w_ge525_inclui_altera_distribuidora w_ge525_inclui_altera_distribuidora

type variables
str_ge525_parametro st

uo_produto io_Produto
end variables

forward prototypes
public function boolean wf_grava_produto (long al_produto)
public function boolean wf_atualiza_motivo (string as_distribuidora, long al_produto, ref string as_motivo_acordo)
end prototypes

public function boolean wf_grava_produto (long al_produto);Boolean lb_Alteracao = False

Long ll_Linha
Long ll_Achou, ll_Achou_Registro 

String ls_Selecionado
String ls_Selecionado_Ant
String ls_Distribuidora
String ls_Erro
String ls_Para
Long  ll_Motivo_Acordo
Long  ll_Motivo_Acordo_Ant

For ll_Linha = 1 To dw_2.RowCount()
	ls_Selecionado 			= dw_2.Object.Id_Selecionado			[ll_Linha]
	ls_Selecionado_Ant	= dw_2.Object.Id_Selecionado_Ant	[ll_Linha]
	ls_Distribuidora 		= dw_2.Object.Cd_Distribuidora		[ll_Linha]
	ll_Motivo_Acordo       = dw_2.Object.cd_procedimento_acordo    	[ll_Linha] 
	ll_Motivo_Acordo_Ant =  dw_2.Object.cd_procedimentoant  	[ll_Linha]  

		
	//  Altera$$HEX2$$e700e300$$ENDHEX$$o Motivo Acordo
	If ls_Selecionado = 'S' Then 
		If ll_Motivo_Acordo_Ant  <>  ll_Motivo_Acordo Then 			
			Select Count(*)
				Into :ll_Achou_Registro
			From distribuidora_acordo_devolucao
			Where cd_distribuidora = :ls_Distribuidora
			And cd_produto = :al_Produto
			and cd_procedimento_acordo=:ll_Motivo_Acordo_Ant
			Using SqlCa;
		
			If SqlCa.SqlCode = -1 Then
				ls_Erro = SqlCa.SqlErrText
				SqlCa.of_Rollback();
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar se o produto [" + String(al_Produto) + "] tem acordo de devolu$$HEX2$$e700e300$$ENDHEX$$o com a distribuidora [" + ls_Distribuidora + "].", StopSign!)
				Return False
			Else
				If ll_Achou_Registro=1 Then 
					Update distribuidora_acordo_devolucao
					Set cd_procedimento_acordo=:ll_Motivo_Acordo
					Where cd_produto=:al_Produto
					and cd_distribuidora=:ls_Distribuidora
					Using SqlCA;
					
					If SqlCa.SqlCode = -1 Then
						ls_Erro = SqlCa.SqlErrText
						SqlCa.of_Rollback();
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao Atualzilzar motivo acordo. Produto [" + String(al_Produto) + "] tem acordo de devolu$$HEX2$$e700e300$$ENDHEX$$o com a distribuidora [" + ls_Distribuidora + "].", StopSign!)
						Return False
					End If

					// Historico de Altera$$HEX2$$e700e300$$ENDHEX$$o
					If Not gf_Grava_Historico_Alteracao_Tabela('DISTRIBUIDORA_ACORDO_DEVOLUCAO',& 
									String(ls_Distribuidora)+";"+String(al_Produto),& 
									'CD_DISTRIBUIDORA', String(ll_Motivo_Acordo), String(ll_Motivo_Acordo_Ant) ,&
									gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, "A",&
									Ref ls_Erro, True) Then Return False				
					
				End If 					
			End If 			
		End If 
	End If 	   		
		
		
	If ls_Selecionado <> ls_Selecionado_Ant    Then
		
		lb_Alteracao = True
		
		Select Count(*)
			Into :ll_Achou
		From distribuidora_acordo_devolucao
		Where cd_distribuidora = :ls_Distribuidora
			And cd_produto = :al_Produto
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			ls_Erro = SqlCa.SqlErrText
			SqlCa.of_Rollback();
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar se o produto [" + String(al_Produto) + "] tem acordo de devolu$$HEX2$$e700e300$$ENDHEX$$o com a distribuidora [" + ls_Distribuidora + "].", StopSign!)
			Return False
		End If
		
		//Se foi selecionado e n$$HEX1$$e300$$ENDHEX$$o existe o registro na tabela ir$$HEX1$$e100$$ENDHEX$$ gravar
		If ls_Selecionado = "S" Then
			If ll_Achou = 0 Then
				
				If ll_Motivo_Acordo<=0 Then 
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O Motivo $$HEX1$$e900$$ENDHEX$$ Obrigat$$HEX1$$f300$$ENDHEX$$rio. No [" + String(al_Produto) + "] e distribuidora [" + ls_Distribuidora + "] n$$HEX1$$e300$$ENDHEX$$o esta definido.", StopSign!)
					Return False	
				End If 	
				
				Insert Into distribuidora_acordo_devolucao(cd_distribuidora, cd_produto, dh_inclusao, nr_matricula, cd_procedimento_acordo  )
					Values(:ls_Distribuidora, :al_Produto, getdate(), :gvo_Aplicacao.ivo_Seguranca.Nr_Matricula,:ll_Motivo_Acordo )  
				Using SqlCa;
				
				If SqlCa.SqlCode = -1 Then
					ls_Erro = SqlCa.SqlErrText
					SqlCa.of_Rollback();
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao inserir o produto [" + String(al_Produto) + "] e distribuidora [" + ls_Distribuidora + "] no acordo de devolu$$HEX2$$e700e300$$ENDHEX$$o.~r" + ls_Erro, StopSign!)
					Return False
				End If
				
				// Historico de Inclusao
				If Not gf_Grava_Historico_Alteracao_Tabela('DISTRIBUIDORA_ACORDO_DEVOLUCAO',& 
									String(ls_Distribuidora)+";"+String(al_Produto),&
									'CD_DISTRIBUIDORA', '0', String(ll_Motivo_Acordo) ,&
									gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, "I",&
									Ref ls_Erro, True) Then Return False
				
				If Not gf_ge525_Revisao_Desconto_Preste(al_Produto, false) Then Return False		
				
			End If			
		Else
			
			//Se existe o registro ir$$HEX1$$e100$$ENDHEX$$ excluir
			If ll_Achou > 0 Then
				Delete From distribuidora_acordo_devolucao
				Where cd_distribuidora = :ls_Distribuidora
					And cd_produto = :al_Produto
				Using SqlCa;
				
				If SqlCa.SqlCode = -1 Then
					ls_Erro = SqlCa.SqlErrText
					SqlCa.of_Rollback();
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao excluir o produto [" + String(al_Produto) + "] e distribuidora [" + ls_Distribuidora + "] do acordo de devolu$$HEX2$$e700e300$$ENDHEX$$o.~r" + ls_Erro, StopSign!)
					Return False
				End If
				
				// Historico de Exclus$$HEX1$$e300$$ENDHEX$$o
				If Not gf_Grava_Historico_Alteracao_Tabela('DISTRIBUIDORA_ACORDO_DEVOLUCAO',& 
									String(ls_Distribuidora)+";"+String(al_Produto),& 
									'CD_DISTRIBUIDORA',String(ll_Motivo_Acordo_Ant) , '0',&
									gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, "E",&
									Ref ls_Erro, True) Then Return False
									
				If Not gf_ge525_Revisao_Desconto_Preste(al_Produto, false) Then Return False												
				
			End If
		End If
	End If
Next

Return True
end function

public function boolean wf_atualiza_motivo (string as_distribuidora, long al_produto, ref string as_motivo_acordo);String lvs_Erro 

Select coalesce(a.cd_procedimento_acordo,0) as cd_motivo
Into :as_motivo_acordo
From  dbo.distribuidora_acordo_devolucao a
Left  join dbo.distribuidora_proced_acordo b  on a.cd_procedimento_acordo = b.cd_procedimento_acordo 
Where cd_distribuidora  =:as_distribuidora  
And cd_produto =:al_produto
Using SqlCA;


If SqlCa.SqlCode = -1 Then
	lvs_Erro  = SqlCa.SqlErrText
	SqlCa.of_Rollback();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar se o produto [" + String(al_produto) + "] tem acordo de devolu$$HEX2$$e700e300$$ENDHEX$$o com a distribuidora [" + as_distribuidora + "] Tem Motivo.", StopSign!)
	Return False
End If


Return True 

end function

on w_ge525_inclui_altera_distribuidora.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.gb_2
end on

on w_ge525_inclui_altera_distribuidora.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.gb_2)
end on

event ue_postopen;call super::ue_postopen;st = Message.PowerObjectParm

//Se for altera$$HEX2$$e700e300$$ENDHEX$$o
If st.Id_Tipo = "A" Then
	dw_1.Object.Cd_Produto[1] = st.Cd_Produto
	dw_1.Object.De_Produto[1] = st.De_Produto
	
	dw_1.Enabled = False
End If

dw_2.Event ue_Retrieve()
end event

event ue_preopen;call super::ue_preopen;io_Produto = Create uo_produto
end event

event close;call super::close;If IsValid(io_Produto) Then Destroy(io_Produto)
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge525_inclui_altera_distribuidora
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge525_inclui_altera_distribuidora
integer width = 2249
integer height = 188
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge525_inclui_altera_distribuidora
integer width = 2190
integer height = 96
string dataobject = "dw_ge525_selecao_inclusao_prd"
end type

event dw_1::ue_key;call super::ue_key;Long ll_Achou

If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "de_produto"
					
			io_Produto.of_Localiza_Produto(This.GetText())
			
			Select Count(*)
				Into :ll_Achou
			From distribuidora_acordo_devolucao
			Where cd_produto = :io_Produto.Cd_Produto
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar se o produto [" + String(io_Produto.Cd_Produto) + "] tem acordo de devolu$$HEX2$$e700e300$$ENDHEX$$o cadastrado.", StopSign!)
				Return -1
			End If
			
			If ll_Achou > 0 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produto [" + String(io_Produto.Cd_Produto) + "] j$$HEX1$$e100$$ENDHEX$$ tem acordo de devolu$$HEX2$$e700e300$$ENDHEX$$o cadastrado.~r" + &
												"Localize-o na tela anterior e fa$$HEX1$$e700$$ENDHEX$$a a edi$$HEX2$$e700e300$$ENDHEX$$o utlizando duplo clique.", Exclamation!)
				Return -1
			End If
						
			If io_Produto.Localizado Then
				This.Object.Cd_Produto[1] = io_Produto.Cd_Produto
				This.Object.De_Produto[1] = io_Produto.ivs_Descricao_Apresentacao_Venda
			End If
	End Choose
End If
end event

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case "de_produto"
		If Not IsNull(Data) and Data <> "" Then
			If Data <> io_Produto.ivs_Descricao_Apresentacao_Venda Then
				Return 1
			End If
			
		Else
			io_Produto.of_Inicializa()
			
			This.Object.Cd_Produto[1] = io_Produto.Cd_Produto
			This.Object.De_Produto[1] = io_Produto.ivs_Descricao_Apresentacao_Venda
		End If
End Choose
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge525_inclui_altera_distribuidora
integer x = 37
integer y = 1972
string text = "&Gravar"
boolean default = false
end type

event cb_ok::clicked;call super::clicked;Long ll_Find

dw_1.AcceptText()
dw_2.AcceptText()

If st.Id_Tipo = "I" Then
	If IsNull(dw_1.Object.Cd_Produto[1]) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o produto.")
		dw_1.Event ue_Pos(1, "de_produto")
		Return -1
	End If
End If

ll_Find = dw_2.Find("id_selecionado = 'S'", 1, dw_2.RowCount())

If ll_Find < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Find da dw_2.", StopSign!)
	dw_2.SetFocus()
	Return -1
End If

If ll_Find = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione ao menos uma distribuidora.")
	dw_2.SetFocus()
	Return -1
End If

If Not wf_Grava_Produto(dw_1.Object.Cd_Produto[1]) Then Return -1

SqlCa.of_Commit();

CloseWithReturn(Parent, "OK")
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge525_inclui_altera_distribuidora
integer x = 366
integer y = 1972
end type

type dw_2 from dc_uo_dw_base within w_ge525_inclui_altera_distribuidora
integer x = 37
integer y = 252
integer width = 2930
integer height = 1672
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge525_selecao_distrib"
boolean vscrollbar = true
end type

event ue_recuperar;//OverRide

Return This.Retrieve(st.Cd_Produto)
end event

event constructor;call super::constructor;This.of_SetRowSelection()
end event

event itemchanged;call super::itemchanged;If dwo.Name = "id_selecionado" Then
	If Data = "N" And This.Object.Id_Selecionado_Ant[row] = "S" Then
		If This.Object.Id_Possui_Lote[row] = "S" Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existe lote cadastrado para a distribuidora [" + String(This.Object.Cd_Distribuidora[row]) + "]." + &
											"~r~rFa$$HEX1$$e700$$ENDHEX$$a a exclus$$HEX1$$e300$$ENDHEX$$o do lote e ap$$HEX1$$f300$$ENDHEX$$s a distribuidora poder$$HEX1$$e100$$ENDHEX$$ ser desmarcada.", Exclamation!)
			Return 1
		End If
		
		
		
		
	End If
	
	
	
	
End If
end event

event ue_postretrieve;call super::ue_postretrieve;Long ll_Linha  
String lvs_Motivo 


dw_2.AcceptText()

If pl_Linhas > 0 Then
//	For ll_Linha = 1 To dw_2.rowCount ()
	//	If Not wf_atualiza_motivo(dw_2.Object.cd_distribuidora[ll_Linha], dw_2.Object.cd_produto[ll_Linha],Ref lvs_Motivo) Then Return -1
	//	dw_2.Object.cd_distribuidora[ll_Linha] = lvs_Motivo
	///Next 		
End If 	


Return pl_Linhas





end event

type gb_2 from groupbox within w_ge525_inclui_altera_distribuidora
integer x = 23
integer y = 192
integer width = 2958
integer height = 1756
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

