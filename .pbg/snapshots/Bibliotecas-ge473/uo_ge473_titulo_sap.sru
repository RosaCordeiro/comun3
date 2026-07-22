HA$PBExportHeader$uo_ge473_titulo_sap.sru
forward
global type uo_ge473_titulo_sap from nonvisualobject
end type
end forward

global type uo_ge473_titulo_sap from nonvisualobject
end type
global uo_ge473_titulo_sap uo_ge473_titulo_sap

type variables
/* Tabela SAP => BKPF - Cabe$$HEX1$$e700$$ENDHEX$$alho Documento */
String ivs_mandt		/* Mandante */
String ivs_bukrs		/* Empresa */
String ivs_belnr		/* N$$HEX1$$ba00$$ENDHEX$$ Documento Cont$$HEX1$$e100$$ENDHEX$$bil */
String ivs_gjahr		/* Ano */
String ivs_blart		/* Tipo Documento Cont$$HEX1$$e100$$ENDHEX$$bil */
String ivs_bldat		/* Data do Documento (emiss$$HEX1$$e300$$ENDHEX$$o) */
String ivs_budat		/* Data do Lan$$HEX1$$e700$$ENDHEX$$amento (entrada) */
String ivs_cpudt		/* Data de Entrada (digita$$HEX2$$e700e300$$ENDHEX$$o) */
String ivs_cputm		/* Hora de Entrada (digita$$HEX2$$e700e300$$ENDHEX$$o) */
String ivs_xblnr		/* N$$HEX1$$ba00$$ENDHEX$$ Refer$$HEX1$$ea00$$ENDHEX$$ncia do Documento */
String ivs_bktxt		/* Texto do Cabe$$HEX1$$e700$$ENDHEX$$alho Documento */
String ivs_xref1_hd	/* Chave Refer$$HEX1$$ea00$$ENDHEX$$ncia 1 - Cabe$$HEX1$$e700$$ENDHEX$$alho */
String ivs_xref2_hd	/* Chave Refer$$HEX1$$ea00$$ENDHEX$$ncia 2 - Cabe$$HEX1$$e700$$ENDHEX$$alho */
String ivs_waers		/* Moeda */
String ivs_awtyp		/* Opera$$HEX2$$e700e300$$ENDHEX$$o Refer$$HEX1$$ea00$$ENDHEX$$ncia (processo SAP que criou o docto) */
String ivs_usnam		/* Usu$$HEX1$$e100$$ENDHEX$$rio (criador) */
String ivs_tcode		/* Transa$$HEX2$$e700e300$$ENDHEX$$o (que criou o docto) */
String ivs_aworg_rev	/* Empresa + Ano - Documento Estornado */
String ivs_awref_rev	/* N$$HEX1$$ba00$$ENDHEX$$ Documento Cont$$HEX1$$e100$$ENDHEX$$bil - Documento Estornado */
String ivs_xreversing/* $$HEX1$$c900$$ENDHEX$$ um documento de estorno? */

/* Tabela SAP => BSEG - Item Documento */
String ivs_buzei		/* N$$HEX1$$ba00$$ENDHEX$$ Item do Documento (Sequencial dentro do documento cont$$HEX1$$e100$$ENDHEX$$bil) */
String ivs_gsber		/* Divis$$HEX1$$e300$$ENDHEX$$o (Filial SAP) */
String ivs_zuonr		/* Atribui$$HEX2$$e700e300$$ENDHEX$$o */
String ivs_sgtxt		/* Texto do Item */
String ivs_xref1		/* Chave Refer$$HEX1$$ea00$$ENDHEX$$ncia 1 */
String ivs_xref2		/* Chave Refer$$HEX1$$ea00$$ENDHEX$$ncia 2 */
String ivs_xref3		/* Chave Refer$$HEX1$$ea00$$ENDHEX$$ncia 3 */
String ivs_kidno		/* Refer$$HEX1$$ea00$$ENDHEX$$ncia Pagamento */
String ivs_zfbdt		/* Data Base Vencimento */
String ivs_zterm		/* Condi$$HEX2$$e700e300$$ENDHEX$$o de Pagamento */
String ivs_zlsch		/* Forma de Pagamento */
String ivs_netdt		/* Data Vencimento */
String ivs_hkont		/* Conta Raz$$HEX1$$e300$$ENDHEX$$o (conta cont$$HEX1$$e100$$ENDHEX$$bil SAP) */
String ivs_kunnr		/* Cliente (somente em t$$HEX1$$ed00$$ENDHEX$$tulos a receber ou antecipa$$HEX2$$e700f500$$ENDHEX$$es) */
String ivs_lifnr		/* Fornecedor (somente em t$$HEX1$$ed00$$ENDHEX$$tulos a pagar ou cr$$HEX1$$e900$$ENDHEX$$dito) */
String ivs_umskz		/* C$$HEX1$$f300$$ENDHEX$$d. Raz$$HEX1$$e300$$ENDHEX$$o Especial */
String ivs_kostl		/* Centro de Custo */
String ivs_prctr		/* Centro de Lucro */
String ivs_hbkid		/* Banco Empresa */
String ivs_anfbn		/* Solita$$HEX2$$e700e300$$ENDHEX$$o LC (envio remessa banco) */
String ivs_wrbtr		/* Montante em Moeda do Documento */
String ivs_nebtr		/* Montante L$$HEX1$$ed00$$ENDHEX$$quido do Documento */
String ivs_ebeln		/* N$$HEX1$$ba00$$ENDHEX$$ Documento Compras */
String ivs_ebelp		/* N$$HEX1$$ba00$$ENDHEX$$ Item Documento Compras */
String ivs_matnr		/* N$$HEX1$$ba00$$ENDHEX$$ Material (c$$HEX1$$f300$$ENDHEX$$digo de produto SAP) */
String ivs_anln1		/* N$$HEX1$$ba00$$ENDHEX$$ Ativo Imobilizado (c$$HEX1$$f300$$ENDHEX$$digo do ativo SAP) */
String ivs_anln2		/* Subn$$HEX1$$fa00$$ENDHEX$$mero Ativo Imobilizado (p/ bens vinculados, subitens) */
String ivs_vbeln		/* Documento Faturamento */
String ivs_vbel2		/* Documento Vendas */
String ivs_posn2		/* Item Documento Vendas */

/* Campos utilizados na interface */
String 	ivs_de_chave_acesso_sap
String 	ivs_NR_Titulo
Long 		ivl_Filial
DateTime	ivdh_Movimento
DateTime	ivdh_Emissao
DateTime	ivdh_Sistema
DateTime	ivdh_Vencto
String 	ivs_CD_Cliente
String 	ivs_NR_Usuario
Long 		ivl_CD_Portador
Decimal 	ivdc_VL_Nominal
Long 		ivl_NR_Nf
String	ivs_DE_Serie
String	ivs_DE_Especie

Private:
Long ivl_Tabela = 157

dc_uo_ds_base ivds_de_para

uo_Titulo 		ivo_Titulo
uo_ge473_comum	ivo_Comum
end variables

forward prototypes
private function boolean of_inicializa_variaveis (ref string as_log)
public subroutine of_processa_atualizacao ()
public function boolean of_processa_titulo (long al_controle, long al_tabela)
public function boolean of_de_para_usuario (readonly string as_usuario_sap, ref string as_usuario, ref string as_log)
public function boolean of_date_time_ex (string as_valor, string as_coluna, ref datetime adh_valor, ref string as_log)
public function boolean of_insere_movimento_titulo (string ps_titulo, integer pi_nr_movimento, integer pi_tipo_movimento, string ps_responsavel, datetime pdt_sistema, datetime pdt_movimento, decimal pdc_movimento, string ps_historico, long pl_filial, ref string ps_log)
public function boolean of_valida_situacao_estorno_titulo (readonly string as_nr_documento_sap, long al_filial, long al_portador, string as_cliente, string as_tipo, long al_nr_nf, string as_serie, datetime adt_vencimento, ref string as_nr_titulo, ref string as_log, ref boolean ab_estornado)
public function boolean of_de_para_portador (readonly string as_banco_empresa, ref long al_portador, ref string as_log)
public function boolean of_de_para_filial (readonly string as_divisao, ref long al_filial, ref string as_log)
private function boolean of_insere_de_para (string as_tabela, string as_chave_sap, string as_chave_legado, ref string as_log)
private function boolean of_retorna_valor_de_para (string as_tabela, string as_chave_sap, ref string as_chave_legado, ref string as_log)
public function boolean of_insere_titulo (long al_controle_interface, string ps_titulo, long pl_filial, string ps_tipo_titulo, integer pi_portador, datetime pdt_emissao, datetime pdt_vencimento, decimal pdc_nominal, long pl_empresa_docto_sap, string ps_nr_docto_sap, long pl_ano_docto_sap, integer pl_item_docto_sap, string ps_cliente, long pl_nr_nf, string ps_serie, string ps_de_referencia_sap, string ps_nr_referencia, string ps_de_atribuicao, string ps_de_chave_ref_1, string ps_de_chave_ref_2, string ps_de_chave_ref_3, string ps_nr_referencia_pagto, string ps_cd_condicao_pagto, string ps_cd_forma_pagto, string ps_de_solicitacao_lc, string ps_nr_conta_sap, string ps_nr_docto_faturamento, ref string ps_log)
public function boolean of_valida_situacao_titulo (long al_empresa_sap, readonly string as_nr_documento_sap, long al_nr_ano_sap, long al_nr_item, long al_filial, long al_portador, string as_cliente, string as_tipo, long al_nr_nf, string as_serie, datetime adt_vencimento, ref string as_log)
public function boolean of_de_para_cliente (readonly string as_cliente_sap, boolean ab_fornecedor, ref string as_cliente, ref string as_log)
public function boolean of_expandir_fornecedor_para_cliente (readonly string as_fornecedor_sap, readonly string as_cliente_sap, ref string as_cliente_sybase, ref string as_log)
end prototypes

