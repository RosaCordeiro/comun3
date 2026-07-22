HA$PBExportHeader$w_ge147_gera_arquivo_edi.srw
forward
global type w_ge147_gera_arquivo_edi from dc_w_response
end type
type gb_2 from groupbox within w_ge147_gera_arquivo_edi
end type
type gb_1 from groupbox within w_ge147_gera_arquivo_edi
end type
type dw_1 from dc_uo_dw_base within w_ge147_gera_arquivo_edi
end type
type dw_2 from dc_uo_dw_base within w_ge147_gera_arquivo_edi
end type
type cb_confirma from commandbutton within w_ge147_gera_arquivo_edi
end type
type cb_cancela from commandbutton within w_ge147_gera_arquivo_edi
end type
type cb_atualizar from commandbutton within w_ge147_gera_arquivo_edi
end type
type cb_envia_ftp from commandbutton within w_ge147_gera_arquivo_edi
end type
end forward

global type w_ge147_gera_arquivo_edi from dc_w_response
integer width = 3383
integer height = 1768
string title = "GE147 - Gera o Arquivo EDI"
long backcolor = 80269524
gb_2 gb_2
gb_1 gb_1
dw_1 dw_1
dw_2 dw_2
cb_confirma cb_confirma
cb_cancela cb_cancela
cb_atualizar cb_atualizar
cb_envia_ftp cb_envia_ftp
end type
global w_ge147_gera_arquivo_edi w_ge147_gera_arquivo_edi

type variables
uo_pedido_central_edi ivo_pedido_edi

uo_Fornecedor io_fornecedor

String ivs_cgc_envio
String ivs_nome_arquivo

String is_Id_Utiliza_Ftp
String is_Id_Utiliza_SFtp
String is_De_Endereco_Ftp
String is_De_Usuario_Ftp
String is_De_Senha_Ftp
String is_De_Diretorio_Envio
String is_De_Porta


String is_OPENTEXTSFTP = "C:\Sistemas\Co\Arquivos\OPENTEXTSFTP\"
end variables

forward prototypes
public function boolean wf_verifica_pedido_selecionado ()
public function boolean wf_envia_ftp (string ps_path, string ps_arquivo_ftp)
public function boolean wf_carrega_parametros (string ps_id_pedido_edi, ref string ps_id_layout_edi)
end prototypes

public function boolean wf_verifica_pedido_selecionado ();Long lvl_Find,&
	 lvl_Pedido,&
	 lvl_Linhas,&
	 lvl_Contador,&
	 lvl_Linha

DateTime lvdh_Envio

String ls_Gerar

dw_2.AcceptText()

lvl_Find = dw_2.Find("id_gerar = 'S'", 1, dw_2.RowCount())
	
If lvl_Find = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o pedido.")
	Return False
End If
	
If lvl_Find = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Pelo menos um pedido deve ser selecionado.")
	Return False
Else

lvl_Contador = 0

For lvl_Linha = 1 To dw_2.RowCount()
	
	If dw_2.Object.Id_Gerar[lvl_Linha] = "S" Then
		lvl_Contador ++
	End If
	
Next

If lvl_Contador > 1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "$$HEX1$$c900$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel selecionar somente um pedido por vez.", Exclamation!)
	Return False
End If

	lvdh_Envio 	= dw_2.Object.dh_envio_edi	[lvl_Find]
	lvl_Pedido	= dw_2.Object.nr_pedido		[lvl_Find]
	
	If Not IsNull(lvdh_Envio) Then
		
		If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O pedido '" + String(lvl_Pedido) + &
				   "' j$$HEX1$$e100$$ENDHEX$$ foi enviado em '" + String(lvdh_Envio, "dd/mm/yyyy hh:mm") + "'.~r~r" +&
				   "Deseja gerar novamente ?", Question!, YesNo!, 2) = 2 Then
			Return False
		End If
	End If
End If

Return True
end function

public function boolean wf_envia_ftp (string ps_path, string ps_arquivo_ftp);String lvs_Msg
String lvs_Server	= "162.44.221.132"
String lvs_User	= "Clamed"
String lvs_Pass	= "Ung390"
String ls_Dir_Ftp = "Entrada"

