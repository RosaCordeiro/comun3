HA$PBExportHeader$w_ge425_agendamento_recalculo.srw
forward
global type w_ge425_agendamento_recalculo from dc_w_cadastro_selecao_lista
end type
type cb_selecao from commandbutton within w_ge425_agendamento_recalculo
end type
type st_mensagem from statictext within w_ge425_agendamento_recalculo
end type
end forward

global type w_ge425_agendamento_recalculo from dc_w_cadastro_selecao_lista
integer width = 3639
integer height = 2516
string title = "GE425 - Agendamento do Pr$$HEX1$$f300$$ENDHEX$$ximo Rec$$HEX1$$e100$$ENDHEX$$lculo"
cb_selecao cb_selecao
st_mensagem st_mensagem
end type
global w_ge425_agendamento_recalculo w_ge425_agendamento_recalculo

type variables
uo_ge216_filiais io_Selecao_filiais 

String ivs_filiais, ivs_nulo, ivs_Matricula_Alteracao
end variables

forward prototypes
public function boolean wf_verifica_vendas ()
public function boolean wf_atualiza_parametro_reposicao_estoque (date adt_recalculo)
public function boolean wf_salva ()
public function boolean wf_consulta_movimento (long al_filial, long al_linha, datetime adh_inicio_movto_eb)
end prototypes

public function boolean wf_verifica_vendas ();Date lvdt_Primeira_Venda

DateTime ldt_Inicio_Movto_Calculo_EB

Boolean lvb_Erro = False

Long 	lvl_Linha,&
		lvl_Filial,&
		lvl_Dias_Movimento,&
		ll_Dias_Controle
		
String lvs_Reduz_EB

Open(w_Aguarde)

w_Aguarde.Title = "Verificando o movimento das lojas..."

w_Aguarde.uo_progress.of_SetMax(dw_2.RowCount())

For lvl_Linha = 1 To  dw_2.RowCount()
	
	lvs_Reduz_EB 						= dw_2.Object.id_reduz_estoque_base				[lvl_Linha]
	lvl_Filial								= dw_2.Object.cd_filial									[lvl_Linha]
	lvl_Dias_Movimento				= dw_2.Object.qt_dias_movimento					[lvl_Linha]
	ldt_Inicio_Movto_Calculo_EB		= dw_2.Object.dh_inicio_movimento_calculo_eb	[lvl_Linha]
	
	If lvl_Filial = 506 Then
		lvl_Filial = 506
	End If
	
	// Para for$$HEX1$$e700$$ENDHEX$$ar o sistema a olhar os movimentos destas lojas
	//If Not IsNull(ldt_Inicio_Movto_Calculo_EB) Then  lvl_Dias_Movimento = 0 
	
	If dw_2.Object.id_novo_calculo[lvl_Linha] = 'SIM' Then
		ll_Dias_Controle = 100
	Else
		ll_Dias_Controle = 90
	End If
				
	If Not wf_Consulta_Movimento(lvl_Filial, lvl_Linha, ldt_Inicio_Movto_Calculo_EB) Then
		lvb_Erro = True
		Exit
	End If
	
	lvl_Dias_Movimento	= dw_2.Object.qt_dias_movimento[lvl_Linha]
	
	If lvs_Reduz_EB = "N" and lvl_Dias_Movimento >= ll_Dias_Controle Then
		dw_2.Object.id_reduz[lvl_Linha]  = 'S'
	End If
	
	If lvs_Reduz_EB = "S" and lvl_Dias_Movimento < ll_Dias_Controle Then
		// N$$HEX1$$e300$$ENDHEX$$o deveria reduzir
		dw_2.Object.id_reduz						[lvl_Linha]  	= 'N'
		dw_2.Object.id_reduz_estoque_base	[lvl_Linha] 	= 'N'
	End If
	
	w_Aguarde.uo_progress.of_SetProgress(lvl_Linha)
	
Next

Close(w_Aguarde)

