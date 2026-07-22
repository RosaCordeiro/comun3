HA$PBExportHeader$w_ge334_rel_analise_produto.srw
forward
global type w_ge334_rel_analise_produto from dc_w_sheet
end type
type tab_1 from tab within w_ge334_rel_analise_produto
end type
type tp_movimento from userobject within tab_1
end type
type tab_movimento from tab within tp_movimento
end type
type tp_resumo from userobject within tab_movimento
end type
type gb_5 from groupbox within tp_resumo
end type
type dw_resumo from dc_uo_dw_base within tp_resumo
end type
type tp_resumo from userobject within tab_movimento
gb_5 gb_5
dw_resumo dw_resumo
end type
type tp_geral from userobject within tab_movimento
end type
type gb_8 from groupbox within tp_geral
end type
type dw_movgeral from dc_uo_dw_base within tp_geral
end type
type tp_geral from userobject within tab_movimento
gb_8 gb_8
dw_movgeral dw_movgeral
end type
type tp_venda from userobject within tab_movimento
end type
type tab_venda from tab within tp_venda
end type
type tp_venda_mensal from userobject within tab_venda
end type
type gb_17 from groupbox within tp_venda_mensal
end type
type gb_18 from groupbox within tp_venda_mensal
end type
type dw_venda_mensal from dc_uo_dw_base within tp_venda_mensal
end type
type dw_venda_mensal_det from dc_uo_dw_base within tp_venda_mensal
end type
type tp_venda_mensal from userobject within tab_venda
gb_17 gb_17
gb_18 gb_18
dw_venda_mensal dw_venda_mensal
dw_venda_mensal_det dw_venda_mensal_det
end type
type tp_venda_filial from userobject within tab_venda
end type
type tab_venda_filial from tab within tp_venda_filial
end type
type tp_filial_vd from userobject within tab_venda_filial
end type
type gb_2 from groupbox within tp_filial_vd
end type
type dw_venda from dc_uo_dw_base within tp_filial_vd
end type
type tp_filial_vd from userobject within tab_venda_filial
gb_2 gb_2
dw_venda dw_venda
end type
type tp_filial_det_vd from userobject within tab_venda_filial
end type
type gb_4 from groupbox within tp_filial_det_vd
end type
type dw_venda_det from dc_uo_dw_base within tp_filial_det_vd
end type
type tp_filial_det_vd from userobject within tab_venda_filial
gb_4 gb_4
dw_venda_det dw_venda_det
end type
type tab_venda_filial from tab within tp_venda_filial
tp_filial_vd tp_filial_vd
tp_filial_det_vd tp_filial_det_vd
end type
type tp_venda_filial from userobject within tab_venda
tab_venda_filial tab_venda_filial
end type
type tab_venda from tab within tp_venda
tp_venda_mensal tp_venda_mensal
tp_venda_filial tp_venda_filial
end type
type tp_venda from userobject within tab_movimento
tab_venda tab_venda
end type
type tp_devvenda from userobject within tab_movimento
end type
type tab_devenda from tab within tp_devvenda
end type
type tp_filial_dv from userobject within tab_devenda
end type
type gb_6 from groupbox within tp_filial_dv
end type
type dw_devvenda from dc_uo_dw_base within tp_filial_dv
end type
type tp_filial_dv from userobject within tab_devenda
gb_6 gb_6
dw_devvenda dw_devvenda
end type
type tp_filial_det_dv from userobject within tab_devenda
end type
type gb_7 from groupbox within tp_filial_det_dv
end type
type dw_devvenda_det from dc_uo_dw_base within tp_filial_det_dv
end type
type tp_filial_det_dv from userobject within tab_devenda
gb_7 gb_7
dw_devvenda_det dw_devvenda_det
end type
type tab_devenda from tab within tp_devvenda
tp_filial_dv tp_filial_dv
tp_filial_det_dv tp_filial_det_dv
end type
type tp_devvenda from userobject within tab_movimento
tab_devenda tab_devenda
end type
type tp_compra from userobject within tab_movimento
end type
type tab_compra from tab within tp_compra
end type
type tp_filial_co from userobject within tab_compra
end type
type gb_9 from groupbox within tp_filial_co
end type
type dw_compra from dc_uo_dw_base within tp_filial_co
end type
type tp_filial_co from userobject within tab_compra
gb_9 gb_9
dw_compra dw_compra
end type
type tp_filial_det_co from userobject within tab_compra
end type
type gb_10 from groupbox within tp_filial_det_co
end type
type dw_compra_det from dc_uo_dw_base within tp_filial_det_co
end type
type tp_filial_det_co from userobject within tab_compra
gb_10 gb_10
dw_compra_det dw_compra_det
end type
type tab_compra from tab within tp_compra
tp_filial_co tp_filial_co
tp_filial_det_co tp_filial_det_co
end type
type tp_compra from userobject within tab_movimento
tab_compra tab_compra
end type
type tp_devcompra from userobject within tab_movimento
end type
type tab_devcompra from tab within tp_devcompra
end type
type tp_filial_dc from userobject within tab_devcompra
end type
type gb_11 from groupbox within tp_filial_dc
end type
type dw_devcompra from dc_uo_dw_base within tp_filial_dc
end type
type tp_filial_dc from userobject within tab_devcompra
gb_11 gb_11
dw_devcompra dw_devcompra
end type
type tp_filial_det_dc from userobject within tab_devcompra
end type
type gb_12 from groupbox within tp_filial_det_dc
end type
type dw_devcompra_det from dc_uo_dw_base within tp_filial_det_dc
end type
type tp_filial_det_dc from userobject within tab_devcompra
gb_12 gb_12
dw_devcompra_det dw_devcompra_det
end type
type tab_devcompra from tab within tp_devcompra
tp_filial_dc tp_filial_dc
tp_filial_det_dc tp_filial_det_dc
end type
type tp_devcompra from userobject within tab_movimento
tab_devcompra tab_devcompra
end type
type tp_transf from userobject within tab_movimento
end type
type tab_transf from tab within tp_transf
end type
type tp_filial_tf from userobject within tab_transf
end type
type gb_15 from groupbox within tp_filial_tf
end type
type dw_transf from dc_uo_dw_base within tp_filial_tf
end type
type tp_filial_tf from userobject within tab_transf
gb_15 gb_15
dw_transf dw_transf
end type
type tp_filial_det_tf from userobject within tab_transf
end type
type gb_16 from groupbox within tp_filial_det_tf
end type
type dw_transf_det from dc_uo_dw_base within tp_filial_det_tf
end type
type tp_filial_det_tf from userobject within tab_transf
gb_16 gb_16
dw_transf_det dw_transf_det
end type
type tab_transf from tab within tp_transf
tp_filial_tf tp_filial_tf
tp_filial_det_tf tp_filial_det_tf
end type
type tp_transf from userobject within tab_movimento
tab_transf tab_transf
end type
type tp_ajuste from userobject within tab_movimento
end type
type tab_ajuste from tab within tp_ajuste
end type
type tp_filial_aj from userobject within tab_ajuste
end type
type gb_13 from groupbox within tp_filial_aj
end type
type dw_ajuste from dc_uo_dw_base within tp_filial_aj
end type
type tp_filial_aj from userobject within tab_ajuste
gb_13 gb_13
dw_ajuste dw_ajuste
end type
type tp_filial_det_aj from userobject within tab_ajuste
end type
type gb_14 from groupbox within tp_filial_det_aj
end type
type dw_ajuste_det from dc_uo_dw_base within tp_filial_det_aj
end type
type tp_filial_det_aj from userobject within tab_ajuste
gb_14 gb_14
dw_ajuste_det dw_ajuste_det
end type
type tab_ajuste from tab within tp_ajuste
tp_filial_aj tp_filial_aj
tp_filial_det_aj tp_filial_det_aj
end type
type tp_ajuste from userobject within tab_movimento
tab_ajuste tab_ajuste
end type
type tab_movimento from tab within tp_movimento
tp_resumo tp_resumo
tp_geral tp_geral
tp_venda tp_venda
tp_devvenda tp_devvenda
tp_compra tp_compra
tp_devcompra tp_devcompra
tp_transf tp_transf
tp_ajuste tp_ajuste
end type
type tp_movimento from userobject within tab_1
tab_movimento tab_movimento
end type
type tp_estoque_base from userobject within tab_1
end type
type tab_estbase from tab within tp_estoque_base
end type
type tp_estbase from userobject within tab_estbase
end type
type gb_19 from groupbox within tp_estbase
end type
type dw_estoque_base from dc_uo_dw_base within tp_estbase
end type
type tp_estbase from userobject within tab_estbase
gb_19 gb_19
dw_estoque_base dw_estoque_base
end type
type tp_estbase_hist from userobject within tab_estbase
end type
type gb_20 from groupbox within tp_estbase_hist
end type
type dw_estoque_base_det from dc_uo_dw_base within tp_estbase_hist
end type
type tp_estbase_hist from userobject within tab_estbase
gb_20 gb_20
dw_estoque_base_det dw_estoque_base_det
end type
type tab_estbase from tab within tp_estoque_base
tp_estbase tp_estbase
tp_estbase_hist tp_estbase_hist
end type
type tp_estoque_base from userobject within tab_1
tab_estbase tab_estbase
end type
type tp_procurado from userobject within tab_1
end type
type tab_procurado from tab within tp_procurado
end type
type tp_filial_falta from userobject within tab_procurado
end type
type gb_21 from groupbox within tp_filial_falta
end type
type dw_procurado from dc_uo_dw_base within tp_filial_falta
end type
type tp_filial_falta from userobject within tab_procurado
gb_21 gb_21
dw_procurado dw_procurado
end type
type tp_filial_falta_det from userobject within tab_procurado
end type
type gb_22 from groupbox within tp_filial_falta_det
end type
type dw_procurado_det from dc_uo_dw_base within tp_filial_falta_det
end type
type tp_filial_falta_det from userobject within tab_procurado
gb_22 gb_22
dw_procurado_det dw_procurado_det
end type
type tab_procurado from tab within tp_procurado
tp_filial_falta tp_filial_falta
tp_filial_falta_det tp_filial_falta_det
end type
type tp_procurado from userobject within tab_1
tab_procurado tab_procurado
end type
type tp_saldo from userobject within tab_1
end type
type gb_3 from groupbox within tp_saldo
end type
type dw_saldo from dc_uo_dw_base within tp_saldo
end type
type tp_saldo from userobject within tab_1
gb_3 gb_3
dw_saldo dw_saldo
end type
type tab_1 from tab within w_ge334_rel_analise_produto
tp_movimento tp_movimento
tp_estoque_base tp_estoque_base
tp_procurado tp_procurado
tp_saldo tp_saldo
end type
type gb_1 from groupbox within w_ge334_rel_analise_produto
end type
type dw_1 from dc_uo_dw_base within w_ge334_rel_analise_produto
end type
end forward

global type w_ge334_rel_analise_produto from dc_w_sheet
integer width = 3579
integer height = 2332
string title = "GE334 - An$$HEX1$$e100$$ENDHEX$$lise Produto"
event ue_retrieve ( )
event ue_reset ( )
event ue_set_focus ( )
tab_1 tab_1
gb_1 gb_1
dw_1 dw_1
end type
global w_ge334_rel_analise_produto w_ge334_rel_analise_produto

type variables
Long ivl_Produto

Datetime ivdh_Inicio
Datetime ivdh_Fim

String ivs_Filiais

uo_produto			ivo_produto
uo_filial				ivo_filial
uo_ge216_filiais	ivo_filiais
end variables

forward prototypes
public subroutine wf_set_menu (powerobject po_control[])
public function boolean wf_localiza_usuario (string ps_matricula, string ps_nome)
end prototypes

event ue_retrieve();Long lvl_Filial
String lvs_Selecao

dw_1.AcceptText( )
Yield()

ivl_Produto	= dw_1.Object.cd_produto	[1]
ivdh_Inicio	= dw_1.Object.dh_inicio		[1]
ivdh_Fim 	= dw_1.Object.dh_fim		[1]
lvl_Filial		= dw_1.Object.cd_filial		[1]
lvs_Selecao	= dw_1.Object.id_filial		[1]

If IsNull(ivl_Produto) Or ivl_Produto = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o c$$HEX1$$f300$$ENDHEX$$digo do produto.",Exclamation!)
	dw_1.Event ue_Pos(1, "de_produto")
	Return 
End If

If ivdh_Inicio < Datetime('2010/01/01') Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio corretamente.",Exclamation!)
	dw_1.Event ue_Pos(1, "dh_inicio")
	Return 
End If

If ivdh_Fim < Datetime('2010/01/01') Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino corretamente.",Exclamation!)
	dw_1.Event ue_Pos(1, "dh_fim")
	Return 
End If

If Date(ivdh_Inicio) > Date(ivdh_Fim) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a data de t$$HEX1$$e900$$ENDHEX$$rmino.",Exclamation!)
	dw_1.Event ue_Pos(1, "dh_inicio")
	Return 
End If

If lvs_Selecao = "U" Then
	If Not IsNull(lvl_Filial) and (lvl_Filial > 0) Then
		ivs_Filiais = String(lvl_Filial)
	End If
End If

ivdh_Inicio	= Datetime(Date(ivdh_Inicio),Time('00:00:00'))
ivdh_Fim 	= Datetime(Date(ivdh_Fim),Time('23:59:59'))

Tab_1.Event ue_Retrieve()

Tab_1.Event ue_Set_Focus()
end event

event ue_reset();SetNull(ivl_Produto)
Tab_1.Event ue_Reset()
end event

public subroutine wf_set_menu (powerobject po_control[]);Any lva_Tipo

Integer 	lvi_Contador, &
       		lvi_Contador2

Tab lvtab_Control
UserObject lvo_UserObj

PowerObject lvo_Objeto

// Atualiza o menu da janela
This.ivm_Menu = This.MenuId

For lvi_Contador = 1 To UpperBound(po_control)
	lvo_Objeto = po_control[lvi_Contador]
	
	lva_Tipo = TypeOf(lvo_Objeto)
	
	Choose Case lva_Tipo
		Case DataWindow!
			lvo_Objeto.Dynamic of_SetMenu(This.ivm_Menu)		
		Case Tab!
			lvtab_Control = lvo_Objeto
			wf_set_menu(lvtab_Control.Control)
		Case UserObject!
			lvo_UserObj = lvo_Objeto
			wf_set_menu(lvo_UserObj.Control)
	End Choose
Next
end subroutine

public function boolean wf_localiza_usuario (string ps_matricula, string ps_nome);Boolean lvb_Sucesso = True

Select nm_usuario Into :ps_Nome
From usuario
Where nr_matricula = :ps_Matricula
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		
	Case 100
		ps_Nome = "DESCONHECIDO"
		
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Usu$$HEX1$$e100$$ENDHEX$$rio")
		lvb_Sucesso = False
End Choose

Return lvb_Sucesso
end function

on w_ge334_rel_analise_produto.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.gb_1=create gb_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.dw_1
end on

on w_ge334_rel_analise_produto.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_1)
destroy(this.gb_1)
destroy(this.dw_1)
end on

event ue_preopen;call super::ue_preopen;ivo_produto = Create uo_produto
ivo_filial		= Create uo_filial
ivo_filiais		= Create uo_ge216_filiais
end event

event close;call super::close;Destroy(ivo_produto)
Destroy(ivo_filial)
Destroy(ivo_filiais)
end event

event ue_postopen;call super::ue_postopen;wf_set_menu(This.Control)

dw_1.Event ue_AddRow()

ivdh_Inicio	= Datetime(RelativeDate(Today(),-1),Time('00:00'))
ivdh_Fim		= Datetime(Today(),Time('23:59:59'))

dw_1.Object.dh_inicio [1] = ivdh_Inicio
dw_1.Object.dh_fim	 [1] = ivdh_Fim


This.ivm_menu.mf_recuperar(True)

This.ivm_menu.ivb_permite_imprimir = True

dw_1.Post SetFocus()
end event

type dw_visual from dc_w_sheet`dw_visual within w_ge334_rel_analise_produto
end type

type gb_aux_visual from dc_w_sheet`gb_aux_visual within w_ge334_rel_analise_produto
end type

type tab_1 from tab within w_ge334_rel_analise_produto
event ue_reset ( )
event ue_retrieve ( )
event ue_set_focus ( )
integer x = 37
integer y = 400
integer width = 3479
integer height = 1728
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long backcolor = 79741120
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
integer selectedtab = 1
tp_movimento tp_movimento
tp_estoque_base tp_estoque_base
tp_procurado tp_procurado
tp_saldo tp_saldo
end type

event ue_reset();Long lvl_Control

For lvl_Control = 1 To UpperBound(This.Control)
	This.Control[lvl_Control].DYNAMIC Event ue_Reset()
Next
end event

event ue_retrieve();This.Control[This.SelectedTab].DYNAMIC Event ue_Retrieve()
end event

event ue_set_focus();This.Control[This.SelectedTab].DYNAMIC Event ue_set_focus()
end event

on tab_1.create
this.tp_movimento=create tp_movimento
this.tp_estoque_base=create tp_estoque_base
this.tp_procurado=create tp_procurado
this.tp_saldo=create tp_saldo
this.Control[]={this.tp_movimento,&
this.tp_estoque_base,&
this.tp_procurado,&
this.tp_saldo}
end on

on tab_1.destroy
destroy(this.tp_movimento)
destroy(this.tp_estoque_base)
destroy(this.tp_procurado)
destroy(this.tp_saldo)
end on

event selectionchanged;This.Post Event ue_Retrieve()
This.Post Event ue_Set_Focus()
end event

type tp_movimento from userobject within tab_1
event ue_retrieve ( )
event ue_reset ( )
event ue_set_focus ( )
integer x = 18
integer y = 100
integer width = 3442
integer height = 1612
long backcolor = 79741120
string text = "Movimenta$$HEX2$$e700e300$$ENDHEX$$o"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
tab_movimento tab_movimento
end type

event ue_retrieve();This.Tab_movimento.Event ue_Retrieve()
end event

event ue_reset();This.Tab_movimento.Event ue_Reset()
end event

event ue_set_focus();This.tab_movimento.Event ue_Set_Focus()
end event

on tp_movimento.create
this.tab_movimento=create tab_movimento
this.Control[]={this.tab_movimento}
end on

on tp_movimento.destroy
destroy(this.tab_movimento)
end on

type tab_movimento from tab within tp_movimento
event ue_reset ( )
event ue_retrieve ( )
event ue_set_focus ( )
integer x = 9
integer y = 24
integer width = 3424
integer height = 1576
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long backcolor = 79741120
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
boolean perpendiculartext = true
tabposition tabposition = tabsonleft!
integer selectedtab = 1
tp_resumo tp_resumo
tp_geral tp_geral
tp_venda tp_venda
tp_devvenda tp_devvenda
tp_compra tp_compra
tp_devcompra tp_devcompra
tp_transf tp_transf
tp_ajuste tp_ajuste
end type

