HA$PBExportHeader$uo_funcional_card.sru
forward
global type uo_funcional_card from nonvisualobject
end type
end forward

global type uo_funcional_card from nonvisualobject
end type
global uo_funcional_card uo_funcional_card

type variables
constant long cd_convenio = 52349
constant long cd_condicao_convenio = 161

// Numero m$$HEX1$$e100$$ENDHEX$$ximo de produtos  para venda funcional
Integer ivi_nr_itens_venda = 10,&
            cd_tipo_comissao

Boolean ivb_Compra 
Boolean ivb_PreAutorizacao

//TEF
String nr_Autorizacao
String cd_Operadora
String de_Operadora
String cd_Rede
String de_Rede
String Retorno
String de_Complemento
String de_Dados_Complementares

Long ivl_Produto
Long ivl_Enviados
//

String cd_conveniado,&
          nm_portador,&
          nm_conveniado,&
          nr_terminal,& 
          nr_cartao,&
          nr_nsu,&
		 nr_nsu_host,&
          hr_emissao,&
          de_transacao,&
          nr_matricula_vendedor,&
          de_barras[],&
          id_cliente_caixa = 'N',&
		 id_status,&
		 de_login_ws,&
		 de_senha_ws,&
		 cd_cliente_pbm

Date  dt_emissao

Decimal {2} vl_total
Decimal {2} vl_saldo
Decimal {2} vl_cartao
Decimal {2} vl_avista
Decimal {2} vl_desconto
Decimal {2} vl_desconto_funcional
Decimal {2} vl_produto[]
Decimal {2} vl_PMC[]
Decimal {2} vl_total_bruto
Decimal {2} vl_base_calculo
Decimal {2} vl_subsidio
Decimal {2} vl_reembolso

string ivs_path_log
String ivs_Xml_Produto_WS

Long nr_nc, &
         nr_ecf,&
         nr_doc, &
         qt_produto[],&
         nr_seq_cesta_atendimento

dc_uo_api ivo_api

dc_uo_ds_base ds_autorizacao
end variables

forward prototypes
public function boolean of_grava_arquivo (integer ai_arquivo, string as_linha)
public function decimal of_decimal (string as_valor, integer ai_decimal)
public function string of_decimal (decimal adc_valor, integer ai_tamanho, integer ai_decimal)
public function boolean of_produto_codigo_barras (string as_codigo_barras, ref long al_produto)
public function boolean of_confirmacao_venda_ok ()
public subroutine of_imprime_autorizacao (string as_autorizacao)
public function boolean of_log ()
public function boolean of_valida_produto ()
public subroutine of_carrega_produtos (ref integer ai_index, ref integer ai_item, string as_transacao, integer ai_barras, integer ai_quantidade, integer ai_valor, integer ai_status, integer ai_pmc)
public function boolean of_verifica_autorizacao (string as_autorizacao)
public function boolean of_autorizacao (long pl_autorizacao)
public function boolean of_carrega_autorizacao ()
public function boolean of_ini_correto ()
public subroutine of_atualiza_cliente_funcional_card ()
public function boolean of_grava_venda_pbm (long al_filial, long al_notafiscal, string as_especie, string as_serie, long al_ecf, long al_cupom, datetime adh_movimento, decimal adc_valor_venda)
public subroutine of_inicializa ()
public function boolean of_gera_xml_produto_ws (datawindow pdw_itens)
public function boolean of_busca_conveniado ()
public function boolean of_inicia_tabela_produtos ()
public function string of_mensagem_produto (long al_tipo)
public function boolean of_retorno_autorizacao_desconto (string ps_desconto)
public function boolean of_retorno_autorizacao_reembolso (string ps_reembolso)
public function boolean of_retorno_autorizacao_total (string ps_total)
public function boolean of_retorno_autorizacao_total_avista (string ps_avista)
public function boolean of_retorno_autorizacao_total_cartao (string ps_cartao)
public function boolean of_retorno_produto (string ps_codigo_barras)
public function boolean of_retorno_produto_desconto (string ps_desconto)
public function boolean of_retorno_produto_preco_bruto (string ps_preco)
public function boolean of_retorno_produto_preco_liquido (string ps_preco)
public function boolean of_retorno_produto_preco_pbm (string ps_preco)
public function boolean of_retorno_produto_preco_praticado (string ps_preco)
public function boolean of_retorno_produto_quantidade (long pl_autorizada)
public function boolean of_retorno_produto_status (string ps_status)
public function boolean of_retorno_produto_valor_subsidio (string ps_preco)
public function boolean of_verifica_autorizacao ()
public function boolean of_grava_venda_pbm_produto (long al_filial, long al_nota_fiscal, string as_especie, string as_serie, long al_convenio)
end prototypes

public function boolean of_grava_arquivo (integer ai_arquivo, string as_linha);Integer lvi_Write

lvi_Write = FileWrite(ai_Arquivo, as_Linha)

If lvi_Write = LenA(as_Linha) Then
	Return True
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do arquivo.", StopSign!)
	Return False
End If
end function

public function decimal of_decimal (string as_valor, integer ai_decimal);Decimal lvdc_Valor

String lvs_Temp

lvs_Temp = LeftA(as_Valor, LenA(as_Valor) - ai_Decimal) + "," + RightA(as_Valor, ai_Decimal)

lvdc_Valor = Dec(lvs_Temp)

Return lvdc_Valor
end function

public function string of_decimal (decimal adc_valor, integer ai_tamanho, integer ai_decimal);String lvs_Valor, &
       lvs_Zeros, &
		 lvs_Decimal

Integer lvi_Contador

If IsNull(adc_Valor) Then adc_Valor = 0

For lvi_Contador = 1 To ai_Decimal
	lvs_Decimal += "0"
Next

lvs_Valor = String(adc_Valor, "0." + lvs_Decimal)

lvs_Valor = LeftA(lvs_Valor, LenA(lvs_Valor) - ai_Decimal - 1) + RightA(lvs_Valor, ai_Decimal)

For lvi_Contador = 1 To ai_Tamanho - LenA(lvs_Valor)
	lvs_Zeros += "0"
Next

lvs_Valor = lvs_Zeros + lvs_Valor

Return lvs_Valor
end function

public function boolean of_produto_codigo_barras (string as_codigo_barras, ref long al_produto);Select cd_produto Into :al_Produto
From produto_geral
Where de_codigo_barras = :as_Codigo_Barras
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0

		Return True
	Case 100
		Return False
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do C$$HEX1$$f300$$ENDHEX$$digo Interno do Produto")
		Return False
