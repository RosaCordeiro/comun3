HA$PBExportHeader$uo_ge666_atualiza_bloqueio_produto_end.sru
forward
global type uo_ge666_atualiza_bloqueio_produto_end from nonvisualobject
end type
end forward

global type uo_ge666_atualiza_bloqueio_produto_end from nonvisualobject
end type
global uo_ge666_atualiza_bloqueio_produto_end uo_ge666_atualiza_bloqueio_produto_end

forward prototypes
public function boolean of_processa_bloqueio_produto_end ()
public function boolean of_envia_email (string as_assunto_email, string as_msg_completa, ref string al_msg_erro)
public subroutine of_mensagem_email ()
public function boolean of_atualiza_bloqueio_prod_end (long al_nr_bloqueio, ref string as_log)
end prototypes

public function boolean of_processa_bloqueio_produto_end ();
Date ldh_hoje,&
		ldt_inicio,&
		ldt_termino
		
Datetime ldt_Data

Long	ll_Linha,&
		ll_Linhas,&
		ll_nr_wms_localizacao_bloqueio,&
		ll_sequencial,&
		ll_produto,&
		ll_achou,&
		ll_achou_produto_abastecimento,&
		ll_achou_produto_pulmao,&
		ll_caixa_padrao,&
		ll_find
		
		
Integer	li_Erros,&
			li_sucesso

String	ls_Situacao,&
			ls_retorno,&
			ls_matricula,&
			ls_endereco,&
			ls_lote,&
			ls_situacao_bloqueio,&
			ls_bloqueado,&
			ls_erro_banco = '',&
			ls_atualiza_bloqueio,&
			ls_LogErro = '',&
			ls_LogSucesso = '',&
			ls_assunto_email,&
			ls_descricao_produto
			
Boolean lb_Sucesso

