HA$PBExportHeader$w_selecao_bd.srw
forward
global type w_selecao_bd from dc_w_response_ok_cancela
end type
end forward

global type w_selecao_bd from dc_w_response_ok_cancela
integer width = 1723
integer height = 896
string title = "Sele$$HEX2$$e700e300$$ENDHEX$$o de Banco de Dados"
boolean center = true
end type
global w_selecao_bd w_selecao_bd

type prototypes
FUNCTION integer SQLAllocEnv(ref long henv) LIBRARY "odbc32.dll"
FUNCTION integer SQLFreeEnv(long henv) LIBRARY "odbc32.dll"
FUNCTION integer SQLDataSources &
     (long henv, integer idirection, ref string szdsn, int idsnmax, &
     ref integer idsn, ref string szdesc, integer idescmax, ref integer idesc) &
    library "odbc32.dll" alias for "SQLDataSources;Ansi" 
end prototypes

on w_selecao_bd.create
call super::create
end on

on w_selecao_bd.destroy
call super::destroy
end on

event ue_postopen;call super::ue_postopen;dw_1.Event ue_Retrieve()
Dw_1.SetFocus()
end event

event ue_preopen;call super::ue_preopen;String ls_Ini
String ls_DataBase
String ls_DataSource
String ls_HostName

ls_Ini = "c:\sistemas\vv\exe\verifica_versao.ini"

// Usa a conex$$HEX1$$e300$$ENDHEX$$o do VV para listar as filiais
ls_DataBase	= ProfileString( ls_Ini, 'Database', "DataBase", "" )
ls_DataSource	= ProfileString( ls_Ini, 'Database', "DataSource", "" )

SqlCa.of_SetDataBase( ls_DataBase )

If Not SqlCa.of_Connect(ls_DataSource, ls_HostName) Then
	This.cb_Cancelar.Event Clicked()
Else
	dw_1.of_SetTransObject( SqlCa )
End If
end event

event close;call super::close;If SqlCa.of_IsConnected() Then
	SqlCa.of_Disconnect()
End If
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_selecao_bd
integer taborder = 0
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_selecao_bd
integer width = 1641
integer height = 628
integer taborder = 0
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_selecao_bd
integer width = 1582
integer height = 544
integer taborder = 10
string dataobject = "dw_lista_bd"
boolean vscrollbar = true
end type

event dw_1::constructor;call super::constructor;This.of_SetRowSelection()

This.ivb_Ordena_Colunas = True
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	cb_Ok.Event Clicked()
End If
end event

event dw_1::doubleclicked;call super::doubleclicked;cb_ok.event clicked( )
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_selecao_bd
integer x = 1038
integer y = 672
end type

event cb_ok::clicked;call super::clicked;Long lvl_Linha

String lvs_BD

dw_1.AcceptText()

lvl_Linha	= dw_1.GetRow()
lvs_BD	= dw_1.Object.cd_base [ lvl_Linha ]

CloseWithReturn( Parent, lvs_BD )
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_selecao_bd
integer x = 1371
integer y = 672
end type