private function boolean of_inicializa_variaveis (ref string as_log);Try
	//Cria dataset para armazenar DE/PARA conhecidos, para n$$HEX1$$e300$$ENDHEX$$o buscar 2x o mesmo registro no banco
	If Not IsValid(ivds_de_para) Then
		ivds_de_para = Create dc_uo_ds_base
		If Not ivds_de_para.Of_ChangeDataObject("ds_ge473_de_para", False) Then
			as_log = This.ClassName()+".of_Inicializa_Variaveis(): Falha ao mudar para datasource ds_ge473_de_para."
			Return False
		End If
	End If
	
	SetNull(ivs_de_chave_acesso_sap)
	
	SetNull(ivs_mandt)		/* Mandante */
	SetNull(ivs_bukrs)		/* Empresa */
	SetNull(ivs_belnr)		/* N$$HEX1$$ba00$$ENDHEX$$ Documento Cont$$HEX1$$e100$$ENDHEX$$bil */
	SetNull(ivs_gjahr)		/* Ano */
	SetNull(ivs_blart)		/* Tipo Documento Cont$$HEX1$$e100$$ENDHEX$$bil */
	SetNull(ivs_bldat)		/* Data do Documento (emiss$$HEX1$$e300$$ENDHEX$$o) */
	SetNull(ivs_budat)		/* Data do Lan$$HEX1$$e700$$ENDHEX$$amento (entrada) */
	SetNull(ivs_cpudt)		/* Data de Entrada (digita$$HEX2$$e700e300$$ENDHEX$$o) */
	SetNull(ivs_cputm)		/* Hora de Entrada (digita$$HEX2$$e700e300$$ENDHEX$$o) */
	SetNull(ivs_xblnr)		/* N$$HEX1$$ba00$$ENDHEX$$ Refer$$HEX1$$ea00$$ENDHEX$$ncia do Documento */
	SetNull(ivs_bktxt)		/* Texto do Cabe$$HEX1$$e700$$ENDHEX$$alho Documento */
	SetNull(ivs_xref1_hd)	/* Chave Refer$$HEX1$$ea00$$ENDHEX$$ncia 1 - Cabe$$HEX1$$e700$$ENDHEX$$alho */
	SetNull(ivs_xref2_hd)	/* Chave Refer$$HEX1$$ea00$$ENDHEX$$ncia 2 - Cabe$$HEX1$$e700$$ENDHEX$$alho */
	SetNull(ivs_waers)		/* Moeda */
	SetNull(ivs_awtyp)		/* Opera$$HEX2$$e700e300$$ENDHEX$$o Refer$$HEX1$$ea00$$ENDHEX$$ncia (processo SAP que criou o docto) */
	SetNull(ivs_usnam)		/* Usu$$HEX1$$e100$$ENDHEX$$rio (criador) */
	SetNull(ivs_tcode)		/* Transa$$HEX2$$e700e300$$ENDHEX$$o (que criou o docto) */
	SetNull(ivs_aworg_rev)	/* Empresa + Ano - Documento Estornado */
	SetNull(ivs_awref_rev)	/* N$$HEX1$$ba00$$ENDHEX$$ Documento Cont$$HEX1$$e100$$ENDHEX$$bil - Documento Estornado */
	SetNull(ivs_xreversing)	/* $$HEX1$$c900$$ENDHEX$$ um documento de estorno? */

	/* Tabela SAP => BSEG - Item Documento */
	SetNull(ivs_buzei)		/* N$$HEX1$$ba00$$ENDHEX$$ Item do Documento (Sequencial dentro do documento cont$$HEX1$$e100$$ENDHEX$$bil) */
	SetNull(ivs_gsber)		/* Divis$$HEX1$$e300$$ENDHEX$$o (Filial SAP) */
	SetNull(ivs_zuonr)		/* Atribui$$HEX2$$e700e300$$ENDHEX$$o */
	SetNull(ivs_sgtxt)		/* Texto do Item */
	SetNull(ivs_xref1)		/* Chave Refer$$HEX1$$ea00$$ENDHEX$$ncia 1 */
	SetNull(ivs_xref2)		/* Chave Refer$$HEX1$$ea00$$ENDHEX$$ncia 2 */
	SetNull(ivs_xref3)		/* Chave Refer$$HEX1$$ea00$$ENDHEX$$ncia 3 */
	SetNull(ivs_kidno)		/* Refer$$HEX1$$ea00$$ENDHEX$$ncia Pagamento */
	SetNull(ivs_zfbdt)		/* Data Base Vencimento */
	SetNull(ivs_zterm)		/* Condi$$HEX2$$e700e300$$ENDHEX$$o de Pagamento */
	SetNull(ivs_zlsch)		/* Forma de Pagamento */
	SetNull(ivs_netdt)		/* Data Vencimento */
	SetNull(ivs_hkont)		/* Conta Raz$$HEX1$$e300$$ENDHEX$$o (conta cont$$HEX1$$e100$$ENDHEX$$bil SAP) */
	SetNull(ivs_kunnr)		/* Cliente (somente em t$$HEX1$$ed00$$ENDHEX$$tulos a receber ou antecipa$$HEX2$$e700f500$$ENDHEX$$es) */
	SetNull(ivs_lifnr)		/* Fornecedor (somente em t$$HEX1$$ed00$$ENDHEX$$tulos a pagar ou cr$$HEX1$$e900$$ENDHEX$$dito) */
	SetNull(ivs_umskz)		/* C$$HEX1$$f300$$ENDHEX$$d. Raz$$HEX1$$e300$$ENDHEX$$o Especial */
	SetNull(ivs_kostl)		/* Centro de Custo */
	SetNull(ivs_prctr)		/* Centro de Lucro */
	SetNull(ivs_hbkid)		/* Banco Empresa */
	SetNull(ivs_anfbn)		/* Solita$$HEX2$$e700e300$$ENDHEX$$o LC (envio remessa banco) */
	SetNull(ivs_wrbtr)		/* Montante em Moeda do Documento */
	SetNull(ivs_nebtr)		/* Montante L$$HEX1$$ed00$$ENDHEX$$quido do Documento */
	SetNull(ivs_ebeln)		/* N$$HEX1$$ba00$$ENDHEX$$ Documento Compras */
	SetNull(ivs_ebelp)		/* N$$HEX1$$ba00$$ENDHEX$$ Item Documento Compras */
	SetNull(ivs_matnr)		/* N$$HEX1$$ba00$$ENDHEX$$ Material (c$$HEX1$$f300$$ENDHEX$$digo de produto SAP) */
	SetNull(ivs_anln1)		/* N$$HEX1$$ba00$$ENDHEX$$ Ativo Imobilizado (c$$HEX1$$f300$$ENDHEX$$digo do ativo SAP) */
	SetNull(ivs_anln2)		/* Subn$$HEX1$$fa00$$ENDHEX$$mero Ativo Imobilizado (p/ bens vinculados, subitens) */
	SetNull(ivs_vbeln)		/* Documento Faturamento */
	SetNull(ivs_vbel2)		/* Documento Vendas */
	SetNull(ivs_posn2)		/* Item Documento Vendas */
	
	ivl_Tabela = 157

Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro ao iniciar as variaveis. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try

Return True
end function

public subroutine of_processa_atualizacao ();Long ll_Linhas
Long ll_Linha, ll_nr_controle, ll_controles_gerando
String lvs_Log

dc_uo_ds_base lvds_1

Try 
	lvds_1  = Create dc_uo_ds_base
	
	If Not lvds_1.of_ChangeDataObject('ds_ge473_lista_controles', False) Then 
		gvo_aplicacao.of_grava_log("Interface Titulo SAP - Erro alterar a DW [ds_ge473_lista_controles] - uo_ge473_titulo_sap.of_processa_atualizacao" )
		Return
	End If
	
	ll_Linhas = lvds_1.Retrieve(ivl_Tabela)
	
	If ll_Linhas > 0 Then
		For ll_Linha = 1 To ll_Linhas
			This.of_Processa_Titulo( lvds_1.Object.nr_controle[ll_Linha], This.ivl_tabela )	
		Next
	ElseIf ll_Linhas < 0 Then
		gvo_aplicacao.of_grava_log("Interface Titulo SAP - Erro ao recuperar os da DW [ds_ge473_lista_controles] - uo_ge473_titulo_sap.of_processa_atualizacao.")
	End If	
	
Finally
	If IsValid(lvds_1) Then Destroy(lvds_1)
End try
end subroutine

public function boolean of_processa_titulo (long al_controle, long al_tabela);Boolean lvb_Sucesso = False, lvb_Estornado = False

Long lvl_Atualizacao_Pend
Long lvl_Linhas
Long lvl_Linha
Long lvl_Movto_Estorno

String lvs_Log
String lvs_Log_Compl
String lvs_Chave_Controle
String lvs_Valor

Integer lvi_Movto_Abertura

