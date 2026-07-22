HA$PBExportHeader$uo_ge473_fornecedor_conexao.sru
forward
global type uo_ge473_fornecedor_conexao from nonvisualobject
end type
end forward

global type uo_ge473_fornecedor_conexao from nonvisualobject
end type
global uo_ge473_fornecedor_conexao uo_ge473_fornecedor_conexao

type variables
String is_Fornecedor_Sap
String is_Fornecedor
String is_Liberado
String is_Filial_Sap
Long il_Tabela  = 42 
Long il_Filial



end variables

forward prototypes
public function boolean of_inicializa_variaveis (ref string as_log)
public function boolean of_atualiza_fornecedor_conexao (long al_filial, string as_fornecedor, string as_liberado, ref string as_log)
public subroutine of_processa_atualizacao ()
public function boolean of_executa_fornecedor_conexao (long al_controle, long al_tabela)
end prototypes

public function boolean of_inicializa_variaveis (ref string as_log);Try

	SetNull(is_Filial_Sap)	
	SetNull(il_Filial)
	SetNull(is_liberado)
	SetNull(is_Fornecedor)	
	SetNull(is_Fornecedor_Sap)	

Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro ao iniciar as vari$$HEX1$$e100$$ENDHEX$$veis. Erro: " + lo_rte.GetMessage( )
	Return False						 
End Try

Return True




end function

public function boolean of_atualiza_fornecedor_conexao (long al_filial, string as_fornecedor, string as_liberado, ref string as_log);Long ll_Qtd

select	count(*) 
Into 		:ll_Qtd
from		filial_projeto_conexao
where	cd_filial=:al_filial
and		cd_fornecedor=:as_fornecedor
Using		SqlCa;

If SqlCa.SqlCode = -1 Then
	as_Log	= "Erro ao localizar o registro Filial_projeto_Conexao!." + " Erro: "+ SqlCa.SqlErrText
	Return False
End If 

// Marcado para Inserir e N$$HEX1$$e300$$ENDHEX$$o tem o Registro
If as_liberado  = "X" and ll_Qtd = 0  Then 
	
	INSERT INTO filial_projeto_conexao ( cd_filial, cd_fornecedor )
	VALUES ( :al_filial, :as_fornecedor)
	Using SqlCa;
								
	If SqlCa.SqlCode = -1 Then
		as_Log	= "Erro ao incluir o registro filial_projeto_conexao." + " Erro: "+ SqlCa.SqlErrText
		Return False
	End If
End If 

// Desmarcado : Apagar e tem o Registro 
If IsNull(as_liberado) and ll_Qtd >0 Then 

	Delete from filial_projeto_conexao
	Where	cd_filial=:al_filial
	and		cd_fornecedor=:as_fornecedor
	Using SqlCA;
	
	If SqlCa.SqlCode = -1 Then
		as_Log	= "Erro ao excluir o registro filial_projeto_conexao." + " Erro: "+ SqlCa.SqlErrText
		Return False
	Else
		as_Log	= "Registro exluido com sucesso da filial_projeto_conexao." 
		Return True
	End If 	
End If 

Return True 			

end function

public subroutine of_processa_atualizacao ();Long ll_Linhas
Long ll_Linha

dc_uo_ds_base lds 

try 
	
	lds  = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject('ds_ge473_lista_controles', False) Then 
		gvo_aplicacao.of_grava_log("Interface Produto - Erro alterar a DW [ds_ge473_lista_controles] - uo_ge473_fornecedor_conexao.of_processa_atualizacao" )
		Return
	End If
	
	ll_Linhas = lds.Retrieve(il_Tabela)
	
	If ll_Linhas > 0 Then
		For ll_Linha = 1 To ll_Linhas
											
			uo_ge473_fornecedor_conexao  lo_Fornecedor_Conexao
			 
			Try
				lo_Fornecedor_Conexao	= Create uo_ge473_fornecedor_conexao
				lo_Fornecedor_Conexao.of_executa_fornecedor_conexao(lds.Object.nr_controle[ll_Linha] ,  il_Tabela )
			Finally
				Destroy(lo_Fornecedor_Conexao)
			End Try			
			
		Next
	ElseIf ll_Linhas < 0 Then
		gvo_aplicacao.of_grava_log("Interface FornecedorConexao - Erro ao recuperar os da DW [ds_ge473_lista_controles] - uo_ge473_fornecedor_conexao.of_processa_atualizacao.")
	End If	
	
