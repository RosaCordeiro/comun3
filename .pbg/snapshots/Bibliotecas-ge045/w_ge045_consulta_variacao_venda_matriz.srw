HA$PBExportHeader$w_ge045_consulta_variacao_venda_matriz.srw
forward
global type w_ge045_consulta_variacao_venda_matriz from w_ge045_consulta_variacao_venda
end type
end forward

global type w_ge045_consulta_variacao_venda_matriz from w_ge045_consulta_variacao_venda
integer width = 3177
integer height = 2200
end type
global w_ge045_consulta_variacao_venda_matriz w_ge045_consulta_variacao_venda_matriz

forward prototypes
public subroutine wf_atualiza_totais ()
end prototypes

public subroutine wf_atualiza_totais ();Decimal lvdc_Rentabilidade
Decimal lvdc_Venda
Decimal lvdc_CMV
Decimal lvdc_Comissao
Decimal lvdc_Impostos

Long ll_Linha

dw_3.AcceptText()

For ll_Linha = 1 To dw_3.RowCount()
	lvdc_Venda 		= dw_3.Object.Vl_Venda		[ll_Linha]
	lvdc_CMV 		= dw_3.Object.Vl_CMV		[ll_Linha]
	lvdc_Comissao	= dw_3.Object.Vl_Comissao[ll_Linha]
	lvdc_Impostos	= dw_3.Object.Vl_ICMS		[ll_Linha] - dw_3.Object.Vl_Pis_Cofins[ll_Linha]
	
	lvdc_Rentabilidade = lvdc_Venda - lvdc_CMV - lvdc_Comissao - lvdc_Impostos
	
	dw_3.Object.Vl_Rentabilidade[ll_Linha] = lvdc_Rentabilidade
	
	If lvdc_Venda > 0 Then
		dw_3.Object.Perc_Rentabilidade	[ll_Linha] = Round(lvdc_Rentabilidade / lvdc_Venda * 100, 2)
	Else
		dw_3.Object.Perc_Rentabilidade	[ll_Linha] = 0
	End If
Next
end subroutine

on w_ge045_consulta_variacao_venda_matriz.create
call super::create
end on

on w_ge045_consulta_variacao_venda_matriz.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type dw_visual from w_ge045_consulta_variacao_venda`dw_visual within w_ge045_consulta_variacao_venda_matriz
end type

type gb_aux_visual from w_ge045_consulta_variacao_venda`gb_aux_visual within w_ge045_consulta_variacao_venda_matriz
end type

type gb_3 from w_ge045_consulta_variacao_venda`gb_3 within w_ge045_consulta_variacao_venda_matriz
integer width = 3067
integer height = 944
end type

type gb_1 from w_ge045_consulta_variacao_venda`gb_1 within w_ge045_consulta_variacao_venda_matriz
end type

type gb_2 from w_ge045_consulta_variacao_venda`gb_2 within w_ge045_consulta_variacao_venda_matriz
integer width = 3067
end type

type dw_1 from w_ge045_consulta_variacao_venda`dw_1 within w_ge045_consulta_variacao_venda_matriz
end type

type dw_2 from w_ge045_consulta_variacao_venda`dw_2 within w_ge045_consulta_variacao_venda_matriz
integer width = 3013
integer height = 660
string dataobject = "dw_ge045_listadw2_mat"
end type

type dw_3 from w_ge045_consulta_variacao_venda`dw_3 within w_ge045_consulta_variacao_venda_matriz
integer width = 2834
integer height = 848
string dataobject = "dw_ge045_listadw3_mat"
boolean hscrollbar = true
boolean hsplitscroll = true
end type

event dw_3::ue_recuperar;//OverRide
Long ll_Row

dw_2.AcceptText()

ll_row = dw_2.GetRow()

If ll_row <= 0 Then Return 0

Return This.Retrieve(dw_2.Object.cd_filial[ll_row], dw_2.Object.nr_nf[ll_row], dw_2.Object.de_especie[ll_row], dw_2.Object.de_serie[ll_row])
end event

event dw_3::ue_saveas;// Override
Date	lvdt_Inicio,&
		lvdt_Termino

DateTime ldh_Mov_Caixa
		
Decimal lvdc_Rentabilidade
Decimal lvdc_Venda
Decimal lvdc_CMV
Decimal lvdc_Comissao
Decimal lvdc_Impostos

