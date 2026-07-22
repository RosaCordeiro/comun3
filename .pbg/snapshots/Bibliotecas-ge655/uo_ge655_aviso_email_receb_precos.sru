HA$PBExportHeader$uo_ge655_aviso_email_receb_precos.sru
forward
global type uo_ge655_aviso_email_receb_precos from nonvisualobject
end type
end forward

global type uo_ge655_aviso_email_receb_precos from nonvisualobject
end type
global uo_ge655_aviso_email_receb_precos uo_ge655_aviso_email_receb_precos

type variables
String ivs_dias_parametro
end variables

forward prototypes
public function boolean of_processa_envio_preco_fornecedor ()
public function boolean of_localiza_feriado (date adt_feriado, ref string as_erro)
public function boolean of_verifica_limite_hr_envio (ref string as_hr_limite_rec, ref string as_erro)
public function boolean of_email_pendente_envio_preco (string as_nm_contato, string as_uf_estado, string as_nm_distribuidora, string as_email_destinatario, ref string as_erro)
end prototypes

public function boolean of_processa_envio_preco_fornecedor ();Long	ll_Linhas, &
		ll_Linha, &
		ll_Linhas_fc, &
		ll_Linha_fc, &
		ll_Pedido

String	lvs_erro, &
		lvs_texto_email, &
		lvs_nm_contato, &
		lvs_uf_estado, &
		lvs_email,&
		lvs_emails,&
		lvs_cd_fornecedor,&
		lvs_cd_fornecedor_proximo,&
		lvs_unidade_ferederacao,&
		ls_hr_rec_arqui_preco,&
		lvs_nm_distribuidora		

Date ldt_data


ldt_data = Date(gf_getServerDate())

Try
	dc_uo_ds_base lds_contato_fornecedor
	dc_uo_ds_base lds_fornecedor_envio_pendente

	lds_fornecedor_envio_pendente = create dc_uo_ds_base
	If Not lds_fornecedor_envio_pendente.of_changedataobject('ds_ge655_receb_pendente_preco') Then
		lvs_erro = "Erro no ChangeDataObject da ds_ge655_fornecedor_envio_pendente."
		Return False
	End If

	lds_contato_fornecedor = create dc_uo_ds_base
	If Not lds_contato_fornecedor.of_changedataobject('ds_ge655_contato_fornecedor') Then
		lvs_erro = "Erro no ChangeDataObject da ds_ge655_contato_fornecedor."
		Return False
	End If
	
	If Not of_localiza_feriado(ldt_data, Ref lvs_erro) Then Return false
	
	ll_Linhas_fc = lds_fornecedor_envio_pendente.retrieve()

	Open(w_Aguarde)
	
	w_Aguarde.Title = "Processando Envio Email: Pedido de pre$$HEX1$$e700$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o enviado..."
	w_Aguarde.uo_Progress.of_setmax(ll_Linhas_fc)

	If ll_Linhas_fc > 0 Then
		lvs_uf_estado = ""
				
		For ll_Linha_fc = 1 To ll_Linhas_fc

			lvs_cd_fornecedor 		= lds_fornecedor_envio_pendente.object.cd_distribuidora		[ll_Linha_fc]
			lvs_unidade_ferederacao = lds_fornecedor_envio_pendente.object.cd_unidade_federacao	[ll_Linha_fc]
			lvs_nm_distribuidora		= lds_fornecedor_envio_pendente.object.nm_razao_social		[ll_Linha_fc]
			
			lvs_texto_email = ""
			
			w_Aguarde.Title = "Enviando e-mail Linha: " + String(ll_Linha_fc) + " de " + String(ll_Linhas_fc)
			w_Aguarde.uo_Progress.of_setprogress(ll_Linha_fc)
			
			If ll_Linha_fc < ll_Linhas_fc Then
				lvs_cd_fornecedor_proximo = lds_fornecedor_envio_pendente.object.cd_distribuidora[ll_Linha_fc + 1]
			Else
				lvs_cd_fornecedor_proximo = '000000000'
			End If
			
			If lvs_uf_estado = "" Then
				lvs_uf_estado = lvs_unidade_ferederacao
			Else
				lvs_uf_estado += ", " + lvs_unidade_ferederacao
			End If
			
			If lvs_cd_fornecedor <> lvs_cd_fornecedor_proximo Then
			
				ll_linhas = lds_contato_fornecedor.retrieve(lvs_cd_fornecedor)
			
				If ll_Linhas > 0 Then
					lvs_nm_contato = ""
			
					For ll_Linha = 1 To ll_Linhas
						lvs_email = lds_contato_fornecedor.object.de_email[ll_Linha]
						lvs_nm_contato = lds_contato_fornecedor.object.nm_contato [1]
					  	
						If ll_Linha = 1 Then
							lvs_emails = lvs_email
						Else
							lvs_emails += ";" + lvs_email
						End If
					Next
				End If
					
				If Not This.of_email_pendente_envio_preco(lvs_nm_contato, lvs_uf_estado, lvs_nm_distribuidora, lvs_emails, Ref lvs_erro) Then
					lvs_erro = "Erro ao enviar email para loja: of_envia_email_precos ge655." + lvs_erro
					Return False
				End If
				
				lvs_uf_estado = ""
			End If
		Next
	End If
