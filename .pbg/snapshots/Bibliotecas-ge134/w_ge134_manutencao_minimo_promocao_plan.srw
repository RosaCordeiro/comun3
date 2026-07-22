HA$PBExportHeader$w_ge134_manutencao_minimo_promocao_plan.srw
forward
global type w_ge134_manutencao_minimo_promocao_plan from w_ge134_manutencao_minimo_promocao
end type
end forward

global type w_ge134_manutencao_minimo_promocao_plan from w_ge134_manutencao_minimo_promocao
end type
global w_ge134_manutencao_minimo_promocao_plan w_ge134_manutencao_minimo_promocao_plan

forward prototypes
public function boolean wf_atualiza_informacoes ()
public function boolean wf_valida_fator_conversao ()
public function boolean wf_atualiza_qtde_estoque_minimo ()
end prototypes

public function boolean wf_atualiza_informacoes ();// O conteudo da fun$$HEX2$$e700e300$$ENDHEX$$o do ancestral n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ executado
Boolean lvb_Sucesso = True

Integer lvi_Row

Long 	lvl_Promocao, &
		lvl_Filial, &
		lvl_Produto, &
		lvl_Estoque_Minimo, &
		lvl_Estoque_Minimo_Ant,&
		ll_Motivo, &
		ll_Est_Min_Matriz,&
		ll_Est_Min_Matriz_Ant,&
		ll_Achou
	  
Tab_1.TabPage_1.dw_1.AcceptText()
Tab_1.TabPage_1.dw_2.AcceptText()
Tab_1.TabPage_2.dw_3.AcceptText()
Tab_1.TabPage_2.dw_6.AcceptText()

lvl_Promocao = Tab_1.TabPage_1.dw_1.Object.Cd_Promocao[1]

ll_Motivo = Tab_1.TabPage_2.dw_6.Object.Cd_Motivo[1]

If ll_Motivo = 0 Then
	SetNull(ll_Motivo)
End If

