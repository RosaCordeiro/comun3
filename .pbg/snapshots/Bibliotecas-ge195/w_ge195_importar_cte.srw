HA$PBExportHeader$w_ge195_importar_cte.srw
forward
global type w_ge195_importar_cte from dc_w_selecao_lista_relatorio
end type
type dw_4 from dc_uo_dw_base within w_ge195_importar_cte
end type
type dw_5 from dc_uo_dw_base within w_ge195_importar_cte
end type
end forward

global type w_ge195_importar_cte from dc_w_selecao_lista_relatorio
integer width = 3479
integer height = 1896
string title = "GE195 - Conhecimento de Transporte Eletr$$HEX1$$f400$$ENDHEX$$nico CT-e"
dw_4 dw_4
dw_5 dw_5
end type
global w_ge195_importar_cte w_ge195_importar_cte

type prototypes
FUNCTION long ShellExecuteA ( long ll_hWnd, REF String ls_operation, REF String ls_file, REF string ls_parameters, REF string ls_directory, INT nShowCmd) library 'shell32.dll' 
end prototypes

forward prototypes
public subroutine wf_limpa_tela ()
public function boolean wf_localiza_codigo_fornecedor (string as_cnpj, ref string as_fornecedor)
public function boolean wf_conhecimento_importado (string as_emitente, long al_conhecimento, string as_serie)
public function boolean wf_busca_xml_ftp (string as_chave_acesso, date adt_emissao, ref string as_diretorio_xml)
public function boolean wf_nfe_indexacao (string as_chave_acesso, ref boolean ab_possui_registro)
end prototypes

public subroutine wf_limpa_tela ();This.ivm_Menu.mf_Confirmar(False)
This.ivm_Menu.mf_Cancelar(False)
This.ivm_Menu.mf_recuperar( True)

//dw_1.Reset()
//dw_1.Event ue_AddRow()
dw_2.Reset()
dw_2.Event ue_AddRow()
dw_4.Reset()
dw_4.Event ue_AddRow()
dw_5.Reset()
dw_5.Event ue_AddRow()

dw_1.SetFocus()
end subroutine

public function boolean wf_localiza_codigo_fornecedor (string as_cnpj, ref string as_fornecedor);select top 1 cd_fornecedor
into :as_Fornecedor
from fornecedor 
where nr_cgc = :as_Cnpj
order by id_situacao asc
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case -1
		MessageBox("Erro", "Erro ao localizar o fornecedor: "+SqlCa.SqlErrText)
		Return False

	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Fornecedor n$$HEX1$$e300$$ENDHEX$$o localizado com o CNPJ "+as_Cnpj)
		Return False
End Choose

Return True
end function

public function boolean wf_conhecimento_importado (string as_emitente, long al_conhecimento, string as_serie);Long ll_Conhecimento

Select nr_conhecimento
Into :ll_Conhecimento
From conhecimento_transporte
Where cd_emitente 		= :as_Emitente
	and nr_conhecimento = :al_Conhecimento
	and de_serie 			= :as_Serie
Using SqlCa;	

Choose Case SqlCa.SqlCode
	Case -1
		MessageBox("Erro", "Erro ao verificar se o conhecimento j$$HEX1$$e100$$ENDHEX$$ foi importado: "+SqlCa.SqlErrText)
		Return False

	Case 0
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Conhecimento j$$HEX1$$e100$$ENDHEX$$ importado.")
		Return False
End Choose

Return True
end function

public function boolean wf_busca_xml_ftp (string as_chave_acesso, date adt_emissao, ref string as_diretorio_xml);String 	ls_Ano,&
			ls_Mes,&
			ls_Dia,&
			ls_Cnpj,&
			ls_Arquivo_Xml,&
			ls_Mensagem,&
			ls_Diretorio,&
			ls_mensagem_log,&
			ls_Diretorio_Ftp
			
Long 	ll_Ano,&
		ll_Mes,&
		ll_Dia
		
Boolean 	lb_Localizado,&
			lb_download_sefaz,&
			lb_Possui_Registro
			
dc_uo_Ftp lo_Ftp

ls_Diretorio = "C:\Sistemas\WS\XML_CTe\"
If Not DirectoryExists ( ls_Diretorio ) Then
	If CreateDirectory( ls_Diretorio) <> 1 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel criar o diret$$HEX1$$f300$$ENDHEX$$rio '"+ls_Diretorio+"' para importa$$HEX2$$e700e300$$ENDHEX$$o do XML.")
		Return False
	End If
