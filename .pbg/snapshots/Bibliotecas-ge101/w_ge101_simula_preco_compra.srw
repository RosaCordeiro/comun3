HA$PBExportHeader$w_ge101_simula_preco_compra.srw
forward
global type w_ge101_simula_preco_compra from dc_w_response_ok_cancela
end type
end forward

global type w_ge101_simula_preco_compra from dc_w_response_ok_cancela
integer height = 1448
string title = "GE101 - Simula Pre$$HEX1$$e700$$ENDHEX$$o de Compra"
end type
global w_ge101_simula_preco_compra w_ge101_simula_preco_compra

type variables
st_ge101_simula_preco_compra ist
end variables

forward prototypes
public subroutine wf_atualiza_valores ()
public function boolean wf_calcula_valor_compra (long al_produto, decimal adc_preco_fabrica, string as_fornecedor, string as_uf_forn, decimal adc_pc_ipi, ref decimal adc_proporcao, integer ai_flag)
end prototypes

public subroutine wf_atualiza_valores ();Long ll_Produto

Decimal ldc_Preco_Fabrica, ldc_IPI, ldc_Proporcao, ldc_Margem

String ls_Forn, ls_UF_Forn

dw_1.AcceptText()

ll_Produto			= dw_1.Object.cd_produto			[1]
ls_Forn				= dw_1.Object.cd_fornecedor		[1]
ldc_IPI				= dw_1.Object.pc_IPI					[1]
ls_UF_Forn			= dw_1.Object.cd_uf_fornecedor	[1]
ldc_Margem			= dw_1.Object.pc_margem			[1]

If IsNull(dw_1.Object.vl_preco_venda[1]) or dw_1.Object.vl_preco_venda[1] = 0.00 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o pre$$HEX1$$e700$$ENDHEX$$o de venda.")
	dw_1.Event ue_Pos(1,'vl_preco_venda')
	Return
End If

If IsNull(ldc_Margem) or ldc_Margem = 0.00 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a margem do resultado.")
	dw_1.Event ue_Pos(1,'pc_margem')
	Return
End If

// Chama a fun$$HEX2$$e700e300$$ENDHEX$$o para retornar a proporcionalidade
ldc_Preco_Fabrica = 100

If Not wf_calcula_valor_compra(ll_Produto, ldc_Preco_Fabrica, ls_Forn,  ls_UF_Forn, ldc_IPI, ref ldc_Proporcao, 1) Then Return

ldc_Preco_Fabrica	= round(dw_1.Object.vl_preco_venda[1] * ldc_Proporcao, 2)

ldc_Preco_Fabrica = Round(ldc_Preco_Fabrica * round((100 - ldc_Margem) / 100, 2), 2)

//dw_1.Object.pc_margem				[1]

dw_1.Object.vl_preco_fabrica[1] = ldc_Preco_Fabrica

If Not wf_calcula_valor_compra(ll_Produto, ldc_Preco_Fabrica, ls_Forn,  ls_UF_Forn, ldc_IPI, ref ldc_Proporcao, 2) Then Return
end subroutine

public function boolean wf_calcula_valor_compra (long al_produto, decimal adc_preco_fabrica, string as_fornecedor, string as_uf_forn, decimal adc_pc_ipi, ref decimal adc_proporcao, integer ai_flag);Decimal ldc_Valor_Compra, ldc_PC_ICMS

SetNull(ldc_PC_ICMS)

uo_produto lo_produto
lo_produto = Create uo_Produto

uo_simula_pedido lo_Simula
lo_Simula = Create uo_simula_pedido

lo_produto.of_Localiza_Codigo_Interno(al_produto)

dw_1.Object.vl_fator_conversao	[1]	= lo_produto.vl_fator_conversao
dw_1.Object.nr_ncm					[1]	= lo_produto.nr_classificacao_fiscal

ldc_Valor_Compra = lo_Simula.of_valor_compra_nova(	adc_preco_fabrica, &
																		0.00, &
																		0.00, &
																		'SC', &
																		as_uf_forn,& 
																		lo_produto, &
																		adc_pc_ipi,& 
																		as_fornecedor, &
																		ldc_PC_ICMS)

If ldc_Valor_Compra < 0 Then
	SqlCa.of_Rollback();
	MessageBox("Erro", "Valor de compra calculado $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido.", StopSign!)
	Return False
End If

adc_proporcao = adc_preco_fabrica / ldc_Valor_Compra

//ldc_Resultado2 = round(64.67 * ldc_Resultado, 2)

