HA$PBExportHeader$w_ge313_rel_transferencia_prod_vencido.srw
forward
global type w_ge313_rel_transferencia_prod_vencido from dc_w_selecao_lista_relatorio
end type
type cb_exportar from commandbutton within w_ge313_rel_transferencia_prod_vencido
end type
end forward

global type w_ge313_rel_transferencia_prod_vencido from dc_w_selecao_lista_relatorio
string tag = "w_ge313_rel_transferencia_prod_vencido"
integer width = 2011
integer height = 1908
string title = "GE313 - Relat$$HEX1$$f300$$ENDHEX$$rio de Transfer$$HEX1$$ea00$$ENDHEX$$ncia de Produtos Vencidos"
cb_exportar cb_exportar
end type
global w_ge313_rel_transferencia_prod_vencido w_ge313_rel_transferencia_prod_vencido

type variables
uo_filial ivo_filial
uo_ge253_mult ivo_mult
end variables

on w_ge313_rel_transferencia_prod_vencido.create
int iCurrent
call super::create
this.cb_exportar=create cb_exportar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_exportar
end on

on w_ge313_rel_transferencia_prod_vencido.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_exportar)
end on

event ue_postopen;call super::ue_postopen;dw_1.Object.dt_inicial[1] = Today()
dw_1.Object.dt_final  [1] = Today()

This.ivm_Menu.ivb_Permite_Imprimir = True

end event

event ue_saveas;dw_3.Event ue_SaveAs()
end event

event ue_preopen;call super::ue_preopen;ivo_mult = Create uo_ge253_mult
end event

event close;call super::close;Destroy(ivo_mult)
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge313_rel_transferencia_prod_vencido
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge313_rel_transferencia_prod_vencido
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge313_rel_transferencia_prod_vencido
integer x = 14
integer y = 256
integer width = 1952
integer height = 1448
integer weight = 700
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge313_rel_transferencia_prod_vencido
integer x = 14
integer width = 1239
integer height = 228
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge313_rel_transferencia_prod_vencido
integer x = 32
integer y = 80
integer width = 1202
integer height = 152
string dataobject = "dw_ge313_selecao"
end type

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge313_rel_transferencia_prod_vencido
integer x = 46
integer y = 332
integer width = 1874
integer height = 1344
string dataobject = "dw_ge313_lista"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_recuperar;// OverRide
Date 	lvdt_inicial , &
		lvdt_final

String lvs_Conveniencia

dw_1.AcceptText()

lvdt_inicial 			= dw_1.Object.dt_inicial 			[1]
lvdt_final   			= dw_1.Object.dt_final   			[1]
lvs_Conveniencia	= dw_1.Object.id_conveniencia	[1]

If lvs_Conveniencia = "N" Then
	This.of_AppendWhere("substring(p.cd_subcategoria,1,1)<>'4'")	
End If

Return This.Retrieve(lvdt_inicial,lvdt_final)

end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;cb_Exportar.Enabled = (pl_Linhas > 0)
ivm_menu.mf_salvarcomo(pl_linhas > 0)

Return pl_Linhas
end event

event dw_2::ue_reset;call super::ue_reset;cb_Exportar.Enabled = False
ivm_menu.mf_salvarcomo(False)
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge313_rel_transferencia_prod_vencido
integer x = 1655
integer y = 8
integer width = 311
integer height = 184
integer taborder = 50
string dataobject = "dw_ge313_relatorio"
end type

event dw_3::ue_preprint;call super::ue_preprint;Date 	lvdt_inicial , &
		lvdt_final

dw_1.AcceptText()

lvdt_inicial = dw_1.Object.dt_inicial [1]
lvdt_final   = dw_1.Object.dt_final   [1]

This.Object.st_periodo.text = String(lvdt_inicial,"dd/mm/yyyy") + ' $$HEX1$$e000$$ENDHEX$$ ' + &
                              				String(lvdt_final  ,"dd/mm/yyyy")
Return AncestorReturnValue
end event

