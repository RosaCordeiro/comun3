HA$PBExportHeader$w_ge007_selecao_motivo_bloqueio.srw
forward
global type w_ge007_selecao_motivo_bloqueio from dc_w_selecao_generica
end type
end forward

global type w_ge007_selecao_motivo_bloqueio from dc_w_selecao_generica
integer width = 2272
integer height = 1548
string title = "GE007 - Sele$$HEX2$$e700e300$$ENDHEX$$o de Motivos de Bloqueio"
end type
global w_ge007_selecao_motivo_bloqueio w_ge007_selecao_motivo_bloqueio

on w_ge007_selecao_motivo_bloqueio.create
call super::create
end on

on w_ge007_selecao_motivo_bloqueio.destroy
call super::destroy
end on

event open;call super::open;STRING lvs_Motivo_Bloqueio

lvs_Motivo_Bloqueio = Message.StringParm

If lvs_Motivo_Bloqueio <> "" Then
	dw_1.Object.De_Motivo_Bloqueio[1] = lvs_Motivo_Bloqueio
	ivb_Pesquisa_Direta = True
End If
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge007_selecao_motivo_bloqueio
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge007_selecao_motivo_bloqueio
integer x = 18
integer y = 192
integer width = 2208
integer height = 1116
long backcolor = 80269524
string text = "Lista de Motivos"
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge007_selecao_motivo_bloqueio
integer x = 18
integer y = 4
integer width = 1504
integer height = 176
long backcolor = 80269524
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge007_selecao_motivo_bloqueio
integer x = 41
integer y = 68
integer width = 1472
integer height = 100
string dataobject = "dw_ge007_selecao"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge007_selecao_motivo_bloqueio
integer x = 41
integer y = 240
integer width = 2162
integer height = 1044
string dataobject = "dw_ge007_lista"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String  lvs_SQL, &
        lvs_Where, &
        lvs_Motivo_Bloqueio

dw_1.AcceptText()

lvs_Motivo_Bloqueio = Trim(dw_1.Object.De_Motivo_Bloqueio[1])

If lvs_Motivo_Bloqueio <> "" Then		
	This.of_AppendWhere("de_motivo_bloqueio like '" + lvs_Motivo_Bloqueio + "%'")
End If

Return AncestorReturnValue
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge007_selecao_motivo_bloqueio
integer x = 1463
integer y = 1332
end type

event cb_selecionar::clicked;call super::clicked;Long lvl_Linha

String lvs_Motivo_Bloqueio
     
lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	lvs_Motivo_Bloqueio = dw_2.Object.Cd_Motivo_Bloqueio[lvl_Linha]
	CloseWithReturn(Parent, lvs_Motivo_Bloqueio)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um Motivo de Bloqueio.", Information!, Ok!)
	dw_2.SetFocus()
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge007_selecao_motivo_bloqueio
integer x = 1856
integer y = 1332
end type

event cb_cancelar::clicked;call super::clicked;STRING lvs_Motivo_Bloqueio

SetNull(lvs_Motivo_Bloqueio)

CloseWithReturn(Parent, lvs_Motivo_Bloqueio)
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge007_selecao_motivo_bloqueio
integer x = 1065
integer y = 1332
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge007_selecao_motivo_bloqueio
integer x = 23
integer y = 1344
integer width = 1010
long backcolor = 80269524
end type

