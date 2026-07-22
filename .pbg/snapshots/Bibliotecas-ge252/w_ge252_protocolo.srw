HA$PBExportHeader$w_ge252_protocolo.srw
forward
global type w_ge252_protocolo from dc_w_base
end type
type st_limite from statictext within w_ge252_protocolo
end type
type dw_2 from datawindow within w_ge252_protocolo
end type
type cb_2 from commandbutton within w_ge252_protocolo
end type
type cb_1 from commandbutton within w_ge252_protocolo
end type
type dw_1 from dc_uo_dw_base within w_ge252_protocolo
end type
type gb_1 from groupbox within w_ge252_protocolo
end type
end forward

global type w_ge252_protocolo from dc_w_base
string tag = "w_ws038_prot_devolucao"
integer width = 2395
integer height = 1244
string title = "GE252 - Protocolo Defeito F$$HEX1$$e100$$ENDHEX$$brica"
boolean controlmenu = false
boolean minbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 134217750
st_limite st_limite
dw_2 dw_2
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
gb_1 gb_1
end type
global w_ge252_protocolo w_ge252_protocolo

type variables
Long il_qtde_Recebida, il_Qtde_Informada
		
st_parametros_protocolo ist_parametros_protocolo
end variables

forward prototypes
public subroutine wf_valida_quantidade (string as_protocolo, long al_motivo, long al_qtd)
end prototypes

public subroutine wf_valida_quantidade (string as_protocolo, long al_motivo, long al_qtd);long ll_selecinados, ll_find, ll_insert, ll_nova_qtd

dw_2.accepttext()
ll_selecinados = dw_2.rowcount()

if ll_selecinados > 0 then
	ll_find = dw_2.find("nr_protocolo = '" + as_protocolo + "' and cd_motivo_defeito = " + String (al_motivo), 0, ll_selecinados)
	if ll_find > 0 then
		If al_qtd = 0 then
			dw_2.DeleteRow (ll_find)
		else
			dw_2.object.qt_lote[ll_find] = al_qtd
		End if
	else
		If al_qtd > 0 then
			ll_insert = dw_2.insertrow(0)
			dw_2.object.cd_produto[ll_insert] = ist_parametros_protocolo.cd_produto
			dw_2.object.nr_lote[ll_insert] = ist_parametros_protocolo.nr_lote
			dw_2.object.nr_protocolo[ll_insert] = as_protocolo
			dw_2.object.qt_lote[ll_insert] = al_qtd
			dw_2.object.cd_motivo_defeito[ll_insert] = al_motivo
		End if
	end if
else
	If al_qtd > 0 then
		ll_insert = dw_2.insertrow(0)
		dw_2.object.cd_produto[ll_insert] = ist_parametros_protocolo.cd_produto
		dw_2.object.nr_lote[ll_insert] = ist_parametros_protocolo.nr_lote
		dw_2.object.nr_protocolo[ll_insert] = as_protocolo
		dw_2.object.qt_lote[ll_insert] = al_qtd
		dw_2.object.cd_motivo_defeito[ll_insert] = al_motivo
	End if
end if

Return
end subroutine

on w_ge252_protocolo.create
int iCurrent
call super::create
this.st_limite=create st_limite
this.dw_2=create dw_2
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_limite
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.cb_1
this.Control[iCurrent+5]=this.dw_1
this.Control[iCurrent+6]=this.gb_1
end on

on w_ge252_protocolo.destroy
call super::destroy
destroy(this.st_limite)
destroy(this.dw_2)
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
	If MessageBox ("Aten$$HEX2$$e700e300$$ENDHEX$$o", &
						"N$$HEX1$$e300$$ENDHEX$$o foi localizado nenhum protocolo para o Produto/Lote informados." + '~n~r' + 'Deseja adicionar um protocolo?', &
						Question!, YesNo!, 2) = 2 then
		cb_2.Event Clicked ()
		Return
	else
		ist_parametros_protocolo.qtd_lote = ist_parametros_protocolo.qtd_protocolo
		
		OpenWithParm (w_ge252_ajuste_protocolo, ist_parametros_protocolo)
		ist_parametros_protocolo = Message.PowerObjectParm

		If ist_parametros_protocolo.qtd_protocolo <> -1 then
			MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Protocolo alterado!')
			dw_1.Event ue_Recuperar ()
			ll_linhas = dw_1.RowCount ()
		End if
	End if
