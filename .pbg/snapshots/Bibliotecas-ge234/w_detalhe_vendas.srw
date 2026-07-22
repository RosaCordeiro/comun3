HA$PBExportHeader$w_detalhe_vendas.srw
forward
global type w_detalhe_vendas from dc_w_response_ok_cancela
end type
end forward

global type w_detalhe_vendas from dc_w_response_ok_cancela
integer width = 2496
integer height = 876
string title = "GE234 - Resumo de Faturamento Detalhado"
end type
global w_detalhe_vendas w_detalhe_vendas

type variables
uo_parametro_janelas iuo_parametro

// Farmagora
Decimal ivdc_venda_farmagora_dia, ivdc_venda_farmagora_mes, ivdc_venda_farmagora_ano
Long ivl_cliente_farmagora_dia, ivl_cliente_farmagora_mes, ivl_cliente_farmagora_ano

// Disque Entrega
Decimal ivdc_venda_disque_dia, ivdc_venda_disque_mes, ivdc_venda_disque_ano
Long ivl_cliente_disque_dia, ivl_cliente_disque_mes, ivl_cliente_disque_ano

// Ifood
Decimal ivdc_venda_ifood_dia, ivdc_venda_ifood_mes, ivdc_venda_ifood_ano
Long ivl_cliente_ifood_dia, ivl_cliente_ifood_mes, ivl_cliente_ifood_ano


// Manipulados
Decimal ivdc_venda_manip_dia,  ivdc_venda_manip_mes,  ivdc_venda_manip_ano
Decimal ivdc_Cota_Manip_ano , ivdc_Cota_Manip_Mes , ivdc_Cota_Manip_Dia 
Long ivl_cliente_manip_ano, ivl_cliente_manip_mes, ivl_cliente_manip_dia













 

end variables

forward prototypes
public subroutine wf_atualiza_informacoes ()
public function boolean wf_venda_devolucao ()
public function boolean wf_venda_devolucao_old ()
public function boolean wf_venda_devolucao_manipulado ()
public function boolean wf_cota_filial ()
public function long wf_retorna_filial_cc (long pl_filial)
end prototypes

public subroutine wf_atualiza_informacoes ();Integer lvi_Row
Long  ll_Filial 

wf_venda_devolucao()
wf_venda_devolucao_manipulado()
wf_Cota_Filial()

// Vendas Normais
lvi_Row = dw_1.InsertRow(0)
dw_1.Object.id_tipo_venda		[lvi_Row] = 'N'
dw_1.Object.vl_venda_dia		[lvi_Row] = iuo_Parametro.ivdc_Venda_Dia - ivdc_venda_farmagora_dia - ivdc_venda_disque_dia - ivdc_venda_manip_dia
dw_1.Object.qt_clientes_dia		[lvi_Row] = iuo_Parametro.ivl_Clientes_Dia - ivl_cliente_farmagora_dia - ivl_cliente_disque_dia - ivl_cliente_manip_dia 
dw_1.Object.vl_venda_mes		[lvi_Row] = iuo_Parametro.ivdc_venda_mes - ivdc_venda_farmagora_Mes - ivdc_venda_disque_mes - ivdc_venda_manip_mes
dw_1.Object.qt_clientes_mes	[lvi_Row] = iuo_Parametro.ivl_Clientes_Mes - ivl_cliente_farmagora_Mes - ivl_cliente_disque_mes - ivl_cliente_manip_mes
dw_1.Object.vl_venda_ano		[lvi_Row] = iuo_Parametro.ivdc_venda_ano - ivdc_venda_farmagora_ano - ivdc_venda_disque_ano - ivdc_venda_manip_ano
dw_1.Object.qt_clientes_ano	[lvi_Row] = iuo_Parametro.ivl_Clientes_Ano - ivl_cliente_farmagora_Ano - ivl_cliente_disque_ano - ivl_cliente_manip_ano 


