HA$PBExportHeader$dc_uo_xml.sru
forward
global type dc_uo_xml from nonvisualobject
end type
end forward

global type dc_uo_xml from nonvisualobject
end type
global dc_uo_xml dc_uo_xml

type variables
int CAPICOM_ENCRYPTION_ALGORITHM_RC2   = 0
int CAPICOM_ENCRYPTION_ALGORITHM_RC4   = 1
int CAPICOM_ENCRYPTION_ALGORITHM_DES   = 2
int CAPICOM_ENCRYPTION_ALGORITHM_3DES = 3
int CAPICOM_ENCRYPTION_ALGORITHM_AES   = 4
int CAPICOM_AUTHENTICATED_ATTRIBUTE_SIGNING_TIME = 0 
int CAPICOM_AUTHENTICATED_ATTRIBUTE_DOCUMENT_NAME = 1
int CAPICOM_CURRENT_USER_STORE     = 2
int CAPICOM_STORE_OPEN_READ_ONLY  = 0
int CAPICOM_ENCODE_BINARY = 0

String 	BR = char(13)+char(10)		,&
			lvs_cabecalho 
			
//= '<soap12:Header>' + &
//			'<nfeCabecMsg xmlns="http://www.portalfiscal.inf.br/nfe/wsdl/NFeRecepcao">' +&
//			'<versaoDados>string</versaoDados>' +
//			'<cUF>string<cUF>' + BR
//			'</nfeCabecMsg>' + BR
//			'</soap12:Header>'

String xmlDoc 
end variables

forward prototypes
public function string of_gerar_xml_cabecalho (long al_nr_nf, string de_especie, string de_serie, long cd_filal)
public function string of_gera_icms (string as_icms_type, datawindow dw_itens, long lvl_linha)
public function string of_replace_ean (string as_ean)
public function string of_replace_inscricao_estadual (string as_inscricao)
public function string of_replace_numero (double ad_valor, integer ai_tipo)
public function string of_replace_telefone (string as_telefone)
public function string of_retira_caracteres_especiais (string as_string)
public subroutine of_gerar_xml_rodape ()
public function string of_gera_pis (string type_pis, datawindow dw_itens, long lvl_linha)
public function string of_assinatura (string as_documento)
public function string of_hash (string as_dados)
public function string of_x509certificate ()
public subroutine of_pbdom ()
public function string of_gera_xml_completo ()
public function string of_gerar_xml_dados (long al_nr_nf, string as_especie, string as_serie, long al_filial)
public function string of_gerar_xml_totais (long al_nr_nf, string as_especie, string as_serie, integer ai_filial)
public function string of_assina_xml ()
public function integer of_assina_xml_texto ()
end prototypes

public function string of_gerar_xml_cabecalho (long al_nr_nf, string de_especie, string de_serie, long cd_filal);String lvs_Dados

Long al_linha

dc_uo_dw_base dw_nfe 


lvs_Dados = '<?xml version="1.0" encoding="UTF-8"?>'+&
			     '<enviNFe xmlns="http://www.portalfiscal.inf.br/nfe" versao="1.10">'
lvs_Dados += '<idLote>' + + '</idLote>' +&
'<NFe xmlns="http://www.portalfiscal.inf.br/nfe">'
//lvs_Dados += ''<infNFe Id="' + as_chave_acesso + '" versao="1.10">'' +&
//''<ide>''
//lvs_Dados += ''<cUF>'' +dw_nfe.Object.ide_cUF[al_linha] + ''</cUF>''
//lvs_Dados += '<cNF>'+ Mid(as_chave_acesso,36,8) + '</cNF>'          
lvs_Dados += '<natOp>' + dw_nfe.Object.ide_NatOp[al_linha] + '</natOp>'
lvs_Dados += '<indPag>' + dw_nfe.Object.ide_indPag[al_linha] + '</indPag>'
lvs_Dados += '<mod>' + dw_nfe.Object.ide_mod[al_linha] + '</mod>'
lvs_Dados += '<serie>' + dw_nfe.Object.ide_serie[al_linha] + '</serie>'
lvs_Dados += '<nNF>' + gf_replace(string(dw_nfe.Object.ide_nNF[al_linha]),",",".",0) + '</nNF>'
lvs_Dados += '<dEmi>' + gf_replace(string(dw_nfe.Object.ide_dEmi[al_linha], 'yyyy-mm-dd'),",",".",0) + '</dEmi>'
lvs_Dados += '<dSaiEnt>' + gf_replace(string(dw_nfe.Object.ide_dSaiEnt[al_Linha], 'yyyy-mm-dd'),",",".",0) + '</dSaiEnt>'
lvs_Dados += '<tpNF>' + dw_nfe.Object.ide_tpNF[al_linha] + '</tpNF>'
lvs_Dados += '<cMunFG>' + dw_nfe.Object.ide_cMunFG[al_linha] + '</cMunFG>'
lvs_Dados += '<tpImp>' + dw_nfe.Object.ide_TpImp[al_linha] + '</tpImp>'
lvs_Dados += '<tpEmis>' + dw_nfe.Object.ide_TpEmis[al_linha] + '</tpEmis>'
//lvs_Dados += '<cDV>' + Mid(as_chave_acesso,44,1) + '</cDV>'
lvs_Dados += '<tpAmb>' + dw_nfe.Object.ide_TpAmb[al_linha] +'</tpAmb>'
lvs_Dados += '<finNFe>' + dw_nfe.Object.ide_FinNFe[al_linha] + '</finNFe>'
lvs_Dados += '<procEmi>' + dw_nfe.Object.ide_ProcEmi[al_linha] + '</procEmi>'
lvs_Dados += '<verProc>' + dw_nfe.Object.ide_VerProc[al_linha] + '</verProc></ide><emit>'


If Len(string(dw_nfe.Object.emit_CNPJ[al_linha])) = 14 Then 	
	lvs_Dados += '<CNPJ>' + dw_nfe.Object.emit_CNPJ[al_linha] + '</CNPJ>' 
Else  
	lvs_Dados += '<CPF>' + dw_nfe.Object.emit_CNPJ[al_linha] + '<CPF>'
End If



lvs_Dados += '<xNome>' + dw_nfe.Object.emit_XNome[al_linha] + '</xNome>'
lvs_Dados += '<xFant>' + dw_nfe.Object.emit_XFant[al_linha] + '</xFant><enderEmit>'
lvs_Dados += '<xLgr>' + dw_nfe.Object.emit_XLgr[al_linha] + '</xLgr>'
lvs_Dados += '<nro>' + dw_nfe.Object.emit_Nro[al_linha] + '</nro>'
lvs_Dados += '<xCpl>' + dw_nfe.Object.emit_XCpl[al_linha] + '</xCpl>'
lvs_Dados += '<xBairro>' + dw_nfe.Object.emit_xBairro[al_linha] + '</xBairro>'
lvs_Dados += '<cMun>' + dw_nfe.Object.emit_CMun[al_linha] + '</cMun>'
lvs_Dados += '<xMun>' + dw_nfe.Object.emit_XMun[al_linha] + '</xMun>'
lvs_Dados += '<UF>' + dw_nfe.Object.emit_UF[al_linha] + '</UF>'
lvs_Dados += '<CEP>' + dw_nfe.Object.emit_CEP[al_linha] + '</CEP>'
lvs_Dados += '<cPais>' + dw_nfe.Object.emit_CPais[al_linha] + '</cPais>'
lvs_Dados += '<xPais>' + dw_nfe.Object.emit_XPais[al_linha] + '</xPais>'
//lvs_Dados += '<fone>' + wf_replace_telefone(dw_nfe.Object.emit_Fone[al_linha]) + '</fone></enderEmit>'
//lvs_Dados += '<IE>' + wf_replace_inscricao_estadual(dw_nfe.Object.emit_IE[al_linha] + '</IE></emit><dest>'

//lvs_Txt = "NOTA FISCAL|"+ gf_replace(string(ai_notas),",",".",0) + "|" + BR  

If Len(string(dw_nfe.Object.emit_CNPJ[al_linha])) = 14 Then 	
	lvs_Dados += '<CNPJ>' + dw_nfe.Object.dest_CNPJ[al_Linha] + '</CNPJ>' 
Else  
	lvs_Dados += '<CPF>' + dw_nfe.Object.dest_CNPJ[al_Linha] + '<CPF>'
End If

lvs_Dados += '<xNome>' + dw_nfe.Object.dest_xNome[al_linha] + '</xNome><enderDest>'
lvs_Dados += '<xLgr>' + dw_nfe.Object.dest_XLgr[al_linha] +'</xLgr>'
lvs_Dados += '<nro>' + dw_nfe.Object.dest_Nro[al_linha] + '</nro>'
lvs_Dados += '<xCpl>' + dw_nfe.Object.dest_XCpl[al_linha] + '</xCpl>'
lvs_Dados += '<xBairro>' + dw_nfe.Object.dest_XBairro[al_linha] + '</xBairro>'
lvs_Dados += '<cMun>' + dw_nfe.Object.dest_CMun[al_linha] + '</cMun>'
lvs_Dados += '<xMun>' + dw_nfe.Object.dest_XMun[al_linha] + '</xMun>'
lvs_Dados += '<UF>' + dw_nfe.Object.dest_UF[al_linha] + '</UF>'

