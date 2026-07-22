HA$PBExportHeader$uo_ge195_cte.sru
forward
global type uo_ge195_cte from nonvisualobject
end type
end forward

global type uo_ge195_cte from nonvisualobject
end type
global uo_ge195_cte uo_ge195_cte

type variables
Integer ii_log
end variables

forward prototypes
public function string of_get_value_tag (string as_xml, string as_tag, integer ai_pos)
public function double of_str_double_value (string as_value)
public function boolean of_read_xml (string as_xml, ref t_cte at_cte)
public function boolean of_localiza_codigo_fornecedor (string as_cnpj, ref string as_fornecedor, ref string as_mensagem_log)
public function boolean of_processa_cte (string as_chave_acesso)
public function boolean of_abre_log ()
public function boolean of_grava_log (string as_mensagem)
public function boolean of_conhecimento_importado (string as_emitente, long al_conhecimento, string as_serie, ref string as_mensagem_log)
public function boolean of_localiza_rem_dest (string as_cnpj, string as_tipo, ref long al_filial, ref string as_mensagem_log)
end prototypes

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

public function double of_str_double_value (string as_value);Double ls_Value
If as_Value <> "" Then
	ls_Value = Double(gf_Replace(as_Value, ".", ",", 0))
Else
	ls_Value = 0.00
End If	
Return ls_Value
end function

public function boolean of_read_xml (string as_xml, ref t_cte at_cte);String 	ls_Xml,&
			ls_XmlAux,&
			ls_XmlAux_1
			
Integer i			

ls_Xml   = gf_Replace(as_Xml, "~r~n", "", 0)

ls_Xml   = gf_Replace(ls_Xml, "~n", "", 0)

ls_Xml   = gf_Replace(ls_Xml, "~r", "", 0)

//Tratamento p/ nao importar arquivo que n$$HEX1$$e300$$ENDHEX$$o seja de CT-e
If Pos( ls_Xml, "<infCte" ) <= 0  Then
	Return False
End If

