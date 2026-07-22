HA$PBExportHeader$w_ge039_menu_fiscal.srw
forward
global type w_ge039_menu_fiscal from window
end type
type cb_meios_pagamento from commandbutton within w_ge039_menu_fiscal
end type
type cb_sair from commandbutton within w_ge039_menu_fiscal
end type
type dw_1 from dc_uo_dw_base within w_ge039_menu_fiscal
end type
type st_msg from statictext within w_ge039_menu_fiscal
end type
type cb_lmfc_reducao from commandbutton within w_ge039_menu_fiscal
end type
type cb_tab_estoque from commandbutton within w_ge039_menu_fiscal
end type
type cb_produto from commandbutton within w_ge039_menu_fiscal
end type
type cb_lmfs from commandbutton within w_ge039_menu_fiscal
end type
type cb_identifica_pafecf from commandbutton within w_ge039_menu_fiscal
end type
type cb_arquivo_mfd from commandbutton within w_ge039_menu_fiscal
end type
type cb_lmfc_data from commandbutton within w_ge039_menu_fiscal
end type
type cb_lx from commandbutton within w_ge039_menu_fiscal
end type
type cb_movimento_ecf from commandbutton within w_ge039_menu_fiscal
end type
type cb_espelho_mdf from commandbutton within w_ge039_menu_fiscal
end type
end forward

global type w_ge039_menu_fiscal from window
integer x = 535
integer y = 640
integer width = 2565
integer height = 760
boolean titlebar = true
string title = "GE039 - Fun$$HEX2$$e700f500$$ENDHEX$$es de Controle da Impressora Fiscal"
windowtype windowtype = response!
long backcolor = 80269524
cb_meios_pagamento cb_meios_pagamento
cb_sair cb_sair
dw_1 dw_1
st_msg st_msg
cb_lmfc_reducao cb_lmfc_reducao
cb_tab_estoque cb_tab_estoque
cb_produto cb_produto
cb_lmfs cb_lmfs
cb_identifica_pafecf cb_identifica_pafecf
cb_arquivo_mfd cb_arquivo_mfd
cb_lmfc_data cb_lmfc_data
cb_lx cb_lx
cb_movimento_ecf cb_movimento_ecf
cb_espelho_mdf cb_espelho_mdf
end type
global w_ge039_menu_fiscal w_ge039_menu_fiscal

type prototypes

end prototypes

type variables
s_ge039_parametro_pafecf ivs_Parametro

String ivs_Laudo
String ivs_Autenticacao
String ivs_Autenticacao_Caixa
String ivs_Autenticacao_Retaguarda

end variables

on w_ge039_menu_fiscal.create
this.cb_meios_pagamento=create cb_meios_pagamento
this.cb_sair=create cb_sair
this.dw_1=create dw_1
this.st_msg=create st_msg
this.cb_lmfc_reducao=create cb_lmfc_reducao
this.cb_tab_estoque=create cb_tab_estoque
this.cb_produto=create cb_produto
this.cb_lmfs=create cb_lmfs
this.cb_identifica_pafecf=create cb_identifica_pafecf
this.cb_arquivo_mfd=create cb_arquivo_mfd
this.cb_lmfc_data=create cb_lmfc_data
this.cb_lx=create cb_lx
this.cb_movimento_ecf=create cb_movimento_ecf
this.cb_espelho_mdf=create cb_espelho_mdf
this.Control[]={this.cb_meios_pagamento,&
this.cb_sair,&
this.dw_1,&
this.st_msg,&
this.cb_lmfc_reducao,&
this.cb_tab_estoque,&
this.cb_produto,&
this.cb_lmfs,&
this.cb_identifica_pafecf,&
this.cb_arquivo_mfd,&
this.cb_lmfc_data,&
this.cb_lx,&
this.cb_movimento_ecf,&
this.cb_espelho_mdf}
end on

