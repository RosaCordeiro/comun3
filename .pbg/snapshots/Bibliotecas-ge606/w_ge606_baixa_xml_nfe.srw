HA$PBExportHeader$w_ge606_baixa_xml_nfe.srw
forward
global type w_ge606_baixa_xml_nfe from dc_w_response_ok_cancela
end type
type dw_2 from datawindow within w_ge606_baixa_xml_nfe
end type
type gb_2 from groupbox within w_ge606_baixa_xml_nfe
end type
type st_1 from statictext within w_ge606_baixa_xml_nfe
end type
type dw_3 from datawindow within w_ge606_baixa_xml_nfe
end type
type cb_1 from commandbutton within w_ge606_baixa_xml_nfe
end type
end forward

global type w_ge606_baixa_xml_nfe from dc_w_response_ok_cancela
integer width = 4768
integer height = 2032
string title = "GE606 - Baixa XML"
boolean controlmenu = true
dw_2 dw_2
gb_2 gb_2
st_1 st_1
dw_3 dw_3
cb_1 cb_1
end type
global w_ge606_baixa_xml_nfe w_ge606_baixa_xml_nfe

type variables
String is_Diretorio_XML
Long ivl_Produto

Datetime ivdh_Inicio
Datetime ivdh_Fim

String ivs_Filiais
String ivs_Chaves_acesso

uo_filial				ivo_filial
uo_ge216_filiais	ivo_filiais


end variables

forward prototypes
public function boolean of_parametro_conexao_ftp (ref string as_ftp_xml_endereco, ref string as_ftp_xml_usuario, ref string as_ftp_xml_senha)
public subroutine wf_retorna_tipo (long al_filial, string as_chave, date adt_incio, date adt_fim)
public function boolean wf_importar_planilha_chave_acesso ()
public function boolean wf_baixa_xml_nfe ()
public function boolean wf_inclui_controle (string as_chave, date adh_emissao, datetime adh_movimentacao_caixa, string as_especie, string as_erro, long al_filial, long al_nr_nf, string as_de_serie, string as_nr_matricula_baixa)
public function boolean wf_inclui_divergencia (string as_chave, date adh_emissao, datetime adh_movimentacao_caixa, string as_especie, string as_erro, long al_filial, long al_nr_nf, string as_de_serie, string as_nr_matricula_baixa, string as_fantasia)
end prototypes

public function boolean of_parametro_conexao_ftp (ref string as_ftp_xml_endereco, ref string as_ftp_xml_usuario, ref string as_ftp_xml_senha);String ls_Parametro

ls_Parametro = 'DE_FTP_XML_ENDERECO'

select vl_parametro
Into :as_ftp_xml_endereco
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

If IsNull(as_ftp_xml_endereco) or as_ftp_xml_endereco = '' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Par$$HEX1$$e200$$ENDHEX$$metro geral de comunica$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido '" + ls_Parametro + "'.")
	Return False
End If
as_ftp_xml_endereco = Lower(as_ftp_xml_endereco)

ls_Parametro = 'DE_FTP_XML_USUARIO'
select vl_parametro
Into :as_ftp_xml_usuario
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
//
If IsNull(as_ftp_xml_usuario) or as_ftp_xml_usuario = '' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Par$$HEX1$$e200$$ENDHEX$$metro geral de comunica$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido '" + ls_Parametro  + "'.")
	Return False
End If
as_ftp_xml_usuario = Lower(as_ftp_xml_usuario)

ls_Parametro = 'DE_FTP_XML_SENHA'
select vl_parametro
Into :as_ftp_xml_senha
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

If IsNull(as_ftp_xml_senha) or as_ftp_xml_senha = '' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Par$$HEX1$$e200$$ENDHEX$$metro geral de comunica$$HEX2$$e700e300$$ENDHEX$$o inv$$HEX1$$e100$$ENDHEX$$lido '" + ls_Parametro +  "'.")
	Return False
End If

as_ftp_xml_senha = Lower(as_ftp_xml_senha)

Return True
end function

