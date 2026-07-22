HA$PBExportHeader$uo_el021_rappi.sru
forward
global type uo_el021_rappi from nonvisualobject
end type
end forward

global type uo_el021_rappi from nonvisualobject
end type
global uo_el021_rappi uo_el021_rappi

type variables
		
uo_ge073_json	io_Json
			
uo_produto ivo_produto			
			
String ls_Grava_arquivo,&
			is_Arquivo_Log

String  idh_geracao
String idh_geracao_completa
String lvs_Tipo_Carga
Date adt_parametro

dc_uo_ds_base lds1 
dc_uo_ds_base lds2

Long ii_log

String is_Url_Producao ="https://services.grability.rappi.com/api/cpgs-integration/datasets"
String is_Key = "e89b7a68-86b0-4433-a867-c98312c3e06d"	


end variables

forward prototypes
public function boolean of_gera_dados_rapp ()
public function boolean of_busca_data_parametro (ref date adt_para, ref string as_log)
private function boolean of_envia_servidor_rapp (string as_metodo, string as_url, string as_json_envio, string as_autenticacao_key, boolean ab_utiliza_api_key, boolean ab_utiliza_origem, ref string as_json_retorno, ref string as_erro)
public function boolean of_atualiza_desconto (long al_filial, long al_produto, ref decimal ldc_desconto, ref date ldt_inicio, ref date ldt_termino)
public function boolean of_retira_caracteres (ref string as_json, ref string as_log)
public function boolean of_autenticacao (ref string as_key, ref string as_erro, string as_json, ref string as_json_retorno)
public subroutine of_envia_email (long al_filial, string as_erro_json, datetime adh_data, long al_qtd_produtos, string al_tipo)
public function boolean of_busca_data_parametro_loja (long al_filial, ref string as_log, ref string idt_geracao, ref string idt_geracao_completa)
public function boolean of_atualiza_horario_atualizacao (long al_filial, ref string as_log, boolean lb_tipo)
public function boolean of_gerar_arquivo (integer al_filial, date adt_saldo, ref string as_json, ref string as_log, ref long al_qtd_produtos, ref boolean lb_tipo_atualizacao)
end prototypes

public function boolean of_gera_dados_rapp ();Boolean lb_Sucesso = False
Boolean lb_Tipo

Long ll_Linhas,&
		ll_Linha,&
		ll_Loja,&
		ll_qtd
		
String as_Log,&
		  lvs_json,&
		  lvs_json_retorno,&
		  lvs_msg

DateTime ldt_geracao
ll_qtd = 0


Try	
	// Busca lojas com Parametro  = "S" para Rappi
	lds1  = Create dc_uo_ds_base
	If Not lds1.of_ChangeDataObject('ds_el021_lojas_configuradas', False) Then 
		gvo_aplicacao.of_grava_log("Lista lojas Rappi - Erro alterar a DW [ds_el021_lojas_configuradas] - uo_el021_rappi.of_gera_dados_rappi")
		lb_Sucesso = False
	End If
		
	// Busca Data do Parametro para Execu$$HEX2$$e700e300$$ENDHEX$$o
	If Not of_busca_data_parametro (ref adt_parametro, ref as_log) Then 
		gvo_aplicacao.of_grava_log("Rappi - Erro ao buscar data de parametro para Carga - uo_el021_rappi.of_gera_dados_rappi")
		lb_Sucesso = False
	End If 		
	
	// Executa DW de Lojas
	ll_Linhas = lds1.Retrieve()

	// Se tiver Registros
	If ll_Linhas > 0 Then		
		For ll_Linha = 1 To ll_Linhas	// Para todas as Lojas			
			ll_Loja = lds1.Object.cd_filial [ll_Linha]			
			If This.of_gerar_arquivo (ll_Loja ,  adt_parametro, ref lvs_json , ref as_Log, ref ll_qtd, ref lb_tipo ) Then  					// Gera$$HEX2$$e700e300$$ENDHEX$$o do Arquivo para Loja
				If ll_qtd > 0 Then 
					If This.of_autenticacao ( is_Key , ref as_Log, lvs_json ,  ref lvs_json_retorno  ) Then 										// Autentica$$HEX2$$e700e300$$ENDHEX$$o -- > Envio		
						If This.of_atualiza_horario_atualizacao(ll_Loja ,ref as_Log,  lb_tipo   ) Then   													// Atualiza Data e Hora para Loja
							lb_Sucesso = True			
						End If 									
					End If 
				End If 
			End If 
			
			If lb_Sucesso Then 
				of_envia_email ( ll_Loja , lvs_json_retorno , ldt_geracao , ll_qtd , 'S' )
			Else 
				of_envia_email ( ll_Loja , lvs_json_retorno , ldt_geracao , ll_qtd , 'E' )
			End If 
			
		Next
	ElseIf ll_Linhas < 0 Then
		gvo_aplicacao.of_grava_log("Lojas Rappi - Erro na gera$$HEX2$$e700e300$$ENDHEX$$o e envio dos dados ao APP Rappi - uo_el021_rappi.of_gera_dados_rappi")
	End If				
	
