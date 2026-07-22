HA$PBExportHeader$uo_cliente.sru
forward
global type uo_cliente from nonvisualobject
end type
end forward

global type uo_cliente from nonvisualobject
end type
global uo_cliente uo_cliente

type variables
Boolean Localizado
Boolean Senha_Criptograda	 	= False
Boolean Falecido					= False
Boolean ib_Mostra_MSG_CNPJ_Invalido = False

DateTime dh_Nascimento
DateTime dh_inclusao

String	cd_cliente, &
		nm_cliente, &
		nm_razao_social, &
		id_tipo_cliente, &
		id_fisica_juridica, &
		nr_cpf_cgc, &
		cd_unidade_federacao, &
		de_endereco, &          
		nm_cidade, &
		cd_uf,&
		de_bairro , &
		nr_cep, &
		nr_ddd_fone, &
		nr_fone, &
		nr_ddd_celular, &
		nr_fone_celular, &
		nr_ddd_comercial, &
		nr_fone_comercial, &
		nr_inscricao_estadual, &
		cd_dependente, &
		nm_dependente,&
		nr_cartao_clube,&
		de_senha_cliente,&
		id_senha_criptografada,&
		de_senha_dependente,&
		nr_rg,&
		de_endereco_email_envio_xml, &
		id_sexo, &
		nr_endereco, &
		cd_cidade_ibge, &
		de_email,&
		de_hash_senha,&
		de_hash_senha_dep
String de_orgao_emissor_rg
String cd_uf_emissor_rg
String id_rede_cartao
String nm_conjuge
String id_falecido
String nm_social
String de_complemento

Long	cd_cidade,&
		cd_filial_centralizadora,&
		cd_tipo_nf_sucata

integer  nr_dia_vencimento

Decimal vl_limite_credito

string ivs_parametro, &
         ivs_tipo_cliente = "", &
         ivs_fisica_juridica

Protected:
string ivs_bloqueio_de_para = 'SI3'
Long ivl_Filial_Param
end variables

forward prototypes
public subroutine of_localiza_codigo (string ps_cliente)
public function boolean of_exclui_cliente (string ps_cliente)
public function boolean of_de_para_dependente (string ps_cliente_de, string ps_cliente_para)
public function boolean of_exclui_bloqueio_de (string ps_cliente_de)
public function boolean of_exclui_cliente_de (string ps_cliente_de)
public function boolean of_de_para_nf_devolucao_venda (string ps_cliente_de, string ps_cliente_para)
public function boolean of_de_para_nf_venda (string ps_cliente_de, string ps_cliente_para)
public function boolean of_de_para_referencia_comercial (string ps_cliente_de, string ps_cliente_para)
public function boolean of_de_para_titulo_receber (string ps_cliente_de, string ps_cliente_para)
public function long of_proximo_bloqueio (long pl_filial)
public function boolean of_insere_cliente_de_para (string ps_cliente_de, string ps_cliente_para, datetime pdh_data_alteracao)
public function boolean of_de_para_alteracao (string ps_cliente_de, string ps_cliente_para, datetime pdh_data_bloqueio, long pl_filial, string ps_usuario)
public function boolean of_insere_bloqueio_de_para (string ps_cliente, datetime pdh_data_bloqueio, long pl_filial, string ps_usuario)
public function boolean of_de_para_exclusao (datetime pdh_data_exclusao, long pl_filial, string ps_usuario)
public function boolean of_altera_cliente_de_para (string ps_cliente_de, string ps_cliente_para, datetime pdh_data_alteracao, datetime pdh_data_exclusao)
public function long of_filial_parametro ()
public subroutine of_inicializa ()
public function boolean of_de_para_contas_receber (string as_cliente_de, string as_cliente_para, string as_tipo_conta)
public function boolean of_de_para_contas_receber (string as_cliente_de, string as_cliente_para)
public function boolean of_proximo_codigo (long al_filial, ref string as_codigo)
public subroutine of_localiza_generica (string ps_parametro)
public function boolean of_proximo_dependente (string as_cliente, ref string as_dependente)
public function boolean of_localiza_dependente_generica (string as_parametro)
public function boolean of_localiza_dependente_codigo (string as_parametro)
public function boolean of_localiza_dependente (string as_parametro)
public function boolean of_localiza_cartao (string as_cartao)
public function boolean of_existe_cpf_cgc (string as_cpf_cgc, ref boolean ab_existe)
public function boolean of_de_para_pontuacao_clube (string as_cliente_de, string as_cliente_para)
public function boolean of_saldo_pontuacao_cliente (string as_cliente, date adt_data_inicial, ref decimal adc_pontuacao)
public function boolean of_de_para_recibo_resgate_clube (string ps_cliente_de, string ps_cliente_para)
public function boolean of_de_para_cartao_clube (string ps_cliente_de, string ps_cliente_para, datetime pdh_bloqueio, string ps_usuario, long pl_filial)
public function boolean of_de_para_historico_negociacao (string ps_cliente_de, string ps_cliente_para)
public function boolean of_vencimento_conta (string as_cliente, date adt_movimento, ref date adt_vencimento)
public subroutine of_localiza_cliente (string ps_parametro, string as_identificador)
public subroutine of_localiza_cliente (string ps_parametro)
public subroutine of_localiza_cpf (string ps_cpf)
public subroutine of_localiza_rg (string ps_rg)
public function boolean of_verifica_bloqueio_matriz (string as_cliente, string as_dependente, string as_tipo_venda, ref string as_matricula)
public subroutine of_localiza_cpf (string ps_cpf, boolean pb_messagebox)
public function boolean of_de_para_cliente_caixa (string ps_cliente_de, string ps_cliente_para)
public function boolean of_proximo_codigo (long al_filial, ref string as_codigo, boolean pb_matriz)
public function boolean of_de_para_campanha_cliente (string ps_cliente_de, string ps_cliente_para)
public function boolean of_insere_bloqueio (long pl_filial, string ps_tipo_bloqueio, string ps_motivo_bloqueio, string ps_cliente, datetime pdh_data_bloqueio, string ps_usuario)
public subroutine of_appendwhere_nome_cliente (dc_uo_dw_base pdw_base, string ps_nome)
public function boolean of_de_para_historico_categoria (string ps_cliente_de, string ps_cliente_para)
public subroutine of_localiza_cnpj ()
public function boolean of_possui_reserva_produto ()
public function boolean of_proximo_cliente (long al_filial, ref string as_novo_codigo)
public function boolean of_de_para_venda_pbm (string ps_cliente_de, string ps_cliente_para)
public function boolean of_exclui_tipo_aviso_cliente_de (string ps_cliente_de)
public function boolean of_localiza_cliente_sap (string ps_cliente_sap, boolean pb_messagebox)
end prototypes

public subroutine of_localiza_codigo (string ps_cliente);String lvs_Criptografada

Select cl.cd_cliente,
		cl.nm_cliente,
		cl.nm_social,
		cl.nm_razao_social,
		cl.id_tipo_cliente,
		cl.id_fisica_juridica,
		cl.nr_cpf_cgc,
		ci.cd_unidade_federacao,
		cl.de_endereco,
		cl.nr_endereco,
		cl.de_bairro,
		cl.cd_cidade,
		ci.nm_cidade,
		ci.cd_unidade_federacao,
		cl.nr_cep,
		cl.nr_ddd_fone_residencial, 
		cl.nr_fone_residencial,
		cl.nr_ddd_celular,
		cl.nr_celular,
		cl.nr_ddd_fone_comercial,
		cl.nr_fone_comercial,		
		cl.nr_inscricao_estadual,
		cl.cd_filial_centralizadora,
		cl.nr_dia_vencimento,
		cl.de_senha_venda_credito,
		cl.id_senha_criptografada,
		cl.nr_rg,
		cl.de_orgao_emissor_rg,
		cl.cd_uf_emissor_rg,
		cl.de_endereco_email_envio_xml,
		cl.id_sexo,
		cl.dh_nascimento,
		ci.cd_cidade_ibge,
		cl.de_endereco_email,
		cl.nm_conjuge,
		Coalesce(cl.id_falecido, 'N'),
		cl.dh_inclusao,
		cl.de_complemento,
		cl.de_hash_senha,
		cl.cd_tipo_nf_sucata
Into	:cd_cliente,
		:nm_cliente,
		:nm_social,
		:nm_razao_social,
		:id_tipo_cliente,
		:id_fisica_juridica,
		:nr_cpf_cgc,
		:cd_unidade_federacao,
		:de_endereco,
		:nr_endereco,
		:de_bairro,
		:cd_cidade,
		:nm_cidade,
		:cd_uf,
		:nr_cep,
		:nr_ddd_fone,
		:nr_fone,
		:nr_ddd_celular,
		:nr_fone_celular,
		:nr_ddd_comercial,
		:nr_fone_comercial,		
		:nr_inscricao_estadual,
		:cd_filial_centralizadora,
		:nr_dia_vencimento,
		:de_senha_cliente,
		:lvs_Criptografada,
		:nr_rg,
		:de_Orgao_Emissor_Rg,
		:cd_uf_emissor_rg,
		:de_endereco_email_envio_xml,
		:id_sexo,
		:dh_Nascimento,
		:cd_cidade_ibge,
		:de_email,
		:nm_conjuge,
		:id_falecido,
		:dh_inclusao,
		:de_complemento,
		:de_hash_senha,
		:cd_tipo_nf_sucata
From cliente cl LEFT OUTER JOIN cidade ci
    ON cl.cd_cidade = ci.cd_cidade
Where cl.cd_cliente = :ps_cliente
Using SqlCa;

This.Senha_Criptograda 	= (lvs_Criptografada = 'S')
This.Falecido				= (This.id_falecido = 'S')
This.ivs_Tipo_Cliente		= This.id_Tipo_Cliente