End If

lb_Localizado = False

ll_Ano 	= Year(adt_Emissao)
ll_Mes 	= Month(adt_Emissao)
ll_Dia 		= Day(adt_Emissao)

ls_Ano = "Ano_"+String(ll_Ano)
If ll_Mes < 10 Then ls_Mes = "Mes_0"+String(ll_Mes) Else ls_Mes = "Mes_"+String(ll_Mes)
If ll_Dia < 10 Then ls_Dia = "Dia_0"+String(ll_Dia) Else ls_Dia = "Dia_"+String(ll_Dia)
ls_Cnpj = Mid(as_Chave_Acesso, 7, 14)
ls_Arquivo_Xml = as_Chave_Acesso+"-cte.xml"

If Not wf_Nfe_Indexacao(as_Chave_Acesso, Ref lb_Possui_Registro) Then
	Return False
End If

If lb_Possui_Registro Then
	Try
		lo_Ftp = Create dc_uo_Ftp
		
		If Not lo_Ftp.of_Conecta_Ftp("", "10.0.0.4", "nfe", "nfe",ref ls_mensagem_log ) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao conectar no FTP: "+ls_mensagem_log+".")
			Return False
		End If
		
		ls_Diretorio_Ftp = "CT-e/" + ls_Ano + "/" + ls_Mes + "/" + ls_Dia + "/" + ls_CNPJ
		
		lb_Localizado = True
		
		If lo_Ftp.of_Ftp_Set_Dir(ls_Diretorio_Ftp, Ref ls_Mensagem) = -1 Then 
			lb_Localizado = False	
		End If
		
		If lb_Localizado Then
			If not lo_Ftp.of_Ftp_GetFile(ls_Arquivo_Xml, ls_Diretorio+"\"+ls_Arquivo_Xml, Ref ls_Mensagem) Then
				lb_Localizado = False
			End If
		End If	
	Finally
	  Destroy(lo_Ftp)
	End Try

	If lb_Localizado Then
		If  FileExists(ls_Diretorio+ls_Arquivo_Xml) Then
			as_Diretorio_XML = ls_Diretorio+ls_Arquivo_Xml
			Return True
		Else
			lb_Localizado = False
		End If
	Else
		lb_Localizado = False
	End If
End If	

If Not lb_Localizado Then
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizado o arquivo XML em nossa base de dados.~rDeseja fazer download da SEFAZ?", Question!, YesNo!, 1) = 1 Then
		OpenWithParm(w_ge195_download_sefaz, as_Chave_Acesso)
		
		If  FileExists(ls_Diretorio+ls_Arquivo_Xml) Then
			as_Diretorio_XML = ls_Diretorio+ls_Arquivo_Xml
			Return True
		Else
			If  FileExists(ls_Diretorio+as_Chave_Acesso+".xml") Then
				as_Diretorio_XML = ls_Diretorio+as_Chave_Acesso+".xml"
				Return True
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel localizar o arquivo XML.")
				Return False
			End if
		End If
		
	End If
End if

Return False

end function

public function boolean wf_nfe_indexacao (string as_chave_acesso, ref boolean ab_possui_registro);Long ll_Qtde

Select Count(*)
Into:ll_Qtde
From nfe_indexacao
Where id_nf = :as_Chave_Acesso
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Erro", "Erro ao veirificar se existe o arquivo na tabela nfe_indexacao: "+SqlCa.SqlErrText)
	Return False
End If

If ll_Qtde > 0 Then
	ab_Possui_Registro = True
Else
	ab_Possui_Registro = False
End If

Return True
end function

event ue_postopen;call super::ue_postopen;dw_2.Event ue_AddRow()

dw_1.Event ue_Pos(1,"de_chave_acesso")
end event

on w_ge195_importar_cte.create
int iCurrent
call super::create
this.dw_4=create dw_4
this.dw_5=create dw_5
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_4
this.Control[iCurrent+2]=this.dw_5
end on

on w_ge195_importar_cte.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_4)
destroy(this.dw_5)
end on

event ue_save;call super::ue_save;String 	ls_Emitente,&
			ls_Remetente,&
			ls_Serie,&
			ls_Chave_Acesso,&
			ls_Natureza_Operacao,&
			ls_Cst_Tributacao,&
			ls_Observacao,&
			ls_Cnpj_Emitente,&
			ls_Cnpj_Remetente,&
			ls_Erro,&
			ls_Chave_Nota,&
			ls_Nome_Componente
			