Try
	If Not IsValid(ivo_Comum) Then ivo_Comum = Create uo_ge473_comum
	
	Select de_chave_sap
	Into :ivs_de_chave_acesso_sap
	From interface_sap  i 
	Where i.cd_tabela = 157
		and i.nr_controle = :al_controle
	Using SQLCa;	
	
	If SQLCa.SQLCode = -1 Then
		lvs_Log	= "Erro ao buscar o controle na tabela interface_sap. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle)+". Erro: "+SQLCa.SQLErrText
		Return False
	End If	
	
	If Not This.of_Inicializa_Variaveis(Ref lvs_Log) Then Return False
	
	If Not ivo_Comum.of_Atualizacao_Pendente(al_Controle, Ref lvl_Atualizacao_Pend, Ref lvs_Log) Then Return False
	
	//Controle j$$HEX1$$e100$$ENDHEX$$ foi processado
	If lvl_Atualizacao_Pend = 0 Then Return True
	
	If Not ivo_Comum.of_Muda_Situacao_Interface(al_Controle, Ref lvs_Log) Then Return False
	If Not ivo_Comum.of_localiza_chave_controle(al_Controle, Ref lvs_Chave_Controle, Ref lvs_Log) Then Return False
	
	If ivo_Comum.of_Processa_Carrega_Dados(al_controle , ref lvs_Log) Then
		
		lvl_Linhas = ivo_Comum.ids_lista_registros.RowCount()
		
		if isValid(w_aguarde_3) Then
			w_aguarde_3.uo_progress_2.of_Reset()
			w_aguarde_3.uo_progress_2.of_SetMax(lvl_linhas)
		end if
		
		For lvl_Linha = 1 To lvl_Linhas
			/* Tabela SAP => BKPF - Cabe$$HEX1$$e700$$ENDHEX$$alho Documento */
			ivs_mandt 		= Trim(ivo_Comum.ids_lista_registros.Object.mandt		[lvl_Linha])	/* Mandante */
			ivs_bukrs 		= Trim(ivo_Comum.ids_lista_registros.Object.bukrs		[lvl_Linha])	/* Empresa */
			ivs_belnr 		= Trim(ivo_Comum.ids_lista_registros.Object.belnr		[lvl_Linha])	/* N$$HEX1$$ba00$$ENDHEX$$ Documento Cont$$HEX1$$e100$$ENDHEX$$bil */
			ivs_gjahr 		= Trim(ivo_Comum.ids_lista_registros.Object.gjahr		[lvl_Linha])	/* Ano */
			ivs_blart 		= Trim(ivo_Comum.ids_lista_registros.Object.blart		[lvl_Linha])	/* Tipo Documento Cont$$HEX1$$e100$$ENDHEX$$bil */
			ivs_bldat 		= Trim(ivo_Comum.ids_lista_registros.Object.bldat		[lvl_Linha])	/* Data do Documento (emiss$$HEX1$$e300$$ENDHEX$$o) */
			ivs_budat 		= Trim(ivo_Comum.ids_lista_registros.Object.budat		[lvl_Linha])	/* Data do Lan$$HEX1$$e700$$ENDHEX$$amento (entrada) */
			ivs_cpudt		= Trim(ivo_Comum.ids_lista_registros.Object.cpudt		[lvl_Linha])	/* Data de Entrada (digita$$HEX2$$e700e300$$ENDHEX$$o) */
			ivs_cputm		= Trim(ivo_Comum.ids_lista_registros.Object.cputm		[lvl_Linha])	/* Hora de Entrada (digita$$HEX2$$e700e300$$ENDHEX$$o) */
			ivs_xblnr		= Trim(ivo_Comum.ids_lista_registros.Object.xblnr		[lvl_Linha])	/* N$$HEX1$$ba00$$ENDHEX$$ Refer$$HEX1$$ea00$$ENDHEX$$ncia do Documento */
			ivs_bktxt 		= Trim(ivo_Comum.ids_lista_registros.Object.bktxt		[lvl_Linha])	/* Texto do Cabe$$HEX1$$e700$$ENDHEX$$alho Documento */
			ivs_xref1_hd	= Trim(ivo_Comum.ids_lista_registros.Object.xref1_hd	[lvl_Linha])	/* Chave Refer$$HEX1$$ea00$$ENDHEX$$ncia 1 - Cabe$$HEX1$$e700$$ENDHEX$$alho */
			ivs_xref2_hd	= Trim(ivo_Comum.ids_lista_registros.Object.xref2_hd	[lvl_Linha])	/* Chave Refer$$HEX1$$ea00$$ENDHEX$$ncia 2 - Cabe$$HEX1$$e700$$ENDHEX$$alho */
			ivs_waers		= Trim(ivo_Comum.ids_lista_registros.Object.waers		[lvl_Linha])	/* Moeda */
			ivs_awtyp		= Trim(ivo_Comum.ids_lista_registros.Object.awtyp		[lvl_Linha])	/* Opera$$HEX2$$e700e300$$ENDHEX$$o Refer$$HEX1$$ea00$$ENDHEX$$ncia (processo SAP que criou o docto) */
			ivs_usnam		= Trim(ivo_Comum.ids_lista_registros.Object.usnam		[lvl_Linha])	/* Usu$$HEX1$$e100$$ENDHEX$$rio (criador) */
			ivs_tcode		= Trim(ivo_Comum.ids_lista_registros.Object.tcode		[lvl_Linha])	/* Transa$$HEX2$$e700e300$$ENDHEX$$o (que criou o docto) */
			ivs_aworg_rev	= Trim(ivo_Comum.ids_lista_registros.Object.aworg_rev	[lvl_Linha])	/* Empresa + Ano - Documento Estornado */
			ivs_awref_rev	= Trim(ivo_Comum.ids_lista_registros.Object.awref_rev	[lvl_Linha])	/* N$$HEX1$$ba00$$ENDHEX$$ Documento Cont$$HEX1$$e100$$ENDHEX$$bil - Documento Estornado */
			ivs_xreversing	= Trim(ivo_Comum.ids_lista_registros.Object.xreversing	[lvl_Linha])	/* $$HEX1$$c900$$ENDHEX$$ um documento de estorno? */

			/* Tabela SAP => BSEG - Item Documento */
			ivs_buzei		= Trim(ivo_Comum.ids_lista_registros.Object.buzei		[lvl_Linha])	/* N$$HEX1$$ba00$$ENDHEX$$ Item do Documento (Sequencial dentro do documento cont$$HEX1$$e100$$ENDHEX$$bil) */
			ivs_gsber		= Trim(ivo_Comum.ids_lista_registros.Object.gsber		[lvl_Linha])	/* Divis$$HEX1$$e300$$ENDHEX$$o (Filial SAP) */
			ivs_zuonr		= Trim(ivo_Comum.ids_lista_registros.Object.zuonr		[lvl_Linha])	/* Atribui$$HEX2$$e700e300$$ENDHEX$$o */
			ivs_sgtxt		= Trim(ivo_Comum.ids_lista_registros.Object.sgtxt		[lvl_Linha])	/* Texto do Item */
			ivs_xref1		= Trim(ivo_Comum.ids_lista_registros.Object.xref1		[lvl_Linha])	/* Chave Refer$$HEX1$$ea00$$ENDHEX$$ncia 1 */
			ivs_xref2		= Trim(ivo_Comum.ids_lista_registros.Object.xref2		[lvl_Linha])	/* Chave Refer$$HEX1$$ea00$$ENDHEX$$ncia 2 */
			ivs_xref3		= Trim(ivo_Comum.ids_lista_registros.Object.xref3		[lvl_Linha])	/* Chave Refer$$HEX1$$ea00$$ENDHEX$$ncia 3 */
			ivs_kidno		= Trim(ivo_Comum.ids_lista_registros.Object.kidno		[lvl_Linha])	/* Refer$$HEX1$$ea00$$ENDHEX$$ncia Pagamento */
			ivs_zfbdt		= Trim(ivo_Comum.ids_lista_registros.Object.zfbdt		[lvl_Linha])	/* Data Base Vencimento */
			ivs_zterm		= Trim(ivo_Comum.ids_lista_registros.Object.zterm		[lvl_Linha])	/* Condi$$HEX2$$e700e300$$ENDHEX$$o de Pagamento */
			ivs_zlsch		= Trim(ivo_Comum.ids_lista_registros.Object.zlsch		[lvl_Linha])	/* Forma de Pagamento */
			ivs_netdt		= Trim(ivo_Comum.ids_lista_registros.Object.netdt		[lvl_Linha])	/* Data Vencimento */
			ivs_hkont		= Trim(ivo_Comum.ids_lista_registros.Object.hkont		[lvl_Linha])	/* Conta Raz$$HEX1$$e300$$ENDHEX$$o (conta cont$$HEX1$$e100$$ENDHEX$$bil SAP) */
			ivs_kunnr		= Trim(ivo_Comum.ids_lista_registros.Object.kunnr		[lvl_Linha])	/* Cliente (somente em t$$HEX1$$ed00$$ENDHEX$$tulos a receber ou antecipa$$HEX2$$e700f500$$ENDHEX$$es) */
			ivs_lifnr		= Trim(ivo_Comum.ids_lista_registros.Object.lifnr		[lvl_Linha])	/* Fornecedor (somente em t$$HEX1$$ed00$$ENDHEX$$tulos a pagar ou cr$$HEX1$$e900$$ENDHEX$$dito) */
			ivs_umskz		= Trim(ivo_Comum.ids_lista_registros.Object.umskz		[lvl_Linha])	/* C$$HEX1$$f300$$ENDHEX$$d. Raz$$HEX1$$e300$$ENDHEX$$o Especial */
			ivs_kostl		= Trim(ivo_Comum.ids_lista_registros.Object.kostl		[lvl_Linha])	/* Centro de Custo */
			ivs_prctr		= Trim(ivo_Comum.ids_lista_registros.Object.prctr		[lvl_Linha])	/* Centro de Lucro */
			ivs_hbkid		= Trim(ivo_Comum.ids_lista_registros.Object.hbkid		[lvl_Linha])	/* Banco Empresa */
			ivs_anfbn		= Trim(ivo_Comum.ids_lista_registros.Object.anfbn		[lvl_Linha])	/* Solita$$HEX2$$e700e300$$ENDHEX$$o LC (envio remessa banco) */
			ivs_wrbtr		= Trim(ivo_Comum.ids_lista_registros.Object.wrbtr		[lvl_Linha])	/* Montante em Moeda do Documento */
			ivs_nebtr		= Trim(ivo_Comum.ids_lista_registros.Object.nebtr		[lvl_Linha])	/* Montante L$$HEX1$$ed00$$ENDHEX$$quido do Documento */
			ivs_ebeln		= Trim(ivo_Comum.ids_lista_registros.Object.ebeln		[lvl_Linha])	/* N$$HEX1$$ba00$$ENDHEX$$ Documento Compras */
			ivs_ebelp		= Trim(ivo_Comum.ids_lista_registros.Object.ebelp		[lvl_Linha])	/* N$$HEX1$$ba00$$ENDHEX$$ Item Documento Compras */
			ivs_matnr		= Trim(ivo_Comum.ids_lista_registros.Object.matnr		[lvl_Linha])	/* N$$HEX1$$ba00$$ENDHEX$$ Material (c$$HEX1$$f300$$ENDHEX$$digo de produto SAP) */
			ivs_anln1		= Trim(ivo_Comum.ids_lista_registros.Object.anln1		[lvl_Linha])	/* N$$HEX1$$ba00$$ENDHEX$$ Ativo Imobilizado (c$$HEX1$$f300$$ENDHEX$$digo do ativo SAP) */
			ivs_anln2		= Trim(ivo_Comum.ids_lista_registros.Object.anln2		[lvl_Linha])	/* Subn$$HEX1$$fa00$$ENDHEX$$mero Ativo Imobilizado (p/ bens vinculados, subitens) */
			ivs_vbeln		= Trim(ivo_Comum.ids_lista_registros.Object.vbeln		[lvl_Linha])	/* Documento Faturamento */
			ivs_vbel2		= Trim(ivo_Comum.ids_lista_registros.Object.vbel2		[lvl_Linha])	/* Documento Vendas */
			ivs_posn2		= Trim(ivo_Comum.ids_lista_registros.Object.posn2		[lvl_Linha])	/* Item Documento Vendas */
			
			//Reduzir texto para caber no campo Sybase
			ivs_sgtxt 		= gf_replace(ivs_sgtxt, 'LAN$$HEX1$$c700$$ENDHEX$$AMENTO DE VERBA', 'LAN$$HEX1$$c700$$ENDHEX$$AMENTO VERBA',0)
			
			If IsValid(w_aguarde_3) Then
				w_aguarde_3.wf_SetText('Titulo: ' + IIF(ivs_xreversing='X',ivs_awref_rev, ivs_belnr) , 3 )
			End If		
			
			lvs_Log_Compl = 'SAP: Tipo['+ivs_blart+&
												'], Titulo['+IIF(ivs_xreversing='X',ivs_awref_rev, ivs_belnr)+&
												'], Valor['+ivs_wrbtr+&
												'], Vencimento['+ivs_netdt+'].'
			
			//////////////////////////////////////////////////
			//	 				Tipos de Documentos		 			//
			//----------------------------------------------//
			//	AC - Cli. Acor.Comerciais (Verbas Compras)	//
			//	SC - Est. Acor.Comerciais (Verbas Compras)	//
			//////////////////////////////////////////////////
			If Pos("|AC|SC|","|"+ivs_blart+"|") = 0 Then
				lvb_Sucesso = False
				lvs_Log = "O tipo de documento '"+ivs_blart+"' n$$HEX1$$e300$$ENDHEX$$o foi previsto na interface. O esperado $$HEX1$$e900$$ENDHEX$$ AC."
				Return False
			End If
			
			//////////////////////////////////////////////////
			//	 		Tipos de Documentos de Estorno 			//
			//----------------------------------------------//
			//	SC - Est. Acor.Comerciais (Verbas Compras)	//
			//////////////////////////////////////////////////
			If Pos("|SC|","|"+ivs_blart+"|") > 0 And (IsNull(ivs_awref_rev) Or ivs_awref_rev = '') Then
				lvb_Sucesso = False
				lvs_Log = "Para o tipo de documento '"+ivs_blart+"' $$HEX1$$e900$$ENDHEX$$ preciso informar o campo [AWREF_REV]."
				Return False
			End If
			
			/* Efetua DE/PARA SAP x Sybase */
			If Not This.Of_De_Para_Usuario(ivo_Comum.ids_lista_registros.Object.usnam[lvl_Linha], ref ivs_NR_Usuario, ref lvs_Log) Then Return False
			If Not This.Of_De_Para_Filial(ivo_Comum.ids_lista_registros.Object.gsber[lvl_Linha], ref ivl_Filial, ref lvs_Log) Then Return False		
			If Not This.Of_De_Para_Cliente(ivo_Comum.ids_lista_registros.Object.kunnr[lvl_Linha], False, ref ivs_CD_Cliente, ref lvs_Log) Then Return False
			If Not This.Of_De_Para_Portador(ivo_Comum.ids_lista_registros.Object.hbkid[lvl_Linha], ref ivl_CD_Portador, ref lvs_Log) Then Return False
			/* Converte Informa$$HEX2$$e700f500$$ENDHEX$$es de Texto para o Tipo de Dado do Sybase */
			If Not ivo_Comum.Of_Decimal(ivs_wrbtr, 'WRBTR', ref ivdc_VL_Nominal, ref lvs_Log) Then Return False
			If Not ivo_Comum.Of_Date_Time(ivs_cpudt, ivs_cputm, 'CPUDT / CPUTM', ref ivdh_Sistema, ref lvs_Log ) Then Return False
			If Not ivo_Comum.Of_Date_Time(ivs_budat, 'BLDAT', ref ivdh_Movimento, ref lvs_Log ) Then Return False
			If Not ivo_Comum.Of_Date_Time(ivs_budat, 'BUDAT', ref ivdh_Emissao, ref lvs_Log ) Then Return False
			//If Not ivo_Comum.Of_Date_Time(ivs_budat, 'BLDAT', ref ivdh_Emissao, ref lvs_Log ) Then Return False /* 2024.05.07 - Ocorre problema na data ao subir novamente ao SAP */
			If Not ivo_Comum.Of_Date_Time(ivs_netdt, 'NETDT', ref ivdh_Vencto, ref lvs_Log ) Then Return False
					
			//Forma de pagamento 9 $$HEX1$$e900$$ENDHEX$$ boleto originado no SAP (mesmo que A), 
			// por$$HEX1$$e900$$ENDHEX$$m foi criada uma nova para que o setor n$$HEX1$$e300$$ENDHEX$$o envie dois boletos iguais
			If ivs_zlsch='9' or ivs_zlsch='A' Then
				ivs_zlsch		 = 'A'
				ivl_CD_Portador = 50 //Portador SICREDI (boleto)
			//Se o portador padr$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ banco mas o t$$HEX1$$ed00$$ENDHEX$$tulo SAP n$$HEX1$$e300$$ENDHEX$$o, ent$$HEX1$$e300$$ENDHEX$$o altera para carteira
			ElseIf ivl_CD_Portador = 50 Then
				ivl_CD_Portador = 10 //Portador CARTEIRA
			End If
			
			/* Conforme o Tipo de Documento (blart) seta os campos NF_NF, DE_SERIE, DE_ESPECIE */
			Choose Case ivs_blart 
				Case 'AC', 'SC'  //Verbas Compras
					SetNull(ivl_NR_Nf)
					SetNull(ivs_DE_Serie)
					SetNull(ivs_DE_Especie)
					
				Case Else 
					SetNull(ivl_NR_Nf)
					SetNull(ivs_DE_Serie)
					SetNull(ivs_DE_Especie)
			End Choose
			
			Choose Case ivs_blart
				Case "AC" //Novo
					//Verifica titulo existente (Ano + Empresa + N$$HEX1$$ba00$$ENDHEX$$ Documento + N$$HEX1$$ba00$$ENDHEX$$ Item )
					If Not This.Of_Valida_Situacao_Titulo(	Long(ivs_bukrs),	/* Empresa	*/ &
																		ivs_belnr,			/* N$$HEX1$$ba00$$ENDHEX$$ Docto */ &
																		Long(ivs_gjahr),	/* Ano 		*/ & 
																		Long(ivs_buzei),	/* N$$HEX1$$ba00$$ENDHEX$$ Item	*/ &
																		ivl_Filial, &
																		ivl_CD_Portador, &
																		ivs_CD_Cliente,&
																		"CR", &
																		ivl_NR_Nf, &
																		ivs_DE_Serie, &
																		ivdh_Vencto,&
																		ref lvs_Log) Then
						lvb_Sucesso = False
						Return False
					Else
						//Busca no Sybase a pr$$HEX1$$f300$$ENDHEX$$xima numera$$HEX2$$e700e300$$ENDHEX$$o para a filial/t$$HEX1$$ed00$$ENDHEX$$tulo, 
						// coloca o XX no final para n$$HEX1$$e300$$ENDHEX$$o conflitar com a numera$$HEX2$$e700e300$$ENDHEX$$o da loja
						ivs_NR_Titulo = LeftA(ivo_Titulo.Of_Proximo_Titulo(ivl_Filial),11) + 'XX'
						
						//Se n$$HEX1$$e300$$ENDHEX$$o conseguiu buscar/gerar uma numera$$HEX2$$e700e300$$ENDHEX$$o para o t$$HEX1$$ed00$$ENDHEX$$tulo
						If IsNull(ivs_NR_Titulo) Then 
							lvb_Sucesso = False
							lvs_Log = "Erro ao gerar o pr$$HEX1$$f300$$ENDHEX$$ximo n$$HEX1$$fa00$$ENDHEX$$mero de t$$HEX1$$ed00$$ENDHEX$$tulo no sistema. Filial " + string(ivl_Filial)
							Return False
						End If
						//Insere o t$$HEX1$$ed00$$ENDHEX$$tulo
						If This.of_Insere_Titulo( al_controle, &
														  ivs_NR_Titulo, &
														  ivl_Filial, &
														  "CR", &
														  ivl_CD_Portador, &
														  ivdh_Movimento, &
														  ivdh_Vencto, &
														  ivdc_VL_Nominal, &
														  Long(ivs_bukrs), /* Empresa SAP */	&
														  ivs_belnr, 		 /* N$$HEX1$$ba00$$ENDHEX$$ Docto SAP	*/ &
														  Long(ivs_gjahr), /* Ano Docto SAP	*/ &
														  Long(ivs_buzei), /* N$$HEX1$$ba00$$ENDHEX$$ Item SAP	*/ &
														  ivs_CD_Cliente, &
														  ivl_NR_Nf, &
														  ivs_DE_Serie, &
														  '',	&
														  ivs_xblnr, /* Refer$$HEX1$$ea00$$ENDHEX$$ncia		*/ &
														  ivs_zuonr, /* Atribui$$HEX2$$e700e300$$ENDHEX$$o		*/ &
														  ivs_xref1, /* Chave Ref.1	*/ &
														  ivs_xref2, /* Chave Ref.2	*/ &
														  ivs_xref3, /* Chave Ref.3	*/ &
														  ivs_kidno, /* Ref. Pagto		*/ &
														  ivs_zterm, /* Cond. Pagto	*/ &
														  ivs_zlsch, /* Forma Pagto	*/ &
														  ivs_anfbn, /* Solic. LC		*/	&
														  ivs_hkont, /* Conta Raz$$HEX1$$e300$$ENDHEX$$o	*/ &
														  ivs_vbeln, /* Doc. Fatura	*/ &
														  Ref lvs_Log) Then
												  
							lvi_Movto_Abertura = ivo_Titulo.Of_Movto_Abertura()
							//Se encontrou qual $$HEX1$$e900$$ENDHEX$$ a movimenta$$HEX2$$e700e300$$ENDHEX$$o de abertura
							If lvi_Movto_Abertura <> 0 Then
								//Insere o movimento de abertura (movimento_titulo_receber)
								If This.Of_Insere_Movimento_Titulo(	 ivs_NR_Titulo, &
																				 1,&
																				 lvi_Movto_Abertura, &
																				 ivs_NR_Usuario, &
																				 ivdh_Sistema, &
																				 ivdh_Movimento, &
																				 ivdc_VL_Nominal, &
																				 ivs_sgtxt, &
																				 ivl_Filial, &
																				 Ref lvs_Log) Then lvb_Sucesso = True
							End If
						End If
					End If
					
				Case "SC" // Estorno
					lvb_Estornado = False
					//Verifica se o t$$HEX1$$ed00$$ENDHEX$$tulo j$$HEX1$$e100$$ENDHEX$$ foi estornado
					If Not This.Of_Valida_Situacao_Estorno_Titulo(	ivs_awref_rev, &
																					ivl_Filial, &
																					ivl_CD_Portador, &
																					ivs_CD_Cliente,&
																					"CR", &
																					ivl_NR_Nf, &
																					ivs_DE_Serie, &
																					ivdh_Vencto,&
																					ref ivs_NR_Titulo, &
																					ref lvs_Log, &
																					ref lvb_Estornado) Then
						Return False
					Else
						
						// Se j$$HEX1$$e100$$ENDHEX$$ estiver estornado, n$$HEX1$$e300$$ENDHEX$$o precisa inserir movimento de estorno.
						If lvb_Estornado Then
							lvb_Sucesso = True
						Else
							// Atualiza o movimento de abertura para estornado
							Update movimento_titulo_receber
							Set id_estorno = 'S'
							Where nr_titulo           	= :ivs_NR_Titulo
							  and cd_filial_movimento 	= :ivl_Filial
							  and nr_movimento        	= 1
							Using SQLCa;
							
							If SQLCa.SQLCode = -1 Then
								lvs_Log = "Erro ao atualizar movimento de abertura do titulo com o nr_documento_sap '" + ivs_belnr + "'." + SQLCa.SQLErrText
								lvb_Sucesso = False
							ElseIf SQLCa.SQLNRows <= 0 Then
								lvs_Log = "Erro ao atualizar movimento de abertura do titulo com o nr_documento_sap '" + ivs_belnr + "'. Movimento n$$HEX1$$e300$$ENDHEX$$o encontrado."
								lvb_Sucesso = False
							Else
								
								//Movimento de estono
								lvl_Movto_Estorno = ivo_Titulo.of_Movto_Estorno_Abertura()
								//Insere o movimento de estorno de abertura (movimento_titulo_receber)
								If This.Of_Insere_Movimento_Titulo(	ivs_NR_Titulo, &
																				ivl_Filial, &
																				lvl_Movto_Estorno, &
																				ivs_NR_Usuario, &
																				ivdh_Sistema, &
																				ivdh_Movimento, &
																				ivdc_VL_Nominal, &
																				ivs_sgtxt, &
																				ivl_Filial, &
																				Ref lvs_Log) Then lvb_Sucesso = True
							End If
						End If
					End If
					
				Case Else
					//fim
					
			End Choose
			
			//Commit por titulo
			If lvb_Sucesso Then SQLCa.of_Commit()
			
			if IsValid(w_aguarde_3) Then
				w_aguarde_3.uo_progress_2.of_SetProgress(1)
			end if	
			
		Next
		
	End If
	
