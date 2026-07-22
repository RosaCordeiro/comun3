HA$PBExportHeader$uo_prestador_servico_clube.sru
forward
global type uo_prestador_servico_clube from nonvisualobject
end type
end forward

global type uo_prestador_servico_clube from nonvisualobject
end type
global uo_prestador_servico_clube uo_prestador_servico_clube

type variables
Integer cd_prestador

Long cd_produto

Decimal vl_pago

String ivs_parametro

String nm_prestador,&
          id_situacao

Boolean Localizado

end variables

forward prototypes
public subroutine of_localiza_prestador (string ps_parametro)
public subroutine of_localiza_generica (string ps_parametro)
public subroutine of_inicializa ()
public function boolean of_localiza_codigo (long pl_prestador)
public function boolean of_proximo_lancamento_caixa (string as_caixa, long al_controle_caixa, ref integer ai_lancamento)
public function boolean of_inclui_lancamento_caixa (string as_caixa, long al_controle_caixa, decimal adc_lancamento, string as_historico, string as_parametro_loja)
public function boolean of_cancela_pagamento (long al_nr_pgto, string as_matricula_operador)
public function boolean of_grava_pagto_servico_clube (long al_prestador, decimal adc_pgto_total, long al_filial, string as_matricula_pgto, long al_vale_resgate[], long al_produto[], decimal adc_pgto_resgate[])
public function boolean of_valida_vale_resgate (long al_prestador, long al_vale_resgate, long al_filial_pgto)
public function boolean of_verifica_pagto (long al_vale_resgate)
public function boolean of_localiza_cidade (long al_filial, ref integer ai_cidade, ref string as_nome_cidade)
public function boolean of_verifica_produto_prestador (long al_prestador, long al_produto, ref decimal adc_vlr_custo)
public function boolean of_grava_pagto_servico_clube (long al_nr_pgto, long al_prestador, decimal adc_pgto_total, long al_filial, string as_matricula_pgto)
public function boolean of_grava_pagto_servico_clube_produto (long al_nr_pgto, long al_vale_resgate, long al_produto, decimal adc_pgto_resgate)
public function boolean of_grava_pagto_servico_clube_produto (long al_nr_pgto, long al_vale_resgate[], long al_produto[], decimal adc_pgto_resgate[])
public function boolean of_localiza_vale_resgate (long al_vale_resgate, ref long al_produto, long al_filial_pgto)
public function boolean of_localiza_proximo_pgto (ref long al_nr_pagto)
end prototypes

public subroutine of_localiza_prestador (string ps_parametro);Integer lvi_Tamanho

lvi_Tamanho = LenA(ps_Parametro)

// Verifica se foi recebido algum par$$HEX1$$e200$$ENDHEX$$metro
If lvi_Tamanho > 0 Then
	
	// Verifica o tipo do par$$HEX1$$e200$$ENDHEX$$metro recebido
	If IsNumber(ps_Parametro) Then

		// Localiza$$HEX2$$e700e300$$ENDHEX$$o direta pelo c$$HEX1$$f300$$ENDHEX$$digo da prestador
		of_Localiza_Codigo(Long(ps_Parametro))

		If Not Localizado Then

			// Se n$$HEX1$$e300$$ENDHEX$$o localizar pelos m$$HEX1$$e900$$ENDHEX$$todos anteriores
			// Abre a janela de localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica
			of_Localiza_Generica("")
		End If
	
	Else
		// Localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica conforme o nome do prestador
		of_Localiza_Generica(ps_Parametro)
	End If
	
Else
	
	// Localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica sem par$$HEX1$$e200$$ENDHEX$$metros
	of_Localiza_Generica("")
End If
end subroutine

public subroutine of_localiza_generica (string ps_parametro);Long lvl_Prestador

This.ivs_parametro = ps_Parametro

OpenWithParm(w_ge089_selecao_prestador_servico, This)

lvl_Prestador = Message.DoubleParm	

If Not IsNull(lvl_Prestador) Then
	of_Localiza_Codigo(lvl_Prestador)
Else
	Localizado = False
End If
end subroutine

public subroutine of_inicializa ();SetNull(Cd_Prestador)
nm_Prestador = ""
end subroutine

