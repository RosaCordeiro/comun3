HA$PBExportHeader$w_ge169_consulta_prod_nao_movto.srw
forward
global type w_ge169_consulta_prod_nao_movto from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge169_consulta_prod_nao_movto from dc_w_selecao_lista_relatorio
integer width = 2967
integer height = 1476
string title = "GE169 - Produtos em Estoque N$$HEX1$$e300$$ENDHEX$$o Movimentados"
end type
global w_ge169_consulta_prod_nao_movto w_ge169_consulta_prod_nao_movto

type variables
dc_uo_ds_base ivds_Prod_Filial
dc_uo_ds_base ivds_Filial
dc_uo_ds_base ivds_Ult_Movto

uo_Filial ivo_Filial
end variables

forward prototypes
public subroutine wf_insere_padrao ()
end prototypes

public subroutine wf_insere_padrao ();Long ll_Nulo

SetNull(ll_Nulo)

DataWindowChild	ldwc_Child

ldwc_Child  = dw_1.of_InsertRow_DDDW("cd_grupo" )			

ldwc_Child.SetItem(1, "cd_grupo", ll_Nulo)
ldwc_Child.SetItem(1, "de_grupo", "TODOS")

dw_1.Object.cd_grupo[1] = ll_Nulo
end subroutine

on w_ge169_consulta_prod_nao_movto.create
call super::create
end on

on w_ge169_consulta_prod_nao_movto.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_preopen;call super::ue_preopen;ivb_permite_fechar = False
MaxHeight = 9999
MaxWidth = 7550


ivds_Prod_Filial = Create dc_uo_ds_base
ivds_prod_filial.of_changedataobject('ds_ge169_produtos_nao_mov')

ivds_Filial = Create dc_uo_ds_base
ivds_Filial.of_changedataobject('ds_ge169_filial')

ivds_Ult_Movto = Create dc_uo_ds_base
ivds_Ult_Movto.of_changedataobject('ds_ge169_ult_movimento')

ivo_Filial = Create uo_Filial
end event

event close;call super::close;Destroy(ivds_prod_filial)
Destroy(ivds_Filial)
Destroy(ivds_Ult_Movto)
end event

event ue_postopen;call super::ue_postopen;dw_1.Object.dt_analise [1] = Today()

wf_insere_padrao( )

ivm_menu.ivb_permite_imprimir = True
end event

event ue_print;//override
dw_3.Event ue_Print()
end event

event ue_printimmediate;//override
dw_3.Event ue_PrintImmediate()
end event

event ue_saveas;//override
dw_3.Event ue_SaveAs()
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge169_consulta_prod_nao_movto
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge169_consulta_prod_nao_movto
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge169_consulta_prod_nao_movto
integer y = 296
integer width = 2866
integer height = 972
integer weight = 700
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge169_consulta_prod_nao_movto
integer width = 2866
integer height = 272
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge169_consulta_prod_nao_movto
integer width = 2798
integer height = 196
string dataobject = "dw_ge169_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case "nm_filial"
		If Data <> ivo_Filial.Nm_Fantasia Then
			If Data <> '' Then
				Return 1
			Else
				ivo_Filial.of_inicializa( )
				This.Object.cd_filial [Row] = ivo_Filial.cd_filial
			End If
		End If
End Choose
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Filial) Then
	This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
End If
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	Choose Case This.GetColumnName()

		Case "nm_filial"
			ivo_Filial.of_Localiza_Filial(This.GetText())
			
			If ivo_Filial.Localizada Then
				This.Object.Cd_Filial	[1] = ivo_Filial.Cd_Filial
				This.Object.Nm_Filial	[1] = ivo_Filial.Nm_Fantasia
				
			End If
			
	End Choose
End If
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge169_consulta_prod_nao_movto
integer x = 78
integer y = 372
integer width = 2798
integer height = 864
string dataobject = "dw_ge169_lista"
boolean hscrollbar = true
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;Long lvl_Grupo
Long lvl_Filial
Long lvl_Dias

Date lvdt_Ult_Mov
Date lvdt_Analise

dw_1.AcceptText( )

ivds_prod_filial.of_restoresqloriginal( )

lvl_Grupo			= dw_1.Object.cd_grupo		[1]
lvl_Filial			= dw_1.Object.cd_filial		[1]
lvl_Dias			= dw_1.Object.nr_dias		[1]
lvdt_Analise		= gf_retorna_ultimo_dia_mes(dw_1.Object.dt_analise	[1])
If lvdt_Analise > Today() Then lvdt_Analise = Today()
lvdt_Ult_Mov	= RelativeDate(lvdt_Analise, - lvl_Dias)

If lvl_Grupo > 0 Then
	ivds_prod_filial.of_appendwhere("cp.cd_grupo='"+String(lvl_Grupo)+"'")
End If

