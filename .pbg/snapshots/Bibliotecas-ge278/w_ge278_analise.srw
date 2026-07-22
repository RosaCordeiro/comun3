HA$PBExportHeader$w_ge278_analise.srw
forward
global type w_ge278_analise from dc_w_sheet
end type
type tab_1 from tab within w_ge278_analise
end type
type tp_inicial from userobject within tab_1
end type
type spd_ini_perdas_caixa from uo_grafico_menor within tp_inicial
end type
type spd_ini_dev_compra from uo_grafico_menor within tp_inicial
end type
type spd_ini_ajuste_estoque from uo_grafico_menor within tp_inicial
end type
type spd_ini_desc from uo_grafico_menor within tp_inicial
end type
type spd_ini_dev_venda from uo_grafico_menor within tp_inicial
end type
type spd_ini_canc from uo_grafico_menor within tp_inicial
end type
type tp_inicial from userobject within tab_1
spd_ini_perdas_caixa spd_ini_perdas_caixa
spd_ini_dev_compra spd_ini_dev_compra
spd_ini_ajuste_estoque spd_ini_ajuste_estoque
spd_ini_desc spd_ini_desc
spd_ini_dev_venda spd_ini_dev_venda
spd_ini_canc spd_ini_canc
end type
type tp_canc_venda from userobject within tab_1
end type
type tab_canc_venda from tab within tp_canc_venda
end type
type tp_geral_cav from userobject within tab_canc_venda
end type
type cb_mostra_canc from dropdownlistbox within tp_geral_cav
end type
type dw_canc_venda_regional_perc from dc_uo_dw_base within tp_geral_cav
end type
type spd_cancvenda from uo_grafico_menor within tp_geral_cav
end type
type st_24 from statictext within tp_geral_cav
end type
type st_23 from statictext within tp_geral_cav
end type
type st_22 from statictext within tp_geral_cav
end type
type st_21 from statictext within tp_geral_cav
end type
type st_20 from statictext within tp_geral_cav
end type
type st_19 from statictext within tp_geral_cav
end type
type ln_4 from line within tp_geral_cav
end type
type cb_tipo_canc from dropdownlistbox within tp_geral_cav
end type
type dw_canc_venda_regional from dc_uo_dw_base within tp_geral_cav
end type
type gb_2 from groupbox within tp_geral_cav
end type
type tp_geral_cav from userobject within tab_canc_venda
cb_mostra_canc cb_mostra_canc
dw_canc_venda_regional_perc dw_canc_venda_regional_perc
spd_cancvenda spd_cancvenda
st_24 st_24
st_23 st_23
st_22 st_22
st_21 st_21
st_20 st_20
st_19 st_19
ln_4 ln_4
cb_tipo_canc cb_tipo_canc
dw_canc_venda_regional dw_canc_venda_regional
gb_2 gb_2
end type
type tp_top_filial_cancela from userobject within tab_canc_venda
end type
type dw_top_filial_cancela_qtde from dc_uo_dw_base within tp_top_filial_cancela
end type
type dw_top_filial_cancela from dc_uo_dw_base within tp_top_filial_cancela
end type
type tp_top_filial_cancela from userobject within tab_canc_venda
dw_top_filial_cancela_qtde dw_top_filial_cancela_qtde
dw_top_filial_cancela dw_top_filial_cancela
end type
type tp_revisao_cancvenda from userobject within tab_canc_venda
end type
type dw_revisao_cancvenda from dc_uo_dw_base within tp_revisao_cancvenda
end type
type gb_10 from groupbox within tp_revisao_cancvenda
end type
type tp_revisao_cancvenda from userobject within tab_canc_venda
dw_revisao_cancvenda dw_revisao_cancvenda
gb_10 gb_10
end type
type tab_canc_venda from tab within tp_canc_venda
tp_geral_cav tp_geral_cav
tp_top_filial_cancela tp_top_filial_cancela
tp_revisao_cancvenda tp_revisao_cancvenda
end type
type cb_detalhe_cve from commandbutton within tp_canc_venda
end type
type tp_canc_venda from userobject within tab_1
tab_canc_venda tab_canc_venda
cb_detalhe_cve cb_detalhe_cve
end type
type tp_dev_venda from userobject within tab_1
end type
type tab_dev_venda from tab within tp_dev_venda
end type
type tp_geral_dvv from userobject within tab_dev_venda
end type
type cb_mostra_devvenda from dropdownlistbox within tp_geral_dvv
end type
type cb_tipo_devenda from dropdownlistbox within tp_geral_dvv
end type
type st_18 from statictext within tp_geral_dvv
end type
type st_17 from statictext within tp_geral_dvv
end type
type st_16 from statictext within tp_geral_dvv
end type
type st_15 from statictext within tp_geral_dvv
end type
type st_14 from statictext within tp_geral_dvv
end type
type st_13 from statictext within tp_geral_dvv
end type
type spd_dev_venda from uo_grafico_menor within tp_geral_dvv
end type
type dw_dev_venda_regional from dc_uo_dw_base within tp_geral_dvv
end type
type gb_4 from groupbox within tp_geral_dvv
end type
type ln_3 from line within tp_geral_dvv
end type
type tp_geral_dvv from userobject within tab_dev_venda
cb_mostra_devvenda cb_mostra_devvenda
cb_tipo_devenda cb_tipo_devenda
st_18 st_18
st_17 st_17
st_16 st_16
st_15 st_15
st_14 st_14
st_13 st_13
spd_dev_venda spd_dev_venda
dw_dev_venda_regional dw_dev_venda_regional
gb_4 gb_4
ln_3 ln_3
end type
type tp_top_filiais_devv from userobject within tab_dev_venda
end type
type dw_top_filiais_devv from dc_uo_dw_base within tp_top_filiais_devv
end type
type tp_top_filiais_devv from userobject within tab_dev_venda
dw_top_filiais_devv dw_top_filiais_devv
end type
type tp_revisao_devvenda from userobject within tab_dev_venda
end type
type dw_revisao_devvenda from dc_uo_dw_base within tp_revisao_devvenda
end type
type gb_11 from groupbox within tp_revisao_devvenda
end type
type tp_revisao_devvenda from userobject within tab_dev_venda
dw_revisao_devvenda dw_revisao_devvenda
gb_11 gb_11
end type
type tab_dev_venda from tab within tp_dev_venda
tp_geral_dvv tp_geral_dvv
tp_top_filiais_devv tp_top_filiais_devv
tp_revisao_devvenda tp_revisao_devvenda
end type
type cb_2 from commandbutton within tp_dev_venda
end type
type tp_dev_venda from userobject within tab_1
tab_dev_venda tab_dev_venda
cb_2 cb_2
end type
type tp_desc_venda from userobject within tab_1
end type
type tab_desc_venda from tab within tp_desc_venda
end type
type tp_geral_dsv from userobject within tab_desc_venda
end type
type dw_desc_venda_regional_perc from dc_uo_dw_base within tp_geral_dsv
end type
type cb_tipo_descvenda from dropdownlistbox within tp_geral_dsv
end type
type cb_mostra_descvenda from dropdownlistbox within tp_geral_dsv
end type
type st_6 from statictext within tp_geral_dsv
end type
type st_4 from statictext within tp_geral_dsv
end type
type st_5 from statictext within tp_geral_dsv
end type
type st_10 from statictext within tp_geral_dsv
end type
type st_11 from statictext within tp_geral_dsv
end type
type st_12 from statictext within tp_geral_dsv
end type
type dw_desc_venda_regional from dc_uo_dw_base within tp_geral_dsv
end type
type spd_desc_venda from uo_grafico_menor within tp_geral_dsv
end type
type gb_3 from groupbox within tp_geral_dsv
end type
type ln_2 from line within tp_geral_dsv
end type
type tp_geral_dsv from userobject within tab_desc_venda
dw_desc_venda_regional_perc dw_desc_venda_regional_perc
cb_tipo_descvenda cb_tipo_descvenda
cb_mostra_descvenda cb_mostra_descvenda
st_6 st_6
st_4 st_4
st_5 st_5
st_10 st_10
st_11 st_11
st_12 st_12
dw_desc_venda_regional dw_desc_venda_regional
spd_desc_venda spd_desc_venda
gb_3 gb_3
ln_2 ln_2
end type
type tp_top_desc_filiais from userobject within tab_desc_venda
end type
type dw_top_filial_desconto_qtde from dc_uo_dw_base within tp_top_desc_filiais
end type
type dw_top_filial_desconto from dc_uo_dw_base within tp_top_desc_filiais
end type
type tp_top_desc_filiais from userobject within tab_desc_venda
dw_top_filial_desconto_qtde dw_top_filial_desconto_qtde
dw_top_filial_desconto dw_top_filial_desconto
end type
type tp_top_desc from userobject within tab_desc_venda
end type
type dw_top20_desconto from dc_uo_dw_base within tp_top_desc
end type
type gb_8 from groupbox within tp_top_desc
end type
type tp_top_desc from userobject within tab_desc_venda
dw_top20_desconto dw_top20_desconto
gb_8 gb_8
end type
type tp_revisao_descvenda from userobject within tab_desc_venda
end type
type dw_revisao_descvenda from dc_uo_dw_base within tp_revisao_descvenda
end type
type gb_9 from groupbox within tp_revisao_descvenda
end type
type tp_revisao_descvenda from userobject within tab_desc_venda
dw_revisao_descvenda dw_revisao_descvenda
gb_9 gb_9
end type
type tab_desc_venda from tab within tp_desc_venda
tp_geral_dsv tp_geral_dsv
tp_top_desc_filiais tp_top_desc_filiais
tp_top_desc tp_top_desc
tp_revisao_descvenda tp_revisao_descvenda
end type
type cb_detalha_desc from commandbutton within tp_desc_venda
end type
type tp_desc_venda from userobject within tab_1
tab_desc_venda tab_desc_venda
cb_detalha_desc cb_detalha_desc
end type
type tp_dev_compra from userobject within tab_1
end type
type tab_dev_compra from tab within tp_dev_compra
end type
type tp_geral_dcp from userobject within tab_dev_compra
end type
type cb_tipo_devcompra from dropdownlistbox within tp_geral_dcp
end type
type cb_mostra_devcompra from dropdownlistbox within tp_geral_dcp
end type
type dw_dev_compra_regional from dc_uo_dw_base within tp_geral_dcp
end type
type sped_dev_compra from uo_grafico_menor within tp_geral_dcp
end type
type st_2 from statictext within tp_geral_dcp
end type
type st_1 from statictext within tp_geral_dcp
end type
type st_3 from statictext within tp_geral_dcp
end type
type st_7 from statictext within tp_geral_dcp
end type
type st_9 from statictext within tp_geral_dcp
end type
type st_8 from statictext within tp_geral_dcp
end type
type gb_5 from groupbox within tp_geral_dcp
end type
type ln_1 from line within tp_geral_dcp
end type
type tp_geral_dcp from userobject within tab_dev_compra
cb_tipo_devcompra cb_tipo_devcompra
cb_mostra_devcompra cb_mostra_devcompra
dw_dev_compra_regional dw_dev_compra_regional
sped_dev_compra sped_dev_compra
st_2 st_2
st_1 st_1
st_3 st_3
st_7 st_7
st_9 st_9
st_8 st_8
gb_5 gb_5
ln_1 ln_1
end type
type tp_top_filial_dev_compra from userobject within tab_dev_compra
end type
type dw_top_filiais_dev_compra from dc_uo_dw_base within tp_top_filial_dev_compra
end type
type tp_top_filial_dev_compra from userobject within tab_dev_compra
dw_top_filiais_dev_compra dw_top_filiais_dev_compra
end type
type tp_top_forn_devolucao from userobject within tab_dev_compra
end type
type dw_top_forn_devolucao from dc_uo_dw_base within tp_top_forn_devolucao
end type
type tp_top_forn_devolucao from userobject within tab_dev_compra
dw_top_forn_devolucao dw_top_forn_devolucao
end type
type tp_revisao_devcompra from userobject within tab_dev_compra
end type
type dw_revisao_devcompra from dc_uo_dw_base within tp_revisao_devcompra
end type
type gb_12 from groupbox within tp_revisao_devcompra
end type
type tp_revisao_devcompra from userobject within tab_dev_compra
dw_revisao_devcompra dw_revisao_devcompra
gb_12 gb_12
end type
type tab_dev_compra from tab within tp_dev_compra
tp_geral_dcp tp_geral_dcp
tp_top_filial_dev_compra tp_top_filial_dev_compra
tp_top_forn_devolucao tp_top_forn_devolucao
tp_revisao_devcompra tp_revisao_devcompra
end type
type cb_3 from commandbutton within tp_dev_compra
end type
type tp_dev_compra from userobject within tab_1
tab_dev_compra tab_dev_compra
cb_3 cb_3
end type
type tp_ajuste_estoque from userobject within tab_1
end type
type tab_ajuste_estoque from tab within tp_ajuste_estoque
end type
type tp_geral_aje from userobject within tab_ajuste_estoque
end type
type cb_tipo_aje from dropdownlistbox within tp_geral_aje
end type
type cb_mostra_aje from dropdownlistbox within tp_geral_aje
end type
type st_37 from statictext within tp_geral_aje
end type
type dw_ajuste_estoque_regional from dc_uo_dw_base within tp_geral_aje
end type
type spd_ajuste_estoque from uo_grafico_menor within tp_geral_aje
end type
type st_36 from statictext within tp_geral_aje
end type
type st_31 from statictext within tp_geral_aje
end type
type st_32 from statictext within tp_geral_aje
end type
type st_33 from statictext within tp_geral_aje
end type
type st_34 from statictext within tp_geral_aje
end type
type st_35 from statictext within tp_geral_aje
end type
type gb_6 from groupbox within tp_geral_aje
end type
type ln_6 from line within tp_geral_aje
end type
type tp_geral_aje from userobject within tab_ajuste_estoque
cb_tipo_aje cb_tipo_aje
cb_mostra_aje cb_mostra_aje
st_37 st_37
dw_ajuste_estoque_regional dw_ajuste_estoque_regional
spd_ajuste_estoque spd_ajuste_estoque
st_36 st_36
st_31 st_31
st_32 st_32
st_33 st_33
st_34 st_34
st_35 st_35
gb_6 gb_6
ln_6 ln_6
end type
type tp_top_filiais_aje from userobject within tab_ajuste_estoque
end type
type dw_top_filiais_aje from dc_uo_dw_base within tp_top_filiais_aje
end type
type tp_top_filiais_aje from userobject within tab_ajuste_estoque
dw_top_filiais_aje dw_top_filiais_aje
end type
type tp_top_motivo_aje from userobject within tab_ajuste_estoque
end type
type dw_top_motivo_aje from dc_uo_dw_base within tp_top_motivo_aje
end type
type tp_top_motivo_aje from userobject within tab_ajuste_estoque
dw_top_motivo_aje dw_top_motivo_aje
end type
type tp_revisao_ajuest from userobject within tab_ajuste_estoque
end type
type dw_revisao_ajuste from dc_uo_dw_base within tp_revisao_ajuest
end type
type gb_13 from groupbox within tp_revisao_ajuest
end type
type tp_revisao_ajuest from userobject within tab_ajuste_estoque
dw_revisao_ajuste dw_revisao_ajuste
gb_13 gb_13
end type
type tab_ajuste_estoque from tab within tp_ajuste_estoque
tp_geral_aje tp_geral_aje
tp_top_filiais_aje tp_top_filiais_aje
tp_top_motivo_aje tp_top_motivo_aje
tp_revisao_ajuest tp_revisao_ajuest
end type
type cb_detalhes_aje from commandbutton within tp_ajuste_estoque
end type
type tp_ajuste_estoque from userobject within tab_1
tab_ajuste_estoque tab_ajuste_estoque
cb_detalhes_aje cb_detalhes_aje
end type
type tp_sobras_perdas from userobject within tab_1
end type
type tab_sobras from tab within tp_sobras_perdas
end type
type tp_sobras_geral from userobject within tab_sobras
end type
type st_38 from statictext within tp_sobras_geral
end type
type cb_tipo_fcx from dropdownlistbox within tp_sobras_geral
end type
type cb_mostra_fcx from dropdownlistbox within tp_sobras_geral
end type
type st_30 from statictext within tp_sobras_geral
end type
type st_29 from statictext within tp_sobras_geral
end type
type st_28 from statictext within tp_sobras_geral
end type
type st_26 from statictext within tp_sobras_geral
end type
type st_25 from statictext within tp_sobras_geral
end type
type st_27 from statictext within tp_sobras_geral
end type
type dw_perda_caixa_regional from dc_uo_dw_base within tp_sobras_geral
end type
type spd_perdas_caixa from uo_grafico_menor within tp_sobras_geral
end type
type gb_7 from groupbox within tp_sobras_geral
end type
type ln_5 from line within tp_sobras_geral
end type
type tp_sobras_geral from userobject within tab_sobras
st_38 st_38
cb_tipo_fcx cb_tipo_fcx
cb_mostra_fcx cb_mostra_fcx
st_30 st_30
st_29 st_29
st_28 st_28
st_26 st_26
st_25 st_25
st_27 st_27
dw_perda_caixa_regional dw_perda_caixa_regional
spd_perdas_caixa spd_perdas_caixa
gb_7 gb_7
ln_5 ln_5
end type
type tp_top_faltas from userobject within tab_sobras
end type
type dw_top_filial_perda from dc_uo_dw_base within tp_top_faltas
end type
type tp_top_faltas from userobject within tab_sobras
dw_top_filial_perda dw_top_filial_perda
end type
type tab_sobras from tab within tp_sobras_perdas
tp_sobras_geral tp_sobras_geral
tp_top_faltas tp_top_faltas
end type
type cb_detfaltacaixa from commandbutton within tp_sobras_perdas
end type
type tp_sobras_perdas from userobject within tab_1
tab_sobras tab_sobras
cb_detfaltacaixa cb_detfaltacaixa
end type
type tab_1 from tab within w_ge278_analise
tp_inicial tp_inicial
tp_canc_venda tp_canc_venda
tp_dev_venda tp_dev_venda
tp_desc_venda tp_desc_venda
tp_dev_compra tp_dev_compra
tp_ajuste_estoque tp_ajuste_estoque
tp_sobras_perdas tp_sobras_perdas
end type
type dw_1 from dc_uo_dw_base within w_ge278_analise
end type
type gb_1 from groupbox within w_ge278_analise
end type
end forward

global type w_ge278_analise from dc_w_sheet
string tag = "w_ge278_analise"
integer width = 3246
integer height = 2112
string title = "GE278 - Painel de An$$HEX1$$e100$$ENDHEX$$lises"
boolean resizable = false
event ue_retrieve ( )
tab_1 tab_1
dw_1 dw_1
gb_1 gb_1
end type
global w_ge278_analise w_ge278_analise

type variables
dc_uo_ds_base ivds_regiao

dc_uo_ds_base ivds_resumo_estoque
dc_uo_ds_base ivds_resumo_estoque_2

dc_uo_ds_base ivds_lancamentos_caixa
dc_uo_ds_base ivds_lancamentos_caixa_2

dc_uo_ds_base ivds_ajuste_estoque
dc_uo_ds_base ivds_ajuste_estoque_2

dc_uo_ds_base ivds_vendas
dc_uo_ds_base ivds_vendas_2

dc_uo_ds_base ivds_vendas_canc
dc_uo_ds_base ivds_vendas_canc_2

Datetime ivdt_Media_Ini_Ant
Datetime ivdt_Media_Fim_Ant
end variables

forward prototypes
public subroutine wf_get_tipo_cancelamento (ref long pl_tipo, ref long pl_mostra)
public subroutine wf_carrega_parametros ()
public subroutine wf_salva_parametros ()
public subroutine wf_get_tipo_desconto_venda (ref long pl_tipo, ref long pl_mostra)
public subroutine wf_get_tipo_devolucao_venda (ref long pl_tipo, ref long pl_mostra)
public subroutine wf_get_tipo_devolucao_compra (ref long pl_tipo, ref long pl_mostra)
public subroutine wf_get_tipo_ajuste_estoque (ref long pl_tipo, ref long pl_mostra)
public subroutine wf_get_tipo_faltas_caixa (ref long pl_tipo, ref long pl_mostra)
public function boolean wf_atualiza_datas ()
end prototypes

event ue_retrieve();Datetime lvdt_Inicio
Datetime lvdt_Fim
Datetime lvdt_Media_Ini
Datetime lvdt_Media_Fim

Long lvl_Mes
Long lvl_Ano

Decimal{2} lvdc_Total
Decimal{2} lvdc_Total_2
Decimal{2} lvdc_Percentual = 0.00

Boolean lvb_Atualiza_Media

dw_1.Accepttext( )

wf_atualiza_datas()
lvdt_Inicio		= dw_1.Object.dt_inicio			[1]
lvdt_Fim			= dw_1.Object.dt_fim				[1]

lvdt_Inicio 		= DateTime(Date(lvdt_Inicio),Time('00:00'))
lvdt_Fim 			= DateTime(Date(lvdt_Fim),Time('23:59:59'))

If lvdt_Inicio > lvdt_Fim Then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','A Data Inicial n$$HEX1$$e300$$ENDHEX$$o pode ser maior que a data final!',Exclamation!)
	Return
End If

If Date(lvdt_Fim) > Today() Then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','A pesquisa somente pode ser executada com datas anteriores ou igual a data atual!',Exclamation!)
	Return
End If

lvdt_Media_Ini	= dw_1.Object.dt_media_ini	[1]
lvdt_Media_Fim	= dw_1.Object.dt_media_fim	[1]

lvdt_Media_Ini	= DateTime(Date(lvdt_Media_Ini),Time('00:00'))
lvdt_Media_Fim	= DateTime(Date(lvdt_Media_Fim),Time('23:59:59'))

ivds_regiao.Retrieve()

