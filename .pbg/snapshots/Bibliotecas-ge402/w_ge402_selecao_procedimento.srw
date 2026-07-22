HA$PBExportHeader$w_ge402_selecao_procedimento.srw
forward
global type w_ge402_selecao_procedimento from dc_w_selecao_generica
end type
end forward

global type w_ge402_selecao_procedimento from dc_w_selecao_generica
integer height = 1684
string title = "GE402 - Sele$$HEX2$$e700e300$$ENDHEX$$o Procedimento Sistema"
end type
global w_ge402_selecao_procedimento w_ge402_selecao_procedimento

forward prototypes
public subroutine wf_insere_padrao ()
end prototypes

public subroutine wf_insere_padrao ();DataWindowChild	ldwc_Child

/*Grupo*/
ldwc_Child  = dw_1.of_InsertRow_DDDW( "cd_sistema" )			

ldwc_Child.SetItem(1, "cd_sistema", ""	)
ldwc_Child.SetItem(1, "nm_sistema", "TODOS")
//ldwc_Child.SetItem(1, "id_loja", "S")
ldwc_Child.SetItem(1, "id_controle_acesso", "S")

ldwc_Child.SetFilter("id_controle_acesso='S'")
ldwc_Child.Filter()

dw_1.Object.cd_sistema[1] = ""
end subroutine

on w_ge402_selecao_procedimento.create
call super::create
end on

on w_ge402_selecao_procedimento.destroy
call super::destroy
end on

event ue_postopen;call super::ue_postopen;String lvs_Sistema
String lvs_Filtro

wf_insere_padrao()

lvs_Filtro 	= Mid(Message.StringParm, 1, Pos(Message.StringParm, ";") - 1)
lvs_Sistema	= Mid(Message.StringParm, Pos(Message.StringParm, ";") + 1)

If lvs_Sistema <> "" Then
	dw_1.Object.cd_sistema [1] = lvs_Sistema
End If

If lvs_Filtro <> "" Then
	dw_1.Object.de_filtro [1] = lvs_Filtro
	dw_2.Event ue_Retrieve()
End If
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge402_selecao_procedimento
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge402_selecao_procedimento
integer y = 268
integer width = 2432
integer height = 1152
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge402_selecao_procedimento
integer width = 2446
integer height = 252
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge402_selecao_procedimento
integer width = 2391
integer height = 152
string dataobject = "dw_ge402_selecao"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge402_selecao_procedimento
integer y = 340
integer width = 2382
integer height = 1052
string dataobject = "dw_ge402_lista_procedimento"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Pesquisa
String lvs_Sistema
String lvs_Situacao

dw_1.AcceptText( )
lvs_Pesquisa	= dw_1.Object.de_filtro		[1]
lvs_Sistema		= dw_1.Object.cd_sistema	[1]
lvs_Situacao		= dw_1.Object.id_situacao	[1]

If Trim(lvs_Pesquisa)<>"" Then
	dw_2.of_Appendwhere( "((p.de_procedimento like '%"+Upper(lvs_Pesquisa)+"%') or (p.cd_procedimento like '%"+Upper(lvs_Pesquisa)+"%') or (p.cd_library like '%"+Upper(lvs_Pesquisa)+"%'))" )
End If

If lvs_Sistema <> "" Then
	dw_2.of_Appendwhere( "exists (select 1 from procedimento_sistema ps1 where ps1.cd_procedimento = p.cd_procedimento and ps1.cd_sistema = '"+lvs_Sistema+"')" )
End If

If lvs_Situacao <> "T" Then
	dw_2.of_Appendwhere( "coalesce(p.id_situacao,'A')='"+lvs_Situacao+"'" )
End If

Return AncestorReturnValue
end event

event dw_2::constructor;call super::constructor;This.Of_Setrowselection( "", 'if(id_situacao="I", rgb(255,0,0),rgb(0,0,0))')
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge402_selecao_procedimento
integer y = 1456
end type

event cb_selecionar::clicked;call super::clicked;String lvs_Codigo

If dw_2.GetRow( ) > 0 Then
	lvs_Codigo = dw_2.Object.cd_procedimento [ dw_2.GetRow( ) ]
	
	CloseWithReturn(Parent, lvs_Codigo)
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Selecione um tipo de informa$$HEX2$$e700e300$$ENDHEX$$o.")
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge402_selecao_procedimento
integer y = 1456
end type

event cb_cancelar::clicked;call super::clicked;CloseWithReturn(Parent, "")
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge402_selecao_procedimento
integer y = 1456
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge402_selecao_procedimento
integer y = 1456
end type