Long 	ll_Conhecimento,&
		ll_Natureza_Operacao,&
		ll_Forma_Pagamento,&
		ll_Qt_Volumes,&
		ll_Linha,&
		ll_Linhas,&
		ll_Tomador
		
Decimal	ldc_Bc_Icms,&
			ldc_Reducao_Bc_Icms,&   
			ldc_Pc_Icms,&
			ldc_Vl_Icms,&
			ldc_Vl_Bc_Icms_St_Retido,&
			ldc_Pc_Red_Bc_Icms_St_Retido,&
			ldc_Vl_Conhecimento,&
			ls_Valor_Componente
		
DateTime	ldh_Emissao,& 
				ldh_Importacao
				
dw_2.AcceptText()

ls_Cnpj_Emitente			= dw_2.Object.de_cnpj_emit[1] 
ls_Cnpj_Remetente		= dw_2.Object.de_cnpj_rem[1]

If Not wf_localiza_codigo_fornecedor(ls_Cnpj_Emitente, Ref ls_Emitente) Then
	Return -1
End If

If Not wf_localiza_codigo_fornecedor(ls_Cnpj_Remetente, Ref ls_Remetente) Then
	Return -1
End If

ll_Conhecimento						= dw_2.Object.nr_cte								[1]
ls_Serie									= dw_2.Object.de_serie_cte					[1]
ldh_Emissao								= dw_2.Object.dh_emissao						[1]
ls_Chave_Acesso						= dw_2.Object.de_chave_acesso				[1]
ll_Natureza_Operacao				= dw_2.Object.cd_natureza_operacao		[1]
ls_Natureza_Operacao				= dw_2.Object.de_natureza_operacao		[1]
ll_Forma_Pagamento					= dw_2.Object.cd_forma_pagamento			[1]
ls_Cst_Tributacao						= dw_2.Object.cd_cst_tributacao				[1]
ldc_Bc_Icms								= dw_2.Object.vl_bc_icms						[1]
ldc_Reducao_Bc_Icms				= dw_2.Object.pc_reducao_bc_icms			[1]
ldc_Pc_Icms								= dw_2.Object.pc_icms							[1]
ldc_Vl_Icms								= dw_2.Object.vl_icms							[1]
ldc_Vl_Bc_Icms_St_Retido			= dw_2.Object.vl_bc_icms_st_retido			[1]
ldc_Pc_Red_Bc_Icms_St_Retido	= dw_2.Object.pc_red_bc_icms_st_retido	[1]
ldc_Vl_Conhecimento					= dw_2.Object.vl_receber						[1]
ll_Qt_Volumes							= dw_2.Object.qt_volumes						[1]
ls_Observacao							= dw_2.Object.de_observacao					[1]
ll_Tomador								= dw_2.Object.nr_tomador						[1]
		
If Not wf_Conhecimento_Importado(ls_Emitente, ll_Conhecimento, ls_Serie) Then
	Return -1
End If		

//********************Insere o conhecimento********************
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
			nr_tomador)
Values(	:ls_Emitente,
			:ll_Conhecimento,   
			:ls_Serie,   
			:ldh_Emissao,  
			GetDate(),
			:ls_Chave_Acesso,   
			:ls_Remetente,   
			:ll_Natureza_Operacao,   
			:ls_Natureza_Operacao,   
			:ll_Forma_Pagamento,   
			:ls_Cst_Tributacao,   
			:ldc_Bc_Icms,   
			:ldc_Reducao_Bc_Icms,   
			:ldc_Pc_Icms,   
			:ldc_Vl_Icms,   
			:ldc_Vl_Bc_Icms_St_Retido,   
			:ldc_Pc_Red_Bc_Icms_St_Retido,   
			:ldc_Vl_Conhecimento,   
			GetDate(),
			:ll_Qt_Volumes,   
			:ls_Observacao,
			:ll_Tomador) 
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case -1
		ls_Erro = SqlCa.SqlErrText
		SqlCa.of_RollBack()
		MessageBox("Erro", "Ero ao salvar dados do CT-e : "+ls_Erro)
		Return -1
End Choose
//***********************************************************

//************* Insere as notas *******************************
dw_4.AcceptText()

ll_Linhas = dw_4.RowCount()

