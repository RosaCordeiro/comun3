HA$PBExportHeader$uo_ge473_produto_uf_sap.sru
forward
global type uo_ge473_produto_uf_sap from nonvisualobject
end type
end forward

global type uo_ge473_produto_uf_sap from nonvisualobject
end type
global uo_ge473_produto_uf_sap uo_ge473_produto_uf_sap

type variables
uo_ge473_comum io_Comum

DateTime	idh_preco_venda_futuro

Decimal	idc_vl_preco_venda_maximo,&
			idc_vl_preco_venda_futuro
			
String	is_cd_produto_sap,&
		is_cd_unidade_federacao			
end variables

forward prototypes
public function boolean of_atualiza_produto_uf (long al_controle)
private function boolean of_inicializa_variaveis (ref string as_log)
public function boolean of_valida_dados (ref string as_log)
public function boolean of_grava_historico_produto_uf (long al_produto, ref string as_log)
private function boolean of_insere_produto_uf (long al_produto, ref string as_log)
end prototypes

public function boolean of_atualiza_produto_uf (long al_controle);dc_uo_ds_base lds

Long	ll_Produto,&
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
	io_Comum.of_grava_erro(al_controle, 176, "Erro ao mudar a situa$$HEX2$$e700e300$$ENDHEX$$o na tabela interface_sap. N$$HEX1$$fa00$$ENDHEX$$mero de controle: "+String(al_controle)+". Erro: "+SqlCa.sqlErrText)
	Return False
End If

If ll_Achou = 0 Then Return True