on w_ge039_menu_fiscal.destroy
destroy(this.cb_meios_pagamento)
destroy(this.cb_sair)
destroy(this.dw_1)
destroy(this.st_msg)
destroy(this.cb_lmfc_reducao)
destroy(this.cb_tab_estoque)
destroy(this.cb_produto)
destroy(this.cb_lmfs)
destroy(this.cb_identifica_pafecf)
destroy(this.cb_arquivo_mfd)
destroy(this.cb_lmfc_data)
destroy(this.cb_lx)
destroy(this.cb_movimento_ecf)
destroy(this.cb_espelho_mdf)
end on

event close;Destroy(pdv)
end event

event open;Date ldt_Reduzaoz

String ls_Laudo
String ls_Autenticacao

pdv = Create uo_pdv

pdv.of_modo_impressora()

uo_Parametro_Filial lvo_Parametro
lvo_Parametro = Create uo_Parametro_Filial

If lvo_Parametro.of_Localiza_Parametro("NR_LAUDO_PAFECF", ref ls_Laudo) Then
	
	If lvo_Parametro.of_Localiza_Parametro("ID_AUTENTICACAO_PAFECF_" + Upper(gvo_Aplicacao.ivo_Seguranca.Cd_Sistema), ref ls_Autenticacao) Then
		
		This.ivs_Autenticacao	= ls_Autenticacao
		This.ivs_Laudo				= ls_Laudo
					
	End If
	
End If

Destroy(lvo_Parametro)
end event

type cb_meios_pagamento from commandbutton within w_ge039_menu_fiscal
integer x = 859
integer y = 408
integer width = 800
integer height = 108
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Meios de pagamento"
end type

event clicked;
Boolean 	lb_Sucesso

Long		ll_Row

String 	ls_Relatorio[]

Decimal{2} ldc_venda

ivs_Parametro.id_periodo = 'S'
ivs_Parametro.id_coo 	 = 'N'
ivs_Parametro.id_destino = 'N'

OpenWithParm(w_ge039_parametro_pafecf,ivs_Parametro)

ivs_Parametro = Message.PowerObjectParm

If ivs_Parametro.id_Retorno = 'OK' Then
	
	If Not dw_1.of_ChangeDataObject('dw_ge039_pafecf_meio_pagamento') Then Return
	
	dw_1.Retrieve(ivs_Parametro.dh_inicial,ivs_Parametro.dh_final)
	
	If dw_1.RowCount() > 0 Then
		
		If Not pdv.of_abreporta() Then Return
		
		ls_Relatorio[1] = 'Resumo Meios de Pagamento'
		ls_Relatorio[2] = 'Periodo: ' + String(ivs_Parametro.dh_inicial,'dd/mm/yyyy') + ' ate ' + String(ivs_Parametro.dh_final,'dd/mm/yyyy')	
		
		For ll_row = 1 To dw_1.RowCount()
			
			ldc_venda = dw_1.object.vl_total_venda[ll_row]
					
			Choose Case dw_1.object.cd_forma_pagamento[ll_row]
				Case 'DI'
					ls_Relatorio[ll_row+3] += 'DINHEIRO:' + RightA(space(30) + String(ldc_venda,'###,###,##0.00'),26)
				Case 'CP'
					ls_Relatorio[ll_row+3] += 'CARTAO CREDITO:' + RightA(space(30) + String(ldc_venda,'###,###,##0.00'),20)
				Case 'CA'
					ls_Relatorio[ll_row+3] += 'CARTAO DEBITO:' + RightA(space(30) + String(ldc_venda,'###,###,##0.00'),21)
				Case 'HA'
					ls_Relatorio[ll_row+3] += 'CHEQUE:' + RightA(space(30) + String(ldc_venda,'###,###,##0.00'),28)
				Case 'HP'
					ls_Relatorio[ll_row+3] += 'CHEQUE-PRE:' + RightA(space(30) + String(ldc_venda,'###,###,##0.00'),23)
				Case 'CV'	
					ls_Relatorio[ll_row+3] += 'CONVENIO:' + RightA(space(30) + String(ldc_venda,'###,###,##0.00'),26)
			End Choose
			
		Next
			
		lb_Sucesso = pdv.of_emite_comprovante('01',ls_Relatorio)

		pdv.of_fechaporta()
	
	End If	
	
