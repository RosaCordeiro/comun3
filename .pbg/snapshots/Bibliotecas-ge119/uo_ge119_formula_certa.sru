HA$PBExportHeader$uo_ge119_formula_certa.sru
forward
global type uo_ge119_formula_certa from nonvisualobject
end type
end forward

global type uo_ge119_formula_certa from nonvisualobject
end type
global uo_ge119_formula_certa uo_ge119_formula_certa

type prototypes
Function Long FC_ValorRequisicao( Long CdFil, &
											 Long NrRqu, &
										 ref Double nValorReq, &
										 ref Double nValorDsc, &
										 ref Double nValorLiq, &
										 ref Double nSinal, &
										 ref Double nSaldo ) Library 'C:\sistemas\DLL\FCerta\FCVclSystemClamed.DLL' alias for 'ValorRequisicao;Ansi'

Function Long FC_ValorOrcamento( Long CdFil, &
											 Long NrOrcamento, &
										 ref Double nValorOrc, &
										 ref Double nValorDsc, &
										 ref Double nValorLiq ) Library 'C:\sistemas\DLL\FCerta\FCVclSystemClamed.DLL' alias for 'ValorOrcamento;Ansi'

Function Long FC_ReceberSinal( Long CdFil, &
										  Long NrRqu, &
										  Double ValorSinal, &
										  Long NumeroCupom )  Library 'C:\sistemas\DLL\FCerta\FCVclSystemClamed.DLL' alias for 'ReceberSinal;Ansi'
										  
Function Long FC_ReceberSaldo( Long CdFil, &
										  Long NrRqu, &
										  Double ValorSaldo, &
										  Long NumeroCupom )  Library 'C:\sistemas\DLL\FCerta\FCVclSystemClamed.DLL' alias for 'ReceberSaldo;Ansi'
										  
Function Long FC_ReceberTotal( Long CdFil, &
										  Long NrRqu, &
										  Double ValorTotal, &
										  Long NumeroCupom )  Library 'C:\sistemas\DLL\FCerta\FCVclSystemClamed.DLL' alias for 'ReceberTotal;Ansi'

Function Long FC_EstornarRequisicao( Long CdFil, &
												  Long NrRqu )  Library 'C:\sistemas\DLL\FCerta\FCVclSystemClamed.DLL' alias for 'EstornarRequisicao;Ansi'
end prototypes

type variables
Long nr_requisicao

DECIMAL {2} vl_bruto
DECIMAL {2} vl_desconto
DECIMAL {2} vl_liquido
DECIMAL {2} vl_sinal_recebido
DECIMAL {2} vl_saldo_receber
end variables

forward prototypes
public function boolean of_inicializa ()
public function long of_verifica_retorno (long pl_retorno)
public function boolean of_pagamento_total (long pl_filial, long pl_requisicao, decimal pdc_valor, long pl_coo, ref long pl_retorno)
public function boolean of_estornar_pagamento (long pl_filial, long pl_requisicao, ref long pl_retorno)
public function boolean of_filial_em_inventario (long pl_filial_fcerta, ref boolean pb_em_inventario)
public function boolean of_valor_requisicao (long pl_filial, long pl_requisicao, ref decimal pdc_valorreq, ref decimal pdc_valordesc, ref decimal pdc_valorliq, ref decimal pdc_sinal, ref decimal pdc_saldo, ref long pl_retorno, boolean pb_modo_orcamento)
public function boolean of_modo_venda_de (long ll_filial_fcerta_de, long ll_requisicao_orcamento, ref string ps_modo_venda)
public function boolean of_localiza_valor_compra_requisicao (integer pl_filial_fcerta, long pl_requisicao, ref decimal pdc_valor_compra)
public function boolean of_localiza_valor_taxa_entrega (long pl_romaneio, ref decimal pdc_valor_taxa)
end prototypes

public function boolean of_inicializa ();Return True
end function

