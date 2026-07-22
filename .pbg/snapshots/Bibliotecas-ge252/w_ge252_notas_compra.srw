HA$PBExportHeader$w_ge252_notas_compra.srw
forward
global type w_ge252_notas_compra from dc_w_base
end type
type cb_2 from commandbutton within w_ge252_notas_compra
end type
type cb_1 from commandbutton within w_ge252_notas_compra
end type
type dw_1 from dc_uo_dw_base within w_ge252_notas_compra
end type
type gb_1 from groupbox within w_ge252_notas_compra
end type
end forward

global type w_ge252_notas_compra from dc_w_base
integer width = 1984
integer height = 1228
string title = "WS0252 - Notas de Compra"
boolean minbox = false
boolean resizable = false
windowtype windowtype = response!
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
gb_1 gb_1
end type
global w_ge252_notas_compra w_ge252_notas_compra

type variables
Long 	il_Produto,&
		il_Qt_Devolver

String is_Fornecedor

dc_uo_ds_base ids_NF_Origem
end variables

on w_ge252_notas_compra.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.gb_1
end on

on w_ge252_notas_compra.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event open;call super::open;String ls_Parametro

ls_Parametro = Message.StringParm	

is_Fornecedor 	= Mid(ls_Parametro, 1, 9)
il_Produto		= Long(Mid(ls_Parametro, 10, 10))
il_Qt_Devolver 	= Long(Mid(ls_Parametro, 20))

ids_NF_Origem = Create dc_uo_ds_base
end event

event ue_postopen;call super::ue_postopen;dw_1.Event ue_AddRow()
end event

event close;CloseWithReturn(this, ids_NF_Origem)
end event

type cb_2 from commandbutton within w_ge252_notas_compra
integer x = 41
integer y = 1036
integer width = 402
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Confirmar"
end type

event clicked;Long 	ll_Qtde,&
		ll_Linha,&
		ll_Linhas,&
		ll_Row,&
		ll_Nota

dw_1.AcceptText()

ll_Qtde = dw_1.GetItemNumber(1, "compute_1")

If ll_Qtde > il_Qt_Devolver Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A quantidade m$$HEX1$$e100$$ENDHEX$$xima permitida $$HEX1$$e900$$ENDHEX$$ "+String(il_Qt_Devolver)+".")
	Return 1
End If

If ll_Qtde < il_Qt_Devolver Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Dever$$HEX1$$e100$$ENDHEX$$ ter a quantidade de  "+String(il_Qt_Devolver)+" produtos.")
	Return 1
End If

If Not ids_NF_Origem.of_ChangeDataObject("ds_ge252_notas_compra") Then
	Return 1
End If

ll_Linhas = dw_1.RowCount()
ll_Row = 1

For ll_Linha = 1 To ll_Linhas
	ll_Nota = dw_1.object.nr_nf	[ll_Linha]
	
	If Not IsNull(ll_Nota) Then
		ids_NF_Origem.object.cd_fornecedor				[ll_Row] = dw_1.object.cd_fornecedor				[ll_Linha]
		ids_NF_Origem.object.nr_nf							[ll_Row] = dw_1.object.nr_nf							[ll_Linha]
		ids_NF_Origem.object.de_especie					[ll_Row] = dw_1.object.de_especie					[ll_Linha]
		ids_NF_Origem.object.de_serie						[ll_Row] = dw_1.object.de_serie						[ll_Linha]
		ids_NF_Origem.object.cd_natureza_operacao	[ll_Row] = dw_1.object.cd_natureza_operacao		[ll_Linha]
		ids_NF_Origem.object.vl_preco_unitario			[ll_Row] = dw_1.object.vl_preco_unitario			[ll_Linha]
		ids_NF_Origem.object.pc_desconto				[ll_Row] = dw_1.object.pc_desconto					[ll_Linha]
		ids_NF_Origem.object.nr_lote						[ll_Row] = dw_1.object.nr_lote							[ll_Linha]
		ids_NF_Origem.object.qt_lote_original			[ll_Row] = dw_1.object.qt_lote_original				[ll_Linha]
		ids_NF_Origem.object.qt_lote						[ll_Row] = dw_1.object.qt_lote							[ll_Linha]
		
		ll_Row += 1
	End If
Next

CloseWithReturn(Parent, ids_NF_Origem)
end event

type cb_1 from commandbutton within w_ge252_notas_compra
integer x = 1623
integer y = 1036
integer width = 297
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Sair"
end type

event clicked;
CloseWithReturn(Parent, ids_NF_Origem)
	


end event

type dw_1 from dc_uo_dw_base within w_ge252_notas_compra
integer x = 64
integer y = 80
integer width = 1838
integer height = 920
integer taborder = 20
string dataobject = "ds_ge252_notas_compra"
boolean vscrollbar = true
end type

event buttonclicked;call super::buttonclicked;st_parametros_nota_compra lst_Parametro

Long	ll_Nota,&
		ll_Row,&
		ll_Qtde_Selecionada

This.AcceptText()

ll_Row = This.GetRow()

ll_Nota = This.Object.nr_nf[ll_Row]

If IsNull(ll_Nota) Then
	ll_Qtde_Selecionada = dw_1.GetItemNumber(1, "compute_1")

	If ll_Qtde_Selecionada >= il_Qt_Devolver Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Quantidade j$$HEX1$$e100$$ENDHEX$$ atendida.")	
		Return 1
	End If

	OpenWithParm(w_ge252_localiza_nota_compra, is_Fornecedor+String(il_Produto))
	
	lst_Parametro = Message.PowerObjectParm

	If lst_Parametro.retorno = 1 Then
		This.object.cd_fornecedor			[ll_Row] = lst_Parametro.cd_fornecedor
		This.object.nr_nf						[ll_Row] = lst_Parametro.nr_nf
		This.object.de_especie				[ll_Row] = lst_Parametro.de_especie
		This.object.de_serie					[ll_Row] = lst_Parametro.de_serie
		This.object.cd_natureza_operacao	[ll_Row] = lst_Parametro.cd_natureza_operacao
		This.object.vl_preco_unitario		[ll_Row] = lst_Parametro.vl_preco_unitario
		This.object.pc_desconto				[ll_Row] = lst_Parametro.pc_desconto
		This.object.nr_lote						[ll_Row] = lst_Parametro.nr_lote
		This.object.qt_lote_original			[ll_Row] = lst_Parametro.qt_lote
		
		If lst_Parametro.qt_lote > (il_Qt_Devolver - ll_Qtde_Selecionada) Then
			This.object.qt_lote						[ll_Row] = il_Qt_Devolver - ll_Qtde_Selecionada
		Else
			This.object.qt_lote						[ll_Row] = lst_Parametro.qt_lote
		End If
		

		This.Event ue_AddRow()
	End If
Else
	dw_1.DeleteRow(ll_Row)
End If

Return 1
end event

type gb_1 from groupbox within w_ge252_notas_compra
integer x = 32
integer y = 12
integer width = 1897
integer height = 1000
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Notas de Compra"
end type

