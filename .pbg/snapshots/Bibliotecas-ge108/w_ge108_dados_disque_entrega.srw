HA$PBExportHeader$w_ge108_dados_disque_entrega.srw
forward
global type w_ge108_dados_disque_entrega from dc_w_response_ok_cancela
end type
type dw_2 from dc_uo_dw_base within w_ge108_dados_disque_entrega
end type
type cb_1 from commandbutton within w_ge108_dados_disque_entrega
end type
type dw_3 from dc_uo_dw_base within w_ge108_dados_disque_entrega
end type
type cb_definir_entrega from commandbutton within w_ge108_dados_disque_entrega
end type
type gb_2 from groupbox within w_ge108_dados_disque_entrega
end type
end forward

global type w_ge108_dados_disque_entrega from dc_w_response_ok_cancela
integer width = 3483
integer height = 1588
string title = "GE108 - Informa$$HEX2$$e700f500$$ENDHEX$$es para entrega"
long backcolor = 80269524
event ue_atualiza_total_pedido ( )
dw_2 dw_2
cb_1 cb_1
dw_3 dw_3
cb_definir_entrega cb_definir_entrega
gb_2 gb_2
end type
global w_ge108_dados_disque_entrega w_ge108_dados_disque_entrega

type variables
Boolean ib_Roteiro_Pendente = True //Bot$$HEX1$$e300$$ENDHEX$$o Definir Entrega

String is_Cliente
String is_Vendedor
String is_carteira_digital

Long il_Seq_Cliente_Caixa
Long il_Roteiro

Integer ii_Roteiro_Parametro, ii_Count_Roteiro
Date idt_Agendamento

uo_Cidade io_Cidade
uo_Cliente io_Cliente

String is_Texto_Endereco = "Digite aqui o cep ou o endere$$HEX1$$e700$$ENDHEX$$o e pressione [Enter]"

uo_ge099_endereco io_Endereco

Decimal	idc_Vl_Pedido_Minimo_Isento_Frete
Decimal	idc_Total_Produto
Decimal  idc_Vl_Parcela_Minima


end variables

forward prototypes
public function string wf_retira_caracteres (string as_parametro)
public subroutine wf_localiza_endereco ()
public function boolean wf_pedido_minimo_isento_frete ()
public function boolean wf_valor_frete (string as_cep, ref decimal adc_vl_frete)
public function boolean wf_existe_roteiro_salvo ()
public function boolean wf_dados_ok (ref string as_mensagem)
public function boolean wf_calcula_parcela (decimal adc_pagamento, integer ai_nr_parcela)
public function boolean wf_grava_forma_pagamento (long al_roteiro)
public function boolean wf_inclui_roteiro_entrega (ref decimal adc_frete, boolean ab_mostra_msg)
public function boolean wf_valida_forma_pagamento ()
public function boolean wf_grava_roteiro_saida ()
end prototypes

event ue_atualiza_total_pedido();Decimal{2} ldc_Frete, ldc_Total_Pedido

Boolean lb_dif_avista

dw_1.AcceptText()
dw_3.AcceptText()

ldc_Frete	= dw_1.GetItemDecimal(dw_1.RowCount(), "vl_frete")
If IsNull(ldc_Frete) Then ldc_Frete = 0

//Total Pedido
ldc_Total_Pedido = idc_Total_Produto + ldc_Frete

dw_3.Object.vl_total_produto 	[ 1 ] = idc_Total_produto
dw_3.Object.vl_total_pedido 	[ 1 ] = idc_Total_produto + ldc_Frete
dw_3.Object.vl_frete			 	[ 1 ] = ldc_Frete

dw_3.AcceptText()


end event

public function string wf_retira_caracteres (string as_parametro);String lvs_Retorno

lvs_Retorno = gf_Replace(as_Parametro, ' ', '', 0)
lvs_Retorno = gf_Replace(lvs_Retorno, '.', '', 0)
lvs_Retorno = gf_Replace(lvs_Retorno, '-', '', 0)
lvs_Retorno = gf_Replace(lvs_Retorno, '(', '', 0)
lvs_Retorno = gf_Replace(lvs_Retorno, ')', '', 0)

Return lvs_Retorno
end function

public subroutine wf_localiza_endereco ();String lvs_Cep

Long ll_Cidade_Informada

Decimal	ldc_Vl_Frete

dw_1.AcceptText()

lvs_Cep = trim(dw_1.Object.Localizacao_Endereco[1])
ll_Cidade_Informada = dw_1.Object.Cd_Cidade[1]

If IsNull( ll_Cidade_Informada ) Or ll_Cidade_Informada = 0 Then ll_Cidade_Informada = gvo_Parametro.Cd_Cidade

io_Endereco.ivl_Cidade_Informada = ll_Cidade_Informada

//Se o usu$$HEX1$$e100$$ENDHEX$$rio informou hifen na pesquisa o sistema retira pra fazer a consulta
lvs_Cep = gf_ge099_Remove_Hifen_Cep(lvs_Cep)
io_Endereco.of_Localiza_endereco(lvs_Cep)

//ivb_Localizou_Endereco = True

