HA$PBExportHeader$uo_ge486_comissao_produto.sru
forward
global type uo_ge486_comissao_produto from nonvisualobject
end type
end forward

global type uo_ge486_comissao_produto from nonvisualobject
end type
global uo_ge486_comissao_produto uo_ge486_comissao_produto

forward prototypes
public function boolean of_atualiza_comissao (long al_produto, integer al_tipo_comissao, date adh_movimento, ref string as_log)
end prototypes

public function boolean of_atualiza_comissao (long al_produto, integer al_tipo_comissao, date adh_movimento, ref string as_log);Date ldh_Inicio_Comissao

Boolean lb_Sucesso = True

Long ll_Linhas
Long ll_Linha
Long ll_Produto
Long ll_Tipo_Comissao
Long ll_Achou

Decimal ldc_PC_Comissao_SAP
Decimal ldc_PC_Comissao_Legado
Decimal ldc_PC_Comissao_Atual

String ls_Msg_Email
String ls_Chave
String ls_Nulo

SetNull(ls_Nulo)

// Produ$$HEX2$$e700e300$$ENDHEX$$o
If gvo_Aplicacao.ivs_DataSource = 'central' Then
	If Not lf_ge486_inicio_comissao_sap(ref ldh_Inicio_Comissao, as_log) Then Return False	
	// N$$HEX1$$e300$$ENDHEX$$o faz nada
	If ldh_Inicio_Comissao > adh_movimento Then Return True
End If

dc_uo_ds_base lds 

Try
	
	If Not IsValid(w_Aguarde_1) Then Open(w_Aguarde_1)
		
	w_Aguarde_1.Title = "Atualizando Comiss$$HEX1$$e300$$ENDHEX$$o de Produto do tipo [" + String(al_Tipo_Comissao) +  "] ..."

	w_aguarde_1.uo_progress.of_setstart()
		
	// Sistema Carga
	If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = "CA" Then
		gvo_Aplicacao.of_Grava_Log("In$$HEX1$$ed00$$ENDHEX$$cio - Atualiza$$HEX2$$e700e300$$ENDHEX$$o Comiss$$HEX1$$e300$$ENDHEX$$o Produto")
	End If
	
	lds = Create dc_uo_ds_base
	
	If Not lds.of_changedataobject('ds_ge486_lista_produto_atualizacao') Then
		as_Log = "Erro ao alterar a DS [ds_ge486_lista_produto_atualizacao], objeto [uo_ge486_comissao_produto], fun$$HEX2$$e700e300$$ENDHEX$$o of_atualiza_comissao."
		Return False
	End If
	
	If Not IsNull(al_produto) and al_produto > 0 Then
		lds.of_appendwhere_subquery( "g.cd_produto = " + String(al_produto) , 1)
	End If
	
	ll_Linhas = lds.Retrieve(al_tipo_comissao, adh_movimento)
	
	If ll_Linhas > 0 Then
		
		If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = "CA" Then
			If gvo_Aplicacao.ivs_DataSource <> 'homologa' Then 
				If ll_Linhas >= 2000 Then
					as_log = "Bloqueio para n$$HEX1$$e300$$ENDHEX$$o atualizar a comiss$$HEX1$$e300$$ENDHEX$$o de mais que 2000 produtos."
					gvo_Aplicacao.of_Grava_Log(as_log)
					lb_Sucesso = False
					Return False
				End If
			End If
		End If
		
		w_aguarde_1.uo_progress.of_setmax(ll_Linhas)
						
		For ll_Linha = 1 To ll_Linhas
		
			ll_Produto 						= lds.Object.cd_produto				[ll_Linha]
			ldc_PC_Comissao_Legado	= lds.Object.pc_comissao_legado	[ll_Linha]
			ldc_PC_Comissao_SAP		= lds.Object.pc_comissao_sap		[ll_Linha]
			
			ls_Chave = String(ll_Produto) + '@#!' + String(al_Tipo_Comissao)
			
			Select cd_produto, pc_comissao
			Into :ll_Achou, :ldc_PC_Comissao_Atual
			From tipo_comissao_produto
			where cd_produto = :ll_Produto
				and cd_tipo_comissao = :al_tipo_comissao
			Using SqlCa;
			
			Choose Case SqlCa.SqlCode
				Case 0
					
					If ldc_PC_Comissao_SAP > 0 Then
					
						UPDATE tipo_comissao_produto  
						SET pc_comissao =:ldc_PC_Comissao_SAP
						Where cd_produto = :ll_Produto
							and cd_tipo_comissao = :al_tipo_comissao
						Using SqlCa;
						
						If SqlCa.Sqlcode = -1 Then
							as_Log	= "Erro ao atualizar o registro na tabela 'tipo_comissao_produto', produto '" + String(ll_Produto) + "', objeto [uo_ge486_comissao_produto], fun$$HEX2$$e700e300$$ENDHEX$$o of_atualiza_comissao. Erro: "+ SqlCa.SqlErrText
							lb_Sucesso = False
							Return False	
						End If
						
						If Not gf_Grava_Historico_Alteracao_Tabela('TIPO_COMISSAO_PRODUTO', ls_Chave, 'PC_COMISSAO', String(ldc_PC_Comissao_Atual), String(ldc_PC_Comissao_SAP), 'SAP001', 'A', Ref as_log, False) Then Return False
					
					Else
						
						DELETE FROM tipo_comissao_produto
						Where cd_produto 			= :ll_Produto
							and cd_tipo_comissao 	= :al_tipo_comissao
						Using SqlCa;
						
						If SqlCa.Sqlcode = -1 Then
							as_Log	= "Erro ao excluir o registro na tabela 'tipo_comissao_produto', produto '" + String(ll_Produto) + "', objeto [uo_ge486_comissao_produto], fun$$HEX2$$e700e300$$ENDHEX$$o of_atualiza_comissao. Erro: "+ SqlCa.SqlErrText
							lb_Sucesso = False
							Return False	
						End If
						
						If Not gf_Grava_Historico_Alteracao_Tabela('TIPO_COMISSAO_PRODUTO', ls_Chave, 'PC_COMISSAO', String(ldc_PC_Comissao_Atual), String(ldc_PC_Comissao_SAP), 'SAP001', 'E', Ref as_log, False) Then Return False
												
					End If
					
				Case 100
					
					If ldc_PC_Comissao_SAP > 0 Then
					
						INSERT INTO tipo_comissao_produto ( cd_produto, cd_tipo_comissao, pc_comissao)  
						VALUES ( :ll_Produto, :al_tipo_comissao, :ldc_PC_Comissao_SAP )
						Using SqlCa;
						
						If SqlCa.Sqlcode = -1 Then
							as_Log	= "Erro ao inserir o registro na tabela 'tipo_comissao_produto', produto '" + String(ll_Produto) + "', objeto [uo_ge486_comissao_produto], fun$$HEX2$$e700e300$$ENDHEX$$o of_atualiza_comissao. Erro: "+ SqlCa.SqlErrText
							lb_Sucesso = False
							Return False	
						End If
						
						If Not gf_Grava_Historico_Alteracao_Tabela('TIPO_COMISSAO_PRODUTO', ls_Chave, 'PC_COMISSAO', ls_Nulo, String(ldc_PC_Comissao_SAP), 'SAP001', 'I', Ref as_log, False) Then Return False
					
					End If
					
				Case -1
					as_Log	= "Erro ao atualizar o registro na tabela 'tipo_comissao_produto', objeto [uo_ge486_comissao_produto], fun$$HEX2$$e700e300$$ENDHEX$$o of_atualiza_comissao. Erro: "+ SqlCa.SqlErrText
					lb_Sucesso = False
					Return False	
			End Choose							
			
			w_Aguarde_1.uo_progress.of_setprogress(ll_Linha)
		Next
		
	ElseIf ll_Linhas < 0 Then
		as_Log = "Erro ao recuperar os registros da DS [ds_ge486_lista_produto_atualizacao], objeto [uo_ge486_comissao_produto], fun$$HEX2$$e700e300$$ENDHEX$$o of_atualiza_comissao. Erro: " + lds.ivo_dbError.ivs_SqlErrText
		Return False
	End If
				
