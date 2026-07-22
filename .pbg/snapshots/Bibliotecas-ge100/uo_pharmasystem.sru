HA$PBExportHeader$uo_pharmasystem.sru
forward
global type uo_pharmasystem from nonvisualobject
end type
end forward

global type uo_pharmasystem from nonvisualobject
end type
global uo_pharmasystem uo_pharmasystem

type variables
String Id_Status

String nm_Conveniado
String nm_Operadora
String nm_Empresa 

String Retorno

String nr_Autorizacao

String cd_Dependente
String nm_Dependente

Long ivl_Produtos
Long ivl_Enviados

Long qt_Dependentes

Decimal {2} vl_Saldo
Decimal {2} vl_Desconto
Decimal {2} vl_Desconto_PBM

//Decimal {2} vl_Total_Nota

dc_uo_ds_base ds_autorizacao
dc_uo_ds_base ds_retorno

end variables

forward prototypes
public function boolean of_inicializa_tabela_produtos ()
public function string of_mensagem_produto ()
public function boolean of_verifica_autorizacao ()
public function boolean of_verifica_autorizacao_old ()
public function boolean of_retorno_produto (string ps_codigo_barras)
public function boolean of_retorno_produto_desconto (string ps_desconto)
public function boolean of_retorno_produto_preco_bruto (string ps_preco)
public function boolean of_retorno_produto_preco_liquido (string ps_preco)
public function boolean of_retorno_produto_quantidade (long pl_autorizada)
public function boolean of_retorno_produto_status (string ps_status)
public function boolean of_retorno_produto_valor_receber (string ps_valor)
public function boolean of_grava_venda_pbm (long al_filial, long al_notafiscal, string as_especie, string as_serie, long al_ecf, long al_cupom, datetime adh_movimento, decimal adc_valor_venda)
public subroutine of_inicializa ()
public function boolean of_grava_venda_pbm_produto (long al_filial, long al_nota_fiscal, string as_especie, string as_serie, long al_convenio)
public function boolean of_produto_autorizacao (long pl_produto, string ps_descricao, string ps_barras, long pl_quantidade, decimal pdc_preco_unitario, decimal pdc_preco_praticado, decimal pdc_desconto_loja, long pl_sequencial)
end prototypes

public function boolean of_inicializa_tabela_produtos ();
If Not ds_autorizacao.of_ChangeDataObject('dw_ge084_autorizacao_pharmasystem') Then Return False

If Not ds_retorno.of_ChangeDataObject('dw_ge084_autorizacao_pharmasystem') Then Return False

ds_Autorizacao.Reset()
ds_Retorno.Reset()

This.ivl_Produtos = 0
This.ivl_Enviados = 0

Return True

end function

public function string of_mensagem_produto ();String ls_Retorno

Decimal {2} ldc_Preco_Bruto
Decimal {2} ldc_Preco_Liquido

This.ivl_Enviados ++

// <CodEAN>;<CodPDV>;<Descricao>;<Qtde>;<PrecoBruto>;<PrecoLiquido>;

ldc_Preco_Bruto   = This.ds_autorizacao.object.vl_preco_bruto[This.ivl_Enviados]
ldc_Preco_Liquido = This.ds_autorizacao.object.vl_preco_loja [This.ivl_Enviados]

ls_Retorno = This.ds_autorizacao.object.de_codigo_barras[This.ivl_Enviados] + ";" + &
				 String(This.ds_autorizacao.object.cd_produto[This.ivl_Enviados],'0000000000') + ";" + &
				 This.ds_autorizacao.object.nm_produto[This.ivl_Enviados] + ";" + &
				 String(This.ds_autorizacao.object.qt_vendida[This.ivl_Enviados],'0000') + ";" + &
				 LeftA(String(ldc_Preco_Bruto,'####0.00'),LenA(String(ldc_Preco_Bruto,'####0.00'))-3) + RightA(String(ldc_Preco_Bruto,'####0.00'),2) + ";" + &
				 LeftA(String(ldc_Preco_Liquido,'####0.00'),LenA(String(ldc_Preco_Liquido,'####0.00'))-3) + RightA(String(ldc_Preco_Liquido,'####0.00'),2) + ";"
				 
