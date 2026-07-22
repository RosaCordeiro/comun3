HA$PBExportHeader$w_selecao_filial_odbc.srw
forward
global type w_selecao_filial_odbc from dc_w_response_ok_cancela
end type
type dw_2 from dc_uo_dw_base within w_selecao_filial_odbc
end type
type gb_2 from groupbox within w_selecao_filial_odbc
end type
end forward

global type w_selecao_filial_odbc from dc_w_response_ok_cancela
integer width = 1723
integer height = 1840
string title = "Sele$$HEX2$$e700e300$$ENDHEX$$o de ODBC"
dw_2 dw_2
gb_2 gb_2
end type
global w_selecao_filial_odbc w_selecao_filial_odbc

type prototypes
FUNCTION integer SQLAllocEnv(ref long henv) LIBRARY "odbc32.dll"
FUNCTION integer SQLFreeEnv(long henv) LIBRARY "odbc32.dll"
FUNCTION integer SQLDataSources &
     (long henv, integer idirection, ref string szdsn, int idsnmax, &
     ref integer idsn, ref string szdesc, integer idescmax, ref integer idesc) &
    library "odbc32.dll" alias for "SQLDataSources;Ansi" 
end prototypes

type variables
String is_Lista_ODBC_From
end variables

forward prototypes
public subroutine wf_lista_odbc ()
end prototypes

public subroutine wf_lista_odbc ();Long ll_henv
Long lvl_Linha_Nova
Long ll_Achou
Long ll_Filial_ODBC

String ls_dsn
String ls_desc
String ls_nova
String ls_Filtro
String ls_Fantasia

Integer li_direction
Integer li_dsnmax
Integer li_dsnlen
Integer li_descmax
Integer li_desclen
Integer li_rc
integer li_length = 255

SetRedRaw(False)

ls_dsn     = Space(li_length)
li_dsnmax  = li_length
ls_desc    = Space(li_length)
li_descmax = li_length

If SQLAllocEnv(ll_henv) = -1 Then
    MessageBox("SQLAllocEnv", "FALHOU")
Else
    li_direction = 1
    Do While SQLDataSources &
        (ll_henv, li_direction, ls_dsn, li_dsnmax, li_dsnlen, &
         ls_desc, li_descmax, li_desclen) = 0
			
		ls_Nova = LeftA(ls_Desc, 24)
		
		If (ls_Nova = "Adaptive Server Anywhere")or(Upper(ls_Nova) = "POSTGRESQL UNICODE") Then
			
			ll_Achou = dw_1.Find( "cd_filial = " + String( Long( LeftA( ls_dsn, 4 ) ) ), 1, dw_1.rowCount() )
			
			If ll_Achou > 0 Then Continue
			
			lvl_Linha_Nova = dw_1.InsertRow(0)
			
			ll_Filial_ODBC	= Long( LeftA( ls_dsn, 4 ) )
			ls_Fantasia		= Upper( MidA( ls_dsn, 6 ) )
			
			If Trim( ls_Fantasia ) = "" Then SetNull( ls_Fantasia )
			
			dw_1.Object.Cd_Filial			[lvl_Linha_Nova] = ll_Filial_ODBC
			dw_1.Object.Nm_Fantasia	[lvl_Linha_Nova] = ls_Fantasia
			dw_1.Object.Id_Filial			[lvl_Linha_Nova] = 'N'
			dw_1.Object.Nm_Odbc		[lvl_Linha_Nova] = Upper( ls_dsn )
		End If
	Loop
	
   SQLFreeEnv(ll_henv)
End If

If IsNull( dw_1.Object.cd_Filial[ 1 ] ) Then dw_1.DeleteRow( 1 )

dw_2.AcceptText( )

ls_Filtro = Trim( dw_2.Object.de_Filtro[1] )

If ls_Filtro <> "" And Not IsNull( ls_Filtro ) Then
	ls_Filtro = "((string(cd_filial) like '"+dw_2.Object.de_Filtro[1]+"%') or (nm_fantasia like '%"+dw_2.Object.de_Filtro[1]+"%'))"
	
	dw_1.setFilter( ls_Filtro )
	dw_1.filter( )
End If

dw_1.Sort()

SetRedRaw(True)
end subroutine

on w_selecao_filial_odbc.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.gb_2
end on

on w_selecao_filial_odbc.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.gb_2)
end on

event ue_postopen;call super::ue_postopen;Try
	uo_parametro_pdv lo_parm
	lo_parm = Create uo_parametro_pdv
	This.is_Lista_ODBC_From = lo_parm.of_Get_Lista_Odbc_From( )
	
