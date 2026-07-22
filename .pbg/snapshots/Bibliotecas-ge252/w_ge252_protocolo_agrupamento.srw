HA$PBExportHeader$w_ge252_protocolo_agrupamento.srw
forward
global type w_ge252_protocolo_agrupamento from dc_w_base
end type
type cb_2 from commandbutton within w_ge252_protocolo_agrupamento
end type
type cb_1 from commandbutton within w_ge252_protocolo_agrupamento
end type
type dw_1 from dc_uo_dw_base within w_ge252_protocolo_agrupamento
end type
type gb_1 from groupbox within w_ge252_protocolo_agrupamento
end type
end forward

global type w_ge252_protocolo_agrupamento from dc_w_base
string tag = "w_ge252_protocolo_agrupamento"
integer width = 2395
integer height = 1168
string title = "GE252 - Protocolo Defeito F$$HEX1$$e100$$ENDHEX$$brica"
boolean controlmenu = false
boolean minbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 134217750
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
gb_1 gb_1
end type
global w_ge252_protocolo_agrupamento w_ge252_protocolo_agrupamento

type variables
Long il_qtde_Recebida, il_Qtde_Informada
		
st_parametros_protocolo ist_parametros_protocolo
end variables

forward prototypes
public subroutine wf_valida_quantidade (string as_protocolo, long al_motivo, long al_qtd)
end prototypes

public subroutine wf_valida_quantidade (string as_protocolo, long al_motivo, long al_qtd);
end subroutine

on w_ge252_protocolo_agrupamento.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.gb_1
end on

on w_ge252_protocolo_agrupamento.destroy
call super::destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.gb_1)
end on

event ue_postopen;call super::ue_postopen;long ll_linhas

ist_parametros_protocolo = Message.PowerObjectParm	

dw_1.Event ue_Recuperar ()

ll_linhas = dw_1.RowCount ()

If ll_linhas = 0 then
	MessageBox ("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o foi localizado nenhum protocolo para o Produto/Lote informados.", Information!, Ok!)
	Return
End if
	
end event

type cb_2 from commandbutton within w_ge252_protocolo_agrupamento
integer x = 1998
integer y = 972
integer width = 311
integer height = 96
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Cancela"
end type

event clicked;ist_parametros_protocolo.qtd_protocolo = -1

CloseWithReturn(Parent, ist_parametros_protocolo ) 
end event

type cb_1 from commandbutton within w_ge252_protocolo_agrupamento
integer x = 1609
integer y = 972
integer width = 311
integer height = 96
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "OK"
end type

event clicked;long ll_row, &
     ll_rows, &
     ll_qtd_informada, &
     ll_cd_motivo_defeito, &
     ll_count_valid, &
     ll_selected_row, &
	  ll_qt_lote, &
	  ll_qt_lote_total

string ls_protocolo,&
			ls_endere$$HEX1$$e700$$ENDHEX$$o_localizacao

dw_1.AcceptText()
ll_rows = dw_1.RowCount()

If ll_rows = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ protocolos selecionados para o produto/lote!")
	Return 1
End If

For ll_row = 1 to ll_rows
	If Not IsNull(dw_1.Object.qt_lote[ll_row]) And dw_1.Object.qt_lote[ll_row] > 0 Then
		ll_count_valid++
		ll_selected_row = ll_row
	End If
Next

If ll_count_valid = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a quantidade de produtos a utilizar em apenas uma linha.")
	Return 1
ElseIf ll_count_valid > 1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a quantidade de produtos em apenas uma linha. ~rAs demais devem ficar com valor 0.")
	Return 1
End If

ll_qt_lote   			= dw_1.Object.qt_lote[ll_selected_row]
ls_protocolo     		= dw_1.Object.nr_protocolo[ll_selected_row]
ll_cd_motivo_defeito = dw_1.Object.cd_motivo_defeito[ll_selected_row]
ll_qt_lote_total		= dw_1.Object.disponivel[ll_selected_row]
ls_endere$$HEX1$$e700$$ENDHEX$$o_localizacao = dw_1.Object.cd_endereco_localizacao[ll_selected_row]

