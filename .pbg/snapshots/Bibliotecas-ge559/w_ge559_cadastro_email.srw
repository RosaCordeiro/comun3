HA$PBExportHeader$w_ge559_cadastro_email.srw
forward
global type w_ge559_cadastro_email from dc_w_2tab_cadastro_selecao_lista_det
end type
end forward

global type w_ge559_cadastro_email from dc_w_2tab_cadastro_selecao_lista_det
string tag = "w_ge559_cadastro_email"
integer width = 3973
integer height = 1820
string title = "GE559 - Cadastro de Email Automatico. "
end type
global w_ge559_cadastro_email w_ge559_cadastro_email

type variables
uo_Usuario ivo_Usuario
uo_mensagem_email io_Msg_Email
end variables

forward prototypes
public subroutine wf_insere_padrao ()
end prototypes

public subroutine wf_insere_padrao ();DataWindowChild	ldwc_Child

/*Sistema*/
ldwc_Child  = Tab_1.TabPage_1.dw_1.of_InsertRow_DDDW("cd_sistema" )			

ldwc_Child.SetItem(1, "cd_sistema", "00"	)
ldwc_Child.SetItem(1, "nm_sistema", "TODOS")

Tab_1.TabPage_1.dw_1.Object.Cd_sistema[1] = "00"
end subroutine

on w_ge559_cadastro_email.create
call super::create
end on

on w_ge559_cadastro_email.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;Destroy(ivo_Usuario)
Destroy(io_Msg_Email)
end event

event open;call super::open;ivo_Usuario = Create uo_Usuario
io_Msg_Email = Create uo_mensagem_email
end event

event ue_preopen;call super::ue_preopen;ivb_grava_log = True

// Determina as dimens$$HEX1$$f500$$ENDHEX$$es dos folders
// Sele$$HEX2$$e700e300$$ENDHEX$$o
ivl_Largura_1 = 2885
ivl_Altura_1  = 1640

// Detalhes
ivl_Largura_2 = 3936
ivl_Altura_2    = 1640
end event

event ue_postopen;call super::ue_postopen;wf_insere_padrao()
end event

type dw_visual from dc_w_2tab_cadastro_selecao_lista_det`dw_visual within w_ge559_cadastro_email
end type

type gb_aux_visual from dc_w_2tab_cadastro_selecao_lista_det`gb_aux_visual within w_ge559_cadastro_email
end type

type tab_1 from dc_w_2tab_cadastro_selecao_lista_det`tab_1 within w_ge559_cadastro_email
integer y = 4
integer width = 3895
integer height = 1604
end type

event tab_1::selectionchanging;//OverRide

Long ll_Linha

SetPointer(HourGlass!)

If NewIndex = 2 Then
	If Tab_1.TabPage_1.dw_2.GetRow() > 0 Then
	
		
		Tab_1.TabPage_2.dw_3.Event ue_Retrieve()
		
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma linha da lista para visualizar os detalhes.", StopSign!)
		// N$$HEX1$$e300$$ENDHEX$$o permite a troca do folder
		Return 1
	End If
Else
	ivm_Menu.mf_Confirmar(False)
	ivm_Menu.mf_Cancelar(False)
	ivm_menu.ivb_permite_incluir 	= False
	ivm_Menu.mf_Excluir(False)

End If	


SetPointer(Arrow!)
end event

type tabpage_1 from dc_w_2tab_cadastro_selecao_lista_det`tabpage_1 within tab_1
integer width = 3858
integer height = 1488
end type

type gb_2 from dc_w_2tab_cadastro_selecao_lista_det`gb_2 within tabpage_1
integer y = 372
integer width = 2802
integer height = 1100
end type

type gb_1 from dc_w_2tab_cadastro_selecao_lista_det`gb_1 within tabpage_1
integer width = 1783
integer height = 340
end type