end if

if ll_linhas > 0 then
	dw_1.setfocus()
	dw_1.setcolumn(6)
	st_limite.text = string(ist_parametros_protocolo.qtd_protocolo) + ' $$HEX1$$e900$$ENDHEX$$ a quantidade m$$HEX1$$e100$$ENDHEX$$xima que poder$$HEX1$$e100$$ENDHEX$$ ser movimentada.'
else
	st_limite.text = 'Problemas ao carregar dados na tela'
end if
	
end event

type st_limite from statictext within w_ge252_protocolo
integer x = 14
integer y = 980
integer width = 1568
integer height = 132
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 255
long backcolor = 553648127
boolean focusrectangle = false
end type

type dw_2 from datawindow within w_ge252_protocolo
boolean visible = false
integer x = 64
integer y = 1140
integer width = 2194
integer height = 136
integer taborder = 30
boolean enabled = false
string title = "none"
string dataobject = "ds_ge252_qtd_selecao_protocolo"
boolean border = false
end type

type cb_2 from commandbutton within w_ge252_protocolo
integer x = 1998
integer y = 964
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

type cb_1 from commandbutton within w_ge252_protocolo
integer x = 1609
integer y = 964
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

event clicked;long ll_row, ll_rows, ll_qtd_informada, ll_saldo = 0, ll_find, ll_insert , ll_cd_motivo_defeito
string ls_protocolo
dc_uo_ds_Base ds_itens_selecionados

dw_1.AcceptText()
dw_2.AcceptText()

ll_rows = dw_2.rowcount()

If ll_rows > 0 then
	
	ll_qtd_informada = dw_2.Object.qt_tot_lote [ll_rows]
	
	If ll_qtd_informada = 0 then
		MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Informe a quantidade de produtos a utilizar!')
		Return 1
	End if
else
	MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'N$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ protocolos selecionados para o produto/lote!')
	Return 1
End if

If IsNull(ll_qtd_informada) or (ll_qtd_informada < 1) Then
	if MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma que n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ utilizada a quantidade de protocolo?", Question!, YesNo!,2) = 2 then
		return 1
	end if
End If

If ll_qtd_informada > ist_parametros_protocolo.qtd_protocolo Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A quantidade de protocolo n$$HEX1$$e300$$ENDHEX$$o pode ser maior que [" + string(ist_parametros_protocolo.qtd_protocolo) + "]")
	Return 1
End If

if ll_qtd_informada < ist_parametros_protocolo.qtd_protocolo then
	If MessageBox ('Aten$$HEX2$$e700e300$$ENDHEX$$o', &
						'Confirma que a quantidade a utilizar [' + String (ll_qtd_informada) + '] $$HEX1$$e900$$ENDHEX$$ inferior a quantidade de protocolo dispon$$HEX1$$ed00$$ENDHEX$$vel [' + String (ist_parametros_protocolo.qtd_protocolo) + '] ?', &
						Question!, YesNo!,2) = 2 then
		return 1
	end if
end if

/* 
Para devolver a sele$$HEX2$$e700e300$$ENDHEX$$o necessita usar uma datastore na estrutura
Copia para a datastore da estrutura de paramentros os registros selecionados 
*/
ds_itens_selecionados = Create dc_uo_ds_base
If Not ds_itens_selecionados.of_ChangeDataObject('ds_ge252_qtd_selecao_protocolo') Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no changedata da 'ds_ge252_qtd_selecao_protocolo'.")
	Return 1