lvs_Dados += '<CEP>' + dw_nfe.Object.dest_CEP[al_linha] + '</CEP>'
lvs_Dados += '<cPais>' + dw_nfe.Object.dest_CPais[al_linha] + '</cPais>'
lvs_Dados += '<xPais>' + dw_nfe.Object.dest_XPais[al_linha] + '</xPais>'
//lvs_Dados += '<fone>' +  wf_replace_telefone(dw_nfe.Object.dest_Fone[al_linha]) + '</fone></enderDest>'
//lvs_Dados += wf_replace_inscricao_estadual(dw_nfe.Object.dest_IE[al_linha]) + '<IE />'
lvs_Dados += '</dest>'


	
Return lvs_Dados
//
//OLEObject oMessage ,TSignedData, TSigner, TCertStore, TCertificate, TAttribute, TUtilities, TSigner2
//
//Int Ind
//Boolean Desatachado
//
//String Documento
//String Assinatura
//
////String TobeEncrypted ,hidden, filename, encryptedmessage, decrypted
////
////int CAPICOM_ENCRYPTION_ALGORITHM_RC2   = 0
////int CAPICOM_ENCRYPTION_ALGORITHM_RC4   = 1
////int CAPICOM_ENCRYPTION_ALGORITHM_DES   = 2
////int CAPICOM_ENCRYPTION_ALGORITHM_3DES = 3
////int CAPICOM_ENCRYPTION_ALGORITHM_AES   = 4
////int li_FileNum 
//
//int CAPICOM_CURRENT_USER_STORE     = 2
//int CAPICOM_STORE_OPEN_READ_ONLY  = 0
//
//TSignedData = CREATE OLEObject
//If TSignedData.ConnectToNewObject("CAPICOM.SignedData") '<>' 0 Then
//MessageBox("CAPICOM","Impossivel fazer conex$$HEX1$$e300$$ENDHEX$$o com CAPICOM.DLL: Object SignedData")
//Return
//End If
//
//TSigner = CREATE OLEObject
//If TSigner.ConnectToNewObject("CAPICOM.Signer") '<>' 0 Then
//MessageBox("CAPICOM","Impossivel fazer conex$$HEX1$$e300$$ENDHEX$$o com CAPICOM.DLL: Object Signer")
//Return
//End If
//
//TSigner2 = CREATE OLEObject
//If TSigner2.ConnectToNewObject("CAPICOM.Signer2") '<>' 0 Then
//MessageBox("CAPICOM","Impossivel fazer conex$$HEX1$$e300$$ENDHEX$$o com CAPICOM.DLL: Object Signer")
//Return
//End If
//
//TCertStore = CREATE OLEObject
//If TCertStore.ConnectToNewObject("CAPICOM.Store") '<>' 0 Then
//MessageBox("CAPICOM","Impossivel fazer conex$$HEX1$$e300$$ENDHEX$$o com CAPICOM.DLL: Object Store")
//Return
//End If
//
//TCertificate = CREATE OLEObject
//If TCertificate.ConnectToNewObject("CAPICOM.Certificate") '<>' 0 Then
//MessageBox("CAPICOM","Impossivel fazer conex$$HEX1$$e300$$ENDHEX$$o com CAPICOM.DLL: Object Certificate")
//Return
//End If
//
//TAttribute = CREATE OLEObject
//If TAttribute.ConnectToNewObject("CAPICOM.Attribute") '<>' 0 Then
//MessageBox("CAPICOM","Impossivel fazer conex$$HEX1$$e300$$ENDHEX$$o com CAPICOM.DLL:Object Attribute")
//Return
//End If
//
//TUtilities = CREATE OLEObject
//If TUtilities.ConnectToNewObject("CAPICOM.Utilities") '<>' 0 Then
//MessageBox("CAPICOM","Impossivel fazer conex$$HEX1$$e300$$ENDHEX$$o com CAPICOM.DLL: Object Utilities")
//Return
//End If
//
////If MessageBox() Then
//	Desatachado = True 
////Else 
////	Desatachado = False
////End If
//	
//TCertStore.open(CAPICOM_CURRENT_USER_STORE, 'My',CAPICOM_STORE_OPEN_READ_ONLY)
//
//
//
////oMessage = CREATE OLEObject
////If oMessage.ConnectToNewObject("CAPICOM.EncryptedData") '<>' 0 Then
////MessageBox("CAPICOM","Impossivel fazer conex$$HEX1$$e300$$ENDHEX$$o com CAPICOM.DLL")
////Return
////End If
//
////Tobeencrypted = 'ASDVRE' //mensagem a ser encripitada
//
////hidden = 'password' //SUA CHAVE
//
////oMessage.Content = Tobeencrypted
////oMessage.SetSecret(hidden)
////oMessage.Algorithm.Name = CAPICOM_ENCRYPTION_ALGORITHM_DES
////encryptedmessage = oMessage.Encrypt()
//
////If Len(encryptedmessage) '< 1 Then
////MessageBox("CAPICOM", "Menssagem n$$HEX1$$e300$$ENDHEX$$o foi encripitada")
////Else
////MessageBox("CAPICOM", " A mensagem encripitada $$HEX1$$e900$$ENDHEX$$ : " + encryptedmessage)
////li_FileNum = FileOpen("C:\SEU_ARQUIVO.txt",StreamMode!, Write!, LockWrite!, Replace!)
////FileWrite(li_FileNum,encryptedmessage)
////FileClose(li_FileNum)
////End If
//
//// DESTRUINDO O OBJETO
//
////oMessage.DisConnectObject()
////DESTROY oMessage
//
//
//////// === Decripitando ====================
////
////OLEObject oMessage
////
////string ls_Pswd_Input, hidden, encrypted
////
////integer li_FileNum
////
////// Conectando a CAPICOM.DLL
////
////oMessage = CREATE OLEObject
////IF oMessage.ConnectToNewObject("CAPICOM.EncryptedData") '<>' 0 THEN
////MessageBox("CAPICOM","Impossivel fazer conex$$HEX1$$e300$$ENDHEX$$o com CAPICOM.DLL")
////RETURN
////END IF
////
////li_FileNum = FileOpen("C:\SEU_ARQUIVO.txt", StreamMode!)
////FileRead(li_FileNum, ls_Pswd_Input)
////FileClose(li_FileNum)
////
////hidden='password' // SUA CHAVE
////
////MessageBox("CAPICOM", " A mensagem encripitada $$HEX1$$e900$$ENDHEX$$ : " + ls_Pswd_Input)
////
////IF Len(ls_Pswd_Input) >' 0 THEN
////oMessage.SetSecret(hidden)
////oMessage.Decrypt(ls_Pswd_Input)
////encrypted = oMessage.Content
////MessageBox("CAPICOM", " A mensagem decripitade $$HEX1$$e900$$ENDHEX$$ : " + encrypted)
////ELSE
////MessageBox("CAPICOM", "N$$HEX1$$e300$$ENDHEX$$oi existe mensagem para decripitar.")
////END IF
////
//////DESTRUINDO O OBJETO
////oMessage.DisConnectObject()
////DESTROY oMessage
////
//////========================================
////
////
////
return ''
end function

public function string of_gera_icms (string as_icms_type, datawindow dw_itens, long lvl_linha);String lvs_Dados

lvs_Dados = '<ICMS>'

