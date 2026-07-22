HA$PBExportHeader$uo_ge142_fechamento_convenio.sru
forward
global type uo_ge142_fechamento_convenio from nonvisualobject
end type
end forward

global type uo_ge142_fechamento_convenio from nonvisualobject
end type
global uo_ge142_fechamento_convenio uo_ge142_fechamento_convenio

type variables
uo_Convenio 			ivo_Convenio 	// GE004
uo_Parametro_Geral 	ivo_Parametro 	// GE014
uo_ge142_Cobesc 	ivo_Cobesc 		// GE253
uo_Titulo 				ivo_Titulo	    // GE020

Integer	ivi_Cont_Excecao

Integer	ivi_Portador_Bradesco, &
			ivi_Portador_Sicredi
			
Decimal ivdc_Vlr_Abatimento
end variables

forward prototypes
public function boolean of_verifica_ultima_data_lote_convenio (long pl_convenio, ref datetime pdh_venda_inicial, ref datetime pdh_venda_final)
public function boolean of_verifica_saldo_conta (long pl_convenio, ref decimal pdc_saldo)
public function date of_ultimo_dia_mes (integer pi_mes, integer pi_ano)
public function date of_verifica_data_vcto_titulo (long pl_convenio)
public function boolean of_tipo_movto_fechamento (ref long pl_codigo)
public function boolean of_insere_titulo (long pl_convenio, long pl_portador, date pdt_vencimento, date pdt_venda_inicial, date pdt_venda_final, decimal pdc_valor, ref string ps_titulo)
public function boolean of_verifica_parametros (ref long pl_matriz, ref date pdt_data)
public function boolean of_inclui_movimento_conta (long pl_convenio, long pl_tipo_movto, date pdt_data, decimal pdc_valor, string ps_titulo)
public function boolean of_tipo_movto_debito (ref long pl_codigo)
protected function boolean of_insere_lote (long pl_convenio, date pdt_venda_inicial, date pdt_venda_final, decimal pdc_vl_lote, decimal pdc_vl_areceber, string ps_titulo, ref long pl_novo_lote)
public function boolean of_fechamento_convenio (long pl_convenio, long pl_portador, date pdt_vencimento, decimal pdc_vl_total_nf, decimal pdc_vl_titulo, decimal pdc_vl_credito_utilizado, decimal pdc_vl_total_selecionado, date pdt_venda_inicial, date pdt_venda_final, ref long pl_new_lote)
public function boolean of_verifica_vlr_a_receber (long pl_convenio, date pdt_venda_inicial, date pdt_venda_final, ref decimal pdc_vlr_a_receber)
public function boolean of_inclui_movimento_conta (long pl_convenio, long pl_tipo_movto, date pdt_data, decimal pdc_valor, string ps_titulo, string ps_id_tipo_lancto, string ps_de_atribuicao, string ps_nr_referencia_1, string ps_nr_referencia_2, string ps_nr_referencia_3)
end prototypes

public function boolean of_verifica_ultima_data_lote_convenio (long pl_convenio, ref datetime pdh_venda_inicial, ref datetime pdh_venda_final);Boolean  lvb_Valido

Integer	lvi_Nr_Dia_Base

DateTime lvdh_Data_Inclusao

DateTime lvdh_Fechamento

Long	lvl_Ano, &
		lvl_Mes, &
		lvl_Dia

SetNull(lvdh_Data_Inclusao)
SetNull(pdh_Venda_Final)

// Localiza data do $$HEX1$$fa00$$ENDHEX$$ltimo lote para o conv$$HEX1$$ea00$$ENDHEX$$nio	
Select Max(dh_venda_final) into :pdh_Venda_Final 
From lote_fechamento_convenio
Where cd_convenio = :pl_Convenio
  and id_situacao <> 'C'
Using SqlCa;

