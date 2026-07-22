HA$PBExportHeader$w_ge496_faltas_ped_ecommerce_distrib.srw
forward
global type w_ge496_faltas_ped_ecommerce_distrib from dc_w_selecao_lista_detalhe
end type
type cb_1 from commandbutton within w_ge496_faltas_ped_ecommerce_distrib
end type
type dw_4 from dc_uo_dw_base within w_ge496_faltas_ped_ecommerce_distrib
end type
end forward

global type w_ge496_faltas_ped_ecommerce_distrib from dc_w_selecao_lista_detalhe
integer width = 4183
integer height = 2420
string title = "GE496 - Faltas do Pedido E-commerce para Distribuidoras"
cb_1 cb_1
dw_4 dw_4
end type
global w_ge496_faltas_ped_ecommerce_distrib w_ge496_faltas_ped_ecommerce_distrib

type variables
uo_produto io_Produto
end variables

forward prototypes
public subroutine wf_insere_distribuidora_default ()
end prototypes

public subroutine wf_insere_distribuidora_default ();DataWindowChild lvdwc

Integer lvi_Retorno,&
        lvi_Row

If dw_1.GetChild("cd_distribuidora", lvdwc) = 1 Then
	lvdwc.InsertRow(1)
	
	lvdwc.SetItem(1, "cd_fornecedor", "000000000")
	lvdwc.SetItem(1, "nm_fantasia",   "TODAS")
	
	dw_1.Object.Cd_Distribuidora[1] = "000000000"
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild da distribuidora.")
End If
end subroutine

on w_ge496_faltas_ped_ecommerce_distrib.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.dw_4=create dw_4
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.dw_4
end on

on w_ge496_faltas_ped_ecommerce_distrib.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
destroy(this.dw_4)
end on

event ue_postopen;call super::ue_postopen;dw_1.Object.Dh_Inicio		[1] = Today()
dw_1.Object.Dh_Termino	[1] = Today()

wf_Insere_Distribuidora_Default()
end event

event close;call super::close;If IsValid(io_Produto) Then Destroy(io_Produto)
end event

event ue_preopen;call super::ue_preopen;io_Produto = Create uo_produto
end event

type dw_visual from dc_w_selecao_lista_detalhe`dw_visual within w_ge496_faltas_ped_ecommerce_distrib
end type

type gb_aux_visual from dc_w_selecao_lista_detalhe`gb_aux_visual within w_ge496_faltas_ped_ecommerce_distrib
integer y = 1396
integer width = 3291
integer height = 792
end type

type gb_3 from dc_w_selecao_lista_detalhe`gb_3 within w_ge496_faltas_ped_ecommerce_distrib
integer y = 1308
integer width = 3310
integer height = 916
end type

type gb_1 from dc_w_selecao_lista_detalhe`gb_1 within w_ge496_faltas_ped_ecommerce_distrib
integer width = 2089
end type

type gb_2 from dc_w_selecao_lista_detalhe`gb_2 within w_ge496_faltas_ped_ecommerce_distrib
integer y = 392
integer width = 4078
integer height = 896
end type

type dw_1 from dc_w_selecao_lista_detalhe`dw_1 within w_ge496_faltas_ped_ecommerce_distrib
integer width = 2021
string dataobject = "dw_ge496_selecao"
end type

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "de_produto"
			io_Produto.of_Localiza_Produto(This.GetText())
			
			If io_Produto.Localizado Then
				This.Object.Cd_Produto[1] = io_Produto.Cd_Produto
				This.Object.De_Produto[1] = io_Produto.ivs_Descricao_Apresentacao_Venda
			End If
	End Choose
End If
end event

event dw_1::itemchanged;call super::itemchanged;dw_2.Event ue_Reset()
dw_3.Event ue_Reset()

Choose Case dwo.Name
	Case "de_produto"
		If Not IsNull(Data) and Data <> "" Then
			If Data <> io_Produto.ivs_Descricao_Apresentacao_Venda Then
				Return 1
			End If
		Else
			io_Produto.of_Inicializa()
			
			This.Object.Cd_Produto[1] = io_Produto.Cd_Produto
			This.Object.De_Produto[1] = io_Produto.ivs_Descricao_Apresentacao_Venda
		End If
End Choose
end event