End Choose
end function

public function boolean of_confirmacao_venda_ok ();Integer lvi_Arquivo, &
		  lvi_Ind

String  lvs_Arquivo, &
        lvs_Registro, &
		  lvs_Sequencial, &
		  lvs_Funcao, &
		  lvs_Status, &
		  lvs_Mensagem, &
	 	  lvs_Transacao, &
	 	  lvs_NSU, &
		  lvs_Linha_Recibo, &
		  lvs_Vazio[]
		 		  
Long    lvl_Conta		 

Boolean lvb_Retorno = False
		 
//lvs_Arquivo = This.ivs_Path_REC + This.VENDA
//
//If Not This.of_Abre_Arquivo(lvs_Arquivo, lvi_Arquivo, "L") Then Return False
//
//FileRead(lvi_Arquivo, lvs_Registro)
//
//lvs_Sequencial = Mid(lvs_Registro, 1, 4)
//lvs_Funcao     = Mid(lvs_Registro, 5, 2)
//lvs_Status     = Mid(lvs_Registro, 7, 2)
//lvs_Mensagem   = Mid(lvs_Registro, 9, 40)
//lvs_Transacao  = Mid(lvs_Registro, 49, 7)
//lvs_NSU        = Mid(lvs_Registro, 56, 12)
//
//If lvs_Sequencial <> "0002" Then
//	
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Sequencial recebido no arquivo de resposta inv$$HEX1$$e100$$ENDHEX$$lido.", StopSign!)
//	
//Else
//	 
//	If lvs_Funcao <> "03" Then
//		
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Fun$$HEX2$$e700e300$$ENDHEX$$o recebida no arquivo de resposta inv$$HEX1$$e100$$ENDHEX$$lida.", StopSign!)
//
//	Else
//	
//		If lvs_Status = "ER" Then
//			
//			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Arquivo de resposta retornou um erro.~r~r" + lvs_Mensagem, StopSign!)
//			
//		ElseIf lvs_Status = "OK" Then
//			
//			FileRead(lvi_Arquivo, lvs_Registro)
//			
//			This.lvs_Recibo = lvs_Vazio
//			
//			lvs_Linha_Recibo = ''
//			
//			For lvl_conta = 1 To Len(Trim(lvs_Registro))
//				
//				If Mid(lvs_Registro,lvl_conta,1) <> '@' Then
//					
//					lvs_Linha_Recibo = lvs_Linha_Recibo + Mid(lvs_Registro,lvl_conta,1)
//					
//				Else
//					
//					lvi_Ind ++
//					
//					This.lvs_Recibo[lvi_Ind] = lvs_Linha_Recibo
//					
//					lvs_Linha_Recibo = ''
//								
//				End If
//		
//			Next
//			
//			This.lvs_Recibo[lvi_Ind] = lvs_Linha_Recibo
//			This.nr_nsu              = lvs_nsu
//			
//			lvb_Retorno = True
//			
//		Else
//			
//			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Retorno no arquivo de resposta diferente do esperado. " + lvs_Status + "~r~r" + lvs_Mensagem, StopSign!)
//			
//		End If
//		
//	End If
//	
//End If	
////
//FileClose(lvi_Arquivo)
////
//ivo_api.of_delete_file(lvs_arquivo)
//
Return lvb_Retorno

end function

public subroutine of_imprime_autorizacao (string as_autorizacao);dc_uo_ds_Base lvds
lvds = Create dc_uo_ds_Base
If Not lvds.of_ChangeDataObject("dw_impressao_autorizacao") Then Return

SetPointer(HourGlass!)

If lvds.Retrieve(as_Autorizacao) > 0 Then
	Open(dc_w_Prepara_Impressora)
	lvds.Print()
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Autoriza$$HEX2$$e700e300$$ENDHEX$$o '" + as_Autorizacao + "' n$$HEX1$$e300$$ENDHEX$$o localizada para impress$$HEX1$$e300$$ENDHEX$$o.", StopSign!)
End If

Destroy(lvds)
SetPointer(Arrow!)
end subroutine

public function boolean of_log ();String   lvs_Arquivo
Date     lvdt_Movimento		  

lvdt_Movimento = Date(gvo_Parametro.of_dh_movimentacao())
		  
//Monta o nome do arquivo de log
lvs_Arquivo = 'IF' + String(lvdt_Movimento,'dd') + String(lvdt_Movimento,'mm') + String(lvdt_Movimento,'yy') + '.txt'
lvs_Arquivo = ivs_Path_Log + lvs_Arquivo

If Not FileExists(lvs_Arquivo) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Log de autoriza$$HEX2$$e700f500$$ENDHEX$$es : " + lvs_Arquivo + " n$$HEX1$$e300$$ENDHEX$$o encontrado.",StopSign!)
	Return False
End If

Return True

end function

public function boolean of_valida_produto ();Boolean lvb_Sucesso = False

Integer lvi_Index,       &
        lvi_Itens,       &
		  lvi_Perfumaria,  &
		  lvi_Medicamento, &
		  lvi_Produto,     &
		  lvi_Manipulado
		  
// Produtos
// 7893189780046 -> Manipula$$HEX2$$e700e300$$ENDHEX$$o
// 6044226200000 -> Perfumaria
// 6048622800000 -> Manipula$$HEX1$$e700$$ENDHEX$$ao Especial

lvi_Itens = UpperBound(This.de_barras)

For lvi_Index = 1 To lvi_Itens
	If This.de_barras[lvi_Index] <> '' and Not IsNull(This.de_barras[lvi_Index]) Then
		lvi_Produto ++
		Choose Case This.de_barras[lvi_Index] 
			Case '6044226200000' ; lvi_Perfumaria ++
			Case '7893189780046','6048622800000' ; lvi_Manipulado ++
			Case Else            ; lvi_Medicamento ++
		End Choose
	End If
Next

If lvi_Produto > 0 Then
	If lvi_Produto = lvi_Medicamento Then 
		lvb_Sucesso = True 
	Else
		If lvi_Perfumaria > 0 Then
			If lvi_Produto = lvi_Perfumaria Then // Se tiver s$$HEX1$$f300$$ENDHEX$$ perfumaria
			   This.ivb_Compra = True
			   lvb_Sucesso = True
			Else
				Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A autoriza$$HEX2$$e700e300$$ENDHEX$$o deve ter somente MEDICAMENTO ou PERFUMARIA.~r~r" +&
									 "N$$HEX1$$e300$$ENDHEX$$o esque$$HEX1$$e700$$ENDHEX$$a de cancelar a autoriza$$HEX2$$e700e300$$ENDHEX$$o na FUNCIONAL CARD.", Information!)
			End If
		Else
			lvb_Sucesso = True
		End If
	End If
	
