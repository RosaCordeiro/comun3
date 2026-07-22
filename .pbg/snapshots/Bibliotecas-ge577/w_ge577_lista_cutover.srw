HA$PBExportHeader$w_ge577_lista_cutover.srw
forward
global type w_ge577_lista_cutover from dc_w_consulta_lista
end type
type cb_rel_f5 from commandbutton within w_ge577_lista_cutover
end type
type cb_rel_un_med_forn_x_clamed from commandbutton within w_ge577_lista_cutover
end type
type cb_rel_hist_consumo_agr from commandbutton within w_ge577_lista_cutover
end type
type cb_rel_hist_consumo_sep from commandbutton within w_ge577_lista_cutover
end type
type cb_add_reg_info from commandbutton within w_ge577_lista_cutover
end type
type cb_1 from commandbutton within w_ge577_lista_cutover
end type
end forward

global type w_ge577_lista_cutover from dc_w_consulta_lista
integer width = 1129
integer height = 960
cb_rel_f5 cb_rel_f5
cb_rel_un_med_forn_x_clamed cb_rel_un_med_forn_x_clamed
cb_rel_hist_consumo_agr cb_rel_hist_consumo_agr
cb_rel_hist_consumo_sep cb_rel_hist_consumo_sep
cb_add_reg_info cb_add_reg_info
cb_1 cb_1
end type
global w_ge577_lista_cutover w_ge577_lista_cutover

on w_ge577_lista_cutover.create
int iCurrent
call super::create
this.cb_rel_f5=create cb_rel_f5
this.cb_rel_un_med_forn_x_clamed=create cb_rel_un_med_forn_x_clamed
this.cb_rel_hist_consumo_agr=create cb_rel_hist_consumo_agr
this.cb_rel_hist_consumo_sep=create cb_rel_hist_consumo_sep
this.cb_add_reg_info=create cb_add_reg_info
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_rel_f5
this.Control[iCurrent+2]=this.cb_rel_un_med_forn_x_clamed
this.Control[iCurrent+3]=this.cb_rel_hist_consumo_agr
this.Control[iCurrent+4]=this.cb_rel_hist_consumo_sep
this.Control[iCurrent+5]=this.cb_add_reg_info
this.Control[iCurrent+6]=this.cb_1
end on

on w_ge577_lista_cutover.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_rel_f5)
destroy(this.cb_rel_un_med_forn_x_clamed)
destroy(this.cb_rel_hist_consumo_agr)
destroy(this.cb_rel_hist_consumo_sep)
destroy(this.cb_add_reg_info)
destroy(this.cb_1)
end on

type dw_visual from dc_w_consulta_lista`dw_visual within w_ge577_lista_cutover
integer x = 2322
integer y = 1180
end type

type gb_aux_visual from dc_w_consulta_lista`gb_aux_visual within w_ge577_lista_cutover
integer x = 2322
integer y = 1492
end type

type dw_1 from dc_w_consulta_lista`dw_1 within w_ge577_lista_cutover
boolean visible = false
integer x = 2322
integer y = 352
end type

type gb_1 from dc_w_consulta_lista`gb_1 within w_ge577_lista_cutover
boolean visible = false
integer x = 1746
integer y = 1320
end type

type cb_rel_f5 from commandbutton within w_ge577_lista_cutover
integer x = 46
integer y = 28
integer width = 1006
integer height = 112
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Relat$$HEX1$$f300$$ENDHEX$$rio F5"
end type

event clicked;DateTime	ldt_dt_atualiz_distrib, ldt_dh_atualiz_estoque
Dec{2}	ldc_vl_preco, ldc_pc_desconto, ldc_vl_compra, ldc_pc_icms, ldc_pc_reducao_base_icms, ldc_pc_comissao_midia, &
			ldc_vl_repasse_icms, ldc_vl_preco_ordem, ldc_pc_desconto_financeiro, ldc_vl_juros, ldc_vl_preco_venda, &
			ldc_vl_icms_st, ldc_vl_base_icms, ldc_vl_icms, ldc_vl_preco_ordem_melhor_compra
Int 		li_arquivo
Long	 	ll_Linhas_Uf, ll_log, ll_Linha_Uf, ll_Linhas, ll_for, ll_qt_est_disponivel, ll_qt_emb_pdr_distrib, &
			ll_nr_dias_pagamento
