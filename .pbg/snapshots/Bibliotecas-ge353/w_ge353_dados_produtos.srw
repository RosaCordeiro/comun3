HA$PBExportHeader$w_ge353_dados_produtos.srw
forward
global type w_ge353_dados_produtos from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge353_dados_produtos from dc_w_selecao_lista_relatorio
integer width = 4123
integer height = 2036
string title = "GE353 - Lista de Produtos"
end type
global w_ge353_dados_produtos w_ge353_dados_produtos

type variables
uo_cest 								ivo_cest 			//GE021
uo_ge220_tributacao_produto 	ivo_tributacao 	//GE220
//uo_mensagem_fiscal			 	ivo_msg_fiscal 	//FI034
end variables

forward prototypes
public subroutine wf_insere_padrao ()
public subroutine wf_insere_padrao_tipo_icms ()
end prototypes

public subroutine wf_insere_padrao ();DataWindowChild	ldwc_Child

/* Ordena para aparecer primeiro os estados que a empresa tem filial*/
If dw_1.GetChild("cd_uf", ldwc_Child) > 0 Then
	ldwc_Child.SetSort("nr_ordem asc, nm_unidade_federacao asc")
	ldwc_Child.Sort()
End If


/*Grupo*/
ldwc_Child  = dw_1.of_InsertRow_DDDW("cd_grupo" )			

ldwc_Child.SetItem(1, "cd_grupo", "0"	)
ldwc_Child.SetItem(1, "de_grupo", "TODOS")

dw_1.Object.cd_grupo[1] = "0"

/*Subgrupo*/
ldwc_Child  = dw_1.of_InsertRow_DDDW("cd_subgrupo" )			

ldwc_Child.SetItem(1, "cd_subgrupo", "0"	)
ldwc_Child.SetItem(1, "de_subgrupo", "TODOS")
ldwc_Child.SetItem(1, "cd_grupo", "0")
ldwc_Child.Setfilter(" ( cd_grupo = '0' )")
ldwc_Child.Filter()
dw_1.Object.cd_subgrupo[1] = "0"

/* Tipo ICMS */
dw_1.GetChild("cd_tipo_icms", ldwc_Child)
ldwc_Child.SetTrans(SQLCa)
ldwc_Child.SetTransObject(SQLCa)
ldwc_Child.Retrieve('SC')

wf_insere_padrao_tipo_icms()

/* Tributa$$HEX2$$e700e300$$ENDHEX$$o ICMS */
ldwc_Child  = dw_1.of_InsertRow_DDDW("cd_tributacao_icms" )	
ldwc_Child.SetItem(1, "cd_tributacao_icms", ""	)
ldwc_Child.SetItem(1, "de_tributacao_icms", "TODOS")

dw_1.Object.cd_tributacao_icms[1] = ""

/*Lei Gen$$HEX1$$e900$$ENDHEX$$rico*/
ldwc_Child  = dw_1.of_InsertRow_DDDW("id_lei_generico" )			

ldwc_Child.SetItem(1, "id_lei_generico", ""	)
ldwc_Child.SetItem(1, "de_lei_generico", "TODOS")

dw_1.Object.id_lei_generico[1] = ""

/*Lista Pis/Cofins*/
ldwc_Child  = dw_1.of_InsertRow_DDDW("id_lista_pis_cofins" )			

ldwc_Child.SetItem(1, "id_lista_pis_cofins", ""	)
ldwc_Child.SetItem(1, "de_lista_pis_cofins", "TODOS")

dw_1.Object.id_lista_pis_cofins[1] = ""
end subroutine

public subroutine wf_insere_padrao_tipo_icms ();DataWindowChild	ldwc_Child
ldwc_Child  = dw_1.of_InsertRow_DDDW("cd_tipo_icms" )			

ldwc_Child.SetItem(1, "cd_tipo_icms", 0	)
ldwc_Child.SetItem(1, "de_tipo_icms", "TODOS")
ldwc_Child.SetItem(1, "pc_icms", 0.00)
ldwc_Child.SetItem(1, "pc_fcp", 0.00)

dw_1.Object.cd_tipo_icms [1] = 0
end subroutine

on w_ge353_dados_produtos.create
call super::create
end on

on w_ge353_dados_produtos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_preopen;call super::ue_preopen;MaxWidth = 11000
Maxheight = 9999

ivo_cest 			= Create uo_cest
ivo_tributacao	= Create uo_ge220_tributacao_produto

end event

event ue_saveas;call super::ue_saveas;dw_2.Event ue_SaveAs()
end event

event ue_postopen;call super::ue_postopen;wf_insere_padrao()
end event

event close;call super::close;Destroy(ivo_cest)
Destroy(ivo_tributacao)

end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge353_dados_produtos
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge353_dados_produtos
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge353_dados_produtos
integer y = 568
integer width = 4023
integer height = 1216
integer weight = 700
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge353_dados_produtos
integer width = 4023
integer height = 536
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge353_dados_produtos
integer x = 59
integer width = 3982
integer height = 452
string dataobject = "dw_ge353_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;DataWindowChild ldw_Child

