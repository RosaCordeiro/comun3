HA$PBExportHeader$dc_w_sheet.srw
forward
global type dc_w_sheet from dc_w_base
end type
type dw_visual from dc_uo_dw_base within dc_w_sheet
end type
type gb_aux_visual from groupbox within dc_w_sheet
end type
end forward

global type dc_w_sheet from dc_w_base
integer height = 1608
string menuname = "m_janelas"
dw_visual dw_visual
gb_aux_visual gb_aux_visual
end type
global dc_w_sheet dc_w_sheet

type variables
m_janelas ivm_Menu

Integer MaxWidth = 0
Integer MaxHeight = 0
end variables

forward prototypes
public subroutine wf_setmenu ()
public subroutine wf_setmenu_new ()
public subroutine wf_set_descricao_nao_visual (string ps_coluna)
public subroutine wf_setmenu (powerobject po_control[])
end prototypes

public subroutine wf_setmenu ();wf_setmenu( This.Control )
end subroutine

public subroutine wf_setmenu_new ();Any lva_Tipo

Integer lvi_Upper, &
        lvi_Contador

Tab lvtab_Control

PowerObject lvo_Objeto

// Atualiza o menu da janela
This.ivm_Menu = This.MenuId

lvi_Upper = UpperBound(This.Control)

For lvi_Contador = 1 To lvi_Upper
	lvo_Objeto = This.Control[lvi_Contador]
	
	lva_Tipo = TypeOf(lvo_Objeto)
	
	Choose Case lva_Tipo
		Case DataWindow!
			lvo_Objeto.Dynamic of_SetMenu(This.ivm_Menu)		
		Case Tab!
			lvtab_Control = lvo_Objeto
			lva_Tipo = TypeOf(lvtab_Control.Control[1])
			
	End Choose
Next
end subroutine

public subroutine wf_set_descricao_nao_visual (string ps_coluna);//Verifica se foi alterado de campo ou somente mudou de linha
If ps_coluna <> dw_visual.Object.coluna.Tooltip.Tip Then
	If dw_visual.RowCount() > 0 Then
		//Se alterou de campo seta as propriedades do Bal$$HEX1$$e300$$ENDHEX$$o
		dw_visual.Object.coluna.Tooltip.Title =''
		dw_visual.Object.coluna.Tooltip.Tip= ps_coluna
		dw_visual.Object.coluna [1] = ps_coluna
		//Move o cursos do mouse para cima do campo na datawindow
		gvo_aplicacao.of_set_posicao_mouse(UnitsToPixels(dw_visual.X + 60, XUnitsToPixels!), UnitsToPixels(dw_visual.Y + 560, YUnitsToPixels!))
		Sleep(0.5)
		gvo_aplicacao.of_set_posicao_mouse(UnitsToPixels(dw_visual.X + 60, XUnitsToPixels!), UnitsToPixels(dw_visual.Y + 560, YUnitsToPixels!))
	End If
End If
end subroutine

public subroutine wf_setmenu (powerobject po_control[]);Any lva_Tipo

Integer 	lvi_Contador, &
       		lvi_Contador2

Tab lvtab_Control
UserObject lvo_UserObj
ClassDefinition lvo_Class

PowerObject lvo_Objeto

// Atualiza o menu da janela
This.ivm_Menu = This.MenuId

For lvi_Contador = 1 To UpperBound(po_control)
	lvo_Objeto = po_control[lvi_Contador]
	
	lva_Tipo = TypeOf(lvo_Objeto)
	
	Choose Case lva_Tipo
		Case DataWindow!
			lvo_Class = lvo_Objeto.ClassDefinition
			lvo_Class	 = lvo_Class.Ancestor
			
			If Lower(lvo_Class.LibraryName) <> 'pbvm120.dll' Then
				lvo_Objeto.Dynamic of_SetMenu(This.ivm_Menu)		
			End If
		Case Tab!
			lvtab_Control = lvo_Objeto
			wf_setmenu(lvtab_Control.Control)
		Case UserObject!
			lvo_UserObj = lvo_Objeto
			wf_setmenu(lvo_UserObj.Control)
	End Choose
