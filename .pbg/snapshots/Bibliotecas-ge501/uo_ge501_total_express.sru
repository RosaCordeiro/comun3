HA$PBExportHeader$uo_ge501_total_express.sru
forward
global type uo_ge501_total_express from nonvisualobject
end type
end forward

global type uo_ge501_total_express from nonvisualobject
end type
global uo_ge501_total_express uo_ge501_total_express

type variables
String	is_Usuario,&
		is_Senha	

Integer ivi_LOG		
		
String is_Pedido_Ecommerce
String is_reid
String is_url
string is_id_tipo_servico
string is_credenciais_acesso

Long il_tipo_servico

dc_uo_transacao itr_Filial
end variables

forward prototypes
private function boolean of_processa_retorno (string as_xml_retorno, ref string as_erro)
private function boolean of_grava_retorno_rastreamento (string as_xml, ref string as_erro)
private function boolean of_processa_erros_individuais (string as_xml, ref string as_erro)
private function boolean of_envia_webservice (string as_xml_envio, ref string as_xml_retorno, ref string as_erro)
private function boolean of_muda_situacao_pedido_ecommerce (long al_filial_ecommerce, string as_pedido_ecommerce, ref string as_erro)
private function boolean of_insere_rastreamento (long al_filial_ecommerce, string as_pedido_ecommerce, long al_cod_status, string as_desc_status, datetime adh_data_status, ref string as_erro)
public function boolean of_registra_coleta_e_total (long al_filial_ecommerce, string as_pedido_ecommerce, boolean ab_producao, dc_uo_transacao atr_filial, ref string as_erro, string as_rede_filial, long al_filial_pedido)
private function boolean of_ambiente (boolean ab_producao, ref string as_erro, long al_filial_pedido)
public function boolean of_carrega_parametros (long pl_cd_filial, boolean pb_producao, ref string ps_log)
private function boolean of_monta_xml (string as_pedido_ecommerce, ref string as_xml, ref string as_erro, string as_rede_filial)
public function boolean of_encode_credencial (ref string ps_log)
public function boolean of_grava_rastreio (string ps_xml, dc_uo_ds_base pds_rastreio, ref string ps_log)
public function boolean of_processa_retorno_rastreamento (string ps_xml, ref dc_uo_ds_base pds_rastreio, ref string ps_log)
public function boolean of_rastrear_pedido (long pl_cd_filial, date pdh_consulta, boolean pb_producao, ref dc_uo_ds_base pds_rastreio, ref string ps_log)
end prototypes

private function boolean of_processa_retorno (string as_xml_retorno, ref string as_erro);String	ls_Codigo_proc

Long	ll_Pos_1,&
		ll_Pos_2,&
		ll_Length

String	ls_Parte_Xml

Try
				
	ll_Pos_1	= Pos(as_xml_retorno, '<CodigoProc xsi:type="xsd:nonNegativeInteger">')
	ll_Pos_2	= Pos(as_xml_retorno, '</CodigoProc>')
	ll_Length	= Len('<CodigoProc xsi:type="xsd:nonNegativeInteger">')
	
	ls_Codigo_proc	= Mid(as_xml_retorno, ll_Pos_1 + ll_Length, ll_Pos_2 - (ll_Pos_1 + ll_Length))
	
	Choose Case ls_Codigo_proc
		Case "0"
			as_Erro	= "Retorno do WebService: 0 - Cliente n$$HEX1$$e300$$ENDHEX$$o autorizado a realizar o procedimento."
			Return False
		Case "1"
			
		Case "2"
			as_Erro	= "Retorno do WebService: 2 - Sistema indispon$$HEX1$$ed00$$ENDHEX$$vel no momento. (O cliente dever$$HEX1$$e100$$ENDHEX$$ realizar a transmiss$$HEX1$$e300$$ENDHEX$$o novamente mais tarde)."
			Return False
		Case "3"
			as_Erro	= "Retorno do WebService: 3 - Erro na valida$$HEX2$$e700e300$$ENDHEX$$o XSD. (O cliente dever$$HEX1$$e100$$ENDHEX$$ verificar a estrutura do conte$$HEX1$$fa00$$ENDHEX$$do enviado)."
			Return False
		Case "4"
			as_Erro	= "Retorno do WebService: 3 - Erro sist$$HEX1$$ea00$$ENDHEX$$mico por parte da TOTAL EXPRESS. (O cliente dever$$HEX1$$e100$$ENDHEX$$ realizar a transmiss$$HEX1$$e300$$ENDHEX$$o novamente mais tarde)."
			Return False
		Case "5"
			ll_Pos_1	= Pos(as_xml_retorno, '<ErrosIndividuais xsi:type="SOAP-ENC:Array"')
			ll_Pos_2	= Pos(as_xml_retorno, '</ErrosIndividuais>')
			ll_Length	= Len('</ErrosIndividuais>')
			
			ls_Parte_Xml	= Mid(as_xml_retorno, ll_Pos_1, (ll_Pos_2 + ll_Length) - ll_Pos_1)
			
			Return of_Processa_Erros_Individuais(ls_Parte_Xml, Ref as_Erro)
		Case Else
			as_Erro	= "Retorno n$$HEX1$$e300$$ENDHEX$$o esperado do WebService da TOTAL EXPRESS."
			Return False
	End Choose
	
Catch ( runtimeerror  lo_rte )
	as_Erro = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o of_processa_retorno, objeto uo_ge501_total_express. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try

Return True
end function

private function boolean of_grava_retorno_rastreamento (string as_xml, ref string as_erro);String	ls_Serie,&
		ls_Desc_Status,&
		ls_Data_Status,&
		ls_Ect_Tipo,&
		ls_Ect_Hora,&
		ls_Xml_Lote_Retorno,&
		ls_Xml_Lote_Retorno_Bkp,&
		ls_Xml_Encomenda_Retorno,&
		ls_Xml_Encomenda_Retorno_Bkp,&
		ls_Xml_Status_Total,&
		ls_Xml_Item_Encomenda_Retorno,&
		ls_Xml_Item_Encomenda_Retorno_Bkp

Long	ll_Pos_1,&
		ll_Pos_2,&
		ll_Lenght,&
		ll_Pedido_Ecommerce,&
		ll_Nota_Fiscal,&
		ll_Awb,&
		ll_Cod_Status, &
		ll_Ect_Status,&
		ll_Loop

Long ll_Filial_Ecommerce, ll_Lenght_Final_tag

String ls_Aux_Pedido
String ls_Xml_Status_Item
String ls_Xml_Status_Total_bkp

DateTime	ldh_Data_Status		
		