Return ls_Retorno
end function

public function boolean of_verifica_autorizacao ();
Long     ll_Row
Long     ll_Find
Long     ll_quantidade

Decimal {2} ldc_desconto_pbm
Decimal {2} ldc_desconto_loja

String  ls_Retorno
String  ls_Barras

If ds_Retorno.RowCount() = 0 Then 
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao verificar retorno da autoriza$$HEX2$$e700e300$$ENDHEX$$o Pharma-System.",Exclamation!)
	Return False
End If	

This.vl_desconto 		= 000.00
This.vl_desconto_pbm = 000.00

For ll_Row = 1 To This.ds_Retorno.RowCount()
	
	ls_Barras = This.ds_Retorno.object.de_codigo_barras[ll_row]
	
	ll_Find = This.ds_Autorizacao.Find("de_codigo_barras = '" + ls_Barras + "'",1,This.ds_Autorizacao.RowCount())
	
	If ll_Find > 0 Then
		
		This.ds_Autorizacao.object.qt_autorizada	[ll_Row] = This.ds_Retorno.object.qt_autorizada	 	[ll_find]
		This.ds_Autorizacao.object.id_erro			[ll_Row] = This.ds_Retorno.object.id_erro			 	[ll_find]
		This.ds_Autorizacao.object.pc_desconto_pbm[ll_Row] = This.ds_Retorno.object.pc_desconto_pbm	[ll_find]
		This.ds_Autorizacao.object.vl_preco_pbm	[ll_Row] = This.ds_Retorno.object.vl_preco_pbm	 	[ll_find]
		This.ds_Autorizacao.object.vl_receber		[ll_Row] = This.ds_Retorno.object.vl_receber		 	[ll_find]
		
		This.ds_autorizacao.object.vl_preco_bruto	[ll_Row] = This.ds_Retorno.object.vl_preco_bruto	[ll_find]
			
		ll_quantidade 		= This.ds_Autorizacao.object.qt_autorizada[ll_Row]
		
		ldc_desconto_pbm 	= This.ds_autorizacao.object.vl_preco_bruto[ll_Row] - This.ds_autorizacao.object.vl_preco_pbm [ll_Row]
		ldc_desconto_loja	= This.ds_autorizacao.object.vl_preco_bruto[ll_Row] - Round( This.ds_autorizacao.object.vl_preco_loja[ll_Row] * ll_quantidade , 2 )
	
		If ldc_desconto_pbm >= ldc_desconto_loja Then
			
			This.vl_desconto_pbm += ldc_desconto_pbm
			
			This.ds_Autorizacao.object.vl_desconto		 [ll_Row] = ldc_desconto_pbm
			This.ds_Autorizacao.object.vl_preco_liquido[ll_Row] = Round( This.ds_autorizacao.object.vl_preco_pbm[ll_Row] / ll_quantidade , 2  )
			
		Else
					
			This.vl_desconto     += Round( ldc_desconto_loja * ll_quantidade , 2 ) - ldc_desconto_pbm
			This.vl_desconto_pbm += ldc_desconto_pbm
			
			This.ds_Autorizacao.object.vl_desconto[ll_Row] = This.ds_autorizacao.object.vl_preco_loja[ll_Row]
			
		End If
		
End If	
	
Next

Open(w_ge100_autorizacao_PharmaSystem)

This.Retorno = Message.StringParm

Return True
end function

public function boolean of_verifica_autorizacao_old ();
Long     ll_Row
Long     ll_Find
Long     ll_quantidade

Decimal {2} ldc_desconto_pbm
Decimal {2} ldc_desconto_loja

String  ls_Retorno
String  ls_Barras

If ds_Retorno.RowCount() = 0 Then 
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao verificar retorno da autoriza$$HEX2$$e700e300$$ENDHEX$$o Pharma-System.",Exclamation!)
	Return False
End If	

This.vl_desconto 		= 000.00
This.vl_desconto_pbm = 000.00

