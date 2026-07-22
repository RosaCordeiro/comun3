HA$PBExportHeader$w_ge643_gera_credito_pis_cofins.srw
forward
global type w_ge643_gera_credito_pis_cofins from dc_w_response
end type
type cb_1 from commandbutton within w_ge643_gera_credito_pis_cofins
end type
type dw_1 from dc_uo_dw_base within w_ge643_gera_credito_pis_cofins
end type
end forward

global type w_ge643_gera_credito_pis_cofins from dc_w_response
string tag = "w_ge643_gera_credito_pis_cofins"
integer width = 2085
integer height = 560
string title = "GE643 - Calcula Cr$$HEX1$$e900$$ENDHEX$$dito Pis/Cofins"
boolean center = true
cb_1 cb_1
dw_1 dw_1
end type
global w_ge643_gera_credito_pis_cofins w_ge643_gera_credito_pis_cofins

on w_ge643_gera_credito_pis_cofins.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.dw_1
end on

on w_ge643_gera_credito_pis_cofins.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.dw_1)
end on

event open;call super::open;dw_1.insertrow(1)

dw_1.setcolumn('dh_periodo')
dw_1.setfocus()
end event

type pb_help from dc_w_response`pb_help within w_ge643_gera_credito_pis_cofins
end type

type cb_1 from commandbutton within w_ge643_gera_credito_pis_cofins
integer x = 1422
integer y = 308
integer width = 402
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Executar"
end type

event clicked;String ls_id_tipo, ls_ano_mes, ls_log
date ldt_data

dw_1.accepttext()

ls_id_tipo = dw_1.object.id_processamento[1]
ldt_data = dw_1.object.dh_periodo[1]

if isnull(ldt_data) or ldt_data = date('01/01/1900') Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", 'O campo Per$$HEX1$$ed00$$ENDHEX$$odo deve ser preenchido.')
	dw_1.setcolumn('dh_periodo')
	dw_1.setfocus()
	return
ENd if

if ldt_data >= date(gf_getserverdate()) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", 'O Per$$HEX1$$ed00$$ENDHEX$$odo preenchido deve ser inferior ao m$$HEX1$$ea00$$ENDHEX$$s atual.')
	dw_1.setcolumn('dh_periodo')
	dw_1.setfocus()
	return
ENd if

ls_ano_mes = string(ldt_data,'yyyy/mm')

Choose Case ls_id_tipo
	Case '1'
		
		If gvo_Aplicacao.ivs_DataSource <> 'central' then 
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", 'O processo de c$$HEX1$$e100$$ENDHEX$$lculo do cr$$HEX1$$e900$$ENDHEX$$dito do PIS/COFINS deve ser realizado apenas na base de Produ$$HEX2$$e700e300$$ENDHEX$$o.')
			return
		End if
		
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja executar a c$$HEX1$$e100$$ENDHEX$$lculo do cr$$HEX1$$e900$$ENDHEX$$dito do PIS/COFINS?", Question!, YesNo!, 2) = 2 Then Return
	Case '2'
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja Gerar a base hist$$HEX1$$f300$$ENDHEX$$rica (Planilha XLS)?", Question!, YesNo!, 2) = 2 Then Return
	Case '3'
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja Gerar o resumo (Planilha XLS)?", Question!, YesNo!, 2) = 2 Then Return
End Choose

uo_ge643_apura_pis_cofins uo

uo = create uo_ge643_apura_pis_cofins

Choose Case ls_id_tipo
	Case '1'
		uo.of_processa_individual(ls_ano_mes, ref ls_log)
	Case '2'
		uo.of_gera_planilha_completo(ls_ano_mes, ref ls_log)
	Case '3'
		uo.of_gera_planilha_resumo(ls_ano_mes, ref ls_log)
End Choose

destroy uo

if ls_log <> '' and not isnull(ls_log) Then
	Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_log)
ENd if

end event

type dw_1 from dc_uo_dw_base within w_ge643_gera_credito_pis_cofins
integer x = 114
integer y = 76
integer width = 1856
integer height = 184
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge643_selecao"
end type

