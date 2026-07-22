HA$PBExportHeader$w_ge451_selecao_margem_preco.srw
forward
global type w_ge451_selecao_margem_preco from dc_w_selecao_generica
end type
end forward

global type w_ge451_selecao_margem_preco from dc_w_selecao_generica
integer width = 3200
string title = "GE451 - Sele$$HEX2$$e700e300$$ENDHEX$$o Margem de Resulta de Pre$$HEX1$$e700$$ENDHEX$$o"
end type
global w_ge451_selecao_margem_preco w_ge451_selecao_margem_preco

forward prototypes
public subroutine wf_insere_padrao ()
end prototypes

public subroutine wf_insere_padrao ();DataWindowChild	ldwc_Child

Long lvl_Null

SetNull( lvl_Null )

/* Lei Gen$$HEX1$$e900$$ENDHEX$$rico */
ldwc_Child  = dw_1.of_InsertRow_DDDW("id_lei_generico" )			
ldwc_Child.SetItem(1, "id_lei_generico", ""	)
ldwc_Child.SetItem(1, "de_lei_generico", "TODOS")
dw_1.Object.id_lei_generico[1] = ""

/* Rede Filial */
ldwc_Child  = dw_1.of_InsertRow_DDDW("id_rede_filial" )			
ldwc_Child.SetItem(1, "vl_parametro", ""	)
ldwc_Child.SetItem(1, "rede", "TODAS")
dw_1.Object.id_rede_filial[1] = ""

/* Tipo Margem */
ldwc_Child  = dw_1.of_InsertRow_DDDW("cd_tipo_margem" )			
ldwc_Child.SetItem(1, "cd_tipo_margem", lvl_Null	)
ldwc_Child.SetItem(1, "de_tipo_margem", "TODOS")
dw_1.Object.cd_tipo_margem [1] = lvl_Null

/* Tier */
ldwc_Child  = dw_1.of_InsertRow_DDDW("cd_tier" )			
ldwc_Child.SetItem(1, "cd_tier", lvl_Null	)
ldwc_Child.SetItem(1, "de_tier", "TODOS")
dw_1.Object.cd_tier [1] = lvl_Null

/* Classifica$$HEX2$$e700e300$$ENDHEX$$o */
ldwc_Child  = dw_1.of_InsertRow_DDDW("cd_classificacao" )			
ldwc_Child.SetItem(1, "cd_classificacao", lvl_Null	)
ldwc_Child.SetItem(1, "de_classificacao", "TODAS")
dw_1.Object.cd_tier [1] = lvl_Null
end subroutine

on w_ge451_selecao_margem_preco.create
call super::create
end on

on w_ge451_selecao_margem_preco.destroy
call super::destroy
end on

event open;call super::open;wf_insere_padrao()
end event

event ue_postopen;call super::ue_postopen;String lvs_Parametro
String lvs_Tipo_Margem
String lvs_Rede_Filial
String lvs_Lei_Generico
String lvs_Tier
String lvs_Classificacao

lvs_Parametro = Message.StringParm

//Tipo Margem
lvs_Tipo_Margem = Mid(lvs_Parametro, 1, Pos(lvs_Parametro, ";")-1)
lvs_Parametro = Mid(lvs_Parametro, Pos(lvs_Parametro, ";") + 1)
If lvs_Tipo_Margem <> "" Then dw_1.Object.cd_tipo_margem [1] = Long(lvs_Tipo_Margem)

//Rede Filial
lvs_Rede_Filial = Mid(lvs_Parametro, 1, Pos(lvs_Parametro, ";")-1)
lvs_Parametro = Mid(lvs_Parametro, Pos(lvs_Parametro, ";") + 1)
If lvs_Rede_Filial <> "" Then dw_1.Object.id_rede_filial [1] = lvs_Rede_Filial

//Lei Gen$$HEX1$$e900$$ENDHEX$$rico
lvs_Lei_Generico = Mid(lvs_Parametro, 1, Pos( lvs_Parametro, ";")-1)
lvs_Parametro = Mid(lvs_Parametro, Pos( lvs_Parametro, ";") + 1)
If lvs_Lei_Generico <> "" Then dw_1.Object.id_lei_generico [1] = lvs_Lei_Generico

