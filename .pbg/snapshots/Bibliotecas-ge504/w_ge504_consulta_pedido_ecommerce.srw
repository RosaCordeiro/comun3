HA$PBExportHeader$w_ge504_consulta_pedido_ecommerce.srw
forward
global type w_ge504_consulta_pedido_ecommerce from dc_w_sheet
end type
type tab_1 from tab within w_ge504_consulta_pedido_ecommerce
end type
type tabpage_1 from userobject within tab_1
end type
type cb_reenviar_entrega from commandbutton within tabpage_1
end type
type cb_cancelar from commandbutton within tabpage_1
end type
type cb_refaturar from commandbutton within tabpage_1
end type
type cb_transportadora from commandbutton within tabpage_1
end type
type cb_pedido_entregue from commandbutton within tabpage_1
end type
type gb_2 from groupbox within tabpage_1
end type
type gb_1 from groupbox within tabpage_1
end type
type dw_1 from dc_uo_dw_base within tabpage_1
end type
type dw_2 from dc_uo_dw_base within tabpage_1
end type
type cb_etiqueta from commandbutton within tabpage_1
end type
type dw_5 from dc_uo_dw_base within tabpage_1
end type
type tabpage_1 from userobject within tab_1
cb_reenviar_entrega cb_reenviar_entrega
cb_cancelar cb_cancelar
cb_refaturar cb_refaturar
cb_transportadora cb_transportadora
cb_pedido_entregue cb_pedido_entregue
gb_2 gb_2
gb_1 gb_1
dw_1 dw_1
dw_2 dw_2
cb_etiqueta cb_etiqueta
dw_5 dw_5
end type
type tabpage_2 from userobject within tab_1
end type
type dw_3 from dc_uo_dw_base within tabpage_2
end type
type cb_endereco from commandbutton within tabpage_2
end type
type cb_link from commandbutton within tabpage_2
end type
type cb_historico from commandbutton within tabpage_2
end type
type gb_3 from groupbox within tabpage_2
end type
type cb_1 from commandbutton within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_3 dw_3
cb_endereco cb_endereco
cb_link cb_link
cb_historico cb_historico
gb_3 gb_3
cb_1 cb_1
end type
type tabpage_3 from userobject within tab_1
end type
type gb_4 from groupbox within tabpage_3
end type
type dw_4 from dc_uo_dw_base within tabpage_3
end type
type tabpage_3 from userobject within tab_1
gb_4 gb_4
dw_4 dw_4
end type
type tabpage_4 from userobject within tab_1
end type
type dw_6 from dc_uo_dw_base within tabpage_4
end type
type gb_5 from groupbox within tabpage_4
end type
type tabpage_4 from userobject within tab_1
dw_6 dw_6
gb_5 gb_5
end type
type tabpage_5 from userobject within tab_1
end type
type gb_6 from groupbox within tabpage_5
end type
type dw_7 from dc_uo_dw_base within tabpage_5
end type
type tabpage_5 from userobject within tab_1
gb_6 gb_6
dw_7 dw_7
end type
type tab_1 from tab within w_ge504_consulta_pedido_ecommerce
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
end type
type st_confirmar from statictext within w_ge504_consulta_pedido_ecommerce
end type
end forward

global type w_ge504_consulta_pedido_ecommerce from dc_w_sheet
integer width = 4709
integer height = 2276
string title = "GE504 - Consulta de Pedido"
long backcolor = 80269524
event ue_retrieve ( )
tab_1 tab_1
st_confirmar st_confirmar
end type
global w_ge504_consulta_pedido_ecommerce w_ge504_consulta_pedido_ecommerce

type variables
uo_cliente_central ivo_cliente_central
uo_filial ivo_filial

dc_uo_api	io_api	//GE040

//dc_uo_transacao itr_Filial

dc_uo_odbc	ivo_Odbc
uo_transacao_online ivo_Conecta_Odbc
dc_uo_transacao itr_Filial

String is_ODBC_Desenv
String ivs_Path_Correios = "https://portalpostal.com.br/sro.jsp?sro="
string	is_datasource
String	is_id_ecommerce = '2'

boolean ivb_Check

//uo_eCommerce_Vannon iuo_eCommerce_Vannon



end variables

forward prototypes
public subroutine wf_atualiza_valor ()
public function decimal wf_decimal (string ps_valor)
public function boolean wf_conecta_destino (long al_filial_destino)
public function boolean wf_localiza_pedido_drogaexpress (long al_pedido_ecommerce, ref string as_pedido)
public function date wf_data_inicio_9_digitos ()
public function boolean wf_proximo_nr_lancamento (string as_caixa, long al_controle, ref long al_nr_lancamento, ref uo_ge136_transacao_remota ptr_filial_destino)
public function boolean wf_cancela_comprovante_cartao (long al_cd_filial, string as_pedido_drogaexpress, string as_matricula)
public function boolean wf_conecta_filial (long pl_filial, ref string ps_log)
public function boolean wf_desconecta_filial ()
public function boolean wf_equilibrium_cancela_pedido (long pl_cd_filial, long pl_nr_pedido, string ps_nr_pedido, ref string ps_log)
public function boolean wf_insert_pedido_drogaexpress (string as_pedido, string as_pedido_novo, ref string as_log)
public function boolean wf_insert_produtos_drogaexpress (string ps_pedido, string ps_pedido_novo, ref string ps_log)
public function boolean wf_proximo_pedido_drogaexpress (long al_filial, ref string as_pedido_novo, ref string as_log)
public function boolean wf_equilibrium_reenviar_pedido (boolean pb_refaturamento, string ps_nr_pedido_novo)
public function boolean wf_alterar_mod_entrega (ref string ps_log)
public function boolean wf_verifica_capturado_vtex (string ps_url_conector, string ps_chave, string ps_token, string ps_id_transacao, ref boolean pb_capturado, ref string ps_nsu, ref string ps_autorizacao, ref datetime pdh_captura, ref string ps_log)
public function boolean wf_cancela_pedido ()
public function boolean wf_cancela_pedido_cr (string ps_id_ecommerce, string ps_nr_pedido_ecommerce, long pl_cd_filial, string ps_rede, ref string ps_log)
public function boolean wf_verifica_pedido_faturado (boolean pb_pdv_java, long pl_cd_filial, string ps_nr_pedido, long pl_nr_pedido, ref boolean pb_faturado, ref string ps_log)
public function boolean wf_busca_situacao_pedido (boolean pb_pdv_java, string ps_nr_pedido, long pl_cd_filial_ecommerce, long pl_nr_pedido, ref string ps_situacao, ref string ps_log)
public function boolean wf_cancela_pedido_vtex (long pl_cd_filial, long pl_cd_seller, long pl_cd_filial_ecommerce, long pl_nr_pedido, string ps_nr_pedido_ecommerce, string ps_rede, decimal pdc_vl_venda, string ps_motivo, ref boolean pb_capturado, ref string ps_log)
public function boolean wf_cancela_pedido_empurrado (string ps_usuario, string ps_motivo, ref string ps_log)
public function boolean wf_conecta_banco_java (integer al_filial, dc_uo_odbc ao_odbc, ref string as_erro, ref dc_uo_transacao ao_transacao)
public function boolean wf_verifica_cancelamento_pdv_novo (integer al_filial, long al_pedido, ref string as_motivo)
end prototypes

event ue_retrieve;Tab_1.TabPage_1.dw_2.Event ue_Retrieve()
end event

public subroutine wf_atualiza_valor ();Long lvl_Linha,&
	 lvl_Linhas
	 
String lvs_Valor
	 
lvl_Linhas = Tab_1.TabPage_1.dw_2.RowCount()

For lvl_Linha = 1 To lvl_Linhas
	
	lvs_Valor = Tab_1.TabPage_1.dw_2.Object.vl_recuperado[lvl_Linha]
	
	Tab_1.TabPage_1.dw_2.Object.vl_pedido[lvl_Linha] = wf_Decimal(lvs_Valor)

Next


	 

end subroutine

public function decimal wf_decimal (string ps_valor);Integer lvi_Pos

String lvs_Retorno

lvi_Pos = Pos(ps_Valor, '.')

lvs_Retorno = Trim(Left(ps_Valor, lvi_Pos - 1)) + ',' + Trim(Mid(ps_Valor, lvi_Pos + 1))

Return Dec(lvs_Retorno)
end function

public function boolean wf_conecta_destino (long al_filial_destino);//String ls_Odbc_Destino
//
//is_DataSource = gvo_Aplicacao.ivs_DataSource
//		 
//// Se estiver conectado desconecta
//If Destino.of_isConnected() Then Destino.of_Disconnect()
//
//ivo_Odbc.of_Atualiza_Odbcs( String(al_Filial_destino) )
//
//ls_Odbc_Destino = ivo_Odbc.of_Localiza(al_Filial_destino)
//
//Destino.of_Set_Erro_Saida_Padrao( 'LOG' )
//
////// Testa a conexao com o banco de dados da loja
////If Not ivo_ODBC.of_Connect( lvs_ODBC_Destino, 'teste_conexao', 'teste_conexao' ) Then
////	// Grava mensagem de erro no log e n$$HEX1$$e300$$ENDHEX$$o continua o processo
////	This.of_Grava_Arquivo( "[ERRO] Teste de conex$$HEX1$$e300$$ENDHEX$$o com a filial: " + String(al_Filial_Destino) + '~rGE226.uo_ecommerce_vannon.of_conecta_banco_filial_destino(long)', True )
////	Return False
////End If
//
//If Not Destino.of_Connect( ls_Odbc_Destino, "EC504_" + gvo_Aplicacao.of_UserId( ) ) Then
//	// Grava mensagem de erro no log e n$$HEX1$$e300$$ENDHEX$$o continua o processo
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "[ERRO] Conex$$HEX1$$e300$$ENDHEX$$o com a filial: " + String(al_Filial_Destino)  )
//	Return False
//End If
//
Return True
end function

public function boolean wf_localiza_pedido_drogaexpress (long al_pedido_ecommerce, ref string as_pedido);Select nr_pedido_drogaexpress
	INTO :as_Pedido
From pedido_drogaexpress
	Where nr_pedido_ecommerce = :al_pedido_ecommerce
	and id_situacao = 'M'
	and id_refaturado is null
	Limit 1
Using itr_filial;

Choose Case itr_filial.SqlCode
	Case 0
		Return True		
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Nenhum pedido drogaexpress localizado. Pedido ecommerce: " +String(al_pedido_ecommerce ) , Exclamation!)
		Return False
		
	Case -1
		itr_filial.of_MsgDbError("Erro ao localizar o pedido drogaexpress." )
		Return False
End Choose
end function

public function date wf_data_inicio_9_digitos ();String ls_valor

select vl_parametro
	into :ls_valor
	from parametro_geral
	where cd_parametro = 'DH_INICIO_9_DIGITOS_VANNON'
using sqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Erro na localizacao do parametro_geral DH_INICIO_9_DIGITOS_VANNON")
End If

Return Date(ls_valor)

end function

public function boolean wf_proximo_nr_lancamento (string as_caixa, long al_controle, ref long al_nr_lancamento, ref uo_ge136_transacao_remota ptr_filial_destino);
SELECT MAX(nr_lancamento)
  INTO :al_nr_lancamento
  FROM lancamento_caixa
 WHERE cd_caixa = :as_Caixa
   AND nr_controle_caixa = :al_Controle
Using ptr_filial_destino;

Choose Case SqlCa.SqlCode
	Case 0
		If IsNull(al_nr_lancamento) Then al_nr_lancamento = 0
		al_nr_lancamento ++
	Case 100
		al_nr_lancamento = 1
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Pr$$HEX1$$f300$$ENDHEX$$ximo Lan$$HEX1$$e700$$ENDHEX$$amento")
		Return False
End Choose

Return True
end function

public function boolean wf_cancela_comprovante_cartao (long al_cd_filial, string as_pedido_drogaexpress, string as_matricula);
Boolean lb_Sucesso = False

Date lvdt_Parametro

Datetime lvdt_Movimentacao, lvdt_emissao

Decimal {2} lvdc_total_pedido

String lvs_Historico, &
		 lvs_Caixa, &
	     lvs_Caixa_Incluir, &
		 lvs_Mensagem, &
		 lvs_Operador, &
		 lvs_Cancelado, &
		 lvs_cd_forma_pagamento, &
		 lvs_cd_estabelecimento , &
		 lvs_autorizacao_cartao, &
		 lvs_comprovante_cartao, &
		 lvs_de_historico

String ls_Pedido_Ecommerce

String ls_Situacao_DrogaExpress

Long lvl_Linha, &
	  lvl_Comprovante, &
	  lvl_Lancamento_Estornar, &
	  lvl_Lancamento_Incluir, &
	  lvl_Nr_Lancamento, &
	  lvl_Controle, &
	  lvl_Controle_Incluir, &
	  lvl_pedido_ecommerce, &
	  lvl_nr_sequencial
	  