End If

Return lvb_Sucesso 
end function

public subroutine of_carrega_produtos (ref integer ai_index, ref integer ai_item, string as_transacao, integer ai_barras, integer ai_quantidade, integer ai_valor, integer ai_status, integer ai_pmc);//Se for aprovado
If MidA(as_transacao, ai_status, 2) = '00' Then
	//Carrega dados dos produtos
	If MidA(as_transacao, ai_barras, 13) <> ''  Then
		This.vl_PMC    [ai_Index] = Dec(MidA(as_transacao, ai_pmc, 06))/100
		This.de_barras [ai_Index] = MidA(as_transacao, ai_barras, 13)
		This.qt_produto[ai_Index] = Long(MidA(as_transacao, ai_quantidade, 02))	
		This.vl_produto[ai_Index] = Dec(MidA(as_transacao, ai_valor, 06))/100
		ai_item ++
	End If
End If

ai_index ++

end subroutine

public function boolean of_verifica_autorizacao (string as_autorizacao);String lvs_Achou

Long lvl_Convenio

Date lvdt_Venda_De,&
	 lvdt_Venda_Ate,&
	 lvdt_Movimentacao
	 
DateTime lvdt_Venda

lvl_Convenio = This.cd_convenio

lvdt_Movimentacao = Date(gvo_Parametro.of_DH_Movimentacao())
lvdt_Venda_De 	  = RelativeDate(lvdt_Movimentacao, -30)
lvdt_Venda_Ate	  = lvdt_Movimentacao
	   
Select dh_venda
Into :lvdt_Venda
From venda_pbm
Where cd_convenio 	  = :lvl_Convenio
  and nr_autorizacao  = :as_Autorizacao
  and dh_venda		  between :lvdt_Venda_De and :lvdt_Venda_Ate
  and dh_cancelamento is null
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da autoriza$$HEX2$$e700e300$$ENDHEX$$o.")
	Return False
End If

If SqlCa.SqlCode = 0 Then 
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Autoriza$$HEX2$$e700e300$$ENDHEX$$o '" +  as_Autorizacao +&
			   "' j$$HEX1$$e100$$ENDHEX$$ foi utilizada no dia '" + String(Date(lvdt_Venda), "dd/mm/yyyy") + "'.")
	Return False
End If

Return True
end function

public function boolean of_autorizacao (long pl_autorizacao);Boolean lvb_Fim = False

Integer  lvi_Arquivo,&
         lvi_Retorno,&
			lvi_Index,  &
			lvi_Item
			
String   lvs_Transacao,&
         lvs_Arquivo  
		  
Date     lvdt_Movimento		  

If Not This.of_Verifica_Autorizacao(String(pl_Autorizacao, "0000000")) Then Return False

lvdt_Movimento = Today()
		  
//Monta o nome do arquivo de log
lvs_Arquivo = 'IFV' + String(lvdt_Movimento,'dd') + String(lvdt_Movimento,'mm') + String(lvdt_Movimento,'yy') + '.txt'
lvs_Arquivo = ivs_Path_Log + lvs_Arquivo

If Not FileExists(lvs_Arquivo) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Log de autoriza$$HEX2$$e700f500$$ENDHEX$$es : " + lvs_Arquivo + " n$$HEX1$$e300$$ENDHEX$$o encontrado foi localizado.",StopSign!)
	Return False
End If

lvi_Arquivo = FileOpen(lvs_Arquivo, LineMode!, Read!, Shared!, Append!)

If lvi_Arquivo = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na abertura do arquivo '" + ivs_Path_Log + ".", StopSign!)
	Return False
End If

lvi_Retorno = FileRead(lvi_Arquivo,lvs_Transacao)

Do While lvi_Retorno <> -1 and lvi_Retorno <> -100
			
	//Verifica se a transa$$HEX2$$e700e300$$ENDHEX$$o existe
	If MidA(lvs_Transacao,128,07) = String(pl_autorizacao,'0000000') Then
		
		This.nr_terminal    = MidA(lvs_Transacao,113,08)
		This.nr_nsu         = MidA(lvs_Transacao,121,07)
		This.nr_doc         = Long(MidA(lvs_Transacao,128,07))
		This.nr_cartao    	= MidA(lvs_Transacao,75,20)
		This.de_transacao 	= MidA(lvs_Transacao,156,25)
		This.nm_portador  	= MidA(lvs_Transacao,221,35)
		This.dt_emissao   	= Date(MidA(lvs_Transacao,95,02) + '/' + MidA(lvs_Transacao,97,02)+'/'+MidA(lvs_Transacao,99,04))
		This.hr_emissao   	= MidA(lvs_Transacao,103,02) + ':' + MidA(lvs_Transacao,105,02)
		This.vl_saldo     	= Dec(MidA(lvs_Transacao,213,08))/100
		This.vl_desconto    = Dec(MidA(lvs_Transacao,189,08))/100
		This.vl_total       = (Dec(MidA(lvs_Transacao,181,08))/100) - This.vl_desconto
		This.vl_total_bruto = Dec(MidA(lvs_Transacao,181,08))/100
		This.vl_cartao      = Dec(MidA(lvs_Transacao,205,08))/100
		This.vl_avista      = Dec(MidA(lvs_Transacao,197,08))/100
				
		//Verifica se $$HEX1$$e900$$ENDHEX$$ uma transa$$HEX2$$e700e300$$ENDHEX$$o de Venda
		If MidA(lvs_Transacao,150,06) = '011005'	Then
				
			//Controle do n$$HEX1$$fa00$$ENDHEX$$mero de produtos da autoriza$$HEX2$$e700e300$$ENDHEX$$o
			lvi_Index = 1
			
			Do While Not lvb_Fim
									
				Choose Case lvi_Index
					Case 1
						This.of_Carrega_Produtos(Ref lvi_Index, Ref lvi_Item, lvs_Transacao, 256, 289, 291, 297, 279)
					Case 2 
						This.of_Carrega_Produtos(Ref lvi_Index, Ref lvi_Item, lvs_Transacao, 299, 332, 334, 340, 322)
					Case 3
						This.of_Carrega_Produtos(Ref lvi_Index, Ref lvi_Item, lvs_Transacao, 342, 375, 377, 383, 365)
					Case 4
						This.of_Carrega_Produtos(Ref lvi_Index, Ref lvi_Item, lvs_Transacao, 385, 418, 420, 426, 408)
					Case 5
						This.of_Carrega_Produtos(Ref lvi_Index, Ref lvi_Item, lvs_Transacao, 428, 461, 463, 469, 451)
					Case 6
						This.of_Carrega_Produtos(Ref lvi_Index, Ref lvi_Item, lvs_Transacao, 471, 504, 506, 512, 494)
					Case 7
						This.of_Carrega_Produtos(Ref lvi_Index, Ref lvi_Item, lvs_Transacao, 514, 547, 549, 555, 537)
					Case 8
						This.of_Carrega_Produtos(Ref lvi_Index, Ref lvi_Item, lvs_Transacao, 557, 590, 592, 598, 580)
					Case 9
						This.of_Carrega_Produtos(Ref lvi_Index, Ref lvi_Item, lvs_Transacao, 600, 633, 635, 641, 623)
					Case 10
						This.of_Carrega_Produtos(Ref lvi_Index, Ref lvi_Item, lvs_Transacao, 643, 676, 678, 684, 666)
					Case Else
						
						lvb_Fim = True
						//Se n$$HEX1$$e300$$ENDHEX$$o existir produtos no arquivo
						If lvi_Item = 0 Then
							MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Dados dos produtos n$$HEX1$$e300$$ENDHEX$$o encontrado no arquivo de log.",StopSign!)
							Return False			
						End If
					End Choose
			Loop
			
			// Valida os produtos (Manipulado, Medicamento ou Perfumaria)
			If of_Valida_Produto() Then
				Return True
		   Else
				Return False
			End If
		Else
			Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tipo de transa$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o habilitada.~r" + &
		           "Tipo: '" + MidA(lvs_Transacao,150,06) + "'", StopSign!)  
			Return False
		End IF
		
	End If
	
	lvi_Retorno = FileRead(lvi_Arquivo,lvs_Transacao)

