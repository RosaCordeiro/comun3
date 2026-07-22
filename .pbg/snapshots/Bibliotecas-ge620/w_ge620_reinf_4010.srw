HA$PBExportHeader$w_ge620_reinf_4010.srw
forward
global type w_ge620_reinf_4010 from dc_w_response
end type
type cb_exportar from commandbutton within w_ge620_reinf_4010
end type
type cb_fechar from commandbutton within w_ge620_reinf_4010
end type
type dw_1 from dc_uo_dw_base within w_ge620_reinf_4010
end type
type cb_sel_dir from commandbutton within w_ge620_reinf_4010
end type
type gb_1 from groupbox within w_ge620_reinf_4010
end type
end forward

global type w_ge620_reinf_4010 from dc_w_response
integer width = 2149
integer height = 656
string title = "GE620 - Exporta$$HEX2$$e700e300$$ENDHEX$$o REINF R4010"
cb_exportar cb_exportar
cb_fechar cb_fechar
dw_1 dw_1
cb_sel_dir cb_sel_dir
gb_1 gb_1
end type
global w_ge620_reinf_4010 w_ge620_reinf_4010

type variables
String ivs_Dir
String ivs_Ambiente_Sap 
String ivs_Extensao
Integer ivi_Arquivo
Integer ivi_Empresa
Date ivdt_Inicio
Date ivdt_Fim

dc_uo_ds_base ivds_exp_mult

dc_uo_transacao ivtr_Mult_Quimidrol
dc_uo_transacao ivtr_Mult

dc_uo_transacao ivo_trans_mult, uoi_transacao_SYB
end variables

forward prototypes
public function integer wf_abre_arquivo (string ps_arquivo)
public function boolean wf_conecta_banco ()
public function long wf_retorna_empresa_sap (long pl_empresa_mult)
public function long wf_retorna_plano_contas (long pl_empresa_mult)
public function boolean wf_finaliza_arquivo (integer pi_arquivo, string ps_arquivo)
public function boolean wf_finaliza_arquivo (integer pi_arquivo, string ps_arquivo, long pl_carga)
private function boolean wf_exporta_reinf_4010 ()
end prototypes

public function integer wf_abre_arquivo (string ps_arquivo);Integer lvi_Arquivo

If FileExists(ps_Arquivo) Then	
	If Not FileDelete(ps_Arquivo) Then	
		MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na exclus$$HEX1$$e300$$ENDHEX$$o do arquivo: " + ps_Arquivo+". ~r~n A aplica$$HEX2$$e700e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ encerrada!", StopSign!, Ok! )
		Halt Close
	End If			
End If

lvi_Arquivo = FileOpen(ps_Arquivo , LineMode!, Write!, LockWrite!, Replace!, EncodingUTF8!)

If lvi_Arquivo = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na abertura do arquivo: " + ps_Arquivo+". ~r~n A aplica$$HEX2$$e700e300$$ENDHEX$$o ser$$HEX1$$e100$$ENDHEX$$ encerrada!", StopSign!, Ok! )
	Halt Close
End If

Return lvi_Arquivo
end function

public function boolean wf_conecta_banco ();If Not IsValid(w_Aguarde) Then Open(w_Aguarde)

// Conex$$HEX1$$e300$$ENDHEX$$o com o banco Mult
if Not(IsValid(ivtr_Mult)) Then ivtr_Mult = Create dc_uo_transacao
if Not(IsValid(gtr_Mult)) Then gtr_Mult = Create dc_uo_transacao

If Not(gtr_Mult.of_isconnected()) Then
	w_Aguarde.Title = "Conectando ao banco de dados da Mult..."
	gtr_Mult.ivs_DataBase 	= "MULT"
	gtr_Mult.ivs_Usuario 		= "clamprod"
	
	gtr_Mult.DBParm = "CommitOnDisconnect='No',DecimalSeparator='.,',Date=' ''''DD/MM/YYYY'''' '"
	If Not gtr_Mult.of_Connect("CLAMPROD", "EX") Then
		Close(w_Aguarde)
		Return False
	End If
End If

// Conex$$HEX1$$e300$$ENDHEX$$o com o banco Mult
if Not(IsValid(ivtr_Mult_Quimidrol)) Then ivtr_Mult_Quimidrol = Create dc_uo_transacao