Try	
	ll_Loop = 0
	
	DO WHILE Pos(as_Xml, '<item xsi:type="tns:LoteRetorno">') > 0
		ll_Pos_1	= Pos(as_Xml, '<item xsi:type="tns:LoteRetorno">')
		ll_Pos_2	= Pos(as_Xml, '</ArrayEncomendaRetorno></item>')
		ll_Lenght	= Len( '</ArrayEncomendaRetorno></item>')
		
		ls_Xml_Lote_Retorno	= Mid(as_Xml, ll_Pos_1, (ll_Pos_2 + ll_Lenght) - ll_Pos_1)
		
		ls_Xml_Lote_Retorno_Bkp = ls_Xml_Lote_Retorno
		
		DO WHILE Pos(ls_Xml_Lote_Retorno, '<ArrayEncomendaRetorno xsi:type="SOAP-ENC:Array"') > 0
			ll_Pos_1	= Pos(ls_Xml_Lote_Retorno, '<ArrayEncomendaRetorno xsi:type="SOAP-ENC:Array"')
			ll_Pos_2	= Pos(ls_Xml_Lote_Retorno, '</ArrayEncomendaRetorno>')
			ll_Lenght	= Len( '</ArrayEncomendaRetorno>')
		
			ls_Xml_Encomenda_Retorno	= Mid(ls_Xml_Lote_Retorno, ll_Pos_1, (ll_Pos_2 + ll_Lenght) - ll_Pos_1)
			
			ls_Xml_Encomenda_Retorno_Bkp = ls_Xml_Encomenda_Retorno
			
			DO WHILE Pos(ls_Xml_Encomenda_Retorno, '<item xsi:type="tns:EncomendaRetorno">') > 0
				ll_Pos_1	= Pos(ls_Xml_Encomenda_Retorno, '<item xsi:type="tns:EncomendaRetorno">')
				ll_Pos_2	= Pos(ls_Xml_Encomenda_Retorno, '</ArrayStatusTotal></item>')
				ll_Lenght	= Len( '</ArrayStatusTotal></item>')
				
				If ll_Pos_2 = 0 Then
					ll_Pos_2	= Pos(ls_Xml_Encomenda_Retorno, '</ArrayStatusEct></item>')
					ll_Lenght	= Len('</ArrayStatusEct></item>')
				End If
			
				ls_Xml_Item_Encomenda_Retorno	= Mid(ls_Xml_Encomenda_Retorno, ll_Pos_1, (ll_Pos_2 + ll_Lenght) - ll_Pos_1)
				
				ls_Xml_Item_Encomenda_Retorno_Bkp = ls_Xml_Item_Encomenda_Retorno
				
				//AWB
				ll_Pos_1	= Pos(ls_Xml_Item_Encomenda_Retorno, '<Awb xsi:type="xsd:nonNegativeInteger">')
				ll_Pos_2	= Pos(ls_Xml_Item_Encomenda_Retorno, '</Awb>')
				ll_Lenght	= Len( '<Awb xsi:type="xsd:nonNegativeInteger">')
				
				ll_Awb	= Long(Mid(ls_Xml_Item_Encomenda_Retorno, ll_Pos_1 + ll_Lenght , ll_Pos_2 - (ll_Pos_1+ ll_Lenght)))
				
				//Pedido
				ll_Pos_1	= Pos(ls_Xml_Item_Encomenda_Retorno, '<Pedido xsi:type="xsd:string">')
				ll_Pos_2	= Pos(ls_Xml_Item_Encomenda_Retorno, '</Pedido>')
				ll_Lenght	= Len('<Pedido xsi:type="xsd:string">')
				
				//ls_Aux_Pedido	= Mid(ls_Xml_Item_Encomenda_Retorno, ll_Pos_1 + ll_Lenght , ll_Pos_2 - (ll_Pos_1+ ll_Lenght))				
				ls_Aux_Pedido	= Mid(ls_Xml_Item_Encomenda_Retorno, ll_Pos_1 + ll_Lenght , ll_Pos_2 - (ll_Pos_1+ ll_Lenght))					
									
				Choose Case Mid(ls_Aux_Pedido, 1,1)
					Case '1', '4'; ll_Filial_Ecommerce 	= 809
					Case '2'; ll_Filial_Ecommerce 		= 986
					Case '3'; ll_Filial_Ecommerce 		= 355
				End Choose
						
				ll_Pedido_Ecommerce 	= Long( ls_Aux_Pedido )		
				
				//NotaFiscal
				ll_Pos_1	= Pos(ls_Xml_Item_Encomenda_Retorno, '<NotaFiscal xsi:type="xsd:nonNegativeInteger">')
				ll_Pos_2	= Pos(ls_Xml_Item_Encomenda_Retorno, '</NotaFiscal>')
				ll_Lenght	= Len('<NotaFiscal xsi:type="xsd:nonNegativeInteger">')
				
				ll_Nota_Fiscal	= Long(Mid(ls_Xml_Item_Encomenda_Retorno, ll_Pos_1 + ll_Lenght , ll_Pos_2 - (ll_Pos_1+ ll_Lenght)))
				
				//NotaFiscalSerie
				ll_Pos_1	= Pos(ls_Xml_Item_Encomenda_Retorno, '<SerieNotaFiscal xsi:type="xsd:string">')
				ll_Pos_2	= Pos(ls_Xml_Item_Encomenda_Retorno, '</SerieNotaFiscal>')
				ll_Lenght	= Len('<SerieNotaFiscal xsi:type="xsd:string">')
				
				ls_Serie	= Mid(ls_Xml_Item_Encomenda_Retorno, ll_Pos_1 + ll_Lenght , ll_Pos_2 - (ll_Pos_1+ ll_Lenght))
				
				//Localiza os status da TOTAL EXPRESS
				DO WHILE Pos(ls_Xml_Item_Encomenda_Retorno, '<ArrayStatusTotal xsi:type="SOAP-ENC:Array"') > 0
					ll_Pos_1	= Pos(ls_Xml_Item_Encomenda_Retorno, '<ArrayStatusTotal xsi:type="SOAP-ENC:Array"')
					ll_Pos_2	= Pos(ls_Xml_Item_Encomenda_Retorno, '</ArrayStatusTotal>')
					ll_Lenght_Final_tag	= Len( '</ArrayStatusTotal>')
					
					ls_Xml_Status_Total			= Mid(ls_Xml_Item_Encomenda_Retorno, ll_Pos_1, (ll_Pos_2 + ll_Lenght_Final_tag) - ll_Pos_1)
					ls_Xml_Status_Total_bkp 	= ls_Xml_Status_Total 
					
					//Localiza os status da TOTAL EXPRESS ( Itens )
					DO WHILE Pos( ls_Xml_Status_Total, '<item xsi:type="tns:StatusTotal"' ) > 0
						ll_Pos_1	= Pos( ls_Xml_Status_Total, '<item xsi:type="tns:StatusTotal"' )
						ll_Pos_2	= Pos( ls_Xml_Status_Total, '</item>' )
						ll_Lenght	= Len( '</item>' )
						
						ls_Xml_Status_Item	= Mid( ls_Xml_Status_Total, ll_Pos_1, ( ll_Pos_2 - ll_Pos_1 ) + ll_Lenght )
												
						//CodStatus
						ll_Pos_1	= Pos(ls_Xml_Status_Item, '<CodStatus xsi:type="xsd:nonNegativeInteger">')
						ll_Pos_2	= Pos(ls_Xml_Status_Item, '</CodStatus>')
						ll_Lenght	= Len( '<CodStatus xsi:type="xsd:nonNegativeInteger">')
						
						ll_Cod_Status	= Long(Mid(ls_Xml_Status_Item, ll_Pos_1 + ll_Lenght , ll_Pos_2 - (ll_Pos_1+ ll_Lenght)))
						
						//DescStatus
						ll_Pos_1	= Pos(ls_Xml_Status_Item, '<DescStatus xsi:type="xsd:string">')
						ll_Pos_2	= Pos(ls_Xml_Status_Item, '</DescStatus>')
						ll_Lenght	= Len( '<DescStatus xsi:type="xsd:string">')
						
						ls_Desc_Status	= Mid(ls_Xml_Status_Item, ll_Pos_1 + ll_Lenght , ll_Pos_2 - (ll_Pos_1+ ll_Lenght))
						
						//DataStatus
						ll_Pos_1	= Pos(ls_Xml_Status_Item, '<DataStatus xsi:type="xsd:dateTime">')
						ll_Pos_2	= Pos(ls_Xml_Status_Item, '</DataStatus>')
						ll_Lenght	= Len( '<DataStatus xsi:type="xsd:dateTime">')
						
						ls_Data_Status	= Mid(ls_Xml_Status_Item, ll_Pos_1 + ll_Lenght , ll_Pos_2 - (ll_Pos_1+ ll_Lenght))
						
						ldh_Data_Status = DateTime(Mid(ls_Data_Status, 9, 2)+"/"+Mid(ls_Data_Status, 6, 2)+"/"+Mid(ls_Data_Status, 1, 4)+" "+Mid(ls_Data_Status, 12, 8))
						
						//Limpa a parte j$$HEX1$$e100$$ENDHEX$$ lida		
						ls_Xml_Status_Total = gf_Replace(ls_Xml_Status_Total, ls_Xml_Status_Item , '', 0)
						
