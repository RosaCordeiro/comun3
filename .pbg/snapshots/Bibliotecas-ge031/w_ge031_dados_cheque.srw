HA$PBExportHeader$w_ge031_dados_cheque.srw
forward
global type w_ge031_dados_cheque from dc_w_response_ok_cancela
end type
type st_aviso1 from statictext within w_ge031_dados_cheque
end type
type st_aviso2 from statictext within w_ge031_dados_cheque
end type
type uo_msg_menu from uo_texto_paf2 within w_ge031_dados_cheque
end type
end forward

global type w_ge031_dados_cheque from dc_w_response_ok_cancela
integer width = 1801
integer height = 1008
string title = "GE031 - Lan$$HEX1$$e700$$ENDHEX$$amento de Cheques"
st_aviso1 st_aviso1
st_aviso2 st_aviso2
uo_msg_menu uo_msg_menu
end type
global w_ge031_dados_cheque w_ge031_dados_cheque

type variables
uo_banco	ivo_banco
uo_ge031_cheque	ivo_cheque
end variables

forward prototypes
public function boolean wf_valida_cmc7 (string ps_cmc7)
public function boolean wf_preenche_campos (string ps_cmc7)
public function boolean wf_verifica_cheque ()
end prototypes

public function boolean wf_valida_cmc7 (string ps_cmc7);Long  ll_A, ll_B, ll_C,ll_D,ll_E,ll_F,ll_G,ll_C2,ll_H,ll_I,ll_J,ll_K,&
	  	ll_L,ll_M,ll_N,ll_O,ll_P,ll_Q,ll_C1,ll_R,ll_S,ll_T,ll_U,ll_V,&
		ll_W,ll_X,ll_Y,ll_Z,ll_$,ll_C3,ll_var1,ll_var2,ll_var3,&
		ll_Soma,ll_C1_calc,ll_C2_calc,ll_C3_calc, ll_Resto

Decimal {2} ldc_Resultado

//Verifica se est$$HEX1$$e100$$ENDHEX$$ nulo, se sim, retorna falso

If Trim(ps_cmc7) = '' or IsNull(ps_cmc7) Then
	Return False
End If

ll_A	= Long(MidA(ps_cmc7,1,1))
ll_B	= Long(MidA(ps_cmc7,2,1))
ll_C	= Long(MidA(ps_cmc7,3,1))
ll_D	= Long(MidA(ps_cmc7,4,1))
ll_E	= Long(MidA(ps_cmc7,5,1))
ll_F	= Long(MidA(ps_cmc7,6,1))
ll_G	= Long(MidA(ps_cmc7,7,1))
ll_C2	= Long(MidA(ps_cmc7,8,1))
ll_H	= Long(MidA(ps_cmc7,9,1))
ll_I		= Long(MidA(ps_cmc7,10,1))
ll_J	= Long(MidA(ps_cmc7,11,1))
ll_K	= Long(MidA(ps_cmc7,12,1))
ll_L	= Long(MidA(ps_cmc7,13,1))
ll_M	= Long(MidA(ps_cmc7,14,1))
ll_N	= Long(MidA(ps_cmc7,15,1))
ll_O	= Long(MidA(ps_cmc7,16,1))
ll_P	= Long(MidA(ps_cmc7,17,1))
ll_Q	= Long(MidA(ps_cmc7,18,1))
ll_C1	= Long(MidA(ps_cmc7,19,1))
ll_R	= Long(MidA(ps_cmc7,20,1))
ll_S	= Long(MidA(ps_cmc7,21,1))
ll_T	= Long(MidA(ps_cmc7,22,1))
ll_U	= Long(MidA(ps_cmc7,23,1))
ll_V	= Long(MidA(ps_cmc7,24,1))
ll_W	= Long(MidA(ps_cmc7,25,1))
ll_X	= Long(MidA(ps_cmc7,26,1))
ll_Y	= Long(MidA(ps_cmc7,27,1))
ll_Z	= Long(MidA(ps_cmc7,28,1))
ll_$	= Long(MidA(ps_cmc7,29,1))
ll_C3	= Long(MidA(ps_cmc7,30,1))

ll_Soma = 0