event ue_reset();Long lvl_Control

For lvl_Control = 1 To UpperBound(This.Control)
	This.Control[lvl_Control].DYNAMIC Event ue_Reset()
Next
end event

event ue_retrieve();This.Control[This.SelectedTab].DYNAMIC Event ue_Retrieve()
end event

event ue_set_focus();This.Control[This.SelectedTab].DYNAMIC Event ue_set_focus()

end event

on tab_movimento.create
this.tp_resumo=create tp_resumo
this.tp_geral=create tp_geral
this.tp_venda=create tp_venda
this.tp_devvenda=create tp_devvenda
this.tp_compra=create tp_compra
this.tp_devcompra=create tp_devcompra
this.tp_transf=create tp_transf
this.tp_ajuste=create tp_ajuste
this.Control[]={this.tp_resumo,&
this.tp_geral,&
this.tp_venda,&
this.tp_devvenda,&
this.tp_compra,&
this.tp_devcompra,&
this.tp_transf,&
this.tp_ajuste}
end on

on tab_movimento.destroy
destroy(this.tp_resumo)
destroy(this.tp_geral)
destroy(this.tp_venda)
destroy(this.tp_devvenda)
destroy(this.tp_compra)
destroy(this.tp_devcompra)
destroy(this.tp_transf)
destroy(this.tp_ajuste)
end on

event selectionchanged;Yield()
This.Post Event ue_Retrieve()
end event

type tp_resumo from userobject within tab_movimento
event ue_retrieve ( )
event ue_reset ( )
event ue_set_focus ( )
integer x = 489
integer y = 16
integer width = 2917
integer height = 1544
long backcolor = 79741120
string text = "Resumo"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
gb_5 gb_5
dw_resumo dw_resumo
end type

event ue_retrieve();This.dw_resumo.Event ue_Retrieve()
end event

event ue_reset();This.dw_resumo.Event ue_Reset()
end event

event ue_set_focus();This.dw_resumo.SetFocus()
end event

on tp_resumo.create
this.gb_5=create gb_5
this.dw_resumo=create dw_resumo
this.Control[]={this.gb_5,&
this.dw_resumo}
end on

on tp_resumo.destroy
destroy(this.gb_5)
destroy(this.dw_resumo)
end on

type gb_5 from groupbox within tp_resumo
integer x = 32
integer width = 2862
integer height = 1528
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista"
end type

type dw_resumo from dc_uo_dw_base within tp_resumo
event ue_reducao_valores ( datetime pdh_inicio,  datetime pdh_fim )
integer x = 69
integer y = 64
integer width = 2784
integer height = 1432
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_ge334_lista_resumo"
boolean ivb_ordena_colunas = true
end type

event ue_reducao_valores(datetime pdh_inicio, datetime pdh_fim);Long lvl_Qtde_Parcial
Long lvl_Qtde

Decimal{2} lvdc_Custo_Parcial
Decimal{2} lvdc_Custo

String lvs_SQL
	
lvs_SQL = "select 	sum(case when tm.id_entrada_saida = 'S' then -1 else 1 end * case when tm.id_cancelamento = 'S' then -1 else 1 end * me.qt_movimento) as qt_movimento, " + &
					"	sum(case when tm.id_entrada_saida = 'S' then -1 else 1 end * case when tm.id_cancelamento = 'S' then -1 else 1 end * (me.qt_movimento * me.vl_custo_unitario)) as vl_movimento " + &
				" from movimento_estoque me  (index idx_produto_data_fil) " + &
				" inner join tipo_movimento_estoque tm  " + &
				"	on tm.cd_tipo_movimento = me.cd_tipo_movimento  " + &
				" where me.cd_produto = "+String(ivl_Produto) + &
				"	and me.dh_movimento >= '"+String(pdh_inicio,'YYYY/MM/DD')+"'" + &
				"	and me.dh_movimento < '"+String(pdh_fim,'YYYY/MM/DD')+"'" 
lvs_SQL += IIF((Not IsNull(ivs_Filiais))and(ivs_Filiais<>'')," and me.cd_filial_movimento in ("+ivs_Filiais+")","")//" and me.cd_filial_movimento > 0"
	
PREPARE SQLSA FROM :lvs_SQL ;
DESCRIBE SQLSA INTO SQLDA ;
DECLARE lcu_parcial DYNAMIC CURSOR FOR SQLSA ;
OPEN DYNAMIC lcu_parcial USING DESCRIPTOR SQLDA ;

// Buscar a primeira linha do resultado
FETCH lcu_parcial INTO :lvl_Qtde_Parcial, :lvdc_Custo_Parcial;

CLOSE lcu_parcial;

If IsNull(lvl_Qtde_Parcial) Then lvl_Qtde_Parcial = 0
If IsNull(lvdc_Custo_Parcial) Then lvdc_Custo_Parcial = 0

lvdc_Custo	= This.Object.vl_movimento		[1]
lvl_Qtde	 	= This.Object.qt_movimento	[1]

lvdc_Custo	+= lvdc_Custo_Parcial
lvl_Qtde	 	+= lvl_Qtde_Parcial

This.Object.vl_movimento	[1] = lvdc_Custo
This.Object.qt_movimento	[1] = lvl_Qtde
end event

event ue_recuperar;//override
Long lvl_Linha

//Time lvtm_Inicio
//lvtm_Inicio = Now()

This.SetRedraw(False)
This.Retrieve(ivdh_Inicio, ivdh_Fim, ivl_Produto)

//MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Tempo de execu$$HEX2$$e700e300$$ENDHEX$$o: '+String(SecondsAfter(lvtm_Inicio,Now()))+' seg.')

lvl_Linha = This.InsertRow(1)
This.Object.de_tipo_movimento[lvl_Linha] = 'SALDO INICIAL'
This.Object.nr_ordem		 		[lvl_Linha] = 1
This.Object.id_tipo_movimento	[lvl_Linha] = 'IN'

lvl_Linha = This.InsertRow(0)
This.Object.de_tipo_movimento[lvl_Linha] = 'SALDO FINAL'
This.Object.nr_ordem		 		[lvl_Linha] = 3
This.Object.id_tipo_movimento	[lvl_Linha] = 'FN'

Return This.RowCount()
end event

event ue_preretrieve;call super::ue_preretrieve;If IsNull(ivl_Produto) or (Not ivl_Produto > 0) Then Return -1

//Adiciona filtros relat$$HEX1$$f300$$ENDHEX$$rio impresso
This.ivs_filtro_relatorio = {""}
This.ivs_filtro_relatorio[2] = 'Per$$HEX1$$ed00$$ENDHEX$$odo: '+String(ivdh_Inicio,'DD/MM/YYYY')+' $$HEX1$$e000$$ENDHEX$$ '+String(ivdh_Fim,'DD/MM/YYYY')
This.ivs_filtro_relatorio[3] = 'Produto: '+ivo_produto.ivs_descricao_apresentacao_venda+' ('+String(ivl_Produto)+')'

If Not IsNull(ivs_Filiais) and (Trim(ivs_Filiais)<>"") Then
	This.Of_appendwhere("me.cd_filial_movimento in ("+ivs_Filiais+")")
	
	If Pos(',',ivs_Filiais) > 0 Then
		This.ivs_filtro_relatorio[4] = 'Filiais: '+ivs_Filiais
	Else	
		This.ivs_filtro_relatorio[4] = 'Filial: '+ivo_Filial.nm_fantasia+' ('+ivs_Filiais+')'		
	End If
End If

Open(w_aguarde)
w_aguarde.Title = 'Atualizando informa$$HEX2$$e700f500$$ENDHEX$$es...'
w_aguarde.uo_progress.of_setMax(3)

Return AncestorReturnValue
end event

event ue_postretrieve;call super::ue_postretrieve;Date lvdt_Saldo
Date lvdt_Mes_Inicio

Decimal{2} lvdc_Custo_Inicial
Decimal{2} lvdc_Custo_Parcial
Decimal{2} lvdc_Custo_Final

Long lvl_Qtde_Inicial
Long lvl_Qtde_Parcial
Long lvl_Qtde_Final

String lvs_SQL

w_aguarde.Title = 'Recuperando saldo inicial...'
w_aguarde.uo_progress.of_setProgress(1)

lvdt_Mes_Inicio = Date(String(ivdh_Inicio,'YYYY/MM')+'/01')
lvdt_Saldo = gf_primeiro_dia_mes(RelativeDate(lvdt_Mes_Inicio,-1))

lvs_SQL = "select coalesce(sum(s.qt_saldo_final),0), coalesce(sum(s.qt_saldo_final * s.vl_custo_medio),0) " + &
				"From saldo_produto s (index idx_data_produto) " + &
				"Where s.dh_saldo = '"+String(lvdt_Saldo,'YYYY/MM/DD')+"'" + &
				"	And s.cd_produto = "+String(ivl_Produto) + &
				"	And s.qt_saldo_final > 0 "
lvs_SQL += IIF((Not IsNull(ivs_Filiais))and(Trim(ivs_Filiais)<>'')," and s.cd_filial in ("+ivs_Filiais+")","")

PREPARE SQLSA FROM :lvs_SQL ;
DESCRIBE SQLSA INTO SQLDA ;
DECLARE lcu_saldo_inicial DYNAMIC CURSOR FOR SQLSA ;
OPEN DYNAMIC lcu_saldo_inicial USING DESCRIPTOR SQLDA ;

// Buscar a primeira linha do resultado
FETCH lcu_saldo_inicial INTO :lvl_Qtde_Inicial, :lvdc_Custo_Inicial;

CLOSE lcu_saldo_inicial;

w_aguarde.Title = 'Reduzindo os valores de produtos movimentados at$$HEX1$$e900$$ENDHEX$$ a data...'
w_aguarde.uo_progress.of_setProgress(2)

This.Object.qt_movimento	[1] = lvl_Qtde_Inicial
This.Object.vl_movimento	[1] = lvdc_Custo_Inicial

If Date(ivdh_Inicio)>lvdt_Mes_Inicio Then
	This.AcceptText( )
	This.Event ue_reducao_valores(datetime(lvdt_Mes_Inicio),ivdh_Inicio)
	
	lvl_Qtde_Inicial 	= This.Object.qt_movimento[1]
	lvdc_Custo_Inicial	= This.Object.vl_movimento	[1]
End If

This.GroupCalc( )

pl_linhas = This.RowCount()

lvl_Qtde_Parcial	= This.GetItemDecimal(pl_linhas,'qt_movimento_total')
lvdc_Custo_Parcial	= This.GetItemDecimal(pl_linhas,'vl_movimento_total')

This.Object.qt_movimento	[pl_linhas] = lvl_Qtde_Inicial + lvl_Qtde_Parcial
This.Object.vl_movimento	[pl_linhas] = lvdc_Custo_Inicial + lvdc_Custo_Parcial

w_aguarde.uo_progress.of_setProgress(3)


This.SetRedraw(True)
If IsValid(w_aguarde) Then Close(w_aguarde)

This.ivo_controle_menu.of_salvarcomo(pl_linhas > 2)
This.ivo_controle_menu.of_imprimir(pl_linhas > 2)
This.ivo_controle_menu.Of_atualiza( )

Return AncestorReturnValue
end event

event constructor;call super::constructor;This.Of_SetRowSelection( )
end event

event getfocus;call super::getfocus;This.ivo_controle_menu.of_recuperar(True)
This.ivo_controle_menu.Of_atualiza( )
end event

event losefocus;call super::losefocus;This.ivm_menu.mf_salvarcomo(False)
This.ivm_menu.mf_imprimir(False)
end event

event ue_printimmediate;//override
This.Event ue_imprimir_relatorio('Resumo Movimenta$$HEX2$$e700e300$$ENDHEX$$o Produto','CL', True)
end event

event ue_print;//override
This.Event ue_imprimir_relatorio('Resumo Movimenta$$HEX2$$e700e300$$ENDHEX$$o Produto','CL', False)
end event

type tp_geral from userobject within tab_movimento
event ue_reset ( )
event ue_retrieve ( )
event ue_set_focus ( )
integer x = 489
integer y = 16
integer width = 2917
integer height = 1544
long backcolor = 79741120
string text = "Geral"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
gb_8 gb_8
dw_movgeral dw_movgeral
end type

event ue_reset();This.dw_movgeral.Event ue_Reset()
end event

event ue_retrieve();This.dw_movgeral.Event ue_retrieve()
end event

event ue_set_focus();This.dw_movgeral.SetFocus()
end event

on tp_geral.create
this.gb_8=create gb_8
this.dw_movgeral=create dw_movgeral
this.Control[]={this.gb_8,&
this.dw_movgeral}
end on

on tp_geral.destroy
destroy(this.gb_8)
destroy(this.dw_movgeral)
end on

type gb_8 from groupbox within tp_geral
integer x = 32
integer width = 2857
integer height = 1524
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista"
end type

type dw_movgeral from dc_uo_dw_base within tp_geral
integer x = 55
integer y = 64
integer width = 2821
integer height = 1428
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_ge334_lista_geral"
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event constructor;call super::constructor;This.Of_SetRowSelection( )
end event

event getfocus;call super::getfocus;This.ivo_controle_menu.of_recuperar(True)
This.ivo_controle_menu.Of_atualiza( )
end event

event losefocus;call super::losefocus;This.ivm_menu.mf_salvarcomo(False)
This.ivm_menu.mf_imprimir(False)
end event

event ue_recuperar;//override
Return This.Retrieve(ivdh_Inicio, ivdh_Fim, ivl_Produto)
end event

event ue_preretrieve;call super::ue_preretrieve;If IsNull(ivl_Produto) or (Not ivl_Produto > 0) Then Return -1

//Adiciona filtros relat$$HEX1$$f300$$ENDHEX$$rio impresso
This.ivs_filtro_relatorio = {""}
This.ivs_filtro_relatorio[2] = 'Per$$HEX1$$ed00$$ENDHEX$$odo: '+String(ivdh_Inicio,'DD/MM/YYYY')+' $$HEX1$$e000$$ENDHEX$$ '+String(ivdh_Fim,'DD/MM/YYYY')
This.ivs_filtro_relatorio[3] = 'Produto: '+ivo_produto.ivs_descricao_apresentacao_venda+' ('+String(ivl_Produto)+')'

If Not IsNull(ivs_Filiais) and (Trim(ivs_Filiais)<>"") Then
	This.Of_appendwhere("r.cd_filial in ("+ivs_Filiais+")")
	
	If Pos(',',ivs_Filiais) > 0 Then
		This.ivs_filtro_relatorio[4] = 'Filiais: '+ivs_Filiais
	Else	
		This.ivs_filtro_relatorio[4] = 'Filial: '+ivo_Filial.nm_fantasia+' ('+ivs_Filiais+')'		
	End If
End If

Open(w_aguarde)
w_aguarde.Title = 'Atualizando informa$$HEX2$$e700f500$$ENDHEX$$es...'

Return AncestorReturnValue
end event

event ue_postretrieve;call super::ue_postretrieve;This.ivo_controle_menu.of_salvarcomo(pl_linhas > 2)
This.ivo_controle_menu.of_imprimir(pl_linhas > 2)
This.ivo_controle_menu.Of_atualiza( )
Close(w_aguarde)

Return AncestorReturnValue
end event

event ue_print;//override
This.Event ue_imprimir_relatorio('Movimenta$$HEX2$$e700e300$$ENDHEX$$o Produto por Filial','CL', False)
end event

event ue_printimmediate;//override
This.Event ue_imprimir_relatorio('Movimenta$$HEX2$$e700e300$$ENDHEX$$o Produto por Filial','CL', True)
end event

type tp_venda from userobject within tab_movimento
event ue_retrieve ( )
event ue_reset ( )
event ue_set_focus ( )
integer x = 489
integer y = 16
integer width = 2917
integer height = 1544
long backcolor = 79741120
string text = "Venda L$$HEX1$$ed00$$ENDHEX$$quida"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
tab_venda tab_venda
end type

event ue_retrieve();This.Tab_venda.Event ue_Retrieve()
end event

event ue_reset();Tab_Venda.Event ue_Reset()
end event

event ue_set_focus();Tab_venda.Event ue_Set_focus()
end event

on tp_venda.create
this.tab_venda=create tab_venda
this.Control[]={this.tab_venda}
end on

on tp_venda.destroy
destroy(this.tab_venda)
end on

type tab_venda from tab within tp_venda
event ue_reset ( )
event ue_retrieve ( )
event ue_set_focus ( )
integer x = 9
integer y = 4
integer width = 2894
integer height = 1532
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long backcolor = 79741120
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
integer selectedtab = 1
tp_venda_mensal tp_venda_mensal
tp_venda_filial tp_venda_filial
end type

event ue_reset();Long lvl_Control

For lvl_Control = 1 To UpperBound(This.Control)
	This.Control[lvl_Control].DYNAMIC Event ue_Reset()
Next
end event

event ue_retrieve();This.Control[This.SelectedTab].DYNAMIC Event ue_Retrieve()
end event

event ue_set_focus();This.Control[This.SelectedTab].DYNAMIC Event ue_set_focus()
end event

on tab_venda.create
this.tp_venda_mensal=create tp_venda_mensal
this.tp_venda_filial=create tp_venda_filial
this.Control[]={this.tp_venda_mensal,&
this.tp_venda_filial}
end on

on tab_venda.destroy
destroy(this.tp_venda_mensal)
destroy(this.tp_venda_filial)
end on

event selectionchanged;Yield()
This.Post Event ue_Retrieve()
end event

type tp_venda_mensal from userobject within tab_venda
event ue_reset ( )
event ue_retrieve ( )
event ue_set_focus ( )
integer x = 18
integer y = 100
integer width = 2857
integer height = 1416
long backcolor = 79741120
string text = "Por M$$HEX1$$ea00$$ENDHEX$$s"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
gb_17 gb_17
gb_18 gb_18
dw_venda_mensal dw_venda_mensal
dw_venda_mensal_det dw_venda_mensal_det
end type

event ue_reset();This.dw_venda_mensal.Event ue_Reset()
This.dw_venda_mensal_det.Event ue_Reset()
end event

event ue_retrieve();This.dw_venda_mensal.Event ue_Retrieve()
This.Event ue_Set_Focus()
end event

event ue_set_focus();This.dw_venda_mensal.SetFocus()
end event

on tp_venda_mensal.create
this.gb_17=create gb_17
this.gb_18=create gb_18
this.dw_venda_mensal=create dw_venda_mensal
this.dw_venda_mensal_det=create dw_venda_mensal_det
this.Control[]={this.gb_17,&
this.gb_18,&
this.dw_venda_mensal,&
this.dw_venda_mensal_det}
end on

