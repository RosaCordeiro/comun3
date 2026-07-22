HA$PBExportHeader$dc_uo_nfe.sru
forward
global type dc_uo_nfe from oleobject
end type
end forward

global type dc_uo_nfe from oleobject
end type
global dc_uo_nfe dc_uo_nfe

type variables
string is_evento,&
		is_chave_acesso_canc,&
		is_nfe_cte,&
		is_Versao
end variables

forward prototypes
private function double of_str_double_value (string as_value)
private function string of_get_tipo_pis (long ai_tipo_pis)
private function boolean of_get_footer (string a_xml, ref t_total at_total, ref t_transp at_transp, ref t_cobr at_cobr, ref t_infadic at_infadic, ref t_compra at_compra)
private function boolean of_get_header (string a_xml, ref t_ide at_ide, ref t_emit at_emit, ref t_dest at_dest)
public function boolean of_read_xml (string a_xml, boolean ab_tudo, ref t_infnfe at_infnfe)
public function boolean of_verifica_cancelamento (string as_chave_acesso, ref string as_mensagem_log)
public function string of_get_value_tag (string as_xml, string as_tag, integer ai_pos)
public function string of_get_value_tag_pipe (string as_xml, string as_tag)
public function string gf_replace_rastro (string ps_assunto, string ps_pesquisa, string ps_substitui, integer pl_qtde)
public function boolean of_read_xml (string a_xml, boolean ab_tudo, ref t_infnfe at_infnfe, ref string as_log)
public function boolean of_verificar_rastro_nf (ref string as_mensagem_log, ref string as_habilita_rastro_med_nf)
private function boolean of_get_details (string a_xml, ref t_prod at_prod, ref t_imposto at_imposto, ref string as_infadprod, ref decimal adc_vitem, ref t_dfereferenciado at_dfereferenciado, ref string as_log)
end prototypes

private function double of_str_double_value (string as_value);Double ls_Value
If as_Value <> "" Then
	ls_Value = Double(gf_Replace(as_Value, ".", ",", 0))
Else
	ls_Value = 0.00
End If	
Return ls_Value
end function

private function string of_get_tipo_pis (long ai_tipo_pis);String ls_Tipo

If ai_tipo_pis < 3 Then
  ls_Tipo = 'PISAliq'
ElseIf ai_tipo_pis < 4 Then
  ls_Tipo = 'PISQtde'
ElseIf ai_tipo_pis <= 9 Then
  ls_Tipo = 'PISNT'
ElseIf ai_tipo_pis = 99 Then
  ls_Tipo = 'PISOutr'
End If

Return ls_Tipo
end function

private function boolean of_get_footer (string a_xml, ref t_total at_total, ref t_transp at_transp, ref t_cobr at_cobr, ref t_infadic at_infadic, ref t_compra at_compra);String l_XmlAux, l_XmlAux2, l_XmlAux3, l_XmlAux4, l_XmlAux5
Integer i 
Boolean lb_Retorno

