HA$PBExportHeader$w_ge452_selecao_precificacao.srw
forward
global type w_ge452_selecao_precificacao from dc_w_selecao_generica
end type
end forward

global type w_ge452_selecao_precificacao from dc_w_selecao_generica
integer width = 3657
string title = "GE452 - Sele$$HEX2$$e700e300$$ENDHEX$$o Precifica$$HEX2$$e700e300$$ENDHEX$$o"
end type
global w_ge452_selecao_precificacao w_ge452_selecao_precificacao

type variables
uo_subcategoria ivo_subcategoria
end variables

forward prototypes
public subroutine wf_insere_padrao ()
end prototypes

public subroutine wf_insere_padrao ();DataWindowChild	ldwc_Child
Long lvl_Null
SetNull( lvl_Null )

//Rede Filial
ldwc_Child  = dw_1.of_InsertRow_DDDW("id_rede_filial" )			
ldwc_Child.SetItem(1, "id_rede_filial", ""	)
ldwc_Child.SetItem(1, "nm_rede_filial", "TODAS")
ldwc_Child.SetItem(1, "id_precificacao", "S")

If dw_1.GetChild("id_rede_filial", ldwc_Child) > 0 Then
	ldwc_Child.Setfilter(" ( id_precificacao = 'S' )")
	ldwc_Child.Filter()
End If

//Tipo Precifica$$HEX2$$e700e300$$ENDHEX$$o
ldwc_Child  = dw_1.of_InsertRow_DDDW("cd_tipo_precificacao" )			
ldwc_Child.SetItem(1, "cd_tipo_precificacao", lvl_Null	)
ldwc_Child.SetItem(1, "de_tipo_precificacao", "TODAS")

If dw_1.GetChild("cd_tipo_precificacao", ldwc_Child) > 0 Then
	ldwc_Child.Setfilter("IsNull(cd_tipo_precificacao) or ( cd_tipo_precificacao > 0 )")
	ldwc_Child.Filter()
End If

//UF
ldwc_Child  = dw_1.of_InsertRow_DDDW("cd_uf" )			
ldwc_Child.SetItem(1, "cd_unidade_federacao", ""	)
ldwc_Child.SetItem(1, "nm_unidade_federacao", "TODAS")
end subroutine

on w_ge452_selecao_precificacao.create
call super::create
end on

on w_ge452_selecao_precificacao.destroy
call super::destroy
end on

event ue_preopen;call super::ue_preopen;ivo_subcategoria = Create uo_subcategoria
end event

event close;call super::close;Destroy(ivo_subcategoria)
end event

event ue_postopen;call super::ue_postopen;String lvs_Parametro
String lvs_Tipo_Precificacao
String lvs_Rede_Filial
String lvs_UF
String lvs_Subcategoria
String lvs_Situacao

wf_insere_padrao()

lvs_Parametro = Message.StringParm

//Tipo Precifica$$HEX2$$e700e300$$ENDHEX$$o
lvs_Tipo_Precificacao	= Mid(lvs_Parametro, 1, Pos(lvs_Parametro, ";")-1)
lvs_Parametro			= Mid(lvs_Parametro, Pos(lvs_Parametro, ";") + 1)
If lvs_Tipo_Precificacao <> "" Then dw_1.Object.cd_tipo_precificacao [1] = Long(lvs_Tipo_Precificacao)

//UF
lvs_UF			= Mid(lvs_Parametro, 1, Pos(lvs_Parametro, ";")-1)
lvs_Parametro	= Mid(lvs_Parametro, Pos(lvs_Parametro, ";") + 1)
If lvs_UF <> "" Then dw_1.Object.cd_uf [1] = lvs_UF

//Rede Filial
lvs_Rede_Filial	= Mid(lvs_Parametro, 1, Pos(lvs_Parametro, ";")-1)
lvs_Parametro	= Mid(lvs_Parametro, Pos(lvs_Parametro, ";") + 1)
If lvs_Rede_Filial <> "" Then dw_1.Object.id_rede_filial [1] = lvs_Rede_Filial

//Subcategoria
lvs_Subcategoria	= Mid(lvs_Parametro, 1, Pos(lvs_Parametro, ";")-1)
lvs_Parametro 		= Mid(lvs_Parametro, Pos(lvs_Parametro, ";") + 1)
If lvs_Subcategoria <> "" Then 
	ivo_subcategoria.of_localiza_codigo( lvs_Subcategoria )
	dw_1.Object.cd_subcategoria [1] = ivo_subcategoria.cd_subcategoria
	dw_1.Object.de_subcategoria [1] = ivo_subcategoria.de_subcategoria
End If

lvs_Situacao		= Mid(lvs_Parametro, 1)
If lvs_Situacao <> "" Then 
	dw_1.Object.id_situacao [1] = lvs_Situacao
	dw_1.Object.id_situacao.TabSequence = 0