// Produtos Manipulados
lvi_Row = dw_1.InsertRow(0)
dw_1.Object.id_tipo_venda		[lvi_Row] = 'M'
dw_1.Object.vl_venda_dia		[lvi_Row] = ivdc_venda_manip_dia
///dw_1.Object.vl_cota_dia			[lvi_Row] = ivdc_Cota_Manip_Dia
dw_1.Object.qt_clientes_dia		[lvi_Row] = ivl_cliente_manip_dia
dw_1.Object.vl_venda_mes		[lvi_Row] = ivdc_venda_manip_mes
//dw_1.Object.vl_cota_mes		[lvi_Row] = ivdc_Cota_Manip_Mes
dw_1.Object.qt_clientes_mes	[lvi_Row] = ivl_cliente_manip_mes
dw_1.Object.vl_venda_ano		[lvi_Row] = ivdc_venda_manip_ano
//dw_1.Object.vl_cota_ano		[lvi_Row] = ivdc_Cota_Manip_ano
dw_1.Object.qt_clientes_ano	[lvi_Row] = ivl_cliente_manip_ano


// Vendas Farmagora
lvi_Row = dw_1.InsertRow(0)
dw_1.Object.id_tipo_venda		[lvi_Row] = 'F'
dw_1.Object.vl_venda_dia		[lvi_Row] = ivdc_venda_farmagora_dia - ivdc_venda_ifood_dia
dw_1.Object.qt_clientes_dia		[lvi_Row] = ivl_cliente_farmagora_dia - ivl_cliente_ifood_dia
dw_1.Object.vl_venda_mes		[lvi_Row] = ivdc_venda_farmagora_mes - ivdc_venda_ifood_mes
dw_1.Object.qt_clientes_mes	[lvi_Row] = ivl_cliente_farmagora_mes - ivl_cliente_ifood_mes
dw_1.Object.vl_venda_ano		[lvi_Row] = ivdc_venda_farmagora_ano - ivdc_venda_ifood_ano
dw_1.Object.qt_clientes_ano	[lvi_Row] = ivl_cliente_farmagora_ano - ivl_cliente_ifood_ano



// Vendas Disque Entrega
lvi_Row = dw_1.InsertRow(0)
dw_1.Object.id_tipo_venda		[lvi_Row] = 'DI'
dw_1.Object.vl_venda_dia		[lvi_Row] = ivdc_venda_disque_dia
dw_1.Object.qt_clientes_dia		[lvi_Row] = ivl_cliente_disque_dia
dw_1.Object.vl_venda_mes		[lvi_Row] = ivdc_venda_disque_mes
dw_1.Object.qt_clientes_mes	[lvi_Row] = ivl_cliente_disque_mes
dw_1.Object.vl_venda_ano		[lvi_Row] = ivdc_venda_disque_ano
dw_1.Object.qt_clientes_ano	[lvi_Row] = ivl_cliente_disque_ano

// Vendas Ifood
lvi_Row = dw_1.InsertRow(0)
dw_1.Object.id_tipo_venda		[lvi_Row] = 'I'
dw_1.Object.vl_venda_dia		[lvi_Row] = ivdc_venda_ifood_dia
dw_1.Object.qt_clientes_dia		[lvi_Row] = ivl_cliente_ifood_dia
dw_1.Object.vl_venda_mes		[lvi_Row] = ivdc_venda_ifood_mes
dw_1.Object.qt_clientes_mes	[lvi_Row] = ivl_cliente_ifood_mes
dw_1.Object.vl_venda_ano		[lvi_Row] = ivdc_venda_ifood_ano
dw_1.Object.qt_clientes_ano	[lvi_Row] = ivl_cliente_ifood_ano





end subroutine

public function boolean wf_venda_devolucao ();SetPointer(HourGlass!)


///////////////////////////
/// FARMAGORA /
//////////////////////////

///////////// Vendas do dia Farmagora
Select sum(vl_venda - vl_devolucao_venda), sum(qt_cliente_venda - qt_cliente_devolucao)
Into :ivdc_venda_farmagora_dia, :ivl_cliente_farmagora_dia
From resumo_venda_ecommerce
Where cd_filial 					=: iuo_parametro.ivl_filial_umso[1]
    and dh_resumo				=: iuo_Parametro.ivdt_ontem
    and id_loja_ecommerce 	= 'F'
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Verifica$$HEX2$$e700e300$$ENDHEX$$o das vendas di$$HEX1$$e100$$ENDHEX$$ria do farmagora.")
	Return False