For ll_Row = 1 To This.ds_Retorno.RowCount()
	
	ls_Barras = This.ds_Retorno.object.de_codigo_barras[ll_row]
	
	ll_Find = This.ds_Autorizacao.Find("de_codigo_barras = '" + ls_Barras + "'",1,This.ds_Autorizacao.RowCount())
	
	If ll_Find > 0 Then
		
		This.ds_Autorizacao.object.qt_autorizada	[ll_Row] = This.ds_Retorno.object.qt_autorizada	 [ll_find]
		This.ds_Autorizacao.object.id_erro			[ll_Row] = This.ds_Retorno.object.id_erro			 [ll_find]
		This.ds_Autorizacao.object.pc_desconto_pbm[ll_Row] = This.ds_Retorno.object.pc_desconto_pbm[ll_find]
		This.ds_Autorizacao.object.vl_preco_pbm	[ll_Row] = This.ds_Retorno.object.vl_preco_pbm	 [ll_find]
		This.ds_Autorizacao.object.vl_receber		[ll_Row] = This.ds_Retorno.object.vl_receber		 [ll_find]
		
		Decimal {2} a,b,c,d,e
		
		a = This.ds_Retorno.object.pc_desconto_pbm[ll_find]
		b = This.ds_Retorno.object.vl_preco_pbm	[ll_find]
		c = This.ds_Retorno.object.vl_receber		[ll_find]
		
		d = This.ds_autorizacao.object.vl_preco_bruto[ll_Row]
		e = This.ds_autorizacao.object.vl_preco_loja [ll_Row]
										
		ll_quantidade 		= This.ds_Autorizacao.object.qt_autorizada[ll_Row]
		
		ldc_desconto_pbm 	= This.ds_autorizacao.object.vl_preco_bruto[ll_Row] - This.ds_autorizacao.object.vl_preco_pbm [ll_Row]
		ldc_desconto_loja	= This.ds_autorizacao.object.vl_preco_bruto[ll_Row] - This.ds_autorizacao.object.vl_preco_loja[ll_Row]
	
		If ldc_desconto_pbm >= ldc_desconto_loja Then
			
			This.vl_desconto_pbm += Round( ldc_desconto_pbm * ll_quantidade , 2 )
			
			This.ds_Autorizacao.object.vl_desconto		 [ll_Row] = ldc_desconto_pbm
			This.ds_Autorizacao.object.vl_preco_liquido[ll_Row] = This.ds_autorizacao.object.vl_preco_pbm[ll_Row]
			
		Else
					
			This.vl_desconto     += Round( ldc_desconto_loja * ll_quantidade , 2 ) - Round( ldc_desconto_pbm * ll_quantidade , 2 )
			This.vl_desconto_pbm += Round( ldc_desconto_pbm  * ll_quantidade , 2 )
			
			This.ds_Autorizacao.object.vl_desconto[ll_Row] = This.ds_autorizacao.object.vl_preco_loja[ll_Row]
			
		End If
		
End If	
	
Next

Open(w_ge100_autorizacao_PharmaSystem)

This.Retorno = Message.StringParm

Return True
end function

public function boolean of_retorno_produto (string ps_codigo_barras);
Long ll_Row

ll_Row = This.ds_Retorno.InsertRow(0)

This.ds_Retorno.object.de_codigo_barras[ll_Row] = ps_codigo_barras

Return True

end function

public function boolean of_retorno_produto_desconto (string ps_desconto);
Long ll_Row

ll_Row = This.ds_Retorno.RowCount()

If ll_Row > 0 Then
	If This.ds_Retorno.object.pc_desconto_pbm[ll_Row] = 0 Then
		This.ds_Retorno.object.pc_desconto_pbm[ll_Row] = Dec(ps_desconto)/100
	End If	
End If	

Return True
end function

public function boolean of_retorno_produto_preco_bruto (string ps_preco);
Long ll_Row

ll_Row = This.ds_Retorno.RowCount()

If ll_Row > 0 Then
	If This.ds_Retorno.object.vl_preco_bruto[ll_Row] = 0 Then
		This.ds_Retorno.object.vl_preco_bruto[ll_Row] = Dec(ps_preco)/100
	End If	
End If	

Return True
end function

