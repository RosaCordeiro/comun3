HA$PBExportHeader$w_ge150_selecao_cliente_droga.srw
forward
global type w_ge150_selecao_cliente_droga from dc_w_selecao_generica
end type
type gb_3 from groupbox within w_ge150_selecao_cliente_droga
end type
type dw_3 from dc_uo_dw_base within w_ge150_selecao_cliente_droga
end type
end forward

global type w_ge150_selecao_cliente_droga from dc_w_selecao_generica
integer x = 123
integer y = 300
integer width = 3442
integer height = 1780
string title = "GE150 - Sele$$HEX2$$e700e300$$ENDHEX$$o de Clientes do Farmagora"
long backcolor = 80269524
gb_3 gb_3
dw_3 dw_3
end type
global w_ge150_selecao_cliente_droga w_ge150_selecao_cliente_droga

type variables
uo_ge150_cliente_drogaexpress      ivo_cliente_droga_parent
end variables

forward prototypes
public subroutine wf_atualiza_dados_cliente (long pl_row)
end prototypes

public subroutine wf_atualiza_dados_cliente (long pl_row);STRING lvs_Cliente
//
IF pl_row > 0 THEN
	//
	lvs_Cliente = dw_2.Object.cd_cliente_drogaexpress[pl_row]
	//
	dw_3.Retrieve(lvs_Cliente)
ELSE
	dw_3.Reset()
END IF
//
end subroutine

on w_ge150_selecao_cliente_droga.create
int iCurrent
call super::create
this.gb_3=create gb_3
this.dw_3=create dw_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_3
this.Control[iCurrent+2]=this.dw_3
end on

on w_ge150_selecao_cliente_droga.destroy
call super::destroy
destroy(this.gb_3)
destroy(this.dw_3)
end on

event open;call super::open;String lvs_Cliente

ivo_Cliente_Droga_Parent = Message.PowerObjectParm

lvs_Cliente = ivo_Cliente_Droga_Parent.ivs_Parametro

If lvs_Cliente <> "" Then
	dw_1.Object.Nm_Cliente[1] = lvs_Cliente
	dw_1.AcceptText()

	ivb_Pesquisa_Direta = True	
End If


end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge150_selecao_cliente_droga
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge150_selecao_cliente_droga
integer x = 18
integer y = 192
integer width = 3365
integer height = 1088
long backcolor = 80269524
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge150_selecao_cliente_droga
integer x = 18
integer width = 3365
integer height = 172
long backcolor = 80269524
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge150_selecao_cliente_droga
integer x = 46
integer y = 76
integer width = 3301
integer height = 88
integer taborder = 80
string dataobject = "dw_ge150_selecao_cliente_droga"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge150_selecao_cliente_droga
integer x = 46
integer y = 244
integer width = 3314
integer height = 1008
string dataobject = "dw_ge150_lista_cliente_droga"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Cliente
String lvs_Endereco

dw_1.AcceptText()

lvs_Cliente  = Trim(dw_1.Object.Nm_Cliente [1])
lvs_Endereco = Trim(dw_1.Object.De_Endereco[1])

If Not IsNull(lvs_Cliente) and lvs_Cliente <> ""  Then
	This.of_AppendWhere("nm_cliente like '" + lvs_Cliente + "%'")
End If

If Not IsNull(lvs_Endereco) and lvs_Endereco <> ""  Then
	This.of_AppendWhere("de_endereco like '" + lvs_Endereco + "%'")
End If

Return 1

end event

event dw_2::rowfocuschanged;call super::rowfocuschanged;Wf_Atualiza_Dados_Cliente(currentrow)

end event

event dw_2::ue_retrieve;call super::ue_retrieve;//
IF AncestorReturnValue > 0 THEN
	//
	Wf_Atualiza_Dados_Cliente(1)
	//
ELSE
	dw_3.Reset()
END IF
//
RETURN AncestorReturnValue
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge150_selecao_cliente_droga
integer x = 2537
integer y = 1552
end type

event cb_selecionar::clicked;call super::clicked;Long lvl_Linha

String lvs_Cd_Cliente

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	lvs_Cd_Cliente = String(dw_2.Object.cd_cliente_drogaexpress[lvl_Linha])
	CloseWithReturn(Parent, lvs_Cd_cliente)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto na lista.", Information!, Ok!)
	dw_2.SetFocus()
End If


end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge150_selecao_cliente_droga
integer x = 3013
integer y = 1552
end type

event cb_cancelar::clicked;call super::clicked;String lvs_Cd_Cliente

SetNull(lvs_Cd_Cliente)

CloseWithReturn(Parent, lvs_Cd_Cliente)
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge150_selecao_cliente_droga
integer x = 2153
integer y = 1552
integer taborder = 70
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge150_selecao_cliente_droga
integer x = 50
integer y = 1568
integer width = 2016
long backcolor = 80269524
end type

type gb_3 from groupbox within w_ge150_selecao_cliente_droga
integer x = 18
integer y = 1280
integer width = 3365
integer height = 252
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 79741120
string text = "Detalhes"
borderstyle borderstyle = styleraised!
end type

type dw_3 from dc_uo_dw_base within w_ge150_selecao_cliente_droga
integer x = 46
integer y = 1336
integer width = 3301
integer height = 168
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_ge150_detalhes_cliente_droga"
boolean livescroll = false
end type