Choose Case SqlCa.Sqlcode 
	Case 0  			
		
		Select nr_dia_base, dh_inclusao
		 Into :lvi_Nr_Dia_base, :lvdh_Data_Inclusao
		 From convenio
		 Where cd_convenio = :pl_Convenio
		 Using SqlCa;
		 
		 If SqlCa.SqlCode = -1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Erro na localiza$$HEX1$$e700$$ENDHEX$$ao do dia base de fechamento do conv$$HEX1$$ea00$$ENDHEX$$nio[" + String(pl_Convenio) + "].", StopSign!, Ok!)
		End If
				
		lvl_Ano 	= Year(Date(gf_GetServerDate()))
		lvl_Mes	= Month(Date(gf_GetServerDate()))
		lvl_Dia	= Day(Date(gf_GetServerDate()))
		
		Select min(dh_fechamento)
		 Into :lvdh_Fechamento
		From convenio_periodo_fechamento
		Where cd_convenio 	= :pl_Convenio
		  and dh_fechamento > :pdh_Venda_Final
		 Using SqlCa;
		 
		 If SqlCa.SqlCode = -1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Erro na localiza$$HEX1$$e700$$ENDHEX$$ao da data de fechamento do conv$$HEX1$$ea00$$ENDHEX$$nio[" + String(pl_Convenio) + "].", StopSign!, Ok!)
		End If
		 
		If IsNull(pdh_Venda_Inicial) and IsNull(pdh_Venda_Final) Then			
			If IsNull(lvdh_Data_Inclusao) Then			
				pdh_Venda_Inicial = DateTime(Date('2011/01/01'),Time('00:00:00'))
			Else
				pdh_Venda_Inicial = lvdh_Data_Inclusao
			End If
		Else
			pdh_Venda_Inicial = DateTime(RelativeDate(Date(pdh_Venda_Final), 1))
		End If
		
		If pdh_Venda_Inicial <= DateTime(Today(),Time('00:00:00') ) then 			
			//pdh_Venda_Final = DateTime( RelativeDate(Today(), -1) , Now() )	

			If IsNull(lvdh_Fechamento) Then
				If lvi_Nr_Dia_Base = 31 Then
					pdh_Venda_Final = DateTime(gf_Retorna_Ultimo_Dia_Mes( RelativeDate(Today(), -1)) )
				Else
					pdh_Venda_Final = DateTime( String(Year(Today())) + "/" + String(Month(Today())) + "/" + String(lvi_Nr_Dia_Base))
				End If
			Else
				pdh_Venda_Final = lvdh_Fechamento
			End If
		Else
			pdh_Venda_Final = pdh_Venda_Inicial
		End If	

		lvb_Valido = True
	
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Erro na verifica$$HEX2$$e700e300$$ENDHEX$$o do $$HEX1$$fa00$$ENDHEX$$ltimo lote do conv$$HEX1$$ea00$$ENDHEX$$nio [" + String(pl_Convenio) + "]." + SqlCa.SqlErrText, StopSign!, Ok!)
		lvb_Valido = False		
End Choose	

Return lvb_Valido
end function

public function boolean of_verifica_saldo_conta (long pl_convenio, ref decimal pdc_saldo);Select s.vl_outros
Into :pdc_Saldo
From convenio c,
     contas_receber_saldo s,
	  parametro p
where c.cd_convenio   	= :pl_Convenio
  and s.cd_conta      		= convert(char(5), c.cd_convenio)
  and s.id_tipo_conta 		= 'CV'
  and s.dh_conta      		= p.dh_fechamento_contas_receber
Using SqlCa;

If SqlCa.SqlCode =  -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Erro na verifica$$HEX2$$e700e300$$ENDHEX$$o do saldo do conv$$HEX1$$ea00$$ENDHEX$$nio [" + String(pl_Convenio) + "]." + SqlCa.SqlErrText, StopSign!)
	Return False
End If

Return True
end function

public function date of_ultimo_dia_mes (integer pi_mes, integer pi_ano);Date lvdt_Data

pi_Mes += 1

If pi_mes = 13 Then
	pi_Mes  = 1
	pi_Ano += 1
End If

lvdt_Data = Date("01/" + String(pi_Mes, "00") + "/" + String(pi_Ano, "0000"))

lvdt_Data = RelativeDate(lvdt_Data, -1)

Return lvdt_Data
end function

