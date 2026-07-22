HA$PBExportHeader$uo_ge550_esteira_automatica.sru
forward
global type uo_ge550_esteira_automatica from nonvisualobject
end type
end forward

global type uo_ge550_esteira_automatica from nonvisualobject
end type
global uo_ge550_esteira_automatica uo_ge550_esteira_automatica

type variables
String ivs_usuario
String ivs_senha
String is_Url_Status_Servico
String is_Url_Envio
String is_Url_Retorno
String is_Status_Servico

String ivs_ws_login = "WEBSERVICE"
String ivs_ws_pwd	 = "1234123"

Long ivl_id_integracao  = 0

Boolean ib_Desenvolvimento = False
end variables

forward prototypes
public function boolean of_envia_email (string ps_mensagem)
public function boolean of_monta_item_json (string ps_i_station, string ps_i_endereco, string ps_i_qtdd, string ps_i_codigo, string ps_i_descr, string ps_i_ean, ref string ps_json_station, ref string ps_json_item, ref string ps_log)
public function boolean of_monta_etiqueta_json (string ps_ws_login, string ps_ws_pwd, string ps_i_invnumber, string ps_i_numfilial, string ps_i_prioridade, string ps_i_articletype, string ps_i_filial, string ps_i_numbacia, string ps_i_endclient, string ps_i_cidclient, string ps_i_cepclient, string ps_i_ufclient, string ps_i_numrota, string ps_i_dataorder, string ps_i_dataimporder, string ps_i_tubarcode, string psi_numvolume, string ps_i_numvoltotal, ref string ps_json_retorno, ref string ps_log)
public function boolean of_atualiza_etiqueta_impressa (long pl_cd_filial, long pl_cd_pedido, long pl_cd_volume, ref string ps_erro)
public function boolean of_envia_esteira_automatica (long pl_cd_filial, long pl_pedido, long pl_volume, string ps_tipo_envio, ref string ps_erro)
public function boolean of_agendar_separacao_automatica (date pdh_data)
public function boolean of_incluir_integracao_esteira (long pl_cd_filial, long pl_nr_pedido_distribuidora, long pl_nr_volume, long pl_id_integracao, string pds_integracao, string ps_nr_picking, string ps_id_tipo, ref string ps_erro)
public function boolean of_retira_caracteres (string as_json, ref string as_erro)
public function boolean of_busca_urls_envio_esteira (ref string ps_url_status_servico, ref string ps_url_envio, ref string ps_url_retorno, ref string ps_erro)
public function boolean of_envia_json (string ps_metodo, string ps_json_envio, string ps_url, ref string ps_json_retorno, ref string ps_erro)
public function boolean of_verifica_config_loja_esteira_auto (long pl_cd_filial, ref string ps_erro)
public function boolean of_verifica_pedido_enviado (long pl_cd_filial, long pl_nr_pedido, long pl_nr_volume, ref string ps_erro)
public function boolean of_verifica_esteira (integer pi_esteira, ref string ps_erro)
public function boolean of_libera_pedido_areenviar (long pl_cd_filial, long pl_nr_pedido, long pl_nr_volume, ref string ps_erro)
end prototypes

public function boolean of_envia_email (string ps_mensagem);String lvs_Msg

s_email lst_Email

lvs_Msg = "Aten$$HEX2$$e700e300$$ENDHEX$$o, <br><br>" + &
               "Descri$$HEX2$$e700e300$$ENDHEX$$o: "+ps_mensagem+"<br>"

lst_Email.ps_mensagem = lvs_Msg
lst_Email.pb_assinatura = True

If Not gf_ge202_envia_email_padrao( 271 , lst_Email ) Then
   Return False	
End If

Return True
end function

public function boolean of_monta_item_json (string ps_i_station, string ps_i_endereco, string ps_i_qtdd, string ps_i_codigo, string ps_i_descr, string ps_i_ean, ref string ps_json_station, ref string ps_json_item, ref string ps_log);String lvs_json_station , lvs_log, lvs_json_item

lvs_json_station = ' { "i_station":' + '"' + ps_i_station +  '"' + '} ' 

lvs_json_item ='  { ' + &
							 ' "i_endereco":' + '"' + ps_i_endereco + '",' + &
							 ' "i_qtdd":'     + '"' + ps_i_qtdd    + '",' + &
							 ' "i_codigo":'   + '"' + ps_i_codigo   + '",' + &
							 ' "i_ean":'      + '"' + ps_i_ean     + '",' + &
							 ' "i_descr":'    + '"' + ps_i_descr    + '"' + &
						 '  } ' 
 
// Retirar caracteres diferentes
If Not this.of_retira_caracteres (  lvs_json_station + lvs_json_item  , Ref lvs_Log)  Then 
	ps_log = lvs_log
	Return False
End If 

