HA$PBExportHeader$uo_trncentre_sitef.sru
forward
global type uo_trncentre_sitef from nonvisualobject
end type
end forward

global type uo_trncentre_sitef from nonvisualobject
end type
global uo_trncentre_sitef uo_trncentre_sitef

type variables
String Id_Status

String nr_Autorizacao

String cd_Operadora
String de_Operadora

String cd_Rede
String de_Rede

String nr_Cartao
String Retorno
String de_Complemento

String de_Dados_Complementares

Long ivl_Produto
Long ivl_Enviados

Decimal {2} vl_desconto
Decimal {2} vl_desconto_trncentre
Decimal {2} vl_base_calculo
Decimal {2} vl_subsidio

Boolean ivb_PreAutorizacao

//Decimal {2} vl_Total_Nota

dc_uo_ds_base ds_autorizacao
end variables

forward prototypes
public function string of_formata_preco (decimal pdc_preco, long pl_tamanho)
public function boolean of_grava_venda_pbm (long al_filial, long al_notafiscal, string as_especie, string as_serie, long al_ecf, long al_cupom, datetime adh_movimento, decimal adc_valor_venda)
public function boolean of_retorno_abertura (dc_uo_ds_base ds_servico)
public function boolean of_retorno_autorizacao (dc_uo_ds_base ds_servico)
public function boolean of_retorno_carga_tabela (dc_uo_ds_base ds_servico)
public function boolean of_retorno_carga_tabela_operadora (dc_uo_ds_base ds_servico)
public function boolean of_retorno_produto (string ps_codigo_barras)
public function boolean of_retorno_produto_desconto (string ps_desconto)
public function boolean of_retorno_produto_preco_liquido (string ps_preco)
public function boolean of_retorno_produto_quantidade (long pl_autorizada)
public function boolean of_retorno_produto_status (string ps_status)
public function boolean of_inicializa ()
public subroutine of_move_row (long pl_row)
public function string of_mensagem_produto (long al_tipo)
public function boolean of_retorno_produto_valor_subsidio (string ps_preco)
public function boolean of_retorno_produto_preco_bruto (string ps_preco)
public function boolean of_inicia_tabela_produtos ()
public function boolean of_dados_complementares_transacao (string ps_dados)
public function boolean of_verifica_autorizacao ()
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

public function boolean of_grava_venda_pbm (long al_filial, long al_notafiscal, string as_especie, string as_serie, long al_ecf, long al_cupom, datetime adh_movimento, decimal adc_valor_venda);
If IsNull(This.Id_Status) or Sitef.TrnCentre.Id_Status <> "00" Then Return True

Long   ll_convenio

String ls_autorizacao
String ls_convenio_pbm
String ls_cartao
String ls_ecf
String ls_cupom
String ls_comprovante

ls_ecf      = String(al_Ecf,'000')
ls_cupom    = String(al_Cupom,'000000')

//Conv$$HEX1$$ea00$$ENDHEX$$nio TrnCentre
ll_convenio     = 52568

ls_autorizacao  = Sitef.nr_Nsu_Host
ls_comprovante  = This.nr_Autorizacao
ls_convenio_pbm = LeftA((This.cd_Operadora + ' ' + This.de_Operadora),20)
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
           nr_cartao)  
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
           :ls_convenio_pbm,
           :ls_cartao);

If Sqlca.Sqlcode <> 0 Then
	Sqlca.of_RollBack( )
	Sqlca.of_MsgDBError("Venda PBM.")
	Return False
End If

If Not This.of_grava_venda_pbm_produto(al_filial,al_notafiscal,as_especie,as_serie,ll_convenio) Then Return False
		   
Return True
end function

public function boolean of_retorno_abertura (dc_uo_ds_base ds_servico);
Long ll_Servico
Long ll_Tamanho

String ls_Servico
String ls_Dados
String ls_ServicoD
String ls_Tabela

If ds_Servico.RowCount() = 0 Then Return False