on tp_venda_mensal.destroy
destroy(this.gb_17)
destroy(this.gb_18)
destroy(this.dw_venda_mensal)
destroy(this.dw_venda_mensal_det)
end on

type gb_17 from groupbox within tp_venda_mensal
integer x = 14
integer y = 16
integer width = 942
integer height = 1380
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Vendas/Resgate por M$$HEX1$$ea00$$ENDHEX$$s"
end type

type gb_18 from groupbox within tp_venda_mensal
integer x = 983
integer y = 16
integer width = 1851
integer height = 1380
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Vendas por Filial no M$$HEX1$$ea00$$ENDHEX$$s"
end type

type dw_venda_mensal from dc_uo_dw_base within tp_venda_mensal
event ue_atualiza_resgates ( long pl_linhas )
event type boolean ue_verifica_resgate ( )
integer x = 37
integer y = 92
integer width = 905
integer height = 1268
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_ge334_lista_venda_mensal"
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event ue_atualiza_resgates(long pl_linhas);Long lvl_Linha, lvl_Ajustes, lvs_Produto

Date lvdh_Inicio, lvdh_Termino

If Not This.Event ue_verifica_resgate() Then Return

If pl_linhas > 0 Then

	Open(w_Aguarde)
	
	w_Aguarde.Title = 'Verificando os Resgates do Produto ...'
	
	w_Aguarde.uo_Progress.of_SetMax(pl_linhas)
	
	For lvl_Linha = 1 To This.RowCount()
		
		lvdh_Inicio 		= Date(This.Object.dh_resumo[lvl_Linha])
		lvdh_Termino	= gf_Retorna_ultimo_dia_mes(lvdh_Inicio)
		
		Select sum(qt_ajuste) 
		Into :lvl_Ajustes
		From ajuste_estoque
		where cd_produto 						= :ivl_Produto
			and cd_motivo_ajuste 				= 35
			and id_entrada_saida 				= 'S'
			and dh_movimentacao_caixa between :lvdh_Inicio and :lvdh_Termino
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgDbError("Erro ao localizar os ajustes de resgates.")
			Exit
		ElseIf lvl_Ajustes > 0 Then
			This.Object.qt_resgate_clube[lvl_Linha] = lvl_Ajustes
		End If
		
		w_Aguarde.uo_Progress.of_SetProgress(lvl_Linha)
			
	Next
	
	Close(w_Aguarde)

End If
end event

event type boolean ue_verifica_resgate();Long lvl_Pontos

Select coalesce(qt_pontos_resgate, 0)
Into :lvl_Pontos
From produto_geral
Where cd_produto = :ivl_Produto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		Return (lvl_Pontos > 0)
	Case 100
		Return False
	Case -1
		SqlCa.of_MsgDbError("Erro ao localizar os pontos de resgate do clube.")
		Return False
End Choose
end event

event ue_postretrieve;call super::ue_postretrieve;This.SetRedraw(False)
This.Post SetRedraw(True)

If pl_Linhas > 0 Then
	This.Event RowFocusChanged(1)
	This.Event ue_atualiza_resgates(This.RowCount())
End If

This.ivo_controle_menu.of_salvarcomo(pl_linhas > 0)
This.ivo_controle_menu.of_imprimir(pl_linhas > 0)
This.ivo_controle_menu.Of_atualiza( )

Return AncestorReturnValue
end event

event ue_recuperar;//override
Return This.Retrieve(ivl_Produto, ivdh_Inicio, ivdh_Fim)
end event

event ue_preretrieve;call super::ue_preretrieve;If IsNull(ivl_Produto) or (Not ivl_Produto > 0) Then Return -1

This.ivs_filtro_relatorio = {""}

//Adiciona filtros relat$$HEX1$$f300$$ENDHEX$$rio impresso
This.ivs_filtro_relatorio[2] = 'Per$$HEX1$$ed00$$ENDHEX$$odo: '+String(ivdh_Inicio,'DD/MM/YYYY')+' $$HEX1$$e000$$ENDHEX$$ '+String(ivdh_Fim,'DD/MM/YYYY')
This.ivs_filtro_relatorio[3] = 'Produto: '+ivo_produto.ivs_descricao_apresentacao_venda+' ('+String(ivl_Produto)+')'
If (Not IsNull(ivs_Filiais)) and (Trim(ivs_Filiais)<>'') Then
	This.Of_appendwhere("r.cd_filial in ("+ivs_Filiais+")")
	
	If Pos(',',ivs_Filiais) > 0 Then
		This.ivs_filtro_relatorio[4] = 'Filiais: '+ivs_Filiais
	Else	
		This.ivs_filtro_relatorio[4] = 'Filial: '+ivo_Filial.nm_fantasia+' ('+ivs_Filiais+')'		
	End If
End If

Return AncestorReturnValue
end event

event rowfocuschanged;call super::rowfocuschanged;dw_venda_mensal_det.Event ue_Retrieve()
end event

event constructor;call super::constructor;This.Of_SetRowselection( )
end event

event getfocus;call super::getfocus;This.ivo_controle_menu.of_recuperar(True)
This.ivo_controle_menu.Of_atualiza( )
end event

event losefocus;call super::losefocus;This.ivm_menu.mf_salvarcomo(False)
This.ivm_menu.mf_imprimir(False)
end event

event ue_print;//override
This.Event ue_imprimir_relatorio('Vendas por M$$HEX1$$ea00$$ENDHEX$$s','CL', False)
end event

event ue_printimmediate;//override
This.Event ue_imprimir_relatorio('Vendas por M$$HEX1$$ea00$$ENDHEX$$s','CL', True)
end event

type dw_venda_mensal_det from dc_uo_dw_base within tp_venda_mensal
integer x = 1015
integer y = 92
integer width = 1810
integer height = 1268
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge334_lista_venda_mensal_det"
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event ue_preretrieve;call super::ue_preretrieve;If IsNull(ivl_Produto) or (Not ivl_Produto > 0) Then Return -1

This.ivs_filtro_relatorio = {""}

//Adiciona filtros relat$$HEX1$$f300$$ENDHEX$$rio impresso
This.ivs_filtro_relatorio[2] = 'Per$$HEX1$$ed00$$ENDHEX$$odo: '+String(ivdh_Inicio,'DD/MM/YYYY')+' $$HEX1$$e000$$ENDHEX$$ '+String(ivdh_Fim,'DD/MM/YYYY')
This.ivs_filtro_relatorio[3] = 'Produto: '+ivo_produto.ivs_descricao_apresentacao_venda+' ('+String(ivl_Produto)+')'
If (Not IsNull(ivs_Filiais)) and (Trim(ivs_Filiais)<>'') Then
	This.Of_appendwhere("r.cd_filial in ("+ivs_Filiais+")")
	
	If Pos(',',ivs_Filiais) > 0 Then
		This.ivs_filtro_relatorio[4] = 'Filiais: '+ivs_Filiais
	Else	
		This.ivs_filtro_relatorio[4] = 'Filial: '+ivo_Filial.nm_fantasia+' ('+ivs_Filiais+')'		
	End If
End If

Return AncestorReturnValue
end event

event ue_recuperar;//override
Datetime lvdth_Mes

Long lvl_Linha

lvl_Linha = Parent.dw_venda_mensal.GetRow()

If lvl_Linha <= 0 Then Return -1

lvdth_Mes = Parent.dw_venda_mensal.Object.dh_resumo [lvl_Linha]

Return This.Retrieve(ivl_Produto, lvdth_Mes)
end event

event constructor;call super::constructor;This.Of_Setrowselection( )
end event

event getfocus;call super::getfocus;This.ivo_controle_menu.of_recuperar(True)
This.ivo_controle_menu.Of_atualiza( )
end event

event losefocus;call super::losefocus;This.ivm_menu.mf_salvarcomo(False)
This.ivm_menu.mf_imprimir(False)
end event

event ue_postretrieve;call super::ue_postretrieve;This.ivo_controle_menu.of_salvarcomo(pl_linhas > 0)
This.ivo_controle_menu.of_imprimir(pl_linhas > 0)
This.ivo_controle_menu.Of_atualiza( )

Return AncestorReturnValue
end event

event ue_print;//override
Datetime lvdth_Mes

Long lvl_Linha

lvl_Linha = Parent.dw_venda_mensal.GetRow()

If lvl_Linha <= 0 Then Return 

lvdth_Mes = Parent.dw_venda_mensal.Object.dh_resumo [lvl_Linha]

This.Event ue_imprimir_relatorio('Vendas por Filial: '+String(lvdth_Mes,'MM/YYYY'),'CL', False)
end event

event ue_printimmediate;//override
Datetime lvdth_Mes

Long lvl_Linha

lvl_Linha = Parent.dw_venda_mensal.GetRow()

If lvl_Linha <= 0 Then Return 

lvdth_Mes = Parent.dw_venda_mensal.Object.dh_resumo [lvl_Linha]

This.Event ue_imprimir_relatorio('Vendas por Filial: '+String(lvdth_Mes,'MM/YYYY'),'CL', True)
end event

type tp_venda_filial from userobject within tab_venda
event ue_reset ( )
event ue_retrieve ( )
event create ( )
event destroy ( )
event ue_set_focus ( )
integer x = 18
integer y = 100
integer width = 2857
integer height = 1416
long backcolor = 79741120
string text = "Por Filial"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
tab_venda_filial tab_venda_filial
end type

event ue_reset();This.Tab_Venda_Filial.Event ue_Reset()
end event

event ue_retrieve();This.Tab_Venda_Filial.Event ue_Retrieve()
end event

on tp_venda_filial.create
this.tab_venda_filial=create tab_venda_filial
this.Control[]={this.tab_venda_filial}
end on

on tp_venda_filial.destroy
destroy(this.tab_venda_filial)
end on

event ue_set_focus();This.Tab_Venda_Filial.Event ue_Set_Focus()
end event

type tab_venda_filial from tab within tp_venda_filial
event ue_retrieve ( )
event ue_reset ( )
event ue_set_focus ( )
event create ( )
event destroy ( )
integer x = 5
integer y = 4
integer width = 2834
integer height = 1396
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long backcolor = 79741120
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
integer selectedtab = 1
tp_filial_vd tp_filial_vd
tp_filial_det_vd tp_filial_det_vd
end type

event ue_retrieve();This.SelectTab(1)
This.tp_filial_vd.Event ue_Retrieve()
end event

event ue_reset();Long lvl_Control

For lvl_Control = 1 To UpperBound(This.Control)
	This.Control[lvl_Control].DYNAMIC Event ue_Reset()
Next

This.SelectTab(1)
end event

event ue_set_focus();Choose Case This.SelectedTab
	Case 1
		If This.Tp_filial_vd.dw_venda.RowCount() > 0 Then This.Tp_filial_vd.Event ue_Set_Focus()
	Case 2
		This.Tp_filial_det_vd.Event ue_Set_Focus()
End Choose
end event

on tab_venda_filial.create
this.tp_filial_vd=create tp_filial_vd
this.tp_filial_det_vd=create tp_filial_det_vd
this.Control[]={this.tp_filial_vd,&
this.tp_filial_det_vd}
end on

on tab_venda_filial.destroy
destroy(this.tp_filial_vd)
destroy(this.tp_filial_det_vd)
end on

event selectionchanging;Long lvl_Linha
Long lvl_Filial
String lvs_Filial

If NewIndex = 2 Then
	lvl_Linha = This.tp_filial_vd.dw_venda.GetRow()
	If lvl_Linha > 0 Then
		lvs_Filial	= This.tp_filial_vd.dw_venda.Object.nm_fantasia	[lvl_Linha]
		lvl_Filial	= This.tp_filial_vd.dw_venda.Object.cd_filial		[lvl_Linha]
		
		This.Tp_filial_det_vd.gb_4.text = ' '+lvs_Filial+' ('+String(lvl_Filial)+') '
		Return 0
	Else 
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Selecione um registro para alterar posteriormente visualizar os detalhes!')
		Return 1
	End If
End If
end event

event selectionchanged;If NewIndex = 2 Then
	This.tp_filial_det_vd.Event ue_Retrieve()
End If

This.Post Event ue_Set_Focus()
end event

type tp_filial_vd from userobject within tab_venda_filial
event ue_retrieve ( )
event ue_reset ( )
event ue_set_focus ( )
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 2798
integer height = 1280
long backcolor = 79741120
string text = "Geral"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
gb_2 gb_2
dw_venda dw_venda
end type

event ue_retrieve();dw_venda.Event ue_Retrieve()
end event

event ue_reset();dw_venda.Event ue_Reset()
end event

event ue_set_focus();This.dw_venda.SetFocus()
end event

on tp_filial_vd.create
this.gb_2=create gb_2
this.dw_venda=create dw_venda
this.Control[]={this.gb_2,&
this.dw_venda}
end on

on tp_filial_vd.destroy
destroy(this.gb_2)
destroy(this.dw_venda)
end on

type gb_2 from groupbox within tp_filial_vd
integer x = 18
integer y = 4
integer width = 2757
integer height = 1260
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista"
end type

type dw_venda from dc_uo_dw_base within tp_filial_vd
event ue_reducao_valores ( datetime pdh_inicio,  datetime pdh_fim )
integer x = 41
integer y = 72
integer width = 2725
integer height = 1156
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_ge334_lista_venda"
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event ue_reducao_valores(datetime pdh_inicio, datetime pdh_fim);Long lvl_Qtde_Parcial
Long lvl_Qtde
Long lvl_Filial
Long lvl_Find

Decimal{2} lvdc_Venda
Decimal{6} lvdc_Venda_Unit
Decimal{6} lvdc_Rentab_Unit
Decimal{6} lvdc_Comiss_Unit
Decimal{6} lvdc_CMV_Unit

String lvs_SQL

lvs_SQL = 	"select r.cd_filial, sum(r.qt_venda - r.qt_devolucao_venda)  "+ &
				" from resumo_movto_estq_prd r"+ &
				" where r.cd_produto =  "+String(ivl_Produto) + &
				"	and r.dh_resumo >= '"+String(pdh_inicio,'YYYY/MM/DD')+"'" + &
				"	and r.dh_resumo < '"+String(pdh_fim,'YYYY/MM/DD')+"'" 
lvs_SQL += IIF((Not IsNull(ivs_Filiais))and(ivs_Filiais<>'')," and r.cd_filial in ("+ivs_Filiais+")","")
lvs_SQL += " Group by r.cd_filial"
	
PREPARE SQLSA FROM :lvs_SQL ;
DESCRIBE SQLSA INTO SQLDA ;
DECLARE lcu_parcial DYNAMIC CURSOR FOR SQLSA ;
OPEN DYNAMIC lcu_parcial USING DESCRIPTOR SQLDA ;

// Buscar a primeira linha do resultado
FETCH lcu_parcial INTO :lvl_Filial, :lvl_Qtde_Parcial;

Do While SQLCa.SQLCode  = 0
	lvl_Find = This.Find('cd_filial='+String(lvl_Filial),1,This.RowCount())
	
	If lvl_Find > 0 Then
		lvl_Qtde	 			= This.Object.qt_venda		[lvl_Find]
		lvdc_Venda_Unit	= This.Object.vl_venda		[lvl_Find]
		lvdc_CMV_Unit		= This.Object.vl_cmv			[lvl_Find]
		lvdc_Comiss_Unit	= This.Object.vl_comissao	[lvl_Find]
		
		If lvl_Qtde <> 0 Then
			lvdc_Venda_Unit	/= lvl_Qtde
			lvdc_CMV_Unit 		/= lvl_Qtde
			lvdc_Comiss_Unit	/= lvl_Qtde
		End If
		
		lvl_Qtde -= lvl_Qtde_Parcial
		
		If lvl_Qtde <> 0 Then
			This.Object.vl_venda			[lvl_Find] = Round(lvdc_Venda_Unit * lvl_Qtde,2)
			This.Object.vl_cmv			[lvl_Find] = Round(lvdc_CMV_Unit * lvl_Qtde,2)
			This.Object.vl_comissao		[lvl_Find] = Round(lvdc_Comiss_Unit * lvl_Qtde,2)
			This.Object.vl_rentabilidade	[lvl_Find] = Round(lvdc_Venda_Unit * lvl_Qtde,2) - Round(lvdc_CMV_Unit * lvl_Qtde,2) - Round(lvdc_Comiss_Unit * lvl_Qtde,2)
			This.Object.qt_venda			[lvl_Find] = lvl_Qtde
		Else
			This.DeleteRow(lvl_Find)
		End If
	End If
	
	FETCH lcu_parcial INTO :lvl_Filial, :lvl_Qtde_Parcial;
Loop

CLOSE lcu_parcial;
end event

event constructor;call super::constructor;This.of_setrowselection( )
end event

event getfocus;call super::getfocus;This.ivo_controle_menu.of_recuperar(True)
This.ivo_controle_menu.Of_atualiza( )

end event

event losefocus;call super::losefocus;This.ivm_menu.mf_salvarcomo(False)
This.ivm_menu.mf_imprimir(False)
end event

event ue_recuperar;//override
Datetime lvdh_Inicio
Datetime lvdh_Fim

lvdh_Inicio = Datetime(gf_primeiro_dia_mes(Date(ivdh_Inicio)))
lvdh_Fim = Datetime(gf_primeiro_dia_mes(Date(ivdh_Fim)))

Return This.Retrieve(lvdh_Inicio, lvdh_Fim, ivl_Produto)
end event

event ue_preretrieve;call super::ue_preretrieve;If IsNull(ivl_Produto) or (Not ivl_Produto > 0) Then Return -1

Open(w_aguarde)
w_aguarde.Title = 'Atualizando informa$$HEX2$$e700f500$$ENDHEX$$es...'
w_aguarde.uo_progress.of_setMax(3)

This.ivs_filtro_relatorio = {""}

//Adiciona filtros relat$$HEX1$$f300$$ENDHEX$$rio impresso
This.ivs_filtro_relatorio[2] = 'Per$$HEX1$$ed00$$ENDHEX$$odo: '+String(ivdh_Inicio,'DD/MM/YYYY')+' $$HEX1$$e000$$ENDHEX$$ '+String(ivdh_Fim,'DD/MM/YYYY')
This.ivs_filtro_relatorio[3] = 'Produto: '+ivo_produto.ivs_descricao_apresentacao_venda+' ('+String(ivl_Produto)+')'
If (Not IsNull(ivs_Filiais)) and (Trim(ivs_Filiais)<>'') Then
	This.Of_appendwhere("r.cd_filial in ("+ivs_Filiais+")")
	
	If Pos(',',ivs_Filiais) > 0 Then
		This.ivs_filtro_relatorio[4] = 'Filiais: '+ivs_Filiais
	Else	
		This.ivs_filtro_relatorio[4] = 'Filial: '+ivo_Filial.nm_fantasia+' ('+ivs_Filiais+')'		
	End If