//Inicio calculo C1

ll_var3 = ll_A * 2
If ll_var3 > 10 Then
	ll_var1 = Long(MidA(String(ll_Var3),1,1))
	ll_var2 = Long(MidA(String(ll_Var3),2,1))
	ll_var3 = ll_var1 + ll_var2
Else
	If ll_var3 = 10 Then
		ll_var3 = 1
	End If
End If

ll_Soma += ll_var3

ll_var3 = ll_B * 1

ll_Soma += ll_var3

ll_var3 = ll_C * 2
If ll_var3 > 10 Then
	ll_var1 = Long(MidA(String(ll_Var3),1,1))
	ll_var2 = Long(MidA(String(ll_Var3),2,1))
	ll_var3 = ll_var1 + ll_var2
Else
	If ll_var3 = 10 Then
		ll_var3 = 1
	End If
End If

ll_Soma += ll_var3

ll_var3 = ll_D * 1

ll_Soma += ll_var3

ll_var3 = ll_E * 2
If ll_var3 > 10 Then
	ll_var1 = Long(MidA(String(ll_Var3),1,1))
	ll_var2 = Long(MidA(String(ll_Var3),2,1))
	ll_var3 = ll_var1 + ll_var2
Else
	If ll_var3 = 10 Then
		ll_var3 = 1
	End If
End If

ll_Soma += ll_var3

ll_var3 = ll_F * 1

ll_Soma += ll_var3

ll_var3 = ll_G * 2
If ll_var3 > 10 Then
	ll_var1 = Long(MidA(String(ll_Var3),1,1))
	ll_var2 = Long(MidA(String(ll_Var3),2,1))
	ll_var3 = ll_var1 + ll_var2
Else
	If ll_var3 = 10 Then
		ll_var3 = 1		
	End If	
End If

ll_Soma += ll_var3

ldc_Resultado = ll_Soma / 10

ll_Resto = Long(MidA(String(ldc_Resultado),3,1))

If ll_Resto <> 0 Then
	ll_C1_calc  = 10 - ll_Resto 
Else
	ll_C1_calc  = 0
End If

If ll_C1_calc <> ll_C1 Then
	Return False
End If

//Fim Calculo C1

//Incio Calculo C2

ll_Soma = 0

ll_var3 = ll_H * 1

ll_Soma += ll_var3

ll_var3 = ll_I * 2
If ll_var3 > 10 Then
	ll_var1 = Long(MidA(String(ll_Var3),1,1))
	ll_var2 = Long(MidA(String(ll_Var3),2,1))
	ll_var3 = ll_var1 + ll_var2
Else
	If ll_var3 = 10 Then
		ll_var3 = 1		
	End If	
End If

ll_Soma += ll_var3

ll_var3 = ll_J * 1

ll_Soma += ll_var3

ll_var3 = ll_K * 2
If ll_var3 > 10 Then
	ll_var1 = Long(MidA(String(ll_Var3),1,1))
	ll_var2 = Long(MidA(String(ll_Var3),2,1))
	ll_var3 = ll_var1 + ll_var2
Else
	If ll_var3 = 10 Then
		ll_var3 = 1		
	End If	
End If

ll_Soma += ll_var3

ll_var3 = ll_L * 1

ll_Soma += ll_var3

ll_var3 = ll_M * 2
If ll_var3 > 10 Then
	ll_var1 = Long(MidA(String(ll_Var3),1,1))
	ll_var2 = Long(MidA(String(ll_Var3),2,1))
	ll_var3 = ll_var1 + ll_var2
Else
	If ll_var3 = 10 Then
		ll_var3 = 1		
	End If	
End If

ll_Soma += ll_var3

ll_var3 = ll_N * 1

ll_Soma += ll_var3

ll_var3 = ll_O * 2
If ll_var3 > 10 Then
	ll_var1 = Long(MidA(String(ll_Var3),1,1))
	ll_var2 = Long(MidA(String(ll_Var3),2,1))
	ll_var3 = ll_var1 + ll_var2
Else
	If ll_var3 = 10 Then
		ll_var3 = 1		
	End If	
End If

ll_Soma += ll_var3

ll_var3 = ll_P * 1

