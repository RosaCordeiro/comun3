HA$PBExportHeader$w_ge119_requisicao_de_para.srw
forward
global type w_ge119_requisicao_de_para from dc_w_response_ok_cancela
end type
end forward

global type w_ge119_requisicao_de_para from dc_w_response_ok_cancela
integer width = 1467
integer height = 704
string title = "GE119 - De / Para - Ajuste Financeiro FCerta"
end type
global w_ge119_requisicao_de_para w_ge119_requisicao_de_para

type variables
uo_ge119_formula_certa ivo_FCerta

Decimal {2} idc_ValorReq, &
				idc_ValorDesc, &
				idc_ValorLiq, &
				idc_Sinal, &
				idc_Saldo
				
Long ivl_retorno_FC

Boolean ib_key

Boolean ib_Modo_Orcamento_De = False
end variables

forward prototypes
public function boolean wf_verifica_requisicao (long pl_registro)
public function boolean wf_troca_requisicao (long pl_filial_de, long pl_registro_de, long pl_filial_para, long pl_registro_para, decimal pdc_registro, long pl_coo)
public function boolean wf_atualiza_venda_manip (long pl_nf, string ps_especie, string ps_serie, long pl_registro_de, long pl_registro_para, decimal pdc_valor, long pl_filial_fcerta, long pl_sequencial)
end prototypes

public function boolean wf_verifica_requisicao (long pl_registro);Long ll_Filial_FCerta
Long ll_Filial_Para
Long ll_Requisicao_De

String ls_Modo_Venda_De

dw_1.AcceptText()

ll_Filial_Para		= dw_1.Object.cd_Filial_Para	[1]
ll_Requisicao_De	= dw_1.Object.nr_Registro		[1]

If IsNull( ll_Filial_Para ) OR ll_Filial_Para = 0 Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe o c$$HEX1$$f300$$ENDHEX$$digo da Filial no F$$HEX1$$f300$$ENDHEX$$rmula Certa.", Exclamation!)
	dw_1.Event ue_Pos( 1, "cd_filial_para" )
	Return False
Else
	ll_Filial_FCerta = dw_1.Object.cd_filial_para [1]
End If

If Not ivo_FCerta.of_Modo_Venda_De( ll_Filial_FCerta, ll_Requisicao_De, Ref ls_Modo_Venda_De ) Then
	Return False
End If

If ls_Modo_Venda_De = 'O' Then
	This.ib_Modo_Orcamento_De = True
	pl_Registro = ll_Requisicao_De
End If

If ivo_FCerta.of_Valor_Requisicao(ll_Filial_FCerta, &
											pl_Registro, &
											Ref idc_ValorReq, &
											Ref idc_ValorDesc, &
											Ref idc_ValorLiq, &
											Ref idc_Sinal, &
											Ref idc_Saldo, &
											Ref ivl_retorno_FC, &
											This.ib_Modo_Orcamento_De ) Then
	If idc_ValorDesc > 0 Then
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Requisi$$HEX2$$e700e300$$ENDHEX$$o com Desconto no F$$HEX1$$f300$$ENDHEX$$rmula Certa. Tire o desconto no F$$HEX1$$f300$$ENDHEX$$rmula Certa para usar a Requisi$$HEX2$$e700e300$$ENDHEX$$o", Exclamation!)
		Return False
	End If
	Return True
End If

Return False
end function

public function boolean wf_troca_requisicao (long pl_filial_de, long pl_registro_de, long pl_filial_para, long pl_registro_para, decimal pdc_registro, long pl_coo);Boolean lb_Sucesso = True

Decimal ldc_ValorReq
Decimal ldc_ValorDesc
Decimal ldc_ValorLiq
Decimal ldc_Sinal
Decimal ldc_Saldo

Long ll_Retorno

