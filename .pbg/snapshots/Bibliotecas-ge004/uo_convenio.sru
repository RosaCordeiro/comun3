HA$PBExportHeader$uo_convenio.sru
forward
global type uo_convenio from nonvisualobject
end type
end forward

global type uo_convenio from nonvisualobject
end type
global uo_convenio uo_convenio

type variables
CONSTANT Long CD_CONVENIO_UNIMED_INJETAVEIS = 54786

Long ivl_Filial_Parametro, &
         ivl_Filial_Matriz

Boolean localizado

Long cd_convenio, &
         cd_portador, &
         cd_filial_centralizadora

String nm_fantasia ,&
          de_endereco, &
          de_bairro, &
          nr_cep, &
          nr_cgc, &
          nr_telefone, &
          nm_razao_social, &
          cd_unidade_federacao, &
          nm_cidade_convenio, &
          id_ordem_compra, &
          id_paga_comissao,&
          cd_convenio_edm,&
          id_venda_disque_entrega,&   
          id_cartao_magnetico,&   
          id_matricula_cartao, &
          id_senha_cartao,&
          de_senha_padrao,&
          id_clube_drogaria,&
          de_endereco_email_envio_xml,&
          nr_inscricao_estadual, &
	     de_endereco_email, &
		 id_gera_nfe, &
		 id_convenio_pbm

String nr_endereco
String id_imprime_comprovante_venda
String id_permite_ecommerce

Integer qt_dias_vencimento, &
            nr_dia_base, &
		   nr_dia_vencimento_titulo

Long    nr_ultimo_lote, cd_cidade

Decimal pc_abatimento_titulo, &
              pc_desconto_taxa_entrega

DateTime dh_atualizacao_conveniado

dc_uo_ds_base ids_contratos_bin
									
end variables

forward prototypes
public subroutine of_localiza_generica (string ps_parametro)
public subroutine of_localiza_convenio (string ps_parametro)
public subroutine of_inicializa ()
public subroutine of_localiza_codigo (long pl_convenio)
public function boolean of_verifica_bloqueio_matriz (long pl_convenio, string ps_conveniado, long pl_dependente, ref string ps_matricula)
public subroutine of_localiza_cnpj (string ps_cnpj)
public function boolean of_verifica_contrato (string ps_cartao, ref long pl_convenio, ref datastore pds_contratos)
public function boolean of_verifica_contrato_sem_cartao (long pl_convenio, ref datastore pds_contratos)
public function boolean of_is_convenio_unimed_injetaveis (long al_convenio)
public function boolean of_verifica_contrato_injetaveis (string ps_cartao, long pl_convenio, ref datastore pds_contratos)
public function boolean of_valida_cartao_desconto_saude (long al_convenio, string as_tipo_cartao, string as_cartao, string as_nome, boolean ab_cartao_validado, ref long al_convenio_contrato)
end prototypes

public subroutine of_localiza_generica (string ps_parametro);String lvs_Convenio

If gvo_Aplicacao.ivo_seguranca.cd_sistema = 'CL' Then
	OpenWithParm(w_ge004_Selecao_Convenio_Paf, ps_Parametro)
Else
	OpenWithParm(w_ge004_Selecao_Convenio, ps_Parametro)	
End If

lvs_Convenio = Message.StringParm

If Not IsNull(lvs_Convenio) Then
	of_Localiza_Codigo(Long(lvs_Convenio))
Else
	Localizado = False
End If
end subroutine

public subroutine of_localiza_convenio (string ps_parametro);Integer lvi_Tamanho

lvi_Tamanho = LenA(ps_Parametro)

// Verifica se foi recebido algum par$$HEX1$$e200$$ENDHEX$$metro
If lvi_Tamanho > 0 Then
	
	// Verifica o tipo do par$$HEX1$$e200$$ENDHEX$$metro recebido
	If IsNumber(ps_Parametro) Then
		
		If lvI_Tamanho > 5 Then
			// Localiza$$HEX2$$e700e300$$ENDHEX$$o direta pelo CNPJ
			of_Localiza_CNPJ(ps_Parametro)
		Else
			// Localiza$$HEX2$$e700e300$$ENDHEX$$o direta pelo c$$HEX1$$f300$$ENDHEX$$digo do conv$$HEX1$$ea00$$ENDHEX$$nio
			of_Localiza_Codigo(Long(ps_Parametro))
		End If

		If Not Localizado Then
			// Se n$$HEX1$$e300$$ENDHEX$$o localizar pelos m$$HEX1$$e900$$ENDHEX$$todos anteriores
			// Abre a janela de localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica
			of_Localiza_Generica("")	
		End If	
	Else	
		// Localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica conforme o nome do cliente
		of_Localiza_Generica(ps_Parametro)
	End If	
