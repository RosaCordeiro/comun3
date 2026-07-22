HA$PBExportHeader$uo_conveniado.sru
forward
global type uo_conveniado from nonvisualobject
end type
end forward

global type uo_conveniado from nonvisualobject
end type
global uo_conveniado uo_conveniado

type variables
Boolean	Localizado, &
			Senha_Criptografada = False, &
			ib_falha_consulta_distribuido = False  //Indica se ocorreu falha nas consultas do conveniado no distribuido.

Long cd_convenio

String	cd_conveniado, &
		cd_cliente,&
		nm_conveniado, &
		id_somente_titular, &
		id_obedece_restricao,&
		id_bloqueio_unimed, &
		nr_cpf, &
		id_sexo

String de_senha
String de_hash_senha
String de_email
String nr_fone

long ivl_filial_parametro, &
        ivl_filial_matriz

// Vari$$HEX1$$e100$$ENDHEX$$veis utilizadas na janela de sele$$HEX2$$e700e300$$ENDHEX$$o do conveniado
Long ivl_Convenio

String ivs_Matricula, &
          ivs_Nome, &
		 ivs_CPF

string ivs_bloqueio_conveniado_de_para = 'SI3'

Constant Long cd_convenio_trncentre = 52568

Constant Long cd_convenio_vidalink  = 52575

end variables

forward prototypes
public function boolean of_matricula (string ps_conveniado)
public subroutine of_localiza_conveniado (long pl_convenio, string ps_conveniado)
public subroutine of_localiza_codigo (long pl_convenio, string ps_conveniado)
public function boolean of_bloqueio_nao_visualizado (long pl_convenio, string ps_conveniado)
public function long of_proximo_codigo_dependente (string p_cd_conveniado, long p_cd_convenio)
public function long of_proximo_bloqueio (long pl_filial)
public function boolean of_de_para_nf_venda (long pl_convenio, string ps_conveniado_de, string ps_conveniado_para)
public function boolean of_de_para_nf_devolucao_venda (long pl_convenio, string ps_conveniado_de, string ps_conveniado_para)
public function boolean of_de_para_dependente_conveniado (long pl_convenio, string ps_conveniado_de, string ps_conveniado_para)
public function boolean of_exclui_conveniado_de (long pl_convenio, string ps_conveniado_de)
public function boolean of_insere_bloqueio_de_para (long pl_convenio, string ps_conveniado_de, datetime pdh_data_bloqueio, long pl_filial, string ps_usuario)
public function boolean of_exclui_bloqueio_de (long pl_convenio, string ps_conveniado_de)
public function boolean of_insere_conveniado_de_para (long pl_convenio, string ps_conveniado_de, string ps_conveniado_para, datetime pdh_data_alteracao)
public function boolean of_de_para_alteracao (long pl_convenio, string ps_conveniado_de, string ps_conveniado_para, datetime pdh_data_bloqueio, long pl_filial, string ps_usuario)
public function boolean of_de_para_exclusao (datetime pdh_data_exclusao, long pl_filial, string ps_usuario)
public function boolean of_limite_condicao (long pl_convenio, long pl_condicao)
public function boolean of_limite_conveniado_liberado (long pl_convenio, string ps_conveniado, long pl_condicao, decimal pdc_compra_atual)
public function date of_data_parametro ()
public function boolean of_Exclui_Condicao_Convenio_Conveniado (long pl_convenio, string ps_conveniado_de)
public function boolean of_altera_conveniado_de_para (long pl_convenio, string ps_conveniado_de, string ps_conveniado_para, datetime pdh_data_alteracao, datetime pdh_data_exclusao)
public function string of_retira_string (string ps_string, string ps_simbolo)
public subroutine of_inicializa ()
protected function boolean of_verifica_condicao_convenio_conveniado (long al_convenio, string as_conveniado, long al_condicao, ref decimal adc_limite_convenio, ref decimal adc_limite_conveniado, ref string as_obedece_limite, ref decimal adc_limite_condicao, ref string as_exige_limite_conveniado, ref string as_controle_limite)
public function boolean of_compras_conveniado (long al_convenio, string as_conveniado, long al_condicao, ref decimal adc_compras)
public function boolean of_limite_conveniado_liberado_matriz (long al_convenio, string as_conveniado, long al_condicao, ref decimal adc_compra_atual)
public function boolean of_cancela_venda_online (long al_filial, long al_nf, string as_especie, string as_serie)
public function boolean of_exclui_limite_conveniado (long pl_convenio, string ps_conveniado_de)
public function boolean of_limite_condicao_convenio_conveniado (long al_convenio, string as_conveniado, long al_condicao, ref boolean ab_existe, ref decimal adc_limite, ref string as_controla_limite)
public function boolean of_limite_conveniado (long al_convenio, string as_conveniado, long al_condicao, ref decimal adc_limite, ref boolean ab_condicao, ref string as_obedece_limite)
public function boolean of_busca_cpf (long al_convenio, string as_conveniado)
public function boolean of_altera_senha_central (long al_convenio, string as_conveniado, string as_senha, date adh_data_atualizacao, long al_filial, string as_operador)
public subroutine of_localiza_cpf (long pl_convenio, string ps_cpf)
public subroutine of_localiza_codigo_filial (long pl_convenio, string ps_conveniado)
public function boolean of_consulta_bloqueio_matriz (long al_convenio, string as_conveniado)
public function boolean of_consulta_limite_matriz (long al_convenio, string as_conveniado, long al_condicao, ref decimal adc_limite_atual)
public function boolean of_limite_conveniado_liberado_matriz (long al_convenio, string as_conveniado, long al_condicao, ref decimal adc_compra_atual, ref decimal adc_valor_ultrapassado, ref boolean ab_dif_avista)
public function boolean of_altera_senha_central (long al_convenio, string as_conveniado, string as_senha, date adh_data_atualizacao, long al_filial, string as_operador, string as_criptografada)
public function boolean of_exclui_conveniado_de_para_excecao (long pl_convenio, string ps_conveniado_de)
public function boolean of_limite_conveniado_liberado_matriz (long al_convenio, string as_conveniado, long al_condicao, ref decimal adc_compra_atual, boolean ab_ecommerce)
public function boolean of_cadastra_conveniado (long pl_convenio, string ps_conveniado, string ps_nome, long pl_filial_atualizacao, string ps_usuario_atualizacao, string ps_cd_bloq_conv_nao_rec, datetime pdt_atualizacao)
public function boolean of_bloqueia_conveniado_nao_atualizado (long pl_convenio, string ps_usuario, long pl_filial, string ps_motivo_bloqueio, datetime pdt_atualizacao)
public function boolean of_bloqueia_conveniado (long pl_convenio, string ps_conveniado, string ps_usuario, long pl_filial, string ps_motivo_bloqueio, datetime pdt_atualizacao)
public function boolean of_cadastra_dependente (datastore pds_dep_conveniado, long p_cd_convenio, string p_cd_conveniado, string p_nome_dependente, string ps_usuario_atualizacao, string ps_cd_bloq_conv_nao_rec, datetime pdt_atualizacao)
public function boolean of_libera_dependente_conveniado (long pl_cd_convenio, string ps_cd_conveniado, string ps_usuario, string ps_cd_bloq_conv_nao_rec, integer pi_cd_dependente, datetime pdt_atualizacao)
public function boolean of_cadastra_dependente_eletrosul (datastore pds_dep_conveniado, long p_cd_convenio, string p_cd_conveniado, string p_nome_dependente, string ps_usuario_atualizacao, string ps_cd_bloq_conv_nao_rec, string ps_cd_dependente, datetime pdt_atualizacao)
public function boolean of_libera_conveniado (long pl_cd_convenio, string ps_cd_conveniado, string ps_usuario, string ps_cd_bloq_conv_nao_rec, datetime pdt_atualizacao)
public function boolean of_bloqueia_depend_conv_nao_atualizado (long pl_convenio, string ps_usuario, long pl_filial, string ps_motivo_bloqueio, datetime pdt_alteracao)
end prototypes

public function boolean of_matricula (string ps_conveniado);Integer lvi_Tamanho, &
        lvi_Contador

String lvs_Char

lvi_Tamanho = Len(ps_Conveniado)

For lvi_Contador = 1 To lvi_Tamanho

	lvs_Char = Mid(ps_Conveniado, lvi_Contador, 1)
	
	If IsNumber(lvs_Char) Then
		Return True
	End If
	
Next	

Return False
end function

public subroutine of_localiza_conveniado (long pl_convenio, string ps_conveniado);String lvs_Conveniado

This.ivl_Convenio = pl_Convenio

// Verifica o par$$HEX1$$e200$$ENDHEX$$metro recebido
If of_Matricula(ps_Conveniado) Then
	of_Localiza_Codigo(pl_Convenio, ps_Conveniado)
	
	If This.ivl_Filial_Parametro = This.ivl_Filial_Matriz Then
		If Not Localizado Then
			This.ivs_Matricula = ps_Conveniado
			This.ivs_Nome      = ""
			of_Localiza_CPF(pl_Convenio, ps_Conveniado)		
		End If 
	End If
	
	If Not Localizado Then
		If This.ivl_Filial_Parametro <> This.ivl_Filial_Matriz Then
			This.ivs_Matricula = ps_Conveniado
			This.ivs_Nome      = ""
		Else			
			This.ivs_Matricula	= ""
			This.ivs_CPF 		= ps_Conveniado
		End If
		
		If This.ivl_Filial_Parametro <> This.ivl_Filial_Matriz Then
			If gvo_Aplicacao.ivo_seguranca.cd_sistema = 'CL' Then			
				OpenWithParm(w_ge005_Selecao_Conveniado_Filial_Paf, This)
			Else
				OpenWithParm(w_ge005_Selecao_Conveniado_Filial, This)
			End If
		Else
			OpenWithParm(w_ge005_Selecao_Conveniado_Matriz, This)
		End If
		
		lvs_Conveniado	= This.Cd_Conveniado
		pl_Convenio		= This.Cd_Convenio
		
		If Not IsNull(lvs_Conveniado) Then
			If This.ivl_Filial_Parametro = This.ivl_Filial_Matriz Then				
				of_Localiza_Codigo(pl_Convenio, lvs_Conveniado)
			Else
				of_Localiza_Codigo_Filial(pl_Convenio, lvs_Conveniado)				
			End If			
		Else
			Localizado = False
		End If		
	End If	
Else
	This.ivs_Matricula = ""
	This.ivs_Nome      = ps_Conveniado

	If This.ivl_Filial_Parametro <> This.ivl_Filial_Matriz Then
		If gvo_Aplicacao.ivo_seguranca.cd_sistema = 'CL' Then		
			OpenWithParm(w_ge005_Selecao_Conveniado_Filial_Paf, This)
		Else
			OpenWithParm(w_ge005_Selecao_Conveniado_Filial, This)
		End If
	Else
		OpenWithParm(w_ge005_Selecao_Conveniado_Matriz, This)
	End If
	
	lvs_Conveniado = This.cd_Conveniado
	
	If Not IsNull(lvs_Conveniado) Then
		of_Localiza_Codigo(pl_Convenio, lvs_Conveniado)
	Else
		Localizado = False
	End If
