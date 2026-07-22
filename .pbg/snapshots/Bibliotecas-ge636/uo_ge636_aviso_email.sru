HA$PBExportHeader$uo_ge636_aviso_email.sru
forward
global type uo_ge636_aviso_email from nonvisualobject
end type
end forward

global type uo_ge636_aviso_email from nonvisualobject
end type
global uo_ge636_aviso_email uo_ge636_aviso_email

type variables
String ivs_dias_parametro
end variables

forward prototypes
public function boolean of_processa_envio_informacao ()
public subroutine of_mensagem_processo (string as_erro_msg)
public function boolean of_envia_email_status (string as_status_alvara, long al_cd_mensagem, string as_mensagem)
end prototypes

public function boolean of_processa_envio_informacao ();Date				ldt_data, &
					ldt_vencimento
DateTime			ldt_emissao
dc_uo_ds_base	lds_veiculos_expirando
Long				ll_Linhas, &
					ll_Linha,  &
					ll_restante
String			lvs_erro,              &
					lvs_cabecalho,         &
					lvs_dados_pendentes,   &
					lvs_dados_vencidos,    &
					lvs_rodape,            &
					lvs_texto_envio,       &
					lvs_dados_2_pendentes, &
					lvs_dados_2_vencidos,  &
					lvs_placa,             &
					lvs_situacao,          &
					lvs_linha,             &
					lvs_tipo_veiculo,      &
					lvs_mensagem,          &
					lvs_mensagem_motivo,   &
					ls_dias_msg

ldt_data = Date (gf_getServerDate ())

Try
	
	// Dados dos ve$$HEX1$$ed00$$ENDHEX$$culos
	lds_veiculos_expirando = Create dc_uo_ds_base
	
	If Not lds_veiculos_expirando.of_changedataobject ('ds_ge636_veiculos') then
		lvs_erro = "Erro no ChangeDataObject da ds_ge636_veiculos."
		of_mensagem_processo (lvs_erro)
		Return False
	End if
	
	ll_Linhas = lds_veiculos_expirando.Retrieve ()
	
	If ll_linhas < 0 then
		lvs_erro = "Erro na extra$$HEX2$$e700e300$$ENDHEX$$o da lista do alvar$$HEX1$$e100$$ENDHEX$$ dos ve$$HEX1$$ed00$$ENDHEX$$culos."
		of_mensagem_processo (lvs_erro)
	End if
	
	Open (w_Aguarde)
	w_Aguarde.Title = "CD: Processando Envio Email: Alvar$$HEX1$$e100$$ENDHEX$$ Sanit$$HEX1$$e100$$ENDHEX$$rio Ve$$HEX1$$ed00$$ENDHEX$$culos..."
	w_Aguarde.uo_Progress.of_setmax (ll_Linhas)
	
	If ll_Linhas > 0 then
		lvs_dados_pendentes   = ''
		lvs_dados_vencidos    = ''
		lvs_dados_2_pendentes = ''
		lvs_dados_2_vencidos  = ''
		
		For ll_Linha = 1 To ll_Linhas
			w_Aguarde.Title = "Enviando e-mail Linha: " + String (ll_Linha) + " de " + String (ll_Linhas)
			w_Aguarde.uo_Progress.of_setprogress (ll_Linha)
			
			// Recupera os dados do ve$$HEX1$$ed00$$ENDHEX$$culo
			lvs_placa        = lds_veiculos_expirando.Object.nr_placa            [ll_Linha]
			lvs_tipo_veiculo = lds_veiculos_expirando.Object.id_tipo_veiculo     [ll_Linha]
			ldt_vencimento   = lds_veiculos_expirando.Object.dh_alvara_sanitario [ll_Linha]
			lvs_situacao     = lds_veiculos_expirando.Object.status_alvara       [ll_Linha]
			ll_restante      = Abs (DaysAfter (ldt_vencimento, ldt_data)) // Calcula os dias restantes
			
			If lvs_situacao = 'RENOVACAO ALVARA PENDENTE' then
				ls_dias_msg = ' a vencer'
			else
				ls_dias_msg = ' vencido'
			End if
			
			lvs_mensagem_motivo = '<tr><th class="tg-0lax">' + String (lvs_placa) + '</th><th class="tg-0lax">' + String (ldt_vencimento, 'dd-mm-yyyy') + '</th><th class="tg-0lax">' + String (lvs_situacao) + '</th><th class="tg-0lax">' + String (ll_restante) + ' dias ' + String (ls_dias_msg) + '</th></tr>'
			
			If lvs_tipo_veiculo = '1' then
				If lvs_situacao = 'RENOVACAO ALVARA PENDENTE' then
					lvs_dados_pendentes += lvs_mensagem_motivo
				else
					lvs_dados_vencidos  += lvs_mensagem_motivo
				End if
			else
				If lvs_situacao = 'RENOVACAO ALVARA PENDENTE' then
					lvs_dados_2_pendentes += lvs_mensagem_motivo
				else
					lvs_dados_2_vencidos  += lvs_mensagem_motivo
				End if
			End if
		Next
		
		If Trim (lvs_dados_pendentes) <> '' then
			of_envia_email_status ('P', 329, lvs_dados_pendentes)
		End if
		
		If Trim (lvs_dados_vencidos) <> '' then
			of_envia_email_status ('V', 329, lvs_dados_vencidos)
		End if
		
		If Trim (lvs_dados_2_pendentes) <> '' then
			of_envia_email_status ('P', 328, lvs_dados_2_pendentes)
		End if
		
		If Trim (lvs_dados_2_vencidos) <> '' then
			of_envia_email_status ('V', 328, lvs_dados_2_vencidos)
		End if
		
	End if
	