Catch ( runtimeerror  lo_rte )
	lb_Sucesso = False	
Finally		
	
	If lb_Sucesso Then
		SqlCa.of_Commit()		
	Else
		SqlCA.of_RollBack()		
		lb_Sucesso = False
	End If	
	
	Destroy (lds1)
End Try

Return lb_Sucesso
end function

public function boolean of_busca_data_parametro (ref date adt_para, ref string as_log);select top 1 dh_saldo 
Into :adt_parametro
From saldo_produto
order by dh_saldo desc  
Using SqlCA;

If SqlCa.SqlCode = -1 Then
	as_Log	= "Erro ao localizar o data do saldo!." + " Erro: "+ SqlCa.SqlErrText
	Return False
End If 

Return True 


end function

private function boolean of_envia_servidor_rapp (string as_metodo, string as_url, string as_json_envio, string as_autenticacao_key, boolean ab_utiliza_api_key, boolean ab_utiliza_origem, ref string as_json_retorno, ref string as_erro);String ls_Status_Text

OleObject	lo_Http,&
				lo_Send
				
Long		li_rc1,&
			li_rc2,&
			ll_Status_Code

Try
	Try
		lo_Send	= CREATE oleobject
		lo_Http	= CREATE oleobject
		lo_Send.ConnectToNewObject("Msxml2.DOMDocument.6.0")		
		lo_Http.ConnectToNewObject("MSXML2.SERVERXMLHTTP.6.0")
		lo_Http.open (as_Metodo, as_Url, False)  
		lo_Http.SetRequestHeader( "Content-Type", "application/json")
		
		If ab_Utiliza_Api_Key Then
			lo_Http.setRequestHeader("api_key", as_Autenticacao_Key)
		End If
		
		// Trust the SSL Certificate 
		lo_Http.setOption(2,'13056') 
		
		If as_Metodo = "POST" Then
			lo_Http.send(as_Json_Envio)
		Else
			lo_Http.send(lo_Send)
		End If
		
		//Pega a resposta do web service
		ls_Status_Text 	= lo_Http.StatusText
		ll_Status_Code 	= lo_Http.Status
		as_json_retorno = lo_Http.ResponseText
	
		If ll_Status_Code > 201 Then
			as_Erro = "App Rappi : Erro no retorno do Web Service.Descri$$HEX2$$e700e300$$ENDHEX$$o : " + String(as_json_retorno)
			gvo_aplicacao.of_grava_log(as_Erro)
			Return False
		Else		
			as_Erro = "App Rappi : Sucesso no retorno do Web Service.Descri$$HEX2$$e700e300$$ENDHEX$$o : " + String(as_json_retorno)
			gvo_aplicacao.of_grava_log(as_Erro)
			Return True 
		End If
	Finally
		//Disconecta
		lo_Http.DisconnectObject()		
		Destroy(lo_Http)
		Destroy(lo_Send)
	End Try