public function long of_verifica_retorno (long pl_retorno);Choose Case pl_retorno
	Case 0
		//Opera$$HEX2$$e700e300$$ENDHEX$$o realizada com sucesso.
	Case 1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Campos inv$$HEX1$$e100$$ENDHEX$$lidos ou n$$HEX1$$e300$$ENDHEX$$o preenchidos.",StopSign!)
	Case 2
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Requisicao / Or$$HEX1$$e700$$ENDHEX$$amento n$$HEX1$$e300$$ENDHEX$$o encontrado.",StopSign!)
	Case 3
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Receber Sinal $$HEX1$$1320$$ENDHEX$$ Pagamento total ou sinal j$$HEX1$$e100$$ENDHEX$$ efetuado.",StopSign!)
	Case 4
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Receber Sinal $$HEX1$$1320$$ENDHEX$$ Valor informado inferior ao sinal m$$HEX1$$ed00$$ENDHEX$$nimo.",StopSign!)
	Case 5
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Receber Saldo $$HEX1$$1320$$ENDHEX$$ Requisi$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o possui sinal ou pagamento total j$$HEX1$$e100$$ENDHEX$$ efetuado.",StopSign!)
	Case 6
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Receber Saldo $$HEX1$$1320$$ENDHEX$$ Valor informado diferente do saldo a receber.",StopSign!)		
	Case 7
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Receber Total $$HEX1$$1320$$ENDHEX$$ Pagamento total ou sinal j$$HEX1$$e100$$ENDHEX$$ efetuado.",StopSign!)		
	Case 8
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Receber Total $$HEX1$$1320$$ENDHEX$$ Valor informado diferente do Valor L$$HEX1$$ed00$$ENDHEX$$quido.",StopSign!)		
	Case 9
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na comunica$$HEX2$$e700e300$$ENDHEX$$o com o servidor. O valor da Requisi$$HEX2$$e700e300$$ENDHEX$$o dever$$HEX1$$e100$$ENDHEX$$ ser informado manualmente!",Exclamation!)		
	Case 10
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Servidor em manuten$$HEX2$$e700e300$$ENDHEX$$o. O valor da Requisi$$HEX2$$e700e300$$ENDHEX$$o dever$$HEX1$$e100$$ENDHEX$$ ser informado manualmente!",Exclamation!)		
	Case 11
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Estorno - Requisi$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o possui nenhum tipo de recebimento.",StopSign!)		
	Case 12
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Receber Sinal - Valor informado maior que Valor L$$HEX1$$ed00$$ENDHEX$$quido.",StopSign!)				
	Case Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Retorno n$$HEX1$$e300$$ENDHEX$$o previsto - " + String(pl_retorno) ,StopSign!)						
End Choose

Return pl_Retorno
end function

public function boolean of_pagamento_total (long pl_filial, long pl_requisicao, decimal pdc_valor, long pl_coo, ref long pl_retorno);Long ll_Retorno

gvo_Aplicacao.of_Grava_Log("uo_ge119_formula_certa - of_pagamento_total Filial: " + String(pl_filial) + " Req.: " +String(pl_requisicao) + "Nr NF.: " + String(pl_coo) + "  - Chamada da fun$$HEX2$$e700e300$$ENDHEX$$o FC_ReceberTotal da dll.")		

ll_Retorno = This.of_Verifica_Retorno(FC_ReceberTotal(pl_filial, pl_requisicao, pdc_Valor, pl_coo))

gvo_Aplicacao.of_Grava_Log("uo_ge119_formula_certa - of_pagamento_total - Saida da fun$$HEX1$$e700$$ENDHEX$$ao FC_ReceberTotal. Retorno: " + String(ll_retorno))		
	
Choose Case ll_Retorno
	Case 0 				// Comando OK						
		pl_retorno		= ll_Retorno
		Return True
	Case 9,10 				// Servidor em manuten$$HEX1$$e700$$ENDHEX$$ao	ou sem comunica$$HEX2$$e700e300$$ENDHEX$$o
		pl_retorno		= ll_Retorno		
		Return True		
	Case Else
		Return False
End Choose

Return False
end function

public function boolean of_estornar_pagamento (long pl_filial, long pl_requisicao, ref long pl_retorno);Long ll_Retorno

String ls_Modo_Venda

If Not This.of_Modo_Venda_De( pl_Filial, pl_Requisicao, ls_Modo_Venda ) Then
	Return False
End If

If ls_Modo_Venda = 'O' Then // Modo or$$HEX1$$e700$$ENDHEX$$amento, n$$HEX1$$e300$$ENDHEX$$o h$$HEX1$$e100$$ENDHEX$$ estorno a realizar
	Return True
End If

gvo_Aplicacao.of_Grava_Log("uo_ge119_formula_certa - of_estorna_pagamento Filial: " + String(pl_filial) + " Req.: " +String(pl_requisicao) + " - Chamada da fun$$HEX2$$e700e300$$ENDHEX$$o FC_EstornarRequisicao da dll."  )

ll_Retorno = This.of_Verifica_Retorno(FC_EstornarRequisicao(pl_filial, pl_requisicao))

gvo_Aplicacao.of_Grava_Log("uo_ge119_formula_certa - of_estorna_pagamento - Retornou da chamada da fun$$HEX2$$e700e300$$ENDHEX$$o FC_EstornarRequisicao da dll. Retorno: " + String(ll_Retorno))
	
