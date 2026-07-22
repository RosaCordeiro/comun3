HA$PBExportHeader$uo_ge473_resumo_repos_estoque_sos_estoque_minimo_sap.sru
forward
global type uo_ge473_resumo_repos_estoque_sos_estoque_minimo_sap from nonvisualobject
end type
end forward

global type uo_ge473_resumo_repos_estoque_sos_estoque_minimo_sap from nonvisualobject
end type
global uo_ge473_resumo_repos_estoque_sos_estoque_minimo_sap uo_ge473_resumo_repos_estoque_sos_estoque_minimo_sap

type variables
uo_ge473_comum io_Comum


String	is_cd_motivo_alteracao,&
		is_cd_produto_sap,&
		is_cd_promocao,&
		is_cd_promocao_sap,&
		is_id_filial_sap,&
		is_id_permite_alteracao,&
		is_id_tipo,&
		is_nome_promocao,&
		is_nr_matricula

Long	il_qt_estoque

DateTime	idh_dh_alteracao,&
				idh_dh_fim_vigencia,&
				idh_dh_inicio_vigencia,&
				idh_dh_item_final_vigencia,&
				idh_dh_item_inicio_vigencia
end variables

forward prototypes
public function boolean of_atualiza_resumo_repos_est_sos_est_min (long al_controle)
public function boolean of_inicializa_variaveis (ref string as_log)
public function boolean of_grava_historico (long al_filial, long al_produto, ref string as_log)
public function boolean of_historico_resumo_reposicao_estoque (long al_filial, long al_produto, ref string as_log)
public function boolean of_insere_dados (long al_filial, long al_produto, ref string as_log)
public function boolean of_insere_resumo_reposicao_estoque (long al_filial, long al_produto, ref string as_log)
public function boolean of_valida_dados (ref string as_log)
public function boolean of_inserre_promocao_sos_estoque_minimo (long al_filial, long al_produto, ref string as_log)
public function boolean of_historico_promocao_sos_estoque_minimo (long al_filial, long al_produto, ref string as_log)
end prototypes

public function boolean of_atualiza_resumo_repos_est_sos_est_min (long al_controle);dc_uo_ds_base lds

