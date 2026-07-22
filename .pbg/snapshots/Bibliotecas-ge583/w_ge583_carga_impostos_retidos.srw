HA$PBExportHeader$w_ge583_carga_impostos_retidos.srw
forward
global type w_ge583_carga_impostos_retidos from dc_w_response
end type
type cb_exportar from commandbutton within w_ge583_carga_impostos_retidos
end type
type cb_fechar from commandbutton within w_ge583_carga_impostos_retidos
end type
type dw_1 from dc_uo_dw_base within w_ge583_carga_impostos_retidos
end type
type cb_sel_dir from commandbutton within w_ge583_carga_impostos_retidos
end type
type dw_log from dc_uo_dw_base within w_ge583_carga_impostos_retidos
end type
type gb_1 from groupbox within w_ge583_carga_impostos_retidos
end type
end forward

global type w_ge583_carga_impostos_retidos from dc_w_response
integer width = 2149
integer height = 664
string title = "GE583 - Exporta$$HEX2$$e700e300$$ENDHEX$$o Impostos Retidos"
cb_exportar cb_exportar
cb_fechar cb_fechar
dw_1 dw_1
cb_sel_dir cb_sel_dir
dw_log dw_log
gb_1 gb_1
end type
global w_ge583_carga_impostos_retidos w_ge583_carga_impostos_retidos

type variables
String ivs_Dir
String ivs_Ambiente_Sap 
String ivs_Extensao
Integer ivi_Arquivo
Integer ivi_Empresa
Date ivdt_Corte_Forn
Date ivdt_Corte_Cliente
Date ivdt_Inicio_Contrato
Date ivdt_Inicio
Date ivdt_Fim

dc_uo_ds_base ivds_exp_mult, ivds_de_para

dc_uo_transacao ivtr_Mult_Quimidrol
dc_uo_transacao ivtr_Mult

dc_uo_transacao ivo_trans_mult, uoi_transacao_SYB
end variables

forward prototypes
public function integer wf_abre_arquivo (string ps_arquivo)
public function boolean wf_conecta_banco ()
public function long wf_retorna_empresa_sap (long pl_empresa_mult)
public function long wf_retorna_plano_contas (long pl_empresa_mult)
public function boolean wf_grava_validacao (string ps_log, string ps_filial, string ps_empresa)
public function string wf_retorna_data_formatada (date pdt_data)
public function string wf_retorna_texto_formatado (string ps_texto)
public function string wf_retorna_decimal_formatado (decimal pdc_decimal)
public function string wf_retorna_telefone_formatado (string ps_ddd, string ps_telefone, ref string ps_tipo, boolean pb_retorna_invalido)
public function boolean wf_valida_contrato ()
public function string wf_retorna_rua_formatada (string ps_rua)
public function boolean wf_finaliza_arquivo (integer pi_arquivo, string ps_arquivo)
public function boolean wf_finaliza_arquivo (integer pi_arquivo, string ps_arquivo, long pl_carga)
public function boolean wf_leitura_planilha (string as_arquivo, integer ai_tipo)
public subroutine wf_atualiza_dados_carga (integer ai_tipo)
public function string wf_retorna_texto_formatado_mat (string ps_texto)
private function boolean wf_exporta_contratos_imposto_retido ()
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

public function boolean wf_grava_validacao (string ps_log, string ps_filial, string ps_empresa);Long lvl_Linha

lvl_Linha = dw_log.InsertRow(0)
dw_log.Object.de_log			[lvl_Linha] = Upper(ps_log)
dw_log.Object.nm_filial		[lvl_Linha] = Upper(ps_filial)
dw_log.Object.nm_empresa	[lvl_Linha] = Upper(ps_empresa)

Return True
end function

public function string wf_retorna_data_formatada (date pdt_data);String lvs_Retorno

If pdt_data > Date("01/01/1900") Then
	lvs_Retorno = String(pdt_data, "DD.MM.YYYY")
Else
	lvs_Retorno = ""
End If

Return lvs_Retorno
end function