Catch ( RuntimeError  lvo_Erro )
	lvs_Log = "Objeto [uo_ge473_titulo_sap], fun$$HEX2$$e700e300$$ENDHEX$$o [of_processa_titulo]. Erro: "+lvo_Erro.GetMessage( )
	Return False		
	
Finally
		
	If lvb_Sucesso Then
		SQLCa.of_Commit()
	Else
		SQLCa.of_RollBack()
		If Not IsNull(lvs_Log_Compl) Then lvs_Log = lvs_Log + " "+ lvs_Log_Compl
		ivo_Comum.of_Grava_Erro(al_controle, 321, lvs_Log)
	End If	
End Try
	
Return True
end function

public function boolean of_de_para_usuario (readonly string as_usuario_sap, ref string as_usuario, ref string as_log);String lvs_Chave_Legado

Try
	If Trim(as_usuario_sap) = "" or IsNull(as_usuario_sap) Then
		as_Log	= "N$$HEX1$$e300$$ENDHEX$$o foi informado o Usu$$HEX1$$e100$$ENDHEX$$rio [usnam]."
		Return False
	End If

	//Verifica se a FILIAL j$$HEX1$$e100$$ENDHEX$$ tem o DE/PARA em mem$$HEX1$$f300$$ENDHEX$$ria
	If Not This.Of_Retorna_Valor_DE_Para('USUARIO', as_usuario_sap, ref lvs_Chave_Legado, ref as_Log ) Then
		Return False
	End If
	
	//Usu$$HEX1$$e100$$ENDHEX$$rio n$$HEX1$$e300$$ENDHEX$$o encontrado no dataset
	If gf_coalesce(lvs_Chave_Legado,'')='' Then
		Select top 1 nr_matricula
		Into	:as_usuario
		From usuario
		Where nr_matricula = :as_usuario_sap
		Using SQLCa;
		
		Choose Case SQLCa.SqlCode
			Case 0
				//Insere o registro no dataset em mem$$HEX1$$f300$$ENDHEX$$ria, para caso exista outro t$$HEX1$$ed00$$ENDHEX$$tulo que necessite do mesmo DE/PARA
				If Not This.Of_Insere_DE_PARA('USUARIO', as_usuario_sap, as_usuario, ref as_log) Then Return False
			Case 100
				as_usuario = '14330'
				//Insere o registro no dataset em mem$$HEX1$$f300$$ENDHEX$$ria, para caso exista outro t$$HEX1$$ed00$$ENDHEX$$tulo que necessite do mesmo DE/PARA
				If Not This.Of_Insere_DE_PARA('USUARIO', as_usuario_sap, as_usuario, ref as_log) Then Return False
				Return True
			Case -1
				as_Log	= "Erro ao localizar o de-para de Usuario SAP e Usuario: " + SQLCa.SQLErrText
				Return False
		End Choose
	Else
		//Recebe o valor j$$HEX1$$e100$$ENDHEX$$ contido no dataset
		as_usuario = lvs_Chave_Legado
	End If
	