End If

dw_2.Event ue_Retrieve()
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge452_selecao_precificacao
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge452_selecao_precificacao
integer y = 380
integer width = 3589
integer height = 908
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge452_selecao_precificacao
integer width = 3584
integer height = 352
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge452_selecao_precificacao
integer width = 3525
integer height = 252
string dataobject = "dw_ge452_selecao"
end type

event dw_1::ue_key;call super::ue_key;If Key=KeyEnter! Then
	Choose Case This.GetColumnName()
		Case 'de_subcategoria'
			ivo_subcategoria.Of_inicializa( )
			ivo_subcategoria.of_localiza( This.GetText() )
			
			This.Object.cd_subcategoria	[1] = ivo_subcategoria.cd_subcategoria
			This.Object.de_subcategoria	[1] = ivo_subcategoria.de_subcategoria
	End Choose
End If
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_subcategoria) Then
	This.Object.de_subcategoria [1] = ivo_subcategoria.de_subcategoria
End If
end event

event dw_1::itemchanged;call super::itemchanged;DataWindowChild ldw_Child

Choose Case Dwo.Name		
	Case 'de_subcategoria'
		If Data <> ivo_subcategoria.de_subcategoria Then
			If Data <> '' Then
				Return 1
			Else
				ivo_subcategoria.of_inicializa( )
				This.Object.cd_subcategoria[Row] = ivo_subcategoria.cd_subcategoria
				This.Object.de_subcategoria[Row] = ivo_subcategoria.de_subcategoria
			End If
		End If

End Choose
end event

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge452_selecao_precificacao
integer y = 452
integer width = 3506
integer height = 808
string dataobject = "dw_ge452_lista"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;Long lvl_Tipo

String lvs_Rede
String lvs_UF
String lvs_Subcategoria
String lvs_Situacao

Datetime lvdh_Inicio
Datetime lvdh_Fim

dw_1.Accepttext( )
 
lvl_Tipo				= dw_1.Object.cd_tipo_precificacao	[1]
lvs_Rede				= dw_1.Object.id_rede_filial			[1]
lvs_UF				= dw_1.Object.cd_uf						[1]
lvs_Subcategoria	= dw_1.Object.cd_subcategoria		[1]
lvs_Situacao			= dw_1.Object.id_situacao				[1]
lvdh_Inicio			= dw_1.Object.dh_inicio					[1]
lvdh_Fim				= dw_1.Object.dh_fim					[1]
 
If Not IsNull(lvl_Tipo) then
	This.Of_appendwhere( "p.cd_tipo_precificacao = "+String(lvl_Tipo) )
End If

If Not IsNull(lvs_Rede) and lvs_Rede <> "" then
	This.Of_appendwhere( "p.id_rede_filial = '"+lvs_Rede + "'")
End If

If Not IsNull(lvs_UF) and lvs_UF <> "" then
	This.Of_appendwhere( "p.cd_uf = '"+lvs_UF+ "'")
End If

If Not IsNull(lvs_Situacao) and lvs_Situacao <> "" then
	This.Of_appendwhere( "p.id_situacao = '"+lvs_Situacao+ "'")
End If

If Not IsNull(lvs_Subcategoria) and lvs_Subcategoria <> "" then
	This.Of_appendwhere( "p.cd_subcategoria = '"+lvs_Subcategoria+ "'")
End If

If Not IsNull(lvdh_Inicio) and lvdh_Inicio > Datetime("2018/01/01") then
	This.Of_appendwhere( "p.dh_inclusao >= '"+String(lvdh_Inicio, "YYYY.MM.DD")+ "'")
End If

If Not IsNull(lvdh_Fim) and lvdh_Fim > Datetime("2018/01/01") then
	This.Of_appendwhere( "p.dh_inclusao <= '"+String(lvdh_Fim, "YYYY.MM.DD")+ "'")
End If

Return AncestorReturnValue
end event

event dw_2::doubleclicked;call super::doubleclicked;cb_selecionar.event clicked( )
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge452_selecao_precificacao
integer x = 2857
end type

event cb_selecionar::clicked;call super::clicked;Long lvl_Precificacao

If dw_2.GetRow() > 0 Then
	lvl_Precificacao = dw_2.Object.nr_precificacao [dw_2.GetRow()]
	
	CloseWithReturn(Parent, String(lvl_Precificacao))
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um registro para confirmar.")
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge452_selecao_precificacao
integer x = 3246
end type

event cb_cancelar::clicked;call super::clicked;CloseWithReturn(Parent, "")
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge452_selecao_precificacao
integer x = 2414
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge452_selecao_precificacao
integer width = 2272
integer height = 120
end type