If Not IsNull(pl_Filial_de) And pl_filial_de > 0 Then
	If Not ib_Modo_Orcamento_De Then
		If ivo_FCerta.of_Estornar_Pagamento( pl_Filial_DE, pl_Registro_DE, Ref ll_Retorno ) Then

			If ll_Retorno = 0 Then
				gvo_Aplicacao.of_Grava_Log( "REQUISI$$HEX2$$c700c300$$ENDHEX$$O DE PARA - Estorno Requis$$HEX2$$e700e300$$ENDHEX$$o FCerta com Sucesso! " + &
													" Requisicao [" + String(pl_registro_de) + "]" + & 
													", Filia_FCerta [" + String(pl_filial_de) + "]")
			Else
				gvo_Aplicacao.of_Grava_Log( "REQUISI$$HEX2$$c700c300$$ENDHEX$$O DE PARA - Erro no Estorno Requis$$HEX2$$e700e300$$ENDHEX$$o FCerta!" + &
													" Requisicao [" + String(pl_registro_de) + "]" + & 
													", Filia_FCerta [" + String(pl_filial_de) + "]" + &
													", Retorno [" + String(ll_retorno) + "]")
				Return False
			End If
		Else
			gvo_Aplicacao.of_Grava_Log( "REQUISI$$HEX2$$c700c300$$ENDHEX$$O DE PARA - Erro no Estorno Requis$$HEX2$$e700e300$$ENDHEX$$o FCerta!" + &
													" Requisicao [" + String(pl_registro_de) + "]" + & 
													", Filia_FCerta [" + String(pl_filial_de) + "]" + &
													", Retorno [" + String(ll_retorno) + "]")
			Return False
		End If
	End If
Else
	Return False
End If

If Not IsNull( pl_Filial_Para ) And pl_Filial_Para > 0 Then	
	// Em caso de or$$HEX1$$e700$$ENDHEX$$amento, podem haver casos de valor de requisi$$HEX2$$e700e300$$ENDHEX$$o diferente de valor de or$$HEX1$$e700$$ENDHEX$$amento, ent$$HEX1$$e300$$ENDHEX$$o consultamos
	// novamente o valor da requisi$$HEX2$$e700e300$$ENDHEX$$o para utilizar este valor no de->para
	
	If ivo_FCerta.of_Valor_Requisicao(pl_Filial_Para, &
												pl_Registro_Para, &
												Ref ldc_ValorReq, &
												Ref ldc_ValorDesc, &
												Ref ldc_ValorLiq, &
												Ref ldc_Sinal, &
												Ref ldc_Saldo, &
												Ref ll_Retorno, &
												False ) Then
	
		If ivo_FCerta.of_pagamento_total(pl_filial_para, pl_registro_para, ldc_ValorReq, pl_coo, Ref ll_retorno) Then
			If ll_retorno = 0 Then
				gvo_Aplicacao.of_Grava_Log( "REQUISI$$HEX2$$c700c300$$ENDHEX$$O DE PARA - Pagamento Requis$$HEX2$$e700e300$$ENDHEX$$o FCerta com Sucesso! " + &
													" Requisicao [" + String(pl_registro_para) + "]" + & 
													", Filia_FCerta [" + String(pl_filial_para) + "]")
			Else
				gvo_Aplicacao.of_Grava_Log( "REQUISI$$HEX2$$c700c300$$ENDHEX$$O DE PARA - Erro no Pagamento Requis$$HEX2$$e700e300$$ENDHEX$$o FCerta!" + &
													" Requisicao [" + String(pl_registro_para) + "]" + & 
													", Filia_FCerta [" + String(pl_filial_para) + "]" + &
													", Retorno [" + String(ll_retorno) + "]")
				Return False
			End If
		Else
			gvo_Aplicacao.of_Grava_Log( "REQUISI$$HEX2$$c700c300$$ENDHEX$$O DE PARA - Erro no Pagamento Requis$$HEX2$$e700e300$$ENDHEX$$o FCerta!" + &
													" Requisicao [" + String(pl_registro_para) + "]" + & 
													", Filia_FCerta [" + String(pl_filial_para) + "]" + &
													", Retorno [" + String(ll_retorno) + "]")
			Return False
		End If
	Else
		gvo_Aplicacao.of_Grava_Log( "REQUISI$$HEX2$$c700c300$$ENDHEX$$O DE PARA - Erro na consulta do valor da requisi$$HEX2$$e700e300$$ENDHEX$$o PARA FCerta!" + &
													" Requisicao [" + String(pl_registro_para) + "]" + & 
													", Filia_FCerta [" + String(pl_filial_para) + "]" + &
													", Retorno [" + String(ll_retorno) + "]")
	End If