Choose Case SqlCa.SqlCode
	Case 0	
		SetNull(Cd_Dependente)
		nm_dependente = ""
		Localizado = True
		
		If Not IsNull(This.nm_Social) And Trim(This.nm_Social) <> "" Then
			This.Nm_Cliente = This.Nm_Social
		End If
		
		// Verifica o tipo do cliente selecionado
		If This.ivs_Tipo_Cliente <> "" Then
			Choose Case This.ivs_Tipo_Cliente
				Case "CR", "RC", "CC"
					If This.Id_Tipo_Cliente <> This.ivs_Tipo_Cliente Then						
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tipo do cliente '" + This.Id_Tipo_Cliente + "' diferente do determinado '" + This.ivs_Tipo_Cliente + "'.", Information!)
						Localizado = False
					End If
					
				Case "CL"
					If This.Id_Tipo_Cliente <> "RC" and This.Id_Tipo_Cliente <> "CC" Then						
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tipo do cliente '" + This.Id_Tipo_Cliente + "' diferente do determinado '" + This.ivs_Tipo_Cliente + "'.", Information!)
						Localizado = False
					End If					
			End Choose
		End If
		
		// Verifica o tipo de pessoa (F$$HEX1$$ed00$$ENDHEX$$sica ou Jur$$HEX1$$ed00$$ENDHEX$$dica)
		If This.ivs_Fisica_Juridica <> "" Then
			If This.Id_Fisica_Juridica <> This.ivs_Fisica_Juridica Then
				If This.ivs_Fisica_Juridica = "F" Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O cliente n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ pessoa f$$HEX1$$ed00$$ENDHEX$$sica.", Information!)
				Else
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O cliente n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ pessoa jur$$HEX1$$ed00$$ENDHEX$$dica.", Information!)
				End If
				
				Localizado = False
			End If
		End If
		
	Case 100
		Localizado = False
		
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Cliente '" + ps_Cliente + "'")
		Localizado = False		
End Choose
end subroutine

public function boolean of_exclui_cliente (string ps_cliente);BOOLEAN lvb_Erro

lvb_Erro = False

Open(w_Aguarde)
	
w_Aguarde.uo_Progress.of_SetMax(5)

DO WHILE TRUE

	w_Aguarde.uo_Progress.of_SetProgress(1)
	
	Delete From bloqueio
	Where cd_cliente = :ps_Cliente;
	
	If Sqlca.Sqlcode = -1 Then		
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Erro ao excluir bloqueio do cliente.~r~r'+ Sqlca.SqlErrText , Information!, Ok! )
		lvb_Erro = True
		Exit
	End If
	
	w_Aguarde.uo_Progress.of_SetProgress(2)					
					
	Delete From cliente_dependente
	Where cd_cliente = :ps_cliente;
	
	If Sqlca.Sqlcode = -1 Then
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Erro ao excluir dependente do cliente.~r~r'+ Sqlca.SqlErrText , Information!, Ok! )
		lvb_Erro = True
		Exit
	End If
	
	w_Aguarde.uo_Progress.of_SetProgress(3)	
	
	Delete From referencia_comercial_cliente
	Where cd_cliente = :ps_cliente;
	
	If Sqlca.Sqlcode = -1 Then
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Erro ao excluir referencia comercial do cliente.~r~r'+ Sqlca.SqlErrText , Information!, Ok! )
		lvb_Erro = True
		Exit
	End If
		
	w_Aguarde.uo_Progress.of_SetProgress(4)	
	
	Delete From composicao_social_cliente
	Where cd_cliente = :ps_cliente;
	
	If Sqlca.Sqlcode = -1 Then
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Erro ao excluir composicao social do cliente. ~r~r' + Sqlca.SqlErrText, Information!, Ok! )
		lvb_Erro = True
		Exit
	End If
		
	w_Aguarde.uo_Progress.of_SetProgress(5)	
	
	Delete From cliente
	Where cd_cliente = :ps_cliente;
	
	If Sqlca.Sqlcode = -1 Then
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Existem refer$$HEX1$$ea00$$ENDHEX$$ncias para o cliente que n$$HEX1$$e300$$ENDHEX$$o permitem sua exclus$$HEX1$$e300$$ENDHEX$$o. ~r~r' + Sqlca.SqlErrText , Information!, Ok! )
		lvb_Erro = True
	End If
	
	Exit
	
LOOP

Close(w_Aguarde)

If Not lvb_Erro Then
	
	COMMIT USING SQLCA;
	
	If Sqlca.Sqlcode = -1 Then
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Erro ao executar commit.',StopSign!,Ok!)
		Return False
	Else
		Return True
	End If
	
Else
	
	ROLLBACK USING SQLCA;
	
	If Sqlca.Sqlcode = -1 Then
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Erro ao executar rollback.',StopSign!,Ok!)
	End If

	Return False
	
End If	
	
end function

public function boolean of_de_para_dependente (string ps_cliente_de, string ps_cliente_para);w_Aguarde.Title = "Atualizando Dependentes..."

Delete From cliente_dependente
Where cd_cliente = :ps_Cliente_De
Using SqlCa;
		
If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Exclus$$HEX1$$e300$$ENDHEX$$o dos dependentes do cliente de.")
	Return False
Else
	Return True
End If
end function

public function boolean of_exclui_bloqueio_de (string ps_cliente_de);w_Aguarde.Title = "Atualizando Bloqueios..."

Delete From bloqueio
Where cd_cliente = :ps_Cliente_De;
  
If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na exclus$$HEX1$$e300$$ENDHEX$$o dos bloqueios." + SqlCa.SqlErrText, StopSign!, Ok!)
	Return False
Else
	Return True
End If
end function

public function boolean of_exclui_cliente_de (string ps_cliente_de);w_Aguarde.Title = "Excluindo Cliente de..."
	
Delete From cliente
Where cd_cliente = :ps_Cliente_De;
  
If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na exclus$$HEX1$$e300$$ENDHEX$$o do Cliente de." + SqlCa.SqlErrText, StopSign!, Ok!)
	Return False
Else
	Return True
End If
end function

public function boolean of_de_para_nf_devolucao_venda (string ps_cliente_de, string ps_cliente_para);w_Aguarde.Title = "Atualizando Notas Fiscais de Devolu$$HEX2$$e700e300$$ENDHEX$$o de Venda..."

Update nf_devolucao_venda
Set cd_cliente = :ps_Cliente_Para,
    cd_cliente_dependente = null
Where cd_cliente = :ps_Cliente_De
Using SqlCa;
  
If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o NF Devolu$$HEX2$$e700e300$$ENDHEX$$o Venda")
	Return False
Else
	Return True
End If
end function

public function boolean of_de_para_nf_venda (string ps_cliente_de, string ps_cliente_para);w_Aguarde.Title = "Atualizando Notas Fiscais de Venda..."

Update nf_venda
Set cd_cliente            = :ps_Cliente_Para,
    cd_cliente_dependente = null
Where cd_cliente = :ps_Cliente_De
Using SqlCa;
  
If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o NF Venda")
	Return False
Else
	Return True
End If
end function

public function boolean of_de_para_referencia_comercial (string ps_cliente_de, string ps_cliente_para);Long lvl_Total

w_Aguarde.Title = "Atualizando Refer$$HEX1$$ea00$$ENDHEX$$ncias Comerciais do Cliente..."

Select count(*) Into :lvl_Total
From referencia_comercial_cliente
Where cd_cliente = :ps_Cliente_Para
Using SqlCa;

If SqlCa.Sqlcode = -1 Then
	SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o das refer$$HEX1$$ea00$$ENDHEX$$ncias comerciais do cliente para.")
	Return False
Else
	If IsNull(lvl_Total) or lvl_Total = 0 Then
  		Insert Into referencia_comercial_cliente (cd_cliente,   
															   nm_referencia,   
															   de_endereco,   
															   de_bairro,   
															   nr_cep,   
															   nr_ddd_telefone,   
															   nr_telefone)
  		Select :ps_Cliente_Para,
				 nm_referencia,   
				 de_endereco,   
				 de_bairro,   
				 nr_cep,   
				 nr_ddd_telefone,   
				 nr_telefone
		From referencia_comercial_cliente
		Where cd_cliente = :ps_Cliente_De
		Using SqlCa;

		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgdbError("Inclus$$HEX1$$e300$$ENDHEX$$o das refer$$HEX1$$ea00$$ENDHEX$$ncias comerciais do cliente para.")
			Return False
		End If
	End If
	
	Delete From referencia_comercial_cliente
	Where cd_cliente = :ps_Cliente_De
	Using SqlCa;

	If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgdbError("Exclus$$HEX1$$e300$$ENDHEX$$o das refer$$HEX1$$ea00$$ENDHEX$$ncias comerciais do cliente de.")
		Return False
	Else
		Return True
	End If
End If
end function

public function boolean of_de_para_titulo_receber (string ps_cliente_de, string ps_cliente_para);w_Aguarde.Title = "Atualizando t$$HEX1$$ed00$$ENDHEX$$tulo a receber..."

Update titulo_receber
Set cd_cliente = :ps_Cliente_Para
Where cd_cliente = :ps_Cliente_De
Using SqlCa;
  
If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o dos t$$HEX1$$ed00$$ENDHEX$$tulos a receber do cliente de.")
	Return False
Else
	Return True
End If
end function

public function long of_proximo_bloqueio (long pl_filial);Long lvl_Bloqueio

Select max(nr_bloqueio) Into :lvl_Bloqueio
From bloqueio
Where cd_filial = :pl_Filial;

If SqlCa.SqlCode = 0 Then
	If IsNull(lvl_Bloqueio) or lvl_Bloqueio = 0 Then
		lvl_Bloqueio = 1
	Else
		lvl_Bloqueio ++			
	End If
End If

Return lvl_Bloqueio
end function

public function boolean of_insere_cliente_de_para (string ps_cliente_de, string ps_cliente_para, datetime pdh_data_alteracao);w_Aguarde.Title = "Inserindo cliente de para..."

Insert Into cliente_de_para (cd_cliente_de,   
									  cd_cliente_para,   
									  dh_alteracao,   
									  dh_exclusao)  
Values (:ps_Cliente_De,   
		  :ps_Cliente_Para,   
		  :pdh_Data_Alteracao,   
		  null)
Using SqlCa;
  
If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Inclus$$HEX1$$e300$$ENDHEX$$o do cliente de para.")
	Return False
Else
	Return True
End If
end function

public function boolean of_de_para_alteracao (string ps_cliente_de, string ps_cliente_para, datetime pdh_data_bloqueio, long pl_filial, string ps_usuario);Boolean lvb_Erro = True

SetPointer(HourGlass!)
Open(w_Aguarde)

w_Aguarde.uo_Progress.of_SetMax(15)

