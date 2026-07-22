HA$PBExportHeader$uo_ge473_comum.sru
forward
global type uo_ge473_comum from nonvisualobject
end type
end forward

global type uo_ge473_comum from nonvisualobject
end type
global uo_ge473_comum uo_ge473_comum

type variables
dc_uo_ds_base 	ids_lista_registros
dc_uo_transacao 	io_SqlCa

string is_coluna[]
	
boolean ib_troca_ds_com_text = false

end variables

forward prototypes
public function boolean of_muda_situacao_interface (long al_controle, ref string as_log)
public function boolean of_verifica_obrigatoriedade_campo (string as_campo, string as_obrigatoriedade, string as_valor, ref string as_log)
public function boolean of_decimal (string as_valor, string as_coluna, ref decimal adc_valor, ref string as_log)
public function boolean of_localiza_codigo_produto_legado (string as_cd_produto_sap, ref long al_produto, ref string as_log)
public function boolean of_grava_erro (long al_controle, long al_cd_mensagem_email, string as_erro)
public function boolean of_date_time (string as_valor, string as_coluna, ref datetime adh_valor, ref string as_log)
public function boolean of_localiza_codigo_filial_legado (string as_filial_sap, ref long al_filial, ref string as_log)
public function boolean of_localiza_codigo_fornecedor_legado (string as_fornecedor_sap, ref string as_fornecedor, ref string as_log)
public function boolean of_monta_ds_dinamica (longlong all_controle, long al_tabela, ref string as_log)
public function boolean of_carrega_colunas_ds (ref string as_log)
public function boolean of_carrega_dados (longlong all_controle, long al_tabela, ref string as_log)
public function boolean of_localiza_codigo_filial_sap (long al_filial_legado, ref string as_filial_sap, ref string as_log)
public function boolean of_processa_carrega_dados (longlong all_controle, ref string as_log)
public function boolean of_localiza_chave_controle (long al_controle, ref string as_chave, ref string as_log)
public function boolean of_localica_codigo_promocao_legado (long al_promocao_sap, ref string al_promocao, ref string as_log)
public function boolean of_localiza_codigo_promocao_legado (string as_cd_promocao_sap, ref long al_promocao, ref string as_log)
public function boolean of_localiza_motivo_esb (string as_cd_motivo, ref string as_descricao, ref string as_log)
public function boolean of_atualizacao_pendente (long al_controle, ref long al_registro_pendente, ref string as_log)
public function boolean of_grava_log_exportacao (str_log_export_sap pst_dados, ref string ps_log)
public function boolean of_date_time_gmt (string as_valor, string as_coluna, ref datetime adh_valor, ref string as_log)
public function boolean of_decimal (string as_valor, string as_coluna, ref decimal adc_valor, ref string as_log, boolean ab_devolve_zero)
public function boolean of_localiza_codigo_filial_legado (long al_filial_sap, ref string as_filial_legado, ref string as_log)
public function string of_busca_valor (string as_xml, string as_tag, long al_pos)
public function boolean of_localiza_codigo_comprador_legado (string as_comprador_sap, ref string as_matricula, ref string as_log)
public function boolean of_grava_erro (long al_controle, long al_cd_mensagem_email, string as_erro, boolean ab_envia_email)
public function boolean of_localiza_condicao_pagto_legado (string as_codigo_pagamento_sap, ref long al_codigo_pagamento_legado, ref string as_log)
public function boolean of_processa_carrega_dados_v2 (longlong all_controle, ref string as_log)
public function boolean of_processa_carrega_dados_v3 (longlong all_controle, ref string as_log)
public subroutine of_connect_io_sqlca ()
public function boolean of_time (string as_hora_sap, string as_coluna, ref time atm_valor, ref string as_log)
public function boolean of_date_time (string as_data, string as_hora, string as_coluna, ref datetime adh_retorno, ref string as_log)
public function boolean of_verifica_registro_pendente (long al_controle, ref boolean ab_registro_pendente, ref string as_log)
public function boolean of_localiza_codigo_fornecedor_legado (string as_fornecedor_sap, ref string as_fornecedor, boolean ab_busca_fornecedor_inativo, ref string as_log)
public function boolean of_localiza_codigo_parceiro_legado (string as_parceiro_sap, ref long al_parceiro, ref string as_log)
end prototypes

public function boolean of_muda_situacao_interface (long al_controle, ref string as_log);String lvs_Host, lvs_Ip

Try
	
	lvs_Host = gvo_Aplicacao.ivo_Seguranca.of_Get_is_Host()
	lvs_Ip 	= gvo_Aplicacao.ivo_Seguranca.of_Get_is_Ip()
	
	Update interface_sap
	set	id_situacao 	= 'P', //Processado
		dh_processamento 	= getdate(),
		de_erro 				= null,
		cd_sistema 			= :gvo_Aplicacao.ivo_Seguranca.cd_Sistema,
		nr_versao_sistema = :gvo_Aplicacao.ivs_Versao,
		de_host 				= :lvs_Host,
		de_ip					= :lvs_Ip
	Where nr_controle = :al_controle
	Using SqlCa;
	
	If SqlCa.sqlcode = -1 Then
		as_Log	= "Erro ao mudar a situa$$HEX2$$e700e300$$ENDHEX$$o na tabela interface_sap. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle)+". Erro: "+SqlCa.sqlErrText
		 Return False
	End If
	
Catch ( runtimeerror  lo_rte )
	    as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_muda_situacao_interface'. Erro: "+lo_rte.GetMessage( )
	    Return False						 
End Try	

Return True
end function

public function boolean of_verifica_obrigatoriedade_campo (string as_campo, string as_obrigatoriedade, string as_valor, ref string as_log);Try
	If as_obrigatoriedade = 'S' Then
		If IsNull(as_valor) or Trim(as_valor) = "" Then
			as_log = "Preechimento do campo '"+as_campo+"' $$HEX1$$e900$$ENDHEX$$ obrigat$$HEX1$$f300$$ENDHEX$$rio"
			Return False
		End If
	End If
Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_verifica_obrigatoriedade_campo'. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try		

Return True


end function

public function boolean of_decimal (string as_valor, string as_coluna, ref decimal adc_valor, ref string as_log);Return of_Decimal(as_valor, as_coluna, ref adc_valor, ref as_log, False)
end function

public function boolean of_localiza_codigo_produto_legado (string as_cd_produto_sap, ref long al_produto, ref string as_log);as_cd_produto_sap = gf_Tira_Zero_Esquerda(as_cd_produto_sap)

If Isnull (as_cd_produto_sap) then 
	as_Log	= "C$$HEX1$$f300$$ENDHEX$$digo do produto SAP est$$HEX1$$e100$$ENDHEX$$ nulo. Favor verifique."  
	Return False
End If

Select cd_produto
  Into :al_Produto
  From produto_geral
 Where cd_produto_sap	= :as_cd_produto_sap
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 100
		Select cd_tipo_produto
		into :al_produto
		from wms_produto_sucata
		Where cd_produto_sap	= :as_cd_produto_sap
		Using SqlCa;
			
		Choose Case SqlCa.SqlCode
			Case 100
				as_Log	= "Nenhum produto foi localizado em nossa base de dados com o c$$HEX1$$f300$$ENDHEX$$digo SAP:"+as_cd_produto_sap+". Favor verifique."
				Return False
			Case -1
				as_Log	= "Erro ao localizar um produto com o c$$HEX1$$f300$$ENDHEX$$digo SAP ("+as_cd_produto_sap+"). Erro: " + SqlCa.SqlErrText
				Return False
		End Choose
	Case -1
		as_Log	= "Erro ao localizar um produto com o c$$HEX1$$f300$$ENDHEX$$digo SAP ("+as_cd_produto_sap+"). Erro: " + SqlCa.SqlErrText
		Return False
End Choose

Return True
end function

public function boolean of_grava_erro (long al_controle, long al_cd_mensagem_email, string as_erro);String	ls_Erro
String ls_Msg_Email
String ls_NM_Interface
String lvs_Host, lvs_Ip

Select t.de_tabela 
Into :ls_NM_Interface
From interface_sap i
inner join tabela_interface_sap t
	on t.cd_tabela = i.cd_tabela
