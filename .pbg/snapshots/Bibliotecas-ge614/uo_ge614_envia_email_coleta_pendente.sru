HA$PBExportHeader$uo_ge614_envia_email_coleta_pendente.sru
forward
global type uo_ge614_envia_email_coleta_pendente from nonvisualobject
end type
end forward

global type uo_ge614_envia_email_coleta_pendente from nonvisualobject
end type
global uo_ge614_envia_email_coleta_pendente uo_ge614_envia_email_coleta_pendente

forward prototypes
public function boolean of_data_ultimo_alerta (ref date adt_ultimo_alerta, ref string as_erro)
public function boolean of_atualiza_data_envio_email (long al_nr_coleta, ref string as_erro)
public function boolean of_atualiza_data_parametro_ultimo_alerta (ref string as_erro)
public function boolean of_envia_email (string as_fornecedor, long al_divisao_fornecedor, string as_nome_divisao, string as_id_distribuidora, string as_email_fornecedor, string as_mensagem_email, ref string as_erro)
public subroutine _documentacao ()
public function boolean of_envia_email_coleta_pendente ()
end prototypes

public function boolean of_data_ultimo_alerta (ref date adt_ultimo_alerta, ref string as_erro);String	ls_Parametro

Try
	select vl_parametro
	into	:ls_Parametro
	from wms_parametro
	where cd_parametro = 'DT_ENVIO_ALERTA_NF_PENDENTE_COLETA'
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			adt_Ultimo_Alerta = Date(ls_Parametro)
		Case 100
			as_Erro = "N$$HEX1$$e300$$ENDHEX$$o foi localizado o par$$HEX1$$e200$$ENDHEX$$metro 'DT_ENVIO_ALERTA_NF_PENDENTE_COLETA'."
			Return False
		Case -1
			as_Erro = "Erro ao localizar o par$$HEX1$$e200$$ENDHEX$$metro 'DT_ENVIO_ALERTA_NF_PENDENTE_COLETA': "+SqlCa.SqlErrText
			Return False
	End Choose
Catch ( runtimeerror  lo_rte )
	as_Erro = "Erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_data_ultimo_alerta': "+  lo_rte.GetMessage()
	Return False
End Try	

Return True
end function

public function boolean of_atualiza_data_envio_email (long al_nr_coleta, ref string as_erro);Update wms_segregado_coleta
Set dh_envio_email = GetDate()
Where nr_coleta = :al_Nr_Coleta
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_Erro = "Erro ao atualizar a coluna 'dh_envio_email' da tabela 'wms_segregado_coleta': "+SqlCa.SqlErrText
	Return False
End If

If SqlCa.SqlnRows	<> 1 Then
	as_Erro = "N$$HEX1$$e300$$ENDHEX$$o foi atualizado nenhum registro ao atualizar a coluna 'dh_envio_email' da tabela 'wms_segregado_coleta'."
	Return False
End If

Return True
end function

public function boolean of_atualiza_data_parametro_ultimo_alerta (ref string as_erro);String	ls_Parametro

Try
	
	ls_Parametro	= String(gf_GetServerDate(), "DD/MM/YYYY")
	
	update wms_parametro
	set vl_parametro = :ls_Parametro
	where cd_parametro = 'DT_ENVIO_ALERTA_NF_PENDENTE_COLETA'
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		as_Erro = "Erro ao atualizar o par$$HEX1$$e200$$ENDHEX$$metro 'DT_ENVIO_ALERTA_NF_PENDENTE_COLETA': "+SqlCa.SqlErrText
		Return False
	End If
	
	If SqlCa.SqlnRows	<> 1 Then
		as_Erro = "N$$HEX1$$e300$$ENDHEX$$o foi atualizado nenhum registro ao atualizar o par$$HEX1$$e200$$ENDHEX$$metro 'DT_ENVIO_ALERTA_NF_PENDENTE_COLETA'."
		Return False
	End If
	
