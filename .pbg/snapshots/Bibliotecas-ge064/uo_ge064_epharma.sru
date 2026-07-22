HA$PBExportHeader$uo_ge064_epharma.sru
forward
global type uo_ge064_epharma from nonvisualobject
end type
end forward

global type uo_ge064_epharma from nonvisualobject
end type
global uo_ge064_epharma uo_ge064_epharma

type variables
constant long cd_convenio                  = 52718
constant long cd_condicao_convenio  = 204
constant string cd_conveniado_venda = '999999'

integer ivi_tempo_espera,&
           cd_tipo_comissao

string  nr_autorizacao,& 
          nr_nsu,&
          cd_tipo_venda, &
          nr_matricula_operador, &
          nr_matricula_vendedor,&
          cd_forma_pagamento, &
          nm_vendedor, &
          nm_operador,&
          nm_conveniado,&
          cd_conveniado,&
		 retorno, &
		 de_rejeicao, &
		 nm_dependente

string lvs_recibo[]

decimal {2} vl_total_produtos                

datetime dh_validade, &
			dh_emissao

boolean Localizado, &
              ivb_Inicializacao = False ,&
              ivb_Consulta       = False,&
              ivb_Modo_Teste = False,&
			ivb_Obriga_Receita = False,&
			ivb_Capturou_Receita = False,&
			ivb_Produto_Rejeitado = False,& 
			ivb_dependente = False

string ivs_path_rec, &
         ivs_path_env, &
         ivs_path_tmp, &
		ivs_epharma_plugin, &
		ivs_arquivo_digitalizado

Long nr_nc, &
         nr_ecf		

dc_uo_api ivo_api
uo_ge073_gera_xml ivo_xml 

constant string SOLICITACAO		= "solaut.txt", &
                     	VENDA    			= "venda.txt",&
                     	REIMPRESSAO    	=  "reimpressao.txt", &
                      	CANCELAMENTO 	= "cancelamento.txt",&
                      	FECHAMENTO     	= "fechamento.txt",&
                      	ATIVIDADE     		= "atividade.txt",&
                      	INICIALIZACAO    	= "inicializacao.txt",&
                      	CONSULTA          	= "consulta.txt", &
                      	DESCONEXAO    	= "desconexao.txt", &
					DIGITALIZACAO  	= "digitalizacao.txt", &
               		SOLIC_DEP    		= "solaut.txt_DEP"

                        
                        

end variables

forward prototypes
public function boolean of_grava_arquivo (integer ai_arquivo, string as_linha)
public function boolean of_ini_correto ()
public function boolean of_abre_arquivo (string as_nome, ref integer ai_arquivo, string as_tipo)
public subroutine of_inicializa ()
public function decimal of_decimal (string as_valor, integer ai_decimal)
public function string of_decimal (decimal adc_valor, integer ai_tamanho, integer ai_decimal)
public function boolean of_produto_codigo_barras (string as_codigo_barras, ref long al_produto)
public function boolean of_confirmacao_venda_ok ()
public function boolean of_solicita_confirmacao_venda (string as_produto[], integer ai_qtde[], decimal adc_preco[])
public function boolean of_grava_confirmacao_venda (string as_produto[], integer ai_qtde[], decimal adc_preco[])
public function boolean of_inclui_produto_autorizacao (string as_autorizacao, long al_produto, string as_codigo_barras, integer ai_qtde, decimal adc_preco_maximo, decimal adc_preco_desconto, decimal adc_preco_epharma, decimal adc_preco_aquisicao, decimal adc_repasse_varejo, string as_rejeicao)
public function boolean of_grava_autorizacao (ref string as_autorizacao, string as_convenio, string as_cartao, date adt_receita, string as_tipo_prescritor, string as_registro_prescritor)
public function boolean of_solicita_reimpressao_recibo (string as_transacao, long ai_convenio)
public function boolean of_grava_solicitacao_reimpressao_recibo (string as_transacao, integer ai_convenio)
public function boolean of_confirmacao_reimpressao ()
public function boolean of_grava_fechamento ()
public function boolean of_confirmacao_fechamento ()
public function boolean of_fechamento ()
public function boolean of_grava_teste_gerenciador ()
public function boolean of_confirmacao_atividade_gerenciador ()
public function boolean of_gerenciador_ativo ()
public function boolean of_resposta_gerenciador_ativo ()
public function boolean of_grava_inicializacao ()
public function boolean of_trata_arquivo_temporario (string as_arquivo_tmp, string as_arquivo_env, boolean ab_sucesso)
public function string of_motivo_rejeicao (string as_codigo)
public subroutine of_imprime_autorizacao (string as_autorizacao)
public function boolean of_desconexao ()
public function boolean of_grava_desconexao ()
public function boolean of_confirmacao_desconexao ()
public function boolean of_resposta_recebida (string as_arquivo, string as_mensagem)
public subroutine of_exclui_arquivo_enviado (string as_arquivo)
public function boolean of_abre_arquivo_log (string as_nome, ref integer ai_arquivo)
public function boolean of_grava_arquivo_log (integer ai_arquivo, string as_linha)
public function boolean wf_atualiza_convenio_epharma (integer pi_arquivo)
public function boolean of_atualiza_convenio_epharma (integer pi_arquivo, ref string ps_mensagem_erro)
public function boolean of_confirmacao_inicializacao (ref string ps_mensagem)
public function boolean of_inicializacao (ref string ps_mensagem)
public subroutine of_carrega_parametros (ref long pl_filial, ref long pl_filial_matriz)
public subroutine of_exclui_arquivo_recebido (string as_arquivo)
public function boolean of_grava_solicitacao (string as_cartao, string as_convenio, date adt_data_receita, string as_tipo_prescritor, string as_crm, string as_uf, string as_produto[], integer ai_qtde[], decimal adc_preco_venda_maximo[], decimal adc_preco_venda[])
public function long of_valor_sem_pontuacao (decimal adc_valor)
public function boolean of_processa_retorno_cancelamento ()
public function boolean of_verifica_transacao (string as_transacao, ref string as_ecf, ref string as_cupom, string as_tipo)
public function boolean of_cancela_transacao (string as_transacao, string as_cupom, string as_ecf, string as_tipo)
public function boolean of_transacao_cancelamento (string as_transacao, string as_tipo)
public function boolean of_solicita_autorizacao (string as_cartao, string as_convenio, date adt_data_receita, string as_tipo_prescritor, string as_crm, string as_uf, string as_produto[], integer ai_qtde[], decimal adc_preco_venda_maximo[], decimal adc_preco_venda[])
public function boolean of_exclui_autorizacao (string as_autorizacao)
public function boolean of_inclui_autorizacao (string as_autorizacao, date adt_validade, long al_convenio, string as_cartao, string as_paciente, date adt_receita, string as_tipo_prescritor, string as_registro_prescritor)
public function boolean of_processa_retorno_consulta (string as_autorizacao, long al_convenio)
public function boolean of_consulta_autorizacao (string as_autorizacao, long al_convenio)
public function boolean of_grava_consulta (string as_autorizacao)
public function boolean of_captura_imagem ()
public function boolean of_valida_linha_retorno (string ps_registro)
public function boolean of_grava_digitalizacao (string as_transacao, string as_caminho_arquivo)
public function boolean of_processa_retorno_digitalizacao ()
public function boolean of_grava_solicitacao_cancelamento (string as_transacao, string as_cupom, string as_ecf, string as_tipo)
public function boolean of_verifica_licensa_antiga (ref string as_licensa)
public function datetime of_verifica_data_arquivo (string as_filename)
public function boolean of_cria_diretorios_epharma_plugin ()
public function boolean of_atualiza_config_epharma_plugin ()
public function boolean of_existe_licenca ()
public function boolean of_selecao_dependente (ref string as_dependente)
public function boolean of_grava_solicitacao_dep (string as_dependente)
end prototypes

public function boolean of_grava_arquivo (integer ai_arquivo, string as_linha);Integer lvi_Write

lvi_Write = FileWrite(ai_Arquivo, as_Linha)

If lvi_Write = LenA(as_Linha) Then
	Return True
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do arquivo.", StopSign!)
	Return False
End If
end function

public function boolean of_ini_correto ();String lvs_ePharma, &
       lvs_Espera,&
	   lvs_Modo

If Upper(Trim(ivs_epharma_plugin)) = 'S' Then
	lvs_ePharma = "C:\e-PharmaPlugin\"
Else
	lvs_ePharma = "C:\epharma\"	
End If
lvs_Espera  = "120"

lvs_Modo = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, "Desenvolvimento", "Modo", "")

If Trim(lvs_ePharma) = "" or &
   Trim(lvs_Espera)  = "" Then
	Return False
End If

If Not IsNumber(lvs_Espera) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Par$$HEX1$$e200$$ENDHEX$$metro tempo de espera e-Pharma '" + lvs_Espera + "' inv$$HEX1$$e100$$ENDHEX$$lido.", StopSign!)
	Return False
End If

If lvs_Modo = "Teste" Then
	ivb_Modo_Teste = True
End If

This.ivi_Tempo_Espera = Integer(lvs_Espera)

If RightA(lvs_ePharma, 1) <> "\" Then
	lvs_ePharma += "\"
End If

This.ivs_Path_REC = lvs_ePharma + "rec\"
This.ivs_Path_ENV = lvs_ePharma + "env\"
This.ivs_Path_TMP = lvs_ePharma + "tmp\"

Return True
end function

public function boolean of_abre_arquivo (string as_nome, ref integer ai_arquivo, string as_tipo);//Aguarda 03 segundos
Yield()
gf_Delay(3)
Yield()

If as_Tipo = "G" Then
	This.of_Exclui_Arquivo_Enviado(as_Nome)
	ai_Arquivo = FileOpen(as_Nome, LineMode!, Write!, Shared!, Replace!)
Else
	// Se a leitura do arquivo for de inicializacao ou de consulta
	If ivb_Inicializacao or ivb_Consulta Then
		
		SetPointer(HourGlass!)
		//Aguarda 08 segundos
		Yield()
		gf_Delay(08)
		Yield()
		SetPointer(Arrow!)
	End If
	ai_Arquivo = FileOpen(as_Nome, LineMode!, Read!, Shared!, Append!)
End If

If ai_Arquivo > 0 Then
	Return True
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na abertura do arquivo '" + as_Nome + "'.", StopSign!)
	Return False
End If
end function

public subroutine of_inicializa ();SetNull(nr_autorizacao) 
SetNull(nr_nsu) 
SetNull(cd_tipo_venda)
SetNull(nr_matricula_operador)
SetNull(nr_matricula_vendedor)
SetNull(cd_forma_pagamento)
SetNull(nm_vendedor)
SetNull(nm_operador)
SetNull(cd_tipo_comissao)
SetNull(retorno)
SetNull(de_rejeicao)
SetNull(ivs_arquivo_digitalizado)
Setnull(nm_dependente)

vl_total_produtos = 0.00
nr_ecf            = 0
nr_nc             = 0

SetNull(dh_validade)
SetNull(dh_emissao)

ivb_Obriga_Receita = False
ivb_Capturou_Receita = False
ivb_dependente = False
end subroutine

public function decimal of_decimal (string as_valor, integer ai_decimal);Decimal lvdc_Valor

String lvs_Temp

lvs_Temp = LeftA(as_Valor, LenA(as_Valor) - ai_Decimal) + "," + RightA(as_Valor, ai_Decimal)

lvdc_Valor = Dec(lvs_Temp)

Return lvdc_Valor
end function

public function string of_decimal (decimal adc_valor, integer ai_tamanho, integer ai_decimal);String lvs_Valor, &
       lvs_Zeros, &
		 lvs_Decimal

Integer lvi_Contador

If IsNull(adc_Valor) Then adc_Valor = 0

For lvi_Contador = 1 To ai_Decimal
	lvs_Decimal += "0"
Next

lvs_Valor = String(adc_Valor, "0." + lvs_Decimal)

lvs_Valor = LeftA(lvs_Valor, LenA(lvs_Valor) - ai_Decimal - 1) + RightA(lvs_Valor, ai_Decimal)

For lvi_Contador = 1 To ai_Tamanho - LenA(lvs_Valor)
	lvs_Zeros += "0"
Next

lvs_Valor = lvs_Zeros + lvs_Valor

Return lvs_Valor
end function

public function boolean of_produto_codigo_barras (string as_codigo_barras, ref long al_produto);Select cd_produto Into :al_Produto
From codigo_barras_produto
Where de_codigo_barras = :as_Codigo_Barras
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		Return True
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O c$$HEX1$$f300$$ENDHEX$$digo de barras n$$HEX1$$e300$$ENDHEX$$o foi localizado '" + as_Codigo_Barras + "'.")
		Return False
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do C$$HEX1$$f300$$ENDHEX$$digo Interno do Produto")
		Return False
End Choose
end function

public function boolean of_confirmacao_venda_ok ();Integer lvi_Arquivo, &
		  lvi_Ind

String  lvs_Arquivo, &
        lvs_Registro, &
		  lvs_Sequencial, &
		  lvs_Funcao, &
		  lvs_Status, &
		  lvs_Mensagem, &
	 	  lvs_Transacao, &
	 	  lvs_NSU, &
		  lvs_Linha_Recibo, &
		  lvs_Vazio[]
		 		  
Long    lvl_Conta		 

Boolean lvb_Retorno = False
		 
lvs_Arquivo = This.ivs_Path_REC + This.VENDA

If Not This.of_Abre_Arquivo(lvs_Arquivo, lvi_Arquivo, "L") Then Return False