Else
	
	// Localiza$$HEX2$$e700e300$$ENDHEX$$o gen$$HEX1$$e900$$ENDHEX$$rica sem par$$HEX1$$e200$$ENDHEX$$metros
	of_Localiza_Generica("")
End If
end subroutine

public subroutine of_inicializa ();SetNull(cd_convenio)

SetNull(Nm_Fantasia)
SetNull(Nm_Razao_Social)
SetNull(id_imprime_comprovante_venda)

id_permite_ecommerce = 'N'
end subroutine

public subroutine of_localiza_codigo (long pl_convenio);If This.ivl_Filial_Parametro <> This.ivl_Filial_Matriz Then
	// Filial	
	Select cd_convenio,
			nm_fantasia,
			 nr_ultimo_lote,
			 cd_portador,
			 qt_dias_vencimento,
			 pc_abatimento_titulo,
			 nr_cgc,
			 de_endereco,
			 de_bairro,
			 nr_cep,
			 convenio.cd_cidade,
			 nr_telefone,
			 nm_razao_social,
			 cd_unidade_federacao,
			 nm_cidade,
			 nr_dia_base,
			 id_ordem_compra, 
			 cd_filial_centralizadora,
			 id_paga_comissao,
			 dh_atualizacao_conveniado,
			 pc_desconto_taxa_entrega,
			 cd_convenio_edm,
			 id_venda_disque_entrega,
			 id_cartao_magnetico, 
			 id_matricula_cartao,
			 id_senha_cartao,
			 de_senha_padrao,
			 id_clube_drogaria,
			 de_endereco_email_envio_xml,
			 nr_inscricao_estadual,
			 nr_endereco,
			 COALESCE(id_imprime_comprovante_venda, 'S'),
			 COALESCE(id_permite_ecommerce, 'N')
	Into :cd_convenio,
		  :nm_fantasia,
		  :nr_ultimo_lote,
		  :cd_portador,
		  :qt_dias_vencimento,
		  :pc_abatimento_titulo,
		  :nr_cgc,
		  :de_endereco,
		  :de_bairro,
		  :nr_cep,
		  :cd_cidade,
		  :nr_telefone,
		  :nm_razao_social,
		  :cd_unidade_federacao,
		  :nm_cidade_convenio,
		  :nr_dia_base,
		  :id_ordem_compra,
		  :cd_filial_centralizadora,
		  :id_paga_comissao,
		  :dh_atualizacao_conveniado,	  
		  :pc_desconto_taxa_entrega,
		  :cd_convenio_edm,
		  :id_venda_disque_entrega,   
		  :id_cartao_magnetico,  
		  :id_matricula_cartao,
		  :id_senha_cartao,
		  :de_senha_padrao,
		  :id_clube_drogaria,
		  :de_endereco_email_envio_xml,
		  :nr_inscricao_estadual,
		  :nr_endereco,
		  :id_imprime_comprovante_venda,
		  :id_permite_ecommerce
	From convenio, cidade
	Where cd_convenio      = :pl_convenio
	  and cidade.cd_cidade = convenio.cd_cidade
	 Using SqlCa;
