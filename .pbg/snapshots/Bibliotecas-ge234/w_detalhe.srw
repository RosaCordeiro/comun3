HA$PBExportHeader$w_detalhe.srw
forward
global type w_detalhe from window
end type
type dw_9 from datawindow within w_detalhe
end type
type dw_7 from datawindow within w_detalhe
end type
type dw_6 from datawindow within w_detalhe
end type
type dw_5 from datawindow within w_detalhe
end type
type cb_1 from commandbutton within w_detalhe
end type
type dw_4 from datawindow within w_detalhe
end type
type st_1 from statictext within w_detalhe
end type
type dw_2 from datawindow within w_detalhe
end type
type dw_1 from datawindow within w_detalhe
end type
type ln_1 from line within w_detalhe
end type
type ln_2 from line within w_detalhe
end type
type ln_3 from line within w_detalhe
end type
type ln_4 from line within w_detalhe
end type
type ln_5 from line within w_detalhe
end type
end forward

global type w_detalhe from window
integer x = 1056
integer y = 456
integer width = 4576
integer height = 2276
boolean titlebar = true
string title = "Detalhe da Rede de Filiais"
windowtype windowtype = response!
long backcolor = 82899184
event apos_abertura ( )
dw_9 dw_9
dw_7 dw_7
dw_6 dw_6
dw_5 dw_5
cb_1 cb_1
dw_4 dw_4
st_1 st_1
dw_2 dw_2
dw_1 dw_1
ln_1 ln_1
ln_2 ln_2
ln_3 ln_3
ln_4 ln_4
ln_5 ln_5
end type
global w_detalhe w_detalhe

type variables
uo_parametro_janelas iuo_parametro
Long ivl_filial[]

end variables

forward prototypes
public function integer wf_monta_grafico ()
end prototypes

event apos_abertura();Long lvl_linha, lvl_linha_dw2, lvl_linha_dw5, lvl_contador, lvl_linha_maior, lvl_saldo, lvl_venda
String lvs_rede, lvs_grupo, lvs_find
Decimal lvdc_valor, lvdc_valor_2, lvdc_soma_valor, lvdc_maior_valor, lvdc_venda_cheia, lvdc_perda, lvdc_dias

SetPointer(HourGlass!)
Open(w_aguarde)
w_aguarde.Title = 'Recuperando informa$$HEX2$$e700f500$$ENDHEX$$es...'

CHOOSE CASE month(iuo_parametro.ivdt_ontem)
	CASE 1
		lvs_find = 'Janeiro'
	CASE 2
		lvs_find = 'Fevereiro'
	CASE 3
		lvs_find = 'Mar$$HEX1$$e700$$ENDHEX$$o'
	CASE 4
		lvs_find = 'Abril'
	CASE 5
		lvs_find = 'Maio'
	CASE 6
		lvs_find = 'Junho'
	CASE 7 
		lvs_find = 'Julho'
	CASE 8
		lvs_find = 'Agosto'
	CASE 9
		lvs_find = 'Setembro'
	CASE 10
		lvs_find = 'Outubro'
	CASE 11
		lvs_find = 'Novembro'
	CASE ELSE
		lvs_find = 'Dezembro'
END CHOOSE

lvs_find = st_1.Text + " " + String(Day(iuo_parametro.ivdt_ontem)) + " de " + lvs_find + " de " + &
           String(Year(iuo_parametro.ivdt_ontem))
st_1.Text = lvs_find

