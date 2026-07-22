HA$PBExportHeader$w_ge232_ajuste_estoque_controlado.srw
forward
global type w_ge232_ajuste_estoque_controlado from dc_w_cadastro_selecao_lista
end type
end forward

global type w_ge232_ajuste_estoque_controlado from dc_w_cadastro_selecao_lista
integer width = 3639
integer height = 1540
string title = "GE232 - Ajuste de Estoque de Produtos Controlados"
end type
global w_ge232_ajuste_estoque_controlado w_ge232_ajuste_estoque_controlado

type variables
uo_produto     ivo_produto
uo_saldo_lote ivo_saldo_lote
uo_saldo_lote ivo_saldo_lote2

string ivs_Operador
end variables

forward prototypes
public function boolean wf_saldo_lote (long al_produto, string as_lote, ref long al_saldo)
public function boolean wf_valida_lote ()
public function boolean wf_custo_unitario (long al_produto, ref decimal adc_custo_medio)
public function boolean wf_usuario_liberado ()
public function boolean wf_ultimo_ajuste (ref long al_ajuste)
end prototypes

public function boolean wf_saldo_lote (long al_produto, string as_lote, ref long al_saldo);Select qt_lote 
Into :al_Saldo
From saldo_produto_lote
Where cd_produto = :al_Produto
  and nr_lote	 = :as_Lote
  and cd_filial 		= 534
Using SqlCa;

If Sqlca.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do saldo do lote do produto.")
	Return False
End If

If SqlCa.SqlCode = 0 Then
	If IsNull(al_Saldo) or al_Saldo < 0 Then
		al_Saldo = 0
	End If
Else
	al_Saldo = 0
End If

Return True
end function

public function boolean wf_valida_lote ();Boolean lvb_Retorno = True

Long lvl_Linha,&
	 lvl_Linhas,&
	 lvl_Produto,&
	 lvl_Qtde_Ajuste,&
	 lvl_Find,&
	 lvl_Saldo,&
	 lvl_Qtde_Ajustado
	 	 
String lvs_Lote, lvs_Tipo_Ajuste
	 
lvl_Linhas = dw_2.RowCount()

For lvl_Linha = 1 To lvl_Linhas
	
	lvl_Produto 			= dw_2.Object.cd_produto[lvl_Linha]
	lvs_Lote    			= dw_2.Object.nr_lote   [lvl_Linha]
	lvl_Qtde_Ajuste 	= dw_2.Object.qt_ajuste [lvl_Linha]
	lvs_Tipo_Ajuste  	= dw_2.Object.id_entrada_saida [lvl_Linha]	
	
	If IsNull(lvl_Qtde_Ajuste) or lvl_Qtde_Ajuste <= 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a quantidade corretamente.")
		dw_2.SetFocus()
		dw_2.SetRow(lvl_Linha)
		dw_2.SetColumn("qt_ajuste")
		lvb_Retorno = False
		Exit
	End If
		
	If IsNull(lvs_Lote) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o lote.")
		dw_2.SetFocus()
		dw_2.SetRow(lvl_Linha)
		dw_2.SetColumn("nr_lote")
		lvb_Retorno = False
		Exit
	End If
			
	If lvl_Linha < lvl_Linhas Then
		lvl_Find    = dw_2.Find("cd_produto =" + String(lvl_Produto) + " and nr_lote = '" + lvs_Lote + "'", lvl_Linha + 1, lvl_Linhas)
		
		If lvl_Find = -1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o produto da Data Window.")
			lvb_Retorno = False
			Exit
		End If
	Else
		lvl_Find = 0
	End If
	
	If lvl_Find > 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O lote '" + lvs_Lote + "' foi informado mais de uma vez.", Exclamation!)
		lvb_Retorno = False
		Exit
	Else
		
		If lvs_Tipo_Ajuste = 'S' Then
		
			If Not wf_Saldo_Lote(lvl_Produto, lvs_Lote, Ref lvl_Saldo) Then
				lvb_Retorno = False
				Exit
			End If
							
			If lvl_Qtde_Ajuste > lvl_Saldo Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Saldo insuficiente para o lote '" + lvs_Lote +  "'.~r~r" +&
									  "Saldo do Lote: " + String(lvl_Saldo), Exclamation!)
									  
				dw_2.SetFocus()
				dw_2.SetRow(lvl_Linha)
				dw_2.SetColumn("qt_ajuste")
				
				lvb_Retorno = False
				Exit
			End If
		End If // tipo
	End if