public function date of_verifica_data_vcto_titulo (long pl_convenio);Integer 	lvi_Dia_Base, &
        		lvi_Dias_Vencimento, &
        		lvi_Mes, &
		  	lvi_Ano, &
			lvi_Dia_Vencimento_Titulo

String lvs_Data, &
       	lvs_Dia_Semana

Date 	lvdt_Emissao, &
	     lvdt_Fechamento, &
	     lvdt_Vencimento, &
		  lvdt_Data

ivo_Convenio.of_Inicializa()
ivo_Convenio.of_Localiza_Codigo(pl_Convenio)

lvi_Dia_Base        				= ivo_Convenio.Nr_Dia_Base
lvi_Dias_Vencimento 			= ivo_Convenio.Qt_Dias_Vencimento
lvi_Dia_Vencimento_Titulo 	= ivo_Convenio.Nr_Dia_Vencimento_Titulo

lvdt_Emissao = Date(gf_GetServerDate())

// Determina qual a data de fechamento, considerando o dia base cadastrado no conv$$HEX1$$ea00$$ENDHEX$$nio
If Day(lvdt_Emissao) < lvi_Dia_Base Then
	If Month(lvdt_Emissao) = 1 Then
		lvi_Mes = 12
		lvi_Ano = Year(lvdt_Emissao) - 1
	Else
		lvi_Mes = Month(lvdt_Emissao) - 1
		lvi_Ano = Year(lvdt_Emissao)
	End If	
Else
	lvi_Mes = Month(lvdt_Emissao)
	lvi_Ano = Year(lvdt_Emissao)
End If	

lvs_Data = String(lvi_Dia_Base, "00") + "/" + String(lvi_Mes, "00") + "/" + String(lvi_Ano, "0000")

// Verifica se $$HEX1$$e900$$ENDHEX$$ uma data v$$HEX1$$e100$$ENDHEX$$lida, sen$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ o $$HEX1$$fa00$$ENDHEX$$ltimo dia do m$$HEX1$$ea00$$ENDHEX$$s
If IsDate(lvs_Data) Then
	lvdt_Fechamento = Date(lvs_Data)
Else
	lvdt_Fechamento = This.of_Ultimo_Dia_Mes(lvi_Mes, lvi_Ano)
End If

// Determina qual a data de vencimento, considerando o prazo cadastrado no conv$$HEX1$$ea00$$ENDHEX$$nio
lvdt_Vencimento = RelativeDate(lvdt_Fechamento, lvi_Dias_Vencimento)

If lvi_Dia_Vencimento_Titulo > 0 Then
	lvi_Mes = Month(lvdt_Emissao)
	lvi_Ano = Year(lvdt_Emissao)
	
	If Day(lvdt_Emissao) >=  lvi_Dia_Vencimento_Titulo Then
		If lvi_Mes = 13 Then
			lvi_Mes = 1
			lvi_Ano = lvi_Ano + 1
		End If
		lvs_Data = String(lvi_Dia_Vencimento_Titulo, "00") + "/" + String(lvi_Mes + 1, "00") + "/" + String(lvi_Ano, "0000")
	 	// Se aqui a data de vencimento caiu para m$$HEX1$$ea00$$ENDHEX$$s '13'...
		If Pos(lvs_Data, '/13/') > 0 Then
			lvs_Data = gf_Replace(lvs_Data, '/13/', '/12/', 0) // Troca /13/ por /12/
			lvs_Data = String(RelativeDate(Date(lvs_Data), 31), "DD/MM/YYYY") // Soma 31 dias (dezembro tem 31)
		End If
	Else
		lvs_Data = String(lvi_Dia_Vencimento_Titulo, "00") + "/" + String(lvi_Mes, "00") + "/" + String(lvi_Ano, "0000")
	End If 
	// Verifica se $$HEX1$$e900$$ENDHEX$$ uma data v$$HEX1$$e100$$ENDHEX$$lida, sen$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ o $$HEX1$$fa00$$ENDHEX$$ltimo dia do m$$HEX1$$ea00$$ENDHEX$$s
	If IsDate(lvs_Data) Then
		lvdt_Fechamento = Date(lvs_Data)
	Else
		lvdt_Fechamento = This.of_Ultimo_Dia_Mes(lvi_Mes, lvi_Ano)
	End If	
	
	lvdt_Vencimento = lvdt_Fechamento