For ll_Servico = 1 To ds_Servico.RowCount()
	
	SetPointer(HourGlass!)

	ls_Servico = ds_Servico.object.id_servico[ll_Servico]
	ls_Dados   = ds_Servico.object.de_dados  [ll_Servico]
	ll_Tamanho = ds_Servico.object.nr_tamanho[ll_Servico]
	
	Choose Case ls_Servico
		Case 'A'
			Sitef.nr_Nsu_Host = LeftA(ls_Dados,12)
		Case 'D'	
			If Not Sitef.of_Sitef_Direto_ServicoD('Abertura de Venda TRNCentre : ' + ls_Dados) Then Return False
		Case 'H'
			
			If LeftA(ls_Dados,02) <> '00' Then Return False
			
			Sitef.cd_Estabelecimento = MidA(ls_Dados,22,15)
			This.cd_Rede 				 = RightA(ls_Dados,2)
			This.de_Rede 				 = MidA(ls_Dados,62,16)
			
		Case 'N'
			Sitef.nr_Nsu_Sitef = ls_Dados
		Case 'X' // Dados Complementar 

			ls_Tabela = MidA(ls_Dados,01)
						
	End Choose
	
Next

Return True
end function

public function boolean of_retorno_autorizacao (dc_uo_ds_base ds_servico);
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
		Case 'A'
			
			Sitef.nr_Nsu_Host  = LeftA(ls_Dados,12)
			Sitef.vl_transacao = Dec(RightA(ls_dados,12))/100
			
			This.nr_Autorizacao = Sitef.nr_Nsu_Sitef

		Case 'D'
			Sitef.msg_operador = ls_Dados
			
		Case 'H'
			This.Id_Status = LeftA(ls_Dados,2)
			
			If This.Id_Status <> '00' Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Autoriza$$HEX2$$e700e300$$ENDHEX$$o Negada ~n~n " + Sitef.msg_operador + " Status (" + This.Id_Status + ")" ,Exclamation!)	
			Else

				Sitef.nr_Nsu_Sitef  = MidA(ls_Dados,78,06)
				
				Sitef.cd_Bandeira   = This.cd_Operadora
				Sitef.de_Bandeira   = This.de_Operadora
				
				Sitef.de_Modalidade = 'TRNCENTRE'
				
				If Sitef.Id_Cartao_Digitado Then
					This.nr_Cartao = Sitef.de_Cartao_Digitado
				Else
					This.nr_Cartao = LeftA(Sitef.de_Cartao_Trilha2,PosA(Sitef.de_Cartao_Trilha2,'=')-1)
				End If
								
			End If
			
			lb_Sucesso = True
			
		Case 'I'
			
			Sitef.de_Via_Caixa   = ls_Dados
			Sitef.de_Via_Cliente = ls_Dados
			
			//For$$HEX1$$e700$$ENDHEX$$a Confirma$$HEX2$$e700e300$$ENDHEX$$o ou Cancelamento da Transa$$HEX2$$e700e300$$ENDHEX$$o
			Sitef.Impressao = True
			
		Case 'X'
				
			If MidA(ls_Dados,1,1) = "p" Then
				
				Long   ll_Row
				Long   ll_Find
				Long   ll_Produtos
				
				String ls_Barras
				
				ll_Produtos = Long(MidA(ls_dados,03,02))
				
				If ll_Produtos <= 0 Then 
					Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Servi$$HEX1$$e700$$ENDHEX$$o X - N$$HEX1$$fa00$$ENDHEX$$mero de produtos retornados inv$$HEX1$$e100$$ENDHEX$$lido.",StopSign!)
					Return False
				End If	
				
				uo_produto lo_produto 
				lo_produto = Create uo_Produto
				
				ls_Dados = MidA(ls_Dados,5)
							
				For ll_Row = 1 To ll_Produtos
					
					ls_Barras = LeftA( MidA(ls_dados, -44 + ( 45 * ll_Row ) ,13) + Space(20) ,20)
									
					lo_Produto.of_Localiza_Codigo_Barras(ls_Barras)
					
					If Not lo_Produto.Localizado Then
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","C$$HEX1$$f300$$ENDHEX$$digo de Barras " + ls_Barras + " n$$HEX1$$e300$$ENDHEX$$o localizado.",Exclamation!)
						Return False
					End If
							
					ll_find = ds_Autorizacao.Find("cd_produto = " + String(lo_Produto.cd_produto) ,1, ds_Autorizacao.RowCount() )
					
					If ll_find < 0 Then
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no Find Servi$$HEX1$$e700$$ENDHEX$$o X",StopSign!)
						Return False
					End If
					
					If ll_find > 0 Then
					
						ds_Autorizacao.object.qt_autorizada    [ll_find] = Long(MidA(ls_dados, -30 + ( 45 * ll_Row ), 03))
						ds_Autorizacao.object.vl_preco_bruto   [ll_find] = Dec(MidA(ls_dados,  -27 + ( 45 * ll_Row ), 07))/100
						ds_Autorizacao.object.vl_preco_liquido [ll_find] = Dec(MidA(ls_dados,  -20 + ( 45 * ll_Row ), 07))/100
						ds_Autorizacao.object.vl_preco_farmacia[ll_find] = Dec(MidA(ls_dados,  -13 + ( 45 * ll_Row ), 07))/100
						ds_Autorizacao.object.pc_desconto      [ll_find] = Dec(MidA(ls_dados,   -6 + ( 45 * ll_Row ), 05))/100
						
						If ds_Autorizacao.object.qt_autorizada [ll_find] < ds_Autorizacao.object.qt_vendida[ll_find] Then
							ds_Autorizacao.object.de_msg_retorno[ll_find] = Upper('Qtde.aut. menor vendida')
						End If	
						
						If ds_Autorizacao.object.qt_vendida    [ll_find] < ds_Autorizacao.object.qt_autorizada[ll_find] Then
							ds_Autorizacao.object.de_msg_retorno[ll_find] = Upper('Qtde.aut. excede vendida')
						End If
						
						ds_Autorizacao.object.id_erro		      [ll_find] = MidA(ls_dados, -1 + ( 45 * ll_Row ) ,02)
						
					Else	
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","C$$HEX1$$f300$$ENDHEX$$digo de Barras: " + ls_Barras + "~n" + &
						                     "C$$HEX1$$f300$$ENDHEX$$digo: " + String(lo_Produto) + "~n" + &
													"Descri$$HEX2$$e700e300$$ENDHEX$$o:" + lo_Produto.De_Produto + ":" + lo_Produto.De_Apresentacao_Venda + "~n~n" + &
													"N$$HEX1$$e300$$ENDHEX$$o localizado na lista de produtos enviados para autoriza$$HEX2$$e700e300$$ENDHEX$$o." ,Exclamation!)
						Return False
						
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