//Tier
lvs_Tier = Mid(lvs_Parametro, 1, Pos(lvs_Parametro, ";")-1)
lvs_Parametro = Mid(lvs_Parametro, Pos(lvs_Parametro, ";") + 1)
If lvs_Tier <> "" Then dw_1.Object.cd_tier [1] = Long(lvs_Tier)

//Classifica$$HEX2$$e700e300$$ENDHEX$$o
lvs_Classificacao = Mid(lvs_Parametro, 1)
If lvs_Classificacao <> "" Then dw_1.Object.cd_classificacao [1] = Long(lvs_Classificacao)

dw_2.Event ue_Retrieve()
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge451_selecao_margem_preco
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge451_selecao_margem_preco
integer y = 372
integer width = 3118
integer height = 916
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge451_selecao_margem_preco
integer width = 3118
integer height = 344
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge451_selecao_margem_preco
integer width = 3035
integer height = 244
string dataobject = "dw_ge451_selecao"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge451_selecao_margem_preco
integer y = 444
integer width = 3035
integer height = 816
string dataobject = "dw_ge451_lista"
end type

event dw_2::doubleclicked;call super::doubleclicked;cb_selecionar.Post Event clicked( )
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;Long lvl_Tipo_Margem
String lvs_Rede_Filial
String lvs_Lei_Generico
Long lvl_Tier
Long lvl_Classificacao

dw_1.Accepttext( )

lvl_Tipo_Margem	= dw_1.Object.cd_tipo_margem	[1]
lvs_Rede_Filial		= dw_1.Object.id_rede_filial		[1]
lvs_Lei_Generico	= dw_1.Object.id_lei_generico		[1]
lvl_Tier				= dw_1.Object.cd_tier				[1]
lvl_Classificacao	= dw_1.Object.cd_classificacao	[1]

//Tipo Margem
If Not IsNull(lvl_Tipo_Margem) And (lvl_Tipo_Margem > 0) Then
	This.Of_Appendwhere( "m.cd_tipo_margem = "+String(lvl_Tipo_Margem) )
End If

//Rede Filial
If Not IsNull(lvs_Rede_Filial) And (lvs_Rede_Filial <> "") Then
	This.Of_Appendwhere( "m.id_rede_filial = '"+lvs_Rede_Filial+"'" )
End If

//Lei Gen$$HEX1$$e900$$ENDHEX$$rico
If Not IsNull(lvs_Lei_Generico) And (lvs_Lei_Generico <> "") Then
	This.Of_Appendwhere( "m.id_lei_generico = '"+lvs_Lei_Generico+"'" )
End If

//Tier
If Not IsNull(lvl_Tier) And (lvl_Tier > 0) Then
	This.Of_Appendwhere( "m.cd_tier_subcategoria = "+String(lvl_Tier) )
End If

//Classifica$$HEX2$$e700e300$$ENDHEX$$o
If Not IsNull(lvl_Classificacao) And (lvl_Classificacao > 0) Then
	This.Of_Appendwhere( "m.cd_classificacao_subcategoria = "+String(lvl_Classificacao) )
End If

Return AncestorReturnValue
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge451_selecao_margem_preco
integer x = 2391
integer y = 1312
end type

event cb_selecionar::clicked;call super::clicked;Long lvl_Margem

If dw_2.GetRow() > 0 Then
	lvl_Margem = dw_2.Object.nr_margem [dw_2.GetRow()]
	CloseWithReturn(Parent, String(lvl_Margem))
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma margem de resultado para retornar.")
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge451_selecao_margem_preco
integer x = 2779
integer y = 1312
end type

event cb_cancelar::clicked;call super::clicked;CloseWithReturn(Parent, "")
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge451_selecao_margem_preco
integer x = 1947
integer y = 1312
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge451_selecao_margem_preco
integer width = 1815
integer height = 108
end type