Try	
	//at_CTe.id = Mid(ls_Xml ,Pos(ls_Xml, "<infCte Id=")+15, 44)
	
	//at_CTe.id = Mid(ls_Xml ,Pos(ls_Xml, "<infCte versao=")+29, 44)
	
	at_CTe.id = of_get_value_tag(ls_Xml, "<chCTe>", 1)
		
	//ide
	ls_XmlAux = Mid(ls_Xml ,Pos(ls_Xml, "<ide>"),Pos(ls_Xml, "</ide>") - Pos(ls_Xml, "<ide>")+LenA('</ide>'))
	at_CTe.ide.cUF 		= Long(of_get_value_tag(ls_XmlAux, "<cUF>", 1))
	at_CTe.ide.cCT			= Long(of_get_value_tag(ls_XmlAux, "<cCT>", 1))
	at_CTe.ide.CFOP 		= Long(of_get_value_tag(ls_XmlAux, "<CFOP>", 1))
	at_CTe.ide.natOp 		= of_get_value_tag(ls_XmlAux, "<natOp>", 1)
	at_CTe.ide.forPag 		= Long(of_get_value_tag(ls_XmlAux, "<forPag>", 1))
	at_CTe.ide.mod 		= Long(of_get_value_tag(ls_XmlAux, "<mod>", 1))
	at_CTe.ide.serie 		= of_get_value_tag(ls_XmlAux, "<serie>", 1)
	at_CTe.ide.nCT			= Long(of_get_value_tag(ls_XmlAux, "<nCT>", 1))
	at_CTe.ide.dhEmi 		= of_get_value_tag(ls_XmlAux, "<dhEmi>", 1)
	at_CTe.ide.cMunEnv 	= Long(of_get_value_tag(ls_XmlAux, "<cMunEnv>", 1))
	at_CTe.ide.xMunEnv 	= of_get_value_tag(ls_XmlAux, "<xMunEnv>", 1)
	at_CTe.ide.UFEnv 		= of_get_value_tag(ls_XmlAux, "<UFEnv>", 1)
	
	//toma03
	ls_XmlAux = Mid(ls_Xml ,Pos(ls_Xml, "<toma03>"),Pos(ls_Xml, "</toma03>") - Pos(ls_Xml, "<toma03>")+LenA('</toma03>'))
	at_CTe.toma03.toma = Long(of_get_value_tag(ls_XmlAux, "<toma>", 1))
	
	//compl
	ls_XmlAux = Mid(ls_Xml ,Pos(ls_Xml, "<compl>"),Pos(ls_Xml, "</compl>") - Pos(ls_Xml, "<compl>")+LenA('</compl>'))
	at_CTe.compl.xObs		= of_get_value_tag(ls_XmlAux, "<xObs>", 1)
	
	//emit
	ls_XmlAux = Mid(ls_Xml ,Pos(ls_Xml, "<emit>"),Pos(ls_Xml, "</emit>") - Pos(ls_Xml, "<emit>")+7)
	at_CTe.emit.CNPJ						= of_get_value_tag(ls_XmlAux, "<CNPJ>", 1)
	at_CTe.emit.IE							= of_get_value_tag(ls_XmlAux, "<IE>", 1)
	at_CTe.emit.xNome					= of_get_value_tag(ls_XmlAux, "<xNome>", 1)
	at_CTe.emit.xFant						= of_get_value_tag(ls_XmlAux, "<xFant>", 1)
	
	at_CTe.emit.enderemit.xLgr			= of_get_value_tag(ls_XmlAux, "<xLgr>", 1)
	at_CTe.emit.enderemit.nro			= of_get_value_tag(ls_XmlAux, "<nro>", 1)
	at_CTe.emit.enderemit.xCpl			= of_get_value_tag(ls_XmlAux, "<xCpl>", 1)
	at_CTe.emit.enderemit.xBairro		= of_get_value_tag(ls_XmlAux, "<xBairro>", 1)
	at_CTe.emit.enderemit.cMun		= Long(of_get_value_tag(ls_XmlAux, "<cMun>", 1))
	at_CTe.emit.enderemit.xMun		= of_get_value_tag(ls_XmlAux, "<xMun>", 1)
	at_CTe.emit.enderemit.CEP			= of_get_value_tag(ls_XmlAux, "<CEP>", 1)
	at_CTe.emit.enderemit.UF			= of_get_value_tag(ls_XmlAux, "<UF>", 1)
	at_CTe.emit.enderemit.fone			= of_get_value_tag(ls_XmlAux, "<fone>", 1)
	
	//rem
	ls_XmlAux = Mid(ls_Xml ,Pos(ls_Xml, "<rem>"),Pos(ls_Xml, "</rem>") - Pos(ls_Xml, "<rem>")+ LenA('</rem>'))
	at_CTe.rem.CNPJ						= of_get_value_tag(ls_XmlAux, "<CNPJ>", 1)
	at_CTe.rem.CPF						= of_get_value_tag(ls_XmlAux, "<CPF>", 1)
	at_CTe.rem.IE							= of_get_value_tag(ls_XmlAux, "<IE>", 1)
	at_CTe.rem.xNome					= of_get_value_tag(ls_XmlAux, "<xNome>", 1)
	at_CTe.rem.xFant						= of_get_value_tag(ls_XmlAux, "<xFant>", 1)
	at_CTe.rem.fone						= of_get_value_tag(ls_XmlAux, "<fone>", 1)
	at_CTe.rem.email						= of_get_value_tag(ls_XmlAux, "<email>", 1)
	
	at_CTe.rem.enderreme.xLgr		= of_get_value_tag(ls_XmlAux, "<xLgr>", 1)
	at_CTe.rem.enderreme.nro			= of_get_value_tag(ls_XmlAux, "<nro>", 1)
	at_CTe.rem.enderreme.xCpl		= of_get_value_tag(ls_XmlAux, "<xCpl>", 1)
	at_CTe.rem.enderreme.xBairro		= of_get_value_tag(ls_XmlAux, "<xBairro>", 1)
	at_CTe.rem.enderreme.cMun		= Long(of_get_value_tag(ls_XmlAux, "<cMun>", 1))
	at_CTe.rem.enderreme.xMun		= of_get_value_tag(ls_XmlAux, "<xMun>", 1)
	at_CTe.rem.enderreme.CEP			= of_get_value_tag(ls_XmlAux, "<CEP>", 1)
	at_CTe.rem.enderreme.UF			= of_get_value_tag(ls_XmlAux, "<UF>", 1)
	at_CTe.rem.enderreme.cPais		= Long(of_get_value_tag(ls_XmlAux, "<cPais>", 1))
	at_CTe.rem.enderreme.xPais		= of_get_value_tag(ls_XmlAux, "<xPais>", 1)
	
	//dest
	ls_XmlAux = Mid(ls_Xml ,Pos(ls_Xml, "<dest>"),Pos(ls_Xml, "</dest>") - Pos(ls_Xml, "<dest>")+ LenA('</dest>'))
	at_CTe.dest.CNPJ						= of_get_value_tag(ls_XmlAux, "<CNPJ>", 1)
	at_CTe.dest.CPF						= of_get_value_tag(ls_XmlAux, "<CPF>", 1)
	at_CTe.dest.IE							= of_get_value_tag(ls_XmlAux, "<IE>", 1)
	at_CTe.dest.xNome					= of_get_value_tag(ls_XmlAux, "<xNome>", 1)
	at_CTe.dest.fone						= of_get_value_tag(ls_XmlAux, "<xFant>", 1)
	at_CTe.dest.ISUF						= Long(of_get_value_tag(ls_XmlAux, "<fone>", 1))
	at_CTe.dest.email						= of_get_value_tag(ls_XmlAux, "<email>", 1)
	
	at_CTe.dest.enderdest.xLgr			= of_get_value_tag(ls_XmlAux, "<xLgr>", 1)
	at_CTe.dest.enderdest.nro			= of_get_value_tag(ls_XmlAux, "<nro>", 1)
	at_CTe.dest.enderdest.xCpl			= of_get_value_tag(ls_XmlAux, "<xCpl>", 1)
	at_CTe.dest.enderdest.xBairro		= of_get_value_tag(ls_XmlAux, "<xBairro>", 1)
	at_CTe.dest.enderdest.cMun		= Long(of_get_value_tag(ls_XmlAux, "<cMun>", 1))
	at_CTe.dest.enderdest.xMun		= of_get_value_tag(ls_XmlAux, "<xMun>", 1)
	at_CTe.dest.enderdest.CEP			= of_get_value_tag(ls_XmlAux, "<CEP>", 1)
	at_CTe.dest.enderdest.UF			= of_get_value_tag(ls_XmlAux, "<UF>", 1)
	at_CTe.dest.enderdest.cPais		= Long(of_get_value_tag(ls_XmlAux, "<cPais>", 1))
	at_CTe.dest.enderdest.xPais		= of_get_value_tag(ls_XmlAux, "<xPais>", 1)
	
	//vprest
	ls_XmlAux = Mid(ls_Xml ,Pos(ls_Xml, "<vPrest>"),Pos(ls_Xml, "</vPrest>") - Pos(ls_Xml, "<vPrest>")+ LenA('</vPrest>'))
	at_CTe.vprest.vtprest						= of_str_double_value(of_get_value_tag(ls_XmlAux, "<vTPrest>", 1))
	at_CTe.vprest.vrec						= of_str_double_value(of_get_value_tag(ls_XmlAux, "<vRec>", 1))
	
	i = 1
	
	DO WHILE Pos(ls_XmlAux, '<Comp>') > 0	
		ls_XmlAux_1 = Mid(ls_XmlAux, Pos(ls_XmlAux, '<Comp>'), Pos(ls_XmlAux, '</Comp>') - Pos(ls_XmlAux, '<Comp>') + LenA('</Comp>') )
		If LenA(ls_XmlAux_1) > 0 Then
			at_CTe.vprest.comp[i].xnome				= of_get_value_tag(ls_XmlAux, "<xNome>", 1)
			at_CTe.vprest.comp[i].vcomp				= of_str_double_value(of_get_value_tag(ls_XmlAux, "<vComp>", 1))
			i += 1
			ls_XmlAux = gf_Replace(ls_XmlAux, ls_XmlAux_1 , '', 0)	
		End If
	LOOP
	
	//imp
	ls_XmlAux 		= Mid(ls_Xml ,Pos(ls_Xml, "<imp>"),Pos(ls_Xml, "</imp>") - Pos(ls_Xml, "<imp>")+LenA('</imp>'))
	ls_XmlAux_1 	= Mid(ls_XmlAux, Pos(ls_XmlAux, '<ICMS>') + LenA('<ICMS>'), Pos(ls_XmlAux, '</ICMS>') - Pos(ls_XmlAux, '<ICMS>') - LenA('<ICMS>'))
	at_CTe.icms.tipoicms					= Mid(ls_XmlAux_1,  (Pos(ls_XmlAux_1, '<ICMS')+LenA('<ICMS')), Pos(ls_XmlAux_1, '>')- (Pos(ls_XmlAux_1, '<ICMS')+LenA('<ICMS')))	
	at_CTe.icms.CST						= of_get_value_tag(ls_XmlAux, "<CST>", 1)
	at_CTe.icms.pRedBC					= of_str_double_value(of_get_value_tag(ls_XmlAux, "<pRedBC>", 1))
	at_CTe.icms.vBC						= of_str_double_value(of_get_value_tag(ls_XmlAux, "<vBC>", 1))
	at_CTe.icms.pICMS					= of_str_double_value(of_get_value_tag(ls_XmlAux, "<pICMS>", 1))
	at_CTe.icms.vICMS					= of_str_double_value(of_get_value_tag(ls_XmlAux, "<vICMS>", 1))
	at_CTe.icms.vCred					= of_str_double_value(of_get_value_tag(ls_XmlAux, "<vCred>", 1))
	at_CTe.icms.vBCSTRet				= of_str_double_value(of_get_value_tag(ls_XmlAux, "<vBCSTRet>", 1))
	at_CTe.icms.pICMSSTRet			= of_str_double_value(of_get_value_tag(ls_XmlAux, "<pICMSSTRet>", 1))
	at_CTe.icms.pRedBCOutraUF		= of_str_double_value(of_get_value_tag(ls_XmlAux, "<pRedBCOutraUF>", 1))
	at_CTe.icms.vBCOutraUF				= of_str_double_value(of_get_value_tag(ls_XmlAux, "<vBCOutraUF>", 1))
	at_CTe.icms.pICMSOutraUF			= of_str_double_value(of_get_value_tag(ls_XmlAux, "<pICMSOutraUF>", 1))
	at_CTe.icms.vICMSOutraUF			= of_str_double_value(of_get_value_tag(ls_XmlAux, "<vICMSOutraUF>", 1))
	at_CTe.icms.indSN					= of_str_double_value(of_get_value_tag(ls_XmlAux, "<indSN>", 1))
	
	//infDoc
	ls_XmlAux 		= Mid(ls_Xml ,Pos(ls_Xml, "<infDoc>"),Pos(ls_Xml, "</infDoc>") - Pos(ls_Xml, "<infDoc>")+LenA('</infDoc>'))
	i = 1
	
	DO WHILE Pos(ls_XmlAux, '<infNFe>') > 0	
		ls_XmlAux_1 = Mid(ls_XmlAux, Pos(ls_XmlAux, '<infNFe>'), Pos(ls_XmlAux, '</infNFe>') - Pos(ls_XmlAux, '<infNFe>') + LenA('</infNFe>') )
		If LenA(ls_XmlAux_1) > 0 Then
			at_CTe.infDoc.infNFe[i].chave				= of_get_value_tag(ls_XmlAux, "<chave>", 1)
			i += 1
			ls_XmlAux = gf_Replace(ls_XmlAux, ls_XmlAux_1 , '', 0)	
		End If
	LOOP
	
	//infCarga
	ls_XmlAux = Mid(ls_Xml ,Pos(ls_Xml, "<infCarga>"),Pos(ls_Xml, "</infCarga>") - Pos(ls_Xml, "<infCarga>")+ LenA('</infCarga>'))
	at_CTe.infcarga.vcarga				= of_str_double_value(of_get_value_tag(ls_XmlAux, "<vCarga>", 1))
	at_CTe.infcarga.propred				= of_get_value_tag(ls_XmlAux, "<proPred>", 1)
	at_CTe.infcarga.xoutcat				= of_get_value_tag(ls_XmlAux, "<xOutCat>", 1)
	
	i = 1
	
	DO WHILE Pos(ls_XmlAux, '<infQ>') > 0	
		ls_XmlAux_1 = Mid(ls_XmlAux, Pos(ls_XmlAux, '<infQ>'), Pos(ls_XmlAux, '</infQ>') - Pos(ls_XmlAux, '<infQ>') + LenA('</infQ>') )
		If LenA(ls_XmlAux_1) > 0 Then
			at_CTe.infcarga.infq[i].cUnid				= of_get_value_tag(ls_XmlAux, "<cUnid>", 1)
			at_CTe.infcarga.infq[i].tpMed				= of_get_value_tag(ls_XmlAux, "<tpMed>", 1)
			at_CTe.infcarga.infq[i].qCarga				= of_str_double_value(of_get_value_tag(ls_XmlAux, "<qCarga>", 1))
			i += 1
			ls_XmlAux = gf_Replace(ls_XmlAux, ls_XmlAux_1 , '', 0)	
		End If
	LOOP

