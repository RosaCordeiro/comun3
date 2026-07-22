HA$PBExportHeader$uo_conta_corrente.sru
forward
global type uo_conta_corrente from nonvisualobject
end type
end forward

global type uo_conta_corrente from nonvisualobject
end type
global uo_conta_corrente uo_conta_corrente

type variables
String cd_cliente, &
          nr_titulo,&
          de_historico, &
          id_Tipo_Titulo

Decimal{2} vl_saldo_anterior, &
                  vl_saldo_atual, &
                  vl_movimento

DateTime dh_Movimento, &
                dh_Sistema

Integer     cd_filial_movimento, &
                nr_dia_base
 
end variables

forward prototypes
public function date of_data_inicio_fechamento (string ps_cliente)
public function boolean of_movto_fechamento (ref long pl_codigo)
public function boolean of_movto_debito (ref long pl_codigo)
public function boolean of_movto_credito (ref long pl_codigo)
public function boolean of_imprime_extrato_cc (string ps_cliente, date pdt_periodo_de, date pdt_periodo_ate)
public function boolean of_verifica_saldo_inicial (string ps_cliente, date pdt_periodo_de, ref decimal pdc_vendas, ref decimal pdc_titulos, ref decimal pdc_outros)
public function boolean of_imprime_extrato_cc (string ps_cliente, date pdt_periodo_de, date pdt_periodo_ate, decimal pdc_vendas, decimal pdc_titulos, decimal pdc_outros)
public function boolean of_imprime_extrato_cc_padrao (string as_cliente)
public function boolean of_atualiza_titulo_fechamento (string as_cliente, date adt_vencimento, string as_titulo)
public function boolean of_fechamento_cc_cliente_old (date adt_fechamento, date adt_inicial, date adt_final, long al_filial, string as_cliente, long al_portador, string as_titulo_banco, date adt_vencimento, decimal adc_vendas, decimal adc_outros, string as_responsavel, ref string as_titulo)
public function boolean of_grava_movimento (string ps_cliente, datetime pdh_movimento, decimal pdc_valor_movimento, integer pi_tipo_movimento, string ps_historico, string ps_titulo, date pdt_vencimento)
public function boolean of_fechamento_cc_cliente (date adt_fechamento, date adt_inicial, date adt_final, long al_filial, string as_cliente, long al_portador, string as_titulo_banco, date adt_vencimento, decimal adc_vendas, decimal adc_outros, string as_responsavel, ref string as_titulo, date adt_movimento)
public function boolean of_saldo_disponivel (string as_cliente, ref decimal adc_saldo)
public function boolean of_imprime_extrato_cc_padrao2 (string as_cliente, decimal adc_saldo_disponivel)
end prototypes

public function date of_data_inicio_fechamento (string ps_cliente);DATETIME lvdh_Venda_Final
			
DATE     lvdt_Venda_Final

Select max(dh_venda_final) Into :lvdh_Venda_Final
From titulo_receber
Where cd_cliente     = :ps_cliente
  and id_tipo_titulo = 'CC'
  and id_situacao    not in ( 'C' , 'E');

If ( Sqlca.Sqlcode = -1 ) Then	
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Erro ao localizar data inicial do per$$HEX1$$ed00$$ENDHEX$$odo de vendas do cliente : ' + ps_Cliente + ' ~r~r : ' + Sqlca.SqlErrText , StopSign! , Ok!) 						
Else

	If IsNull(lvdh_Venda_Final)  Then
		lvdt_Venda_Final = Date('01/01/1900')
	Else
		lvdt_Venda_Final = Date(lvdh_Venda_Final)
		lvdt_Venda_Final = RelativeDate(lvdt_Venda_Final,1)
	End If						
	
End If

Return lvdt_Venda_Final
end function

public function boolean of_movto_fechamento (ref long pl_codigo);Boolean lvb_Sucesso = False