Try	
	
	uo_ge136_transacao_remota lo_Filial_Destino
	gf_ge136_conecta_banco_filial( al_cd_filial, lo_Filial_Destino )	 
	
	//
	Select vl_total_pedido, cd_forma_pagamento, cd_estabelecimento_cartao_credito, 
				 nr_autorizacao_cartao_credito, nr_comprovante_cartao_credito, nr_pedido_ecommerce, dh_emissao, id_situacao
		Into :lvdc_total_pedido, :lvs_cd_forma_pagamento, :lvs_cd_estabelecimento, :lvs_autorizacao_cartao, 
			:lvs_comprovante_cartao, :lvl_pedido_ecommerce, :lvdt_emissao, :ls_Situacao_DrogaExpress
	  From pedido_drogaexpress
	Where cd_filial = :al_Cd_Filial
		 and nr_pedido_drogaexpress = :as_pedido_drogaexpress
	Using lo_Filial_Destino;
	
	If lo_Filial_Destino.SqlCode <> 0 Then
		lo_Filial_Destino.of_Rollback();
		lo_Filial_Destino.of_MsgdbError("Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o dos dados do Pedido Drogaexpress.")
		Return lb_Sucesso
	End If
	
	//
	update pedido_drogaexpress set id_situacao = 'X', nr_matricula_cancelamento = :as_matricula
		where nr_pedido_drogaexpress = :as_pedido_drogaexpress
	Using lo_Filial_Destino;
	
	If lo_Filial_Destino.SqlCode = -1 Then
		lo_Filial_Destino.of_Rollback();
		lo_Filial_Destino.of_msgdberror("Erro ao cancelar o pedido na filial.")
		Return lb_Sucesso
	End If
	
	//
	If lvdt_emissao < Datetime('01/07/2014 00:00:00') Then
		lb_Sucesso = True
		Return lb_Sucesso
	End If
	
	If lvs_cd_forma_pagamento <> 'CP' Then
		lb_Sucesso = True
		Return lb_Sucesso
	End If
		
	 Select cd_caixa, nr_controle_caixa, nr_sequencial, nr_lancamento_caixa, id_cancelamento
		 Into :lvs_Caixa, :lvl_Controle, :lvl_nr_sequencial, :lvl_Lancamento_Estornar, :lvs_Cancelado
		from cartao_comprovante_venda
	Where nr_autorizacao 			= :lvs_autorizacao_cartao
		 and nr_nsu 			 		= :lvs_comprovante_cartao
		 and cd_estabelecimento 	= :lvs_cd_estabelecimento
	Using lo_Filial_Destino;
	
	ls_Pedido_Ecommerce = String( lvl_pedido_ecommerce)
	
	If lvs_Cancelado = 'S' Then
		If ls_Situacao_DrogaExpress = 'F' or ls_Situacao_DrogaExpress = 'D' Then //Cancelamento do comprovante feito pelo Retaguarda. Pedido Faturado = Adiantamento j$$HEX1$$e100$$ENDHEX$$ estornado.
			lb_Sucesso = True
			Return lb_Sucesso
		End If
	End If
	
	If lo_Filial_Destino.SqlCode <> 0 Then
		lo_Filial_Destino.of_Rollback();
		lo_Filial_Destino.of_MsgdbError("Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o dos dados do Comprovante do Cart$$HEX1$$e300$$ENDHEX$$o")
		Return lb_Sucesso
	End If
	
	SELECT MAX(nr_controle_caixa)
	  INTO :lvl_Controle_Incluir
	  FROM controle_caixa
	 WHERE cd_caixa 			= :lvs_Caixa
		AND dh_conferencia 	IS NULL
	Using lo_Filial_Destino;
	
	If (lo_Filial_Destino.SqlCode <> 0) Then
		lo_Filial_Destino.of_Rollback();
		lo_Filial_Destino.of_MsgdbError("Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o dos caixas abertos.")
		Return lb_Sucesso
	End If
	
	If lvl_Controle_Incluir <=0 or IsNull(lvl_Controle_Incluir) Then
		lo_Filial_Destino.of_Rollback();
		lo_Filial_Destino.of_MsgdbError("Nenhum caixa aberto encontrado.")
		Return lb_Sucesso
	End If
		
	// Grava lan$$HEX1$$e700$$ENDHEX$$amento de estorno na conta de adiantamento caso ainda n$$HEX1$$e300$$ENDHEX$$o tenha sido faturado
	If ls_Situacao_DrogaExpress = 'A' Then	
		If Not wf_proximo_nr_lancamento(lvs_Caixa, lvl_Controle_Incluir, Ref lvl_nr_lancamento, lo_Filial_Destino ) Then
			lo_Filial_Destino.of_Rollback();
			Return lb_Sucesso
		End If
		
		
		
		
		
		lvs_de_historico = 'REF. PED :' + String(lvl_pedido_ecommerce) + ' - ECOMMERCE'
		lvdt_Movimentacao = gf_GetServerDate()
		
		INSERT INTO lancamento_caixa (
			cd_caixa,
			nr_controle_caixa,
			nr_lancamento,
			cd_conta_fluxo_caixa,
			dh_lancamento,
			vl_lancamento,
			de_historico,
			nr_recibo_cobranca,
			id_sumarizacao,
			id_estorno,
			dh_exportacao,
			nr_documento,
			cd_filial_transferencia)
		VALUES (:lvs_caixa,
			:lvl_Controle_Incluir,
			:lvl_nr_lancamento,
			'205', 						//cd_conta_fluxo_caixa
			:lvdt_Movimentacao, 	//dh_lancamento 
			:lvdc_total_pedido, 	//vl_lancamento
			:lvs_de_historico,		//de_historico
			null, 						//nr_recibo_cobranca
			null, 						//id_sumarizacao
			'S', 						//id_estorno
			null, 						//dh_exportacao
			 :ls_Pedido_Ecommerce, 	//nr_documento 
			null  						//cd_filial_transferencia
		)
		Using lo_Filial_Destino;	
		
		If lo_Filial_Destino.SqlCode <> 0 Then
			lo_Filial_Destino.of_Rollback();
			lo_Filial_Destino.of_MsgdbError("Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o inclus$$HEX1$$e300$$ENDHEX$$o do estorno do adiantamento.")
			Return lb_Sucesso
		End If
	End If
	
	//Comprovante j$$HEX1$$e100$$ENDHEX$$ foi cancelado no Retaguarda. 
	If lvs_Cancelado = 'S' Then
		lb_Sucesso = True
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Comprovante j$$HEX1$$e100$$ENDHEX$$ cancelado no Retaguarda de Loja.")
		Return lb_Sucesso
	End If
	
	// Cancela o comprovante do cart$$HEX1$$e300$$ENDHEX$$o
	
	Select dh_movimentacao Into :lvdt_Parametro
	From parametro
	Using lo_Filial_Destino;
	
	Update cartao_comprovante_venda
	Set id_cancelamento = 'S',
		 dh_exportacao   = :lvdt_Parametro
	Where cd_caixa          = :lvs_Caixa
	  and nr_controle_caixa = :lvl_Controle
	  and nr_sequencial     = :lvl_Nr_Sequencial
	Using lo_Filial_Destino;
	
	If lo_Filial_Destino.SqlCode = -1 Then
		lo_Filial_Destino.of_Rollback();
		lo_Filial_Destino.of_MsgdbError("Cancelamento do Comprovante do Cart$$HEX1$$e300$$ENDHEX$$o")
	Else
		// Estorna o lan$$HEX1$$e700$$ENDHEX$$amento de caixa se houver
		Update lancamento_caixa
		Set id_estorno    = 'X',
			 dh_exportacao = :lvdt_Parametro
		Where cd_caixa          = :lvs_Caixa
		  and nr_controle_caixa = :lvl_Controle
		  and nr_lancamento     = :lvl_Lancamento_Estornar
		Using lo_Filial_Destino;
	
		If lo_Filial_Destino.SqlCode = -1 Then
			lo_Filial_Destino.of_Rollback();
			lo_Filial_Destino.of_MsgdbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do Lan$$HEX1$$e700$$ENDHEX$$amento Estornado")
			Return lb_Sucesso
		Else				
			If Not wf_proximo_nr_lancamento(lvs_Caixa, lvl_Controle_Incluir, Ref lvl_Lancamento_Incluir, lo_Filial_Destino ) Then
				lo_Filial_Destino.of_Rollback();
				Return lb_Sucesso
			End If
			
			Insert Into lancamento_caixa (cd_caixa,   
													nr_controle_caixa,   
													nr_lancamento,   
													cd_conta_fluxo_caixa,   
													dh_lancamento,   
													vl_lancamento,   
													de_historico,   
													nr_recibo_cobranca,
													id_sumarizacao,
													id_estorno,
													nr_documento,
													cd_caixa_origem,
													nr_controle_caixa_origem,
													nr_lancamento_origem)  
			Select :lvs_Caixa,
					 :lvl_Controle_Incluir,
					 :lvl_Lancamento_Incluir,
					 cd_conta_fluxo_caixa,
					 dh_lancamento,
					 vl_lancamento,
					 de_historico,
					 null,
					 null,
					 'S',
					 :ls_Pedido_Ecommerce,
					 cd_caixa,
					 nr_controle_caixa,
					 nr_lancamento
			From lancamento_caixa
			Where cd_caixa          	= :lvs_Caixa
			  and nr_controle_caixa 	= :lvl_Controle
			  and nr_lancamento     	= :lvl_Lancamento_Estornar
			Using lo_Filial_Destino;
			
			If lo_Filial_Destino.SqlCode = -1 Then
				lo_Filial_Destino.of_Rollback();
				lo_Filial_Destino.of_MsgdbError("Inclus$$HEX1$$e300$$ENDHEX$$o do Lan$$HEX1$$e700$$ENDHEX$$amento de Estorno")
				Return lb_Sucesso
			End If
		End If
	End If
	
	lb_Sucesso = True
	Return lb_Sucesso
	
Finally
	
	IF lb_Sucesso Then lo_Filial_Destino.of_Commit();	
	
	If IsValid( lo_Filial_Destino ) Then
		If lo_Filial_Destino.of_isconnected( ) Then lo_Filial_Destino.of_disconnect( )
		Destroy lo_Filial_Destino
	End If
End Try
end function

public function boolean wf_conecta_filial (long pl_filial, ref string ps_log);String ls_Odbc

if gvo_Aplicacao.ivs_DataSource <> 'central' and ( is_ODBC_Desenv = '' or isnull(is_ODBC_Desenv) ) then
	ps_log = 'Processo n$$HEX1$$e300$$ENDHEX$$o permitido em base de homologa$$HEX2$$e700e300$$ENDHEX$$o sem informar o ODBC da loja teste.'
	return false
end if

is_DataSource = gvo_Aplicacao.ivs_DataSource

if not isvalid(ivo_Odbc) then
	ivo_Odbc = Create dc_uo_odbc
end if

if not isvalid(itr_Filial) Then 
	itr_Filial	= Create dc_uo_Transacao
	itr_Filial.ivs_DataBase = 'ANYWHERE'
end if

if not isvalid(ivo_Conecta_Odbc) Then
	ivo_Conecta_Odbc = Create uo_transacao_online
end if

////Conectar na base da filial
If Not IsNull(is_ODBC_Desenv) and Trim(is_ODBC_Desenv) <> ''  Then
	ls_Odbc =  is_ODBC_Desenv
else
	ivo_Conecta_Odbc.of_inclui_odbc( pl_filial )
	ls_Odbc = ivo_Odbc.of_Localiza( pl_filial )
end if

If itr_Filial.of_IsConnected( ) Then
	itr_Filial.of_Disconnect( )
End If

if itr_Filial.of_Connect( ls_Odbc, 'EC504' , false) = False Then
	ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel estabelecer conex$$HEX1$$e300$$ENDHEX$$o com a Filial: ' + string(pl_filial) 
	return false
end if

Return True
end function

public function boolean wf_desconecta_filial ();if Not isvalid(itr_filial) Then return true

If itr_Filial.of_IsConnected( ) Then
	itr_Filial.of_Disconnect( )
End If

gvo_Aplicacao.ivs_DataSource = is_DataSource

return true
end function

public function boolean wf_equilibrium_cancela_pedido (long pl_cd_filial, long pl_nr_pedido, string ps_nr_pedido, ref string ps_log);string ls_status

uo_ge509_cancelamento luo_cancel
uo_ge509_status luo_status

Try
	
	//Integra$$HEX2$$e700e300$$ENDHEX$$o Equilibrium
	
	luo_cancel = create uo_ge509_cancelamento
	luo_status = create uo_ge509_status

	//cancela o pedido
	if Not luo_cancel.of_processa_cancelamento( ps_nr_pedido, ref ps_log ) Then return false

	//Busca o status do pedido pra certificar que foi cancelado.
	if Not luo_status.of_processa_status( pl_cd_filial, pl_nr_pedido, ps_nr_pedido, ref ls_status, ref ps_log ) Then return false

	if ls_status <> 'CANCELADO' or isnull(ls_status) or ls_status = '' Then
		ps_log =  ' - Falha ao realizar o cancelamento da entrega do pedido: Integra$$HEX2$$e700e300$$ENDHEX$$o Equilibrium'
		return false
	end if
	
	Update pedido_ecommerce_auxiliar
	set id_pedido_equilibrium = null 
	where cd_filial_ecommerce = :pl_cd_filial
	and nr_pedido = :pl_nr_pedido;
	
	if sqlca.sqlcode = -1 then
		ps_log = 'Problemas ao atualizar a tabela pedido_ecommerce_auxiliar: ' + sqlca.sqlerrtext
		return false
	end if

		Update pedido_ecommerce
		set de_url_rastreio = null
		where cd_filial_ecommerce = :pl_cd_filial
		and nr_pedido = :pl_nr_pedido;
	
		if sqlca.sqlcode = -1 then
			ps_log = 'Problemas ao atualizar a tabela pedido_ecommerce: ' + sqlca.sqlerrtext
			return false
		end if
	
Finally
	
	destroy(luo_cancel)
	destroy(luo_status)
	
End Try

return true
end function

public function boolean wf_insert_pedido_drogaexpress (string as_pedido, string as_pedido_novo, ref string as_log);long ll_nr_pedido

//Declare sp_pedido Procedure for sp_proximo_pedido_ecommerce
//	@proximo_sequencial_retorno  = :ll_nr_pedido OUTPUT,
//	@mensagem_retorno = :ls_erro OUTPUT
//USING SQLCA;
//			
//Execute sp_pedido;
//
//If SQLCA.sqlcode = -1 then 
//	ps_log = is_objeto + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_pedido ~n' + 'Erro ao executar a procedure "sp_proximo_pedido_ecommerce": ~n' + SQLCA.sqlerrtext 
//	return false
//end if
//
//Fetch sp_pedido Into :ll_nr_pedido, :ls_erro;
//
//Close sp_pedido;
//
//if ls_erro <> '' and not isnull(ls_erro) Then
//	ps_log = is_objeto + '~nFun$$HEX2$$e700e300$$ENDHEX$$o: of_grava_pedido ~n' + 'Erro ao executar a procedure "sp_proximo_pedido_ecommerce": ~n' + ls_erro
//	return false
//end if
//
//il_nr_pedido = ll_nr_pedido

INSERT INTO pedido_drogaexpress (  nr_pedido_drogaexpress, cd_filial, id_refaturado, id_situacao, dh_emissao, hr_emissao, cd_cliente_drogaexpress, vl_total_produtos, pc_desconto, vl_total_pedido, vl_taxa_entrega, 
	vl_cobrar, vl_pago, cd_tipo_venda, cd_forma_pagamento, nr_matricula_vendedor, nr_matricula_operador, de_especie_doc_fiscal, 
	nr_cartao_credito, dh_validade_cartao, cd_convenio, cd_conveniado, cd_dependente_conveniado, cd_cliente, cd_dependente_cliente, 
	cd_condicao_convenio, cd_condicao_crediario, dh_entrega_marcada, de_observacao, nr_matric_alteracao_preco, nr_matric_liberacao_bloqueio, 
	nr_matric_liberacao_restricao, nr_pedido_antigo, nr_matricula_cancelamento, de_endereco_entrega, de_referencia_entrega, 
	de_bairro_entrega, nr_telefone_entrega, dh_atualizacao_pedido, vl_total_tabela, cd_seguranca_cartao, id_venda_clube, 
	cd_cliente_dependente, nr_cartao_clube, qt_pontos_clube, nm_cartao_credito, nm_cliente_cartao, nm_cliente_cheque, 
	nr_cpf_cheque, id_alteracao, nr_pedido_ecommerce, nm_cliente_entrega, nr_cep_entrega, nr_parcelas_pagamento, 
	nm_administradora_cartao, nm_transportadora, nm_cidade_entrega, cd_uf_entrega, vl_desconto, nr_comprovante_cartao_credito, 
	nr_autorizacao_cartao_credito, cd_estabelecimento_cartao_credito, nr_boleto_bancario, nr_vale_compra, 
	vl_vale_compra, de_complemento_endereco, nr_telefone_contato, cd_filial_ecommerce, nr_endereco_entrega, id_tipo_vale, de_via_pbm, id_rede_ecommerce,nr_pedido_ecommerce_site,id_plataforma_ecommerce,
	id_cpf_nf,
	cd_psp_recebedor,
	cd_autorizacao_cd,
	id_tipo_uso_cd,
	id_tipo_pedido, nr_cpf_pbm,vl_acrescimo)
SELECT :as_Pedido_Novo, cd_filial, 'S', 'A', getdate(), hr_emissao, cd_cliente_drogaexpress, vl_total_produtos, pc_desconto, vl_total_pedido, vl_taxa_entrega, 
	vl_cobrar, vl_pago, cd_tipo_venda, cd_forma_pagamento, nr_matricula_vendedor, nr_matricula_operador, de_especie_doc_fiscal, 
	nr_cartao_credito, dh_validade_cartao, cd_convenio, cd_conveniado, cd_dependente_conveniado, cd_cliente, cd_dependente_cliente, 
	cd_condicao_convenio, cd_condicao_crediario, dh_entrega_marcada, de_observacao, nr_matric_alteracao_preco, nr_matric_liberacao_bloqueio, 
	nr_matric_liberacao_restricao, nr_pedido_antigo, nr_matricula_cancelamento, de_endereco_entrega, de_referencia_entrega, 
	de_bairro_entrega, nr_telefone_entrega, dh_atualizacao_pedido, vl_total_tabela, cd_seguranca_cartao, id_venda_clube, 
	cd_cliente_dependente, nr_cartao_clube, qt_pontos_clube, nm_cartao_credito, nm_cliente_cartao, nm_cliente_cheque, 
	nr_cpf_cheque, id_alteracao, nr_pedido_ecommerce, nm_cliente_entrega, nr_cep_entrega, nr_parcelas_pagamento, 
	nm_administradora_cartao, nm_transportadora, nm_cidade_entrega, cd_uf_entrega, vl_desconto, nr_comprovante_cartao_credito, 
	nr_autorizacao_cartao_credito, cd_estabelecimento_cartao_credito, nr_boleto_bancario, nr_vale_compra, 
	vl_vale_compra, de_complemento_endereco, nr_telefone_contato, cd_filial_ecommerce, nr_endereco_entrega, id_tipo_vale, de_via_pbm, Coalesce(id_rede_ecommerce, 'FA'), nr_pedido_ecommerce_site,id_plataforma_ecommerce,
	id_cpf_nf,
	cd_psp_recebedor,
	cd_autorizacao_cd,
	id_tipo_uso_cd,
	id_tipo_pedido,nr_cpf_pbm,vl_acrescimo
From pedido_drogaexpress
	Where nr_pedido_drogaexpress = :as_Pedido
Using itr_filial;

If itr_filial.SqlCode = -1 Then
	as_log = 'Problemas ao inserir registro na tabela pedido_drogaexpress: ' + itr_filial.sqlerrtext
	itr_filial.of_Rollback( )
	itr_filial.of_Msgdberror( "Erro ao inserir o pedido.~rwf_insert_pedido_drogaexpress(string, string)" )
	Return False
End If

If itr_filial.sqlnrows = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel gravar na filial o novo pedido para o refaturamento.",  StopSign!)
	Return False
End If
	
Return True
end function

public function boolean wf_insert_produtos_drogaexpress (string ps_pedido, string ps_pedido_novo, ref string ps_log);

INSERT INTO produto_pedido_drogaexpress( 
			nr_pedido_drogaexpress, 
			cd_produto, 
			nr_sequencial,
			qt_pedida, 
			vl_preco_tabela, 
			pc_desconto_tabela, 
			vl_preco_praticado, 
			id_alteracao_preco,
			id_restricao_convenio, 
			vl_preco_tabela_liquido, 
			qt_pontos_clube, 
			id_campanha_exclusiva_pbm,
			nr_campanha_pbm,
			cd_pbm,
			id_usa_desconto_pbm) 
SELECT :ps_pedido_novo, 
		cd_produto, 
		nr_sequencial,
		qt_pedida, 
		vl_preco_tabela, 
		pc_desconto_tabela, 
		vl_preco_praticado, 
		id_alteracao_preco,
		id_restricao_convenio,
		vl_preco_tabela_liquido, 
		qt_pontos_clube,
		id_campanha_exclusiva_pbm,
		nr_campanha_pbm,
		cd_pbm,
		id_usa_desconto_pbm
  FROM produto_pedido_drogaexpress 
  WHERE nr_pedido_drogaexpress = :ps_pedido
Using itr_filial;

If itr_filial.SqlCode = -1 Then
	ps_log = 'Problemas ao inserir registro na tabela produto_pedido_drogaexpress: ' + itr_filial.sqlerrtext
	itr_filial.of_Rollback();
	itr_filial.of_Msgdberror( "Erro ao inserir os produtos do pedido.~rwf_insert_produtos_drogaexpress(string, string)" )
	Return False
End If

If itr_filial.sqlnrows = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel gravar na filial o(s) produto(s) do novo pedido para o refaturamento.", StopSign!)
	Return False
End If

Return True
end function

public function boolean wf_proximo_pedido_drogaexpress (long al_filial, ref string as_pedido_novo, ref string as_log);string ls_datasource

ls_datasource = gvo_Aplicacao.ivs_DataSource