End If
end subroutine

public subroutine of_localiza_codigo (long pl_convenio, string ps_conveniado);String lvs_Criptografada

Select	  cd_convenio,
		  cd_conveniado,
		  nm_conveniado,
		  id_somente_titular,
		  id_obedece_restricao,
		  de_senha,
		  de_hash_senha,
		  id_senha_criptografada,
		  cd_cliente,
		  id_bloqueio_unimed,
		  nr_cpf,
		  id_sexo,
		  de_email,
		  nr_fone
Into :cd_convenio,
     :cd_conveniado,
     :nm_conveniado, 
	 :id_somente_titular,
	 :id_obedece_restricao,
	 :de_senha,
	 :de_hash_senha,
	 :lvs_Criptografada,
	 :cd_cliente,
	 :id_bloqueio_unimed,
	 :nr_cpf,
	 :id_sexo,
	 :de_email,
 	 :nr_fone	 
From conveniado
Where cd_convenio   = :pl_convenio
  and cd_conveniado = :ps_conveniado;

Senha_Criptografada = (lvs_Criptografada = 'S')

Choose Case SqlCa.SqlCode
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do conveniado." + SqlCa.SqlErrText, StopSign!)
		Localizado = False
	Case 100
		Localizado = False
	Case 0
		If Trim(This.de_hash_senha) = '' Then
			SetNull(de_hash_senha)
		End If
		If Trim(This.de_senha) = '' Then
			SetNull(de_senha)
		End If
		
//		If This.of_Bloqueio_Nao_Visualizado(This.Cd_Convenio, This.Cd_Conveniado) Then
//			Localizado = False
//		Else
			Localizado = True
//		End If
End Choose
end subroutine

public function boolean of_bloqueio_nao_visualizado (long pl_convenio, string ps_conveniado);Boolean lvb_Retorno = False

String lvs_Descricao_Motivo, &
       lvs_Mensagem, &
		 lvs_Nome_Conveniado, &
		 lvs_Fantasia_Convenio, &
		 lvs_Codigo_Motivo

Long lvl_Linha

If This.ivl_Filial_Parametro <> This.ivl_Filial_Matriz Then

	DataStore lvds_Bloqueio
	lvds_Bloqueio = Create DataStore

	lvds_Bloqueio.DataObject = "dw_bloqueio_nao_visualizar"
	lvds_Bloqueio.SetTransObject(SqlCa)
	
	lvl_Linha = lvds_Bloqueio.Retrieve(pl_Convenio, ps_Conveniado)

	If lvl_Linha > 0 Then
	
	    lvs_Fantasia_Convenio = lvds_Bloqueio.Object.Nm_Fantasia[1]
		lvs_Nome_Conveniado   = lvds_Bloqueio.Object.Nm_Conveniado[1]
		lvs_Codigo_Motivo     = lvds_Bloqueio.Object.Cd_Motivo_Bloqueio[1]
		lvs_Descricao_Motivo  = lvds_Bloqueio.Object.De_Motivo_Bloqueio[1]
		
		lvs_Mensagem = "O conveniado '" + lvs_Nome_Conveniado + " (" + ps_Conveniado + ")'" + &
		               " do conv$$HEX1$$ea00$$ENDHEX$$nio '" + lvs_Fantasia_Convenio + " (" + String(pl_Convenio) + ")'" + &
							" est$$HEX1$$e100$$ENDHEX$$ bloqueado pelo motivo '" + lvs_Descricao_Motivo + " (" + lvs_Codigo_Motivo + ")'" + &
							" e, por isso, n$$HEX1$$e300$$ENDHEX$$o pode ser visualizado, selecionado ou recadastrado."
		
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvs_Mensagem, StopSign!)
		lvb_Retorno = True
	End If
	
	Destroy(lvds_Bloqueio)
End If

Return lvb_Retorno
end function

public function long of_proximo_codigo_dependente (string p_cd_conveniado, long p_cd_convenio);Long lvl_cd_dependente

Select max(cd_dependente) Into :lvl_cd_dependente
From dependente_conveniado
Where cd_convenio   = :p_cd_convenio
  and cd_conveniado = :p_cd_conveniado;

If SqlCa.SqlCode = - 1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na busca do c$$HEX1$$f300$$ENDHEX$$digo dependente. " + SqlCa.SqlErrText,&
	                      StopSign!, Ok!)
	Return 0
End If

If IsNull(lvl_cd_dependente) or lvl_cd_dependente = 0 Then
	lvl_cd_dependente = 1
Else
	lvl_cd_dependente = lvl_cd_dependente + 1
End If	

Return lvl_cd_dependente
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

public function boolean of_de_para_nf_venda (long pl_convenio, string ps_conveniado_de, string ps_conveniado_para);w_Aguarde.Title = "Atualizando notas fiscais de venda..."

Update nf_venda
Set cd_conveniado = :ps_Conveniado_Para,
	 cd_dependente_conveniado = null
Where cd_convenio   = :pl_Convenio
  and cd_conveniado = :ps_Conveniado_De;
  
If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o das notas fiscais de venda.")
	Return False
Else
	Return True
End If
end function

public function boolean of_de_para_nf_devolucao_venda (long pl_convenio, string ps_conveniado_de, string ps_conveniado_para);w_Aguarde.Title = "Atualizando notas fiscais de devolu$$HEX2$$e700e300$$ENDHEX$$o de venda..."

Update nf_devolucao_venda
Set cd_conveniado = :ps_Conveniado_Para
Where cd_convenio   = :pl_Convenio
  and cd_conveniado = :ps_Conveniado_De;
  
If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o das notas fiscais de devolu$$HEX2$$e700e300$$ENDHEX$$o de venda.")
	Return False
Else
	Return True
End If
end function

public function boolean of_de_para_dependente_conveniado (long pl_convenio, string ps_conveniado_de, string ps_conveniado_para);w_Aguarde.Title = "Atualizando dependentes..."

Delete From dependente_conveniado
Where cd_convenio   = :pl_Convenio
  and cd_conveniado = :ps_Conveniado_De;
  
If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o dos dependentes.")
	Return False
Else
	Return True
End If
end function

public function boolean of_exclui_conveniado_de (long pl_convenio, string ps_conveniado_de);w_Aguarde.Title = "Excluindo conveniado de..."

Delete From conveniado
Where cd_convenio   = :pl_Convenio
  and cd_conveniado = :ps_Conveniado_De;
  
If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Erro na exclus$$HEX1$$e300$$ENDHEX$$o do conveniado '" + ps_Conveniado_De + "' do conv$$HEX1$$ea00$$ENDHEX$$nio '" + String(pl_Convenio) + "'.")
	Return False
Else
	Return True
End If
end function

public function boolean of_insere_bloqueio_de_para (long pl_convenio, string ps_conveniado_de, datetime pdh_data_bloqueio, long pl_filial, string ps_usuario);Long lvl_Bloqueio

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
		  'CDO',   
		  :This.ivs_Bloqueio_Conveniado_De_Para,   
		  :pdh_Data_Bloqueio,   
		  :ps_Usuario,   
		  null,   
		  null,   
		  :pl_Convenio,   
		  :ps_Conveniado_De,   
		  null,   
		  null,   
		  null)
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Inclus$$HEX1$$e300$$ENDHEX$$o do bloqueio do conveiado de.")
	Return False
Else
	Return True
End If
end function

public function boolean of_exclui_bloqueio_de (long pl_convenio, string ps_conveniado_de);w_Aguarde.Title = "Atualizando bloqueios..."

Delete
From bloqueio
Where cd_convenio   = :pl_Convenio
  and cd_conveniado = :ps_Conveniado_De;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Erro na exclus$$HEX1$$e300$$ENDHEX$$o dos bloqueios.")
	Return False
Else
	Return True
End If
end function

public function boolean of_insere_conveniado_de_para (long pl_convenio, string ps_conveniado_de, string ps_conveniado_para, datetime pdh_data_alteracao);w_Aguarde.Title = "Inserindo conveniado de para..."

Insert Into conveniado_de_para (cd_convenio,   
										  cd_conveniado_de,   
										  cd_conveniado_para,   
										  dh_alteracao,   
										  dh_exclusao)  
Values (:pl_Convenio,   
		  :ps_Conveniado_De,   
		  :ps_Conveniado_Para,   
		  :pdh_Data_Alteracao,   
		  null)
Using SqlCa;
  
If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Inclus$$HEX1$$e300$$ENDHEX$$o do conveniado de para.")
	Return False
Else
	Return True
End If
end function

public function boolean of_de_para_alteracao (long pl_convenio, string ps_conveniado_de, string ps_conveniado_para, datetime pdh_data_bloqueio, long pl_filial, string ps_usuario);Boolean lvb_Erro = True

SetPointer(HourGlass!)
Open(w_Aguarde)

w_Aguarde.uo_Progress.of_SetMax(6)

If of_De_Para_NF_Venda(pl_Convenio, ps_Conveniado_De, ps_Conveniado_Para) Then
	w_Aguarde.uo_Progress.of_SetProgress(3)
		
	If of_De_Para_NF_Devolucao_Venda(pl_Convenio, ps_Conveniado_De, ps_Conveniado_Para) Then
		w_Aguarde.uo_Progress.of_SetProgress(4)
	
		If of_Insere_Bloqueio_De_Para(pl_Convenio, &
												ps_Conveniado_De, &
												pdh_Data_Bloqueio, &
												pl_Filial, &
												ps_Usuario) Then
			
			w_Aguarde.uo_Progress.of_SetProgress(5)
		
			If of_Insere_Conveniado_De_Para(pl_Convenio, &
													  ps_Conveniado_De, &
													  ps_Conveniado_Para, &
													  pdh_Data_Bloqueio) Then
				
				w_Aguarde.uo_Progress.of_SetProgress(6)
				lvb_Erro = False
			End If
		End If
	End If
End If			

Close(w_Aguarde)
SetPointer(Arrow!)

Return Not lvb_Erro
end function

public function boolean of_de_para_exclusao (datetime pdh_data_exclusao, long pl_filial, string ps_usuario);Boolean lvb_Erro = False

Long lvl_Max, &
     lvl_Convenio, &
	  lvl_Contador

String lvs_Conveniado_De, &
       lvs_Conveniado_Para
		 
Date lvdt_Data_Limite

DateTime lvdh_Data_Alteracao

DataStore lvds_1
lvds_1 = Create DataStore
lvds_1.DataObject = "dw_conveniado_de_para"
lvds_1.SetTransObject(SqlCa)

lvdt_Data_Limite = RelativeDate(Date(pdh_Data_Exclusao), -2)

lvl_Max = lvds_1.Retrieve(lvdt_Data_Limite)

