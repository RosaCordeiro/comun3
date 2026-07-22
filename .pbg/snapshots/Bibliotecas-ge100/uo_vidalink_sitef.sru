HA$PBExportHeader$uo_vidalink_sitef.sru
forward
global type uo_vidalink_sitef from nonvisualobject
end type
end forward

global type uo_vidalink_sitef from nonvisualobject
end type
global uo_vidalink_sitef uo_vidalink_sitef

type variables
String Id_Status

String nr_Autorizacao

String cd_Operadora
String de_Operadora

String nm_Conveniado
String cd_conveniado
String cd_cnpj_convenio
String nr_comprovante
String cd_plano

String cd_Rede
String de_Rede

String nr_Cartao

String Retorno

String de_Complemento
String de_teste

Decimal {2} vl_desconto
Decimal {2} vl_desconto_trncentre
Decimal {2} vl_base_calculo
Decimal {2} vl_subsidio

Long ivl_Produto
Long ivl_Enviados
Long cd_convenio = 52575 //52575 - Farmacia Popular  /  523724 - Copel  /  53725 - Vidalink Outros
String conveniado = '999'

dc_uo_ds_base ds_autorizacao
end variables

forward prototypes
public subroutine of_inicializa ()
public function boolean of_verifica_autorizacao ()
public function string of_formata_preco (decimal pdc_preco, long pl_tamanho)
public function boolean of_retorno_abertura (datastore ds_servico)
public function boolean of_retorno_carga_tabela (datastore ds_servico)
public function boolean of_retorno_carga_tabela_operadora (datastore ds_servico)
public function boolean of_retorno_autorizacao (datastore ds_servico)
public function boolean of_grava_venda_pbm_produto (long al_filial, long al_nota_fiscal, string as_especie, string as_serie)
public function boolean of_inicia_tabela_produtos ()
public function boolean of_dados_complementares_transacao (string ps_dados)
public function boolean of_captura_numero_autorizacao ()
public function boolean of_retorno_produto (string ps_codigo_barras)
public function boolean of_retorno_produto_quantidade (long pl_autorizada)
public function boolean of_retorno_produto_preco_pbm (string ps_preco)
public function boolean of_retorno_produto_preco_bruto (string ps_preco)
public function boolean of_retorno_produto_preco_liquido (string ps_preco)
public function boolean of_retorno_produto_subsidio (string ps_preco)
public function boolean of_retorno_produto_preco_unitario (string ps_preco)
public function boolean of_retorno_produto_reembolso (string ps_preco)
public function boolean of_retorno_produto_reposicao (string ps_preco)
public function boolean of_retorno_autorizacao_desconto (string ps_desconto)
public function boolean of_retorno_produto_pc_reposicao (string ps_reposicao)
public function boolean of_retorno_produto_pc_comissao (string ps_comissao)
public function boolean of_retorno_produto_preco_avista (string ps_preco)
public function boolean of_grava_venda_pbm (long al_filial, long al_notafiscal, string as_especie, string as_serie, long al_ecf, long al_cupom, datetime adh_movimento, decimal adc_valor_venda, string as_tipo_nf, long al_convenio_venda, ref string as_comprovante)
end prototypes

public subroutine of_inicializa ();
SetNull(Id_Status)

SetNull(nr_Autorizacao)
SetNull(Retorno)

SetNull(cd_Operadora)
SetNull(de_Operadora)

SetNull(cd_Rede)
SetNull(de_Rede)

SetNull(de_Complemento)

SetNull(nr_Cartao)

vl_desconto					= 000.00
vl_desconto_trncentre	= 000.00
vl_base_calculo			= 000.00
vl_subsidio					= 000.00

ivl_Produto = 0
ivl_Enviados = 0

//ds_autorizacao.of_ChangeDataObject('dw_ge084_autorizacao_trncentre')
ds_autorizacao.of_ChangeDataObject('dw_ge084_autorizacao_vidalink')
ds_autorizacao.Reset()

end subroutine

public function boolean of_verifica_autorizacao ();
Long     ll_Row
Long     ll_quantidade

Decimal {2} ldc_desconto_trncentre
Decimal {2} ldc_desconto_padrao
Decimal {2} ldc_desconto
Decimal {2} ldc_Subsidio

String  ls_Retorno
String  ls_Barras

This.vl_desconto = 000.00
This.vl_subsidio = 000.00

