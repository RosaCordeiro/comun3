HA$PBExportHeader$uo_ge498_pedido_disque_entrega.sru
forward
global type uo_ge498_pedido_disque_entrega from nonvisualobject
end type
end forward

global type uo_ge498_pedido_disque_entrega from nonvisualobject
end type
global uo_ge498_pedido_disque_entrega uo_ge498_pedido_disque_entrega

type variables
uo_convenio   	 	 				io_convenio						// 
uo_conveniado						io_conveniado					//
uo_condicao_venda_convenio 	io_Condicao_Convenio		//

String cd_cliente
String id_tipo_venda
String cd_conveniado
String nm_cliente
String cd_cliente_dependente
String nm_convenio
String nm_conveniado
String nm_condicao_convenio
String nr_cartao_saude_desconto

String nr_matricula_operador
String nr_matricula_vendedor
String id_situacao
String cd_forma_pagamento
String nr_matric_alteracao_preco
String nr_matric_alteracao_frete
String id_restricao_produto
String id_restricao_grupo
String id_considera_desconto

String nr_matric_liberacao_bloqueio
String nr_matric_liberacao_Restricao
String de_dados_adicionais

Datetime dh_entrega_marcada

String de_endereco_entrega
String de_referencia_entrega
String de_bairro_entrega
String nr_telefone_entrega
String nm_cliente_entrega
String nr_cep_entrega
String nm_cidade_entrega
String cd_uf_entrega
String de_complemento_endereco
String nr_endereco_entrega

String nr_cartao_saude //Desconto Plano de Sa$$HEX1$$fa00$$ENDHEX$$de , ex: unimed

Long cd_convenio
Long cd_condicao_convenio

Integer cd_condicao_crediario
Integer nr_parcelas_clube_prazo

Boolean id_alteracao_pedido

Long nr_pedido
Long cd_filial

Decimal{2} pc_desconto_minimo_convenio
Decimal{2} idc_Total_Produtos, &
				idc_Pc_Desconto, &
				idc_Total_Pedido, &
				idc_Frete, &
				idc_Vl_Cobrar, &
				idc_Vl_Pago, &
				idc_Frete_Calculado,&
				idc_Valor_Pago_aVista



dc_uo_ds_base ids_itens
dc_uo_ds_base ids_Pagamento
dc_uo_ds_base ids_Contratos_Bin //Contratos desconto sa$$HEX1$$fa00$$ENDHEX$$de
end variables

forward prototypes
public function boolean of_grava_itens (long al_pedido)
public function boolean of_proximo_sequencial_pedido (ref long al_pedido)
public function boolean of_grava_pedido ()
public function boolean of_grava_cabecalho (long al_pedido)
public function boolean of_grava_forma_pagamento (long al_pedido)
public subroutine of_inicializa ()
end prototypes

public function boolean of_grava_itens (long al_pedido);Long ll_Row, ll_Linhas
Long ll_Produto, ll_Qtde
Long ll_Requisicao_manip, ll_Promocao_sos, ll_Promocao_Vinculada, ll_Campanha, ll_Cd_Desconto_Extra
Long ll_Convenio_Saude, ll_Contrato

Integer li_Sequencial_item = 0

Decimal{2} ldc_Preco_UN, ldc_PC_Desconto_Tabela, ldc_Preco_Praticado
Decimal{2} ldc_Pc_desconto

String ls_Id_alteracao_preco, ls_Tipo_Desconto, ls_id_usado_vinculada, ls_Etiqueta_prestes
String ls_Vale_Desconto