If lvl_Max > 0 Then	
	w_Aguarde.uo_Progress.of_SetMax(lvl_Max)
	lvb_Erro = True
	
	For lvl_Contador = 1 To lvl_Max
		lvl_Convenio        = lvds_1.Object.Cd_Convenio[lvl_Contador]
		lvs_Conveniado_De   = lvds_1.Object.Cd_Conveniado_De[lvl_Contador]
		lvs_Conveniado_Para = lvds_1.Object.Cd_Conveniado_Para[lvl_Contador]
		lvdh_Data_Alteracao = lvds_1.Object.Dh_Alteracao[lvl_Contador]
		
		If of_Altera_Conveniado_De_Para(lvl_Convenio, lvs_Conveniado_De, lvs_Conveniado_Para, lvdh_Data_Alteracao, pdh_Data_Exclusao) Then		
			If of_De_Para_NF_Venda(lvl_Convenio, lvs_Conveniado_De, lvs_Conveniado_Para) Then
				If of_De_Para_NF_Devolucao_Venda(lvl_Convenio, lvs_Conveniado_De, lvs_Conveniado_Para) Then
					If of_De_Para_Dependente_Conveniado(lvl_Convenio, lvs_Conveniado_De, lvs_Conveniado_Para) Then
						If of_Exclui_Bloqueio_De(lvl_Convenio, lvs_Conveniado_De) Then		
							If of_Exclui_Condicao_Convenio_Conveniado(lvl_Convenio, lvs_Conveniado_De) Then
								If of_Exclui_Limite_Conveniado(lvl_Convenio, lvs_Conveniado_De) Then
									If of_exclui_conveniado_de_para_excecao(lvl_Convenio, lvs_Conveniado_De) Then
										If of_Exclui_Conveniado_De(lvl_Convenio, lvs_Conveniado_De) Then
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
		
		If lvb_Erro Then Exit
		
		w_Aguarde.uo_Progress.of_SetProgress(lvl_Contador)
	Next
End If

Return Not lvb_Erro
end function

public function boolean of_limite_condicao (long pl_convenio, long pl_condicao);String lvs_Limite

Select id_controle_limite Into :lvs_Limite
From relacao_condicao_convenio
Where cd_convenio          = :pl_Convenio
  and cd_condicao_convenio = :pl_Condicao
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If lvs_Limite = "S" Then
			Return True
		Else
			Return False
		End If
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Condi$$HEX2$$e700e300$$ENDHEX$$o de venda n$$HEX1$$e300$$ENDHEX$$o localizada.", StopSign!)
		Return False
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da Condi$$HEX2$$e700e300$$ENDHEX$$o de Venda do Conv$$HEX1$$ea00$$ENDHEX$$nio")
		Return False
End Choose
		
end function

public function boolean of_limite_conveniado_liberado (long pl_convenio, string ps_conveniado, long pl_condicao, decimal pdc_compra_atual);Boolean lvb_Liberado

String lvs_Limite, &
       lvs_Mensagem

Decimal lvdc_Limite, &
        lvdc_Compras_Acumuladas

If This.of_Limite_Condicao(pl_Convenio, pl_Condicao) Then
	Select id_controle_limite,
	       vl_limite_compra 
   Into :lvs_Limite, 
	     :lvdc_Limite
	From condicao_convenio_conveniado
	Where cd_convenio          = :pl_Convenio
	  and cd_conveniado        = :ps_Conveniado
	  and cd_condicao_convenio = :pl_Condicao
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			If lvs_Limite = "S" Then
//				lvdc_Compras_Acumuladas = This.of_Compras_Conveniado(pl_Convenio, &
//																					  ps_Conveniado, &
//																					  pl_Condicao)
				If Not This.of_Compras_Conveniado(	pl_Convenio, &
																ps_Conveniado, &
																pl_Condicao, &
																Ref lvdc_Compras_Acumuladas) Then
					lvdc_Compras_Acumuladas = 0														
				End If 
																								  
				If lvdc_Limite >= (lvdc_Compras_Acumuladas + pdc_Compra_Atual) Then
					lvb_Liberado = True
				Else
					lvs_Mensagem = "O conveniado '" + ps_Conveniado + "' do conv$$HEX1$$ea00$$ENDHEX$$nio '" + &
										 String(pl_Convenio) + "' est$$HEX1$$e100$$ENDHEX$$ com o limite de compras " + &
										 "na condi$$HEX2$$e700e300$$ENDHEX$$o de venda '" + String(pl_Condicao) + "' estourado.~r~r" + &
										 "Valor do Limite : " + String(lvdc_Limite, "0.00") + ".~r" + &
										 "Valor das Compras Acumuladas : " + String(lvdc_Compras_Acumuladas, "0.00") + "."
										 
				   If pdc_Compra_Atual > 0 Then
						lvs_Mensagem += "~rValor desta Compra : " + String(pdc_Compra_Atual, "0.00") + "."
					End If

					lvs_Mensagem += "~r~rValor Ultrapassado : " + String(lvdc_Compras_Acumuladas + pdc_Compra_Atual - lvdc_Limite, "0.00") + "."

					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvs_Mensagem, Exclamation!)
					lvb_Liberado = False
				End If
			Else
				lvb_Liberado = True
			End If
		Case 100
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O conveniado '" + ps_Conveniado + "' do conv$$HEX1$$ea00$$ENDHEX$$nio '" + &
			                      String(pl_Convenio) + "' n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ liberado para comprar " + &
			                      "na condi$$HEX2$$e700e300$$ENDHEX$$o de venda '" + String(pl_Condicao) + "'.", Exclamation!)
			lvb_Liberado = False
		Case -1
			SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Limite de Compras do Conveniado")
			lvb_Liberado = False
	End Choose
Else
	lvb_Liberado = True	
End If

Return lvb_Liberado
end function

public function date of_data_parametro ();DateTime lvdh_Parametro

Select dh_movimentacao Into :lvdh_Parametro
From parametro
Where id_parametro = '1'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Data de movimenta$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o localizada.", StopSign!)
		SetNull(lvdh_Parametro)
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da Data de Movimenta$$HEX2$$e700e300$$ENDHEX$$o")
		SetNull(lvdh_Parametro)
End Choose

Return Date(lvdh_Parametro)
end function

public function boolean of_Exclui_Condicao_Convenio_Conveniado (long pl_convenio, string ps_conveniado_de);w_Aguarde.Title = "Excluindo condicao conv$$HEX1$$ea00$$ENDHEX$$nio conveniado..."

Delete From condicao_convenio_conveniado
Where cd_convenio   = :pl_Convenio
  and cd_conveniado = :ps_Conveniado_De;
  
If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Erro na exclus$$HEX1$$e300$$ENDHEX$$o da tabela: condicao_convenio_conveniado.")
	Return False
Else
	Return True
End If
end function

public function boolean of_altera_conveniado_de_para (long pl_convenio, string ps_conveniado_de, string ps_conveniado_para, datetime pdh_data_alteracao, datetime pdh_data_exclusao);w_Aguarde.Title = "Atualizando conveniado de para..."

Update conveniado_de_para 
Set dh_exclusao = :pdh_Data_Exclusao
Where cd_convenio        = :pl_Convenio   
  and cd_conveniado_de   = :ps_Conveniado_De   
  and cd_conveniado_para = :ps_Conveniado_Para
  and dh_alteracao       = :pdh_Data_Alteracao
Using SqlCa;
  
If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do conveniado de para.")
	Return False
Else
	Return True
End If
end function

public function string of_retira_string (string ps_string, string ps_simbolo);String lvs_String

Integer lvi_Pos

lvi_Pos = Pos(ps_String, ps_Simbolo)
	
If lvi_Pos > 0 Then
	lvs_String = Mid(ps_String, 1, lvi_Pos - 1) + Mid(ps_String, lvi_Pos + 1, Len(ps_String) - 1)
Else
	lvs_String = ps_String
End If

Return lvs_String
end function

public subroutine of_inicializa ();SetNull(This.Cd_Convenio)
SetNull(This.Cd_Conveniado)
SetNull(This.Cd_Cliente)
SetNull(This.Id_Bloqueio_Unimed)
Nm_Conveniado = ""
ib_falha_consulta_distribuido = False
Senha_Criptografada = False


SetNull(This.de_hash_senha)
SetNull(This.nr_CPF)
SetNull(This.de_email)
SetNull(This.nr_fone)
end subroutine

protected function boolean of_verifica_condicao_convenio_conveniado (long al_convenio, string as_conveniado, long al_condicao, ref decimal adc_limite_convenio, ref decimal adc_limite_conveniado, ref string as_obedece_limite, ref decimal adc_limite_condicao, ref string as_exige_limite_conveniado, ref string as_controle_limite);
String lvs_Controle_Limite
String lvs_erro_banco
String lvs_erro_conexao

Boolean lb_Sucesso = False

uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao()

lvo_Conexao.of_Define_Variaveis(True)
lvo_Conexao.of_ConverteVirgula(True)

//lvo_Conexao.of_executa_rotina('0011', { String(al_convenio) , "'"+as_conveniado+"'", String(al_condicao) } )
lvo_Conexao.of_executa_rotina('0111', { String(al_convenio) , "'"+as_conveniado+"'", String(al_condicao) } )

If lvo_Conexao.of_Erro_Execucao() Or lvo_Conexao.of_Erro_Conexao() Then
	lvo_Conexao.of_MsgError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da Condi$$HEX2$$e700e300$$ENDHEX$$o de Venda do Conv$$HEX1$$ea00$$ENDHEX$$nio")
	This.ib_falha_consulta_distribuido = True
	lvs_erro_banco = lvo_Conexao.Result.is_Data
	If IsNull(lvs_erro_banco) Then lvs_erro_banco = ""
	lvs_erro_conexao = lvo_Conexao.is_erro
	If isNull(lvs_erro_conexao) Then lvs_erro_conexao = ""	
	Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log, "Venda Convenio - Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do limite da condicao do convenio no Central. " + &
															"Convenio: " + String(al_convenio) + " Conveniado: " + as_conveniado + " Condicao: " + String(al_condicao) + &
															" Erro Consulta: " + lvs_erro_banco + " Erro Conex$$HEX1$$e300$$ENDHEX$$o: " + lvs_erro_conexao)
Else
	
	If lvo_Conexao.of_Retorno('vl_limite_convenio', Ref adc_limite_convenio) Then
		
		If lvo_Conexao.of_Retorno('vl_limite_conveniado', Ref adc_limite_conveniado) Then
			
			If lvo_Conexao.of_Retorno('id_obedece_limite', Ref as_obedece_limite) Then
				
				If lvo_Conexao.of_Retorno('vl_limite_condicao', Ref adc_limite_condicao) Then
					
					If lvo_Conexao.of_Retorno('id_exige_limite_conveniado', Ref as_exige_limite_conveniado) Then
						
						If lvo_Conexao.of_Retorno('id_controle_limite', Ref as_controle_limite) Then
																	
							If lvo_Conexao.of_Linhas() > 0 Then 
								
								If as_exige_limite_conveniado	= "" Then as_exige_limite_conveniado = "N"
								If as_controle_limite			= "" Then as_controle_limite         = "S"
								If as_obedece_limite				= "" Then as_obedece_limite          = "S"
								
								If IsNull(adc_limite_convenio) Then adc_limite_convenio = 0
								If IsNull(adc_limite_conveniado) Then adc_limite_conveniado = 0
								If IsNull(adc_limite_condicao) Then adc_limite_condicao = 0								
								
								lb_Sucesso = True
								
							End If	
							
						End If
						
					End If
					
				End If
				
			End If
			
		End If	
		
	End If	