// valida gerou nulo
If IsNull( lvs_json_station + lvs_json_item ) Then
	ps_log = 'Produtos do arquivo JSON foram gerados nulo.'
	Return False	
End If	 

ps_json_station		=	lvs_json_station
ps_json_item		=	lvs_json_item			
 
Return True 
 
end function

public function boolean of_monta_etiqueta_json (string ps_ws_login, string ps_ws_pwd, string ps_i_invnumber, string ps_i_numfilial, string ps_i_prioridade, string ps_i_articletype, string ps_i_filial, string ps_i_numbacia, string ps_i_endclient, string ps_i_cidclient, string ps_i_cepclient, string ps_i_ufclient, string ps_i_numrota, string ps_i_dataorder, string ps_i_dataimporder, string ps_i_tubarcode, string psi_numvolume, string ps_i_numvoltotal, ref string ps_json_retorno, ref string ps_log);String lvs_json , lvs_log

lvs_json = '{ ' + &
			  ' "ws_login":'       + '"' + ps_ws_login       + '",' + &
			  ' "ws_pwd":'         + '"' + ps_ws_pwd         + '",' + &
			  ' "ws_coid":'        +         "1"             + ',' + & 
			  ' "i_invnumber":'    + '"' + ps_i_invnumber    + '",' + &
			  ' "i_numfilial":'    + '"' + ps_i_numfilial    + '",' + &
			  ' "i_prioridade":'   + '"' + ps_i_prioridade   + '",' + &
		     ' "i_articletype":'  + '"' + ps_i_articletype  + '",' + &
			  ' "i_filial":'       + '"' + ps_i_filial       + '",' + &
			  ' "i_numbacia":'     + '"' + ps_i_numbacia     + '",' + &
			  ' "i_endclient":'    + '"' + ps_i_endclient    + '",' + &
			  ' "i_cidclient":'    + '"' + ps_i_cidclient    + '",' + & 
			  ' "i_cepclient":'    + '"' + ps_i_cepclient    + '",' + &  
			  ' "i_ufclient":'     + '"' + ps_i_ufclient     + '",' + &   
			  ' "i_numrota":'      + '"' + ps_i_numrota      + '",' + &    
			  ' "i_dataorder":'    + '"' + ps_i_dataorder    + '",' + &    
		     ' "i_dataimporder":' + '"' + ps_i_dataimporder + '",'  + &
			'   "orders":[ ' + &
                          ' { ' + &
										'  "i_tubarcode":'  + '"' + ps_i_tubarcode    + '",' + &    
										'  "i_numvolume":'  + '"' + psi_numvolume     + '",' + &    
										'  "i_numvoltotal":'  + '"' + ps_i_numvoltotal  + '" ,'     
                                
// Retirar caracteres diferentes
If Not this.of_retira_caracteres (  lvs_Json , Ref lvs_Log)  Then 
	ps_log = lvs_log
	Return False
End If 

// valida gerou nulo
If IsNull( lvs_Json ) Then
	ps_log = 'Cabecalho do aquivo JSON foi gerado nulo.'
	Return False	
End If	 
 
ps_json_retorno	=	lvs_json 
 
Return True 
 
end function

public function boolean of_atualiza_etiqueta_impressa (long pl_cd_filial, long pl_cd_pedido, long pl_cd_volume, ref string ps_erro);String ls_erro

Update wms_lista_separacao 
	 Set dh_impressao = getdate()
 Where cd_filial 						= :pl_cd_Filial
	And nr_pedido_distribuidora 	= :pl_cd_Pedido
	And nr_volume 					= :pl_cd_Volume
	Using SqlCa;
			
If SqlCa.SqlCode = -1 Then
	ls_Erro = SqlCa.SqlErrText
	SqlCa.of_Rollback()
	ps_erro = "Erro ao atualizar a dh_impresso: "+ls_Erro 
	Return False		
End If

Return True
end function

public function boolean of_envia_esteira_automatica (long pl_cd_filial, long pl_pedido, long pl_volume, string ps_tipo_envio, ref string ps_erro);Long lvl_Cont, lvl_Linha, lvl_cd_Esteira, lvl_Filial, lvl_Pedido, lvl_Volume
Long lvl_cod_retorno, lvl_cont_itens,lvl_linhas_itens

String lvs_ds_integracao
String lvs_station
String lvs_item
String lvs_json,lvs_json_retorno,lvs_erro
String lvs_url, ls_erro
String lvs_i_filial
String lvs_i_station
String lvs_i_endereco
String lvs_i_qtdd
String lvs_i_codigo
String lvs_i_descricao 
String lvs_json_station
String lvs_json_item
String lvs_i_ean
String lvs_etiqueta_json
String lvs_i_invnumber   
String lvs_i_numfilial   
String lvs_i_numrota     
String lvs_i_numvolume   
String lvs_i_tubarcode   
String lvs_i_numvoltotal  
String lvs_i_numbacia 
String lvs_linhas_itens
String lvs_i_prioridade
String lvs_i_cepclient   
String lvs_i_endclient   
String lvs_i_cidclient   
String lvs_i_ufclient    
String lvs_i_articletype 