Boolean lvb_Sucesso = True

Open( w_Aguarde )

w_Aguarde.Title = "Enviando arquivo, aguarde..."

dc_uo_ftp lvo_ftp
lvo_ftp = create dc_uo_ftp

If Not lvo_Ftp.of_Conecta_Ftp('RO', lvs_Server, lvs_User, lvs_Pass, Ref lvs_Msg) Then		
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na conex$$HEX1$$e300$$ENDHEX$$o com o servidor '" + lvs_Server + "'. Tente novamente em alguns minutos.~r" + &
								 "        Se o problema persistir, entre em contato com o setor de inform$$HEX1$$e100$$ENDHEX$$tica.", StopSign!)									 
	lvb_Sucesso = False
End If

If lvo_ftp.of_ftp_Set_Dir(ls_Dir_Ftp) = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao mudar para o diretorio '" + ls_Dir_Ftp + "' FTP.")
	lvb_Sucesso = False
End If

If lvb_Sucesso Then
	If Not lvo_ftp.of_ftp_PutFile(ps_path, ps_arquivo_ftp, Ref lvs_Msg, False ) Then
		lvb_Sucesso = False
	End If		
End If

Destroy(lvo_ftp)

Close( w_Aguarde )

If lvb_Sucesso Then
	MessageBox("Envio de Arquivo", "Arquivo '" + ps_path + "' enviado com sucesso!")
End If

Return lvb_Sucesso
end function

public function boolean wf_carrega_parametros (string ps_id_pedido_edi, ref string ps_id_layout_edi);Select	id_pedido_edi_layout,
		id_utiliza_ftp,
		de_endereco_ftp,
		de_usuario_ftp,
		de_senha_ftp,
		de_diretorio_envio,
		'22' as de_porta
Into	:ps_id_layout_edi,
		:is_Id_Utiliza_Ftp,
		:is_De_Endereco_Ftp,
		:is_De_Usuario_Ftp,
		:is_De_Senha_Ftp,
		:is_De_Diretorio_Envio,
		:is_De_Porta
From parametro_pedido_edi
Where id_pedido_edi = :ps_id_pedido_edi
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		Return True
		
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foram localizados os par$$HEX1$$e200$$ENDHEX$$metros de conex$$HEX1$$e300$$ENDHEX$$o FTP. Fun$$HEX2$$e700e300$$ENDHEX$$o wf_carrega_parametros.", Exclamation!)
		
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na localiza$$HEX2$$e700e300$$ENDHEX$$o dos par$$HEX1$$e200$$ENDHEX$$metros de conex$$HEX1$$e300$$ENDHEX$$o FTP. Fun$$HEX2$$e700e300$$ENDHEX$$o wf_carrega_parametros." + SqlCa.SqlErrText, StopSign!)
		
End Choose



Return False
end function

on w_ge147_gera_arquivo_edi.create
int iCurrent
call super::create
this.gb_2=create gb_2
this.gb_1=create gb_1
this.dw_1=create dw_1
this.dw_2=create dw_2
this.cb_confirma=create cb_confirma
this.cb_cancela=create cb_cancela
this.cb_atualizar=create cb_atualizar
this.cb_envia_ftp=create cb_envia_ftp
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_2
this.Control[iCurrent+2]=this.gb_1
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.dw_2
this.Control[iCurrent+5]=this.cb_confirma
this.Control[iCurrent+6]=this.cb_cancela
this.Control[iCurrent+7]=this.cb_atualizar
this.Control[iCurrent+8]=this.cb_envia_ftp
end on

on w_ge147_gera_arquivo_edi.destroy
call super::destroy
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.dw_2)
destroy(this.cb_confirma)
destroy(this.cb_cancela)
destroy(this.cb_atualizar)
destroy(this.cb_envia_ftp)
end on

event ue_postopen;call super::ue_postopen;dw_1.Event ue_AddRow()
dw_1.SetFocus()

dw_1.Object.dt_inicio	[1] = Date(gvo_Parametro.of_Dh_Movimentacao())
dw_1.Object.dt_termino	[1] = Date(gvo_Parametro.of_Dh_Movimentacao())