If of_De_Para_Referencia_Comercial(ps_Cliente_De, ps_Cliente_Para) Then
	w_Aguarde.uo_Progress.of_SetProgress(1) 
	If of_De_Para_Campanha_Cliente(ps_Cliente_De, ps_Cliente_Para) Then
		w_Aguarde.uo_Progress.of_SetProgress(2)			
		If of_De_Para_Cliente_Caixa(ps_Cliente_De, ps_Cliente_Para) Then
			w_Aguarde.uo_Progress.of_SetProgress(3)
			If of_De_Para_Contas_Receber(ps_Cliente_De, ps_Cliente_Para) Then
				w_Aguarde.uo_Progress.of_SetProgress(4)
				If of_De_Para_Pontuacao_Clube(ps_Cliente_De, ps_Cliente_Para) Then
					w_Aguarde.uo_Progress.of_SetProgress(5)
					If of_De_Para_NF_Venda(ps_Cliente_De, ps_Cliente_Para) Then
						w_Aguarde.uo_Progress.of_SetProgress(6)
						If of_De_Para_NF_Devolucao_Venda(ps_Cliente_De, ps_Cliente_Para) Then
							w_Aguarde.uo_Progress.of_SetProgress(7)
							If of_De_Para_Titulo_Receber(ps_Cliente_De, ps_Cliente_Para) Then
								w_Aguarde.uo_Progress.of_SetProgress(8)
								If of_De_Para_Historico_Negociacao(ps_Cliente_De,ps_Cliente_Para) Then
									w_Aguarde.uo_Progress.of_SetProgress(9)
									If of_De_Para_Recibo_Resgate_Clube(ps_Cliente_De,ps_Cliente_Para) Then
										w_Aguarde.uo_Progress.of_SetProgress(10)
										If of_De_Para_Cartao_Clube(ps_Cliente_De,ps_Cliente_Para,pdh_Data_Bloqueio,ps_Usuario,pl_Filial) Then
											w_Aguarde.uo_Progress.of_SetProgress(11)
											If of_De_Para_Dependente(ps_Cliente_De, ps_Cliente_Para) Then
												w_Aguarde.uo_Progress.of_SetProgress(12)
												If of_Insere_Bloqueio_De_Para(ps_Cliente_De,pdh_Data_Bloqueio,pl_Filial,ps_Usuario) Then
													w_Aguarde.uo_Progress.of_SetProgress(13)
													If of_De_Para_Historico_Categoria(ps_Cliente_De, ps_Cliente_Para) Then
														w_Aguarde.uo_Progress.of_SetProgress(14)
														If of_Insere_Cliente_De_Para(ps_Cliente_De,ps_Cliente_Para,pdh_Data_Bloqueio) Then
															w_Aguarde.uo_Progress.of_SetProgress(15)
															lvb_Erro = False
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
		End If
	End If
End If

Close(w_Aguarde)
SetPointer(Arrow!)

Return Not lvb_Erro
end function

public function boolean of_insere_bloqueio_de_para (string ps_cliente, datetime pdh_data_bloqueio, long pl_filial, string ps_usuario);Long lvl_Bloqueio

w_Aguarde.Title = "Inserindo bloqueio de para..."

lvl_Bloqueio = This.of_Proximo_Bloqueio(pl_Filial)

Insert Into bloqueio (cd_filial,   
						    nr_bloqueio,   
						    id_tipo_bloqueio,   
						    cd_motivo_bloqueio,   
						    dh_bloqueio,   
						    nr_matricula_bloqueio,   
						    cd_cliente,   
						    cd_clube_cliente,   
						    cd_convenio,   
						    cd_conveniado,   
						    cd_dependente,   
						    dh_liberacao,   
						    nr_matricula_liberacao)
Values (:pl_Filial,   
		  :lvl_Bloqueio,   
		  'CLI',   
		  :This.ivs_Bloqueio_De_Para,   
		  :pdh_Data_Bloqueio,   
		  :ps_Usuario,   
		  :ps_Cliente,   
		  null,   
		  null,   
		  null,   
		  null,   
		  null,   
		  null)
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Inclus$$HEX1$$e300$$ENDHEX$$o do bloqueio do cliente de.")
	Return False
Else
	Return True
End If
end function

public function boolean of_de_para_exclusao (datetime pdh_data_exclusao, long pl_filial, string ps_usuario);Boolean lvb_Erro = False

Long	lvl_Max, &
		lvl_Contador

String	lvs_Cliente_De, &
		lvs_Cliente_Para
		 
Date lvdt_Data_Limite

DateTime lvdh_Data_Alteracao

dc_uo_ds_Base lvds_1
lvds_1 = Create dc_uo_ds_Base

If Not lvds_1.of_ChangeDataObject("dw_ge002_cliente_de_para") Then
	Destroy(lvds_1)
	Return False
End If

lvdt_Data_Limite = RelativeDate(Date(pdh_Data_Exclusao), -2)

lvl_Max = lvds_1.Retrieve(lvdt_Data_Limite)

If lvl_Max > 0 Then	
	w_Aguarde.uo_Progress.of_SetMax(lvl_Max)
	lvb_Erro = True
	
	For lvl_Contador = 1 To lvl_Max
		lvs_Cliente_De			= lvds_1.Object.Cd_Cliente_De		[lvl_Contador]
		lvs_Cliente_Para		= lvds_1.Object.Cd_Cliente_Para	[lvl_Contador]
		lvdh_Data_Alteracao	= lvds_1.Object.Dh_Alteracao		[lvl_Contador]
		
		If of_Altera_Cliente_De_Para(lvs_Cliente_De, lvs_Cliente_Para, lvdh_Data_Alteracao, pdh_Data_Exclusao) Then
			If of_De_Para_Referencia_Comercial(lvs_Cliente_De, lvs_Cliente_Para) Then
				If of_De_Para_Campanha_Cliente(lvs_Cliente_De, lvs_Cliente_Para) Then
					If of_De_Para_Cliente_Caixa(lvs_Cliente_De, lvs_Cliente_Para) Then
						If of_De_Para_Contas_Receber(lvs_Cliente_De, lvs_Cliente_Para) Then
							If of_De_Para_Pontuacao_CLube(lvs_Cliente_De, lvs_Cliente_Para) Then
								If of_De_Para_NF_Venda(lvs_Cliente_De, lvs_Cliente_Para) Then
									If of_de_para_Venda_Pbm(lvs_Cliente_De, lvs_Cliente_Para) Then
										If of_De_Para_NF_Devolucao_Venda(lvs_Cliente_De, lvs_Cliente_Para) Then
											If of_De_Para_Titulo_Receber(lvs_Cliente_De, lvs_Cliente_Para) Then
												If of_De_Para_Historico_Negociacao(lvs_Cliente_De, lvs_Cliente_Para) Then
													If of_De_Para_Recibo_Resgate_Clube(lvs_Cliente_De, lvs_Cliente_Para) Then
														If of_De_Para_Cartao_Clube(lvs_Cliente_De, lvs_Cliente_Para, lvdh_Data_Alteracao,ps_usuario,pl_filial) Then
															If of_De_Para_Dependente(lvs_Cliente_De, lvs_Cliente_Para) Then
																If of_De_Para_Historico_Categoria(lvs_Cliente_De, lvs_Cliente_Para) Then
																	If of_Exclui_Bloqueio_De(lvs_Cliente_De) Then
																		If of_Exclui_Tipo_Aviso_Cliente_De(lvs_Cliente_De) Then	
																			If of_Exclui_Cliente_De(lvs_Cliente_De) Then
																				lvb_Erro = False
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
							End If
						End If
					End If
				End If
			End If
		End If
		
		If lvb_Erro Then
			SqlCa.of_RollBack()
		Else
			SqlCa.of_Commit()
		End If
	
		w_Aguarde.uo_Progress.of_SetProgress(lvl_Contador)
	Next
End If

Destroy(lvds_1)

Return Not lvb_Erro
end function

public function boolean of_altera_cliente_de_para (string ps_cliente_de, string ps_cliente_para, datetime pdh_data_alteracao, datetime pdh_data_exclusao);w_Aguarde.Title = "Atualizando cliente de para..."

Update cliente_de_para 
Set dh_exclusao = :pdh_Data_Exclusao
Where cd_cliente_de   = :ps_Cliente_De   
  and cd_cliente_para = :ps_Cliente_Para
  and dh_alteracao    = :pdh_Data_Alteracao
Using SqlCa;
  
If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do cliente de para.")
	Return False
Else
	Return True
End If
end function

public function long of_filial_parametro ();Long lvl_Filial

//Verifica se o valor j$$HEX1$$e100$$ENDHEX$$ foi carregado
If gf_coalesce(ivl_Filial_Param,0) = 0 Then
	Select cd_filial Into :lvl_Filial
	From parametro 
	Where id_parametro = '1'
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			//Carrega o valor para vari$$HEX1$$e100$$ENDHEX$$vel de instancia, para n$$HEX1$$e300$$ENDHEX$$o ficar fazendo consultas em banco desnecess$$HEX1$$e100$$ENDHEX$$rias
			ivl_Filial_Param = lvl_Filial
			Return lvl_Filial
		Case 100
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Par$$HEX1$$e200$$ENDHEX$$metro n$$HEX1$$e300$$ENDHEX$$o localizado na verifica$$HEX2$$e700e300$$ENDHEX$$o da filial.", StopSign!)
			Return 0
		Case -1
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao verificar filial do par$$HEX1$$e200$$ENDHEX$$metro." + SqlCa.SqlErrText, StopSign!)
			Return 0
	End Choose
Else
	Return ivl_Filial_Param
End If
end function

public subroutine of_inicializa ();Localizado = False
Senha_Criptograda 	= False
Falecido					= False
SetNull(Cd_Cliente)
SetNull(Nm_Cliente)
SetNull(Nm_Social)
SetNull(Nm_Razao_Social)
SetNull(Cd_Dependente)
SetNull(nm_dependente)
SetNull(de_endereco)
SetNull(nr_endereco)
SetNull(dh_Nascimento)
SetNull(de_orgao_emissor_rg)
SetNull(cd_uf_emissor_rg)
SetNull(id_rede_cartao)
SetNull(de_bairro)
SetNull(cd_cidade)
SetNull(nm_cidade)
SetNull(cd_uf)
SetNull(nr_cep)
SetNull(nr_ddd_fone)
SetNull(nr_fone)
SetNull(nr_ddd_celular)
SetNull(nr_fone_celular)
SetNull(nr_ddd_comercial)
SetNull(nr_fone_comercial)
SetNull(nr_cpf_cgc)
SetNull(id_tipo_cliente)
SetNull(id_tipo_cliente)
SetNull(id_fisica_juridica)
SetNull(cd_unidade_federacao)
SetNull(nr_inscricao_estadual)
SetNull(nr_cartao_clube)
SetNull(de_senha_cliente)
SetNull(de_senha_dependente)
SetNull(ivs_tipo_cliente)
SetNull(ivs_fisica_juridica)
SetNull(nm_conjuge)
SetNull(id_falecido)
SetNull(de_complemento)
SetNull(de_email)
SetNull(de_hash_senha)
SetNull(de_hash_senha_dep)
SetNull(cd_tipo_nf_sucata)

end subroutine

public function boolean of_de_para_contas_receber (string as_cliente_de, string as_cliente_para, string as_tipo_conta);w_Aguarde.Title = "Atualizando Contas a Receber..."
	