End If

If lvdt_Emissao >= lvdt_Vencimento Then
	lvdt_Vencimento = RelativeDate(lvdt_Vencimento, 30)
End If	

// Se a data $$HEX1$$e900$$ENDHEX$$ s$$HEX1$$e100$$ENDHEX$$bado ou domingo, altera para segunda-feira
lvs_Dia_Semana = Upper(DayName(lvdt_Vencimento))

Choose Case lvs_Dia_Semana
	Case "SATURDAY" ; lvdt_Vencimento = RelativeDate(lvdt_Vencimento, 2)
	Case "SUNDAY"   ; lvdt_Vencimento = RelativeDate(lvdt_Vencimento, 1)
End Choose

Return lvdt_Vencimento
end function

public function boolean of_tipo_movto_fechamento (ref long pl_codigo);Boolean lvb_Sucesso = False

Select cd_tipo_movimento Into :pl_codigo
From contas_receber_tipo_movimento
Where id_tipo_conta        = 'CV'
  and id_fechamento_vendas = 'S'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		lvb_Sucesso = True
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "C$$HEX1$$f300$$ENDHEX$$digo do movimento de fechamento de vendas n$$HEX1$$e300$$ENDHEX$$o localizado.", StopSign!)
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do C$$HEX1$$f300$$ENDHEX$$digo do Movimento de Fechamento")
End Choose

Return lvb_Sucesso
end function

public function boolean of_insere_titulo (long pl_convenio, long pl_portador, date pdt_vencimento, date pdt_venda_inicial, date pdt_venda_final, decimal pdc_valor, ref string ps_titulo);Boolean 	lvb_Sucesso 			= False, &
			lvb_Chave_Duplicada 	= False

Long lvl_Matriz

Date lvdt_Emissao

String lvs_Responsavel, &
       lvs_Titulo_Banco

Integer lvi_Tipo_Movimento

SetNull(lvs_Titulo_Banco)

If Not This.of_Verifica_Parametros(ref lvl_Matriz, ref lvdt_Emissao) Then
	Return False
End If

// Somente gerar$$HEX1$$e100$$ENDHEX$$ o nr_titulo_banco, se for portador Bradesco
If ivi_Portador_Bradesco = pl_Portador Then

	If Not ivo_Cobesc.of_Titulo_Banco(ref lvs_Titulo_Banco) Then
		Return False
	End If
End If

// Somente gerar$$HEX1$$e100$$ENDHEX$$ o nr_titulo_banco, se for portador Sicredi
If ivi_Portador_Sicredi = pl_Portador Then

	If Not ivo_Cobesc.of_Titulo_Banco_Sicredi(ref lvs_Titulo_Banco) Then
		Return False
	End If
End If

lvl_Matriz = 2
ps_Titulo = ivo_Titulo.of_Proximo_Titulo(lvl_Matriz)

Insert Into titulo_receber (nr_titulo,   
								    cd_filial,   
								    id_tipo_titulo,   
								    cd_portador,   
								    dh_emissao,   
								    dh_vencimento,   
								    dh_calculo_juros,   
								    vl_nominal,   
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
								    cd_convenio,   
								    dh_venda_inicial,   
								    dh_venda_final)
Values (:ps_Titulo,   
		  :lvl_Matriz,   
		  'CV',   
		  :pl_Portador,   
		  :lvdt_Emissao,   
		  :pdt_Vencimento,   
		  :pdt_Vencimento,   
		  :pdc_Valor,   
		  0,   
		  0,   
		  0,   
		  0,   
		  0,   
		  :pdc_Valor,   
		  'A',   
		  'B',   
		  'N',
		  :lvs_Titulo_Banco,
		  :pl_Convenio,   
		  :pdt_Venda_Inicial,   
		  :pdt_Venda_Final)
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	If SqlCa.SqldbCode = 2601 Then lvb_Chave_Duplicada = True	

	// Resgistro j$$HEX1$$e100$$ENDHEX$$ existe na tabela	
	If lvb_Chave_Duplicada Then		
		gf_Delay(3)		
		ivi_Cont_Excecao ++
		
		If ivi_Cont_Excecao < 3 Then
			This.of_Insere_Titulo( pl_Convenio, pl_Portador, pdt_Vencimento, pdt_Venda_Inicial, pdt_Venda_Final, pdc_Valor, ref ps_Titulo)
		End If
	End If
	
	ivi_Cont_Excecao = 1	
	SqlCa.of_MsgdbError("Inclus$$HEX1$$e300$$ENDHEX$$o do T$$HEX1$$ed00$$ENDHEX$$tulo de Conv$$HEX1$$ea00$$ENDHEX$$nio")
	
