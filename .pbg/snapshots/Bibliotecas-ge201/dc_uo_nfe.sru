HA$PBExportHeader$dc_uo_nfe.sru
forward
global type dc_uo_nfe from nonvisualobject
end type
end forward

global type dc_uo_nfe from nonvisualobject
end type
global dc_uo_nfe dc_uo_nfe

type variables
Constant string IMPRESSAO_NORMA = '1'

dc_uo_xml io_Xml
end variables

forward prototypes
public function string of_cgc_filial (long pl_filial)
public function string of_codigo_ibge_uf (long pl_filial)
public function string of_digito_verificador_chave_acesso (string ps_chave)
public function integer of_digito_verificador_ean (string ps_chave)
public function string of_gera_caracteres_ean (string ps_chave)
public function boolean of_envia_xml (integer ai_ambiente)
public function boolean of_grava_chave_acesso (long al_filial, long al_nota, string as_especie, string as_serie, ref string as_chave, string as_tipo_nota, string as_versao_xml)
public function boolean of_gera_chave_acesso (long pl_filial, long pl_nota, string ps_especie, string ps_serie, ref string ps_chave, string ps_versao_xml)
end prototypes

public function string of_cgc_filial (long pl_filial);String 	lvs_CGC

Select nr_cgc
Into :lvs_CGC
From filial
Where cd_filial = :pl_Filial
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		lvs_CGC = Trim(lvs_CGC)
		
		// Desenvolvimento
		//lvs_CGC = '84683481000177'
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O CGC da filial '" + String(pl_Filial) + "' n$$HEX1$$e300$$ENDHEX$$o foi localizado.")
		Return ''
	Case -1
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do CGC da filial '" + String(pl_Filial) + "'.")
		Return ''
End Choose

Return lvs_CGC
		

end function

public function string of_codigo_ibge_uf (long pl_filial);Boolean lvb_Sucesso = False

String 	lvs_Codigo,&
		lvs_UF

Select u.cd_uf_ibge, c.cd_unidade_federacao
Into :lvs_Codigo, :lvs_UF
From filial f, cidade c, unidade_federacao u
Where f.cd_filial 				= :pl_Filial
  and c.cd_cidade				= f.cd_cidade
  and u.cd_unidade_federacao 	= c.cd_unidade_federacao
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If Not IsNull(lvs_Codigo) and lvs_Codigo <> '' and IsNumber(lvs_Codigo) Then
			lvs_Codigo = String(Integer(lvs_Codigo), '00')
			lvb_Sucesso = True
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "C$$HEX1$$f300$$ENDHEX$$digo do IBGE da UF '" + lvs_UF + "' inv$$HEX1$$e100$$ENDHEX$$lido.")
		End If
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O c$$HEX1$$f300$$ENDHEX$$digo do IBGE da UF '" + lvs_UF + "' n$$HEX1$$e300$$ENDHEX$$o foi localizado.")
	Case -1
		SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do c$$HEX1$$f300$$ENDHEX$$digo do IBGE da UF '" + lvs_UF + "'.")
End Choose

If Not lvb_Sucesso Then Return ''

Return lvs_Codigo
		

end function

public function string of_digito_verificador_chave_acesso (string ps_chave);String lvs_Nr_Chave

Integer lvi_Chave     ,&
        lvi_Contador  ,&
		lvi_Char      ,&
		lvi_Divisao	  ,&
		lvi_Digito
		
lvs_Nr_Chave = Trim(ps_Chave)

Double lvd_Soma =0

lvi_Contador = 2

For lvi_Chave =43 to 1 Step -1
	
	lvi_Char = Integer(Mid(lvs_Nr_Chave, lvi_Chave,1))
	lvd_Soma = lvd_Soma + (lvi_Char * lvi_Contador)	

	lvi_Contador += 1
	If lvi_Contador > 9 then
		lvi_Contador = 2
	End If	
Next

lvi_Divisao = Mod(lvd_Soma,11)

If lvi_Divisao = 0 or lvi_Divisao = 1 Then
	lvi_Digito = 0
Else
	lvi_Digito = 11 - (lvi_Divisao)
End If

Return String(lvi_Digito)


end function

public function integer of_digito_verificador_ean (string ps_chave);Integer lvi_Contador,&
		lvi_Bloco,&
		lvi_Retorno = -1
		