Catch (runtimeerror er)   
	MessageBox("Erro", "Erro ao ler o XML da CT-e: ~r~r"+er.GetMessage(), StopSign!)
	Return False
End Try

Return True
end function

public function boolean of_localiza_codigo_fornecedor (string as_cnpj, ref string as_fornecedor, ref string as_mensagem_log);select top 1 cd_fornecedor
into :as_Fornecedor
from fornecedor 
where nr_cgc = :as_Cnpj
order by id_situacao asc
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case -1
		as_mensagem_log = "Erro ao localizar o fornecedor " + SqlCa.SqlErrText
		Return False

	Case 100
		
		as_mensagem_log = "Fornecedor n$$HEX1$$e300$$ENDHEX$$o localizado com o CNPJ " + as_Cnpj
		Return False
End Choose

Return True
end function

public function boolean of_processa_cte (string as_chave_acesso);DateTime ldh_Emissao

Decimal ldc_Total, ldc_Receber, ldc_Bc_Icms, ldc_Red_Base_Icms, ldc_Pc_Icms, ldc_Vl_Icms, ldc_Bc_Icms_St_Retido, ldc_Pc_Red_Bc_Icms_St_Retido, ldc_Icms, ldc_Valor_Componente

Integer li_FileOpen

Long ll_Linha, ll_Itens, ll_Row, ll_Nr_Cte, ll_Nat_Oper, ll_Cd_Form_Pag, ll_Tomador, ll_Nr_Endereco_Emit, ll_Nr_Endereco_Rem, ll_Qt_Volume, ll_Rem, ll_Dest

