HA$PBExportHeader$uo_cliente_central.sru
forward
global type uo_cliente_central from nonvisualobject
end type
end forward

global type uo_cliente_central from nonvisualobject
end type
global uo_cliente_central uo_cliente_central

type variables
string ivs_parametro, &
         ivs_tipo_cliente

string cd_cliente, &
         nm_cliente, &
         id_tipo_cliente, &
         cd_dependente, &
         nm_dependente, &
         nr_cartao_clube,&
         de_senha_cliente,&
         de_senha_dependente,&
		nr_cpf,&
		id_fisica_juridica,&
		nr_matric_liberacao_restricao,&
		nr_dia_vencimento,&
		de_hash_senha,&
		de_hash_senha_dep		

String nm_social
		
Boolean limite_localizado = False

Boolean cartao_bloqueado = False

Decimal vl_limite_credito_saldo,&
              vl_limite_credito,&
              vl_limite_credito_utilizado

Decimal {3}	vl_limite_20

Boolean ivb_permite_resgate_dependente, &
              ivb_permite_credito_dependente
end variables

forward prototypes
public function boolean of_saldo_pontuacao_cliente (string as_cliente, ref decimal adc_pontos)
public subroutine of_inicializa ()
public function boolean of_localiza_dependente_generica (string as_parametro)
public function boolean of_localiza_cliente_generica (string as_parametro)
public function boolean of_localiza_dependente (string as_parametro)
public function boolean of_imprime_recibo_resgate (long al_recibo)
public function boolean of_extrato_pontuacao_cliente (string as_cliente, date adt_inicio, date adt_termino, datawindow adw_dw)
public function boolean of_inclui_movto_venda_devolucao (long al_filial, long al_nf, string as_especie, string as_serie, datetime adh_data, string as_cliente, string as_dependente, string as_cartao, decimal adc_total_nf, decimal adc_pontos, string as_tipo_nf, string as_cancelamento)
public function boolean of_inclui_cartao_clube (string as_cartao, string as_cliente, string as_dependente, long al_filial, string as_matricula)
public function boolean of_localiza_cliente_cartao (string as_cartao)
public function boolean of_grava_cliente (string as_cliente)
public function boolean of_grava_dependente (string as_cliente)
public function boolean of_bloqueia_cartao (string as_cartao, datetime adh_bloqueio, long al_filial, string as_matricula, long al_motivo)
public function boolean of_consulta_limite_credito_local (string as_codigo, decimal adc_credito)
public function boolean of_inclui_precadastro_cliente (string as_cliente)
public function boolean of_limite_credito_calculado (long al_filial, decimal adc_renda, integer ai_idade, string as_tempo_residencia, string as_tipo_residencia, string as_tempo_empresa, string as_estado_civil, string as_ocupacao, ref decimal adc_limite)
public function boolean of_inclui_movto_credito_online (string as_cliente, long al_filial, date adt_movto, integer ai_tipo, decimal adc_valor, string as_documento)
public function boolean of_consulta_limite_credito_central (string as_codigo, decimal adc_credito)
public function boolean of_consulta_limite_credito_cliente (string as_codigo, decimal adc_credito)
public function boolean of_localiza_cliente_cpf (string as_cpf)
public function boolean of_localiza_cliente (string as_parametro, string as_identificador)
public function boolean of_localiza_cliente_rg (string as_rg)
public function boolean of_localiza_cliente (string as_parametro)
public function boolean of_inclui_recibo_resgate (string as_cliente, string as_dependente, string as_cartao, decimal adc_total_pontos, long al_filial, string as_matricula, long al_produto[], long al_qtde[], decimal adc_pontos[], long al_vale[], ref long al_recibo)
public function boolean of_cancela_recibo_resgate_clube (string as_matricula_cancelamento, long al_recibo_resgate, ref long al_produto[], ref integer ai_qtde_produto[])
public function boolean of_inclui_recibo_resgate (string as_cliente, string as_dependente, string as_cartao, decimal adc_total_pontos, long al_filial, string as_matricula, long al_produto[], long al_qtde[], decimal adc_pontos[], string as_utiliza_vale_resgate[], ref long al_recibo)
public subroutine of_esconde_informacoes_vale (ref datastore avds_1)
public function boolean of_imprime_recibo_resgate (long al_recibo, string as_matricula_reimpressao)
public function boolean of_saldo_pontuacao_vencendo (date adt_vencimento, string as_cliente, ref decimal adc_pontos)
public function boolean of_atualiza_pedido_ecommerce (long al_pedido, string as_matricula, string as_situacao)
public function boolean of_localiza_dependente_matriz (ref string as_codigo, ref string as_nome, ref string as_senha)
public function boolean of_localiza_cliente_codigo (string as_codigo)
public function boolean of_tipo_movto_venda_devolucao (string as_tipo_nf, string as_cancelamento, ref long al_tipo_movto)
public function boolean of_data_fechamento_pontuacao (ref date adt_data)
public function boolean of_saldo_pontuacao_cliente (string as_cliente, date adt_saldo, ref decimal adc_pontos)
public function boolean of_limite_credito_cliente (string as_codigo, ref decimal adc_limite_credito, ref boolean ab_localizado)
public function boolean of_consulta_contas_receber (string as_codigo, ref decimal adc_vendas, ref decimal adc_titulos, ref decimal adc_outros)
public function boolean of_data_fechamento_contas_receber (ref datetime adt_data)
public function boolean of_saldo_online_aberto (string as_cliente, ref decimal adc_saldo)
public function boolean of_cliente_bloqueado_bacen (string as_cpf, long al_filial)
public function boolean of_cliente_bloqueado_bacen (string as_cpf)
public function boolean of_proximo_vale_resgate (ref long al_vale_resgate)
public function boolean of_proximo_recibo_resgate (ref long al_recibo)
public function boolean of_tipo_movto_resgate (ref long al_tipo_movto)
public function boolean of_numero_movto_resgate (string as_cliente, long al_recibo, long al_tipo, ref double adb_movto)
public function boolean of_atualiza_utilizacao_pontos (string as_cliente, double adb_movto, decimal adc_pontos)
public function boolean of_inclui_movto_resgate_clube (string as_cliente, decimal adc_pontos, long al_filial, string as_cartao, string as_dependente_cliente, long al_recibo_resgate)
public function boolean of_tipo_movto_resgate_cancelamento (ref long al_tipo_movto)
public function boolean of_carrega_produto_recibo_resgate (long al_recibo_resgate, ref long al_produto[], ref integer ai_qtde_produto[])
public function boolean of_verifica_fase_atualizacao (string as_cliente, ref string ps_nr_fase)
public function boolean of_atualiza_fase_atualizacao (string as_codigo, boolean ab_atualizou)
public function boolean of_inclui_recibo_resgate (string as_cliente, string as_dependente, string as_cartao, decimal adc_total_pontos, long al_filial, string as_matricula, long al_produto[], long al_qtde[], decimal adc_pontos[], string as_utiliza_vale_resgate[], string as_cartao_smiles, ref long al_recibo)
public function boolean of_imprime_recibo_resgate (long al_recibo, string as_matricula_reimpressao, string as_cartao_smiles, long al_qt_milhas)
public function boolean of_atualiza_mensagem_campanha (string ps_cliente, long pl_campanha, string ps_matricula, long pl_filial)
public function boolean of_verifica_mensagem_campanha (dc_uo_ds_base pds_campanha)
public function boolean of_existe_cartao_clube (string as_cliente, string as_dependente, string as_rede_filial, ref boolean ab_existe)
public function boolean of_existe_cartao_clube_central (string as_cliente, string as_dependente, string as_rede_filial, ref boolean ab_existe)
public function boolean of_vale_resgate (long al_produto[], long al_qtde[], string as_utiliza_vale_resgate[], ref long al_vale_resgate[])
public function boolean of_existe_cliente (string as_cliente, ref boolean ab_existe)
public function boolean of_retorna_limite_cliente (string as_codigo, ref decimal adc_limite)
public function boolean of_retorna_limite_cliente_central (string as_codigo, ref decimal adc_limite)
public function boolean of_retorna_limite_cliente_local (string as_codigo, ref decimal adc_limite)
public function boolean of_existe_cpf_cgc (string as_cpf, ref boolean ab_existe)
public function boolean of_atualiza_mensagem_campanha (string ps_cliente, long pl_campanha, string ps_matricula, long pl_filial, string ps_tipo_campanha, string ps_retorno_tela, datetime pdt_abertura_mensagem, datetime pdt_fechamento_mensagem)
public function boolean of_grava_aviso_cliente (string as_cliente, string as_matricula_captacao)
public function boolean of_grava_senha_cliente (string as_cliente, string as_senha, datetime ah_data_alteracao, long al_filial_alteracao, string as_matricula_alteracao, boolean ab_limpa_senha)
public function boolean of_grava_senha_dependente (string as_dependente, string as_senha, datetime ah_data_alteracao, long al_filial_alteracao, string as_matricula_alteracao, boolean ab_limpa_senha)
end prototypes

public function boolean of_saldo_pontuacao_cliente (string as_cliente, ref decimal adc_pontos);Date lvdt_Fechamento

If Not This.of_Data_Fechamento_Pontuacao(ref lvdt_Fechamento) Then
	Return False
End If

Return This.of_Saldo_Pontuacao_Cliente(as_Cliente, lvdt_Fechamento, ref adc_Pontos)
end function

public subroutine of_inicializa ();SetNull(Cd_Cliente)
SetNull(Cd_Dependente)
SetNull(Nr_Cartao_Clube)
SetNull(de_senha_cliente)
SetNull(de_senha_dependente)

Nm_Cliente = ""
Nm_Social = ""
Nm_Dependente = ""
Id_Tipo_Cliente = ""
nr_cpf = ""
Id_Fisica_Juridica = ""

Cartao_Bloqueado = False
end subroutine

public function boolean of_localiza_dependente_generica (string as_parametro);String lvs_Dependente

If IsNull(This.Cd_Cliente) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O c$$HEX1$$f300$$ENDHEX$$digo do cliente deve ser informado para localiza$$HEX2$$e700e300$$ENDHEX$$o dos dependentes.", Information!)
	Return False
End If

This.ivs_Parametro = as_Parametro

OpenWithParm(w_ge077_Selecao_Dependente_Cliente, This)

lvs_Dependente = Message.StringParm

If Not IsNull(lvs_Dependente) and Trim(lvs_Dependente) <> '' Then
	Return This.of_Localiza_Dependente_Matriz(lvs_Dependente, &
															Ref This.nm_Dependente, &
															Ref This.de_Senha_Dependente)
Else
	Return True
End If
end function

public function boolean of_localiza_cliente_generica (string as_parametro);String lvs_Codigo

This.ivs_Parametro = as_Parametro

OpenWithParm(w_ge077_Selecao_Cliente, This)

lvs_Codigo = Message.StringParm

If Not IsNull(lvs_Codigo) Then
	Return This.of_Localiza_Cliente_Codigo(lvs_Codigo)
Else
	Return False
End If
end function

public function boolean of_localiza_dependente (string as_parametro);Boolean lvb_Sucesso = False

Integer lvi_Tamanho

as_Parametro = Trim(as_Parametro)

lvi_Tamanho = LenA(as_Parametro)

Return This.of_Localiza_Dependente_Generica(as_Parametro)

If lvi_Tamanho > 0 Then
	If IsNumber(as_Parametro) Then
		If lvi_Tamanho = 13 Then
			lvb_Sucesso = This.of_Localiza_Dependente_Matriz(Ref as_Parametro, &
																  			 Ref This.Nm_Dependente, &
																 			 Ref This.De_Senha_Dependente)
		End If
		
		If Not lvb_Sucesso Then
			lvb_Sucesso = This.of_Localiza_Dependente_Generica("")
		End If
	Else
		lvb_Sucesso = This.of_Localiza_Dependente_Generica(as_Parametro)
	End If
Else
	lvb_Sucesso = This.of_Localiza_Dependente_Generica("")
End If

Return lvb_Sucesso
end function

public function boolean of_imprime_recibo_resgate (long al_recibo);Boolean lvb_Sucesso = False

Blob lvb_Blob

Long	lvl_Linhas,&
		lvl_Find,&
		lvl_Vale_Resgate, &
		lvl_Retorno, &
		lvl_Linha

String lvs_Mensagem,&
	   lvs_Produto,&
	   lvs_Responsavel_Reimp, &
		lvs_Erro, &
		lvs_Retorno

dc_uo_ds_Base lvds_1
lvds_1 = Create dc_uo_ds_Base

If Not lvds_1.of_ChangeDataObject("dw_ge077_impressao_recibo_resgate") Then
	Destroy(lvds_1)
	Return False
End If

lvds_1.of_AppendWhere("r.nr_recibo_resgate = " + String(al_Recibo))

uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao()

lvo_Conexao.of_ConverteVirgula(True)

lvo_Conexao.of_Retrieve(lvds_1.GetSQLSelect(), Ref lvs_Retorno)

lvl_Retorno = lvds_1.ImportString(lvs_Retorno)

If lvl_Retorno > 0 Then
	lvds_1.of_Print(False)
	lvb_Sucesso = True
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar os produtos do servidor distribui$$HEX1$$ed00$$ENDHEX$$o.")
End If

Destroy(lvds_1)
Destroy(lvo_Conexao)

Return lvb_Sucesso
end function

public function boolean of_extrato_pontuacao_cliente (string as_cliente, date adt_inicio, date adt_termino, datawindow adw_dw);Boolean lvb_Sucesso = False

String lvs_SQL

Integer lvi_Mes, &
        lvi_Ano

Date lvdt_Saldo_Inicial

Decimal lvdc_Saldo_Inicial

Long lvl_Saldo_Inicial
Long lvl_Linha
Long lvl_Linhas

String lvs_Retorno
// Verifica o m$$HEX1$$ea00$$ENDHEX$$s anterior ao m$$HEX1$$ea00$$ENDHEX$$s inicial para recupera$$HEX2$$e700e300$$ENDHEX$$o do saldo inicial
lvi_Mes = Month(adt_Inicio)
lvi_Ano = Year(adt_Inicio)

If lvi_Mes = 1 Then
	lvi_Mes = 12
	lvi_Ano = lvi_Ano - 1
Else
	lvi_Mes = lvi_Mes - 1
End If

lvdt_Saldo_Inicial = Date("01/" + String(lvi_Mes, "00") + "/" + String(lvi_Ano, "0000"))

// Verifica o saldo inicial
If Not This.of_Saldo_Pontuacao_Cliente(as_Cliente, lvdt_Saldo_Inicial, ref lvdc_Saldo_Inicial) Then
	Return False
End If

uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao()

lvo_Conexao.of_ConverteVirgula(True)

lvo_Conexao.of_Relatorio(True)

lvo_Conexao.of_Executa_Rotina("0032",{String(Long(lvdc_Saldo_Inicial * 100)), "'" + as_Cliente + "'", "'" + String(adt_Inicio,"YYYYMMDD") + "'", "'" + String(adt_Termino,"YYYYMMDD") + "'"})

If lvo_Conexao.of_Erro_Conexao() Or lvo_Conexao.of_Erro_Execucao() Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na conex$$HEX1$$e300$$ENDHEX$$o com o servidor distribu$$HEX1$$ed00$$ENDHEX$$do.")
Else
	lvb_Sucesso = True
	
	If lvo_Conexao.of_Linhas() > 0 Then
		lvo_Conexao.of_Retorno_Dados(lvs_Retorno)
		
		If Not IsNull(lvs_Retorno) And Trim(lvs_Retorno) <> "" Then
			
			lvs_Retorno = gf_Replace(lvs_Retorno,".",",",0)
			
			If adw_dw.ImportString(lvs_Retorno) < 0 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na importa$$HEX2$$e700e300$$ENDHEX$$o dos dados do servidor distribu$$HEX1$$ed00$$ENDHEX$$do para a data window local.")
				lvb_Sucesso = False
			End If
			
		End If
		
	End If
	
End If

Destroy(lvo_Conexao)

Return lvb_Sucesso
end function

public function boolean of_inclui_movto_venda_devolucao (long al_filial, long al_nf, string as_especie, string as_serie, datetime adh_data, string as_cliente, string as_dependente, string as_cartao, decimal adc_total_nf, decimal adc_pontos, string as_tipo_nf, string as_cancelamento);Boolean lvb_Sucesso

Long lvl_Tipo_Movto
Long lvl_Row

String lvs_Documento
String lvs_Tabela
String lvs_Colunas
String lvs_Values

If Trim(as_Cartao) = "" Then SetNull(as_Cartao)

// Localiza o c$$HEX1$$f300$$ENDHEX$$digo do tipo do movimento a ser inclu$$HEX1$$ed00$$ENDHEX$$do
If Not This.of_Tipo_Movto_Venda_Devolucao(as_Tipo_NF, &
														as_Cancelamento, &
														ref lvl_Tipo_Movto) Then
	Return False
End If

lvs_Documento = String(al_Filial) + "/" + String(al_NF) + "/" + as_Especie + "/" + as_Serie

uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota
				
lvo_Conexao.of_BancoProducao()

lvs_Tabela 	= 'pontuacao_clube_movimento'

lvs_Colunas = 'cd_cliente,dh_movimento,cd_tipo_movimento,vl_movimento,qt_pontos,cd_filial,nr_cartao_clube,cd_dependente_cliente,nr_documento,de_historico,qt_saldo_pontos,id_situacao_pontos'

If IsNull(as_Dependente) Then
	as_Dependente = 'null'
Else
	as_Dependente = "'" + as_Dependente + "'"
End If

If IsNull(as_Cartao) Then
	as_Cartao = 'null'
Else
	as_Cartao = "'" + as_Cartao + "'"
End If

If IsNull(lvs_Documento) Then
	lvs_Documento = 'null'
Else
	lvs_Documento = "'" + lvs_Documento + "'"
End If
	
lvs_Values	 = "'" + as_Cliente + "',"
lvs_Values	+= "'" + String(adh_Data,'yyyy/mm/dd') + "',"
lvs_Values	+= String(lvl_Tipo_Movto) + ","
lvs_Values	+= gf_Replace(String(adc_Total_NF),",",".",0) + ","
lvs_Values	+= gf_Replace(String(adc_Pontos),",",".",0)	 + ","
lvs_Values	+= String(al_Filial)		+ ","
lvs_Values	+= as_Cartao 		+ ","
lvs_Values	+= as_Dependente			+ ","
lvs_Values	+= lvs_Documento 			+ ","
lvs_Values	+= "null,"
lvs_Values	+= gf_Replace(String(adc_Pontos),",",".",0) + ","
lvs_Values	+= "'D'"
				  
lvb_Sucesso = lvo_Conexao.of_Insert_Registro(lvs_Tabela,lvs_Colunas,lvs_Values, Ref lvl_Row)

Destroy(lvo_Conexao)

Return lvb_Sucesso
end function

public function boolean of_inclui_cartao_clube (string as_cartao, string as_cliente, string as_dependente, long al_filial, string as_matricula);Boolean lvb_Sucesso, &
        lvb_Existe, &
		  lvb_Conexao
		  
String lvs_Mensagem
String	ls_Rede_Filial

If Not gf_Rede_Filial( ref ls_Rede_Filial ) Then
	Return False
End If

// Gambiarra - 06/01/2013 - Liberada a entrega de cart$$HEX1$$f500$$ENDHEX$$es, independente de j$$HEX1$$e100$$ENDHEX$$ existir algum cadastrado para o cliente
// Gambiarra - 16/10/2013 - Bloqueado a entrega de cart$$HEX1$$e300$$ENDHEX$$o da mesma rede para o mesmo cliente/dependente, se n$$HEX1$$e300$$ENDHEX$$o houver outro liberado
// Verifica se existe algum cart$$HEX1$$e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o bloqueado (banco local)
If Not This.of_Existe_Cartao_Clube(as_Cliente, as_Dependente, ls_Rede_Filial, ref lvb_Existe) Then Return False

If lvb_Existe Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Este cliente/dependente j$$HEX1$$e100$$ENDHEX$$ possui outro cart$$HEX1$$e300$$ENDHEX$$o cadastrado.~r" + &
	                      "Para cadastrar um novo $$HEX1$$e900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio bloquear todos os outros.", Information!)
	Return False
End If

// Verifica se existe algum cart$$HEX1$$e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o bloqueado (banco da matriz)
If Not This.of_Existe_Cartao_Clube_Central(as_Cliente, as_Dependente, ls_Rede_Filial, ref lvb_Existe) Then Return False

If lvb_Existe Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Este cliente/dependente j$$HEX1$$e100$$ENDHEX$$ possui outro cart$$HEX1$$e300$$ENDHEX$$o cadastrado.~r" + &
								 "Para cadastrar um novo $$HEX1$$e900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio bloquear todos os outros.", Information!)						 
	Return False
End If

// Inclui o cart$$HEX1$$e300$$ENDHEX$$o no banco local