If Not(ivtr_Mult_Quimidrol.of_isconnected()) Then
	w_Aguarde.Title = "Conectando ao banco de dados da Mult..."
	ivtr_Mult_Quimidrol.ivs_DataBase 	= "MULT"
	ivtr_Mult_Quimidrol.ivs_Usuario 		= "quimidrol"
	
	ivtr_Mult_Quimidrol.DBParm = "CommitOnDisconnect='No',DecimalSeparator='.,',Date=' ''''DD/MM/YYYY'''' '"
	If Not ivtr_Mult_Quimidrol.of_Connect("QUIMIDROL", "EX") Then
		Close(w_Aguarde)
		Return False
	End If
End If

// Conex$$HEX1$$e300$$ENDHEX$$o com o banco Oracle - RH
if Not(IsValid(gtr_RH)) Then gtr_RH = Create dc_uo_transacao

If Not(gtr_RH.of_isconnected()) Then
	w_Aguarde.Title = "Conectando ao banco de dados do RH ..."
	gtr_RH.ivs_DataBase = "ORACLE_RH"
	
	gtr_RH.DBParm = "CommitOnDisconnect='No',DecimalSeparator='.,',Date=' ''''DD/MM/YYYY'''' '"
	If Not gtr_RH.of_Connect("vetorh_ti", "EX") Then
		Close(w_Aguarde)
		Return False
	End If
End If

If IsValid(w_Aguarde) Then Close(w_Aguarde)
end function

public function long wf_retorna_empresa_sap (long pl_empresa_mult);Choose Case pl_empresa_mult
	Case 1 	//AB
		Return 9900
	Case 2 	//CLAMED
		Return 1000
	Case 21	//NEXT STEP
		Return 9600
	Case 22	//Incor
		Return 9700
	Case 24	//Quimidrol
		Return 9800
	Case 61	//BDTech
		Return 9500
End Choose
end function

public function long wf_retorna_plano_contas (long pl_empresa_mult);Choose Case pl_empresa_mult
	Case 1 
		Return 650
	Case 2 
		Return 688
	Case 21 
		Return 649
	Case 22 
		Return 651
	Case 24 
		Return 422
	Case 61 
		Return 383
	Case Else
		Return 0
End Choose

end function

public function boolean wf_finaliza_arquivo (integer pi_arquivo, string ps_arquivo);Return wf_finaliza_arquivo( pi_arquivo, ps_arquivo, 0)
end function

public function boolean wf_finaliza_arquivo (integer pi_arquivo, string ps_arquivo, long pl_carga);String lvs_Arquivo2		
		
lvs_Arquivo2 = Mid(ps_arquivo,1,Len(ps_arquivo)-4)+'.CSV'	
FileClose(pi_arquivo)

If   FileLength(ps_arquivo) = 0 Then
	FileDelete(ps_arquivo) 
Else	
	If FileExists(lvs_Arquivo2) Then
		FileDelete(lvs_Arquivo2)
	End If
	FileMove(ps_arquivo,lvs_Arquivo2)
End If

If Not IsNull(pl_carga) and (pl_carga > 0) Then
	Update carga_sap set dh_fim = CURRENT_DATE where cd_carga = :pl_carga
	Using ivtr_Mult;
	
	If ivtr_Mult.SQLCode = -1 Then
		ivtr_Mult.Of_RollBack()
		ivtr_Mult.of_msgdberror( "Atualiza$$HEX2$$e700e300$$ENDHEX$$o t$$HEX1$$e900$$ENDHEX$$rmino exporta$$HEX2$$e700e300$$ENDHEX$$o" )
		Return False
	End If
	
	ivtr_Mult.Of_Commit()
End If
		
Return True		
end function

private function boolean wf_exporta_reinf_4010 ();Long 			lvl_Linhas
Long       	lvl_linha
Long 			lvl_row
Integer 		lvi_emp_sap
String 		lvs_Dir
String 		lvs_Arquivo
String 		lvs_find
String 		lvs_retorno