gvo_Aplicacao.ivs_DataSource = is_datasource

if Not gf_proximo_pedido_drogaexpress(al_filial, ref as_Pedido_Novo, ref as_log) then return false

gvo_Aplicacao.ivs_DataSource = ls_datasource

//Select max(nr_pedido_drogaexpress)
//	Into :ls_Pedido
//From pedido_drogaexpress
//Using Destino;
//
//Choose Case Destino.SqlCode
//	Case 0
//		If Not IsNull(ls_Pedido) Then
//			ll_Sequencial = Long(Right(ls_Pedido, 7))			
//		Else
//			ll_Sequencial = 0
//		End If
//	Case 100
//		ll_Sequencial = 0
//	Case -1
//		Destino.of_MsgDbError("Erro ao localizar o sequencial do pedido drogaexpress") 
//		Return False
//End Choose
//
//ll_Sequencial++ 
//
//as_Pedido_Novo = String( al_Filial, "0000") + String( ll_Sequencial, "0000000" )		

Return True
end function

public function boolean wf_equilibrium_reenviar_pedido (boolean pb_refaturamento, string ps_nr_pedido_novo);//string ls_nr_pedido_equilibrium, ls_De_entrega, ls_id_tipo_entrega_equilibrium, ls_nm_transportadora, ls_log, ls_id_oferta, ls_id_situacao, ls_url_rastreio, ls_id_pedido, ls_id_situacao_loja
//String ls_nr_pedido_drogaexpress
//String ls_id_plataforma, ls_nm_ecommerce
//long ll_cd_filial, ll_nr_pedido, ll_cd_filial_fisica, ll_existe
//datetime ldh_validade
//
//boolean lb_sucesso=false
//
//long ll_linha
//
//uo_ge509_cotacao luo_cotacao
//
////Integra$$HEX2$$e700e300$$ENDHEX$$o Equilibrium - Cotacao
//
//Try
//	
//	ll_linha = tab_1.tabpage_1.dw_2.getrow()
//
//	if ll_linha < 1 or isnull(ll_linha) Then return true
//	
//	ll_cd_filial = tab_1.tabpage_1.dw_2.object.cd_filial_ecommerce[ll_linha]
//	ll_nr_pedido = tab_1.tabpage_1.dw_2.object.nr_pedido[ll_linha]
//	ll_cd_filial_fisica = tab_1.tabpage_1.dw_2.object.cd_filial[ll_linha]
//	ls_nr_pedido_equilibrium = tab_1.tabpage_1.dw_2.object.id_pedido_equilibrium[ll_linha]
//	ls_De_entrega = tab_1.tabpage_1.dw_2.object.nm_transportadora[ll_linha]
//	ls_id_situacao = tab_1.tabpage_1.dw_2.object.id_situacao[ll_linha]
//	ls_nr_pedido_drogaexpress = tab_1.tabpage_1.dw_2.object.nr_pedido_drogaexpress[ll_linha]
//	ls_id_plataforma = tab_1.tabpage_1.dw_2.object.id_plataforma[ll_linha]
//	ls_nm_ecommerce = tab_1.tabpage_1.dw_2.object.nm_ecommerce[ll_linha]
//	
//	if ls_id_plataforma <> '2' then
//		messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Processo n$$HEX1$$e300$$ENDHEX$$o dispon$$HEX1$$ed00$$ENDHEX$$vel para pedidos da plataforma: ' + ls_nm_ecommerce)
//		return false
//	end if
//	
//	if ( ls_de_entrega <> 'ENTREGA ECON$$HEX1$$d400$$ENDHEX$$MICA' and ls_de_entrega <> 'ENTREGA EXPRESSA' ) or isnull(ls_de_entrega) or ls_de_entrega = '' Then
//		messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Processo n$$HEX1$$e300$$ENDHEX$$o permitido para a seguinte modalidade de entrega: ' + ls_de_entrega )
//		return false
//	end if
//	
//	if pb_refaturamento = false Then
//		if messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Deseja reenviar a cota$$HEX2$$e700e300$$ENDHEX$$o de entrega do pedido ' + string(ll_nr_pedido) + ' para a Equilibrium?', question!, yesno!,2) = 2 then return false
//	else
//		ls_nr_pedido_drogaexpress = ps_nr_pedido_novo
//	end if
//	
//	if not isvalid(w_Aguarde) then Open(w_Aguarde)
//	
//	if pb_refaturamento = false Then
//		if ls_id_situacao <> 'A' Then
//			ls_log = 'A situa$$HEX2$$e700e300$$ENDHEX$$o do pedido n$$HEX1$$e300$$ENDHEX$$o permite o reenvio da cota$$HEX2$$e700e300$$ENDHEX$$o de entrega.'
//			return false
//		End if
//	end if
//	
//	Select Count(*)
//	into :ll_existe
//	from pedido_ecommerce_entrega
//	where nr_pedido = :ll_nr_pedido
//	and cd_filial_ecommerce = :ll_cd_filial;
//	
//	If SQLCA.SQLCOde = -1 then
//		ls_log = 'Problemas ao consultar a tabela pedido_ecommerce_entrega: ' + SQLCA.sqlerrtext
//		return false
//	End if
//	
//	if ll_existe = 0 or isnull(ll_existe) Then 
//		ls_log = 'O pedido ainda n$$HEX1$$e300$$ENDHEX$$o foi enviado para a Equilibrium.'
//		return false
//	end if
//	
//	//Conecta na filial :
//	if pb_refaturamento = false Then
//		Destino 		= Create dc_uo_transacao
//		ivo_Odbc 	= Create dc_uo_odbc
//		
//		Destino.of_SetDataBase('postgresql')
//	
//		If Not wf_Conecta_Destino( ll_cd_filial_fisica ) Then
//			ls_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel conectar a seguinte filial: ' + string(ll_cd_filial_fisica)
//			Return false
//		End If
//	
//		select id_situacao
//		into :ls_id_situacao_loja
//		from pedido_drogaexpress
//		where nr_pedido_drogaexpress = :ls_nr_pedido_drogaexpress
//		Using Destino;
//		
//		if Destino.sqlcode = -1 then
//			ls_log = 'Problemas ao consultar a tabela pedido_drogaexpress: ' + Destino.sqlerrtext
//			Destino.of_rollback( )
//			return false
//		End if
//		
//		if ls_id_situacao_loja = 'X' Then
//			ls_log = 'Opera$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o permitida. A loja cancelou o pedido.'
//			return false
//		elseif ls_id_situacao_loja <> 'A' then
//			ls_log = 'Opera$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o permitida. A loja faturou o pedido.'
//			return false
//		end if
//	
//	ENd if
//	
//	luo_cotacao = create uo_ge509_cotacao
//		
//	if ls_de_entrega = 'ENTREGA ECON$$HEX1$$d400$$ENDHEX$$MICA' Then
//		ls_id_tipo_entrega_equilibrium = '1'
//	Elseif ls_de_entrega = 'ENTREGA EXPRESSA' Then
//		ls_id_tipo_entrega_equilibrium = '2'
//	Else
//		ls_log= 'Tipo de entrega n$$HEX1$$e300$$ENDHEX$$o encontrado.'
//		return false
//	end if
//	
//	//Cria nova cota$$HEX2$$e700e300$$ENDHEX$$o
//	if Not luo_cotacao.of_processa_cotacao( ll_cd_filial, ll_nr_pedido, ls_id_tipo_entrega_equilibrium, ref ls_id_oferta, ref ls_nm_transportadora, ref ldh_validade, ref ls_log ) Then return false
//	
//	update pedido_drogaexpress
//	set nm_transportadora_ecommerce = :ls_nm_transportadora, dh_validade_cotacao_entrega = :ldh_validade
//	where nr_pedido_drogaexpress = :ls_nr_pedido_drogaexpress
//	Using Destino;
//		
//	if Destino.sqlcode = -1 then
//		ls_log = 'Problemas ao atualizar a tabela pedido_drogaexpress: ' + Destino.sqlerrtext
//		Destino.of_rollback( )
//		return false
//	End if
//		
//	if pb_refaturamento = false Then	
//		Destino.of_commit( )	
//			
//		Destino.of_Disconnect()	
//	end if
//		
//	lb_sucesso = True
//		
//Finally
//	
//	if isvalid(w_aguarde) then Close(w_Aguarde)
//	
//	if lb_sucesso = True Then
//		if pb_refaturamento = false Then
//			sqlca.of_commit( )
//			messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Nova cota$$HEX2$$e700e300$$ENDHEX$$o de entrega enviada a Equilibrium com sucesso: ' + ls_id_oferta + ' - ' + ls_nm_transportadora)
//		end if
//		
//	else
//		sqlca.of_rollback( )
//	end if
//	
//	if isvalid(luo_cotacao) Then destroy(luo_cotacao)
//	
//	if pb_refaturamento = false Then
//			// Se estiver conectado desconecta
//		if isvalid(destino) Then
//			If Destino.of_isConnected() Then Destino.of_Disconnect()
//		end if
//		
//		if isvalid(Destino) Then destroy(Destino)
//		if isvalid(ivo_Odbc) Then destroy(ivo_Odbc)
//		
//		gvo_Aplicacao.ivs_DataSource = is_DataSource
//	ENd if
//	
//	if ls_log <> '' and not isnull(ls_log) Then messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o',ls_log)
//end Try
//
return true
end function

public function boolean wf_alterar_mod_entrega (ref string ps_log);Long	ll_Retorno,&
		ll_Pedido,&
		ll_cd_Filial
Long ll_Filial_Ecommerce
Long ll_row

decimal ldc_valor

String	ls_Transp_Anterior,&
		ls_Transp_Atual,&
		ls_Texto,&
		ls_Nome_Filial,&
		ls_Transportadora, ls_nm_Transportadora
string ls_de_tipo_entrega, ls_de_tipo_entrega_site, ls_id_tipo_entrega, ls_id_situacao, ls_id_situacao_novo
String ls_Rede_EC
String ls_Pedido_DrogaExpress
String ls_Situacao_Loja
string ls_nulo
string ls_id_plataforma
string ls_nm_ecommerce

boolean lb_usa_pdv_java = false
boolean lb_sucesso = false

datetime ldt_nulo

uo_ge501_comum luo_comum_vtex
uo_ge501_pedido_status luo_status

Try
	
	setnull(ldt_nulo)
	setnull(ls_nulo)
	
	ll_row = Tab_1.TabPage_1.dw_2.GetRow()

	if ll_row = 0 or isnull(ll_row) Then
		ps_log = 'Selecione um pedido para alterar a modalidade de entrega.'
		return false
	end if
	
	ll_Pedido = Tab_1.TabPage_1.dw_2.object.nr_pedido[ll_row]
	ls_Transportadora = Tab_1.TabPage_1.dw_2.Object.nm_transportadora[ll_row]
	ll_Filial_Ecommerce = Tab_1.TabPage_1.dw_2.object.cd_filial_ecommerce	[ll_row]
	ll_cd_filial = Tab_1.TabPage_1.dw_2.object.cd_filial[ll_row]
	ls_Pedido_DrogaExpress = Tab_1.TabPage_1.dw_2.object.nr_pedido_drogaexpress[ll_row]
	ls_Nome_Filial = Tab_1.TabPage_1.dw_2.Object.nm_Fantasia[ ll_row ]
	ldc_valor = Tab_1.TabPage_1.dw_2.Object.vl_pedido[ ll_row ]
	ls_id_situacao = Tab_1.TabPage_1.dw_2.Object.id_situacao[ ll_row ]
	ls_id_plataforma = Tab_1.TabPage_1.dw_2.Object.id_plataforma[ ll_row ]
	ls_nm_ecommerce = Tab_1.TabPage_1.dw_2.Object.nm_ecommerce[ ll_row ]
	
	if ls_id_plataforma <> '2' and ls_id_plataforma <> '5' then
		ps_log = 'Processo n$$HEX1$$e300$$ENDHEX$$o dispon$$HEX1$$ed00$$ENDHEX$$vel para pedidos da plataforma: ' + ls_nm_ecommerce
		return false
	end if
	
	OpenWithParm( w_ge504_altera_transportadora ,  String(ll_Filial_Ecommerce, '0000') + String(ll_Pedido) )
	
	ll_Retorno = Message.DoubleParm
	
	If ll_Retorno > 0 Then
		
		select de_tipo_entrega, de_tipo_entrega_site, id_tipo_entrega
		into :ls_de_tipo_entrega, :ls_de_tipo_entrega_site, :ls_id_tipo_entrega
		from tipo_entrega_ecommerce
		where cd_tipo_entrega = :ll_retorno
		Using sqlca;
		
		if sqlca.sqlcode = -1 then
			ps_log = 'Problemas ao consultar a tabela tipo_entrega_ecommerce: ' + sqlca.sqlerrtext
			return false
		end if
		
		if ls_id_tipo_entrega = 'ARM' then
			ls_nm_transportadora = ls_de_tipo_entrega_site
		Else
			ls_nm_transportadora = ls_de_tipo_entrega
		ENd if
	
		if ls_id_situacao <> 'A' and ls_id_situacao <> 'G' and ls_id_situacao <> 'X' and ls_id_situacao <> 'I' then	
			ls_id_situacao_novo = 'F'
		Else
			ls_id_situacao_novo = ls_id_situacao
		End if
		
		//Atualizo a situacao na pedido_ecommerce, para que a interface PEDIDO - STATUS possa refazer o processo com a nova modalidade de entrega.
		Update pedido_ecommerce
		set id_situacao = :ls_id_situacao_novo, dh_faturado = null, 
			nm_transportadora = :ls_nm_transportadora, cd_tipo_entrega = :ll_retorno, de_url_rastreio = null, de_codigo_rastreamento_correio = null
		where cd_filial_ecommerce = :ll_Filial_Ecommerce
		and nr_pedido = :ll_pedido;
		
		if sqlca.sqlcode = -1 then
			ps_log = 'Problemas ao atualizar a tabela pedido_ecommerce: ' + sqlca.sqlerrtext
			return false
		end if
		
		Update pedido_ecommerce_auxiliar
		set id_pedido_equilibrium = null, dh_atualizacao_site_rastreio = null
		where cd_filial_ecommerce = :ll_Filial_Ecommerce
		and nr_pedido = :ll_pedido;
		
		if sqlca.sqlcode = -1 then
			ps_log = 'Problemas ao atualizar a tabela pedido_ecommerce_auxiliar: ' + sqlca.sqlerrtext
			return false
		end if
		
		Update pedido_ecommerce_entrega
		set id_situacao = 'X'
		where cd_filial_ecommerce = :ll_Filial_Ecommerce
		and nr_pedido = :ll_pedido
		and id_situacao = 'A';
		
		if sqlca.sqlcode = -1 then
			ps_log = 'Problemas ao atualizar a tabela pedido_ecommerce_entrega: ' + sqlca.sqlerrtext
			return false
		end if
		
		if ls_Pedido_DrogaExpress <> '' and not isnull(ls_Pedido_DrogaExpress) Then
			
			gf_retorna_loja_pdv_novo(ll_cd_filial, ref lb_usa_pdv_java, ref ps_log )
			
			if ps_log <> '' and not isnull(ps_log) Then return false
			
			if lb_usa_pdv_java = False Then
			
				luo_comum_vtex = create uo_ge501_comum
			
				is_ODBC_Desenv 	= luo_comum_vtex.of_desenvolvimento_odbc_baixa_pedido()
			
				If Not wf_Conecta_Filial(ll_cd_Filial, ref ps_Log) Then Return False
			
				Select id_situacao 
				Into :ls_Situacao_Loja
				From pedido_drogaexpress
				Where nr_pedido_drogaexpress = :ls_Pedido_DrogaExpress
				Using itr_Filial;
			
				if itr_Filial.sqlcode = -1 then
					ps_log = 'Problemas ao consultar a tabela pedido_drogaexpress: ' + itr_Filial.sqlerrtext
					return false
				end if
			
				if ls_Situacao_Loja = '' or isnull(ls_Situacao_Loja) Then
					ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel encontrar o pedido [' + ls_Pedido_DrogaExpress + '] no banco de dados da loja [' + string(ll_cd_filial) + '].'
					return false
				end if
			
				Update pedido_drogaexpress
				set nm_transportadora = :ls_nm_transportadora, dh_validade_cotacao_entrega = null, nm_transportadora_ecommerce = null
				where nr_pedido_drogaexpress = :ls_Pedido_DrogaExpress
				Using itr_Filial;
				
				if itr_Filial.sqlcode = -1 then
					ps_log = 'Problemas ao atualizar a tabela pedido_drogaexpress: ' + itr_Filial.sqlerrtext
					return false
				end if
				
				itr_Filial.of_commit( )
				
			End if
			
		ENd if
	
		sqlca.of_commit( )
		
		Tab_1.TabPage_1.dw_2.Event ue_Retrieve( )
			
		If ls_Transportadora <> ls_nm_transportadora Then	
			ls_Texto = "<strong>Pedido:</strong> " + String( ll_Pedido )
			ls_Texto += "<br /><strong>Filial:</strong> " + String( ll_cd_Filial ) + " - " + ls_Nome_Filial
			ls_Texto += "<br /><strong>Mod. Entrega alterada de</strong> " + ls_Transportadora + " <strong>para</strong> " + ls_nm_transportadora + "."
			ls_Texto += "<br /><br /><strong>Alterado por:</strong> " + gvo_Aplicacao.ivo_Seguranca.nr_Matricula + " - " + gvo_Aplicacao.ivo_Seguranca.nm_Usuario
			gf_ge202_envia_email_log( 109, '[' + gvo_aplicacao.ivo_seguranca.cd_sistema + '] - Altera$$HEX2$$e700e300$$ENDHEX$$o de Pedido (Mod. Entrega)', ls_Texto, True )
		End If
		
	End If
	
	lb_sucesso = True
	