End If

Return AncestorReturnValue
end event

event ue_postretrieve;call super::ue_postretrieve;Datetime lvdh_Mes_Inicio
Datetime lvdh_Mes_Fim

w_aguarde.Title = 'Reduzindo valores movimentados 1...'
w_aguarde.uo_progress.of_setProgress(1)

This.SetRedraw(False)
This.Post SetRedraw(True)

lvdh_Mes_Inicio = Datetime(String(ivdh_Inicio,'YYYY/MM')+'/01')
lvdh_Mes_Fim = Datetime(gf_retorna_ultimo_dia_mes(Date(ivdh_Fim)))

If ivdh_Inicio > lvdh_Mes_Inicio Then
	This.Event ue_reducao_valores(lvdh_Mes_Inicio,ivdh_inicio)
End If

w_aguarde.Title = 'Reduzindo valores movimentados 2...'
w_aguarde.uo_progress.of_setProgress(2)

If lvdh_Mes_Fim > ivdh_Fim Then
	This.Event ue_reducao_valores(Datetime(RelativeDate(Date(ivdh_Fim),+1)),Datetime(RelativeDate(Date(lvdh_Mes_Fim),+1)))
End If
w_aguarde.uo_progress.of_setProgress(3)
Close(w_aguarde)

This.ivo_controle_menu.of_salvarcomo(pl_linhas > 0)
This.ivo_controle_menu.of_imprimir(pl_linhas > 0)
This.ivo_controle_menu.Of_atualiza( )

Return AncestorReturnValue
end event

event ue_print;//override
This.Event ue_imprimir_relatorio('Vendas de Produto por Filial','CL', False)
end event

event ue_printimmediate;//override
This.Event ue_imprimir_relatorio('Vendas de Produto por Filial','CL', True)
end event

type tp_filial_det_vd from userobject within tab_venda_filial
event ue_retrieve ( )
event ue_reset ( )
event ue_set_focus ( )
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 2798
integer height = 1280
long backcolor = 79741120
string text = "Detalhes"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
gb_4 gb_4
dw_venda_det dw_venda_det
end type

event ue_retrieve();dw_venda_det.Event ue_Retrieve()
end event

event ue_reset();dw_venda_det.Event ue_Reset()
end event

event ue_set_focus();This.dw_venda_det.SetFocus()
end event

on tp_filial_det_vd.create
this.gb_4=create gb_4
this.dw_venda_det=create dw_venda_det
this.Control[]={this.gb_4,&
this.dw_venda_det}
end on

on tp_filial_det_vd.destroy
destroy(this.gb_4)
destroy(this.dw_venda_det)
end on

type gb_4 from groupbox within tp_filial_det_vd
integer x = 18
integer y = 4
integer width = 2747
integer height = 1284
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista"
end type

type dw_venda_det from dc_uo_dw_base within tp_filial_det_vd
integer x = 46
integer y = 72
integer width = 2697
integer height = 1180
integer taborder = 50
boolean bringtotop = true
string dataobject = "dw_ge334_lista_venda_det"
boolean hscrollbar = true
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event constructor;call super::constructor;This.Of_SetRowSelection( )
end event

event getfocus;call super::getfocus;This.ivo_controle_menu.of_recuperar(True)
This.ivo_controle_menu.Of_atualiza( )

end event

event losefocus;call super::losefocus;This.ivm_menu.mf_salvarcomo(False)
This.ivm_menu.mf_imprimir(False)
end event

event ue_recuperar;//override
Long lvl_Filial
Long lvl_Linha

lvl_Linha = Tab_1.tp_movimento.Tab_movimento.tp_venda.tab_venda.tp_venda_filial.tab_venda_filial.tp_filial_vd.dw_venda.GetRow()

lvl_Filial =  Tab_1.tp_movimento.Tab_movimento.tp_venda.tab_venda.tp_venda_filial.tab_venda_filial.tp_filial_vd.dw_venda.Object.cd_filial [lvl_Linha]

Return This.Retrieve(ivdh_Inicio, ivdh_Fim, ivl_Produto, lvl_Filial)
end event

event ue_postretrieve;call super::ue_postretrieve;This.ivo_controle_menu.of_salvarcomo(pl_linhas > 0)
This.ivo_controle_menu.of_imprimir(pl_linhas > 0)
This.ivo_controle_menu.Of_atualiza( )

Return AncestorReturnValue
end event

event ue_print;//override
This.Event ue_imprimir_relatorio('Movimento Vendas de Produto','CL', False)
end event

event ue_printimmediate;//override
This.Event ue_imprimir_relatorio('Movimento Vendas de Produto','CL', True)
end event

type tp_devvenda from userobject within tab_movimento
event ue_reset ( )
event ue_retrieve ( )
event ue_set_focus ( )
event create ( )
event destroy ( )
integer x = 489
integer y = 16
integer width = 2917
integer height = 1544
long backcolor = 79741120
string text = "Dev. Venda"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
tab_devenda tab_devenda
end type

event ue_reset();Tab_devenda.Event ue_reset()
end event

event ue_retrieve();Tab_devenda.Event ue_Retrieve()
end event

event ue_set_focus();Tab_devenda.Event ue_set_Focus()
end event

on tp_devvenda.create
this.tab_devenda=create tab_devenda
this.Control[]={this.tab_devenda}
end on

on tp_devvenda.destroy
destroy(this.tab_devenda)
end on

type tab_devenda from tab within tp_devvenda
event ue_retrieve ( )
event ue_reset ( )
event ue_set_focus ( )
event create ( )
event destroy ( )
integer x = 14
integer y = 8
integer width = 2889
integer height = 1520
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long backcolor = 79741120
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
integer selectedtab = 1
tp_filial_dv tp_filial_dv
tp_filial_det_dv tp_filial_det_dv
end type

event ue_retrieve();This.SelectTab(1)
This.tp_filial_dv.Event ue_Retrieve()
end event

event ue_reset();Long lvl_Control

For lvl_Control = 1 To UpperBound(This.Control)
	This.Control[lvl_Control].DYNAMIC Event ue_Reset()
Next

This.SelectTab(1)
end event

event ue_set_focus();Choose Case This.SelectedTab
	Case 1
		If This.Tp_filial_dv.dw_devvenda.RowCount() > 0 Then This.Tp_filial_dv.Event ue_Set_Focus()
	Case 2
		This.Tp_filial_det_dv.Event ue_Set_Focus()
End Choose
end event

on tab_devenda.create
this.tp_filial_dv=create tp_filial_dv
this.tp_filial_det_dv=create tp_filial_det_dv
this.Control[]={this.tp_filial_dv,&
this.tp_filial_det_dv}
end on

on tab_devenda.destroy
destroy(this.tp_filial_dv)
destroy(this.tp_filial_det_dv)
end on

event selectionchanging;Long lvl_Linha
Long lvl_Filial
String lvs_Filial

If NewIndex = 2 Then
	lvl_Linha = This.tp_filial_dv.dw_devvenda.GetRow()
	If lvl_Linha > 0 Then
		lvs_Filial	= This.tp_filial_dv.dw_devvenda.Object.nm_fantasia	[lvl_Linha]
		lvl_Filial	= This.tp_filial_dv.dw_devvenda.Object.cd_filial		[lvl_Linha]
		
		This.Tp_filial_det_dv.gb_7.text = ' '+lvs_Filial+' ('+String(lvl_Filial)+') '
		Return 0
	Else 
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Selecione um registro para alterar posteriormente visualizar os detalhes!')
		Return 1
	End If
End If
end event

event selectionchanged;If NewIndex = 2 Then
	This.tp_filial_det_dv.Event ue_Retrieve()
End If

This.Post Event ue_Set_Focus()
end event

type tp_filial_dv from userobject within tab_devenda
event ue_retrieve ( )
event ue_reset ( )
event ue_set_focus ( )
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 2853
integer height = 1404
long backcolor = 79741120
string text = "Por Filial"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
gb_6 gb_6
dw_devvenda dw_devvenda
end type

event ue_retrieve();dw_devvenda.Event ue_Retrieve()
end event

event ue_reset();dw_devvenda.Event ue_Reset()
end event

event ue_set_focus();This.dw_devvenda.SetFocus()
end event

on tp_filial_dv.create
this.gb_6=create gb_6
this.dw_devvenda=create dw_devvenda
this.Control[]={this.gb_6,&
this.dw_devvenda}
end on

on tp_filial_dv.destroy
destroy(this.gb_6)
destroy(this.dw_devvenda)
end on

type gb_6 from groupbox within tp_filial_dv
integer x = 18
integer y = 4
integer width = 2807
integer height = 1384
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista"
end type

type dw_devvenda from dc_uo_dw_base within tp_filial_dv
integer x = 41
integer y = 72
integer width = 2770
integer height = 1280
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_ge334_lista_devvenda"
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event constructor;call super::constructor;This.of_setrowselection( )
end event

event getfocus;call super::getfocus;This.ivo_controle_menu.of_recuperar(True)
This.ivo_controle_menu.Of_atualiza( )

end event

event losefocus;call super::losefocus;This.ivm_menu.mf_salvarcomo(False)
This.ivm_menu.mf_imprimir(False)
end event

event ue_recuperar;//override
Return This.Retrieve(ivdh_Inicio, ivdh_Fim, ivl_Produto)
end event

event ue_preretrieve;call super::ue_preretrieve;If IsNull(ivl_Produto) or (Not ivl_Produto > 0) Then Return -1

Open(w_aguarde)
w_aguarde.Title = 'Atualizando informa$$HEX2$$e700f500$$ENDHEX$$es...'
w_aguarde.uo_progress.of_setMax(3)

//Adiciona filtros relat$$HEX1$$f300$$ENDHEX$$rio impresso
This.ivs_filtro_relatorio = {""}
This.ivs_filtro_relatorio[2] = 'Per$$HEX1$$ed00$$ENDHEX$$odo: '+String(ivdh_Inicio,'DD/MM/YYYY')+' $$HEX1$$e000$$ENDHEX$$ '+String(ivdh_Fim,'DD/MM/YYYY')
This.ivs_filtro_relatorio[3] = 'Produto: '+ivo_produto.ivs_descricao_apresentacao_venda+' ('+String(ivl_Produto)+')'
If (Not IsNull(ivs_Filiais)) and (Trim(ivs_Filiais)<>'') Then
	This.Of_appendwhere("me.cd_filial_movimento in ("+ivs_Filiais+")")
	
	If Pos(',',ivs_Filiais) > 0 Then
		This.ivs_filtro_relatorio[4] = 'Filiais: '+ivs_Filiais
	Else	
		This.ivs_filtro_relatorio[4] = 'Filial: '+ivo_Filial.nm_fantasia+' ('+ivs_Filiais+')'		
	End If
End If

Return AncestorReturnValue
end event

event ue_postretrieve;call super::ue_postretrieve;w_aguarde.uo_progress.of_setProgress(3)
Close(w_aguarde)

This.ivo_controle_menu.of_salvarcomo(pl_linhas > 0)
This.ivo_controle_menu.of_imprimir(pl_linhas > 0)
This.ivo_controle_menu.Of_atualiza( )

Return AncestorReturnValue
end event

event ue_print;//override
This.Event ue_imprimir_relatorio('Dev. Vendas de Produto por Filial','CL', False)
end event

event ue_printimmediate;//override
This.Event ue_imprimir_relatorio('Dev. Vendas de Produto por Filial','CL', True)
end event

type tp_filial_det_dv from userobject within tab_devenda
event ue_retrieve ( )
event ue_reset ( )
event ue_set_focus ( )
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 2853
integer height = 1404
long backcolor = 79741120
string text = "Detalhes"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
gb_7 gb_7
dw_devvenda_det dw_devvenda_det
end type

event ue_retrieve();dw_devvenda_det.Event ue_Retrieve()
end event

event ue_reset();dw_devvenda_det.Event ue_Reset()
end event

event ue_set_focus();This.dw_devvenda_det.SetFocus()
end event

on tp_filial_det_dv.create
this.gb_7=create gb_7
this.dw_devvenda_det=create dw_devvenda_det
this.Control[]={this.gb_7,&
this.dw_devvenda_det}
end on

on tp_filial_det_dv.destroy
destroy(this.gb_7)
destroy(this.dw_devvenda_det)
end on

type gb_7 from groupbox within tp_filial_det_dv
integer x = 18
integer y = 4
integer width = 2811
integer height = 1384
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista"
end type

type dw_devvenda_det from dc_uo_dw_base within tp_filial_det_dv
integer x = 46
integer y = 72
integer width = 2757
integer height = 1280
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_ge334_lista_devvenda_det"
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event constructor;call super::constructor;This.Of_SetRowSelection( )
end event

event getfocus;call super::getfocus;This.ivo_controle_menu.of_recuperar(True)
This.ivo_controle_menu.Of_atualiza( )

end event

event losefocus;call super::losefocus;This.ivm_menu.mf_salvarcomo(False)
This.ivm_menu.mf_imprimir(False)
end event

event ue_recuperar;//override
Long lvl_Filial
Long lvl_Linha

lvl_Linha = Tab_1.tp_movimento.Tab_movimento.tp_devvenda.tab_devenda.tp_filial_dv.dw_devvenda.GetRow()

lvl_Filial = Tab_1.tp_movimento.Tab_movimento.tp_devvenda.tab_devenda.tp_filial_dv.dw_devvenda.Object.cd_filial [lvl_Linha]

Return This.Retrieve(ivdh_Inicio, ivdh_Fim, ivl_Produto, lvl_Filial)
end event

event ue_postretrieve;call super::ue_postretrieve;This.ivo_controle_menu.of_salvarcomo(pl_linhas > 0)
This.ivo_controle_menu.of_imprimir(pl_linhas > 0)
This.ivo_controle_menu.Of_atualiza( )

Return AncestorReturnValue
end event

event ue_print;//override
This.Event ue_imprimir_relatorio('Movimento Dev. Vendas de Produto','CL', False)
end event

event ue_printimmediate;//override
This.Event ue_imprimir_relatorio('Movimento Dev. Vendas de Produto','CL', True)
end event

type tp_compra from userobject within tab_movimento
event ue_reset ( )
event ue_retrieve ( )
event ue_set_focus ( )
event create ( )
event destroy ( )
integer x = 489
integer y = 16
integer width = 2917
integer height = 1544
long backcolor = 79741120
string text = "Compra"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
tab_compra tab_compra
end type

event ue_reset();This.Tab_compra.Event ue_Reset()
end event

event ue_retrieve();This.Tab_compra.Event ue_retrieve()
end event

event ue_set_focus();This.Tab_compra.Event ue_set_focus()
end event

on tp_compra.create
this.tab_compra=create tab_compra
this.Control[]={this.tab_compra}
end on

on tp_compra.destroy
destroy(this.tab_compra)
end on

type tab_compra from tab within tp_compra
event ue_retrieve ( )
event ue_reset ( )
event ue_set_focus ( )
event create ( )
event destroy ( )
integer x = 14
integer y = 8
integer width = 2889
integer height = 1524
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long backcolor = 79741120
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
integer selectedtab = 1
tp_filial_co tp_filial_co
tp_filial_det_co tp_filial_det_co
end type

event ue_retrieve();This.SelectTab(1)
This.tp_filial_co.Event ue_Retrieve()
end event

event ue_reset();Long lvl_Control

For lvl_Control = 1 To UpperBound(This.Control)
	This.Control[lvl_Control].DYNAMIC Event ue_Reset()
Next

This.SelectTab(1)
end event

event ue_set_focus();Choose Case This.SelectedTab
	Case 1
		If This.Tp_filial_co.dw_compra.RowCount() > 0 Then This.Tp_filial_co.Event ue_Set_Focus()
	Case 2
		This.Tp_filial_det_co.Event ue_Set_Focus()
End Choose
end event

on tab_compra.create
this.tp_filial_co=create tp_filial_co
this.tp_filial_det_co=create tp_filial_det_co
this.Control[]={this.tp_filial_co,&
this.tp_filial_det_co}
end on

on tab_compra.destroy
destroy(this.tp_filial_co)
destroy(this.tp_filial_det_co)
end on

event selectionchanging;Long lvl_Linha
Long lvl_Filial
String lvs_Filial

If NewIndex = 2 Then
	lvl_Linha = This.tp_filial_co.dw_compra.GetRow()
	If lvl_Linha > 0 Then
		lvs_Filial	= This.tp_filial_co.dw_compra.Object.nm_fantasia	[lvl_Linha]
		lvl_Filial	= This.tp_filial_co.dw_compra.Object.cd_filial		[lvl_Linha]
		
		This.Tp_filial_det_co.gb_10.text = ' '+lvs_Filial+' ('+String(lvl_Filial)+') '
		Return 0
	Else 
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Selecione um registro para alterar posteriormente visualizar os detalhes!')
		Return 1
	End If
End If
end event

event selectionchanged;If NewIndex = 2 Then
	This.tp_filial_det_co.Event ue_Retrieve()
End If

This.Post Event ue_Set_Focus()
end event

type tp_filial_co from userobject within tab_compra
event ue_retrieve ( )
event ue_reset ( )
event ue_set_focus ( )
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 2853
integer height = 1408
long backcolor = 79741120
string text = "Por Filial"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
gb_9 gb_9
dw_compra dw_compra
end type

event ue_retrieve();dw_compra.Event ue_Retrieve()
end event

event ue_reset();dw_compra.Event ue_Reset()
end event

event ue_set_focus();This.dw_compra.SetFocus()
end event

on tp_filial_co.create
this.gb_9=create gb_9
this.dw_compra=create dw_compra
this.Control[]={this.gb_9,&
this.dw_compra}
end on

on tp_filial_co.destroy
destroy(this.gb_9)
destroy(this.dw_compra)
end on

type gb_9 from groupbox within tp_filial_co
integer x = 18
integer y = 4
integer width = 2811
integer height = 1388
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista"
end type

type dw_compra from dc_uo_dw_base within tp_filial_co
event ue_reducao_valores ( datetime pdh_inicio,  datetime pdh_fim )
integer x = 41
integer y = 72
integer width = 2779
integer height = 1284
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_ge334_lista_compra"
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event ue_reducao_valores(datetime pdh_inicio, datetime pdh_fim);Long lvl_Qtde_Parcial
Long lvl_Qtde
Long lvl_Filial
Long lvl_Find

Decimal{6} lvdc_Compra
Decimal{6} lvdc_Impostos

String lvs_SQL

lvs_SQL = 	"select r.cd_filial, sum(r.qt_compra)  "+ &
				" from resumo_movto_estq_prd r"+ &
				" where r.cd_produto =  "+String(ivl_Produto) + &
				"	and r.dh_resumo >= '"+String(pdh_inicio,'YYYY/MM/DD')+"'" + &
				"	and r.dh_resumo < '"+String(pdh_fim,'YYYY/MM/DD')+"'" 
