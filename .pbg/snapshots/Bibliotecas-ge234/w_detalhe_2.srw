HA$PBExportHeader$w_detalhe_2.srw
forward
global type w_detalhe_2 from dc_w_response_ok_cancela
end type
end forward

global type w_detalhe_2 from dc_w_response_ok_cancela
integer width = 4114
integer height = 708
string title = "GE234 - Resumo de Faturamento Detalhado"
end type
global w_detalhe_2 w_detalhe_2

type variables
uo_parametro_janelas iuo_parametro

decimal ivdc_venda_manip_dia, ivdc_venda_manip_mes, ivdc_venda_manip_ano
decimal ivdc_cota_manip_dia, ivdc_Cota_Manip_mes, ivdc_Cota_Manip_ano

long ivl_cliente_manip_dia, ivl_cliente_manip_mes, ivl_cliente_manip_ano


end variables

forward prototypes
public subroutine wf_atualiza_informacoes ()
public function boolean wf_venda_devolucao_manipulado ()
public function boolean wf_cota_filial ()
public function long wf_retorna_filial_cc (long pl_filial)
end prototypes

public subroutine wf_atualiza_informacoes ();Integer lvi_Row

wf_Venda_Devolucao_Manipulado()
wf_Cota_Filial()

lvi_Row = dw_1.InsertRow(0)

// Produtos de dispensa$$HEX2$$e700e300$$ENDHEX$$o
dw_1.Object.id_tipo_venda		[lvi_Row] = 'D'
dw_1.Object.vl_venda_dia		[lvi_Row] = iuo_Parametro.ivdc_Venda_Dia - ivdc_venda_manip_dia
dw_1.Object.vl_cota_dia			[lvi_Row] = iuo_Parametro.ivdc_Cota_Dia - ivdc_Cota_Manip_Dia
dw_1.Object.qt_clientes_dia		[lvi_Row] = iuo_Parametro.ivl_Clientes_Dia - ivl_cliente_manip_dia

dw_1.Object.vl_venda_mes		[lvi_Row] = iuo_Parametro.ivdc_venda_mes - ivdc_venda_manip_Mes
dw_1.Object.vl_cota_mes		[lvi_Row] = iuo_Parametro.ivdc_cota_mes - ivdc_Cota_Manip_Mes
dw_1.Object.qt_clientes_mes	[lvi_Row] = iuo_Parametro.ivl_Clientes_Mes - ivl_cliente_manip_Mes

dw_1.Object.vl_venda_ano		[lvi_Row] = iuo_Parametro.ivdc_venda_ano - ivdc_venda_manip_ano
dw_1.Object.vl_cota_ano		[lvi_Row] = iuo_Parametro.ivdc_cota_ano - ivdc_Cota_Manip_ano
dw_1.Object.qt_clientes_ano	[lvi_Row] = iuo_Parametro.ivl_Clientes_Ano - ivl_cliente_manip_Ano

lvi_Row = dw_1.InsertRow(0)

// Produtos Manipulados
dw_1.Object.id_tipo_venda		[lvi_Row] = 'M'
dw_1.Object.vl_venda_dia		[lvi_Row] = ivdc_venda_manip_dia
dw_1.Object.vl_cota_dia			[lvi_Row] = ivdc_Cota_Manip_Dia
dw_1.Object.qt_clientes_dia		[lvi_Row] = ivl_cliente_manip_dia

dw_1.Object.vl_venda_mes		[lvi_Row] = ivdc_venda_manip_mes
dw_1.Object.vl_cota_mes		[lvi_Row] = ivdc_Cota_Manip_Mes
dw_1.Object.qt_clientes_mes	[lvi_Row] = ivl_cliente_manip_mes

dw_1.Object.vl_venda_ano		[lvi_Row] = ivdc_venda_manip_ano
dw_1.Object.vl_cota_ano		[lvi_Row] = ivdc_Cota_Manip_ano
dw_1.Object.qt_clientes_ano	[lvi_Row] = ivl_cliente_manip_ano

end subroutine

public function boolean wf_venda_devolucao_manipulado ();// Vendas do dia
Select sum(vl_venda - vl_devolucao_venda), 
		sum(qt_cliente_venda - qt_cliente_devolucao)
Into :ivdc_venda_manip_dia, :ivl_cliente_manip_dia
From resumo_venda_manipulado
Where dh_resumo	=: iuo_Parametro.ivdt_ontem
    and cd_filial 		=: iuo_parametro.ivl_filial_umso[1]
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Verifica$$HEX2$$e700e300$$ENDHEX$$o das vendas di$$HEX1$$e100$$ENDHEX$$ria dos produtos manipulados.")
	Return False
End If

// Vendas do M$$HEX1$$ea00$$ENDHEX$$s
Select sum(vl_venda - vl_devolucao_venda), 
		sum(qt_cliente_venda - qt_cliente_devolucao)
