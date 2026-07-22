HA$PBExportHeader$w_ge152_credito_compras_santa_cruz.srw
forward
global type w_ge152_credito_compras_santa_cruz from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge152_credito_compras_santa_cruz from dc_w_selecao_lista_relatorio
integer width = 1568
integer height = 1796
string title = "GE152 - Cr$$HEX1$$e900$$ENDHEX$$dito de Compras Santa Cruz"
end type
global w_ge152_credito_compras_santa_cruz w_ge152_credito_compras_santa_cruz

type variables
DateTime idh_Inicio_Mov_Comp
DateTime idh_Termino_Mov_Comp
DateTime idh_Inicio_Emi_Comp
DateTime idh_Termino_Emi_Comp
DateTime idh_Inicio_Mov_Dev
DateTime idh_Termino_Mov_Dev
end variables

forward prototypes
public function boolean wf_carrega_informacoes ()
end prototypes

public function boolean wf_carrega_informacoes ();Try

Long ll_Linha

dw_2.AcceptText()

dc_uo_ds_base lds_Compra
lds_Compra = Create dc_uo_ds_base

Open(w_Aguarde)
w_Aguarde.Title = "Recuperando informa$$HEX2$$e700f500$$ENDHEX$$es de Compras.... Aguarde."

If Not lds_Compra.of_ChangeDataObject("ds_ge152_valores_compra") Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar o data store 'ds_ge152_valores_compra'.", StopSign!)
	Return False
End If

lds_Compra.Retrieve(idh_Inicio_Mov_Comp, idh_Termino_Mov_Comp, idh_Inicio_Emi_Comp, idh_Termino_Emi_Comp)

//Carrega as informa$$HEX2$$e700f500$$ENDHEX$$es de compra
If lds_Compra.RowCount() > 0 Then
	For ll_Linha = 1 To lds_Compra.RowCount()

		dw_2.Object.Cd_Uf				[ll_Linha] = lds_Compra.Object.Cd_uf						[ll_Linha]
		dw_2.Object.Vl_Total_Produtos[ll_Linha] = lds_Compra.Object.Vl_Total_Produtos			[ll_Linha]
		dw_2.Object.Vl_Icms_St			[ll_Linha] = lds_Compra.Object.Vl_Icms_St					[ll_Linha]
		dw_2.Object.Vl_Total_Nf			[ll_Linha] = lds_Compra.Object.Vl_Total_Nf					[ll_Linha]
		dw_2.Object.Vl_Recuperar		[ll_Linha] = lds_Compra.Object.Vl_Recuperar				[ll_Linha]
	Next
End If

dc_uo_ds_base lds_Devolucao
lds_Devolucao = Create dc_uo_ds_base

w_Aguarde.Title = "Recuperando informa$$HEX2$$e700f500$$ENDHEX$$es de Devolu$$HEX2$$e700f500$$ENDHEX$$es.... Aguarde."

If Not lds_Devolucao.of_ChangeDataObject("ds_ge152_valores_devolucao") Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar o data store 'ds_ge152_valores_devolucao'.", StopSign!)
	Return False
End If

lds_Devolucao.Retrieve(idh_Inicio_Mov_Dev, idh_Termino_Mov_Dev)

//Carrega as informa$$HEX2$$e700f500$$ENDHEX$$es de devolu$$HEX2$$e700e300$$ENDHEX$$o
If lds_Devolucao.RowCount() > 0 Then
	dw_2.Object.Vl_Total_Produtos_Dev	[1] = lds_Devolucao.Object.Vl_Total_Produtos			[1]
	dw_2.Object.Vl_Total_Despesas		[1] = lds_Devolucao.Object.Total_Despesas				[1]
	dw_2.Object.Vl_Total_Nf_Dev			[1] = lds_Devolucao.Object.Vl_Total_Nf					[1]
	dw_2.Object.Vl_Recuperar_Dev		[1] = lds_Devolucao.Object.Vl_Recuperar_Devolucao	[1]
End If

Finally
	If IsValid(lds_Compra)	Then Destroy (lds_Compra)
	If IsValid(lds_Devolucao)	Then Destroy(lds_Devolucao)
	Close(w_Aguarde)
End Try
end function

on w_ge152_credito_compras_santa_cruz.create
call super::create
end on

on w_ge152_credito_compras_santa_cruz.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;DateTime ldh_Periodo

Long ll_Aux_Mes
Long ll_Aux_Ano

String ls_Mes
String ls_Ano
String ls_Aux

dw_1.AcceptText()

ldh_Periodo = gf_GetServerDate()

ls_Mes = MidA(String(ldh_Periodo), 4 ,2)
ls_Ano = MidA(String(ldh_Periodo), 7, 4)

ll_Aux_Mes = Long(ls_Mes)
ll_Aux_Ano = Long(ls_Ano)

If ls_Mes = '01' Then
	ll_Aux_Ano --
	ls_Ano = String(ll_Aux_Ano)
	ls_Mes = '12'
Else
	 ll_Aux_Mes --
	 ls_Mes = String(ll_Aux_Mes)
End If

ls_Aux = '01/' + ls_Mes + '/' + ls_Ano

dw_1.Object.Dh_Periodo[1] = DateTime(ls_Aux)