lvs_SQL += IIF((Not IsNull(ivs_Filiais))and(ivs_Filiais<>'')," and r.cd_filial in ("+ivs_Filiais+")","")
lvs_SQL += " Group by r.cd_filial"
	
PREPARE SQLSA FROM :lvs_SQL ;
DESCRIBE SQLSA INTO SQLDA ;
DECLARE lcu_parcial DYNAMIC CURSOR FOR SQLSA ;
OPEN DYNAMIC lcu_parcial USING DESCRIPTOR SQLDA ;

// Buscar a primeira linha do resultado
FETCH lcu_parcial INTO :lvl_Filial, :lvl_Qtde_Parcial;

Do While SQLCa.SQLCode  = 0
	lvl_Find = This.Find('cd_filial='+String(lvl_Filial),1,This.RowCount())
	
	If lvl_Find > 0 Then
		lvl_Qtde	 		= This.Object.qt_compra		[lvl_Find]
		lvdc_Compra	= This.Object.vl_compra		[lvl_Find]
		lvdc_Impostos	= This.Object.vl_impostos	[lvl_Find]
		
		If lvl_Qtde <> 0 Then
			lvdc_Compra	/= lvl_Qtde
			lvdc_Impostos	/= lvl_Qtde
		End If
		
		lvl_Qtde -= lvl_Qtde_Parcial
		
		If lvl_Qtde <> 0 Then
			This.Object.vl_compra	[lvl_Find] = Round(lvdc_Compra * lvl_Qtde,2)
			This.Object.vl_impostos	[lvl_Find] = Round(lvdc_Impostos * lvl_Qtde,2)
			This.Object.qt_compra	[lvl_Find] = lvl_Qtde
		Else
			This.DeleteRow(lvl_Find)
		End If
	End If
	
	FETCH lcu_parcial INTO :lvl_Filial, :lvl_Qtde_Parcial;
Loop

CLOSE lcu_parcial;
end event

event constructor;call super::constructor;This.of_setrowselection( )
end event

event getfocus;call super::getfocus;This.ivo_controle_menu.of_recuperar(True)
This.ivo_controle_menu.Of_atualiza( )

end event

event losefocus;call super::losefocus;This.ivm_menu.mf_salvarcomo(False)
This.ivm_menu.mf_imprimir(False)
end event

event ue_recuperar;//override
Datetime lvdh_Inicio
Datetime lvdh_Fim

lvdh_Inicio = Datetime(gf_primeiro_dia_mes(Date(ivdh_Inicio)))
lvdh_Fim = Datetime(gf_primeiro_dia_mes(Date(ivdh_Fim)))

Return This.Retrieve(lvdh_Inicio, lvdh_Fim, ivl_Produto)
end event

event ue_preretrieve;call super::ue_preretrieve;If IsNull(ivl_Produto) or (Not ivl_Produto > 0) Then Return -1

Open(w_aguarde)
w_aguarde.Title = 'Atualizando informa$$HEX2$$e700f500$$ENDHEX$$es...'
w_aguarde.uo_progress.of_setMax(3)

//Adiciona filtros relat$$HEX1$$f300$$ENDHEX$$rio impresso
This.ivs_filtro_relatorio = {""}
This.ivs_filtro_relatorio[2] = 'Per$$HEX1$$ed00$$ENDHEX$$odo: '+String(ivdh_Inicio,'DD/MM/YYYY')+' $$HEX1$$e000$$ENDHEX$$ '+String(ivdh_Fim,'DD/MM/YYYY')
This.ivs_filtro_relatorio[3] = 'Produto: '+ivo_produto.ivs_descricao_apresentacao_venda+' ('+String(ivl_Produto)+')'
If (Not IsNull(ivs_Filiais)) and (Trim(ivs_Filiais)<>'') Then
	This.Of_appendwhere("r.cd_filial in ("+ivs_Filiais+")")
	
	If Pos(',',ivs_Filiais) > 0 Then
		This.ivs_filtro_relatorio[4] = 'Filiais: '+ivs_Filiais
	Else	
		This.ivs_filtro_relatorio[4] = 'Filial: '+ivo_Filial.nm_fantasia+' ('+ivs_Filiais+')'		
	End If
End If

Return AncestorReturnValue
end event

event ue_postretrieve;call super::ue_postretrieve;Datetime lvdh_Mes_Inicio
Datetime lvdh_Mes_Fim

w_aguarde.Title = 'Reduzindo valores movimentados 1...'
w_aguarde.uo_progress.of_setProgress(1)

This.SetRedraw(False)
This.Post SetRedraw(True)

lvdh_Mes_Inicio = Datetime(String(ivdh_Inicio,'YYYY/MM')+'/01')
lvdh_Mes_Fim = Datetime(gf_retorna_ultimo_dia_mes(Date(ivdh_Fim)))

If ivdh_Inicio > lvdh_Mes_Inicio Then
	This.Event ue_reducao_valores(lvdh_Mes_Inicio,ivdh_inicio)
End If

w_aguarde.Title = 'Reduzindo valores movimentados 2...'
w_aguarde.uo_progress.of_setProgress(2)

If lvdh_Mes_Fim > ivdh_Fim Then
	This.Event ue_reducao_valores(Datetime(RelativeDate(Date(ivdh_Fim),+1)),Datetime(RelativeDate(Date(lvdh_Mes_Fim),+1)))
End If
w_aguarde.uo_progress.of_setProgress(3)
Close(w_aguarde)

This.ivo_controle_menu.of_salvarcomo(pl_linhas > 0)
This.ivo_controle_menu.of_imprimir(pl_linhas > 0)
This.ivo_controle_menu.Of_atualiza( )

Return AncestorReturnValue
end event

event ue_print;//override
This.Event ue_imprimir_relatorio('Compras de Produto por Filial','CL', False)
end event

event ue_printimmediate;//override
This.Event ue_imprimir_relatorio('Compras de Produto por Filial','CL', True)
end event

type tp_filial_det_co from userobject within tab_compra
event ue_retrieve ( )
event ue_reset ( )
event ue_set_focus ( )
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 2853
integer height = 1408
long backcolor = 79741120
string text = "Detalhes"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
gb_10 gb_10
dw_compra_det dw_compra_det
end type

event ue_retrieve();dw_compra_det.Event ue_Retrieve()
end event

event ue_reset();dw_compra_det.Event ue_Reset()
end event

event ue_set_focus();This.dw_compra_det.SetFocus()
end event

on tp_filial_det_co.create
this.gb_10=create gb_10
this.dw_compra_det=create dw_compra_det
this.Control[]={this.gb_10,&
this.dw_compra_det}
end on

on tp_filial_det_co.destroy
destroy(this.gb_10)
destroy(this.dw_compra_det)
end on

type gb_10 from groupbox within tp_filial_det_co
integer x = 18
integer y = 4
integer width = 2811
integer height = 1388
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista"
end type

type dw_compra_det from dc_uo_dw_base within tp_filial_det_co
integer x = 46
integer y = 72
integer width = 2761
integer height = 1284
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_ge334_lista_compra_det"
boolean hscrollbar = true
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event constructor;call super::constructor;This.Of_SetRowSelection( )
end event

event getfocus;call super::getfocus;This.ivo_controle_menu.of_recuperar(True)
This.ivo_controle_menu.Of_atualiza( )

end event

event losefocus;call super::losefocus;This.ivm_menu.mf_salvarcomo(False)
This.ivm_menu.mf_imprimir(False)
end event

event ue_recuperar;//override
Long lvl_Filial
Long lvl_Linha

lvl_Linha = Tab_1.tp_movimento.Tab_movimento.tp_compra.Tab_Compra.tp_filial_co.dw_compra.GetRow()

lvl_Filial = Tab_1.tp_movimento.Tab_movimento.tp_compra.Tab_Compra.tp_filial_co.dw_compra.Object.cd_filial [lvl_Linha]

Return This.Retrieve(ivdh_Inicio, ivdh_Fim, ivl_Produto, lvl_Filial)
end event

event ue_postretrieve;call super::ue_postretrieve;This.ivo_controle_menu.of_salvarcomo(pl_linhas > 0)
This.ivo_controle_menu.of_imprimir(pl_linhas > 0)
This.ivo_controle_menu.Of_atualiza( )

Return AncestorReturnValue
end event

event ue_print;//override
This.Event ue_imprimir_relatorio('Movimento Compras de Produto','CL', False)
end event

event ue_printimmediate;//override
This.Event ue_imprimir_relatorio('Movimento Compras de Produto','CL', True)
end event

type tp_devcompra from userobject within tab_movimento
event ue_reset ( )
event ue_retrieve ( )
event ue_set_focus ( )
event create ( )
event destroy ( )
integer x = 489
integer y = 16
integer width = 2917
integer height = 1544
long backcolor = 79741120
string text = "Dev. Compra"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
tab_devcompra tab_devcompra
end type

event ue_reset();Tab_devcompra.Event ue_Reset()
end event

event ue_retrieve();Tab_devcompra.Event ue_retrieve()
end event

event ue_set_focus();Tab_devcompra.Event ue_set_focus()
end event

on tp_devcompra.create
this.tab_devcompra=create tab_devcompra
this.Control[]={this.tab_devcompra}
end on

on tp_devcompra.destroy
destroy(this.tab_devcompra)
end on

type tab_devcompra from tab within tp_devcompra
event ue_retrieve ( )
event ue_reset ( )
event ue_set_focus ( )
event create ( )
event destroy ( )
integer x = 14
integer y = 8
integer width = 2889
integer height = 1524
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long backcolor = 79741120
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
integer selectedtab = 1
tp_filial_dc tp_filial_dc
tp_filial_det_dc tp_filial_det_dc
end type

event ue_retrieve();This.SelectTab(1)
This.tp_filial_dc.Event ue_Retrieve()
end event

event ue_reset();Long lvl_Control

For lvl_Control = 1 To UpperBound(This.Control)
	This.Control[lvl_Control].DYNAMIC Event ue_Reset()
Next

This.SelectTab(1)
end event

event ue_set_focus();Choose Case This.SelectedTab
	Case 1
		If This.Tp_filial_dc.dw_devcompra.RowCount() > 0 Then This.Tp_filial_dc.Event ue_Set_Focus()
	Case 2
		This.Tp_filial_det_dc.Event ue_Set_Focus()
End Choose
end event

on tab_devcompra.create
this.tp_filial_dc=create tp_filial_dc
this.tp_filial_det_dc=create tp_filial_det_dc
this.Control[]={this.tp_filial_dc,&
this.tp_filial_det_dc}
end on

on tab_devcompra.destroy
destroy(this.tp_filial_dc)
destroy(this.tp_filial_det_dc)
end on

event selectionchanging;Long lvl_Linha
Long lvl_Filial
String lvs_Filial

If NewIndex = 2 Then
	lvl_Linha = This.tp_filial_dc.dw_devcompra.GetRow()
	If lvl_Linha > 0 Then
		lvs_Filial	= This.tp_filial_dc.dw_devcompra.Object.nm_fantasia	[lvl_Linha]
		lvl_Filial	= This.tp_filial_dc.dw_devcompra.Object.cd_filial		[lvl_Linha]
		
		This.Tp_filial_det_dc.gb_12.text = ' '+lvs_Filial+' ('+String(lvl_Filial)+') '
		Return 0
	Else 
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Selecione um registro para alterar posteriormente visualizar os detalhes!')
		Return 1
	End If
End If
end event

event selectionchanged;If NewIndex = 2 Then
	This.tp_filial_det_dc.Event ue_Retrieve()
End If

This.Post Event ue_Set_Focus()
end event

type tp_filial_dc from userobject within tab_devcompra
event ue_retrieve ( )
event ue_reset ( )
event ue_set_focus ( )
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 2853
integer height = 1408
long backcolor = 79741120
string text = "Por Filial"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
gb_11 gb_11
dw_devcompra dw_devcompra
end type

event ue_retrieve();dw_devcompra.Event ue_Retrieve()
end event

event ue_reset();dw_devcompra.Event ue_Reset()
end event

event ue_set_focus();This.dw_devcompra.SetFocus()
end event

on tp_filial_dc.create
this.gb_11=create gb_11
this.dw_devcompra=create dw_devcompra
this.Control[]={this.gb_11,&
this.dw_devcompra}
end on

on tp_filial_dc.destroy
destroy(this.gb_11)
destroy(this.dw_devcompra)
end on

type gb_11 from groupbox within tp_filial_dc
integer x = 18
integer y = 4
integer width = 2811
integer height = 1384
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista"
end type

type dw_devcompra from dc_uo_dw_base within tp_filial_dc
integer x = 41
integer y = 72
integer width = 2775
integer height = 1280
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_ge334_lista_devcompra"
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event constructor;call super::constructor;This.of_setrowselection( )
end event

event getfocus;call super::getfocus;This.ivo_controle_menu.of_recuperar(True)
This.ivo_controle_menu.Of_atualiza( )

end event

event losefocus;call super::losefocus;This.ivm_menu.mf_salvarcomo(False)
This.ivm_menu.mf_imprimir(False)
end event

event ue_recuperar;//override
Return This.Retrieve(ivdh_Inicio, ivdh_Fim, ivl_Produto)
end event

event ue_preretrieve;call super::ue_preretrieve;If IsNull(ivl_Produto) or (Not ivl_Produto > 0) Then Return -1

Open(w_aguarde)
w_aguarde.Title = 'Atualizando informa$$HEX2$$e700f500$$ENDHEX$$es...'
w_aguarde.uo_progress.of_setMax(3)

//Adiciona filtros relat$$HEX1$$f300$$ENDHEX$$rio impresso
This.ivs_filtro_relatorio = {""}
This.ivs_filtro_relatorio[2] = 'Per$$HEX1$$ed00$$ENDHEX$$odo: '+String(ivdh_Inicio,'DD/MM/YYYY')+' $$HEX1$$e000$$ENDHEX$$ '+String(ivdh_Fim,'DD/MM/YYYY')
This.ivs_filtro_relatorio[3] = 'Produto: '+ivo_produto.ivs_descricao_apresentacao_venda+' ('+String(ivl_Produto)+')'
If (Not IsNull(ivs_Filiais)) and (Trim(ivs_Filiais)<>'') Then
	This.Of_appendwhere("me.cd_filial_movimento in ("+ivs_Filiais+")")
	
	If Pos(',',ivs_Filiais) > 0 Then
		This.ivs_filtro_relatorio[4] = 'Filiais: '+ivs_Filiais
	Else	
		This.ivs_filtro_relatorio[4] = 'Filial: '+ivo_Filial.nm_fantasia+' ('+ivs_Filiais+')'		
	End If
End If

Return AncestorReturnValue
end event

event ue_postretrieve;call super::ue_postretrieve;w_aguarde.uo_progress.of_setProgress(3)
Close(w_aguarde)

This.ivo_controle_menu.of_salvarcomo(pl_linhas > 0)
This.ivo_controle_menu.of_imprimir(pl_linhas > 0)
This.ivo_controle_menu.Of_atualiza( )

Return AncestorReturnValue
end event

event ue_print;//override
This.Event ue_imprimir_relatorio('Dev. Compra de Produto por Filial','CL', False)
end event

event ue_printimmediate;//override
This.Event ue_imprimir_relatorio('Dev. Compra de Produto por Filial','CL', True)
end event

type tp_filial_det_dc from userobject within tab_devcompra
event ue_retrieve ( )
event ue_reset ( )
event ue_set_focus ( )
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 2853
integer height = 1408
long backcolor = 79741120
string text = "Detalhes"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
gb_12 gb_12
dw_devcompra_det dw_devcompra_det
end type

event ue_retrieve();dw_devcompra_det.Event ue_Retrieve()
end event

event ue_reset();dw_devcompra_det.Event ue_Reset()
end event

event ue_set_focus();This.dw_devcompra_det.SetFocus()
end event

on tp_filial_det_dc.create
this.gb_12=create gb_12
this.dw_devcompra_det=create dw_devcompra_det
this.Control[]={this.gb_12,&
this.dw_devcompra_det}
end on

on tp_filial_det_dc.destroy
destroy(this.gb_12)
destroy(this.dw_devcompra_det)
end on

type gb_12 from groupbox within tp_filial_det_dc
integer x = 18
integer y = 4
integer width = 2811
integer height = 1388
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista"
end type

type dw_devcompra_det from dc_uo_dw_base within tp_filial_det_dc
integer x = 46
integer y = 72
integer width = 2757
integer height = 1284
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_ge334_lista_devcompra_det"
boolean hscrollbar = true
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event constructor;call super::constructor;This.Of_SetRowSelection( )
end event

event getfocus;call super::getfocus;This.ivo_controle_menu.of_recuperar(True)
This.ivo_controle_menu.Of_atualiza( )

end event

event losefocus;call super::losefocus;This.ivm_menu.mf_salvarcomo(False)
This.ivm_menu.mf_imprimir(False)
end event

event ue_recuperar;//override
Long lvl_Filial
Long lvl_Linha

lvl_Linha = Tab_1.tp_movimento.Tab_movimento.tp_devcompra.tab_devcompra.tp_filial_dc.dw_devcompra.GetRow()

lvl_Filial = Tab_1.tp_movimento.Tab_movimento.tp_devcompra.tab_devcompra.tp_filial_dc.dw_devcompra.Object.cd_filial [lvl_Linha]

Return This.Retrieve(ivdh_Inicio, ivdh_Fim, ivl_Produto, lvl_Filial)
end event

event ue_postretrieve;call super::ue_postretrieve;This.ivo_controle_menu.of_salvarcomo(pl_linhas > 0)
This.ivo_controle_menu.of_imprimir(pl_linhas > 0)
This.ivo_controle_menu.Of_atualiza( )

Return AncestorReturnValue
end event

event ue_print;//override
This.Event ue_imprimir_relatorio('Movimento Dev. Compra de Produto','CL', False)
end event

event ue_printimmediate;//override
This.Event ue_imprimir_relatorio('Movimento Dev. Compra de Produto','CL', True)
end event

type tp_transf from userobject within tab_movimento
event ue_reset ( )
event ue_retrieve ( )
event ue_set_focus ( )
event create ( )
event destroy ( )
integer x = 489
integer y = 16
integer width = 2917
integer height = 1544
long backcolor = 79741120
string text = "Transfer$$HEX1$$ea00$$ENDHEX$$ncia"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
tab_transf tab_transf
end type

event ue_reset();This.Tab_transf.Event ue_Reset()
end event

event ue_retrieve();This.Tab_transf.Event ue_Retrieve()
end event

event ue_set_focus();This.Tab_transf.Event ue_Set_Focus()
end event

