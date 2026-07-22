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
String is_Excluir
String is_Filial_Sap

Long il_Filial




end variables

forward prototypes
public function boolean of_inicializa_variaveis (ref string as_log)
public function boolean of_atualiza_fornecedor_conexao (long al_filial, string as_fornecedor, string as_excluir, ref string as_log)
public function boolean of_executa_fornecedor_conexao (long al_controle, long al_tabela)
end prototypes

public function boolean of_inicializa_variaveis (ref string as_log);Try

	SetNull(is_Filial_Sap)	
	SetNull(il_Filial)
	SetNull(is_Excluir)
	SetNull(is_Fornecedor)	
	SetNull(is_Fornecedor_Sap)
	

Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro ao iniciar as vari$$HEX1$$e100$$ENDHEX$$veis. Erro: " + lo_rte.GetMessage( )
	Return False						 
End Try

Return True




end function

public function boolean of_atualiza_fornecedor_conexao (long al_filial, string as_fornecedor, string as_excluir, ref string as_log);Long ll_Qtd

If IsNull(as_excluir) Then 

	select	count(*) 
	Into 		:ll_Qtd
	from		filial_projeto_conexao
	where	cd_filial=:al_filial
	and		cd_fornecedor=:as_fornecedor
	Using		SqlCa;
		
	Choose Case SqlCa.SqlCode
		Case 0
			If ll_Qtd = 0 Then 
				INSERT INTO filial_projeto_conexao ( cd_filial, cd_fornecedor )
				VALUES ( :al_filial, :as_fornecedor)
				Using SqlCa;
								
				If SqlCa.SqlCode = -1 Then
					as_Log	= "Erro ao incluir o registro filial_projeto_conexao." + " Erro: "+ SqlCa.SqlErrText
					Return False
				End If
			Else
				as_Log	= "Registro j$$HEX1$$e100$$ENDHEX$$ existente. N$$HEX1$$e300$$ENDHEX$$o inserido na filial_projeto_conexao." + " Erro: "+ SqlCa.SqlErrText
				Return True
			End If 
		Case 100
			
		Case -1
				as_Log	= "Erro ao localizar o registro filial_projeto_conexao." + " Erro: "+ SqlCa.SqlErrText
				Return False
		End Choose	
Else 

	If as_excluir ="E" Then 
		Delete from filial_projeto_conexao
		Where	cd_filial=:al_filial
		and		cd_fornecedor=:as_fornecedor
		Using SqlCA;
	
		If SqlCa.SqlCode = -1 Then
			as_Log	= "Erro ao excluir o registro filial_projeto_conexao." + " Erro: "+ SqlCa.SqlErrText
			Return False
		Else
			as_Log	= "Registro exluido com sucesso da filial_projeto_conexao." + " Erro: "+ SqlCa.SqlErrText
			Return True
		End If 
		
	End If 
	
End If 


Return True
end function

public function boolean of_executa_fornecedor_conexao (long al_controle, long al_tabela);Boolean lb_Sucesso = False

Long ll_Atualizacao_Pend
Long ll_Linhas

String ls_Log

Try
	
	uo_ge473_comum lo_Comum
	lo_Comum = Create uo_ge473_comum
	
	If Not This.of_inicializa_variaveis(Ref ls_Log) Then Return False
	
	If Not lo_Comum.of_atualizacao_pendente(al_Controle, Ref ll_Atualizacao_Pend, Ref ls_Log) Then Return False
	
	If Not lo_Comum.of_Muda_Situacao_Interface(al_Controle, Ref ls_Log) Then Return False

	//Controle j$$HEX1$$e100$$ENDHEX$$ foi processado
	If ll_Atualizacao_Pend = 0 Then Return True
	
	If lo_Comum.of_processa_carrega_dados(al_controle, al_tabela, ref ls_Log) Then
		
		ll_Linhas = lo_Comum.ids_lista_registros.RowCount()
		
		If ll_Linhas = 1 Then
			
			is_Fornecedor_Sap 	= lo_Comum.ids_lista_registros.Object.cd_fornecedor_sap	[1]
			is_Filial_Sap				= lo_Comum.ids_lista_registros.Object.cd_filial_sap				[1]
			is_Excluir					= lo_Comum.ids_lista_registros.Object.id_excluir					[1]
			
		   If Not lo_Comum.of_Localiza_Codigo_Filial_Legado(is_Filial_Sap, Ref il_Filial, Ref ls_Log) Then Return False
			
			If Not lo_Comum.of_localiza_codigo_fornecedor_legado(is_Fornecedor_Sap , Ref is_Fornecedor, ref ls_Log) Then Return False
			
						
			If This.of_atualiza_fornecedor_conexao(il_Filial , is_Fornecedor, is_Excluir,  ref ls_Log ) Then
				lb_Sucesso = True
			End If
			
						
		Else
			ls_Log  = "Quantidade de registros recebido na interface esta diferente do esperado 1 para a tabela [interface_sap]. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle)+"."
			Return False
		End If
		
	End If
		
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