Long	ll_Produto,&
		ll_Achou,&
		ll_Linhas,&
		ll_Linha,&
		ll_Filial
		
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
		ls_Log = "Erro ao alterar a DW [ds_ge473_lista_valores]. Objeto [uo_ge473_resumo_repos_estoque_sos_estoque_minimo_sap], fun$$HEX2$$e700e300$$ENDHEX$$o [of_atualiza_resumo_repos_est_sos_est_min]."
		Return False
	End If
	
	ll_Linhas = lds.Retrieve(al_controle)
	
	If ll_Linhas < 0 Then
		ls_Log = "Erro no retrieve a DW [ds_ge473_lista_valores]. Objeto [uo_ge473_resumo_repos_estoque_sos_estoque_minimo_sap], fun$$HEX2$$e700e300$$ENDHEX$$o [of_atualiza_resumo_repos_est_sos_est_min]."
		Return False
	End If
	
	If ll_Linhas = 0 Then
		ls_Log = "N$$HEX1$$e300$$ENDHEX$$o foi localizado nenhum registro no retrieve a DW [ds_ge473_lista_valores]. Objeto [uo_ge473_resumo_repos_estoque_sos_estoque_minimo_sap], fun$$HEX2$$e700e300$$ENDHEX$$o [of_atualiza_resumo_repos_est_sos_est_min]."
		Return False
	End If	
	
	If Not io_Comum.of_Muda_Situacao_Interface(al_Controle, Ref ls_Log) Then Return False
	If Not This.of_Inicializa_Variaveis(Ref ls_Log) Then Return False
	
	/*
	 PROMOCAO_SOS_ESTOQUE_MINIMO / RESUMO_REPOSICAO_ESTOQUE	(33)			
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
			Case 'cd_motivo_alteracao'
				is_cd_motivo_alteracao = ls_Vl_Item
			Case 'cd_produto_sap'
				is_cd_produto_sap = gf_Tira_Zero_Esquerda(ls_Vl_Item)
			Case 'cd_promocao'
				is_cd_promocao	= ls_Vl_Item
			Case 'cd_promocao_sap'
				is_cd_promocao_sap	= ls_Vl_Item
			Case 'id_filial_sap'
				is_id_filial_sap	= ls_Vl_Item
			Case 'id_permite_alteracao'
				is_id_permite_alteracao	= ls_Vl_Item
			Case 'id_tipo'
				is_id_tipo	= ls_Vl_Item
			Case 'nome_promocao'
				is_nome_promocao	= ls_Vl_Item
			Case 'nr_matricula'
				is_nr_matricula	= ls_Vl_Item
			Case 'qt_estoque'
				il_qt_estoque	= Long(ls_Vl_Item)
			Case 'dh_alteracao'
				If Not io_Comum.of_Date_Time(ls_Vl_Item, 'DATA DE ALTERA$$HEX2$$c700c300$$ENDHEX$$O', ref idh_dh_alteracao, ref ls_Log) Then Return False
			Case 'dh_fim_vigencia'
				If Not io_Comum.of_Date_Time(ls_Vl_Item, 'DATA DO FIM DA VIG$$HEX1$$ca00$$ENDHEX$$NCIA', ref idh_dh_fim_vigencia, ref ls_Log) Then Return False
			Case 'dh_inicio_vigencia'
				If Not io_Comum.of_Date_Time(ls_Vl_Item, 'DATA DO IN$$HEX1$$cd00$$ENDHEX$$CIO DA VIG$$HEX1$$ca00$$ENDHEX$$NCIA', ref idh_dh_inicio_vigencia, ref ls_Log) Then Return False
			Case 'dh_item_final_vigencia'
				If Not io_Comum.of_Date_Time(ls_Vl_Item, 'DATA DO FIM DA VIG$$HEX1$$ca00$$ENDHEX$$NCIA DO ITEM', ref idh_dh_item_final_vigencia, ref ls_Log) Then Return False
			Case 'dh_item_inicio_vigencia'
				If Not io_Comum.of_Date_Time(ls_Vl_Item, 'DATA DO IN$$HEX1$$cd00$$ENDHEX$$CIO DA VIG$$HEX1$$ca00$$ENDHEX$$NCIA DO ITEM', ref idh_dh_item_inicio_vigencia, ref ls_Log) Then Return False
		End choose
		
	Next
		
	If io_Comum.of_Localiza_Codigo_Produto_Legado(is_cd_produto_sap, Ref ll_Produto, Ref ls_Log) Then
		If io_Comum.of_Localiza_Codigo_Filial_Legado(is_id_filial_sap, Ref ll_Filial, Ref ls_Log) Then
			If This.of_Grava_Historico(ll_Filial, ll_Produto, Ref ls_Log) Then
				If This.of_Insere_Dados(ll_Filial, ll_Produto, Ref ls_Log) Then
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

public function boolean of_inicializa_variaveis (ref string as_log);Try
	
	SetNull(is_cd_motivo_alteracao)
	SetNull(is_cd_produto_sap)
	SetNull(is_cd_promocao)
	SetNull(is_cd_promocao_sap)
	SetNull(is_id_filial_sap)
	SetNull(is_id_permite_alteracao)
	SetNull(is_id_tipo)
	SetNull(is_nome_promocao)
	SetNull(is_nr_matricula)
	SetNull(il_qt_estoque)
	SetNull(idh_dh_alteracao)
	SetNull(idh_dh_fim_vigencia)
	SetNull(idh_dh_inicio_vigencia)
	SetNull(idh_dh_item_final_vigencia)
	SetNull(idh_dh_item_inicio_vigencia)

Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro ao ao iniciar as vari$$HEX1$$e100$$ENDHEX$$veis. Erro: "+lo_rte.GetMessage()
	Return False
End Try

Return True
end function

public function boolean of_grava_historico (long al_filial, long al_produto, ref string as_log);Try
	If is_id_tipo = "ESB" Then //RESUMO_REPOSICAO_ESTOQUE
		If Not of_Historico_Resumo_Reposicao_Estoque(al_Filial, al_Produto, Ref as_Log) Then 
			Return False
		End If		

	ElseIf is_id_tipo = "PRO" Then
		If Not of_Historico_Promocao_Sos_Estoque_Minimo(al_Filial, al_Produto, Ref as_Log) Then
			Return False
		End If
		
	Else
		as_Log = "Tipo de registro '"+is_id_tipo+"' n$$HEX1$$e300$$ENDHEX$$o esperado."
		Return False		
	End If
Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_grava_historico'. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try		
	
Return True
end function

public function boolean of_historico_resumo_reposicao_estoque (long al_filial, long al_produto, ref string as_log);String	ls_Chave

Long	ll_Estoque_Base
		
DateTime	ldh_Termino_Bloqueio

Try
	
	Select		qt_estoque_base,
				dh_termino_bloqueio
	Into		:ll_Estoque_Base,
				:ldh_Termino_Bloqueio
	From resumo_reposicao_estoque	
	Where	cd_filial		= :al_Filial
		And	cd_produto	= :al_produto
	Using SqlCa;
	
	Choose Case SqlCa.sqlcode
		Case 0
			
		Case 100
			as_Log	= "N$$HEX1$$e300$$ENDHEX$$o foi localizado nenhum registro na tabela 'resumo_reposicao_estoque', fun$$HEX2$$e700e300$$ENDHEX$$o 'of_Historico_Resumo_Reposicao_Estoque'."
			Return False
		Case -1
			as_Log	= "Erro no select da tabela 'resumo_reposicao_estoque', fun$$HEX2$$e700e300$$ENDHEX$$o 'of_Historico_Resumo_Reposicao_Estoque'. Erro: "+SqlCa.sqlErrText
			Return False
	End Choose
	
	ls_Chave	= String(al_Filial)+"@#!"+String(al_produto)
	
	If (ll_Estoque_Base	<>	il_qt_estoque) or (IsNull(ll_Estoque_Base) and Not IsNull(il_qt_estoque)) Then
		If Not gf_Grava_Historico_Alteracao_Tabela("RESUMO_REPOSICAO_ESTOQUE", ls_Chave, "QT_ESTOQUE_BASE", String(ll_Estoque_Base), String(il_qt_estoque), is_nr_matricula, 'A', Ref as_log, True) Then Return False
	End If
	
	If (ldh_Termino_Bloqueio	<>	idh_dh_item_final_vigencia) or (IsNull(ldh_Termino_Bloqueio) and Not IsNull(idh_dh_item_final_vigencia)) Then
		If Not gf_Grava_Historico_Alteracao_Tabela("RESUMO_REPOSICAO_ESTOQUE", ls_Chave, "DH_TERMINO_BLOQUEIO", String(ldh_Termino_Bloqueio, "dd/mm/yyyy"), String(idh_dh_item_final_vigencia, "dd/mm/yyyy"), is_nr_matricula, 'A', Ref as_log, True) Then Return False
	End If
Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_Historico_Resumo_Reposicao_Estoque'. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try	

Return True
end function

public function boolean of_insere_dados (long al_filial, long al_produto, ref string as_log);Try
	If is_id_tipo = "ESB" Then //RESUMO_REPOSICAO_ESTOQUE
		If Not of_insere_resumo_reposicao_estoque(al_Filial, al_Produto, Ref as_Log) Then 
			Return False
		End If		
	
	ElseIf is_id_tipo = "PRO" Then	//PROMOCAO_SOS_ESTOQUE_MINIMO
		If Not of_Inserre_Promocao_Sos_Estoque_Minimo(al_Filial, al_Produto, Ref as_Log) Then 
			Return False
		End If		
	Else
		as_Log = "Tipo de registro '"+is_id_tipo+"' n$$HEX1$$e300$$ENDHEX$$o esperado."
		Return False	
	End If
Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_grava_historico'. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try		
	
Return True
end function

public function boolean of_insere_resumo_reposicao_estoque (long al_filial, long al_produto, ref string as_log);Try
	Update resumo_reposicao_estoque set
			dh_alteracao				= getDate(),
			id_alteracao					= 'M',
			nr_matricula_alteracao	= :is_nr_matricula,
			de_motivo_alteracao		= :is_cd_motivo_alteracao,
			qt_estoque_base			= :il_qt_estoque,
			dh_termino_bloqueio		= :idh_dh_item_final_vigencia
	Where	cd_filial		= :al_Filial
		And	cd_produto	= :al_Produto
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		as_Log	= "Erro ao atualizar os dados da tabela 'RESUMO_REPOSICAO_ESTOQUE'. C$$HEX1$$f300$$ENDHEX$$digo do produto SAP ["+is_cd_produto_sap+"], c$$HEX1$$f300$$ENDHEX$$digo legado ["+String(al_Produto)+"]. Erro: "+ SqlCa.SqlErrText
		Return False
	End If
	
	If SqlCa.SqlNRows <> 1 Then
		as_Log	= "Deveria ter atualizado 1 linha na tabela 'RESUMO_REPOSICAO_ESTOQUE', mas a tentativa de atualizar foi de "+String(SqlCa.SqlNRows)+" linha(s). C$$HEX1$$f300$$ENDHEX$$digo do produto SAP ["+is_cd_produto_sap+"], c$$HEX1$$f300$$ENDHEX$$digo legado ["+String(al_Produto)+"]. Erro: "+ SqlCa.SqlErrText
		Return False
	End If
Catch ( runtimeerror  lo_rte )
	as_Log = "Erro ao atualizar os dados da tabela 'RESUMO_REPOSICAO_ESTOQUE'. Erro: "+lo_rte.GetMessage()
	Return False
End Try	

Return True
end function

public function boolean of_valida_dados (ref string as_log);Long	ll_Qtde

Try
		
	If IsNull(il_qt_estoque) or (il_qt_estoque < 0) Then
		as_Log	= "O Quantidade de Estoque deve ser maio do que zero e n$$HEX1$$e300$$ENDHEX$$o pode ser nula."
		Return False
	End If
	
	Select Count(*)
	Into :ll_Qtde
	From usuario
	Where nr_matricula = :is_nr_matricula
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		as_Log	= "Erro ao verificar se a matr$$HEX1$$ed00$$ENDHEX$$cula existe no Sybase: "+SqlCa.SqlErrText
		Return False
	End If
	
	If ll_Qtde = 0 Then
		as_Log	= "N$$HEX1$$e300$$ENDHEX$$o foi localizado a matr$$HEX1$$ed00$$ENDHEX$$cula '"+is_nr_matricula+"' no Sybase."
		Return False
	End If
	
Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_valida_dados'. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try

Return True
end function

public function boolean of_inserre_promocao_sos_estoque_minimo (long al_filial, long al_produto, ref string as_log);Long	ll_Cd_Promocao,&
		ll_Motivo_Alteracao

Try
	ll_Cd_Promocao		= Long(is_cd_promocao)
	ll_Motivo_Alteracao	= Long(is_cd_motivo_alteracao)
	
	Update promocao_sos_estoque_minimo set
							qt_estoque_minimo			= :il_qt_estoque,
							id_alterado_filial				= 'M',
	/*Falta definir*/	qt_estoque_minimo_matriz	= 0,
							nr_matricula_alteracao		= :is_nr_matricula,
							cd_motivo_alteracao			= :ll_Motivo_Alteracao
	Where	cd_promocao_sos	= :ll_Cd_Promocao
		And	cd_filial				= :al_Filial
		And	cd_produto			= :al_Produto
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		as_Log	= "Erro ao atualizar os dados da tabela 'PROMOCAO_SOS_ESTOQUE_MINIMO'. C$$HEX1$$f300$$ENDHEX$$digo do produto SAP ["+is_cd_produto_sap+"], c$$HEX1$$f300$$ENDHEX$$digo legado ["+String(al_Produto)+"]. Erro: "+ SqlCa.SqlErrText
		Return False
	End If
	
	If SqlCa.SqlNRows <> 1 Then
		as_Log	= "Deveria ter atualizado 1 linha na tabela 'PROMOCAO_SOS_ESTOQUE_MINIMO', mas a tentativa de atualizar foi de "+String(SqlCa.SqlNRows)+" linha(s). C$$HEX1$$f300$$ENDHEX$$digo do produto SAP ["+is_cd_produto_sap+"], c$$HEX1$$f300$$ENDHEX$$digo legado ["+String(al_Produto)+"]. Erro: "+ SqlCa.SqlErrText
		Return False
	End If
