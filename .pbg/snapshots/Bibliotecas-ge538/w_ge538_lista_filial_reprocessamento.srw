HA$PBExportHeader$w_ge538_lista_filial_reprocessamento.srw
forward
global type w_ge538_lista_filial_reprocessamento from dc_w_response_ok_cancela
end type
end forward

global type w_ge538_lista_filial_reprocessamento from dc_w_response_ok_cancela
string tag = "w_ge538_libera_processamento"
integer width = 1353
integer height = 1308
string title = "GE538 - Libera Processamento Autom$$HEX1$$e100$$ENDHEX$$tico"
end type
global w_ge538_lista_filial_reprocessamento w_ge538_lista_filial_reprocessamento

type variables
string ivs_Operador
lstr_scanntech istr_param

boolean ib_Check

end variables

on w_ge538_lista_filial_reprocessamento.create
call super::create
end on

on w_ge538_lista_filial_reprocessamento.destroy
call super::destroy
end on

event open;call super::open;istr_param 	= Message.PowerObjectParm

// Verifica acesso no procedimento
If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("W_GE538_LIBERA_REPROCESSAMENTO", ref ivs_Operador) Then
	istr_param.cancel = 'S'
	CloseWithReturn(This, istr_param)
	Return
End If

// Busca filial dispon$$HEX1$$ed00$$ENDHEX$$veis para sele$$HEX2$$e700e300$$ENDHEX$$o no per$$HEX1$$ed00$$ENDHEX$$odo informado
dw_1.retrieve(istr_param.dt_inicial, istr_param.dt_final)

ib_Check = false




end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge538_lista_filial_reprocessamento
integer x = 73
integer y = 72
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge538_lista_filial_reprocessamento
integer x = 18
integer y = 0
integer width = 1280
integer height = 1076
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge538_lista_filial_reprocessamento
integer x = 69
integer y = 48
integer width = 1202
integer height = 996
string dataobject = "dw_ge538_reprocessar_fechamento"
boolean vscrollbar = true
boolean livescroll = false
end type

event dw_1::doubleclicked;call super::doubleclicked;Integer li_Linha
String ls_Marcacao

AcceptText()		

Choose Case dwo.Name
	Case "id_selecionar"
		if ib_Check Then
			ls_Marcacao = 'N'
			ib_Check 	 = False
		else
			ls_Marcacao = 'S'
			ib_Check 	 = True
		end If
		
		For li_Linha = 1 To RowCount()
			Object.id_seleciona[li_Linha] = ls_marcacao
		Next
End Choose
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge538_lista_filial_reprocessamento
integer x = 617
integer y = 1100
end type

event cb_ok::clicked;call super::clicked;dc_uo_ds_Base ds_itens_selecionados

If Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o",'Deseja realmente habilitar movimento para reprocessar novamente?', Exclamation! , OKCancel!, 2 ) = 2 Then
	istr_param.cancel = 'S'
	CloseWithReturn(Parent, istr_param)
End If	

dw_1.AcceptText()
istr_param.cancel = 'N'

ds_itens_selecionados = Create dc_uo_ds_base
If Not ds_itens_selecionados.of_ChangeDataObject('dw_ge538_reprocessar_fechamento') Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no changedata da datastore 'dw_ge538_reprocessar_fechamento'.")
	Return 1
End If

/* 
Para devolver a sele$$HEX2$$e700e300$$ENDHEX$$o necessita usar uma datastore na estrutura
Copia para a datastore da estrutura de paramentros os registros selecionados 
*/
dw_1.rowscopy(1, dw_1.rowcount(), primary!, ds_itens_selecionados, 1, Primary!)

/*
Filtra apenas os itens que fora marcados para reprocessamento
*/
ds_itens_selecionados.setfilter("id_seleciona = 'S'")
ds_itens_selecionados.filter()

ds_itens_selecionados.Accepttext()
if ds_itens_selecionados.rowcount() < 1 then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o",'$$HEX1$$c900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio selecionar ao menos uma filial para reprocessamento')
	istr_param.cancel = 'S'
	ds_itens_selecionados.reset()
	return
End If	

/*
Carrega istr_param.ds_itens_selecionados com a datastore filtrada para processar os itens selecionados
*/
istr_param.ds_itens_selecionados = ds_itens_selecionados

CloseWithReturn(Parent, istr_param) 	
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge538_lista_filial_reprocessamento
integer x = 987
integer y = 1100
end type

event cb_cancelar::clicked;//Overrider
istr_param.as_botao = 'CA'
istr_param.cancel = 'S'
CloseWithReturn(Parent, istr_param)
end event