Finally
    Destroy lds_veiculos_expirando
    Close (w_Aguarde)
End Try

Return True
end function

public subroutine of_mensagem_processo (string as_erro_msg);// DECLARA$$HEX2$$c700d500$$ENDHEX$$ES

String	ls_Msg

s_email	lst_Email					

// PROCEDIMENTOS

ls_Msg =	'<b>ATEN$$HEX2$$c700c300$$ENDHEX$$O!'                                            + '<br><br>' + &
			'<b>Envio de Relatorio de Situacao do Alvara do Veiculo' + '<br></b>' + &
			'<b>Sistema EX'                                          + '<br></b>' + &
			'<b>Mensagem: ' + as_erro_msg                            + '<br></b>'
			
lst_Email.ps_mensagem	= ls_Msg
lst_Email.pb_assinatura = True

gf_ge202_envia_email_padrao (330, lst_Email)

Return
end subroutine

public function boolean of_envia_email_status (string as_status_alvara, long al_cd_mensagem, string as_mensagem);String	ls_Msg,&
			ls_html,&
			ls_erro,&
			ls_assunto,&
			ls_tipo_vencimento,&
			ls_dias_vencimento,&
			ls_email_transportadora

Long		ll_Linha , ll_Linhas

s_email	lst_Email 		//ge202
s_email	lst_Email_nulo //ge202

ls_html = '<style type="text/css">'+&
			 ".tg  {border-collapse:collapse;border-spacing:0;}"+&
			 ".tg td{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:10px;"+&
			 "  overflow:hidden;padding:10px 5px;word-break:normal;}"+&
			 ".tg th{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:10px;"+&
			 "  font-weight:normal;overflow:hidden;padding:10px 5px;word-break:normal;}"+&
			 ".tg .tg-0lax{text-align:left;vertical-align:top}"+&
			 "</style>"+&
			 '<table class="tg">'+&
			 "<thead>"+&
			 '<tr><th class="tg-0lax">Placa</th><th class="tg-0lax">Vencimento</th><th class="tg-0lax">Status Alvara</th><th class="tg-0lax">Dias Alvar$$HEX1$$e100$$ENDHEX$$</th></tr>'+&
			 as_mensagem+&
			 "</thead></table>"