End If
end event

type cb_sair from commandbutton within w_ge039_menu_fiscal
integer x = 1691
integer y = 408
integer width = 800
integer height = 108
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Sair"
end type

event clicked;Close(Parent)
end event

type dw_1 from dc_uo_dw_base within w_ge039_menu_fiscal
boolean visible = false
integer x = 1445
integer y = 864
integer width = 1143
integer height = 708
integer taborder = 80
string dataobject = "dw_ge039_pafecf_estoque"
end type

type st_msg from statictext within w_ge039_menu_fiscal
integer x = 27
integer y = 572
integer width = 2491
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
boolean enabled = false
boolean focusrectangle = false
end type

type cb_lmfc_reducao from commandbutton within w_ge039_menu_fiscal
integer x = 1691
integer y = 28
integer width = 800
integer height = 108
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "LMFC Redu$$HEX2$$e700e300$$ENDHEX$$o"
end type

event clicked;
Boolean 	lb_Sucesso

String	ls_File = 'c:\paf-ecf\leitura-memoria-fiscal-reducao.txt'

ivs_Parametro.id_reducao = 'S'
ivs_Parametro.id_destino = 'S'

OpenWithParm(w_ge039_parametro_pafecf,ivs_Parametro)

ivs_Parametro = Message.PowerObjectParm

If ivs_Parametro.id_Retorno = 'OK' Then


	If Not PDV.of_abreporta() Then Return
	
	st_msg.text = 'Gerando Leitura Mem$$HEX1$$f300$$ENDHEX$$ria Fiscal Completa ...'

	lb_Sucesso = PDV.of_leitura_memoria_fiscal_reducao(ivs_Parametro.nr_reducao_inicial,ivs_Parametro.nr_reducao_final,ivs_Parametro.id_Arquivo,'c')
	
	st_msg.text = ''
	
	If lb_Sucesso Then
		
		If ivs_Parametro.id_Arquivo Then
			dc_uo_api lvo_api
			lvo_api = Create dc_uo_api
			
			If lvo_Api.of_Move_file('c:\PAF-ECF\retorno.txt',ls_File,True) Then
			
				If PDV.of_Assinatura_Digital(ls_File) Then
					
					If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Visualizar arquivo gerado ?",Question!,YesNo!,1) = 1 Then
						Run('C:\Arquivos de programas\Internet Explorer\iexplore.exe ' + ls_File )
					End If
				
				End If
				
			End If
			
			Destroy lvo_api
			
		End If	
		
	End If	
		
	PDV.of_fechaporta()

End If
end event

type cb_tab_estoque from commandbutton within w_ge039_menu_fiscal
integer x = 27
integer y = 152
integer width = 800
integer height = 112
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Tabela Estoque"
end type

event clicked;
Boolean lb_Sucesso

Long ll_File
Long ll_Row

String ls_File = 'c:\PAF-ECF\tabela-estoque.txt'

If Not dw_1.of_ChangeDataObject('dw_ge039_pafecf_produto') Then Return

st_msg.text = 'Carregando tabela de estoque ...'

dw_1.Retrieve()

st_msg.text = 'Gerando arquivo magn$$HEX1$$e900$$ENDHEX$$tico ... '

FileDelete(ls_File)