If IsNull(lvl_Filial) Then
	If MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Sem selecionar filial este relat$$HEX1$$f300$$ENDHEX$$rio poder$$HEX1$$e100$$ENDHEX$$ levar at$$HEX1$$e900$$ENDHEX$$ 2 horas para gerar.~r~n'+ &
								   	'Deseja prosseguir sem preencher a filial?',Exclamation!,YesNo!,2)=2  Then
		dw_1.Event ue_Pos(1,'nm_filial')
		Return -1
	End If
End If

If lvdt_Ult_Mov > Date('2016/07/01') Then
	ivds_prod_filial.of_appendwhere("(s.dh_ultimo_movimento is null or s.dh_ultimo_movimento < '"+String(lvdt_Ult_Mov,'YYYY/MM/DD')+"')")
Else
	ivds_prod_filial.of_appendwhere("not exists (select 1 " + &
															 "from resumo_movto_estq_prd r1 " + &
															 "where r1.cd_produto = s.cd_produto " + &
																"and r1.cd_filial = s.cd_filial " + &
																"and r1.dh_resumo between '"+String(lvdt_Ult_Mov,'YYYY/MM/DD')+"' and '"+String(lvdt_Analise,'YYYY/MM/DD')+"')")
End If

Return AncestorReturnValue
end event

event dw_2::ue_recuperar;//override
//Date lvdt_Inicio
//Date lvdt_Fim
Date lvdt_Saldo

Long lvl_Linha
Long lvl_Filial
Long lvl_Detail
Long lvl_Linha2
//Long lvl_Dias

String ls_Id_Ec

This.SetRedraw(False)
This.Reset()

dw_1.AcceptText( )

lvdt_Saldo	= gf_retorna_ultimo_dia_mes(dw_1.Object.dt_analise [1])
ls_Id_Ec		= dw_1.Object.Id_Ec				[1]
lvl_Filial		= dw_1.Object.cd_filial			[1]

If lvdt_Saldo > Today() Then lvdt_Saldo = Today()
lvdt_Saldo	= gf_primeiro_dia_mes(lvdt_Saldo)

Open(w_Aguarde)

ivds_filial.Retrieve()

ivds_filial.SetFilter('')
ivds_filial.Filter( )

If Not IsNull(lvl_Filial) Then
	ivds_filial.SetFilter("cd_filial =  " + String(lvl_Filial))
	ivds_filial.Filter( )
Else
	If ls_Id_Ec = 'N' Then
		ivds_filial.SetFilter('cd_filial <> 534')
		ivds_filial.Filter( )
	End If
End If

ls_Id_Ec = ivds_prod_filial.GetSQLSelect()

For lvl_Linha = 1 To ivds_filial.RowCount()
	//If lvl_Linha = 4 then Exit //Parar na quarta execu$$HEX2$$e700e300$$ENDHEX$$o para teste desenvolvimento
	w_Aguarde.uo_Progress.of_SetMax(ivds_filial.RowCount())
	lvl_Filial = ivds_filial.Object.cd_filial [lvl_Linha]
	w_Aguarde.Title = 'Recuperando Informa$$HEX2$$e700f500$$ENDHEX$$es Filial '+String(lvl_Filial)+'...'
	ivds_prod_filial.Retrieve(lvdt_Saldo,lvl_Filial)
		
	w_Aguarde.Title = 'Atualizando Informa$$HEX2$$e700f500$$ENDHEX$$es Filial '+String(lvl_Filial)+'...'
	For lvl_Detail = 1 To ivds_prod_filial.RowCount()
		w_Aguarde.uo_Progress.of_SetMax(ivds_prod_filial.RowCount())
		w_Aguarde.uo_Progress.of_SetProgress(lvl_Detail)
		
		lvl_Linha2 = This.InsertRow(0)
		This.Object.cd_filial				[lvl_Linha2] = ivds_prod_filial.Object.cd_filial 					[lvl_Detail]
		This.Object.cd_produto			[lvl_Linha2] = ivds_prod_filial.Object.cd_produto 				[lvl_Detail]
		This.Object.de_produto			[lvl_Linha2] = ivds_prod_filial.Object.de_produto 				[lvl_Detail]
		This.Object.id_situacao			[lvl_Linha2] = ivds_prod_filial.Object.id_situacao 				[lvl_Detail]
		This.Object.cd_grupo_psico		[lvl_Linha2] = ivds_prod_filial.Object.cd_grupo_psico			[lvl_Detail]
		This.Object.cd_fornecedor		[lvl_Linha2] = ivds_prod_filial.Object.cd_fornecedor			[lvl_Detail]
		This.Object.nm_fornecedor		[lvl_Linha2] = ivds_prod_filial.Object.nm_fornecedor			[lvl_Detail]
		This.Object.cd_mix_produto		[lvl_Linha2] = ivds_prod_filial.Object.cd_mix_produto			[lvl_Detail]
		This.Object.vl_fator_conversao	[lvl_Linha2] = ivds_prod_filial.Object.vl_fator_conversao		[lvl_Detail]
		This.Object.de_subcategoria	[lvl_Linha2] = ivds_prod_filial.Object.de_subcategoria		[lvl_Detail]
		This.Object.de_grupo				[lvl_Linha2] = ivds_prod_filial.Object.de_grupo					[lvl_Detail]
		This.Object.cd_grupo				[lvl_Linha2] = ivds_prod_filial.Object.cd_grupo					[lvl_Detail]
		This.Object.qt_estoque_base	[lvl_Linha2] = ivds_prod_filial.Object.qt_estoque_base		[lvl_Detail]		
		This.Object.dt_movimento		[lvl_Linha2] = ivds_prod_filial.Object.dt_movimento			[lvl_Detail]
		This.Object.qt_saldo				[lvl_Linha2] = ivds_prod_filial.Object.qt_saldo					[lvl_Detail]
		This.Object.vl_custo_medio		[lvl_Linha2] = ivds_prod_filial.Object.vl_custo_medio			[lvl_Detail]
		This.Object.dt_movimento		[lvl_Linha2] = ivds_prod_filial.Object.dh_ultimo_movimento	[lvl_Detail]
		This.Object.vl_total_custo		[lvl_Linha2] = ivds_prod_filial.Object.qt_saldo					[lvl_Detail] * ivds_prod_filial.Object.vl_custo_medio		[lvl_Detail]
	Next
	w_Aguarde.uo_Progress.of_SetProgress(lvl_Linha)
	w_Aguarde.Show()
	Yield()