lb_Retorno = True
Try
	
	l_XmlAux = a_xml
	
	//<ICMSTot>
	l_XmlAux2 = Mid(l_XmlAux, Pos(l_XmlAux, '<ICMSTot>'), Pos(l_XmlAux, '</ICMSTot>') - Pos(l_XmlAux, '<ICMSTot>')+10) 
	
	at_total.ICMSTot.vBC				= of_str_double_value(of_get_value_tag(l_XmlAux2, '<vBC>' ,1))
	at_total.ICMSTot.vICMS			= of_str_double_value(of_get_value_tag(l_XmlAux2, '<vICMS>' ,1))
	at_total.ICMSTot.vFCP			= of_str_double_value(of_get_value_tag(l_XmlAux2, '<vFCP>' ,1))
	at_total.ICMSTot.vBCST			= of_str_double_value(of_get_value_tag(l_XmlAux2, '<vBCST>' ,1))
	at_total.ICMSTot.vST				= of_str_double_value(of_get_value_tag(l_XmlAux2, '<vST>' ,1))
	at_total.ICMSTot.vFCPST			= of_str_double_value(of_get_value_tag(l_XmlAux2, '<vFCPST>' ,1))
	at_total.ICMSTot.vFCPSTRet		= of_str_double_value(of_get_value_tag(l_XmlAux2, '<vFCPSTRet>' ,1))
	at_total.ICMSTot.vProd			= of_str_double_value(of_get_value_tag(l_XmlAux2, '<vProd>' ,1))
	at_total.ICMSTot.vFrete			= of_str_double_value(of_get_value_tag(l_XmlAux2, '<vFrete>' ,1))
	at_total.ICMSTot.vSeg			= of_str_double_value(of_get_value_tag(l_XmlAux2, '<vSeg>' ,1))
	at_total.ICMSTot.vDesc			= of_str_double_value(of_get_value_tag(l_XmlAux2, '<vDesc>' ,1))
	at_total.ICMSTot.vICMSDeson	= of_str_double_value(of_get_value_tag(l_XmlAux2, '<vICMSDeson>' ,1))
	at_total.ICMSTot.vII				= of_str_double_value(of_get_value_tag(l_XmlAux2, '<vII>' ,1))
	at_total.ICMSTot.vIPI			= of_str_double_value(of_get_value_tag(l_XmlAux2, '<vIPI>' ,1))
	at_total.ICMSTot.vPIS			= of_str_double_value(of_get_value_tag(l_XmlAux2, '<vPIS>' ,1))
	at_total.ICMSTot.vCOFINS		= of_str_double_value(of_get_value_tag(l_XmlAux2, '<vCOFINS>' ,1))
	at_total.ICMSTot.vOutro			= of_str_double_value(of_get_value_tag(l_XmlAux2, '<vOutro>' ,1))
	at_total.ICMSTot.vNF				= of_str_double_value(of_get_value_tag(l_XmlAux2, '<vNF>' ,1))
	
	//<ISTot>
	If Pos(l_XmlAux, '<ISTot>') > 0 Then
		l_XmlAux2 = Mid(l_XmlAux, Pos(l_XmlAux, '<ISTot>'), Pos(l_XmlAux, '</ISTot>') - Pos(l_XmlAux, '<ISTot>') + 8)
		
		at_total.istot.vis = of_str_double_value(of_get_value_tag(l_XmlAux2, '<vIS>' ,1))
	End If
	
	If Pos(l_XmlAux, '<IBSCBSTot>') > 0 Then
		l_XmlAux3 = Mid(l_XmlAux, Pos(l_XmlAux, '<IBSCBSTot>'), Pos(l_XmlAux, '</IBSCBSTot>') - Pos(l_XmlAux, '<IBSCBSTot>') + 12)
		
		at_total.IBSCBSTot.vBCIBSCBS = of_str_double_value(of_get_value_tag(l_XmlAux3, '<vBCIBSCBS>' ,1))
		
		If Pos(l_XmlAux3, '<gIBS>') > 0 Then
			l_XmlAux4 = Mid(l_XmlAux3, Pos(l_XmlAux3, '<gIBS>'), Pos(l_XmlAux3, '</gIBS>') - Pos(l_XmlAux3, '<gIBS>') + 7)
			
			If Pos(l_XmlAux4, '<gIBSUF>') > 0 Then
				l_XmlAux5 = Mid(l_XmlAux4, Pos(l_XmlAux4, '<gIBSUF>'), Pos(l_XmlAux4, '</gIBSUF>') - Pos(l_XmlAux4, '<gIBSUF>') + 9)
				
				at_total.IBSCBSTot.gIBS_tot.gIBSUF_tot.vDif	= of_str_double_value(of_get_value_tag(l_XmlAux5, '<vDif>' ,1))
				at_total.IBSCBSTot.gIBS_tot.gIBSUF_tot.vDevTrib	= of_str_double_value(of_get_value_tag(l_XmlAux5, '<vDevTrib>' ,1))
				at_total.IBSCBSTot.gIBS_tot.gIBSUF_tot.vIBSUF	= of_str_double_value(of_get_value_tag(l_XmlAux5, '<vIBSUF>' ,1))
			End If
			
			If Pos(l_XmlAux4, '<gIBSMun>') > 0 Then
				l_XmlAux5 = Mid(l_XmlAux4, Pos(l_XmlAux4, '<gIBSMun>'), Pos(l_XmlAux4, '</gIBSMun>') - Pos(l_XmlAux4, '<gIBSMun>') + 10)
				
				at_total.IBSCBSTot.gIBS_tot.gIBSMun_tot.vDif	= of_str_double_value(of_get_value_tag(l_XmlAux5, '<vDif>' ,1))
				at_total.IBSCBSTot.gIBS_tot.gIBSMun_tot.vDevTrib	= of_str_double_value(of_get_value_tag(l_XmlAux5, '<vDevTrib>' ,1))
				at_total.IBSCBSTot.gIBS_tot.gIBSMun_tot.vIBSMun	= of_str_double_value(of_get_value_tag(l_XmlAux5, '<vIBSMun>' ,1))
			End If
			
			at_total.IBSCBSTot.gIBS_tot.vIBS	= of_str_double_value(of_get_value_tag(l_XmlAux4, '<vIBS>' ,1))
		End If
		
		If Pos(l_XmlAux3, '<gCBS>') > 0 Then
			l_XmlAux4 = Mid(l_XmlAux3, Pos(l_XmlAux3, '<gCBS>'), Pos(l_XmlAux3, '</gCBS>') - Pos(l_XmlAux3, '<gCBS>') + 7)
			
			at_total.IBSCBSTot.gCBS_tot.vDif	= of_str_double_value(of_get_value_tag(l_XmlAux4, '<vDif>' ,1))
			at_total.IBSCBSTot.gCBS_tot.vDevTrib	= of_str_double_value(of_get_value_tag(l_XmlAux4, '<vDevTrib>' ,1))
			at_total.IBSCBSTot.gCBS_tot.vCBS	= of_str_double_value(of_get_value_tag(l_XmlAux4, '<vCBS>' ,1))
		End If
	End If
	
	//<ISSQNtot>
	If Pos(l_XmlAux, '<ISSQNtot>') > 0 Then
		l_XmlAux2 = Mid(l_XmlAux, Pos(l_XmlAux, '<ISSQNtot>'), Pos(l_XmlAux, '</ISSQNtot>') - Pos(l_XmlAux, '<ISSQNtot>') + 11)
		
		If Pos(l_XmlAux2, '<vServ>') > 0 Then
			at_total.ISSQNtot.vServ   	= of_str_double_value(of_get_value_tag(l_XmlAux2,'<vServ>' ,1))
		End If
		
		If Pos(l_XmlAux2, '<vBC>') > 0 Then
			at_total.ISSQNtot.vBC     	= of_str_double_value(of_get_value_tag(l_XmlAux2,'<vBC>' ,1))
		End If	 
		
		If Pos(l_XmlAux2, '<vISS>') > 0 Then
			at_total.ISSQNtot.vISS    	= of_str_double_value(of_get_value_tag(l_XmlAux2,'<vISS>' ,1))
		End If	 
		
		If Pos(l_XmlAux2, '<vPIS>') > 0 Then
			at_total.ISSQNtot.vPIS    	= of_str_double_value(of_get_value_tag(l_XmlAux2,'<vPIS>' ,1))
		End If	 
		
		If Pos(l_XmlAux2, '<vCOFINS>') > 0 Then
			at_total.ISSQNtot.vCOFINS 	= of_str_double_value(of_get_value_tag(l_XmlAux2,'<vCOFINS>' ,1))
		End If	 
	End If
	
	//<retTrib>
	If Pos(l_XmlAux, '<retTrib>') > 0 Then
		l_XmlAux2 = Mid(l_XmlAux, Pos(l_XmlAux, '<retTrib>'), Pos(l_XmlAux, '</retTrib>') - Pos(l_XmlAux, '<retTrib>') + 10)
	
		If Pos(l_XmlAux2, '<vRetPIS>') > 0 Then
			at_total.retTrib.vRetPIS    = of_str_double_value(of_get_value_tag(l_XmlAux2,'<vRetPIS>'    ,1))
		End If
		
		If Pos(l_XmlAux2, '<vRetCOFINS>') > 0 Then
			at_total.retTrib.vRetCOFINS = of_str_double_value(of_get_value_tag(l_XmlAux2,'<vRetCOFINS>' ,1))
		End If	 
		
		If Pos(l_XmlAux2, '<vRetCSLL>') > 0 Then
			at_total.retTrib.vRetCSLL   = of_str_double_value(of_get_value_tag(l_XmlAux2,'<vRetCSLL>'   ,1))
		End If	 
		
		If Pos(l_XmlAux2, '<vBCIRRF>') > 0 Then
			at_total.retTrib.vBCIRRF    = of_str_double_value(of_get_value_tag(l_XmlAux2,'<vBCIRRF>'    ,1))
		End If
		
		If Pos(l_XmlAux2, '<vIRRF>') > 0 Then
			at_total.retTrib.vIRRF      = of_str_double_value(of_get_value_tag(l_XmlAux2,'<vIRRF>'      ,1))
		End If
		
		If Pos(l_XmlAux2, '<vBCRetPrev>') > 0 Then
			at_total.retTrib.vBCRetPrev = of_str_double_value(of_get_value_tag(l_XmlAux2,'<vBCRetPrev>' ,1))
		End If
		
		If Pos(l_XmlAux2, '<vRetPrev>') > 0 Then
			at_total.retTrib.vRetPrev   = of_str_double_value(of_get_value_tag(l_XmlAux2,'<vRetPrev>'   ,1))
		End If	 
	End If
	
	//<transp>
	If Pos(l_XmlAux, '<transp>') > 0 Then	
		l_XmlAux2 = Mid(l_XmlAux, Pos(l_XmlAux, '<transp>'), Pos(l_XmlAux, '</transp>') - Pos(l_XmlAux, '<transp>') + 9)
		
		at_transp.modFrete   = Long(of_get_value_tag(l_XmlAux2, '<modFrete>' , 1))
		
		If Pos(l_XmlAux2, '<transporta>') > 0 Then
			at_transp.transporta.CNPJ   	= of_get_value_tag(l_XmlAux2, '<CNPJ>'   ,1)
			at_transp.transporta.CPF    	= of_get_value_tag(l_XmlAux2, '<CPF>'    ,1)
			at_transp.transporta.xNome  	= of_get_value_tag(l_XmlAux2, '<xNome>'  ,1)
			at_transp.transporta.IE     	= of_get_value_tag(l_XmlAux2, '<IE>'     ,1)
			at_transp.transporta.xEnder 	= of_get_value_tag(l_XmlAux2, '<xEnder>' ,1)
			at_transp.transporta.xMun   	= of_get_value_tag(l_XmlAux2, '<xMun>'   ,1)
			at_transp.transporta.UF     	= of_get_value_tag(l_XmlAux2, '<UF>'     ,1)
		End If
	
		//<retTransp>
		if Pos(l_XmlAux2, '<retTransp>') > 0 Then
			at_transp.retTransp.vServ    	= of_str_double_value(of_get_value_tag(l_XmlAux2,'<vServ>'    ,1))
			at_transp.retTransp.vBCRet   	= of_str_double_value(of_get_value_tag(l_XmlAux2,'<vBCRet>'   ,1))
			at_transp.retTransp.pICMSRet 	= of_str_double_value(of_get_value_tag(l_XmlAux2,'<pICMSRet>' ,1))
			at_transp.retTransp.vICMSRet 	= of_str_double_value(of_get_value_tag(l_XmlAux2,'<vICMSRet>' ,1))
			at_transp.retTransp.CFOP     	= Long(of_get_value_tag(l_XmlAux2,'<CFOP>' ,1))
			at_transp.retTransp.cMunFG   	= Long(of_get_value_tag(l_XmlAux2,'<cMunFG>' ,1))
		End If
		
		//<veicTransp>
		If Pos(l_XmlAux2, '<veicTransp>') > 0 Then
			at_transp.veicTransp.placa 	= of_get_value_tag(l_XmlAux2, '<placa>' ,1)
			at_transp.veicTransp.UF    	= of_get_value_tag(l_XmlAux2, '<UF>'    ,1)
			at_transp.veicTransp.RNTC  	= of_get_value_tag(l_XmlAux2, '<RNTC>'  ,1)
		End If
		
		//<vol>
		i = 1	
		DO WHILE Pos(l_XmlAux, '<vol>') > 0 		
			l_XmlAux2 = Mid(l_XmlAux, Pos(l_XmlAux, '<vol>'), Pos(l_XmlAux, '</vol>') - Pos(l_XmlAux, '<vol>') + 6)
			
			If Pos(l_XmlAux2, '<qVol>') > 0 Then
				at_transp.vol[i].qVol 	=  Long(of_get_value_tag(l_XmlAux2,'<qVol>' ,1))
			End If
			
			If Pos(l_XmlAux2, '<esp>') > 0 Then
				at_transp.vol[i].esp   	=  of_get_value_tag(l_XmlAux2,'<esp>' ,1)
			End If
			
			If Pos(l_XmlAux2, '<marca>') > 0 Then
				 at_transp.vol[i].marca 	=  of_get_value_tag(l_XmlAux2,'<marca>' ,1)
			End If
			
			If Pos(l_XmlAux2, '<nVol>') > 0 Then
				at_transp.vol[i].nVol  	=  of_get_value_tag(l_XmlAux2,'<nVol>' ,1)
			End If	 
			
			If Pos(l_XmlAux2, '<pesoL>') > 0 Then
				at_transp.vol[i].pesoL 	=  of_str_double_value(of_get_value_tag(l_XmlAux2,'<pesoL>' ,1))
			End If
			
			If Pos(l_XmlAux2, '<pesoB>') > 0 Then
				at_transp.vol[i].pesoB 	=  of_str_double_value(of_get_value_tag(l_XmlAux2,'<pesoB>' ,1))
			End If	 

			l_XmlAux = gf_Replace(l_XmlAux, l_XmlAux2, "", 0) //Limpa parte j$$HEX1$$e100$$ENDHEX$$ lida
			i += 1
		LOOP
	End If	//</transp>
	
	//<cobr>
	If Pos(l_XmlAux, '<cobr>') > 0 Then
		l_XmlAux2 = Mid(l_XmlAux, Pos(l_XmlAux, '<cobr>'), Pos(l_XmlAux, '</cobr>') - Pos(l_XmlAux, '<cobr>') + 7)
		
		If Pos(l_XmlAux, '<fat>') > 0 Then
			If Pos(l_XmlAux2, '<nFat>') > 0 Then
				at_cobr.fat.nfat 	= of_get_value_tag(l_XmlAux2,'<nFat>' ,1)
			End If
			
			If Pos(l_XmlAux2, '<vOrig>') > 0 Then
				at_cobr.fat.vorig 	= of_str_double_value(of_get_value_tag(l_XmlAux2,'<vOrig>' ,1))
			End If
			
			If Pos(l_XmlAux2, '<vDesc>') > 0 Then
				at_cobr.fat.vdesc 	= of_str_double_value(of_get_value_tag(l_XmlAux2,'<vDesc>' ,1))
			End If
			
			If Pos(l_XmlAux2, '<vLiq>') > 0 Then
				at_cobr.fat.vliq 	= of_str_double_value(of_get_value_tag(l_XmlAux2,'<vLiq>' ,1))
			End If
		End If
		
		i = 1	
		DO WHILE Pos(l_XmlAux, '<dup') > 0 
			l_XmlAux2 = Mid(l_XmlAux, Pos(l_XmlAux, '<dup'), Pos(l_XmlAux, '</dup>') - Pos(l_XmlAux, '<dup') + 6)	
						
			at_cobr.dup[i].ndup	= of_get_value_tag(l_XmlAux2 ,'<nDup>' ,1)
			at_cobr.dup[i].dvenc	= Date(of_get_value_tag(l_XmlAux2 ,'<dVenc>' ,1))
			at_cobr.dup[i].vdup	= of_str_double_value(of_get_value_tag(l_XmlAux2 ,'<vDup>' ,1))
			
			l_XmlAux = gf_Replace(l_XmlAux, l_XmlAux2, "", 0) //Limpa parte j$$HEX1$$e100$$ENDHEX$$ lida
			i += 1
		LOOP
	End If
	
	//<infAdic>
	If Pos(l_XmlAux, '<infAdic>') > 0 Then
		l_XmlAux2 = Mid(l_XmlAux, Pos(l_XmlAux, '<infAdic>'), Pos(l_XmlAux, '</infAdic>') - Pos(l_XmlAux, '<infAdic>') + 10)

		If Pos(l_XmlAux2, '<infAdFisco>') > 0 Then
			at_infadic.infAdFisco = of_get_value_tag(l_XmlAux2,'<infAdFisco>' ,1)
		End If	 
		
		if Pos(l_XmlAux2, '<infCpl>') > 0 Then
			at_infadic.infCpl     = of_get_value_tag(l_XmlAux2,'<infCpl>' ,1)
		End If

		//pega dados para ver se $$HEX1$$e900$$ENDHEX$$ pedido pharmalink...
		if Pos(Upper(l_XmlAux2), '<OBSCONT XCAMPO="XVAN">') > 0 Then
			l_XmlAux2 			= Mid(l_XmlAux2, Pos(Upper(l_XmlAux2), '<OBSCONT XCAMPO="XVAN">'))
			l_XmlAux2 			= Mid(l_XmlAux2, Pos(Upper(l_XmlAux2), '<OBSCONT XCAMPO="XVAN">'), Pos(Upper(l_XmlAux2), '</OBSCONT>') - 1)
			at_infadic.xvan   = Upper(of_get_value_tag(l_XmlAux2,'<xTexto>' ,1))
		Else
			if Pos(Upper(l_XmlAux2), '<OBSCONT XCAMPO="VANPEDIDO">') > 0 Then
				l_XmlAux2 = Mid(l_XmlAux2, Pos(Upper(l_XmlAux2), '<OBSCONT XCAMPO="VANPEDIDO">'))
				l_XmlAux2 = Mid(l_XmlAux2, Pos(Upper(l_XmlAux2), '<OBSCONT XCAMPO="VANPEDIDO">'), Pos(Upper(l_XmlAux2), '</OBSCONT>') - 1)
				at_infadic.xvan     =  Upper(of_get_value_tag(l_XmlAux2,'<xTexto>' ,1))
			End If
		End If
	
		i = 1
		DO WHILE Pos(l_XmlAux, '<obsCont>') > 0 
			l_XmlAux2 = Mid(l_XmlAux, Pos(l_XmlAux, '<obsCont>'), Pos(l_XmlAux, '</obsCont>') - Pos(l_XmlAux, '<obsCont>') + 10)
			at_infadic.obsCont[i].xCampo = of_get_value_tag(l_XmlAux2,'<xCampo>' ,1)
			at_infadic.obsCont[i].xTexto = of_get_value_tag(l_XmlAux2,'<xTexto>' ,1)
			 
			l_XmlAux = gf_Replace(l_XmlAux, l_XmlAux2, "", 0) 
			i += 1
		LOOP
	
		i = 1
		DO WHILE Pos(l_XmlAux, '<obsFisco>') > 0
			l_XmlAux2  = Mid(l_XmlAux, Pos(l_XmlAux, '<obsFisco>'), Pos(l_XmlAux, '</obsFisco>') - Pos(l_XmlAux, '<obsFisco>') + 10)
 
			at_infadic.obsFisco[i].xCampo = of_get_value_tag(l_XmlAux2 ,'<xCampo>' ,1)
			at_infadic.obsFisco[i].xTexto 	= of_get_value_tag(l_XmlAux2 ,'<xTexto>' ,1)

			l_XmlAux = gf_Replace(l_XmlAux, l_XmlAux2, "", 0) 
			i += 1
		LOOP
	End If

	If Pos(l_XmlAux, '<compra>') > 0 Then
		l_XmlAux2 = Mid(l_XmlAux, Pos(l_XmlAux, '<compra>'), Pos(l_XmlAux, '</compra>') - Pos(l_XmlAux, '<compra>') + 8)
		
		If Pos(l_XmlAux2, '<xNEmp>') > 0 Then
			at_compra.xNEmp = of_get_value_tag(l_XmlAux2,'<xNEmp>' ,1)
		End If
		
		If pos(l_XmlAux2, '<xPed>') > 0 Then
			at_compra.xPed  = of_get_value_tag(l_XmlAux2,'<xPed>' ,1)
		End If
		
		If pos(l_XmlAux2, '<xCont>') > 0 Then
			at_compra.xCont = of_get_value_tag(l_XmlAux2,'<xCont>' ,1)
		End If
	End If
