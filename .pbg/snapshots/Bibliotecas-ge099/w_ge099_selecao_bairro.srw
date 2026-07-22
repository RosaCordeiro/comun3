HA$PBExportHeader$w_ge099_selecao_bairro.srw
forward
global type w_ge099_selecao_bairro from dc_w_selecao_generica
end type
end forward

global type w_ge099_selecao_bairro from dc_w_selecao_generica
integer width = 2235
integer height = 1588
string title = "GE099 - Sele$$HEX2$$e700e300$$ENDHEX$$o de Bairro"
end type
global w_ge099_selecao_bairro w_ge099_selecao_bairro

type variables
uo_Cidade 			io_Cidade
uo_ge099_Bairro	io_Bairro

Long ivl_Cidade_Informada
end variables

on w_ge099_selecao_bairro.create
call super::create
end on

on w_ge099_selecao_bairro.destroy
call super::destroy
end on

event open;call super::open;io_Cidade = Create uo_Cidade

io_Bairro = Message.PowerObjectParm

dw_1.Object.De_Bairro[ 1 ]  = io_Bairro.ivs_Parametro_Selecao

If Not IsNull( io_Bairro.ivl_Cidade_Informada ) And io_Bairro.ivl_Cidade_Informada <> 0 Then
	 dw_1.Object.Nm_Cidade[1] = String( io_Bairro.ivl_Cidade_Informada )
	 dw_1.Event ue_pos(1, 'nm_cidade')
	 
	 dw_1.AcceptText()
	 dw_1.Event ue_Key( KeyEnter!, 0 )
	 dw_1.Event ue_pos(1, 'de_bairro')
	 
	 If Trim( io_Bairro.ivs_Parametro_Selecao ) <> "" Then			
		ivb_Pesquisa_Direta = True
	End If
Else
	dw_1.Event ue_pos(1, 'nm_cidade')	
End If

//ivb_Pesquisa_Direta = True
end event

event close;call super::close;Destroy(io_Cidade)
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge099_selecao_bairro
integer x = 37
integer y = 1368
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge099_selecao_bairro
integer y = 276
integer width = 2149
integer height = 1076
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge099_selecao_bairro
integer width = 1760
integer height = 256
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge099_selecao_bairro
integer x = 50
integer y = 76
integer width = 1728
integer height = 156
string dataobject = "dw_ge099_selecao_bairro"
end type

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "nm_cidade"
			io_Cidade.of_Localiza_Cidade( This.GetText() )
			
			If io_Cidade.Localizada Then
				dw_1.Object.Cd_Cidade	[ 1 ] = io_Cidade.Cd_Cidade
				dw_1.Object.Nm_Cidade	[ 1 ] = io_Cidade.Nm_Cidade
				dw_1.Object.Cd_Uf		[ 1 ] = io_Cidade.Cd_Unidade_Federacao
			End If
	End Choose
End If
end event

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge099_selecao_bairro
integer x = 64
integer y = 328
integer width = 2103
integer height = 1012
string dataobject = "dw_ge099_lista_bairro"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;dw_1.AcceptText( )

If Not io_Cidade.Localizada Then
	dw_1.Event ue_Pos( 1, "nm_cidade" )
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "$$HEX1$$c900$$ENDHEX$$ preciso selecionar uma cidade" )
	Return -1
End If

This.of_AppendWhere( "b.de_bairro like '" +  dw_1.Object.De_Bairro[ 1 ] + "%'" )
This.of_AppendWhere( "ci.cd_cidade = " +  String( io_Cidade.Cd_Cidade ) )

Return AncestorReturnValue
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge099_selecao_bairro
integer x = 1422
integer y = 1380
end type

event cb_selecionar::clicked;call super::clicked;Long ll_Linha
Long ll_Bairro

dw_2.AcceptText( )

ll_Linha = dw_2.GetRow( )

If ll_Linha > 0 Then
	ll_Bairro = dw_2.Object.Nr_Bairro[ ll_Linha ]
	
	If Not IsNull( ll_Bairro ) Then
		CloseWithReturn( Parent, String( ll_Bairro ) )
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um bairro.", Information!)
		dw_2.Event ue_Pos(1, "de_bairro")
	End If
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge099_selecao_bairro
integer x = 1810
integer y = 1380
end type

event cb_cancelar::clicked;call super::clicked;String ls_Nulo

SetNull( ls_Nulo )

CloseWithReturn( Parent, ls_Nulo )
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge099_selecao_bairro
integer x = 978
integer y = 1380
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge099_selecao_bairro
boolean visible = false
integer x = 59
integer y = 1184
integer height = 140
end type

