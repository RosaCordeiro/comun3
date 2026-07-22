HA$PBExportHeader$w_ge022_selecao_categoria.srw
forward
global type w_ge022_selecao_categoria from dc_w_selecao_generica
end type
end forward

global type w_ge022_selecao_categoria from dc_w_selecao_generica
integer width = 3067
integer height = 1932
string title = "GE022 - Sele$$HEX2$$e700e300$$ENDHEX$$o Categoria"
end type
global w_ge022_selecao_categoria w_ge022_selecao_categoria

forward prototypes
public subroutine wf_insere_padrao ()
end prototypes

public subroutine wf_insere_padrao ();DataWindowChild	ldwc_Child

/* Grupo Produto */
ldwc_Child  = dw_1.of_InsertRow_DDDW("cd_grupo" )			
ldwc_Child.SetItem(1, "cd_grupo", "0")
ldwc_Child.SetItem(1, "de_grupo", "TODOS")
dw_1.Object.cd_grupo [1] = "0"

/* Subgrupo Produto */
ldwc_Child  = dw_1.of_InsertRow_DDDW("cd_subgrupo" )			
ldwc_Child.SetItem(1, "cd_grupo", "0")	
ldwc_Child.SetItem(1, "cd_subgrupo", "0")
ldwc_Child.SetItem(1, "de_subgrupo", "TODOS")
dw_1.Object.cd_subgrupo [1] = "0"
end subroutine

on w_ge022_selecao_categoria.create
call super::create
end on

on w_ge022_selecao_categoria.destroy
call super::destroy
end on

event ue_postopen;call super::ue_postopen;DataWindowChild ldwc_Child

String lvs_Parametro
String lvs_Pesquisa	= ''
String lvs_Grupo		= ''
String lvs_Subgrupo	= ''

wf_insere_padrao()

lvs_Parametro = Message.StringParm

If Pos(lvs_Parametro,';')>0 Then
	lvs_Pesquisa	= Mid(lvs_Parametro,1,Pos(lvs_Parametro,';')-1)
	lvs_Parametro	= Mid(lvs_Parametro,Pos(lvs_Parametro,';')+1)
	
	If Trim(lvs_Pesquisa) <> '' Then dw_1.Object.de_filtro [1] = Upper(lvs_Pesquisa)
End if

If Pos(lvs_Parametro,';')>0 Then
	lvs_Grupo		= Mid(lvs_Parametro,1,Pos(lvs_Parametro,';')-1)
	lvs_Parametro	= Mid(lvs_Parametro,Pos(lvs_Parametro,';')+1)
	
	If Trim(lvs_Grupo) <> '' Then
		dw_1.Object.cd_grupo [1] = lvs_Grupo
		dw_1.Object.cd_grupo.TabSequence = 0
		
		If dw_1.GetChild("cd_subgrupo", ldwc_Child) = 1 Then
			ldwc_Child.SetFilter("( cd_grupo = '0' or  cd_grupo = '"+lvs_Grupo+"')")
			ldwc_Child.Filter()
			dw_1.Object.cd_subgrupo [1] = '0'
		End If
	End If
End if

If Pos(lvs_Parametro,';')>0 Then
	lvs_Subgrupo	= Mid(lvs_Parametro,1,Pos(lvs_Parametro,';')-1)
	lvs_Parametro	= Mid(lvs_Parametro,Pos(lvs_Parametro,';')+1)
	
	If Trim(lvs_Subgrupo) <> '' Then
		dw_1.Object.cd_subgrupo [1] = lvs_Subgrupo
		dw_1.Object.cd_subgrupo.TabSequence = 0
	End If
End if

If (Trim(lvs_Pesquisa)<>'')or(lvs_Subgrupo<>'') Then dw_2.Event ue_Retrieve()
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge022_selecao_categoria
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge022_selecao_categoria
integer y = 392
integer width = 2994
integer height = 1280
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge022_selecao_categoria
integer width = 1550
integer height = 356
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge022_selecao_categoria
integer width = 1467
integer height = 256
string dataobject = "dw_ge022_selecao_categoria"
end type

event dw_1::itemchanged;call super::itemchanged;DataWindowChild ldwc_Child

Choose Case Dwo.Name
	Case 'cd_grupo'
		//Chamado 	776912 - Estava ocorrendo erro ao filtrar o Grupo na sele$$HEX2$$e700e300$$ENDHEX$$o de categoria
		//If Data <> '1' Then This.Object.id_lei_generico [Row] = 'T'
	
		If This.GetChild("cd_subgrupo", ldwc_Child) = 1 Then
			ldwc_Child.SetFilter("( cd_grupo = '0' or  cd_grupo = '"+Data+"')")
			ldwc_Child.Filter()
			This.Object.cd_subgrupo [Row] = '0'
		End If
End Choose
end event

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge022_selecao_categoria
integer y = 464
integer width = 2921
integer height = 1180
string dataobject = "dw_ge022_lista_categoria"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_grupo
String lvs_Subgrupo
String lvs_Filtro

dw_1.Accepttext( )

lvs_grupo		= dw_1.Object.cd_grupo 	[1]
lvs_Subgrupo	= dw_1.Object.cd_subgrupo[1]
lvs_Filtro			= dw_1.Object.de_filtro		[1]

If (Not IsNull(lvs_Filtro))and(Trim(lvs_Filtro)<>'') Then
	This.Of_appendwhere("c.de_categoria like '%"+lvs_Filtro+"%'")
End if

If lvs_grupo<>'0' then
	This.Of_appendwhere("s.cd_grupo='"+lvs_grupo+"'")
End if

If lvs_Subgrupo<>'0' then
	This.Of_appendwhere("c.cd_subgrupo='"+lvs_Subgrupo+"'")
End if

Return AncestorReturnValue
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge022_selecao_categoria
integer x = 2272
integer y = 1716
end type

event cb_selecionar::clicked;call super::clicked;String lvs_Categoria

If dw_2.GetRow() > 0 Then
	lvs_Categoria = dw_2.Object.cd_categoria [dw_2.GetRow()]
	CloseWithReturn(Parent,lvs_Categoria)
Else
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Selecione uma categoria!')
End If

end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge022_selecao_categoria
integer x = 2661
integer y = 1716
end type

event cb_cancelar::clicked;call super::clicked;CloseWithReturn(Parent,'')
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge022_selecao_categoria
integer x = 1829
integer y = 1716
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge022_selecao_categoria
integer y = 1716
end type