If io_Endereco.Localizado Then
	io_Cidade.of_Localiza_Cidade(String(io_Endereco.Cd_Cidade))
	
	dw_1.Object.nr_cep[1] = io_Endereco.nr_cep
	
	If wf_Valor_Frete(io_Endereco.nr_cep, Ref ldc_Vl_Frete) Then
		dw_1.Object.vl_frete	[1] = ldc_Vl_Frete
	Else
		dw_1.Object.vl_frete	[1] = 0.00
	End If
	
	Event ue_atualiza_total_pedido()
	
	//If io_Endereco.ivb_Libera_Digitacao Then
	If IsNull(io_Endereco.de_endereco) Then
		dw_1.SetTabOrder('nm_cidade', 20)
		dw_1.SetTabOrder('cd_unidade_federacao', 0)
		dw_1.SetTabOrder('de_endereco', 40)
		dw_1.SetTabOrder('nr_cep', 0)
		dw_1.SetTabOrder('nr_telefone', 50)
		dw_1.SetTabOrder('de_bairro', 60)
		dw_1.SetTabOrder('nr_endereco',70)
		dw_1.SetTabOrder('de_complemento', 80)
		
		dw_1.Modify('nm_cidade.background.color="16777215"')
		dw_1.Modify('de_endereco.background.color="16777215"')
		dw_1.Modify('de_bairro.background.color="16777215"')
		
		dw_1.Event ue_pos(1, 'nm_cidade')		
	Else
		dw_1.SetTabOrder('nm_cidade', 0)
		dw_1.SetTabOrder('cd_unidade_federacao', 0)
		dw_1.SetTabOrder('de_endereco', 0)
		dw_1.SetTabOrder('nr_cep', 0)
		dw_1.SetTabOrder('nr_telefone', 20)
		dw_1.SetTabOrder('de_bairro', 0)
		dw_1.SetTabOrder('nr_endereco', 30)
		dw_1.SetTabOrder('de_complemento', 40)
		
		dw_1.Modify('nm_cidade.background.color="67108864"')
		dw_1.Modify('de_endereco.background.color="67108864"')
		dw_1.Modify('de_bairro.background.color="67108864"')
		
		dw_1.Object.nm_cidade					[1] = io_Endereco.Nm_cidade
		dw_1.Object.cd_cidade					[1] = io_Endereco.cd_cidade
		dw_1.Object.de_endereco				[1] = io_Endereco.de_endereco
		dw_1.Object.cd_unidade_federacao	[1] = io_Endereco.cd_unidade_federacao
		dw_1.Object.de_bairro					[1] = MidA(io_Endereco.de_bairro, 1, 20)
		
		dw_1.Event ue_pos(1, 'de_complemento')
	End If
	
	// Se o campo bairro for maior que 20 pega bairro abreviado <> ''.		
	If LenA(io_Endereco.de_bairro) > 20 Then		
		If io_Endereco.de_bairro_abreviado <> "" and Not IsNull(io_Endereco.de_bairro_abreviado) Then
			dw_1.Object.de_bairro[1] = MidA(io_Endereco.de_bairro_abreviado, 1, 20)
		End If
	End If	
	
	// Se campo endereco for > 40 pega endereco abreviado que tem 36 caracteres.
	If LenA(io_Endereco.de_endereco) > 40 Then
		dw_1.Object.de_endereco[1] = io_Endereco.de_endereco_abreviado
	End If
	
Else
	dw_1.Event ue_pos(1, 'localizacao_endereco')
End If

dw_1.Object.Localizacao_Endereco[1] = is_Texto_Endereco
end subroutine

public function boolean wf_pedido_minimo_isento_frete ();String ls_Parametro

select coalesce(vl_parametro, '0.00')
into :ls_Parametro
from parametro_loja
where cd_parametro = 'VL_PEDIDO_MINIMO_ISENTO_FRETE'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		idc_Vl_Pedido_Minimo_Isento_Frete = Dec(ls_Parametro)
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizado o valor m$$HEX1$$ed00$$ENDHEX$$nimo para frete gratis.")
		Return False
	Case -1
		MessageBox("Erro", "Erro ao localizar o valor m$$HEX1$$ed00$$ENDHEX$$nimo para frete gratis: "+ SqlCa.SqlErrText)
		Return False
End Choose

Return True
end function

public function boolean wf_valor_frete (string as_cep, ref decimal adc_vl_frete);Decimal	ldc_Vl_Frete,&
			ldc_Vl_Parametro
			
uo_ge108_produto	 lo_produto

Long	ll_Produto_Frete
			
adc_vl_frete = 0.00		

dw_1.Object.st_frete_padrao.Visible = 0 
dw_1.Object.st_frete_padrao_2.Visible = 0 

//Se o total do pedido for maior ou igual ao valor definido no par$$HEX1$$e200$$ENDHEX$$metro, o frete $$HEX1$$e900$$ENDHEX$$ gr$$HEX1$$e100$$ENDHEX$$tis
If idc_Total_Produto >= idc_Vl_Pedido_Minimo_Isento_Frete Then
	adc_vl_frete = 0.00
	Return True
End If


//Localiza o valor do frete definido no bairro
select coalesce(max(b.vl_frete), 0)
into :ldc_Vl_Frete
from ect_logradouro a
inner join ect_bairro b on b.nr_bairro = a.nr_bairro
where a.nr_cep = :as_CEP
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If ldc_Vl_Frete > 0 Then
			adc_vl_frete = ldc_Vl_Frete
			Return True
		Else
			//Localiza preco frete pela localidade. Sombrio nao possui ruas logradouros, apenas um bairro, um cep padrao
			select coalesce(max(b.vl_frete), 0) 
				into :ldc_Vl_Frete
				from ect_localidade a
				inner join ect_bairro b 
						on b.nr_localidade = a.nr_localidade 
			where a.nr_cep = :as_CEP
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				SqlCa.of_MsgDbError("Erro ao localizar o valor do frete na ect_localidade. "+ SqlCa.SqlErrText)
				Return False
			End If
			
			If ldc_Vl_Frete > 0 Then
				adc_vl_frete = ldc_Vl_Frete
				Return True
			End If			
		End If
	Case -1
		SqlCa.of_MsgDbError("Erro ao localizar o valor do frete. "+ SqlCa.SqlErrText)
		Return False
End Choose

//Localiza o valor do frete no produto FRETE
Try
	lo_produto = Create uo_ge108_produto
	
	ll_Produto_Frete = lo_produto.cd_produto_frete
	
	If Not lo_produto.of_localiza_codigo_interno( ll_Produto_Frete) Then
		MessageBox("Erro", "Erro ao localizar o produto 'FRETE'")
		Return False
	End If
	adc_vl_frete	= lo_produto.of_preco_venda_filial( )
	
	dw_1.Object.st_frete_padrao.Visible = 1 
	dw_1.Object.st_frete_padrao_2.Visible = 1 
	dw_1.Object.st_frete_padrao.Text = "Valor do frete n$$HEX1$$e300$$ENDHEX$$o localizado, verifique se o CEP est$$HEX1$$e100$$ENDHEX$$ correto."
	dw_1.Object.st_frete_padrao_2.Text = "R$"+ String(adc_vl_frete)+ " $$HEX1$$e900$$ENDHEX$$ o valor padr$$HEX1$$e300$$ENDHEX$$o. Caso necess$$HEX1$$e100$$ENDHEX$$rio altere o valor na venda."
	
Finally
	If IsValid(lo_produto) Then
		Destroy(lo_produto)
	End If
End Try

Return True
end function

public function boolean wf_existe_roteiro_salvo ();Long 	ll_nr_roteiro, ll_Cidade 

Integer li_Retrieve, li_Nr_Parcelas, li_Row, li_Linha_nova

String ls_Vendedor, ls_Cep, ls_Endereco
String ls_Nr, ls_Bairro, ls_complemento
String ls_Fone_Entrega, ls_Forma_Pagamento
String ls_Tipo_Receita, ls_PBM, ls_Descricao_Pbm, ls_Autorizacao 
	
Decimal ldc_Troco, ldc_frete

Select nr_roteiro,	
		 nr_matricula_operador, 
		 nr_cep,  
		 de_endereco,
		 nr_endereco,
		 de_bairro, 
		 de_complemento, 
		 cd_cidade, 
		 nr_telefone,
		 vl_troco, 
		 id_tipo_receita, 
		 de_pbm,
		 nr_autorizacao
