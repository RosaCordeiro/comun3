HA$PBExportHeader$w_ge638_posicao_contas_receber.srw
forward
global type w_ge638_posicao_contas_receber from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge638_posicao_contas_receber from dc_w_selecao_lista_relatorio
integer width = 4434
integer height = 2396
string title = "GE638 - Relat$$HEX1$$f300$$ENDHEX$$rio de Posi$$HEX2$$e700e300$$ENDHEX$$o de Contas $$HEX1$$e000$$ENDHEX$$ Receber"
boolean resizable = false
end type
global w_ge638_posicao_contas_receber w_ge638_posicao_contas_receber

type variables
date	ivdt_fechamento		, &
		ivdt_movimentacao	, &
	 	ivdt_Saldo

boolean ivb_verificar_movimentos = false

string ivs_tipo_movimento

uo_convenio 	ivo_convenio
uo_cliente 		ivo_cliente
uo_fornecedor 	ivo_fornecedor
end variables

forward prototypes
public function boolean wf_verifica_datas ()
public function boolean wf_atualiza_movimento_conta (string as_conta, string as_tipo, decimal adc_vendas, decimal adc_titulos, decimal adc_outros)
public subroutine wf_atualiza_movimento ()
public subroutine wf_atualiza_saldo_patrimonio ()
public subroutine wf_atualiza_saldo_verba ()
public subroutine wf_prepara_sql (ref string as_sql, string as_tipo, string as_conta, date adt_data_saldo, date adt_data_limite)
end prototypes

public function boolean wf_verifica_datas ();Boolean lvb_Sucesso

DateTime lvdh_Movto, &
         lvdh_Fechamento

Select dh_movimentacao,
       dh_fechamento_contas_receber 
Into :lvdh_Movto,
     :lvdh_Fechamento
From parametro
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		ivdt_Fechamento   = Date(lvdh_Fechamento)
		ivdt_Movimentacao = Date(lvdh_Movto)
		
		dw_1.Object.Dt_Limite[1] = ivdt_Movimentacao
		
		lvb_Sucesso = True
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Data de fechamento n$$HEX1$$e300$$ENDHEX$$o localizada.", StopSign!)
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da Data de Fechamento")
End Choose

Return lvb_Sucesso
end function

public function boolean wf_atualiza_movimento_conta (string as_conta, string as_tipo, decimal adc_vendas, decimal adc_titulos, decimal adc_outros);Long lvl_Find

String lvs_Find

Decimal	lvdc_Saldo_Vendas, &
			lvdc_Saldo_Titulos, &
			lvdc_Saldo_Outros

lvs_Find = "cd_conta = '" + as_Conta + "' and id_tipo_conta = '" + as_Tipo + "'"

lvl_Find = dw_2.Find(lvs_Find, 1, dw_2.RowCount())

If lvl_Find < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Erro no find para atualiza$$HEX2$$e700e300$$ENDHEX$$o da conta '" + lvs_Find + "'.", StopSign!)
	Return False
End If

If lvl_Find > 0 Then
	lvdc_Saldo_Vendas	= dw_2.Object.Vl_Vendas	[lvl_Find]
	lvdc_Saldo_Titulos		= dw_2.Object.Vl_Titulos	[lvl_Find]
	lvdc_Saldo_Outros		= dw_2.Object.Vl_Outros	[lvl_Find]
	
	dw_2.Object.Vl_Vendas	[lvl_Find] = lvdc_Saldo_Vendas+ adc_Vendas
	dw_2.Object.Vl_Titulos	[lvl_Find] = lvdc_Saldo_Titulos	+ adc_Titulos
	dw_2.Object.Vl_Outros	[lvl_Find] = lvdc_Saldo_Outros	+ adc_Outros
	dw_2.Object.vl_total		[lvl_Find] = dw_2.Object.vl_titulos	[lvl_Find] + dw_2.Object.vl_vendas [lvl_Find] - dw_2.Object.vl_outros [lvl_Find]
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Conta '" + lvs_Find + "' n$$HEX1$$e300$$ENDHEX$$o localizada para atualiza$$HEX2$$e700e300$$ENDHEX$$o dos movimentos.", StopSign!)
End If

Return True
end function

public subroutine wf_atualiza_movimento ();Date	lvdt_Inicio, &
		lvdt_Termino

Long lvl_Total, &
		lvl_Contador

String lvs_Conta, &
		 lvs_Tipo, &
		 lvs_Conta_Anterior, &
		 lvs_Tipo_Anterior, &
		 lvs_Saldo, &
		 lvs_Credito_Debito
		 
Decimal	lvdc_Valor, &
			lvdc_Movto_Vendas, &
			lvdc_Movto_Titulos, &
			lvdc_Movto_Outros
			
String lvs_Considera_PBM