End If


If IsNull(ivdc_venda_farmagora_dia) 	Then ivdc_venda_farmagora_dia 		= 0.00
If Isnull(ivl_cliente_farmagora_dia) 		Then	ivl_cliente_farmagora_dia 	= 0

//Vendas do M$$HEX1$$ea00$$ENDHEX$$s Farmagora
Select sum(vl_venda - vl_devolucao_venda), sum(qt_cliente_venda - qt_cliente_devolucao)
Into :ivdc_venda_farmagora_mes, :ivl_cliente_farmagora_mes
From resumo_venda_ecommerce
Where cd_filial 					=: iuo_parametro.ivl_filial_umso[1]
    and dh_resumo				between :iuo_Parametro.ivdh_inicio_mes and :iuo_parametro.ivdt_ontem
    and id_loja_ecommerce 	= 'F'
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Verifica$$HEX2$$e700e300$$ENDHEX$$o das vendas di$$HEX1$$e100$$ENDHEX$$ria dos produtos farmagora.")
	Return False
End If



If IsNull(ivdc_venda_farmagora_mes) 		Then ivdc_venda_farmagora_mes 	= 0.00
If Isnull(ivl_cliente_farmagora_mes) 		Then	ivl_cliente_farmagora_mes 	= 0

// Vendas do Ano Farmagora
Select sum(vl_venda - vl_devolucao_venda), sum(qt_cliente_venda - qt_cliente_devolucao)
Into :ivdc_venda_farmagora_ano, :ivl_cliente_farmagora_ano
From resumo_venda_ecommerce
Where cd_filial 					=: iuo_parametro.ivl_filial_umso[1]
    and dh_resumo				between :iuo_parametro.ivdh_inicio_ano and :iuo_parametro.ivdt_ontem
    and id_loja_ecommerce 	= 'F'
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Verifica$$HEX2$$e700e300$$ENDHEX$$o das vendas di$$HEX1$$e100$$ENDHEX$$ria dos produtos farmagora.")
	Return False
End If

If IsNull(ivdc_venda_farmagora_ano) 	Then ivdc_venda_farmagora_ano 	= 0.00
If Isnull(ivl_cliente_farmagora_ano) 	Then	ivl_cliente_farmagora_ano 	= 0




///////////////////////////
/// DISQUE ENTREGA /
//////////////////////////

Select sum(vl_venda - vl_devolucao_venda), sum(qt_cliente_venda - qt_cliente_devolucao)
Into :ivdc_venda_disque_dia, :ivl_cliente_disque_dia
From resumo_venda_disque_entrega
Where cd_filial 					=: iuo_parametro.ivl_filial_umso[1]
    and dh_resumo				=: iuo_Parametro.ivdt_ontem
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Verifica$$HEX2$$e700e300$$ENDHEX$$o das vendas di$$HEX1$$e100$$ENDHEX$$ria disque.")
	Return False
End If



If IsNull(ivdc_venda_disque_dia) 	Then ivdc_venda_disque_dia 		= 0.00
If Isnull(ivl_cliente_disque_dia) 		Then	ivl_cliente_disque_dia 	= 0

//Vendas do M$$HEX1$$ea00$$ENDHEX$$s DISQUE
Select sum(vl_venda - vl_devolucao_venda), sum(qt_cliente_venda - qt_cliente_devolucao)
Into :ivdc_venda_disque_mes, :ivl_cliente_disque_mes
From resumo_venda_disque_entrega
Where cd_filial 					=: iuo_parametro.ivl_filial_umso[1]
    and dh_resumo				between :iuo_Parametro.ivdh_inicio_mes and :iuo_parametro.ivdt_ontem
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Verifica$$HEX2$$e700e300$$ENDHEX$$o das vendas do m$$HEX1$$ea00$$ENDHEX$$s do disque.")
	Return False
End If


If IsNull(ivdc_venda_disque_mes) 		Then ivdc_venda_disque_mes 	= 0.00
If Isnull(ivl_cliente_disque_mes) 		Then	ivl_cliente_disque_mes 	= 0

