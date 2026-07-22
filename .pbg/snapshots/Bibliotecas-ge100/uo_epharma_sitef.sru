HA$PBExportHeader$uo_epharma_sitef.sru
forward
global type uo_epharma_sitef from nonvisualobject
end type
end forward

global type uo_epharma_sitef from nonvisualobject
end type
global uo_epharma_sitef uo_epharma_sitef

type variables

Boolean Id_Permite_Inclusao_Produtos = False

String Id_Status

String nr_Autorizacao

String cd_Conveniado = '999999'
String cd_Convenio_ePharma

Long cd_Convenio = 52718
Long cd_Condicao = 204

String de_Convenio

String Retorno

String nr_Cartao

Decimal {2} vl_pago_avista
Decimal {2} vl_desconto_epharma
Decimal {2} vl_total_produtos
Decimal {2} vl_reembolso

dc_uo_ds_base ds_autorizacao

Long nr_ecf_pbm
end variables

forward prototypes
public function string of_formata_preco (decimal pdc_preco, long pl_tamanho)
public function boolean of_inicia_tabela_produtos ()
public function boolean of_verifica_convenio ()
public function boolean of_retorno_autorizacao_old (datastore ds_servico)
public subroutine of_inicializa ()
public function boolean of_grava_venda_pbm (long al_filial, long al_notafiscal, string as_especie, string as_serie, long al_ecf, long al_cupom, datetime adh_movimento)
public function long of_localiza_ecf_autorizacao (string as_dados)
public function boolean of_retorno_autorizacao (datastore ds_servico)
public function boolean of_carrega_produtos_autorizacao_old ()
public function boolean of_carrega_produtos_autorizacao ()
public function boolean of_captura_numero_autorizacao ()
public function long of_consulta_dados_autorizacao ()
public function boolean of_consulta_autorizacao ()
public function boolean of_grava_venda_pbm_produto (long al_filial, long al_nota_fiscal, string as_especie, string as_serie, long al_convenio)
end prototypes

public function string of_formata_preco (decimal pdc_preco, long pl_tamanho);
String ls_Preco

If pdc_preco > 000.00 Then

	ls_Preco = String(pdc_preco,'###,###,##0.00')
	
	ls_Preco = RightA('0000000000' + LeftA( ls_Preco, PosA(ls_Preco,',') - 1 ) + RightA(ls_Preco,2),pl_tamanho)
	
Else
	ls_Preco = LeftA('0000000000',pl_tamanho)

End If	

Return ls_Preco
end function

public function boolean of_inicia_tabela_produtos ();
ds_Autorizacao.Reset()

Return True

end function

public function boolean of_verifica_convenio ();
Select c.cd_convenio,c.nm_convenio
Into :This.cd_Convenio_ePharma,
     :This.de_Convenio
From autorizacao_epharma a,
	 convenio_epharma c
Where a.cd_convenio    = c.cd_convenio
  and a.nr_autorizacao = :This.nr_Autorizacao
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case -1
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do conv$$HEX1$$ea00$$ENDHEX$$nio da e-Pharma da autoriza$$HEX2$$e700e300$$ENDHEX$$o '" + This.nr_Autorizacao + "'.")
		Return False
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o poss$$HEX1$$ed00$$ENDHEX$$vel localizar o conv$$HEX1$$ea00$$ENDHEX$$nio na autoriza$$HEX2$$e700e300$$ENDHEX$$o '" + This.nr_Autorizacao + "'.")
		Return False
End Choose

Return True
end function

public function boolean of_retorno_autorizacao_old (datastore ds_servico);
Long ll_Servico

String ls_Servico
String ls_Dados

Boolean lb_Sucesso

If ds_Servico.RowCount() = 0 Then Return False