Try
	
	if this.id_alteracao_pedido = True Then
		
		Delete from pedido_disque_entrega_produto
		where cd_filial = :this.cd_filial
			and nr_pedido_disque = :this.nr_pedido
			Using SQLCA;
			
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_Rollback()
			SqlCa.of_MsgDbError("Erro ao excluir os produtos do pedido: " +String( this.nr_pedido ))
			Return False
		End If	
		
	end if
	
	ll_Linhas = ids_Itens.RowCount()
	
	For ll_Row = 1 To ll_Linhas
		li_Sequencial_item++	
		
		ll_Produto 						= This.ids_Itens.Object.cd_produto			[ ll_row ]
		ll_Qtde							= This.ids_Itens.Object.qt_pedida				[ ll_row ]
		ldc_Preco_UN 					= This.ids_Itens.Object.vl_preco_unitario	[ ll_row ]
		ldc_PC_Desconto				= This.ids_Itens.Object.pc_desconto			[ ll_row ]
		ldc_PC_Desconto_Tabela 	= This.ids_Itens.Object.pc_desconto_tabela	[ ll_row ]
		ldc_Preco_Praticado			= This.ids_Itens.Object.vl_preco_praticado	[ ll_row ]
		ls_Id_alteracao_preco		= This.ids_Itens.Object.id_alteracao_preco	[ ll_row ]
		ls_Tipo_Desconto				= This.ids_Itens.Object.id_tipo_desconto		[ ll_row ]
		
		ll_Promocao_SOS				= This.ids_Itens.Object.cd_promocao_sos	[ ll_row ]
		ll_Campanha					= This.ids_Itens.Object.nr_campanha			[ ll_row ]
		ls_Vale_Desconto				= This.ids_Itens.Object.nr_vale_desconto	[ ll_row ]
		
		ll_Requisicao_manip			= This.ids_Itens.Object.nr_requisicao_manip		[ ll_row ]
		ll_Cd_Desconto_Extra			= This.ids_Itens.Object.cd_desconto_extra			[ ll_row ]
		ll_Promocao_Vinculada		= This.ids_Itens.Object.cd_promocao_vinculada	[ ll_row ]
		ll_Convenio_Saude			= This.ids_Itens.Object.cd_convenio_saude			[ ll_row ]
		ll_Contrato						= This.ids_Itens.Object.nr_contrato					[ ll_row ]
		
		If IsNull( ll_Produto ) Then Continue
		
		If ll_Promocao_SOS 			= 0 Then SetNull(ll_Promocao_SOS)
		If ll_Campanha					= 0 Then SetNull(ll_Campanha)
		If Trim(ls_Vale_Desconto)	= '' Then SetNull(ls_Vale_Desconto)
		If ll_Requisicao_manip		= 0 Then SetNull(ll_Requisicao_manip)
		If ll_Cd_Desconto_Extra 		= 0 Then SetNull(ll_Cd_Desconto_Extra)
		If ll_Promocao_Vinculada 	= 0 Then SetNull(ll_Promocao_Vinculada)
		If ll_Convenio_Saude		 	= 0 Then SetNull(ll_Convenio_Saude)		
		If ll_Contrato				 	= 0 Then SetNull(ll_Contrato)		
		
		INSERT INTO pedido_disque_entrega_produto(
				cd_filial,   
				nr_pedido_disque,   
				nr_sequencial,   
				cd_produto,
				qt_pedida,   
				vl_preco_unitario,    
				pc_desconto,   
				vl_preco_praticado,   
				nr_requisicao_manip,   
				id_alteracao_preco,   
				cd_promocao_sos,   
				nr_campanha,   
				cd_desconto_extra,   
				id_tipo_desconto,   
				pc_desconto_tabela,   
				nr_etiqueta_prestes,   
				cd_convenio_saude,   
				nr_contrato,   
				id_usado_vinculada,   
				cd_promocao_vinculada,
				nr_vale_desconto)
			Values (
				dbo.uf_filial_parametro(),
				:al_pedido,
				:li_Sequencial_item,
				:ll_Produto,
				:ll_Qtde,
				:ldc_Preco_UN,
				:ldc_PC_Desconto,
				:ldc_Preco_Praticado,
				:ll_Requisicao_manip,   
				:ls_Id_alteracao_preco,
				:ll_Promocao_sos,   
				:ll_Campanha,   
				:ll_Cd_Desconto_Extra,   
				:ls_Tipo_Desconto,   
				:ldc_Pc_Desconto_Tabela,   
				:ls_Etiqueta_prestes,   
				:ll_Convenio_Saude,   
				:ll_Contrato,   
				:ls_id_usado_vinculada,   
				:ll_Promocao_Vinculada,
				:ls_Vale_Desconto
				)
			Using SqlCa;
			
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_Rollback()
			SqlCa.of_MsgDbError("Erro ao inserir o produto: " +String( ll_Produto ))
			Return False
		End If	
	Next
	
	Return True	
Finally

End Try
end function

public function boolean of_proximo_sequencial_pedido (ref long al_pedido);select nextval('dbo.pedido_disque_entrega_nr_pedido_disque_seq')
Into :al_Pedido
From parametro 
where id_parametro = '1'
Using SQLCa;

If IsNull(al_Pedido) Then al_Pedido = 1
	
If SQLCa.SQLCode = -1 Then
	SQLCa.Of_Rollback( )
	SQLCa.Of_Msgdberror( "Erro ao localizar o seq. do pedido." )
	Return False
End If

Return True
end function

public function boolean of_grava_pedido ();Boolean lb_Sucesso = False

Long ll_Pedido