lvb_Atualiza_Media = ((ivdt_Media_Ini_Ant <> lvdt_Media_Ini)or( ivdt_Media_Fim_Ant <> lvdt_Media_Fim))

Open(w_aguarde)
w_Aguarde.uo_Progress.of_SetMax(10)

//Cancelamentos de Vendas
w_Aguarde.Title = 'Recuperando informa$$HEX2$$e700f500$$ENDHEX$$es de vendas do per$$HEX1$$ed00$$ENDHEX$$odo...'
ivds_vendas_canc.Retrieve(lvdt_Inicio,lvdt_Fim)
w_Aguarde.uo_Progress.of_SetProgress(1)	

//Vendas
w_Aguarde.Title = 'Recuperando informa$$HEX2$$e700f500$$ENDHEX$$es de vendas do per$$HEX1$$ed00$$ENDHEX$$odo...'
ivds_vendas.Retrieve(lvdt_Inicio,lvdt_Fim)
w_Aguarde.uo_Progress.of_SetProgress(2)	

//Devolu$$HEX2$$e700f500$$ENDHEX$$es de Vendas
w_Aguarde.Title = 'Recuperando informa$$HEX2$$e700f500$$ENDHEX$$es de estoque do per$$HEX1$$ed00$$ENDHEX$$odo...'
ivds_resumo_estoque.Retrieve(lvdt_Inicio,lvdt_Fim)
w_Aguarde.uo_Progress.of_SetProgress(3)	

//Lan$$HEX1$$e700$$ENDHEX$$amentos Caixas Sobras/Perdas
w_Aguarde.Title = 'Recuperando informa$$HEX2$$e700f500$$ENDHEX$$es de caixa do per$$HEX1$$ed00$$ENDHEX$$odo...'
ivds_lancamentos_caixa.Retrieve(lvdt_Inicio,lvdt_Fim)
w_Aguarde.uo_Progress.of_SetProgress(4)	

//Ajustes Estoque
w_Aguarde.Title = 'Recuperando informa$$HEX2$$e700f500$$ENDHEX$$es de ajustes do per$$HEX1$$ed00$$ENDHEX$$odo...'
ivds_ajuste_estoque.Retrieve(lvdt_Inicio,lvdt_Fim)
w_Aguarde.uo_Progress.of_SetProgress(5)	

//Dados M$$HEX1$$e900$$ENDHEX$$dia
If (lvb_Atualiza_Media) Then
	w_Aguarde.Title = 'Recuperando informa$$HEX2$$e700f500$$ENDHEX$$es de m$$HEX1$$e900$$ENDHEX$$dia de cancelamentos...'
	ivds_vendas_canc_2.Retrieve(lvdt_Media_Ini,lvdt_Media_Fim)
	w_Aguarde.uo_Progress.of_SetProgress(6)	
	
	w_Aguarde.Title = 'Recuperando informa$$HEX2$$e700f500$$ENDHEX$$es de m$$HEX1$$e900$$ENDHEX$$dia de vendas...'
	ivds_vendas_2.Retrieve(lvdt_Media_Ini,lvdt_Media_Fim)
	w_Aguarde.uo_Progress.of_SetProgress(7)	
	
	w_Aguarde.Title = 'Recuperando informa$$HEX2$$e700f500$$ENDHEX$$es de m$$HEX1$$e900$$ENDHEX$$dia de estoque...'
	ivds_resumo_estoque_2.Retrieve(lvdt_Media_Ini,lvdt_Media_Fim)
	w_Aguarde.uo_Progress.of_SetProgress(8)	
	
	w_Aguarde.Title = 'Recuperando informa$$HEX2$$e700f500$$ENDHEX$$es de m$$HEX1$$e900$$ENDHEX$$dia de caixa...'
	ivds_lancamentos_caixa_2.Retrieve(lvdt_Media_Ini,lvdt_Media_Fim)
	w_Aguarde.uo_Progress.of_SetProgress(9)	
	
	w_Aguarde.Title = 'Recuperando informa$$HEX2$$e700f500$$ENDHEX$$es de m$$HEX1$$e900$$ENDHEX$$dia de ajustes...'
	ivds_ajuste_estoque_2.Retrieve(lvdt_Media_Ini,lvdt_Media_Fim)
	w_Aguarde.uo_Progress.of_SetProgress(10)	
	
	ivdt_Media_Ini_Ant	= lvdt_Media_Ini
	ivdt_Media_Fim_Ant	= lvdt_Media_Fim
End If

Close(w_Aguarde)

Tab_1.Event ue_retrieve()

Yield()
end event

public subroutine wf_get_tipo_cancelamento (ref long pl_tipo, ref long pl_mostra);String lvs_Itens[]
String lvs_Text

Long lvl_Linha

lvs_Itens	= Tab_1.tp_canc_venda.tab_canc_venda.tp_geral_cav.cb_tipo_canc.Item
lvs_Text	= Tab_1.tp_canc_venda.tab_canc_venda.tp_geral_cav.cb_tipo_canc.Text

pl_tipo = 0
For lvl_linha=1 To UpperBound(lvs_Itens)
	If lvs_Text = lvs_Itens[lvl_linha] Then
		pl_tipo = lvl_linha
		Exit
	End If
Next

lvs_Itens	= Tab_1.tp_canc_venda.tab_canc_venda.tp_geral_cav.cb_mostra_canc.Item
lvs_Text	= Tab_1.tp_canc_venda.tab_canc_venda.tp_geral_cav.cb_mostra_canc.Text

pl_mostra = 0
For lvl_linha=1 To UpperBound(lvs_Itens)
	If lvs_Text = lvs_Itens[lvl_linha] Then
		pl_mostra = lvl_linha
		Exit
	End If
Next
end subroutine

public subroutine wf_carrega_parametros ();Long lvl_Tipo
Long lvl_Mostra

//Tipo de datas da m$$HEX1$$e900$$ENDHEX$$dia
lvl_Tipo 		= Long(ProfileString(gvo_aplicacao.ivs_arquivo_ini, "Analise", "Periodo", "1"))
lvl_Mostra	= Long(ProfileString(gvo_aplicacao.ivs_arquivo_ini, "Analise", "Media", "1"))
If lvl_Tipo = 4 Then lvl_Tipo = 1
If lvl_Mostra = 4 Then lvl_Mostra = 1
dw_1.Object.id_tipo_analise	[1] = lvl_Tipo
dw_1.Object.id_tipo_media	[1] = lvl_Mostra
wf_atualiza_datas()

//Cancelamentos de Venda
lvl_Tipo 		= Long(ProfileString(gvo_aplicacao.ivs_arquivo_ini, "Analise", "Cancela_Tipo", "1"))
lvl_Mostra 	= Long(ProfileString(gvo_aplicacao.ivs_arquivo_ini, "Analise", "Cancela_Mostra", "1"))
Tab_1.Tp_Canc_Venda.Tab_Canc_Venda.Event ue_SetTipo(lvl_Tipo,lvl_Mostra)

//Devolu$$HEX2$$e700e300$$ENDHEX$$o de Venda
lvl_Tipo 		= Long(ProfileString(gvo_aplicacao.ivs_arquivo_ini, "Analise", "Devolucao_Venda_Tipo", "1"))
lvl_Mostra 	= Long(ProfileString(gvo_aplicacao.ivs_arquivo_ini, "Analise", "Devolucao_Venda_Mostra", "1"))
Tab_1.Tp_Dev_Venda.Tab_Dev_Venda.Event ue_SetTipo(lvl_Tipo,lvl_Mostra)

//Desconto de Venda
lvl_Tipo 		= Long(ProfileString(gvo_aplicacao.ivs_arquivo_ini, "Analise", "Desconto_Venda_Tipo", "1"))
lvl_Mostra 	= Long(ProfileString(gvo_aplicacao.ivs_arquivo_ini, "Analise", "Desconto_Venda_Mostra", "1"))
Tab_1.Tp_Desc_Venda.Tab_Desc_Venda.Event ue_SetTipo(lvl_Tipo,lvl_Mostra)

//Devolucao de Compra
lvl_Tipo 		= Long(ProfileString(gvo_aplicacao.ivs_arquivo_ini, "Analise", "Devolucao_Compra_Tipo", "1"))
lvl_Mostra 	= Long(ProfileString(gvo_aplicacao.ivs_arquivo_ini, "Analise", "Devolucao_Compra_Mostra", "1"))
Tab_1.Tp_Dev_Compra.Tab_Dev_Compra.Event ue_SetTipo(lvl_Tipo,lvl_Mostra)

//Ajuste de Estoque
lvl_Tipo 		= Long(ProfileString(gvo_aplicacao.ivs_arquivo_ini, "Analise", "Ajuste_Estoque_Tipo", "1"))
lvl_Mostra 	= Long(ProfileString(gvo_aplicacao.ivs_arquivo_ini, "Analise", "Ajuste_Estoque_Mostra", "1"))
Tab_1.Tp_Ajuste_Estoque.Tab_Ajuste_Estoque.Event  ue_SetTipo(lvl_Tipo,lvl_Mostra)

//Faltas Caixa
lvl_Tipo 		= Long(ProfileString(gvo_aplicacao.ivs_arquivo_ini, "Analise", "Faltas_Caixa_Tipo", "1"))
lvl_Mostra 	= Long(ProfileString(gvo_aplicacao.ivs_arquivo_ini, "Analise", "Faltas_Caixa_Mostra", "1"))
Tab_1.Tp_Sobras_Perdas.Tab_Sobras.Event ue_SetTipo(lvl_Tipo,lvl_Mostra)
end subroutine

public subroutine wf_salva_parametros ();Long lvl_Tipo
Long lvl_Mostra

dw_1.accepttext( )
//Salva Padr$$HEX1$$e300$$ENDHEX$$o M$$HEX1$$e900$$ENDHEX$$dia An$$HEX1$$e100$$ENDHEX$$lise
SetProfileString(gvo_aplicacao.ivs_arquivo_ini, "Analise", "Periodo", String(dw_1.Object.id_tipo_analise[1]))
SetProfileString(gvo_aplicacao.ivs_arquivo_ini, "Analise", "Media", String(dw_1.Object.id_tipo_media[1]))
//Salva Padr$$HEX1$$e300$$ENDHEX$$o An$$HEX1$$e100$$ENDHEX$$lise Cancelamento
wf_get_tipo_cancelamento(lvl_Tipo,lvl_Mostra)
SetProfileString(gvo_aplicacao.ivs_arquivo_ini, "Analise", "Cancela_Tipo", String(lvl_Tipo))
SetProfileString(gvo_aplicacao.ivs_arquivo_ini, "Analise", "Cancela_Mostra",String(lvl_Mostra))
//Salva Padr$$HEX1$$e300$$ENDHEX$$o An$$HEX1$$e100$$ENDHEX$$lise Dev. Venda
wf_get_tipo_devolucao_venda(lvl_Tipo,lvl_Mostra)
SetProfileString(gvo_aplicacao.ivs_arquivo_ini, "Analise", "Devolucao_Venda_Tipo", String(lvl_Tipo))
SetProfileString(gvo_aplicacao.ivs_arquivo_ini, "Analise", "Devolucao_Venda_Mostra",String(lvl_Mostra))
//Salva Padr$$HEX1$$e300$$ENDHEX$$o An$$HEX1$$e100$$ENDHEX$$lise Desc. Venda
wf_get_tipo_desconto_venda(lvl_Tipo,lvl_Mostra)
SetProfileString(gvo_aplicacao.ivs_arquivo_ini, "Analise", "Desconto_Venda_Tipo", String(lvl_Tipo))
SetProfileString(gvo_aplicacao.ivs_arquivo_ini, "Analise", "Desconto_Venda_Mostra",String(lvl_Mostra))
//Salva Padr$$HEX1$$e300$$ENDHEX$$o An$$HEX1$$e100$$ENDHEX$$lise Dev. Compra
wf_get_tipo_devolucao_compra(lvl_Tipo,lvl_Mostra)
SetProfileString(gvo_aplicacao.ivs_arquivo_ini, "Analise", "Devolucao_Compra_Tipo", String(lvl_Tipo))
SetProfileString(gvo_aplicacao.ivs_arquivo_ini, "Analise", "Devolucao_Compra_Mostra",String(lvl_Mostra))
//Salva Padr$$HEX1$$e300$$ENDHEX$$o An$$HEX1$$e100$$ENDHEX$$lise Ajuste de Estoque
wf_get_tipo_devolucao_compra(lvl_Tipo,lvl_Mostra)
SetProfileString(gvo_aplicacao.ivs_arquivo_ini, "Analise", "Ajuste_Estoque_Tipo", String(lvl_Tipo))
SetProfileString(gvo_aplicacao.ivs_arquivo_ini, "Analise", "Ajuste_Estoque_Mostra",String(lvl_Mostra))
//Salva Padr$$HEX1$$e300$$ENDHEX$$o An$$HEX1$$e100$$ENDHEX$$lise Faltas Caixa
wf_get_tipo_faltas_caixa(lvl_Tipo,lvl_Mostra)
SetProfileString(gvo_aplicacao.ivs_arquivo_ini, "Analise", "Faltas_Caixa_Tipo", String(lvl_Tipo))
SetProfileString(gvo_aplicacao.ivs_arquivo_ini, "Analise", "Faltas_Caixa_Mostra",String(lvl_Mostra))
end subroutine

public subroutine wf_get_tipo_desconto_venda (ref long pl_tipo, ref long pl_mostra);String lvs_Itens[]
String lvs_Text

Long lvl_Linha

lvs_Itens	= Tab_1.Tp_desc_venda.tab_desc_venda.tp_geral_dsv.cb_tipo_descvenda.Item
lvs_Text	= Tab_1.Tp_desc_venda.tab_desc_venda.tp_geral_dsv.cb_tipo_descvenda.Text

pl_tipo = 0
For lvl_linha=1 To UpperBound(lvs_Itens)
	If lvs_Text = lvs_Itens[lvl_linha] Then
		pl_tipo = lvl_linha
		Exit
	End If
Next

lvs_Itens	= Tab_1.Tp_desc_venda.tab_desc_venda.tp_geral_dsv.cb_mostra_descvenda.Item
lvs_Text	= Tab_1.Tp_desc_venda.tab_desc_venda.tp_geral_dsv.cb_mostra_descvenda.Text

pl_mostra = 0
For lvl_linha=1 To UpperBound(lvs_Itens)
	If lvs_Text = lvs_Itens[lvl_linha] Then
		pl_mostra = lvl_linha
		Exit
	End If
Next
end subroutine

public subroutine wf_get_tipo_devolucao_venda (ref long pl_tipo, ref long pl_mostra);String lvs_Itens[]
String lvs_Text

Long lvl_Linha

lvs_Itens	= Tab_1.tp_dev_venda.tab_dev_venda.tp_geral_dvv.cb_tipo_devenda.Item
lvs_Text	= Tab_1.tp_dev_venda.tab_dev_venda.tp_geral_dvv.cb_tipo_devenda.Text

pl_tipo = 0
For lvl_linha=1 To UpperBound(lvs_Itens)
	If lvs_Text = lvs_Itens[lvl_linha] Then
		pl_tipo = lvl_linha
		Exit
	End If
Next

lvs_Itens	= Tab_1.tp_dev_venda.tab_dev_venda.tp_geral_dvv.cb_mostra_devvenda.Item
lvs_Text	= Tab_1.tp_dev_venda.tab_dev_venda.tp_geral_dvv.cb_mostra_devvenda.Text

pl_mostra = 0
For lvl_linha=1 To UpperBound(lvs_Itens)
	If lvs_Text = lvs_Itens[lvl_linha] Then
		pl_mostra = lvl_linha
		Exit
	End If
Next
end subroutine

public subroutine wf_get_tipo_devolucao_compra (ref long pl_tipo, ref long pl_mostra);String lvs_Itens[]
String lvs_Text

Long lvl_Linha

lvs_Itens	= Tab_1.tp_dev_compra.tab_dev_compra.tp_geral_dcp.cb_tipo_devcompra.Item
lvs_Text	= Tab_1.tp_dev_compra.tab_dev_compra.tp_geral_dcp.cb_tipo_devcompra.Text

pl_tipo = 0
For lvl_linha=1 To UpperBound(lvs_Itens)
	If lvs_Text = lvs_Itens[lvl_linha] Then
		pl_tipo = lvl_linha
		Exit
	End If
Next

lvs_Itens	= Tab_1.tp_dev_compra.tab_dev_compra.tp_geral_dcp.cb_mostra_devcompra.Item
lvs_Text	= Tab_1.tp_dev_compra.tab_dev_compra.tp_geral_dcp.cb_mostra_devcompra.Text

pl_mostra = 0
For lvl_linha=1 To UpperBound(lvs_Itens)
	If lvs_Text = lvs_Itens[lvl_linha] Then
		pl_mostra = lvl_linha
		Exit
	End If
Next
end subroutine

public subroutine wf_get_tipo_ajuste_estoque (ref long pl_tipo, ref long pl_mostra);String lvs_Itens[]
String lvs_Text

Long lvl_Linha

lvs_Itens	= Tab_1.tp_ajuste_estoque.tab_ajuste_estoque.tp_geral_aje.cb_tipo_aje.Item
lvs_Text	= Tab_1.tp_ajuste_estoque.tab_ajuste_estoque.tp_geral_aje.cb_tipo_aje.Text

pl_tipo = 0
For lvl_linha=1 To UpperBound(lvs_Itens)
	If lvs_Text = lvs_Itens[lvl_linha] Then
		pl_tipo = lvl_linha
		Exit
	End If
Next

lvs_Itens	= Tab_1.tp_ajuste_estoque.tab_ajuste_estoque.tp_geral_aje.cb_mostra_aje.Item
lvs_Text	= Tab_1.tp_ajuste_estoque.tab_ajuste_estoque.tp_geral_aje.cb_mostra_aje.Text

pl_mostra = 0
For lvl_linha=1 To UpperBound(lvs_Itens)
	If lvs_Text = lvs_Itens[lvl_linha] Then
		pl_mostra = lvl_linha
		Exit
	End If
Next
end subroutine

public subroutine wf_get_tipo_faltas_caixa (ref long pl_tipo, ref long pl_mostra);String lvs_Itens[]
String lvs_Text

Long lvl_Linha

lvs_Itens	= Tab_1.tp_sobras_perdas.tab_sobras.tp_sobras_geral.cb_tipo_fcx.Item
lvs_Text	= Tab_1.tp_sobras_perdas.tab_sobras.tp_sobras_geral.cb_tipo_fcx.Text

pl_tipo = 0
For lvl_linha=1 To UpperBound(lvs_Itens)
	If lvs_Text = lvs_Itens[lvl_linha] Then
		pl_tipo = lvl_linha
		Exit
	End If
Next

lvs_Itens	= Tab_1.tp_sobras_perdas.tab_sobras.tp_sobras_geral.cb_mostra_fcx.Item
lvs_Text	= Tab_1.tp_sobras_perdas.tab_sobras.tp_sobras_geral.cb_mostra_fcx.Text

pl_mostra = 0
For lvl_linha=1 To UpperBound(lvs_Itens)
	If lvs_Text = lvs_Itens[lvl_linha] Then
		pl_mostra = lvl_linha
		Exit
	End If
Next
end subroutine

public function boolean wf_atualiza_datas ();Date lvdt_Inicio
Date lvdt_Fim
Date lvdt_Media_Ini
Date lvdt_Media_Fim

Long lvl_Tipo_Media
Long lvl_Tipo_Analise
Long lvl_Mes
Long lvl_Ano
Long lvl_Aux

dw_1.Accepttext( )

lvl_Tipo_Media		= dw_1.Object.id_tipo_media	[1]
lvl_Tipo_Analise	= dw_1.Object.id_tipo_analise	[1]

Choose Case lvl_Tipo_Analise
	Case 1
		//Dia Anterior
		lvdt_Inicio 	= RelativeDate(Today(),-1)
		lvdt_Fim	 	= RelativeDate(Today(),-1)
	Case 2
		//Semana Atual
		lvdt_Inicio 	= RelativeDate(Today(),-7)
		lvdt_Fim	 	= RelativeDate(Today(),-1)
	Case 3
		//M$$HEX1$$ea00$$ENDHEX$$s Atual
		lvdt_Inicio	= gf_primeiro_dia_mes(Today())
		lvdt_Fim		= RelativeDate(Today(), -1)
	Case 4
		//Customizada
		lvdt_Inicio	= Date(dw_1.Object.dt_inicio	[1])
		lvdt_Fim		= Date(dw_1.Object.dt_fim		[1])
	Case 5
		//Dia Atual
		lvdt_Inicio	= Today()
		lvdt_Fim		= Today()
End Choose

Choose Case lvl_Tipo_Media
	Case 1
		//M$$HEX1$$ea00$$ENDHEX$$s Anterior
		lvl_Mes = Month(lvdt_Inicio)
		lvl_Ano = Year(lvdt_Inicio)
		If lvl_Mes = 1 Then
			lvl_Mes = 12
			lvl_Ano -= 1
		Else
			lvl_Mes -= 1
		End If
		
		lvdt_Media_Ini	= Date('01/' + String(lvl_Mes,'00') + '/' + String(lvl_Ano))
		lvdt_Media_Fim	= gf_retorna_ultimo_dia_mes(lvdt_Media_Ini)
	Case 2
		//Semana Anterior
		lvdt_Media_Ini 	= RelativeDate(lvdt_Inicio,-8)
		lvdt_Media_Fim	= RelativeDate(lvdt_Inicio,-1)
	Case 3
		//Per$$HEX1$$ed00$$ENDHEX$$odo Anterior
		lvl_Aux = DaysAfter(lvdt_Inicio,lvdt_Fim)
		lvdt_Media_Fim	= RelativeDate(lvdt_Inicio, -1)
		lvdt_Media_Ini	= RelativeDate(lvdt_Media_Fim, (0 - lvl_Aux))
	Case 4
		//Customizado
		lvdt_Media_Ini 		= Date(dw_1.Object.dt_media_ini	[1])
		lvdt_Media_Fim		= Date(dw_1.Object.dt_media_fim[1]	)
	Case 5
		//M$$HEX1$$ea00$$ENDHEX$$s Atual
		lvdt_Media_Ini	= gf_primeiro_dia_mes(lvdt_Inicio)
		lvdt_Media_Fim	= gf_retorna_ultimo_dia_mes(lvdt_Media_Ini)
		If lvdt_Media_Fim >= Today() Then
			lvdt_Media_Fim = RelativeDate(Today(), -1)
		End If