Finally
	
	if lb_sucesso = false Then
		sqlca.of_rollback( )
		
		if isvalid(itr_Filial) then
			If itr_Filial.of_IsConnected( ) Then
				itr_Filial.of_rollback( )
			ENd if
		ENd if
	End if
		
	wf_desconecta_filial()
	
	if isvalid(luo_comum_vtex) then destroy(luo_comum_vtex)
	if isvalid(luo_status) then destroy(luo_status)
	
ENd Try

return true
end function

public function boolean wf_verifica_capturado_vtex (string ps_url_conector, string ps_chave, string ps_token, string ps_id_transacao, ref boolean pb_capturado, ref string ps_nsu, ref string ps_autorizacao, ref datetime pdh_captura, ref string ps_log);string ls_nsu, ls_autorizacao
Datetime ldh_conf_fatur

uo_ge501_pedido_ecommerce luo_pedido

//Conectar na VTEX pra verificar se o pagamento foi capturado.

Try
	
	luo_pedido = create uo_ge501_pedido_ecommerce
	
	luo_pedido.is_url_conector = ps_url_conector
	luo_pedido.is_chave_conector = ps_chave
	luo_pedido.is_token_conector = ps_token
	
	ls_nsu = ''
	
	If Not luo_pedido.of_busca_nsu_esitef( 'C', ps_id_transacao, ref ls_nsu, ref ls_autorizacao, ref ldh_conf_fatur, ref ps_log ) Then return false
	
	if ls_nsu <> '' and not isnull(ls_nsu) then
		pb_capturado = True
		
		ps_nsu = ls_nsu
		ps_autorizacao = ls_autorizacao
		pdh_captura = ldh_conf_fatur
		
	Else
		pb_capturado = False
		
		setnull(ps_nsu)
		setnull(ps_autorizacao)
		setnull(pdh_captura)
	ENd if
	
Finally
	
	destroy(luo_pedido)
	
ENd Try

return true
end function

public function boolean wf_cancela_pedido ();Boolean lb_sucesso = False
Boolean lb_usa_pdv_java = False

Decimal ldc_Vale
Decimal ldc_Valor_Total

Long ll_Linha
Long ll_Pedido_ERP
Long ll_Filial
Long ll_Filial_Ecommerce
Long ll_Filial_Log
Long ll_Seq_Log
Long ll_cd_seller

String ls_Pedido_DrogaExpress
String ls_Rede
String ls_Chave_Nula
String ls_MSG_Nula
String ls_Log
String ls_Nulo
String ls_Motivo
String ls_Resp
String ls_Situacao_Loja
String ls_Situacao
String ls_Pedido_Ecommerce
string ls_Tipo_Pagamento
String ls_id_plataforma
String ls_de_plataforma

datetime ldh_atual

boolean lb_capturado=false
boolean lb_faturado = false

uo_ge516_comum_ecommerce luo_log

SetNull(ls_Chave_Nula)
SetNull(ls_MSG_Nula)

If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("GE504_CANCELAR", Ref ls_Resp) Then 
	Return False
End If

tab_1.TabPage_1.dw_2.AcceptText()
	
ll_Linha 		=  tab_1.TabPage_1.dw_2.GetRow()

ls_Situacao 				= tab_1.TabPage_1.dw_2.Object.id_situacao			[ll_Linha]
ls_Tipo_Pagamento 	= tab_1.TabPage_1.dw_2.Object.cd_tipo_pagamento	[ll_Linha]
ll_Pedido_ERP			= tab_1.TabPage_1.dw_2.Object.Nr_Pedido 			[ll_Linha]
ldc_Vale					= tab_1.TabPage_1.dw_2.Object.vl_valecompra		[ll_Linha]

If ldc_Vale > 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Procedimento n$$HEX1$$e300$$ENDHEX$$o permitido para vale compra - rever processo", Exclamation!)
	Return False
End If

If ls_Situacao = 'X' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O pedido ecommerce j$$HEX1$$e100$$ENDHEX$$ foi cancelado [" + string(ll_Pedido_ERP) + "]", Exclamation!)
	Return False
End If
	
If ls_Situacao <> 'A' and ls_Situacao <> 'G' and ls_Situacao <> 'I' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O pedido ecommerce j$$HEX1$$e100$$ENDHEX$$ foi faturado [" + string(ll_Pedido_ERP) + "]", Exclamation!) 
	Return False
End If

If Pos(ls_Tipo_Pagamento, "TRANSF") > 0 or Pos(ls_Tipo_Pagamento, "BOLE") > 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A forma de pagamento n$$HEX1$$e300$$ENDHEX$$o permite cancelamento: " + ls_tipo_pagamento + ".", Exclamation!)
	Return False
End If

Try
	
	luo_log = create uo_ge516_comum_ecommerce
	
	Open(w_Aguarde)
	
	w_Aguarde.Title = "e-Commerce - Cancelamento de Pedido"

	ldh_atual = gf_getserverdate()

	ls_Pedido_DrogaExpress	= tab_1.TabPage_1.dw_2.Object.nr_pedido_drogaexpress	[ ll_Linha ]
	ls_Pedido_Ecommerce	= tab_1.TabPage_1.dw_2.Object.nr_pedido_ecommerce	[ ll_Linha ] 
	ll_Filial						= tab_1.TabPage_1.dw_2.Object.cd_filial						[ ll_Linha ]
	ll_Filial_Ecommerce		= tab_1.TabPage_1.dw_2.Object.cd_filial_ecommerce		[ ll_Linha ]
	ldc_Valor_Total				= tab_1.TabPage_1.dw_2.Object.vl_total						[ ll_Linha ]
	ls_Rede						= tab_1.TabPage_1.dw_2.Object.id_rede_seller				[ ll_Linha ]
	ll_cd_seller					= tab_1.TabPage_1.dw_2.Object.cd_seller						[ ll_Linha ]
	ls_id_plataforma 			= tab_1.TabPage_1.dw_2.Object.id_plataforma				[ll_Linha]
	
	luo_log.is_id_ecommerce = ls_id_plataforma
	luo_log.il_cd_filial_pedido = ll_filial
	luo_log.il_qt_item_enviado_site = 1
	luo_log.is_nr_pedido_ecommerce = ls_Pedido_Ecommerce
	luo_log.is_rede_ecommerce = ls_rede
	
	is_Odbc_desenv = luo_log.of_desenvolvimento_odbc_baixa_pedido()
	
    // Grava in$$HEX1$$ed00$$ENDHEX$$cio do processo
	If Not luo_log.of_grava_log(ll_Filial_Ecommerce, 19, ls_Chave_Nula, 'C', ls_MSG_Nula, ldh_atual, ldh_atual, ref ls_Log, ref ll_Seq_Log ) Then Return False
		
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Deseja cancelar o pedido " + String(ll_Pedido_ERP) + " ?", Question!, YesNo!, 2) = 2 Then
		ls_log = 'Opera$$HEX2$$e700e300$$ENDHEX$$o cancelada pelo usu$$HEX1$$e100$$ENDHEX$$rio.~r~rCancelamento n$$HEX1$$e300$$ENDHEX$$o realizado.'
		Return False
	End If
	
	OpenWithParm(w_ge504_motivo_cancelamento,"")
	ls_Motivo = Message.StringParm

	If IsNull(ls_Motivo) Then 
		ls_Log = 'O motivo do cancelamento n$$HEX1$$e300$$ENDHEX$$o foi informado.'
		Return False	
	End If
	
	gf_retorna_loja_pdv_novo(ll_filial, ref lb_usa_pdv_java, ref ls_log )
	
	if ls_log <> '' and not isnull(ls_log) Then return false
	
	if lb_usa_pdv_java = False Then
	
		If Not wf_Conecta_Filial(ll_Filial, ref ls_Log) Then Return False
	
	End if
	
	if Not this.wf_busca_situacao_pedido( lb_usa_pdv_java, ls_Pedido_DrogaExpress, ll_Filial_Ecommerce, ll_Pedido_ERP, ref ls_Situacao_Loja, ref ls_log) then return false
	
	If ls_Situacao_Loja = 'X' Then
		ls_log = "O pedido ecommerce j$$HEX1$$e100$$ENDHEX$$ foi cancelado na loja [" + string(ll_Pedido_ERP) + "]" 
		Return False
	End If
	
	If ls_Situacao_Loja <> 'A' and ls_Situacao_Loja <> 'G' Then
		ls_log = "O pedido ecommerce j$$HEX1$$e100$$ENDHEX$$ foi FATURADO na loja [" + string(ll_Pedido_ERP) + "]" 
		Return False
	End If
	
	if This.wf_verifica_pedido_faturado( lb_usa_pdv_java, ll_filial, ls_Pedido_DrogaExpress, ll_Pedido_ERP, ref lb_faturado, ref ls_log) then return false
	
	If lb_faturado = True Then
		ls_log = "O pedido ecommerce j$$HEX1$$e100$$ENDHEX$$ foi FATURADO na loja [" + string(ll_Pedido_ERP) + "]" 
		Return False
	End If
	
	If lb_usa_pdv_java = true Then 
		if not wf_verifica_cancelamento_pdv_novo(ll_filial, ll_Pedido_ERP, ls_log) then return false
	End if

	//Cancelar o pedido na plataforma (somente na base de producao):
	if SqlCa.Database = 'central' then
		
		Choose Case ls_id_plataforma
			Case '2' //VTEX
				if Not this.wf_cancela_pedido_vtex( ll_filial, ll_cd_seller, ll_Filial_Ecommerce, ll_Pedido_ERP, ls_Pedido_Ecommerce, ls_rede, ldc_Valor_Total, ls_Motivo, ref lb_capturado, ref ls_log) then return false
				
			Case '5' //Consulta Remedios
				if Not this.wf_cancela_pedido_cr( ls_id_plataforma, ls_Pedido_Ecommerce, ll_filial, ls_rede, ref ls_log) then return false
				
//			Case Else
//				ls_log = 'Os pedidos da plataforma selecionada n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e300$$ENDHEX$$o habilitados para cancelamento.'
//				return false
				
		End Choose
		
	End if
				
	Update pedido_ecommerce 
	set 	id_situacao = 'X', 	
			dh_cancelamento = getdate(), 
			nr_matric_alteracao_situacao = :ls_Resp
	where cd_filial_ecommerce = :ll_Filial_Ecommerce
		and nr_pedido				= :ll_Pedido_ERP
	Using SqlCa;

	If SqlCa.SqlCode = -1 Then
		ls_log = 	'Erro ao mudar a situa$$HEX2$$e700e300$$ENDHEX$$o do pedido": ~n' + SqlCa.sqlerrtext
		Return False
	End If
	
	If Sqlca.SQLNRows <> 1 Then
		ls_log = 	'Nenhum pedido ecommerce foi atualizado.'
		Return False
	End If
				
	if lb_capturado = False Then
	
		Update pedido_ecommerce_auxiliar 
		set de_motivo_cancelamento_pedido = :ls_Motivo
		where cd_filial_ecommerce = :ll_Filial_Ecommerce
			and nr_pedido				= :ll_Pedido_ERP
		Using SqlCa;

	ENd if
			
	If SqlCa.SqlCode = -1 Then
		ls_log = 	'Erro ao gravar o motivo do cancelamento": ~n' + SqlCa.sqlerrtext
		Return False
	End If
	
	If Sqlca.SQLNRows <> 1 Then
		ls_log = 	'Nenhum pedido ecommerce auxiliar foi atualizado.'
		Return False
	End If
				
	Update pedido_ecommerce_entrega
		set id_situacao = 'X'
	where cd_filial_ecommerce = :ll_Filial_Ecommerce
		and nr_pedido = :ll_Pedido_ERP
		and id_situacao = 'A'
	Using SqlCa;

	If SqlCa.SqlCode = -1 Then
		ls_log = 	'Erro ao atualizar a tabela pedido_ecommerce_entrega": ~n' + SqlCa.sqlerrtext
		Return False
	End If
	
	//Cancelar os pedidos Empurrados/Urgentes:
	if Not this.wf_cancela_pedido_empurrado( ls_resp, ls_motivo, ref ls_log) then return false
	
	if lb_usa_pdv_java = False and not isnull(ls_Pedido_DrogaExpress) Then
	
		Update pedido_drogaexpress
		Set id_situacao               = 'X',
			 nr_matricula_cancelamento = :ls_Resp
		Where nr_pedido_drogaexpress = :ls_Pedido_DrogaExpress 			  
		Using itr_Filial;
		
		If itr_Filial.SqlCode = -1 Then
			ls_log = 'Erro ao atualizar a situa$$HEX2$$e700e300$$ENDHEX$$o do pedido na tabela "pedido_drogaexpress": ~n' + itr_Filial.sqlerrtext
			return false
		End IF
		
	End if
				
	lb_sucesso = True

Finally
	
	if Not lb_sucesso then 
			
		sqlca.of_RollBack( )
		if lb_usa_pdv_java = False Then
			if isvalid(itr_filial) then itr_Filial.of_rollback( )
		end if
	
		// Atualiza log com erro
		If luo_log.of_atualiza_ecommerce_log(ll_Filial_Ecommerce, ll_Seq_Log, 'E', ls_Log, gf_getserverdate(), ref ls_Log) Then
			luo_log.of_grava_log_item(ll_Filial_Ecommerce, ll_Seq_Log, ref ls_Log, ls_Log)
		End If
		
		ls_log = iif(IsNull(ls_log), '', ls_log)
	Else
		
		SqlCa.of_Commit()
		if lb_usa_pdv_java = False Then
			if isvalid(itr_filial) then itr_Filial.of_Commit()
		end if
		
		// Marca o log como processado
		If Not luo_log.of_atualiza_ecommerce_log(ll_Filial_Ecommerce, ll_Seq_Log, 'P', ls_MSG_Nula, gf_getserverdate(), ref ls_Log) Then Return False
		luo_log.of_grava_log_item(ll_Filial_Ecommerce, ll_Seq_Log, ref ls_Log, ls_Log)
		
	End If
	
	if lb_usa_pdv_java = False Then
		wf_desconecta_filial()
	end if
	
	destroy(ivo_Conecta_Odbc)
	destroy(itr_Filial)
	destroy(ivo_Odbc)
	destroy(luo_log)
	
	Close(w_Aguarde)
	
	If lb_sucesso then 
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O pedido foi cancelado com sucesso.")
	Else
	 	MessageBox("Erro",  ls_log, StopSign!)
	End If
	
	tab_1.TabPage_1.dw_2.Event ue_Retrieve()
End Try

Return True
end function

public function boolean wf_cancela_pedido_cr (string ps_id_ecommerce, string ps_nr_pedido_ecommerce, long pl_cd_filial, string ps_rede, ref string ps_log);string ls_retorno
string ls_resposta

uo_ge509_comum_consulta_remedio luo_comum
uo_ge073_json luo_json

Try
	
	luo_json = create uo_ge073_json
	
	luo_comum = create uo_ge509_comum_consulta_remedio
	
	if Not luo_comum.of_parametros_ecommerce_filial( pl_cd_filial, ps_rede, ps_id_ecommerce, ref ps_log) then return false
	
	if Not luo_comum.of_patch( '', '/api/v1/store/orders/' + ps_nr_pedido_ecommerce + '/cancel_request', ref ls_retorno, ref ps_log ) then return false
	
	ls_resposta = luo_json.of_busca_conteudo_campo_vtex(ls_retorno, 'success')
	
	if ls_resposta = '' or isnull(ls_resposta) Then
		ps_log = ls_retorno
		return false
	End if
	
Finally
	
	if ps_log <> '' and not isnull(ps_log) Then ps_log = 'Fun$$HEX2$$e700e300$$ENDHEX$$o: wf_cancela_pedido_cr~n' + ps_log
	
	destroy(luo_comum)
	destroy(luo_json)
	
End Try

return true
end function

public function boolean wf_verifica_pedido_faturado (boolean pb_pdv_java, long pl_cd_filial, string ps_nr_pedido, long pl_nr_pedido, ref boolean pb_faturado, ref string ps_log);long ll_notas

Try

	if pb_pdv_java = false Then
					
		Select count(*)
		Into :ll_Notas
		From nf_venda
		Where cd_filial = :pl_cd_Filial
			and nr_pedido_drogaexpress = :ps_nr_pedido
			and dh_cancelamento is null
			and dh_devolucao is null
		Using itr_Filial;
		
		If itr_Filial.SqlCode = -1 Then
			ps_log = 'Problemas ao consultar a tabela "nf_venda": ~n' + itr_Filial.sqlerrtext
			return false
		End If
						
	Else
		
		Select count(*)
		Into :ll_Notas
		From nf_venda
		Where cd_filial = :pl_cd_filial
			and nr_pedido_ecommerce = :pl_nr_pedido
			and dh_cancelamento is null
			and dh_devolucao is null
		Using SQLCA;
		
		If SQLCA.SqlCode = -1 Then
			ps_log = 'Problemas ao consultar a tabela "nf_venda": ~n' + SQLCA.sqlerrtext
			return false
		End If
						
	End if
	
	if ll_notas > 0 then
		pb_faturado = True
	Else
		pb_faturado = false
	End if
	
Finally
	
	if ps_log <> '' and not isnull(ps_log) Then ps_log = 'Fun$$HEX2$$e700e300$$ENDHEX$$o: wf_verifica_pedido_faturado~n' + ps_log
	
End Try
end function