For ll_Linha = 1 To ll_Linhas
	ls_Chave_Nota = dw_4.Object.de_chave_nfe[ll_linha]
	
	INSERT INTO conhecimento_transp_nf  
				( cd_emitente,   
				  nr_conhecimento,   
				  de_serie,   
				  de_chave_acesso )  
	  VALUES (	:ls_Emitente,
					:ll_Conhecimento,   
					:ls_Serie, 
					:ls_Chave_Nota ) 
	Using SqlCa;	
	
	Choose Case SqlCa.SqlCode
		Case -1
			ls_Erro = SqlCa.SqlErrText
			SqlCa.of_RollBack()
			MessageBox("Erro", "Ero ao salvar os documentos origin$$HEX1$$e100$$ENDHEX$$rios : "+ls_Erro)
			Return -1
	End Choose
Next
//***********************************************************

//********************Insere dados do frete************************
dw_5.AcceptText()

ll_Linhas = dw_5.RowCount()

For ll_Linha = 1 To ll_Linhas
	ls_Nome_Componente	= dw_5.Object.nm_componente	[ll_linha]
	ls_Valor_Componente		= dw_5.Object.vl_componente		[ll_linha]
	
	INSERT INTO conhecimento_transp_componente(  
				  cd_emitente,   
				  nr_conhecimento,   
				  de_serie,   
				  nm_componente,   
				  vl_componente )  
	  VALUES ( 	:ls_Emitente,
					:ll_Conhecimento,   
					:ls_Serie,   
					:ls_Nome_Componente,   
					:ls_Valor_Componente)
	Using SqlCa;
	Choose Case SqlCa.SqlCode
		Case -1
			ls_Erro = SqlCa.SqlErrText
			SqlCa.of_RollBack()
			MessageBox("Erro", "Ero ao salvar os componentes do frete : "+ls_Erro)
			Return -1
	End Choose
Next
//***********************************************************


SqlCa.of_Commit()
wf_Limpa_Tela()

Return -1
end event

event ue_cancel;call super::ue_cancel;
wf_Limpa_Tela()
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge195_importar_cte
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge195_importar_cte
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge195_importar_cte
integer y = 196
integer width = 3365
integer height = 1496
integer weight = 700
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge195_importar_cte
integer width = 2921
integer height = 164
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge195_importar_cte
integer y = 76
integer width = 2862
integer height = 100
string dataobject = "dw_ge195_selecao"
end type

event dw_1::itemchanged;//OverRide

Long 	ll_Cte

dw_2.AcceptText()

If dw_2.RowCount() > 0 Then
	ll_Cte = dw_2.Object.nr_cte[1]
	
	If Not IsNull(ll_Cte) Then
		This.ivm_Menu.mf_Confirmar(False)
		This.ivm_Menu.mf_Cancelar(False)
		This.ivm_Menu.mf_recuperar( True)
		
		dw_2.Reset()
		dw_4.Reset()
		dw_5.Reset()
	End If
End If
end event

event dw_1::editchanged;//OverRide

Long 	ll_Cte

dw_2.AcceptText()

If dw_2.RowCount() > 0 Then
	ll_Cte = dw_2.Object.nr_cte[1]
	
	If Not IsNull(ll_Cte) Then
		This.ivm_Menu.mf_Confirmar(False)
		This.ivm_Menu.mf_Cancelar(False)
		This.ivm_Menu.mf_recuperar( True)
		
		dw_2.Reset()
		dw_4.Reset()
		dw_5.Reset()
	End If
End If
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge195_importar_cte
integer y = 252
integer width = 3296
integer height = 1432
string dataobject = "dw_ge195_detalhes"
boolean vscrollbar = false
boolean livescroll = false
end type

event dw_2::constructor;//OverRide
String lvs_DataObject

This.of_SetTransObject(SqlCa)

lvs_DataObject = This.DataObject

If Trim(This.DataObject) <> "" Then
	ivs_SQL_Original = This.Object.DataWindow.Table.Select
End If

ivo_Controle_Menu = Create dc_uo_Menu_DW

ivo_Controle_Menu.of_SetDW(This)

SetNull(ivm_Menu)

This.of_GetParentWindow()

end event

event dw_2::ue_recuperar;//OverRide

uo_ge195_cte lo_Cte

Integer li_FileOpen

String 	ls_Xml,&
			ls_Chave_Acesso,&
			ls_Diretorio_XML

Long	ll_Itens,&
		ll_Row

t_cte lt_cte

Date ldt_Emissao

dw_1.AcceptText()