public function boolean of_retorno_carga_tabela (dc_uo_ds_base ds_servico);
Long ll_Servico

String ls_Servico
String ls_Dados
String ls_ServicoD

Boolean lb_Sucesso

If ds_Servico.RowCount() = 0 Then Return False

For ll_Servico = 1 To ds_Servico.RowCount()
	
	SetPointer(HourGlass!)

	ls_Servico = ds_Servico.object.id_servico[ll_Servico]
	ls_Dados   = ds_Servico.object.de_dados  [ll_Servico]
			
	Choose Case ls_Servico
		Case 'A'
			Sitef.nr_Nsu_Host = LeftA(ls_Dados,12)
		Case 'D'	
			ls_ServicoD = ls_Dados
		Case 'H'
			This.Id_Status = LeftA(ls_Dados,2)
			
			If This.Id_Status <> '00' Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel efetuar carga de tabelas para operadoras - Status (" + This.Id_Status + ")" ,Exclamation!)	
				Exit
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Carga de Tabelas de Operadoras : " + ls_ServicoD)
				lb_Sucesso = True	
			End If
			
		Case 'X'
				
			If MidA(ls_Dados,1,1) = "o" Then
			
				String ls_Menu
				String ls_Opcao
		
				Long   ll_Operadora
							
				For ll_Operadora = 1 To Long(MidA(ls_Dados,2,2))
					
					ls_Menu += MidA(ls_Dados, -19 + (ll_Operadora * 23 ) ,3) + ':' + MidA(ls_Dados, -16 + (ll_Operadora * 23 ) ,20) + ';'
								
				Next
				
				ls_Menu = String(LenA(ls_Menu),'0000')+';'+ls_Menu+"TRNCentre - Sele$$HEX2$$e700e300$$ENDHEX$$o de Operadora"
		
				OpenWithParm(w_ge084_selecao_menu,ls_Menu)
				
				Yield()
				
				ls_opcao = Message.StringParm
			
				Choose Case ls_opcao
					Case "CANCELAR","VOLTAR"
						Return False

					Case Else
						
						This.Cd_Operadora = Trim(ls_Opcao)
						This.De_Operadora = MidA(ls_Menu,PosA(ls_Menu,Trim(ls_Opcao))+4,20)
						lb_Sucesso = True
						
				End Choose
				
			Else	
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Menu de Operadoras n$$HEX1$$e300$$ENDHEX$$o retornado no Servico X.",Exclamation!)	
				Exit
			End If
			
	End Choose
	