Else
	lvs_Responsavel = gvo_Aplicacao.ivo_Seguranca.Nr_Matricula
	
	lvi_Tipo_Movimento = ivo_Titulo.of_Movto_Abertura()
	
	Insert Into movimento_titulo_receber (nr_titulo,   
													  nr_movimento,
													  cd_tipo_movimento,   
													  nr_matricula_responsavel,   
													  dh_sistema,					
													  dh_movimento,   
													  dh_credito,
													  vl_movimento,   
													  vl_juros_recebidos,   
													  vl_desconto_concedido,   
													  vl_despesas_recebidas, 
													  id_estorno,   
													  de_historico,   					
													  nr_recibo_cobranca,
													  cd_filial_movimento)
	Values (:ps_Titulo, 
			  1,
			  :lvi_Tipo_Movimento,
			  :lvs_Responsavel,
			  getdate(),   
			  :lvdt_Emissao,   
			  :lvdt_Emissao,   				
			  :pdc_Valor,
			  0,   
			  0,   
			  0,
			  'N',   
			  Null,   
			  Null,
			  :lvl_Matriz)
	Using SqlCa;	
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgdbError("Inclus$$HEX1$$e300$$ENDHEX$$o do Movimento de Abertura")
	Else
		lvb_Sucesso = True
	End If	
End If

Return lvb_Sucesso
end function

public function boolean of_verifica_parametros (ref long pl_matriz, ref date pdt_data);Boolean lvb_Sucesso = False

DateTime lvdh_Data

Select cd_filial_matriz,
       dh_movimentacao
Into :pl_Matriz,
     :lvdh_Data
From parametro
Using SqlCa;

Choose Case SqlCa.SqlCode 
	Case 0
		pdt_Data = Date(lvdh_Data)
		
		lvb_Sucesso = True
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Par$$HEX1$$e200$$ENDHEX$$metros n$$HEX1$$e300$$ENDHEX$$o localizados.", StopSign!)
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o dos Par$$HEX1$$e200$$ENDHEX$$metros")
End Choose

Return lvb_Sucesso
end function

public function boolean of_inclui_movimento_conta (long pl_convenio, long pl_tipo_movto, date pdt_data, decimal pdc_valor, string ps_titulo);string ls_nulo

setnull(ls_nulo)

return this.of_inclui_movimento_conta( pl_convenio, pl_tipo_movto, pdt_data, pdc_valor, ps_titulo, ls_nulo, ls_nulo, ls_nulo, ls_nulo, ls_nulo)
end function

public function boolean of_tipo_movto_debito (ref long pl_codigo);Boolean lvb_Sucesso = False

Select cd_tipo_movimento Into :pl_Codigo
From contas_receber_tipo_movimento
Where id_tipo_conta   = 'CV'
  and id_outro_debito = 'S'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		lvb_Sucesso = True
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "C$$HEX1$$f300$$ENDHEX$$digo do movimento de outros d$$HEX1$$e900$$ENDHEX$$bitos n$$HEX1$$e300$$ENDHEX$$o localizado.", StopSign!)
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do C$$HEX1$$f300$$ENDHEX$$digo do Movimento de Outros D$$HEX1$$e900$$ENDHEX$$bitos")
End Choose

Return lvb_Sucesso
end function

protected function boolean of_insere_lote (long pl_convenio, date pdt_venda_inicial, date pdt_venda_final, decimal pdc_vl_lote, decimal pdc_vl_areceber, string ps_titulo, ref long pl_novo_lote);Long 	lvl_New_Lote