// Inclui os movimentos de contas a receber no credi$$HEX1$$e100$$ENDHEX$$rio PARA
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
Select :as_Cliente_Para,
		 id_tipo_conta,   
		 cd_tipo_movimento,   
		 dh_movimento,   
		 dh_sistema,   
		 vl_movimento,   
		 cd_filial,   
		 nr_documento,   
		 de_historico,   
		 nr_titulo_fechamento,
		 dh_vencimento
From contas_receber_movimento
Where cd_conta      = :as_Cliente_De
  and id_tipo_conta = :as_Tipo_Conta
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Inclus$$HEX1$$e300$$ENDHEX$$o dos Movimentos de Contas a Receber PARA")
	Return False
End If

// Exclui os movimentos de contas a receber DE
Delete From contas_receber_movimento
Where cd_conta      = :as_Cliente_De
  and id_tipo_conta = :as_Tipo_Conta
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Exclus$$HEX1$$e300$$ENDHEX$$o dos Movimentos de Contas a Receber DE")
	Return False
End If

// Exclui os saldos de contas a receber DE
Delete From contas_receber_saldo
Where cd_conta      = :as_Cliente_De
  and id_tipo_conta = :as_Tipo_Conta
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Exclus$$HEX1$$e300$$ENDHEX$$o dos Saldos de Contas a Receber")
	Return False
End If

Return True
end function

public function boolean of_de_para_contas_receber (string as_cliente_de, string as_cliente_para);If This.of_De_Para_Contas_Receber(as_Cliente_De, as_Cliente_Para, "CR") Then
	Return This.of_De_Para_Contas_Receber(as_Cliente_De, as_Cliente_Para, "CC")
End If

Return False
end function

public function boolean of_proximo_codigo (long al_filial, ref string as_codigo);Return This.of_Proximo_Codigo( al_Filial, as_Codigo, False )
end function

public subroutine of_localiza_generica (string ps_parametro);String lvs_Cliente, ls_Null

SetNull(ls_Null)

This.ivs_Parametro = ps_Parametro

If gvo_Aplicacao.ivo_seguranca.cd_sistema = 'CL' Then
	OpenWithParm(w_ge002_Selecao_Cliente_Paf, This)
Else
	If gvo_Aplicacao.ivo_seguranca.cd_sistema = 'RL' Then 
		If gvo_Aplicacao.ivo_seguranca.cd_procedimento <> 'W_RL009_PAGAMENTO_CONTA' And gvo_Aplicacao.ivo_seguranca.cd_procedimento <> 'W_RL063_RESGATE_PONTOS_CLUBE' Then
			This.ivs_tipo_cliente = ls_Null
		End If
	End If
	OpenWithParm(w_ge002_Selecao_Cliente, This)	
End If

lvs_Cliente = Message.StringParm

If Not IsNull(lvs_Cliente) Then
	of_Localiza_Codigo(lvs_Cliente)
Else
	Localizado = False
End If
end subroutine

public function boolean of_proximo_dependente (string as_cliente, ref string as_dependente);Boolean lvb_Sucesso = True

String lvs_Ultimo

Integer lvi_Ultimo

// Foi colocada a verifica$$HEX2$$e700e300$$ENDHEX$$o pelo substring do c$$HEX1$$f300$$ENDHEX$$digo devido aos c$$HEX1$$f300$$ENDHEX$$digos que foram gravados 
// incorretamente pelo troca dados
// Por Ademir Buss em 07/02/2006

Select max(cd_dependente_cliente) Into :lvs_Ultimo
From cliente_dependente
Where cd_cliente = :as_Cliente
  and substring(cd_dependente_cliente, 1, 11) = :as_Cliente
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If IsNull(lvs_Ultimo) Then
			lvi_Ultimo = 0
		Else
			lvi_Ultimo = Integer(RightA(lvs_Ultimo, 2))
		End If
		
		as_Dependente = as_Cliente + String(lvi_Ultimo + 1, "00")
		
	Case 100
		as_Dependente = as_Cliente + "01"
		
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Pr$$HEX1$$f300$$ENDHEX$$ximo C$$HEX1$$f300$$ENDHEX$$digo do Dependente para o Cliente '" + as_Cliente + "'")
		lvb_Sucesso = False
End Choose

Return lvb_Sucesso
end function

public function boolean of_localiza_dependente_generica (string as_parametro);String lvs_Dependente

If IsNull(This.Cd_Cliente) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O c$$HEX1$$f300$$ENDHEX$$digo do cliente deve ser informado para localiza$$HEX2$$e700e300$$ENDHEX$$o dos dependentes.", Information!)
	Return False
End If

This.ivs_Parametro = as_Parametro

If gvo_Aplicacao.ivo_seguranca.cd_sistema = 'CL' Then
	OpenWithParm(w_ge002_Selecao_Dependente_Cliente_Paf, This)
Else
	OpenWithParm(w_ge002_Selecao_Dependente_Cliente, This)	
End If

lvs_Dependente = Message.StringParm

If Not IsNull(lvs_Dependente) Then
	Return This.of_Localiza_Dependente_Codigo(lvs_Dependente)
Else
	Return False
End If
end function

public function boolean of_localiza_dependente_codigo (string as_parametro);Select cd_dependente_cliente, 
	   nm_dependente,
	   de_senha_venda_credito,
	   de_hash_senha
Into :cd_dependente, 
	 :nm_dependente,
	 :de_senha_dependente,
	 :de_hash_senha_dep
From cliente_dependente
Where cd_dependente_cliente =:as_parametro
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		Localizado = True
	Case 100
		Localizado = False
	Case -1 
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do dependente do cliente")
		Localizado = False
End Choose

Return Localizado

	
	

end function

public function boolean of_localiza_dependente (string as_parametro);Return This.of_Localiza_Dependente_Generica(as_Parametro)


end function

public function boolean of_localiza_cartao (string as_cartao);Boolean lb_Sucesso = False

String ls_cliente,&
       ls_dependente  
	   
Select	 distinct c.cd_cliente, 
		c.cd_dependente_cliente,
		c.nr_cartao_clube,
		coalesce(c.id_rede_cartao,'DC')
  Into	:ls_cliente,
		:ls_dependente,
		:nr_cartao_clube,
		:id_rede_cartao
From cartao_clube c, 
		filial f
Where c.nr_cartao_clube = :as_Cartao
	and f.cd_filial = dbo.uf_filial_parametro( )
	and ( case c.id_rede_cartao when 'PP' then 'PP' else 'DC' end ) = ( case f.id_rede_filial when 'PP' then 'PP' else 'DC' end )
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		
		This.of_Localiza_Codigo(ls_cliente)
		
		If This.Localizado Then
			If Not IsNull(ls_dependente) Then
				This.of_localiza_dependente_codigo(ls_dependente)
			End If
		End If
		
	Case 100
		
		This.Localizado = False		

		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Cart$$HEX1$$e300$$ENDHEX$$o n$$HEX1$$fa00$$ENDHEX$$mero '" + as_Cartao + "' n$$HEX1$$e300$$ENDHEX$$o localizado.",Exclamation!)
		
	Case -1
		Sqlca.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do cliente")
		Return False
		
End Choose

Return True
end function

public function boolean of_existe_cpf_cgc (string as_cpf_cgc, ref boolean ab_existe);Long lvl_Total

Select count(*) Into :lvl_Total
From cliente
Where nr_cpf_cgc = :as_CPF_CGC
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Verifica$$HEX2$$e700e300$$ENDHEX$$o da Exist$$HEX1$$ea00$$ENDHEX$$ncia do CPF/CNPJ '" + as_CPF_CGC + "'")
	Return False
End If

If IsNull(lvl_Total) Then lvl_Total = 0

If lvl_Total = 0 Then
	ab_Existe = False
Else
	ab_Existe = True
End If

Return True
end function

public function boolean of_de_para_pontuacao_clube (string as_cliente_de, string as_cliente_para);w_Aguarde.Title = "Atualizando Pontua$$HEX2$$e700e300$$ENDHEX$$o Clube..."
	
// Inclui os movimentos de contas a receber no credi$$HEX1$$e100$$ENDHEX$$rio PARA
Insert Into pontuacao_clube_movimento (cd_cliente,   
												   dh_movimento,   
													cd_tipo_movimento,   
													vl_movimento,   
													qt_pontos,   
													cd_filial,
													nr_cartao_clube,   
													cd_dependente_cliente,
													nr_documento,   
													de_historico,
													qt_saldo_pontos,
													id_situacao_pontos) 
Select :as_Cliente_Para,
		 dh_movimento,   
		 cd_tipo_movimento,   
	 	 vl_movimento,   
		 qt_saldo_pontos,
		 cd_filial,
		 null,   
		 null,
		 nr_documento,   
		 de_historico,
		 qt_saldo_pontos,
		 id_situacao_pontos
From  pontuacao_clube_movimento
Where cd_cliente = :as_Cliente_De
and   qt_saldo_pontos > 0
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Inclus$$HEX1$$e300$$ENDHEX$$o dos Movimentos de Pontua$$HEX2$$e700e300$$ENDHEX$$o Clube PARA")
	Return False
End If

// Exclui os movimentos de pontuacao clube utilizacao DE
Delete From pontuacao_clube_utilizacao
where nr_movimento_utilizacao in (select nr_movimento
											 from pontuacao_clube_movimento
											 Where cd_cliente = :as_Cliente_De)
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Exclus$$HEX1$$e300$$ENDHEX$$o dos Movimentos de Pontua$$HEX2$$e700e300$$ENDHEX$$o Clube Utilizacao DE")
	Return False
End If

// Exclui os movimentos de pontuacao clube DE
Delete From pontuacao_clube_movimento
Where cd_cliente = :as_Cliente_De
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Exclus$$HEX1$$e300$$ENDHEX$$o dos Movimentos de Pontua$$HEX2$$e700e300$$ENDHEX$$o Clube DE")
	Return False
End If

// Exclui os saldos de pontuacao clube DE
Delete From pontuacao_clube_saldo
Where cd_cliente  = :as_Cliente_De
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Exclus$$HEX1$$e300$$ENDHEX$$o dos Saldos de Pontua$$HEX2$$e700e300$$ENDHEX$$o Clube DE")
	Return False
End If

Return True
end function

public function boolean of_saldo_pontuacao_cliente (string as_cliente, date adt_data_inicial, ref decimal adc_pontuacao);Date lvdt_Saldo

Integer lvi_Mes, &
		  lvi_Ano

lvi_Mes = Month(adt_Data_Inicial)
lvi_Ano = Year(adt_Data_Inicial)

lvi_Mes = lvi_Mes - 1

If lvi_Mes = 0 Then
	lvi_Mes = 12
	lvi_Ano = lvi_Ano -1
End If

lvdt_Saldo = Date("01/" + String(lvi_Mes, "00") + "/" + String(lvi_Ano))
	
