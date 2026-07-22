HA$PBExportHeader$w_ge274_busca_xml_ftp.srw
forward
global type w_ge274_busca_xml_ftp from dc_w_sheet
end type
type cb_2 from commandbutton within w_ge274_busca_xml_ftp
end type
type cb_1 from commandbutton within w_ge274_busca_xml_ftp
end type
type dw_1 from dc_uo_dw_base within w_ge274_busca_xml_ftp
end type
end forward

global type w_ge274_busca_xml_ftp from dc_w_sheet
string tag = "w_ge274_busca_xml_ftp"
integer width = 2021
integer height = 772
string title = "GE274 - Consulta DANFE"
boolean resizable = false
cb_2 cb_2
cb_1 cb_1
dw_1 dw_1
end type
global w_ge274_busca_xml_ftp w_ge274_busca_xml_ftp

type prototypes
// A altera$$HEX2$$e700e300$$ENDHEX$$o do caminho da dll implica em problemas nos aplicativos - CR/FI/CO/CT
Function Integer pBuscaXML (string aChave, String aDtEmissao, String aDirXml, String aDirExecutavel) library "Busca_XML_Ftp.dll" alias for "pBuscaXML;Ansi"

//FUNCTION boolean CreateProcess(string AppName, string CommLine, long l1, long l2, boolean binh, long creationflags, long l3, string dir, str_startupinfo startupinfo, ref str_processinformation pi ) library 'kernel32.dll' alias for "CreateProcessA"


end prototypes

type variables
dc_uo_zip ivo_ZIP
end variables

forward prototypes
public function boolean wf_localiza_emissao_clamed (string as_chave_acesso, ref date adt_emissao)
public function boolean wf_localiza_data_emissao (string as_chave_acesso, ref date adt_emissao)
public function boolean wf_localiza_emissao_fornecedor (string as_chave_acesso, ref date adt_emissao)
public function boolean of_parametro_conexao_ftp (string as_modelo_doc, ref string as_ftp_xml_endereco, ref string as_ftp_xml_usuario, ref string as_ftp_xml_senha)
public function boolean wf_busca_xml_ftp (string as_chave_acesso, date adt_emissao, string as_diretorio_xml, ref string as_arquivo_xml)
end prototypes

public function boolean wf_localiza_emissao_clamed (string as_chave_acesso, ref date adt_emissao);Date	ldt_Inicio,&
		ldt_Fim

String ls_Modelo
String ls_Especie
String ls_CNPJ

Long ll_Dia		

ls_Modelo	= Mid(as_Chave_Acesso, 21, 2)
ls_CNPJ		= Mid(as_Chave_Acesso, 7, 14)
ldt_Inicio		= Date("01/" + Mid(as_Chave_Acesso, 5, 2) + "/20" + Mid(as_Chave_Acesso, 3, 2))	
ldt_Fim		= gf_retorna_ultimo_dia_mes(ldt_Inicio)

//Verifica esp$$HEX1$$e900$$ENDHEX$$cie atrav$$HEX1$$e900$$ENDHEX$$s do modelo
Choose Case ls_Modelo
	Case '65'
		ls_Especie = 'NFC'
	Case '59'
		ls_Especie = 'SAT'
	Case '55'
		ls_Especie = 'NFE'
	Case Else
		ls_Especie = 'NFE'		
End Choose

