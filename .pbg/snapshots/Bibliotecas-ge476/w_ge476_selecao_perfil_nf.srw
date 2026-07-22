HA$PBExportHeader$w_ge476_selecao_perfil_nf.srw
forward
global type w_ge476_selecao_perfil_nf from dc_w_selecao_generica
end type
end forward

global type w_ge476_selecao_perfil_nf from dc_w_selecao_generica
integer width = 2345
string title = "GE476 - Sele$$HEX2$$e700e300$$ENDHEX$$o Tipo Nota Diversa"
end type
global w_ge476_selecao_perfil_nf w_ge476_selecao_perfil_nf

forward prototypes
public subroutine wf_insere_padrao ()
end prototypes

public subroutine wf_insere_padrao ();DatawindowChild ldwc_1

If dw_1.getChild("cd_uf", ldwc_1) > 0 Then
	ldwc_1.InsertRow(1)
	ldwc_1.SetItem(1, "cd_unidade_federacao", "")
	ldwc_1.SetItem(1, "nm_unidade_federacao", "TODOS")
End If
end subroutine

on w_ge476_selecao_perfil_nf.create
call super::create
end on

on w_ge476_selecao_perfil_nf.destroy
call super::destroy
end on

event ue_postopen;call super::ue_postopen;String lvs_Parametro

lvs_Parametro = Message.StringParm

If lvs_Parametro <> "" Then
	dw_1.Object.De_Pesquisa [1] = lvs_Parametro
	dw_2.Post Event ue_Retrieve()
End If

wf_insere_padrao()

ivb_Pesquisa_Direta = True
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge476_selecao_perfil_nf
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge476_selecao_perfil_nf
integer y = 352
integer width = 2263
integer height = 916
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge476_selecao_perfil_nf
integer width = 2021
integer height = 328
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge476_selecao_perfil_nf
integer width = 1938
integer height = 228
string dataobject = "dw_ge476_selecao"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge476_selecao_perfil_nf
integer y = 424
integer width = 2181
integer height = 816
string dataobject = "dw_ge476_lista"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Pesquisa
String lvs_UF
String lvs_Vigente

dw_1.Accepttext( )

lvs_Pesquisa= dw_1.Object.de_pesquisa	[1]
lvs_UF		= dw_1.Object.cd_uf			[1]
lvs_Vigente	= dw_1.Object.id_vigente	[1]

If Not IsNull(lvs_Pesquisa) and Trim(lvs_Pesquisa)<>'' Then
	This.Of_AppendWhere("p.de_perfil_nf like '%"+lvs_Pesquisa+"%' "+IIF(IsNumber(lvs_Pesquisa), "or cast(p.cd_perfil_nf as varchar)='"+String(lvs_Pesquisa),""))
End If

If Not IsNull(lvs_UF) and Trim(lvs_UF)<>'' Then
	This.Of_AppendWhere("p.cd_unidade_federacao = '"+lvs_UF+"'")
End If

If lvs_Vigente = "S" Then
	This.Of_AppendWhere("p.dh_inicio <= '"+String(Today(), 'YYYY.MM.DD')+"' and (p.dh_termino is null or p.dh_termino >= '"+String(Today(), 'YYYY.MM.DD')+"')")
End If

Return AncestorReturnValue
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge476_selecao_perfil_nf
integer x = 1541
end type

event cb_selecionar::clicked;call super::clicked;Long lvl_Perfil_NF
Long lvl_Linha


lvl_Linha = dw_2.GetRow()
If lvl_Linha > 0 Then
	lvl_Perfil_NF = dw_2.Object.cd_perfil_nf [lvl_Linha]

	CloseWithReturn(Parent, lvl_Perfil_NF)
Else
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Selecione um perfil para continuar.')
	Return -1
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge476_selecao_perfil_nf
integer x = 1929
end type

event cb_cancelar::clicked;call super::clicked;Long lvl_Null

Setnull(lvl_Null)

CloseWithReturn(Parent, lvl_Null)
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge476_selecao_perfil_nf
integer x = 1097
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge476_selecao_perfil_nf
integer width = 1056
integer height = 132
end type

