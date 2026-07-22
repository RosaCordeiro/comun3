HA$PBExportHeader$w_ge321_consulta_log_alteracao.srw
forward
global type w_ge321_consulta_log_alteracao from dc_w_selecao_lista_relatorio
end type
type dw_4 from dc_uo_dw_base within w_ge321_consulta_log_alteracao
end type
type st_filtro_fixo from statictext within w_ge321_consulta_log_alteracao
end type
end forward

global type w_ge321_consulta_log_alteracao from dc_w_selecao_lista_relatorio
integer width = 4663
integer height = 2288
string title = "GE321 - Consulta Hist$$HEX1$$f300$$ENDHEX$$rico Altera$$HEX2$$e700e300$$ENDHEX$$o"
dw_4 dw_4
st_filtro_fixo st_filtro_fixo
end type
global w_ge321_consulta_log_alteracao w_ge321_consulta_log_alteracao

type variables
uo_usuario			ivo_usuario	//GE010
uo_campo_log 		ivo_campo	//GE321
uo_tabela_log 		ivo_tabela	//GE321
uo_log_alteracao	ivo_param	//GE321
end variables

on w_ge321_consulta_log_alteracao.create
int iCurrent
call super::create
this.dw_4=create dw_4
this.st_filtro_fixo=create st_filtro_fixo
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_4
this.Control[iCurrent+2]=this.st_filtro_fixo
end on

on w_ge321_consulta_log_alteracao.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_4)
destroy(this.st_filtro_fixo)
end on

event ue_preopen;call super::ue_preopen;ivo_usuario	= Create uo_usuario
ivo_campo 	= Create uo_campo_log
ivo_tabela	= Create uo_tabela_log

ivo_param = Message.PowerObjectParm	

MaxHeight = 9999

end event

event close;call super::close;Destroy(ivo_usuario)
Destroy(ivo_campo)
Destroy(ivo_tabela)
end event

event ue_postopen;call super::ue_postopen;String lvs_Filtro_Fixo = ""

If IsValid(ivo_param) Then
	If ivo_param.Tabelas<>"" Then lvs_Filtro_Fixo += "Tabelas ("+Upper(ivo_param.Tabelas)+") "
	If ivo_param.Campos<>"" Then lvs_Filtro_Fixo += "Campos ("+Upper(ivo_param.Campos)+") "
	st_filtro_fixo.Visible	= (lvs_Filtro_Fixo <> "")
	st_filtro_fixo.Text		= "Filtro Fixo:  "+lvs_Filtro_Fixo

	ivo_campo.Of_Set_Filtro( ivo_param.Campos )
	ivo_tabela.Of_Set_Filtro( ivo_param.Tabelas )
	dw_1.Object.de_chave	[1] = ivo_param.Chave
	dw_1.Object.dt_inicio		[1] = ivo_param.Inicio
	dw_1.Object.dt_fim		[1] = ivo_param.Fim
Else
	dw_1.Object.dt_inicio	[1] = Today()
	dw_1.Object.dt_fim	[1] = Today()
End If

dw_4.Event ue_AddRow()
end event