If lvb_Erro Then
	SqlCa.of_Rollback()
	//cb_confirma.Enabled = False	
Else
	SqlCa.of_Commit()
	//cb_confirma.Enabled = True
End If

Return True
end function

public function boolean wf_atualiza_parametro_reposicao_estoque (date adt_recalculo);Boolean lvb_Sucesso = True

Long 	lvl_Linha,&
	 	lvl_Filial
	 
String	lvs_Selecao,&
		lvs_Reduz,&
		ls_NOVO_CALCULO_EB,&
		lvs_Reduz_Ant

For lvl_Linha = 1 To dw_2.RowCount()
	
	lvl_Filial   		= dw_2.Object.cd_filial 							[lvl_Linha]
	lvs_Selecao  	= dw_2.Object.id_selecao						[lvl_Linha] 
	lvs_Reduz	  	= dw_2.Object.id_reduz_estoque_base		[lvl_Linha] 
	lvs_Reduz_Ant 	= dw_2.Object.id_reduz_estoque_base_ant	[lvl_Linha] 	
		
	If lvs_Selecao = 'S' Then
		
		If Not gf_utiliza_novo_calculo_eb(lvl_Filial, ref ls_NOVO_CALCULO_EB) Then Return False
				
		If ls_NOVO_CALCULO_EB = 'S' Then Continue
				
		Update parametro_reposicao_estoque 
		Set dh_inicio_periodo_1  			= dateadd(day, -84, :adt_Recalculo), 
			dh_termino_periodo_1 			= dateadd(day, -71, :adt_Recalculo),   
			dh_inicio_periodo_2  			= dateadd(day, -70, :adt_Recalculo),   
			dh_termino_periodo_2 			= dateadd(day, -57, :adt_Recalculo),   
			dh_inicio_periodo_3  			= dateadd(day, -56, :adt_Recalculo),   
			dh_termino_periodo_3 			= dateadd(day, -43, :adt_Recalculo),   
			dh_inicio_periodo_4  			= dateadd(day, -42, :adt_Recalculo),   
			dh_termino_periodo_4 			= dateadd(day, -29, :adt_Recalculo),   
			dh_inicio_periodo_5  			= dateadd(day, -28, :adt_Recalculo),   
			dh_termino_periodo_5 			= dateadd(day, -15, :adt_Recalculo),   
			dh_inicio_periodo_6  			= dateadd(day, -14, :adt_Recalculo),   
			dh_termino_periodo_6 			= dateadd(day,  -1, :adt_Recalculo),   
			id_periodos_atualizados 		= 'S',   
			dh_proximo_calculo      		= :adt_Recalculo,
			nr_matricula_proximo_recalculo 	= :ivs_Matricula_Alteracao,
			id_reduz_estoque_base		= :lvs_Reduz
		 From parametro_reposicao_estoque p
		Where p.id_tipo_reposicao = 'E' 
		  and p.cd_filial = :lvl_Filial
		Using SqlCa;
		  
	  	If SqlCa.SqlCode = -1 Then
		  	SqlCa.of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o da data do pr$$HEX1$$f300$$ENDHEX$$ximo rec$$HEX1$$e100$$ENDHEX$$lculo")
		  	lvb_Sucesso = False
	  	End If
		  
		If lvb_Sucesso Then
			Update parametro_reposicao_estoque 
			Set dh_inicio_periodo_1  			= dateadd(day, -365, :adt_Recalculo), 
				dh_termino_periodo_1 			= dateadd(day, -352, :adt_Recalculo),   
				dh_inicio_periodo_2  			= dateadd(day, -351, :adt_Recalculo),   
				dh_termino_periodo_2 			= dateadd(day, -338, :adt_Recalculo),   
				dh_inicio_periodo_3  			= dateadd(day,  -56, :adt_Recalculo),   
				dh_termino_periodo_3 			= dateadd(day,  -43, :adt_Recalculo),   
				dh_inicio_periodo_4  			= dateadd(day,  -42, :adt_Recalculo),   
				dh_termino_periodo_4 			= dateadd(day,  -29, :adt_Recalculo),   
				dh_inicio_periodo_5  			= dateadd(day,  -28, :adt_Recalculo),   
				dh_termino_periodo_5 			= dateadd(day,  -15, :adt_Recalculo),   
				dh_inicio_periodo_6  			= dateadd(day,  -14, :adt_Recalculo),   
				dh_termino_periodo_6 			= dateadd(day,   -1, :adt_Recalculo),   
				id_periodos_atualizados 		= 'S',   
				dh_proximo_calculo      		= :adt_Recalculo,
				nr_matricula_proximo_recalculo 	= :ivs_Matricula_Alteracao,
				id_reduz_estoque_base		= :lvs_Reduz
 			From parametro_reposicao_estoque p
			Where p.id_tipo_reposicao = 'S' and
				  p.cd_filial =:lvl_Filial
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				SqlCa.of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o da data do pr$$HEX1$$f300$$ENDHEX$$ximo rec$$HEX1$$e100$$ENDHEX$$lculo.")
				lvb_Sucesso = False
			End If
		End If
	Else
		If lvs_Reduz_Ant <> lvs_Reduz Then
			Update parametro_reposicao_estoque 
			Set id_reduz_estoque_base		= :lvs_Reduz
			 From parametro_reposicao_estoque p
			Where p.cd_filial = :lvl_Filial
			Using SqlCa;
			  
			If SqlCa.SqlCode = -1 Then
				SqlCa.of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o da redu$$HEX2$$e700e300$$ENDHEX$$o do EB calculado")
				lvb_Sucesso = False
			End If
		End If			
	End If
	
	If Not lvb_Sucesso Then Exit