public function boolean of_localiza_codigo (long pl_prestador);Boolean lvb_Sucesso = False

uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao()

lvo_Conexao.of_Define_Variaveis(True)

lvo_Conexao.of_Executa_Rotina("0139", { String(pl_Prestador) })

If lvo_Conexao.of_Erro_Execucao() Or lvo_Conexao.of_Erro_Conexao() Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na conex$$HEX1$$e300$$ENDHEX$$o com o servidor distribu$$HEX1$$ed00$$ENDHEX$$do.")
Else
	If lvo_Conexao.of_Linhas() > 0 Then
		If lvo_Conexao.of_Retorno("nm_prestador", Ref nm_Prestador) 	Then
			If lvo_Conexao.of_Retorno("id_situacao", Ref id_Situacao) 		Then
				This.cd_Prestador = pl_Prestador
				Localizado		= True
				lvb_Sucesso 	= True
			End If
		End If
	Else
		Localizado	= False
	End If	
End If

Destroy(lvo_Conexao)

Return lvb_Sucesso
end function

public function boolean of_proximo_lancamento_caixa (string as_caixa, long al_controle_caixa, ref integer ai_lancamento);Select Max(nr_lancamento) 
Into :ai_lancamento
From lancamento_caixa
Where cd_caixa 			=:as_caixa
  and nr_controle_caixa =:al_controle_caixa
Using SqlCa;

If SqlCa.Sqlcode = -1 Then
	SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do pr$$HEX1$$f300$$ENDHEX$$ximo lan$$HEX1$$e700$$ENDHEX$$amento do caixa (" + as_Caixa + "-" + String(al_Controle_Caixa) + ").") 
	Return False

Else
	If IsNull(ai_Lancamento) Then ai_Lancamento = 0
	
	ai_Lancamento = ai_Lancamento + 1
End If

Return True
end function

public function boolean of_inclui_lancamento_caixa (string as_caixa, long al_controle_caixa, decimal adc_lancamento, string as_historico, string as_parametro_loja);Integer lvi_Lancamento,&
		lvi_Conta_Caixa
		
uo_Parametro_Filial lvo_Parametro_Filial 

lvo_Parametro_Filial = Create uo_Parametro_Filial

If Not lvo_Parametro_Filial.of_Localiza_Parametro(as_Parametro_Loja, Ref lvi_Conta_Caixa) Then 
	Return False
End If

Destroy(lvo_Parametro_Filial)

If Not of_Proximo_Lancamento_Caixa(as_Caixa, al_Controle_Caixa, Ref lvi_Lancamento) Then Return False

Insert Into lancamento_caixa  
	 ( cd_caixa,   
	   nr_controle_caixa,   
	   nr_lancamento,   
	   cd_conta_fluxo_caixa,   
	   dh_lancamento,   
	   vl_lancamento,   
	   de_historico,   
	   nr_recibo_cobranca,   
	   id_estorno )  
Values (:as_Caixa,   
	    :al_Controle_Caixa,   
	    :lvi_Lancamento,   
	    :lvi_Conta_Caixa,   
	    getdate(),   
	    :adc_Lancamento,   
	    :as_historico,   
	    null,   
	    'N' )
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Inclus$$HEX1$$e300$$ENDHEX$$o do lan$$HEX1$$e700$$ENDHEX$$amento no caixa (" + as_Caixa + "-" + String(al_Controle_Caixa) + ").")
	SqlCa.of_RollBack();
	Return False
Else
	SqlCa.of_Commit();
End If

Return True
end function

public function boolean of_cancela_pagamento (long al_nr_pgto, string as_matricula_operador);Boolean lvb_Sucesso = False
	
Long lvl_Row

String lvs_Tabela
String lvs_Set
String lvs_Where

uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao()
	
lvs_Tabela	 = "pagto_servico_clube"

lvs_Set		 =  " dh_cancelamento							= '" + String(Today(),"yyyy/mm/dd hh:mm:dd") + "',"
lvs_Set		 += " nr_matricula_cancelamento				= '" + as_Matricula_Operador 				 + "'"