For ll_Servico = 1 To ds_Servico.RowCount()
		
	SetPointer(HourGlass!)

	ls_Servico = ds_Servico.object.id_servico[ll_Servico]
	ls_Dados   = ds_Servico.object.de_dados  [ll_Servico]
			
	Choose Case ls_Servico
		Case 'D'
			Sitef.msg_operador = ls_Dados
			
		Case 'H'
			
			This.Id_Status = LeftA(ls_Dados,2)
			
			If This.Id_Status <> '00' Then
				If This.Id_Status = 'SC' Then
					If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Confirma transa$$HEX2$$e700e300$$ENDHEX$$o e-Pharma ?",Question!,YesNo!) = 1 Then
						This.Id_Status = '00'
					Else	
						Exit
					End If	
				Else	
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Autoriza$$HEX2$$e700e300$$ENDHEX$$o Negada ~n~n " + Sitef.msg_operador + " Status (" + This.Id_Status + ")" ,Exclamation!)	
				End If	
				
			Else

				Sitef.nr_Nsu_Host  	= MidA(ls_Dados,13,09)
				Sitef.nr_Nsu_Sitef 	= MidA(ls_Dados,78,06)
							
				Sitef.cd_Bandeira  	= MidA(ls_Dados,84,02)
				
				Sitef.de_Bandeira  	= MidA(ls_Dados,62,16)
				Sitef.de_Modalidade 	= MidA(ls_Dados,62,16)
												
			End If
			
			lb_Sucesso = True
			
		Case 'I'
			
			Sitef.de_Via_Caixa   = ls_Dados
			Sitef.de_Via_Cliente = ls_Dados
			
			//For$$HEX1$$e700$$ENDHEX$$a Confirma$$HEX2$$e700e300$$ENDHEX$$o ou Cancelamento da Transa$$HEX2$$e700e300$$ENDHEX$$o
			Sitef.Impressao = True

		Case 'V'
			
		Case 'X'
				
			If MidA(ls_Dados,1,1) = "1" Then
				
				Long   ll_Row
				Long   ll_Find
				Long   ll_Produtos
				
				String ls_Barras
				
				ll_Produtos = Long(MidA(ls_dados,02,02))
				
				If ll_Produtos <= 0 Then 
					Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Servi$$HEX1$$e700$$ENDHEX$$o X - N$$HEX1$$fa00$$ENDHEX$$mero de produtos retornados inv$$HEX1$$e100$$ENDHEX$$lido.",StopSign!)
					Return False
				End If	
				
				uo_produto lo_produto 
				lo_produto = Create uo_Produto
				
				ls_Dados = MidA(ls_Dados,4)
							
				For ll_Row = 1 To ll_Produtos
					
					ls_Barras = LeftA( MidA(ls_dados, -52 + ( 53 * ll_Row ) ,13) + Space(20) ,20)
					
					lo_Produto.of_Localiza_Codigo_Barras(Trim(ls_Barras))
					
					If Not lo_Produto.Localizado Then
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","C$$HEX1$$f300$$ENDHEX$$digo de Barras " + Trim(ls_Barras) + " n$$HEX1$$e300$$ENDHEX$$o localizado. [old]",Exclamation!)
						lb_Sucesso = False
						Exit
					End If
							
					ll_find = ds_Autorizacao.Find("cd_produto = " + String(lo_Produto.cd_produto) ,1, ds_Autorizacao.RowCount() )
					
					If ll_find < 0 Then
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no Find Servi$$HEX1$$e700$$ENDHEX$$o X",StopSign!)
						lb_Sucesso = False
						Exit
					End If
					
					If ll_find > 0 Then
					
						ds_Autorizacao.object.qt_autorizada    [ll_find] = Long(MidA(ls_dados, -39 + ( 53 * ll_Row ), 02))
						ds_Autorizacao.object.vl_preco_bruto   [ll_find] = Dec(MidA(ls_dados,  -37 + ( 53 * ll_Row ), 07))/100
						ds_Autorizacao.object.vl_preco_liquido [ll_find] = Dec(MidA(ls_dados,  -30 + ( 53 * ll_Row ), 07))/100
						ds_Autorizacao.object.vl_preco_farmacia[ll_find] = Dec(MidA(ls_dados,  -23 + ( 53 * ll_Row ), 07))/100
						ds_Autorizacao.object.pc_desconto      [ll_find] = Dec(MidA(ls_dados,  -16 + ( 53 * ll_Row ), 07))/100
						
						If ds_Autorizacao.object.qt_autorizada [ll_find] < ds_Autorizacao.object.qt_vendida[ll_find] Then
							ds_Autorizacao.object.de_msg_retorno[ll_find] = Upper('Qtde.aut. menor vendida')
						End If	
						
						If ds_Autorizacao.object.qt_vendida    [ll_find] < ds_Autorizacao.object.qt_autorizada[ll_find] Then
							ds_Autorizacao.object.de_msg_retorno[ll_find] = Upper('Qtde.aut. excede vendida')
						End If
						
						ds_Autorizacao.object.id_erro		      [ll_find] = MidA(ls_dados, -1 + ( 53 * ll_Row ) ,02)
						
					Else	
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","C$$HEX1$$f300$$ENDHEX$$digo de Barras: " + ls_Barras + "~n" + &
						                     "C$$HEX1$$f300$$ENDHEX$$digo: " + String(lo_Produto) + "~n" + &
													"Descri$$HEX2$$e700e300$$ENDHEX$$o:" + lo_Produto.De_Produto + ":" + lo_Produto.De_Apresentacao_Venda + "~n~n" + &
													"N$$HEX1$$e300$$ENDHEX$$o localizado na lista de produtos enviados para autoriza$$HEX2$$e700e300$$ENDHEX$$o." ,Exclamation!)
						lb_Sucesso = False
						Exit
						
					End If	
					
				Next
				
				Destroy(lo_produto)
							
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Dados dos produtos n$$HEX1$$e300$$ENDHEX$$o foram retornadas no Servico X.",Exclamation!)
				Exit
			End If
			
	End Choose
	
Next

Return lb_Sucesso
end function

public subroutine of_inicializa ();
This.cd_Conveniado = '999999'
This.cd_Convenio 	 = 52718
This.cd_Condicao 	 = 204

SetNull(Id_Status)
SetNull(nr_Autorizacao)
SetNull(de_Convenio)
SetNull(cd_Convenio_ePharma)
SetNull(nr_Cartao)
SetNull(Retorno)
SetNull(nr_Ecf_Pbm)

vl_pago_avista			= 000.00
vl_desconto_epharma	= 000.00
vl_total_produtos  	= 000.00
vl_Reembolso			= 000.00

Id_Permite_Inclusao_Produtos = False

ds_autorizacao.of_ChangeDataObject('dw_ge100_autorizacao_epharma')
ds_autorizacao.Reset()

end subroutine

public function boolean of_grava_venda_pbm (long al_filial, long al_notafiscal, string as_especie, string as_serie, long al_ecf, long al_cupom, datetime adh_movimento);If IsNull(This.Id_Status) or Sitef.ePharma.Id_Status <> "00" Then Return True

Long   ll_convenio

String ls_autorizacao
String ls_convenio_pbm
String ls_cartao
String ls_ecf
String ls_cupom
String ls_comprovante

