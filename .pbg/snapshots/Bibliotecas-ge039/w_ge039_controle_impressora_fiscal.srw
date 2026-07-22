HA$PBExportHeader$w_ge039_controle_impressora_fiscal.srw
forward
global type w_ge039_controle_impressora_fiscal from window
end type
type cb_cat52 from commandbutton within w_ge039_controle_impressora_fiscal
end type
type cb_numero_sorte from commandbutton within w_ge039_controle_impressora_fiscal
end type
type cb_transacao_pendente from commandbutton within w_ge039_controle_impressora_fiscal
end type
type cb_mapa_resumo from commandbutton within w_ge039_controle_impressora_fiscal
end type
type st_data_hota from statictext within w_ge039_controle_impressora_fiscal
end type
type st_2 from statictext within w_ge039_controle_impressora_fiscal
end type
type st_funcao from statictext within w_ge039_controle_impressora_fiscal
end type
type cb_horario_verao from commandbutton within w_ge039_controle_impressora_fiscal
end type
type cb_configuracao from commandbutton within w_ge039_controle_impressora_fiscal
end type
type cb_parametros from commandbutton within w_ge039_controle_impressora_fiscal
end type
type cb_leitura_mf from commandbutton within w_ge039_controle_impressora_fiscal
end type
type cb_cancela_cupom from commandbutton within w_ge039_controle_impressora_fiscal
end type
type cb_mfd_mensal from commandbutton within w_ge039_controle_impressora_fiscal
end type
type cb_data_hora_atual from commandbutton within w_ge039_controle_impressora_fiscal
end type
type cb_reducaoz from commandbutton within w_ge039_controle_impressora_fiscal
end type
type cb_leiturax from commandbutton within w_ge039_controle_impressora_fiscal
end type
type gb_1 from groupbox within w_ge039_controle_impressora_fiscal
end type
end forward

global type w_ge039_controle_impressora_fiscal from window
integer x = 1390
integer y = 1076
integer width = 1929
integer height = 1160
boolean titlebar = true
string title = "GE039 - Fun$$HEX2$$e700f500$$ENDHEX$$es de Controle da Impressora Fiscal"
boolean controlmenu = true
windowtype windowtype = response!
long backcolor = 80269524
cb_cat52 cb_cat52
cb_numero_sorte cb_numero_sorte
cb_transacao_pendente cb_transacao_pendente
cb_mapa_resumo cb_mapa_resumo
st_data_hota st_data_hota
st_2 st_2
st_funcao st_funcao
cb_horario_verao cb_horario_verao
cb_configuracao cb_configuracao
cb_parametros cb_parametros
cb_leitura_mf cb_leitura_mf
cb_cancela_cupom cb_cancela_cupom
cb_mfd_mensal cb_mfd_mensal
cb_data_hora_atual cb_data_hora_atual
cb_reducaoz cb_reducaoz
cb_leiturax cb_leiturax
gb_1 gb_1
end type
global w_ge039_controle_impressora_fiscal w_ge039_controle_impressora_fiscal

type variables

end variables

forward prototypes
public subroutine wf_atualiza_data_fiscal ()
public subroutine wf_cancela_cupom_aberto ()
public subroutine wf_datahora ()
public function boolean wf_exibe_data_hora ()
public subroutine wf_leiturax ()
public subroutine wf_reducaoz ()
public subroutine wf_configura_modalidades_pagto ()
public subroutine wf_legenda_nao_fiscal ()
public subroutine wf_parametros ()
public subroutine wf_configura_legenda_nao_fiscal ()
public subroutine wf_configura_venda_bruta ()
public function boolean wf_horario_verao ()
public subroutine wf_reducaoz_old ()
public subroutine wf_grava_mapa_resumo ()
public subroutine wf_transacao_tef_pendente ()
public subroutine wf_numero_sorte ()
end prototypes

public subroutine wf_atualiza_data_fiscal ();//
DateTime ldt_data
//
IF NOT PDV.of_abreporta() THEN
	RETURN
END IF
//

ldt_data = PDV.of_dh_movimentacao()

PDV.of_gera_espelho_mfd_mensal(PDV.ecf, Date(ldt_data))

Return

//IF NOT PDV.of_Atualiza_Data_Fiscal() THEN
//	RETURN
//END IF

end subroutine

public subroutine wf_cancela_cupom_aberto ();String ls_Usuario


If Not PDV.Of_Verifica_Problemas_Impressora() Then Return

If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("CANCELAMENTO_CUPOM_FISCAL", Ref ls_Usuario) Then Return

PDV.Of_Cancela_Ultimo_Cupom(True,ls_Usuario)