String ls_Log, ls_Cd_Emitente, ls_Remetente, ls_Xml, ls_Diretorio_XML, ls_Diretorio_Leitura, ls_Chave_Acesso, ls_Serie, ls_Observacao, ls_Nat_Oper, ls_Emit, ls_Rua_Emit, ls_Bairro_Emit, ls_Mun_Emit, ls_Uf_Emit, ls_Cep_Emit, ls_Compl_Emit, ls_Cnpj_Emit, ls_Ie_Emit, ls_Fone_Emit
String ls_Rem, ls_Rua_Rem, ls_Bairro_Rem, ls_Mun_Rem, ls_Uf_Rem, ls_Cep_Rem, ls_Compl_Rem, ls_Cnpj_Rem, ls_Ie_Rem, ls_Fone_Rem, ls_Cd_Cst_Tributacao, ls_Chave_Nota, ls_Nome_Componente, ls_Erro, ls_Cnpj_Dest
String ls_Anexo[]
			
t_cte lt_cte

Try
	of_Abre_Log()
	
	ls_Diretorio_Leitura = ProfileString(gvo_Aplicacao.ivs_Arquivo_INI, 'Diretorio', 'XMLImportacao', "")
	
	ls_Diretorio_Xml = ls_Diretorio_Leitura + as_Chave_Acesso + "-cte.xml"

	li_FileOpen = FileOpen (ls_Diretorio_Xml , TextMode! , Read!, LockRead! )
	FileReadEx (li_FileOpen, ls_Xml)
	FileClose (li_FileOpen)
	
	uo_ge195_cte lo_Cte
	lo_Cte = Create uo_ge195_cte
	
	If Not lo_Cte.of_read_xml(ls_Xml, Ref lt_cte) Then
		ls_Log = "Erro na leitura do CT-e '" + ls_Diretorio_Xml + "'. Fun$$HEX2$$e700e300$$ENDHEX$$o of_processa_cte"
		Return False
	End If
	
	Try
		ls_Chave_Acesso	= lt_cte.id
		ll_Nr_Cte				= lt_cte.ide.nct
		ls_Serie				= lt_cte.ide.serie
		ldh_Emissao			= DateTime(Mid(lt_cte.ide.dhemi,9,2)+"/"+Mid(lt_cte.ide.dhemi,6,2)+"/"+Mid(lt_cte.ide.dhemi,1,4)+" "+Mid(lt_cte.ide.dhemi,12,8))
		ls_Observacao		= lt_cte.compl.xobs
		ll_Nat_Oper			= lt_cte.ide.cfop
		ls_Nat_Oper			= lt_cte.ide.natop
		ll_Cd_Form_Pag	= lt_cte.ide.forpag
		 
		ll_Tomador 				= lt_cte.toma03.toma
		
		ls_Emit					= lt_cte.emit.xnome
		ls_Rua_Emit				= lt_cte.emit.enderemit.xlgr
		ll_Nr_Endereco_Emit	= Long(lt_cte.emit.enderemit.nro)
		ls_Bairro_Emit			= lt_cte.emit.enderemit.xbairro
		ls_Mun_Emit			= lt_cte.emit.enderemit.xmun
		ls_Uf_Emit				= lt_cte.emit.enderemit.uf
		ls_Cep_Emit				= lt_cte.emit.enderemit.cep
		ls_Compl_Emit			= lt_cte.emit.enderemit.xcpl
		ls_Cnpj_Emit			= lt_cte.emit.cnpj
		ls_Ie_Emit				= lt_cte.emit.ie
		ls_Fone_Emit			= lt_cte.emit.enderemit.fone
		
		ls_Rem					= lt_cte.rem.xnome
		ls_Rua_Rem 			= lt_cte.rem.enderreme.xlgr
		ll_Nr_Endereco_Rem	= Long(lt_cte.rem.enderreme.nro)
		ls_Bairro_Rem			= lt_cte.rem.enderreme.xbairro
		ls_Mun_Rem 			= lt_cte.rem.enderreme.xmun
		ls_Uf_Rem				= lt_cte.rem.enderreme.uf
		ls_Cep_Rem 			= lt_cte.rem.enderreme.cep
		ls_Compl_Rem 			= lt_cte.rem.enderreme.xcpl
		ls_Cnpj_Rem 			= lt_cte.rem.cnpj
		ls_Ie_Rem 				= lt_cte.rem.ie
		ls_Fone_Rem 			= lt_cte.rem.fone
		
		ls_Cnpj_Dest 			= lt_cte.dest.cnpj
						
		ldc_Total 								= Round(lt_cte.vprest.vtprest, 2)
		ldc_Receber 							= Round(lt_cte.vprest.vrec, 2)
		ls_Cd_Cst_Tributacao					= lt_cte.icms.tipoicms
		ldc_Bc_Icms								= Round(lt_cte.icms.vbc, 2)
		ldc_Red_Base_Icms					= Round(lt_cte.icms.predbc, 2)
		ldc_Icms									= Round(lt_cte.icms.picms, 2)
		ldc_Vl_Icms								= Round(lt_cte.icms.vicms, 2)
		ldc_Bc_Icms_St_Retido				= Round(lt_cte.icms.vbcstret, 2)
		ldc_Pc_Red_Bc_Icms_St_Retido	= Round(lt_cte.icms.picmsstret, 2)
		
		If Not of_Localiza_Codigo_Fornecedor(ls_Cnpj_Emit, Ref ls_Cd_Emitente, Ref ls_Log) Then
			Return False
		End If
		
		If Not of_Conhecimento_Importado(ls_Cd_Emitente, ll_Nr_Cte, ls_Serie, Ref ls_Log ) Then
			Return False
		End If
		
		If Not of_Localiza_Rem_Dest(ls_Cnpj_Rem, 'REM', Ref ll_Rem, Ref ls_Log) Then
			Return False
		End If
		
		If Not of_Localiza_Rem_Dest(ls_Cnpj_Dest, 'DEST', Ref ll_Dest, Ref ls_Log) Then
			Return False
		End If
		
		ll_Itens = UpperBound(lt_cte.infcarga.infq[])
		
		For ll_Linha = 1 To ll_Itens
			If lt_cte.infcarga.infq[ll_Linha].cUnid = "03" Then
				ll_Qt_Volume = lt_cte.infcarga.infq[ll_Linha].qCarga
			End If
		Next
		
		SetNull(ls_Remetente)
		
		Insert Into conhecimento_transporte(
					cd_emitente,   
					nr_conhecimento,   
					de_serie,   
					dh_emissao,   
					dh_movimentacao_caixa,   
					de_chave_acesso, 
					cd_remetente,   
					nr_natureza_operacao,   
					de_natureza_operacao,   
					cd_forma_pagamento,   
					cd_cst_tributacao,   
					vl_bc_icms,   
					pc_reducao_bc_icms,   
					pc_icms,   
					vl_icms,   
					vl_bc_icms_st_retido,   
					pc_red_bc_icms_st_retido,   
					vl_conhecimento,   
					dh_importacao,   
					qt_volumes,   
					de_observacao,
					nr_tomador,
					cd_filial_remetente,
					cd_filial_destino)
		Values(	:ls_Cd_Emitente,
					:ll_Nr_Cte,   
					:ls_Serie,   
					:ldh_Emissao,  
					GetDate(),
					:ls_Chave_Acesso,   
					:ls_Remetente,   
					:ll_Nat_Oper,   
					:ls_Nat_Oper,   
					:ll_Cd_Form_Pag,   
					:ls_Cd_Cst_Tributacao,   
					:ldc_Bc_Icms,   
					:ldc_Red_Base_Icms,   
					:ldc_Icms,   
					:ldc_Vl_Icms,   
					:ldc_Bc_Icms_St_Retido,   
					:ldc_Pc_Red_Bc_Icms_St_Retido,   
					:ldc_Receber,   
					GetDate(),
					:ll_Qt_Volume,
					:ls_Observacao,
					:ll_Tomador,
					:ll_Rem,
					:ll_Dest)
		Using SqlCa;

		If SqlCa.SqlCode = - 1 Then
			ls_Erro = SqlCa.SqlErrText
			SqlCa.of_RollBack();
			ls_Log = "Erro ao salvar dados do CT-e : " + ls_Erro
			Return False
		End If
		
		ll_Itens = UpperBound(lt_cte.infdoc.infnfe[])
		
		For ll_Linha = 1 To ll_Itens
		
			ls_Chave_Nota = lt_cte.infdoc.infnfe[ll_Linha].chave
			
			//Insere as NF's
			
			INSERT INTO conhecimento_transp_nf  
							( cd_emitente,   
							  nr_conhecimento,   
							  de_serie,   
							  de_chave_acesso )
			  VALUES (	:ls_Cd_Emitente,
							:ll_Nr_Cte,   
							:ls_Serie, 
							:ls_Chave_Nota ) 
			Using SqlCa;	
	
			If SqlCa.SqlCode = -1 Then
				ls_Erro = SqlCa.SqlErrText
				SqlCa.of_RollBack();
				ls_Log = "Erro ao salvar os documentos origin$$HEX1$$e100$$ENDHEX$$rios : " + ls_Erro
				Return False
			End If
		Next
		
		ll_Linha = 0
		ll_Itens = UpperBound(lt_cte.vprest.comp[])
		
		For ll_Linha = 1 To ll_Itens			
			
			ls_Nome_Componente	= lt_cte.vprest.comp[ll_Linha].xnome
			ldc_Valor_Componente	= Round(lt_cte.vprest.comp[ll_Linha].vcomp, 2)
			
			//Insere dados do frete
			
			INSERT INTO conhecimento_transp_componente(  
							  cd_emitente,   
							  nr_conhecimento,   
							  de_serie,   
							  nm_componente,   
							  vl_componente )  
			  VALUES ( 	:ls_Cd_Emitente,
							:ll_Nr_Cte,   
							:ls_Serie,   
							:ls_Nome_Componente,   
							:ldc_Valor_Componente)
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				ls_Erro = SqlCa.SqlErrText
				SqlCa.of_RollBack();
				ls_Log = "Erro ao salvar os componentes do frete : " + ls_Erro
				Return False
			End If
		Next
		
		Update nfe_indexacao
			Set id_verificado_divergencia_ped = 'S'
		Where id_nf =:as_chave_acesso
		Using SqlCa;
			
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_RollBack();
			ls_Log = "Erro ao atualizar o campo 'id_verificado_divergencia_ped' da tabela NFE_INDEXACAO (CT-e).'" + SqlCa.SqlErrText
			of_Grava_Log(ls_Log)
			Return False
		End If
		
		SqlCa.of_Commit();
				
	Catch (runtimeerror er)
		ls_Log = "Erro ao importar o XML da CT-e: ~r~r"+er.GetMessage()
		Return False
	End Try
		
