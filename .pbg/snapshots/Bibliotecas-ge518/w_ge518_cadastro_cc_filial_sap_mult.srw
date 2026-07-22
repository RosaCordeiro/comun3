HA$PBExportHeader$w_ge518_cadastro_cc_filial_sap_mult.srw
forward
global type w_ge518_cadastro_cc_filial_sap_mult from dc_w_cadastro_selecao_lista
end type
end forward

global type w_ge518_cadastro_cc_filial_sap_mult from dc_w_cadastro_selecao_lista
integer width = 3927
integer height = 2368
string title = "GE518 - Cadastro Filial  e/ou Centro de Custo - Interface SAP "
end type
global w_ge518_cadastro_cc_filial_sap_mult w_ge518_cadastro_cc_filial_sap_mult

type variables
String is_tp_tabela
Long   il_Empresa_Sap

dc_uo_ds_base ivds_lista_itens

// Conex$$HEX1$$e300$$ENDHEX$$o Oracle 
dc_uo_transacao 				ivtr_Mult

end variables

forward prototypes
public subroutine wf_verifica_insere (string as_tp_tabela)
public function boolean wf_verifica_item (long al_chave_legado, ref string as_descricao, ref string as_usuario)
end prototypes

public subroutine wf_verifica_insere (string as_tp_tabela);
end subroutine

public function boolean wf_verifica_item (long al_chave_legado, ref string as_descricao, ref string as_usuario);Boolean lb_Encontrou
String ls_Find

as_descricao = ''
as_usuario = ''

lb_Encontrou	= (dw_2.Find("cd_chave_legado = '"+String(al_chave_legado)+ "'", 1, dw_2.RowCount()-1) > 0 )

If lb_Encontrou then
	/* N$$HEX1$$e300$$ENDHEX$$o permitir$$HEX1$$e100$$ENDHEX$$ gravar item que j$$HEX1$$e100$$ENDHEX$$ esteja cadastrado */ 
	Return True
End If 

If is_tp_tabela = 'FILIAL' then
	Select fi.nm_fantasia into :as_descricao
		From filial fi	
		Where fi.cd_filial = cast(:al_chave_legado as decimal) Using SQLCa;
		
		If SQLCa.SQLCode = -1 Then
			SQLCa.Of_RollBack()
			SQLCa.Of_MsgDbError("Falha ao buscar Filial")
			Return False
		End If
else
	/* Tratar$$HEX1$$e100$$ENDHEX$$ Centro de Custo */
	Select cc.de_centro_custo into :as_descricao
		From centro_custo 	cc		
		where cc.cd_centro_custo = cast(:al_chave_legado as decimal) Using SQLCa;
		
		If SQLCa.SQLCode = -1 Then
			SQLCa.Of_RollBack()
			SQLCa.Of_MsgDbError("Falha ao buscar Centro de Custo")
			Return False
		End If
End If	

/* Pesquisa Nome do usuario */
Select u.nm_usuario into :as_usuario
From  usuario  u     	
Where u.nr_matricula = :gvo_Aplicacao.ivo_seguranca.nr_matricula Using SQLCa;

If SQLCa.SQLCode = -1 Then
	SQLCa.Of_RollBack()
	SQLCa.Of_MsgDbError("Falha ao buscar Usu$$HEX1$$e100$$ENDHEX$$rio")
	Return False
End If

Return lb_Encontrou
end function

on w_ge518_cadastro_cc_filial_sap_mult.create
call super::create
end on

on w_ge518_cadastro_cc_filial_sap_mult.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;ivtr_Mult 	= Create dc_uo_transacao

dw_1.Object.cd_empresa			[1] = 1000
dw_1.Object.tp_tabela				[1] = 'CENTRO_CUSTO' 

If Lower( SqlCa.DataBase ) = 'homologa' Then
		//Homologa$$HEX2$$e700e300$$ENDHEX$$o
		If Not(ivtr_Mult.of_isconnected()) Then
			ivtr_Mult.ivs_DataBase 	= "MULT"
			ivtr_Mult.ivs_Usuario 		= "clamteste"
			ivtr_Mult.DBParm = "CommitOnDisconnect='No',DecimalSeparator='.,',Date=' ''''DD/MM/YYYY'''' '"
			If Not ivtr_Mult.of_Connect("CLAMTESTE", "EX") Then
					ivtr_Mult.of_msgdberror( )
			End If
		End If
	Else
		//Produ$$HEX2$$e700e300$$ENDHEX$$o
		If Not(ivtr_Mult.of_isconnected()) Then
			ivtr_Mult.ivs_DataBase 	= "MULT"
			ivtr_Mult.ivs_Usuario 		= "clamprod"
			ivtr_Mult.DBParm = "CommitOnDisconnect='No',DecimalSeparator='.,',Date=' ''''DD/MM/YYYY'''' '"
			If Not ivtr_Mult.of_Connect("CLAMPROD", "EX") Then
					ivtr_Mult.of_msgdberror( )
			End If
		End If
