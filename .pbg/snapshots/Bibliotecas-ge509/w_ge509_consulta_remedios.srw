HA$PBExportHeader$w_ge509_consulta_remedios.srw
forward
global type w_ge509_consulta_remedios from dc_w_response
end type
type cb_1 from commandbutton within w_ge509_consulta_remedios
end type
type cb_2 from commandbutton within w_ge509_consulta_remedios
end type
type cb_3 from commandbutton within w_ge509_consulta_remedios
end type
type cb_4 from commandbutton within w_ge509_consulta_remedios
end type
type cb_5 from commandbutton within w_ge509_consulta_remedios
end type
end forward

global type w_ge509_consulta_remedios from dc_w_response
string title = "Integra$$HEX2$$e700e300$$ENDHEX$$o Consulta Rem$$HEX1$$e900$$ENDHEX$$dios"
cb_1 cb_1
cb_2 cb_2
cb_3 cb_3
cb_4 cb_4
cb_5 cb_5
end type
global w_ge509_consulta_remedios w_ge509_consulta_remedios

on w_ge509_consulta_remedios.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
this.cb_3=create cb_3
this.cb_4=create cb_4
this.cb_5=create cb_5
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_3
this.Control[iCurrent+4]=this.cb_4
this.Control[iCurrent+5]=this.cb_5
end on

on w_ge509_consulta_remedios.destroy
call super::destroy
destroy(this.cb_1)
destroy(this.cb_2)
destroy(this.cb_3)
destroy(this.cb_4)
destroy(this.cb_5)
end on