type dw_2 from dc_w_selecao_lista_detalhe`dw_2 within w_ge496_faltas_ped_ecommerce_distrib
integer y = 468
integer width = 4014
integer height = 784
string dataobject = "dw_ge496_lista"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;Date ldt_Inicio
Date ldt_Termino

Long ll_Produto

String ls_Distribuidora

dw_1.AcceptText()

ldt_Inicio 		= dw_1.Object.Dh_Inicio				[1]
ldt_Termino		= dw_1.Object.Dh_Termino			[1]
ls_Distribuidora	= dw_1.Object.Cd_Distribuidora	[1]
ll_Produto		= dw_1.Object.Cd_Produto			[1]

If IsNull(ldt_Inicio) Or IsNull(ldt_Termino) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio.", Exclamation!)
	dw_1.Event ue_Pos(1, "dh_inicio")
	Return -1
End If

If IsNull(ldt_Termino) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino.", Exclamation!)
	dw_1.Event ue_Pos(1, "dh_inicio")
	Return -1
End If

If ldt_Inicio > ldt_Termino Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", " A data de in$$HEX1$$ed00$$ENDHEX$$cio n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a data de t$$HEX1$$e900$$ENDHEX$$rmino.")
	dw_1.Event ue_Pos(1, "dh_inicio")
	Return -1
End If

If ls_Distribuidora <> "000000000" Then
	This.of_AppendWhere("p.cd_distribuidora = '" + ls_Distribuidora + "'")
End If

If ll_Produto > 0 Then
	This.of_AppendWhere("pp.cd_produto = " + String(ll_Produto))
End If

Return 1
end event

event dw_2::ue_recuperar;//OverRide

Return This.Retrieve(dw_1.Object.Dh_Inicio[1], dw_1.Object.Dh_Termino[1])
end event

type dw_3 from dc_w_selecao_lista_detalhe`dw_3 within w_ge496_faltas_ped_ecommerce_distrib
integer y = 1376
integer width = 3218
integer height = 788
string dataobject = "dw_ge496_detalhe"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event dw_3::ue_recuperar;//OverRide

dw_2.AcceptText()

Return This.Retrieve(dw_2.Object.Cd_Filial[dw_2.GetRow()], dw_2.Object.Nr_Pedido_Distribuidora[dw_2.GetRow()])
end event

event dw_3::constructor;call super::constructor;This.of_SetRowSelection()
This.ivb_Ordena_Colunas = True
end event

event dw_3::ue_preretrieve;call super::ue_preretrieve;Long ll_Produto

dw_1.AcceptText()

ll_Produto = dw_1.Object.Cd_Produto[1]

If dw_1.Object.Cd_Produto[1] > 0 Then
	This.of_AppendWhere("pp.cd_produto = " + String(ll_Produto))
End If

Return 1
end event

type cb_1 from commandbutton within w_ge496_faltas_ped_ecommerce_distrib
integer x = 2149
integer y = 256
integer width = 453
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Gerar Planilha"
end type

event clicked;dw_4.Event ue_Retrieve()
end event

type dw_4 from dc_uo_dw_base within w_ge496_faltas_ped_ecommerce_distrib
boolean visible = false
integer x = 2638
integer y = 32
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge496_planilha"
end type

event ue_recuperar;//OverRide

dw_1.AcceptText()

Return This.Retrieve(dw_1.Object.Dh_Inicio[1], dw_1.Object.Dh_Termino[1])
end event

event ue_preretrieve;call super::ue_preretrieve;Date ldt_Inicio
Date ldt_Termino

Long ll_Produto

String ls_Distribuidora

dw_1.AcceptText()

ldt_Inicio 		= dw_1.Object.Dh_Inicio				[1]
ldt_Termino		= dw_1.Object.Dh_Termino			[1]
ls_Distribuidora	= dw_1.Object.Cd_Distribuidora	[1]
ll_Produto		= dw_1.Object.Cd_Produto			[1]

If IsNull(ldt_Inicio) Or IsNull(ldt_Termino) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio.", Exclamation!)
	dw_1.Event ue_Pos(1, "dh_inicio")
	Return -1
End If

If IsNull(ldt_Termino) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino.", Exclamation!)
	dw_1.Event ue_Pos(1, "dh_inicio")
	Return -1
End If

If ldt_Inicio > ldt_Termino Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", " A data de in$$HEX1$$ed00$$ENDHEX$$cio n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a data de t$$HEX1$$e900$$ENDHEX$$rmino.")
	dw_1.Event ue_Pos(1, "dh_inicio")
	Return -1
End If

If ls_Distribuidora <> "000000000" Then
	This.of_AppendWhere("p.cd_distribuidora = '" + ls_Distribuidora + "'")
End If

If ll_Produto > 0 Then
	This.of_AppendWhere("pp.cd_produto = " + String(ll_Produto))
End If

Return 1
end event

event ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	This.Event ue_SaveAs()
End If

Return pl_Linhas
end event