Next 

Return lvb_Retorno 
end function

public function boolean wf_custo_unitario (long al_produto, ref decimal adc_custo_medio);Select vl_custo_medio Into :adc_Custo_Medio
From vw_saldo_atual_produto
Where cd_produto = :al_Produto
     and cd_filial		= 534
Using Sqlca;

If Sqlca.Sqlcode = -1 Then
	Sqlca.of_MsgDbError('Erro ao localizar custo do produto : ' + String(al_Produto) )
ElseIf Sqlca.Sqlcode = 100 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o",'Custo do produto : ' + String(al_Produto) + ' n$$HEX1$$e300$$ENDHEX$$o localizado.',StopSign!)
Else
	If IsNull(adc_Custo_Medio) Then	adc_Custo_Medio = 000.00
	Return True
End If	

Return False
end function

public function boolean wf_usuario_liberado ();String ls_Usuario

Select nr_matricula
Into :ls_Usuario
From usuario_sistema
Where cd_sistema 		= 'FA'
   and nr_matricula 		= :ivs_Operador
   and cd_perfil_usuario 	= 4
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		Return True
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Usu$$HEX1$$e100$$ENDHEX$$rio n$$HEX1$$e300$$ENDHEX$$o esta liberado para este procedimento. ~rPerfil autorizado: GERENTE LOGISTICA", Exclamation!)
	Case -1 
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do perfil do usuario do FA")
End Choose

Return False


end function

public function boolean wf_ultimo_ajuste (ref long al_ajuste);Select max(nr_ajuste) 
Into :al_ajuste  
From ajuste_estoque
Where cd_filial_ajuste = 534
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If IsNull(al_ajuste) Then
			al_ajuste = 0
		End If
		
	Case 100
		al_ajuste = 0
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do $$HEX1$$fa00$$ENDHEX$$ltimo ajuste.")
		Return False
End Choose

Return True
end function

on w_ge232_ajuste_estoque_controlado.create
call super::create
end on

on w_ge232_ajuste_estoque_controlado.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;ivo_Produto     = Create uo_Produto
ivo_Saldo_Lote  = Create uo_Saldo_Lote
ivo_Saldo_Lote2 = Create uo_Saldo_Lote


ivm_Menu.mf_Recuperar(False)
ivm_Menu.mf_Incluir(False)

If  gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("w_ge232_ajuste_estoque_controlado", ref ivs_Operador) Then 
	If Not wf_usuario_liberado() Then Close(This)
Else
	Close(This)
End If

end event

event close;call super::close;Destroy(ivo_Produto)
Destroy(ivo_Saldo_Lote)
Destroy(ivo_Saldo_Lote2)
end event

event ue_save;call super::ue_save;This.ivb_Valida_Salva = True

Return AncestorReturnValue
end event

event ue_cancel;call super::ue_cancel;ivm_Menu.mf_Recuperar(False)
ivm_Menu.mf_Excluir(False)
ivm_Menu.mf_Incluir(False)

ivm_Menu.mf_Confirmar(False)
ivm_Menu.mf_Cancelar(False)
end event

type dw_1 from dc_w_cadastro_selecao_lista`dw_1 within w_ge232_ajuste_estoque_controlado
integer x = 37
integer y = 68
integer width = 1728
string dataobject = "dw_ge232_selecao"
end type

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)
end event

event dw_1::itemchanged;call super::itemchanged;Integer lvi_Motivo

dw_1.AcceptText()

lvi_Motivo = dw_1.Object.cd_motivo_ajuste[1] 
		
If lvi_Motivo > 0  Then
	This.ivm_Menu.mf_Incluir(True)
Else
	This.ivm_Menu.mf_Incluir(False)
End If
	

end event

type gb_2 from dc_w_cadastro_selecao_lista`gb_2 within w_ge232_ajuste_estoque_controlado
integer x = 14
integer y = 256
integer width = 3557
integer height = 1080
integer taborder = 20
integer weight = 700
end type