public function boolean wf_busca_situacao_pedido (boolean pb_pdv_java, string ps_nr_pedido, long pl_cd_filial_ecommerce, long pl_nr_pedido, ref string ps_situacao, ref string ps_log);string ls_situacao_loja

Try

	if pb_pdv_java = false then
		
		Select id_situacao 
		Into :ls_Situacao_Loja
		From pedido_drogaexpress
		Where nr_pedido_drogaexpress = :ps_nr_pedido
		Using itr_Filial;
		
		if itr_filial.sqlcode = -1 then
			ps_log = 'Erro ao consultar o pedido na tabela pedido_drogaexpress: ' + itr_filial.sqlerrtext
			return false
		End if
		
	else
		
		Select id_situacao
		into :ls_situacao_loja
		from pedido_ecommerce
		where nr_pedido = :pl_nr_pedido
		and cd_filial_ecommerce = :pl_cd_filial_ecommerce
		Using SQLCA;
		
		if SQLCA.sqlcode = -1 then
			ps_log = 'Erro ao consultar o pedido na tabela pedido_ecommerce: ' + SQLCA.sqlerrtext
			return false
		End if
		
	end if

	if ls_situacao_loja = '' or isnull(ls_situacao_loja) then
		ls_situacao_loja = 'A'
	End if

	ps_situacao = ls_situacao_loja

Finally
	
	if ps_log <> '' and not isnull(ps_log) Then ps_log = 'Fun$$HEX2$$e700e300$$ENDHEX$$o: wf_busca_situacao_pedido~n' + ps_log
	
End Try

return true
end function

public function boolean wf_cancela_pedido_vtex (long pl_cd_filial, long pl_cd_seller, long pl_cd_filial_ecommerce, long pl_nr_pedido, string ps_nr_pedido_ecommerce, string ps_rede, decimal pdc_vl_venda, string ps_motivo, ref boolean pb_capturado, ref string ps_log);string ls_Cod_Transacao
string ls_retorno
string ls_Cod_Transacao_conector
string ls_conector_pagamento
string ls_nsu_captura
string ls_nr_autorizacao
string ls_Valor_Venda
string ls_Json
string ls_RetAPI_Status
string ls_RetAPI_Valor

boolean lb_capturado=false

datetime ldh_captura

uo_ge501_comum luo_comum_vtex
uo_ge073_json luo_json

Try

	luo_comum_vtex = create uo_ge501_comum
	luo_json = create uo_ge073_json
	
	//Carrega os parametros e busca o c$$HEX1$$f300$$ENDHEX$$digo da filial vinculado a rede.
	if Not luo_comum_vtex.of_parametros_ecommerce_filial(pl_cd_seller, ps_Rede, '2', ref ps_log ) Then return false
	
	Select de_codigo_transacao 
	Into :ls_Cod_Transacao
	From pedido_ecommerce_auxiliar
	where cd_filial_ecommerce = :pl_cd_Filial_Ecommerce
		and nr_pedido				= :pl_nr_pedido
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		ps_log = 'Erro ao consultar o c$$HEX1$$f300$$ENDHEX$$digo da transa$$HEX2$$e700e300$$ENDHEX$$o do cart$$HEX1$$e300$$ENDHEX$$o": ~n' + SqlCa.sqlerrtext
		Return False
	End If
		
	If IsNull(ls_Cod_Transacao) or Trim(ls_Cod_Transacao) = '' Then
		ps_log = 'Nr da transa$$HEX2$$e700e300$$ENDHEX$$o do cart$$HEX1$$e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o foi localizado.'
		Return False
	End If		
		
	luo_comum_vtex.is_url = gf_replace(luo_comum_vtex.is_url, 'myvtex.com', 'vtexpayments.com.br', 0 )
		
	//Acessa o site para buscar as informa$$HEX2$$e700f500$$ENDHEX$$es de pagamento da transacao
	if Not luo_comum_vtex.of_get( gf_replace( "/api/pvt/transactions/XXX/payments", 'XXX', ls_Cod_Transacao, 0 ) , ref ls_retorno, ref ps_log ) then return false
		
	ls_Cod_Transacao_conector = luo_json.of_busca_conteudo_campo_vtex(ls_retorno, 'tid')
	ls_conector_pagamento = luo_json.of_busca_conteudo_campo_vtex(ls_retorno, 'connector')
	
	If upper(ls_conector_pagamento) = 'ESITEF' then
		
		//Verificar se o pagamento foi capturado. Se foi, nao realizar cancelameno da transacao e emitir alerta para avisar o setor financeiro pra fazer estorno ao cliente.
		if not this.wf_verifica_capturado_vtex( luo_comum_vtex.is_url_conector , luo_comum_vtex.is_chave_conector , luo_comum_vtex.is_token_conector , ls_Cod_Transacao_conector, ref lb_capturado, ref ls_nsu_captura, ref ls_nr_autorizacao, ref ldh_captura, ref ps_log ) then return false
				
	Else		
		lb_capturado = false
	End if		
		
	if lb_capturado = True Then
			
		Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'O pagamento desse pedido foi capturado de forma autom$$HEX1$$e100$$ENDHEX$$tica pela VTEX.~nInformar ao setor financeiro para realizar o estorno do valor ao cliente.~nSegue abaixo os dados da captura:~n~n' + &
						'Pedido: ' + string (pl_nr_pedido) + '~nFilial: ' + string(pl_cd_Filial) + '~nNSU: ' + ls_nsu_captura + '~nData da captura: ' + String(ldh_captura,'dd/mm/yyyy hh:mm'), Exclamation!)
		
	Else
	
		if pdc_vl_venda >= 1 then
			ls_Valor_Venda = gf_replace(String(pdc_vl_venda), ',', '', 0 )
		else
			ls_Valor_Venda = right(String(pdc_vl_venda),2)
		end if
			
		ls_Json = '{"value":' + ls_Valor_Venda + '}'
		
		luo_comum_vtex.is_nr_pedido_ecommerce = ps_nr_pedido_ecommerce
		luo_comum_vtex.il_cd_filial_pedido 			= pl_cd_filial
		luo_comum_vtex.is_json 						= ls_Json
		
		// Seta para true para pegar o retorno do cancelamento da transa$$HEX2$$e700e300$$ENDHEX$$o
		luo_comum_vtex.ib_utiliza_retorno = True
		
		if Not luo_comum_vtex.of_post(ls_Json, 'api/pvt/transactions/' + ls_Cod_Transacao + '/cancellation-request' , ref ls_retorno, ref ps_log ) then return false
		
		If Not IsNull(ls_retorno) and Trim(ls_retorno) <> '' Then
			
			ls_RetAPI_Status = luo_json.of_busca_conteudo_campo(ls_retorno, 'status')
			ls_RetAPI_Valor = luo_json.of_busca_conteudo_campo(ls_retorno, 'cancelledValue')
			
			If IsNull(ls_RetAPI_Status) or Trim(ls_RetAPI_Status) = '' or ls_RetAPI_Status <> '10' Then
				ps_log = 'Transa$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o foi cancelada - REFA$$HEX1$$c700$$ENDHEX$$A O PROCEDIMENTO NO SITE.'
				Return False
			End If		
			
			If Not IsNull(ls_RetAPI_Valor) and Trim(ls_RetAPI_Valor) <> '' Then
				If ls_RetAPI_Valor <> ls_Valor_Venda Then
					ps_log = 'Valor da transa$$HEX2$$e700e300$$ENDHEX$$o cancelada esta diferente do valor solicitado - REFA$$HEX1$$c700$$ENDHEX$$A O PROCEDIMENTO NO SITE.'
					Return False
				End If
			Else
				ps_log = 'A API de cancelamento n$$HEX1$$e300$$ENDHEX$$o devolveu o valor da transa$$HEX2$$e700e300$$ENDHEX$$o - REFA$$HEX1$$c700$$ENDHEX$$A O PROCEDIMENTO NO SITE.'
				Return False
			End If		
			
		Else
			ps_log = 'API n$$HEX1$$e300$$ENDHEX$$o devolveu o retorno do cancelamento do cart$$HEX1$$e300$$ENDHEX$$o.'
			Return False
		End If
		
	End if
	
	luo_comum_vtex.is_url = gf_replace(luo_comum_vtex.is_url, 'vtexpayments.com.br','myvtex.com', 0 )
	
	// PRIMEIRA CHAMADA
	//https://bazarhorizonte.vtexcommercestable.com.br/api/oms/pvt/orders/{{pedido}}/cancel
	if Not luo_comum_vtex.of_post( '', '/api/oms/pvt/orders/' + iif(pl_cd_seller = 809, '', 'SLR-') + ps_nr_Pedido_Ecommerce + '/cancel' , ref ls_retorno, ref ps_log ) then return false
	
	// SEGUNDA CHAMADA
	//https://bazarhorizonte.vtexcommercestable.com.br/api/oms/pvt/orders/{{pedido}}/cancel
	if Not luo_comum_vtex.of_post( '', '/api/oms/pvt/orders/' + iif(pl_cd_seller = 809, '', 'SLR-') + ps_nr_Pedido_Ecommerce + '/cancel' , ref ls_retorno, ref ps_log ) then return false
	
	if lb_capturado = True Then
		
		Update pedido_ecommerce_auxiliar 
		set de_motivo_cancelamento_pedido = :ps_Motivo, nr_nsu_host = :ls_nsu_captura, dh_confirmacao_faturamento = :ldh_captura
		where cd_filial_ecommerce = :pl_cd_filial_ecommerce
			and nr_pedido				= :pl_nr_pedido
		Using SqlCa;
	
		If SqlCa.SqlCode = -1 Then
			ps_log = 'Erro ao atualizar a tabela pedido_ecommerce_auxiliar": ~n' + SqlCa.sqlerrtext
			Return False
		End If
	
	End if
	
	pb_capturado = lb_capturado
	
Finally
	
	if ps_log <> '' and not isnull(ps_log) Then ps_log = 'Fun$$HEX2$$e700e300$$ENDHEX$$o: wf_cancela_pedido_vtex~n' + ps_log
	
	destroy(luo_comum_vtex)
	destroy(luo_json)
	
End Try

return true
end function

public function boolean wf_cancela_pedido_empurrado (string ps_usuario, string ps_motivo, ref string ps_log);long ll_linhas
long ll_for
long ll_nr_pedido_empurrado
long ll_cd_filial

string ls_id_situacao
string ls_id_tipo_pedido


Tab_1.TabPage_5.dw_7.Event ue_Retrieve()

ll_linhas = tab_1.tabpage_5.dw_7.rowcount()

for ll_for = 1 to ll_linhas
	
	ll_cd_filial = tab_1.tabpage_5.dw_7.object.cd_filial[ll_for]
	ll_nr_pedido_empurrado = tab_1.tabpage_5.dw_7.object.nr_pedido_empurrado[ll_for]
	ls_id_tipo_pedido = tab_1.tabpage_5.dw_7.object.id_tipo_pedido[ll_for]
	ls_id_situacao = tab_1.tabpage_5.dw_7.object.id_situacao[ll_for]
	
	if ls_id_tipo_pedido <> 'U' Then Continue
	
	Choose Case ls_id_situacao
		Case 'C','P','B'
			
			Update pedido_empurrado
			set id_situacao = 'X', dh_cancelamento = getdate(), nr_matricula_cancelamento = :ps_usuario, de_motivo_cancelamento = :ps_motivo
			where cd_filial = :ll_cd_filial
			and nr_pedido_empurrado = :ll_nr_pedido_empurrado;
			
			if sqlca.sqlcode = -1 then
				ps_log = 'Erro ao atualizar a tabela pedido_empurrado: ' + sqlca.sqlerrtext
				return false
			ENd if

			Update pedido_empurrado_produto
			set id_situacao = 'X', qt_empurrada = 0, qt_aprovada = 0
			where cd_filial = :ll_cd_filial
			and nr_pedido_empurrado = :ll_nr_pedido_empurrado;
			
			if sqlca.sqlcode = -1 then
				ps_log = 'Erro ao atualizar a tabela pedido_empurrado_produto: ' + sqlca.sqlerrtext
				return false
			ENd if
			
		Case Else
			Continue
	End Choose
	
Next

return true
end function

public function boolean wf_conecta_banco_java (integer al_filial, dc_uo_odbc ao_odbc, ref string as_erro, ref dc_uo_transacao ao_transacao);String	ls_DataBase,&
		ls_ServerName,&
		ls_Ip,&
		ls_Odbc
		
select		de_database,
			de_servername,
			de_ip
Into	:ls_DataBase,
		:ls_ServerName,
		:ls_Ip
from parametro_odbc
where cd_filial = :al_Filial
using SqlCa;

Choose Case SqlCa.SqlCode
	Case 100
		as_Erro = "Par$$HEX1$$e200$$ENDHEX$$metros do sistema n$$HEX1$$e300$$ENDHEX$$o localizados para criar a ODBC da filial "+String(al_Filial)+"."
		Return False
	Case -1
		as_Erro = "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o dos par$$HEX1$$e200$$ENDHEX$$metros do ODBC da filial "+String(al_Filial)+".~rErro: " + SqlCa.SqlErrText
		Return False
End Choose

ls_Odbc = String(al_Filial, "0000")	

If SQLCa.Database = 'homologa' then
		ao_Odbc.ivs_DataBase		= ls_DataBase
		ao_Odbc.ivs_ServerName	= ls_ServerName
		ao_Odbc.ivs_ip					= "10.0.4.87"
		ao_Odbc.ivs_Pdv_Java		= 'S'
		
		ao_Odbc.of_grava_regedit_odbc(al_Filial)
Else
	ao_Odbc.ivs_DataBase		= ls_DataBase
	ao_Odbc.ivs_ServerName	= ls_ServerName
	ao_Odbc.ivs_ip					= ls_Ip 
	ao_Odbc.ivs_Pdv_Java		= 'S'
	
	ao_Odbc.of_grava_regedit_odbc(al_Filial)
End If
	
If ao_Odbc.of_Connect(ls_Odbc, 'dbo', 'teste') Then
		ao_transacao.ivs_database = "POSTGRESQL_JAVA"
	If Not ao_transacao.of_Connect(ls_Odbc, "") Then 
		as_Erro = "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel conectar no banco de dados da filial.~r~rFilial "+String(al_Filial)+"."
		Return False
	End If			
Else
	as_Erro = "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel conectar no banco de dados da filial.~r~rFilial "+String(al_Filial)+"."
	Return False
End If
 
Return True
end function

public function boolean wf_verifica_cancelamento_pdv_novo (integer al_filial, long al_pedido, ref string as_motivo);String	 ls_Erro

Boolean id_Pode_Cancelar
Try 
	dc_uo_Odbc lvo_Odbc
	lvo_Odbc = Create dc_uo_Odbc
	
	dc_uo_transacao Transact_Saldo
	Transact_Saldo = create dc_uo_transacao
	
	wf_conecta_banco_java(al_filial, lvo_Odbc, ref ls_Erro, ref Transact_Saldo )
	
	Select case when id_pode_cancelar = 'S' then True else False end,  de_motivo 
	into :id_Pode_Cancelar, :as_motivo
	from integ.vw_pedido_plataforma_sit_canc_matriz
	where cd_filial = :al_filial and nr_pedido = :al_pedido
	Using Transact_Saldo;
	
	Choose Case Transact_Saldo.SqlCode
	Case 0
		if not id_Pode_Cancelar then return false
		Return True
	Case -1
		as_motivo = "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o dos dados do pedido no pgsql [wf_verifica_cancelamento_pdv_novo .~rErro: " + SqlCa.SqlErrText
		Return False
End Choose
	
Finally 
	if IsValid(lvo_Odbc) then destroy(lvo_Odbc)
	if IsValid(Transact_Saldo) then destroy(Transact_Saldo)
End Try

return true
end function

on w_ge504_consulta_pedido_ecommerce.create
int iCurrent
call super::create
this.tab_1=create tab_1
this.st_confirmar=create st_confirmar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
this.Control[iCurrent+2]=this.st_confirmar
end on

on w_ge504_consulta_pedido_ecommerce.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_1)
destroy(this.st_confirmar)
end on

event ue_postopen;call super::ue_postopen;datawindowchild ldwc_ecommerce

Tab_1.TabPage_1.dw_1.getchild( 'id_origem', ref ldwc_ecommerce )

ldwc_ecommerce.settransobject( SQLCA )
if ldwc_ecommerce.retrieve() > 1 Then
	ldwc_ecommerce.insertrow( 1 )
	ldwc_ecommerce.setitem(1, 'id_ecommerce', 'T' )
	ldwc_ecommerce.setitem(1, 'nm_ecommerce', 'TODOS' )
end if

Tab_1.TabPage_1.dw_1.of_SetMenu(This.ivm_Menu)
Tab_1.TabPage_1.dw_2.of_SetMenu(This.ivm_Menu)

Tab_1.TabPage_1.dw_1.ivo_Controle_Menu.of_Recuperar(True)
Tab_1.TabPage_1.dw_2.ivo_Controle_Menu.of_Recuperar(True)

Tab_1.TabPage_1.dw_2.ivo_Controle_Menu.of_SalvarComo(True)
//Parent.ivm_Menu.mf_SalvarComo(True)

Tab_1.TabPage_1.dw_1.Event ue_AddRow()
Tab_1.TabPage_1.dw_1.SetFocus()

ivo_Cliente_Central = Create uo_Cliente_Central
io_api					= Create dc_uo_api

Tab_1.TabPage_1.dw_1.Object.dt_Termino[1] = gvo_Parametro.of_DH_Movimentacao()
Tab_1.TabPage_1.dw_1.Object.dt_Inicio [1] = DateTime(RelativeDate(Date(gvo_Parametro.of_DH_Movimentacao()), -10))