where i.nr_controle = :al_controle
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_Erro	=  SqlCa.SqlerrText
	SqlCa.of_Rollback()
	as_erro	= "Erro ao localizar o nome da interface: " +ls_Erro
	Return False
End If

lvs_Host = gvo_Aplicacao.ivo_Seguranca.of_Get_is_Host()
lvs_Ip 	= gvo_Aplicacao.ivo_Seguranca.of_Get_is_Ip()

Update interface_sap
Set	de_erro				= :as_erro,
		id_situacao			= 'E',
		cd_sistema 			= :gvo_Aplicacao.ivo_Seguranca.cd_Sistema,
		nr_versao_sistema = :gvo_Aplicacao.ivs_Versao,
		de_host 				= :lvs_Host,
		de_ip					= :lvs_Ip
Where nr_controle =:al_controle
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_Erro	=  SqlCa.SqlerrText
	SqlCa.of_Rollback()
	as_erro	= "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do erro na tabela [interface_sap]: " +ls_Erro
	Return False
End If

If SqlCa.SqlnRows = 0 Then 
	SqlCa.of_Rollback()
	as_erro = "Nenhum registro foi atualizado na tabela 'interface_sap'. Fun$$HEX2$$e700e300$$ENDHEX$$o 'wf_grava_erro'."
	Return False
End If

If SqlCa.SqlnRows > 1 Then 
	SqlCa.of_Rollback()
	as_erro	= "Foram encontrados mais de um registro para a atualiza$$HEX2$$e700e300$$ENDHEX$$o de erro para o controle '" + String(al_controle) + "'."
	Return False
End If

SqlCa.of_Commit()

ls_Msg_Email = 'Houveram problemas na interface de descida do SAP . <br>'+ &
					 'Interface:<b>' + ls_NM_Interface + '</b><br>'+ &
					 'Controle:' + String(al_Controle) + ' <br>'+ &
					 '</ul></ul>'+&
					 as_erro

gf_ge202_envia_email_automatico(al_Cd_Mensagem_Email , '', ls_Msg_Email, {''})

Return True
end function

public function boolean of_date_time (string as_valor, string as_coluna, ref datetime adh_valor, ref string as_log);
If Trim(as_Valor) =  ''  or isnull( as_Valor ) Then
	SetNull( adh_valor )
Else
	Exception lo_Exp
	lo_Exp = CREATE Exception
	lo_Exp.setMessage("O campo nao contem uma data")
	
	Try
		//20210423
		If len( trim( as_Valor ) ) = 8 Then
			as_Valor = Mid(as_Valor, 1, 4) + '/' + Mid(as_Valor, 5, 2) + '/' + Mid(as_Valor, 7, 2)
		End If
				
		If len( trim( as_Valor ) ) < 10 then
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

public function boolean of_localiza_codigo_filial_legado (string as_filial_sap, ref long al_filial, ref string as_log);If Trim(as_Filial_Sap) = "" Then
	SetNull(al_Filial)
	
	Return True
End If

if as_Filial_Sap = '1001' then
	SetNull(al_Filial)
	
	as_log = "Filial n$$HEX1$$e300$$ENDHEX$$o permitida para integra$$HEX2$$e700e300$$ENDHEX$$o com o legado. Filial: " + as_Filial_Sap
	
	Return False
end if

Select cd_chave_legado
  Into :al_Filial
  From integracao_sap
 Where cd_tabela = 'FILIAL'
	And cd_chave_sap	= :as_Filial_Sap
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 100
		if IsNull(as_filial_sap) then as_filial_sap = '(C$$HEX1$$f300$$ENDHEX$$digo n$$HEX1$$e300$$ENDHEX$$o enviado)'
		
		as_Log	= "N$$HEX1$$e300$$ENDHEX$$o foi localizado na tabela 'INTEGRA$$HEX2$$c700c200$$ENDHEX$$O SAP', o c$$HEX1$$f300$$ENDHEX$$digo da filial, com o c$$HEX1$$f300$$ENDHEX$$digo SAP '"+as_Filial_Sap+"'."
		Return False
	Case -1
		as_Log	= "Erro ao localizar o c$$HEX1$$f300$$ENDHEX$$digo da filial no legado: " + SqlCa.SqlErrText
		Return False
End Choose

Return True
end function

public function boolean of_localiza_codigo_fornecedor_legado (string as_fornecedor_sap, ref string as_fornecedor, ref string as_log);return of_localiza_codigo_fornecedor_legado(as_fornecedor_sap, REF as_fornecedor, false, REF as_log)
end function

public function boolean of_monta_ds_dinamica (longlong all_controle, long al_tabela, ref string as_log);Long ll_Linha_Coluna
Long ll_Linhas_Coluna
Long ll_Tamanho_Coluna

String ls_NM_Coluna
String ls_Lista_Colunas
String ls_Create_Table
String ls_PK_TabTemp
String ls_Drop_Table

String ls_Create_DS
String ls_Erro_Create_DS

// Monta script para montar a DS
dc_uo_ds_base lds_Coluna

try
	// INICIO - RECUPERA OS NOMES DAS COLUNAS PARA MONTAR O SCRIPT PARA MONTAR A DS
	lds_Coluna = Create dc_uo_ds_base 	
	
	of_Connect_io_SqlCa()
	
	io_SqlCa.AutoCommit = True
	
	// Carrega a DS padr$$HEX1$$e300$$ENDHEX$$o que receber$$HEX1$$e100$$ENDHEX$$ os dados da interface
	If Not ids_lista_registros.of_ChangeDataObject("ds_ge473_default_carga_dados", False) Then
		as_log = "Erro ao alterar a DW [ds_ge473_default_carga_dados]. Objeto [uo_ge473_comum], fun$$HEX2$$e700e300$$ENDHEX$$o [of_carrega_dados]."
		Return False
	End If	
	
	If Not lds_Coluna.of_ChangeDataObject("ds_ge473_tabela_interface_sap_definicao", False) Then
		as_log = "Erro ao alterar a DW [ds_ge473_tabela_interface_sap_definicao]. Objeto [uo_ge473_comum], fun$$HEX2$$e700e300$$ENDHEX$$o [of_carrega_dados]."
		Return False
	End If	
	
	ll_Linhas_Coluna = lds_Coluna.Retrieve(al_tabela)
	
	If ll_Linhas_Coluna > 0 Then
		
		For ll_Linha_Coluna = 1 To ll_Linhas_Coluna
			ls_NM_Coluna 			= lds_Coluna.Object.cd_coluna[ll_Linha_Coluna]
			ll_Tamanho_Coluna 	= lds_Coluna.Object.qt_tamanho_coluna[ll_Linha_Coluna]
			
			If IsNull(ll_Tamanho_Coluna) or ll_Tamanho_Coluna = 0 Then ll_Tamanho_Coluna = 10
						
			// Primeira linha
			If ll_Linha_Coluna = 1 Then
				// Se possuir mais de 1 coluna
				//If ll_Linhas_Coluna > 1 Then
					ls_Lista_Colunas += 'nr_registro int not null' + ', '
				//Else
				//	ls_Lista_Colunas += 'nr_registro int not null '
				//End If
			End If
			
			// Se n$$HEX1$$e300$$ENDHEX$$o a ultima linha inclui o ','
			If ll_Linha_Coluna <> ll_Linhas_Coluna Then
				ls_Lista_Colunas += Lower(ls_NM_Coluna) + ' varchar('+String(ll_Tamanho_Coluna) + ') null' + ', '
			Else
				ls_Lista_Colunas += Lower(ls_NM_Coluna) + ' varchar('+String(ll_Tamanho_Coluna) + ') null'
			End If
			
		Next 
		
	ElseIf ll_Linhas_Coluna = 0 Then
		as_log = "N$$HEX1$$e300$$ENDHEX$$o foram localizado as colunas para a tabela '" + String(al_tabela) + "' na DW [ds_ge473_tabela_interface_sap_definicao]. Objeto [uo_ge473_comum], fun$$HEX2$$e700e300$$ENDHEX$$o [of_carrega_dados]."
		Return False
	Else
		as_log = "Erro ao recuperar as colunas da tabela '" + String(al_tabela) + "' na DW [ds_ge473_tabela_interface_sap_definicao]. Objeto [uo_ge473_comum], fun$$HEX2$$e700e300$$ENDHEX$$o [of_carrega_dados]."
		Return False
	End If	
	// FIM - RECUPERA OS NOMES DAS COLUNAS PARA MONTAR O SCRIPT PARA MONTAR A DS
	
	//INICIO - CRIACAO TABELA TEMPORARIA
	If ls_Lista_Colunas <> '' Then
		//s1 = 'create table #temptab1 (id int not null, lname char(20) not null) '
		ls_Create_Table = 'create table #temptab1 (' + ls_Lista_Colunas + ') '
	Else
		as_log = "N$$HEX1$$e300$$ENDHEX$$o localizado a lista das colunas da tabela '" + String(al_tabela) + "' para montar a tabela tempor$$HEX1$$e100$$ENDHEX$$ria. Objeto [uo_ge473_comum], fun$$HEX2$$e700e300$$ENDHEX$$o [of_carrega_dados]." + 'Erro '  + io_SqlCa.SqlErrText
		Return False
	End If
	
	ls_Drop_Table = 'drop table #temptab1'
	Execute Immediate :ls_Drop_Table Using io_SqlCa;
	If io_SqlCa.sqlcode <> 0 Then