type pb_help from dc_w_response`pb_help within w_ge509_consulta_remedios
end type

type cb_1 from commandbutton within w_ge509_consulta_remedios
integer x = 366
integer y = 168
integer width = 549
integer height = 156
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Produtos"
end type

event clicked;
string ls_log
string ls_Rede
long ll_cd_filial

// DEBUG
str_ge509_debug str

Open(w_ge509_debug)

str = Message.PowerObjectParm

uo_ge509_produto luo_produto

luo_produto = create uo_ge509_produto

ll_cd_filial = str.cd_filial
//luo_pedido.is_pedido_debug = str.nr_pedido

If IsNull(ll_Cd_filial) or ll_Cd_filial = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A filial n$$HEX1$$e300$$ENDHEX$$o foi informada.")
	destroy(luo_produto)
	Return 
End If

select id_rede_filial
into :ls_rede
from ecommerce_rede_filial
where id_ecommerce = '5'
and cd_filial = :ll_cd_filial;

if sqlca.sqlcode = -1 then
	messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Problemas ao consultar a tabela ecommerce_rede_filial: ' + sqlca.sqlerrtext)
	return
end if

If IsNull(ls_Rede) or Trim(ls_Rede) = '' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar a rede da filial selecionada.")
	destroy(luo_produto)
	Return 
End If

luo_produto.of_processa_interface( ls_rede, ll_cd_filial, '5')
end event

type cb_2 from commandbutton within w_ge509_consulta_remedios
integer x = 366
integer y = 372
integer width = 549
integer height = 156
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "PEDIDO - BAIXA"
end type

event clicked;
string ls_log
string ls_Rede
long ll_cd_filial

// DEBUG
str_ge509_debug str

Open(w_ge509_debug)

str = Message.PowerObjectParm

uo_ge509_pedido_baixa luo_pedido

luo_pedido = create uo_ge509_pedido_baixa

ll_cd_filial = str.cd_filial
luo_pedido.is_pedido_debug = str.nr_pedido

If IsNull(ll_Cd_filial) or ll_Cd_filial = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A filial n$$HEX1$$e300$$ENDHEX$$o foi informada.")
	destroy(luo_pedido)
	Return 
End If

select id_rede_filial
into :ls_rede
from ecommerce_rede_filial
where id_ecommerce = '5'
and cd_filial = :ll_cd_filial;

if sqlca.sqlcode = -1 then
	messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Problemas ao consultar a tabela ecommerce_rede_filial: ' + sqlca.sqlerrtext)
	return
end if

If IsNull(ls_Rede) or Trim(ls_Rede) = '' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar a rede da filial selecionada.")
	destroy(luo_pedido)
	Return 
End If

luo_pedido.of_processa_interface( ls_rede, ll_cd_filial, '5')

Destroy(luo_pedido)
end event

type cb_3 from commandbutton within w_ge509_consulta_remedios
integer x = 366
integer y = 536
integer width = 549
integer height = 156
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "PEDIDO - LOJA"
end type

event clicked;string ls_log
string ls_Rede
long ll_cd_filial

// DEBUG
str_ge509_debug str

Open(w_ge509_debug)

str = Message.PowerObjectParm

uo_ge509_pedido_loja luo_pedido

luo_pedido = create uo_ge509_pedido_loja

ll_cd_filial = str.cd_filial
luo_pedido.is_pedido_debug = str.nr_pedido

If IsNull(ll_Cd_filial) or ll_Cd_filial = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A filial n$$HEX1$$e300$$ENDHEX$$o foi informada.")
	destroy(luo_pedido)
	Return 
End If

select id_rede_filial
into :ls_rede
from ecommerce_rede_filial
where id_ecommerce = '5'
and cd_filial = :ll_cd_filial;

if sqlca.sqlcode = -1 then
	messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Problemas ao consultar a tabela ecommerce_rede_filial: ' + sqlca.sqlerrtext)
	return
end if

If IsNull(ls_Rede) or Trim(ls_Rede) = '' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar a rede da filial selecionada.")
	destroy(luo_pedido)
	Return 
End If

luo_pedido.of_processa_interface( ls_rede, ll_cd_filial, '5')
end event

type cb_4 from commandbutton within w_ge509_consulta_remedios
integer x = 366
integer y = 708
integer width = 549
integer height = 156
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "PEDIDO - STATUS"
end type

event clicked;string ls_log
string ls_Rede
long ll_cd_filial

// DEBUG
str_ge509_debug str

Open(w_ge509_debug)

str = Message.PowerObjectParm

uo_ge509_pedido_status luo_pedido

luo_pedido = create uo_ge509_pedido_status

ll_cd_filial = str.cd_filial

luo_pedido.is_pedido_debug = str.nr_pedido

If IsNull(ll_Cd_filial) or ll_Cd_filial = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A filial n$$HEX1$$e300$$ENDHEX$$o foi informada.")
	destroy(luo_pedido)
	Return 
End If

select id_rede_filial
into :ls_rede
from ecommerce_rede_filial
where id_ecommerce = '5'
and cd_filial = :ll_cd_filial;

if sqlca.sqlcode = -1 then
	messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Problemas ao consultar a tabela ecommerce_rede_filial: ' + sqlca.sqlerrtext)
	return
end if

If IsNull(ls_Rede) or Trim(ls_Rede) = '' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar a rede da filial selecionada.")
	destroy(luo_pedido)
	Return 
End If

luo_pedido.of_processa_interface( ls_rede, ll_cd_filial, '5')
end event

type cb_5 from commandbutton within w_ge509_consulta_remedios
integer x = 1422
integer y = 744
integer width = 402
integer height = 200
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "none"
end type

event clicked;String ls_Status_Text, ls_usuario, ls_senha, ls_url, ls_retorno, ls_json

long ll_Status_Code

OleObject lo_Xml_Http
oleobject iole_Send

Try
	Try		
		
		ls_url = 'http://172.19.12.57:4015/'
		//ls_json = '{"idRede":"PP", "nrPedidoEcommerce":"1432642593322-01"}'
		
		ls_usuario = ''
		ls_senha = ''
		
		lo_Xml_Http = CREATE oleobject		
		lo_Xml_Http.ConnectToNewObject("MSXML2.SERVERXMLHTTP.6.0")

		iole_Send = CREATE oleobject
		iole_Send.ConnectToNewObject("Msxml2.DOMDocument.6.0")

		lo_Xml_Http.open ("GET", ls_url, False)
		
		lo_Xml_Http.setRequestHeader("Content-Type", "application/json") 
		
		//Somente se for conex$$HEX1$$e300$$ENDHEX$$o segura https:
//		if pos(Upper(is_url), 'HTTPS:') > 0 Then
//			If Not this.of_encode_credencial( ref as_erro ) then return false
//			lo_Xml_Http.setRequestHeader("Authorization", 'basic ' + is_credenciais_acesso)
//			lo_Xml_Http.setOption(2,'13056') 
//		end if
		
		lo_Xml_Http.send(iole_Send)	
		
		//Pega a resposta do web service
		ls_Status_Text = lo_Xml_Http.StatusText
		ll_Status_Code = lo_Xml_Http.Status
		
		If ll_Status_Code >= 300 Or ll_Status_Code = 0 Then
			messagebox('Atencao', "Erro no retorno do Web Service. C$$HEX1$$f300$$ENDHEX$$digo do erro: " +String(ll_Status_Code)+ " Descri$$HEX2$$e700e300$$ENDHEX$$o do erro: " + ls_Status_Text)
			Return -1
		Else
		//Pega o retorno do web service
			ls_retorno = String(lo_Xml_Http.ResponseText)
		End If
	Finally
		//Disconecta
		lo_Xml_Http.DisconnectObject()
		
		Destroy(lo_Xml_Http)
	End Try

Catch (RuntimeError lo_rte)
	messagebox('Atencao', "PEDIDO: | Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o of_envia_webservice, objeto uo_ge501_total_express. Erro: "+lo_rte.GetMessage())
	Return -1
Finally
	//FileClose( This.ivi_LOG )
End Try

Return 1
end event

