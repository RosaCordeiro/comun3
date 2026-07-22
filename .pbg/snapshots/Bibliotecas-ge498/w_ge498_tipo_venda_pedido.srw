HA$PBExportHeader$w_ge498_tipo_venda_pedido.srw
forward
global type w_ge498_tipo_venda_pedido from dc_w_response_ok_cancela
end type
type cb_consulta from commandbutton within w_ge498_tipo_venda_pedido
end type
type dw_2 from dc_uo_dw_base within w_ge498_tipo_venda_pedido
end type
type dw_3 from dc_uo_dw_base within w_ge498_tipo_venda_pedido
end type
type st_mensagem from statictext within w_ge498_tipo_venda_pedido
end type
type gb_convenio from groupbox within w_ge498_tipo_venda_pedido
end type
type gb_condicao_convenio from groupbox within w_ge498_tipo_venda_pedido
end type
end forward

global type w_ge498_tipo_venda_pedido from dc_w_response_ok_cancela
integer width = 2185
integer height = 1740
string title = "GE498 - Tipo de venda - Pedido Disque"
boolean center = true
cb_consulta cb_consulta
dw_2 dw_2
dw_3 dw_3
st_mensagem st_mensagem
gb_convenio gb_convenio
gb_condicao_convenio gb_condicao_convenio
end type
global w_ge498_tipo_venda_pedido w_ge498_tipo_venda_pedido

type prototypes

end prototypes

type variables
uo_convenio                   				io_convenio
uo_conveniado								io_conveniado
uo_dependente_conveniado    			io_dependente
uo_ge498_pedido_disque_entrega		io_pedido
uo_Cliente									io_Cliente
uo_condicao_venda_convenio			io_Condicao_convenio

CONSTANT Long il_width_convenio = 3223
CONSTANT Long il_height_convenio = 1542
CONSTANT Long il_width_padrao = 2162
CONSTANT Long il_height_padrao = 544
CONSTANT Long il_pos_X_OK_conv = 2463
CONSTANT Long il_pos_Y_OK_conv =  1264
CONSTANT Long il_pos_X_Canc_conv = 2799
CONSTANT Long il_pos_Y_Canc_conv = 1264
CONSTANT Long il_pos_X_OK_padrao = 1440
CONSTANT Long il_pos_Y_OK_padrao = 268
CONSTANT Long il_pos_X_Canc_padrao = 1774
CONSTANT Long il_pos_Y_Canc_padrao = 268

String is_Id_Clube_Prazo = 'N'
end variables

forward prototypes
public function boolean wf_bloqueio_convenio_filial ()
public subroutine wf_atualiza_conveniado ()
public subroutine wf_atualiza_dependente ()
public subroutine wf_localiza_dependente ()
public subroutine wf_atualiza_tela (string ps_tipo_venda)
public function boolean wf_processa_convenio (ref string ps_mensagem)
public subroutine wf_localiza_conveniado (string ps_cd_conveniado)
public subroutine wf_localiza_convenio (long pl_cd_convenio)
end prototypes

public function boolean wf_bloqueio_convenio_filial ();LONG   lvl_convenio, lvl_return, lvl_Filial
//
lvl_convenio = dw_2.Object.cd_convenio[1]
lvl_filial   = gvo_parametro.cd_filial
//
SELECT cd_convenio
  INTO :lvl_return
  FROM convenio_filial
 WHERE cd_convenio = :lvl_convenio AND
       cd_filial   = :lvl_filial ;
//
IF SQLCA.SQLCode = 100 THEN
	
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Conv$$HEX1$$ea00$$ENDHEX$$nio n$$HEX1$$e300$$ENDHEX$$o liberado para esta filial.", StopSign!)
		
	RETURN FALSE
	
END IF
//
RETURN TRUE
//
end function

public subroutine wf_atualiza_conveniado ();dw_2.Object.Cd_Conveniado[1] = io_conveniado.Cd_Conveniado
dw_2.Object.Nm_Conveniado[1] = io_conveniado.Nm_Conveniado

