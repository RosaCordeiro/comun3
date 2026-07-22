HA$PBExportHeader$uo_ge527_processa_notas_cd.sru
forward
global type uo_ge527_processa_notas_cd from nonvisualobject
end type
end forward

global type uo_ge527_processa_notas_cd from nonvisualobject
end type
global uo_ge527_processa_notas_cd uo_ge527_processa_notas_cd

type variables
String is_objeto

end variables

forward prototypes
public function boolean of_envia_email (string as_mensagem)
public function boolean of_processa_atualizacao_saldo ()
public function boolean of_inicia_processo ()
end prototypes

public function boolean of_envia_email (string as_mensagem);String ls_Anexo[]

String ls_Log

ls_Log = 'Houveram problemas na atualiza$$HEX2$$e700e300$$ENDHEX$$o de estoque das notas de transfer$$HEX1$$ea00$$ENDHEX$$ncia do CD. <br>' + as_mensagem 

If Not gf_ge202_envia_email_automatico(239, "", ls_Log, ls_Anexo) Then
	Return False
End If

Return True

end function

public function boolean of_processa_atualizacao_saldo ();Long ll_Linha
Long ll_Linhas
Long ll_Filial_Origem
Long ll_Nota

DateTime ldh_Movimentacao

String ls_Especie
String ls_Serie
String ls_Retorno
String ls_Chave_Log
String ls_Chave_Log_2

dc_uo_ds_base lds_Notas_Pendentes

try 
	lds_Notas_Pendentes = Create dc_uo_ds_base
	
	Open(w_Aguarde)
	
	w_Aguarde.Title = "Atualizando Saldo NF Transf. CD..."
		
	If Not This.of_inicia_processo() Then Return False
	
	If Not lds_Notas_Pendentes.of_ChangeDataObject( 'ds_ge527_lista_notas_pendentes', False ) Then
		of_envia_email(is_objeto +  "Erro na mudan$$HEX1$$e700$$ENDHEX$$a da datastore 'ds_to005_lista_notas_pendentes'.")
		Return False
	End If
	
	ll_Linhas = lds_Notas_Pendentes.Retrieve()
	
	If ll_Linhas = 0 Then Return True
	
	If ll_Linhas > 0 Then
		
		w_aguarde.uo_progress.of_setmax(ll_Linhas)
	
		For ll_Linha = 1 To ll_Linhas
			
			w_Aguarde.Title = "Atualizando Saldo NF Transf. CD - " + String(ll_Linha) +  ' de: '  +  String(ll_Linhas)

			ll_Filial_Origem		= lds_Notas_Pendentes.Object.Cd_Filial_Origem	[ ll_Linha ]
			ll_Nota 				= lds_Notas_Pendentes.Object.Nr_Nf					[ ll_Linha ]
			ls_Especie 			= lds_Notas_Pendentes.Object.De_Especie			[ ll_Linha ]
			ls_Serie 				= lds_Notas_Pendentes.Object.De_Serie				[ ll_Linha ]
			ldh_Movimentacao	= lds_Notas_Pendentes.Object.Dh_Movimentacao	[ ll_Linha ]
			
			ls_Chave_Log = 'Filial: <b>' + String( ll_Filial_Origem ) +'</b><br>' 
			ls_Chave_Log += 'Nota: <b>' + String( ll_Nota ) +'</b><br>'
			ls_Chave_Log += 'Esp$$HEX1$$e900$$ENDHEX$$cie: <b>' + ls_Especie +'</b><br>'
			ls_Chave_Log += 'S$$HEX1$$e900$$ENDHEX$$rie: <b>' + ls_Serie +'</b><br>'
			
			ls_Chave_Log_2 = 'CHAVE: ( cd_filial_origem - nr_nf - de_especie - de_serie ) - ( ' + &
									String( ll_Filial_Origem ) + " - " + &
								 	String( ll_Nota ) + " - " + &
								 	ls_Especie + " - " + &
								 	ls_Serie + &
								 	' ) :: '
					
			Declare sp_atualiza Procedure For	sp_atualiza_saldo_transf_ec
									@cd_filial		= :ll_Filial_Origem,
									@nr_nf			= :ll_Nota,
									@de_especie	= :ls_Especie,
									@de_serie		= :ls_Serie,
									@mensagem_retorno = :ls_Retorno
			Using SqlCa;
					
			Execute sp_atualiza;
			
			Choose Case SqlCa.SqlCode
				Case -1
					ls_Chave_Log += 'Erro: <b>' + SqlCa.SqlErrText + '</b><br>'
					of_Envia_Email(ls_Chave_Log)
					gvo_Aplicacao.of_Grava_Log( ls_Chave_Log_2 + SqlCa.SqlErrText)
					Close sp_atualiza;
					Return False
			End Choose
			
			Fetch sp_atualiza Into :ls_Retorno;
			
			If Trim( ls_Retorno ) <> '' Then
				ls_Chave_Log += 'Erro: <b>' + ls_Retorno + '</b><br>'
				of_envia_email(ls_Chave_Log)
				gvo_Aplicacao.of_Grava_Log( ls_Chave_Log_2 +  ls_Retorno)
				w_aguarde.uo_progress.of_setprogress(ll_Linha)
			End If
			
			Close sp_atualiza;
			
			w_aguarde.uo_progress.of_setprogress(ll_Linha)			
		Next
		
	ElseIf ll_Linhas < 0 Then
		of_envia_email(is_objeto +  "Erro ao recuperar os dados da 'ds_to005_lista_notas_pendentes'.")
		gvo_Aplicacao.of_Grava_Log(is_objeto +  "Erro ao recuperar os dados da 'ds_to005_lista_notas_pendentes'.")
		Return False
	End If
		