type dw_1 from dc_w_2tab_cadastro_selecao_lista_det`dw_1 within tabpage_1
integer x = 32
integer width = 1751
integer height = 232
string dataobject = "dw_ge559_selecao"
end type

event dw_1::ue_key;call super::ue_key;This.accepttext()

If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "nm_usuario"
			ivo_Usuario.of_Localiza_Usuario(This.GetText())
			
			If ivo_Usuario.Localizado Then
				This.Object.nr_matricula	[1] = ivo_Usuario.nr_matricula
				This.Object.nm_usuario	[1] = ivo_Usuario.nm_usuario
			End If
			
		Case "de_assunto"
			io_Msg_Email.of_Localiza(This.GetText())
			
			If io_Msg_Email.Localizado Then
				This.Object.Cd_Mensagem	[1] = io_Msg_Email.Cd_Mensagem
				This.Object.De_Assunto		[1] = io_Msg_Email.De_Assunto
			End If			
	End Choose
End If
end event

event dw_1::ue_cancel;//OverRide
end event

event dw_1::editchanged;call super::editchanged;tab_1.tabpage_1.dw_2.Event ue_Reset()

Choose Case dwo.Name
		
	Case "nm_usuario"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Usuario.nm_usuario Then
				Return 1
			End If
		Else
			ivo_Usuario.of_Inicializa()
				
			This.Object.nr_matricula	[1] = ivo_Usuario.nr_matricula
			This.Object.nm_usuario  [1] = ivo_Usuario.nm_usuario
		End If
		
	Case "de_assunto"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> io_Msg_Email.De_Assunto Then
				Return 1
			End If
		Else
			io_Msg_Email.of_Inicializa()
				
			This.Object.Cd_Mensagem	[1] = io_Msg_Email.Cd_Mensagem
			This.Object.De_Assunto  	[1] = io_Msg_Email.De_Assunto
		End If
End Choose
end event

event dw_1::itemchanged;call super::itemchanged;tab_1.tabpage_1.dw_2.Event ue_Reset()

Choose Case dwo.Name
		
	Case "nm_usuario"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Usuario.nm_usuario Then
				Return 1
			End If
		Else
			ivo_Usuario.of_Inicializa()
				
			This.Object.nr_matricula	[1] = ivo_Usuario.nr_matricula
			This.Object.nm_usuario  [1] = ivo_Usuario.nm_usuario
		End If
		
	Case "de_assunto"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> io_Msg_Email.De_Assunto Then
				Return 1
			End If
		Else
			io_Msg_Email.of_Inicializa()
				
			This.Object.Cd_Mensagem	[1] = io_Msg_Email.Cd_Mensagem
			This.Object.De_Assunto  	[1] = io_Msg_Email.De_Assunto
		End If
End Choose
end event

type dw_2 from dc_w_2tab_cadastro_selecao_lista_det`dw_2 within tabpage_1
integer x = 50
integer y = 452
integer width = 2738
integer height = 984
string dataobject = "dw_ge559_lista"
boolean hscrollbar = true
end type

event dw_2::ue_cancel;//OverRide
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;ivm_menu.ivb_permite_incluir = False
ivm_Menu.mf_Excluir(False)

//Salvar planilha
If pl_Linhas > 0 Then
	This.ivo_Controle_Menu.of_SalvarComo(True)
Else
	This.ivo_Controle_Menu.of_SalvarComo(False)
End If

Return pl_Linhas
end event

event dw_2::constructor;call super::constructor;This.ivb_Ordena_Colunas = True
This.ivb_Ordena_Colunas = True
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;Long ll_Cd_Mensagem

String ls_Matricula
String ls_Cd_Sistema

Tab_1.TabPage_1.dw_1.AcceptText()

ll_Cd_Mensagem	= Tab_1.TabPage_1.dw_1.Object.Cd_mensagem 	[1]
ls_Matricula			= Tab_1.TabPage_1.dw_1.Object.nr_matricula		[1]
ls_Cd_Sistema		= Tab_1.TabPage_1.dw_1.Object.cd_sistema 		[1]

If Not IsNull(ll_Cd_Mensagem) And ll_Cd_Mensagem > 0 Then 
	This.of_appendwhere("a.cd_mensagem = " + String(ll_Cd_Mensagem))
End If

If Not IsNull(ls_Matricula) And ls_Matricula <> "" Then
	This.of_appendwhere("b.nr_matricula = '" + ls_Matricula +"'")
End If

If ls_Cd_Sistema <> "00" Then
	This.of_appendwhere("a.cd_sistema = '" + ls_Cd_Sistema + "'")
End If

Return 1
end event

type tabpage_2 from dc_w_2tab_cadastro_selecao_lista_det`tabpage_2 within tab_1
integer width = 3858
integer height = 1488
end type

type gb_3 from dc_w_2tab_cadastro_selecao_lista_det`gb_3 within tabpage_2
integer width = 3808
integer height = 1448
end type