Catch ( runtimeerror  lo_rte )
	as_Log = "Erro ao atualizar os dados da tabela 'PROMOCAO_SOS_ESTOQUE_MINIMO'. Erro: "+lo_rte.GetMessage()
	Return False
End Try	

Return True
end function

public function boolean of_historico_promocao_sos_estoque_minimo (long al_filial, long al_produto, ref string as_log);String	ls_Chave

Long	ll_Estoque_Minimo,&
		ll_Estoque_Minimo_Matriz,&
		ll_Estoque_Minimo_Matriz_New,&
		ll_Cd_Promocao,&
		ll_Motivo_Alteracao_New,&
		ll_Motivo_Alteracao_Old

Try
	
	ll_Cd_Promocao			= Long(is_cd_promocao)
	ll_Motivo_Alteracao_New	= Long(is_cd_motivo_alteracao)
		
		
	
	Select		qt_estoque_minimo,
				qt_estoque_minimo_matriz,
				cd_motivo_alteracao
	Into		:ll_Estoque_Minimo,
				:ll_Estoque_Minimo_Matriz,
				:ll_Motivo_Alteracao_Old
	From promocao_sos_estoque_minimo	
	Where	cd_promocao_sos	= :ll_Cd_Promocao
		And	cd_filial		= :al_Filial
		And	cd_produto	= :al_produto
	Using SqlCa;
	
	Choose Case SqlCa.sqlcode
		Case 0
			
		Case 100
			as_Log	= "N$$HEX1$$e300$$ENDHEX$$o foi localizado nenhum registro na tabela 'promocao_sos_estoque_minimo', fun$$HEX2$$e700e300$$ENDHEX$$o 'of_historico_promocao_sos_estoque_minimo'."
			Return False
		Case -1
			as_Log	= "Erro no select da tabela 'promocao_sos_estoque_minimo', fun$$HEX2$$e700e300$$ENDHEX$$o 'of_historico_promocao_sos_estoque_minimo'. Erro: "+SqlCa.sqlErrText
			Return False
	End Choose
	
	ls_Chave	= String(al_Filial)+"@#!"+String(al_produto)
	
	If (ll_Estoque_Minimo	<>	il_qt_estoque) or (IsNull(ll_Estoque_Minimo) and Not IsNull(il_qt_estoque)) Then
		ls_Chave	= String(ll_Cd_Promocao)+"@#!"+String(al_Filial)+"@#!"+String(al_produto)+"@#!"+String(il_qt_estoque)
		If Not gf_Grava_Historico_Alteracao_Tabela("PROMOCAO_SOS_ESTOQUE_MINIMO", ls_Chave, "QT_ESTOQUE_MINIMO", String(ll_Estoque_Minimo), String(il_qt_estoque), is_nr_matricula, 'A', Ref as_log, True) Then Return False
	End If
	
	//FALTA DEFINIR O ESTOQUE MINIMO MATRIZ QUE VEM DO SAP
	//If (ll_Estoque_Minimo_Matriz	<>	ll_Estoque_Minimo_Matriz_New) or (IsNull(ll_Estoque_Minimo_Matriz) and Not IsNull(ll_Estoque_Minimo_Matriz_New)) Then
	//	ls_Chave	= String(ll_Cd_Promocao)+"@#!"+String(al_Filial)+"@#!"+String(al_produto)+"@#!"+String(ll_Estoque_Minimo_Matriz_New)
	//	If Not gf_Grava_Historico_Alteracao_Tabela("PROMOCAO_SOS_ESTOQUE_MINIMO", ls_Chave, "QT_ESTOQUE_MINIMO_MATRIZ", String(ll_Estoque_Minimo_Matriz), String(il_qt_estoque), is_nr_matricula, 'A', Ref as_log, True) Then Return False
	//End If
	
	If (ll_Motivo_Alteracao_Old	<>	ll_Motivo_Alteracao_New) or (IsNull(ll_Motivo_Alteracao_Old) and Not IsNull(ll_Motivo_Alteracao_New)) Then
		ls_Chave	= String(ll_Cd_Promocao)+"@#!"+String(al_Filial)+"@#!"+String(al_produto)+"@#!"+String(ll_Motivo_Alteracao_New)
		If Not gf_Grava_Historico_Alteracao_Tabela("PROMOCAO_SOS_ESTOQUE_MINIMO", ls_Chave, "CD_MOTIVO_ALTERACAO", String(ll_Estoque_Minimo), String(il_qt_estoque), is_nr_matricula, 'A', Ref as_log, True) Then Return False
	End If
	
Catch ( runtimeerror  lo_rte )
	as_Log = "Ocorreu erro na fun$$HEX2$$e700e300$$ENDHEX$$o 'of_historico_promocao_sos_estoque_minimo'. Erro: "+lo_rte.GetMessage( )
	Return False						 
End Try	

Return True
end function

on uo_ge473_resumo_repos_estoque_sos_estoque_minimo_sap.create
call super::create
TriggerEvent( this, "constructor" )
end on

on uo_ge473_resumo_repos_estoque_sos_estoque_minimo_sap.destroy
TriggerEvent( this, "destructor" )
call super::destroy
end on

event constructor;io_Comum	= Create uo_ge473_comum
end event

event destructor;Destroy(io_Comum)
end event

