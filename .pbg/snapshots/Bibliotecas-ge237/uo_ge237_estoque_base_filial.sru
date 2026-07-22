HA$PBExportHeader$uo_ge237_estoque_base_filial.sru
forward
global type uo_ge237_estoque_base_filial from nonvisualobject
end type
end forward

global type uo_ge237_estoque_base_filial from nonvisualobject
end type
global uo_ge237_estoque_base_filial uo_ge237_estoque_base_filial

type variables
uo_smtp io_smtp							//GE202

dc_uo_ds_base ids_Relatorio

dc_uo_ds_base ids_Filiais

Boolean ib_Erro = False
end variables

forward prototypes
public function boolean of_salva_arquivo (string ps_path)
public function boolean of_atualiza_controle_relatorio (integer al_filial, datetime adh_solicitacao)
public subroutine of_gera_relatorio ()
public function boolean of_envia_relatorio (string as_caminho_anexo, long pl_filial)
end prototypes

public function boolean of_salva_arquivo (string ps_path);Integer li_Retorno
            			
// Verifica se j$$HEX1$$e100$$ENDHEX$$ existe o arquivo
If FileExists(ps_Path) Then
	If Not FileDelete(ps_Path) Then
		gvo_Aplicacao.Of_Grava_Log("- Nao foi possivel excluir o arquivo " + ps_Path )
		Return False
	End If   
End If
							 
If ids_Relatorio.SaveAs( ps_Path, Excel!, True ) = 1 Then
	Return True
Else
	Return False
End If

end function

public function boolean of_atualiza_controle_relatorio (integer al_filial, datetime adh_solicitacao);Boolean lb_Sucesso = True

Update controle_relatorio_eb
	Set dh_geracao 		= getdate()
Where cd_filial 			= :al_Filial
	and dh_solicitacao 	= :adh_solicitacao
Using SqlCa;

If SqlCa.SqlCode <> 0 Then
	gvo_Aplicacao.Of_Grava_Log("- Erro ao gravar a data de geracao na tabela controle_relatorio_eb. Registro:  Filial: "  + String( al_Filial ) + " - Dh_Solicitacao: " + String( adh_Solicitacao ) + sqlCa.SqlErrText)
	lb_Sucesso = False
End If

If lb_Sucesso Then
	SqlCa.of_Commit()
Else
	SqlCa.of_RollBack()
End if

Return lb_Sucesso
end function

public subroutine of_gera_relatorio ();Long ll_Row
Long ll_Linhas
Long ll_Linhas_Filiais
Long ll_Filial

DateTime ldh_Solicitacao

String ls_Arquivo
String ls_Path

ls_Path = gvo_Aplicacao.ivs_Path_Arquivos

Open( w_Aguarde )
w_Aguarde.Title = "Processo iniciado, aguarde..."

gvo_Aplicacao.Of_Grava_Log("- *** Relatorio Estoque Base Bloqueado: Inicio do processo..." )		

If Not ids_Filiais.Of_ChangeDataObject("ds_ge237_filiais" ) Then
	gvo_Aplicacao.Of_Grava_Log(" - Erro no ChangeDataObject da DataStore de Filiais.")
	Close( w_Aguarde )
	ib_Erro = True
	Return	
End If

If Not ids_Relatorio.Of_ChangeDataObject("dw_ge237_relatorio" ) Then
	gvo_Aplicacao.Of_Grava_Log("Erro no ChangeDataObject da DataStore Relat$$HEX1$$f300$$ENDHEX$$rio.")
	Close( w_Aguarde )
	ib_Erro = True
	Return	
End If

ll_Linhas_Filiais = ids_Filiais.Retrieve()

