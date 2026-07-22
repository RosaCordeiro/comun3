HA$PBExportHeader$w_ge139_consulta_venda_produto.srw
forward
global type w_ge139_consulta_venda_produto from dc_w_selecao_lista_relatorio
end type
type dw_4 from dc_uo_dw_base within w_ge139_consulta_venda_produto
end type
type cb_2 from commandbutton within w_ge139_consulta_venda_produto
end type
type cb_1 from commandbutton within w_ge139_consulta_venda_produto
end type
type gb_3 from groupbox within w_ge139_consulta_venda_produto
end type
end forward

global type w_ge139_consulta_venda_produto from dc_w_selecao_lista_relatorio
integer width = 2981
integer height = 1932
string title = "GE139 - Consulta Vendas do Produto"
dw_4 dw_4
cb_2 cb_2
cb_1 cb_1
gb_3 gb_3
end type
global w_ge139_consulta_venda_produto w_ge139_consulta_venda_produto

type variables
long il_pontos_resgate

DateTime ivdh_base

String ivs_Filiais

uo_ge216_filiais	uo_filiais
uo_Produto			io_Produto
end variables

forward prototypes
public subroutine wf_atualiza_resgates (long pl_linhas)
public subroutine wf_verifica_resgate ()
end prototypes

public subroutine wf_atualiza_resgates (long pl_linhas);Long ll_Linha, ll_Produto, ll_Ajustes, ls_Produto

Date ldh_Inicio, ldh_Termino

If il_Pontos_Resgate = 0 Then Return

dw_1.AcceptText()
dw_2.AcceptText()

ll_Produto 	= dw_1.Object.cd_produto[1]

If pl_linhas > 0 Then

	Open(w_Aguarde)
	
	w_Aguarde.Title = 'Verificando os Resgates do Produto ...'
	
	w_Aguarde.uo_Progress.of_SetMax(pl_linhas)
	
	For ll_Linha = 1 To dw_2.RowCount()
		
		ldh_Inicio 		= Date(dw_2.Object.dh_resumo[ll_Linha])
		ldh_Termino	= gf_Retorna_ultimo_dia_mes(ldh_Inicio)
		
		Select sum(qt_ajuste) 
		Into :ll_Ajustes
		From ajuste_estoque
		where cd_produto 						= :ll_Produto
			and cd_motivo_ajuste 				= 35
			and id_entrada_saida 				= 'S'
			and dh_movimentacao_caixa between :ldh_Inicio and :ldh_Termino
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgDbError("Erro ao localizar os ajustes de resgates.")
			Exit
		Else
			If ll_Ajustes > 0 Then
				dw_2.Object.qt_resgate_clube[ll_Linha] = ll_Ajustes
			End If
		End If
		
		w_Aguarde.uo_Progress.of_SetProgress(ll_Linha)
			
	Next
	
	Close(w_Aguarde)

End If
end subroutine

public subroutine wf_verifica_resgate ();Select isnull(qt_pontos_resgate, 0)
Into :il_pontos_resgate
From produto_geral
Where cd_produto = :io_Produto.Cd_Produto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
	Case -1
		SqlCa.of_MsgDbError("Erro ao localizar os pontos de resgate do clube.")
End Choose
end subroutine

on w_ge139_consulta_venda_produto.create
int iCurrent
call super::create
this.dw_4=create dw_4
this.cb_2=create cb_2
this.cb_1=create cb_1
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_4
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.gb_3
end on

on w_ge139_consulta_venda_produto.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_4)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.gb_3)
end on

event open;call super::open;uo_filiais		= Create uo_ge216_filiais
io_Produto	= Create uo_Produto
end event

event close;call super::close;Destroy(uo_filiais)
Destroy(io_Produto)
end event

event ue_postopen;call super::ue_postopen;Boolean lvb_Sucesso = False

DateTime lvdh_Inicio
DateTime lvdh_Termino

Select dateadd(month, -12, dh_movimentacao),
		 dh_movimentacao
Into	:lvdh_Inicio, 
     	:lvdh_Termino
From parametro
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		lvb_Sucesso = True
		
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Datas do par$$HEX1$$e200$$ENDHEX$$metro n$$HEX1$$e300$$ENDHEX$$o localizadas.", StopSign!)
		
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o das Datas do Par$$HEX1$$e200$$ENDHEX$$metro")
End Choose