Catch ( runtimeerror  lo_rte )
	as_Erro = "Erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_atualiza_data_ultimo_alerta': "+  lo_rte.GetMessage()
	Return False
End Try	

Return True
end function

public function boolean of_envia_email (string as_fornecedor, long al_divisao_fornecedor, string as_nome_divisao, string as_id_distribuidora, string as_email_fornecedor, string as_mensagem_email, ref string as_erro);dc_uo_ds_Base	lds_auxiliar_compra
dc_uo_ds_Base			lds_Contatos

Boolean lb_Envio_Email_Divisao = True

Long	ll_linhas,&
		ll_linha,&
		ll_auxiliar_compras
		
s_email str

String ls_Mensagem_Email
String ls_Anexo[]
string ls_auxiliar_comprador
string ls_email_coleta
string ls_email_comprador
string ls_email_auxiliar

Try
	
	lds_Contatos = Create dc_uo_ds_Base
	
	If Not lds_Contatos.of_ChangeDataObject("ds_GE614_contato_fornecedor") Then
		SqlCa.of_Rollback()
		gf_ge202_envia_email_automatico(264, "", "Erro no ChageDataObject da ds_GE614_contato_fornecedor", ls_Anexo, False)
		Return False
	End If
	
	lds_auxiliar_compra = Create dc_uo_ds_Base
	If Not lds_auxiliar_compra.of_ChangeDataObject("ds_GE614_contato_auxiliar_compra") Then
		SqlCa.of_Rollback()
		gf_ge202_envia_email_automatico(264, "", "Erro no ChageDataObject da ds_GE614_contato_auxiliar_compra", ls_Anexo, False)
		Return False
	End If
	
	If al_Divisao_Fornecedor = 0 Then SetNull(al_Divisao_Fornecedor)
	
	ll_linhas = lds_Contatos.Retrieve(as_Fornecedor, al_Divisao_Fornecedor)
	ll_auxiliar_compras = lds_auxiliar_compra.retrieve(as_Fornecedor, al_Divisao_Fornecedor)
		
	If ll_linhas < 0 Then
		SqlCa.of_Rollback()
		gf_ge202_envia_email_automatico(264, "", "Erro no retrieve da ds_GE614_contato_fornecedor", ls_Anexo, False)
		Return False
	End If

	If ll_linhas > 0 Then
		as_Email_Fornecedor  = ""
		
		If as_Id_Distribuidora = "N" Then
			If Not IsNull(al_Divisao_Fornecedor) And al_Divisao_Fornecedor > 0 Then
				lds_Contatos.SetFilter("nr_sql = 1")
				lds_Contatos.Filter( )
			End If					
			
			If lds_Contatos.RowCount() = 0 Or IsNull(al_Divisao_Fornecedor) Then
				lds_Contatos.SetFilter( '' )
				lds_Contatos.Filter( )
						
				lds_Contatos.SetFilter("nr_sql = 2")
				lds_Contatos.Filter( )
				
				lb_Envio_Email_Divisao = False
			End If
			
			ll_Linhas = lds_Contatos.RowCount()
		End If
		
		For ll_Linha  = 1 to ll_Linhas
			str.ps_to[upperbound(str.ps_to) + 1] = lds_Contatos.Object.de_email[ll_linha]
		Next
	
		/*
		Se tiver email do comprador e do auxiliar, deve verificar se ambos recebem o email de notifica$$HEX2$$e700e300$$ENDHEX$$o.
		Caso o comprador n$$HEX1$$e300$$ENDHEX$$o esteja marcado para receber, apenas o auxiliar recebe notifica$$HEX2$$e700e300$$ENDHEX$$o
		*/
		for ll_linha = 1 to ll_auxiliar_compras
			
			ls_email_coleta = lds_auxiliar_compra.Object.email_coleta[ll_linha]
			ls_email_comprador = lds_auxiliar_compra.Object.email_comprador[ll_linha]
			ls_auxiliar_comprador = lds_auxiliar_compra.Object.id_auxiliar[ll_linha]
			ls_email_auxiliar = lds_auxiliar_compra.Object.email_auxiliar[ll_linha]
			if ls_email_coleta = 'S' and ls_email_comprador <> '-' then str.ps_cc[upperbound(str.ps_cc) + 1] = ls_email_comprador
			if ls_auxiliar_comprador = 'S' and ls_email_auxiliar <> '-' then str.ps_cc[upperbound(str.ps_cc) + 1] = ls_email_auxiliar
		next
	
		If lb_Envio_Email_Divisao And as_Id_Distribuidora = "N" Then
			as_Mensagem_Email += "<br><br><b>E-mail enviado para os contatos do tipo Comercial e Log$$HEX1$$ed00$$ENDHEX$$stica cadastrados na divis$$HEX1$$e300$$ENDHEX$$o " + String(as_Nome_Divisao) + " do fornecedor.</b>"
		Else
			as_Mensagem_Email += "<br><br><b>E-mail enviado para os contatos do tipo Comercial e Log$$HEX1$$ed00$$ENDHEX$$stica do cadastro do fornecedor.</b>"
		End If
	End If
	
	If ll_Linhas = 0 Then
		If (as_Email_Fornecedor <> "") and Not IsNull(as_Email_Fornecedor) Then
			str.ps_to[upperbound(str.ps_to) + 1]	= as_Email_Fornecedor
			as_Mensagem_Email += "<br><br><b>E-mail enviado para o contato principal do cadastro do fornecedor.</b>"
		End If
	End If
	
	str.ps_Mensagem	= as_Mensagem_Email
	str.pb_assinatura	= True	
	
	If gvo_Aplicacao.ivs_DataSource = 'central' Then
		If Not gf_ge202_envia_email_padrao(130, str) Then
			as_Erro = "Erro ao enviar e-mail ao fornecedor. Fun$$HEX2$$e700e300$$ENDHEX$$o 'of_Envia_Email'."
			Return False	
		End If
	Else
		//Desenvolvimento
		//	s_email teste
		//	str = teste
		//str.ps_Mensagem	= as_Mensagem_Email
		//str.pb_assinatura	= True	
		gf_ge202_envia_email_padrao(130, str)
	End If
	
	Return True
	
