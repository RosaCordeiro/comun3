HA$PBExportHeader$uo_ge251_licitacao_pedido.sru
forward
global type uo_ge251_licitacao_pedido from nonvisualobject
end type
end forward

global type uo_ge251_licitacao_pedido from nonvisualobject
event ue_post_open ( ref nonvisualobject avo_ro006_comum )
end type
global uo_ge251_licitacao_pedido uo_ge251_licitacao_pedido

type variables
Boolean	localizado

Long	nr_pedido, &
		nr_orcamento, &
		cd_filial_faturamento

DateTime	dh_licitacao, &
				dh_alteracao, &
				dh_cancelamento, &
				dh_prazo_entrega, &
				dh_orcamento, &
				dh_alteracao_orcamento
				
String	nr_matricula_inclusao, &
		nr_pedido_cliente, &
		nr_matricula_alteracao, &
		nr_matricula_cancelamento, &
		cd_cliente_entrega, &
		de_motivo_cancelamento, &
		nr_autorizacao, &
		id_situacao, &
		cd_cliente, &
		nm_cliente, &
		nm_razao_social, &
		cd_cidade_cliente, &
		uf_cliente, &
		cd_cliente_orcamento, &
		nr_matricula_inclusao_orcamento, &
		nr_matricula_alteracao_orcamento, &
		nr_cpf_cnpj, &
		nr_inscricao_estadual, &
		cd_tipo_cliente, &
		de_tipo_cliente
		
Decimal	vl_pedido
		
Integer cd_condicao_crediario

// Vari$$HEX1$$e100$$ENDHEX$$veis Pedido_Produto
Integer 	nr_item, &
			qt_pedida, &
			qt_faturada
			
Decimal	vl_preco_unitario, &
			pc_desconto,&
			vl_preco_total_produto
end variables

forward prototypes
public function boolean of_proximo_pedido (ref long pl_pedido)
public function boolean of_exclui_pedido (long pl_nr_pedido)
public function boolean of_exclui_pedido_produto (long pl_nr_pedido, long pl_cd_produto)
public function boolean of_exclui_item (long pl_nr_pedido, integer pi_nr_item)
public function boolean of_exclui_pedido_produto (long pl_nr_pedido)
public subroutine of_localiza_pedido (long pl_parametro)
public subroutine of_localiza_generico ()
public subroutine of_localiza_codigo (long pl_nr_pedido)
public subroutine of_carrega_dados_cliente ()
public subroutine of_carrega_dados_orcamento ()
public function boolean of_carrega_dados_pedido_produto (long pl_nr_pedido, long pl_cd_produto)
public function boolean of_atualiza_qtde_faturada (long pl_nr_pedido, long pl_cd_produto, long pl_qt_faturada)
public function boolean of_atualiza_pedido (long pl_nr_pedido, datetime pdh_dh_licitacao, long pl_nr_orcamento, string ps_nr_pedido_cliente, decimal pdc_vl_pedido, string ps_nr_matricula_alteracao, datetime pdth_dh_alteracao, string ps_cd_cliente_entrega, string ps_nr_autorizacao, date pdh_dh_prazo_entrega)
public function boolean of_insere_pedido (long pl_nr_pedido, datetime pdh_dh_licitacao, string ps_nr_matricula_inclusao, long pl_nr_orcamento, string ps_nr_pedido_cliente, decimal pdc_vl_pedido, string ps_cd_cliente_entrega, string ps_nr_autorizacao, date pdh_dh_prazo_entrega, string ps_id_situacao, string ps_id_orgao_publico)
public function boolean of_insere_pedido_produto (long pl_nr_pedido, integer pi_nr_item, long pl_cd_produto, long pl_qt_pedida, decimal pdc_vl_preco_unitario, decimal pdc_pc_desconto, decimal pdc_vl_total)
public function boolean of_atualiza_situacao_pedido (long pl_nr_pedido, string as_situacao, string as_chave_movimento_wms)
public function boolean of_atualiza_situacao_pedido (long pl_nr_pedido, string ps_chave_movimento_wms)
end prototypes