//						If Not This.of_Insere_Rastreamento(	ll_Filial_Ecommerce,&
//																		ll_Pedido_Ecommerce,&
//																		ll_Cod_Status,&
//																		ls_Desc_Status,&
//																		ldh_Data_Status,&
//																		Ref as_Erro)	Then
//							Return False
//						End If
						
						ll_Loop++
					LOOP
					
					ls_Xml_Item_Encomenda_Retorno = gf_Replace(ls_Xml_Item_Encomenda_Retorno, ls_Xml_Status_Total_bkp, '', 0)
				LOOP
				
				//Localiza os status da ECT (Correios)
				DO WHILE Pos(ls_Xml_Item_Encomenda_Retorno, '<ArrayStatusEct xsi:type="SOAP-ENC:Array"') > 0
					ll_Pos_1	= Pos(ls_Xml_Item_Encomenda_Retorno, '<ArrayStatusEct xsi:type="SOAP-ENC:Array"')
					ll_Pos_2	= Pos(ls_Xml_Item_Encomenda_Retorno, '</ArrayStatusEct>')
					ll_Lenght	= Len( '</ArrayStatusEct>')
					
					ls_Xml_Status_Total	= Mid(ls_Xml_Item_Encomenda_Retorno, ll_Pos_1, (ll_Pos_2 + ll_Lenght) - ll_Pos_1)
					
					//EctTipo
					ll_Pos_1	= Pos(ls_Xml_Status_Total, '<EctTipo xsi:type="xsd:string">')
					ll_Pos_2	= Pos(ls_Xml_Status_Total, '</EctTipo>')
					ll_Lenght	= Len( '<EctTipo xsi:type="xsd:string">')
					
					ls_Ect_Tipo	= Mid(ls_Xml_Status_Total, ll_Pos_1 + ll_Lenght , ll_Pos_2 - (ll_Pos_1+ ll_Lenght))
					
					//EctStatus
					ll_Pos_1	= Pos(ls_Xml_Status_Total, '<EctStatus xsi:type="xsd:string">')
					ll_Pos_2	= Pos(ls_Xml_Status_Total, '</EctStatus>')
					ll_Lenght	= Len( '<EctStatus xsi:type="xsd:string">')
					
					ll_Ect_Status	= Long(Mid(ls_Xml_Status_Total, ll_Pos_1 + ll_Lenght , ll_Pos_2 - (ll_Pos_1+ ll_Lenght)))
					
					//EctData
					ll_Pos_1	= Pos(ls_Xml_Status_Total, '<EctData xsi:type="xsd:date">')
					ll_Pos_2	= Pos(ls_Xml_Status_Total, '</EctData>')
					ll_Lenght	= Len( '<EctData xsi:type="xsd:date">')
					
					ls_Data_Status	= Mid(ls_Xml_Status_Total, ll_Pos_1 + ll_Lenght , ll_Pos_2 - (ll_Pos_1+ ll_Lenght))
					
					//ls_Ect_Hora
					ll_Pos_1	= Pos(ls_Xml_Status_Total, '<EctHora xsi:type="xsd:time">')
					ll_Pos_2	= Pos(ls_Xml_Status_Total, '</EctHora>')
					ll_Lenght	= Len( '<EctHora xsi:type="xsd:time">')
					
					ls_Ect_Hora	= Mid(ls_Xml_Status_Total, ll_Pos_1 + ll_Lenght , ll_Pos_2 - (ll_Pos_1+ ll_Lenght))
					
					ldh_Data_Status = DateTime(Mid(ls_Data_Status, 9, 2)+"/"+Mid(ls_Data_Status, 6, 2)+"/"+Mid(ls_Data_Status, 1, 4) + " "+ls_Ect_Hora)
					
					If ((ls_Ect_Tipo = "BDE") and (ll_Ect_Status = 1)) or ((ls_Ect_Tipo = "BDI") and (ll_Ect_Status = 1)) or ((ls_Ect_Tipo = "BDR") and (ll_Ect_Status = 1)) Then
						
//						If Not This.of_Insere_Rastreamento(	ll_Filial_Ecommerce,&
//																		ll_Pedido_Ecommerce,&
//																		1,&
//																		"ENTREGA REALIZADA - CORREIOS",&
//																		ldh_Data_Status,&
//																		Ref as_Erro)	Then
//							Return False
//						End If
						
					End If
					
					//Limpa a parte j$$HEX1$$e100$$ENDHEX$$ lida		
					ls_Xml_Item_Encomenda_Retorno = gf_Replace(ls_Xml_Item_Encomenda_Retorno, ls_Xml_Status_Total, '', 0)
					
				LOOP
				
				//Limpa a parte j$$HEX1$$e100$$ENDHEX$$ lida		
				ls_Xml_Encomenda_Retorno = gf_Replace(ls_Xml_Encomenda_Retorno, ls_Xml_Item_Encomenda_Retorno_Bkp, '', 0)
			LOOP
			
			//Limpa a parte j$$HEX1$$e100$$ENDHEX$$ lida		
			ls_Xml_Lote_Retorno = gf_Replace(ls_Xml_Lote_Retorno, ls_Xml_Encomenda_Retorno_Bkp, '', 0)
				
		LOOP
		as_Xml = gf_Replace(as_Xml, ls_Xml_Lote_Retorno_Bkp, '', 0)
		
	LOOP
	
Catch ( runtimeerror  lo_rte )
	as_Erro = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o of_grava_retorno_rastrear_pedido, objeto uo_ge501_total_express. Erro: "+lo_rte.GetMessage()
	Return False
End Try	

Return True
end function

private function boolean of_processa_erros_individuais (string as_xml, ref string as_erro);Boolean lb_Retorno = False, lb_ignorar_erro = false

String	ls_Xml_Aux,&
		ls_Codigo_Erro,&
		ls_Descricao_Erro

Long	ll_Pos_1,&
		ll_Pos_2,&
		ll_Lenght
		
Try
	as_Erro = ""
	
	DO WHILE Pos(as_Xml, '<item xsi:type="tns:CriticaVolume">') > 0
		ll_Pos_1	= Pos(as_Xml, '<item xsi:type="tns:CriticaVolume">')
		ll_Pos_2	= Pos(as_Xml, '</item>')
		ll_Lenght	= Len( '</item>')
		
		ls_Xml_Aux	= Mid(as_Xml, ll_Pos_1, (ll_Pos_2 + ll_Lenght) - ll_Pos_1)
		
		ll_Pos_1	= Pos(ls_Xml_Aux, '<CodigoErro xsi:type="xsd:nonNegativeInteger">')
		ll_Pos_2	= Pos(ls_Xml_Aux, '</CodigoErro>')
		ll_Lenght	= Len( '<CodigoErro xsi:type="xsd:nonNegativeInteger">')
		
		ls_Codigo_Erro	= Mid(ls_Xml_Aux, ll_Pos_1 + ll_Lenght , ll_Pos_2 - (ll_Pos_1+ ll_Lenght))
		
		lb_ignorar_erro = false
		
		Choose Case ls_Codigo_Erro
			Case "1"
				ls_Descricao_Erro = "1 - Tipo de servi$$HEX1$$e700$$ENDHEX$$ao n$$HEX1$$e300$$ENDHEX$$o contratado."
				
			Case "2" //Erro nos dados enviados
				ll_Pos_1	= Pos(ls_Xml_Aux, '<DescricaoErro xsi:type="xsd:string">')
				ll_Pos_2	= Pos(ls_Xml_Aux, '</DescricaoErro>')
				ll_Lenght	= Len( '<DescricaoErro xsi:type="xsd:string">')
				
				ls_Descricao_Erro	= Mid(ls_Xml_Aux, ll_Pos_1 + ll_Lenght , ll_Pos_2 - (ll_Pos_1+ ll_Lenght))
				
			Case "3"
				//Nesse caso a interface deve continuar
				lb_ignorar_erro = true
				
				//ls_Descricao_Erro	= "3 - Volume duplicado."
				//lb_Retorno = True
				
			Case "4"
				ls_Descricao_Erro = "4 - Erro sist$$HEX1$$ea00$$ENDHEX$$mico por parte da Total Express ao processar volume."
				
			Case Else
				ls_Descricao_Erro	= "Erro desconhecido."
		End Choose
		
		if lb_ignorar_erro = false then
			If as_Erro = "" Then
				as_Erro = ls_Codigo_Erro + " - "+ls_Descricao_Erro
			Else
				as_Erro += "~n" + ls_Codigo_Erro + " - "+ls_Descricao_Erro
			End If
		end if
		
		as_Xml = gf_Replace(as_Xml, ls_Xml_Aux, '', 0)	//Limpa a parte j$$HEX1$$e100$$ENDHEX$$ lida
	
	LOOP
	
Catch ( runtimeerror  lo_rte )
	as_Erro = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o of_processa_erros_individuais, objeto uo_ge501_total_express. Erro: "+lo_rte.GetMessage()
	Return False				 
End Try	

Return lb_Retorno
end function

private function boolean of_envia_webservice (string as_xml_envio, ref string as_xml_retorno, ref string as_erro);String		ls_Status_Text

long   ll_Status_Code

OleObject lo_Xml_Http

