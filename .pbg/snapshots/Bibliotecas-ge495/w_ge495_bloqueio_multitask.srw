HA$PBExportHeader$w_ge495_bloqueio_multitask.srw
forward
global type w_ge495_bloqueio_multitask from dc_w_cadastro_selecao_lista
end type
type cb_1 from commandbutton within w_ge495_bloqueio_multitask
end type
type cb_2 from commandbutton within w_ge495_bloqueio_multitask
end type
end forward

global type w_ge495_bloqueio_multitask from dc_w_cadastro_selecao_lista
string tag = "w_ge495_bloqueio_multitask"
integer width = 3287
integer height = 1532
string title = "GE495 - Bloqueio Gera$$HEX2$$e700e300$$ENDHEX$$o de Pedido da MultiTask"
cb_1 cb_1
cb_2 cb_2
end type
global w_ge495_bloqueio_multitask w_ge495_bloqueio_multitask

type variables
uo_ge495_email_bloqueio_multitask lo_email_bloqueio
String ls_erro 
Long  ll_Dias_Envio_Tela = 3 

end variables

forward prototypes
public function string wf_retorna_usuario ()
end prototypes

public function string wf_retorna_usuario ();String ls_Matricula, ls_Nome

Select nr_matricula, nm_usuario
Into :ls_Matricula, :ls_Nome
From usuario
Where nr_matricula = :gvo_Aplicacao.ivo_Seguranca.Nr_Matricula
Using Sqlca;

Choose Case SqlCa.Sqlcode
	Case 0
		 Return ls_Matricula + ' : ' + ls_Nome
	Case 100
	Case -1
		SqlCa.of_MsgDbError('Erro ao localizar o usu$$HEX1$$e100$$ENDHEX$$rio respons$$HEX1$$e100$$ENDHEX$$vel.')
End Choose 

Return ''

end function

on w_ge495_bloqueio_multitask.create
int iCurrent
call super::create
this.cb_1=create cb_1
this.cb_2=create cb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
this.Control[iCurrent+2]=this.cb_2
end on

on w_ge495_bloqueio_multitask.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_1)
destroy(this.cb_2)
end on

event close;call super::close;Destroy (lo_email_bloqueio)
end event

event open;call super::open;lo_email_bloqueio = Create uo_ge495_email_bloqueio_multitask
end event

type dw_visual from dc_w_cadastro_selecao_lista`dw_visual within w_ge495_bloqueio_multitask
end type

type gb_aux_visual from dc_w_cadastro_selecao_lista`gb_aux_visual within w_ge495_bloqueio_multitask
end type

type dw_1 from dc_w_cadastro_selecao_lista`dw_1 within w_ge495_bloqueio_multitask
integer x = 64
integer y = 68
integer width = 613
integer height = 88
string dataobject = "dw_ge495_selecao"
end type

event dw_1::constructor;call super::constructor;// Habilitar a coluna de sele$$HEX2$$e700e300$$ENDHEX$$o (freform)
This.of_SetColSelection(True)
end event

event dw_1::itemchanged;call super::itemchanged;dw_2.Reset()
end event

type gb_2 from dc_w_cadastro_selecao_lista`gb_2 within w_ge495_bloqueio_multitask
integer y = 220
integer width = 3154
end type

type gb_1 from dc_w_cadastro_selecao_lista`gb_1 within w_ge495_bloqueio_multitask
integer width = 658
integer height = 180
end type

type dw_2 from dc_w_cadastro_selecao_lista`dw_2 within w_ge495_bloqueio_multitask
integer x = 78
integer y = 296
integer width = 3090
integer height = 876
string dataobject = "dw_ge495_lista"
end type

event dw_2::constructor;call super::constructor;// Habilitar a linha de sele$$HEX2$$e700e300$$ENDHEX$$o (list)
This.of_SetRowSelection()


end event

event dw_2::ue_addrow;call super::ue_addrow;If AncestorReturnValue > 0 Then
	This.Object.nr_matricula_inclusao	[AncestorReturnValue] = gvo_Aplicacao.ivo_Seguranca.Nr_Matricula
	This.Object.de_usuario				[AncestorReturnValue] = wf_Retorna_Usuario()	
End If

Return AncestorReturnValue
end event

event dw_2::itemchanged;call super::itemchanged;//override

//If Not This.of_Coluna_Sem_Validacao_Salva(dwo.Name) Then
//	If ivb_UpdateAble Then
//		ivw_ParentWindow.ivb_Valida_Salva = True
//	End If
//End If
//
//This.Object.nr_matricula_inclusao	[This.GetRow()] = gvo_Aplicacao.ivo_Seguranca.Nr_Matricula
//This.Object.de_usuario				[This.GetRow()] = wf_Retorna_Usuario()	
//
//If Date(This.Object.dh_pedido[This.GetRow()]) < Date(gf_GetServerdate()) Then
//	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'A data do bloqueio deve maior ou igual a data atual.')
//	dw_2.Event ue_Pos(This.GetRow(), 'dh_pedido')
//	Return -1
//End If
//
//If IsNull(This.Object.de_motivo_bloqueio[This.GetRow()]) or Trim(This.Object.de_motivo_bloqueio[This.GetRow()]) = '' Then
//	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Informe o motivo do bloqueio.')
//	dw_2.Event ue_Pos(This.GetRow(), 'de_motivo_bloqueio')
//	Return -1
//End If
end event

event dw_2::ue_recuperar;//override

Date ldh_Bloqueio

dw_1.AcceptText()

ldh_Bloqueio = dw_1.Object.dh_bloqueio[1]

If Not IsNull(ldh_Bloqueio) Then
	This.of_AppendWhere("p.dh_pedido = '" + String(ldh_Bloqueio, 'yyyy/mm/dd') + "'")	