Choose Case ll_Retorno
	Case 0 				// Comando OK						
		pl_retorno		= ll_Retorno
		Return True
		
	Case 11 				// Requisi$$HEX2$$e700e300$$ENDHEX$$o sem valor a ser estornado
		pl_retorno		= ll_Retorno		
		Return True
		
	Case Else
		Return False
		
End Choose

Return False
end function

public function boolean of_filial_em_inventario (long pl_filial_fcerta, ref boolean pb_em_inventario);/* Realiza consulta no cronograma de invent$$HEX1$$e100$$ENDHEX$$rios para retornar se a filial est$$HEX1$$e100$$ENDHEX$$ trabalhando com or$$HEX1$$e700$$ENDHEX$$amento ou requisi$$HEX2$$e700e300$$ENDHEX$$o
	Retorno: Fun$$HEX2$$e700e300$$ENDHEX$$o executada com sucesso
	Argumentos:
		long in pl_Filial_FCerta: C$$HEX1$$f300$$ENDHEX$$digo da filial no F$$HEX1$$f300$$ENDHEX$$rmula Certa
		boolean out pb_em_inventario: True = em invent$$HEX1$$e100$$ENDHEX$$rio, False = N$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ em invent$$HEX1$$e100$$ENDHEX$$rio
*/
Long ll_Registros

pb_Em_Inventario = False

SELECT COUNT(1)
   INTO :ll_Registros
  FROM cronograma_inventario_fcerta
WHERE cd_filial_fcerta	= :pl_Filial_Fcerta
	AND dh_inicio			<= getdate( )
	AND dh_termino		>= getdate( )
USING SqlCa;

Choose Case SqlCa.SqlCode
	Case -1
		SqlCa.of_MsgDbError( "uo_ge119_formula_certa.of_filial_em_inventario(long)" )
		Return False
		
	Case Else
		If ll_Registros > 0 Then
			pb_Em_Inventario = True
		End If
End Choose

Return True
end function

public function boolean of_valor_requisicao (long pl_filial, long pl_requisicao, ref decimal pdc_valorreq, ref decimal pdc_valordesc, ref decimal pdc_valorliq, ref decimal pdc_sinal, ref decimal pdc_saldo, ref long pl_retorno, boolean pb_modo_orcamento);Long ll_Retorno

Double 	ld_ValorReq		= 0, &
			ld_ValorDesc	= 0, &
			ld_ValorLiq		= 0, &
			ld_Sinal			= 0, &
			ld_Saldo			= 0

If pb_Modo_Orcamento Then
	gvo_Aplicacao.of_Grava_Log("uo_ge119_formula_certa - of_valor_requisicao Filial : " + String(pl_filial) + " Req.: " +String(pl_requisicao) + " - Chamada da fun$$HEX2$$e700e300$$ENDHEX$$o FC_ValorOrcamento da dll.")		
	ll_Retorno = This.of_Verifica_Retorno( FC_ValorOrcamento( pl_filial, pl_requisicao, ref ld_ValorReq, ref ld_ValorDesc, ref ld_ValorLiq ) )	
	gvo_Aplicacao.of_Grava_Log("uo_ge119_formula_certa - of_valor_requisicao - Saida da fun$$HEX2$$e700e300$$ENDHEX$$o FC_ValorOrcamento da dll. Retorno: " + String(ll_retorno))			
Else
	gvo_Aplicacao.of_Grava_Log("uo_ge119_formula_certa - of_valor_requisicao Filial : " + String(pl_filial) + " Req.: " +String(pl_requisicao) + " - Chamada da fun$$HEX2$$e700e300$$ENDHEX$$o FC_ValorRequisicao da dll.")			
	ll_Retorno = This.of_Verifica_Retorno( FC_ValorRequisicao( pl_filial, pl_requisicao, ref ld_ValorReq, ref ld_ValorDesc, ref ld_ValorLiq, ref ld_Sinal, ref ld_Saldo ) )
	gvo_Aplicacao.of_Grava_Log("uo_ge119_formula_certa - of_valor_requisicao - Saida da fun$$HEX2$$e700e300$$ENDHEX$$o FC_ValorRequisicao da dll. Retorno: " + String(ll_retorno))				
End If
	