String lvs_Texto

Choose Case Dwo.Name
	Case 'cd_grupo' 
		If Data <> '1' Then This.Object.id_lei_generico [Row] = ''
	
		If This.GetChild("cd_subgrupo", ldw_Child) = 1 Then
			ldw_Child.SetFilter("( cd_grupo = '0' or  cd_grupo = '"+Data+"')")
			ldw_Child.Filter()
			This.Object.cd_subgrupo [Row] = '0'
		End If
	Case 'cd_uf'
		If This.GetChild("cd_tipo_icms", ldw_Child) = 1 Then
			ldw_Child.Retrieve(Data)
			wf_insere_padrao_tipo_icms()
		End If
	Case 'cd_tributacao_icms'
		This.Accepttext( )
		lvs_Texto =  This.Describe("Evaluate('LookUpDisplay(cd_tributacao_icms)',1)")
		This.Object.cd_tributacao_icms.ToolTip.Tip = lvs_Texto
		This.Object.cd_tributacao_icms.ToolTip.Enabled =  (Len(lvs_Texto) > 30)
	
	Case 'de_trib_prod' 
		If Data <> ivo_tributacao.de_tributacao_produto Then
			If Data <> '' Then
				Return 1
			Else
				ivo_tributacao.of_inicializa( )
				This.Object.cd_trib_prod	[Row] = ivo_tributacao.cd_tributacao_produto
				This.Object.de_trib_prod	[Row] = ivo_tributacao.de_tributacao_produto
			End If
		End If
End Choose

dw_2.Reset()
end event

event dw_1::ue_key;call super::ue_key;String lvs_Uf

If Key=KeyEnter! Then
	Choose Case This.GetColumnName()
			
		Case 'de_trib_prod'
			lvs_Uf = This.Object.cd_uf [1]
			ivo_tributacao.of_localiza_generica(This.GetText(),lvs_Uf)
			
			If ivo_tributacao.Localizado Then
				This.Object.cd_trib_prod [1] = ivo_tributacao.cd_tributacao_produto
				This.Object.de_trib_prod [1] = ivo_tributacao.de_tributacao_produto		
			Else
				ivo_tributacao.Of_inicializa( )
				
				This.Object.cd_trib_prod [1] = ivo_tributacao.cd_tributacao_produto
				This.Object.de_trib_prod [1] = ivo_tributacao.de_tributacao_produto	
			End If
			
	
	End Choose
End If
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Tributacao) Then
	This.Object.de_trib_prod [1] = ivo_Tributacao.de_tributacao_produto
End If


end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge353_dados_produtos
integer y = 628
integer width = 3954
integer height = 1124
string dataobject = "dw_ge353_lista"
boolean hscrollbar = true
boolean hsplitscroll = true
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_UF
String lvs_Lista
String lvs_Grupo
String lvs_SubGrupo
String lvs_Lei_G
String lvs_Trib
String lvs_Situacao
String lvs_Diverg
String lvs_ABC
String lvs_FPB
String lvs_Sem_PMC
String lvs_Red_BC_ST
String lvs_Gratis_FPB

Long lvl_NCM_Ini
Long lvl_NCM_Fin
Long lvl_Tipo
Long lvl_Trib_Prod
Long lvl_Msg_Fiscal

dw_1.AcceptText()

lvs_UF 				= dw_1.Object.Cd_UF					[1]
lvl_NCM_Ini		= dw_1.Object.nr_ncm_inicio			[1]
lvl_NCM_Fin		= dw_1.Object.nr_ncm_fim				[1]
lvs_Lista			= dw_1.Object.id_lista_pis_cofins		[1]
lvs_Grupo			= dw_1.Object.cd_grupo					[1]
lvs_SubGrupo		= dw_1.Object.cd_subgrupo			[1]
lvs_Lei_G			= dw_1.Object.id_lei_generico			[1]
lvs_Situacao		= dw_1.Object.id_situacao				[1]
lvs_Trib				= dw_1.Object.cd_tributacao_icms	[1]
lvl_Tipo				= dw_1.Object.cd_tipo_icms			[1]
lvs_Diverg			= dw_1.Object.id_divergencia_ncm	[1]
lvs_ABC				= dw_1.Object.id_abcfarma				[1]
lvs_FPB				= dw_1.Object.id_fpb						[1]

lvl_Trib_Prod		= dw_1.Object.cd_trib_prod				[1]
lvs_Sem_PMC		= dw_1.Object.id_sem_pmc				[1]
lvs_Red_BC_ST	= dw_1.Object.id_red_base_st			[1]
lvs_Gratis_FPB	= dw_1.Object.id_gratis_fpb			[1]
lvl_Msg_Fiscal		= dw_1.Object.cd_mensagem_fiscal	[1]