lvs_Where	 = " nr_pagamento = "  + String(al_nr_pgto)
		
If Not lvo_Conexao.of_Update_Registro(lvs_Tabela, lvs_Set, lvs_Where, Ref lvl_Row) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no cancelamento do pagamento do servi$$HEX1$$e700$$ENDHEX$$o do clube '" + String(al_nr_pgto) + "'", Information!)
Else
	lvb_Sucesso = True
End If	

Destroy(lvo_Conexao)

Return lvb_Sucesso
end function

public function boolean of_grava_pagto_servico_clube (long al_prestador, decimal adc_pgto_total, long al_filial, string as_matricula_pgto, long al_vale_resgate[], long al_produto[], decimal adc_pgto_resgate[]);Boolean lvb_Sucesso = False

Long lvl_Nr_Pagto

If of_Localiza_Proximo_Pgto(lvl_Nr_Pagto) Then
	If of_Grava_Pagto_Servico_Clube(lvl_Nr_Pagto,& 
								    al_Prestador,& 
									adc_Pgto_Total,& 
									al_Filial,& 
									as_Matricula_pgto) Then
									
		If of_Grava_Pagto_Servico_Clube_Produto(lvl_Nr_Pagto,&
												al_Vale_Resgate[],&
												al_Produto[],&
												adc_Pgto_Resgate[]) Then
			lvb_Sucesso = True
		End If	
	End If
End If

Return lvb_Sucesso 
end function

public function boolean of_valida_vale_resgate (long al_prestador, long al_vale_resgate, long al_filial_pgto);Boolean lvb_Sucesso = False

If of_Localiza_Vale_Resgate(al_vale_resgate, Ref cd_produto, Ref al_Filial_Pgto) Then
	If of_Verifica_Pagto(al_Vale_Resgate) Then
		lvb_Sucesso = of_Verifica_Produto_Prestador(al_Prestador, cd_produto, Ref vl_pago)
	End If
End If

Return lvb_Sucesso 

end function

public function boolean of_verifica_pagto (long al_vale_resgate);Boolean lvb_Sucesso = False

Long lvl_Prestador,&
	 lvl_Filial

DateTime lvdh_Pagamento

uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao()

lvo_Conexao.of_Define_Variaveis(True)

lvo_Conexao.of_Executa_Rotina("0040",{String(al_Vale_Resgate)})

If lvo_Conexao.of_Erro_Execucao() Or lvo_Conexao.of_Erro_Conexao() Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do pagamento do servi$$HEX1$$e700$$ENDHEX$$o do vale de resgate '" + String(al_Vale_Resgate) + "'.")
Else
	If lvo_Conexao.of_Linhas() > 0 Then
		If lvo_Conexao.of_Retorno("cd_prestador", Ref lvl_Prestador) Then
			If lvo_Conexao.of_Retorno("dh_pagamento", Ref lvdh_Pagamento) Then
				If lvo_Conexao.of_Retorno("cd_filial", Ref lvl_Filial) Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O vale de resgate '" + String(al_Vale_Resgate) + "' j$$HEX1$$e100$$ENDHEX$$ foi pago para o prestador '" + &
								  String(lvl_Prestador) + "' na filial '" + String(lvl_Filial) + "' em '" + &
								  String(lvdh_Pagamento, "dd/mm/yyyy") + "'.")
				End If
			End If
		End If
	Else
		lvb_Sucesso = True
	End If
End If

Return lvb_Sucesso


end function

public function boolean of_localiza_cidade (long al_filial, ref integer ai_cidade, ref string as_nome_cidade);Boolean lvb_Sucesso = False

Long lvl_Cidade

uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao()

lvo_Conexao.of_Define_Variaveis(True)

lvo_Conexao.of_Executa_Rotina("0039",{String(al_Filial)})

If lvo_Conexao.of_Erro_Execucao() Or lvo_Conexao.of_Erro_Conexao() Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o cidade da filial '" + String(al_Filial) + "'.")
Else
	If lvo_Conexao.of_Linhas() > 0 Then
		If lvo_Conexao.of_Retorno("cd_cidade", Ref lvl_Cidade) Then
			If lvo_Conexao.of_Retorno("nm_cidade", Ref as_Nome_Cidade) Then
				lvb_Sucesso = True
			End If
		End If
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Cidade da filial '" + String(al_Filial) + "' n$$HEX1$$e300$$ENDHEX$$o foi localizada.")
	End If