//		as_log = "Erro ao dropar a tabela tempor$$HEX1$$e100$$ENDHEX$$ria. Objeto [uo_ge473_comum], fun$$HEX2$$e700e300$$ENDHEX$$o [of_carrega_dados]." + 'Erro '  + io_SqlCa.SqlErrText
//		Return False
	End If
	
	Execute Immediate :ls_Create_Table Using io_SqlCa;

	If io_SqlCa.sqlcode = 0 Then
		// Cria a pk da tabela tempor$$HEX1$$e100$$ENDHEX$$ria
		ls_PK_TabTemp = 'alter table #temptab1 add constraint pk_registro primary key clustered (nr_registro) '
		
		Execute Immediate :ls_PK_TabTemp Using io_SqlCa;
		
		If io_SqlCa.SqlCode <> 0 Then
			as_log = "Erro ao criar a chave prim$$HEX1$$e100$$ENDHEX$$ria tabela tempor$$HEX1$$e100$$ENDHEX$$ria. Objeto [uo_ge473_comum], fun$$HEX2$$e700e300$$ENDHEX$$o [of_carrega_dados]." + 'Erro '  + io_SqlCa.SqlErrText
			Return False
		End If		
	Else
		as_log = "Erro ao criar a tabela tempor$$HEX1$$e100$$ENDHEX$$ria. Objeto [uo_ge473_comum], fun$$HEX2$$e700e300$$ENDHEX$$o [of_carrega_dados]. " + 'Erro '  + io_SqlCa.SqlErrText
		Return False
	End If
	//FIM - CRIACAO TABELA TEMPORARIA
	
	// INICIO - ASSOCIAR OS CAMPOS DA TABELA TEMP NA DATA STORE QUE RECEBERA OS DADOS
	ls_Create_DS = io_SqlCa.SyntaxFromSQL("SELECT * FROM #temptab1 ",  "style(type=grid)", ls_Erro_Create_DS)
	
	IF Len(ls_Erro_Create_DS) > 0 THEN
		as_log = "Erro SyntaxFromSQL '" + ls_Erro_Create_DS+ "'. Objeto [uo_ge473_comum], fun$$HEX2$$e700e300$$ENDHEX$$o [of_carrega_dados]."
		Return False
	END IF
	
	ids_lista_registros.Create( ls_Create_DS, ls_Erro_Create_DS)

	IF Len(ls_Erro_Create_DS) > 0 THEN
		as_log = "Erro SyntaxFromSQL '" + ls_Erro_Create_DS+ "'. Objeto [uo_ge473_comum], fun$$HEX2$$e700e300$$ENDHEX$$o [of_carrega_dados]."
		Return False
	END IF
	// FIM - ASSOCIAR OS CAMPOS DA TABELA TEMP NA DATA STORE QUE RECEBERA OS DADOS
	
finally
	If IsValid(lds_Coluna) Then Destroy(lds_Coluna)
	io_SqlCa.AutoCommit = False
end try

Return True
end function

public function boolean of_carrega_colunas_ds (ref string as_log);String  ls_Cols[]

Long ll_Linhas
Long ll_Linha

ll_Linhas = Long( ids_lista_registros.Object.DataWindow.Column.Count )

If ll_Linhas = 0 Then
	as_log = "N$$HEX1$$e300$$ENDHEX$$o foi localizado colunas na ids_lista_registros . Objeto [uo_ge473_comum], fun$$HEX2$$e700e300$$ENDHEX$$o [of_carrega_dados_colunas]."
	Return False
End If

//Inicializa
is_coluna[] = ls_Cols[]

FOR ll_Linha = 1 TO ll_Linhas
   is_coluna[ll_Linha] = ids_lista_registros.Describe( "#" + String(ll_Linha) + ".Name" )
NEXT

Return True
end function

public function boolean of_carrega_dados (longlong all_controle, long al_tabela, ref string as_log);Long ll_Qtde_Itens
Long ll_NR_Item
Long ll_rowcount
Long ll_Linha
Long ll_Registros
Long ll_Insert

Long ll_Linha_Coluna

Long ll_Find

String ls_NM_Coluna
String ls_Valor_Coluna
String ls_Nulo
String ls_Obrigatorio
String ls_Tipo_Dado
String ls_dataobject
String ls_id_grava_xml
String ls_xml

dc_uo_ds_base 	lds 
dc_uo_ds_base 	lds_itens 
//dc_uo_transacao	lo_SqlCa

SetNull(ls_Nulo)