End If	

Destroy(lvo_Conexao)
	
Return lb_Sucesso
end function

public function boolean of_compras_conveniado (long al_convenio, string as_conveniado, long al_condicao, ref decimal adc_compras);String	lvs_Where

Try
	uo_Transacao_Remota lvo_Conexao
	lvo_Conexao = Create uo_Transacao_Remota
	
	lvo_Conexao.of_BancoProducao( )
	
	lvo_Conexao.of_Define_Variaveis( True )
	lvo_Conexao.of_ConverteVirgula( True )
	
	lvs_Where = " and cd_convenio	= " + String( al_Convenio ) 	+ &
					"  and cd_conveniado	= '" + as_Conveniado + "'"
	
	If Not IsNull(al_Condicao) Then
		lvs_Where += "  and cd_condicao_convenio = " + String( al_Condicao )
	End If
	
	lvo_Conexao.of_executa_rotina( '0012', { lvs_Where } )
		
	If lvo_Conexao.of_Erro_Execucao( ) or lvo_Conexao.of_Erro_Conexao( ) Then
		lvo_Conexao.of_MsgError( "Verifica$$HEX2$$e700e300$$ENDHEX$$o das Compras do Conveniado" )
		adc_Compras = 0
		This.ib_falha_consulta_distribuido = True
		gvo_Aplicacao.of_Grava_Log( "Venda Convenio - Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o das compras do conveniado no Central. Convenio: " + String( al_convenio ) + " Conveniado: " + as_conveniado )
																
		Return False
	End If

	If lvo_Conexao.of_Linhas() > 0 Then
		If Not lvo_Conexao.of_Retorno( 'vl_compras', Ref adc_Compras ) Then
			Return False
		End If
	End If
		
	Return True
	
Catch( RuntimeError ru )
	MessageBox( 'RuntimeError', ru.getMessage( ) + '~rGE005 : uo_conveniado.of_compras_conveniado( long, string, long, ref decimal )', StopSign! )
	Return False
	
Finally
	If IsValid( lvo_Conexao ) Then Destroy lvo_Conexao
End Try
end function

public function boolean of_limite_conveniado_liberado_matriz (long al_convenio, string as_conveniado, long al_condicao, ref decimal adc_compra_atual);return this.of_limite_conveniado_liberado_matriz( al_convenio, as_conveniado, al_condicao, ref adc_compra_atual, False)
end function

public function boolean of_cancela_venda_online (long al_filial, long al_nf, string as_especie, string as_serie);Boolean lvb_Sucesso = False

Long lvl_Row

String lvs_Chave
String lvs_Tabela
String lvs_Set
String lvs_Where

lvs_Chave = "(" + String(al_Filial) + "/" + String(al_NF) + "/" + as_Especie + "/" + as_Serie + ")"

uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao()
	
lvs_Tabela	 = "nf_venda_convenio_online"

lvs_Set		 = "id_cancelada	= 'S'"

lvs_Where	 = " cd_filial		=  "  + String(al_Filial)
lvs_Where	+= " and nr_nf		=  "  + String(al_NF)
lvs_Where	+= " and de_especie	= '"  + as_Especie	+ "'"
lvs_Where	+= " and de_serie	= '"  + as_Serie	+ "'"
		
If Not lvo_Conexao.of_Update_Registro(lvs_Tabela, lvs_Set, lvs_Where, Ref lvl_Row) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no cancelamento da nota fiscal de venda para conv$$HEX1$$ea00$$ENDHEX$$nio online '" + lvs_Chave + "'.", Information!)
Else
	lvb_Sucesso = True
End If	

Destroy(lvo_Conexao)

Return lvb_Sucesso
end function

public function boolean of_exclui_limite_conveniado (long pl_convenio, string ps_conveniado_de);w_Aguarde.Title = "Excluindo historico limite conveniado..."

Delete From historico_limite_conveniado
Where cd_convenio   = :pl_Convenio
  and cd_conveniado = :ps_Conveniado_De;
  
If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Erro na exclus$$HEX1$$e300$$ENDHEX$$o da tabela: historico_limite_conveniado.")
	Return False
Else
	Return True
End If
end function

public function boolean of_limite_condicao_convenio_conveniado (long al_convenio, string as_conveniado, long al_condicao, ref boolean ab_existe, ref decimal adc_limite, ref string as_controla_limite);
String lvs_Controle_Limite
String lvs_erro_banco
String lvs_erro_conexao

Boolean lb_Sucesso = False

uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao()

lvo_Conexao.of_Define_Variaveis(True)
lvo_Conexao.of_ConverteVirgula(True)

lvo_Conexao.of_executa_rotina('0102', { String(al_convenio) , "'"+as_conveniado+"'", String(al_condicao) } )
//lvo_Conexao.of_executa_rotina('0002', { String(al_convenio) , "'"+as_conveniado+"'", String(al_condicao) } )

If lvo_Conexao.of_Erro_Execucao() Or lvo_Conexao.of_Erro_Conexao() Then
	lvo_Conexao.of_MsgError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da Condi$$HEX2$$e700e300$$ENDHEX$$o de Venda do Conv$$HEX1$$ea00$$ENDHEX$$nio")
	This.ib_falha_consulta_distribuido = True
	lvs_erro_banco = lvo_Conexao.Result.is_Data
	If IsNull(lvs_erro_banco) Then lvs_erro_banco = ""
	lvs_erro_conexao = lvo_Conexao.is_erro
	If isNull(lvs_erro_conexao) Then lvs_erro_conexao = ""
	Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log, "Venda Convenio - Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do limite do conveniado no Central. " + &
															"Convenio: " + String(al_convenio) + " Conveniado: " + as_conveniado + &
															" Erro Consulta: " + lvs_erro_banco + " Erro Conex$$HEX1$$e300$$ENDHEX$$o: " + lvs_erro_conexao)
Else
	
	If lvo_Conexao.of_Retorno('id_controle_limite', Ref lvs_Controle_Limite) Then
		
		//If lvo_Conexao.of_Retorno('vl_limite_compras', Ref adc_limite) Then
		If lvo_Conexao.of_Retorno('vl_limite_compra', Ref adc_limite) Then
			
			lb_Sucesso = True
			
			If IsNull(adc_Limite) Then adc_Limite = 0
		
			If lvo_Conexao.of_Linhas() > 0 Then
				
				ab_existe = True
				as_controla_limite = lvs_Controle_Limite				
							
				If lvs_Controle_Limite = "N" Then
					adc_limite = 0
				End If	
				
			Else
				ab_existe = False
			End If	
			
		End If	
		
	End If	
	
End If	

Destroy(lvo_Conexao)
	
Return lb_Sucesso
end function

public function boolean of_limite_conveniado (long al_convenio, string as_conveniado, long al_condicao, ref decimal adc_limite, ref boolean ab_condicao, ref string as_obedece_limite);
Boolean lvb_Existe

Decimal lvdc_Limite_Condicao_Convenio_Conveniado, &
        lvdc_Limite_Condicao, &
		  lvdc_Limite_Conveniado, &
		  lvdc_Limite_Convenio

String lvs_Exige_Limite_Conveniado, &
       lvs_Obedece_Limite, &
		 lvs_Controle_Limite

// Verifica a exist$$HEX1$$ea00$$ENDHEX$$ncia de limite por condi$$HEX2$$e700e300$$ENDHEX$$o / conv$$HEX1$$ea00$$ENDHEX$$nio / conveniado
// Se existir, este ser$$HEX1$$e100$$ENDHEX$$ o valor a ser respeitado
/******Processo comentado em 04/03/2016 a partir desta versao n$$HEX1$$e300$$ENDHEX$$o tem mais limite atrelado a condi$$HEX2$$e700e300$$ENDHEX$$o****/
//If Not This.of_Limite_Condicao_Convenio_Conveniado(al_Convenio, &
//																	as_Conveniado, &
//																	al_Condicao, &
//																	ref lvb_Existe, &
//																	ref lvdc_Limite_Condicao_Convenio_Conveniado, &
//																	ref lvs_Controle_Limite) Then
//	adc_Limite = 0	
//	Return True
//End If																	
//
//If lvb_Existe Then
//	adc_Limite = lvdc_Limite_Condicao_Convenio_Conveniado
//	ab_Condicao = True
//	as_obedece_limite = lvs_Controle_Limite	
//	Return True
//End If

// Verifica os limites por condi$$HEX2$$e700e300$$ENDHEX$$o, conveniado e conv$$HEX1$$ea00$$ENDHEX$$nio para determinar qual o limite ser$$HEX1$$e100$$ENDHEX$$ considerado
If Not This.of_Verifica_Condicao_Convenio_Conveniado(	al_Convenio, &
																	as_Conveniado, &
																	al_Condicao, &
																	Ref lvdc_Limite_Convenio, &
																	Ref lvdc_Limite_Conveniado, &
																	Ref lvs_Obedece_limite, &
																	Ref lvdc_Limite_Condicao, &
 																	Ref lvs_Exige_Limite_Conveniado, &
																	Ref lvs_Controle_Limite) Then
	adc_Limite = 0
	Return True												
End If

// Se o conveniado n$$HEX1$$e300$$ENDHEX$$o possuir limite por condi$$HEX2$$e700e300$$ENDHEX$$o do conv$$HEX1$$ea00$$ENDHEX$$nio
// e a condi$$HEX2$$e700e300$$ENDHEX$$o exigir este cadastramento, n$$HEX1$$e300$$ENDHEX$$o permite a venda
If lvs_Exige_Limite_Conveniado = "S" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O conveniado '" + as_Conveniado + "' do conv$$HEX1$$ea00$$ENDHEX$$nio '" + String(al_Convenio) + &
					  "' n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ liberado para comprar na condi$$HEX2$$e700e300$$ENDHEX$$o de venda '" + String(al_Condicao) + "'.")
	
	Return False
End If

// Se o conveniado n$$HEX1$$e300$$ENDHEX$$o obedecer o limite de cr$$HEX1$$e900$$ENDHEX$$dito, n$$HEX1$$e300$$ENDHEX$$o possui limite definido
If lvs_Obedece_Limite = "N" Then
	adc_Limite = 0
	as_obedece_limite = lvs_Obedece_Limite	
Else
	// Se o limite do conveniado $$HEX1$$e900$$ENDHEX$$ maior que zero, este ser$$HEX1$$e100$$ENDHEX$$ o valor a ser respeitado
	If lvdc_Limite_Conveniado > 0 Then
		adc_Limite = lvdc_Limite_Conveniado
	Else
		// Se a condi$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o possuir controle de limite, n$$HEX1$$e300$$ENDHEX$$o possui limite
		If lvs_Controle_Limite = "N" Then
			adc_Limite = 0
		Else
			// Se o limite da condi$$HEX2$$e700e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ maior que zero, este ser$$HEX1$$e100$$ENDHEX$$ o valor a ser respeitado
			If lvdc_Limite_Condicao > 0 Then
				adc_Limite = lvdc_Limite_Condicao
				ab_Condicao = True
			Else
				// Se o limite da condi$$HEX2$$e700e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ maior que zero, este ser$$HEX1$$e100$$ENDHEX$$ o valor a ser respeitado
				If lvdc_Limite_Convenio > 0 Then
					adc_Limite = lvdc_Limite_Convenio
				Else
					adc_Limite = 0
				End If	
			End If			
		End If		
	End If	