//VAI PUXAR O CLIENTE DA TELA DE ATENDIMENTO
//If IsNull(io_venda.cd_cliente) Or Trim(io_venda.cd_cliente) = '' Then
//	dw_1.Object.Cd_Cliente   [1] = io_conveniado.Cd_Cliente
//Else
//	dw_1.Object.Cd_Cliente   [1] = io_venda.cd_cliente
//End If

SetNull(io_dependente.Cd_Dependente)

io_dependente.Nm_Dependente = ""

wf_Atualiza_Dependente()
end subroutine

public subroutine wf_atualiza_dependente ();dw_2.Object.Cd_Dependente[1] = io_dependente.Cd_Dependente
dw_2.Object.Nm_Dependente[1] = io_dependente.Nm_Dependente
end subroutine

public subroutine wf_localiza_dependente ();String lvs_Dependente

lvs_Dependente = dw_1.GetText()

io_dependente.of_Localiza_Dependente(io_convenio.Cd_Convenio, &
                                     io_conveniado.Cd_Conveniado, &
									 			lvs_Dependente)

If io_dependente.Localizado Then
	wf_Atualiza_Dependente()
End If
end subroutine

public subroutine wf_atualiza_tela (string ps_tipo_venda);Choose Case ps_tipo_venda
	Case 'AV'
		This.width = il_width_padrao
		This.height = il_height_padrao
		gb_convenio.visible = False
		This.dw_2.visible = False
		This.cb_ok.x = il_pos_X_OK_padrao
		This.cb_ok.y = il_pos_Y_OK_padrao
		This.cb_cancelar.x = il_pos_X_Canc_padrao
		This.cb_cancelar.y = il_pos_Y_Canc_padrao
		//wf_centraliza_janela()
	Case 'CV'
		This.width = il_width_convenio
		This.height = il_height_convenio
		This.gb_convenio.visible = True
		This.dw_2.visible = True
		This.cb_ok.x = il_pos_X_OK_conv
		This.cb_ok.y = il_pos_Y_OK_conv
		This.cb_cancelar.x = il_pos_X_Canc_conv
		This.cb_cancelar.y = il_pos_Y_Canc_conv
		This.dw_2.setfocus( )
		//wf_centraliza_janela()
	Case 'CR'
		This.width = il_width_padrao
		This.height = il_height_padrao
		gb_convenio.visible = False
		This.dw_2.visible = False
		This.cb_ok.x = il_pos_X_OK_padrao
		This.cb_ok.y = il_pos_Y_OK_padrao
		This.cb_cancelar.x = il_pos_X_Canc_padrao
		This.cb_cancelar.y = il_pos_Y_Canc_padrao
		//wf_centraliza_janela()
	Case 'CC'
		This.width = il_width_padrao
		This.height = il_height_padrao
		gb_convenio.visible = False
		This.dw_2.visible = False
		This.cb_ok.x = il_pos_X_OK_padrao
		This.cb_ok.y = il_pos_Y_OK_padrao
		This.cb_cancelar.x = il_pos_X_Canc_padrao
		This.cb_cancelar.y = il_pos_Y_Canc_padrao
		//wf_centraliza_janela()
End Choose
end subroutine

public function boolean wf_processa_convenio (ref string ps_mensagem);long ll_cd_convenio
long ll_cd_dependente
long ll_cd_condicao
long ll_linha

string ls_log
string ls_cd_conveniado
string ls_matricula
string ls_Restricao_Produto
string ls_Restricao_Grupo
string ls_Considera_desc_produto

boolean lb_retorno
boolean lb_sucesso = false

decimal ldc_Pc_Desconto_Min_Convenio
decimal ldc_valor