Insert Into cartao_clube (nr_cartao_clube,   
								  dh_entrega,   
								  cd_filial_entrega,   
								  nr_matricula_entrega,   
								  cd_cliente,   
								  cd_dependente_cliente,   
								  dh_bloqueio,   
								  cd_motivo_bloqueio,   
								  cd_filial_bloqueio,   
								  nr_matricula_bloqueio,
								  id_rede_cartao)  
Values (:as_Cartao,   
		  getdate(),   
		  :al_Filial,   
		  :as_Matricula,   
		  :as_Cliente,   
		  :as_Dependente,   
		  null,   
		  null,   
		  null,   
		  null,
		  :ls_Rede_Filial)
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Inclus$$HEX1$$e300$$ENDHEX$$o do Cart$$HEX1$$e300$$ENDHEX$$o do Clube '" + as_Cartao + "'")
	Return False
End If

SqlCa.of_Commit()


// Inclui o cart$$HEX1$$e300$$ENDHEX$$o no banco da matriz
Long	lvl_Row
String	lvs_Tabela
String	lvs_Colunas
String	lvs_Values

uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao()
	
lvs_Tabela  = "cartao_clube"

lvs_Colunas = "nr_cartao_clube, dh_entrega, cd_filial_entrega, nr_matricula_entrega, cd_cliente, cd_dependente_cliente, dh_bloqueio, cd_motivo_bloqueio, cd_filial_bloqueio, nr_matricula_bloqueio, id_rede_cartao"

//--- Verifica se o n$$HEX1$$fa00$$ENDHEX$$mero do cart$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ nulo
If IsNull(as_Cartao) Or Trim(as_Cartao) = "" Then
	as_Cartao = "null,"
Else
	as_Cartao = "'" + as_Cartao + "',"
End If
	
//--- Verifica se a matr$$HEX1$$ed00$$ENDHEX$$cula do usu$$HEX1$$e100$$ENDHEX$$rio est$$HEX1$$e100$$ENDHEX$$ nula
If IsNull(as_Matricula) Or Trim(as_Matricula) = "" Then
	as_Matricula = "null,"
Else
	as_Matricula = "'" + as_Matricula + "',"
End If	

//--- Verifica se o c$$HEX1$$f300$$ENDHEX$$digo do cliente est$$HEX1$$e100$$ENDHEX$$ nulo
If IsNull(as_Cliente) Or Trim(as_Cliente) = "" Then
	as_Cliente = "null,"
Else
	as_Cliente = "'" + as_Cliente + "',"
End If

//--- Verifica se o c$$HEX1$$f300$$ENDHEX$$digo do dependente $$HEX1$$e900$$ENDHEX$$ nulo
If IsNull(as_Dependente) Or Trim(as_Dependente) = "" Then
	as_Dependente = "null,"
Else
	as_Dependente = "'" + as_Dependente + "',"
End If
	
lvs_Values  = as_Cartao
lvs_Values += "'" + String( gf_GetServerDate(),"YYYY/MM/DD hh:mm:ss") + "',"
lvs_Values += String(al_Filial)	+ ","   
lvs_Values += as_Matricula 
lvs_Values += as_Cliente  
lvs_Values += as_Dependente
lvs_Values += "null,"
lvs_Values += "null,"
lvs_Values += "null,"   
lvs_Values += "null,"
lvs_Values += "'" + ls_Rede_Filial + "'"

lvo_Conexao.of_Insert_Registro(lvs_Tabela,lvs_Colunas,lvs_Values, Ref lvl_Row)

If lvl_Row > 0 Then
	lvb_Sucesso = True
Else
	lvb_Sucesso = False
End If

Destroy(lvo_Conexao)
//--- Fim da verifica$$HEX2$$e700e300$$ENDHEX$$o na matriz
If lvb_Sucesso Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O cart$$HEX1$$e300$$ENDHEX$$o '" + as_Cartao + "' foi inclu$$HEX1$$ed00$$ENDHEX$$do com sucesso nos bancos de dados da loja e da matriz.")
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O cart$$HEX1$$e300$$ENDHEX$$o '" + as_Cartao + "' foi inclu$$HEX1$$ed00$$ENDHEX$$do somente no banco de dados da loja e estar$$HEX1$$e100$$ENDHEX$$ dispon$$HEX1$$ed00$$ENDHEX$$vel " + &
	                      "para as outras lojas somente ap$$HEX1$$f300$$ENDHEX$$s a atualiza$$HEX2$$e700e300$$ENDHEX$$o da matriz.")
End If

// Retorna sempre true, pois incluiu no banco de dados da loja
Return True 
end function

public function boolean of_localiza_cliente_cartao (string as_cartao);String lvs_Mensagem

Boolean lvb_Sucesso = False

Datetime lvdh_Bloqueio

uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao()

lvo_Conexao.of_ConverteVirgula(True)
lvo_Conexao.of_Define_Variaveis(True)

lvo_Conexao.of_Executa_Rotina('0133', {"'" + as_cartao + "'", String( lvo_Conexao.il_Filial ) })

If lvo_Conexao.of_Erro_Execucao() Or lvo_Conexao.of_Erro_Conexao() Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do cart$$HEX1$$e300$$ENDHEX$$o n$$HEX1$$fa00$$ENDHEX$$mero '" + as_Cartao, StopSign!)
Else
	
	If lvo_Conexao.of_Linhas() > 0 Then		
		If lvo_Conexao.of_Retorno("cd_cliente", Ref This.Cd_Cliente) Then
			If lvo_Conexao.of_Retorno("cd_dependente_cliente", Ref This.Cd_Dependente) Then
				If lvo_Conexao.of_Retorno("dh_bloqueio", Ref lvdh_Bloqueio) Then
										
					lvb_Sucesso = True
					
					lvb_Sucesso = This.of_Localiza_Cliente_Codigo(This.Cd_Cliente)
					
					This.Nr_Cartao_Clube = as_Cartao
					
					If Not IsNull(lvdh_Bloqueio) Then 
						This.Cartao_Bloqueado = True
					Else
						This.Cartao_Bloqueado = False
					End If

					SetNull(This.Nm_Dependente)
					
					If Not IsNull(This.Cd_Dependente) and Trim(This.Cd_Dependente) <> '' Then
						lvb_Sucesso = This.of_Localiza_Dependente_Matriz(Ref This.Cd_Dependente, &
																  						 Ref This.Nm_Dependente, &
																 						 Ref This.De_Senha_Dependente)
					End If
					
				End If		
			End If
		End If
	End If
	
End If

Destroy(lvo_Conexao)

Return lvb_Sucesso
end function

public function boolean of_grava_cliente (string as_cliente);Boolean lvb_Sucesso = False

dc_uo_ds_Base lvds_1
lvds_1 = Create dc_uo_ds_Base

If Not lvds_1.of_ChangeDataObject("dw_ge077_gravacao_cliente") Then
	Destroy(lvds_1)
	Return False
End If

If lvds_1.Retrieve(as_Cliente) <= 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na recupera$$HEX2$$e700e300$$ENDHEX$$o dos dados para grava$$HEX2$$e700e300$$ENDHEX$$o do cliente no banco de dados da matriz.")
	Destroy(lvds_1)
	Return False	
End If

// Novo
String 	lvs_Cliente, &
		lvs_Cliente_Where, &
		lvs_Nome, &
		lvs_Tipo_Cliente, &
		lvs_Fisica_Juridica, &
		lvs_CPF, &
		lvs_RG, &
		lvs_Orgao_RG, &
		lvs_Uf_Emissor_RG, &
		lvs_Mae, &
		lvs_Sexo, &
		lvs_Estado_Civil, &
		lvs_Filhos, &
		lvs_Endereco, &
		lvs_Numero, &
		lvs_Complemento, &
		lvs_Bairro, &
		lvs_CEP, &
		lvs_Tempo_Residencia, &
		lvs_Tipo_Residencia, &
		lvs_Email, &
		lvs_DDD_Res, &
		lvs_Fone_Res, &
		lvs_DDD_Com, &
		lvs_Fone_Com, &
		lvs_DDD_Cel, &
		lvs_Fone_Cel, &
		lvs_DDD_Rec, &
		lvs_Fone_Rec, &
		lvs_Empresa, &
		lvs_Profissao, &
		lvs_Ocupacao, &
		lvs_Tempo_Empresa, &
		lvs_Matric_Calc_Credito, &
		lvs_Matric_Aprov_Credito, &
		lvs_Uso_Continuo, &
		lvs_Comunicacao, &
		lvs_Matricula_Inclusao, &
		lvs_Matricula_Atualizacao, &
		lvs_Documentacao_Pendente, &
		lvs_Conjuge, &
		lvs_Outra_Ocupacao, &
		lvs_Empresa_Convenio, &
		lvs_Permite_Resgate_Dep, &
		lvs_Permite_Credito_Dep, &
		lvs_Razao_Social, &
		lvs_Inscricao_Estadual, &
		lvs_Email_Envio_Xml

String ls_Falecido, ls_Nome_Social		
	
// Datatime
String	lvs_Inclusao, &
        lvs_Atualizacao, &
        lvs_Nascimento, &
	    lvs_Filho_1, &
	    lvs_Filho_2, &
	    lvs_Filho_3, &
	    lvs_Filho_4, &
		lvs_Calculo_Credito, &
		lvs_Aprovacao_Credito		 
		 
// Long		 
String	lvs_Filial_Inclusao, &
		lvs_Filial_Atualizacao, &
		lvs_Cidade, &
		lvs_Filial_Centralizadora, &
		lvs_Portador, &
		lvs_Dia_Vencimento, &
		lvs_Filial_Calc_Credito, &
		lvs_Filial_Aprov_Credito, &
		lvs_Filial_Pendente, &
		lvs_Grau_Instrucao

// Decimal
String	lvs_Renda_Mensal, &
		lvs_Credito_Calculado, &
		lvs_Credito_Aprovado

// Integer
String	lvs_Pontos_Proxima_Compra

Long lvl_Row
String lvs_Tabela

lvs_Cliente               				= lvds_1.Object.Cd_Cliente                 	[1]
lvs_Nome                  			= lvds_1.Object.Nm_Cliente                 	[1]
lvs_Tipo_Cliente          			= lvds_1.Object.Id_Tipo_Cliente            	[1]
lvs_Fisica_Juridica					= lvds_1.Object.Id_Fisica_Juridica			[1]
lvs_CPF                   				= lvds_1.Object.Nr_CPF_CGC                 [1]
lvs_RG                    				= lvds_1.Object.Nr_RG                      	[1]
lvs_Orgao_RG              			= lvds_1.Object.De_Orgao_Emissor_RG  [1]
lvs_Uf_Emissor_RG       			= lvds_1.Object.Cd_Uf_Emissor_RG       	[1]
lvs_Nascimento         	  			= String(lvds_1.Object.Dh_Nascimento   	[1],"YYYY/MM/DD HH:MM:SS")
lvs_Mae                   				= lvds_1.Object.Nm_Mae                     	[1]
lvs_Sexo                  				= lvds_1.Object.Id_Sexo                    	[1]
lvs_Estado_Civil        				= lvds_1.Object.Id_Estado_Civil           	[1]
lvs_Filhos                				= lvds_1.Object.Id_Possui_Filhos           	[1]
lvs_Filho_1               				= String(lvds_1.Object.Dh_Nascimento_Filho_1			[1],"YYYY/MM/DD HH:MM:SS")
lvs_Filho_2               				= String(lvds_1.Object.Dh_Nascimento_Filho_2			[1],"YYYY/MM/DD HH:MM:SS")
lvs_Filho_3               				= String(lvds_1.Object.Dh_Nascimento_Filho_3			[1],"YYYY/MM/DD HH:MM:SS")
lvs_Filho_4               				= String(lvds_1.Object.Dh_Nascimento_Filho_4			[1],"YYYY/MM/DD HH:MM:SS")
lvs_Cidade                				= String(lvds_1.Object.Cd_Cidade  		 				[1])
lvs_Endereco              			= lvds_1.Object.De_Endereco                					[1]
lvs_Numero                			= lvds_1.Object.Nr_Endereco                					[1]
lvs_Complemento           		= lvds_1.Object.De_Complemento             				[1]
lvs_Bairro                				= lvds_1.Object.De_Bairro                 			 		[1]
lvs_CEP                   				= lvds_1.Object.Nr_CEP                     					[1]
lvs_Tempo_Residencia      		= lvds_1.Object.Id_Tempo_Residencia        			[1]
lvs_Tipo_Residencia       			= lvds_1.Object.Id_Tipo_Residencia         				[1]
lvs_Email                 				= lvds_1.Object.De_Endereco_Email          				[1]
lvs_DDD_Res               			= lvds_1.Object.Nr_DDD_Fone_Residencial    			[1]
lvs_Fone_Res              			= lvds_1.Object.Nr_Fone_Residencial        				[1]
lvs_DDD_Cel               			= lvds_1.Object.Nr_DDD_Celular             				[1]
lvs_Fone_Cel              			= lvds_1.Object.Nr_Celular                					[1]
lvs_DDD_Com               			= lvds_1.Object.Nr_DDD_Fone_Comercial      			[1]
lvs_Fone_Com              			= lvds_1.Object.Nr_Fone_Comercial          				[1]
lvs_DDD_Rec               			= lvds_1.Object.Nr_DDD_Fone_Recado         			[1]
lvs_Fone_Rec              			= lvds_1.Object.Nr_Fone_Recado             				[1]
lvs_Empresa               			= lvds_1.Object.Nm_Empresa                 				[1]
lvs_Profissao            	 			= lvds_1.Object.De_Profissao               					[1]
lvs_Ocupacao              			= lvds_1.Object.Id_Natureza_Ocupacao       			[1]
lvs_Tempo_Empresa         		= lvds_1.Object.Id_Tempo_Empresa           			[1]
lvs_Renda_Mensal     	  			= String(lvds_1.Object.Vl_Renda_Mensal     			[1])
lvs_Uso_Continuo          			= lvds_1.Object.Id_Medicamento_Uso_Continuo		[1]
lvs_Comunicacao           			= lvds_1.Object.Id_Autoriza_Comunicacao    			[1]
lvs_Dia_Vencimento        		= String(lvds_1.Object.Nr_Dia_Vencimento     			[1])
lvs_Calculo_Credito       			= String(lvds_1.Object.Dh_Calculo_Credito    			[1],"YYYY/MM/DD HH:MM:SS")
lvs_Filial_Calc_Credito   			= String(lvds_1.Object.Cd_Filial_Calc_Credito			[1])
lvs_Matric_Calc_Credito   		= lvds_1.Object.Nr_Matric_Calc_Credito     				[1]
lvs_Credito_Calculado     		= String(lvds_1.Object.Vl_Limite_Credito_Calculado	[1])
lvs_Aprovacao_Credito	  		= String(lvds_1.Object.Dh_Aprovacao_Credito       	[1],"YYYY/MM/DD HH:MM:SS")
lvs_Filial_Aprov_Credito  		= String(lvds_1.Object.Cd_Filial_Aprov_Credito   	 	[1])
lvs_Matric_Aprov_Credito  		= lvds_1.Object.Nr_Matric_Aprov_Credito    			[1]
lvs_Credito_Aprovado      		= String(lvds_1.Object.Vl_Limite_Credito_Aprovado 	[1])
lvs_Filial_Pendente       			= String(lvds_1.Object.Cd_Filial_Credito_Pendente 	[1])
lvs_Filial_Centralizadora 			= String(lvds_1.Object.Cd_Filial_Centralizadora   		[1])
lvs_Portador              			= String(lvds_1.Object.Cd_Portador                			[1])
lvs_Filial_Inclusao       			= String(lvds_1.Object.Cd_Filial_Inclusao         		[1])
lvs_Matricula_Inclusao    		= lvds_1.Object.Nr_Matricula_Inclusao      				[1]	
lvs_Inclusao              				= String(lvds_1.Object.Dh_Inclusao               	 		[1],"YYYY/MM/DD HH:MM:SS")
lvs_Filial_Atualizacao    			= String(lvds_1.Object.Cd_Filial_Atualizacao      		[1])
lvs_Matricula_Atualizacao 		= lvds_1.Object.Nr_Matricula_Atualizacao   				[1]	
lvs_Atualizacao        	  			= String(lvds_1.Object.Dh_Atualizacao            		 	[1],"YYYY/MM/DD HH:MM:SS")
lvs_Pontos_Proxima_Compra	= String(lvds_1.Object.Qt_Pontos_Proxima_Compra  	[1])
lvs_Documentacao_Pendente 	= lvds_1.Object.Id_Documentacao_Pendente     		[1]
lvs_Conjuge              	 			= lvds_1.Object.Nm_Conjuge                 				[1]
lvs_Outra_Ocupacao        		=	lvds_1.Object.De_Natureza_Ocupacao  				[1]
lvs_Empresa_Convenio      		= lvds_1.Object.Nm_Empresa_Convenio          			[1]
lvs_Permite_Resgate_Dep   		= lvds_1.Object.Id_Permite_Resgate_Dependente		[1]
lvs_Permite_Credito_Dep   		= lvds_1.Object.Id_Permite_Credito_Dependente		[1]
lvs_Grau_Instrucao   	  			= String(lvds_1.Object.Cd_Grau_Instrucao				[1])
lvs_Razao_Social					= lvds_1.Object.Nm_Razao_Social							[1]
lvs_Inscricao_Estadual			= lvds_1.Object.Nr_Inscricao_Estadual					[1]
lvs_Email_Envio_Xml				= lvds_1.Object.De_Endereco_Email_Envio_Xml		[1]
ls_Falecido							= lvds_1.Object.id_Falecido									[1]
ls_Nome_Social					= lvds_1.Object.nm_social									[1]