finally
	Destroy lds
end try
end subroutine

public function boolean of_executa_fornecedor_conexao (long al_controle, long al_tabela);Boolean lb_Sucesso = True

Long ll_Atualizacao_Pend
Long ll_Linhas
Long ll_Linha
Long ll_Pos

String ls_Log
String ls_Tipo_Chave
String ls_PRD_Chave

Try
		
	uo_ge473_comum lo_Comum
	lo_Comum = Create uo_ge473_comum
	
	If Not This.of_inicializa_variaveis(Ref ls_Log) Then Return False
	
	If Not lo_Comum.of_atualizacao_pendente(al_Controle, Ref ll_Atualizacao_Pend, Ref ls_Log) Then Return False
	
	//Controle j$$HEX1$$e100$$ENDHEX$$ foi processado
	If ll_Atualizacao_Pend = 0 Then Return True
	
	If Not lo_Comum.of_Muda_Situacao_Interface(al_Controle, Ref ls_Log) Then Return False

	If lo_Comum.of_processa_carrega_dados(al_controle, ref ls_Log) Then
		
		ll_Linhas = lo_Comum.ids_lista_registros.RowCount()
		
		If ll_Linhas >0 Then 
			
			if isvalid(w_aguarde_3) Then
				w_aguarde_3.uo_progress_2.of_reset()
				w_aguarde_3.uo_progress_2.of_setmax(ll_linhas)
			end if
			
			For ll_Linha = 1 To ll_Linhas		
					
				is_Fornecedor_Sap 	= lo_Comum.ids_lista_registros.Object.cd_fornecedor_sap	[ll_Linha]
				is_Filial_Sap				= lo_Comum.ids_lista_registros.Object.cd_filial_sap				[ll_Linha]
				is_Liberado				= lo_Comum.ids_lista_registros.Object.id_liberado			[ll_Linha]
				
				// Valida Codigo da Filial 
				If Not lo_Comum.of_Localiza_Codigo_Filial_Legado(is_Filial_Sap, Ref il_Filial, Ref ls_Log) Then 
					lb_Sucesso = False
					Return False
				End If 				
				
				// Valida codigo do Fornecedor
				If Not lo_Comum.of_localiza_codigo_fornecedor_legado(is_Fornecedor_Sap , Ref is_Fornecedor, ref ls_Log) Then 
					lb_Sucesso = False
					Return False
				End If 
					
				if isvalid(w_aguarde_3) Then
					w_aguarde_3.wf_settext('Fornecedor: ' + is_fornecedor, 3 )
				end if	
					
				If Not This.of_atualiza_fornecedor_conexao(il_Filial , is_Fornecedor, is_Liberado,  ref ls_Log ) Then
					lb_Sucesso = False
					Return False
				End If
				
				if isvalid(w_aguarde_3) Then
					w_aguarde_3.uo_progress_2.of_setprogress(ll_linha)
				end if
				
			Next
						
		Else
			ls_Log  = "Quantidade de registros recebido na interface esta diferente do esperado 1 para a tabela [interface_sap]. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle)+"."
			lb_Sucesso = False
			Return False
		End If
		
	End If
	
Catch ( runtimeerror  lo_rte )
	ls_Log = "Objeto [uo_ge473_fornecedor_conexao], fun$$HEX2$$e700e300$$ENDHEX$$o [of_executa_fornecedor_coenxao]. Erro: "+lo_rte.GetMessage( )
	lb_Sucesso = False
	Return False		
Finally		
	If lb_Sucesso Then
		SqlCa.of_Commit()
	Else
		SqlCA.of_RollBack()
		lo_Comum.of_grava_erro(al_controle, 175, ls_Log)
	End If
	
	Destroy lo_Comum	


End Try

Return True
end function

on uo_ge473_fornecedor_conexao.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge473_fornecedor_conexao.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

