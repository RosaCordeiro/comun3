HA$PBExportHeader$w_ge168_consulta_filial_novo_eb.srw
forward
global type w_ge168_consulta_filial_novo_eb from dc_w_consulta_lista
end type
type cb_1 from commandbutton within w_ge168_consulta_filial_novo_eb
end type
type cb_2 from commandbutton within w_ge168_consulta_filial_novo_eb
end type
type cb_3 from commandbutton within w_ge168_consulta_filial_novo_eb
end type
end forward

global type w_ge168_consulta_filial_novo_eb from dc_w_consulta_lista
integer width = 6528
integer height = 1816
string title = "GE168 - Consulta Filial Novo Estoque Base"
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
end type
global w_ge168_consulta_filial_novo_eb w_ge168_consulta_filial_novo_eb

type variables
Boolean	ib_alteracao_perfil_autorizada
String  ivs_Matric_Logada 

str_ge168_parametros st_ge168_parametros
end variables

forward prototypes
public subroutine wf_atualiza_movimento ()
public function boolean wf_grava_historico ()
public function boolean wf_valida_dados ()
public subroutine wf_set_somente_consulta ()
end prototypes

public subroutine wf_atualiza_movimento ();Date lvdt_Primeira_Venda, ldt_Movimento

String ls_Mensagem

Long ll_Linhas, ll_Linha, ll_Filial, ll_Dias_Movto

ll_Linhas = dw_1.RowCount()

For ll_Linha = 1 To ll_Linhas
	
	ll_Filial			= dw_1.Object.cd_filial									[ll_Linha]
	ldt_Movimento	= Date(dw_1.Object.dh_inicio_movimento_calculo_eb	[ll_Linha])
	
	If ldt_Movimento = Date("01/01/1900") or isnull(ldt_Movimento) Then
		select min(dh_resumo)
		Into :lvdt_Primeira_Venda
		From resumo_movimento_estoque
		where	cd_filial 			= :ll_Filial
	  	   and 	dh_resumo 			>= (select dateadd(day, -365, dh_movimentacao) from parametro where id_parametro = '1')
		   and	vl_venda_avista > 0
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			ls_Mensagem = "Localiza$$HEX2$$e700e300$$ENDHEX$$o a primeira venda da filial '" + String(ll_Filial) + "'. " + SqlCa.SqlErrText
			//This.of_Grava_Log(ai_Log, ls_Mensagem, True)
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Mensagem)
			Return
		End If
	Else
		lvdt_Primeira_Venda = ldt_Movimento
	End If

	Select count(*)
	Into :ll_Dias_Movto
	From resumo_movimento_estoque
	where	cd_filial 				= :ll_Filial
		and	vl_venda_avista 	> 0
		and 	dh_resumo 			>= :lvdt_Primeira_Venda
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		ls_Mensagem = "Localiza$$HEX2$$e700e300$$ENDHEX$$o o n$$HEX1$$fa00$$ENDHEX$$mero de dias de vendas da filial '" + String(ll_Filial) + "'. " + SqlCa.SqlErrText
		//This.of_Grava_Log(ai_Log, ls_Mensagem, True)
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Mensagem)
		Return
	End If
	
	dw_1.Object.qt_dias_movto[ll_Linha] = ll_Dias_Movto
	
Next


end subroutine

public function boolean wf_grava_historico ();Long ll_Linha, ll_Filial, ll_Perfil

String lvs_ValorPara, ls_Operador, ls_Erro, ls_Motivo_Ant, ls_Motivo

Date ldt_Prox_Calc, ldt_Prox_Calc_Ant, ldt_Inicio_Mov_Calc, ldt_Inicio_Mov_Calc_Ant

dw_1.AcceptText()

ls_Operador	= gvo_Aplicacao.ivo_Seguranca.Nr_Matricula