Try
	//Abre tela aguarde
	Open(w_aguarde)
	w_aguarde.Title = "Recuperando informa$$HEX2$$e700f500$$ENDHEX$$es REINF 4010..."

	If Not ivds_exp_mult.Of_ChangeDataObject( "ds_ge620_impostos_retidos") Then Return False
	
	//Altera objeto para a base do Oracle
	ivds_exp_mult.Of_SetTransObject( ivo_trans_mult )
	
	ivs_Ambiente_Sap = 'PRD' 
	lvl_Linhas = ivds_exp_mult.Retrieve(ivi_Empresa, wf_retorna_empresa_sap(ivi_Empresa), ivdt_inicio,  ivdt_fim)  
	
	w_aguarde.Title = "Exportando informa$$HEX2$$e700f500$$ENDHEX$$es REINF 4010..."	
	Yield()
	
	//Diretorio arquivos
	lvs_Arquivo = ivs_Dir+"\CLAMED\REINF_4010_de_" + gf_Replace(String(ivdt_Inicio), "/", "_", 0) + "_ate_" + gf_Replace(String(ivdt_Fim), "/", "_", 0) +"_"+String(Today(), "HHMM") +"."+ivs_Extensao
	If not DirectoryExists(ivs_Dir) Then CreateDirectory(ivs_Dir)
	If not DirectoryExists(ivs_Dir+"\CLAMED") Then CreateDirectory(ivs_Dir+"\CLAMED")

	Choose Case lvl_Linhas
		Case is < 0
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Falha ao recuperar as informa$$HEX2$$e700f500$$ENDHEX$$es de REINF 4010 - " + "ds_ge620_impostos_retidos." , Exclamation!)
			Return False
			
		Case 0
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foram encontrados informa$$HEX2$$e700f500$$ENDHEX$$es  " +" com os par$$HEX1$$e200$$ENDHEX$$metros informados.", Exclamation!)
			Return False
		
		Case Else
			
		//Renomeia arquivo atual, se existir, para um backup
		If FileExists(lvs_Arquivo) Then
			If FileCopy (lvs_Arquivo , lvs_Dir+"\CLAMED\REINF_4010_de_" + gf_Replace(String(ivdt_Inicio), "/", "_", 0) + "_ate_" + gf_Replace(String(ivdt_Fim), "/", "_", 0)+"_BKP_"+"."+ivs_Extensao, True) = 1 Then
				FileDelete(lvs_Arquivo)
			End If
		End if			
	
     	ivds_exp_mult.accepttext()
	  
		//Salva arquivo
		ivds_exp_mult.Of_SaveAs( lvs_Arquivo )
			
	End Choose
	
Catch (RuntimeError lvo_Erro)
	MessageBox("Erro", lvo_Erro.GetMessage(), StopSign!)
	Return False
	
Finally
	If IsValid(ivds_exp_mult) Then ivds_exp_mult.Reset()
	If IsValid(w_aguarde) Then Close(w_aguarde)
End Try

Return True
end function

on w_ge620_reinf_4010.create
int iCurrent
call super::create
this.cb_exportar=create cb_exportar
this.cb_fechar=create cb_fechar
this.dw_1=create dw_1
this.cb_sel_dir=create cb_sel_dir
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_exportar
this.Control[iCurrent+2]=this.cb_fechar
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.cb_sel_dir
this.Control[iCurrent+5]=this.gb_1
end on

on w_ge620_reinf_4010.destroy
call super::destroy
destroy(this.cb_exportar)
destroy(this.cb_fechar)
destroy(this.dw_1)
destroy(this.cb_sel_dir)
destroy(this.gb_1)
end on

event ue_postopen;call super::ue_postopen;Long lvl_linha

DataWindowChild lvdwc_Child

dw_1.Event ue_AddRow()

//Seta conex$$HEX1$$e300$$ENDHEX$$o Mult no DW_1, para capturar as empresas no DDW
If dw_1.Getchild( "cd_empresa", lvdwc_Child) > 0 Then
	lvdwc_Child.SetTrans(ivo_trans_mult)
	lvdwc_Child.Retrieve()
End If


