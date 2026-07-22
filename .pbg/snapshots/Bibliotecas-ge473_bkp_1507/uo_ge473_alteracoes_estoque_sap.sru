HA$PBExportHeader$uo_ge473_alteracoes_estoque_sap.sru
forward
global type uo_ge473_alteracoes_estoque_sap from nonvisualobject
end type
end forward

global type uo_ge473_alteracoes_estoque_sap from nonvisualobject
end type
global uo_ge473_alteracoes_estoque_sap uo_ge473_alteracoes_estoque_sap

type variables
uo_ge473_comum io_Comum

String	is_cd_produto_sap,&
		is_filial_sap,&
		is_tp_alteracao

Decimal	idc_qtd_alterada

DateTime	idh_alteracao



end variables

forward prototypes
public function boolean of_valida_dados (ref string as_log)
private function boolean of_inicializa_variaveis (ref string as_log)
public function boolean of_localiza_codigo_filial_legado (string as_filial_sap, ref long al_filial, ref string as_log)
public function boolean of_atualiza_alteracao_estoque (long al_controle)
public function boolean of_grava_historico_alteracao_estoque (string as_filial, string as_produto, ref string as_log)
public function boolean of_insere_alteracao_estoque (long al_filial, long al_produto, ref string as_log)
end prototypes

public function boolean of_valida_dados (ref string as_log);Try
		
	If IsNull(is_cd_produto_sap) or Trim(is_cd_produto_sap) = "" Then
		as_Log	= "O c$$HEX1$$f300$$ENDHEX$$digo do produto do SAP n$$HEX1$$e300$$ENDHEX$$o pode ser nulo."
		Return False
	End If
	
	If IsNull(is_filial_sap) or (Trim(is_filial_sap) = "") Then
		as_Log	= "O c$$HEX1$$f300$$ENDHEX$$digo da filial est$$HEX1$$e100$$ENDHEX$$ nulo."
		Return False
	End If

Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_valida_dados'. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try

Return True

end function

private function boolean of_inicializa_variaveis (ref string as_log);Try
	
	setNull (is_cd_produto_sap)
	setNull(is_filial_sap)
	setNull(is_tp_alteracao)
	setNull(idh_alteracao)
	setNull(idc_qtd_alterada)

Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro ao ao iniciar as vari$$HEX1$$e100$$ENDHEX$$veis. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try

Return True


end function

public function boolean of_localiza_codigo_filial_legado (string as_filial_sap, ref long al_filial, ref string as_log);Select cd_chave_legado
Into	:al_Filial
From integracao_sap
Where	cd_tabela = 'FILIAL'
	And	cd_chave_sap	= :as_Filial_Sap
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		
	Case 100
		as_Log	= "N$$HEX1$$e300$$ENDHEX$$o foi localizado na tabela 'INTEGRA$$HEX2$$c700c200$$ENDHEX$$O SAP', o c$$HEX1$$f300$$ENDHEX$$digo da filial, com o c$$HEX1$$f300$$ENDHEX$$digo SAP '"+as_Filial_Sap+"'."
		Return False
	Case -1
		as_Log	= "Erro ao localizao o c$$HEX1$$f300$$ENDHEX$$digo da filial no legado: " + SqlCa.SqlErrText
		Return False
End Choose

Return True
end function

public function boolean of_atualiza_alteracao_estoque (long al_controle);dc_uo_ds_base lds

Long	ll_Filial,&
		ll_Produto,&
		ll_Achou,&
		ll_Linhas,&
		ll_Linha
		
		
String	ls_Log,&
		ls_Coluna,&
		ls_Vl_Item,&
		ls_Obrig
		
Boolean	lb_Sucesso = False		


Select count(*)
Into :ll_Achou
From 	interface_sap
Where nr_controle = :al_controle
	 and id_situacao in ('C', 'E')
	and dh_processamento is null
Using SqlCa;