Loop

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Autoriza$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o foi localizada no arquivo log.",StopSign!)

Return False
end function

public function boolean of_carrega_autorizacao ();Open(w_ge100_autorizacao_funcional_card)

IF IsNull(This.nr_doc) Then Return False

//st_autorizacao.text = String(This.nr_doc)

If This.ivb_Compra Then 
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Autoriza$$HEX2$$e700e300$$ENDHEX$$o de Compra de Perfumaria.~n~nSer$$HEX1$$e100$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio registrar os itens para finaliza$$HEX2$$e700e300$$ENDHEX$$o da venda.",Exclamation!)
End If	

Return True
end function

public function boolean of_ini_correto ();String lvs_Funcional_card

lvs_Funcional_card = gvo_Aplicacao.of_GetFromINI("Diretorio", "Funcional_Card")

If Trim(lvs_Funcional_card) = "" Then 
	SetProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "Diretorio", "Funcional_Card", "c:\micronet\")
End If

lvs_Funcional_card = gvo_Aplicacao.of_GetFromINI("Diretorio", "Funcional_Card")
//If Trim(lvs_Funcional_card) = "" Then Return False

If RightA(lvs_Funcional_card, 1) <> "\" Then
	lvs_Funcional_card += "\"
End If

This.ivs_Path_Log       = lvs_Funcional_card + "log\"

If ProfileString(gvo_Aplicacao.ivs_Arquivo_INI,"Desenvolvimento", "Atualiza_Ftp", "") <> "N" Then
	of_Atualiza_Cliente_Funcional_Card()
End If

Return True		
end function

public subroutine of_atualiza_cliente_funcional_card ();MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Fun$$HEX2$$e700e300$$ENDHEX$$o desabilitada, favor entrar em contato com o setor de inform$$HEX1$$e100$$ENDHEX$$tica.~r~r" + &
								"GE100 - uo_funcional_card - of_atualiza_cliente_funcional_card", StopSign!)

Return

Boolean lvb_Sucesso = True

Integer lvi_Retorno

Long	lvl_NR_Atualizacao_Parm, &
		lvl_Linha, &
		lvl_Linhas
	 
String lvs_Atualiza, &
	   lvs_NR_Atualizaco_Registro, &
	   lvs_Path, &
		lvs_MSG, &
		lvs_Arquivos[], &
		lvs_Arquivo_FTP, &
		lvs_Arquivo_Local, &
		lvs_MSG_FTP
	   
uo_Parametro_Filial lvo_Parametro

lvo_Parametro = Create uo_Parametro_Filial

If lvo_Parametro.of_Localiza_Parametro("NR_ATUALIZACAO_CLIENTE_FUNCIONAL_CARD", Ref lvl_NR_Atualizacao_Parm) Then
	// As filiais que n$$HEX1$$e300$$ENDHEX$$o possuem o Funcional Card est$$HEX1$$e300$$ENDHEX$$o com zero no param$$HEX1$$ea00$$ENDHEX$$tro
	If lvl_NR_Atualizacao_Parm = 0 Then
		Destroy lvo_Parametro
		Return 
	End If
End If

// Pega o n$$HEX1$$fa00$$ENDHEX$$mero do controle no registro
lvi_Retorno  = RegistryGet("HKEY_LOCAL_MACHINE\SOFTWARE\DrogariaCatarinense\FuncionalCard\Cliente", + & 
							"Nr Atualizacao", RegString!, lvs_NR_Atualizaco_Registro)

// Se n$$HEX1$$e300$$ENDHEX$$o existir a chave no registro vai incluir
If lvi_Retorno = -1 Then
	If RegistrySet("HKEY_LOCAL_MACHINE\SOFTWARE\DrogariaCatarinense\FuncionalCard\Cliente", "Nr Atualizacao", RegString!, "0") = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao incluir o registro 'HKEY_LOCAL_MACHINE\SOFTWARE\DrogariaCatarinense\FuncionalCard'.")
		Return
	Else
		lvs_NR_Atualizaco_Registro = "0"
	End If
End If

lvs_Atualiza = "N"

If Long(lvs_NR_Atualizaco_Registro) <> lvl_NR_Atualizacao_Parm Then
	lvs_Atualiza = "S"