Try
	
	Open(w_Aguarde)
	dc_uo_ds_Base lvds_1
	lvds_1 = Create dc_uo_ds_Base
	
	w_Aguarde.Title = "Verificando a Movimenta$$HEX2$$e700e300$$ENDHEX$$o das Contas..."
	
	If Not lvds_1.of_ChangeDataObject("dw_ge638_movimento_conta") Then Return
	
	dw_1.accepttext( )
	lvs_Considera_PBM	= dw_1.Object.id_considerar_pbm	[1]
	lvs_Conta				= dw_1.Object.cd_conta					[1]
	
	If lvs_Considera_PBM = "N" Then
		lvds_1.of_AppendWhere("m.cd_conta not in ('52575', '53724', '53725', '52349' ,'52718','53847')")
	End If
	
	If lvs_Conta <> "" Then
		lvds_1.of_AppendWhere("m.cd_conta = '"+lvs_Conta+"'")
	End If
	
	lvdt_Termino 	= dw_1.Object.Dt_Limite[1]
	lvdt_Inicio  		= Date("01/" + String(lvdt_Termino, "mm/yyyy"))

	lvds_1.of_AppendWhere("m.id_tipo_conta in (" + ivs_Tipo_Movimento + ")")
	
	lvl_Total = lvds_1.Retrieve(lvdt_Inicio, lvdt_Termino)
	
	If lvl_Total > 0 Then
		w_Aguarde.uo_Progress.of_SetMax(lvl_Total)
		
		For lvl_Contador = 1 To lvl_Total
			
			lvs_Conta          		= lvds_1.Object.Cd_Conta            		[lvl_Contador]
			lvs_Tipo           		= lvds_1.Object.Id_Tipo_Conta       	[lvl_Contador]
			lvs_Saldo          		= lvds_1.Object.Id_Atualizacao_Saldo[lvl_Contador]
			lvs_Credito_Debito 	= lvds_1.Object.Id_Credito_Debito  	[lvl_Contador]
			lvdc_Valor         		= lvds_1.Object.Vl_Movimento      	[lvl_Contador]
						
		
			If lvs_Conta <> lvs_Conta_Anterior or lvs_Tipo <> lvs_Tipo_Anterior Then
				If lvl_Contador > 1 Then
					If Not wf_Atualiza_Movimento_Conta(lvs_Conta_Anterior, &
																  lvs_Tipo_Anterior, &
																  lvdc_Movto_Vendas, &
																  lvdc_Movto_Titulos, &
																  lvdc_Movto_Outros) Then
						Exit
					End If
				End If
				
				lvs_Conta_Anterior 	= lvs_Conta
				lvs_Tipo_Anterior  	= lvs_Tipo
				
				lvdc_Movto_Vendas  	= 0
				lvdc_Movto_Titulos 	= 0
				lvdc_Movto_Outros  	= 0			
			End If
			
			Choose Case lvs_Saldo
				Case "1"
					If lvs_Credito_Debito = "C" Then
						lvdc_Movto_Vendas = lvdc_Movto_Vendas - lvdc_Valor
					Else
						lvdc_Movto_Vendas = lvdc_Movto_Vendas + lvdc_Valor
					End If
					
				Case "2"
					If lvs_Credito_Debito = "C" Then
						lvdc_Movto_Titulos = lvdc_Movto_Titulos - lvdc_Valor
					Else
						lvdc_Movto_Titulos = lvdc_Movto_Titulos + lvdc_Valor
					End If
					
				Case "3"
					If lvs_Credito_Debito = "C" Then
						lvdc_Movto_Outros = lvdc_Movto_Outros + lvdc_Valor
					Else
						lvdc_Movto_Outros = lvdc_Movto_Outros - lvdc_Valor
					End If
			End Choose		
			
			w_Aguarde.uo_Progress.of_SetProgress(lvl_Contador)
		Next
	
		// Atualiza a $$HEX1$$fa00$$ENDHEX$$ltima conta
		wf_Atualiza_Movimento_Conta( lvs_Conta_Anterior, &
												 lvs_Tipo_Anterior, &
												 lvdc_Movto_Vendas, &
												 lvdc_Movto_Titulos, &
												 lvdc_Movto_Outros)
												
	Else
		//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Movimentos n$$HEX1$$e300$$ENDHEX$$o localizados para apura$$HEX2$$e700e300$$ENDHEX$$o dos saldos.", Information!)
	End If
Finally
	If IsValid(lvds_1) then Destroy(lvds_1)
	If IsValid(w_Aguarde) then Close(w_Aguarde)	
End try
end subroutine

public subroutine wf_atualiza_saldo_patrimonio ();String lvs_Crediario
String lvs_Patrimonio
String lvs_Cd_Cliente
String lvs_Cd_Cliente_SAP
String lvs_Nm_Cliente
String lvs_Conta

Long lvl_Linha
Long lvl_Linhas
Long lvl_Find

Decimal{2} lvdc_Valor
Decimal{2} lvdc_Aux
Decimal{2} lvdc_LP

Date lvdt_Limite