Select dh_emissao
Into : adt_Emissao
From(
	select cast(b.dh_emissao as date) as dh_emissao
	from nf_diversa_nfe a
	inner join nf_diversa b on b.cd_filial_origem = a.cd_filial_origem
								and b.nr_nf = a.nr_nf
								and b.de_especie  = a.de_especie
								and b.de_serie  = a.de_serie
	where a.de_chave_acesso = :as_Chave_Acesso
		and b.dh_movimentacao_caixa between :ldt_Inicio and :ldt_Fim
		and a.de_especie = :ls_Especie
	
	union
	
	select cast(b.dh_emissao as date) as dh_emissao
	from nf_transferencia_nfe a
	inner join nf_transferencia b on b.cd_filial_origem = a.cd_filial_origem
								and b.nr_nf = a.nr_nf
								and b.de_especie  = a.de_especie
								and b.de_serie  = a.de_serie
	where a.de_chave_acesso = :as_Chave_Acesso
	and b.dh_movimentacao_caixa between :ldt_Inicio and :ldt_Fim
		and a.de_especie = :ls_Especie
	
	union
	
	select cast(b.dh_emissao as date) as dh_emissao
	from nf_venda_nfe a
	inner join nf_venda b on b.cd_filial = a.cd_filial
								and b.nr_nf = a.nr_nf
								and b.de_especie  = a.de_especie
								and b.de_serie  = a.de_serie
	where a.de_chave_acesso = :as_Chave_Acesso
	and b.dh_movimentacao_caixa between :ldt_Inicio and :ldt_Fim
		and a.de_especie = :ls_Especie
		and b.cd_filial in (select f1.cd_filial
								From filial f1
								Where f1.nr_cgc = :ls_CNPJ)
	
	union
	
	select cast(b.dh_movimentacao_caixa as date) as dh_emissao
	from nf_devolucao_venda_nfe a
	inner join nf_devolucao_venda b on b.cd_filial = a.cd_filial
								and b.nr_nf = a.nr_nf
								and b.de_especie  = a.de_especie
								and b.de_serie  = a.de_serie
	where a.de_chave_acesso = :as_Chave_Acesso
	and b.dh_movimentacao_caixa between :ldt_Inicio and :ldt_Fim
		and a.de_especie = :ls_Especie
	
	union
	
	select cast(b.dh_emissao as date) as dh_emissao
	from nf_devolucao_compra_nfe a
	inner join nf_devolucao_compra b on b.cd_filial = a.cd_filial
								and b.nr_nf = a.nr_nf
								and b.de_especie  = a.de_especie
								and b.de_serie  = a.de_serie
	where a.de_chave_acesso = :as_Chave_Acesso
	and b.dh_movimentacao_caixa between :ldt_Inicio and :ldt_Fim
		and a.de_especie = :ls_Especie

) as tudo
Using SqlCa;

Choose Case SqlCa.SqlCode 
	Case 0
		
	Case 100
		Return False
	Case -1
		SqlCa.of_Msgdberror("Erro ao localizar a data de emiss$$HEX1$$e300$$ENDHEX$$o da nota.")
		Return False
End Choose

Return True
end function

public function boolean wf_localiza_data_emissao (string as_chave_acesso, ref date adt_emissao);String	ls_Cnpj

Long ll_Qtde

ls_Cnpj	= Mid(as_Chave_Acesso, 7, 14)

//Verifica se $$HEX1$$e900$$ENDHEX$$ uma nota da CLAMED
Select Count(1)
Into :ll_Qtde
From filial
Where nr_cgc  = :ls_Cnpj
Using SqlCa;

If SqlCa.Sqlcode = -1 Then
	SqlCa.of_msgdberror("Erro ao verificar se a nota $$HEX1$$e900$$ENDHEX$$ da CLAMED." )
	Return False
End If

If ll_Qtde > 0 Then
	If Not wf_Localiza_Emissao_Clamed(as_Chave_Acesso, Ref adt_Emissao) Then
		Return False
	End If
Else
	If Not wf_Localiza_Emissao_Fornecedor(as_Chave_Acesso, Ref adt_Emissao) Then
		Return False
	End If
End If

Return True
end function

public function boolean wf_localiza_emissao_fornecedor (string as_chave_acesso, ref date adt_emissao);select cast(dh_emissao as date)
into :adt_Emissao
from nfe_indexacao
where id_nf = :as_Chave_Acesso
Using SqlCa;