Select cd_tipo_movimento Into :pl_Codigo
From contas_receber_tipo_movimento
Where id_tipo_conta        = 'CC'
  and id_fechamento_vendas = 'S'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		lvb_Sucesso = True
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "C$$HEX1$$f300$$ENDHEX$$digo do movimento de fechamento de vendas n$$HEX1$$e300$$ENDHEX$$o localizado.", StopSign!)
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do C$$HEX1$$f300$$ENDHEX$$digo do Movimento de Fechamento")
End Choose

Return lvb_Sucesso
end function

public function boolean of_movto_debito (ref long pl_codigo);Boolean lvb_Sucesso = False

Select cd_tipo_movimento Into :pl_Codigo
From contas_receber_tipo_movimento
Where id_tipo_conta   = 'CC'
  and id_outro_debito = 'S'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		lvb_Sucesso = True
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "C$$HEX1$$f300$$ENDHEX$$digo do movimento de d$$HEX1$$e900$$ENDHEX$$bito n$$HEX1$$e300$$ENDHEX$$o localizado.", StopSign!)
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do C$$HEX1$$f300$$ENDHEX$$digo do Movimento de D$$HEX1$$e900$$ENDHEX$$bito")
End Choose

Return lvb_Sucesso
end function

public function boolean of_movto_credito (ref long pl_codigo);Boolean lvb_Sucesso = False

Select cd_tipo_movimento Into :pl_Codigo
From contas_receber_tipo_movimento
Where id_tipo_conta    = 'CC'
  and id_outro_credito = 'S'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		lvb_Sucesso = True
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "C$$HEX1$$f300$$ENDHEX$$digo do movimento de cr$$HEX1$$e900$$ENDHEX$$dito n$$HEX1$$e300$$ENDHEX$$o localizado.", StopSign!)
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do C$$HEX1$$f300$$ENDHEX$$digo do Movimento de Cr$$HEX1$$e900$$ENDHEX$$dito")
End Choose

Return lvb_Sucesso
end function

public function boolean of_imprime_extrato_cc (string ps_cliente, date pdt_periodo_de, date pdt_periodo_ate);Decimal lvdc_Vendas, &
        lvdc_Titulos, &
		  lvdc_Outros

pdt_Periodo_De = gf_Primeiro_Dia_Mes(pdt_Periodo_De)

If Not This.of_Verifica_Saldo_Inicial(ps_Cliente, &
												  pdt_Periodo_De, &
												  ref lvdc_Vendas, &
												  ref lvdc_Titulos, &
												  ref lvdc_Outros) Then 
	Return False
End If

Return This.of_Imprime_Extrato_CC(ps_Cliente, &
											 pdt_Periodo_De, &
											 pdt_Periodo_Ate, &
											 lvdc_Vendas, &
											 lvdc_Titulos, &
											 lvdc_Outros)
end function

public function boolean of_verifica_saldo_inicial (string ps_cliente, date pdt_periodo_de, ref decimal pdc_vendas, ref decimal pdc_titulos, ref decimal pdc_outros);Boolean lvb_Sucesso = True

Date lvdt_Anterior, &
     lvdt_Saldo
	  
lvdt_Anterior = RelativeDate(pdt_Periodo_De, -1)

lvdt_Saldo = Date(String(lvdt_Anterior, "01/mm/yyyy"))

Select vl_vendas,
       vl_titulos,
		 vl_outros
Into :pdc_Vendas,
     :pdc_Titulos,
	  :pdc_Outros
From contas_receber_saldo
Where cd_conta      = :ps_Cliente
  and id_tipo_conta = 'CC'
  and dh_conta      = :lvdt_Saldo
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		
	Case 100
		pdc_Vendas  = 0
		pdc_Titulos = 0
		pdc_Outros  = 0
		
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Saldo inicial")
		lvb_Sucesso = False
End Choose

Return lvb_Sucesso
end function

public function boolean of_imprime_extrato_cc (string ps_cliente, date pdt_periodo_de, date pdt_periodo_ate, decimal pdc_vendas, decimal pdc_titulos, decimal pdc_outros);Long lvl_Linhas

dc_uo_ds_base lvds_Relatorio
lvds_Relatorio = Create dc_uo_ds_base