ll_File = FileOpen(ls_File, LineMode!, Write!, LockWrite!, Append!)
/*
If FileWrite(ll_File,'E1' + &
                      LeftA(gvo_parametro.nr_cgc+Space(14),14) + &
							 LeftA(gvo_parametro.nr_inscricao_estadual+Space(14),14) + &
							 LeftA(gvo_parametro.nm_razao_social+Space(50),50) ) <> -1 Then
							 
	Open(w_Aguarde)
	w_Aguarde.uo_Progress.of_SetMax(dw_1.RowCount())
	
	For ll_Row = 1 To dw_1.RowCount()
		
		w_Aguarde.uo_Progress.of_SetProgress(ll_Row)
		
		If FileWrite(ll_File,'E2' + &
                      LeftA(gvo_parametro.nr_cgc + Space(14) ,14) + &
							 LeftA(String(dw_1.object.cd_produto[ll_row],'000000') + Space(14) ,14) + &
							 LeftA(dw_1.object.de_produto[ll_row] + Space(50) ,50) + &
							 LeftA(dw_1.object.cd_un[ll_row] + Space(06) ,06) + &
							 RightA(Space(09)+String(dw_1.object.qt_saldo_final[ll_row],'#####0.00'),09) + &
							 String(Today(),'yyymmdd') ) = -1 Then
							 
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao gravar registro E2 da tabela produto.",StopSign!)
			lb_Sucesso = False
			Exit	
		Else
			lb_Sucesso = True
				
		End If
		
	Next
	
	If lb_Sucesso Then
		
		If FileWrite(ll_File,'E9' + &
							 LeftA(gvo_parametro.nr_cgc+Space(14),14) + &
							 LeftA(gvo_parametro.nr_inscricao_estadual+Space(14),14) + &
							 String(dw_1.RowCount(),'000000') ) = -1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao gravar registro E9 da tabela produto.",StopSign!)
			
		Else
			
			If IsValid(w_Aguarde) Then Close(w_Aguarde)
			
			FileClose(ll_File)

			If PDV.of_Assinatura_Digital(ls_File) Then
				If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Visualizar arquivo gerado ?",Question!,YesNo!,1) = 1 Then
					Run('C:\Arquivos de programas\Internet Explorer\iexplore.exe ' + ls_File)
				End If
			End If	
			
		End If
		
	End If
	
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao gravar registro E1 da tabela produto.",StopSign!)
End If	

FileClose(ll_File)

If IsValid(w_Aguarde) Then Close(w_Aguarde)
	*/		
st_msg.text = ''
end event

type cb_produto from commandbutton within w_ge039_menu_fiscal
integer x = 859
integer y = 152
integer width = 800
integer height = 112
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Produto"
end type

event clicked;
Boolean 	lb_Sucesso

Long 		ll_File
Long 		ll_Row

String 	ls_File = 'c:\paf-ecf\produto.txt'

If Not dw_1.of_ChangeDataObject('dw_ge039_pafecf_produto') Then Return

st_msg.text = 'Carregando tabela de estoque ...'

dw_1.Retrieve()

st_msg.text = 'Gerando arquivo magn$$HEX1$$e900$$ENDHEX$$tico ... '

FileDelete(ls_File)