Select qt_pontos
Into :adc_pontuacao
From pontuacao_clube_saldo
Where cd_cliente = :as_cliente
  and dh_saldo   = :lvdt_Saldo
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do saldo do cliente do clube")
	Return False
End If

If SqlCa.SqlCode = 100 Then
	adc_pontuacao = 0
End If
	
Return True
end function

public function boolean of_de_para_recibo_resgate_clube (string ps_cliente_de, string ps_cliente_para);w_Aguarde.Title = "Atualizando Recibo Resgate..."

Update recibo_resgate_clube
Set cd_cliente            = :ps_Cliente_Para,
    nr_cartao_clube       = null,
    cd_dependente_cliente = null
Where cd_cliente = :ps_Cliente_De
Using SqlCa;
  
If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o Recibo Resgate")
	Return False
Else
	Return True
End If
end function

public function boolean of_de_para_cartao_clube (string ps_cliente_de, string ps_cliente_para, datetime pdh_bloqueio, string ps_usuario, long pl_filial);w_Aguarde.Title = "Atualizando Cart$$HEX1$$e300$$ENDHEX$$o Clube..."

Update cartao_clube
Set cd_cliente            = :ps_Cliente_Para,
    cd_dependente_cliente = null,
    dh_bloqueio           = :pdh_bloqueio,
	 cd_motivo_bloqueio    = 7,
	 cd_filial_bloqueio    = :pl_filial,
	 nr_matricula_bloqueio = :ps_usuario
Where cd_cliente = :ps_Cliente_De
Using SqlCa;
  
If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o Cart$$HEX1$$e300$$ENDHEX$$o Clube")
	Return False
Else
	Return True
End If
end function

public function boolean of_de_para_historico_negociacao (string ps_cliente_de, string ps_cliente_para);Long lvl_Ultimo_Historico, &
     lvl_Contador

w_Aguarde.Title = "Atualizando Hist$$HEX1$$f300$$ENDHEX$$rico Negocia$$HEX2$$e700e300$$ENDHEX$$o..."

Select max(nr_historico) Into :lvl_Ultimo_Historico
From historico_negociacao_cliente
Where cd_cliente = :ps_Cliente_Para
Using SqlCa;

If SqlCa.Sqlcode = -1 Then
	SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o dos hist$$HEX1$$f300$$ENDHEX$$ricos de negocia$$HEX2$$e700e300$$ENDHEX$$o do cliente para.")
	Return False
End If

If isnull(lvl_Ultimo_Historico) Then
  	lvl_Ultimo_Historico = 0
End If

Update historico_negociacao_cliente 
set cd_cliente   = :ps_Cliente_Para,
    nr_historico = nr_historico + :lvl_Ultimo_Historico  
Where cd_cliente = :ps_Cliente_De
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Altera$$HEX2$$e700e300$$ENDHEX$$o do historico de negocia$$HEX2$$e700e300$$ENDHEX$$o do cliente para.")
	Return False
End If

Return True
end function

public function boolean of_vencimento_conta (string as_cliente, date adt_movimento, ref date adt_vencimento);Integer lvi_Dia_Vencimento, &
        lvi_Dia_Base, &
		  lvi_Mes_Base, &
		  lvi_Ano_Base, &
		  lvi_Melhor_Dia
		  
Date lvdt_Melhor_Dia

// Localiza o dia de vencimento da conta do cliente
Select nr_dia_vencimento Into :lvi_Dia_Vencimento
From cliente
Where cd_cliente = :as_Cliente
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If IsNull(lvi_Dia_Vencimento) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Dia de vencimento da conta do cliente '" + as_Cliente + "' n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ informado.")
			Return False
		End If

		lvi_Dia_Base = Day(adt_Movimento)
		lvi_Mes_Base = Month(adt_Movimento)
		lvi_Ano_Base = Year(adt_Movimento)
		
		If lvi_Dia_Vencimento <= lvi_Dia_Base Then
			If lvi_Mes_Base = 12 Then
				lvi_Mes_Base = 1
				lvi_Ano_Base ++
			Else
				lvi_Mes_Base ++
			End If
		End If		

		// Determina a data de vencimento
		If lvi_Mes_Base = 2 And lvi_Dia_Vencimento = 30 Then
			adt_Vencimento = RelativeDate(Date(String(lvi_Ano_Base) + "/03/01"), -1)
		Else
			adt_Vencimento = Date(String(lvi_Dia_Vencimento, "00") + "/" + &
										 String(lvi_Mes_Base, "00") + "/" + &
										 String(lvi_Ano_Base, "0000"))			
		End If
		
		// Determina o melhor dia de compra
		Choose Case lvi_Dia_Vencimento
			Case  5 ; lvi_Melhor_Dia = 26
			Case 10 ; lvi_Melhor_Dia =  1
			Case 15 ; lvi_Melhor_Dia =  6
			Case 20 ; lvi_Melhor_Dia = 11
			Case 25 ; lvi_Melhor_Dia = 16
			Case 30 ; lvi_Melhor_Dia = 21				
		End Choose
		
		If lvi_Dia_Vencimento = 5 Then
			If Not gf_DateAdd(adt_Vencimento, "month", -1, ref lvdt_Melhor_Dia) Then Return False
			
			lvdt_Melhor_Dia = Date(String(lvi_Melhor_Dia) + "/" + String(lvdt_Melhor_Dia, "mm/yyyy"))
		Else
			lvdt_Melhor_Dia = Date(String(lvi_Melhor_Dia) + "/" + String(adt_Vencimento, "mm/yyyy"))
		End If
		
		// Se a data do movimento for maior ou igual ao melhor dia, passa o vencimento para um m$$HEX1$$ea00$$ENDHEX$$s depois
		If adt_Movimento >= lvdt_Melhor_Dia Then
			If Not gf_DateAdd(adt_Vencimento, "month", 1, ref adt_Vencimento) Then Return False
			
			// 28 ou 29/02 para 30/03
			If lvi_Mes_Base = 2 And lvi_Dia_Vencimento = 30 Then
				adt_Vencimento = Date("30/" + String(adt_Vencimento, "mm/yyyy"))
			End If
		End If
		
		Return True
		
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Dia de vencimento da conta do cliente '" + as_Cliente + "' n$$HEX1$$e300$$ENDHEX$$o localizada.")
		Return False
		
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Dia de Vencimento da Conta do Cliente '" + as_Cliente + "'")
		Return False
End Choose
end function

public subroutine of_localiza_cliente (string ps_parametro, string as_identificador);Integer lvi_Tamanho

This.Localizado = False

ps_Parametro = Trim(ps_Parametro)

lvi_Tamanho = LenA(ps_Parametro)

// Verifica se foi recebido algum par$$HEX1$$e200$$ENDHEX$$metro
If lvi_Tamanho > 0 Then		
	// Verifica o tipo do par$$HEX1$$e200$$ENDHEX$$metro recebido	
	If IsNumber(ps_Parametro) Then
		
		If as_identificador = 'CC' Then
			of_Localiza_Cartao(ps_Parametro)
			Return
		End If
	
		If as_identificador = 'CPF' Then
			of_Localiza_CPF(ps_Parametro)
			Return
		End If
		
		If as_identificador = 'RG' Then
			of_Localiza_RG(ps_Parametro)
			Return
		End If
		
	Else	
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe um par$$HEX1$$e200$$ENDHEX$$metro de localiza$$HEX2$$e700e300$$ENDHEX$$o correto.",Exclamation!)
	End If	
Else	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe um par$$HEX1$$e200$$ENDHEX$$metro de localiza$$HEX2$$e700e300$$ENDHEX$$o correto.",Exclamation!)
End If
end subroutine

public subroutine of_localiza_cliente (string ps_parametro);Integer lvi_Tamanho

This.Localizado = False

ps_Parametro = Trim(ps_Parametro)

lvi_Tamanho = LenA(ps_Parametro)

// Verifica se foi recebido algum par$$HEX1$$e200$$ENDHEX$$metro
If lvi_Tamanho > 0 Then		
	// Verifica o tipo do par$$HEX1$$e200$$ENDHEX$$metro recebido	
	If IsNumber(ps_Parametro) Then
		If lvi_Tamanho = 14 Then
			
			If gf_CGC_Valido( ps_Parametro, ib_Mostra_MSG_CNPJ_Invalido ) Then
				This.of_Localiza_CPF(ps_Parametro)
			Else			
				ps_Parametro = LeftA(ps_Parametro, 13)
				lvi_Tamanho = 13
			End If
		End If
		
		If lvi_Tamanho = 13 Then
			of_Localiza_Cartao(ps_Parametro)
		End If	
		
		//Se o tamanho for 10, pode ser c$$HEX1$$f300$$ENDHEX$$digo cliente SAP
		If lvi_Tamanho = 10 Then
			If This.Of_Localiza_Cliente_SAP(ps_Parametro, False) Then Return
		End If
		
		// Se o tamanho for 12, quer dizer que a leitura foi feita pelo leitor $$HEX1$$f300$$ENDHEX$$ptico
		// O $$HEX1$$fa00$$ENDHEX$$ltimo n$$HEX1$$fa00$$ENDHEX$$mero ser$$HEX1$$e100$$ENDHEX$$ desconsiderado na procura
		If lvi_Tamanho = 12 Then
			ps_Parametro = LeftA(ps_Parametro, 11)
		End If
		
		If Not This.Localizado Then
			// Localiza$$HEX2$$e700e300$$ENDHEX$$o direta pelo c$$HEX1$$f300$$ENDHEX$$digo do cliente
			of_Localiza_Codigo(ps_Parametro)
		End If	
		
		If Not This.Localizado Then
			// Se n$$HEX1$$e300$$ENDHEX$$o localizar pelos m$$HEX1$$e900$$ENDHEX$$todos anteriores
			// Abre a janela de localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica
			of_Localiza_Generica(ps_Parametro)	
		End If
	Elseif lvi_Tamanho = 14 Then
		if Match(ps_Parametro, "[0-9]") then //Verifica se $$HEX1$$e900$$ENDHEX$$ CNPJ alfanumerico.
			If gf_CGC_Valido( ps_Parametro, ib_Mostra_MSG_CNPJ_Invalido ) Then 
				This.of_Localiza_CPF(ps_Parametro)
			else
				of_Localiza_Generica(ps_Parametro)	
			end if
		else
			// Localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica conforme o nome do cliente
			of_Localiza_Generica(ps_Parametro)	
		end if
	else
		// Localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica conforme o nome do cliente
		of_Localiza_Generica(ps_Parametro)
	End If	
Else	
	// Localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica sem par$$HEX1$$e200$$ENDHEX$$metros
	of_Localiza_Generica("")
End If
end subroutine

