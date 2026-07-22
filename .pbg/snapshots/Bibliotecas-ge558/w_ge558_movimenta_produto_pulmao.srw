HA$PBExportHeader$w_ge558_movimenta_produto_pulmao.srw
forward
global type w_ge558_movimenta_produto_pulmao from dc_w_response_ok_cancela
end type
end forward

global type w_ge558_movimenta_produto_pulmao from dc_w_response_ok_cancela
string tag = "w_ge558_movimenta_produto_pulmao"
integer width = 1115
integer height = 728
string title = "GE558 - Movimentar Produtos para o Pulm$$HEX1$$e300$$ENDHEX$$o"
end type
global w_ge558_movimenta_produto_pulmao w_ge558_movimenta_produto_pulmao

type variables
String is_Endereco

Long il_Produto

st_ge558_dados_produto ist_Parametro
end variables

forward prototypes
public function boolean wf_endereco_valido (string as_endereco)
end prototypes

public function boolean wf_endereco_valido (string as_endereco);String ls_Bairro

Select cd_bairro
Into :ls_Bairro
from vw_wms_endereco
where cd_endereco = :as_Endereco
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		//ls_Bairro 1 -> PULM$$HEX1$$c300$$ENDHEX$$O
		//ls_Bairro 9 -> PULM$$HEX1$$c300$$ENDHEX$$O CONTROLADO
		
		If (ls_Bairro <> "1") and (ls_Bairro <> "9") Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Esse n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ um endere$$HEX1$$e700$$ENDHEX$$o do pulm$$HEX1$$e300$$ENDHEX$$o.")
			Return False
		End If
	Case -1		
		MessageBox("Erro", "Erro ao verificar se o endere$$HEX1$$e700$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ do pulm$$HEX1$$e300$$ENDHEX$$o: "+  SqlCa.SQLErrText)
		Return False
		
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Endere$$HEX1$$e700$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o localizado.")
		Return False	
End Choose

Return True
end function

on w_ge558_movimenta_produto_pulmao.create
call super::create
end on

on w_ge558_movimenta_produto_pulmao.destroy
call super::destroy
end on

event open;call super::open; String ls_Parametro

ls_Parametro = Message.StringParm	

is_Endereco = Mid(ls_Parametro, 1, 8)

il_Produto = Long(Mid(ls_parametro, 9))
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge558_movimenta_produto_pulmao
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge558_movimenta_produto_pulmao
integer width = 1047
integer height = 484
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge558_movimenta_produto_pulmao
integer width = 1010
integer height = 388
string dataobject = "dw_ge558_movimenta_produto_pulmao"
end type

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge558_movimenta_produto_pulmao
integer x = 393
integer y = 512
end type

event cb_ok::clicked;call super::clicked;String ls_Endereco

Long	ll_Qt_Caixas,&
		ll_Cx_padrao

dw_1.AcceptText()

ls_Endereco		= dw_1.Object.cd_endereco_pulmao	[1]
ll_Qt_Caixas		= dw_1.Object.qt_caixas					[1]
ll_Cx_padrao	= dw_1.Object.qt_caixa_padrao		[1]

If IsNull(ll_Cx_padrao) or ll_Cx_padrao = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a caixa padr$$HEX1$$e300$$ENDHEX$$o.")
	Return 1
End If

If ll_Cx_padrao < 1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A caixa padr$$HEX1$$e300$$ENDHEX$$o deve ser maior do que 1.")
	Return 1
End If

If IsNull(ll_Qt_Caixas) or ll_Qt_Caixas = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a quantidade de caixas.")
	Return 1
End If

// Tratativa
If  ll_Qt_Caixas < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Quantidade de caixas Incorreta!.")
	Return 1
End If



If Not wf_Endereco_Valido(ls_Endereco) Then
	Return 1
End If

ist_Parametro.cd_endereco_pulmao	= ls_Endereco
ist_Parametro.qt_movimento			= ll_Qt_Caixas
ist_Parametro.qt_caixa_padrao			= ll_Cx_padrao
ist_Parametro.id_retorno					= "S"

CloseWithReturn(Parent, ist_Parametro)
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge558_movimenta_produto_pulmao
integer x = 754
integer y = 512
end type

event cb_cancelar::clicked;//OverRide
ist_Parametro.id_retorno					= "N"

CloseWithReturn(Parent, ist_Parametro)
end event

