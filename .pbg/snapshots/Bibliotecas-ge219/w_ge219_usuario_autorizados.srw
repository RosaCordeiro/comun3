HA$PBExportHeader$w_ge219_usuario_autorizados.srw
forward
global type w_ge219_usuario_autorizados from dc_w_response_ok_cancela
end type
type cb_1 from commandbutton within w_ge219_usuario_autorizados
end type
end forward

global type w_ge219_usuario_autorizados from dc_w_response_ok_cancela
integer width = 2862
integer height = 1284
string title = "GE219 - Usu$$HEX1$$e100$$ENDHEX$$rios Autorizados a Liberar Pedido"
cb_1 cb_1
end type
global w_ge219_usuario_autorizados w_ge219_usuario_autorizados

type variables
uo_GE219_Liberacao_Pedido_Central iuo_Liberacao

end variables

forward prototypes
public function boolean wf_envia_email ()
public function boolean wf_existe_responsavel_selecionado (ref integer ai_reponsaveis)
end prototypes

public function boolean wf_envia_email ();Boolean lvb_Sucesso = True

Integer li_Linha, li_Responsaveis, li_Contador

String ls_Endereco_Email[], ls_Mensagem, ls_Enter, ls_Matricula

If dw_1.RowCount() > 0  Then

	If Not wf_Existe_Responsavel_Selecionado(ref li_Responsaveis) Then
		Return false
	End If
		
	If li_Responsaveis > 0 Then
		
		DELETE FROM pedido_central_liberacao
		Where nr_pedido = :iuo_Liberacao.nr_pedido_central
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgDbError("Erro na exclus$$HEX1$$e300$$ENDHEX$$o dos repons$$HEX1$$e100$$ENDHEX$$veis pela libera$$HEX2$$e700e300$$ENDHEX$$o do pedido.")
			Return False
		End If		
		
		For li_Linha = 1 to dw_1.Rowcount( )
			
			If dw_1.Object.id_enviar_email[li_Linha] = 'S' Then
				
				li_Contador ++
				
				ls_Endereco_Email[li_Contador]	= dw_1.Object.de_endereco_email	[li_Linha]
				ls_Matricula								= dw_1.Object.nr_matricula				[li_Linha]
				
				INSERT INTO pedido_central_liberacao ( nr_pedido, nr_matricula )  
 				VALUES ( :iuo_Liberacao.nr_pedido_central,  :ls_Matricula ) 
			 	USING Sqlca;
				 
				 If SqlCa.SqlCode = -1 Then
					SqlCa.of_MsgDbError("Erro na inclus$$HEX1$$e300$$ENDHEX$$o do respons$$HEX1$$e100$$ENDHEX$$vel pela libera$$HEX2$$e700e300$$ENDHEX$$o do pedido.")
					lvb_Sucesso = False
					Exit
				 End If
			
			End If
			
		Next
		
		If Not lvb_Sucesso Then Return False
		
		SqlCa.of_Commit();
				
		ls_Enter = char(13)+char(10)
		
		ls_Mensagem =	"Voc$$HEX1$$ea00$$ENDHEX$$ $$HEX1$$e900$$ENDHEX$$ respons$$HEX1$$e100$$ENDHEX$$vel em aprovar o pedido '" +&
								String(iuo_Liberacao.nr_pedido_central) + "' no valor de '" +&
								String(iuo_Liberacao.vl_Pedido, "#,##0.00") + "'." +&
								ls_Enter + ls_Enter +  "Email autom$$HEX1$$e100$$ENDHEX$$tico."
									
									
	Else
//		// Colocar o e-mail do HEDER
//		ls_Endereco_Email[1]  = 'sergio.gol@clamed.com.br'
//		ls_Endereco_Email[2]  = is_email_comprador
//				
//		ls_Enter = char(13)+char(10)
//			
//		ls_Mensagem =	"Voc$$HEX1$$ea00$$ENDHEX$$ $$HEX1$$e900$$ENDHEX$$ respons$$HEX1$$e100$$ENDHEX$$vel em aprovar o pedido '" +&
//								String(iuo_Liberacao.nr_pedido_central) + "'." +&
//								ls_Enter + ls_Enter +  "*** Nenhum respons$$HEX1$$e100$$ENDHEX$$vel com e-mail foi selecionado para aprovar o pedido. ***" +&
//								ls_Enter + ls_Enter +  "Email autom$$HEX1$$e100$$ENDHEX$$tico."
				
	End If
	
	iuo_Liberacao.of_Envia_Email(iuo_Liberacao.nm_responsavel, "Aprovar Pedido de Compra", ls_Mensagem, iuo_Liberacao.de_endereco_email_responsavel, ls_Endereco_Email)
	