FileRead(lvi_Arquivo, lvs_Registro)

lvs_Sequencial = MidA(lvs_Registro, 1, 4)
lvs_Funcao     = MidA(lvs_Registro, 5, 2)
lvs_Status     = MidA(lvs_Registro, 7, 2)
lvs_Mensagem   = MidA(lvs_Registro, 9, 40)
lvs_Transacao  = MidA(lvs_Registro, 49, 7)
lvs_NSU        = MidA(lvs_Registro, 56, 12)

If lvs_Sequencial <> "0002" Then
	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Sequencial recebido no arquivo de resposta inv$$HEX1$$e100$$ENDHEX$$lido.", StopSign!)
	
Else
	 
	If lvs_Funcao <> "03" Then
		
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Fun$$HEX2$$e700e300$$ENDHEX$$o recebida no arquivo de resposta inv$$HEX1$$e100$$ENDHEX$$lida.", StopSign!)

	Else
	
		If lvs_Status = "ER" Then
			
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Arquivo de resposta retornou um erro.~r~r" + lvs_Mensagem, StopSign!)
			
		ElseIf lvs_Status = "OK" Then
			
			FileRead(lvi_Arquivo, lvs_Registro)
			
			This.lvs_Recibo = lvs_Vazio
			
			lvs_Linha_Recibo = ''
			
			For lvl_conta = 1 To LenA(Trim(lvs_Registro))
				
				If MidA(lvs_Registro,lvl_conta,1) <> '@' Then
					
					lvs_Linha_Recibo = lvs_Linha_Recibo + MidA(lvs_Registro,lvl_conta,1)
					
				Else
					
					lvi_Ind ++
					
					This.lvs_Recibo[lvi_Ind] = lvs_Linha_Recibo
					
					lvs_Linha_Recibo = ''
								
				End If
		
			Next
			
			This.lvs_Recibo[lvi_Ind] = lvs_Linha_Recibo
			This.nr_nsu              = lvs_nsu
			
			lvb_Retorno = True
			
		Else
			
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Retorno no arquivo de resposta diferente do esperado. " + lvs_Status + "~r~r" + lvs_Mensagem, StopSign!)
			
		End If
		
	End If
	
End If	
//
FileClose(lvi_Arquivo)
//
ivo_api.of_delete_file(lvs_arquivo)
//
Return lvb_Retorno

end function

public function boolean of_solicita_confirmacao_venda (string as_produto[], integer ai_qtde[], decimal adc_preco[]);Boolean lvb_Sucesso = False

String lvs_Arquivo, &
       lvs_Arquivo_ENV

lvs_Arquivo_ENV = This.ivs_Path_ENV + This.VENDA

If This.of_Grava_Confirmacao_Venda(as_Produto[], &
            							  ai_Qtde[], &
											  adc_preco[]) Then
									  
	If This.of_Resposta_Recebida(This.VENDA, "Aguardando Confirma$$HEX2$$e700e300$$ENDHEX$$o da Venda") Then
		lvb_Sucesso = This.of_Confirmacao_Venda_Ok()
	Else
		If FileExists(lvs_Arquivo_ENV) Then
			This.of_Exclui_Arquivo_Enviado(lvs_Arquivo_ENV)
		End If
	End If
End If

//This.of_Desconexao()

Return lvb_Sucesso
end function

public function boolean of_grava_confirmacao_venda (string as_produto[], integer ai_qtde[], decimal adc_preco[]);Boolean lvb_Sucesso = True

Integer lvi_Arquivo, &
        lvi_Contador

String lvs_Arquivo_ENV, &
       lvs_Arquivo_TMP, &
		 lvs_Arquivo_REC, &
       lvs_Linha, &
		 lvs_Preco, &
		 lvs_Produto
		 
If UpperBound(as_Produto) <> UpperBound(ai_Qtde) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$fa00$$ENDHEX$$mero de produtos $$HEX1$$e900$$ENDHEX$$ diferente das quantidades.", StopSign!)
	Return False
End If

lvs_Arquivo_TMP = This.ivs_Path_TMP + This.VENDA
lvs_Arquivo_ENV = This.ivs_Path_ENV + This.VENDA
lvs_Arquivo_REC = This.ivs_Path_REC + This.VENDA

//Exclui arquivo de retorno antigo.
This.of_exclui_arquivo_recebido(lvs_Arquivo_REC)

If Not This.of_Abre_Arquivo(lvs_Arquivo_TMP, lvi_Arquivo, "G") Then Return False

// Grava a linha de cabe$$HEX1$$e700$$ENDHEX$$alho
lvs_Linha = "0002" + &
            "03"   + &
            String(This.Nr_Ecf,'0000')  + &
				String(This.Nr_NC,'000000') + &
				String(Long(This.Nr_Autorizacao),'000000000000') + &
				"1"

If This.of_Grava_Arquivo(lvi_Arquivo, lvs_Linha) Then
	
	// Grava as linhas dos produtos
	For lvi_Contador = 1 To UpperBound(as_Produto)
		
		lvs_Produto = as_Produto[lvi_Contador]
		
		If LenA(lvs_Produto) <> 13 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produto '" + lvs_Produto + "' com tamanho inv$$HEX1$$e100$$ENDHEX$$lido.", StopSign!)
			lvb_Sucesso = False
			Exit
		End If
		
		lvs_preco = String(adc_preco[lvi_contador]*100,'0000000') 
		
		lvs_Linha = lvs_Produto + &
						String(ai_Qtde[lvi_Contador], "00") + &
						lvs_preco + &
						"1" + &						
						"00000000" + &
						"0000000"  + &
						Space(40)						
	
		If Not This.of_Grava_Arquivo(lvi_Arquivo, lvs_Linha) Then
			lvb_Sucesso = False					
			Exit
		End If
		
	Next
Else
	lvb_Sucesso = False
End If

FileClose(lvi_Arquivo)

Return This.of_Trata_Arquivo_Temporario(lvs_Arquivo_TMP, lvs_Arquivo_ENV, lvb_Sucesso)	
end function

public function boolean of_inclui_produto_autorizacao (string as_autorizacao, long al_produto, string as_codigo_barras, integer ai_qtde, decimal adc_preco_maximo, decimal adc_preco_desconto, decimal adc_preco_epharma, decimal adc_preco_aquisicao, decimal adc_repasse_varejo, string as_rejeicao);Insert Into autorizacao_epharma_produto (nr_autorizacao,
                                         cd_produto,
											        de_codigo_barras,
													  qt_autorizada,
													  vl_preco_maximo,
													  vl_preco_com_desconto,
													  vl_preco_epharma,
													  vl_preco_aquisicao,
													  vl_repasse_varejo,
													  cd_motivo_rejeicao)
Values (:as_Autorizacao,
        :al_Produto,
		  :as_Codigo_Barras,
		  :ai_Qtde,
		  :adc_Preco_Maximo,
		  :adc_Preco_Desconto,
		  :adc_Preco_ePharma,
		  :adc_Preco_Aquisicao,
		  :adc_Repasse_Varejo,
		  :as_Rejeicao)
Using SqlCa;

If SqlCa.SqlCode = - 1 Then
	SqlCa.of_MsgdbError("Inclus$$HEX1$$e300$$ENDHEX$$o do Produto da Autoriza$$HEX2$$e700e300$$ENDHEX$$o")
	Return False
Else
	Return True
End If
end function

public function boolean of_grava_autorizacao (ref string as_autorizacao, string as_convenio, string as_cartao, date adt_receita, string as_tipo_prescritor, string as_registro_prescritor);Boolean lvb_Sucesso = False

Integer	lvi_Arquivo, &
			lvi_Qtde, &
			lvi_Read

Decimal	lvdc_Preco_Maximo, &
			lvdc_Preco_Desconto, &
			lvdc_Preco_ePharma, &
			lvdc_Preco_Aquisicao, &
			lvdc_Repasse_Varejo

String	lvs_Arquivo, &
		lvs_Registro, &
		lvs_Sequencial, &
		lvs_Funcao, &
		lvs_Status, &
		lvs_Mensagem, &
		lvs_Transacao, &
		lvs_Validade, &
		lvs_Paciente, &
		lvs_Codigo_Barras, &
		lvs_Rejeicao, &
		lvs_Menor_Preco, &
		lvs_Receita, &
		ls_Texto_Email_Log
		 
Long	lvl_Produto,&
		lvl_Convenio

Date lvdt_Validade

lvs_Arquivo = This.ivs_Path_REC + This.SOLICITACAO

If Not This.of_Abre_Arquivo(lvs_Arquivo, lvi_Arquivo, "L") Then Return False

FileRead(lvi_Arquivo, lvs_Registro)

lvs_Sequencial  = MidA(lvs_Registro, 1, 4)
lvs_Funcao      = MidA(lvs_Registro, 5, 2)
lvs_Status      = MidA(lvs_Registro, 7, 2)
lvs_Mensagem    = MidA(lvs_Registro, 9, 40)
lvs_Transacao   = MidA(lvs_Registro, 49, 7)
as_Autorizacao  = MidA(lvs_Registro, 56, 12)
lvs_Validade    = MidA(lvs_Registro, 68, 6)
lvs_Paciente    = MidA(lvs_Registro, 74, 24)
This.dh_emissao = DateTime(Today(), Now())

If Upper(Trim(ivs_epharma_plugin)) = 'S' Then
	lvs_Receita    = MidA(lvs_Registro, 109, 1)
	If lvs_Receita = '2' Then
		This.ivb_Obriga_Receita = True
	Else
		This.ivb_Obriga_Receita = False
	End If	
End If

lvl_Convenio = Long(as_Convenio)

If lvs_Sequencial <> "0001" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Sequencial recebido no arquivo de resposta inv$$HEX1$$e100$$ENDHEX$$lido. uo_ge064_epharma.of_grava_autorizacao()", StopSign!)
Else
	If lvs_Funcao <> "01" Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Fun$$HEX2$$e700e300$$ENDHEX$$o recebida no arquivo de resposta inv$$HEX1$$e100$$ENDHEX$$lida. uo_ge064_epharma.of_grava_autorizacao()", StopSign!)
	Else
		If lvs_Status = "ER" Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Arquivo de resposta retornou um erro. uo_ge064_epharma.of_grava_autorizacao()~r~r" + lvs_Mensagem, StopSign!)
		Else
			lvdt_Validade = Date(MidA(lvs_Validade, 5, 2) + "/" + &
										MidA(lvs_Validade, 3, 2) + "/" + &
										MidA(lvs_Validade, 1, 2))
										
			If lvdt_Validade = Date("01/01/1900") Then lvdt_Validade = Today()							
					
			lvl_Convenio = Long(as_Convenio)
			
			If This.of_Exclui_Autorizacao(as_Autorizacao) Then
					
				If This.of_Inclui_Autorizacao(as_Autorizacao, &
											  lvdt_Validade, &
											  lvl_Convenio, &
											  as_Cartao, &
											  lvs_Paciente, &
											  adt_Receita, &
											  as_Tipo_Prescritor, &
											  as_Registro_Prescritor) Then
					lvi_Read = FileRead(lvi_Arquivo, lvs_Registro)
					
					Do While lvi_Read <> -100
						lvb_Sucesso = False
						
						If LenA(lvs_Registro) <> 61 Then
							If This.of_Valida_Linha_Retorno( lvs_Registro ) Then // Desconsidera os lixos j$$HEX1$$e100$$ENDHEX$$ previstos
								lvi_Read = FileRead(lvi_Arquivo, lvs_Registro)
								Continue
							End If
							
							FileClose( lvi_Arquivo )
							
							ls_Texto_Email_Log = 'Tamanho do registro lido no arquivo resposta inv$$HEX1$$e100$$ENDHEX$$lido. uo_ge064_epharma.of_grava_autorizacao() <br /><br />Registro: ' + lvs_Registro + &
														  '<br />Autoriza$$HEX2$$e700e300$$ENDHEX$$o: ' + as_Autorizacao
														  
							lvi_Arquivo = FileOpen( lvs_Arquivo, StreamMode!, Read!, Shared! )
							FileRead( lvi_Arquivo, lvs_Registro )
							
							ls_Texto_Email_Log += '<br /><br />Conteudo do arquivo:<br />' + lvs_Registro
							
							gf_ge202_envia_email_log( 63, &
																'LOG RL AUTORIZACAO EPHARMA - LOJA(' + String( gvo_Parametro.Cd_Filial ) +')', &
																 ls_Texto_Email_Log )
							
							MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tamanho do registro lido no arquivo resposta inv$$HEX1$$e100$$ENDHEX$$lido. uo_ge064_epharma.of_grava_autorizacao()", StopSign!)
						Else
							lvs_Codigo_Barras    = Trim(MidA(lvs_Registro, 1, 13))
							lvi_Qtde             = Integer(MidA(lvs_Registro, 14, 2))
							
							// PRD_PMC 
							lvdc_Preco_Maximo    = This.of_Decimal(MidA(lvs_Registro, 16, 7), 2) 
							// PRD_PFINAL => valor a ser recebido no ato da venda
							lvdc_Preco_Desconto  = This.of_Decimal(MidA(lvs_Registro, 23, 7), 2) 
							// PRD_PLOJA  => valor do menor pre$$HEX1$$e700$$ENDHEX$$o(valor a ser impresso no cupom fiscal) 
							lvdc_Preco_ePharma   = This.of_Decimal(MidA(lvs_Registro, 30, 7), 2)
							lvdc_Preco_Aquisicao = This.of_Decimal(MidA(lvs_Registro, 37, 7), 2)
							lvdc_Repasse_Varejo  = This.of_Decimal(MidA(lvs_Registro, 44, 7), 2)
							lvs_Menor_Preco      = MidA(lvs_Registro, 51, 1)
							lvs_Rejeicao         = MidA(lvs_Registro, 52, 2)
							
							If Trim(lvs_Rejeicao) = "" Then 
								SetNull(lvs_Rejeicao)
							Else
								This.ivb_Produto_Rejeitado = True
							End If
							This.de_rejeicao = lvs_Rejeicao
							
							If Trim(lvs_Codigo_Barras) = '0000012345670' Then //Manipulado, retirar os zeros a esquerda
								lvs_Codigo_Barras = '12345670'
							End If
							
							If This.of_Produto_Codigo_Barras(lvs_Codigo_Barras, lvl_Produto) Then 
								If This.of_Inclui_Produto_Autorizacao(as_Autorizacao, &
																	  lvl_Produto, &
																	  lvs_Codigo_Barras, &
																	  lvi_Qtde, &
																	  lvdc_Preco_Maximo, &
																	  lvdc_Preco_Desconto, &
																	  lvdc_Preco_ePharma, &
																	  lvdc_Preco_Aquisicao, &
																	  lvdc_Repasse_Varejo, &
																	  lvs_Rejeicao) Then
									lvb_Sucesso = True
								End If
							End If
						End If
						
						If Not lvb_Sucesso Then Exit
						lvi_Read = FileRead(lvi_Arquivo, lvs_Registro)
					Loop
					
					If lvb_Sucesso Then
						SqlCa.of_Commit()
					Else
						SqlCa.of_RollBack()
					End If
				End If
			End If
		End If
	End If