String ldt_i_dataorder   
String ldh_i_dataimporder
String ls_Operador

//If (SqlCa.Database <> 'central') Then ib_Desenvolvimento = True	
ivl_id_integracao = 0

Try

	dc_uo_ds_base lds_ge550_etiquetas
	dc_uo_ds_base lds_ge550_itens
	
	lds_ge550_etiquetas	= create dc_uo_ds_base
	lds_ge550_itens   		= create dc_uo_ds_base

	// Carrega Informa$$HEX2$$e700f500$$ENDHEX$$es de URL 
	If Not this.of_busca_urls_envio_esteira(Ref is_Url_Envio, Ref is_Url_Retorno , Ref is_Url_Status_Servico, Ref ls_erro ) Then 
		ivl_id_integracao = 0
		ps_erro = "Aviso - EsteiraBrint: Erro Busca URL Configuracao de Esteira Autom$$HEX1$$e100$$ENDHEX$$tica."  
		Return False
	End If
	
	If Not lds_ge550_etiquetas.of_ChangeDataObject( 'ds_ge550_etiquetas_separacao' , False) Then 
		ivl_id_integracao = 0
		ps_erro = "Erro no change data object da ds_ge550_etiquetas_separacao. Funcao of_envia_esteira_automatica"
		Return False
	End If	
	
	If Not lds_ge550_itens.of_ChangeDataObject( 'ds_ge550_itens_separacao' , False) Then 
		ivl_id_integracao = 0
		ps_erro = "Erro no change data object da ds_ge550_itens_separacao. Funcao of_envia_esteira_automatica"
		Return False
	End If	
	
	lvl_Linha = lds_ge550_etiquetas.Retrieve(pl_cd_filial, pl_pedido, pl_volume)
	
	If lvl_Linha < 0 Then
		ivl_id_integracao = 0
		ps_Erro = "Erro no retrieve da ds_ge550_etiquetas_separacao. Filial:" + String(pl_cd_filial) + "|Ped:" + String(pl_Pedido) + "|Vol:" + String(pl_Volume)
		Return False
	End If
	
	For lvl_Cont = 1 To lvl_Linha
		
		//Buscar Etiqueta
		lvs_i_filial							=	lds_ge550_etiquetas.object.i_filial						[lvl_Cont]				
		lvs_i_invnumber					=	String(lds_ge550_etiquetas.object.i_invnumber		[lvl_Cont])
		lvs_i_numfilial						=	String(lds_ge550_etiquetas.object.i_numfilial		[lvl_Cont])   
		lvs_i_numrota						=	String(lds_ge550_etiquetas.object.i_numrota		[lvl_Cont])     
		lvs_i_numvolume					=	String(lds_ge550_etiquetas.object.i_numvolume	[lvl_Cont])   
		lvs_i_tubarcode						=	String(lds_ge550_etiquetas.object.i_tubarcode		[lvl_Cont])   
		lvs_i_numvoltotal					=	String(lds_ge550_etiquetas.object.i_numvoltotal	[lvl_Cont])  
		lvs_i_numbacia						=	String(lds_ge550_etiquetas.object.i_numbacia		[lvl_Cont])    
		lvs_i_prioridade					= 	String(lds_ge550_etiquetas.object.i_prioridade 	[lvl_Cont]) //Padr$$HEX1$$e300$$ENDHEX$$o 99 fixado no sql
		lvs_i_cepclient						=	lds_ge550_etiquetas.object.i_cepclient				[lvl_Cont]   
		lvs_i_endclient						=	lds_ge550_etiquetas.object.i_endclient				[lvl_Cont]   
		lvs_i_cidclient						=	lds_ge550_etiquetas.object.i_cidclient				[lvl_Cont]   
		lvs_i_ufclient						=	lds_ge550_etiquetas.object.i_ufclient					[lvl_Cont]    
		lvs_i_articletype					=	lds_ge550_etiquetas.object.i_articletype				[lvl_Cont] 
		ldt_i_dataorder						=	String(lds_ge550_etiquetas.object.i_dataorder		[lvl_Cont])    
		ldh_i_dataimporder				= 	String(lds_ge550_etiquetas.object.i_dataimporder[lvl_Cont])
		
		//Em homologa$$HEX2$$e700e300$$ENDHEX$$o havia este campo com 3 caracteres provocando erro ao enviar o json para a api que aceita no maximo 2 caracteres
		If Len(lvs_i_numbacia) > 2 Then
			ivl_id_integracao = 0
			ps_erro = 'Numero de bacia invalido. ' + 'Bacia:' + lvs_i_numbacia + "|Filial:" + String(pl_cd_filial) + "|Ped:" + String(pl_Pedido) + "|Vol:" + String(pl_Volume)
			Return False  
		End If
		
		//Se n$$HEX1$$e300$$ENDHEX$$o tiver numero de ordem de bacia coloca o 00, banco de destino precisa de algum valor a api nao aceita Nulo neste campo
		If IsNull(lvs_i_numbacia) Then
			lvs_i_numbacia = "00"
		End If
		
		// Monta Etiqueta
		If Not this.of_monta_etiqueta_json(ivs_ws_login			,	ivs_ws_pwd		,	lvs_i_invnumber	,	lvs_i_numfilial		,	lvs_i_prioridade	,	lvs_i_articletype	,	lvs_i_filial		, +&
													lvs_i_numbacia			,	lvs_i_endclient	,	lvs_i_cidclient		,	lvs_i_cepclient		,	lvs_i_ufclient		,	lvs_i_numrota		,	ldt_i_dataorder, +&		
													ldh_i_dataimporder	,	lvs_i_tubarcode	,	lvs_i_numvolume	,	lvs_i_numvoltotal	,	Ref lvs_etiqueta_json	,	Ref lvs_erro	)	Then	
			ivl_id_integracao = 0
			ps_erro = 'Erro ao montar etiqueta: ' + lvs_erro + ". Filial:" + String(pl_cd_filial) + "|Ped:" + String(pl_Pedido) + "|Vol:" + String(pl_Volume)
			Return False  
		End If
		
		lvl_linhas_itens = lds_ge550_itens.Retrieve(pl_Cd_Filial, pl_Pedido, pl_Volume)
		
		If lvl_linhas_itens <= 0 Then
			ivl_id_integracao = 0
			ps_Erro = "Erro no retrieve da ds_ge550_itens_separacao. Filial:" + String(pl_cd_filial) + "|Ped:" + String(pl_Pedido) + "|Vol:" + String(pl_Volume)
			Return False
		End If
				
		For lvl_cont_itens = 1 To lvl_linhas_itens
			
			lvs_i_station			=	lds_ge550_itens.object.i_station			[lvl_cont_itens]
			lvs_i_ean				=	lds_ge550_itens.object.i_ean				[lvl_cont_itens]
			lvs_i_endereco      =	lds_ge550_itens.object.i_endereco		[lvl_cont_itens]
			lvs_i_qtdd			=	String(lds_ge550_itens.object.i_qtdd		[lvl_cont_itens])
			lvs_i_codigo			=	String(lds_ge550_itens.object.i_codigo	[lvl_cont_itens])
			lvs_i_descricao		=	lds_ge550_itens.object.i_descricao		[lvl_cont_itens]	
			
			If IsNull(lvs_i_station) Then
				ivl_id_integracao = 0
				ps_erro = 'Endereco nao configurado. ' + 'End:' + lvs_i_endereco + "|Filial:" + String(pl_cd_filial) + "|Ped:" + String(pl_Pedido) + "|Vol:" + String(pl_Volume)
				Return False  
			End If
			
			//Pega somente os 3 ultimos digitos do EAN, tamanho max na api $$HEX1$$e900$$ENDHEX$$ 3
			lvs_i_ean = Right(Trim(lvs_i_ean), 3)

			If Not this.of_monta_item_json(lvs_i_station, lvs_i_endereco, lvs_i_qtdd, lvs_i_codigo, lvs_i_descricao, lvs_i_ean, Ref lvs_json_station, Ref lvs_json_item, Ref lvs_erro) Then	
				ivl_id_integracao = 0
				ps_erro = 'Erro ao montar item: ' + lvs_erro + ". Filial:" + String(pl_cd_filial) + "|Ped:" + String(pl_Pedido) + "|Vol:" + String(pl_Volume)
				Return False  
			End If
			
			//Verifica se chegou no final dos itens
			If lvl_cont_itens		=	lvl_linhas_itens Then
				
				If lvs_station <> "" Then
					//Verifica se ja contem o lvs_json_station no lvs_station
					If Match(lvs_station, lvs_json_station) Then
						lvs_station		= 	' "stations":[ ' + lvs_station + ' ], ' 
					Else
						lvs_station		= 	' "stations":[ ' + lvs_station + ', ~n' + lvs_json_station +    ' ], ' 
					End If
				//Caso seja somente 1 item no pedido
				Else
					lvs_station = 	' "stations":[ ' + lvs_json_station + ' ], '  
				End If
				
				lvs_item			=	' "itens":[ ' + lvs_item + lvs_json_item + ' ]  }' 	 +   ' ]  } ' 				     		
				lvs_json			=	lvs_station + lvs_item
				
				//Finaliza arquivo json
				lvs_json			=	lvs_etiqueta_json + lvs_json 
				
				// Retirar caracteres diferentes
				If Not this.of_retira_caracteres (  lvs_json  , Ref ls_Erro)  Then 
					ivl_id_integracao = 0
					ps_erro = ls_Erro + ". Filial:" + String(pl_cd_filial) + "|Ped:" + String(pl_Pedido) + "|Vol:" + String(pl_Volume)
					Return False
				End If 
				
				//Valida se esta ok
				If IsNull( lvs_json ) OR Trim(lvs_json) = "" Then
					ivl_id_integracao = 0
					ps_erro = 'Problema no arquivo JSON. Foi gerado nulo. Filial:' + String(pl_cd_filial) + "|Ped:" + String(pl_Pedido) + "|Vol:" + String(pl_Volume)
					Return False	
				End If	 
	
				If Not ib_Desenvolvimento Then
					// Envio. metodo + json + url 
					If Not this.of_envia_json ( 'POST', lvs_json, is_Url_Status_Servico, Ref is_Status_Servico, Ref ls_erro )  Then
						if Pos(ls_erro, 'Pedido Ja existente na Base') > 0 then
							ivl_id_integracao = 1
						else
							//ivl_id_integracao = 0
							ps_erro =  ls_erro 
							//Return False
						end if
					End If 
					
					If ivl_id_integracao = 1 Then
						lvs_ds_integracao	= 'Sucesso na Integracao'
					Else
						lvs_ds_integracao	= ps_erro
					End If 	
						
					If Not this.of_incluir_integracao_esteira(pl_cd_filial,pl_pedido,pl_volume,ivl_id_integracao,lvs_ds_integracao,lvs_i_tubarcode,ps_tipo_envio, Ref ls_erro )  Then
						ps_erro = ls_erro
						Return False
					End If
				End If	
			Else
				//Adiciona stations e itens
				If lvs_station <> "" Then
					//Verifica se ja contem o lvs_json_station no lvs_station
					If Not Match(lvs_station, lvs_json_station) Then
						lvs_station = lvs_station + ', ~n' + lvs_json_station 
					End If
				Else
					lvs_station = lvs_json_station
				End If
				//Adiciona itens
				lvs_item = lvs_item + lvs_json_item + ', ~n '
			End If			
		Next	
	Next	
	
	If ivl_id_integracao = 1 Then 
		Return True
	Else
		Return False
	End If 	