Try
	
	dw_1.Accepttext( )
	lvdt_Limite		= dw_1.Object.dt_limite	[1]
	lvs_Crediario	= dw_1.Object.id_cr 		[1]
	lvs_Patrimonio	= dw_1.Object.id_pt 		[1]
	lvs_Conta		= dw_1.Object.cd_conta	[1]
	
	If lvdt_Limite > ivdt_movimentacao Then lvdt_Limite = ivdt_movimentacao
	
	Open(w_Aguarde)
	dc_uo_ds_Base lvds_1
	lvds_1 = Create dc_uo_ds_Base
	
	w_Aguarde.Title = "Deduzindo os saldos referentes a vendas patrimoniais..."
	
	If Not lvds_1.of_ChangeDataObject("ds_ge638_posicao_patrimonio") Then Return
	
	If lvs_Conta <> "" Then
		lvds_1.of_appendwhere( "t.cd_cliente = '"+lvs_Conta+"'", 1 )
		lvds_1.of_appendwhere( "t.cd_cliente = '"+lvs_Conta+"'", 2 )
	End If
	
	lvl_Linhas = lvds_1.Retrieve(lvdt_Limite)
	
	For lvl_Linha = 1 To lvl_Linhas
		lvs_Cd_Cliente			= lvds_1.Object.cd_cliente			[lvl_Linha]
		lvs_Nm_Cliente			= lvds_1.Object.nm_cliente			[lvl_Linha]
		lvs_Cd_Cliente_SAP	= lvds_1.Object.cd_cliente_sap	[lvl_Linha]
		lvdc_Valor				= lvds_1.Object.vl_total			[lvl_Linha]
		
		//Reduzir as vendas credi$$HEX1$$e100$$ENDHEX$$rio
		If lvs_Crediario = "S" Then
			lvl_Find = dw_2.Find("id_tipo_conta = 'CR' and cd_conta='"+lvs_Cd_Cliente+"'", 1, dw_2.RowCount())
			
			If lvl_Find > 0 Then
				
				select coalesce(sum(case when mt.cd_tipo_movimento in (1,4) then 1 else -1 end * (mt.vl_movimento - coalesce(mt.vl_juros_recebidos,0) + coalesce(mt.vl_desconto_concedido,0) - coalesce(mt.vl_despesas_recebidas,0) - coalesce(mt.vl_multa_recebida,0))),0)
				 into :lvdc_LP
				from movimento_titulo_receber mt
				inner join titulo_receber t
					on t.nr_titulo = mt.nr_titulo
				inner join cliente c (index pk_cliente)
					on c.cd_cliente = t.cd_cliente
				left outer join nf_diversa n
					on n.cd_filial_origem = t.cd_filial_nf
					and n.nr_nf = t.nr_nf
					and n.de_serie = t.de_serie
					and n.de_especie = t.de_especie
				left outer join (
						select 
							cast(isap.cd_chave_legado as integer) cd_filial_origem,
							j1.nfnum as nr_nf,
							'NFE' de_especie,
							j2.series as de_serie
						from j_1bnfdoc_1 j1
							inner join j_1bnfdoc_2 j2
								on j2.mandt = j1.mandt 
								and j2.docnum = j1.docnum 
								and j2.nr_sequencial = j1.nr_sequencial
								and j2.nftype = 'ZL' /* Vendas de Ativo */
							inner join integracao_sap isap
								on isap.cd_empresa = 1000
								and isap.cd_tabela = 'FILIAL'
								and isap.cd_chave_sap = j1.branch
					) as j_1bnfdoc
						on j_1bnfdoc.cd_filial_origem = t.cd_filial_nf
						and j_1bnfdoc.nr_nf = t.nr_nf
						and j_1bnfdoc.de_serie = t.de_serie
						and j_1bnfdoc.de_especie = t.de_especie
				Where t.cd_cliente = :lvs_Cd_Cliente
				     and t.dh_emissao <= :lvdt_Limite
					and (t.dh_baixa > :lvdt_Limite or t.id_situacao = 'A')
					and t.id_tipo_titulo = 'CR'
					and mt.dh_movimento <= :lvdt_Limite 
					and t.id_perdas_lucros = 'S'
					and (n.nr_nf is not null or j_1bnfdoc.nr_nf is not null)
				Using SqlCa;				
				
				lvdc_Valor 	= lvdc_Valor - lvdc_LP
				lvdc_Aux 	= dw_2.Object.vl_titulos [lvl_Find]
				
				dw_2.Object.vl_titulos	[lvl_Find] = lvdc_Aux - lvdc_Valor
				dw_2.Object.vl_total		[lvl_Find] = dw_2.Object.vl_titulos	[lvl_Find] + dw_2.Object.vl_vendas [lvl_Find] - dw_2.Object.vl_outros [lvl_Find]
			End If
		End If
		
		//Adicionar as vendas patrim$$HEX1$$f400$$ENDHEX$$nio
		If lvs_Patrimonio = "S" Then 
			lvl_Find = dw_2.InsertRow(0)
			
			dw_2.Object.cd_conta			[lvl_Find] = lvs_Cd_Cliente
			dw_2.Object.cd_cliente_sap	[lvl_Find] = lvs_Cd_Cliente_SAP
			dw_2.Object.nm_conta			[lvl_Find] = lvs_Nm_Cliente
			dw_2.Object.id_tipo_conta		[lvl_Find] = "PT"
			dw_2.Object.vl_titulos			[lvl_Find] = lvdc_Valor
			dw_2.Object.vl_total				[lvl_Find] = dw_2.Object.vl_titulos	[lvl_Find] + dw_2.Object.vl_vendas [lvl_Find] - dw_2.Object.vl_outros [lvl_Find]
		End If
	Next
Finally
	If IsValid(lvds_1) Then Destroy(lvds_1)
	If IsValid(w_Aguarde) Then Close(w_Aguarde)
	
End Try
end subroutine

public subroutine wf_atualiza_saldo_verba ();String lvs_Crediario
String lvs_Verba
String lvs_Cd_Cliente
String lvs_Cd_Cliente_SAP
String lvs_Nm_Cliente
String lvs_Conta