End If



end event

event ue_preopen;call super::ue_preopen;
ivds_lista_itens		= Create dc_uo_ds_base
ivds_lista_itens.of_changedataobject("dw_ge518_cadastro_cc")
ivb_grava_log =True
end event

event close;call super::close;Destroy(ivds_lista_itens)

If IsValid(ivtr_Mult) Then
	If ivtr_Mult.Of_IsConnected( ) Then ivtr_Mult.Of_disconnect( )
	Destroy(ivtr_Mult)
End If



end event

event ue_save;call super::ue_save;Long 		ll_Achou 
Long 		ll_Linha, ll_Totlin
String 	ls_cd_chave_legado, ls_cd_chave_sap
String 	ls_matricula
Datetime ldt_data

If AncestorReturnValue > 0 Then
	ll_Totlin = dw_2.RowCount()
	// Tratar$$HEX1$$e100$$ENDHEX$$ atualiza$$HEX2$$e700e300$$ENDHEX$$o no banco Oracle
    ll_Achou = dw_2.Find("id_situacao = 'I'", 1, ll_Totlin )
	 
    If  ll_Achou <> 0 Then
	For ll_Linha = ll_Achou to ll_Totlin
            // Inserir$$HEX1$$e100$$ENDHEX$$ no bd Oracle as Novas Linhas
			If  dw_2.Object.id_situacao [ll_Linha]	= 'I' then
				ls_cd_chave_legado 	= dw_2.Object.cd_chave_legado 			[ll_Linha]
				ls_cd_chave_sap		= dw_2.Object.cd_chave_sap				[ll_Linha]
				ls_matricula				= dw_2.Object.nr_matricula_inclusao 	[ll_Linha]
				ldt_data					= dw_2.Object.dh_inclusao 					[ll_Linha]
				
				Insert into integracao_sap (cd_empresa,cd_tabela,cd_chave_sap,cd_chave_legado,dh_inclusao,nr_matricula_inclusao) 
				values (:il_Empresa_Sap,:is_tp_tabela,:ls_cd_chave_sap, :ls_cd_chave_legado,:ldt_data, :ls_matricula) using ivtr_Mult;
		
				If ivtr_Mult.SQLCode = -1 Then
					ivtr_Mult.of_msgdberror( "Erro na Grava$$HEX2$$e700e300$$ENDHEX$$o item no banco de dados Oracle")
					ivtr_Mult.of_RollBack( )
				else
					ivtr_Mult.of_commit()
				End If		
			End If
		Next
	End iF 
End If

Return AncestorReturnValue
end event

type dw_visual from dc_w_cadastro_selecao_lista`dw_visual within w_ge518_cadastro_cc_filial_sap_mult
end type

type gb_aux_visual from dc_w_cadastro_selecao_lista`gb_aux_visual within w_ge518_cadastro_cc_filial_sap_mult
end type

type dw_1 from dc_w_cadastro_selecao_lista`dw_1 within w_ge518_cadastro_cc_filial_sap_mult
integer width = 1783
string dataobject = "dw_ge518_selecao"
end type

event dw_1::rowfocuschanged;call super::rowfocuschanged;dw_2.Post Event ue_Retrieve()
end event

event dw_1::itemchanged;call super::itemchanged;dw_2.reset()
end event

type gb_2 from dc_w_cadastro_selecao_lista`gb_2 within w_ge518_cadastro_cc_filial_sap_mult
integer width = 3831
integer height = 1864
end type

type gb_1 from dc_w_cadastro_selecao_lista`gb_1 within w_ge518_cadastro_cc_filial_sap_mult
integer width = 3831
end type

type dw_2 from dc_w_cadastro_selecao_lista`dw_2 within w_ge518_cadastro_cc_filial_sap_mult
event wf_verifica_insere ( string as_tabela )
integer x = 59
integer y = 348
integer width = 3794
integer height = 1792
string dataobject = "dw_ge518_cadastro_filial"
end type