Try
	lb_Sucesso = False
	
	if this.nr_pedido = 0 or isnull(this.nr_pedido) Then
		//Pedido novo
		If Not This.of_proximo_sequencial_pedido( Ref ll_Pedido ) Then return false
		id_alteracao_pedido = false
	else
		//Pedido j$$HEX1$$e100$$ENDHEX$$ existe
		id_alteracao_pedido = True
		ll_pedido = this.nr_pedido
	end if
			
	If This.of_grava_cabecalho( ll_Pedido ) Then
		If This.of_grava_itens( ll_Pedido ) Then
			If of_grava_forma_pagamento( ll_Pedido ) Then
				lb_Sucesso = True	
			End If
		End If
	End If
	
	Return lb_Sucesso
	
Finally
	If lb_Sucesso Then
		SqlCa.of_Commit()
	Else
		SqlCa.of_Rollback()
	End If	
End Try
end function

public function boolean of_grava_cabecalho (long al_pedido);Try
		
	if id_alteracao_pedido = False Then	

		Insert into pedido_disque_entrega 
			 (cd_filial,
			  nr_pedido_disque,
			  dh_emissao,
			  vl_total_produtos,
			  pc_desconto,
			  vl_total_pedido,
			  vl_taxa_entrega,
			  vl_taxa_entrega_calculada,
			  vl_cobrar, 
			  vl_pago,
			  id_situacao,
			  nr_matricula_vendedor,
			  nr_matricula_operador,
			  cd_cliente,
			  id_tipo_venda,
			  nr_matric_alteracao_frete,
			  nr_matric_alteracao_preco,
			  cd_conveniado,
			  nr_matric_liberacao_bloqueio,
			  nr_matric_liberacao_restricao,
			  nr_cartao_desconto,
			  de_dados_adicionais,
			  dh_entrega_marcada,   
				de_endereco_entrega,   
				de_referencia_entrega,   
				de_bairro_entrega,   
				nr_telefone_entrega,   
				nm_cliente_entrega,   
				nr_cep_entrega,   
				nm_cidade_entrega,   
				cd_uf_entrega,   
				de_complemento_endereco,   
				nr_endereco_entrega  
			  )
			Values(
			  dbo.uf_filial_parametro(),
			  :al_Pedido,
			  getDate(),
			  :This.idc_total_produtos,
			  :This.idc_Pc_Desconto,
			  :This.idc_Total_Pedido,
			  :This.idc_Frete,
			  :This.idc_Frete_Calculado,
			  :This.idc_vl_cobrar, 
			  :This.idc_vl_pago,
			  :This.id_situacao,
			  :This.nr_matricula_vendedor,
			  :This.nr_matricula_operador,
			  :This.cd_cliente,
			  :This.id_tipo_venda,
			  :This.nr_matric_alteracao_frete,
			  :This.nr_matric_alteracao_preco,
			  :This.cd_conveniado,
			  :This.nr_matric_liberacao_bloqueio,
			  :This.nr_matric_liberacao_Restricao,
			  :This.nr_cartao_saude, 					//nr_cartao_desconto
			  :This.de_dados_adicionais,
			  :This.dh_entrega_marcada,   
				:This.de_endereco_entrega,   
				:This.de_referencia_entrega,   
				:This.de_bairro_entrega,   
				:This.nr_telefone_entrega,   
				:This.nm_cliente_entrega,   
				:This.nr_cep_entrega,   
				:This.nm_cidade_entrega,   
				:This.cd_uf_entrega,   
				:This.de_complemento_endereco,   
				:This.nr_endereco_entrega  
			)
		Using SqlCa;
			
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_Rollback()
			SqlCa.of_MsgDbError("Erro ao incluir o pedido.")
			Return False
		End If
		
	else
		
		Update pedido_disque_entrega
		set vl_total_produtos 					= :This.idc_total_produtos,
			pc_desconto 							= :This.idc_Pc_Desconto,
			vl_total_pedido 						= :This.idc_Total_Pedido,
			vl_taxa_entrega 						= :This.idc_Frete,
			vl_taxa_entrega_calculada 		= :This.idc_Frete_Calculado,
			vl_cobrar 								= :This.idc_vl_cobrar, 
			vl_pago 									= :This.idc_vl_pago,
			id_situacao 							= :This.id_situacao,
			nr_matricula_vendedor 			= :This.nr_matricula_vendedor,
			nr_matricula_operador 				= :This.nr_matricula_operador,
			cd_cliente 								= :This.cd_cliente,
			id_tipo_venda 						= :This.id_tipo_venda,
			nr_matric_alteracao_frete 			= :This.nr_matric_alteracao_frete,
			nr_matric_alteracao_preco 		= :This.nr_matric_alteracao_preco,
			cd_conveniado 						= :This.cd_conveniado,
			nr_matric_liberacao_bloqueio 	= :This.nr_matric_liberacao_bloqueio,
			nr_matric_liberacao_restricao 	= :This.nr_matric_liberacao_Restricao,
			nr_cartao_desconto 					= :This.nr_cartao_saude, 
			de_dados_adicionais 				= :This.de_dados_adicionais,
			dh_entrega_marcada				= :This.dh_entrega_marcada,   
			de_endereco_entrega 				= :This.de_endereco_entrega,   
			de_referencia_entrega 				= :This.de_referencia_entrega,   
			de_bairro_entrega 					= :This.de_bairro_entrega,   
			nr_telefone_entrega 				= :This.nr_telefone_entrega,   
			nm_cliente_entrega 					= :This.nm_cliente_entrega,   
			nr_cep_entrega 						= :This.nr_cep_entrega, 
			nm_cidade_entrega 					= :This.nm_cidade_entrega,    
			cd_uf_entrega 						= :This.cd_uf_entrega,    
			de_complemento_endereco 		= :This.de_complemento_endereco,    
			nr_endereco_entrega  				= :This.nr_endereco_entrega 
		where cd_filial = :this.cd_filial
			and nr_pedido_disque = :this.nr_pedido
			Using SQLCA;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_Rollback()
			SqlCa.of_MsgDbError("Erro ao atualizar o pedido.")
			Return False
		End If
		
	end if
	
	Return True	