end subroutine

public subroutine wf_datahora ();//
//IF NOT PDV.of_AbrePorta() THEN RETURN
//
Wf_exibe_data_hora()
//
//PDV.of_FechaPorta()
//

end subroutine

public function boolean wf_exibe_data_hora ();
Date   ldt_dataecf
Date   ldt_datafiscal
Date   ldt_datareducaoz
String ls_hora
String ls_Msg

If Not PDV.Of_HoraEcf(Ref ls_Hora)          Then Return False
If Not PDV.of_dataecf(Ref ldt_dataecf)       Then Return False
If Not PDV.of_datafiscal(Ref ldt_datafiscal) Then Return False

ls_Msg = "Data Corrente : " + String(ldt_dataecf) + "~r~nHora Corrente : " + ls_hora

If ldt_datafiscal = Date("1900/01/01") Then
	
	If Not PDV.of_data_ultima_reducaoz(Ref ldt_datareducaoz) Then Return False
	
  	ls_Msg += "~r~nData $$HEX1$$da00$$ENDHEX$$ltima Redu$$HEX2$$e700e300$$ENDHEX$$o Z : " + String(ldt_datareducaoz) + "~r~r N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio efetuar redu$$HEX2$$e700e300$$ENDHEX$$o Z (sem movimenta$$HEX2$$e700e300$$ENDHEX$$o)."
	
Else              
	
	ls_Msg += "~r~nData Fiscal : " + String(ldt_datafiscal)
	
End If

Messagebox("Impressora Fiscal",ls_Msg)

Return true

end function

public subroutine wf_leiturax ();//
IF messagebox ("Aten$$HEX2$$e700e300$$ENDHEX$$o","Confirma leitura X ?",Question!, YesNo!, 1) = 2 THEN RETURN
//
IF NOT PDV.of_AbrePorta() THEN
	RETURN
END IF
//
PDV.of_leiturax(False)
//
//PDV.of_fechaporta()
//
end subroutine

public subroutine wf_reducaoz ();PDV.of_reducaoz()

end subroutine

public subroutine wf_configura_modalidades_pagto ();STRING lvs_Reducao, lvs_Transacao
//
IF NOT PDV.of_abreporta() THEN
	RETURN
END IF
//
lvs_Reducao   = PDV.of_parametro28("REDUCAO")
lvs_Transacao = PDV.of_parametro28("TRANSA")
//
//PDV.of_fechaporta()
//

end subroutine

public subroutine wf_legenda_nao_fiscal ();//

//If Not PDV.of_AbrePorta() Then Return
//
//PDV.of_fechaporta()
//
end subroutine

public subroutine wf_parametros ();//
//If Not PDV.of_AbrePorta() Then Return
//
//PDV.of_fechaporta()
//
end subroutine

public subroutine wf_configura_legenda_nao_fiscal ();//
//If Not PDV.of_AbrePorta() Then Return
//
//PDV.of_fechaporta()
//
end subroutine

public subroutine wf_configura_venda_bruta ();//
//If Not PDV.of_AbrePorta() Then Return
//
If PDV.of_Atualiza_Venda_Bruta(False) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Atualiza$$HEX2$$e700e300$$ENDHEX$$o efetuada com sucesso.")
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Atualiza$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o efetuada.",StopSign!)
End If	
//
//PDV.of_fechaporta()
//
end subroutine

public function boolean wf_horario_verao ();
Boolean lb_Sucesso

//If Not PDV.of_abreporta() Then Return False

lb_Sucesso = PDV.of_horario_verao()

//PDV.of_fechaporta()

Return lb_Sucesso
end function

public subroutine wf_reducaoz_old ();BOOLEAN lvb_Mapa_Resumo

If messagebox ("Aten$$HEX2$$e700e300$$ENDHEX$$o","Confirma Redu$$HEX2$$e700e300$$ENDHEX$$o Z ?",Question!, YesNo!, 1) = 2 Then Return 

uo_mapa_resumo lvo_mapa_resumo
lvo_mapa_resumo = Create uo_mapa_resumo

lvb_Mapa_Resumo = lvo_mapa_resumo.of_gravacao_mapa_resumo_ok()

IF NOT lvb_Mapa_Resumo THEN

	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel ler os totalizadores da impressora Fiscal.~nDesligue e ligue a impressora, depois tente novamente.",Exclamation!)

	Return

End If

If Not PDV.of_abreporta() Then Return

If Not PDV.of_reducaoz() Then
	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o foi possivel executar redu$$HEX2$$e700e300$$ENDHEX$$o 'Z'. Mapa Resumo n$$HEX1$$e300$$ENDHEX$$o foi gravado.",StopSign!)
	
