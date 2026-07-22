HA$PBExportHeader$uo_ge344_pedido_solicitacao.sru
forward
global type uo_ge344_pedido_solicitacao from nonvisualobject
end type
end forward

global type uo_ge344_pedido_solicitacao from nonvisualobject
end type
global uo_ge344_pedido_solicitacao uo_ge344_pedido_solicitacao

type variables
Boolean	ib_Possui_Pedido
String	is_Tipo = 'A'
end variables

forward prototypes
public subroutine of_envia_msg_erro (string as_erro)
public function boolean of_verifica_inicio_geracao_pedido_cd (date adt_hoje, ref boolean ab_comecou, ref string as_erro)
public function boolean of_verifica_ultimo_pedido (long al_filial, string as_tipo, ref long al_pedido, ref string as_erro)
public function boolean of_marca_solicitacao (long al_solicitacao, long al_filial, long al_pedido, ref string as_erro)
public function boolean of_verifica_bloqueio (long al_filial, date adt_pedido, ref boolean ab_data_bloqueada, ref string as_erro)
public function boolean of_grava_item_pedido (long al_solicitacao, long al_filial, long al_pedido, long al_produto, long al_qtde, ref string as_erro)
public function boolean of_grava_cabecalho_pedido (long al_filial, long al_pedido, string as_tipo, string as_matricula, ref string as_erro)
public function boolean of_processa_solicitacoes ()
end prototypes

public subroutine of_envia_msg_erro (string as_erro);// DECLARA$$HEX2$$c700d500$$ENDHEX$$ES

String	ls_Msg

s_email	lst_Email					

// PROCEDIMENTOS

ls_Msg =	'<b>ATEN$$HEX2$$c700c300$$ENDHEX$$O!!!!!'                                    + '<br><br>' + &
			'<b>Cria$$HEX2$$e700e300$$ENDHEX$$o de Pedidos de Almoxarifado'              + '<br></b>' + &
			'<b>Sistema GERENCIAMENTO DE CATEGORIAS'             + '<br></b>' + &
			'<b>Mensagem: [' + This.Classname () + ' ' + as_erro + '<br></b>'
			
lst_Email.ps_mensagem	= ls_Msg
lst_Email.pb_assinatura = True

gf_ge202_envia_email_padrao (323, lst_Email)

Return
end subroutine

public function boolean of_verifica_inicio_geracao_pedido_cd (date adt_hoje, ref boolean ab_comecou, ref string as_erro);// DECLARA$$HEX2$$c700d500$$ENDHEX$$ES

Boolean	lb_sucesso
Datetime	ldh_inicio_geracao

// PROCEDIMENTOS

lb_sucesso = True

Try
	SELECT dh_inicio_geracao
	  INTO :ldh_inicio_geracao
	  FROM controle_geracao_pedido
	 WHERE id_multitask_logistica = 'S'
		AND dh_pedido              = :adt_hoje
	 USING SQLCA;
	
	Choose case SQLCA.SQLCode
		case is < 0
			as_erro    = 'Erro na verifica$$HEX2$$e700e300$$ENDHEX$$o do in$$HEX1$$ed00$$ENDHEX$$cio do processo de gera$$HEX2$$e700e300$$ENDHEX$$o de pedido do CD: ' + SQLCA.SQLErrText
			lb_sucesso = False
		case 0
			//A gera$$HEX2$$e700e300$$ENDHEX$$o de pedidos j$$HEX1$$e100$$ENDHEX$$ come$$HEX1$$e700$$ENDHEX$$ou
			ab_comecou = True
		case 100
			ab_comecou = False
	End choose
	
Finally
	If not lb_Sucesso then
		as_erro = '(of_verifica_inicio_geracao_pedido_cd)] ' + as_erro
	End if
End try

Return lb_sucesso
end function

public function boolean of_verifica_ultimo_pedido (long al_filial, string as_tipo, ref long al_pedido, ref string as_erro);// DECLARA$$HEX2$$c700d500$$ENDHEX$$ES
Boolean	lb_Sucesso
Long		ll_Achou

// PROCEDIMENTOS

ib_Possui_Pedido = False