If lvb_Sucesso Then
	dw_1.Object.Dt_Inicio 	[1] = Date("01/" + String(lvdh_Inicio,  "mm/yyyy"))
	dw_1.Object.Dt_Termino	[1] = Date("01/" + String(lvdh_Termino, "mm/yyyy"))
End If
end event

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge139_consulta_venda_produto
integer y = 292
integer width = 1161
integer height = 1328
integer weight = 700
string text = "Vendas/Resgate por M$$HEX1$$ea00$$ENDHEX$$s"
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge139_consulta_venda_produto
integer width = 2880
integer height = 264
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge139_consulta_venda_produto
integer width = 2811
integer height = 168
string dataobject = "dw_ge139_selecao_venda_mensal"
end type

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	If GetColumnName() = "de_produto" Then
		io_Produto.of_Localiza_Produto(This.GetText())
		
		If io_Produto.Localizado Then
			This.Object.Cd_Produto[1] = io_Produto.Cd_Produto
			This.Object.De_Produto[1] = io_Produto.De_Produto + " : " + io_Produto.De_Apresentacao_Venda
		Else
			io_Produto.of_Inicializa()
		End If
	End If
End If
end event

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)
end event

event dw_1::itemchanged;call super::itemchanged;Long lvl_Lojas

String ls_Nulo

Setnull(ls_Nulo)

If dwo.Name = "id_vendas_filiais" Then
	If Data = "S" Then
		If dw_2.GetRow() > 0 Then
			dw_2.Post Event RowFocusChanged(dw_2.GetRow())
		End If
	Else
		dw_4.Reset()
	End If
End If

If dwo.Name = "id_filiais" Then	
	ivs_filiais = ls_Nulo 
	If Data = 'C' Then
				
		OpenWithParm(w_ge216_selecao_filiais, uo_Filiais)
		
		lvl_Lojas = Message.DoubleParm
		
		If lvl_Lojas > 0 Then
			ivs_filiais = uo_Filiais.ivs_filiais
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma filial foi selecionada.")
		End If
		
	End If
	
	If dw_2.GetRow() > 0 Then
		dw_2.Post Event RowFocusChanged(dw_2.GetRow())
	End If
End If
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge139_consulta_venda_produto
integer y = 368
integer width = 1093
integer height = 1220
string dataobject = "dw_ge139_lista_venda_mensal"
end type

event dw_2::constructor;call super::constructor;This.of_SetRowSelection()
end event

event dw_2::rowfocuschanged;call super::rowfocuschanged;String lvs_Selecao,&
	   lvs_Rede,&
	   lvs_Filiais

If CurrentRow > 0 Then
	dw_1.AcceptText()
	
	lvs_Selecao 	= dw_1.Object.Id_Vendas_Filiais	[1]
	lvs_Filiais	= dw_1.Object.id_filiais 				[1]	
	
	If lvs_Selecao = "S" Then
		ivdh_Base 	= This.Object.Dh_Resumo	[CurrentRow]
			
		gb_3.Text = "Vendas por Filial no M$$HEX1$$ea00$$ENDHEX$$s " + String(ivdh_Base, "mm/yyyy")
		
		dw_4.of_RestoreOriginalSQL()
		
		If lvs_Filiais = 'C' Then
			If Not IsNull( ivs_Filiais ) or ivs_Filiais <> "" Then
				dw_4.of_AppendWhere("r.cd_filial in (" + ivs_Filiais + ")")
			End If
		End If
				
		dw_4.Retrieve(io_Produto.Cd_Produto, Date(ivdh_Base))
	End If
End If
end event

event dw_2::ue_recuperar;// Override

Long ll_Produto

dw_1.AcceptText()

ll_Produto = dw_1.Object.Cd_Produto[1]

If IsNull(ll_Produto) Or ll_Produto = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o produto.")
	dw_1.Event ue_Pos(1, "de_produto")
	Return -1
End If

If Not IsDate(String(dw_1.Object.Dt_Inicio[1])) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio corretamente.")
	dw_1.Event ue_Pos(1, "dt_inicio")
	Return -1
End If

If Not IsDate(String(dw_1.Object.Dt_Termino[1])) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino corretamente.")
	dw_1.Event ue_Pos(1, "dt_termino")
	Return -1
End If

If Date(dw_1.Object.Dt_Inicio[1]) > Date(dw_1.Object.Dt_Termino[1]) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a data de t$$HEX1$$e900$$ENDHEX$$rmino.", StopSign!)
	dw_1.Event ue_Pos(1, "dt_inicio")
	Return -1