Else
	
	//Aguarda 10 segundos ...
	gf_delay(10)
	
	PDV.of_Atualiza_Venda_Bruta(True)

End If

PDV.of_fechaporta()

Destroy(lvo_mapa_resumo)

end subroutine

public subroutine wf_grava_mapa_resumo ();//PDV.of_abreporta() 

If Not PDV.of_Grava_Mapa_Resumo(Datetime(Today())) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$c300$$ENDHEX$$O foi gravado o mapa resumo !",StopSign!)
End If

If IsValid(w_janela_aguarde) Then CLOSE(w_janela_aguarde)

/*Date ldt_Data_Fis

If Not PDV.of_data_ultima_reducaoz(Ref ldt_Data_Fis) Then
	PDV.of_fechaporta()
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$c300$$ENDHEX$$O foi gravado o mapa resumo !",StopSign!)
	Return
End If

uo_mapa_resumo lvo_mapa_resumo
lvo_mapa_resumo = Create uo_mapa_resumo

lvo_mapa_resumo.dh_fiscal = ldt_Data_Fis

If lvo_mapa_resumo.of_gravacao_mapa_resumo_ok() Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Mapa Resumo gravado com sucesso !")

End If

If IsValid(w_janela_aguarde) Then CLOSE(w_janela_aguarde)

Destroy(lvo_mapa_resumo)*/
end subroutine

public subroutine wf_transacao_tef_pendente ();Long lvl_ECF
Long lvl_Transacao

If PDV.of_Nr_Ecf(Ref lvl_ECF) Then
	Delete transacao_tef
	 Where nr_ecf = :lvl_ECF
	 Using SQLCa;			 
		 
	If SQLCa.SQLNRows > 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Transa$$HEX2$$e700f500$$ENDHEX$$es TEF do ECF '" + String(lvl_ECF) + "' exclu$$HEX1$$ed00$$ENDHEX$$das com sucesso.")
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma transacao TEF pendente para o ECF " + String(lvl_ECF) + ".")
	End If	
End If


If SQLCa.SQLNRows > 0 Then
	SQLCa.of_Commit()
End If
end subroutine

public subroutine wf_numero_sorte ();Long ll_Nota, &
	   ll_Row, &
	   ll_Row_Sorte, &
	   ll_ind
		
Decimal {2} ldc_Total_Produtos, &
				ldc_pc_desconto_nf, &
				ldc_Preco_Praticado		

String ls_comprovante[], &
		 ls_valor, &
		 ls_cliente, &
		 ls_nome_cliente

If Not PDV.Of_Verifica_Problemas_Impressora() Then Return