Choose Case SqlCa.SqlCode 
	Case 0
		
	Case 100
		Return False
	Case -1
		SqlCa.of_Msgdberror("Erro ao localizar a data de emiss$$HEX1$$e300$$ENDHEX$$o da nota.")
		Return False
End Choose

Return True
end function

public function boolean of_parametro_conexao_ftp (string as_modelo_doc, ref string as_ftp_xml_endereco, ref string as_ftp_xml_usuario, ref string as_ftp_xml_senha);String ls_Parametro

If as_modelo_doc = '65' or as_modelo_doc = '59' then
	as_ftp_xml_endereco	= '10.0.4.30'
	as_ftp_xml_usuario	= 'nfce'
	as_ftp_xml_senha		= 'nfce'
Else
	ls_Parametro = 'DE_FTP_XML_ENDERECO'
	
	select vl_parametro
	Into :as_Ftp_Xml_Endereco
	From parametro_geral
	Where cd_parametro = :ls_Parametro
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
		Case 100
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Par$$HEX1$$e200$$ENDHEX$$metro geral de comunica$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o foi localizado '" + ls_Parametro + "'.")
			Return False
		Case -1
			SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro geral de comunica$$HEX2$$e700e300$$ENDHEX$$o '" + ls_Parametro + "'.")
			Return False
	End Choose
	
	If IsNull(as_Ftp_Xml_Endereco) or as_Ftp_Xml_Endereco = '' Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Par$$HEX1$$e200$$ENDHEX$$metro geral de comunica$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido '" + ls_Parametro + "'.")
		Return False
	End If
	
	as_Ftp_Xml_Endereco = Lower(as_Ftp_Xml_Endereco)
	
	
	ls_Parametro = 'DE_FTP_XML_USUARIO'
	
	select vl_parametro
	Into :as_Ftp_Xml_Usuario
	From parametro_geral
	Where cd_parametro = :ls_Parametro
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
		Case 100
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Par$$HEX1$$e200$$ENDHEX$$metro geral de comunica$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o foi localizado '" + ls_Parametro + "'.")
			Return False
		Case -1
			SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro geral de comunica$$HEX2$$e700e300$$ENDHEX$$o '" + ls_Parametro + "'.")
			Return False
	End Choose
	
	If IsNull(as_Ftp_Xml_Usuario) or as_Ftp_Xml_Usuario = '' Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Par$$HEX1$$e200$$ENDHEX$$metro geral de comunica$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido '" + ls_Parametro  + "'.")
		Return False
	End If
	
	as_ftp_xml_usuario = Lower(as_Ftp_Xml_Usuario)
	
	ls_Parametro = 'DE_FTP_XML_SENHA'
	
	select vl_parametro
	Into :as_Ftp_Xml_Senha
	From parametro_geral
	Where cd_parametro = :ls_Parametro
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
		Case 100
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Par$$HEX1$$e200$$ENDHEX$$metro geral de comunica$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o foi localizado '" + ls_Parametro + "'.")
			Return False
		Case -1
			SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do par$$HEX1$$e200$$ENDHEX$$metro geral de comunica$$HEX2$$e700e300$$ENDHEX$$o '" + ls_Parametro + "'.")
			Return False
	End Choose
	
	If IsNull(as_Ftp_Xml_Senha) or as_Ftp_Xml_Senha = '' Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Par$$HEX1$$e200$$ENDHEX$$metro geral de comunica$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido '" + ls_Parametro +  "'.")
		Return False
	End If
	
	as_Ftp_Xml_Senha = Lower(as_Ftp_Xml_Senha)
End If

Return True
end function

public function boolean wf_busca_xml_ftp (string as_chave_acesso, date adt_emissao, string as_diretorio_xml, ref string as_arquivo_xml);Date	ldt_Diretorio_Novo