Try
	
	ldh_hoje = Date(gf_GetServerDate())
	
	ldt_Data = DateTime(Date(RelativeDate(ldh_hoje, -1)), Time('16:59:59'))
	
	dc_uo_ds_base lds_bloqueio_produto_end
	lds_bloqueio_produto_end = Create dc_uo_ds_base
	
	If Not lds_bloqueio_produto_end.Of_ChangeDataObject('ds_ge666_bloqueio_produto_endereco') then
		ls_retorno = "Erro no ChageDataObject da ds_ge666_bloqueio_produto_endereco." 
		Return False
	End if
	
	lds_bloqueio_produto_end.Retrieve(ldh_hoje)
	ll_Linhas = lds_bloqueio_produto_end.RowCount()
	
	If ll_Linhas > 0 Then
		lds_bloqueio_produto_end.setsort('id_situacao A')
		lds_bloqueio_produto_end.sort()
	End If
	
	Open(w_Aguarde)
	
	w_Aguarde.Title = "Processando: Atualiza$$HEX2$$e700e300$$ENDHEX$$o de bloqueios dos produtos bloqueados no endere$$HEX1$$e700$$ENDHEX$$o no Estoque Central...."
	w_Aguarde.uo_Progress.of_setmax(ll_Linhas)
	
		
	For ll_Linha = 1 To ll_Linhas
		
		w_Aguarde.Title = "Atualizando os produtos bloqueado no endere$$HEX1$$e700$$ENDHEX$$o: " + String(ll_Linha) + " de " + String(ll_Linhas)
		w_Aguarde.uo_Progress.of_setprogress(ll_Linha)

		lb_Sucesso = False
		
		ll_nr_wms_localizacao_bloqueio	=	lds_bloqueio_produto_end.Object.nr_wms_localizacao_bloqueio	[ll_Linha]
		ls_endereco								=	lds_bloqueio_produto_end.Object.cd_endereco						[ll_Linha]
		ll_produto								=	lds_bloqueio_produto_end.Object.cd_produto						[ll_Linha]
		ll_sequencial							=	lds_bloqueio_produto_end.Object.nr_sequencial					[ll_Linha]	
		ls_lote									=	lds_bloqueio_produto_end.Object.nr_lote							[ll_Linha]
		ll_caixa_padrao						=	lds_bloqueio_produto_end.Object.qt_caixa_padrao					[ll_Linha]
		ldt_inicio								=	lds_bloqueio_produto_end.Object.dh_inicio							[ll_Linha]
		ldt_termino								=	lds_bloqueio_produto_end.Object.dh_termino						[ll_Linha]
		ls_descricao_produto					=	lds_bloqueio_produto_end.Object.de_produto						[ll_Linha]
		ls_situacao_bloqueio					=	lds_bloqueio_produto_end.Object.id_situacao						[ll_Linha]
		
		Select id_bloqueado
		Into :ls_bloqueado
		From wms_localizacao
		Where cd_endereco = :ls_endereco
		And nr_sequencial = :ll_sequencial
		And cd_produto = :ll_produto
		And qt_caixa_padrao  = :ll_caixa_padrao
		And nr_lote		= :ls_lote
		Using SqlCa;
		
		Choose Case SqlCa.Sqlcode
			Case 100
				ls_LogSucesso += "N$$HEX1$$e300$$ENDHEX$$o foi poss$$HEX1$$ed00$$ENDHEX$$vel Bloquear/Desbloquear o produto "+ ls_descricao_produto +", pois ele n$$HEX1$$e300$$ENDHEX$$o foi encontrado no endere$$HEX1$$e700$$ENDHEX$$o "+ ls_endereco +" lote "+ ls_lote + " nr_bloqueio:" +&
										string(ll_nr_wms_localizacao_bloqueio) + ". "
				li_Sucesso++
				
				If ls_situacao_bloqueio = 'E' Then 
					ls_LogSucesso += "<br>"
					Continue 
				End If
				
				If of_atualiza_bloqueio_prod_end(ll_nr_wms_localizacao_bloqueio, Ref ls_retorno) Then
					ls_LogSucesso += ls_retorno
					Continue
				End If
				
			Case -1
				ls_erro_banco = sqlca.sqlerrtext
				SqlCa.of_RollBack()
				ls_LogErro += "Erro em localiza do produto "+ ls_descricao_produto +" no endere$$HEX1$$e700$$ENDHEX$$o "+ ls_endereco +" na tabela wms_localizacao. nr_bloqueio:"+ string(ll_nr_wms_localizacao_bloqueio)+". Erro:" +&
										ls_erro_banco +".<br>"
				li_Erros++
				Continue
				
			Case 0 
				If ldt_inicio = ldh_hoje and ldt_termino >= ldh_hoje and ls_situacao_bloqueio = 'V' Then
					If ls_bloqueado = 'N' Then
							Select count(*)
							Into :ll_achou_produto_abastecimento
							From wms_abastecimento_flow_rack
							Where cd_endereco_retirada = :ls_endereco
							And cd_produto = :ll_produto
							And nr_lote = :ls_lote
							And qt_caixa_padrao = :ll_caixa_padrao
							Using SqlCa;
							
							If SqlCa.SqlCode = -1 Then
								ls_erro_banco = sqlca.sqlerrtext
								SqlCa.of_RollBack()
								ls_LogErro += "Erro Localiza$$HEX2$$e700e300$$ENDHEX$$o do produto "+ ls_descricao_produto +" no endere$$HEX1$$e700$$ENDHEX$$o "+ ls_endereco +" na tabela wms_lista_separacao_produto nr_bloqueio:"+ string(ll_nr_wms_localizacao_bloqueio)+&
														" "+ ls_erro_banco +".<br>"
								li_Erros++
								Continue
							End If
							
							
							If ll_achou_produto_abastecimento = 0 Then
								Select Count(*)
								Into :ll_achou_produto_pulmao
								FROM wms_lista_separacao ls
								Inner Join wms_lista_separacao_produto lsp
									On  lsp.cd_filial               = ls.cd_filial
									And lsp.nr_pedido_distribuidora = ls.nr_pedido_distribuidora
									And lsp.nr_volume               = ls.nr_volume 
								Where ls.dh_geracao >= :ldt_Data and lsp.cd_endereco_localizacao = :ls_endereco
								Using SqlCa;
								
								If SqlCa.SqlCode = -1 Then
									ls_erro_banco = sqlca.sqlerrtext
									SqlCa.of_RollBack()
									ls_LogErro += "Erro Localiza$$HEX2$$e700e300$$ENDHEX$$o do produto "+ ls_descricao_produto +" no endere$$HEX1$$e700$$ENDHEX$$o "+ ls_endereco +" na tabela wms_lista_separacao_produto nr_bloqueio:"+ string(ll_nr_wms_localizacao_bloqueio)+&
														" Erro:"+ SqlCa.SqlErrText +".<br>"
									li_Erros++
									Continue
								End If
								
								If ll_achou_produto_pulmao = 0 Then
									ls_atualiza_bloqueio = 'S'
									lb_Sucesso = True										
								Else
									ls_LogSucesso += "Produto "+ ls_descricao_produto +" no endere$$HEX1$$e700$$ENDHEX$$o "+ ls_endereco +", N$$HEX1$$e300$$ENDHEX$$o foi bloqueado consta na lista de lista separacao [wms_lista_separacao_produto].  Nr_bloqueio:"+&
																string(ll_nr_wms_localizacao_bloqueio) + ". "
									li_Sucesso++
									
									If of_atualiza_bloqueio_prod_end(ll_nr_wms_localizacao_bloqueio, Ref ls_retorno) Then
										ls_LogSucesso += ls_retorno
										Continue
									End If
								End If
							Else
								ls_LogSucesso += "Produto "+ ls_descricao_produto +" no endere$$HEX1$$e700$$ENDHEX$$o "+ ls_endereco +"  Nr_bloqueio:"+ string(ll_nr_wms_localizacao_bloqueio)+&
															", N$$HEX1$$e300$$ENDHEX$$o foi bloqueado consta na lista de abastecimento flow rack [wms_abastecimento_flow_rack]. "
								li_Sucesso++
								
								If of_atualiza_bloqueio_prod_end(ll_nr_wms_localizacao_bloqueio, Ref ls_retorno) Then
									ls_LogSucesso += ls_retorno
									Continue
								End If
							End If
						End If
				Else
					If ls_situacao_bloqueio = 'E' Then
						If ldt_termino =  date(ldt_Data) Then 						
							If ls_bloqueado = 'S' Then
								ls_atualiza_bloqueio = 'N'
								lb_Sucesso = True
							End IF
						End If
					End If
				End If
				
		End Choose
		
		If lb_Sucesso THen
			Update wms_localizacao
			set id_bloqueado = :ls_atualiza_bloqueio
			Where cd_endereco = :ls_endereco
			And nr_sequencial = :ll_sequencial
			And cd_produto = :ll_produto
			And qt_caixa_padrao  = :ll_caixa_padrao
			And nr_lote		= :ls_lote
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				ls_erro_banco = sqlca.sqlerrtext
				SqlCa.of_RollBack()
				ls_LogErro += "Erro em atualizar a situa$$HEX2$$e700e300$$ENDHEX$$o bloqueio na tabela [wms_localizacao]. ~n Endereco:"+ ls_endereco +" Produto: "+ ls_descricao_produto +&
									" Seguencial:"+ string(ll_sequencial) +" Nr_bloqueio:"+ string(ll_nr_wms_localizacao_bloqueio)+" Erro:"+ ls_erro_banco +".<br>"
 				li_Erros++
			Else 
				SqlCa.of_Commit()
				
				If ls_atualiza_bloqueio = 'N' Then
					ls_Situacao = 'Desbloqueado'
				Else
					ls_Situacao = 'Bloqueado'
				End If
				
				ls_LogSucesso += "Produto "+ ls_descricao_produto +" foi atualizado a situa$$HEX2$$e700e300$$ENDHEX$$o para " + ls_Situacao + " no endere$$HEX1$$e700$$ENDHEX$$o "+ ls_endereco + ".<br>"
				li_Sucesso++	
			End If
		Else
			SqlCa.of_RollBack()
		End If	
	Next
	
	If li_Sucesso > 0 Then
		If Isnull(ls_LogSucesso) Then
			ls_LogSucesso =  'Mensagem vazia, Verifica os produtos que foram atualizado o bloqueio/desbloquio no endere$$HEX1$$e700$$ENDHEX$$o.'
		End If
		
		ls_assunto_email = 'PROCESSO DE BLOQUEIOS/DESBLOQUEIOS DO PRODUTOS NO ENDERE$$HEX1$$c700$$ENDHEX$$O'
		
		If Not of_Envia_Email(ls_assunto_email, ls_LogSucesso, Ref ls_retorno) Then Return True
	End If 
	
	If li_Erros > 0 Then
		If Isnull(ls_LogErro) Then
			ls_LogErro = 'Mensagem vazia, Verifica o erro na atualiza$$HEX2$$e700e300$$ENDHEX$$o do bloqueio do produto no endere$$HEX1$$e700$$ENDHEX$$o.'
		End If
		
		ls_assunto_email = 'ERRO NO PROCESSO DE BLOQUEIOS/DESBLOQUEIOS DOS PRODUTOS NO ENDERE$$HEX1$$c700$$ENDHEX$$O'
		
		If Not of_Envia_Email(ls_assunto_email, ls_LogErro, Ref ls_retorno) Then Return True
	End If