Try
	Try		
		as_XMl_Envio = gf_Replace( as_xml_Envio, "&", "e",  0)		
		
		lo_Xml_Http = CREATE oleobject		
		lo_Xml_Http.ConnectToNewObject("MSXML2.SERVERXMLHTTP.6.0")

		lo_Xml_Http.open ("POST", is_url, False, is_Usuario, is_Senha)
		
		lo_Xml_Http.setRequestHeader("Content-Type", "text/xml") 
		
		//Somente se for conex$$HEX1$$e300$$ENDHEX$$o segura https:
		if pos(Upper(is_url), 'HTTPS:') > 0 Then
			If Not this.of_encode_credencial( ref as_erro ) then return false
			lo_Xml_Http.setRequestHeader("Authorization", 'basic ' + is_credenciais_acesso)
			lo_Xml_Http.setOption(2,'13056') 
		end if
		
		lo_Xml_Http.send(as_Xml_Envio)	
		
		//Pega a resposta do web service
		ls_Status_Text = lo_Xml_Http.StatusText
		ll_Status_Code = lo_Xml_Http.Status
		
		If ll_Status_Code >= 300 Or ll_Status_Code = 0 Then
			as_Erro = "Erro no retorno do Web Service. C$$HEX1$$f300$$ENDHEX$$digo do erro: " +String(ll_Status_Code)+ " Descri$$HEX2$$e700e300$$ENDHEX$$o do erro: " + ls_Status_Text
			Return False
		Else
		//Pega o retorno do web service
			as_Xml_Retorno = String(lo_Xml_Http.ResponseText)
		End If
	Finally
		//Disconecta
		lo_Xml_Http.DisconnectObject()
		
		Destroy(lo_Xml_Http)
	End Try

Catch (RuntimeError lo_rte)
	as_Erro = "PEDIDO: " + This.is_pedido_ecommerce + " | Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o of_envia_webservice, objeto uo_ge501_total_express. Erro: "+lo_rte.GetMessage()
	Return False
Finally
	FileClose( This.ivi_LOG )
End Try

Return True
end function

private function boolean of_muda_situacao_pedido_ecommerce (long al_filial_ecommerce, string as_pedido_ecommerce, ref string as_erro);Try
	Update pedido_ecommerce
	Set id_situacao = 'C' //Comunicado a Transportadora
	Where	cd_filial_ecommerce 	= :al_filial_ecommerce
		and 	nr_pedido_ecommerce = :as_Pedido_Ecommerce
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		as_Erro = "Erro no update da tabela 'pedido_ecommerce', coluna 'id_situacao': "+SqlCa.SqlErrText
		Return False
	End If
	
	If SqlCa.SqlnRows <> 1 Then
		as_Erro = "Problema ao atualizar a situa$$HEX2$$e700e300$$ENDHEX$$o do Pedido Ecommerce. Deveria ter atualizado 1 linha mas atualizou "+String(SqlCa.SqlnRows)+" linhas."
		Return False
	End If
	
//	If Not This.of_Insere_Rastreamento( al_filial_ecommerce, al_pedido_ecommerce, 0, 'ARQUIVO RECEBIDO', gf_GetServerDate(), Ref as_Erro ) Then
//		Return False
//	End If
	
Catch (RuntimeError lo_rte)
	as_Erro = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o of_muda_situacao_pedido_ecommerce, objeto uo_ge501_total_express. Erro: "+lo_rte.GetMessage( )
	Return False
End Try	

Return True
end function

private function boolean of_insere_rastreamento (long al_filial_ecommerce, string as_pedido_ecommerce, long al_cod_status, string as_desc_status, datetime adh_data_status, ref string as_erro);//Long	ll_Sequencial,&
//		ll_Qtde
//
//Try
//	
//	//Verifica se j$$HEX1$$e100$$ENDHEX$$ existe o rastreamento
//	select count(*)
//	Into :ll_Qtde
//	from total_express_rastreamento
//	where cd_filial_ecommerce		= :al_filial_ecommerce
//		and nr_pedido_ecommerce	= :al_Pedido_Ecommerce
//		and cd_status					= :al_Cod_Status
//	Using SqlCa;
//	
//	If SqlCa.SqlCode = -1 Then
//		as_Erro = "Erro no select que verifica se j$$HEX1$$e100$$ENDHEX$$ tem o rastreamento cadastrado: "+SqlCa.SqlErrText
//		SqlCa.of_RollBack( )
//		Return False
//	End If
//	
//	If ll_Qtde = 0 Then
//	
//		//Localiza o sequencial
//		Select coalesce(max(nr_sequencial), 0) + 1
//		Into :ll_Sequencial
//		From total_express_rastreamento
//		Where	cd_filial_ecommerce		= :al_filial_ecommerce
//			and	nr_pedido_ecommerce	= :al_Pedido_Ecommerce
//		Using SqlCa;
//		
//		Choose Case SqlCa.SqlCode
//			Case 0
//				
//			Case 100
//				as_Erro = "N$$HEX1$$e300$$ENDHEX$$o foi localizado o pr$$HEX1$$f300$$ENDHEX$$ximo sequencial da tabela 'total_express_rastreamento': "+SqlCa.SqlErrText
//				SqlCa.of_RollBack( )
//				Return False
//			Case -1
//				as_Erro = "Erro no select que localiza o pr$$HEX1$$f300$$ENDHEX$$ximo sequencial da tabela 'total_express_rastreamento': "+SqlCa.SqlErrText
//				SqlCa.of_RollBack( )
//				Return False
//		End Choose
//		
//		//Insere o rastreamento
//		Insert Into total_express_rastreamento(	cd_filial_ecommerce,
//															nr_pedido_ecommerce,
//															nr_sequencial,
//															cd_status,
//															dh_status,
//															de_status_descricao)
//		Values(	:al_filial_ecommerce,
//					:al_Pedido_Ecommerce,
//					:ll_Sequencial,
//					:al_Cod_Status,
//					:adh_Data_Status,
//					:as_Desc_Status)
//		Using SqlCa;
//		
//		If SqlCa.SqlCode = -1 Then
//			as_Erro = "PEDIDO: " + String(al_Pedido_Ecommerce) + " | Ststus: " + String( al_Cod_Status ) + " | Erro no insert da tabela 'total_express_rastreamento': "+SqlCa.SqlErrText
//			SqlCa.of_RollBack( )
//			Return False
//		End If
//		
//		If SqlCa.SqlnRows <> 1 Then
//			as_Erro = "Problema ao inserir um novo rastreamento na tabela 'total_express_rastreamento'. Deveria ter inserido 1 linha mas inseriu "+String(SqlCa.SqlnRows)+" linhas."
//			SqlCa.of_RollBack( )
//			Return False
//		End If
//		
//		Choose Case al_Cod_Status
//			Case 0,1,83,84
//				UPDATE total_express_rastreamento
//				SET dh_atualizacao_ecommerce = NULL
//				WHERE cd_filial_ecommerce	= :al_filial_ecommerce
//				AND nr_pedido_ecommerce		= :al_Pedido_Ecommerce
//				AND cd_status						= :al_Cod_Status
//				USING SQLCA;
//				
//				Choose Case SqlCa.SqlCode
//					Case -1
//						as_Erro = " Atualiza$$HEX2$$e700e300$$ENDHEX$$o do status do total_express_rastreamentodh_atualizacao_ecommerce. " + SqlCa.SqlErrText + " | of_insere_rastreamento"
//						SqlCa.of_RollBack( )
//						
//					Case Else
//						SqlCa.of_Commit( )
//				End Choose
//		End Choose
//
//	End If
//	
//Catch ( runtimeerror  lo_rte )
//	as_Erro = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o of_insere_rastreamento, objeto uo_ge501_total_express. Erro: "+lo_rte.GetMessage()
//	SqlCa.of_RollBack( )
//	Return False
//End Try

Return True
end function

public function boolean of_registra_coleta_e_total (long al_filial_ecommerce, string as_pedido_ecommerce, boolean ab_producao, dc_uo_transacao atr_filial, ref string as_erro, string as_rede_filial, long al_filial_pedido);Boolean	lb_Sucesso = False

String		ls_Xml_Envio,&
			ls_Xml_Retorno
Try
	
	itr_filial = atr_filial
	
	This.is_Pedido_Ecommerce 	= as_pedido_ecommerce
	
	If Not of_carrega_parametros(al_filial_pedido, ab_producao, ref as_Erro) Then
		Return False
	End If
	
	as_Erro = ""
	
	If This.of_Monta_Xml(as_Pedido_Ecommerce, Ref ls_Xml_Envio, Ref as_Erro, as_rede_filial) Then
		If This.of_envia_WebService( ls_Xml_Envio, Ref ls_Xml_Retorno, Ref as_Erro) Then
			If This.of_Processa_Retorno(ls_Xml_Retorno, Ref as_Erro) Then
					lb_Sucesso = True
			End If
		End If
	End If

