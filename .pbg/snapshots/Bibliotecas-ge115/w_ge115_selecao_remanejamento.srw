HA$PBExportHeader$w_ge115_selecao_remanejamento.srw
forward
global type w_ge115_selecao_remanejamento from dc_w_selecao_generica
end type
end forward

global type w_ge115_selecao_remanejamento from dc_w_selecao_generica
integer width = 4681
integer height = 1708
string title = "GE115 - Sele$$HEX2$$e700e300$$ENDHEX$$o de Remanejamento de Produtos entre Filiais"
end type
global w_ge115_selecao_remanejamento w_ge115_selecao_remanejamento

type variables
boolean ib_selecionar_varios_remanej
end variables

forward prototypes
public function string wf_seleciona_remanejamentos ()
end prototypes

public function string wf_seleciona_remanejamentos ();Long ll_Linha, ll_Contador

String ls_Retorno

For ll_Linha = 1 To dw_2.RowCount()
			
	If dw_2.Object.id_selecionar[ll_Linha] = 'S' Then
		
		ll_Contador ++
		
		If ll_Contador = 1 Then
			ls_Retorno =  String(dw_2.Object.cd_remanejamento[ll_Linha])
		Else
			ls_Retorno =  ls_Retorno + ", " + String(dw_2.Object.cd_remanejamento[ll_Linha])
		End If
		
	End If
		
Next

Return ls_Retorno
end function

on w_ge115_selecao_remanejamento.create
call super::create
end on

on w_ge115_selecao_remanejamento.destroy
call super::destroy
end on

event open;call super::open;If Mid(Message.StringParm,1,1) = 'S' Then
	ib_selecionar_varios_remanej = True
Else
	ib_selecionar_varios_remanej 			= False
	dw_2.Object.id_selecionar.Protect		=	1
	dw_2.Object.id_selecionar.Visible		=	0
	dw_2.Object.p_selecao.Visible 			= 0
End If

dw_1.Object.De_Remanejamento[ 1 ] = Mid(Message.StringParm, 2)

If Message.StringParm <> "" Then
	ivb_Pesquisa_Direta = True
End If
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge115_selecao_remanejamento
integer x = 1637
integer y = 52
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge115_selecao_remanejamento
integer y = 184
integer width = 4590
integer height = 1280
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge115_selecao_remanejamento
integer width = 1541
integer height = 168
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge115_selecao_remanejamento
integer x = 55
integer y = 76
integer width = 1490
integer height = 72
string dataobject = "dw_ge115_selecao_generica"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge115_selecao_remanejamento
integer x = 64
integer y = 240
integer width = 4517
integer height = 1188
string dataobject = "dw_ge115_lista_generica"
boolean hscrollbar = true
boolean livescroll = false
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String ls_Descricao

dw_1.AcceptText()

ls_Descricao = dw_1.Object.De_Remanejamento[ 1 ]

If ls_Descricao <> "" Then
	If IsNumber( ls_Descricao ) Then
		This.of_AppendWhere( "cd_remanejamento = " + ls_Descricao )
	Else
		This.of_AppendWhere( "de_remanejamento like '" + ls_Descricao + "%'" )
	End If
End If

Return 1
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;Long ll_Linha

DataWindowChild lvdwc

For ll_Linha = 1 To pl_Linhas
	If This.Object.Id_Selecao_Produto[ ll_Linha ] = 0 Then
		

		lvdwc = This.of_InsertRow_DDDW( "id_selecao_produto" )			
		
		lvdwc.SetItem( 1, "de_grupo" , "TODOS" )
		lvdwc.SetItem( 1, "cd_grupo" , "0" )
		
		This.Object.Id_Selecao_Produto[ ll_Linha ] = 0
		
	End If
Next

Return pl_Linhas
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge115_selecao_remanejamento
integer x = 3858
integer y = 1488
end type

event cb_selecionar::clicked;call super::clicked;Long ll_Linha

String ls_Codigo

ll_Linha = dw_2.GetRow()

If ll_Linha > 0 Then
	
	If ib_selecionar_varios_remanej Then
		ls_Codigo = wf_seleciona_remanejamentos()
	Else
		If dw_2.GetItemNumber(4, "qt_remanejamentos") > 1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Somente um remanejamento poder$$HEX1$$e100$$ENDHEX$$ ser selecionado.")
			Return
		End If
		
		ls_Codigo = String( dw_2.Object.Cd_Remanejamento[ ll_Linha ] )
	End If
	
	CloseWithReturn( Parent, ls_Codigo )
Else
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma linha na lista.", Information! )
	dw_2.SetFocus()
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge115_selecao_remanejamento
integer x = 4247
integer y = 1488
end type

event cb_cancelar::clicked;call super::clicked;String ls_Nulo

SetNull( ls_Nulo )

CloseWithReturn( Parent, ls_Nulo )
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge115_selecao_remanejamento
integer x = 3415
integer y = 1488
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge115_selecao_remanejamento
integer x = 37
integer y = 1496
integer width = 1760
end type