Next

Return lb_Sucesso
end function

public function boolean of_retorno_carga_tabela_operadora (dc_uo_ds_base ds_servico);
Long ll_Servico

String ls_Servico
String ls_Dados
String ls_ServicoD

Boolean lb_Sucesso

If ds_Servico.RowCount() = 0 Then Return False

For ll_Servico = 1 To ds_Servico.RowCount()
	
	SetPointer(HourGlass!)

	ls_Servico = ds_Servico.object.id_servico[ll_Servico]
	ls_Dados   = ds_Servico.object.de_dados  [ll_Servico]
			
	Choose Case ls_Servico
		Case 'A'
		Case 'D'	
		Case 'H'
			This.Id_Status = LeftA(ls_Dados,2)
			
			If This.Id_Status = '00' Then
				lb_Sucesso = True
			Else	
				lb_Sucesso = False
			End If
			
		Case 'X'
				
			If MidA(ls_Dados,1,1) = "c" Then
				
				If Not of_Dados_Complementares_Transacao(ls_Dados) Then Return False
				
			End If
			
	End Choose
	
Next

Return lb_Sucesso
end function

public function boolean of_retorno_produto (string ps_codigo_barras);
Long ll_Find

If This.ds_Autorizacao.RowCount() > 0 Then
	ll_Find = This.ds_Autorizacao.Find("de_codigo_barras = '" + ps_codigo_barras + "'", 1, This.ds_Autorizacao.RowCount())
	
	If ll_Find < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no Find da localiza$$HEX2$$e700e300$$ENDHEX$$o do produto TRNCentre")
	ElseIf ll_Find > 0 Then
		//Alterado - Antes movia a linha localizada para o final. Nos outros retorno pegava a $$HEX1$$fa00$$ENDHEX$$ltima linha. Agora utiliza a var ivl_Produto
		//This.of_Move_Row(ll_Find)
		//ll_Row = This.ds_Autorizacao.RowCount()
		ivl_Produto = ll_Find
	Else
		If sitef.cd_funcao = 591 Then
			ivl_Produto = This.ds_Autorizacao.InsertRow(0)
		Else
			//N$$HEX1$$e300$$ENDHEX$$o posso inserir no grid produto que originalmente n$$HEX1$$e300$$ENDHEX$$o estava.
			ivl_Produto = 0
		End If;
	End If
Else
	ivl_Produto = This.ds_Autorizacao.InsertRow(0)
End If

If ivl_Produto > 0 Then
	This.ds_Autorizacao.object.de_codigo_barras[ivl_Produto] = ps_codigo_barras
End If

Return True

end function

public function boolean of_retorno_produto_desconto (string ps_desconto);If ivl_Produto > 0 Then
	If This.ds_Autorizacao.object.pc_desconto[ivl_Produto] = 0 Then
		This.ds_Autorizacao.object.pc_desconto[ivl_Produto] = Dec(ps_desconto)/100
	End If	
End If	

Return True
end function

public function boolean of_retorno_produto_preco_liquido (string ps_preco);If ivl_Produto > 0 Then

	This.ds_Autorizacao.object.vl_preco_liquido[ivl_Produto] = Dec(ps_preco)/100
	
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

public function boolean of_inicializa ();
SetNull(Id_Status)