Catch( RuntimeError ru )
	MessageBox( "RuntimeError", ru.getMessage( ), StopSign! )
	This.is_Lista_ODBC_From = 'SO'
Finally
	
	Destroy lo_parm
End Try

dw_2.Event ue_AddRow()
dw_1.Event ue_Retrieve()
dw_2.SetFocus()
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

event close;// OverRide

If SqlCa.of_IsConnected() Then
	SqlCa.of_Disconnect()
End If
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_selecao_filial_odbc
integer x = 1563
integer y = 8
integer taborder = 0
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_selecao_filial_odbc
integer y = 236
integer width = 1641
integer height = 1360
integer taborder = 0
integer weight = 700
string facename = "Verdana"
string text = "Lista"
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_selecao_filial_odbc
integer y = 300
integer width = 1582
integer height = 1276
integer taborder = 20
string dataobject = "dw_lista_filiais_odbc"
boolean vscrollbar = true
boolean ivb_ordena_colunas = true
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

event dw_1::ue_recuperar;// OverRide
Long ll_Linha
Long ll_Find

Try
	Open( w_Aguarde )
	
	If Parent.is_Lista_ODBC_From <> 'SO' Then
		w_Aguarde.Title = "Obtendo lista de filial do par$$HEX1$$e200$$ENDHEX$$metro odbc..."
		This.Retrieve( )
	End If

	w_Aguarde.Title = "Obtendo lista de ODBC's do Sistema Operacional..."
	wf_Lista_Odbc( )
	
	dc_uo_ds_base lds_1
	lds_1 = create dc_uo_ds_base
	lds_1.of_changedataobject( 'dw_lista_filiais_odbc' )
	lds_1.Retrieve( )
	
	For ll_Linha = 1 To dw_1.RowCount( )
		If IsNull( dw_1.Object.Nm_Fantasia[ ll_Linha ] ) Then
			ll_Find = lds_1.Find( "cd_filial = " + String( dw_1.Object.Cd_Filial[ ll_Linha ] ), 1, lds_1.RowCount( ) )
			
			If ll_Find > 0 Then
				dw_1.Object.Nm_Fantasia[ ll_Linha ] = lds_1.Object.Nm_Fantasia[ ll_Find ]
			End If
		End If
	Next
	
	destroy lds_1
	
	Return This.rowCount( )
Finally
	If IsValid( w_Aguarde ) Then Close( w_Aguarde )
End Try
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_selecao_filial_odbc
integer x = 1038
integer y = 1620
integer taborder = 30
end type

event cb_ok::clicked;call super::clicked;Long ll_Linha
Long ll_Filial

String ls_Odbc

dw_1.AcceptText()

ll_Linha	= dw_1.GetRow()
If ll_Linha > 0 Then

	ll_Filial	= dw_1.Object.Cd_Filial[ ll_Linha ]
	
	If dw_1.Object.Id_Filial[ll_Linha] = 'S' Then
		ls_Odbc = RightA( '0000' + String( ll_Filial ), 4 )
		
		dc_uo_odbc lo_Odbc
		lo_Odbc = Create dc_uo_odbc
		lo_Odbc.of_Atualiza_Odbcs( RightA( '0000' + String( ll_Filial ), 4 ) )
		Destroy lo_Odbc
	Else
		ls_Odbc	= dw_1.Object.Nm_Odbc[ ll_Linha ]
	End If
	
	CloseWithReturn( Parent, ls_Odbc )
Else
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Selecione um conex$$HEX1$$e300$$ENDHEX$$o ou clique em cancelar.',Exclamation!)
End If
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_selecao_filial_odbc
integer x = 1371
integer y = 1620
integer taborder = 40
end type

type dw_2 from dc_uo_dw_base within w_selecao_filial_odbc
integer x = 59
integer y = 96
integer width = 1573
integer height = 104
boolean bringtotop = true
string dataobject = "dw_filtro"
end type

event editchanged;call super::editchanged;String ls_Filtro
	
ls_Filtro = "((string(cd_filial) like '"+data+"%') or (nm_fantasia like '%"+data+"%'))"

dw_1.setFilter( ls_Filtro )
dw_1.filter( )
end event

event ue_key;call super::ue_key;If Key = KeyEnter! Then
	cb_Ok.Event Clicked()
End If
end event

type gb_2 from groupbox within w_selecao_filial_odbc
integer x = 27
integer y = 20
integer width = 1637
integer height = 208
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Filtro"
end type