Select sum(vl_venda - vl_devolucao_venda), sum(qt_cliente_venda - qt_cliente_devolucao)
Into :ivdc_venda_disque_ano, :ivl_cliente_disque_ano
From resumo_venda_disque_entrega
Where cd_filial 					=: iuo_parametro.ivl_filial_umso[1]
    and dh_resumo				between :iuo_parametro.ivdh_inicio_ano and :iuo_parametro.ivdt_ontem
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Verifica$$HEX2$$e700e300$$ENDHEX$$o das vendas do ano do disque.")
	Return False
End If

If IsNull(ivdc_venda_disque_ano) 	Then ivdc_venda_disque_ano 	= 0.00
If Isnull(ivl_cliente_disque_ano) 	Then	ivl_cliente_disque_ano 	= 0






///////////////////////////
/// Ifood    /
//////////////////////////

Select sum(vl_venda - vl_devolucao_venda), sum(qt_cliente_venda - qt_cliente_devolucao)
Into :ivdc_venda_ifood_dia, :ivl_cliente_ifood_dia
From resumo_venda_ifood
Where cd_filial 					=: iuo_parametro.ivl_filial_umso[1]
    and dh_resumo				=: iuo_Parametro.ivdt_ontem
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Verifica$$HEX2$$e700e300$$ENDHEX$$o das vendas di$$HEX1$$e100$$ENDHEX$$ria disque.")
	Return False
End If



If IsNull(ivdc_venda_ifood_dia) 	Then ivdc_venda_ifood_dia 		= 0.00
If Isnull(ivl_cliente_ifood_dia) 		Then	ivl_cliente_ifood_dia 	= 0

//Vendas do M$$HEX1$$ea00$$ENDHEX$$s IFOOD
Select sum(vl_venda - vl_devolucao_venda), sum(qt_cliente_venda - qt_cliente_devolucao)
Into :ivdc_venda_ifood_mes, :ivl_cliente_ifood_mes
From resumo_venda_ifood
Where cd_filial 					=: iuo_parametro.ivl_filial_umso[1]
    and dh_resumo				between :iuo_Parametro.ivdh_inicio_mes and :iuo_parametro.ivdt_ontem
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Verifica$$HEX2$$e700e300$$ENDHEX$$o das vendas do m$$HEX1$$ea00$$ENDHEX$$s do disque.")
	Return False
End If


If IsNull(ivdc_venda_ifood_mes) 		Then ivdc_venda_ifood_mes 	= 0.00
If Isnull(ivl_cliente_ifood_mes) 		Then	ivl_cliente_ifood_mes 	= 0

Select sum(vl_venda - vl_devolucao_venda), sum(qt_cliente_venda - qt_cliente_devolucao)
Into :ivdc_venda_ifood_ano, :ivl_cliente_ifood_ano
From resumo_venda_ifood
Where cd_filial 					=: iuo_parametro.ivl_filial_umso[1]
    and dh_resumo				between :iuo_parametro.ivdh_inicio_ano and :iuo_parametro.ivdt_ontem
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Verifica$$HEX2$$e700e300$$ENDHEX$$o das vendas do ano do disque.")
	Return False
End If

If IsNull(ivdc_venda_ifood_ano) 	Then ivdc_venda_ifood_ano 	= 0.00
If Isnull(ivl_cliente_ifood_ano) 	Then	ivl_cliente_ifood_ano 	= 0


SetPointer(Arrow!)
Return True
  

end function

public function boolean wf_venda_devolucao_old ();SetPointer(HourGlass!)

// Vendas do dia Farmagora
Select coalesce(sum(n.vl_total_nf),0) - coalesce(sum(dv.vl_total_nf),0), count(n.nr_nf)
Into :ivdc_venda_farmagora_dia, :ivl_cliente_farmagora_dia
From nf_venda n, nf_devolucao_venda dv
Where n.cd_filial 						=: iuo_parametro.ivl_filial_umso[1]
    and n.dh_movimentacao_caixa 	=: iuo_Parametro.ivdt_ontem
    and n.nr_pedido_ecommerce 	is not null
    and n.nr_nf_anexa 				is null
    and n.dh_cancelamento 			is null
    and n.dh_devolucao				is null
    and dv.nr_nf_venda       			=* n.nr_nf
    and dv.cd_filial_venda   			=* n.cd_filial
    and dv.de_especie_venda  		=* n.de_especie
    and dv.de_serie_venda    		=* n.de_serie
    and dv.dh_cancelamento   		is null	
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Verifica$$HEX2$$e700e300$$ENDHEX$$o das vendas di$$HEX1$$e100$$ENDHEX$$ria dos produtos farmagora.")
	Return False