lvs_rede = iuo_parametro.ivs_rede
CHOOSE CASE lvs_rede
	CASE 'DC'
		ivl_filial[] = iuo_parametro.ivl_filial_dc[]
		lvl_linha = dw_1.InsertRow(0)
		dw_1.Object.nome_rede[lvl_linha] = "DROGARIA CATARINENSE"
		dw_1.Object.num_lojas[lvl_linha] = UpperBound(iuo_parametro.ivl_filial_dc[])
	CASE 'PP'
		ivl_filial[] = iuo_parametro.ivl_filial_pp[]
		lvl_linha = dw_1.InsertRow(0)
		dw_1.Object.nome_rede[lvl_linha] = "PRE$$HEX1$$c700$$ENDHEX$$O POPULAR"
		dw_1.Object.num_lojas[lvl_linha] = UpperBound(iuo_parametro.ivl_filial_pp[])
	CASE 'PF'
		ivl_filial[] = iuo_parametro.ivl_filial_pro[]
		lvl_linha = dw_1.InsertRow(0)
		dw_1.Object.nome_rede[lvl_linha] = "PROF$$HEX1$$d300$$ENDHEX$$RMULA"
		dw_1.Object.num_lojas[lvl_linha] = UpperBound(iuo_parametro.ivl_filial_pro[])
	CASE 'FA'
		ivl_filial[] = iuo_parametro.ivl_filial_far[]
		lvl_linha = dw_1.InsertRow(0)
		dw_1.Object.nome_rede[lvl_linha] = "FARMAGORA"
		dw_1.Object.num_lojas[lvl_linha] = UpperBound(iuo_parametro.ivl_filial_far[])
	CASE 'CP'
		ivl_filial[] = iuo_parametro.ivl_filial_dcp[]
		lvl_linha = dw_1.InsertRow(0)
		dw_1.Object.nome_rede[lvl_linha] = "DROGARIA PRE$$HEX1$$c700$$ENDHEX$$O POPULAR"
		dw_1.Object.num_lojas[lvl_linha] = UpperBound(iuo_parametro.ivl_filial_dcp[])
	CASE 'MAN'
		ivl_filial[] = iuo_parametro.ivl_filial_man[]
		lvl_linha = dw_1.InsertRow(0)
		dw_1.Object.nome_rede[lvl_linha] = "MANIPULA$$HEX2$$c700c300$$ENDHEX$$O CATARINENSE"
		dw_1.Object.num_lojas[lvl_linha] = UpperBound(iuo_parametro.ivl_filial_man[])
		dw_4.Visible = False
	CASE ELSE
		ivl_filial[] = iuo_parametro.ivl_filial_umso[]
		dw_1.DataObject = "dw_detalhe_filial_1"
		dw_1.SetTransObject(SqlCa)
		dw_1.Retrieve(ivl_filial[1])
END CHOOSE

Yield()

lvl_linha_dw2 = dw_2.Retrieve(iuo_parametro.ivdh_inicio_mes, DateTime(iuo_parametro.ivdt_ontem, Time("00:00:00")), &
                ivl_filial)

lvl_linha_dw5 = dw_5.Retrieve()

dw_4.Retrieve(iuo_parametro.ivdh_inicio_mes, ivl_filial)

dw_6.Retrieve(iuo_parametro.ivdh_inicio_mes, DateTime(iuo_parametro.ivdt_ontem, Time("00:00:00")), ivl_filial)

dw_7.Retrieve(iuo_parametro.ivdh_inicio_mes, ivl_filial)

lvdc_maior_valor = 0

FOR lvl_contador = 1 TO lvl_linha_dw5
	dw_5.Object.nr_dias[lvl_contador] = iuo_parametro.ivi_dias_corrente
	lvs_grupo = dw_5.Object.cd_grupo[lvl_contador]
	lvs_find = "cd_grupo='" + lvs_grupo + "'"
	lvl_linha = dw_7.Find(lvs_find, 1, dw_7.RowCount())
	If lvl_linha > 0 Then
		lvdc_valor = dw_7.Object.vl_venda[lvl_linha]
		dw_5.Object.vl_vendas[lvl_contador] = lvdc_valor
		lvdc_soma_valor = lvdc_soma_valor + lvdc_valor
		If lvdc_valor > lvdc_maior_valor Then
			lvdc_maior_valor = lvdc_valor
			lvl_linha_maior = lvl_contador
		End If
		lvdc_valor_2 = dw_7.Object.vl_venda_bruta[lvl_linha]
		if lvs_grupo < '4' Then
			lvdc_venda_cheia = lvdc_venda_cheia + lvdc_valor_2
		end if
	End If
	lvl_linha = dw_4.Find(lvs_find, 1, dw_4.RowCount())
	If lvl_linha > 0 Then
		lvdc_valor = dw_4.Object.vl_estoque_custo[lvl_linha]
		dw_5.Object.vl_estoque[lvl_contador] = lvdc_valor
		lvl_saldo = dw_4.Object.qt_saldo[lvl_linha]
	End If
	lvl_linha = dw_6.Find(lvs_find, 1, dw_6.RowCount())
	If lvl_linha > 0 Then
		lvdc_valor = dw_6.Object.vl_perda[lvl_linha]
		lvdc_perda = lvdc_perda + lvdc_valor
		lvdc_valor = lvdc_valor / lvdc_valor_2 * 100
		dw_5.Object.pc_faltas[lvl_contador] = lvdc_valor
	End If
	lvl_linha = dw_7.Find(lvs_find, 1, dw_7.RowCount())
	If lvl_linha > 0 Then
		lvdc_valor = dw_7.Object.pc_rentab[lvl_linha]
		dw_5.Object.pc_rentab[lvl_contador] = lvdc_valor
		lvl_venda = dw_7.Object.qt_venda[lvl_linha]
		If lvl_venda > 0 and lvl_saldo > 0 Then
			lvdc_dias = Round(lvl_saldo / lvl_venda * 30, 2)
		Else
			lvdc_dias = 0
		End If
		dw_5.Object.nr_dias[lvl_contador] = lvdc_dias
	End If
