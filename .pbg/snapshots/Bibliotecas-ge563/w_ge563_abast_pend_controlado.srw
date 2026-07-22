HA$PBExportHeader$w_ge563_abast_pend_controlado.srw
forward
global type w_ge563_abast_pend_controlado from dc_w_response_ok_cancela
end type
type st_1 from statictext within w_ge563_abast_pend_controlado
end type
type cb_1 from commandbutton within w_ge563_abast_pend_controlado
end type
type cb_2 from commandbutton within w_ge563_abast_pend_controlado
end type
type st_2 from statictext within w_ge563_abast_pend_controlado
end type
end forward

global type w_ge563_abast_pend_controlado from dc_w_response_ok_cancela
integer width = 3054
integer height = 1472
string title = "GE563 - Produtos com Abastecimento Pendente [Somente Controlado]"
st_1 st_1
cb_1 cb_1
cb_2 cb_2
st_2 st_2
end type
global w_ge563_abast_pend_controlado w_ge563_abast_pend_controlado

type variables
Date adt_Parametro
Long il_Mensgem = 291 
end variables

forward prototypes
public function boolean wf_data (ref date adt_parametro)
public function boolean wf_envia_email_validar (datawindow adw_data, datetime adt_data, long al_linhas)
end prototypes

public function boolean wf_data (ref date adt_parametro);Boolean lvb_Sucesso = False
DateTime lvdh_Data

Select dh_movimentacao Into :lvdh_Data
From parametro
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		adt_Parametro = Date(lvdh_Data)
		
		lvb_Sucesso = True
		
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Data do par$$HEX1$$e200$$ENDHEX$$metro n$$HEX1$$e300$$ENDHEX$$o localizada.", StopSign!)
		
	Case -1
		SqlCa.of_MsgdbError("Verifica$$HEX2$$e700e300$$ENDHEX$$o da Data do Par$$HEX1$$e200$$ENDHEX$$metro")		
End Choose

Return lvb_Sucesso



end function

public function boolean wf_envia_email_validar (datawindow adw_data, datetime adt_data, long al_linhas);Long  ll_Produto , ll_Qtd_Pedida, ll_Saldo_Flow , ll_Dif , ll_Linha, ll_Saldo_Pulmao
String lvs_Cabecalho_Tabela, lvs_Descricao, lvs_Dados_Tabela, lvs_Rodape_Tabela
Datetime lvdt_data

SetNull(lvs_Cabecalho_Tabela)
SetNull(lvs_Dados_Tabela)
SetNull(lvs_Rodape_Tabela) 
s_email str //ge202
lvdt_data = adt_data

//  Monta Email para Envio: Envio Para Cesar  - TI para valida$$HEX2$$e700f500$$ENDHEX$$es
lvs_Cabecalho_Tabela = 	"<Html>"+&
									"<Body>"+&
									"<br>"+&										
									"<Table border=1>"+&
									"<tr bgcolor='#ffff66' >"+& 
									"<td>Produto</td>"+&	
									"<td>Descri$$HEX2$$e700e300$$ENDHEX$$o</td> "+&		
									"<td>Qtd. Pedida</td> "+&	
									"<td>Saldo Flow</td> "+&	
									"<td>Diferen$$HEX1$$e700$$ENDHEX$$a</td> "+&		
									"<td>Saldo Pulm$$HEX1$$e300$$ENDHEX$$o</td> "+&	
									"</tr>"
lvs_Dados_Tabela = " "
// Loop Para Email	
For	ll_Linha  = 1 To al_linhas
		ll_Produto  			= adw_data.object.cd_produto				[ll_Linha]
		lvs_Descricao		= gf_retira_caracteres_especiais (adw_data.object.de_produto[ll_Linha])
		ll_Qtd_Pedida		= adw_data.object.qt_pedida				[ll_Linha]
		ll_Saldo_Flow		= adw_data.object.qt_saldo					[ll_Linha]
		ll_Dif				     = adw_data.object.qt_diferenca			[ll_Linha]
		ll_Saldo_Pulmao	 = adw_data.object.qt_saldo_pulmao		[ll_Linha]
		
		// Dados da Tabela
		lvs_Dados_Tabela += "<tr>"+&
									"<td>" + String(ll_Produto)+ "~n</td>"+&
									"<td>" + Trim(lvs_Descricao) + "~n</td>"+&									
									"<td align='center' >" +String(ll_Qtd_Pedida) + "~n</td>"+&
									"<td align='center' >" +String(ll_Saldo_Flow) + "~n</td>"+&
									"<td align='center' >"+String(ll_Dif)+"~n</td>"+&										
									"<td align='center' >"+String(ll_Saldo_Pulmao)+"~n</td>"+&										
								    "</tr>"
Next