Next
end subroutine

on dc_w_sheet.create
int iCurrent
call super::create
if this.MenuName = "m_janelas" then this.MenuID = create m_janelas
this.dw_visual=create dw_visual
this.gb_aux_visual=create gb_aux_visual
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_visual
this.Control[iCurrent+2]=this.gb_aux_visual
end on

on dc_w_sheet.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_visual)
destroy(this.gb_aux_visual)
end on

event ue_preopen;call super::ue_preopen;//*********************************************************	//
//   Verifica se foi verificado o acesso aos procedimentos da tela						//
//   caso n$$HEX1$$e300$$ENDHEX$$o tenha sido verificado $$HEX1$$e900$$ENDHEX$$ chamada uma verifica$$HEX2$$e700e300$$ENDHEX$$o de acesso			//
//   para setar o id_permite_incluir, id_permite_alterar e id_permite_excluir		//
//   ao remover o sistema n$$HEX1$$e300$$ENDHEX$$o respeitar$$HEX1$$e100$$ENDHEX$$ as permiss$$HEX1$$f500$$ENDHEX$$es de inclus$$HEX1$$e300$$ENDHEX$$o, 				//
//   altera$$HEX2$$e700e300$$ENDHEX$$o e exclus$$HEX1$$e300$$ENDHEX$$o do procedimento.													//
//*********************************************************	//
If IsValid(gvo_aplicacao) Then
	If gvo_aplicacao.ivo_seguranca.of_get_ultimo_procedimento() <> Upper(This.ClassName( )) Then
		gvo_aplicacao.ivo_seguranca.of_acesso_procedimento(This.ClassName( ))
	End If
End if

wf_SetMenu(This.Control)
end event

event ue_save;call super::ue_save;If AncestorReturnValue = 1 Then
	This.ivm_Menu.mf_Confirmar(False)
	This.ivm_Menu.mf_Cancelar(False)	
End If

Return AncestorReturnValue
end event

event show;call super::show;wf_Verifica_Versao( )
end event

event ue_postopen;call super::ue_postopen;Integer lvl_PxWidth
Integer lvl_PxHeight
Integer lvl_UnWidth
Integer lvl_UnHeight

If (MaxWidth > 0)or(MaxHeight>0) Then
	gvo_aplicacao.of_retorna_resolucao_monitor(lvl_PxWidth,lvl_PxHeight)
	
	lvl_UnWidth	= PixelsToUnits(lvl_PxWidth,XPixelsToUnits!)
	lvl_UnHeight	= PixelsToUnits(lvl_PxHeight,YPixelsToUnits!)
	
	If (lvl_PxWidth <> 800)and(MaxWidth > 0) Then //Diferente da resolu$$HEX2$$e700e300$$ENDHEX$$o 800 x 600 (Padr$$HEX1$$e300$$ENDHEX$$o Loja)
		If lvl_UnWidth >= MaxWidth Then //Maior que tamanho ideal
			This.Width = MaxWidth
		Else 
			This.Width = lvl_UnWidth - 50
		End If
	End If
	
	If (lvl_PxHeight <> 600)and(MaxHeight > 0) Then //Diferente da resolu$$HEX2$$e700e300$$ENDHEX$$o 800 x 600 (Padr$$HEX1$$e300$$ENDHEX$$o Loja)
		If lvl_UnHeight >= MaxHeight Then //Maior que tamanho ideal
			This.Height = MaxHeight
		Else 
			This.Height = lvl_UnHeight - 650
		End If
	End If
End If
end event