Choose Case as_icms_Type
	Case '00'
		lvs_Dados += '<ICMS00>'
		lvs_Dados += '<orig>' + dw_itens.Object.icms_Orig[lvl_Linha] + '</orig>'
		lvs_Dados += '<CST>' + dw_itens.Object.icms_CST[lvl_Linha] + '</CST>'
		lvs_Dados += '<modBC>' + string(dw_itens.Object.icms_ModBC[lvl_Linha]) + '</modBC>'
		lvs_Dados += '<vBC>' + of_replace_numero(dw_itens.Object.icms_VBC[lvl_Linha],1) + '</vBC>'
		lvs_Dados += '<pICMS>' +  of_replace_numero(dw_itens.Object.icms_PICMS[lvl_Linha],1) + '</pICMS>'
		lvs_Dados += '<vICMS>' + of_replace_numero(dw_itens.Object.icms_VICMS[lvl_Linha],1) + '</vICMS>'
		lvs_Dados += '</ICMS00>'
	Case '10'
		lvs_Dados += '<ICMS10>'
		lvs_Dados += '<orig>' + dw_itens.Object.icms_Orig[lvl_Linha] + '</orig>'
		lvs_Dados += '<CST>' + dw_itens.Object.icms_CST[lvl_Linha] + '</CST>'
		lvs_Dados += '<modBC>' + string(dw_itens.Object.icms_ModBC[lvl_Linha]) + '</modBC>'
		lvs_Dados += '<vBC>' + of_replace_numero(dw_itens.Object.icms_VBC[lvl_Linha],1) + '</vBC>'
		lvs_Dados += '<pICMS>' +  of_replace_numero(dw_itens.Object.icms_PICMS[lvl_Linha],1) + '</pICMS>'
		lvs_Dados += '<vICMS>' + of_replace_numero(dw_itens.Object.icms_VICMS[lvl_Linha],1) + '</vICMS>'
		lvs_Dados += '<ModBCST>' + string(dw_itens.Object.icms_ModBCST[lvl_Linha]) + '</ModBCST>'
		lvs_Dados += '<PMVAST>' + of_replace_numero(dw_itens.Object.icms_PMVAST[lvl_Linha],1) + '</PMVAST>'
		lvs_Dados += '<PRedBCST>' + of_replace_numero(dw_itens.Object.icms_PRedBCST[lvl_Linha],1) + '</PRedBCST>'
		lvs_Dados += '<VBCST>' + of_replace_numero(dw_itens.Object.icms_VBCST[lvl_Linha],1) + '</VBCST>'
		lvs_Dados += '<PICMSST>' + of_replace_numero(dw_itens.Object.icms_PICMSST[lvl_Linha],1) + '</PICMSST>'
		lvs_Dados += '<VLICMSST>' + of_replace_numero(dw_itens.Object.icms_VLICMSST[lvl_Linha],1) + '</VLICMSST>'
	Case '20'
		lvs_Dados += '<ICMS20>'
		lvs_Dados += '<CST>' + dw_itens.Object.icms_CST[lvl_Linha] + '</CST>' 
		lvs_Dados += '<ModBC>' + string(dw_itens.Object.icms_ModBC[lvl_Linha]) + '</ModBC>' 
		lvs_Dados += '<PRedBC>' + of_replace_numero( dw_itens.Object.icms_PRedBC[lvl_Linha],1) + '</PRedBC>'  
		lvs_Dados += '<VBC>' + of_replace_numero(dw_itens.Object.icms_VBC[lvl_Linha],1) + '</VBC>'  
		lvs_Dados += '<PICMS>' + of_replace_numero(dw_itens.Object.icms_PICMS[lvl_Linha],1) + '</PICMS>'  
		lvs_Dados += '<VICMS>' + of_replace_numero(dw_itens.Object.icms_VICMS[lvl_Linha],1) + '</VICMS>'  		
	Case '30'
		lvs_Dados += '<ICMS30>'
		lvs_Dados += '<Orig>' + dw_Itens.Object.icms_Orig[lvl_Linha] + '</Orig>'  
		lvs_Dados += '<CST>' + dw_itens.Object.icms_CST[lvl_Linha] + '</CST>'  
		lvs_Dados += '<ModBCST>' + string(dw_itens.Object.icms_ModBCST[lvl_Linha]) + '</ModBCST>'  
		lvs_Dados += '<PMVAST>' + of_replace_numero(dw_itens.Object.icms_PMVAST[lvl_Linha],1) + '</PMVAST>' 
		lvs_Dados += '<PRedBCST>' + of_replace_numero(dw_itens.Object.icms_PRedBCST[lvl_Linha],1) + '</PRedBCST>'  
		lvs_Dados += '<VBCST>' +of_replace_numero(dw_itens.Object.icms_VBCST[lvl_Linha],1) + '</VBCST>'  
		lvs_Dados += '<PICMSST>' +of_replace_numero(dw_itens.Object.icms_PICMSST[lvl_Linha],1) + '</PICMSST>' 
		lvs_Dados += '<VLICMSST>' +of_replace_numero(dw_itens.Object.icms_VLICMSST[lvl_Linha],1) + '</VLICMSST>'  	
	Case '40'
		lvs_Dados += '<ICMS40>'
		lvs_Dados += '<Orig>' +dw_itens.Object.icms_Orig[lvl_Linha] + '</Orig>'  
		lvs_Dados += '<CST>' +dw_itens.Object.icms_CST[lvl_Linha] + '</CST>'  
	Case '50'
		lvs_Dados += '<ICMS50>'
		lvs_Dados += '<Orig>' +dw_Itens.Object.icms_Orig[lvl_Linha] + '</Orig>' 
		lvs_Dados += '<CST>' +dw_itens.Object.icms_CST[lvl_Linha] + '</CST>' 
	Case '60'
		lvs_Dados += '<ICMS60>'
		lvs_Dados += '<Orig>' +dw_Itens.Object.icms_Orig[lvl_Linha] + '</Orig>' 
		lvs_Dados += '<CST>' +dw_itens.Object.icms_CST[lvl_Linha] + '</CST>' 
		lvs_Dados += '<vBCSTRet>' +of_replace_numero(dw_itens.Object.icms_vBCSTRet[lvl_Linha],2) + '</vBCSTRet>' 
		lvs_Dados += '<vICMSSTRet>' +of_replace_numero(dw_itens.Object.icms_vICMSSTRet[lvl_Linha],2) + '</vICMSSTRet>' 
	Case '70'
		lvs_Dados += '<ICMS70>'
		lvs_Dados += '<Orig>' +dw_Itens.Object.icms_Orig[lvl_Linha] + '</Orig>' 
		lvs_Dados += '<CST>' +dw_itens.Object.icms_CST[lvl_Linha] + '</CST>' 
		lvs_Dados += '<ModBC>' +string(dw_itens.Object.icms_ModBC[lvl_Linha]) + '</ModBC>' 
		lvs_Dados += '<PRedBC>' +of_replace_numero(dw_itens.Object.icms_PRedBC[lvl_Linha],1) + '</PRedBC>'  
		lvs_Dados += '<VBC>' +of_replace_numero(dw_itens.Object.icms_VBC[lvl_Linha],1) + '</VBC>'  
		lvs_Dados += '<PICMS>' +of_replace_numero(dw_itens.Object.icms_PICMS[lvl_Linha],1) + '</PICMS>'  
		lvs_Dados += '<VICMS>' +of_replace_numero(dw_itens.Object.icms_VICMS[lvl_Linha],1) + '</VICMS>'  
		lvs_Dados += '<ModBCST>' +string(dw_itens.Object.icms_ModBCST[lvl_Linha]) + '</ModBCST>'  
		lvs_Dados += '<PMVAST>' +of_replace_numero(dw_itens.Object.icms_PMVAST[lvl_Linha],1) + '</PMVAST>'  
		lvs_Dados += '<PRedBCST>' +of_replace_numero(dw_itens.Object.icms_PRedBCST[lvl_Linha],1) + '</PRedBCST>'  
		lvs_Dados += '<VBCST>' +of_replace_numero(dw_itens.Object.icms_VBCST[lvl_Linha],1) + '</VBCST>'  
		lvs_Dados += '<PICMSST>' +of_replace_numero(dw_itens.Object.icms_PICMSST[lvl_Linha],1) + '</PICMSST>'  
		lvs_Dados += '<VLICMSST>' +of_replace_numero(dw_itens.Object.icms_VLICMSST[lvl_Linha],1) + '</VLICMSST>'  	
	Case '90'
		lvs_Dados += '<ICMS90>'
		lvs_Dados += '<Orig>' +dw_itens.Object.icms_Orig[lvl_Linha] + '</Orig>'  
		lvs_Dados += '<CST>' +dw_itens.Object.icms_CST[lvl_Linha] + '</CST>' 
		lvs_Dados += '<ModBC>' +string(dw_itens.Object.icms_ModBC[lvl_Linha]) + '</ModBC>'  
		lvs_Dados += '<PRedBC>' +of_replace_numero(dw_itens.Object.icms_PRedBC[lvl_Linha],1) + '</PRedBC>'  
		lvs_Dados += '<VBC>' +of_replace_numero(dw_itens.Object.icms_VBC[lvl_Linha],2) + '</VBC>'  
		lvs_Dados += '<PICMS>' +of_replace_numero(dw_itens.Object.icms_PICMS[lvl_Linha],2) + '</PICMS>'  
		lvs_Dados += '<VICMS>' +of_replace_numero(dw_itens.Object.icms_VICMS[lvl_Linha],2) + '</VICMS>'  
		lvs_Dados += '<ModBCST>' +string(dw_itens.Object.icms_ModBCST[lvl_Linha]) + '</ModBCST>'  
		lvs_Dados += '<PMVAST>' +of_replace_numero(dw_itens.Object.icms_PMVAST[lvl_Linha],1) + '</PMVAST>'  
		lvs_Dados += '<PRedBCST>' +of_replace_numero(dw_itens.Object.icms_PRedBCST[lvl_Linha],1) + '</PRedBCST>'  
		lvs_Dados += '<VBCST>' +of_replace_numero(dw_itens.Object.icms_VBCST[lvl_Linha],2) + '</VBCST>'  
		lvs_Dados += '<PICMSST>' +of_replace_numero(dw_itens.Object.icms_PICMSST[lvl_Linha],2) + '</PICMSST>'  
		lvs_Dados += '<VLICMSST>' +of_replace_numero(dw_itens.Object.icms_VLICMSST[lvl_Linha],2) + '</VLICMSST>' 
End Choose
		
lvs_Dados += '</ICMS>'

Return lvs_Dados
end function

public function string of_replace_ean (string as_ean);If Len(as_Ean) < 13 or isnull(as_ean)  Then
	Return ''
End If

Return as_ean
end function

public function string of_replace_inscricao_estadual (string as_inscricao);String lvs_Result

Long lvl_Pos

If Isnull(as_inscricao) Then Return ''

lvs_Result = gf_replace(as_inscricao,"(" ,"",0) 

lvs_Result = gf_replace(lvs_Result,")" ,"",0) 

lvs_Result = gf_replace(lvs_Result,"-" ,"",0) 

lvs_Result = gf_replace(lvs_Result,"/" ,"",0) 

lvs_Result = gf_replace(lvs_Result,"-" ,"",0) 

lvs_Result = gf_replace(lvs_Result," " ,"",0)

lvs_Result = gf_replace(lvs_Result,"." ,"",0)

Return lvs_result
		
		



end function

public function string of_replace_numero (double ad_valor, integer ai_tipo);String lvs_Result

Long lvl_Pos