ls_ecf      = String(al_Ecf,'000')
ls_cupom    = String(al_Cupom,'000000')

If as_especie = 'NFC' or as_especie = 'SAT' Then
	ls_cupom = RightA(This.nr_Autorizacao,6)	
End If

//Conv$$HEX1$$ea00$$ENDHEX$$nio e-Pharma
ll_convenio = 52718

ls_autorizacao  = This.nr_Autorizacao
ls_comprovante  = Sitef.nr_Nsu_Host
ls_convenio_pbm = LeftA(This.cd_Convenio_ePharma,20)
ls_cartao       = This.nr_Cartao

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
			  vl_reembolso_total,
			  nr_ecf_pbm)  
Values   ( :al_Filial,  
           :al_NotaFiscal, 
           :as_Especie,   
           :as_Serie,   
           :ll_convenio,
           :adh_Movimento,
           :This.vl_Total_Produtos,
           :ls_autorizacao,   
           :ls_comprovante,   
           :ls_ecf,   
           :ls_cupom,   
           null,
           :ls_convenio_pbm,
           :ls_cartao,
			  :This.vl_Reembolso,
			  :This.nr_ecf_pbm);

If Sqlca.Sqlcode <> 0 Then
	Sqlca.of_RollBack( )
	Sqlca.of_MsgDBError("Venda PBM ePharma.")
	Return False
End If

If Not This.of_grava_venda_pbm_produto(al_filial,al_notafiscal,as_especie,as_serie,ll_convenio) Then Return False
		   
Return True
end function

public function long of_localiza_ecf_autorizacao (string as_dados);
Long lvl_Pos

String lvs_Retorno
String lvs_Auxiliar
 
lvl_Pos = PosA(as_Dados, "ECF") + 4

If lvl_Pos > 0 Then
	Do While True
		lvs_Auxiliar = MidA(as_Dados, lvl_Pos, 1)
		If Trim(lvs_Auxiliar) <> ""  And Not IsNull(lvs_Auxiliar) Then
			If IsNumber(lvs_Auxiliar) Then
				lvs_Retorno += lvs_Auxiliar
			Else
				Exit
			End If
		End If	
		lvl_Pos++
	Loop
End If

If Not IsNumber(lvs_Retorno) or Long(lvs_Retorno) <= 0 Then
	lvl_Pos = PosA(as_Dados, "SERIE") + 6
	
	If lvl_Pos > 0 Then
		Do While True
			lvs_Auxiliar = MidA(as_Dados, lvl_Pos, 1)
			If Trim(lvs_Auxiliar) <> ""  And Not IsNull(lvs_Auxiliar) Then
				If IsNumber(lvs_Auxiliar) Then
					lvs_Retorno += lvs_Auxiliar
				Else
					Exit
				End If
			End If	
			lvl_Pos++
		Loop
	End If	
End If

Return Long(lvs_Retorno)
end function

public function boolean of_retorno_autorizacao (datastore ds_servico);
Long 		ll_Servico

String 	ls_Servico
String 	ls_Dados

Boolean 	lb_Sucesso  = True

If ds_Servico.RowCount() = 0 Then Return False