public function boolean of_proximo_pedido (ref long pl_pedido);Boolean lvb_Sucesso = True

Select max(nr_pedido)
Into :pl_Pedido
From licitacao_pedido
Using SqlCa;

Choose Case SqlCa.SqlCode 
	Case 0
		If IsNull(pl_Pedido) or pl_Pedido = 0 Then
			pl_Pedido = 1
		Else
			pl_Pedido ++			
		End If
	Case 100
		pl_Pedido = 1
	Case - 1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Pr$$HEX1$$f300$$ENDHEX$$ximo Pedido")
		lvb_Sucesso = False
End Choose

Return lvb_Sucesso
end function

public function boolean of_exclui_pedido (long pl_nr_pedido);Delete From licitacao_pedido
Where nr_pedido = :pl_Nr_Pedido
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Erro na exclus$$HEX1$$e300$$ENDHEX$$o do pedido[" + String(pl_Nr_Pedido) + "] na tabela licitacao_pedido - " + SqlCa.SqlErrText, StopSign!)
	Return False
End If

Return True
end function

public function boolean of_exclui_pedido_produto (long pl_nr_pedido, long pl_cd_produto);Delete From licitacao_pedido_produto
Where nr_pedido 	= :pl_Nr_Pedido
    and cd_produto	= :pl_Cd_Produto
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Erro na exclus$$HEX1$$e300$$ENDHEX$$o do produto [" + String(pl_Cd_Produto) + " no pedido[" + String(pl_Nr_Pedido) + "] na tabela licitacao_pedido_produto- " + SqlCa.SqlErrText, StopSign!)
	Return False
End If

Return True
end function

public function boolean of_exclui_item (long pl_nr_pedido, integer pi_nr_item);Delete From licitacao_pedido_produto
Where nr_pedido 	= :pl_Nr_Pedido
    and nr_item		= :pi_Nr_Item
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Erro na exclus$$HEX1$$e300$$ENDHEX$$o do item[" + String(pi_Nr_Item) + " no pedido[" + String(pl_Nr_Pedido) + "] na tabela licitacao_pedido_produto- " + SqlCa.SqlErrText, StopSign!)
	Return False
End If

Return True
end function

public function boolean of_exclui_pedido_produto (long pl_nr_pedido);Delete From licitacao_pedido_produto
Where nr_pedido 	= :pl_Nr_Pedido
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Erro na exclus$$HEX1$$e300$$ENDHEX$$o do pedido[" + String(pl_Nr_Pedido) + "] na tabela licitacao_pedido_produto- " + SqlCa.SqlErrText, StopSign!)
	Return False
End If

Return True
end function

public subroutine of_localiza_pedido (long pl_parametro);Integer lvi_Tamanho

lvi_Tamanho = LenA(String(pl_Parametro))

// Verifica se foi recebido algum par$$HEX1$$e200$$ENDHEX$$metro
If lvi_Tamanho > 0 Then
	
	// Verifica o tipo do par$$HEX1$$e200$$ENDHEX$$metro recebido
	If IsNumber(String(pl_Parametro)) Then

		// Localiza$$HEX2$$e700e300$$ENDHEX$$o direta pelo c$$HEX1$$f300$$ENDHEX$$digo da filial
		of_Localiza_Codigo(pl_Parametro)

		If Not Localizado Then
			// Se n$$HEX1$$e300$$ENDHEX$$o localizar pelos m$$HEX1$$e900$$ENDHEX$$todos anteriores
			// Abre a janela de localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica
			of_Localiza_Generico()	
		End If
	
	Else	
		// Localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica conforme o nome do cliente
		of_Localiza_Generico()
	End If
	
Else	
	// Localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica sem par$$HEX1$$e200$$ENDHEX$$metros
	of_Localiza_Generico()
End If
end subroutine

public subroutine of_localiza_generico ();Long lvl_Nr_Pedido

OpenWithParm(w_GE251_Selecao_Pedido, This)

lvl_Nr_Pedido = Long(Message.StringParm)

If Not IsNull(lvl_Nr_Pedido) Then
	of_Localiza_Codigo(lvl_Nr_Pedido)
Else
	Localizado = False
End If
end subroutine

public subroutine of_localiza_codigo (long pl_nr_pedido);Select 	nr_pedido, &
			dh_licitacao, &
			nr_matricula_inclusao, &
			nr_orcamento, &
			nr_pedido_cliente, &
			vl_pedido, &
			nr_matricula_alteracao, &
			dh_alteracao, &
			nr_matricula_cancelamento, &
			cd_cliente_entrega, &
			dh_cancelamento, &
			de_motivo_cancelamento, &
			nr_autorizacao, &
			dh_prazo_entrega, &
			coalesce(id_situacao, "A")
Into 	:nr_pedido, &
		:dh_licitacao, &
		:nr_matricula_inclusao, &
		:nr_orcamento, &
		:nr_pedido_cliente, &
		:vl_pedido, &
		:nr_matricula_alteracao, &
		:dh_alteracao, &
		:nr_matricula_cancelamento, &
		:cd_cliente_entrega, &
		:dh_cancelamento, &
		:de_motivo_cancelamento, &
		:nr_autorizacao, &
		:dh_prazo_entrega, &
		:id_situacao
From 	licitacao_pedido lp
Where lp.nr_pedido = :pl_Nr_Pedido
Using SqlCa;

Choose Case SqlCa.SqlCode 
	Case -1
		Sqlca.Of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Pedido.")
		Localizado = False
	Case 100
		Localizado = False
	Case Else
		Localizado = True
		
		This.of_Carrega_Dados_Cliente()
		This.of_Carrega_Dados_Orcamento()
End Choose
end subroutine

public subroutine of_carrega_dados_cliente ();Select cl.cd_cliente,
		cl.nm_cliente,
		cl.nm_razao_social,
		cl.cd_cidade,
		cd.cd_unidade_federacao, 
		cl.nr_cpf_cgc,
		cl.nr_inscricao_estadual,
		tc.cd_tipo_cliente,
		tc.de_tipo_cliente
Into 	:cd_cliente, &
		:nm_cliente, &
		:nm_razao_social, &
		:cd_cidade_cliente, &
		:uf_cliente,
		:nr_cpf_cnpj, &
		:nr_inscricao_estadual, &
		:cd_tipo_cliente, &
		:de_tipo_cliente
From cliente cl
Inner Join cidade cd
 on cd.cd_cidade = cl.cd_cidade
Left outer join tipo_cliente tc
 on tc.cd_tipo_cliente = cl.cd_tipo_cliente
Where cl.cd_cliente = :cd_cliente_entrega
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Erro ao carregar dados do cliente[" + Cd_Cliente_Entrega + "].", StopSign!)	
End If
		
end subroutine

public subroutine of_carrega_dados_orcamento ();Select lo.cd_cliente,
		lo.nr_matricula_inclusao,
		lo.dh_orcamento,
		lo.nr_matricula_alteracao, 
		lo.dh_alteracao,
		lo.cd_filial_faturamento,
		lo.cd_condicao_crediario
Into 	:cd_cliente_orcamento,
		:nr_matricula_inclusao_orcamento,
		:dh_orcamento,
		:nr_matricula_alteracao_orcamento,
		:dh_alteracao_orcamento,
		:cd_filial_faturamento,
		:cd_condicao_crediario
From licitacao_orcamento lo
Inner Join licitacao_pedido lp
 on lp.nr_orcamento = lo.nr_orcamento
Where lp.nr_pedido = :nr_pedido
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Erro ao carregar dados da tabela licitacao_orcamento[" + String(Nr_Pedido)+ "].", StopSign!)	
End If
		
end subroutine

public function boolean of_carrega_dados_pedido_produto (long pl_nr_pedido, long pl_cd_produto);Select lpp.nr_item, 
		lpp.qt_pedida,
		lpp.vl_preco_unitario,
		lpp.pc_desconto,
		lpp.qt_faturada,
		lpp.vl_total
Into :nr_item, &
		:qt_pedida, &
		:vl_preco_unitario, &
		:pc_desconto,
		:qt_faturada,
		:vl_preco_total_produto
From licitacao_pedido_produto lpp
Where lpp.nr_pedido = :pl_Nr_Pedido
   and lpp.cd_produto	= :pl_Cd_Produto
Using SqlCa;

Choose Case SqlCa.SqlCode 
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Erro ao carregar dados do Produto Pedido_Licita$$HEX2$$e700e300$$ENDHEX$$o [Produto:" + String(pl_Cd_Produto)+ " / Pedido:" + String(pl_Nr_Pedido) + "].", StopSign!)	
		Return False
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Produto Pedido_Licita$$HEX2$$e700e300$$ENDHEX$$o [Produto:" + String(pl_Cd_Produto)+ " / Pedido:" + String(pl_Nr_Pedido) + "], n$$HEX1$$e300$$ENDHEX$$o localizado.", Exclamation!)	
		Return False
End Choose

Return True
end function

public function boolean of_atualiza_qtde_faturada (long pl_nr_pedido, long pl_cd_produto, long pl_qt_faturada);Update licitacao_pedido_produto
  Set qt_faturada = coalesce(qt_faturada,0) + :pl_Qt_Faturada
 Where nr_pedido = :pl_Nr_Pedido
   and cd_produto 	= :pl_Cd_Produto
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o da quantidade faturada do produto [" + String(pl_Cd_Produto) + "] do pedido [" + String(pl_Nr_Pedido) + "].", StopSign!)
	Return False
End If

Return True
end function

public function boolean of_atualiza_pedido (long pl_nr_pedido, datetime pdh_dh_licitacao, long pl_nr_orcamento, string ps_nr_pedido_cliente, decimal pdc_vl_pedido, string ps_nr_matricula_alteracao, datetime pdth_dh_alteracao, string ps_cd_cliente_entrega, string ps_nr_autorizacao, date pdh_dh_prazo_entrega);Boolean lvb_Sucesso  = True

Update licitacao_pedido
     Set 	dh_licitacao 					= :pdh_Dh_Licitacao,
			nr_orcamento				= :pl_Nr_Orcamento,
  			nr_pedido_cliente 			= :ps_Nr_Pedido_Cliente,
  			vl_pedido					= :pdc_Vl_Pedido,
			nr_matricula_alteracao	= :ps_Nr_Matricula_Alteracao,
  			cd_cliente_entrega		= :ps_Cd_Cliente_Entrega,
  			nr_autorizacao				= :ps_Nr_Autorizacao,
			dh_prazo_entrega			= :pdh_Dh_Prazo_Entrega
Where nr_pedido = :pl_nr_Pedido
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Erro ao atualizar o pedido [" + String(pl_Nr_Pedido) + "] na tabela licitacao_pedido - " + SqlCa.SqlErrText, StopSign!)
	lvb_Sucesso = False
End If

Return lvb_Sucesso
end function

public function boolean of_insere_pedido (long pl_nr_pedido, datetime pdh_dh_licitacao, string ps_nr_matricula_inclusao, long pl_nr_orcamento, string ps_nr_pedido_cliente, decimal pdc_vl_pedido, string ps_cd_cliente_entrega, string ps_nr_autorizacao, date pdh_dh_prazo_entrega, string ps_id_situacao, string ps_id_orgao_publico);Boolean lvb_Sucesso  = True

Insert Into licitacao_pedido
 (nr_pedido, &
  dh_licitacao, &
  nr_matricula_inclusao, &
  nr_orcamento, &
  nr_pedido_cliente, &
  vl_pedido, &
  cd_cliente_entrega, &
  id_orgao_publico, &
  nr_autorizacao, &
  dh_prazo_entrega, &
  id_situacao
  )
Select :pl_Nr_Pedido, 
  		 :pdh_Dh_Licitacao,
  		 :ps_Nr_Matricula_Inclusao, 
  		 :pl_Nr_Orcamento, 
  		 :ps_Nr_Pedido_Cliente, 
  		 :pdc_Vl_Pedido,
  		 :ps_Cd_Cliente_Entrega,
		 :ps_Id_Orgao_Publico,
  		 :ps_Nr_Autorizacao,
  		 :pdh_Dh_Prazo_Entrega,
  		 :ps_Id_Situacao
From parametro
Where not exists (Select 1 
						From licitacao_pedido
					   Where nr_pedido = :pl_nr_Pedido)
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Erro ao inserir o pedido [" + String(pl_Nr_Pedido) + "] na tabela licitacao_pedido - " + SqlCa.SqlErrText, StopSign!)
	lvb_Sucesso = False
End If

Return lvb_Sucesso
end function

public function boolean of_insere_pedido_produto (long pl_nr_pedido, integer pi_nr_item, long pl_cd_produto, long pl_qt_pedida, decimal pdc_vl_preco_unitario, decimal pdc_pc_desconto, decimal pdc_vl_total);Boolean lvb_Sucesso  = True

Update licitacao_pedido_produto
   set cd_produto 			= :pl_Cd_Produto
		,qt_pedida			= :pl_Qt_Pedida
		,vl_preco_unitario 	= :pdc_VL_Preco_Unitario
		,pc_desconto		= :pdc_Pc_Desconto
		,vl_total				= :pdc_Vl_Total
Where nr_pedido	= :pl_Nr_Pedido
 	and nr_item		= :pi_Nr_Item
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do produto [" + String(pl_Cd_Produto) + "] - na tabela licitacao_pedido_produto - " + SqlCa.SqlErrText, StopSign!)
	lvb_Sucesso = False
End If

If SqlCa.SqlNRows = 0 Then
	Insert Into licitacao_pedido_produto
	 (nr_pedido, &
	  nr_item, &
	  cd_produto, &
	  qt_pedida, &
	  vl_preco_unitario, &
	  pc_desconto,&
	  vl_total
	 )
	Select :pl_Nr_Pedido, 
			 :pi_Nr_Item,
			 :pl_Cd_Produto,
			 :pl_Qt_Pedida, &
			 :pdc_VL_Preco_Unitario, &
			 :pdc_Pc_Desconto,&
			 :pdc_Vl_Total
	From parametro
	Where not exists (Select 1
							From licitacao_pedido_produto
						  Where nr_pedido 	= :pl_Nr_Pedido
								and nr_item		= :pi_Nr_Item)
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Erro na inclus$$HEX1$$e300$$ENDHEX$$o do produto [" + String(pl_Cd_Produto) + "] - na tabela licitacao_pedido_produto - " + SqlCa.SqlErrText, StopSign!)
		lvb_Sucesso = False
	End If
End If

Return lvb_Sucesso
end function

public function boolean of_atualiza_situacao_pedido (long pl_nr_pedido, string as_situacao, string as_chave_movimento_wms);If Not IsNull(as_chave_movimento_wms) and Trim(as_chave_movimento_wms) <> '' Then
	Update licitacao_pedido
	Set id_situacao = :as_situacao, cd_chave_movimento_wms = :as_chave_movimento_wms
	Where nr_pedido = :pl_Nr_Pedido
		and exists (Select 1 
						From licitacao_pedido_produto  lpp
					  Where lpp.nr_pedido = :pl_Nr_Pedido
					  Having sum(qt_faturada) = sum(qt_pedida) )
	Using SqlCa;
Else
	Update licitacao_pedido
	Set id_situacao = :as_situacao
	Where nr_pedido = :pl_Nr_Pedido
		and exists (Select 1 
						From licitacao_pedido_produto  lpp
					  Where lpp.nr_pedido = :pl_Nr_Pedido
					  Having sum(qt_faturada) = sum(qt_pedida) )
	Using SqlCa;
End If

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o da situa$$HEX2$$e700e300$$ENDHEX$$o do pedido [" + String(pl_Nr_Pedido) + "].", StopSign!)
	Return False
End If

Return True
end function

public function boolean of_atualiza_situacao_pedido (long pl_nr_pedido, string ps_chave_movimento_wms);Return of_atualiza_situacao_pedido( pl_nr_pedido, "F", ps_chave_movimento_wms)
end function

on uo_ge251_licitacao_pedido.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge251_licitacao_pedido.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