// Adapta$$HEX2$$e700e300$$ENDHEX$$o para o servidor distribu$$HEX1$$ed00$$ENDHEX$$do novo
lvs_Cliente 					= gf_Valida_Nulo(lvs_Cliente, True, False)
lvs_Nome	 				= gf_Valida_Nulo(lvs_Nome, True, False)
lvs_Tipo_Cliente 			= gf_Valida_Nulo(lvs_Tipo_Cliente, True, False)
lvs_Fisica_Juridica			= gf_Valida_Nulo(lvs_Fisica_Juridica, True, False)
lvs_CPF 						= gf_Valida_Nulo(lvs_CPF, True, False)
lvs_RG			 	 		= gf_Valida_Nulo(lvs_RG, True, False)
lvs_Orgao_RG 		 		= gf_Valida_Nulo(lvs_Orgao_RG, True, False)
lvs_Uf_Emissor_RG		= gf_Valida_Nulo(lvs_Uf_Emissor_RG, True, False)
lvs_Nascimento 		 	= gf_Valida_Nulo(lvs_Nascimento, True, False)
lvs_Mae 			 			= gf_Valida_Nulo(lvs_Mae, True, False)
lvs_Sexo 			 		= gf_Valida_Nulo(lvs_Sexo, True, False)
lvs_Estado_Civil	 		= gf_Valida_Nulo(lvs_Estado_Civil, True, False)
lvs_Filhos			 		= gf_Valida_Nulo(lvs_Filhos, True, False)
lvs_Filho_1		 	 		= gf_Valida_Nulo(lvs_Filho_1, True, False)
lvs_Filho_2		 	 		= gf_Valida_Nulo(lvs_Filho_2, True, False)
lvs_Filho_3			 		= gf_Valida_Nulo(lvs_Filho_3, True, False)
lvs_Filho_4			 		= gf_Valida_Nulo(lvs_Filho_4, True, False)
lvs_Cidade			 		= gf_Valida_Nulo(lvs_Cidade, False, False)
lvs_Endereco		 		= gf_Valida_Nulo(lvs_Endereco, True, False)
lvs_Numero 					= gf_Valida_Nulo(lvs_Numero, True, False)
lvs_Complemento 			= gf_Valida_Nulo(lvs_Complemento, True, False)
lvs_Bairro		 			= gf_Valida_Nulo(lvs_Bairro, True, False)
lvs_CEP 						= gf_Valida_Nulo(lvs_CEP, True, False)
lvs_Tempo_Residencia	= gf_Valida_Nulo(lvs_Tempo_Residencia, True, False)
lvs_Tipo_Residencia	 	= gf_Valida_Nulo(lvs_Tipo_Residencia, True, False)
lvs_Email			 			= gf_Valida_Nulo(lvs_Email, True, False)
lvs_DDD_Res 				= gf_Valida_Nulo(lvs_DDD_Res, True, False)
lvs_Fone_Res				= gf_Valida_Nulo(lvs_Fone_Res, True, False)
lvs_DDD_Cel 				= gf_Valida_Nulo(lvs_DDD_Cel, True, False)
lvs_Fone_Cel 				= gf_Valida_Nulo(lvs_Fone_Cel, True, False)
lvs_DDD_Com 				= gf_Valida_Nulo(lvs_DDD_Com, True, False)
lvs_Fone_Com 				= gf_Valida_Nulo(lvs_Fone_Com, True, False)
lvs_DDD_Rec 				= gf_Valida_Nulo(lvs_DDD_Rec, True, False)
lvs_Fone_Rec 				= gf_Valida_Nulo(lvs_Fone_Rec, True, False)
lvs_Empresa 				= gf_Valida_Nulo(lvs_Empresa, True, False)
lvs_Profissao 				= gf_Valida_Nulo(lvs_Profissao, True, False)
lvs_Ocupacao 				= gf_Valida_Nulo(lvs_Ocupacao, True, False)
lvs_Tempo_Empresa 		= gf_Valida_Nulo(lvs_Tempo_Empresa, True, False)
lvs_Renda_Mensal 		= gf_Valida_Nulo(lvs_Renda_Mensal, False, False)
lvs_Uso_Continuo 			= gf_Valida_Nulo(lvs_Uso_Continuo, True, False)
lvs_Comunicacao 			= gf_Valida_Nulo(lvs_Comunicacao, True, False)
lvs_Dia_Vencimento 		= gf_Valida_Nulo(lvs_Dia_Vencimento, False, False)
lvs_Calculo_Credito 		= gf_Valida_Nulo(lvs_Calculo_Credito, True, False)
lvs_Filial_Calc_Credito 	= gf_Valida_Nulo(lvs_Filial_Calc_Credito, False, False)
lvs_Matric_Calc_Credito 	= gf_Valida_Nulo(lvs_Matric_Calc_Credito, True, False)
lvs_Credito_Calculado 		= gf_Valida_Nulo(lvs_Credito_Calculado, False, False)
lvs_Aprovacao_Credito 		= gf_Valida_Nulo(lvs_Aprovacao_Credito, True, False)
lvs_Filial_Aprov_Credito 		= gf_Valida_Nulo(lvs_Filial_Aprov_Credito, False, False)
lvs_Matric_Aprov_Credito 	= gf_Valida_Nulo(lvs_Matric_Aprov_Credito, True, False)
lvs_Credito_Aprovado 		= gf_Valida_Nulo(lvs_Credito_Aprovado, False, False)
lvs_Filial_Pendente 		= gf_Valida_Nulo(lvs_Filial_Pendente, False, False)
lvs_Filial_Centralizadora 	= gf_Valida_Nulo(lvs_Filial_Centralizadora, False, False)
lvs_Portador 				= gf_Valida_Nulo(lvs_Portador, False, False)
lvs_Filial_Inclusao 			= gf_Valida_Nulo(lvs_Filial_Inclusao, False, False)
lvs_Matricula_Inclusao	= gf_Valida_Nulo(lvs_Matricula_Inclusao, True, False)
lvs_Inclusao 				= gf_Valida_Nulo(lvs_Inclusao, True, False)
lvs_Filial_Atualizacao 		= gf_Valida_Nulo(lvs_Filial_Atualizacao, False, False)
lvs_Matricula_Atualizacao	= gf_Valida_Nulo(lvs_Matricula_Atualizacao, True, False)
lvs_Atualizacao 				= gf_Valida_Nulo(lvs_Atualizacao, True, False)
lvs_Pontos_Proxima_Compra 	= gf_Valida_Nulo(lvs_Pontos_Proxima_Compra, False, False)
lvs_Documentacao_Pendente 	= gf_Valida_Nulo(lvs_Documentacao_Pendente, True, False)
lvs_Conjuge 					= gf_Valida_Nulo(lvs_Conjuge, True, False)
lvs_Outra_Ocupacao 			= gf_Valida_Nulo(lvs_Outra_Ocupacao, True, False)
lvs_Empresa_Convenio 		= gf_Valida_Nulo(lvs_Empresa_Convenio, True, False)
lvs_Permite_Resgate_Dep 	= gf_Valida_Nulo(lvs_Permite_Resgate_Dep, True, False)
lvs_Razao_Social				= gf_Valida_Nulo(lvs_Razao_Social, True, False)
lvs_Inscricao_Estadual		= gf_Valida_Nulo(lvs_Inscricao_Estadual, True, False)
ls_Falecido						= gf_Valida_Nulo(ls_Falecido, True, False)
lvs_Grau_Instrucao 			= gf_Valida_Nulo(lvs_Grau_Instrucao, False, False)
lvs_Permite_Credito_Dep 	= gf_Valida_Nulo(lvs_Permite_Credito_Dep, True, False)
ls_Nome_Social				= gf_Valida_Nulo(ls_Nome_Social, True, False)

lvs_Email_Envio_Xml			= gf_Valida_Nulo(lvs_Email_Envio_Xml, True, True) // Este sempre deve ser o ultimo campo

uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao()

lvo_Conexao.of_Executa_Rotina("0006",{"Select 1 from cliente where cd_cliente = '" + as_Cliente + "'"})

If lvo_Conexao.of_Erro_Execucao() Or lvo_Conexao.of_Erro_Conexao() Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do cliente '" + as_Cliente + "'.")
Else
	If lvo_Conexao.of_Linhas() > 0 Then
		
		String lvs_Set
		String lvs_Where			
		
		lvs_Tabela	 = "cliente"
		
		lvs_Set		 =  " id_tipo_cliente="						+ lvs_Tipo_Cliente
		lvs_Set		 += " nm_cliente="							+ lvs_Nome
		lvs_Set		 += " nr_cpf_cgc="							+ lvs_CPF
		lvs_Set		 += " id_fisica_juridica="						+ lvs_Fisica_Juridica
		lvs_Set		 += " nr_rg="									+ lvs_RG
		lvs_Set		 += " de_orgao_emissor_rg="				+ lvs_Orgao_RG
		lvs_Set		 += " cd_uf_emissor_rg="					+ lvs_Uf_Emissor_RG
		lvs_Set		 += " dh_nascimento="						+ lvs_Nascimento
		lvs_Set		 += " nm_mae="								+ lvs_Mae
		lvs_Set		 += " id_sexo="								+ lvs_Sexo
		lvs_Set		 += " id_estado_civil="						+ lvs_Estado_Civil
		lvs_Set		 += " cd_cidade="								+ lvs_Cidade
		lvs_Set		 += " de_endereco="							+ lvs_Endereco
		lvs_Set		 += " nr_endereco="							+ lvs_Numero
		lvs_Set		 += " de_complemento="					+ lvs_Complemento
		lvs_Set		 += " de_bairro="								+ lvs_Bairro
		lvs_Set		 += " nr_cep="									+ lvs_CEP	
		lvs_Set		 += " de_endereco_email="					+ lvs_Email
		lvs_Set		 += " nr_ddd_fone_residencial="			+ lvs_DDD_Res
		lvs_Set		 += " nr_fone_residencial="					+ lvs_Fone_Res
		lvs_Set		 += " nr_ddd_celular=" 						+ lvs_DDD_Cel
		lvs_Set		 += " nr_celular="								+ lvs_Fone_Cel
		lvs_Set		 += " cd_filial_centralizadora="				+ lvs_Filial_Centralizadora
		lvs_Set		 += " cd_portador="							+ lvs_Portador
		lvs_Set		 += " id_autoriza_comunicacao="			+ lvs_Comunicacao
		lvs_Set		 += " cd_filial_atualizacao="				+ lvs_Filial_Atualizacao
		lvs_Set		 += " nr_matricula_atualizacao="			+ lvs_Matricula_Atualizacao
		lvs_Set		 += " dh_atualizacao="						+ lvs_Atualizacao
		lvs_Set		 += " nm_razao_social="					+ lvs_Razao_Social
		lvs_Set		 += " nr_inscricao_estadual="				+ lvs_Inscricao_Estadual
		lvs_Set		 += " nm_social="								+ ls_Nome_Social
		

		If lvds_1.Object.Id_Tipo_Cliente[1] = 'CC' Then // Clube Prazo - Pega valor direto da DW porque a vari$$HEX1$$e100$$ENDHEX$$vel j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ formatada para o distribuido
			lvs_Set		 += " id_tempo_residencia="				+ lvs_Tempo_Residencia
			lvs_Set		 += " id_tipo_residencia="					+ lvs_Tipo_Residencia
			lvs_Set		 += " nr_ddd_fone_comercial=" 			+ lvs_DDD_Com
			lvs_Set		 += " nr_fone_comercial="					+ lvs_Fone_Com
			lvs_Set		 += " nr_ddd_fone_recado="				+ lvs_DDD_Rec
			lvs_Set		 += " nr_fone_recado=" 						+ lvs_Fone_Rec
			lvs_Set		 += " nm_empresa="							+ lvs_Empresa			
			lvs_Set		 += " de_profissao="							+ lvs_Profissao
			lvs_Set		 += " id_natureza_ocupacao="				+ lvs_Ocupacao
			lvs_Set		 += " id_tempo_empresa="					+ lvs_Tempo_Empresa
			lvs_Set		 += " vl_renda_mensal=" 					+ lvs_Renda_Mensal		
			lvs_Set		 += " dh_calculo_credito="					+ lvs_Calculo_Credito
			lvs_Set		 += " cd_filial_calc_credito="				+ lvs_Filial_Calc_Credito
			lvs_Set		 += " nr_matric_calc_credito="				+ lvs_Matric_Calc_Credito
			lvs_Set		 += " dh_aprovacao_credito="				+ lvs_Aprovacao_Credito
			lvs_Set		 += " cd_filial_aprov_credito="				+ lvs_Filial_Aprov_Credito
			lvs_Set		 += " nr_matric_aprov_credito="			+ lvs_Matric_Aprov_Credito
			lvs_Set		 += " vl_limite_credito_calculado="		+ lvs_Credito_Calculado
			lvs_Set		 += " vl_limite_credito_aprovado="		+ lvs_Credito_Aprovado
			lvs_Set		 += " cd_filial_credito_pendente=" 		+ lvs_Filial_Pendente
			lvs_Set		 += " nr_dia_vencimento="					+ lvs_Dia_Vencimento
			lvs_Set		 += " id_documentacao_pendente="		+ lvs_Documentacao_Pendente
			lvs_Set		 += " nm_conjuge="							+ lvs_Conjuge
			lvs_Set		 += " de_natureza_ocupacao="			+ lvs_Outra_Ocupacao
			lvs_Set		 += " nm_empresa_convenio="			+ lvs_Empresa_Convenio
			lvs_Set		 += " id_permite_resgate_dependente="	+ lvs_Permite_Resgate_Dep
			lvs_Set	+= " id_permite_credito_dependente="		+ lvs_Permite_Credito_Dep
			lvs_Set	+= " cd_grau_instrucao="						+ lvs_Grau_Instrucao
		End If
		
		lvs_Set += " de_endereco_email_envio_xml="	+ lvs_Email_Envio_Xml
		
		lvs_Where	 = " cd_cliente = '"  + as_Cliente + "'"
				
		If Not lvo_Conexao.of_Update_Registro(lvs_Tabela, lvs_Set, lvs_Where, Ref lvl_Row) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no atualiza$$HEX2$$e700e300$$ENDHEX$$o do cliente '" + as_Cliente + "' na matriz.", Information!)
		Else
			lvb_Sucesso = True
		End If	
		
	Else			
		String lvs_Colunas
		String lvs_Values
		
		lvs_Tabela 	= 'cliente'
		
		// Carrega os campos basicos de qualquer cadastro
		lvs_Colunas  = 	'cd_cliente, id_tipo_cliente, id_fisica_juridica, nm_cliente, nr_cpf_cgc, nr_rg, ' + &
						'de_orgao_emissor_rg, cd_uf_emissor_rg, dh_nascimento, id_sexo, id_estado_civil, '  + &
						'cd_cidade, de_endereco, nr_endereco, de_complemento, de_bairro, nr_cep, ' + &
						'de_endereco_email, nr_ddd_fone_residencial, nr_fone_residencial, nr_ddd_celular, ' + &							
						'nr_celular, nr_ddd_fone_comercial, nr_fone_comercial, ' + &
						'cd_filial_centralizadora, cd_portador, id_autoriza_comunicacao, ' + &
						'cd_filial_inclusao, nr_matricula_inclusao, dh_inclusao, cd_filial_atualizacao, nr_matricula_atualizacao, ' + &
						'dh_atualizacao, nm_razao_social, nr_inscricao_estadual, nm_social, '
						
		lvs_Values	=	lvs_Cliente + lvs_Tipo_Cliente + lvs_Fisica_Juridica + lvs_Nome + lvs_CPF + lvs_RG + &
						lvs_Orgao_RG + lvs_Uf_Emissor_RG + lvs_Nascimento + lvs_Sexo + lvs_Estado_Civil + &
						lvs_Cidade 	+ lvs_Endereco + lvs_Numero + lvs_Complemento + lvs_Bairro + lvs_CEP + &
						lvs_Email + lvs_DDD_Res + lvs_Fone_Res + lvs_DDD_Cel + &
						lvs_Fone_Cel + lvs_DDD_Com + lvs_Fone_Com + &
						lvs_Filial_Centralizadora + lvs_Portador + lvs_Comunicacao + &
						lvs_Filial_Inclusao + lvs_Matricula_Inclusao + lvs_Inclusao + lvs_Filial_Atualizacao + lvs_Matricula_Atualizacao + &
						lvs_Atualizacao + lvs_Razao_Social + lvs_Inscricao_Estadual + ls_Nome_Social
						
			
		// Adiciona os campos de clube prazo
		If lvds_1.Object.Id_Tipo_Cliente[1] = 'CC' Then // Clube Prazo
			lvs_Colunas  += 'nr_dia_vencimento, nm_mae, id_tempo_residencia, id_tipo_residencia, nr_ddd_fone_recado, nr_fone_recado, ' + &
							'nm_empresa, de_profissao, id_natureza_ocupacao, id_tempo_empresa, vl_renda_mensal, dh_calculo_credito, ' + &
							'cd_filial_calc_credito, nr_matric_calc_credito, dh_aprovacao_credito, cd_filial_aprov_credito, ' + &
							'nr_matric_aprov_credito, vl_limite_credito_calculado, vl_limite_credito_aprovado, cd_filial_credito_pendente, ' + &							
							'id_documentacao_pendente, nm_conjuge, de_natureza_ocupacao, ' + &
							'nm_empresa_convenio, id_permite_resgate_dependente, id_permite_credito_dependente, cd_grau_instrucao, '
			
			lvs_Values	+=	lvs_Dia_Vencimento + lvs_Mae + lvs_Tempo_Residencia + lvs_Tipo_Residencia + lvs_DDD_Rec + lvs_Fone_Rec + &
							lvs_Empresa + lvs_Profissao + lvs_Ocupacao + lvs_Tempo_Empresa + lvs_Renda_Mensal + lvs_Calculo_Credito + &
							lvs_Filial_Calc_Credito + lvs_Matric_Calc_Credito + lvs_Aprovacao_Credito + lvs_Filial_Aprov_Credito + &
							lvs_Matric_Aprov_Credito + lvs_Credito_Calculado + lvs_Credito_Aprovado + lvs_Filial_Pendente + &
							lvs_Documentacao_Pendente + lvs_Conjuge + lvs_Outra_Ocupacao + &
							lvs_Empresa_Convenio + lvs_Permite_Resgate_Dep + lvs_Permite_Credito_Dep + lvs_Grau_Instrucao
		End If
		
		// Inclui o ultimo campo, sem virgula no final
		lvs_Colunas	+= 'de_endereco_email_envio_xml'
		lvs_Values	+= lvs_Email_Envio_Xml
						  
		lvo_Conexao.of_Insert_Registro(lvs_Tabela,lvs_Colunas,lvs_Values, Ref lvl_Row)
		
		If lvo_Conexao.of_Erro_Execucao() Or lvo_Conexao.of_Erro_Conexao() Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na inclus$$HEX1$$e300$$ENDHEX$$o do cliente '" + as_Cliente + "'.~r")
		End If

	End If
	
End If

Destroy(lvo_Conexao)
Destroy(lvds_1)
Return lvb_Sucesso
end function

public function boolean of_grava_dependente (string as_cliente);Boolean lvb_Sucesso = False

dc_uo_ds_Base lvds_1
lvds_1 = Create dc_uo_ds_Base

If Not lvds_1.of_ChangeDataObject("dw_ge077_gravacao_dependente") Then
	Destroy(lvds_1)
	Return False
End If

If lvds_1.Retrieve(as_Cliente) <= 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na recupera$$HEX2$$e700e300$$ENDHEX$$o dos dados para grava$$HEX2$$e700e300$$ENDHEX$$o dos dependentes do cliente no banco de dados da matriz.")
	Destroy(lvds_1)
	Return False	
End If

String lvs_Achou, &
		lvs_Codigo, &
		lvs_Cliente, &
		lvs_Nome, &
		lvs_Matricula_Atualizacao, &
		lvs_Parentesco, &
		lvs_Situacao
		 
DateTime lvdh_Atualizacao, &
         lvdh_Nascimento
		 
String lvs_Atualizacao, &
       lvs_Nascimento

Long lvl_Linha, &
     lvl_Filial_Atualizacao, &
	 lvl_Row
	 
String lvs_Tabela
String lvs_Set
String lvs_Where
String lvs_Colunas
String lvs_Values

uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao()

For lvl_Linha = 1 To lvds_1.RowCount()
	lvs_Cliente               			= lvds_1.Object.Cd_Cliente            			[lvl_Linha]
	lvs_Codigo                			= lvds_1.Object.Cd_Dependente_Cliente  	[lvl_Linha]
	lvs_Nome                  		= lvds_1.Object.Nm_Dependente          		[lvl_Linha]
	lvdh_Nascimento           		= lvds_1.Object.Dh_Nascimento           		[lvl_Linha]
	lvs_Parentesco            		= lvds_1.Object.Id_Grau_Parentesco      		[lvl_Linha]
	lvs_Situacao              		= lvds_1.Object.Id_Situacao             			[lvl_Linha]
	lvl_Filial_Atualizacao    		= lvds_1.Object.Cd_Filial_Atualizacao   		[lvl_Linha]
	lvs_Matricula_Atualizacao 	= lvds_1.Object.Nr_Matricula_Atualizacao	[lvl_Linha]	
	lvdh_Atualizacao          		= lvds_1.Object.Dh_Atualizacao          		[lvl_Linha]
	

	lvo_Conexao.of_Executa_Rotina("0114",{"'" + lvs_Codigo + "'"})
	
	If lvo_Conexao.of_Erro_Execucao() Or lvo_Conexao.of_Erro_Conexao() Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do dependente '" + lvs_Codigo + "'.")
		lvb_Sucesso = False
		Exit
	End If 

//	lvs_Nome					= gf_Valida_Nulo(lvs_Nome, True, False)
//	lvdh_Nascimento				= gf_Valida_Nulo(lvdh_Nascimento, True, False)   
//	lvs_Parentesco				= gf_Valida_Nulo(lvs_Parentesco, True, False)
//	lvs_Cliente					= gf_Valida_Nulo(lvs_Matricula_Atualizacao, True, False)
//	lvs_Situacao				= gf_Valida_Nulo(lvs_Situacao, True, False)
//	lvl_Filial_Atualizacao		= gf_Valida_Nulo(lvl_Filial_Atualizacao, False, False)
//	lvs_Atualizacao				= gf_Valida_Nulo(String(lvdh_Atualizacao, True, False)
//	lvs_Matricula_Atualizacao	= gf_Valida_Nulo(lvs_Matricula_Atualizacao, True, True)
	
		
	If lvo_Conexao.of_Linhas() = 0 Then
		lvs_Tabela 	= 'cliente_dependente'
			
		lvs_Colunas = 'cd_dependente_cliente, nm_dependente, dh_nascimento, id_grau_parentesco, cd_cliente, id_situacao, cd_filial_atualizacao, dh_atualizacao, nr_matricula_atualizacao'
		
		lvs_Values	= "'" + lvs_Codigo 		+ "',"	+ &
					  "'" + lvs_Nome 		+ "'," 	+ &
					  "'" + String(lvdh_Nascimento,'yyyy/mm/dd') + "'," + &
					  "'" + lvs_Parentesco  + "',"	+ &
					  "'" + lvs_Cliente 	+ "',"	+ &
					  "'" + lvs_Situacao 	+ "',"	+ &
					  String(lvl_Filial_Atualizacao)+ ","	+ &
					  "'" + String(lvdh_Atualizacao,'yyyy/mm/dd hh:mm:ss') + "'," + &
					  "'" + lvs_Matricula_Atualizacao 	+ "'"
						  
		If Not lvo_Conexao.of_Insert_Registro(lvs_Tabela,lvs_Colunas,lvs_Values, Ref lvl_Row) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na inclus$$HEX1$$e300$$ENDHEX$$o do dependente '" + lvs_Codigo + "'.")
			lvb_Sucesso = False
			Exit
		End If

		
	ElseIf lvo_Conexao.of_Linhas() > 0  Then
		lvs_Tabela = "cliente_dependente"
		
		lvs_Set	 = "nm_dependente				= '" + lvs_Nome + "',"
		lvs_Set	+= " dh_nascimento				= '" + String(lvdh_Nascimento,"yyyy/mm/dd") + "',"
		lvs_Set	+= " id_grau_parentesco			= '" + lvs_Parentesco + "',"
		lvs_Set	+= " id_situacao				= '" + lvs_Situacao + "',"
		lvs_Set	+= " cd_filial_atualizacao		=  " + String(lvl_Filial_Atualizacao) + ","
		lvs_Set	+= " dh_atualizacao				= '" + String(lvdh_Atualizacao,"yyyy/mm/dd hh:mm:ss") + "',"
		lvs_Set	+= " nr_matricula_atualizacao	= '" + lvs_Matricula_Atualizacao + "'"
	
		lvs_Where = "cd_dependente_cliente = '" + lvs_Codigo + "'"
		
		If Not lvo_Conexao.of_Update_Registro(lvs_Tabela, lvs_Set, lvs_Where, Ref lvl_Row) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do dependente '" + lvs_Codigo + "'.")
			lvb_Sucesso = False
			Exit
		End If	
	End If
