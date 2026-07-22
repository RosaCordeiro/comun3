HA$PBExportHeader$w_ge358_acompanhamento_uso.srw
forward
global type w_ge358_acompanhamento_uso from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge358_acompanhamento_uso from dc_w_selecao_lista_relatorio
string tag = "w_ge358_acompanhamento_uso"
integer width = 5102
integer height = 2436
string title = "GE358 - Acompanhamento de Uso"
end type
global w_ge358_acompanhamento_uso w_ge358_acompanhamento_uso

type variables
uo_filial						io_Filial //ge009
uo_produto					io_Produto //ge001

STRING ivs_filiais, ivs_nulo


end variables

forward prototypes
public subroutine of_cota_filial (long al_filial, date adt_mes, integer al_row)
public subroutine of_valor_utilizado_negociacao (long al_filial, date adt_periodo, integer al_row)
end prototypes

public subroutine of_cota_filial (long al_filial, date adt_mes, integer al_row);Date ldt_Ultimo_dia_Mes
Date ldt_primeiro_dia_mes

Decimal ldc_Sum_Cota_Mes_Filial
Decimal ldc_Cota_Dia_Filial

ldt_Ultimo_dia_Mes 	= gf_retorna_ultimo_dia_mes( adt_mes )
ldt_primeiro_dia_mes = gf_primeiro_dia_mes( adt_mes )

SELECT isnull(sum( vl_cota ),0)
INTO :ldc_Sum_Cota_Mes_Filial
FROM cota_filial 
WHERE cd_filial = :al_filial
	and (dh_cota between :ldt_primeiro_dia_mes AND :ldt_Ultimo_dia_Mes)
 Using SqlCa;
	
dw_2.Object.meta_mensal [al_row] = ldc_Sum_Cota_Mes_Filial

If SqlCa.SqlCode = -1 Then
	SqlCa.of_msgDbError( "Erro ao localizar a cota mensal da filial. " +String(al_filial) )
	Return
End If

Select vl_cota
into :ldc_Cota_Dia_Filial
from cota_filial
where cd_filial = :al_filial
	and dh_cota = :adt_mes 
 Using SqlCa;

dw_2.Object.meta_diaria [al_row] = ldc_Cota_Dia_Filial	 
	 
If SqlCa.SqlCode = -1 Then
	SqlCa.of_msgDbError( "Erro ao localizar a cota di$$HEX1$$e100$$ENDHEX$$ria da filial . " +String(al_filial) )
	Return
End If
	 
end subroutine

public subroutine of_valor_utilizado_negociacao (long al_filial, date adt_periodo, integer al_row);Date ldt_Inicio
Date ldt_Termino

Decimal ldc_Total_Utilizado_Mes
Decimal ldc_Total_Utilizado_Dia

ldt_Inicio 	= gf_primeiro_dia_mes ( adt_periodo )
ldt_Termino	= gf_retorna_ultimo_dia_mes ( adt_periodo )

select 
case when min(n.dh_movimentacao_caixa) >= '20190601' then COALESCE( Cast( sum( round(i.vl_preco_unitario * (1-(COALESCE(infd.pc_desconto_maximo, infd.pc_desconto_tabela,0)/100)),2) * i.qt_vendida) - sum(i.vl_preco_praticado*i.qt_vendida) as decimal(15,2)) , 0)
	else COALESCE( Cast( sum( round(i.vl_preco_unitario * (1-(i.pc_desconto_tabela/100)),2) * i.qt_vendida) - sum(i.vl_preco_praticado*i.qt_vendida) as decimal(15,2)) , 0) ENd
	INTO :ldc_Total_Utilizado_Mes
from nf_venda n (index idx_data_filial)
inner join  item_nf_venda i (index pk_item_nf_venda)
 on i.cd_filial		= n.cd_filial 
  and i.nr_nf			= n.nr_nf 
  and i.de_especie	= n.de_especie 
  and i.de_serie		= n.de_serie 
inner join item_nf_venda_desconto infd  (index pk_item_nf_venda_desconto)
 on infd.cd_filial 		= i.cd_filial
  and infd.nr_nf 		= i.nr_nf
  and infd.de_especie 	= i.de_especie
  and infd.de_serie		= i.de_serie
  and infd.cd_produto 	= i.cd_produto
  and coalesce(infd.nr_sequencial,1) = i.nr_sequencial