For ll_Servico = 1 To ds_Servico.RowCount()
		
	SetPointer(HourGlass!)

	ls_Servico = ds_Servico.object.id_servico[ll_Servico]
	ls_Dados   = ds_Servico.object.de_dados  [ll_Servico]
			
	gvo_Aplicacao.of_Grava_Log( "uo_epharma_sitef - of_retorno_autorizacao.~rServico: [ " + ls_Servico + " ] ---------- Dados: [ " + ls_dados + " ]")
			
	Choose Case ls_Servico
		Case 'D'
			Sitef.msg_operador = ls_Dados
			
		Case 'H'
			
			This.Id_Status = LeftA(ls_Dados,2)
			
			If This.Id_Status <> '00' Then
				If This.Id_Status = 'SC' Then
					If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Confirma transa$$HEX2$$e700e300$$ENDHEX$$o e-Pharma ?",Question!,YesNo!) = 1 Then
						This.Id_Status = '00'
					Else	
						lb_Sucesso = False
						Exit
					End If	
				Else	
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Autoriza$$HEX2$$e700e300$$ENDHEX$$o Negada ~n~n " + Sitef.msg_operador + " Status (" + This.Id_Status + ")" ,Exclamation!)
					lb_Sucesso = False
				End If	
				
			Else

				Sitef.nr_Nsu_Host  	= MidA(ls_Dados,13,09)
				Sitef.nr_Nsu_Sitef 	= MidA(ls_Dados,78,06)
							
				Sitef.cd_Bandeira  	= MidA(ls_Dados,84,02)
				
				Sitef.de_Bandeira  	= MidA(ls_Dados,62,16)
				Sitef.de_Modalidade 	= MidA(ls_Dados,62,16)
												
			End If
					
		Case 'I'
			
			Sitef.de_Via_Caixa   = ls_Dados
			Sitef.de_Via_Cliente = ls_Dados
			
			This.nr_ecf_pbm = of_Localiza_ECF_Autorizacao(ls_Dados)
			
			If IsNull(This.nr_ecf_pbm) Or This.nr_ecf_pbm <=0 Then			
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informa$$HEX2$$e700e300$$ENDHEX$$o de ECF retornada pelo ePharma Inv$$HEX1$$e100$$ENDHEX$$lida! Venda ser$$HEX1$$e100$$ENDHEX$$ cancelada!" ,Exclamation!)
				lb_Sucesso = False
				Exit
			End If			

			//For$$HEX1$$e700$$ENDHEX$$a Confirma$$HEX2$$e700e300$$ENDHEX$$o ou Cancelamento da Transa$$HEX2$$e700e300$$ENDHEX$$o
			Sitef.Impressao = True	
			
		Case 'V'
			
		Case 'X'
				
			If MidA(ls_Dados,1,1) = "1" Then
				
				Long   ll_Row
				Long   ll_Find
				Long   ll_Produtos
				
				String ls_Barras
				
				ll_Produtos = Long(MidA(ls_dados,02,02))
				
				If ll_Produtos <= 0 Then 
					Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Servi$$HEX1$$e700$$ENDHEX$$o X - N$$HEX1$$fa00$$ENDHEX$$mero de produtos retornados inv$$HEX1$$e100$$ENDHEX$$lido.",StopSign!)
					lb_Sucesso = False
					Exit
				End If	
				
				uo_produto lo_produto 
				lo_produto = Create uo_Produto
				
				ls_Dados = MidA(ls_Dados,4)
							
				For ll_Row = 1 To ll_Produtos
					
					ls_Barras = LeftA( MidA(ls_dados, -52 + ( 53 * ll_Row ) ,13) + Space(20) ,20)
					
					lo_Produto.of_Localiza_Codigo_Barras(Trim(ls_Barras))
					
					If Not lo_Produto.Localizado Then
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","C$$HEX1$$f300$$ENDHEX$$digo de Barras " + Trim(ls_Barras) + " n$$HEX1$$e300$$ENDHEX$$o localizado.",Exclamation!)
						lb_Sucesso = False
						Exit
					End If
							
					ll_find = ds_Autorizacao.Find("cd_produto = " + String(lo_Produto.cd_produto) ,1, ds_Autorizacao.RowCount() )
					
					If ll_find < 0 Then
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no Find Servi$$HEX1$$e700$$ENDHEX$$o X",StopSign!)
						lb_Sucesso = False
						Exit
					End If
					
					If ll_find > 0 Then
					
						If ds_Autorizacao.object.qt_autorizada [ll_find] < ds_Autorizacao.object.qt_vendida[ll_find] Then
							ds_Autorizacao.object.de_msg_retorno[ll_find] = Upper('Qtde.aut. menor vendida')
						End If	
						
						If ds_Autorizacao.object.qt_vendida    [ll_find] < ds_Autorizacao.object.qt_autorizada[ll_find] Then
							ds_Autorizacao.object.de_msg_retorno[ll_find] = Upper('Qtde.aut. excede vendida')
						End If
						
						ds_Autorizacao.object.id_erro		      [ll_find] = MidA(ls_dados, -1 + ( 53 * ll_Row ) ,02)
						
					Else	
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","C$$HEX1$$f300$$ENDHEX$$digo de Barras: " + ls_Barras + "~n" + &
						                     "C$$HEX1$$f300$$ENDHEX$$digo: " + String(lo_Produto) + "~n" + &
													"Descri$$HEX2$$e700e300$$ENDHEX$$o:" + lo_Produto.De_Produto + ":" + lo_Produto.De_Apresentacao_Venda + "~n~n" + &
													"N$$HEX1$$e300$$ENDHEX$$o localizado na lista de produtos enviados para autoriza$$HEX2$$e700e300$$ENDHEX$$o." ,Exclamation!)
						lb_Sucesso = False
						Exit
						
					End If	
					
				Next
				
				Destroy(lo_produto)
							
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Dados dos produtos n$$HEX1$$e300$$ENDHEX$$o foram retornadas no Servico X.",Exclamation!)
				lb_Sucesso = False
				Exit
			End If
			
	End Choose
	
Next

Return lb_Sucesso
end function

public function boolean of_carrega_produtos_autorizacao_old ();Boolean lvb_Sucesso = True

Long    lvl_Item,&
        lvl_Row
		 
Date lvd_Movimentacao

Decimal {2} ldc_Desconto

lvd_Movimentacao  = Date(gvo_parametro.of_dh_movimentacao())

dc_uo_ds_Base ds_produtos

ds_produtos = Create dc_uo_ds_Base
ds_produtos.of_ChangeDataObject('dw_ge100_epharma_autorizacao_capturada')

ds_produtos.Retrieve(This.nr_autorizacao)

If ds_produtos.RowCount() = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o foi possivel localizar produtos da Autoriza$$HEX2$$e700e300$$ENDHEX$$o de Venda e-Pharma.",Exclamation!)
	Return False