SetNull(nr_Autorizacao)
SetNull(Retorno)

SetNull(cd_Operadora)
SetNull(de_Operadora)

SetNull(cd_Rede)
SetNull(de_Rede)

SetNull(de_Complemento)

SetNull(nr_Cartao)

SetNull(de_Dados_Complementares)

vl_desconto					= 000.00
vl_desconto_trncentre	= 000.00
vl_base_calculo			= 000.00
vl_subsidio					= 000.00

ivl_Produto = 0
ivl_Enviados = 0

ivb_PreAutorizacao = False

//vl_Total_Nota				= 000.00

If Not ds_autorizacao.of_ChangeDataObject('dw_ge084_autorizacao_trncentre') Then Return False

ds_autorizacao.Reset()

Return True
end function

public subroutine of_move_row (long pl_row);Long lvl_Insert

lvl_Insert = This.ds_Autorizacao.InsertRow(0)

This.ds_Autorizacao.Object.cd_produto[lvl_Insert]						= This.ds_Autorizacao.Object.cd_produto[pl_Row]
This.ds_Autorizacao.Object.nm_produto[lvl_Insert]						= This.ds_Autorizacao.Object.nm_produto[pl_Row]
This.ds_Autorizacao.Object.de_codigo_barras[lvl_Insert]				= This.ds_Autorizacao.Object.de_codigo_barras[pl_Row]
This.ds_Autorizacao.Object.qt_autorizada[lvl_Insert]					= This.ds_Autorizacao.Object.qt_autorizada[pl_Row]
This.ds_Autorizacao.Object.qt_vendida[lvl_Insert]						= This.ds_Autorizacao.Object.qt_vendida[pl_Row]
This.ds_Autorizacao.Object.vl_preco_farmacia[lvl_Insert]				= This.ds_Autorizacao.Object.vl_preco_farmacia[pl_Row]
This.ds_Autorizacao.Object.vl_preco_bruto[lvl_Insert]					= This.ds_Autorizacao.Object.vl_preco_bruto[pl_Row]
This.ds_Autorizacao.Object.vl_preco_liquido[lvl_Insert]				= This.ds_Autorizacao.Object.vl_preco_liquido[pl_Row]
This.ds_Autorizacao.Object.vl_preco_liquido_operadora[lvl_Insert]	= This.ds_Autorizacao.Object.vl_preco_liquido_operadora[pl_Row]
This.ds_Autorizacao.Object.vl_desconto[lvl_Insert]						= This.ds_Autorizacao.Object.vl_desconto[pl_Row]
This.ds_Autorizacao.Object.pc_desconto[lvl_Insert]						= This.ds_Autorizacao.Object.pc_desconto[pl_Row]
This.ds_Autorizacao.Object.pc_desconto_padrao[lvl_Insert]			= This.ds_Autorizacao.Object.pc_desconto_padrao[pl_Row]
This.ds_Autorizacao.Object.id_embalagem[lvl_Insert]					= This.ds_Autorizacao.Object.id_embalagem[pl_Row]
This.ds_Autorizacao.Object.id_erro[lvl_Insert]							= This.ds_Autorizacao.Object.id_erro[pl_Row]
This.ds_Autorizacao.Object.id_complemento[lvl_Insert]					= This.ds_Autorizacao.Object.id_complemento[pl_Row]
This.ds_Autorizacao.Object.de_complemento[lvl_Insert]					= This.ds_Autorizacao.Object.de_complemento[pl_Row]
This.ds_Autorizacao.Object.vl_subsidio[lvl_Insert]						= This.ds_Autorizacao.Object.vl_subsidio[pl_Row]
This.ds_Autorizacao.Object.de_msg_retorno[lvl_Insert]					= This.ds_Autorizacao.Object.de_msg_retorno[pl_Row]
This.ds_Autorizacao.Object.cd_grupo_produto[lvl_Insert]				= This.ds_Autorizacao.Object.cd_grupo_produto[pl_Row]