public subroutine wf_retorna_tipo (long al_filial, string as_chave, date adt_incio, date adt_fim);//select 'VENDA'
//from dbo.nf_venda n (index idx_data_filial)
//inner join dbo.nf_venda_nfe e on e.cd_filial = n.cd_filial and e.nr_nf = n.nr_nf	and e.de_especie = n.de_especie	and e.de_serie = n.de_serie
//where n.dh_movimentacao_caixa >= :adt_inicio
// AND n.dh_movimentacao_caixa <= :adt_fim
// and n.cd_filial = :al_filial
// and n.dh_cancelamento is null
// 
//union
//
//select 'VENDA_DEV'
//from dbo.nf_devolucao_venda n (index idx_dh_movimentacao_caixa)
//inner join dbo.nf_devolucao_venda_nfe e on e.cd_filial = n.cd_filial and e.nr_nf = n.nr_nf	and e.de_especie = n.de_especie	and e.de_serie = n.de_serie
//where n.dh_movimentacao_caixa >= :adt_inicio'
// AND n.dh_movimentacao_caixa <= :adt_fim
// and n.cd_filial :al_filial
// and n.dh_cancelamento is null
// 
//union 
//
//select 'TS'
//from dbo.nf_transferencia_nfe e
//where n.dh_movimentacao_caixa >= :adt_inicio
// AND n.dh_movimentacao_caixa <= :adt_fim
// and n.cd_filial_origem :al_filial
// and n.dh_cancelamento is null
// 
//union 
//
//select 'TE'
//from dbo.nf_transferencia n (index idx_filial_destino)
//inner join dbo.nf_transferencia_nfe e on e.cd_filial_origem = n.cd_filial_origem and e.nr_nf = n.nr_nf	and e.de_especie = n.de_especie	and e.de_serie = n.de_serie
//where n.dh_movimentacao_caixa >= :adt_inicio
// AND n.dh_movimentacao_caixa <= :adt_fim
// and n.cd_filial_destino :al_filial
// and n.dh_cancelamento is null
// 
//union 
//
//select 'COMPRA'
//from dbo.nf_compra n (index idx_filial_data_movimento)
//where n.dh_movimentacao_caixa >= :adt_inicio
// AND n.dh_movimentacao_caixa <= :adt_fim
// and n.cd_filial :al_filial
// 
//union
//
//select 'COMPRA_DEV'
//from dbo.nf_devolucao_compra n (index idx_dh_movimentacao_caixa)
//inner join dbo.nf_devolucao_compra_nfe e on e.cd_filial = n.cd_filial and e.nr_nf = n.nr_nf	and e.de_especie = n.de_especie	and e.de_serie = n.de_serie
//where n.dh_movimentacao_caixa >= :adt_inicio
// AND n.dh_movimentacao_caixa <= :adt_fim
// and n.cd_filial :al_filial
// and n.dh_cancelamento is null
// 
//union 
//
//select 'DIVERSA'
//from dbo.nf_diversa n (index idx_filial_origem_data)
//inner join dbo.nf_diversa_nfe e on e.cd_filial_origem = n.cd_filial_origem and e.nr_nf = n.nr_nf	and e.de_especie = n.de_especie	and e.de_serie = n.de_serie
//where n.dh_movimentacao_caixa >= :adt_inicio
// AND n.dh_movimentacao_caixa <= :adt_fim
// and n.cd_filial_origem :al_filial
// and n.dh_cancelamento is null
// 
//;
end subroutine

public function boolean wf_importar_planilha_chave_acesso ();Long		lvl_Linha,&
			lvl_Linhas
			
Integer	lvi_File, lvi_ret

String		lvs_FullName,&
			lvs_FileName,&
			lvs_msg
			
Any		lva_Dado

String ls_Nome_Fantasia

dc_uo_excel lvo_Excel
		
//Orienta usuario
MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Os dados na planilha devem estar da seguinte forma:~r~n~r~nColuna A = Chave e Acesso da NF-e")

//Seleciona arquivo
lvi_ret = GetFileOpenName ("Selecione o arquivo Excel", +lvs_FullName, lvs_FileName, &
	"xlsx","Excel 2007 (*.xlsx),*.xlsx,Excel 97-2003 (*.xls),*.xls")
	
Choose Case lvi_ret
	Case 0
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Opera$$HEX2$$e700e300$$ENDHEX$$o cancelada pelo usu$$HEX1$$e100$$ENDHEX$$rio.")
		Return True
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Ocorreu um erro ao selcionar o arquivo excel.")
		Return True
End Choose
		
Try
	
	lvo_Excel = Create dc_uo_excel			
					
	Open(w_Aguarde)
	
	w_Aguarde.Title = "Importando planilha ..."
	
	// Refer$$HEX1$$ea00$$ENDHEX$$ncia o arquivo 
	If ( lvo_Excel.uo_Referencia_Objeto_Excel(lvs_FullName) ) Then
		
		// Coluna de Refer$$HEX1$$ea00$$ENDHEX$$ncia
		lvl_Linhas = lvo_Excel.uo_Verifica_Tamanho_Arquivo("A") 
		
		If lvl_Linhas > 0 Then
			w_Aguarde.uo_Progress.of_SetMax(lvl_Linhas)
			
			ivs_Chaves_acesso = ""
			For lvl_Linha = 1 To lvl_Linhas
				
				w_Aguarde.uo_Progress.of_SetProgress(lvl_Linha)
												
				// Chave acesso
				lva_Dado = lvo_Excel.uo_Lendo_Dados(lvl_Linha, "A")
				
				If ivs_Chaves_acesso = "" Then
					ivs_Chaves_acesso = "'"+String(lva_Dado)+"'"
				Else
					ivs_Chaves_acesso = ivs_Chaves_acesso + ",'"+String(lva_Dado)+"'"
				End If
				
			Next
			
			dw_3.object.de_chaves[1] = ivs_Chaves_acesso
			
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Importa$$HEX2$$e700e300$$ENDHEX$$o da planilha conclu$$HEX1$$ed00$$ENDHEX$$da.")
		  
		Else // ll_Linhas
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A planilha n$$HEX1$$e300$$ENDHEX$$o possui nenhuma linha.")
		End If
		
	End If
	
Finally
	If IsValid(w_Aguarde) 	Then Close(w_Aguarde)
	If IsValid(lvo_Excel) 		Then Destroy(lvo_Excel)
End Try
		
Return True
end function

public function boolean wf_baixa_xml_nfe ();dc_uo_ds_Base		lds_Notas

dc_uo_ftp lo_Ftp

dc_uo_api lo_api

String	lvs_ftp_xml_endereco,&
		lvs_ftp_xml_usuario,&
		lvs_ftp_xml_senha,&
		lvs_Mensagem,&
		lvs_Cnpj,&
		lvs_Chave_Acesso,&
		lvs_Diretorio,&
		lvs_Arquivo_Xml,&
		lvs_Arquivo_Xml_UPPER1,&
		lvs_Arquivo_Xml_UPPER2,&
		lvs_Path_XML,&
		lvs_Ano,&
		lvs_Mes,&
		lvs_Dia,&
		lvs_Erro = "",&
		lvs_Especie,&
		lvs_Especie_Anterior = "",&
		lvs_Nulo,&
		lvs_Selecao,&
		lvs_Tipo,&
		lvs_Diretorio_Filial,&
		lvs_SQL,&
		lvs_de_serie,&
		lvs_nm_fantasia
		