End Choose

dw_1.Object.dt_inicio			[1] = lvdt_Inicio
dw_1.Object.dt_fim		 	[1] = lvdt_Fim
dw_1.Object.dt_media_ini	[1] = lvdt_Media_Ini
dw_1.Object.dt_media_fim 	[1] = lvdt_Media_Fim

Return True
end function

on w_ge278_analise.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.dw_1=create dw_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.gb_1
end on

on w_ge278_analise.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_1)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event ue_postopen;call super::ue_postopen;Long lvl_Mes
Long lvl_Ano

Date lvdt_Inicio
Date lvdt_Media_Ini

dw_1.Event ue_AddRow()

lvdt_Inicio = RelativeDate(Today(), -1)
dw_1.Object.dt_inicio	[1] = lvdt_Inicio
dw_1.Object.dt_fim	[1] = lvdt_Inicio

//Atualiza t$$HEX1$$ed00$$ENDHEX$$tulos dos gr$$HEX1$$e100$$ENDHEX$$ficos
Tab_1.tp_inicial.Event ue_settitulo()

wf_carrega_parametros()

This.ivm_Menu.mf_Recuperar(True)
end event

event ue_preopen;call super::ue_preopen;ivds_vendas					= Create dc_uo_ds_base
ivds_vendas_2				= Create dc_uo_ds_base
ivds_vendas_canc			= Create dc_uo_ds_base
ivds_vendas_canc_2		= Create dc_uo_ds_base
ivds_resumo_estoque		= Create dc_uo_ds_base
ivds_resumo_estoque_2	= Create dc_uo_ds_base
ivds_ajuste_estoque		= Create dc_uo_ds_base
ivds_ajuste_estoque_2	= Create dc_uo_ds_base
ivds_lancamentos_caixa	= Create dc_uo_ds_base
ivds_lancamentos_caixa_2	= Create dc_uo_ds_base
ivds_regiao	= Create dc_uo_ds_base

ivds_vendas.of_changedataobject('ds_ge278_vendas_regional')
ivds_vendas_2.of_changedataobject('ds_ge278_vendas_regional')
ivds_vendas_canc.of_changedataobject('ds_ge278_vendas_canceladas_regional')
ivds_vendas_canc_2.of_changedataobject('ds_ge278_vendas_canceladas_regional')
ivds_resumo_estoque.of_changedataobject('ds_ge278_resumo_estoque')
ivds_resumo_estoque_2.of_changedataobject('ds_ge278_resumo_estoque')
ivds_ajuste_estoque.of_changedataobject('ds_ge278_ajuste_estoque')
ivds_ajuste_estoque_2.of_changedataobject('ds_ge278_ajuste_estoque')
ivds_lancamentos_caixa.of_changedataobject('ds_ge278_lancamentos_caixa')
ivds_lancamentos_caixa_2.of_changedataobject('ds_ge278_lancamentos_caixa')
ivds_regiao.of_changedataobject('ds_ge278_regiao')
end event

event close;call super::close;wf_salva_parametros()

Destroy(ivds_vendas)
Destroy(ivds_vendas_2)
Destroy(ivds_vendas_canc)
Destroy(ivds_vendas_canc_2)
Destroy(ivds_resumo_estoque)
Destroy(ivds_resumo_estoque_2)
Destroy(ivds_lancamentos_caixa)
Destroy(ivds_lancamentos_caixa_2)
Destroy(ivds_ajuste_estoque)
Destroy(ivds_ajuste_estoque_2)
Destroy(ivds_regiao)
end event

type dw_visual from dc_w_sheet`dw_visual within w_ge278_analise
integer x = 59
integer y = 2140
end type

type gb_aux_visual from dc_w_sheet`gb_aux_visual within w_ge278_analise
integer x = 23
integer y = 2068
end type

type tab_1 from tab within w_ge278_analise
event create ( )
event destroy ( )
event ue_retrieve ( )
integer x = 37
integer y = 324
integer width = 3168
integer height = 1604
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
tp_inicial tp_inicial
tp_canc_venda tp_canc_venda
tp_dev_venda tp_dev_venda
tp_desc_venda tp_desc_venda
tp_dev_compra tp_dev_compra
tp_ajuste_estoque tp_ajuste_estoque
tp_sobras_perdas tp_sobras_perdas
end type

on tab_1.create
this.tp_inicial=create tp_inicial
this.tp_canc_venda=create tp_canc_venda
this.tp_dev_venda=create tp_dev_venda
this.tp_desc_venda=create tp_desc_venda
this.tp_dev_compra=create tp_dev_compra
this.tp_ajuste_estoque=create tp_ajuste_estoque
this.tp_sobras_perdas=create tp_sobras_perdas
this.Control[]={this.tp_inicial,&
this.tp_canc_venda,&
this.tp_dev_venda,&
this.tp_desc_venda,&
this.tp_dev_compra,&
this.tp_ajuste_estoque,&
this.tp_sobras_perdas}
end on

on tab_1.destroy
destroy(this.tp_inicial)
destroy(this.tp_canc_venda)
destroy(this.tp_dev_venda)
destroy(this.tp_desc_venda)
destroy(this.tp_dev_compra)
destroy(this.tp_ajuste_estoque)
destroy(this.tp_sobras_perdas)
end on

event ue_retrieve();Open(w_aguarde)
w_Aguarde.uo_Progress.of_SetMax(7)

w_Aguarde.Title = 'Atualizando dados tela inicial...'
tp_inicial.Event ue_Retrieve()
w_Aguarde.uo_Progress.of_SetProgress(1)	

w_Aguarde.Title = 'Atualizando gr$$HEX1$$e100$$ENDHEX$$ficos cancelamento venda...'
tp_canc_venda.Event ue_Retrieve()
w_Aguarde.uo_Progress.of_SetProgress(2)	

w_Aguarde.Title = 'Atualizando gr$$HEX1$$e100$$ENDHEX$$ficos devolu$$HEX2$$e700e300$$ENDHEX$$o venda...'
tp_dev_venda.Event ue_Retrieve()
w_Aguarde.uo_Progress.of_SetProgress(3)	

w_Aguarde.Title = 'Atualizando gr$$HEX1$$e100$$ENDHEX$$ficos desconto venda...'
tp_desc_venda.Event ue_Retrieve()
w_Aguarde.uo_Progress.of_SetProgress(4)	

w_Aguarde.Title = 'Atualizando gr$$HEX1$$e100$$ENDHEX$$ficos devolu$$HEX2$$e700e300$$ENDHEX$$o compra...'
tp_dev_compra.Event ue_Retrieve()
w_Aguarde.uo_Progress.of_SetProgress(5)	

w_Aguarde.Title = 'Atualizando gr$$HEX1$$e100$$ENDHEX$$ficos ajuste estoque...'
tp_ajuste_estoque.Event ue_Retrieve()
w_Aguarde.uo_Progress.of_SetProgress(6)	

w_Aguarde.Title = 'Atualizando gr$$HEX1$$e100$$ENDHEX$$ficos faltas/sobras caixa...'
tp_sobras_perdas.Event ue_Retrieve()
w_Aguarde.uo_Progress.of_SetProgress(7)	

Close(w_aguarde)
end event

event selectionchanging;Choose Case NewIndex
	Case 2 
		tp_canc_venda.Tab_Canc_Venda.SelectTab(1)
	Case 3
		tp_dev_venda.Tab_Dev_Venda.SelectTab(1)
	Case 4 
		tp_desc_venda.tab_desc_venda.SelectTab(1)
	Case 5 
		tp_dev_compra.tab_dev_compra.SelectTab(1)
	Case 6 
		tp_ajuste_estoque.tab_ajuste_estoque.SelectTab(1)
	Case 7 
		tp_sobras_perdas.tab_sobras.SelectTab(1)
End Choose
end event

type tp_inicial from userobject within tab_1
event create ( )
event destroy ( )
event ue_settitulo ( )
event ue_retrieve ( )
integer x = 558
integer y = 16
integer width = 2592
integer height = 1572
long backcolor = 67108864
string text = "Inicial"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 553648127
spd_ini_perdas_caixa spd_ini_perdas_caixa
spd_ini_dev_compra spd_ini_dev_compra
spd_ini_ajuste_estoque spd_ini_ajuste_estoque
spd_ini_desc spd_ini_desc
spd_ini_dev_venda spd_ini_dev_venda
spd_ini_canc spd_ini_canc
end type

on tp_inicial.create
this.spd_ini_perdas_caixa=create spd_ini_perdas_caixa
this.spd_ini_dev_compra=create spd_ini_dev_compra
this.spd_ini_ajuste_estoque=create spd_ini_ajuste_estoque
this.spd_ini_desc=create spd_ini_desc
this.spd_ini_dev_venda=create spd_ini_dev_venda
this.spd_ini_canc=create spd_ini_canc
this.Control[]={this.spd_ini_perdas_caixa,&
this.spd_ini_dev_compra,&
this.spd_ini_ajuste_estoque,&
this.spd_ini_desc,&
this.spd_ini_dev_venda,&
this.spd_ini_canc}
end on

on tp_inicial.destroy
destroy(this.spd_ini_perdas_caixa)
destroy(this.spd_ini_dev_compra)
destroy(this.spd_ini_ajuste_estoque)
destroy(this.spd_ini_desc)
destroy(this.spd_ini_dev_venda)
destroy(this.spd_ini_canc)
end on

event ue_settitulo();spd_ini_canc.of_settitulo('Cancelamento Venda')
spd_ini_dev_venda.of_settitulo('Devolu$$HEX2$$e700e300$$ENDHEX$$o Venda')
spd_ini_desc.of_settitulo('Desconto Venda')
spd_ini_dev_compra.of_settitulo('Devolu$$HEX2$$e700e300$$ENDHEX$$o Compra')
spd_ini_ajuste_estoque.of_settitulo('Ajustes Estoque')
spd_ini_perdas_caixa.of_settitulo('Faltas Caixas')
end event

type spd_ini_perdas_caixa from uo_grafico_menor within tp_inicial
integer x = 1568
integer y = 584
integer taborder = 40
boolean border = true
end type

on spd_ini_perdas_caixa.destroy
call uo_grafico_menor::destroy
end on

event ue_clicked;call super::ue_clicked;Tab_1.selecttab(7)
end event

type spd_ini_dev_compra from uo_grafico_menor within tp_inicial
integer x = 46
integer y = 580
integer taborder = 30
boolean border = true
end type

on spd_ini_dev_compra.destroy
call uo_grafico_menor::destroy
end on

event ue_clicked;call super::ue_clicked;Tab_1.selecttab(5)
end event

type spd_ini_ajuste_estoque from uo_grafico_menor within tp_inicial
integer x = 805
integer y = 584
integer taborder = 30
boolean border = true
end type

on spd_ini_ajuste_estoque.destroy
call uo_grafico_menor::destroy
end on

event ue_clicked;call super::ue_clicked;Tab_1.selecttab(6)
end event

type spd_ini_desc from uo_grafico_menor within tp_inicial
integer x = 1568
integer y = 36
integer taborder = 30
boolean border = true
end type

on spd_ini_desc.destroy
call uo_grafico_menor::destroy
end on

event ue_clicked;call super::ue_clicked;Tab_1.selecttab(4)
end event

type spd_ini_dev_venda from uo_grafico_menor within tp_inicial
integer x = 805
integer y = 36
integer taborder = 30
boolean border = true
end type

on spd_ini_dev_venda.destroy
call uo_grafico_menor::destroy
end on

event ue_clicked;call super::ue_clicked;Tab_1.selecttab(3)
end event

type spd_ini_canc from uo_grafico_menor within tp_inicial
event destroy ( )
integer x = 46
integer y = 36
integer taborder = 50
boolean border = true
end type

on spd_ini_canc.destroy
call uo_grafico_menor::destroy
end on

event ue_clicked;call super::ue_clicked;Tab_1.selecttab(2)
end event

type tp_canc_venda from userobject within tab_1
event create ( )
event destroy ( )
event ue_retrieve ( )
integer x = 558
integer y = 16
integer width = 2592
integer height = 1572
long backcolor = 79741120
string text = "Canc. Venda"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
tab_canc_venda tab_canc_venda
cb_detalhe_cve cb_detalhe_cve
end type

on tp_canc_venda.create
this.tab_canc_venda=create tab_canc_venda
this.cb_detalhe_cve=create cb_detalhe_cve
this.Control[]={this.tab_canc_venda,&
this.cb_detalhe_cve}
end on

on tp_canc_venda.destroy
destroy(this.tab_canc_venda)
destroy(this.cb_detalhe_cve)
end on

event ue_retrieve();Tab_Canc_Venda.SelectTab(1)
Tab_Canc_Venda.tp_geral_cav.Event ue_Retrieve()
end event

type tab_canc_venda from tab within tp_canc_venda
event create ( )
event destroy ( )
event ue_settipo ( long pl_tipo,  long pl_mostra )
integer x = 9
integer y = 12
integer width = 2574
integer height = 1424
integer taborder = 20
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
tp_geral_cav tp_geral_cav
tp_top_filial_cancela tp_top_filial_cancela
tp_revisao_cancvenda tp_revisao_cancvenda
end type

on tab_canc_venda.create
this.tp_geral_cav=create tp_geral_cav
this.tp_top_filial_cancela=create tp_top_filial_cancela
this.tp_revisao_cancvenda=create tp_revisao_cancvenda
this.Control[]={this.tp_geral_cav,&
this.tp_top_filial_cancela,&
this.tp_revisao_cancvenda}
end on

on tab_canc_venda.destroy
destroy(this.tp_geral_cav)
destroy(this.tp_top_filial_cancela)
destroy(this.tp_revisao_cancvenda)
end on

event ue_settipo(long pl_tipo, long pl_mostra);tp_geral_cav.Event ue_settipo(pl_tipo,pl_mostra)
tp_top_filial_cancela.Event ue_settipo(pl_tipo,pl_mostra)
end event

event selectionchanging;Long lvl_Tipo
Long lvl_Mostra

wf_get_tipo_cancelamento(lvl_Tipo,lvl_Mostra)

Choose Case NewIndex
	Case 2 
		Choose Case lvl_Tipo
			Case 1
				tp_top_filial_cancela.dw_top_filial_cancela_qtde.Event ue_Retrieve()
			Case 2
				tp_top_filial_cancela.dw_top_filial_cancela.Event ue_Retrieve()
		End Choose
	Case 3
		tp_revisao_cancvenda.dw_revisao_cancvenda.Event ue_Retrieve()
End Choose
end event

type tp_geral_cav from userobject within tab_canc_venda
event create ( )
event destroy ( )
event ue_retrieve ( )
event ue_settipo ( long pl_tipo,  long pl_mostra )
integer x = 18
integer y = 100
integer width = 2537
integer height = 1308
boolean border = true
long backcolor = 79741120
string text = "Geral"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
cb_mostra_canc cb_mostra_canc
dw_canc_venda_regional_perc dw_canc_venda_regional_perc
spd_cancvenda spd_cancvenda
st_24 st_24
st_23 st_23
st_22 st_22
st_21 st_21
st_20 st_20
st_19 st_19
ln_4 ln_4
cb_tipo_canc cb_tipo_canc
dw_canc_venda_regional dw_canc_venda_regional
gb_2 gb_2
end type

on tp_geral_cav.create
this.cb_mostra_canc=create cb_mostra_canc
this.dw_canc_venda_regional_perc=create dw_canc_venda_regional_perc
this.spd_cancvenda=create spd_cancvenda
this.st_24=create st_24
this.st_23=create st_23
this.st_22=create st_22
this.st_21=create st_21
this.st_20=create st_20
this.st_19=create st_19
this.ln_4=create ln_4
this.cb_tipo_canc=create cb_tipo_canc
this.dw_canc_venda_regional=create dw_canc_venda_regional
this.gb_2=create gb_2
this.Control[]={this.cb_mostra_canc,&
this.dw_canc_venda_regional_perc,&
this.spd_cancvenda,&
this.st_24,&
this.st_23,&
this.st_22,&
this.st_21,&
this.st_20,&
this.st_19,&
this.ln_4,&
this.cb_tipo_canc,&
this.dw_canc_venda_regional,&
this.gb_2}
end on

on tp_geral_cav.destroy
destroy(this.cb_mostra_canc)
destroy(this.dw_canc_venda_regional_perc)
destroy(this.spd_cancvenda)
destroy(this.st_24)
destroy(this.st_23)
destroy(this.st_22)
destroy(this.st_21)
destroy(this.st_20)
destroy(this.st_19)
destroy(this.ln_4)
destroy(this.cb_tipo_canc)
destroy(this.dw_canc_venda_regional)
destroy(this.gb_2)
end on

event ue_retrieve();Long lvl_Linha_Aux
Long lvl_Linha
Long lvl_Tipo
Long lvl_Mostra

Decimal{8} lvdc_Total
Decimal{8} lvdc_Total_2
Decimal{2} lvdc_Percentual = 0.00

wf_get_tipo_cancelamento(lvl_Tipo,lvl_Mostra)

Tab_1.tp_canc_venda.cb_detalhe_cve.Enabled = False

Choose Case lvl_Tipo
	Case 1
		//Atualiza Gr$$HEX1$$e100$$ENDHEX$$fico Regionais
		If lvl_Mostra = 1 Then
			dw_canc_venda_regional_perc.Event ue_Retrieve()
		Else
			dw_canc_venda_regional.Event ue_Retrieve()
		End If
		//Retorna Propor$$HEX2$$e700e300$$ENDHEX$$o de Cancelamentos Atual
		If (ivds_vendas_canc.RowCount() > 0)and(ivds_vendas.RowCount()>0) Then
			lvdc_Total 		= ivds_vendas_canc.Object.cp_qt_total[1] / ivds_vendas.Object.cp_qt_total[1]
		End If
		//Retorna Propor$$HEX2$$e700e300$$ENDHEX$$o de Cancelamentos M$$HEX1$$e900$$ENDHEX$$dia
		If (ivds_vendas_canc_2.RowCount() > 0)and(ivds_vendas_2.RowCount()>0) Then 
			lvdc_Total_2	= (ivds_vendas_canc_2.Object.cp_qt_total[1]) / ivds_vendas_2.Object.cp_qt_total[1]
		End If
		//Calcula Percentual Atual x Media
		If lvdc_Total_2 > 0 Then 
			lvdc_Percentual = Round((lvdc_Total / lvdc_Total_2)*100,2)
		End If
		//Habilita Bot$$HEX1$$e300$$ENDHEX$$o Detalhes	
		If lvdc_Total > 0 Then
			Tab_1.tp_canc_venda.cb_detalhe_cve.Enabled = True
		End If
		//Nomeia o eixo Y do gr$$HEX1$$e100$$ENDHEX$$fico com os valores mostrados
		dw_canc_venda_regional_perc.Object.gr_1.Values.Label	='Qtde Cancelamentos (%)'
		dw_canc_venda_regional.Object.gr_1.Values.Label		='Qtde Cancelamentos'
	Case 2		
		//Atualiza Gr$$HEX1$$e100$$ENDHEX$$fico Regionais
		If lvl_Mostra = 1 Then
			dw_canc_venda_regional_perc.Event ue_Retrieve()
		Else
			dw_canc_venda_regional.Event ue_Retrieve()
		End If
		//Retorna Propor$$HEX2$$e700e300$$ENDHEX$$o de Cancelamentos Atual
		If (ivds_vendas_canc.RowCount() > 0)and(ivds_vendas.RowCount()>0) Then
			lvdc_Total 		= ivds_vendas_canc.Object.cp_vl_total[1] / ivds_vendas.Object.cp_vl_total[1]
		End If
		//Retorna Propor$$HEX2$$e700e300$$ENDHEX$$o de Cancelamentos M$$HEX1$$e900$$ENDHEX$$dia
		If (ivds_vendas_canc_2.RowCount() > 0)and(ivds_vendas_2.RowCount()>0) Then 
			lvdc_Total_2	= (ivds_vendas_canc_2.Object.cp_vl_total[1]) / ivds_vendas_2.Object.cp_vl_total[1]
		End If
		//Calcula Percentual Atual x Media
		If lvdc_Total_2 > 0 Then 
			lvdc_Percentual = Round((lvdc_Total / lvdc_Total_2)*100,2)
		End If
		//Habilita Bot$$HEX1$$e300$$ENDHEX$$o Detalhes	
		If lvdc_Total > 0 Then
			Tab_1.tp_canc_venda.cb_detalhe_cve.Enabled = True
		End If
		//Nomeia o eixo Y do gr$$HEX1$$e100$$ENDHEX$$fico com os valores mostrados
		dw_canc_venda_regional_perc.Object.gr_1.Values.Label	='Valor Cancelamentos (%)'
		dw_canc_venda_regional.Object.gr_1.Values.Label		='Valor Cancelamentos (R$)'
End Choose

spd_cancvenda.of_setvalor(lvdc_Percentual)
Tab_1.tp_inicial.spd_ini_canc.of_setvalor(lvdc_Percentual)
end event

event ue_settipo(long pl_tipo, long pl_mostra);This.Event ue_Retrieve()

dw_canc_venda_regional.Visible			= (pl_mostra = 2)
dw_canc_venda_regional_perc.Visible	= (pl_mostra = 1)