If Not lvds_Relatorio.Of_ChangeDataObject("dw_ge035_relatorio") Then 
	Destroy(lvds_Relatorio)
	Return False
End If

SetPointer(HourGlass!)

lvl_Linhas = lvds_Relatorio.Retrieve(ps_Cliente, pdt_Periodo_De, pdt_Periodo_Ate)

lvds_Relatorio.Object.Movimento.Object.Vl_Inicial_Vendas [1] = pdc_Vendas
lvds_Relatorio.Object.Movimento.Object.Vl_Inicial_Titulos[1] = pdc_Titulos
lvds_Relatorio.Object.Movimento.Object.Vl_Inicial_Outros [1] = pdc_Outros

If lvl_Linhas <> -1 Then
	If lvl_Linhas > 0 Then		
		lvds_Relatorio.Print(True)
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existem informa$$HEX2$$e700f500$$ENDHEX$$es para impress$$HEX1$$e300$$ENDHEX$$o.", Information!)
	End If
End If

SetPointer(Arrow!)

Destroy(lvds_Relatorio)

Return True
end function

public function boolean of_imprime_extrato_cc_padrao (string as_cliente);Long lvl_Linhas

dc_uo_ds_base lvds_1
lvds_1 = Create dc_uo_ds_base

If Not lvds_1.of_ChangeDataObject("dw_ge035_extrato_padrao") Then 
	Destroy(lvds_1)
	Return False
End If

SetPointer(HourGlass!)

lvl_Linhas = lvds_1.Retrieve(as_Cliente)

If lvl_Linhas <> -1 Then
	If lvl_Linhas > 0 Then		
		lvds_1.Print(True)
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existem informa$$HEX2$$e700f500$$ENDHEX$$es para impress$$HEX1$$e300$$ENDHEX$$o do extrato.", Information!)
	End If
End If

SetPointer(Arrow!)

Destroy(lvds_1)

Return True
end function

public function boolean of_atualiza_titulo_fechamento (string as_cliente, date adt_vencimento, string as_titulo);If PosA( Upper( SqlCa.SqlReturnData ), 'POSTGRESQL' ) > 0 Then
	Update contas_receber_movimento as m
	Set nr_titulo_fechamento = :as_titulo
	From contas_receber_tipo_movimento t
	Where m.cd_conta      = :as_Cliente
	  and m.id_tipo_conta = 'CC'
	  and m.dh_vencimento <= :adt_Vencimento
	  and m.nr_titulo_fechamento is null
	  and t.cd_tipo_movimento = m.cd_tipo_movimento 
	  and t.id_atualizacao_saldo in ('1', '3')
	Using SqlCa;
Else

	Update contas_receber_movimento
	Set nr_titulo_fechamento = :as_titulo
	From contas_receber_movimento m,   
		  contas_receber_tipo_movimento t
	Where m.cd_conta      = :as_Cliente
	  and m.id_tipo_conta = 'CC'
	  and m.dh_vencimento <= :adt_Vencimento
	  and m.nr_titulo_fechamento is null
	  and t.cd_tipo_movimento = m.cd_tipo_movimento 
	  and t.id_atualizacao_saldo in ('1', '3')
	Using SqlCa;
End If

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do T$$HEX1$$ed00$$ENDHEX$$tulo nos Movimentos com Data de Vencimento")
	Return False
End If

Return True
end function

public function boolean of_fechamento_cc_cliente_old (date adt_fechamento, date adt_inicial, date adt_final, long al_filial, string as_cliente, long al_portador, string as_titulo_banco, date adt_vencimento, decimal adc_vendas, decimal adc_outros, string as_responsavel, ref string as_titulo);String lvs_Historico

Long lvl_Tipo_Movto
		  
DATETIME lvdh_Movimento

Decimal lvdc_Valor_Titulo

lvdh_Movimento = DateTime(adt_Final)