String	ls_Cnpj_Origem,&
		ls_Ano,&
		ls_Mes,&
		ls_Dia,&
		ls_Cnpj,&
		ls_Nota,&
		ls_Endereco_Ftp,&
		ls_Usuario_Ftp,&
		ls_Senha_Ftp,&
		ls_Erro,&
		ls_Diretorio,&
		ls_Arquivo,&
		ls_Arquivo_UPPER1,&
		ls_Arquivo_UPPER2,&
		ls_Arquivo_Aux,&
		ls_Modelo, &
		ls_Dir_Dias[],&
		ls_Dir_Cnpj[],&
		ls_Dir_Notas[]
		
dc_uo_Ftp lo_Ftp

Long	ll_Linha_Dia,&
		ll_Linha_Cnpj,&
		ll_Linha_Nota,&
		ll_Filial
		
If IsNull(adt_Emissao) Then //N$$HEX1$$e300$$ENDHEX$$o tem data de emiss$$HEX1$$e300$$ENDHEX$$o
	If Not wf_Localiza_Data_Emissao(as_chave_acesso, Ref adt_Emissao) Then
		Return False
	End If
End If

Try
	lo_Ftp = Create dc_uo_Ftp
	ls_Modelo			= Mid(as_chave_acesso, 21, 2)
	ls_Cnpj_Origem	= Mid(as_Chave_Acesso, 7, 14)
	
	If Not This.of_Parametro_Conexao_Ftp(ls_Modelo, Ref ls_Endereco_Ftp, Ref ls_Usuario_Ftp, Ref ls_Senha_Ftp) Then
		Return False
	End If
	
	If Not lo_Ftp.of_Conecta_Ftp("", ls_Endereco_Ftp, ls_Usuario_Ftp, ls_Senha_Ftp,ref ls_Erro ) Then
		MessageBox("Erro", "Erro ao buscar o arquivo via ftp: "+ls_Erro )
		Return False
	End If
	
	If Mid(ls_Cnpj_Origem, 1, 8) = "84683481" Then
		Select top 1 cd_filial
		Into :ll_Filial
		From filial
		Where nr_cgc = :ls_Cnpj_Origem
		order by coalesce(id_situacao,'A'), 
					coalesce(id_aberta, 'A'),
					dh_reinauguracao asc
		Using SQLCa;
		
		If SQLCa.SQLCode = -1 Then
			SQLCa.Of_Msgdberror( "Localiza$$HEX2$$e700e300$$ENDHEX$$o filial emiss$$HEX1$$e300$$ENDHEX$$o.")
			Return False
		End If
	Else
		Select top 1 cd_filial
		Into :ll_Filial
		From nf_compra
		Where de_chave_acesso = :as_chave_acesso
		Using SQLCa;
		
		If SQLCa.SQLCode = -1 Then
			SQLCa.Of_Msgdberror( "Localiza$$HEX2$$e700e300$$ENDHEX$$o filial nota.")
			Return False
		End If		
	End If
	
	Choose Case ls_Modelo
		Case '59' 
			ls_Ano		= String(Year(adt_Emissao))
			ls_Mes		= Right("0"+String(Month(adt_Emissao)), 2)
			ls_Dia			= Right("0"+String(Day(adt_Emissao)), 2)
			ls_Diretorio	= ls_Ano+"/"+ls_Mes+"/"+ls_Dia+"/"+String(ll_Filial, "0000")
			ls_Arquivo	= 'AD'+as_Chave_Acesso+".xml.zip"
		Case '65' 	
			ls_Ano		= String(Year(adt_Emissao))
			ls_Mes		= Right("0"+String(Month(adt_Emissao)), 2)
			ls_Dia			= Right("0"+String(Day(adt_Emissao)), 2)
			ls_Diretorio	= ls_Ano+"/"+ls_Mes+"/"+ls_Dia+"/"+String(ll_Filial, "0000")
			ls_Arquivo	= as_Chave_Acesso+"-nfce.xml.zip"
		Case Else
			ls_Ano		= "Ano_"+String(Year(adt_Emissao))
			ls_Mes		= "Mes_"+Right("0"+String(Month(adt_Emissao)), 2)
			ls_Dia			= "Dia_"+Right("0"+String(Day(adt_Emissao)), 2)
			ls_Diretorio	= ls_Ano+"/"+ls_Mes+"/"+ls_Dia+"/"+ls_Cnpj_Origem
			ls_Arquivo	= as_Chave_Acesso+"-nfe.xml"
			ls_Arquivo_UPPER1 = as_Chave_Acesso+"-NFE.xml"
			ls_Arquivo_UPPER2 = as_Chave_Acesso+"-NFE.XML"
	End Choose
	
	If lo_Ftp.of_Ftp_Set_Dir(ls_Diretorio, Ref ls_Erro) = -1 Then 
		MessageBox("Erro", "Erro ao buscar o arquivo via ftp: "+ls_Erro )
		Return  False	
	End If
	
	If not lo_Ftp.of_Ftp_GetFile(ls_Arquivo, as_Diretorio_Xml+ls_Arquivo, Ref ls_Erro) Then
		If not lo_Ftp.of_Ftp_GetFile(ls_Arquivo_UPPER1, as_Diretorio_Xml+ls_Arquivo, Ref ls_Erro) Then
			If not lo_Ftp.of_Ftp_GetFile(ls_Arquivo_UPPER2, as_Diretorio_Xml+ls_Arquivo, Ref ls_Erro) Then
				MessageBox("Erro", "Erro ao buscar o arquivo via ftp: "+ls_Erro )
				Return False
			End If
		End If
	End If
	
	//Recebe o valor arquivo
	ls_Arquivo_Aux = ls_Arquivo
	
	//Se for arquivo compactado
	If Upper(Right(ls_Arquivo, 3))="ZIP" Then
		//Verifica se objeto ZIP j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ criado
		If Not IsValid(ivo_ZIP) Then ivo_ZIP = Create dc_uo_zip
		
		//Novo arquivo XML
		ls_Arquivo_Aux = Mid(ls_Arquivo, 1, Len(ls_Arquivo) -4)
		
		//Se o arquivo ZIP j$$HEX1$$e100$$ENDHEX$$ existir ele exclui
		If FileExists(as_Diretorio_Xml+ls_Arquivo_Aux) Then FileDelete(as_Diretorio_Xml+ls_Arquivo_Aux)
		
		//Verifica se o arquivo existe
		If FileExists(as_Diretorio_Xml+ls_Arquivo) Then 
			ivo_ZIP.Of_UnZip_Origem( as_Diretorio_Xml+ls_Arquivo )
			ivo_ZIP.Of_UnZip_Destino( as_Diretorio_Xml )
			ivo_ZIP.Of_UnZip( True )
		End If
	End If
	
	//Retorna o arquivo XML
	as_arquivo_xml = as_Diretorio_Xml+ls_Arquivo_Aux