on tp_transf.create
this.tab_transf=create tab_transf
this.Control[]={this.tab_transf}
end on

on tp_transf.destroy
destroy(this.tab_transf)
end on

type tab_transf from tab within tp_transf
event ue_retrieve ( )
event ue_reset ( )
event ue_set_focus ( )
event create ( )
event destroy ( )
integer x = 14
integer y = 8
integer width = 2894
integer height = 1524
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long backcolor = 79741120
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
integer selectedtab = 1
tp_filial_tf tp_filial_tf
tp_filial_det_tf tp_filial_det_tf
end type

event ue_retrieve();This.SelectTab(1)
This.tp_filial_tf.Event ue_Retrieve()
end event

event ue_reset();Long lvl_Control

For lvl_Control = 1 To UpperBound(This.Control)
	This.Control[lvl_Control].DYNAMIC Event ue_Reset()
Next

This.SelectTab(1)
end event

event ue_set_focus();Choose Case This.SelectedTab
	Case 1
		If This.Tp_filial_tf.dw_transf.RowCount() > 0 Then This.Tp_filial_tf.Event ue_Set_Focus()
	Case 2
		This.Tp_filial_det_tf.Event ue_Set_Focus()
End Choose
end event

on tab_transf.create
this.tp_filial_tf=create tp_filial_tf
this.tp_filial_det_tf=create tp_filial_det_tf
this.Control[]={this.tp_filial_tf,&
this.tp_filial_det_tf}
end on

on tab_transf.destroy
destroy(this.tp_filial_tf)
destroy(this.tp_filial_det_tf)
end on

event selectionchanging;Long lvl_Linha
Long lvl_Filial
String lvs_Filial

If NewIndex = 2 Then
	lvl_Linha = This.tp_filial_tf.dw_transf.GetRow()
	If lvl_Linha > 0 Then
		lvs_Filial	= This.tp_filial_tf.dw_transf.Object.nm_fantasia	[lvl_Linha]
		lvl_Filial	= This.tp_filial_tf.dw_transf.Object.cd_filial		[lvl_Linha]
		
		This.tp_filial_det_tf.gb_16.text = ' '+lvs_Filial+' ('+String(lvl_Filial)+') '
		Return 0
	Else 
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Selecione um registro para alterar posteriormente visualizar os detalhes!')
		Return 1
	End If
End If
end event

event selectionchanged;If NewIndex = 2 Then
	This.tp_filial_det_tf.Event ue_Retrieve()
End If

This.Post Event ue_Set_Focus()
end event

type tp_filial_tf from userobject within tab_transf
event ue_retrieve ( )
event ue_reset ( )
event ue_set_focus ( )
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 2857
integer height = 1408
long backcolor = 79741120
string text = "Por Filial"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
gb_15 gb_15
dw_transf dw_transf
end type

event ue_retrieve();dw_transf.Event ue_Retrieve()
end event

event ue_reset();dw_transf.Event ue_Reset()
end event

event ue_set_focus();This.dw_transf.SetFocus()
end event

on tp_filial_tf.create
this.gb_15=create gb_15
this.dw_transf=create dw_transf
this.Control[]={this.gb_15,&
this.dw_transf}
end on

on tp_filial_tf.destroy
destroy(this.gb_15)
destroy(this.dw_transf)
end on

type gb_15 from groupbox within tp_filial_tf
integer x = 18
integer y = 4
integer width = 2816
integer height = 1384
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista"
end type

type dw_transf from dc_uo_dw_base within tp_filial_tf
integer x = 41
integer y = 72
integer width = 2779
integer height = 1280
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_ge334_lista_transf"
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event constructor;call super::constructor;This.of_setrowselection( )
end event

event getfocus;call super::getfocus;This.ivo_controle_menu.of_recuperar(True)
This.ivo_controle_menu.Of_atualiza( )

end event

event losefocus;call super::losefocus;This.ivm_menu.mf_salvarcomo(False)
This.ivm_menu.mf_imprimir(False)
end event

event ue_recuperar;//override
Return This.Retrieve(ivdh_Inicio, ivdh_Fim, ivl_Produto)
end event

event ue_preretrieve;call super::ue_preretrieve;If IsNull(ivl_Produto) or (Not ivl_Produto > 0) Then Return -1

Open(w_aguarde)
w_aguarde.Title = 'Atualizando informa$$HEX2$$e700f500$$ENDHEX$$es...'
w_aguarde.uo_progress.of_setMax(3)

//Adiciona filtros relat$$HEX1$$f300$$ENDHEX$$rio impresso
This.ivs_filtro_relatorio = {""}
This.ivs_filtro_relatorio[2] = 'Per$$HEX1$$ed00$$ENDHEX$$odo: '+String(ivdh_Inicio,'DD/MM/YYYY')+' $$HEX1$$e000$$ENDHEX$$ '+String(ivdh_Fim,'DD/MM/YYYY')
This.ivs_filtro_relatorio[3] = 'Produto: '+ivo_produto.ivs_descricao_apresentacao_venda+' ('+String(ivl_Produto)+')'
If (Not IsNull(ivs_Filiais)) and (Trim(ivs_Filiais)<>'') Then
	This.Of_appendwhere("me.cd_filial_movimento in ("+ivs_Filiais+")")
	
	If Pos(',',ivs_Filiais) > 0 Then
		This.ivs_filtro_relatorio[4] = 'Filiais: '+ivs_Filiais
	Else	
		This.ivs_filtro_relatorio[4] = 'Filial: '+ivo_Filial.nm_fantasia+' ('+ivs_Filiais+')'		
	End If
End If

Return AncestorReturnValue
end event

event ue_postretrieve;call super::ue_postretrieve;w_aguarde.uo_progress.of_setProgress(3)
Close(w_aguarde)

This.ivo_controle_menu.of_salvarcomo(pl_linhas > 0)
This.ivo_controle_menu.of_imprimir(pl_linhas > 0)
This.ivo_controle_menu.Of_atualiza( )

Return AncestorReturnValue
end event

event ue_print;//override
This.Event ue_imprimir_relatorio('Dev. Compra de Produto por Filial','CL', False)
end event

event ue_printimmediate;//override
This.Event ue_imprimir_relatorio('Dev. Compra de Produto por Filial','CL', True)
end event

type tp_filial_det_tf from userobject within tab_transf
event ue_retrieve ( )
event ue_reset ( )
event ue_set_focus ( )
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 2857
integer height = 1408
long backcolor = 79741120
string text = "Detalhes"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
gb_16 gb_16
dw_transf_det dw_transf_det
end type

event ue_retrieve();dw_transf_det.Event ue_Retrieve()
end event

event ue_reset();dw_transf_det.Event ue_Reset()
end event

event ue_set_focus();dw_transf_det.SetFocus()
end event

on tp_filial_det_tf.create
this.gb_16=create gb_16
this.dw_transf_det=create dw_transf_det
this.Control[]={this.gb_16,&
this.dw_transf_det}
end on

on tp_filial_det_tf.destroy
destroy(this.gb_16)
destroy(this.dw_transf_det)
end on

type gb_16 from groupbox within tp_filial_det_tf
integer x = 18
integer y = 4
integer width = 2811
integer height = 1384
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista"
end type

type dw_transf_det from dc_uo_dw_base within tp_filial_det_tf
integer x = 46
integer y = 72
integer width = 2757
integer height = 1280
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_ge334_lista_transf_det"
boolean hscrollbar = true
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event constructor;call super::constructor;This.Of_SetRowSelection( )
end event

event getfocus;call super::getfocus;This.ivo_controle_menu.of_recuperar(True)
This.ivo_controle_menu.Of_atualiza( )

end event

event losefocus;call super::losefocus;This.ivm_menu.mf_salvarcomo(False)
This.ivm_menu.mf_imprimir(False)
end event

event ue_recuperar;//override
Long lvl_Filial
Long lvl_Linha

lvl_Linha = Tab_1.tp_movimento.Tab_movimento.tp_transf.tab_transf.tp_filial_tf.dw_transf.GetRow()

lvl_Filial = Tab_1.tp_movimento.Tab_movimento.tp_transf.tab_transf.tp_filial_tf.dw_transf.Object.cd_filial [lvl_Linha]

Return This.Retrieve(ivdh_Inicio, ivdh_Fim, ivl_Produto, lvl_Filial)
end event

event ue_postretrieve;call super::ue_postretrieve;This.ivo_controle_menu.of_salvarcomo(pl_linhas > 0)
This.ivo_controle_menu.of_imprimir(pl_linhas > 0)
This.ivo_controle_menu.Of_atualiza( )

Return AncestorReturnValue
end event

event ue_print;//override
This.Event ue_imprimir_relatorio('Movimento Transfer$$HEX1$$ea00$$ENDHEX$$ncia de Produto','CL', False)
end event

event ue_printimmediate;//override
This.Event ue_imprimir_relatorio('Movimento Transfer$$HEX1$$ea00$$ENDHEX$$ncia de Produto','CL', True)
end event

type tp_ajuste from userobject within tab_movimento
event ue_reset ( )
event ue_retrieve ( )
event ue_set_focus ( )
event create ( )
event destroy ( )
integer x = 489
integer y = 16
integer width = 2917
integer height = 1544
long backcolor = 79741120
string text = "Ajuste"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
tab_ajuste tab_ajuste
end type

event ue_reset();This.Tab_ajuste.Event ue_Reset()
end event

event ue_retrieve();This.Tab_ajuste.Event ue_Retrieve()
end event

event ue_set_focus();This.Tab_ajuste.Event ue_set_focus()
end event

on tp_ajuste.create
this.tab_ajuste=create tab_ajuste
this.Control[]={this.tab_ajuste}
end on

on tp_ajuste.destroy
destroy(this.tab_ajuste)
end on

type tab_ajuste from tab within tp_ajuste
event ue_retrieve ( )
event ue_reset ( )
event ue_set_focus ( )
event create ( )
event destroy ( )
integer x = 14
integer y = 8
integer width = 2889
integer height = 1524
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long backcolor = 79741120
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
integer selectedtab = 1
tp_filial_aj tp_filial_aj
tp_filial_det_aj tp_filial_det_aj
end type

event ue_retrieve();This.SelectTab(1)
This.tp_filial_aj.Event ue_Retrieve()
end event

event ue_reset();Long lvl_Control

For lvl_Control = 1 To UpperBound(This.Control)
	This.Control[lvl_Control].DYNAMIC Event ue_Reset()
Next

This.SelectTab(1)
end event

event ue_set_focus();Choose Case This.SelectedTab
	Case 1
		If This.Tp_filial_aj.dw_ajuste.RowCount() > 0 Then This.Tp_filial_aj.Event ue_Set_Focus()
	Case 2
		This.Tp_filial_det_aj.Event ue_Set_Focus()
End Choose
end event

on tab_ajuste.create
this.tp_filial_aj=create tp_filial_aj
this.tp_filial_det_aj=create tp_filial_det_aj
this.Control[]={this.tp_filial_aj,&
this.tp_filial_det_aj}
end on

on tab_ajuste.destroy
destroy(this.tp_filial_aj)
destroy(this.tp_filial_det_aj)
end on

event selectionchanging;Long lvl_Linha
Long lvl_Filial
String lvs_Filial

If NewIndex = 2 Then
	lvl_Linha = This.tp_filial_aj.dw_ajuste.GetRow()
	If lvl_Linha > 0 Then
		lvs_Filial	= This.tp_filial_aj.dw_ajuste.Object.nm_fantasia	[lvl_Linha]
		lvl_Filial	= This.tp_filial_aj.dw_ajuste.Object.cd_filial			[lvl_Linha]
		
		This.Tp_filial_det_aj.gb_14.text = ' '+lvs_Filial+' ('+String(lvl_Filial)+') '
		Return 0
	Else 
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Selecione um registro para alterar posteriormente visualizar os detalhes!')
		Return 1
	End If
End If
end event

event selectionchanged;If NewIndex = 2 Then
	This.tp_filial_det_aj.Event ue_Retrieve()
End If

This.Post Event ue_Set_Focus()
end event

type tp_filial_aj from userobject within tab_ajuste
event ue_retrieve ( )
event ue_reset ( )
event ue_set_focus ( )
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 2853
integer height = 1408
long backcolor = 79741120
string text = "Por Filial"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
gb_13 gb_13
dw_ajuste dw_ajuste
end type

event ue_retrieve();dw_ajuste.Event ue_Retrieve()
end event

event ue_reset();dw_ajuste.Event ue_Reset()
end event

event ue_set_focus();This.dw_ajuste.SetFocus()
end event

on tp_filial_aj.create
this.gb_13=create gb_13
this.dw_ajuste=create dw_ajuste
this.Control[]={this.gb_13,&
this.dw_ajuste}
end on

on tp_filial_aj.destroy
destroy(this.gb_13)
destroy(this.dw_ajuste)
end on

type gb_13 from groupbox within tp_filial_aj
integer x = 18
integer y = 4
integer width = 2807
integer height = 1388
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista"
end type

type dw_ajuste from dc_uo_dw_base within tp_filial_aj
integer x = 41
integer y = 72
integer width = 2757
integer height = 1284
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_ge334_lista_ajuste"
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event constructor;call super::constructor;This.of_setrowselection( )
end event

event getfocus;call super::getfocus;This.ivo_controle_menu.of_recuperar(True)
This.ivo_controle_menu.Of_atualiza( )

end event

event losefocus;call super::losefocus;This.ivm_menu.mf_salvarcomo(False)
This.ivm_menu.mf_imprimir(False)
end event

event ue_recuperar;//override
Return This.Retrieve(ivdh_Inicio, ivdh_Fim, ivl_Produto)
end event

event ue_preretrieve;call super::ue_preretrieve;If IsNull(ivl_Produto) or (Not ivl_Produto > 0) Then Return -1

Open(w_aguarde)
w_aguarde.Title = 'Atualizando informa$$HEX2$$e700f500$$ENDHEX$$es...'
w_aguarde.uo_progress.of_setMax(3)

//Adiciona filtros relat$$HEX1$$f300$$ENDHEX$$rio impresso
This.ivs_filtro_relatorio = {""}
This.ivs_filtro_relatorio[2] = 'Per$$HEX1$$ed00$$ENDHEX$$odo: '+String(ivdh_Inicio,'DD/MM/YYYY')+' $$HEX1$$e000$$ENDHEX$$ '+String(ivdh_Fim,'DD/MM/YYYY')
This.ivs_filtro_relatorio[3] = 'Produto: '+ivo_produto.ivs_descricao_apresentacao_venda+' ('+String(ivl_Produto)+')'
If (Not IsNull(ivs_Filiais)) and (Trim(ivs_Filiais)<>'') Then
	This.Of_appendwhere("me.cd_filial_movimento in ("+ivs_Filiais+")")
	
	If Pos(',',ivs_Filiais) > 0 Then
		This.ivs_filtro_relatorio[4] = 'Filiais: '+ivs_Filiais
	Else	
		This.ivs_filtro_relatorio[4] = 'Filial: '+ivo_Filial.nm_fantasia+' ('+ivs_Filiais+')'		
	End If
End If

Return AncestorReturnValue
end event

event ue_postretrieve;call super::ue_postretrieve;w_aguarde.uo_progress.of_setProgress(3)
Close(w_aguarde)

This.ivo_controle_menu.of_salvarcomo(pl_linhas > 0)
This.ivo_controle_menu.of_imprimir(pl_linhas > 0)
This.ivo_controle_menu.Of_atualiza( )

Return AncestorReturnValue
end event

event ue_print;//override
This.Event ue_imprimir_relatorio('Ajustes de Produto por Filial','CL', False)
end event

event ue_printimmediate;//override
This.Event ue_imprimir_relatorio('Ajustes de Produto por Filial','CL', True)
end event

type tp_filial_det_aj from userobject within tab_ajuste
event ue_retrieve ( )
event ue_reset ( )
event ue_set_focus ( )
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 2853
integer height = 1408
long backcolor = 79741120
string text = "Detalhes"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
gb_14 gb_14
dw_ajuste_det dw_ajuste_det
end type

event ue_retrieve();dw_ajuste_det.Event ue_Retrieve()
end event

event ue_reset();dw_ajuste_det.Event ue_Reset()
end event

event ue_set_focus();This.dw_ajuste_det.SetFocus()
end event

on tp_filial_det_aj.create
this.gb_14=create gb_14
this.dw_ajuste_det=create dw_ajuste_det
this.Control[]={this.gb_14,&
this.dw_ajuste_det}
end on

on tp_filial_det_aj.destroy
destroy(this.gb_14)
destroy(this.dw_ajuste_det)
end on

type gb_14 from groupbox within tp_filial_det_aj
integer x = 18
integer y = 4
integer width = 2807
integer height = 1384
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista"
end type

type dw_ajuste_det from dc_uo_dw_base within tp_filial_det_aj
integer x = 46
integer y = 72
integer width = 2752
integer height = 1280
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_ge334_lista_ajuste_det"
boolean hscrollbar = true
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event constructor;call super::constructor;This.Of_SetRowSelection( )
end event

event getfocus;call super::getfocus;This.ivo_controle_menu.of_recuperar(True)
This.ivo_controle_menu.Of_atualiza( )

end event

event losefocus;call super::losefocus;This.ivm_menu.mf_salvarcomo(False)
This.ivm_menu.mf_imprimir(False)
end event

event ue_recuperar;//override
Long lvl_Filial
Long lvl_Linha

lvl_Linha = Tab_1.tp_movimento.Tab_movimento.tp_ajuste.tab_ajuste.tp_filial_aj.dw_ajuste.GetRow()

lvl_Filial = Tab_1.tp_movimento.Tab_movimento.tp_ajuste.tab_ajuste.tp_filial_aj.dw_ajuste.Object.cd_filial [lvl_Linha]

Return This.Retrieve(ivdh_Inicio, ivdh_Fim, ivl_Produto, lvl_Filial)
end event

event ue_postretrieve;call super::ue_postretrieve;This.ivo_controle_menu.of_salvarcomo(pl_linhas > 0)
This.ivo_controle_menu.of_imprimir(pl_linhas > 0)
This.ivo_controle_menu.Of_atualiza( )

Return AncestorReturnValue
end event

event ue_print;//override
This.Event ue_imprimir_relatorio('Movimento Ajustes de Produto','CL', False)
end event

event ue_printimmediate;//override
This.Event ue_imprimir_relatorio('Movimento Ajustes de Produto','CL', True)
end event

type tp_estoque_base from userobject within tab_1
event ue_reset ( )
event ue_retrieve ( )
event ue_set_focus ( )
integer x = 18
integer y = 100
integer width = 3442
integer height = 1612
long backcolor = 79741120
string text = "Estoque Base"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
tab_estbase tab_estbase
end type

event ue_reset();This.Tab_estbase.Event ue_Reset()
end event