Try
		
	lds = Create dc_uo_ds_base
	
	If ib_troca_ds_com_text Then
		If Not lds.of_ChangeDataObject('ds_ge473_interface_sap_item_nova_text', False) Then
			as_log = "Erro ao alterar a DW [ds_ge473_interface_sap_item_nova_text]. Objeto [uo_ge473_comum], fun$$HEX2$$e700e300$$ENDHEX$$o [of_carrega_dados]."
			Return False
		End If	
	Else
		If Not lds.of_ChangeDataObject('ds_ge473_interface_sap_item_nova', False) Then
			as_log = "Erro ao alterar a DW [ds_ge473_interface_sap_item_nova]. Objeto [uo_ge473_comum], fun$$HEX2$$e700e300$$ENDHEX$$o [of_carrega_dados]."
			Return False
		End If	
	End If
	
	lds_itens = Create dc_uo_ds_base
	If Not lds_itens.of_ChangeDataObject("ds_ge473_interface_sap_item_lista", False) Then
		as_log = "Erro ao alterar a DW [ds_ge473_interface_sap_item_lista]. Objeto [uo_ge473_comum], fun$$HEX2$$e700e300$$ENDHEX$$o [of_carrega_dados]."
		Return False
	End If	
	
	ll_Qtde_Itens = lds_itens.Retrieve(all_controle)
	
	If ll_Qtde_Itens > 0 Then

		// FAZ UM FOR PARA CADA ITEM DA TABELA INTERFACE_SAP_ITEM				
		For ll_Linha = 1 To ll_Qtde_Itens
			select Coalesce(id_grava_xml, 'N')
			  into :ls_id_grava_xml
			  from tabela_interface_sap
			 where cd_tabela	= :al_tabela;
			 
			Choose Case SQLCA.SQlCode 
				Case -1
					as_Log	= "Erro ao verificar se a tabela grava o xml ao inv$$HEX1$$e900$$ENDHEX$$s dos itens de forma separada."
					Return False
				Case 100
					as_Log	= "N$$HEX1$$e300$$ENDHEX$$o encontrado a tabela para verificar se grava o xml ao inv$$HEX1$$e900$$ENDHEX$$s dos itens de forma separada."
					Return False
			End Choose
			
			// Recupera todas os valores do item
			ll_Registros = lds.Retrieve(all_controle, lds_itens.Object.nr_item[ll_Linha] )	
			
			If ll_Registros > 0 Then
				
				// Insere o registo na na DS que ser$$HEX1$$e100$$ENDHEX$$ consumida posteriormente pelos programas
				ll_Insert = ids_lista_registros.InsertRow(0)
				
				if ls_id_grava_xml	= 'S' then
					ll_rowcount = lds.RowCount()
					
					if ll_rowcount <= 0 then 
						as_Log	= "N$$HEX1$$e300$$ENDHEX$$o encontrado a linha para ler o xml."
						Return False
					end if
					
					if Upper(lds.Object.cd_coluna[1]) = 'XML' then
						ls_xml	= lds.Object.vl_item[1]
					
						if Trim(ls_xml) = '' or IsNull(ls_xml) then 
							as_Log	= "XML recebido est$$HEX1$$e100$$ENDHEX$$ em branco ou nulo."
							Return False
						end if
					else
						ls_id_grava_xml	= 'N'
					end if
				end if
				
				// Faz a leitura do array para pegar o nome das colunas na DS
				For ll_Linha_Coluna = 1 To UpperBound(is_coluna[])
					ls_NM_Coluna = is_coluna[ll_Linha_Coluna]
					
					If ls_NM_Coluna = 'nr_registro' Then
						Continue
					End If 
					
					If ls_id_grava_xml = 'N' Then
						// Procura o valor da coluna nos registros recuperados
						ll_Find = lds.Find("cd_coluna = '" + ls_NM_Coluna + "'", 1, ll_Registros)
						
						If ll_Find < 0 Then
							as_log = "Erro no FIND ao localizar o valor da coluna do controle na tabela interface_sap_item."
							Return False
						ElseIf ll_Find = 0 Then
							ls_Valor_Coluna	= ''
						Else
							ls_Valor_Coluna = lds.Object.vl_item[ll_Find]
						End If					
					Else
						ls_Valor_Coluna = of_busca_valor(ls_xml, '<' + ls_NM_Coluna + '>', 1)
					End If
					
					If Trim(ls_Valor_Coluna) = '' Then ls_Valor_Coluna = ls_Nulo
					
					Select upper(id_obrigatorio), upper(id_tipo_dado) 
					Into :ls_Obrigatorio, :ls_Tipo_Dado
					From tabela_interface_sap_definicao
					Where cd_tabela = :al_tabela
					  and lower(cd_coluna) = :ls_NM_Coluna
					Using SqlCa;
					 
					 If SqlCa.SqlCode = -1 Then
						as_Log	= "Erro ao localizar a obrigatoriedade do preenchimento do campo '" + ls_NM_Coluna + "' da tabela '" + String(al_Tabela) + "' : " + SqlCa.SqlErrText
						Return False
					End If
					
					If IsNull(ls_Valor_Coluna) and ls_Obrigatorio = 'S' Then
						as_Log	= "O preenchimento do campo '" + ls_NM_Coluna + "' $$HEX1$$e900$$ENDHEX$$ obrigat$$HEX1$$f300$$ENDHEX$$rio para a tabela '" + String(al_Tabela) + "'."
						Return False
					End If
					
					If ls_Tipo_Dado = 'NUMBER' or ls_Tipo_Dado = 'INT' or ls_Tipo_Dado = 'SMALLINT'Then
						If Not IsNumber(ls_Valor_Coluna) Then
							as_Log	= "O valor recebido no campo '" + ls_NM_Coluna + "' n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ num$$HEX1$$e900$$ENDHEX$$rico "
							Return False
						End If
					End If
												
					ids_lista_registros.SetItem(ll_Insert, ls_NM_Coluna, ls_Valor_Coluna)
				Next
				
			ElseIf ll_Registros < 0 Then
				as_log = "Erro ao recuperar a quantidade de itens recebidos na tabela interface_sap_item para o controle '" + String(all_Controle) + "'. Objeto [uo_ge473_comum], fun$$HEX2$$e700e300$$ENDHEX$$o [of_carrega_dados]."
				Return False
			End If
						
		Next
	
	Else
	End If
		
	//ids_lista_registros.SaveAs("c:\teste_sergio.xls", Excel!	, true)
				
Catch ( runtimeerror  lo_rte1 )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_carrega_dados'. Erro: "+lo_rte1.GetMessage( )
	Return False			
Finally
	Destroy lds_itens
	Destroy lds
//	Destroy(lo_SqlCa)	 
End Try

Return True
end function

public function boolean of_localiza_codigo_filial_sap (long al_filial_legado, ref string as_filial_sap, ref string as_log);String ls_filial_legado

ls_filial_legado = String(al_filial_legado)

If Trim(String(al_Filial_Legado)) = "" Then
	SetNull(as_Filial_sap)
	Return True
End If

Select cd_chave_sap
Into	:as_Filial_sap
From integracao_sap
Where	cd_tabela = 'FILIAL'
	And	cd_chave_legado	= :ls_Filial_legado
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		
	Case 100
		as_Log	= "N$$HEX1$$e300$$ENDHEX$$o foi localizado na tabela 'INTEGRA$$HEX2$$c700c200$$ENDHEX$$O SAP', o c$$HEX1$$f300$$ENDHEX$$digo da filial SAP, com o c$$HEX1$$f300$$ENDHEX$$digo Filial Legado '"+String(al_Filial_legado)+"'."
		Return False
	Case -1
		as_Log	= "Erro ao localizao o c$$HEX1$$f300$$ENDHEX$$digo da filial no SAP: " + SqlCa.SqlErrText
		Return False
End Choose

Return True
end function

public function boolean of_processa_carrega_dados (longlong all_controle, ref string as_log);Long ll_Tabela

Select cd_tabela
Into :ll_Tabela
From interface_sap
Where nr_controle = :all_controle
Using SqlCa;
	
If SqlCa.sqlcode = -1 Then
	as_Log	= "Erro ao localiza o c$$HEX1$$f300$$ENDHEX$$digo da tabela na tabela interface_sap. Erro: "+SqlCa.sqlErrText
 	Return False
End If

If This.of_monta_ds_dinamica(all_controle, ll_Tabela, Ref as_log) Then
	If This.of_carrega_colunas_ds(Ref as_Log) Then
		If This.of_carrega_dados(all_controle, ll_Tabela, Ref as_log) Then
			Return True
		End If
	End If
End If

Return False
end function

public function boolean of_localiza_chave_controle (long al_controle, ref string as_chave, ref string as_log);Select de_chave_sap
Into	:as_chave
From interface_sap
Where nr_controle = :al_controle
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
	Case 100
		as_Log	= "Controle da interface SAP '" + String(al_controle) + "' n$$HEX1$$e300$$ENDHEX$$o foi localizado."
		Return False
	Case -1
		as_Log	= "Erro ao localizar o controle da interface SAP: " + SqlCa.SqlErrText
		Return False
End Choose

Return True
end function

public function boolean of_localica_codigo_promocao_legado (long al_promocao_sap, ref string al_promocao, ref string as_log);String ls_promocao

ls_promocao = String(al_promocao)

If Trim(String(al_promocao_sap)) = "" Then
	SetNull(al_promocao)
	Return True
End If

Select  cd_promocao_sos
Into 	  :al_promocao
from    promocao_sos
where  cd_promocao_sap =:al_promocao_sap
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		
	Case 100
		as_Log	= "N$$HEX1$$e300$$ENDHEX$$o foi localizado o c$$HEX1$$f300$$ENDHEX$$digo da promo$$HEX2$$e700e300$$ENDHEX$$o no legado com o c$$HEX1$$f300$$ENDHEX$$digo SAP '"+String(al_promocao_sap)+"'."
		Return False
	Case -1
		as_Log	= "Erro ao localizao o c$$HEX1$$f300$$ENDHEX$$digo da promocao no legado: " + SqlCa.SqlErrText
		Return False
End Choose

Return True
end function

public function boolean of_localiza_codigo_promocao_legado (string as_cd_promocao_sap, ref long al_promocao, ref string as_log);If as_cd_promocao_sap = '' or isnull(as_cd_promocao_sap) Then
	SetNull(al_promocao)
	Return True
End If

Select cd_promocao_sos
Into	:al_promocao
From promocao_sos
Where cd_promocao_sap = :as_cd_promocao_sap
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		
	Case 100
		as_Log	= "N$$HEX1$$e300$$ENDHEX$$o foi localizado na tabela 'PROMOCAO_SOS', a promo$$HEX2$$e700e300$$ENDHEX$$o com o c$$HEX1$$f300$$ENDHEX$$digo SAP '"+ as_cd_promocao_sap +"'."
		Return False
	Case -1
		as_Log	= "Erro ao localizar o c$$HEX1$$f300$$ENDHEX$$digo da promo$$HEX2$$e700e300$$ENDHEX$$o no legado: " + SqlCa.SqlErrText
		Return False
