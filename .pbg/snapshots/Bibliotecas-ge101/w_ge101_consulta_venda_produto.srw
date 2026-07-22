HA$PBExportHeader$w_ge101_consulta_venda_produto.srw
forward
global type w_ge101_consulta_venda_produto from dc_w_response
end type
type gb_3 from groupbox within w_ge101_consulta_venda_produto
end type
type gb_2 from groupbox within w_ge101_consulta_venda_produto
end type
type gb_1 from groupbox within w_ge101_consulta_venda_produto
end type
type dw_1 from dc_uo_dw_base within w_ge101_consulta_venda_produto
end type
type cb_fechar from commandbutton within w_ge101_consulta_venda_produto
end type
type dw_2 from dc_uo_dw_base within w_ge101_consulta_venda_produto
end type
type dw_3 from dc_uo_dw_base within w_ge101_consulta_venda_produto
end type
type cb_consultar from commandbutton within w_ge101_consulta_venda_produto
end type
type cb_1 from commandbutton within w_ge101_consulta_venda_produto
end type
type cb_2 from commandbutton within w_ge101_consulta_venda_produto
end type
end forward

global type w_ge101_consulta_venda_produto from dc_w_response
integer x = 599
integer y = 32
integer width = 2953
integer height = 1820
string title = "GE101 - Consulta Vendas do Produto"
boolean controlmenu = false
long backcolor = 80269524
gb_3 gb_3
gb_2 gb_2
gb_1 gb_1
dw_1 dw_1
cb_fechar cb_fechar
dw_2 dw_2
dw_3 dw_3
cb_consultar cb_consultar
cb_1 cb_1
cb_2 cb_2
end type
global w_ge101_consulta_venda_produto w_ge101_consulta_venda_produto

type variables
long ivl_produto = 0, il_pontos_resgate, il_pbm

string ivs_descricao,&
         ivs_cia

DateTime ivdh_base

String ivs_Filiais

uo_ge216_filiais uo_filiais
end variables

forward prototypes
public subroutine wf_atualiza_resgates (long pl_linhas)
public subroutine wf_verifica_resgate ()
public subroutine wf_atualiza_pbm (string as_tipo)
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
		From ajuste_estoque    (index idx_prod_motivo_data )     
		where cd_produto 						= :ll_Produto
			and cd_motivo_ajuste 			= 35
			and id_entrada_saida 				= 'S'
			and dh_movimentacao_caixa 	between :ldh_Inicio and :ldh_Termino
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
Where cd_produto = :ivl_produto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
		ivl_produto = 0
	Case -1
		SqlCa.of_MsgDbError("Erro ao localizar os pontos de resgate do clube.")
End Choose


end subroutine

public subroutine wf_atualiza_pbm (string as_tipo);Date ldt_Venda
Date ldt_Termino

Long ll_Linha
Long ll_Find
Long ll_Produto
Long ll_Linhas

String ls_Inicio
String ls_Ds

dw_1.AcceptText()
dw_2.AcceptText()

Try
	
	dc_uo_ds_base lds
	lds = Create dc_uo_ds_base
	
	If as_Tipo = "V" Then
		ls_Ds = "ds_ge101_lista_produtos_pbm"
	Else
		ls_Ds = "ds_ge101_devolucao_pbm"
	End If
	
	If Not lds.of_ChangeDataObject(ls_Ds) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar a ds '" + ls_Ds + "'.", StopSign!)
		Return
	End If
	
	ls_Inicio  	= String(dw_1.Object.Dt_Inicio [1], "dd") + "/" + String(dw_1.Object.Dt_Inicio [1], "mm") + '/' + String(dw_1.Object.Dt_Inicio [1], "yyyy")
	ldt_Termino = gf_Calcula_Ultimo_Dia_Mes(Month(Date(dw_1.Object.Dt_Termino [1])),Year(Date(dw_1.Object.Dt_Termino [1])))
	ll_Produto  	= dw_1.Object.cd_produto[1]
			
	ll_Linhas = lds.Retrieve(ll_Produto, Date(ls_Inicio), Date(ldt_Termino))
		
	If ll_Linhas < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no retrieve da ds '" + ls_Ds + "'.", StopSign!)
		Return
	End If
	
	If ll_Linhas > 0 Then
	
		Open(w_Aguarde)
		w_Aguarde.Title = "Atualizando os dados de Venda PBM"
		w_Aguarde.uo_Progress.of_SetMax(ll_Linhas)
		
		For ll_Linha = 1 To ll_Linhas
			ldt_Venda = Date("01/" + lds.Object.Dh_Venda[ll_Linha])
			
			ll_Find =  dw_2.Find("dh_resumo = Date('" + String(ldt_Venda, "yyyy/mm/dd") + "')",1, dw_2.RowCount())
							
			If ll_Find > 0 Then
				If as_Tipo = "V" Then
					dw_2.Object.qt_pbm[ll_Find] = lds.object.Qtd[ll_Linha]
				Else
					dw_2.Object.qt_pbm[ll_Find] = dw_2.Object.qt_pbm[ll_Find] - lds.object.Qtd[ll_Linha] //Diminui a quantidade de venda pela quantidade de devolu$$HEX2$$e700e300$$ENDHEX$$o
				End If
			End If
			
			w_Aguarde.uo_Progress.of_SetProgress(ll_Linha)
		Next
	End If