Long lvl_Linha
Long lvl_Linhas
Long lvl_Find

Decimal{2} lvdc_Valor
Decimal{2} lvdc_Outro
Decimal{2} lvdc_Aux
Decimal{2} lvdc_LP

Date lvdt_Limite

Try
	
	dw_1.Accepttext( )
	lvdt_Limite		= dw_1.Object.dt_limite	[1]
	lvs_Crediario	= dw_1.Object.id_cr 		[1]
	lvs_Verba		= dw_1.Object.id_vb 		[1]
	lvs_Conta		= dw_1.Object.cd_conta	[1]
	
	//If lvdt_Limite > ivdt_movimentacao Then lvdt_Limite = ivdt_movimentacao
	
	Open(w_Aguarde)
	dc_uo_ds_Base lvds_1
	lvds_1 = Create dc_uo_ds_Base
	
	w_Aguarde.Title = "Deduzindo os saldos referentes a vendas patrimoniais..."
	
	If Not lvds_1.of_ChangeDataObject("ds_ge638_posicao_verba") Then Return
	
	If lvs_Conta <> "" Then
		lvds_1.of_appendwhere( "t.cd_cliente = '"+lvs_Conta+"'", 1 )
		lvds_1.of_appendwhere( "crm.cd_conta = '"+lvs_Conta+"'", 2 )
	End If
	
	lvl_Linhas = lvds_1.Retrieve(lvdt_Limite)
	
	For lvl_Linha = 1 To lvl_Linhas
		lvs_Cd_Cliente			= lvds_1.Object.cd_cliente			[lvl_Linha]
		lvs_Nm_Cliente			= lvds_1.Object.nm_cliente			[lvl_Linha]
		lvs_Cd_Cliente_SAP	= lvds_1.Object.cd_cliente_sap	[lvl_Linha]
		lvdc_Valor				= lvds_1.Object.vl_total			[lvl_Linha]
		lvdc_Outro				= lvds_1.Object.vl_outros			[lvl_Linha]
		
		//Reduzir as vendas credi$$HEX1$$e100$$ENDHEX$$rio
		If lvs_Crediario = "S" Then
			lvl_Find = dw_2.Find("id_tipo_conta = 'CR' and cd_conta='"+lvs_Cd_Cliente+"'", 1, dw_2.RowCount())
			
			If lvl_Find > 0 Then
				
				select coalesce(sum(case when mt.cd_tipo_movimento in (1,4) then 1 else -1 end * (mt.vl_movimento - coalesce(mt.vl_juros_recebidos,0) + coalesce(mt.vl_desconto_concedido,0) - coalesce(mt.vl_despesas_recebidas,0) - coalesce(mt.vl_multa_recebida,0))),0)
				 into :lvdc_LP
				from titulo_receber t (index idx_docto_sap)
				inner join movimento_titulo_receber mt
					on mt.nr_titulo = t.nr_titulo
				inner join cliente c (index pk_cliente)
					on c.cd_cliente = t.cd_cliente
				Where t.cd_cliente = :lvs_Cd_Cliente
				     and t.dh_emissao <= :lvdt_Limite
					and (t.dh_baixa > :lvdt_Limite or t.id_situacao = 'A')
					and t.id_tipo_titulo = 'CR'
					and mt.dh_movimento <= :lvdt_Limite
					and t.nr_conta_sap = '0011201067'
					and t.nr_documento_sap is not null
					and t.id_perdas_lucros = 'S'
				Using SqlCa;				
				
				lvdc_Valor 	= lvdc_Valor - lvdc_LP
				lvdc_Aux 	= dw_2.Object.vl_titulos [lvl_Find]
				
				dw_2.Object.vl_outros	[lvl_Find] = dw_2.Object.vl_outros	[lvl_Find] - lvdc_Outro
				dw_2.Object.vl_titulos	[lvl_Find] = lvdc_Aux - lvdc_Valor
				dw_2.Object.vl_total		[lvl_Find] = dw_2.Object.vl_titulos	[lvl_Find] + dw_2.Object.vl_vendas [lvl_Find] - dw_2.Object.vl_outros [lvl_Find]
			End If
		End If
		
		//Adicionar os t$$HEX1$$ed00$$ENDHEX$$tulos de verbas
		If lvs_Verba = "S" Then 
			lvl_Find = dw_2.Find("id_tipo_conta = 'VB' and cd_conta='"+lvs_Cd_Cliente+"'", 1, dw_2.RowCount())
			
			If Not (lvl_Find > 0) Then 
				lvl_Find = dw_2.InsertRow(0)
			Else
				lvdc_Valor += dw_2.Object.vl_titulos	[lvl_Find]
				lvdc_Outro += dw_2.Object.vl_outros		[lvl_Find]
			End If
			
			dw_2.Object.cd_conta				[lvl_Find] = lvs_Cd_Cliente
			dw_2.Object.cd_cliente_sap		[lvl_Find] = lvs_Cd_Cliente_SAP
			dw_2.Object.nm_conta				[lvl_Find] = lvs_Nm_Cliente
			dw_2.Object.id_tipo_conta		[lvl_Find] = "VB"
			dw_2.Object.vl_titulos			[lvl_Find] = lvdc_Valor
			dw_2.Object.vl_outros			[lvl_Find] = lvdc_Outro
			dw_2.Object.vl_total				[lvl_Find] = dw_2.Object.vl_titulos	[lvl_Find] + dw_2.Object.vl_vendas [lvl_Find] - dw_2.Object.vl_outros [lvl_Find]
		End If
	Next