end event

event close;call super::close;Destroy(ivo_Cliente_Central)
Destroy(ivo_filial)
Destroy(io_api)
//destroy(iuo_ecommerce_vannon)
end event

event open;call super::open;ivo_filial= create uo_filial

//iuo_eCommerce_Vannon = create uo_ecommerce_vannon

if gvo_Aplicacao.ivo_Seguranca.Cd_Sistema <> 'EC' Then
	tab_1.tabpage_1.dw_2.modify('st_rastrear.visible=0')
end if
end event

type dw_visual from dc_w_sheet`dw_visual within w_ge504_consulta_pedido_ecommerce
end type

type gb_aux_visual from dc_w_sheet`gb_aux_visual within w_ge504_consulta_pedido_ecommerce
end type

type tab_1 from tab within w_ge504_consulta_pedido_ecommerce
integer x = 5
integer width = 4658
integer height = 2084
integer taborder = 10
boolean bringtotop = true
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long backcolor = 80269524
boolean raggedright = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
tabpage_3 tabpage_3
tabpage_4 tabpage_4
tabpage_5 tabpage_5
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.tabpage_3=create tabpage_3
this.tabpage_4=create tabpage_4
this.tabpage_5=create tabpage_5
this.Control[]={this.tabpage_1,&
this.tabpage_2,&
this.tabpage_3,&
this.tabpage_4,&
this.tabpage_5}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
destroy(this.tabpage_3)
destroy(this.tabpage_4)
destroy(this.tabpage_5)
end on

event selectionchanging;SetPointer(HourGlass!)

Choose Case NewIndex 
		
	Case 2 
		If Tab_1.TabPage_1.dw_2.GetRow() > 0 Then
			// Executa o evento de recupera$$HEX2$$e700e300$$ENDHEX$$o das linhas
			// das DW's de detalhes
			Tab_1.TabPage_2.dw_3.Event ue_Retrieve()
	
			// Permite a troca do folder
			Return 0
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma linha da lista para visualizar os detalhes.", StopSign!)
			// N$$HEX1$$e300$$ENDHEX$$o permite a troca do folder
			Return 1
		End If

	Case  3 
		If Tab_1.TabPage_1.dw_2.GetRow() > 0 Then
			// Executa o evento de recupera$$HEX2$$e700e300$$ENDHEX$$o das linhas
			// das DW's de detalhes
			Tab_1.TabPage_3.dw_4.Event ue_Retrieve()
	
			// Permite a troca do folder
			Return 0
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma linha da lista para visualizar os detalhes.", StopSign!)
			// N$$HEX1$$e300$$ENDHEX$$o permite a troca do folder
			Return 1
		End If

	Case 4
		
		If Tab_1.TabPage_1.dw_2.GetRow() > 0 Then
			// Executa o evento de recupera$$HEX2$$e700e300$$ENDHEX$$o das linhas
			// das DW's de detalhes
			Tab_1.TabPage_4.dw_6.Event ue_Retrieve()
	
			// Permite a troca do folder
			Return 0
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma linha da lista para visualizar os detalhes.", StopSign!)
			// N$$HEX1$$e300$$ENDHEX$$o permite a troca do folder
			Return 1
		End If

	Case 5
		
		If Tab_1.TabPage_1.dw_2.GetRow() > 0 Then
			// Executa o evento de recupera$$HEX2$$e700e300$$ENDHEX$$o das linhas
			// das DW's de detalhes
			Tab_1.TabPage_5.dw_7.Event ue_Retrieve()
	
			// Permite a troca do folder
			Return 0
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma linha da lista para visualizar os detalhes.", StopSign!)
			// N$$HEX1$$e300$$ENDHEX$$o permite a troca do folder
			Return 1
		End If

End Choose

SetPointer(Arrow!)
end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4622
integer height = 1964
long backcolor = 80269524
string text = "Pedidos"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
cb_reenviar_entrega cb_reenviar_entrega
cb_cancelar cb_cancelar
cb_refaturar cb_refaturar
cb_transportadora cb_transportadora
cb_pedido_entregue cb_pedido_entregue
gb_2 gb_2
gb_1 gb_1
dw_1 dw_1
dw_2 dw_2
cb_etiqueta cb_etiqueta
dw_5 dw_5
end type

on tabpage_1.create
this.cb_reenviar_entrega=create cb_reenviar_entrega
this.cb_cancelar=create cb_cancelar
this.cb_refaturar=create cb_refaturar
this.cb_transportadora=create cb_transportadora
this.cb_pedido_entregue=create cb_pedido_entregue
this.gb_2=create gb_2
this.gb_1=create gb_1
this.dw_1=create dw_1
this.dw_2=create dw_2
this.cb_etiqueta=create cb_etiqueta
this.dw_5=create dw_5
this.Control[]={this.cb_reenviar_entrega,&
this.cb_cancelar,&
this.cb_refaturar,&
this.cb_transportadora,&
this.cb_pedido_entregue,&
this.gb_2,&
this.gb_1,&
this.dw_1,&
this.dw_2,&
this.cb_etiqueta,&
this.dw_5}
end on

on tabpage_1.destroy
destroy(this.cb_reenviar_entrega)
destroy(this.cb_cancelar)
destroy(this.cb_refaturar)
destroy(this.cb_transportadora)
destroy(this.cb_pedido_entregue)
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.cb_etiqueta)
destroy(this.dw_5)
end on

type cb_reenviar_entrega from commandbutton within tabpage_1
integer x = 1134
integer y = 1856
integer width = 521
integer height = 100
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Reenviar Entrega"
end type

event clicked;wf_equilibrium_reenviar_pedido(false,'')
end event

type cb_cancelar from commandbutton within tabpage_1
integer x = 3858
integer y = 1856
integer width = 553
integer height = 100
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Cancelar Pedido"
end type

event clicked;wf_cancela_pedido()
Return 1

end event

type cb_refaturar from commandbutton within tabpage_1
integer x = 27
integer y = 1856
integer width = 521
integer height = 100
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Refaturar"
end type

event clicked;Long ll_Pedido_Ecommerce, ll_Linha,ll_Filial, ll_Filial_Ec
Long ll_Sequencial

Boolean lb_Sucesso = False

String ls_Matricula
String ls_Motivo
String ls_Pedido_Novo
String ls_Pedido_DrogaExpress
String ls_Situacao //Somente M- Remetido a Transp
String ls_nm_transportadora
String ls_nr_pedido_equilibrium
String ls_log, ls_id_plataforma, ls_nm_ecommerce
uo_ge516_comum_ecommerce luo_log

Try
	dw_2.AcceptText()
	
	ll_Linha = dw_2.GetRow()
	
	ll_Filial_Ec					= dw_2.Object.cd_filial_ecommerce 		[ ll_Linha ]
	ll_Pedido_Ecommerce		= dw_2.Object.Nr_Pedido 					[ ll_Linha ]
	ls_Pedido_DrogaExpress	= dw_2.Object.nr_pedido_drogaexpress	[ ll_Linha ]
	ll_Filial						= dw_2.Object.cd_filial						[ ll_Linha ]
	ls_Situacao  				= dw_2.Object.id_situacao					[ ll_Linha ]
	ls_nm_transportadora	= dw_2.Object.nm_transportadora		[ ll_Linha ]
	ls_nr_pedido_equilibrium= dw_2.Object.id_pedido_equilibrium		[ ll_Linha ]
	
	ls_id_plataforma = dw_2.Object.id_plataforma[ ll_Linha ]
	ls_nm_ecommerce = dw_2.Object.nm_ecommerce[ ll_Linha ]
	
	if ls_id_plataforma <> '2' and ls_id_plataforma <> '5' then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", 'Processo n$$HEX1$$e300$$ENDHEX$$o dispon$$HEX1$$ed00$$ENDHEX$$vel para pedidos da plataforma: ' + ls_nm_ecommerce )
		return -1
	end if
	
	If Not IsNull(dw_2.Object.nr_pedido_ecommerce[ ll_Linha ]) Then
		If dw_2.Object.id_tipo_entrega[ ll_Linha ] = 'ECT' and Not IsNull(dw_2.Object.de_codigo_rastreamento_correio[ ll_Linha ]) Then
			
			Update ecommerce_reserva_etiqueta
			set nr_pedido = 1
			where cd_filial_ecommerce = :ll_Filial_Ec
				and nr_pedido = :ll_Pedido_Ecommerce
				Using SQLCA;
				
			If SqlCa.SqlCode = -1 Then
				SqlCa.of_Rollback();
				SqlCa.of_MsgDbError("Erro ao desfazer o v$$HEX1$$ed00$$ENDHEX$$nculo do pedido com a etiqueta do correio. Pedido: " + String( ll_Pedido_Ecommerce ) )
				Return -1
			End If	
			
//			///necess$$HEX1$$e100$$ENDHEX$$rio colocar um update para mudar a referencia na tabela ecommerce_reserva_etiqueta, o nr_pedido = 1
//			// QUANTO ALTERAR O TIPO DE ENTREGA, MUDAR TAMBEM O CD_TIPO_ENTREGA
//			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Funcionalidade n$$HEX1$$e300$$ENDHEX$$o dispon$$HEX1$$ed00$$ENDHEX$$vel para pedido da VTEX.~r~rTI: Ser$$HEX1$$e100$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio colocar um UPDATE para zerar o v$$HEX1$$ed00$$ENDHEX$$nculo da etiqueta do correio - mudar o pedido para 1.")	
//			Return -1
		End If
	End If

	If ls_Situacao <> 'M' And ls_Situacao <> 'C' And ls_Situacao <> 'E' Then
		SqlCa.of_Rollback();
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Situa$$HEX2$$e700e300$$ENDHEX$$o do pedido n$$HEX1$$e300$$ENDHEX$$o dispon$$HEX1$$ed00$$ENDHEX$$vel para refaturamento.")	
		Return -1
	End If
	
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Deseja liberar o refaturamento do pedido " + String(ll_Pedido_Ecommerce) + " ?", Question!, YesNo!, 2) = 2 Then
		SqlCa.of_Rollback();
		Return -1
	End If

	OpenWithParm( w_justificativa, '05Informe o motivo do refaturamento.' )
	
	ls_Motivo = 	Message.StringParm
	
	If IsNull( ls_Motivo ) Then
		Return -1
	End If
	
	//Solicitar Matricula Senha
	If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("EC001_REFATURAR", Ref ls_Matricula) Then 
		Return -1
	End If
	
	//Desenv
	//ll_Filial = 13
	
	luo_log = create uo_ge516_comum_ecommerce
	
	is_Odbc_desenv = luo_log.of_desenvolvimento_odbc_baixa_pedido()
	
	If Not wf_Conecta_Filial(ll_Filial, ref ls_Log) Then Return -1
	
//	If Not wf_Conecta_Destino( ll_Filial ) Then
//		Return -1
//	End If
	
	If Not wf_Proximo_Pedido_DrogaExpress( ll_Filial, Ref ls_Pedido_Novo, ref ls_log) Then Return -1
		
	If wf_Insert_Pedido_DrogaExpress(  ls_Pedido_DrogaExpress, ls_Pedido_Novo, ref ls_log ) Then
		If wf_Insert_Produtos_DrogaExpress( ls_Pedido_DrogaExpress, ls_Pedido_Novo, ref ls_log ) Then	
			lb_Sucesso = True
		End If
	End If
		
	If lb_Sucesso Then
			
//		if ls_nm_transportadora = 'ENTREGA EXPRESSA' or ls_nm_transportadora = 'ENTREGA ECON$$HEX1$$d400$$ENDHEX$$MICA' then
//			if Not wf_equilibrium_reenviar_pedido(True, ls_Pedido_Novo) then 
//				lb_sucesso = false
//				return -1
//			end if
//		end if

		//Atualiza Pedido Matriz
		Update pedido_ecommerce
			set nr_matricula_refaturamento 	= :ls_Matricula,
				dh_refaturamento					= getDate(),
				de_motivo_refaturamento		= :ls_Motivo	,
				id_situacao							= 'A',
				dh_faturado							= null,
				nr_pedido_drogaexpress			= :ls_Pedido_Novo,
				de_codigo_rastreamento_correio = null,
				de_url_rastreio 						= null
		Where cd_filial_ecommerce  		= :ll_Filial_Ec
			and nr_pedido 				 		= :ll_Pedido_Ecommerce
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			ls_log = 'Problemas ao atualizar registro na tabela pedido_ecommerce: ' + Sqlca.sqlerrtext
			SqlCa.of_Rollback();
			SqlCa.of_MsgDbError("Erro ao marcar o pedido como refaturado. Pedido " + String( ll_Pedido_Ecommerce ) )
			Return -1
		End If
	
//		//SE J$$HEX1$$e100$$ENDHEX$$ existe um pedido na Equilibrium, nesse caso fazer o cancelamento.
//		if ls_nr_pedido_equilibrium <> '' and not isnull(ls_nr_pedido_equilibrium) Then
//			if Not wf_equilibrium_cancela_pedido( ll_Filial_Ec, ll_Pedido_Ecommerce, ls_nr_pedido_equilibrium, ref ls_log) then 
//				lb_sucesso = false
//				return -1
//			end if
//		ENd if
	
		itr_filial.of_Commit( );
		SqlCa.of_commit( );
	
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Pedido liberado para o refaturamento.")
		
		dw_2.Event ue_Retrieve()
		
		Return 1
		
	End If
		
Finally
	
	if lb_sucesso = false then
		if isvalid(itr_filial) Then
			itr_filial.of_rollback( );
		ENd if
		SqlCa.of_Rollback();
		
		if ls_log <> '' and not isnull(ls_log) Then
			messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_log, stopsign!)
		end if
		
	end if
	
	wf_desconecta_filial()

	If IsValid( ivo_Odbc ) Then Destroy ivo_Odbc
End Try
	


end event

type cb_transportadora from commandbutton within tabpage_1
integer x = 1861
integer y = 1852
integer width = 667
integer height = 100
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Alterar Mod. Entrega"
end type

event clicked;string ls_log

dw_2.AcceptText()

If dw_2.getrow( ) = 0 Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Um pedido deve ser localizado para alterar a modalidade de entrega.", Exclamation! )
	Return -1
End If

if Not wf_alterar_mod_entrega(ref ls_log) then
	messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o',ls_log, Exclamation!)
	return -1
end if



end event

type cb_pedido_entregue from commandbutton within tabpage_1
integer x = 2578
integer y = 1852
integer width = 667
integer height = 100
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Marcar como Entregue"
end type

event clicked;Boolean lvb_Sucesso = False

String lvs_Tabela
String lvs_Set
String lvs_Where

String ls_Situacao
String ls_Matricula
String ls_Selecao

Long ll_Retorno
Long ll_Pedido
Long ll_Linhas
Long ll_Row
Long ll_Filial_EC

ll_Linhas = Tab_1.TabPage_1.dw_2.RowCount()

If Tab_1.TabPage_1.dw_2.Find("id_selecao='S'", 0, ll_Linhas ) = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Nenhum pedido foi selecionado.")
	Return
End If

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Deseja atribuir a situa$$HEX2$$e700e300$$ENDHEX$$o 'ENTREGUE' para o(s) pedido(s) selecionado(s)?", Question!, YesNo!, 2) = 2 Then 
	Return 
End If

ls_Matricula	= gvo_Aplicacao.ivo_Seguranca.Nr_Matricula

Open(w_Aguarde)
w_Aguarde.Title = "Atualizando pedido ECOMMERCE na matriz."
w_Aguarde.uo_Progress.of_SetMax( ll_Linhas )

For ll_Row = 1 To ll_Linhas
	
	w_Aguarde.uo_Progress.of_SetProgress( ll_Linhas )
	
	ls_Selecao = Tab_1.TabPage_1.dw_2.Object.id_selecao			[ ll_Row ]

	If ls_Selecao = "S" Then
		
		ls_Situacao	= Tab_1.TabPage_1.dw_2.Object.id_situacao				[ ll_Row ]
		ll_Pedido		= Tab_1.TabPage_1.dw_2.Object.nr_pedido				[ ll_Row ]
		ll_Filial_EC	= Tab_1.TabPage_1.dw_2.Object.cd_filial_ecommerce	[ ll_Row ]
		
		w_Aguarde.Title = "Atualizando o pedido "+String(ll_Pedido)
		
		// N$$HEX1$$e300$$ENDHEX$$o faz para a VTEX
		If Not IsNull(Tab_1.TabPage_1.dw_2.Object.nr_pedido_ecommerce[ ll_Row ]) Then 	Continue
		
		uo_Transacao_Remota lvo_Conexao
		lvo_Conexao = Create uo_Transacao_Remota
		
		If gvo_Aplicacao.ivs_DataSource = 'central' Then lvo_Conexao.of_BancoProducao()
							 
		lvs_Tabela	= "pedido_ecommerce"
		
		lvs_Set		  =  " id_situacao = 'E', "
		lvs_Set		+= " dh_alteracao_situacao = getdate(), "
		lvs_Set      	+= " nr_matric_alteracao_situacao = '" + ls_Matricula + "'"
		
		lvs_Where    = " cd_filial_ecommerce = " + String( ll_Filial_EC ) + " and nr_pedido = "  + String(ll_Pedido)
												 
		If Not lvo_Conexao.of_Update_Registro(lvs_Tabela, lvs_Set, lvs_Where, Ref ll_Retorno) Then
			  MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na altera$$HEX2$$e700e300$$ENDHEX$$o do pedido eCommerce '" + String(ll_Pedido) + "'.", StopSign!)    
		End If    
				
		Destroy(lvo_Conexao)
		
	End If
	