Into 	:il_Roteiro, 
		:ls_Vendedor, 
		:ls_Cep, 
		:ls_Endereco, 
		:ls_Nr,
		:ls_Bairro,
		:ls_complemento,
		:ll_Cidade,
		:ls_Fone_Entrega,
		:ldc_Troco,
		:ls_Tipo_Receita,
		:ls_Descricao_PBM,
		:ls_Autorizacao
From roteiro_entrega 
 where nr_sequencial_cliente_caixa = :il_Seq_Cliente_Caixa
 	Order by nr_roteiro desc
	Limit 1
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case -1
		SqlCa.of_Rollback( )
		SqlCa.of_Msgdberror("Erro ao localizar o roteiro salvo.")
		Return False
	Case 100
		SetNull(il_Roteiro)
		Return False
	Case 0
		If Not IsNull( ll_nr_roteiro ) Then
			io_Cliente.of_Localiza_codigo( is_Cliente )
			If io_Cliente.Localizado Then
				dw_1.Object.nm_cliente					[1]	 = io_Cliente.nm_cliente
				dw_1.Object.cd_cliente					[1]	 = io_Cliente.cd_cliente
				dw_1.Object.nr_cpf_cgc					[1] = io_Cliente.nr_cpf_cgc
			End If
			
			//Perfis SAC=5 e SAF=9
			//Recuperam os dados do roteiro
			//Demais perfis pegam os dados do cliente
			If gvo_aplicacao.ivo_seguranca.cd_perfil_usuario <> 5 And gvo_aplicacao.ivo_seguranca.cd_perfil_usuario <> 9 Then
				ll_Cidade				= io_Cliente.cd_cidade
				ls_Bairro				= io_Cliente.de_bairro
				ls_Endereco			= io_Cliente.de_endereco
				ls_Nr					= io_Cliente.nr_endereco
				ls_complemento	= io_Cliente.de_complemento
				ls_Cep				= io_Cliente.nr_cep
				ls_Endereco			= io_Cliente.de_endereco
			End If	
								
			dw_1.Object.de_endereco					[1] = ls_Endereco
			dw_1.Object.nr_endereco					[1] = ls_Nr
			dw_1.Object.de_bairro						[1] = ls_Bairro
			dw_1.Object.de_complemento_roteiro	[1] = ls_complemento
			dw_1.Object.nr_cep							[1] = ls_Cep
			dw_1.Object.nr_telefone						[1] = ls_Fone_Entrega
			dw_1.Object.vl_frete							[1] = ldc_frete
			dw_1.Object.vl_troco							[1] = ldc_Troco
			dw_1.Object.de_pbm							[1] = ls_Descricao_PBM
			dw_1.Object.nr_autorizacao					[1] = ls_Autorizacao
			dw_1.Object.id_tipo_receita					[1]	 = ls_Tipo_Receita
			
			io_Cidade.of_Localiza_codigo( ll_Cidade )
			If io_Cidade.Localizada Then
				dw_1.Object.nm_cidade					[1]	 = io_Cidade.nm_cidade
				dw_1.Object.cd_cidade					[1]	 = io_Cidade.cd_cidade
				dw_1.Object.cd_unidade_federacao	[1] = io_Cidade.cd_unidade_federacao
			End If	
						
			If Not IsNull(ls_Descricao_PBM) And Trim(ls_Descricao_PBM) <> '' Then
				dw_1.Object.id_pbm						[1] = 'S'
				dw_3.Visible = False
			Else
				dw_1.Object.id_pbm						[1] = 'N'
				dw_3.Visible = True
			End If
						
			//busca forma de pagamento
			dc_uo_ds_base lds_Pagamento
			lds_Pagamento = Create dc_uo_ds_base
				
			If Not lds_Pagamento.of_Changedataobject( "dw_ge108_multiplas_formas_pagamento" ) Then
				If IsValid(lds_Pagamento) Then Destroy lds_Pagamento
				Return False
			End If
			
			li_Retrieve = lds_Pagamento.Retrieve( il_Roteiro )
			
			If li_Retrieve < 0 Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no Retrieve formas de pagamento. Fun$$HEX2$$e700e300$$ENDHEX$$o: wf_existe_roteiro_salvo().")
				If IsValid(lds_Pagamento) Then Destroy lds_Pagamento
				Return False
			End If
			
			If li_Retrieve > 0 Then
				dw_2.reset()
				For li_Row = 1 To li_Retrieve
					li_Linha_nova = dw_2.InsertRow(0)
					dw_2.Object.cd_forma_pagamento	[li_Linha_nova] = lds_Pagamento.Object.cd_forma_pagamento	[li_Row]
					dw_2.Object.vl_pagamento				[li_Linha_nova] = lds_Pagamento.Object.vl_pagamento				[li_Row]
					dw_2.Object.nr_parcelas_cartao		[li_Linha_nova] = lds_Pagamento.Object.nr_parcelas_cartao		[li_Row]
				Next
				
				dw_2.AcceptText()
			End If
			
			If IsValid(lds_Pagamento) Then Destroy lds_Pagamento
			
		End If						
End Choose

Return True

end function

public function boolean wf_dados_ok (ref string as_mensagem);String ls_Nulo

Decimal 	ldc_Vl_Frete

SetNull( ls_Nulo )
SetNull( as_mensagem )

dw_1.AcceptText()

ldc_Vl_Frete		= dw_1.Object.vl_frete					[1]

If Not gf_Valida_Informacoes_cliente(dw_1.Object.nm_cliente[1], 1, Ref as_mensagem) Then	
	dw_1.SetColumn("nm_cliente")
	dw_1.SetFocus()
	Return False
End If

If Not gf_Valida_Informacoes_Cliente(dw_1.Object.nr_cpf_cgc[1], 4, Ref as_mensagem) Then
	dw_1.SetColumn("nr_cpf_cgc")
	dw_1.SetFocus()
	Return False
End If

If IsNull(dw_1.Object.cd_cidade[1]) Then
	as_mensagem = "A cidade deve estar preenchida."
	dw_1.SetColumn("nm_cidade")
	dw_1.SetFocus()
	Return False
End If

If Not gf_Valida_Informacoes_Cliente(dw_1.Object.de_endereco[1], 2, Ref as_mensagem ) Then
	dw_1.SetColumn("de_endereco")
	dw_1.SetFocus()
	Return False
End If

If IsNull(dw_1.Object.nr_telefone[1]) Or Trim(dw_1.Object.de_endereco[1]) = '' Then
	as_mensagem = "Informe um telefone para contato."
	dw_1.SetColumn("nr_telefone")
	dw_1.SetFocus()
	Return False