ll_Soma += ll_var3

ll_var3 = ll_Q * 2
If ll_var3 > 10 Then
	ll_var1 = Long(MidA(String(ll_Var3),1,1))
	ll_var2 = Long(MidA(String(ll_Var3),2,1))
	ll_var3 = ll_var1 + ll_var2
Else
	If ll_var3 = 10 Then
		ll_var3 = 1		
	End If	
End If

ll_Soma += ll_var3

If ll_Soma = 0 Then
	Return False
End If

ldc_Resultado = ll_Soma / 10

ll_Resto = Long(MidA(String(ldc_Resultado),3,1))

If ll_Resto <> 0 Then
	ll_C2_calc  = 10 - ll_Resto 
Else
	ll_C2_calc  = 0
End If

If ll_C2_calc <> ll_C2 Then
	Return False
End If

//Fim Calculo C2

//Inicio Calculo C3

ll_Soma = 0

ll_var3 = ll_R * 1

ll_Soma += ll_var3

ll_var3 = ll_S * 2
If ll_var3 > 10 Then
	ll_var1 = Long(MidA(String(ll_Var3),1,1))
	ll_var2 = Long(MidA(String(ll_Var3),2,1))
	ll_var3 = ll_var1 + ll_var2
Else
	If ll_var3 = 10 Then
		ll_var3 = 1		
	End If	
End If

ll_Soma += ll_var3

ll_var3 = ll_T * 1

ll_Soma += ll_var3

ll_var3 = ll_U * 2
If ll_var3 > 10 Then
	ll_var1 = Long(MidA(String(ll_Var3),1,1))
	ll_var2 = Long(MidA(String(ll_Var3),2,1))
	ll_var3 = ll_var1 + ll_var2
Else
	If ll_var3 = 10 Then
		ll_var3 = 1		
	End If	
End If

ll_Soma += ll_var3

ll_var3 = ll_V * 1

ll_Soma += ll_var3

ll_var3 = ll_W * 2
If ll_var3 > 10 Then
	ll_var1 = Long(MidA(String(ll_Var3),1,1))
	ll_var2 = Long(MidA(String(ll_Var3),2,1))
	ll_var3 = ll_var1 + ll_var2
Else
	If ll_var3 = 10 Then
		ll_var3 = 1		
	End If	
End If

ll_Soma += ll_var3

ll_var3 = ll_X * 1

ll_Soma += ll_var3

ll_var3 = ll_Y * 2
If ll_var3 > 10 Then
	ll_var1 = Long(MidA(String(ll_Var3),1,1))
	ll_var2 = Long(MidA(String(ll_Var3),2,1))
	ll_var3 = ll_var1 + ll_var2
Else
	If ll_var3 = 10 Then
		ll_var3 = 1		
	End If	
End If

ll_Soma += ll_var3

ll_var3 = ll_Z * 1

ll_Soma += ll_var3

ll_var3 = ll_$ * 2
If ll_var3 > 10 Then
	ll_var1 = Long(MidA(String(ll_Var3),1,1))
	ll_var2 = Long(MidA(String(ll_Var3),2,1))
	ll_var3 = ll_var1 + ll_var2
Else
	If ll_var3 = 10 Then
		ll_var3 = 1		
	End If	
End If

ll_Soma += ll_var3

If ll_Soma = 0 Then
	Return False
End If

ldc_Resultado = ll_Soma / 10

ll_Resto = Long(MidA(String(ldc_Resultado),3,1))

If ll_Resto <> 0 Then
	ll_C3_calc  = 10 - ll_Resto 
Else
	ll_C3_calc  = 0
End If

If ll_C3 <> ll_C3_calc Then
	Return False
End If

//Fim Calculo C3

Return True
end function

public function boolean wf_preenche_campos (string ps_cmc7);String lvs_banco, lvs_agencia, lvs_conta, lvs_cheque

lvs_Banco = (MidA(String(ps_cmc7),1,3))

ivo_Banco.of_Localiza_Banco(lvs_Banco)

// Verifica se o Banco foi localizado e atualiza a DW

