HA$PBExportHeader$w_ge600_inversoes_corretivas.srw
$PBExportComments$tela para corrigir problemas de subidas pro CAR erroneas
forward
global type w_ge600_inversoes_corretivas from dc_w_2tab_consulta_selecao_lista_2det
end type
end forward

global type w_ge600_inversoes_corretivas from dc_w_2tab_consulta_selecao_lista_2det
integer width = 5285
integer height = 1920
boolean maxbox = true
boolean clientedge = true
end type
global w_ge600_inversoes_corretivas w_ge600_inversoes_corretivas

type variables
long ivl_Filial
date ivdt_dt_inicio, ivdt_dt_final
char ivc_id_grava_xml
Decimal{0} ivdc_Nr_Nf, ivdc_id_selecao, ivdc_nsu, ivdc_pedido
Decimal{2} ivdc_valor
			
end variables

on w_ge600_inversoes_corretivas.create
call super::create
end on

on w_ge600_inversoes_corretivas.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event resize;call super::resize;

Tab_1.Height	= NewHeight - Tab_1.Y - 16
Tab_1.Width	= NewWidth - Tab_1.X - 16

//dw2
Tab_1.Tabpage_1.gb_2.Height 	=  Tab_1.Height - Tab_1.Tabpage_1.gb_2.Y - 140
Tab_1.Tabpage_1.dw_2.Height 	=  Tab_1.Height - Tab_1.Tabpage_1.dw_2.Y - 170

Tab_1.Tabpage_1.gb_2.Width 	=  Tab_1.Width - Tab_1.Tabpage_1.gb_2.X - 100
Tab_1.Tabpage_1.dw_2.Width =  Tab_1.Width - Tab_1.Tabpage_1.dw_2.X - 140

////dw3
//Tab_1.Tabpage_2.gb_3.Height 	=  Tab_1.Height - Tab_1.Tabpage_2.gb_3.Y - 140
//Tab_1.Tabpage_2.dw_3.Height 	=  Tab_1.Height - Tab_1.Tabpage_2.dw_3.Y - 170
//
//Tab_1.Tabpage_2.gb_3.Width 	=  Tab_1.Width - Tab_1.Tabpage_2.gb_3.X - 100
//Tab_1.Tabpage_2.dw_3.Width =  Tab_1.Width - Tab_1.Tabpage_2.dw_3.X - 140
end event

event ue_preopen;call super::ue_preopen;
Maxheight = 9999
ivl_largura_1 = 5530 
ivl_largura_2 = 5530

ivl_Altura_2  = This.Height
end event

type dw_visual from dc_w_2tab_consulta_selecao_lista_2det`dw_visual within w_ge600_inversoes_corretivas
end type

type gb_aux_visual from dc_w_2tab_consulta_selecao_lista_2det`gb_aux_visual within w_ge600_inversoes_corretivas
end type

type tab_1 from dc_w_2tab_consulta_selecao_lista_2det`tab_1 within w_ge600_inversoes_corretivas
integer x = 0
integer y = 0
integer width = 5120
integer height = 1680
end type

event tab_1::selectionchanged;call super::selectionchanged;
if newindex = 2 then
	if isnull(ivdc_id_selecao) or ivdc_id_selecao = 0 then
		messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Selecione uma linha para fazer a invers$$HEX1$$e300$$ENDHEX$$o que contenha um cart$$HEX1$$e300$$ENDHEX$$o.')
		return -1
	end if
end if
end event

type tabpage_1 from dc_w_2tab_consulta_selecao_lista_2det`tabpage_1 within tab_1
integer width = 5083
integer height = 1564
end type

type gb_2 from dc_w_2tab_consulta_selecao_lista_2det`gb_2 within tabpage_1
integer y = 204
integer width = 5029
integer height = 1252
string text = "Painel"
end type

type gb_1 from dc_w_2tab_consulta_selecao_lista_2det`gb_1 within tabpage_1
integer x = 18
integer y = 0
integer width = 3954
integer height = 204
end type

type dw_1 from dc_w_2tab_consulta_selecao_lista_2det`dw_1 within tabpage_1
integer y = 52
integer width = 3890
integer height = 144
string dataobject = "dw_ge600_get"
end type

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.name
	case 'dt_inicio'
		  this.object.dt_final[1] = date( Data ) 
end choose
end event

type dw_2 from dc_w_2tab_consulta_selecao_lista_2det`dw_2 within tabpage_1
integer x = 55
integer y = 260
integer width = 4969
integer height = 1172
string dataobject = "dw_ge600_lista"
boolean maxbox = true
boolean hscrollbar = true
boolean resizable = true
boolean border = true
boolean hsplitscroll = true
boolean ivb_selecao_linhas = true
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;Parent.dw_1.Accepttext( )