End If

FileClose(lvi_Arquivo)

If Not FileDelete(lvs_Arquivo) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na exclus$$HEX1$$e300$$ENDHEX$$o de resposta '" + lvs_Arquivo + "'.", StopSign!)
End If

Return lvb_Sucesso
end function

public function boolean of_solicita_reimpressao_recibo (string as_transacao, long ai_convenio);Boolean lvb_Sucesso = False

String lvs_Autorizacao

SetPointer(HourGlass!)

If This.of_Grava_Solicitacao_Reimpressao_Recibo(as_transacao,ai_convenio) Then
									  
	If This.of_Resposta_Recebida(This.REIMPRESSAO, "Aguardando Confirma$$HEX2$$e700e300$$ENDHEX$$o para Reimpress$$HEX1$$e300$$ENDHEX$$o") Then
		
		If This.of_Confirmacao_Reimpressao() Then
			
			lvb_Sucesso = True
			
		End If
			
	End If

End If

Return lvb_Sucesso
end function

public function boolean of_grava_solicitacao_reimpressao_recibo (string as_transacao, integer ai_convenio);Boolean lvb_Sucesso = True

Integer lvi_Arquivo, &
        lvi_Contador

String lvs_Arquivo_ENV, &
       lvs_Arquivo_TMP, &
       lvs_Linha		 

lvs_Arquivo_TMP = This.ivs_Path_TMP + This.REIMPRESSAO
lvs_Arquivo_ENV = This.ivs_Path_ENV + This.REIMPRESSAO

If Not This.of_Abre_Arquivo(lvs_Arquivo_TMP, lvi_Arquivo, "G") Then Return False

// Grava a linha de cabe$$HEX1$$e700$$ENDHEX$$alho
lvs_Linha = "0003" + &
            "10"   + &
				"03"   + &
            String(Long(as_transacao),'0000000') + &
				String(ai_convenio,'000')

If Not This.of_Grava_Arquivo(lvi_Arquivo, lvs_Linha) Then lvb_Sucesso = False

FileClose(lvi_Arquivo)

Return This.of_Trata_Arquivo_Temporario(lvs_Arquivo_TMP, lvs_Arquivo_ENV, lvb_Sucesso)	
end function

public function boolean of_confirmacao_reimpressao ();Integer lvi_Arquivo, &
		  lvi_Ind

String  lvs_Arquivo, &
        lvs_Registro, &
		  lvs_Sequencial, &
		  lvs_Funcao, &
		  lvs_Status, &
		  lvs_Mensagem, &
	 	  lvs_Transacao, &
	 	  lvs_NSU, &
		  lvs_Linha_Recibo, &
		  lvs_Vazio[]
		 		  
Long    lvl_Conta		 

Boolean lvb_Retorno = False
		 
lvs_Arquivo = This.ivs_Path_REC + This.REIMPRESSAO

If Not This.of_Abre_Arquivo(lvs_Arquivo, lvi_Arquivo, "L") Then Return False

FileRead(lvi_Arquivo, lvs_Registro)

lvs_Sequencial = MidA(lvs_Registro, 1, 4)
lvs_Funcao     = MidA(lvs_Registro, 5, 2)
lvs_Status     = MidA(lvs_Registro, 7, 2)
lvs_Mensagem   = MidA(lvs_Registro, 9, 40)

If lvs_Sequencial <> "0003" Then
	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Sequencial recebido no arquivo de resposta inv$$HEX1$$e100$$ENDHEX$$lido.", StopSign!)
	
Else
	 
	If lvs_Funcao <> "10" Then
		
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Fun$$HEX2$$e700e300$$ENDHEX$$o recebida no arquivo de resposta inv$$HEX1$$e100$$ENDHEX$$lida.", StopSign!)

	Else
	
		If lvs_Status = "ER" Then
			
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Arquivo de resposta retornou um erro.~r~r" + lvs_Mensagem, StopSign!)
			
		ElseIf lvs_Status = "OK" Then
			
			FileRead(lvi_Arquivo, lvs_Registro)
			
			This.lvs_Recibo = lvs_Vazio
			
			lvs_Linha_Recibo = ''
			
			For lvl_conta = 1 To LenA(Trim(lvs_Registro))
				
				If MidA(lvs_Registro,lvl_conta,1) <> '@' Then
					
					lvs_Linha_Recibo = lvs_Linha_Recibo + MidA(lvs_Registro,lvl_conta,1)
					
				Else
					
					lvi_Ind ++
					
					This.lvs_Recibo[lvi_Ind] = lvs_Linha_Recibo
					
					lvs_Linha_Recibo = ''
								
				End If
		
			Next
			
			This.lvs_Recibo[lvi_Ind] = lvs_Linha_Recibo
			
			lvb_Retorno = True
			
		Else
			
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Retorno no arquivo de resposta diferente do esperado. " + lvs_Status + "~r~r" + lvs_Mensagem, StopSign!)
			
		End If
		
	End If
	
End If	
//
FileClose(lvi_Arquivo)
//
ivo_api.of_delete_file(lvs_arquivo)
//
Return lvb_Retorno

end function

public function boolean of_grava_fechamento ();Boolean lvb_Sucesso = True

Integer lvi_Arquivo, &
        lvi_Contador

String lvs_Arquivo_ENV, &
       lvs_Arquivo_TMP, &
       lvs_Linha		 

lvs_Arquivo_TMP = This.ivs_Path_TMP + This.FECHAMENTO
lvs_Arquivo_ENV = This.ivs_Path_ENV + This.FECHAMENTO

If Not This.of_Abre_Arquivo(lvs_Arquivo_TMP, lvi_Arquivo, "G") Then Return False

// Grava a linha de cabe$$HEX1$$e700$$ENDHEX$$alho
lvs_Linha = "0005" + &
            "10"   + &
			"20"

If Not This.of_Grava_Arquivo(lvi_Arquivo, lvs_Linha) Then lvb_Sucesso = False

FileClose(lvi_Arquivo)

Return This.of_Trata_Arquivo_Temporario(lvs_Arquivo_TMP, lvs_Arquivo_ENV, lvb_Sucesso)	
end function

public function boolean of_confirmacao_fechamento ();Integer lvi_Arquivo, &
		  lvi_Ind

String  lvs_Arquivo, &
        lvs_Registro, &
		  lvs_Sequencial, &
		  lvs_Funcao, &
		  lvs_Status, &
		  lvs_Mensagem
		 		  
Long    lvl_Conta		 

Boolean lvb_Retorno = False
		 
lvs_Arquivo = This.ivs_Path_REC + This.FECHAMENTO

If Not This.of_Abre_Arquivo(lvs_Arquivo, lvi_Arquivo, "L") Then Return False

FileRead(lvi_Arquivo, lvs_Registro)

lvs_Sequencial = MidA(lvs_Registro, 1, 4)
lvs_Funcao     = MidA(lvs_Registro, 5, 2)
lvs_Status     = MidA(lvs_Registro, 7, 2)
lvs_Mensagem   = MidA(lvs_Registro, 9, 40)

If lvs_Sequencial <> "0005" Then
	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Sequencial recebido no arquivo de resposta inv$$HEX1$$e100$$ENDHEX$$lido.", StopSign!)
	
Else
	 
	If lvs_Funcao <> "10" Then
		
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Fun$$HEX2$$e700e300$$ENDHEX$$o recebida no arquivo de resposta inv$$HEX1$$e100$$ENDHEX$$lida.", StopSign!)

	Else
	
		If lvs_Status = "ER" Then
			
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Arquivo de resposta retornou um erro.~r~r" + lvs_Mensagem, StopSign!)
			
		ElseIf lvs_Status = "OK" Then
			
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Fechamento executado com sucesso.")
			
			lvb_Retorno = True
			
		Else
			
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Retorno no arquivo de resposta diferente do esperado. " + lvs_Status + "~r~r" + lvs_Mensagem, StopSign!)
			
		End If
		
	End If
	
End If	
//
FileClose(lvi_Arquivo)
//
ivo_api.of_delete_file(lvs_arquivo)
//
Return lvb_Retorno

end function

public function boolean of_fechamento ();Boolean lvb_Sucesso = False

String lvs_Autorizacao

If This.of_Grava_Fechamento() Then
									  
	If This.of_Resposta_Recebida(This.FECHAMENTO, "Aguardando Confirma$$HEX2$$e700e300$$ENDHEX$$o do Fechamento") Then
		
		lvb_Sucesso = This.of_Confirmacao_Fechamento()
			
	End If

End If

Return lvb_Sucesso
end function

public function boolean of_grava_teste_gerenciador ();Boolean lvb_Sucesso = True

Integer lvi_Arquivo, &
        lvi_Contador

String lvs_Arquivo_ENV, &
       lvs_Arquivo_TMP, &
		 lvs_Arquivo_REC, &
       lvs_Linha		 
		 
SetPointer(HourGlass!)		 

lvs_Arquivo_TMP = This.ivs_Path_TMP + This.ATIVIDADE
lvs_Arquivo_ENV = This.ivs_Path_ENV + This.ATIVIDADE
lvs_Arquivo_REC = This.ivs_Path_REC + This.ATIVIDADE

//Exclui arquivo de retorno antigo
This.of_Exclui_Arquivo_Recebido(lvs_Arquivo_REC)

If Not This.of_Abre_Arquivo(lvs_Arquivo_TMP, lvi_Arquivo, "G") Then Return False

// Grava a linha de cabe$$HEX1$$e700$$ENDHEX$$alho
lvs_Linha = "0009" + &
            "97" 

If Not This.of_Grava_Arquivo(lvi_Arquivo, lvs_Linha) Then lvb_Sucesso = False

FileClose(lvi_Arquivo)

Return This.of_Trata_Arquivo_Temporario(lvs_Arquivo_TMP, lvs_Arquivo_ENV, lvb_Sucesso)	
end function

public function boolean of_confirmacao_atividade_gerenciador ();Integer lvi_Arquivo, &
		  lvi_Ind

String  lvs_Arquivo, &
        lvs_Registro, &
		  lvs_Sequencial, &
		  lvs_Funcao, &
		  lvs_Status
		 		  
Boolean lvb_Retorno = False
		 
lvs_Arquivo = This.ivs_Path_REC + This.ATIVIDADE

If Not This.of_Abre_Arquivo(lvs_Arquivo, lvi_Arquivo, "L") Then Return False

FileRead(lvi_Arquivo, lvs_Registro)

lvs_Sequencial = MidA(lvs_Registro, 1, 4)
lvs_Funcao     = MidA(lvs_Registro, 5, 2)
lvs_Status     = MidA(lvs_Registro, 7, 2)

If lvs_Sequencial <> "0009" Then
	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Sequencial recebido no arquivo de resposta inv$$HEX1$$e100$$ENDHEX$$lido.", StopSign!)
	
Else
	 
	If lvs_Funcao <> "97" Then
		
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Fun$$HEX2$$e700e300$$ENDHEX$$o recebida no arquivo de resposta inv$$HEX1$$e100$$ENDHEX$$lida.", StopSign!)

	Else
	
		If lvs_Status = "OK" Then
					
			lvb_Retorno = True
			
		Else
			
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Gerencidor ePharma n$$HEX1$$e300$$ENDHEX$$o esta ativo. ~n~n          Favor Verificar.",Exclamation!)
						
		End If
		
	End If
	
End If	
//
FileClose(lvi_Arquivo)
//
ivo_api.of_delete_file(lvs_arquivo)
//
Return lvb_Retorno

end function

public function boolean of_gerenciador_ativo ();Boolean lvb_Sucesso = False

String lvs_Autorizacao

SetPointer(HourGlass!)

If This.of_Grava_Teste_Gerenciador() Then
	
	SetPointer(HourGlass!)
									  
	If This.of_Resposta_Gerenciador_Ativo() Then
		
		SetPointer(HourGlass!)
		
		lvb_Sucesso = This.of_Confirmacao_Atividade_Gerenciador()
		
	End If	
			