Next

Destroy(lvds_1)
Destroy(lvo_Conexao)

Return lvb_Sucesso
end function

public function boolean of_bloqueia_cartao (string as_cartao, datetime adh_bloqueio, long al_filial, string as_matricula, long al_motivo);Boolean lvb_Sucesso = False

Long lvl_Row

String lvs_Tabela
String lvs_Set
String lvs_Where

uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao()
	
lvs_Tabela	 = "cartao_clube"

lvs_Set		 =  " dh_bloqueio						= '" + String(adh_Bloqueio,"yyyy/mm/dd hh:mm:ss")	+ "',"
lvs_Set		 += " cd_filial_bloqueio				=  " + String(al_Filial) 							+ " ,"
lvs_Set		 += " nr_matricula_bloqueio				= '" + as_Matricula						 			+ "',"
lvs_Set		 += " cd_motivo_bloqueio				=  " + String(al_Motivo)

lvs_Where	 = " nr_cartao_clube = '"  + as_Cartao + "'"
		
If Not lvo_Conexao.of_Update_Registro(lvs_Tabela, lvs_Set, lvs_Where, Ref lvl_Row) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no bloqueio do cart$$HEX1$$e300$$ENDHEX$$o do clube '" + as_Cartao + "'.", Information!)
Else
	lvb_Sucesso = True
End If	

Destroy(lvo_Conexao)

Return lvb_Sucesso
end function

public function boolean of_consulta_limite_credito_local (string as_codigo, decimal adc_credito);Boolean lvb_Sucesso = False
		
Select vl_limite_credito_aprovado Into :This.vl_limite_credito
From cliente
Where cd_cliente = :as_Codigo
Using SqlCa;
	
Choose Case SqlCa.SqlCode
	Case 0
		
		If IsNull(This.vl_limite_credito) Then This.vl_limite_credito = 00.000
		
		If This.vl_limite_credito = 000.00 Then			
			
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Cliente n$$HEX1$$e300$$ENDHEX$$o possui limite de cr$$HEX1$$e900$$ENDHEX$$dito",Exclamation!)
			
		Else			
			This.vl_limite_20 = This.vl_limite_credito + ( This.vl_limite_credito * 20 ) / 100							
			//Se a compra ultrapassou 20% do limite do cliente n$$HEX1$$e300$$ENDHEX$$o permite a venda, sen$$HEX1$$e300$$ENDHEX$$o solicita libera$$HEX2$$e700e300$$ENDHEX$$o para valor at$$HEX1$$e900$$ENDHEX$$ 20% maior que o limite.
			If This.vl_limite_20 < adc_credito Then
				
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Limite de cr$$HEX1$$e900$$ENDHEX$$dito insuficiente~n~n" + &
									 "Limite atual        : R$ " + String(This.vl_limite_credito,"###,##0.00") + "~n" + & 
									 "Valor Compra     : R$ " + String(adc_credito,"###,##0.00")+ "~n" + &
									 "Excesso             : R$ " + String(adc_credito - This.vl_limite_credito,"###,##0.00") ,Exclamation!)
		
			Else
				If This.vl_limite_credito < adc_credito And This.vl_limite_20 >= adc_credito Then
					
					If gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("LIBERACAO_LIMITE_CREDITO", Ref nr_matric_liberacao_restricao) Then
						lvb_Sucesso = True
					Else
						lvb_Sucesso = False
					End If				
		
				Else
					lvb_Sucesso = True
				End If
			End If						
		End If		

			
	Case 100

		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Limite de Cr$$HEX1$$e900$$ENDHEX$$dito do cliente '" + as_Codigo + "' n$$HEX1$$e300$$ENDHEX$$o localizado.",StopSign!)
		
	Case -1
		
		Sqlca.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do limite de cr$$HEX1$$e900$$ENDHEX$$dito do cliente '" + as_Codigo + "'")
		
End Choose
	
Return lvb_Sucesso
end function

public function boolean of_inclui_precadastro_cliente (string as_cliente);//Boolean lvb_Sucesso = False
//
//Blob lvb_Blob
//
//String lvs_Mensagem
//
//dc_uo_ds_Base lvds_1
//lvds_1 = Create dc_uo_ds_Base
//
//If Not lvds_1.of_ChangeDataObject("dw_ge077_precadastro_cliente") Then
//	Destroy(lvds_1)
//	Return False
//End If
//
//If lvds_1.Retrieve(as_Cliente) <= 0 Then
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na recupera$$HEX2$$e700e300$$ENDHEX$$o dos dados para inclus$$HEX1$$e300$$ENDHEX$$o do pr$$HEX1$$e900$$ENDHEX$$-cadastro do cliente no banco de dados da matriz.")
//	Destroy(lvds_1)
//	Return False	
//End If
//
//uo_SD_Cliente_Central lvo_Cliente
//
//If This.ivo_Conexao.CreateInstance(lvo_Cliente, "uo_sd_cliente_central") <> 0 Then
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na cria$$HEX2$$e700e300$$ENDHEX$$o do objeto remoto 'UO_SD_CLIENTE_CENTRAL'.", StopSign!)
//Else
//	If lvds_1.GetFullState(lvb_Blob) = -1 Then
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'GetFullState' do cliente.", StopSign!)
//	Else
//		lvb_Sucesso = lvo_Cliente.of_Inclui_PreCadastro_Cliente(ref lvb_Blob, ref lvs_Mensagem)
//		
//		If Not lvb_Sucesso Then
//			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvs_Mensagem, Information!)
//		End If	
//	End If
//	
//	Destroy(lvo_Cliente)	
//End If
//
//Destroy(lvds_1)
//
//Return lvb_Sucesso

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Fun$$HEX2$$e700e300$$ENDHEX$$o desabilitada.~r~rFavor informar ao CPD.")

Return True
end function

public function boolean of_limite_credito_calculado (long al_filial, decimal adc_renda, integer ai_idade, string as_tempo_residencia, string as_tipo_residencia, string as_tempo_empresa, string as_estado_civil, string as_ocupacao, ref decimal adc_limite);Boolean lvb_Sucesso = False

Long lvl_Pontos_Filial

uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao()

lvo_Conexao.of_Define_Variaveis(True)

lvo_Conexao.of_ConverteVirgula(True)

lvo_Conexao.of_Executa_Rotina("0037",{String(al_Filial)})

If lvo_Conexao.of_Erro_Execucao() Or lvo_Conexao.of_Erro_Conexao() Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o da filial '" + String(al_Filial) + "' para verificar os pontos para o c$$HEX1$$e100$$ENDHEX$$lculo do limite de cr$$HEX1$$e900$$ENDHEX$$dito.")
Else
	If lvo_Conexao.of_Linhas() = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Filial '" + String(al_Filial) + "' n$$HEX1$$e300$$ENDHEX$$o localizada para verificar os pontos para o c$$HEX1$$e100$$ENDHEX$$lculo do limite de cr$$HEX1$$e900$$ENDHEX$$dito.")
	Else
		If lvo_Conexao.of_Retorno("qt_pontos_limite_credito", Ref lvl_Pontos_Filial) Then
			lvb_Sucesso = True
			
			adc_Limite = gf_Limite_Credito_Calculado(adc_Renda, &
													  ai_Idade, &
													  as_Tempo_Residencia, &
													  as_Tipo_Residencia, &
													  as_Tempo_Empresa, &
													  as_Estado_Civil, &
													  as_Ocupacao, &
													  lvl_Pontos_Filial)
		End If
	End If
End If

Destroy(lvo_Conexao)

Return lvb_Sucesso
end function

public function boolean of_inclui_movto_credito_online (string as_cliente, long al_filial, date adt_movto, integer ai_tipo, decimal adc_valor, string as_documento);Boolean lvb_Sucesso = False

String lvs_Mensagem

Long	lvl_Row

String	lvs_Tabela
String	lvs_Colunas
String	lvs_Values

uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao()
	
lvs_Tabela  = "movimento_credito_online"

lvs_Colunas = "cd_cliente, cd_filial, dh_movimento, id_tipo_movimento, vl_movimento, nr_documento"

// Verifica se o Cliente $$HEX1$$e900$$ENDHEX$$ nulo
If IsNull(as_Cliente) Or Trim(as_Cliente) = "" Then
	as_Cliente = "null,"
Else
	as_Cliente = "'" + as_Cliente + "',"
End If

// Verifica se o Documento $$HEX1$$e900$$ENDHEX$$ nulo
If IsNull(as_Documento) Or Trim(as_Documento) = "" Then
	as_Documento = "null"
Else
	as_Documento = "'" + as_Documento + "'"
End If

lvs_Values  = as_Cliente
lvs_Values += String(al_Filial)							+ " ,"
lvs_Values += "'" + String(adt_Movto,"YYYYMMDD")		+ "',"
lvs_Values += String(ai_Tipo)							+ " ,"
lvs_Values += gf_Replace(String(adc_Valor),",",".",0)	+ " ,"
lvs_Values += as_Documento

lvo_Conexao.of_Insert_Registro(lvs_Tabela,lvs_Colunas,lvs_Values, Ref lvl_Row)

If lvl_Row <= 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na inclus$$HEX1$$e300$$ENDHEX$$o do movimento de cr$$HEX1$$e900$$ENDHEX$$dito online.", Information!)
Else
	lvb_Sucesso = True
End If

Destroy(lvo_Conexao)

Return lvb_Sucesso
end function

public function boolean of_consulta_limite_credito_central (string as_codigo, decimal adc_credito);Boolean lvb_Sucesso = False

Decimal lvdc_Vendas, &
		  lvdc_Titulos, &
		  lvdc_Outros, &
		  lvdc_OnLine

	If Not This.of_Limite_Credito_Cliente(as_Codigo, &
													  ref This.vl_limite_credito, &
													  ref This.limite_localizado) Then
		Return False
	End If

	If Not This.Limite_Localizado Then
		lvb_Sucesso = True
	Else
		If Not This.of_Consulta_Contas_Receber(as_Codigo, &
															ref lvdc_Vendas, &
															ref lvdc_Titulos, &
															ref lvdc_Outros) Then
			Return False
		End If

		If Not This.of_Saldo_OnLine_Aberto(as_Codigo, &
													  lvdc_OnLine) Then
			Return False
		End If
		
		This.vl_Limite_Credito_Utilizado = lvdc_Vendas + lvdc_Titulos - lvdc_Outros + lvdc_OnLine
		This.vl_Limite_Credito_Saldo     = This.vl_Limite_Credito - This.vl_Limite_Credito_Utilizado
		
//		If This.vl_Limite_Credito_Utilizado < 0 Then
//			This.vl_Limite_Credito_Saldo = This.vl_Limite_Credito_Utilizado - This.vl_Limite_Credito
//		Else
//			This.vl_Limite_Credito_Saldo     = This.vl_Limite_Credito - This.vl_Limite_Credito_Utilizado
//		End If

		If This.vl_limite_credito = 000.00 Then			
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Cliente n$$HEX1$$e300$$ENDHEX$$o possui limite de cr$$HEX1$$e900$$ENDHEX$$dito",Exclamation!)
			lvb_Sucesso = False			
		Else			
			This.vl_limite_20 = ( This.vl_limite_credito * 20 ) / 100			
			//Se a compra ultrapassou 20% do limite do cliente n$$HEX1$$e300$$ENDHEX$$o permite a venda, sen$$HEX1$$e300$$ENDHEX$$o solicita libera$$HEX2$$e700e300$$ENDHEX$$o para valor at$$HEX1$$e900$$ENDHEX$$ 20% maior que o limite.			
			If ( Round(This.vl_limite_20 + This.vl_limite_credito_saldo,2) ) < adc_credito Then									
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Limite de cr$$HEX1$$e900$$ENDHEX$$dito insuficiente~n~n" + &
									 "Limite atual        : R$ " + String(This.vl_limite_credito,"###,##0.00") + "~n" + & 
									 "Limite utilizado   : R$ " + String(This.vl_limite_credito_utilizado,"###,##0.00") + "~n" + & 
									 "Saldo dispon$$HEX1$$ed00$$ENDHEX$$vel : R$ " + String(This.vl_limite_credito_saldo,"###,##0.00") + "~n" + &
									 "Valor Compra     : R$ " + String(adc_credito,"###,##0.00")+ "~n" + &
									 "Excesso             : R$ " + String(adc_credito - This.vl_limite_credito_saldo,"###,##0.00") ,Exclamation!)
	
				lvb_Sucesso = False								 
			Else
				If This.vl_limite_credito_saldo < adc_credito And &
					( This.vl_limite_20 + This.vl_limite_credito_saldo ) >= adc_credito Then				
					
					If gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("LIBERACAO_LIMITE_CREDITO", Ref nr_matric_liberacao_restricao) Then
						lvb_Sucesso = True
					Else
						lvb_Sucesso = False
					End If
					
				Else				
					lvb_Sucesso = True
				End If
			End If	
		End If			
	End If
	
Return lvb_Sucesso
end function

public function boolean of_consulta_limite_credito_cliente (string as_codigo, decimal adc_credito);//Consultas remota matriz
Boolean lb_Sucesso

Open(w_Aguarde)
w_Aguarde.Title = "Consultando Limite de Cr$$HEX1$$e900$$ENDHEX$$dito do Cliente na Matriz..."

lb_Sucesso = This.of_consulta_limite_credito_central(as_codigo, adc_credito)
	
Close(w_Aguarde)

If Not This.Limite_Localizado Then
	
	lb_Sucesso = This.of_consulta_limite_credito_local(as_codigo, adc_credito)
		
End If

Return lb_Sucesso
end function

public function boolean of_localiza_cliente_cpf (string as_cpf);Boolean 	lvb_Sucesso = False, &
        	lvb_Tipo_Correto
			  
uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao()

lvo_Conexao.of_Define_Variaveis(True)

lvo_Conexao.of_Executa_Rotina('0115',{"'" + as_Cpf + "'"})

If Not lvo_Conexao.of_Erro_Execucao() Then
	If lvo_Conexao.of_Linhas() > 0 Then
		If lvo_Conexao.of_Retorno('cd_cliente', Ref This.cd_Cliente) Then
			If lvo_Conexao.of_Retorno('nm_cliente', Ref This.nm_Cliente) Then
				If lvo_Conexao.of_Retorno('id_tipo_cliente', Ref This.id_Tipo_Cliente) Then
					If lvo_Conexao.of_Retorno('id_permite_resgate_dependente', Ref This.ivb_Permite_Resgate_Dependente) Then
						If lvo_Conexao.of_Retorno('id_permite_credito_dependente', Ref This.ivb_Permite_Credito_Dependente) Then
							If lvo_Conexao.of_Retorno('de_senha_venda_credito', Ref This.de_Senha_Cliente) Then
								If lvo_Conexao.of_Retorno('nr_cartao_clube', Ref This.nr_Cartao_Clube) Then
									If lvo_Conexao.of_Retorno('nr_cpf_cgc', Ref This.nr_cpf) Then
										If lvo_Conexao.of_Retorno('id_fisica_juridica', Ref This.id_fisica_juridica) Then										
											If lvo_Conexao.of_Retorno('nr_dia_vencimento', Ref This.nr_dia_vencimento) Then
												If lvo_Conexao.of_Retorno('de_hash_senha', Ref This.de_hash_senha) Then
													lvb_Sucesso = True						
													lvb_Tipo_Correto = True
													
													// Verifica o tipo do cliente selecionado
													If This.ivs_Tipo_Cliente <> "" Then
														Choose Case This.ivs_Tipo_Cliente
															Case "CR", "RC", "CC"
																If This.Id_Tipo_Cliente <> This.ivs_Tipo_Cliente Then						
																	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tipo do cliente '" + This.Id_Tipo_Cliente + "' diferente do determinado '" + This.ivs_Tipo_Cliente + "'.", Information!)
																	lvb_Tipo_Correto = False
																End If
																
															Case "CL"
																If This.Id_Tipo_Cliente <> "RC" and This.Id_Tipo_Cliente <> "CC" Then						
																	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tipo do cliente '" + This.Id_Tipo_Cliente + "' diferente do determinado '" + This.ivs_Tipo_Cliente + "'.", Information!)
																	lvb_Tipo_Correto = False
																End If					
														End Choose
													End If
													
													If Not lvb_Tipo_Correto Then
														SetNull(This.Cd_Cliente)
														SetNull(Nm_Cliente)
														SetNull(Id_Tipo_Cliente)
														SetNull(Nr_cpf)
														SetNull(Id_Fisica_Juridica)
														SetNull(Nr_dia_vencimento)
													End If
													
													
													SetNull(This.Cd_Dependente)
													SetNull(This.Nm_Dependente)				
													
													This.Cartao_Bloqueado = False
												End If
											End If																				
										End If
									End If
								End If
							End If
						End If
					End If				
				End If			
			End If
		End If
	End If
Else
	lvo_Conexao.of_MsgError("Localiza$$HEX2$$e700e300$$ENDHEX$$o cliente CPF")
End If

Destroy(lvo_Conexao)
	
Return lvb_Sucesso
end function

public function boolean of_localiza_cliente (string as_parametro, string as_identificador);Boolean lvb_Sucesso = False

Integer lvi_Tamanho

This.Cartao_Bloqueado = False

as_Parametro = Trim(as_Parametro)

lvi_Tamanho = LenA(as_Parametro)

If lvi_Tamanho > 0 Then

	If IsNumber(as_Parametro) Then
		
		If as_identificador = 'CC' Then
			lvb_Sucesso = This.of_Localiza_Cliente_Cartao(as_Parametro)
			Return lvb_Sucesso
		End If
		
		If as_identificador = 'CPF' Then
			lvb_Sucesso = This.of_Localiza_Cliente_CPF(as_Parametro)
			Return lvb_Sucesso
		End If
		
		If as_identificador = 'RG' Then
			lvb_Sucesso = This.of_Localiza_Cliente_RG(as_Parametro)
			Return lvb_Sucesso
		End If		
						
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe um par$$HEX1$$e200$$ENDHEX$$metro de localiza$$HEX2$$e700e300$$ENDHEX$$o correto.",Exclamation!)
	End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe um par$$HEX1$$e200$$ENDHEX$$metro de localiza$$HEX2$$e700e300$$ENDHEX$$o correto.",Exclamation!)
End If

Return lvb_Sucesso
end function

public function boolean of_localiza_cliente_rg (string as_rg);Boolean 	lvb_Sucesso = False
			  
uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao()

lvo_Conexao.of_Define_Variaveis(True)

lvo_Conexao.of_Executa_Rotina('0117',{"'" + as_rg + "'"})

If Not lvo_Conexao.of_Erro_Execucao() Then
	If lvo_Conexao.of_Linhas() > 0 Then
		If lvo_Conexao.of_Retorno('cd_cliente', Ref This.cd_Cliente) Then
			If lvo_Conexao.of_Retorno('nm_cliente', Ref This.nm_Cliente) Then
				If lvo_Conexao.of_Retorno('id_tipo_cliente', Ref This.id_Tipo_Cliente) Then
					If lvo_Conexao.of_Retorno('id_permite_resgate_dependente', Ref This.ivb_Permite_Resgate_Dependente) Then
						If lvo_Conexao.of_Retorno('id_permite_credito_dependente', Ref This.ivb_Permite_Credito_Dependente) Then
							If lvo_Conexao.of_Retorno('de_senha_venda_credito', Ref This.de_Senha_Cliente) Then
								If lvo_Conexao.of_Retorno('nr_cartao_clube', Ref This.nr_Cartao_Clube) Then
									If lvo_Conexao.of_Retorno('nr_cpf_cgc', Ref This.nr_cpf) Then
										If lvo_Conexao.of_Retorno('de_hash_senha', Ref This.de_hash_senha) Then
											lvb_Sucesso = True
											
											SetNull(This.nm_Dependente)
											SetNull(This.cd_Dependente)
										End If
									End If
								End If
							End If
						End If
					End If				
				End If			
			End If
		End If
	End If