DateTime lvdth_Servidor

Select max(nr_lote_convenio)
Into :lvl_New_Lote
From lote_fechamento_convenio
Where cd_convenio = :pl_Convenio
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do $$HEX1$$fa00$$ENDHEX$$ltimo lote para o conv$$HEX1$$ea00$$ENDHEX$$nio[" + String(pl_Convenio)+"].", StopSign!)
	Return False
End If

If IsNull(lvl_New_Lote) Then 
	lvl_New_Lote = 1 
Else
	lvl_New_Lote ++
End If

lvdth_Servidor = gf_GetServerDate()

Insert Into lote_fechamento_convenio(	cd_convenio, &
													nr_lote_convenio, &
													dh_abertura, &
													dh_venda_inicial, &
													dh_venda_final, &
													vl_lote, &
													vl_receber_empresa, &
													id_situacao, &
													nr_titulo)
Values( 	:pl_Convenio, &
			:lvl_New_Lote, &
			:lvdth_Servidor, &
			:pdt_Venda_Inicial, &
			:pdt_Venda_Final, &
			:pdc_Vl_Lote, &
			:pdc_Vl_AReceber, &
			"F", &
			:ps_Titulo )
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Erro ao incluir novo lote de fechamento para o conv$$HEX1$$ea00$$ENDHEX$$nio[" + String(pl_Convenio) + "]." + SqlCa.SqlErrText, StopSign!)
	Return False
End If

Update nf_venda
	 set nr_lote_convenio = :lvl_New_Lote
from nf_venda nf (index idx_convenio_data)
where nf.cd_convenio = :pl_convenio 
  and nf.dh_movimentacao_caixa >= :pdt_Venda_Inicial
  and nf.dh_movimentacao_caixa <= :pdt_Venda_Final
  and nf.dh_cancelamento is null
  and nf.nr_nf_anexa is null
Using SqlCa;
  
If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do novo lote nas notas fiscais de vendas para o conv$$HEX1$$ea00$$ENDHEX$$nio[" + String(pl_Convenio) + "].", StopSign!)
	Return False
End If

Update nf_venda
	 set nr_lote_convenio = :lvl_New_Lote
from nf_venda nf (index idx_lote_convenio)
where nf.cd_convenio = :pl_convenio 
  and nf.dh_movimentacao_caixa < :pdt_Venda_Inicial 
  and nf.dh_cancelamento is null 
  and nf.nr_nf_anexa is null
  and nf.nr_lote_convenio is null
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do novo lote nas notas fiscais de vendas para o conv$$HEX1$$ea00$$ENDHEX$$nio[" + String(pl_Convenio) + "].", StopSign!)
	Return False
End If

pl_Novo_Lote = lvl_New_Lote

Return True
end function

public function boolean of_fechamento_convenio (long pl_convenio, long pl_portador, date pdt_vencimento, decimal pdc_vl_total_nf, decimal pdc_vl_titulo, decimal pdc_vl_credito_utilizado, decimal pdc_vl_total_selecionado, date pdt_venda_inicial, date pdt_venda_final, ref long pl_new_lote);Boolean lvb_Sucesso = False

Long 	lvl_Total, &
     	lvl_Contador, &
	  	lvl_Convenio, &
	  	lvl_Convenio_Anterior, &
	  	lvl_Lote, &
	  	lvl_Tipo_Movto, &
	  	lvl_Filial


Date 	lvdt_Venda_Inicial, &
	  	lvdt_Venda_Final, &
	  	lvdt_Movto

String 	lvs_Titulo, &
       		lvs_Fechar, ls_nulo

Decimal 	lvdc_Valor_Lote, &
       		lvdc_Total_Convenio, &
		  	lvdc_Total_Geral, &
			lvdc_Vlr_A_Receber, &
			lvdc_Valor_Titulo

setnull(ls_nulo)

ivi_Cont_Excecao = 1

// Localiza o c$$HEX1$$f300$$ENDHEX$$digo do movimento de fechamento de vendas
If Not This.of_Tipo_Movto_Fechamento(ref lvl_Tipo_Movto) Then Return False