Try

	ll_cd_convenio = dw_2.Object.Cd_Convenio[1]
	ls_cd_conveniado = dw_2.Object.Cd_Conveniado[1]
	ll_cd_dependente = dw_2.Object.Cd_dependente[1]
		
	If IsNull(ll_cd_convenio) Or ll_cd_convenio <= 0 Then
		ls_log = "Informe um Conv$$HEX1$$ea00$$ENDHEX$$nio v$$HEX1$$e100$$ENDHEX$$lido."
		dw_2.setcolumn( 'nm_convenio')
		dw_2.setfocus( )
		return false
	End If
	
	If IsNull(ls_cd_conveniado) Or Trim(ls_cd_conveniado) = '' Then
		ls_log = "Informe um Conveniado v$$HEX1$$e100$$ENDHEX$$lido."
		dw_2.setcolumn( 'nm_conveniado')
		dw_2.setfocus( )
		Return false
	End If
		
	lb_retorno = io_Convenio.of_Verifica_Bloqueio_Matriz(ll_cd_convenio, ls_cd_conveniado, ll_cd_dependente, Ref ls_matricula)
																				 
	if lb_retorno = True Then
		ls_log = 'Conv$$HEX1$$ea00$$ENDHEX$$nio bloqueado.'
		return false
	end if	
		
	ll_Linha = dw_3.GetRow()
	If ll_Linha > 0 Then
		
		ll_cd_condicao = dw_3.Object.Cd_Condicao_Convenio[ll_Linha]		
		
		io_Condicao_convenio.of_localiza_codigo( ll_cd_convenio, ll_cd_condicao)
		
		If Not io_Condicao_convenio.Localizado Then
			Return false
		End If
		
		ldc_Pc_Desconto_Min_Convenio = dw_3.Object.pc_desconto_minimo[ll_Linha]
		ls_Restricao_Produto = dw_3.Object.	id_restricao_produto[ll_Linha]
		ls_Restricao_Grupo = dw_3.Object.id_restricao_grupo_produto[ll_Linha]
		ls_Considera_desc_produto = dw_3.Object.id_considera_desc_produto[ll_Linha]
		
	Else
		ls_log = "Selecione a condi$$HEX2$$e700e300$$ENDHEX$$o de venda desejada do Conv$$HEX1$$ea00$$ENDHEX$$nio."
		return false
	End If

//	//Verifica o limite do conveniado
//	if Not io_Conveniado.of_Limite_Conveniado_Liberado_Matriz(ll_cd_convenio, ls_cd_Conveniado, ll_cd_condicao, Ref ldc_valor) Then return false
//														  
	
	ps_mensagem = 'Conv$$HEX1$$ea00$$ENDHEX$$nio: ' + dw_2.Object.nm_fantasia[1] + ' (' + String(dw_2.Object.Cd_Convenio[1]) + ')~r' +&
						'Conveniado: '+ dw_2.Object.nm_Conveniado[1] + ' ('+dw_2.Object.Cd_Conveniado[1]+')~r' + &
						'Condi$$HEX2$$e700e300$$ENDHEX$$o Venda: ' + String(dw_3.Object.Cd_Condicao_Convenio[ll_Linha]) + ' - ' + dw_3.Object.de_Condicao_Convenio[ll_Linha]
	
	io_pedido.io_convenio = io_convenio
	io_pedido.io_conveniado = io_conveniado
	io_pedido.io_Condicao_convenio = io_Condicao_convenio
	
	io_pedido.cd_convenio = ll_cd_Convenio
	io_pedido.nm_convenio = dw_2.Object.nm_fantasia[1]
	io_pedido.cd_conveniado = ls_cd_conveniado
	io_pedido.nm_conveniado = dw_2.Object.nm_Conveniado[1]
	io_pedido.pc_desconto_minimo_convenio = ldc_Pc_Desconto_Min_Convenio
	io_pedido.cd_condicao_convenio = ll_cd_Condicao
	io_pedido.nm_condicao_convenio = dw_3.Object.de_Condicao_Convenio[ll_Linha]
	io_pedido.id_restricao_produto = ls_Restricao_Produto
	io_pedido.id_restricao_grupo	 = ls_Restricao_Grupo
	io_pedido.id_considera_desconto = ls_Considera_desc_produto 

	lb_sucesso = true

Finally
	
	if Not lb_sucesso Then
		messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_log , information!)
	end if
	
End Try



return true
end function

public subroutine wf_localiza_conveniado (string ps_cd_conveniado);String lvs_Conveniado

if ps_cd_conveniado = '' or isnull(ps_cd_conveniado) Then
	lvs_Conveniado = dw_2.GetText()
	io_conveniado.of_Localiza_Conveniado(io_convenio.Cd_Convenio, lvs_Conveniado)
else
	io_conveniado.of_Localiza_Conveniado(io_convenio.Cd_Convenio, ps_cd_conveniado)
end if