Finally
	SqlCa.of_RollBack()
	Destroy(lds_bloqueio_produto_end)
	Close(w_Aguarde)
End Try

Return True

end function

public function boolean of_envia_email (string as_assunto_email, string as_msg_completa, ref string al_msg_erro);String lvs_Msg


s_email lst_Email

lst_Email.ps_assunto = as_assunto_email
lst_Email.ps_mensagem = as_msg_completa
lst_Email.pb_assinatura = True

If Not IsNull(as_msg_completa) Then
	If (SqlCa.Database = 'central') Then
		If Not gf_ge202_envia_email_padrao(352, lst_email, False) Then
			al_msg_erro = 'Erro em enviar o email para informar a atualiza$$HEX2$$e700e300$$ENDHEX$$o do produto bloqueado.'
			Return False	
		End If
	End If
End If


Return True

end function

public subroutine of_mensagem_email ();
end subroutine

public function boolean of_atualiza_bloqueio_prod_end (long al_nr_bloqueio, ref string as_log);String ls_erro 

date ldt_data

ldt_data = RelativeDate(Date(gf_GetServerDate()),-1)

Update wms_localizacao_bloqueio
	set dh_termino = :ldt_data,
			dh_atualizacao_bloqueio = getdate()
Where nr_wms_localizacao_bloqueio = :al_nr_bloqueio
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_erro = sqlca.sqlerrtext
	SqlCa.of_RollBack()
	as_log = "Obs.: Erro em encerrar o bloqueio na tabela wms_localizacao_bloqueio, nr_bloqueio:"+ string(al_nr_bloqueio)+	". Erro:"+ ls_erro +".<br>"
Else
	as_log = "Obs.: O status do pedido foi modificado para 'Encerrado' por meio de um ajuste de data de termino para o dia "+string(ldt_data)+"<br>"
	SqlCa.Of_commit()
End If

Return True
end function

on uo_ge666_atualiza_bloqueio_produto_end.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge666_atualiza_bloqueio_produto_end.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