If ivo_Banco.Localizado Then
	dw_1.Object.cd_Banco[1] = ivo_Banco.cd_banco
	dw_1.Object.nm_Banco[1] = ivo_Banco.nm_Banco
Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Banco n$$HEX1$$e300$$ENDHEX$$o cadastrado.")
	Return False
End If

// Agencia

lvs_agencia = (MidA(String(ps_cmc7),4,4))
dw_1.Object.nr_agencia[1] = lvs_agencia

// Conta

//Na regra do CMC7 a conta n$$HEX1$$e300$$ENDHEX$$o pode ultrapassar o tamanho de 10 digitos
//Mas alguns bancos usam essa parte do cmc7 para colocar junto a razao contabil
//Assim o numero da conta correta pode variar de banco para banco.

lvs_conta = (MidA(String(ps_cmc7),20,10))

If Long(lvs_Banco) = 33  Or Long(lvs_Banco) = 341 Or Long(lvs_Banco) = 748 Then 
	lvs_conta = RightA(lvs_conta,6)
End If	
If Long(lvs_Banco) = 237 Or Long(lvs_Banco) = 85 Then 
	lvs_conta = RightA(lvs_conta,7)
End If
If Long(lvs_Banco) = 1 Then 
	lvs_conta = RightA(lvs_conta,8)
End If
If Long(lvs_Banco) = 104 Then 
	lvs_conta = RightA(lvs_conta,9)
End If

dw_1.Object.nr_conta[1] = lvs_conta

// Cheque

lvs_cheque = (MidA(String(ps_cmc7),12,6))
dw_1.Object.nr_cheque[1] = lvs_cheque

Return True
end function

public function boolean wf_verifica_cheque ();DateTime ldt_emissao
Decimal {2} ldc_valor
String	lvs_cpf_cgc, &
		lvs_banco, &
		lvs_agencia, &
		lvs_conta, &
		lvs_cheque
Long	ll_find

dw_1.AcceptText()

//lvs_cpf_cgc		= ivo_venda.is_cpf_cheque
lvs_banco		= dw_1.Object.cd_banco		[1]
lvs_agencia		= dw_1.Object.nr_agencia	[1]
lvs_conta			= dw_1.Object.nr_conta		[1]
lvs_cheque		= dw_1.Object.nr_cheque	[1]

//Verifica se cheque j$$HEX1$$e100$$ENDHEX$$ estive no sistema
Select dh_emissao, vl_cheque
Into :ldt_emissao, :ldc_valor
From cheque
Where cd_banco = :lvs_banco
  and nr_agencia = :lvs_agencia
  and nr_conta = :lvs_conta
  and nr_cheque = :lvs_cheque
Using Sqlca;

Choose Case SqlCa.SqlCode
	Case 0
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O cheque informado j$$HEX1$$e100$$ENDHEX$$ existe no Sistema." + &
						" Lan$$HEX1$$e700$$ENDHEX$$ado dia '" + String(ldt_emissao,"dd/mm/yyyy") + "' no valor de R$ '" + String(ldc_valor,"###0.00") + "'.", StopSign!, Ok!)
		dw_1.Object.nr_cmc7.protect = 0						
		Return False
	Case 100
		Return True
	Case -1
		Sqlca.Of_MsgDbError('Verifica$$HEX2$$e700e300$$ENDHEX$$o Cheque.')	
		Return False
End Choose	 
	 



end function

on w_ge031_dados_cheque.create
int iCurrent
call super::create
this.st_aviso1=create st_aviso1
this.st_aviso2=create st_aviso2
this.uo_msg_menu=create uo_msg_menu
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_aviso1
this.Control[iCurrent+2]=this.st_aviso2
this.Control[iCurrent+3]=this.uo_msg_menu
end on

on w_ge031_dados_cheque.destroy
call super::destroy
destroy(this.st_aviso1)
destroy(this.st_aviso2)
destroy(this.uo_msg_menu)
end on

event ue_postopen;call super::ue_postopen;Decimal {2} ldc_cheque

ivo_banco   = Create uo_banco

//dw_1.SetReDraw(False)
dw_1.AcceptText()

dw_1.Object.dh_emissao   [1] = gvo_parametro.of_dh_movimentacao()