If io_conveniado.Localizado Then
	
	wf_Atualiza_Conveniado()
	
	io_conveniado.of_busca_cpf(io_convenio.Cd_Convenio, io_conveniado.Cd_Conveniado)		
	
	dw_2.SetColumn("nm_dependente")
	dw_2.SetFocus()
	
	//gb_condicao_convenio.Visible = True
	//dw_3.visible = True
	//dw_3.retrieve(io_convenio.cd_convenio)
	//If dw_3.rowcount( ) > 0 Then
		//dw_3.SetFocus()	
		cb_consulta.visible = True
	//End If
	
	If io_convenio.id_senha_cartao = "S" Then	
		
		//LIBERACAO SENHA RESPONSAVEL LOJA
		
		//VERIFICAR SITUACAO DE CONVENIADO SEM SENHA CADASTRADA
//		If IsNull(io_conveniado.de_senha) or Trim(io_conveniado.de_senha) = '' Then
//			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O conv$$HEX1$$ea00$$ENDHEX$$nio selecionado exige senha para confirma$$HEX2$$e700e300$$ENDHEX$$o da venda, por$$HEX1$$e900$$ENDHEX$$m o conveniado ainda n$$HEX1$$e300$$ENDHEX$$o possui senha cadastrada.",Exclamation!)					
//		End If
	End If	
End If
end subroutine

public subroutine wf_localiza_convenio (long pl_cd_convenio);String lvs_Convenio

if pl_cd_convenio = 0 or isnull(pl_cd_convenio) then
	lvs_Convenio = dw_2.GetText()
	io_convenio.of_Localiza_Convenio(lvs_Convenio)
else
	io_convenio.of_Localiza_Convenio(string(pl_cd_convenio))
end if

If io_convenio.Localizado Then
	
	dw_2.Object.Cd_Convenio             [1] = io_convenio.Cd_Convenio
	dw_2.Object.Nm_Fantasia             [1] = io_convenio.Nm_Fantasia
	dw_2.Object.Pc_Desconto_Taxa_Entrega[1] = io_convenio.Pc_Desconto_Taxa_Entrega
	dw_2.Object.cd_convenio_edm         [1] = io_convenio.cd_convenio_edm
	dw_2.Object.id_clube_drogaria       [1] = io_convenio.id_clube_drogaria

	If Wf_Bloqueio_Convenio_Filial() Then

		SetNull(io_conveniado.Cd_Conveniado)
		
		io_conveniado.nm_Conveniado = ""
		
		wf_Atualiza_Conveniado()
		dw_3.reset()
		cb_consulta.visible = False

		dw_2.SetColumn("nm_conveniado")
		dw_2.SetFocus()
	Else	
		
		dw_2.Object.cd_convenio[1] = 0
		dw_2.Object.nm_fantasia[1] = ""
		
		dw_2.Object.cd_conveniado[1] = ""
		dw_2.Object.nm_conveniado[1] = ""
		
		SetNull(io_conveniado.Cd_Convenio)
		SetNull(io_conveniado.Cd_Conveniado)		
		
		io_convenio.Nm_Fantasia     = ""
		io_conveniado.Nm_Conveniado = ""
		
		dw_2.SetColumn("nm_fantasia")
		dw_2.SetFocus()
		
	End If
	gb_condicao_convenio.visible = true
	dw_3.visible = True
	dw_3.retrieve(io_convenio.cd_convenio)
				
End If
end subroutine

on w_ge498_tipo_venda_pedido.create
int iCurrent
call super::create
this.cb_consulta=create cb_consulta
this.dw_2=create dw_2
this.dw_3=create dw_3
this.st_mensagem=create st_mensagem
this.gb_convenio=create gb_convenio
this.gb_condicao_convenio=create gb_condicao_convenio
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_consulta
this.Control[iCurrent+2]=this.dw_2
this.Control[iCurrent+3]=this.dw_3
this.Control[iCurrent+4]=this.st_mensagem
this.Control[iCurrent+5]=this.gb_convenio
this.Control[iCurrent+6]=this.gb_condicao_convenio
end on

on w_ge498_tipo_venda_pedido.destroy
call super::destroy
destroy(this.cb_consulta)
destroy(this.dw_2)
destroy(this.dw_3)
destroy(this.st_mensagem)
destroy(this.gb_convenio)
destroy(this.gb_condicao_convenio)
end on

