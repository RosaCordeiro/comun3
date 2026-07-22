HA$PBExportHeader$uo_ge473_pedido_filial_bloqueio_sap.sru
forward
global type uo_ge473_pedido_filial_bloqueio_sap from nonvisualobject
end type
end forward

global type uo_ge473_pedido_filial_bloqueio_sap from nonvisualobject
end type
global uo_ge473_pedido_filial_bloqueio_sap uo_ge473_pedido_filial_bloqueio_sap

type variables
uo_ge473_comum io_Comum

String	is_cd_filial_sap,&
		is_cd_fornecedor_sap,&
		is_cd_tipo_pedido_almoxarifado,&
		is_cd_tipo_pedido_distribuidora,&
		is_cd_tipo_pedido_estoque_central,&
		is_de_motivo_rejeicao,&
		is_id_pertence_local_geladeira,&
		is_id_bloq_forn
		
DateTime	idh_dh_bloqueio


end variables

forward prototypes
public function boolean of_atualiza_pedido_filial_bloqueio (long al_controle)
public function boolean of_valida_dados (ref string as_log)
private function boolean of_inicializa_variaveis (ref string as_log)
private function boolean of_tipo_operacao (ref string as_operacao, ref string as_log)
private function boolean of_grava_historic_pedido_filial_bloqueio (long al_filial, string as_fornecedor, string as_operacao, ref string as_log)
private function boolean of_insere_pedido_filial_bloqueio (string as_operacao, long al_filial, ref string as_distribuidora, ref string as_log)
private function boolean of_insere_pedido_distribuidora (string as_tipo_bloqueio, string as_operacao, long al_filial, ref string as_log)
private function boolean of_delete_pedido_distribuidora (string as_tipo_bloqueio, string as_operacao, long al_filial, ref string as_log)
end prototypes

public function boolean of_atualiza_pedido_filial_bloqueio (long al_controle);dc_uo_ds_base lds

Long	ll_Filial,&
		ll_Achou,&
		ll_Linhas,&
		ll_Linha
		
String	ls_Log,&
		ls_Coluna,&
		ls_Vl_Item,&
		ls_Obrig,&
		ls_Operacao,&
		ls_Fornecedor
		
Boolean	lb_Sucesso = False		

Select count(*)
Into :ll_Achou
From 	interface_sap
Where nr_controle = :al_controle
	 and id_situacao in ('C', 'E')
	and dh_processamento is null
Using SqlCa;