Try
	
	lds		= Create dc_uo_ds_base
	
	If Not lds.of_ChangeDataObject('ds_ge473_lista_valores', False) Then 
		ls_Log = "Erro ao alterar a DW [ds_ge473_lista_valores]. Objeto [uo_ge473_produto_sap], fun$$HEX2$$e700e300$$ENDHEX$$o [of_atualiza_produto]."
		Return False
	End If
	
	ll_Linhas = lds.Retrieve(al_controle)
	
	If ll_Linhas < 0 Then
		ls_Log = "Erro no retrieve a DW [ds_ge473_lista_valores]. Objeto [uo_ge473_produto_sap], fun$$HEX2$$e700e300$$ENDHEX$$o [of_atualiza_produto]."
		Return False
	End If
	
	If ll_Linhas = 0 Then
		ls_Log = "N$$HEX1$$e300$$ENDHEX$$o foi localizado nenhum registro no retrieve a DW [ds_ge473_lista_valores]. Objeto [uo_ge473_produto_sap], fun$$HEX2$$e700e300$$ENDHEX$$o [of_atualiza_produto]."
		Return False
	End If	
	
	If Not io_Comum.of_Muda_Situacao_Interface(al_Controle, Ref ls_Log) Then Return False
	If Not This.of_Inicializa_Variaveis(Ref ls_Log) Then Return False
	
	/*
	 PRODUTO_UF (24)			
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
			Case 'cd_produto'
				is_cd_produto_sap = gf_Tira_Zero_Esquerda(ls_Vl_Item)
			Case 'cd_unidade_federacao'
				is_cd_unidade_federacao = ls_Vl_Item
			Case 'vl_preco_venda_futuro'
				If Not io_Comum.of_decimal(ls_Vl_Item, 'PRE$$HEX1$$c700$$ENDHEX$$O VENDA FUTURO', ref idc_vl_preco_venda_futuro, ref ls_Log) Then Return False
			Case 'dh_preco_venda_futuro'
				If Not io_Comum.of_date_time(ls_Vl_Item, 'DATA PRE$$HEX1$$c700$$ENDHEX$$O VENDA FUTURO', ref idh_preco_venda_futuro, ref ls_Log) Then Return False
			Case 'vl_preco_venda_maximo'
				If Not io_Comum.of_decimal(ls_Vl_Item, 'PRE$$HEX1$$c700$$ENDHEX$$O VENDA M$$HEX1$$c100$$ENDHEX$$XIMO', ref idc_vl_preco_venda_maximo, ref ls_Log) Then Return False
		End choose
		
	Next
		
	If This.of_Valida_Dados(Ref ls_Log) Then
		If io_Comum.of_Localiza_Codigo_Produto_Legado(is_cd_produto_sap, Ref ll_Produto, Ref ls_Log) Then
			If This.of_Grava_Historico_Produto_Uf(ll_Produto, Ref ls_Log) Then
				If This.of_Insere_Produto_Uf(ll_Produto, Ref ls_Log) Then
					lb_Sucesso	= True
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

private function boolean of_inicializa_variaveis (ref string as_log);Try
	
	setNull(is_cd_produto_sap)
	setNull(idh_preco_venda_futuro)
	setNull(idc_vl_preco_venda_maximo)
	setNull(idc_vl_preco_venda_futuro)
	setNull(is_cd_unidade_federacao)

Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro ao ao iniciar as vari$$HEX1$$e100$$ENDHEX$$veis. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try

Return True
end function

public function boolean of_valida_dados (ref string as_log);Try
		
	If IsNull(is_cd_produto_sap) or Trim(is_cd_produto_sap) = "" Then
		as_Log	= "O c$$HEX1$$f300$$ENDHEX$$digo do produto do SAP n$$HEX1$$e300$$ENDHEX$$o pode ser nulo."
		Return False
	End If
	
	If IsNull(is_cd_unidade_federacao) or Trim(is_cd_unidade_federacao) = "" Then
		as_Log	= "A Unidade de Federa$$HEX2$$e700e300$$ENDHEX$$o (UF) n$$HEX1$$e300$$ENDHEX$$o pode ser nula."
		Return False
	End If
	
Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_valida_dados'. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try

Return True
end function

public function boolean of_grava_historico_produto_uf (long al_produto, ref string as_log);DateTime	ldh_preco_venda_futuro

Decimal	ldc_vl_preco_venda_maximo,&
			ldc_vl_preco_venda_futuro
			
Try			
	
	Select		dh_preco_venda_futuro,
				vl_preco_venda_maximo,
				vl_preco_venda_futuro
	Into	:ldh_preco_venda_futuro,
			:ldc_vl_preco_venda_maximo,
			:ldc_vl_preco_venda_futuro
	From produto_uf	
	Where	cd_unidade_federacao	= :is_cd_unidade_federacao
		And	cd_produto					= :al_produto
	Using SqlCa;
	
	Choose Case SqlCa.sqlcode
		Case 0
			
		Case 100
			as_Log	= "N$$HEX1$$e300$$ENDHEX$$o foi localizado o produto, fun$$HEX2$$e700e300$$ENDHEX$$o 'of_grava_historico_produto_uf'."
			Return False
		Case -1
			as_Log	= "Erro no select da tabela 'produto_uf', fun$$HEX2$$e700e300$$ENDHEX$$o 'of_grava_historico_produto_uf'. Erro: "+SqlCa.sqlErrText
			Return False
	End Choose
	
	
	If (ldh_preco_venda_futuro	<>	idh_preco_venda_futuro) or (IsNull(ldh_preco_venda_futuro) and Not IsNull(idh_preco_venda_futuro)) Then
		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_UF", String(al_produto), "DH_PRECO_VENDA_FUTURO", String(ldh_preco_venda_futuro, "dd/mm/yyyy"), String(idh_preco_venda_futuro, "dd/mm/yyyy"), 'SAP001', 'A', Ref as_log, True) Then Return False
	End If
	
	If (ldc_vl_preco_venda_maximo	<>	idc_vl_preco_venda_maximo)  or (IsNull(ldc_vl_preco_venda_maximo) and Not IsNull(idc_vl_preco_venda_maximo)) Then
		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_UF", String(al_produto), "VL_PRECO_VENDA_MAXIMO", String(ldc_vl_preco_venda_maximo), String(idc_vl_preco_venda_maximo), 'SAP001', 'A', Ref as_log, True) Then Return False
	End If
	
	If (ldc_vl_preco_venda_futuro	<>	idc_vl_preco_venda_futuro)  or (IsNull(ldc_vl_preco_venda_futuro) and Not IsNull(idc_vl_preco_venda_futuro)) Then
		If Not gf_Grava_Historico_Alteracao_Tabela("PRODUTO_UF", String(al_produto), "VL_PRECO_VENDA_FUTURO", String(ldc_vl_preco_venda_futuro), String(idc_vl_preco_venda_futuro), 'SAP001', 'A', Ref as_log, True) Then Return False
	End If

Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_grava_historico_produto_uf'. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try		

Return True
end function

private function boolean of_insere_produto_uf (long al_produto, ref string as_log);Update produto_uf set
dh_preco_venda_futuro			= :idh_preco_venda_futuro,
vl_preco_venda_futuro			= :idc_vl_preco_venda_futuro,
vl_preco_venda_maximo			= :idc_vl_preco_venda_maximo,
nr_matric_preco_venda_futuro	= 'SAP001'
Where	cd_unidade_federacao	= :is_cd_unidade_federacao
	And	cd_produto					= :al_Produto
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	as_Log	= "Erro ao atualizar os dados da tabela 'PRODUTO_UF'. C$$HEX1$$f300$$ENDHEX$$digo do produto SAP ["+is_cd_produto_sap+"], c$$HEX1$$f300$$ENDHEX$$digo legado ["+String(al_Produto)+"]. Erro: "+ SqlCa.SqlErrText
	Return False
End If

If SqlCa.SqlNRows <> 1 Then
	as_Log	= "Deveria ter atualizado 1 linha na tabela 'PRODUTO_UF', mas a tentativa de atualizar foi de "+String(SqlCa.SqlNRows)+" linha(s). C$$HEX1$$f300$$ENDHEX$$digo do produto SAP ["+is_cd_produto_sap+"], c$$HEX1$$f300$$ENDHEX$$digo legado ["+String(al_Produto)+"]. Erro: "+ SqlCa.SqlErrText
	Return False
End If

Return True
end function

on uo_ge473_produto_uf_sap.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge473_produto_uf_sap.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;io_Comum	= Create uo_ge473_comum
end event

event destructor;Destroy(io_Comum)
end event