lvl_Pos = Pos(string(ad_valor),",")
Choose Case ai_tipo
	Case 1
		If ad_valor = 0 or IsNull(ad_valor) Then
			lvs_Result = ""
		Else	
			If lvl_Pos >0 Then
				lvs_Result = gf_replace(string(ad_valor,"0.00"),",",".",0) 
			Else
				lvs_Result = gf_replace(string(ad_valor),",",".",0)
			End If
		End If
	Case 2
		If ad_valor = 0 or IsNull(ad_valor) Then
			lvs_Result = "0.00"
		Else
			If lvl_Pos >0 Then
				lvs_Result = gf_replace(string(ad_valor,"0.00"),",",".",0) 
			Else
				lvs_Result = gf_replace(string(ad_valor),",",".",0) 
			End If
		End If
	End Choose
Return lvs_Result



end function

public function string of_replace_telefone (string as_telefone);String lvs_Result

Long lvl_Pos

If Isnull(as_telefone) Then Return ''

lvs_Result = gf_replace(as_telefone,"(" ,"",0) 

lvs_Result = gf_replace(lvs_Result,")" ,"",0) 

lvs_Result = gf_replace(lvs_Result,"-" ,"",0) 

lvs_Result = gf_replace(lvs_Result," " ,"",0)

lvs_Result = gf_replace(lvs_Result,"." ,"",0)

// No caso de ter telefones inv$$HEX1$$e100$$ENDHEX$$lidos
If Len(lvs_Result) < 10 Then Return ''

Return lvs_result
		
		



end function

public function string of_retira_caracteres_especiais (string as_string);as_string = gf_replace(as_string, "$$HEX1$$c100$$ENDHEX$$", 'A', 0)
as_string = gf_replace(as_string, "$$HEX1$$c000$$ENDHEX$$", 'A', 0)
as_string = gf_replace(as_string, "$$HEX1$$c300$$ENDHEX$$", 'A', 0)
as_string = gf_replace(as_string, "$$HEX1$$c200$$ENDHEX$$", 'A', 0)
as_string = gf_replace(as_string, "$$HEX1$$c400$$ENDHEX$$", 'E', 0)
as_string = gf_replace(as_string, "$$HEX1$$c900$$ENDHEX$$", 'E', 0)
as_string = gf_replace(as_string, "$$HEX1$$c800$$ENDHEX$$", 'E', 0)
as_string = gf_replace(as_string, "$$HEX1$$ca00$$ENDHEX$$", 'E', 0)
as_string = gf_replace(as_string, "$$HEX1$$cb00$$ENDHEX$$", 'E', 0)
as_string = gf_replace(as_string, "$$HEX1$$cd00$$ENDHEX$$", 'I', 0)
as_string = gf_replace(as_string, "$$HEX1$$cc00$$ENDHEX$$", 'I', 0)
as_string = gf_replace(as_string, "$$HEX1$$ce00$$ENDHEX$$", 'I', 0)
as_string = gf_replace(as_string, "$$HEX1$$cf00$$ENDHEX$$", 'I', 0)
as_string = gf_replace(as_string, "$$HEX1$$d300$$ENDHEX$$", 'O', 0)
as_string = gf_replace(as_string, "$$HEX1$$d200$$ENDHEX$$", 'O', 0)
as_string = gf_replace(as_string, "$$HEX1$$d400$$ENDHEX$$", 'O', 0)
as_string = gf_replace(as_string, "$$HEX1$$d500$$ENDHEX$$", 'O', 0)
as_string = gf_replace(as_string, "$$HEX1$$d600$$ENDHEX$$", 'O', 0)
as_string = gf_replace(as_string, "$$HEX1$$da00$$ENDHEX$$", 'U', 0)
as_string = gf_replace(as_string, "$$HEX1$$d900$$ENDHEX$$", 'U', 0)
as_string = gf_replace(as_string, "$$HEX1$$db00$$ENDHEX$$", 'U', 0)
as_string = gf_replace(as_string, "$$HEX1$$dc00$$ENDHEX$$", 'U', 0)
as_string = gf_replace(as_string, "$$HEX1$$d100$$ENDHEX$$", 'N', 0)
as_string = gf_replace(as_string, "$$HEX1$$dd00$$ENDHEX$$", 'Y', 0)

Return as_String
end function

public subroutine of_gerar_xml_rodape ();
end subroutine

public function string of_gera_pis (string type_pis, datawindow dw_itens, long lvl_linha);String lvs_Dados

lvs_Dados = '<PIS>'
		
		Choose Case Type_Pis
			Case 'PISAliq'
				lvs_Dados += '<PISAliq>'
				lvs_Dados += '<CST>' + dw_itens.Object.pis_CST[lvl_Linha] + '</CST>'
				lvs_Dados += '<vBC>' + dw_itens.Object.pis_VBC[lvl_Linha] + '</vBC>'
				lvs_Dados += '<pPIS>' + dw_itens.Object.pis_PPIS[lvl_Linha] + '</pPIS>'
				lvs_Dados += '</PISAliq>'
			Case 'PISQtde'
				lvs_Dados += '<PISQtde>'
				lvs_Dados += '<CST>' + dw_itens.Object.pis_CST[lvl_Linha] + '</CST>'
				lvs_Dados += '<qBCProd>' + dw_itens.Object.pis_QBCProd[lvl_Linha] + '</qBCProd>'
				lvs_Dados += '<vAliqProd>' + dw_itens.Object.pis_VAliqProd[lvl_Linha] + '</vAliqProd>'
				lvs_Dados += '<vPIS>' + dw_itens.Object.pis_VPIS[lvl_Linha] + '</vPIS>'
				lvs_Dados += '</PISQtde>'
			Case 'PISNT'
				lvs_Dados += '<PISNT>'
				lvs_Dados += '<CST>' + dw_itens.Object.pis_CST[lvl_Linha] + '</CST>'
				lvs_Dados += '</PISNT>'
			Case 'PISOutr'
				lvs_Dados += '<PISOutr>'
				lvs_Dados += '<CST>' + dw_itens.Object.pis_CST[lvl_Linha] + '</CST>'
				lvs_Dados += '<vBC>' + dw_itens.Object.pis_VBC[lvl_Linha] + '</vBC>'
				lvs_Dados += '<pPIS>' + dw_itens.Object.pis_PPIS[lvl_Linha] + '</pPIS>'
				lvs_Dados += '<qBCProd>' +  dw_itens.Object.pis_QBCProd[lvl_Linha] + '</qBCProd>'
				lvs_Dados += '<vAliqProd>' + dw_itens.Object.pis_VAliqProd[lvl_Linha] + '</vAliqProd>'
				lvs_Dados += '<vPIS>' +  dw_itens.Object.pis_VPIS[lvl_Linha] + '</vPIS>'
				lvs_Dados += '</PISOutr>'
			Case 'PISST'
				lvs_Dados += '<PISST>'
				lvs_Dados += '<vBC>' + dw_itens.Object.pis_VBC[lvl_Linha] + '</vBC>'
				lvs_Dados += '<pPIS>' + dw_itens.Object.pis_PPIS[lvl_Linha] + '</pPIS>'
				lvs_Dados += '<qBCProd>' +  dw_itens.Object.pis_QBCProd[lvl_Linha] + '</qBCProd>'
				lvs_Dados += '<vAliqProd>' + dw_itens.Object.pis_VAliqProd[lvl_Linha] + '</vAliqProd>'
				lvs_Dados += '<vPIS>' +  dw_itens.Object.pis_VPIS[lvl_Linha] + '</vPIS>'
				lvs_Dados += '</PISST>'
		End Choose
		lvs_Dados += '</PIS>'

Return lvs_Dados
end function

public function string of_assinatura (string as_documento);String lvs_Assinatura		,&
          lvs_Binary_String

OLEObject	CertStore		,&
				Certificado		,&
				Atributo			,&
				Assinante		,&
				SignedData		,&
				Util				

Boolean Desatachado = True
//String TobeEncrypted ,hidden, filename, encryptedmessage, decrypted

CertStore = CREATE OLEObject
If CertStore.ConnectToNewObject("CAPICOM.Store.3") <> 0 Then
	MessageBox("CAPICOM","Impossivel fazer conex$$HEX1$$e300$$ENDHEX$$o com CAPICOM.DLL: Object CertStore")
	Return ''
End If

Certificado = CREATE OLEObject
If Certificado.ConnectToNewObject("CAPICOM.Certificate.2") <> 0 Then
	MessageBox("CAPICOM","Impossivel fazer conex$$HEX1$$e300$$ENDHEX$$o com CAPICOM.DLL: Object Certificate.2")
	Return ''
End If

Atributo = CREATE OLEObject
If Atributo.ConnectToNewObject("CAPICOM.Attribute") <> 0 Then
	MessageBox("CAPICOM","Impossivel fazer conex$$HEX1$$e300$$ENDHEX$$o com CAPICOM.DLL: Object Attribute")
	Return ''
End If

Assinante = CREATE OLEObject
If Assinante.ConnectToNewObject("CAPICOM.Signer.2") <> 0 Then
	MessageBox("CAPICOM","Impossivel fazer conex$$HEX1$$e300$$ENDHEX$$o com CAPICOM.DLL: Object Signer.2")
	Return ''
End If

SignedData = CREATE OLEObject
If SignedData.ConnectToNewObject("CAPICOM.SignedData") <> 0 Then
	MessageBox("CAPICOM","Impossivel fazer conex$$HEX1$$e300$$ENDHEX$$o com CAPICOM.DLL: Object SignedData")
	Return ''
End If