Try
	SELECT COUNT (*)
	  INTO :ll_Achou
	  FROM pedido_almoxarifado
	 WHERE cd_filial      = :al_Filial
		AND nr_pedido     >= 30000
		AND id_situacao    = 'C'
		AND dh_emissao    >= DATEADD (DAY, -5, GETDATE ())
		AND id_tipo_pedido = :as_tipo
	 USING SQLCA;
	
	If SQLCA.SQLCode = -1 then
		as_erro = 'Erro ao consultar se j$$HEX1$$e100$$ENDHEX$$ existe um pedido colocado para a filial ' + String (al_Filial) + ': ' + SQLCA.SqlErrText
		Return False
	End if
	
	If ll_Achou > 0 then
		SELECT MAX (nr_pedido)
		  INTO :al_pedido
		  FROM pedido_almoxarifado
		 WHERE cd_filial      = :al_Filial
			AND nr_pedido     >= 30000
			AND id_situacao    = 'C'
			AND dh_emissao    >= DATEADD (DAY, -5, GETDATE ())
			AND id_tipo_pedido = :as_tipo
		 USING SQLCA;
		
		If SQLCA.SQLCode = -1 then
			as_erro = "Erro ao consultar o n$$HEX1$$fa00$$ENDHEX$$mero do pedido j$$HEX1$$e100$$ENDHEX$$ existente com situa$$HEX2$$e700e300$$ENDHEX$$o 'COLOCADO': " + SQLCA.SqlErrText
			Return False
		End if
		
		ib_Possui_Pedido = True
		
	else
		
		SELECT COALESCE (MAX (nr_pedido), 29999) + 1
		  INTO :al_Pedido
		  FROM pedido_almoxarifado
		 WHERE cd_filial  = :al_Filial
			AND nr_pedido >= 30000
		 USING SQLCA;
		
		If SQLCA.SQLCode = -1 then
			as_erro = 'Erro ao consultar o $$HEX1$$fa00$$ENDHEX$$ltimo pedido da filial ' + String (al_Filial) + ': ' + SQLCA.SqlErrText
			Return False
		End if
	End if
	
	lb_Sucesso = True
	
Finally
	If not lb_Sucesso then
		as_erro = '(of_verifica_ultimo_pedido)] ' + as_erro
	End if
	
End try

Return lb_Sucesso
end function

public function boolean of_marca_solicitacao (long al_solicitacao, long al_filial, long al_pedido, ref string as_erro);Boolean	lb_Sucesso

Try
	UPDATE pedido_solicitacao
		SET id_situacao      = 'C'
		  , dh_processamento = GETDATE ()
		  , nr_pedido        = :al_pedido
	 WHERE nr_solicitacao = :al_solicitacao
		AND cd_filial      = :al_filial
	 USING SQLCA;
	
	If SQLCA.SQLCode < 0 then
		as_erro    = 'Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o da solicita$$HEX2$$e700e300$$ENDHEX$$o ' + String (al_solicitacao) + ' da filial ' + String (al_Filial) + ': ' + SQLCA.SQLErrText
		Return False
	End if
	
	lb_Sucesso = True
	
Finally
	If not lb_Sucesso then
		as_erro = '(of_marca_solicitacao)] ' + as_erro
		SQLCA.of_RollBack ()
	End if
End try

Return True
end function

public function boolean of_verifica_bloqueio (long al_filial, date adt_pedido, ref boolean ab_data_bloqueada, ref string as_erro);// DECLARA$$HEX2$$c700d500$$ENDHEX$$ES
Boolean	lb_Sucesso
Long		ll_Achou

// PROCEDIMENTOS

Try
	SELECT COUNT (*)
	  INTO :ll_Achou
	  FROM pedido_filial_bloqueio
	 WHERE id_tipo_bloqueio = 'D'
		AND cd_filial        = :al_filial
		AND (dh_pedido       = :adt_pedido
		 OR  :adt_pedido     BETWEEN dh_inicio_bloqueio AND dh_termino_bloqueio)
	 USING SQLCA;
	
	If SQLCA.SQLCode < 0 then
		as_erro = 'Erro ao verificar se existe bloqueio de pedido para a filial ' + String (al_filial) + ' no dia ' + String (adt_pedido, 'DD/MM/YYYY') + ': ' + SQLCA.SQLErrText
		Return False
	End if
	
	If ll_Achou > 0 then
		ab_data_bloqueada = True
	else
		ab_data_bloqueada = False
	End if
	
	lb_Sucesso = True
	