ds_Autorizacao.DeleteRow(pl_Row)
end subroutine

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
		ls_Retorno = LeftA(String(ldc_Desconto,'####0.00'),LenA(String(ldc_Desconto,'####0.00'))-3) + RightA(String(ldc_Desconto,'####0.00'),2)
		
	Case 4015 //Tipo de Embalagem (padr$$HEX1$$e300$$ENDHEX$$o = U)
		ls_Retorno = "U"
		
	Case 4016 //Pre$$HEX1$$e700$$ENDHEX$$o Bruto (Centavos)
		ldc_Preco_Bruto   = This.ds_autorizacao.object.vl_preco_bruto	 [This.ivl_Enviados]
		ls_Retorno = LeftA(String(ldc_Preco_Bruto,'####0.00'),LenA(String(ldc_Preco_Bruto,'####0.00'))-3) + RightA(String(ldc_Preco_Bruto,'####0.00'),2)
		
	Case 4017 //Pre$$HEX1$$e700$$ENDHEX$$o L$$HEX1$$ed00$$ENDHEX$$quido (Centavos)
		ldc_Preco_Liquido = This.ds_autorizacao.object.vl_preco_farmacia[This.ivl_Enviados]
		ls_Retorno = LeftA(String(ldc_Preco_Liquido,'####0.00'),LenA(String(ldc_Preco_Liquido,'####0.00'))-3) + RightA(String(ldc_Preco_Liquido,'####0.00'),2)
		
	Case 4018 //Valor a receber da Loja (Centavos)
		
End Choose				 
				 
Return ls_Retorno
end function

public function boolean of_retorno_produto_valor_subsidio (string ps_preco);If ivl_Produto > 0 Then

	This.ds_Autorizacao.object.vl_preco_farmacia[ivl_Produto] = Dec(ps_preco)/100
	
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

public function boolean of_inicia_tabela_produtos ();
If Not ds_autorizacao.of_ChangeDataObject('dw_ge084_autorizacao_trncentre') Then Return False

ds_Autorizacao.Reset()

Return True

end function

public function boolean of_dados_complementares_transacao (string ps_dados);Long ll_Row

String ls_Parametro
String ls_TipoCampo
String ls_TamMin
String ls_TamMax
String ls_NomeCampo
String ls_Opcao

SetNull(This.de_Complemento)

For ll_Row = 1 To Long(LeftA(ps_Dados,02))
	
	ls_TipoCampo = MidA(ps_Dados, -22 + ( 25 * ll_Row ) , 1)
	ls_TamMin    = MidA(ps_Dados, -21 + ( 25 * ll_Row ) , 2)
	ls_TamMax    = MidA(ps_Dados, -19 + ( 25 * ll_Row ) , 2)
	ls_NomeCampo = MidA(ps_Dados, -17 + ( 25 * ll_Row ) , 20)
	
	Choose Case Upper(ls_TipoCampo)
		Case "A"
			
			ls_Parametro = '00000'+';'+String(Long(ls_TamMin),'00000')+';'+String(Long(ls_TamMax),'00000')+Space(30)+ls_NomeCampo
						
			OpenWithParm(w_ge084_coleta_campo_string,ls_Parametro)
		
		Case "N"
			
			ls_Parametro = '00000'+';'+String(Long(ls_TamMin),'00000')+';'+String(Long(ls_TamMax),'00000')+ls_NomeCampo
			
			OpenWithParm(w_ge084_coleta_campo_numerico,ls_Parametro)
			
		Case "F"	
			
			OpenWithParm(w_ge084_coleta_sim_nao,ls_NomeCampo)
			
	End Choose
	
	ls_Opcao = Message.StringParm
	
	IF ls_Opcao = "CANCELAR" Then Return False
	
	This.de_Complemento += String(LenA(ls_Opcao),'00')+ls_Opcao
	
Next

Return False
end function

public function boolean of_verifica_autorizacao ();
Long     ll_Row
Long     ll_quantidade

Decimal {2} ldc_desconto_trncentre
Decimal {2} ldc_desconto_padrao
Decimal {2} ldc_desconto
Decimal {2} ldc_Subsidio
Decimal {2} ldc_per_desc

String  ls_Retorno
String  ls_Barras

This.vl_desconto = 000.00
This.vl_subsidio = 000.00