event open;call super::open;io_pedido 					= Create uo_ge498_pedido_disque_entrega
io_convenio 					= Create uo_convenio
io_conveniado	 			= Create uo_conveniado
io_dependente 				= Create uo_dependente_conveniado
io_Cliente 					= Create uo_Cliente
io_Condicao_convenio	= Create uo_Condicao_Venda_Convenio

wf_centraliza_janela()

io_pedido = Message.PowerObjectParm

io_Cliente.of_localiza_codigo( io_pedido.cd_cliente )

If Not io_Cliente.Localizado Then
	SetNull(io_pedido.cd_cliente)
	CloseWithReturn(This, io_pedido)
End If





end event

event ue_postopen;call super::ue_postopen;long ll_find

dw_2.Event ue_AddRow()
dw_3.Event ue_AddRow()

uo_parametro_filial io_parametro
io_parametro = Create uo_parametro_filial
io_parametro.of_localiza_parametro( 'ID_CLUBE_PRAZO', ref is_Id_Clube_Prazo)
Destroy io_parametro

if io_pedido.cd_convenio > 0 Then
	
	dw_1.object.id_tipo_venda[1] = 'CV'
	
	this.wf_atualiza_tela( 'CV' )
	
	this.wf_localiza_convenio( io_pedido.cd_convenio )
	
end if

if io_pedido.cd_condicao_convenio > 0  then
	
	ll_find  = dw_3.find('cd_condicao_convenio = ' + string(io_pedido.cd_condicao_convenio),1,dw_3.rowcount( ) )
	
	if ll_find > 0 then
		dw_3.setrow( ll_find )
	end if
	
	dw_2.setcolumn( 'nm_conveniado')
	dw_2.setfocus( )
	
end if


end event

event close;call super::close;//Destroy(io_pedido)
//Destroy(io_convenio)
//Destroy(io_conveniado)
Destroy(io_dependente)
Destroy(io_Cliente)
//Destroy(io_Condicao_convenio)
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge498_tipo_venda_pedido
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge498_tipo_venda_pedido
integer width = 2107
integer height = 228
integer taborder = 20
string text = "Tipo de Venda"
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge498_tipo_venda_pedido
integer y = 60
integer width = 1998
integer height = 152
integer taborder = 30
string dataobject = "dw_ge498_tipo_venda"
end type

event dw_1::itemchanged;call super::itemchanged;If dwo.Name = "id_tipo_venda" Then
	If Trim(Data) <> "" Then
		Choose Case Data
			Case 'CR'
				If io_Cliente.id_tipo_cliente <> Data Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Cliente selecionado n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ do tipo CREDI$$HEX1$$c100$$ENDHEX$$RIO.")
					This.Object.id_tipo_venda[1] = 'AV'
					wf_atualiza_tela( 'AV' )
					Return 1
				End If
			
			Case 'CC';
				If io_Cliente.id_tipo_cliente <> Data Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Cliente selecionado n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ do tipo CLUBE PRAZO.", Exclamation!)
					This.Object.id_tipo_venda[1] = 'AV'
					wf_atualiza_tela( 'AV' )
					Return 1
				End If
				
				If is_Id_Clube_Prazo <> 'S' Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Loja n$$HEX1$$e300$$ENDHEX$$o habilitada para venda do tipo CLUBE PRAZO.", Exclamation!)
					This.Object.id_tipo_venda[1] = 'AV'
					wf_atualiza_tela( 'AV' )
					Return 1
				End If
				
			Case 'CV';
			Case 'AV'
			Case 'PB'
			
		End Choose	
		
		wf_atualiza_tela( String(Data) )
	End If
End If
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge498_tipo_venda_pedido
integer x = 1458
integer y = 272
integer taborder = 80
boolean default = false
end type

event cb_ok::clicked;call super::clicked;String ls_tipo_venda
String ls_msg_conv
String ls_msg
String ls_desc_venda
String ls_retorno
long ll_linha
dc_uo_ds_base lds_param

dw_1.AcceptText( )
dw_2.AcceptText( )
dw_3.AcceptText( )