//Considerar a data atual para fechamentos e movimentos, para preservar a posi$$HEX2$$e700e300$$ENDHEX$$o CRE
If Not This.of_verifica_parametros( ref lvl_Filial, ref lvdt_Movto) Then Return False

// Verifica novamente o vlr a receber para evitar diferen$$HEX1$$e700$$ENDHEX$$as entre o t$$HEX1$$ed00$$ENDHEX$$tulo a fechar e notas
If Not This.of_verifica_vlr_a_receber(pl_Convenio, pdt_Venda_Inicial, pdt_Venda_Final, Ref lvdc_Vlr_A_Receber) Then Return False

If lvdc_Vlr_A_Receber > 0 Then	
	lvdc_Valor_Titulo = Round(lvdc_Vlr_A_Receber * ((100 - ivdc_Vlr_Abatimento) / 100), 2)
	lvdc_Valor_Titulo = lvdc_Valor_Titulo - pdc_vl_credito_utilizado
End If	

If lvdc_Valor_Titulo <> pdc_Vl_Titulo Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "H$$HEX1$$e100$$ENDHEX$$ diverg$$HEX1$$ea00$$ENDHEX$$ncias entre o valor do t$$HEX1$$ed00$$ENDHEX$$tulo informado e o que ser$$HEX1$$e100$$ENDHEX$$ fechado do conv$$HEX1$$ea00$$ENDHEX$$nio: " + String(pl_Convenio), StopSign!)
	Return False
End If
//

// Inclui o t$$HEX1$$ed00$$ENDHEX$$tulo e o movimento de t$$HEX1$$ed00$$ENDHEX$$tulo a receber
If This.of_Insere_Titulo(	pl_Convenio, &
                    				pl_Portador, &
								pdt_Vencimento, &
								pdt_Venda_Inicial, &
								pdt_Venda_Final, &
								pdc_Vl_Titulo, &
  								ref lvs_Titulo) Then
								  
	If This.of_Insere_Lote(	pl_Convenio, &
									pdt_Venda_Inicial, &
									pdt_Venda_Final, &
									pdc_Vl_Total_NF, &
									pdc_Vl_Titulo, &
									lvs_Titulo, &
									ref pl_New_Lote) Then
									
//		If This.of_Inclui_Movimento_Conta(	pl_Convenio, &
//														lvl_Tipo_Movto, &
//														pdt_Venda_Final, &
//														pdc_Vl_Total_NF, &
//														lvs_Titulo) Then

		If This.of_Inclui_Movimento_Conta(	pl_Convenio, &
														lvl_Tipo_Movto, &
														lvdt_Movto, &
														pdc_Vl_Titulo, &
														lvs_Titulo) Then
															
			// Verifica a necessidade de lan$$HEX1$$e700$$ENDHEX$$ar o d$$HEX1$$e900$$ENDHEX$$bito referente ao cr$$HEX1$$e900$$ENDHEX$$dito utilizado
			If pdc_Vl_Credito_Utilizado > 0 Then
				If This.of_Tipo_Movto_Debito(ref lvl_Tipo_Movto) Then
//					If This.of_Inclui_Movimento_Conta(	pl_Convenio, &
//																	lvl_Tipo_Movto, &
//																	lvdt_Movto, &
//																	pdc_Vl_Credito_Utilizado, &															 
//																	lvs_Titulo) Then
//						lvb_Sucesso = True
//					End If

					If This.of_Inclui_Movimento_Conta(	pl_Convenio, &
																	lvl_Tipo_Movto, &
																	lvdt_Movto, &
																	pdc_Vl_Credito_Utilizado, &															 
																	lvs_Titulo, &
																	ls_nulo, &
																	ls_nulo, &
																	lvs_Titulo, &
																	ls_nulo, &
																	'OC.' + string(pl_Convenio)) Then
						lvb_Sucesso = True
					End If

				End If
			Else
				lvb_Sucesso = True
			End If
		End If // If This.of_Inclui_Movimento_Conta
	End If // If This.of_Insere_Lote
End If // If This.of_Insere_Titulo

If lvb_Sucesso Then
	SqlCa.of_Commit()	
Else
	SqlCa.of_RollBack()