Else
	
	ds_Autorizacao.Reset()
	
	For lvl_Item=1 To ds_produtos.RowCount()
		
		lvl_row = ds_Autorizacao.InsertRow(0)

		If ds_Autorizacao.object.vl_preco_maximo[lvl_row] > 0 Then
			ldc_Desconto = Round( ( ds_Autorizacao.object.vl_preco_epharma[lvl_row] / ds_Autorizacao.object.vl_preco_maximo[lvl_row] ) * 100 , 2 )
		Else
			ldc_Desconto = 0
		End If
		
		ds_Autorizacao.object.cd_produto       			[lvl_row] = ds_produtos.object.cd_produto           [lvl_Item]
		ds_Autorizacao.object.nm_produto       			[lvl_row] = ds_produtos.object.de_produto           [lvl_Item]
		ds_Autorizacao.object.de_codigo_barras 			[lvl_row] = ds_produtos.object.de_codigo_barras     [lvl_Item]
		ds_Autorizacao.object.qt_autorizada    			[lvl_row] = ds_produtos.object.qt_autorizada        [lvl_Item]
		ds_Autorizacao.object.vl_preco_maximo   			[lvl_row] = ds_Produtos.object.vl_preco_maximo    	 [lvl_Item]
		ds_Autorizacao.object.vl_preco_com_desconto 		[lvl_row] = ds_Produtos.object.vl_preco_com_desconto[lvl_Item]
		ds_Autorizacao.object.vl_preco_epharma				[lvl_row] = ds_Produtos.object.vl_preco_epharma     [lvl_Item]
		ds_Autorizacao.object.vl_preco_aquisicao			[lvl_row] = ds_Produtos.object.vl_preco_aquisicao   [lvl_Item]
		ds_Autorizacao.object.vl_repasse_varejo         [lvl_row] = ds_Produtos.object.vl_repasse_varejo    [lvl_Item]		
		ds_Autorizacao.object.id_erro		      			[lvl_row] = ds_produtos.object.cd_motivo_rejeicao   [lvl_item]
		ds_Autorizacao.object.pc_desconto         		[lvl_row] = ldc_Desconto
		
		This.vl_pago_avista      += Round( ds_Autorizacao.object.vl_preco_com_desconto[lvl_row] * ds_Autorizacao.object.qt_autorizada[lvl_row] , 2 )
	    This.vl_desconto_epharma += Round( ( ds_Autorizacao.object.vl_preco_maximo[lvl_row] - ds_Autorizacao.object.vl_preco_epharma[lvl_row] ) * ds_Autorizacao.object.qt_autorizada[lvl_row] , 2 )
		This.vl_total_produtos   += Round( ds_Autorizacao.object.vl_preco_epharma[lvl_row] * ds_Autorizacao.object.qt_autorizada[lvl_row] , 2 )
		This.vl_Reembolso        += Round( ( ds_Autorizacao.object.vl_preco_maximo[lvl_row] - ds_Autorizacao.object.vl_preco_com_desconto[lvl_row] ) * ds_Autorizacao.object.qt_autorizada[lvl_row] , 2 )
			
	Next
			
End If

If This.vl_Pago_Avista = This.vl_total_Produtos Then
	This.Id_Permite_Inclusao_Produtos = True
Else
	This.Id_Permite_Inclusao_Produtos = False
End If	

gvo_Aplicacao.of_Grava_Log( "uo_epharma_sitef - of_carrega_produtos_autorizacao_old. ~r Valores: epharma.vl_pago_avista: " + String(This.vl_pago_avista) + &
									   " epharma.vl_desconto_epharma: " + String(This.vl_desconto_epharma) + &
									   " epharma.vl_total_produtos: " + String(This.vl_total_produtos) + &
									   " epharma.vl_Reembolso: " + String(This.vl_Reembolso) + &
									   " epharma.Id_Permite_Inclusao_Produtos: " + String(This.Id_Permite_Inclusao_Produtos))

Destroy(ds_produtos)

Return lvb_Sucesso
end function

public function boolean of_carrega_produtos_autorizacao ();Boolean lvb_Sucesso = False

Integer lvi_Arquivo, &
        lvi_Qtde, &
		  lvi_Read

Decimal {2} ldc_Desconto, &
		  lvdc_Preco_Maximo, &
        lvdc_Preco_Desconto, &
		  lvdc_Preco_ePharma, &
		  lvdc_Preco_Aquisicao, &
		  lvdc_Repasse_Varejo
		 
Date lvdt_Validade,&
     lvdt_Receita,&
	  lvd_Movimentacao	  

Long    lvl_Item,&
        lvl_Row,&
		  lvl_Produto		   

String lvs_Arquivo, &
       lvs_Registro, &
		 lvs_Sequencial, &
		 lvs_Funcao, &
		 lvs_Status, &
		 lvs_Mensagem, &
		 lvs_Cartao,&
		 lvs_Paciente,&
		 lvs_Codigo_Barras, &
		 lvs_Rejeicao,&
		 lvs_Tipo_Prescritor,&
		 lvs_Registro_Prescritor,&
		 lvs_Autorizacao,&
		 lvs_Situacao, &
	    lvs_DescP, &
		 lvs_DescV, &
		 lvs_Descricao, &
		 lvs_DirEp, &
		 lvs_TempEp
		 
Open(w_ge084_processando)
w_ge084_processando.mle_1.text = "Processando ePharma..."

//Reinicia ePharma
Run("Taskkill /f /t /im PBMS.exe /im e-pharma.exe /im epharma.exe")

gf_Delay(3)

Run("C:\ePharma\PBMS.exe /min")
Run("C:\ePharma\e-pharma.exe /min")
Run("C:\ePharma\epharma.exe /min")

gf_Delay(2)

gf_ativa_janela(w_ge084_processando)

If Not FileExists("C:\ePharma\REC\inicializacao.txt") Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao fazer a inicializa$$HEX2$$e700e300$$ENDHEX$$o do e-Pharma.")
	Return False
End If

lvd_Movimentacao  = Date(gvo_parametro.of_dh_movimentacao())

lvs_DirEp  = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI,"Diretorio", "ePharma","")
lvs_TempEp = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI,"Tempo", "Espera_ePharma","")

If IsNull(lvs_TempEp) or Trim(lvs_TempEp) = "" Then
	SetProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "Tempo", "Espera_ePharma", "120")
End If

If IsNull(lvs_DirEp) or Trim(lvs_DirEp) = "" Then
	SetProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "Diretorio", "ePharma", "c:\epharma\")
End If

uo_ge064_ePharma lvo_ePharma
lvo_ePharma = Create uo_ge064_ePharma //GE064

