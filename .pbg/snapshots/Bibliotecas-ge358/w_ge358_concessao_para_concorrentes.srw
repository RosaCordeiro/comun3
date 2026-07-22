HA$PBExportHeader$w_ge358_concessao_para_concorrentes.srw
forward
global type w_ge358_concessao_para_concorrentes from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge358_concessao_para_concorrentes from dc_w_selecao_lista_relatorio
string tag = "w_ge358_concessao_para_concorrentes"
integer width = 3090
integer height = 2320
string title = "GE358 - Desconto de Concess$$HEX1$$e300$$ENDHEX$$o para Concorrentes"
end type
global w_ge358_concessao_para_concorrentes w_ge358_concessao_para_concorrentes

type variables
uo_filial						io_Filial //ge009
uo_ge355_concorrente	io_Concorrente
dc_uo_ds_base 			ivds_carga_cobre_preco

STRING ivs_filiais, ivs_nulo
end variables

forward prototypes
public function integer wf_total_utilizado (integer al_filial, date adt_inicio, date adt_fim)
end prototypes

public function integer wf_total_utilizado (integer al_filial, date adt_inicio, date adt_fim);Decimal idc_Total_Utilizado_Mes, idc_Total_Utilizado_Dia

SELECT IsNull(Round(Sum( n.qt_negociada * (	n.vl_preco_unitario * (((Case when n.pc_desconto_negociado > n.pc_desconto_unitario then n.pc_desconto_negociado else n.pc_desconto_unitario end) - n.pc_desconto_unitario) / 100))) ,	2), 0)
	INTO :idc_Total_Utilizado_Mes
FROM cliente_caixa c
	INNER JOIN negociacao_cliente n
	ON n.nr_sequencial_cliente_caixa = c.nr_sequencial
	and n.cd_filial = c.cd_filial
WHERE (c.dh_movimentacao between :adt_inicio AND :adt_fim)
	AND n.cd_filial	 	= :al_filial
	AND n.id_situacao 	= 'A'
	AND c.id_situacao in ( 'A', 'C' )
	AND  NOT EXISTS ( select x.nr_nf FROM nf_venda x 
								  WHERE x.cd_filial  		= c.cd_filial
									 AND x.nr_nf      		= c.nr_nf
									 AND x.de_especie 	= c.de_especie
									 AND x.de_serie   		= c.de_serie
									 AND x.dh_cancelamento IS NOT NULL )
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_msgDbError("Erro ao localizar o valor utilizado durante o m$$HEX1$$ea00$$ENDHEX$$s no cobre pre$$HEX1$$e700$$ENDHEX$$o. Filial: " + String( al_Filial ))
	Return -1
End If

SELECT IsNull(Round(Sum( n.qt_negociada * (	n.vl_preco_unitario * (((Case when n.pc_desconto_negociado > n.pc_desconto_unitario then n.pc_desconto_negociado else n.pc_desconto_unitario end) - n.pc_desconto_unitario) / 100))) ,	2), 0)
	INTO :idc_Total_Utilizado_Dia
FROM cliente_caixa c
	INNER JOIN negociacao_cliente n
	ON n.nr_sequencial_cliente_caixa = c.nr_sequencial
	and n.cd_filial = c.cd_filial
WHERE c.dh_movimentacao = :adt_inicio
	AND n.cd_filial	 	= :al_filial
	AND n.id_situacao 	= 'A'
	AND c.id_situacao in ( 'A', 'C' )
	AND   NOT EXISTS ( select x.nr_nf FROM nf_venda x 
								  WHERE x.cd_filial  		= c.cd_filial
									 AND x.nr_nf      		= c.nr_nf
									 AND x.de_especie 	= c.de_especie
									 AND x.de_serie   		= c.de_serie
									 AND x.dh_cancelamento IS NOT NULL )
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_msgDbError("Erro ao localizar o valor utilizado durante o dia no cobre pre$$HEX1$$e700$$ENDHEX$$o. Filial: " + String( al_Filial ))
	Return -1
End If


If idc_Total_Utilizado_Mes < 0 	or IsNull( idc_Total_Utilizado_Mes ) 	Then idc_Total_Utilizado_Mes = 0
If idc_Total_Utilizado_Dia < 0 	or IsNull( idc_Total_Utilizado_Dia ) 	Then idc_Total_Utilizado_Dia = 0

Return 1
end function

on w_ge358_concessao_para_concorrentes.create
call super::create
end on

on w_ge358_concessao_para_concorrentes.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;DateTime ldh_Atual

io_Filial			= Create uo_filial
io_Concorrente	= Create uo_ge355_concorrente

If Not gf_Data_Parametro(Ref ldh_Atual) Then Return

dw_1.Object.Dh_Inicio		[1] = ldh_Atual
dw_1.Object.Dh_Termino	[1] = ldh_Atual

ivds_carga_cobre_preco = Create dc_uo_ds_base

If Not ivds_carga_cobre_preco.of_changedataobject('dw_ge358_lista_concessao-carga') Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Ocorreu um erro ao tentar alterar para a dw_ge358_lista_concessao-carga. Dados n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e300$$ENDHEX$$o carregados.",StopSign!);
	Destroy(ivds_carga_cobre_preco)
	SqlCa.of_RollBack();
End If
end event

event close;call super::close;Destroy(io_Filial)
Destroy(io_Concorrente)

end event