event close;call super::close;//Caso o bot$$HEX1$$e300$$ENDHEX$$o de confirmar estiver habilitado no momento do fechamento da tela
// e o sistema estiver utilizando o timer out, o sistema remover$$HEX1$$e100$$ENDHEX$$ a tela da listagem 
// de telas que impedem o fechamento do sistema
If IsValid(ivm_Menu) Then
	If ivm_Menu.m_editar.m_confirmaroperacao.Enabled Then
		If IsValid(gvo_aplicacao) Then
			If gvo_aplicacao.ivb_usa_timer_out Then
				gvo_aplicacao.of_remove_tela(This.Title)
			End If
		End If
	End If
End If
end event

event open;call super::open;Boolean lvb_Habilita = False	

If IsValid( This ) Then // O Close no c$$HEX1$$f300$$ENDHEX$$digo ancestral destoy a tela causando erro nos testes abaixo
	
	// Atualiza as vari$$HEX1$$e100$$ENDHEX$$veis de controle de acesso as fun$$HEX2$$e700f500$$ENDHEX$$es do menu
	If IsValid(gvo_Aplicacao) And IsValid( ivm_Menu ) Then		
		ivm_Menu.ivb_Permite_Incluir	= gvo_Aplicacao.ivo_Seguranca.of_Get_Id_Inclusao( )
		ivm_Menu.ivb_Permite_Alterar	= gvo_Aplicacao.ivo_Seguranca.of_Get_Id_Alteracao( )
		ivm_Menu.ivb_Permite_Excluir	= gvo_Aplicacao.ivo_Seguranca.of_Get_Id_Exclusao( )
		
		// Atualiza o menu da janela para permanecer as fun$$HEX2$$e700f500$$ENDHEX$$es desabilitadas
		// conforme o menu principal
		Choose Case gvo_Aplicacao.ivo_Seguranca.Cd_Sistema
			Case 'RL', 'CL', 'EL', 'VV', 'TL', 'DB', 'BL', 'AU', 'CP', 'AT'
				//SISTEMAS DE LOJA N$$HEX1$$c300$$ENDHEX$$O ATUALIZAR$$HEX1$$c300$$ENDHEX$$O NOVAMENTE O MENU
			Case Else
				gvo_Aplicacao.ivo_Seguranca.of_Habilita_Menu(ivm_Menu)	
		End Choose
		
		//	//////// procedimento HELP ////////
		If Lower( RightA( Trim( gvo_Aplicacao.ivs_Path_Manual ), 3 ) ) = 'chm' Then
			If This.AccessibleName <> '' Then
				lvb_Habilita = True
			End If		
		Else
			lvb_Habilita = True
	//		If FileExists(gvo_Aplicacao.ivs_Path_Manual  + gvo_Aplicacao.ivo_Seguranca.Cd_Sistema +"/" + Trim(This.ClassName())  + ".html") Then
	//			lvb_Habilita = True
	//		End If
		End If
		
		If IsValid(ivm_Menu) Then	
			ivm_Menu.mf_Habilita_Help(lvb_Habilita)
		End If	
		//	//////// procedimento HELP ////////		
	End If
	
	// Comentado por Fernando Cambiaghi em 31/08/2016, pois estava deslocando as telas que estavam com a propriedade [center] marcada
	// Posiciona a janela
	X = 1	
	Y = 1
	
	// Prepara a exibi$$HEX2$$e700e300$$ENDHEX$$o da janela
	This.SetRedraw(False)
	
End If
end event

type dw_visual from dc_uo_dw_base within dc_w_sheet
boolean visible = false
integer x = 73
integer y = 1244
integer width = 1637
integer height = 148
integer taborder = 0
string dataobject = "dw_auxilio_visual"
end type

type gb_aux_visual from groupbox within dc_w_sheet
boolean visible = false
integer x = 37
integer y = 1172
integer width = 1728
integer height = 236
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Aux$$HEX1$$ed00$$ENDHEX$$lio Visual"
end type

