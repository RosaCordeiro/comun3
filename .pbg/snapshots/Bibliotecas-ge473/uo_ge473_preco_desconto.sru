HA$PBExportHeader$uo_ge473_preco_desconto.sru
forward
global type uo_ge473_preco_desconto from nonvisualobject
end type
end forward

global type uo_ge473_preco_desconto from nonvisualobject
end type
global uo_ge473_preco_desconto uo_ge473_preco_desconto

type variables
String is_Id_Registro //Pre$$HEX1$$e700$$ENDHEX$$o ou Desconto
String is_Regiao //UF - Opcional para desconto
String is_Cd_Produto_Sap 
Decimal idc_Vlr_Compra
Long il_Tabela  = 147
Long il_cd_produto_legado



end variables

forward prototypes
public function boolean of_inicializa_variaveis (ref string as_log)
public subroutine of_processa_atualizacao ()
public function boolean of_valida_dados (ref string as_log)
public function boolean of_atualiza_preco_desconto (long al_controle, long al_tabela)
private function boolean of_insere_preco (long al_controle, ref string as_log)
private function boolean of_insere_desconto (long al_controle, ref string as_log)
end prototypes

public function boolean of_inicializa_variaveis (ref string as_log);Try

	SetNull(is_Id_Registro)	
	SetNull(is_Regiao)
	SetNull(is_Cd_Produto_Sap)
	SetNull(idc_Vlr_Compra)	

Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro ao iniciar as vari$$HEX1$$e100$$ENDHEX$$veis. Erro: " + lo_rte.GetMessage( )
	Return False						 
End Try

Return True




end function

public subroutine of_processa_atualizacao ();Long ll_Linhas
Long ll_Linha

dc_uo_ds_base lds 

try 
	
	lds  = Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject('ds_ge473_lista_controles', False) Then 
		gvo_aplicacao.of_grava_log("Interface Pre$$HEX1$$e700$$ENDHEX$$o/Desconto - Erro alterar a DW [ds_ge473_lista_controles] - uo_ge473_preco_desconto.of_processa_atualizacao" )
		Return
	End If
	
	ll_Linhas = lds.Retrieve(il_Tabela)
	
	If ll_Linhas > 0 Then
		For ll_Linha = 1 To ll_Linhas
											
			uo_ge473_preco_desconto  lo_Preco_Desconto
			 
			Try
				lo_Preco_Desconto	= Create uo_ge473_preco_desconto
				lo_Preco_Desconto.of_atualiza_preco_desconto(lds.Object.nr_controle[ll_Linha] ,  il_Tabela )
			Finally
				Destroy(lo_Preco_Desconto)
			End Try			
			
		Next
	ElseIf ll_Linhas < 0 Then
		gvo_aplicacao.of_grava_log("Interface PrecoDesconto - Erro ao recuperar os da DW [ds_ge473_lista_controles] - uo_ge473_preco_desconto.of_processa_atualizacao.")
	End If	
	
finally
	Destroy lds
end try
end subroutine

public function boolean of_valida_dados (ref string as_log);Try
		
	If IsNull(is_Cd_Produto_Sap) or Trim(is_Cd_Produto_Sap) = "" Then
		as_Log	= "O c$$HEX1$$f300$$ENDHEX$$digo do produto do SAP n$$HEX1$$e300$$ENDHEX$$o pode ser nulo."
		Return False
	End If
	
	If IsNull(is_Id_Registro) or Trim(is_Id_Registro) = "" Or (is_Id_Registro <> 'PRECO' And is_Id_Registro <> 'DESCONTO') Then
		as_Log	= "Tipo do registro (Id_Registro) inv$$HEX1$$e100$$ENDHEX$$lido."
		Return False
	End If
	
	If IsNull(idc_Vlr_Compra) Then
		as_Log	= "Valor compra/desconto n$$HEX1$$e300$$ENDHEX$$o pode ser nulo."
		Return False
	End If
	
	If Not IsNull(is_Regiao) And Trim(is_Regiao) <> '' Then
		If Len(is_Regiao) <> 2 Then
			as_Log	= "Valor inv$$HEX1$$e100$$ENDHEX$$lido para a UF."
			Return False			
		End If
	End If	
		
Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_valida_dados' do uo_ge473_preco_desconto. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try

Return True
end function

public function boolean of_atualiza_preco_desconto (long al_controle, long al_tabela);Long	ll_Linhas,&
		ll_Linha, &
		ll_Atualizacao_Pend
		
String	ls_Log,&
		ls_Vl_Item
		
Boolean	lb_Sucesso = True		