If lvs_UF = "" or IsNull(lvs_UF) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Deve ser informado a UF para recupera$$HEX2$$e700e300$$ENDHEX$$o dos dados.", Exclamation!)
	Return -1
End If



If (Not IsNull(lvl_Trib_Prod)) Then
	This.of_appendwhere("u.cd_tributacao_produto = "+String(lvl_Trib_Prod))
End If

If lvs_Situacao <> 'T' Then
	This.of_appendwhere("g.id_situacao = '"+lvs_Situacao+"'")
End If

If lvs_ABC <> 'T' Then
	This.of_appendwhere("coalesce(g.id_caderno_abcfarma,'N') = '"+lvs_ABC+"'")
End If

If lvs_FPB <> 'T' Then
	This.of_appendwhere("coalesce(g.id_farmacia_popular,'N') = '"+lvs_FPB+"'")
End If


If lvs_Sem_PMC = 'S' Then
	This.of_appendwhere("coalesce(u.vl_preco_venda_maximo,0.00)=0.00")
End If

If lvs_Lista <> '' Then
	This.of_appendwhere("g.id_situacao_pis_cofins = '"+lvs_Lista+"'")
End If

If lvs_Lei_G <> '' Then
	This.of_appendwhere("g.id_lei_generico = '"+lvs_Lei_G+"'")
End If

If lvs_Trib <> '' Then
	This.of_appendwhere("u.cd_tributacao_icms = '"+lvs_Trib+"'")
End If

If lvl_Tipo > 0 Then
	This.of_appendwhere("u.cd_tipo_icms = "+String(lvl_Tipo))
End If

If ((Not IsNull(lvl_NCM_Ini)) and (lvl_NCM_Ini > 1)) Then
	This.of_appendwhere("g.nr_classificacao_fiscal >= "+String(lvl_NCM_Ini))
End If

If ((Not IsNull(lvl_NCM_Fin)) and (lvl_NCM_Fin < 99999999)) Then
	This.of_appendwhere("g.nr_classificacao_fiscal <= "+String(lvl_NCM_Fin))
End If

If lvs_Grupo<>'0' Then
	This.of_appendwhere("v.cd_grupo='"+lvs_Grupo+"'")
End If

If lvs_SubGrupo<>'0' Then
	This.of_appendwhere("v.cd_subgrupo='"+lvs_SubGrupo+"'")
End If

If lvs_Gratis_FPB = 'S' Then
	This.of_appendwhere("coalesce(g.id_gratis_farm_popular,'N')='S'")
End If

If lvs_Red_BC_ST = 'S' Then
	This.of_appendwhere("coalesce(u.pc_reducao_base_st,0) > 0")
ElseIf lvs_Red_BC_ST = 'N' Then
	This.of_appendwhere("coalesce(u.pc_reducao_base_st,0) = 0")
End If

If lvs_Diverg = 'S' Then
	This.of_appendwhere(" ( (u.cd_tipo_icms<>nse.cd_tipo_icms) or "+ &
								 	"(u.cd_tributacao_icms<>nse.cd_tributacao_icms) or "+ &
								 	"(coalesce(u.cd_mensagem_fiscal,0)<>coalesce(nse.cd_mensagem_fiscal,0)) or "+ &
									"(u.cd_tributacao_produto<>nse.cd_tributacao_produto))")
End If

Return 1
end event

event dw_2::ue_recuperar;// OverRide

String lvs_UF

dw_1.AcceptText()

lvs_UF = dw_1.Object.Cd_UF[1]

Return This.Retrieve(lvs_UF)
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;This.ivm_Menu.mf_SalvarComo(pl_Linhas > 0)

Return pl_Linhas
end event

event dw_2::getfocus;call super::getfocus;If This.RowCount() > 0 Then
	This.ivm_Menu.mf_SalvarComo(True)
End If
end event

event dw_2::constructor;call super::constructor;String lvs_Coluna[], &
       lvs_Nome[]
		 

lvs_Coluna = {"de_produto","de_grupo","de_apresentacao_estoque","de_apresentacao_venda","nm_fornecedor",&	
					"id_superfluo","demanda","controlado","liberado","situacao"}

lvs_Nome = {"Produto", "Grupo", "Apresenta$$HEX2$$e700e300$$ENDHEX$$o Estoque", "Apresenta$$HEX2$$e700e300$$ENDHEX$$o Venda", &
				"Fornecedor", "Superfluo","Demanda","Controlado","Liberado","Situa$$HEX2$$e700e300$$ENDHEX$$o" }

This.of_SetSort(lvs_Coluna, lvs_Nome)
This.of_SetFilter(lvs_Coluna, lvs_Nome)
end event

event dw_2::ue_reset;call super::ue_reset;This.ivm_Menu.mf_SalvarComo(False)
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge353_dados_produtos
integer x = 4119
integer y = 36
integer width = 233
integer height = 240
end type