Choose Case Trim(ivo_cheque.id_tipo_cheque)				
	Case "HA"		
		dw_1.Object.id_tipo_deposito	[1] = 'D'
//				dw_1.Object.vl_cheque			[1] = ivo_venda.ivo_pagamento.vl_pagamento
		dw_1.Object.vl_cheque			[1] = 0.00
		dw_1.Object.dh_vencimento	[1] = gvo_parametro.of_dh_movimentacao()				
		dw_1.Object.id_tipo_deposito.protect = 1		
		dw_1.Object.dh_vencimento.protect = 1						
					
	Case "HP"
		dw_1.Object.id_tipo_deposito	[1] = 'T'
//				dw_1.Object.vl_cheque			[1] = ivo_venda.ivo_pagamento.vl_pagamento
		dw_1.Object.vl_cheque			[1] = 0.00
		dw_1.Object.id_tipo_deposito.protect = 1
		dw_1.Object.dh_vencimento.protect = 0
End Choose				

If dw_1.Object.id_tipo_deposito[1] = 'T' Then
	st_aviso1.Visible = True
	st_aviso2.Visible = True
End If

dw_1.SetColumn('nr_cmc7')
dw_1.SetFocus()
end event

event open;call super::open;ivo_cheque    = Create uo_ge031_cheque

ivo_cheque = Message.PowerObjectParm
ivo_cheque.retorno = ''

If gvo_Aplicacao.ivo_seguranca.cd_sistema = 'CL' Then
	uo_msg_menu.visible = True
End If

end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge031_dados_cheque
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge031_dados_cheque
integer width = 1742
integer height = 780
integer taborder = 40
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge031_dados_cheque
integer width = 1673
integer height = 572
integer taborder = 50
string dataobject = "dw_ge031_dados_cheque"
end type

event dw_1::ue_key;call super::ue_key;Choose Case This.GetColumnName()		
	
	Case "nr_cmc7"
	
		If Key = KeyEnter! or Key = KeyTab! Then
			
			If not wf_valida_cmc7(This.GetText()) Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "CMC7 inv$$HEX1$$e100$$ENDHEX$$lido.")
				Return 1
			Else
				If wf_preenche_campos(This.GetText()) Then
					dw_1.SetColumn("vl_cheque")
					dw_1.SetFocus()
					dw_1.Object.nr_cmc7.Protect = 1							
				End If
			End If 
		End If		
					
End Choose
end event

event dw_1::itemfocuschanged;call super::itemfocuschanged;//Choose Case dwo.name 
//	Case "nr_cmc7"	
//		If Not wf_valida_cmc7(dwo.name.getText()) Then
//			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "CMC7 inv$$HEX1$$e100$$ENDHEX$$lido.")
////			dw_1.SetColumn("nr_cmc7")
////			dw_1.SetFocus()	
//			Return 1
////		Else
////			wf_preenche_campos(ls_cmc7) 
//		End If 
//End Choose


end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge031_dados_cheque
integer x = 1106
integer y = 800
boolean default = false
end type

event cb_ok::clicked;call super::clicked;String ls_retorno, &
		ls_cmc7		
Long ll_row

dw_1.AcceptText()

ls_cmc7 = dw_1.Object.nr_cmc7[1]

If dw_1.Object.vl_cheque[1] <= 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Valor do cheque $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido!")	
	dw_1.Event ue_Pos(1, "vl_cheque")
	Return
End If

If IsNull(dw_1.Object.dh_vencimento[1])  Or (dw_1.Object.dh_vencimento[1] < dw_1.Object.dh_emissao[1]) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe uma data de Vencimento V$$HEX1$$e100$$ENDHEX$$lida!")	
	dw_1.Event ue_Pos(1, "dh_vencimento")
	Return
End If

If Date(dw_1.Object.dh_vencimento[1]) > RelativeDate(Date(dw_1.Object.dh_emissao[1]),150) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de Vencimento excede o limite de 150 dias ap$$HEX1$$f300$$ENDHEX$$s a data de Emiss$$HEX1$$e300$$ENDHEX$$o.", Information!)
	dw_1.Event ue_Pos(1,"dh_vencimento")
	Return