Try
	uo_ge473_comum lo_Comum
	lo_Comum = Create uo_ge473_comum
	
	If Not This.of_inicializa_variaveis(Ref ls_Log) Then 
		lb_Sucesso = False
		Return False	
	End If
	
	If Not lo_Comum.of_atualizacao_pendente(al_Controle, Ref ll_Atualizacao_Pend, Ref ls_Log) Then 
		lb_Sucesso = False
		Return False	
	End If
	
	//Controle j$$HEX1$$e100$$ENDHEX$$ foi processado
	If ll_Atualizacao_Pend = 0 Then Return True
	
	If Not lo_Comum.of_Muda_Situacao_Interface(al_Controle, Ref ls_Log) Then 
		lb_Sucesso = False
		Return False	
	End If

	If lo_Comum.of_processa_carrega_dados(al_controle, ref ls_Log) Then
		
		ll_Linhas = lo_Comum.ids_lista_registros.RowCount()
		
		If ll_Linhas > 0 Then 
			
			If isvalid(w_aguarde_3) Then
				w_aguarde_3.uo_progress_2.of_reset()
				w_aguarde_3.uo_progress_2.of_setmax(ll_linhas)
			End If
			
			For ll_Linha = 1 To ll_Linhas	
				is_Id_Registro		= lo_Comum.ids_lista_registros.Object.id_registro		[ll_Linha]
				is_Regiao			= lo_Comum.ids_lista_registros.Object.cd_regiao		[ll_Linha]
				is_Cd_Produto_Sap= lo_Comum.ids_lista_registros.Object.cd_material	[ll_Linha]
				idc_Vlr_Compra	= Dec(gf_Replace(lo_Comum.ids_lista_registros.Object.vl_compra[ll_Linha], '.', ',', 0))
				
				//Valida os dados n
				If Not of_Valida_Dados( Ref ls_Log ) Then					
					lb_Sucesso = False
					Return False	
				End If
				
				if idc_Vlr_Compra >= 100000 Then
					idc_Vlr_Compra = 99999.99
				End if
				
				If Not lo_Comum.of_localiza_codigo_produto_legado(is_Cd_Produto_Sap, Ref il_cd_produto_legado, Ref ls_log) Then
					lb_Sucesso = False
					Return False	
				End If

				If isvalid(w_aguarde_3) Then
					w_aguarde_3.wf_settext('Controle: ' + string(al_controle), 3 )
				End If	
				
				If is_Id_Registro = 'PRECO' Then
					If Not of_Insere_Preco(al_controle, Ref ls_log) Then
						lb_Sucesso = False
						Return False	
					End If
				ElseIf is_Id_Registro = 'DESCONTO' Then
					If Not of_Insere_Desconto(al_controle, Ref ls_log) Then
						lb_Sucesso = False
						Return False	
					End If
				End If

				If isvalid(w_aguarde_3) Then
					w_aguarde_3.uo_progress_2.of_setprogress(ll_linha)
				End if
				
			Next
						
		Else
			ls_Log  = "Quantidade de registros recebido na interface esta diferente do esperado 1 para a tabela [interface_sap]. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle)+"."
			lb_Sucesso = False
			Return False
		End If
		
	End If
	
Catch ( runtimeerror  lo_rte )
	ls_Log = "Objeto [uo_ge473_preco_desconto], fun$$HEX2$$e700e300$$ENDHEX$$o [of_atualiza_preco_desconto]. Erro: "+lo_rte.GetMessage( )
	lb_Sucesso = False
	Return False		
Finally		
	If lb_Sucesso Then
		SqlCa.of_Commit()
	Else
		SqlCA.of_RollBack()
		lo_Comum.of_grava_erro(al_controle, 183, ls_Log)
	End If
	
	Destroy lo_Comum	
	
End Try

Return lb_Sucesso
end function

private function boolean of_insere_preco (long al_controle, ref string as_log);//UF Obrigat$$HEX1$$f300$$ENDHEX$$rio nesta fun$$HEX2$$e700e300$$ENDHEX$$o
Decimal ldc_Vlr_Rep

If Len(is_Regiao) <> 2 Then
	as_Log	= "Valor inv$$HEX1$$e100$$ENDHEX$$lido para a UF na of_insere_preco."
	Return False			
End If

SELECT  vl_preco_reposicao
INTO :ldc_Vlr_Rep
FROM produto_uf
WHERE cd_produto = :il_cd_produto_legado
	And cd_unidade_federacao = :is_Regiao
Using SqlCa;