Catch (RunTimeError lo_error)
	ps_Erro = lo_error.GetMessage()
	Return False
Finally
	If IsValid(lds_ge550_etiquetas) Then Destroy(lds_ge550_etiquetas)
	If IsValid(lds_ge550_itens) Then Destroy(lds_ge550_itens)
End Try
end function

public function boolean of_agendar_separacao_automatica (date pdh_data);dc_uo_ds_base lds_esteira
lds_esteira	           = create dc_uo_ds_base

uo_ge550_esteira_automatica luo_esteira
luo_esteira             = Create  uo_ge550_esteira_automatica

Long lvl_row, lvl_cont, lvl_filial, lvl_pedido, lvl_volume

DateTime ldh_data_1, ldh_data_2

String ls_erro

If (SqlCa.Database <> 'central') Then ib_Desenvolvimento = True	

ldh_data_1 =  DateTime(String(pdh_data) + ' 00:00:00.000')
ldh_data_2 =  DateTime(String(pdh_data) + ' 23:59:59.000')
 
If Not lds_esteira.of_ChangeDataObject( 'ds_ge550_agendar_esteira_automatica' , False) Then 
	luo_esteira.of_envia_email( "Erro ao agendar Esteira Automatica." )
	Destroy lds_esteira
	Destroy luo_esteira
	Return False