Choose Case ll_Linhas_Filiais

	Case -1
		gvo_Aplicacao.Of_Grava_Log("- Erro no retrieve das filiais que solicitaram o relat$$HEX1$$f300$$ENDHEX$$rio.")
	Case 0
		gvo_Aplicacao.Of_Grava_Log("- Nenhuma filial solicitou o relat$$HEX1$$f300$$ENDHEX$$rio do estoque base.")	
	Case Else
	
		w_Aguarde.uo_Progress.of_SetMax( ll_Linhas_Filiais )
		
		For ll_Row = 1 To ll_Linhas_Filiais
			
			ll_Filial 				= ids_Filiais.Object.cd_filial 			[ ll_Row ]
			ldh_Solicitacao 	= ids_Filiais.Object.dh_solicitacao [ ll_Row ]
			
			w_Aguarde.Title = "Processando a filial " + String( ll_Filial )
								
			ll_Linhas = ids_Relatorio.Retrieve( ll_Filial ) 
			
			If ll_Linhas <= 0 Then 
				gvo_Aplicacao.Of_Grava_Log("- N$$HEX1$$e300$$ENDHEX$$o existe produtos com estoque base bloqueado para filial: " + String( ll_Filial ) )		
			Else
			
				ls_Arquivo = ls_Path + String( ll_Filial, "0000" ) +"_Bloqueio_Estoque_Base_" + String( Today(), "ddmm" ) + ".XLS"
				
				If Not of_salva_arquivo( ls_Arquivo ) Then
					gvo_Aplicacao.Of_Grava_Log("- Nao foi possivel salvar o relatorio de alteracoes do estoque base da filial: " + String( ll_Filial, "dd/mm/yyyy" ) )
					ib_Erro = True
					Continue
				End If
				
				If Not of_Envia_Relatorio( ls_Arquivo, ll_Filial ) Then
					gvo_Aplicacao.Of_Grava_Log("- Nao foi possivel enviar o email para a filial "  + String( ll_Filial ) )
					ib_Erro = True
					Continue		
				End If
				
				//Atualiza o controle relatorio para processado.
				If Not of_Atualiza_Controle_Relatorio( ll_Filial, ldh_Solicitacao ) Then
					ib_Erro = True
					Continue
				End If
				
				gvo_Aplicacao.Of_Grava_Log("- Filial: " + String( ll_Filial, "0000" )  + "   Envio de e-mail OK") 
				
				If Not FileDelete(ls_Arquivo) Then
					gvo_Aplicacao.Of_Grava_Log("- Nao foi possivel excluir o arquivo " + ls_Arquivo )
					ib_Erro = True
					Continue
				End If
				
			End If
			
			w_Aguarde.uo_Progress.of_SetProgress( ll_Row )
			
			Yield()
			
		Next
		
End Choose

Close( w_Aguarde )

gvo_Aplicacao.Of_Grava_Log("- *** Relatorio Estoque Base Bloqueado: Termino do processo..." )		

end subroutine

public function boolean of_envia_relatorio (string as_caminho_anexo, long pl_filial);//String ls_Anexo[]
//String ls_TO[]
//String ls_Cc[]
//
////ls_TO 	= { String(pl_Filial,"0000") + "@drogarialocal.com.br" } 
//ls_TO 	= { "anderson.lima@clamed.com.br" } 
//
////ls_Cc 	= {"wagner.frasseto@clamed.com.br"}
//
//ls_Anexo = { as_caminho_anexo }
//
//io_smtp.of_envia_email_anexo("DESENVOLVIMENTO DE SISTEMAS", &
//							  "sistemas@clamed.com.br", + &
//							  "Relat$$HEX1$$f300$$ENDHEX$$rio de Produtos com Estoque Base Bloqueado", + &
//							  "Em anexo o arquivo", + &
//							  ls_To,ls_Cc,ls_Anexo)
//						  
//If io_smtp.is_LastError <> "" Then 
//	//ls_To = {"wagner.frasseto@clamed.com.br","fernando.correa@clamed.com.br"}
//	ls_To 		=	{"wagner.frasseto@clamed.com.br"}
//	io_smtp.of_envia_email("DESENVOLVIMENTO DE SISTEMAS", &
//									  "sistemas@clamed.com.br", &
//									  "ERRO - Relat$$HEX1$$f300$$ENDHEX$$rio de Produtos com Estoque Base Bloqueado" , &
//									  "Filial:" + String ( pl_Filial ), &
//									  ls_TO)
//	Return False
//	
//End If
//
//Return True

s_email str

str.ps_to[1]  = String(pl_Filial,"0000") + "@drogarialocal.com.br"

str.ps_anexo = { as_caminho_anexo }

gf_ge202_envia_email_padrao(80, str)

Return True
end function

on uo_ge237_estoque_base_filial.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge237_estoque_base_filial.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;io_smtp 		= Create uo_Smtp

ids_Relatorio 	= Create dc_uo_ds_base

ids_Filiais		= Create dc_uo_ds_base
end event

event destructor;Destroy io_smtp
Destroy ids_Relatorio
Destroy ids_Filiais
end event