End If

Return lvb_Sucesso
end function

public function boolean of_resposta_gerenciador_ativo ();Time lvt_Limite

Boolean lvb_Existe = False

String lvs_Arquivo

lvs_Arquivo = This.ivs_Path_REC + This.ATIVIDADE

lvt_Limite = RelativeTime(Now(), 5)

Do While Not lvb_Existe
	
	If Now() > lvt_Limite Then 
		
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Gerenciador e-Pharma n$$HEX1$$e300$$ENDHEX$$o esta ativo. ~n~n          Favor verificar.", Exclamation!)
		
		Exit
		
	End If	
		
	lvb_Existe = FileExists(lvs_Arquivo)
	
Loop

Return lvb_Existe
end function

public function boolean of_grava_inicializacao ();Boolean lvb_Sucesso = True

Integer lvi_Arquivo, &
        lvi_Contador

String lvs_Arquivo_ENV, &
       lvs_Arquivo_TMP, &
		 lvs_Linha		 

lvs_Arquivo_TMP = This.ivs_Path_TMP + This.INICIALIZACAO
lvs_Arquivo_ENV = This.ivs_Path_ENV + This.INICIALIZACAO

//lvs_Arquivo_TMP = This.ivs_path_tmp_ret + This.INICIALIZACAO
//lvs_Arquivo_ENV = This.ivs_Path_TMP + This.INICIALIZACAO

If Not This.of_Abre_Arquivo(lvs_Arquivo_TMP, lvi_Arquivo, "G") Then Return False

// Grava a linha de cabe$$HEX1$$e700$$ENDHEX$$alho
lvs_Linha = "0010" + &
            "10"   + &
				"23"

If Not This.of_Grava_Arquivo(lvi_Arquivo, lvs_Linha) Then lvb_Sucesso = False

FileClose(lvi_Arquivo)

Return This.of_Trata_Arquivo_Temporario(lvs_Arquivo_TMP, lvs_Arquivo_ENV, lvb_Sucesso)	
end function

public function boolean of_trata_arquivo_temporario (string as_arquivo_tmp, string as_arquivo_env, boolean ab_sucesso);If ab_Sucesso Then
	If FileExists(as_Arquivo_ENV) Then
		If Not FileDelete(as_Arquivo_ENV) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na exclus$$HEX1$$e300$$ENDHEX$$o do arquivo '" + as_Arquivo_ENV + "'.", StopSign!)
			Return False
		End If
	End If
	
	//Return ivo_API.of_Move_File(as_Arquivo_TMP, as_Arquivo_ENV)	
	If ivo_API.of_copy_file( as_Arquivo_TMP, as_Arquivo_ENV, true) Then
		FileDelete(as_Arquivo_TMP) 
		Return True
	Else
		Return False
	End If	
Else	
	If Not FileDelete(as_Arquivo_TMP) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na exclus$$HEX1$$e300$$ENDHEX$$o do arquivo '" + as_Arquivo_TMP + "'.", StopSign!)
		Return False
	Else
		Return True
	End If
End If
end function

public function string of_motivo_rejeicao (string as_codigo);String lvs_Descricao

Choose Case as_Codigo
	Case "LM" ; lvs_Descricao = "LIMITE M$$HEX1$$c100$$ENDHEX$$XIMO DE VALORES"		
	Case "QA" ; lvs_Descricao = "SOLIC. SUPERA A QTDE. AUTORIZADA"		
	Case "QP" ; lvs_Descricao = "EXCEDE QUANTIDADE NO PER$$HEX1$$cd00$$ENDHEX$$ODO"		
	Case "QR" ; lvs_Descricao = "EXCEDE QUANTIDADE M$$HEX1$$c100$$ENDHEX$$XIMA DO ITEM"		
	Case "QU" ; lvs_Descricao = "SALDO INSUFICIENTE"		
	Case "RC" ; lvs_Descricao = "RECEITA J$$HEX1$$c100$$ENDHEX$$ ATENDIDA"
	Case Else ; lvs_Descricao = "MOTIVO N$$HEX1$$c300$$ENDHEX$$O PREVISTO"
End Choose

Return as_Codigo + " - " + lvs_Descricao
end function

public subroutine of_imprime_autorizacao (string as_autorizacao);dc_uo_ds_Base lvds
lvds = Create dc_uo_ds_Base
If Not lvds.of_ChangeDataObject("dw_rl020_impressao_autorizacao") Then Return

SetPointer(HourGlass!)

If lvds.Retrieve(as_Autorizacao) > 0 Then
	Open(dc_w_Prepara_Impressora)
	lvds.Print()
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Autoriza$$HEX2$$e700e300$$ENDHEX$$o '" + as_Autorizacao + "' n$$HEX1$$e300$$ENDHEX$$o localizada para impress$$HEX1$$e300$$ENDHEX$$o.", StopSign!)
End If

Destroy(lvds)
SetPointer(Arrow!)
end subroutine

public function boolean of_desconexao ();Boolean lvb_Sucesso = False

String lvs_Arquivo_ENV

lvs_Arquivo_ENV = This.ivs_Path_ENV + This.DESCONEXAO

If This.of_Grava_Desconexao() Then
	If This.of_Resposta_Recebida(This.DESCONEXAO, "Aguardando Confirma$$HEX2$$e700e300$$ENDHEX$$o da Desconex$$HEX1$$e300$$ENDHEX$$o") Then
		lvb_Sucesso = This.of_Confirmacao_Desconexao()
	Else
		//Exclui arquivo n$$HEX1$$e300$$ENDHEX$$o enviado
		If FileExists(lvs_Arquivo_ENV) Then
			This.of_Exclui_Arquivo_Enviado(lvs_Arquivo_ENV)
		End If
	End If
End If

Return lvb_Sucesso
end function

public function boolean of_grava_desconexao ();Boolean lvb_Sucesso = True

Integer lvi_Arquivo, &
        lvi_Contador

String lvs_Arquivo_ENV, &
       lvs_Arquivo_TMP, &
		 lvs_Arquivo_REC, &
       lvs_Linha		 

lvs_Arquivo_TMP = This.ivs_Path_TMP + This.DESCONEXAO
lvs_Arquivo_ENV = This.ivs_Path_ENV + This.DESCONEXAO
lvs_Arquivo_REC = This.ivs_Path_REC + This.DESCONEXAO

//Exclui arquivo de retorno antigo.
This.of_exclui_arquivo_recebido(lvs_Arquivo_REC)

If Not This.of_Abre_Arquivo(lvs_Arquivo_TMP, lvi_Arquivo, "G") Then Return False

lvs_Linha = "0099" + "81"

If Not This.of_Grava_Arquivo(lvi_Arquivo, lvs_Linha) Then lvb_Sucesso = False

FileClose(lvi_Arquivo)

Return This.of_Trata_Arquivo_Temporario(lvs_Arquivo_TMP, lvs_Arquivo_ENV, lvb_Sucesso)	
end function

public function boolean of_confirmacao_desconexao ();Boolean lvb_Retorno = False

Integer lvi_Arquivo

String lvs_Arquivo, &
       lvs_Registro, &
		 lvs_Sequencial, &
		 lvs_Funcao, &
		 lvs_Status, &
		 lvs_Mensagem
		 
lvs_Arquivo = This.ivs_Path_REC + This.DESCONEXAO

If Not This.of_Abre_Arquivo(lvs_Arquivo, lvi_Arquivo, "L") Then Return False

FileRead(lvi_Arquivo, lvs_Registro)

lvs_Sequencial = MidA(lvs_Registro, 1, 4)
lvs_Funcao     = MidA(lvs_Registro, 5, 2)
lvs_Status     = MidA(lvs_Registro, 7, 2)
lvs_Mensagem   = MidA(lvs_Registro, 9, 40)

If lvs_Sequencial <> "0099" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Sequencial recebido no arquivo de resposta inv$$HEX1$$e100$$ENDHEX$$lido.", StopSign!)
Else
	If lvs_Funcao <> "81" Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Fun$$HEX2$$e700e300$$ENDHEX$$o recebida no arquivo de resposta inv$$HEX1$$e100$$ENDHEX$$lida.", StopSign!)
	Else
		If lvs_Status = "ER" Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Arquivo de resposta retornou um erro.~r~r" + lvs_Mensagem, StopSign!)
		Else
			lvb_Retorno = True
		End If
	End If
End If	

FileClose(lvi_Arquivo)

If Not FileDelete(lvs_Arquivo) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na exclus$$HEX1$$e300$$ENDHEX$$o do arquivo '" + lvs_Arquivo + "'.", StopSign!)
End If

Return lvb_Retorno
end function

public function boolean of_resposta_recebida (string as_arquivo, string as_mensagem);Boolean lvb_Sucesso = False

String lvs_Retorno, &
       lvs_Log

lvs_Log = "In$$HEX1$$ed00$$ENDHEX$$cio    - " + as_Mensagem
gvo_Aplicacao.of_Grava_Log(lvs_Log)

uo_Aguarde_ePharma lvo_Aguarde
lvo_Aguarde = Create uo_Aguarde_ePharma

lvo_Aguarde.ivs_Arquivo_ENV 	= This.ivs_Path_ENV + as_arquivo
lvo_Aguarde.ivs_Arquivo  		= This.ivs_Path_REC + as_Arquivo
lvo_Aguarde.ivs_arquivo_dep 	= This.ivs_Path_REC + SOLIC_DEP
lvo_Aguarde.ivs_Mensagem 		= as_Mensagem
lvo_Aguarde.ivi_Limite   		= This.ivi_Tempo_Espera

OpenWithParm(w_Aguarde_ePharma, lvo_Aguarde)

lvs_Retorno = Message.StringParm

If lvs_Retorno = "S" Or lvs_Retorno = "D" Then
	If lvs_Retorno = "D" Then
		This.ivb_dependente = True
	End If
	lvb_Sucesso = True
End If

//If lvs_Retorno = "S" Then
//	lvb_Sucesso = True
//End If

lvs_Log = "T$$HEX1$$e900$$ENDHEX$$rmino   - " + as_Mensagem
If lvb_Sucesso Then 
	lvs_Log += " - SUCESSO"
Else
	lvs_Log += " - ERRO"
End If

gvo_Aplicacao.of_Grava_Log(lvs_Log)

Destroy(lvo_Aguarde)
Return lvb_Sucesso
end function

public subroutine of_exclui_arquivo_enviado (string as_arquivo);If FileExists(as_Arquivo) Then
	If Not FileDelete(as_Arquivo) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na exclus$$HEX1$$e300$$ENDHEX$$o do arquivo '" + as_Arquivo + "'.", StopSign!)
	End If
End If
end subroutine

public function boolean of_abre_arquivo_log (string as_nome, ref integer ai_arquivo);ai_Arquivo = FileOpen(as_Nome, LineMode!, Write!, Shared!, Replace!)

If ai_Arquivo > 0 Then
	Return True
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na abertura do arquivo '" + as_Nome + "'.", StopSign!)
	Return False
End If
end function

public function boolean of_grava_arquivo_log (integer ai_arquivo, string as_linha);Integer lvi_Write

lvi_Write = FileWrite(ai_Arquivo, as_Linha)

If lvi_Write = LenA(as_Linha) Then
	Return True
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do arquivo.", StopSign!)
	Return False
End If
end function

public function boolean wf_atualiza_convenio_epharma (integer pi_arquivo);

Return True
end function

public function boolean of_atualiza_convenio_epharma (integer pi_arquivo, ref string ps_mensagem_erro);Boolean lvb_Sucesso = True

Integer lvi_Read

String	lvs_Registro, &
       	lvs_Tipo, &
		lvs_Desc_Convenio
		
Long lvl_Convenio

Date lvdt_Parametro

lvdt_Parametro = Date(gvo_Parametro.of_dh_Movimentacao())

lvi_Read = FileRead(pi_Arquivo, lvs_Registro)
	
Do While lvi_Read > 0		
	
	lvs_Tipo = MidA(lvs_Registro, 1, 2)
	
	Choose Case lvs_Tipo
			
		Case "01"
			lvl_Convenio      		= Long(MidA(lvs_Registro, 3, 12))
			lvs_Desc_Convenio 	= Upper(Trim(MidA(lvs_Registro, 15, 30)))
			
			// Atualiza Conv$$HEX1$$ea00$$ENDHEX$$nio
			Update convenio_epharma
			Set nm_convenio   = :lvs_Desc_Convenio, dh_atualizacao =  getdate(), id_situacao = 'A'
			Where cd_convenio = :lvl_Convenio
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				ps_Mensagem_Erro = "Erro na Atualiza$$HEX2$$e700e300$$ENDHEX$$o Conv$$HEX1$$ea00$$ENDHEX$$nio ePharma:" + String(lvl_Convenio)
				SqlCa.of_MsgdbError(ps_Mensagem_Erro)
				lvb_Sucesso = False
				Exit
			Else
				If SqlCa.SqlNRows = 0 Then
					
					//Inclui Novo Conv$$HEX1$$ea00$$ENDHEX$$nio
					Insert Into convenio_epharma(cd_convenio,
					                   						nm_convenio,
														  	id_situacao,
															dh_atualizacao)
					Values(	:lvl_Convenio,
					       		:lvs_Desc_Convenio,
							 	'A',
								 getdate());
			
					If SqlCa.SqlCode = -1 Then
						ps_Mensagem_Erro = "Erro na inclus$$HEX1$$e300$$ENDHEX$$o do conv$$HEX1$$ea00$$ENDHEX$$nio " + String(lvl_Convenio)
						SqlCa.of_MsgdbError(ps_Mensagem_Erro)
						lvb_Sucesso = False
						Exit
					End If
				End If
			End If					
	End Choose
	
	lvi_Read = FileRead(pi_Arquivo, lvs_Registro)