End If	

lvl_row = lds_esteira.Retrieve(ldh_data_1,ldh_data_2)

For lvl_cont = 1 To lvl_row
	
	lvl_Filial		= lds_esteira.Object.cd_filial						[lvl_cont]
	lvl_Pedido	= lds_esteira.Object.nr_pedido_distribuidora	[lvl_cont]
	lvl_Volume	= lds_esteira.Object.nr_volume					[lvl_cont]
	
	// Verificar se loja esta configurada
	If Not luo_esteira.of_verifica_config_loja_esteira_auto( lvl_Filial, Ref ls_Erro ) Then
		If Not ib_Desenvolvimento Then
			If Not this.of_incluir_integracao_esteira(	lvl_Filial,	lvl_Pedido,	lvl_Volume,	ivl_id_integracao , Left("Erro: " + ls_Erro, 100),	'0', '1', Ref ls_erro )  Then
				this.of_envia_email("Erro ao incluir integracao esteira. " + ls_erro + ". Filial " + String(lvl_Filial) + ", Pedido " + String(lvl_Pedido) + ", Volume " + String(lvl_Volume) + "")
				Return False
			End If
			Close(w_Aguarde_1)
			
			//Envia email com o erro
			luo_esteira.of_envia_email( ls_erro )
			Destroy lds_esteira
			Destroy luo_esteira		
			Continue
		End If
	End If 
	
	//Verifica se o pedido ja foi integrado
	If Not luo_esteira.of_verifica_pedido_enviado(lvl_Filial, lvl_Pedido, lvl_Volume, Ref ls_Erro) Then
		If Not ib_Desenvolvimento Then
			If Not this.of_incluir_integracao_esteira(	lvl_Filial,	lvl_Pedido,	lvl_Volume,	ivl_id_integracao , Left("Erro: " + ls_Erro, 100),	'1', '1', Ref ls_erro )  Then
				this.of_envia_email("Erro ao incluir integracao esteira. " + ls_erro + ". Filial " + String(lvl_Filial) + ", Pedido " + String(lvl_Pedido) + ", Volume " + String(lvl_Volume) + "")
				Return False
			End If
			Close(w_Aguarde_1)
			
			//Envia email com o erro
			luo_esteira.of_envia_email( ls_erro )
			Destroy lds_esteira
			Destroy luo_esteira		
			Continue
		End If	
	End If	
	
	//Inicia processo de integra$$HEX2$$e700e300$$ENDHEX$$o
	If Not luo_esteira.of_envia_esteira_automatica( lvl_Filial, lvl_pedido, lvl_volume , '1' , Ref ls_erro )   Then
		If Not ib_Desenvolvimento Then
			If Not this.of_incluir_integracao_esteira(	lvl_Filial,	lvl_Pedido,	lvl_Volume,	ivl_id_integracao , Left( ls_Erro, 100),	'0', '1', Ref ls_erro )  Then
				this.of_envia_email("Erro ao incluir integracao esteira. " + ls_erro + ". Filial " + String(lvl_Filial) + ", Pedido " + String(lvl_Pedido) + ", Volume " + String(lvl_Volume) + "")
				Return False
			End If
			Close(w_Aguarde_1)
			
			//Envia email com o erro
			luo_esteira.of_envia_email( ls_erro )
			Destroy lds_esteira
			Destroy luo_esteira
			Continue
		End If	
	End If

