HA$PBExportHeader$w_ge554_rel_analise_compras.srw
forward
global type w_ge554_rel_analise_compras from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge554_rel_analise_compras from dc_w_selecao_lista_relatorio
integer width = 4457
integer height = 1368
string title = "GE554 - An$$HEX1$$e100$$ENDHEX$$lise Fiscal de Compras"
end type
global w_ge554_rel_analise_compras w_ge554_rel_analise_compras

type variables
dc_uo_transacao ivtr_trans
end variables

on w_ge554_rel_analise_compras.create
call super::create
end on

on w_ge554_rel_analise_compras.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;Datetime lvdh_Parametro

gf_data_parametro(lvdh_Parametro)

dw_1.Object.dt_inicio	[1] = gf_primeiro_dia_mes(RelativeDate(gf_primeiro_dia_mes(Date(lvdh_Parametro)),-1))
dw_1.Object.dt_fim	[1] = RelativeDate(gf_primeiro_dia_mes(Date(lvdh_Parametro)),-1)

This.ivm_menu.ivb_permite_imprimir = True

ivtr_trans = Create dc_uo_transacao
ivtr_trans.ivs_database = 'SYBASE'
ivtr_trans.of_connect(gvo_aplicacao.ivs_datasource,'',False)
ivtr_trans.AutoCommit = True

ivb_permite_fechar = False
end event

event ue_preopen;call super::ue_preopen;Maxheight = 9999
MaxWidth = 8150
end event

event close;call super::close;ivtr_trans.Of_disconnect( )
Destroy(ivtr_trans)
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge554_rel_analise_compras
integer x = 82
integer y = 1500
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge554_rel_analise_compras
integer x = 46
integer y = 1428
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge554_rel_analise_compras
integer y = 220
integer width = 4338
integer height = 940
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge554_rel_analise_compras
integer width = 1161
integer height = 188
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge554_rel_analise_compras
integer width = 1106
integer height = 92
string dataobject = "dw_ge554_selecao"
end type

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge554_rel_analise_compras
integer y = 296
integer width = 4270
integer height = 832
string dataobject = "dw_ge554_lista"
boolean ivb_ordena_colunas = true
end type

event dw_2::constructor;call super::constructor;This.ShareData( dw_3)
end event

event dw_2::ue_reset;call super::ue_reset;This.ivm_menu.mf_SalvarComo(False)
end event

event dw_2::ue_retrieve;//override
Datetime lvdh_Inicio
Datetime lvdh_Fim

dw_2.SetTrans(ivtr_trans)
dw_2.SetTransObject(ivtr_trans)

dw_1.AcceptText( )
lvdh_Inicio	= dw_1.Object.dt_inicio	[1]
lvdh_Fim		= dw_1.Object.dt_fim		[1]

Open(w_aguarde)
w_aguarde.Title = 'Aguarde...'
This.Retrieve(lvdh_Inicio,lvdh_Fim)
Close(w_aguarde)

This.ivm_menu.mf_SalvarComo(This.RowCount() > 0)
This.ivm_menu.mf_Imprimir(This.RowCount() > 0)

Return This.RowCount()
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge554_rel_analise_compras
integer x = 1339
integer y = 24
integer height = 160
string dataobject = "dw_ge554_relatorio"
end type