Catch ( runtimeerror  lo_rte )
	lb_Retorno = False
Finally	
	Return lb_Retorno
End Try
end function

private function boolean of_get_header (string a_xml, ref t_ide at_ide, ref t_emit at_emit, ref t_dest at_dest);Boolean 	lb_Retorno
String 	l_XmlAux, ls_refNFe


lb_Retorno = True

Try
	
	If a_Xml = "" Then 
		lb_Retorno = False
		Return lb_Retorno
	End If
	
	l_XmlAux = 	Mid(a_Xml,Pos(a_Xml, '<ide>'), Pos(a_Xml, '</ide>') - Pos(a_Xml, '<ide>'))
	
	at_ide.cUF    	=  of_get_value_tag(l_XmlAux,          	'<cUF>'     	,1)
	at_ide.cNF    	=  Long(of_get_value_tag(l_XmlAux, 		'<cNF>'     	,1))
	at_ide.natOp  	=  of_get_value_tag(l_XmlAux,    			'<natOp>'   	,1)
	
	If Pos(l_XmlAux, '<indPag>') > 0 Then
		at_ide.indPag 	=  Long(of_get_value_tag(l_XmlAux, 		'<indPag>'  	,1))
	End If
	
	at_ide.modelo 	=  Long(of_get_value_tag(l_XmlAux, 		'<mod>'     	,1))
	at_ide.serie  	=  of_get_value_tag(l_XmlAux, 			'<serie>'   	,1)
	at_ide.nNF     	=  Long(of_get_value_tag(l_XmlAux, 		'<nNF>'     	,1))
	If of_get_value_tag(l_XmlAux,	'<dEmi>',		1) <> "" Then
		at_ide.dEmi =  Date(of_get_value_tag(l_XmlAux,		'<dEmi>'	,1))
	Else
		at_ide.dEmi =  Date(Mid(of_get_value_tag(l_XmlAux,		'<dhEmi>'	,1), 1,10))
	End If		
	
	If of_get_value_tag(l_XmlAux,	'<dSaiEnt>',		1) <> "" Then
		at_ide.dSaiEnt =  Date(of_get_value_tag(l_XmlAux,		'<dSaiEnt>'	,1))
	End If				
	at_ide.tpNF   	=  Long(of_get_value_tag(l_XmlAux, 		'<tpNF>'    	,1))
	at_ide.cMunFG 	=  Long(of_get_value_tag(l_XmlAux, 		'<cMunFG>' ,1))
	at_ide.cMunFGIBS 	=  of_get_value_tag(l_XmlAux, 		'<cMunFGIBS>' ,1)

	at_ide.tpImp  	=  Long(of_get_value_tag(l_XmlAux, 		'<tpImp>'   	,1))
	at_ide.tpEmis 	=  Long(of_get_value_tag(l_XmlAux,		'<tpEmis>'  	,1))
	at_ide.cDV    	=  Long(of_get_value_tag(l_XmlAux, 		'<cDV>'     	,1))
	at_ide.tpAmb  	=  Long(of_get_value_tag(l_XmlAux, 		'<tpAmb>'   ,1))
	at_ide.finNFe 	=  Long(of_get_value_tag(l_XmlAux, 		'<finNFe>'  	,1))
	
	at_ide.tpNFDebito 	=  of_get_value_tag(l_XmlAux, 		'<tpNFDebito>'  	,1)
	at_ide.tpNFCredito 	=  of_get_value_tag(l_XmlAux, 		'<tpNFCredito>'  	,1)
		
	at_ide.procEmi	=  Long(of_get_value_tag(l_XmlAux, 		'<procEmi>' ,1))
	at_ide.verProc	=  of_get_value_tag(l_XmlAux,				'<verProc>'	,1)
	
	If of_get_value_tag(l_XmlAux, '<NFref>'	,1) <> '' Then
		a_Xml = Mid(a_Xml, Pos(a_Xml, '<NFref>'), (LenA(a_Xml) - Pos(a_Xml, '<NFref>') + 1))
		l_XmlAux = Mid(a_Xml,Pos(a_Xml, '<NFref>'), Pos(a_Xml, '</NFref>') - Pos(a_Xml, '<NFref>')+8)
		
		do while of_get_value_tag(l_XmlAux, '<refNFe>'	,1) <> '' 
			ls_refNFe = of_get_value_tag(l_XmlAux, '<refNFe>'	,1)
			
			at_ide.nfref.refnfe[UpperBound(at_ide.nfref.refnfe) + 1] = ls_refNFe
			
			l_XmlAux = gf_Replace(l_XmlAux, "<refNFe>" + ls_refNFe + "</refNFe>", "", 0)
		loop
	End If
	
	//gPagAntecipado -> Verificar necessidade posteriormente (Guilherme Cordeiro)
	
	//Emitente
	a_Xml = Mid(a_Xml, Pos(a_Xml, '<emit>'), (LenA(a_Xml) - Pos(a_Xml, '<emit>') + 1))
	l_XmlAux = Mid(a_Xml,Pos(a_Xml, '<emit>'), Pos(a_Xml, '</emit>') - Pos(a_Xml, '<emit>')+7)
	
	at_emit.CNPJ    				=  of_get_value_tag(l_XmlAux,			'<CNPJ>'      	,1)
	at_emit.xNome   				=  of_get_value_tag(l_XmlAux,			'<xNome>'   	,1)
	at_emit.xFant   				=  of_get_value_tag(l_XmlAux,			'<xFant>'		,1)
	at_emit.Endereco.xLgr    	=  of_get_value_tag(l_XmlAux,        	'<xLgr>'    		,1)
	at_emit.Endereco.xCpl    	=  of_get_value_tag(l_XmlAux,        	'<xCpl>'    		,1)
	at_emit.Endereco.nro     		=  of_get_value_tag(l_XmlAux,         	'<nro>'      		,1)
	at_emit.Endereco.xBairro 	=  of_get_value_tag(l_XmlAux,         	'<xBairro>'  	,1)
	If of_get_value_tag(l_XmlAux,'<cMun>'      ,1) <> '' Then
		at_emit.Endereco.cMun  	=  Long(of_get_value_tag(l_XmlAux,	'<cMun>'    		,1))
	End If	
	at_emit.Endereco.xMun    	=  of_get_value_tag(l_XmlAux,         	'<xMun>'     	,1)
	at_emit.Endereco.UF      		=  of_get_value_tag(l_XmlAux,         	'<UF>'       		,1)
	If of_get_value_tag(l_XmlAux,'<CEP>'      ,1) <> '' Then
		at_emit.Endereco.CEP     =  Long(of_get_value_tag(l_XmlAux,	'<CEP>'      		,1))
	End If	
	If  of_get_value_tag(l_XmlAux,'<cPais>',1) <> '' Then
		at_emit.Endereco.cPais   =  Long(of_get_value_tag(l_XmlAux,	'<cPais>'			,1))
	End If
	at_emit.Endereco.xPais   	=  of_get_value_tag(l_XmlAux,			'<xPais>'			,1)
	at_emit.Endereco.fone    	=  of_get_value_tag(l_XmlAux,			'<fone>'			,1)
	at_emit.IE      					=  of_get_value_tag(l_XmlAux,			'<IE>'				,1)
	If of_get_value_tag(l_XmlAux,'<CRT>'  ,1) <> '' Then
		at_emit.CRT     			=  Long(of_get_value_tag(l_XmlAux,	'<CRT>'			,1))
	End If
	
	//Destinatario
	a_Xml 		= Mid(a_Xml, pos(a_Xml, '<dest>'), (LenA(a_Xml) - pos(a_Xml, '<dest>') + 1))
	l_XmlAux 	= Mid(a_Xml, Pos(a_Xml, '<dest>'), Pos(a_Xml, '</dest>') - Pos(a_Xml, '<dest>'))
			  
	at_dest.CNPJ    				=  of_get_value_tag(l_XmlAux,			'<CNPJ>'     	,1)
	at_dest.xNome   				=  of_get_value_tag(l_XmlAux,			'<xNome>'   	,1)
	at_dest.endereco.xLgr      	=  of_get_value_tag(l_XmlAux,         	'<xLgr>'   		,1)
	at_dest.endereco.xCpl      	=  of_get_value_tag(l_XmlAux,         	'<xCpl>'   		,1)
	at_dest.endereco.nro       	=  of_get_value_tag(l_XmlAux,         	'<nro>'    		,1)
	at_dest.endereco.xBairro   	=  of_get_value_tag(l_XmlAux,         	'<xBairro>'		,1)
	If of_get_value_tag(l_XmlAux,'<CEP>'    ,1) <> "" Then
		at_dest.endereco.cMun	=  Long(of_get_value_tag(l_XmlAux,	'<cMun>'   		,1))
	End If	
	at_dest.endereco.xMun      	=  of_get_value_tag(l_XmlAux,         	'<xMun>'   		,1)
	at_dest.endereco.UF        	=  of_get_value_tag(l_XmlAux,         	'<UF>'     		,1)
	If of_get_value_tag(l_XmlAux,'<CEP>'    ,1) <> "" Then
		at_dest.endereco.CEP     =  Long(of_get_value_tag(l_XmlAux,	'<CEP>'    		,1))
	End If
	If of_get_value_tag(l_XmlAux,'<cPais>'  ,1) <> "" Then
		at_dest.endereco.cPais   =  Long(of_get_value_tag(l_XmlAux,	'<cPais>'  		,1))
	End If
	at_dest.endereco.xPais     	=  of_get_value_tag(l_XmlAux,         	'<xPais>'  		,1)
	at_dest.endereco.fone      	=  of_get_value_tag(l_XmlAux,         	'<fone>'   		,1)
	at_dest.IE     					=  of_get_value_tag(l_XmlAux,			'<IE>'   			,1)
	at_dest.email  					=  of_get_value_tag(l_XmlAux,			'<email>'   		,1)

Catch ( runtimeerror  lo_rte )
	lb_Retorno = False
//	MessageBox (	"Erro", "Ocorreu erro ao localizar os dados totalizadores da nota ~r~r"+ & 						
// 						"Erro: "+lo_rte.GetMessage( ))
Finally
	Return lb_Retorno
End Try	
end function

public function boolean of_read_xml (string a_xml, boolean ab_tudo, ref t_infnfe at_infnfe);String ls_log

return this.of_read_xml(a_xml, ab_tudo, REF at_infnfe, REF ls_log)
end function

public function boolean of_verifica_cancelamento (string as_chave_acesso, ref string as_mensagem_log);Long ll_Achou

Select count(*) 
Into :ll_Achou
From nfe_destinadas
Where de_chave_acesso 	= :as_chave_acesso
  	and id_situacao_nf 		= '3'
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_Mensagem_Log = "Erro ao verificar o cancelamento no SEFAZ: "+ SqlCa.sqlerrtext
	SqlCa.of_RollBack();
	Return False
End If

If ll_Achou > 0 Then
	as_mensagem_log = "A nota esta cancelada no SEFAZ."
	Return False
End If

Return True
end function

public function string of_get_value_tag (string as_xml, string as_tag, integer ai_pos);Integer li_Esp, li_i, li_Inicio, li_Fim
string  ls_Result, ls_Xml_Aux

as_Tag = gf_Replace(as_Tag, '/', '', 0)
as_Tag = gf_Replace(as_Tag, '<', '', 0)
as_Tag = gf_Replace(as_Tag, '>', '', 0)
If Pos(' ', as_Tag) > 0 Then 
	li_Esp = Pos(' ',as_Tag)
