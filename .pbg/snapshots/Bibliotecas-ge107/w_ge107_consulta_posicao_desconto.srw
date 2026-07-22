HA$PBExportHeader$w_ge107_consulta_posicao_desconto.srw
forward
global type w_ge107_consulta_posicao_desconto from dc_w_response
end type
type dw_1 from dc_uo_dw_base within w_ge107_consulta_posicao_desconto
end type
type cb_1 from commandbutton within w_ge107_consulta_posicao_desconto
end type
end forward

global type w_ge107_consulta_posicao_desconto from dc_w_response
integer x = 1134
integer y = 904
integer width = 1349
integer height = 700
string title = "GE107 - Consulta Desconto M$$HEX1$$e900$$ENDHEX$$dio"
boolean controlmenu = false
long backcolor = 80269524
dw_1 dw_1
cb_1 cb_1
end type
global w_ge107_consulta_posicao_desconto w_ge107_consulta_posicao_desconto

forward prototypes
public subroutine wf_atualiza_descontos (date adt_inicio, date adt_termino, ref decimal adc_desconto_geral, ref decimal adc_desconto_comercial, ref decimal adc_desconto_filial)
public subroutine wf_cobre_preco (ref decimal adc_cobre_preco, date adt_getdate)
end prototypes

public subroutine wf_atualiza_descontos (date adt_inicio, date adt_termino, ref decimal adc_desconto_geral, ref decimal adc_desconto_comercial, ref decimal adc_desconto_filial);Decimal lvdc_Venda_Bruta, &
        lvdc_Venda_Liquida, &
		  lvdc_Venda_Tabela, &
		  lvdc_Devolucao_Bruta, &
		  lvdc_Devolucao_Liquida, &
		  lvdc_Venda, &
		  lvdc_Devolucao

Select sum(vl_venda_bruta),
       sum(vl_venda_avista + vl_venda_crediario + vl_venda_conta_corrente + vl_venda_convenio),
		 sum(vl_venda_tabela),
		 sum(vl_devolucao_venda_bruta),
		 sum(vl_devolucao_venda)
Into :lvdc_Venda_Bruta,
     :lvdc_Venda_Liquida,
	  :lvdc_Venda_Tabela,
	  :lvdc_Devolucao_Bruta,
	  :lvdc_Devolucao_Liquida
From resumo_movimento_estoque
Where dh_resumo between :adt_Inicio and :adt_Termino
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		lvdc_Venda_Bruta   = lvdc_Venda_Bruta   - lvdc_Devolucao_Bruta
		lvdc_Venda_Liquida = lvdc_Venda_Liquida - lvdc_Devolucao_Liquida
		lvdc_Venda_Tabela  = lvdc_Venda_Tabela  - lvdc_Devolucao_Liquida
		
		If lvdc_Venda_Bruta <> 0 Then
			adc_Desconto_Geral     = Round(((lvdc_Venda_Bruta - lvdc_Venda_Liquida)  / lvdc_Venda_Bruta) * 100, 2)
			adc_Desconto_Comercial = Round(((lvdc_Venda_Bruta - lvdc_Venda_Tabela)   / lvdc_Venda_Bruta) * 100, 2)
		End If
		
		If lvdc_Venda_Tabela <> 0 Then
			adc_Desconto_Filial = Round(((lvdc_Venda_Tabela - lvdc_Venda_Liquida) / lvdc_Venda_Tabela) * 100, 2)
		End If
		
	Case 100
	Case -1
		SqlCa.of_MsgdbError("C$$HEX1$$e100$$ENDHEX$$lculo Desconto M$$HEX1$$e900$$ENDHEX$$dio")
End Choose
end subroutine

public subroutine wf_cobre_preco (ref decimal adc_cobre_preco, date adt_getdate);
SELECT IsNull(Round(Sum( n.qt_negociada * (	n.vl_preco_unitario * (((Case when n.pc_desconto_negociado > n.pc_desconto_unitario then n.pc_desconto_negociado else n.pc_desconto_unitario end) - n.pc_desconto_unitario) / 100))) ,	2), 0)
	INTO :adc_cobre_preco
FROM cliente_caixa c
	INNER JOIN negociacao_cliente n
	ON n.nr_sequencial_cliente_caixa = c.nr_sequencial
WHERE c.dh_movimentacao = :adt_getdate
	AND n.id_situacao 	= 'A'
	AND c.id_situacao in ( 'A', 'C' )
	AND   NOT EXISTS ( select x.nr_nf FROM nf_venda x 
								  WHERE x.cd_filial  		= c.cd_filial
									 AND x.nr_nf      		= c.nr_nf
									 AND x.de_especie 	= c.de_especie
									 AND x.de_serie   		= c.de_serie
									 AND x.dh_cancelamento IS NOT NULL )
Using SqlCa;

end subroutine

on w_ge107_consulta_posicao_desconto.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_1
end on

on w_ge107_consulta_posicao_desconto.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_1)
end on

event ue_postopen;call super::ue_postopen;Date 	lvdt_Parametro, &
     	lvdt_Inicio

Decimal 	lvdc_Geral_Acumulado, &
        		lvdc_Geral_Hoje, &
			lvdc_Comercial_Acumulado, &
			lvdc_Comercial_Hoje, &
			lvdc_Filial_Acumulado, &
			lvdc_Filial_Hoje,&
			lvdc_cobre_preco

SetPointer(HourGlass!)

dw_1.Event ue_AddRow()

lvdt_Parametro = Date(gvo_Parametro.of_Dh_Movimentacao())
lvdt_Inicio    = Date("01/" + MidA(String(lvdt_Parametro), 4))

wf_Atualiza_Descontos(	lvdt_Inicio, &
                      				lvdt_Parametro, &
							 	ref lvdc_Geral_Acumulado, &
							 	ref lvdc_Comercial_Acumulado, &
							 	ref lvdc_Filial_Acumulado)

wf_Atualiza_Descontos(	lvdt_Parametro, &
                      				lvdt_Parametro, &
							 	ref lvdc_Geral_Hoje, &
							 	ref lvdc_Comercial_Hoje, &
							 	ref lvdc_Filial_Hoje)

wf_cobre_preco(ref lvdc_cobre_preco, lvdt_Parametro)

dw_1.Object.Pc_Geral_Acumulado			[1] = lvdc_Geral_Acumulado
dw_1.Object.Pc_Geral_Hoje         			[1] = lvdc_Geral_Hoje
dw_1.Object.Pc_Comercial_Acumulado	[1] = lvdc_Comercial_Acumulado
dw_1.Object.Pc_Comercial_Hoje     		[1] = lvdc_Comercial_Hoje
dw_1.Object.Pc_Filial_Acumulado   		[1] = lvdc_Filial_Acumulado
dw_1.Object.Pc_Filial_Hoje        			[1] = lvdc_Filial_Hoje
dw_1.Object.vlr_cobre_preco				[1] = lvdc_cobre_preco

SetPointer(Arrow!)
end event

type pb_help from dc_w_response`pb_help within w_ge107_consulta_posicao_desconto
end type

type dw_1 from dc_uo_dw_base within w_ge107_consulta_posicao_desconto
integer x = 9
integer y = 8
integer width = 1321
integer height = 604
boolean bringtotop = true
string dataobject = "dw_ge107_consulta_posicao_desconto"
end type

type cb_1 from commandbutton within w_ge107_consulta_posicao_desconto
integer x = 905
integer y = 436
integer width = 347
integer height = 96
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Fechar"
boolean cancel = true
boolean default = true
end type

event clicked;Close(Parent)
end event