ll_File = FileOpen(ls_File, LineMode!, Write!, LockWrite!, Append!)
/*
If FileWrite(ll_File,'E1' + &
                      LeftA(gvo_parametro.nr_cgc+Space(14),14) + &
							 LeftA(gvo_parametro.nr_inscricao_estadual+Space(14),14) + &
							 LeftA(gvo_parametro.nm_razao_social+Space(50),50) ) <> -1 Then
							 
	Open(w_Aguarde)
	w_Aguarde.uo_Progress.of_SetMax(dw_1.RowCount())
	
	For ll_Row = 1 To dw_1.RowCount()
		
		w_Aguarde.uo_Progress.of_SetProgress(ll_Row)
		
		If FileWrite(ll_File,'E2' + &
                      LeftA(gvo_parametro.nr_cgc + Space(14) ,14) + &
							 LeftA(String(dw_1.object.cd_produto[ll_row],'000000') + Space(14) ,14) + &
							 LeftA(dw_1.object.de_produto[ll_row] + Space(50) ,50) + &
							 LeftA(dw_1.object.cd_un[ll_row] + Space(06) ,06) + &
							 RightA(Space(09)+String(dw_1.object.qt_saldo_final[ll_row],'#####0.00'),09)) = -1 Then
							 
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao gravar registro E2 da tabela produto.",StopSign!)
			lb_Sucesso = False
			Exit
		Else
			lb_Sucesso = True
			
		End If
		
	Next
	
	If IsValid(w_Aguarde) Then Close(w_Aguarde)
	
	If lb_Sucesso Then
		
		If FileWrite(ll_File,'E9' + &
							 LeftA(gvo_parametro.nr_cgc+Space(14),14) + &
							 LeftA(gvo_parametro.nr_inscricao_estadual+Space(14),14) + &
							 String(dw_1.RowCount(),'000000') ) = -1 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao gravar registro E9 da tabela produto.",StopSign!)
		Else
			
			FileClose(ll_File)
			
			If PDV.of_Assinatura_Digital(ls_File) Then
				
				If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Visualizar arquivo gerado ?",Question!,YesNo!,1) = 1 Then
					Run('C:\Arquivos de programas\Internet Explorer\iexplore.exe ' + ls_File )
				End If
			
			End If	
						
		End If
		
	End If
	
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao gravar registro E1 da tabela produto.",StopSign!)
End If	

If IsValid(w_Aguarde) Then Close(w_Aguarde)
			
st_msg.text = ''
*/		
FileClose(ll_File)

end event

type cb_lmfs from commandbutton within w_ge039_menu_fiscal
integer x = 1691
integer y = 152
integer width = 800
integer height = 112
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "LMFS"
end type

event clicked;
Boolean lb_Sucesso

String ls_File

ivs_Parametro.id_periodo = 'S'
ivs_Parametro.id_destino = 'S'
ivs_Parametro.id_reducao = 'S'

OpenWithParm(w_ge039_parametro_pafecf,ivs_Parametro)

ivs_Parametro = Message.PowerObjectParm

If ivs_Parametro.id_Retorno = 'OK' Then

	if Not PDV.of_abreporta() Then Return
	
	st_msg.text = 'Gerando Leitura Mem$$HEX1$$f300$$ENDHEX$$ria Fiscal Simplificada ...'
	
	If ivs_Parametro.nr_reducao_inicial > 0 and ivs_Parametro.nr_reducao_final > 0 Then
		
		ls_File = 'c:\paf-ecf\leitura-memoria-fiscal-simplificada-reducao.txt'
		
		lb_Sucesso = PDV.of_leitura_memoria_fiscal_reducao(ivs_Parametro.nr_reducao_inicial,ivs_Parametro.nr_reducao_final,ivs_Parametro.id_Arquivo,'s')
	Else	
		
		ls_File = 'c:\paf-ecf\leitura-memoria-fiscal-simplificada-data.txt'
		
		lb_Sucesso = PDV.of_leitura_memoria_fiscal(String(ivs_Parametro.dh_inicial,'dd/mm/yyyy'),String(ivs_Parametro.dh_final,'dd/mm/yyyy'),ivs_Parametro.id_Arquivo,'s')
	End If
	
	st_msg.text = ''
	
	If lb_Sucesso Then
		
		If ivs_Parametro.id_Arquivo Then
			
			dc_uo_api lvo_Api
			lvo_api = Create dc_uo_api
					
			If lvo_Api.of_Move_File('c:\PAF-ECF\retorno.txt',ls_File,True) Then
				
				If PDV.of_Assinatura_Digital(ls_File) Then
				
					If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Visualizar arquivo gerado ?",Question!,YesNo!,1) = 1 Then
						Run('C:\Arquivos de programas\Internet Explorer\iexplore.exe ' + ls_File)
					End If
					
				End If
				
			End If	
			
			Destroy lvo_Api
			
		End If	
		
	End If	
		
	PDV.of_fechaporta()
	
End If
end event