Choose Case ll_Retorno
	Case 0 				// Comando OK						
		pdc_ValorReq 	= ld_ValorReq
		pdc_ValorDesc	= ld_ValorDesc		
		pdc_ValorLiq	= ld_ValorLiq
		pdc_Sinal		= ld_Sinal
		pdc_Saldo		= ld_Saldo
		pl_retorno		= ll_Retorno
		
		Return True
		
	Case 9,10 				// Servidor em manuten$$HEX1$$e700$$ENDHEX$$ao	ou sem comunica$$HEX2$$e700e300$$ENDHEX$$o
		pdc_ValorReq 	= 0
		pdc_ValorDesc	= 0
		pdc_ValorLiq	= 0
		pdc_Sinal		= 0
		pdc_Saldo		= 0
		pl_retorno		= ll_Retorno	
		
		Return True
		
	Case Else
		Return False
End Choose

Return False
end function

public function boolean of_modo_venda_de (long ll_filial_fcerta_de, long ll_requisicao_orcamento, ref string ps_modo_venda);// O = Or$$HEX1$$e700$$ENDHEX$$amento, R = Requisi$$HEX2$$e700e300$$ENDHEX$$o
 
 SELECT COALESCE( MAX( id_modo_venda ), 'R' )
	INTO :ps_Modo_Venda
   FROM registro_venda_manip
 WHERE cd_filial			= :gvo_Parametro.Cd_Filial
 	 AND cd_filial_fcerta	= :ll_Filial_FCerta_DE
	 AND nr_registro		= :ll_Requisicao_Orcamento
USING SqlCa;

Choose Case SqlCa.SqlCode
	Case -1
		SqlCa.of_MsgDbError( "Fun$$HEX2$$e700e300$$ENDHEX$$o: wf_modo_venda_de(long, long)" )
		Return False
End Choose

If IsNull( ps_Modo_Venda ) Then
	ps_Modo_Venda = 'R'
End If

Return True
end function

public function boolean of_localiza_valor_compra_requisicao (integer pl_filial_fcerta, long pl_requisicao, ref decimal pdc_valor_compra);/* Metodo para localizar o pre$$HEX1$$e700$$ENDHEX$$o de compra para lan$$HEX1$$e700$$ENDHEX$$amento na transfer$$HEX1$$ea00$$ENDHEX$$ncia
 * pl_Filial = Nosso C$$HEX1$$f300$$ENDHEX$$digo de Filial
 * pl_Requisicao = N$$HEX1$$fa00$$ENDHEX$$mero da Requisi$$HEX2$$e700e300$$ENDHEX$$o
*/
Boolean lb_Sucesso = True

Decimal ldc_PrCompra

dc_uo_transacao ltr_Firebird
ltr_Firebird = Create dc_uo_transacao

uo_Filial lo_Filial
lo_Filial = Create uo_Filial

dc_uo_ODBC lo_Odbc
lo_Odbc = Create dc_uo_ODBC

Try	
	gvo_Aplicacao.of_Grava_Log("uo_ge119_formula_certa - of_localiza_valor_compra_requisicao Filial: " + String(pl_filial_fcerta) + " Req.: " +String(pl_requisicao) + " - Inicio das consultas no banco Fcerta.")	
	If Not lo_Odbc.of_Grava_Regedit_Odbc_FCerta( "FCerta_GE119" ) Then
		Return False
	End If
	
	ltr_Firebird.ivs_DataBase = "FIREBIRD"
	
	lb_Sucesso = ltr_Firebird.of_Connect( "FCerta_GE119", "GE119" )
	
	If Not lb_Sucesso Then Return lb_Sucesso
	
	SELECT prcompra
	   INTO :pdc_Valor_Compra
	  FROM fc12100
	WHERE cdfil		= :pl_Filial_FCerta
		AND nrrqu	= :pl_Requisicao
	USING ltr_Firebird;
	
	Choose Case ltr_Firebird.SqlCode
		Case -1
			ltr_Firebird.of_MsgDbError( "uo_GE119_Formula_Certa.of_Localiza_Valor_Compra_Requisicao( integer, long, ref decimal )" )
			Return False
			
		Case 100
			MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Requisi$$HEX2$$e700e300$$ENDHEX$$o N$$HEX1$$ba00$$ENDHEX$$ " + String( pl_Requisicao ) + " n$$HEX1$$e300$$ENDHEX$$o localizada no F$$HEX1$$f300$$ENDHEX$$rmula Certa para a filial " + String( pl_Filial_FCerta ) + ".", StopSign! )
			pdc_Valor_Compra = 0
			Return False
			
	End Choose

Catch( Exception ex )
	MessageBox( "Exception", ex.GetMessage( ), StopSign! )
	Return False
	