where n.dh_movimentacao_caixa  between :ldt_Inicio AND :ldt_Termino
  and n.cd_filial = :al_filial
  and n.dh_cancelamento is null
  and n.nr_nf_anexa 		is null
  and i.id_alteracao_preco = 'S' 
  and i.vl_preco_unitario	<> i.vl_preco_praticado
  and infd.id_tipo_desconto = 'NEG'
Using SqlCa;

dw_2.Object.vlr_consumido_mes [al_row] = ldc_Total_Utilizado_Mes

If SqlCa.SqlCode = -1 Then
	SqlCa.of_msgDbError("Erro ao localizar o valor utilizado durante o m$$HEX1$$ea00$$ENDHEX$$s no cobre pre$$HEX1$$e700$$ENDHEX$$o. Filial: " + String( al_Filial ))
End If

adt_periodo = date(gf_getserverdate())
									 
select 
case when min(n.dh_movimentacao_caixa) >= '20190601' then COALESCE( Cast( sum( round(i.vl_preco_unitario * (1-(COALESCE(infd.pc_desconto_maximo, infd.pc_desconto_tabela,0)/100)),2) * i.qt_vendida) - sum(i.vl_preco_praticado*i.qt_vendida) as decimal(15,2)) , 0)
	else COALESCE( Cast( sum( round(i.vl_preco_unitario * (1-(i.pc_desconto_tabela/100)),2) * i.qt_vendida) - sum(i.vl_preco_praticado*i.qt_vendida) as decimal(15,2)) , 0) ENd
	INTO :ldc_Total_Utilizado_Dia
from nf_venda n (index idx_data_filial)
inner join  item_nf_venda i (index pk_item_nf_venda)
 on i.cd_filial		= n.cd_filial 
  and i.nr_nf			= n.nr_nf 
  and i.de_especie	= n.de_especie 
  and i.de_serie		= n.de_serie 
inner join item_nf_venda_desconto infd  (index pk_item_nf_venda_desconto)
 on infd.cd_filial 		= i.cd_filial
  and infd.nr_nf 		= i.nr_nf
  and infd.de_especie 	= i.de_especie
  and infd.de_serie		= i.de_serie
  and infd.cd_produto 	= i.cd_produto
  and coalesce(infd.nr_sequencial,1) = i.nr_sequencial

where n.dh_movimentacao_caixa = :adt_periodo
  and n.cd_filial = :al_filial
  and n.dh_cancelamento is null
  and n.nr_nf_anexa 		is null
  and i.id_alteracao_preco = 'S' 
  and i.vl_preco_unitario	<> i.vl_preco_praticado
  and infd.id_tipo_desconto = 'NEG'
Using SqlCa;

dw_2.Object.vlr_consumido_dia [al_row] = ldc_Total_Utilizado_Dia

If SqlCa.SqlCode = -1 Then
	SqlCa.of_msgDbError("Erro ao localizar o valor utilizado durante o dia no cobre pre$$HEX1$$e700$$ENDHEX$$o. Filial: " + String( al_Filial ))
End If
end subroutine

on w_ge358_acompanhamento_uso.create
call super::create
end on

on w_ge358_acompanhamento_uso.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;DateTime ldh_Atual

io_Filial			= Create uo_filial
io_Produto		= Create uo_produto

If Not gf_Data_Parametro(Ref ldh_Atual) Then Return

dw_1.Object.Dh_Inicio		[1] = ldh_Atual
dw_1.Object.Dh_Termino	[1] = ldh_Atual
end event

event close;call super::close;Destroy(io_Filial)
Destroy(io_Produto)
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge358_acompanhamento_uso
integer x = 37
integer y = 832
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge358_acompanhamento_uso
integer x = 0
integer y = 760
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge358_acompanhamento_uso
integer y = 340
integer width = 4978
integer height = 1880
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge358_acompanhamento_uso
integer width = 1554
integer height = 292
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge358_acompanhamento_uso
integer width = 1394
integer height = 188
string dataobject = "dw_ge358_selecao_acomp_uso"
end type