ls_Chave_Acesso	= dw_1.Object.de_chave_acesso	[1]
ldt_Emissao			= dw_1.Object.dh_emissao			[1]

If IsNull(ls_Chave_Acesso) or (Trim(ls_Chave_Acesso) = "") Then
	MessageBox("Erro", "Informe a chave de acesso.")
	dw_1.Event ue_Pos(1,"de_chave_acesso")
	Return -1
End If

If Len(ls_Chave_Acesso) <> 44 Then
	MessageBox("Erro", "Informe a chave de acesso deve ter 44 digitos.")
	dw_1.Event ue_Pos(1,"de_chave_acesso")
	Return -1
End If

If IsNull(ldt_Emissao) Then
	MessageBox("Erro", "Informe a data de emiss$$HEX1$$e300$$ENDHEX$$o.")
	dw_1.Event ue_Pos(1,"dh_emissao")
	Return -1
End If

If Not wf_busca_xml_ftp(ls_Chave_Acesso, ldt_Emissao, Ref ls_Diretorio_XML) Then
	dw_1.Event ue_Pos(1,"de_chave_acesso")
	Return -1
End If

//li_FileOpen = FileOpen ("C:\Users\cleser.wiggers\Downloads\35150660664828000176570000049312131216819690.xml" , TextMode! , Read!, LockRead! )
li_FileOpen = FileOpen (ls_Diretorio_XML , TextMode! , Read!, LockRead! )

If li_FileOpen = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Ocorreu erro ao abrir o arquivo XML.")
	dw_1.Event ue_Pos(1,"de_chave_acesso")
	Return -1
End If

FileReadEx (li_FileOpen, ls_Xml) 

If FileClose (li_FileOpen) = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Ocorreu erro ao fechar o arquivo XML.")
	dw_1.Event ue_Pos(1,"de_chave_acesso")
	Return -1
End If

If Not FileDelete(ls_Diretorio_XML) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Ocorreu erro ao deletar o arquivo XML.")
	dw_1.Event ue_Pos(1,"de_chave_acesso")
	Return -1
End If

