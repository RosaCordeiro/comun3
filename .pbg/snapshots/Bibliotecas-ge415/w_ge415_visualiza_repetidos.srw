HA$PBExportHeader$w_ge415_visualiza_repetidos.srw
forward
global type w_ge415_visualiza_repetidos from dc_w_response_ok_cancela
end type
end forward

global type w_ge415_visualiza_repetidos from dc_w_response_ok_cancela
integer width = 3223
integer height = 1392
string title = "GE415 - Lista De Produtos j$$HEX1$$e100$$ENDHEX$$ Colocados"
end type
global w_ge415_visualiza_repetidos w_ge415_visualiza_repetidos

type variables
Long    il_Filial,&
		  il_Produto



end variables

on w_ge415_visualiza_repetidos.create
call super::create
end on

on w_ge415_visualiza_repetidos.destroy
call super::destroy
end on

event ue_postopen;call super::ue_postopen;Long ll_linhas, ll_linha

ll_linhas = dw_1.Retrieve(il_Produto, il_Filial)

If ll_Linhas < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar os produtos.")
	cb_ok.Event Clicked()
	Return
End If

If ll_Linhas = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizado nenhum produto.")
End If

end event

event open;call super::open;
str_ge415_produto_filial st
st = Message.PowerObjectParm	

il_Produto	= st.cd_produto
il_Filial		= st.cd_filial

end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge415_visualiza_repetidos
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge415_visualiza_repetidos
integer width = 3173
integer height = 1180
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge415_visualiza_repetidos
integer width = 3127
integer height = 1092
string title = "GE350 - Lista Notas de Transfer$$HEX1$$ea00$$ENDHEX$$ncia"
string dataobject = "dw_ge415_duplicados"
boolean vscrollbar = true
end type

event dw_1::constructor;call super::constructor;dw_1.of_SetRowSelection()					
end event

event dw_1::rowfocuschanged;call super::rowfocuschanged;

//If CurrentRow > 0 Then			
	
//	st.nr_nf			= This.Object.nf_transf 	[CurrentRow] + '-' + This.Object.de_especie[CurrentRow] 	+ '-' + This.Object.de_serie[CurrentRow] 	 

//End If
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge415_visualiza_repetidos
integer x = 2885
integer y = 1196
end type

event cb_ok::clicked;call super::clicked;
CloseWithReturn(Parent, '')
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge415_visualiza_repetidos
boolean visible = false
integer x = 2450
integer y = 756
boolean enabled = false
end type