Finally
	Destroy(lds_contato_fornecedor)
	Destroy(lds_fornecedor_envio_pendente)
	Close(w_Aguarde)
End Try

Return True

end function

public function boolean of_localiza_feriado (date adt_feriado, ref string as_erro);String ls_feriado
Long ll_contagem

ls_feriado = String(adt_feriado, 'YYYY/MM/DD')

select count(cd_grupo_feriado)
	Into :ll_contagem
	from feriado 
	where cd_grupo_feriado = 3 
	and dh_feriado = :ls_feriado
Using SqlCa;	

Choose Case SqlCa.SqlCode
	Case -1
		as_erro = "N$$HEX1$$e300$$ENDHEX$$o foi localizado o feriado"
		Return False			
End Choose

If ll_contagem> 0 Then
	Return False
End If

Return True
end function

public function boolean of_verifica_limite_hr_envio (ref string as_hr_limite_rec, ref string as_erro);Select vl_parametro
Into :as_hr_limite_rec
From parametro_geral
Where cd_parametro = 'HR_CORTE_REC_ARQUIVO_PRE_DIST'
Using SqlCA;

Choose Case SqlCa.SqlCode
	Case -1
		as_Erro = "Erro em consulta o horario corte de recebimento de arquivo pre$$HEX1$$e700$$ENDHEX$$o" + SqlCa.sqlErrText
		Return False
End Choose

Return True 
end function

public function boolean of_email_pendente_envio_preco (string as_nm_contato, string as_uf_estado, string as_nm_distribuidora, string as_email_destinatario, ref string as_erro);String	lvs_texto_email,&
		ls_hr_rec_arqui_preco
		
s_email lst_Email

If Not of_verifica_limite_hr_envio(Ref ls_hr_rec_arqui_preco, Ref as_erro) Then Return false

lvs_texto_email = "Ol$$HEX1$$e100$$ENDHEX$$ "+ as_nm_contato + ",<br><br>" + &
					"O arquivo de pre$$HEX1$$e700$$ENDHEX$$os enviado para a CLAMED pela distribuidora <b>" + as_nm_distribuidora + "</b> diariamente ainda n$$HEX1$$e300$$ENDHEX$$o consta em nossa base de dados. " + &
					"Caso j$$HEX1$$e100$$ENDHEX$$ tenha sido enviado, favor desconsiderar este e-mail. Do contr$$HEX1$$e100$$ENDHEX$$rio, favor envi$$HEX1$$e100$$ENDHEX$$-lo at$$HEX1$$e900$$ENDHEX$$ as <b>" + ls_hr_rec_arqui_preco + "</b> horas, sendo que ap$$HEX1$$f300$$ENDHEX$$s isso as distribuidoras que n$$HEX1$$e300$$ENDHEX$$o enviarem seus arquivos, " + &
					"ficar$$HEX1$$e300$$ENDHEX$$o bloqueadas para faturamento de pedidos no dia corrente.<br><br>" + &
					"Lembrando que os arquivos de estoque devem continuar sendo enviados durante o dia, no menor intervalo de tempo poss$$HEX1$$ed00$$ENDHEX$$vel.<br><br>" + &
					"<b>Estados Pendentes:</b> " + as_uf_estado + "<br><br>"
					
					
lst_Email.ps_mensagem	= lvs_texto_email
lst_Email.pb_assinatura = True
lst_email.ps_to[1] = as_email_destinatario

If gvo_Aplicacao.ivs_DataSource = 'central' then
	If Not gf_ge202_envia_email_padrao(349, lst_Email)	Then
		Return False
	End If
End IF	
Return True





end function

on uo_ge655_aviso_email_receb_precos.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge655_aviso_email_receb_precos.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