public function string wf_retorna_texto_formatado (string ps_texto);If IsNull(ps_texto) Then ps_texto = ""
ps_texto = gf_replace(ps_texto, ";", ",", 0)
ps_texto = gf_replace(ps_texto, "`", "", 0)
ps_texto = gf_replace(ps_texto, "$$HEX1$$b400$$ENDHEX$$", "", 0)
ps_texto = gf_replace(ps_texto, "'", "", 0)
ps_texto = gf_replace(ps_texto, "-", " ", 0)
ps_texto = gf_replace(ps_texto, "/", " ", 0)
ps_texto = gf_replace(ps_texto, "\", " ", 0)
ps_texto = gf_replace(ps_texto, "    ", " ", 0)
ps_texto = gf_replace(ps_texto, "   ", " ", 0)
ps_texto = gf_replace(ps_texto, "  ", " ", 0)
ps_texto = gf_replace(ps_texto, "~r~n", " ", 0)
ps_texto = gf_replace(ps_texto, "~n", " ", 0)
ps_texto = gf_replace(ps_texto, "~t", " ", 0)
ps_texto = gf_retira_acentos(ps_texto)

Return Upper(Trim(ps_texto))
end function

public function string wf_retorna_decimal_formatado (decimal pdc_decimal);Return gf_replace(String(pdc_decimal, "###0.00"), ",", ".", 0)
end function

public function string wf_retorna_telefone_formatado (string ps_ddd, string ps_telefone, ref string ps_tipo, boolean pb_retorna_invalido);String lvs_Retorno
String lvs_Tipo
String lvs_Telefone
String lvs_DDD

ps_tipo = ""

lvs_DDD		= ps_ddd
lvs_Telefone= ps_telefone

//Caso hajam telefones separados por barras, ser$$HEX1$$e100$$ENDHEX$$ levado apenas o primeiro
If Pos(ps_telefone, "/") > 7 Then 
	lvs_Telefone = Mid(lvs_Telefone, 1, Pos(lvs_Telefone, "/"))
End If

lvs_DDD		= gf_retorna_so_numeros(lvs_DDD)
lvs_Telefone= gf_retorna_so_numeros(lvs_Telefone)

If IsNull(lvs_Telefone) or Trim(lvs_Telefone)="" or longlong(lvs_Telefone)=0 Then Return ""
If IsNull(lvs_DDD) Then lvs_DDD = ""

If Mid(lvs_Telefone, 1, 4) = "0800" and (len(lvs_Telefone)=10 or len(lvs_Telefone)=11) Then 
	lvs_Retorno = lvs_Telefone
	ps_tipo = "CENTRAL 0800"
Else
	ps_tipo = "TELEFONE"
	If Mid(lvs_Telefone, 1, 1) = "0" Then lvs_Telefone = Mid(lvs_Telefone, 2)
	
	If Trim(lvs_DDD) = "" then 
		If ((Len(lvs_Telefone) > 9) and (Long(Mid(lvs_Telefone, 1, 1)) > 4)) or &
			((Len(lvs_Telefone) > 8) and (Long(Mid(lvs_Telefone, 1, 1)) <= 4)) Then
			lvs_DDD = Mid(Trim(lvs_Telefone), 1, 2)
			lvs_Telefone = Trim(Mid(lvs_Telefone, 3))
		End If
	End If
	
	//Telefone
	If ((Len(lvs_Telefone) = 7 or Len(lvs_Telefone) = 8)) and (Long(Mid(lvs_Telefone, 1, 1)) <= 4) Then 
		//Falta 1 d$$HEX1$$ed00$$ENDHEX$$gito
		If Len(lvs_Telefone) = 7 Then lvs_Telefone = "3"+lvs_Telefone
			
		lvs_Retorno = Trim(lvs_DDD + " " + lvs_Telefone)
		
	//Celular
	ElseIf ((Len(lvs_Telefone) >= 8 or Len(lvs_Telefone) >= 9)) and (Long(Mid(lvs_Telefone, 1, 1)) > 4) Then 
		ps_tipo = "CELULAR"
		If Len(lvs_Telefone) = 8 Then lvs_Telefone = "9"+lvs_Telefone	
			
		lvs_Retorno = Trim(lvs_DDD + " " + lvs_Telefone)
	Else
		If pb_retorna_invalido Then
			lvs_Retorno = Trim(ps_ddd+" "+ps_telefone)
		Else
			lvs_Retorno = ""			
		End If
	End If
End If

Return lvs_Retorno
end function

public function boolean wf_valida_contrato ();Return True
end function

public function string wf_retorna_rua_formatada (string ps_rua);String lvs_Rua

lvs_Rua = Upper(Trim(ps_rua))
If IsNull(lvs_Rua) Then lvs_Rua = ""

If IsNull(lvs_Rua) or Trim(lvs_Rua) = "" Then lvs_Rua = 'RUA'
If Trim(lvs_Rua) = "-" Then lvs_Rua = 'RUA'

If Mid(lvs_Rua, Len(lvs_Rua) - 4) = " S/N$$HEX1$$ba00$$ENDHEX$$" Then lvs_Rua = Mid(lvs_Rua, 1, Len(lvs_Rua) - 4)
If Mid(lvs_Rua, Len(lvs_Rua) - 4) = ",S/N$$HEX1$$ba00$$ENDHEX$$" Then lvs_Rua = Mid(lvs_Rua, 1, Len(lvs_Rua) - 4)
If Mid(lvs_Rua, Len(lvs_Rua) - 3) = " S/N" Then lvs_Rua = Mid(lvs_Rua, 1, Len(lvs_Rua) - 3)
If Mid(lvs_Rua, Len(lvs_Rua) - 3) = ",S/N" Then lvs_Rua = Mid(lvs_Rua, 1, Len(lvs_Rua) - 3)
If Mid(lvs_Rua, Len(lvs_Rua) - 2) = " SN" Then lvs_Rua = Mid(lvs_Rua, 1, Len(lvs_Rua) - 2)
If Mid(lvs_Rua, Len(lvs_Rua) - 2) = " N$$HEX1$$ba00$$ENDHEX$$" Then lvs_Rua = Mid(lvs_Rua, 1, Len(lvs_Rua) - 2)
If Mid(lvs_Rua, Len(lvs_Rua) - 2) = ",N$$HEX1$$ba00$$ENDHEX$$" Then lvs_Rua = Mid(lvs_Rua, 1, Len(lvs_Rua) - 2)
If Mid(lvs_Rua, Len(lvs_Rua) - 2) = " NR" Then lvs_Rua = Mid(lvs_Rua, 1, Len(lvs_Rua) - 2)
If Mid(lvs_Rua, Len(lvs_Rua) - 2) = ",NR" Then lvs_Rua = Mid(lvs_Rua, 1, Len(lvs_Rua) - 2)
If Mid(Trim(lvs_Rua), Len(Trim(lvs_Rua))) = "-" Then lvs_Rua = Mid(lvs_Rua, 1, Len(lvs_Rua) - 1)
If Mid(Trim(lvs_Rua), Len(Trim(lvs_Rua))) = "," Then lvs_Rua = Mid(lvs_Rua, 1, Len(lvs_Rua) - 1)
If Mid(lvs_Rua, 1, 2) = "R " Then lvs_Rua = 'RUA '+Trim(Mid(lvs_Rua, 3))
If Mid(lvs_Rua, 1, 2) = "R." Then lvs_Rua = 'RUA '+Trim(Mid(lvs_Rua, 3))
If Mid(lvs_Rua, 1, 2) = "R:" Then lvs_Rua = 'RUA '+Trim(Mid(lvs_Rua, 3))
If Mid(lvs_Rua, 1, 3) = "R.:" Then lvs_Rua = 'RUA '+Trim(Mid(lvs_Rua, 4))
If Mid(lvs_Rua, 1, 4) = "RUA:" Then lvs_Rua = 'RUA '+Trim(Mid(lvs_Rua, 5))
If Mid(lvs_Rua, 1, 5) = "RUA.:" Then lvs_Rua = 'RUA '+Trim(Mid(lvs_Rua, 6))

Return wf_retorna_texto_formatado(lvs_Rua)
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

public function boolean wf_leitura_planilha (string as_arquivo, integer ai_tipo);Boolean lb_Sucesso = True

Any la_Dado

Long ll_Linha
Long ll_Linhas
Long ll_Produto
Long ll_Achou
Long ll_Grupo_Pai

String ls_Valor

Try
	dc_uo_excel lo_Excel
	lo_Excel = Create dc_uo_excel
	
	Open(w_Aguarde)
	w_Aguarde.Title = "Lendo a planilha..."
	
	// Refer$$HEX1$$ea00$$ENDHEX$$ncia o Arquivo 
	If ( lo_Excel.uo_Referencia_Objeto_Excel(as_Arquivo) ) Then
		// Coluna de Refer$$HEX1$$ea00$$ENDHEX$$ncia
		ll_Linhas = lo_Excel.uo_Verifica_Tamanho_Arquivo("A") 
		
		If ll_Linhas > 0 Then
			w_Aguarde.uo_Progress.of_SetMax(ll_Linhas)
					
			For ll_Linha = 1 To ll_Linhas
				
				la_Dado = lo_Excel.uo_Lendo_Dados(ll_Linha, "A")
				If Not IsNumber(String(la_Dado)) Then
					SqlCa.of_RollBack();
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produto inv$$HEX1$$e100$$ENDHEX$$lido na coluna 'A' da linha: " + String(ll_Linha), Exclamation!)
					lb_Sucesso = False
					Return False
				End If
				ll_Produto  = Long(la_Dado)
				
				
				ls_Valor = String(lo_Excel.uo_Lendo_Dados(ll_Linha, "B"))
				If IsNull(ls_Valor) or ls_Valor = '' Then
					SqlCa.of_RollBack();
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Valor NULO ou EM BRANCO na coluna 'B' da linha: " + String(ll_Linha), Exclamation!)
					lb_Sucesso = False
					Return False
				End If
				
				// E o valor vier #N/D o valor da c$$HEX1$$e900$$ENDHEX$$lula vem negativo
				If longlong(ls_Valor) < 0 Then ls_Valor = ''
				
				If ai_tipo = 5 Then
					ll_Grupo_Pai = Long(ls_Valor)
				End If
				
				// Segmento IMS
				If ai_tipo = 4 Then
					If ls_Valor = 'MIP MARCA' Then ls_Valor= 'MIM'
					If ls_Valor = 'MIP GENERICO' Then ls_Valor= 'MIG'
					If ls_Valor = 'MIP TRADE' Then ls_Valor= 'MIT'
					
					If ls_Valor = 'RX GENERICO' Then ls_Valor= 'RXG'
					If ls_Valor = 'RX PROMOVIDO' Then ls_Valor= 'RXP'
					If ls_Valor = 'RX TRADE' Then ls_Valor= 'RXT'
				End If
				
				If ai_tipo = 5 Then
					ls_Valor = String(lo_Excel.uo_Lendo_Dados(ll_Linha, "C"))
					If IsNull(ls_Valor) or ls_Valor = '' Then
						SqlCa.of_RollBack();
						MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Valor NULO ou EM BRANCO na coluna 'C' da linha: " + String(ll_Linha), Exclamation!)
						lb_Sucesso = False
						Return False
					End If
				End If
															
//				select ps.cd_produto 
//				Into :ll_Achou
//				from produto_sap ps
//				inner join produto_geral pg
//					on pg.cd_produto = ps.cd_produto
//				where  ps.cd_produto = :ll_Produto
//				Using SqlCa;
//				
//				Choose Case SqlCa.SqlCode 
//					Case 0
						
						Choose Case ai_tipo
							Case 1  // Descri$$HEX2$$e700e300$$ENDHEX$$o
								UPDATE produto_sap  
								SET de_produto = :ls_Valor
								Where cd_produto = :ll_Produto
								Using SqlCa;
								  
							Case 2 // Grupo de mercadoria
								UPDATE produto_sap  
								SET cd_grupo_mercadoria = :ls_Valor
								Where cd_produto = :ll_Produto
								Using SqlCa;
								
							Case 3 // Arvore
								UPDATE produto_sap  
								SET cd_arvore_mercad = :ls_Valor
								Where cd_produto = :ll_Produto
								Using SqlCa;
								
							Case 4 // Segmento
								UPDATE produto_sap  
								SET cd_segmento = :ls_Valor
								Where cd_produto = :ll_Produto
								Using SqlCa;
								
							Case 5 // Pai e Filho
								
								UPDATE produto_sap  
								SET cd_grupo_pai = :ll_Grupo_Pai, cd_grupo_categoria_pai = :ls_Valor
								Where cd_produto = :ll_Produto
								Using SqlCa;
								
								
							Case Else
								lb_Sucesso = False
								SqlCa.of_RollBack();
								MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tipo de leitura n$$HEX1$$e300$$ENDHEX$$o prevista para o produto " + string(ll_Produto) )
								Return False
						End Choose
						
						If gvo_Aplicacao.ivs_DataSource = 'central' Then
							If Sqlca.SQLNRows = 0 Then
								Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi atualizado nenhum registro para o produto '" + String(ll_Produto) +  "' tipo '"+ String(ai_tipo) + "'.")
								SqlCa.of_RollBack();
								Return False
							End If	
						End If
						
												
//					Case 100
						
//						ll_Achou  = 0 
//						
//						select cd_produto 
//						Into :ll_Achou
//						from produto_geral
//						where  cd_produto = :ll_Produto
//						Using SqlCa;
//						
//						If SqlCa.SqlCode = -1 Then
//							lb_Sucesso = False
//							SqlCa.of_RollBack();
//							Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar o produto")
//							Return False
//						End If
//						
//						If ll_Achou = 0 Then
//							w_aguarde.uo_progress.of_setprogress(ll_Linha)
//							Continue
//						End If 
//												
//						Choose Case ai_tipo 
//							Case 1 // Descri$$HEX2$$e700e300$$ENDHEX$$o
//								INSERT INTO produto_sap ( cd_produto, de_produto)   
//	 	 						VALUES ( :ll_Produto, :ls_Valor)
//								Using SqlCa;
//								  
//							Case 2  // Grupo de mercadoria
//								INSERT INTO produto_sap ( cd_produto, cd_grupo_mercadoria)   
//	 	 						VALUES ( :ll_Produto, :ls_Valor)
//  								Using SqlCa;
//							
//							Case 3  // Arvore
//								INSERT INTO produto_sap ( cd_produto, cd_arvore_mercad)   
//	 	 						VALUES ( :ll_Produto, :ls_Valor)
// 								Using SqlCa; 
//								 
//							Case 4  // Segmento
//								INSERT INTO produto_sap ( cd_produto, cd_segmento)   
//	 	 						VALUES ( :ll_Produto, :ls_Valor)
//  								Using SqlCa;
//							
//							Case 5 // Pai e Filhao
//								
//								INSERT INTO produto_sap ( cd_produto, cd_grupo_pai, cd_grupo_categoria_pai)   
//	 	 						VALUES ( :ll_Produto, :ll_Grupo_Pai, :ls_Valor)
//  								Using SqlCa;
//								  								
//							Case Else
//								lb_Sucesso = False
//								SqlCa.of_RollBack();
//								MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Tipo de leitura n$$HEX1$$e300$$ENDHEX$$o prevista para o produto " + string(ll_Produto) )
//								Return False
//						End Choose
//						
//						If SqlCa.SqlCode = -1 Then
//							lb_Sucesso = False
//							Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao inserir o produto SAP" + SqlCa.SqlerrText)
//							SqlCa.of_RollBack();
//							Return False
//						End If
//						
//					Case -1
//						lb_Sucesso = False
//						SqlCa.of_MsgDbError("Erro ao localizar o cheque." )
//						Return False
//				End choose	
				
				w_aguarde.uo_progress.of_setprogress(ll_Linha)	
			Next
			
			If lb_Sucesso Then
				SqlCa.of_Commit();
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Terminou.")
			Else
				SqlCa.of_RollBack();
			End If
			
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A planilha est$$HEX1$$e100$$ENDHEX$$ em branco.")
			Return False
		End If
	End If
	
Finally
	

	
	Close(w_Aguarde)
	If IsValid(lo_Excel) Then Destroy(lo_Excel)
End Try
Return True
end function

public subroutine wf_atualiza_dados_carga (integer ai_tipo);Integer li_Arquivo

String lvs_Path, &
       	lvs_Arquivo

li_Arquivo = GetFileOpenName("Selecione o Arquivo de Retorno", lvs_Path, lvs_Arquivo, "", "Excel 2007 (*.XLSX),*.XLSX,Excel (*.XLS), *.XLS")

If li_Arquivo = 1 Then
	wf_leitura_planilha(lvs_Path, ai_tipo)
End If
end subroutine

public function string wf_retorna_texto_formatado_mat (string ps_texto);If IsNull(ps_texto) or Trim(ps_Texto) = '' Then 
	Return  ""
End If

ps_texto = trim(ps_Texto)

//~t	Tab
//~r	Carriage return
//~n	Newline or linefeed
//~"	Double quote
//~'	Single quote
//~~	Tilde

ps_texto = "CC*" + ps_texto

ps_texto = gf_replace(ps_texto, ";", ".", 0)
ps_texto = gf_replace(ps_texto, "-", "~t", 0)

//ps_texto = gf_replace(ps_texto, "`", "", 0)
//ps_texto = gf_replace(ps_texto, "$$HEX1$$b400$$ENDHEX$$", "", 0)
//ps_texto = gf_replace(ps_texto, "'", "", 0)
//ps_texto = gf_replace(ps_texto, "-", " ", 0)
//ps_texto = gf_replace(ps_texto, "/", " ", 0)
//ps_texto = gf_replace(ps_texto, "\", " ", 0)
//ps_texto = gf_replace(ps_texto, "    ", " ", 0)
//ps_texto = gf_replace(ps_texto, "   ", " ", 0)
//ps_texto = gf_replace(ps_texto, "  ", " ", 0)

//ps_texto = gf_replace(ps_texto, "~r~n", " ", 0)
//ps_texto = gf_replace(ps_texto, "~n", " ", 0)
//ps_texto = gf_replace(ps_texto, "~t", " ", 0)
//ps_texto = gf_retira_acentos(ps_texto)

ps_texto = gf_replace(ps_texto, "~r", "CC/", 0)
ps_texto = gf_replace(ps_texto, "~n", "CC/", 0)

ps_texto = gf_replace(ps_texto, "CC/CC/", "CC/", 0)

Return ps_texto
end function

private function boolean wf_exporta_contratos_imposto_retido ();Long 			lvl_Linhas
Long       	lvl_linha
Long 			lvl_row
Integer 		lvi_emp_sap
String 		lvs_Dir
String 		lvs_Arquivo
String 		lvs_tipocarga
String    	 	lvs_cpf_cnpj  
String 		lvs_Fornec_SAP
String 		lvs_find
String 		lvs_retorno
Decimal{2}  lvdc_valcont
Decimal{2}  lvdc_valcont_orig

Try
	//Abre tela aguarde
	Open(w_aguarde)
	w_aguarde.Title = "Recuperando informa$$HEX2$$e700f500$$ENDHEX$$es Imposto Retido  "+ "..."

	If Not ivds_exp_mult.Of_ChangeDataObject( "ds_ge583_impostos_retidos") Then Return False
	
	//Altera objeto para a base do Oracle
	ivds_exp_mult.Of_SetTransObject( ivo_trans_mult )
	
	ivs_Ambiente_Sap = 'TXB' 
	lvl_Linhas = ivds_exp_mult.Retrieve(ivi_Empresa,1000, ivdt_inicio,  ivdt_fim)  
	
	w_aguarde.Title = "Exportando informa$$HEX2$$e700f500$$ENDHEX$$es Impostos Retidos  "+ "..."	
	Yield()
	
	//Diretorio arquivos
	lvs_Arquivo = ivs_Dir+"\CLAMED\Contratos_Impostos_Retidos "+"_de_" + gf_Replace(String(ivdt_Inicio), "/", "_", 0) + "_ate_" + gf_Replace(String(ivdt_Fim), "/", "_", 0) +"_"+String(Today(), "HHMM") +"."+ivs_Extensao
	If not DirectoryExists(ivs_Dir) Then CreateDirectory(ivs_Dir)
	If not DirectoryExists(ivs_Dir+"\CLAMED") Then CreateDirectory(ivs_Dir+"\CLAMED")

	Choose Case lvl_Linhas
		Case is < 0
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Falha ao recuperar as informa$$HEX2$$e700f500$$ENDHEX$$es de Impostos Retidos - " + "ds_ge583_impostos_retidos." , Exclamation!)
			Return False
			
		Case 0
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foram encontrados informa$$HEX2$$e700f500$$ENDHEX$$es  " +" com os par$$HEX1$$e200$$ENDHEX$$metros informados.", Exclamation!)
			Return False
		
		Case Else
			
		//Renomeia arquivo atual, se existir, para um backup
		If FileExists(lvs_Arquivo) Then
			If FileCopy (lvs_Arquivo , lvs_Dir+"\CLAMED\Contratos_Impostos_Retidos "+"_de_" + gf_Replace(String(ivdt_Inicio), "/", "_", 0) + "_ate_" + gf_Replace(String(ivdt_Fim), "/", "_", 0)+"_BKP_"+"."+ivs_Extensao, True) = 1 Then
				FileDelete(lvs_Arquivo)
			End If
		End if			
	
	   // Realiza DE-PARA Fornecedor
	For lvl_linha = 1 to lvl_Linhas
			 
		lvs_cpf_cnpj = ivds_exp_mult.GetItemString(lvl_linha, 'cpf_cnpj')
		Setnull(lvs_Fornec_SAP)
      	lvs_find		= "cd_chave_legado = '" + lvs_cpf_cnpj +"'"
		
		//Verifica se o campo existe na DW DE/PARA carregada
		lvl_row	= ivds_de_para.find(lvs_find, 1, ivds_de_para.rowcount( ) )
		//Se existe na DW
		If lvl_row > 0 then
			//Pega o valor e guarda-o na vari$$HEX1$$e100$$ENDHEX$$vel
		       lvs_Fornec_SAP = ivds_de_para.GetItemString(lvl_Row, 'cd_chave_sap')
			  ivds_exp_mult.SetItem( lvl_Linha, 'ID_Parceiro', lvs_Fornec_SAP)	 
		End If	
	Next	
	
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

on w_ge583_carga_impostos_retidos.create
int iCurrent
call super::create
this.cb_exportar=create cb_exportar
this.cb_fechar=create cb_fechar
this.dw_1=create dw_1
this.cb_sel_dir=create cb_sel_dir
this.dw_log=create dw_log
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_exportar
this.Control[iCurrent+2]=this.cb_fechar
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.cb_sel_dir
this.Control[iCurrent+5]=this.dw_log
this.Control[iCurrent+6]=this.gb_1
end on

on w_ge583_carga_impostos_retidos.destroy
call super::destroy
destroy(this.cb_exportar)
destroy(this.cb_fechar)
destroy(this.dw_1)
destroy(this.cb_sel_dir)
destroy(this.dw_log)
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
ivds_de_para		 = Create dc_uo_ds_base

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
	
	//Alterar para os datasources de de-para de produto e fornecedor de notas fiscais
	ivds_de_para.of_SetTransObject( uoi_transacao_SYB )
	If Not ivds_de_Para.Of_ChangeDataObject("ds_ge583_de_para_fornecedor", False) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel  alternar para a DW 'ds_ge583_de_para_fornecedor'.", StopSign!)
		Post Close( This )
	End If

ivb_permite_fechar = False
end event

event close;call super::close;
If Isvalid (ivds_de_para)  	then Destroy(ivds_de_para)
If Isvalid (ivds_exp_mult)  	then Destroy(ivds_exp_mult)

//SYB
uoi_transacao_SYB.of_disconnect( )
Destroy(uoi_transacao_SYB)


Destroy(ivtr_Mult)

end event

type pb_help from dc_w_response`pb_help within w_ge583_carga_impostos_retidos
integer x = 0
integer y = 0
end type

type cb_exportar from commandbutton within w_ge583_carga_impostos_retidos
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

dw_log.Reset()

Long lvl_Empresa
Date lvdt_Posicao
Long lvl_Total_Rec


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
	
w_Aguarde_2.Title = "Recuperando informa$$HEX2$$e700f500$$ENDHEX$$es de DE/PARA Fornecedor.."
lvl_Total_Rec = ivds_de_para.Retrieve()
If lvl_Total_Rec < 1 then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o existe registro na tabela de DE-PARA de Fornecedores entre legado e SAP(TDF) .~r~nErroDB:" + uoi_transacao_SYB.sqlerrtext, Exclamation!)
	Return
End If

If IsValid(w_Aguarde_2) Then Close(w_Aguarde_2)

wf_exporta_contratos_imposto_retido()
end event

type cb_fechar from commandbutton within w_ge583_carga_impostos_retidos
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

type dw_1 from dc_uo_dw_base within w_ge583_carga_impostos_retidos
integer x = 119
integer y = 108
integer width = 1906
integer height = 276
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge583_selecao_imp_retido"
end type

type cb_sel_dir from commandbutton within w_ge583_carga_impostos_retidos
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

type dw_log from dc_uo_dw_base within w_ge583_carga_impostos_retidos
boolean visible = false
integer x = 178
integer y = 1696
integer width = 178
integer height = 100
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge583_log"
end type

type gb_1 from groupbox within w_ge583_carga_impostos_retidos
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