event dw_2::ue_recuperar;//override
Long 		ll_Totlin

dw_1.AcceptText()		

il_Empresa_Sap	= dw_1.Object.cd_empresa	[1]
is_tp_tabela			= dw_1.Object.tp_tabela		[1]

If is_tp_tabela = 'CENTRO_CUSTO'  then
	This.of_ChangeDataObject("dw_ge518_cadastro_cc")
	ivds_lista_itens.of_ChangeDataObject("dw_ge518_cadastro_cc")
else
	This.of_ChangeDataObject("dw_ge518_cadastro_filial")
	ivds_lista_itens.of_ChangeDataObject("dw_ge518_cadastro_filial")
End If	
	
This.SetRedraw(False)

ll_Totlin = This.retrieve( il_Empresa_Sap, is_tp_tabela)
If ll_Totlin < 0 Then
	This.Reset()
	Return -1
End If

ivds_lista_itens.retrieve (il_Empresa_Sap, is_tp_tabela) /* esta Ds ser$$HEX1$$e100$$ENDHEX$$ utilizada para identificar as linhas novas digitadas */ 

//Seta TabOrder=0 para n$$HEX1$$e300$$ENDHEX$$o haver edi$$HEX2$$e700e300$$ENDHEX$$o
This.Modify('cd_chave_sap'+".TabSequence=0")

SetPointer(Arrow!)
This.SetRedraw(True)

Return This.RowCount()
end event

event dw_2::ue_postretrieve;//override

Super::Event ue_PostRetrieve(This.RowCount())

This.Sort()

Return This.RowCount()
end event

event dw_2::constructor;call super::constructor;This.Of_Setrowselection( )

end event

event dw_2::itemchanged;call super::itemchanged;Long ll_Linha,  ll_Totlin,  ll_chave_legado	
String lvs_descricao, lvs_usuario

If dwo.Name = "cd_chave_legado" Then
	ll_linha = row
	ll_chave_legado = Long(data)
	If wf_verifica_item(ll_chave_legado, ref lvs_descricao, ref lvs_usuario) then 
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Item j$$HEX1$$e100$$ENDHEX$$ cadastro - Verifique: "+String(data)+".")
		Return 1
	else
		dw_2.Object.cd_empresa				[ll_linha] = il_Empresa_Sap
		dw_2.Object.cd_tabela					[ll_linha] = is_tp_tabela
		dw_2.Object.dh_inclusao					[ll_linha] = gf_GetServerDate()
		dw_2.Object.nr_matricula_inclusao    [ll_linha] = gvo_Aplicacao.ivo_seguranca.nr_matricula
		dw_2.Object.nm_usuario					[ll_linha] = lvs_usuario
		dw_2.Object.id_situacao					[ll_linha] = 'I'
		dw_2.Modify('cd_chave_sap'+".TabSequence=20")
		dw_2.SetColumn("cd_chave_sap")
		dw_2.SetFocus()
	End If
End If			
end event

event dw_2::ue_predeleterow;call super::ue_predeleterow;String 	ls_Id_Situacao
Long  		ll_Linha
String 	ls_cd_chave_legado
String		ls_cd_chave_sap		
String		ls_matricula		
Datetime	ldt_data	

If AncestorReturnValue then 
	ll_Linha = this.getrow()
  	ls_cd_chave_legado 	= dw_2.Object.cd_chave_legado 			[ll_Linha]
	ls_cd_chave_sap		= dw_2.Object.cd_chave_sap				[ll_Linha]
	ls_matricula				= dw_2.Object.nr_matricula_inclusao 	[ll_Linha]
	ldt_data					= dw_2.Object.dh_inclusao 					[ll_Linha]
				
	Delete from  integracao_sap where cd_empresa = :il_Empresa_Sap and cd_tabela = :is_tp_tabela and
				                   cd_chave_legado = :ls_cd_chave_legado  using ivtr_Mult;
			
	If ivtr_Mult.SQLCode = -1 Then
			ivtr_Mult.of_msgdberror( "Erro na Exclus$$HEX1$$e300$$ENDHEX$$o item no banco de dados Oracle")
			ivtr_Mult.of_RollBack( )
		else
			ivtr_Mult.of_commit()
	End If		
End If

Return AncestorReturnValue
end event

event dw_2::ue_addrow;call super::ue_addrow;This.Of_Setrowselection( )

This.Setcolumn('cd_chave_legado')
This.Setfocus() 

Return AncestorReturnValue
end event