Next

Close(w_Aguarde)

Tab_1.TabPage_1.dw_2.Event ue_Retrieve()


end event

type gb_2 from groupbox within tabpage_1
integer x = 27
integer y = 596
integer width = 4576
integer height = 1224
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
string text = "Lista"
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within tabpage_1
integer x = 27
integer y = 28
integer width = 4581
integer height = 568
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
borderstyle borderstyle = styleraised!
end type

type dw_1 from dc_uo_dw_base within tabpage_1
integer x = 55
integer y = 96
integer width = 4320
integer height = 488
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge504_selecao"
end type

event constructor;call super::constructor;This.of_SetColSelection(True)
end event

event getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
end event

event ue_key;String lvs_Coluna
Integer lvi_Nulo
SetNull(lvi_Nulo)
dw_1.AcceptText()

If Key = KeyEnter! Then
	
	lvs_Coluna = This.GetColumnName()
	
	If lvs_Coluna = 'nm_filial' Then
		ivo_Filial.of_Localiza_Filial(dw_1.GetText())
		If ivo_Filial.Localizada Then	
			this.Object.Cd_Filial[1]   = ivo_Filial.Cd_Filial
			this.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
		Else
			this.Object.Cd_Filial[1]   = lvi_Nulo
			this.Object.Nm_filial[1] = ""	
		End If
		
		//wf_Localiza_Filial()
		
	End If
End If





end event

event editchanged;call super::editchanged;dw_2.Event ue_Reset()
end event

event itemchanged;call super::itemchanged;Long lvl_Nulo

If dwo.Name = "nm_filial" Then	
	SetNull(lvl_Nulo)	
	If Data = "" Or IsNull(Data) Then
		This.Object.Cd_Filial[1] = lvl_nulo
		Return 0
	End If			
	If Data <> ivo_Filial.Nm_Fantasia Then Return 1
End if

dw_2.Event ue_Reset()
end event

type dw_2 from dc_uo_dw_base within tabpage_1
event ue_mousemove pbm_mousemove
integer x = 64
integer y = 652
integer width = 4517
integer height = 1140
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge504_lista"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event ue_mousemove;If This.RowCount() > 0 Then
	If	((xpos >= Long(This.Object.id_imagem.X)) and (xpos <= (Long(This.Object.id_imagem.X) + Long(This.Object.id_imagem.width)))) and  ((ypos >= Long(This.Object.id_imagem.y)) and (ypos <= (Long(This.Object.id_imagem.y) + Long(This.Object.id_imagem.Height))))Then
		
		st_confirmar.Visible = True
		
		If ivb_Check Then
			st_confirmar.Text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para desmarcar todos."
		Else
			st_confirmar.Text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para marcar todos."
		End If
	Else
		st_confirmar.Visible = False
	End If
End If
end event

event ue_preretrieve;call super::ue_preretrieve;String ls_Cliente
String ls_situacao
String ls_Refaturado
String ls_rede_ecommerce
String ls_Pedido
String ls_Origem
String ls_de_tipo_entrega
String ls_CPF
String ls_Tipo_Pagto
String ls_controlado
String ls_termolabil
String ls_id_tipo_pedido
String ls_nr_autorizacao, lvs_nr_pedido_plataforma, ls_administradora

DateTime ldh_Periodo_De
DateTime ldh_Periodo_Ate

Decimal ldc_Valor
Decimal ldc_Valor_ate
		 
Long ll_Filial
//Long ll_nr_pedido  //tranformar em variavel de instancia
Long ll_filial_ecommerce
Long ll_Dias
Long ll_Produto
Long ll_administradora

Tab_1.TabPage_1.dw_1.AcceptText( )

ll_Filial          			= Tab_1.TabPage_1.dw_1.object.cd_filial  		 			[1]
ldh_Periodo_de     	= Tab_1.TabPage_1.dw_1.object.dt_inicio  					[1]
ldh_Periodo_ate    	= Tab_1.TabPage_1.dw_1.object.dt_termino 				[1]
ls_Situacao        		= Tab_1.TabPage_1.dw_1.object.id_situacao				[1]
ls_Pedido	       		= Tab_1.TabPage_1.dw_1.object.nr_pedido	 		 	[1]
ls_de_tipo_entrega 	= Tab_1.TabPage_1.dw_1.object.de_tipo_entrega		[1]
ls_Refaturado			= Tab_1.TabPage_1.dw_1.object.id_refaturado			[1]
ls_rede_ecommerce	= Tab_1.TabPage_1.dw_1.object.id_rede_ecommerce	[1]
ls_Origem				= Tab_1.TabPage_1.dw_1.object.id_origem				[1]
ldc_Valor					= Tab_1.TabPage_1.dw_1.object.vl_pedido					[1]
ldc_Valor_ate			= Tab_1.TabPage_1.dw_1.object.vl_pedido_ate			[1]
ls_CPF					= Tab_1.TabPage_1.dw_1.object.nr_cpf						[1]
ls_Tipo_Pagto			= Tab_1.TabPage_1.dw_1.object.cd_tipo_pagamento	[1]
ll_Dias					= Tab_1.TabPage_1.dw_1.object.qt_dias					[1]
ll_Produto				= Tab_1.TabPage_1.dw_1.object.cd_produto				[1]
ls_controlado			= Tab_1.TabPage_1.dw_1.object.id_prd_controlado		[1]
ls_termolabil			= Tab_1.TabPage_1.dw_1.object.id_prd_termolabil		[1]
ls_id_tipo_pedido		= Tab_1.TabPage_1.dw_1.object.id_tipo_pedido			[1]
ls_nr_autorizacao		= Tab_1.TabPage_1.dw_1.object.nr_autorizacao			[1]
lvs_nr_pedido_plataforma	= Tab_1.TabPage_1.dw_1.object.nr_pedido_plataforma[1]
ls_administradora		= Tab_1.TabPage_1.dw_1.object.cd_administradora		[1]

//ldh_Periodo_De = Datetime(RelativeDate(Date(ldh_Periodo_De), -1))
ldh_Periodo_ate = Datetime(RelativeDate(Date(ldh_Periodo_ate), +1))

If Not IsNull(ll_Filial) then
	This.of_AppendWhere("p.cd_filial = " + String(ll_filial))
End If

If Not IsNull(ldc_Valor) and ldc_Valor > 0 Then
	This.of_AppendWhere("p.vl_total >= " + gf_Valor_Com_Ponto(ldc_Valor))
End If

If Not IsNull(ldc_Valor_ate) and ldc_Valor_ate > 0 Then
	This.of_AppendWhere("p.vl_total <= " + gf_Valor_Com_Ponto(ldc_Valor_ate))
End If


If Not IsNull(ldh_Periodo_de) then
	This.of_AppendWhere("p.dh_compra >= '" + String(ldh_Periodo_De,"yyyymmdd")+"'")
End If

If Not IsNull(ldh_Periodo_ate) then
	This.of_AppendWhere("p.dh_compra < '" + String(ldh_Periodo_Ate,"yyyymmdd")+"'")
End If

If (Not IsNull(ls_Situacao)) and (ls_Situacao<>"T") then
	This.of_AppendWhere("p.id_situacao = '" + ls_situacao+"'")
End If

If (Not IsNull(ls_de_tipo_entrega)) and (ls_de_tipo_entrega <> 'TODOS') then
	This.of_AppendWhere("p.nm_transportadora = '" + ls_de_tipo_entrega + "'" )
End If

If Not IsNull(ll_Produto) and ll_Produto > 0 Then
	This.of_AppendWhere("exists (select * from pedido_ecommerce_produto pp where pp.cd_filial_ecommerce = p.cd_filial_ecommerce and pp.nr_pedido = p.nr_pedido and pp.cd_produto = " + String(ll_Produto) + ")")
End If

if ls_controlado = 'S' Then
	This.of_AppendWhere("exists (select * from pedido_ecommerce_produto pp inner join produto_geral pg on pg.cd_produto = pp.cd_produto where pp.cd_filial_ecommerce = p.cd_filial_ecommerce and pp.nr_pedido = p.nr_pedido and pg.cd_grupo_psico is not null )")	
end if

if ls_termolabil = 'S' then
	This.of_AppendWhere("exists (select * from pedido_ecommerce_produto pp inner join produto_geral pg on pg.cd_produto = pp.cd_produto where pp.cd_filial_ecommerce = p.cd_filial_ecommerce and pp.nr_pedido = p.nr_pedido and left(pg.de_produto,2) = 'ZZ' )")		
end if

If Not IsNull(ls_Pedido) then

	If Len(Trim(ls_Pedido)) > 9 or Not IsNumber(ls_Pedido) Then
		This.of_AppendWhere("p.nr_pedido_ecommerce = '" + ls_Pedido + "'")
	ElseIf Len(Trim(ls_Pedido)) <= 5 Then
		This.of_AppendWhere("p.nr_pedido_ecommerce_seq = '" + ls_Pedido + "'")
	Else		
		This.of_AppendWhere("p.nr_pedido = " + ls_Pedido)
	End If

end if

If ls_Origem <> 'T' Then
	If ls_Origem = '1' Then
		This.of_AppendWhere("p.nr_pedido_ecommerce is null ")
	Else
		This.of_AppendWhere("p.nr_pedido_ecommerce is not null ")
		This.of_AppendWhere("p.id_ecommerce = '" + ls_origem + "' ")
	End If
End If

If ls_Refaturado = 'S' Then
	This.of_AppendWhere("p.dh_refaturamento is not null")
End If

If ls_rede_ecommerce <> 'TD' Then
	// ifood
	If ls_Origem = '3' Then
		This.of_AppendWhere( "f.id_rede_filial = '" + ls_rede_ecommerce + "'" )
	Else
		This.of_AppendWhere( "a.id_rede_ecommerce = '" + ls_rede_ecommerce +  "'" )
	End If	
End If

If Not IsNull(ls_CPF) and Trim(ls_CPF) <> '' Then
	This.of_AppendWhere("p.nr_cpf_cgc = '" + ls_CPF + "'")
End If

If ls_Tipo_Pagto <> 'TODOS' Then
	This.of_AppendWhere("p.cd_tipo_pagamento = '" + ls_Tipo_Pagto + "'")
End If

If Not IsNull(ll_Dias) and ll_Dias > 0 Then
	This.of_AppendWhere("datediff(dd, p.dh_compra, getdate()) >= " + String(ll_Dias))
End If
	
if not isnull(ls_id_tipo_pedido) and ls_id_tipo_pedido <> 'TOD' then
	This.of_AppendWhere("a.id_tipo_pedido = '" + ls_id_tipo_pedido + "'")
ENd if

if not isnull(ls_nr_autorizacao) and ls_nr_autorizacao <> '' Then
	This.of_AppendWhere("coalesce(a.nr_autorizacao_cartao_credito,a.cd_autorizacao_cd) = '" + ls_nr_autorizacao + "'")
End if

If Not IsNull(lvs_nr_pedido_plataforma) and Trim(lvs_nr_pedido_plataforma) <> '' Then
	This.of_AppendWhere("a.nr_pedido_plataforma = '" + lvs_nr_pedido_plataforma + "'")
End If

if ls_administradora <> 'TODAS' Then
	ll_administradora = Long(ls_administradora)
	This.of_AppendWhere(" exists (select tef.cd_administradora from dbo.cartao_produto tef where tef.nm_produto = a.nm_administradora_cartao  and tef.cd_administradora =" + String(ll_administradora)+ ")")
End if

	
Return 1
end event

event ue_postretrieve;if  gvo_Aplicacao.ivo_Seguranca.Cd_Sistema <> 'EC' Then
		cb_pedido_entregue.Enabled 	= 	False
		cb_refaturar.Enabled				=	False
		cb_cancelar.Enabled 				=  False
		cb_transportadora.Enabled		=	False
		cb_pedido_entregue.Enabled 	=	False
		cb_reenviar_entrega.enabled 	= false
		
		cb_Etiqueta.enabled				=false
		
		wf_Atualiza_Valor()
		
		return pl_linhas
end if
	
If pl_Linhas > 0 Then
	This.ScrollToRow(1)
	This.Event RowFocusChanged(1)
	This.SetRow(1)
	This.SetFocus()
	
	cb_pedido_entregue.Enabled 	= True
	cb_refaturar.Enabled 				= True
	cb_cancelar.Enabled 				= True
	cb_transportadora.Enabled		= True	
	cb_pedido_entregue.Enabled 	= True
	cb_reenviar_entrega.enabled	= True
	
	wf_Atualiza_Valor()
Else
	If pl_Linhas = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.", Information!)
		cb_pedido_entregue.Enabled 	= 	False
		cb_refaturar.Enabled				=	False
		cb_cancelar.Enabled 				=  False
		cb_transportadora.Enabled		=	False
		cb_pedido_entregue.Enabled 	=	False
		cb_reenviar_entrega.enabled	=  False
		
		cb_Etiqueta.enabled				=false
	End If
End If

Return pl_Linhas

end event

event getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
end event

event constructor;call super::constructor;This.of_SetRowSelection("if (id_situacao = ~"X~", rgb(255, 198, 198), if(id_situacao = ~"E~",rgb(213, 255, 213), if(id_situacao = ~"V~",rgb(192, 192, 192), rgb(255, 255, 255))))","")

// Habilitar a ordena$$HEX2$$e700e300$$ENDHEX$$o na coluna
This.ivb_Ordena_Colunas = True
end event

event rowfocuschanged;call super::rowfocuschanged;Long lvl_Linha,&
     lvl_filial

String 	lvs_Situacao,&
		lvs_Transportadora,&
		lvs_Codigo

lvl_Linha = Tab_1.TabPage_1.dw_2.GetRow()

if lvl_Linha > 0 then

	lvs_Situacao 				= Tab_1.TabPage_1.dw_2.object.id_Situacao									[lvl_linha]
	lvl_filial   					= Tab_1.TabPage_1.dw_2.object.cd_filial										[lvl_linha]
	lvs_Transportadora 	= Tab_1.TabPage_1.dw_2.Object.nm_transportadora						[lvl_linha]
	lvs_Codigo					= Tab_1.TabPage_1.dw_2.object.de_codigo_rastreamento_correio	[lvl_linha]
	
	If lvs_Situacao <> "X" and lvs_Transportadora <> 'PRIORIT$$HEX1$$c100$$ENDHEX$$RIA' and gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = 'EC' Then 
		cb_Etiqueta.Enabled=true
	Else
		cb_Etiqueta.Enabled=false
	End If
	
	this.object.t_pedido_ecommerce.text = this.object.nr_pedido_ecommerce[currentrow]
	
//	If lvs_Situacao = "M" Or lvs_Situacao = "R" Then
//		cb_pedido_entregue.Enabled = True
//	Else
//		cb_pedido_entregue.Enabled = False
//	End If
	
End if
end event

event clicked;call super::clicked;String	ls_Codigo_Rastreamento,&
		ls_id_tipo_entrega,&
		lvs_Exe, ls_url_rastreio
		
Long ll_Pedido		

If dwo.Name = "st_rastrear" Then
	
	If Row > 0 Then
		
		ls_Codigo_Rastreamento = This.Object.de_codigo_rastreamento_correio[ Row ]
		ll_Pedido 					= This.Object.nr_pedido									[ Row ]
		ls_id_tipo_entrega			= This.Object.nm_transportadora						[ Row ]
		ls_url_rastreio = This.Object.de_url_rastreio[ Row ]
		
		if Not isnull(ls_url_rastreio) and ls_url_rastreio <> '' Then
			
			io_api.of_Shell_Execute(ls_url_rastreio, '')
			
		elseIf ls_id_tipo_entrega = "TOT" Then
			OpenWithParm(w_ge504_rastreamento, ll_Pedido)
		Else
			If IsNull(ls_Codigo_Rastreamento) Or ls_Codigo_Rastreamento = "" Then Return
			
			lvs_Exe = ivs_Path_Correios  + ls_Codigo_Rastreamento
			
			io_api.of_Shell_Execute(lvs_Exe, '')
		End If
		
	End If
	
End If



end event

event doubleclicked;call super::doubleclicked;String lvs_Marcacao
String ls_Situacao

Integer lvi_Row
		  
If dwo.Name = "id_imagem" Then
	
	If ivb_Check Then
		lvs_Marcacao = 'N'
		st_confirmar.Text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para marcar todos."
		ivb_Check 	 = False
	Else
		st_confirmar.Text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para desmarcar todos."
		lvs_Marcacao = 'S'
		ivb_Check 	 = True
	End If
	
	For lvi_Row = 1 To This.RowCount()
	
		ls_Situacao = Tab_1.TabPage_1.dw_2.Object.id_situacao[ lvi_Row ]
	
		If ls_Situacao <> "M" AND ls_Situacao <> "R" Then Continue
		
		// N$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ possivel para a VTEX, pelo menos por enquanto
		If Not IsNull(Tab_1.TabPage_1.dw_2.Object.nr_pedido_ecommerce[ lvi_Row ]) Then Continue
		
		This.Object.id_selecao[ lvi_Row ] = lvs_Marcacao
		
	Next
	
End If
end event

event itemchanged;call super::itemchanged;String ls_Situacao

If dwo.Name = "id_selecao" Then
	
	ls_Situacao = This.Object.id_situacao[ row ]
	
	If ls_Situacao <> "M" AND ls_Situacao <> "R" Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Somente pedidos com a situa$$HEX2$$e700e300$$ENDHEX$$o 'REMETIDO' ou 'EM ROTEIRO'~rpodem ser selecionados.")
		Return 1
	End If
	
