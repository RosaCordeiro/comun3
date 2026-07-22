HA$PBExportHeader$dc_w_mdi.srw
forward
global type dc_w_mdi from dc_w_base
end type
type mdi_1 from mdiclient within dc_w_mdi
end type
end forward

global type dc_w_mdi from dc_w_base
string menuname = "m_mdi"
boolean maxbox = true
windowtype windowtype = mdihelp!
windowstate windowstate = maximized!
mdi_1 mdi_1
end type
global dc_w_mdi dc_w_mdi

forward prototypes
public subroutine wf_inicia_at ()
end prototypes

public subroutine wf_inicia_at ();If gvo_Aplicacao.ivo_Seguranca.cd_Sistema <> 'RL' Then Return

// Executa apenas no Servidor de Banco de Dados e Servidor de Comunica$$HEX2$$e700e300$$ENDHEX$$o
If ( Not gf_Is_DataBase_Server( ) ) And ( Not gf_Is_Communication_Server( ) ) Then Return

DateTime ldh_Arquivo
DateTime ldh_Servidor

Long ll_Read

Integer li_File

String ls_Arquivo
String ls_Texto

If Not DirectoryExists( "C:\Sistemas\At" ) Then	Return

ls_Arquivo = 'c:\sistemas\verifica_agendador'

dc_uo_Api lo_Api
lo_Api = Create dc_uo_Api
ldh_Arquivo	= lo_Api.of_Data_Arquivo( ls_Arquivo + '.log' )
Destroy lo_Api

ldh_Servidor = gf_GetServerDate()

If DaysAfter( Date( ldh_Servidor ), Date( ldh_Arquivo ) ) = 0 Then
	If SecondsAfter( Time( ldh_Arquivo ), Time( ldh_Servidor ) ) < 300 Then
		Return
	End If
End If

li_File = FileOpen( ls_Arquivo + '.bat', LineMode!, Write!, Shared!, Replace! )
FileWrite( li_File, 'tasklist -FI "IMAGENAME eq at.exe" > ' + ls_Arquivo + '.log' )
FileClose( li_File )

gf_run( ls_Arquivo + '.bat', 2 )

li_File = FileOpen( ls_Arquivo + '.log', LineMode!, Read!, Shared! )

ll_Read = FileRead( li_File, ls_Texto )

Do While ll_Read >= 0
	If PosA( Upper( ls_Texto ), 'AT.EXE' ) > 0 Then
		FileClose( li_File )
		Return
	End If
	
	ll_Read = FileRead( li_File, ls_Texto )
Loop

Run( "c:\sistemas\vv\exe\vv.exe AT" )
end subroutine

on dc_w_mdi.create
int iCurrent
call super::create
if this.MenuName = "m_mdi" then this.MenuID = create m_mdi
this.mdi_1=create mdi_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.mdi_1
end on

on dc_w_mdi.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.mdi_1)
end on

event open;call super::open;This.Title = gvo_Aplicacao.iapp_Aplicacao.DisplayName
	
This.SetMicroHelp(gvo_Aplicacao.iapp_Aplicacao.MicroHelpDefault)

/* Biometria */
m_Mdi.mf_Habilita_Biometria( )			
/* Biometria */

wf_Inicia_At( ) // No RL, verifica se o AT est$$HEX1$$e100$$ENDHEX$$ no ar e caso n$$HEX1$$e300$$ENDHEX$$o esteja, coloca
Timer(300)


end event

event ue_open;call super::ue_open;String lvs_Sheet
dc_w_Sheet lvw_Sheet

lvs_Sheet = Message.StringParm
OpenSheet(lvw_Sheet, lvs_Sheet, This, 0, Original!)
end event

event ue_postopen;call super::ue_postopen;SqlCa.of_End_Transaction( )
end event

event timer;call super::timer;wf_Inicia_At( ) // No RL, verifica se o AT est$$HEX1$$e100$$ENDHEX$$ no ar e caso n$$HEX1$$e300$$ENDHEX$$o esteja, coloca
end event

type mdi_1 from mdiclient within dc_w_mdi
long BackColor=276856960
end type