public subroutine of_localiza_cpf (string ps_cpf);This.of_Localiza_Cpf( ps_Cpf, True )
end subroutine

public subroutine of_localiza_rg (string ps_rg);String lvs_Criptografada

Select cl.cd_cliente,
       	 cl.nm_cliente,
		 cl.nm_social,
		 cl.id_tipo_cliente,
		 cl.id_fisica_juridica,
		 cl.nr_cpf_cgc,
		 ci.cd_unidade_federacao,
		 cl.de_endereco,
		 cl.de_bairro,
		 cl.cd_cidade,
		 ci.nm_cidade, 
		 cl.nr_cep,
		 cl.nr_ddd_fone_residencial, 
          cl.nr_fone_residencial,
		 cl.nr_inscricao_estadual,
		 cl.cd_filial_centralizadora,
		 cl.nr_dia_vencimento,
		 cl.de_senha_venda_credito,
		 cl.id_senha_criptografada,
		 cl.de_hash_senha
Into :cd_cliente,
     :nm_cliente,
	  :nm_social,
	  :id_tipo_cliente,
	  :id_fisica_juridica,
	  :nr_cpf_cgc,
	  :cd_unidade_federacao,
	  :de_endereco,
	  :de_bairro,
	  :cd_cidade,
	  :nm_cidade,
	  :nr_cep,
	  :nr_ddd_fone,
	  :nr_fone,
	  :nr_inscricao_estadual,
	  :cd_filial_centralizadora,
	  :nr_dia_vencimento,
	  :de_senha_cliente,
	  :lvs_Criptografada,
	  :de_hash_senha
From cliente AS cl
		LEFT OUTER JOIN cidade As ci
			ON ci.cd_cidade = cl.cd_cidade
Where cl.nr_rg = :ps_rg
Using SqlCa;

Senha_Criptograda = (lvs_Criptografada = 'S')

Choose Case SqlCa.SqlCode
	Case 0	
		SetNull(Cd_Dependente)
		nm_dependente = ""
		Localizado = True
		
		If Not IsNull(This.nm_Social) And Trim(This.nm_Social) <> "" Then
			This.Nm_Cliente = This.Nm_Social
		End If
		
		// Verifica o tipo do cliente selecionado
		If This.ivs_Tipo_Cliente <> "" Then
			Choose Case This.ivs_Tipo_Cliente
				Case "CR", "RC", "CC"
					If This.Id_Tipo_Cliente <> This.ivs_Tipo_Cliente Then						
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tipo do cliente '" + This.Id_Tipo_Cliente + "' diferente do determinado '" + This.ivs_Tipo_Cliente + "'.", Information!)
						Localizado = False
					End If
					
				Case "CL"
					If This.Id_Tipo_Cliente <> "RC" and This.Id_Tipo_Cliente <> "CC" Then						
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tipo do cliente '" + This.Id_Tipo_Cliente + "' diferente do determinado '" + This.ivs_Tipo_Cliente + "'.", Information!)
						Localizado = False
					End If					
			End Choose
		End If
		
		// Verifica o tipo de pessoa (F$$HEX1$$ed00$$ENDHEX$$sica ou Jur$$HEX1$$ed00$$ENDHEX$$dica)
		If This.ivs_Fisica_Juridica <> "" Then
			If This.Id_Fisica_Juridica <> This.ivs_Fisica_Juridica Then
				If This.ivs_Fisica_Juridica = "F" Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O cliente n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ pessoa f$$HEX1$$ed00$$ENDHEX$$sica.", Information!)
				Else
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O cliente n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ pessoa jur$$HEX1$$ed00$$ENDHEX$$dica.", Information!)
				End If
				
				Localizado = False
			End If
		End If
		
	Case 100
		Localizado = False
		
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","RG n$$HEX1$$fa00$$ENDHEX$$mero '" + ps_rg + "' n$$HEX1$$e300$$ENDHEX$$o localizado.",Exclamation!)
		
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Cliente RG : '" + ps_rg + "'")
		Localizado = False		
End Choose
end subroutine

public function boolean of_verifica_bloqueio_matriz (string as_cliente, string as_dependente, string as_tipo_venda, ref string as_matricula);Boolean lb_Bloqueado
Boolean lb_Sucesso
Boolean lb_Liberacao

String ls_SQL,&
		 ls_SQL1,&
       ls_SQL2,&
		 ls_Select
		 
String ls_Banco		 
String ls_Retorno
String ls_Erro
String ls_Sintaxe

Long	 ll_Row

ls_Select =  	"select b.id_tipo_bloqueio as id_tipo_bloqueio," 			+ CharA(13) + CharA(10) + &
					"       b.cd_motivo_bloqueio as cd_motivo_bloqueio," 	+ CharA(13) + CharA(10) + &
					"       m.de_motivo_bloqueio as de_motivo_bloqueio," 	+ CharA(13) + CharA(10) + &
					"       m.id_permite_liberacao as id_permite_liberacao" + CharA(13) + CharA(10) + &
					"  from bloqueio b, motivo_bloqueio m" 						+ CharA(13) + CharA(10) + &
					" where m.cd_motivo_bloqueio = b.cd_motivo_bloqueio and b.dh_liberacao is null" + CharA(13) + CharA(10) + &
					"   and b.cd_cliente = '" + as_Cliente + "'" + CharA(13) + CharA(10)

// Altera o SQL para sele$$HEX2$$e700e300$$ENDHEX$$o dos bloqueios do cliente
Choose Case as_Tipo_Venda
	Case "CR"
		ls_SQL1 = ls_Select + " and b.id_tipo_bloqueio in ('CLI', 'CRE')"
	Case "CC"
		ls_SQL1 = ls_Select + " and b.id_tipo_bloqueio in ('CLI', 'CCO')"
	Case Else
		ls_SQL1 = ls_Select + " and b.id_tipo_bloqueio = 'CLI'"
End Choose

// Altera o SQL para sele$$HEX2$$e700e300$$ENDHEX$$o dos bloqueios do dependente do cliente
If Not IsNull(as_Dependente) Then

	ls_SQL2 = ls_Select + " and b.id_tipo_bloqueio = 'DEP' and b.cd_cliente_dependente = '" + as_Dependente + "'"
	
End If
			  
If Not IsNull(as_Dependente) Then
	ls_SQL = ls_SQL1 + CharA(13) + CharA(10) + "UNION" + CharA(13) + CharA(10) + ls_SQL2
Else
	ls_SQL = ls_SQL1 + CharA(13) + CharA(10)
End If

// Determina a sintaxe para cria$$HEX2$$e700e300$$ENDHEX$$o da datawindow
ls_Sintaxe = SqlCa.SyntaxFromSQL(ls_SQL, "Style(Type=Grid)", ls_Erro)

// Cria a datastore
DataStore lvds_1
lvds_1 = Create DataStore

lvds_1.Create(ls_Sintaxe, ls_Erro)

If Trim(ls_Erro) <> "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na cria$$HEX2$$e700e300$$ENDHEX$$o da datastore para consulta dos bloqueios.")
	Return False
End If

uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao()

lvo_Conexao.of_executa_Rotina('00006',{ls_SQL})

If lvo_Conexao.of_Erro_Execucao() Then lvo_Conexao.of_MsgError("Localiza$$HEX2$$e700e300$$ENDHEX$$o de bloqueios do Cliente")

If Not ( lvo_Conexao.of_Erro_Conexao() or lvo_Conexao.of_Erro_Execucao() ) Then	//Caso ocorra erro de conex$$HEX1$$e300$$ENDHEX$$o ou erro de execu$$HEX2$$e700e300$$ENDHEX$$o no servidor Linux

	If Not lvo_Conexao.of_Retorno(Ref lvds_1) Then
		lb_Sucesso = False
	Else	
					
		ls_Banco = "Banco Matriz"
		
		lb_Sucesso = True
		
		If lvds_1.RowCount() > 0 Then
			lb_Bloqueado = True
		Else
			lb_Bloqueado = False
		End If
		
	End If	
	
Else
	
	ls_Banco   = "Banco Local"
	
	lvds_1.SetTransObject(SqlCa)
				
	If lvds_1.Retrieve() = -1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na consulta dos bloqueios no banco de dados local.")
		lb_Sucesso = False
	Else
	
		lb_Sucesso = True
		
		If lvds_1.RowCount() > 0 Then
			lb_Bloqueado = True
		Else
			lb_Bloqueado = False
		End If
		
	End If	
	
End If	

// Verifica se conseguiu consultar na matriz ou na loja
If lb_Sucesso Then
	
	If lvds_1.RowCount() > 0 Then
	
		lb_Liberacao = True									// Bloqueado com permiss$$HEX1$$e300$$ENDHEX$$o para libera$$HEX2$$e700e300$$ENDHEX$$o
		
		For ll_Row = 1 To lvds_1.RowCount()
			If lvds_1.object.id_permite_liberacao[ll_Row] = "N" Then
				lb_Liberacao = False							// Bloqueado sem permiss$$HEX1$$e300$$ENDHEX$$o para libera$$HEX2$$e700e300$$ENDHEX$$o
				Exit
			End If						
		Next
	
	End If
	
	If lb_Bloqueado Then

		If lb_Liberacao Then
			If gvo_Aplicacao.ivo_seguranca.cd_sistema = 'CL' Then
				OpenWithParm(w_ge002_bloqueio_paf,'0')
			Else
				OpenWithParm(w_ge002_bloqueio,'0')				
			End If
		Else
			If gvo_Aplicacao.ivo_seguranca.cd_sistema = 'CL' Then			
				OpenWithParm(w_ge002_bloqueio_paf,'100')
			Else
				OpenWithParm(w_ge002_bloqueio,'100')				
			End If
		End If	
			
		Choose Case Message.StringParm
			Case "CANCELAR"
				lb_Bloqueado = True
			Case "DETALHES"
				
				uo_ge002_Parametro_Controle_Bloqueio lvo_Parametro
				lvo_Parametro = Create uo_ge002_Parametro_Controle_Bloqueio
				
				lvo_Parametro.ivds_1 = lvds_1
				
				lvo_Parametro.ivs_Banco = ls_Banco
				
				If gvo_Aplicacao.ivo_seguranca.cd_sistema = 'CL' Then
					OpenWithParm(w_ge002_Lista_Bloqueio_Paf, lvo_Parametro)
				Else
					OpenWithParm(w_ge002_Lista_Bloqueio, lvo_Parametro)					
				End If
				
				ls_Retorno = Message.StringParm
		
				If IsNull(ls_Retorno) Then
					lb_Bloqueado = True
				Else
					lb_Bloqueado = False
					
					as_Matricula = ls_Retorno
				End If
				
				Destroy(lvo_Parametro)		

			Case "LIBERAR"
				If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("LIBERACAO_BLOQUEIO_CLIENTE", ref as_matricula) Then 
					lb_Bloqueado = True
				Else
					lb_Bloqueado = False
				End If
		End Choose
			
	End If
	
