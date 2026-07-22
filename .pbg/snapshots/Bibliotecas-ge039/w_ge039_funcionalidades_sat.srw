HA$PBExportHeader$w_ge039_funcionalidades_sat.srw
forward
global type w_ge039_funcionalidades_sat from dc_w_response
end type
type cb_atualiza from commandbutton within w_ge039_funcionalidades_sat
end type
type cb_desbloquear from commandbutton within w_ge039_funcionalidades_sat
end type
type cb_bloquear from commandbutton within w_ge039_funcionalidades_sat
end type
type cb_trocar_codigo from commandbutton within w_ge039_funcionalidades_sat
end type
type cb_extrair from commandbutton within w_ge039_funcionalidades_sat
end type
type cb_teste from commandbutton within w_ge039_funcionalidades_sat
end type
type cb_status from commandbutton within w_ge039_funcionalidades_sat
end type
type cb_consulta from commandbutton within w_ge039_funcionalidades_sat
end type
type cb_assinar from commandbutton within w_ge039_funcionalidades_sat
end type
type cb_ativar from commandbutton within w_ge039_funcionalidades_sat
end type
type cb_conf_rede from commandbutton within w_ge039_funcionalidades_sat
end type
type cb_gera_codigo from commandbutton within w_ge039_funcionalidades_sat
end type
type gb_1 from groupbox within w_ge039_funcionalidades_sat
end type
end forward

global type w_ge039_funcionalidades_sat from dc_w_response
integer width = 1925
integer height = 752
string title = "GE039 - Funcionalidades SAT"
boolean center = true
cb_atualiza cb_atualiza
cb_desbloquear cb_desbloquear
cb_bloquear cb_bloquear
cb_trocar_codigo cb_trocar_codigo
cb_extrair cb_extrair
cb_teste cb_teste
cb_status cb_status
cb_consulta cb_consulta
cb_assinar cb_assinar
cb_ativar cb_ativar
cb_conf_rede cb_conf_rede
cb_gera_codigo cb_gera_codigo
gb_1 gb_1
end type
global w_ge039_funcionalidades_sat w_ge039_funcionalidades_sat

on w_ge039_funcionalidades_sat.create
int iCurrent
call super::create
this.cb_atualiza=create cb_atualiza
this.cb_desbloquear=create cb_desbloquear
this.cb_bloquear=create cb_bloquear
this.cb_trocar_codigo=create cb_trocar_codigo
this.cb_extrair=create cb_extrair
this.cb_teste=create cb_teste
this.cb_status=create cb_status
this.cb_consulta=create cb_consulta
this.cb_assinar=create cb_assinar
this.cb_ativar=create cb_ativar
this.cb_conf_rede=create cb_conf_rede
this.cb_gera_codigo=create cb_gera_codigo
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_atualiza
this.Control[iCurrent+2]=this.cb_desbloquear
this.Control[iCurrent+3]=this.cb_bloquear
this.Control[iCurrent+4]=this.cb_trocar_codigo
this.Control[iCurrent+5]=this.cb_extrair
this.Control[iCurrent+6]=this.cb_teste
this.Control[iCurrent+7]=this.cb_status
this.Control[iCurrent+8]=this.cb_consulta
this.Control[iCurrent+9]=this.cb_assinar
this.Control[iCurrent+10]=this.cb_ativar
this.Control[iCurrent+11]=this.cb_conf_rede
this.Control[iCurrent+12]=this.cb_gera_codigo
this.Control[iCurrent+13]=this.gb_1
end on

on w_ge039_funcionalidades_sat.destroy
call super::destroy
destroy(this.cb_atualiza)
destroy(this.cb_desbloquear)
destroy(this.cb_bloquear)
destroy(this.cb_trocar_codigo)
destroy(this.cb_extrair)
destroy(this.cb_teste)
destroy(this.cb_status)
destroy(this.cb_consulta)
destroy(this.cb_assinar)
destroy(this.cb_ativar)
destroy(this.cb_conf_rede)
destroy(this.cb_gera_codigo)
destroy(this.gb_1)
end on