If lvo_ePharma.of_INI_Correto() Then
	If lvo_ePharma.of_Grava_Consulta(This.nr_autorizacao) Then
		If lvo_ePharma.of_Resposta_Recebida(lvo_ePharma.CONSULTA, "Aguardando Consulta da Autoriza$$HEX2$$e700e300$$ENDHEX$$o") Then
			lvo_ePharma.ivb_Consulta = True
			
			lvs_Arquivo = lvo_ePharma.ivs_Path_REC + lvo_ePharma.CONSULTA
			
			If Not lvo_ePharma.of_Abre_Arquivo(lvs_Arquivo, lvi_Arquivo, "L") Then Return False
			
			FileRead(lvi_Arquivo, lvs_Registro)
			
			lvs_Sequencial  = MidA(lvs_Registro, 1, 4)
			lvs_Funcao      = MidA(lvs_Registro, 5, 2)
			lvs_Status      = MidA(lvs_Registro, 7, 2)
			lvs_Mensagem    = MidA(lvs_Registro, 9, 40)
			lvs_Autorizacao = MidA(lvs_Registro, 56, 12)
			
			If lvs_Sequencial <> "0008" Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Sequencial recebido no arquivo de resposta inv$$HEX1$$e100$$ENDHEX$$lido.~r" + &
											 "Sequencial: (" + lvs_Sequencial + ")", StopSign!)
				lvb_Sucesso = False										 
			Else
				If lvs_Funcao <> "04" Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Fun$$HEX2$$e700e300$$ENDHEX$$o recebida no arquivo de resposta inv$$HEX1$$e100$$ENDHEX$$lida.", StopSign!)
					lvb_Sucesso = False
				Else
					If lvs_Status = "ER" Then
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Arquivo de resposta retornou um erro.~r~r" + lvs_Mensagem, StopSign!)
						lvb_Sucesso = False
					Else
						lvdt_Validade = Today()
						lvdt_Receita  = Today()
						
						lvs_Cartao    = "0000000000000000000"
						lvs_Paciente  = "PACIENTE"
						
						lvs_Tipo_Prescritor     = "1"
						lvs_Registro_Prescritor = "CRM/CRO"
					
								
						lvi_Read = FileRead(lvi_Arquivo, lvs_Registro)
							
						Do While lvi_Read <> -100					
							
							If LenA(lvs_Registro) <> 61 Then
								MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tamanho do registro lido no arquivo resposta inv$$HEX1$$e100$$ENDHEX$$lido.", StopSign!)
							Else																			
								
								lvs_Codigo_Barras    = MidA(lvs_Registro, 1, 13)
								
								If lvo_ePharma.of_Produto_Codigo_Barras(lvs_Codigo_Barras, lvl_Produto) Then 															
									lvb_Sucesso   = True
								End If
								
								lvi_Qtde             = Integer(MidA(lvs_Registro, 14, 2))
								lvdc_Preco_Maximo    = lvo_ePharma.of_Decimal(MidA(lvs_Registro, 16, 7), 2)
								lvdc_Preco_Desconto  = lvo_ePharma.of_Decimal(MidA(lvs_Registro, 23, 7), 2)
								lvdc_Preco_ePharma   = lvo_ePharma.of_Decimal(MidA(lvs_Registro, 30, 7), 2)
								lvdc_Preco_Aquisicao = lvo_ePharma.of_Decimal(MidA(lvs_Registro, 37, 7), 2)
								lvdc_Repasse_Varejo  = lvo_ePharma.of_Decimal(MidA(lvs_Registro, 44, 7), 2)
								lvs_Rejeicao         = MidA(lvs_Registro, 53, 2)
													
								If Trim(lvs_Rejeicao) = "" Then SetNull(lvs_Rejeicao)
							
	
								lvl_row = ds_Autorizacao.InsertRow(0)
								
								ldc_Desconto = Round( ( lvdc_Preco_ePharma / lvdc_Preco_Maximo ) * 100 , 2 )
								
								ds_Autorizacao.object.cd_produto       			[lvl_row] = lvl_Produto
								ds_Autorizacao.object.nm_produto       			[lvl_row] = lvs_DescP
								ds_Autorizacao.object.de_codigo_barras 			[lvl_row] = lvs_Codigo_Barras
								ds_Autorizacao.object.qt_autorizada    			[lvl_row] = lvi_Qtde
								ds_Autorizacao.object.vl_preco_maximo   			[lvl_row] = lvdc_Preco_Maximo
								ds_Autorizacao.object.vl_preco_com_desconto 		[lvl_row] = lvdc_Preco_Desconto
								ds_Autorizacao.object.vl_preco_epharma				[lvl_row] = lvdc_Preco_ePharma
								ds_Autorizacao.object.vl_preco_aquisicao			[lvl_row] = lvdc_Preco_Aquisicao
								ds_Autorizacao.object.vl_repasse_varejo         [lvl_row] = lvdc_Repasse_Varejo
								ds_Autorizacao.object.id_erro		      			[lvl_row] = lvs_Rejeicao
								ds_Autorizacao.object.pc_desconto         		[lvl_row] = ldc_Desconto
								
								This.vl_pago_avista      += Round( ds_Autorizacao.object.vl_preco_com_desconto[lvl_row] * ds_Autorizacao.object.qt_autorizada[lvl_row] , 2 )
								This.vl_desconto_epharma += Round( ( ds_Autorizacao.object.vl_preco_maximo[lvl_row] - ds_Autorizacao.object.vl_preco_epharma[lvl_row] ) * ds_Autorizacao.object.qt_autorizada[lvl_row] , 2 )
								This.vl_total_produtos   += Round( ds_Autorizacao.object.vl_preco_epharma[lvl_row] * ds_Autorizacao.object.qt_autorizada[lvl_row] , 2 )
								This.vl_Reembolso        += Round( ( ds_Autorizacao.object.vl_preco_maximo[lvl_row] - ds_Autorizacao.object.vl_preco_com_desconto[lvl_row] ) * ds_Autorizacao.object.qt_autorizada[lvl_row] , 2 )						
													
							End If
							
							If Not lvb_Sucesso Then Exit
							
							lvi_Read = FileRead(lvi_Arquivo, lvs_Registro)
						Loop
						
					End If
				End If
			End If
			
			FileClose(lvi_Arquivo)
			
			If Not FileDelete(lvs_Arquivo) Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na exclus$$HEX1$$e300$$ENDHEX$$o de resposta '" + lvs_Arquivo + "'.", StopSign!)
			End If
		End If
	End If	