Finally
	Destroy(lds_Contatos)
	Destroy(lds_auxiliar_compra)
End Try
end function

public subroutine _documentacao ();/*
  Objetivo: Enviar comunicado de notas pendentes de colega para fornecedores
	Chamado: 1073069


Objeto que gerencia o envio de email referente a Nota Pendente de Coleta

Envia emails para os fornecedores, compradores e auxiliares de comprador
*/

end subroutine

public function boolean of_envia_email_coleta_pendente ();//Envia email para avisar que tem nota de segregado esperando para ser coletada.
dc_uo_ds_Base	lds_Notas

String ls_Erro,&
		ls_Cd_Fornecedor,&
		ls_Email_Fornecedor,&
		ls_Email_Proximo_Fornecedor,&
		ls_Mensagem_Email	= "", &
		ls_Id_Distribuidora, &
		ls_Nm_Comprador, &
		ls_Nome_Divisao, &
		ls_Nome_Fantasia, &
		ls_Anexo[],&
		ls_motivo_devolucao

Long	ll_Linhas,&
		ll_Linha,&
		ll_Coleta,&
		ll_Nota, &
		ll_Divisao_Fornecedor, &
		ll_NF_Compra, &
		ll_Prox_Divisao,&
		ll_Linhas_Email
		
		
Date	ldt_Data_Atual,&
		ldt_Data_Ultimo_Alerta
		
Boolean	lb_Sucesso = True

DateTime	ldh_Emissao
		