type cb_exportar from commandbutton within w_ge313_rel_transferencia_prod_vencido
integer x = 1275
integer y = 132
integer width = 521
integer height = 108
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Gerar Exporta$$HEX2$$e700e300$$ENDHEX$$o"
end type

event clicked;Boolean lvb_Sucesso = True

Date 	lvdt_Inicio, &
     	lvdt_Termino
	  
Long 	lvl_Linha         ,&
     	lvl_Filial_Origem ,&
     	lvl_Exportacao

String lvs_Historico

Decimal{2} lvdc_Valor
	  
dw_1.AcceptText()

lvdt_inicio     	= dw_1.Object.dt_inicial[1]
lvdt_termino		= dw_1.Object.dt_final  [1]


If Not IsDate(String(lvdt_inicio, "dd/mm/yyyy")) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data inicial.", StopSign!)
	dw_1.Event ue_Pos(1, "dt_inicial")
	Return
End If

If Not IsDate(String(lvdt_termino, "dd/mm/yyyy")) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data final.", StopSign!)
	dw_1.Event ue_Pos(1, "dt_final")
	Return
End If

If lvdt_termino < lvdt_inicio Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Data final deve ser maior que data inicial.", StopSign!)
	dw_1.Event ue_Pos(1, "dt_inicial")
	Return
End If

Open(w_Aguarde)
w_Aguarde.Title = "Verificando Lan$$HEX1$$e700$$ENDHEX$$amentos..."

lvl_Exportacao = ivo_mult.Of_inicia_lote('GE313VENC', 'VenLctCont', Today())
lvs_Historico = "VLR REF PERDAS C/ PRODUTOS VENCIDOS E DANIFICADOS MES "+String(lvdt_termino,'MM/YYYY')

w_Aguarde.uo_Progress.of_SetMax(dw_2.RowCount())

For lvl_Linha = 1 To dw_2.RowCount()
	lvl_Filial_Origem 	= dw_2.Object.cd_filial_origem[lvl_Linha]
	lvdc_Valor         	= dw_2.Object.valor[lvl_Linha]
	
	If Not ivo_mult.Of_grava_lote_item(	lvl_Exportacao		, &
													lvl_Filial_Origem	, &
													lvdt_termino			, &
													4127					, &
													"D"					, &
													lvdc_Valor			, &
													lvs_Historico			, &
													999				) Then
		lvb_Sucesso = False
		Exit
	End If
	
	w_Aguarde.uo_Progress.of_SetProgress(lvl_Linha)
Next

lvdc_Valor = dw_2.Object.Total[dw_2.RowCount()]
If Not ivo_mult.Of_grava_lote_item(	lvl_Exportacao		, &
												534					, &
												lvdt_termino			, &
												4127					, &
												"C"					, &
												lvdc_Valor			, &
												lvs_Historico			, &
												999				) Then
	lvb_Sucesso = False
End If

Close(w_Aguarde)
		
If lvb_Sucesso Then lvb_Sucesso = ivo_mult.of_finaliza_lote(lvl_Exportacao)

If lvb_Sucesso Then
	SQLCa.Of_Commit()
	//ivo_Mult.of_exporta_lote(lvl_Exportacao,'C:\Users\marlon.kniss\Desktop\SQL\VENCIDOS.txt',False)
	MessageBox("Sucesso!","Registros gravados com sucesso na base.~r~n"+&
					"O arquivo ser$$HEX1$$e100$$ENDHEX$$ importado automaticamente em at$$HEX1$$e900$$ENDHEX$$ 10 minutos.~r~n"+ &
					"Aguarde a importa$$HEX2$$e700e300$$ENDHEX$$o no Mult-M3 e posteriormente fa$$HEX1$$e700$$ENDHEX$$a a confer$$HEX1$$ea00$$ENDHEX$$ncia.") 
Else 
	SQLCa.Of_RollBack()
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Ocorreu uma falha na grava$$HEX2$$e700e300$$ENDHEX$$o do lote ou cancelamento pelo usu$$HEX1$$e100$$ENDHEX$$rio.", Exclamation!)
End If

end event