Catch (RuntimeError lo_rte)
	as_Erro = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o of_envia_nota_e_total, objeto uo_ge501_total_express. Erro: "+lo_rte.GetMessage( )
	Return False
End Try	

Return lb_Sucesso
end function

private function boolean of_ambiente (boolean ab_producao, ref string as_erro, long al_filial_pedido);//Try
//	
//	If ab_Producao Then
//		//Produ$$HEX2$$e700e300$$ENDHEX$$o
//		If al_filial_pedido = 181 Then
//			is_Usuario	= "drogariacatar-prod"
//			is_Senha		= "y1TAJz36"
//			il_tipo_servico = 1
//		Else
//			is_Usuario	= "clamed-prod"
//			is_Senha		= "9qrxvz!@"
//			il_tipo_servico = 6
//		End If
//		
//	Else	
//		//Homologa$$HEX2$$e700e300$$ENDHEX$$o
//		is_Usuario	= "clamed-qa"
//		is_Senha		= "9qrxvz!!"
//		il_tipo_servico = 6
//	End If
//
//Catch (RuntimeError lo_rte)
//	as_Erro = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o of_ambiente, objeto uo_ge501_total_express. Erro: "+lo_rte.GetMessage( )
//	Return False
//End Try	
//
Return True
	
	
end function

public function boolean of_carrega_parametros (long pl_cd_filial, boolean pb_producao, ref string ps_log);

if pb_producao = True Then

	select e.de_url, e.de_reid, e.de_usuario, e.de_senha, e.id_tipo_servico
	into :is_url, :is_reid, :is_usuario, :is_senha, :is_id_tipo_servico
	from ecommerce_hub_transp e
	inner join tipo_entrega_ecommerce t on t.cd_tipo_entrega = e.cd_tipo_entrega
	where t.id_tipo_entrega = 'TOT'
		and e.cd_filial_hub = :pl_cd_filial
		and e.id_ecommerce = '2';

Else	
	
	select e.de_url, e.de_reid, e.de_usuario_homologa, e.de_senha_homologa, e.id_tipo_servico_homologa
	into :is_url, :is_reid, :is_usuario, :is_senha, :is_id_tipo_servico
	from ecommerce_hub_transp e
	inner join tipo_entrega_ecommerce t on t.cd_tipo_entrega = e.cd_tipo_entrega
	where t.id_tipo_entrega = 'TOT'
		and e.cd_filial_hub = :pl_cd_filial
		and e.id_ecommerce = '2';	
		
End if	
	
if sqlca.sqlcode = -1 then
	ps_log = 'Objeto: ' + this.classname() + '; Fun$$HEX2$$e700e300$$ENDHEX$$o: of_carrega_parametros ; Problemas ao consultar a tabela "ecommerce_hub_transp" : ' + sqlca.sqlerrtext
	return false
end if

If is_url = '' or isnull(is_url) Then
	ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel identificar a URL [ecommerce_hub_transp] para envio Total Express.'
	return false
end if

If is_reid = '' or isnull(is_reid) Then
	ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel identificar o Reid [ecommerce_hub_transp] para envio Total Express.'
	return false
end if

If is_usuario = '' or isnull(is_usuario) Then
	ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel identificar o usu$$HEX1$$e100$$ENDHEX$$rio de acesso [ecommerce_hub_transp] para envio Total Express.'
	return false
end if

If is_senha = '' or isnull(is_senha) Then
	ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel identificar a senha de acesso [ecommerce_hub_transp] para envio Total Express.'
	return false
end if

If is_id_tipo_servico = '' or isnull(is_id_tipo_servico) Then
	ps_log = 'N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel identificar o Tipo de Servi$$HEX1$$e700$$ENDHEX$$o[ecommerce_hub_transp] para envio Total Express.'
	return false
end if

il_tipo_servico = long(is_id_tipo_servico)

return true
end function

private function boolean of_monta_xml (string as_pedido_ecommerce, ref string as_xml, ref string as_erro, string as_rede_filial);Long	ll_Cod_Remessa,&
		ll_Tipo_Servico,&
		ll_Volumes,&
		ll_Nf_Numero
		
String	ls_Tipo_Entrega,&
		ls_Cond_Frete,&
		ls_Natureza,&
		ls_Tipo_Volume,&
		ls_Isencao_Icms,&
		ls_Dest_Nome,&
		ls_Dest_Cpf_Cgc,&
		ls_Dest_End,&
		ls_Dest_End_Num,&
		ls_Dest_Compl,&
		ls_Dest_Bairro,&
		ls_Dest_Cidade,&
		ls_Dest_Estado,&
		ls_Dest_Pais,&
		ls_Dest_Cep,&
		ls_Dest_Email,&
		ls_Dest_Telefone_1,&
		ls_Nfe_Serie,&
		ls_Nfe_Chave,&
		ls_Fuso_Horario,&
		ls_nr_pedido_drogaexpress
		
DateTime	ldh_Nfe_Data

Decimal	ldc_Nfe_Val_Total,&
			ldc_Nfe_Val_Prod
			