Choose Case SqlCa.sqlcode 
	Case -1
		as_Log	= "Erro ao buscar dados para verifica$$HEX2$$e700e300$$ENDHEX$$o of_insere_preco. C$$HEX1$$f300$$ENDHEX$$digo do produto SAP ["+is_cd_produto_sap+"], c$$HEX1$$f300$$ENDHEX$$digo legado ["+String(il_cd_produto_legado)+"]. Erro: "+ SqlCa.SqlErrText
		Return False
	Case 100
		as_Log = "Produto '" + String(il_cd_produto_legado) + "' n$$HEX1$$e300$$ENDHEX$$o localizado para altera$$HEX2$$e700e300$$ENDHEX$$o na tabela produto_uf. " 
		Return False
	Case 0
		If idc_Vlr_Compra <> ldc_Vlr_Rep And idc_Vlr_Compra > 0 Then
			UPDATE produto_uf SET
				 vl_preco_reposicao = :idc_Vlr_Compra,
				 dh_preco_reposicao = getdate(),
				 nr_matricula_preco_reposicao = '14330'
			WHERE cd_produto = :il_cd_produto_legado
				AND cd_unidade_federacao = :is_Regiao
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				as_Log	= "Erro ao atualizar os dados da tabela 'PRODUTO_UF'. C$$HEX1$$f300$$ENDHEX$$digo do produto SAP ["+is_cd_produto_sap+"], c$$HEX1$$f300$$ENDHEX$$digo legado ["+String(il_cd_produto_legado)+"]. Erro: "+ SqlCa.SqlErrText
				Return False
			End If
			
			If SqlCa.SqlNRows <> 1 Then
				as_Log	= "Deveria ter atualizado 1 linha na tabela 'PRODUTO_UF', mas tentou atualizar "+String(SqlCa.SqlNRows)+" linha(s). C$$HEX1$$f300$$ENDHEX$$digo do produto SAP ["+is_cd_produto_sap+"], c$$HEX1$$f300$$ENDHEX$$digo legado ["+String(il_cd_produto_legado)+"]. Erro: "+ SqlCa.SqlErrText
				Return False
			End If
		Else
			//Valor j$$HEX1$$e100$$ENDHEX$$ esta correto
			Return True
		End If
End Choose

Return True
end function

private function boolean of_insere_desconto (long al_controle, ref string as_log);Decimal ldc_Vlr_Rep

SELECT  pc_desconto_fornecedor
INTO :ldc_Vlr_Rep
FROM produto_central
WHERE cd_produto = :il_cd_produto_legado
Using SqlCa;

Choose Case SqlCa.sqlcode 
	Case -1
		as_Log	= "Erro ao buscar dados para verifica$$HEX2$$e700e300$$ENDHEX$$o of_insere_desconto. C$$HEX1$$f300$$ENDHEX$$digo do produto SAP ["+is_cd_produto_sap+"], c$$HEX1$$f300$$ENDHEX$$digo legado ["+String(il_cd_produto_legado)+"]. Erro: "+ SqlCa.SqlErrText
		Return False
	Case 100
		as_Log = "Produto '" + String(il_cd_produto_legado) + "' n$$HEX1$$e300$$ENDHEX$$o localizado para altera$$HEX2$$e700e300$$ENDHEX$$o na tabela 'produto_central'. " 
		Return False
	Case 0
		If idc_Vlr_Compra <> ldc_Vlr_Rep And idc_Vlr_Compra >= 0 Then
			UPDATE produto_central SET
				 pc_desconto_fornecedor = :idc_Vlr_Compra
			WHERE
				 cd_produto = :il_cd_produto_legado
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				as_Log	= "Erro ao atualizar os dados da tabela 'produto_central'. C$$HEX1$$f300$$ENDHEX$$digo do produto SAP ["+is_cd_produto_sap+"], c$$HEX1$$f300$$ENDHEX$$digo legado ["+String(il_cd_produto_legado)+"]. Erro: "+ SqlCa.SqlErrText
				Return False
			End If
			
			If SqlCa.SqlNRows <> 1 Then
				as_Log	= "Deveria ter atualizado 1 linha na tabela 'produto_central', mas tentou atualizar "+String(SqlCa.SqlNRows)+" linha(s). C$$HEX1$$f300$$ENDHEX$$digo do produto SAP ["+is_cd_produto_sap+"], c$$HEX1$$f300$$ENDHEX$$digo legado ["+String(il_cd_produto_legado)+"]. Erro: "+ SqlCa.SqlErrText
				Return False
			End If
		Else
			//Valor j$$HEX1$$e100$$ENDHEX$$ esta correto
			Return True
		End If
End Choose

Return True
end function

on uo_ge473_preco_desconto.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge473_preco_desconto.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