event resize;call super::resize;dw_2.Height -= dw_4.Height - 30
dw_4.Y = Newheight - 780
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge321_consulta_log_alteracao
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge321_consulta_log_alteracao
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge321_consulta_log_alteracao
integer y = 432
integer width = 4558
integer height = 1696
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge321_consulta_log_alteracao
integer width = 2587
integer height = 328
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge321_consulta_log_alteracao
integer width = 2519
integer height = 248
string dataobject = "dw_ge321_selecao"
end type

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	This.Accepttext( )
	Choose Case This.GetColumnName()
		Case 'nm_usuario'
			ivo_usuario.of_localiza_usuario(This.GetText())
			
			If ivo_usuario.Localizado Then
				This.Object.nm_usuario	[1] = ivo_usuario.nm_usuario
				This.Object.nr_matricula	[1] = ivo_usuario.nr_matricula
			Else
				ivo_usuario.Of_Inicializa()
				This.Object.nm_usuario	[1] = ivo_usuario.nm_usuario
				This.Object.nr_matricula	[1] = ivo_usuario.nr_matricula
			End If
			
		Case 'nm_localiza_tabela'
			ivo_tabela.of_localiza(This.GetText())
			
			If ivo_tabela.Localizado Then
				This.Object.nm_localiza_tabela	[1] = ivo_tabela.Tabela
				This.Object.nm_tabela			[1] = ivo_tabela.Tabela
				
				This.Event ue_pos(1,'nm_campo')
			Else
				ivo_tabela.Of_Inicializa()
				This.Object.nm_localiza_tabela	[1] = ivo_tabela.Tabela
				This.Object.nm_tabela			[1] = ivo_tabela.Tabela
			End If
			//Limpa informa$$HEX2$$e700f500$$ENDHEX$$es do campo
			ivo_campo.Of_Inicializa()
			This.Object.nm_localiza_campo	[1] = ivo_campo.Campo
			This.Object.nm_campo 				[1] = ivo_campo.Campo
			
		Case 'nm_localiza_campo'
			ivo_campo.of_localiza(This.GetText(),ivo_tabela.Tabela)
			
			If ivo_campo.Localizado Then
				This.Object.nm_localiza_campo[1] = ivo_campo.Campo
				This.Object.nm_campo			[1] = ivo_campo.Campo
			Else
				ivo_campo.Of_Inicializa()
				This.Object.nm_localiza_campo[1] = ivo_campo.Campo
				This.Object.nm_campo			[1] = ivo_campo.Campo
			End If
	End Choose
End If
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_usuario) then
	This.Object.nm_usuario [1] = ivo_usuario.nm_usuario
End If

If IsValid(ivo_tabela) then
	This.Object.nm_localiza_tabela [1] = ivo_tabela.Tabela
End If

If IsValid(ivo_campo) then
	This.Object.nm_localiza_campo [1] = ivo_campo.Campo
End If
end event

event dw_1::itemchanged;call super::itemchanged;Choose Case Dwo.Name
	Case "nm_usuario"
		If Trim(Data) <> "" Then
			If Data <> ivo_usuario.Nm_Usuario Then
				Return 1
			End If	
		Else	
			ivo_usuario.Of_Inicializa()
			
			This.Object.nr_matricula	[1] = ivo_usuario.nr_matricula
			This.Object.nm_usuario	[1] = ivo_usuario.nm_usuario
		End If
	Case "nm_localiza_campo"
		If Trim(Data) <> "" Then
			If Data <> ivo_campo.Campo Then
				Return 1
			End If	
		Else	
			ivo_campo.Of_Inicializa()
			
			This.Object.nm_localiza_campo	[1] = ivo_campo.Campo
			This.Object.nm_campo				[1] = ivo_campo.Campo
		End If
	Case "nm_localiza_tabela"
		If Trim(Data) <> "" Then
			If Data <> ivo_Tabela.Tabela Then
				Return 1
			End If	
		Else	
			ivo_Tabela.Of_Inicializa()
			
			This.Object.nm_localiza_tabela	[1] = ivo_Tabela.Tabela
			This.Object.nm_tabela			[1] = ivo_Tabela.Tabela
			
			ivo_campo.Of_Inicializa()
			
			This.Object.nm_localiza_campo	[1] = ivo_campo.Campo
			This.Object.nm_campo				[1] = ivo_campo.Campo
		End If
End Choose
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge321_consulta_log_alteracao
integer y = 508
integer width = 4489
integer height = 844
string dataobject = "dw_ge321_lista"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_recuperar;Datetime lvdh_Inicio
Datetime lvdh_Fim

dw_1.AcceptText( )
lvdh_Inicio	= Datetime(dw_1.Object.dt_inicio	[1],Time('00:00:00'))
lvdh_Fim		= Datetime(dw_1.Object.dt_fim	[1],Time('23:59:59'))

Return This.Retrieve(lvdh_Inicio,lvdh_Fim, gvo_aplicacao.ivo_seguranca.cd_sistema)
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Tabela
String lvs_Campo
String lvs_Tipo
String lvs_Usuario
String lvs_Chave

dw_1.AcceptText( )

lvs_Tabela	= dw_1.Object.nm_tabela	[1]
lvs_Campo	= dw_1.Object.nm_campo	[1]
lvs_Tipo		= dw_1.Object.id_alteracao	[1]
lvs_Usuario	= dw_1.Object.nr_matricula	[1]
lvs_Chave	= dw_1.Object.de_chave		[1]