Else
	// Matriz
	Select cd_convenio,
			nm_fantasia,
			 nr_ultimo_lote,
			 cd_portador,
			 qt_dias_vencimento,
			 pc_abatimento_titulo,
			 nr_cgc,
			 de_endereco,
			 de_bairro,
			 nr_cep,
			 convenio.cd_cidade,
			 nr_telefone,
			 nm_razao_social,
			 cd_unidade_federacao,
			 nm_cidade,
			 nr_dia_base,
			 id_ordem_compra, 
			 cd_filial_centralizadora,
			 id_paga_comissao,
			 dh_atualizacao_conveniado,
			 pc_desconto_taxa_entrega,
			 cd_convenio_edm,
			 id_venda_disque_entrega,
			 id_cartao_magnetico, 
			 id_matricula_cartao,
			 id_senha_cartao,
			 de_senha_padrao,
			 id_clube_drogaria,
			 de_endereco_email,
			 de_endereco_email_envio_xml,
			 nr_inscricao_estadual,
			 nr_dia_vencimento_titulo,
			 id_gera_nfe,
			 nr_endereco,
			 coalesce(id_convenio_pbm, 'N'),
			  COALESCE(id_imprime_comprovante_venda, 'S'),
			  COALESCE(id_permite_ecommerce, 'N')				
	Into :cd_convenio,
		  :nm_fantasia,
		  :nr_ultimo_lote,
		  :cd_portador,
		  :qt_dias_vencimento,
		  :pc_abatimento_titulo,
		  :nr_cgc,
		  :de_endereco,
		  :de_bairro,
		  :nr_cep,
		  :cd_cidade,
		  :nr_telefone,
		  :nm_razao_social,
		  :cd_unidade_federacao,
		  :nm_cidade_convenio,
		  :nr_dia_base,
		  :id_ordem_compra,
		  :cd_filial_centralizadora,
		  :id_paga_comissao,
		  :dh_atualizacao_conveniado,	  
		  :pc_desconto_taxa_entrega,
		  :cd_convenio_edm,
		  :id_venda_disque_entrega,   
		  :id_cartao_magnetico,  
		  :id_matricula_cartao,
		  :id_senha_cartao,
		  :de_senha_padrao,
		  :id_clube_drogaria,
		  :de_endereco_email,
		  :de_endereco_email_envio_xml,
		  :nr_inscricao_estadual,
		  :nr_dia_vencimento_titulo,
		  :id_gera_nfe,
		  :nr_endereco,
		  :id_convenio_pbm,
		  :id_imprime_comprovante_venda,
		  :id_permite_ecommerce
	From convenio, cidade
	Where cd_convenio      = :pl_convenio
	  and cidade.cd_cidade = convenio.cd_cidade
	 Using SqlCa;	
End If	 
  
Choose Case SqlCa.SqlCode
	Case 0		
		If Trim(cd_convenio_edm) = '' Then SetNull(cd_convenio_edm) 
		
		Localizado = True		
		
	Case 100
		Localizado = False
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do conv$$HEX1$$ea00$$ENDHEX$$nio." + SqlCa.SqlErrText, StopSign!)
		Localizado = False
End Choose
end subroutine

public function boolean of_verifica_bloqueio_matriz (long pl_convenio, string ps_conveniado, long pl_dependente, ref string ps_matricula);Boolean lb_Bloqueado
Boolean lb_Sucesso
Boolean lb_Liberacao

String ls_SQL,&
		 ls_SQL1,&
       ls_SQL2,&
		 ls_SQL3,&
		 ls_Select
		 
String ls_Banco		 
String ls_Retorno
String ls_Erro
String ls_Sintaxe
String ls_Permite_Liberacao

Long	 ll_Row

ls_Select =  	"select b.id_tipo_bloqueio as id_tipo_bloqueio,"				+ CharA(13) + CharA(10) + &
						"       b.cd_motivo_bloqueio as cd_motivo_bloqueio,"		+ CharA(13) + CharA(10) + &
						"       m.de_motivo_bloqueio as de_motivo_bloqueio,"	+ CharA(13) + CharA(10) + &
						"       m.id_permite_liberacao as id_permite_liberacao"	+ CharA(13) + CharA(10) + &
						"  from bloqueio b, motivo_bloqueio m"						+ CharA(13) + CharA(10)
					
ls_SQL1 = ls_Select + &         
   		  " where m.cd_motivo_bloqueio = b.cd_motivo_bloqueio and b.dh_liberacao is null and" + CharA(13) + CharA(10) + &
			  "       b.cd_convenio = " + String(pl_Convenio) + " and" + CharA(13) + CharA(10) + &
			  "       b.id_tipo_bloqueio = 'CON'"
		  
ls_SQL2 = ls_Select + &
   		  " Where m.cd_motivo_bloqueio = b.cd_motivo_bloqueio and b.dh_liberacao is null and" + CharA(13) + CharA(10) + &
			  "       b.cd_convenio = " + String(pl_Convenio) + " and" + CharA(13) + CharA(10) + &
			  "       b.cd_conveniado = '" + ps_Conveniado + "' and" + CharA(13) + CharA(10) + &
			  "       b.id_tipo_bloqueio = 'CDO'"
			  