Catch (RunTimeError lo_error)
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lo_error.GetMessage(), StopSign!)
	Return

Finally
	Close(w_Aguarde)
	If IsValid(lds) Then Destroy(lds)
End Try
end subroutine

on w_ge101_consulta_venda_produto.create
int iCurrent
call super::create
this.gb_3=create gb_3
this.gb_2=create gb_2
this.gb_1=create gb_1
this.dw_1=create dw_1
this.cb_fechar=create cb_fechar
this.dw_2=create dw_2
this.dw_3=create dw_3
this.cb_consultar=create cb_consultar
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_3
this.Control[iCurrent+2]=this.gb_2
this.Control[iCurrent+3]=this.gb_1
this.Control[iCurrent+4]=this.dw_1
this.Control[iCurrent+5]=this.cb_fechar
this.Control[iCurrent+6]=this.dw_2
this.Control[iCurrent+7]=this.dw_3
this.Control[iCurrent+8]=this.cb_consultar
this.Control[iCurrent+9]=this.cb_1
this.Control[iCurrent+10]=this.cb_2
end on

on w_ge101_consulta_venda_produto.destroy
call super::destroy
destroy(this.gb_3)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.cb_fechar)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.cb_consultar)
destroy(this.cb_1)
destroy(this.cb_2)
end on

event open;call super::open;String lvs_Parametro

Long lvl_Filial 

lvs_Parametro = Message.StringParm

lvl_Filial 	  = Long(LeftA(lvs_Parametro, 4))
ivl_Produto   = Long(MidA(lvs_Parametro,5 ,6))
ivs_Descricao = MidA(lvs_Parametro, 11)

If lvl_Filial = 534 Then
	ivs_Cia = 'S'
Else
	ivs_Cia = 'N'
End If

wf_Verifica_Resgate()
end event

event ue_postopen;call super::ue_postopen;Boolean lvb_Sucesso = False

DateTime lvdh_Inicio, &
         lvdh_Termino
			
uo_filiais = Create uo_ge216_filiais 			
			
Select dateadd(month, -12, dh_movimentacao),
		 dh_movimentacao
Into :lvdh_Inicio, 
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
	dw_1.Event ue_AddRow()
	
	dw_1.Object.Cd_Produto[1] = ivl_Produto
	dw_1.Object.De_Produto[1] = ivs_Descricao
	dw_1.Object.Dt_Inicio [1] = Date("01/" + String(lvdh_Inicio,  "mm/yyyy"))
	dw_1.Object.Dt_Termino[1] = Date("01/" + String(lvdh_Termino, "mm/yyyy"))
			
	dw_2.Event ue_Retrieve()
	
	
	
	
Else
	Close(This)
End If
end event

event close;call super::close;Destroy uo_filiais
end event

