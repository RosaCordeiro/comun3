HA$PBExportHeader$w_ge402_selecao_tipo_informacao.srw
forward
global type w_ge402_selecao_tipo_informacao from dc_w_selecao_generica
end type
end forward

global type w_ge402_selecao_tipo_informacao from dc_w_selecao_generica
string title = "GE402 - Sele$$HEX2$$e700e300$$ENDHEX$$o Tipo Informa$$HEX2$$e700e300$$ENDHEX$$o"
end type
global w_ge402_selecao_tipo_informacao w_ge402_selecao_tipo_informacao

on w_ge402_selecao_tipo_informacao.create
call super::create
end on

on w_ge402_selecao_tipo_informacao.destroy
call super::destroy
end on

event open;call super::open;If Message.StringParm <> "" Then
	dw_1.Object.de_filtro [1] = Message.StringParm
	dw_2.Event ue_Retrieve()
End If
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge402_selecao_tipo_informacao
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge402_selecao_tipo_informacao
integer y = 212
integer width = 2432
integer height = 1076
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge402_selecao_tipo_informacao
integer width = 1906
integer height = 180
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge402_selecao_tipo_informacao
integer width = 1847
integer height = 80
string dataobject = "dw_ge402_selecao_tipo_inf"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge402_selecao_tipo_informacao
integer y = 284
integer width = 2382
integer height = 976
string dataobject = "dw_ge402_lista_tipo_informacao"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Pesquisa

dw_1.AcceptText( )
lvs_Pesquisa = dw_1.Object.de_filtro [1]

If Trim(lvs_Pesquisa)<>"" Then
	dw_2.of_Appendwhere( "de_tipo_informacao like '%"+Upper(lvs_Pesquisa)+"%'" )
End If

Return AncestorReturnValue
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge402_selecao_tipo_informacao
end type

event cb_selecionar::clicked;call super::clicked;String lvs_Codigo

If dw_2.GetRow( ) > 0 Then
	lvs_Codigo = String(dw_2.Object.cd_tipo_informacao [ dw_2.GetRow( ) ])
	
	CloseWithReturn(Parent, lvs_Codigo)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Selecione um tipo de informa$$HEX2$$e700e300$$ENDHEX$$o.")
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge402_selecao_tipo_informacao
end type

event cb_cancelar::clicked;call super::clicked;CloseWithReturn(Parent, "")
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge402_selecao_tipo_informacao
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge402_selecao_tipo_informacao
end type

