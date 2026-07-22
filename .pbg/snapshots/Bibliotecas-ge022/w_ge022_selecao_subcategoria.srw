HA$PBExportHeader$w_ge022_selecao_subcategoria.srw
forward
global type w_ge022_selecao_subcategoria from dc_w_selecao_generica
end type
end forward

global type w_ge022_selecao_subcategoria from dc_w_selecao_generica
integer width = 3067
integer height = 1932
string title = "GE022 - Sele$$HEX2$$e700e300$$ENDHEX$$o Subcategoria"
end type
global w_ge022_selecao_subcategoria w_ge022_selecao_subcategoria

type variables
uo_categoria ivo_categoria
end variables

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

on w_ge022_selecao_subcategoria.create
call super::create
end on

on w_ge022_selecao_subcategoria.destroy
call super::destroy
end on

event ue_postopen;call super::ue_postopen;DataWindowChild ldwc_Child

String lvs_Parametro
String lvs_Pesquisa	= ''
String lvs_Grupo		= ''
String lvs_Subgrupo	= ''
String lvs_Categoria	= ''

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

If Trim(lvs_Parametro)<>"" Then
	If Pos(lvs_Parametro,';')>0 Then 
		lvs_Categoria	= Mid(lvs_Parametro,1,Pos(lvs_Parametro,';')-1)
		lvs_Parametro	= Mid(lvs_Parametro,Pos(lvs_Parametro,';')+1)
	Else
		lvs_Categoria	= lvs_Parametro
		lvs_Parametro	= ''
	End If
	
	ivo_categoria.of_localiza_codigo(lvs_Categoria)
	
	If ivo_categoria.Localizado Then
		dw_1.Object.cd_categoria [1] = ivo_categoria.cd_categoria
		dw_1.Object.de_categoria [1] = ivo_categoria.de_categoria
		
		dw_1.Object.de_categoria.TabSequence = 0
	End if
End If

If (Trim(lvs_Pesquisa)<>'')or(lvs_Subgrupo<>'') Then dw_2.Event ue_Retrieve()
end event

event ue_preopen;call super::ue_preopen;ivo_categoria = Create uo_categoria
end event

event close;call super::close;Destroy(ivo_categoria)
end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge022_selecao_subcategoria
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge022_selecao_subcategoria
integer y = 304
integer width = 2994
integer height = 1368
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge022_selecao_subcategoria
integer width = 2994
integer height = 276
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge022_selecao_subcategoria
integer width = 2939
integer height = 176
string dataobject = "dw_ge022_selecao_subcategoria"
end type

event dw_1::itemchanged;call super::itemchanged;DataWindowChild ldwc_Child

Choose Case Dwo.Name
	Case 'cd_grupo'
		If Data <> '1' Then This.Object.id_lei_generico [Row] = 'T'
	
		If This.GetChild("cd_subgrupo", ldwc_Child) = 1 Then
			ldwc_Child.SetFilter("( cd_grupo = '0' or  cd_grupo = '"+Data+"')")
			ldwc_Child.Filter()
			This.Object.cd_subgrupo [Row] = '0'
		End If
		
	Case 'de_categoria'
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_categoria.de_categoria Then
				Return 1
			End If	
		Else			
			ivo_categoria.Of_Inicializa()
			
			This.Object.cd_categoria	[1] = ivo_categoria.de_categoria
			This.Object.de_categoria	[1] = ivo_categoria.cd_categoria
		End If	
		
End Choose
end event

event dw_1::ue_key;call super::ue_key;String lvs_Grupo	
String lvs_Subgrupo

If Key=KeyEnter! Then
	Choose Case This.GetColumnName()
		Case 'de_categoria'
			lvs_Grupo		= This.Object.cd_grupo 		[1]
			lvs_Subgrupo	= This.Object.cd_subgrupo	[1]
			
			ivo_categoria.of_localiza(This.GetText(),lvs_Grupo,lvs_Subgrupo)
			
			This.Object.cd_categoria	[1] = ivo_categoria.cd_categoria
			This.Object.de_categoria	[1] = ivo_categoria.de_categoria
	End Choose
End If
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_categoria) Then
	This.Object.de_categoria [1] = ivo_categoria.de_categoria
End If

end event

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge022_selecao_subcategoria
integer y = 376
integer width = 2939
integer height = 1268
string dataobject = "dw_ge022_lista_subcategoria"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_grupo
String lvs_Subgrupo
String lvs_Categoria
String lvs_Filtro

dw_1.Accepttext( )

lvs_grupo		= dw_1.Object.cd_grupo 	[1]
lvs_Subgrupo	= dw_1.Object.cd_subgrupo[1]
lvs_Categoria	= dw_1.Object.cd_categoria[1]
lvs_Filtro			= dw_1.Object.de_filtro		[1]

If (Not IsNull(lvs_Filtro))and(Trim(lvs_Filtro)<>'') Then
	This.Of_appendwhere("sc.de_subcategoria like '%"+lvs_Filtro+"%'")
End if

If (Not IsNull(lvs_Categoria))and(Trim(lvs_Categoria)<>'') Then
	This.Of_appendwhere("c.cd_categoria = '"+lvs_Categoria+"'")
End if

If lvs_grupo<>'0' then
	This.Of_appendwhere("s.cd_grupo='"+lvs_grupo+"'")
End if

If lvs_Subgrupo<>'0' then
	This.Of_appendwhere("c.cd_subgrupo='"+lvs_Subgrupo+"'")
End if

Return AncestorReturnValue
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge022_selecao_subcategoria
integer x = 2272
integer y = 1716
end type

event cb_selecionar::clicked;call super::clicked;String lvs_Subcategoria

If dw_2.GetRow() > 0 Then
	lvs_Subcategoria = dw_2.Object.cd_subcategoria [dw_2.GetRow()]
	CloseWithReturn(Parent,lvs_Subcategoria)
Else
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Selecione uma Subcategoria!')
End If

end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge022_selecao_subcategoria
integer x = 2661
integer y = 1716
end type

event cb_cancelar::clicked;call super::clicked;CloseWithReturn(Parent,'')
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge022_selecao_subcategoria
integer x = 1829
integer y = 1716
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge022_selecao_subcategoria
integer y = 1716
end type