ls_SQL3 = ls_Select + &
   		  " Where m.cd_motivo_bloqueio = b.cd_motivo_bloqueio and b.dh_liberacao is null and" + CharA(13) + CharA(10) + &
			  "       b.cd_convenio = " + String(pl_Convenio) + " and" + CharA(13) + CharA(10) + &
			  "       b.cd_conveniado = '" + ps_Conveniado + "' and" + CharA(13) + CharA(10) + &
			  "       b.cd_dependente = " + String(pl_Dependente) + " and" + CharA(13) + CharA(10) + &
			  "       b.id_tipo_bloqueio = 'DCO'"
			  
ls_SQL = ls_SQL1 + CharA(13) + CharA(10) + "UNION" + CharA(13) + CharA(10) + ls_SQL2			  

If Not IsNull(pl_Dependente) Then
	ls_SQL += CharA(13) + CharA(10) + "UNION" + CharA(13) + CharA(10) + ls_SQL3
End If

// Determina a sintaxe para cria$$HEX2$$e700e300$$ENDHEX$$o da datawindow
ls_Sintaxe = SqlCa.SyntaxFromSQL(ls_SQL, "Style(Type=Grid)", ls_Erro)

// Cria a datastore
DataStore lvds_1
lvds_1 = Create DataStore

lvds_1.Create(ls_Sintaxe, ls_Erro)

If Trim(ls_Erro) <> "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na cria$$HEX2$$e700e300$$ENDHEX$$o da datastore para consulta dos bloqueios.~n~n" + ls_Erro)
	Return False
End If

uo_Transacao_Remota lvo_Conexao
lvo_Conexao = Create uo_Transacao_Remota

lvo_Conexao.of_BancoProducao()

lvo_Conexao.of_executa_Rotina('00006',{ls_SQL})

If lvo_Conexao.of_Erro_Execucao() Then lvo_Conexao.of_MsgError("Localiza$$HEX2$$e700e300$$ENDHEX$$o de bloqueio Conv$$HEX1$$ea00$$ENDHEX$$nio")

ls_Select = lvds_1.Object.DataWindow.Table.Select

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
			ls_Permite_Liberacao = lvds_1.object.id_permite_liberacao[ll_Row]
			
			If ls_Permite_Liberacao = "N" Then
				lb_Liberacao = False	// Bloqueado sem permiss$$HEX1$$e300$$ENDHEX$$o para libera$$HEX2$$e700e300$$ENDHEX$$o
				Exit
			End If
		Next
	
	End If
	
	If lb_Bloqueado Then

		If lb_Liberacao Then
			If gvo_Aplicacao.ivo_seguranca.cd_sistema = 'CL' Then
				gvo_Aplicacao.of_Grava_Log( "GE005-uo_convenio - of_verifica_bloqueio_matriz - Encontrou bloqueio que pode ser liberado. Consulta: " + ls_banco )
				OpenWithParm(w_ge004_bloqueio_paf,'0')
			Else
				OpenWithParm(w_ge004_bloqueio,'0')				
			End If
		Else
			If gvo_Aplicacao.ivo_seguranca.cd_sistema = 'CL' Then
				gvo_Aplicacao.of_Grava_Log( "GE005-uo_convenio - of_verifica_bloqueio_matriz - Encontrou bloqueio que N$$HEX1$$c300$$ENDHEX$$O pode ser liberado. Consulta: " + ls_banco )				
				OpenWithParm(w_ge004_bloqueio_paf,'100')
			Else
				OpenWithParm(w_ge004_bloqueio,'100')				
			End If
		End If	
			
		Choose Case Message.StringParm
			Case "CANCELAR"
				lb_Bloqueado = True
			Case "DETALHES"
				
				uo_ge004_Parametro_Controle_Bloqueio lvo_Parametro
				lvo_Parametro = Create uo_ge004_Parametro_Controle_Bloqueio
				
				lvo_Parametro.ivds_1 = lvds_1
				
				lvo_Parametro.ivs_Banco = ls_Banco
				
				If gvo_Aplicacao.ivo_seguranca.cd_sistema = 'CL' Then				
					OpenWithParm(w_ge004_Lista_Bloqueio_Paf, lvo_Parametro)
				Else
					OpenWithParm(w_ge004_Lista_Bloqueio, lvo_Parametro)					
				End If
				
				ls_Retorno = Message.StringParm
		
				If IsNull(ls_Retorno) Then
					lb_Bloqueado = True
				Else
					lb_Bloqueado = False
					
					ps_Matricula = ls_Retorno
				End If
				
				Destroy(lvo_Parametro)		

			Case "LIBERAR"
				If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("LIBERACAO_BLOQUEIO_CLIENTE", ref ps_matricula) Then 
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