String	ls_cd_produto_sap, ls_cd_produto_distribuidora, ls_id_situacao, ls_id_situacao_anterior, ls_cd_fornecedor_sap, &
			ls_cd_uf, ls_cd_fornecedor, ls_texto, ls_arquivo

dc_uo_ds_base 				lds, lds_aux, lds_aux_uf
uo_ge577_relatorio_f5	luo_ge577_relatorio_f5


luo_ge577_relatorio_f5	= Create uo_ge577_relatorio_f5

If not luo_ge577_relatorio_f5.of_cria_arquivo('F5', li_arquivo, REF ls_arquivo) Then
	Return -1
End if

If not luo_ge577_relatorio_f5.of_controla_ds(lds, lds_aux, lds_aux_uf) Then
	Return -1
End if

ll_Linhas_Uf	= lds_aux_uf.RowCount()

For ll_Linha_Uf = 1 to ll_Linhas_Uf
	ls_cd_uf 			= lds_aux_uf.object.cd_uf [ll_Linha_Uf]
	ls_cd_fornecedor 	= lds_aux_uf.object.cd_fornecedor_sap[ll_Linha_Uf]

	ll_linhas = lds.Retrieve(ls_cd_uf, ls_cd_fornecedor)
	
	For ll_for = 1 To ll_Linhas		
		If not luo_ge577_relatorio_f5.of_busca_dados(ll_for, &
																   lds, &
																   ls_cd_uf, &
																   ls_cd_fornecedor_sap, &
																   ls_cd_produto_sap, &
																   ldc_vl_repasse_icms, &
																   ldc_vl_preco_ordem, &
																   ldc_pc_desconto_financeiro, &
																   ldc_vl_preco_ordem_melhor_compra, &
																   ldc_vl_juros, &
																   ldc_vl_preco_venda, &
																   ldc_vl_icms_st, &
																   ldc_vl_base_icms, &
																   ldc_vl_icms, &
																   ls_cd_produto_distribuidora, &
																   ll_qt_est_disponivel, &
																   ll_qt_emb_pdr_distrib, &
																   ldt_dt_atualiz_distrib, &
																   ll_nr_dias_pagamento, &
																   ldc_vl_preco, &
																   ldc_pc_desconto, &
																   ldc_vl_compra, &
																   ls_id_situacao, &
																   ls_id_situacao_anterior, &
																   ldc_pc_icms, &
																   ldc_pc_reducao_base_icms, &
																   ldc_pc_comissao_midia, &
																   ldt_dh_atualiz_estoque) Then
			Continue
		End If
	 	
		If Not luo_ge577_relatorio_f5.of_escrever_arquivo(li_arquivo, &
																		  ls_cd_fornecedor, &
																		  ls_cd_uf, &
																		  ls_cd_produto_sap, &
																		  ls_cd_produto_distribuidora, &
																		  ldc_vl_repasse_icms, &
																		  ldc_vl_preco_ordem, &
																		  ldc_pc_desconto_financeiro, &
																		  ldc_vl_juros, &
																		  ldc_vl_preco_venda, &
																		  ldc_vl_icms_st, &
																		  ldc_vl_base_icms, &
																		  ldc_vl_icms, &
																		  ldc_vl_preco, &
																		  ldc_pc_desconto, &
																		  ldc_vl_compra, &
																		  ldc_pc_icms, &
																		  ldc_pc_reducao_base_icms, &
																		  ldc_pc_comissao_midia, &
																		  ll_qt_est_disponivel, &
																		  ll_qt_emb_pdr_distrib, &
																		  ldt_dt_atualiz_distrib, &
																		  ll_nr_dias_pagamento, &
																		  ldt_dh_atualiz_estoque, &
																		  ls_id_situacao, &
																		  ls_id_situacao_anterior)	Then
			Continue
		End If
	Next
Next

FileClose (li_arquivo)

MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Arquivo gerado: ' + ls_arquivo)
end event

type cb_rel_un_med_forn_x_clamed from commandbutton within w_ge577_lista_cutover
integer x = 46
integer y = 152
integer width = 1006
integer height = 108
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Rel Un Forn X Un Clamed"
end type