Finally
	If not lb_Sucesso then
		as_erro = '(of_verifica_bloqueio)] ' + as_erro
	End if
End try

Return True
end function

public function boolean of_grava_item_pedido (long al_solicitacao, long al_filial, long al_pedido, long al_produto, long al_qtde, ref string as_erro);// DECLARA$$HEX2$$c700d500$$ENDHEX$$ES

Boolean	lb_Sucesso
Long		ll_Achou
String	ls_incluiu

// PROCEDIMENTOS

SELECT cd_produto
  INTO :ll_Achou
  FROM pedido_almoxarifado_produto
 WHERE cd_filial  = :al_Filial
	AND nr_pedido  = :al_Pedido
	AND cd_produto = :al_Produto
 USING SQLCA;

Try
	Choose Case SQLCA.SQLCode
		case 0
			ls_incluiu = 'N'
			
		case 100
			INSERT INTO pedido_almoxarifado_produto (cd_filial
																, nr_pedido
																, cd_produto
																, qt_pedida
																, qt_atendida
																, qt_separada
																, qt_faturada)
														VALUES (:al_filial
																, :al_pedido
																, :al_Produto
																, :al_Qtde
																, 0, 0, 0)
			 USING SQLCA;
			
			If SQLCA.SqlCode = -1 then
				as_Erro = 'Erro ao inserir o produto ' + String (al_produto) + ' no pedido ' + String (al_pedido) + ' da filial ' + String (al_filial) + ': ' + SQLCA.SqlErrText
				Return False
			End if
			
			ls_incluiu = 'S'
			
		case is < 0
			as_Erro = 'Erro ao verificar se o produto ' + String (al_produto) + ' j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ no pedido ' + String (al_pedido) + ' da filial ' + String (al_filial) + ': ' + SQLCA.SqlErrText
			Return False
	End Choose
	
	UPDATE pedido_solicitacao_produto
		SET id_inclusao_pedido = :ls_incluiu
	 WHERE nr_solicitacao = :al_solicitacao
		AND cd_filial      = :al_filial
		AND cd_produto     = :al_produto
	 USING SQLCA;
	
	If SQLCA.SqlCode = -1 then
		as_Erro = 'Erro ao atualizar o produto ' + String (al_produto) + ' na solicita$$HEX2$$e700e300$$ENDHEX$$o ' + String (al_solicitacao) + ' da filial ' + String (al_filial) + ': ' + SQLCA.SqlErrText
		Return False
	End if
	
	lb_Sucesso = True
	
Finally
	If not lb_Sucesso then
		as_erro = '(of_grava_item_pedido)] ' + as_erro
		SQLCA.of_RollBack ()
	End if
End try

Return True
end function

public function boolean of_grava_cabecalho_pedido (long al_filial, long al_pedido, string as_tipo, string as_matricula, ref string as_erro);// DECLARA$$HEX2$$c700d500$$ENDHEX$$ES
Boolean	lb_Sucesso
DateTime	ldh_Emissao
DateTime	ldh_Atual
String	ls_Contato

// PROCEDIMENTOS

If Not ib_Possui_Pedido then
	SetNull (ls_Contato)
	
	If Not gf_Data_Parametro (Ref ldh_Emissao) Then Return False
	
	ldh_Atual = gf_GetServerDate ()
	
	Try
		
		INSERT INTO pedido_almoxarifado (cd_filial
												,  nr_pedido
												,  dh_emissao
												,  id_situacao
												,  nr_matricula_cadastramento
												,  dh_inclusao
												,  id_tipo_pedido
												,  vl_total_pedido
												,  de_dados_adicionais)
										 VALUES (:al_filial
												,  :al_pedido
												,  :ldh_Emissao
												,  'C'
												,  :as_matricula
												,  :ldh_Atual
												,  :as_tipo
												,  0.00
												, :ls_Contato)
		 USING SQLCA;
		
		If SQLCA.SQLCode = -1 then
			as_Erro = 'Erro ao gravar o cabe$$HEX1$$e700$$ENDHEX$$alho do pedido: ' +  SQLCA.SQLErrText
			Return False
		End if
		
		lb_Sucesso = True
		
	Finally
		If not lb_Sucesso then
			as_erro = '(of_grava_cabecalho_pedido)] ' + as_erro
			SQLCA.of_RollBack ()
		End if
	End try
