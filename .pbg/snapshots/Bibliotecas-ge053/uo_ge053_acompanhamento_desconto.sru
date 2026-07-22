HA$PBExportHeader$uo_ge053_acompanhamento_desconto.sru
forward
global type uo_ge053_acompanhamento_desconto from nonvisualobject
end type
end forward

global type uo_ge053_acompanhamento_desconto from nonvisualobject
end type
global uo_ge053_acompanhamento_desconto uo_ge053_acompanhamento_desconto

forward prototypes
public function boolean of_venda_sem_desconto (long al_filial, date adt_inicio, date adt_termino, ref decimal adc_venda)
public function boolean of_devolucao_sem_desconto (long al_filial, date adt_inicio, date adt_termino, ref decimal adc_devolucao)
end prototypes

public function boolean of_venda_sem_desconto (long al_filial, date adt_inicio, date adt_termino, ref decimal adc_venda);Select sum(round(round(i.vl_preco_praticado * i.qt_vendida, 2) * ((100 - n.pc_desconto) / 100), 2))
Into :adc_Venda
From nf_venda n (index idx_data_filial),
	  item_nf_venda i (index pk_item_nf_venda),
	  produto_geral p (index pk_produto_geral)
Where n.cd_filial = :al_Filial
  and n.dh_movimentacao_caixa between :adt_Inicio and :adt_Termino
  and n.dh_cancelamento is null
  and n.nr_nf_anexa     is null
  and i.cd_filial  = n.cd_filial
  and i.nr_nf      = n.nr_nf
  and i.de_especie = n.de_especie
  and i.de_serie   = n.de_serie
  and p.cd_subcategoria like '7%' 
  and p.cd_produto = i.cd_produto
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o das Vendas sem Desconto da Filial '" + String(al_Filial) + "'")
	Return False
End If

If IsNull(adc_Venda) Then adc_Venda = 0

Return True

end function

public function boolean of_devolucao_sem_desconto (long al_filial, date adt_inicio, date adt_termino, ref decimal adc_devolucao);Select sum(round(round(round(i.vl_preco_unitario * ((100 - i.pc_desconto) / 100), 2) * i.qt_devolvida, 2) * ((100 - n.pc_desconto) / 100), 2))
Into :adc_Devolucao
From nf_devolucao_venda n,
     item_nf_devolucao_venda i
Where n.cd_filial = :al_Filial
  and n.dh_movimentacao_caixa between :adt_Inicio and :adt_Termino
  and n.dh_cancelamento is null
  and i.cd_filial  = n.cd_filial
  and i.nr_nf      = n.nr_nf
  and i.de_especie = n.de_especie
  and i.de_serie   = n.de_serie
//  and i.cd_produto in (select cd_produto from produto_geral where substring(cd_subcategoria, 1, 1) in ('6', '7'))
  and i.cd_produto in (select cd_produto from produto_geral where cd_subcategoria like '7%')
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o das Devolu$$HEX2$$e700f500$$ENDHEX$$es sem Desconto da Filial '" + String(al_Filial) + "'")
	Return False
End If

If IsNull(adc_Devolucao) Then adc_Devolucao = 0

Return True
end function

on uo_ge053_acompanhamento_desconto.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge053_acompanhamento_desconto.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