Long	lvl_Linha,&
		lvl_Linhas,&
		lvl_Ano,&
		lvl_Mes,&
		lvl_Dia,&
		lvl_achou,&
		lvl_Filial,&
		lvl_nr_nf,&
		lvl_Filial_Filtro
		
		
Date	lvdt_Emissao		
DateTime lvdh_movimentacao_caixa

SetNull(lvs_Nulo)

Try
	
	lo_Ftp			= Create dc_uo_ftp 
	lds_Notas	= Create dc_uo_ds_Base
	lo_Api			= Create dc_uo_api

	dw_3.AcceptText( )

	ivdh_Inicio	= dw_3.Object.dh_inicio		[1]
	ivdh_Fim 	= dw_3.Object.dh_fim		[1]
	lvl_Filial_Filtro		= dw_3.Object.cd_filial		[1]
	lvs_Selecao	= dw_3.Object.id_filial		[1]
	If dw_3.Object.nf_venda[1] = "S" Then lvs_Tipo = "'ve'"
	if dw_3.Object.nf_transf_e[1] = "S" Then
		If lvs_Tipo <> "" Then
			lvs_Tipo = lvs_Tipo + ",'te'"
		Else
			lvs_Tipo = "'te'"
		End If
	End If
	If dw_3.Object.nf_compra[1] = "S" Then
		If lvs_Tipo <> "" Then
			lvs_Tipo = lvs_Tipo + ",'co'"
		Else
			lvs_Tipo = "'co'"
		End If
	End If
	If dw_3.Object.nf_diversa[1] = "S" Then
		If lvs_Tipo <> "" Then
			lvs_Tipo = lvs_Tipo + ",'di'"
		Else
			lvs_Tipo = "'di'"
		End If
	End If
	if dw_3.Object.nf_dev_venda[1] = "S" Then
		If lvs_Tipo <> "" Then
			lvs_Tipo = lvs_Tipo + ",'dv'"
		Else
			lvs_Tipo = "'dv'"
		End If
	End If
	If dw_3.Object.nf_transf_s[1] = "S" Then
		If lvs_Tipo <> "" Then
			lvs_Tipo = lvs_Tipo + ",'ts'"
		Else
			lvs_Tipo = "'ts'"
		End If
	End If
	If dw_3.Object.nf_dev_compra	[1] = "S" Then
		If lvs_Tipo <> "" Then
			lvs_Tipo = lvs_Tipo + ",'dc'"
		Else
			lvs_Tipo = "'dc'"
		End If
	End If
	
	If dw_3.Object.nf_compra_excluida[1] = "S" Then
		If lvs_Tipo <> "" Then
			lvs_Tipo = lvs_Tipo + ",'ne'"
		Else
			lvs_Tipo = "'ne'"
		End If
	End If	
	
	If lvs_Tipo = "" Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe ao menos uma op$$HEX2$$e700e300$$ENDHEX$$o de Nota.",Exclamation!)
		dw_3.setfocus( )
		Return False 
	Else
		lvs_Tipo = " in("+lvs_Tipo+")"
	End If
	
	If ivdh_Inicio < Datetime('1900/01/01') Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio corretamente.",Exclamation!)
		dw_3.SetFocus()
		Return False 
	End If
	
	If ivdh_Fim < Datetime('1900/01/01') Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino corretamente.",Exclamation!)
		dw_3.SetFocus()
		Return False 
	End If
	
	If Date(ivdh_Inicio) > Date(ivdh_Fim) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a data de t$$HEX1$$e900$$ENDHEX$$rmino.",Exclamation!)
		dw_3.SetFocus()
		Return False 
	End If
	
	If lvs_Selecao = "U" Then
		If Not IsNull(lvl_Filial_Filtro) and (lvl_Filial_Filtro > 0) Then
			ivs_Filiais = String(lvl_Filial_Filtro)
		End If
	End If
	If (IsNull(ivs_Filiais) Or ivs_Filiais = "") And (IsNull(ivs_Chaves_acesso) Or ivs_Chaves_acesso = "") Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Pelo menos uma filial ou um grupo de chave de acesso devem ser informado.",Exclamation!)
		dw_3.setfocus( )
		Return False 
	End If
	
		
	ivdh_Inicio	= Datetime(Date(ivdh_Inicio),Time('00:00:00'))
	ivdh_Fim 	= Datetime(Date(ivdh_Fim),Time('23:59:59'))
	
	Open(w_Aguarde)
	
	If Not lds_Notas.of_ChangeDataObject("dw_ge606_notas") Then
		MessageBox("Erro", "Erro no ChageDataObject da dw_ge606_notas.")
		Return False
	End If
	
	lds_Notas.of_appendwhere_subquery("tmp.tipo "+lvs_Tipo, 11)
	
	If ivs_Filiais <> "" Then
		lds_Notas.of_appendwhere_subquery("tmp.cd_filial in("+ivs_Filiais+")", 11)
	End If
	
	If ivs_Chaves_acesso <> "" Then
		lds_Notas.of_appendwhere_subquery("tmp.de_chave_acesso in("+ivs_Chaves_acesso+")", 11)
	End If
	
	lvl_Linhas	= lds_Notas.Retrieve(ivdh_Inicio,ivdh_Fim)
	//Nao entendi o erro de indice - ver com Sergio. Porem no segundo retrieve nao ocorre...???
	If lvl_Linhas < 0 Then lvl_Linhas	= lds_Notas.Retrieve(ivdh_Inicio,ivdh_Fim)
	lvs_SQL = lds_Notas.GetSqlSelect()
	ClipBoard(lvs_SQL)
	
	If lvl_Linhas < 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro no Retrieve. Entre em contato com a TI.~r~n"+SqlCa.is_lasterrortext+"~r~n"+SqlCa.sqlerrtext )
		Return False
	End If
	
	If lvl_Linhas = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizado nenhum registro.")
		Return False
	End If
	
	If lvl_Linhas > 0 Then
		dw_2.reset( )
		w_Aguarde.Title = "Baixando XML ... "
		w_Aguarde.uo_Progress.of_setmax(lvl_Linhas)
		
		If Not of_parametro_conexao_ftp(Ref lvs_ftp_xml_endereco, Ref lvs_ftp_xml_usuario, Ref lvs_ftp_xml_senha) Then
			Return False
		End If
				
		For lvl_Linha = 1 To lvl_Linhas
			w_Aguarde.Title = "Baixando XML ... " + String(lvl_Linha) + " de " + String(lvl_Linhas)
			w_Aguarde.uo_Progress.of_setprogress(lvl_Linha)
			
			lvdt_Emissao					=	Date(lds_Notas.Object.dh_emissao		[lvl_Linha]	)
			lvs_Chave_Acesso				=	lds_Notas.Object.de_chave_acesso		[lvl_Linha]	
			lvs_Especie						=	lds_Notas.Object.de_especie				[lvl_Linha]	
			lvdh_movimentacao_caixa	= lds_Notas.Object.dh_movimentacao_caixa[lvl_Linha]	
			lvl_Filial							= lds_Notas.Object.cd_Filial						[lvl_Linha]	
			lvl_nr_nf							= lds_Notas.Object.nr_nf							[lvl_Linha]	
			lvs_de_serie						= lds_Notas.Object.de_serie					[lvl_Linha]
			lvs_nm_fantasia				= lds_Notas.Object.nm_fantasia				[lvl_Linha]

			
			If lvs_Especie <> lvs_Especie_Anterior Then
				If lo_Ftp.of_desconecta_ftp( ) <> 1 Then
					MessageBox("Erro", "Erro ao desconectar do FTP.")
					Return False
				End If
					
				If lvs_Especie  = 'NFE' Then
					If Not lo_Ftp.of_Conecta_ftp("GN", lvs_ftp_xml_endereco, lvs_ftp_xml_usuario, lvs_ftp_xml_senha, Ref lvs_Mensagem) Then
						MessageBox("Erro", "Erro ao conectaro no FTP: "+lvs_Mensagem)
						Return False
					End If
				Else
					If Not lo_Ftp.of_Conecta_ftp("GN", lvs_ftp_xml_endereco, "nfce", "nfce", Ref lvs_Mensagem) Then
						MessageBox("Erro", "Erro ao conectaro no FTP: "+lvs_Mensagem)
						Return False
					End If
				End If				
			End If
		
			If  lo_Ftp.of_ftp_set_dir('/',Ref lvs_Mensagem)  = -1 Then
				MessageBox("Erro", "Erro ao retornar ao diret$$HEX1$$f300$$ENDHEX$$rio raiz do FTP: "+lvs_Mensagem)
				Return False		
			End If
			
			If lvs_Especie = 'NFE' Then
				lvs_Arquivo_Xml			= lvs_Chave_Acesso + "-nfe.xml"
				lvs_Arquivo_Xml_Upper1	= lvs_Chave_Acesso + "-NFE.xml"
				lvs_Arquivo_Xml_Upper2	= lvs_Chave_Acesso + "-NFE.XML"
			ElseIf lvs_Especie = 'SAT' Then
				lvs_Arquivo_Xml			= 'AD' + lvs_Chave_Acesso + ".xml.zip"
			Else // NFCE
				lvs_Arquivo_Xml			= lvs_Chave_Acesso +"-nfce.xml.zip"
				lvs_Arquivo_Xml_Upper1	= lvs_Chave_Acesso +"-NFCE.xml.zip"
				lvs_Arquivo_Xml_Upper2	= lvs_Chave_Acesso +"-NFCE.XML.zip"
			End If
			
		
			//lvs_Arquivo_Xml			= lvs_Chave_Acesso +iif(lvs_Especie = 'NFE', "-nfe.xml", "-nfce.xml.zip")
			//lvs_Arquivo_Xml_Upper1	= lvs_Chave_Acesso +iif(lvs_Especie = 'NFE', "-NFE.xml", "-NFCE.xml.zip")
			//lvs_Arquivo_Xml_Upper2	= lvs_Chave_Acesso +iif(lvs_Especie = 'NFE', "-NFE.XML", "-NFCE.XML.zip")
			
			lvs_Especie_Anterior		= lds_Notas.Object.de_especie[lvl_Linha]	
			
			lvl_Ano = Year(lvdt_Emissao)
			lvl_Mes = Month(lvdt_Emissao)
			lvl_Dia = Day(lvdt_Emissao)
								
			If lvs_Especie  = 'NFE' Then
				lvs_Ano = "Ano_"+String(lvl_Ano)
				If lvl_Mes < 10 Then lvs_Mes = "Mes_0"+String(lvl_Mes) Else lvs_Mes = "Mes_"+String(lvl_Mes)
				If lvl_Dia < 10 Then lvs_Dia = "Dia_0"+String(lvl_Dia) Else lvs_Dia = "Dia_"+String(lvl_Dia)
				lvs_Cnpj = Mid(lvs_Chave_Acesso, 7, 14)
				
				lvs_Diretorio = lvs_Ano + "/" + lvs_Mes + "/" + lvs_Dia + "/" + lvs_CNPJ
			Else
				lvs_Ano = String(lvl_Ano)
				If lvl_Mes < 10 Then lvs_Mes = "0"+String(lvl_Mes) Else lvs_Mes = String(lvl_Mes)
				If lvl_Dia < 10 Then lvs_Dia = "0"+String(lvl_Dia) Else lvs_Dia = String(lvl_Dia)
					
				lvs_Diretorio = lvs_Ano + "/" + lvs_Mes + "/" + lvs_Dia + "/" + Right("0000"+ String(lvl_Filial), 4)
	
			End If
			
			If lo_Ftp.of_Ftp_Set_Dir(lvs_Diretorio, Ref lvs_Mensagem) = -1 Then 
				lvs_Erro = iif(lvs_Erro = "", lvs_Chave_Acesso, lvs_Erro +"~r"+lvs_Chave_Acesso)
				If Not wf_inclui_divergencia(lvs_Chave_Acesso, lvdt_Emissao, lvdh_movimentacao_caixa, lvs_Especie, "PASTA N$$HEX1$$c300$$ENDHEX$$O LOCALIZADA NO FTP - " + lvs_Diretorio, lvl_Filial, lvl_nr_nf, lvs_de_serie, gvo_aplicacao.ivo_seguranca.nr_matricula,lvs_nm_fantasia) Then Return False
				continue
			End If
			
			lvs_Diretorio_Filial = String(lds_Notas.Object.cd_filial[lvl_Linha])+"-"+lvs_nm_fantasia + "\"
			
			If Not DirectoryExists( is_Diretorio_XML + lvs_Diretorio_Filial ) Then
				If CreateDirectory ( is_Diretorio_XML + lvs_Diretorio_Filial ) <> 1 Then
					MessageBox("Erro","Erro ao criar o diret$$HEX1$$f300$$ENDHEX$$rio '"+is_Diretorio_XML+ lvs_Diretorio_Filial +"'.")
					Return False
				End If
			End If
			
			If lvs_Especie  = 'NFC' Then 
				If FileExists(is_Diretorio_XML+lvs_Diretorio_Filial+Left(lvs_Arquivo_Xml,Len(lvs_Arquivo_Xml)-4)) Then
					If Not wf_inclui_divergencia(lvs_Chave_Acesso, lvdt_Emissao, lvdh_movimentacao_caixa, lvs_Especie, "XML J$$HEX1$$c000$$ENDHEX$$ FOI BAIXADO NO - " + is_Diretorio_XML+lvs_Diretorio_Filial, lvl_Filial, lvl_nr_nf, lvs_de_serie, gvo_aplicacao.ivo_seguranca.nr_matricula,lvs_nm_fantasia) Then Return False
					Continue
				End If
			Else
				If FileExists(is_Diretorio_XML+lvs_Diretorio_Filial+lvs_Arquivo_Xml) Then
					If Not wf_inclui_divergencia(lvs_Chave_Acesso, lvdt_Emissao, lvdh_movimentacao_caixa, lvs_Especie, "XML J$$HEX1$$c000$$ENDHEX$$ FOI BAIXADO NO - " + is_Diretorio_XML+lvs_Diretorio_Filial, lvl_Filial, lvl_nr_nf, lvs_de_serie, gvo_aplicacao.ivo_seguranca.nr_matricula,lvs_nm_fantasia) Then Return False
					Continue
				End If
			End If
			
			If not lo_Ftp.of_Ftp_GetFile(lvs_Arquivo_Xml, is_Diretorio_XML+lvs_Diretorio_Filial+lvs_Arquivo_Xml, Ref lvs_Mensagem) Then
				If not lo_Ftp.of_Ftp_GetFile(lvs_Arquivo_Xml_Upper1, is_Diretorio_XML+lvs_Diretorio_Filial+lvs_Arquivo_Xml, Ref lvs_Mensagem) Then
					If not lo_Ftp.of_Ftp_GetFile(lvs_Arquivo_Xml_Upper2, is_Diretorio_XML+lvs_Diretorio_Filial+lvs_Arquivo_Xml, Ref lvs_Mensagem) Then
						lvs_Erro = iif(lvs_Erro = "", lvs_Chave_Acesso, lvs_Erro +"~r"+lvs_Chave_Acesso)
						If Not wf_inclui_divergencia(lvs_Chave_Acesso, lvdt_Emissao, lvdh_movimentacao_caixa, lvs_Especie, "XML N$$HEX1$$c300$$ENDHEX$$O LOCALIZADO - " + lvs_Diretorio, lvl_Filial, lvl_nr_nf, lvs_de_serie, gvo_aplicacao.ivo_seguranca.nr_matricula,lvs_nm_fantasia) Then Return False
						continue
					End If
				End If
			End If
			
			If lvs_Especie  = 'NFC' or lvs_Especie = 'SAT' Then
				If not lo_Api.of_unzip( is_Diretorio_XML+lvs_Diretorio_Filial+lvs_Arquivo_Xml, is_Diretorio_XML+lvs_Diretorio_Filial) Then
					MessageBox("Erro", "Erro ao descompactar o arquivo "+lvs_Arquivo_Xml)
					Return False
				End If
				
				If not FileDelete( is_Diretorio_XML+lvs_Diretorio_Filial+lvs_Arquivo_Xml) Then
					MessageBox("Erro", "Erro ao deletar o arquivo "+lvs_Arquivo_Xml)
					Return False
				End If
			End If
					
			If Not wf_inclui_controle(lvs_Chave_Acesso, lvdt_Emissao, lvdh_movimentacao_caixa, lvs_Especie, lvs_Nulo, lvl_Filial, lvl_nr_nf, lvs_de_serie, gvo_aplicacao.ivo_seguranca.nr_matricula) Then Return False
			
		Next
		
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Download dos XML's de NFe realizado com sucesso.")
				
	End If
	