/*Open(w_ge039_numero_sorte)

ll_Nota = Message.DoubleParm

If Not IsNull(ll_nota) And ll_Nota <> 0 Then
	dc_uo_ds_Base lds_Sorteio 
	lds_Sorteio = Create dc_uo_ds_Base 
	
	lds_Sorteio.of_ChangeDataObject('dw_ge039_numeros_sorte')
	lds_Sorteio.Retrieve(gvo_parametro.cd_filial,ll_nota)
	
	If lds_Sorteio.RowCount() > 0 Then	
		
		dc_uo_ds_Base lds_Itens
		lds_Itens = Create dc_uo_ds_Base 
		
		lds_Itens.of_ChangeDataObject('dw_ge039_itens_nf_sorte')
		lds_Itens.Retrieve(gvo_parametro.cd_filial,ll_nota)
		
		If lds_Itens.RowCount() > 0 Then
			
			For ll_Row = 1 To lds_Itens.RowCount()							
		
				//Aplica desconto sub_total no valor do produto.
				If lds_Itens.object.pc_desconto_nf[ll_row] > 0 Then		
					ldc_Preco_Praticado = Round(lds_Itens.object.vl_preco_praticado[ll_row] * ( 1 - ( lds_Itens.object.pc_desconto_nf[ll_row] / 100 ) ) ,2 )
				Else
					ldc_Preco_Praticado = lds_Itens.object.vl_preco_praticado[ll_row]
				End If			
				
				ldc_Total_Produtos += Round( lds_Itens.object.qt_vendida[ll_row] * ldc_Preco_Praticado ,2)
			Next
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Nota Informada n$$HEX1$$e300$$ENDHEX$$o Itens v$$HEX1$$e100$$ENDHEX$$lidos!", Information!)
			Destroy(lds_Sorteio)
			Destroy(lds_Itens)
			Return			
		End If
		
		//Monta texto da ECF
		ls_Valor  	= STRING(ldc_Total_Produtos, "###,##0.00")
		
		ll_ind ++; ls_comprovante[ll_ind] = "Qual a rede de farm$$HEX1$$e100$$ENDHEX$$cias que cuida de voc$$HEX1$$ea00$$ENDHEX$$?"
		ll_ind ++; ls_comprovante[ll_ind] = "( X ) Drogaria Catarinense    (   ) Outros"
		ll_ind ++; ls_comprovante[ll_ind] = space(50)
		ll_ind ++; ls_comprovante[ll_ind] = Fill(" ",13) + "Distribui$$HEX2$$e700e300$$ENDHEX$$o Gratuita" 
		ll_ind ++; ls_comprovante[ll_ind] = space(50)
		ll_ind ++; ls_comprovante[ll_ind] = Fill(" ",17) + "NATAL DE PR$$HEX1$$ca00$$ENDHEX$$MIOS"
		ll_ind ++; ls_comprovante[ll_ind] = Fill(" ",14) + "DROGARIA CATARINENSE"
		ll_ind ++; ls_comprovante[ll_ind] = space(50)
		ll_ind ++; ls_comprovante[ll_ind] = "Ref. Cupom Fiscal (DOC) " + String(ll_Nota)
		ll_ind ++; ls_comprovante[ll_ind] = "Valor Total de N$$HEX1$$e300$$ENDHEX$$o medicamentos: R$ " + ls_valor
		ll_ind ++; ls_comprovante[ll_ind] = space(50)
		ll_ind ++; ls_comprovante[ll_ind] = space(50)
		ll_ind ++; ls_comprovante[ll_ind] = "N$$HEX1$$fa00$$ENDHEX$$mero(s) da Sorte Gerado(s)"		
		
		uo_cliente  lvo_cliente		
		lvo_Cliente = Create uo_Cliente
		
		ls_Cliente = lds_Sorteio.object.cd_cliente[1]
		lvo_Cliente.of_Localiza_Codigo(ls_Cliente)
		
		ls_nome_Cliente = lvo_Cliente.nm_cliente		
		Destroy(lvo_Cliente)
		
		For ll_Row_Sorte = 1 To lds_Sorteio.RowCount()
			ll_ind ++; ls_comprovante[ll_ind] = Fill(" ",6) + lds_Sorteio.object.nr_sorte[ll_Row_Sorte]

		Next
		
		ll_ind ++; ls_comprovante[ll_ind] = space(50)
		ll_ind ++; ls_comprovante[ll_ind] = space(50)
		ll_ind ++; ls_comprovante[ll_ind] = "Pertencente ao Cliente:"
		ll_ind ++; ls_comprovante[ll_ind] = ls_nome_cliente	
		ll_ind ++; ls_comprovante[ll_ind] = space(50)
		ll_ind ++; ls_comprovante[ll_ind] = "Certificado de Autoriza$$HEX2$$e700e300$$ENDHEX$$o CAIXA n$$HEX1$$ba00$$ENDHEX$$ 4-1823/2013"
		ll_ind ++; ls_comprovante[ll_ind] = space(50)
		ll_ind ++; ls_comprovante[ll_ind] = Fill(" ",10) + "Sorteio dia 04/01/2014."
		ll_ind ++; ls_comprovante[ll_ind] = "Regulamento disponivel nas Drogarias Catarinense"
		ll_ind ++; ls_comprovante[ll_ind] = "ou no site: www.drogariacatarinense.com.br"				

		Destroy(lds_Sorteio)
		Destroy(lds_Itens)	
		
		Sitef = Create uo_Sitef
		
		If Not pdv.of_emite_comprovante("VIA RECIBO",ls_comprovante) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel imprimir n$$HEX1$$fa00$$ENDHEX$$meros da Sorte.",StopSign!)
		End If		
		
		Destroy(Sitef)
		
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Nota Informada n$$HEX1$$e300$$ENDHEX$$o possui n$$HEX1$$fa00$$ENDHEX$$mero(s) da Sorte!", Information!)
		Destroy(lds_Sorteio)
		Return
	End If	
End If */