Long	lvl_Linha,&
		lvl_Filial
	 
If This.RowCount() = 0 Then Return

lvdt_Inicio		= Date(dw_1.Object.dt_periodo_de [1])
lvdt_Termino	= Date(dw_1.Object.dt_periodo_ate[1])
lvl_Filial			= dw_1.Object.cd_filial[1]
 
dc_uo_ds_Base lvds

lvds = Create dc_uo_ds_Base

If Not lvds.of_ChangeDataObject("ds_ge045_excel_mat") Then 
	Destroy(lvds)
	Return
End If

SetPointer(HourGlass!)

Open(w_Aguarde)
w_Aguarde.Title = "Preparando Salva em Excel..."

If (Not IsNull(lvl_Filial))and(lvl_Filial > 0) Then
	lvds.of_appendwhere_SubQuery('nf.cd_filial='+String(lvl_Filial), 2)
	lvds.of_appendwhere_SubQuery('nfv1.cd_filial='+String(lvl_Filial), 1)
else
	lvds.of_appendwhere_SubQuery('nf.cd_filial > 0', 2)
	lvds.of_appendwhere_SubQuery('nfv1.cd_filial > 0', 1)
End If

lvds.Retrieve(lvdt_Inicio, lvdt_Termino)

If lvds.RowCount() > 0 Then
	lvds.of_SaveAs("")
End If

Close(w_Aguarde)

SetPointer(Arrow!)

Destroy(lvds)
end event

type dw_4 from w_ge045_consulta_variacao_venda`dw_4 within w_ge045_consulta_variacao_venda_matriz
integer x = 2016
integer y = 20
string dataobject = "dw_ge045_relatorio_mat"
end type

type cbx_sumarizado from w_ge045_consulta_variacao_venda`cbx_sumarizado within w_ge045_consulta_variacao_venda_matriz
integer y = 188
end type

event cbx_sumarizado::clicked;String lvs_Coluna[], &
       lvs_Nome[]
		 
If This.Checked Then
	dw_2.of_ChangeDataObject("dw_ge045_sumarizado_mat")
	lvs_Coluna = {"cd_filial", "nm_fantasia", "preco_liquido","preco_praticado","qtde", "pc_desc"}
	lvs_Nome = {"Filial", "Nome Fantasia", "Pre$$HEX1$$e700$$ENDHEX$$o Unit$$HEX1$$e100$$ENDHEX$$rio","Pre$$HEX1$$e700$$ENDHEX$$o Praticado","Quantidade", "Desconto"}
	dw_2.Width		= 2386
	dw_2.Height		= 1344
	gb_2.Width		= 2441
	gb_2.Height		= 1440
	Parent.Width	= 2537
	gb_3.Visible	= False
	dw_3.Visible	= False
Else
	dw_2.of_ChangeDataObject("dw_ge045_listadw2_mat")	
	lvs_Coluna = {"nr_nf", "de_especie", "de_serie","dh_emissao","dh_movimentacao_caixa","id_tipo_venda", "usuario_usuario_liberacao"}
	lvs_Nome = {"nota", "esp$$HEX1$$e900$$ENDHEX$$cie", "s$$HEX1$$e900$$ENDHEX$$rie","emiss$$HEX1$$e300$$ENDHEX$$o","data de movimenta$$HEX2$$e700e300$$ENDHEX$$o","tipo de venda","usu$$HEX1$$e100$$ENDHEX$$rio"}
	dw_2.Width		= 3008
	dw_2.Height		= 676
	gb_2.Width		= 3063
	gb_2.Height		= 772
	Parent.Width	= 3159
	gb_3.Visible	= True
	dw_3.Visible	= True
End If

dw_2.ivm_Menu.mf_SalvarComo(False)
dw_2.ivo_Controle_Menu.of_Imprimir(False)

dw_2.of_SetSort(lvs_Coluna, lvs_Nome)
dw_2.of_SetFilter(lvs_Coluna, lvs_Nome)		 

dw_2.Event ue_Reset()
dw_3.Event ue_Reset()

dw_2.of_SetRowSelection()
end event

type dw_5 from w_ge045_consulta_variacao_venda`dw_5 within w_ge045_consulta_variacao_venda_matriz
integer x = 2578
integer y = 36
string dataobject = "dw_ge045_relatorio_sumarizado_mat"
end type