Finally
	
	If Trim(ls_Log) <> ""	Then
		ls_Log = ls_Log + " - Chave de Acesso = '" + as_Chave_Acesso + "'."
		of_Grava_Log(ls_Log)		
		gf_ge202_Envia_Email_Automatico(92, "", ls_Log, ls_Anexo[])
	End If
	
	Destroy(lo_Cte)
	FileClose(ii_Log)
End Try

Return True
end function

public function boolean of_abre_log ();String ls_Path

ls_Path 	= gvo_Aplicacao.of_GetFromINI("Diretorio", "Diretorio")

If IsNull(ls_Path) or Trim(ls_Path) = '' Then 
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Diret$$HEX1$$f300$$ENDHEX$$rio para a grava$$HEX2$$e700e300$$ENDHEX$$o do log n$$HEX1$$e300$$ENDHEX$$o foi localizado no INI da aplica$$HEX2$$e700e300$$ENDHEX$$o. Chave: Diretorio | Se$$HEX2$$e700e300$$ENDHEX$$o: Diretorio = c:\sistemas\gn\arquivos\ .", StopSign!)
	Return False
End If

ls_Path = ls_Path + "xml_email_" + string(Today(),"ddmm")

If Not gf_Cria_Logs(ls_Path, 4, ref ii_log) Then
	Return False