Catch (RuntimeError rte)
	as_Json_Retorno = lo_Http.ResponseText
	as_Erro = "App Rappi : Erro no retorno do Web Service.Codigo do Erro: " +String(ll_Status_Code)+ "~r~nDescri$$HEX2$$e700e300$$ENDHEX$$o Erro: " + ls_Status_Text
	gvo_aplicacao.of_grava_log(as_Erro)
	Return False	
End Try

end function

public function boolean of_atualiza_desconto (long al_filial, long al_produto, ref decimal ldc_desconto, ref date ldt_inicio, ref date ldt_termino);// N$$HEX1$$e300$$ENDHEX$$o mais utilizado abaixo buscando da uo_produto 
select cast(isnull(min(a1.dh_inicio), getdate())  as date) ,  
       cast(isnull(max(a1.dh_termino),getdate()) as date) ,          
       coalesce(max(b1.pc_desconto),0) as pc_desconto  
Into :ldt_inicio,
		: ldt_termino,
		:ldc_desconto
From promocao_sos a1
Inner join promocao_sos_filial f1 
on f1.cd_promocao_sos = a1.cd_promocao_sos
Inner join  promocao_sos_produto b1 
on b1.cd_promocao_sos = a1.cd_promocao_sos
where a1.id_tipo_promocao 	= 'N'
and   a1.id_situacao      		= 'L'               
and   a1.dh_inicio <= (select dh_movimentacao from parametro  where id_parametro = '1')
and   (a1.dh_termino >= (select dh_movimentacao from parametro where id_parametro = '1') or a1.dh_termino is null)
and   b1.cd_produto =: al_produto
and   f1.cd_filial =:al_filial
Using SqlCA;			

If SqlCa.SqlCode = -1 Then
	ldc_desconto  = 0
	Return False
Else
	Return True 
End If 


end function

public function boolean of_retira_caracteres (ref string as_json, ref string as_log);Try
	as_json	= gf_Replace(as_json, "'", " ", 0)
	as_json	= gf_Replace(as_json, "&", "&#38;", 0)
	as_json	= gf_Replace(as_json, "	", "", 0)
		
catch (RuntimeError lo_rte)
	as_Log	= "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_retira_caracteres_especiais', objeto 'uo_el100_sap_cliente'. Erro: "+lo_rte.GetMessage()
	Return False
End Try

Return True
end function

public function boolean of_autenticacao (ref string as_key, ref string as_erro, string as_json, ref string as_json_retorno);String	ls_Json,&
		ls_Login,&
		ls_Senha,&
		ls_Url,&
		ls_json_retorno
		
Boolean	lb_Sucesso = False

Try
	SetNull(as_json_retorno)
	ls_Url	= is_Url_Producao 
		
	If This.of_Envia_Servidor_Rapp ("POST", ls_Url, as_json, is_Key , True , False, Ref ls_Json_Retorno, Ref as_Erro) Then
		lb_Sucesso = True		
		as_json_retorno = ls_Json_Retorno
	Else
		lb_Sucesso = False
		as_json_retorno = ls_Json_Retorno
	End If 	
	
Catch (RuntimeError rte)
	as_Erro = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o of_autenticacao, objeto uo_el02_rappi.of_autenticacao ->Erro: " + rte.getMessage()
	as_json_retorno = ls_Json_Retorno
	lb_Sucesso = False
End Try

Return lb_Sucesso



end function

public subroutine of_envia_email (long al_filial, string as_erro_json, datetime adh_data, long al_qtd_produtos, string al_tipo);DateTime ldh_solicitacao,&
			 ldh_Envio	
String ls_Texto_email
String ls_Dados_Email
Long  ll_Cod_Msg
String ls_Extra_Email
String ls_Texto_Email_Extra
String ls_Tipo

		 
s_email str //ge202
ll_Cod_Msg = 182