End Choose

Return True
end function

public function boolean of_localiza_motivo_esb (string as_cd_motivo, ref string as_descricao, ref string as_log);If Trim(as_cd_motivo) = "" Then
	SetNull(as_descricao)
	Return True
End If

Select cd_chave_legado
Into	:as_descricao
From integracao_sap
Where cd_tabela = 'MOTIVO_ESB'
	And cd_chave_sap	= :as_cd_motivo
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		
	Case 100
		as_Log	= "N$$HEX1$$e300$$ENDHEX$$o foi localizado na tabela 'INTEGRA$$HEX2$$c700c200$$ENDHEX$$O SAP', o motivo de altera$$HEX2$$e700e300$$ENDHEX$$o de estoque base, com o c$$HEX1$$f300$$ENDHEX$$digo SAP '"+as_cd_motivo+"'."
		Return False
	Case -1
		as_Log	= "Erro ao localizar o c$$HEX1$$f300$$ENDHEX$$digo do motivo de altera$$HEX2$$e700e300$$ENDHEX$$o de estoque base no legado: " + SqlCa.SqlErrText
		Return False
End Choose

Return True
end function

public function boolean of_atualizacao_pendente (long al_controle, ref long al_registro_pendente, ref string as_log);string ls_cd_chave
long ll_cd_tabela, ll_nr_controle=0

al_registro_pendente=0 // Inicializa com zero e substitui por 1 se estiver pendente.

// Verificar se o controle est$$HEX1$$e100$$ENDHEX$$ pendente. Se retornar algo, est$$HEX1$$e100$$ENDHEX$$.
Select 1, cd_tabela, de_chave_sap
Into 	:al_registro_pendente, :ll_cd_tabela, :ls_cd_chave
From 	interface_sap
Where nr_controle = :al_controle
    and id_situacao in ('C', 'E')
    and dh_processamento is null
Using SqlCa;

If SqlCa.sqlcode = -1 Then
	as_log = "Erro ao verificar se h$$HEX1$$e100$$ENDHEX$$ registros para processar na tabela [interface_sap]. Erro: "+SqlCa.sqlErrText
	Return False
End If

If SqlCa.sqlcode = 100 Then
	as_log = "N$$HEX1$$e300$$ENDHEX$$o foi encontrado registro pendente para o controle " + String(al_controle)
	al_registro_pendente = 0
	Return True
End If

// Se chegou at$$HEX1$$e900$$ENDHEX$$ aqui, o controle est$$HEX1$$e100$$ENDHEX$$ pendente.
// Validar se precisa processar outro controle antes do al_Controle.

// Busca um controle menor, que tamb$$HEX1$$e900$$ENDHEX$$m esteja pendente, e...
Choose Case ll_cd_tabela
	Case 24, 160, 161 // PRECO_REGULAR/PRECO_PROFIMETRICS/PRECO_PMC
		//... Que possua o mesmo cd_produto_sap do al_Controle.
		Select max(a.nr_controle)
		into :ll_nr_controle
		from interface_sap a (index idx_situacao)
			inner join interface_sap_item b on (b.nr_controle = a.nr_controle)
		Where a.cd_tabela = :ll_cd_tabela
			and a.id_situacao in ('E', 'C')
			and a.nr_controle < :al_controle
			and b.cd_coluna = 'cd_produto_sap'
			and Exists (Select 1
							from interface_sap_item x
							where x.nr_controle = :al_controle
							and x.cd_coluna = 'cd_produto_sap'
							and convert(varchar,x.vl_item) = convert(varchar,b.vl_item));
						
		If SqlCa.sqlcode = -1 Then
			as_log = "Erro ao verificar se h$$HEX1$$e100$$ENDHEX$$ registros para processar na tabela [interface_sap_item]. Erro: "+SqlCa.sqlErrText
			Return False
		End If

	Case 34 // PROMOCAO
		//... Que possua a mesma de_chave_sap do al_Controle.
		Select  max(a.nr_controle)
		into :ll_nr_controle
		from interface_sap a (index idx_cont_pend)
		Where a.cd_tabela = :ll_cd_tabela
			and a.id_situacao in ('E', 'C')
			and a.nr_controle < :al_controle
			and a.de_chave_sap = :ls_cd_chave;
			
		If SqlCa.sqlcode = -1 Then
			as_log = "Erro ao verificar se h$$HEX1$$e100$$ENDHEX$$ registros para processar na tabela [interface_sap]. Erro: "+SqlCa.sqlErrText
			Return False
		End If
	
	Case 73,104 // NOTA FISCAL
		// n$$HEX1$$e300$$ENDHEX$$o validar
	
	Case Else // Outras interfaces
		//... Valida com interface_sap_item_chave do al_Controle.
		Select max(a.nr_controle)
		into :ll_nr_controle
		from interface_sap a (index idx_situacao)
			inner join interface_sap_item_chave b on (b.nr_controle = a.nr_controle) 
		Where a.cd_tabela = :ll_cd_tabela
			and a.id_situacao in ('E', 'C')
			and a.nr_controle < :al_controle
			and b.cd_chave in (Select i.cd_chave
										from  interface_sap_item_chave i (index idx_controle)
										Where i.nr_controle = :al_controle);
										
		If SqlCa.sqlcode = -1 Then
			as_log = "Erro ao verificar se h$$HEX1$$e100$$ENDHEX$$ registros para processar na tabela [interface_sap_item_chave]. Erro: "+SqlCa.sqlErrText
			Return False
		End If
		
End Choose

// Achou algum controle que deve ser processado antes?
if ll_nr_controle > 0 Then
	as_log = "O Controle " + string(ll_nr_controle) + " deve ser processado."
	Return False
end if

Return True
end function

public function boolean of_grava_log_exportacao (str_log_export_sap pst_dados, ref string ps_log);long ll_nr_atualizacao
string ls_erro
datetime ldt_exportacao

if isnull(pst_dados.dh_exportacao) or date(pst_dados.dh_exportacao) = date('01/01/1900') Then
	ldt_exportacao = gf_getserverdate()
else
	ldt_exportacao = pst_dados.dh_exportacao
end if

Declare sp_log Procedure for sp_log_exportacao_sap_prox_seq
									@proximo_sequencial_retorno  = :ll_nr_atualizacao OUTPUT,
									@mensagem_retorno = :ls_erro OUTPUT
USING SQLCA;

Execute sp_log;

If sqlca.sqlcode = -1 then 
	ps_log = 'Erro ao executar a procedure "SP_LOG_EXPORTACAO_SAP_PROX_SEQ" (of_grava_log_exportacao): ' + sqlca.sqlerrtext 
	return false
end if

Fetch sp_log Into :ll_nr_atualizacao, :ls_erro;

Close sp_log;

if ll_nr_atualizacao = -1 then
	ps_log = 'Erro ao executar a procedure "SP_LOG_EXPORTACAO_SAP_PROX_SEQ" (of_grava_log_exportacao): ' + ls_erro
	return false
end if

insert into log_exportacao_sap(nr_atualizacao,
										cd_empresa,
										cd_chave,
										id_tipo_nf,
										id_tipo_log,
										cd_filial,
										nr_nf,
										de_especie,
										de_serie,
										cd_fornecedor,
										id_situacao_docto,
										id_documento_mult,
										id_status_integracao,
										dh_exportacao,
										dh_importacao,
										nr_documento_sap,
										id_reprocessar,
										nr_lancamento,
										nr_lancamento_caixa,
										cd_ambiente_sap,
										id_estornar,
										dh_estornado_sap,
										de_erro,
										nr_documento_sap_estornado,
										cd_tipo_documento,
										cd_chave_interface,
										dh_documento,
										id_documento_origem_verificado,
										nr_titulo,
										cd_produto,
										cd_promocao_sos)