End If

Return lvb_Sucesso
end function

public function boolean wf_existe_responsavel_selecionado (ref integer ai_reponsaveis);String ls_Mensagem

ai_reponsaveis = dw_1.GetItemNumber(dw_1.RowCount(), "total_responsaveis")

If ai_reponsaveis = 0 Then
	MessageBox('Aten$$HEX1$$e700$$ENDHEX$$ao', 'Nenhum respons$$HEX1$$e100$$ENDHEX$$vel foi selecionado.', Exclamation!)
	Return False
End If

If ai_reponsaveis = 1 Then
	ls_Mensagem = 'Confirma o envio do e-mail para o respons$$HEX1$$e100$$ENDHEX$$vel selecionado ?'
Else
	ls_Mensagem = 'Confirma o envio do e-mail para os respons$$HEX1$$e100$$ENDHEX$$veis selecionados ?'
End If

If MessageBox('Aten$$HEX1$$e700$$ENDHEX$$ao', ls_Mensagem, Question!, YesNo!, 2)  = 2 Then
	Return False
End If

Return true


end function

on w_ge219_usuario_autorizados.create
int iCurrent
call super::create
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
end on

on w_ge219_usuario_autorizados.destroy
call super::destroy
destroy(this.cb_1)
end on

event open;call super::open;iuo_Liberacao = Create uo_GE219_Liberacao_Pedido_Central

iuo_Liberacao = Message.PowerObjectParm
end event

event ue_postopen;call super::ue_postopen;dw_1.Event ue_Retrieve()

dw_1.Object.t_pedido.text = "Pedido de Compra: " + String(iuo_Liberacao.nr_pedido_central)
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge219_usuario_autorizados
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge219_usuario_autorizados
integer width = 2793
integer height = 1028
string text = "Pessoas Autorizadas a Liberar o Pedido"
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge219_usuario_autorizados
integer x = 64
integer y = 72
integer width = 2725
integer height = 924
string dataobject = "ds_lista_liberacao_pedido"
boolean vscrollbar = true
end type

event dw_1::itemchanged;call super::itemchanged;String ls_Endereco_Email, ls_Usuario

If Row > 0 Then
	
	ls_Endereco_Email	= Trim(This.Object.de_endereco_email[Row])
	ls_Usuario			= This.Object.nm_usuario[row]
	
	If Data = "S" and (IsNull(ls_Endereco_Email)  or ls_Endereco_Email = "")  Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existe e-mail cadastrado para o respons$$HEX1$$e100$$ENDHEX$$vel '" + ls_Usuario + "'.", Exclamation!)
		Return 1
	End If
End If

Return 0
end event

event dw_1::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	dw_1.SetRedraw(false)
	dw_1.SetFilter("vl_liberado > " + gf_Replace(String(iuo_Liberacao.vl_pedido), ',','.',0))
	dw_1.Filter()
	dw_1.SetRedraw(true)
End If

Return pl_Linhas
end event

event dw_1::ue_recuperar;//OverRide

Return This.Retrieve(iuo_Liberacao.vl_pedido)
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge219_usuario_autorizados
integer x = 2505
integer y = 1064
end type

event cb_ok::clicked;call super::clicked;String lvs_Retorno

If wf_Envia_Email() Then
	SetNull(lvs_Retorno)
	CloseWithReturn(Parent, lvs_Retorno)
End If
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge219_usuario_autorizados
boolean visible = false
integer x = 1344
integer y = 1160
end type

type cb_1 from commandbutton within w_ge219_usuario_autorizados
integer x = 23
integer y = 1064
integer width = 727
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Voltar para Rascunho"
end type

event clicked;String lvs_Retorno

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja salvar o pedido '"  + String(iuo_Liberacao.nr_pedido_central) + "' como RASCUNHO ?", Question!, YesNo!, 2) = 2 Then Return

Update pedido_central
Set id_situacao = 'R'
Where nr_pedido = :iuo_Liberacao.nr_pedido_central
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do pedido para RASCUNHO.")
Else

	SqlCa.of_Commit();

	SetNull(lvs_Retorno)
	CloseWithReturn(Parent, lvs_Retorno)
	
End If

end event