If al_tipo = 'E' Then 
	ls_Tipo = "Rappi : Erro de Envio"
Else
	ls_Tipo = "Rappi : Sucesso de Envio"	
End If 	
	
If al_qtd_produtos	 = 0 Then 
	ls_Tipo = "Rappi : Nenhum Produto a Atualizar"
End If 
	
ldh_Envio 	= gf_GetServerDate()	
	
ls_Texto_Email = 	"<HTML>"+&
										"<BODY>"+&
										"<BR>"+&										
										"<TABLE border=0>"+&
										"<TR>"+& 
										"<TD><B>" + ls_Tipo + " no Envio dos Dados</B></TD>"+&	
										"</TR>"+&
										"<TR>"+& 
										"<TD><B>Tipo de Carga: " + lvs_Tipo_Carga + "</B></TD>"+&	
										"</TR>"+&
										"<TR>"+& 
										"<TD><b>Filial : "+String(al_filial)+ "~n</b></TD> "+&	
										"</TR>"+&									
										"<TR>"+& 
										"<TD>Texto do Processo : "+ string(as_erro_json) + "~n</TD> "+&	
										"</TR>"+&																			
										"<TR>"+& 
										"<TD>Data Gera$$HEX2$$e700e300$$ENDHEX$$o/Envio: " +string(ldh_Envio) + "~n</TD> "+&	
										"</TR>"+& 										
										"<TR>"+& 
										"<TD><b>Quantidade de Produtos Atualizados: " +string(al_qtd_produtos) + "~n</b></TD> "+&	
										"</TR>"+& 										
										"</TABLE>"+&
										"</BODY>"+&	
										"</HTML>" 	


If  al_tipo<>"" Then 
	str.ps_Mensagem	= ls_Texto_Email
	//str.ps_to[1] 			= ls_EmailLoja
	str.pb_Assinatura	= True
	gf_ge202_envia_email_padrao(ll_Cod_Msg, str)
Else
	Return 
End If 
end subroutine

public function boolean of_busca_data_parametro_loja (long al_filial, ref string as_log, ref string idt_geracao, ref string idt_geracao_completa);
select 	vl_parametro 
Into	 	:idt_geracao
from    	parametro_loja  
where 	cd_parametro  = 'DH_ULT_CARGA_RAPPI'  
and 		cd_filial  =:al_filial
Using SqlCA;


If SqlCa.SqlCode = -1 Then
	as_Log	= "Erro ao localizar a ultima data da carga diaria loja - rappi !." + " Erro: "+ SqlCa.SqlErrText
	Return False
End If 


select 	vl_parametro 
Into	 	:idt_geracao_completa
from    	parametro_loja  
where 	cd_parametro  = 'DH_ULT_CARGA_RAPPI_COMPLETA'  
and 		cd_filial  =:al_filial
Using SqlCA;

If SqlCa.SqlCode = -1 Then
	as_Log	= "Erro ao localizar a ultima data da carga completa loja - rappi !." + " Erro: "+ SqlCa.SqlErrText
	Return False
End If 


Return True 

end function

public function boolean of_atualiza_horario_atualizacao (long al_filial, ref string as_log, boolean lb_tipo);Datetime ldh_data
String lvs_datahora
ldh_data  = DateTime(Today(), Now()) 
lvs_datahora =  String  (ldh_data, "yyyy-mm-dd hh:mm:ss")

// Caso False Atualiza carga horaria
If Not lb_tipo Then 
	Update parametro_loja
	set vl_parametro =:lvs_datahora
	where cd_parametro  = 'DH_ULT_CARGA_RAPPI'
	and cd_filial  = :al_filial
	Using SqlCA;
Else // Caso Tru Atualiza carga completa
	Update  parametro_loja 
	set vl_parametro =:lvs_datahora 
	where cd_parametro  = 'DH_ULT_CARGA_RAPPI_COMPLETA' 
	and cd_filial  = :al_filial
	Using SqlCA;