Loop

If lvb_Sucesso Then
	Update convenio_epharma
	Set id_situacao = 'I'
	Where id_situacao = 'A'
	    and (dh_atualizacao is null or dh_atualizacao < :lvdt_Parametro)
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		ps_Mensagem_Erro = "Erro na altera$$HEX2$$e700e300$$ENDHEX$$o da situa$$HEX2$$e700e300$$ENDHEX$$o do conv$$HEX1$$ea00$$ENDHEX$$nio " + String(lvl_Convenio)
		SqlCa.of_MsgdbError(ps_Mensagem_Erro)
		lvb_Sucesso = False
	End If
End If

Return lvb_Sucesso
end function

public function boolean of_confirmacao_inicializacao (ref string ps_mensagem);Integer lvi_Arquivo, &
		  lvi_Ind

String  lvs_Arquivo, &
        lvs_Registro, &
		  lvs_Sequencial, &
		  lvs_Funcao, &
		  lvs_Status, &
		  lvs_Mensagem
		 		  
Long    lvl_Conta		 

Boolean lvb_Retorno = False

lvs_Arquivo = This.ivs_Path_REC + This.INICIALIZACAO

If Not This.of_Abre_Arquivo(lvs_Arquivo, lvi_Arquivo, "L") Then Return False

FileRead(lvi_Arquivo, lvs_Registro)

lvs_Sequencial = MidA(lvs_Registro, 1, 4)
lvs_Funcao     = MidA(lvs_Registro, 5, 2)
lvs_Status     = MidA(lvs_Registro, 7, 2)
lvs_Mensagem   = MidA(lvs_Registro, 9, 40)

If lvs_Sequencial <> "0010" Then
	
	ps_Mensagem = "Sequencial recebido no arquivo de resposta inv$$HEX1$$e100$$ENDHEX$$lido."
	
Else
	 
	If lvs_Funcao <> "10" Then
		
		ps_Mensagem = "Fun$$HEX2$$e700e300$$ENDHEX$$o recebida no arquivo de resposta inv$$HEX1$$e100$$ENDHEX$$lida."

	Else
	
		If lvs_Status = "ER" Then
			
			ps_Mensagem = "Arquivo de resposta retornou um erro.~r~r" + lvs_Mensagem
			
		ElseIf lvs_Status = "OK" Then
			
			ps_Mensagem = "Inicializa$$HEX2$$e700e300$$ENDHEX$$o do Terminal conclu$$HEX1$$ed00$$ENDHEX$$da."
			
			lvb_Retorno = True
			
			Long lvl_Filial, &
			     lvl_Filial_Matriz
				  
			This.of_Carrega_Parametros(Ref lvl_Filial, Ref lvl_Filial_Matriz)
			
			// S$$HEX1$$f300$$ENDHEX$$ far$$HEX1$$e100$$ENDHEX$$ a atualiza$$HEX2$$e700e300$$ENDHEX$$o se for matriz
			If lvl_Filial = lvl_Filial_Matriz Then
				
				If Not This.of_Atualiza_Convenio_ePharma(lvi_Arquivo, Ref ps_Mensagem) Then 
					lvb_Retorno = False
				Else
					SqlCa.of_Commit()
				End If
			End If
		Else
			ps_Mensagem = "Retorno no arquivo de resposta diferente do esperado. " + lvs_Status + "~r~r" + lvs_Mensagem
			
		End If
		
	End If
	
End If	

FileClose(lvi_Arquivo)

//ivo_api.of_delete_file(lvs_arquivo)

Return lvb_Retorno
end function

public function boolean of_inicializacao (ref string ps_mensagem);Boolean lvb_Sucesso = False

String lvs_Autorizacao

SetPointer(HourGlass!)

This.of_Exclui_Arquivo_Recebido(This.ivs_Path_REC + This.INICIALIZACAO)

If This.of_Grava_Inicializacao() Then
	
	ivb_Inicializacao = True
	
	If This.of_Resposta_Recebida(This.INICIALIZACAO, "Aguardando Confirma$$HEX2$$e700e300$$ENDHEX$$o da Inicializa$$HEX2$$e700e300$$ENDHEX$$o") Then
		
		lvb_Sucesso = This.of_Confirmacao_Inicializacao(Ref ps_Mensagem)
			
	End If

End If

Return lvb_Sucesso
end function

public subroutine of_carrega_parametros (ref long pl_filial, ref long pl_filial_matriz);Select cd_filial, cd_filial_matriz
Into :pl_Filial,
     :pl_Filial_Matriz
From parametro
Where id_parametro = '1'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o dos par$$HEX1$$e200$$ENDHEX$$metros do sistema." + Sqlca.SqlErrText , StopSign!)
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Par$$HEX1$$e200$$ENDHEX$$metros do sistema n$$HEX1$$e300$$ENDHEX$$o localizados.", StopSign!)		
End Choose
end subroutine

public subroutine of_exclui_arquivo_recebido (string as_arquivo);If FileExists(as_Arquivo) Then
	If Not FileDelete(as_Arquivo) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na exclus$$HEX1$$e300$$ENDHEX$$o do arquivo '" + as_Arquivo + "'.", StopSign!)
	End If
End If
end subroutine

public function boolean of_grava_solicitacao (string as_cartao, string as_convenio, date adt_data_receita, string as_tipo_prescritor, string as_crm, string as_uf, string as_produto[], integer ai_qtde[], decimal adc_preco_venda_maximo[], decimal adc_preco_venda[]);Boolean lvb_Sucesso = True

Integer lvi_Arquivo, &
        lvi_Contador, lvi_Len

String lvs_Arquivo_ENV, &
       lvs_Arquivo_TMP, &
		 lvs_Arquivo_REC,&
       lvs_Linha, &
		 lvs_Produto, &
		 lvs_Preco_PMC, &
		 lvs_Preco_Venda 

If UpperBound(as_Produto) <> UpperBound(ai_Qtde) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$fa00$$ENDHEX$$mero de produtos $$HEX1$$e900$$ENDHEX$$ diferente das quantidades.", StopSign!)	
	Return False
End If

lvs_Arquivo_TMP = This.ivs_path_tmp + This.SOLICITACAO
lvs_Arquivo_ENV = This.ivs_Path_ENV + This.SOLICITACAO
lvs_Arquivo_REC = This.ivs_path_REC + This.SOLICITACAO

//Exclui arquivo recebido antigo.
This.of_exclui_arquivo_recebido(lvs_Arquivo_REC)

//Exclui arquivo DEP recebido antigo
lvs_Arquivo_REC = This.ivs_path_REC + This.SOLIC_DEP
This.of_exclui_arquivo_recebido(lvs_Arquivo_REC)

If Not This.of_Abre_Arquivo(lvs_Arquivo_TMP, lvi_Arquivo, "G") Then Return False

// Grava a linha de cabe$$HEX1$$e700$$ENDHEX$$alho
If Upper(Trim(ivs_epharma_plugin)) = 'S' Then
	lvs_Linha = "0001" + &
					"01" + &
					as_Cartao + &
				as_Convenio + &
				String(adt_Data_Receita, "yymmdd") + &
				as_Tipo_Prescritor + &
				as_CRM + &
				as_UF + &
				Space(37) + &
				Space(76) + &
				Space(40) //colocados para atender nova versao POSWEB
Else
	lvs_Linha = "0001" + &
					"01" + &
					as_Cartao + &
				as_Convenio + &
				String(adt_Data_Receita, "yymmdd") + &
				as_Tipo_Prescritor + &
				as_CRM + &
				as_UF + &
				Space(37) + &
				Space(76)
End If

If This.of_Grava_Arquivo(lvi_Arquivo, lvs_Linha) Then
	// Grava as linhas dos produtos
	For lvi_Contador = 1 To UpperBound(as_Produto)
		lvs_Produto = as_Produto[lvi_Contador]
		
		If LenA(lvs_Produto) <> 13 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produto '" + lvs_Produto + "' com tamanho inv$$HEX1$$e100$$ENDHEX$$lido.", StopSign!)
			lvb_Sucesso = False
			Exit
		End If
		
		lvs_Preco_PMC   = String(This.of_Valor_Sem_Pontuacao(adc_preco_venda_maximo[lvi_Contador]), "0000000")
		lvs_Preco_Venda = String(This.of_Valor_Sem_Pontuacao(adc_preco_venda       [lvi_Contador]), "0000000")
		
		lvs_Linha = lvs_Produto + &
					"0000000" + & 
					"00000000" + &
					String(ai_Qtde[lvi_Contador], "00") +&
					lvs_Preco_PMC +&
					lvs_Preco_Venda
	
		If Not This.of_Grava_Arquivo(lvi_Arquivo, lvs_Linha) Then 
			lvb_Sucesso = False					
			Exit
		End If
	Next
Else
	lvb_Sucesso = False
End If

FileClose(lvi_Arquivo)

If Not lvb_Sucesso Then
	Return False
End If

gf_delay(3)

Return This.of_Trata_Arquivo_Temporario(lvs_Arquivo_TMP, lvs_Arquivo_ENV, lvb_Sucesso)	
end function

public function long of_valor_sem_pontuacao (decimal adc_valor);Integer lvi_Pos

String lvs_Valor 

If IsNull(adc_Valor) Then adc_Valor = 0 

lvs_Valor = String(adc_valor)

lvi_Pos   = PosA(lvs_Valor, ',')

Return Long(MidA(lvs_Valor, 1, lvi_Pos - 1) + MidA(lvs_Valor, lvi_Pos + 1, 2))
end function

public function boolean of_processa_retorno_cancelamento ();Boolean lvb_Sucesso = False

String lvs_Arquivo_REC,&
		 lvs_Sequencial, &
       lvs_Funcao    , &
		 lvs_Status    , &
		 lvs_MSG			, &
		 lvs_String

Integer lvi_Arquivo
	
lvs_Arquivo_REC = ivs_path_rec + This.CANCELAMENTO

If Not This.of_Abre_Arquivo(lvs_Arquivo_REC, Ref lvi_Arquivo, "L") Then Return False

FileRead(lvi_Arquivo, lvs_String)

lvs_Sequencial = MidA(lvs_String, 1, 4)
lvs_Funcao     = MidA(lvs_String, 5, 2)
lvs_Status     = MidA(lvs_String, 7, 2)
lvs_MSG        = MidA(lvs_String, 9, 40)

If lvs_Sequencial <> "0100" Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Seq$$HEX1$$fc00$$ENDHEX$$encial do arquivo recebido no arquivo inv$$HEX1$$e100$$ENDHEX$$lido.", StopSign!)
Else
	If lvs_Funcao <> "10" Then
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Fun$$HEX2$$e700e300$$ENDHEX$$o recebida no arquivo inv$$HEX1$$e100$$ENDHEX$$lida.", StopSign!)
	Else
		If lvs_Status = "ER" Then
			Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A resposta do retorno retornou um erro.~r~r" +&
							lvs_MSG, StopSign!)
		Else
			lvb_Sucesso = True
		End If
	End If
End If

FileClose(lvi_Arquivo)

If Not FileDelete(lvs_Arquivo_REC) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na exclus$$HEX1$$e300$$ENDHEX$$o de resposta '" + lvs_Arquivo_REC + "'.", StopSign!)
End IF

Return lvb_Sucesso
end function

public function boolean of_verifica_transacao (string as_transacao, ref string as_ecf, ref string as_cupom, string as_tipo);Boolean lvb_Sucesso = False

DateTime lvdt_Cancelamento

Integer lvi_Venda

String lvs_Nulo

as_ECF   = ""
as_Cupom = ""

as_transacao = "000000000000" + Trim(as_transacao)
as_transacao = RightA(as_transacao, 12)

if as_tipo = 'A' then 
	as_transacao = "000000000000" + Trim(as_transacao) 
	as_transacao = RightA(as_transacao, 12)
else 
	as_transacao = "000000000" + Trim(as_transacao) 
	as_transacao = RightA(as_transacao, 9)
end if

If as_tipo = 'A' Then
	
	Select nr_autorizacao, dh_cancelamento
	Into :as_transacao, :lvdt_Cancelamento
	From autorizacao_epharma
	Where nr_autorizacao =:as_transacao
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da Autoriza$$HEX2$$e700e300$$ENDHEX$$o e-Pharma")
	End If 
	
	If SqlCa.SqlCode = 100 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Autoriza$$HEX2$$e700e300$$ENDHEX$$o e-Pharma n$$HEX1$$e300$$ENDHEX$$o foi encontrada.", StopSign!)
	End If
	
	If SqlCa.SqlCode = 0 Then
		
		If Not IsNull(lvdt_Cancelamento) Then
			Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Autoriza$$HEX2$$e700e300$$ENDHEX$$o j$$HEX1$$e100$$ENDHEX$$ foi cancelada.", StopSign!)
			Return False
		End If
		
		Select count(*) 
		Into :lvi_Venda
		From venda_pbm
		Where nr_autorizacao =:as_transacao
		  and dh_cancelamento is null
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da venda para a autoriza$$HEX2$$e700e300$$ENDHEX$$o")
		End If
		
		If SqlCa.SqlCode = 0 Then
			
			If lvi_Venda > 0 Then
				Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existe uma venda vinculada a essa autoriza$$HEX2$$e700e300$$ENDHEX$$o.~r~r" +&
											 "Efetue o cancelamento da venda.", StopSign!)
			Else
				lvb_Sucesso = True
			End If
		End If
		
	End If
	