For ll_Row = 1 To This.ds_autorizacao.RowCount()
			
	This.ds_autorizacao.object.vl_preco_liquido_operadora[ll_Row] = ds_autorizacao.object.vl_preco_liquido[ll_Row]

	ldc_Subsidio  			  = This.ds_autorizacao.object.vl_preco_liquido[ll_Row] - This.ds_autorizacao.object.vl_preco_farmacia[ll_Row]
	ll_quantidade 			  = This.ds_autorizacao.object.qt_autorizada   [ll_Row]
	
	ldc_desconto_trncentre = This.ds_autorizacao.object.vl_preco_bruto[ll_Row] - This.ds_autorizacao.object.vl_preco_liquido[ll_Row]
	ldc_desconto_padrao    = This.ds_autorizacao.object.vl_preco_bruto[ll_Row] * (This.ds_autorizacao.object.pc_desconto_padrao[ll_Row] / 100)

	If ldc_desconto_trncentre >= ldc_desconto_padrao Then
		
		This.vl_desconto_trncentre += Round( ldc_Desconto_trncentre * ll_quantidade , 2 )
		//Calcula percentual correto devido a diferen$$HEX1$$e700$$ENDHEX$$as de 0,01.
		
		ldc_per_desc = ((ldc_desconto_trncentre * 100) / This.ds_autorizacao.object.vl_preco_bruto[ll_Row])
		This.ds_autorizacao.object.pc_desconto[ll_Row] = ldc_per_desc
		
	Else
		
		This.ds_autorizacao.object.vl_preco_liquido[ll_Row] = This.ds_autorizacao.object.vl_preco_bruto[ll_Row] - ldc_desconto_padrao
		
		This.vl_desconto           += Round( ldc_Desconto_padrao    * ll_quantidade , 2 ) - Round( ldc_Desconto_trncentre * ll_quantidade , 2 )
		This.vl_desconto_trncentre += Round( ldc_Desconto_trncentre * ll_quantidade , 2 )
		
	End If
	
	This.ds_autorizacao.object.vl_desconto[ll_Row] = ldc_Desconto
	
	This.vl_subsidio += Round( ldc_Subsidio * ll_quantidade, 2 )

Next

Open(w_ge100_autorizacao_trncentre)

This.Retorno = Message.StringParm

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

For ll_row = 1 To Sitef.TrnCentre.ds_Autorizacao.RowCount()
	
	ls_Status         = This.ds_Autorizacao.object.id_Erro           [ll_row]
	
	If ls_Status <> "00" Then Continue
				
	ll_produto        = This.ds_Autorizacao.object.cd_produto        [ll_row]
	ll_quantidade     = This.ds_Autorizacao.object.qt_autorizada     [ll_row]
	If ll_quantidade = 0 Then Continue
	ldc_prc_maximo    = This.ds_Autorizacao.object.vl_preco_bruto    [ll_row]
	ldc_prc_praticado = This.ds_Autorizacao.object.vl_preco_farmacia [ll_row]
	ldc_prc_avista    = This.ds_Autorizacao.object.vl_preco_liquido  [ll_row]
	ldc_subisidio     = This.ds_Autorizacao.object.vl_subsidio       [ll_row]
	ldc_reposicao     = 000.00
	ll_seq				= This.ds_Autorizacao.object.nr_sequencial[ll_row]
	
	ldc_reembolso     = ldc_prc_maximo - ldc_prc_avista
	
	ldc_reembolso_total += ( ldc_reembolso * ll_quantidade )
	
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
	
Update Venda_pbm
   Set vl_reembolso_total = :ldc_reembolso_total
 Where cd_filial  = :al_Filial
   and nr_nf      = :al_Nota_Fiscal
   and de_especie = :as_Especie
   and de_serie   = :as_Serie
 Using Sqlca;  
   
If Sqlca.Sqlcode <> 0 Then
	Sqlca.of_RollBack( )
	Sqlca.of_MsgDBError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o Venda PBM - Reembolso.")
	Return False
End If		 

Return True
end function

on uo_trncentre_sitef.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_trncentre_sitef.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ds_autorizacao = Create dc_uo_ds_base

end event

event destructor;Destroy(ds_autorizacao)
end event