If adc_Vendas > adc_Outros Then
	uo_Titulo lvo_Titulo		 
	lvo_Titulo = Create uo_Titulo
	
	lvdc_Valor_Titulo = adc_Vendas - adc_Outros
	
	as_Titulo = lvo_Titulo.of_Insere_Titulo_Conta_Corrente(al_Filial, &
																			 as_Cliente, &
																			 al_Portador, &
																			 as_Titulo_Banco, &
																			 adt_Vencimento, &
																			 lvdc_Valor_Titulo, &
																			 lvdc_Valor_Titulo, &
																			 'B', &
																			 adt_Inicial, &
																			 adt_Final, &
																			 as_Responsavel,&
																			 'CC', &
																			 lvdh_Movimento)
																				 
	Destroy(lvo_Titulo)
	
	//Retorno nulo n$$HEX1$$e300$$ENDHEX$$o conseguiu gravar titulo
	If IsNull(as_Titulo) or as_Titulo = "" Then Return False
End If

If adc_Vendas > 0 Then
	If Not This.of_Movto_Fechamento(ref lvl_Tipo_Movto) Then Return False

	lvs_Historico = "FECHAMENTO DE VENDAS"
	
	If Not This.of_Grava_Movimento(as_Cliente,&
											 lvdh_Movimento, &
											 adc_Vendas, &
											 lvl_Tipo_Movto, &
											 lvs_Historico, &
											 as_Titulo, &
											 adt_Fechamento) Then
		Return False
	End If
End If

If adc_Outros <> 0 Then
	If adc_Outros > 0 Then
		If Not this.of_Movto_Debito(ref lvl_Tipo_Movto) Then Return False
		
		If adc_Outros > adc_Vendas Then
			adc_Outros = adc_Vendas
		End If
	Else
		If Not this.of_Movto_Credito(ref lvl_Tipo_Movto) Then Return False
		adc_Outros = adc_Outros * -1
	End If

	lvs_Historico = "FECHAMENTO DE DEBITOS/CREDITOS"
		
	If Not This.of_Grava_Movimento(as_Cliente,&
											 lvdh_Movimento, &
											 adc_Outros, &
											 lvl_Tipo_Movto, &
											 lvs_Historico, &
											 as_Titulo, &
											 adt_Fechamento) Then
		Return False
	End If
End If

If as_Titulo <> "" Then
	If Not This.of_Atualiza_Titulo_Fechamento(as_Cliente, adt_Fechamento, as_Titulo) Then 
		Return False
	End If
End If

Return True
end function

public function boolean of_grava_movimento (string ps_cliente, datetime pdh_movimento, decimal pdc_valor_movimento, integer pi_tipo_movimento, string ps_historico, string ps_titulo, date pdt_vencimento);String lvs_Documento

If ps_Titulo = "" Then
	lvs_Documento = ""
	
	Insert Into contas_receber_movimento (cd_conta,   
													  id_tipo_conta,   
													  cd_tipo_movimento,   
													  dh_movimento,   
													  dh_sistema,   
													  vl_movimento,
													  cd_filial,
													  nr_documento,   
													  de_historico,
													  dh_vencimento)  
	Select :ps_cliente,
   	    'CC',
			 :pi_Tipo_Movimento,
			 :pdh_Movimento,
			 getdate(),
			 :pdc_Valor_Movimento,
			 cd_filial_matriz,
			 :lvs_Documento,
			 :ps_historico,
			 :pdt_Vencimento
	From parametro
	Using SqlCa;
Else
	lvs_Documento = LeftA(ps_Titulo, 4) + "-" + MidA(ps_Titulo, 5, 7) + "-" + RightA(ps_Titulo, 2)
	
	Insert Into contas_receber_movimento (cd_conta,   
													  id_tipo_conta,   
													  cd_tipo_movimento,   
													  dh_movimento,   
													  dh_sistema,   
													  vl_movimento,
													  cd_filial,
													  nr_documento,   
													  de_historico,   
													  nr_titulo_fechamento,
													  dh_vencimento)  
	Select :ps_cliente,
   	    'CC',
			 :pi_Tipo_Movimento,
			 :pdh_Movimento,
			 getdate(),
			 :pdc_Valor_Movimento,
			 cd_filial_matriz,
			 :lvs_Documento,
			 :ps_historico,
			 :ps_titulo,
			 :pdt_Vencimento
	From parametro
	Using SqlCa;