Next

Return lvb_Sucesso 
end function

public function boolean wf_salva ();Date lvdt_Recalculo,&
	 lvdt_Movimentacao,&
	 lvdt_Data_Limite
	 
Integer lvi_Filiais

Long ll_Dia

String lvs_Dia

dw_1.AcceptText()

lvdt_Recalculo 	  		= dw_1.Object.dh_recalculo[1]
lvdt_Movimentacao 	= Date(gvo_Parametro.of_DH_Movimentacao())
lvs_Dia 		  			= Upper(DayName(lvdt_Recalculo))
lvi_Filiais 	  			= dw_2.GetItemNumber(dw_2.RowCount(), "total_fil")
ll_Dia						= Day(lvdt_Recalculo)

// Se n$$HEX1$$e300$$ENDHEX$$o tiver selecinada o usu$$HEX1$$e100$$ENDHEX$$rio pode estar alterando somente se $$HEX1$$e900$$ENDHEX$$ ou n$$HEX1$$e300$$ENDHEX$$o para reduzir o EB.
If lvi_Filiais > 0 Then
	If Isnull(lvdt_Recalculo) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data do pr$$HEX1$$f300$$ENDHEX$$ximo rec$$HEX1$$e100$$ENDHEX$$lculo corretamente.")
		dw_1.Event ue_Pos(1, "dh_recalculo")
		Return False
	End If
	
	lvdt_Data_Limite = RelativeDate(lvdt_Movimentacao, 30)
	If lvdt_Recalculo > lvdt_Data_Limite Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data do rec$$HEX1$$e100$$ENDHEX$$lculo n$$HEX1$$e300$$ENDHEX$$o pode maior que '" + String(lvdt_Data_Limite, "dd/mm/yyyy") +  "'.")
		dw_1.Event ue_Pos(1, "dh_recalculo")
		Return False
	End If	
	
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma o agendamento do rec$$HEX1$$e100$$ENDHEX$$lculo ?", Question!, YesNo!, 2) = 2 Then Return False
End If