Finally
	Destroy(lo_Ftp)
End Try

Return True
end function

on w_ge274_busca_xml_ftp.create
int iCurrent
call super::create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.dw_1
end on

on w_ge274_busca_xml_ftp.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.dw_1)
end on

event ue_postopen;call super::ue_postopen;dw_1.event ue_addrow()
dw_1.Object.de_especie[1] = 'NFE'
dw_1.Object.de_serie[1]		= '1'



end event

type dw_visual from dc_w_sheet`dw_visual within w_ge274_busca_xml_ftp
end type

type gb_aux_visual from dc_w_sheet`gb_aux_visual within w_ge274_busca_xml_ftp
end type

type cb_2 from commandbutton within w_ge274_busca_xml_ftp
integer x = 878
integer y = 192
integer width = 562
integer height = 96
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Buscar Chave Nota"
end type

event clicked;String  	    	ls_Chave
DateTime	ldh_Emissao

Long 		ll_Filial
Long	 	li_Nr_Nota
String 	ls_Especie
String 	ls_Serie

Long ll_Linhas

dw_1.AcceptText()

If IsNull(dw_1.Object.nr_nota  [1]) Then
	MessageBox("Aviso", "Informe o N$$HEX1$$fa00$$ENDHEX$$mero da Nota.")	
	Dw_1.Event ue_Pos(1,"nr_nota")
	Return