type cb_identifica_pafecf from commandbutton within w_ge039_menu_fiscal
integer x = 27
integer y = 280
integer width = 800
integer height = 112
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Identifica$$HEX2$$e700e300$$ENDHEX$$o PAF-ECF"
end type

event clicked;Boolean lb_Sucesso

String  ls_Relatorio[]

String  ls_Laudo

st_msg.text = 'Imprimindo Identifica$$HEX2$$e700e300$$ENDHEX$$o do PAF-ECF ...'

If Not PDV.of_abreporta() Then Return

ls_Relatorio[01]  = CharA(13) + CharA(10)
ls_Relatorio[02]  = "      I D E N T I F I C A C A O    D O    P A F - E C F" + CharA(13) + CharA(10)
ls_Relatorio[03]  = CharA(13) + CharA(10)
ls_Relatorio[04]  = "NR LAUDO : " + ivs_Laudo
ls_Relatorio[05]  = ""
ls_Relatorio[06]  = "DESENVOLVEDOR : 84.683.481/0001-77"
ls_Relatorio[07]  = "                CIA LATINO AMERICANA DE MEDICAMENTOS"
ls_Relatorio[08]  = CharA(13) + CharA(10)
ls_Relatorio[09]  = "RUA NOVE DE MARCO 638 - CENTRO - CEP: 89.201-400"
ls_Relatorio[10]  = "JOINVILLE - SANTA CATARINA"
ls_Relatorio[11]  = "FONE: (47) 3461-9931 FAX: (47) 3461-9959 " + CharA(13) + CharA(10)
ls_Relatorio[12] = "CONTATO: LUCIAN GERVASI GALIOTTO"
ls_Relatorio[13] = "         lucian.galiotto@cialatinoamericana.com.br"
ls_Relatorio[14] =  CharA(13) + CharA(10)
ls_Relatorio[15] = "SOFTWARE: SISTEMA DE CAIXA"
ls_Relatorio[16] = "VERSAO 10.00" + CharA(13) + CharA(10)
ls_Relatorio[17] = "EXECUTAVEIS: CL.EXE MD5: " + ivs_Autenticacao_Caixa + CharA(13) + CharA(10)
ls_Relatorio[18] = "EXECUTAVEIS: RL.EXE MD5: " + ivs_Autenticacao_Retaguarda
ls_Relatorio[19] = CharA(13) + CharA(10)
ls_Relatorio[20] = "ECF AUTORIZADA NUMERO DE S$$HEX1$$c900$$ENDHEX$$RIE"
ls_Relatorio[21] = PDV.nr_serie
		
lb_Sucesso = PDV.of_emite_comprovante('01',ls_Relatorio)

st_msg.text = ''
	
PDV.of_fechaporta()
end event

type cb_arquivo_mfd from commandbutton within w_ge039_menu_fiscal
integer x = 859
integer y = 284
integer width = 800
integer height = 108
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Arquivo MFD"
end type

event clicked;
Boolean lb_Sucesso

String ls_parametro_inicial
String ls_parametro_final

String ls_tipo
String ls_File = 'c:\paf-ecf\cotepe1704.txt'

ivs_Parametro.id_periodo = 'S'
ivs_Parametro.id_coo     = 'S'
ivs_Parametro.id_destino = 'N'

OpenWithParm(w_ge039_parametro_pafecf,ivs_Parametro)

ivs_Parametro = Message.PowerObjectParm