type gb_1 from dc_w_cadastro_selecao_lista`gb_1 within w_ge232_ajuste_estoque_controlado
integer x = 14
integer width = 1769
integer height = 244
integer taborder = 30
integer weight = 700
end type

type dw_2 from dc_w_cadastro_selecao_lista`dw_2 within w_ge232_ajuste_estoque_controlado
integer x = 41
integer y = 308
integer width = 3511
integer height = 1000
integer taborder = 40
string dataobject = "dw_ge232_lista"
end type

event dw_2::ue_key;Long lvl_Linha

String lvs_Grupo_Psico,&
	    lvs_Coluna,&
	    lvs_Data
String lvs_Nao_Psico
	   
Decimal{2} lvdc_Custo_Unitario
	   
dw_1.AcceptText()

lvl_Linha = dw_2.GetRow()

lvs_Coluna = This.GetColumnName()

If Key = keyEnter! Then
	If lvs_Coluna = "nm_produto" Then
		ivo_Produto.of_Localiza_Produto(This.GetText())
		
		If ivo_Produto.Localizado Then
			
			lvs_Grupo_Psico = ivo_Produto.cd_grupo_psico 
			
			If Not IsNull(lvs_Grupo_Psico) and lvs_Grupo_Psico <> "" Then
				
				If Not gf_Grupo_Nao_Psico_Matriz(lvs_Grupo_Psico, ref lvs_Nao_Psico) Then
					Return -1
				Else
					If lvs_Nao_Psico = 'S' Then
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto '" + ivo_Produto.ivs_Descricao_Apresentacao_Venda +&
		 						     " (" + String(ivo_Produto.cd_produto) + ")' n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ controlado.")
										
						Return -1

					End If
				End If
						
				If wf_Custo_Unitario(ivo_Produto.cd_produto, Ref lvdc_Custo_Unitario) Then 
										
					dw_2.Object.cd_produto       	[lvl_Linha] = ivo_Produto.cd_produto
					dw_2.Object.nm_produto       	[lvl_Linha] = ivo_Produto.ivs_Descricao_Apresentacao_Venda

					dw_2.Object.vl_custo_unitario[lvl_Linha] = lvdc_Custo_Unitario
					
					dw_2.Event ue_Pos(lvl_Linha, "qt_ajuste")
																								
					//ivo_Saldo_Lote.of_Preenche_Lista_Matriz(This, 534, ivo_Produto.cd_produto)
					
					OpenWithParm(w_ge232_selecionar_lote, String( ivo_Produto.cd_produto))
					
					dw_2.Object.nr_lote[lvl_Linha]  = Message.StringParm
					
					dw_2.Event ue_AddRow()					
					
				End If
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O produto '" + ivo_Produto.ivs_Descricao_Apresentacao_Venda +&
									   " (" + String(ivo_Produto.cd_produto) + ")' n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ controlado.")
				Return -1
			End If
		End If
	End If
	
//	If lvs_Coluna = "qt_ajuste" Then 
//		dw_2.Event ue_Pos(lvl_Linha, "nr_lote")
//	End If
	
//	If lvs_Coluna = "nr_lote" or lvs_Coluna = "cd_motivo_ajuste" Then
//		
//		lvs_Data = This.GetText()
//				
//		If Not IsNull(lvs_Data) and lvs_Data <> "" Then
//			dw_2.Event ue_AddRow()
//		End If
//	End If

	If lvs_Coluna = "qt_ajuste"  or lvs_Coluna = "cd_motivo_ajuste" Then 
		lvs_Data = This.GetText()
				
		If Not IsNull(lvs_Data) and lvs_Data <> "" Then
			dw_2.Event ue_AddRow()
		End If
	End If
	
	