Catch ( runtimeerror  lo_rte )
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro: "+ lo_rte.GetMessage())
	Return False
Finally
	lo_Ftp.of_Desconecta_ftp()
	Destroy(lds_Notas)
	Destroy(lo_Ftp)
	Destroy(lo_Api)
	Close(w_Aguarde)
End Try

Return True

end function

public function boolean wf_inclui_controle (string as_chave, date adh_emissao, datetime adh_movimentacao_caixa, string as_especie, string as_erro, long al_filial, long al_nr_nf, string as_de_serie, string as_nr_matricula_baixa);INSERT INTO controle_baixa_xml  ( de_chave_acesso, dh_emissao, dh_movimentacao_caixa,de_especie, cd_filial, nr_nf, de_serie, nr_matricula_baixa )  
VALUES (:as_chave,  :adh_emissao, :adh_movimentacao_caixa, :as_especie, :al_filial, :al_nr_nf, :as_de_serie, :as_nr_matricula_baixa)
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_Rollback()
	Messagebox("Erro", "Erro ao inserir dados na controle_baixa_xml.~r~n"+SqlCa.sqlerrtext)
	Return False
End If

SqlCa.of_Commit()

end function

public function boolean wf_inclui_divergencia (string as_chave, date adh_emissao, datetime adh_movimentacao_caixa, string as_especie, string as_erro, long al_filial, long al_nr_nf, string as_de_serie, string as_nr_matricula_baixa, string as_fantasia);Long lvl_row