End If
				
If lvs_Atualiza = 'S' Then
	
	dc_uo_ftp ivo_Ftp		
	ivo_FTP = Create dc_uo_FTP
	
	lvs_Path = gvo_Aplicacao.of_GetFromINI("Diretorio", "Funcional_Card")
	
	// Faz a conec$$HEX2$$e700e300$$ENDHEX$$o com o servidor FTP
	If ivo_FTP.of_Conecta_ftp("PBM", "10.0.0.17", "pbm", "pbm", Ref lvs_MSG) Then
		
		// Lista arquivos que ser$$HEX1$$e300$$ENDHEX$$o copiados
		ivo_FTP.of_ftp_Lista_Arquivos("*.txt", Ref lvs_Arquivos[])
		
		lvl_Linhas = UpperBound(lvs_Arquivos[])
		
		For lvl_Linha = 1 To lvl_Linhas
	
			lvs_Arquivo_FTP = lvs_Arquivos[lvl_Linha]
			
			lvs_Arquivo_Local = lvs_Path + lvs_Arquivo_FTP
			
			// Se o arquivo j$$HEX1$$e100$$ENDHEX$$ foi pego exclui para pegar novamente
			If FileExists(lvs_Arquivo_Local) Then
				// Se n$$HEX1$$e300$$ENDHEX$$o conseguir excluir o arquivo
				If Not FileDelete(lvs_Arquivo_Local) Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao excluir o arquivo local '" + lvs_Arquivo_Local + "'.")
					Continue
				End If
			End If
					
			If Not ivo_FTP.of_ftp_GetFile(lvs_Arquivo_FTP, lvs_Arquivo_Local, ref lvs_MSG_FTP, "BIN") Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel fazer o download do arquivo '" + lvs_Arquivo_FTP + "'.")
				lvb_Sucesso = False
				Exit
			End If
				
		Next
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi possivel conectar ao servidor FTP.", StopSign!)
	End If
	
	ivo_FTP.of_Desconecta_ftp()
	Destroy(ivo_FTP)
End If

If lvb_Sucesso Then
	If RegistrySet("HKEY_LOCAL_MACHINE\SOFTWARE\DrogariaCatarinense\FuncionalCard\Cliente", +&
			   "Nr Atualizacao", RegString!, String(lvl_NR_Atualizacao_Parm)) = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao atualizar o registro 'HKEY_LOCAL_MACHINE\SOFTWARE\DrogariaCatarinense\FuncionalCard'.")
		Destroy lvo_Parametro
		Return
	End If
End If
	
Destroy lvo_Parametro
end subroutine

public function boolean of_grava_venda_pbm (long al_filial, long al_notafiscal, string as_especie, string as_serie, long al_ecf, long al_cupom, datetime adh_movimento, decimal adc_valor_venda);
If IsNull(This.Id_Status) or Sitef.Funcional.Id_Status <> "00" Then Return True

Long   ll_convenio

String ls_autorizacao
String ls_conveniado_pbm
String ls_cartao
String ls_ecf
String ls_cupom
String ls_comprovante

Decimal{2} ldc_Valor_Reembolso

ls_ecf      = String(al_Ecf,'000')
ls_cupom    = String(al_Cupom,'000000')

ll_convenio     	= This.cd_convenio

ls_autorizacao  	= This.nr_autorizacao
ls_comprovante    = This.nr_nsu_host
ls_Conveniado_PBM = This.cd_conveniado
ls_Cartao 		   = This.nr_cartao

ldc_Valor_Reembolso = This.vl_total_bruto - This.vl_avista

Insert Into venda_pbm  
         ( cd_filial,   
           nr_nf,   
           de_especie,   
           de_serie,   
           cd_convenio,   
           dh_venda,   
           vl_total_venda,   
           nr_autorizacao,   
           nr_comprovante_venda,   
           nr_ecf,   
           nr_cupom,   
           dh_cancelamento,   
           cd_convenio_pbm,   
           nr_cartao,
			  vl_reembolso_total)  
Values   ( :al_Filial,  
           :al_NotaFiscal, 
           :as_Especie,   
           :as_Serie,   
           :ll_convenio,
           :adh_Movimento,
           :adc_Valor_Venda,
           :ls_autorizacao,   
           :ls_comprovante,   
           :ls_ecf,   
           :ls_cupom,   
           null,
           :ls_conveniado_pbm,
           :ls_cartao,
			  :ldc_valor_reembolso);

If Sqlca.Sqlcode <> 0 Then
	Sqlca.of_RollBack( )
	Sqlca.of_MsgDBError("Venda PBM - FC.")
	Return False
End If

If Not This.of_grava_venda_pbm_produto(al_filial,al_notafiscal,as_especie,as_serie,ll_convenio) Then Return False
		   
Return True
end function

public subroutine of_inicializa ();Integer lvi_Index
String  lvs_Nulo
Decimal lvdc_Nulo

SetNull(lvs_Nulo)
SetNull(lvdc_Nulo)

//Inicializa array com dados do produto
For lvi_Index = 1 To ivi_nr_itens_venda
	de_barras [lvi_Index] = lvs_Nulo
	qt_produto[lvi_Index] = lvdc_Nulo
	vl_produto[lvi_Index] = lvdc_Nulo
Next

SetNull(nr_terminal)
SetNull(nr_doc)
SetNull(nm_portador)
SetNull(nr_cartao)
SetNull(nr_nsu)
SetNull(nr_nsu_host)
SetNull(dt_emissao) 
SetNull(hr_emissao)
SetNull(de_transacao)
SetNull(nr_matricula_vendedor)
SetNull(cd_conveniado)
SetNull(nm_conveniado)
SetNull(Id_Status)

ivb_Compra = False

vl_total       = 000.00
vl_saldo       = 000.00
vl_cartao      = 000.00
vl_avista      = 000.00
vl_desconto    = 000.00
vl_total_bruto = 000.00

//nr_ecf   = 0
//nr_nc    = 0

SetNull(nr_Autorizacao)

SetNull(Retorno)
SetNull(cd_Operadora)
SetNull(de_Operadora)
SetNull(cd_Rede)
SetNull(de_Rede)
SetNull(de_Complemento)
SetNull(de_Dados_Complementares)

vl_desconto_funcional	= 000.00
vl_base_calculo			= 000.00
vl_subsidio					= 000.00

ivl_Produto = 0
ivl_Enviados = 0