Else
	li_Esp = LenA(as_Tag)
End If	

li_Inicio = 1
ls_Xml_Aux = as_xml
for li_i = 1 to ai_Pos 
	 ls_Result = Mid(	ls_Xml_Aux,  &
	 						Pos(ls_Xml_Aux, '<'+as_tag+'>')+LenA(as_tag)+2, &
	 						Pos(ls_Xml_Aux, '</'+as_tag+'>') - (Pos(ls_Xml_Aux, '<'+as_tag+'>')+LenA(as_tag)+2))
	ls_Xml_Aux = Mid(ls_Xml_Aux, Pos(ls_Xml_Aux, '</'+as_tag+'>') +  LenA(as_tag)+3)
Next
 Return ls_Result
end function

public function string of_get_value_tag_pipe (string as_xml, string as_tag);string  ls_Result

as_Tag = gf_Replace(as_Tag, '/', '', 0)
as_Tag = gf_Replace(as_Tag, '|', '', 0)

ls_Result = Mid(	as_xml,  &
 						Pos(as_xml, '|'+as_tag+'|')+LenA(as_tag)+2, &
 						Pos(as_xml, '|/'+as_tag+'|') - (Pos(as_xml, '|'+as_tag+'|')+LenA(as_tag)+2))

Return ls_Result
end function

public function string gf_replace_rastro (string ps_assunto, string ps_pesquisa, string ps_substitui, integer pl_qtde);Long	lvl_Pos1, &
		lvl_Pos2

lvl_Pos1 = Pos(ps_Assunto, '<rastro>')
lvl_Pos2 = Pos(ps_Assunto, '</rastro>')

// Verifica se ambos os marcadores foram encontrados
If lvl_Pos1 > 0 and lvl_Pos2 > 0 Then
  // Remove a primeira ocorr$$HEX1$$ea00$$ENDHEX$$ncia entre <rastro> e </rastro>
  ps_Assunto = Mid(ps_Assunto, 1, lvl_Pos1 - 1) + Mid(ps_Assunto, lvl_Pos2 + Len('</rastro>'))
End If

Return ps_Assunto
end function

public function boolean of_read_xml (string a_xml, boolean ab_tudo, ref t_infnfe at_infnfe, ref string as_log);Boolean 	lb_Retorno
Integer 	i
String 	l_Xml, l_XmlAux, l_XmlAux2, l_XmlItens, ls_NitemStr

//Vari$$HEX1$$e100$$ENDHEX$$veis do XML
Dec{2}		ldc_vitem
String    	ls_InfAdProd

t_ide    			lt_Ide
t_emit  				lt_Emit
t_dest    			lt_Dest
t_Prod    			lt_Prod
t_imposto			lt_Imposto
t_total    			lt_Total
t_transp    		lt_Transp
t_cobr    			lt_Cobr
t_infAdic   		lt_InfAdic
t_compra    		lt_Compra
t_DFeReferenciado	lt_DFeReferenciado

 
l_Xml   = gf_Replace(a_Xml, "~r~n ", "", 0)
l_Xml   = gf_Replace(l_Xml, " ~r~n", "", 0)
l_Xml   = gf_Replace(l_Xml, "~n ", "", 0)
l_Xml   = gf_Replace(l_Xml, " ~n", "", 0)
l_Xml   = gf_Replace(l_Xml, "~r ", "", 0)
l_Xml   = gf_Replace(l_Xml, " ~r", "", 0)
l_Xml   = gf_Replace(l_Xml, "~r~n", "", 0)
l_Xml   = gf_Replace(l_Xml, "~n", "", 0)
l_Xml   = gf_Replace(l_Xml, "~r", "", 0)
l_Xml   = gf_Replace(l_Xml, "	", "", 0)

//Tratamento p/ nao importar arquivo que seja de NF-e
If Pos( l_Xml, "<nfeProc" ) <= 0 And Pos( l_Xml, "<TNfeProc" ) <= 0 Then
	is_evento = Upper(of_get_value_tag(l_Xml, '<tpEvento>', 1))
	
	If is_Evento = '110111' Then is_evento = 'CANCELAMENTO'
		
	// Informa$$HEX2$$e700f500$$ENDHEX$$es utilizadas no objeto uo_ge238_importa_xml.
	If is_evento = 'CANCELAMENTO' Then
		//<chNFe>42160684684620000187550020001662381098434732</chNFe>
		is_chave_acesso_canc = of_get_value_tag(l_Xml, '<chNFe>', 1)
		
		If is_chave_acesso_canc <> "" Then
			is_nfe_cte= 'NFE'
		Else
			//<chCTe>42161075000174001125570010003821061008689428</chCTe> 
			is_chave_acesso_canc = of_get_value_tag(l_Xml, '<chCTe>', 1)			
			is_nfe_cte= 'CTE'
		End If
		
		// Retorna Falso porque esta fun$$HEX2$$e700e300$$ENDHEX$$o tamb$$HEX1$$e900$$ENDHEX$$m $$HEX1$$e900$$ENDHEX$$ utilizada na importa$$HEX2$$e700e300$$ENDHEX$$o de nota do pedido eletr$$HEX1$$f400$$ENDHEX$$nico
		Return False
	Else
		is_evento = ''
		Return False
	End If
End If

//*******************************LENDO DADOS DE CABE$$HEX1$$c700$$ENDHEX$$ALHO*******************
l_XmlAux = Mid(l_Xml ,Pos(l_Xml, '<infNFe Id="'),Pos(l_Xml, "<ide>") - Pos(l_Xml, '<infNFe Id="')+4)

If Trim(l_XmlAux) = "" Then
	Return False
End If

at_InfNFe.versao 	= Mid(l_XmlAux, Pos(l_XmlAux, 'versao="')+8, Pos(l_XmlAux, '">') - Pos(l_XmlAux, 'versao="')-8)
is_Versao			= at_InfNFe.versao
at_InfNFe.id		= Mid(l_XmlAux, Pos(l_XmlAux, 'Id="NFe') +7, 44)
l_XmlAux 			= Mid(l_Xml , Pos(l_Xml, '<ide>'), Pos(l_Xml,  '<det nItem="') - Pos(l_Xml, '<ide>'))

If Trim(l_XmlAux) = "" Then
	Return False
End If

If not of_get_header(l_XmlAux, ref lt_Ide, ref lt_Emit, ref lt_Dest) Then
	Return False	
End If	

at_InfNFe.ide  	= lt_Ide
at_InfNFe.emit 	= lt_Emit
at_InfNFe.dest 	= lt_Dest
//**************************************************************************

If not ab_tudo Then
	Return True
End If

//********************************LENDO DADOS DOS ITENS***********************
l_Xml = Mid(l_Xml, Pos(l_Xml, '<det nItem="'), LenA(l_Xml) - Pos(l_Xml,  '<det nItem="')) //Limpa parte j$$HEX1$$e100$$ENDHEX$$ lida

l_XmlItens = l_Xml
i = 1

Do WHILE pos(l_XmlItens, '<det nItem=') > 0
	l_XmlAux    = Mid(l_XmlItens, Pos(l_XmlItens, '<det nItem='), LenA(l_XmlItens))
	l_XmlAux    = Mid(l_XmlAux, 0, Pos(l_XmlAux, '</det>') + 5)
		
	Long ll_Pos1, ll_Pos2
	
	ll_Pos1	= Pos(l_XmlItens, '<det nItem="') + 12
	
	If Pos(l_XmlAux, '" xmlns="http://www.portalfiscal.inf.br/nfe"><prod>') > 0 Then
		ll_Pos2	= Pos(l_XmlAux, '" xmlns="http://www.portalfiscal.inf.br/nfe"><prod>')
	Else
		ll_Pos2	= Pos(l_XmlAux, '"><prod>')
	End If
	ll_Pos2	= ll_Pos2 - ll_Pos1
	
	If ll_Pos1 > 0 Then
		at_InfNFe.det[i].nitem = Mid(l_XmlAux, ll_Pos1, ll_Pos2)
	Else
		Return False //Se n$$HEX1$$e300$$ENDHEX$$o encontrar i item retorna false
	End If
	
	If not of_get_details(ref l_XmlAux, ref lt_Prod, ref lt_Imposto, ref ls_InfAdProd, ref ldc_vitem, ref lt_DFeReferenciado, ref as_log) Then		
		Return False
	End If
	
	at_InfNFe.det[i].prod      		= lt_Prod
	at_InfNFe.det[i].imposto   		= lt_Imposto
	at_InfNFe.det[i].infAdProd 		= ls_InfAdProd
	at_InfNFe.det[i].vitem 				= ldc_vitem
	at_InfNFe.det[i].DFeReferenciado = lt_DFeReferenciado
	
	i += 1
	l_XmlItens = Mid(l_XmlItens, (Pos(l_XmlItens, l_XmlAux) + LenA(l_XmlAux)), LenA(l_XmlItens)) //Limpa a parte j$$HEX1$$e100$$ENDHEX$$ lida
LOOP

//********************************LENDO TOTAIS*******************************
l_Xml = Mid(l_Xml, Pos(l_Xml, '<total>'))

l_XmlAux = Mid(l_Xml, Pos(l_Xml, '<total>'), Pos(l_Xml, '</infNFe>') - Pos(l_Xml, '<total>'))

If not of_get_footer(ref l_XmlAux, ref lt_Total, ref lt_Transp, ref lt_Cobr, ref lt_InfAdic, ref lt_Compra) Then
	Return False
End If

at_InfNFe.ide		= lt_Ide
at_InfNFe.emit		= lt_Emit
at_InfNFe.total	= lt_Total
at_InfNFe.transp	= lt_Transp
at_InfNFe.cobr		= lt_Cobr
at_InfNFe.infAdic	= lt_InfAdic
at_InfNFe.compra	= lt_Compra
//**************************************************************************	
 
Return True
end function

public function boolean of_verificar_rastro_nf (ref string as_mensagem_log, ref string as_habilita_rastro_med_nf);Select COALESCE(vl_parametro, 'N')
Into :as_habilita_rastro_med_nf
From parametro_geral
Where cd_parametro= 'ID_RASTRO_MED_NF'
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_Mensagem_Log = "Erro ao verificar a consulta na tabela parametro_geral: "+ SqlCa.sqlerrtext
	SqlCa.of_RollBack();
	Return False
End If

Return True
end function

private function boolean of_get_details (string a_xml, ref t_prod at_prod, ref t_imposto at_imposto, ref string as_infadprod, ref decimal adc_vitem, ref t_dfereferenciado at_dfereferenciado, ref string as_log);Boolean 	lb_Retorno
Decimal	ldc_PMC, ldc_vitem
Integer 	lnItem, i 
String 	l_XmlAux, l_XmlAux2, l_XmlAux3, l_XmlAux4, l_XmlAux5, l_XmlAux6, ls_Tipo_Icms, ls_verificar_rastro_nf

t_imposto 			lt_Imposto
t_prod 				lt_Prod
t_dfereferenciado lt_dfereferenciado


lb_Retorno = True