For lvi_Row = 1 To Tab_1.TabPage_2.dw_3.RowCount()
	lvl_Produto        			= Tab_1.TabPage_2.dw_3.Object.Cd_Produto                					[lvi_Row]
	lvl_Filial         				= Tab_1.TabPage_2.dw_3.Object.Cd_Filial                 						[lvi_Row]
	lvl_Estoque_Minimo		= Tab_1.TabPage_2.dw_3.Object.Qt_Estoque_Minimo_Promocao			[lvi_Row]
	lvl_Estoque_Minimo_Ant	= Tab_1.TabPage_2.dw_3.Object.qt_estoque_minimo_promocao_ant	[lvi_Row]
	ll_Est_Min_Matriz 			= Tab_1.TabPage_2.dw_3.Object.Qt_Estoque_Minimo_Matriz				[lvi_Row]
	ll_Est_Min_Matriz_Ant		= Tab_1.TabPage_2.dw_3.Object.qt_estoque_minimo_matriz_ant			[lvi_Row]	
	
	//S$$HEX1$$f300$$ENDHEX$$ obrigado a informar se a promo$$HEX2$$e700e300$$ENDHEX$$o for de Planograma
	If ivo_Promocao.ivs_Tipo = "P" Then
		If IsNull(ll_Motivo) Then
			If lvl_Estoque_Minimo <> lvl_Estoque_Minimo_Ant or ll_Est_Min_Matriz <> ll_Est_Min_Matriz_Ant Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o motivo de altera$$HEX2$$e700e300$$ENDHEX$$o.")
				Tab_1.TabPage_2.dw_6.Event ue_Pos(1, "cd_motivo")
				lvb_Sucesso = False
				Exit
			End If
		End If
	End If	
	
	If lvl_Estoque_Minimo > 0 Or ll_Est_Min_Matriz > 0 Then
								
		Select count(*)
		Into :ll_Achou
		From promocao_sos_estoque_minimo
		Where cd_promocao_sos = :lvl_Promocao
		  and cd_filial		= :lvl_Filial
		  and cd_produto	= :lvl_Produto
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgdbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do estoque m$$HEX1$$ed00$$ENDHEX$$nimo da promo$$HEX2$$e700e300$$ENDHEX$$o")
			lvb_Sucesso = False
			Exit
		End If
		
		If ll_Achou > 0 Then
			
			If lvl_Estoque_Minimo <> lvl_Estoque_Minimo_Ant or ll_Est_Min_Matriz <> ll_Est_Min_Matriz_Ant Then
				
				Update promocao_sos_estoque_minimo
					Set	qt_estoque_minimo = :lvl_Estoque_Minimo,
							qt_estoque_minimo_matriz = :ll_Est_Min_Matriz,
							nr_matricula_alteracao = :gvo_Aplicacao.ivo_Seguranca.Nr_Matricula,
							cd_motivo_alteracao = :ll_Motivo
				Where cd_promocao_sos = :lvl_Promocao
				  and cd_filial		= :lvl_Filial
				  and cd_produto	= :lvl_Produto
				Using SqlCa;
				
				If SqlCa.SqlCode = -1 Then
					SqlCa.of_MsgdbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do estoque m$$HEX1$$ed00$$ENDHEX$$nimo da promo$$HEX2$$e700e300$$ENDHEX$$o")
					lvb_Sucesso = False
					Exit
				End If
				
			End If
			
		Else
			Insert Into promocao_sos_estoque_minimo(cd_promocao_sos,
																	 cd_filial,
																	 cd_produto,
																	 qt_estoque_minimo,
																	 qt_estoque_minimo_matriz,
																	 nr_matricula_alteracao,
																	 cd_motivo_alteracao)
			Values(:lvl_Promocao,
					 :lvl_Filial,
					 :lvl_Produto,
					 :lvl_Estoque_Minimo,
					 :ll_Est_Min_Matriz,
					 :gvo_Aplicacao.ivo_Seguranca.Nr_Matricula,
					 :ll_Motivo)
			Using SqlCa;
			
			If SqlCa.SqlCode = - 1 Then
				SqlCa.of_MsgdbError("Inclus$$HEX1$$e300$$ENDHEX$$o do Estoque M$$HEX1$$ed00$$ENDHEX$$nimo para Promo$$HEX2$$e700e300$$ENDHEX$$o")
				lvb_Sucesso = False
				Exit
			End If
		End If
		
	Else
		If Not wf_Exclui_Produto_Promocao(lvl_Promocao, lvl_Filial, lvl_Produto) Then
			lvb_Sucesso = False
			Exit
		End If
		
		If Not gf_ge134_Grava_Historico_Exclusao_Promo(lvl_Promocao, lvl_Filial, lvl_Produto, lvl_Estoque_Minimo_Ant, 'D', ll_Motivo) Then
			lvb_Sucesso = False
			Exit
		End If
	End If
Next

Return lvb_Sucesso
end function

public function boolean wf_valida_fator_conversao ();// O conteudo da fun$$HEX2$$e700e300$$ENDHEX$$o do ancestral n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ executado
Long	lvl_Total, &
		lvl_Linha, &
		lvl_Estoque_Minimo, &
		lvl_Fator, &
		ll_Min_Matriz
	  	  
Tab_1.TabPage_2.dw_3.AcceptText()
Tab_1.TabPage_2.dw_4.AcceptText()

lvl_Total = Tab_1.TabPage_2.dw_3.RowCount()

lvl_Fator = Tab_1.TabPage_2.dw_4.Object.Vl_Fator_Conversao[1]

For lvl_Linha = 1 To lvl_Total
	lvl_Estoque_Minimo	= Tab_1.TabPage_2.dw_3.Object.Qt_Estoque_Minimo_Promocao	[lvl_Linha]
	
	If lvl_Estoque_Minimo > 0 Then
		If Mod(lvl_Estoque_Minimo, lvl_Fator) <> 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O estoque m$$HEX1$$ed00$$ENDHEX$$nimo deve ser m$$HEX1$$fa00$$ENDHEX$$ltiplo do fator de convers$$HEX1$$e300$$ENDHEX$$o.", StopSign!)
			Tab_1.TabPage_2.dw_3.Event ue_Pos(lvl_Linha, "qt_estoque_minimo_promocao")
			Return False
		End If
	End If
	
	If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = 'GC' Then
		ll_Min_Matriz = Tab_1.TabPage_2.dw_3.Object.Qt_Estoque_Minimo_Matriz	[lvl_Linha]
		
		If ll_Min_Matriz > 0 Then
			If Mod(ll_Min_Matriz, lvl_Fator) <> 0 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O estoque m$$HEX1$$ed00$$ENDHEX$$nimo deve ser m$$HEX1$$fa00$$ENDHEX$$ltiplo do fator de convers$$HEX1$$e300$$ENDHEX$$o.", StopSign!)
				Tab_1.TabPage_2.dw_3.Event ue_Pos(lvl_Linha, "qt_estoque_minimo_matriz")
				Return False
			End If
		End If
	End If	
