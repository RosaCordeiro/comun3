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
public function boolean of_atualizacao_pendente (long al_controle, ref long al_registro_pendente, ref string as_log)
public function boolean of_localiza_codigo_filial_sap (long al_filial_legado, ref string as_filial_sap, ref string as_log)
public function boolean of_processa_carrega_dados (longlong all_controle, ref string as_log)
end prototypes

public function boolean of_muda_situacao_interface (long al_controle, ref string as_log);Try
	
	Update interface_sap
	set	id_situacao = 'P', //Processado
		dh_processamento = getdate(),
		de_erro = null
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

public function boolean of_decimal (string as_valor, string as_coluna, ref decimal adc_valor, ref string as_log);If Trim(as_Valor) =  '' Then
	SetNull(adc_valor)
Else
	If IsNumber(as_Valor) Then
		adc_Valor = Dec(gf_Replace(as_Valor, '.', ',', 0))
	Else
		as_Log = "O valor informado '" + as_valor + "' para o campo '" + as_coluna + "' n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ v$$HEX1$$e100$$ENDHEX$$lido."
		Return False
	End If
End If

Return True
end function

public function boolean of_localiza_codigo_produto_legado (string as_cd_produto_sap, ref long al_produto, ref string as_log);as_cd_produto_sap = gf_Tira_Zero_Esquerda(as_cd_produto_sap)

Select cd_produto
Into	:al_Produto
From produto_geral
Where cd_produto_sap = :as_cd_produto_sap
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		
	Case 100
		as_Log	= "N$$HEX1$$e300$$ENDHEX$$o foi localizado na tabela 'PRODUTO_GERAL', o produto com o c$$HEX1$$f300$$ENDHEX$$digo SAP '"+as_cd_produto_sap+"'."
		Return False
	Case -1
		as_Log	= "Erro ao localizao o c$$HEX1$$f300$$ENDHEX$$digo do produto no legado: " + SqlCa.SqlErrText
		Return False
End Choose

Return True
end function

public function boolean of_grava_erro (long al_controle, long al_cd_mensagem_email, string as_erro);String	ls_Erro
String ls_Msg_Email

Update interface_sap
Set	de_erro		= :as_erro,
		id_situacao	= 'E'
Where nr_controle =:al_controle
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_Erro	=  SqlCa.SqlerrText
	MessageBox("Erro", "Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do erro na tabela [interface_sap]: " +ls_Erro)
	SqlCa.of_Rollback()
	Return False
End If

If SqlCa.SqlnRows = 0 Then 
	MessageBox("Erro", "Nenhum registro foi atualizado na tabela 'interface_sap'. Fun$$HEX2$$e700e300$$ENDHEX$$o 'wf_grava_erro'.")
	SqlCa.of_Rollback()
	Return False
End If

If SqlCa.SqlnRows > 1 Then 
	MessageBox("Erro", "Foram encontrados mais de um registro para a atualiza$$HEX2$$e700e300$$ENDHEX$$o de erro para o controle '" + String(al_controle) + "'.")
	SqlCa.of_Rollback()
	Return False
End If

SqlCa.of_Commit()

ls_Msg_Email = 'Houveram problemas na interface de descida do SAP . <br>'+ &
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

Select cd_chave_legado
Into	:al_Filial
From integracao_sap
Where	cd_tabela = 'FILIAL'
	And	cd_chave_sap	= :as_Filial_Sap
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		
	Case 100
		as_Log	= "N$$HEX1$$e300$$ENDHEX$$o foi localizado na tabela 'INTEGRA$$HEX2$$c700c200$$ENDHEX$$O SAP', o c$$HEX1$$f300$$ENDHEX$$digo da filial, com o c$$HEX1$$f300$$ENDHEX$$digo SAP '"+as_Filial_Sap+"'."
		Return False
	Case -1
		as_Log	= "Erro ao localizao o c$$HEX1$$f300$$ENDHEX$$digo da filial no legado: " + SqlCa.SqlErrText
		Return False