event ue_retrieve();This.Tab_estbase.Event ue_Retrieve()
end event

event ue_set_focus();This.tab_estbase.Event ue_Set_Focus()
end event

on tp_estoque_base.create
this.tab_estbase=create tab_estbase
this.Control[]={this.tab_estbase}
end on

on tp_estoque_base.destroy
destroy(this.tab_estbase)
end on

type tab_estbase from tab within tp_estoque_base
event create ( )
event destroy ( )
event ue_reset ( )
event ue_retrieve ( )
event ue_set_focus ( )
integer x = 5
integer y = 16
integer width = 3429
integer height = 1588
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long backcolor = 79741120
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
integer selectedtab = 1
tp_estbase tp_estbase
tp_estbase_hist tp_estbase_hist
end type

on tab_estbase.create
this.tp_estbase=create tp_estbase
this.tp_estbase_hist=create tp_estbase_hist
this.Control[]={this.tp_estbase,&
this.tp_estbase_hist}
end on

on tab_estbase.destroy
destroy(this.tp_estbase)
destroy(this.tp_estbase_hist)
end on

event ue_reset();Long lvl_Control

For lvl_Control = 1 To UpperBound(This.Control)
	This.Control[lvl_Control].DYNAMIC Event ue_Reset()
Next
end event

event ue_retrieve();This.SelectTab(1)
This.Control[This.SelectedTab].DYNAMIC Event ue_Retrieve()
end event

event ue_set_focus();This.Control[This.SelectedTab].DYNAMIC Event ue_set_focus()
end event

event selectionchanging;Long lvl_Linha
Long lvl_Filial
String lvs_Filial

If NewIndex = 2 Then
	lvl_Linha = This.tp_estbase.dw_estoque_base.GetRow()
	If lvl_Linha > 0 Then
		lvs_Filial	= This.tp_estbase.dw_estoque_base.Object.nm_fantasia	[lvl_Linha]
		lvl_Filial	= This.tp_estbase.dw_estoque_base.Object.cd_filial			[lvl_Linha]
		
		This.tp_estbase_hist.gb_20.text = ' '+lvs_Filial+' ('+String(lvl_Filial)+') '
		Return 0
	Else 
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Selecione um registro para alterar posteriormente visualizar os detalhes!')
		Return 1
	End If
End If
end event

event selectionchanged;If NewIndex = 2 Then
	This.tp_estbase_hist.Event ue_Retrieve()
End If

This.Post Event ue_Set_Focus()
end event

type tp_estbase from userobject within tab_estbase
event create ( )
event destroy ( )
event ue_reset ( )
event ue_retrieve ( )
event ue_set_focus ( )
integer x = 18
integer y = 100
integer width = 3392
integer height = 1472
long backcolor = 79741120
string text = "Posi$$HEX2$$e700e300$$ENDHEX$$o Atual"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
gb_19 gb_19
dw_estoque_base dw_estoque_base
end type

on tp_estbase.create
this.gb_19=create gb_19
this.dw_estoque_base=create dw_estoque_base
this.Control[]={this.gb_19,&
this.dw_estoque_base}
end on

on tp_estbase.destroy
destroy(this.gb_19)
destroy(this.dw_estoque_base)
end on

event ue_reset();This.dw_estoque_base.Event ue_Reset()
end event

event ue_retrieve();This.dw_estoque_base.Event ue_Retrieve()
end event

event ue_set_focus();This.dw_estoque_base.SetFocus()
end event

type gb_19 from groupbox within tp_estbase
integer x = 18
integer y = 8
integer width = 3351
integer height = 1448
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista"
end type

type dw_estoque_base from dc_uo_dw_base within tp_estbase
integer x = 37
integer y = 72
integer width = 3323
integer height = 1360
integer taborder = 40
boolean bringtotop = true
string dataobject = "dw_ge334_lista_estoque_base"
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event constructor;call super::constructor;This.of_SetRowSelection("", "if(not isnull(dh_termino_bloqueio), rgb(255,0,0), rgb(0,0,0))")
end event

event getfocus;call super::getfocus;This.ivo_controle_menu.of_recuperar(True)
This.ivo_controle_menu.Of_atualiza( )
end event

event losefocus;call super::losefocus;This.ivm_menu.mf_salvarcomo(False)
This.ivm_menu.mf_imprimir(False)
end event

event ue_recuperar;//override
Return This.Retrieve(ivl_Produto)
end event

event ue_preretrieve;call super::ue_preretrieve;If IsNull(ivl_Produto) or (Not ivl_Produto > 0) Then Return -1

//Adiciona filtros relat$$HEX1$$f300$$ENDHEX$$rio impresso
This.ivs_filtro_relatorio = {""}
This.ivs_filtro_relatorio[2] = 'Per$$HEX1$$ed00$$ENDHEX$$odo: '+String(ivdh_Inicio,'DD/MM/YYYY')+' $$HEX1$$e000$$ENDHEX$$ '+String(ivdh_Fim,'DD/MM/YYYY')
This.ivs_filtro_relatorio[3] = 'Produto: '+ivo_produto.ivs_descricao_apresentacao_venda+' ('+String(ivl_Produto)+')'

If Not IsNull(ivs_Filiais) and (Trim(ivs_Filiais)<>"") Then
	This.Of_appendwhere("r.cd_filial in ("+ivs_Filiais+")",1)
	This.Of_appendwhere("r.cd_filial in ("+ivs_Filiais+")",2)
	
	If Pos(',',ivs_Filiais) > 0 Then
		This.ivs_filtro_relatorio[4] = 'Filiais: '+ivs_Filiais
	Else	
		This.ivs_filtro_relatorio[4] = 'Filial: '+ivo_Filial.nm_fantasia+' ('+ivs_Filiais+')'		
	End If
End If

Return AncestorReturnValue
end event

event ue_postretrieve;call super::ue_postretrieve;Long lvl_Linha, &
     lvl_Dias_Bloqueio

String lvs_Matricula, &
       lvs_Nome

DateTime lvdh_Termino_Bloqueio, &
         lvdh_Movimentacao

This.SetReDraw(False)
If pl_Linhas > 0 Then	
	For lvl_Linha = 1 To pl_Linhas
		lvdh_Termino_Bloqueio	= This.Object.Dh_Termino_Bloqueio	[lvl_Linha]
		lvdh_Movimentacao		= This.Object.Dh_Movimentacao		[lvl_Linha]	
		
		If Not IsNull(lvdh_Termino_Bloqueio) Then
			lvl_Dias_Bloqueio = DaysAfter(Date(lvdh_Movimentacao), Date(lvdh_Termino_Bloqueio))
		Else
			lvl_Dias_Bloqueio = 0
		End If
		
		This.Object.Qt_Dias_Bloqueio[lvl_Linha] = lvl_Dias_Bloqueio
	Next
	
	This.Event RowFocusChanged(1)
End If

This.SetReDraw(True)

This.ivo_controle_menu.of_salvarcomo(pl_linhas > 0)
This.ivo_controle_menu.of_imprimir(pl_linhas > 0)
This.ivo_controle_menu.Of_atualiza( )

Return AncestorReturnValue
end event

event ue_print;//override
This.Event ue_imprimir_relatorio('Estoque Base por Filial','CL', False)
end event

event ue_printimmediate;//override
This.Event ue_imprimir_relatorio('Estoque Base por Filial','CL', True)
end event

event rowfocuschanged;call super::rowfocuschanged;String lvs_Matricula, &
		 lvs_Nome, &
       lvs_Descricao = ""
		 
DateTime lvdh_Alteracao, &
         lvdh_Termino_Bloqueio, &
			lvdh_Movimentacao

Long lvl_Dias_Bloqueio

If CurrentRow > 0 Then
	lvdh_Alteracao        		= This.Object.Dh_Alteracao				[CurrentRow]
	lvs_Matricula         		= This.Object.Nr_Matricula_Alteracao	[CurrentRow]
	lvs_Nome					= This.Object.Nm_Alteracao			[CurrentRow]	
	lvdh_Termino_Bloqueio	= This.Object.Dh_Termino_Bloqueio	[CurrentRow]	
	lvdh_Movimentacao		= This.Object.Dh_Movimentacao		[CurrentRow]	
	
	If Not IsNull(lvdh_Alteracao) Then
		lvs_Descricao = "* ALTERADO EM '" + String(lvdh_Alteracao, "dd/mm/yyyy hh:mm") + "' POR '" + lvs_Nome + "'"
		
		If Not IsNull(lvdh_Termino_Bloqueio) Then
			lvl_Dias_Bloqueio = DaysAfter(Date(lvdh_Movimentacao), Date(lvdh_Termino_Bloqueio))
			
			If lvl_Dias_Bloqueio = 1 Then
				lvs_Descricao += " - BLOQUEADO POR 1 DIA"
			Else
				lvs_Descricao += " - BLOQUEADO POR " + String(lvl_Dias_Bloqueio) + " DIAS"
			End If
			
			lvs_Descricao += " AT$$HEX1$$c900$$ENDHEX$$ '" + String(lvdh_Termino_Bloqueio, "dd/mm/yyyy") + "'"
		End If
	End If
End If

This.Object.De_Alteracao.Text = lvs_Descricao
end event

type tp_estbase_hist from userobject within tab_estbase
event ue_reset ( )
event ue_set_focus ( )
event ue_retrieve ( )
integer x = 18
integer y = 100
integer width = 3392
integer height = 1472
long backcolor = 79741120
string text = "Hist$$HEX1$$f300$$ENDHEX$$rico"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
gb_20 gb_20
dw_estoque_base_det dw_estoque_base_det
end type

event ue_reset();This.dw_estoque_base_det.Event ue_Reset()

end event

event ue_set_focus();This.dw_estoque_base_det.SetFocus()
end event

event ue_retrieve();This.dw_estoque_base_det.Event ue_Retrieve()
end event

on tp_estbase_hist.create
this.gb_20=create gb_20
this.dw_estoque_base_det=create dw_estoque_base_det
this.Control[]={this.gb_20,&
this.dw_estoque_base_det}
end on

on tp_estbase_hist.destroy
destroy(this.gb_20)
destroy(this.dw_estoque_base_det)
end on

type gb_20 from groupbox within tp_estbase_hist
integer x = 18
integer y = 8
integer width = 3351
integer height = 1452
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista"
end type

type dw_estoque_base_det from dc_uo_dw_base within tp_estbase_hist
integer x = 46
integer y = 76
integer width = 3314
integer height = 1364
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge334_lista_estoque_base_hist"
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.Of_setrowselection( )
end event

event ue_recuperar;//override
Long lvl_Linha
Long lvl_Filial

lvl_Linha = Tab_1.tp_estoque_base.Tab_estbase.tp_estbase.Dw_estoque_base.GetRow()

lvl_Filial = Tab_1.tp_estoque_base.Tab_estbase.tp_estbase.Dw_estoque_base.Object.cd_filial [lvl_Linha]

Return This.Retrieve(lvl_Filial, ivl_produto)
end event

type tp_procurado from userobject within tab_1
event ue_reset ( )
event ue_retrieve ( )
event ue_set_focus ( )
integer x = 18
integer y = 100
integer width = 3442
integer height = 1612
long backcolor = 79741120
string text = "Procurado em Falta"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
tab_procurado tab_procurado
end type

event ue_reset();This.Tab_procurado.Event ue_reset()
end event

event ue_retrieve();This.Tab_procurado.Event ue_Retrieve()
end event

event ue_set_focus();This.Tab_procurado.Event ue_Set_Focus()
end event

on tp_procurado.create
this.tab_procurado=create tab_procurado
this.Control[]={this.tab_procurado}
end on

on tp_procurado.destroy
destroy(this.tab_procurado)
end on

type tab_procurado from tab within tp_procurado
event ue_reset ( )
event ue_retrieve ( )
event ue_set_focus ( )
event create ( )
event destroy ( )
integer x = 5
integer y = 8
integer width = 3429
integer height = 1596
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long backcolor = 79741120
boolean raggedright = true
boolean focusonbuttondown = true
boolean boldselectedtext = true
integer selectedtab = 1
tp_filial_falta tp_filial_falta
tp_filial_falta_det tp_filial_falta_det
end type

event ue_reset();Long lvl_Control

For lvl_Control = 1 To UpperBound(This.Control)
	This.Control[lvl_Control].DYNAMIC Event ue_Reset()
Next
end event

event ue_retrieve();This.SelectTab(1)
This.Control[This.SelectedTab].DYNAMIC Event ue_Retrieve()
end event

event ue_set_focus();This.Control[This.SelectedTab].DYNAMIC Event ue_set_focus()
end event

on tab_procurado.create
this.tp_filial_falta=create tp_filial_falta
this.tp_filial_falta_det=create tp_filial_falta_det
this.Control[]={this.tp_filial_falta,&
this.tp_filial_falta_det}
end on

on tab_procurado.destroy
destroy(this.tp_filial_falta)
destroy(this.tp_filial_falta_det)
end on

event selectionchanging;Long lvl_Linha
Long lvl_Filial
String lvs_Filial

If NewIndex = 2 Then
	lvl_Linha = This.tp_filial_falta.dw_procurado.GetRow()
	If lvl_Linha > 0 Then
		lvs_Filial	= This.tp_filial_falta.dw_procurado.Object.nm_fantasia	[lvl_Linha]
		lvl_Filial	= This.tp_filial_falta.dw_procurado.Object.cd_filial		[lvl_Linha]
		
		This.tp_filial_falta_det.gb_22.text = ' '+lvs_Filial+' ('+String(lvl_Filial)+') '
		Return 0
	Else 
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Selecione uma filial para alterar posteriormente visualizar os detalhes!')
		Return 1
	End If
End If
end event

event selectionchanged;If NewIndex = 2 Then
	This.tp_filial_falta_det.Event ue_Retrieve()
End If

This.Post Event ue_Set_Focus()
end event

type tp_filial_falta from userobject within tab_procurado
event ue_reset ( )
event ue_retrieve ( )
event ue_set_focus ( )
event create ( )
event destroy ( )
integer x = 18
integer y = 100
integer width = 3392
integer height = 1480
long backcolor = 79741120
string text = "Por Filial"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
gb_21 gb_21
dw_procurado dw_procurado
end type

event ue_reset();This.dw_procurado.Event ue_Reset()
end event

event ue_retrieve();This.dw_procurado.Event ue_Retrieve()
end event

event ue_set_focus();This.dw_procurado.SetFocus()
end event

on tp_filial_falta.create
this.gb_21=create gb_21
this.dw_procurado=create dw_procurado
this.Control[]={this.gb_21,&
this.dw_procurado}
end on

on tp_filial_falta.destroy
destroy(this.gb_21)
destroy(this.dw_procurado)
end on

type gb_21 from groupbox within tp_filial_falta
integer x = 18
integer y = 4
integer width = 3342
integer height = 1460
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista"
end type

type dw_procurado from dc_uo_dw_base within tp_filial_falta
integer x = 50
integer y = 80
integer width = 3255
integer height = 1348
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_ge334_lista_produtos_falta"
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event ue_recuperar;//override
Open(w_aguarde)
w_aguarde.Title = 'Recuperando informa$$HEX2$$e700f500$$ENDHEX$$es de produtos procurados em falta...'

Return This.Retrieve(ivdh_Inicio,ivdh_Fim,ivl_Produto)
end event

event constructor;call super::constructor;This.Of_setrowselection( )
end event

event ue_postretrieve;call super::ue_postretrieve;Long lvl_Find
Long lvl_Filial
Long lvl_Qtde
Decimal{2} lvdc_Venda
Decimal{2} lvdc_Falta

This.SetRedraw(False)
This.Post SetRedraw(True)

w_aguarde.Title = 'Atualizando informa$$HEX2$$e700f500$$ENDHEX$$es de vendas do produto no per$$HEX1$$ed00$$ENDHEX$$odo...'

/*Utiliza$$HEX2$$e700e300$$ENDHEX$$o do cursor com SQL fixo*/
DECLARE lcu_venda CURSOR FOR
SELECT	r.cd_filial,
			sum((r.qt_venda - r.qt_devolucao_venda)) as qt_venda,
        		sum((r.qt_venda - r.qt_devolucao_venda) * (pg.vl_preco_venda_atual / pg.vl_fator_conversao)) as vl_venda_bruta
FROM resumo_movto_estq_prd  r (index idx_filial_produto_dt)
INNER JOIN filial f (index pk_filial)
	on f.cd_filial = r.cd_filial
INNER JOIN produto_geral pg (index pk_produto_geral)
	ON r.cd_produto = pg.cd_produto
WHERE r.dh_resumo between :ivdh_Inicio and :ivdh_Fim
	And r.cd_produto = :ivl_Produto
	And r.cd_filial > 0
group by r.cd_filial
order by r.cd_filial;

OPEN lcu_venda;

FETCH lcu_venda INTO :lvl_Filial, :lvl_Qtde, :lvdc_Venda;

Do While SQLCa.SQLCode = 0 
	lvl_Find = This.Find("cd_filial="+String(lvl_Filial),1,This.RowCount())
	
	If lvl_Find > 0 Then
		This.Object.qt_venda	[lvl_Find] = lvl_Qtde
		This.Object.vl_venda	[lvl_Find] = lvdc_Venda
		
		lvdc_Falta = This.Object.vl_falta	[lvl_Find]
		If lvdc_Venda > 0.00 Then
			This.Object.pc_falta	[lvl_Find] = Round((lvdc_Falta / lvdc_Venda) * 100,2)
		End If
	End If
	
	FETCH lcu_venda INTO :lvl_Filial, :lvl_Qtde, :lvdc_Venda;
Loop

Close lcu_venda;

Close(w_aguarde)

This.ivo_controle_menu.of_salvarcomo(pl_linhas > 0)
This.ivo_controle_menu.of_imprimir(pl_linhas > 0)
This.ivo_controle_menu.Of_atualiza( )

Return AncestorReturnValue
end event

event ue_preretrieve;call super::ue_preretrieve;If IsNull(ivl_Produto) or (Not ivl_Produto > 0) Then Return -1

//Adiciona filtros relat$$HEX1$$f300$$ENDHEX$$rio impresso
This.ivs_filtro_relatorio = {""}
This.ivs_filtro_relatorio[2] = 'Per$$HEX1$$ed00$$ENDHEX$$odo: '+String(ivdh_Inicio,'DD/MM/YYYY')+' $$HEX1$$e000$$ENDHEX$$ '+String(ivdh_Fim,'DD/MM/YYYY')
This.ivs_filtro_relatorio[3] = 'Produto: '+ivo_produto.ivs_descricao_apresentacao_venda+' ('+String(ivl_Produto)+')'