End If

Return True
end function

public function boolean of_busca_cpf (long al_convenio, string as_conveniado);String lvs_Select
String lvs_Retorno

Try	
	SELECT COALESCE( nr_cpf, '' ) 
	INTO :lvs_Retorno
	FROM conveniado
	WHERE cd_convenio	= :al_Convenio
	AND cd_conveniado	= :as_Conveniado
	USING SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case -1
			SqlCa.of_MsgDbError( 'GE005 - uo_conveniado.of_busca_cliente( long, string )' )
			Return False
			
		Case 100
			// N$$HEX1$$e300$$ENDHEX$$o localizou, busca na matriz
			
		Case 0
			If LenA( lvs_Retorno ) = 11 Then // Sen$$HEX1$$e300$$ENDHEX$$o - Tamanho diferente de 11, busca na matriz
				This.nr_cpf = LeftA( lvs_Retorno, 11 )
				Return True
			End If
	End Choose

	lvs_Select =	"select c.nr_cpf as 'nr_cpf'" + &
					"  from conveniado c " + &
					" Where c.cd_convenio = " + String( al_Convenio ) + " and" + &
					" c.cd_conveniado = '" + as_Conveniado + "'"				
	
	uo_Transacao_Remota lvo_Conexao
	lvo_Conexao = Create uo_Transacao_Remota
	
	lvo_Conexao.of_BancoProducao()
	
	lvo_Conexao.of_Retrieve( lvs_Select, Ref lvs_Retorno )
	
	If lvo_Conexao.of_Erro_Execucao( ) Or lvo_Conexao.of_Erro_Conexao( ) Then
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na conex$$HEX1$$e300$$ENDHEX$$o com o servidor distribu$$HEX1$$ed00$$ENDHEX$$do.~rGE005 - uo_conveniado.of_busca_cpf( long, string )" )
		Return False
	End If
	
	If IsNull(lvs_Retorno) Or Trim(lvs_Retorno) = '' Or LenA(lvs_Retorno) < 11 Then
		SetNull( This.nr_cpf )
		Return False
	End If

	This.nr_cpf = LeftA( lvs_Retorno, 11 )
	
	// Atualiza o CPF no banco de dados local
	lvs_Select = 'BEGIN TRANSACTION;'
	Execute immediate :lvs_Select Using SqlCa;
	
	UPDATE conveniado
	SET nr_cpf = :This.nr_cpf
	WHERE cd_convenio	= :al_convenio
	AND cd_conveniado	= :as_conveniado
	USING SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgDbError( 'GE005 - uo_conveniado.of_busca_cliente( long, string )' )
		
		lvs_Select = 'ROLLBACK;'
		Execute immediate :lvs_Select Using SqlCa;
		
		Return False
	Else
		lvs_Select = 'COMMIT;'
		Execute immediate :lvs_Select Using SqlCa;
	End If
	//
	
	Return True
	
Finally
	If IsValid( lvo_Conexao ) Then Destroy ( lvo_Conexao )
End Try
end function

public function boolean of_altera_senha_central (long al_convenio, string as_conveniado, string as_senha, date adh_data_atualizacao, long al_filial, string as_operador);String lvs_Tabela, &
		 lvs_Set, &
		 lvs_Where, &
		 lvs_Retorno
		 
Long lvl_Registros

Boolean lb_Sucesso = False

lvs_Tabela = "conveniado"

lvs_set = " de_hash_senha  = '" + as_senha + "'," + &
			" dh_atualizacao = getdate()," + &  
			" cd_filial_atualizacao = " + String(al_filial) + "," + &
			" nr_matricula_atualizacao = '" + as_operador + "'," + &
			" id_senha_criptografada = 'S' "

lvs_Where =	"	cd_convenio = " + String(al_Convenio) + " and" + &
					"  cd_conveniado = '" + as_Conveniado + "'"				

uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao()

lvo_Conexao.of_Update_Registro(lvs_Tabela, lvs_Set, lvs_Where, Ref lvl_Registros)

If lvo_Conexao.of_Erro_Execucao() Or lvo_Conexao.of_Erro_Conexao() Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na conex$$HEX1$$e300$$ENDHEX$$o com o servidor distribu$$HEX1$$ed00$$ENDHEX$$do.")
Else	
	If IsNull(lvl_Registros) Or Trim(String(lvl_Registros)) = '' Or lvl_Registros = 0 Then
		lb_Sucesso = False
	Else		
		lb_Sucesso = True
	End If
End If

Destroy(lvo_Conexao)
	
Return lb_Sucesso
end function

public subroutine of_localiza_cpf (long pl_convenio, string ps_cpf);String lvs_Criptografada
Integer lvi_Cont

Select count(1)
Into :lvi_Cont
From conveniado
Where cd_convenio   	= :pl_convenio
  and nr_cpf 			= :ps_cpf
Using SqlCa;

If lvi_Cont > 1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Existem dois ou mais conveniados com este CPF.", Exclamation!)
	Localizado = False
	Return
End If

Select 	cd_convenio,
			cd_conveniado,
			nm_conveniado,
			id_somente_titular,
			id_obedece_restricao,
			de_senha,
			de_hash_senha,
			id_senha_criptografada,
			cd_cliente,
			id_bloqueio_unimed,
			nr_cpf,
			de_email,
		     nr_fone
Into :cd_convenio,
     :cd_conveniado,
     :nm_conveniado, 
	 :id_somente_titular,
	 :id_obedece_restricao,
	 :de_senha,
	 :de_hash_senha,
	 :lvs_Criptografada,
	 :cd_cliente,
	 :id_bloqueio_unimed,
	 :nr_cpf,
	 :de_email,
	 :nr_fone
From conveniado
Where cd_convenio   	= :pl_convenio
  and nr_cpf 			= :ps_cpf;

Senha_Criptografada = (lvs_Criptografada = 'S')

Choose Case SqlCa.SqlCode
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do conveniado." + SqlCa.SqlErrText , StopSign!)
		Localizado = False
	Case 100
		Localizado = False
	Case 0
		If Trim(This.de_hash_senha) = '' Then
			SetNull(de_hash_senha)
		End If
		If Trim(This.de_senha) = '' Then
			SetNull(de_senha)
		End If
		
//		If This.of_Bloqueio_Nao_Visualizado(This.Cd_Convenio, This.Cd_Conveniado) Then
//			Localizado = False
//		Else
			Localizado = True
//		End If
End Choose
end subroutine

public subroutine of_localiza_codigo_filial (long pl_convenio, string ps_conveniado);String lvs_Criptografada
//Fun$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ usada porque depois de selecionar conveniado em outro momento $$HEX1$$e900$$ENDHEX$$ feita a verifica$$HEX2$$e700e300$$ENDHEX$$o de bloqueios.

Select c.cd_convenio,
       c.cd_conveniado,
       c.nm_conveniado,
  	   c.id_somente_titular,
	   c.id_obedece_restricao,
	   c.de_senha,
	    c.de_hash_senha,
	   c.id_senha_criptografada,
	   c.cd_cliente,
		c.id_bloqueio_unimed,
		c.nr_cpf,
		c.de_email,
		c.nr_fone
Into :cd_convenio,
     :cd_conveniado,
     :nm_conveniado, 
	 :id_somente_titular,
	 :id_obedece_restricao,
	 :de_senha,
	 :de_hash_senha,
	 :lvs_Criptografada,
	 :cd_cliente,
	 :id_bloqueio_unimed,
	 :nr_cpf,
	 :de_email,
  	 :nr_fone
From conveniado c
Where c.cd_convenio   = :pl_convenio
  and c.cd_conveniado = :ps_conveniado
  and not exists (select b.cd_conveniado
         				  from bloqueio b
						  inner join motivo_bloqueio m
						  		   on m.cd_motivo_bloqueio = b.cd_motivo_bloqueio
					               and m.id_permite_visualizacao = 'N'									  
		                where b.cd_convenio        = c.cd_convenio
			               and b.cd_conveniado      = c.cd_conveniado
			               and b.id_tipo_bloqueio   <> 'DCO'
			               and b.dh_liberacao is null);

Senha_Criptografada = (lvs_Criptografada = 'S')

Choose Case SqlCa.SqlCode
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do conveniado." + SqlCa.SqlErrText, StopSign!)
		Localizado = False
	Case 100
		Localizado = False
	Case 0
		If Trim(This.de_hash_senha) = '' Then
			SetNull(de_hash_senha)
		End If
		If Trim(This.de_senha) = '' Then
			SetNull(de_senha)
		End If
		
//		If This.of_Bloqueio_Nao_Visualizado(This.Cd_Convenio, This.Cd_Conveniado) Then
//			Localizado = False
//		Else
			Localizado = True
//		End If
End Choose
end subroutine

public function boolean of_consulta_bloqueio_matriz (long al_convenio, string as_conveniado);String lvs_Select, &
		 lvs_Retorno

Boolean lb_Sucesso = False

lvs_Select ="Select c.cd_conveniado " + &
				"From conveniado c " + &
				"Where c.cd_convenio   = " + String(al_Convenio) + &
				  " and c.cd_conveniado = '" + as_Conveniado + "'" + &
				  " and not exists (select b.cd_conveniado " + &
						  "from bloqueio b " + &
						  "inner join motivo_bloqueio m " + &
							"on m.cd_motivo_bloqueio = b.cd_motivo_bloqueio " + &
							"and m.id_permite_visualizacao = 'N' " + &									  
						  "where b.cd_convenio        = c.cd_convenio " + &
							 "and b.cd_conveniado      = c.cd_conveniado " + &
							 "and b.id_tipo_bloqueio   <> 'DCO' " + &
							 "and b.dh_liberacao is null) "				

uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao()

lvo_Conexao.of_Retrieve(lvs_Select, Ref lvs_Retorno)

If lvo_Conexao.of_Erro_Execucao() Or lvo_Conexao.of_Erro_Conexao() Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na conex$$HEX1$$e300$$ENDHEX$$o com o servidor distribu$$HEX1$$ed00$$ENDHEX$$do.")
Else
	
	If IsNull(lvs_Retorno) Or Trim(lvs_Retorno) = '' Then
		//N$$HEX1$$e300$$ENDHEX$$o encontrou bloqueio
		lb_Sucesso = False
	Else		
		lb_Sucesso = True
	End If
End If

Destroy(lvo_Conexao)
	
Return lb_Sucesso
end function

public function boolean of_consulta_limite_matriz (long al_convenio, string as_conveniado, long al_condicao, ref decimal adc_limite_atual);
Decimal lvdc_Limite, &
        lvdc_Compras_Acumuladas
		  
Boolean lvb_Limite_Condicao	