End If

wf_Verifica_Resgate()

Return This.Retrieve(io_Produto.Cd_Produto, Date(dw_1.Object.Dt_Inicio[1]), Date(dw_1.Object.Dt_Termino[1]))
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	This.Event RowFocusChanged(1)
	
	wf_Atualiza_Resgates(pl_linhas)
Else
	dw_4.Reset()
End If

Return pl_Linhas
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge139_consulta_venda_produto
boolean visible = false
integer x = 1838
integer y = 416
integer width = 800
integer height = 412
end type

event dw_3::ue_print;call super::ue_print;Long lvl_Linha

String lvs_Selecao

lvs_Selecao = dw_1.Object.Id_Vendas_Filiais[1]

If lvs_Selecao <> "S" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","A op$$HEX2$$e700e300$$ENDHEX$$o 'mostrar vendas por filial' n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ marcada.")
	Return
Else	
	lvl_Linha = dw_4.RowCount()
	
	If lvl_Linha <= 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o existem informa$$HEX2$$e700f500$$ENDHEX$$es para impress$$HEX1$$e300$$ENDHEX$$o.")
		Return
	Else
		
		This.Object.st_Mes.Text = String(ivdh_Base, "mm/yyyy")
		This.Object.Cabecalho_Produto.Text = io_Produto.ivs_Descricao_Apresentacao_Venda + " (" + String(io_Produto.Cd_Produto) + ")"
		This.of_Print(False)
	End If
End If
end event

type dw_4 from dc_uo_dw_base within w_ge139_consulta_venda_produto
integer x = 1257
integer y = 348
integer width = 1632
integer height = 1248
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge139_lista_venda_filial"
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.of_SetRowSelection()
end event

type cb_2 from commandbutton within w_ge139_consulta_venda_produto
integer x = 1975
integer y = 1636
integer width = 544
integer height = 100
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Exportar p/ Excel"
end type

event clicked;String lvs_Selecao

dw_1.AcceptText()

lvs_Selecao = dw_1.Object.Id_Vendas_Filiais[1]

If lvs_Selecao <> "S" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","A op$$HEX2$$e700e300$$ENDHEX$$o 'mostrar vendas por filial' n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ marcada.")
	Return
Else
	If dw_4.RowCount() < 1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o existem informa$$HEX2$$e700f500$$ENDHEX$$es para impress$$HEX1$$e300$$ENDHEX$$o.")
		Return
	Else
		dw_4.Event ue_SaveAs()
	End If
End If
end event

type cb_1 from commandbutton within w_ge139_consulta_venda_produto
integer x = 2569
integer y = 1636
integer width = 357
integer height = 100
integer taborder = 80
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Imprimir"
end type

event clicked;DateTime lvdh_Base

Long lvl_Linha

String lvs_Produto, &
		 lvs_Selecao

lvs_Selecao = dw_1.Object.Id_Vendas_Filiais[1]

If lvs_Selecao <> "S" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","A op$$HEX2$$e700e300$$ENDHEX$$o 'mostrar vendas por filial' n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ marcada.")
	Return
Else	
	lvl_Linha = dw_4.RowCount()
	
	If lvl_Linha <= 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o existem informa$$HEX2$$e700f500$$ENDHEX$$es para impress$$HEX1$$e300$$ENDHEX$$o.")
		Return
	Else
		dc_uo_ds_base lvds_1
		lvds_1 = Create dc_uo_ds_base
		
		lvds_1.of_ChangeDataObject("dw_ge139_relatorio_venda_filial")
		lvds_1.Retrieve(io_Produto.Cd_Produto, Date(ivdh_Base))
		
		lvds_1.Object.st_Mes.Text = String(ivdh_Base, "mm/yyyy")
		lvds_1.Object.Cabecalho_Produto.Text = io_Produto.ivs_Descricao_Apresentacao_Venda + " (" + String(io_Produto.Cd_Produto) + ")"
		lvds_1.of_Print(False)
			
		Destroy(lvds_1)
	End If
End If
end event

type gb_3 from groupbox within w_ge139_consulta_venda_produto
integer x = 1221
integer y = 292
integer width = 1691
integer height = 1328
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Vendas por Filial no M$$HEX1$$ea00$$ENDHEX$$s"
borderstyle borderstyle = styleraised!
end type