Else
	Return False
End If

Return True
end function

public function boolean wf_atualiza_venda_manip (long pl_nf, string ps_especie, string ps_serie, long pl_registro_de, long pl_registro_para, decimal pdc_valor, long pl_filial_fcerta, long pl_sequencial);Boolean lb_sucesso = False

Long ll_filial
Long ll_operacao
Long ll_produto
Long ll_qtde
String ls_dados

Decimal {2} ldc_preco_unitario
Decimal {2} ldc_pc_desconto

ll_filial = gvo_parametro.cd_filial

SELECT cd_natureza_operacao, cd_produto, qt_registro , de_dados_adicionais, vl_preco_unitario, pc_desconto
   INTO :ll_operacao, :ll_produto, :ll_qtde, :ls_dados, :ldc_preco_unitario, :ldc_pc_desconto
  FROM registro_venda_manip
WHERE cd_filial			= :ll_filial
	AND nr_nf			= :pl_nf
	AND de_especie	= :ps_especie
	AND de_serie   		= :ps_serie
	AND nr_registro	= :pl_registro_de
 Using Sqlca;  
 
Choose Case Sqlca.SqlCode
	Case 0		
		Delete From registro_venda_manip
		 Where cd_filial						= :ll_filial
			and nr_nf						= :pl_nf
			and de_especie					= :ps_especie
			and de_serie					= :ps_serie
			and cd_natureza_operacao	= :ll_operacao
			and cd_produto					= :ll_produto
			and nr_registro					= :pl_registro_de
		Using Sqlca;		
	
		If Sqlca.Sqlcode <> 0 Then
			Sqlca.of_MsgDBError("Exclus$$HEX1$$e300$$ENDHEX$$o Registro Manip. Original.")
		Else		
			Insert Into registro_venda_manip  
					( cd_filial,   
					  nr_nf,
					  de_especie,
					  de_serie,
					  nr_sequencial,
					  cd_produto,
					  nr_registro,
					  cd_natureza_operacao,
					  qt_registro,
					  vl_registro,
					  cd_filial_fcerta,
					  id_modo_venda,
					  de_dados_adicionais, 
					  vl_preco_unitario, 
					  pc_desconto)   
			Values (:ll_filial,   
					  :pl_nf,
					  :ps_especie,
					  :ps_serie,
					  :pl_Sequencial,
					  :ll_produto,
					  :pl_registro_para,
					  :ll_operacao,
					  :ll_qtde,
					  :pdc_valor,
					  :pl_filial_fcerta,
					  'R',
					  :ls_dados, 
					  :ldc_preco_unitario, 
					  :ldc_pc_desconto)
			Using Sqlca;
			
			If Sqlca.Sqlcode <> 0 Then
				Sqlca.of_RollBack()
				Sqlca.of_MsgDBError("Exclus$$HEX1$$e300$$ENDHEX$$o Registro Manip. Para.")
			Else
				lb_sucesso = True
			End If					
		End If
		
	Case 100		
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Requisi$$HEX2$$e700e300$$ENDHEX$$o Original n$$HEX1$$e300$$ENDHEX$$o encontrada!",StopSign!)
		
	Case -1			
		Sqlca.of_MsgDbError('Localiza$$HEX2$$e700e300$$ENDHEX$$o Registro Venda Manip.')		
		
End Choose

If lb_sucesso Then
	Sqlca.Of_Commit()	
	Return True
Else
	Return False	
End If
end function

on w_ge119_requisicao_de_para.create
call super::create
end on

on w_ge119_requisicao_de_para.destroy
call super::destroy
end on

event open;call super::open;ivo_FCerta = Create uo_ge119_formula_certa

//dw_1.SetFocus()


end event

event close;call super::close;If IsValid(ivo_FCerta) Then Destroy(ivo_FCerta)
end event