// Se for selecionada mais de uma loja a data deve ser maior que a data atual
// e n$$HEX1$$e300$$ENDHEX$$o pode ser S$$HEX1$$c100$$ENDHEX$$BADO ou DOMINGO
If lvi_Filiais > 1 Then
	
	If lvdt_Recalculo <= lvdt_Movimentacao Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data do rec$$HEX1$$e100$$ENDHEX$$lculo deve ser maior que a data atual '" + String(lvdt_Movimentacao, "dd/mm/yyyy") + "'.")
		dw_1.Event ue_Pos(1, "dh_recalculo")
		Return False
	End If
Else
	If lvdt_Recalculo < lvdt_Movimentacao Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data do rec$$HEX1$$e100$$ENDHEX$$lculo deve ser maior ou igual a data atual '" + String(lvdt_Movimentacao, "dd/mm/yyyy") + "'.")
		dw_1.Event ue_Pos(1, "dh_recalculo")
		Return False
	End If
	
	If lvi_Filiais = 0 Then
		//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione pelo menos uma filial.")
		
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", 	"Nenhuma loja foi selecionada para agendar o c$$HEX1$$e100$$ENDHEX$$lculo do EB.~r" +&
											"Somente ser$$HEX1$$e100$$ENDHEX$$ atualizado o par$$HEX1$$e200$$ENDHEX$$metro <Reduzir EB> (caso tenha sido alterado). ~r~r"+&
											"Deseja continuar mesmo assim ?", Question!, YesNo!, 2) = 2 Then Return False
	End If
End If

If Not lf_ge425_limite_agendamentos(lvi_Filiais, lvdt_Recalculo) Then Return False

If ll_Dia = 1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O rec$$HEX1$$e100$$ENDHEX$$lculo n$$HEX1$$e300$$ENDHEX$$o pode ser agendado para o dia 1$$HEX1$$ba00$$ENDHEX$$.")
	dw_1.Event ue_Pos(1, "dh_recalculo")
	Return False
End If

If wf_Atualiza_Parametro_Reposicao_Estoque(lvdt_Recalculo) Then
	SqlCa.of_Commit();
	If lvi_Filiais = 0 Then
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Atualiza$$HEX2$$e700e300$$ENDHEX$$o realizada com sucesso.")
	Else
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data do pr$$HEX1$$f300$$ENDHEX$$ximo rec$$HEX1$$e100$$ENDHEX$$lculo foi atualizada com sucesso.")
	End If
	dw_2.Event ue_Retrieve()
	Return True
Else
	SqlCa.of_RollBack();
	Return False
End If
end function

public function boolean wf_consulta_movimento (long al_filial, long al_linha, datetime adh_inicio_movto_eb);DateTime ldt_Primeira_Venda

Long lvl_Vendas

If IsNull(adh_inicio_movto_eb) Then
	// Pega somente o movimento do $$HEX1$$fa00$$ENDHEX$$ltimo ano pois para o c$$HEX1$$e100$$ENDHEX$$lculo s$$HEX1$$f300$$ENDHEX$$ interessa no m$$HEX1$$e100$$ENDHEX$$ximo os ultimos 100 dias
	Select count(*)
	Into :lvl_Vendas
	From resumo_movimento_estoque
	where	cd_filial 				= :al_Filial
		and	vl_venda_avista 	> 0
		and 	dh_resumo 			>= (select dateadd(day, -365, dh_movimentacao) from parametro where id_parametro = '1')
	Using SqlCa;
Else
	Select count(*)
	Into :lvl_Vendas
	From resumo_movimento_estoque
	where	cd_filial 				= :al_Filial
		and	vl_venda_avista 	> 0
		and 	dh_resumo 			>= :adh_inicio_movto_eb
	Using SqlCa;
End If

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do n$$HEX1$$fa00$$ENDHEX$$mero de dias de vendas.")
	Return False
End If

Update parametro_reposicao_estoque
Set qt_dias_movimento = :lvl_Vendas
Where cd_filial =:al_Filial
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro reposi$$HEX2$$e700e300$$ENDHEX$$o estoque.")
	Return False
End If