Try	

	ll_tipo_servico = il_tipo_servico

	select nr_pedido_drogaexpress 
	into :ls_nr_pedido_drogaexpress
	from pedido_ecommerce pe
		inner join pedido_ecommerce_auxiliar pa on pa.cd_filial_ecommerce= pe.cd_filial_ecommerce and pa.nr_pedido = pe.nr_pedido
	where pe.nr_pedido_ecommerce = :as_pedido_ecommerce
		and pa.id_rede_ecommerce = :as_rede_filial;
		
	Choose Case sqlca.SqlCode
		Case 0
		Case 100
			as_Erro = "N$$HEX1$$e300$$ENDHEX$$o foram localizadas as informa$$HEX2$$e700f500$$ENDHEX$$es do pedido "+ as_Pedido_Ecommerce +"."
			Return False
		Case -1
			as_Erro = "Erro ao localizar as informa$$HEX2$$e700f500$$ENDHEX$$es do pedido "+ as_Pedido_Ecommerce +": "+sqlca.SqlErrText
			Return False
	End Choose	
		
	//6 as cd_tipo_servico,
	//1 as cd_tipo_servico homologa	
	Select	1 as nr_cod_remessa,	
			'0' as id_tipo_entrega,
			coalesce(a.qt_volume, 1) as qt_volumes,
			'CIF' as de_cond_frete,
			coalesce(max(d.de_produto+' : '+d.de_apresentacao_venda), '') as de_natureza,
			'CX' as de_tipo_volume,
			case when sum(coalesce(b.vl_icms, 0)) > 0 then '1' else '0' end as id_isencao_icms,
			coalesce(a.nm_cliente_entrega, '') as de_dest_nome,
			coalesce(a.nr_cpf_cheque, '') as nr_dest_cpf_cgc,
			coalesce(a.de_endereco_entrega, '') as de_dest_end,
			coalesce(a.nr_endereco_entrega, '') as nr_dest_end_num,
			left( coalesce(a.de_complemento_endereco, ''), 60 ) as de_dest_compl,
			left(coalesce(a.de_bairro_entrega, ''), 40) as de_dest_bairro,
			left(coalesce(a.nm_cidade_entrega, ''), 40 ) as de_dest_cidade,
			coalesce(a.cd_uf_entrega, '') as dest_estado,
			'BRASIL' as de_dest_pais,
			coalesce(a.nr_cep_entrega,'') as de_dest_cep,
			left( coalesce(a.de_endereco_email, ''), 60 ) as de_dest_email,
			coalesce(a.nr_telefone_entrega, '') as nr_dest_telefone_1,
			b.nr_nf as nr_nf_numero,
			b.de_serie as de_nfe_serie,
			b.dh_emissao as dh_nfe_data,
			b.vl_total_nf as vl_nfe_val_total,
			b.vl_total_produtos as vl_nfe_val_prod,
			e.de_chave_acesso as de_nfe_chave
	Into	:ll_Cod_Remessa,
			:ls_Tipo_Entrega,
			:ll_Volumes,
			:ls_Cond_Frete,
			:ls_Natureza,
			:ls_Tipo_Volume,
			:ls_Isencao_Icms,
			:ls_Dest_Nome,
			:ls_Dest_Cpf_Cgc,
			:ls_Dest_End,
			:ls_Dest_End_Num,
			:ls_Dest_Compl,
			:ls_Dest_Bairro,
			:ls_Dest_Cidade,
			:ls_Dest_Estado,
			:ls_Dest_Pais,
			:ls_Dest_Cep,
			:ls_Dest_Email,
			:ls_Dest_Telefone_1,
			:ll_Nf_Numero,
			:ls_Nfe_Serie,
			:ldh_Nfe_Data,
			:ldc_Nfe_Val_Total,
			:ldc_Nfe_Val_Prod,
			:ls_Nfe_Chave
	From pedido_drogaexpress	a
	Inner Join nf_venda			b	on		b.nr_pedido_drogaexpress	= a.nr_pedido_drogaexpress
	Inner Join item_nf_venda	c	on		c.cd_filial						= b.cd_filial
											and	c.nr_nf						= b.nr_nf
											and	c.de_especie				= b.de_especie
											and	c.de_serie					= b.de_serie
	Inner join produto_geral    d	on		d.cd_produto				= c.cd_produto
	Inner join nf_venda_nfe     e	on		e.cd_filial					= b.cd_filial
											and	e.nr_nf						= b.nr_nf
											and	e.de_especie				= b.de_especie
											and	e.de_serie					= b.de_serie
	Where a.nr_pedido_drogaexpress = :ls_nr_pedido_drogaexpress
	Group By	a.qt_volume,
				a.nm_cliente_entrega,
				a.nr_cpf_cheque,
				a.de_endereco_entrega,
				a.nr_endereco_entrega,
				a.de_complemento_endereco,
				a.de_bairro_entrega,
				a.nm_cidade_entrega,
				a.cd_uf_entrega,
				a.nr_cep_entrega,
				a.de_endereco_email,
				a.nr_telefone_entrega,
				b.nr_nf,
				b.de_serie,
				b.dh_emissao,
				b.vl_total_nf,
				b.vl_total_produtos,
				e.de_chave_acesso
	Using itr_filial;
	
	Choose Case itr_filial.SqlCode
		Case 0
		Case 100
			as_Erro = "N$$HEX1$$e300$$ENDHEX$$o foram localizadas as informa$$HEX2$$e700f500$$ENDHEX$$es do pedido "+ as_Pedido_Ecommerce +"."
			Return False
		Case -1
			as_Erro = "Erro ao localizar as informa$$HEX2$$e700f500$$ENDHEX$$es do pedido "+ as_Pedido_Ecommerce +": "+itr_filial.SqlErrText
			Return False
	End Choose
	
	If IsNull(ll_Cod_Remessa) Then
		as_Erro = "Ocorreu um problema na fun$$HEX2$$e700e300$$ENDHEX$$o of_monta_xml, objeto uo_ge501_total_express, o vari$$HEX1$$e100$$ENDHEX$$vel 'll_Cod_Remessa' est$$HEX1$$e100$$ENDHEX$$ nula."
		Return False	
	End If
	
	If IsNull(ll_Tipo_Servico) Then
		as_Erro = "Ocorreu um problema na fun$$HEX2$$e700e300$$ENDHEX$$o of_monta_xml, objeto uo_ge501_total_express, o vari$$HEX1$$e100$$ENDHEX$$vel 'll_Tipo_Servico' est$$HEX1$$e100$$ENDHEX$$ nula."
		Return False	
	End If
	
	If IsNull(ls_Tipo_Entrega) Then
		as_Erro = "Ocorreu um problema na fun$$HEX2$$e700e300$$ENDHEX$$o of_monta_xml, objeto uo_ge501_total_express, o vari$$HEX1$$e100$$ENDHEX$$vel 'ls_Tipo_Entrega' est$$HEX1$$e100$$ENDHEX$$ nula."
		Return False	
	End If
	
	If IsNull(ll_Volumes) Then
		as_Erro = "Ocorreu um problema na fun$$HEX2$$e700e300$$ENDHEX$$o of_monta_xml, objeto uo_ge501_total_express, o vari$$HEX1$$e100$$ENDHEX$$vel 'll_Volumes' est$$HEX1$$e100$$ENDHEX$$ nula."
		Return False	
	End If
	
	If IsNull(ls_Natureza) Then
		as_Erro = "Ocorreu um problema na fun$$HEX2$$e700e300$$ENDHEX$$o of_monta_xml, objeto uo_ge501_total_express, o vari$$HEX1$$e100$$ENDHEX$$vel 'ls_Natureza' est$$HEX1$$e100$$ENDHEX$$ nula."
		Return False	
	End If
	
	If IsNull(ls_Tipo_Volume) Then
		as_Erro = "Ocorreu um problema na fun$$HEX2$$e700e300$$ENDHEX$$o of_monta_xml, objeto uo_ge501_total_express, o vari$$HEX1$$e100$$ENDHEX$$vel 'ls_Tipo_Volume' est$$HEX1$$e100$$ENDHEX$$ nula."
		Return False	
	End If
	
	If IsNull(ls_Isencao_Icms) Then
		as_Erro = "Ocorreu um problema na fun$$HEX2$$e700e300$$ENDHEX$$o of_monta_xml, objeto uo_ge501_total_express, o vari$$HEX1$$e100$$ENDHEX$$vel 'ls_Isencao_Icms' est$$HEX1$$e100$$ENDHEX$$ nula."
		Return False	
	End If
	
	If IsNull(ls_Dest_Nome) Then
		as_Erro = "Ocorreu um problema na fun$$HEX2$$e700e300$$ENDHEX$$o of_monta_xml, objeto uo_ge501_total_express, o vari$$HEX1$$e100$$ENDHEX$$vel 'ls_Dest_Nome' est$$HEX1$$e100$$ENDHEX$$ nula."
		Return False	
	End If
	
	If IsNull(ls_Dest_Cpf_Cgc) Then
		as_Erro = "Ocorreu um problema na fun$$HEX2$$e700e300$$ENDHEX$$o of_monta_xml, objeto uo_ge501_total_express, o vari$$HEX1$$e100$$ENDHEX$$vel 'ls_Dest_Cpf_Cgc' est$$HEX1$$e100$$ENDHEX$$ nula."
		Return False	
	End If
	
	If IsNull(ls_Dest_End) Then
		as_Erro = "Ocorreu um problema na fun$$HEX2$$e700e300$$ENDHEX$$o of_monta_xml, objeto uo_ge501_total_express, o vari$$HEX1$$e100$$ENDHEX$$vel 'ls_Dest_End' est$$HEX1$$e100$$ENDHEX$$ nula."
		Return False	
	End If
	
	If IsNull(ls_Dest_End_Num) Then
		as_Erro = "Ocorreu um problema na fun$$HEX2$$e700e300$$ENDHEX$$o of_monta_xml, objeto uo_ge501_total_express, o vari$$HEX1$$e100$$ENDHEX$$vel 'ls_Dest_End_Num' est$$HEX1$$e100$$ENDHEX$$ nula."
		Return False	
	End If
	
	If IsNull(ls_Dest_Bairro) Then
		as_Erro = "Ocorreu um problema na fun$$HEX2$$e700e300$$ENDHEX$$o of_monta_xml, objeto uo_ge501_total_express, o vari$$HEX1$$e100$$ENDHEX$$vel 'ls_Dest_Bairro' est$$HEX1$$e100$$ENDHEX$$ nula."
		Return False	
	End If
	
	If IsNull(ls_Dest_Cidade) Then
		as_Erro = "Ocorreu um problema na fun$$HEX2$$e700e300$$ENDHEX$$o of_monta_xml, objeto uo_ge501_total_express, o vari$$HEX1$$e100$$ENDHEX$$vel 'ls_Dest_Cidade' est$$HEX1$$e100$$ENDHEX$$ nula."
		Return False	
	End If
	
	If IsNull(ls_Dest_Estado) Then
		as_Erro = "Ocorreu um problema na fun$$HEX2$$e700e300$$ENDHEX$$o of_monta_xml, objeto uo_ge501_total_express, o vari$$HEX1$$e100$$ENDHEX$$vel 'ls_Dest_Estado' est$$HEX1$$e100$$ENDHEX$$ nula."
		Return False	
	End If
	
	If IsNull(ls_Dest_Pais) Then
		as_Erro = "Ocorreu um problema na fun$$HEX2$$e700e300$$ENDHEX$$o of_monta_xml, objeto uo_ge501_total_express, o vari$$HEX1$$e100$$ENDHEX$$vel 'ls_Dest_Pais' est$$HEX1$$e100$$ENDHEX$$ nula."
		Return False	
	End If
	
	If IsNull(ls_Dest_Cep) Then
		as_Erro = "Ocorreu um problema na fun$$HEX2$$e700e300$$ENDHEX$$o of_monta_xml, objeto uo_ge501_total_express, o vari$$HEX1$$e100$$ENDHEX$$vel 'ls_Dest_Cep' est$$HEX1$$e100$$ENDHEX$$ nula."
		Return False	
	End If
	
	If IsNull(ll_Nf_Numero) Then
		as_Erro = "Ocorreu um problema na fun$$HEX2$$e700e300$$ENDHEX$$o of_monta_xml, objeto uo_ge501_total_express, o vari$$HEX1$$e100$$ENDHEX$$vel 'll_Nf_Numero' est$$HEX1$$e100$$ENDHEX$$ nula."
		Return False	
	End If
	
	If IsNull(ls_Nfe_Serie) Then
		as_Erro = "Ocorreu um problema na fun$$HEX2$$e700e300$$ENDHEX$$o of_monta_xml, objeto uo_ge501_total_express, o vari$$HEX1$$e100$$ENDHEX$$vel 'ls_Nfe_Serie' est$$HEX1$$e100$$ENDHEX$$ nula."
		Return False	
	End If
	
	If IsNull(ldh_Nfe_Data) Then
		as_Erro = "Ocorreu um problema na fun$$HEX2$$e700e300$$ENDHEX$$o of_monta_xml, objeto uo_ge501_total_express, o vari$$HEX1$$e100$$ENDHEX$$vel 'ldh_Nfe_Data' est$$HEX1$$e100$$ENDHEX$$ nula."
		Return False	
	End If
	
	If IsNull(ldc_Nfe_Val_Total) Then
		as_Erro = "Ocorreu um problema na fun$$HEX2$$e700e300$$ENDHEX$$o of_monta_xml, objeto uo_ge501_total_express, o vari$$HEX1$$e100$$ENDHEX$$vel 'ldc_Nfe_Val_Total' est$$HEX1$$e100$$ENDHEX$$ nula."
		Return False	
	End If
	
	If IsNull(ldc_Nfe_Val_Prod) Then
		as_Erro = "Ocorreu um problema na fun$$HEX2$$e700e300$$ENDHEX$$o of_monta_xml, objeto uo_ge501_total_express, o vari$$HEX1$$e100$$ENDHEX$$vel 'ldc_Nfe_Val_Prod' est$$HEX1$$e100$$ENDHEX$$ nula."
		Return False	
	End If
	
	If IsNull(ls_Nfe_Chave) Then
		ls_Nfe_Chave = ''
		//as_Erro = "Ocorreu um problema na fun$$HEX2$$e700e300$$ENDHEX$$o of_monta_xml, objeto uo_ge501_total_express, o vari$$HEX1$$e100$$ENDHEX$$vel 'ls_Nfe_Chave' est$$HEX1$$e100$$ENDHEX$$ nula."
		//Return False	
	End If
	
	as_Xml	=		'<?xml version="1.0" encoding="UTF-8"?>'+&
						'<soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:RegistraColeta">'+&
						'<soapenv:Header/>'+&
						'<soapenv:Body>'+&
						'<ns1:RegistraColeta>'+&
						'<RegistraColetaRequest xsi:type="ns2:RegistraColetaRequest">'+&
						'<CodRemessa xsi:type="xsd:string">'+String(ll_Cod_Remessa)+'</CodRemessa>'+&
						'<Encomendas SOAP-ENC:arrayType="ns2:Encomenda[1]" xsi:type="ns2:Encomendas">'+&
						'<item xsi:type="ns2:Encomenda">'+&
						'<TipoServico xsi:type="xsd:nonNegativeInteger">'+String(ll_Tipo_Servico)+'</TipoServico>'+&
						'<TipoEntrega xsi:type="xsd:nonNegativeInteger">'+ls_Tipo_Entrega+'</TipoEntrega>'+&
						'<Volumes xsi:type="xsd:nonNegativeInteger">'+String(ll_Volumes)+'</Volumes>'+&
						'<CondFrete xsi:type="xsd:string">CIF</CondFrete>'+&
						'<Pedido xsi:type="xsd:string">' +  as_pedido_ecommerce +'</Pedido>'+&
						'<Natureza xsi:type="xsd:string">'+Mid(Trim(gf_Replace(ls_Natureza, "&", "e", 0)), 1, 25)+'</Natureza>'+&
						'<TipoVolumes xsi:type="xsd:string">'+ls_Tipo_Volume+'</TipoVolumes>'	+&
						'<IsencaoIcms xsi:type="xsd:nonNegativeInteger">'+ls_Isencao_Icms+'</IsencaoIcms>'+&
						'<DestNome xsi:type="xsd:string">'+Mid(Trim(ls_Dest_Nome), 1, 40)+'</DestNome>'+&
						'<DestCpfCnpj xsi:type="xsd:string">'+Trim(ls_Dest_Cpf_Cgc)+'</DestCpfCnpj>'+&
						'<DestEnd xsi:type="xsd:string">'+Mid(Trim(ls_Dest_End), 1, 40)+'</DestEnd>'+&
						'<DestEndNum xsi:type="xsd:string">'+Trim(ls_Dest_End_Num)+'</DestEndNum>'
	If (Trim(ls_Dest_Compl) <> "") and not IsNull(ls_Dest_Compl) Then
		as_Xml	+= '<DestCompl xsi:type="xsd:string">'+Mid(Trim(ls_Dest_Compl), 1, 60)+'</DestCompl>'
	End If	
	
	as_Xml	+=		'<DestBairro xsi:type="xsd:string">'+Mid(Trim(ls_Dest_Bairro), 1, 40)+'</DestBairro>'+&
						'<DestCidade xsi:type="xsd:string">'+Mid(Trim(ls_Dest_Cidade), 1, 40)+'</DestCidade>'+&
						'<DestEstado xsi:type="xsd:string">'+Trim(ls_Dest_Estado)+'</DestEstado>'+&
						'<DestPais xsi:type="xsd:string">'+Trim(ls_Dest_Pais)+'</DestPais>'+&
						'<DestCep xsi:type="xsd:nonNegativeInteger">'+Trim(ls_Dest_Cep)+'</DestCep>'
	If (Trim(ls_Dest_Email) <> "") and not IsNull(ls_Dest_Email) Then
		as_Xml	+=	'<DestEmail xsi:type="xsd:string">'+Mid(Trim(ls_Dest_Email), 1, 60)+'</DestEmail>'
	End If
	
	If (Trim(ls_Dest_Telefone_1) <> "") and not IsNull(ls_Dest_Telefone_1) Then
		as_Xml	+=	'<DestTelefone1 xsi:type="xsd:nonNegativeInteger">'+Trim(ls_Dest_Telefone_1)+'</DestTelefone1>'
	End If
	
	as_Xml	+=		'<DocFiscalNFe SOAP-ENC:arrayType="ns2:NFe[1]" xsi:type="ns2:DocFiscalNFe">'+&
						'<item xsi:type="ns2:NFe">'+&
						'<NfeNumero xsi:type="xsd:nonNegativeInteger">'+String(ll_Nf_Numero)+'</NfeNumero>'+&
						'<NfeSerie xsi:type="xsd:nonNegativeInteger">'+Trim(ls_Nfe_Serie)+'</NfeSerie>'+&
						'<NfeData xsi:type="xsd:date">'+String(ldh_Nfe_Data, 'YYYY-mm-dd')+'T'+String(ldh_Nfe_Data, 'hh:mm:ss')+'</NfeData>'+&
						'<NfeValTotal xsi:type="xsd:decimal">'+gf_Replace(String(ldc_Nfe_Val_Total, '###.##'), ',', '.', 0)+'</NfeValTotal>'+&
						'<NfeValProd xsi:type="xsd:decimal">'+gf_Replace(String(ldc_Nfe_Val_Prod, '###.##'), ',', '.', 0)+'</NfeValProd>'+&
						'<NfeChave xsi:type="xsd:string">'+Trim(ls_Nfe_Chave)+'</NfeChave>'+&
						'</item>'+&
						'</DocFiscalNFe>'+&
						'</item>'+&
						'</Encomendas>'+&
						'</RegistraColetaRequest>'+&
						'</ns1:RegistraColeta>'+&
						'</soapenv:Body>'+&
						'</soapenv:Envelope>'
						
	If IsNull(as_Xml) Then
		as_Erro = "Ocorreu um problema na fun$$HEX2$$e700e300$$ENDHEX$$o of_monta_xml, objeto uo_ge501_total_express, o XML est$$HEX1$$e100$$ENDHEX$$ nulo."
		Return False	
	End If
	
	If as_Xml = "" Then
		as_Erro = "Ocorreu um problema na fun$$HEX2$$e700e300$$ENDHEX$$o of_monta_xml, objeto uo_ge501_total_express, o XML est$$HEX1$$e100$$ENDHEX$$ vazio."
		Return False
	End If
	