// Envio do Email
lvs_Rodape_Tabela = "</Table></br>Data:" +  String(lvdt_data, "dd/mm/yyyy hh:mm:ss") + "</Body></Html>"
str.ps_Mensagem	= lvs_Cabecalho_Tabela + lvs_Dados_Tabela + lvs_Rodape_Tabela
str.pb_Assinatura	= True
gf_ge202_envia_email_padrao(il_Mensgem,str)	

Return True 
end function

on w_ge563_abast_pend_controlado.create
int iCurrent
call super::create
this.st_1=create st_1
this.cb_1=create cb_1
this.cb_2=create cb_2
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.cb_2
this.Control[iCurrent+4]=this.st_2
end on

on w_ge563_abast_pend_controlado.destroy
call super::destroy
destroy(this.st_1)
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.st_2)
end on

event ue_postopen;call super::ue_postopen;DateTime lvdt_data
Long ll_linha, ll_Linhas

lvdt_data = gf_getServerDate()
wf_data(Ref adt_Parametro)  

dw_1.retrieve(adt_Parametro) 
ll_Linhas = dw_1.RowCount()

If ll_Linhas > 0 Then
	st_1.visible = True 	
	st_2.visible = True 	
	st_2.text = String(lvdt_data, "dd/mm/yyyy hh:mm:ss") 
	wf_envia_email_validar(dw_1, lvdt_data, ll_Linhas   )
Else
	st_1.visible = False 	
	st_2.visible = False 	
End If 
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge563_abast_pend_controlado
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge563_abast_pend_controlado
integer width = 2999
string text = "Lista de Produtos"
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge563_abast_pend_controlado
integer x = 64
integer y = 72
integer width = 2921
integer height = 1044
string dataobject = "dw_ge563_lista_abast_pend_controlado"
boolean vscrollbar = true
boolean livescroll = false
end type

event dw_1::ue_recuperar;call super::ue_recuperar;// Continua o envio do PAD Picking
If This.RowCount() = 0 Then
	CloseWithReturn(Parent, 1)
End If 

Return 1
end event

event dw_1::constructor;call super::constructor;// Habilitar a ordena$$HEX2$$e700e300$$ENDHEX$$o na coluna
This.ivb_Ordena_Colunas = True

This.of_SetRowSelection()
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge563_abast_pend_controlado
boolean visible = false
integer x = 1307
integer width = 1070
boolean enabled = false
string text = "&Continuar o Envio p/ PAD Picking"
end type

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge563_abast_pend_controlado
integer x = 2629
integer y = 1152
integer width = 402
end type

event cb_cancelar::clicked;// OverRide
CloseWithReturn(Parent, 2)



end event

type st_1 from statictext within w_ge563_abast_pend_controlado
boolean visible = false
integer x = 46
integer y = 1288
integer width = 1751
integer height = 88
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 134217857
long backcolor = 67108864
string text = "$$HEX1$$c900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio abastecer o flow para os produtos listados!"
alignment alignment = center!
boolean focusrectangle = false
end type

type cb_1 from commandbutton within w_ge563_abast_pend_controlado
integer x = 23
integer y = 1140
integer width = 471
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Exportar Excel"
end type

event clicked;
dw_1.event ue_saveas( )
end event

type cb_2 from commandbutton within w_ge563_abast_pend_controlado
integer x = 1778
integer y = 1152
integer width = 795
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Continuar Gera$$HEX2$$e700e300$$ENDHEX$$o Picking ?"
end type

event clicked;Long ll_Produtos
Long ll_Retorno

ll_Produtos = dw_1.RowCount()

If ll_Produtos > 0 Then
	If ll_Produtos > 100 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existe mais de 100 produtos que n$$HEX1$$e300$$ENDHEX$$o foram abastecidos. ~r~rA gera$$HEX2$$e700e300$$ENDHEX$$o do picking n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ realizada.", Exclamation!)
		ll_Retorno = 2
	Else
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existem '" + String(ll_Produtos) + "' produtos que n$$HEX1$$e300$$ENDHEX$$o foram abastecidos, se continuar o processo de gera$$HEX2$$e700e300$$ENDHEX$$o do picking vai gerar corte no pedido. ~r~rDeseja continuar mesmo assim?", Question!, YesNo!, 2) = 1 Then
			ll_Retorno = 1
		End If
	End If
Else
	ll_Retorno = 1
End If

// 1 - // Continua o Abastecimento

CloseWithReturn(Parent, ll_Retorno)


end event

type st_2 from statictext within w_ge563_abast_pend_controlado
boolean visible = false
integer x = 1810
integer y = 1288
integer width = 1010
integer height = 88
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 255
long backcolor = 67108864
alignment alignment = right!
boolean focusrectangle = false
end type

