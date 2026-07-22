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


end event

event ue_open;call super::ue_open;String lvs_Sheet
dc_w_Sheet lvw_Sheet

lvs_Sheet = Message.StringParm
OpenSheet(lvw_Sheet, lvs_Sheet, This, 0, Original!)
end event

event ue_postopen;call super::ue_postopen;SqlCa.of_End_Transaction( )
end event

type mdi_1 from mdiclient within dc_w_mdi
long BackColor=276856960
end type