End If

Return lvb_Sucesso
end function

public function boolean of_verifica_vlr_a_receber (long pl_convenio, date pdt_venda_inicial, date pdt_venda_final, ref decimal pdc_vlr_a_receber);Decimal	lvdc_Vl_Total_Nf, &
			lvdc_Vl_Total_Pago_Avista, &
			lvdc_Vl_Total_Receber
			
select sum(x.vl_total_nf),
         sum(x.vl_total_pago_avista)
into 	:lvdc_Vl_Total_Nf, &
		:lvdc_Vl_Total_Pago_Avista
from (
select coalesce(sum(nf.vl_total_nf),0) vl_total_nf,
       coalesce(sum(nf.vl_pago_avista),0) vl_total_pago_avista
from nf_venda nf (index idx_convenio_data)
where nf.cd_convenio 			 	= :pl_Convenio 
  and nf.dh_movimentacao_caixa >= :pdt_Venda_Inicial
  and nf.dh_movimentacao_caixa <= :pdt_Venda_Final 
  and nf.dh_cancelamento is null
  and nf.nr_nf_anexa is null
union
select coalesce(sum(nf.vl_total_nf),0),
       	coalesce(sum(nf.vl_pago_avista),0)
from nf_venda nf (index idx_lote_convenio)
where nf.cd_convenio 				= :pl_Convenio
  and nf.dh_movimentacao_caixa < :pdt_Venda_Inicial 
  and nf.dh_cancelamento is null 
  and nf.nr_nf_anexa is null
  and nf.nr_lote_convenio is null
) x
Using SqlCa;
  
If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o dos valores de vendas do conv$$HEX1$$ea00$$ENDHEX$$nio[" + String(pl_Convenio) + "]" + SqlCa.SqlErrText, StopSign!)
	Return False
End If

pdc_vlr_a_receber = lvdc_Vl_Total_Nf - lvdc_Vl_Total_Pago_Avista
  
Return True
end function

public function boolean of_inclui_movimento_conta (long pl_convenio, long pl_tipo_movto, date pdt_data, decimal pdc_valor, string ps_titulo, string ps_id_tipo_lancto, string ps_de_atribuicao, string ps_nr_referencia_1, string ps_nr_referencia_2, string ps_nr_referencia_3);String lvs_Conta, &
       lvs_Documento

lvs_Conta = String(pl_Convenio)

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
												  nr_matricula_inclusao,
												  id_tipo_lancto,
												  de_atribuicao,
												  nr_referencia_1,
												  nr_referencia_2,
												  nr_referencia_3)  
Select :lvs_Conta,
       'CV',
		 :pl_Tipo_Movto,
		 :pdt_Data,
		 getdate(),
		 :pdc_Valor,
		 cd_filial_matriz,
		 :lvs_Documento,
		 null,
		 :ps_Titulo,
		 :gvo_aplicacao.ivo_seguranca.nr_matricula,
		 :ps_id_tipo_lancto,
		 :ps_de_atribuicao,
		 :ps_nr_referencia_1,
		 :ps_nr_referencia_2,
		 :ps_nr_referencia_3
From parametro
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Inclus$$HEX1$$e300$$ENDHEX$$o do Movimento")
	Return False
End If

Return True
end function

on uo_ge142_fechamento_convenio.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge142_fechamento_convenio.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ivo_Convenio 	= Create uo_Convenio
ivo_Parametro 	= Create uo_Parametro_Geral
ivo_Cobesc 		= Create uo_ge142_Cobesc
ivo_Titulo 		= Create uo_Titulo

If Not ivo_Parametro.of_Localiza_Parametro("CD_PORTADOR_BRADESCO", ref ivi_Portador_Bradesco) Then
	Destroy(ivo_Parametro)
End If

If Not ivo_Parametro.of_Localiza_Parametro("CD_PORTADOR_SICREDI", ref ivi_Portador_Sicredi) Then
	Destroy(ivo_Parametro)
End If


end event

event destructor;Destroy(ivo_Convenio)
Destroy(ivo_Parametro)
Destroy(ivo_Titulo)
Destroy(ivo_Cobesc)

end event