Values( :ll_nr_atualizacao,
			:pst_dados.cd_empresa,
			:pst_dados.cd_chave,
			:pst_dados.id_tipo_nf,
			:pst_dados.id_tipo_log,
			:pst_dados.cd_filial,
			:pst_dados.nr_nf,
			:pst_dados.de_especie,
			:pst_dados.de_serie,
			:pst_dados.cd_fornecedor,
			:pst_dados.id_situacao_docto,
			:pst_dados.id_documento_mult,
			:pst_dados.id_status_integracao,
			:ldt_exportacao,
			:pst_dados.dh_importacao,
			:pst_dados.nr_documento_sap,
			:pst_dados.id_reprocessar,
			:pst_dados.nr_lancamento,
			:pst_dados.nr_lancamento_caixa,
			:pst_dados.cd_ambiente_sap,
			:pst_dados.id_estornar,
			:pst_dados.dh_estornado_sap,
			:pst_dados.de_erro,
			:pst_dados.nr_documento_sap_estornado,
			:pst_dados.cd_tipo_documento,
			:pst_dados.cd_chave_interface,
			:pst_dados.dh_documento,
			:pst_dados.id_documento_origem_verificado,
			:pst_dados.nr_titulo,
			:pst_dados.cd_produto,
			:pst_dados.cd_promocao_sos) USING SQLCA;

If sqlca.sqlcode = -1 then 
	ps_log = 'Erro ao inserir registro na tabela "log_exportacao_sap": ' + sqlca.sqlerrtext 
	return false
end if

return True
end function

public function boolean of_date_time_gmt (string as_valor, string as_coluna, ref datetime adh_valor, ref string as_log);
If Trim(as_Valor) =  ''  or isnull( as_Valor ) Then
	SetNull( adh_valor )
Else
	Exception lo_Exp
	lo_Exp = CREATE Exception
	lo_Exp.setMessage("O campo nao contem uma data")
	
	Try
		//2021-04-23T17:30:35-03:00
		If len( trim( as_Valor ) ) < 25 then
			THROW (lo_Exp )
		End IF 
		//
		adh_valor = Datetime( date(as_Valor), time( mid( as_Valor, 12, 5) ) )
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

public function boolean of_decimal (string as_valor, string as_coluna, ref decimal adc_valor, ref string as_log, boolean ab_devolve_zero);If Trim(as_Valor) =  '' Then
	SetNull(adc_valor)
Else
	If Not IsNull(as_Valor) Then
		If IsNumber(as_Valor) Then
			adc_Valor = Dec(gf_Replace(as_Valor, '.', ',', 0))
		Else
			as_Log = "O valor informado '" + as_valor + "' para o campo '" + as_coluna + "' n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ v$$HEX1$$e100$$ENDHEX$$lido."
			Return False
		End If
	End If
End If

If IsNull(adc_valor) and ab_devolve_zero Then adc_valor = 0.00

Return True
end function

public function boolean of_localiza_codigo_filial_legado (long al_filial_sap, ref string as_filial_legado, ref string as_log);String ls_filial_sap

if al_filial_sap = 1001 then	
	as_log = "Filial n$$HEX1$$e300$$ENDHEX$$o permitida para integra$$HEX2$$e700e300$$ENDHEX$$o com o legado. Filial: " + String(al_filial_sap)
	
	Return False
end if

ls_filial_sap = String(al_filial_sap)

If Trim(String(al_Filial_sap)) = "" Then
	SetNull(as_Filial_legado)
	Return True
End If

Select cd_chave_legado
  Into :as_filial_legado
  From integracao_sap
 Where cd_tabela 		= 'FILIAL'
	And cd_chave_sap	= :ls_filial_sap
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		
	Case 100
		if IsNull(al_Filial_sap) then al_Filial_sap = 0
		
		as_Log	= "N$$HEX1$$e300$$ENDHEX$$o foi localizado na tabela 'INTEGRA$$HEX2$$c700c200$$ENDHEX$$O SAP', o c$$HEX1$$f300$$ENDHEX$$digo da filial legado, com o c$$HEX1$$f300$$ENDHEX$$digo Filial SAP '"+String(al_Filial_sap)+"'."
		Return False
	Case -1
		as_Log	= "Erro ao localizar o c$$HEX1$$f300$$ENDHEX$$digo da filial no legado: " + SqlCa.SqlErrText
		Return False
End Choose

Return True
end function

public function string of_busca_valor (string as_xml, string as_tag, long al_pos);String 	ls_retorno, ls_Xml_Aux
Long 		ll_pos1, ll_pos2


as_Tag = gf_Replace(as_Tag, '/', '', 0)
as_Tag = gf_Replace(as_Tag, '<', '', 0)
as_Tag = gf_Replace(as_Tag, '>', '', 0)

ls_Xml_Aux = as_xml

ll_pos1 = Pos(ls_Xml_Aux, '<'+as_tag+'>', al_pos)
ll_pos2 = Pos(ls_Xml_Aux, '</'+as_tag+'>', al_pos)

ls_retorno = Mid(ls_Xml_Aux,  ll_pos1 + LenA(as_tag)+2, ll_pos2 - ( ll_pos1 + LenA(as_tag)+2))

al_pos = ll_pos2

return ls_retorno
end function

public function boolean of_localiza_codigo_comprador_legado (string as_comprador_sap, ref string as_matricula, ref string as_log);If Trim(as_comprador_sap) = "" or isnull(as_comprador_sap) Then
	as_Log = "O Grupo Comprador n$$HEX1$$e300$$ENDHEX$$o Informado(Vazio) no PEDIDO SAP. Favor verificar."
	Return False
End If

SELECT cd_chave_legado
INTO :as_Matricula
FROM integracao_sap
WHERE cd_tabela = 'GRUPO_COMPRADOR'
    AND cd_chave_sap = :as_comprador_sap
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 100
		as_Log	= "N$$HEX1$$e300$$ENDHEX$$o foi localizado na tabela 'GRUPO_COMPRADOR', o comprador com o c$$HEX1$$f300$$ENDHEX$$digo SAP '"+ as_comprador_sap +"'."
		Return False
	Case -1
		as_Log	= "Erro ao localizar o c$$HEX1$$f300$$ENDHEX$$digo do grupo comprador no legado: " + SqlCa.SqlErrText
		Return False
End Choose

Return True
end function

public function boolean of_grava_erro (long al_controle, long al_cd_mensagem_email, string as_erro, boolean ab_envia_email);String	ls_Erro
String ls_Msg_Email
String ls_NM_Interface
String lvs_Host, lvs_Ip

Select t.de_tabela 
Into :ls_NM_Interface
From interface_sap i
inner join tabela_interface_sap t
	on t.cd_tabela = i.cd_tabela
where i.nr_controle = :al_controle
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_Erro	=  SqlCa.SqlerrText
	SqlCa.of_Rollback()
	as_erro	= "Erro ao localizar o nome da interface: " +ls_Erro
	Return False
End If

lvs_Host = gvo_Aplicacao.ivo_Seguranca.of_Get_is_Host()
lvs_Ip 	= gvo_Aplicacao.ivo_Seguranca.of_Get_is_Ip()
	
Update interface_sap
Set	de_erro				= :as_erro,
		id_situacao			= 'E',
		cd_sistema			= :gvo_Aplicacao.ivo_Seguranca.cd_Sistema,
		nr_versao_sistema	= :gvo_Aplicacao.ivs_Versao,
		de_host				= :lvs_Host,
		de_ip					= :lvs_Ip
Where nr_controle =:al_controle
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_Erro	=  SqlCa.SqlerrText
	SqlCa.of_Rollback()
	as_erro	= "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do erro na tabela [interface_sap]: " +ls_Erro
	Return False
End If

If SqlCa.SqlnRows = 0 Then 
	SqlCa.of_Rollback()
	as_erro = "Nenhum registro foi atualizado na tabela 'interface_sap'. Fun$$HEX2$$e700e300$$ENDHEX$$o 'wf_grava_erro'."
	Return False
End If

If SqlCa.SqlnRows > 1 Then 
	SqlCa.of_Rollback()
	as_erro	= "Foram encontrados mais de um registro para a atualiza$$HEX2$$e700e300$$ENDHEX$$o de erro para o controle '" + String(al_controle) + "'."
	Return False
End If

SqlCa.of_Commit()