ivb_PreAutorizacao = False

ds_autorizacao.of_ChangeDataObject('dw_ge084_autorizacao_trncentre')

ds_autorizacao.Reset()

//Return True
end subroutine

public function boolean of_gera_xml_produto_ws (datawindow pdw_itens);Integer li_File

Long ll_Linhas
Long ll_Linha
Long ll_Produto
Long ll_Find

String ls_EAN
String ls_Tipo
String ls_Preco
String ls_Qtde_Venda
String ls_Qtde_Receita
String ls_Data_Receita
String ls_Conselho
String ls_NR_Conselho
String ls_UF_Conselho

String ls_Xml

If FileExists( ivs_Xml_Produto_WS ) Then
	FileDelete( ivs_Xml_Produto_WS )
End If

dc_uo_ds_base ldw_Itens
ldw_Itens = Create dc_uo_ds_base
ldw_Itens.of_ChangeDataObject( 'dw_cl002_itens' )
ll_Find = pdw_Itens.RowsCopy( 1, pdw_Itens.RowCount( ), Primary!, ldw_Itens, 1, Primary! )

ls_Xml = '<?xml version="1.0" encoding="UTF-8"?><Produtos>'

ll_Linhas = ldw_Itens.RowCount( )

For ll_Linha = 1 To ll_Linhas
	ll_Find		= 1
	ll_Produto	= ldw_Itens.Object.Cd_Produto[ ll_Linha ]
	
	If IsNull( ll_Produto ) Or ll_Produto = 0 Then
		ldw_Itens.DeleteRow( ll_Linha )
		ll_Linhas --
		Continue
	End If
	
	ls_Qtde_Venda = String( ldw_Itens.Object.qt_Vendida[ ll_Find ] )

	Do While ll_Find > 0
		ll_Find = ldw_Itens.Find( 'cd_produto = ' + String( ll_produto ), ll_Linha +1, ll_Linhas )
		
		If ll_Find > 0 Then		
			ls_Qtde_Venda = String( Long( ls_Qtde_Venda ) +  ldw_Itens.Object.Qt_Vendida[ ll_Find ] )
			ldw_Itens.DeleteRow( ll_Find )
			ll_Linhas --
		End If
	Loop
	
	ls_EAN				=	String( ldw_Itens.Object.De_Codigo_Barras	[ ll_Linha ] )
	ls_Preco				=	String( ldw_Itens.Object.Vl_Preco_Praticado	[ ll_Linha ] )
	ls_Qtde_Receita	=	String( ldw_Itens.Object.Qt_Vendida[ ll_Linha ] ) // N$$HEX1$$e300$$ENDHEX$$o Tem
	ls_Data_Receita	=	String( now( ), "dd/mm/yyyy" ) // N$$HEX1$$e300$$ENDHEX$$o Tem
	ls_Conselho			=	String( ldw_Itens.Object.Id_Registro_Prescritor	[ ll_Linha ] )
	ls_NR_Conselho	=	String( ldw_Itens.Object.Nr_Registro_Prescritor	[ ll_Linha ] )
	ls_UF_Conselho	=	String( ldw_Itens.Object.Cd_Uf_Prescritor			[ ll_Linha ] )
	
	If IsNull( ls_Conselho ) Then		ls_Conselho			= ""
	If IsNull( ls_NR_Conselho ) Then	ls_NR_Conselho	= ""
	If IsNull( ls_UF_Conselho ) Then	ls_UF_Conselho	= ""
	
	Choose Case Long( ldw_Itens.Object.Cd_Grupo_Produto[ ll_Linha ] )
		Case 1	;	ls_Tipo = 'medicamento'
		Case Else;	ls_Tipo = 'outro'
	End Choose
	
	uo_Produto lo_Produto
	lo_Produto = Create uo_Produto
	
	If ll_Produto = lo_Produto.Cd_Produto_Manipulado Then
		ls_Tipo = 'manipulacao'
	End If
	
	Destroy lo_Produto
	
	ls_Xml +=	'<Produto EAN="' + ls_EAN + '" Tipo="' + ls_Tipo + '" Preco="' + ls_Preco + '" Qtd_vendida="' + ls_Qtde_Venda + '" ' + &
					'Qtd_receitada="' + ls_Qtde_Receita + '" Data_receita="' + ls_Data_Receita + '" Conselho="' + ls_NR_Conselho + '" ' + &
					'UF_Conselho="' + ls_UF_Conselho + '" Tipo_Conselho="' + ls_Conselho + '" />'
Next

ls_Xml += '</Produtos>'

Destroy ldw_Itens

li_File = FileOpen( ivs_Xml_Produto_WS, StreamMode!, Write!, LockWrite!, Replace! )

If li_File = -1 Then
	MessageBox( 'Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao abrir o arquivo de produtos ' + ivs_Xml_Produto_WS, StopSign! )
	Return False
End If

ll_Find = FileWrite( li_File, ls_Xml )

FileClose( li_File )

If ll_Find = -1 Then
	MessageBox( 'Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Erro ao gravar o arquivo de produtos ' + ivs_Xml_Produto_WS, StopSign! )
	Return False
End If

Return True
end function

public function boolean of_busca_conveniado ();Long 	ll_conveniado, &
		ll_convenio
String 	ls_nome_conveniado, &
			ls_autorizacao, &
			ls_cliente_pbm, &
			ls_cartao

ll_convenio 	= This.cd_convenio
ls_autorizacao = Fill('0', 10 - Len(This.nr_autorizacao)) + This.nr_autorizacao

Select cd_convenio_pbm,   
	   nm_cliente,
		cd_cliente,
		nr_cartao
Into   :ll_conveniado,
	   :ls_nome_conveniado,
		:ls_cliente_pbm,
		:ls_cartao
From   autorizacao_pbm
where cd_convenio_loja = :ll_convenio
	and nr_autorizacao = :ls_autorizacao
Using Sqlca;

Choose Case Sqlca.SqlCode
	Case 0		
		This.cd_conveniado 	= String(ll_conveniado)
		This.nm_portador 		= ls_nome_conveniado		
		This.cd_cliente_pbm	= ls_cliente_pbm
		This.nr_cartao			= ls_cartao
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel localizar informa$$HEX2$$e700f500$$ENDHEX$$es do Conveniado da Autoriza$$HEX2$$e700e300$$ENDHEX$$o.",StopSign!)
		Return False

	Case -1	
		Sqlca.of_MsgDbError('Localiza$$HEX2$$e700e300$$ENDHEX$$o conveniado Funcional Card.')		
		Return False