event dw_1::itemchanged;call super::itemchanged;long lvl_lojas

dw_2.Event ue_Reset()

Choose Case dwo.Name

	Case "id_filiais"
		
		If Data = 'C' Then
		
			ivs_filiais = ivs_nulo 
			
			uo_ge216_filiais uo_filiais
			
			uo_Filiais = Create uo_ge216_filiais
			
			OpenWithParm(w_ge216_selecao_filiais, uo_Filiais)
			
			lvl_Lojas = Message.DoubleParm
			
			If lvl_Lojas > 0 Then
				ivs_filiais = uo_Filiais.ivs_filiais
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma filial foi selecionada.")
			End If
			
			Destroy(uo_Filiais)
			
		End If

End Choose
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge358_acompanhamento_uso
integer y = 404
integer width = 4910
integer height = 1764
string dataobject = "dw_ge358_lista_acomp_uso"
boolean hscrollbar = true
boolean hsplitscroll = true
end type

event dw_2::ue_postretrieve;call super::ue_postretrieve;long ll_row
long ll_cd_filial
date ldt_cota

For ll_row = 1 to dw_2.rowcount()
	
	w_Aguarde.uo_Progress.of_SetMax(dw_2.rowcount())
	
	ll_cd_filial 	= dw_2.getitemnumber( ll_row, 'cd_filial')
	ldt_cota		= dw_2.getitemdate(ll_row, 'dh_cota')
	
	of_valor_utilizado_negociacao(ll_cd_filial, ldt_cota, ll_row)
	of_cota_filial(ll_cd_filial, ldt_cota, ll_row)
	
	w_Aguarde.uo_Progress.of_SetProgress(ll_row)
	
Next

SetRedraw(True)

Close(w_Aguarde)

If dw_2.RowCount() > 0 Then
	dw_2.ivo_Controle_Menu.of_SalvarComo(True)
Else
	dw_2.ivo_Controle_Menu.of_SalvarComo(False)
End If

Return pl_Linhas
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;DateTime ldh_Inicio
DateTime ldh_Termino

Long ll_Concorrente
Long ll_Produto

String ls_Efetivado
String lvs_filial

dw_1.AcceptText()

ldh_Inicio		= dw_1.Object.Dh_Inicio				[1]
ldh_Termino	= dw_1.Object.Dh_Termino			[1]
lvs_Filial 			= dw_1.Object.id_filiais 				[1]

If IsNull(ldh_Inicio) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio.")
	dw_1.Event ue_Pos(1, "dh_inicio")
	Return -1
End If

If IsNull(ldh_Termino) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino.")
	dw_1.Event ue_Pos(1, "dh_termino")
	Return -1
End If

If ldh_Inicio > ldh_Termino Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a data de t$$HEX1$$e900$$ENDHEX$$rmino.")
	dw_1.Event ue_Pos(1, "dh_inicio")
	Return -1
End If

If lvs_Filial = 'C' Then
	If Not IsNull(ivs_Filiais) Then
		This.of_AppendWhere("pcp.cd_filial in (" + ivs_Filiais + ")")
	End If
Else
	If Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Esta consulta poder$$HEX1$$e100$$ENDHEX$$ demorar, para otimiz$$HEX1$$e100$$ENDHEX$$-la voc$$HEX1$$ea00$$ENDHEX$$ pode especificar uma filial.~rDeseja informar a filial?", Question!,YesNo!,1)=1 Then
		dw_1.Event ue_Pos(1, "id_filiais")
		dw_1.SetFocus()
		Return -1
	End If	
End If

Return 1
end event

event dw_2::ue_recuperar;//OverRide

dw_1.AcceptText()

date ldt_inicio, ldt_fim 

ldt_inicio = gf_primeiro_dia_mes(date( dw_1.Object.Dh_Inicio[1]) )
					
ldt_fim	= gf_retorna_ultimo_dia_mes(date(dw_1.Object.Dh_Termino[1]) )

Open(w_aguarde)
w_aguarde.Title = 'Carregando informa$$HEX2$$e700f500$$ENDHEX$$es....'

Return This.Retrieve(ldt_inicio, ldt_fim)
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge358_acompanhamento_uso
integer x = 3168
integer y = 1308
end type