If cb_tipo_canc.Text  <> cb_tipo_canc.Text(pl_tipo) Then
	cb_tipo_canc.SelectItem(pl_tipo)
End If

If cb_mostra_canc.Text  <> cb_mostra_canc.Text(pl_mostra) Then
	cb_mostra_canc.SelectItem(pl_mostra)
End If
end event

type cb_mostra_canc from dropdownlistbox within tp_geral_cav
integer x = 1865
integer y = 1156
integer width = 608
integer height = 324
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
string text = "Valor"
boolean sorted = false
boolean vscrollbar = true
string item[] = {"Percentual","Valor"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;Long lvl_Mostra
Long lvl_Tipo

wf_get_tipo_cancelamento(lvl_Tipo,lvl_Mostra)

Tab_1.Tp_Canc_Venda.Tab_Canc_Venda.Event ue_settipo(lvl_Tipo,Index)
end event

type dw_canc_venda_regional_perc from dc_uo_dw_base within tp_geral_cav
integer x = 41
integer y = 32
integer width = 1751
integer height = 1236
integer taborder = 20
string dataobject = "dwg_ge278_regional_cancelamento_perc"
boolean border = true
end type

event ue_recuperar;//override
Long lvl_Linha
Long lvl_Regiao
Long lvl_Find
Long lvl_Qtde_Canc
Long lvl_Qtde_Venda
Long lvl_Tipo
Long lvl_Mostra

Decimal{2} lvdc_Canc
Decimal{2} lvdc_Venda
Decimal{2} lvdc_Pc_Regional = 0.00

This.SetRedraw(False)
This.Reset()

wf_get_tipo_cancelamento(lvl_Tipo,lvl_Mostra)

//Preenche dados do gr$$HEX1$$e100$$ENDHEX$$fico por Regional
For lvl_Linha = 1 To ivds_regiao.RowCount() 
	lvdc_Pc_Regional = 0.00
	lvl_Regiao = ivds_regiao.Object.cd_regiao[lvl_Linha]
	lvl_Find = ivds_vendas_canc.Find('cd_regiao='+String(lvl_Regiao), 1, ivds_vendas_canc.RowCount())
	If lvl_Find > 0 Then
		lvl_Qtde_Canc	= ivds_vendas_canc.Object.qt_total	[lvl_Find]
		lvdc_Canc			= ivds_vendas_canc.Object.vl_total	[lvl_Find]
		lvl_Find = ivds_vendas.Find('cd_regiao='+String(lvl_Regiao), 1, ivds_vendas.RowCount())
		If lvl_Find > 0 Then
			lvl_Qtde_Venda	= ivds_vendas.Object.qt_total	[lvl_Find]
			lvdc_Venda		= ivds_vendas.Object.vl_total	[lvl_Find]
			
			Choose Case lvl_Tipo
				Case 1
					If lvl_Qtde_Venda > 0 Then
						lvdc_Pc_Regional = (lvl_Qtde_Canc / lvl_Qtde_Venda) * 100
					End If
				Case 2
					If lvdc_Venda > 0 Then
						lvdc_Pc_Regional = (lvdc_Canc / lvdc_Venda) * 100
					End If
			End Choose
		End If
	End If
	
	This.Event ue_AddRow()
	This.Object.cd_regional 			[lvl_Linha] = lvl_Regiao
	This.Object.de_regional			[lvl_Linha] = ivds_regiao.Object.de_regiao[lvl_Linha]			
	This.Object.pc_cancelamento	[lvl_Linha] = lvdc_Pc_Regional
Next

This.SetRedraw(True)

If ivds_vendas_canc.RowCount() > 0 Then
	Tab_1.tp_canc_venda.cb_detalhe_cve.Enabled = True
End If

Return This.RowCount()
end event

type spd_cancvenda from uo_grafico_menor within tp_geral_cav
integer x = 1815
integer y = 32
integer taborder = 40
boolean border = true
end type

on spd_cancvenda.destroy
call uo_grafico_menor::destroy
end on

type st_24 from statictext within tp_geral_cav
integer x = 1815
integer y = 608
integer width = 110
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 553648127
string text = "R = "
alignment alignment = center!
boolean focusrectangle = false
end type

type st_23 from statictext within tp_geral_cav
integer x = 1925
integer y = 568
integer width = 549
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 553648127
string text = "( CaV / V )"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_22 from statictext within tp_geral_cav
integer x = 1925
integer y = 648
integer width = 549
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 553648127
string text = "( CaV M / V M )"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_21 from statictext within tp_geral_cav
integer x = 1879
integer y = 760
integer width = 558
integer height = 52
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "CaV = Canc. Venda"
boolean focusrectangle = false
end type

type st_20 from statictext within tp_geral_cav
integer x = 1943
integer y = 824
integer width = 402
integer height = 52
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "V = Vendas"
boolean focusrectangle = false
end type

type st_19 from statictext within tp_geral_cav
integer x = 1938
integer y = 884
integer width = 494
integer height = 52
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "M = M$$HEX1$$e900$$ENDHEX$$dia"
boolean focusrectangle = false
end type

type ln_4 from line within tp_geral_cav
integer linethickness = 4
integer beginx = 1961
integer beginy = 636
integer endx = 2414
integer endy = 636
end type

type cb_tipo_canc from dropdownlistbox within tp_geral_cav
integer x = 1865
integer y = 1064
integer width = 608
integer height = 236
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
string text = "Valor"
boolean sorted = false
string item[] = {"Quantidade","Valor"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;Long lvl_Mostra
Long lvl_Tipo

wf_get_tipo_cancelamento(lvl_Tipo,lvl_Mostra)

Tab_1.Tp_Canc_Venda.Tab_Canc_Venda.Event ue_settipo(Index,lvl_Mostra)

end event

type dw_canc_venda_regional from dc_uo_dw_base within tp_geral_cav
integer x = 41
integer y = 32
integer width = 1751
integer height = 1236
integer taborder = 40
boolean bringtotop = true
string dataobject = "dwg_ge278_regional_cancelamento"
boolean border = true
end type

event ue_recuperar;//override
Long lvl_Linha_Aux
Long lvl_Linha
Long lvl_Regiao
Long lvl_Find
Long lvl_Qtde_Canc
Long lvl_Qtde_Venda
Long lvl_Tipo
Long lvl_Mostra

Decimal{8} lvdc_Media
Decimal{8} lvdc_Media_Qtde
Decimal{2} lvdc_Venda
Decimal{2} lvdc_Canc

wf_get_tipo_cancelamento(lvl_Tipo,lvl_Mostra)

This.SetRedraw(False)
This.Reset( )

//Retorna Propor$$HEX2$$e700e300$$ENDHEX$$o de Cancelamentos M$$HEX1$$e900$$ENDHEX$$dia
If (ivds_vendas_canc_2.RowCount() > 0)and(ivds_vendas_2.RowCount()>0) Then 
	lvdc_Media			= (ivds_vendas_canc_2.Object.cp_vl_total[1]) / ivds_vendas_2.Object.cp_vl_total	[1]
	lvdc_Media_Qtde	= (ivds_vendas_canc_2.Object.cp_qt_total[1]) / ivds_vendas_2.Object.cp_qt_total[1]
End If

Choose Case lvl_Tipo
	Case 1
		This.Object.gr_1.Values="sum(qt_cancelamento for graph)"
		This.Object.gr_1.Values.Dispattr.Format="#,##0"
	Case 2
		This.Object.gr_1.Values="sum(vl_cancelamento for graph)"
		This.Object.gr_1.Values.Dispattr.Format="#,##0.00"
End Choose

For lvl_Linha = 1 To ivds_regiao.RowCount()
	lvl_Regiao = ivds_regiao.Object.cd_regiao[lvl_Linha]
	lvl_Find = ivds_vendas_canc.Find('cd_regiao='+String(lvl_Regiao), 1, ivds_vendas_canc.RowCount())
	If lvl_Find > 0 Then
		lvl_Qtde_Canc	= ivds_vendas_canc.Object.qt_total	[lvl_Find]
		lvdc_Canc			= ivds_vendas_canc.Object.vl_total	[lvl_Find]
		lvl_Find = ivds_vendas.Find('cd_regiao='+String(lvl_Regiao), 1, ivds_vendas.RowCount())
		If lvl_Find > 0 Then
			lvl_Qtde_Venda	= ivds_vendas.Object.qt_total	[lvl_Find]
			lvdc_Venda		= ivds_vendas.Object.vl_total	[lvl_Find]
		End If
	End If

	This.Event ue_AddRow()
	lvl_Linha_Aux = This.RowCount()
	This.Object.cd_regional 			[lvl_Linha_Aux] = lvl_Regiao
	This.Object.de_regional			[lvl_Linha_Aux] = ivds_regiao.Object.de_regiao[lvl_Linha]
	This.Object.vl_cancelamento	[lvl_Linha_Aux] = lvdc_Canc
	This.Object.qt_cancelamento	[lvl_Linha_Aux] = lvl_Qtde_Canc
	This.Object.id_tipo 				[lvl_Linha_Aux] = 'Atual'

	This.Event ue_AddRow()
	This.Object.cd_regional			[lvl_Linha_Aux + 1] = lvl_Regiao
	This.Object.de_regional 			[lvl_Linha_Aux + 1] = ivds_regiao.Object.de_regiao[lvl_Linha]
	This.Object.vl_cancelamento	[lvl_Linha_Aux + 1] = Round(lvdc_Venda * lvdc_Media,2)
	This.Object.qt_cancelamento	[lvl_Linha_Aux + 1] = Round(lvl_Qtde_Venda * lvdc_Media_Qtde,0)
	This.Object.id_tipo 				[lvl_Linha_Aux + 1] = 'M$$HEX1$$e900$$ENDHEX$$dia'
Next

This.SetRedraw(True)

Return This.RowCount()
end event

type gb_2 from groupbox within tp_geral_cav
integer x = 1810
integer y = 1000
integer width = 699
integer height = 272
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tipo An$$HEX1$$e100$$ENDHEX$$lise"
borderstyle borderstyle = stylebox!
end type

type tp_top_filial_cancela from userobject within tab_canc_venda
event ue_settipo ( long pl_tipo,  long pl_mostra )
integer x = 18
integer y = 100
integer width = 2537
integer height = 1308
long backcolor = 79741120
string text = "TOP 10 - Filiais"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_top_filial_cancela_qtde dw_top_filial_cancela_qtde
dw_top_filial_cancela dw_top_filial_cancela
end type

event ue_settipo(long pl_tipo, long pl_mostra);dw_top_filial_cancela_qtde.visible = (pl_tipo = 1)
dw_top_filial_cancela.visible 		= (pl_tipo = 2)
end event

on tp_top_filial_cancela.create
this.dw_top_filial_cancela_qtde=create dw_top_filial_cancela_qtde
this.dw_top_filial_cancela=create dw_top_filial_cancela
this.Control[]={this.dw_top_filial_cancela_qtde,&
this.dw_top_filial_cancela}
end on

on tp_top_filial_cancela.destroy
destroy(this.dw_top_filial_cancela_qtde)
destroy(this.dw_top_filial_cancela)
end on

type dw_top_filial_cancela_qtde from dc_uo_dw_base within tp_top_filial_cancela
integer x = 46
integer y = 36
integer width = 2455
integer height = 1236
integer taborder = 20
string dataobject = "dwg_ge278_top_filiais_cancelamento_qtde"
boolean border = true
end type

event ue_recuperar;//override
Datetime lvdt_Inicio
Datetime lvdt_Fim

dw_1.Accepttext( )

lvdt_Inicio = dw_1.Object.dt_inicio	[1]
lvdt_Fim	  = dw_1.Object.dt_fim	[1]

lvdt_Inicio = Datetime(Date(lvdt_Inicio),Time('00:00:00'))
lvdt_Fim	  = Datetime(Date(lvdt_Fim),Time('23:59:59'))

Return This.Retrieve(lvdt_Inicio,lvdt_Fim)
end event

event ue_preretrieve;call super::ue_preretrieve;This.of_appendwhere_subquery("not exists (	select i2.cd_produto " + &
															"from nf_venda n2 " + &
															"inner join item_nf_venda i2 " + &
																"on i2.cd_filial = n2.cd_filial " + &
																"and i2.nr_nf = n2.nr_nf " + &
																"and i2.de_serie = n2.de_serie " + &
																"and i2.de_especie = n2.de_especie " + &
															"where n2.dh_movimentacao_caixa = lo.dh_movimentacao_caixa " + &
																"and n2.cd_filial = lo.cd_filial " + &
																"and n2.dh_emissao between lo.dh_cancelamento and dateadd(mi,7,lo.dh_cancelamento) " + &
																"and i2.cd_produto = lo.cd_produto " + &
																"and n2.cd_caixa = lo.cd_caixa " + &
																"and n2.nr_controle_caixa = lo.nr_controle_caixa " + &
																"and n2.nr_ecf = lo.nr_ecf"+&
																")",1)

Return AncestorReturnValue
end event

type dw_top_filial_cancela from dc_uo_dw_base within tp_top_filial_cancela
integer x = 46
integer y = 36
integer width = 2455
integer height = 1236
integer taborder = 20
boolean bringtotop = true
string dataobject = "dwg_ge278_top_filiais_cancelamento"
boolean border = true
end type

event ue_recuperar;//override
Datetime lvdt_Inicio
Datetime lvdt_Fim

dw_1.Accepttext( )

lvdt_Inicio = dw_1.Object.dt_inicio	[1]
lvdt_Fim	  = dw_1.Object.dt_fim	[1]

lvdt_Inicio = Datetime(Date(lvdt_Inicio),Time('00:00:00'))
lvdt_Fim	  = Datetime(Date(lvdt_Fim),Time('23:59:59'))

Return This.Retrieve(lvdt_Inicio,lvdt_Fim)
end event

event ue_preretrieve;call super::ue_preretrieve;This.of_appendwhere_subquery("not exists (	select i2.cd_produto " + &
															"from nf_venda n2 " + &
															"inner join item_nf_venda i2 " + &
																"on i2.cd_filial = n2.cd_filial " + &
																"and i2.nr_nf = n2.nr_nf " + &
																"and i2.de_serie = n2.de_serie " + &
																"and i2.de_especie = n2.de_especie " + &
															"where n2.dh_movimentacao_caixa = lo.dh_movimentacao_caixa " + &
																"and n2.cd_filial = lo.cd_filial " + &
																"and n2.dh_emissao between lo.dh_cancelamento and dateadd(mi,7,lo.dh_cancelamento) " + &
																"and i2.cd_produto = lo.cd_produto " + &
																"and n2.cd_caixa = lo.cd_caixa " + &
																"and n2.nr_controle_caixa = lo.nr_controle_caixa " + &
																"and n2.nr_ecf = lo.nr_ecf"+&
																")",1)

Return AncestorReturnValue
end event

type tp_revisao_cancvenda from userobject within tab_canc_venda
integer x = 18
integer y = 100
integer width = 2537
integer height = 1308
long backcolor = 79741120
string text = "Revis$$HEX1$$e300$$ENDHEX$$o"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_revisao_cancvenda dw_revisao_cancvenda
gb_10 gb_10
end type

on tp_revisao_cancvenda.create
this.dw_revisao_cancvenda=create dw_revisao_cancvenda
this.gb_10=create gb_10
this.Control[]={this.dw_revisao_cancvenda,&
this.gb_10}
end on

on tp_revisao_cancvenda.destroy
destroy(this.dw_revisao_cancvenda)
destroy(this.gb_10)
end on

type dw_revisao_cancvenda from dc_uo_dw_base within tp_revisao_cancvenda
integer x = 41
integer y = 72
integer width = 2437
integer height = 1192
integer taborder = 30
string dataobject = "dw_ge278_revisao"
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.Of_setrowselection( )
end event

event rowfocuschanged;call super::rowfocuschanged;Datetime lvdh_Revisao

If CurrentRow > 0 Then
	This.Object.de_revisao_footer.Text	= This.Object.de_revisao	[CurrentRow]
	This.Object.nm_usuario_footer.Text	= This.Object.nm_usuario	[CurrentRow] + ' ('+String(This.Object.nr_matricula_revisao	[CurrentRow])+')'
	lvdh_Revisao								= This.Object.dh_revisao	[CurrentRow]
	If (Not IsNull(lvdh_Revisao)) and (lvdh_Revisao > Datetime('2015/01/01')) Then
		This.Object.dh_revisao_footer.Text	= String(lvdh_Revisao,'dd/mm/yyyy hh:mm')
	Else
		This.Object.dh_revisao_footer.Text	= ''
	End If
Else 
	This.Object.de_revisao_footer.Text 	= ''
	This.Object.nm_usuario_footer.Text	= ''
	This.Object.dh_revisao_footer.Text	= ''
End If
end event

event ue_recuperar;//override
Datetime lvdt_Inicio
Datetime lvdt_Fim

dw_1.Accepttext( )

lvdt_Inicio = dw_1.Object.dt_inicio	[1]
lvdt_Fim	  = dw_1.Object.dt_fim	[1]

lvdt_Inicio = Datetime(Date(lvdt_Inicio),Time('00:00:00'))
lvdt_Fim	  = Datetime(Date(lvdt_Fim),Time('23:59:59'))

Return This.Retrieve(lvdt_Inicio,lvdt_Fim)
end event

event ue_preretrieve;call super::ue_preretrieve;This.Of_appendwhere("m.id_analise='CAV'")

Return AncestorReturnValue
end event

type gb_10 from groupbox within tp_revisao_cancvenda
integer x = 23
integer y = 8
integer width = 2482
integer height = 1272
integer taborder = 20
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

type cb_detalhe_cve from commandbutton within tp_canc_venda
integer x = 1088
integer y = 1456
integer width = 402
integer height = 92
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Detalhes"
end type

event clicked;//override
Datetime lvdt_Inicio
Datetime lvdt_Fim

Long lvl_Tipo
Long lvl_Mostra

String lvs_Param

dw_1.Accepttext( )

wf_get_tipo_cancelamento(lvl_Tipo,lvl_Mostra)

lvdt_Inicio = dw_1.Object.dt_inicio	[1]
lvdt_Fim	  = dw_1.Object.dt_fim	[1]

lvs_Param = String(lvdt_Inicio,'dd/mm/yyyy')+';'+String(lvdt_Fim,'dd/mm/yyyy')+';'+String(lvl_Tipo)+';'+String(lvl_Mostra)+';'

OpenSheetWithParm(w_ge279_relatorio_log_cancelamento,lvs_Param,dc_w_MDI)

end event

type tp_dev_venda from userobject within tab_1
event ue_retrieve ( )
integer x = 558
integer y = 16
integer width = 2592
integer height = 1572
long backcolor = 79741120
string text = "Dev. Venda"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
tab_dev_venda tab_dev_venda
cb_2 cb_2
end type

event ue_retrieve();Tab_Dev_Venda.SelectTab(1)
Tab_Dev_Venda.tp_geral_dvv.Event ue_retrieve()
end event

on tp_dev_venda.create
this.tab_dev_venda=create tab_dev_venda
this.cb_2=create cb_2
this.Control[]={this.tab_dev_venda,&
this.cb_2}
end on

on tp_dev_venda.destroy
destroy(this.tab_dev_venda)
destroy(this.cb_2)
end on

type tab_dev_venda from tab within tp_dev_venda
event create ( )
event destroy ( )
event ue_settipo ( long pl_tipo,  long pl_mostra )
integer x = 9
integer y = 12
integer width = 2574
integer height = 1424
integer taborder = 10
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
tp_geral_dvv tp_geral_dvv
tp_top_filiais_devv tp_top_filiais_devv
tp_revisao_devvenda tp_revisao_devvenda
end type

on tab_dev_venda.create
this.tp_geral_dvv=create tp_geral_dvv
this.tp_top_filiais_devv=create tp_top_filiais_devv
this.tp_revisao_devvenda=create tp_revisao_devvenda
this.Control[]={this.tp_geral_dvv,&
this.tp_top_filiais_devv,&
this.tp_revisao_devvenda}
end on

on tab_dev_venda.destroy
destroy(this.tp_geral_dvv)
destroy(this.tp_top_filiais_devv)
destroy(this.tp_revisao_devvenda)
end on

event ue_settipo(long pl_tipo, long pl_mostra);tp_geral_dvv.Event ue_settipo(pl_tipo,pl_mostra)
tp_top_filiais_devv.Event ue_settipo(pl_tipo,pl_mostra)
end event

event selectionchanging;Choose Case NewIndex
	Case 2
		tp_top_filiais_devv.dw_top_filiais_devv.Event ue_Retrieve()
	Case 3
		tp_revisao_devvenda.dw_revisao_devvenda.Event ue_Retrieve()
End Choose
end event

type tp_geral_dvv from userobject within tab_dev_venda
event create ( )
event destroy ( )
event ue_retrieve ( )
event ue_settipo ( long pl_tipo,  long pl_mostra )
integer x = 18
integer y = 100
integer width = 2537
integer height = 1308
boolean border = true
long backcolor = 79741120
string text = "Geral"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
cb_mostra_devvenda cb_mostra_devvenda
cb_tipo_devenda cb_tipo_devenda
st_18 st_18
st_17 st_17
st_16 st_16
st_15 st_15
st_14 st_14
st_13 st_13
spd_dev_venda spd_dev_venda
dw_dev_venda_regional dw_dev_venda_regional
gb_4 gb_4
ln_3 ln_3
end type

on tp_geral_dvv.create
this.cb_mostra_devvenda=create cb_mostra_devvenda
this.cb_tipo_devenda=create cb_tipo_devenda
this.st_18=create st_18
this.st_17=create st_17
this.st_16=create st_16
this.st_15=create st_15
this.st_14=create st_14
this.st_13=create st_13
this.spd_dev_venda=create spd_dev_venda
this.dw_dev_venda_regional=create dw_dev_venda_regional
this.gb_4=create gb_4
this.ln_3=create ln_3
this.Control[]={this.cb_mostra_devvenda,&
this.cb_tipo_devenda,&
this.st_18,&
this.st_17,&
this.st_16,&
this.st_15,&
this.st_14,&
this.st_13,&
this.spd_dev_venda,&
this.dw_dev_venda_regional,&
this.gb_4,&
this.ln_3}
end on

on tp_geral_dvv.destroy
destroy(this.cb_mostra_devvenda)
destroy(this.cb_tipo_devenda)
destroy(this.st_18)
destroy(this.st_17)
destroy(this.st_16)
destroy(this.st_15)
destroy(this.st_14)
destroy(this.st_13)
destroy(this.spd_dev_venda)
destroy(this.dw_dev_venda_regional)
destroy(this.gb_4)
destroy(this.ln_3)
end on

event ue_retrieve();Long lvl_Linha_Aux
Long lvl_Linha

Decimal{6} lvdc_Total
Decimal{6} lvdc_Total_2
Decimal{6} lvdc_Divisor
Decimal{2} lvdc_Percentual = 0.00

dw_dev_venda_regional.SetRedraw(False)
dw_dev_venda_regional.Reset( )

If ivds_resumo_estoque.RowCount() > 0 Then
	//Propor$$HEX2$$e700e300$$ENDHEX$$o Per$$HEX1$$ed00$$ENDHEX$$odo
	lvdc_Divisor = ivds_resumo_estoque.Object.cp_venda[1]
	If lvdc_Divisor > 0 Then
		lvdc_Total 	= ivds_resumo_estoque.Object.cp_dev_venda[1] / lvdc_Divisor
	Else
		lvdc_Total 	= 0.00
	End If
	//Propor$$HEX2$$e700e300$$ENDHEX$$o M$$HEX1$$e900$$ENDHEX$$dia
	lvdc_Divisor = ivds_resumo_estoque_2.Object.cp_venda[1]
	If lvdc_Divisor > 0 Then
		lvdc_Total_2= (ivds_resumo_estoque_2.Object.cp_dev_venda[1]) / lvdc_Divisor

		For lvl_Linha = 1 To ivds_resumo_estoque.RowCount()
			dw_dev_venda_regional.Event ue_AddRow()
			lvl_Linha_Aux = dw_dev_venda_regional.RowCount()
			dw_dev_venda_regional.Object.cd_regional 		[lvl_Linha_Aux] = ivds_resumo_estoque.Object.cd_regiao[lvl_Linha]
			dw_dev_venda_regional.Object.de_regional			[lvl_Linha_Aux] = ivds_resumo_estoque.Object.de_regiao[lvl_Linha]
			dw_dev_venda_regional.Object.qt_devolucao		[lvl_Linha_Aux] = ivds_resumo_estoque.Object.qt_cliente_devolucao[lvl_Linha]
			dw_dev_venda_regional.Object.vl_devolucao		[lvl_Linha_Aux] = ivds_resumo_estoque.Object.vl_devolucao_venda[lvl_Linha]
			dw_dev_venda_regional.Object.id_tipo 				[lvl_Linha_Aux] = 'Atual'
	
			dw_dev_venda_regional.Event ue_AddRow()
			dw_dev_venda_regional.Object.cd_regional			[lvl_Linha_Aux + 1] = ivds_resumo_estoque.Object.cd_regiao[lvl_Linha]
			dw_dev_venda_regional.Object.de_regional 		[lvl_Linha_Aux + 1] = ivds_resumo_estoque.Object.de_regiao[lvl_Linha]
			dw_dev_venda_regional.Object.qt_devolucao 		[lvl_Linha_Aux + 1] = ivds_resumo_estoque.Object.qt_cliente_devolucao[lvl_Linha]
			dw_dev_venda_regional.Object.vl_devolucao		[lvl_Linha_Aux + 1] = ivds_resumo_estoque.Object.vl_venda_liquida[lvl_Linha] * lvdc_Total_2
			dw_dev_venda_regional.Object.id_tipo 				[lvl_Linha_Aux + 1] = 'M$$HEX1$$e900$$ENDHEX$$dia'
		Next
	
		lvdc_Percentual = Round((lvdc_Total / lvdc_Total_2)*100,2)
	End If
End If

spd_dev_venda.of_setvalor(lvdc_Percentual)
Tab_1.tp_inicial.spd_ini_dev_venda.of_setvalor(lvdc_Percentual)

dw_dev_venda_regional.SetRedraw(True)
end event

event ue_settipo(long pl_tipo, long pl_mostra);//This.Event ue_Retrieve()
end event

type cb_mostra_devvenda from dropdownlistbox within tp_geral_dvv
integer x = 1865
integer y = 1156
integer width = 608
integer height = 236
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
string text = "Valor"
string item[] = {"Valor"}
borderstyle borderstyle = stylelowered!
end type

type cb_tipo_devenda from dropdownlistbox within tp_geral_dvv
integer x = 1865
integer y = 1064
integer width = 608
integer height = 236
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
string text = "Valor"
string item[] = {"Valor"}
borderstyle borderstyle = stylelowered!
end type

type st_18 from statictext within tp_geral_dvv
integer x = 1815
integer y = 600
integer width = 110
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 553648127
string text = "R = "
alignment alignment = center!
boolean focusrectangle = false
end type

type st_17 from statictext within tp_geral_dvv
integer x = 1925
integer y = 568
integer width = 549
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 553648127
string text = "( DvV / V )"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_16 from statictext within tp_geral_dvv
integer x = 1925
integer y = 648
integer width = 549
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 553648127
string text = "( DvV M / V M )"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_15 from statictext within tp_geral_dvv
integer x = 1879
integer y = 756
integer width = 558
integer height = 52
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "DvV = Dev. Venda"
boolean focusrectangle = false
end type

type st_14 from statictext within tp_geral_dvv
integer x = 1943
integer y = 820
integer width = 402
integer height = 52
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "V = Vendas"
boolean focusrectangle = false
end type

type st_13 from statictext within tp_geral_dvv
integer x = 1938
integer y = 880
integer width = 494
integer height = 52
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "M = M$$HEX1$$e900$$ENDHEX$$dia"
boolean focusrectangle = false
end type

type spd_dev_venda from uo_grafico_menor within tp_geral_dvv
integer x = 1815
integer y = 32
integer taborder = 40
boolean border = true
end type

on spd_dev_venda.destroy
call uo_grafico_menor::destroy
end on

type dw_dev_venda_regional from dc_uo_dw_base within tp_geral_dvv
integer x = 41
integer y = 32
integer width = 1751
integer height = 1236
integer taborder = 50
string dataobject = "dwg_ge278_regional_dev_venda"
boolean border = true
end type

type gb_4 from groupbox within tp_geral_dvv
integer x = 1810
integer y = 1000
integer width = 699
integer height = 272
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tipo An$$HEX1$$e100$$ENDHEX$$lise"
borderstyle borderstyle = stylebox!
end type

type ln_3 from line within tp_geral_dvv
integer linethickness = 4
integer beginx = 1966
integer beginy = 632
integer endx = 2418
integer endy = 632
end type

type tp_top_filiais_devv from userobject within tab_dev_venda
event ue_settipo ( long pl_tipo,  long pl_mostra )
integer x = 18
integer y = 100
integer width = 2537
integer height = 1308
long backcolor = 79741120
string text = "TOP 10 - Filiais"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_top_filiais_devv dw_top_filiais_devv
end type

on tp_top_filiais_devv.create
this.dw_top_filiais_devv=create dw_top_filiais_devv
this.Control[]={this.dw_top_filiais_devv}
end on

on tp_top_filiais_devv.destroy
destroy(this.dw_top_filiais_devv)
end on

type dw_top_filiais_devv from dc_uo_dw_base within tp_top_filiais_devv
integer x = 46
integer y = 36
integer width = 2455
integer height = 1236
integer taborder = 20
string dataobject = "dwg_ge278_top_filiais_dev_venda"
boolean border = true
end type

event ue_recuperar;//override
Datetime lvdt_Inicio
Datetime lvdt_Fim

dw_1.Accepttext( )

lvdt_Inicio = dw_1.Object.dt_inicio	[1]
lvdt_Fim	  = dw_1.Object.dt_fim	[1]

lvdt_Inicio = Datetime(Date(lvdt_Inicio),Time('00:00:00'))
lvdt_Fim	  = Datetime(Date(lvdt_Fim),Time('23:59:59'))

Return This.Retrieve(lvdt_Inicio,lvdt_Fim)
end event

type tp_revisao_devvenda from userobject within tab_dev_venda
integer x = 18
integer y = 100
integer width = 2537
integer height = 1308
long backcolor = 79741120
string text = "Revis$$HEX1$$e300$$ENDHEX$$o"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_revisao_devvenda dw_revisao_devvenda
gb_11 gb_11
end type

on tp_revisao_devvenda.create
this.dw_revisao_devvenda=create dw_revisao_devvenda
this.gb_11=create gb_11
this.Control[]={this.dw_revisao_devvenda,&
this.gb_11}
end on

on tp_revisao_devvenda.destroy
destroy(this.dw_revisao_devvenda)
destroy(this.gb_11)
end on

type dw_revisao_devvenda from dc_uo_dw_base within tp_revisao_devvenda
integer x = 41
integer y = 72
integer width = 2437
integer height = 1192
integer taborder = 40
string dataobject = "dw_ge278_revisao"
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.Of_setrowselection( )
end event

event rowfocuschanged;call super::rowfocuschanged;Datetime lvdh_Revisao

If CurrentRow > 0 Then
	This.Object.de_revisao_footer.Text	= This.Object.de_revisao	[CurrentRow]
	This.Object.nm_usuario_footer.Text	= This.Object.nm_usuario	[CurrentRow] + ' ('+String(This.Object.nr_matricula_revisao	[CurrentRow])+')'
	lvdh_Revisao								= This.Object.dh_revisao	[CurrentRow]
	If (Not IsNull(lvdh_Revisao)) and (lvdh_Revisao > Datetime('2015/01/01')) Then
		This.Object.dh_revisao_footer.Text	= String(lvdh_Revisao,'dd/mm/yyyy hh:mm')
	Else
		This.Object.dh_revisao_footer.Text	= ''
	End If
Else 
	This.Object.de_revisao_footer.Text 	= ''
	This.Object.nm_usuario_footer.Text	= ''
	This.Object.dh_revisao_footer.Text	= ''
End If
end event

event ue_recuperar;//override
Datetime lvdt_Inicio
Datetime lvdt_Fim

dw_1.Accepttext( )

lvdt_Inicio = dw_1.Object.dt_inicio	[1]
lvdt_Fim	  = dw_1.Object.dt_fim	[1]

lvdt_Inicio = Datetime(Date(lvdt_Inicio),Time('00:00:00'))
lvdt_Fim	  = Datetime(Date(lvdt_Fim),Time('23:59:59'))

Return This.Retrieve(lvdt_Inicio,lvdt_Fim)
end event

event ue_preretrieve;call super::ue_preretrieve;This.Of_appendwhere("m.id_analise='DVV'")

Return AncestorReturnValue
end event

type gb_11 from groupbox within tp_revisao_devvenda
integer x = 23
integer y = 8
integer width = 2482
integer height = 1272
integer taborder = 20
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

type cb_2 from commandbutton within tp_dev_venda
integer x = 1088
integer y = 1456
integer width = 402
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Detalhes"
end type

type tp_desc_venda from userobject within tab_1
event ue_retrieve ( )
event create ( )
event destroy ( )
integer x = 558
integer y = 16
integer width = 2592
integer height = 1572
boolean border = true
long backcolor = 79741120
string text = "Desc. Venda"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
tab_desc_venda tab_desc_venda
cb_detalha_desc cb_detalha_desc
end type

event ue_retrieve();Tab_Desc_Venda.SelectTab(1)
Tab_Desc_Venda.tp_geral_dsv.Event ue_Retrieve()
end event

on tp_desc_venda.create
this.tab_desc_venda=create tab_desc_venda
this.cb_detalha_desc=create cb_detalha_desc
this.Control[]={this.tab_desc_venda,&
this.cb_detalha_desc}
end on

on tp_desc_venda.destroy
destroy(this.tab_desc_venda)
destroy(this.cb_detalha_desc)
end on

type tab_desc_venda from tab within tp_desc_venda
event create ( )
event destroy ( )
event ue_settipo ( long pl_tipo,  long pl_mostra )
integer x = 5
integer y = 8
integer width = 2574
integer height = 1424
integer taborder = 10
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
tp_geral_dsv tp_geral_dsv
tp_top_desc_filiais tp_top_desc_filiais
tp_top_desc tp_top_desc
tp_revisao_descvenda tp_revisao_descvenda
end type

on tab_desc_venda.create
this.tp_geral_dsv=create tp_geral_dsv
this.tp_top_desc_filiais=create tp_top_desc_filiais
this.tp_top_desc=create tp_top_desc
this.tp_revisao_descvenda=create tp_revisao_descvenda
this.Control[]={this.tp_geral_dsv,&
this.tp_top_desc_filiais,&
this.tp_top_desc,&
this.tp_revisao_descvenda}
end on

on tab_desc_venda.destroy
destroy(this.tp_geral_dsv)
destroy(this.tp_top_desc_filiais)
destroy(this.tp_top_desc)
destroy(this.tp_revisao_descvenda)
end on

event ue_settipo(long pl_tipo, long pl_mostra);Tp_Geral_Dsv.Event ue_settipo(pl_tipo,pl_mostra)
Tp_Top_Desc_Filiais.Event ue_settipo(pl_tipo,pl_mostra)
end event

event selectionchanging;Long lvl_Tipo
Long lvl_Mostra

wf_get_tipo_desconto_venda(lvl_Tipo,lvl_Mostra)

Choose Case NewIndex
	Case 2 
		Choose Case lvl_Tipo
			Case 1
				tp_top_desc_filiais.dw_top_filial_desconto_qtde.Event ue_Retrieve()
			Case 2
				tp_top_desc_filiais.dw_top_filial_desconto.Event ue_Retrieve()
		End Choose
	Case 3
		tp_top_desc.dw_top20_desconto.Event ue_Retrieve()
	Case 4
		tp_revisao_descvenda.dw_revisao_descvenda.Event ue_Retrieve()
End Choose

//Desabilita fun$$HEX2$$e700e300$$ENDHEX$$o detalhes na aba de revis$$HEX1$$e300$$ENDHEX$$o
Parent.cb_detalha_desc.enabled = (NewIndex <> 4)
end event

type tp_geral_dsv from userobject within tab_desc_venda
event create ( )
event destroy ( )
event ue_retrieve ( )
event ue_settipo ( long pl_tipo,  long pl_mostra )
integer x = 18
integer y = 100
integer width = 2537
integer height = 1308
boolean border = true
long backcolor = 79741120
string text = "Geral"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_desc_venda_regional_perc dw_desc_venda_regional_perc
cb_tipo_descvenda cb_tipo_descvenda
cb_mostra_descvenda cb_mostra_descvenda
st_6 st_6
st_4 st_4
st_5 st_5
st_10 st_10
st_11 st_11
st_12 st_12
dw_desc_venda_regional dw_desc_venda_regional
spd_desc_venda spd_desc_venda
gb_3 gb_3
ln_2 ln_2
end type

on tp_geral_dsv.create
this.dw_desc_venda_regional_perc=create dw_desc_venda_regional_perc
this.cb_tipo_descvenda=create cb_tipo_descvenda
this.cb_mostra_descvenda=create cb_mostra_descvenda
this.st_6=create st_6
this.st_4=create st_4
this.st_5=create st_5
this.st_10=create st_10
this.st_11=create st_11
this.st_12=create st_12
this.dw_desc_venda_regional=create dw_desc_venda_regional
this.spd_desc_venda=create spd_desc_venda
this.gb_3=create gb_3
this.ln_2=create ln_2
this.Control[]={this.dw_desc_venda_regional_perc,&
this.cb_tipo_descvenda,&
this.cb_mostra_descvenda,&
this.st_6,&
this.st_4,&
this.st_5,&
this.st_10,&
this.st_11,&
this.st_12,&
this.dw_desc_venda_regional,&
this.spd_desc_venda,&
this.gb_3,&
this.ln_2}
end on

on tp_geral_dsv.destroy
destroy(this.dw_desc_venda_regional_perc)
destroy(this.cb_tipo_descvenda)
destroy(this.cb_mostra_descvenda)
destroy(this.st_6)
destroy(this.st_4)
destroy(this.st_5)
destroy(this.st_10)
destroy(this.st_11)
destroy(this.st_12)
destroy(this.dw_desc_venda_regional)
destroy(this.spd_desc_venda)
destroy(this.gb_3)
destroy(this.ln_2)
end on

event ue_retrieve();Decimal{6} lvdc_Total
Decimal{6} lvdc_Total_2
Decimal{2} lvdc_Percentual = 0.00

Long lvl_Tipo
Long lvl_Mostra

wf_get_tipo_desconto_venda(lvl_Tipo,lvl_Mostra)

Tab_1.tp_desc_venda.cb_detalha_desc.Enabled = False

Choose Case lvl_Tipo
	Case 1 //Gr$$HEX1$$e100$$ENDHEX$$ficos Por Quantidade
		If ivds_vendas.RowCount() > 0 Then
			//Propor$$HEX2$$e700e300$$ENDHEX$$o Atual
			lvdc_Total 		= ivds_vendas.Object.cp_qt_total_desc[1] / ivds_vendas.Object.cp_qt_total[1]
			//Proporc$$HEX1$$e300$$ENDHEX$$o M$$HEX1$$e900$$ENDHEX$$dia
			lvdc_Total_2	= (ivds_vendas_2.Object.cp_qt_total_desc[1]) /ivds_vendas_2.Object.cp_qt_total[1]

			If lvl_Mostra = 2 Then
				//Desabilita atualiza$$HEX2$$e700e300$$ENDHEX$$o gr$$HEX1$$e100$$ENDHEX$$fica da DW
				dw_desc_venda_regional.SetRedraw(False)
				//Limpa valores da DW
				dw_desc_venda_regional.Reset( )
				//Atualiza gr$$HEX1$$e100$$ENDHEX$$fico
				dw_desc_venda_regional.Event ue_Retrieve()
				//Habilita atualiza$$HEX2$$e700e300$$ENDHEX$$o gr$$HEX1$$e100$$ENDHEX$$fica da DW
				dw_desc_venda_regional.SetRedraw(True)
			Else
				//Desabilita atualiza$$HEX2$$e700e300$$ENDHEX$$o gr$$HEX1$$e100$$ENDHEX$$fica da DW
				dw_desc_venda_regional_perc.SetRedraw(False)
				//Limpa valores da DW
				dw_desc_venda_regional_perc.Reset( )
				//Atualiza gr$$HEX1$$e100$$ENDHEX$$fico
				dw_desc_venda_regional_perc.Event ue_Retrieve()
				//Habilita atualiza$$HEX2$$e700e300$$ENDHEX$$o gr$$HEX1$$e100$$ENDHEX$$fica da DW
				dw_desc_venda_regional_perc.SetRedraw(True)
			End If
			//Calcula percentual geral entre as propor$$HEX2$$e700f500$$ENDHEX$$es
			lvdc_Percentual = Round((lvdc_Total / lvdc_Total_2)*100,2)
			//Habilita bot$$HEX1$$e300$$ENDHEX$$o de detalhamento
			Tab_1.tp_desc_venda.cb_detalha_desc.Enabled = True
			//Nomeia o eixo Y do gr$$HEX1$$e100$$ENDHEX$$fico com os valores mostrados
			dw_desc_venda_regional_perc.Object.gr_1.Values.Label	='Qtde Descontos (%)'
			dw_desc_venda_regional.Object.gr_1.Values.Label		='Qtde Descontos'
		End If
	Case 2 //Gr$$HEX1$$e100$$ENDHEX$$ficos por Valor
		If ivds_resumo_estoque.RowCount() > 0 Then
			//Propor$$HEX2$$e700e300$$ENDHEX$$o Atual
			lvdc_Total 		= ivds_resumo_estoque.Object.cp_total_desconto[1] / ivds_resumo_estoque.Object.cp_venda[1]
			//Proporc$$HEX1$$e300$$ENDHEX$$o M$$HEX1$$e900$$ENDHEX$$dia
			lvdc_Total_2	= (ivds_resumo_estoque_2.Object.cp_total_desconto[1]) /ivds_resumo_estoque_2.Object.cp_venda[1]

			If lvl_Mostra = 2 Then
				//Desabilita atualiza$$HEX2$$e700e300$$ENDHEX$$o gr$$HEX1$$e100$$ENDHEX$$fica da DW
				dw_desc_venda_regional.SetRedraw(False)
				//Limpa valores da DW
				dw_desc_venda_regional.Reset( )
				//Atualiza gr$$HEX1$$e100$$ENDHEX$$fico
				dw_desc_venda_regional.Event ue_Retrieve()
				//Habilita atualiza$$HEX2$$e700e300$$ENDHEX$$o gr$$HEX1$$e100$$ENDHEX$$fica da DW
				dw_desc_venda_regional.SetRedraw(True)
			Else
				//Desabilita atualiza$$HEX2$$e700e300$$ENDHEX$$o gr$$HEX1$$e100$$ENDHEX$$fica da DW
				dw_desc_venda_regional_perc.SetRedraw(False)
				//Limpa valores da DW
				dw_desc_venda_regional_perc.Reset( )
				//Atualiza gr$$HEX1$$e100$$ENDHEX$$fico
				dw_desc_venda_regional_perc.Event ue_Retrieve()
				//Habilita atualiza$$HEX2$$e700e300$$ENDHEX$$o gr$$HEX1$$e100$$ENDHEX$$fica da DW
				dw_desc_venda_regional_perc.SetRedraw(True)
			End If
			//Calcula percentual geral entre as propor$$HEX2$$e700f500$$ENDHEX$$es
			lvdc_Percentual = Round((lvdc_Total / lvdc_Total_2)*100,2)
			//Habilita bot$$HEX1$$e300$$ENDHEX$$o de detalhamento
			Tab_1.tp_desc_venda.cb_detalha_desc.Enabled = True
			//Nomeia o eixo Y do gr$$HEX1$$e100$$ENDHEX$$fico com os valores mostrados
			dw_desc_venda_regional_perc.Object.gr_1.Values.Label	='Valor Descontos (%)'
			dw_desc_venda_regional.Object.gr_1.Values.Label		='Valor Descontos (R$)'
		End If
End Choose

//Atualiza ponteiro do gr$$HEX1$$e100$$ENDHEX$$fico na tela atual
spd_desc_venda.of_setvalor(lvdc_Percentual)
//Atualiza ponteiro do gr$$HEX1$$e100$$ENDHEX$$fico na tela inicial
Tab_1.tp_inicial.spd_ini_desc.of_setvalor(lvdc_Percentual)
end event

event ue_settipo(long pl_tipo, long pl_mostra);This.Event ue_Retrieve()

dw_desc_venda_regional.Visible			= (pl_mostra = 2)
dw_desc_venda_regional_perc.Visible	= (pl_mostra = 1)

If cb_tipo_descvenda.Text  <> cb_tipo_descvenda.Text(pl_tipo) Then
	cb_tipo_descvenda.SelectItem(pl_tipo)
End If

If cb_mostra_descvenda.Text  <> cb_mostra_descvenda.Text(pl_mostra) Then
	cb_mostra_descvenda.SelectItem(pl_mostra)
End If
end event

type dw_desc_venda_regional_perc from dc_uo_dw_base within tp_geral_dsv
integer x = 41
integer y = 32
integer width = 1751
integer height = 1236
integer taborder = 30
string dataobject = "dwg_ge278_regional_desconto_perc"
boolean border = true
end type

event ue_recuperar;//override
Long lvl_Linha
Long lvl_Regiao
Long lvl_Find
Long lvl_Qtde_Desc
Long lvl_Qtde_Venda
Long lvl_Tipo
Long lvl_Mostra

Decimal{2} lvdc_Desc
Decimal{2} lvdc_Venda
Decimal{2} lvdc_Pc_Regional = 0.00

This.SetRedraw(False)
This.Reset()

wf_get_tipo_desconto_venda(lvl_Tipo,lvl_Mostra)

//Preenche dados do gr$$HEX1$$e100$$ENDHEX$$fico por Regional
For lvl_Linha = 1 To ivds_regiao.RowCount() 
	lvdc_Pc_Regional = 0.00
	lvl_Regiao = ivds_regiao.Object.cd_regiao[lvl_Linha]
	lvl_Find = ivds_resumo_estoque.Find('cd_regiao='+String(lvl_Regiao), 1, ivds_resumo_estoque.RowCount())
	If lvl_Find > 0 Then
		lvdc_Venda		= ivds_resumo_estoque.Object.vl_venda_liquida		[lvl_Find]
		lvdc_Desc		= ivds_resumo_estoque.Object.vl_venda_desconto	[lvl_Find]
		lvl_Find 			= ivds_vendas.Find('cd_regiao='+String(lvl_Regiao), 1, ivds_vendas.RowCount())
		If lvl_Find > 0 Then
			lvl_Qtde_Desc	= ivds_vendas.Object.qt_desc	[lvl_Find]
			lvl_Qtde_Venda	= ivds_vendas.Object.qt_total	[lvl_Find]
			
			Choose Case lvl_Tipo
				Case 1
					If lvl_Qtde_Venda > 0 Then
						lvdc_Pc_Regional = (lvl_Qtde_Desc / lvl_Qtde_Venda) * 100
					End If
				Case 2
					If lvdc_Venda > 0 Then
						lvdc_Pc_Regional = (lvdc_Desc / lvdc_Venda) * 100
					End If
			End Choose
		End If
	End If
	
	This.Event ue_AddRow()
	This.Object.cd_regional 		[lvl_Linha] = lvl_Regiao
	This.Object.de_regional		[lvl_Linha] = ivds_regiao.Object.de_regiao[lvl_Linha]			
	This.Object.pc_desconto		[lvl_Linha] = lvdc_Pc_Regional
Next

This.SetRedraw(True)

If ivds_vendas_canc.RowCount() > 0 Then
	Tab_1.tp_desc_venda.cb_detalha_desc.Enabled = True
End If

Return This.RowCount()
end event

type cb_tipo_descvenda from dropdownlistbox within tp_geral_dsv
integer x = 1865
integer y = 1064
integer width = 608
integer height = 236
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
string text = "Valor"
string item[] = {"Quantidade","Valor"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;Long lvl_Mostra
Long lvl_Tipo

wf_get_tipo_desconto_venda(lvl_Tipo,lvl_Mostra)

Tab_1.Tp_Desc_Venda.Tab_Desc_Venda.Event ue_settipo(Index,lvl_Mostra)
end event

type cb_mostra_descvenda from dropdownlistbox within tp_geral_dsv
integer x = 1865
integer y = 1156
integer width = 608
integer height = 236
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
string text = "Valor"
string item[] = {"Percentual","Valor"}
borderstyle borderstyle = stylelowered!
end type

event selectionchanged;Long lvl_Mostra
Long lvl_Tipo

wf_get_tipo_desconto_venda(lvl_Tipo,lvl_Mostra)

Tab_1.Tp_Desc_Venda.Tab_Desc_Venda.Event ue_settipo(lvl_Tipo,Index)
end event

type st_6 from statictext within tp_geral_dsv
integer x = 1815
integer y = 592
integer width = 110
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 553648127
string text = "R = "
alignment alignment = center!
boolean focusrectangle = false
end type

type st_4 from statictext within tp_geral_dsv
integer x = 1929
integer y = 560
integer width = 526
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 553648127
string text = "( DsV / V )"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_5 from statictext within tp_geral_dsv
integer x = 1938
integer y = 644
integer width = 526
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 553648127
string text = "( DsV M / V M )"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_10 from statictext within tp_geral_dsv
integer x = 1879
integer y = 756
integer width = 558
integer height = 52
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "DsV = Desc. Venda"
boolean focusrectangle = false
end type

type st_11 from statictext within tp_geral_dsv
integer x = 1943
integer y = 820
integer width = 402
integer height = 52
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "V = Vendas"
boolean focusrectangle = false
end type

type st_12 from statictext within tp_geral_dsv
integer x = 1938
integer y = 880
integer width = 494
integer height = 52
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "M = M$$HEX1$$e900$$ENDHEX$$dia"
boolean focusrectangle = false
end type

type dw_desc_venda_regional from dc_uo_dw_base within tp_geral_dsv
integer x = 41
integer y = 32
integer width = 1751
integer height = 1236
integer taborder = 40
string dataobject = "dwg_ge278_regional_desconto"
boolean border = true
end type

event ue_recuperar;call super::ue_recuperar;Decimal{8} lvdc_Media			= 0.00
Decimal{8} lvdc_Media_Qtde 	= 0.00

Long lvl_Linha
Long lvl_Linha_Aux
Long lvl_Find
Long lvl_Tipo
Long lvl_Mostra
Long lvl_Regiao

//Retorna valores do combo
wf_get_tipo_desconto_venda(lvl_Tipo,lvl_Mostra)

If ivds_vendas_2.RowCount()>0 Then	
	lvdc_Media_Qtde 	= ivds_vendas_2.Object.cp_qt_total_desc	[1] / ivds_vendas_2.Object.cp_qt_total	[1]
	lvdc_Media			= ivds_vendas_2.Object.cp_vl_total_desc	[1] / ivds_vendas_2.Object.cp_vl_total	[1]
End If

Choose Case lvl_Tipo
	Case 1
		This.Object.gr_1.Values="sum(qt_desconto for graph)"
		This.Object.gr_1.Values.Dispattr.Format="#,##0"
	Case 2
		This.Object.gr_1.Values="sum(vl_desconto for graph)"
		This.Object.gr_1.Values.Dispattr.Format="#,##0.00"
End Choose

For lvl_Linha = 1 To ivds_regiao.RowCount()
	lvl_Regiao = ivds_regiao.Object.cd_regiao	[lvl_Linha]
	
	lvl_Find = ivds_vendas.Find("cd_regiao="+String(lvl_Regiao),1,ivds_vendas.RowCount())
	If lvl_Find > 0 Then
		This.Event ue_AddRow()
		lvl_Linha_Aux = This.RowCount()
		This.Object.cd_regional 	[lvl_Linha_Aux] = lvl_Regiao
		This.Object.de_regional	[lvl_Linha_Aux] = ivds_regiao.Object.de_regiao	[lvl_Linha]
		This.Object.vl_desconto	[lvl_Linha_Aux] = ivds_vendas.Object.vl_desconto	[lvl_Linha]
		This.Object.qt_desconto	[lvl_Linha_Aux] = ivds_vendas.Object.qt_desc		[lvl_Linha]
		This.Object.id_tipo 		[lvl_Linha_Aux] = 'Atual'
	
		This.Event ue_AddRow()
		This.Object.cd_regional	[lvl_Linha_Aux + 1] = lvl_Regiao
		This.Object.de_regional 	[lvl_Linha_Aux + 1] = ivds_regiao.Object.de_regiao	[lvl_Linha]
		This.Object.vl_desconto	[lvl_Linha_Aux + 1] = ivds_vendas.Object.vl_total		[lvl_Linha] * lvdc_Media
		This.Object.qt_desconto	[lvl_Linha_Aux + 1] = ivds_vendas.Object.qt_total		[lvl_Linha] * lvdc_Media_Qtde
		This.Object.id_tipo 		[lvl_Linha_Aux + 1] = 'M$$HEX1$$e900$$ENDHEX$$dia'
	End If
Next
	
Return This.RowCount()
end event

type spd_desc_venda from uo_grafico_menor within tp_geral_dsv
event destroy ( )
integer x = 1815
integer y = 32
integer taborder = 50
boolean border = true
end type

on spd_desc_venda.destroy
call uo_grafico_menor::destroy
end on

type gb_3 from groupbox within tp_geral_dsv
integer x = 1810
integer y = 1000
integer width = 699
integer height = 272
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tipo An$$HEX1$$e100$$ENDHEX$$lise"
borderstyle borderstyle = stylebox!
end type

type ln_2 from line within tp_geral_dsv
integer linethickness = 4
integer beginx = 1961
integer beginy = 624
integer endx = 2414
integer endy = 624
end type

type tp_top_desc_filiais from userobject within tab_desc_venda
event ue_settipo ( long pl_tipo,  long pl_mostra )
integer x = 18
integer y = 100
integer width = 2537
integer height = 1308
boolean border = true
long backcolor = 79741120
string text = "TOP 10 - Filiais"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_top_filial_desconto_qtde dw_top_filial_desconto_qtde
dw_top_filial_desconto dw_top_filial_desconto
end type

event ue_settipo(long pl_tipo, long pl_mostra);dw_top_filial_desconto_qtde.visible	= (pl_tipo = 1)
dw_top_filial_desconto.visible			= (pl_tipo = 2)
end event

on tp_top_desc_filiais.create
this.dw_top_filial_desconto_qtde=create dw_top_filial_desconto_qtde
this.dw_top_filial_desconto=create dw_top_filial_desconto
this.Control[]={this.dw_top_filial_desconto_qtde,&
this.dw_top_filial_desconto}
end on

on tp_top_desc_filiais.destroy
destroy(this.dw_top_filial_desconto_qtde)
destroy(this.dw_top_filial_desconto)
end on

type dw_top_filial_desconto_qtde from dc_uo_dw_base within tp_top_desc_filiais
integer x = 41
integer y = 32
integer width = 2437
integer height = 1236
integer taborder = 40
string dataobject = "dwg_ge278_top_filiais_desconto_qtde"
boolean border = true
end type

event ue_recuperar;//override
Datetime lvdt_Inicio
Datetime lvdt_Fim

dw_1.Accepttext( )

lvdt_Inicio = dw_1.Object.dt_inicio	[1]
lvdt_Fim	  = dw_1.Object.dt_fim	[1]

lvdt_Inicio = Datetime(Date(lvdt_Inicio),Time('00:00:00'))
lvdt_Fim	  = Datetime(Date(lvdt_Fim),Time('23:59:59'))

Return This.Retrieve(lvdt_Inicio,lvdt_Fim)
end event

type dw_top_filial_desconto from dc_uo_dw_base within tp_top_desc_filiais
integer x = 41
integer y = 32
integer width = 2437
integer height = 1236
integer taborder = 20
string dataobject = "dwg_ge278_top_filiais_desconto"
boolean border = true
end type

event ue_recuperar;//override
Datetime lvdt_Inicio
Datetime lvdt_Fim

dw_1.Accepttext( )

lvdt_Inicio = dw_1.Object.dt_inicio	[1]
lvdt_Fim	  = dw_1.Object.dt_fim	[1]

lvdt_Inicio = Datetime(Date(lvdt_Inicio),Time('00:00:00'))
lvdt_Fim	  = Datetime(Date(lvdt_Fim),Time('23:59:59'))

Return This.Retrieve(lvdt_Inicio,lvdt_Fim)
end event

type tp_top_desc from userobject within tab_desc_venda
integer x = 18
integer y = 100
integer width = 2537
integer height = 1308
long backcolor = 79741120
string text = "TOP 20 - Descontos"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_top20_desconto dw_top20_desconto
gb_8 gb_8
end type

on tp_top_desc.create
this.dw_top20_desconto=create dw_top20_desconto
this.gb_8=create gb_8
this.Control[]={this.dw_top20_desconto,&
this.gb_8}
end on

on tp_top_desc.destroy
destroy(this.dw_top20_desconto)
destroy(this.gb_8)
end on

type dw_top20_desconto from dc_uo_dw_base within tp_top_desc
integer x = 46
integer y = 64
integer width = 2423
integer height = 1176
integer taborder = 30
string dataobject = "dw_ge278_top20_descontos"
boolean hscrollbar = true
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
end type

event ue_retrieve;//override
Datetime lvdt_Inicio
Datetime lvdt_Fim

dw_1.Accepttext( )

lvdt_Inicio = dw_1.Object.dt_inicio	[1]
lvdt_Fim	  = dw_1.Object.dt_fim	[1]

lvdt_Inicio = Datetime(Date(lvdt_Inicio),Time('00:00:00'))
lvdt_Fim	  = Datetime(Date(lvdt_Fim),Time('23:59:59'))

Return This.Retrieve(lvdt_Inicio,lvdt_Fim)
end event

event constructor;call super::constructor;This.of_SetRowSelection( )
end event

type gb_8 from groupbox within tp_top_desc
integer x = 23
integer y = 8
integer width = 2482
integer height = 1272
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
borderstyle borderstyle = stylebox!
end type

type tp_revisao_descvenda from userobject within tab_desc_venda
integer x = 18
integer y = 100
integer width = 2537
integer height = 1308
long backcolor = 79741120
string text = "Revis$$HEX1$$e300$$ENDHEX$$o"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_revisao_descvenda dw_revisao_descvenda
gb_9 gb_9
end type

on tp_revisao_descvenda.create
this.dw_revisao_descvenda=create dw_revisao_descvenda
this.gb_9=create gb_9
this.Control[]={this.dw_revisao_descvenda,&
this.gb_9}
end on

on tp_revisao_descvenda.destroy
destroy(this.dw_revisao_descvenda)
destroy(this.gb_9)
end on

type dw_revisao_descvenda from dc_uo_dw_base within tp_revisao_descvenda
integer x = 41
integer y = 72
integer width = 2437
integer height = 1192
integer taborder = 20
string dataobject = "dw_ge278_revisao"
boolean vscrollbar = true
end type

event rowfocuschanged;call super::rowfocuschanged;Datetime lvdh_Revisao

If CurrentRow > 0 Then
	This.Object.de_revisao_footer.Text	= This.Object.de_revisao	[CurrentRow]
	This.Object.nm_usuario_footer.Text	= This.Object.nm_usuario	[CurrentRow] + ' ('+String(This.Object.nr_matricula_revisao	[CurrentRow])+')'
	lvdh_Revisao								= This.Object.dh_revisao	[CurrentRow]
	If (Not IsNull(lvdh_Revisao)) and (lvdh_Revisao > Datetime('2015/01/01')) Then
		This.Object.dh_revisao_footer.Text	= String(lvdh_Revisao,'dd/mm/yyyy hh:mm')
	Else
		This.Object.dh_revisao_footer.Text	= ''
	End If
Else 
	This.Object.de_revisao_footer.Text 	= ''
	This.Object.nm_usuario_footer.Text	= ''
	This.Object.dh_revisao_footer.Text	= ''
End If
end event

event ue_preretrieve;call super::ue_preretrieve;This.Of_appendwhere("m.id_analise='DSV'")

Return AncestorReturnValue
end event

event constructor;call super::constructor;This.Of_setrowselection( )
end event

event ue_recuperar;//override
Datetime lvdt_Inicio
Datetime lvdt_Fim

dw_1.Accepttext( )

lvdt_Inicio = dw_1.Object.dt_inicio	[1]
lvdt_Fim	  = dw_1.Object.dt_fim	[1]

lvdt_Inicio = Datetime(Date(lvdt_Inicio),Time('00:00:00'))
lvdt_Fim	  = Datetime(Date(lvdt_Fim),Time('23:59:59'))

Return This.Retrieve(lvdt_Inicio,lvdt_Fim)
end event

type gb_9 from groupbox within tp_revisao_descvenda
integer x = 23
integer y = 8
integer width = 2482
integer height = 1272
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

type cb_detalha_desc from commandbutton within tp_desc_venda
integer x = 1083
integer y = 1452
integer width = 402
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Detalhes"
end type

event clicked;//override
Datetime lvdt_Inicio
Datetime lvdt_Fim

String lvs_Param

dw_1.Accepttext( )

lvdt_Inicio = dw_1.Object.dt_inicio	[1]
lvdt_Fim	  = dw_1.Object.dt_fim	[1]

lvs_Param = String(lvdt_Inicio,'dd/mm/yyyy')+';'+String(lvdt_Fim,'dd/mm/yyyy')

If Tab_1.tp_desc_venda.tab_desc_venda.SelectedTab = 3 Then
	OpenSheetWithParm(w_ge277_consulta_desc_comercial,lvs_Param,dc_w_MDI)
Else
	OpenSheetWithParm(w_ge276_consulta_desconto_venda,lvs_Param,dc_w_MDI)
End If
end event

type tp_dev_compra from userobject within tab_1
event ue_retrieve ( )
integer x = 558
integer y = 16
integer width = 2592
integer height = 1572
boolean border = true
long backcolor = 79741120
string text = "Dev. Compra"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
tab_dev_compra tab_dev_compra
cb_3 cb_3
end type

event ue_retrieve();Tab_Dev_Compra.selecttab(1)
Tab_Dev_Compra.tp_geral_dcp.Event ue_Retrieve()
end event

on tp_dev_compra.create
this.tab_dev_compra=create tab_dev_compra
this.cb_3=create cb_3
this.Control[]={this.tab_dev_compra,&
this.cb_3}
end on

on tp_dev_compra.destroy
destroy(this.tab_dev_compra)
destroy(this.cb_3)
end on

type tab_dev_compra from tab within tp_dev_compra
event create ( )
event destroy ( )
event ue_settipo ( long pl_tipo,  long pl_mostra )
integer x = 5
integer y = 8
integer width = 2574
integer height = 1424
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
tp_geral_dcp tp_geral_dcp
tp_top_filial_dev_compra tp_top_filial_dev_compra
tp_top_forn_devolucao tp_top_forn_devolucao
tp_revisao_devcompra tp_revisao_devcompra
end type

on tab_dev_compra.create
this.tp_geral_dcp=create tp_geral_dcp
this.tp_top_filial_dev_compra=create tp_top_filial_dev_compra
this.tp_top_forn_devolucao=create tp_top_forn_devolucao
this.tp_revisao_devcompra=create tp_revisao_devcompra
this.Control[]={this.tp_geral_dcp,&
this.tp_top_filial_dev_compra,&
this.tp_top_forn_devolucao,&
this.tp_revisao_devcompra}
end on

on tab_dev_compra.destroy
destroy(this.tp_geral_dcp)
destroy(this.tp_top_filial_dev_compra)
destroy(this.tp_top_forn_devolucao)
destroy(this.tp_revisao_devcompra)
end on

event ue_settipo(long pl_tipo, long pl_mostra);Tp_Geral_Dcp.Event ue_SetTipo(pl_Tipo,pl_Mostra)
Tp_Top_Filial_Dev_Compra.Event ue_SetTipo(pl_Tipo,pl_Mostra)
Tp_Top_Forn_Devolucao.Event ue_SetTipo(pl_Tipo,pl_Mostra)
end event

event selectionchanged;Choose Case NewIndex
	Case 2 
		tp_top_filial_dev_compra.dw_top_filiais_dev_compra.Event ue_Retrieve()
	Case 3
		tp_top_forn_devolucao.dw_top_forn_devolucao.Event ue_Retrieve()
	Case 4
		tp_revisao_devcompra.dw_revisao_devcompra.Event ue_Retrieve()
End Choose
end event

type tp_geral_dcp from userobject within tab_dev_compra
event create ( )
event destroy ( )
event ue_retrieve ( )
event ue_settipo ( long pl_tipo,  long pl_mostra )
integer x = 18
integer y = 100
integer width = 2537
integer height = 1308
boolean border = true
long backcolor = 79741120
string text = "Geral"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
cb_tipo_devcompra cb_tipo_devcompra
cb_mostra_devcompra cb_mostra_devcompra
dw_dev_compra_regional dw_dev_compra_regional
sped_dev_compra sped_dev_compra
st_2 st_2
st_1 st_1
st_3 st_3
st_7 st_7
st_9 st_9
st_8 st_8
gb_5 gb_5
ln_1 ln_1
end type

on tp_geral_dcp.create
this.cb_tipo_devcompra=create cb_tipo_devcompra
this.cb_mostra_devcompra=create cb_mostra_devcompra
this.dw_dev_compra_regional=create dw_dev_compra_regional
this.sped_dev_compra=create sped_dev_compra
this.st_2=create st_2
this.st_1=create st_1
this.st_3=create st_3
this.st_7=create st_7
this.st_9=create st_9
this.st_8=create st_8
this.gb_5=create gb_5
this.ln_1=create ln_1
this.Control[]={this.cb_tipo_devcompra,&
this.cb_mostra_devcompra,&
this.dw_dev_compra_regional,&
this.sped_dev_compra,&
this.st_2,&
this.st_1,&
this.st_3,&
this.st_7,&
this.st_9,&
this.st_8,&
this.gb_5,&
this.ln_1}
end on

on tp_geral_dcp.destroy
destroy(this.cb_tipo_devcompra)
destroy(this.cb_mostra_devcompra)
destroy(this.dw_dev_compra_regional)
destroy(this.sped_dev_compra)
destroy(this.st_2)
destroy(this.st_1)
destroy(this.st_3)
destroy(this.st_7)
destroy(this.st_9)
destroy(this.st_8)
destroy(this.gb_5)
destroy(this.ln_1)
end on

event ue_retrieve();Long lvl_Linha_Aux
Long lvl_Linha

Decimal{8} lvdc_Total
Decimal{8} lvdc_Total_2
Decimal{2} lvdc_Devolucao
Decimal{2} lvdc_Percentual = 0.00

dw_dev_compra_regional.SetRedraw(False)
dw_dev_compra_regional.Reset( )

If ivds_resumo_estoque.RowCount() > 0 Then
	lvdc_Total 		= ivds_resumo_estoque.Object.cp_dev_compra[1] / ivds_resumo_estoque.Object.cp_compra[1]
	
	//M$$HEX1$$e900$$ENDHEX$$dia Proporcional
	lvdc_Total_2	= (ivds_resumo_estoque_2.Object.cp_dev_compra[1]) / ivds_resumo_estoque_2.Object.cp_compra[1]
	
	If (lvdc_Total_2 > 0) Then
		For lvl_Linha = 1 To ivds_resumo_estoque.RowCount()
			lvdc_Devolucao = ivds_resumo_estoque.Object.vl_devolucao_compra[lvl_Linha]
			If lvdc_Devolucao = 0 Then Continue
			
			dw_dev_compra_regional.Event ue_AddRow()
			lvl_Linha_Aux = dw_dev_compra_regional.RowCount()
			dw_dev_compra_regional.Object.cd_regional 	[lvl_Linha_Aux] = ivds_resumo_estoque.Object.cd_regiao[lvl_Linha]
			dw_dev_compra_regional.Object.de_regional	[lvl_Linha_Aux] = ivds_resumo_estoque.Object.de_regiao[lvl_Linha]
			dw_dev_compra_regional.Object.vl_devolucao	[lvl_Linha_Aux] = lvdc_Devolucao
			dw_dev_compra_regional.Object.id_tipo 		[lvl_Linha_Aux] = 'Atual'
	
			dw_dev_compra_regional.Event ue_AddRow()
			dw_dev_compra_regional.Object.cd_regional	[lvl_Linha_Aux + 1] = ivds_resumo_estoque.Object.cd_regiao[lvl_Linha]
			dw_dev_compra_regional.Object.de_regional 	[lvl_Linha_Aux + 1] = ivds_resumo_estoque.Object.de_regiao[lvl_Linha]
			dw_dev_compra_regional.Object.vl_devolucao	[lvl_Linha_Aux + 1] = ivds_resumo_estoque.Object.vl_compra[lvl_Linha] * lvdc_Total_2
			dw_dev_compra_regional.Object.id_tipo 		[lvl_Linha_Aux + 1] = 'M$$HEX1$$e900$$ENDHEX$$dia'
		Next

		lvdc_Percentual = Round((lvdc_Total / lvdc_Total_2)*100,2)
	End If
End If

sped_dev_compra.of_setvalor(lvdc_Percentual)
Tab_1.tp_inicial.spd_ini_dev_compra.of_setvalor(lvdc_Percentual)
	
dw_dev_compra_regional.SetRedraw(True)
end event

type cb_tipo_devcompra from dropdownlistbox within tp_geral_dcp
integer x = 1865
integer y = 1064
integer width = 608
integer height = 236
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
string text = "Valor"
string item[] = {"Valor"}
borderstyle borderstyle = stylelowered!
end type

type cb_mostra_devcompra from dropdownlistbox within tp_geral_dcp
integer x = 1865
integer y = 1156
integer width = 608
integer height = 236
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
string text = "Valor"
string item[] = {"Valor"}
borderstyle borderstyle = stylelowered!
end type

type dw_dev_compra_regional from dc_uo_dw_base within tp_geral_dcp
integer x = 41
integer y = 32
integer width = 1751
integer height = 1236
integer taborder = 40
string dataobject = "dwg_ge278_regional_dev_compra"
boolean border = true
end type

type sped_dev_compra from uo_grafico_menor within tp_geral_dcp
event destroy ( )
integer x = 1815
integer y = 32
integer taborder = 30
boolean border = true
end type

on sped_dev_compra.destroy
call uo_grafico_menor::destroy
end on

type st_2 from statictext within tp_geral_dcp
integer x = 1815
integer y = 592
integer width = 110
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 553648127
string text = "R = "
alignment alignment = center!
boolean focusrectangle = false
end type

type st_1 from statictext within tp_geral_dcp
integer x = 1934
integer y = 564
integer width = 485
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 553648127
string text = "( DCp / Cp )"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_3 from statictext within tp_geral_dcp
integer x = 1934
integer y = 648
integer width = 485
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 553648127
string text = "( DCp M / Cp M )"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_7 from statictext within tp_geral_dcp
integer x = 1879
integer y = 740
integer width = 558
integer height = 52
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "DCp = Dev. Compra"
boolean focusrectangle = false
end type

type st_9 from statictext within tp_geral_dcp
integer x = 1915
integer y = 804
integer width = 402
integer height = 52
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "Cp = Compras"
boolean focusrectangle = false
end type

type st_8 from statictext within tp_geral_dcp
integer x = 1938
integer y = 864
integer width = 494
integer height = 52
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "M = M$$HEX1$$e900$$ENDHEX$$dia"
boolean focusrectangle = false
end type

type gb_5 from groupbox within tp_geral_dcp
integer x = 1810
integer y = 1000
integer width = 699
integer height = 272
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tipo An$$HEX1$$e100$$ENDHEX$$lise"
borderstyle borderstyle = stylebox!
end type

type ln_1 from line within tp_geral_dcp
integer linethickness = 4
integer beginx = 1947
integer beginy = 632
integer endx = 2400
integer endy = 632
end type

type tp_top_filial_dev_compra from userobject within tab_dev_compra
event ue_settipo ( long pl_tipo,  long pl_mostra )
integer x = 18
integer y = 100
integer width = 2537
integer height = 1308
long backcolor = 79741120
string text = "TOP 10 - Filiais"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_top_filiais_dev_compra dw_top_filiais_dev_compra
end type

on tp_top_filial_dev_compra.create
this.dw_top_filiais_dev_compra=create dw_top_filiais_dev_compra
this.Control[]={this.dw_top_filiais_dev_compra}
end on

on tp_top_filial_dev_compra.destroy
destroy(this.dw_top_filiais_dev_compra)
end on

type dw_top_filiais_dev_compra from dc_uo_dw_base within tp_top_filial_dev_compra
integer x = 46
integer y = 36
integer width = 2455
integer height = 1236
integer taborder = 20
string dataobject = "dwg_ge278_top_filiais_dev_compra"
boolean border = true
end type

event ue_recuperar;//override
Datetime lvdt_Inicio
Datetime lvdt_Fim

dw_1.Accepttext( )

lvdt_Inicio = dw_1.Object.dt_inicio	[1]
lvdt_Fim	  = dw_1.Object.dt_fim	[1]

lvdt_Inicio = Datetime(Date(lvdt_Inicio),Time('00:00:00'))
lvdt_Fim	  = Datetime(Date(lvdt_Fim),Time('23:59:59'))

Return This.Retrieve(lvdt_Inicio,lvdt_Fim)
end event

type tp_top_forn_devolucao from userobject within tab_dev_compra
event ue_retrieve ( )
event ue_settipo ( long pl_tipo,  long pl_mostra )
integer x = 18
integer y = 100
integer width = 2537
integer height = 1308
long backcolor = 79741120
string text = "TOP 10 - Fornecedores"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_top_forn_devolucao dw_top_forn_devolucao
end type

on tp_top_forn_devolucao.create
this.dw_top_forn_devolucao=create dw_top_forn_devolucao
this.Control[]={this.dw_top_forn_devolucao}
end on

on tp_top_forn_devolucao.destroy
destroy(this.dw_top_forn_devolucao)
end on

type dw_top_forn_devolucao from dc_uo_dw_base within tp_top_forn_devolucao
integer x = 37
integer y = 32
integer width = 2464
integer height = 1248
integer taborder = 20
string dataobject = "dwg_ge278_top_fornecedor_devolucao"
boolean border = true
end type

event ue_recuperar;//override
Datetime lvdt_Inicio
Datetime lvdt_Fim

dw_1.Accepttext( )

lvdt_Inicio = dw_1.Object.dt_inicio	[1]
lvdt_Fim	  = dw_1.Object.dt_fim	[1]

lvdt_Inicio = Datetime(Date(lvdt_Inicio),Time('00:00:00'))
lvdt_Fim	  = Datetime(Date(lvdt_Fim),Time('23:59:59'))

Return This.Retrieve(lvdt_Inicio,lvdt_Fim)
end event

type tp_revisao_devcompra from userobject within tab_dev_compra
integer x = 18
integer y = 100
integer width = 2537
integer height = 1308
long backcolor = 79741120
string text = "Revis$$HEX1$$e300$$ENDHEX$$o"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_revisao_devcompra dw_revisao_devcompra
gb_12 gb_12
end type

on tp_revisao_devcompra.create
this.dw_revisao_devcompra=create dw_revisao_devcompra
this.gb_12=create gb_12
this.Control[]={this.dw_revisao_devcompra,&
this.gb_12}
end on

on tp_revisao_devcompra.destroy
destroy(this.dw_revisao_devcompra)
destroy(this.gb_12)
end on

type dw_revisao_devcompra from dc_uo_dw_base within tp_revisao_devcompra
integer x = 41
integer y = 72
integer width = 2437
integer height = 1192
integer taborder = 40
string dataobject = "dw_ge278_revisao"
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.Of_setrowselection( )
end event

event rowfocuschanged;call super::rowfocuschanged;Datetime lvdh_Revisao

If CurrentRow > 0 Then
	This.Object.de_revisao_footer.Text	= This.Object.de_revisao	[CurrentRow]
	This.Object.nm_usuario_footer.Text	= This.Object.nm_usuario	[CurrentRow] + ' ('+String(This.Object.nr_matricula_revisao	[CurrentRow])+')'
	lvdh_Revisao								= This.Object.dh_revisao	[CurrentRow]
	If (Not IsNull(lvdh_Revisao)) and (lvdh_Revisao > Datetime('2015/01/01')) Then
		This.Object.dh_revisao_footer.Text	= String(lvdh_Revisao,'dd/mm/yyyy hh:mm')
	Else
		This.Object.dh_revisao_footer.Text	= ''
	End If
Else 
	This.Object.de_revisao_footer.Text 	= ''
	This.Object.nm_usuario_footer.Text	= ''
	This.Object.dh_revisao_footer.Text	= ''
End If
end event

event ue_recuperar;//override
Datetime lvdt_Inicio
Datetime lvdt_Fim

dw_1.Accepttext( )

lvdt_Inicio = dw_1.Object.dt_inicio	[1]
lvdt_Fim	  = dw_1.Object.dt_fim	[1]

lvdt_Inicio = Datetime(Date(lvdt_Inicio),Time('00:00:00'))
lvdt_Fim	  = Datetime(Date(lvdt_Fim),Time('23:59:59'))

Return This.Retrieve(lvdt_Inicio,lvdt_Fim)
end event

event ue_preretrieve;call super::ue_preretrieve;This.Of_appendwhere("m.id_analise='DVC'")

Return AncestorReturnValue
end event

type gb_12 from groupbox within tp_revisao_devcompra
integer x = 23
integer y = 8
integer width = 2482
integer height = 1272
integer taborder = 20
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

type cb_3 from commandbutton within tp_dev_compra
integer x = 1083
integer y = 1452
integer width = 402
integer height = 92
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Detalhes"
end type

type tp_ajuste_estoque from userobject within tab_1
event ue_retrieve ( )
integer x = 558
integer y = 16
integer width = 2592
integer height = 1572
boolean border = true
long backcolor = 79741120
string text = "Ajuste Estoque"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
tab_ajuste_estoque tab_ajuste_estoque
cb_detalhes_aje cb_detalhes_aje
end type

event ue_retrieve();tab_ajuste_estoque.selecttab(1)
tab_ajuste_estoque.tp_geral_aje.Event ue_Retrieve()
end event

on tp_ajuste_estoque.create
this.tab_ajuste_estoque=create tab_ajuste_estoque
this.cb_detalhes_aje=create cb_detalhes_aje
this.Control[]={this.tab_ajuste_estoque,&
this.cb_detalhes_aje}
end on

on tp_ajuste_estoque.destroy
destroy(this.tab_ajuste_estoque)
destroy(this.cb_detalhes_aje)
end on

type tab_ajuste_estoque from tab within tp_ajuste_estoque
event create ( )
event destroy ( )
event ue_settipo ( long pl_tipo,  long pl_mostra )
integer x = 5
integer y = 8
integer width = 2574
integer height = 1424
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
tp_geral_aje tp_geral_aje
tp_top_filiais_aje tp_top_filiais_aje
tp_top_motivo_aje tp_top_motivo_aje
tp_revisao_ajuest tp_revisao_ajuest
end type

on tab_ajuste_estoque.create
this.tp_geral_aje=create tp_geral_aje
this.tp_top_filiais_aje=create tp_top_filiais_aje
this.tp_top_motivo_aje=create tp_top_motivo_aje
this.tp_revisao_ajuest=create tp_revisao_ajuest
this.Control[]={this.tp_geral_aje,&
this.tp_top_filiais_aje,&
this.tp_top_motivo_aje,&
this.tp_revisao_ajuest}
end on

on tab_ajuste_estoque.destroy
destroy(this.tp_geral_aje)
destroy(this.tp_top_filiais_aje)
destroy(this.tp_top_motivo_aje)
destroy(this.tp_revisao_ajuest)
end on

event ue_settipo(long pl_tipo, long pl_mostra);Tp_Geral_Aje.Event ue_SetTipo(pl_tipo,pl_mostra)
Tp_Top_Filiais_Aje.Event ue_SetTipo(pl_tipo,pl_mostra)
Tp_Top_Motivo_Aje.Event ue_SetTipo(pl_tipo,pl_mostra)
end event

event selectionchanging;Choose Case NewIndex
	Case 2 
		tp_top_filiais_aje.dw_top_filiais_aje.Event ue_Retrieve()
	Case 3
		tp_top_motivo_aje.dw_top_motivo_aje.Event ue_Retrieve()
	Case 4
		tp_revisao_ajuest.dw_revisao_ajuste.Event ue_Retrieve()
End Choose
end event

type tp_geral_aje from userobject within tab_ajuste_estoque
event create ( )
event destroy ( )
event ue_retrieve ( )
event ue_settipo ( long pl_tipo,  long pl_mostra )
integer x = 18
integer y = 100
integer width = 2537
integer height = 1308
long backcolor = 79741120
string text = "Geral"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
cb_tipo_aje cb_tipo_aje
cb_mostra_aje cb_mostra_aje
st_37 st_37
dw_ajuste_estoque_regional dw_ajuste_estoque_regional
spd_ajuste_estoque spd_ajuste_estoque
st_36 st_36
st_31 st_31
st_32 st_32
st_33 st_33
st_34 st_34
st_35 st_35
gb_6 gb_6
ln_6 ln_6
end type

on tp_geral_aje.create
this.cb_tipo_aje=create cb_tipo_aje
this.cb_mostra_aje=create cb_mostra_aje
this.st_37=create st_37
this.dw_ajuste_estoque_regional=create dw_ajuste_estoque_regional
this.spd_ajuste_estoque=create spd_ajuste_estoque
this.st_36=create st_36
this.st_31=create st_31
this.st_32=create st_32
this.st_33=create st_33
this.st_34=create st_34
this.st_35=create st_35
this.gb_6=create gb_6
this.ln_6=create ln_6
this.Control[]={this.cb_tipo_aje,&
this.cb_mostra_aje,&
this.st_37,&
this.dw_ajuste_estoque_regional,&
this.spd_ajuste_estoque,&
this.st_36,&
this.st_31,&
this.st_32,&
this.st_33,&
this.st_34,&
this.st_35,&
this.gb_6,&
this.ln_6}
end on

on tp_geral_aje.destroy
destroy(this.cb_tipo_aje)
destroy(this.cb_mostra_aje)
destroy(this.st_37)
destroy(this.dw_ajuste_estoque_regional)
destroy(this.spd_ajuste_estoque)
destroy(this.st_36)
destroy(this.st_31)
destroy(this.st_32)
destroy(this.st_33)
destroy(this.st_34)
destroy(this.st_35)
destroy(this.gb_6)
destroy(this.ln_6)
end on

event ue_retrieve();Long lvl_Linha_Aux
Long lvl_Linha
Long lvl_Venda

Decimal{10} lvdc_Total
Decimal{10} lvdc_Total_2
Decimal{2} lvdc_Percentual = 0.00

dw_ajuste_estoque_regional.SetRedraw(False)
dw_ajuste_estoque_regional.Reset( )

If (ivds_ajuste_estoque.RowCount() > 0)and(ivds_resumo_estoque.RowCount() > 0)and(ivds_ajuste_estoque_2.RowCount()>0) Then
	lvdc_Total 		= ivds_ajuste_estoque.Object.cp_vl_total[1] / ivds_resumo_estoque.Object.cp_venda[1]
	//M$$HEX1$$e900$$ENDHEX$$dia Proporcional
	lvdc_Total_2	= (ivds_ajuste_estoque_2.Object.cp_vl_total[1]) / ivds_resumo_estoque_2.Object.cp_venda[1]
	//Dados Atuais
	For lvl_Linha = 1 To ivds_ajuste_estoque.RowCount()
		dw_ajuste_estoque_regional.Event ue_AddRow()
		lvl_Linha_Aux = dw_ajuste_estoque_regional.RowCount()
		dw_ajuste_estoque_regional.Object.cd_regional 	[lvl_Linha_Aux] = ivds_ajuste_estoque.Object.cd_regiao	[lvl_Linha]
		dw_ajuste_estoque_regional.Object.de_regional	[lvl_Linha_Aux] = ivds_ajuste_estoque.Object.de_regiao	[lvl_Linha]
		dw_ajuste_estoque_regional.Object.vl_total			[lvl_Linha_Aux] = ivds_ajuste_estoque.Object.vl_total	[lvl_Linha]
		dw_ajuste_estoque_regional.Object.id_tipo 			[lvl_Linha_Aux] = 'Atual'		
	Next
	//Dados M$$HEX1$$e900$$ENDHEX$$dios
	For  lvl_Linha = 1 To ivds_resumo_estoque.RowCount()
		dw_ajuste_estoque_regional.Event ue_AddRow()
		lvl_Linha_Aux = dw_ajuste_estoque_regional.RowCount()
		dw_ajuste_estoque_regional.Object.cd_regional	[lvl_Linha_Aux] = ivds_resumo_estoque.Object.cd_regiao			[lvl_Linha]
		dw_ajuste_estoque_regional.Object.de_regional 	[lvl_Linha_Aux] = ivds_resumo_estoque.Object.de_regiao			[lvl_Linha]
		dw_ajuste_estoque_regional.Object.vl_total			[lvl_Linha_Aux] = ivds_resumo_estoque.Object.vl_venda_liquida	[lvl_Linha] * lvdc_Total_2
		dw_ajuste_estoque_regional.Object.id_tipo 			[lvl_Linha_Aux] = 'M$$HEX1$$e900$$ENDHEX$$dia'
	Next
	lvdc_Percentual = Round((lvdc_Total / lvdc_Total_2)*100,2)
End If

Tab_1.tp_ajuste_estoque.cb_detalhes_aje.Enabled = (lvdc_Total > 0)

spd_ajuste_estoque.of_setvalor(lvdc_Percentual)
Tab_1.tp_inicial.spd_ini_ajuste_estoque.of_setvalor(lvdc_Percentual)
	
dw_ajuste_estoque_regional.SetRedraw(True)
end event

type cb_tipo_aje from dropdownlistbox within tp_geral_aje
integer x = 1870
integer y = 1068
integer width = 608
integer height = 236
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
string text = "Valor"
string item[] = {"Valor"}
borderstyle borderstyle = stylelowered!
end type

type cb_mostra_aje from dropdownlistbox within tp_geral_aje
integer x = 1870
integer y = 1160
integer width = 608
integer height = 236
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
string text = "Valor"
string item[] = {"Valor"}
borderstyle borderstyle = stylelowered!
end type

type st_37 from statictext within tp_geral_aje
integer x = 1906
integer y = 796
integer width = 494
integer height = 52
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "AS = Ajuste Sa$$HEX1$$ed00$$ENDHEX$$da"
boolean focusrectangle = false
end type

type dw_ajuste_estoque_regional from dc_uo_dw_base within tp_geral_aje
integer x = 46
integer y = 36
integer width = 1751
integer height = 1236
integer taborder = 30
string dataobject = "dwg_ge278_regional_ajuste_estoque"
boolean border = true
end type

type spd_ajuste_estoque from uo_grafico_menor within tp_geral_aje
event destroy ( )
integer x = 1819
integer y = 36
integer taborder = 30
boolean border = true
end type

on spd_ajuste_estoque.destroy
call uo_grafico_menor::destroy
end on

type st_36 from statictext within tp_geral_aje
integer x = 1815
integer y = 596
integer width = 110
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 553648127
string text = "R = "
alignment alignment = center!
boolean focusrectangle = false
end type

type st_31 from statictext within tp_geral_aje
integer x = 1929
integer y = 568
integer width = 507
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 553648127
string text = "( (AS-AE) / Vd )"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_32 from statictext within tp_geral_aje
integer x = 1815
integer y = 644
integer width = 754
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 553648127
string text = "((AS M-AE M) / Vd M )"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_33 from statictext within tp_geral_aje
integer x = 1906
integer y = 736
integer width = 599
integer height = 52
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "AE = Ajuste Entrada"
boolean focusrectangle = false
end type

type st_34 from statictext within tp_geral_aje
integer x = 1911
integer y = 860
integer width = 402
integer height = 52
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "Vd = Vendas"
boolean focusrectangle = false
end type

type st_35 from statictext within tp_geral_aje
integer x = 1934
integer y = 920
integer width = 494
integer height = 52
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "M = M$$HEX1$$e900$$ENDHEX$$dia"
boolean focusrectangle = false
end type

type gb_6 from groupbox within tp_geral_aje
integer x = 1815
integer y = 1004
integer width = 699
integer height = 272
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tipo An$$HEX1$$e100$$ENDHEX$$lise"
borderstyle borderstyle = stylebox!
end type

type ln_6 from line within tp_geral_aje
integer linethickness = 4
integer beginx = 1934
integer beginy = 632
integer endx = 2386
integer endy = 632
end type

type tp_top_filiais_aje from userobject within tab_ajuste_estoque
event ue_settipo ( long pl_tipo,  long pl_mostra )
integer x = 18
integer y = 100
integer width = 2537
integer height = 1308
long backcolor = 79741120
string text = "TOP 10 - Filiais"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_top_filiais_aje dw_top_filiais_aje
end type

on tp_top_filiais_aje.create
this.dw_top_filiais_aje=create dw_top_filiais_aje
this.Control[]={this.dw_top_filiais_aje}
end on

on tp_top_filiais_aje.destroy
destroy(this.dw_top_filiais_aje)
end on

type dw_top_filiais_aje from dc_uo_dw_base within tp_top_filiais_aje
integer x = 46
integer y = 36
integer width = 2455
integer height = 1236
integer taborder = 20
string dataobject = "dwg_ge278_top_filiais_ajuste_estoque"
boolean border = true
end type

event ue_recuperar;//override
Datetime lvdt_Inicio
Datetime lvdt_Fim

dw_1.Accepttext( )

lvdt_Inicio = dw_1.Object.dt_inicio	[1]
lvdt_Fim	  = dw_1.Object.dt_fim	[1]

lvdt_Inicio = Datetime(Date(lvdt_Inicio),Time('00:00:00'))
lvdt_Fim	  = Datetime(Date(lvdt_Fim),Time('23:59:59'))

Return This.Retrieve(lvdt_Inicio,lvdt_Fim)
end event

type tp_top_motivo_aje from userobject within tab_ajuste_estoque
event ue_settipo ( long pl_tipo,  long pl_mostra )
integer x = 18
integer y = 100
integer width = 2537
integer height = 1308
long backcolor = 79741120
string text = "TOP 10 - Motivo"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_top_motivo_aje dw_top_motivo_aje
end type

on tp_top_motivo_aje.create
this.dw_top_motivo_aje=create dw_top_motivo_aje
this.Control[]={this.dw_top_motivo_aje}
end on

on tp_top_motivo_aje.destroy
destroy(this.dw_top_motivo_aje)
end on

type dw_top_motivo_aje from dc_uo_dw_base within tp_top_motivo_aje
integer x = 46
integer y = 36
integer width = 2455
integer height = 1236
integer taborder = 20
string dataobject = "dwg_ge278_top_motivo_ajuste_estoque"
boolean border = true
end type

event ue_recuperar;//override
Datetime lvdt_Inicio
Datetime lvdt_Fim

dw_1.Accepttext( )

lvdt_Inicio = dw_1.Object.dt_inicio	[1]
lvdt_Fim	  = dw_1.Object.dt_fim	[1]

lvdt_Inicio = Datetime(Date(lvdt_Inicio),Time('00:00:00'))
lvdt_Fim	  = Datetime(Date(lvdt_Fim),Time('23:59:59'))

Return This.Retrieve(lvdt_Inicio,lvdt_Fim)
end event

type tp_revisao_ajuest from userobject within tab_ajuste_estoque
integer x = 18
integer y = 100
integer width = 2537
integer height = 1308
long backcolor = 79741120
string text = "Revis$$HEX1$$e300$$ENDHEX$$o"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_revisao_ajuste dw_revisao_ajuste
gb_13 gb_13
end type

on tp_revisao_ajuest.create
this.dw_revisao_ajuste=create dw_revisao_ajuste
this.gb_13=create gb_13
this.Control[]={this.dw_revisao_ajuste,&
this.gb_13}
end on

on tp_revisao_ajuest.destroy
destroy(this.dw_revisao_ajuste)
destroy(this.gb_13)
end on

type dw_revisao_ajuste from dc_uo_dw_base within tp_revisao_ajuest
integer x = 41
integer y = 72
integer width = 2437
integer height = 1192
integer taborder = 40
string dataobject = "dw_ge278_revisao"
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.Of_setrowselection( )
end event

event rowfocuschanged;call super::rowfocuschanged;Datetime lvdh_Revisao

If CurrentRow > 0 Then
	This.Object.de_revisao_footer.Text	= This.Object.de_revisao	[CurrentRow]
	This.Object.nm_usuario_footer.Text	= This.Object.nm_usuario	[CurrentRow] + ' ('+String(This.Object.nr_matricula_revisao	[CurrentRow])+')'
	lvdh_Revisao								= This.Object.dh_revisao	[CurrentRow]
	If (Not IsNull(lvdh_Revisao)) and (lvdh_Revisao > Datetime('2015/01/01')) Then
		This.Object.dh_revisao_footer.Text	= String(lvdh_Revisao,'dd/mm/yyyy hh:mm')
	Else
		This.Object.dh_revisao_footer.Text	= ''
	End If
Else 
	This.Object.de_revisao_footer.Text 	= ''
	This.Object.nm_usuario_footer.Text	= ''
	This.Object.dh_revisao_footer.Text	= ''
End If
end event

event ue_recuperar;//override
Datetime lvdt_Inicio
Datetime lvdt_Fim

dw_1.Accepttext( )

lvdt_Inicio = dw_1.Object.dt_inicio	[1]
lvdt_Fim	  = dw_1.Object.dt_fim	[1]

lvdt_Inicio = Datetime(Date(lvdt_Inicio),Time('00:00:00'))
lvdt_Fim	  = Datetime(Date(lvdt_Fim),Time('23:59:59'))

Return This.Retrieve(lvdt_Inicio,lvdt_Fim)
end event

event ue_preretrieve;call super::ue_preretrieve;This.Of_appendwhere("m.id_analise='AJE'")

Return AncestorReturnValue
end event

type gb_13 from groupbox within tp_revisao_ajuest
integer x = 23
integer y = 8
integer width = 2482
integer height = 1272
integer taborder = 20
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

type cb_detalhes_aje from commandbutton within tp_ajuste_estoque
integer x = 1083
integer y = 1452
integer width = 402
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Detalhes"
end type

event clicked;Datetime lvdt_Inicio
Datetime lvdt_Fim

String lvs_Param

dw_1.Accepttext( )

lvdt_Inicio = dw_1.Object.dt_inicio	[1]
lvdt_Fim	  = dw_1.Object.dt_fim	[1]

lvs_Param = String(lvdt_Inicio,'dd/mm/yyyy')+';'+String(lvdt_Fim,'dd/mm/yyyy')

OpenSheetWithParm(w_ge280_consulta_ajuste_estoque,lvs_Param,dc_w_MDI)

end event

type tp_sobras_perdas from userobject within tab_1
event ue_retrieve ( )
integer x = 558
integer y = 16
integer width = 2592
integer height = 1572
boolean border = true
long backcolor = 79741120
string text = "Sobras e Perdas"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
tab_sobras tab_sobras
cb_detfaltacaixa cb_detfaltacaixa
end type

event ue_retrieve();tab_sobras.selecttab(1)
tab_sobras.tp_Sobras_Geral.Event ue_Retrieve()
end event

on tp_sobras_perdas.create
this.tab_sobras=create tab_sobras
this.cb_detfaltacaixa=create cb_detfaltacaixa
this.Control[]={this.tab_sobras,&
this.cb_detfaltacaixa}
end on

on tp_sobras_perdas.destroy
destroy(this.tab_sobras)
destroy(this.cb_detfaltacaixa)
end on

type tab_sobras from tab within tp_sobras_perdas
event ue_settipo ( long pl_tipo,  long pl_mostra )
integer x = 5
integer y = 8
integer width = 2574
integer height = 1424
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
tp_sobras_geral tp_sobras_geral
tp_top_faltas tp_top_faltas
end type

event ue_settipo(long pl_tipo, long pl_mostra);Tp_Sobras_Geral.Event ue_SetTipo(pl_Tipo,pl_Mostra)
Tp_Top_Faltas.Event ue_SetTipo(pl_Tipo,pl_Mostra)
end event

on tab_sobras.create
this.tp_sobras_geral=create tp_sobras_geral
this.tp_top_faltas=create tp_top_faltas
this.Control[]={this.tp_sobras_geral,&
this.tp_top_faltas}
end on

on tab_sobras.destroy
destroy(this.tp_sobras_geral)
destroy(this.tp_top_faltas)
end on

event selectionchanging;If NewIndex = 2 Then
	Tp_Top_Faltas.dw_top_filial_perda.Event ue_Retrieve()
End If
end event

type tp_sobras_geral from userobject within tab_sobras
event ue_retrieve ( )
event ue_settipo ( long pl_tipo,  long pl_mostra )
integer x = 18
integer y = 100
integer width = 2537
integer height = 1308
long backcolor = 79741120
string text = "Geral"
long tabtextcolor = 33554432
long picturemaskcolor = 536870912
st_38 st_38
cb_tipo_fcx cb_tipo_fcx
cb_mostra_fcx cb_mostra_fcx
st_30 st_30
st_29 st_29
st_28 st_28
st_26 st_26
st_25 st_25
st_27 st_27
dw_perda_caixa_regional dw_perda_caixa_regional
spd_perdas_caixa spd_perdas_caixa
gb_7 gb_7
ln_5 ln_5
end type

event ue_retrieve();Long lvl_Linha_Aux
Long lvl_Linha
Long lvl_Venda

Decimal{6} lvdc_Total
Decimal{6} lvdc_Total_2
Decimal{2} lvdc_Percentual = 0.00

dw_perda_caixa_regional.SetRedraw(False)
dw_perda_caixa_regional.Reset( )

If ivds_lancamentos_caixa.RowCount() > 0 Then
	lvdc_Total 		= ivds_lancamentos_caixa.Object.vl_total_resultado[1] / ivds_resumo_estoque.Object.cp_venda[1]
	//M$$HEX1$$e900$$ENDHEX$$dia Proporcional
	lvdc_Total_2	= (ivds_lancamentos_caixa_2.Object.vl_total_resultado[1]) / ivds_resumo_estoque_2.Object.cp_venda[1]
	//Dados Atuais
	Tab_1.tp_Sobras_Perdas.cb_detFaltaCaixa.Enabled = (ivds_lancamentos_caixa.RowCount() > 0)
	For lvl_Linha = 1 To ivds_lancamentos_caixa.RowCount()
		dw_perda_caixa_regional.Event ue_AddRow()
		lvl_Linha_Aux = dw_perda_caixa_regional.RowCount()
		dw_perda_caixa_regional.Object.cd_regional 	[lvl_Linha_Aux] = ivds_lancamentos_caixa.Object.cd_regiao	[lvl_Linha]
		dw_perda_caixa_regional.Object.de_regional	[lvl_Linha_Aux] = ivds_lancamentos_caixa.Object.de_regiao	[lvl_Linha]
		dw_perda_caixa_regional.Object.vl_resultado	[lvl_Linha_Aux] = ivds_lancamentos_caixa.Object.vl_resultado	[lvl_Linha]
		dw_perda_caixa_regional.Object.id_tipo 			[lvl_Linha_Aux] = 'Atual'
	Next
	//Dados M$$HEX1$$e900$$ENDHEX$$dios
	For lvl_Linha = 1 To ivds_lancamentos_caixa.RowCount()
		dw_perda_caixa_regional.Event ue_AddRow()
		lvl_Linha_Aux = dw_perda_caixa_regional.RowCount()
		dw_perda_caixa_regional.Object.cd_regional	[lvl_Linha_Aux] = ivds_resumo_estoque.Object.cd_regiao[lvl_Linha]
		dw_perda_caixa_regional.Object.de_regional 	[lvl_Linha_Aux] = ivds_resumo_estoque.Object.de_regiao[lvl_Linha]
		dw_perda_caixa_regional.Object.vl_resultado	[lvl_Linha_Aux] = ivds_resumo_estoque.Object.vl_venda_liquida[lvl_Linha] * lvdc_Total_2
		dw_perda_caixa_regional.Object.id_tipo 			[lvl_Linha_Aux] = 'M$$HEX1$$e900$$ENDHEX$$dia'
	Next

	lvdc_Percentual = Round((lvdc_Total / lvdc_Total_2)*100,2)
End If

spd_perdas_caixa.of_setvalor(lvdc_Percentual)
Tab_1.tp_inicial.spd_ini_perdas_caixa.of_setvalor(lvdc_Percentual)
	
dw_perda_caixa_regional.SetRedraw(True)
end event

on tp_sobras_geral.create
this.st_38=create st_38
this.cb_tipo_fcx=create cb_tipo_fcx
this.cb_mostra_fcx=create cb_mostra_fcx
this.st_30=create st_30
this.st_29=create st_29
this.st_28=create st_28
this.st_26=create st_26
this.st_25=create st_25
this.st_27=create st_27
this.dw_perda_caixa_regional=create dw_perda_caixa_regional
this.spd_perdas_caixa=create spd_perdas_caixa
this.gb_7=create gb_7
this.ln_5=create ln_5
this.Control[]={this.st_38,&
this.cb_tipo_fcx,&
this.cb_mostra_fcx,&
this.st_30,&
this.st_29,&
this.st_28,&
this.st_26,&
this.st_25,&
this.st_27,&
this.dw_perda_caixa_regional,&
this.spd_perdas_caixa,&
this.gb_7,&
this.ln_5}
end on

on tp_sobras_geral.destroy
destroy(this.st_38)
destroy(this.cb_tipo_fcx)
destroy(this.cb_mostra_fcx)
destroy(this.st_30)
destroy(this.st_29)
destroy(this.st_28)
destroy(this.st_26)
destroy(this.st_25)
destroy(this.st_27)
destroy(this.dw_perda_caixa_regional)
destroy(this.spd_perdas_caixa)
destroy(this.gb_7)
destroy(this.ln_5)
end on

type st_38 from statictext within tp_sobras_geral
integer x = 1906
integer y = 828
integer width = 626
integer height = 52
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "AjCf = Ajuste Caixa Falta"
boolean focusrectangle = false
end type

type cb_tipo_fcx from dropdownlistbox within tp_sobras_geral
integer x = 1870
integer y = 1068
integer width = 608
integer height = 236
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
string text = "Valor"
string item[] = {"Valor"}
borderstyle borderstyle = stylelowered!
end type

type cb_mostra_fcx from dropdownlistbox within tp_sobras_geral
integer x = 1870
integer y = 1160
integer width = 608
integer height = 236
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
string text = "Valor"
string item[] = {"Valor"}
borderstyle borderstyle = stylelowered!
end type

type st_30 from statictext within tp_sobras_geral
integer x = 1966
integer y = 932
integer width = 494
integer height = 52
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "M = M$$HEX1$$e900$$ENDHEX$$dia"
boolean focusrectangle = false
end type

type st_29 from statictext within tp_sobras_geral
integer x = 1943
integer y = 884
integer width = 402
integer height = 52
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "Vd = Vendas"
boolean focusrectangle = false
end type

type st_28 from statictext within tp_sobras_geral
integer x = 1893
integer y = 776
integer width = 626
integer height = 52
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "AjCs = Ajuste Caixa Sobra"
boolean focusrectangle = false
end type

type st_26 from statictext within tp_sobras_geral
integer x = 1806
integer y = 648
integer width = 741
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 553648127
string text = "(AjCf M - AjCs M) / Vd M"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_25 from statictext within tp_sobras_geral
integer x = 1929
integer y = 564
integer width = 581
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 553648127
string text = "(AjCf - AjCs) / Vd"
alignment alignment = center!
boolean focusrectangle = false
end type

type st_27 from statictext within tp_sobras_geral
integer x = 1815
integer y = 592
integer width = 110
integer height = 52
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 553648127
string text = "R = "
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_perda_caixa_regional from dc_uo_dw_base within tp_sobras_geral
integer x = 46
integer y = 36
integer width = 1751
integer height = 1236
string dataobject = "dwg_ge278_regional_lucros_perdas"
boolean border = true
end type

type spd_perdas_caixa from uo_grafico_menor within tp_sobras_geral
integer x = 1819
integer y = 36
integer taborder = 20
boolean border = true
end type

on spd_perdas_caixa.destroy
call uo_grafico_menor::destroy
end on

type gb_7 from groupbox within tp_sobras_geral
integer x = 1815
integer y = 1004
integer width = 699
integer height = 272
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
string text = "Tipo An$$HEX1$$e100$$ENDHEX$$lise"
borderstyle borderstyle = stylebox!
end type

type ln_5 from line within tp_sobras_geral
integer linethickness = 4
integer beginx = 1934
integer beginy = 632
integer endx = 2501
integer endy = 632
end type

type tp_top_faltas from userobject within tab_sobras
event create ( )
event destroy ( )
event ue_settipo ( long pl_tipo,  long pl_mostra )
integer x = 18
integer y = 100
integer width = 2537
integer height = 1308
long backcolor = 79741120
string text = "TOP 10 - Filiais"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_top_filial_perda dw_top_filial_perda
end type

on tp_top_faltas.create
this.dw_top_filial_perda=create dw_top_filial_perda
this.Control[]={this.dw_top_filial_perda}
end on

on tp_top_faltas.destroy
destroy(this.dw_top_filial_perda)
end on

type dw_top_filial_perda from dc_uo_dw_base within tp_top_faltas
integer x = 46
integer y = 36
integer width = 2455
integer height = 1236
integer taborder = 20
string dataobject = "dwg_ge278_top_filiais_perdas"
boolean border = true
end type

event ue_recuperar;//override
Datetime lvdt_Inicio
Datetime lvdt_Fim

dw_1.Accepttext( )

lvdt_Inicio = dw_1.Object.dt_inicio	[1]
lvdt_Fim	  = dw_1.Object.dt_fim	[1]

lvdt_Inicio = Datetime(Date(lvdt_Inicio),Time('00:00:00'))
lvdt_Fim	  = Datetime(Date(lvdt_Fim),Time('23:59:59'))

Return This.Retrieve(lvdt_Inicio,lvdt_Fim)
end event

type cb_detfaltacaixa from commandbutton within tp_sobras_perdas
integer x = 1083
integer y = 1452
integer width = 402
integer height = 92
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Detalhes"
end type

event clicked;//override
Datetime lvdt_Inicio
Datetime lvdt_Fim

Long lvl_Tipo
Long lvl_Mostra

String lvs_Param

dw_1.Accepttext( )

wf_get_tipo_cancelamento(lvl_Tipo,lvl_Mostra)

lvdt_Inicio = dw_1.Object.dt_inicio	[1]
lvdt_Fim	  = dw_1.Object.dt_fim	[1]

lvs_Param = String(lvdt_Inicio,'dd/mm/yyyy')+';'+String(lvdt_Fim,'dd/mm/yyyy')+';'+String(lvl_Tipo)+';'+String(lvl_Mostra)+';'

OpenSheetWithParm(w_ge295_relatorio_falta_caixas,lvs_Param,dc_w_MDI)
end event

type dw_1 from dc_uo_dw_base within w_ge278_analise
integer x = 78
integer y = 88
integer width = 1189
integer height = 184
integer taborder = 20
string dataobject = "dw_ge278_selecao"
end type

event itemchanged;call super::itemchanged;String lvs_Tipo_Media = '0'
String lvs_Tipo_Analise = '0'

Choose Case Dwo.Name
	Case 'id_tipo_media'
		lvs_Tipo_Media 	= Data
		lvs_Tipo_Analise 	= String(This.Object.id_tipo_analise[Row])
	Case 'id_tipo_analise'
		lvs_Tipo_Analise 	= Data
		lvs_Tipo_Media 	= String(This.Object.id_tipo_media[Row])
End Choose

If (Dwo.Name = 'id_tipo_media') or (Dwo.Name = 'id_tipo_analise') Then
	If (lvs_Tipo_Analise = '4')or(lvs_Tipo_Media = '4') Then
		This.Width = 2250
		gb_1.Width = 2335
	ElseIf This.Width <> 1190 Then
		This.Width = 1190
		gb_1.Width = 1275
	End If
End If

end event

event constructor;call super::constructor;This.of_SetColSelection(True)
end event

type gb_1 from groupbox within w_ge278_analise
integer x = 37
integer y = 16
integer width = 1275
integer height = 276
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