If ab_envia_email Then
	ls_Msg_Email = 'Houveram problemas na interface de descida do SAP . <br>'+ &
						 'Interface:<b>' + ls_NM_Interface + '</b><br>'+ &
						 'Controle:' + String(al_Controle) + ' <br>'+ &
						 '</ul></ul>'+&
						 as_erro
	
	gf_ge202_envia_email_automatico(al_Cd_Mensagem_Email , '', ls_Msg_Email, {''})
End If

Return True
end function

public function boolean of_localiza_condicao_pagto_legado (string as_codigo_pagamento_sap, ref long al_codigo_pagamento_legado, ref string as_log);If Trim(as_codigo_pagamento_sap) = "" or isnull(as_codigo_pagamento_sap) Then
	Return True
End If

SELECT cd_chave_legado
INTO :al_codigo_pagamento_legado
FROM integracao_sap
WHERE cd_tabela = 'CONDICAO_PAGAMENTO'
    AND cd_chave_sap = :as_codigo_pagamento_sap
	AND dh_inclusao = (select max(a.dh_inclusao) from integracao_sap a where a.cd_tabela = 'CONDICAO_PAGAMENTO' and a.cd_chave_sap = :as_codigo_pagamento_sap )
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 100
		as_Log	= "N$$HEX1$$e300$$ENDHEX$$o foi localizado na tabela 'CONDICAO_PAGAMENTO', a condi$$HEX2$$e700e300$$ENDHEX$$o pagamento com o c$$HEX1$$f300$$ENDHEX$$digo SAP '"+ as_codigo_pagamento_sap +"'."
		Return False
	Case -1
		as_Log	= "Erro ao localizar o c$$HEX1$$f300$$ENDHEX$$digo de condi$$HEX2$$e700e300$$ENDHEX$$o de pagamento no legado: " + SqlCa.SqlErrText
		Return False
End Choose

Return True
end function

public function boolean of_processa_carrega_dados_v2 (longlong all_controle, ref string as_log);
/**
 * Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_carrega_dados_v2
 * Objetivo: Popular a ids_lista_registros com todos os dados da 'interface_sap_item' referentes ao 'all_Controle'.
 *
 * Par$$HEX1$$e200$$ENDHEX$$metros:
 * - all_controle (longlong): 'nr_controle' da 'interface_sap'.
 * - as_log (ref string): Retorna logs em caso de erro.
 * - Retorno: Sucesso (True) | Erro (False)
 * 
 * Descri$$HEX2$$e700e300$$ENDHEX$$o do Processo:
 * 1. Consulta 'interface_sap' para buscar c$$HEX1$$f300$$ENDHEX$$digo da tabela da interface pelo 'all_Controle'.
 * 2. Instancia a ids_lista_registros, seta o dataobject da interface e recupera os dados.
 * 
 * -------------
 *
 * Depend$$HEX1$$ea00$$ENDHEX$$ncias:
 * 1. Necess$$HEX1$$e100$$ENDHEX$$rio criar uma procedure para cada interface que utilizar a fun$$HEX2$$e700e300$$ENDHEX$$o V2; (exemplo: sp_interface_sap_item_34(@nr_controle))
 * 1.1. O c$$HEX1$$f300$$ENDHEX$$digo da procedure a ser criada pode ser obtido com a query: SELECT dbo.fn_interface_sap_gera_procedure(@cd_tabela)
 * 
 * 2. Necess$$HEX1$$e100$$ENDHEX$$rio criar um dataobject do tipo Stored Procedure para cada cd_tabela:
 * 2.1. File > New > DataWindow > Grid/Tabular > [OK] > Stored Procedure > [NEXT] > [x] System Procedure > [Selecionar a procedure criada para a interface] > [NEXT] > [NEXT] > [FINISH]
 * 2.2. Salvar com o nome no seguinte padr$$HEX1$$e300$$ENDHEX$$o: ds_ge473_interface_XXX, onde XXX $$HEX1$$e900$$ENDHEX$$ o cd_tabela.
 **/

Long ll_Tabela

Try
	
	// Buscar interface do controle
	Select cd_tabela
	Into :ll_Tabela
	From interface_sap
	Where nr_controle = :all_controle
	Using SqlCa;
		
	If SqlCa.sqlcode = -1 Then
		as_Log = "Erro ao localizar o c$$HEX1$$f300$$ENDHEX$$digo da tabela na tabela interface_sap. Erro: "+SqlCa.sqlErrText
		Return False
	End If
		
	// Criar datastore da interface
	ids_lista_registros = Create dc_uo_ds_base
	If Not ids_lista_registros.of_ChangeDataObject("ds_ge473_interface_"+String(ll_Tabela)) Then
		as_Log = "Interface n$$HEX1$$e300$$ENDHEX$$o preparada para busca de dados V2."
		Return False
	End If
	
	// Recuperar dados
	If ids_lista_registros.Retrieve(all_controle) < 0 Then
		as_Log = "Erro ao recuperar dados. Erro: " + SQLCA.is_LastErrorText
		Return False
	End If
	
	Return True

Catch ( runtimeerror  lo_rte1 )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_processa_carrega_dados_v2'. Erro: "+lo_rte1.GetMessage( )
	Return False
End Try
end function

public function boolean of_processa_carrega_dados_v3 (longlong all_controle, ref string as_log);/**
 * Fun$$HEX2$$e700e300$$ENDHEX$$o: of_processa_carrega_dados_v3
 * Objetivo: Popular a ids_lista_registros com todos os dados da 'interface_sap_item' referentes ao 'all_Controle'.
 * 
 * Pode ser utilizada para interfaces de descida SAP, desde que:
 * 	1. A defini$$HEX2$$e700e300$$ENDHEX$$o da tabela tenha no m$$HEX1$$e100$$ENDHEX$$ximo 180 colunas (devido ao limite de caracteres da query ser 16384);
 * 	2. O 'vl_item' da 'interface_sap_item' para as colunas definidas tenha at$$HEX1$$e900$$ENDHEX$$ 255 caracteres.
 *
 * Par$$HEX1$$e200$$ENDHEX$$metros:
 * 	- all_controle (longlong): 'nr_controle' da 'interface_sap'.
 * 	- as_log (ref string): Retorna logs em caso de erro.
 * 	- Retorno: Sucesso (True) | Erro (False)
 * 
 * Descri$$HEX2$$e700e300$$ENDHEX$$o do Processo:
 * 	1. Gera um SELECT para buscar todos os dados da 'interface_sap_item' do 'all_Controle'.
 * 	1.1. A 'fn_interface_sap_gera_select' utiliza as colunas cadastradas na 'tabela_interface_sap_definicao' e monta uma query de consulta.
 * 	2. Gera a Syntax, cria a datastore e recupera os dados.
**/

String lvs_Select, lvs_Syntax, lvs_Erro

Try

	// Gerar SELECT para a datastore
	SELECT convert(text, dbo.fn_interface_sap_gera_select(:all_controle))
	INTO :lvs_Select
	FROM dummy
	USING SQLCA;
	
	If SQLCA.SQLCode = -1 Or SQLCA.SQLCode = 100 Or lvs_Select = '' Then
		as_Log = "Erro ao gerar SELECT. SQLCode="+String(SQLCA.SQLCode)+". Erro: " + SQLCA.SQLErrText
		Return False
	End If
	
	// Gerar syntax
	lvs_Syntax = SQLCA.SyntaxFromSQL(lvs_Select, 'Tabular', Ref lvs_Erro)
	If lvs_Syntax = '' Then
		as_Log = "Erro ao gerar Syntax da DataStore. Erro: " + lvs_Erro
		Return False
	End If
	
	// Criar datastore
	ids_lista_registros = Create dc_uo_ds_base
	If ids_lista_registros.Create(lvs_Syntax, Ref lvs_Erro) = -1 Then
		as_Log = "Erro ao criar DataStore. Erro: " + lvs_Erro
		Return False
	End If
	ids_lista_registros.SetTransObject(SQLCA)

	// Recuperar dados
	If ids_lista_registros.Retrieve() < 0 Then
		as_Log = "Erro ao recuperar dados. Erro: " + SQLCA.is_LastErrorText
		Return False
	End If
	
	Return True

Catch ( runtimeerror  lo_rte1 )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_processa_carrega_dados_v3'. Erro: "+lo_rte1.GetMessage( )
	Return False
End Try
end function