Finally
	If IsValid(lvds_1) Then Destroy(lvds_1)
	If IsValid(w_Aguarde) Then Close(w_Aguarde)
	
End Try
end subroutine

public subroutine wf_prepara_sql (ref string as_sql, string as_tipo, string as_conta, date adt_data_saldo, date adt_data_limite);String lvs_SQL
Date lvdt_Saldo_Limite

If ivs_Tipo_Movimento <> "" Then ivs_Tipo_Movimento += ", "

If gf_Ultimo_Dia_Mes(adt_data_limite) Then
	lvdt_Saldo_Limite = Date("01/" + String(adt_data_limite, "mm/yyyy"))
Else
	lvdt_Saldo_Limite = Date("01/" + String(adt_data_limite, "mm/yyyy"))
	lvdt_Saldo_Limite = Date("01/" + String(RelativeDate(lvdt_Saldo_Limite, -1), "mm/yyyy"))
End If
	
ivs_Tipo_Movimento += "'" + as_Tipo + "'"

Choose Case as_Tipo
	Case "CV"
		lvs_SQL = "select s.cd_conta, v.cd_cliente_sap as cd_cliente_sap, s.id_tipo_conta, v.nm_fantasia nm_conta, " + &
					 "s.vl_vendas, s.vl_titulos, s.vl_outros, coalesce(s.vl_vendas, 0) + coalesce(s.vl_titulos, 0) - coalesce(s.vl_outros, 0) as vl_total " + &
					 "from contas_receber_saldo s, convenio v " + &
					 "where s.id_tipo_conta = 'CV' " + &
					 "and v.cd_convenio = convert(integer, s.cd_conta)"
					
	Case "CC", "CR", "PT", "VB"
		lvs_SQL = "select s.cd_conta, c.cd_cliente_sap as cd_cliente_sap, s.id_tipo_conta, c.nm_cliente nm_conta, " + &
					 "s.vl_vendas, s.vl_titulos, s.vl_outros, coalesce(s.vl_vendas, 0) + coalesce(s.vl_titulos, 0) - coalesce(s.vl_outros, 0) as vl_total " + &
					 "from contas_receber_saldo s " + &
					 "inner join cliente c "+ &
					 	"on c.cd_cliente = s.cd_conta " + &
					 "where s.id_tipo_conta = '" + as_Tipo + "' " 
					 
		
	Case "FO"
		lvs_SQL = "select s.cd_conta, '' as cd_cliente_sap, s.id_tipo_conta, f.nm_fantasia nm_conta, " + &
					 "s.vl_vendas, s.vl_titulos, s.vl_outros, coalesce(s.vl_vendas, 0) + coalesce(s.vl_titulos, 0) - coalesce(s.vl_outros, 0) as vl_total " + &
					 "from contas_receber_saldo s, fornecedor f " + &
					 "where s.id_tipo_conta = 'FO' " + &
					 "and f.cd_fornecedor = s.cd_conta"
		
	Case "LP"
		lvs_SQL = "select s.cd_conta,  isf.cd_chave_sap as cd_cliente_sap, s.id_tipo_conta, f.nm_fantasia nm_conta, " + &
					 "s.vl_vendas, s.vl_titulos, s.vl_outros, coalesce(s.vl_vendas, 0) + coalesce(s.vl_titulos, 0) - coalesce(s.vl_outros, 0) as vl_total " + &
					 "from contas_receber_saldo s "+ &
					 "inner join filial f on f.cd_filial = convert(integer, s.cd_conta)" + &
					 "inner join integracao_sap isf on isf.cd_tabela = 'FILIAL' and isf.cd_chave_legado = s.cd_conta " + &
					 "where s.id_tipo_conta = 'LP' "
End Choose

//Se for tipo CR, VB ou PT ent$$HEX1$$e300$$ENDHEX$$o verifica se o saldo $$HEX1$$e900$$ENDHEX$$ data futura (normalmente $$HEX1$$e900$$ENDHEX$$ menor ou igual)
If lvdt_Saldo_Limite > adt_data_saldo and (as_Tipo = "CR" or as_Tipo = "PT" or as_Tipo = "VB") Then
	lvs_SQL += " and s.dh_conta = ( SELECT max(s2.dh_conta) FROM contas_receber_saldo s2 "+ &
											" WHERE s2.dh_conta between '" + String(adt_Data_Saldo, "yyyy/mm/dd") + "'" + &
												" AND '"+String(lvdt_Saldo_Limite, "yyyy/mm/dd") + "'" + &
												IIF(as_conta<>"", "AND s2.cd_conta = '"+as_conta+"' "," AND s2.cd_conta = s.cd_conta ") + &
												" AND s2.id_tipo_conta = s.id_tipo_conta)"
Else
	lvs_SQL += " and s.dh_conta = '" + String(adt_Data_Saldo, "yyyy/mm/dd") + "'"
End If

If as_conta <> '' Then
	lvs_SQL += " and s.cd_conta='" + as_conta + "'"
End If