Else
	lvo_Conexao.of_MsgError("Localiza$$HEX2$$e700e300$$ENDHEX$$o cliente RG")
End If

Destroy(lvo_Conexao)
	
Return lvb_Sucesso











//Boolean lvb_Sucesso, &
//        lvb_Tipo_Correto
//
//String lvs_Mensagem
//
//uo_SD_Cliente_Central lvo_Cliente
//
//If This.ivo_Conexao.CreateInstance(lvo_Cliente, "uo_sd_cliente_central") <> 0 Then
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na cria$$HEX2$$e700e300$$ENDHEX$$o do objeto remoto 'UO_SD_CLIENTE_CENTRAL'.", StopSign!)
//Else
//	lvb_Sucesso = lvo_Cliente.of_Localiza_Cliente_rg(as_rg, &
//	                                                             ref This.Cd_Cliente,&
//																 ref This.Nm_Cliente, &
//																 ref This.Id_Tipo_Cliente, &
//																 ref This.ivb_Permite_Resgate_Dependente, &
//																 ref This.ivb_Permite_Credito_Dependente, &
//																 ref This.De_Senha_Cliente,&
//															     ref lvs_Mensagem)
//	
//	If lvb_Sucesso Then
//		lvb_Tipo_Correto = True
//		
//		// Verifica o tipo do cliente selecionado
//		If This.ivs_Tipo_Cliente <> "" Then
//			Choose Case This.ivs_Tipo_Cliente
//				Case "CR", "RC", "CC"
//					If This.Id_Tipo_Cliente <> This.ivs_Tipo_Cliente Then						
//						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tipo do cliente '" + This.Id_Tipo_Cliente + "' diferente do determinado '" + This.ivs_Tipo_Cliente + "'.", Information!)
//						lvb_Tipo_Correto = False
//					End If
//					
//				Case "CL"
//					If This.Id_Tipo_Cliente <> "RC" and This.Id_Tipo_Cliente <> "CC" Then						
//						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tipo do cliente '" + This.Id_Tipo_Cliente + "' diferente do determinado '" + This.ivs_Tipo_Cliente + "'.", Information!)
//						lvb_Tipo_Correto = False
//					End If					
//			End Choose
//		End If
//		
//		If Not lvb_Tipo_Correto Then
//			SetNull(This.Cd_Cliente)
//			Nm_Cliente = ""
//			Id_Tipo_Cliente = ""
//		End If
//		
//		SetNull(This.Nr_Cartao_Clube)
//		SetNull(This.Cd_Dependente)
//		
//		This.Nm_Dependente = ""
//		
//		This.Cartao_Bloqueado = False
//	End If
//	
//	If lvs_Mensagem <> "" Then
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvs_Mensagem, Information!)
//	End If
//	
//	Destroy(lvo_Cliente)
//End If	
//	
//Return lvb_Sucesso
end function

public function boolean of_localiza_cliente (string as_parametro);Boolean lvb_Sucesso = False

Integer lvi_Tamanho

This.Cartao_Bloqueado = False

as_Parametro = Trim(as_Parametro)

lvi_Tamanho = LenA(as_Parametro)

If lvi_Tamanho > 0 Then
	If IsNumber(as_Parametro) Then
		If lvi_Tamanho = 14 Then
			as_Parametro = LeftA(as_Parametro, 13)
			lvi_Tamanho = 13
		End If
		
		// Se o tamanho for 12, quer dizer que a leitura foi feita pelo leitor $$HEX1$$f300$$ENDHEX$$ptico
		// O $$HEX1$$fa00$$ENDHEX$$ltimo n$$HEX1$$fa00$$ENDHEX$$mero ser$$HEX1$$e100$$ENDHEX$$ desconsiderado na procura
		If lvi_Tamanho = 12 Then
			as_Parametro = LeftA(as_Parametro, 11)
			lvi_Tamanho = 11
		End If
		
		If lvi_Tamanho = 11 Then
			lvb_Sucesso = This.of_Localiza_Cliente_Codigo(as_Parametro)
		End If
		
		If lvi_Tamanho = 13 Then
			lvb_Sucesso = This.of_Localiza_Cliente_Cartao(as_Parametro)
		End If
		
		If Not lvb_Sucesso Then
			lvb_Sucesso = This.of_Localiza_Cliente_Generica("")
		End If
	Else
		lvb_Sucesso = This.of_Localiza_Cliente_Generica(as_Parametro)
	End If
Else
	lvb_Sucesso = This.of_Localiza_Cliente_Generica("")
End If

Return lvb_Sucesso
end function

public function boolean of_inclui_recibo_resgate (string as_cliente, string as_dependente, string as_cartao, decimal adc_total_pontos, long al_filial, string as_matricula, long al_produto[], long al_qtde[], decimal adc_pontos[], long al_vale[], ref long al_recibo);//Boolean lvb_Sucesso = False
//
//String lvs_Mensagem
//
//uo_SD_Cliente_Central lvo_Cliente
//
//If This.ivo_Conexao.CreateInstance(lvo_Cliente, "uo_sd_cliente_central") <> 0 Then
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na cria$$HEX2$$e700e300$$ENDHEX$$o do objeto remoto 'UO_SD_CLIENTE_CENTRAL'.", StopSign!)
//Else
//	lvb_Sucesso = lvo_Cliente.of_Inclui_Recibo_Resgate(as_Cliente, &
//													   as_Dependente, &
//													   as_Cartao, &
//													   adc_Total_Pontos, &
//													   al_Filial, &
//													   as_Matricula, &
//													   al_Produto, &
//													   al_Qtde, &
//													   adc_Pontos, &
//													   al_Vale, &
//													   ref al_Recibo, &
//													   ref lvs_Mensagem)
//	
//	If lvs_Mensagem <> "" Then
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvs_Mensagem, Information!)
//	End If
//	
//	Destroy(lvo_Cliente)
//End If	
//	
//Return lvb_Sucesso

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Fun$$HEX2$$e700e300$$ENDHEX$$o desabilitada.~r~rFavor informar ao CPD.")

Return True
end function

public function boolean of_cancela_recibo_resgate_clube (string as_matricula_cancelamento, long al_recibo_resgate, ref long al_produto[], ref integer ai_qtde_produto[]);Boolean lvb_Sucesso = False
//
//String lvs_Mensagem
//
//uo_SD_Cliente_Central lvo_Cliente
//
//If This.ivo_Conexao.CreateInstance(lvo_Cliente, "uo_sd_cliente_central") <> 0 Then
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na cria$$HEX2$$e700e300$$ENDHEX$$o do objeto remoto 'UO_SD_CLIENTE_CENTRAL'.", StopSign!)
//Else
//	lvb_Sucesso = lvo_Cliente.of_Cancela_Recibo_Resgate_Clube(as_Matricula_Cancelamento,&
//															  al_Recibo_Resgate,&
//															  al_Produto[],&
//															  ai_Qtde_Produto[],&
//															  ref lvs_Mensagem)
//	
//	If lvs_Mensagem <> "" Then
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvs_Mensagem, Information!)
//	End If
//	
//	Destroy(lvo_Cliente)
//End If	
//	
//Return lvb_Sucesso

//--- SD Novo

//Boolean lvb_Sucesso = False

String lvs_Cliente,&
	   lvs_Cartao_Clube,&
	   lvs_Cliente_Dependente

String lvs_Cartao_Smiles

Decimal lvdc_Pontos

Long lvl_Filial

DateTime lvdh_Cancelamento
  
uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao()

lvo_Conexao.of_ConverteVirgula(True)

lvo_Conexao.of_Define_Variaveis(True)

lvo_Conexao.of_Executa_Rotina("0033", {String(al_recibo_resgate)})

If lvo_Conexao.of_Erro_Execucao() Or lvo_Conexao.of_Erro_Conexao() Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na conex$$HEX1$$e300$$ENDHEX$$o com o servidor distribu$$HEX1$$ed00$$ENDHEX$$do.")
	lvb_Sucesso = False
Else
	If lvo_Conexao.of_Linhas() > 0 Then		
		If lvo_Conexao.of_Retorno("cd_cliente", Ref lvs_Cliente) Then
			If lvo_Conexao.of_Retorno("qt_pontos", Ref lvdc_Pontos) Then
				If lvo_Conexao.of_Retorno("cd_filial", Ref lvl_Filial) Then
					If lvo_Conexao.of_Retorno("nr_cartao_clube", Ref lvs_Cartao_Clube) Then
						If lvo_Conexao.of_Retorno("cd_dependente_cliente", Ref lvs_Cliente_Dependente) Then
							If lvo_Conexao.of_Retorno("dh_cancelamento", Ref lvdh_Cancelamento) Then
								If lvo_Conexao.of_Retorno("nr_cartao_smiles", Ref lvs_Cartao_Smiles) Then
								
									If Not IsNull(lvdh_Cancelamento) Then
										MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O recibo de resgate '" + String(al_Recibo_Resgate) +&
													  "' j$$HEX1$$e100$$ENDHEX$$ foi cancelado em '" + String(lvdh_Cancelamento, "dd/mm/yyyy") + "'.")
									Else									
										Long lvl_Row
	
										String lvs_Tabela
										String lvs_Set
										String lvs_Where
										
										as_matricula_cancelamento = gf_Valida_Nulo(as_matricula_cancelamento,True,True)
																				
										lvs_Tabela	 = "recibo_resgate_clube"
										
										//lvs_Set		 =  " dh_cancelamento						= '" + String(Today(),"yyyy/mm/dd hh:mm:dd") + "',"
										lvs_Set		 =  " dh_cancelamento						= GetDate(),"
										lvs_Set		 += " nr_matricula_cancelamento				=  " + as_matricula_cancelamento
										
										If Not IsNull(lvs_Cartao_Smiles) Or lvs_Cartao_Smiles <> "" Then
											lvs_Set += ", id_situacao_resgate = 'X' " 											
										End If
										
										lvs_Where	 = " nr_recibo_resgate = "  + String(al_Recibo_Resgate)
										
										If Not lvo_Conexao.of_Update_Registro(lvs_Tabela, lvs_Set, lvs_Where, Ref lvl_Row) Then
											MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao cancelar o recibo de resgate '" + String(al_Recibo_Resgate) + "'.", Information!)
										Else										
											//---- Fun$$HEX2$$e700e300$$ENDHEX$$o no SD antigo
											If This.of_Inclui_Movto_Resgate_Clube(lvs_Cliente,&
																					lvdc_Pontos,&
																				  lvl_Filial,&
																				  lvs_Cartao_Clube,&
																				  lvs_Cliente_Dependente,&
																				  al_Recibo_Resgate) Then 
												lvb_Sucesso = This.of_Carrega_Produto_Recibo_Resgate(al_Recibo_Resgate,&
																									 	Ref al_produto[],&
																										Ref ai_Qtde_Produto[])
											End If
	
	
										End If	
										
									End If
								End If
							End If
						End If
					End If
				End If
			End If
		End If	
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Recibo de resgate '" + String(al_Recibo_Resgate) + "' n$$HEX1$$e300$$ENDHEX$$o localizado.")
	End If
End If

Destroy(lvo_Conexao)

Return lvb_Sucesso
end function

public function boolean of_inclui_recibo_resgate (string as_cliente, string as_dependente, string as_cartao, decimal adc_total_pontos, long al_filial, string as_matricula, long al_produto[], long al_qtde[], decimal adc_pontos[], string as_utiliza_vale_resgate[], ref long al_recibo);String ls_Nulo

SetNull( ls_Nulo )

Return This.of_Inclui_Recibo_Resgate(as_cliente, &
												as_dependente, &
												as_cartao, &
												adc_total_pontos, &
												al_filial, &
												as_matricula, &
												al_produto, &
												al_qtde, &
												adc_pontos, &
												as_utiliza_vale_resgate, &
												ls_Nulo, &
												ref al_recibo)
end function

public subroutine of_esconde_informacoes_vale (ref datastore avds_1);avds_1.Object.st_logotipo.visible       = False
avds_1.Object.st_linha.visible          = False
avds_1.Object.st_corte_aqui.visible     = False
avds_1.Object.st_data_cabecalho.visible = False
avds_1.Object.st_cabecalho.visible      = False
avds_1.Object.st_vale_resgate.visible   = False
avds_1.Object.st_nm_produto.visible     = False
avds_1.Object.st_produto.visible        = False
avds_1.Object.st_nm_filial.visible      = False
avds_1.Object.st_filial.visible         = False
avds_1.Object.st_nm_data.visible        = False
avds_1.Object.st_dh_resgate.visible     = False
avds_1.Object.st_mensagem1.visible      = False
avds_1.Object.st_mensagem2.visible      = False
avds_1.Object.st_mensagem3.visible      = False
avds_1.Object.st_mensagem4.visible      = False
avds_1.Object.st_mensagem5.visible      = False
avds_1.Object.st_mensagem6.visible      = False

avds_1.Object.st_nm_responsavel.visible = False
avds_1.Object.st_responsavel.visible    = False
avds_1.Object.st_traco1.visible         = False
avds_1.Object.st_traco2.visible         = False
avds_1.Object.st_traco3.visible         = False
avds_1.Object.st_traco4.visible         = False
avds_1.Object.st_traco5.visible         = False
avds_1.Object.st_traco6.visible         = False
avds_1.Object.st_traco7.visible         = False
avds_1.Object.st_traco8.visible         = False
avds_1.Object.st_carimbo.visible        = False
avds_1.Object.st_marcacao1.visible      = False
avds_1.Object.st_marcacao2.visible      = False
avds_1.Object.st_marcacao3.visible      = False
avds_1.Object.st_marcacao4.visible      = False



end subroutine

public function boolean of_imprime_recibo_resgate (long al_recibo, string as_matricula_reimpressao);String ls_Nulo
Long 	ll_Nulo

SetNull( ls_Nulo )
SetNull( ll_Nulo )

Return This.of_imprime_recibo_resgate(al_recibo, &
													as_matricula_reimpressao, &
													ls_Nulo, &
													ll_Nulo)
end function

public function boolean of_saldo_pontuacao_vencendo (date adt_vencimento, string as_cliente, ref decimal adc_pontos);Boolean lvb_Sucesso = False

String lvs_Mensagem

uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao()

lvo_Conexao.of_ConverteVirgula(True)

lvo_Conexao.of_Define_Variaveis(True)

lvo_Conexao.of_Executa_Rotina("0030",{"'" + String(adt_Vencimento,"yyyymmdd") + "'", "'" + as_Cliente + "'"})

If (lvo_Conexao.of_Erro_Execucao() Or lvo_Conexao.of_Erro_Conexao()) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do saldo de pontos do cliente que est$$HEX1$$e300$$ENDHEX$$o para vencer '" + as_Cliente + &
						 "' no m$$HEX1$$ea00$$ENDHEX$$s '" + String(adt_Vencimento, "mm/yyyy") + "'.")
	adc_Pontos	= 0
	lvb_Sucesso = False
Else
	If lvo_Conexao.of_Linhas() > 0 Then
		If lvo_Conexao.of_Retorno("qt_pontos_vencidos", Ref adc_Pontos) Then
			If IsNull(adc_Pontos) Then
				adc_Pontos = 0
			End If				
			lvb_Sucesso = True
			
		End If
	Else
		lvb_Sucesso = True
		adc_Pontos = 0
	End If
	
End If	
Destroy(lvo_Conexao)

Return lvb_Sucesso
end function

public function boolean of_atualiza_pedido_ecommerce (long al_pedido, string as_matricula, string as_situacao);Boolean lvb_Sucesso = False

DateTime ldh_ServerDate

Long lvl_Row

String lvs_Tabela
String lvs_Set
String lvs_Where

uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao()

ldh_ServerDate = gf_GetServerDate( )
	
lvs_Tabela	 = "pedido_ecommerce"

lvs_Set		 =  " id_situacao						= '" + as_Situacao							 + "',"
lvs_Set		 += " dh_alteracao_situacao				= '" + String(Today(),"yyyy/mm/dd hh:mm:dd") + "',"
lvs_Set		 += " nr_matric_alteracao_situacao		= '"  + as_Matricula						 + "'"

lvs_Where	 = " nr_pedido = "  + String(al_Pedido)
		
If Not lvo_Conexao.of_Update_Registro(lvs_Tabela, lvs_Set, lvs_Where, Ref lvl_Row) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao alterar a situa$$HEX2$$e700e300$$ENDHEX$$o do pedido do ECOMMERCE '" + String(al_Pedido) + "'", Information!)
Else
	lvb_Sucesso = True
End If	

Destroy(lvo_Conexao)

Return lvb_Sucesso
end function

public function boolean of_localiza_dependente_matriz (ref string as_codigo, ref string as_nome, ref string as_senha);Boolean lvb_Sucesso = False

uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao()

lvo_Conexao.of_Define_Variaveis(True)

lvb_Sucesso = lvo_Conexao.of_Executa_Rotina('0114', {"'" + as_Codigo + "'"})

If lvo_Conexao.of_Erro_Execucao() Then
   lvo_Conexao.of_MsgError("Localiza$$HEX2$$e700e300$$ENDHEX$$o dependente Cliente")
Else	
	
	If lvo_Conexao.of_Erro_Conexao() Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do dependente '" + as_Codigo, StopSign!)
	Else
		
		If lvo_Conexao.of_Linhas() = 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Dependente '" + as_Codigo + "' n$$HEX1$$e300$$ENDHEX$$o localizado.", StopSign!)
		Else
			
			If lvo_Conexao.of_Retorno("nm_dependente", Ref as_Nome) Then
				If lvo_Conexao.of_Retorno("de_senha_venda_credito", Ref as_Senha) Then
					If lvo_Conexao.of_Retorno('de_hash_senha', Ref This.de_hash_senha_dep) Then					
						This.cd_Dependente = as_Codigo
						lvb_Sucesso = True
					End If
				End If
			End If
			
		End If
		
	End If
	
End If	

Destroy(lvo_Conexao)

Return lvb_Sucesso
end function

public function boolean of_localiza_cliente_codigo (string as_codigo);Boolean 	lvb_Sucesso = False, &
	      lvb_Tipo_Correto	  

uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao()

lvo_Conexao.of_Define_Variaveis(True)

lvo_Conexao.of_Executa_Rotina('0116',{"'" + as_Codigo + "'"})

If Not lvo_Conexao.of_Erro_Execucao() Then
	
	If lvo_Conexao.of_Linhas() > 0 Then
		If lvo_Conexao.of_Retorno('nm_cliente', Ref This.nm_Cliente) Then
			If lvo_Conexao.of_Retorno('id_tipo_cliente', Ref This.id_Tipo_Cliente) Then
				If lvo_Conexao.of_Retorno('id_permite_resgate_dependente', Ref This.ivb_Permite_Resgate_Dependente) Then
					If lvo_Conexao.of_Retorno('id_permite_credito_dependente', Ref This.ivb_Permite_Credito_Dependente) Then
						If lvo_Conexao.of_Retorno('de_senha_venda_credito', Ref This.de_Senha_Cliente) Then	
							If lvo_Conexao.of_Retorno('nr_cpf_cgc', Ref This.nr_cpf) Then	
								If lvo_Conexao.of_Retorno('id_fisica_juridica', Ref This.id_fisica_juridica) Then								
									If lvo_Conexao.of_Retorno('nr_dia_vencimento', Ref This.nr_dia_vencimento) Then
										If lvo_Conexao.of_Retorno('de_hash_senha', Ref This.de_hash_senha) Then										
											lvb_Tipo_Correto = True
							
											// Verifica o tipo do cliente selecionado
											If This.ivs_Tipo_Cliente <> "" Then
												Choose Case This.ivs_Tipo_Cliente
													Case "CR", "RC", "CC"
														If This.Id_Tipo_Cliente <> This.ivs_Tipo_Cliente Then						
															MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tipo do cliente '" + This.Id_Tipo_Cliente + "' diferente do determinado '" + This.ivs_Tipo_Cliente + "'.", Information!)
															lvb_Tipo_Correto = False
														End If
														
													Case "CL"
														If This.Id_Tipo_Cliente <> "RC" and This.Id_Tipo_Cliente <> "CC" Then						
															MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tipo do cliente '" + This.Id_Tipo_Cliente + "' diferente do determinado '" + This.ivs_Tipo_Cliente + "'.", Information!)
															lvb_Tipo_Correto = False
														End If					
												End Choose
											End If
											
											If lvb_Tipo_Correto Then
												This.Cd_Cliente = as_Codigo
											Else
												SetNull(This.Cd_Cliente)
												SetNull(Nm_Cliente)
												SetNull(Id_Tipo_Cliente)
												SetNull(Nr_cpf)
												SetNull(Id_Fisica_Juridica)
												SetNull(Nr_dia_vencimento)
											End If	
											
											lvb_Sucesso = True
										End If
									End If
								End If
							End If
						End If						
					End If
				End If				
			End If			
		End If
	End If