Into :ivdc_venda_manip_mes, :ivl_cliente_manip_mes
From resumo_venda_manipulado
Where dh_resumo	between :iuo_Parametro.ivdh_inicio_mes and :iuo_parametro.ivdt_ontem
    and cd_filial 					=: iuo_parametro.ivl_filial_umso[1]
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Verifica$$HEX2$$e700e300$$ENDHEX$$o das vendas do m$$HEX1$$ea00$$ENDHEX$$s dos produtos manipulados.")
	Return False
End If

// Vendas do Ano
Select sum(vl_venda - vl_devolucao_venda), 
		sum(qt_cliente_venda - qt_cliente_devolucao)
Into :ivdc_venda_manip_ano, :ivl_cliente_manip_ano
From resumo_venda_manipulado
Where dh_resumo	between :iuo_parametro.ivdh_inicio_ano and :iuo_parametro.ivdt_ontem
    and cd_filial 					=: iuo_parametro.ivl_filial_umso[1]
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Verifica$$HEX2$$e700e300$$ENDHEX$$o das vendas do ano dos produtos manipulados.")
	Return False
End If

Return True

end function

public function boolean wf_cota_filial ();Long lvl_Filial_CC

lvl_Filial_CC = wf_retorna_filial_cc(iuo_parametro.ivl_filial_umso[1])

// Cota dia
Select sum(vl_cota)
Into :ivdc_Cota_Manip_Dia
From cota_filial
Where cd_filial	= :lvl_Filial_CC
    and dh_cota =: iuo_Parametro.ivdt_ontem
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError('Localiza$$HEX2$$e700e300$$ENDHEX$$o da cota do dia')
	Return False
End If

// Cota dia
Select sum(vl_cota)
Into :ivdc_Cota_Manip_mes
From cota_filial
Where cd_filial	= :lvl_Filial_CC
    and dh_cota	between :iuo_Parametro.ivdh_inicio_mes and :iuo_parametro.ivdt_ontem
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError('Localiza$$HEX2$$e700e300$$ENDHEX$$o da cota do m$$HEX1$$ea00$$ENDHEX$$s')
	Return False
End If

// Cota ANO
Select sum(vl_cota)
Into :ivdc_Cota_Manip_ano
From cota_filial
Where cd_filial	= :lvl_Filial_CC
    and dh_cota	between :iuo_parametro.ivdh_inicio_ano and :iuo_parametro.ivdt_ontem
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError('Localiza$$HEX2$$e700e300$$ENDHEX$$o da cota do ano')
	Return False
End If

Return True
end function

public function long wf_retorna_filial_cc (long pl_filial);Choose Case pl_filial
	Case 723
		Return 873
	Case 786
		Return 985
	Case Else
		Return pl_filial
End Choose
end function

on w_detalhe_2.create
call super::create
end on

on w_detalhe_2.destroy
call super::destroy
end on

event open;call super::open;iuo_parametro = Create uo_parametro_janelas
iuo_parametro = Message.PowerObjectParm

dw_1.Object.venda_dia_t.text = String(iuo_parametro.ivdt_Ontem, 'dd/mm/yyyy')

dw_1.Object.venda_mes_t.text = Upper(gf_Mes_Extenso(Month(iuo_parametro.ivdt_Ontem)))

dw_1.Object.venda_ano_t.text = String(iuo_parametro.ivdt_Ontem, 'yyyy')

wf_Atualiza_Informacoes()
end event

event ue_postopen;// OverRide

ivo_dbError = Create dc_uo_dbError
end event

event ue_preopen;//OverRide

Long lvl_Altura_Total, &
     lvl_Largura_Total, &
	  lvl_Altura_Janela, &
	  lvl_Largura_Janela

Environment lva

If GetEnvironment(lva) <> 1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na identifica$$HEX2$$e700e300$$ENDHEX$$o do ambiente.", Information!)
	Return
End If

lvl_Altura_Total  = lva.ScreenHeight
lvl_Largura_Total = lva.ScreenWidth

lvl_Altura_Total  = PixelsToUnits(lvl_Altura_Total,  YPixelsToUnits!)
lvl_Largura_Total = PixelsToUnits(lvl_Largura_Total, XPixelsToUnits!)

lvl_Altura_Janela  = This.Height
lvl_Largura_Janela = This.Width

//This.X = (lvl_Largura_Total - lvl_Largura_Janela) / 2
//This.Y = (lvl_Altura_Total  - lvl_Altura_Janela)  / 2

This.X = 320
This.Y = 1708
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_detalhe_2
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_detalhe_2
integer width = 4050
integer height = 480
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_detalhe_2
integer width = 3963
integer height = 364
string dataobject = "dw_detalhe_filial"
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_detalhe_2
boolean visible = false
integer x = 3351
integer y = 504
integer width = 201
end type

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_detalhe_2
integer x = 3762
integer y = 504
string text = "&Fechar"
end type