End Choose



Return True
end function

public function boolean of_inicia_tabela_produtos ();
If Not ds_autorizacao.of_ChangeDataObject('dw_ge100_autorizacao_funcional_tef') Then Return False

ds_Autorizacao.Reset()

Return True
end function

public function string of_mensagem_produto (long al_tipo);String ls_Retorno

Decimal {2} ldc_Preco_Bruto
Decimal {2} ldc_Preco_Liquido
Decimal {2} ldc_Desconto


Choose Case al_Tipo
	Case 1012 //C$$HEX1$$f300$$ENDHEX$$digo de Barra do Produto
		This.ivl_Enviados ++		
		
		If This.ivl_Enviados > This.ds_Autorizacao.RowCount() Then
			ls_Retorno = ""
			Return ls_Retorno
		End If
		
		ls_Retorno = This.ds_autorizacao.object.de_codigo_barras[This.ivl_Enviados]
		
	Case 1013 //Quantidade Solicitada
		ls_Retorno = String(This.ds_autorizacao.object.qt_vendida[This.ivl_Enviados])
		
	Case 4008 //Percentual de Desconto concedido pela administradora
		ldc_Desconto = This.ds_Autorizacao.Object.pc_desconto[This.ivl_Enviados]
		ls_Retorno = Left(String(ldc_Desconto,'####0.00'),Len(String(ldc_Desconto,'####0.00'))-3) + Right(String(ldc_Desconto,'####0.00'),2)
		
	Case 4015 //Tipo de Embalagem (padr$$HEX1$$e300$$ENDHEX$$o = U)
		ls_Retorno = "U"
		
	Case 4016 //Pre$$HEX1$$e700$$ENDHEX$$o Bruto (Centavos)
		ldc_Preco_Bruto   = This.ds_autorizacao.object.vl_preco_bruto	 [This.ivl_Enviados]
		ls_Retorno = Left(String(ldc_Preco_Bruto,'####0.00'),Len(String(ldc_Preco_Bruto,'####0.00'))-3) + Right(String(ldc_Preco_Bruto,'####0.00'),2)
		
	Case 4017 //Pre$$HEX1$$e700$$ENDHEX$$o L$$HEX1$$ed00$$ENDHEX$$quido (Centavos)
		ldc_Preco_Liquido = This.ds_autorizacao.object.vl_preco_farmacia[This.ivl_Enviados]
		ls_Retorno = Left(String(ldc_Preco_Liquido,'####0.00'),Len(String(ldc_Preco_Liquido,'####0.00'))-3) + Right(String(ldc_Preco_Liquido,'####0.00'),2)
		
	Case 4018 //Valor a receber da Loja (Centavos)
		
End Choose				 
				 
Return ls_Retorno
end function

public function boolean of_retorno_autorizacao_desconto (string ps_desconto);This.vl_desconto = Dec(ps_desconto)/100

Return True
end function

public function boolean of_retorno_autorizacao_reembolso (string ps_reembolso);This.vl_reembolso = Dec(ps_reembolso)/100

Return True
end function

public function boolean of_retorno_autorizacao_total (string ps_total);This.vl_total = Dec(ps_total)/100

Return True
end function

public function boolean of_retorno_autorizacao_total_avista (string ps_avista);This.vl_avista = Dec(ps_avista)/100

Return True
end function

public function boolean of_retorno_autorizacao_total_cartao (string ps_cartao);This.vl_cartao = Dec(ps_cartao)/100

Return True
end function

public function boolean of_retorno_produto (string ps_codigo_barras);Long ll_Find

If This.ds_Autorizacao.RowCount() > 0 Then
	ll_Find = This.ds_Autorizacao.Find("de_codigo_barras = '" + ps_codigo_barras + "'", 1, This.ds_Autorizacao.RowCount())
	
	If ll_Find < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no Find da localiza$$HEX2$$e700e300$$ENDHEX$$o do produto Funcional")
	ElseIf ll_Find > 0 Then
		ivl_Produto = ll_Find
	Else
		ivl_Produto = This.ds_Autorizacao.InsertRow(0)
	End If
Else
	ivl_Produto = This.ds_Autorizacao.InsertRow(0)
End If

This.ds_Autorizacao.object.de_codigo_barras[ivl_Produto] = ps_codigo_barras

Return True

end function

public function boolean of_retorno_produto_desconto (string ps_desconto);If ivl_Produto > 0 Then
	If This.ds_Autorizacao.object.pc_desconto[ivl_Produto] = 0 Then
		This.ds_Autorizacao.object.pc_desconto[ivl_Produto] = Dec(ps_desconto)/100
	End If	
End If	

Return True
end function

public function boolean of_retorno_produto_preco_bruto (string ps_preco);If ivl_Produto > 0 Then
	If This.ds_Autorizacao.object.vl_preco_bruto[ivl_Produto] = 0 Then
		This.ds_Autorizacao.object.vl_preco_bruto[ivl_Produto] = Dec(ps_preco)/100
	End If	
End If	

Return True
end function

public function boolean of_retorno_produto_preco_liquido (string ps_preco);If ivl_Produto > 0 Then

	This.ds_Autorizacao.object.vl_preco_liquido[ivl_Produto] = Dec(ps_preco)/100
	
End If	

Return True
end function

public function boolean of_retorno_produto_preco_pbm (string ps_preco);If ivl_Produto > 0 Then
	If This.ds_Autorizacao.object.vl_preco_farmacia[ivl_Produto] = 0 Then
		This.ds_Autorizacao.object.vl_preco_farmacia[ivl_Produto] = Dec(ps_preco)/100
	End If	
End If	

Return True
end function

public function boolean of_retorno_produto_preco_praticado (string ps_preco);If ivl_Produto > 0 Then
	If This.ds_Autorizacao.object.vl_preco_liquido_operadora[ivl_Produto] = 0 Then
		This.ds_Autorizacao.object.vl_preco_liquido_operadora[ivl_Produto] = Dec(ps_preco)/100
	End If	
End If	

Return True
end function

public function boolean of_retorno_produto_quantidade (long pl_autorizada);If ivl_Produto > 0 Then

	This.ds_Autorizacao.object.qt_autorizada[ivl_Produto] = pl_autorizada
	
End If	

Return True
end function