End If

If IsNull(ivdc_venda_farmagora_dia) 	Then ivdc_venda_farmagora_dia 		= 0.00
If Isnull(ivl_cliente_farmagora_dia) 		Then	ivl_cliente_farmagora_dia 	= 0

//Vendas do M$$HEX1$$ea00$$ENDHEX$$s Farmagora
Select sum(n.vl_total_nf) - coalesce(sum(dv.vl_total_nf),0), count(n.nr_nf)
Into :ivdc_venda_farmagora_mes, :ivl_cliente_farmagora_mes
From nf_venda n, nf_devolucao_venda dv
Where n.cd_filial 						=: iuo_parametro.ivl_filial_umso[1]
    and n.dh_movimentacao_caixa 	between :iuo_Parametro.ivdh_inicio_mes and :iuo_parametro.ivdt_ontem
    and n.nr_pedido_ecommerce 	is not null
    and n.nr_nf_anexa 				is null
    and n.dh_cancelamento 			is null
    and n.dh_devolucao				is null
    and dv.nr_nf_venda       			=* n.nr_nf
    and dv.cd_filial_venda   			=* n.cd_filial
    and dv.de_especie_venda  		=* n.de_especie
    and dv.de_serie_venda    		=* n.de_serie
    and dv.dh_cancelamento   		is null	
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Verifica$$HEX2$$e700e300$$ENDHEX$$o das vendas do m$$HEX1$$ea00$$ENDHEX$$s dos produtos farmagora.")
	Return False
End If

If IsNull(ivdc_venda_farmagora_mes) 		Then ivdc_venda_farmagora_mes 	= 0.00
If Isnull(ivl_cliente_farmagora_mes) 		Then	ivl_cliente_farmagora_mes 	= 0

// Vendas do Ano Farmagora
Select sum(n.vl_total_nf) - coalesce(sum(dv.vl_total_nf),0), count(n.nr_nf)
Into :ivdc_venda_farmagora_ano, :ivl_cliente_farmagora_ano
From nf_venda n, nf_devolucao_venda dv
Where n.cd_filial 						=: iuo_parametro.ivl_filial_umso[1]
    and n.dh_movimentacao_caixa between :iuo_parametro.ivdh_inicio_ano and :iuo_parametro.ivdt_ontem
    and n.nr_pedido_ecommerce 	is not null
    and n.nr_nf_anexa 				is null
    and n.dh_cancelamento 			is null
    and n.dh_devolucao				is null
    and dv.nr_nf_venda       			=* n.nr_nf
    and dv.cd_filial_venda   			=* n.cd_filial
    and dv.de_especie_venda  		=* n.de_especie
    and dv.de_serie_venda    		=* n.de_serie
    and dv.dh_cancelamento   		is null	
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Verifica$$HEX2$$e700e300$$ENDHEX$$o das vendas do ano dos produtos farmagora.")
	Return False
End If

If IsNull(ivdc_venda_farmagora_ano) 	Then ivdc_venda_farmagora_ano 	= 0.00
If Isnull(ivl_cliente_farmagora_ano) 	Then	ivl_cliente_farmagora_ano 	= 0

///////////////////////////
/// DISQUE ENTREGA /
//////////////////////////