lvl_row = dw_2.InsertRow(0)

dw_2.Object.de_chave_acesso				[lvl_row] = as_chave
dw_2.Object.nr_nf								[lvl_row] = al_nr_nf
dw_2.Object.cd_filial							[lvl_row] = al_filial
dw_2.Object.nm_fantasia					[lvl_row] = as_fantasia
dw_2.Object.dh_emissao					[lvl_row] = adh_emissao
dw_2.Object.de_especie						[lvl_row] = as_especie
//dw_2.Object.dh_xml_baixado				[lvl_row] = DateTime (Today(), Now())
dw_2.Object.de_erro							[lvl_row] = as_Erro
dw_2.Object.de_serie							[lvl_row] = as_de_serie
dw_2.Object.nr_matricula_baixa			[lvl_row] = as_nr_matricula_baixa
dw_2.Object.dh_movimentacao_caixa	[lvl_row] = adh_movimentacao_caixa

Return True
end function

on w_ge606_baixa_xml_nfe.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.gb_2=create gb_2
this.st_1=create st_1
this.dw_3=create dw_3
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.gb_2
this.Control[iCurrent+3]=this.st_1
this.Control[iCurrent+4]=this.dw_3
this.Control[iCurrent+5]=this.cb_1
end on

on w_ge606_baixa_xml_nfe.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.gb_2)
destroy(this.st_1)
destroy(this.dw_3)
destroy(this.cb_1)
end on

