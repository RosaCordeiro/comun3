HA$PBExportHeader$w_ge252_qtde_produto.srw
forward
global type w_ge252_qtde_produto from dc_w_base
end type
type dw_1 from dc_uo_dw_base within w_ge252_qtde_produto
end type
type st_1 from statictext within w_ge252_qtde_produto
end type
type cb_2 from commandbutton within w_ge252_qtde_produto
end type
type cb_1 from commandbutton within w_ge252_qtde_produto
end type
type gb_1 from groupbox within w_ge252_qtde_produto
end type
end forward

global type w_ge252_qtde_produto from dc_w_base
integer width = 923
integer height = 472
string title = "WS0252 - Qtde Produto"
boolean minbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 12639424
dw_1 dw_1
st_1 st_1
cb_2 cb_2
cb_1 cb_1
gb_1 gb_1
end type
global w_ge252_qtde_produto w_ge252_qtde_produto

type variables
st_parametros_qtd_produto	ist_qtd_prd
end variables

forward prototypes
public subroutine wf_confirmar ()
end prototypes

public subroutine wf_confirmar ();Long ll_Qtde

dw_1.AcceptText()

ll_Qtde = dw_1.object.qt_produto[1]

If IsNull(ll_Qtde) or (ll_Qtde < 1) Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a quantidade.", Information!)
	dw_1.Event ue_Pos(1, 'qt_produto')
	Return 
End If

If ist_qtd_prd.as_acao = 'E' then
	If ll_Qtde >= ist_qtd_prd.al_qtde then
		Messagebox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'A quantidade deve ser menor que a quantidade que j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ no agrupamento (' + String (ist_qtd_prd.al_qtde) + ')!', Information!)
		dw_1.Event ue_Pos(1, 'qt_produto')
		Return 
	End if
End if

CloseWithReturn(w_ge252_qtde_produto, ll_Qtde)
end subroutine

on w_ge252_qtde_produto.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.st_1=create st_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.st_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.gb_1
end on

on w_ge252_qtde_produto.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.st_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.gb_1)
end on

event open;call super::open;ist_qtd_prd = Message.PowerObjectParm

dw_1.Event ue_AddRow()

If ist_qtd_prd.as_acao = 'E' then
	dw_1.Object.qt_produto [1] = 0
	gb_1.Text                  = 'Qtde. a Excluir do Produto'
End if
end event

event key;call super::key;If key = KeyEnter! Then
	wf_Confirmar()
End If
end event

type dw_1 from dc_uo_dw_base within w_ge252_qtde_produto
integer x = 46
integer y = 76
integer width = 649
integer height = 92
integer taborder = 20
string dataobject = "dw_ge252_qtde_produto"
end type

event ue_key;call super::ue_key;If key = KeyEnter! Then
	wf_Confirmar()
End If
end event

type st_1 from statictext within w_ge252_qtde_produto
integer x = 37
integer y = 204
integer width = 503
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 12639424
string text = "[Enter] Confirma"
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_ge252_qtde_produto
integer x = 91
integer y = 276
integer width = 325
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Confirmar"
end type

event clicked;wf_Confirmar()
end event

type cb_1 from commandbutton within w_ge252_qtde_produto
integer x = 466
integer y = 276
integer width = 325
integer height = 92
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Sair"
end type

event clicked;CloseWithReturn(Parent, -1)
end event

type gb_1 from groupbox within w_ge252_qtde_produto
integer x = 41
integer width = 827
integer height = 196
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 12639424
string text = "Qtde. Produto"
end type