//TESTES RELATORIO GERENCIAL

		ll_ind ++; ls_comprovante[ll_ind] = "Ol$$HEX1$$e100$$ENDHEX$$, ADMOCIR SANT'ANA SILVA,"
		ll_ind ++; ls_comprovante[ll_ind] = "portador do CPF 123XXXXXX45!"
		ll_ind ++; ls_comprovante[ll_ind] = "Voc$$HEX1$$ea00$$ENDHEX$$ consentiu para que a CLAMED possa"
		ll_ind ++; ls_comprovante[ll_ind] = "utilizar os seus dados pessoais nas"
		ll_ind ++; ls_comprovante[ll_ind] = "atividades selecionadas abaixo,"
		ll_ind ++; ls_comprovante[ll_ind] = "com o objetivo de oferecermos servi$$HEX1$$e700$$ENDHEX$$os e"
		ll_ind ++; ls_comprovante[ll_ind] = "atendimento personalizado."
		ll_ind ++; ls_comprovante[ll_ind] = space(50)
		ll_ind ++; ls_comprovante[ll_ind] = "(X) Registro de seu hist$$HEX1$$f300$$ENDHEX$$rico de compras"
		ll_ind ++; ls_comprovante[ll_ind] = Fill(" ",4)+"para acesso ao Clube de benef$$HEX1$$ed00$$ENDHEX$$cios."
		ll_ind ++; ls_comprovante[ll_ind] = "(X) Pesquisas e estudos de comportamento de compras"
		ll_ind ++; ls_comprovante[ll_ind] = "( ) Cadastro nos programas de uso cont$$HEX1$$ed00$$ENDHEX$$nuo"
		ll_ind ++; ls_comprovante[ll_ind] = Fill(" ",4)+"de medicamentos da ind$$HEX1$$fa00$$ENDHEX$$stria farmac$$HEX1$$ea00$$ENDHEX$$utica."
		ll_ind ++; ls_comprovante[ll_ind] = "Comunica$$HEX2$$e700e300$$ENDHEX$$o e Marketing"
		ll_ind ++; ls_comprovante[ll_ind] = Fill(" ",4)+"( ) Envio de SMS e Whatsapp"
		ll_ind ++; ls_comprovante[ll_ind] = Fill(" ",4)+"(X) Envio e-mail marketing"
		ll_ind ++; ls_comprovante[ll_ind] = Fill(" ",4)+"( ) Contato por telefone"
		ll_ind ++; ls_comprovante[ll_ind] = Fill(" ",4)+"( ) Correspond$$HEX1$$ea00$$ENDHEX$$ncia"		
		ll_ind ++; ls_comprovante[ll_ind] = space(50)
		
		ll_ind ++; ls_comprovante[ll_ind] = "Voc$$HEX1$$ea00$$ENDHEX$$ pode alterar as autoriza$$HEX2$$e700f500$$ENDHEX$$es acima"
		ll_ind ++; ls_comprovante[ll_ind] = "a qualquer momento em nossas lojas,"
		ll_ind ++; ls_comprovante[ll_ind] = "acessando sua conta online pelo site ou"
		ll_ind ++; ls_comprovante[ll_ind] = "aplicativo ou atrav$$HEX1$$e900$$ENDHEX$$s do Portal de"
		ll_ind ++; ls_comprovante[ll_ind] = "Privacidade da CLAMED."
		ll_ind ++; ls_comprovante[ll_ind] = "Para obter mais informa$$HEX2$$e700f500$$ENDHEX$$es sobre o"
		ll_ind ++; ls_comprovante[ll_ind] = "tratamento dos dados pessoais e/ou"
		ll_ind ++; ls_comprovante[ll_ind] = "exercer os seus direitos, acesse o nosso"
		ll_ind ++; ls_comprovante[ll_ind] = "Portal da Privacidade atrav$$HEX1$$e900$$ENDHEX$$s do site"
		ll_ind ++; ls_comprovante[ll_ind] = "https://www.clamed.com.br/portal-da-privacidade/"		
		
		Sitef = Create uo_Sitef
		If Not pdv.of_emite_comprovante("VIA RECIBO",ls_comprovante) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel imprimir.",StopSign!)
		End If		
		Destroy(Sitef)
end subroutine

on w_ge039_controle_impressora_fiscal.create
this.cb_cat52=create cb_cat52
this.cb_numero_sorte=create cb_numero_sorte
this.cb_transacao_pendente=create cb_transacao_pendente
this.cb_mapa_resumo=create cb_mapa_resumo
this.st_data_hota=create st_data_hota
this.st_2=create st_2
this.st_funcao=create st_funcao
this.cb_horario_verao=create cb_horario_verao
this.cb_configuracao=create cb_configuracao
this.cb_parametros=create cb_parametros
this.cb_leitura_mf=create cb_leitura_mf
this.cb_cancela_cupom=create cb_cancela_cupom
this.cb_mfd_mensal=create cb_mfd_mensal
this.cb_data_hora_atual=create cb_data_hora_atual
this.cb_reducaoz=create cb_reducaoz
this.cb_leiturax=create cb_leiturax
this.gb_1=create gb_1
this.Control[]={this.cb_cat52,&
this.cb_numero_sorte,&
this.cb_transacao_pendente,&
this.cb_mapa_resumo,&
this.st_data_hota,&
this.st_2,&
this.st_funcao,&
this.cb_horario_verao,&
this.cb_configuracao,&
this.cb_parametros,&
this.cb_leitura_mf,&
this.cb_cancela_cupom,&
this.cb_mfd_mensal,&
this.cb_data_hora_atual,&
this.cb_reducaoz,&
this.cb_leiturax,&
this.gb_1}
end on