End If

If This.vl_Pago_Avista = This.vl_total_Produtos Then
	This.Id_Permite_Inclusao_Produtos = True
Else
	This.Id_Permite_Inclusao_Produtos = False
End If	

gvo_Aplicacao.of_Grava_Log( "uo_epharma_sitef - of_carrega_produtos_autorizacao. ~r Valores: epharma.vl_pago_avista: " + String(This.vl_pago_avista) + &
									   " epharma.vl_desconto_epharma: " + String(This.vl_desconto_epharma) + &
									   " epharma.vl_total_produtos: " + String(This.vl_total_produtos) + &
									   " epharma.vl_Reembolso: " + String(This.vl_Reembolso) + &
									   " epharma.Id_Permite_Inclusao_Produtos: " + String(This.Id_Permite_Inclusao_Produtos))

If IsValid(w_ge084_processando) Then
	Close(w_ge084_processando)
End If

Destroy(lvo_ePharma)

Return lvb_Sucesso
end function

public function boolean of_captura_numero_autorizacao ();String ls_Autorizacao

OpenWithParm(w_ge084_numero_autorizacao,'AUTORIZA$$HEX2$$c700c300$$ENDHEX$$O e-PHARMA')

ls_Autorizacao = Message.StringParm
	
Yield()

Choose Case ls_Autorizacao 
	Case "CANCELAR"
		Return False
	Case Else	
		This.nr_Autorizacao = String(Long(ls_Autorizacao),'000000000000')
		Return True
End Choose
end function

public function long of_consulta_dados_autorizacao ();Long lvl_Retorno

String 	ls_Paciente, &
			ls_Obriga_Receita, &
			ls_Capturou_Receita

DateTime ldt_Validade, &
		   ldt_Cancelamento
			
lvl_Retorno = -1

Select dh_validade, 
		 nm_paciente,
		 dh_cancelamento,
		 nr_cartao,
		 id_obriga_receita,
		 id_capturou_receita		 
Into :ldt_validade,
	  :ls_Paciente,
	  :ldt_Cancelamento,
	  :This.nr_Cartao,
	  :ls_obriga_receita,
	  :ls_capturou_receita	  
From autorizacao_epharma
Where nr_autorizacao = :This.nr_Autorizacao
Using Sqlca;

If Sqlca.Sqlcode = -1 Then
	
	Sqlca.Of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o Autoriza$$HEX2$$e700e300$$ENDHEX$$o")

	SetNull(ldt_Validade)
	SetNull(ls_Paciente)
			
ElseIf Sqlca.Sqlcode = 100 Then
		
	SetNull(ldt_Validade)
	SetNull(ls_Paciente)
	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Autoriza$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o localizada.",Exclamation!)
	
	lvl_Retorno = -1
	
ElseIf Sqlca.Sqlcode = 0 Then
		
	If Date(ldt_Validade) < Today() Then 
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A autoriza$$HEX2$$e700e300$$ENDHEX$$o '" + This.nr_Autorizacao + "' era v$$HEX1$$e100$$ENDHEX$$lida somente at$$HEX1$$e900$$ENDHEX$$ '" + &
		                      String(ldt_Validade, "dd/mm/yyyy") + "'.", Exclamation!)
		SetNull(ldt_Validade)
		SetNull(ls_Paciente)
		
		lvl_Retorno = -1
		
	Else

		If Not IsNull(ldt_Cancelamento) Then

			SetNull(ldt_Validade)
			SetNull(ls_Paciente)
			
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Autoriza$$HEX2$$e700e300$$ENDHEX$$o foi cancelada na e-Pharma.", StopSign!)
			
			lvl_Retorno = -1
		Else
			
			If This.of_Verifica_Convenio() Then
				lvl_Retorno = 0
			End If
			
		End If
		
		If ls_Obriga_Receita = 'S' And ls_Capturou_Receita <> 'S' Then
			SetNull(ldt_Validade)
			SetNull(ls_Paciente)
			
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi Digitalizada a Receita para a Autoriza$$HEX2$$e700e300$$ENDHEX$$o!", StopSign!)				
			
			lvl_Retorno = -1			
		End If		
			
	End If
	
End If

Return lvl_Retorno
end function

public function boolean of_consulta_autorizacao ();Long lvl_Retorno

If Not This.of_Captura_Numero_Autorizacao() Then Return False

lvl_Retorno = This.of_Consulta_Dados_Autorizacao()

If lvl_Retorno = 1 Then
	If Not This.of_Carrega_Produtos_Autorizacao() Then Return False	