Catch ( runtimeerror  lo_rte )
	as_Erro = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o of_monta_xml, objeto uo_ge501_total_express. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try
	
		  
Return True
end function

public function boolean of_encode_credencial (ref string ps_log);blob lb_credencial
long ll_pos
string ls_retorno
n_winsock luo_win

luo_win = create n_winsock

lb_credencial = blob( is_usuario + ':' + is_senha, EncodingUTF8! )

ls_retorno = luo_win.of_encode64( lb_credencial)

destroy(luo_win)

if ls_retorno = '' or isnull(ls_retorno) Then
	ps_log = 'Objeto: ' + this.classname() + ';Fun$$HEX2$$e700e300$$ENDHEX$$o: of_encode_credencial ; N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel codificar as credenciais de acesso.'
	return false
end if

is_credenciais_acesso = ls_retorno

return true
end function

public function boolean of_grava_rastreio (string ps_xml, dc_uo_ds_base pds_rastreio, ref string ps_log);string ls_retorno
String ls_status, ls_data, ls_descricao, ls_objeto, ls_pedido, ls_nota, ls_serie
long ll_total, ll_for, ll_total_status
long ll_nr_sequencial
long ll_existe
long ll_for2
long ll_row

datetime ldh_status
boolean lb_sucesso= false