event clicked;int		li_arquivo
Long		ll_for
String	ls_cd_produto_sap, ls_cd_fornecedor_sap, ls_cd_unidade_fornecedor, ls_cd_unidade_clamed, ls_caminho_arquivo

dc_uo_ds_base 								lds
uo_ge577_relatorio_de_para_un_forn	luo_ge577_relatorio_de_para_un_forn


luo_ge577_relatorio_de_para_un_forn	= Create uo_ge577_relatorio_de_para_un_forn

if not luo_ge577_relatorio_de_para_un_forn.of_criar_arquivo("un_for_x_un_clamed", li_arquivo, ls_caminho_arquivo) Then 
	Return -1
End If

if not luo_ge577_relatorio_de_para_un_forn.of_grava_arquivo_cabecalho(li_arquivo) Then
	Return -1
End If

if not luo_ge577_relatorio_de_para_un_forn.of_controle_ds(lds) Then
	Return -1
End If

for ll_for = 1 to lds.RowCount()
	if Not luo_ge577_relatorio_de_para_un_forn.of_buscar_dados(lds, &
																				  ll_for, &
																				  ls_cd_produto_sap, &
																				  ls_cd_fornecedor_sap, &
																				  ls_cd_unidade_fornecedor, &
																				  ls_cd_unidade_clamed) Then
		Continue
	End If
	
	if Not luo_ge577_relatorio_de_para_un_forn.of_gravar_dados(li_arquivo, &
																				  ls_cd_produto_sap, &
																				  ls_cd_fornecedor_sap, &
																				  ls_cd_unidade_fornecedor, &
																				  ls_cd_unidade_clamed) Then
		Continue
	End If
next

FileClose (li_arquivo)

MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Arquivo gerado: ' + ls_caminho_arquivo)
end event

type cb_rel_hist_consumo_agr from commandbutton within w_ge577_lista_cutover
integer x = 46
integer y = 272
integer width = 1006
integer height = 108
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Rel His. Consumo Agrupado"
end type

event clicked;Date		ld_dh_limite
Int		li_arquivo
Long		ll_for
String	ls_cd_fornecedor_sap, ls_cd_unidade_fornecedor, ls_cd_unidade_clamed, ls_cd_produtos_sap[], &
			ls_arquivo, ls_cd_filiais_sap[]

dc_uo_ds_base 							lds
uo_ge577_relatorio_hist_consumo	luo_ge577_relatorio_hist_consumo
uo_ge040_args							luo_ge040_args


luo_ge577_relatorio_hist_consumo	= Create uo_ge577_relatorio_hist_consumo

if not luo_ge577_relatorio_hist_consumo.of_buscar_arquivo(REF ls_cd_produtos_sap, REF ls_cd_filiais_sap, REF ld_dh_limite) Then
	Return -1
End If

if not luo_ge577_relatorio_hist_consumo.of_criar_arquivo("hist_consumo_agr", li_arquivo, ls_arquivo) Then
	Return -1
End If

if not luo_ge577_relatorio_hist_consumo.of_setar_is_tipo_relatorio("AGR") Then
	Return -1
End If

if not luo_ge577_relatorio_hist_consumo.of_gravar_cabecalho(li_arquivo) Then
	Return -1
End If

if not luo_ge577_relatorio_hist_consumo.of_controle_ds(REF lds, ls_cd_produtos_sap, ls_cd_filiais_sap, ld_dh_limite) Then
	Return -1
End If

for ll_for = 1 to lds.RowCount()
	if Not luo_ge577_relatorio_hist_consumo.of_buscar_dados(lds, &
																			  ll_for, &
																			  luo_ge040_args) Then
		Continue
	End If
	
	if Not luo_ge577_relatorio_hist_consumo.of_gravar_dados(li_arquivo, &
																			  luo_ge040_args) Then
		Continue
	End If
next

FileClose (li_arquivo)

MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Arquivo gerado ' + ls_arquivo)
end event

type cb_rel_hist_consumo_sep from commandbutton within w_ge577_lista_cutover
integer x = 46
integer y = 392
integer width = 1006
integer height = 108
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Rel His. Consumo Sep. por Filial"
end type

