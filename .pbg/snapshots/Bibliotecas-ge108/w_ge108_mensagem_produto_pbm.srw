HA$PBExportHeader$w_ge108_mensagem_produto_pbm.srw
forward
global type w_ge108_mensagem_produto_pbm from dc_w_response_ok_cancela
end type
end forward

global type w_ge108_mensagem_produto_pbm from dc_w_response_ok_cancela
integer width = 2752
integer height = 732
boolean titlebar = false
long backcolor = 8421376
end type
global w_ge108_mensagem_produto_pbm w_ge108_mensagem_produto_pbm

on w_ge108_mensagem_produto_pbm.create
call super::create
end on

on w_ge108_mensagem_produto_pbm.destroy
call super::destroy
end on

event key;call super::key;Boolean lb_Fechar = False
Boolean lb_Persiste

String ls_Retorno =''

Choose Case Key 
	Case KeySpaceBar!
		lb_Fechar = True
	Case KeyEscape!
		lb_Fechar = True
	Case KeyF5!
		lb_Fechar = True
		ls_Retorno = 'F5'
End Choose

If lb_Fechar Then
 	CloseWithReturn( This, ls_Retorno )
End If
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge108_mensagem_produto_pbm
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge108_mensagem_produto_pbm
integer x = 32
integer y = 8
integer width = 2670
integer height = 680
long backcolor = 8421376
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge108_mensagem_produto_pbm
integer x = 41
integer y = 40
integer width = 2633
integer height = 628
string dataobject = "dw_ge108_mensagem_prd_pbm"
end type

event dw_1::ue_key;call super::ue_key;Choose Case Key 
	Case KeySpaceBar!
		Event key(Key, keyflags)
	Case KeyEscape!
		Event key(Key, keyflags)
	Case KeyF5!
		Event key(Key, keyflags)
End Choose
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge108_mensagem_produto_pbm
boolean visible = false
integer x = 1527
integer y = 772
boolean enabled = false
boolean default = false
end type

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge108_mensagem_produto_pbm
boolean visible = false
integer x = 1861
integer y = 772
boolean enabled = false
end type