Else
	lvo_Conexao.of_MsgError("Localiza$$HEX2$$e700e300$$ENDHEX$$o cliente C$$HEX1$$f300$$ENDHEX$$digo")
End If

Destroy(lvo_Conexao)
	
Return lvb_Sucesso
end function

public function boolean of_tipo_movto_venda_devolucao (string as_tipo_nf, string as_cancelamento, ref long al_tipo_movto);Boolean lvb_Sucesso = False

String lvs_Parametro

uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao()

lvo_Conexao.of_Define_Variaveis(True)

If as_Tipo_NF = "V" and as_Cancelamento = "N" Then
	lvs_Parametro = "Where id_venda = 'S'"
	
ElseIf as_Tipo_NF = "V" and as_Cancelamento = "S" Then
	lvs_Parametro = "Where id_cancelamento_venda = 'S'"
	
ElseIf as_Tipo_NF = "D" and as_Cancelamento = "N" Then
	lvs_Parametro = "Where id_devolucao_venda = 'S'"
	
ElseIf as_Tipo_NF = "D" and as_Cancelamento = "S" Then
	lvs_Parametro = "Where id_cancelamento_dev_venda = 'S'"
End If

lvo_Conexao.of_Executa_Rotina("0118",{lvs_Parametro})

If Not lvo_Conexao.of_Erro_Conexao() Then
	If Not lvo_Conexao.of_Erro_Execucao() Then
		If lvo_Conexao.of_Linhas() > 0 Then
			If lvo_Conexao.of_Retorno("cd_tipo_movimento", Ref al_Tipo_Movto) Then
				lvb_Sucesso = True		
			End If
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Tipo do movimento de venda/devolu$$HEX2$$e700e300$$ENDHEX$$o '" + as_Tipo_NF + "/" + as_Cancelamento + "' n$$HEX1$$e300$$ENDHEX$$o localizado.")
		End If
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do tipo do movimento de venda/devolu$$HEX2$$e700e300$$ENDHEX$$o '" + as_Tipo_NF + "/" + as_Cancelamento, StopSign!)
	End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na conex$$HEX1$$e300$$ENDHEX$$o com o servidor distribu$$HEX1$$ed00$$ENDHEX$$do ao tentar localizar o tipo de movimenta$$HEX2$$e700e300$$ENDHEX$$o.")
End If

Destroy(lvo_Conexao)

Return lvb_Sucesso
end function

public function boolean of_data_fechamento_pontuacao (ref date adt_data);Boolean	lvb_Sucesso = True

String	lvs_Valor
String	lvs_Parametro

lvs_Parametro = "DT_FECHAMENTO_PONTUACAO_CLUBE"

uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao()

lvo_Conexao.of_Define_Variaveis(True)

lvo_Conexao.of_Executa_Rotina("0121", {"'" + lvs_Parametro + "'"})

If lvo_Conexao.of_Erro_Execucao() Or lvo_Conexao.of_Erro_Conexao() Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro '" + lvs_Parametro + "'.", StopSign!)
Else
	If lvo_Conexao.of_Linhas() > 0 Then
		If lvo_Conexao.of_Retorno("vl_parametro", Ref lvs_Valor) Then		
			If IsDate(lvs_Valor) Then
				adt_Data = Date(lvs_Valor)				
				lvb_Sucesso = True
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Valor '" + lvs_Valor + "' do par$$HEX1$$e200$$ENDHEX$$metro '" + lvs_Parametro + "' inv$$HEX1$$e100$$ENDHEX$$lido.", StopSign!)		
			End If
		End If
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Par$$HEX1$$e200$$ENDHEX$$metro '" + lvs_Parametro + "' n$$HEX1$$e300$$ENDHEX$$o localizado.", StopSign!)
	End If
End If

Destroy(lvo_Conexao)

Return lvb_Sucesso
end function

public function boolean of_saldo_pontuacao_cliente (string as_cliente, date adt_saldo, ref decimal adc_pontos);Boolean lvb_Sucesso = False

uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao()

lvo_Conexao.of_Define_Variaveis(True)
lvo_Conexao.of_ConverteVirgula(True)

lvo_Conexao.of_Executa_Rotina("0122", {"'" + as_Cliente + "'", "'" + String(adt_Saldo,"yyyymmdd") + "'"})
	
If lvo_Conexao.of_Erro_Execucao() Or lvo_Conexao.of_Erro_Conexao() Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do saldo de pontos do cliente '" + as_Cliente + &
						  "' no m$$HEX1$$ea00$$ENDHEX$$s '" + String(adt_Saldo, "mm/yyyy") + "'.", StopSign!)
Else
	If lvo_Conexao.of_Linhas() > 0 Then
		If lvo_Conexao.of_Retorno("qt_pontos", Ref adc_Pontos) Then
			lvb_Sucesso = True
		End If
	Else
		adc_Pontos = 0
		lvb_Sucesso = True
	End If
End If

Destroy(lvo_Conexao)

Return lvb_Sucesso
end function

public function boolean of_limite_credito_cliente (string as_codigo, ref decimal adc_limite_credito, ref boolean ab_localizado);Boolean lvb_Sucesso = True

Decimal lvdc_vendas,&
		lvdc_titulos,&
		lvdc_outros,&
		lvdc_limite
		
ab_Localizado = False		

uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao()

lvo_Conexao.of_ConverteVirgula(True)
lvo_Conexao.of_Define_Variaveis(True)

lvo_Conexao.of_Executa_Rotina("0123",{"'" + as_Codigo + "'"})

If lvo_Conexao.of_Erro_Execucao() Or lvo_Conexao.of_Erro_Conexao() Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do limite de cr$$HEX1$$e900$$ENDHEX$$dito do cliente '" + as_Codigo + "'.")
	
	lvb_Sucesso = False
Else
	If lvo_Conexao.of_Linhas() > 0 Then
		If lvo_Conexao.of_Retorno("vl_limite_credito_aprovado", Ref adc_Limite_Credito) Then
		
			If IsNull(adc_limite_credito) Then adc_limite_credito = 00.000
			
			ab_Localizado = True
		Else
			lvb_Sucesso = False
		End IF
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Limite de cr$$HEX1$$e900$$ENDHEX$$dito do cliente '" + as_Codigo + "' n$$HEX1$$e300$$ENDHEX$$o localizado na Matriz.")
	End If
End If

Destroy(lvo_Conexao)

Return lvb_Sucesso
end function

public function boolean of_consulta_contas_receber (string as_codigo, ref decimal adc_vendas, ref decimal adc_titulos, ref decimal adc_outros);Boolean lvb_Sucesso = False

DateTime lvdh_data_fechamento

If This.of_data_fechamento_contas_receber(Ref lvdh_data_fechamento) Then

	uo_Transacao_Remota lvo_Conexao
	lvo_Conexao = Create uo_Transacao_Remota
	
	lvo_Conexao.of_BancoProducao()
	
	lvo_Conexao.of_Define_Variaveis(True)
	lvo_Conexao.of_ConverteVirgula(True)
	
	lvo_Conexao.of_Executa_Rotina("0125",{"'" + as_Codigo + "'", "'" + String(lvdh_data_fechamento,"yyyymmdd") + "'"})
	
	If lvo_Conexao.of_Erro_Execucao() Or lvo_Conexao.of_Erro_Conexao() Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao consultar contas a receber do cliente '" + as_Codigo + "'.")
	Else
	
		If lvo_Conexao.of_Retorno("vl_vendas", Ref adc_Vendas) Then
			If lvo_Conexao.of_Retorno("vl_titulos", Ref adc_Titulos) Then
				If lvo_Conexao.of_Retorno("vl_outros", Ref adc_Outros) Then
					If IsNull(adc_vendas)  Then adc_vendas  = 00.000
					If IsNull(adc_titulos) Then adc_titulos = 00.000
					If IsNull(adc_outros)  Then adc_outros  = 00.000
					
					lvb_Sucesso = True
				End If
			End If
		End If
	End If
	
	Destroy(lvo_Conexao)
	
End If

Return lvb_Sucesso
end function

public function boolean of_data_fechamento_contas_receber (ref datetime adt_data);Boolean lvb_Sucesso = False

uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao()

lvo_Conexao.of_Define_Variaveis(True)

lvo_Conexao.of_Executa_Rotina("0124",{""})

If lvo_Conexao.of_Erro_Execucao() Or lvo_Conexao.of_Erro_Conexao() Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao localizar data de fechamento do contas a receber.")
Else
	If lvo_Conexao.of_Linhas() > 0 Then
		If lvo_Conexao.of_Retorno("dh_fechamento_contas_receber", Ref adt_Data) Then
			lvb_Sucesso = True
		End If
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel localizar data de fechamento do contas a receber.")		
	End If
End If

Destroy(lvo_Conexao)

Return lvb_Sucesso
end function

public function boolean of_saldo_online_aberto (string as_cliente, ref decimal adc_saldo);// 1 = Venda
// 2 = Cancelamento de Venda
// 3 = Pagamento por Conta
// 4 = Pagamento de T$$HEX1$$ed00$$ENDHEX$$tulo

uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao()

lvo_Conexao.of_Define_Variaveis(True)
lvo_Conexao.of_ConverteVirgula(True)

lvo_Conexao.of_Executa_Rotina("0126",{"'" + as_Cliente + "'"})

If lvo_Conexao.of_Erro_Execucao() Or lvo_Conexao.of_Erro_Conexao() Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na consulta do saldo online do cliente '" + as_Cliente + "'.")	
	Return False		
Else
	If lvo_Conexao.of_Linhas() > 0 Then
		If lvo_Conexao.of_Retorno("vl_saldo_aberto", Ref adc_Saldo) Then
			If IsNull(adc_Saldo) Then adc_Saldo = 0
		Else
			Return False
		End If
	Else
		adc_Saldo = 0
	End If
End If

Destroy(lvo_Conexao)

Return True
end function

public function boolean of_cliente_bloqueado_bacen (string as_cpf, long al_filial);Boolean lvb_Bloqueado

Long		lvl_Row

String	lvs_Bloqueado = "N", &
			lvs_Tabela, &
			lvs_Colunas, &
			lvs_Values

as_CPF = RightA("00000000000000" + as_CPF, 14)

lvb_Bloqueado = This.of_Cliente_Bloqueado_Bacen(as_CPF)

If lvb_Bloqueado Then lvs_Bloqueado = "S"

uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao()

lvs_Tabela  =	"consulta_registro_bacen"

lvs_Colunas =	"nr_cpf_cgc, dh_consulta, cd_filial, id_bloqueado"

lvs_Values  =	"'" + as_CPF								+ "'," + &
					"'" + String(Today(),"yyyymmdd")		+ "'," + &
					String(al_Filial)							+ ","  + &
					"'" + lvs_Bloqueado						+ "'"

lvo_Conexao.of_Insert_Registro(lvs_Tabela, lvs_Colunas, lvs_Values, Ref lvl_Row)

Return lvb_Bloqueado
end function

public function boolean of_cliente_bloqueado_bacen (string as_cpf);Boolean lvb_Sucesso = False

String lvs_Nome

uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao()

lvo_Conexao.of_Define_Variaveis(True)

as_CPF = RightA("00000000000000" + as_CPF, 14)

lvo_Conexao.of_Executa_Rotina("0127",{"'" + as_CPF + "'"})

If lvo_Conexao.of_Erro_Execucao() Or lvo_Conexao.of_Erro_Conexao() Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "CPF/CGC : '" + as_CPF + "'~r~rErro na verifica$$HEX2$$e700e300$$ENDHEX$$o do registro BACEN. ")
	lvb_Sucesso = True
Else
	If lvo_Conexao.of_Linhas() > 0 Then
		lvb_Sucesso = True
		
		If lvo_Conexao.of_Retorno("nm_cliente", Ref lvs_Nome) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "CPF/CGC : '" + as_CPF + "'~rNome : '" + lvs_Nome + "'~r~rExistem pend$$HEX1$$ea00$$ENDHEX$$ncias no cadastro.~n~nPor favor, procure o gerente do banco.")
		End If
	End If
End If

Destroy(lvo_Conexao)

Return lvb_Sucesso
end function

public function boolean of_proximo_vale_resgate (ref long al_vale_resgate);Boolean lvb_Sucesso = True

uo_Parametro_Loja_Central lvo_Parametro
lvo_Parametro = Create uo_Parametro_Loja_Central

If Not lvo_Parametro.of_Proximo_Sequencial("NR_ULTIMO_VALE_RESGATE_CLUBE", ref al_vale_resgate) Then
	lvb_Sucesso = False
End If

Destroy(lvo_Parametro)

Return lvb_Sucesso
end function

public function boolean of_proximo_recibo_resgate (ref long al_recibo);Boolean lvb_Sucesso = True

uo_Parametro_Loja_Central lvo_Parametro
lvo_Parametro = Create uo_Parametro_Loja_Central

If Not lvo_Parametro.of_Proximo_Sequencial("NR_ULTIMO_RECIBO_RESGATE_CLUBE", ref al_Recibo) Then
	lvb_Sucesso = False
End If

Destroy(lvo_Parametro)

Return lvb_Sucesso
end function

public function boolean of_tipo_movto_resgate (ref long al_tipo_movto);Boolean lvb_Sucesso

uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao()

lvo_Conexao.of_Define_Variaveis(True)

lvo_Conexao.of_Executa_Rotina("0044",{"id_resgate = 'S'"})

If lvo_Conexao.of_Erro_Execucao() Or lvo_Conexao.of_Erro_Conexao() Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do tipo do movimento de resgate.")
	Destroy(lvo_Conexao)
	Return False
End If

If lvo_Conexao.of_Linhas() > 0 Then
	If lvo_Conexao.of_Retorno("cd_tipo_movimento", Ref al_Tipo_Movto) Then
		lvb_Sucesso = True
	End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Tipo do movimento de resgate n$$HEX1$$e300$$ENDHEX$$o localizado.")
End If

Destroy(lvo_Conexao)

Return lvb_Sucesso
end function

public function boolean of_numero_movto_resgate (string as_cliente, long al_recibo, long al_tipo, ref double adb_movto);Boolean lvb_Sucesso = False

Long lvl_Movto

String lvs_Doc

lvs_Doc = String(al_Recibo)

uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao()

lvo_Conexao.of_Define_Variaveis(True)

lvo_Conexao.of_Executa_Rotina("0045",{"'" + as_Cliente + "'", "'" + lvs_Doc + "'", String(al_Tipo)})

If lvo_Conexao.of_Erro_Execucao() Or lvo_Conexao.of_Erro_Conexao() Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do n$$HEX1$$fa00$$ENDHEX$$mero do movimento de resgate.")
Else
	If lvo_Conexao.of_Linhas() > 0 Then
		If lvo_Conexao.of_Retorno("nr_movimento",  Ref lvl_Movto) Then
			adb_Movto = Double(lvl_Movto)
			lvb_Sucesso = True
		End If		
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$fa00$$ENDHEX$$mero do movimento de resgate n$$HEX1$$e300$$ENDHEX$$o localizado.")
	End If
End If

Return lvb_Sucesso

end function

public function boolean of_atualiza_utilizacao_pontos (string as_cliente, double adb_movto, decimal adc_pontos);Boolean lvb_Sucesso = True

Long lvl_Contador
	  
Double lvdb_Movto

Decimal lvdc_Saldo, &
        lvdc_Utilizacao, &
        lvdc_Utilizacao_Acumulada, &
		  lvdc_Utilizacao_Pendente
		  
String lvs_Situacao, &
       lvs_Tipo, &
	   lvs_Retorno

String lvs_Tabela
String lvs_Set
String lvs_Where
String lvs_Colunas
String lvs_Values

Long lvl_Row

dc_uo_ds_Base lvds
lvds = Create dc_uo_ds_Base

If Not lvds.of_ChangeDataObject("dw_ge077_utilizacao_pontos", False) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na troca da DW 'dw_ge077_utilizacao_pontos'.")
	Destroy(lvds)
	Return False
End If

uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao()

lvo_Conexao.of_ConverteVirgula(True)

lvo_Conexao.of_Relatorio(True)

lvds.of_AppendWhere("m.cd_cliente = '" + as_cliente + "'")

lvo_Conexao.of_Retrieve(lvds.GetSQLSelect(), Ref lvs_Retorno)

If Not IsNull(lvs_Retorno) And Trim(lvs_Retorno) <> '' Then
	
	If lvds.ImportString(lvs_Retorno) > 0 Then
		For lvl_Contador = 1 To lvds.RowCount()
			SetNull(lvs_Tabela)
			SetNull(lvs_Set)
			SetNull(lvs_Where)
			SetNull(lvs_Colunas)
			SetNull(lvs_Values)
			
			
			lvdb_Movto = lvds.Object.Nr_Movimento     [lvl_Contador]
			lvdc_Saldo = lvds.Object.Qt_Saldo_Pontos  [lvl_Contador]
			lvs_Tipo   = lvds.Object.Id_Credito_Debito[lvl_Contador]
			
			lvdc_Utilizacao_Pendente = adc_Pontos - lvdc_Utilizacao_Acumulada
			
			If lvdc_Utilizacao_Pendente > 0 Then
				If lvs_Tipo = "D" or lvdc_Utilizacao_Pendente >= lvdc_Saldo Then
					lvdc_Utilizacao = lvdc_Saldo
					lvs_Situacao    = "U" // Utilizado
				Else
					lvdc_Utilizacao = lvdc_Utilizacao_Pendente
					lvs_Situacao    = "D" // Dispon$$HEX1$$ed00$$ENDHEX$$vel
				End If
				
				lvdc_Saldo -= lvdc_Utilizacao
				
				If lvs_Tipo = "C" Then
					lvdc_Utilizacao_Acumulada += lvdc_Utilizacao
				Else
					lvdc_Utilizacao_Acumulada -= lvdc_Utilizacao
				End If
				
				// Atualiza o saldo e a situa$$HEX2$$e700e300$$ENDHEX$$o dos pontos
				lvs_Tabela = "pontuacao_clube_movimento"
				
				lvs_Set =	"qt_saldo_pontos    = "  + gf_Replace(String(lvdc_Saldo),",",".",0) + ", " + &
							"id_situacao_pontos = '" + lvs_Situacao + "'"
				
				lvs_Where = "nr_movimento = " + String(lvdb_Movto)
				
				If Not lvo_Conexao.of_Update_Registro(lvs_Tabela, lvs_Set, lvs_Where, Ref lvl_Row) Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do saldo dos pontos do movimento '" + String(lvdb_Movto) + "' do cliente '" + as_Cliente + "'.", Information!)
					lvb_Sucesso = False
					Exit
				End If	
				
				// Inclui na lista dos movimentos utilizados no resgate
				lvs_Tabela = "pontuacao_clube_utilizacao"
				
				lvs_Colunas = "nr_movimento_utilizacao, nr_movimento_utilizado, qt_pontos"
				
				lvs_Values =	String(adb_Movto)  + ", " + &
								String(lvdb_Movto) + ", " + &
						  		gf_Replace(String(lvdc_Utilizacao),",",".",0)
								  
				
				If Not lvo_Conexao.of_Insert_Registro(lvs_Tabela,lvs_Colunas,lvs_Values, Ref lvl_Row) Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na inclus$$HEX1$$e300$$ENDHEX$$o do movimento '" + String(lvdb_Movto) + "' utilizado no resgate do cliente '" + as_Cliente + "'.")
					lvb_Sucesso = False
					Exit
				End If	
				
			End If
		Next
		
		If lvb_Sucesso Then
			If lvdc_Utilizacao_Acumulada <> adc_Pontos Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Utiliza$$HEX2$$e700e300$$ENDHEX$$o acumulada '" + String(lvdc_Utilizacao_Acumulada, "0.00") + &
							  "' diferente do total de pontos do resgate '" + String(adc_Pontos, "0.00") + "'.")
								  
				lvb_Sucesso = False
			End If
		End If
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Pontua$$HEX2$$e700e300$$ENDHEX$$o dispon$$HEX1$$ed00$$ENDHEX$$vel n$$HEX1$$e300$$ENDHEX$$o localizada para utiliza$$HEX2$$e700e300$$ENDHEX$$o pelo resgate.")
		lvb_Sucesso = False
	End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Pontua$$HEX2$$e700e300$$ENDHEX$$o dispon$$HEX1$$ed00$$ENDHEX$$vel n$$HEX1$$e300$$ENDHEX$$o localizada para utiliza$$HEX2$$e700e300$$ENDHEX$$o pelo resgate.")
	lvb_Sucesso = False
End If

Destroy(lvds)
Destroy(lvo_Conexao)

Return lvb_Sucesso
end function

public function boolean of_inclui_movto_resgate_clube (string as_cliente, decimal adc_pontos, long al_filial, string as_cartao, string as_dependente_cliente, long al_recibo_resgate);Boolean lvb_Sucesso

Long lvl_Tipo_Movimento
Long lvl_Row