public subroutine of_localiza_cnpj (string ps_cnpj);Integer lvi_Cont

Long ll_Convenio

Select count(1)
 Into :lvi_Cont
From convenio
Where nr_cgc = :ps_cnpj
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Erro na verifica$$HEX2$$e700e300$$ENDHEX$$o do conv$$HEX1$$ea00$$ENDHEX$$nio no CNPJ: [" + ps_CNPJ + "] - " + SqlCa.SqlErrText, StopSign!)
	Localizado = False
	Return
End If

If lvi_Cont > 1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Existem dois ou mais conv$$HEX1$$ea00$$ENDHEX$$nios com o CNPJ: [" + ps_CNPJ + "]", Exclamation!)
	Localizado = False
	Return
End If 

Select cd_convenio
 Into :ll_Convenio
From convenio
Where nr_cgc = :ps_cnpj
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		//Localiza pelo cd_convenio
		This.of_localiza_codigo( ll_Convenio )
		
	Case 100
		Localizado = False
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o do conv$$HEX1$$ea00$$ENDHEX$$nio." + SqlCa.SqlErrText, StopSign!)
		Localizado = False
End Choose

end subroutine

public function boolean of_verifica_contrato (string ps_cartao, ref long pl_convenio, ref datastore pds_contratos);//Busca contratos ativos para Descontos de Plano de Saude e verifica se a carteirinha est$$HEX1$$e100$$ENDHEX$$ em algum.
String ls_bin
Long ll_convenio
String ls_convenios

//BIN Cart$$HEX1$$e300$$ENDHEX$$o UNIMED = 4 primeiros dig$$HEX1$$ed00$$ENDHEX$$tos
ls_bin = LeftA(ps_cartao,4)

//Convenio do contrato estar$$HEX1$$e100$$ENDHEX$$ nos parametros
uo_Parametro_Filial lvo_Parametro
lvo_Parametro = Create uo_Parametro_Filial

lvo_Parametro.of_Localiza_Parametro('CD_CONVENIO_DESCONTO', ref ls_convenios, False)

Destroy(lvo_Parametro)

If IsNull(ls_convenios) Or Trim(ls_convenios) = '' Then
	//N$$HEX1$$e300$$ENDHEX$$o tem convenios cadastrados
	Return True
Else
	ls_convenios = Trim(ls_convenios)
	
	dc_uo_ds_base lds_contratos
	lds_contratos = Create dc_uo_ds_base
	
	If Not lds_contratos.of_ChangeDataObject('ds_ge004_contratos_ativos') Then Return False
	
	lds_contratos.of_RestoreSqlOriginal( )
	lds_contratos.of_appendwhere( 'c.cd_convenio in (' + ls_convenios + ')' )
	lds_contratos.Retrieve( ls_bin )
	
	If lds_contratos.RowCount() > 0 Then
		pl_convenio = lds_contratos.object.cd_convenio[1]
		lds_contratos.rowscopy( 1, lds_contratos.RowCount(), Primary!, pds_contratos, 1, Primary!)
	Else
		Return False
	End If
End If

Return True


end function

public function boolean of_verifica_contrato_sem_cartao (long pl_convenio, ref datastore pds_contratos);//Busca contratos ativos para Descontos de Plano de Saude
Long ll_convenio
String ls_convenios
	
dc_uo_ds_base lds_contratos
lds_contratos = Create dc_uo_ds_base

If Not lds_contratos.of_ChangeDataObject('ds_ge004_contratos_ativos_sem_cartao') Then Return False

lds_contratos.of_RestoreSqlOriginal()
lds_contratos.Retrieve(String(pl_convenio))

If lds_contratos.RowCount() > 0 Then
	lds_contratos.rowscopy( 1, lds_contratos.RowCount(), Primary!, pds_contratos, 1, Primary!)
Else
	Return False
End If

Return True


end function

public function boolean of_is_convenio_unimed_injetaveis (long al_convenio);//Aguardando definicao do depto de convenio com o cod correto
//If al_Convenio = This.cd_convenio_unimed_injetaveis Then
//	Return True
//Else
//	Return False
//End If

Return (al_Convenio = This.cd_convenio_unimed_injetaveis)

end function