Util = CREATE OLEObject
If Util.ConnectToNewObject("CAPICOM.Utilities") <> 0 Then
	MessageBox("CAPICOM","Impossivel fazer conex$$HEX1$$e300$$ENDHEX$$o com CAPICOM.DLL: Object Utilities")
	Return ''
End If

CertStore.open(CAPICOM_CURRENT_USER_STORE, 'My',CAPICOM_STORE_OPEN_READ_ONLY)

if  CertStore.Certificates.Count = 0 then
	MessageBox("CAPICOM"," TCertStore.Certificates.Count")
	Return ''
end if	

Certificado = CertStore.Certificates[1]
Assinante.Certificate = Certificado

//Util.Base64Encode()
//
//Utilities.Base64Encode( _
//  ByVal SrcString _
//)


Assinante.Options    = 1
SignedData.Content = as_documento
Atributo.Name = CAPICOM_AUTHENTICATED_ATTRIBUTE_SIGNING_TIME
Atributo.Value = Now()
//Assinante.AuthenticateAttributes.add(Atributo)
//Atributo.Value = ExtractFileName(odlgCertificado.FileName)

lvs_Assinatura 		= SignedData.Sign(Assinante, True, CAPICOM_ENCODE_BINARY)
//lvs_Binary_String	= Util.BinaryStringToByteArray(Assinante)

Return lvs_Assinatura
end function

public function string of_hash (string as_dados);String lvs_Hash		,&
          Dados

OLEObject	HashedData		

Int AlgoHash
				
HashedData = CREATE OLEObject
If HashedData.ConnectToNewObject("CAPICOM.HashedData") <> 0 Then
	MessageBox("CAPICOM","Impossivel fazer conex$$HEX1$$e300$$ENDHEX$$o com CAPICOM.DLL: Object HashedData")
	Return ''
End If

HashedData.Algorithm(AlgoHash)
HashedData.Hash(as_dados)
 
 lvs_Hash = HashedData.Value

return lvs_Hash

end function

public function string of_x509certificate ();String lvs_Hash		,&
          Dados

OLEObject	x509Certificate	

Int AlgoHash
				
x509Certificate = CREATE OLEObject
If x509Certificate.ConnectToNewObject("System.Security.Cryptography.X509Certificates.X509Certificate") <> 0 Then
	MessageBox("System","Impossivel fazer conex$$HEX1$$e300$$ENDHEX$$o com System.DLL: Object x509Certificate")
	Return ''
End If

//x509Certificate.Open()

//x509Certificate.Close()

return lvs_Hash



end function

public subroutine of_pbdom ();//PBDOM_ATTRIBUTE					ATTRIBUTE_NODE					Attribute
//PBDOM_BUILDER						None									DOMBuilder
//PBDOM_CDATA							CDATA_SECTION_NODE			CDATA
//PBDOM_CHARACTERDATA			CHARACTER_DATA_NODE		None
//PBDOM_COMMENT					COMMENT_NODE					Comment
//PBDOM_DOCUMENT					DOCUMENT_NODE					Document
//PBDOM_DOCTYPE						DOCUMENT_TYPE_NODE			DocType
//PBDOM_ELEMENT						ELEMENT_NODE					Element
//PBDOM_ENTITYREFERENCE			ENTITY_REFERENCE_NODE		EntityRef
//PBDOM_OBJECT						NODE									None
//PBDOM_PROCESSINGINSTURCTION	PROCESSING_INSTRUCTION_NODE	Processinginstruction
//PBDOM_TEXT							TEXT_NODE							Text


end subroutine

public function string of_gera_xml_completo ();String lvs_xml

Integer lvi_Arquivo

//of_gerar_xml_cabecalho(lvl_Nr_Nf, lvs_Especie, lvs_Serie, lvl_Filial)
//lvs_xml = of_gerar_xml_dados(lvl_Nr_Nf, lvs_Especie, lvs_Serie, lvl_Filial)
//lvs_xml += of_gera_icms()
//lvs_xml += of_gerar_xml_totais()






return lvs_xml
end function

public function string of_gerar_xml_dados (long al_nr_nf, string as_especie, string as_serie, long al_filial);String lvs_Dados		,&
		 lvs_NCM			,&
          Icms_Type		,&
		 Type_Pis

Long lvl_Linha		,&
        lvl_Linhas

dc_uo_dw_base dw_itens

lvl_Linhas = dw_Itens.Retrieve(al_Nr_nf, as_Especie, as_Serie, al_Filial)

If lvl_Linhas > 0 Then
	For lvl_Linha = 1 To lvl_Linhas		
		If lvl_Linhas > 0 Then					
			If Isnull(string(dw_itens.Object.prod_NCM[lvl_Linha])) or string(dw_itens.Object.prod_NCM[lvl_Linha]) = '99' Then
				lvs_NCM = '99'
			Else
				If string(dw_itens.Object.prod_NCM[lvl_Linha]) <> '99' Then
					lvs_NCM = string(dw_itens.Object.prod_NCM[lvl_Linha], '00000000')
				End If
			End If
			lvs_Dados = '<det nItem="' + String(lvl_Linha) + '">'
			lvs_Dados += '<prod>'
			lvs_Dados += '<cProd> + string(dw_itens.Object.prod_CProd[lvl_Linha]) + </cProd>'
			If IsNull(of_replace_ean(dw_itens.Object.prod_CEAN[lvl_Linha])) or of_replace_ean(dw_itens.Object.prod_CEAN[lvl_Linha]) = '' Then
				lvs_Dados += '<cEAN />'
			Else		
				lvs_Dados += '<cEAN>' + of_replace_ean(dw_itens.Object.prod_CEAN[lvl_Linha]) + '<cEAN />'
			End If
			lvs_Dados += '<xProd>' + dw_itens.Object.prod_XProd[lvl_Linha] + '</xProd>'
			lvs_Dados += '<CFOP>' + string(dw_itens.Object.prod_CFOP[lvl_Linha]) + '</CFOP>'
			lvs_Dados += '<uCom>' + dw_itens.Object.prod_UCom[lvl_Linha] + '</uCom>'
			lvs_Dados += '<qCom>' + of_replace_numero(dw_itens.Object.prod_QCom[lvl_Linha],1) + '</qCom>'
			lvs_Dados += '<vUnCom>' + of_replace_numero(dw_itens.Object.prod_VUnCom[lvl_Linha],1) + '</vUnCom>'
			lvs_Dados += '<vProd>' + of_replace_numero(dw_itens.Object.prod_VProd[lvl_Linha],1) + '</vProd>'
			If IsNull(of_replace_ean(dw_itens.Object.prod_CEANTrib[lvl_Linha])) or of_replace_ean(dw_itens.Object.prod_CEANTrib[lvl_Linha]) = '' Then
				lvs_Dados += '<cEANTrib />'
			Else
				lvs_Dados += '<cEANTrib>' + of_replace_ean(dw_itens.Object.prod_CEANTrib[lvl_Linha]) + '</cEANTrib>'
			End If
			lvs_Dados += '<uTrib>' + dw_itens.Object.prod_UTrib[lvl_linha] + '</uTrib>'
			lvs_Dados += '<qTrib>' + of_replace_numero(dw_itens.Object.prod_QTrib[lvl_Linha],1) + '</qTrib>'
			lvs_Dados += '<vUnTrib>' + of_replace_numero(dw_itens.Object.prod_VUnTrib[lvl_Linha],1) + '</vUnTrib></prod><imposto>'
		End If				
		lvs_Dados += of_gera_icms(dw_itens.Object.icms_CST[lvl_linha], dw_Itens, lvl_linha)
		
		//fu$$HEX2$$e700e300$$ENDHEX$$o procurar tipo de pis********************************************
		lvs_Dados += of_gera_pis("", dw_Itens, lvl_linha)
		
		lvs_Dados += '<COFINS>'
		lvs_Dados += '<COFINSAliq>'
		lvs_Dados += '<CST>' + + '</CST>'
		lvs_Dados += '<vBC>' + + '</vBC>'
		lvs_Dados += '<pCOFINS>' + + '</pCOFINS>'
		lvs_Dados += '<vCOFINS>' + + '</vCOFINS>'
		lvs_Dados += '</COFINSAliq>'
		lvs_Dados += '</COFINS>'
		lvs_Dados += '</imposto>'
		lvs_Dados += '</det>'	
	Next
Else
//	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', "O itens da nota fiscal '" + String(al_nr_nf) + "' n$$HEX1$$e300$$ENDHEX$$o foram localizados.")
	destroy(dw_itens)
//	Return False
End If
destroy(dw_itens)

//lvs_Dados = wf_retira_caracteres_especiais(lvs_Dados)

//If Isnull(lvs_Txt) or lvs_TXT = "" Then
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao gerar cabe$$HEX1$$e700$$ENDHEX$$alho da nota fiscal '" + string(dw_nfe.Object.ide_nNF[al_linha]) + "' para o arquivo do SEFAZ.", StopSign!)
//	Return False
//End If
return lvs_Dados
end function

public function string of_gerar_xml_totais (long al_nr_nf, string as_especie, string as_serie, integer ai_filial);String lvs_Totais