Try
	
	Try
		
		Open(w_Aguarde)
		
		ldt_Data_Atual	= Date(gf_GetServerDate())
		
		lds_Notas = Create dc_uo_ds_Base
		
		If Not of_Data_Ultimo_Alerta(Ref ldt_Data_Ultimo_Alerta, Ref ls_Erro) Then
			gf_ge202_envia_email_automatico(264, "", ls_Erro, ls_Anexo, False)
			Return False
		End If
	
		If ldt_Data_Ultimo_Alerta < 	ldt_Data_Atual Then
			If Not lds_Notas.of_ChangeDataObject("ds_GE614_nf_pendente_coleta") Then
				gf_ge202_envia_email_automatico(264, "", "Erro no ChageDataObject da ds_GE614_nf_pendente_coleta", ls_Anexo, False)
				Return False
			End If
		
			ll_Linhas	= lds_Notas.Retrieve()
				
			If ll_Linhas > 0 Then
				w_Aguarde.Title = "Enviando e-mail de coleta em atraso..."
						
				w_Aguarde.uo_Progress.of_setmax(ll_Linhas)
						
				For ll_Linha = 1 To ll_Linhas
					
					ll_Coleta				 = lds_Notas.Object.nr_coleta		       [ll_Linha]
					ls_Cd_Fornecedor		 = lds_Notas.Object.cd_fornecedor       [ll_Linha]
					ls_Email_Fornecedor	 = lds_Notas.Object.de_email		       [ll_Linha]
					ll_Nota					 = lds_Notas.Object.nr_nf			       [ll_Linha]
					ldh_Emissao				 = lds_Notas.Object.dh_emissao	       [ll_Linha]
					ll_Divisao_Fornecedor = lds_Notas.Object.Nr_Divisao		    [ll_Linha]
					ls_Id_Distribuidora	 = lds_Notas.Object.Id_Distribuidora    [ll_Linha]
					ll_NF_Compra			 = lds_Notas.Object.Nr_Nf_Compra		    [ll_Linha]
					ls_Nm_Comprador		 = lds_Notas.Object.Nm_Comprador	       [ll_Linha]
					ls_Nome_Divisao		 = lds_Notas.Object.Nm_Divisao		    [ll_Linha]
					ls_Nome_Fantasia		 = lds_Notas.Object.Nm_Fantasia		    [ll_Linha]
					ls_motivo_devolucao   = lds_Notas.Object.de_motivo_devolucao [ll_Linha]
					
					if isnull(ls_motivo_devolucao) then ls_motivo_devolucao = ''
					
					If ll_Linha < ll_Linhas	Then
						ls_Email_Proximo_Fornecedor = lds_Notas.Object.cd_fornecedor	[ll_Linha + 1]
						ll_Prox_Divisao				 = lds_Notas.Object.Nr_Divisao		[ll_Linha + 1]
					Else
						ls_Email_Proximo_Fornecedor = ""
						ll_Prox_Divisao					   = 0
					End If
					
					If ls_Mensagem_Email = "" Then
						ll_Linhas_Email = 1
						ls_Mensagem_Email = "Caro fornecedor " + ls_Nome_Fantasia + ",<br><br>~n" + &
							"<table border=2 style='font-family:Verdana; font-size:12px; table-layout: fixed; width: 220px; overflow: hidden;'>~n" + &
							"<tr>~n" + &
							"<th WIDTH=100>Nota</th>~n" + &
							"<th WIDTH=180>Emiss$$HEX1$$e300$$ENDHEX$$o da Devolu$$HEX2$$e700e300$$ENDHEX$$o</th>~n" + &
							"<th WIDTH=120>Nota de Origem</th>~n" + &
							"<th WIDTH=280>Comprador</th>~n" + &
							"<th WIDTH=180>C$$HEX1$$f300$$ENDHEX$$digo Divis$$HEX1$$e300$$ENDHEX$$o</th>~n" + &
							"<th WIDTH=280>Nome Divis$$HEX1$$e300$$ENDHEX$$o</th>~n" + &
							"<th WIDTH=280>Motivo Devolu$$HEX2$$e700e300$$ENDHEX$$o</th>~n" + &
							"</tr>~n" + &
							"<tr>~n" + &
							"<td WIDTH=100>" + String(ll_Nota) + "</td>~n" + &
							"<td WIDTH=180>" + String(ldh_Emissao, "dd/mm/yyyy") + "</td>~n" + &
							"<td WIDTH=120>" + String(ll_NF_Compra) + "</td>~n" + &
							"<td WIDTH=280>" + ls_Nm_Comprador + "</td>~n" + &
							"<td WIDTH=180>" + String(ll_Divisao_Fornecedor) + "</td>~n" + &
							"<td WIDTH=280>" + ls_Nome_Divisao + "</td>~n" + &
							"<td WIDTH=280>" + ls_motivo_devolucao + "</td>~n" + &
							"</tr>~n"
					Else
						ll_Linhas_Email += 1
						ls_Mensagem_Email += "<tr>~n" + &
							"<td WIDTH=100>" + String(ll_Nota) + "</td>~n" + &
							"<td WIDTH=180>" + String(ldh_Emissao, "dd/mm/yyyy") + "</td>~n" + &
							"<td WIDTH=120>" + String(ll_NF_Compra) + "</td>~n" + &
							"<td WIDTH=280>" + ls_Nm_Comprador + "</td>~n" + &
							"<td WIDTH=180>" + String(ll_Divisao_Fornecedor) + "</td>~n" + &
							"<td WIDTH=280>" + ls_Nome_Divisao + "</td>~n" + &
							"<td WIDTH=280>" + ls_motivo_devolucao + "</td>~n" + &
							"</tr>~n"
					End If
					
					If (ls_Cd_Fornecedor <> ls_Email_Proximo_Fornecedor) Or ll_Linhas_Email = 100 Then
						
						ls_Mensagem_Email += "</table>~n<br><br>As notas acima est$$HEX1$$e300$$ENDHEX$$o pendentes de coleta, caso n$$HEX1$$e300$$ENDHEX$$o ocorra a coleta em at$$HEX1$$e900$$ENDHEX$$ 30 dias ap$$HEX1$$f300$$ENDHEX$$s a emiss$$HEX1$$e300$$ENDHEX$$o, a mercadoria ser$$HEX1$$e100$$ENDHEX$$ encaminhada $$HEX1$$e000$$ENDHEX$$ incinera$$HEX2$$e700e300$$ENDHEX$$o."
												
						If Not of_Envia_Email(ls_Cd_Fornecedor, ll_Divisao_Fornecedor, ls_Nome_Divisao, ls_Id_Distribuidora, ls_Email_Fornecedor, ls_Mensagem_Email, Ref ls_Erro) Then
							lb_Sucesso = False
							Exit
						End If
						
						ls_Mensagem_Email	= ""
						ll_Linhas_Email = 0 
						
						SqlCa.of_commit()	//Faz comit para cada fornecedor
					End If
					
					If Not of_Atualiza_Data_Envio_Email(ll_Coleta, Ref ls_Erro) Then
						lb_Sucesso = False
						Exit
					End If
					
					w_Aguarde.uo_Progress.of_setprogress(ll_Linha)
				Next
			End If
			
			If lb_Sucesso Then
				If Not of_Atualiza_Data_Parametro_Ultimo_Alerta(Ref ls_Erro) Then
					lb_Sucesso = False
				End If
			End If
			
			If lb_Sucesso Then
				SqlCa.of_commit()
				
				Return True
			Else
				SqlCa.of_Rollback()
				gf_ge202_envia_email_automatico(264, "", ls_Erro, ls_Anexo, False)
				Return False
			End If
		End If
		
	Catch ( runtimeerror  lo_rte )
		gvo_Aplicacao.Of_Grava_Log("Falha na tentativa de envio de email de coleta pendente. ~rErro: "+lo_rte.GetMessage())
		Return False
	End Try
	
Finally
	Destroy(lds_Notas)
	Close(w_Aguarde)
End Try

end function

on uo_ge614_envia_email_coleta_pendente.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge614_envia_email_coleta_pendente.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