If Trim(as_SQL) <> "" Then as_SQL += " union "

as_SQL += lvs_SQL
end subroutine

on w_ge638_posicao_contas_receber.create
call super::create
end on

on w_ge638_posicao_contas_receber.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;ivm_Menu.ivb_Permite_Imprimir = True

If Not wf_Verifica_Datas() Then
	Close(This)
End If

ivo_Convenio 	= Create uo_Convenio
ivo_Cliente 		= Create uo_Cliente
ivo_Fornecedor	= Create uo_Fornecedor
end event

event ue_saveas;dw_3.Event ue_SaveAs()
end event

event ue_preopen;call super::ue_preopen;//Tamanho ideal da tela para exibi$$HEX2$$e700e300$$ENDHEX$$o sem necessidade de Scroll
MaxWidth	= 4425

//Tamanho ideal da tela para exibi$$HEX2$$e700e300$$ENDHEX$$o sem necessidade de Scroll
//Neste caso como s$$HEX1$$e300$$ENDHEX$$o muitos registros o sistema ajusta ao m$$HEX1$$e100$$ENDHEX$$ximo poss$$HEX1$$ed00$$ENDHEX$$vel da tela
MaxHeight	= 9999
end event

event close;call super::close;Destroy(ivo_Convenio)
Destroy(ivo_Cliente)
Destroy(ivo_Fornecedor)
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge638_posicao_contas_receber
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge638_posicao_contas_receber
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge638_posicao_contas_receber
integer x = 18
integer y = 416
integer width = 4370
integer height = 1796
string text = "Posi$$HEX2$$e700e300$$ENDHEX$$o das Contas"
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge638_posicao_contas_receber
integer x = 18
integer y = 4
integer width = 4014
integer height = 384
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge638_posicao_contas_receber
integer x = 37
integer y = 56
integer width = 3982
integer height = 312
string dataobject = "dw_ge638_selecao"
end type

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)
end event

event dw_1::itemchanged;call super::itemchanged;String	lvs_Nulo

SetNull(lvs_Nulo)

Choose Case Dwo.Name		
	Case "ds_conta"
					
		If This.Object.Id_CV[1] = 'S' Then
			If Trim(Data) <> "" Then
				If Data <> ivo_Convenio.nm_Fantasia Then
					Return 1
				End If	
			Else			
				SetNull(ivo_Convenio.Cd_Convenio)
				ivo_Convenio.Nm_Fantasia = ""
				
				This.Object.Cd_Conta[1] = String(ivo_Convenio.Cd_Convenio)
				This.Object.Ds_Conta[1] = ivo_Convenio.Nm_Fantasia			
			End If
		End If
		
		If This.Object.Id_CC[1] = 'S' or This.Object.Id_CR[1] = 'S' Then
			If Trim(Data) <> "" Then
				If Data <> ivo_Cliente.Nm_Cliente Then
					Return 1
				End If	
			Else			
				SetNull(ivo_Cliente.Cd_Cliente)
				ivo_Cliente.Nm_Cliente = ""
				
				This.Object.Cd_Conta[1] = ivo_Cliente.Cd_Cliente
				This.Object.Ds_Conta[1] = ivo_Cliente.Nm_Cliente
			End If
		End If
		
		If This.Object.Id_FO[1] = 'S' Then
			If Trim(Data) <> "" Then
				If Data <> ivo_Fornecedor.nm_Razao_Social Then
					Return 1
				End If
			Else
				This.Object.Cd_Conta[1] = lvs_Nulo
				ivo_Fornecedor.Nm_Razao_Social = ""

				This.Object.Cd_Conta[1] = lvs_Nulo
				This.Object.Ds_Conta[1] = ivo_Fornecedor.Nm_Razao_Social
			End If
		End If
End Choose
end event

event dw_1::losefocus;call super::losefocus;//If This.Object.Id_CV[1] = 'S' Then
//	If IsValid(ivo_Convenio) Then	
//		This.Object.Cd_Conta[1] = String(ivo_Convenio.Cd_Convenio)
//		This.Object.Ds_Conta[1] = ivo_Convenio.Nm_Fantasia	
//	End If	
//End If
//
//If This.Object.Id_CR[1] = 'S' or This.Object.Id_CC[1] = 'S' Then
//	If IsValid(ivo_Cliente) Then	
//		This.Object.Cd_Conta[1] = ivo_Cliente.Cd_Cliente
//		This.Object.Ds_Conta[1] = ivo_Cliente.Nm_Cliente
//	End If	
//End If
//
//If This.Object.Id_FO[1] = 'S' Then
//	If IsValid(ivo_Fornecedor) Then
//		This.Object.Cd_Conta[1] = ivo_Fornecedor.Cd_Fornecedor
//		This.Object.Ds_Conta[1] = ivo_Fornecedor.Nm_Razao_Social
//	End If	
//End If
end event

event dw_1::ue_key;call super::ue_key;Boolean	lvb_Selecionado = False

String		lvs_Coluna, &
			lvs_Conta

lvs_Coluna = This.GetColumnName()

lvs_Conta = This.GetText()