If Not IsNull(ivs_Filiais) and (Trim(ivs_Filiais)<>"") Then
	This.Of_appendwhere("ppc.cd_filial in ("+ivs_Filiais+")")
	
	If Pos(',',ivs_Filiais) > 0 Then
		This.ivs_filtro_relatorio[4] = 'Filiais: '+ivs_Filiais
	Else	
		This.ivs_filtro_relatorio[4] = 'Filial: '+ivo_Filial.nm_fantasia+' ('+ivs_Filiais+')'		
	End If
End If

Return AncestorReturnValue
end event

event ue_print;//override
This.Event ue_imprimir_relatorio('Produto Procurado em Falta por Filial','CL', False)
end event

event ue_printimmediate;//override
This.Event ue_imprimir_relatorio('Produto Procurado em Falta por Filial','CL', True)
end event

event losefocus;call super::losefocus;This.ivm_menu.mf_salvarcomo(False)
This.ivm_menu.mf_imprimir(False)
end event

event getfocus;call super::getfocus;This.ivo_controle_menu.of_recuperar(True)
This.ivo_controle_menu.Of_atualiza( )
end event

type tp_filial_falta_det from userobject within tab_procurado
event ue_retrieve ( )
event ue_reset ( )
event ue_set_focus ( )
integer x = 18
integer y = 100
integer width = 3392
integer height = 1480
long backcolor = 79741120
string text = "Detalhes"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
gb_22 gb_22
dw_procurado_det dw_procurado_det
end type

event ue_retrieve();This.dw_procurado_det.Event ue_retrieve()
end event

event ue_reset();This.dw_procurado_det.Event ue_Reset()
end event

event ue_set_focus();This.dw_procurado_det.SetFocus()
end event

on tp_filial_falta_det.create
this.gb_22=create gb_22
this.dw_procurado_det=create dw_procurado_det
this.Control[]={this.gb_22,&
this.dw_procurado_det}
end on

on tp_filial_falta_det.destroy
destroy(this.gb_22)
destroy(this.dw_procurado_det)
end on

type gb_22 from groupbox within tp_filial_falta_det
integer x = 9
integer y = 16
integer width = 3360
integer height = 1448
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista"
end type

type dw_procurado_det from dc_uo_dw_base within tp_filial_falta_det
integer x = 41
integer y = 92
integer width = 3305
integer height = 1336
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge334_lista_produtos_falta_det"
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event constructor;call super::constructor;This.Of_setrowselection( )
end event

event ue_recuperar;//override
Long lvl_Linha
Long lvl_Filial

lvl_Linha = Tab_1.tp_procurado.tab_procurado.tp_filial_falta.dw_procurado.GetRow()

lvl_Filial = Tab_1.tp_procurado.tab_procurado.tp_filial_falta.dw_procurado.Object.cd_filial [lvl_Linha]

Return This.Retrieve(ivdh_Inicio, ivdh_fim, ivl_produto, lvl_Filial)
end event

event ue_print;//override
This.Event ue_imprimir_relatorio('Produto em Falta na Filial','CL', False)
end event

event ue_printimmediate;//override
This.Event ue_imprimir_relatorio('Produto em Falta na Filial','CL', True)
end event

event losefocus;call super::losefocus;This.ivm_menu.mf_salvarcomo(False)
This.ivm_menu.mf_imprimir(False)
end event

event getfocus;call super::getfocus;This.ivo_controle_menu.of_recuperar(True)
This.ivo_controle_menu.Of_atualiza( )
end event

event ue_postretrieve;call super::ue_postretrieve;This.ivo_controle_menu.of_salvarcomo(pl_linhas > 0)
This.ivo_controle_menu.of_imprimir(pl_linhas > 0)
This.ivo_controle_menu.Of_atualiza( )

Return AncestorReturnValue
end event

event ue_preretrieve;call super::ue_preretrieve;//Adiciona filtros relat$$HEX1$$f300$$ENDHEX$$rio impresso
This.ivs_filtro_relatorio = {""}
This.ivs_filtro_relatorio[2] = 'Per$$HEX1$$ed00$$ENDHEX$$odo: '+String(ivdh_Inicio,'DD/MM/YYYY')+' $$HEX1$$e000$$ENDHEX$$ '+String(ivdh_Fim,'DD/MM/YYYY')
This.ivs_filtro_relatorio[3] = 'Produto: '+ivo_produto.ivs_descricao_apresentacao_venda+' ('+String(ivl_Produto)+')'
This.ivs_filtro_relatorio[4] = 'Filial: '+Parent.gb_22.Text

Return AncestorReturnValue
end event

type tp_saldo from userobject within tab_1
event ue_retrieve ( )
event ue_reset ( )
event ue_set_focus ( )
integer x = 18
integer y = 100
integer width = 3442
integer height = 1612
long backcolor = 79741120
string text = "Saldo"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
gb_3 gb_3
dw_saldo dw_saldo
end type

event ue_retrieve();This.dw_saldo.Event ue_Retrieve()
end event

event ue_reset();This.dw_saldo.Event ue_Reset()
end event

event ue_set_focus();This.dw_saldo.SetFocus()
end event

on tp_saldo.create
this.gb_3=create gb_3
this.dw_saldo=create dw_saldo
this.Control[]={this.gb_3,&
this.dw_saldo}
end on

on tp_saldo.destroy
destroy(this.gb_3)
destroy(this.dw_saldo)
end on

type gb_3 from groupbox within tp_saldo
integer x = 18
integer y = 12
integer width = 3401
integer height = 1584
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista"
end type

type dw_saldo from dc_uo_dw_base within tp_saldo
integer x = 37
integer y = 76
integer width = 3374
integer height = 1496
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge334_lista_saldo_filial"
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event ue_recuperar;//override
Return This.Retrieve(ivdh_Inicio, ivdh_Fim, ivl_Produto)
end event

event ue_postretrieve;call super::ue_postretrieve;Date lvdt_Saldo
Date lvdt_Mes_Inicio

Decimal{2} lvdc_Custo_Inicial
Decimal{2} lvdc_Custo_Parcial
Decimal{2} lvdc_Custo_Final
Decimal{2} lvdc_Custo_Entrada
Decimal{2} lvdc_Custo_Saida

Long lvl_Qtde_Inicial
Long lvl_Qtde_Parcial
Long lvl_Qtde_Final
Long lvl_Qtde_Entrada
Long lvl_Qtde_Saida
Long lvl_Filial
Long lvl_Find
Long lvl_Linha

String lvs_Filial
String lvs_SQL

lvdt_Mes_Inicio = Date(String(ivdh_Inicio,'YYYY/MM')+'/01')
lvdt_Saldo = gf_primeiro_dia_mes(RelativeDate(lvdt_Mes_Inicio,-1))

Open(w_aguarde)
This.SetRedraw(False)
This.Post SetRedraw(True)

w_aguarde.Title = 'Recuperando informa$$HEX2$$e700f500$$ENDHEX$$es de saldo inicial...'
// Declara$$HEX2$$e700e300$$ENDHEX$$o do Cursor
lvs_SQL = "select s.cd_filial, f.nm_fantasia, sum(s.qt_saldo_final), sum(s.qt_saldo_final * s.vl_custo_medio) " + &
				"From saldo_produto s " + &
				"Inner Join filial f " + &
				"	on f.cd_filial = s.cd_filial " + &
				"Where s.dh_saldo = '"+String(lvdt_Saldo,'YYYY/MM/DD')+"'" + &
				"	And s.cd_produto = "+String(ivl_Produto) + &
				"	And s.qt_saldo_final > 0 "
lvs_SQL += IIF((Not IsNull(ivs_Filiais))and(ivs_Filiais<>'')," and s.cd_filial in ("+ivs_Filiais+")","")
lvs_SQL += "Group by s.cd_filial, f.nm_fantasia"

PREPARE SQLSA FROM :lvs_SQL ;
DESCRIBE SQLSA INTO SQLDA ;
DECLARE lcu_saldo DYNAMIC CURSOR FOR SQLSA ;
OPEN DYNAMIC lcu_saldo USING DESCRIPTOR SQLDA ;

// Buscar a primeira linha do resultado
FETCH lcu_saldo INTO :lvl_Filial, :lvs_Filial, :lvl_Qtde_Inicial, :lvdc_Custo_Inicial;

// Repetir Enquanto Houver Linhas
DO WHILE SQLCA.sqlcode = 0
	lvl_Find = This.Find('cd_filial='+String(lvl_Filial),1,This.RowCount())
	
	If lvl_Find > 0 Then
		This.Object.qt_inicial	[lvl_Find] = lvl_Qtde_Inicial
		This.Object.vl_inicial	[lvl_Find] = lvdc_Custo_Inicial
	Else
		lvl_Find = This.InsertRow(0)
		This.Object.cd_filial		[lvl_Find] = lvl_Filial
		This.Object.nm_fantasia	[lvl_Find] = lvs_Filial
		This.Object.qt_inicial		[lvl_Find] = lvl_Qtde_Inicial
		This.Object.vl_inicial		[lvl_Find] = lvdc_Custo_Inicial
	End If
	
	FETCH lcu_saldo INTO :lvl_Filial, :lvs_Filial, :lvl_Qtde_Inicial, :lvdc_Custo_Inicial;
Loop

Close lcu_saldo;

If Date(ivdh_Inicio)>lvdt_Mes_Inicio Then
	lvs_SQL = 	"select 	me.cd_filial_movimento as cd_filial, " + &
								" f.nm_fantasia, "+ &
								" sum(case when tm.id_entrada_saida = 'S' then -1 else 1 end * case when tm.id_cancelamento = 'S' then -1 else 1 end * me.qt_movimento) as qt_movimento, " + &
								" sum(case when tm.id_entrada_saida = 'S' then -1 else 1 end * case when tm.id_cancelamento = 'S' then -1 else 1 end * (me.qt_movimento * me.vl_custo_unitario)) as vl_movimento " + &
					" from movimento_estoque me " + &
					" inner join tipo_movimento_estoque tm " + &
					"	on tm.cd_tipo_movimento = me.cd_tipo_movimento " + &
					" inner join filial f "+ &
					" 	on f.cd_filial = me.cd_filial_movimento " + &
					" where me.cd_produto = "+String(ivl_Produto) + &
					" and me.dh_movimento >= '"+String(lvdt_Mes_Inicio,'YYYY/MM/DD')+"'" + &
					" and me.dh_movimento < '"+String(ivdh_Inicio,'YYYY/MM/DD')+"'" 
	lvs_SQL += 	IIF((Not IsNull(ivs_Filiais))and(ivs_Filiais<>'')," and me.cd_filial_movimento in ("+ivs_Filiais+")"," and me.cd_filial_movimento > 0")
	lvs_SQL += 	" Group by me.cd_filial_movimento, f.nm_fantasia"
	
	PREPARE SQLSA FROM :lvs_SQL ;
	DESCRIBE SQLSA INTO SQLDA ;
	DECLARE lcu_diferenca DYNAMIC CURSOR FOR SQLSA ;
	OPEN DYNAMIC lcu_diferenca USING DESCRIPTOR SQLDA ;
	
	// Buscar a primeira linha do resultado
	FETCH lcu_diferenca INTO :lvl_Filial, :lvs_Filial, :lvl_Qtde_Parcial, :lvdc_Custo_Parcial;
	
	// Repetir Enquanto Houver Linhas
	DO WHILE SQLCA.sqlcode = 0
		lvl_Find = This.Find('cd_filial='+String(lvl_Filial),1,This.RowCount())
		
		If lvl_Find > 0 Then
			lvl_Qtde_Inicial		= This.Object.qt_inicial	[lvl_Find]
			lvdc_Custo_Inicial	= This.Object.vl_inicial	[lvl_Find]
			
			This.Object.qt_inicial	[lvl_Find] = lvl_Qtde_Inicial + lvl_Qtde_Parcial
			This.Object.vl_inicial	[lvl_Find] = lvdc_Custo_Inicial + lvdc_Custo_Parcial
		Else
			lvl_Find = This.InsertRow(0)
			This.Object.cd_filial		[lvl_Find] = lvl_Filial
			This.Object.nm_fantasia	[lvl_Find] = lvs_Filial
			This.Object.qt_inicial		[lvl_Find] = lvl_Qtde_Parcial
			This.Object.vl_inicial		[lvl_Find] = lvdc_Custo_Parcial
		End If
		
		FETCH lcu_diferenca INTO :lvl_Filial, :lvs_Filial, :lvl_Qtde_Parcial, :lvdc_Custo_Parcial;
	Loop
	
	Close lcu_diferenca;
End If

For lvl_Linha = 1 To This.RowCount()
	lvl_Qtde_Inicial		= This.Object.qt_inicial	[lvl_Linha]
	lvl_Qtde_Entrada	= This.Object.qt_entrada[lvl_Linha]
	lvl_Qtde_Saida		= This.Object.qt_saida	[lvl_Linha]
	
	This.Object.qt_final	[lvl_Linha] = lvl_Qtde_Inicial + lvl_Qtde_Entrada - lvl_Qtde_Saida
	
	lvdc_Custo_Inicial		= This.Object.vl_inicial	[lvl_Linha]
	lvdc_Custo_Entrada	= This.Object.vl_entrada	[lvl_Linha]
	lvdc_Custo_Saida		= This.Object.vl_saida	[lvl_Linha]
	
	This.Object.vl_final	[lvl_Linha] = lvdc_Custo_Inicial + lvdc_Custo_Entrada - lvdc_Custo_Saida
Next

This.Sort()

Close(w_aguarde)

This.ivo_controle_menu.of_salvarcomo(pl_linhas > 0)
This.ivo_controle_menu.of_imprimir(pl_linhas > 0)
This.ivo_controle_menu.Of_atualiza( )

Return This.RowCount()
end event

event constructor;call super::constructor;This.Of_Setrowselection( )
end event

event ue_preretrieve;call super::ue_preretrieve;If IsNull(ivl_Produto) or (Not ivl_Produto > 0) Then Return -1

//Adiciona filtros relat$$HEX1$$f300$$ENDHEX$$rio impresso
This.ivs_filtro_relatorio = {""}
This.ivs_filtro_relatorio[2] = 'Per$$HEX1$$ed00$$ENDHEX$$odo: '+String(ivdh_Inicio,'DD/MM/YYYY')+' $$HEX1$$e000$$ENDHEX$$ '+String(ivdh_Fim,'DD/MM/YYYY')
This.ivs_filtro_relatorio[3] = 'Produto: '+ivo_produto.ivs_descricao_apresentacao_venda+' ('+String(ivl_Produto)+')'

If Not IsNull(ivs_Filiais) and (Trim(ivs_Filiais)<>"") Then
	This.Of_appendwhere("me.cd_filial_movimento in ("+ivs_Filiais+")")
	
	If Pos(',',ivs_Filiais) > 0 Then
		This.ivs_filtro_relatorio[4] = 'Filiais: '+ivs_Filiais
	Else	
		This.ivs_filtro_relatorio[4] = 'Filial: '+ivo_Filial.nm_fantasia+' ('+ivs_Filiais+')'		
	End If
Else
	This.Of_appendwhere("me.cd_filial_movimento > 0")
End If

Return AncestorReturnValue
end event

event getfocus;call super::getfocus;This.ivo_controle_menu.of_recuperar(True)
This.ivo_controle_menu.Of_atualiza( )
end event

event losefocus;call super::losefocus;This.ivm_menu.mf_salvarcomo(False)
This.ivm_menu.mf_imprimir(False)
end event

event ue_printimmediate;//override
This.Event ue_imprimir_relatorio('Saldo Produto por Filial','CL', True)
end event

event ue_print;//override
This.Event ue_imprimir_relatorio('Saldo Produto por Filial','CL', False)
end event

type gb_1 from groupbox within w_ge334_rel_analise_produto
integer x = 32
integer y = 12
integer width = 2821
integer height = 348
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
end type

type dw_1 from dc_uo_dw_base within w_ge334_rel_analise_produto
integer x = 69
integer y = 80
integer width = 2766
integer height = 256
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge334_selecao"
end type

event ue_key;call super::ue_key;If Key = KeyEnter! Then
	Choose Case This.GetColumnName() 
		Case "de_produto"
			ivo_Produto.of_Localiza_Produto(This.GetText())
			
			If ivo_Produto.Localizado Then
				 This.Object.Cd_Produto[1] = ivo_Produto.Cd_Produto
				 This.Object.De_Produto[1] = ivo_produto.ivs_descricao_apresentacao_estoque
			Else 
				ivo_Produto.of_Inicializa()
			End If
			
		Case "nm_filial"
			ivo_filial.of_Localiza_filial(This.GetText())
			
			If ivo_filial.Localizada Then
				 This.Object.cd_filial	[1] = ivo_filial.Cd_Filial
				 This.Object.nm_filial	[1] = ivo_filial.nm_fantasia
			Else 
				ivo_filial.of_Inicializa()
			End If
	End Choose
End If
end event

event itemchanged;call super::itemchanged;Long lvl_Lojas

Choose Case dwo.name
	Case "de_produto"
		If Trim(Data) <> "" Then
			If Data <> ivo_produto.ivs_descricao_apresentacao_estoque Then
				Return 1
			End If	
		Else			
			ivo_produto.Of_inicializa( )
			ivl_Produto = ivo_produto.Cd_produto
			
			This.Object.cd_produto	[1] = ivo_produto.Cd_produto
			This.Object.de_produto	[1] = ivo_produto.ivs_descricao_apresentacao_estoque		
		End If
	Case "nm_filial"
		If Trim(Data) <> "" Then
			If Data <> ivo_Filial.nm_Fantasia Then
				Return 1
			End If	
		Else			
			ivo_Filial.Of_inicializa( )
			
			This.Object.Cd_Filial	[1] = ivo_Filial.Cd_Filial
			This.Object.Nm_Filial	[1] = ivo_Filial.Nm_Fantasia			
		End If
		
	Case "id_filial"
		ivs_filiais = "" 
		If Data = 'C' Then
					
			OpenWithParm(w_ge216_selecao_filiais, ivo_filiais)
			
			lvl_Lojas = Message.DoubleParm
			
			If lvl_Lojas > 0 Then
				ivs_filiais = ivo_filiais.ivs_filiais
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma filial foi selecionada.")
				Data = "T"
				dw_1.Object.id_filial [Row] = Data
			End If
			
		End If
End Choose

Tab_1.Event ue_Reset()
end event

event losefocus;call super::losefocus;If IsValid(ivo_produto) then
	If ivo_produto.Localizado Then
		This.Object.De_Produto[1] = ivo_produto.ivs_descricao_apresentacao_estoque
	End If
End If

If IsValid(ivo_Filial) then
	If ivo_Filial.Localizada Then
		This.Object.nm_filial	[1] = ivo_filial.nm_fantasia
	End If
End If
end event

event editchanged;call super::editchanged;Tab_1.Post Event ue_Reset()
end event