type pb_help from dc_w_response`pb_help within w_ge101_consulta_venda_produto
end type

type gb_3 from groupbox within w_ge101_consulta_venda_produto
integer x = 1202
integer y = 264
integer width = 1705
integer height = 1320
integer taborder = 20
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

type gb_2 from groupbox within w_ge101_consulta_venda_produto
integer x = 18
integer y = 264
integer width = 1143
integer height = 1320
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Vendas/Resgate por M$$HEX1$$ea00$$ENDHEX$$s"
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within w_ge101_consulta_venda_produto
integer x = 23
integer width = 2880
integer height = 252
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
borderstyle borderstyle = styleraised!
end type

type dw_1 from dc_uo_dw_base within w_ge101_consulta_venda_produto
integer x = 46
integer y = 60
integer width = 2825
integer height = 176
boolean bringtotop = true
string dataobject = "dw_ge101_selecao_venda_mensal"
end type

event constructor;call super::constructor;This.of_SetColSelection(True)
end event

event itemchanged;call super::itemchanged;Long lvl_Lojas

String ls_Nulo

Setnull(ls_Nulo)

If dwo.Name = "id_vendas_filiais" Then
	If Data = "S" Then
		If dw_2.GetRow() > 0 Then
			dw_2.Post Event RowFocusChanged(dw_2.GetRow())
		End If
	Else
		dw_3.Reset()
	End If
End If

If  dwo.Name = "id_filiais" Then
	
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

type cb_fechar from commandbutton within w_ge101_consulta_venda_produto
integer x = 2546
integer y = 1604
integer width = 357
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Fechar"
boolean cancel = true
end type

event clicked;Close(Parent)


end event

type dw_2 from dc_uo_dw_base within w_ge101_consulta_venda_produto
integer x = 46
integer y = 316
integer width = 1093
integer height = 1232
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_ge101_lista_venda_mensal"
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.of_SetRowSelection()
end event

event ue_recuperar;// Override

String lvs_Inicio, &
       lvs_Termino
	  
dw_1.AcceptText()

lvs_Inicio 	= "01/" + String(dw_1.Object.Dt_Inicio [1], "mm/yyyy")
lvs_Termino	= "01/" + String(dw_1.Object.Dt_Termino[1], "mm/yyyy")

If Not IsDate(lvs_Inicio) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio corretamente.", StopSign!)
	dw_1.Event ue_Pos(1, "dt_inicio")
	Return -1
End If

If Not IsDate(lvs_Termino) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino corretamente.", StopSign!)
	dw_1.Event ue_Pos(1, "dt_termino")
	Return -1
End If


Return This.Retrieve(ivl_Produto, Date(lvs_Inicio), Date(lvs_Termino))

end event

event rowfocuschanged;call super::rowfocuschanged;DateTime lvdh_Base

String lvs_Selecao,&
	   lvs_Rede,&
	   lvs_FIliais

If CurrentRow > 0 Then
	dw_1.AcceptText()
	
	lvs_Selecao 	= dw_1.Object.Id_Vendas_Filiais	[1]
	lvs_FIliais		= dw_1.Object.id_filiais 				[1]	
	
	If lvs_Selecao = "S" Then
		lvdh_Base 	= This.Object.Dh_Resumo	[CurrentRow]
		ivdh_Base 	= This.Object.Dh_Resumo	[CurrentRow]
			
		gb_3.Text = "Vendas por Filial no M$$HEX1$$ea00$$ENDHEX$$s " + String(lvdh_Base, "mm/yyyy")
		
		dw_3.of_RestoreOriginalSQL()
		
		If lvs_FIliais = 'C' Then
			If Not IsNull( ivs_Filiais ) or ivs_Filiais <> "" Then
				dw_3.of_AppendWhere("r.cd_filial in (" + ivs_Filiais + ")")
			End If
		End If
				
		dw_3.Retrieve(ivl_Produto, Date(lvdh_Base))
	End If
End If
end event

event ue_postretrieve;If pl_Linhas > 0 Then
	This.Event RowFocusChanged(1)	
	
	wf_Atualiza_Resgates(pl_linhas)
	
	wf_Atualiza_Pbm("V") //Venda
	wf_Atualiza_Pbm("D") //Devolu$$HEX2$$e700e300$$ENDHEX$$o
Else
	dw_3.Reset()
End If

Return pl_Linhas
end event

type dw_3 from dc_uo_dw_base within w_ge101_consulta_venda_produto
integer x = 1239
integer y = 320
integer width = 1641
integer height = 1232
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_ge101_lista_venda_filial"
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.of_SetRowSelection()
end event

type cb_consultar from commandbutton within w_ge101_consulta_venda_produto
integer x = 18
integer y = 1604
integer width = 366
integer height = 100
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Consultar"
boolean cancel = true
end type

event clicked;dw_2.Event ue_Retrieve()







	
end event

type cb_1 from commandbutton within w_ge101_consulta_venda_produto
integer x = 2126
integer y = 1604
integer width = 357
integer height = 100
integer taborder = 70
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

dc_uo_ds_base lvds_1

uo_Produto lvo_Produto

String lvs_Produto, &
		 lvs_Selecao

lvs_Selecao = dw_1.Object.Id_Vendas_Filiais[1]

If lvs_Selecao <> "S" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","A op$$HEX2$$e700e300$$ENDHEX$$o 'mostrar vendas por filial' n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ marcada.")
	Return
Else	
	lvl_Linha = dw_3.RowCount()
	
	If lvl_Linha < 1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o existem informa$$HEX2$$e700f500$$ENDHEX$$es para impress$$HEX1$$e300$$ENDHEX$$o.")
		Return
	Else
		lvds_1 = Create dc_uo_ds_base
		lvo_Produto = Create uo_Produto
		lvo_Produto.of_Localiza_Codigo_Interno(ivl_Produto)
		lvs_Produto = lvo_Produto.De_Produto + " : " + lvo_Produto.De_Apresentacao_Venda
		
		lvds_1.of_ChangeDataObject("dw_ge101_relatorio_venda_filial")
	
		lvds_1.Retrieve(ivl_Produto, Date(ivdh_Base))
		
		lvds_1.Object.st_Mes.Text = String(ivdh_Base, "mm/yyyy")
		lvds_1.Object.Cabecalho_Produto.Text = lvs_Produto + " (" + String(ivl_produto) + ")"
		lvds_1.of_Print(False)
			
		Destroy(lvds_1)
		Destroy(lvo_Produto)
	End If
End If
end event

type cb_2 from commandbutton within w_ge101_consulta_venda_produto
integer x = 1563
integer y = 1604
integer width = 544
integer height = 100
integer taborder = 60
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
	If dw_3.RowCount() < 1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o existem informa$$HEX2$$e700f500$$ENDHEX$$es para impress$$HEX1$$e300$$ENDHEX$$o.")
		Return
	Else
		dw_3.Event ue_SaveAs()
	End If
End If
end event