Finally

End Try
end function

public function boolean of_grava_forma_pagamento (long al_pedido);Long ll_Row, ll_Linhas, ll_Convenio, ll_Condicao_Convenio, ll_Condicao_Crediario

String ls_Forma_Pagamento

Integer li_Sequencial = 0, li_Parcelas_Cartao, li_Parcelas_Clube

Decimal{2} ldc_Pagamento

Try
	
	if this.id_alteracao_pedido = True Then
		
		Delete from pedido_disque_entrega_pagamento
		where cd_filial = :this.cd_filial
			and nr_pedido_disque = :this.nr_pedido
			Using SQLCA;
			
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_Rollback()
			SqlCa.of_MsgDbError("Erro ao excluir os dados de pagamento do pedido: " +String( this.nr_pedido ))
			Return False
		End If	
		
	end if
	
	SetNull(li_Parcelas_Cartao)
	ll_Linhas = This.ids_Pagamento.RowCount()
	
	If This.id_tipo_venda <> 'AV' Then //Insere o tipo de pagamento padr$$HEX1$$e300$$ENDHEX$$o
		ll_Row = This.ids_Pagamento.InsertRow(0)
		
		If IsNull(This.idc_Valor_Pago_aVista) Then This.idc_Valor_Pago_aVista = 0
		
		This.ids_Pagamento.Object.cd_forma_pagamento		[ ll_row ] = This.id_tipo_venda
		This.ids_Pagamento.Object.vl_pagamento				[ ll_row ] = This.idc_total_pedido - This.idc_Valor_Pago_aVista
		This.ids_Pagamento.Object.nr_parcelas_cartao		[ ll_row ] = li_Parcelas_Cartao
		This.ids_Pagamento.Object.cd_convenio					[ ll_row ] = This.cd_convenio
		This.ids_Pagamento.Object.cd_condicao_convenio		[ ll_row ] = This.cd_condicao_convenio
		This.ids_Pagamento.Object.cd_condicao_crediario		[ ll_row ] = This.cd_condicao_crediario
		This.ids_Pagamento.Object.nr_parcelas_clube_prazo	[ ll_row ] = This.nr_parcelas_clube_prazo
		This.ids_Pagamento.Object.nr_sequencial				[ ll_row ] = 0 //Usado apenas p/gravar esse registro por primeiro
	End If
	
	This.ids_Pagamento.SetSort('nr_sequencial')
	This.ids_Pagamento.Sort()
	
	ll_Linhas = This.ids_Pagamento.RowCount()

	For ll_Row = 1 To ll_Linhas		
		ls_Forma_Pagamento	= This.ids_Pagamento.Object.cd_forma_pagamento		[ ll_row ]
		ldc_Pagamento			= This.ids_Pagamento.Object.vl_pagamento				[ ll_row ]
		ll_Convenio				= This.ids_Pagamento.Object.cd_convenio					[ ll_row ]
		ll_Condicao_Convenio	= This.ids_Pagamento.Object.cd_condicao_convenio		[ ll_row ]
		ll_Condicao_Crediario	= This.ids_Pagamento.Object.cd_condicao_crediario		[ ll_row ]
		li_Parcelas_Cartao		= This.ids_Pagamento.Object.nr_parcelas_cartao			[ ll_row ]
		li_Parcelas_Clube		= This.ids_Pagamento.Object.nr_parcelas_clube_prazo	[ ll_row ]
		
		If IsNull( ls_Forma_Pagamento ) Then Continue
		
		li_Sequencial++
				
		INSERT INTO pedido_disque_entrega_pagamento(
				cd_filial,   
				nr_pedido_disque,   
				nr_sequencial,   
				cd_forma_pagamento,
				vl_pagamento,   
				nr_parcelas_cartao,
				cd_convenio,    
				cd_condicao_convenio,   
				cd_condicao_crediario,
				nr_parcelas_clube_prazo
			)
			Values (
				dbo.uf_filial_parametro(),
				:al_pedido,
				:li_Sequencial,
				:ls_Forma_Pagamento,
				:ldc_Pagamento,
				:li_Parcelas_Cartao,
				:ll_Convenio,
				:ll_Condicao_Convenio,
				:ll_Condicao_Crediario,
				:li_Parcelas_Clube
				)
			Using SqlCa;
			
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_Rollback()
			SqlCa.of_MsgDbError("Erro ao inserir a forma de pagamento: " +ls_Forma_Pagamento)
			Return False
		End If	
	Next
	
	Return True	