Catch (RuntimeError lvo_Erro)
	as_log = lvo_Erro.GetMessage()
	Return False
	
Finally
	//
End Try

Return True
end function

public function boolean of_date_time_ex (string as_valor, string as_coluna, ref datetime adh_valor, ref string as_log);If Trim(as_Valor) =  ''  or isnull( as_Valor ) Then
	SetNull( adh_valor )
Else
	Exception lo_Exp
	lo_Exp = CREATE Exception
	lo_Exp.setMessage("O campo nao contem uma data")
	
	Try
		//20210423-085315
		If len( trim( as_Valor ) ) = 15 Then
			as_Valor = Mid(as_Valor, 1, 4) + '/' + Mid(as_Valor, 5, 2) + '/' + Mid(as_Valor, 7, 2) + ' ' +  Mid(as_Valor, 10, 2) + ':' +  Mid(as_Valor, 12, 2) + ':' +  Mid(as_Valor, 14, 2)
		End If
				
		If len( trim( as_Valor ) ) <> 19 then
			THROW (lo_Exp )
		End IF 
		//
		adh_valor = DateTime(as_Valor)
		//
		If isnull( adh_valor)  then 
			THROW (lo_Exp )
		End IF 
	
	Catch  (Throwable lo_rte )
		as_Log = "O valor informado '" + as_valor + "' para o campo '" + as_coluna + "' n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ v$$HEX1$$e100$$ENDHEX$$lido. Erro: "+lo_rte.GetMessage( )
		If Isvalid( lo_Exp ) Then Destroy  lo_Exp
		If Isvalid(  lo_rte ) Then Destroy  lo_rte
		Return False						 
	End Try