dw_2.Object.qt_dias_movimento[al_Linha] = lvl_Vendas

Return True
end function

on w_ge425_agendamento_recalculo.create
int iCurrent
call super::create
this.cb_selecao=create cb_selecao
this.st_mensagem=create st_mensagem
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_selecao
this.Control[iCurrent+2]=this.st_mensagem
end on

on w_ge425_agendamento_recalculo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_selecao)
destroy(this.st_mensagem)
end on

event ue_postopen;// OverRide

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
wf_set_somente_consulta()

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

//dc_uo_dw_Base lvo_Update[]
//lvo_Update = {dw_2}
//This.wf_SetUpdate_DW(lvo_Update)

dw_1.Event ue_AddRow()

//This.ivm_Menu.mf_Incluir(True)
This.ivm_Menu.mf_Recuperar(True)

//Est$$HEX1$$e100$$ENDHEX$$ habilitado o Aux$$HEX1$$ed00$$ENDHEX$$lio Visual no INI ?
If gvo_aplicacao.ivb_usa_aux_visual Then 
	//Adiciona Linha DW
	If dw_visual.RowCount() = 0 Then dw_visual.Event ue_AddRow()
	//Seta os valores de redimensionamento da tela para compatibilidade com telas redimensionam
	MaxWidth = This.Width
	MaxHeight = This.Height
	//Chama o redimensionamento da tela, onde est$$HEX1$$e100$$ENDHEX$$ tratado onde deve aparecer a DW
	This.Event Resize(0,MaxWidth - 72, MaxHeight)
	//Seta DW visivel
	gb_aux_visual.Visible = True
	dw_visual.Visible = True
	
	Yield()
End If

dw_1.SetFocus()

io_Selecao_filiais 	= Create uo_ge216_filiais
end event

event close;call super::close;Destroy io_Selecao_filiais
end event

event ue_save;//OverRide

If wf_salva() Then
	This.ivm_Menu.mf_Confirmar(False)
	This.ivm_Menu.mf_Cancelar(False)	
End If

Return 1

end event

type dw_visual from dc_w_cadastro_selecao_lista`dw_visual within w_ge425_agendamento_recalculo
integer y = 1504
end type

type gb_aux_visual from dc_w_cadastro_selecao_lista`gb_aux_visual within w_ge425_agendamento_recalculo
integer y = 1432
end type

type dw_1 from dc_w_cadastro_selecao_lista`dw_1 within w_ge425_agendamento_recalculo
integer x = 64
integer y = 76
integer width = 1449
integer height = 188
string dataobject = "dw_ge425_selecao"
end type

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)
end event

event dw_1::itemchanged;call super::itemchanged;Long lvl_Nulo

Long lvl_Lojas

String lvs_Dia_Semana

dw_1.AcceptText()

SetNull(lvl_Nulo)

If This.GetColumnName() = "id_conjunto_filial" Then
		
	ivs_filiais = ivs_nulo 
	
	If Data = 'C' Then
		OpenWithParm(w_ge216_selecao_filiais, io_Selecao_filiais)
		
		lvl_Lojas = Message.DoubleParm
		
		If lvl_Lojas > 0 Then
			ivs_filiais = io_Selecao_filiais.ivs_filiais
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma filial foi selecionada.")					
		End If
	End If
	
	dw_2.Reset()
End If 

If This.GetColumnName() = "dh_recalculo" Then
	
	Choose Case DayNumber(dw_1.Object.dh_recalculo[1])
		Case 1
			lvs_Dia_Semana = 'Domingo'	
		Case 2
			lvs_Dia_Semana = 'Segunda-feira'
		Case 3
			lvs_Dia_Semana = 'Ter$$HEX1$$e700$$ENDHEX$$a-feira'
		Case 4
			lvs_Dia_Semana = 'Quarta-feira'
		Case 5
			lvs_Dia_Semana = 'Quinta-feira'
		Case 6
			lvs_Dia_Semana = 'Sexta-feira'
		Case 7
			lvs_Dia_Semana = 'S$$HEX1$$e100$$ENDHEX$$bado'
	End Choose	
	
	dw_1.Object.st_Dia_Semana.text = Upper(lvs_Dia_Semana)
	
End If


end event

event dw_1::editchanged;call super::editchanged;//If This.GetColumnName() = "id_conjunto_filial" Then
end event

type gb_2 from dc_w_cadastro_selecao_lista`gb_2 within w_ge425_agendamento_recalculo
integer y = 296
integer width = 3520
integer height = 1880
integer weight = 700
fontcharset fontcharset = ansi!
end type