event ue_postopen;call super::ue_postopen;String ls_parametro

ls_parametro = Message.StringParm

dw_1.Object.cd_filial_fcerta	[1]	= Long(Trim(gf_captura_valor(ls_parametro, '|', 1, false)))
dw_1.Object.nr_registro		[1]	= Long(Trim(gf_captura_valor(ls_parametro, '|', 2, false)))
dw_1.Object.vl_registro		[1]	= Dec(Trim(gf_captura_valor(ls_parametro, '|', 3, false)))
dw_1.Object.nr_coo			[1]	= Long(Trim(gf_captura_valor(ls_parametro, '|', 4, false)))
dw_1.Object.nr_nf				[1]	= Long(Trim(gf_captura_valor(ls_parametro, '|', 5, false)))
dw_1.Object.de_especie		[1]	= Trim(gf_captura_valor(ls_parametro, '|', 6, false))
dw_1.Object.de_serie			[1]	= Trim(gf_captura_valor(ls_parametro, '|', 7, false))
dw_1.Object.nr_sequencial	[1]	= Long(gf_captura_valor(ls_parametro, '|', 8, false))

This.wf_centraliza_janela()



end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge119_requisicao_de_para
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge119_requisicao_de_para
integer width = 1399
integer height = 468
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge119_requisicao_de_para
integer width = 1335
integer height = 364
string dataobject = "dw_ge119_requisicao_de_para"
end type

event dw_1::editchanged;call super::editchanged;Choose Case This.GetColumnName() 		
	Case "cd_filial_para"
		This.object.nr_registro_para [1] = 0
		This.object.vl_registro_para [1] = 0		
		
End Choose

end event

event dw_1::itemchanged;call super::itemchanged;//Choose Case This.GetColumnName() 
//	Case "nr_registro_para"
//		If This.GetText() <> "" And Long(This.GetText()) > 0 Then
//			If ib_key = False Then
//				If wf_verifica_requisicao(Long(This.GetText())) Then
//					If ivl_retorno_FC = 0 Then 
//						//coloca o valor no campo
//						If idc_ValorLiq > idc_Sinal Then
//							dw_1.Object.vl_registro_para [1] = idc_ValorLiq
//							cb_OK.SetFocus()
//						Else
//							This.Event ue_Pos(1,"nr_registro_para")
//							MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Requisi$$HEX2$$e700e300$$ENDHEX$$o sem Saldo $$HEX1$$e000$$ENDHEX$$ Receber.",StopSign!)
//							Return 1
//						End If
//					End If
////					If ivl_retorno_FC = 9 or ivl_retorno_FC = 10 Then //Servidor fora do ar ou em manuten$$HEX2$$e700e300$$ENDHEX$$o.
////						dw_1.Object.vl_registro.protect = 0												
////						This.SetFocus()
////						This.SetColumn("vl_registro_para")						
////					End If									
//				Else
//					Return 1
//				End If
//			End If
//		Else
//			Return 1
//		End If				
//
//End Choose
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge119_requisicao_de_para
integer x = 763
integer y = 500
end type

event cb_ok::clicked;call super::clicked;dw_1.AcceptText()

If IsNull(dw_1.Object.cd_filial_para [1]) OR dw_1.Object.cd_filial_para [1] = 0 Then
	Messagebox( "Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe o c$$HEX1$$f300$$ENDHEX$$digo da Filial no F$$HEX1$$f300$$ENDHEX$$rmula Certa.", Exclamation! )
	dw_1.Event ue_Pos( 1, "cd_filial_para" )
	Return
End If

If IsNull(dw_1.Object.nr_registro_para [1]) OR dw_1.Object.nr_registro_para [1] = 0 Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Digite o n$$HEX1$$fa00$$ENDHEX$$mero do registro.", Exclamation!)
	dw_1.Event ue_Pos( 1 , "nr_registro_para" )
	Return
End If