public function boolean of_retorno_produto_preco_liquido (string ps_preco);
Long ll_Row

ll_Row = This.ds_Retorno.RowCount()

If ll_Row > 0 Then

	This.ds_Retorno.object.vl_preco_pbm[ll_Row] = Dec(ps_preco)/100
	
End If	

Return True
end function

public function boolean of_retorno_produto_quantidade (long pl_autorizada);
Long ll_Row

ll_Row = This.ds_Retorno.RowCount()

If ll_Row > 0 Then

	This.ds_Retorno.object.qt_autorizada[ll_Row] = pl_autorizada
	
End If	

Return True
end function

public function boolean of_retorno_produto_status (string ps_status);
Long ll_Row

ll_Row = This.ds_Retorno.RowCount()

If ll_Row > 0 Then

	This.ds_Retorno.object.id_erro[ll_Row] = ps_status
	
End If	

Return True
end function

public function boolean of_retorno_produto_valor_receber (string ps_valor);
Long ll_Row

ll_Row = This.ds_Retorno.RowCount()

If ll_Row > 0 Then
	If This.ds_Retorno.object.vl_receber[ll_Row] = 0 Then
		This.ds_Retorno.object.vl_receber[ll_Row] = Dec(ps_valor)/100
	End If	
End If	

Return True
end function

public function boolean of_grava_venda_pbm (long al_filial, long al_notafiscal, string as_especie, string as_serie, long al_ecf, long al_cupom, datetime adh_movimento, decimal adc_valor_venda);
If IsNull(This.Id_Status) or Sitef.PharmaSystem.Id_Status <> "00" Then Return True

Long   ll_convenio

String ls_autorizacao
String ls_convenio_pbm
String ls_cartao
String ls_ecf
String ls_cupom
String ls_comprovante

ls_ecf      = String(al_Ecf,'000')
ls_cupom    = String(al_Cupom,'000000')

ll_convenio     = 53545

ls_autorizacao  = This.nr_Autorizacao
If Trim(Sitef.nr_Cartao) = '' Or Isnull(Sitef.nr_Cartao) Then
	ls_cartao       = Sitef.nr_cpf_cgc
Else
	ls_cartao       = Sitef.nr_Cartao
End If

ls_comprovante  = String(al_notafiscal,'00000000')
ls_convenio_pbm = LeftA(This.nm_Empresa,20)
//ls_convenio_pbm = This.nm_Operadora

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

If Sqlca.Sqlcode = -1 Then
	Sqlca.of_RollBack()
	Sqlca.of_MsgDBError("Venda PBM PharmaSystem.")	
	Return False
End If

If Not This.of_grava_venda_pbm_produto(al_filial,al_notafiscal,as_especie,as_serie,ll_convenio) Then Return False
		   
Return True
end function

public subroutine of_inicializa ();
SetNull(This.Id_Status)

This.ivl_Produtos = 0
This.ivl_Enviados = 0

This.qt_Dependentes = 0

This.vl_Saldo = 000.00
//This.vl_Total_Nota = 000.00

SetNull(This.nr_Autorizacao)
SetNull(This.nm_Conveniado)
SetNull(This.nm_Operadora)
SetNull(This.nm_Empresa)

SetNull(This.cd_Dependente)
SetNull(This.nm_Dependente)




end subroutine

public function boolean of_grava_venda_pbm_produto (long al_filial, long al_nota_fiscal, string as_especie, string as_serie, long al_convenio);
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

For ll_row = 1 To Sitef.PharmaSystem.ds_Autorizacao.RowCount()
	
	ls_Status         = This.ds_Autorizacao.object.id_Erro           [ll_row]
	
	If ls_Status <> "00" Then Continue
				
	ll_produto        = This.ds_Autorizacao.object.cd_produto        [ll_row]
	ll_quantidade     = This.ds_Autorizacao.object.qt_autorizada     [ll_row]
	ldc_prc_maximo    = This.ds_Autorizacao.object.vl_preco_bruto    [ll_row]