String lvs_Documento
String lvs_Tabela
String lvs_Colunas
String lvs_Values

String lvs_Recibo_Resgate

lvs_Recibo_Resgate = String(al_Recibo_Resgate)

If Not This.of_Tipo_Movto_Resgate_Cancelamento(Ref lvl_Tipo_Movimento) Then Return False

uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota
				
lvo_Conexao.of_BancoProducao()

lvs_Tabela 	= 'pontuacao_clube_movimento'

lvs_Colunas = 'cd_cliente, dh_movimento, cd_tipo_movimento, vl_movimento, qt_pontos, cd_filial, dh_registro, nr_cartao_clube, cd_dependente_cliente, nr_documento, de_historico, qt_saldo_pontos, id_situacao_pontos'
	
lvs_Values	 = "'" + as_Cliente + "', "
lvs_Values	+= "cast(dbo.tochar(getdate(), 'yyyymmdd') as datetime), "
lvs_Values	+= String(lvl_Tipo_Movimento) + ", "
lvs_Values	+= "0, "
lvs_Values	+= gf_Replace(String(adc_Pontos),",",".",0)	 + ", "
lvs_Values	+= String(al_Filial)		+ ","
lvs_Values	+= "GetDate() ,"
lvs_Values	+= gf_Valida_Nulo(as_Cartao, True, False) 	
lvs_Values	+= gf_Valida_Nulo(as_dependente_cliente, True, False)
lvs_Values	+= gf_Valida_Nulo(lvs_Recibo_Resgate, True, False)
lvs_Values	+= "'CANCELAMENTO DE RESGATE', "
lvs_Values	+= gf_Replace(String(adc_Pontos),",",".",0) + ","
lvs_Values	+= "'D'"
				 
If Not lvo_Conexao.of_Insert_Registro(lvs_Tabela,lvs_Colunas,lvs_Values, Ref lvl_Row) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na inclus$$HEX1$$e300$$ENDHEX$$o do movimento de cancelamento '" + as_Cliente + "'.")
Else
	lvb_Sucesso = True
End If

Destroy(lvo_Conexao)

Return lvb_Sucesso
end function

public function boolean of_tipo_movto_resgate_cancelamento (ref long al_tipo_movto);Boolean lvb_Sucesso

uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao()

lvo_Conexao.of_Define_Variaveis(True)

lvo_Conexao.of_Executa_Rotina("0044",{"id_cancelamento_resgate = 'S'"})

If lvo_Conexao.of_Erro_Execucao() Or lvo_Conexao.of_Erro_Conexao() Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do tipo do movimento de resgate.")
	Destroy(lvo_Conexao)
	Return False
End If

If lvo_Conexao.of_Linhas() > 0 Then
	If lvo_Conexao.of_Retorno("cd_tipo_movimento", Ref al_Tipo_Movto) Then
		lvb_Sucesso = True
	End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Tipo do movimento de resgate n$$HEX1$$e300$$ENDHEX$$o localizado.")
End If

Destroy(lvo_Conexao)

Return lvb_Sucesso
end function

public function boolean of_carrega_produto_recibo_resgate (long al_recibo_resgate, ref long al_produto[], ref integer ai_qtde_produto[]);Boolean lvb_Sucesso = False

Long lvl_Linhas,&
	 lvl_Linha
	 
String lvs_Retorno

dc_uo_ds_base lvds_1
uo_Transacao_Remota lvo_Conexao

lvds_1 = Create dc_uo_ds_base
If Not lvds_1.of_ChangeDataObject("dw_ge077_produto_recibo_resgate") Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao trocar para a Data Window dw_ge077_produto_recibo_resgate.")
	Destroy(lvds_1)
	Return False
End If

lvds_1.of_AppendWhere("nr_recibo_resgate = " + String(al_Recibo_Resgate))

lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao()

lvo_Conexao.of_Retrieve(lvds_1.GetSQLSelect(), Ref lvs_Retorno)

If lvo_Conexao.of_Erro_Conexao() Or lvo_Conexao.of_Erro_Execucao() Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na conex$$HEX1$$e300$$ENDHEX$$o com o servidor distribu$$HEX1$$ed00$$ENDHEX$$do.")
Else
	If Not IsNull(lvs_Retorno) And Trim(lvs_Retorno) <> "" Then
		If lvds_1.ImportString(lvs_Retorno) > 0 Then
			lvb_Sucesso = True
			
			lvl_Linhas = lvds_1.RowCount()
									
			For lvl_Linha = 1 To lvl_Linhas
				al_Produto     [lvl_Linha] = lvds_1.Object.cd_produto[lvl_Linha]
				ai_Qtde_Produto[lvl_Linha] = lvds_1.Object.qt_produto[lvl_Linha]
			Next
		End If		
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Nenhum produto foi localizado para o recibo de resgate '" + String(al_Recibo_Resgate) + "'.")
	End If
End If

Destroy(lvds_1)
Destroy(lvo_Conexao)

Return lvb_Sucesso

end function

public function boolean of_verifica_fase_atualizacao (string as_cliente, ref string ps_nr_fase);DateTime ldh_Solicitou_Atualizacao
DateTime ldh_Atualizacao_Fase
DateTime ldh_Parametro

uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao()

lvo_Conexao.of_Define_Variaveis(True)
lvo_Conexao.of_ConverteVirgula(True)

lvo_Conexao.of_Executa_Rotina("0048",{"'" + as_Cliente + "'"})

ps_Nr_Fase = 'N' // Se n$$HEX1$$e300$$ENDHEX$$o for necess$$HEX1$$e100$$ENDHEX$$rio atualizar

If lvo_Conexao.of_Erro_Execucao() Or lvo_Conexao.of_Erro_Conexao() Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na consulta da fase de atualiza$$HEX2$$e700e300$$ENDHEX$$o do cliente '" + as_Cliente + "'.")	
	Return False		
Else
	If lvo_Conexao.of_Linhas() > 0 Then
		// Verifica se j$$HEX1$$e100$$ENDHEX$$ houve atualiza$$HEX2$$e700e300$$ENDHEX$$o da fase atual
		If lvo_Conexao.of_Retorno("dh_atualizacao_fase", Ref ldh_Atualizacao_Fase) Then
			If IsNull( ldh_Atualizacao_Fase ) Then
				// Se ainda n$$HEX1$$e300$$ENDHEX$$o atualizou, verifica se j$$HEX1$$e100$$ENDHEX$$ foi solicitada a atualiza$$HEX2$$e700e300$$ENDHEX$$o na data atual
				If lvo_Conexao.of_Retorno("dh_solicitou_atualizacao", Ref ldh_Solicitou_Atualizacao) Then
					ldh_Parametro = gvo_Parametro.of_Dh_Movimentacao()
					If IsNull( ldh_Solicitou_Atualizacao ) Or ldh_Parametro > ldh_Solicitou_Atualizacao Then
						// Verifica o n$$HEX1$$fa00$$ENDHEX$$mero da fase de atualizacao
						If lvo_Conexao.of_Retorno("nr_fase_atualizacao", Ref ps_Nr_Fase) Then
							If IsNull( ps_Nr_Fase )  Then
								ps_Nr_Fase = 'N'
							End If
						Else
							Return False
						End If
					End If
				Else
					Return False
				End If
			End If
		Else
			Return False
		End If
	End If
End If

Destroy(lvo_Conexao)

Return True
end function

public function boolean of_atualiza_fase_atualizacao (string as_codigo, boolean ab_atualizou);Boolean lvb_Sucesso = False

Long lvl_Row

String lvs_Tabela
String lvs_Set
String lvs_Where

uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao()
	
lvs_Tabela	 = "cliente"

If ab_Atualizou Then
	lvs_Set = " dh_atualizacao_fase = getdate() "
Else
	lvs_Set = " dh_solicitou_atualizacao = getdate() "
End If

lvs_Where	 = " cd_cliente = '"  + String( as_Codigo ) + "'"
		
If Not lvo_Conexao.of_Update_Registro(lvs_Tabela, lvs_Set, lvs_Where, Ref lvl_Row) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao alterar a data da fase de atualiza$$HEX2$$e700e300$$ENDHEX$$o do cliente '" + String(as_Codigo) + "'", Information!)
Else
	lvb_Sucesso = True
End If	

/*
If ab_Atualizou Then
	lvs_Set = " nr_fase_atualizacao = '1' "

	lvs_Where	 = " cd_cliente = '"  + String( as_Codigo ) + "' "
	lvs_Where	 += " and nr_fase_atualizacao is null"
		
	If Not lvo_Conexao.of_Update_Registro(lvs_Tabela, lvs_Set, lvs_Where, Ref lvl_Row) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao alterar a fase de atualiza$$HEX2$$e700e300$$ENDHEX$$o do cliente '" + String(as_Codigo) + "'", Information!)
		lvb_Sucesso = False
	Else
		lvb_Sucesso = True
	End If	
End If

Destroy(lvo_Conexao)
*/
Return lvb_Sucesso
end function

public function boolean of_inclui_recibo_resgate (string as_cliente, string as_dependente, string as_cartao, decimal adc_total_pontos, long al_filial, string as_matricula, long al_produto[], long al_qtde[], decimal adc_pontos[], string as_utiliza_vale_resgate[], string as_cartao_smiles, ref long al_recibo);Boolean lvb_Sucesso 			= True

Long lvl_Contador, &
     lvl_Tipo_Movto,&
	 lvl_Vale_Resgate[], &
	 lvl_Row	  
	 
DateTime ldh_ServerDate

Double lvdb_Movto_Resgate
		  
String lvs_Recibo,&
       lvs_Utiliza_Vale_Resgate

String lvs_Tabela
String lvs_Colunas
String lvs_Values

// Inclui vale resgate(voucher)
If Not This.of_Vale_Resgate(al_Produto, al_Qtde, as_Utiliza_vale_resgate, Ref lvl_Vale_Resgate) Then
	Return False
End If

// Verifica o pr$$HEX1$$f300$$ENDHEX$$ximo sequencial para inclus$$HEX1$$e300$$ENDHEX$$o do recibo
If Not This.of_Proximo_Recibo_Resgate(ref al_Recibo) Then 
	Return False
End If

// Localiza o c$$HEX1$$f300$$ENDHEX$$digo do tipo do movimento de resgate
If Not This.of_Tipo_Movto_Resgate(ref lvl_Tipo_Movto) Then
	Return False
End If

uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota 

lvo_Conexao.of_BancoProducao()

//Acerto de variaveis que podem ser nulas
as_Cartao				= gf_Valida_Nulo(as_Cartao,True,False)
as_Dependente			= gf_Valida_Nulo(as_Dependente,True,False)

ldh_ServerDate	= gf_GetServerDate( )

lvs_Tabela = "recibo_resgate_clube"

lvs_Colunas = "nr_recibo_resgate, cd_cliente, dh_resgate, qt_pontos, cd_filial, nr_matricula_resgate, nr_cartao_clube, cd_dependente_cliente, dh_cancelamento, nr_matricula_cancelamento"

lvs_Values =	String(al_Recibo)	+ ", " + &
				"'" + as_Cliente	+ "', " + &
				"'" + String( ldh_ServerDate,"yyyy/mm/dd" ) + " " + String( ldh_ServerDate,"HH:MM:SS" ) + "', " + &
				gf_Replace(String(adc_Total_Pontos),",",".",0) + ", " + &
				String(al_Filial)		+ ",  " + &
				"'" + as_Matricula 		+ "', " + &
				as_Cartao				+ &
				as_Dependente			+ &
				"null,null"					

If Not IsNull( as_Cartao_Smiles ) Then
	lvs_Colunas += ", nr_cartao_smiles, id_situacao_resgate"
	
	lvs_Values += ", '" + as_Cartao_Smiles	+ "', "	+ &
						"'R'"
End If			

If Not lvo_Conexao.of_Insert_Registro(lvs_Tabela,lvs_Colunas,lvs_Values, Ref lvl_Row) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na inclus$$HEX1$$e300$$ENDHEX$$o do recibo de resgate do cliente '" + as_Cliente + "'.")
	Destroy(lvo_Conexao)
	Return False
Else		
	// Inclui os produtos do recibo
	For lvl_Contador = 1 To UpperBound(al_Produto)
		SetNull(lvs_Tabela)
		SetNull(lvs_Colunas)
		SetNull(lvs_Values)
		
		lvs_Tabela	= "recibo_resgate_clube_produto"
		
		lvs_Colunas	= "nr_recibo_resgate, cd_produto, qt_produto, qt_pontos, nr_vale_resgate"
		
		lvs_Values	=	String(al_Recibo) 					+ ", " + &
						String(al_Produto[lvl_Contador]) 	+ ", " + &
						String(al_Qtde[lvl_Contador])		+ ", " + &
						gf_Replace(String(adc_Pontos[lvl_Contador]),",",".",0) + ", " + &
						gf_Valida_Nulo(String(lvl_Vale_Resgate[lvl_Contador]),False,True)
		
		If Not lvo_Conexao.of_Insert_Registro(lvs_Tabela,lvs_Colunas,lvs_Values, Ref lvl_Row) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na inclus$$HEX1$$e300$$ENDHEX$$o do produto '" + String(al_Produto[lvl_Contador]) + "' do recibo de resgate do cliente '" + as_Cliente + "'.")
			
			lvb_Sucesso = False
			Exit
		End If	
	Next
	
	// Inclui o movimento de pontua$$HEX2$$e700e300$$ENDHEX$$o
	If lvb_Sucesso Then
		lvb_Sucesso = False
		
		SetNull(lvs_Tabela)
		SetNull(lvs_Colunas)
		SetNull(lvs_Values)
		
		lvs_Recibo = String(al_Recibo)
		
		
		lvs_Tabela	= "pontuacao_clube_movimento"
		
		lvs_Colunas	= "cd_cliente, dh_movimento, cd_tipo_movimento, vl_movimento, qt_pontos, cd_filial, nr_cartao_clube, cd_dependente_cliente, nr_documento, de_historico, qt_saldo_pontos, id_situacao_pontos"
		
		lvs_Values	=	"'" + as_Cliente 					+ "', " + &
						"'" + String( ldh_ServerDate ,"YYYY/MM/DD")	+ "', " + &
						String(lvl_Tipo_Movto) 				+ ", " + &
						"0, " + &
						gf_Replace(String(adc_Total_Pontos),",",".",0) + ", " + &
						String(al_Filial)					+ ", " + &
						as_Cartao							+ &
						as_Dependente						+ &
						"'" + lvs_Recibo					+ "', " + &
						"null, 0, 'U'"

		If Not lvo_Conexao.of_Insert_Registro(lvs_Tabela,lvs_Colunas,lvs_Values, Ref lvl_Row) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na inclus$$HEX1$$e300$$ENDHEX$$o do movimento de pontua$$HEX2$$e700e300$$ENDHEX$$o do resgate do cliente '" + as_Cliente + "'.")
		Else
			// Localiza o n$$HEX1$$fa00$$ENDHEX$$mero do movimento de resgate que foi inclu$$HEX1$$ed00$$ENDHEX$$do
			If This.of_Numero_Movto_Resgate(as_Cliente, &
											  al_Recibo, &
											  lvl_Tipo_Movto, &
											  ref lvdb_Movto_Resgate) Then
	
				// Atualiza o saldo dos pontos
				If This.of_Atualiza_Utilizacao_Pontos(as_Cliente, &
													  lvdb_Movto_Resgate, &
													  adc_Total_Pontos) Then											  
					lvb_Sucesso = True
				End If
			End If			
		End If
	End If	
End If

Destroy(lvo_Conexao)

Return lvb_Sucesso
end function

public function boolean of_imprime_recibo_resgate (long al_recibo, string as_matricula_reimpressao, string as_cartao_smiles, long al_qt_milhas);Boolean lvb_Sucesso = False

Blob lvb_Blob

Long	lvl_Linhas,&
		lvl_Find,&
		lvl_Vale_Resgate, &
		lvl_Retorno, &
		lvl_Linha

Long ll_Pontos

String lvs_Mensagem,&
	   lvs_Produto,&
	   lvs_Responsavel_Reimp, &
		lvs_Erro, &
		lvs_Retorno
		
String ls_DataStore

Date ldh_Inicio_Nova_Regra_Smiles
Date ldh_Parametro

dc_uo_ds_Base lvds_1
lvds_1 = Create dc_uo_ds_Base

If Not IsNull( as_cartao_smiles ) Then
	ls_DataStore = "dw_ge077_impressao_recibo_resgate_smiles"
Else
	ls_DataStore = 'dw_ge077_impressao_recibo_resgate'
End If

If Not lvds_1.of_ChangeDataObject( ls_DataStore ) Then
	Destroy(lvds_1)
	Return False
End If

lvds_1.of_AppendWhere("r.nr_recibo_resgate = " + String(al_Recibo))

uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao()

lvo_Conexao.of_ConverteVirgula(True)

lvo_Conexao.of_Retrieve(lvds_1.GetSQLSelect(), Ref lvs_Retorno)

lvl_Retorno = lvds_1.ImportString(lvs_Retorno)

If lvl_Retorno > 0 Then
	
//	For lvl_Linha = 1 To lvds_1.RowCount() 
//		lvds_1.Object.qt_pontos			[lvl_Linha] = gf_Replace(lvds_1.Object.qt_pontos			[lvl_Linha],".",",",0)
//		lvds_1.Object.qt_pontos_total	[lvl_Linha] = gf_Replace(lvds_1.Object.qt_pontos_total	[lvl_Linha],".",",",0)
//	Next
	
	lvl_Find = lvds_1.Find("Not IsNull(nr_vale_resgate)", 1, lvl_Retorno)
					
	If lvl_Find = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o n$$HEX1$$fa00$$ENDHEX$$mero do vale resgate.")
	Else
		If lvl_Find > 0 Then
			lvl_Vale_Resgate 	= lvds_1.Object.nr_vale_resgate	[lvl_Find]
			lvs_Produto	     	= lvds_1.Object.de_produto     		[lvl_Find]
			
			lvds_1.Object.st_Vale_Resgate.text = "N$$HEX1$$fa00$$ENDHEX$$mero: " + String(lvl_Vale_Resgate)
			lvds_1.Object.st_produto.text      = lvs_Produto
						
			// Se for um reimpress$$HEX1$$e300$$ENDHEX$$o
			If as_Matricula_Reimpressao <> "" Then
				
				lvds_1.Object.st_Reimpressao.Visible = True
				lvds_1.Object.st_Reimpressao.text    = "*** Este vale de resgate foi REIMPRESSO na filial '" +&
														 String(gvo_Parametro.of_Filial()) +&
														"' com a matr$$HEX1$$ed00$$ENDHEX$$cula '" + as_Matricula_Reimpressao + "' ***"
			End If
		Else
			// O resgate n$$HEX1$$e300$$ENDHEX$$o possui servi$$HEX1$$e700$$ENDHEX$$o
			If IsNull( as_cartao_smiles ) Then
				This.of_esconde_informacoes_vale(Ref lvds_1)			
			End If
			
		End If
							
		lvds_1.of_Print(False)
		lvb_Sucesso = True
	
	End If
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar os produtos do servidor distribu$$HEX1$$ed00$$ENDHEX$$do.")
End If

Destroy(lvds_1)
Destroy(lvo_Conexao)

Return lvb_Sucesso
end function

public function boolean of_atualiza_mensagem_campanha (string ps_cliente, long pl_campanha, string ps_matricula, long pl_filial);String ls_Null

DateTime ldt_Null

SetNull(ls_Null)
SetNull(ldt_Null)

Return This.of_atualiza_mensagem_campanha( ps_cliente, pl_campanha, ps_matricula, pl_filial, ls_Null, ls_Null, ldt_Null, ldt_Null )



/*
Boolean lvb_Sucesso = False

Long lvl_Row

String lvs_Tabela
String lvs_Set
String lvs_Where

uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao()
	
lvs_Tabela	 = "campanha_cliente"

lvs_Set = " dh_aviso = getdate(), "
lvs_Set += " cd_filial_aviso = " + String( pl_Filial ) + ", "
lvs_Set += " nr_matricula_aviso = '" + ps_Matricula + "'"

lvs_Where	 = " nr_campanha = "  + String( pl_Campanha ) + " and "
lvs_Where	 += " cd_cliente = '"  + ps_Cliente + "'"
		
If Not lvo_Conexao.of_Update_Registro(lvs_Tabela, lvs_Set, lvs_Where, Ref lvl_Row) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao atualizar os dados da campanha '" + String( pl_Campanha ) + "' do cliente '" + ps_Cliente + "'", Information!)
Else
	lvb_Sucesso = True
End If	

Destroy(lvo_Conexao)

Return lvb_Sucesso*/
end function

public function boolean of_verifica_mensagem_campanha (dc_uo_ds_base pds_campanha);Boolean lb_Sucesso = True

Long ll_Retorno

String ls_Retorno

uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao()

lvo_Conexao.of_Retrieve( pds_Campanha.GetSQLSelect(), Ref ls_Retorno )