If ivs_Parametro.id_Retorno = 'OK' Then
	
	If ivs_Parametro.nr_coo_inicial > 0 Then
		ls_Tipo = '2'
		ls_Parametro_inicial = String(ivs_Parametro.nr_coo_inicial,'000000')
		ls_Parametro_final   = String(ivs_Parametro.nr_coo_final,'000000')
	Else	
		ls_Tipo = '1'
		ls_Parametro_inicial = String(ivs_Parametro.dh_inicial,'ddmmyyyy')
		ls_Parametro_final  = String(ivs_Parametro.dh_final,'ddmmyyyy')
	End If	
	
	If Not PDV.of_abreporta() Then Return
	
	st_msg.text = 'Gerando Arquivo Cotepe 17/04 ...'
	
	//lb_Sucesso = PDV.of_gera_arquivo_cotepe1704(ls_Tipo,ls_Parametro_inicial,ls_Parametro_final,gvo_parametro.nm_razao_social,gvo_parametro.de_endereco)
	
	st_msg.text = ''
	
	If lb_Sucesso Then
		
		If PDV.of_Assinatura_Digital(ls_File) Then
		
			If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Visualizar arquivo gerado ?",Question!,YesNo!,1) = 1 Then
				Run('C:\Arquivos de programas\Internet Explorer\iexplore.exe ' + ls_File )
			End If
		
		End If
		
	End If
	
	PDV.of_fechaporta()

End If
end event

type cb_lmfc_data from commandbutton within w_ge039_menu_fiscal
integer x = 859
integer y = 28
integer width = 800
integer height = 108
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "LMFC Data"
end type

event clicked;
Boolean 	lb_Sucesso

String	ls_File = 'c:\paf-ecf\leitura-memoria-fiscal-data.txt'

ivs_Parametro.id_periodo = 'S'
ivs_Parametro.id_destino = 'S'

OpenWithParm(w_ge039_parametro_pafecf,ivs_Parametro)

ivs_Parametro = Message.PowerObjectParm

If ivs_Parametro.id_Retorno = 'OK' Then

	If Not PDV.of_abreporta() Then Return
	
	st_msg.text = 'Gerando Leitura Mem$$HEX1$$f300$$ENDHEX$$ria Fiscal Completa ...'
	
	lb_Sucesso = PDV.of_leitura_memoria_fiscal(String(ivs_Parametro.dh_inicial,'dd/mm/yyyy'),String(ivs_Parametro.dh_final,'dd/mm/yyyy'),ivs_Parametro.id_Arquivo,'C')
	
	st_msg.text = ''
	
	If lb_Sucesso Then
		
		If ivs_Parametro.id_Arquivo Then
			
			dc_uo_api lvo_api
			lvo_api = Create dc_uo_api
		
			If lvo_Api.of_Move_File('c:\PAF-ECF\retorno.txt',ls_File,True) Then
			
				If PDV.of_Assinatura_Digital(ls_File) Then
					
					If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Visualizar arquivo gerado ?",Question!,YesNo!,1) = 1 Then
						Run('C:\Arquivos de programas\Internet Explorer\iexplore.exe ' + ls_File )
					End If
				
				End If
				
			End If	
			
			Destroy lvo_Api
			
		End If	
		
	End If	
		
	PDV.of_fechaporta()

End If
end event

type cb_lx from commandbutton within w_ge039_menu_fiscal
integer x = 27
integer y = 28
integer width = 800
integer height = 108
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "LX"
end type

event clicked;Boolean 	lb_Sucesso

String 	ls_File = 'c:\paf-ecf\leiturax.txt'

ivs_Parametro.id_destino = 'S'

OpenWithParm(w_ge039_parametro_pafecf,ivs_Parametro)

ivs_Parametro = Message.PowerObjectParm

If ivs_Parametro.id_Retorno = 'OK' Then

	If Not PDV.of_abreporta() Then Return
	
	st_msg.text = 'Gerando Leitura X ...'
	
	lb_Sucesso = PDV.of_leiturax(ivs_Parametro.id_Arquivo)
	
	st_msg.text = ''
	
	If lb_Sucesso Then
		
		dc_uo_Api lvo_Api
		lvo_Api = Create dc_uo_Api
		
		If lvo_Api.of_Move_File('c:\retorno.txt',ls_File,True) Then
		
			If PDV.of_Assinatura_Digital(ls_File) Then
			
				If ivs_Parametro.id_Arquivo Then
							
					If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Visualizar arquivo gerado ?",Question!,YesNo!,1) = 1 Then
						Run('C:\Arquivos de programas\Internet Explorer\iexplore.exe ' + ls_File)
					End If	
					
				End If	
				
			End If	
			
		End If
		
		Destroy lvo_Api
		
	End If	
	
	PDV.of_fechaporta()
	