End If

If Isvalid( lo_Exp ) Then Destroy  lo_Exp
If Isvalid( lo_rte )  Then Destroy  lo_rte

Return True
end function

public function boolean of_insere_movimento_titulo (string ps_titulo, integer pi_nr_movimento, integer pi_tipo_movimento, string ps_responsavel, datetime pdt_sistema, datetime pdt_movimento, decimal pdc_movimento, string ps_historico, long pl_filial, ref string ps_log);INSERT INTO movimento_titulo_receber( nr_titulo,   
												  nr_movimento,   
												  cd_tipo_movimento,   
												  nr_matricula_responsavel,   
												  dh_sistema,   
												  dh_movimento,   
												  dh_credito,   
												  vl_movimento,   
												  vl_multa_recebida,   
												  vl_juros_recebidos,   
												  vl_desconto_concedido,   
												  vl_despesas_recebidas,   
												  id_estorno,   
												  de_historico,   
												  nr_recibo_cobranca,   
												  cd_filial_movimento,   
												  nr_matric_juros_desconto,   
												  cd_filial_atualizacao,   
												  dh_atualizacao_filial )  
VALUES (:ps_Titulo,   
		  :pi_nr_movimento,   
		  :pi_Tipo_Movimento,   
		  :ps_Responsavel,   
		  :pdt_Sistema,   
		  :pdt_Movimento,   
		  :pdt_Movimento,   
		  :pdc_Movimento,    
		  0.00,    
		  0.00,   
		  0.00,   
		  0.00,   
		  'N',   
		  :ps_Historico,   
		  null,   
		  :pl_Filial,   
		  null,   
		  null,   
		  null )
Using SQLCa;

If SQLCa.SqlCode = -1 Then
	ps_log = "Erro na inclus$$HEX1$$e300$$ENDHEX$$o do movimento t$$HEX1$$ed00$$ENDHEX$$tulo receber. " + SQLCa.SQLErrText
	Return False
End If

Return True
end function

public function boolean of_valida_situacao_estorno_titulo (readonly string as_nr_documento_sap, long al_filial, long al_portador, string as_cliente, string as_tipo, long al_nr_nf, string as_serie, datetime adt_vencimento, ref string as_nr_titulo, ref string as_log, ref boolean ab_estornado);String lvs_Sit
Decimal lvdc_vl_Recebido

// Procura um t$$HEX1$$ed00$$ENDHEX$$tulo da mesma filial, portador, tipo, cliente, documento SAP e data de vencimento.

Select top 1 nr_titulo, 
		id_situacao,
		vl_recebido
Into	:as_nr_titulo,
		:lvs_Sit,
		:lvdc_vl_Recebido
From titulo_receber
Where cd_filial 			= :al_filial
	And cd_portador 		= :al_portador
	And id_tipo_titulo 	= :as_tipo
	And cd_cliente 		= :as_cliente
	And nr_documento_sap = :as_nr_documento_sap
/*	And nr_nf 				= :al_nr_nf   
	And de_especie 		= 'NFE'   
	And de_serie 			= :as_serie*/
	And dh_vencimento		= :adt_vencimento
Using SQLCa;

Choose Case SQLCa.SqlCode
	Case 0 //  Encontrou
		
		// J$$HEX1$$e100$$ENDHEX$$ estornado
		If lvs_Sit = 'E' And lvdc_vl_Recebido = 0 Then
			ab_Estornado = True
			Return True
		End If
		
		// N$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ mais aberto ou j$$HEX1$$e100$$ENDHEX$$ teve algum valor recebido
		If lvs_Sit <> "A" or lvdc_vl_Recebido > 0 Then
			as_Log = "Somente t$$HEX1$$ed00$$ENDHEX$$tulos em aberto e com nenhum valor recebido podem ser estornados."
			Return False
		End If
		
	Case 100
		as_Log = "T$$HEX1$$ed00$$ENDHEX$$tulo n$$HEX1$$e300$$ENDHEX$$o encontrado na tabela titulo_receber para o nr_documento_sap '"+as_nr_documento_sap+"'. Estorno cancelado."
		Return False
		
	Case -1
		as_Log = "Erro ao localizar o t$$HEX1$$ed00$$ENDHEX$$tulo na tabela titulo_receber para o nr_documento_sap '"+as_nr_documento_sap+"'" + SQLCa.SQLErrText
		Return False
		
End Choose

Return True
end function

public function boolean of_de_para_portador (readonly string as_banco_empresa, ref long al_portador, ref string as_log);String lvs_Chave_Legado

Try
	//Se n$$HEX1$$e300$$ENDHEX$$o tiver HBKID (banco empresa) ent$$HEX1$$e300$$ENDHEX$$o o t$$HEX1$$ed00$$ENDHEX$$tulo receber$$HEX1$$e100$$ENDHEX$$ o portador 10 - CARTEIRA
	If Trim(as_banco_empresa) = "" or IsNull(as_banco_empresa) Then
		al_portador = 10
		Return True
	End If
	
	//Verifica se o portador j$$HEX1$$e100$$ENDHEX$$ tem o DE/PARA em mem$$HEX1$$f300$$ENDHEX$$ria
	If Not This.Of_Retorna_Valor_DE_Para('PORTADOR', as_banco_empresa, ref lvs_Chave_Legado, ref as_Log ) Then
		Return False
	End If
	
	//N$$HEX1$$e300$$ENDHEX$$o tinha o DE/PARA no dataset
	If (gf_coalesce(lvs_Chave_Legado,'')='') or (Not IsNumber(lvs_Chave_Legado)) Then
		//O banco empresa no SAP, geralmente, tem 5 posi$$HEX2$$e700f500$$ENDHEX$$es, as 3 primeiras $$HEX1$$e900$$ENDHEX$$ o banco
		If IsNumber(as_banco_empresa) and LenA(as_banco_empresa)>3 Then
			lvs_Chave_Legado = Mid(as_banco_empresa, 1, 3)
		End If
		
		//Busca portador na base de dados
		Select top 1 cd_portador
		Into	:al_portador
		From portador
		Where cd_banco = :lvs_Chave_Legado
		Using SQLCa;
		
		Choose Case SQLCa.SqlCode
			Case 0
				//Insere o registro no dataset em mem$$HEX1$$f300$$ENDHEX$$ria, para caso exista outro t$$HEX1$$ed00$$ENDHEX$$tulo que necessite do mesmo DE/PARA
				If Not This.Of_Insere_DE_PARA('PORTADOR', as_banco_empresa, String(al_portador), ref as_log) Then Return False
			Case 100
				as_Log	= "DE/PARA de Banco Empresa (SAP) para Portador (Sybase) n$$HEX1$$e300$$ENDHEX$$o foi localizado. [hbkid]"
				Return False
			Case -1
				as_Log	= "Erro ao localizar o DE/PARA de banco empresa (SAP) para Portador (Sybase): " + SQLCa.SQLErrText
				Return False
		End Choose
	Else
		//Recebe o valor j$$HEX1$$e100$$ENDHEX$$ existente no DE/PARA de mem$$HEX1$$f300$$ENDHEX$$ria
		al_portador = Long(lvs_Chave_Legado)
	End If
	
Catch (RuntimeError lvo_Erro)
	as_Log = lvo_Erro.GetMessage()
	Return False
	
Finally
	//
End Try

Return True
end function

public function boolean of_de_para_filial (readonly string as_divisao, ref long al_filial, ref string as_log);String lvs_Chave_Legado

