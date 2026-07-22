HA$PBExportHeader$uo_ge571_enderecos_wms.sru
forward
global type uo_ge571_enderecos_wms from nonvisualobject
end type
end forward

global type uo_ge571_enderecos_wms from nonvisualobject
end type
global uo_ge571_enderecos_wms uo_ge571_enderecos_wms

forward prototypes
public subroutine _documentacao ()
public function boolean of_processa_exclusao_endereco (long al_produto)
end prototypes

public subroutine _documentacao ();/*
  Objetivo:  Executar na esteira de controlados e eliminar registro na tabela wms_endereco_produto
  que n$$HEX1$$e300$$ENDHEX$$o tem saldo.

*/
end subroutine

public function boolean of_processa_exclusao_endereco (long al_produto);//Fun$$HEX2$$e700e300$$ENDHEX$$o para Excluir Enderecos de Flow e Pulm$$HEX1$$e300$$ENDHEX$$o
//Apenas para CONTROLADO
Long ll_Linha, ll_Linhas
Long ll_Produto, ll_seconds_after
DateTime	ldt_dh_inclusao, ldt_agora
String ls_Endereco, ls_Lote, ls_msg, ls_Anexo[], ls_Parametro_Endereco_Abast, ls_data_window
Boolean lb_Sucesso = True


Try 
	dc_uo_ds_base lds_1
	lds_1 = Create dc_uo_ds_base

	// Carrega Parametro: Se parametro "SIM", N$$HEX1$$e300$$ENDHEX$$o cadastra endere$$HEX1$$e700$$ENDHEX$$os autom. Controlado
	If Not gf_wms_endereco_abast( Ref  ls_Parametro_Endereco_Abast) Then Return False

	If ls_Parametro_Endereco_Abast = "S" Then 
		ls_data_window = "dw_ge571_endereco_vazio_controlado_nova"	
	Else
		ls_data_window = "dw_ge571_endereco_vazio_controlado"		
	End If 
		
	If Not lds_1.of_ChangeDataObject(ls_data_window, False) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao trocar a DW [" + ls_data_window + "].", StopSign!)
		Return False
	End If 
	
	// Caso tenha um produto.
	If al_produto > 0 Then 		
		lds_1.of_appendwhere (' a.cd_produto = ' + string(al_produto) )
	End If 
	
	ll_Linhas = lds_1.retrieve()
		
	If ll_Linhas >0 Then
	
			// Para Carregando....
			If Not IsValid(w_aguarde) then
			Open(w_aguarde)
			End If
			w_aguarde.Title = "WMS-Processando Exclusao Endere$$HEX1$$e700$$ENDHEX$$os Controlado."
			w_aguarde.uo_progress.of_reset()
			w_aguarde.uo_progress.Of_SetMax(ll_linhas)
	
	
			For ll_Linha = 1 To ll_Linhas
				// Para Carregando
				w_aguarde.Title = "WMS-Processando Exclusao Endere$$HEX1$$e700$$ENDHEX$$os Controlado:" + String(ll_Linha)+" De :"+String(ll_Linhas)
				// Campos da Data Window
				ll_Produto = lds_1.Object.cd_produto[ll_Linha]
				ls_Endereco = lds_1.Object.cd_endereco [ll_Linha]
				ls_Lote = lds_1.Object.nr_lote [ll_Linha]
				ldt_dh_inclusao = lds_1.Object.dh_inclusao[ll_Linha]
				
				ldt_agora	= gf_GetServerDate()
				
				ll_seconds_after = SecondsAfter(Time(ldt_dh_inclusao), Time(ldt_agora)) + (DaysAfter(Date(ldt_dh_inclusao), Date(ldt_agora)) * 86400)
				
				//Se tiver passado menos de uma hora da cria$$HEX2$$e700e300$$ENDHEX$$o do endere$$HEX1$$e700$$ENDHEX$$o ele n$$HEX1$$e300$$ENDHEX$$o pode excluir automaticamente.
				if ll_seconds_after <= 3600 then
					Continue
				end if
				
				// Atualza Matricula antes
				Update  wms_endereco_produto
				Set nr_matricula_responsavel = '14330'
				Where cd_produto =:ll_Produto
				And cd_endereco =:ls_Endereco
				Using SqlCA;
			
				If SqlCa.SqlCode = -1 Then
					lb_Sucesso = False
					ls_msg = "Erro ao alterar matricula endereco do Produto:"+String(ll_Produto) + "Endere$$HEX1$$e700$$ENDHEX$$o:" + String(ls_Endereco)
					gf_ge202_envia_email_automatico(277, '',ls_MSG, ls_Anexo)
					SqlCa.of_Rollback()
					Exit
				End If
			
				// Apaga Enderecos que n$$HEX1$$e300$$ENDHEX$$o tem Saldo No CD
				Delete from wms_endereco_produto
				Where cd_produto =:ll_Produto
				And cd_endereco =:ls_Endereco
				Using SqlCA;
		
				If SqlCa.SqlCode = -1 Then
					lb_Sucesso = False
					ls_msg = "Erro ao excluir endereco do Produto:"+String(ll_Produto) + "Endere$$HEX1$$e700$$ENDHEX$$o:" + String(ls_Endereco)
					gf_ge202_envia_email_automatico(277, '',ls_MSG, ls_Anexo)
					SqlCa.of_Rollback()
					Exit
				End If
		
			// Para Carregando
			w_aguarde.uo_progress.Of_SetProgress(ll_Linha)
		Next
	End If
Finally
	If lb_Sucesso Then
		SqlCa.of_commit( )
	End If

	// Destroy Objetos
	If IsValid(w_aguarde) Then Close(w_aguarde)
	If IsValid(lds_1) Then Destroy(lds_1)
End try

Return lb_Sucesso




end function

on uo_ge571_enderecos_wms.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge571_enderecos_wms.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