Next
	
Return True
end function

public function boolean of_incluir_integracao_esteira (long pl_cd_filial, long pl_nr_pedido_distribuidora, long pl_nr_volume, long pl_id_integracao, string pds_integracao, string ps_nr_picking, string ps_id_tipo, ref string ps_erro);DateTime ldh_inclusao

Long ll_existe

String ls_Erro
  
ldh_inclusao = DateTime(gf_GetServerDate()) 
 
 Select count(*)
    Into :ll_existe
  From wms_integracao_esteira
 Where cd_filial 						=:pl_cd_filial 
     And nr_pedido_distribuidora 	=:pl_nr_pedido_distribuidora
	And nr_volume   					=:pl_nr_volume
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_Erro = SqlCa.SqlErrText
	SqlCa.of_Rollback();
	ps_erro = "Erro ao verificar se existe registro na wms_integracao_esteira."
	Return False
End If
  
If ll_existe > 0 Then
	Update wms_integracao_esteira
	      Set id_integracao  =:pl_id_integracao
			 , ds_integracao =:pds_integracao
			 , dh_inclusao	  = :ldh_inclusao
 	 Where cd_filial 						=:pl_cd_filial
	     And nr_pedido_distribuidora	=:pl_nr_pedido_distribuidora
		And nr_volume						=:pl_nr_volume
	Using SqlCa;

Else	
	INSERT INTO wms_integracao_esteira  
	( cd_filial
	, nr_pedido_distribuidora
	, nr_volume
	, id_integracao
	, ds_integracao
	, nr_picking
	, id_tipo
	, dh_inclusao )  
	VALUES (  :pl_cd_filial
				, :pl_nr_pedido_distribuidora
				, :pl_nr_volume
				, :pl_id_integracao
				, :pds_integracao
				, :ps_nr_picking
				, :ps_id_tipo
				, :ldh_inclusao )
	Using SqlCa;
End If

If Sqlca.Sqlcode = -1 Then
	ls_Erro = SqlCa.SqlErrText
  	SqlCa.of_RollBack();
  	ps_erro = "Erro no update/insert da wms_integracao_esteira."
   	Return false
End If

Sqlca.of_commit( );

Return True
end function

public function boolean of_retira_caracteres (string as_json, ref string as_erro);Try
	as_json	= gf_Replace(as_json, "'", " ", 0)
	as_json	= gf_Replace(as_json, "&", "&#38;", 0)
	as_json	= gf_Replace(as_json, "	", "", 0)
		
