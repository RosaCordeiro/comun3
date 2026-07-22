HA$PBExportHeader$w_ge589_importacao_j1btax.srw
forward
global type w_ge589_importacao_j1btax from dc_w_response_ok_cancela
end type
end forward

global type w_ge589_importacao_j1btax from dc_w_response_ok_cancela
integer width = 2382
integer height = 528
string title = "GE589 - Importa$$HEX2$$e700e300$$ENDHEX$$o J1BTAX SAP -> Sybase"
end type
global w_ge589_importacao_j1btax w_ge589_importacao_j1btax

forward prototypes
public subroutine wf_b_selecionar_arquivo ()
end prototypes

public subroutine wf_b_selecionar_arquivo ();String lvs_Msg, lvs_Arquivo
uo_ge589_importacao_j1btax luo

If IsNull(dw_1.GetItemString(1, "cd_tabela")) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Favor selecionar a tabela a ser importada.", Exclamation!)
	Return
End If

dw_1.AcceptText()

Try
	luo = create uo_ge589_importacao_j1btax
	
	If luo.of_Selecionar_Arquivo(dw_1.GetItemString(1, "cd_tabela"), Ref lvs_Arquivo) Then
		dw_1.SetItem(1, "De_Arquivo", lvs_Arquivo)
		cb_Ok.Enabled = (Right(Lower(lvs_Arquivo), 4) = ".txt") // Habilita se for .txt
	End If
	
Finally
	Destroy luo
End Try
end subroutine

on w_ge589_importacao_j1btax.create
call super::create
end on

on w_ge589_importacao_j1btax.destroy
call super::destroy
end on

event ue_postopen;call super::ue_postopen;pb_help.visible = true
dw_1.SetItem(1, "cd_ambiente_sap", "XXX")
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge589_importacao_j1btax
integer x = 18
integer y = 308
end type

event pb_help::clicked;call super::clicked;String lvs_Msg

lvs_Msg = "Esta interface importa um arquivo (.txt) que contenha dados das tabelas J1BTAX do SAP para o Sybase."
lvs_Msg += '~r~r$$HEX1$$c900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio exportar uma planilha do SAP com layout padr$$HEX1$$e300$$ENDHEX$$o da transa$$HEX2$$e700e300$$ENDHEX$$o SE16N utilizando: '
lvs_Msg += '~r"Exportar > Planilha Eletr$$HEX1$$f400$$ENDHEX$$nica > Formato XLSX".'
lvs_Msg += '~r~rAp$$HEX1$$f300$$ENDHEX$$s exportar, abrir a planilha no Excel e salvar ela como "Texto (separado por tabula$$HEX2$$e700f500$$ENDHEX$$es) (*.txt)"'
lvs_Msg += "~r* Dados a partir da linha 2"
lvs_Msg += "~r~rTabelas:"
lvs_Msg += "~r- J_1BTXPIS"
lvs_Msg += "~r- J_1BTXCOF"
lvs_Msg += "~r- J_1BTXISS"
lvs_Msg += "~r- J_1BTXIC3"
lvs_Msg += "~r- J_1BTXST3"
lvs_Msg += "~r- J_1BTXIP3"

MessageBox("Informa$$HEX2$$e700e300$$ENDHEX$$o", lvs_Msg)
end event

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge589_importacao_j1btax
integer width = 2322
integer height = 288
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge589_importacao_j1btax
integer x = 32
integer width = 2277
integer height = 176
string dataobject = "dw_ge589_selecao"
end type

event dw_1::clicked;call super::clicked;if dwo.name = "b_selecionar_arquivo" then
	wf_b_Selecionar_Arquivo()
end if
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	If This.GetColumnName() = "de_arquivo" Then wf_b_Selecionar_Arquivo()
end if
end event

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.name
	Case 'cd_ambiente_sap', 'cd_tabela'
		This.SetItem(1, 'de_arquivo', '')
End Choose
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge589_importacao_j1btax
integer x = 1701
integer y = 320
boolean enabled = false
end type

event cb_ok::clicked;call super::clicked;String lvs_Msg
uo_ge589_importacao_j1btax luo

Try
	luo = Create uo_ge589_importacao_j1btax
	
	If dw_1.GetItemString(1, "cd_ambiente_sap") = "XXX" Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Favor selecionar o ambiente.", Exclamation!)
		Return
	End If
	
	gvo_Aplicacao.ivo_Seguranca.of_Set_Persiste_Usuario( True )
	luo.ivb_Visual = True
	
	If Not luo.of_Importar_Arquivo(	dw_1.GetItemString(1, "cd_ambiente_sap"), &
												dw_1.GetItemString(1, "cd_tabela"), &
												dw_1.GetItemString(1, "de_arquivo"), ref lvs_Msg) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvs_Msg, StopSign!)
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvs_Msg, Information!)
	End If

Catch (Exception e)
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", e.GetMessage(), StopSign!)
Finally
	Destroy luo
End Try
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge589_importacao_j1btax
integer x = 2034
integer y = 320
end type