For ll_Row = 1 To This.ds_autorizacao.RowCount()
			
	This.ds_autorizacao.object.vl_preco_liquido_operadora[ll_Row] = ds_autorizacao.object.vl_preco_liquido[ll_Row]

	ldc_Subsidio  = This.ds_autorizacao.object.vl_preco_liquido[ll_Row] - This.ds_autorizacao.object.vl_preco_farmacia[ll_Row]
	ll_quantidade = This.ds_autorizacao.object.qt_autorizada   [ll_Row]
	
	ldc_desconto_trncentre = This.ds_autorizacao.object.vl_preco_bruto[ll_Row] - This.ds_autorizacao.object.vl_preco_liquido[ll_Row]
	ldc_desconto_padrao    = This.ds_autorizacao.object.vl_preco_bruto[ll_Row] * (This.ds_autorizacao.object.pc_desconto_padrao[ll_Row] / 100)

	If ldc_desconto_trncentre >= ldc_desconto_padrao Then
		
		This.vl_desconto_trncentre += Round( ldc_Desconto_trncentre * ll_quantidade , 2 )
		
	Else
		
		This.ds_autorizacao.object.vl_preco_liquido[ll_Row] = This.ds_autorizacao.object.vl_preco_bruto[ll_Row] - ldc_desconto_padrao
		
		This.vl_desconto           += Round( ldc_Desconto_padrao    * ll_quantidade , 2 ) - Round( ldc_Desconto_trncentre * ll_quantidade , 2 )
		This.vl_desconto_trncentre += Round( ldc_Desconto_trncentre * ll_quantidade , 2 )
		
	End If
	
	This.ds_autorizacao.object.vl_desconto[ll_Row] = ldc_Desconto
	
	This.vl_subsidio += Round( ldc_Subsidio * ll_quantidade, 2 )

Next

// Open(w_ge100_autorizacao_vidalink)

This.Retorno = Message.StringParm

Return True
end function

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

public function boolean of_retorno_abertura (datastore ds_servico);
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

public function boolean of_retorno_carga_tabela (datastore ds_servico);
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

public function boolean of_retorno_carga_tabela_operadora (datastore ds_servico);
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

public function boolean of_retorno_autorizacao (datastore ds_servico);
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
				
				Sitef.de_Modalidade = 'VIDALINK'
				
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

public function boolean of_grava_venda_pbm_produto (long al_filial, long al_nota_fiscal, string as_especie, string as_serie);
String ls_Status
	
Long ll_row
Long ll_produto
Long ll_quantidade
Long ll_seq

Decimal {2} ldc_prc_maximo
Decimal {2} ldc_prc_praticado
Decimal {2} ldc_prc_avista
Decimal {2} ldc_subisidio
Decimal {2} ldc_reposicao
Decimal {2} ldc_reembolso
Decimal {2} ldc_reembolso_total = 000.00

For ll_row = 1 To This.ds_Autorizacao.RowCount()
	
//	ls_Status         = This.ds_Autorizacao.object.id_Erro           [ll_row]
//	
//	If ls_Status <> "00" Then Continue
				
	ll_produto        = This.ds_Autorizacao.object.cd_produto        [ll_row]
	ll_quantidade     = This.ds_Autorizacao.object.qt_autorizada     [ll_row]
	ldc_prc_maximo    = This.ds_Autorizacao.object.vl_preco_bruto    [ll_row]
	ldc_prc_praticado = This.ds_Autorizacao.object.vl_preco_liquido [ll_row]
	ldc_prc_avista    = This.ds_Autorizacao.object.vl_preco_avista  [ll_row]
	ldc_subisidio     = This.ds_Autorizacao.object.vl_subsidio       [ll_row]
	ldc_reposicao     = 000.00
	ll_seq				= This.ds_Autorizacao.object.nr_sequencial   [ll_row]
	
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
	SqlCa.of_RollBack( )
	Sqlca.of_MsgDBError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o Venda PBM - Reembolso.")
	Return False
End If		 

Return True
end function

public function boolean of_inicia_tabela_produtos ();
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

public function boolean of_captura_numero_autorizacao ();String ls_Autorizacao

OpenWithParm(w_ge084_numero_autorizacao,'AUTORIZA$$HEX2$$c700c300$$ENDHEX$$O VIDALINK')

ls_Autorizacao = Message.StringParm
	
Yield()

Choose Case ls_Autorizacao 
	Case "CANCELAR"
		Return False
	Case Else	
		This.nr_Autorizacao = ls_Autorizacao
		Return True
End Choose

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
		ivl_Produto = This.ds_Autorizacao.InsertRow(0)
	End If
Else
	ivl_Produto = This.ds_Autorizacao.InsertRow(0)
End If

This.ds_Autorizacao.object.de_codigo_barras[ivl_Produto] = ps_codigo_barras

Return True

end function

public function boolean of_retorno_produto_quantidade (long pl_autorizada);If ivl_Produto > 0 Then

	This.ds_Autorizacao.object.qt_autorizada[ivl_Produto] = pl_autorizada
	
End If	

Return True
end function

public function boolean of_retorno_produto_preco_pbm (string ps_preco);If ivl_Produto > 0 Then
	If This.ds_Autorizacao.object.vl_preco_bruto[ivl_Produto] = 0 Then
		This.ds_Autorizacao.object.vl_preco_bruto[ivl_Produto] = Dec(ps_preco)/100
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

public function boolean of_retorno_produto_subsidio (string ps_preco);If ivl_Produto > 0 Then
	If This.ds_Autorizacao.object.vl_subsidio[ivl_Produto] = 0 Then
		This.ds_Autorizacao.object.vl_subsidio[ivl_Produto] = Dec(ps_preco)/100
	End If	
End If	

Return True
end function