catch (RuntimeError lo_rte)
	as_Erro	= "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_retira_caracteres', objeto 'uo_ge550_esteira_automatica'. Erro: "+lo_rte.GetMessage()
	Return False
End Try

Return True
end function

public function boolean of_busca_urls_envio_esteira (ref string ps_url_status_servico, ref string ps_url_envio, ref string ps_url_retorno, ref string ps_erro);
//// URL STATUS DO SERVICO
Select de_parametro
Into :ps_url_status_servico
From  wms_parametro
Where cd_parametro = 'URL_STATUS_ESTEIRA_AUTOMATICA'
Using SqlCA;
				
If SqlCa.SqlCode = - 1 Then
	ps_Erro = "Erro ao consultar url_status: "+Sqlca.sqlErrText
	Return False
End If
		
If IsNull(ps_url_status_servico) or ps_url_status_servico='' Then 
	ps_Erro = "Erro ao consultar url_status: "+Sqlca.sqlErrText
	Return False
End If 


/// URL ENVIO INFORMA$$HEX2$$c700d500$$ENDHEX$$ES
Select de_parametro
Into :ps_url_envio
From  wms_parametro
Where cd_parametro = 'URL_ENVIO_ESTEIRA'
Using SqlCA;
				
If SqlCa.SqlCode = - 1 Then
	ps_Erro = "Erro ao consultar url_envio: "+Sqlca.sqlErrText
	Return False
End If
		
If IsNull(ps_url_envio) or ps_url_envio='' Then 
	ps_Erro = "Erro ao consultar url_envio: "+Sqlca.sqlErrText
	Return False
End If 
		
/// URL RETORNO INFORMA$$HEX2$$c700d500$$ENDHEX$$ES		
Select de_parametro
Into :ps_url_retorno
From  wms_parametro
Where cd_parametro = 'URL_RETORNO_RETORNO_ESTEIRA_AUTOMATICA'
Using SqlCA;	
		
If SqlCa.SqlCode = - 1 Then
	ps_Erro = "Erro ao consultar url_retorno: "+Sqlca.sqlErrText
	Return False
End If
		
If IsNull(ps_url_envio) or ps_url_envio='' Then 
	ps_Erro = "Erro ao consultar url_retorno: "+Sqlca.sqlErrText
	Return False
End If 		

is_Url_Status_Servico = ps_url_status_servico		
is_Url_Envio 	= ps_url_envio
is_Url_Retorno  = ps_url_retorno

Return True 
end function

public function boolean of_envia_json (string ps_metodo, string ps_json_envio, string ps_url, ref string ps_json_retorno, ref string ps_erro);String ls_Status_Text

OleObject	lo_Http,&
				lo_Send
			
Long	li_rc1, li_rc2
Long  ll_status_code

Try
	Try
		lo_Send	= CREATE oleobject
		lo_Http	= CREATE oleobject
		lo_Send.ConnectToNewObject("Msxml2.DOMDocument.6.0")		
		lo_Http.ConnectToNewObject("MSXML2.SERVERXMLHTTP.6.0")
		lo_Http.open (ps_Metodo, ps_Url, False)  
		lo_Http.SetRequestHeader( "Content-Type", "application/json")
		
		If ps_Metodo = "POST" Then
			lo_Http.send(ps_json_envio)
		Else
			//lo_Http.send(ps_url)
		End If

		//Pega a resposta do web service
		ls_Status_Text 	= lo_Http.StatusText
		ll_Status_Code 	= lo_Http.Status
		ps_json_retorno = lo_Http.ResponseText
		
		//Retorno for maior que 201 n$$HEX1$$e300$$ENDHEX$$o foi integrado
		If ll_Status_Code > 201 Then
			ivl_id_integracao = ll_Status_Code
			ps_Erro = String(ls_Status_Text)
			Return False
		Else					
			ivl_id_integracao = 1
			Return True 
		End If
	Catch (RuntimeError lo_rte2)
			ivl_id_integracao = 0
			Return False
	Finally
		//Desconecta
		lo_Http.DisconnectObject()	
		GarbageCollect()
		Destroy(lo_Http)
		Destroy(lo_Send)
	End Try

Catch (RuntimeError rte)	
	ps_Erro = "Erro no try do envio: " +String(ll_Status_Code)+ "~r~nDescricao Erro: " + String(ls_Status_Text) + "~n http_response: " + lo_Http.ResponseText + "~n json_retorno: " + ps_Json_Retorno
	Return False	
End Try
end function

public function boolean of_verifica_config_loja_esteira_auto (long pl_cd_filial, ref string ps_erro);String ls_parametro
String ls_Erro

