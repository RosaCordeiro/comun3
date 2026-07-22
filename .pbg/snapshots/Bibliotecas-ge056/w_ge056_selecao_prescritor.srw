HA$PBExportHeader$w_ge056_selecao_prescritor.srw
forward
global type w_ge056_selecao_prescritor from dc_w_selecao_generica
end type
end forward

global type w_ge056_selecao_prescritor from dc_w_selecao_generica
integer x = 379
integer y = 436
integer width = 2674
integer height = 1524
string title = "GE056 - Sele$$HEX2$$e700e300$$ENDHEX$$o de Prescritores"
end type
global w_ge056_selecao_prescritor w_ge056_selecao_prescritor

type variables
uo_prescritor ivo_prescritor

end variables

on w_ge056_selecao_prescritor.create
call super::create
end on

on w_ge056_selecao_prescritor.destroy
call super::destroy
end on

event open;call super::open;String lvs_Parametro

ivo_Prescritor = Message.PowerObjectParm
lvs_Parametro  = ivo_Prescritor.ivs_Parametro

If lvs_Parametro <> "" Then
	
	If IsNumber(lvs_Parametro) Then
		dw_1.Object.nr_registro  [1] = lvs_Parametro
	Else
		dw_1.Object.nm_prescritor[1] = lvs_Parametro
	End If
	
	This.ivb_Pesquisa_Direta = True
	
End If
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge056_selecao_prescritor
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge056_selecao_prescritor
integer y = 288
integer width = 2592
integer height = 1008
string text = "Lista de Prescritores"
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge056_selecao_prescritor
integer y = 16
integer width = 1824
integer height = 260
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge056_selecao_prescritor
integer x = 46
integer width = 1797
integer height = 184
string dataobject = "dw_ge056_selecao"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge056_selecao_prescritor
integer x = 55
integer y = 340
integer width = 2533
integer height = 932
string dataobject = "dw_ge056_lista"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;
String lvs_SQL, &
		 lvs_id_registro, &
		 lvs_nr_registro, &
       lvs_nome

dw_1.AcceptText()

lvs_nome        = Trim(dw_1.Object.nm_prescritor[1])
lvs_id_registro = Trim(dw_1.Object.id_registro[1])
lvs_nr_registro = String(Long(dw_1.Object.nr_registro[1]),'00000000')

If Not IsNull(lvs_Nome) and Trim(lvs_Nome) <> "" Then
	This.of_AppendWhere("nm_prescritor like '" + lvs_nome + "%'" )
End If

If lvs_id_registro <> "T" Then
	This.of_AppendWhere("id_registro = '" + lvs_id_registro + "'")
End If

If Not IsNull(lvs_nr_registro) and Trim(lvs_nr_registro) <> '' Then
	This.of_AppendWhere("nr_registro = '" + lvs_nr_registro + "'")
End If

Return 1
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge056_selecao_prescritor
integer x = 1856
end type

event cb_selecionar::clicked;Long lvl_Linha

String lvs_Cd_Cliente

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	ivo_Prescritor.id_registro   = dw_2.Object.id_registro  [lvl_Linha]
	ivo_Prescritor.nr_registro   = dw_2.Object.nr_registro  [lvl_Linha]
	ivo_Prescritor.nm_prescritor = dw_2.Object.nm_prescritor[lvl_Linha]
	ivo_Prescritor.cd_uf         = dw_2.Object.cd_uf        [lvl_Linha]
	CloseWithReturn(Parent, ivo_Prescritor)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um prescritor.", Information!, Ok!)
	dw_2.SetFocus()
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge056_selecao_prescritor
integer x = 2254
end type

event cb_cancelar::clicked;call super::clicked;String lvs_Cd_Cliente

SetNull(lvs_Cd_Cliente)

CloseWithReturn(Parent, lvs_Cd_Cliente)
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge056_selecao_prescritor
integer x = 1394
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge056_selecao_prescritor
integer x = 41
integer y = 1328
integer width = 1321
end type