event ue_postopen;call super::ue_postopen;dw_3.InsertRow(0)

ivdh_Inicio	= Datetime(RelativeDate(Today(),-1),Time('00:00'))
ivdh_Fim		= Datetime(Today(),Time('23:59:59'))

dw_3.Object.dh_inicio [1] = ivdh_Inicio
dw_3.Object.dh_fim	 [1] = ivdh_Fim

dw_3.Post SetFocus()

is_Diretorio_XML	= "C:\NFE\XML\"

If Not DirectoryExists( "C:\NFE\" ) Then
	If CreateDirectory ( "C:\NFE\" ) <> 1 Then
		MessageBox("Erro","Erro ao criar o diret$$HEX1$$f300$$ENDHEX$$rio 'C:\NFE\'.")
		Close(This)
		Return
	ElseIf Not DirectoryExists( "C:\NFE\XML\" ) Then
		If CreateDirectory ("C:\NFE\XML\" ) <> 1 Then
			MessageBox("Erro","Erro ao criar o diret$$HEX1$$f300$$ENDHEX$$rio 'C:\NFE\XML\'.")
			Close(This)
			Return
		End If
	End If
End If

st_1.Text = "Diret$$HEX1$$f300$$ENDHEX$$rio destino do XML: "+ is_Diretorio_XML
end event

event close;call super::close;Destroy(ivo_filial)
Destroy(ivo_filiais)
end event

event ue_preopen;call super::ue_preopen;ivo_filial		= Create uo_filial
ivo_filiais		= Create uo_ge216_filiais
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge606_baixa_xml_nfe
integer x = 2738
integer y = 36
integer width = 137
integer height = 116
integer taborder = 0
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge606_baixa_xml_nfe
integer width = 2930
integer height = 612
string text = " Filtros"
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge606_baixa_xml_nfe
boolean visible = false
integer x = 3360
integer y = 44
integer width = 279
integer height = 112
end type

event dw_1::itemchanged;call super::itemchanged;Long lvl_Lojas

Choose Case dwo.name
	Case "nm_filial"
		If Trim(Data) <> "" Then
			If Data <> ivo_Filial.nm_Fantasia Then
				Return 1
			End If	
		Else			
			ivo_Filial.Of_inicializa( )
			
			This.Object.Cd_Filial	[1] = ivo_Filial.Cd_Filial
			This.Object.Nm_Filial	[1] = ivo_Filial.Nm_Fantasia			
		End If
		
	Case "id_filial"
		ivs_filiais = "" 
		If Data = 'C' Then
					
			OpenWithParm(w_ge216_selecao_filiais, ivo_filiais)
			
			lvl_Lojas = Message.DoubleParm
			
			If lvl_Lojas > 0 Then
				ivs_filiais = ivo_filiais.ivs_filiais
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma filial foi selecionada.")
				Data = "T"
				dw_1.Object.id_filial [Row] = Data
			End If
			
		End If
End Choose

This.accepttext( )
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Filial) then
	If ivo_Filial.Localizada Then
		This.Object.nm_filial	[1] = ivo_filial.nm_fantasia
	End If
End If
This.accepttext( )
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	Choose Case This.GetColumnName() 
			
		Case "nm_filial"
			ivo_filial.of_Localiza_filial(This.GetText())
			
			If ivo_filial.Localizada Then
				 This.Object.cd_filial	[1] = ivo_filial.Cd_Filial
				 This.Object.nm_filial	[1] = ivo_filial.nm_fantasia
			Else 
				ivo_filial.of_Inicializa()
			End If
	End Choose
	This.accepttext( )
End If
end event

event dw_1::clicked;call super::clicked;Choose Case dwo.name
	Case "bt_chave"
		Parent.wf_importar_planilha_chave_acesso()
	Case "bt_limpar"
		ivs_Chaves_acesso = ""
		dw_1.object.de_chaves[1] = ""
	Case Else
		//
End Choose
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge606_baixa_xml_nfe
integer x = 2295
integer y = 624
integer weight = 700
string text = "&Baixar"
boolean default = false
end type

event cb_ok::clicked;call super::clicked;Parent.wf_baixa_xml_nfe()
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge606_baixa_xml_nfe
integer x = 2642
integer y = 624
boolean cancel = false
end type

event cb_cancelar::clicked;call super::clicked;Close(w_ge606_baixa_xml_nfe)
end event

type dw_2 from datawindow within w_ge606_baixa_xml_nfe
integer x = 46
integer y = 792
integer width = 4649
integer height = 1108
integer taborder = 60
boolean bringtotop = true
string dataobject = "dw_ge606_lista"
boolean hscrollbar = true
boolean vscrollbar = true
boolean border = false
boolean livescroll = true
end type

event constructor;//Habilitar a op$$HEX2$$e700e300$$ENDHEX$$o de salvar em planilha
//dw_2.ivo_Controle_Menu.of_SalvarComo(True) [pos open)

//Parent.ivm_Menu.mf_SalvarComo(True)
end event

type gb_2 from groupbox within w_ge606_baixa_xml_nfe
integer x = 23
integer y = 716
integer width = 4709
integer height = 1208
integer taborder = 50
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = " Diverg$$HEX1$$ea00$$ENDHEX$$ncias"
borderstyle borderstyle = styleraised!
end type

type st_1 from statictext within w_ge606_baixa_xml_nfe
integer x = 87
integer y = 636
integer width = 2103
integer height = 68
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "C:\NFe\XML\"
boolean focusrectangle = false
end type

type dw_3 from datawindow within w_ge606_baixa_xml_nfe
event ue_key pbm_dwnkey
integer x = 87
integer y = 68
integer width = 2839
integer height = 528
integer taborder = 50
boolean bringtotop = true
string title = "none"
string dataobject = "dw_ge606_selecao"
boolean border = false
boolean livescroll = true
end type

event ue_key;If Key = KeyEnter! Then
	Choose Case This.GetColumnName() 
			
		Case "nm_filial"
			ivo_filial.of_Localiza_filial(This.GetText())
			
			If ivo_filial.Localizada Then
				 This.Object.cd_filial	[1] = ivo_filial.Cd_Filial
				 This.Object.nm_filial	[1] = ivo_filial.nm_fantasia
			Else 
				ivo_filial.of_Inicializa()
			End If
	End Choose
	This.accepttext( )
End If
end event

event clicked;Choose Case dwo.name
	Case "bt_chave"
		Parent.wf_importar_planilha_chave_acesso()
	Case "bt_limpar"
		ivs_Chaves_acesso = ""
		this.object.de_chaves[1] = ""
	Case Else
		//
End Choose
end event

event itemchanged;Long lvl_Lojas

Choose Case dwo.name
	Case "nm_filial"
		If Trim(Data) <> "" Then
			If Data <> ivo_Filial.nm_Fantasia Then
				Return 1
			End If	
		Else			
			ivo_Filial.Of_inicializa( )
			
			This.Object.Cd_Filial	[1] = ivo_Filial.Cd_Filial
			This.Object.Nm_Filial	[1] = ivo_Filial.Nm_Fantasia			
		End If
		
	Case "id_filial"
		ivs_filiais = "" 
		If Data = 'C' Then
					
			OpenWithParm(w_ge216_selecao_filiais, ivo_filiais)
			
			lvl_Lojas = Message.DoubleParm
			
			If lvl_Lojas > 0 Then
				ivs_filiais = ivo_filiais.ivs_filiais
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma filial foi selecionada.")
				Data = "T"
				This.Object.id_filial [Row] = Data
			End If
			
		End If
End Choose

This.accepttext( )
end event

event losefocus;If IsValid(ivo_Filial) then
	If ivo_Filial.Localizada Then
		This.Object.nm_filial	[1] = ivo_filial.nm_fantasia
	End If
End If
This.accepttext( )
end event

type cb_1 from commandbutton within w_ge606_baixa_xml_nfe
integer x = 3049
integer y = 624
integer width = 910
integer height = 100
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Exportar Lista Diverg$$HEX1$$ea00$$ENDHEX$$ncia (XLS)"
end type

event clicked;String	lvs_Arquivo, &
		lvs_Diretorio, &
		lvs_Extensao,&
		MensagemErro

Integer lvi_Retorno

MensagemErro = ""

lvi_Retorno = GetFileSaveName("Selecione o caminho do arquivo", &
										lvs_Diretorio, 	&
										lvs_Arquivo, 	&
										"XLS", 			&
										"Arquivos Excel (*.XLS),*.XLS,Arquivos Excel Formatado (*.XLS),*.XLSF" 	+ &
										",Arquivos Excel (*.XLSX),*.XLSX,Arquivos CSV (*.CSV),*.CSV"	+ &
										",Arquivos PDF (*.PDF),*.PDF,Arquivos HTML (*.HTML),*.HTML" 		+ &
										",Arquivos Texto (*.TXT),*.TXT")

If lvi_Retorno = -1 Then
	MensagemErro = "Ocorreu um erro durante a chamada da janela de sele$$HEX2$$e700e300$$ENDHEX$$o do arquivo."
	Return 
Else
	If lvi_Retorno = 0 Then Return
End If

lvs_Diretorio = Upper( lvs_Diretorio )
lvs_Diretorio = gf_replace(lvs_Diretorio,'.XLSF','.XLS',0)

// Verifica se j$$HEX1$$e100$$ENDHEX$$ existe o arquivo
If FileExists(lvs_Diretorio) Then
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja substituir o arquivo '" + lvs_Diretorio + "' existente ?", Question!, YesNo!, 1) =  1 Then 
		If Not FileDelete(lvs_Diretorio) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na exclus$$HEX1$$e300$$ENDHEX$$o do arquivo '" + lvs_Diretorio + "'.", StopSign!)
			Return
		End If
	Else
		Return 
	End If   
End If

// Salva o arquivo
lvs_Extensao = gf_replace(Mid(lvs_Arquivo,Len(lvs_Arquivo)-3,4),'.','',0)

lvs_Extensao = Upper( lvs_Extensao )

If (lvs_Extensao = 'XLS') or (lvs_Extensao = 'XLSF') then
	If dw_2.RowCount() > 65000 Then
		If MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!',	'Este relat$$HEX1$$f300$$ENDHEX$$rio excede o limite de 65.000 linhas do formato Excel (XLS).~r~n'+ &
											'O arquivo n$$HEX1$$e300$$ENDHEX$$o poder$$HEX1$$e100$$ENDHEX$$ ser salvo neste formato.~r~n~r~n'+ &
											'Deseja selecionar outro formato?',Question!, YesNo!,1)=1 Then 
			//dw_2.Event ue_SaveAs()
			Return
		Else
			Return
		End If
	End If
End If

Open(w_aguarde_1)
If IsValid(w_aguarde_1) Then w_aguarde_1.Title = 'Aguarde... Salvando...'
Choose Case lvs_Extensao
	Case 'XLS'
		lvi_Retorno = dw_2.SaveAs(lvs_Diretorio, Excel8!, True)
	Case 'XLSX'
		lvi_Retorno = dw_2.SaveAs(lvs_Diretorio, XLSX!, True)
	Case 'CSV'
		//lvi_Retorno = This.SaveAs(lvs_Diretorio, CSV!, True,EncodingUTF8!)
		lvi_Retorno = dw_2.SaveAsFormattedText(lvs_Diretorio, EncodingANSI!, ";")
	Case 'HTML'
		lvi_Retorno = dw_2.SaveAs(lvs_Diretorio, HTMLTable!, True)
	Case 'PDF'
		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tipo PDF n$$HEX1$$e300$$ENDHEX$$o previsto.")
		Return
	Case 'TXT'
		lvi_Retorno = dw_2.SaveAs(lvs_Diretorio, Text!, True,EncodingUTF8!)
	Case 'XLSF'
		If IsValid(w_aguarde_1) Then w_aguarde_1.uo_progress.Of_SetMax(2)
		If dw_2.SaveAs( lvs_Diretorio, HTMLTable!, True ) = 1 Then
			If IsValid(w_aguarde_1) Then w_aguarde_1.uo_progress.Of_SetProgress(1)
			// Converte arquivo HTML para Excel
			OLEObject Excel 
			Excel = Create OLEObject 
			
			If Excel.ConnectToNewObject('Excel.Application') = 0 Then
				Excel.Application.DisplayAlerts = False
				Excel.Application.Workbooks.Open(lvs_Diretorio)
				Excel.Application.Workbooks( 1 ).Parent.Windows( Excel.Application.Workbooks( 1 ).Name ).Visible = True
				Excel.Application.Workbooks( 1 ).SaveAs(lvs_Diretorio, 56 ) 
				Excel.Application.Workbooks( 1 ).Close()
				Excel.DisconnectObject()
			
				Destroy(Excel)
				lvi_Retorno = 1
			Else
				Destroy(Excel)
				lvi_Retorno = -1
			End If
			If IsValid(w_aguarde_1) Then w_aguarde_1.uo_progress.Of_SetProgress(2)
		Else
			lvi_Retorno = -1
		End If
End Choose
If IsValid(w_aguarde_1) Then Close(w_aguarde_1)

If lvi_Retorno <> 1 Then
	MensagemErro = "Erro ao salvar o arquivo '" + lvs_Diretorio + "'."
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", MensagemErro, StopSign!)	
	Return 
Else
	MensagemErro = ""
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Arquivo '" + lvs_Diretorio + "' salvo com sucesso.", Information!)
End If
end event