End If 
			
If SqlCa.sqlcode = -1 Then
	as_Log	= "Erro na atualizacao parametro :  DH_ULT_CARGA_RAPPI ou DH_ULT_CARGA_RAPPI_COMPLETA'. Erro: "+SqlCa.sqlErrText
	Return False
Else
	SqlCa.of_Commit()
	Return True 	
End If 






end function

public function boolean of_gerar_arquivo (integer al_filial, date adt_saldo, ref string as_json, ref string as_log, ref long al_qtd_produtos, ref boolean lb_tipo_atualizacao);Boolean lb_Sucesso = True 
Boolean lb_Consulta_Completa =  False
lb_tipo_atualizacao = False

Long ll_Linhas,&
		ll_Linha,&
		ll_cd_produto
		
String ls_Log
String ls_json
String ls_Consulta

Decimal ldc_discount
Decimal ldc_price
Decimal {2} ldc_valor

Date  ldt_discount_end_at,&
		 ldt_discount_start_at
		 
Time lh_agora		 
		 
String  ls_dt_data

String lvs_store_id,&
		 lvs_id,&
		 lvs_gtin,&
		 lvs_name,&
		 lvs_description,&
		 lvs_brand,&
		 lvs_trademark,&
		 lvs_primeiro_nivel,&
		 lvs_segundo_nivel ,&
		 lvs_price,&
		 lvs_discount_price,&
		 lvs_discount,&	
		 lvs_stock,&
		 lvs_is_avaliable,&
		 lvs_is_discontined,&
		 lvs_sale_type,&
		 lvs_image_url