Else
	
	Select nr_ecf_pbm, nr_cupom, dh_cancelamento
	Into :as_ecf, :as_cupom, :lvdt_Cancelamento
	From venda_pbm
	Where nr_comprovante_venda =:as_transacao
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_MSgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da venda e-pharma")
	End If
	
	If SqlCa.SqlCode = 100 Then
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A Venda e-Pharma n$$HEX1$$e300$$ENDHEX$$o foi encontrada.", StopSign!)
	Else
		If Not IsNull(lvdt_Cancelamento) Then
			Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A venda j$$HEX1$$e100$$ENDHEX$$ foi cancelada na e-Pharma.", StopSign!)
			as_ECF   = ""
			as_Cupom = ""
		Else 
			lvb_Sucesso = True
		End If
	End If

End If


Return lvb_Sucesso 
end function

public function boolean of_cancela_transacao (string as_transacao, string as_cupom, string as_ecf, string as_tipo);Boolean lvb_Sucesso = False

If This.of_Grava_Solicitacao_Cancelamento(as_transacao, as_cupom, as_ecf, as_tipo) Then
	If This.of_Resposta_Recebida(This.CANCELAMENTO, "Aguardando o cancelamento da transa$$HEX2$$e700e300$$ENDHEX$$o") Then
		If This.of_Processa_Retorno_Cancelamento() Then
			// Colocar a data de cancelamento da transacao
			If This.of_Transacao_Cancelamento(as_transacao, as_tipo) Then
				If as_Tipo = "V" Then
					Open(w_mensagem)
				Else
					Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O cancelamento da Autoriza$$HEX2$$e700e300$$ENDHEX$$o e-Pharma foi realizado com sucesso.", Information!)
				End If
				lvb_Sucesso = True		
			End If
		End If
	End If		
End If

Return lvb_Sucesso 
end function

public function boolean of_transacao_cancelamento (string as_transacao, string as_tipo);Boolean lvb_Sucesso = True

DateTime lvdt_Movimento

lvdt_Movimento = gvo_Parametro.of_dh_Movimentacao()

If as_Tipo = "A" Then
	Update autorizacao_epharma
	Set dh_cancelamento = :lvdt_Movimento
	Where nr_autorizacao =:as_transacao
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o da data de cancelamento da Autoriza$$HEX2$$e700e300$$ENDHEX$$o e-Pharma")
		lvb_Sucesso = False
	End If
Else
	as_transacao = RightA(as_transacao,9)
	
	Update venda_pbm
	Set dh_cancelamento = :lvdt_Movimento
	Where nr_comprovante_venda =:as_transacao
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgDbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o da data de cancelamento da Venda e-Pharma")
		lvb_Sucesso = False
	End If
End IF

If lvb_Sucesso Then
	SqlCa.of_Commit()
Else
	SqlCa.of_RollBack()
End If

Return lvb_Sucesso
end function

public function boolean of_solicita_autorizacao (string as_cartao, string as_convenio, date adt_data_receita, string as_tipo_prescritor, string as_crm, string as_uf, string as_produto[], integer ai_qtde[], decimal adc_preco_venda_maximo[], decimal adc_preco_venda[]);Boolean lvb_Sucesso = False, &
		   lvb_sucesso_dep = true

String lvs_Autorizacao, &
	   lvs_Arquivo_ENV

lvs_Arquivo_ENV = This.ivs_Path_ENV + This.SOLICITACAO
This.ivb_Produto_Rejeitado = False

If This.of_Grava_Solicitacao(as_Cartao, &
                             as_Convenio, &
							 adt_Data_Receita, &
							 as_Tipo_Prescritor, &
							 as_CRM, &
							 as_UF, &
							 as_Produto[], &
							 ai_Qtde[], &
							 adc_preco_venda_maximo[], &
							 adc_preco_venda[]) Then
									  
	If This.of_Resposta_Recebida(This.SOLICITACAO, "Aguardando Autoriza$$HEX2$$e700e300$$ENDHEX$$o para Venda") Then
		If This.ivb_dependente Then
			If This.of_selecao_dependente( ref This.nm_dependente ) Then
				If This.of_grava_solicitacao_dep( This.nm_dependente ) Then
					If Not This.of_Resposta_Recebida(This.SOLICITACAO, "Aguardando Autoriza$$HEX2$$e700e300$$ENDHEX$$o para Venda") Then
						lvb_sucesso = False
						lvb_sucesso_dep = False
						If FileExists(lvs_Arquivo_ENV) Then
							This.of_Exclui_Arquivo_Enviado(lvs_Arquivo_ENV)
						End If						
					End If
				Else
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Problemas na gera$$HEX2$$e700e300$$ENDHEX$$o do arquivo de dependente.", Exclamation!)					
					lvb_sucesso = False
					lvb_sucesso_dep = False
				End If
			Else			
				lvb_sucesso = False
				lvb_sucesso_dep = False
			End If			
		End If
		If lvb_sucesso_dep Then
			If This.of_Grava_Autorizacao(Ref lvs_Autorizacao, &
										 as_Convenio, &
										 as_Cartao, &
										 adt_Data_Receita, &
										 as_Tipo_Prescritor, &
										 as_CRM) Then
										 
				This.nr_Autorizacao = lvs_Autorizacao				

				If This.ivb_Obriga_Receita Then //variavel carregada conforme retorno da autoriza$$HEX2$$e700e300$$ENDHEX$$o
					If IsNull(This.de_rejeicao) Then
						If Not of_captura_imagem() Then
							MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Dados da Receita N$$HEX1$$c300$$ENDHEX$$O foram captados!!", Information!)
						Else
							
						End If						
					End If
				End If
				
				If This.ivb_Produto_Rejeitado = False Then						
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Autoriza$$HEX2$$e700e300$$ENDHEX$$o '" + lvs_Autorizacao + "' recebida com sucesso.", Information!)									
				Else
					MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Autoriza$$HEX2$$e700e300$$ENDHEX$$o '" + lvs_Autorizacao + "' gerada com um ou mais itens rejeitados.", Exclamation! )				
				End If
				
				lvb_Sucesso = True
			End If
		End If
	Else
		If FileExists(lvs_Arquivo_ENV) Then
			This.of_Exclui_Arquivo_Enviado(lvs_Arquivo_ENV)
		End If
	End If
End If

//This.of_Desconexao()

Return lvb_Sucesso
end function

public function boolean of_exclui_autorizacao (string as_autorizacao);Boolean lvb_Sucesso = False, &
		lvb_Exclui  = False

String lvs_Convenio

Select cd_convenio Into :lvs_Convenio
From autorizacao_epharma
Where nr_autorizacao = :as_Autorizacao
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		
		Select cd_convenio Into :lvs_Convenio
		From venda_pbm
		Where cd_convenio     = 52718
		  and nr_autorizacao  = :as_Autorizacao
		  and dh_cancelamento is null
		Using SqlCa;
		
		Choose Case SqlCa.SqlCode 
			Case 0
				// Verifica se existe alguma venda para esta autoriza$$HEX2$$e700e300$$ENDHEX$$o
				Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Autoriza$$HEX2$$e700e300$$ENDHEX$$o j$$HEX1$$e100$$ENDHEX$$ cadastrada '" + as_Autorizacao + "'.~r~r" +&
									  "Existem vendas para esta autoriza$$HEX2$$e700e300$$ENDHEX$$o.", Information!)
				Return False
			Case 100
				// Se n$$HEX1$$e300$$ENDHEX$$o tiver venda vai excluir
				lvb_Exclui = True
			Case -1
				SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da venda pbm")
				Return False
		End Choose
				
		If lvb_Exclui Then
			
			Delete From autorizacao_epharma_produto
			Where nr_autorizacao = :as_Autorizacao
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				SqlCa.of_MsgdbError("Exclus$$HEX1$$e300$$ENDHEX$$o dos Produtos da Autoriza$$HEX2$$e700e300$$ENDHEX$$o")
			Else
				Delete From autorizacao_epharma
				Where nr_autorizacao = :as_Autorizacao
				Using SqlCa;
				
				If SqlCa.SqlCode = -1 Then
					SqlCa.of_MsgdbError("Exclus$$HEX1$$e300$$ENDHEX$$o da Autoriza$$HEX2$$e700e300$$ENDHEX$$o")
				Else
					lvb_Sucesso = True
				End If			
			End If
		End If
	Case 100
		lvb_Sucesso = True
	Case -1
		SqlCa.of_MsgdbError("Verifica$$HEX2$$e700e300$$ENDHEX$$o da Exist$$HEX1$$ea00$$ENDHEX$$ncia da Autoriza$$HEX2$$e700e300$$ENDHEX$$o")		
End Choose

Return lvb_Sucesso
end function

public function boolean of_inclui_autorizacao (string as_autorizacao, date adt_validade, long al_convenio, string as_cartao, string as_paciente, date adt_receita, string as_tipo_prescritor, string as_registro_prescritor);String ls_Receita

If 	This.ivb_Obriga_Receita Then
	ls_Receita = 'S'
Else
	ls_Receita = 'N'
End If

Insert Into autorizacao_epharma(nr_autorizacao,
                                dh_emissao,
                                dh_validade,
								cd_convenio,
								nr_cartao,
								nm_paciente,
								dt_receita,
								id_tipo_prescritor,
								nr_registro_prescritor,
								id_obriga_receita,
								id_capturou_receita)
Values (:as_Autorizacao,
       	:This.dh_emissao,
       	:adt_Validade,
	   	:al_Convenio,
	   	:as_Cartao,
	   	:as_Paciente,
		:adt_Receita,
		:as_Tipo_Prescritor,
		:as_Registro_Prescritor,
		:ls_Receita,
		'N')
Using SqlCa;

If SqlCa.SqlCode = - 1 Then
	SqlCa.of_MsgdbError("Inclus$$HEX1$$e300$$ENDHEX$$o da Autoriza$$HEX2$$e700e300$$ENDHEX$$o")
	Return False
Else
	Return True
End If
end function

public function boolean of_processa_retorno_consulta (string as_autorizacao, long al_convenio);Boolean lvb_Sucesso = False

Integer lvi_Arquivo, &
        lvi_Qtde, &
		  lvi_Read

Decimal lvdc_Preco_Maximo, &
        lvdc_Preco_Desconto, &
		  lvdc_Preco_ePharma, &
		  lvdc_Preco_Aquisicao, &
		  lvdc_Repasse_Varejo

String lvs_Arquivo, &
       lvs_Registro, &
		 lvs_Sequencial, &
		 lvs_Funcao, &
		 lvs_Status, &
		 lvs_Mensagem, &
		 lvs_Cartao,&
		 lvs_Paciente,&
		 lvs_Codigo_Barras, &
		 lvs_Rejeicao,&
		 lvs_Tipo_Prescritor,&
		 lvs_Registro_Prescritor,&
		 lvs_Autorizacao,&
		 lvs_Situacao, &
		 ls_Texto_Email_Log
		 
Long lvl_Produto

Date lvdt_Validade,&
     lvdt_Receita

lvs_Arquivo = This.ivs_Path_REC + This.CONSULTA

If Not This.of_Abre_Arquivo(lvs_Arquivo, lvi_Arquivo, "L") Then Return False

FileRead(lvi_Arquivo, lvs_Registro)

lvs_Sequencial  = MidA(lvs_Registro, 1, 4)
lvs_Funcao      = MidA(lvs_Registro, 5, 2)
lvs_Status      = MidA(lvs_Registro, 7, 2)
lvs_Mensagem    = MidA(lvs_Registro, 9, 40)
lvs_Autorizacao = MidA(lvs_Registro, 56, 12)

If lvs_Sequencial <> "0008" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Sequencial recebido no arquivo de resposta inv$$HEX1$$e100$$ENDHEX$$lido.~r" + &
								 "Sequencial: (" + lvs_Sequencial + ")", StopSign!)