If SqlCa.sqlcode = -1 Then
	io_Comum.of_grava_erro(al_controle, 177, "Erro ao mudar a situa$$HEX2$$e700e300$$ENDHEX$$o na tabela interface_sap. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle)+". Erro: "+SqlCa.sqlErrText)
	Return False
End If

If ll_Achou = 0 Then Return True


Try
	
	lds		= Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject('ds_ge473_lista_valores', False) Then 
		ls_Log = "Erro ao alterar a DW [ds_ge473_lista_valores]. Objeto [uo_ge473_alteracoes_estoque_sap], fun$$HEX2$$e700e300$$ENDHEX$$o [of_atualiza_produto]."
		Return False
	End If
	
	ll_Linhas = lds.Retrieve(al_controle)

	If ll_Linhas < 0 Then
		ls_Log = "Erro no retrieve a DW [ds_ge473_lista_valores]. Objeto [uo_ge473_alteracoes_estoque_sap], fun$$HEX2$$e700e300$$ENDHEX$$o [of_atualiza_produto]."
		Return False
	End If
	
	If ll_Linhas = 0 Then
		ls_Log = "N$$HEX1$$e300$$ENDHEX$$o foi localizado nenhum registro no retrieve a DW [ds_ge473_lista_valores]. Objeto [uo_ge473_alteracoes_estoque_sap], fun$$HEX2$$e700e300$$ENDHEX$$o [of_atualiza_produto]."
		Return False
	End If	

	If Not io_Comum.of_Muda_Situacao_Interface(al_Controle, Ref ls_Log) Then Return False
	
	If Not This.of_Inicializa_Variaveis(Ref ls_Log) Then Return False


	
	/*
	 SALDO ESTOQUE SAP (27)			
	*/
	
	For ll_Linha = 1 To ll_Linhas
		ls_Coluna 	= lds.Object.cd_coluna		[ll_Linha]
		ls_Vl_Item	= lds.Object.vl_item			[ll_Linha]
		ls_Obrig		= lds.Object.id_obrigatorio	[ll_Linha]
		
		ls_VL_Item = Upper(ls_VL_Item)
		
		If Trim(ls_Vl_Item) = "" Then
			SetNull(ls_Vl_Item)
		End If
		
		If Not io_Comum.of_verifica_obrigatoriedade_campo(ls_Coluna, ls_Obrig, ls_Vl_Item, Ref ls_Log) Then
			Return False
		End if
			
		
		Choose Case  Lower(ls_Coluna)
			Case 'cd_produto_sap'
				is_cd_produto_sap = gf_Tira_Zero_Esquerda(ls_Vl_Item)
			Case 'cd_estoque_sap'
				is_filial_sap = gf_Tira_Zero_Esquerda(ls_Vl_Item)
			Case 'dh_alteracao'
				If Not io_Comum.of_date_time(ls_Vl_Item, 'DATA DA ALTERACAO', ref idh_alteracao, ref ls_Log) Then Return False
			Case 'qtd_alterada'
				If Not io_Comum.of_decimal(ls_Vl_Item, 'QUANTIDADE ALTERADA', ref idc_qtd_alterada, ref ls_Log) Then Return False
		End choose
		
	Next
		
	If This.of_Valida_Dados(Ref ls_Log) Then
		If This.of_Localiza_Codigo_Filial_Legado(is_filial_sap, Ref ll_Filial, Ref ls_Log) Then
			If io_Comum.of_Localiza_Codigo_Produto_Legado(is_cd_produto_sap, Ref ll_Produto, Ref ls_Log) Then
				If This.of_Insere_Alteracao_Estoque(ll_Filial, ll_Produto, Ref ls_Log) Then
//					If This.of_Grava_Historico_Saldo_Estoque(ll_Filial, ll_Produto, Ref ls_Log) Then
						lb_Sucesso	= True
				//	End If
				End If
			End If
		End If
	End If
			
Finally
	
	If lb_Sucesso Then
		SqlCa.of_Commit()
	Else
		SqlCA.of_RollBack()
		io_Comum.of_grava_erro(al_controle, 177, ls_Log)   /// VER O QUE $$HEX1$$c900$$ENDHEX$$ 177
	End If
		
	Destroy(lds)
End Try

Return lb_Sucesso
end function

public function boolean of_grava_historico_alteracao_estoque (string as_filial, string as_produto, ref string as_log);DateTime	ldh_alteracao
Decimal		ldc_qtd_alterada
String  		lvs_tp_alteracao
			
Try			
	
	Select	dh_alteracao,
				qtd_alterada,
				tp_alteracao
				
	Into	:ldh_alteracao,
			:ldc_qtd_alterada,
			:lvs_tp_alteracao
	From alteracoes_estoque_sap
	Where	cd_filial_sap				= :as_Filial
		And	cd_produto_sap			= :as_produto
	Using SqlCa;
	
	
	Choose Case SqlCa.sqlcode
		Case 0
			
		Case 100
			as_Log	= "N$$HEX1$$e300$$ENDHEX$$o foi localizado o produto, fun$$HEX2$$e700e300$$ENDHEX$$o 'of_grava_historico_alteracao_estoque'."
			Return False
		Case -1
			as_Log	= "Erro no select da tabela 'saldo_estoque', fun$$HEX2$$e700e300$$ENDHEX$$o 'of_grava_historico_alteracao_estoque'. Erro: "+SqlCa.sqlErrText
			Return False
	End Choose
	
	
	If ldc_qtd_alterada	<>	idc_qtd_alterada Then
		If Not gf_Grava_Historico_Alteracao_Tabela("ALTERACOES_ESTOQUE_SAP", String(as_produto), "QTD_SALDO", String(ldc_qtd_alterada), String(idc_qtd_alterada), 'SAP001', 'A', Ref as_log, True) Then Return False
	End If

Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_grava_historico_alteracao_estoque'. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try		

Return True
end function

public function boolean of_insere_alteracao_estoque (long al_filial, long al_produto, ref string as_log);Insert into alteracoes_estoque_sap ( cd_filial_sap,
												cd_produto_sap,
												tp_alteracao,
												qtd_alterada,
												dh_alteracao)
												values
												(:is_filial_sap,
												:is_cd_produto_sap,	
												:is_tp_alteracao,
												:idc_qtd_alterada,
												:idh_alteracao)
												Using SqlCA;



If SqlCa.SqlCode = -1 Then
	as_Log	= "Erro ao atualizar os dados da tabela 'ALTERACOES_ESTOQUE_SAP'. C$$HEX1$$f300$$ENDHEX$$digo do produto SAP ["+is_cd_produto_sap+"], c$$HEX1$$f300$$ENDHEX$$digo legado ["+String(al_Produto)+"]. Erro: "+ SqlCa.SqlErrText
	Return False
End If

If SqlCa.SqlNRows <> 1 Then
	as_Log	= "Deveria ter atualizado 1 linha na tabela 'ALTERACOES_ESTOQUE_SAP', mas a tentativa de atualizar foi de "+String(SqlCa.SqlNRows)+" linha(s). C$$HEX1$$f300$$ENDHEX$$digo do produto SAP ["+is_cd_produto_sap+"], c$$HEX1$$f300$$ENDHEX$$digo legado ["+String(al_Produto)+"]. Erro: "+ SqlCa.SqlErrText
	Return False
End If

Return True





end function

on uo_ge473_alteracoes_estoque_sap.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge473_alteracoes_estoque_sap.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;io_Comum	= Create uo_ge473_comum
end event

event destructor;Destroy(io_Comum)
end event