End if

Return True
end function

public function boolean of_processa_solicitacoes ();// DECLARA$$HEX2$$c700d500$$ENDHEX$$ES

Boolean			lb_Geracao_Comecou, &
					lb_Data_Bloqueada
Date				ldt_Hoje
dc_uo_ds_base	lds_Solicitacoes, &
					lds_Produtos
Long				ll_Lin_Sol,     &
					ll_Tot_Sol,     &
					ll_Lin_Prd,     &
					ll_Tot_Prd,     &
					ll_Solicitacao, &
					ll_Filial,      &
					ll_Pedido,      &
					ll_Produto,     &
					ll_Qtde_Pedida
String			ls_Erro,      &
					ls_Tipo,      &
					ls_Matricula, &
					ls_Funcao = '(of_processa_solicitacoes)] '

// PROCEDIMENTOS

ldt_Hoje = Date (gf_GetServerDate ())

If not of_verifica_inicio_geracao_pedido_cd (ldt_Hoje, Ref lb_Geracao_Comecou, Ref ls_Erro) then
	of_envia_msg_erro (ls_Erro)
	Return False
End if

If lb_Geracao_Comecou then
	Return False
End if

lds_Solicitacoes = Create dc_uo_ds_base

If not lds_Solicitacoes.of_ChangeDataObject ('ds_ge344_solicitacoes', False) then
	of_envia_msg_erro (ls_Funcao + "Erro no change dataobject da 'ds_ge344_solicitacoes'")
	Return False
End if

lds_Produtos = Create dc_uo_ds_base

If not lds_Produtos.of_ChangeDataObject ('ds_ge344_produtos_solicitacao', False) then
	of_envia_msg_erro (ls_Funcao + "Erro no change dataobject da 'ds_ge344_produtos_solicitacao'")
	Return False
End if

ll_Tot_Sol = lds_Solicitacoes.Retrieve (ldt_Hoje)

For ll_Lin_Sol = 1 to ll_Tot_Sol
	ll_Solicitacao = lds_Solicitacoes.Object.nr_solicitacao             [ll_Lin_Sol]
	ll_Filial      = lds_Solicitacoes.Object.cd_filial                  [ll_Lin_Sol]
	ls_Tipo        = lds_Solicitacoes.Object.id_tipo_pedido             [ll_Lin_Sol]
	ls_Matricula   = lds_Solicitacoes.Object.nr_matricula_cadastramento [ll_Lin_Sol]
	
	If not of_verifica_bloqueio (ll_Filial, ldt_Hoje, Ref lb_Data_Bloqueada, Ref ls_Erro) then
		of_envia_msg_erro (ls_Erro)
		Return False
	End if
	
	If lb_Data_Bloqueada then
		Continue
	End if
	
	If not of_verifica_ultimo_pedido (ll_Filial, ls_Tipo, Ref ll_Pedido, Ref ls_Erro) then
		of_envia_msg_erro (ls_Erro)
		Return False
	End if
		
	If not of_grava_cabecalho_pedido (ll_Filial, ll_Pedido, ls_Tipo, ls_Matricula, Ref ls_Erro) then
		of_envia_msg_erro (ls_Erro)
		Return False
	End if
	
	ll_Tot_Prd = lds_Produtos.Retrieve (ll_Solicitacao, ll_Filial)
	
	For ll_Lin_Prd = 1 to ll_Tot_Prd
		ll_Produto     = lds_Produtos.Object.cd_produto [ll_Lin_Prd]
		ll_Qtde_Pedida = lds_Produtos.Object.qt_pedida  [ll_Lin_Prd]
		If not of_Grava_Item_Pedido (ll_Solicitacao, ll_Filial, ll_Pedido, ll_Produto, ll_Qtde_Pedida, Ref ls_Erro) then
			of_envia_msg_erro (ls_Erro)
			Return False
		End if
	Next
	
	If not of_marca_solicitacao (ll_Solicitacao, ll_Filial, ll_Pedido, Ref ls_Erro) then
		of_envia_msg_erro (ls_Erro)
		Return False
	End if
	
	SQLCA.of_Commit ()
Next

Return True
end function

on uo_ge344_pedido_solicitacao.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge344_pedido_solicitacao.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