End If

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Inclus$$HEX1$$e300$$ENDHEX$$o do Movimento")
	Return False
End If

Return True
end function

public function boolean of_fechamento_cc_cliente (date adt_fechamento, date adt_inicial, date adt_final, long al_filial, string as_cliente, long al_portador, string as_titulo_banco, date adt_vencimento, decimal adc_vendas, decimal adc_outros, string as_responsavel, ref string as_titulo, date adt_movimento);String lvs_Historico

Long 	lvl_Tipo_Movto, &
		lvl_Nulo

Integer lvi_Tipo_Movimento

Decimal lvdc_Valor_Titulo

If IsNull(as_Titulo) Then as_Titulo = ""

SetNull(lvl_Nulo)

If adc_Vendas >= adc_Outros Then
	uo_Titulo lvo_Titulo		 
	lvo_Titulo = Create uo_Titulo
	
	If adc_Vendas = adc_Outros Then
		lvdc_Valor_Titulo = adc_Vendas
	Else
		lvdc_Valor_Titulo = adc_Vendas - adc_Outros
	End If
	
	as_Titulo = lvo_Titulo.of_Insere_Titulo_Conta_Corrente(	al_Filial, &
																as_Cliente, &
																al_Portador, &
																as_Titulo_Banco, &
																adt_Vencimento, &
																lvdc_Valor_Titulo, &
																lvdc_Valor_Titulo, &
																'B', &
																adt_Inicial, &
																adt_Final, &
																as_Responsavel,&
																'CC', &
																DateTime(adt_Movimento))
																
	If adc_Vendas = adc_Outros Then
		lvi_Tipo_Movimento = lvo_Titulo.of_Movto_Pagto()
		
		If Not lvo_Titulo.of_Insere_Movimento(	as_Titulo, &
													lvi_Tipo_Movimento, &
													DateTime(adt_Movimento), &
													DateTime(adt_Movimento), &
													lvdc_Valor_Titulo, &
													0.00, &
													0.00, &
													0.00, &
													0.00, &
													'N', &
													as_Responsavel, &
													'T$$HEX1$$cd00$$ENDHEX$$TULO GERADO E BAIXADO PELO FECHAM. CC', &
													lvl_Nulo, &
													al_Filial) Then Return False		
	End If
																				 
	Destroy(lvo_Titulo)
	
	//Retorno nulo n$$HEX1$$e300$$ENDHEX$$o conseguiu gravar titulo
	If IsNull(as_Titulo) or as_Titulo = "" Then Return False
End If

If adc_Vendas > 0 Then
	If Not This.of_Movto_Fechamento(ref lvl_Tipo_Movto) Then Return False

	lvs_Historico = "FECHAMENTO DE VENDAS"
	
	If Not This.of_Grava_Movimento(as_Cliente,&
											 DateTime(adt_Movimento), &
											 adc_Vendas, &
											 lvl_Tipo_Movto, &
											 lvs_Historico, &
											 as_Titulo, &
											 adt_Fechamento) Then
		Return False
	End If
End If

If adc_Outros <> 0 Then
	If adc_Outros > 0 Then
		If Not this.of_Movto_Debito(ref lvl_Tipo_Movto) Then Return False
		
		If adc_Outros > adc_Vendas Then
			adc_Outros = adc_Vendas
		End If
	Else
		If Not this.of_Movto_Credito(ref lvl_Tipo_Movto) Then Return False
		adc_Outros = adc_Outros * -1
	End If

	lvs_Historico = "FECHAMENTO DE DEBITOS/CREDITOS"
		
	If Not This.of_Grava_Movimento(as_Cliente,&
											 DateTime(adt_Movimento), &
											 adc_Outros, &
											 lvl_Tipo_Movto, &
											 lvs_Historico, &
											 as_Titulo, &
											 adt_Fechamento) Then
		Return False
	End If
