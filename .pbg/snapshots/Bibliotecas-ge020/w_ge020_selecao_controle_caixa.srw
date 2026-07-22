HA$PBExportHeader$w_ge020_selecao_controle_caixa.srw
forward
global type w_ge020_selecao_controle_caixa from dc_w_selecao_generica
end type
end forward

global type w_ge020_selecao_controle_caixa from dc_w_selecao_generica
integer x = 343
integer y = 376
integer width = 3237
integer height = 1652
string title = "GE020 - Sele$$HEX2$$e700e300$$ENDHEX$$o de Controles de Caixa"
long backcolor = 80269524
end type
global w_ge020_selecao_controle_caixa w_ge020_selecao_controle_caixa

type variables
boolean ivb_nao_conferidos

Integer ivl_Filial
end variables

on w_ge020_selecao_controle_caixa.create
call super::create
end on

on w_ge020_selecao_controle_caixa.destroy
call super::destroy
end on

event open;call super::open;String lvs_Parametro
String lvs_Conferidos
String lvs_Filial

lvs_Parametro	= Message.StringParm
lvs_Conferidos	= MidA( lvs_Parametro, 1, Pos( lvs_Parametro, ';' ) - 1 )

This.ivl_Filial = Integer( MidA( lvs_Parametro ,Pos( lvs_Parametro, ';' ) + 1 ) )

If lvs_Conferidos = "S" Then
	This.ivb_Nao_Conferidos = True
Else
	This.ivb_Nao_Conferidos = False
End If
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge020_selecao_controle_caixa
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge020_selecao_controle_caixa
integer x = 18
integer y = 264
integer width = 3168
integer height = 1144
long backcolor = 80269524
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge020_selecao_controle_caixa
integer x = 18
integer y = 4
integer width = 1650
integer height = 256
long backcolor = 80269524
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge020_selecao_controle_caixa
integer x = 41
integer y = 68
integer width = 1618
integer height = 180
string dataobject = "dw_ge020_selecao_controle_caixa"
end type

event dw_1::ue_addrow;call super::ue_addrow;Date lvdt_Inicio, &
     lvdt_Termino

If AncestorReturnValue > 0 Then
	This.SetTransObject(SqlCa)
	This.of_Populate_DDDW("cd_caixa")

	lvdt_Termino = Today()
	lvdt_Inicio  = RelativeDate(lvdt_Termino, -1)

	This.Object.Dt_Inicio[1]  = lvdt_Inicio
	This.Object.Dt_Termino[1] = lvdt_Termino	
End If

Return AncestorReturnValue
end event

event dw_1::ue_preinsertrow;call super::ue_preinsertrow;This.DataObject = "dw_ge020_selecao_controle_caixa"

Return AncestorReturnValue
end event

event dw_1::ue_populate_dddw;Long lvl_Filial

String lvs_Filial

lvs_Filial			= Mid(Message.StringParm,Pos(Message.StringParm,';') + 1)

If (Not IsNull(lvs_Filial)) and (IsNumber(lvs_Filial)) Then
	lvl_Filial = Long(lvs_Filial)
Else
	lvl_Filial = gvo_parametro.of_filial( )
End If

pdwc_dddw.SetTransObject(SqlCa)

pdwc_dddw.Retrieve(lvl_Filial)
end event

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge020_selecao_controle_caixa
integer x = 50
integer y = 312
integer width = 3113
integer height = 1076
string dataobject = "dw_ge020_lista_controle_caixa"
boolean ivb_ordena_colunas = true
boolean ivb_selecao_colunas = true
end type

event dw_2::ue_recuperar;// Override

Long lvl_Linhas 

String lvs_Caixa

Date lvdt_Inicio, &
     lvdt_Termino
	  
dw_1.AcceptText()

lvs_Caixa    = dw_1.Object.Cd_Caixa  [1]
lvdt_Inicio  = dw_1.Object.Dt_Inicio [1]
lvdt_Termino = dw_1.Object.Dt_Termino[1]

If IsNull(lvs_Caixa) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o caixa para consulta.", Information!)
	dw_1.SetColumn("cd_caixa")
	dw_1.SetFocus()
	Return -1
End If

If IsNull(lvdt_Inicio) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio do per$$HEX1$$ed00$$ENDHEX$$odo.", Information!)
	dw_1.SetColumn("dt_inicio")
	dw_1.SetFocus()
	Return -1
End If

If IsNull(lvdt_Termino) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino do per$$HEX1$$ed00$$ENDHEX$$odo.", Information!)
	dw_1.SetColumn("dt_termino")
	dw_1.SetFocus()
	Return -1
End If

Return This.Retrieve(lvs_Caixa, lvdt_Inicio, lvdt_Termino)
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;If Parent.ivb_Nao_Conferidos Then
	This.of_AppendWhere("cc.dh_conferencia is null")
End If

Return 1
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge020_selecao_controle_caixa
integer x = 2423
integer y = 1436
end type

event cb_selecionar::clicked;call super::clicked;String lvs_Retorno, &
       lvs_Caixa, &
		 lvs_Controle
		 
Long lvl_Linha

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	lvs_Caixa		= dw_2.Object.Cd_Caixa[lvl_Linha]
	lvs_Controle	= String(dw_2.Object.Nr_Controle_Caixa[lvl_Linha], "0000000000")

	lvs_Retorno  = lvs_Caixa + lvs_Controle

	CloseWithReturn(Parent,lvs_Retorno)
Else
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um Caixa.", Information! )
	dw_2.SetFocus()
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge020_selecao_controle_caixa
integer x = 2816
integer y = 1436
end type

event cb_cancelar::clicked;call super::clicked;STRING lvs_Retorno

SetNull(lvs_Retorno)

CloseWithReturn(Parent,lvs_Retorno)
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge020_selecao_controle_caixa
integer x = 1989
integer y = 1436
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge020_selecao_controle_caixa
integer x = 23
integer y = 1436
long backcolor = 80269524
end type