ivo_Pedido_EDI 	= Create uo_Pedido_Central_EDI

io_fornecedor		= Create uo_Fornecedor
end event

event close;call super::close;Destroy ivo_Pedido_EDI
Destroy io_fornecedor
end event

type pb_help from dc_w_response`pb_help within w_ge147_gera_arquivo_edi
end type

type gb_2 from groupbox within w_ge147_gera_arquivo_edi
integer x = 23
integer y = 316
integer width = 3296
integer height = 1224
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 80269524
string text = "Pedido Colocados"
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within w_ge147_gera_arquivo_edi
integer x = 27
integer y = 8
integer width = 1522
integer height = 296
integer taborder = 10
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
borderstyle borderstyle = styleraised!
end type

type dw_1 from dc_uo_dw_base within w_ge147_gera_arquivo_edi
integer x = 46
integer y = 80
integer width = 1486
integer height = 208
integer taborder = 60
boolean bringtotop = true
string dataobject = "dw_ge147_selecao_pedido_edi"
end type

event constructor;call super::constructor;This.of_SetColSelection(True)
end event

event itemchanged;call super::itemchanged;dw_2.Reset()

If dwo.Name = "cd_fornecedor" Then
	cb_atualizar.Event clicked()
End If
end event

type dw_2 from dc_uo_dw_base within w_ge147_gera_arquivo_edi
integer x = 59
integer y = 400
integer width = 3232
integer height = 1108
integer taborder = 30
boolean bringtotop = true
string dataobject = "dw_ge147_lista_pedido_edi"
boolean vscrollbar = true
end type

event ue_postretrieve;call super::ue_postretrieve;Long lvl_Linha

If pl_Linhas > 0 Then
	cb_confirma.Enabled = True
	
	For lvl_Linha = 1 To pl_Linhas
		dw_2.Object.nr_cgc_envio		[lvl_Linha] = ivs_cgc_envio
	Next
	
Else
	cb_confirma.Enabled = False
	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.")
End If

Return  pl_Linhas
end event

event ue_recuperar;Date	lvdt_Inicio,&
	 	lvdt_Termino
	 
String lvs_Fornecedor
String lvs_CGC
	 
dw_1.AcceptText()

lvdt_Inicio 		= dw_1.Object.dt_inicio			[1]
lvdt_Termino 	= dw_1.Object.dt_termino		[1]
lvs_Fornecedor	= dw_1.Object.cd_fornecedor	[1]

io_fornecedor.of_Localiza_Codigo(lvs_Fornecedor)

If Not io_fornecedor.Localizado Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "C$$HEX1$$f300$$ENDHEX$$digo do fornecedor n$$HEX1$$e300$$ENDHEX$$o localizado.")
	dw_1.Event ue_Pos(1, "cd_fornecedor")
	Return -1
End If

ivs_cgc_envio 		= io_fornecedor.nr_cgc
ivs_nome_arquivo	= io_fornecedor.nm_Fantasia

If ivs_cgc_envio = '03560974000975' Then ivs_cgc_envio = '03560974000118'

This.of_AppendWhere("f.cd_fornecedor = '" + lvs_Fornecedor + "'")

Return This.Retrieve(lvdt_Inicio, lvdt_Termino)
end event

event constructor;call super::constructor;This.of_SetRowSelection()
end event

type cb_confirma from commandbutton within w_ge147_gera_arquivo_edi
integer x = 2601
integer y = 1556
integer width = 343
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "&Confirma"
end type

event clicked;Boolean lvb_Sucesso = False, lvb_IMS

Integer lvi_Arquivo,&
		lvi_Contador

Long lvl_Linha,&
	 lvl_Linhas,&
	 lvl_Pedido,&
	 lvl_Find,&
	 lvl_Sequencial
	 
String	lvs_Tipo_Pedido,&
	   	lvs_CGC_Fornecedor,&
		lvs_PBM	
		
String lvs_Path
String lvs_Arquivo
String ls_ID_EDI
String ls_Erro
String ls_EDI_Layout
String ls_De_Van
 
lvl_Linhas = dw_2.RowCount()

If lvl_Linhas > 0 Then
	
	ls_ID_EDI	= dw_2.Object.id_pedido_edi	[1]
	ls_De_Van	= dw_2.Object.De_Pedido_Edi	[1]
		
	lvi_Contador = 0
	
	// NEOGRID OU ENTIRE utilizam layout TIVIT
//	If ls_ID_EDI = 'N' or ls_ID_EDI = 'E' Then
//		ls_EDI_Layout = 'T'
//	Else
//		ls_EDI_Layout = ls_ID_EDI
//	End If
	
	If Not wf_Carrega_Parametros(ls_ID_EDI, Ref ls_EDI_Layout) Then
		Return -1
	End If
	
	// Verifica se o existe algum pedido selecionado
	If Not wf_Verifica_Pedido_Selecionado() Then Return
	
	// Abre o arquivo
	If Not ivo_Pedido_EDI.of_Abre_Arquivo( Ref lvi_Arquivo, Ref lvl_Sequencial, Ref lvs_Path, Ref lvs_Arquivo, ivs_nome_arquivo, ls_ID_EDI, ls_De_Van, ivs_cgc_envio) Then Return
	
	For lvl_Linha = 1 To lvl_Linhas
		
		If dw_2.Object.id_gerar[lvl_Linha] = 'N' Then Continue
			
		lvi_Contador ++
		lvb_Sucesso 				= False
		ls_Erro						= ""
		lvl_Pedido 					= dw_2.Object.nr_pedido		[lvl_Linha]
		lvs_CGC_Fornecedor		= dw_2.Object.nr_cgc_envio	[lvl_Linha]
		lvs_PBM						= dw_2.Object.id_pbm			[lvl_Linha]
		
		// S$$HEX1$$f300$$ENDHEX$$ ira funcionar para a ASTRAZENECA
		If lvs_CGC_Fornecedor <> '60318797000100' Then
			lvs_PBM = 'N'
		End If
		
		// Grava o registro cabe$$HEX1$$e700$$ENDHEX$$alho
		If lvi_Contador = 1 Then
			If Not ivo_Pedido_EDI.of_Gera_Registro_Cabecalho( lvi_Arquivo, ls_EDI_Layout, lvl_Pedido, lvs_PBM, lvl_Sequencial, lvs_CGC_Fornecedor, Ref ls_Erro ) Then
				lvb_Sucesso = False
				Exit
			End If
		End If

		If ivo_Pedido_EDI.of_gera_registro_cabecalho_pedido(lvi_Arquivo, ls_EDI_Layout, lvl_Pedido, lvs_PBM, Ref lvs_Tipo_Pedido, Ref ls_Erro ) Then
			If ivo_Pedido_EDI.of_Gera_Registro_Condicao(lvi_Arquivo, ls_EDI_Layout, lvl_Pedido, lvs_Tipo_Pedido, Ref ls_Erro ) Then 
				If ivo_Pedido_EDI.of_Gera_Registro_Produto(lvi_Arquivo, ls_EDI_Layout, lvl_Pedido, Ref ls_Erro ) Then
					If ivo_Pedido_EDI.of_Atualiza_Data_Envio(lvl_Pedido) Then
						lvb_Sucesso = True
					End If
				End If
			End If
		End If
				 	
		If Not lvb_Sucesso Then Exit
			
	Next
	
	// EDI BAYER OpenText - Registro Finalizador
	If lvb_Sucesso And ls_ID_EDI = 'O' Then
		If Not ivo_Pedido_EDI.of_Layout_Bayer_Finalizador( lvi_Arquivo, Ref ls_Erro ) Then lvb_Sucesso = False
	End If
	
	If lvb_Sucesso Then
		If Not ivo_Pedido_EDI.of_Atualiza_Ultimo_Sequencial(lvl_Sequencial, ls_ID_EDI) Then
			lvb_Sucesso = True
		End If
	End If

	FileClose(lvi_Arquivo)

	If lvb_Sucesso Then
		SqlCa.of_Commit();
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O arquivo de pedido EDI '" + lvs_Path + "' foi gerado com sucesso.")		
		dw_2.Event ue_Retrieve()
	Else
		SqlCa.of_RollBack();
		
		If Not IsNull(ls_Erro) And ls_Erro <> "" Then MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", ls_Erro )
		
		// Se der algum erro durante a gera$$HEX2$$e700e300$$ENDHEX$$o do arquivo o sistema vai excluir o arquivo
		FileDelete( lvs_Path )
	End If
	
End If
end event

type cb_cancela from commandbutton within w_ge147_gera_arquivo_edi
integer x = 2981
integer y = 1556
integer width = 343
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "C&ancela"
end type

event clicked;Close(Parent)
end event

type cb_atualizar from commandbutton within w_ge147_gera_arquivo_edi
integer x = 27
integer y = 1556
integer width = 343
integer height = 100
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Atualiza&r"
end type

event clicked;Date	lvdt_Inicio
Date 	lvdt_Termino
	 
String lvs_Fornecedor
String lvs_CGC
	 
dw_1.AcceptText()

lvdt_Inicio 			= dw_1.Object.dt_inicio			[1]
lvdt_Termino 		= dw_1.Object.dt_termino		[1]
lvs_Fornecedor		= dw_1.Object.cd_fornecedor	[1]

If Isnull(lvdt_Inicio) Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio corretamente.")
	dw_1.Event ue_Pos(1, "dt_inicio")
	Return
End If

If Isnull(lvdt_Termino) Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino corretamente.")
	dw_1.Event ue_Pos(1, "dt_termino")
	Return
End If

If lvdt_Inicio > lvdt_Termino Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que a data de t$$HEX1$$e900$$ENDHEX$$rmino.", Exclamation!)
	dw_1.Event ue_Pos(1, "dt_inicio")
	Return
End If

If Isnull(lvs_Fornecedor) Then
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o fornecedor.")
	dw_1.Event ue_Pos(1, "cd_fornecedor")
	Return
End If

dw_2.Event ue_Retrieve()
end event

type cb_envia_ftp from commandbutton within w_ge147_gera_arquivo_edi
integer x = 498
integer y = 1556
integer width = 585
integer height = 100
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Enviar Arquivo FTP"
end type

event clicked;String ls_Id_Edi
String ls_De_Van
String ls_Layout
String ls_sftp
String ls_de_edi


dw_2.AcceptText()

If dw_2.RowCount() > 0 Then
	
	ls_Id_Edi		= dw_2.Object.Id_Pedido_Edi	[1]
	ls_De_Van	= dw_2.Object.De_Pedido_Edi	[1]
	ls_sftp		= String(dw_2.Object.usa_sftp	[1])
	ls_de_edi	= dw_2.Object.de_pedido_edi	[1]
	
	
	If Not wf_Carrega_Parametros(ls_Id_Edi, Ref ls_Layout) Then
		Return -1
	End If
	
	If is_Id_Utiliza_Ftp = 'N' Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A Van selecionada n$$HEX1$$e300$$ENDHEX$$o utiliza FTP para a transmiss$$HEX1$$e300$$ENDHEX$$o de arquivos.")
		Return -1
	End If

	st_parametros_conexao str
	
	str.de_van 							= ls_De_Van
	str.de_endereco					= is_De_Endereco_Ftp
	str.de_usuario						= is_De_Usuario_Ftp
	str.de_senha						= is_De_Senha_Ftp
	str.de_diretorio_ftp				= is_De_Diretorio_Envio
	str.de_diretorio_local				= 'C:\' + ls_De_Van + '\'
	str.de_diretorio_local_backup	= 'C:\' + ls_De_Van + '\BKP'
	str.usa_sftp							= ls_sftp
	str.de_porta							= is_De_Porta
	str.de_edi							= ls_de_edi
	
	//  Especifico para Uso OpenText-Nestle
	If ls_sftp  = '1'  Then 
		str.de_diretorio_local				=  is_OPENTEXTSFTP   
		str.de_diretorio_local_backup	=  str.de_diretorio_local	+ 'BKP'
	End If 	
		
	OpenWithParm(w_ge147_envia_ftp, str)
	
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum pedido foi selecionado.")
	Return -1
End If
end event

