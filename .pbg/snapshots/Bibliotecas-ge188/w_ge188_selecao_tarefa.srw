HA$PBExportHeader$w_ge188_selecao_tarefa.srw
forward
global type w_ge188_selecao_tarefa from dc_w_selecao_generica
end type
end forward

global type w_ge188_selecao_tarefa from dc_w_selecao_generica
integer width = 2651
string title = "GE188 - Sele$$HEX2$$e700e300$$ENDHEX$$o Tarefa"
end type
global w_ge188_selecao_tarefa w_ge188_selecao_tarefa

type variables
uo_sistema ivo_sistema
end variables

on w_ge188_selecao_tarefa.create
call super::create
end on

on w_ge188_selecao_tarefa.destroy
call super::destroy
end on

event ue_postopen;call super::ue_postopen;String lvs_Filtro

lvs_Filtro = Message.StringParm
dw_1.Object.de_tarefa [1] = lvs_Filtro

If (Not IsNull(lvs_Filtro)) and (lvs_Filtro <> '') Then
	dw_2.Event ue_Retrieve()
End If
end event

event ue_preopen;call super::ue_preopen;ivo_sistema = Create uo_sistema
end event

event close;call super::close;Destroy(ivo_sistema)
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge188_selecao_tarefa
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge188_selecao_tarefa
integer y = 288
integer width = 2574
integer height = 996
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge188_selecao_tarefa
integer width = 2432
integer height = 264
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge188_selecao_tarefa
integer width = 2382
integer height = 164
string dataobject = "dw_ge188_selecao_tarefa"
end type

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.name
	Case "nm_sistema"
		If Trim(Data) <> "" Then
			If Data <> ivo_sistema.Descricao Then
				Return 1
			End If	
		Else	
			ivo_sistema.Of_inicializa( )
			
			This.Object.Cd_Sistema	[1] = ivo_sistema.Codigo
			This.Object.Nm_Sistema	[1] = ivo_sistema.Descricao
		End If
End Choose
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	This.AcceptText( )
	Choose Case This.GetColumnName()
		Case 'nm_sistema'
			ivo_sistema.Of_Localiza(This.GetText())
			
			This.Object.cd_sistema	[1] = ivo_sistema.Codigo
			This.Object.nm_sistema	[1] = ivo_sistema.Descricao
	End Choose
End If
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_sistema) Then
	This.Object.nm_sistema [1] = ivo_sistema.Descricao
End If
end event

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge188_selecao_tarefa
integer x = 64
integer y = 360
integer width = 2514
integer height = 896
string dataobject = "dw_ge188_lista_selecao_tarefa"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Descricao
String lvs_Situacao
String lvs_Sistema

dw_1.AcceptText( )

lvs_Descricao	= dw_1.Object.de_tarefa	[1]
lvs_Situacao		= dw_1.Object.id_situacao	[1]
lvs_Sistema		= dw_1.Object.cd_sistema	[1]

If (Not IsNull(lvs_Descricao)) and (Trim(lvs_Descricao)<>'') Then
	This.Of_AppendWhere("upper(de_tarefa) like '%"+lvs_Descricao+"%'")
End If

If (lvs_Situacao<>'T') Then
	This.Of_AppendWhere("id_situacao = '"+lvs_Situacao+"'")
End If

If (Not IsNull(lvs_Sistema)) and (Trim(lvs_Sistema)<>'') Then
	This.Of_AppendWhere("cd_sistema = '"+lvs_Sistema+"'")
End If

Return AncestorReturnValue
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge188_selecao_tarefa
integer x = 1851
end type

event cb_selecionar::clicked;call super::clicked;Long lvl_Linha
Long lvl_Tarefa

lvl_Linha = dw_2.GetRow()
If lvl_Linha > 0 Then
	lvl_Tarefa = dw_2.Object.cd_tarefa [lvl_Linha]
	
	CloseWithReturn(Parent,String(lvl_Tarefa))
Else
	cb_cancelar.Event Clicked( )
End If

end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge188_selecao_tarefa
integer x = 2240
end type

event cb_cancelar::clicked;call super::clicked;CloseWithReturn(Parent,'')
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge188_selecao_tarefa
integer x = 1408
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge188_selecao_tarefa
end type