public function boolean of_retorno_produto_status (string ps_status);If ivl_Produto > 0 Then

	This.ds_Autorizacao.object.id_erro[ivl_Produto] = ps_status
	
End If	

Return True
end function

public function boolean of_retorno_produto_valor_subsidio (string ps_preco);If ivl_Produto > 0 Then

	This.ds_Autorizacao.object.vl_preco_farmacia[ivl_Produto] = Dec(ps_preco)/100
	
End If	

Return True
end function

public function boolean of_verifica_autorizacao ();
Long     ll_Row
Long     ll_quantidade
Long 	   ll_Linhas

Decimal {2} ldc_per_avista
Decimal {2} ldc_per_subsidio
Decimal {2} ldc_preco_avista
Decimal {2} ldc_preco_subsidio
Decimal {2} ldc_diferenca
Decimal {2} ldc_total_avista

String  ls_Retorno
String  ls_Barras

Boolean lb_Verifica = False

ll_Linhas = This.ds_autorizacao.RowCount()

For ll_Row = 1 To This.ds_autorizacao.RowCount()
	
	ll_quantidade 			  = This.ds_autorizacao.object.qt_autorizada   [ll_Row]	
	//100% a vista
	If This.vl_total = This.vl_avista Then
		This.ds_Autorizacao.object.vl_preco_liquido  	[ll_row] = This.ds_Autorizacao.object.vl_preco_liquido_operadora  [ll_row]
		This.ds_Autorizacao.object.vl_subsidio       		[ll_row] = 0.00
	Else	
		// 100% subsidio
		If This.vl_total = This.vl_cartao Then
			This.ds_Autorizacao.object.vl_preco_liquido  	[ll_row] = 0.00
			This.ds_Autorizacao.object.vl_subsidio       		[ll_row] = This.ds_Autorizacao.object.vl_preco_liquido_operadora  [ll_row]
		Else
			//Parte a vista e parte subsidio
			lb_Verifica = True
			ldc_per_avista 			= ((This.vl_avista * 100) / This.vl_total)
			ldc_per_subsidio 		= ((This.vl_cartao * 100) / This.vl_total)			
			
			ldc_preco_avista 		= Round((This.ds_Autorizacao.object.vl_preco_liquido_operadora  [ll_row] * ldc_per_avista) / 100, 2)
			ldc_preco_subsidio 	= Round((This.ds_Autorizacao.object.vl_preco_liquido_operadora  [ll_row] * ldc_per_subsidio) / 100, 2)			
			
//			ldc_diferenca = (ldc_preco_avista + ldc_preco_subsidio) - This.ds_Autorizacao.object.vl_preco_liquido_operadora  [ll_row]								
			
			ldc_Total_avista = ldc_Total_avista +  (ldc_preco_avista * ll_quantidade)
			
			This.ds_Autorizacao.object.vl_preco_liquido  	[ll_row] = ldc_preco_avista
			This.ds_Autorizacao.object.vl_subsidio       		[ll_row] = ldc_preco_subsidio
			
		End If	
	End If				

Next

//Acerto para fazer com o o Total a Vista dos produtos seja igual ao realmente cobrado.
If (ldc_Total_avista <> This.vl_avista) And lb_Verifica Then
	ldc_diferenca =  ldc_Total_avista - This.vl_avista
	This.ds_Autorizacao.object.vl_preco_liquido  	[ll_Linhas]	=  ldc_preco_avista - (ldc_diferenca / ll_quantidade)
End If

Return True
end function

public function boolean of_grava_venda_pbm_produto (long al_filial, long al_nota_fiscal, string as_especie, string as_serie, long al_convenio);
If Sitef.TrnCentre.Id_Status <> "00" Then Return True

String ls_Status
String ls_pbm = 'N'
	
Long ll_row
Long ll_produto
Long ll_quantidade
Long ll_count
Long ll_seq

Decimal {2} ldc_prc_maximo
Decimal {2} ldc_prc_praticado
Decimal {2} ldc_prc_avista
Decimal {2} ldc_subisidio
Decimal {2} ldc_reposicao
Decimal {2} ldc_reembolso
Decimal {2} ldc_reembolso_total = 000.00

For ll_row = 1 To This.ds_Autorizacao.RowCount()
	
	ls_Status         = This.ds_Autorizacao.object.id_Erro           [ll_row]
	
	If ls_Status <> "00" Then Continue
				
	ll_produto        		= This.ds_Autorizacao.object.cd_produto        [ll_row]
	ll_quantidade     	= This.ds_Autorizacao.object.qt_autorizada     [ll_row]
	ldc_prc_maximo 	= This.ds_Autorizacao.object.vl_preco_farmacia    [ll_row]
	ldc_prc_praticado 	= This.ds_Autorizacao.object.vl_preco_liquido_operadora [ll_row]
	ldc_prc_avista    	= This.ds_Autorizacao.object.vl_preco_liquido  [ll_row]
	ldc_subisidio     	= This.ds_Autorizacao.object.vl_subsidio       [ll_row]
	ldc_reposicao     	= 000.00
	ll_seq					= This.ds_Autorizacao.object.nr_sequencial   [ll_row]

	Insert Into venda_pbm_produto
				( cd_filial,   
				 nr_nf,   
				 de_especie,   
				 de_serie,   
				 cd_produto,   
				 qt_vendida,   
				 vl_preco_maximo,   
				 vl_praticado,   
				 vl_pago_avista,   
				 vl_subsidio,   
				 vl_reembolso,   
				 vl_reposicao,
				 nr_sequencial)  
	Values(:al_Filial,
			 :al_Nota_Fiscal,
			 :as_Especie,
			 :as_Serie,
			 :ll_produto,
			 :ll_quantidade,
			 :ldc_prc_maximo,
			 :ldc_prc_praticado,
			 :ldc_prc_avista,
			 :ldc_subisidio,
			 0.00,   
			 0.00,
			 :ll_seq);
				 
	If Sqlca.Sqlcode <> 0 Then
		Sqlca.of_RollBack()
		Sqlca.of_MsgDBError("Venda PBM produtos.")
		Return False
	End If		 
	
Next

Return True
end function

on uo_funcional_card.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_funcional_card.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ivo_API = Create dc_uo_API
ds_autorizacao = Create dc_uo_ds_base

ivs_Xml_Produto_WS = 'c:\sistemas\funcional\arquivos\XmlProdutos.xml'

end event

event destructor;Destroy(ivo_API)
Destroy(ds_autorizacao)
end event