public subroutine of_connect_io_sqlca ();If Not isValid(io_SqlCa) Then io_SqlCa = create dc_uo_transacao

If io_SqlCa.of_isConnected() Then Return

io_SqlCa.ivs_database = "SYBASE"

If Not io_SqlCa.of_Connect(gvo_Aplicacao.ivs_DataSource, 'GE473 - Interface') Then
//		as_log = "Erro ao conectar no Sybase. Objeto [uo_ge473_comum], fun$$HEX2$$e700e300$$ENDHEX$$o [of_carrega_dados]."
//		Return False
End If

ids_lista_registros.of_SetTransObject(io_SqlCa)
end subroutine

public function boolean of_time (string as_hora_sap, string as_coluna, ref time atm_valor, ref string as_log);/* Formato esperado HHMMSS */
Try	
	If Trim(as_hora_sap) =  ''  or isNull( as_hora_sap ) Then
		SetNull( atm_valor )
	Else	
		//Verifica se h$$HEX1$$e100$$ENDHEX$$ separador na hora,minuto
		If Pos(":", as_hora_sap) = 0 Then
			Choose Case Len( Trim( as_hora_sap ) )
				Case 5 // 83225 -> HMMSS -> 08:32:25
					as_hora_sap = '0'+Mid(as_hora_sap, 1, 1) + ':' + Mid(as_hora_sap, 2, 2) + ':' + Mid(as_hora_sap, 4, 2)		
				Case 6 //083225 -> HHMMSS -> 08:32:25
					as_hora_sap = Mid(as_hora_sap, 1, 2) + ':' + Mid(as_hora_sap, 3, 2) + ':' + Mid(as_hora_sap, 5, 2)
				Case 9 //083225999 -> HHMMSSFFF -> 08:32:25:999
					as_hora_sap = Mid(as_hora_sap, 1, 2) + ':' + Mid(as_hora_sap, 3, 2) + ':' + Mid(as_hora_sap, 5, 2) + ':' + Mid(as_hora_sap, 7, 3)	
				Case Else
					as_log = 'O campo '+as_coluna+' n$$HEX1$$e300$$ENDHEX$$o cont$$HEX1$$e900$$ENDHEX$$m uma hora v$$HEX1$$e100$$ENDHEX$$lida. Valor ['+as_hora_sap+'].'
					Return False
			End Choose
		End If
		
		//Usa fun$$HEX2$$e700e300$$ENDHEX$$o standard para validar se o valor $$HEX1$$e900$$ENDHEX$$ uma data v$$HEX1$$e100$$ENDHEX$$lida
		If Not IsTime(as_hora_sap) Then
			as_log = 'O campo '+as_coluna+' n$$HEX1$$e300$$ENDHEX$$o cont$$HEX1$$e900$$ENDHEX$$m uma hora v$$HEX1$$e100$$ENDHEX$$lida. Valor ['+as_hora_sap+'].'
			Return False
		Else
			//Converte o tipo de dado
			atm_valor = Time(as_hora_sap)
		End If
	End If
	
Catch  (RuntimeError lo_Erro )
	as_Log = "O valor informado '" + as_hora_sap + "' para o campo '" + as_coluna + "' n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ v$$HEX1$$e100$$ENDHEX$$lido. Erro: "+lo_Erro.GetMessage( )
	Return False	
	
Finally
	If IsValid( lo_Erro ) Then Destroy(lo_Erro)
End Try

Return True
end function

public function boolean of_date_time (string as_data, string as_hora, string as_coluna, ref datetime adh_retorno, ref string as_log);Datetime lvdh_Data
Time lvtm_Hora

//Converte a data
If Not This.Of_Date_Time(as_data, as_coluna, ref lvdh_Data, ref as_log) Then Return False
//Converte a hora
If Not This.Of_Time(as_hora, as_coluna, ref lvtm_Hora, ref as_log) Then Return False
//Junta as informa$$HEX2$$e700f500$$ENDHEX$$es em uma vari$$HEX1$$e100$$ENDHEX$$vel datetime
adh_retorno = Datetime(Date(lvdh_Data), lvtm_Hora)

Return True
end function

public function boolean of_verifica_registro_pendente (long al_controle, ref boolean ab_registro_pendente, ref string as_log);String 	ls_cd_chave


ab_registro_pendente	= False

SELECT
	de_chave_sap
INTO
	:ls_cd_chave
FROM
	interface_sap
WHERE
	nr_controle = :al_controle
   AND id_situacao in ('C', 'E')
   AND dh_processamento is null
USING SqlCa;

Choose Case SQLCA.SQLCode
	Case -1
		as_log = "Erro ao verificar se h$$HEX1$$e100$$ENDHEX$$ registros para processar na tabela [interface_sap]. Erro: "+SqlCa.sqlErrText
		Return False
	Case 100
		ab_registro_pendente = False
	Case 0
		ab_registro_pendente = True
End Choose

Return True

end function

public function boolean of_localiza_codigo_fornecedor_legado (string as_fornecedor_sap, ref string as_fornecedor, boolean ab_busca_fornecedor_inativo, ref string as_log);String	ls_Fornecedor_Sap_f1, ls_Fornecedor_Sap_f2, ls_Fornecedor_Sap_f3

If Isnull(as_fornecedor_sap) or (Trim(as_fornecedor_sap) = "") Then
	SetNull(as_Fornecedor)
	Return True
End If

ls_Fornecedor_Sap_f1 = Right('000000' + as_Fornecedor_Sap, 10)
ls_Fornecedor_Sap_f2	= as_Fornecedor_Sap
ls_Fornecedor_Sap_f3	= gf_remove_zeros_esquerda(as_Fornecedor_Sap)

if ab_busca_fornecedor_inativo then
	Select top 1 cd_fornecedor
	  Into :as_Fornecedor
	  From fornecedor 
	 Where cd_fornecedor_sap				in (:ls_Fornecedor_Sap_f1, :ls_Fornecedor_Sap_f2, :ls_Fornecedor_Sap_f3)
	Using SqlCa;
else
	Select top 1 cd_fornecedor
	  Into :as_Fornecedor
	  From fornecedor 
	 Where cd_fornecedor_sap				in (:ls_Fornecedor_Sap_f1, :ls_Fornecedor_Sap_f2, :ls_Fornecedor_Sap_f3)
	 	And coalesce(id_situacao, 'A')	<> 'I'
	Using SqlCa;	
end if

Choose Case SqlCa.SqlCode
	Case 0
		
	Case 100
		as_Log	= "N$$HEX1$$e300$$ENDHEX$$o foi localizado na tabela 'INTEGRA$$HEX2$$c700c200$$ENDHEX$$O SAP', o c$$HEX1$$f300$$ENDHEX$$digo do fornecedor, com o c$$HEX1$$f300$$ENDHEX$$digo SAP '"+as_Fornecedor_Sap+"'."
		Return False
	Case -1
		as_Log	= "Erro ao localizao o c$$HEX1$$f300$$ENDHEX$$digo do fornecedor no legado: " + SqlCa.SqlErrText
		Return False
End Choose

Return True
end function

public function boolean of_localiza_codigo_parceiro_legado (string as_parceiro_sap, ref long al_parceiro, ref string as_log);/*If Trim(as_parceiro_sap) = "" Then
	SetNull(al_parceiro)
	
	Return True
End If

if as_parceiro_Sap = '1001' then
	SetNull(al_parceiro)
	
	as_log = "Parceiro n$$HEX1$$e300$$ENDHEX$$o permitido para integra$$HEX2$$e700e300$$ENDHEX$$o com o legado. Parceiro: " + as_parceiro_Sap
	
	Return False
end if*/

Select cd_chave_legado
  Into :al_parceiro
  From integracao_sap
 Where cd_tabela = 'PARCEIRO'
	And cd_chave_sap	= :as_parceiro_Sap
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case -1
		as_Log	= "Erro ao localizar o c$$HEX1$$f300$$ENDHEX$$digo do parceiro no legado: " + SqlCa.SqlErrText
		Return False
End Choose

Return True
end function

on uo_ge473_comum.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge473_comum.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ids_lista_registros = Create dc_uo_ds_base //
end event

event destructor;Destroy ids_lista_registros
Destroy io_SqlCa
end event