Else
	lb_Bloqueado = True
End If

Destroy(lvo_Conexao)

Return lb_Bloqueado
end function

public subroutine of_localiza_cpf (string ps_cpf, boolean pb_messagebox);String lvs_Criptografada

Select	cl.cd_cliente,
		cl.nm_cliente,
		cl.nm_social,
		cl.nm_razao_social,
		cl.id_tipo_cliente,
		cl.id_fisica_juridica,
		cl.nr_cpf_cgc,
		ci.cd_unidade_federacao,
		cl.de_endereco,
		cl.nr_endereco,
		cl.de_bairro,
		cl.cd_cidade,
		ci.nm_cidade,
		ci.cd_unidade_federacao,
		cl.nr_cep,
		cl.nr_ddd_fone_residencial,
		cl.nr_fone_residencial,
		cl.nr_ddd_celular,
		cl.nr_celular,
		cl.nr_ddd_fone_comercial,
		cl.nr_fone_comercial,		
		cl.nr_inscricao_estadual,
		cl.cd_filial_centralizadora,
		cl.nr_dia_vencimento,
		cl.de_senha_venda_credito,
		cl.id_senha_criptografada,
		cl.nr_rg,
		cl.de_orgao_emissor_rg,
		cl.cd_uf_emissor_rg,
		cl.de_endereco_email_envio_xml,
		id_sexo,
		dh_nascimento,
		nm_conjuge,
		Coalesce(cl.id_falecido, 'N'),
		cl.dh_inclusao,
		cl.de_complemento,
		cl.de_endereco_email,
		cl.de_hash_senha,
		cl.cd_tipo_nf_sucata
Into	:cd_cliente,
		:nm_cliente,
		:nm_social,
		:nm_razao_social,
		:id_tipo_cliente,
		:id_fisica_juridica,
		:nr_cpf_cgc,
		:cd_unidade_federacao,
		:de_endereco,
		:nr_endereco,
		:de_bairro,
		:cd_cidade,
		:nm_cidade,
		:cd_uf,
		:nr_cep,
		:nr_ddd_fone,
		:nr_fone,
		:nr_ddd_celular,
		:nr_fone_celular,
		:nr_ddd_comercial,
		:nr_fone_comercial,		
		:nr_inscricao_estadual,
		:cd_filial_centralizadora,
		:nr_dia_vencimento,
		:de_senha_cliente,
		:lvs_Criptografada,
		:nr_rg,
		:de_Orgao_Emissor_Rg,
		:cd_uf_emissor_rg,
		:de_endereco_email_envio_xml,
		:id_sexo,
		:dh_Nascimento,
		:nm_conjuge,
		:id_falecido,
		:dh_inclusao,
		:de_complemento,
		:de_email,
		:de_hash_senha,
		:cd_tipo_nf_sucata
From	cliente cl
		LEFT OUTER JOIN	cidade ci
		   ON cl.cd_cidade = ci.cd_cidade
Where cl.nr_cpf_cgc = :ps_cpf
	and cl.dh_inclusao = ( select min(dh_inclusao) from cliente where nr_cpf_cgc = :ps_cpf )
Using SqlCa;

This.Senha_Criptograda 	= (lvs_Criptografada = 'S')
This.Falecido				= (This.id_falecido ='S')
This.ivs_Tipo_Cliente		= This.id_Tipo_Cliente

Choose Case SqlCa.SqlCode
	Case 0	
		SetNull(Cd_Dependente)
		nm_dependente = ""
		Localizado = True
		
		If Not IsNull(This.nm_Social) And Trim(This.nm_Social) <> "" Then
			This.Nm_Cliente = This.Nm_Social
		End If

		// Verifica o tipo do cliente selecionado
		If This.ivs_Tipo_Cliente <> "" Then
			Choose Case This.ivs_Tipo_Cliente
				Case "CR", "RC", "CC"
					If This.Id_Tipo_Cliente <> This.ivs_Tipo_Cliente Then
						If pb_MessageBox Then
							MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tipo do cliente '" + This.Id_Tipo_Cliente + "' diferente do determinado '" + This.ivs_Tipo_Cliente + "'.", Information!)
						End If
						Localizado = False
					End If
					
				Case "CL"
					If This.Id_Tipo_Cliente <> "RC" and This.Id_Tipo_Cliente <> "CC" Then						
						If pb_MessageBox Then
							MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tipo do cliente '" + This.Id_Tipo_Cliente + "' diferente do determinado '" + This.ivs_Tipo_Cliente + "'.", Information!)
						End If
						Localizado = False
					End If					
			End Choose
		End If
		
		// Verifica o tipo de pessoa (F$$HEX1$$ed00$$ENDHEX$$sica ou Jur$$HEX1$$ed00$$ENDHEX$$dica)
		If This.ivs_Fisica_Juridica <> "" Then
			If This.Id_Fisica_Juridica <> This.ivs_Fisica_Juridica Then
				If pb_MessageBox Then
					If This.ivs_Fisica_Juridica = "F" Then
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O cliente n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ pessoa f$$HEX1$$ed00$$ENDHEX$$sica.", Information!)
					Else
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O cliente n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ pessoa jur$$HEX1$$ed00$$ENDHEX$$dica.", Information!)
					End If
				End If
				
				Localizado = False
			End If
		End If
				
	Case 100
		Localizado = False
		
		If pb_MessageBox Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","CPF/CNPJ n$$HEX1$$fa00$$ENDHEX$$mero '" + ps_cpf + "' n$$HEX1$$e300$$ENDHEX$$o localizado.",Exclamation!)
		End If
		
	Case -1
		If pb_MessageBox Then
			SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Cliente CPF/CNPJ : '" + ps_cpf + "'")
		End If
		Localizado = False		
End Choose
end subroutine

public function boolean of_de_para_cliente_caixa (string ps_cliente_de, string ps_cliente_para);w_Aguarde.Title = "Exclus$$HEX1$$e300$$ENDHEX$$o Cliente Caixa..."

update cliente_caixa set cd_cliente = :ps_cliente_para
where cd_cliente = :ps_Cliente_De
Using SqlCa;


If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Exclus$$HEX1$$e300$$ENDHEX$$o Cliente Caixa")
	Return False
End If

Return True
end function

public function boolean of_proximo_codigo (long al_filial, ref string as_codigo, boolean pb_matriz);Boolean lvb_Sucesso = True

String lvs_Ultimo, ls_Ultimo_Cliente_Parametro

Long lvl_Ultimo

SetNull( as_Codigo )

If Not pb_Matriz Then // Caso seja filial
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Fun$$HEX2$$e700e300$$ENDHEX$$o desabilitada!~ruo_cliente.of_proximo_codigo( long, ref string, boolean", StopSign! )
	Return False
Else // Matriz
	
	Select vl_parametro Into :ls_Ultimo_Cliente_Parametro
	From parametro_geral
	Where cd_parametro = 'CD_CLIENTE'
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			If Not This.of_proximo_cliente(al_filial, Ref as_codigo) Then Return False
		Case 100
			// Se n$$HEX1$$e300$$ENDHEX$$o existir o parametro mant$$HEX1$$e900$$ENDHEX$$m do jeito que esta
			Select max(cd_cliente) Into :lvs_Ultimo
			From  cliente
			Where cd_filial_inclusao = :al_Filial
			Using SqlCa;
			
			Choose Case SqlCa.SqlCode
				Case 0
					If IsNull(lvs_Ultimo) Then 
						lvl_Ultimo = 0
					Else
						lvl_Ultimo = Long(MidA(lvs_Ultimo, 5))
					End If
					
					as_Codigo = String(al_Filial, "0000") + String(lvl_Ultimo + 1, "0000000")
					
				Case 100
					as_Codigo = String(al_Filial, "0000") + "0000001"
					
				Case -1
					SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Pr$$HEX1$$f300$$ENDHEX$$ximo C$$HEX1$$f300$$ENDHEX$$digo do Cliente para Filial '" + String(al_Filial) + "'")
					lvb_Sucesso = False
			End Choose
			//
		Case -1
			SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro [CD_CLIENTE] para Filial '" + String(al_Filial) + "'")
			lvb_Sucesso = False
	End Choose
	
End If

Return lvb_Sucesso
end function

public function boolean of_de_para_campanha_cliente (string ps_cliente_de, string ps_cliente_para);w_Aguarde.Title = "Atualizando Campanha Cliente..."

Update campanha_cliente
Set cd_cliente		= :ps_Cliente_Para
Where cd_cliente	= :ps_Cliente_De
Using SqlCa;
  
If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o campanha_cliente")
	Return False
Else
	Return True
End If
end function

public function boolean of_insere_bloqueio (long pl_filial, string ps_tipo_bloqueio, string ps_motivo_bloqueio, string ps_cliente, datetime pdh_data_bloqueio, string ps_usuario);Long lvl_Bloqueio

lvl_Bloqueio = This.of_Proximo_Bloqueio(pl_Filial)

Insert Into bloqueio (cd_filial,   
						    nr_bloqueio,   
						    id_tipo_bloqueio,   
						    cd_motivo_bloqueio,   
						    dh_bloqueio,   
						    nr_matricula_bloqueio,   
						    cd_cliente,   
						    cd_clube_cliente,   
						    cd_convenio,   
						    cd_conveniado,   
						    cd_dependente,   
						    dh_liberacao,   
						    nr_matricula_liberacao)
Values (:pl_Filial,   
		  :lvl_Bloqueio,   
		  :ps_Tipo_Bloqueio,   
		  :ps_Motivo_Bloqueio,
		  :pdh_Data_Bloqueio,   
		  :ps_Usuario,   
		  :ps_Cliente,   
		  null,   
		  null,   
		  null,   
		  null,   
		  null,   
		  null)
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Inclus$$HEX1$$e300$$ENDHEX$$o do bloqueio do cliente.")
	Return False
Else
	Return True
End If
end function

public subroutine of_appendwhere_nome_cliente (dc_uo_dw_base pdw_base, string ps_nome);Long ll_Versao

If SqlCa.of_Dbms_Name( ) = 'POSTGRESQL' Then
	pdw_Base.of_AppendWhere( "nm_cliente_sem_acento like remove_acento( '" + ps_nome + "%' )")
	Return
End If

pdw_Base.of_AppendWhere( "nm_cliente like '" + ps_nome + "%'" )
end subroutine

public function boolean of_de_para_historico_categoria (string ps_cliente_de, string ps_cliente_para); Long lvl_Ultimo_Historico, &
     lvl_Contador

w_Aguarde.Title = "Atualizando Hist$$HEX1$$f300$$ENDHEX$$rico Categoria..."

Delete
From cliente_categoria_historico
Where cd_cliente = :ps_Cliente_Para
Using SqlCa;

If SqlCa.Sqlcode = -1 Then
	SqlCa.of_MsgdbError("Exclus$$HEX1$$e300$$ENDHEX$$o do hist$$HEX1$$f300$$ENDHEX$$rico da categoria do cliente para.")
	Return False
End If

Update cliente_categoria_historico 
set cd_cliente = :ps_Cliente_Para
Where cd_cliente = :ps_Cliente_De
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Altera$$HEX2$$e700e300$$ENDHEX$$o do hist$$HEX1$$f300$$ENDHEX$$rico da categoria do cliente para.")
	Return False
End If

Return True
end function

public subroutine of_localiza_cnpj ();
end subroutine

public function boolean of_possui_reserva_produto ();//-----------------------------------
// RESERVA VIGENTE OU EXPIRADA
//-----------------------------------

Integer li_contador

If Not This.Localizado Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Cliente n$$HEX1$$e300$$ENDHEX$$o localizado.")
	Return False
End If

If gvo_Parametro.Cd_Filial <> gvo_Parametro.cd_Filial_Matriz Then
		
	select count( nr_sequencial )
	into :li_contador
	from cliente_caixa c
	where cd_cliente 		= :This.Cd_Cliente
	and id_tipo 				= 'R'
	and id_situacao 		in ('T', 'R')
	and ( ( dbo.uf_dh_parametro() between dh_inicio_reserva and dh_termino_reserva ) OR ( dh_termino_reserva <  dbo.uf_dh_parametro() ) )
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_msgDbError( "Erro ao localizar reserva do cliente " + This.Cd_Cliente )
		Return False
	End If
		
	Return ( li_Contador > 0 )
	
Else
	
	//Implementar na consulta na matriz
End If
end function

public function boolean of_proximo_cliente (long al_filial, ref string as_novo_codigo);Boolean lb_Sucesso = True

String ls_Ultimo_Codigo

Select coalesce(vl_parametro, '0')
Into :ls_Ultimo_Codigo
From parametro_geral
Where cd_parametro = 'CD_CLIENTE'
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do $$HEX1$$fa00$$ENDHEX$$ltimo C$$HEX1$$f300$$ENDHEX$$digo do Cliente para Filial '" + String(al_Filial) + "'")
	Return False
End If

If Not IsNumber(ls_Ultimo_Codigo) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "$$HEX1$$da00$$ENDHEX$$ltimo sequencial informado no par$$HEX1$$e200$$ENDHEX$$meto $$HEX1$$e900$$ENDHEX$$ inv$$HEX1$$e100$$ENDHEX$$lido.", StopSign!)
	Return False