Try
	//Tratamento caso entre com valor vazio
	If Trim(as_divisao) = "" or IsNull(as_divisao) Then
		as_Log	= "N$$HEX1$$e300$$ENDHEX$$o foi informado o c$$HEX1$$f300$$ENDHEX$$digo da filial [gsber]."
		Return False
	End If
	
	//Verifica se a FILIAL j$$HEX1$$e100$$ENDHEX$$ tem o DE/PARA em mem$$HEX1$$f300$$ENDHEX$$ria
	If Not This.Of_Retorna_Valor_DE_Para('FILIAL', as_divisao, ref lvs_Chave_Legado, ref as_Log ) Then
		Return False
	End If
	
	//Se n$$HEX1$$e300$$ENDHEX$$o encontrou a filial legado no DE/PARA de mem$$HEX1$$f300$$ENDHEX$$ria
	If gf_coalesce(lvs_Chave_Legado,'')='' or (Not IsNumber(lvs_Chave_Legado)) Then
		Select top 1 cd_chave_legado
		Into	:lvs_Chave_Legado
		From integracao_sap
		Where cd_tabela = 'FILIAL' 
		and cd_chave_sap = :as_divisao
		Using SQLCa;
		
		Choose Case SQLCa.SqlCode
			Case 0
				//OK
				al_filial = Long(lvs_Chave_Legado)
			Case 100
				as_Log	= "De-Para de Filial n$$HEX1$$e300$$ENDHEX$$o foi localizado. [gsber]"
				Return False
			Case -1
				as_Log	= "Erro ao localizar o de-para de Filial: " + SQLCa.SQLErrText
				Return False
		End Choose
	Else
		al_filial = Long(lvs_Chave_Legado)
	End If

Catch (RuntimeError lvo_Erro)
	as_log = lvo_Erro.GetMessage()
	Return False
	
Finally
	//
End Try

Return True
end function

private function boolean of_insere_de_para (string as_tabela, string as_chave_sap, string as_chave_legado, ref string as_log);Long lvl_Linha

Try
	lvl_Linha = ivds_de_para.InsertRow(0)
	
	ivds_de_para.Object.cd_tabela			[lvl_Linha] = as_tabela
	ivds_de_para.Object.cd_chave_sap		[lvl_Linha] = as_chave_sap
	ivds_de_para.Object.cd_chave_legado	[lvl_Linha] = as_chave_legado
	
Catch (RuntimeError lvo_Erro)
	as_log = lvo_Erro.GetMessage()
	Return False
	
Finally
	//
End Try

Return True
end function

private function boolean of_retorna_valor_de_para (string as_tabela, string as_chave_sap, ref string as_chave_legado, ref string as_log);Long lvl_Find

Try
	//Anula o retorno
	SetNull(as_chave_legado)
	//Confirma que a datastore est$$HEX1$$e100$$ENDHEX$$ criada
	If Not IsValid(ivds_de_para) Then
		ivds_de_para = Create dc_uo_ds_base
		If Not ivds_de_para.Of_ChangeDataObject('ds_ge473_de_para', False) Then
			as_log = This.ClassName()+".of_retorna_valor_de_para(): Falha ao mudar para o datasource ds_ge473_de_para."
			Return False
		End If
		//Recupera os valores j$$HEX1$$e100$$ENDHEX$$ definidos na query
		ivds_de_para.Retrieve()
	End If
	//Busca dentro da DW se j$$HEX1$$e100$$ENDHEX$$ existe esse DE/PARA
	lvl_Find = ivds_de_para.Find("cd_tabela='"+as_tabela+"' and cd_chave_sap='"+as_chave_sap+"'", 1, ivds_de_para.RowCount())
	//Se encontrou?
	If lvl_Find > 0 Then
		//Pega o valor para retornar a fun$$HEX2$$e700e300$$ENDHEX$$o pai
		as_chave_legado = ivds_de_para.Object.cd_chave_legado [lvl_Find]
	End If
	
Catch (RuntimeError lvo_Erro)
	as_log = lvo_Erro.GetMessage()
	Return False
Finally
	//
End Try

Return True
end function

public function boolean of_insere_titulo (long al_controle_interface, string ps_titulo, long pl_filial, string ps_tipo_titulo, integer pi_portador, datetime pdt_emissao, datetime pdt_vencimento, decimal pdc_nominal, long pl_empresa_docto_sap, string ps_nr_docto_sap, long pl_ano_docto_sap, integer pl_item_docto_sap, string ps_cliente, long pl_nr_nf, string ps_serie, string ps_de_referencia_sap, string ps_nr_referencia, string ps_de_atribuicao, string ps_de_chave_ref_1, string ps_de_chave_ref_2, string ps_de_chave_ref_3, string ps_nr_referencia_pagto, string ps_cd_condicao_pagto, string ps_cd_forma_pagto, string ps_de_solicitacao_lc, string ps_nr_conta_sap, string ps_nr_docto_faturamento, ref string ps_log);Long lvl_Filial_NF
String lvs_Especie_NF

If pl_nr_nf > 0 Then
	lvl_Filial_NF 	= pl_filial
	lvs_Especie_NF	= 'NFE'
Else
	SetNull(lvl_Filial_NF)
	SetNull(pl_Nr_NF)
	SetNull(lvs_Especie_NF)
End If

INSERT INTO titulo_receber ( nr_titulo,   
									  cd_filial,   
									  id_tipo_titulo,   
									  cd_portador,   
									  dh_emissao,   
									  dh_vencimento,   
									  dh_calculo_juros,   
									  vl_nominal,   
									  vl_multa_recebida,   
									  vl_juros_recebidos,   
									  vl_desconto_concedido,   
									  vl_despesas_pagas,   
									  vl_despesas_recebidas,   
									  vl_recebido,   
									  vl_aberto,   
									  id_situacao,   
									  id_carne_bloqueto,   
									  id_protesto,   
									  nr_titulo_banco,   
									  dh_baixa,   
									  cd_convenio,   
									  cd_cliente,   
									  cd_filial_nf,   
									  nr_nf,   
									  de_especie,   
									  de_serie,   
									  nr_titulo_as400,   
									  nr_remessa,   
									  dh_controle_atualizacao_filial,   
									  dh_venda_inicial,   
									  dh_venda_final,   
									  cd_filial_atualizacao,   
									  dh_atualizacao_filial,   
									  cd_fornecedor,   
									  id_perdas_lucros,
									  nr_controle_interface_sap, 
									  cd_empresa_sap, 
									  nr_documento_sap,
									  nr_ano_sap, 
									  nr_item_sap, 
									  de_referencia_sap,
									  nr_referencia,
									  de_atribuicao,
									  de_chave_ref_1,
									  de_chave_ref_2,
									  de_chave_ref_3,
									  nr_referencia_pagto,
									  cd_condicao_pagto,
									  cd_forma_pagto,
									  de_solicitacao_lc,
									  nr_conta_sap,
									  nr_docto_faturamento)  
VALUES (:ps_Titulo,   
		  :pl_Filial,   
		  :ps_Tipo_Titulo,   
		  :pi_Portador,   
		  :pdt_Emissao,   
		  :pdt_Vencimento,   
		  :pdt_Vencimento,   
		  :pdc_Nominal,   
		  0.00,
		  0.00,
		  0.00,   
		  0.00,   
		  0.00,   
		  0.00,   
		  :pdc_Nominal,   
		  'A',   
		  'B',   
		  'N',  
		  null,   
		  null,   
		  null,   
		  :ps_Cliente,   
		  :lvl_Filial_NF,   
		  :pl_Nr_NF,   
		  :lvs_Especie_NF,   
		  :ps_Serie,   
		  null,   
		  null,   
		  null,   
		  null,   
		  null,   
		  null,   
		  null,   
		  null,   
		  null,
		  :al_controle_interface,
		  :pl_empresa_docto_sap, 
		  :ps_nr_docto_sap,
		  :pl_ano_docto_sap, 
		  :pl_item_docto_sap,
		  :ps_de_referencia_sap,
		  :ps_nr_referencia,
		  :ps_de_atribuicao,
		  :ps_de_chave_ref_1,
		  :ps_de_chave_ref_2,
		  :ps_de_chave_ref_3,
		  :ps_nr_referencia_pagto,
		  :ps_cd_condicao_pagto,
		  :ps_cd_forma_pagto,
		  :ps_de_solicitacao_lc,
		  :ps_nr_conta_sap,
		  :ps_nr_docto_faturamento)
Using SQLCa;

If SQLCa.SqlCode = -1 Then
	ps_log = "Erro na inclus$$HEX1$$e300$$ENDHEX$$o do t$$HEX1$$ed00$$ENDHEX$$tulo. " + SQLCa.SQLErrText
	Return False
End If

Return True
end function

public function boolean of_valida_situacao_titulo (long al_empresa_sap, readonly string as_nr_documento_sap, long al_nr_ano_sap, long al_nr_item, long al_filial, long al_portador, string as_cliente, string as_tipo, long al_nr_nf, string as_serie, datetime adt_vencimento, ref string as_log);String lvs_nr_titulo

Select	top 1 nr_titulo
Into	:lvs_nr_titulo
From titulo_receber
Where cd_empresa_sap 	= :al_empresa_sap
	And nr_ano_sap			= :al_nr_ano_sap
	And nr_documento_sap = :as_nr_documento_sap
	And nr_item_sap		= :al_nr_item
Using SQLCa;