ivm_Menu.ivb_Permite_Imprimir = True
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge152_credito_compras_santa_cruz
integer x = 37
integer y = 776
integer width = 1381
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge152_credito_compras_santa_cruz
integer x = 0
integer y = 704
integer width = 1472
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge152_credito_compras_santa_cruz
integer y = 192
integer width = 1458
integer height = 1392
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge152_credito_compras_santa_cruz
integer width = 681
integer height = 164
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge152_credito_compras_santa_cruz
integer y = 72
integer width = 617
integer height = 84
string dataobject = "dw_ge152_selecao"
end type

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge152_credito_compras_santa_cruz
integer y = 268
integer width = 1403
integer height = 1292
string dataobject = "dw_ge152_lista"
end type

event dw_2::ue_recuperar;//OverRide

Date ldt_Aux

DateTime ldh_Periodo
DateTime ldh_Compara

Long ll_Aux_Ano
Long ll_Aux_Mes

String ls_Mes
String ls_Ano
String ls_Aux
String ls_Mes_Aux
String ls_Ano_Aux

dw_1.AcceptText()

ldh_Periodo		= dw_1.Object.Dh_Periodo[1]
ldh_Compara	= gf_GetServerDate()

If IsNull(ldh_Periodo) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o per$$HEX1$$ed00$$ENDHEX$$odo.")
	dw_1.Event ue_Pos(1, "dh_periodo")
	Return -1
End If

ls_Aux = String(ldh_Periodo, '01/mm/yyyy')

If DateTime(ls_Aux) > ldh_Compara Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Per$$HEX1$$ed00$$ENDHEX$$odo informado $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido.")
	dw_1.Event ue_Pos(1, "dh_periodo")
	Return -1
End If

ls_Mes = MidA(String(ldh_Periodo), 4, 2)
ls_Ano = MidA(String(ldh_Periodo), 7, 4)

ls_Mes_Aux = MidA(String(ldh_Compara), 4, 2)
ls_Ano_Aux = MidA(String(ldh_Compara), 7, 4)

ldt_Aux = Date(String('06/' + ls_Mes_Aux + '/' + ls_Ano_Aux))

If ldh_Compara < DateTime(ldt_Aux) Then
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Podem existir notas fiscais que ainda n$$HEX1$$e300$$ENDHEX$$o foram confirmadas pelas filiais/Perini." + &
									"~rTem certeza que deseja executar o relat$$HEX1$$f300$$ENDHEX$$rio?", Question!, YesNo!, 2) = 2 Then
		Return -1
	End If
End If

ldt_Aux = gf_Retorna_Ultimo_Dia_Mes(Date('01/' + ls_Mes + '/' + ls_Ano))

If DateTime(ldt_Aux) > ldh_Compara Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O m$$HEX1$$ea00$$ENDHEX$$s ainda n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ fechado.")
	dw_1.Event ue_Pos(1, "dh_periodo")
	Return -1
End If

idh_Inicio_Mov_Comp		= DateTime('01/' + ls_Mes + '/' + ls_Ano)
idh_Termino_Mov_Comp	= ldh_Compara

idh_Inicio_Emi_Comp		= idh_Inicio_Mov_Comp

idh_Inicio_Mov_Dev		= idh_Inicio_Mov_Comp
idh_Termino_Mov_Dev	= DateTime(ldt_Aux)

If ls_Mes = '12' Then
	ll_Aux_Ano = Long(ls_Ano) + 1
	ls_Ano = String(ll_Aux_Ano)
	ls_Mes = '01'
Else
	ll_Aux_Mes = Long(ls_Mes)
	ll_Aux_Mes ++
	ls_Mes = String(ll_Aux_Mes)
End If

ls_Aux = String("01/" + ls_Mes + '/' + ls_Ano)

idh_Termino_Emi_Comp = DateTime(ls_Aux)

If Not wf_Carrega_Informacoes() Then Return -1

Return This.RowCount()
end event

event dw_2::ue_print;call super::ue_print;dw_3.Event ue_Printimmediate()
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	ivm_Menu.ivb_Permite_Imprimir = True
	This.ivo_Controle_Menu.of_SalvarComo(True)
Else
	ivm_Menu.ivb_Permite_Imprimir = False
	This.ivo_Controle_Menu.of_SalvarComo(False)
End If

Return pl_Linhas
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge152_credito_compras_santa_cruz
integer x = 750
integer y = 36
integer width = 626
integer height = 300
string dataobject = "dw_ge152_relatorio"
boolean vscrollbar = false
end type

event dw_3::ue_preprint;call super::ue_preprint;DateTime ldh_Periodo

Integer li_Mes

String ls_Mes
String ls_Ano

dw_1.AcceptText()
dw_3.AcceptText()

ldh_Periodo = dw_1.Object.Dh_Periodo[1]

ls_Mes = MidA(String(ldh_Periodo), 4, 2)
ls_Ano = MidA(String(ldh_Periodo), 7, 4)

li_Mes = Integer(ls_Mes)

ls_Mes = gf_Mes_Extenso(li_Mes)

This.Object.Titulo_Dw.Text = "Entradas de Mercadoria " + ls_Mes + " " + ls_Ano + &
										"~rDistribuidora Santa Cruz"

Return 1
end event

