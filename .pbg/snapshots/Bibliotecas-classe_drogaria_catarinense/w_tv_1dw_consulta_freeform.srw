HA$PBExportHeader$w_tv_1dw_consulta_freeform.srw
forward
global type w_tv_1dw_consulta_freeform from w_sheet
end type
type dw_1 from u_dw within w_tv_1dw_consulta_freeform
end type
type tv_1 from u_tvs within w_tv_1dw_consulta_freeform
end type
end forward

global type w_tv_1dw_consulta_freeform from w_sheet
int Width=2743
int Height=1588
dw_1 dw_1
tv_1 tv_1
end type
global w_tv_1dw_consulta_freeform w_tv_1dw_consulta_freeform

type variables

end variables

on w_tv_1dw_consulta_freeform.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.tv_1=create tv_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.tv_1
end on

on w_tv_1dw_consulta_freeform.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.dw_1)
destroy(this.tv_1)
end on

type dw_1 from u_dw within w_tv_1dw_consulta_freeform
int X=1024
int Y=12
int Width=1678
int Height=1388
int TabOrder=11
boolean BringToTop=true
BorderStyle BorderStyle=StyleRaised!
boolean VScrollBar=false
end type

event constructor;call super::constructor;// Desabilita o Update da DW
ib_IsUpdateAble = False
end event

event pfc_retrieve;call super::pfc_retrieve;Long lvl_Linhas

// Recupera as linhas conforme a linha selecionada na TreeView
lvl_Linhas = This.Event Recuperar()

Return lvl_Linhas
end event

type tv_1 from u_tvs within w_tv_1dw_consulta_freeform
int X=9
int Y=12
int Width=997
int Height=1388
int TabOrder=11
boolean BringToTop=true
BorderStyle BorderStyle=StyleRaised!
long PictureMaskColor=79741120
long TextColor=8388608
long BackColor=16777215
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
end type

event selectionchanged;call super::selectionchanged;// Recupera as linhas da DW
// conforme a linha selecionada na TreeView
dw_1.Event pfc_Retrieve()
end event

