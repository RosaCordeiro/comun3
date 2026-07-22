HA$PBExportHeader$w_ge552_altera_psico_adendo.srw
forward
global type w_ge552_altera_psico_adendo from dc_w_response_ok_cancela
end type
end forward

global type w_ge552_altera_psico_adendo from dc_w_response_ok_cancela
integer width = 2030
integer height = 528
string title = "GE552 - Altera Psico Adendo"
end type
global w_ge552_altera_psico_adendo w_ge552_altera_psico_adendo

type variables
Long il_Produto
end variables

on w_ge552_altera_psico_adendo.create
call super::create
end on

on w_ge552_altera_psico_adendo.destroy
call super::destroy
end on

event ue_postopen;call super::ue_postopen;il_Produto = Long(Message.StringParm)

dw_1.Event ue_Retrieve()

ivb_grava_log = True
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge552_altera_psico_adendo
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge552_altera_psico_adendo
integer width = 1970
integer height = 288
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge552_altera_psico_adendo
integer width = 1911
integer height = 196
string dataobject = "dw_ge552_altera_psico_adendo"
end type

event dw_1::ue_recuperar;//OverRide

Return This.Retrieve(il_Produto)
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge552_altera_psico_adendo
integer x = 1344
integer y = 324
string text = "&Alterar"
end type

event cb_ok::clicked;call super::clicked;Long ll_Achou
Long ll_Produto

String ls_Grupo_Psico
String ls_Adendo
String ls_Adendo_Old
String ls_Erro

dw_1.AcceptText()

ll_Produto		= dw_1.Object.Cd_Produto							[1]
ls_Grupo_Psico = dw_1.Object.Cd_Grupo_Psico_Real				[1]
ls_Adendo 		= dw_1.Object.Cd_Grupo_Psico_Adendo			[1]
ls_Adendo_Old 	= dw_1.Object.Cd_Grupo_Psico_Adendo_Old	[1]
														
If ls_Adendo <> ls_Adendo_Old Then
	
	If ls_Adendo = "W" Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Somente grupo de PSICOTR$$HEX1$$d300$$ENDHEX$$PICO pode ser selecionado.", Exclamation!)
		dw_1.Event ue_Pos(1, "cd_grupo_psico_adendo")
		Return -1
	End If
	
	If ls_Grupo_Psico = ls_Adendo Then
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Grupo Psico e Adendo est$$HEX1$$e300$$ENDHEX$$o iguais.~r~rDeseja continuar mesmo assim?", Question!, YesNo!, 2) = 2 Then
			dw_1.Event ue_Pos(1, "cd_grupo_psico_adendo")
			Return -1
		End If
	End If
	
	Select Count(*)
		Into :ll_Achou
	From grupo_psico_adendo
	Where cd_produto = :ll_Produto
	Using SqlCa;
	
	If SqlCa.SqlCode = - 1 Then
		ls_Erro = SqlCa.SqlErrText
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o produto [" + String(ll_Produto) + "] na grupo_psico_adendo. " + ls_Erro)
		Return -1
	End If
	
	If ll_Achou = 0 Then
		Insert Into grupo_psico_adendo(cd_produto, cd_grupo_atual, cd_grupo_real)
			Values(:ll_Produto, :ls_Grupo_Psico, :ls_Adendo)
		Using SqlCa;
				
	Else
		
		Update grupo_psico_adendo
			Set cd_grupo_real = :ls_Adendo,
				 cd_grupo_atual = :ls_Grupo_Psico
		Where cd_produto = :ll_Produto
		Using SqlCa;
	End If
	
	If SqlCa.SqlCode = -1 Then			
		ls_Erro = SqlCa.SqlErrText
		SqlCa.of_Rollback();
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao inserir/atualizar o produto [" + String(ll_Produto) + "] na grupo_psico_adendo. " + ls_Erro)
		Return -1
	End If
	
	If Not gf_Grava_Historico_Alteracao_Tabela("GRUPO_PSICO_ADENDO", String(ll_Produto), "CD_GRUPO_PSICO_ADENDO", ls_Adendo_Old, ls_Adendo, + &
														gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, "A", Ref ls_Erro, True) Then
		Return -1
	End If
	
	SqlCa.of_Commit();
End If

CloseWithReturn(Parent, "OK")
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge552_altera_psico_adendo
integer x = 1678
integer y = 324
end type

