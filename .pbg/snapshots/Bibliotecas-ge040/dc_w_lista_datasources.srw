HA$PBExportHeader$dc_w_lista_datasources.srw
forward
global type dc_w_lista_datasources from Window
end type
type cb_2 from commandbutton within dc_w_lista_datasources
end type
type cb_1 from commandbutton within dc_w_lista_datasources
end type
type ddlb_datasource from dropdownlistbox within dc_w_lista_datasources
end type
type st_1 from statictext within dc_w_lista_datasources
end type
type gb_1 from groupbox within dc_w_lista_datasources
end type
end forward

global type dc_w_lista_datasources from Window
int X=1454
int Y=1316
int Width=1847
int Height=384
long BackColor=80269524
WindowType WindowType=response!
cb_2 cb_2
cb_1 cb_1
ddlb_datasource ddlb_datasource
st_1 st_1
gb_1 gb_1
end type
global dc_w_lista_datasources dc_w_lista_datasources

type prototypes
FUNCTION integer SQLAllocEnv(ref long henv) LIBRARY "odbc32.dll"
FUNCTION integer SQLFreeEnv(long henv) LIBRARY "odbc32.dll"
FUNCTION integer SQLDataSources &
     (long henv, integer idirection, ref string szdsn, int idsnmax, &
     ref integer idsn, ref string szdesc, integer idescmax, ref integer idesc) &
    library "odbc32.dll" alias for "SQLDataSources;Ansi" 
Function boolean GetUserNameA( ref string userID, ref ulong len ) library "ADVAPI32.DLL" alias for "GetUserNameA;Ansi"

end prototypes

type variables
String ivs_DataSource
end variables

on dc_w_lista_datasources.create
this.cb_2=create cb_2
this.cb_1=create cb_1
this.ddlb_datasource=create ddlb_datasource
this.st_1=create st_1
this.gb_1=create gb_1
this.Control[]={this.cb_2,&
this.cb_1,&
this.ddlb_datasource,&
this.st_1,&
this.gb_1}
end on

on dc_w_lista_datasources.destroy
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.ddlb_datasource)
destroy(this.st_1)
destroy(this.gb_1)
end on

type cb_2 from commandbutton within dc_w_lista_datasources
int X=370
int Y=200
int Width=293
int Height=108
int TabOrder=30
string Text="&Cancelar"
int TextSize=-8
int Weight=700
string FaceName="Verdana"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;String lvs_Retorno

SetNull(lvs_Retorno)
CloseWithReturn(Parent, lvs_Retorno)
end event

type cb_1 from commandbutton within dc_w_lista_datasources
int X=59
int Y=200
int Width=293
int Height=108
int TabOrder=20
string Text="&Alterar"
int TextSize=-8
int Weight=700
string FaceName="Verdana"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event clicked;CloseWithReturn(Parent, ivs_DataSource)
end event

type ddlb_datasource from dropdownlistbox within dc_w_lista_datasources
int X=457
int Y=92
int Width=1303
int Height=572
int TabOrder=10
BorderStyle BorderStyle=StyleLowered!
boolean VScrollBar=true
long TextColor=33554432
int TextSize=-8
int Weight=400
string FaceName="Verdana"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

event constructor;long ll_henv
string ls_dsn, ls_desc
integer li_direction, li_dsnmax, li_dsnlen, li_descmax, li_desclen, li_rc
integer li_length = 255

ls_dsn = Space(li_length)
li_dsnmax = li_length
ls_desc = Space(li_length)
li_descmax = li_length

IF SQLAllocEnv(ll_henv) = -1 THEN
    MessageBox("SQLAllocEnv", "FALHOU")
ELSE
    li_direction = 1
    DO WHILE SQLDataSources &
        (ll_henv, li_direction, ls_dsn, li_dsnmax, li_dsnlen, &
         ls_desc, li_descmax, li_desclen) = 0
         ddlb_datasource.AddItem(ls_dsn)
    LOOP
    SQLFreeEnv(ll_henv)
END IF
end event

event selectionchanged;ivs_DataSource = This.Text
end event

type st_1 from statictext within dc_w_lista_datasources
int X=59
int Y=92
int Width=398
int Height=76
boolean Enabled=false
string Text="DataSource :"
boolean FocusRectangle=false
long TextColor=8388608
long BackColor=80269524
int TextSize=-8
int Weight=700
string FaceName="Verdana"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

type gb_1 from groupbox within dc_w_lista_datasources
int X=18
int Y=4
int Width=1787
int Height=348
int TabOrder=40
string Text="Informe a filial para acesso"
BorderStyle BorderStyle=StyleRaised!
long TextColor=8388608
long BackColor=80269524
int TextSize=-8
int Weight=700
string FaceName="Verdana"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