End IF	

If Trim(dw_1.Object.de_Especie  [1]) = "" Then
	MessageBox("Aviso", "Informe a Esp$$HEX1$$e900$$ENDHEX$$cie.")	
	Dw_1.Event ue_Pos(1,"de_Especie")
	Return
End IF

If Trim(dw_1.Object.de_Serie  [1]) = "" Then
	MessageBox("Aviso", "Informe a S$$HEX1$$e900$$ENDHEX$$rie.")	
	Dw_1.Event ue_Pos(1,"de_Serie")
	Return
End IF

If IsNull(dw_1.Object.cd_filial  [1]) Then
	MessageBox("Aviso", "Informe o C$$HEX1$$f300$$ENDHEX$$digo da Filial.")	
	Dw_1.Event ue_Pos(1,"cd_filial")
	Return
End IF
	

ll_filial       = dw_1.Object.cd_filial     [1]
li_Nr_Nota = dw_1.Object.nr_nota     [1]
ls_Especie = dw_1.Object.de_Especie[1]
ls_Serie    = dw_1.Object.de_Serie    [1]

dc_uo_ds_base lds_Nota
lds_Nota = Create dc_uo_ds_base

lds_Nota.Of_ChangeDataObject("ds_ge274_nota")

ll_Linhas = lds_Nota.Retrieve(ll_filial, li_Nr_Nota, ls_Especie, ls_Serie )

If ll_Linhas >1 Then 
	messagebox("","" + String(lds_Nota.Object.de_chave_Acesso	[1]))	
ElseIf ll_Linhas = 0 Then 
	messagebox("Aviso","Chave da Nota Fiscal n$$HEX1$$e300$$ENDHEX$$o encontrada.")
ElseIf ll_Linhas = 1 Then 	
//st_chave_nota.Text = lds_Nota.Object.de_chave_Acesso	[1]
//st_dt_emissao        = lds_Nota.Object.dh_Envio			[1]



dw_1.Object.de_chave_nota	[1] = lds_Nota.Object.de_chave_Acesso	[1]
dw_1.Object.dh_emissao		[1] = lds_Nota.Object.dh_envio				[1]
End If
//SqlCa.of_MsgDbError("Erro ao localizar a nota fiscal." + SqlCa.SqlErrText )
dw_1.AcceptText()

Destroy lds_Nota

Return

end event

type cb_1 from commandbutton within w_ge274_busca_xml_ftp
integer x = 937
integer y = 464
integer width = 503
integer height = 100
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Visualizar Nota"
end type

event clicked; String ls_chave
 String ls_dirXML
 String ls_dirExec
 String ls_ExeDanfe
 String ls_ExeName
 String ls_ArquivoXML
 
 Integer lvi_Retorno
 
 Date ldt_Emissao
 
//Verifica se existe o diret$$HEX1$$f300$$ENDHEX$$rio para o arquivo XML da nota a ser impressa
ls_dirXML = ProfileString(gvo_aplicacao.ivs_arquivo_ini, "Diretorio", "ArquivoXML", "")
If Trim(ls_dirXML) = "" Then
	ls_dirXML = "C:\Sistemas\"+gvo_aplicacao.ivo_seguranca.cd_sistema+"\XML_Notas\"	 
    	SetProfileString(gvo_aplicacao.ivs_arquivo_ini, "Diretorio", "ArquivoXML",ls_dirXML)
End If

