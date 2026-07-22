HA$PBExportHeader$w_ge350_lista_notas_tranferencia.srw
forward
global type w_ge350_lista_notas_tranferencia from dc_w_response_ok_cancela
end type
end forward

global type w_ge350_lista_notas_tranferencia from dc_w_response_ok_cancela
integer width = 2789
integer height = 952
string title = "GE350 - Lista Notas de Origem"
end type
global w_ge350_lista_notas_tranferencia w_ge350_lista_notas_tranferencia

type variables
Long    il_Filial,&
		  il_Produto
String   is_Lote,&
		   is_nr_nf	
		  
DateTime idh_solicitacao




end variables

on w_ge350_lista_notas_tranferencia.create
call super::create
end on

on w_ge350_lista_notas_tranferencia.destroy
call super::destroy
end on

event ue_postopen;call super::ue_postopen;Long ll_linhas,&
	   ll_linha

ll_linhas = dw_1.Retrieve(il_Filial, il_Produto, is_Lote)

If ll_linhas > 0 Then
	For ll_linha=1 to ll_linhas
		dw_1.Object.dh_solicitacao[ll_linha] = idh_solicitacao	
	Next 	
End If

If ll_Linhas < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar as notas de transfer$$HEX1$$ea00$$ENDHEX$$ncia.")
	cb_ok.Event Clicked()
	Return
End If

If ll_Linhas = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizado nenhuma nota de transfer$$HEX1$$ea00$$ENDHEX$$ncia.")
End If




		


end event

event open;call super::open;str_ge350_dados_notas_avaria st
st =Message.PowerObjectParm	

il_Produto		    = st.nr_produto
is_Lote				= st.nr_lote
il_Filial 			     = st.cd_filial
idh_solicitacao		= st.dh_solicita	



end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge350_lista_notas_tranferencia
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge350_lista_notas_tranferencia
integer width = 2738
integer height = 744
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge350_lista_notas_tranferencia
integer width = 2679
integer height = 640
string title = "GE350 - Lista Notas de Transfer$$HEX1$$ea00$$ENDHEX$$ncia"
string dataobject = "dw_ge350_lista_nf_transfer"
boolean vscrollbar = true
end type

event dw_1::constructor;call super::constructor;dw_1.of_SetRowSelection()					
end event

event dw_1::rowfocuschanged;call super::rowfocuschanged;

//If CurrentRow > 0 Then			
	
//	st.nr_nf			= This.Object.nf_transf 	[CurrentRow] + '-' + This.Object.de_especie[CurrentRow] 	+ '-' + This.Object.de_serie[CurrentRow] 	 

//End If
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge350_lista_notas_tranferencia
integer x = 2094
integer y = 756
end type

event cb_ok::clicked;call super::clicked;long  ll_Nota
Double ldb_Vlr_Nota
String ls_Emissao

ll_Nota = dw_1.object.nf_transferencia[dw_1.getrow()]
ldb_Vlr_Nota = dw_1.object.vl_total_nf[dw_1.getrow()]
ls_Emissao = string(dw_1.object.dh_emissao[dw_1.getrow()], 'dd/mm/yyyy')

CloseWithReturn(Parent, string(ll_Nota) + ';' + string(ldb_Vlr_Nota) + ';' + ls_Emissao )
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge350_lista_notas_tranferencia
integer x = 2427
integer y = 756
end type