NEXT

lvl_saldo = dw_4.Object.qt_total_saldo[1]
lvl_venda = dw_7.Object.qt_total_venda[1]
If lvl_venda > 0 and lvl_saldo > 0 Then
	lvdc_dias = Round(lvl_saldo / lvl_venda * 30, 2)
Else
	lvdc_dias = 0
End If
dw_5.Object.nr_dias_total[1] = lvdc_dias

lvdc_valor = dw_7.Object.tot_rentab[1]
dw_5.Object.tot_rentab[1] = lvdc_valor
If lvdc_venda_cheia > 0 Then
	lvdc_valor = lvdc_perda / lvdc_venda_cheia * 100
Else 
	lvdc_valor = 0
End If
dw_5.Object.pc_total_perda[1] = lvdc_valor

lvdc_valor = dw_2.Object.vl_venda_liquida[lvl_linha_dw2]
If lvdc_valor <> lvdc_soma_valor Then
	lvdc_valor = lvdc_valor - lvdc_soma_valor
	lvdc_valor = lvdc_maior_valor + lvdc_valor
	dw_5.Object.vl_vendas[lvl_linha_maior] = lvdc_valor
End If

dw_5.SetFilter("vl_vendas > 0 or vl_estoque > 0")
dw_5.Filter()

dw_5.Sort()


wf_monta_grafico()

SetPointer(Arrow!)
cb_1.Enabled = True
Close(w_aguarde)
end event

public function integer wf_monta_grafico ();DateTime lvdt_aux
Long lvl_linha, lvl_contador
String lvs_mes_ano

lvdt_aux = DateTime(RelativeDate(iuo_parametro.ivdt_ontem, -365), Time("00:00:00"))
//lvl_linha = dw_8.Retrieve(lvdt_aux, DateTime(iuo_parametro.ivdt_ontem, Time("00:00:00")), ivl_filial)

//FOR lvl_contador = 1 TO lvl_linha
//	lvs_mes_ano = dw_9.Object.dh_resumo[lvl_contador]
//	lvdt_aux = DateTime(Date("01/" + lvs_mes_ano), Time("00:00:00"))
//	
//NEXT


Return 1

end function

on w_detalhe.create
this.dw_9=create dw_9
this.dw_7=create dw_7
this.dw_6=create dw_6
this.dw_5=create dw_5
this.cb_1=create cb_1
this.dw_4=create dw_4
this.st_1=create st_1
this.dw_2=create dw_2
this.dw_1=create dw_1
this.ln_1=create ln_1
this.ln_2=create ln_2
this.ln_3=create ln_3
this.ln_4=create ln_4
this.ln_5=create ln_5
this.Control[]={this.dw_9,&
this.dw_7,&
this.dw_6,&
this.dw_5,&
this.cb_1,&
this.dw_4,&
this.st_1,&
this.dw_2,&
this.dw_1,&
this.ln_1,&
this.ln_2,&
this.ln_3,&
this.ln_4,&
this.ln_5}
end on

on w_detalhe.destroy
destroy(this.dw_9)
destroy(this.dw_7)
destroy(this.dw_6)
destroy(this.dw_5)
destroy(this.cb_1)
destroy(this.dw_4)
destroy(this.st_1)
destroy(this.dw_2)
destroy(this.dw_1)
destroy(this.ln_1)
destroy(this.ln_2)
destroy(this.ln_3)
destroy(this.ln_4)
destroy(this.ln_5)
end on

event open;X = 51
Y = 432

iuo_parametro = Create uo_parametro_janelas
iuo_parametro = Message.PowerObjectParm

This.PostEvent("apos_abertura")

end event

type dw_9 from datawindow within w_detalhe
boolean visible = false
integer x = 978
integer y = 1600
integer width = 443
integer height = 428
integer taborder = 30
string dataobject = "dw_detalhe_filial_8"
boolean border = false
boolean livescroll = true
end type

event constructor;This.SetTransObject(SQlCa)
end event