on w_ge039_controle_impressora_fiscal.destroy
destroy(this.cb_cat52)
destroy(this.cb_numero_sorte)
destroy(this.cb_transacao_pendente)
destroy(this.cb_mapa_resumo)
destroy(this.st_data_hota)
destroy(this.st_2)
destroy(this.st_funcao)
destroy(this.cb_horario_verao)
destroy(this.cb_configuracao)
destroy(this.cb_parametros)
destroy(this.cb_leitura_mf)
destroy(this.cb_cancela_cupom)
destroy(this.cb_mfd_mensal)
destroy(this.cb_data_hora_atual)
destroy(this.cb_reducaoz)
destroy(this.cb_leiturax)
destroy(this.gb_1)
end on

event open;String ls_Matricula_Abertura_Tela

If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("W_GE039_CONTROLE_IMPRESSORA_FISCAL", ref ls_Matricula_Abertura_Tela) Then 
	CLOSE(This)
	Return
End If

cb_Horario_Verao.Visible = False
cb_Numero_Sorte.Visible = False

//
Timer(60)
//
String ls_Rede_Filial, ls_MFD
DateTime ldt_Data_Servidor

This.Event Timer()

//Cria Diretorio para os arquivos da ECF - Legisla$$HEX2$$e700e300$$ENDHEX$$o CAT-52 - SP
dc_uo_api lo_api
lo_api = Create dc_uo_api	
lo_api.of_create_directory('C:\Sistemas\RL\Arquivos\ECF')
Destroy(lo_api)				

PDV = Create uo_pdv

IF NOT PDV.ivb_modo_teste THEN
	//
	IF PDV.of_abreporta() THEN
		//
		If Not PDV.of_atualiza_cadastro_ecf() Then CLOSE(This)
		//		
		
//		If Trim(gvo_parametro.ivs_uf_filial) = 'SP' Then
//			cb_cat52.Visible = True
//		End If						

	ELSE
		CLOSE(This)
	END IF	
	//
ELSE
	cb_data_hora_atual.enabled             = False
	cb_leiturax.enabled					    = False
	cb_reducaoz.enabled					    = False
	cb_mfd_mensal.enabled				    = False
	cb_cancela_cupom.enabled			    = False
	cb_leitura_mf.enabled  					= False
	cb_parametros.enabled                    = False
	cb_configuracao.enabled                  = False
	cb_mapa_resumo.Enabled 				= False
	//
	This.Title = This.Title + " - [Modo Teste]"
	//
END IF	
end event

event close;If IsValid(PDV) Then PDV.of_fechaporta()
If IsValid(PDV) Then Destroy(PDV)
end event

event timer;
st_data_hota.text = String(Today(), "dd/mm/yyyy hh:mm")
end event

type cb_cat52 from commandbutton within w_ge039_controle_impressora_fiscal
integer x = 1266
integer y = 492
integer width = 562
integer height = 112
integer taborder = 130
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "MFD Cotepe"
end type

event getfocus;//
this.default = TRUE
//
//st_funcao.text = 'Ajuste de Hor$$HEX1$$e100$$ENDHEX$$rio de Ver$$HEX1$$e300$$ENDHEX$$o.'
end event

event losefocus;//
this.default = FALSE
//
end event

event clicked;//****CAT 52 n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio mais ser gerado.******
//Bot$$HEX1$$e300$$ENDHEX$$o agora gera Arq. MFD cotepe 17/04.
DateTime ldt_data

IF NOT PDV.of_abreporta() THEN
	RETURN
END IF

ldt_data = PDV.of_dh_movimentacao()

PDV.of_gera_cotepe_mensal(PDV.ecf, Date(ldt_data))

Return