End If

Return This.Retrieve()

end event

event dw_2::ue_preupdate;call super::ue_preupdate;Long ll_Linha
Date ldh_Parametro
String ls_Origem
String lvs_origem_salvar

			
ldh_Parametro = Date(gf_GetServerdate())
lvs_origem_salvar = "Salvando : GE495 - Bloqueio Gera$$HEX2$$e700e300$$ENDHEX$$o de Pedido da MultiTask: 3 Dias Antes"

For ll_Linha = 1 to This.RowCount()

	If date(This.Object.dh_pedido[ll_Linha]) <>  iif(IsNull(This.Object.dh_pedido_anterior[ll_Linha]), Date('01/01/1900'), Date(This.Object.dh_pedido_anterior[ll_Linha])) Then
		If Date(This.Object.dh_pedido[ll_Linha]) < ldh_Parametro Then
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'A data do bloqueio deve maior ou igual a data atual.')
			This.Event ue_Pos(ll_Linha, 'dh_pedido')
			Return -1
		End If
	End If
	
	If Date(This.Object.dh_pedido[ll_Linha]) > RelativeDate(ldh_Parametro, 90) Then
		If MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Voc$$HEX1$$ea00$$ENDHEX$$ esta cadastrando uma data maior que 90 dias da data atual.'+&
							'~r~rDeseja continuar mesmo assim?', Question!, YesNo!, 2) = 2 Then
			Return -1
		End If
	End If
		
	If (IsNull(This.Object.de_motivo_bloqueio[ll_Linha]) or Trim(This.Object.de_motivo_bloqueio[ll_Linha]) = '') or (iif(IsNull(This.Object.de_motivo_bloqueio[ll_Linha]), '', This.Object.de_motivo_bloqueio[ll_Linha]) <> iif(IsNull(This.Object.de_motivo_bloqueio_anterior[ll_Linha]), '', This.Object.de_motivo_bloqueio_anterior[ll_Linha])) Then
		If IsNull(This.Object.de_motivo_bloqueio[ll_Linha]) or Trim(This.Object.de_motivo_bloqueio[ll_Linha]) = '' Then
			MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Informe o motivo do bloqueio.')
			This.Event ue_Pos(ll_Linha, 'de_motivo_bloqueio')
			Return -1
		End If
	End If
	
	
	// Faz diferen$$HEX1$$e700$$ENDHEX$$a dos Dias, Caso seja ll_Dias_Envio_Tela Envia email
//	If DaysAfter(ldh_Parametro , Date(This.Object.dh_pedido[ll_Linha])) = ll_Dias_Envio_Tela  Then 
//		If Not lo_email_bloqueio.of_envia_email( This.Object.de_motivo_bloqueio[ll_Linha],&
//																	Date(This.Object.dh_pedido[ll_Linha]),&  
//																	ldh_Parametro,& 
//																	ls_erro,& 
//																	lvs_origem_salvar) Then 
//			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no envio do email Mudan$$HEX1$$e700$$ENDHEX$$a Procedimento Data Pedido! Avise Inform$$HEX1$$e100$$ENDHEX$$tica", StopSign!)
//			dw_1.SetFocus()
//			Return -1			 
//		End If 				
//	End If	
Next

Return AncestorReturnValue
end event

type cb_1 from commandbutton within w_ge495_bloqueio_multitask
integer x = 2670
integer y = 1216
integer width = 521
integer height = 112
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Enviar Email"
end type

event clicked;Long ll_Linha


String ls_de_motivo,&
		  ls_origem

Date ldt_pedido,&
		ldt_hoje,&
		ldt_dh_envio
		
		

dw_2.accepttext( )
ll_Linha 			= dw_2.getrow( )
ls_de_motivo = dw_2.object.de_motivo_bloqueio[ll_Linha]
ldt_pedido 	= Date(dw_2.object.dh_pedido[ll_Linha])
ldt_hoje  		=   Date (gf_GetServerDate()) 	
ls_origem 		= "Bot$$HEX1$$e300$$ENDHEX$$o Enviar Email: GE495 - Bloqueio Gera$$HEX2$$e700e300$$ENDHEX$$o de Pedido da MultiTask"


// N$$HEX1$$e300$$ENDHEX$$o permite envio de email : Data Pedido Menor Data de Hoje
If ldt_pedido<ldt_hoje Then 
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Data nao permitida para envio do email!", StopSign!)
	dw_1.SetFocus()
	Return 
End If 

// Mensagem antes do envio
If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma o envio do email ?", Question!, YesNo!, 2) = 1 Then
		If Not lo_email_bloqueio.of_envia_email( ls_de_motivo,&
																	ldt_pedido,&  
																	ldt_hoje,& 
																	ls_erro,& 
																	ls_origem) Then 
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no envio do email Mudan$$HEX1$$e700$$ENDHEX$$a Procedimento Data Pedido! Avise Inform$$HEX1$$e100$$ENDHEX$$tica", StopSign!)
			dw_1.SetFocus()
			Return 
		End If 		
Else	
	dw_1.SetFocus()
	Return 
End If 
end event

type cb_2 from commandbutton within w_ge495_bloqueio_multitask
boolean visible = false
integer x = 1815
integer y = 1224
integer width = 402
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
boolean enabled = false
string text = "none"
end type

event clicked;

If Not lo_email_bloqueio.of_envia_email_automatico( ) Then 
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no envio do email Mudan$$HEX1$$e700$$ENDHEX$$a Procedimento Data Pedido! Avise Inform$$HEX1$$e100$$ENDHEX$$tica", StopSign!)
	Return
End If 


end event