End If

If Not gf_Valida_Informacoes_Cliente(dw_1.Object.de_bairro[1], 3, Ref as_Mensagem) Then
	dw_1.SetColumn("de_bairro")
	dw_1.SetFocus()
	Return False
End If

If Not gf_Valida_Informacoes_Cliente(dw_1.Object.nr_cep[1], 6, Ref as_Mensagem) Then
	dw_1.SetColumn("nr_cep")
	dw_1.SetFocus()
	Return False
End If

If IsNull(ldc_Vl_Frete) Then
	as_mensagem = "O valor do frete n$$HEX1$$e300$$ENDHEX$$o pode ser nulo."
	dw_1.SetColumn("localizacao_endereco")
	dw_1.SetFocus()
	Return False
End If

Return True

end function

public function boolean wf_calcula_parcela (decimal adc_pagamento, integer ai_nr_parcela);Decimal ldc_Vl_Parcela

dw_2.Object.st_Valor_Parcela.Text = ""

If IsNull(adc_pagamento) 	Then adc_pagamento 	= 0
If IsNull(ai_nr_parcela) 		Then ai_nr_parcela 		= 1

ldc_Vl_Parcela =  Round(( adc_pagamento ) / ai_nr_parcela, 2 )

If ai_nr_parcela > 1 Then			
	If ldc_Vl_Parcela < idc_Vl_Parcela_Minima Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Valor m$$HEX1$$ed00$$ENDHEX$$nimo da parcela n$$HEX1$$e300$$ENDHEX$$o atingido. ( R$ " +String( idc_Vl_Parcela_Minima, '#,##0.00' ) + ' )' )
		dw_2.Object.nr_parcelas_cartao[ 1 ] = 1
		//dw_2.Object.st_Valor_Parcela.Text = String(1) + "x de R$ " + String(adc_pagamento,  '#,##0.00' ) + ' sem juros'
		Return False
	End If
End If

//dw_2.Object.st_Valor_Parcela.Text = String(ai_nr_parcela) + "x de R$ " + String( ldc_Vl_Parcela,  '#,##0.00' ) + ' sem juros'

Return True
end function

public function boolean wf_grava_forma_pagamento (long al_roteiro);Integer li_Row, li_Linhas, li_Nr_Parcelas

Decimal ldc_valor, ldc_Total_Multiplos_Pagamento

String ls_Forma_Pagamento

//O Commit est$$HEX1$$e100$$ENDHEX$$ no final da fun$$HEX2$$e700e300$$ENDHEX$$o wf_inclui_roteiro_entrega


//Deleta a forma de pagamento caso exista
Delete from roteiro_entrega_pagamento
 where nr_roteiro = :al_Roteiro
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_Rollback( )
	SqlCa.of_MSgdberror( "Erro ao deletar as formas de paamento" )
	Return False
End If

dw_2.AcceptText()

li_Linhas = dw_2.RowCount()

For li_Row = 1 To li_Linhas
	ls_Forma_Pagamento 	= dw_2.Object.cd_forma_pagamento	[ li_Row ]
	ldc_valor 					= dw_2.Object.vl_pagamento			[ li_Row ]	
	li_Nr_Parcelas				= dw_2.Object.nr_parcelas_cartao	[ li_Row ]
	
	If ls_Forma_Pagamento <> 'CP' Then
		SetNull( li_Nr_Parcelas )
	End If
	
	Insert into roteiro_entrega_pagamento(nr_roteiro, nr_sequencial, vl_pagamento, cd_forma_pagamento, nr_parcelas_cartao)
		Values(:al_Roteiro, :li_Row, :ldc_Valor, :ls_Forma_Pagamento, :li_Nr_Parcelas )
		Using SqlCa;
	
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_Rollback()
			SqlCa.of_MsgDbError("Erro no insert da forma de pagamento.")
			Return False
		End If
Next

Return True
end function

public function boolean wf_inclui_roteiro_entrega (ref decimal adc_frete, boolean ab_mostra_msg);Long ll_Cidade

String	ls_Cep,&
		ls_Endereco,&
		ls_Nr,&
		ls_Bairro,&
		ls_complemento,&
		ls_Fone_Entrega

String ls_PBM
String ls_tipo_Receita
String ls_Autorizacao
String ls_descricao_Pbm
String ls_Mensagem
String ls_Forma_Pagto_Aux

Decimal ldc_frete
Decimal ldc_Troco

dw_1.AcceptText()

If ab_mostra_msg Then
	If Not wf_Dados_OK(Ref ls_Mensagem ) Then
		If Not IsNull( ls_Mensagem ) And ls_Mensagem <> "" Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Mensagem,Exclamation!)
		End If
		Return False
	End If
End If

ll_Cidade					= dw_1.Object.cd_cidade					[1]
ls_Endereco 			= dw_1.Object.de_endereco				[1]
ls_Nr 						= dw_1.Object.nr_endereco					[1]
ls_Bairro 				= dw_1.Object.de_bairro					[1]
ls_complemento		= Trim(LeftA(dw_1.Object.de_complemento_roteiro	[1],200))
ls_Cep					= dw_1.Object.nr_cep						[1]
ls_Fone_Entrega		= dw_1.Object.nr_telefone					[1]
ldc_Troco				= dw_1.Object.vl_troco						[1]
ldc_frete					= dw_1.Object.vl_frete						[1]
ls_PBM					= dw_1.Object.id_pbm						[1]
ls_tipo_Receita			= dw_1.Object.id_tipo_receita				[1]
ls_Descricao_pbm		= dw_1.Object.de_pbm						[1]
ls_Autorizacao			= dw_1.Object.nr_autorizacao				[1]

If ab_mostra_msg Then
	If Not wf_valida_forma_pagamento() Then
		Return False
	End If
End If

//Grava a primeira linha na forma de pagamento antiga.
//Para corrigir os roteiros sem as multiplas formas de pagamento.
If ab_mostra_msg Then
	If dw_2.RowCount() > 0 Then
		ls_Forma_Pagto_Aux = dw_2.Object.cd_forma_pagamento[1]
	End If
End If

If ldc_Troco = 0 Then
	SetNull(ldc_Troco)
End If

If ls_PBM = 'N' Then
	SetNull(ls_Descricao_pbm)
	SetNull(ls_Autorizacao)
End If