String  lvs_Mensagem, &
	 	  lvs_obedece_limite

// Verifica a exist$$HEX1$$ea00$$ENDHEX$$ncia de limite de cr$$HEX1$$e900$$ENDHEX$$dito
If Not This.of_Limite_Conveniado(al_Convenio, &
											as_Conveniado, &
											al_Condicao, &
											ref lvdc_Limite, &
											ref lvb_Limite_Condicao, &
											ref lvs_Obedece_Limite) Then
	Return False
End If

// Se o limite for zero quer dizer que o conveniado n$$HEX1$$e300$$ENDHEX$$o possui limite cadastrado
If (lvdc_Limite = 0) Then 
	adc_limite_atual = 0
	Return True 
End If

// Verifica o valor das compras acumuladas no per$$HEX1$$ed00$$ENDHEX$$odo pelo conveniado
If Not lvb_Limite_Condicao Then SetNull(al_Condicao)

If Not This.of_Compras_Conveniado(al_Convenio, &
										    as_Conveniado, &
											 al_Condicao, &
											 ref lvdc_Compras_Acumuladas) Then
	Return False
End If
																				  
// Calcula Limite atual
adc_limite_atual = lvdc_Limite - lvdc_Compras_Acumuladas

Return True
end function

public function boolean of_limite_conveniado_liberado_matriz (long al_convenio, string as_conveniado, long al_condicao, ref decimal adc_compra_atual, ref decimal adc_valor_ultrapassado, ref boolean ab_dif_avista);
Decimal lvdc_Limite, &
        lvdc_Compras_Acumuladas, &
	    lvdc_Limite_20
		  
Boolean lvb_Limite_Condicao	

String  lvs_Mensagem, &
	 	  lvs_obedece_limite
	
// Verifica a exist$$HEX1$$ea00$$ENDHEX$$ncia de limite de cr$$HEX1$$e900$$ENDHEX$$dito
If Not This.of_Limite_Conveniado(al_Convenio, &
											as_Conveniado, &
											al_Condicao, &
											ref lvdc_Limite, &
											ref lvb_Limite_Condicao, &
											ref lvs_Obedece_Limite) Then
	Return False
End If

gvo_Aplicacao.of_Grava_Log( "of_limite_conveniado: LIMITE RETORNADO: " + sTRING(lvdc_Limite) + " - Convenio: " + String(al_Convenio) + " Conveniado: " +  as_Conveniado)

// Se o limite for zero quer dizer que o conveniado n$$HEX1$$e300$$ENDHEX$$o possui limite cadastrado
If (lvdc_Limite = 0) Then Return True // And (lvs_obedece_limite = "N") Then Return True

lvdc_Limite_20 = ( lvdc_Limite * 20 ) / 100

// Verifica o valor das compras acumuladas no per$$HEX1$$ed00$$ENDHEX$$odo pelo conveniado
If Not lvb_Limite_Condicao Then SetNull(al_Condicao)

If Not This.of_Compras_Conveniado(al_Convenio, &
										    as_Conveniado, &
											 al_Condicao, &
											 ref lvdc_Compras_Acumuladas) Then
	Return False
End If

gvo_Aplicacao.of_Grava_Log( "of_limite_conveniado: COMPRAS ACUMULADAS: " + sTRING(lvdc_Compras_Acumuladas) + " - Convenio: " + String(al_Convenio) + " Conveniado: " +  as_Conveniado)
																				  
// Verifica se o limite $$HEX1$$e900$$ENDHEX$$ suficiente
If al_convenio = 50805 Then //Para o conv$$HEX1$$ea00$$ENDHEX$$nio CLAMED permite comprar at$$HEX1$$e900$$ENDHEX$$ 20% do limite, e n$$HEX1$$e300$$ENDHEX$$o tem op$$HEX2$$e700e300$$ENDHEX$$o de pagar o valor ultrapassado $$HEX1$$e000$$ENDHEX$$ vista. Chamado: 486986
	If (lvdc_Limite + lvdc_Limite_20) >= lvdc_Compras_Acumuladas + adc_Compra_Atual Then Return True
Else
	If lvdc_Limite >= lvdc_Compras_Acumuladas + adc_Compra_Atual Then Return True
End If

ab_dif_avista = False

lvs_Mensagem = "O conveniado '" + as_Conveniado + "' do conv$$HEX1$$ea00$$ENDHEX$$nio '" + &
				  String(al_Convenio) + "' est$$HEX1$$e100$$ENDHEX$$ com o limite de compras excedido.~r~r" + &
				  "Valor do Limite : " + String(lvdc_Limite, "0.00") + ".~r" + &
				  "Valor das Compras Acumuladas : " + String(lvdc_Compras_Acumuladas, "0.00") + "."
					 
If adc_Compra_Atual > 0 Then
	lvs_Mensagem += "~rValor desta Compra : " + String(adc_Compra_Atual, "0.00") + "."
End If

lvs_Mensagem += "~r~rValor Ultrapassado : " + String(lvdc_Compras_Acumuladas + adc_Compra_Atual - lvdc_Limite, "0.00") + "."

If al_convenio = 50805 Then //Para o conv$$HEX1$$ea00$$ENDHEX$$nio CLAMED permite comprar at$$HEX1$$e900$$ENDHEX$$ 20% do limite, e n$$HEX1$$e300$$ENDHEX$$o tem op$$HEX2$$e700e300$$ENDHEX$$o de pagar o valor ultrapassado $$HEX1$$e000$$ENDHEX$$ vista. Chamado: 486986
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o",lvs_Mensagem)
Else
	If (lvdc_Compras_Acumuladas + adc_Compra_Atual - lvdc_Limite) <= adc_compra_atual Then
		lvs_Mensagem += "~rO Cliente deseja somar o valor ultrapassado ao pagamento $$HEX1$$e000$$ENDHEX$$ vista?"
		
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o",lvs_Mensagem, Question!,YesNo!, 2) = 1 Then
			adc_valor_ultrapassado 	= lvdc_Compras_Acumuladas + adc_Compra_Atual - lvdc_Limite
			ab_dif_avista 				= True
			Return False
		End If
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o",lvs_Mensagem)
	End If
End If

Return False
end function

public function boolean of_altera_senha_central (long al_convenio, string as_conveniado, string as_senha, date adh_data_atualizacao, long al_filial, string as_operador, string as_criptografada);String lvs_Tabela, &
		 lvs_Set, &
		 lvs_Where, &
		 lvs_Retorno
		 
Long lvl_Registros

Boolean lb_Sucesso = False

lvs_Tabela = "conveniado"

lvs_set = " de_hash_senha  = '" + as_senha + "'," + &
			" dh_atualizacao = getdate()," + &  
			" cd_filial_atualizacao = " + String(al_filial) + "," + &
			" nr_matricula_atualizacao = '" + as_operador + "'," + &
			" id_senha_criptografada = '" + as_criptografada + "'"

lvs_Where =	"	cd_convenio = " + String(al_Convenio) + " and" + &
					"  cd_conveniado = '" + as_Conveniado + "'"				

uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao()

lvo_Conexao.of_Update_Registro(lvs_Tabela, lvs_Set, lvs_Where, Ref lvl_Registros)

If lvo_Conexao.of_Erro_Execucao() Or lvo_Conexao.of_Erro_Conexao() Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na conex$$HEX1$$e300$$ENDHEX$$o com o servidor distribu$$HEX1$$ed00$$ENDHEX$$do.")
Else	
	If IsNull(lvl_Registros) Or Trim(String(lvl_Registros)) = '' Or lvl_Registros = 0 Then
		lb_Sucesso = False
	Else		
		lb_Sucesso = True
	End If
End If

Destroy(lvo_Conexao)
	
Return lb_Sucesso
end function

public function boolean of_exclui_conveniado_de_para_excecao (long pl_convenio, string ps_conveniado_de);w_Aguarde.Title = "Excluindo conveniado de para Excecao..."

Delete From conveniado_de_para_excecao
Where cd_convenio   = :pl_Convenio
  and cd_conveniado = :ps_Conveniado_De
Using SqlCa;
  
If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Erro na exclus$$HEX1$$e300$$ENDHEX$$o do conveniado (excec$$HEX1$$e300$$ENDHEX$$o) '" + ps_Conveniado_De + "' do conv$$HEX1$$ea00$$ENDHEX$$nio '" + String(pl_Convenio) + "'.")
	Return False
Else
	Return True
End If
end function

public function boolean of_limite_conveniado_liberado_matriz (long al_convenio, string as_conveniado, long al_condicao, ref decimal adc_compra_atual, boolean ab_ecommerce);
Decimal lvdc_Limite, &
        lvdc_Compras_Acumuladas
		  
Boolean lvb_Limite_Condicao	

String  lvs_Mensagem, &
	 	  lvs_obedece_limite

// Verifica a exist$$HEX1$$ea00$$ENDHEX$$ncia de limite de cr$$HEX1$$e900$$ENDHEX$$dito
If Not This.of_Limite_Conveniado(al_Convenio, &
											as_Conveniado, &
											al_Condicao, &
											ref lvdc_Limite, &
											ref lvb_Limite_Condicao, &
											ref lvs_Obedece_Limite) Then
	Return False
End If

// Se o limite for zero quer dizer que o conveniado n$$HEX1$$e300$$ENDHEX$$o possui limite cadastrado
If (lvdc_Limite = 0) Then Return True // And (lvs_obedece_limite = "N") Then Return True

// Verifica o valor das compras acumuladas no per$$HEX1$$ed00$$ENDHEX$$odo pelo conveniado
If Not lvb_Limite_Condicao Then SetNull(al_Condicao)

If Not This.of_Compras_Conveniado(al_Convenio, &
										    as_Conveniado, &
											 al_Condicao, &
											 ref lvdc_Compras_Acumuladas) Then
	Return False
End If
																				  
// Verifica se o limite $$HEX1$$e900$$ENDHEX$$ suficiente
if ab_ecommerce = True Then
	//Se estiver faturando pelo Ecommerce Loja, o valor da venda atual j$$HEX1$$e100$$ENDHEX$$ estara calculado nas compras acumuladas.
	If lvdc_Limite >= lvdc_Compras_Acumuladas Then Return True
Else
	If lvdc_Limite >= lvdc_Compras_Acumuladas + adc_Compra_Atual Then Return True
ENd if

lvs_Mensagem = "O conveniado '" + as_Conveniado + "' do conv$$HEX1$$ea00$$ENDHEX$$nio '" + &
				  String(al_Convenio) + "' est$$HEX1$$e100$$ENDHEX$$ com o limite de compras excedido.~r~r" + &
				  "Valor do Limite : " + String(lvdc_Limite, "0.00") + ".~r" + &
				  "Valor das Compras Acumuladas : " + String(lvdc_Compras_Acumuladas, "0.00") + "."
					 
If adc_Compra_Atual > 0 Then
	lvs_Mensagem += "~rValor desta Compra : " + String(adc_Compra_Atual, "0.00") + "."
End If

lvs_Mensagem += "~r~rValor Ultrapassado : " + String(lvdc_Compras_Acumuladas + adc_Compra_Atual - lvdc_Limite, "0.00") + "."

MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o",lvs_Mensagem)

Return False
end function

public function boolean of_cadastra_conveniado (long pl_convenio, string ps_conveniado, string ps_nome, long pl_filial_atualizacao, string ps_usuario_atualizacao, string ps_cd_bloq_conv_nao_rec, datetime pdt_atualizacao);Boolean lvb_Retorno = True

String lvs_Conveniado
String lvs_Achou

Update conveniado
Set nm_conveniado            		= :ps_Nome,
	 cd_filial_atualizacao    		= :pl_Filial_Atualizacao,
	 nr_matricula_atualizacao	= :ps_Usuario_Atualizacao,
	 dh_atualizacao           		= :pdt_atualizacao
Where cd_convenio            	= :pl_convenio
  and cd_conveniado			= :ps_conveniado
 // and coalesce(nm_conveniado,'') <> coalesce(:ps_Nome,'') //No final das leituras de arquivos o sistema bloqueia quem n$$HEX1$$e300$$ENDHEX$$o foi atualizado
  ;
  
If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do conveniado " + ps_Conveniado + &
								 " do conv$$HEX1$$ea00$$ENDHEX$$nio " + String(pl_Convenio))
	lvb_Retorno = False			
Else	
	If SqlCa.SqlNRows = 0 Then
		Select cd_conveniado
		Into :lvs_Achou
		From conveniado
		Where cd_convenio            	= :pl_convenio
		  and cd_conveniado			= :ps_conveniado;
		  
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgdbError("Sele$$HEX2$$e700e300$$ENDHEX$$o do conveniado " + ps_Conveniado + &
									  " do conv$$HEX1$$ea00$$ENDHEX$$nio " + String(pl_Convenio))
			lvb_Retorno = False			
		End If
		
		If SQLCa.SQLCode = 100 Then
			// Conveniado n$$HEX1$$e300$$ENDHEX$$o cadastrado (novo)
			Insert Into conveniado (cd_convenio,
											cd_conveniado,
											nm_conveniado,
											id_somente_titular,
											id_obedece_restricao,
											cd_filial_atualizacao,
											nr_matricula_atualizacao,
											dh_atualizacao)
			Values (:pl_convenio,
					  :ps_conveniado,
					  :ps_nome,
					  'N',
					  'S',
					  :pl_filial_atualizacao,
					  :ps_usuario_atualizacao,
					  :pdt_atualizacao);
					  
			If SqlCa.SqlCode = -1 Then
				SqlCa.of_MsgdbError("Erro na inclus$$HEX1$$e300$$ENDHEX$$o do conveniado " + ps_Conveniado + &
										  " do conv$$HEX1$$ea00$$ENDHEX$$nio " + String(pl_Convenio))
				lvb_Retorno = False			
			End If
		Else
			// libera se o conveniado estiver com o motivo do bloqueio 
			// igual a SI1 (conveniado nao recebido) ou (004) para o convenio Dohler / Comfio
			If Not of_libera_conveniado(pl_convenio, ps_conveniado, ps_Usuario_Atualizacao, ps_cd_bloq_conv_nao_rec, pdt_atualizacao) Then Return False
		End If
	Else
		// libera se o conveniado estiver com o motivo do bloqueio 
		// igual a SI1 (conveniado nao recebido) ou (004) para o convenio Dohler / Comfio
		If Not of_libera_conveniado(pl_convenio, ps_conveniado, ps_Usuario_Atualizacao, ps_cd_bloq_conv_nao_rec, pdt_atualizacao) Then Return False
	End If
End If

Return lvb_Retorno
end function

public function boolean of_bloqueia_conveniado_nao_atualizado (long pl_convenio, string ps_usuario, long pl_filial, string ps_motivo_bloqueio, datetime pdt_atualizacao);Long lvl_Bloqueio, &
     lvl_Max, &
	  lvl_Contador

Long lvl_count=1, lvl_umporcento

String lvs_Conveniado

// Verifica quais os conveniados cuja data de atualiza$$HEX2$$e700e300$$ENDHEX$$o seja menor
// que a $$HEX1$$fa00$$ENDHEX$$ltima data de atualiza$$HEX2$$e700e300$$ENDHEX$$o por disquette

dc_uo_ds_Base lvds_1
lvds_1 = Create dc_uo_ds_Base
If Not lvds_1.of_ChangeDataObject("ds_conveniado_nao_atualizado") Then Return False

Try

	Open(w_Aguarde)
	w_Aguarde.Title = "Bloqueando Conveniados n$$HEX1$$e300$$ENDHEX$$o Atualizados..."
	
	lvl_Max = lvds_1.Retrieve(pl_Convenio, ps_Motivo_Bloqueio)
	
	w_Aguarde.uo_progress.of_SetMax(lvl_Max)
	
	if lvl_max > 100 Then
		lvl_umporcento = lvl_max/100
	End if
	
	If lvl_Max > 0 Then
		lvl_Bloqueio   = This.of_Proximo_Bloqueio(pl_Filial)
		
		For lvl_Contador = 1 To lvl_Max
	
			lvs_Conveniado = lvds_1.Object.Cd_Conveniado[lvl_Contador]				
			
			Insert Into bloqueio (cd_filial,
										 nr_bloqueio,
										 id_tipo_bloqueio,
										 cd_motivo_bloqueio,
										 dh_bloqueio,
										 nr_matricula_bloqueio,
										 cd_convenio,
										 cd_conveniado)
			Values(:pl_Filial,
					 :lvl_bloqueio,
					 'CDO',
					 :ps_motivo_bloqueio,
					 :pdt_atualizacao,
					 :ps_usuario,
					 :pl_convenio,
					 :lvs_conveniado)
			Using SqlCa;
					 
			If SqlCa.SqlCode = -1 Then
				SqlCa.of_MsgdbError("Erro na inclus$$HEX1$$e300$$ENDHEX$$o do bloqueio.")
				Return False
			End If
			
			if lvl_max <= 100 then
				w_Aguarde.uo_Progress.of_SetProgress(lvl_Contador)
			ELse
				if lvl_Contador >= (lvl_umporcento*lvl_count) or lvl_Contador >= lvl_Max Then
					lvl_count++
					w_Aguarde.uo_Progress.of_SetProgress(lvl_Contador)
				ENd if
			ENd if
			
			lvl_Bloqueio ++
		Next	
	End If

Finally

	Destroy(lvds_1)
	Close(w_Aguarde)
	
ENd Try

Return True
end function

public function boolean of_bloqueia_conveniado (long pl_convenio, string ps_conveniado, string ps_usuario, long pl_filial, string ps_motivo_bloqueio, datetime pdt_atualizacao);Long lvl_Bloqueio, &
     lvl_Controle

lvl_Bloqueio = This.of_Proximo_Bloqueio(pl_Filial)

Select count(*) Into :lvl_controle
From bloqueio
Where cd_convenio = :pl_convenio
And cd_conveniado = :ps_conveniado
And cd_motivo_bloqueio = :ps_motivo_bloqueio
And dh_liberacao is null
Using SqlCa;
				 
If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Erro na inclus$$HEX1$$e300$$ENDHEX$$o do bloqueio.")
	Return False
End If
If lvl_controle = 0 Then
	Insert Into bloqueio (cd_filial,
								 nr_bloqueio,
								 id_tipo_bloqueio,
								 cd_motivo_bloqueio,
								 dh_bloqueio,
								 nr_matricula_bloqueio,
								 cd_convenio,
								 cd_conveniado)
	Values(:pl_Filial,
			 :lvl_bloqueio,
			 'CDO',
			 :ps_motivo_bloqueio,
			 :pdt_atualizacao,
			 :ps_usuario,
			 :pl_convenio,
			 :ps_conveniado)
	Using SqlCa;
					 
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgdbError("Erro na inclus$$HEX1$$e300$$ENDHEX$$o do bloqueio.")
		Return False
	End If
End If

Return True
end function

public function boolean of_cadastra_dependente (datastore pds_dep_conveniado, long p_cd_convenio, string p_cd_conveniado, string p_nome_dependente, string ps_usuario_atualizacao, string ps_cd_bloq_conv_nao_rec, datetime pdt_atualizacao);Long lvl_cd_dependente_conveniado, &
	  lvl_Find

Integer lvi_Dependente

String lvs_relacao_dependencia

lvl_Find = pds_Dep_Conveniado.Find("cd_convenio = " + String(p_cd_convenio) + &
           " and cd_conveniado = '" + p_cd_conveniado + "' and nm_dependente = '" + &
			  UPPER(p_nome_dependente) + "'", 1, pds_Dep_Conveniado.RowCount())

If lvl_Find < 0 Then
	
	// Para retirar strings( ' " ) do nome do dependente
	p_nome_dependente = This.of_Retira_String(p_nome_dependente, "'")
	p_nome_dependente = This.of_Retira_String(p_nome_dependente, '"')
	
	lvl_Find = pds_Dep_Conveniado.Find("cd_convenio = " + String(p_cd_convenio) + &
              " and cd_conveniado = '" + p_cd_conveniado + "' and nm_dependente = '" + &
			     UPPER(p_nome_dependente) + "'", 1, pds_Dep_Conveniado.RowCount())
				  
	If lvl_Find < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o(find), do conveniado :'" + p_cd_conveniado + &
	              "' e dependente : '" + p_nome_dependente + "'.",StopSign!)
		Return False
	End If
End If

If lvl_Find = 0 Then
		
	lvl_cd_dependente_conveniado = Of_proximo_codigo_dependente(p_cd_conveniado,p_cd_convenio)
	lvs_relacao_dependencia      = "DESCONHECIDO"

	Insert Into dependente_conveniado( cd_conveniado,
												  cd_dependente,
												  cd_convenio  ,
												  nm_dependente,	
												  de_relacao_dependencia,
												  dh_atualizacao_filial)
	Values ( :p_cd_conveniado,
				:lvl_cd_dependente_conveniado,
				:p_cd_convenio,
				:p_nome_dependente,
				:lvs_relacao_dependencia,
				:pdt_atualizacao);
				
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgdbError("Erro na inclus$$HEX1$$e300$$ENDHEX$$o do Dependente: " +p_nome_dependente + ". ")
		Return False
	Else
		Return True
	End If	
Else
	
	lvi_Dependente = pds_Dep_Conveniado.Object.Cd_Dependente[lvl_Find]
	
	Update dependente_conveniado
	set dh_atualizacao_filial = :pdt_atualizacao
	Where cd_convenio         = :p_cd_convenio
	  and cd_conveniado       = :p_cd_conveniado
	  and cd_dependente       = :lvi_Dependente
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgdbError("Erro na Atualiza$$HEX2$$e700e300$$ENDHEX$$o do Dependente: " + p_nome_dependente + ". ")
		Return False
	Else
		If SqlCa.SqlNRows > 0 Then			
			// libera se o dependente estiver com o motivo do bloqueio 
			// igual a SI1 (conveniado nao recebido)
			If Not of_libera_dependente_conveniado(p_cd_convenio, p_cd_conveniado, ps_Usuario_Atualizacao, ps_cd_bloq_conv_nao_rec, lvi_Dependente, pdt_atualizacao) Then Return False
		
			Return True
		End If
	End If