ls_tipo_venda = dw_1.object.id_tipo_venda [1]

If IsNull(ls_tipo_venda) Or ls_tipo_venda = '' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione o tipo de Venda.", Information!)
	dw_1.setfocus( )
	Return - 1
End if

Choose Case ls_tipo_venda
	Case 'AV'
		ls_desc_venda = 'A VISTA'		
		
	Case 'CV'
		ls_desc_venda = 'CONV$$HEX1$$ca00$$ENDHEX$$NIO'
		
		if Not parent.wf_processa_convenio( ref ls_msg_conv ) then return -1
							
	Case 'CR'
		ls_desc_venda = 'CREDI$$HEX1$$c100$$ENDHEX$$RIO'
				
	Case 'CC'
		ls_desc_venda = 'CLUBE PRAZO'
		
End Choose

ls_msg = 'Prosseguir com o Pedido Disque Entrega? ~r~r'+ &
			 'Tipo venda: ' + ls_desc_venda + '~r' + &
			 '      Cliente: ' + io_Cliente.nm_cliente + '~r' + &
			 ls_msg_conv

lds_param = create dc_uo_ds_base
lds_param.dataobject = 'dw_ge498_tipo_venda_pedido_msg'

ll_linha = lds_param.insertrow(0)
lds_param.object.de_tipo[ll_linha] = 'Tipo venda:'
lds_param.object.de_descricao[ll_linha] = ls_desc_venda

ll_linha = lds_param.insertrow(0)
lds_param.object.de_tipo[ll_linha] = 'Cliente:'
lds_param.object.de_descricao[ll_linha] = io_Cliente.nm_cliente

if ls_tipo_venda = 'CV' then

	ll_linha = lds_param.insertrow(0)
	lds_param.object.de_tipo[ll_linha] = 'Conv$$HEX1$$ea00$$ENDHEX$$nio:'
	lds_param.object.de_descricao[ll_linha] = io_pedido.nm_convenio + ' (' + String(io_pedido.cd_convenio) + ')'
	
	ll_linha = lds_param.insertrow(0)
	lds_param.object.de_tipo[ll_linha] = 'Conveniado:'
	lds_param.object.de_descricao[ll_linha] = io_pedido.nm_conveniado + ' ('+io_pedido.cd_conveniado+')'
	
	ll_linha = lds_param.insertrow(0)
	lds_param.object.de_tipo[ll_linha] = 'Condi$$HEX2$$e700e300$$ENDHEX$$o venda:'
	lds_param.object.de_descricao[ll_linha] =  String(io_pedido.cd_condicao_convenio) + ' - ' + io_pedido.nm_condicao_convenio
//	
end if

OpenWithParm( w_ge498_tipo_venda_pedido_msg, lds_param )

ls_retorno = message.stringparm

If ls_retorno = 'S' Then
	//io_pedido.cd_cliente =
	//io_pedido.nm_cliente =
	io_pedido.id_tipo_venda = ls_tipo_venda

	CloseWithReturn(Parent, io_pedido)
Else
	Return -1
End If			 

end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge498_tipo_venda_pedido
integer x = 1792
integer y = 272
integer taborder = 90
end type

event cb_cancelar::clicked;//OverRide
String ls_null

SetNull(ls_null)
io_Pedido.cd_cliente = ls_Null
CloseWithReturn(Parent, io_Pedido)
end event

type cb_consulta from commandbutton within w_ge498_tipo_venda_pedido
boolean visible = false
integer x = 32
integer y = 1248
integer width = 512
integer height = 100
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Consulta &Limite"
end type

event clicked;Long ll_Convenio
Long ll_Condicao
Long ll_Linha

Decimal ldc_Pago_Avista
Decimal ldc_Valor_Limite

String ls_conveniado

ll_Linha = dw_3.GetRow()