Finally	
	If ltr_Firebird.of_IsConnected( ) Then ltr_Firebird.of_Disconnect( )
	lo_Odbc.of_Deleta_Regedit_Odbc( "FCerta_GE119" )
	gvo_Aplicacao.of_Grava_Log("uo_ge119_formula_certa - of_localiza_valor_compra_requisicao - Saida da fun$$HEX2$$e700e300$$ENDHEX$$o.")		
	
	Destroy ltr_Firebird
	Destroy lo_Odbc
	
End Try
end function

public function boolean of_localiza_valor_taxa_entrega (long pl_romaneio, ref decimal pdc_valor_taxa);/* Metodo para localizar o valor de taxa de entrega no FCerta
 * pl_Filial = Nosso C$$HEX1$$f300$$ENDHEX$$digo de Filial
 * pl_Requisicao = N$$HEX1$$fa00$$ENDHEX$$mero do Romaneio
*/
Boolean lb_Sucesso = True

Date ldt_Entrega

Decimal ldc_PrCompra

Long ll_filial_romaneio

dc_uo_transacao ltr_Firebird
ltr_Firebird = Create dc_uo_transacao

uo_Filial lo_Filial
lo_Filial = Create uo_Filial

dc_uo_ODBC lo_Odbc
lo_Odbc = Create dc_uo_ODBC

Try
	gvo_Aplicacao.of_Grava_Log("uo_ge119_formula_certa - of_localiza_valor_taxa_entrega Romaneio: " + String(pl_romaneio) + " - Inicio das consultas no banco Fcerta.")		
	ldt_Entrega = RelativeDate( Date( gvo_Parametro.Dh_Movimentacao ), -5 )
	
	lo_filial.of_localiza_filial(String(gvo_parametro.cd_filial))
	lo_filial.of_filial_fcerta()	
	If IsNull(lo_filial.Cd_Filial_FCerta) Or lo_filial.Cd_Filial_FCerta <= 0 Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi encontrado c$$HEX1$$f300$$ENDHEX$$digo de Filial FCerta.", StopSign! )
		Return False
	End If
	ll_filial_romaneio = lo_filial.cd_filial_entrega_fcerta
	
	If Not lo_Odbc.of_Grava_Regedit_Odbc_FCerta( "FCerta_GE119" ) Then
		Return False
	End If
	
	ltr_Firebird.ivs_DataBase = "FIREBIRD"
	
	lb_Sucesso = ltr_Firebird.of_Connect( "FCerta_GE119", "GE119" )
	
	If Not lb_Sucesso Then Return lb_Sucesso

	SELECT vrtxa
	   INTO :pdc_Valor_Taxa
	  FROM fc12400
	WHERE cdfilentgdes	= :ll_filial_romaneio
		AND nrentg			= :pl_Romaneio
		AND dtentg			>= :ldt_Entrega
	USING ltr_Firebird;
	
	Choose Case ltr_Firebird.SqlCode
		Case -1
			ltr_Firebird.of_MsgDbError( "uo_GE119_Formula_Certa.of_Localiza_Valo_Taxa_Entrega( long, ref decimal )" )
			Return False
			
		Case 100
			MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Romaneio N$$HEX1$$ba00$$ENDHEX$$ " + String( pl_Romaneio ) + " n$$HEX1$$e300$$ENDHEX$$o localizada no F$$HEX1$$f300$$ENDHEX$$rmula Certa para a filial " + String( ll_filial_romaneio ) + ".", StopSign! )
			pdc_Valor_Taxa = 0
			Return False
			
		Case 0
			If pdc_valor_taxa <= 0 Then
				MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Romaneio N$$HEX1$$ba00$$ENDHEX$$ " + String( pl_Romaneio ) + " da filial " + String( ll_filial_romaneio ) + " est$$HEX1$$e100$$ENDHEX$$ sem valor de Taxa de Entrega.", StopSign! )
				Return False			
			End If
			
	End Choose

Catch( Exception ex )
	MessageBox( "Exception", ex.GetMessage( ), StopSign! )
	Return False
	
Finally	
	If ltr_Firebird.of_IsConnected( ) Then ltr_Firebird.of_Disconnect( )
	lo_Odbc.of_Deleta_Regedit_Odbc( "FCerta_GE119" )
	gvo_Aplicacao.of_Grava_Log("uo_ge119_formula_certa - of_localiza_valor_taxa_entrega - Saida da fun$$HEX2$$e700e300$$ENDHEX$$o.")			
	
	Destroy ltr_Firebird
	Destroy lo_Odbc
	Destroy lo_Filial
End Try
end function

on uo_ge119_formula_certa.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge119_formula_certa.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ChangeDirectory( 'C:\sistemas\dll\fcerta' )
end event