lvs_Totais =  '<total>'
lvs_Totais += '<ICMSTot>'
//  '<vBC>' + wf_replace_numero(dw_nfe.Object.total_vbc[al_linha],2) + '</vBC>' 
//  '<vICMS> + wf_replace_numero(dw_nfe.Object.total_VICMS[al_linha],2) + </vICMS> 
//  '<vBCST> + wf_replace_numero(dw_nfe.Object.total_VBCST[al_linha],2) + </vBCST> 
//  '<vST> + wf_replace_numero(dw_nfe.Object.total_VST[al_linha],2) + </vST> 
//  '<vProd> + wf_replace_numero(dw_nfe.Object.total_VProd[al_linha],2) + </vProd> 
//  '<vFrete> + wf_replace_numero(dw_nfe.Object.total_VFrete[al_linha],2) + </vFrete> 
//  '<vSeg> + wf_replace_numero(dw_nfe.Object.total_VSeg[al_linha],2) + </vSeg> 
//  '<vDesc> +  wf_replace_numero(dw_nfe.Object.total_VDesc[al_linha],2) + </vDesc> 
//  '<vII> + wf_replace_numero(dw_nfe.Object.total_vii[al_linha],2) + </vII> 
//  '<vIPI> + wf_replace_numero(dw_nfe.Object.total_VIPI[al_linha],2) + </vIPI> 
//  '<vPIS> + wf_replace_numero(dw_nfe.Object.total_VPIS[al_linha],2) + </vPIS> 
//  '<vCOFINS> + wf_replace_numero(dw_nfe.Object.total_VCOFINS[al_linha],2) + </vCOFINS> 
//  '<vOutro> + wf_replace_numero(dw_nfe.Object.total_VOutro[al_linha],2) + </vOutro> 
//  '<vNF> + wf_replace_numero( dw_nfe.Object.total_VNF[al_linha],2) + </vNF> 
//  '</ICMSTot>
//  '</total>
//- '<transp>
//  '<modFrete>0</modFrete> 
//  '</transp>
//- '<infAdic>
//  <infCpl>DIFER. ART8$$HEX1$$ba00$$ENDHEX$$ ITEM III ANEXO 3 RICMS/SC01</infCpl> 
//  </infAdic>
//  </infNFe>
//- <Signature xmlns="http://www.w3.org/2000/09/xmldsig#">
//- <SignedInfo>
//  <CanonicalizationMethod Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315" /> 
//  <SignatureMethod Algorithm="http://www.w3.org/2000/09/xmldsig#rsa-sha1" /> 
//- <Reference URI="#NFe42100984683481000177550050000737301000000017">
//- <Transforms>

////	lvs_Txt =  lvs_Txt + "W17|" +  dw_nfe.Object.total_VServ[al_linha] + "|" +  dw_nfe.Object.total_VBC[al_linha] + "|" +  dw_nfe.Object.total_VISS[al_linha] + "|" +  dw_nfe.Object.total_VPIS[al_linha] + "|" +  dw_nfe.Object.total_VCOFINS[al_linha] + "|" + BR
////End If
////lvs_Txt =  lvs_Txt + "W23|" +  wf_replace_numero(dw_nfe.Object.total_VRetPIS[al_linha]) + "|" + wf_replace_numero( dw_nfe.Object.total_VRetCOFINS[al_linha]) +"|" +  wf_replace_numero(dw_nfe.Object.total_VRetCSLL[al_linha]) + "|" +  wf_replace_numero(dw_nfe.Object.VBCIRRF[al_linha]) + "|" + wf_replace_numero(dw_nfe.Object.total_VIRRF[al_linha]) + "|" +  wf_replace_numero(dw_nfe.Object.total_VBCRetPrev[al_linha]) + "|" +  wf_replace_numero(dw_nfe.Object.total_VRetPrev[al_linha]) + "|" + BR
//lvs_Txt =  lvs_Txt + "X|0|" + BR
////lvs_Txt =  lvs_Txt + "X03|" +  wf_replace_numero(dw_nfe.Object.total_XNome[al_linha]) + "|" +  wf_replace_numero(dw_nfe.Object.total_IE[al_linha]) + "|" +  wf_replace_numero(dw_nfe.Object.total_XEnder[al_linha]) + "|" +  wf_replace_numero(dw_nfe.Object.total_UF) + "|" + wf_replace_numero(dw_nfe.Object.total_XMun) + "|" + BR
//
////lvs_Txt =  lvs_Txt + "X09|" + BR
////If
////	"X04|" +  dw_nfe.Object.CNPJ[al_linha] + "|" + BR
////Else
////	"X05|" +  dw_nfe.total_Object.CPF[al_linha] + "|" + BR
////End If
////
////If
////	"X11|" +  dw_nfe.Object.total_VServ[al_linha] + "|" +  dw_nfe.Object.total_VBCRet[al_linha] + "|" +  dw_nfe.Object.total_PICMSRet"|"VICMSRet"|"CFOP"|"CMunFG"|" + BR
////End If
////
////[0 ou 1]{ + BR
////"X18|" +  dw_nfe.Object.Placa[al_linha] "|" +  dw_nfe.Object.UF[al_linha] + "|" +  dw_nfe.Object.RNTC[al_linha] "|" + BR
////} + BR
////[0 a 2]{ + BR
////"X22|" +  dw_nfe.Object.Placa[al_linha] + "|" +  dw_nfe.Object.UF[al_linha] + "|" +  dw_nfe.Object.RNTC[al_linha] + "|" + BR
////} + BR
////Vers$$HEX1$$e300$$ENDHEX$$o 1.1.1 - (29/10/2008) P$$HEX1$$e100$$ENDHEX$$gina 11 de 32 + BR
////[0 a N]{ + BR
////"X26|" +  dw_nfe.Object.QVol[al_linha] + "|" +  dw_nfe.Object.Esp[al_linha] + "|" +  dw_nfe.Object.Marca[al_linha] + "|"  +  dw_nfe.Object.NVol[al_linha] + "|" +  dw_nfe.Object.PesoL[al_linha] + "|" +  dw_nfe.Object.PesoB[al_linha] + "|" + BR
////[0 a N]{ + BR
////X33"|" +  dw_nfe.Object.NLacre[al_linha] + "|" + BR
////} + BR
////} + BR
////
//
////If
////	[0 ou 1]{ + BR
////	"Y|" + BR
////End If
////
////If
////	"Y02|" +  dw_nfe.Object.NFat[al_linha] + "|" +  dw_nfe.Object.VOrig[al_linha] + "|" +  dw_nfe.Object.VDesc[al_linha] + "|" +  dw_nfe.Object.VLiq[al_linha] + "|" + BR
////Enf If
////
////
////[0 a N]{ + BR
////"Y07|"+  dw_nfe.Object.NDup[al_linha] + "|" +  dw_nfe.Object.DVenc[al_linha] + "|" +  dw_nfe.Object.VDup[al_linha] + "|" + BR
////} + BR
////
//
//If 	Trim(as_informacoes) <> "" or &
//	Not Isnull(as_informacoes)  or &
//	Trim(as_informacoes_adicionais) <> "" or &
//	Not Isnull(as_informacoes_adicionais)  Then
//	//"Z|" + as_informacoes + "|" +  dw_nfe.Object.InfCpl[al_linha] + "|" + BR
//	lvs_Txt =  lvs_Txt + "Z|" + as_informacoes +"|" + as_informacoes_adicionais + "|" + BR
////	If
////		For i= 1 To 10
////			[0 a 10]{ + BR
////			"Z04|" +  dw_nfe.Object.XCampo[al_linha] + "|" +  dw_nfe.Object.XTexto[al_linha] + "|" + BR
////		Next
////	End If	
////
////	[0 a N]{ + BR
////	"Z10|" +  dw_nfe.Object.NProc[al_linha] + "|" +  dw_nfe.Object.IndProc[al_linha] + "|" + BR
//End If
//
//
////
////If 
////"ZA|" +  dw_nfe.Object.UFEmbarq[al_linha] + "|" +  dw_nfe.Object.XLocEmbarq[al_linha] + "|" + BR
////End If
////If 
////"ZB|" +  dw_nfe.Object.XNEmp[al_linha] + "|" +  dw_nfe.Object.XPed[al_linha] "|" +  dw_nfe.Object.XCont[al_linha] + "|" + BR
////End If
//
//lvs_Txt = wf_retira_caracteres_especiais(lvs_Txt)
//
//wf_Grava_Arquivo(ai_Arquivo, lvs_TXt)	
//