event ue_postopen;call super::ue_postopen;String ls_operador

If gvo_parametro.id_sat_ativa = 'S' Then
	PDV = Create uo_pdv
	
	IF NOT PDV.ivb_modo_teste THEN
		IF Not PDV.of_abreporta() THEN 
			CLOSE(This)
		ELSE
			PDV.ivb_Porta_Aberta = True
			ChangeDirectory( 'c:\sistemas\dll\sat' )
			If Not PDV.ivo_sat.of_abre_doc() Then CLOSE(This)
		END IF			
	ELSE
		This.Title = This.Title + " - [Modo Teste]"
	END IF
	
	If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("W_GE039_FUNCIONALIDADES_SAT", Ref ls_Operador) Then 
		Close(This)	
	End If
	
	If Trim(gvo_parametro.ivs_uf_filial) <> 'SP' Then
		Messagebox("SAT","UF da Filial n$$HEX1$$e300$$ENDHEX$$o usa SAT.", StopSign!)	
		Close(This)
	End If	
Else
	Messagebox("SAT","Par$$HEX1$$e200$$ENDHEX$$metro SAT n$$HEX1$$e300$$ENDHEX$$o ativado na Loja.", StopSign!)
	Close(This)	
End If
end event

event close;call super::close;If IsValid(PDV) Then
	PDV.of_fechaporta()
	Destroy(PDV)
End If
end event