For ll_Linha = 1 To dw_1.RowCount()
	
	ll_Filial = dw_1.Object.cd_filial[ll_Linha]
	
	Select	 cd_perfil_estoque, coalesce(de_motivo_inicio_movto_calc_eb, '')
		Into :ll_Perfil, :ls_Motivo_Ant
	From filial
	Where cd_filial = :ll_Filial
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgdbError("Erro ao localizar o perfil de estoque")
		SqlCa.of_RollBack();
		Return False
	End If

	If gf_Houve_Alteracao_Dw(dw_1, 'CD_PERFIL_ESTOQUE',ll_Linha, ref lvs_ValorPara) Then
		If Not gf_Grava_Historico_Alteracao_Tabela('FILIAL', String(ll_Filial), 'CD_PERFIL_ESTOQUE', String(ll_Perfil), &
																lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
	End If
	
	ldt_Prox_Calc		= Date(dw_1.Object.dh_proximo_calculo		[ll_Linha])
	ldt_Prox_Calc_Ant	= Date(dw_1.Object.dh_proximo_calculo_ant	[ll_Linha])
	
	If ldt_Prox_Calc <> ldt_Prox_Calc_Ant Then
		
		Update parametro_reposicao_estoque
		Set dh_proximo_calculo = :ldt_Prox_Calc
		Where cd_filial = :ll_Filial
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgdbError("Erro ao atualizar o pr$$HEX1$$f300$$ENDHEX$$ximo c$$HEX1$$e100$$ENDHEX$$lculo")
			SqlCa.of_RollBack();
			Return False
		End If
		
		If Sqlca.SQLNRows <> 2 Then
			SqlCa.of_RollBack();
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Foi alterado mais registros que o esperado.")
			Return False
		End If
		
	End If

	ldt_Inicio_Mov_Calc 		= Date(dw_1.Object.dh_inicio_movimento_calculo_eb[ll_Linha])
	ldt_Inicio_Mov_Calc_Ant	= Date(dw_1.Object.dh_inicio_mov_calculo_eb_ant	[ll_Linha])
	
	If Not IsNull(ldt_Inicio_Mov_Calc) Then
		//Se teve altera$$HEX2$$e700e300$$ENDHEX$$o
		If (ldt_Inicio_Mov_Calc <> ldt_Inicio_Mov_Calc_Ant) Or IsNull(ldt_Inicio_Mov_Calc_Ant) Then
			If gf_Houve_Alteracao_Dw(dw_1, 'DH_INICIO_MOVIMENTO_CALCULO_EB',ll_Linha, ref lvs_ValorPara) Then
				If Not gf_Grava_Historico_Alteracao_Tabela('FILIAL', String(ll_Filial), 'DH_INICIO_MOVIMENTO_CALCULO_EB', String(ldt_Inicio_Mov_Calc_Ant), &
																	lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
			End If
			
			ls_Motivo = dw_1.Object.De_Motivo_Inicio_Movto_Calc_Eb[ll_Linha]
		
			If ls_Motivo_Ant <> ls_Motivo Then
				If gf_Houve_Alteracao_Dw(dw_1, 'DE_MOTIVO_INICIO_MOVTO_CALC_EB',ll_Linha, ref lvs_ValorPara) Then
					If Not gf_Grava_Historico_Alteracao_Tabela('FILIAL', String(ll_Filial), 'DE_MOTIVO_INICIO_MOVTO_CALC_EB', String(ls_Motivo_Ant), &
																		lvs_ValorPara, ls_Operador, 'A', Ref ls_Erro, True) Then Return False
				End If
			End If
		End If
	End If
	
Next

Return True
end function

public function boolean wf_valida_dados ();Long ll_Linha

Date ldt_Prox_Calc, ldt_Prox_Calc_Ant, lvdt_Movimentacao, ldt_Data_Limite, ldt_Inicio_Mov_Calc, ldt_Inicio_Mov_Calc_Ant, ldt_Limite_Max, ldt_Limite_Min

dw_1.AcceptText()

lvdt_Movimentacao = Date(gvo_Parametro.of_DH_Movimentacao())

ldt_Data_Limite = RelativeDate(lvdt_Movimentacao, 20)
ldt_Limite_Min = RelativeDate(lvdt_Movimentacao, -30)
ldt_Limite_Max = RelativeDate(lvdt_Movimentacao, 30)

For ll_Linha = 1 To dw_1.RowCount()
			
	ldt_Inicio_Mov_Calc 		= Date(dw_1.Object.dh_inicio_movimento_calculo_eb[ll_Linha])
	ldt_Inicio_Mov_Calc_Ant	= Date(dw_1.Object.dh_inicio_mov_calculo_eb_ant	[ll_Linha])
	
	ldt_Prox_Calc		= Date(dw_1.Object.dh_proximo_calculo			[ll_Linha])
	ldt_Prox_Calc_Ant	= Date(dw_1.Object.dh_proximo_calculo_ant	[ll_Linha])
	
	If Not IsNull(ldt_Inicio_Mov_Calc) Then
		//Se teve altera$$HEX2$$e700e300$$ENDHEX$$o
		If (ldt_Inicio_Mov_Calc <> ldt_Inicio_Mov_Calc_Ant) Or IsNull(ldt_Inicio_Mov_Calc_Ant) Then
			
			If (ldt_Inicio_Mov_Calc < ldt_Limite_Min) Or (ldt_Inicio_Mov_Calc > ldt_Limite_Max) Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$", "A data de in$$HEX1$$ed00$$ENDHEX$$cio do movimento do estoque base n$$HEX1$$e300$$ENDHEX$$o pode ser menor e nem maior que 30 dias.~r" + &
											"~rData Limite M$$HEX1$$ed00$$ENDHEX$$nima: " + String(ldt_Limite_Min) + &
											"~rData Limite M$$HEX1$$e100$$ENDHEX$$xima: " + String(ldt_Limite_Max), Exclamation!)
				dw_1.Event ue_Pos(ll_Linha, "dh_inicio_movimento_calculo_eb")
				Return False
			End If
			
			If IsNull(dw_1.Object.De_Motivo_Inicio_Movto_Calc_Eb[ll_Linha]) Or Trim(dw_1.Object.De_Motivo_Inicio_Movto_Calc_Eb[ll_Linha]) = "" Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o motivo de altera$$HEX2$$e700e300$$ENDHEX$$o.", Exclamation!)
				dw_1.Event ue_Pos(ll_Linha, "de_motivo_inicio_movto_calc_eb")
				Return False
			End If
			
			If LenA(dw_1.Object.De_Motivo_Inicio_Movto_Calc_Eb[ll_Linha]) < 10 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O motivo de altera$$HEX2$$e700e300$$ENDHEX$$o deve ter ao menos 10 caracteres.", Exclamation!)
				dw_1.Event ue_Pos(ll_Linha, "de_motivo_inicio_movto_calc_eb")
				Return False
			End If
		End If
	End If
	
	If ldt_Prox_Calc <> ldt_Prox_Calc_Ant Then
		
		If ldt_Prox_Calc <= lvdt_Movimentacao Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data do pr$$HEX1$$f300$$ENDHEX$$ximo c$$HEX1$$e100$$ENDHEX$$lculo dever$$HEX1$$e100$$ENDHEX$$ ser maior que a data de hoje.")
			dw_1.Event ue_Pos(ll_Linha, "dh_proximo_calculo")
			Return False
		End If
		
		If ldt_Prox_Calc > ldt_Data_Limite Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data do pr$$HEX1$$f300$$ENDHEX$$ximo c$$HEX1$$e100$$ENDHEX$$lculo n$$HEX1$$e300$$ENDHEX$$o pode ser maior que '" + String(ldt_Data_Limite) + "'.")
			dw_1.Event ue_Pos(ll_Linha, "dh_proximo_calculo")
			Return False
		End If		
	End If
	
Next

Return True
end function

public subroutine wf_set_somente_consulta ();dw_1.of_set_somente_leitura(This.ivm_Menu.ivb_permite_alterar)
end subroutine

on w_ge168_consulta_filial_novo_eb.create
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

on w_ge168_consulta_filial_novo_eb.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
end on

event ue_postopen;call super::ue_postopen;dc_uo_dw_Base lvo_Update[]
lvo_Update = {dw_1}
ivs_Matric_Logada = gvo_Aplicacao.ivo_Seguranca.Nr_Matricula

If ivs_Matric_Logada = '14231'  or ivs_Matric_Logada = '505273'   or   ivs_Matric_Logada = '505315'     Then 
	cb_1.visible = True 
	dw_1.Object.qtd_dias_movto.tabsequence = '40'
Else
	cb_1.visible = False 
	dw_1.Object.qtd_dias_movto.tabsequence = '0'
End If 

This.wf_SetUpdate_DW(lvo_Update)
end event

event ue_preupdate;call super::ue_preupdate;If Not wf_valida_dados() Then Return False

If Not wf_grava_historico() Then Return False

Return True
end event

event ue_save;call super::ue_save;If AncestorReturnValue = 1 Then	
	dw_1.Event ue_Retrieve()
End If

Return AncestorReturnValue
end event

event ue_cancel;call super::ue_cancel;ivm_Menu.mf_Confirmar(False)
ivm_Menu.mf_Cancelar(False)

dw_1.Event ue_Retrieve()
end event

type dw_visual from dc_w_consulta_lista`dw_visual within w_ge168_consulta_filial_novo_eb
integer x = 37
integer y = 1152
end type

type gb_aux_visual from dc_w_consulta_lista`gb_aux_visual within w_ge168_consulta_filial_novo_eb
integer x = 0
integer y = 1080
end type

type dw_1 from dc_w_consulta_lista`dw_1 within w_ge168_consulta_filial_novo_eb
integer x = 50
integer y = 76
integer width = 6405
integer height = 1396
string dataobject = "dw_ge168_lista_filiais_novo_calculo_eb"
boolean hscrollbar = true
boolean hsplitscroll = true
end type

event dw_1::constructor;call super::constructor;This.of_SetRowSelection()
This.ivb_Ordena_Colunas = True
end event

event dw_1::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	This.ivo_Controle_Menu.of_SalvarComo(True)
	wf_atualiza_movimento()
Else
	This.ivo_Controle_Menu.of_SalvarComo(False)
End If

Return pl_Linhas
end event

event dw_1::editchanged;call super::editchanged;Parent.ivm_Menu.mf_Confirmar(True)
Parent.ivm_Menu.mf_Cancelar(True)
end event

event dw_1::itemchanged;call super::itemchanged;Date	ld_dh_proximo_calculo
Long	ll_qt_filiais_agendadas_dia, ll_qt_max_filiais_recalculo_est_base_dia
String	ls_Operador

Parent.ivm_Menu.mf_Confirmar(True)
Parent.ivm_Menu.mf_Cancelar(True)

Choose case dwo.name
	Case 'dh_proximo_calculo'
		ld_dh_proximo_calculo = Date(data)
		
		select cast(vl_parametro as integer)
		  into :ll_qt_max_filiais_recalculo_est_base_dia
		  from parametro_geral
		 where cd_parametro = 'QT_MAX_FILIAIS_RECALCULO_EST_BASE_DIA';
		 
		Choose Case SQLCA.SQLCode
			Case -1
				MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao buscar o par$$HEX1$$e200$$ENDHEX$$metro QT_MAX_FILIAIS_RECALCULO_EST_BASE_DIA. '  + SQLCA.SQLErrTExt, StopSign!)
				return 2
			Case 100
				MessageBox("aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi encontrado o par$$HEX1$$e200$$ENDHEX$$metro QT_MAX_FILIAIS_RECALCULO_EST_BASE_DIA.", StopSign!)
				return 2
		End Choose
		
		if ll_qt_max_filiais_recalculo_est_base_dia > 0 then
			select count(*)
			  into :ll_qt_filiais_agendadas_dia
			  from parametro_reposicao_estoque pre
			 inner join filial f
						on f.cd_filial = pre.cd_filial
			 where pre.dh_proximo_calculo 	= :ld_dh_proximo_calculo
				and pre.id_tipo_reposicao		= 'E'
				and f.id_situacao					= 'A'
				and f.id_pedido_centralizado	= 'S'
			 using SQLCA;
			 
			 Choose Case SQLCA.SQLCode
				Case -1
					MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao buscar a quantidade de filiais agendadas para esta data. ' + SQLCA.SQLErrTExt, StopSign!)
					return 2
			End Choose
			
			if IsNull(ll_qt_filiais_agendadas_dia) then ll_qt_filiais_agendadas_dia = 0
			
			if ll_qt_max_filiais_recalculo_est_base_dia <= ll_qt_filiais_agendadas_dia then
				MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ mais poss$$HEX1$$ed00$$ENDHEX$$vel agendar o c$$HEX1$$e100$$ENDHEX$$lculo para o dia ' + String(ld_dh_proximo_calculo, 'dd/mm/yyyy') + ' devido a quantidade de filiais agendadas para esse dia. Por favor selecione um dia diferente.', StopSign!)
				return 2
			end if
		end if
		
	case 'cd_perfil_estoque'
		//A altera$$HEX2$$e700e300$$ENDHEX$$o desta coluna s$$HEX1$$f300$$ENDHEX$$ $$HEX1$$e900$$ENDHEX$$ permitida para usu$$HEX1$$e100$$ENDHEX$$rios autorizados (chamado 1101170)
		if not ib_alteracao_perfil_autorizada then
			If not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("W_GE168_ALTERAR_PERFIL_ESTOQUE ", ref ls_Operador) Then
				Return 2
			else
				ib_alteracao_perfil_autorizada = True
			End if
		End if
End Choose
end event

type gb_1 from dc_w_consulta_lista`gb_1 within w_ge168_consulta_filial_novo_eb
integer width = 6437
integer height = 1488
integer weight = 700
string text = "Filiais"
end type

type cb_1 from commandbutton within w_ge168_consulta_filial_novo_eb
boolean visible = false
integer x = 1303
integer y = 1516
integer width = 667
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Alterar Dias Movimento"
end type

event clicked;String ls_Matric_Logada, ls_Chave, ls_Achou, ls_MSG, ls_UF, ls_Perfil_Estoq_Atual, ls_Perfil, ls_Parametro,ls_Dias
Long ll_Filial, ll_Registros, ll_Perfil_Estoque
dw_1.AcceptText()

If ivs_Matric_Logada = '14231'  or ivs_Matric_Logada = '505273'  or ivs_Matric_Logada = '505315' Then
	
	ll_Filial 					= dw_1.Object.cd_filial				[dw_1.GetRow()]
	ls_Dias					= dw_1.Object.qtd_dias_movto		[dw_1.GetRow()]
		
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Alterar o dias movimento para a filial [" + String(ll_Filial) + "] ?", Question!, YesNo!, 2) = 1 Then
		
		ls_Chave = String(ll_Filial, '0000') + '@#!QT_DIAS_MOVIMENTO_CALCULO_ESTOQUE_BASE'

		Select vl_parametro
		Into :ls_Achou
		From parametro_loja
		Where cd_filial = :ll_Filial
			and cd_parametro = 'QT_DIAS_MOVIMENTO_CALCULO_ESTOQUE_BASE'
		Using SqlCa;
		
		Choose Case SqlCa.SqlCode
			Case 0
				
				Update parametro_loja
				Set vl_parametro = :ls_Dias
				Where cd_filial = :ll_Filial
				And cd_parametro = 'QT_DIAS_MOVIMENTO_CALCULO_ESTOQUE_BASE'
				Using SqlCa;
				
				If SqlCa.Sqlcode = -1 Then
					SqlCa.of_RollBack();
					SqlCa.of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro 'QT_DIAS_MOVIMENTO_CALCULO_ESTOQUE_BASE'.")
					Return 
				End If	
				
				ll_Registros = Sqlca.SQLNRows
				
				If Not gf_Grava_Historico_Alteracao_Tabela('PARAMETRO_LOJA', ls_Chave, 'VL_PARAMETRO', ls_Achou,&
																ls_Dias , ls_Matric_Logada, 'A', ref ls_MSG, True) Then
					SqlCa.of_RollBack();
					Return
				End If
	
			Case 100
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Par$$HEX1$$e200$$ENDHEX$$metro n$$HEX1$$e300$$ENDHEX$$o cadastrado.")
			Case -1
				SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro 'QT_DIAS_MOVIMENTO_CALCULO_ESTOQUE_BASE'.")
				Return
		End Choose
				
				
		SqlCa.of_Commit();
		dw_1.Event ue_Retrieve();
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O par$$HEX1$$e200$$ENDHEX$$metro dias movimento alterado com sucesso somente para filial: [" + String(ll_Filial) +"]")
		
	End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Us$$HEX1$$fa00$$ENDHEX$$ario n$$HEX1$$e300$$ENDHEX$$o liberado para alterar o par$$HEX1$$e200$$ENDHEX$$metro. ~rUsu$$HEX1$$e100$$ENDHEX$$rios Liberados: Sergio Gol / Sergio Lopes.")
End If
end event

type cb_2 from commandbutton within w_ge168_consulta_filial_novo_eb
integer x = 18
integer y = 1516
integer width = 1234
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Consultar Dias de Cobertura (Perfil Estoque)"
end type

event clicked;Long ll_Perfil_Estoque

dw_1.AcceptText()

If dw_1.GetRow() > 0 Then
	ll_Perfil_Estoque = dw_1.Object.cd_perfil_estoque[dw_1.GetRow()]
	OpenWithParm(w_ge168_perfil_estoque, String(ll_Perfil_Estoque))
End If
end event

type cb_3 from commandbutton within w_ge168_consulta_filial_novo_eb
string tag = "Consultar Hist$$HEX1$$f300$$ENDHEX$$rico de Altera$$HEX2$$e700e300$$ENDHEX$$o (Perfil de Estoque)"
integer x = 2021
integer y = 1516
integer width = 1399
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Consultar Hist$$HEX1$$f300$$ENDHEX$$rico de Altera$$HEX2$$e700e300$$ENDHEX$$o (Perfil de Estoque)"
end type

event clicked;/*
Helpdesk: 1101188
Tipo: Melhoria
Autor: Jo$$HEX1$$e300$$ENDHEX$$o Lopes
Motivo: Cria$$HEX2$$e700e300$$ENDHEX$$o de relat$$HEX1$$f300$$ENDHEX$$rio com hist$$HEX1$$f300$$ENDHEX$$rico de altera$$HEX2$$e700e300$$ENDHEX$$o de perfil de estoque
*/
long ll_linha

dw_1.AcceptText()

/* Linha Selecionada */
ll_linha = dw_1.GetRow()

/* Se a linha selecionada for maior (>) que 0... */
If ll_linha > 0 Then
	/* ... Executa o processo */
	
	/* 
	A$$HEX2$$e700e300$$ENDHEX$$o: Carrega a estrutura de parametros com linha selecionada no objeto dw_1
	Valores: Codigo e Nome Fantasia da Filial  
	*/
	st_ge168_parametros.cd_filial = dw_1.Object.cd_filial[ll_linha]
	st_ge168_parametros.nm_fantasia = dw_1.Object.nm_fantasia[ll_linha]
	
	/* Abre a window de consulta usando a estrutura de parametros carregada */
	OpenWithParm(w_ge168_historico_perfil, st_ge168_parametros)
End If

end event