End If

If (dw_1.Object.id_tipo_deposito[1] = 'T') And  (dw_1.Object.dh_vencimento[1] <= dw_1.Object.dh_emissao[1]) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Data de Vencimento deve ser maior que a Data de Emiss$$HEX1$$e300$$ENDHEX$$o!")	
	dw_1.Event ue_Pos(1, "dh_vencimento")
	Return
End If

If Long(dw_1.Object.nr_cmc7.Protect) = 0 Then
	If Not wf_valida_cmc7(ls_cmc7) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "CMC7 inv$$HEX1$$e100$$ENDHEX$$lido.")
		dw_1.SetColumn("nr_cmc7")
		dw_1.SetFocus()	
		Return
	Else
		wf_preenche_campos(ls_cmc7) 
	End If 
End If

//Verifica se cheque j$$HEX1$$e100$$ENDHEX$$ existe na Base
If Not wf_verifica_cheque() Then Return

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O valor do CHEQUE de R$ " + String(dw_1.Object.vl_cheque[1],"#####0.00") + " esta correto?" , Question!,YesNo!, 2) = 2 Then
	dw_1.Event ue_Pos(1, "vl_cheque")
	Return
End If

//w_cl002_venda.dw_cheques.Object.cd_caixa 					[ll_Row] = ivo_venda.cd_caixa
//w_cl002_venda.dw_cheques.Object.nr_matricula_operador [ll_Row] = ivo_venda.nr_matricula_operador
//w_cl002_venda.dw_cheques.Object.nr_controle_caixa 		[ll_Row] = ivo_venda.nr_controle_caixa
//w_cl002_venda.dw_cheques.Object.nr_cpf_cgc_cliente		[ll_Row] = ivo_venda.is_cpf_cheque
ivo_cheque.cd_banco					 = dw_1.Object.cd_banco 		[1]
ivo_cheque.nr_agencia				 = dw_1.Object.nr_agencia 		[1]
ivo_cheque.nr_conta					 = dw_1.Object.nr_conta 		[1]
ivo_cheque.nr_cheque				 = dw_1.Object.nr_cheque 		[1]
ivo_cheque.vl_cheque					 = dw_1.Object.vl_cheque 		[1]
ivo_cheque.dh_emissao				 = DateTime(dw_1.Object.dh_emissao  	[1])
ivo_cheque.dh_vencimento			 = DateTime(dw_1.Object.dh_vencimento	[1])
ivo_cheque.nr_cmc7					 = dw_1.Object.nr_cmc7 		[1]
ivo_cheque.id_tipo_deposito			 = dw_1.Object.id_tipo_deposito[1]

ivo_cheque.retorno = 'OK'
CloseWithReturn(Parent, ivo_cheque)

end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge031_dados_cheque
integer x = 1440
integer y = 800
end type

event cb_cancelar::clicked;//OverRide

ivo_cheque.retorno = 'CANCELAR'
CloseWithReturn(Parent, ivo_cheque)
end event

type st_aviso1 from statictext within w_ge031_dados_cheque
boolean visible = false
integer x = 206
integer y = 644
integer width = 1477
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 67108864
boolean enabled = false
string text = "ATEN$$HEX2$$c700c300$$ENDHEX$$O: Ser$$HEX1$$e100$$ENDHEX$$ incluso um lan$$HEX1$$e700$$ENDHEX$$amento de transfer$$HEX1$$ea00$$ENDHEX$$ncia"
boolean focusrectangle = false
end type

type st_aviso2 from statictext within w_ge031_dados_cheque
boolean visible = false
integer x = 206
integer y = 704
integer width = 1367
integer height = 68
boolean bringtotop = true
integer textsize = -9
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 255
long backcolor = 67108864
boolean enabled = false
string text = "para Tesouraria no valor do Cheque!"
boolean focusrectangle = false
end type

type uo_msg_menu from uo_texto_paf2 within w_ge031_dados_cheque
boolean visible = false
integer x = 151
integer y = 796
integer height = 100
integer taborder = 60
boolean bringtotop = true
boolean enabled = false
end type

on uo_msg_menu.destroy
call uo_texto_paf2::destroy
end on