public function boolean of_retorno_produto_preco_unitario (string ps_preco);If ivl_Produto > 0 Then
	If This.ds_Autorizacao.object.vl_preco_liquido_operadora[ivl_Produto] = 0 Then
		This.ds_Autorizacao.object.vl_preco_liquido_operadora[ivl_Produto] = Dec(ps_preco)/100
	End If	
End If	

Return True
end function

public function boolean of_retorno_produto_reembolso (string ps_preco);If ivl_Produto > 0 Then
	If This.ds_Autorizacao.object.vl_reembolso[ivl_Produto] = 0 Then
		This.ds_Autorizacao.object.vl_reembolso[ivl_Produto] = Dec(ps_preco)/100
	End If	
End If	

Return True
end function

public function boolean of_retorno_produto_reposicao (string ps_preco);If ivl_Produto > 0 Then
	If This.ds_Autorizacao.object.vl_reposicao[ivl_Produto] = 0 Then
		This.ds_Autorizacao.object.vl_reposicao[ivl_Produto] = Dec(ps_preco)/100
	End If	
End If	

Return True
end function

public function boolean of_retorno_autorizacao_desconto (string ps_desconto);This.vl_desconto = Dec(ps_desconto)/100

Return True
end function

public function boolean of_retorno_produto_pc_reposicao (string ps_reposicao);If ivl_Produto > 0 Then
	If This.ds_Autorizacao.object.pc_reposicao[ivl_Produto] = 0 Then
		This.ds_Autorizacao.object.pc_reposicao[ivl_Produto] = Dec(ps_reposicao)/100
	End If	
End If	

Return True
end function

public function boolean of_retorno_produto_pc_comissao (string ps_comissao);If ivl_Produto > 0 Then
	If This.ds_Autorizacao.object.pc_comissao[ivl_Produto] = 0 Then
		This.ds_Autorizacao.object.pc_comissao[ivl_Produto] = Dec(ps_comissao)/100
	End If	
End If	

Return True
end function

public function boolean of_retorno_produto_preco_avista (string ps_preco);If ivl_Produto > 0 Then
	If This.ds_Autorizacao.object.vl_preco_avista[ivl_Produto] = 0 Then
		This.ds_Autorizacao.object.vl_preco_avista[ivl_Produto] = Dec(ps_preco)/100
	End If	
End If	

Return True
end function

public function boolean of_grava_venda_pbm (long al_filial, long al_notafiscal, string as_especie, string as_serie, long al_ecf, long al_cupom, datetime adh_movimento, decimal adc_valor_venda, string as_tipo_nf, long al_convenio_venda, ref string as_comprovante);
If IsNull(This.Id_Status) or This.Id_Status <> "00" Then Return True

Long   ll_convenio

String ls_autorizacao
String ls_convenio_pbm
String ls_cartao
String ls_ecf
String ls_cupom
String ls_comprovante
String ls_conveniado

Boolean lb_encontrou

ls_ecf      = String(al_Ecf,'000')
ls_cupom    = String(al_Cupom,'000000')

ls_autorizacao  = gf_retorna_so_numeros(This.nr_autorizacao)
ls_convenio_pbm = LeftA(This.cd_cnpj_convenio,20)
ls_cartao       = RightA(Trim(This.cd_conveniado),20)
ls_comprovante  = Trim(This.nr_comprovante)
as_comprovante = ls_comprovante

////Verifica se o convenio Vidalink existe no conveniado.
Select cd_conveniado Into :ls_conveniado
From conveniado
Where cd_convenio = :This.cd_convenio
  and cd_conveniado = :ls_comprovante
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		//Se encontrou vai atualizar o codigo do conveniado na nota de venda.
		lb_encontrou = True	
	Case -1
		SqlCa.of_RollBack( )
		SqlCa.of_MsgDbError( "Erro na verifica$$HEX2$$e700e300$$ENDHEX$$o de conveniado Vidalink." )
		Return False
End Choose

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
           :This.cd_convenio,
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
	SqlCa.of_RollBack( )
	Sqlca.of_MsgDBError("Venda PBM.")
	Return False
End If

//Faz a alteracao somente quando o convenio for Vidalink, demais n$$HEX1$$e300$$ENDHEX$$o faz.
If as_tipo_nf = 'CV' And lb_encontrou And al_convenio_venda = This.cd_convenio Then
	Update nf_venda
	Set cd_conveniado = :ls_comprovante
	Where cd_filial   = :al_filial
	  and nr_nf       = :al_NotaFiscal
	  and de_especie  = :as_especie
	  and de_serie    = :as_serie
	Using Sqlca;
	
	If Sqlca.Sqlcode = -1 Then
		SqlCa.of_RollBack( )
		Sqlca.Of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do conveniado Venda Vidalink.")
		Return False
	End If
End If


If Not This.of_grava_venda_pbm_produto(al_filial,al_notafiscal,as_especie,as_serie) Then Return False
		   
Return True
end function

on uo_vidalink_sitef.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_vidalink_sitef.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ds_autorizacao = Create dc_uo_ds_base

end event

event destructor;Destroy(ds_autorizacao)
end event