Try 	
	lds2  = Create dc_uo_ds_base
	SetNull(as_log)
	SetNull (lvs_Tipo_Carga)	

	// Para dados de Preco
	ivo_Produto = Create uo_Produto
		
	// Busca Datas dos Parametros para Execu$$HEX2$$e700e300$$ENDHEX$$o :  Define a Cara $$HEX1$$e900$$ENDHEX$$ Completa ou Hor$$HEX1$$e100$$ENDHEX$$ria
	If Not of_busca_data_parametro_loja (al_filial , ref as_log, ref idh_geracao , ref idh_geracao_completa ) Then 
		gvo_aplicacao.of_grava_log("Rappi - Erro ao buscar data de parametro para Carga - uo_el021_rappi.of_gera_dados_rappi")
		lb_Sucesso = True
	End If 		
			
	// Se esta no horario e data da carga $$HEX1$$e900$$ENDHEX$$ diferente da data ultima carga completa
	lh_agora 	= Time(gf_GetServerDate())
	If (lh_agora>=01:00:00 and lh_agora<=07:00:00)  Then 
			If String(Date(idh_geracao_completa), "yyyy-mm-dd") < String(Date(idh_geracao), "yyyy-mm-dd") Then    
				lb_Consulta_Completa = True			
			End If 
	End If 		
		
	If Not lds2.of_ChangeDataObject('ds_el021_lojas_rappi', False) Then 
		as_log = "Lista lojas Rappi - Erro alterar a DW [ds_el021_lojas_configuradas] - uo_el021_rappi.of_gerar_arquivo"
		gvo_aplicacao.of_grava_log(as_log)
		Return False
	End If
	
	// Executa dw com Produtos
	ll_Linhas = 0 
	If 	Not lb_Consulta_Completa Then 
				ls_Consulta = "   	b.cd_produto in ( select  distinct  a.cd_produto "+&
					    	 "     from    movimento_estoque a " +&							  
							"     	inner join tipo_movimento_estoque b on a.cd_tipo_movimento = b.cd_tipo_movimento " +&
				            "  	where   b.id_tipo_movimento ='V'  and     a.qt_movimento>0 "  +&
							"		and  		a.cd_filial_movimento = " + String(al_filial) +& 
							"      and     	a.dh_inclusao >='" +String(idh_geracao)  +"')"     						
		lds2.of_appendwhere(ls_Consulta)
		ll_Linhas = lds2.Retrieve(al_filial, adt_parametro)
		lvs_Tipo_Carga = "Parcial"
	Else
		lvs_Tipo_Carga = "Completa"
		ll_Linhas = lds2.Retrieve(al_filial, adt_parametro)				
	End If 
	
	
	If ll_Linhas	>0 Then 
		// Nula os campos
		SetNull(ls_json)
		SetNull(as_json)
				
		If Not IsValid(w_aguarde) then
			Open(w_aguarde)
		End If	
		
		w_aguarde.Title = "App Rappi:Gerando dados Para o Envio ..."
		w_aguarde.uo_progress.of_reset()
		w_aguarde.uo_progress.Of_SetMax(ll_Linhas)		
		
		ls_json = '{"records":['
		For ll_Linha = 1 To ll_Linhas
				w_aguarde.Title = "Envio App Rappi da Loja:"  + String(al_filial)  + "- Nro:" + String(ll_Linha)+" De:"+String(ll_Linhas)				

				// Campos para UO_Produto
				ivo_produto.cd_produto = lds2.Object.Cd_Produto[ll_Linha]
				ivo_produto.vl_fator_conversao = lds2.Object.vl_fator_conversao[ll_Linha]
				
				// Campos para o Json
				lvs_store_id 		= Trim(String(al_filial))
				lvs_id 				= Trim(String( lds2.Object.id[ll_Linha]))
				lvs_gtin 			= Trim(String( lds2.Object.gtin[ll_Linha]))
				lvs_name 			=  Trim(gf_Replace(gf_retira_acentos(Trim(String(lds2.Object.nome[ll_Linha]))), "~r~n", "", 0))
				lvs_description  	=  Trim (gf_Replace(gf_retira_acentos(Trim(lds2.Object.description[ll_Linha])), "~r~n", "", 0) ) 
				lvs_brand  			    =Trim(gf_Replace(gf_retira_acentos(Trim(String(lds2.Object.brand[ll_Linha]))), "~r~n", "", 0) )
				lvs_trademark 		= Trim (gf_Replace (gf_retira_acentos(Trim(String(lds2.Object.trademark[ll_Linha]))), "~r~n", "", 0) )
				lvs_primeiro_nivel	=  Trim(gf_Replace (gf_retira_acentos(Trim(String(lds2.Object.primeiro_nivel[ll_Linha]))), "~r~n", "", 0) )
				lvs_segundo_nivel	=  Trim (gf_Replace (gf_retira_acentos(Trim(String(lds2.Object.segundo_nivel[ll_Linha]))), "~r~n", "", 0))
				lvs_stock 				= Trim(String(lds2.Object.stock [ll_Linha]))
				lvs_is_avaliable 		= Trim(String( lds2.Object.is_avaliable[ll_Linha]))
				lvs_is_discontined 	=	Trim(String( lds2.Object.is_discontined[ll_Linha]))
				lvs_sale_type			=	Trim(String(lds2.Object.sale_type [ll_Linha]))  
				lvs_image_url			=""
				// Para Pre$$HEX1$$e700$$ENDHEX$$os e Descontos
				ldc_price				= ivo_Produto.Of_Preco_Venda_Filial_Matriz(al_filial) 
				ldc_discount			= ivo_Produto.Of_Desconto_Filial(al_filial)
				lvs_price 				= Trim (gf_replace(String (ldc_price), ",", "." ,0 ))
				lvs_discount			= gf_replace(String(ldc_discount), "," , "." ,0 ) 
				
				// Faz calculo Preco com Desconto
				If ldc_discount >0 Then 
					ldc_valor = (ldc_price  -  (ldc_price * (ldc_discount/100)))
					lvs_discount_price 		= Trim(gf_replace(String(ldc_valor), "," ,  ".", 0))     				
					lvs_price = lvs_discount_price
				Else
					lvs_discount_price			= Trim(gf_replace(String(ldc_price) , "," ,  ".", 0))      
					lvs_price = lvs_discount_price
				End If 
				
				
				// Monta o Json do Item
				ls_json +="{"
				ls_json += '"store_id"'+":" +'"' +String(lvs_store_id)+'"'+   ","+&
					 '"id"'+":"+'"'+lvs_id+'"'+","+&				
					 '"gtin"'+":" +'"'+lvs_gtin+'"'+","+&
					 '"name"'+":" +'"'+lvs_name+ '"'+","+&				 
					 '"description"'+":" +'"'+lvs_description+'"' +","+&
					 '"brand"'+":" + '"' +   +lvs_brand+  '"' +","+&
					 '"trademark"'+":" +  '"'  +lvs_trademark+ '"'+","+&
					 '"category_first_level"' + ":" + '"'   +lvs_primeiro_nivel + '"' +"," + &
					 '"category_second_level"'+":"  + '"'  +lvs_segundo_nivel  + '"'  +"," + &
					 '"price"'+":"+lvs_price +"," +& 
					 '"discount_price"'+":"+"0.00"+","+&
					 '"discount"'+":"+lvs_discount+","+&
					 '"discount_start_at"'+":"+   '"'  +  String(ldt_discount_start_at)+ '"' +   ","+&
					 '"discount_end_at"'+":"+   '"' +   String(ldt_discount_end_at)+ '"' +    ","+&
					 '"stock"'+":"+lvs_stock+","+&
					 '"is_available"'+":"+ lvs_is_avaliable +","+&
					 '"is_discontined"'+":"+lvs_is_discontined+","+&
					 '"sale_type"'+":" + '"'  +lvs_sale_type+  '"'
					
					If ll_linha < ll_Linhas	Then
						ls_Json	+='},'
					Else
						ls_Json	+='}'
					End If
															
					w_aguarde.uo_progress.Of_SetProgress(ll_Linha)					
		Next
		
		// Retirar caracteres diferentes
		If Not of_retira_caracteres (  ls_Json , ref ls_Log)  Then 
		   lb_Sucesso = False
		   as_log = "Lojas Rappi - Erro ao retirar caracteres  - uo_el021_rappi.of_gerar_arquivo"
		   gvo_aplicacao.of_grava_log(as_log)			
		End If 
				
		// Finaliza Json
		ls_Json	+= ']}'
		as_json = ls_Json
		
		// Valida: N$$HEX1$$e300$$ENDHEX$$o pode ser vazio
		If IsNull(as_json) Then 
			lb_Sucesso = False
			as_log = "Lojas Rappi - Erro ao gerar arquivo Json Arquivo Vazio  - uo_el021_rappi.of_gerar_arquivo"
			gvo_aplicacao.of_grava_log(as_log)			
		End If 		
		
	ElseIf ll_Linhas < 0 Then
		as_log = "Lojas Rappi - Erro ao gerar arquivo Json da DW [ds_el021_lojas_rappi]  - uo_el021_rappi.of_gerar_arquivo"
		gvo_aplicacao.of_grava_log(as_log)
	End If		
	
Catch ( runtimeerror  lo_rte )
	lb_Sucesso = False	
	as_log = "Lojas Rappi - Erro ao gerar arquivo Json uo_el021_rappi.of_gerar_arquivo"
	gvo_aplicacao.of_grava_log(as_log)
Finally		
	
	If lb_Sucesso Then		
		al_qtd_produtos = ll_Linhas
		lb_tipo_atualizacao = lb_Consulta_Completa  
		If IsValid(w_aguarde) then Close(w_aguarde)
	Else		
		al_qtd_produtos = 0
		lb_Sucesso = False		
	End If		
	
	Destroy (lds2)
	Destroy(ivo_Produto)
End Try

Return lb_Sucesso
end function

on uo_el021_rappi.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_el021_rappi.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;
//is_Login_Prod			= "XXXXXX"
//is_Senha_Prod			= "XXXXXXX"




end event