End If

dw_2.rowscopy(1, dw_2.rowcount(), primary!, ds_itens_selecionados, 1, Primary!)
ist_parametros_protocolo.ds_itens_selecionados = ds_itens_selecionados
ist_parametros_protocolo.qtd_protocolo = ll_saldo

CloseWithReturn (Parent, ist_parametros_protocolo)
end event

type dw_1 from dc_uo_dw_base within w_ge252_protocolo
integer x = 55
integer y = 88
integer width = 2235
integer height = 844
integer taborder = 20
string dataobject = "dw_ge252_protocolo"
boolean vscrollbar = true
boolean livescroll = false
end type

event itemchanged;call super::itemchanged;long ll_qtd, ll_motivo
string ls_protocolo, ls_saldo, ls_Msg
long ll_null, ll_disponivel

setnull(ll_null)

choose case dwo.name
	case 'qt_lote'

		ll_qtd = double(data)
		if isnull(ll_qtd) then ll_qtd = 0
		
		ls_protocolo = object.nr_protocolo[row]
		ll_motivo    = object.cd_motivo_defeito [row]
		ll_disponivel = object.disponivel[row]
		
		if ll_qtd < 0 then 
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A quantidade informada n$$HEX1$$e300$$ENDHEX$$o pode ser inferior a 0 (Zero)")
			Object.qt_lote[row] = ll_null
			wf_valida_quantidade(ls_protocolo, ll_motivo, 0)
			return 1
		end if
		
		if ll_qtd > ll_disponivel then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A quantidade informada $$HEX1$$e900$$ENDHEX$$ superior a quantidade m$$HEX1$$e100$$ENDHEX$$xima dispon$$HEX1$$ed00$$ENDHEX$$vel")
			Object.qt_lote[row] = ll_null
			wf_valida_quantidade(ls_protocolo, ll_motivo, 0)
			return 1
		end if
		
		if ll_qtd > ist_parametros_protocolo.qtd_protocolo then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A quantidade de protocolo n$$HEX1$$e300$$ENDHEX$$o pode ser maior que " + string(ist_parametros_protocolo.qtd_protocolo) + "")
			Object.qt_lote[row] = ll_null
			wf_valida_quantidade(ls_protocolo, ll_motivo, 0)
			return 1
		end if	
		
//		if (ll_qtd < ist_parametros_protocolo.qtd_protocolo and ll_qtd > 0) then
//			ls_saldo = String(ist_parametros_protocolo.qtd_protocolo)
//			ls_Msg = 'Confirma que a quantidade informada $$HEX1$$e900$$ENDHEX$$ inferior a quantidade de protocolo dispon$$HEX1$$ed00$$ENDHEX$$vel?'
//			If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Msg, Question!, YesNo!,2) = 2 Then 
//				Object.qt_lote[row] = ll_null
//				wf_valida_quantidade(ls_protocolo, ll_motivo, 0)
//				return 1
//			end if
//		end if	
//		
		if ll_qtd = 0 then
			ls_Msg = 'A quantidade informada $$HEX1$$e900$$ENDHEX$$ igual a 0 (Zero), n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ utitilizada'
			If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Msg, Question!, YesNo!,2) = 2 Then 
				Object.qt_lote[row] = ll_null
				wf_valida_quantidade(ls_protocolo, ll_motivo, 0)
				return 1
			end if
		end if	
		
		wf_valida_quantidade(ls_protocolo, ll_motivo, ll_qtd)
end choose
end event

event ue_recuperar;//override
Long	ll_Linhas

ll_Linhas = This.Retrieve (ist_parametros_protocolo.cd_produto, ist_parametros_protocolo.nr_lote)

If ll_Linhas < 0 Then
	MessageBox ("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o protocolo!")
	cb_1.Event Clicked ()
	Return -1
End If

Return ll_Linhas
end event

type gb_1 from groupbox within w_ge252_protocolo
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