If Not IsNull( il_Roteiro ) Then	
	Update roteiro_entrega 
		Set nr_cep 						= :ls_Cep,
			 de_endereco				= :ls_Endereco,
			 nr_endereco				= :ls_Nr, 
			 de_bairro					= :ls_Bairro, 
			 de_complemento			= :ls_complemento, 
			 cd_cidade					= :ll_Cidade, 
			 nr_telefone					= :ls_Fone_Entrega,
			 vl_troco						= :ldc_Troco, 
			 id_tipo_receita				= :ls_Tipo_Receita,
			 de_pbm						= :ls_Descricao_PBM,
			 nr_autorizacao				= :ls_Autorizacao,
			 cd_forma_pagamento	= :ls_Forma_Pagto_Aux
		Where nr_roteiro							= :il_Roteiro
			and nr_sequencial_cliente_caixa	= :il_Seq_Cliente_Caixa
	Using SqlCa;

Else
	select COALESCE( MAX(nr_roteiro), 0) + 1
		into :il_Roteiro
	from roteiro_entrega
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.Of_MsgDbError("Erro ao localizar o pr$$HEX1$$f300$$ENDHEX$$ximo sequencial do roteiro de entrega.")
		Return False	
	End If

	Insert Into roteiro_entrega( nr_roteiro, cd_entregador, nr_matricula_operador, dh_inclusao, id_situacao, nr_sequencial_cliente_caixa, nr_cep,  de_endereco,nr_endereco,de_bairro, de_complemento, cd_cidade, nr_telefone, vl_troco, id_tipo_receita, de_pbm, nr_autorizacao, cd_forma_pagamento  )
		Values( :il_Roteiro, '1', :is_Vendedor, getdate(), 'X', :il_Seq_Cliente_Caixa, :ls_Cep, :ls_Endereco, :ls_Nr, :ls_Bairro, :ls_complemento, :ll_Cidade, :ls_Fone_Entrega, :ldc_Troco, :ls_Tipo_Receita, :ls_Descricao_PBM, :ls_Autorizacao, :ls_Forma_Pagto_Aux )
	Using SqlCa;	
	
End If

If SqlCa.SqlCode = -1 Then
	SqlCa.of_Rollback();
	SqlCa.of_MsgDbError("Erro ao incluir o pedido disque entrega. Fun$$HEX2$$e700e300$$ENDHEX$$o: wf_inclui_roteiro_entrega()")
	Return False
Else
	
	If wf_grava_forma_pagamento( il_Roteiro ) Then
		//Se for gravado pelo bot$$HEX1$$e300$$ENDHEX$$o cancelar n$$HEX1$$e300$$ENDHEX$$o informa o roteiro_saida
		If ab_mostra_msg Then
			If Not wf_Grava_Roteiro_Saida( ) Then
				Return False
			End If 
		End If
		
		SqlCa.of_Commit();
	End If
	
End If

adc_frete = ldc_frete

Return True

end function

public function boolean wf_valida_forma_pagamento ();Integer li_Row, li_Linhas, li_Nr_Parcelas

Decimal{2} ldc_valor, ldc_Total_Multiplos_Pagamento, ldc_frete, ldc_Troco_para, ldc_total_dinheiro

String ls_Forma_Pagamento, ls_PBM

dw_1.AcceptText()
dw_2.AcceptText()
dw_3.AcceptText()

li_Linhas = dw_2.RowCount()

If li_Linhas = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Selecione uma forma de pagamento")
	Return False
End If

ldc_Troco_para 	= dw_1.Object.vl_Troco	[1]
ls_PBM				= dw_1.Object.id_pbm	[1]

ldc_Total_Multiplos_Pagamento 	= dw_2.GetItemDecimal(dw_2.RowCount(), 'cp_total_multiplos_pagto' )		
ldc_total_dinheiro					 	= dw_2.GetItemDecimal(dw_2.RowCount(), 'cp_total_dinheiro' )		
ldc_frete									= dw_1.GetItemDecimal(dw_1.RowCount(), 'vl_frete' )	

If IsNull( ldc_Total_Multiplos_Pagamento ) Then ldc_Total_Multiplos_Pagamento = 0
If IsNull( ldc_total_dinheiro ) Then ldc_total_dinheiro = 0
If IsNull( ldc_frete ) Then ldc_frete = 0

If ls_PBM <> 'S' Then
	If ldc_Total_Multiplos_Pagamento < ( idc_Total_Produto + ldc_Frete ) Then
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Total de pagamento(s) inferior ao valor total do pedido.", Exclamation!)
		Return False
	End If
	
	If ldc_Total_Multiplos_Pagamento > ( idc_Total_Produto + ldc_frete ) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Total de pagamento(s) superior ao valor total do pedido.", Exclamation!)
		Return False
	End If

End If

If ldc_Troco_para > 0 And ldc_total_dinheiro = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Foi informado 'Enviar Troco Para' mas n$$HEX1$$e300$$ENDHEX$$o foi informada a forma de pagamento DINHEIRO.", Exclamation! )
	dw_1.Event ue_Pos(1, 'vl_troco')
	Return False
End If

For li_Row = 1 To li_Linhas
	ldc_valor 					= dw_2.Object.vl_pagamento			[ li_Row ]
	ls_Forma_Pagamento 	= dw_2.Object.cd_forma_pagamento	[ li_Row ]
	li_Nr_Parcelas				= dw_2.Object.nr_parcelas_cartao	[ li_Row ]
	
	If IsNull(ldc_valor) Then ldc_valor = 0
	
	If ldc_Valor <= 0 Then
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Valor do pagamento $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido.", Exclamation!)
		dw_2.Event ue_Pos(li_Row, "vl_pagamento")
		Return False
	End If
	
	If ls_Forma_Pagamento = 'XX' Then 
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Selecione a forma de pagamento.", Exclamation!)
		dw_2.Event ue_Pos(li_Row, "cd_forma_pagamento")
		Return False
	End If
	
	If ls_Forma_Pagamento = 'CP' Then
		If IsNull(li_Nr_Parcelas) Or li_Nr_Parcelas = 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Selecione a quantidade de parcela.",Exclamation!)
			dw_2.Event ue_Pos(li_Row,"nr_parcelas_cartao")
			Return False
		End If
		
		If li_Nr_Parcelas > 1 Then
			If Round((ldc_valor + ldc_frete) / li_Nr_Parcelas, 2) < idc_Vl_Parcela_Minima Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Valor m$$HEX1$$ed00$$ENDHEX$$nimo da parcela n$$HEX1$$e300$$ENDHEX$$o atingido. ( R$ " +String( idc_Vl_Parcela_Minima, '#,##0.00' ) + ' )' , Exclamation!)
				dw_2.Event ue_Pos(li_Row,"nr_parcelas_cartao")
				Return False
			End If
		End If
	End If 
	
Next

Return True
end function

public function boolean wf_grava_roteiro_saida ();Date ldt_Parametro

Integer li_Count

ldt_Parametro = Date(gvo_Parametro.dh_movimentacao )

//muda a data do parametro para a data do agendamento, caso houver
If Not IsNull(idt_Agendamento) And idt_Agendamento <> Date('1900/01/01') Then
	ldt_Parametro = idt_Agendamento
End If

//O Commit est$$HEX1$$e100$$ENDHEX$$ no final da fun$$HEX2$$e700e300$$ENDHEX$$o wf_inclui_roteiro_entrega

Select count(nr_roteiro)
	into :li_Count
from roteiro_saida
where dh_saida 		= :ldt_Parametro
    and id_parametro 	= :ii_Roteiro_Parametro
    and nr_roteiro		= :il_Roteiro
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_msgdberror( "Erro no select do reteiro." )
	Return False
End If

If IsNull(li_Count) Or li_Count = 0 Then
	Insert into roteiro_saida( dh_saida, id_parametro, nr_roteiro, dh_inclusao, nr_matricula_inclusao )
		  Values( :ldt_Parametro, :ii_Roteiro_Parametro, :il_Roteiro, getdate(), :is_Vendedor )
	Using SqlCa;

	If SqlCa.SqlCode = -1 Then
		SqlCa.of_Rollback()
		SqlCa.of_MsgDbError("Erro no insert do roteiro sa$$HEX1$$ed00$$ENDHEX$$da.")
		Return False
	End If
End If

Return True
end function

on w_ge108_dados_disque_entrega.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.cb_1=create cb_1
this.dw_3=create dw_3
this.cb_definir_entrega=create cb_definir_entrega
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.dw_3
this.Control[iCurrent+4]=this.cb_definir_entrega
this.Control[iCurrent+5]=this.gb_2
end on

on w_ge108_dados_disque_entrega.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.cb_1)
destroy(this.dw_3)
destroy(this.cb_definir_entrega)
destroy(this.gb_2)
end on