End Choose

Return True
end function

public function boolean of_localiza_codigo_fornecedor_legado (string as_fornecedor_sap, ref string as_fornecedor, ref string as_log);If Isnull(as_fornecedor_sap) or (Trim(as_fornecedor_sap) = "") Then
	SetNull(as_Fornecedor)
	Return True
End If

Select cd_fornecedor
Into	:as_Fornecedor
From fornecedor 
Where	cd_fornecedor_sap			= :as_Fornecedor_Sap
	And	coalesce(id_situacao, 'A')	<> 'I'
Using SqlCa;

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

dc_uo_ds_base 	lds 
dc_uo_ds_base 	lds_itens 
//dc_uo_transacao	lo_SqlCa

SetNull(ls_Nulo)

Try
		
	lds = Create dc_uo_ds_base
	If Not lds.of_ChangeDataObject("ds_ge473_interface_sap_item_nova", False) Then
		as_log = "Erro ao alterar a DW [ds_ge473_interface_sap_item_nova]. Objeto [uo_ge473_comum], fun$$HEX2$$e700e300$$ENDHEX$$o [of_carrega_dados]."
		Return False
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
			
			// Recupera todas os valores do item
			ll_Registros = lds.Retrieve(all_controle, lds_itens.Object.nr_item[ll_Linha] )	
			
			If ll_Registros > 0 Then
				
				// Insere o registo na na DS que ser$$HEX1$$e100$$ENDHEX$$ consumida posteriormente pelos programas
				ll_Insert = ids_lista_registros.InsertRow(0)
				
				// Faz a leitura do array para pegar o nome das colunas na DS
				For ll_Linha_Coluna = 1 To UpperBound(is_coluna[])
					ls_NM_Coluna = is_coluna[ll_Linha_Coluna]
					
					If ls_NM_Coluna = 'nr_registro' Then
						Continue
					End If 
					
					// Procura o valor da coluna nos registros recuperados
					ll_Find = lds.Find("cd_coluna = '" + ls_NM_Coluna + "'", 1, ll_Registros)
					
					If ll_Find > 0 Then
						ls_Valor_Coluna = lds.Object.vl_item[ll_Find]
						
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
					ElseIf ll_Find = 0 Then
						as_log = "Coluna '" + ls_NM_Coluna + "' n$$HEX1$$e300$$ENDHEX$$o foi localizada na interface_sap_item do controle '" + String(all_Controle) + "'. Objeto [uo_ge473_comum], fun$$HEX2$$e700e300$$ENDHEX$$o [of_carrega_dados]."
						Return False
					Else
						as_log = "Erro no FIND ao localizar o valor da coluna do controle na tabela interface_sap_item."
						Return False		
					End If
					
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

public function boolean of_atualizacao_pendente (long al_controle, ref long al_registro_pendente, ref string as_log);Select count(*)
Into :al_registro_pendente
From 	interface_sap
Where nr_controle = :al_controle
    and id_situacao in ('C', 'E')
    and dh_processamento is null
Using SqlCa;

If SqlCa.sqlcode = -1 Then
	as_log = "Erro ao verificar se h$$HEX1$$e100$$ENDHEX$$ registros para processar na tabela [interface_sap]. Erro: "+SqlCa.sqlErrText
	Return False
End If

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

on uo_ge473_comum.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge473_comum.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;ids_lista_registros = Create dc_uo_ds_base

io_SqlCa	= create dc_uo_transacao

io_SqlCa.ivs_database = "SYBASE"
	
If Not io_SqlCa.of_Connect(gvo_Aplicacao.ivs_DataSource, 'GE473 - Interface') Then
//		as_log = "Erro ao conectar no Sybase. Objeto [uo_ge473_comum], fun$$HEX2$$e700e300$$ENDHEX$$o [of_carrega_dados]."
//		Return False
End If

ids_lista_registros.of_SetTransObject(io_SqlCa)
end event

event destructor;Destroy ids_lista_registros
Destroy io_SqlCa
end event