event ue_saveas;call super::ue_saveas;dw_3.Event ue_SaveAs()
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge358_concessao_para_concorrentes
integer x = 37
integer y = 832
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge358_concessao_para_concorrentes
integer x = 0
integer y = 760
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge358_concessao_para_concorrentes
integer y = 352
integer width = 2962
integer height = 1752
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge358_concessao_para_concorrentes
integer width = 1504
integer height = 320
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge358_concessao_para_concorrentes
integer width = 1317
integer height = 192
string dataobject = "dw_ge358_selecao_concessao"
end type

event dw_1::itemchanged;call super::itemchanged;long lvl_lojas

dw_2.Event ue_Reset()

//ivds_carga_cobre_preco.reset()

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

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge358_concessao_para_concorrentes
integer x = 73
integer y = 408
integer width = 2889
integer height = 1664
string dataobject = "dw_ge358_lista_concessao"
boolean livescroll = false
end type

event dw_2::ue_postretrieve;call super::ue_postretrieve;long 	ll_row, ll_linha_print, ll_linha_atual, ll_concluiu_sim, ll_concluiu_nao
long 	ll_cd_filial, ll_cd_concorrente, ll_cd_concorrente_ant 
string	ls_nm_fantasia, ls_nm_concorrente, ls_concluiu

ll_cd_concorrente_ant = 0
ll_concluiu_sim = 0
ll_concluiu_nao = 0

For ll_row = 1 to ivds_carga_cobre_preco.rowcount()
	
	ll_cd_filial				= ivds_carga_cobre_preco.Object.cd_filial [ll_row]
	ls_nm_fantasia			= ivds_carga_cobre_preco.Object.nm_fantasia [ll_row]
	ll_cd_concorrente		= ivds_carga_cobre_preco.Object.cd_concorrente [ll_row]
	ls_nm_concorrente	= ivds_carga_cobre_preco.Object.nm_concorrente [ll_row]
	ls_concluiu		 		= trim(ivds_carga_cobre_preco.Object.concluiu [ll_row])

	If ll_cd_concorrente <> ll_cd_concorrente_ant  or ll_row = 1 then
		
		ll_concluiu_sim = 0
		ll_concluiu_nao = 0
		
		ll_linha_print = dw_2.insertrow(0)

		if ls_concluiu = 'SIM' then
			ll_concluiu_sim = ll_concluiu_sim + 1
		Else // NAO
			ll_concluiu_nao = ll_concluiu_nao + 1
		End if
	
		dw_2.object.cd_filial[ ll_linha_print ] = ll_cd_filial
		dw_2.object.nm_fantasia[ ll_linha_print ] = ls_nm_fantasia
		dw_2.object.cd_concorrente[ ll_linha_print ] = ll_cd_concorrente
		dw_2.object.nm_concorrente[ ll_linha_print ] = ls_nm_concorrente
		dw_2.object.concluiu_sim[ ll_linha_print ] = ll_concluiu_sim
		dw_2.object.concluiu_nao[ ll_linha_print ] = ll_concluiu_nao

		ll_cd_concorrente_ant = ll_cd_concorrente
		ll_linha_atual = ll_linha_print
	Else

		if ls_concluiu = 'SIM' then
			ll_concluiu_sim = ll_concluiu_sim + 1
		Else // NAO
			ll_concluiu_nao = ll_concluiu_nao + 1
		End if
		
		dw_2.object.concluiu_sim[ ll_linha_atual ] = ll_concluiu_sim
		dw_2.object.concluiu_nao[ ll_linha_atual ] = ll_concluiu_nao
		
	End if
	
Next

pl_linhas = dw_2.rowcount()
This.ivo_Controle_Menu.of_SalvarComo(true)
Return pl_Linhas
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;DateTime ldh_Inicio
DateTime ldh_Termino

String lvs_filial

dw_1.AcceptText()

dw_2.reset()
ivds_carga_cobre_preco.Reset()

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

If lvs_Filial = 'T' Then
	If Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Esta consulta poder$$HEX1$$e100$$ENDHEX$$ demorar, para otimiz$$HEX1$$e100$$ENDHEX$$-la voc$$HEX1$$ea00$$ENDHEX$$ pode especificar uma filial.~rDeseja informar a filial?", Question!,YesNo!,1)=1 Then
		dw_1.Event ue_Pos(1, "id_filiais")
		dw_1.SetFocus()
		Return -1
	End If
End if

If lvs_Filial = 'C' Then
	If Not IsNull(ivs_Filiais) Then
		
		Destroy(ivds_carga_cobre_preco)
		ivds_carga_cobre_preco = Create dc_uo_ds_base

		If Not ivds_carga_cobre_preco.of_changedataobject('dw_ge358_lista_concessao-carga') Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Ocorreu um erro ao tentar alterar para a dw_ge358_lista_concessao-carga. Dados n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e300$$ENDHEX$$o carregados.",StopSign!);
			Destroy(ivds_carga_cobre_preco)
			SqlCa.of_RollBack();
		End If
		
		ivds_carga_cobre_preco.of_AppendWhere("n.cd_filial in (" + ivs_Filiais + ")",1)
		ivds_carga_cobre_preco.of_AppendWhere("n.cd_filial in (" + ivs_Filiais + ")",2)

	End If

End If

Return 1
end event

event dw_2::ue_recuperar;//OverRide

dw_1.AcceptText()

return ivds_carga_cobre_preco.Retrieve(dw_1.Object.Dh_Inicio[1], dw_1.Object.Dh_Termino[1])

end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge358_concessao_para_concorrentes
boolean visible = false
integer x = 78
integer y = 1272
integer width = 3374
integer height = 796
boolean enabled = false
string dataobject = "dw_ge358_lista_concessao"
boolean resizable = true
boolean border = false
borderstyle borderstyle = stylebox!
end type