End If

as_novo_codigo = String(Long(ls_Ultimo_Codigo) + 1)

Update parametro_geral
Set vl_parametro = :as_novo_codigo
Where cd_parametro = 'CD_CLIENTE'
  and vl_parametro = :ls_Ultimo_Codigo
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do Pr$$HEX1$$f300$$ENDHEX$$ximo C$$HEX1$$f300$$ENDHEX$$digo do Cliente para Filial '" + String(al_Filial) + "'")
	Return False
Else	
	If SqlCa.SqlnRows = 0 Then
		lb_Sucesso = of_proximo_cliente(al_Filial, as_novo_codigo)
	Else
		as_novo_codigo =String(al_Filial, "0000") + String(Long(as_novo_codigo), "0000000")
	End If
End If

Return lb_Sucesso
end function

public function boolean of_de_para_venda_pbm (string ps_cliente_de, string ps_cliente_para);w_Aguarde.Title = "Atualizando Venda PBM..."

Update venda_pbm
Set cd_cliente            = :ps_Cliente_Para
Where cd_cliente = :ps_Cliente_De
Using SqlCa;
  
If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o venda_pbm")
	Return False
Else
	Return True
End If
end function

public function boolean of_exclui_tipo_aviso_cliente_de (string ps_cliente_de);w_Aguarde.Title = "Atualizando Tipo Aviso Cliente..."

Delete From tipo_aviso_cliente
Where cd_cliente = :ps_Cliente_De
Using SqlCa;
  
If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na exclus$$HEX1$$e300$$ENDHEX$$o do tipo aviso cliente." + SqlCa.SqlErrText, StopSign!, Ok!)
	Return False
Else
	Return True
End If
end function

public function boolean of_localiza_cliente_sap (string ps_cliente_sap, boolean pb_messagebox);String lvs_Criptografada

//Cliente SAP $$HEX1$$e900$$ENDHEX$$ composto por 10 caracteres, num$$HEX1$$e900$$ENDHEX$$ricos
If Not IsNumber(ps_cliente_sap) or Len(ps_cliente_sap)<>10 Then Return False
//N$$HEX1$$e300$$ENDHEX$$o executar no sistema legado de loja (campo cd_cliente_sap n$$HEX1$$e300$$ENDHEX$$o existe)
If gvo_Aplicacao.ivo_seguranca.cd_sistema = 'RL' Then Return False
//Se for loja
If This.of_Filial_Parametro()<>534 Then Return False


Select	cl.cd_cliente,
		cl.nm_cliente,
		cl.nm_social,
		cl.nm_razao_social,
		cl.id_tipo_cliente,
		cl.id_fisica_juridica,
		cl.nr_cpf_cgc,
		ci.cd_unidade_federacao,
		cl.de_endereco,
		cl.nr_endereco,
		cl.de_bairro,
		cl.cd_cidade,
		ci.nm_cidade,
		ci.cd_unidade_federacao,
		cl.nr_cep,
		cl.nr_ddd_fone_residencial,
		cl.nr_fone_residencial,
		cl.nr_ddd_celular,
		cl.nr_celular,
		cl.nr_ddd_fone_comercial,
		cl.nr_fone_comercial,		
		cl.nr_inscricao_estadual,
		cl.cd_filial_centralizadora,
		cl.nr_dia_vencimento,
		cl.de_senha_venda_credito,
		cl.id_senha_criptografada,
		cl.nr_rg,
		cl.de_orgao_emissor_rg,
		cl.cd_uf_emissor_rg,
		cl.de_endereco_email_envio_xml,
		id_sexo,
		dh_nascimento,
		nm_conjuge,
		Coalesce(cl.id_falecido, 'N'),
		cl.dh_inclusao,
		cl.de_complemento,
		cl.de_endereco_email,
		cl.de_hash_senha,
		cl.cd_tipo_nf_sucata
Into	:cd_cliente,
		:nm_cliente,
		:nm_social,
		:nm_razao_social,
		:id_tipo_cliente,
		:id_fisica_juridica,
		:nr_cpf_cgc,
		:cd_unidade_federacao,
		:de_endereco,
		:nr_endereco,
		:de_bairro,
		:cd_cidade,
		:nm_cidade,
		:cd_uf,
		:nr_cep,
		:nr_ddd_fone,
		:nr_fone,
		:nr_ddd_celular,
		:nr_fone_celular,
		:nr_ddd_comercial,
		:nr_fone_comercial,		
		:nr_inscricao_estadual,
		:cd_filial_centralizadora,
		:nr_dia_vencimento,
		:de_senha_cliente,
		:lvs_Criptografada,
		:nr_rg,
		:de_Orgao_Emissor_Rg,
		:cd_uf_emissor_rg,
		:de_endereco_email_envio_xml,
		:id_sexo,
		:dh_Nascimento,
		:nm_conjuge,
		:id_falecido,
		:dh_inclusao,
		:de_complemento,
		:de_email,
		:de_hash_senha,
		:cd_tipo_nf_sucata
From	cliente cl
		LEFT OUTER JOIN	cidade ci
		   ON cl.cd_cidade = ci.cd_cidade
Where cl.cd_cliente_sap = :ps_cliente_sap
	and cl.dh_inclusao = ( select min(dh_inclusao) from cliente where cd_cliente_sap = :ps_cliente_sap )
Using SqlCa;

This.Senha_Criptograda 	= (lvs_Criptografada = 'S')
This.Falecido				= (This.id_falecido ='S')
This.ivs_Tipo_Cliente	= This.id_Tipo_Cliente

Choose Case SqlCa.SqlCode
	Case 0	
		SetNull(Cd_Dependente)
		nm_dependente = ""
		Localizado = True
		
		If Not IsNull(This.nm_Social) And Trim(This.nm_Social) <> "" Then
			This.Nm_Cliente = This.Nm_Social
		End If

		// Verifica o tipo do cliente selecionado
		If This.ivs_Tipo_Cliente <> "" Then
			Choose Case This.ivs_Tipo_Cliente
				Case "CR", "RC", "CC"
					If This.Id_Tipo_Cliente <> This.ivs_Tipo_Cliente Then
						If pb_MessageBox Then
							MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tipo do cliente '" + This.Id_Tipo_Cliente + "' diferente do determinado '" + This.ivs_Tipo_Cliente + "'.", Information!)
						End If
						Localizado = False
					End If
					
				Case "CL"
					If This.Id_Tipo_Cliente <> "RC" and This.Id_Tipo_Cliente <> "CC" Then						
						If pb_MessageBox Then
							MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tipo do cliente '" + This.Id_Tipo_Cliente + "' diferente do determinado '" + This.ivs_Tipo_Cliente + "'.", Information!)
						End If
						Localizado = False
					End If					
			End Choose
		End If
		
		// Verifica o tipo de pessoa (F$$HEX1$$ed00$$ENDHEX$$sica ou Jur$$HEX1$$ed00$$ENDHEX$$dica)
		If This.ivs_Fisica_Juridica <> "" Then
			If This.Id_Fisica_Juridica <> This.ivs_Fisica_Juridica Then
				If pb_MessageBox Then
					If This.ivs_Fisica_Juridica = "F" Then
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O cliente n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ pessoa f$$HEX1$$ed00$$ENDHEX$$sica.", Information!)
					Else
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O cliente n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ pessoa jur$$HEX1$$ed00$$ENDHEX$$dica.", Information!)
					End If
				End If
				
				Localizado = False
			End If
		End If
				
	Case 100
		Localizado = False
		
		If pb_MessageBox Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Cliente SAP '" + ps_cliente_sap + "' n$$HEX1$$e300$$ENDHEX$$o localizado.",Exclamation!)
		End If
		
	Case -1
		If pb_MessageBox Then
			SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Cliente SAP : '" + ps_cliente_sap + "'")
		End If
		Localizado = False		
End Choose

Return Localizado
end function

on uo_cliente.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_cliente.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;SetNull(This.cd_dependente)
end event

