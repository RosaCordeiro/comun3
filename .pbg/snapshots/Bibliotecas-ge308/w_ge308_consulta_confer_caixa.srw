HA$PBExportHeader$w_ge308_consulta_confer_caixa.srw
forward
global type w_ge308_consulta_confer_caixa from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge308_consulta_confer_caixa from dc_w_selecao_lista_relatorio
string tag = "w_ge308_consulta_confer_caixa"
integer width = 2391
integer height = 1780
string title = "GE308 - Consulta Controles de Caixas Pendentes"
end type
global w_ge308_consulta_confer_caixa w_ge308_consulta_confer_caixa

on w_ge308_consulta_confer_caixa.create
call super::create
end on

on w_ge308_consulta_confer_caixa.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;dw_1.Object.dt_inicio		[1] = RelativeDate( Date( gf_getServerDate() ),-3 )
dw_1.Object.dt_termino	[1] = RelativeDate( Date( gf_getServerDate() ),-1 )

This.ivm_Menu.mf_Recuperar(True)

end event

event ue_saveas;call super::ue_saveas;dw_2.Event ue_SaveAs()	
end event

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge308_consulta_confer_caixa
integer x = 23
integer y = 268
integer width = 2299
integer height = 1308
integer weight = 700
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge308_consulta_confer_caixa
integer x = 23
integer y = 8
integer width = 2126
integer height = 244
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge308_consulta_confer_caixa
integer x = 64
integer y = 68
integer width = 2062
integer height = 164
string dataobject = "dw_ge308_selecao"
end type

event dw_1::getfocus;call super::getfocus;This.ivm_Menu.mf_SalvarComo(False)	
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge308_consulta_confer_caixa
integer x = 55
integer y = 344
integer width = 2245
integer height = 1204
string dataobject = "dw_ge308_lista"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_postretrieve;call super::ue_postretrieve;This.ivm_Menu.mf_SalvarComo(pl_Linhas > 0)	

Return pl_Linhas
end event

event dw_2::ue_reset;call super::ue_reset;This.ivm_Menu.mf_SalvarComo(False)	
end event

event dw_2::ue_recuperar;//Override
DateTime ldh_inicio
DateTime ldh_termino

ldh_inicio		= dw_1.Object.dt_inicio		[1]
ldh_termino	= dw_1.Object.dt_termino	[1]

Return dw_2.Retrieve(ldh_inicio,ldh_termino)
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Movimento
String lvs_Situacao

dw_1.Accepttext( )
lvs_Movimento	= dw_1.Object.id_movimento[1]
lvs_Situacao		= dw_1.Object.id_situacao [1]

If  lvs_Movimento = 'S' Then
	dw_2.of_appendwhere("exists (select nf.cd_filial" + &
	                                          	" from nf_venda nf "+ &
											" where nf.cd_filial = f.cd_filial " + &
											" and nf.dh_movimentacao_caixa = cc.dh_movimentacao_caixa)")
End If

If lvs_Situacao <> 'T' Then
	dw_2.of_appendwhere("coalesce(cc.id_situacao,'N')='"+ lvs_Situacao+"'")
End If	

Return 1
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge308_consulta_confer_caixa
boolean visible = false
integer x = 1623
integer y = 40
integer height = 280
end type