Next
Close(w_Aguarde)
This.SetRedraw(True)

Return This.RowCount()
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;Long lvl_Linha
Long lvl_Produto
Long lvl_Filial
Long lvl_Dias

Date lvdt_Data
Date lvdt_Fim
Date lvdt_Ult_Mov

dw_1.AcceptText( )

lvl_Dias		= dw_1.Object.nr_dias		[1]
lvdt_Fim		= gf_retorna_ultimo_dia_mes(dw_1.Object.dt_analise [1])
If lvdt_Fim > Today() Then lvdt_Fim = Today()
lvdt_Data	= RelativeDate(lvdt_Fim, - lvl_Dias)

ivm_menu.mf_SalvarComo(pl_linhas > 0)
ivm_menu.mf_Imprimir(pl_linhas > 0)

Open(w_aguarde)
w_aguarde.uo_Progress.of_SetMax(pl_linhas)
w_aguarde.Title = 'Recuperando $$HEX1$$fa00$$ENDHEX$$ltima data de movimento...'
For lvl_Linha = 1 To pl_linhas
	w_aguarde.uo_Progress.of_SetProgress(lvl_Linha)
	
	lvl_Produto	= This.Object.cd_produto	[lvl_Linha]
	lvl_Filial		= This.Object.cd_filial			[lvl_Linha]
	lvdt_Ult_Mov= This.Object.dt_movimento[lvl_Linha]
	
	If Not IsNull(lvdt_Ult_Mov) Then Continue
	
	If ivds_Ult_Movto.Retrieve(lvl_Filial,lvl_Produto,lvdt_Data) > 0 Then
		This.Object.dt_movimento [lvl_linha] = ivds_Ult_Movto.Object.dh_resumo [1]
	End if
Next
Close(w_aguarde)

Return AncestorReturnValue


end event

event dw_2::ue_reset;call super::ue_reset;ivm_menu.mf_SalvarComo(False)
ivm_menu.mf_Imprimir(False)
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge169_consulta_prod_nao_movto
integer x = 1947
integer y = 828
string dataobject = "dw_ge169_relatorio"
end type

event dw_3::ue_preprint;call super::ue_preprint;Date lvdt_Ref
Long lvl_Dias

dw_1.AcceptText( )
lvl_Dias		= dw_1.Object.nr_dias [1]
lvdt_Ref		= gf_retorna_ultimo_dia_mes(dw_1.Object.dt_analise [1])
If lvdt_Ref > Today() Then lvdt_Ref = Today()

If ivo_filial.cd_filial > 0 Then
	This.Object.st_filial.Text = 'Filial: '+ivo_filial.nm_fantasia+' ('+String(ivo_filial.cd_filial)+')'
Else
	This.Object.st_filial.Text = 'Filial: TODAS'
End If

This.Object.st_grupo.Text = 'Grupo: '+dw_1.Describe("Evaluate('LookUpDisplay(cd_grupo)',1)")
This.Object.st_data_ref.Text = 'Data Ref.: '+String(lvdt_Ref,'DD/MM/YYYY')
This.Object.st_titulo.Text = 'Produtos Estocados N$$HEX1$$e300$$ENDHEX$$o Movimentados desde '+String(RelativeDate(lvdt_Ref, - lvl_Dias),'DD/MM/YYYY')

Return AncestorReturnValue
end event

event dw_3::ue_saveas;//override
This.Event ue_PrePrint()

SUPER::EVENT ue_SaveAs()
end event