End If

Return True
end function

public function boolean of_grava_log (string as_mensagem);String lvs_Mensagem

Integer lvi_Write
	
lvs_Mensagem = String(Today(), "dd/mm/yyyy") + " " + String(Now(), "hh:mm:ss") + &
               " - " + as_Mensagem

lvi_Write = FileWrite(ii_log, lvs_Mensagem)

If lvi_Write = LenA(lvs_Mensagem) Then
	Return True
Else
	//MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na grava$$HEX2$$e700e300$$ENDHEX$$o do arquivo de LOG.", StopSign!)
	Return False
End If
end function

public function boolean of_conhecimento_importado (string as_emitente, long al_conhecimento, string as_serie, ref string as_mensagem_log);Long ll_Conhecimento

Select nr_conhecimento
Into :ll_Conhecimento
From conhecimento_transporte
Where cd_emitente 		= :as_Emitente
	and nr_conhecimento = :al_Conhecimento
	and de_serie 			= :as_Serie
Using SqlCa;	

Choose Case SqlCa.SqlCode
	Case -1
		as_Mensagem_Log =  "Erro ao verificar se o conhecimento j$$HEX1$$e100$$ENDHEX$$ foi importado: " + SqlCa.SqlErrText
		Return False

	Case 0
		as_Mensagem_Log = "Conhecimento j$$HEX1$$e100$$ENDHEX$$ importado."
		Return False