If ll_qt_lote > 0 Then
	If ll_qt_lote < ll_qt_lote_total Then
		Update agrupamento_dev_com_prd_prt_nf
		Set qt_lote = qt_lote - :ll_qt_lote
		Where nr_agrupamento = :ist_parametros_protocolo.nr_agrupamento
		And nr_protocolo = :ls_protocolo
		And cd_produto = :ist_parametros_protocolo.cd_produto
		And nr_lote = :ist_parametros_protocolo.nr_lote
		And cd_endereco_localizacao = :ls_endere$$HEX1$$e700$$ENDHEX$$o_localizacao
		And cd_motivo_defeito = :ll_cd_motivo_defeito
		Using SqlCa;
		
		If Sqlca.SqlCode = -1 Then
			SqlCa.Of_Rollback()
			Sqlca.of_MsgDbError("Erro ao atualizar quantidade na tabela [agrupamento_dev_com_prd_prt_nf].")
			Return 1
		End If
	ElseIf ll_qt_lote = ll_qt_lote_total Then
		Delete 
		From agrupamento_dev_com_prd_prt_nf
		Where nr_agrupamento = :ist_parametros_protocolo.nr_agrupamento
		And nr_protocolo = :ls_protocolo
		And cd_produto = :ist_parametros_protocolo.cd_produto
		And nr_lote = :ist_parametros_protocolo.nr_lote
		And cd_endereco_localizacao = :ls_endere$$HEX1$$e700$$ENDHEX$$o_localizacao
		And cd_motivo_defeito = :ll_cd_motivo_defeito
		Using SqlCa;
		
		If Sqlca.SqlCode = -1 Then
			SqlCa.Of_Rollback()
			Sqlca.of_MsgDbError("Erro em excluir a quantidade na tabela [agrupamento_dev_com_prd_prt_nf]." )
			Return 1
		End if
	End if
End If

ist_parametros_protocolo.qtd_protocolo     = ll_qt_lote
ist_parametros_protocolo.nr_protocolo      = ls_protocolo
ist_parametros_protocolo.cd_motivo_defeito = ll_cd_motivo_defeito




CloseWithReturn(Parent, ist_parametros_protocolo)

end event

type dw_1 from dc_uo_dw_base within w_ge252_protocolo_agrupamento
integer x = 55
integer y = 88
integer width = 2235
integer height = 844
integer taborder = 20
string dataobject = "dw_ge252_protocolo_agrupamento"
boolean vscrollbar = true
boolean livescroll = false
end type

event ue_recuperar;//override
Long	ll_Linhas

ll_Linhas = This.Retrieve (ist_parametros_protocolo.cd_produto, ist_parametros_protocolo.nr_lote, ist_parametros_protocolo.nr_agrupamento)

If ll_Linhas < 0 Then
	MessageBox ("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o protocolo!")
	cb_1.Event Clicked ()
	Return -1
End If

Return ll_Linhas
end event

event editchanged;call super::editchanged;long ll_qtd, ll_motivo
string ls_protocolo, ls_saldo, ls_Msg
long ll_null, ll_disponivel

setnull(ll_null)

choose case dwo.name
	case 'qt_lote'

		ll_qtd = double(data)
		if isnull(ll_qtd) then ll_qtd = 0
		
		ll_disponivel = object.disponivel[row]
		
		
		If ll_qtd > ll_disponivel Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A quantidade informada $$HEX1$$e900$$ENDHEX$$ superior a quantidade m$$HEX1$$e100$$ENDHEX$$xima dispon$$HEX1$$ed00$$ENDHEX$$vel")
			Object.qt_lote[row] = ll_null
			return 1
		end if
		
		
		If ll_qtd < 0 then 
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A quantidade informada n$$HEX1$$e300$$ENDHEX$$o pode ser inferior a 0 (Zero)")
			Object.qt_lote[row] = ll_null
			return 1
		End if
end choose
end event

type gb_1 from groupbox within w_ge252_protocolo_agrupamento
integer x = 32
integer width = 2331
integer height = 964
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 134217750
string text = "Lista dos Protocolos do Produto"
borderstyle borderstyle = styleraised!
end type