Else
	If lvs_Funcao <> "04" Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Fun$$HEX2$$e700e300$$ENDHEX$$o recebida no arquivo de resposta inv$$HEX1$$e100$$ENDHEX$$lida.", StopSign!)
	Else
		If lvs_Status = "ER" Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Arquivo de resposta retornou um erro.~r~r" + lvs_Mensagem, StopSign!)
		Else
			lvdt_Validade = Today()
			lvdt_Receita  = Today()
			
			lvs_Cartao    = "0000000000000000000"
			lvs_Paciente  = "PACIENTE"
			
			lvs_Tipo_Prescritor     = "1"
			lvs_Registro_Prescritor = "CRM/CRO"
			
			// Verifica se existe a autoriza$$HEX2$$e700e300$$ENDHEX$$o e exclui
			If This.of_Exclui_Autorizacao(as_Autorizacao) Then
				// Inclui a autoriza$$HEX2$$e700e300$$ENDHEX$$o
				If This.of_Inclui_Autorizacao(as_Autorizacao, &
														lvdt_Validade, &
														al_Convenio, &
														lvs_Cartao, &
														lvs_Paciente, &
														lvdt_Receita, &
														lvs_Tipo_Prescritor, &
														lvs_Registro_Prescritor) Then
						
					lvi_Read = FileRead(lvi_Arquivo, lvs_Registro)
						
					Do While lvi_Read <> -100
						
						lvb_Sucesso = False
						
						If LenA(lvs_Registro) <> 61 Then
							If This.of_Valida_Linha_Retorno( lvs_Registro ) Then // Desconsidera os lixos j$$HEX1$$e100$$ENDHEX$$ previstos
								lvi_Read = FileRead(lvi_Arquivo, lvs_Registro)
								Continue
							End If							
							
							FileClose( lvi_Arquivo )
							
							ls_Texto_Email_Log = 'Tamanho do registro lido no arquivo resposta inv$$HEX1$$e100$$ENDHEX$$lido. uo_ge064_epharma.of_processao_retorno_transacao() <br /><br />Registro: ' + lvs_Registro + &
														  '<br />Autoriza$$HEX2$$e700e300$$ENDHEX$$o: ' + as_Autorizacao
														  
							lvi_Arquivo = FileOpen( lvs_Arquivo, StreamMode!, Read!, Shared! )
							FileRead( lvi_Arquivo, lvs_Registro )
							
							ls_Texto_Email_Log += '<br /><br />Conteudo do arquivo:<br />' + lvs_Registro
							
							gf_ge202_envia_email_log( 63, &
																'LOG RL AUTORIZACAO EPHARMA - LOJA(' + String( gvo_Parametro.Cd_Filial ) +')', &
																 ls_Texto_Email_Log )
							
							MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tamanho do registro lido no arquivo resposta inv$$HEX1$$e100$$ENDHEX$$lido. uo_ge064_epharma.of_processao_retorno_transacao()", StopSign!)
						Else
							lvs_Codigo_Barras		= MidA(lvs_Registro, 1, 13)
							lvi_Qtde					= Integer(MidA(lvs_Registro, 14, 2))
							lvdc_Preco_Maximo    = This.of_Decimal(MidA(lvs_Registro, 16, 7), 2)
							lvdc_Preco_Desconto	= This.of_Decimal(MidA(lvs_Registro, 23, 7), 2)
							lvdc_Preco_ePharma	= This.of_Decimal(MidA(lvs_Registro, 30, 7), 2)
							lvdc_Preco_Aquisicao	= This.of_Decimal(MidA(lvs_Registro, 37, 7), 2)
							lvdc_Repasse_Varejo	= This.of_Decimal(MidA(lvs_Registro, 44, 7), 2)
							lvs_Rejeicao				= MidA(lvs_Registro, 53, 2)
												
							If Trim(lvs_Rejeicao) = "" Then SetNull(lvs_Rejeicao)
							
							If This.of_Produto_Codigo_Barras(lvs_Codigo_Barras, lvl_Produto) Then 
								// Inclui os produtos autorizados
								lvb_Sucesso = This.of_Inclui_Produto_Autorizacao(as_Autorizacao, &
																							    lvl_Produto, &
																							    lvs_Codigo_Barras, &
																							    lvi_Qtde, &
																							    lvdc_Preco_Maximo, &
																							    lvdc_Preco_Desconto, &
																							    lvdc_Preco_ePharma, &
																							    lvdc_Preco_Aquisicao, &
																							    lvdc_Repasse_Varejo, &
																							    lvs_Rejeicao)
							End If
						End If
						
						If Not lvb_Sucesso Then Exit
						
						lvi_Read = FileRead(lvi_Arquivo, lvs_Registro)
					Loop
				End If
			End If
			
			If lvb_Sucesso Then
				SqlCa.of_Commit()
			Else
				SqlCa.of_RollBack()
			End If	
		End If
	End If
End If

FileClose(lvi_Arquivo)

If Not FileDelete(lvs_Arquivo) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na exclus$$HEX1$$e300$$ENDHEX$$o de resposta '" + lvs_Arquivo + "'.", StopSign!)
End If

Return lvb_Sucesso
end function

public function boolean of_consulta_autorizacao (string as_autorizacao, long al_convenio);Boolean lvb_Sucesso = False

If This.of_Grava_Consulta(as_Autorizacao) Then
	If This.of_Resposta_Recebida(This.CONSULTA, "Aguardando Consulta da Autoriza$$HEX2$$e700e300$$ENDHEX$$o") Then
		ivb_Consulta = True // Este par$$HEX1$$e200$$ENDHEX$$metro $$HEX1$$e900$$ENDHEX$$ utilizado na hora de abrir o arquivo de retorno
		If This.of_Processa_Retorno_Consulta(as_Autorizacao, al_Convenio) Then
			If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Consulta da autoriza$$HEX2$$e700e300$$ENDHEX$$o '" + as_Autorizacao + "' realizada com sucesso.~r" + &
			                         "Deseja imprimir o comprovante ?", Question!, YesNo!, 2) = 1 Then
				This.of_Imprime_Autorizacao(as_Autorizacao)
			End If
			
			lvb_Sucesso = True
		End If
	End If
End If

Return lvb_Sucesso
end function

public function boolean of_grava_consulta (string as_autorizacao);Boolean lvb_Sucesso = True

Integer lvi_Arquivo, &
        lvi_Contador

String lvs_Arquivo_ENV, &
       lvs_Arquivo_TMP, &
		 lvs_Arquivo_REC, &
       lvs_Linha		 

lvs_Arquivo_TMP = This.ivs_Path_TMP + This.CONSULTA
lvs_Arquivo_ENV = This.ivs_Path_ENV + This.CONSULTA
lvs_Arquivo_REC = This.ivs_Path_REC + This.CONSULTA

//Exclui o arquivo recebido
This.of_Exclui_Arquivo_Recebido(lvs_Arquivo_REC)

If Not This.of_Abre_Arquivo(lvs_Arquivo_TMP, lvi_Arquivo, "G") Then Return False

// Grava a linha de cabe$$HEX1$$e700$$ENDHEX$$alho
lvs_Linha = "0008" + &
            "04"   + &
				as_autorizacao + &
				"1"

If Not This.of_Grava_Arquivo(lvi_Arquivo, lvs_Linha) Then lvb_Sucesso = False

FileClose(lvi_Arquivo)

Return This.of_Trata_Arquivo_Temporario(lvs_Arquivo_TMP, lvs_Arquivo_ENV, lvb_Sucesso)	
end function

public function boolean of_captura_imagem ();Boolean lb_Sucesso = False
Date ldh_emissao, ldh_emissao2

OpenWithParm(w_ge064_captura_receita,This)

//gf_Ativa_Janela(This)

Choose Case This.Retorno
	Case 'OK'
		//Gera arquivo epharma de digitalizacao	
		If This.of_grava_digitalizacao( This.nr_autorizacao, This.ivs_arquivo_digitalizado) Then
			If This.of_Resposta_Recebida(This.DIGITALIZACAO, "Aguardando Envio da digitaliza$$HEX2$$e700e300$$ENDHEX$$o") Then				
				If This.of_Processa_Retorno_Digitalizacao() Then
					lb_Sucesso = True
					
					ldh_emissao = Date(This.dh_emissao)
					ldh_emissao2	= RelativeDate(ldh_emissao, 1 )		
					
					Update autorizacao_epharma
					Set id_capturou_receita  = 'S'
					Where nr_autorizacao = :This.nr_autorizacao
					and dh_emissao >= :ldh_emissao
					and dh_emissao <= :ldh_emissao2
					Using SqlCa;
					
					If SqlCa.SqlCode = -1 Then
						Sqlca.of_RollBack()			
						lb_Sucesso = False				
					Else
						Sqlca.of_Commit()
						This.ivb_Capturou_Receita = True	
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Digitaliza$$HEX2$$e700e300$$ENDHEX$$o de imagens feita com sucesso!", Information!)			
					End If	
				Else
					lb_sucesso = False
				End If
			Else
				lb_sucesso = False
			End If
		Else
			lb_Sucesso = False
		End If
		
	Case 'CANCELAR'
		lb_Sucesso = False	
End Choose

Return lb_Sucesso


end function

public function boolean of_valida_linha_retorno (string ps_registro);/* Fernando Cambiaghi - 10/06/2016
	O retorno no arquivo cont$$HEX1$$e900$$ENDHEX$$m linhas n$$HEX1$$e300$$ENDHEX$$o previstas, com isso, foi realizada interven$$HEX2$$e700e300$$ENDHEX$$o para desconsiderar esses retornos
*/

If LenA( ps_Registro ) <> 61 Then

	If IsNumber( Trim( ps_Registro ) ) Then
		If Long( Trim( ps_Registro ) ) = 0 Then Return True // 000000000
	End If
	
	If Trim( ps_Registro ) = '' Then Return True // Linha em branco
End If

Return False
end function

public function boolean of_grava_digitalizacao (string as_transacao, string as_caminho_arquivo);Boolean lvb_Sucesso = True

String lvs_Arquivo_TMP, &
		 lvs_Arquivo_REC, &
		 lvs_Arquivo_ENV, &
		 lvs_String

Integer lvi_Arquivo

Long ll_tam, ll_espaco

lvs_Arquivo_TMP = ivs_Path_TMP + DIGITALIZACAO
lvs_Arquivo_REC = ivs_Path_REC + DIGITALIZACAO
lvs_Arquivo_ENV = ivs_Path_ENV + DIGITALIZACAO

ll_tam = LenA(as_caminho_arquivo)
ll_espaco = 128 - ll_tam

// Exclui os arquivos recebidos que n$$HEX1$$e300$$ENDHEX$$o foram lidos
This.of_Exclui_Arquivo_Recebido(lvs_Arquivo_REC)

If Not This.of_Abre_Arquivo(lvs_Arquivo_TMP, Ref lvi_Arquivo, "G" ) Then Return False

lvs_String = "0001" 		  +& 
				 "11"         +&
				 as_transacao +&
				 as_caminho_arquivo + Space(ll_espaco)

If Not This.of_Grava_Arquivo(lvi_Arquivo, lvs_String) Then lvb_Sucesso = False

FileClose(lvi_Arquivo)

Return This.of_Trata_Arquivo_Temporario(lvs_Arquivo_TMP, lvs_Arquivo_ENV, lvb_Sucesso)
end function

public function boolean of_processa_retorno_digitalizacao ();Boolean lvb_Sucesso = False

String lvs_Arquivo_REC,&
		 lvs_Sequencial, &
       lvs_Funcao    , &
		 lvs_Status    , &
		 lvs_MSG			, &
		 lvs_String

Integer lvi_Arquivo
	
lvs_Arquivo_REC = ivs_path_rec + This.DIGITALIZACAO

If Not This.of_Abre_Arquivo(lvs_Arquivo_REC, Ref lvi_Arquivo, "L") Then Return False

FileRead(lvi_Arquivo, lvs_String)

lvs_Sequencial = MidA(lvs_String, 1, 4)
lvs_Funcao     = MidA(lvs_String, 5, 2)
lvs_Status     = MidA(lvs_String, 7, 2)
lvs_MSG        = MidA(lvs_String, 9, 40)

If lvs_Sequencial <> "0001" Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Seq$$HEX1$$fc00$$ENDHEX$$encial do arquivo recebido no arquivo inv$$HEX1$$e100$$ENDHEX$$lido.", StopSign!)
Else
	If lvs_Funcao <> "11" Then
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Fun$$HEX2$$e700e300$$ENDHEX$$o recebida no arquivo inv$$HEX1$$e100$$ENDHEX$$lida.", StopSign!)
	Else
		If lvs_Status = "ER" Then
			Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A resposta do retorno retornou um erro.~r~r" +&
							lvs_MSG, StopSign!)
		Else
			lvb_Sucesso = True
		End If
	End If
End If

FileClose(lvi_Arquivo)

If Not FileDelete(lvs_Arquivo_REC) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na exclus$$HEX1$$e300$$ENDHEX$$o de resposta '" + lvs_Arquivo_REC + "'.", StopSign!)
End IF

Return lvb_Sucesso
end function

public function boolean of_grava_solicitacao_cancelamento (string as_transacao, string as_cupom, string as_ecf, string as_tipo);Boolean lvb_Sucesso = True

String lvs_Arquivo_TMP, &
		 lvs_Arquivo_REC, &
		 lvs_Arquivo_ENV, &
		 lvs_String, &
		 lvs_tipo

Integer lvi_Arquivo

Long lvl_ecf, lvl_cupom

lvs_Arquivo_TMP = ivs_Path_TMP + CANCELAMENTO
lvs_Arquivo_REC = ivs_Path_REC + CANCELAMENTO
lvs_Arquivo_ENV = ivs_Path_ENV + CANCELAMENTO

// Exclui os arquivos recebidos que n$$HEX1$$e300$$ENDHEX$$o foram lidos
This.of_Exclui_Arquivo_Recebido(lvs_Arquivo_REC)

If Not This.of_Abre_Arquivo(lvs_Arquivo_TMP, Ref lvi_Arquivo, "G" ) Then Return False

If Upper(Trim(ivs_epharma_plugin)) = 'S' Then
	lvl_ecf 		= Long(as_ecf)
	lvl_cupom	= Long(as_cupom)
	as_ecf 		= String(lvl_ecf,'000000000')
	as_cupom 	= String(lvl_cupom,'000000000')
	If as_tipo = 'V' Then
		lvs_tipo = '1'
	Else
		lvs_tipo = '0'
	End If
	
	lvs_String = "0100" 		  +& 
					 "10"         +&
					 "21"         +&
					 as_transacao +&
					 "1" 			  +&
					 as_ecf 		  +&
					 as_cupom	  +&
					 lvs_tipo