Long lvl_Soma		
		
String lvs_Numero

Integer lvi_Len

lvi_Len = Len(ps_Chave)

If Len(ps_Chave) = 44 Then
	If IsNumber(ps_Chave) Then
	
		For lvi_Contador = 1 To 44 
			
			lvi_Bloco ++
		
			lvs_Numero = Mid(ps_Chave, lvi_Contador, 2)
			
			lvl_Soma = lvl_Soma + (Long(lvs_Numero) * lvi_Bloco)
			
			lvi_Contador = lvi_Contador + 1
		Next
		
		lvi_Retorno = Mod(lvl_Soma + 105, 103)
	Else
		Messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'A chave de acesso inv$$HEX1$$e100$$ENDHEX$$lida.')
	End If
Else
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', "O c$$HEX1$$f300$$ENDHEX$$digo da chave de acesso deve conter 44 n$$HEX1$$fa00$$ENDHEX$$meros.")
End If

Return lvi_Retorno
end function

public function string of_gera_caracteres_ean (string ps_chave);Integer lvi_Contador,&
		lvi_Numero,&
		lvi_DV

String lvs_Digito_Verificador,&
	   lvs_Retorno

String  lvs_Caracteres[100]
//				   1   2   3   4   5  6    7   8   9   0   1   2   3   4   5   6   7   8   9   0   1   2   3   4   5
lvs_Caracteres = {'!','"','#','$','%','&','$$HEX1$$1820$$ENDHEX$$','(',')','*','+',',','-','.','/','0','1','2','3','4','5','6','7','8','9',&
				  ':',';','<','=','>','?','@','A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R',&
				  'S','T','U','V','W','X','Y','Z','[','\',']','^','_','`','a','b','c','d','e','f','g','h','i','j','k',&
				  'l','m','n','o','p','q','r','s','t','u','v','w','x','y','z','{','|','}','~~','$$HEX1$$c300$$ENDHEX$$','$$HEX1$$c400$$ENDHEX$$','$$HEX1$$c500$$ENDHEX$$','$$HEX1$$c600$$ENDHEX$$','$$HEX1$$c700$$ENDHEX$$','$$HEX1$$c200$$ENDHEX$$'}

lvi_DV = This.of_digito_verificador_ean(ps_chave)

If lvi_DV = -1 Then
	MessageBox("Aten$$HEX1$$e700$$ENDHEX$$ao", "Digito verificador invalido.")
	SetNull(lvs_Retorno)
	Return lvs_Retorno
End If
	
ps_Chave = ps_Chave + string(lvi_DV, '00')

For lvi_Contador = 1 To 46 
	
	lvi_Numero = Integer(Mid(ps_Chave, lvi_Contador, 2))
	
	If lvi_Numero = 0 Then
		lvi_Numero = 100
	End If
	
	lvs_Retorno = lvs_Retorno + Mid(lvs_Caracteres[lvi_Numero], 1,1)
	
	lvi_Contador = lvi_Contador + 1
Next

lvs_Retorno = "$$HEX1$$cd00$$ENDHEX$$" + lvs_Retorno + '$$HEX1$$d300$$ENDHEX$$'

Return lvs_Retorno
end function

public function boolean of_envia_xml (integer ai_ambiente);String xml_Retorno		,&
          lvs_Cabe$$HEX1$$e700$$ENDHEX$$aho =	'<?xml version="1.0" encoding="UTF-8"?>'											+&
								'<cabecMsg xmlns="http://www.portalfiscal.inf.br/nfe" versao="1.02">'		+&
								'<versaoDados>1.10</versaoDados>'												+&
								'</cabecMsg>'

SoapConnection sp_Connection

px_nfecancelamento  nfe_Cancelamento
px_nfeconsulta          nfe_Consulta
px_nfeinutilizacao      nfe_Inutilizacao
px_nferecepcao         nfe_Recepcao
px_nferetrecepcao     nfe_RetRecepcao
px_nfestatusservico   nfe_StatusServico

sp_Connection  = Create SoapConnection
////sp_com.setbasicauthentication( "https://www.softnex.com.br/plenocard/_services/sigeus/auth/auth.php",)


If ai_Ambiente = 1 Then  //produ$$HEX2$$e700e300$$ENDHEX$$o
	long ll_ret
	//Cancelamento
	ll_ret = sp_Connection.CreateInstance( nfe_Cancelamento , " px_nfecancelamento")
	if ll_ret <> 0 then
		messagebox("atencao", "falha na criacao do proxy cancelamento")
	end if	
	ll_ret = sp_Connection.CreateInstance( nfe_Cancelamento , " px_nferecepcao")
	if ll_ret <> 0 then
		messagebox("atencao", "falha na criacao do proxy Recepcao")
	end if
	//RetRecepcao
	ll_ret = sp_Connection.CreateInstance( nfe_RetRecepcao , " px_nferet_recepcao")
	if ll_ret <> 0 then
		messagebox("atencao", "falha na criacao do proxy RetRecepcao")
	end if
	//StatusServico
	ll_ret = sp_Connection.CreateInstance( nfe_StatusServico , " px_statusservico")
	if ll_ret <> 0 then
		messagebox("atencao", "falha na criacao do proxy StatusServico")
	end if
	//envio

xml_Retorno = nfe_Cancelamento.nfecancelamentonf( lvs_Cabe$$HEX1$$e700$$ENDHEX$$aho , "dados da nota")
Else //Homologa$$HEX2$$e700e300$$ENDHEX$$o
End If 

//io_Xml.of_gerar_xml_cabecalho( /*long al_nr_nf*/, /*string de_especie*/, /*string de_serie*/, /*long cd_filal */)

Return True
end function

public function boolean of_grava_chave_acesso (long al_filial, long al_nota, string as_especie, string as_serie, ref string as_chave, string as_tipo_nota, string as_versao_xml);// Se a chave for passada no par$$HEX1$$e200$$ENDHEX$$metro o sistema vai gerar uma nova chave, pois
// todo envio ao sefaz com sucesso ou n$$HEX1$$e300$$ENDHEX$$o a chave n$$HEX1$$e300$$ENDHEX$$o pode ser repetida

If Not This.of_Gera_Chave_Acesso(al_Filial, al_Nota, as_Especie, as_Serie, ref as_Chave, as_versao_xml ) Then
	Return False
End If

Choose Case as_Tipo_Nota
	Case 'TR' // Transfer$$HEX1$$ea00$$ENDHEX$$ncia
		Update nf_transferencia_nfe
		Set de_chave_acesso = :as_Chave //,  id_situacao          = 'G'
		Where cd_filial_origem 	= :al_Filial
		  and nr_nf				= :al_Nota
		  and de_especie		= :as_Especie
		  and de_serie			= :as_serie
		Using SqlCa;
		
	Case 'DV' // Devolu$$HEX2$$e700e300$$ENDHEX$$o de venda
		Update nf_devolucao_venda_nfe
		Set de_chave_acesso = :as_Chave //,  id_situacao          = 'G'
		Where cd_filial		= :al_Filial
		  and nr_nf			= :al_Nota
		  and de_especie	= :as_Especie
		  and de_serie		= :as_serie
		Using SqlCa;

	Case 'DC' // Devolu$$HEX2$$e700e300$$ENDHEX$$o de compras
		Update nf_devolucao_compra_nfe
		Set de_chave_acesso = :as_Chave //, id_situacao          = 'G'
		Where cd_filial		= :al_Filial
		  and nr_nf			= :al_Nota
		  and de_especie	= :as_Especie
		  and de_serie		= :as_serie
		Using SqlCa;
	
	Case 'DI' // Diversas
		Update nf_diversa_nfe
		Set de_chave_acesso = :as_Chave //,  id_situacao          = 'G'
		Where cd_filial_origem 	= :al_Filial
		  and nr_nf				= :al_Nota
		  and de_especie		= :as_Especie
		  and de_serie			= :as_serie
		Using SqlCa;
		
	Case 'AN' // Anexa
		Update nf_venda_nfe
		Set de_chave_acesso = :as_Chave //,  id_situacao          = 'G'
		Where cd_filial 	= :al_Filial
		  and nr_nf				= :al_Nota
		  and de_especie		= :as_Especie
		  and de_serie			= :as_serie
		Using SqlCa;
		
	Case Else 
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', "Tipo de nota n$$HEX1$$e300$$ENDHEX$$o prevista para gerar a CHAVE DE ACESSO '" + as_Tipo_Nota + "'.")
		Return False
End Choose 
		
If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError('Erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o da chave de acesso na nota fiscal de transfer$$HEX1$$ea00$$ENDHEX$$ncia.')
	SqlCa.of_RollBack();
	Return False
End If

SqlCa.of_Commit();

// O COMMIT DEVE FICAR NA TELA QUE CHAMA A FUN$$HEX2$$c700c300$$ENDHEX$$O

Return True



end function

public function boolean of_gera_chave_acesso (long pl_filial, long pl_nota, string ps_especie, string ps_serie, ref string ps_chave, string ps_versao_xml);String lvs_CGC,&
	   lvs_Codigo_UF,&
	   lvs_Chave,&
	   lvs_Emissao,&
	   lvs_DV
	   
Long lvl_Sequencial

lvs_CGC 	  	= This.of_CGC_Filial(pl_Filial)
lvs_Codigo_UF 	= This.of_codigo_ibge_uf(pl_Filial)
lvs_Emissao   	= Mid(String(Year(Date(gf_GetServerDate())), "0000"), 3) + String(Month(Date(gf_GetServerDate())), "00")

If IsNumber(ps_Serie) Then
	ps_Serie = String(Long(ps_Serie), "000")
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O s$$HEX1$$e900$$ENDHEX$$rie da NFE deve ser n$$HEX1$$fa00$$ENDHEX$$meros.")
	Return False
End If

//informar o conte$$HEX1$$fa00$$ENDHEX$$do da tag tpemis - forma de emiss$$HEX1$$e300$$ENDHEX$$o da NF-e: 1- Normal, 2-Conting$$HEX1$$ea00$$ENDHEX$$ncia FS, 3-Conting$$HEX1$$ea00$$ENDHEX$$ncia SCAN, 4-DPEC e 5-Contig$$HEX1$$ea00$$ENDHEX$$ncia FS-DA.

If ps_Versao_XML = '2.0' Then
	// Gera uma chave nova
	If IsNull(ps_Chave) or ps_Chave = '' Then
		// Quando a chave $$HEX1$$e900$$ENDHEX$$ gerada pela primeira vez o sequencial ser$$HEX1$$e100$$ENDHEX$$ sempre um
		//ps_Chave = lvs_Codigo_Uf + lvs_Emissao + lvs_CGC + "55" + ps_Serie + String(pl_Nota, "000000000") + '1' + "00000001"
		ps_Chave = lvs_Codigo_Uf + lvs_Emissao + lvs_CGC + "55" + ps_Serie + String(pl_Nota, "000000000") + '1' + "01" + string(pl_filial, "000000")
	Else
		// Se j$$HEX1$$e100$$ENDHEX$$ existir uma chave de acesso cadastrada a fun$$HEX2$$e700e300$$ENDHEX$$o vai mudar o sequencial e recalcular o DV
		lvl_Sequencial = Long(Mid(ps_Chave, 36, 2))
		
		lvl_Sequencial = lvl_Sequencial + 1
		
		ps_Chave = Mid(ps_Chave, 1, 35) + String(lvl_Sequencial, "00") + string(pl_filial, "000000")
	End If
Else
	// Vers$$HEX1$$e300$$ENDHEX$$o 1.0
	ps_Chave = lvs_Codigo_Uf + lvs_Emissao + lvs_CGC + "55" + ps_Serie + String(pl_Nota, "000000000") + string(pl_filial, "000000000")
End If

lvs_DV = This.of_digito_verificador_chave_acesso(ps_Chave)
	
ps_Chave = ps_Chave + lvs_DV

If Len(ps_Chave) <> 44 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A Chave de acesso deve possuir 44 posi$$HEX2$$e700f500$$ENDHEX$$es.", StopSign!)
	Return False
End If

Return True
end function

on dc_uo_nfe.create
call super::create
TriggerEvent( this, "constructor" )
end on

on dc_uo_nfe.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;// Este objeto tamb$$HEX1$$e900$$ENDHEX$$m existe no PB6 na biblioteca ge110

io_Xml = Create dc_uo_xml
end event

event destructor;Destroy(dc_uo_xml)
end event