event open;call super::open;STRING	ls_string, ls_aux

Integer li_cont = 0, li_len, li_Pos

srt_parametros_disque_entrega lsrt_Par_Disq_Entr

lsrt_Par_Disq_Entr = Message.PowerObjectParm


is_Cliente				= lsrt_Par_Disq_Entr.cd_cliente	
il_Seq_Cliente_Caixa	= lsrt_Par_Disq_Entr.sequencial_cliente_caixa
is_Vendedor				= lsrt_Par_Disq_Entr.nr_matricula_vendedor
idc_Total_Produto		= lsrt_Par_Disq_Entr.vl_total_pedido
end event

event ue_postopen;call super::ue_postopen;io_cidade = Create uo_cidade
io_Cliente = Create uo_Cliente

io_Endereco = Create uo_ge099_endereco

LONG	ll_max

String ls_Cpf_Cgc

Decimal	ldc_Vl_Frete

dw_3.Event ue_addRow()

//Verifica pedido salvo
If Not wf_Existe_Roteiro_Salvo() Then
	ll_max = dw_1.Retrieve( is_Cliente )

	If ll_max <= 0 Then dw_1.Event ue_Addrow()
	
	If ll_max	<= 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizado o cliente com o c$$HEX1$$f300$$ENDHEX$$digo "+is_Cliente+".")
		Close(This)	
		Return
	End If
	
	//Adiciona uma 1 linha das multiplas formas de pagamento
	//dw_2.Event ue_AddRow()
	
End If

If Not wf_Pedido_Minimo_Isento_Frete() Then
	SetNull(ldc_Vl_Frete)
	CloseWithReturn(This, ldc_Vl_Frete)
End If

If Not wf_Valor_Frete(dw_1.Object.nr_cep[1], Ref ldc_Vl_Frete) Then
	SetNull(ldc_Vl_Frete)
	CloseWithReturn(This, ldc_Vl_Frete)
End If

ls_Cpf_Cgc = dw_1.Object.nr_cpf_cgc[ 1 ]

If LenA( ls_Cpf_Cgc ) > 11 Then
	dw_1.Object.nr_cpf_cgc.EditMask.mask = '##.###.###/####-##'
Else
	dw_1.Object.nr_cpf_cgc.EditMask.mask = '###.###.###-##'
End If

dw_1.Object.localizacao_endereco		[1] = is_Texto_Endereco
dw_1.Object.vl_frete							[1] = ldc_Vl_Frete
dw_1.Object.vl_parametro_frete_gratis	[1] = idc_Vl_Pedido_Minimo_Isento_Frete

If Not IsNull(dw_1.Object.de_complemento[1]) Then
	dw_1.Object.de_complemento_roteiro[1] = Trim(dw_1.Object.de_complemento[1])
End If

uo_parametro_filial lo_Parametro
lo_Parametro = Create uo_parametro_filial
lo_Parametro.of_localiza_parametro( 'VL_PARCELA_MINIMA_TEF', Ref idc_Vl_Parcela_Minima)
lo_Parametro.of_Localiza_Parametro("ID_CARTEIRA_DIGITAL", ref is_carteira_digital, False)
If IsValid( lo_Parametro ) Then Destroy lo_Parametro

If Trim(Upper(is_carteira_digital)) = 'S' Then
	dw_2.Modify("cd_forma_pagamento.Values=' 	XX/DINHEIRO	DI/CART$$HEX1$$c300$$ENDHEX$$O D$$HEX1$$c900$$ENDHEX$$BITO	CA/CART$$HEX1$$c300$$ENDHEX$$O CR$$HEX1$$c900$$ENDHEX$$DITO	CP/CARTEIRA DIGITAL	CD/'")
Else
	dw_2.Modify("cd_forma_pagamento.Values=' 	XX/DINHEIRO	DI/CART$$HEX1$$c300$$ENDHEX$$O D$$HEX1$$c900$$ENDHEX$$BITO	CA/CART$$HEX1$$c300$$ENDHEX$$O CR$$HEX1$$c900$$ENDHEX$$DITO	CP/'")
End If

//dw_2.AcceptText()

dw_1.SetColumn("de_complemento_roteiro")

This.Event ue_atualiza_total_pedido()

dw_1.SetFocus()

//Inicializa
Select Count(id_parametro) 
	into :ii_Count_Roteiro
From roteiro_parametro
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Erro ao localizar os par$$HEX1$$e200$$ENDHEX$$metros do roteiro entrega.")
End If

//Se n$$HEX1$$e300$$ENDHEX$$o tem parametros defidos n$$HEX1$$e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ obrigat$$HEX1$$f300$$ENDHEX$$rio informar o roteiro
ib_Roteiro_Pendente = (ii_Count_Roteiro > 0)

cb_definir_entrega.Visible = ib_Roteiro_Pendente


end event

event close;call super::close;If IsValid( io_Cidade ) Then Destroy io_Cidade
If IsValid( io_Cliente ) Then Destroy io_Cliente