End If



end event

event dw_2::ue_preinsertrow;call super::ue_preinsertrow;If dw_2.RowCount() > 0 Then
	If IsNull(dw_2.Object.cd_produto[dw_2.RowCount()]) Then
		Return 0
	End If
End If

Return 1
end event

event dw_2::ue_addrow;call super::ue_addrow;Integer lvi_Motivo

Long lvl_Linha

dw_1.AcceptText()

lvi_Motivo = dw_1.Object.cd_motivo_ajuste[1]

If AncestorReturnValue > 0 Then
	lvl_Linha = AncestorReturnValue
	dw_2.Object.cd_motivo_ajuste[lvl_Linha] = lvi_Motivo
End If

Return AncestorReturnValue


	
end event

event dw_2::rowfocuschanged;call super::rowfocuschanged;Long lvl_Linha,&
	 lvl_Produto

lvl_Linha = This.GetRow()

dw_1.AcceptText()
dw_2.AcceptText()

If lvl_Linha > 0 Then
	
	lvl_Produto = dw_2.Object.cd_produto[lvl_Linha]
	
	If Not IsNull(lvl_Produto) Then
		//ivo_Saldo_Lote2.of_Preenche_Lista(This, 534, lvl_Produto)
	End If
End If
end event

event dw_2::ue_preupdate;call super::ue_preupdate;Boolean lvb_Sucesso = True

DateTime lvdh_Movimentacao
DateTime lvdh_ajuste

Long 	lvl_Linhas,&
	 	lvl_Linha,&
	 	lvl_Ajuste

Integer lvi_Motivo
	 
String lvs_Entrada_Saida,&
	    lvs_Responsavel,&
	    lvs_Comentario,&
		 ls_Lote
		 
//If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existe corre$$HEX2$$e700e300$$ENDHEX$$o para ajustes de psicotr$$HEX1$$f300$$ENDHEX$$picos! ~r    Deseja realmente confirmar o ajuste?", &
//			  Exclamation!, YesNo!, 2) = 2 Then
//  Return -1
//End If
		 
dw_2.AcceptText()

lvl_Linhas = dw_2.RowCount()

If lvl_Linhas > 0 Then
	If IsNull(dw_2.Object.cd_produto[lvl_Linhas]) Then
		dw_2.DeleteRow(dw_2.RowCount())
		lvl_Linhas --
	End If
End If

If lvl_Linhas = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe pelo menos um produto.")
	Return -1
End If

lvdh_Movimentacao = gvo_Parametro.of_Dh_Movimentacao()
lvdh_Ajuste			= gf_GetServerDate()

lvs_Comentario    = dw_1.Object.de_comentario   [1]

lvb_Sucesso = wf_Valida_Lote()

lvb_Sucesso = wf_Ultimo_ajuste(ref lvl_Ajuste)

If lvb_Sucesso Then

	For lvl_Linha = 1 To lvl_Linhas
		
		dw_2.Object.dh_movimentacao_caixa	[lvl_Linha] = lvdh_Movimentacao
		dw_2.Object.dh_ajuste						[lvl_Linha] = lvdh_Ajuste
		dw_2.Object.Nr_Matricula_Responsavel	[lvl_Linha] = ivs_Operador
		dw_2.Object.De_Comentario_Ajuste		[lvl_Linha] = lvs_Comentario
		
		lvl_Ajuste ++	
		
		dw_2.Object.nr_ajuste[lvl_Linha] = lvl_Ajuste
		
	Next
	
Else
	Return -1
End If

Return 1
end event

event dw_2::ue_update;call super::ue_update;If AncestorReturnValue = 1 Then
	
	dw_1.Reset()
	dw_1.Event ue_AddRow()
	dw_2.Reset()
	
	ivm_Menu.mf_Excluir(False)
	ivm_Menu.mf_Incluir(False)
	
End If

Return AncestorReturnValue
end event