If (dw_1.Object.cd_filial_para [1] = dw_1.Object.cd_filial_fcerta [1]) And &
   (dw_1.Object.nr_registro_para [1] = dw_1.Object.nr_registro [1])  Then
	Messagebox( "Aten$$HEX2$$e700e300$$ENDHEX$$o","Registros DE e PARA s$$HEX1$$e300$$ENDHEX$$o iguais.", Exclamation! )
	dw_1.Event ue_Pos( 1 , "nr_registro_para" )
	Return
End If

If wf_verifica_requisicao(dw_1.Object.nr_registro_para[1]) Then
	If ivl_retorno_FC = 0 Then 
		If idc_ValorLiq > idc_Sinal Then
			dw_1.Object.vl_registro_para [1] = idc_ValorLiq
		Else
			dw_1.Event ue_Pos( 1 , "nr_registro_para" )
			MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o","Requisi$$HEX2$$e700e300$$ENDHEX$$o sem Saldo $$HEX1$$e000$$ENDHEX$$ Receber.", StopSign! )
			Return
		End If
		
		If idc_ValorLiq < dw_1.Object.vl_registro[1] Then
			dw_1.Event ue_Pos( 1 , "nr_registro_para" )
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Saldo da Requisi$$HEX2$$e700e300$$ENDHEX$$o informada [" + String(idc_ValorLiq, "###0.00") + "], menor que o valor da requisi$$HEX2$$e700e300$$ENDHEX$$o atual.",StopSign!)
			Return			
		End If
	Else
		dw_1.Event ue_Pos( 1 , "nr_registro_para" )
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Problemas para recuperar informa$$HEX2$$e700f500$$ENDHEX$$es da Requisi$$HEX2$$e700e300$$ENDHEX$$o Para.",StopSign!)
		Return	
	End If
End If

If IsNull(dw_1.Object.vl_registro_para [1]) OR dw_1.Object.vl_registro_para [1] = 0 Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Valor Requisi$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o informada! Informe a requisi$$HEX2$$e700e300$$ENDHEX$$o novamente.", Exclamation!)
	dw_1.SetFocus()
	dw_1.SelectText(1,10)
	Return
End If

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Confirma a troca da requisi$$HEX2$$e700e300$$ENDHEX$$o: ["+ String(dw_1.Object.nr_registro[1]) + "] Filial FCerta: [" + String(dw_1.Object.cd_filial_fcerta[1]) + "]" + &
								 " Para a requisi$$HEX2$$e700e300$$ENDHEX$$o: ["+ String(dw_1.Object.nr_registro_para[1]) + "] Filial FCerta: [" + String(dw_1.Object.cd_filial_para[1]) + "] ?",Question!,YesNo!,1) = 2 Then 
	Return
Else
	If wf_troca_requisicao(dw_1.Object.cd_filial_fcerta[1], dw_1.Object.nr_registro[1], dw_1.Object.cd_filial_para[1], dw_1.Object.nr_registro_para [1], &
								  dw_1.Object.vl_registro_para[1], dw_1.Object.nr_coo[1]) Then	
		If wf_atualiza_venda_manip(dw_1.Object.nr_nf[1], dw_1.Object.de_especie[1], dw_1.Object.de_serie[1], dw_1.Object.nr_registro[1], &
											dw_1.Object.nr_registro_para[1], dw_1.Object.vl_registro[1], dw_1.Object.cd_filial_para[1], dw_1.Object.nr_sequencial[1]) Then		
			Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Troca de Requisi$$HEX2$$e700f500$$ENDHEX$$es conclu$$HEX1$$ed00$$ENDHEX$$da com sucesso!", Information!)
			CloseWithReturn(Parent, 'OK')
		Else
			Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Troca de Requisi$$HEX2$$e700f500$$ENDHEX$$es N$$HEX1$$c300$$ENDHEX$$O processada!", StopSign!)
			CloseWithReturn(Parent, 'CANCELA')		
		End If
	Else
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Troca de Requisi$$HEX2$$e700f500$$ENDHEX$$es N$$HEX1$$c300$$ENDHEX$$O processada!", StopSign!)
		CloseWithReturn(Parent, 'CANCELA')
	End If
End If
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge119_requisicao_de_para
integer x = 1097
integer y = 500
end type