//
//
//Boolean lb_sucesso
//String ls_parametro
//String ls_destino
//
//OpenWithParm(w_ge039_cat52,ls_Parametro)
//
//ls_Parametro = Message.StringParm
//
//If IsDate(ls_Parametro) Then	
//	
//	Open(w_janela_aguarde)
//	w_janela_aguarde.mle_1.text = "Gerando arquivo CAT52..."
//
//	lb_Sucesso = PDV.of_gera_CAT52('',Date(ls_parametro), Ref ls_destino)
//	
//	If lb_Sucesso Then
//		ls_destino = gf_replace(ls_destino, '/', '\', 0)
//		
//		dc_uo_zip lo_Zip
//		lo_Zip = Create dc_uo_zip			
//		lo_zip.of_zip(ls_destino, ls_destino + '.zip')		
//		Destroy(lo_zip)
//		
//		FileDelete(ls_destino)
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Arquivo Gerado com Sucesso! " + ls_destino + ".zip")		
//	Else
//		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro na gera$$HEX2$$e700e300$$ENDHEX$$o do arquivo!")		
//	End If
//	
//	Close(w_Janela_Aguarde)		
//End If

end event

type cb_numero_sorte from commandbutton within w_ge039_controle_impressora_fiscal
integer x = 69
integer y = 496
integer width = 562
integer height = 108
integer taborder = 110
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&N$$HEX1$$fa00$$ENDHEX$$mero da Sorte"
end type

event clicked;//
IF NOT PDV.of_AbrePorta() THEN RETURN
//
wf_numero_sorte()
//
PDV.of_FechaPorta()
//
end event

event getfocus;//
this.default = TRUE
//
st_funcao.text = "Reimpress$$HEX1$$e300$$ENDHEX$$o N$$HEX1$$fa00$$ENDHEX$$mero da Sorte"
end event

event losefocus;//
this.default = FALSE
//
end event

type cb_transacao_pendente from commandbutton within w_ge039_controle_impressora_fiscal
boolean visible = false
integer x = 667
integer y = 496
integer width = 562
integer height = 112
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "&Trans. Pendente"
end type

event clicked;
wf_Transacao_Tef_Pendente()

end event

event getfocus;//
this.default = TRUE
//
st_funcao.text = 'Apagar transa$$HEX2$$e700f500$$ENDHEX$$es TEF que est$$HEX1$$e300$$ENDHEX$$o pendente.'
end event

event losefocus;//
this.default = False
//
end event

type cb_mapa_resumo from commandbutton within w_ge039_controle_impressora_fiscal
integer x = 1266
integer y = 356
integer width = 562
integer height = 112
integer taborder = 100
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Mapa Resumo"
end type

event clicked;
wf_Grava_Mapa_Resumo()

end event

event getfocus;//
this.default = TRUE
//
st_funcao.text = 'Gerar mapa resumo.'
end event

event losefocus;//
this.default = False
//
end event

type st_data_hota from statictext within w_ge039_controle_impressora_fiscal
integer x = 640
integer y = 972
integer width = 635
integer height = 76
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "none"
boolean focusrectangle = false
end type

type st_2 from statictext within w_ge039_controle_impressora_fiscal
integer x = 32
integer y = 972
integer width = 567
integer height = 76
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "DATA - HORA PDV: "
boolean focusrectangle = false
end type

type st_funcao from statictext within w_ge039_controle_impressora_fiscal
integer x = 73
integer y = 636
integer width = 1760
integer height = 268
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
boolean enabled = false
string text = "none"
boolean border = true
borderstyle borderstyle = styleraised!
boolean focusrectangle = false
end type

type cb_horario_verao from commandbutton within w_ge039_controle_impressora_fiscal
integer x = 672
integer y = 492
integer width = 562
integer height = 112
integer taborder = 120
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Hor$$HEX1$$e100$$ENDHEX$$rio de Ver$$HEX1$$e300$$ENDHEX$$o"
end type

event clicked;
wf_horario_verao()

end event

event getfocus;//
this.default = TRUE
//
st_funcao.text = 'Ajuste de Hor$$HEX1$$e100$$ENDHEX$$rio de Ver$$HEX1$$e300$$ENDHEX$$o.'
end event

event losefocus;//
this.default = False
//
end event

type cb_configuracao from commandbutton within w_ge039_controle_impressora_fiscal
integer x = 1266
integer y = 216
integer width = 562
integer height = 112
integer taborder = 90
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Configura$$HEX2$$e700e300$$ENDHEX$$o"
end type

event clicked;
wf_configura_venda_bruta()

end event

event getfocus;//
this.default = TRUE
//
st_funcao.text = 'Atualiza configura$$HEX2$$e700f500$$ENDHEX$$es.'
end event

event losefocus;//
this.default = False
//
end event

type cb_parametros from commandbutton within w_ge039_controle_impressora_fiscal
integer x = 1266
integer y = 76
integer width = 562
integer height = 112
integer taborder = 80
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Par$$HEX1$$e200$$ENDHEX$$metros"
end type