// Vendas do dia DISQUE
Select sum(vl_total_nf), count(n.nr_nf)
Into :ivdc_venda_disque_dia, :ivl_cliente_disque_dia
From nf_venda n
Where n.cd_filial 						=: iuo_parametro.ivl_filial_umso[1]
    and n.dh_movimentacao_caixa 	=: iuo_Parametro.ivdt_ontem
    and n.nr_pedido_ecommerce 	is null
    and n.nr_pedido_drogaexpress is not null
    and n.nr_nf_anexa 				is null
    and n.dh_cancelamento 			is null
    and n.dh_devolucao				is null
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Verifica$$HEX2$$e700e300$$ENDHEX$$o das vendas di$$HEX1$$e100$$ENDHEX$$ria dos produtos disque.")
	Return False
End If

If IsNull(ivdc_venda_disque_dia) 	Then ivdc_venda_disque_dia 		= 0.00
If Isnull(ivl_cliente_disque_dia) 		Then	ivl_cliente_disque_dia 	= 0

//Vendas do M$$HEX1$$ea00$$ENDHEX$$s DISQUE
Select sum(vl_total_nf), count(n.nr_nf)
Into :ivdc_venda_disque_mes, :ivl_cliente_disque_mes
From nf_venda n
Where n.cd_filial 						=: iuo_parametro.ivl_filial_umso[1]
    and n.dh_movimentacao_caixa 	between :iuo_Parametro.ivdh_inicio_mes and :iuo_parametro.ivdt_ontem
    and n.nr_pedido_ecommerce 	is null
    and n.nr_pedido_drogaexpress is not null
    and n.nr_nf_anexa 				is null
    and n.dh_cancelamento 			is null
    and n.dh_devolucao				is null
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Verifica$$HEX2$$e700e300$$ENDHEX$$o das vendas do m$$HEX1$$ea00$$ENDHEX$$s dos produtos disque.")
	Return False
End If

If IsNull(ivdc_venda_disque_mes) 		Then ivdc_venda_disque_mes 	= 0.00
If Isnull(ivl_cliente_disque_mes) 		Then	ivl_cliente_disque_mes 	= 0

// Vendas do Ano DISQUE
Select sum(vl_total_nf), count(n.nr_nf)
Into :ivdc_venda_disque_ano, :ivl_cliente_disque_ano
From nf_venda n
Where n.cd_filial 						=: iuo_parametro.ivl_filial_umso[1]
    and n.dh_movimentacao_caixa  between :iuo_parametro.ivdh_inicio_ano and :iuo_parametro.ivdt_ontem
    and n.nr_pedido_ecommerce 	is null
    and n.nr_pedido_drogaexpress is not null
    and n.nr_nf_anexa 				is null
    and n.dh_cancelamento 			is null
    and n.dh_devolucao				is null
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Verifica$$HEX2$$e700e300$$ENDHEX$$o das vendas do ano dos produtos disque.")
	Return False
End If

If IsNull(ivdc_venda_disque_ano) 	Then ivdc_venda_disque_ano 	= 0.00
If Isnull(ivl_cliente_disque_ano) 	Then	ivl_cliente_disque_ano 	= 0

SetPointer(Arrow!)

Return True
  

end function

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

If IsNull(ivdc_venda_manip_dia) 	Then ivdc_venda_manip_dia 		= 0.00
If Isnull(ivl_cliente_manip_dia) 		Then	ivl_cliente_manip_dia 	= 0


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

If IsNull(ivdc_venda_manip_mes) 	Then ivdc_venda_manip_mes 		= 0.00
If Isnull(ivl_cliente_manip_mes) 		Then	ivl_cliente_manip_mes 	= 0


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

If IsNull(ivdc_venda_manip_ano) 	Then ivdc_venda_manip_ano 		= 0.00
If Isnull(ivl_cliente_manip_ano) 		Then	ivl_cliente_manip_ano 	= 0


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

on w_detalhe_vendas.create
call super::create
end on

on w_detalhe_vendas.destroy
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

type pb_help from dc_w_response_ok_cancela`pb_help within w_detalhe_vendas
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_detalhe_vendas
integer width = 2427
integer height = 660
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_detalhe_vendas
integer y = 52
integer width = 2350
integer height = 592
string dataobject = "dw_detalhe_filial_new"
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_detalhe_vendas
boolean visible = false
integer x = 3351
integer y = 504
integer width = 201
end type

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_detalhe_vendas
integer x = 2139
integer y = 680
string text = "&Fechar"
end type