catch ( runtimeerror  lo_rte )
	of_envia_email(is_objeto+  "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_inicia_processo'. Erro: "+lo_rte.GetMessage( ))
	gvo_Aplicacao.of_Grava_Log(is_objeto+  "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_inicia_processo'. Erro: "+lo_rte.GetMessage( ))
	Return False				
finally
	Destroy lds_Notas_Pendentes
	Close(w_Aguarde)
end try

Return True
end function

public function boolean of_inicia_processo ();try 
	
	Update nf_transferencia
		Set id_atualizacao_mov_estoque = 'P'
	Where id_atualizacao_mov_estoque = 'N'
	  Using SqlCa;
	  
	If SqlCa.SqlCode = -1 Then
		of_envia_email(is_objeto +  "Erro ao atualizar o in$$HEX1$$ed00$$ENDHEX$$cio do processo de atualiza$$HEX2$$e700e300$$ENDHEX$$o de estoque 'of_inicia_processo'. Erro: " + SqlCa.SqlErrText)
		gvo_Aplicacao.of_Grava_Log(is_objeto +  "Erro ao atualizar o in$$HEX1$$ed00$$ENDHEX$$cio do processo de atualiza$$HEX2$$e700e300$$ENDHEX$$o de estoque 'of_inicia_processo'. Erro: " + SqlCa.SqlErrText)
		SqlCa.of_RollBack()
		Return False
	End If
	  
	If SqlCa.SqlNRows > 0 Then SqlCa.of_Commit()
	
catch ( runtimeerror  lo_rte )
	of_Envia_Email(is_objeto+  "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_inicia_processo'. Erro: "+lo_rte.GetMessage( ))
	gvo_Aplicacao.of_Grava_Log(is_objeto+  "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_inicia_processo'. Erro: "+lo_rte.GetMessage( ))
	Return False				
finally
end try

Return True



end function

on uo_ge527_processa_notas_cd.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge527_processa_notas_cd.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;is_objeto = 'Objeto: [' + this.classname() + '] ~n'
end event