Select Coalesce(vl_parametro, 'N')
   Into :ls_parametro 
 From parametro_loja 
Where cd_parametro = 'ID_FILIAL_ESTEIRA_AUTOMATICA'
    and cd_filial =:pl_cd_filial
 Using sqlCA;

Choose Case Sqlca.Sqlcode
	Case 0
		If ls_parametro = 'N' Then
			ivl_id_integracao  = 0
			ps_Erro = ("Parametro loja 'ID_FILIAL_ESTEIRA_AUTOMATICA' da filial [" +String(pl_cd_filial) + "] nao esta configurado para Esteira Automatica.")
			Return False
		Else
			Return True
		End If
				
	Case 100
		ivl_id_integracao  = 0
		ps_Erro = ("Parametro loja 'ID_FILIAL_ESTEIRA_AUTOMATICA' nao cadastrado para a filial [" +String(pl_cd_filial) + "].")
		Return False
		
	Case -1		
		ivl_id_integracao  = 0
		ps_Erro = ("Erro ao verificar o parametro loja 'ID_FILIAL_ESTEIRA_AUTOMATICA' da filial [" + String(pl_cd_filial) + "]. " + Sqlca.SqlErrText )
		//Enviar email com o erro
		this.of_envia_email( ps_Erro )
		Return False
End Choose

Return True
end function

public function boolean of_verifica_pedido_enviado (long pl_cd_filial, long pl_nr_pedido, long pl_nr_volume, ref string ps_erro);Long lvl_existe

 Select count(*)
    Into :lvl_existe
  From wms_integracao_esteira
Where cd_filial 						=:pl_cd_filial
    And nr_pedido_distribuidora =:pl_nr_pedido
    And nr_volume					=:pl_nr_volume 
    And id_integracao = 1	
Using SqlCa;

Choose Case Sqlca.Sqlcode
	Case -1		
		ivl_id_integracao  = 0
		ps_Erro = ("Erro ao consultar se o pedido ja foi enviado para a Filial:" + String(pl_cd_filial) + "|Ped:" + String(pl_nr_pedido) + "|Vol:" + String(pl_nr_volume) + ".~n"  + SqlCa.SqlErrText)
		Return False
		
	Case 0
		//Se existir pedido integrado n$$HEX1$$e300$$ENDHEX$$o continua a integra$$HEX2$$e700e300$$ENDHEX$$o
		If lvl_existe > 0 Then
			ivl_id_integracao  = 0
			ps_Erro = ("Pedido ja integrado para a Filial:" + String(pl_cd_filial) + "|Ped:" + String(pl_nr_pedido) + "|Vol:" + String(pl_nr_volume))
			Return False
		Else
			Return True
		End If
End Choose

end function

public function boolean of_verifica_esteira (integer pi_esteira, ref string ps_erro);String lvs_configurada

 Select  id_utiliza_esteira_autom 
    Into :lvs_configurada
  From wms_esteira 
Where id_situacao  = 'A'  
    And cd_esteira  =:pi_esteira
  Using SqlCA;

Choose Case Sqlca.Sqlcode
	Case 100
		//No caso de todas as esteiras nao encontra informa$$HEX2$$e700f500$$ENDHEX$$es no banco
		ps_erro = "Configura$$HEX2$$e700e300$$ENDHEX$$o da Esteira ["+ string(pi_esteira) +"] n$$HEX1$$e300$$ENDHEX$$o encontrada. "+Sqlca.SqlErrText
		Return False
	Case 0
		If lvs_configurada = "S" Then			
			Return True
		Else 			
			ps_erro = "Esteira ["+ string(pi_esteira) +"] n$$HEX1$$e300$$ENDHEX$$o configurada."
			Return False
		End If
	Case -1
		ps_erro = "Erro ao localizar esteira configurada: "+Sqlca.SqlErrText
		Return False
End Choose

end function

public function boolean of_libera_pedido_areenviar (long pl_cd_filial, long pl_nr_pedido, long pl_nr_volume, ref string ps_erro);Long lvl_existe

Update  wms_integracao_esteira
Set id_integracao = 0 ,  ds_integracao  = null 
Where cd_filial 						=:pl_cd_filial
And nr_pedido_distribuidora =:pl_nr_pedido
And nr_volume					=:pl_nr_volume 
And id_integracao = 1	
Using SqlCA;

Choose Case Sqlca.Sqlcode
	Case -1		
		ivl_id_integracao  = 0
		ps_Erro = ("Erro ao consultar se o pedido ja foi enviado para a Filial:" + String(pl_cd_filial) + "|Ped:" + String(pl_nr_pedido) + "|Vol:" + String(pl_nr_volume) + ".~n"  + SqlCa.SqlErrText)
		Return False
End Choose


Return True 

end function

on uo_ge550_esteira_automatica.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge550_esteira_automatica.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