End Choose

Return True
end function

public function boolean of_localiza_rem_dest (string as_cnpj, string as_tipo, ref long al_filial, ref string as_mensagem_log);If as_Tipo = 'REM' Then
	
	Select f.cd_filial
		Into: al_Filial
	From filial As f
		Inner Join parametro_loja As p
			On p.cd_filial = f.cd_filial
	Where f.nr_cgc = :as_Cnpj
		And p.cd_parametro = 'ID_REDE_FILIAL'
		And f.id_situacao = 'A'
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			Return True
			
		Case 100
			as_Mensagem_Log = "N$$HEX1$$e300$$ENDHEX$$o foi localizado o remetente '" + as_Cnpj + "'. Fun$$HEX2$$e700e300$$ENDHEX$$o of_localiza_rem_dest"
			
		Case -1
			as_Mensagem_Log = "Erro ao localizar o remetente '" + as_Cnpj + "'. Fun$$HEX2$$e700e300$$ENDHEX$$o of_localiza_rem_dest " + SqlCa.SqlErrText
	End Choose
	
	Return False
	
Else
	
	Select f.cd_filial
		Into: al_Filial
	From filial As f
		Inner Join parametro_odbc As p
			On p.cd_filial = f.cd_filial
	Where f.nr_cgc = :as_Cnpj
	And f.id_situacao = 'A'
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			Return True
			
		Case 100
			as_Mensagem_Log = "N$$HEX1$$e300$$ENDHEX$$o foi localizado o destinat$$HEX1$$e100$$ENDHEX$$rio '" + as_Cnpj + "'. Fun$$HEX2$$e700e300$$ENDHEX$$o of_localiza_rem_dest"
		
		Case -1
			as_Mensagem_Log = "Erro ao localizar o destinat$$HEX1$$e100$$ENDHEX$$rio '" + as_Cnpj + "'. Fun$$HEX2$$e700e300$$ENDHEX$$o of_localiza_rem_dest " + SqlCa.SqlErrText
	End Choose

	Return False		
End If
end function

on uo_ge195_cte.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge195_cte.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