Next

Return True
end function

public function boolean wf_atualiza_qtde_estoque_minimo ();// O conteudo da fun$$HEX2$$e700e300$$ENDHEX$$o do ancestral n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ executado
Boolean lvb_Sucesso = True

Long lvl_Row, &
     lvl_Promocao, &
	  lvl_Filial, &
	  lvl_Produto, &
	  lvl_Qtde_Estoque, &
	  ll_Qt_Est_Min_Mat, &
	  ll_Nulo
	  
Tab_1.TabPage_1.dw_1.AcceptText()
Tab_1.TabPage_1.dw_2.AcceptText()
Tab_1.TabPage_2.dw_3.AcceptText()

lvl_Promocao = Tab_1.TabPage_1.dw_1.Object.Cd_Promocao[1]

SetNull(ll_Nulo)
	  
For lvl_Row = 1 To Tab_1.TabPage_2.dw_3.RowCount()
	
	lvl_Filial  = Tab_1.TabPage_2.dw_3.Object.Cd_Filial[lvl_Row]
	lvl_Produto = Tab_1.TabPage_2.dw_3.Object.Cd_Produto[lvl_Row]
	
	Select qt_estoque_minimo, qt_estoque_minimo_matriz
	Into :lvl_Qtde_Estoque, :ll_Qt_Est_Min_Mat
	From promocao_sos_estoque_minimo
	where cd_promocao_sos = :lvl_Promocao
	  and cd_filial       = :lvl_Filial
	  and cd_produto      = :lvl_Produto
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			Tab_1.TabPage_2.dw_3.Object.Qt_Estoque_Minimo_Promocao		[lvl_Row] = lvl_Qtde_Estoque
			Tab_1.TabPage_2.dw_3.Object.qt_estoque_minimo_promocao_ant	[lvl_Row] = lvl_Qtde_Estoque
			Tab_1.TabPage_2.dw_3.Object.Qt_Estoque_Minimo_Matriz				[lvl_Row] = ll_Qt_Est_Min_Mat
			Tab_1.TabPage_2.dw_3.Object.qt_estoque_minimo_matriz_ant		[lvl_Row] = ll_Qt_Est_Min_Mat
			
		Case 100
			Tab_1.TabPage_2.dw_3.Object.Qt_Estoque_Minimo_Promocao		[lvl_Row] = 0
			Tab_1.TabPage_2.dw_3.Object.qt_estoque_minimo_promocao_ant	[lvl_Row] = 0
			Tab_1.TabPage_2.dw_3.Object.Qt_Estoque_Minimo_Matriz				[lvl_Row] = 0
			Tab_1.TabPage_2.dw_3.Object.qt_estoque_minimo_matriz_ant		[lvl_Row] = 0	
			
		Case -1
			SqlCa.of_MsgdbError("localiza$$HEX2$$e700e300$$ENDHEX$$o do estoque m$$HEX1$$ed00$$ENDHEX$$nimo da filial: " + String(lvl_Filial) + &
			                    " para a promo$$HEX2$$e700e300$$ENDHEX$$o: " + String(lvl_Filial) + " e produto: " + &
									  String(lvl_Produto))
			lvb_Sucesso = False
			Exit
	End Choose	
Next

Return lvb_Sucesso
end function

event ue_postopen;//OverRide

ivo_dbError = Create dc_uo_dbError