End If
end event

type cb_movimento_ecf from commandbutton within w_ge039_menu_fiscal
integer x = 1691
integer y = 284
integer width = 800
integer height = 108
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Movimento por ECF"
end type

event clicked;
Long     ll_Row
Long 		ll_Ecf

String	ls_Arquivo

ivs_Parametro.id_periodo = 'S'
ivs_Parametro.id_ecf     = 'S'
ivs_Parametro.id_destino = 'N'

OpenWithParm(w_ge039_parametro_pafecf,ivs_Parametro)

ivs_Parametro = Message.PowerObjectParm

If ivs_Parametro.id_Retorno = 'OK' Then
	
	If Not dw_1.of_ChangeDataObject('dw_ge039_pafecf_ecf_movimento') Then Return
	
	dw_1.Retrieve(ivs_Parametro.nr_ecf_inicial,ivs_Parametro.nr_ecf_final,ivs_Parametro.dh_inicial,ivs_Parametro.dh_final)
	
	For ll_Row = 1 To dw_1.RowCount()
		
		ll_ecf = dw_1.object.nr_ecf[ll_Row]
					
		//PDV.of_Gera_Movimento_pafecf(Ref ls_Arquivo,ll_ecf, ivs_Parametro.dh_inicial,ivs_Parametro.dh_final)
			
	Next
		
	st_msg.text = 'Gerando arquivo magn$$HEX1$$e900$$ENDHEX$$tico ... '
	
	If IsValid(w_Aguarde) Then Close(w_Aguarde)
				
	st_msg.text = ''
	
End If	
end event

type cb_espelho_mdf from commandbutton within w_ge039_menu_fiscal
integer x = 27
integer y = 408
integer width = 800
integer height = 108
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Espelho MFD"
end type

event clicked;
Boolean lb_Sucesso

String ls_Parametro_Inicial
String ls_Parametro_Final
String ls_Tipo

String ls_File = 'c:\paf-ecf\leitura-memoria-fita-detalhe.txt'

ivs_Parametro.id_periodo = 'S'
ivs_Parametro.id_coo 	 = 'S'
ivs_Parametro.id_destino = 'N'

OpenWithParm(w_ge039_parametro_pafecf,ivs_Parametro)

ivs_Parametro = Message.PowerObjectParm

If ivs_Parametro.id_Retorno = 'OK' Then

	If Not PDV.of_abreporta() Then Return
	
	st_msg.text = 'Gerando Leitura Mem$$HEX1$$f300$$ENDHEX$$ria Fiscal Completa ...'
	
	If ivs_Parametro.nr_coo_inicial > 0 Then
		lb_Sucesso = PDV.of_leitura_memoria_fita_detalhe('2',String(ivs_Parametro.nr_coo_inicial,'000000'),String(ivs_Parametro.nr_coo_final,'000000'))	
	Else		
		lb_Sucesso = PDV.of_leitura_memoria_fita_detalhe('1',String(ivs_Parametro.dh_inicial,'dd/mm/yyyy'),String(ivs_Parametro.dh_final,'dd/mm/yyyy'))	
	End If
	
	st_msg.text = ''
	
	If lb_Sucesso Then
		
		dc_uo_api lvo_api
		lvo_api = create dc_uo_api
		
		lvo_api.of_Move_File("c:\retorno.txt", ls_File, True)
		
		Destroy lvo_Api
		
		If PDV.of_Assinatura_Digital(ls_File) Then
		
			If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Visualizar arquivo gerado ?",Question!,YesNo!,1) = 1 Then
				Run('C:\Arquivos de programas\Internet Explorer\iexplore.exe ' + ls_File )
			End If
		
		End If
		
	End If	
		
	PDV.of_fechaporta()
	
End If	




end event