If SqlCa.sqlcode = -1 Then
	io_Comum.of_grava_erro(al_controle, 176, "Erro ao verificar se tem algum controle para ser processado. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle)+". Erro: "+SqlCa.sqlErrText)
	Return False
End If

If ll_Achou = 0 Then Return True

Try
	
	lds		= Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject('ds_ge473_lista_valores', False) Then 
		ls_Log = "Erro ao alterar a DW [ds_ge473_lista_valores]. Objeto [uo_ge473_pedido_filial_bloqueio_sap], fun$$HEX2$$e700e300$$ENDHEX$$o [of_atualiza_pedido_filial_bloqueio]."
		Return False
	End If
	
	ll_Linhas = lds.Retrieve(al_controle)
	
	If ll_Linhas < 0 Then
		ls_Log = "Erro no retrieve a DW [ds_ge473_lista_valores]. Objeto [uo_ge473_pedido_filial_bloqueio_sap], fun$$HEX2$$e700e300$$ENDHEX$$o [of_atualiza_pedido_filial_bloqueio]."
		Return False
	End If
	
	If ll_Linhas = 0 Then
		ls_Log = "N$$HEX1$$e300$$ENDHEX$$o foi localizado nenhum registro no retrieve a DW [ds_ge473_lista_valores]. Objeto [uo_ge473_pedido_filial_bloqueio_sap], fun$$HEX2$$e700e300$$ENDHEX$$o [of_atualiza_pedido_filial_bloqueio]."
		Return False
	End If	
	
	If Not io_Comum.of_Muda_Situacao_Interface(al_Controle, Ref ls_Log) Then Return False
	
	If Not This.of_Inicializa_Variaveis(Ref ls_Log) Then Return False
	
	/*
	 BLOQUEIO_PEDIDO_FILIAL (32)			
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
			Case 'cd_filial_sap'
				is_cd_filial_sap = gf_Tira_Zero_Esquerda(ls_Vl_Item)
			Case 'cd_fornecedor_sap'
				is_cd_fornecedor_sap = ls_Vl_Item
			Case 'cd_tipo_pedido_almoxarifado'
				is_cd_tipo_pedido_almoxarifado	= ls_Vl_Item
			Case 'cd_tipo_pedido_distribuidora'
				is_cd_tipo_pedido_distribuidora	= ls_Vl_Item
			Case 'cd_tipo_pedido_estoque_central'
				is_cd_tipo_pedido_estoque_central	= ls_Vl_Item
			Case 'de_motivo_rejeicao'
				is_de_motivo_rejeicao	= ls_Vl_Item
			Case 'dh_bloqueio'
				If Not io_Comum.of_date_time(ls_Vl_Item, 'DATA BLOQUEIO', ref idh_dh_bloqueio, ref ls_Log) Then Return False
			Case 'id_pertence_local_geladeira'
				is_id_pertence_local_geladeira	= ls_Vl_Item
			Case 'id_bloq_forn'
				is_id_bloq_forn	= ls_Vl_Item
		End choose
	Next
	
	If IsNull(is_cd_filial_sap)								Then	is_cd_filial_sap								= ""
	If IsNull(is_cd_fornecedor_sap)						Then	is_cd_fornecedor_sap						= ""
	If IsNull(is_cd_tipo_pedido_almoxarifado)		Then	is_cd_tipo_pedido_almoxarifado		= ""
	If IsNull(is_cd_tipo_pedido_distribuidora)			Then	is_cd_tipo_pedido_distribuidora		= ""
	If IsNull(is_cd_tipo_pedido_estoque_central)	Then	is_cd_tipo_pedido_estoque_central	= ""
	If IsNull(is_de_motivo_rejeicao)					Then	is_de_motivo_rejeicao					= ""
	If IsNull(is_id_pertence_local_geladeira)			Then	is_id_pertence_local_geladeira			= ""
	If IsNull(is_id_bloq_forn)								Then	is_id_bloq_forn								= ""
	
	
	If This.of_Valida_Dados(Ref ls_Log) Then
		If io_Comum.of_Localiza_Codigo_Filial_Legado(is_cd_filial_sap, Ref ll_Filial, Ref ls_Log) Then
			If io_Comum.of_Localiza_Codigo_Fornecedor_Legado(is_cd_fornecedor_sap, Ref ls_Fornecedor, Ref ls_Log) Then
				If This.of_Tipo_Operacao(Ref ls_Operacao,  Ref ls_Log) Then
					If This.of_Insere_Pedido_Filial_Bloqueio(ls_Operacao, ll_Filial, Ref ls_Fornecedor, Ref ls_Log) Then
						lb_Sucesso	= True
					End If
				End If
			End If
		End If
	End If
			
Finally
	
	If lb_Sucesso Then
		SqlCa.of_Commit()
	Else
		SqlCA.of_RollBack()
		io_Comum.of_grava_erro(al_controle, 176, ls_Log)
	End If
		
	Destroy(lds)
End Try

Return lb_Sucesso
end function

public function boolean of_valida_dados (ref string as_log);Try

	If IsNull(idh_dh_bloqueio) or Not IsDate(String(idh_dh_bloqueio, "dd/mm/yyyy")) Then
		as_Log	= "A data de bloqueio n$$HEX1$$e300$$ENDHEX$$o foi preenchida ou est$$HEX1$$e100$$ENDHEX$$ com um valor inv$$HEX1$$e100$$ENDHEX$$lido."
		Return False
	End If
		
	If (Trim(is_cd_tipo_pedido_distribuidora) <> "")  and (Trim(is_id_bloq_forn) = "")	Then
		If IsNull(is_cd_fornecedor_sap) or Trim(is_cd_fornecedor_sap) = "" Then
			as_Log	=  "Quando o campo Tipo de Pedido Distribuidora vier preenchido do SAP, o c$$HEX1$$f300$$ENDHEX$$digo do fornecedor do SAP n$$HEX1$$e300$$ENDHEX$$o pode ser vazio."
			Return False
		End If
		
		If Trim(is_cd_tipo_pedido_almoxarifado) <> "" Then
			as_Log	= "Quando o campo Tipo de Pedido Distribuidora vier preenchido do SAP, o campo Tipo de Pedido Almoxarifado deve ser vazio."
			Return False
		End If
		
		If Trim(is_cd_tipo_pedido_estoque_central) <> "" Then
			as_Log	= "Quando o campo Tipo de Pedido Distribuidora vier preenchido do SAP, o campo Tipo de Pedido Estoque Central deve ser vazio."
			Return False
		End If
		
		If Trim(is_id_pertence_local_geladeira) <> "" Then
			as_Log	= "Quando o campo Tipo de Pedido Distribuidora vier preenchido do SAP, o campo Pertence Local Geladeira deve ser vazio."
			Return False
		End If
		
		If Trim(is_id_bloq_forn) <> "" Then
			as_Log	= "Quando o campo Tipo de Pedido Distribuidora vier preenchido do SAP, o campo ID Bloqueio Fornecedor deve ser vazio."
			Return False
		End If
	End If
	
	If Trim(is_cd_tipo_pedido_estoque_central) <> "" Then
		If (Trim(is_cd_tipo_pedido_almoxarifado) <> "") and (Trim(is_id_pertence_local_geladeira) <> "") Then
			as_Log	= "Quando o campo Tipo de Pedido Estoque Central vier preenchido do SAP, o campo Tipo de Pedido Almoxarifado ou o campo Pertence Local Geladeira devem ser vazio."
			Return False
		End If
		
		If Trim(is_cd_fornecedor_sap) <> "" Then
			as_Log	= "Quando o campo Tipo de Pedido Estoque Central vier preenchido do SAP, o campo C$$HEX1$$f300$$ENDHEX$$digo do Fornecedor deve ser vazio."
			Return False
		End If
		
		If Trim(is_cd_tipo_pedido_distribuidora) <> "" Then
			as_Log	= "Quando o campo Tipo de Pedido Estoque Central vier preenchido do SAP, o campo Tipo Pedido Distribuidora deve ser vazio."
			Return False
		End If
		
		If Trim(is_id_bloq_forn) <> "" Then
			as_Log	= "Quando o campo Tipo de Pedido Estoque Central vier preenchido do SAP, o campo ID Bloqueio Fornecedor deve ser vazio."
			Return False
		End If
	End If
	
	If Trim(is_cd_tipo_pedido_almoxarifado) <> "" Then	
		If Trim(is_cd_tipo_pedido_distribuidora) <> "" Then
			as_Log	= "Quando o campo Tipo de Pedido Almoxarifado vier preenchido do SAP, o campo Tipo de Pedido Distribuidora deve ser vazio."
			Return False
		End If
		
		If Trim(is_cd_fornecedor_sap) <> "" Then
			as_Log	= "Quando o campo Tipo de Pedido Almoxarifado vier preenchido do SAP, o campo C$$HEX1$$f300$$ENDHEX$$digo do Fornecedor SAP deve ser vazio."
			Return False
		End If
		
		If Trim(is_id_pertence_local_geladeira) <> "" Then
			as_Log	= "Quando o campo Tipo de Pedido Almoxarifado vier preenchido do SAP, o campo Pertence Local Geladeira deve ser vazio."
			Return False
		End If
		
		If Trim(is_id_bloq_forn) <> "" Then
			as_Log	= "Quando o campo Tipo de Pedido Almoxarifado vier preenchido do SAP, o campo ID Bloqueio Fornecedor deve ser vazio."
			Return False
		End If
	End If
	
	If Trim(is_id_pertence_local_geladeira) = "X" Then
		If Trim(is_cd_tipo_pedido_distribuidora) <> "" Then
			as_Log	= "Quando o campo ID Pertence Local Geladeira vier preenchido do SAP, o campo Tipo de Pedido Distribuidora deve ser vazio."
			Return False
		End If
		
		If Trim(is_cd_fornecedor_sap) <> "" Then
			as_Log	= "Quando o campo ID Pertence Local Geladeira vier preenchido do SAP, o campo C$$HEX1$$f300$$ENDHEX$$digo do Fornecedor SAP deve ser vazio."
			Return False
		End If
		
		If Trim(is_cd_tipo_pedido_almoxarifado) <> "" Then
			as_Log	= "Quando o campo ID Pertence Local Geladeira vier preenchido do SAP, o campo Tipo de Pedido Almoxarifado deve ser vazio."
			Return False
		End If
		
		If Trim(is_id_bloq_forn) <> "" Then
			as_Log	= "Quando o campo ID Pertence Local Geladeira vier preenchido do SAP, o campo ID Bloqueio Fornecedor deve ser vazio."
			Return False
		End If
	End If
	
	If Trim(is_id_bloq_forn) = "X" Then
		If Trim(is_cd_filial_sap) = "" Then
			as_Log	= "Quando o campo ID Bloqueio Fornecedor vier preenchido do SAP, o campo C$$HEX1$$f300$$ENDHEX$$digo Filial deve ser informado."
			Return False
		End If		
	End If

Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_valida_dados'. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try

Return True
end function

private function boolean of_inicializa_variaveis (ref string as_log);Try
	SetNull(is_cd_filial_sap)
	SetNull(is_cd_fornecedor_sap)
	SetNull(is_cd_tipo_pedido_almoxarifado)
	SetNull(is_cd_tipo_pedido_distribuidora)
	SetNull(is_cd_tipo_pedido_estoque_central)
	SetNull(is_de_motivo_rejeicao)
	SetNull(is_id_pertence_local_geladeira)
	SetNull(idh_dh_bloqueio)
	SetNull(is_id_bloq_forn)

Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro ao ao iniciar as vari$$HEX1$$e100$$ENDHEX$$veis. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try

Return True
end function

private function boolean of_tipo_operacao (ref string as_operacao, ref string as_log);Date	ldt_Atual
		
Try
	
	ldt_Atual	= Date(gf_GetServerDate())
	
	If Date(idh_dh_bloqueio) < ldt_Atual Then
		as_Operacao	 = "E"	//Exclui
	Else
		as_Operacao	 = "I"	//Insere		
	End If	

Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_Tipo_Operacao'. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try		

Return True
end function

private function boolean of_grava_historic_pedido_filial_bloqueio (long al_filial, string as_fornecedor, string as_operacao, ref string as_log);
String	ls_Alteracao_Insert,&
		ls_Alteracao_Delete
		
SetNull(ls_Alteracao_Insert)
SetNull(ls_Alteracao_Delete)
		
Try
	
	If as_Operacao = "I" Then
		
		ls_Alteracao_Insert	= String(al_Filial)+" @#!"+as_Fornecedor+"@#!"+String(idh_dh_bloqueio, "DD/MM/YYYY")
		
	ElseIf as_Operacao = "E" Then
		
		ls_Alteracao_Delete	= String(al_Filial)+" @#!"+as_Fornecedor+"@#!"+String(idh_dh_bloqueio, "DD/MM/YYYY")
		
	Else
		as_Log = "Opera$$HEX2$$e700e300$$ENDHEX$$o '"+as_Operacao+"' n$$HEX1$$e300$$ENDHEX$$o prevista na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_grava_historic_pedido_filial_bloqueio'."
		Return False
	End If
	
	If Not gf_Grava_Historico_Alteracao_Tabela("PEDIDO_FILIAL_BLOQUEIO", "CD_FILIAL@#!CD_DISTRIBUIDORA@#!DH_PEDIDO", "NR_BLOQUEIO", ls_Alteracao_Delete, ls_Alteracao_Insert, 'SAP001', as_Operacao, Ref as_log, True) Then Return False

Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_Grava_Historic_Pedido_Filial_Bloqueio'. Erro: "+lo_rte.GetMessage( )
	Return False
End Try		

Return True
end function

private function boolean of_insere_pedido_filial_bloqueio (string as_operacao, long al_filial, ref string as_distribuidora, ref string as_log);String	ls_tipo_bloqueio
Try
	
	If (Trim(is_cd_tipo_pedido_distribuidora) <> "") and (is_id_bloq_forn = "") Then
		ls_tipo_bloqueio	= "D"
	ElseIf (is_cd_tipo_pedido_almoxarifado = "") and (is_id_pertence_local_geladeira = "") and (is_id_bloq_forn = "") Then
		as_distribuidora		= "053404705"
		ls_tipo_bloqueio	= "D"
	ElseIf (is_cd_tipo_pedido_almoxarifado <> "") and ((is_id_pertence_local_geladeira = "") and (is_cd_tipo_pedido_distribuidora = "") and (is_cd_fornecedor_sap = "")) and (is_id_bloq_forn = "") Then
		as_distribuidora		= "053404705"
		ls_tipo_bloqueio	= "A"
	ElseIf (is_id_pertence_local_geladeira = "X") and (is_id_bloq_forn = "") Then
		as_distribuidora		= "053404705"
		ls_tipo_bloqueio	= "T"
	ElseIf is_id_bloq_forn <> "" Then
		ls_tipo_bloqueio	= "D"
	End If
	
	If IsNull(ls_tipo_bloqueio) or (ls_tipo_bloqueio = "") Then
		as_Log = "N$$HEX1$$e300$$ENDHEX$$o foi definido o tipo de bloqueio."
		Return False
	End If
	
	If as_Operacao = "I" Then	//Insere
		If is_id_bloq_forn <> "" Then
			If Not of_Insere_Pedido_Distribuidora(ls_tipo_bloqueio, as_Operacao, al_Filial, Ref as_Log) Then
				Return False
			End If
		Else	
			INSERT INTO pedido_filial_bloqueio  
						( id_tipo_bloqueio,   
						  cd_filial,   
						  cd_distribuidora,   
						  dh_pedido,   
						  nr_dia_semana,   
						  de_motivo_bloqueio )  
			  VALUES (	:ls_tipo_bloqueio,
							:al_Filial,
							:as_distribuidora,
							:idh_dh_bloqueio,
							Null,
							:is_de_motivo_rejeicao)
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				as_Log = "Erro no INSERT da 'pedido_filial_bloqueio': "+SqlCa.SqlErrText
				Return False
			End If
		End If
		
		If Not This.of_Grava_Historic_Pedido_Filial_Bloqueio(al_Filial, as_distribuidora, as_Operacao, Ref as_Log) Then
			Return False
		End If
		
	ElseIf as_Operacao = "E" Then //Exclui
		If is_id_bloq_forn <> "" Then
			If Not of_Delete_Pedido_Distribuidora(ls_tipo_bloqueio, as_Operacao, al_Filial, Ref as_Log) Then
				Return False
			End If
		Else
			DELETE FROM pedido_filial_bloqueio
			WHERE	id_tipo_bloqueio	= :ls_tipo_bloqueio
				AND	cd_filial				= :al_Filial
				AND	cd_distribuidora	= :as_distribuidora
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				as_Log = "Erro no DELETE da 'pedido_filial_bloqueio': "+SqlCa.SqlErrText
				Return False
			End If
			
			If SqlCa.SqlNRows	<> 1 Then
				as_Log = "Erro no DELETE da 'pedido_filial_bloqueio'. Deveria ter exclu$$HEX1$$ed00$$ENDHEX$$do 1 linha, mas excluiu "+String(SqlCa.SqlNRows)+" linha(s)."
				Return False
			End If
			
			If Not This.of_Grava_Historic_Pedido_Filial_Bloqueio(al_Filial, as_distribuidora, as_Operacao, Ref as_Log) Then
				Return False
			End If
		End If
	Else
		as_Log = "Opera$$HEX2$$e700e300$$ENDHEX$$o '"+as_Operacao+"' n$$HEX1$$e300$$ENDHEX$$o prevista na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_insere_pedido_filial_bloqueio'."
		Return False
	End If
	
Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_insere_pedido_filial_bloqueio'. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try	

Return True
end function

private function boolean of_insere_pedido_distribuidora (string as_tipo_bloqueio, string as_operacao, long al_filial, ref string as_log);dc_uo_ds_base	lds

Long	ll_Linha,&
		ll_Linhas
		
String	ls_Distribuidora		

Try
	lds	= Create dc_uo_ds_base

	If Not lds.of_ChangeDataObject('ds_ge473_filial_distrib_bloqueio', False) Then 
		as_log = "Erro ao alterar a DW [ds_ge473_filial_distrib_bloqueio]."
		Return False
	End If
	
	ll_Linhas = lds.Retrieve(al_Filial)
	
	If ll_Linhas > 0 Then
	
		For ll_Linha = 1 To ll_Linhas
			ls_Distribuidora	= lds.Object.cd_fornecedor	[ll_Linha]
			
			INSERT INTO pedido_filial_bloqueio  
						( id_tipo_bloqueio,   
						  cd_filial,   
						  cd_distribuidora,   
						  dh_pedido,   
						  nr_dia_semana,   
						  de_motivo_bloqueio)  
			  VALUES (	:as_tipo_bloqueio,
							:al_Filial,
							:ls_Distribuidora,
							:idh_dh_bloqueio,
							Null,
							:is_de_motivo_rejeicao)
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				as_Log = "Erro no INSERT da 'pedido_filial_bloqueio': "+SqlCa.SqlErrText
				Return False
			End If
			
			If Not This.of_Grava_Historic_Pedido_Filial_Bloqueio(al_Filial, ls_Distribuidora, as_Operacao, Ref as_Log) Then
				Return False
			End If
			
		Next
	Else
		as_log = "N$$HEX1$$e300$$ENDHEX$$o foi localizado nenhuma distribuidora para bloquear as distribuidoras da filial "+String(al_Filial)+"."
		Return False
	End If
	
Catch (RuntimeError lo_rte)
	as_log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_Insere_Pedido_Distribuidora', objeto 'uo_ge473_pedido_filial_bloqueio_sap'. Erro: "+lo_rte.GetMessage()
	Return False
	
Finally
	If IsValid(lds) Then Destroy(lds)
End try

Return True
end function

private function boolean of_delete_pedido_distribuidora (string as_tipo_bloqueio, string as_operacao, long al_filial, ref string as_log);dc_uo_ds_base	lds

Long	ll_Linha,&
		ll_Linhas
		
String	ls_Distribuidora		

Try
	lds	= Create dc_uo_ds_base

	If Not lds.of_ChangeDataObject('ds_ge473_filial_distrib_bloqueio', False) Then 
		as_log = "Erro ao alterar a DW [ds_ge473_filial_distrib_bloqueio]."
		Return False
	End If
	
	ll_Linhas = lds.Retrieve(al_Filial)
	
	If ll_Linhas > 0 Then
	
		For ll_Linha = 1 To ll_Linhas
			ls_Distribuidora	= lds.Object.cd_fornecedor	[ll_Linha]
			
			DELETE FROM pedido_filial_bloqueio
			WHERE	id_tipo_bloqueio	= :as_Tipo_Bloqueio
				AND	cd_filial				= :al_Filial
				AND	cd_distribuidora	= :ls_Distribuidora
			Using SqlCa;
			
			If SqlCa.SqlCode = -1 Then
				as_Log = "Erro no DELETE da 'pedido_filial_bloqueio': "+SqlCa.SqlErrText
				Return False
			End If
			
			If SqlCa.SqlNRows	<> 1 Then
				as_Log = "Erro no DELETE da 'pedido_filial_bloqueio'. Deveria ter exclu$$HEX1$$ed00$$ENDHEX$$do 1 linha, mas excluiu "+String(SqlCa.SqlNRows)+" linha(s)."
				Return False
			End If
			
			If Not This.of_Grava_Historic_Pedido_Filial_Bloqueio(al_Filial, ls_Distribuidora, as_Operacao, Ref as_Log) Then
				Return False
			End If
			
		Next
	Else
		as_log = "N$$HEX1$$e300$$ENDHEX$$o foi localizado nenhuma distribuidora para bloquear as distribuidoras da filial "+String(al_Filial)+"."
		Return False
	End If
	
Catch (RuntimeError lo_rte)
	as_log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_Insere_Pedido_Distribuidora', objeto 'uo_ge473_pedido_filial_bloqueio_sap'. Erro: "+lo_rte.GetMessage()
	Return False
	
Finally
	If IsValid(lds) Then Destroy(lds)
End try

Return True
end function

on uo_ge473_pedido_filial_bloqueio_sap.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge473_pedido_filial_bloqueio_sap.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;io_Comum	= Create uo_ge473_comum
end event

event destructor;Destroy(io_Comum)
end event

