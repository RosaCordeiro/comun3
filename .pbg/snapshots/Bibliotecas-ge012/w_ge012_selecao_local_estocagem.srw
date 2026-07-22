HA$PBExportHeader$w_ge012_selecao_local_estocagem.srw
forward
global type w_ge012_selecao_local_estocagem from dc_w_selecao_generica
end type
end forward

global type w_ge012_selecao_local_estocagem from dc_w_selecao_generica
integer x = 654
integer width = 2715
integer height = 1560
string title = "GE012 - Sele$$HEX2$$e700e300$$ENDHEX$$o de Locais de Estocagem"
end type
global w_ge012_selecao_local_estocagem w_ge012_selecao_local_estocagem

event open;call super::open;STRING lvs_local

If IsValid( This ) Then
	lvs_local = Message.StringParm
	
	If lvs_local <> "" THEN
		dw_1.Object.de_local_estocagem[1] = lvs_local
	END IF
	
	ivb_Pesquisa_Direta = TRUE
End If

end event

on w_ge012_selecao_local_estocagem.create
call super::create
end on

on w_ge012_selecao_local_estocagem.destroy
call super::destroy
end on

type pb_help from dc_w_selecao_generica`pb_help within w_ge012_selecao_local_estocagem
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge012_selecao_local_estocagem
integer x = 23
integer y = 188
integer width = 2633
integer height = 1132
string text = "Lista de Locais de Estocagem"
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge012_selecao_local_estocagem
integer x = 23
integer y = 4
integer width = 1527
integer height = 172
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge012_selecao_local_estocagem
integer x = 41
integer y = 64
integer width = 1499
integer height = 100
string dataobject = "dw_ge012_selecao"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge012_selecao_local_estocagem
integer x = 41
integer y = 240
integer width = 2587
integer height = 1048
string dataobject = "dw_ge012_lista"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_de_local

dw_1.AcceptText()

lvs_de_local = TRIM(dw_1.Object.de_local_estocagem[1])

IF Len(lvs_de_local) > 0 THEN
	This.of_AppendWhere(" de_local_estocagem like '" + lvs_de_local + "%'", 2)
END IF

RETURN AncestorReturnValue
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge012_selecao_local_estocagem
integer x = 1893
integer y = 1344
end type

event cb_selecionar::clicked;call super::clicked;Long lvl_Linha, &
     lvl_local

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	lvl_local = dw_2.Object.Cd_local_estocagem[lvl_Linha]
	CloseWithReturn(Parent, lvl_local)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um local.", Information!, Ok!)
	dw_2.SetFocus()
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge012_selecao_local_estocagem
integer x = 2286
integer y = 1344
end type

event cb_cancelar::clicked;call super::clicked;Long lvl_local

SETNULL(lvl_local)

CloseWithReturn(Parent, lvl_local)

end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge012_selecao_local_estocagem
integer x = 1413
integer y = 1344
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge012_selecao_local_estocagem
integer x = 27
integer y = 1356
integer width = 997
end type