// Ajusta a mensagem com base na situa$$HEX2$$e700e300$$ENDHEX$$o recebida
If as_status_alvara = 'P' Then
	ls_assunto = "Pedentes"
	ls_Msg =	" Prezados,<br>"+& 
				"<br>"+&
				" Segue abaixo a situa$$HEX2$$e700e300$$ENDHEX$$o dos ve$$HEX1$$ed00$$ENDHEX$$culos com alvar$$HEX1$$e100$$ENDHEX$$s sanit$$HEX1$$e100$$ENDHEX$$rios pedentes que necessitam de regulariza$$HEX2$$e700e300$$ENDHEX$$o:<br>"+&
				"<br>"+&
				"<p><strong>" + &
				" Situa$$HEX2$$e700e300$$ENDHEX$$o dos Alvar$$HEX1$$e100$$ENDHEX$$s Sanit$$HEX1$$e100$$ENDHEX$$rios Pendentes:<br></strong></p>" + &
				ls_html+"<br>" + & 
				"<p><strong>" + &
				" A$$HEX2$$e700e300$$ENDHEX$$o Necess$$HEX1$$e100$$ENDHEX$$ria:<br></strong></p>" + &
				"Solicitamos que as provid$$HEX1$$ea00$$ENDHEX$$ncias cab$$HEX1$$ed00$$ENDHEX$$veis sejam tomadas para a regulariza$$HEX2$$e700e300$$ENDHEX$$o dos alvar$$HEX1$$e100$$ENDHEX$$s sanit$$HEX1$$e100$$ENDHEX$$rios dos ve$$HEX1$$ed00$$ENDHEX$$culos mencionados, a fim de evitar interrup$$HEX2$$e700f500$$ENDHEX$$es nas opera$$HEX2$$e700f500$$ENDHEX$$es.<br>"
Else
	ls_assunto = "Vencidos"
	ls_Msg =	" Prezados,<br>"+& 
				"<br>"+&
				" Segue abaixo a situa$$HEX2$$e700e300$$ENDHEX$$o dos ve$$HEX1$$ed00$$ENDHEX$$culos com alvar$$HEX1$$e100$$ENDHEX$$s sanit$$HEX1$$e100$$ENDHEX$$rios vencidos que necessitam de regulariza$$HEX2$$e700e300$$ENDHEX$$o:<br>"+&
				"<br>"+&
				"<p><strong>" + &
				" Situa$$HEX2$$e700e300$$ENDHEX$$o dos Alvar$$HEX1$$e100$$ENDHEX$$s Sanit$$HEX1$$e100$$ENDHEX$$rios Vencidos:<br></strong></p>" + &	
				ls_html+"<br>" + & 
				"<p><strong>" + &
				" A$$HEX2$$e700e300$$ENDHEX$$o Necess$$HEX1$$e100$$ENDHEX$$ria:<br></strong></p>" + &
				"Os ve$$HEX1$$ed00$$ENDHEX$$culos mencionados acima n$$HEX1$$e300$$ENDHEX$$o poder$$HEX1$$e300$$ENDHEX$$o ser utilizados para o transporte de materiais da CLAMED at$$HEX1$$e900$$ENDHEX$$ que seus alvar$$HEX1$$e100$$ENDHEX$$s sanit$$HEX1$$e100$$ENDHEX$$rios sejam renovados.<br>" + &
				"Solicitamos que as provid$$HEX1$$ea00$$ENDHEX$$ncias cab$$HEX1$$ed00$$ENDHEX$$veis sejam tomadas para resolver este problema o mais breve poss$$HEX1$$ed00$$ENDHEX$$vel.<br>"
End If

lst_email.ps_Assunto    = ls_assunto
lst_Email.ps_mensagem	= ls_Msg
lst_Email.pb_assinatura = True

If Not gf_ge202_envia_email_padrao(al_cd_mensagem, lst_Email) Then
	Return False
End If

//Limpa a estrutura do e-mail
lst_Email = lst_Email_nulo

Return True
end function

on uo_ge636_aviso_email.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge636_aviso_email.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