Choose Case SQLCa.SqlCode
	Case 0
		//OK
		If Not IsNull(lvs_nr_titulo) And lvs_nr_titulo <> "" Then
			as_Log = "T$$HEX1$$ed00$$ENDHEX$$tulo SAP ("+as_nr_documento_sap+") j$$HEX1$$e100$$ENDHEX$$ gravado na tabela titulo_receber com o n$$HEX1$$fa00$$ENDHEX$$mero: "+lvs_nr_titulo
			Return False
		End If
	Case 100
		//OK pode inserir
	Case -1
		as_Log	= "Erro ao localizar o tilulo na tabela titulo_receber" + SQLCa.SQLErrText
		Return False
End Choose

Return True
end function

public function boolean of_de_para_cliente (readonly string as_cliente_sap, boolean ab_fornecedor, ref string as_cliente, ref string as_log);String lvs_Cliente_SAP

Try
	If Trim(as_cliente_sap) = "" or IsNull(as_cliente_sap) Then
		as_Log	= "N$$HEX1$$e300$$ENDHEX$$o foi informado o c$$HEX1$$f300$$ENDHEX$$digo do Cliente [kunnr]."
		Return False
	End If
	
	//Remove zeros a esquerda
	lvs_Cliente_SAP = gf_remove_zeros_esquerda(as_cliente_sap)
	
	//Verifica se a FILIAL j$$HEX1$$e100$$ENDHEX$$ tem o DE/PARA em mem$$HEX1$$f300$$ENDHEX$$ria
	If Not This.Of_Retorna_Valor_DE_Para('CLIENTE', as_cliente_sap, ref as_cliente, ref as_Log ) Then
		Return False
	End If
	
	//Se n$$HEX1$$e300$$ENDHEX$$o encontrou o cliente no dataset
	If gf_coalesce(as_cliente,'')='' Then
		//busca na base de clientes
		Select top 1 cd_cliente
		Into	:as_cliente
		From cliente
		Where cd_cliente_sap = :lvs_Cliente_SAP
		Using SQLCa;
		
		Choose Case SQLCa.SqlCode
			Case 0
				//Insere o registro no dataset em mem$$HEX1$$f300$$ENDHEX$$ria, para caso exista outro t$$HEX1$$ed00$$ENDHEX$$tulo que necessite do mesmo DE/PARA
				If Not This.Of_Insere_DE_PARA('CLIENTE', as_cliente_sap, as_cliente, ref as_log) Then Return False
			
			Case 100
				//Se n$$HEX1$$e300$$ENDHEX$$o tem o cliente e possuir o c$$HEX1$$f300$$ENDHEX$$digo fornecedor preenchido faz a expans$$HEX1$$e300$$ENDHEX$$o para cliente
				If (Not ab_fornecedor) and gf_coalesce(ivs_lifnr,'')<>'' Then
					Return This.Of_Expandir_Fornecedor_Para_Cliente(ivs_lifnr, as_cliente_sap, ref as_cliente, ref as_log)
				Else
					as_Log	= "De-para de Cliente SAP ["+as_cliente_sap+"] n$$HEX1$$e300$$ENDHEX$$o foi localizado no Sybase."
					Return False
				End If
			Case -1
				as_Log	= "Erro ao localizar o de-para de Cliente SAP e Cliente: " + SQLCa.SQLErrText
				Return False
		End Choose
	End If
	
Catch(RuntimeError lvo_Erro)
	as_log = lvo_Erro.GetMessage()
	Return False
End Try

Return True
end function

public function boolean of_expandir_fornecedor_para_cliente (readonly string as_fornecedor_sap, readonly string as_cliente_sap, ref string as_cliente_sybase, ref string as_log);String lvs_Forn_Legado
String lvs_Forn_SAP
String lvs_Cli_Legado
String lvs_CNPJ
String lvs_CPF

Try
	//Remove zeros a esquerda
	lvs_Forn_SAP = gf_remove_zeros_esquerda(as_fornecedor_sap)
	
	Select top 1 cd_fornecedor, nr_cgc, nr_cpf
	Into :lvs_Forn_Legado, :lvs_CNPJ, :lvs_CPF
	From fornecedor
	Where cd_fornecedor_sap = :as_fornecedor_sap
	Order by coalesce(id_situacao,'A') asc, cd_fornecedor desc
	Using SQLCa;
		
	Choose Case SQLCa.SqlCode
		Case 0
			//Se possuir CPF
			If gf_coalesce(lvs_CPF,'')<>'' Then
				//Verifica se o CPF j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ cadastrado como cliente (pode n$$HEX1$$e300$$ENDHEX$$o ter o CD_CLIENTE_SAP)
				Select cd_cliente
				Into :lvs_Cli_Legado
				From cliente 
				Where nr_cpf_cgc = :lvs_CPF
				Using SQLCa;
			End If
			
			//Se ainda n$$HEX1$$e300$$ENDHEX$$o encontrou um cliente pelo CPF, tenta pelo CNPJ
			If gf_coalesce(lvs_Cli_Legado,'') = '' Then
				//Verifica se o CPF j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ cadastrado como cliente (pode n$$HEX1$$e300$$ENDHEX$$o ter o CD_CLIENTE_SAP)
				Select cd_cliente
				Into :lvs_Cli_Legado
				From cliente 
				Where nr_cpf_cgc = :lvs_CNPJ
				Using SQLCa;					
			End If
			
			//Se encontrou algum cliente
			If gf_coalesce(lvs_Cli_Legado,'') <> '' Then
				//Atualiza c$$HEX1$$f300$$ENDHEX$$digo cliente SAP (caso n$$HEX1$$e300$$ENDHEX$$o tenha) para n$$HEX1$$e300$$ENDHEX$$o ocorrer mais o problema
				Update cliente
				Set cd_cliente_sap = :as_cliente_sap
				Where cd_cliente = :lvs_Cli_Legado
					and cd_cliente_sap is null
				Using SQLCa;
			Else
				lvs_Cli_Legado = '000200' + Mid(lvs_Forn_Legado,5,5)
				
				insert into cliente ( cd_cliente, id_tipo_cliente, cd_cliente_sap, id_fisica_juridica, nm_cliente, nm_razao_social, nr_cpf_cgc, nr_inscricao_estadual, 
							 cd_cidade, de_endereco, nr_endereco, de_complemento, de_bairro, nr_cep, id_tempo_residencia, id_tipo_residencia, 
							 de_endereco_email, nr_ddd_fone_residencial, nr_fone_residencial, nr_ddd_celular, nr_celular, nr_ddd_fone_comercial, nr_fone_comercial, 
							 cd_filial_inclusao, nr_matricula_inclusao, dh_inclusao, cd_filial_atualizacao, nr_matricula_atualizacao, dh_atualizacao, id_inativo)
				SELECT :lvs_Cli_Legado, 'CR', :as_cliente_sap, id_fisica_juridica, nm_fantasia, nm_razao_social, coalesce(nr_cgc, nr_cpf) as nr_cpf_cgc, nr_inscricao_estadual, 
						cd_cidade, de_endereco, cast(nr_endereco as varchar) as nr_endereco, null as de_complemento, de_bairro, nr_cep, null as id_tempo_residencia, null as id_tipo_residencia, 
						de_email, nr_ddd_telefone, nr_telefone, nr_ddd_fax, nr_fax, nr_ddd_telefone_compras, nr_telefone_compras, 
						2 as cd_filial_inclusao, '14330' as nr_matricula_inclusao, getdate() as dh_inclusao, 2 as cd_filial_atualizacao, '14330' as nr_matricula_atualizacao, getdate() as dh_atualizacao,
						'N' as id_inativo
				from fornecedor
				where cd_fornecedor = :lvs_Forn_Legado
				and not exists (select 1 
									 from cliente c1 
									 where c1.nr_cpf_cgc = fornecedor.nr_cgc)
				Using SQLCa;
				
				If SQLCa.SQLCode = -1 Then
					as_log = "Erro ao expandir o fornecedor ["+gf_coalesce(lvs_Forn_Legado,'')+"]. ErroDB: "+SQLCa.SQLErrText
					Return False
				End If
			End If

			//Insere o registro no dataset em mem$$HEX1$$f300$$ENDHEX$$ria, para caso exista outro t$$HEX1$$ed00$$ENDHEX$$tulo que necessite do mesmo DE/PARA
			If Not This.Of_Insere_DE_PARA('CLIENTE', as_cliente_sap, lvs_Cli_Legado, ref as_log) Then Return False
			
			Return This.Of_De_Para_Cliente(as_cliente_sap, True, ref as_cliente_sybase, ref as_log)
		Case 100
			//Se n$$HEX1$$e300$$ENDHEX$$o encontrou um fornecedor, ent$$HEX1$$e300$$ENDHEX$$o retorna a fun$$HEX2$$e700e300$$ENDHEX$$o de DE/PARA de cliente vazio
			SetNull(as_cliente_sybase)
			Return True
			
		Case -1
			as_Log	= "Erro ao localizar o fornecedor SAP ["+as_fornecedor_sap+"] para expandir para cliente. ErroDB: " + SQLCa.SQLErrText
			Return False
	End Choose
	
Catch(RuntimeError lvo_Erro)
	as_log = lvo_Erro.GetMessage()
	Return False
End Try

Return True
end function

on uo_ge473_titulo_sap.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge473_titulo_sap.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event destructor;If IsValid(ivds_de_para) Then
	ivds_de_para.RowsDiscard(1, ivds_de_para.RowCount(), Primary!)
	Destroy(ivds_de_para)
End If

If IsValid(ivo_Comum) Then Destroy(ivo_Comum)
If IsValid(ivo_Titulo) Then Destroy(ivo_Titulo)
end event

event constructor;ivo_Titulo   = Create uo_Titulo
end event