If IsValid( io_Endereco ) Then Destroy io_Endereco
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge108_dados_disque_entrega
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge108_dados_disque_entrega
integer x = 14
integer y = 0
integer width = 3433
integer height = 1456
integer taborder = 0
long backcolor = 553648127
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge108_dados_disque_entrega
integer x = 41
integer y = 64
integer width = 3383
integer height = 940
integer taborder = 10
string dataobject = "dw_ge108_dados_disque_entrega"
end type

event dw_1::itemchanged;call super::itemchanged;Integer  li_Parcelas, ll_Null
Decimal ldc_Vl_Parcela, ldc_Frete
String ls_Null
SetNull(ll_Null)
SetNull(ls_Null) 

Choose Case Lower(dwo.Name) 
	Case "id_forma_pagamento"
		This.Object.nr_parcelas_cartao[ Row ] = ll_Null
		
		If Data = 'CP' Then
			This.Object.nr_parcelas_cartao[Row] = 1
			This.Event ue_Pos(1, 'nr_parcelas_cartao')
			This.Event itemchanged( row, This.Object.nr_parcelas_cartao, '1' )
			This.acceptText()
		End If
		
		If Data <> 'DI' Then
			This.Object.vl_troco[Row] = 0.00	
			This.acceptText()
		End If
		
	Case "nr_parcelas_cartao"
		This.Object.st_Valor_Parcela.Text = ""
		
		If Not IsNull(Data) and Trim(Data) <> "" Then
			li_Parcelas 	= Integer(Data)
			ldc_Frete		= This.object.vl_frete[row]
			
			ldc_Vl_Parcela =  Round((idc_Total_Produto + ldc_Frete) / li_Parcelas, 2)
			
			If li_Parcelas > 1 Then			
				If ldc_Vl_Parcela < idc_Vl_Parcela_Minima Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Valor m$$HEX1$$ed00$$ENDHEX$$nimo da parcela n$$HEX1$$e300$$ENDHEX$$o atingido. ( R$ " +String( idc_Vl_Parcela_Minima, '#,##0.00' ) + ' )' )
					This.Object.nr_parcelas_cartao[ Row ] = 1
					This.Object.st_Valor_Parcela.Text = String(1) + "x de R$ " + String(idc_Total_Produto + ldc_Frete,  '#,##0.00' ) + ' sem juros'
					Return 1
				End If
			End If
			
			This.Object.st_Valor_Parcela.Text = String(li_parcelas) + "x de R$ " + String( ldc_Vl_Parcela,  '#,##0.00' ) + ' sem juros'
		End If
		
	Case "nr_cpf_cgc"
		If IsNull(data) or Trim(data) = ""   Then
			Return 0
		Else
			If LenA(data) < 14 Then 
				If gf_nr_cpf_valido(data) Then
					This.Object.nr_cpf_cgc.EditMask.mask = '###.###.###-##'
				Else
					This.Object.nr_cpf_cgc.EditMask.mask = '##############'
					Return 1
				End If
			Else
				If gf_cgc_valido(data) Then
					This.Object.nr_cpf_cgc.EditMask.mask = '##.###.###/####-##'
				Else
					This.Object.nr_cpf_cgc.EditMask.mask = '##############'
					Return 1
				End If
			End If
		End If
		
	Case "nm_cidade"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Trim(Data) <> io_Cidade.Nm_Cidade Then
				Return 1
			End If
		Else
			io_Cidade.Of_Inicializa()
			
			This.Object.cd_cidade	[1] = io_Cidade.cd_cidade
			This.Object.nm_cidade	[1] = io_Cidade.nm_cidade
		End If
		
	Case 'id_pbm'
		If Data = 'N' Then
			This.Object.de_pbm			[1] = ls_Null
			dw_1.Object.nr_autorizacao	[1] = ls_Null
			dw_3.Visible = True
		Else
			dw_3.Visible = False
		End If			
End Choose


end event

event dw_1::ue_key;call super::ue_key;String lvs_Coluna

lvs_Coluna = This.GetColumnName()

If Key = KeyEnter! Then
	Choose Case lvs_Coluna
		Case "nm_cidade"
			io_Cidade.of_Localiza_Cidade(This.GetText())
			
			If io_Cidade.Localizada Then					
				dw_1.Object.nm_cidade						[1] = io_Cidade.nm_cidade
				dw_1.Object.cd_cidade						[1] = io_Cidade.cd_cidade
				dw_1.Object.cd_unidade_federacao	 	[1] = io_Cidade.cd_unidade_federacao
			End If
			
		Case "localizacao_endereco"
			If Upper(Trim(This.GetText())) = Upper(is_Texto_Endereco) Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", is_Texto_Endereco, StopSign!)
				Return -1
			End If
						
			wf_localiza_endereco()
	End Choose
	
ElseIf KeyDown(KeyShift!) and KeyDown(KeyF5!) Then//(key = KeyShift!+KeyF5! ) Then
		Run( "calc" )
End If

end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge108_dados_disque_entrega
integer x = 2793
integer y = 1312
boolean default = false
end type

event cb_ok::clicked;Decimal ldc_Vl_Frete

String ls_Parametro

If ib_Roteiro_Pendente Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O roteiro de entrega n$$HEX1$$e300$$ENDHEX$$o foi definido.~r~rPressione o bot$$HEX1$$e300$$ENDHEX$$o [Definir Entrega].")
	Return -1
End If

If Not wf_Inclui_Roteiro_Entrega( Ref ldc_Vl_Frete, True ) Then
	Return -1
End If

ls_Parametro = String(ldc_Vl_Frete) + '|' + String( il_Roteiro)

CloseWithReturn( Parent, ls_Parametro )

end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge108_dados_disque_entrega
integer x = 3109
integer y = 1312
integer weight = 700
end type

event cb_cancelar::clicked;//OverRide

Decimal ldc_Vl_Frete

String ls_Null
SetNull(ls_Null)

wf_Inclui_Roteiro_Entrega( Ref ldc_Vl_Frete, False )

CloseWithReturn(Parent, ls_Null)

end event

type dw_2 from dc_uo_dw_base within w_ge108_dados_disque_entrega
integer x = 64
integer y = 1064
integer width = 1984
integer height = 340
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge108_multiplas_formas_pagamento"
boolean vscrollbar = true
end type

event itemchanged;call super::itemchanged;Integer  li_Parcelas, ll_Null
Decimal{2} ldc_Vl_Parcela, ldc_Vl_Pagamento, ldc_Total_Pedido, ldc_Total_Multiplos_Pagamento
Decimal{2} ldc_Total_Dinheiro
String ls_PBM

SetNull(ll_Null)

dw_1.AcceptText()
dw_3.AcceptText()

ls_PBM									= dw_1.Object.id_pbm[ 1 ]
ldc_Total_Multiplos_Pagamento 	= This.GetItemDecimal(1, 'cp_total_multiplos_pagto' )	
ldc_Total_Dinheiro					 	= This.GetItemDecimal(1, 'cp_total_dinheiro' )	
ldc_Total_Pedido						= dw_3.GetItemDecimal(1, 'vl_total_pedido' )	

If IsNull(ldc_Total_Multiplos_Pagamento) 	Then ldc_Total_Multiplos_Pagamento = 0
If IsNull(ldc_Total_Dinheiro) 					Then ldc_Total_Dinheiro = 0
If IsNull(ldc_Total_Pedido) 						Then ldc_Total_Pedido = 0

Choose Case Lower(dwo.Name) 
	Case "cd_forma_pagamento"
		
		This.Object.nr_parcelas_cartao[ Row ] = ll_Null
		
		If This.Find("cd_forma_pagamento='" +Data+"'", 1, This.RowCount() ) > 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Forma de pagamento j$$HEX1$$e100$$ENDHEX$$ foi informada.", Exclamation!)
			This.Object.cd_forma_pagamento [ row ] = ''
			This.Object.vl_pagamento 			[ row ] = 0
			Return 1
		End If
		
		If This.RowCount() = 1 Then				
			This.Object.vl_pagamento	[Row] = ldc_Total_Pedido
		End If
		
		If Data = 'CP' Then
			This.Object.nr_parcelas_cartao[Row] = 1			
			This.Event ue_Pos(row, 'vl_pagamento')
		End If
			
	Case "nr_parcelas_cartao"		
		ldc_Vl_Pagamento = This.Object.vl_Pagamento[1]
		
	Case "vl_pagamento"
		This.AcceptText()
		//Pega novamente o valor atualizado
		ldc_Total_Multiplos_Pagamento 	= This.GetItemDecimal(1, 'cp_total_multiplos_pagto' )	
		
		Choose Case This.Object.cd_forma_pagamento[ row ]	
			Case 'DI'
				//Dinheiro pode ter pagamento a maior
			Case Else
				If ls_PBM <> 'S' Then
					If ldc_Total_Multiplos_Pagamento > ldc_Total_Pedido Then
						If ldc_Total_Dinheiro > 0 And ( ldc_Total_Dinheiro > ( ldc_Total_Multiplos_Pagamento - ldc_Total_Pedido )  ) Then
							//Valor de troco					
						Else
							MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Valor do pagamento superior ao valor total do pedido.", Exclamation!)
							This.Object.vl_pagamento[Row] = 0
							Return 1
						End If
					Else
						If Dec(Data) > ( ldc_Total_Pedido - (ldc_Total_Multiplos_Pagamento - Dec(Data))) Then
							MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Valor do pagamento superior ao valor total do pedido.", Exclamation!)
							This.Object.vl_pagamento[Row] = 0
							Return 1
						End If	
					End If
				End If
		End Choose
		
End Choose

Parent.Event ue_atualiza_total_pedido()

end event

event clicked;call super::clicked;Integer li_Row
If dwo.Name = 'cb_excluir_pagto' Then
	li_Row = dw_2.getRow()
	dw_2.deleterow(li_Row)
End If
end event

type cb_1 from commandbutton within w_ge108_dados_disque_entrega
integer x = 1349
integer y = 1044
integer width = 402
integer height = 84
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Adic. Pagto."
end type

event clicked;Decimal{2} ldc_Total_Multiplos_Pagamento, ldc_Frete

String ls_PBM

dw_1.AcceptText()
dw_2.AcceptText()

ls_PBM = dw_1.Object.id_pbm[1]

//Sem selecao da forma de pagamento
If dw_2.Find( "cd_forma_pagamento='XX'", 1, dw_2.RowCount() ) > 0 Then
	Return -1
End If
If dw_2.Find( "cd_forma_pagamento=''", 1, dw_2.RowCount() ) > 0 Then
	Return -1
End If
If dw_2.Find( "IsNull(cd_forma_pagamento)", 1, dw_2.RowCount() ) > 0 Then
	Return -1
End If
If dw_2.Find( "vl_pagamento = 0", 1, dw_2.RowCount() ) > 0 Then
	Return -1
End If
If dw_2.Find( "IsNull(vl_pagamento)", 1, dw_2.RowCount() ) > 0 Then
	Return -1
End If

ldc_Total_Multiplos_Pagamento 	= dw_2.GetItemDecimal(dw_2.RowCount(), 'cp_total_multiplos_pagto' )		
ldc_frete									= dw_1.GetItemDecimal(dw_1.RowCount(), 'vl_frete' )		

If IsNull(ldc_Total_Multiplos_Pagamento) 	Then ldc_Total_Multiplos_Pagamento = 0
If IsNull(ldc_frete) 									Then ldc_frete = 0

If ls_PBM <> 'S' Then
	If ldc_Total_Multiplos_Pagamento >= ( idc_Total_Produto + ldc_frete ) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Total do pedido j$$HEX1$$e100$$ENDHEX$$ foi atendido.", Exclamation!)
		Return -1
	End If
End If

dw_2.InsertRow(0)
end event

type dw_3 from dc_uo_dw_base within w_ge108_dados_disque_entrega
integer x = 2085
integer y = 996
integer width = 1344
integer height = 284
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge108_total_pedido"
end type

type cb_definir_entrega from commandbutton within w_ge108_dados_disque_entrega
integer x = 2094
integer y = 1312
integer width = 539
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Definir Entrega"
end type

event clicked;Integer li_Pos
String ls_Retorno, ls_Aux

//Ao clicar no bot$$HEX1$$e300$$ENDHEX$$o inicializa a varialvel
ib_Roteiro_Pendente = True

Open( w_ge108_roteiro_entrega )

ls_Retorno = Message.stringparm

li_Pos = PosA(ls_Retorno, '|')

If li_Pos > 0 Then
	ls_Aux = Mid( ls_Retorno, 1, li_Pos - 1 )
	ii_Roteiro_Parametro = Integer(ls_Aux)
	
	ls_Aux = Mid( ls_Retorno, li_Pos + 1)
	idt_Agendamento =Date(ls_Aux)
Else
	ii_Roteiro_Parametro = Integer(ls_Retorno)
End If

If Not IsNull( ii_Roteiro_Parametro ) And ii_Roteiro_Parametro > 0 Then
	ib_Roteiro_Pendente = False
End If
end event

type gb_2 from groupbox within w_ge108_dados_disque_entrega
integer x = 41
integer y = 996
integer width = 2039
integer height = 428
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 553648127
string text = "Pagamento"
end type