event clicked;Date		ld_dh_limite
Int		li_arquivo
Long		ll_for
String	ls_cd_produto_sap, ls_cd_fornecedor_sap, ls_cd_unidade_fornecedor, ls_cd_unidade_clamed, &
			ls_cd_produtos_sap[], ls_arquivo, ls_cd_filiais_sap[]

dc_uo_ds_base 							lds
uo_ge577_relatorio_hist_consumo	luo_ge577_relatorio_hist_consumo
uo_ge040_args							luo_ge040_args


luo_ge577_relatorio_hist_consumo	= Create uo_ge577_relatorio_hist_consumo

if not luo_ge577_relatorio_hist_consumo.of_buscar_arquivo(REF ls_cd_produtos_sap, REF ls_cd_filiais_sap, REF ld_dh_limite) Then
	Return -1
End If

if not luo_ge577_relatorio_hist_consumo.of_criar_arquivo("hist_consumo_sep", li_arquivo, ls_arquivo) Then
	Return -1
End If

if not luo_ge577_relatorio_hist_consumo.of_setar_is_tipo_relatorio("SEP") Then
	Return -1
End If

if not luo_ge577_relatorio_hist_consumo.of_gravar_cabecalho(li_arquivo) Then
	Return -1
End If

if not luo_ge577_relatorio_hist_consumo.of_controle_ds(lds, ls_cd_produtos_sap, ls_cd_filiais_sap, ld_dh_limite) Then
	Return -1
End If

for ll_for = 1 to lds.RowCount()
	if Not luo_ge577_relatorio_hist_consumo.of_buscar_dados(lds, &
																			  ll_for, &
																			  luo_ge040_args) Then
		Continue
	End If
	
	if Not luo_ge577_relatorio_hist_consumo.of_gravar_dados(li_arquivo, &
																			  luo_ge040_args) Then
		Continue
	End If
next

FileClose (li_arquivo)

MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Arquivo gerado ' + ls_arquivo)
end event

type cb_add_reg_info from commandbutton within w_ge577_lista_cutover
integer x = 46
integer y = 512
integer width = 1006
integer height = 108
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Adicionar Registro Info"
end type

event clicked;dc_uo_ds_base 					lds
uo_ge577_add_registro_info	luo_ge577_add_registro_info


luo_ge577_add_registro_info	= Create uo_ge577_add_registro_info
lds									= Create dc_uo_ds_base

if not luo_ge577_add_registro_info.of_controla_ds(lds) Then
	Return -1
End If

if not luo_ge577_add_registro_info.of_insere_registro_info(lds) Then
	Return -1
End If

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Opera$$HEX2$$e700e300$$ENDHEX$$o realizada com sucesso.")
end event

type cb_1 from commandbutton within w_ge577_lista_cutover
integer x = 46
integer y = 632
integer width = 1006
integer height = 108
integer taborder = 40
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Rel Saldo"
end type

event clicked;Int		li_arquivo
Long		ll_for
String	ls_cd_fornecedor_sap, ls_cd_unidade_fornecedor, ls_cd_unidade_clamed, &
			ls_arquivo, ls_cd_filiais_sap[]

dc_uo_ds_base 							lds
uo_ge577_relatorio_saldo			luo_ge577_relatorio_saldo
uo_ge040_args							luo_ge040_args


luo_ge577_relatorio_saldo	= Create uo_ge577_relatorio_saldo

if not luo_ge577_relatorio_saldo.of_buscar_arquivo(REF ls_cd_filiais_sap) Then
	Return -1
End If

if not luo_ge577_relatorio_saldo.of_criar_arquivo("saldo", li_arquivo, ls_arquivo) Then
	Return -1
End If

if not luo_ge577_relatorio_saldo.of_gravar_cabecalho(li_arquivo) Then
	Return -1
End If

if not luo_ge577_relatorio_saldo.of_controle_ds(REF lds, ls_cd_filiais_sap) Then
	Return -1
End If

for ll_for = 1 to lds.RowCount()
	if Not luo_ge577_relatorio_saldo.of_buscar_dados(lds, &
																	 ll_for, &
																	 luo_ge040_args) Then
		Continue
	End If
	
	if Not luo_ge577_relatorio_saldo.of_gravar_dados(li_arquivo, &
																	 luo_ge040_args) Then
		Continue
	End If
next

FileClose (li_arquivo)

MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Arquivo gerado ' + ls_arquivo)
end event