type gb_1 from dc_w_cadastro_selecao_lista`gb_1 within w_ge425_agendamento_recalculo
integer width = 1495
integer height = 268
integer weight = 700
end type

type dw_2 from dc_w_cadastro_selecao_lista`dw_2 within w_ge425_agendamento_recalculo
integer y = 364
integer width = 3392
integer height = 1780
string dataobject = "dw_ge425_lista_filial"
end type

event dw_2::rowfocuschanged;call super::rowfocuschanged;String lvs_Mensagem

Long ll_Dias_Controle

lvs_Mensagem = ''

dw_2.AcceptText()

If This.RowCount() > 0 Then
	
	If dw_2.Object.id_novo_calculo[currentrow] = 'SIM' Then
		ll_Dias_Controle = 100
	Else
		ll_Dias_Controle = 90
	End If
	
	If dw_2.Object.id_reduz_estoque_base[currentrow] = 'N' and dw_2.Object.qt_dias_movimento[currentrow] >= ll_Dias_Controle Then
		lvs_Mensagem = "MAIS DE '" + String(ll_Dias_Controle) + "' DIAS DE MOVTO. *** N$$HEX1$$c300$$ENDHEX$$O VAI REDUZIR O EB *** "
		//st_mensagem.TextColor = rgb(0, 255, 0)
	End If
	
	If dw_2.Object.id_reduz_estoque_base[currentrow] = 'S' and dw_2.Object.qt_dias_movimento[currentrow] < ll_Dias_Controle Then
		lvs_Mensagem = "MENOS DE '" + String(ll_Dias_Controle) + "' DIAS DE MOVTO. *** VAI REDUZIR O EB ***"
		//st_mensagem.TextColor = rgb(255, 255, 0)
	End If
End If

st_mensagem.text = lvs_Mensagem
end event

event dw_2::ue_postretrieve;//OverRide

Boolean lvb_Classificar

If pl_Linhas > 0 Then
	lvb_Classificar = IsValid(This.ivo_Sort)

	This.Event RowFocusChanged(1)
	This.SetRow(1)
	This.SetFocus()
	
	This.ivm_Menu.mf_SalvarComo(True)
	
	wf_verifica_vendas()
	
	//This.of_SetRowSelection("if (id_reduz = ~"S~", rgb(255, 0, 0), if(id_reduz = ~"N~",rgb(255, 255, 0), if(id_reduz = ~"V~",rgb(192, 192, 192), if(id_reduz = ~"S~", rgb(0, 128, 255), rgb(255, 255, 255)))))","")
	This.of_SetRowSelection("if (id_reduz = ~"S~", rgb(0, 255, 0), if(id_reduz = ~"N~",rgb(255, 255, 0), rgb(255, 255, 255) ) )","")
Else
	If pl_Linhas = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.", Information!)
		This.ivm_Menu.mf_SalvarComo(False)
	End If
End If

Parent.ivm_Menu.mf_Classificar(lvb_Classificar)

Return pl_Linhas
end event

event dw_2::ue_recuperar;//OverRide
String ls_Conjunto

dw_1.AcceptText()

ls_Conjunto	= dw_1.Object.id_conjunto_filial[1]

If ls_Conjunto = 'C' and not isnull(ivs_Filiais) and trim(ivs_Filiais) <> ''  Then
	dw_2.of_AppendWhere_SubQuery("f.cd_filial in (" + ivs_Filiais + ")", 2)