If lvo_Conexao.of_Erro_Execucao() Or lvo_Conexao.of_Erro_Conexao() Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na conex$$HEX1$$e300$$ENDHEX$$o com o servidor distribu$$HEX1$$ed00$$ENDHEX$$do.")
	lb_Sucesso = False
Else
	If Not IsNull( ls_Retorno ) And Trim( ls_Retorno ) <> '' Then
		ll_Retorno = pds_Campanha.ImportString( ls_Retorno )
		
		If ll_Retorno < 0 Then
			lb_Sucesso = False
		End If
	End If
End If

Destroy lvo_Conexao

Return lb_Sucesso
end function

public function boolean of_existe_cartao_clube (string as_cliente, string as_dependente, string as_rede_filial, ref boolean ab_existe);Long lvl_Total

If IsNull(as_Dependente) Then
	Select count(*) Into :lvl_Total
	 From cartao_clube
    Where cd_cliente = :as_Cliente
	    and cd_dependente_cliente is null
	    and dh_bloqueio is null
	    and coalesce( id_rede_cartao, 'DC' ) = :as_Rede_Filial
	 Using SqlCa;	
Else
	Select count(*) Into :lvl_Total
	From cartao_clube
	Where cd_cliente            = :as_Cliente
	  and cd_dependente_cliente = :as_Dependente
	  and dh_bloqueio is null
      and coalesce( id_rede_cartao, 'DC' ) = :as_Rede_Filial
	Using SqlCa;
End If

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Verifica$$HEX2$$e700e300$$ENDHEX$$o da Exist$$HEX1$$ea00$$ENDHEX$$ncia de Cart$$HEX1$$f500$$ENDHEX$$es do Clube")
	Return False
End If

If IsNull(lvl_Total) or lvl_Total = 0 Then 
	ab_Existe = False
Else
	ab_Existe = True
End If

Return True
end function

public function boolean of_existe_cartao_clube_central (string as_cliente, string as_dependente, string as_rede_filial, ref boolean ab_existe);Boolean lvb_Sucesso = False

Long	lvl_Total

String	lvs_Where

lvs_Where = "Where cd_cliente = '" + as_Cliente + "' " + &
			" and dh_bloqueio is null " + &
			" and coalesce( id_rede_cartao, 'DC' ) = '" + as_Rede_Filial + "' "
			
If Not IsNull(as_Dependente) Then
	lvs_Where += " and cd_dependente_cliente = '" + as_Dependente + "'"
Else
	lvs_Where += " and cd_dependente_cliente is null"
End If

uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao()

lvo_Conexao.of_Define_Variaveis(True)

lvo_Conexao.of_Executa_Rotina("0031",{lvs_Where})

If lvo_Conexao.of_Erro_Conexao() Or lvo_Conexao.of_Erro_Execucao() Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na verifica$$HEX2$$e700e300$$ENDHEX$$o da exist$$HEX1$$ea00$$ENDHEX$$ncia de cart$$HEX1$$f500$$ENDHEX$$es do clube.")
Else
	If lvo_Conexao.of_Retorno("qt_total", lvl_Total) Then
		lvb_Sucesso = True
		
		If IsNull(lvl_Total) or lvl_Total = 0 Then 
			ab_Existe = False
		Else
			ab_Existe = True
		End If 
	End If
End If

Destroy(lvo_Conexao)

Return lvb_Sucesso
end function

public function boolean of_vale_resgate (long al_produto[], long al_qtde[], string as_utiliza_vale_resgate[], ref long al_vale_resgate[]);Boolean lvb_Retorno = True

Integer lvi_Contador

Long	lvl_Nulo, &
	 	lvl_Vale_Resgate, &
		lvl_Produto, &
		lvl_Qtde

SetNull(lvl_Nulo)

String lvs_Utiliza_Vale_Resgate

For lvi_Contador = 1 To UpperBound(al_Produto)
	
	lvs_Utiliza_Vale_Resgate = as_utiliza_vale_resgate[lvi_Contador]
	
	If lvs_Utiliza_Vale_Resgate = "S" Then
		lvl_Produto	= al_Produto[lvi_Contador]
		lvl_Qtde		= al_Qtde[lvi_Contador]
		If Not This.of_Proximo_Vale_Resgate(Ref lvl_Vale_Resgate) Then
			lvb_Retorno = False
			Exit
		End If
		al_Vale_Resgate[lvi_Contador] = lvl_Vale_Resgate
	Else
		al_Vale_Resgate[lvi_Contador] = lvl_Nulo
	End If
Next

Return lvb_Retorno
end function

public function boolean of_existe_cliente (string as_cliente, ref boolean ab_existe);Boolean lb_Sucesso = False

uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao()

lvo_Conexao.of_Executa_Rotina("0006",{"Select 1 from cliente where cd_cliente = '" + as_Cliente + "'"})

If lvo_Conexao.of_Erro_Execucao() Or lvo_Conexao.of_Erro_Conexao() Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do cliente '" + as_Cliente + "'.")
Else
	lb_Sucesso = True
	
	If lvo_Conexao.of_Linhas() > 0 Then
		ab_Existe = True
	Else
		ab_Existe = False
	End If
End If

Destroy lvo_Conexao

Return lb_Sucesso
end function

public function boolean of_retorna_limite_cliente (string as_codigo, ref decimal adc_limite);//Consultas remota matriz
Boolean lb_Sucesso

Open(w_Aguarde)
w_Aguarde.Title = "Consultando Limite de Cr$$HEX1$$e900$$ENDHEX$$dito do Cliente na Matriz..."

lb_Sucesso = This.of_retorna_limite_cliente_central(as_codigo, ref adc_limite)
	
Close(w_Aguarde)

If Not This.Limite_Localizado Then
	
	lb_Sucesso = This.of_retorna_limite_cliente_local(as_codigo, ref adc_limite)
		
End If

Return lb_Sucesso
end function

public function boolean of_retorna_limite_cliente_central (string as_codigo, ref decimal adc_limite);Boolean lvb_Sucesso = False

Decimal lvdc_Vendas, &
		  lvdc_Titulos, &
		  lvdc_Outros, &
		  lvdc_OnLine

If Not This.of_Limite_Credito_Cliente(as_Codigo, &
												  ref This.vl_limite_credito, &
												  ref This.limite_localizado) Then
	Return False
End If

If Not This.Limite_Localizado Then
	lvb_Sucesso = True
Else
	If Not This.of_Consulta_Contas_Receber(as_Codigo, &
														ref lvdc_Vendas, &
														ref lvdc_Titulos, &
														ref lvdc_Outros) Then
		Return False
	End If

	If Not This.of_Saldo_OnLine_Aberto(as_Codigo, &
												  lvdc_OnLine) Then
		Return False
	End If
	
	This.vl_Limite_Credito_Utilizado = lvdc_Vendas + lvdc_Titulos - lvdc_Outros + lvdc_OnLine
	This.vl_Limite_Credito_Saldo     = This.vl_Limite_Credito - This.vl_Limite_Credito_Utilizado
	
//	If This.vl_Limite_Credito_Utilizado < 0 Then
//		This.vl_Limite_Credito_Saldo = This.vl_Limite_Credito_Utilizado - This.vl_Limite_Credito
//	Else
//		This.vl_Limite_Credito_Saldo     = This.vl_Limite_Credito - This.vl_Limite_Credito_Utilizado
//	End If	

	If This.vl_limite_credito = 000.00 Then			
		adc_limite = 000.00
		lvb_Sucesso = True
	Else			
		This.vl_limite_20 = Round ( ( This.vl_limite_credito * 20 ) / 100 , 2)
		
		//Considera 20% do limite junto com o saldo.			
		adc_limite = This.vl_limite_20 + This.vl_limite_credito_saldo
		lvb_Sucesso = True
	End If			
End If

Return lvb_Sucesso
end function

public function boolean of_retorna_limite_cliente_local (string as_codigo, ref decimal adc_limite);Boolean lvb_Sucesso = False
		
Select vl_limite_credito_aprovado Into :This.vl_limite_credito
From cliente
Where cd_cliente = :as_Codigo
Using SqlCa;
	
Choose Case SqlCa.SqlCode
	Case 0
		
		If IsNull(This.vl_limite_credito) Then This.vl_limite_credito = 00.000
		
		If This.vl_limite_credito = 000.00 Then			
			
			adc_limite = 000.00
			
		Else			
			This.vl_limite_20 = This.vl_limite_credito + ( This.vl_limite_credito * 20 ) / 100							
			//Se a compra ultrapassou 20% do limite do cliente n$$HEX1$$e300$$ENDHEX$$o permite a venda, sen$$HEX1$$e300$$ENDHEX$$o solicita libera$$HEX2$$e700e300$$ENDHEX$$o para valor at$$HEX1$$e900$$ENDHEX$$ 20% maior que o limite.
			
			adc_limite = This.vl_limite_20			
			lvb_Sucesso = True
		End If		
			
	Case 100

			adc_limite = 000.00		
		
	Case -1
		
			adc_limite = 000.00
		
End Choose
	
Return lvb_Sucesso
end function

public function boolean of_existe_cpf_cgc (string as_cpf, ref boolean ab_existe);Boolean lb_Sucesso = False

uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao()

lvo_Conexao.of_Executa_Rotina( "0006",{"Select 1 from cliente where nr_cpf_cgc = '" + as_Cpf + "'"} )

If lvo_Conexao.of_Erro_Execucao( ) Or lvo_Conexao.of_Erro_Conexao( ) Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do cliente pelo CPF '" + as_Cpf + "'." )
Else
	lb_Sucesso = True
	
	ab_Existe = lvo_Conexao.of_Linhas( ) > 0
End If

Destroy lvo_Conexao

Return lb_Sucesso
end function

public function boolean of_atualiza_mensagem_campanha (string ps_cliente, long pl_campanha, string ps_matricula, long pl_filial, string ps_tipo_campanha, string ps_retorno_tela, datetime pdt_abertura_mensagem, datetime pdt_fechamento_mensagem);Long lvl_Row

String lvs_Tabela
String lvs_Set
String lvs_Where

Try

	uo_Transacao_Remota lvo_Conexao
	lvo_Conexao = Create uo_Transacao_Remota
	
	lvo_Conexao.of_BancoProducao()
		
	lvs_Tabela	 = "campanha_cliente"
	
	lvs_Set = " cd_filial_aviso = " + String( pl_Filial ) + ", "
	lvs_Set += " nr_matricula_aviso = '" + ps_Matricula + "',"
	
	lvs_Where	 = " nr_campanha = "  + String( pl_Campanha ) + " and "
	lvs_Where	 += " cd_cliente = '"  + ps_Cliente + "'"
	
	ps_tipo_campanha = Upper(ps_tipo_campanha)
	
	If ps_tipo_campanha = 'EX' Or ps_tipo_campanha = 'MB' Or ps_tipo_campanha = 'EX' Or ps_tipo_campanha = 'AP' Then  //ex-cliente - Melhor Pre$$HEX1$$e700$$ENDHEX$$o - Produto Interesse.												
		If ps_retorno_tela = 'N' Then											
			lvs_Set	+=	 "dh_aviso = '"+ String(pdt_abertura_mensagem, "yyyymmdd hh:mm:ss")+"', "+&
							"dh_tempo_cancelar  = '"+String(pdt_fechamento_mensagem, "yyyymmdd hh:mm:ss")+"',"+& 										
							"dh_tempo_salvar = null"
											
		Else
			lvs_Set	+=	 "dh_aviso = '"+String(pdt_abertura_mensagem, "yyyymmdd hh:mm:ss")+"', "+&				
							"dh_tempo_cancelar  = null "+&
							",dh_tempo_salvar = '"+String(pdt_fechamento_mensagem, "yyyymmdd hh:mm:ss")+"'"
		End If									
	
	Else //Demais Campanhas
		//lvs_Set += " dh_aviso = getdate()" //Ultimo campo a ser atualizado
		//Altera$$HEX2$$e700e300$$ENDHEX$$o soliciada pelo Douglas, para atualizar a informa$$HEX2$$e700e300$$ENDHEX$$o em todas as demais campanhas.
		lvs_Set	+=	 "dh_aviso = '"+String(pdt_abertura_mensagem, "yyyymmdd hh:mm:ss")+"', "+&				
						"dh_tempo_cancelar  = null "+&
						",dh_tempo_salvar = '"+String(pdt_fechamento_mensagem, "yyyymmdd hh:mm:ss")+"'"  				
	End If //Tipo campanha	
	
	If Not lvo_Conexao.of_Update_Registro(lvs_Tabela, lvs_Set, lvs_Where, Ref lvl_Row) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao atualizar os dados da campanha '" + String( pl_Campanha ) + "' do cliente '" + ps_Cliente + "'", Information!)
		Return False
	End If
	
	Return True
	
Finally
	If IsValid(lvo_Conexao) Then Destroy lvo_Conexao
End Try
end function

public function boolean of_grava_aviso_cliente (string as_cliente, string as_matricula_captacao);/*
w_rl001_cadastro_cliente_pf
wf_salva_aviso_cliente tamb$$HEX1$$e900$$ENDHEX$$m usa fun$$HEX2$$e700f500$$ENDHEX$$es parecidas
*/

String ls_Situacao
String ls_Tipo
String ls_Tabela
String ls_Where
String ls_Colunas
String ls_Values
String ls_Situacao_Matriz
String ls_Rede
String ls_Cd_Tipo
String ls_Consentimento

Long ll_Retorno, li_Linhas
Long ll_Filial

Integer li_Row

Try
	uo_Transacao_Remota lo_Conexao
	lo_Conexao = Create uo_Transacao_Remota
	
	lo_Conexao.of_BancoProducao()
	lo_Conexao.of_Define_Variaveis(True)
	
	dc_uo_ds_base lds_Consentimentos
	lds_Consentimentos = Create dc_uo_ds_base
	
	If Not lds_Consentimentos.of_changedataobject( 'ds_ge040_consentimento_cliente' ) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no evento of_changedataobject")
		Return False
	End If
	
	ls_Rede 	= gvo_Parametro.id_rede_filial
	ll_Filial	= gvo_Parametro.cd_filial	
	
	li_Linhas = lds_Consentimentos.Retrieve( as_cliente, ls_Rede )
	
	If li_Linhas < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no retrieve. Fun$$HEX2$$e700e300$$ENDHEX$$o: wf_localiza_consentimento()")
		Return False
	End If
		
	as_Matricula_Captacao	= gf_valida_nulo(as_Matricula_Captacao, True, True)
	
	//A - Ativo
	//I - Inativo
	For li_Row = 1 To li_Linhas
		ls_Cd_Tipo				= String(lds_Consentimentos.Object.cd_tipo_aviso 		[ li_Row ])
		ls_Tipo 					= lds_Consentimentos.Object.de_tipo							[ li_Row ]
		ls_Situacao 				= lds_Consentimentos.Object.id_situacao					[ li_Row ]
		ls_Consentimento 		= String(lds_Consentimentos.Object.dh_consentimento	[ li_Row ], "YYYY/MM/DD HH:MM:SS")
			
		lo_Conexao.of_Executa_Rotina("0006",{"select id_situacao from tipo_aviso_cliente where cd_tipo_aviso = " + ls_Cd_Tipo + " and cd_cliente = '" + as_Cliente + "'" })
		
		If lo_Conexao.of_Erro_Execucao() Or lo_Conexao.of_Erro_Conexao() Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do tipo aviso cliente '" + ls_Tipo + "'.")
			Return False
		End If 	
		
		ls_Cd_Tipo					= gf_valida_nulo(ls_Cd_Tipo, False, True)
		ls_Tipo						= gf_valida_nulo(ls_Tipo, True, True)
		ls_Situacao					= gf_valida_nulo(ls_Situacao, True, True)
		ls_Consentimento			= gf_valida_nulo(ls_Consentimento, True, True)
		
		If lo_Conexao.of_Linhas() = 0 Then
			ls_Tabela 	= 'tipo_aviso_cliente'
			ls_Colunas 	= 'cd_tipo_aviso, cd_cliente, id_situacao, dh_consentimento, cd_filial_inclusao, nr_matricula_inclusao'
			ls_Values	=  ls_Cd_Tipo + ",'" + as_cliente + "'," + &
								ls_Situacao +"," +&
								ls_Consentimento + ","+&
								String(ll_Filial) + ","+&
								as_matricula_captacao
							  
			If Not lo_Conexao.of_Insert_Registro(ls_Tabela,ls_Colunas,ls_Values, Ref ll_Retorno) Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na inclus$$HEX1$$e300$$ENDHEX$$o do tipo_aviso_cliente '" + ls_Cd_Tipo + "/"+as_cliente+"'.")
				Return False
			End If
			
		ElseIf lo_Conexao.of_Linhas() > 0  Then
			If lo_Conexao.of_Retorno("id_situacao", Ref ls_Situacao_Matriz) Then
				
				ls_Situacao_Matriz = gf_valida_nulo(ls_Situacao_Matriz, True, True)
				
				If ls_Situacao <> ls_Situacao_Matriz Then
					ls_Where = "cd_tipo_aviso=" +ls_Cd_Tipo+ " and cd_cliente = '" + as_cliente + "'"
					
					If Not lo_Conexao.of_Update_Registro("tipo_aviso_cliente", "id_situacao=" + ls_Situacao +", dh_consentimento=" +ls_Consentimento + ",cd_filial_atualizacao=" +String(ll_Filial)+", nr_matricula_atualizacao="+as_Matricula_Captacao, ls_Where, Ref ll_Retorno) Then
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do tipo_aviso_cliente " + ls_Cd_Tipo + "/" + as_cliente + ".")
						Return False
					End If	
				End If
			End If
		End If
		
	Next
	
	Return True
Finally
	If IsValid(lo_Conexao) Then Destroy lo_Conexao
End Try

end function

public function boolean of_grava_senha_cliente (string as_cliente, string as_senha, datetime ah_data_alteracao, long al_filial_alteracao, string as_matricula_alteracao, boolean ab_limpa_senha);Boolean	lvb_Sucesso = False

Long		lvl_Row

String	lvs_Tabela
String	lvs_Set
String	lvs_Where
	
uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao()

If IsNull(as_Senha) Then as_Senha = ""
	
lvs_Tabela	 = "cliente"

lvs_Set		 =  " de_hash_senha			= '" + as_senha										+ "',"
If ab_limpa_senha then
	lvs_Set		 +=  " de_senha_venda_credito		= '" + as_senha										+ "',"	
End If
lvs_Set		 += " dh_alteracao_senha				= '" + String(ah_data_alteracao,"yyyymmdd hh:mm:ss")	+ "',"
lvs_Set		 += " cd_filial_alteracao_senha		= "  + String(al_filial_alteracao)				+ ","
lvs_Set		 += " nr_matricula_alteracao_senha	= '" + as_matricula_alteracao 					+ "'"

lvs_Where	 = " cd_cliente = '"  + as_cliente + "'"
		
If Not lvo_Conexao.of_Update_Registro(lvs_Tabela, lvs_Set, lvs_Where, Ref lvl_Row) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na altera$$HEX2$$e700e300$$ENDHEX$$o da senha do cliente '" + as_Cliente + "'.", Information!)
Else
	lvb_Sucesso = True
End If	

Destroy(lvo_Conexao)

Return lvb_Sucesso

end function

public function boolean of_grava_senha_dependente (string as_dependente, string as_senha, datetime ah_data_alteracao, long al_filial_alteracao, string as_matricula_alteracao, boolean ab_limpa_senha);Boolean lvb_Sucesso = False

Long		lvl_Row

String	lvs_Tabela
String	lvs_Set
String	lvs_Where
	
uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao()

If IsNull(as_Senha) Then as_Senha = ""
	
lvs_Tabela	 = "cliente_dependente"

lvs_Set		 =  " de_hash_senha			= '" + as_senha										+ "',"
If ab_limpa_senha then
	lvs_Set		 +=  " de_senha_venda_credito		= '" + as_senha										+ "',"	
End If
lvs_Set		 += " dh_alteracao_senha				= '" + String(ah_data_alteracao,"yyyymmdd hh:mm:ss")	+ "',"
lvs_Set		 += " cd_filial_alteracao_senha		= "  + String(al_filial_alteracao)				+ ","
lvs_Set		 += " nr_matricula_alteracao_senha	= '" + as_matricula_alteracao 					+ "'"

lvs_Where	 = " cd_dependente_cliente = '"  + as_dependente + "'"
		
If Not lvo_Conexao.of_Update_Registro(lvs_Tabela, lvs_Set, lvs_Where, Ref lvl_Row) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na altera$$HEX2$$e700e300$$ENDHEX$$o da senha do dependente '" + as_dependente + "'.", Information!)
Else
	lvb_Sucesso = True
End If	

Destroy(lvo_Conexao)

Return lvb_Sucesso


end function

on uo_cliente_central.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_cliente_central.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;This.of_Inicializa()
end event