public function boolean of_verifica_contrato_injetaveis (string ps_cartao, long pl_convenio, ref datastore pds_contratos);//Busca contratos ativos para Descontos de Plano de Saude
Long ll_convenio

String ls_convenios
String ls_Bin

Try	
	//BIN Cart$$HEX1$$e300$$ENDHEX$$o UNIMED = 4 primeiros dig$$HEX1$$ed00$$ENDHEX$$tos
	ls_bin = LeftA(ps_cartao,4)
	
	dc_uo_ds_base lds_contratos
	lds_contratos = Create dc_uo_ds_base
	
	If Not lds_contratos.of_ChangeDataObject( 'ds_ge004_contratos_injetaveis' ) Then Return False
	
	lds_contratos.of_RestoreSqlOriginal()
	lds_contratos.of_appendwhere( "b.cd_convenio = " +String(pl_Convenio) )
	lds_contratos.Retrieve( ls_bin)
	
	If lds_contratos.RowCount() > 0 Then
		lds_contratos.rowscopy( 1, lds_contratos.RowCount(), Primary!, pds_contratos, 1, Primary!)
	Else
		Return False
	End If

	Return True
	
Finally
	If IsValid(lds_contratos) Then Destroy lds_contratos
End Try


end function

public function boolean of_valida_cartao_desconto_saude (long al_convenio, string as_tipo_cartao, string as_cartao, string as_nome, boolean ab_cartao_validado, ref long al_convenio_contrato);Boolean lb_Existe_Contrato = False

String ls_convenios
String ls_resposta
String ls_erro
String ls_rede

Long ll_Convenio
Long ll_status_code

Try
	SetNull(al_Convenio_contrato)
	If Not gf_rede_filial(Ref ls_rede) Then
		Return False
	End If
	
	uo_Transacao_Remota lvo_Conexao
	
	Choose Case as_tipo_cartao
		Case 'UNIMED',	 '1' //Cart$$HEX1$$e300$$ENDHEX$$o UNIMED
		
			If LenA(Trim(as_cartao)) <> 17  Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Cart$$HEX1$$e300$$ENDHEX$$o '" + as_cartao + "' inv$$HEX1$$e100$$ENDHEX$$lido para desconto.", Exclamation!)				
				Return False
			End If
			
			If ls_Rede <> 'DC' And ls_Rede <> 'PP' Then
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Desconto Plano Sa$$HEX1$$fa00$$ENDHEX$$de n$$HEX1$$e300$$ENDHEX$$o liberado para filiais dessa rede.",Exclamation!)
				Return False					
			End If	
			
//			If Not This.ids_contratos_bin.of_ChangeDataObject( 'ds_ge004_contratos_ativos' ) Then 
//				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no evento of_ChangeDataObject. Fun$$HEX2$$e700e300$$ENDHEX$$o: uo_convenio.of_valida_cartao_desconto_saude()")
//				Return False
//			End If
			
			//Todos os contratos ter$$HEX1$$e300$$ENDHEX$$o desconto nos injetaveis
			If This.of_is_convenio_unimed_injetaveis( al_Convenio ) Then
				If This.of_verifica_contrato_injetaveis( as_cartao, al_convenio, Ref This.ids_contratos_bin ) Then
					lb_Existe_Contrato		= ( This.ids_contratos_bin.rowcount( ) > 0 )
					al_Convenio_contrato	= al_Convenio
				End If
			Else
				If LeftA(as_cartao,4) = '0027' Then //Verifica Cart$$HEX1$$e300$$ENDHEX$$o Unimed Joinville se $$HEX1$$e900$$ENDHEX$$ de contratos da Clamed.
					lvo_Conexao = Create uo_Transacao_Remota	
					lvo_Conexao.of_BancoProducao()
					
					SetPointer(HourGlass!)		
					If Not lvo_Conexao.of_verifica_unimed_clamed(as_Cartao) Then
						Return False
					End If		
				End If
				
				If This.of_verifica_contrato(as_cartao, ref ll_convenio, ref This.ids_contratos_bin) Then						
					lb_Existe_Contrato		= ( This.ids_contratos_bin.rowcount( ) > 0 )
					al_Convenio_contrato	= ll_convenio
				End If
				
			End If
					
			
		
		Case 'CLINIPAM', '2' //CLINIPAM