Try
	//Inicia vari$$HEX1$$e100$$ENDHEX$$veis
	as_infadprod 			= ""
	at_Imposto 				= lt_Imposto
	at_Prod 					= lt_Prod
	adc_vitem				= ldc_vitem
	at_dfereferenciado	= lt_dfereferenciado
	
	l_XmlAux = a_xml
	
	l_XmlAux2 = Mid(l_XmlAux, Pos(l_XmlAux, '<prod>'), Pos(l_XmlAux, '</prod>') - Pos(l_XmlAux, '<prod>') + LenA('</prod>') )
	
	at_prod.cProd    		=  of_get_value_tag(l_XmlAux2, '<cProd>', 1)
	at_prod.cEAN      		=  of_get_value_tag(l_XmlAux2, '<cEAN>', 1)
	at_prod.xProd     		=  of_get_value_tag(l_XmlAux2, '<xProd>', 1)
	
	If Pos(l_XmlAux2, '<NCM>') > 0 Then
		at_prod.NCM       	=  Long(of_get_value_tag(l_XmlAux2, '<NCM>', 1))
	End If	 
	If Pos(Upper(l_XmlAux2), '<CEST>') > 0 Then
		at_prod.CEST       	=  of_get_value_tag(l_XmlAux2, '<CEST>', 1)
	End If	
	
	at_prod.EXTIPI    		=  of_get_value_tag(l_XmlAux2, '<EXTIPI>' , 1)
	at_prod.CFOP      		=  of_get_value_tag(l_XmlAux2, '<CFOP>', 1)
	at_prod.uCom      		=  of_get_value_tag(l_XmlAux2, '<uCom>', 1)
	at_prod.qCom      		=  of_str_double_value(of_get_value_tag(l_XmlAux2,	'<qCom>', 1))
	at_prod.vUnCom    		=  of_str_double_value(of_get_value_tag(l_XmlAux2,	'<vUnCom>', 1))
	at_prod.vProd     		=  of_str_double_value(of_get_value_tag(l_XmlAux2,	'<vProd>', 1))
	at_prod.cEANTrib  		=  of_get_value_tag(l_XmlAux2, '<cEANTrib>', 1)
	at_prod.uTrib     		=  of_get_value_tag(l_XmlAux2, '<uTrib>', 1)
	at_prod.qTrib     		=  of_str_double_value(of_get_value_tag(l_XmlAux2,	'<qTrib>', 1))
	at_prod.vUnTrib   		=  of_str_double_value(of_get_value_tag(l_XmlAux2,	'<vUnTrib>', 1))
	
	If of_get_value_tag(l_XmlAux2,'vFrete'  ,1) <> '' Then
		at_prod.vFrete    	=  of_str_double_value(of_get_value_tag(l_XmlAux2,	'vFrete', 1))
	End If
	
	If of_get_value_tag(l_XmlAux2,'vSeg', 1) <> '' Then
		at_prod.vSeg      	=  of_str_double_value(of_get_value_tag(l_XmlAux2,	'vSeg', 1))
	End If
	
	If of_get_value_tag(l_XmlAux2,'vDesc'    ,1) <> '' Then
		at_prod.vDesc     	=  of_str_double_value(of_get_value_tag(l_XmlAux2,	'vDesc' , 1))
	End If
	If of_get_value_tag(l_XmlAux2,'vOutro'    ,1) <> '' Then
		at_prod.vOutro    	=  of_str_double_value(of_get_value_tag(l_XmlAux2,	'vOutro', 1))
	End If
	If of_get_value_tag(l_XmlAux2,'<indTot>'    ,1) <> '' Then
		at_prod.indTot    	=  Long(of_get_value_tag(l_XmlAux2,	'<indTot>', 1))
	End If
	
	If of_get_value_tag(l_XmlAux2,'<xPed>'    ,1) <> '' Then
		at_prod.xped    	=  of_get_value_tag(l_XmlAux2,	'<xPed>', 1)
	End If
	
	If of_get_value_tag(l_XmlAux2,'<nItemPed>'    ,1) <> '' Then
		at_prod.nItemPed    	=  Long(of_get_value_tag(l_XmlAux2,	'<nItemPed>', 1))
	End If
	
	If of_get_value_tag(l_XmlAux2,'<cBenef>'    ,1) <> '' Then
		at_prod.cBenef    	=  of_get_value_tag(l_XmlAux2,	'<cBenef>', 1)
	End If
	
	If of_get_value_tag(l_XmlAux2,'<vPMC>'    ,1) <> '' Then
		at_prod.vPMC    	=  of_str_double_value(of_get_value_tag(l_XmlAux2,	'<vPMC>', 1))
	End If
	
	//Lotes de medicamentos
	i = 1
	
	If  Pos(l_XmlAux2, '<rastro') > 0 Then	//Essa tag tem a partir da vers$$HEX1$$e300$$ENDHEX$$o 4.00 da NF-e
		l_XmlAux3 = Mid(l_XmlAux2, Pos(l_XmlAux2, '<med'), Pos(l_XmlAux2, '</med>') - Pos(l_XmlAux2, '<med') + LenA('</med>') )
		If of_get_value_tag(l_XmlAux3,'<vPMC>', 1) <> "" Then
			ldc_PMC	=  of_str_double_value(of_get_value_tag(l_XmlAux3,'<vPMC>', 1))
		Else
			ldc_PMC	= 0.00
		End If
		
		DO WHILE Pos(l_XmlAux2, '<rastro') > 0	
			l_XmlAux3 = Mid(l_XmlAux2, Pos(l_XmlAux2, '<rastro'), Pos(l_XmlAux2, '</rastro>') - Pos(l_XmlAux2, '<rastro') + LenA('</rastro>') )
			If LenA(l_XmlAux3) > 0 Then
				at_prod.med[i].nLote		= gf_Replace(gf_Replace(of_get_value_tag(l_XmlAux3, '<nLote>',	1), '"', "", 0), "'", "", 0)
				at_prod.med[i].qLote		= Double(gf_Replace(of_get_value_tag(l_XmlAux3, '<qLote>',	1), ".", ",", 0))
				at_prod.med[i].dFab		= Date(of_get_value_tag(l_XmlAux3, '<dFab>', 1))
				at_prod.med[i].dVal			= Date(of_get_value_tag(l_XmlAux3,	'<dVal>', 1))
				at_prod.med[i].vPMC		= ldc_PMC
				i += 1
				l_XmlAux2 = gf_Replace_rastro(l_XmlAux2, l_XmlAux3 , '', 0)
			End If
		LOOP		
	Else
		i = 1
		
		If Not this.of_verificar_rastro_nf(Ref as_log, Ref ls_verificar_rastro_nf) Then
			lb_Retorno = False
		Else
			If ls_verificar_rastro_nf = 'S' Then
				DO WHILE Pos(l_XmlAux2, '<med') > 0	
					l_XmlAux3 = Mid(l_XmlAux2, Pos(l_XmlAux2, '<med'), Pos(l_XmlAux2, '</med>') - Pos(l_XmlAux2, '<med>') + LenA('</med>') )
					If LenA(l_XmlAux3) > 0 Then
						If Pos(l_XmlAux2, '<rastro') > 0 Then
							at_prod.med[i].nLote	= gf_Replace(gf_Replace(of_get_value_tag(l_XmlAux3, '<nLote>',	1), '"', "", 0), "'", "", 0)
							at_prod.med[i].qLote	= Double(gf_Replace(of_get_value_tag(l_XmlAux3, '<qLote>',	1), ".", ",", 0))
							at_prod.med[i].dFab	= Date(of_get_value_tag(l_XmlAux3, '<dFab>', 1))
							at_prod.med[i].dVal	= Date(of_get_value_tag(l_XmlAux3,	'<dVal>', 1))
							at_prod.med[i].vPMC	= of_str_double_value(of_get_value_tag(l_XmlAux3,'<vPMC>', 1))
							i += 1
							l_XmlAux2 = gf_Replace(l_XmlAux2, l_XmlAux3 , '', 0)			
						Else
							as_log = 'Erro sem informa$$HEX2$$e700e300$$ENDHEX$$o de lote no item: ' + string(i)
							lb_Retorno = False
							Exit
						End if
					End If
				LOOP
			Else
				DO WHILE Pos(l_XmlAux2, '<med') > 0	
					l_XmlAux3 = Mid(l_XmlAux2, Pos(l_XmlAux2, '<med'), Pos(l_XmlAux2, '</med>') - Pos(l_XmlAux2, '<med>') + LenA('</med>') )
					If LenA(l_XmlAux3) > 0 Then
						at_prod.med[i].nLote	= gf_Replace(gf_Replace(of_get_value_tag(l_XmlAux3, '<nLote>',	1), '"', "", 0), "'", "", 0)
						at_prod.med[i].qLote	= Double(gf_Replace(of_get_value_tag(l_XmlAux3, '<qLote>',	1), ".", ",", 0))
						at_prod.med[i].dFab	= Date(of_get_value_tag(l_XmlAux3, '<dFab>', 1))
						at_prod.med[i].dVal	= Date(of_get_value_tag(l_XmlAux3,	'<dVal>', 1))
						at_prod.med[i].vPMC	= of_str_double_value(of_get_value_tag(l_XmlAux3,'<vPMC>', 1))
						i += 1
						l_XmlAux2 = gf_Replace(l_XmlAux2, l_XmlAux3 , '', 0)	
					End If
				LOOP
			End If
		End If	
	End If
	
	if lb_retorno then
		l_XmlAux2 = Mid(l_XmlAux, Pos(l_XmlAux, '<imposto>')) 
		
		//<ICMS>
		l_XmlAux3 = Mid(l_XmlAux2, Pos(l_XmlAux2, '<ICMS>') + 6, Pos(l_XmlAux2, '</ICMS>') - Pos(l_XmlAux2, '<ICMS>')-6)	
		ls_Tipo_Icms = Mid(l_XmlAux3,  (Pos(l_XmlAux3, '<ICMS')+LenA('<ICMS')), Pos(l_XmlAux3, '>')- (Pos(l_XmlAux3, '<ICMS')+LenA('<ICMS')))	
		at_imposto.ICMS.TipoICMS = ls_Tipo_Icms
		
		If of_get_value_tag(l_XmlAux3, '<orig>', 1) <> '' Then
			at_imposto.ICMS.orig       =  Long(of_get_value_tag(l_XmlAux3, '<orig>', 1)) 
		End If	
		
		If of_get_value_tag(l_XmlAux3, '<CST>', 1) <> '' Then
			at_imposto.ICMS.CST    =  of_get_value_tag(l_XmlAux3, '<CST>', 1)
		Else
			If ls_Tipo_Icms		= "SN101" Then
				at_imposto.ICMS.CST = "41"
			ElseIf ls_Tipo_Icms	= "SN102" Then
				at_imposto.ICMS.CST = "41"
			ElseIf ls_Tipo_Icms	= "SN201" Then
				at_imposto.ICMS.CST = "60"	
			ElseIf ls_Tipo_Icms	= "SN202" Then
				at_imposto.ICMS.CST = "60"
			ElseIf ls_Tipo_Icms	= "SN500" Then
				at_imposto.ICMS.CST = "60"
			End If
		End If	
		
		If of_get_value_tag(l_XmlAux3,'<CSOSN>',         1) <> '' Then
			 at_imposto.ICMS.CSOSN  =  Long(of_get_value_tag(l_XmlAux3, '<CSOSN>', 1))
		End If		
		
		If of_get_value_tag(l_XmlAux3,'<modBC>',         1) <> '' Then
			 at_imposto.ICMS.modBC  =  Long(of_get_value_tag(l_XmlAux3, '<modBC>', 1))
		End If	
		
		If of_get_value_tag(l_XmlAux3,'<pRedBC>',      1) <> '' Then
			 at_imposto.ICMS.pRedBC =  of_str_double_value(of_get_value_tag(l_XmlAux3, '<pRedBC>', 1))
		End If	
		
		If of_get_value_tag(l_XmlAux3,'<vBC>',         1) <> '' Then
			 at_imposto.ICMS.vBC    =  of_str_double_value(of_get_value_tag(l_XmlAux3, '<vBC>', 1))
		End If		
		
		If of_get_value_tag(l_XmlAux3,'<pICMS>',       1) <>'' Then
			 at_imposto.ICMS.pICMS  =  of_str_double_value(of_get_value_tag(l_XmlAux3,	'<pICMS>', 1))
		End If		 
		
		If of_get_value_tag(l_XmlAux3,'<vICMS>',       1) <> '' Then
			 at_imposto.ICMS.vICMS  =  of_str_double_value(of_get_value_tag(l_XmlAux3,	'<vICMS>', 1))
		End If	
		
		If of_get_value_tag(l_XmlAux3,'<pST>',       1) <> '' Then
			 at_imposto.ICMS.pST  =  of_str_double_value(of_get_value_tag(l_XmlAux3,	'<pST>', 1))
		End If	
		
		If of_get_value_tag(l_XmlAux3,'<vICMSSubstituto>',       1) <> '' Then
			 at_imposto.ICMS.vICMSSubstituto  =  of_str_double_value(of_get_value_tag(l_XmlAux3,	'<vICMSSubstituto>', 1))
		End If		
			
		If of_get_value_tag(l_XmlAux3,'<modBCST>',       1) <> '' Then
			 at_imposto.ICMS.modBCST=  Long(of_get_value_tag(l_XmlAux3, '<modBCST>', 1))
		Else
			SetNull(at_imposto.ICMS.modBCST)
		End If	
		
		If of_get_value_tag(l_XmlAux3,'<pMVAST>',      1) <> '' Then
			 at_imposto.ICMS.pMVAST     =  of_str_double_value(of_get_value_tag(l_XmlAux3, '<pMVAST>', 1))
		End If		
		
		If of_get_value_tag(l_XmlAux3,'<pRedBCST>',    1) <> '' Then
			 at_imposto.ICMS.pRedBCST=  of_str_double_value(of_get_value_tag(l_XmlAux3, '<pRedBCST>', 1))
		End If	
		
		If of_get_value_tag(l_XmlAux3,'<vBCST>',       1) <> '' Then
			 at_imposto.ICMS.vBCST   =  of_str_double_value(of_get_value_tag(l_XmlAux3, '<vBCST>', 1))
		End If	
		
		If of_get_value_tag(l_XmlAux3,'<pICMSST>',     1) <> '' Then
			 at_imposto.ICMS.pICMSST =  of_str_double_value(of_get_value_tag(l_XmlAux3, '<pICMSST>', 1))
		End If	
		
		If of_get_value_tag(l_XmlAux3,'<vICMSST>',     1) <> '' Then
			 at_imposto.ICMS.vICMSST =  of_str_double_value(of_get_value_tag(l_XmlAux3, '<vICMSST>', 1))
		End If	
		
		If of_get_value_tag(l_XmlAux3,'<UFST>',        1) <> '' Then
			 at_imposto.ICMS.UFST    =  of_get_value_tag(l_XmlAux3, '<UFST>', 1)
		End If	
		
		If of_get_value_tag(l_XmlAux3,'<pBCOp>',       1) <> '' Then
			 at_imposto.ICMS.pBCOp   =  of_str_double_value(of_get_value_tag(l_XmlAux3, '<pBCOp>', 1))
		End If	
		
		If of_get_value_tag(l_XmlAux3,'<vBCSTRet>',    1) <> '' Then
			 at_imposto.ICMS.vBCSTRet=  of_str_double_value(of_get_value_tag(l_XmlAux3, '<vBCSTRet>', 1))
		End If	
		
		If of_get_value_tag(l_XmlAux3,'<vICMSSTRet>',  1) <> '' Then
			 at_imposto.ICMS.vICMSSTRet =  of_str_double_value(of_get_value_tag(l_XmlAux3,	'<vICMSSTRet>',  	1))
		End If	
		
		If of_get_value_tag(l_XmlAux3,'<motDesICMS>',  1) <> '' Then
			 at_imposto.ICMS.motDesICMS =  of_get_value_tag(l_XmlAux3, '<motDesICMS>',  1)
		End If	
		
		If of_get_value_tag(l_XmlAux3,'<pCredSN>',     1) <> '' Then
			 at_imposto.ICMS.pCredSN =  of_str_double_value(of_get_value_tag(l_XmlAux3, '<pCredSN>', 1))
		End If	
		
		If of_get_value_tag(l_XmlAux3,'<vCredICMSSN>', 1) <> '' Then
			 at_imposto.ICMS.vCredICMSSN=  of_str_double_value(of_get_value_tag(l_XmlAux3,	'<vCredICMSSN>', 1))
		End If	
		
		If of_get_value_tag(l_XmlAux3,'<vICMSDeson>', 1) <> '' Then
			 at_imposto.ICMS.vICMSDeson =  of_str_double_value(of_get_value_tag(l_XmlAux3,	'<vICMSDeson>', 1))
		End If	
		
		If of_get_value_tag(l_XmlAux3,'<vICMSOp>', 1) <> '' Then
			 at_imposto.ICMS.vICMSOp =  of_str_double_value(of_get_value_tag(l_XmlAux3,	'<vICMSOp>', 1))
		End If	
		
		If of_get_value_tag(l_XmlAux3,'<pDif>', 1) <> '' Then
			 at_imposto.ICMS.pDif =  of_str_double_value(of_get_value_tag(l_XmlAux3,	'<pDif>', 1))
		End If	
		
		If of_get_value_tag(l_XmlAux3,'<vICMSDif>', 1) <> '' Then
			 at_imposto.ICMS.vICMSDif =  of_str_double_value(of_get_value_tag(l_XmlAux3,	'<vICMSDif>', 1))
		End If	
		
		If of_get_value_tag(l_XmlAux3,'<vBCFCP>', 1) <> '' Then
			 at_imposto.ICMS.vBCFCP =  of_str_double_value(of_get_value_tag(l_XmlAux3,	'<vBCFCP>', 1))
		End If	
		
		If of_get_value_tag(l_XmlAux3,'<pFCP>', 1) <> '' Then
			 at_imposto.ICMS.pFCP =  of_str_double_value(of_get_value_tag(l_XmlAux3,	'<pFCP>', 1))
		End If	
		
		If of_get_value_tag(l_XmlAux3,'<vFCP>', 1) <> '' Then
			 at_imposto.ICMS.vFCP =  of_str_double_value(of_get_value_tag(l_XmlAux3,	'<vFCP>', 1))
		End If	
		
		If of_get_value_tag(l_XmlAux3,'<vBCFCPST>', 1) <> '' Then
			 at_imposto.ICMS.vBCFCPST =  of_str_double_value(of_get_value_tag(l_XmlAux3,	'<vBCFCPST>', 1))
		End If	
		
		If of_get_value_tag(l_XmlAux3,'<pFCPST>', 1) <> '' Then
			 at_imposto.ICMS.pFCPST =  of_str_double_value(of_get_value_tag(l_XmlAux3,	'<pFCPST>', 1))
		End If	
		
		If of_get_value_tag(l_XmlAux3,'<vFCPST>', 1) <> '' Then
			 at_imposto.ICMS.vFCPST =  of_str_double_value(of_get_value_tag(l_XmlAux3,	'<vFCPST>', 1))
		End If	
		
		If of_get_value_tag(l_XmlAux3,'<vBCFCPSTRet>', 1) <> '' Then
			 at_imposto.ICMS.vBCFCPSTRet =  of_str_double_value(of_get_value_tag(l_XmlAux3,	'<vBCFCPSTRet>', 1))
		End If	
		
		If of_get_value_tag(l_XmlAux3,'<pFCPSTRet>', 1) <> '' Then
			 at_imposto.ICMS.pFCPSTRet =  of_str_double_value(of_get_value_tag(l_XmlAux3,	'<pFCPSTRet>', 1))
		End If	
	
		If of_get_value_tag(l_XmlAux3,'<vFCPSTRet>', 1) <> '' Then
			 at_imposto.ICMS.vFCPSTRet =  of_str_double_value(of_get_value_tag(l_XmlAux3,	'<vFCPSTRet>', 1))
		End If		
		
		l_XmlAux3 = Mid(l_XmlAux2, Pos(l_XmlAux2, '<IPI>'),  Pos(l_XmlAux2, '</IPI>') - Pos(l_XmlAux2, '<IPI>') +6)
		
		If LenA(l_XmlAux3) > 0 Then //Tem a tag <IPI>
			If (Pos(l_XmlAux3, 'clEnq') > 0) Then
				at_imposto.IPI.clEnq    = of_get_value_tag(l_XmlAux3, '<clEnq>', 1)
			End If	
			If (Pos(l_XmlAux3, 'CNPJProd') > 0) Then
				at_imposto.IPI.CNPJProd = of_get_value_tag(l_XmlAux3, '<CNPJProd>',	1)
			End If		  
			If (Pos(l_XmlAux3, 'cSelo') > 0) Then
				at_imposto.IPI.cSelo    = of_get_value_tag(l_XmlAux3, '<cSelo>', 1)
			End If		  
			If (Pos(l_XmlAux3, 'qSelo') > 0) Then
				at_imposto.IPI.qSelo    = Long(of_get_value_tag(l_XmlAux3,	'<qSelo>', 1))
			End If		  
			If (Pos(l_XmlAux3, 'cEnq') > 0) Then
				at_imposto.IPI.cEnq     = of_get_value_tag(l_XmlAux3, '<cEnq>', 1)
			End If		  
		
			If Pos(l_XmlAux3, '<IPITrib>') > 0 Then
				l_XmlAux3 = Mid(l_XmlAux3, (Pos(l_XmlAux3, '<IPITrib>') + 9), (Pos(l_XmlAux3, '</IPITrib>') - Pos(l_XmlAux3, '<IPITrib>') - 9))
				at_imposto.IPI.TipoIpi = 'IPITrib'
				at_imposto.IPI.IPITrib.CST   = of_get_value_tag(l_XmlAux3, '<CST>', 1)
				
				If Pos(l_XmlAux3, '<vBC>') > 0 Then
					at_imposto.IPI.IPITrib.vBC   = of_str_double_value(of_get_value_tag(l_XmlAux3, '<vBC>', 1))
					at_imposto.IPI.IPITrib.pIPI  	= of_str_double_value(of_get_value_tag(l_XmlAux3, '<pIPI>', 1))
		
				ElseIf Pos(l_XmlAux3, '<qUnid>') > 0 Then
					at_imposto.IPI.IPITrib.qUnid = of_str_double_value(of_get_value_tag(l_XmlAux3,'<qUnid>', 1))
					at_imposto.IPI.IPITrib.vUnid = of_str_double_value(of_get_value_tag(l_XmlAux3,'<vUnid>', 1))
				End If
				
				at_imposto.IPI.IPITrib.vIPI  = of_str_double_value(of_get_value_tag(l_XmlAux3, '<vIPI>', 1))
		
			Else
				 If Pos(l_XmlAux3, '<IPINT>') > 0 Then
					  at_imposto.IPI.TipoIpi   	= 'IPINT'
					  at_imposto.IPI.IPINT.CST 	= of_get_value_tag(l_XmlAux3, '<CST>', 1)
				End If
			End If
		End If
				
		If Pos(l_XmlAux2, '<PIS>') > 0 Then
			l_XmlAux3 = Mid(l_XmlAux2, Pos(l_XmlAux2, '<PIS>') ,Pos(l_XmlAux2, '</PIS>') - Pos(l_XmlAux2, '<PIS>') + 6)
			
			If Pos(l_XmlAux2, '<PISAliq>') > 0 Then
				at_imposto.PIS.TipoPis			= 'PISAliq'	
				at_imposto.PIS.PISAliq.CST     	= of_get_value_tag(l_XmlAux3,'<CST>' ,1)
				at_imposto.PIS.PISAliq.vBC     	= of_str_double_value(of_get_value_tag(l_XmlAux3,'<vBC>' ,1))
				at_imposto.PIS.PISAliq.pPIS 	= of_str_double_value(of_get_value_tag(l_XmlAux3,'<pPIS>' ,1))
				at_imposto.PIS.PISAliq.vPIS 	= of_str_double_value(of_get_value_tag(l_XmlAux3,'<vPIS>' ,1))
				
			ElseIf Pos(l_XmlAux2, '<PISQtde>') > 0 Then
				at_imposto.PIS.TipoPis					= 'PISQtde'
				at_imposto.PIS.PISQtde.CST       	= of_get_value_tag(l_XmlAux3,'<CST>' ,1)
				at_imposto.PIS.PISQtde.qBCProd  	= of_str_double_value(of_get_value_tag(l_XmlAux3,'<qBCProd>' ,1))
				at_imposto.PIS.PISQtde.vAliqProd 	= of_str_double_value(of_get_value_tag(l_XmlAux3,'<vAliqProd>' ,1))
				at_imposto.PIS.PISQtde.vPIS   		= of_str_double_value(of_get_value_tag(l_XmlAux3,'<vPIS>' ,1))
				
			ElseIf Pos(l_XmlAux2, '<PISNT>') > 0 Then
				at_imposto.PIS.TipoPis				= 'PISNT'
				at_imposto.PIS.PISNT.CST 			= of_get_value_tag(l_XmlAux3,'<CST>' ,1)
				
			ElseIf Pos(l_XmlAux2, '<PISOutr>') > 0 Then
				at_imposto.PIS.TipoPis				= 'PISOutr'
				at_imposto.PIS.PISOutr.CST		= of_get_value_tag(l_XmlAux3,'<CST>' ,1)
				at_imposto.PIS.PISOutr.vBC			= of_str_double_value(of_get_value_tag(l_XmlAux3,'<vBC>' ,1))
				at_imposto.PIS.PISOutr.pPIS		= of_str_double_value(of_get_value_tag(l_XmlAux3,'<pPIS>' ,1))
				at_imposto.PIS.PISOutr.qBCProd	= of_str_double_value(of_get_value_tag(l_XmlAux3,'<qBCProd>' ,1))
				at_imposto.PIS.PISOutr.vAliqProd	= of_str_double_value(of_get_value_tag(l_XmlAux3,'<vAliqProd>' ,1))
				at_imposto.PIS.PISOutr.vPIS		= of_str_double_value(of_get_value_tag(l_XmlAux3,'<vPIS>' ,1))			
			End If	
		End If
		
		//<PISST>
		If Pos(l_XmlAux2, '<PISST>') > 0 Then
			l_XmlAux3 = Mid(l_XmlAux2, Pos(l_XmlAux2, '<PISST>') ,Pos(l_XmlAux2, '</PISST>') - Pos(l_XmlAux2, '<PISST>') + 8)
			 If  of_get_value_tag(l_XmlAux3, '<vBC>' ,1) <> '' Then
				at_imposto.PISST.vBC       	= of_str_double_value(of_get_value_tag(l_XmlAux3,'<vBC>' ,1))
			End If
			If  of_get_value_tag(l_XmlAux3,'<pPIS>' ,1) <> '' Then
				at_imposto.PISST.pPIS      	= of_str_double_value(of_get_value_tag(l_XmlAux3,'<pPIS>' ,1))
			End If
			If  of_get_value_tag(l_XmlAux3,'<qBCProd>' ,1) <> '' Then
				at_imposto.PISST.qBCProd   = of_str_double_value(of_get_value_tag(l_XmlAux3,'<qBCProd>' ,1))
			End If
			If  of_get_value_tag(l_XmlAux3,'<vAliqProd>' ,1) <> '' Then
				at_imposto.PISST.vAliqProd = of_str_double_value(of_get_value_tag(l_XmlAux3,'<vAliqProd>' ,1))
			End If
			If  of_get_value_tag(l_XmlAux3,'<vPIS>' ,1) <> '' Then
				at_imposto.PISST.vPIS      	= of_str_double_value(of_get_value_tag(l_XmlAux3,'<vPIS>' ,1))
			End If
		End If
			
		If Pos(l_XmlAux2, '<COFINS>') > 0 Then
			l_XmlAux3 = Mid(l_XmlAux2, Pos(l_XmlAux2, '<COFINS>') ,Pos(l_XmlAux2, '</COFINS>') - Pos(l_XmlAux2, '<COFINS>') + 9)
			
			If Pos(l_XmlAux2, '<COFINSAliq>') > 0 Then
				at_imposto.COFINS.TipoCofins					= 'COFINSAliq'	
				at_imposto.COFINS.COFINSAliq.CST     		= of_get_value_tag(l_XmlAux3,'<CST>' ,1)
				at_imposto.COFINS.COFINSAliq.vBC     		= of_str_double_value(of_get_value_tag(l_XmlAux3,'<vBC>' ,1))
				at_imposto.COFINS.COFINSAliq.pCOFINS 	= of_str_double_value(of_get_value_tag(l_XmlAux3,'<pCOFINS>' ,1))
				at_imposto.COFINS.COFINSAliq.vCOFINS 	= of_str_double_value(of_get_value_tag(l_XmlAux3,'<vCOFINS>' ,1))
				
			ElseIf Pos(l_XmlAux2, '<COFINSQtde>') > 0 Then
				at_imposto.COFINS.TipoCofins					= 'COFINSQtde'
				at_imposto.COFINS.COFINSQtde.CST       	= of_get_value_tag(l_XmlAux3,'<CST>' ,1)
				at_imposto.COFINS.COFINSQtde.qBCProd   	= of_str_double_value(of_get_value_tag(l_XmlAux3,'<qBCProd>' ,1))
				at_imposto.COFINS.COFINSQtde.vAliqProd 	= of_str_double_value(of_get_value_tag(l_XmlAux3,'<vAliqProd>' ,1))
				at_imposto.COFINS.COFINSQtde.vCOFINS   = of_str_double_value(of_get_value_tag(l_XmlAux3,'<vCOFINS>' ,1))
				
			ElseIf Pos(l_XmlAux2, '<COFINSNT>') > 0 Then
				at_imposto.COFINS.TipoCofins					= 'COFINSNT'
				at_imposto.COFINS.COFINSNT.CST 			= of_get_value_tag(l_XmlAux3,'<CST>' ,1)
				
			ElseIf Pos(l_XmlAux2, '<COFINSOutr>') > 0 Then
				at_imposto.COFINS.TipoCofins					= 'COFINSOutr'
				at_imposto.COFINS.COFINSOutr.CST			= of_get_value_tag(l_XmlAux3,'<CST>' ,1)
				at_imposto.COFINS.COFINSOutr.vBC			= of_str_double_value(of_get_value_tag(l_XmlAux3,'<vBC>' ,1))
				at_imposto.COFINS.COFINSOutr.pCOFINS	= of_str_double_value(of_get_value_tag(l_XmlAux3,'<pCOFINS>' ,1))
				at_imposto.COFINS.COFINSOutr.qBCProd	= of_str_double_value(of_get_value_tag(l_XmlAux3,'<qBCProd>' ,1))
				at_imposto.COFINS.COFINSOutr.vAliqProd	= of_str_double_value(of_get_value_tag(l_XmlAux3,'<vAliqProd>' ,1))
				at_imposto.COFINS.COFINSOutr.vCOFINS	= of_str_double_value(of_get_value_tag(l_XmlAux3,'<vCOFINS>' ,1))			
			End If	
		End If
		
		//<COFINSST>
		If Pos(l_XmlAux2, '<COFINSST>') > 0 Then
			l_XmlAux3 = Mid(l_XmlAux2, Pos(l_XmlAux2, '<COFINSST>') ,Pos(l_XmlAux2, '</COFINSST>') - Pos(l_XmlAux2, '<COFINSST>') + 11)	
			 
			at_imposto.COFINSST.vBC        	= of_str_double_value(of_get_value_tag(l_XmlAux3,'<vBC>'       ,1))
			at_imposto.COFINSST.pCOFINS    = of_str_double_value(of_get_value_tag(l_XmlAux3,'<pCOFINS>'   ,1))
			at_imposto.COFINSST.qBCProd    	= of_str_double_value(of_get_value_tag(l_XmlAux3,'<qBCProd>'   ,1))
			at_imposto.COFINSST.vAliqProd  	= of_str_double_value(of_get_value_tag(l_XmlAux3,'<vAliqProd>' ,1))
			at_imposto.COFINSST.vCOFINS    = of_str_double_value(of_get_value_tag(l_XmlAux3,'<vCOFINS>'   ,1))
		End If
		
		//<ISSQN>
		If Pos(l_XmlAux2, '<ISSQN>') > 0 Then
			l_XmlAux3 = Mid(l_XmlAux2, Pos(l_XmlAux2, '<ISSQN>') ,Pos(l_XmlAux2, '</ISSQN>') - Pos(l_XmlAux2, '<ISSQN>') + 8)
			
			at_imposto.ISSQN.vBC       		= of_str_double_value(of_get_value_tag(l_XmlAux3,'<vBC>'    ,1))
			at_imposto.ISSQN.vAliq     		= of_str_double_value(of_get_value_tag(l_XmlAux3,'<vAliq>'  ,1))
			at_imposto.ISSQN.vISSQN    		= of_str_double_value(of_get_value_tag(l_XmlAux3,'<vISSQN>' ,1))
			at_imposto.ISSQN.cMunFG    		= Long(of_get_value_tag(l_XmlAux3,'<cMunFG>' ,1))
			at_imposto.ISSQN.cListServ 		= Long(of_get_value_tag(l_XmlAux3,'<cListServ>' ,1))
			at_imposto.ISSQN.cSitTrib  		= of_get_value_tag(l_XmlAux3,'<cSitTrib>' ,1)
		End If
		
		//<IS>
		If Pos(l_XmlAux2, '<IS>') > 0 Then
			l_XmlAux3 = Mid(l_XmlAux2, Pos(l_XmlAux2, '<IS>') ,Pos(l_XmlAux2, '</IS>') - Pos(l_XmlAux2, '<IS>') + 5)
			
			at_imposto.isel.CSTIS       	= of_get_value_tag(l_XmlAux3,'<CSTIS>' ,1)
			at_imposto.isel.cClassTribIS  = of_get_value_tag(l_XmlAux3,'<cClassTribIS>' ,1)
			at_imposto.isel.vBCIS     		= of_str_double_value(of_get_value_tag(l_XmlAux3,'<vBCIS>' ,1))
			at_imposto.isel.pIS     		= of_str_double_value(of_get_value_tag(l_XmlAux3,'<pIS>' ,1))
			at_imposto.isel.pISEspec     	= of_str_double_value(of_get_value_tag(l_XmlAux3,'<pISEspec>' ,1))
			
			at_imposto.isel.uTrib     		= of_get_value_tag(l_XmlAux3,'<uTrib>' ,1)
			at_imposto.isel.qTrib     		= of_str_double_value(of_get_value_tag(l_XmlAux3,'<qTrib>' ,1))
			
			at_imposto.isel.vIS     		= of_str_double_value(of_get_value_tag(l_XmlAux3,'<vIS>' ,1))
		End If 
		
		
		//<IBSCBS>
		If Pos(l_XmlAux2, '<IBSCBS>') > 0 Then
			l_XmlAux3 = Mid(l_XmlAux2, Pos(l_XmlAux2, '<IBSCBS>') ,Pos(l_XmlAux2, '</IBSCBS>') - Pos(l_XmlAux2, '<IBSCBS>') + 9)
			
			at_imposto.ibscbs.CST       	= of_get_value_tag(l_XmlAux3,'<CST>' ,1)
			at_imposto.ibscbs.cClassTrib  = of_get_value_tag(l_XmlAux3,'<cClassTrib>' ,1)

			If Pos(l_XmlAux3, '<gIBSCBS>') > 0 Then
				l_XmlAux4 = Mid(l_XmlAux3, Pos(l_XmlAux3, '<gIBSCBS>') ,Pos(l_XmlAux3, '</gIBSCBS>') - Pos(l_XmlAux3, '<gIBSCBS>') + 10)
				
				at_imposto.ibscbs.gIBSCBS.vBC	= of_str_double_value(of_get_value_tag(l_XmlAux4,'<vBC>' ,1))
				
				If Pos(l_XmlAux4, '<gIBSUF>') > 0 Then
					l_XmlAux5 = Mid(l_XmlAux4, Pos(l_XmlAux4, '<gIBSUF>') ,Pos(l_XmlAux4, '</gIBSUF>') - Pos(l_XmlAux4, '<gIBSUF>') + 9)
					
					at_imposto.ibscbs.gIBSCBS.gIBSUF.pIBSUF = of_str_double_value(of_get_value_tag(l_XmlAux5,'<pIBSUF>' ,1))
					
					If Pos(l_XmlAux5, '<gDif>') > 0 Then
						l_XmlAux6 = Mid(l_XmlAux5, Pos(l_XmlAux5, '<gDif>') ,Pos(l_XmlAux5, '</gDif>') - Pos(l_XmlAux5, '<gDif>') + 7)
						
						at_imposto.ibscbs.gIBSCBS.gIBSUF.gDif.pDif = of_str_double_value(of_get_value_tag(l_XmlAux6,'<pDif>' ,1))
						at_imposto.ibscbs.gIBSCBS.gIBSUF.gDif.vDif = of_str_double_value(of_get_value_tag(l_XmlAux6,'<vDif>' ,1))
					End If
					
					If Pos(l_XmlAux5, '<gDevTrib>') > 0 Then
						l_XmlAux6 = Mid(l_XmlAux5, Pos(l_XmlAux5, '<gDevTrib>') ,Pos(l_XmlAux5, '</gDevTrib>') - Pos(l_XmlAux5, '<gDevTrib>') + 11)
						
						at_imposto.ibscbs.gIBSCBS.gIBSUF.gDevTrib.vDevTrib = of_str_double_value(of_get_value_tag(l_XmlAux6,'<vDevTrib>' ,1))
					End If
					
					If Pos(l_XmlAux5, '<gRed>') > 0 Then
						l_XmlAux6 = Mid(l_XmlAux5, Pos(l_XmlAux5, '<gRed>') ,Pos(l_XmlAux5, '</gRed>') - Pos(l_XmlAux5, '<gRed>') + 7)
						
						at_imposto.ibscbs.gIBSCBS.gIBSUF.gRed.pRedAliq = of_str_double_value(of_get_value_tag(l_XmlAux6,'<pRedAliq>' ,1))
						at_imposto.ibscbs.gIBSCBS.gIBSUF.gRed.pAliqEfet = of_str_double_value(of_get_value_tag(l_XmlAux6,'<pAliqEfet>' ,1))
					End If
					
					If Pos(l_XmlAux5, '<vIBSUF>') > 0 Then
						at_imposto.ibscbs.gIBSCBS.gIBSUF.vIBSUF = of_str_double_value(of_get_value_tag(l_XmlAux5,'<vIBSUF>' ,1))
					end if
				End If
				
				If Pos(l_XmlAux4, '<gIBSMun>') > 0 Then
					l_XmlAux5 = Mid(l_XmlAux4, Pos(l_XmlAux4, '<gIBSMun>') ,Pos(l_XmlAux4, '</gIBSMun>') - Pos(l_XmlAux4, '<gIBSMun>') + 10)
					
					at_imposto.ibscbs.gIBSCBS.gIBSMun.pIBSMun = of_str_double_value(of_get_value_tag(l_XmlAux5,'<pIBSMun>' ,1))
					
					If Pos(l_XmlAux5, '<gDif>') > 0 Then
						l_XmlAux6 = Mid(l_XmlAux5, Pos(l_XmlAux5, '<gDif>') ,Pos(l_XmlAux5, '</gDif>') - Pos(l_XmlAux5, '<gDif>') + 7)
						
						at_imposto.ibscbs.gIBSCBS.gIBSMun.gDif.pDif = of_str_double_value(of_get_value_tag(l_XmlAux6,'<pDif>' ,1))
						at_imposto.ibscbs.gIBSCBS.gIBSMun.gDif.vDif = of_str_double_value(of_get_value_tag(l_XmlAux6,'<vDif>' ,1))
					End If
					
					If Pos(l_XmlAux5, '<gDevTrib>') > 0 Then
						l_XmlAux6 = Mid(l_XmlAux5, Pos(l_XmlAux5, '<gDevTrib>') ,Pos(l_XmlAux5, '</gDevTrib>') - Pos(l_XmlAux5, '<gDevTrib>') + 11)
						
						at_imposto.ibscbs.gIBSCBS.gIBSMun.gDevTrib.vDevTrib = of_str_double_value(of_get_value_tag(l_XmlAux6,'<vDevTrib>' ,1))
					End If
					
					If Pos(l_XmlAux5, '<gRed>') > 0 Then
						l_XmlAux6 = Mid(l_XmlAux5, Pos(l_XmlAux5, '<gRed>') ,Pos(l_XmlAux5, '</gRed>') - Pos(l_XmlAux5, '<gRed>') + 7)
						
						at_imposto.ibscbs.gIBSCBS.gIBSMun.gRed.pRedAliq = of_str_double_value(of_get_value_tag(l_XmlAux6,'<pRedAliq>' ,1))
						at_imposto.ibscbs.gIBSCBS.gIBSMun.gRed.pAliqEfet = of_str_double_value(of_get_value_tag(l_XmlAux6,'<pAliqEfet>' ,1))
					End If
					
					If Pos(l_XmlAux5, '<vIBSMun>') > 0 Then
						at_imposto.ibscbs.gIBSCBS.gIBSMun.vIBSMun = of_str_double_value(of_get_value_tag(l_XmlAux5,'<vIBSMun>' ,1))
					end if
				End If
				
				If Pos(l_XmlAux4, '<vIBS>') > 0 Then
					at_imposto.ibscbs.gIBSCBS.vIBS = of_str_double_value(of_get_value_tag(l_XmlAux4,'<vIBS>' ,1))
				End If
			End If
			
			If Pos(l_XmlAux3, '<gCBS>') > 0 Then
				l_XmlAux4 = Mid(l_XmlAux3, Pos(l_XmlAux3, '<gCBS>') ,Pos(l_XmlAux3, '</gCBS>') - Pos(l_XmlAux3, '<gCBS>') + 7)
				
				at_imposto.ibscbs.gIBSCBS.gCBS.pCBS = of_str_double_value(of_get_value_tag(l_XmlAux3,'<pCBS>' ,1))
				
				If Pos(l_XmlAux4, '<gDif>') > 0 Then
					l_XmlAux5 = Mid(l_XmlAux4, Pos(l_XmlAux4, '<gDif>') ,Pos(l_XmlAux4, '</gDif>') - Pos(l_XmlAux4, '<gDif>') + 7)
					
					at_imposto.ibscbs.gIBSCBS.gCBS.gDif.pDif = of_str_double_value(of_get_value_tag(l_XmlAux5,'<pDif>' ,1))
					at_imposto.ibscbs.gIBSCBS.gCBS.gDif.vDif = of_str_double_value(of_get_value_tag(l_XmlAux5,'<vDif>' ,1))
				End If
				
				If Pos(l_XmlAux4, '<gDevTrib>') > 0 Then
					l_XmlAux5 = Mid(l_XmlAux4, Pos(l_XmlAux4, '<gDevTrib>') ,Pos(l_XmlAux4, '</gDevTrib>') - Pos(l_XmlAux4, '<gDevTrib>') + 11)
					
					at_imposto.ibscbs.gIBSCBS.gCBS.gDevTrib.vDevTrib = of_str_double_value(of_get_value_tag(l_XmlAux5,'<vDevTrib>' ,1))
				End If
				
				If Pos(l_XmlAux4, '<gRed>') > 0 Then
					l_XmlAux5 = Mid(l_XmlAux4, Pos(l_XmlAux4, '<gRed>') ,Pos(l_XmlAux4, '</gRed>') - Pos(l_XmlAux4, '<gRed>') + 7)
					
					at_imposto.ibscbs.gIBSCBS.gCBS.gRed.pRedAliq = of_str_double_value(of_get_value_tag(l_XmlAux5,'<pRedAliq>' ,1))
					at_imposto.ibscbs.gIBSCBS.gCBS.gRed.pAliqEfet = of_str_double_value(of_get_value_tag(l_XmlAux5,'<pAliqEfet>' ,1))
				End If
				
				If Pos(l_XmlAux4, '<vCBS>') > 0 Then
					at_imposto.ibscbs.gIBSCBS.gCBS.vCBS = of_str_double_value(of_get_value_tag(l_XmlAux4,'<vCBS>' ,1))
				End If
			End If
			
			If Pos(l_XmlAux3, '<gTribRegular>') > 0 Then
				l_XmlAux4 = Mid(l_XmlAux3, Pos(l_XmlAux3, '<gTribRegular>') ,Pos(l_XmlAux3, '</gTribRegular>') - Pos(l_XmlAux3, '<gTribRegular>') + 15)
				
				at_imposto.ibscbs.gIBSCBS.gTribRegular.CSTReg = of_get_value_tag(l_XmlAux4,'<CSTReg>' ,1)
				at_imposto.ibscbs.gIBSCBS.gTribRegular.cClassTribReg = of_get_value_tag(l_XmlAux4,'<cClassTribReg>' ,1)
				at_imposto.ibscbs.gIBSCBS.gTribRegular.pAliqEfetRegIBSUF = of_str_double_value(of_get_value_tag(l_XmlAux4,'<pAliqEfetRegIBSUF>' ,1))
				at_imposto.ibscbs.gIBSCBS.gTribRegular.vTribRegIBSUF = of_str_double_value(of_get_value_tag(l_XmlAux4,'<vTribRegIBSUF>' ,1))
				at_imposto.ibscbs.gIBSCBS.gTribRegular.pAliqEfetRegIBSMun = of_str_double_value(of_get_value_tag(l_XmlAux4,'<pAliqEfetRegIBSMun>' ,1))
				at_imposto.ibscbs.gIBSCBS.gTribRegular.vTribRegIBSMun = of_str_double_value(of_get_value_tag(l_XmlAux4,'<vTribRegIBSMun>' ,1))
				at_imposto.ibscbs.gIBSCBS.gTribRegular.pAliqEfetRegCBS = of_str_double_value(of_get_value_tag(l_XmlAux4,'<pAliqEfetRegCBS>' ,1))
				at_imposto.ibscbs.gIBSCBS.gTribRegular.vTribRegCBS = of_str_double_value(of_get_value_tag(l_XmlAux4,'<vTribRegCBS>' ,1))
			End If
		End If 
		
		If pos(l_XmlAux, '<infAdProd>') > 0 Then
			as_infadprod = of_get_value_tag(l_XmlAux,'<infAdProd>' ,1)
			
			//Se n$$HEX1$$e300$$ENDHEX$$o tinha a tag <med>, pega o lote do produto nas informa$$HEX2$$e700f500$$ENDHEX$$es adicionais do produto
			If Pos('<med', l_XmlAux) <= 0 Then
				
				If of_Get_Value_Tag_Pipe(as_infadprod, '|nLote|') <> '' Then
					at_prod.med[1].nLote   = of_Get_Value_Tag_Pipe(as_infadprod, '|nLote|')
				End If
				
				If of_Get_Value_Tag_Pipe(as_infadprod, '|qLote|') <> '' Then
					at_prod.med[1].qLote   = Double(gf_Replace(of_Get_Value_Tag_Pipe(as_infadprod, '|qLote|'), ".", ",", 0))
				End If
				
				If of_Get_Value_Tag_Pipe(as_infadprod, '|dFab|') <> '' Then
					at_prod.med[1].dFab   = Date(of_Get_Value_Tag_Pipe(as_infadprod, '|dFab|'))
				End If
				
				If of_Get_Value_Tag_Pipe(as_infadprod, '|dVal|') <> '' Then
					at_prod.med[1].dVal   = Date(of_Get_Value_Tag_Pipe(as_infadprod, '|dVal|'))
				End If
			End If
		End If
		
		If pos(l_XmlAux, '<vItem>') > 0 Then
			adc_vitem = of_str_double_value(of_get_value_tag(l_XmlAux,'<vItem>',1))
		end if
		
		If pos(l_XmlAux, '<DFeReferenciado>') > 0 Then
			l_XmlAux2 = Mid(l_XmlAux, Pos(l_XmlAux, '<DFeReferenciado>'))
			
			at_dfereferenciado.chaveAcesso = of_get_value_tag(l_XmlAux2,'<chaveAcesso>' ,1)
			at_dfereferenciado.nItem = of_get_value_tag(l_XmlAux2,'<nItem>' ,1)
		end if
	End if
	
catch ( runtimeerror  lo_rte )
	lb_Retorno = False
//	MessageBox (	"Erro", "Ocorreu erro ao localizar os itens da nota ~r~r"+ & 						
// 						"Erro: "+lo_rte.GetMessage( ))
Finally
	
	Return lb_Retorno
End Try
end function

on dc_uo_nfe.create
call super::create
TriggerEvent( this, "constructor" )
end on

on dc_uo_nfe.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