type pb_help from dc_w_response`pb_help within w_ge039_funcionalidades_sat
integer x = 1673
integer y = 448
integer taborder = 140
end type

type cb_atualiza from commandbutton within w_ge039_funcionalidades_sat
integer x = 1266
integer y = 320
integer width = 562
integer height = 108
integer taborder = 130
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Atualizar Software"
end type

event clicked;If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Deseja Atualizar o Software do Equipamento SAT?",Question!,YesNo!,2) = 1 Then	
	If IsNull(gvo_parametro.cd_ativacao_SAT) Or Trim(gvo_parametro.cd_ativacao_SAT) = ''  Then 
		Messagebox("SAT","C$$HEX1$$f300$$ENDHEX$$digo ativa$$HEX2$$e700e300$$ENDHEX$$o do SAT n$$HEX1$$e300$$ENDHEX$$o configurada.", StopSign!)
		Return -1
	End If		
	
	If PDV.ivo_SAT.of_comunica_sat() Then		
		If PDV.ivo_SAT.of_atualizar_software() Then
			MessageBox("SAT", "Atualiza$$HEX2$$e700e300$$ENDHEX$$o de Software ativada com Sucesso!", Information!)				
		End If
	End If
End If
end event

type cb_desbloquear from commandbutton within w_ge039_funcionalidades_sat
integer x = 1266
integer y = 192
integer width = 562
integer height = 108
integer taborder = 120
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Desbloquear SAT"
end type

event clicked;If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Deseja DESBLOQUEAR o equipamento SAT?",Question!,YesNo!,2) = 1 Then	
	If IsNull(gvo_parametro.cd_ativacao_SAT) Or Trim(gvo_parametro.cd_ativacao_SAT) = ''  Then 
		Messagebox("SAT","C$$HEX1$$f300$$ENDHEX$$digo ativa$$HEX2$$e700e300$$ENDHEX$$o do SAT n$$HEX1$$e300$$ENDHEX$$o configurada.", StopSign!)
		Return -1
	End If		
	
	If PDV.ivo_SAT.of_comunica_sat() Then		
		If PDV.ivo_SAT.of_desbloquear_sat() Then
			MessageBox("SAT", "Equipamento SAT Desbloqueado com Sucesso!", Information!)
		End If
	End If
End If
end event

type cb_bloquear from commandbutton within w_ge039_funcionalidades_sat
integer x = 1266
integer y = 64
integer width = 562
integer height = 108
integer taborder = 110
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Bloquer SAT"
end type

event clicked;If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Deseja BLOQUEAR o equipamento SAT?",Question!,YesNo!,2) = 1 Then	
	If IsNull(gvo_parametro.cd_ativacao_SAT) Or Trim(gvo_parametro.cd_ativacao_SAT) = ''  Then 
		Messagebox("SAT","C$$HEX1$$f300$$ENDHEX$$digo ativa$$HEX2$$e700e300$$ENDHEX$$o do SAT n$$HEX1$$e300$$ENDHEX$$o configurada.", StopSign!)
		Return -1
	End If		
	
	If PDV.ivo_SAT.of_comunica_sat() Then		
		If PDV.ivo_SAT.of_bloquear_sat() Then
			MessageBox("SAT", "Equipamento SAT Bloqueado com Sucesso!", Information!)				
		End If
	End If
End If
end event

type cb_trocar_codigo from commandbutton within w_ge039_funcionalidades_sat
integer x = 667
integer y = 320
integer width = 562
integer height = 108
integer taborder = 90
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Trocar C$$HEX1$$f300$$ENDHEX$$digo"
end type

event clicked;String ls_retorno
String ls_codigo
String ls_tipo
String ls_Mensagem_Distribuido
String ls_INI_sat = "C:\Sistemas\CL\SAT\cfesatConfig.ini"
Long 	ll_Regitros

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Deseja Trocar o c$$HEX1$$f300$$ENDHEX$$digo de Ativa$$HEX2$$e700e300$$ENDHEX$$o do SAT?",Question!,YesNo!,2) = 1 Then	
	MessageBox("SAT", "O Sistema de Caixa deve estar Fechado para prosseguir!", Information!)	

	Open(w_ge039_troca_codigo_sat)	
	ls_retorno = Message.StringParm
	
	If Not IsNull(ls_retorno) And Trim(ls_retorno) > '' Then
		ls_tipo 	 		= Trim(gf_captura_valor(ls_retorno, '|', 1, false))
		ls_codigo			= Trim(gf_captura_valor(ls_retorno, '|', 2, false))
		
		If IsNull(gvo_parametro.cd_ativacao_SAT) Or Trim(gvo_parametro.cd_ativacao_SAT) = ''  Then 
			Messagebox("SAT","C$$HEX1$$f300$$ENDHEX$$digo ativa$$HEX2$$e700e300$$ENDHEX$$o do SAT n$$HEX1$$e300$$ENDHEX$$o configurada.", StopSign!)
			Return -1
		End If		
		
		If PDV.ivo_SAT.of_comunica_sat() Then		
			If PDV.ivo_SAT.of_troca_codigo_ativacao(ls_tipo,ls_codigo) Then
				//Atualizar o parametro no banco da loja e no central.
				uo_Parametro_Filial lo_Parametro_Loja // GE036
				lo_Parametro_Loja = Create uo_Parametro_Filial
				If lo_Parametro_Loja.of_Atualiza_parametro( 'CD_ATIVACAO_SAT', ls_codigo ) Then
					SqlCa.Of_Commit()
					gvo_parametro.cd_ativacao_SAT = ls_codigo
					SetProfileString(ls_INI_sat, "CFESAT", "CodigoAtivacao", gvo_parametro.cd_ativacao_SAT)							
				End If
				Destroy lo_Parametro_Loja			
				
				uo_Transacao_Remota lvo_Conexao
				lvo_Conexao = Create uo_Transacao_Remota			
				lvo_Conexao.of_BancoProducao()
				
				If Not lvo_Conexao.of_Update_Registro( "parametro_loja", "vl_parametro= '" + ls_codigo + "'", "cd_filial = " + String( gvo_parametro.cd_filial) + " and cd_parametro = 'CD_ATIVACAO_SAT'", ref ll_Regitros, ref ls_Mensagem_Distribuido ) Then
					Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log, "TROCA de codigo SAT - Erro ao atualizar a informa$$HEX2$$e700e300$$ENDHEX$$o no Central: " + ls_Mensagem_Distribuido)
	//				MessageBox("SAT", "Erro ao atualizar no Central: " + ls_Mensagem_Distribuido,  Exclamation!)
				End If
				Destroy lvo_Conexao			
				
				MessageBox("SAT", "Atualiza$$HEX2$$e700e300$$ENDHEX$$o de c$$HEX1$$f300$$ENDHEX$$digo de ativa$$HEX2$$e700e300$$ENDHEX$$o SAT feita com Sucesso!", Information!)	
			End If
		End If	
	End If
End If
end event

type cb_extrair from commandbutton within w_ge039_funcionalidades_sat
integer x = 667
integer y = 192
integer width = 562
integer height = 108
integer taborder = 70
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Extrair Logs"
end type

event clicked;If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Deseja Extrair log do SAT?",Question!,YesNo!,2) = 1 Then	
	If PDV.ivo_SAT.of_comunica_sat() Then		
		If PDV.ivo_SAT.of_extrair_logs() Then
			MessageBox("SAT", "Logs Extraidos com Sucesso! C:\Sistemas\DLL\sat\sat_log.txt", Information!)				
		End If
	End If
End If
end event

type cb_teste from commandbutton within w_ge039_funcionalidades_sat
integer x = 667
integer y = 64
integer width = 562
integer height = 108
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "TesteFimAFim"
end type

event clicked;If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Fazer o TesteFimAFim com o SAT?",Question!,YesNo!,2) = 1 Then	
	If IsNull(gvo_parametro.cd_ativacao_SAT) Or Trim(gvo_parametro.cd_ativacao_SAT) = ''  Then 
		Messagebox("SAT","C$$HEX1$$f300$$ENDHEX$$digo ativa$$HEX2$$e700e300$$ENDHEX$$o do SAT n$$HEX1$$e300$$ENDHEX$$o configurada.", StopSign!)
		Return -1
	End If		
	
	If PDV.ivo_SAT.of_comunica_sat() Then		
		If PDV.ivo_SAT.of_teste_fimafim() Then
			MessageBox("SAT", "Teste entre AC / SAT e SEFAZ realizado com Sucesso!", Information!)
		End If
	End If
End If
end event

type cb_status from commandbutton within w_ge039_funcionalidades_sat
integer x = 73
integer y = 452
integer width = 562
integer height = 108
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Status Operacional"
end type

event clicked;String ls_Retorno_sat
String ls_Serie
String ls_situacao
String ls_vencto_certif
String ls_status_rede
String ls_data
String ls_hora
String ls_versao_sb
String ls_versao_layout
String ls_msg

If PDV.ivo_sat.of_status_operacional(Ref ls_Retorno_sat) Then
	Sqlca.of_LogDbError(gvo_Aplicacao.ivi_log, "Status Operacional SAT: [" + ls_Retorno_Sat + "]")			
	ls_serie	 			= Trim(gf_captura_valor(ls_retorno_sat, '|', 6, false))
	ls_status_rede		= Trim(gf_captura_valor(ls_retorno_sat, '|', 14, false))
	ls_data				= Trim(gf_captura_valor(ls_retorno_sat, '|', 18, false))
	ls_hora 				= MidA(ls_Data,9,6)
	ls_hora				= MidA(ls_hora,1,2) + ':' + MidA(ls_hora,3,2) + ':' + MidA(ls_hora,5,2)
	ls_Data 				= MidA(ls_Data,7,2)+"/"+MidA(ls_Data,5,2)+"/"+MidA(ls_Data,1,4) +' '+ ls_hora
	ls_versao_sb		= Trim(gf_captura_valor(ls_retorno_sat, '|', 19, false))	
	ls_versao_layout	= Trim(gf_captura_valor(ls_retorno_sat, '|', 20, false))	
	ls_vencto_certif		= Trim(gf_captura_valor(ls_retorno_sat, '|', 27, false))
	ls_vencto_certif 	= MidA(ls_vencto_certif,7,2)+"/"+MidA(ls_vencto_certif,5,2)+"/"+MidA(ls_vencto_certif,1,4)	
	ls_situacao			= Trim(gf_captura_valor(ls_retorno_sat, '|', 28, false))
	Choose Case ls_situacao
		Case "0" //SAT Desbloqueado
			ls_situacao = ls_situacao + ' DESBLOQUEADO'
		Case "1"	
			ls_situacao = ls_situacao + ' BLOQUEADO SEFAZ'			
		Case "2"	
			ls_situacao = ls_situacao + ' BLOQUEADO EMPRESA'			
		Case "3"	
			ls_situacao = ls_situacao + ' BLOQUEADO FABRICA'
	End Choose
	ls_Msg = "Nr. Serie: " + ls_serie + &
				"~r~nStatus Rede: " + ls_status_rede + &
				"~r~nData SAT: " + ls_data + &
				"~r~nVers$$HEX1$$e300$$ENDHEX$$o SB: " + ls_versao_sb + &
				"~r~nVers$$HEX1$$e300$$ENDHEX$$o Layout: " + ls_versao_layout + &
				"~r~nVencimento Certificado: " + ls_vencto_certif + &
				"~r~nSitua$$HEX2$$e700e300$$ENDHEX$$o: " + ls_situacao
	
	Messagebox("SAT Status Operacional",ls_Msg)		
End If

end event

type cb_consulta from commandbutton within w_ge039_funcionalidades_sat
integer x = 73
integer y = 320
integer width = 562
integer height = 108
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Consultar SAT"
end type

event clicked;If PDV.ivo_SAT.of_comunica_sat() Then
	MessageBox("SAT", "Comunica$$HEX2$$e700e300$$ENDHEX$$o com o SAT funcionando.", Information!)		
End If
end event

type cb_assinar from commandbutton within w_ge039_funcionalidades_sat
integer x = 73
integer y = 192
integer width = 567
integer height = 108
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Associar Assinatura"
end type

event clicked;String ls_cnpj_software_house = '84683481000177'

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Deseja associar assinatura ao SAT?",Question!,YesNo!,2) = 1 Then	
	If IsNull(gvo_parametro.cd_ativacao_SAT) Or Trim(gvo_parametro.cd_ativacao_SAT) = ''  Then 
		Messagebox("SAT","C$$HEX1$$f300$$ENDHEX$$digo ativa$$HEX2$$e700e300$$ENDHEX$$o do SAT n$$HEX1$$e300$$ENDHEX$$o configurada.", StopSign!)
		Return -1
	End If		
	
	If PDV.ivo_SAT.of_comunica_sat() Then		
		If PDV.ivo_SAT.of_associar_assinatura(ls_cnpj_software_house, gvo_parametro.nr_cgc) Then
			MessageBox("SAT", "Assinatura associada com Sucesso!", Information!)				
		End If
	End If
End If
end event

type cb_ativar from commandbutton within w_ge039_funcionalidades_sat
integer x = 73
integer y = 64
integer width = 562
integer height = 108
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Ativar SAT"
end type

event clicked;If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Deseja Ativar equipamento SAT?",Question!,YesNo!,2) = 1 Then	
	If IsNull(gvo_parametro.cd_ativacao_SAT) Or Trim(gvo_parametro.cd_ativacao_SAT) = ''  Then 
		Messagebox("SAT","C$$HEX1$$f300$$ENDHEX$$digo ativa$$HEX2$$e700e300$$ENDHEX$$o do SAT n$$HEX1$$e300$$ENDHEX$$o configurada.", StopSign!)
		Return -1
	End If		
	
	If PDV.ivo_SAT.of_comunica_sat() Then
		If PDV.ivo_SAT.of_ativa_sat() Then
			MessageBox("SAT", "SAT ativado com Sucesso!", Information!)				
		End If
	End If
End If
end event

type cb_conf_rede from commandbutton within w_ge039_funcionalidades_sat
integer x = 667
integer y = 452
integer width = 562
integer height = 108
integer taborder = 100
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Verifica Conf. Rede"
end type

event clicked;Boolean pb_varios_parametros
String ls_INI_sat = "C:\Sistemas\CL\SAT\cfesatConfig.ini"
String ls_tipoInter
String ls_tipoLAN
String ls_lanip
String ls_lanMask
String ls_lanGW
String ls_DNS1
String ls_DNS2
String ls_msg_erro
String ls_msg_aviso
String ls_arquivos[]
String ls_retorno_sat

If IsNull(gvo_parametro.cd_ativacao_SAT) Or Trim(gvo_parametro.cd_ativacao_SAT) = ''  Then 
	Messagebox("SAT","C$$HEX1$$f300$$ENDHEX$$digo ativa$$HEX2$$e700e300$$ENDHEX$$o do SAT n$$HEX1$$e300$$ENDHEX$$o configurada.", StopSign!)
	Return -1
End If	

//ls_INI  = gvo_Aplicacao.ivs_Arquivo_INI
//ls_ambiente_sat = ProfileString(ls_INI, "ECF", "Homologacao_NFCE","")

//If Trim(ls_ambiente_sat) = 'S' Then //1 = Normal   -  2 = Homologcao
//	This.id_homologacao = '2'
//Else
//	This.id_homologacao = '1'
//End If

If FileExists(ls_INI_sat) Then
	ls_tipoInter 	= Trim(ProfileString(ls_INI_sat, "CFESATNETWORK", "TipoInter",""))
	ls_tipoLAN 	= Trim(ProfileString(ls_INI_sat, "CFESATNETWORK", "TipoLan",""))
	ls_lanip	 	= Trim(ProfileString(ls_INI_sat, "CFESATNETWORK", "LanIP",""))
	ls_lanMask 	= Trim(ProfileString(ls_INI_sat, "CFESATNETWORK", "LanMask",""))
	ls_lanGW 	= Trim(ProfileString(ls_INI_sat, "CFESATNETWORK", "LanGW",""))	
	ls_DNS1 		= Trim(ProfileString(ls_INI_sat, "CFESATNETWORK", "LanDNS1",""))
	ls_DNS1 		= Trim(ProfileString(ls_INI_sat, "CFESATNETWORK", "LanDNS2",""))	
	
	If IsNull(ls_tipoInter) Or ls_tipoInter = '' Then
		ls_msg_erro = 'O Tipo Internet [TipoInter] n$$HEX1$$e300$$ENDHEX$$o foi definido no arquivo ' + ls_INI_sat
	End If
	If IsNull(ls_tipoLAN) Or ls_tipoLAN = '' Then
		ls_msg_erro = 'O Tipo LAN [TipoLan] n$$HEX1$$e300$$ENDHEX$$o foi definido no arquivo ' + ls_INI_sat
		If ls_msg_erro <> '' Then pb_varios_parametros = True
	End If
	If IsNull(ls_lanip) Or ls_lanip = '' Then
		ls_msg_erro = 'O IP do SAT [LanIP] n$$HEX1$$e300$$ENDHEX$$o foi definido no arquivo ' + ls_INI_sat
		If ls_msg_erro <> '' Then pb_varios_parametros = True		
	End If
	If IsNull(ls_lanMask) Or ls_lanMask = '' Then
		ls_msg_erro = 'A Mascar$$HEX1$$e100$$ENDHEX$$ de rede [LanMask] n$$HEX1$$e300$$ENDHEX$$o foi definido no arquivo ' + ls_INI_sat
		If ls_msg_erro <> '' Then pb_varios_parametros = True
	End If
	If IsNull(ls_lanGW) Or ls_lanGW = '' Then
		ls_msg_erro = 'O Gateway padr$$HEX1$$e300$$ENDHEX$$o [LanGW] n$$HEX1$$e300$$ENDHEX$$o foi definido no arquivo ' + ls_INI_sat
		If ls_msg_erro <> '' Then pb_varios_parametros = True
	End If
	If IsNull(ls_DNS1) Or ls_DNS1 = '' Then
		ls_msg_erro = 'O DNS preferencial [LanDNS1] n$$HEX1$$e300$$ENDHEX$$o foi definido no arquivo ' + ls_INI_sat
		If ls_msg_erro <> '' Then pb_varios_parametros = True
	End If
	If pb_varios_parametros Then
		ls_msg_erro = 'Alguns par$$HEX1$$e200$$ENDHEX$$metros de rede n$$HEX1$$e300$$ENDHEX$$o foram definidos no arquivo ' + ls_INI_sat
	End If
	
	If ls_msg_erro <> '' Then
		Messagebox("SAT",ls_msg_erro+&
					  ". Defina o(s) par$$HEX1$$e200$$ENDHEX$$metro(s) e tente novamente.", StopSign!)
		Return -1		
	End If
	
	ls_msg_aviso = "Dados para configura$$HEX2$$e700e300$$ENDHEX$$o de rede do SAT est$$HEX1$$e300$$ENDHEX$$o corretas?" +&
						"~r~nTipo Internet: " + ls_tipoInter + &
						"~r~nTipo Rede: " + ls_tipoLAN + &
						"~r~nEndere$$HEX1$$e700$$ENDHEX$$o IP: " + ls_lanip + &
						"~r~nMascar$$HEX1$$e100$$ENDHEX$$ de Rede: " + ls_lanMask + &
						"~r~nGateway: " + ls_lanGW + &
						"~r~nDNS 1: " + ls_DNS1 + &
						"~r~nDNS 2: " + ls_DNS2
						
	Messagebox("SAT Configura$$HEX2$$e700e300$$ENDHEX$$o de Rede",ls_msg_aviso)		
Else
	Messagebox("SAT","Arquivo "+ ls_INI_sat +" do SAT n$$HEX1$$e300$$ENDHEX$$o existe no PDV!", StopSign!)	
	Return -1
End If

end event

type cb_gera_codigo from commandbutton within w_ge039_funcionalidades_sat
integer x = 1266
integer y = 452
integer width = 562
integer height = 108
integer taborder = 60
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "C$$HEX1$$f300$$ENDHEX$$digo Vincula$$HEX2$$e700e300$$ENDHEX$$o"
end type

event clicked;String ls_cnpj_software_house = '84683481000177'
String ls_cnpj
String	ls_fantasia
String ls_cabecalho
String ls_Titulo
String ls_To[]
String ls_Cc[]
String ls_Co[]
String ls_codigo
String ls_Msg
String ls_retorno

Long ll_filial
Long ll_retorno
Long ll_row
Long ll_Ind_To
Long ll_Ind_Cc
Long ll_Ind_Co

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O certificado digital da CLAMED est$$HEX1$$e100$$ENDHEX$$ instalado no PDV?",Question!,YesNo!,2) = 1 Then
	
	Open(w_ge039_cnpj_sat)	
	ls_cnpj = Message.StringParm
	
	If Not IsNull(ls_cnpj) And Trim(ls_cnpj) > '' Then
		
		Select cd_filial, nm_fantasia Into :ll_filial, :ls_fantasia
		From filial
		Where nr_cgc = :ls_cnpj
		Using SqlCa;

		Choose Case Sqlca.SqlCode
			Case 100
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "CNPJ Informado ainda n$$HEX1$$e300$$ENDHEX$$o cadastro no sistema.", StopSign!)
				Return -1
			Case -1
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao localizar Filial." + SqlCa.SqlErrText, StopSign!)
				Return -1
		End Choose			
		
		If PDV.ivo_SAT.of_gera_codigo_vinculacao(ls_cnpj_software_house, ls_cnpj, Ref ls_codigo) Then
			
			ls_Cabecalho = "<font face='verdana' size='1'>'Este $$HEX1$$e900$$ENDHEX$$ um email autom$$HEX1$$e100$$ENDHEX$$tico. Favor n$$HEX1$$e300$$ENDHEX$$o responder esta mensagem.'</font><br /><br />" + &	
						 "Filial: " + String(ll_filial) + " CNPJ: " + ls_cnpj + "<p><p>"

			ls_msg ="Foi gerado o C$$HEX1$$f300$$ENDHEX$$digo de Vincula$$HEX2$$e700e300$$ENDHEX$$o SAT para a Filial: " + String(ll_filial) + &
						" - " + ls_fantasia + ". Favor cadastrar no SEFAZ SP." +  "<p><p>"  + &
						Trim(ls_codigo)
			
			dc_uo_ds_Base lvds_1
			lvds_1 = Create dc_uo_ds_Base
			
			If Not lvds_1.of_ChangeDataObject("ds_ge039_email_envio") Then
				Destroy(lvds_1)
			Else
				lvds_1.of_AppendWhere("m.cd_mensagem = 45")	
		
				uo_Transacao_Remota lvo_Conexao
				lvo_Conexao = Create uo_Transacao_Remota
				
				lvo_Conexao.of_BancoProducao()
				
				lvo_Conexao.of_Retrieve(lvds_1.GetSQLSelect(), Ref ls_Retorno)
				
				If lvo_Conexao.of_Erro_Execucao() Or lvo_Conexao.of_Erro_Conexao() Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro na conex$$HEX1$$e300$$ENDHEX$$o com o servidor distribu$$HEX1$$ed00$$ENDHEX$$do.")
					ll_Retorno = 0
				Else
					If IsNull(ls_Retorno) Or Trim(ls_Retorno) = '' Then
						ll_Retorno = 0
					Else
						ll_Retorno = lvds_1.ImportString(ls_Retorno)
						
						If ll_Retorno >= 0 Then
							ll_Row = 0
							For ll_Row = 1 To lvds_1.RowCount()
								ls_Titulo = lvds_1.Object.de_assunto[ll_Row] + ": Filial " + String(ll_filial)					
			
								Choose Case lvds_1.Object.id_tipo_envio[ll_Row]
									Case 'TO'
										ll_Ind_To ++
										ls_To[ll_Ind_To] = lvds_1.Object.de_email[ll_Row]							
									Case 'CC'
										ll_Ind_Cc ++
										ls_Cc[ll_Ind_Cc] = lvds_1.Object.de_email[ll_Row]							
									Case 'CO'
										ll_Ind_Co ++
										ls_Co[ll_Ind_Co] = lvds_1.Object.de_email[ll_Row]														
								End Choose						
							Next
							
							uo_smtp lvo_smtp
							lvo_smtp = Create uo_smtp
												
							lvo_Smtp.ib_grava_log_db = False
		
							lvo_smtp.of_envia_email("ALERTA DE SISTEMA", &
														  "sistemas@clamed.com.br", + &
														  ls_Titulo, + &
														  ls_cabecalho + ls_Msg, + &
														  ls_To,ls_Cc,ls_Co)										
						Else
							MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar os dados do servidor distribu$$HEX1$$ed00$$ENDHEX$$do.")
						End If
					End If
				End If		
			End If
			
			Destroy(lvo_Conexao)
			Destroy(lvds_1)	
			Destroy(lvo_smtp)				
			
			MessageBox("SAT", "C$$HEX1$$f300$$ENDHEX$$digo gerado e e-mail enviado!!~r~n" + &
									 ls_codigo, Information!)
		End If
	End If	

End If


end event

type gb_1 from groupbox within w_ge039_funcionalidades_sat
event mousemove pbm_mousemove
integer x = 32
integer width = 1847
integer height = 608
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