End If

If as_Titulo <> "" Then
	If Not This.of_Atualiza_Titulo_Fechamento(as_Cliente, adt_Fechamento, as_Titulo) Then 
		Return False
	End If
End If

Return True
end function

public function boolean of_saldo_disponivel (string as_cliente, ref decimal adc_saldo);Decimal lvdc_Vendas,&
         lvdc_Titulos,&
	 lvdc_Outros,&
 	 lvdc_OnLine,&
    	 lvdc_Limite_Credito_Utilizado, & 
         lvdc_Limite_Credito_Saldo,&
	 lvdc_Limite_Credito
Datetime lvdh_fechamento_contas_receber
       
Select vl_limite_credito_aprovado
  Into :lvdc_limite_credito
From cliente
Where cd_cliente = :as_Cliente
 Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Erro")		
	Return False
End If


Select dh_fechamento_contas_receber
  Into :lvdh_fechamento_contas_receber
  From parametro
where id_parametro = '1'
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Erro")		
	Return False
End If
 
Select cr.vl_vendas,
  cr.vl_titulos,
   cr.vl_outros
  Into :lvdc_Vendas,
  :lvdc_Titulos,
  :lvdc_Outros
From contas_receber_saldo cr,
  cliente c
Where cr.cd_conta   = c.cd_cliente
  and cr.id_tipo_conta = c.id_tipo_cliente
  and cr.cd_conta      = :as_Cliente
  and cr.dh_conta      = :lvdh_fechamento_contas_receber
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Erro")		
	Return False
End If
 

Select sum(case id_tipo_movimento
  when 1 then vl_movimento 
  when 2 then vl_movimento * -1
  when 3 then vl_movimento * -1
  when 4 then vl_movimento * -1
  end)
  Into :lvdc_OnLine
From movimento_credito_online
Where cd_cliente = :as_Cliente
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Erro")		
	Return False
End If

If  Isnull(lvdc_limite_credito) Then
	lvdc_limite_credito = 0
End If
If  Isnull(lvdc_Limite_Credito_Utilizado) Then
	lvdc_limite_credito = 0
End If
If  Isnull(lvdc_Limite_Credito_Saldo) Then
	lvdc_limite_credito = 0
End If
If  Isnull(lvdc_Vendas) Then
	lvdc_Vendas = 0
End If
 If  Isnull(lvdc_Titulos) Then
	lvdc_Titulos = 0
End If
If  Isnull(lvdc_Outros) Then
	lvdc_Outros = 0
End If
If  Isnull(lvdc_OnLine) Then
	lvdc_OnLine = 0
End If 

lvdc_Limite_Credito_Utilizado = (lvdc_Vendas + lvdc_Titulos + lvdc_OnLine) - lvdc_Outros
lvdc_Limite_Credito_Saldo     = lvdc_Limite_Credito - lvdc_Limite_Credito_Utilizado
adc_saldo = lvdc_Limite_Credito_Saldo 

Return True
end function

public function boolean of_imprime_extrato_cc_padrao2 (string as_cliente, decimal adc_saldo_disponivel);Long lvl_Linhas

dc_uo_ds_base lvds_1
lvds_1 = Create dc_uo_ds_base

If Not lvds_1.of_ChangeDataObject("dw_ge035_extrato_padrao") Then 
	Destroy(lvds_1)
	Return False
End If

SetPointer(HourGlass!)

lvl_Linhas = lvds_1.Retrieve(as_Cliente,adc_saldo_disponivel)

If lvl_Linhas <> -1 Then
	If lvl_Linhas > 0 Then		
		lvds_1.Print(True)
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existem informa$$HEX2$$e700f500$$ENDHEX$$es para impress$$HEX1$$e300$$ENDHEX$$o do extrato.", Information!)
	End If
End If

SetPointer(Arrow!)

Destroy(lvds_1)

Return True
end function

on uo_conta_corrente.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_conta_corrente.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