//Carrega configura$$HEX2$$e700f500$$ENDHEX$$es INI
ivs_Dir = ProfileString(gvo_aplicacao.ivs_arquivo_ini,"SAP", "Diretorio_Carga", gvo_aplicacao.ivs_path_arquivos+"\Carga SAP")
ivs_Dir = Upper(gf_replace(ivs_Dir, "\\", "\", 0))
If not DirectoryExists(ivs_Dir) Then CreateDirectory(ivs_Dir)

//Popula dados padr$$HEX1$$e300$$ENDHEX$$o DW_1
ivdt_fim    = gf_Retorna_Ultimo_Dia_Mes (RelativeDate(Today(), -1))
ivdt_inicio = gf_primeiro_dia_mes(ivdt_fim )

dw_1.Object.dt_inicio		[1] = ivdt_inicio
dw_1.Object.dt_fim		[1] = ivdt_fim

dw_1.Object.cd_empresa	[1] = 2
dw_1.Object.nm_diretorio	[1] = ivs_Dir

ivds_exp_mult = Create dc_uo_ds_base
ivds_exp_mult.SetTrans( ivo_trans_mult )


end event

event ue_preopen;call super::ue_preopen;String lvs_Datasource

//Conecta base Mult
ivo_trans_mult = create dc_uo_transacao
lvs_Datasource = IIF(lower(gvo_aplicacao.ivs_datasource)="central", "CLAMPROD", "CLAMTESTE")
if not gf_conecta_banco_mult(ivo_trans_mult, lvs_Datasource) then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel conectar ao banco Mult com o usu$$HEX1$$e100$$ENDHEX$$rio: " + lvs_Datasource, Exclamation!)
	Post Close( This )
end if


//Conex$$HEX1$$e300$$ENDHEX$$o com BD Sybase em producao. Necessario para efetuar os de-para de fornecedor
uoi_transacao_SYB = Create dc_uo_transacao

//Se ja estiver em producao utiliza o SQLCA
If lower(gvo_aplicacao.ivs_database) = "central" then
		uoi_transacao_SYB = SQLCA
	 else
		lvs_Datasource = gvo_aplicacao.ivo_Seguranca.Cd_Sistema + "_" + gvo_aplicacao.of_UserId()
		uoi_transacao_SYB.of_SetDataBase('SYBASE')
		uoi_transacao_SYB.Database = 'SYBASE'
		If Not uoi_transacao_SYB.of_Connect( 'central', lvs_Datasource) Then 
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel conectar ao banco Sybase de produ$$HEX2$$e700e300$$ENDHEX$$o (CENTRAL) com o usu$$HEX1$$e100$$ENDHEX$$rio: " + lvs_Datasource, Exclamation!)
			Post Close( This )
		End If
End If
	
ivb_permite_fechar = False
end event

event close;call super::close;If Isvalid (ivds_exp_mult)  	then Destroy(ivds_exp_mult)

//SYB
uoi_transacao_SYB.of_disconnect( )
Destroy(uoi_transacao_SYB)


Destroy(ivtr_Mult)

end event

type pb_help from dc_w_response`pb_help within w_ge620_reinf_4010
integer x = 0
integer y = 0
end type

type cb_exportar from commandbutton within w_ge620_reinf_4010
integer x = 1257
integer y = 440
integer width = 402
integer height = 92
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Exportar"
end type

event clicked;dw_1.AcceptText( )

Long lvl_Empresa
Date lvdt_Posicao


ivi_Empresa		= dw_1.Object.cd_empresa		[1]
ivdt_inicio		= dw_1.Object.dt_inicio			[1]
ivdt_fim			= dw_1.Object.dt_fim				[1]
ivs_Extensao	= dw_1.Object.de_extensao		[1]
ivs_Dir 			= dw_1.Object.nm_diretorio	[1]

If  ivdt_inicio > ivdt_fim Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Data de t$$HEX1$$e900$$ENDHEX$$rmino deve ser maior que a data de in$$HEX1$$ed00$$ENDHEX$$cio.", Information!, Ok!)
	dw_1.SetColumn("dt_fim")
	dw_1.SetFocus()
	Return
End If

If IsNull(ivs_Dir) or Trim(ivs_Dir)="" Then ivs_Dir = gvo_aplicacao.ivs_path_arquivos+"\Carga SAP"
If not DirectoryExists(ivs_Dir) Then CreateDirectory(ivs_Dir)

//Abre tela aguarde
Open(w_Aguarde_2)
w_Aguarde_2.Show()

If IsValid(w_Aguarde_2) Then Close(w_Aguarde_2)

wf_exporta_reinf_4010()
end event

type cb_fechar from commandbutton within w_ge620_reinf_4010
integer x = 1687
integer y = 440
integer width = 402
integer height = 92
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Fechar"
boolean cancel = true
end type

event clicked;Close( Parent )
end event

type dw_1 from dc_uo_dw_base within w_ge620_reinf_4010
integer x = 119
integer y = 108
integer width = 1906
integer height = 276
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge620_selecao_imp_retido"
end type

type cb_sel_dir from commandbutton within w_ge620_reinf_4010
integer x = 1911
integer y = 268
integer width = 101
integer height = 80
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "..."
end type

event clicked;String lvs_Dir

lvs_Dir = ivs_Dir
If GetFolder("Selecione a pasta de grava$$HEX2$$e700e300$$ENDHEX$$o", ref lvs_Dir) = 1 Then
	ivs_Dir = Upper(lvs_Dir)
	dw_1.Object.nm_diretorio [1] = ivs_Dir
End If
end event

type gb_1 from groupbox within w_ge620_reinf_4010
integer x = 87
integer y = 12
integer width = 2007
integer height = 404
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
end type