ivdt_dt_inicio 		= Parent.dw_1.Object.dt_inicio[1]
ivdt_dt_final 		= Parent.dw_1.Object.dt_final[1]
ivl_Filial 				= Parent.dw_1.Object.id_filial[1]
ivc_id_grava_xml 	= Parent.dw_1.Object.id_grava_xml[1]
ivdc_Nr_Nf 			= Parent.dw_1.Object.nr_nf[1]
ivdc_nsu 				= Parent.dw_1.Object.nsu[1]
ivdc_pedido			= Parent.dw_1.Object.pedido[1]

if ivdt_dt_inicio > ivdt_dt_final then  ///posterior liberarei datas diferentes
	messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Datas informadas inv$$HEX1$$e100$$ENDHEX$$lidas!')
	return -1
end if

if isnull(ivdc_Nr_Nf) and isnull(ivdc_nsu) and isnull(ivdc_pedido) and (ivdc_valor > 0.00) then
	messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Favor informar uma forma de busca no filtro!')
	return -1
end if

if not isnull(ivdc_nsu) then //NSU
	select top 1 cco.nr_nf
	into :ivdc_Nr_Nf
	from cartao_comprovante_operacao cco 
	where cco.cd_filial = :ivl_Filial
		and charindex(cast(:ivdc_nsu as varchar), cco.nr_nsu) > 0
		and cast(cco.dh_operacao as date) between dateadd(dd,-30,cast(:ivdt_dt_inicio as date)) and dateadd(dd,30,cast(:ivdt_dt_final as date))
	using sqlca;
	
	if (sqlca.sqlcode = 0) and (sqlca.sqlnrows > 0) and isnull(ivdc_Nr_Nf) then
		if isnull(ivdc_Nr_Nf) then
			messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Busca na tabela de cart$$HEX1$$e300$$ENDHEX$$o usando a NSU retornou linha mas n$$HEX1$$e300$$ENDHEX$$o existe venda preenchido.')
			return -1
		end if
	elseif sqlca.sqlcode = 100 then
			messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Busca na tabela de cart$$HEX1$$e300$$ENDHEX$$o usando a NSU n$$HEX1$$e300$$ENDHEX$$o retornou registro.')
			return -1
	end if
elseif not isnull(ivdc_pedido) then //pedido
	select top 1 n.nr_nf 
	into :ivdc_Nr_Nf 
	from nf_venda n
	where n.nr_pedido_ecommerce = :ivdc_pedido
	using sqlca;
	if sqlca.sqlcode = 100 then
		messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Busca na tabela de venda usando o pedido n$$HEX1$$e300$$ENDHEX$$o retornou registro.')
		return -1
	end if
end if

return 1
end event

event dw_2::ue_recuperar;//Over

return This.Retrieve('PRD', ivdt_dt_inicio, ivdt_dt_final, ivl_Filial, ivdc_Nr_Nf )


end event

event dw_2::clicked;call super::clicked;
setnull(ivdc_id_selecao)

if this.getitemstring( row, 'cd_forma_pagto') = 'PCS1' then
	Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Sececione um cart$$HEX1$$e300$$ENDHEX$$o, linha selecionada foi em dinheiro, a invers$$HEX1$$e300$$ENDHEX$$o ocorrer$$HEX1$$e100$$ENDHEX$$ apenas na linha de cart$$HEX1$$e300$$ENDHEX$$o!')
else
	ivdc_id_selecao = this.getitemdecimal( row,'nr_atualizacao')
end if
end event

type tabpage_2 from dc_w_2tab_consulta_selecao_lista_2det`tabpage_2 within tab_1
integer width = 5083
integer height = 1564
end type

type gb_4 from dc_w_2tab_consulta_selecao_lista_2det`gb_4 within tabpage_2
integer width = 4933
integer height = 756
string text = "Log"
end type

type gb_3 from dc_w_2tab_consulta_selecao_lista_2det`gb_3 within tabpage_2
integer width = 4928
integer height = 656
string text = "Invers$$HEX1$$e300$$ENDHEX$$o"
end type

type dw_3 from dc_w_2tab_consulta_selecao_lista_2det`dw_3 within tabpage_2
integer width = 4795
integer height = 524
string dataobject = "dw_ge600_detalhe"
end type

type dw_4 from dc_w_2tab_consulta_selecao_lista_2det`dw_4 within tabpage_2
integer width = 4782
integer height = 596
string dataobject = "dw_ge600_log"
end type