type dw_3 from dc_w_2tab_cadastro_selecao_lista_det`dw_3 within tabpage_2
integer x = 59
integer width = 3717
integer height = 1348
string dataobject = "dw_ge559_lista_detalhe"
boolean vscrollbar = true
end type

event dw_3::ue_key;call super::ue_key;Long ll_Find

Tab_1.TabPage_1.dw_1.AcceptText()
This.accepttext()

If Key = KeyEnter! Then
	Choose Case This.GetColumnName()

		Case "nm_usuario"
			ivo_Usuario.of_Localiza_Usuario(This.GetText())
			
			If ivo_Usuario.Localizado Then
				This.Object.nr_matricula	[This.getrow() ] = ivo_Usuario.nr_matricula
				This.Object.nm_usuario	[This.getrow() ] = ivo_Usuario.nm_usuario
				This.Object.de_email		[This.getrow() ] = ivo_Usuario.de_email
			End If
	End Choose
End If

end event

event dw_3::constructor;call super::constructor;This.ivb_Ordena_Colunas = True

This.of_SetRowSelection()

ivi_Tipo_Cancelar = RETRIEVE
end event

event dw_3::ue_preupdate;call super::ue_preupdate;String ls_Matricula
String ls_Usuario
String ls_Email
String ls_Email_Ant
String ls_Tipo

Date dt_Inicio
Date dt_Termino

Long ll_Linha
Long ll_Find

This.accepttext()

For ll_Linha = 1 to This.rowcount()

	ls_Matricula		= This.Object.nr_matricula 					[ll_Linha]
	ls_Usuario		= This.Object.nm_usuario					[ll_Linha]
	ls_email			= This.Object.de_email						[ll_Linha]
	ls_Email_Ant	= This.Object.de_email_ant 				[ll_Linha]
	ls_Tipo			= This.Object.id_tipo_envio 					[ll_Linha]
	dt_Inicio			= Date(This.Object.dh_inicio_envio		[ll_Linha])
	dt_Termino		= Date(This.Object.dh_termino_envio 	[ll_Linha])

	If isNull(ls_Matricula) Or ls_matricula = '' Then
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Matricula n$$HEX1$$e300$$ENDHEX$$o pode ser nula.',Exclamation!)
		This.event ue_Pos(ll_Linha,"nm_usuario" )
		Return -1
	End If
	
	If isNull(ls_email) or ls_email = '' Then
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','E-mail n$$HEX1$$e300$$ENDHEX$$o pode ser nulo.',Exclamation!)
		This.event ue_Pos(ll_Linha,"de_email" )
		Return -1
	End If
	
	If not gf_valida_email(ls_email) Then
	//	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','E-mail invalido.',Exclamation!) //MessageBox est$$HEX1$$e100$$ENDHEX$$ dentro da fun$$HEX2$$e700e300$$ENDHEX$$o.
		This.event ue_Pos(ll_Linha,"de_email" )
		Return -1
	End If
	
	If ls_email <> ls_Email_Ant Or isNull(ls_Email_Ant) Then	
		
		ll_Find = This.find("nr_matricula = '" + ls_Matricula + "'", 1, This.rowcount())
			
		If ll_Find > 0 And ll_Find <> ll_Linha Then
			Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Usu$$HEX1$$e100$$ENDHEX$$rio j$$HEX1$$e100$$ENDHEX$$ consta na lista.",Exclamation!)
			This.event ue_Pos(ll_Linha,"nm_usuario" )
			Return -1
		End If
		
		If ll_Find < 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Find da dw_3.", StopSign!)
			Return -1
		End If
		
		setNull(ll_Find)
		
		ll_Find = This.find("de_email = '" + ls_Email + "'", 1, This.rowcount())
		
		If ll_Find > 0  And ll_Find <> ll_Linha  Then
			Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Email j$$HEX1$$e100$$ENDHEX$$ consta na lista.",Exclamation!)
			This.event ue_Pos(ll_Linha,"de_email" )
			Return -1
		End If
		
		If ll_Find < 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Find da dw_3.", StopSign!)
			Return -1
		End If

		This.Object.cd_mensagem[ll_Linha] = Tab_1.TabPage_1.dw_2.Object.cd_mensagem [ Tab_1.TabPage_1.dw_2.GetRow()]
		If posA(ls_email,'@clamed.com.br',1) < 1 Then
			If posA(ls_email,'@clamedlocal.com.br',1) < 1 Then
				MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','E-mail deve ser do dominio Clamed.',Exclamation!)
				This.event ue_Pos(ll_Linha,"de_email" )
				Return -1
			End If
		End If
	End If
	
	
	If isNull(dt_Inicio) Or not isDate(String(dt_Inicio)) Then
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Informe a data de inicio.',Exclamation!)
		This.event ue_Pos(ll_Linha,"dh_inicio_envio" )
		Return -1
	End If
	
	If isNull(ls_Tipo) Then
		MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Informe o tipo de envio.',Exclamation!)
		This.event ue_Pos(ll_Linha,"id_tipo_envio" )
		Return -1
	End If
	
Next
end event

event dw_3::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	ivm_menu.ivb_permite_incluir = True
	ivm_menu.mf_incluir(True)
	ivm_Menu.mf_Excluir(True)
	
	//Salvar planilha
	This.ivo_Controle_Menu.of_SalvarComo(True)

Else
	ivm_menu.ivb_permite_incluir = False
	ivm_Menu.mf_Excluir(False)
	
	This.ivo_Controle_Menu.of_SalvarComo(False)
End If

Return pl_Linhas
end event

event dw_3::ue_preinsertrow;//OverRide

If wf_Valida_Salva() > 0 Then
	Return 1
Else
	Return -1
End If
end event

event dw_3::ue_addrow;//OverRide

Long lvl_Linha

Integer lvi_Retorno

SetPointer(HourGlass!)

If This.Event ue_PreInsertRow() = 1 Then
	lvl_Linha = This.InsertRow(0)
	
	// Posiciona na linha inclu$$HEX1$$ed00$$ENDHEX$$da
	This.ScrollToRow(lvl_Linha)
	This.SetRow(lvl_Linha)

	// Posiciona na primeira coluna com TabOrder < 0
	of_Posiciona_Coluna()

	lvi_Retorno = lvl_Linha
	
	ivb_Inclusao = True
	
	This.ivo_Controle_Menu.of_Excluir(True)
	
	This.Object.dh_inicio_envio[lvl_Linha] = Date(gf_GetServerDate() )
	
	ivm_Menu.mf_Confirmar(False)
	ivm_Menu.mf_Cancelar(False)
	
Else
	lvi_Retorno = -1
End If

SetPointer(Arrow!)

Return lvi_Retorno


end event

event dw_3::ue_recuperar;//OverRide

Tab_1.TabPage_1.dw_2.AcceptText()

Return This.Retrieve(Tab_1.TabPage_1.dw_2.Object.cd_mensagem [ Tab_1.TabPage_1.dw_2.GetRow()])
end event

event dw_3::ue_deleterow;//OverRide
Boolean lvb_Retorno = False

SetPointer(HourGlass!)

If This.Event ue_PreDeleteRow() Then
	If This.DeleteRow(0) = 1 Then
		If Not IsNull(ivm_Menu) Then			
			ivm_Menu.mf_Confirmar(True)
			ivm_Menu.mf_Cancelar(True)
			
			If This.RowCount() = 0 Then	
				ivm_Menu.mf_Imprimir(False)
				ivm_Menu.mf_Excluir(False)
			ElseIf This.RowCount() = 1 Then
				ivm_Menu.mf_Classificar(False)
				ivm_Menu.mf_Filtrar(False)
				ivm_Menu.mf_Localizar(False)
			End If	
		End If
		
		// Se for uma DW atualiz$$HEX1$$e100$$ENDHEX$$vel, habilita a valida$$HEX2$$e700e300$$ENDHEX$$o do closequery da janela
		If ivb_UpdateAble Then
			ivw_ParentWindow.ivb_Valida_Salva = True
		End If

		lvb_Retorno = True
	End If
End If

SetPointer(Arrow!)
Return lvb_Retorno
end event

event dw_3::clicked;//Overrider

long lvl_row, lvl_cont, lvl_find

This.AcceptText()

If dwo.Name = "p_seleciona" Then
	
	lvl_row = This.rowCount()
		
	lvl_find = This.find(" id_principal = 'S' " , 1, lvl_row)
	
	For lvl_cont = 1 To lvl_row
		
		If lvl_find = 0 Then
			This.object.id_principal[lvl_cont] = 'S'
		Else	
			This.object.id_principal[lvl_cont] = 'N'
		End If
	Next	
End If

// For$$HEX1$$e700$$ENDHEX$$a ao confirmar validar o evento ue_save
ivb_Valida_Salva = True

ivm_Menu.mf_cancelar( True)
ivm_Menu.mf_confirmar( True)
end event