If IsValid(ivo_param) Then
	If ivo_param.Tabelas <> "" Then
		This.Of_AppendWhere("h.nm_tabela in ('"+gf_replace(gf_replace(Upper(ivo_param.Tabelas), ",", "','",0), " ", "", 0)+"')", 1)
		This.Of_AppendWhere("h.nm_tabela in ('"+gf_replace(gf_replace(Upper(ivo_param.Tabelas), ",", "','",0), " ", "", 0)+"')", 2)
	End If
	
	If ivo_param.Campos <> "" Then
		This.Of_AppendWhere("h.nm_coluna in ('"+gf_replace(gf_replace(Upper(ivo_param.Campos), ",", "','",0), " ", "", 0)+"')", 1)
		This.Of_AppendWhere("h.nm_coluna in ('"+gf_replace(gf_replace(Upper(ivo_param.Campos), ",", "','",0), " ", "", 0)+"')", 2)
	End If
	
	If ivo_param.Campos_ignorar <> "" Then
		This.Of_AppendWhere("h.nm_coluna not in ('"+gf_replace(gf_replace(Upper(ivo_param.Campos_ignorar), ",", "','",0), " ", "", 0)+"')", 1)
		This.Of_AppendWhere("h.nm_coluna not in ('"+gf_replace(gf_replace(Upper(ivo_param.Campos_ignorar), ",", "','",0), " ", "", 0)+"')", 2)
	End If
	
End If
	
If (Not IsNull(lvs_Tabela))and(Trim(lvs_Tabela)<>'') Then
	This.Of_AppendWhere("h.nm_tabela = '"+lvs_Tabela+"'", 1)
	This.Of_AppendWhere("h.nm_tabela = '"+lvs_Tabela+"'", 2)
End If

If (Not IsNull(lvs_Campo))and(Trim(lvs_Campo)<>'') Then
	This.Of_AppendWhere("h.nm_coluna = '"+lvs_Campo+"'", 1)
	This.Of_AppendWhere("h.nm_coluna = '"+lvs_Campo+"'", 2)
End If

If (Not IsNull(lvs_Tipo))and(Trim(lvs_Tipo)<>'T') Then
	This.Of_AppendWhere("h.id_alteracao = '"+lvs_Tipo+"'", 1)
	This.Of_AppendWhere("h.id_alteracao = '"+lvs_Tipo+"'", 2)
End If

If (Not IsNull(lvs_Usuario))and(Trim(lvs_Usuario)<>'') Then
	This.Of_AppendWhere("h.nr_matric_alteracao = '"+lvs_Usuario+"'", 1)
	This.Of_AppendWhere("h.nr_matric_alteracao = '"+lvs_Usuario+"'", 2)
End If

If (Not IsNull(lvs_Chave))and(Trim(lvs_Chave)<>'') Then
	lvs_Chave = Trim(gf_replace(lvs_Chave,' - ','@#!',0))
	This.Of_AppendWhere("h.de_chave like '%"+lvs_Chave+"%'", 1)
	This.Of_AppendWhere("h.de_chave like '%"+lvs_Chave+"%'", 2)
End If

lvs_Chave = This.GetSQLSelect()

Return AncestorReturnValue
end event

event dw_2::rowfocuschanged;call super::rowfocuschanged;If (Not IsNull(CurrentRow)) and (CurrentRow > 0) and (CurrentRow <= This.RowCount()) Then
	dw_4.Object.de_de	[1] = This.Object.de_alteracao_de	[CurrentRow]
	dw_4.Object.de_para	[1] = This.Object.de_alteracao_para	[CurrentRow]
Else
	dw_4.Object.de_de	[1] = ''
	dw_4.Object.de_para	[1] = ''
End If
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;This.ivm_menu.mf_salvarcomo( pl_linhas > 0)

Return AncestorReturnValue
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge321_consulta_log_alteracao
integer x = 2665
integer y = 76
end type

type dw_4 from dc_uo_dw_base within w_ge321_consulta_log_alteracao
integer x = 59
integer y = 1332
integer width = 4526
integer height = 724
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge321_alteracao"
end type

type st_filtro_fixo from statictext within w_ge321_consulta_log_alteracao
integer x = 55
integer y = 364
integer width = 2711
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 16777401
long backcolor = 67108864
boolean focusrectangle = false
end type