Else
	If lvl_Retorno = 0 Then
		If Not This.of_Carrega_Produtos_Autorizacao_old() Then Return False	
	Else
		Return False
	End If 
End If

Return True
end function

public function boolean of_grava_venda_pbm_produto (long al_filial, long al_nota_fiscal, string as_especie, string as_serie, long al_convenio);String ls_pbm = 'N'
String ls_Status
	
Long ll_row
Long ll_produto
Long ll_quantidade
Long ll_count
Long ll_seq

Decimal {2} ldc_prc_maximo
Decimal {2} ldc_prc_praticado
Decimal {2} ldc_prc_desconto
Decimal {2} ldc_prc_avista
Decimal {2} ldc_subisidio
Decimal {2} ldc_reposicao
Decimal {2} ldc_reembolso
Decimal {2} ldc_reembolso_total = 000.00

For ll_row = 1 To Sitef.ePharma.ds_Autorizacao.RowCount()
	
//	ls_Status         = This.ds_Autorizacao.object.id_Erro           [ll_row]	
//	If ls_Status <> "00" Then Continue				
	ll_produto      	= This.ds_Autorizacao.object.cd_produto   	[ll_row]
	ll_quantidade   	= This.ds_Autorizacao.object.qt_autorizada	[ll_row]
	ll_seq				= This.ds_Autorizacao.object.nr_sequencial	[ll_row]
	If ll_quantidade = 0 Then Continue
	
	Select a.vl_preco_maximo,
			 a.vl_preco_epharma, 		
			 a.vl_preco_com_desconto, 
			 a.vl_preco_aquisicao	
	into	:ldc_prc_maximo,
			:ldc_prc_praticado,
			:ldc_prc_avista,
			:ldc_reposicao
	From autorizacao_epharma_produto a
	Where a.nr_autorizacao = :This.nr_Autorizacao
	  and a.cd_produto     = :ll_produto
	Using SqlCa;
				 
	If Sqlca.Sqlcode <> 0 Then
		Sqlca.of_RollBack()
		Sqlca.of_MsgDBError("Selecao produtos autorizacao.")
		Return False
	End If		 	
	
	ldc_subisidio     = ldc_prc_praticado -  ldc_prc_avista
	ldc_reembolso     = ldc_prc_maximo - ldc_prc_avista
	
	//Verifica se o produto $$HEX1$$e900$$ENDHEX$$ PBM no momento da venda.
	//AGORA $$HEX1$$c900$$ENDHEX$$ FEITO NO CENTRAL PELO TC - VOLTAR QUANDO FOR TUDO POSTGRE
/*	If Not IsNull(al_convenio) Then
		Select Count(*)
		  Into :ll_Count			
		From pbm p 
			INNER JOIN pbm_produto pp
			on pp.cd_pbm = p.cd_pbm	
		where p.cd_convenio = :al_convenio
		and pp.cd_produto = :ll_produto
		 Using SqlCa;
		 
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o dos conv$$HEX1$$ea00$$ENDHEX$$nios PBMs do produto '" + String(ll_Produto) + "'.")
			Return False
		End If
		
		If ll_Count > 0 Then
			ls_pbm = 'S'
		Else
			ls_pbm = 'N'			
		End If		
	End If */

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
			 :ldc_reembolso,   
			 :ldc_reposicao,
			 :ll_seq);
				 
	If Sqlca.Sqlcode <> 0 Then
		Sqlca.of_RollBack()
		Sqlca.of_MsgDBError("Venda PBM produtos.")
		Return False
	End If		 
	
Next


//Insert Into venda_pbm_produto(cd_filial,
//										nr_nf,   
//										de_especie,   
//										de_serie,   
//										cd_produto,   
//										qt_vendida,   
//										vl_preco_maximo,   
//										vl_praticado,   
//										vl_pago_avista,   
//										vl_subsidio,   
//										vl_reembolso,
//										vl_reposicao)  
//Select i.cd_filial,   			  								//cd_filial
//		 i.nr_nf,       			  								//nr_nf
//		 i.de_especie,  			  								//de_especie
//		 i.de_serie,    			  								//de_serie
//		 i.cd_produto,  			  								//cd_produto
//		 i.qt_vendida,  			  								//qt_vendida
//		 a.vl_preco_maximo, 		  								//vl_preco_maximo  
//		 a.vl_preco_epharma, 		  							//vl_praticado
//		 a.vl_preco_com_desconto,   							//vl_pago_avista
//		 a.vl_preco_epharma - a.vl_preco_com_desconto, 	//vl_subsidio
//		 a.vl_preco_maximo  - a.vl_preco_com_desconto, 	//vl_reembolso
//		 a.vl_preco_aquisicao		  							//vl_reposicao
//From item_nf_venda i,
//	  autorizacao_epharma_produto a
//Where i.cd_filial      = :al_filial
//  and i.nr_nf          = :al_nota_fiscal
//  and i.de_especie 	  = :as_especie
//  and i.de_serie       = :as_serie
//  and a.nr_autorizacao = :This.nr_Autorizacao
//  and a.cd_produto     = i.cd_produto
//Using SqlCa;
//			 
//If Sqlca.Sqlcode <> 0 Then
//	Sqlca.of_RollBack()
//	Sqlca.of_MsgDBError("Venda PBM produtos.")
//	Return False
//End If		 

Return True
end function

on uo_epharma_sitef.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_epharma_sitef.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ds_autorizacao = Create dc_uo_ds_base

end event

event destructor;Destroy(ds_autorizacao)
end event