//  <Transform Algorithm="http://www.w3.org/2000/09/xmldsig#enveloped-signature" /> 
//  <Transform Algorithm="http://www.w3.org/TR/2001/REC-xml-c14n-20010315" /> 
//  </Transforms>
//  <DigestMethod Algorithm="http://www.w3.org/2000/09/xmldsig#sha1" /> 
//  <DigestValue>ZaMXrpXxus4DXWSa07EO0ypVwpE=</DigestValue> 
//  </Reference>
//  </SignedInfo>
//  <SignatureValue>pA6n29VAGT/2ZKrmQJ5MHYHh954eiqdF1zSxjdjdyDzG6t6IiNJkpl0Lmy+DHlF+qiOmVPgma62c ytJwtR9o7M56tW/JctJPnkH0y2eB56aaESvKQjmmq9oyvy/FA2jDhYFxuage7YOg3cHCbG1Yz/1a pqeEaocTDJwESWpgSWI=</SignatureValue> 
//- <KeyInfo>
//- <X509Data>
//  <X509Certificate>MIIGPzCCBSegAwIBAgIIFxK3VIalx7owDQYJKoZIhvcNAQEFBQAwTDELMAkGA1UEBhMCQlIxEzAR BgNVBAoTCklDUC1CcmFzaWwxKDAmBgNVBAMTH1NFUkFTQSBDZXJ0aWZpY2Fkb3JhIERpZ2l0YWwg djEwHhcNMTAwODE3MTkwOTUzWhcNMTEwODE3MTkwOTUzWjCB7zELMAkGA1UEBhMCQlIxEzARBgNV BAoTCklDUC1CcmFzaWwxFDASBgNVBAsTCyhFTSBCUkFOQ08pMRgwFgYDVQQLEw8wMDAwMDEwMDEz NTMzODcxFDASBgNVBAsTCyhFTSBCUkFOQ08pMRQwEgYDVQQLEwsoRU0gQlJBTkNPKTEUMBIGA1UE CxMLKEVNIEJSQU5DTykxFDASBgNVBAsTCyhFTSBCUkFOQ08pMRQwEgYDVQQLEwsoRU0gQlJBTkNP KTEtMCsGA1UEAxMkQ0lBIExBVElOTyBBTUVSSUNBTkEgREUgTUVESUNBTUVOVE9TMIGfMA0GCSqG SIb3DQEBAQUAA4GNADCBiQKBgQDR6pjilX6dIcFXiy25YbSmoGdLjwSTmOrlcBVd5rZ28xhy92Au RhFzNufH+KDy4r6U/6QSk1nut7GMKcozJe0ipV/Cw5jpqZETeNPUfy46lvprKC7rfbSbNZijPODE oEOT5DS769oCrixK6qcpWeqrU0yyYPDSexvznqbMFXuhtwIDAQABo4IDAzCCAv8wDgYDVR0PAQH/ BAQDAgXgMB0GA1UdJQQWMBQGCCsGAQUFBwMCBggrBgEFBQcDBDAfBgNVHSMEGDAWgBS3YKhb+bKm rgDtdOvVSsmWaGb1XDCBxgYDVR0RBIG+MIG7gSdDT05UQUJJTElEQURFQENJQUxBVElOT0FNRVJJ Q0FOQS5DT00uQlKgOAYFYEwBAwSgLxMtMjcxMTE5NjE0ODYyNDc5OTk1MzAwMDAwMDAwMDAwMDAw MDAwMDAwMDAwMDAwoCIGBWBMAQMCoBkTF1NPTklBIEJSRVNDSUFOSSBNQVJJQU5PoBkGBWBMAQMD oBATDjg0NjgzNDgxMDAwMTc3oBcGBWBMAQMHoA4TDDAwMDAwMDAwMDAwMDBXBgNVHSAEUDBOMEwG BmBMAQIBBjBCMEAGCCsGAQUFBwIBFjRodHRwOi8vd3d3LmNlcnRpZmljYWRvZGlnaXRhbC5jb20u YnIvcmVwb3NpdG9yaW8vZHBjMIHwBgNVHR8EgegwgeUwSaBHoEWGQ2h0dHA6Ly93d3cuY2VydGlm aWNhZG9kaWdpdGFsLmNvbS5ici9yZXBvc2l0b3Jpby9sY3Ivc2VyYXNhY2R2MS5jcmwwQ6BBoD+G PWh0dHA6Ly9sY3IuY2VydGlmaWNhZG9zLmNvbS5ici9yZXBvc2l0b3Jpby9sY3Ivc2VyYXNhY2R2 MS5jcmwwU6BRoE+GTWh0dHA6Ly9yZXBvc2l0b3Jpby5pY3BicmFzaWwuZ292LmJyL2xjci9TZXJh c2EvcmVwb3NpdG9yaW8vbGNyL3NlcmFzYWNkdjEuY3JsMIGXBggrBgEFBQcBAQSBijCBhzBHBggr BgEFBQcwAoY7aHR0cDovL3d3dy5jZXJ0aWZpY2Fkb2RpZ2l0YWwuY29tLmJyL2NhZGVpYXMvc2Vy YXNhY2R2MS5wN2IwPAYIKwYBBQUHMAGGMGh0dHA6Ly9vY3NwLmNlcnRpZmljYWRvZGlnaXRhbC5j b20uYnIvc2VyYXNhY2R2MTANBgkqhkiG9w0BAQUFAAOCAQEAl8Z7UOEw0sydJqUmTX0EuL99is35 U+rtUw+8mBX0pR4KYoaZDz5vh3YRao6Qd5FYKhJbWA08mDMzjqaM7Uoh5tOgtrEOisICMQK35nSa oNy4r9Go6/s/OcWTjyYUxo2+aiR5cJ1QZnKa52RxDPajQlVqaPsv2qCo4wPje2bwRBdTmkU0zmhu UzJw1dwfS1lEMA8NO2+/6T2Ix3vYFWt6iBODiNkiT7OtxH6BoSSj/XvKrRaYB9jnreRPsbPwMn02 e19h7pI/WqeqOKjo+gi9TSOnhqO1K72JAEkQZFcZSFWwwPzbaVByeSh0zsWO8AR6S9dwHKfJ7hgi PQkYnihUmw==</X509Certificate> 
//  </X509Data>
//  </KeyInfo>
//  </Signature>
//  </NFe>
//- <protNFe versao="2.00">
//- <infProt Id="ID342100001179594">
//  <tpAmb>2</tpAmb> 
//  <verAplic>SVRS20100923173711</verAplic> 
//  <chNFe>42100984683481000177550050000737301000000017</chNFe> 
//  <dhRecbto>2010-09-27T10:28:19</dhRecbto> 
//  <nProt>342100001179594</nProt> 
//  <digVal>ZaMXrpXxus4DXWSa07EO0ypVwpE=</digVal> 
//  <cStat>100</cStat> 
//  <xMotivo>Autorizado o uso da NF-e</xMotivo> 
//  </infProt>
//  </protNFe>
//  </nfeProc>







Return ''
end function

public function string of_assina_xml ();String lvs_Assinatura		,&
          lvs_Binary_String	,&
		 Xml_Assinado		,&	 
		 lvs_Mensagem		,&
		 Cert = "CN=CIA LATINO AMERICANA DE MEDICAMENTOS, OU=(EM BRANCO), OU=(EM BRANCO), OU=(EM BRANCO), OU=(EM BRANCO), OU=(EM BRANCO), OU=000001001353387, OU=(EM BRANCO), O=ICP-Brasil, C=BR"

OLEObject	CertStore		,&
				Certificado		,&
				Atributo			,&
				Assinante		,&
				SignedData		,&
				Util				

OLEObject	XMLDoc2			,&
				XMLDSig			,&
				dsigKey			,&
				signedKey		,&
				nodePai			,&
				nodeX509Data 	,&
				nodeIrmao		,&
				SignedDocument

Boolean Desatachado = True

Integer teste

Util = CREATE OLEObject
If Util.ConnectToNewObject("NFe_Util_Interface") <> 0 Then
	MessageBox("CAPICOM","Impossivel fazer conex$$HEX1$$e300$$ENDHEX$$o com CAPICOM.DLL: Object CertStore")
	Return ''
End If

//Classes para certificados
CertStore = CREATE OLEObject
If CertStore.ConnectToNewObject("CAPICOM.Store.3") <> 0 Then
	MessageBox("CAPICOM","Impossivel fazer conex$$HEX1$$e300$$ENDHEX$$o com CAPICOM.DLL: Object CertStore")
	Return ''
End If

Certificado = CREATE OLEObject
If Certificado.ConnectToNewObject("CAPICOM.Certificate.2") <> 0 Then
	MessageBox("CAPICOM","Impossivel fazer conex$$HEX1$$e300$$ENDHEX$$o com CAPICOM.DLL: Object Certificate.2")
	Return ''
End If

Atributo = CREATE OLEObject
If Atributo.ConnectToNewObject("CAPICOM.Attribute") <> 0 Then
	MessageBox("CAPICOM","Impossivel fazer conex$$HEX1$$e300$$ENDHEX$$o com CAPICOM.DLL: Object Attribute")
	Return ''
End If

Assinante = CREATE OLEObject
If Assinante.ConnectToNewObject("CAPICOM.Signer.2") <> 0 Then
	MessageBox("CAPICOM","Impossivel fazer conex$$HEX1$$e300$$ENDHEX$$o com CAPICOM.DLL: Object Signer.2")
	Return ''
End If

SignedData = CREATE OLEObject
If SignedData.ConnectToNewObject("CAPICOM.SignedData") <> 0 Then
	MessageBox("CAPICOM","Impossivel fazer conex$$HEX1$$e300$$ENDHEX$$o com CAPICOM.DLL: Object SignedData")
	Return ''
End If


/*0: ref := 'infNFe';
          1: ref := 'infCanc';
          2: ref := 'infInut';*/
			 
//teste = 
//Assinar('<a>aaa</a>', 'infNFe', Cert, xml_Assinado,  lvs_Mensagem)
 //Util.Assinar(xmlDoc, ref       , nome, xmlAssinado, mensagem);
//Classes para XML******************************************************
//Util = CREATE OLEObject
//If Util.ConnectToNewObject("nfe_util.TUtil") <> 0 Then
//	MessageBox("CAPICOM","Impossivel fazer conex$$HEX1$$e300$$ENDHEX$$o com CAPICOM.DLL: Object Utilities")
//	//Return ''
//End If

Util = CREATE OLEObject
If Util.ConnectToNewObject("System.Security.Cryptography.Xml.KeyInfo") <> 0 Then
	MessageBox("CAPICOM","Impossivel fazer conex$$HEX1$$e300$$ENDHEX$$o com CAPICOM.DLL: Object Utilities")
	//Return ''