If ai_flag = 2 Then
	
	dw_1.Object.vl_icms_st						[1] = lo_Simula.vl_icms_st
	//dw_1.Object.vl_repasse						[1] = lo_Simula.vl_repasse
	//dw_1.Object.cd_grupo							[1] = lo_Simula.cd_grupo
	//dw_1.Object.id_icms_normal				[1] = lo_Simula.id_icms_normal
	dw_1.Object.pc_icms							[1] = lo_Simula.pc_icms
	//dw_1.Object.vl_preco_fabrica				[1] = lo_Simula.vl_preco_final_fab
	//dw_1.Object.vl_preco_fabrica				[1] = ldc_Valor_Compra
	dw_1.Object.pc_reducao_icms				[1] = lo_Simula.pc_reducao_base_icms
	
	IF dw_1.Object.pc_reducao_icms[1]  > 0 Then
		dw_1.Object.vl_bc_icms[1] = round((lo_Simula.vl_bc_icms / (100 - dw_1.Object.pc_reducao_icms[1])) * 100 , 2)
	Else
		dw_1.Object.vl_bc_icms[1] = lo_Simula.vl_bc_icms
	End If
	
	dw_1.Object.pc_icms							[1] = lo_Simula.pc_icms_compra
	dw_1.Object.vl_icms							[1] = lo_Simula.vl_icms
	
	dw_1.Object.pc_mva							[1] = lo_Simula.vl_mva
	dw_1.Object.pc_reducao_st					[1] = lo_Simula.pc_Reducao_Base_ST
	dw_1.Object.pc_icms_st						[1] = lo_Simula.pc_icms_venda
	dw_1.Object.vl_icms_st						[1] = lo_Simula.vl_icms_st
	
	dw_1.Object.vl_bc_ipi							[1]	 = lo_Simula.vl_bc_ipi
	dw_1.Object.pc_ipi							[1] = lo_Simula.pc_ipi
	dw_1.Object.vl_ipi								[1]	 = lo_Simula.vl_ipi
			
	dw_1.Object.vl_bc_icms_st					[1] = lo_Simula.vl_bc_icms_st
	
	If lo_Simula.vl_pmc > 0 Then
		dw_1.Object.vl_bc_icms_st				[1] = lo_Simula.vl_pmc
	End If
	
	dw_1.Object.pc_repasse_icms				[1] = lo_Simula.pc_repasse

End If

Destroy lo_produto
Destroy lo_Simula

Return True
end function

on w_ge101_simula_preco_compra.create
call super::create
end on

on w_ge101_simula_preco_compra.destroy
call super::destroy
end on

event open;call super::open;ist = Message.PowerObjectParm	
end event

event ue_postopen;call super::ue_postopen;dw_1.Object.cd_produto[1] = ist.cd_produto
dw_1.Object.de_produto[1] = ist.de_produto

dw_1.Object.cd_fornecedor		[1] = ist.cd_fornecedor
dw_1.Object.nm_razao_social	[1] = ist.nm_razao_social
dw_1.Object.cd_uf_fornecedor	[1] = ist.cd_uf_fornecedor

dw_1.Object.pc_ipi				[1] = ist.pc_ipi

decimal ldc_Preco, ldc_Margem

string ls_Grupo, ls_Lei_Generico

Select pu.vl_preco_venda_atual, v.de_grupo, pg.id_lei_generico, coalesce(pu.pc_margem_resultado_preco, 0)
Into :ldc_Preco, :ls_Grupo, :ls_Lei_Generico, :ldc_Margem
from produto_uf pu
inner join produto_geral pg
	on pg.cd_produto = pu.cd_produto
inner join vw_classificacao_produto v
	on v.cd_subcategoria = pg.cd_subcategoria
where pu.cd_produto = :ist.cd_produto
    and pu.cd_unidade_federacao = 'SC'
Using Sqlca;

If SqlCa.SqlCode = -1 Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao recuperar o valor de venda.")
	Return
End If

dw_1.Object.de_grupo		 			[1] = ls_Grupo
dw_1.Object.vl_preco_venda			[1] = ldc_Preco
dw_1.Object.pc_margem				[1] = ldc_Margem
dw_1.Object.id_lei_generico			[1] = ls_Lei_Generico

wf_atualiza_valores()
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge101_simula_preco_compra
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge101_simula_preco_compra
integer width = 2400
integer height = 1196
integer taborder = 20
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge101_simula_preco_compra
integer x = 46
integer width = 2354
integer height = 1096
integer taborder = 50
string dataobject = "dw_ge101_simulacao_compra"
end type

event dw_1::constructor;call super::constructor;// Habilitar a coluna de sele$$HEX2$$e700e300$$ENDHEX$$o (freform)
This.of_SetColSelection(True)
end event

event dw_1::itemchanged;call super::itemchanged;wf_atualiza_valores()
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge101_simula_preco_compra
boolean visible = false
integer x = 1088
integer y = 1228
integer taborder = 30
end type

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge101_simula_preco_compra
integer x = 2121
integer y = 1224
integer taborder = 40
end type