Finally

End Try
end function

public subroutine of_inicializa ();id_alteracao_pedido = False

ids_itens.Reset()
ids_Pagamento.Reset()

SetNull(This.cd_cliente)
SetNull(This.id_tipo_venda)
SetNull(This.cd_conveniado)
SetNull(This.nm_cliente)
SetNull(This.cd_cliente_dependente)
SetNull(This.nm_convenio)
SetNull(This.nm_conveniado)
SetNull(This.nm_condicao_convenio)
SetNull(This.nr_cartao_saude_desconto)

SetNull(This.nr_matricula_operador)
SetNull(This.nr_matricula_vendedor)
SetNull(This.id_situacao)
SetNull(This.cd_forma_pagamento)
SetNull(This.nr_matric_alteracao_preco)
SetNull(This.nr_matric_alteracao_frete)
SetNull(This.id_restricao_produto)
SetNull(This.id_restricao_grupo)
SetNull(This.id_considera_desconto)

SetNull(This.nr_matric_liberacao_bloqueio)
SetNull(This.nr_matric_liberacao_Restricao)

SetNull(This.cd_convenio)
SetNull(This.cd_condicao_convenio)

SetNull(This.cd_condicao_crediario)
SetNull(This.nr_parcelas_clube_prazo)

SetNull(This.nr_pedido)
SetNull(This.cd_filial)

pc_desconto_minimo_convenio = 0.00
idc_Total_Produtos			= 0.00
idc_Pc_Desconto				= 0.00
idc_Total_Pedido			= 0.00
idc_Frete					= 0.00
idc_Vl_Cobrar				= 0.00
idc_Vl_Pago					= 0.00
idc_Frete_Calculado			= 0.00
end subroutine

on uo_ge498_pedido_disque_entrega.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge498_pedido_disque_entrega.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ids_Itens = Create dc_uo_ds_base

If Not This.ids_Itens.of_ChangeDataObject( "dw_ge498_lista_produtos" ) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro of_ChangeDataObject 'dw_ge498_lista_produtos'. Evento Constructor()")
	Return -1
End If

ids_Pagamento = Create dc_uo_ds_base

If Not This.ids_Pagamento.of_ChangeDataObject("dw_ge498_multiplas_formas_pagamento" ) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro of_ChangeDataObject 'dw_ge498_multiplas_formas_pagamento'. Evento Constructor()")
	Return -1
End If

ids_Contratos_Bin = Create dc_uo_ds_base

If Not This.ids_Contratos_Bin.of_ChangeDataObject("ds_ge004_contratos_ativos" ) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro of_ChangeDataObject 'ds_ge004_contratos_ativos'. Evento Constructor()" )
	Return -1
End If

This.of_Inicializa()
end event

event destructor;If IsValid(ids_itens) 			Then Destroy ids_itens
If IsValid(ids_Pagamento) 	Then Destroy ids_Pagamento
If IsValid(ids_Contratos_Bin) Then Destroy ids_Contratos_Bin

If IsValid( io_convenio ) 					Then Destroy io_convenio
If IsValid( io_conveniado ) 				Then Destroy io_conveniado
If IsValid( io_Condicao_Convenio ) 	Then Destroy io_Condicao_Convenio

end event