End If

XMLDSig = CREATE OLEObject
If XMLDSig.ConnectToNewObject("msxml2.MxDigitalSignature.5.0") <> 0 Then   //System.Xml.XmlDocument
	MessageBox("CAPICOM","Impossivel fazer conex$$HEX1$$e300$$ENDHEX$$o com CAPICOM.DLL: Object IXMLDigitalSignature")
	//Return ''
End If

//XMLDoc = CREATE OLEObject
//If XMLDoc.ConnectToNewObject("System.Xml.XmlDocument") <> 0 Then
//	MessageBox("CAPICOM","Impossivel fazer conex$$HEX1$$e300$$ENDHEX$$o com CAPICOM.DLL: XMLDoc")
//	//Return ''
//End If



XMLDoc2 = CREATE OLEObject
If XMLDoc2.ConnectToNewObject("nfe_util.Util") <> 0 Then
	MessageBox("CAPICOM","Impossivel fazer conex$$HEX1$$e300$$ENDHEX$$o com CAPICOM.DLL: XMLDoc")
	//Return ''
End If

//XMLDoc = CREATE OLEObject
//If XMLDoc.ConnectToNewObject("System.Security.Cryptography.RSACryptoServiceProvider") <> 0 Then
//	MessageBox("CAPICOM","Impossivel fazer conex$$HEX1$$e300$$ENDHEX$$o com CAPICOM.DLL: Object IXMLDOMDocument3")
//	//Return ''
//End If

SignedDocument = CREATE OLEObject

teste = SignedDocument.ConnectToNewObject("System.Security.Cryptography.Xml.SignedXml")
If teste <> 0 Then
	MessageBox("CAPICOM","Impossivel fazer conex$$HEX1$$e300$$ENDHEX$$o com CAPICOM.DLL: Object SignedDocument")
	//Return ''
End If

XMLDSig = CREATE OLEObject
If XMLDSig.ConnectToNewObject("msxml2.IXMLDigitalSignature.5.0") <> 0 Then
	MessageBox("CAPICOM","Impossivel fazer conex$$HEX1$$e300$$ENDHEX$$o com CAPICOM.DLL: Object IXMLDigitalSignature")
	//Return ''
End If

dsigKey = CREATE OLEObject
If dsigKey.ConnectToNewObject("msxml2.IXMLDSigKey.3.0") <> 0 Then
	MessageBox("CAPICOM","Impossivel fazer conex$$HEX1$$e300$$ENDHEX$$o com CAPICOM.DLL: Object IXMLDSigKey")
	//Return ''
End If

signedKey = CREATE OLEObject
If signedKey.ConnectToNewObject("msxml2.IXMLDSigKey.5.0") <> 0 Then
	MessageBox("CAPICOM","Impossivel fazer conex$$HEX1$$e300$$ENDHEX$$o com CAPICOM.DLL: Object IXMLDSigKey")
	//Return ''
End If

 nodePai = CREATE OLEObject
If nodePai.ConnectToNewObject("msxml2.IXMLDOMNode.5.0") <> 0 Then
	MessageBox("CAPICOM","Impossivel fazer conex$$HEX1$$e300$$ENDHEX$$o com CAPICOM.DLL: Object IXMLDOMNode")
	//Return ''
End If

nodeX509Data = CREATE OLEObject
If nodeX509Data.ConnectToNewObject("msxml2.IXMLDOMNode.5.0") <> 0 Then
	MessageBox("CAPICOM","Impossivel fazer conex$$HEX1$$e300$$ENDHEX$$o com CAPICOM.DLL: Object nodeX509Data")
	//Return ''
End If

nodeIrmao = CREATE OLEObject
If nodeIrmao.ConnectToNewObject("msxml2.IXMLDOMNode.5.0") <> 0 Then
	MessageBox("CAPICOM","Impossivel fazer conex$$HEX1$$e300$$ENDHEX$$o com CAPICOM.DLL: Object nodeIrmao")
	//Return ''
End If


	//If (Trim(Value) = '') Then
  // raise Exception.Create('N$$HEX1$$e300$$ENDHEX$$o existe informa$$HEX2$$e700e300$$ENDHEX$$o para fazer a Assinatura Digital');
  // XMLDoc := CoDOMDocument50.Create;
//   With XMLDoc Do
//   Begin
     XMLDoc2. async              			= False
      XMLDoc2.validateOnParse    	= False
      XMLDoc2.preserveWhiteSpace = True
//   End;

//   XMLDSig := CoMXDigitalSignature50.Create;

//   If (not XMLDoc.LoadXML(Value) ) then
//      raise Exception.Create('N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel carregar o "texto" XML');

   XMLDoc2.setProperty('SelectionNamespaces', 'FUrlXMLDSig');

//   XMLDSig.signature = XMLDoc.selectSingleNode('.//ds:Signature')// [b]{O grande macete para assinar o XML
//   em bloco esta neste codigo, mas como eu n$$HEX1$$e300$$ENDHEX$$o conseguir ele posicionar no bloco do xml na qual ele dever assinar
//   fiz, como segue abaixo}[/b]











CertStore.open(CAPICOM_CURRENT_USER_STORE, 'My',CAPICOM_STORE_OPEN_READ_ONLY)

if  CertStore.Certificates.Count = 0 then
	MessageBox("CAPICOM"," TCertStore.Certificates.Count")
	Return ''
end if	


Certificado = CertStore.Certificates[1]
Assinante.Certificate = Certificado

//Util.Base64Encode()
//
//Utilities.Base64Encode( _
//  ByVal SrcString _
//)

Assinante.Options    = 1
//SignedData.Content = as_documento     descomentar
Atributo.Name = CAPICOM_AUTHENTICATED_ATTRIBUTE_SIGNING_TIME
Atributo.Value = Now()
//Assinante.AuthenticateAttributes.add(Atributo)
//Atributo.Value = ExtractFileName(odlgCertificado.FileName)

lvs_Assinatura 		= SignedData.Sign(Assinante, True, CAPICOM_ENCODE_BINARY)
//lvs_Binary_String	= Util.BinaryStringToByteArray(Assinante)

Return lvs_Assinatura
end function

public function integer of_assina_xml_texto ();
OleObject Util

Util = CREATE OLEObject
If Util.ConnectToNewObject("NFe_Util_Interface") <> 0 Then
	MessageBox("CAPICOM","Impossivel fazer conex$$HEX1$$e300$$ENDHEX$$o com CAPICOM.DLL: Object CertStore")
	Return 1
End If

return 1
//procedure TFormAssinatura.btAssinarClick(Sender: TObject);
//var
//Util:NFe_Util_Interface;
//i:integer;
//    ///  1.Assinar: Assinatura Digital XML no padr$$HEX1$$e300$$ENDHEX$$o do Projeto NF-e
//    ///
//    ///
//    ///    Entradas:
//    ///     XMLString: string XML a ser assinada
//    ///     RefUri : Refer$$HEX1$$ea00$$ENDHEX$$ncia da URI a ser assinada (Ex. infNFe
//    ///     X509Cert : certificado digital a ser utilizado na assinatura digital
//    ///
//    ///    Retornos:
//    ///
//    ///      Assinar : c$$HEX1$$f300$$ENDHEX$$digo do resultado
//    ///
//    ///              0 - Assinatura realizada com sucesso
//    ///              1 - Erro: Problema ao acessar o certificado digital - %exce$$HEX2$$e700e300$$ENDHEX$$o%
//    ///              2 - Certificado digital inexistente para %nome%
//    ///              3 - XML mal formado + exce$$HEX2$$e700e300$$ENDHEX$$o
//    ///              4 - A tag de assinatura %RefUri% inexiste
//    ///              5 - A tag de assinatura %RefUri% n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ unica
//    ///              6 - Erro Ao assinar o documento - ID deve ser string %RefUri(Atributo)%
//    ///              7 - Erro: Ao assinar o documento - %exce$$HEX2$$e700e300$$ENDHEX$$o%
//    ///
//    ///      XMLStringAssinado : string XML assinada
//    ///
//    ///      msgResultado      : Literal da mensagem resultado
//begin
//  if xmlDoc <> '' then
//  begin
//  if rtfNome.Text <> '' then
//     begin
//     Util := CoUtil.Create;
//     case tpDoc.ItemIndex of
//          0: ref := 'infNFe';
//          1: ref := 'infCanc';
//          2: ref := 'infInut';
//     end;
//     nome := rtfNome.Text;
//     i:= Util.Assinar(xmlDoc, ref, nome, xmlAssinado, mensagem);
//     if i <> 0 then     MessageDlg( 'Processo de assinatura falhou...', mtInformation, [mbOk], 0);
//     GroupBox4.Visible := true;
//     edResultado.Text := inttostr(i)+ ' - ' +mensagem;
//     rtfAssinado.Text := xmlAssinado;
//     btGravar.enabled := true;
//     btGravar.setfocus;
//     Util := nil;
//     end
//     else
//    MessageDlg( 'Nome do titular do Certificado n$$HEX1$$e300$$ENDHEX$$o informado...', mtInformation, [mbOk], 0);
//  end
//  else
//    MessageDlg( 'Documento XML para assinatura n$$HEX1$$e300$$ENDHEX$$o informado...', mtInformation, [mbOk], 0);
//end;
//
end function

on dc_uo_xml.create
call super::create
TriggerEvent( this, "constructor" )
end on

on dc_uo_xml.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