//Registra Tela para Controle de Inatividade
If (Not(ivb_permite_fechar)) and (IsValid(gvo_Aplicacao)) Then
	If gvo_Aplicacao.ivb_Usa_Timer_Out Then
		gvo_Aplicacao.of_insere_tela(This.Title)
	End If
End If

// Insere a tela response do array de responses abertas
// Necess$$HEX1$$e100$$ENDHEX$$rio a armazenagem para fechar as telas por inatividade
If IsValid(gvo_Aplicacao) Then
	If gvo_Aplicacao.ivb_usa_timer_out Then
		If This.WindowType = Response! Then
			gvo_Aplicacao.of_insere_response(This)
		End if
	End If
End If

//Verifica se no grupo de acesso a tela est$$HEX1$$e100$$ENDHEX$$ sem permiss$$HEX1$$e300$$ENDHEX$$o de altera$$HEX2$$e700e300$$ENDHEX$$o
// e seta como somente leitura os campos
If This.WindowType <> Response! Then
	wf_set_somente_consulta()
End If	

Integer lvl_PxWidth
Integer lvl_PxHeight
Integer lvl_UnWidth
Integer lvl_UnHeight

If (MaxWidth > 0)or(MaxHeight>0) Then
	gvo_aplicacao.of_retorna_resolucao_monitor(lvl_PxWidth,lvl_PxHeight)
	
	lvl_UnWidth	= PixelsToUnits(lvl_PxWidth,XPixelsToUnits!)
	lvl_UnHeight	= PixelsToUnits(lvl_PxHeight,YPixelsToUnits!)
	
	If (lvl_PxWidth <> 800)and(MaxWidth > 0) Then //Diferente da resolu$$HEX2$$e700e300$$ENDHEX$$o 800 x 600 (Padr$$HEX1$$e300$$ENDHEX$$o Loja)
		If lvl_UnWidth >= MaxWidth Then //Maior que tamanho ideal
			This.Width = MaxWidth
		Else 
			This.Width = lvl_UnWidth - 50
		End If
	End If
	
	If (lvl_PxHeight <> 600)and(MaxHeight > 0) Then //Diferente da resolu$$HEX2$$e700e300$$ENDHEX$$o 800 x 600 (Padr$$HEX1$$e300$$ENDHEX$$o Loja)
		If lvl_UnHeight >= MaxHeight Then //Maior que tamanho ideal
			This.Height = MaxHeight
		Else 
			This.Height = lvl_UnHeight - 650
		End If
	End If
End If

Tab_1.TabPage_1.dw_1.Event ue_AddRow()
Tab_1.TabPage_1.dw_1.SetFocus()

Tab_1.TabPage_2.dw_4.Event ue_AddRow()

Tab_1.TabPage_1.dw_1.SetFocus()

ivo_Promocao.ivs_Tipo = "P"

This.Title = "GE134 - Manuten$$HEX2$$e700e300$$ENDHEX$$o de Estoque M$$HEX1$$ed00$$ENDHEX$$nimo de Produtos em Promo$$HEX2$$e700e300$$ENDHEX$$o Planograma"
end event

on w_ge134_manutencao_minimo_promocao_plan.create
call super::create
end on

on w_ge134_manutencao_minimo_promocao_plan.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type dw_visual from w_ge134_manutencao_minimo_promocao`dw_visual within w_ge134_manutencao_minimo_promocao_plan
end type

type gb_aux_visual from w_ge134_manutencao_minimo_promocao`gb_aux_visual within w_ge134_manutencao_minimo_promocao_plan
end type

type tab_1 from w_ge134_manutencao_minimo_promocao`tab_1 within w_ge134_manutencao_minimo_promocao_plan
end type

event tab_1::selectionchanging;call super::selectionchanging;If NewIndex = 2 Then

	Tab_1.TabPage_2.dw_3.Object.qt_estoque_minimo_matriz_t.Visible = 1
	Tab_1.TabPage_2.dw_3.Object.qt_estoque_minimo_matriz_l.Visible = 1
	Tab_1.TabPage_2.dw_3.Object.qt_estoque_minimo_matriz.Visible = 1
	
	If Tab_1.TabPage_1.dw_2.RowCount() > 0 Then
		If Date(ivo_Promocao.Dh_Termino_Estoque_Minimo) < Date(gf_getserverdate()) Then
			Tab_1.TabPage_2.dw_3.SetTabOrder('qt_estoque_minimo_promocao', 0)
//			Tab_1.TabPage_2.dw_3.SetTabOrder('qt_estoque_minimo_matriz', 0)
		Else
			Tab_1.TabPage_2.dw_3.SetTabOrder('qt_estoque_minimo_promocao', 1)
//			Tab_1.TabPage_2.dw_3.SetTabOrder('qt_estoque_minimo_matriz', 2)
		End If
	End If

End If
			

end event

type tabpage_1 from w_ge134_manutencao_minimo_promocao`tabpage_1 within tab_1
end type