If ll_Linha > 0 Then	
	
	ll_Condicao 			= dw_3.Object.Cd_Condicao_Convenio[ll_Linha]
	ldc_Pago_Avista 	= dw_3.Object.pc_avista[ll_Linha]
	
	If ldc_Pago_Avista = 100 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Condi$$HEX2$$e700e300$$ENDHEX$$o Selecionada n$$HEX1$$e300$$ENDHEX$$o usa Limite.")		
		Return
	End If
	
	ll_Convenio 		= dw_2.Object.cd_convenio		[1]
	ls_Conveniado	= dw_2.Object.cd_conveniado [1]

	If Not io_Conveniado.of_Consulta_Limite_Matriz(ll_Convenio, &
 																 	ls_Conveniado, &
																	ll_Condicao, &
																	Ref ldc_Valor_Limite)	Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o foi possivel consultar o Limite na Matriz!")
	Else
		If ldc_Valor_limite = 0 Then MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Sem restri$$HEX2$$e700e300$$ENDHEX$$o de Limite.")
		
		If ldc_Valor_limite > 0 Then 
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Limite de compra de R$ " + String(ldc_Valor_Limite, "0.00") + " para a condi$$HEX2$$e700e300$$ENDHEX$$o escolhida.")
		End If
		
		If ldc_Valor_limite < 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Cliente sem limite.")			
		End If
	End If	
	
End If
end event

type dw_2 from dc_uo_dw_base within w_ge498_tipo_venda_pedido
boolean visible = false
integer x = 87
integer y = 324
integer width = 2290
integer height = 240
integer taborder = 50
boolean bringtotop = true
string dataobject = "dw_ge498_selecao_convenio_conveniado"
end type

event itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case "nm_fantasia"
		If Data <> io_convenio.Nm_Fantasia Then Return 1
	Case "nm_conveniado"
		If Data <> io_conveniado.Nm_Conveniado Then Return 1
	Case "nm_dependente"
		If Trim(Data) <> "" Then
			If Data <> io_dependente.Nm_Dependente Then Return 1					
		Else
			SetNull(io_dependente.Cd_Dependente)
			io_dependente.Nm_Dependente = ""
			
			wf_Atualiza_Dependente()			
		End If
End Choose
end event

event ue_key;call super::ue_key;LONG lvl_Convenio

If Key = KeyEnter! Then
	
	Choose Case This.GetColumnName()
		Case "nm_fantasia"   ; wf_Localiza_Convenio(0)
		Case "nm_conveniado" ; wf_Localiza_Conveniado('')
		Case "nm_dependente" ; wf_Localiza_Dependente()
	End Choose

End If
end event

event losefocus;call super::losefocus;//Override

If IsValid(io_convenio) Then
	dw_2.Object.Nm_Fantasia[1] = io_convenio.Nm_Fantasia
End If

If IsValid(io_conveniado) Then
	dw_2.Object.nm_Conveniado[1] = io_conveniado.Nm_Conveniado
End If

If IsValid(io_dependente) Then
	dw_2.Object.Nm_Dependente[1] = io_dependente.Nm_Dependente
End If
end event

event constructor;call super::constructor;This.of_SetColSelection(True)
end event

type dw_3 from dc_uo_dw_base within w_ge498_tipo_venda_pedido
boolean visible = false
integer x = 46
integer y = 688
integer width = 3118
integer height = 528
integer taborder = 70
boolean bringtotop = true
string dataobject = "dw_ge498_selecao_condicao_convenio"
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.of_SetRowSelection()
end event

event rowfocuschanged;call super::rowfocuschanged;If currentRow > 0 Then
	st_mensagem.text = This.Object.cp_mensagem_receita[currentRow]
Else
	st_mensagem.text = ''
ENd If

Return currentRow
end event

type st_mensagem from statictext within w_ge498_tipo_venda_pedido
integer x = 713
integer y = 1248
integer width = 1710
integer height = 96
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 128
long backcolor = 67108864
string text = "none"
boolean focusrectangle = false
end type

type gb_convenio from groupbox within w_ge498_tipo_venda_pedido
boolean visible = false
integer x = 32
integer y = 244
integer width = 2373
integer height = 376
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Dados Conv$$HEX1$$ea00$$ENDHEX$$nio"
borderstyle borderstyle = styleraised!
end type

type gb_condicao_convenio from groupbox within w_ge498_tipo_venda_pedido
boolean visible = false
integer x = 23
integer y = 632
integer width = 3173
integer height = 596
integer taborder = 60
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Condi$$HEX2$$e700f500$$ENDHEX$$es Conv$$HEX1$$ea00$$ENDHEX$$nio"
end type