End If
end event

type cb_etiqueta from commandbutton within tabpage_1
integer x = 581
integer y = 1856
integer width = 521
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "&Etiqueta Correio"
end type

event clicked;Long	lvl_Nr_Pedido,&
		lvi_Linha
		
String ls_id_tipo_entrega		

dw_2.AcceptText()

lvi_Linha=Tab_1.TabPage_1.dw_2.getrow()

lvl_Nr_Pedido		=Tab_1.TabPage_1.dw_2.object.Nr_Pedido					[lvi_linha]
ls_id_tipo_entrega	= Tab_1.TabPage_1.dw_2.object.nm_transportadora		[lvi_Linha]

//If Not IsNull(dw_2.Object.nr_pedido_ecommerce[lvi_Linha ]) Then
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Funcionalidade n$$HEX1$$e300$$ENDHEX$$o dispon$$HEX1$$ed00$$ENDHEX$$vel para pedido da VTEX.")	
//	Return
//End If

If ls_id_tipo_entrega = "TRA" Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o","Essa opera$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitida para a modalidade de entrega LS TRANSLOG.", Exclamation! )
	Return 
End If

If ls_id_tipo_entrega = "JAD" Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o","Essa opera$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitida para a modalidade de entrega JADLOG.", Exclamation! )
	Return 
End If

If ls_id_tipo_entrega = "TOT" Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o","Essa opera$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitida para a modalidade de entrega TOTAL EXPRESS.", Exclamation! )
	Return 
End If

If ls_id_tipo_entrega = "MOT" Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o","Essa opera$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitida para a modalidade de entrega MOTOBOY.", Exclamation! )
	Return 
End If

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a impress$$HEX1$$e300$$ENDHEX$$o da etiqueta do pedido '" + String(lvl_nr_Pedido) + "' ?", Question!, YesNo!, 2) = 2 Then
	Return
End If

dw_5.Reset()

dw_5.Event ue_Retrieve()

dw_5.Event ue_Print()

end event

type dw_5 from dc_uo_dw_base within tabpage_1
boolean visible = false
integer x = 2971
integer y = 240
integer width = 210
integer height = 156
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge504_etiqueta"
boolean hscrollbar = true
boolean vscrollbar = true
end type

event ue_recuperar;// OverRide
String 	ls_SQL,&
		ls_dados

This.SetRedraw(False)

Open(w_Aguarde)
w_Aguarde.Title = "Recuperando as Informa$$HEX2$$e700f500$$ENDHEX$$es na Matriz..."

//If Not ivo_Cliente_Central.ivo_Conexao.of_ConnectToServer() Then 
//	Close(w_Aguarde)
//	Return -1
//End If
//
//If ivo_Cliente_Central.ivo_Conexao.of_Retrieve(ref Tab_1.TabPage_1.dw_5, "CONSULTA PEDIDO ECOMMERCE") Then 
//	lvl_Retorno = This.RowCount()	
//End If
//
//ivo_Cliente_Central.ivo_Conexao.DisconnectServer()

uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao()

lvo_Conexao.of_Relatorio(True)

ls_SQL = dw_5.GetSQLSelect()

If lvo_Conexao.of_Retrieve(ls_SQL, Ref ls_Dados) Then
	
	long ll_Retorno 
	
	ll_retorno = dw_5.ImportString(ls_Dados)
	
End If	

Destroy(lvo_Conexao)

ll_Retorno = This.RowCount()

Close(w_Aguarde)

This.VScrollBar = True

This.SetRedraw(True)

//x = 59
//y = 448

Return ll_Retorno

end event

event ue_preretrieve;call super::ue_preretrieve;Long lvl_Pedido

Tab_1.TabPage_1.dw_2.AcceptText()

lvl_Pedido = Tab_1.TabPage_1.dw_2.object.nr_pedido[Tab_1.TabPage_1.dw_2.GetRow()]

If Not IsNull(lvl_Pedido) then
	This.of_AppendWhere("p.nr_pedido = " + String(lvl_Pedido))
End If
									
Return 1
end event

event ue_preprint;call super::ue_preprint;Integer lvi_Cont,&
		lvi_Soma,&
		lvi_Digito

String lvs_CEP

Tab_1.TabPage_1.dw_2.AcceptText()

lvs_CEP = Tab_1.TabPage_1.dw_2.Object.nr_cep_ent[Tab_1.TabPage_1.dw_2.GetRow()]

For lvi_Cont = 1 To 8 
	lvi_Soma = lvi_Soma + Integer(Mid(lvs_CEP, lvi_Cont,1))
Next

lvi_Digito = Integer(Right(String(lvi_Soma), 1))

lvi_Digito = 10 - lvi_Digito

lvs_CEP = "/" + lvs_CEP + String(lvi_Digito) + "\"

dw_5.Object.st_cep.text = lvs_CEP

Return AncestorReturnValue
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4622
integer height = 1964
long backcolor = 80269524
string text = "Detalhe"
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_3 dw_3
cb_endereco cb_endereco
cb_link cb_link
cb_historico cb_historico
gb_3 gb_3
cb_1 cb_1
end type

on tabpage_2.create
this.dw_3=create dw_3
this.cb_endereco=create cb_endereco
this.cb_link=create cb_link
this.cb_historico=create cb_historico
this.gb_3=create gb_3
this.cb_1=create cb_1
this.Control[]={this.dw_3,&
this.cb_endereco,&
this.cb_link,&
this.cb_historico,&
this.gb_3,&
this.cb_1}
end on

on tabpage_2.destroy
destroy(this.dw_3)
destroy(this.cb_endereco)
destroy(this.cb_link)
destroy(this.cb_historico)
destroy(this.gb_3)
destroy(this.cb_1)
end on

type dw_3 from dc_uo_dw_base within tabpage_2
integer x = 78
integer y = 92
integer width = 3584
integer height = 1568
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge504_detalhe_entrega"
end type

event ue_recuperar;Long lvl_Linha,&
	 lvl_Pedido
	 
Long ll_Filial_Ecommerce, ll_retorno
String ls_situacao

Tab_1.TabPage_1.dw_2.AcceptText()

lvl_Linha = Tab_1.TabPage_1.dw_2.GetRow()

lvl_Pedido 				= Tab_1.TabPage_1.dw_2.Object.nr_pedido				[ lvl_Linha ]
ll_Filial_Ecommerce 	= Tab_1.TabPage_1.dw_2.Object.cd_filial_ecommerce 	[ lvl_Linha ]
ls_situacao 	= Tab_1.TabPage_1.dw_2.Object.id_situacao						 	[ lvl_Linha ]

this.reset()

Tab_1.TabPage_2.dw_3.of_AppendWhere("pe.cd_filial_ecommerce = " + String(ll_Filial_Ecommerce) + " and pe.nr_pedido =" + String(lvl_Pedido))

ll_retorno = dw_3.retrieve()

if ls_situacao <> 'E' and ls_situacao <> 'D' and ls_situacao <> 'X' Then
	cb_endereco.enabled = true
else
	cb_endereco.enabled = false
end if

This.VScrollBar = True

x = 80
y = 125

Return ll_Retorno
end event

event getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
end event

event constructor;call super::constructor;// Habilitar a coluna de sele$$HEX2$$e700e300$$ENDHEX$$o (freform)
This.of_SetColSelection(True)
end event

event ue_postretrieve;call super::ue_postretrieve;Tab_1.TabPage_2.dw_3.AcceptText()

If IsNull(Tab_1.TabPage_2.dw_3.Object.cd_url_integracao[ Tab_1.TabPage_2.dw_3.getrow() ]) Then
	cb_link.Enabled = false
Else
	cb_link.Enabled = true
End If

Return pl_Linhas
end event

type cb_endereco from commandbutton within tabpage_2
integer x = 2926
integer y = 572
integer width = 690
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Alterar Endere$$HEX1$$e700$$ENDHEX$$o"
end type

event clicked;String ls_parametro
long ll_Pedido, ll_Filial_Ecommerce, ll_retorno, ll_linha

ll_linha = Tab_1.TabPage_1.dw_2.GetRow()

ll_Pedido = Tab_1.TabPage_1.dw_2.object.nr_pedido[ll_linha]
ll_Filial_Ecommerce 	= Tab_1.TabPage_1.dw_2.object.cd_filial_ecommerce[ll_linha]

ls_parametro = String(ll_Filial_Ecommerce, '0000') + String(ll_Pedido) 

OpenWithParm(w_ge504_altera_endereco, ls_parametro)

ll_retorno = message.doubleparm

if ll_retorno = 1 Then
	
	dw_3.Event ue_retrieve()
	
	this.enabled = false
	
end if
end event

type cb_link from commandbutton within tabpage_2
integer x = 2089
integer y = 1076
integer width = 475
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Link: ADM VTEX"
end type

event clicked;String ls_URL
String ls_URL_Alt
String ls_Pedido
String ls_Rede
String ls_Data_Inicial
String ls_Data_Final
Date ldh_Compra

Tab_1.TabPage_1.dw_2.AcceptText()

ls_URL 		= Tab_1.TabPage_2.dw_3.Object.cd_url_integracao[ Tab_1.TabPage_2.dw_3.getrow() ]
ls_Pedido 	= Tab_1.TabPage_2.dw_3.Object.nr_pedido_ecommerce[ Tab_1.TabPage_2.dw_3.getrow() ] 
ls_Rede 		= Tab_1.TabPage_2.dw_3.Object.id_rede_ecommerce[ Tab_1.TabPage_2.dw_3.getrow() ] 
ldh_Compra = Date(Tab_1.TabPage_2.dw_3.Object.dh_compra[ Tab_1.TabPage_2.dw_3.getrow() ] )

If Tab_1.TabPage_2.dw_3.Object.cd_seller[ Tab_1.TabPage_2.dw_3.getrow() ]  <>  809 Then
	ls_Pedido = 'SLR-' + ls_Pedido
End If

ls_Data_Inicial = String( RelativeDate (ldh_Compra, -1 ) , 'yyyy-mm-dd')
ls_Data_Final	= String( RelativeDate (ldh_Compra, 1 ) , 'yyyy-mm-dd')

ls_URL_Alt =ls_URL +  'admin/checkout/#/orders/' + ls_Pedido + '?orderBy=creationDate,desc&page=1&q='  + ls_Pedido + '&f_creationDate=creationDate:%5B' + ls_Data_Inicial+ 'T03:00:00.000Z%20TO%20' + ls_Data_Final+ 'T02:59:59.999Z%5D'

//ls_URL = 'https://precopopular325.myvtex.com/admin/checkout/#/orders/SLR-1120122654081-02?orderBy=creationDate,desc&page=1&q=SLR-1120122654081-02&f_creationDate=creationDate:%5B2020-09-26T03:00:00.000Z%20TO%202021-03-27T02:59:59.999Z%5D'

If Not IsNull(ls_URL_Alt) Then
	io_api.of_Shell_Execute(ls_URL_Alt, '')
End If

end event

type cb_historico from commandbutton within tabpage_2
integer x = 2926
integer y = 672
integer width = 690
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Hist$$HEX1$$f300$$ENDHEX$$rico de Altera$$HEX2$$e700f500$$ENDHEX$$es"
end type

event clicked;st_ge382_parametros str

str.Tabela[1] = 'PEDIDO_ECOMMERCE'
str.Chave = Tab_1.TabPage_1.dw_2.Object.nr_pedido_ecommerce[ Tab_1.TabPage_1.dw_2.getrow() ]

OpenWithParm(w_ge382_historico_alteracao, str)
end event

type gb_3 from groupbox within tabpage_2
integer x = 64
integer y = 16
integer width = 3643
integer height = 1680
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
borderstyle borderstyle = styleraised!
end type

type cb_1 from commandbutton within tabpage_2
integer x = 2089
integer y = 1184
integer width = 475
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Listar Notas"
end type

event clicked;Long ll_Pedido

dw_3.AcceptText()

ll_Pedido = dw_3.Object.Nr_Pedido [1] 

OpenWithParm(w_ge504_detalhe_notas, ll_Pedido)
end event

type tabpage_3 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4622
integer height = 1964
long backcolor = 80269524
string text = "Produtos"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
gb_4 gb_4
dw_4 dw_4
end type

on tabpage_3.create
this.gb_4=create gb_4
this.dw_4=create dw_4
this.Control[]={this.gb_4,&
this.dw_4}
end on

on tabpage_3.destroy
destroy(this.gb_4)
destroy(this.dw_4)
end on

type gb_4 from groupbox within tabpage_3
integer x = 27
integer y = 20
integer width = 3369
integer height = 1592
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

type dw_4 from dc_uo_dw_base within tabpage_3
integer x = 55
integer y = 88
integer width = 3310
integer height = 1048
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge504_produtos"
boolean vscrollbar = true
end type

event getfocus;call super::getfocus;This.ivo_Controle_Menu.of_Atualiza()
end event

event ue_recuperar;// OverRide
Long lvl_Linha,&
	 lvl_Pedido
	 
Long ll_Filial_Ecommerce, ll_retorno
	 
Tab_1.TabPage_1.dw_2.AcceptText()

lvl_Linha 					= Tab_1.TabPage_1.dw_2.GetRow()
lvl_Pedido				= Tab_1.TabPage_1.dw_2.Object.nr_pedido 				[lvl_Linha]
ll_Filial_Ecommerce 	= Tab_1.TabPage_1.dw_2.Object.cd_filial_Ecommerce 	[lvl_Linha]

Tab_1.TabPage_3.dw_4.of_AppendWhere("cd_filial_ecommerce = " + String(ll_Filial_Ecommerce) + " and nr_pedido =" + String(lvl_Pedido))

ll_retorno = dw_4.retrieve()
	
This.VScrollBar = True

x = 55
y = 88

Return ll_Retorno
end event

event constructor;call super::constructor;// Habilitar a linha de sele$$HEX2$$e700e300$$ENDHEX$$o (list)
This.of_SetRowSelection()
end event

type tabpage_4 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4622
integer height = 1964
long backcolor = 80269524
string text = "Pagamento"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
dw_6 dw_6
gb_5 gb_5
end type

on tabpage_4.create
this.dw_6=create dw_6
this.gb_5=create gb_5
this.Control[]={this.dw_6,&
this.gb_5}
end on

on tabpage_4.destroy
destroy(this.dw_6)
destroy(this.gb_5)
end on

type dw_6 from dc_uo_dw_base within tabpage_4
integer x = 5
integer y = 56
integer width = 4603
integer height = 700
integer taborder = 20
string dataobject = "dw_ge504_pagamento"
boolean hscrollbar = true
end type

event ue_recuperar;// OverRide
Long lvl_Linha,&
	 lvl_Pedido
	 
Long ll_Filial_Ecommerce, ll_retorno
	 
Tab_1.TabPage_1.dw_2.AcceptText()

lvl_Linha 					= Tab_1.TabPage_1.dw_2.GetRow()
lvl_Pedido				= Tab_1.TabPage_1.dw_2.Object.nr_pedido 				[lvl_Linha]
ll_Filial_Ecommerce 	= Tab_1.TabPage_1.dw_2.Object.cd_filial_Ecommerce 	[lvl_Linha]

ll_retorno = this.retrieve(ll_filial_ecommerce, lvl_Pedido)
	
Return ll_Retorno
end event

type gb_5 from groupbox within tabpage_4
integer y = 12
integer width = 4617
integer height = 1236
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
end type

type tabpage_5 from userobject within tab_1
integer x = 18
integer y = 104
integer width = 4622
integer height = 1964
long backcolor = 80269524
string text = "Pedido Empurrado/Urgente"
long tabtextcolor = 33554432
long tabbackcolor = 80269524
long picturemaskcolor = 536870912
gb_6 gb_6
dw_7 dw_7
end type

on tabpage_5.create
this.gb_6=create gb_6
this.dw_7=create dw_7
this.Control[]={this.gb_6,&
this.dw_7}
end on

on tabpage_5.destroy
destroy(this.gb_6)
destroy(this.dw_7)
end on

type gb_6 from groupbox within tabpage_5
integer x = 18
integer y = 4
integer width = 4581
integer height = 1628
integer taborder = 30
integer textsize = -9
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
borderstyle borderstyle = styleraised!
end type

type dw_7 from dc_uo_dw_base within tabpage_5
integer x = 32
integer y = 60
integer width = 4530
integer height = 1520
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge504_pedido_empurrado"
boolean vscrollbar = true
end type

event ue_recuperar;Long lvl_Linha,&
	 lvl_Pedido
	 
Long ll_Filial_Ecommerce, ll_retorno
	 
Tab_1.TabPage_1.dw_2.AcceptText()

lvl_Linha = Tab_1.TabPage_1.dw_2.GetRow()
lvl_Pedido = Tab_1.TabPage_1.dw_2.Object.nr_pedido[lvl_Linha]
ll_Filial_Ecommerce = Tab_1.TabPage_1.dw_2.Object.cd_filial_Ecommerce[lvl_Linha]

ll_retorno = dw_7.retrieve(ll_Filial_Ecommerce, lvl_Pedido)
	
Return ll_Retorno
end event

event constructor;call super::constructor;// Habilitar a linha de sele$$HEX2$$e700e300$$ENDHEX$$o (list)
This.of_SetRowSelection()
end event

type st_confirmar from statictext within w_ge504_consulta_pedido_ecommerce
boolean visible = false
integer x = 3200
integer y = 628
integer width = 873
integer height = 60
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 15793151
boolean enabled = false
string text = "D$$HEX1$$ea00$$ENDHEX$$ um duplo click para marcar todos"
boolean focusrectangle = false
end type