type dw_7 from datawindow within w_detalhe
integer x = 1641
integer y = 1144
integer width = 2907
integer height = 880
integer taborder = 20
string dataobject = "dw_detalhe_filial_7"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event constructor;This.SetTransObject(SqlCa)
end event

type dw_6 from datawindow within w_detalhe
boolean visible = false
integer x = 864
integer y = 1572
integer width = 590
integer height = 520
integer taborder = 10
string dataobject = "dw_detalhe_filial_6"
boolean border = false
boolean livescroll = true
end type

event constructor;This.SetTransObject(SQlCa)
end event

type dw_5 from datawindow within w_detalhe
integer x = 14
integer y = 304
integer width = 2391
integer height = 804
integer taborder = 40
string dataobject = "dw_detalhe_filial_mes"
boolean border = false
boolean livescroll = true
end type

event constructor;This.SetTransObject(SqlCa)
end event

event clicked;String lvs_titulo, lvs_coluna, lvs_sort_atual
Integer lvi_tamanho

If LeftA(This.GetBandAtPointer(), 6) = "header" Then
	lvs_titulo = This.GetObjectAtPointer()
	lvi_tamanho = LenA(lvs_titulo) - 2
	lvs_titulo = LeftA(lvs_titulo, lvi_tamanho)
		
	CHOOSE CASE lvs_titulo
		CASE "de_grupo_t"
			lvs_coluna = "de_grupo"
		CASE "vl_vendas_t"
			lvs_coluna = "vl_vendas"
		CASE "pc_vendas_t"
			lvs_coluna = "pc_vendas"
		CASE "vl_estoque_t"
			lvs_coluna = "vl_estoque"
		CASE "nr_dias_estoque_t"
			lvs_coluna = "nr_dias_estoque"
		CASE ELSE
			Return
	END CHOOSE		

	lvs_sort_atual = This.Object.DataWindow.Table.Sort
	lvi_tamanho = LenA(lvs_sort_atual) - 2
	lvs_titulo = LeftA(lvs_sort_atual, lvi_tamanho)
	If lvs_coluna = lvs_titulo Then
		lvs_sort_atual = RightA(lvs_sort_atual, 1)
		If lvs_sort_atual = "A" Then
			lvs_sort_atual = " D"
		Else
			lvs_sort_atual = " A"
		End If
		lvs_coluna = lvs_coluna + lvs_sort_atual
	End If
	This.SetSort(lvs_coluna)
	This.Sort()
End If

end event

type cb_1 from commandbutton within w_detalhe
integer x = 4064
integer y = 2064
integer width = 439
integer height = 108
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Fechar"
boolean cancel = true
boolean default = true
end type

event clicked;Close(Parent)
end event

type dw_4 from datawindow within w_detalhe
integer x = 27
integer y = 1144
integer width = 1573
integer height = 704
string dataobject = "dw_detalhe_filial_4"
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event constructor;This.SetTransObject(SqlCa)
end event

type st_1 from statictext within w_detalhe
integer x = 14
integer y = 20
integer width = 2391
integer height = 80
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "Resumos Acumulados at$$HEX1$$e900$$ENDHEX$$"
alignment alignment = center!
boolean focusrectangle = false
end type

type dw_2 from datawindow within w_detalhe
integer x = 2427
integer y = 20
integer width = 2126
integer height = 1096
string dataobject = "dw_detalhe_filial_2"
boolean border = false
boolean livescroll = true
end type

event constructor;This.SetTransObject(SqlCa)
end event

type dw_1 from datawindow within w_detalhe
integer x = 14
integer y = 160
integer width = 2391
integer height = 100
string dataobject = "dw_detalhe_filial_5"
boolean border = false
boolean livescroll = true
end type

type ln_1 from line within w_detalhe
long linecolor = 8388608
integer linethickness = 8
integer beginx = 14
integer beginy = 128
integer endx = 2382
integer endy = 128
end type

type ln_2 from line within w_detalhe
long linecolor = 8388608
integer linethickness = 8
integer beginx = 14
integer beginy = 292
integer endx = 2405
integer endy = 292
end type

type ln_3 from line within w_detalhe
long linecolor = 8388608
integer linethickness = 8
integer beginy = 1124
integer endx = 4558
integer endy = 1124
end type

type ln_4 from line within w_detalhe
long linecolor = 8388608
integer linethickness = 8
integer beginx = 2414
integer endx = 2414
integer endy = 1116
end type

type ln_5 from line within w_detalhe
long linecolor = 8388608
integer linethickness = 8
integer beginx = 1609
integer beginy = 1124
integer endx = 1609
integer endy = 2188
end type