oleobject lole_node_item, lole_xml, lole_node_status

Try
	
	IF Not IsValid(lole_xml) THEN
		lole_xml = CREATE oleobject
		lole_xml.ConnectToNewObject("Msxml2.DOMDocument.6.0")
	End if
	
	if Not lole_xml.loadXML(ps_xml) then
		ps_log = string(lole_xml.parseError.reason) 
		return false
	end if
	
	lole_xml.async = false
	
	lole_node_item = lole_xml.documentElement.SelectNodes('//ArrayEncomendaRetorno/item')
	
	ll_total = long(lole_node_item.length) - 1
	
	//ll_total_status = long(lole_node_status.length)
	
	if ll_total < 0 Then return true
	
	ll_nr_sequencial = 0
	
//	pb_novo_rastreio = false

	for ll_for = ll_total to 0 step -1
//		
		lole_node_status = lole_node_item.item(ll_for).SelectNodes('ArrayStatusTotal/item')

		ll_total_status = long(lole_node_status.length) - 1

		ls_objeto = String(lole_node_item.item(ll_for).childNodes.item(0).text)
		ls_pedido = String(lole_node_item.item(ll_for).childNodes.item(1).text)
		ls_nota = String(lole_node_item.item(ll_for).childNodes.item(2).text)
		ls_serie = String(lole_node_item.item(ll_for).childNodes.item(3).text)
		
//		pds_rastreio
		
		for ll_for2 = 0 to ll_total_status
		
			ls_status = String(lole_node_status.item(ll_for2).childNodes.item(0).text)
			ls_descricao = String(lole_node_status.item(ll_for2).childNodes.item(1).text)
			ls_data = String(lole_node_status.item(ll_for2).childNodes.item(2).text)
			
		next
		
	next
	
	lb_sucesso = true
	
CATCH (runtimeerror er)   
	ps_log = er.GetMessage()
	return false 
Finally
	if isvalid(lole_node_item) then destroy(lole_node_item)
End Try

return true




return true
end function

public function boolean of_processa_retorno_rastreamento (string ps_xml, ref dc_uo_ds_base pds_rastreio, ref string ps_log);string ls_retorno
String ls_status, ls_data, ls_descricao, ls_objeto, ls_pedido, ls_nota, ls_serie
long ll_total, ll_for, ll_total_status
long ll_nr_sequencial
long ll_existe
long ll_for2
long ll_row

datetime ldh_status
boolean lb_sucesso= false

oleobject lole_node_item, lole_xml, lole_node_status

Try
	
	IF Not IsValid(lole_xml) THEN
		lole_xml = CREATE oleobject
		lole_xml.ConnectToNewObject("Msxml2.DOMDocument.6.0")
	End if
	
	if Not lole_xml.loadXML(ps_xml) then
		ps_log = string(lole_xml.parseError.reason) 
		return false
	end if
	
	lole_xml.async = false
	
	lole_node_item = lole_xml.documentElement.SelectNodes('//ArrayEncomendaRetorno/item')
	
	ll_total = long(lole_node_item.length) - 1
	
	if ll_total < 0 Then return true
	
	ll_nr_sequencial = 0

	for ll_for = ll_total to 0 step -1
//		
		lole_node_status = lole_node_item.item(ll_for).SelectNodes('ArrayStatusTotal/item')

		ll_total_status = long(lole_node_status.length) - 1

		ls_objeto = String(lole_node_item.item(ll_for).childNodes.item(0).text)
		ls_pedido = String(lole_node_item.item(ll_for).childNodes.item(1).text)
		ls_nota = String(lole_node_item.item(ll_for).childNodes.item(2).text)
		ls_serie = String(lole_node_item.item(ll_for).childNodes.item(3).text)
	
		for ll_for2 = 0 to ll_total_status
		
			ls_status = String(lole_node_status.item(ll_for2).childNodes.item(0).text)
			ls_descricao = String(lole_node_status.item(ll_for2).childNodes.item(1).text)
			ls_data = String(lole_node_status.item(ll_for2).childNodes.item(2).text)
			
			ldh_status = Datetime(date( left(ls_data,10) ), time( mid(ls_data, 12, 10) ) )
			
			ll_row = pds_rastreio.insertrow(0)
		
			if pos(ls_pedido,'SLR-',0) > 0 Then
				ls_pedido = gf_replace(ls_pedido,'SLR-', '',0)
			ENd if
		
			pds_rastreio.setitem(ll_row, 'de_objeto', ls_objeto)
			pds_rastreio.setitem(ll_row, 'nr_pedido_ecommerce', ls_pedido)
			pds_rastreio.setitem(ll_row, 'nr_sequencial', ll_for2)
			pds_rastreio.setitem(ll_row, 'cd_status', ls_status)
			pds_rastreio.setitem(ll_row, 'de_status', ls_descricao)
			pds_rastreio.setitem(ll_row, 'dh_status', ldh_status)

		next
		
	next
	
	lb_sucesso = true
	
CATCH (runtimeerror er)   
	ps_log = er.GetMessage()
	return false 
Finally
	if isvalid(lole_node_item) then destroy(lole_node_item)
	if isvalid(lole_node_status) then destroy(lole_node_status)
End Try

return true




return true
end function

public function boolean of_rastrear_pedido (long pl_cd_filial, date pdh_consulta, boolean pb_producao, ref dc_uo_ds_base pds_rastreio, ref string ps_log);String	ls_Xml,&
		ls_Xml_Retorno

Boolean	lb_Sucesso = False

Try

	If Not this.of_carrega_parametros( pl_cd_filial, pb_producao, ref ps_log ) Then return false
	
	ls_Xml	=	'<?xml version="1.0" encoding="ISO-8859-1"?>'+&
					'<soapenv:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:urn="urn:ObterTracking">'+&
					'<soapenv:Header/>'+&
					'<soapenv:Body>'+&
					'<urn:ObterTracking soapenv:encodingStyle="http://schemas.xmlsoap.org/soap/encoding/">'+&
					'<ObterTrackingRequest xsi:type="web:ObterTrackingRequest" xmlns:web="http://edi.totalexpress.com.br/soap/webservice_v24.total">'+&
					'<DataConsulta xsi:type="xsd:date">'+String(pdh_consulta, "yyyy-mm-dd")+'</DataConsulta>'+&
					'</ObterTrackingRequest>'+&
					'</urn:ObterTracking>'+&
					'</soapenv:Body>'+&
					'</soapenv:Envelope>'

					
	If This.of_Envia_WebService(ls_Xml, Ref ls_Xml_Retorno, Ref ps_log) Then
		If This.of_Processa_Retorno_Rastreamento(ls_Xml_Retorno, Ref pds_rastreio, Ref ps_log) Then
			lb_Sucesso = True
		End If
	End If
	
Catch ( runtimeerror  lo_rte )
	ps_log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o of_rastrear_pedido, objeto uo_ge501_total_express. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try

Return lb_Sucesso 
end function

on uo_ge501_total_express.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge501_total_express.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