type gb_2 from w_ge134_manutencao_minimo_promocao`gb_2 within tabpage_1
end type

type gb_1 from w_ge134_manutencao_minimo_promocao`gb_1 within tabpage_1
end type

type dw_1 from w_ge134_manutencao_minimo_promocao`dw_1 within tabpage_1
end type

type dw_2 from w_ge134_manutencao_minimo_promocao`dw_2 within tabpage_1
end type

type cb_minimo from w_ge134_manutencao_minimo_promocao`cb_minimo within tabpage_1
end type

event cb_minimo::clicked;//OverRide

Long lvl_Promocao, &
	  lvl_Retorno

String ls_Responsavel

dw_1.AcceptText()

If Not gvo_aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("GE134_IMPORT_EST_MIN_VIA_EXCEL", Ref ls_Responsavel) Then Return

lvl_Promocao = dw_1.Object.cd_promocao[1]

OpenWithParm(w_ge134_insere_estoque_minimo, String(lvl_Promocao))
end event

type cb_gera_planilha from w_ge134_manutencao_minimo_promocao`cb_gera_planilha within tabpage_1
end type

type dw_5 from w_ge134_manutencao_minimo_promocao`dw_5 within tabpage_1
end type

type tabpage_2 from w_ge134_manutencao_minimo_promocao`tabpage_2 within tab_1
end type

type gb_3 from w_ge134_manutencao_minimo_promocao`gb_3 within tabpage_2
end type

type dw_3 from w_ge134_manutencao_minimo_promocao`dw_3 within tabpage_2
end type

event dw_3::itemchanged;//OverRide

If Not This.of_Coluna_Sem_Validacao_Salva(dwo.Name) Then
	If ivb_UpdateAble Then
		ivw_ParentWindow.ivb_Valida_Salva = True
	End If
End If

If dwo.Name = "qt_estoque_minimo_promocao" Or dwo.Name = "qt_estoque_minimo_matriz" Then
	ivm_Menu.mf_Confirmar(True)
	ivm_Menu.mf_Cancelar(True)
	
	ivb_Salva = True
End If

If dwo.Name = "qt_estoque_minimo_promocao" Then
	If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = 'GC' Then
		This.Object.Qt_Estoque_Minimo_Matriz[row] = Long(Data)
	End If
End If
end event

event dw_3::editchanged;//OverRide

If Not This.of_Coluna_Sem_Validacao_Salva(dwo.Name) Then
	If ivb_UpdateAble Then
		ivw_ParentWindow.ivb_Valida_Salva = True
	End If
End If

If dwo.Name = "qt_estoque_minimo_promocao" Or dwo.Name = "qt_estoque_minimo_matriz" Then
	ivm_Menu.mf_Confirmar(True)
	ivm_Menu.mf_Cancelar(True)
	
	ivb_Salva = True
End If

If dwo.Name = "qt_estoque_minimo_promocao" Then
	If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = 'GC' Then
		This.Object.Qt_Estoque_Minimo_Matriz[row] = Long(Data)
	End If
End If
end event

type gb_5 from w_ge134_manutencao_minimo_promocao`gb_5 within tabpage_2
end type

type gb_4 from w_ge134_manutencao_minimo_promocao`gb_4 within tabpage_2
end type

type dw_4 from w_ge134_manutencao_minimo_promocao`dw_4 within tabpage_2
end type

type dw_6 from w_ge134_manutencao_minimo_promocao`dw_6 within tabpage_2
end type

