HA$PBExportHeader$w_ge387_consulta_colaborador_rh.srw
forward
global type w_ge387_consulta_colaborador_rh from dc_w_selecao_lista_relatorio
end type
type dw_4 from dc_uo_dw_base within w_ge387_consulta_colaborador_rh
end type
type gb_3 from groupbox within w_ge387_consulta_colaborador_rh
end type
end forward

global type w_ge387_consulta_colaborador_rh from dc_w_selecao_lista_relatorio
string accessiblename = "Consulta Informa$$HEX2$$e700f500$$ENDHEX$$es de Colaborador no RH (GF010)"
integer width = 2807
integer height = 852
string title = "GE387 - Consulta Informa$$HEX2$$e700f500$$ENDHEX$$es de Colaborador no RH"
boolean resizable = false
dw_4 dw_4
gb_3 gb_3
end type
global w_ge387_consulta_colaborador_rh w_ge387_consulta_colaborador_rh

type variables
uo_Usuario	io_Usuario /// GE010

dc_uo_transacao RUBI
end variables

on w_ge387_consulta_colaborador_rh.create
int iCurrent
call super::create
this.dw_4=create dw_4
this.gb_3=create gb_3
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_4
this.Control[iCurrent+2]=this.gb_3
end on

on w_ge387_consulta_colaborador_rh.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_4)
destroy(this.gb_3)
end on

event ue_postopen;call super::ue_postopen;io_Usuario = Create uo_Usuario
io_Usuario.of_Todos_Usuarios( )

Rubi = Create dc_uo_transacao

Rubi.ivs_DataBase = 'ORACLE_RH'

If Not Rubi.of_Connect( 'vetorh_ti' , gvo_Aplicacao.ivo_Seguranca.Cd_Sistema + "_" + gvo_Aplicacao.of_ComputerName( ) ) Then
	Destroy Rubi
	Close( This )
End If
end event

event close;call super::close;If IsValid( RUBI ) Then Destroy RUBI
If IsValid( io_Usuario ) Then Destroy io_Usuario
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge387_consulta_colaborador_rh
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge387_consulta_colaborador_rh
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge387_consulta_colaborador_rh
integer x = 27
integer y = 224
integer width = 1349
integer height = 440
integer weight = 700
string text = "Situa$$HEX2$$e700e300$$ENDHEX$$o no RH"
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge387_consulta_colaborador_rh
integer x = 27
integer width = 1970
integer height = 180
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge387_consulta_colaborador_rh
integer x = 59
integer width = 1915
integer height = 76
string dataobject = "dw_ge387_selecao"
end type

event dw_1::ue_key;call super::ue_key;String ls_Coluna

ls_Coluna = This.GetColumnName()

If Key = KeyEnter! Then
	
	Choose Case ls_Coluna
		Case "nm_usuario"
			io_Usuario.of_Localiza_Usuario( This.GetText( ) )
			
			If Not io_Usuario.Localizado Then
				io_Usuario.of_Inicializa( )
			Else
				dw_2.Post Event ue_Retrieve()
			End If
			
			This.Object.Nm_Usuario	[1] = io_Usuario.Nm_Usuario
			This.Object.Nr_Matricula	[1] = io_Usuario.Nr_Matricula
			
	End Choose
End If
end event

event dw_1::itemchanged;call super::itemchanged;String ls_Nulo

SetNull( ls_Nulo )

Choose Case dwo.Name
	Case 'nm_usuario'
		dw_1.Object.Nr_Matricula[ 1 ] = ls_Nulo
		
End Choose

end event

event dw_1::losefocus;call super::losefocus;If IsValid( io_Usuario ) Then
	If io_Usuario.Nr_Matricula <> This.Object.Nr_Matricula[ 1 ] Then
		This.Object.Nm_Usuario	[ 1 ] = io_Usuario.Nm_Usuario
		This.Object.Nr_Matricula	[ 1 ] = io_Usuario.Nr_Matricula
	End If
End If
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge387_consulta_colaborador_rh
integer x = 59
integer y = 316
integer width = 1298
integer height = 324
string dataobject = "dw_ge387_lista"
boolean vscrollbar = false
boolean livescroll = false
end type

event dw_2::ue_recuperar;// OverRide
This.of_SetTransObject( RUBI )

Return This.Retrieve( io_Usuario.Nr_Matricula )
end event

event dw_2::constructor;// OverRide

ivo_Controle_Menu = Create dc_uo_Menu_DW

ivo_Controle_Menu.of_SetDW(This)

SetNull(ivm_Menu)

This.of_GetParentWindow()
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;dw_4.Event ue_Retrieve()

Return AncestorReturnValue
end event

event dw_2::ue_reset;call super::ue_reset;dw_4.Event ue_reset()
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge387_consulta_colaborador_rh
integer x = 2523
integer y = 36
integer width = 494
integer height = 100
end type

type dw_4 from dc_uo_dw_base within w_ge387_consulta_colaborador_rh
integer x = 1426
integer y = 300
integer width = 1317
integer height = 324
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge387_sybase"
end type

event ue_recuperar;// OverRide
Return This.Retrieve( io_Usuario.Nr_Matricula )
end event

type gb_3 from groupbox within w_ge387_consulta_colaborador_rh
integer x = 1408
integer y = 224
integer width = 1349
integer height = 440
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Situa$$HEX2$$e700e300$$ENDHEX$$o Matriz"
end type