If ( lvs_Coluna = "ds_conta" ) Then 
	
	If ( key = KeyEnter! ) Then
		
		// CV
		If This.Object.Id_CV[1] = 'S' Then		
			If Not IsNull(lvs_Conta) and TRIM(lvs_Conta) <> "" Then 
			
				ivo_Convenio.Of_Localiza_Convenio(lvs_Conta)
				
				If ( ivo_Convenio.Localizado ) Then
					This.Object.Cd_Conta[1] = String(ivo_Convenio.Cd_Convenio)
					This.Object.Ds_Conta[1] = ivo_Convenio.Nm_Fantasia
				End If
			End If
					
			lvb_Selecionado = True
		End If
		
		// CC
		If This.Object.Id_CC[1] = 'S' and Not lvb_Selecionado Then
			ivo_Cliente.ivs_Tipo_Cliente = "CC"
			
			ivo_Cliente.of_Localiza_CLiente(lvs_Conta)
			
			If ivo_Cliente.Localizado Then			
				dw_1.Object.Cd_Conta[1] = ivo_Cliente.Cd_Cliente
				dw_1.Object.Ds_Conta[1] = ivo_Cliente.Nm_Cliente	
			End If

			lvb_Selecionado = True					
		End If			
		
		// CR
		If This.Object.Id_CR[1] = 'S' and Not lvb_Selecionado Then
			ivo_Cliente.ivs_Tipo_Cliente = "CR"
			
			ivo_Cliente.of_Localiza_Cliente(lvs_Conta)
			
			If ivo_Cliente.Localizado Then			
				dw_1.Object.Cd_Conta[1] = ivo_Cliente.Cd_Cliente
				dw_1.Object.Ds_Conta[1] = ivo_Cliente.Nm_Cliente	
			End If
			
			lvb_Selecionado = True					
		End If			
		
		// FO
		If This.Object.Id_FO[1] = 'S' and Not lvb_Selecionado Then
			ivo_Fornecedor.of_Localiza_Fornecedor(lvs_Conta)
			
			If ivo_Fornecedor.Localizado Then
				dw_1.Object.Cd_Conta[1] = ivo_Fornecedor.Cd_Fornecedor
				dw_1.Object.Ds_Conta[1] = ivo_Fornecedor.Nm_Razao_Social
			End If			
		End If
	End If
End If
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge638_posicao_contas_receber
integer x = 46
integer y = 480
integer width = 4338
integer height = 1712
string dataobject = "dw_ge638_lista"
end type

event dw_2::ue_postretrieve;call super::ue_postretrieve;This.ivm_Menu.mf_SalvarComo(pl_linhas > 0)

Return pl_Linhas
end event

event dw_2::constructor;call super::constructor;String lvs_Coluna[], &
       lvs_Nome[], &
       lvs_Protect[]
		 
lvs_Coluna = {"id_tipo_conta", "cd_conta", "nm_conta", "vl_vendas", "vl_titulos", "vl_outros", "vl_total"}

lvs_Nome = {"Tipo Conta", "Cod. Conta",  "Nome Conta", "Valor Vendas", "Valor T$$HEX1$$ed00$$ENDHEX$$tulos", "Valor Outros", "Valor Total"}
lvs_Protect = {"S", "N", "N", "N", "N", "N", "N"}

This.of_SetSort(lvs_Coluna, lvs_Nome, lvs_Protect)
This.of_SetFilter(lvs_Coluna, lvs_Nome)
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;String 	lvs_CV, &
       	lvs_CC, &
		 	lvs_CR, &
		 	lvs_FO, &
		 	lvs_LP, &
		 	lvs_PT, &
		 	lvs_VB, &
		 	lvs_SQL, &
			lvs_Cd_Conta, &
			lvs_Considera_PBM

Date 	lvdt_Limite

Long lvl_Total_Where = 0
Long lvl_Where

dw_1.AcceptText()

lvdt_Limite 		= dw_1.Object.Dt_Limite				[1]
lvs_CV     		 	= dw_1.Object.Id_CV					[1]
lvs_CC      		= dw_1.Object.Id_CC					[1]
lvs_CR      		= dw_1.Object.Id_CR					[1]
lvs_FO      		= dw_1.Object.Id_FO					[1]
lvs_LP      		= dw_1.Object.Id_LP					[1]
lvs_PT      		= dw_1.Object.Id_PT					[1]
lvs_VB      		= dw_1.Object.Id_VB					[1]
lvs_Cd_Conta		= dw_1.Object.Cd_Conta				[1]
lvs_Considera_PBM	= dw_1.Object.id_considerar_pbm	[1]

If IsNull(lvdt_Limite) or Not IsDate(String(lvdt_Limite, "dd/mm/yyyy")) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Informe a data limite corretamente.", Exclamation!)
	dw_1.Event ue_Pos(1, "dt_limite")
	Return -1
End If

If lvs_CV = "N" and lvs_CC = "N" and lvs_CR = "N" and lvs_FO = "N" and lvs_LP = "N" and lvs_PT = "N" and lvs_VB = "N" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Selecione pelo menos um tipo de conta.", Exclamation!)
	dw_1.Event ue_Pos(1, "id_cv")
	Return -1
End If