End If

Destroy(lvo_Conexao)

ai_Cidade = lvl_Cidade

Return lvb_Sucesso

end function

public function boolean of_verifica_produto_prestador (long al_prestador, long al_produto, ref decimal adc_vlr_custo);Boolean lvb_Sucesso = False

uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao()

lvo_Conexao.of_Define_Variaveis(True)
lvo_Conexao.of_ConverteVirgula(True)

lvo_Conexao.of_Executa_Rotina("0041",{String(al_prestador), String(al_produto)})

If lvo_Conexao.of_Erro_Execucao() Or lvo_Conexao.of_Erro_Conexao() Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do custo do servi$$HEX1$$e700$$ENDHEX$$o '" + String(al_Produto) + "'.")
Else
	If lvo_Conexao.of_Linhas() > 0 Then
		If lvo_Conexao.of_Retorno("vl_custo", Ref adc_vlr_custo) Then
			lvb_Sucesso = True
		End If
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O custo do servi$$HEX1$$e700$$ENDHEX$$o do clube '" + String(al_Produto) + "' n$$HEX1$$e300$$ENDHEX$$o foi localizado.")
	End If
End If

Return lvb_Sucesso
end function

public function boolean of_grava_pagto_servico_clube (long al_nr_pgto, long al_prestador, decimal adc_pgto_total, long al_filial, string as_matricula_pgto);Boolean lvb_Sucesso = False

Long lvl_Row

String lvs_Tabela
String lvs_Colunas
String lvs_Values

uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota
	
lvo_Conexao.of_BancoProducao()

as_Matricula_Pgto = gf_Valida_Nulo(as_Matricula_Pgto, True, False)

lvs_Tabela 	= 'pagto_servico_clube'

lvs_Colunas = 'nr_pagamento, cd_prestador, dh_pagamento, vl_pago, cd_filial, nr_matricula_pagamento, dh_cancelamento, nr_matricula_cancelamento'

lvs_Values	=	String(al_nr_pgto)								+ ","  + &
				String(al_prestador)							+ ","  + &
				"'" + String(Today(),'yyyy/mm/dd hh:mm:ss')		+ "'," + &
				gf_Replace(String(adc_pgto_total),",",".",0)	+ ","  + &
				String(al_filial)								+ ","  + &
				as_Matricula_Pgto 								+ &
				"null, null"
				  
If lvo_Conexao.of_Insert_Registro(lvs_Tabela,lvs_Colunas,lvs_Values, Ref lvl_Row) Then
	lvb_Sucesso = True
End If

Destroy(lvo_Conexao)

Return True



end function

public function boolean of_grava_pagto_servico_clube_produto (long al_nr_pgto, long al_vale_resgate, long al_produto, decimal adc_pgto_resgate);Boolean lvb_Sucesso = False

Long lvl_Row

String lvs_Tabela
String lvs_Colunas
String lvs_Values

uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota
			
lvo_Conexao.of_BancoProducao()

lvs_Tabela 	= 'pagto_servico_clube_produto'

lvs_Colunas = 'nr_pagamento, nr_vale_resgate, cd_produto, vl_pago'

lvs_Values	= 	String(al_nr_pgto) 		+ "," + &
				String(al_vale_resgate) + "," + &
				String(al_produto) 		+ "," + &
				gf_Replace(String(adc_pgto_resgate),",",".",0)
				  
If lvo_Conexao.of_Insert_Registro(lvs_Tabela,lvs_Colunas,lvs_Values, Ref lvl_Row) Then
	lvb_Sucesso = True
End If

Destroy(lvo_Conexao)
	   
Return True
end function

public function boolean of_grava_pagto_servico_clube_produto (long al_nr_pgto, long al_vale_resgate[], long al_produto[], decimal adc_pgto_resgate[]);Boolean lvb_Sucesso = False

Integer lvi_Linhas,&
        lvi_Linha
		