//			ls_DW = 'ds_ge004_contratos_ativos_sem_cartao'
			
			If LenA( Trim(as_cartao) ) > 0 Then
				uo_Parametro_Filial lvo_Parametro
				lvo_Parametro = Create uo_Parametro_Filial
				lvo_Parametro.of_Localiza_Parametro('CD_CONVENIO_DESCONTO', ref ls_convenios, False)
				If IsValid( lvo_Parametro ) Then Destroy( lvo_Parametro )
				
				lvo_Conexao = Create uo_Transacao_Remota
				lvo_Conexao.of_BancoProducao()
				
				If lvo_Conexao.of_verifica_cartao_saude(ls_convenios, as_Cartao, as_tipo_cartao, Ref ll_convenio) Then			
						
//					If Not This.ids_contratos_bin.of_ChangeDataObject( 'ds_ge004_contratos_ativos_sem_cartao' ) Then 
//						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no evento of_ChangeDataObject. Fun$$HEX2$$e700e300$$ENDHEX$$o: uo_convenio.of_valida_cartao_desconto_saude()")
//						Return False
//					End If
					
					If This.of_verifica_contrato_sem_cartao(ll_convenio, ref This.ids_contratos_bin) Then		
						lb_Existe_Contrato 		= ( This.ids_contratos_bin.rowcount( ) > 0 )
						al_Convenio_contrato 	= ll_convenio
					End If
				Else
					Return False
				End If	
			End If	
	
	End Choose
	
	If lb_Existe_Contrato Then
		
		//Aqui consulta WEB service para ver se o cart$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ ativo.
		Choose Case as_Tipo_Cartao
			Case 'UNIMED', '1'
				
				//Se o Cart$$HEX1$$e300$$ENDHEX$$o j$$HEX1$$e100$$ENDHEX$$ foi validado n$$HEX1$$e300$$ENDHEX$$o precisa passar pelo WebService novamente
				//O RL j$$HEX1$$e100$$ENDHEX$$ faz a valida$$HEX2$$e700e300$$ENDHEX$$o do cartao Unimed no atendimento
				If ab_Cartao_validado Then
					Return True
				End If
				
				Try
					uo_ge493_wsunimed lo_ws
					lo_ws = Create uo_ge493_wsunimed
					
					If lo_ws.of_envia_ws( as_cartao, as_nome, Ref ls_resposta, Ref ls_erro, Ref ll_status_code ) Then
						If ls_resposta = 'N' Then
							 MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O cart$$HEX1$$e300$$ENDHEX$$o '" + as_cartao + "' n$$HEX1$$e300$$ENDHEX$$o existe ou n$$HEX1$$e300$$ENDHEX$$o est$$HEX1$$e100$$ENDHEX$$ ativo na operadora.", Exclamation!)
							 Return False
						End If
					Else
						//Unimed Injetaveis nao deve prosseguir em caso de erro na consulta da API
						If This.of_is_convenio_unimed_injetaveis( al_Convenio_contrato ) Then
							MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro consulta: " + ls_resposta +' '+ ls_erro , StopSign!)   
							Return False
						Else				
							If ll_status_code = 404 Or ll_status_code = 500 Then //erro de conexao ou erro interno do WebService   
								 MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na Consulta com a operadora. ~n" + &
																			"Ser$$HEX1$$e100$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio fazer a confirma$$HEX2$$e700e300$$ENDHEX$$o de documentos com o cliente." , Information!)       
							Else
								 MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro consulta: " + ls_resposta +' '+ ls_erro , StopSign!)                       
								 Return False
							End If               
							
						End If
					End If
				Finally
					If IsValid(lo_ws) Then Destroy(lo_ws)       
				End Try
			Case Else
				//Web service nao implementado
				//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", 'Web Service n$$HEX1$$e300$$ENDHEX$$o implementado para o tipo de cart$$HEX1$$e300$$ENDHEX$$o: ' + as_Tipo_Cartao, Exclamation! )
		End Choose
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Cart$$HEX1$$e300$$ENDHEX$$o '" + as_cartao + "' sem contrato de desconto ativo.", Exclamation!)	
		Return False
	End If

	Return True
	
Finally	
	If IsValid(lvo_Conexao) Then Destroy lvo_Conexao
End Try
	

end function

on uo_convenio.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_convenio.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ids_contratos_bin = Create dc_uo_ds_base
ids_contratos_bin.of_changedataobject( "ds_ge004_contratos_ativos" )


Select cd_filial, 
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

This.of_Inicializa()
end event