//	ldc_prc_praticado = This.ds_Autorizacao.object.vl_preco_loja     [ll_row]
	ldc_prc_praticado = This.ds_Autorizacao.object.vl_preco_liquido [ll_row]
	ldc_prc_avista    = This.ds_Autorizacao.object.vl_preco_liquido   [ll_row]
	ldc_subisidio     = 000.00
	ldc_reposicao     = 000.00
		
	ldc_reembolso     = ldc_prc_maximo - ldc_prc_avista
	
	ldc_reembolso_total += ldc_reembolso
	//ldc_reembolso_total += ( ldc_reembolso * ll_quantidade )
	
	ll_seq 		= This.ds_Autorizacao.object.nr_sequencial		[ll_row]
	
	If IsNull(ldc_prc_maximo) 		Then ldc_prc_maximo 		= 000.00
	If IsNull(ldc_prc_praticado) 	Then ldc_prc_praticado 	= 000.00
	If IsNull(ldc_prc_avista) 		Then ldc_prc_avista 		= 000.00
	If IsNull(ldc_subisidio) 		Then ldc_subisidio 		= 000.00
	If IsNull(ldc_reposicao) 		Then ldc_reposicao 		= 000.00
	If IsNull(ldc_reembolso)		Then ldc_reembolso 		= 000.00

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
				 
	If Sqlca.Sqlcode = -1 Then
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
   
If Sqlca.Sqlcode = -1 Then
	Sqlca.of_RollBack()
	Sqlca.of_MsgDBError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o Venda PBM - Reembolso.")
	Return False
End If		 

Return True
end function

public function boolean of_produto_autorizacao (long pl_produto, string ps_descricao, string ps_barras, long pl_quantidade, decimal pdc_preco_unitario, decimal pdc_preco_praticado, decimal pdc_desconto_loja, long pl_sequencial);
Long ll_Row
Long ll_Find
Long ll_Quantidade

Decimal {2} ldc_Preco_Liquido

If IsNull(pl_Produto) or pl_Produto = 0 Then Return True

ll_find = This.ds_autorizacao.Find('cd_produto = ' + String(pl_produto) ,1, This.ds_autorizacao.RowCount())

If ll_find > 0 Then
	
	ll_Quantidade  = This.ds_autorizacao.object.qt_vendida[ll_find]
	ll_Quantidade += pl_quantidade
	
	This.ds_autorizacao.object.qt_vendida[ll_find] = ll_Quantidade 

ElseIf ll_find = 0 Then

	ll_Row = This.ds_autorizacao.InsertRow(0)
	
	//Preco Liquido Calculado
	ldc_Preco_Liquido = pdc_preco_unitario - Round( pdc_preco_unitario * ( pdc_desconto_loja / 100),2)
	
	This.ds_autorizacao.object.cd_produto 		 	[ll_Row] = pl_produto
	This.ds_autorizacao.object.nm_produto 		 	[ll_Row] = ps_descricao
	This.ds_autorizacao.object.de_codigo_barras 	[ll_Row] = LeftA(ps_barras+Space(13),13)
	This.ds_autorizacao.object.qt_vendida		 	[ll_Row] = pl_quantidade
	This.ds_autorizacao.object.vl_preco_bruto	 	[ll_Row] = pdc_preco_unitario
	This.ds_autorizacao.object.vl_preco_loja     [ll_Row] = ldc_Preco_Liquido
	This.ds_autorizacao.object.pc_desconto_loja  [ll_Row] = pdc_desconto_loja
	This.ds_autorizacao.object.pc_desconto_pbm  	[ll_Row] = 000.00
	This.ds_autorizacao.object.vl_preco_pbm  		[ll_Row] = 000.00
	This.ds_autorizacao.object.vl_receber			[ll_Row] = 000.00
	This.ds_autorizacao.object.nr_sequencial		[ll_Row] = pl_sequencial
	
	This.ivl_Produtos ++
	
Else
	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no find",StopSign!)
	
	Return False
	
End If	

Return True
end function

on uo_pharmasystem.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_pharmasystem.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ds_autorizacao = Create dc_uo_ds_base
ds_retorno     = Create dc_uo_ds_base

end event

event destructor;Destroy(ds_autorizacao)
Destroy(ds_retorno)

end event