event getfocus;//
this.default = TRUE
//
st_funcao.text = 'Imprime par$$HEX1$$e200$$ENDHEX$$metros da ECF.'
end event

event losefocus;//
this.default = False
//
end event

event clicked;
wf_parametros()
end event

type cb_leitura_mf from commandbutton within w_ge039_controle_impressora_fiscal
integer x = 667
integer y = 356
integer width = 562
integer height = 112
integer taborder = 70
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Leitura MF"
end type

event getfocus;//
this.default = TRUE
//
st_funcao.text = 'Captura Informa$$HEX2$$e700f500$$ENDHEX$$es do Mapa Resumo da $$HEX1$$fa00$$ENDHEX$$ltima "REDU$$HEX2$$c700c200$$ENDHEX$$O "Z"'
end event

event losefocus;//
this.default = FALSE
//
end event

event clicked;
Boolean lb_Sucesso

If Not PDV.of_abreporta() Then Return

//lb_Sucesso = PDV.of_leitura_memoria_fiscal('011208','051208','c:')

PDV.of_fechaporta()



end event

type cb_cancela_cupom from commandbutton within w_ge039_controle_impressora_fiscal
integer x = 667
integer y = 220
integer width = 562
integer height = 108
integer taborder = 60
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Cancela Cupom"
end type

event clicked;IF NOT PDV.of_AbrePorta() THEN RETURN
//
Wf_Cancela_Cupom_Aberto()
//
PDV.of_fechaporta()
//


end event

event getfocus;//
this.default = TRUE
//
st_funcao.text = "Cancela $$HEX1$$fa00$$ENDHEX$$ltimo cupom fiscal. Caso este cupom esteja gravado no sistema, efetua o cancelamento autom$$HEX1$$e100$$ENDHEX$$tico. Caso n$$HEX1$$e300$$ENDHEX$$o esteja, apenas executa o cancelamento no ECF."
end event

event losefocus;//
this.default = False
//
end event

type cb_mfd_mensal from commandbutton within w_ge039_controle_impressora_fiscal
integer x = 667
integer y = 80
integer width = 562
integer height = 108
integer taborder = 50
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "M&FD Mensal"
end type

event clicked;//
wf_atualiza_data_fiscal()
//
end event

event getfocus;//
this.default = TRUE
//
st_funcao.text = "Gera arquivo MFD do m$$HEX1$$ea00$$ENDHEX$$s anterior. Ao iniciar o processo o PDV e ECF devem ficar ligados at$$HEX1$$e900$$ENDHEX$$ o final."
end event

event losefocus;//
this.default = FALSE
//
end event

type cb_data_hora_atual from commandbutton within w_ge039_controle_impressora_fiscal
integer x = 69
integer y = 80
integer width = 562
integer height = 108
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Data/Hora"
end type

event clicked;//
wf_datahora()
//
end event

event getfocus;//
this.default = TRUE
//

st_funcao.text = "Exibe a data/hora corrente e a data fiscal da impressora fiscal."
end event

event losefocus;//
this.default = FALSE
//
end event

type cb_reducaoz from commandbutton within w_ge039_controle_impressora_fiscal
integer x = 69
integer y = 360
integer width = 562
integer height = 108
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Redu$$HEX2$$e700e300$$ENDHEX$$o Z"
end type

event clicked;//
wf_reducaoz()
//

end event

event getfocus;//
this.default = TRUE
//
st_funcao.text = "Fechamento di$$HEX1$$e100$$ENDHEX$$rio impressora. Ap$$HEX1$$f300$$ENDHEX$$s executar esse comando, n$$HEX1$$e300$$ENDHEX$$o poder$$HEX1$$e100$$ENDHEX$$ mais ser realizada vendas para o dia fiscal encerrado."
end event

event losefocus;//
this.default = FALSE
//
end event

type cb_leiturax from commandbutton within w_ge039_controle_impressora_fiscal
integer x = 69
integer y = 220
integer width = 562
integer height = 108
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Leitura X"
end type

event clicked;//
wf_leiturax ()
//
end event

event getfocus;//
this.default = TRUE
//
st_funcao.text = "Troca papel / Abertura di$$HEX1$$e100$$ENDHEX$$ria. [CTRL+X] Tecla Atalho no Sistema Caixa."
end event

event losefocus;//
this.default = FALSE
//
end event

type gb_1 from groupbox within w_ge039_controle_impressora_fiscal
event mousemove pbm_mousemove
integer x = 32
integer y = 8
integer width = 1847
integer height = 936
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