Long lvl_Vale_Resgate,&
	 lvl_Produto
	 
Decimal lvdc_Pgto_Resgate
		
lvi_Linhas = UpperBound(al_vale_resgate[])

For lvi_Linha = 1 To lvi_Linhas
	lvl_Vale_Resgate  = al_Vale_Resgate [lvi_Linha]
	lvdc_Pgto_Resgate = adc_pgto_resgate[lvi_Linha]
	lvl_Produto       = al_Produto	    [lvi_Linha]
	
	lvb_Sucesso = of_Grava_Pagto_Servico_Clube_Produto(al_nr_Pgto,&
													   lvl_Vale_Resgate,&
													   lvl_Produto,&
													   lvdc_Pgto_Resgate)
	
	If Not lvb_Sucesso Then Exit
Next

Return lvb_Sucesso
end function

public function boolean of_localiza_vale_resgate (long al_vale_resgate, ref long al_produto, long al_filial_pgto);Boolean lvb_Sucesso = False

Long lvl_Filial_Resgate

Integer lvi_Cidade_Resgate,&
		lvi_Cidade_Pagto
		
String lvs_Cidade_Resgate,&
	   lvs_Cidade_Pagto 

uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao()

lvo_Conexao.of_Define_Variaveis(True)

lvo_Conexao.of_Executa_Rotina("0038",{String(al_Vale_Resgate)})

If lvo_Conexao.of_Erro_Execucao() Or lvo_Conexao.of_Erro_Conexao() Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do vale resgate '" + String(al_Vale_Resgate) + "'.")
Else
	If lvo_Conexao.of_Linhas() > 0 Then
		If lvo_Conexao.of_Retorno("cd_produto", Ref al_produto) Then
			lvb_Sucesso = True
			
//Alterado por Wagner
//Data: 26/04/2017
//Chamado: 244264
//Obs: O pagto do vale resgate pode ser efetuado em qualquer filial

//			If lvo_Conexao.of_Retorno("cd_filial", Ref lvl_Filial_Resgate) Then
//				// Resgate
//				If of_Localiza_Cidade(lvl_Filial_Resgate, Ref lvi_Cidade_Resgate, Ref lvs_Cidade_Resgate) Then
//					// Pagto
//					If of_Localiza_Cidade(al_Filial_Pgto, Ref lvi_Cidade_Pagto, Ref lvs_Cidade_Pagto) Then
//						If lvi_Cidade_Resgate = lvi_Cidade_Pagto Then
//							lvb_Sucesso = True			
//						Else
//							MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O pagamento s$$HEX1$$f300$$ENDHEX$$ pode ser efetuado na mesma cidade onde o resgate foi efetuado '" + lvs_Cidade_Resgate + " (" + String(lvi_Cidade_Resgate) + ")' .")
//						End If
//					End If
//				End If				
//			End If
		End If
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O vale resgate '" + String(al_Vale_Resgate) + "' n$$HEX1$$e300$$ENDHEX$$o foi utilizado.")
	End If
End If

Destroy(lvo_Conexao)

Return lvb_Sucesso
end function

public function boolean of_localiza_proximo_pgto (ref long al_nr_pagto);Boolean lvb_Sucesso = False

uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao()

lvo_Conexao.of_Define_Variaveis(True)

lvo_Conexao.of_Executa_Rotina("0006",{"Select Max(nr_pagamento) as 'nr_pagamentos' From pagto_servico_clube"})

If lvo_Conexao.of_Erro_Execucao() Or lvo_Conexao.of_Erro_Conexao() Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do pr$$HEX1$$f300$$ENDHEX$$ximo pagamento de resgate.")
Else
	If lvo_Conexao.of_Retorno("nr_pagamentos", Ref al_nr_Pagto) Then
		If IsNull(al_nr_Pagto) Or al_nr_Pagto = 0 Then
			al_nr_Pagto = 1
		Else
			al_nr_Pagto = al_nr_Pagto + 1
		End If
		
		lvb_Sucesso = True
	End If
End If

Destroy(lvo_Conexao)

Return lvb_Sucesso 



end function

on uo_prestador_servico_clube.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_prestador_servico_clube.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;This.of_Inicializa()
end event