Catch ( runtimeerror  lo_rte )
	as_log = "Objeto [uo_ge486_comissao_produto], fun$$HEX2$$e700e300$$ENDHEX$$o [of_atualiza_comissao]. RuntimeError: "+lo_rte.GetMessage( )
	Return False		
	
Finally
	
	// Sistema Carga
	If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = "CA" Then
		
		If lb_Sucesso Then
			SqlCa.of_Commit()
		Else
			SqlCA.of_RollBack()
			
			ls_Msg_Email = 'Houveram problemas no sistema CARGA . <br>'+ &
			'Atualiza$$HEX2$$e700e300$$ENDHEX$$o de comiss$$HEX1$$e300$$ENDHEX$$o de produto. <br>'+ &
			 '</ul></ul>'+&
			as_log

			gf_ge202_envia_email_automatico(180 , '', ls_Msg_Email, {''})
		End If
		
		If Not IsNull(as_log) and Trim(as_log) <> "" Then
			gvo_Aplicacao.of_Grava_Log(as_Log)
		End If
		
		gvo_Aplicacao.of_Grava_Log("Fim - Atualiza$$HEX2$$e700e300$$ENDHEX$$o Comiss$$HEX1$$e300$$ENDHEX$$o Produto")
	End If
		
	If IsValid(w_Aguarde_1) Then Close(w_Aguarde_1)
	If IsValid(lds) Then Destroy lds
End Try
	
Return True
end function

event constructor;//
end event

on uo_ge486_comissao_produto.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge486_comissao_produto.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