//Verifica se existe o diret$$HEX1$$f300$$ENDHEX$$rio do execut$$HEX1$$e100$$ENDHEX$$vel para abrir o XML
ls_dirExec = ProfileString(gvo_aplicacao.ivs_arquivo_ini, "Diretorio", "DirExecutavelXML", "")
If Trim(ls_dirExec) = "" Then
	ls_ExeDanfe = "C:\Program Files\danfeview\danfev.exe"
	If Not FileExists(ls_ExeDanfe) Then
		ls_ExeDanfe = "C:\DANFEView\danfev.exe"
		If Not FileExists(ls_ExeDanfe) Then
			ls_ExeDanfe = "C:\Program Files (x86)\danfeview\danfev.exe"
			If Not FileExists(ls_ExeDanfe) Then
				ls_ExeDanfe = ''
				lvi_Retorno = GetFileOpenName("Selecione o Programa para Visualizar DANFE",+ ls_ExeDanfe, ls_ExeName, "EXE", "Aplicativos (*.EXE),*.EXE")
				If Not FileExists(ls_ExeDanfe) Then
					MessageBox('Erro!','Programa de visualiza$$HEX2$$e700e300$$ENDHEX$$o de DANFE selecionado incorretamente.',StopSign!)
					Return -1
				End If
			End If
		End If
	End If
	
	SetProfileString(gvo_aplicacao.ivs_arquivo_ini, "Diretorio", "DirExecutavelXML",ls_ExeDanfe)
	ls_dirExec = ls_ExeDanfe
End If

dw_1.AcceptText()

If Trim(dw_1.Object.de_chave_nota[1]) <> "" Then
	ls_chave      	=  dw_1.Object.de_chave_nota[1]
	ldt_Emissao = dw_1.Object.dh_emissao[1]
	Open(w_aguarde)
	w_aguarde.Title = "Aguarde... Buscando XML..."
	
	If Not DirectoryExists(ls_DirXML) Then
		If CreateDirectory(ls_DirXML) = -1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao criar o diret$$HEX1$$f300$$ENDHEX$$rio '" + ls_DirXML + "'.", StopSign!)
			Return -1
		End If
	End If
	
	If wf_Busca_Xml_Ftp(ls_Chave, ldt_Emissao, ls_DirXML, ref ls_ArquivoXML) Then
		If Run(ls_dirExec + " "+ ls_ArquivoXML) = -1 Then
			MessageBox("Aviso", "Erro ao abrir a nota.~rO arquivo est$$HEX1$$e100$$ENDHEX$$ no diret$$HEX1$$f300$$ENDHEX$$rio: "+ ls_ArquivoXML+".")
		End If
	Else
		MessageBox("Aviso", "Arquivo XML n$$HEX1$$e300$$ENDHEX$$o encontrado para visualizar a nota.")
	End If
	
	Close(w_aguarde)
Else
	MessageBox("Aviso", "Informe a chave da Nota.")	
	Dw_1.Event ue_Pos(1,"de_chave_nota")
End If	
end event

type dw_1 from dc_uo_dw_base within w_ge274_busca_xml_ftp
integer x = 14
integer y = 28
integer width = 1966
integer height = 580
string dataobject = "dw_ge274_selecao"
end type

event itemfocuschanged;call super::itemfocuschanged;//If dwo.name = "de_chave_nota" Then
//	If This.Object.de_chave_nota.editmask.mask <> "############################################" then
//			 This.Object.de_chave_nota.editmask.mask = "############################################"
//		End If			 
//End If	
end event

event clicked;call super::clicked;//If dwo.name = "de_chave_nota" Then
//	If This.Object.de_chave_nota.editmask.mask <> "############################################" then
//			 This.Object.de_chave_nota.editmask.mask = "############################################"
//		End If			 
//End If	
end event

event itemchanged;call super::itemchanged;//if dwo.name = "de_chave_nota" then
//	This.Object.de_chave_nota.editmask.mask = "####  ####  ####  ####  ####  ####  ####  ####  ####  ####  ####"
//end if	
end event