Else
	lvs_String = "0100" 		  +& 
					 "10"         +&
					 "21"         +&
					 as_transacao +&
					 "1" 			  +&
					 as_ecf 		  +&
					 as_cupom
End If

If Not This.of_Grava_Arquivo(lvi_Arquivo, lvs_String) Then lvb_Sucesso = False

FileClose(lvi_Arquivo)

Return This.of_Trata_Arquivo_Temporario(lvs_Arquivo_TMP, lvs_Arquivo_ENV, lvb_Sucesso)
end function

public function boolean of_verifica_licensa_antiga (ref string as_licensa);Integer li_FileOpen

Long  ll_Linhas 

String ls_Conteudo_Arquivo,& 
		 ls_Registro,& 
		 ls_Arquivos[],& 
		 ls_Dir,& 
		 ls_Arquivo_Atual 

DateTime ldt_Arquivo_MaisNovo,& 
         ldt_Arquivo_Data 

Boolean lb_Sucesso 

lb_Sucesso = FALSE 

//CAPTURA O VALOR ANTIGO DA LICEN$$HEX1$$c700$$ENDHEX$$A 
ls_Registro = "Registry: Lido CodPos:"

li_FileOpen = FileOpen ( "C:\Epharma\"+ String(gvo_parametro.dh_movimentacao, "YYYY-MM-DD") + ".F00", TextMode! , Read!) 

IF li_FileOpen < 0 THEN 
	setNull(li_FileOpen) 

	ls_Dir = "C:\Epharma\"

	gf_dir_list(ls_Dir, '*.F00', 0+1, REF ls_Arquivos) 

	IF UpperBound( ls_Arquivos ) = 0 THEN 
		RETURN FALSE 
	ELSE 
		FOR ll_Linhas = 1 TO  UpperBound( ls_Arquivos )
			ldt_Arquivo_Data = This.of_verifica_data_arquivo( ls_Dir + ls_Arquivos[ll_Linhas]) 

			IF ldt_Arquivo_Data > ldt_Arquivo_MaisNovo THEN 
				ldt_Arquivo_MaisNovo = ldt_Arquivo_Data
				ls_Arquivo_Atual = ls_Arquivos[ll_Linhas] 
			END IF 
			
			lb_Sucesso = TRUE
		NEXT 
		
		li_FileOpen = FileOpen ( ls_dir + ls_Arquivo_Atual , TextMode! , Read!)
		
	END IF 
ELSE 
	lb_Sucesso = TRUE 
END IF 

IF lb_Sucesso THEN 
	
	If li_FileOpen > 0 Then
		FileReadEx (li_FileOpen, ls_Conteudo_Arquivo) 
		FileClose (li_FileOpen) 
	End If
	
	as_licensa = gf_tira_zero_esquerda(midA(ls_Conteudo_Arquivo, posA(ls_Conteudo_Arquivo,ls_Registro) + LenA(ls_Registro) ,8)) 
END IF 

RETURN TRUE 



end function

public function datetime of_verifica_data_arquivo (string as_filename);String ls_test, ls_path, ls_file
DateTime ldt_retorno
OLEObject obj_shell, obj_folder, obj_item

Try
	SetNull(ldt_retorno)
	
	obj_shell = CREATE OLEObject
	obj_shell.ConnectToNewObject( 'shell.application' )
	
	ls_path = Left( as_filename, LastPos( as_filename, "\" ) )
	ls_file = Mid( as_filename, LastPos( as_filename, "\" ) + 1 )
	
	 obj_folder = obj_shell.NameSpace( ls_path )
	 
	 IF IsValid( obj_folder ) THEN
		  obj_item = obj_folder.ParseName( ls_file )
		  
		  IF IsValid( obj_item ) THEN
				ls_test = obj_folder.GetDetailsOf( obj_item, 3 )			
				ldt_retorno = DateTime( ls_test )
		  END IF
	 END IF

Finally
	If IsValid( obj_shell ) 		Then DESTROY obj_shell
	If IsValid( obj_folder ) 	Then DESTROY obj_folder
	If IsValid( obj_item ) 		Then DESTROY obj_item
	
	Return ldt_retorno
	
End Try
end function

public function boolean of_cria_diretorios_epharma_plugin ();If Not DirectoryExists("C:\e-PharmaPlugin") Then
	If  CreateDirectory("C:\e-PharmaPlugin") <> 1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao criar os diret$$HEX1$$f300$$ENDHEX$$rios necessarios.", Exclamation!)
		Return False
	End If
End If

If Not DirectoryExists("C:\e-PharmaPlugin\Config") Then
	If  CreateDirectory("C:\e-PharmaPlugin\Config") <> 1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao criar o diret$$HEX1$$f300$$ENDHEX$$rio Config.", Exclamation!)
		Return False
	End If
End If

If Not DirectoryExists("C:\e-PharmaPlugin\ENV") Then
	If  CreateDirectory("C:\e-PharmaPlugin\ENV") <> 1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao criar o diret$$HEX1$$f300$$ENDHEX$$rio \ENV .", Exclamation!)
		Return False
	End If
End If 

If Not DirectoryExists("C:\e-PharmaPlugin\REC") Then
	If  CreateDirectory("C:\e-PharmaPlugin\REC") <> 1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao criar o diret$$HEX1$$f300$$ENDHEX$$rio \REC .", Exclamation!)
		Return False
	End If
End If

If Not DirectoryExists("C:\e-PharmaPlugin\tmp") Then
	If  CreateDirectory("C:\e-PharmaPlugin\tmp") <> 1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao criar o diret$$HEX1$$f300$$ENDHEX$$rio \tmp .", Exclamation!)
		Return False
	End If
End If

If Not DirectoryExists("C:\e-PharmaPlugin\ScannerImagens") Then
	If  CreateDirectory("C:\e-PharmaPlugin\ScannerImagens") <> 1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao criar o diret$$HEX1$$f300$$ENDHEX$$rio \ScannerImagens .", Exclamation!)
		Return False
	End If
End If

Return True
end function

public function boolean of_atualiza_config_epharma_plugin ();Integer	li_FileOpen,&
		 	li_Write
			 
String	ls_Diretorio,&
		ls_Conteudo_Arquivo,&
		ls_xml_Padrao,&
		ls_xml,&
		ls_Licenca

ls_Diretorio = "C:\e-PharmaPlugin\Config\Plconf.xml"

Try
	
	If not This.of_verifica_licensa_antiga( ref ls_Licenca) Then Return False
	
	If not ivo_xml.of_abre_arquivo( ls_Diretorio )  Then
		Return False
	Else
		ls_xml_Padrao = "<StatusActive>Inactive</StatusActive>"+&
							"<UriBaseAdressWebApi>https://PosWebApi.epharma.com.br/</UriBaseAdressWebApi>"+&
							"<LocalSaveImageDirectory>C:\e-PharmaPlugin\ScannerImagens</LocalSaveImageDirectory>"+&
							"<DeviceScannerSelected/>"+&
							"<RadioSelectScannerMode>WIA</RadioSelectScannerMode>"+&
							"<ResolutionScanner>0</ResolutionScanner>"+&
							"<LocalSavePdvCommand>C:\e-PharmaPlugin\ENV</LocalSavePdvCommand>"+&
							"<LocalSavePdvReturn>C:\e-PharmaPlugin\REC</LocalSavePdvReturn>"+&
							"<RadioSelectConsultPriceMode>NoFile</RadioSelectConsultPriceMode>"+&
							"<LocalDllFileToConsultPrice/>"+&
							"<LocalImportFileToConsultPrice/>"+&
							"<GBASFile/>"+&
							"<TerminalIp/>"+&
							"<ListConvenioLastUpdateDate>0001-01-01T00:00:00</ListConvenioLastUpdateDate>"+&
							"<Convenios/>"+&
							"<Motivos/>"+&
							"<LoginCnpj>false</LoginCnpj>"+&
							"</PluginParameters>"
										
		ls_xml  		= '<PluginParameters xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">'+&
							"<NRLICENSE>" +ls_Licenca+"</NRLICENSE>" +&
							"<CPNJ>" + gvo_parametro.nr_cgc +"</CPNJ>" +&
	/*XML PADRAO*/ 	ls_xml_Padrao
	
	End If
	
	If Not ivo_xml.of_grava_arquivo( ls_xml) Then
	End If
	
Catch(runtimeerror lo)

Finally
	ivo_xml.of_fecha_arquivo( )
End Try

Return True
end function

public function boolean of_existe_licenca ();Integer li_FileOpen 
String	ls_Conteudo_Arquivo,& 
   		ls_Diretorio,& 
 	    	ls_Licenca 

TRY

	ls_diretorio = "C:\e-PharmaPlugin\Config\Plconf.xml"

	li_FileOpen = FileOpen(ls_Diretorio , TextMode! , Read!, Shared!) 
	FileReadEx (li_FileOpen, ls_Conteudo_Arquivo) 
	FileClose (li_FileOpen) 

	ls_Licenca = ivo_xml.of_busca_conteudo_tag(ls_Conteudo_Arquivo, "NRLICENSE") 

	IF ls_Licenca = '' OR IsNull(ls_Licenca) THEN RETURN FALSE 

FINALLY 

END TRY 

RETURN TRUE 



end function

public function boolean of_selecao_dependente (ref string as_dependente);Boolean lvb_Sucesso = False

Integer	lvi_Arquivo, &
			lvi_Qtde, &
			lvi_Read

String	lvs_Arquivo, &
		lvs_Registro, &
		lvs_Sequencial, &
		lvs_Funcao, &
		lvs_Status, &
		lvs_Dependentes, &
		lvs_Mensagem, &
		lvs_retorno

lvs_Arquivo = This.ivs_Path_REC + This.SOLIC_DEP

If Not This.of_Abre_Arquivo(lvs_Arquivo, lvi_Arquivo, "L") Then Return False

FileRead(lvi_Arquivo, lvs_Registro)

lvs_Sequencial  = MidA(lvs_Registro, 1, 4)
lvs_Funcao      = MidA(lvs_Registro, 5, 2)
lvs_Status      = MidA(lvs_Registro, 7, 2)
lvs_dependentes  = RightA(lvs_Registro, LenA(lvs_Registro) - 8)
lvs_Mensagem     = RightA(lvs_Registro, LenA(lvs_Registro) - 8)

If lvs_Sequencial <> "0001" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Sequencial recebido no arquivo de resposta inv$$HEX1$$e100$$ENDHEX$$lido. uo_ge064_epharma.of_grava_autorizacao()", StopSign!)
Else
	If lvs_Funcao <> "01" Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Fun$$HEX2$$e700e300$$ENDHEX$$o recebida no arquivo de resposta inv$$HEX1$$e100$$ENDHEX$$lida. uo_ge064_epharma.of_grava_autorizacao()", StopSign!)
	Else
		If lvs_Status = "ER" Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Arquivo de resposta retornou um erro. uo_ge064_epharma.of_grava_autorizacao()~r~r" + lvs_Mensagem, StopSign!)
		Else
			//Lista dependentes para sele$$HEX2$$e700e300$$ENDHEX$$o.
			
			OpenWithParm(w_ge064_selecao_dependente, lvs_dependentes)

			lvs_Retorno = Message.StringParm
			
			as_dependente = lvs_Retorno			
			If lvs_Retorno <> 'CANCELAR' Then				
				as_dependente = lvs_Retorno
				lvb_sucesso = True
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi selecionado dependente.", StopSign!)
			End If	
		End If
	End If
End If

FileClose(lvi_Arquivo)

If Not FileDelete(lvs_Arquivo) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na exclus$$HEX1$$e300$$ENDHEX$$o de resposta '" + lvs_Arquivo + "'.", StopSign!)
End If

Return lvb_Sucesso
end function

public function boolean of_grava_solicitacao_dep (string as_dependente);Boolean lvb_Sucesso = True

Integer lvi_Arquivo, &
        lvi_Contador, lvi_Len

String lvs_Arquivo_ENV, &
       lvs_Arquivo_TMP, &
		 lvs_Arquivo_REC,&
       lvs_Linha, &
		 lvs_Produto, &
		 lvs_Preco_PMC, &
		 lvs_Preco_Venda 

lvs_Arquivo_TMP = This.ivs_path_tmp + This.SOLIC_DEP
lvs_Arquivo_ENV = This.ivs_Path_ENV + This.SOLIC_DEP
//lvs_Arquivo_REC = This.ivs_path_REC + This.SOLICITACAO

If Not This.of_Abre_Arquivo(lvs_Arquivo_TMP, lvi_Arquivo, "G") Then Return False

lvs_Linha = "0001" + &
				"11" + &
				"RE" + &
				as_dependente

If Not This.of_Grava_Arquivo(lvi_Arquivo, lvs_Linha) Then
	lvb_Sucesso = False
End If

FileClose(lvi_Arquivo)

If Not lvb_Sucesso Then
	Return False
End If

gf_delay(3)

Return This.of_Trata_Arquivo_Temporario(lvs_Arquivo_TMP, lvs_Arquivo_ENV, lvb_Sucesso)
end function

on uo_ge064_epharma.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge064_epharma.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ivo_API = Create dc_uo_API

uo_Parametro_Filial lvo_Parametro
lvo_Parametro = Create uo_Parametro_Filial
ivo_xml =  CREATE uo_ge073_gera_xml 

lvo_Parametro.of_Localiza_Parametro('ID_USA_EPHARMA_PLUGIN', ref ivs_epharma_plugin, False)

Destroy(lvo_Parametro)
end event

event destructor;Destroy(ivo_API)
Destroy(ivo_xml) 
end event