/*
  Se a data limite for maior ou igual a data de movimenta$$HEX2$$e700e300$$ENDHEX$$o atual,
  recupera os saldos do m$$HEX1$$ea00$$ENDHEX$$s de fechamento, sen$$HEX1$$e300$$ENDHEX$$o
  se a data limite for o $$HEX1$$fa00$$ENDHEX$$ltimo dia do m$$HEX1$$ea00$$ENDHEX$$s, recupera o saldo do m$$HEX1$$ea00$$ENDHEX$$s da data limite,
  sen$$HEX1$$e300$$ENDHEX$$o recupera os saldos do m$$HEX1$$ea00$$ENDHEX$$s anterior a data limite e processa os movimentos
*/

If (lvdt_Limite >= ivdt_Movimentacao) Then
	ivdt_Saldo = ivdt_Fechamento
	
	ivb_Verificar_Movimentos = False
Else
	If gf_Ultimo_Dia_Mes(lvdt_Limite) Then
		ivdt_Saldo = Date("01/" + String(lvdt_Limite, "mm/yyyy"))
	
		ivb_Verificar_Movimentos = False
	Else
		ivdt_Saldo = Date("01/" + String(lvdt_Limite, "mm/yyyy"))
		ivdt_Saldo = Date("01/" + String(RelativeDate(ivdt_Saldo, -1), "mm/yyyy"))
	
		ivb_Verificar_Movimentos = True
	End If
End If

ivs_Tipo_Movimento = ""

If lvs_CV = "S" Then	
	wf_Prepara_SQL(ref lvs_SQL, "CV", lvs_Cd_Conta, ivdt_Saldo, lvdt_Limite)
	lvl_Total_Where ++
End If

If lvs_CC = "S" Then	
	wf_Prepara_SQL(ref lvs_SQL, "CC", lvs_Cd_Conta, ivdt_Saldo, lvdt_Limite)
	lvl_Total_Where ++
End If 

If lvs_CR = "S" Then	
	wf_Prepara_SQL(ref lvs_SQL, "CR", lvs_Cd_Conta, ivdt_Saldo, lvdt_Limite)
	lvl_Total_Where ++
ElseIf lvs_PT	= "S" Then	
	wf_Prepara_SQL(ref lvs_SQL, "PT", lvs_Cd_Conta, ivdt_Saldo, lvdt_Limite)
	lvl_Total_Where ++ 
ElseIf lvs_VB	= "S" Then	
	wf_Prepara_SQL(ref lvs_SQL, "VB", lvs_Cd_Conta, ivdt_Saldo, lvdt_Limite)
	lvl_Total_Where ++ 
End If 
	
If lvs_FO = "S" Then	
	wf_Prepara_SQL(ref lvs_SQL, "FO", lvs_Cd_Conta, ivdt_Saldo, lvdt_Limite)
	lvl_Total_Where ++
End If 
	
If lvs_LP	= "S" Then	
	wf_Prepara_SQL(ref lvs_SQL, "LP", lvs_Cd_Conta, ivdt_Saldo, lvdt_Limite)
	lvl_Total_Where ++
End If 

This.of_ChangeSQL(lvs_SQL)

//If Not IsNull(lvs_Cd_Conta) and lvs_Cd_Conta <> '' Then
//	For lvl_Where = 1 To lvl_Total_Where
//		This.of_AppendWhere("s.cd_conta='" + lvs_Cd_Conta + "'", lvl_Where)
//	Next
//End If
//
If lvs_Considera_PBM = "N" Then
	If lvs_CV = "S" Then	
		This.of_AppendWhere("s.cd_conta not in ('52575', '53724', '53725', '52349' ,'52718','53847')", 1)
	End If
End If

Return 1
end event

event dw_2::ue_recuperar;//override
Long lvl_Linhas
String lvs_Oculta_Zerados

Try

	This.SetRedraw(False)
	
	This.SetFilter("")
	This.Filter()
	lvl_Linhas = This.Retrieve()
	
	If lvl_Linhas > 0 Then	
		If ivb_verificar_movimentos Then wf_atualiza_movimento( )
	End If
	
	If dw_1.Object.Id_CR [1] = 'S' or dw_1.Object.Id_PT [1] = 'S' Then
		wf_atualiza_saldo_patrimonio( )
	End If
	
	If dw_1.Object.Id_CR [1] = 'S' or dw_1.Object.Id_VB [1] = 'S' Then
		wf_atualiza_saldo_verba( )
	End If
	
	dw_1.accepttext( )
	lvs_Oculta_Zerados	= dw_1.Object.id_ocultar_zerados		[1]
	If lvs_Oculta_Zerados = "S" Then
		This.SetFilter("(vl_vendas <> 0) or (vl_titulos <> 0) or (vl_outros <> 0)")
	Else
		This.SetFilter("")
	End If
	This.Filter()
	
	This.Sort()
	This.GroupCalc()

Finally
	This.SetRedraw(True)	
End Try

Return This.RowCount()
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge638_posicao_contas_receber
integer x = 4078
integer y = 96
integer width = 411
integer height = 184
string dataobject = "dw_ge638_relatorio"
end type

event dw_3::ue_preprint;call super::ue_preprint;Date lvdt_Limite

String lvs_Data

lvdt_Limite = dw_1.Object.Dt_Limite[1]

lvs_Data = "At$$HEX1$$e900$$ENDHEX$$ a Data: " + String(lvdt_Limite, "dd/mm/yyyy")

dw_3.Object.t_Data_Cabecalho.Text = lvs_Data

dw_3.GroupCalc()

Return dw_3.RowCount()
end event