End If

Return True
end function

public function boolean of_libera_dependente_conveniado (long pl_cd_convenio, string ps_cd_conveniado, string ps_usuario, string ps_cd_bloq_conv_nao_rec, integer pi_cd_dependente, datetime pdt_atualizacao);String lvs_nr_matricula_liberacao

Long lvl_Bloqueio

lvs_nr_matricula_liberacao = ps_Usuario

// libera bloqueio com motivo: SI1 
Update bloqueio
	Set dh_liberacao           = :pdt_atualizacao,
		 nr_matricula_liberacao = :lvs_nr_matricula_liberacao
where cd_motivo_bloqueio		= :ps_cd_bloq_conv_nao_rec
  and cd_convenio 	    		= :pl_cd_convenio
  and cd_conveniado      		= :ps_cd_conveniado
  and cd_dependente           = :pi_cd_dependente
  and id_tipo_bloqueio 	 		= 'DCO'
  and dh_liberacao            is Null ;
	 
If SqlCa.SqlCode = -1 Then		 
	SqlCa.of_MsgdbError("Erro na libera$$HEX2$$e700e300$$ENDHEX$$o do conveniado: " + ps_cd_conveniado + " ")
	Return False
End If

Return True
end function

public function boolean of_cadastra_dependente_eletrosul (datastore pds_dep_conveniado, long p_cd_convenio, string p_cd_conveniado, string p_nome_dependente, string ps_usuario_atualizacao, string ps_cd_bloq_conv_nao_rec, string ps_cd_dependente, datetime pdt_atualizacao);Long lvl_cd_dependente_conveniado, &
	  lvl_Find

Integer lvi_Dependente

lvl_Find = pds_Dep_Conveniado.Find("cd_convenio = " + String(p_cd_convenio) + &
           " and cd_conveniado = '" + p_cd_conveniado + "' and nm_dependente = '" + &
			  UPPER(p_nome_dependente) + "'", 1, pds_Dep_Conveniado.RowCount())

If lvl_Find < 0 Then
	
	// Para retirar strings( ' " ) do nome do dependente
	p_nome_dependente = This.of_Retira_String(p_nome_dependente, "'")
	p_nome_dependente = This.of_Retira_String(p_nome_dependente, '"')
	
	lvl_Find = pds_Dep_Conveniado.Find("cd_convenio = " + String(p_cd_convenio) + &
              " and cd_conveniado = '" + p_cd_conveniado + "' and nm_dependente = '" + &
			     UPPER(p_nome_dependente) + "'", 1, pds_Dep_Conveniado.RowCount())
				  
	If lvl_Find < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o(find), do conveniado :'" + p_cd_conveniado + &
	              "' e dependente : '" + p_nome_dependente + "'.",StopSign!)
		Return False
	End If
End If

If lvl_Find = 0 Then
		
	lvl_cd_dependente_conveniado = Of_proximo_codigo_dependente(p_cd_conveniado,p_cd_convenio)

	Insert Into dependente_conveniado( cd_conveniado,
												  cd_dependente,
												  cd_convenio  ,
												  nm_dependente,	
												  de_relacao_dependencia,
												  dh_atualizacao_filial)
	Values ( :p_cd_conveniado,
				:lvl_cd_dependente_conveniado,
				:p_cd_convenio,
				:p_nome_dependente,
				:ps_cd_dependente,
				:pdt_atualizacao);
				
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgdbError("Erro na inclus$$HEX1$$e300$$ENDHEX$$o do Dependente: " +p_nome_dependente + ". ")
		Return False
	Else
		Return True
	End If	
Else
	
	lvi_Dependente = pds_Dep_Conveniado.Object.Cd_Dependente[lvl_Find]
	
	Update dependente_conveniado
	set dh_atualizacao_filial = :pdt_atualizacao,
	    de_relacao_dependencia = :ps_cd_dependente 
	Where cd_convenio         = :p_cd_convenio
	  and cd_conveniado       = :p_cd_conveniado
	  and cd_dependente       = :lvi_Dependente
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		SqlCa.of_MsgdbError("Erro na Atualiza$$HEX2$$e700e300$$ENDHEX$$o do Dependente: " + p_nome_dependente + ". ")
		Return False
	Else
		If SqlCa.SqlNRows > 0 Then			
			// libera se o dependente estiver com o motivo do bloqueio 
			// igual a SI1 (conveniado nao recebido)
			If Not of_libera_dependente_conveniado(p_cd_convenio, p_cd_conveniado, ps_Usuario_Atualizacao, ps_cd_bloq_conv_nao_rec, lvi_Dependente, pdt_atualizacao) Then Return False
		
			Return True
		End If
	End If
End If

Return True
end function

public function boolean of_libera_conveniado (long pl_cd_convenio, string ps_cd_conveniado, string ps_usuario, string ps_cd_bloq_conv_nao_rec, datetime pdt_atualizacao);String lvs_nr_matricula_liberacao

Long lvl_Bloqueio

lvs_nr_matricula_liberacao = ps_Usuario

// Se o convenio for da Dohler / Comfio, libera bloqueio com motivo: SI1 ou 004
If pl_cd_convenio = 51361 or pl_cd_convenio = 51359 Then

	Update bloqueio
		Set dh_liberacao           = :pdt_atualizacao,
		    nr_matricula_liberacao = :lvs_nr_matricula_liberacao
	where cd_motivo_bloqueio	   in ('004',:ps_cd_bloq_conv_nao_rec)
	  and cd_convenio 	    		= :pl_cd_convenio
	  and cd_conveniado      		= :ps_cd_conveniado
  	  and id_tipo_bloqueio 	 		= 'CDO'
	  and dh_liberacao            is Null	 ;
		 
	If SqlCa.SqlCode = -1 Then		 
		SqlCa.of_MsgdbError("Erro na libera$$HEX2$$e700e300$$ENDHEX$$o do conveniado: " + ps_cd_conveniado + " ")
		Return False
	End If
	//Se o convenio for da Embraco, libera bloqueio com motivo: SI1 ou 016 ou 203
ElseIf pl_cd_convenio = 50139 or pl_cd_convenio = 52725 Then

	Update bloqueio
		Set dh_liberacao           = :pdt_atualizacao,
		    nr_matricula_liberacao = :lvs_nr_matricula_liberacao
	where cd_motivo_bloqueio	   in ('016','203',:ps_cd_bloq_conv_nao_rec)
	  and cd_convenio 	    		= :pl_cd_convenio
	  and cd_conveniado      		= :ps_cd_conveniado
  	  and id_tipo_bloqueio 	 		= 'CDO'
	  and dh_liberacao            is Null	 ;
		 
	If SqlCa.SqlCode = -1 Then		 
		SqlCa.of_MsgdbError("Erro na libera$$HEX2$$e700e300$$ENDHEX$$o do conveniado: " + ps_cd_conveniado + " ")
		Return False
	End If
Else
	// libera bloqueio com motivo: SI1 
	Update bloqueio
		Set dh_liberacao           = :pdt_atualizacao,
			 nr_matricula_liberacao = :lvs_nr_matricula_liberacao
	where cd_motivo_bloqueio		= :ps_cd_bloq_conv_nao_rec
	  and cd_convenio 	    		= :pl_cd_convenio
	  and cd_conveniado      		= :ps_cd_conveniado
	  and id_tipo_bloqueio 	 		= 'CDO'
	  and dh_liberacao            is Null ;
		 
	If SqlCa.SqlCode = -1 Then		 
		SqlCa.of_MsgdbError("Erro na libera$$HEX2$$e700e300$$ENDHEX$$o do conveniado: " + ps_cd_conveniado + " ")
		Return False
	End If
End If

Return True
end function

public function boolean of_bloqueia_depend_conv_nao_atualizado (long pl_convenio, string ps_usuario, long pl_filial, string ps_motivo_bloqueio, datetime pdt_alteracao);Long lvl_Bloqueio, &
     lvl_Max, &
	  lvl_Contador

Integer lvi_Dependente

String lvs_Conveniado

// Verifica quais os dependentes dos conveniados cuja data de atualiza$$HEX2$$e700e300$$ENDHEX$$o seja menor
// que a $$HEX1$$fa00$$ENDHEX$$ltima data de atualiza$$HEX2$$e700e300$$ENDHEX$$o do conv$$HEX1$$ea00$$ENDHEX$$nio

dc_uo_ds_Base lvds_1
lvds_1 = Create dc_uo_ds_Base
If Not lvds_1.of_ChangeDataObject("ds_dependente_conveniado_nao_atualizado") Then Return False

Open(w_Aguarde)
w_Aguarde.Title = "Bloqueando Dependentes dos Conveniados n$$HEX1$$e300$$ENDHEX$$o Atualizados..."

lvl_Max = lvds_1.Retrieve(pl_Convenio, ps_Motivo_Bloqueio)

w_Aguarde.uo_progress.of_SetMax(lvl_Max)

If lvl_Max > 0 Then
	lvl_Bloqueio   = This.of_Proximo_Bloqueio(pl_Filial)
	
	For lvl_Contador = 1 To lvl_Max

		lvs_Conveniado = lvds_1.Object.Cd_Conveniado[lvl_Contador]
		lvi_Dependente = lvds_1.Object.Cd_Dependente[lvl_Contador]				
		
		Insert Into bloqueio (cd_filial,
									 nr_bloqueio,
									 id_tipo_bloqueio,
									 cd_motivo_bloqueio,
									 dh_bloqueio,
									 nr_matricula_bloqueio,
									 cd_convenio,
									 cd_conveniado,
									 cd_dependente)
		Values(:pl_Filial,
				 :lvl_bloqueio,
				 'DCO',
				 :ps_motivo_bloqueio,
				 :pdt_alteracao,
				 :ps_usuario,
				 :pl_convenio,
				 :lvs_conveniado,
				 :lvi_dependente)
		Using SqlCa;
				 
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgdbError("Erro na inclus$$HEX1$$e300$$ENDHEX$$o do bloqueio.")
			Return False
		End If

		w_Aguarde.uo_Progress.of_SetProgress(lvl_Contador)
		lvl_Bloqueio ++
	Next	
End If

Destroy(lvds_1)
Close(w_Aguarde)

Return True
end function

on uo_conveniado.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_conveniado.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;Select cd_filial, 
       cd_filial_matriz
Into :This.ivl_Filial_Parametro,
     :This.ivl_Filial_Matriz
From parametro
Where id_parametro = '1'
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Filial dos par$$HEX1$$e200$$ENDHEX$$metros n$$HEX1$$e300$$ENDHEX$$o localizada.", StopSign!)
		SetNull(This.ivl_Filial_Parametro)		
		SetNull(This.ivl_Filial_Matriz)				
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o da filial dos par$$HEX1$$e200$$ENDHEX$$metros." + SqlCa.SqlErrText, StopSign!)
		SetNull(This.ivl_Filial_Parametro)
		SetNull(This.ivl_Filial_Matriz)				
End Choose
end event