Try
	lo_Cte = Create uo_ge195_cte

	If Not lo_Cte.of_read_xml(ls_Xml, ref  lt_cte ) Then
		Return 1 
	End If
	
	Try
		dw_2.Object.de_chave_acesso			[1] = lt_cte.id
		dw_2.Object.nr_cte						[1] = lt_cte.ide.nct
		dw_2.Object.de_serie_cte				[1] = lt_cte.ide.serie
		dw_2.Object.dh_emissao				[1] = DateTime(Mid(lt_cte.ide.dhemi,9,2)+"/"+Mid(lt_cte.ide.dhemi,6,2)+"/"+Mid(lt_cte.ide.dhemi,1,4)+" "+Mid(lt_cte.ide.dhemi,12,8))
		dw_2.Object.de_observacao			[1] = lt_cte.compl.xobs
		dw_2.Object.cd_natureza_operacao	[1] = lt_cte.ide.cfop
		dw_2.Object.de_natureza_operacao	[1] = lt_cte.ide.natop
		dw_2.Object.cd_forma_pagamento	[1] = lt_cte.ide.forpag
		 
		dw_2.Object.nr_tomador					[1] = lt_cte.toma03.toma
		
		dw_2.Object.nm_emitente				[1] = lt_cte.emit.xnome
		dw_2.Object.de_rua_emit				[1] = lt_cte.emit.enderemit.xlgr
		dw_2.Object.nr_endereco_emit		[1] = Long(lt_cte.emit.enderemit.nro)
		dw_2.Object.de_bairro_emit			[1] = lt_cte.emit.enderemit.xbairro
		dw_2.Object.de_municipio_emit		[1] = lt_cte.emit.enderemit.xmun
		dw_2.Object.de_uf_emit					[1] = lt_cte.emit.enderemit.uf
		dw_2.Object.de_cep_emit				[1] = lt_cte.emit.enderemit.cep
		dw_2.Object.de_complemento_emit	[1] = lt_cte.emit.enderemit.xcpl
		dw_2.Object.de_cnpj_emit				[1] = lt_cte.emit.cnpj
		dw_2.Object.de_ie_emit					[1] = lt_cte.emit.ie
		dw_2.Object.de_fone_emit				[1] = lt_cte.emit.enderemit.fone
		
		dw_2.Object.nm_remetente				[1] = lt_cte.rem.xnome
		dw_2.Object.de_rua_rem				[1] = lt_cte.rem.enderreme.xlgr
		dw_2.Object.nr_endereco_rem			[1] = Long(lt_cte.rem.enderreme.nro)
		dw_2.Object.de_bairro_rem				[1] = lt_cte.rem.enderreme.xbairro
		dw_2.Object.de_municipio_rem		[1] = lt_cte.rem.enderreme.xmun
		dw_2.Object.de_uf_rem					[1] = lt_cte.rem.enderreme.uf
		dw_2.Object.de_cep_rem				[1] = lt_cte.rem.enderreme.cep
		dw_2.Object.de_complemento_rem	[1] = lt_cte.rem.enderreme.xcpl
		dw_2.Object.de_cnpj_rem				[1] = lt_cte.rem.cnpj
		dw_2.Object.de_ie_rem					[1] = lt_cte.rem.ie
		dw_2.Object.de_fone_rem				[1] = lt_cte.rem.fone
		
		//Notas de origem
		ll_Itens = UpperBound(lt_cte.infdoc.infnfe[])
		
		For ll_Row = 1 To ll_Itens
			dw_4.Object.de_especie_nfe	[ll_Row] = "NF-e"
			dw_4.Object.de_serie_nfe		[ll_Row] = Mid(lt_cte.infdoc.infnfe[ll_Row].chave, 23, 3)
			dw_4.Object.nr_nfe				[ll_Row] = LOng(MId(lt_cte.infdoc.infnfe[ll_Row].chave, 27, 9))
			dw_4.Object.de_chave_nfe		[ll_Row] = lt_cte.infdoc.infnfe[ll_Row].chave
		Next
		
		//Componentes de frete
		ll_Itens = UpperBound(lt_cte.vprest.comp[])
		
		For ll_Row = 1 To ll_Itens
			dw_5.Object.nm_componente	[ll_Row] = lt_cte.vprest.comp[ll_Row].xnome
			dw_5.Object.vl_componente	[ll_Row] = lt_cte.vprest.comp[ll_Row].vcomp
		Next
		
		//Informa$$HEX2$$e700f500$$ENDHEX$$es da Carga
		dw_2.Object.de_prd_predominante	[1] = lt_cte.infcarga.propred
		
		ll_Itens = UpperBound(lt_cte.infcarga.infq[])
		
		For ll_Row = 1 To ll_Itens
			If lt_cte.infcarga.infq[ll_Row].cUnid = "03" Then
				dw_2.Object.qt_volumes	[1] = lt_cte.infcarga.infq[ll_Row].qCarga
			End If
		Next
		
		dw_2.Object.vl_total							[1] = lt_cte.vprest.vtprest
		dw_2.Object.vl_receber						[1] = lt_cte.vprest.vrec
		dw_2.Object.cd_cst_tributacao				[1]	= lt_cte.icms.tipoicms
		dw_2.Object.vl_bc_icms						[1]= lt_cte.icms.vbc
		dw_2.Object.pc_reducao_bc_icms			[1]= lt_cte.icms.predbc
		dw_2.Object.pc_icms							[1]= lt_cte.icms.picms
		dw_2.Object.vl_icms							[1]= lt_cte.icms.vicms
		dw_2.Object.vl_bc_icms_st_retido			[1]= lt_cte.icms.vbcstret
		dw_2.Object.pc_red_bc_icms_st_retido	[1]= lt_cte.icms.picmsstret
		
		Parent.ivm_Menu.mf_Confirmar(True)
		Parent.ivm_Menu.mf_Cancelar(True)
		Parent.ivm_Menu.mf_recuperar( False)
		
	Catch (runtimeerror er)   
		MessageBox("Erro", "Erro ao importar o XML da CT-e: ~r~r"+er.GetMessage(), StopSign!)
		Return 1
	End Try
		
Finally
	Destroy(lo_Cte)	
End Try

Return 1
end event

event dw_2::ue_postretrieve;//OverRide

Return 0
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge195_importar_cte
integer y = 216
end type

type dw_4 from dc_uo_dw_base within w_ge195_importar_cte
integer x = 91
integer y = 1016
integer width = 2217
integer height = 384
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge195_notas"
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.of_SetRowSelection()
end event

type dw_5 from dc_uo_dw_base within w_ge195_importar_cte
integer x = 2350
integer y = 312
integer width = 992
integer height = 524
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge195_componentes_frete"
boolean vscrollbar = true
boolean livescroll = false
end type

event constructor;call super::constructor;This.of_SetRowSelection()
end event