End If

Return This.Retrieve()
end event

event dw_2::itemchanged;call super::itemchanged;String lvs_Coluna, lvs_Reduz

Long ll_Dias_Controle

dw_1.AcceptText()

lvs_Coluna = This.GetColumnName()

If lvs_Coluna = 'id_reduz_estoque_base' Then
	
	If dw_2.Object.id_novo_calculo[row] = 'SIM' Then
		ll_Dias_Controle = 100
	Else
		ll_Dias_Controle = 90
	End If
		
	lvs_Reduz = 'Z'	
	
	If Data = 'N' Then
				
		If dw_2.Object.qt_dias_movimento[row] >= ll_Dias_Controle Then
			If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Esta filial possui mais de '" + String(ll_Dias_Controle) +  "' dias de movimenta$$HEX2$$e700e300$$ENDHEX$$o. ~r" +&
								"O sistema n$$HEX1$$e300$$ENDHEX$$o vai reduzir o estoque base.~r~r" +&
								"Confirma a altera$$HEX2$$e700e300$$ENDHEX$$o mesmo assim ?", Question!, YesNo!, 2) = 2 Then
								Return 1
			Else
				// Deveria reduzir
				lvs_Reduz = 'S'				
			End If
		End If
	
	End If
	
	If Data = 'S' and dw_2.Object.qt_dias_movimento[row] < ll_Dias_Controle Then 
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Esta filial possui menos de '" + String(ll_Dias_Controle) +  "' dias de movimento.~r~r" +&
						"O estoque base n$$HEX1$$e300$$ENDHEX$$o pode ser reduzido.", Exclamation!)						
		Return 1
	End If
	
	dw_2.Object.id_reduz[row] = lvs_Reduz
	
End If

end event

event dw_2::constructor;call super::constructor;// Habilitar a ordena$$HEX2$$e700e300$$ENDHEX$$o na coluna
This.ivb_Ordena_Colunas = True
end event

type cb_selecao from commandbutton within w_ge425_agendamento_recalculo
integer x = 3077
integer y = 2196
integer width = 471
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Todas Filiais"
end type

event clicked;Long lvl_Contador

String lvs_Selecao

Date 	lvdt_Recalculo

dw_1.AcceptText()

lvdt_Recalculo 	  = dw_1.Object.dh_recalculo[1]

If This.Text = "&Nenhuma Filial" Then
	This.Text = "&Todas Filiais"
	lvs_Selecao = "N"	
Else
//	If Isnull(lvdt_Recalculo) Then
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data do pr$$HEX1$$f300$$ENDHEX$$ximo rec$$HEX1$$e100$$ENDHEX$$lculo corretamente.")
//		dw_1.Event ue_Pos(1, "dh_recalculo")
//		Return
//	End If
//	
//	If lvdt_Recalculo <= ivdt_Parametro Then
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data do rec$$HEX1$$e100$$ENDHEX$$lculo deve ser maior que a data atual '" + String(ivdt_Parametro, "dd/mm/yyyy") + "'.")
//		dw_1.Event ue_Pos(1, "dh_recalculo")
//		Return
//	End If
	
	This.Text = "&Nenhuma Filial"
	lvs_Selecao = "S"
End If

dw_2.AcceptText()

Parent.ivm_Menu.mf_Confirmar(True)
Parent.ivm_Menu.mf_Cancelar(True)	

For lvl_Contador = 1 To dw_2.RowCount()
	If dw_2.Object.id_novo_calculo[lvl_Contador] <> 'SIM' Then
		dw_2.Object.Id_Selecao[lvl_Contador] = lvs_Selecao
	End If
Next
end event

type st_mensagem from statictext within w_ge425_agendamento_recalculo
integer x = 41
integer y = 2204
integer width = 1486
integer height = 76
boolean bringtotop = true
integer textsize = -7
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
boolean focusrectangle = false
end type

