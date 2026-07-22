HA$PBExportHeader$w_consulta_desconto_regionalizado.srw
forward
global type w_consulta_desconto_regionalizado from w_1dw_consulta_lista
end type
type gb_1 from groupbox within w_consulta_desconto_regionalizado
end type
end forward

global type w_consulta_desconto_regionalizado from w_1dw_consulta_lista
int Width=3333
int Height=1876
boolean TitleBar=true
string Title="GE043 - Consulta de Descontos Regionalizados"
gb_1 gb_1
end type
global w_consulta_desconto_regionalizado w_consulta_desconto_regionalizado

on w_consulta_desconto_regionalizado.create
int iCurrent
call super::create
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_1
end on

on w_consulta_desconto_regionalizado.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.gb_1)
end on

event open;call super::open;ivb_Impressao = True
end event

type dw_1 from w_1dw_consulta_lista`dw_1 within w_consulta_desconto_regionalizado
int X=73
int Y=64
int Width=3200
int Height=1604
boolean BringToTop=true
string DataObject="dw_lista_desconto_regionalizado"
end type

event dw_1::recuperar;//
LONG 		lvl_linha, lvl_cd_filial
STRING	lvs_datahoje
//
lvl_cd_filial = gvo_parametro.of_filial()
lvs_datahoje  = STRING(Today(), "YYYYMMDD")	
//
lvl_linha     = This.retrieve(lvl_cd_filial, lvs_datahoje)
//
THIS.ShareData(dw_2)
//
Return lvl_Linha
end event

event dw_1::constructor;//Override
call super::constructor;// Desabilita o Update da DW
ib_IsUpdateAble = False

// Habilita a fun$$HEX2$$e700e300$$ENDHEX$$o de sele$$HEX2$$e700e300$$ENDHEX$$o de linhas
of_SetRowSelect(True)

end event

type dw_2 from w_1dw_consulta_lista`dw_2 within w_consulta_desconto_regionalizado
int X=41
int Y=1432
int Width=1618
int TabOrder=30
boolean Visible=false
boolean BringToTop=true
string DataObject="dw_relatorio_desconto_regionalizado"
end type

type gb_1 from groupbox within w_consulta_desconto_regionalizado
int X=37
int Width=3255
int Height=1696
int TabOrder=20
string Text="Lista"
BorderStyle BorderStyle=StyleRaised!
long TextColor=8388608
long BackColor=67108864
int TextSize=-8
int Weight=400
string FaceName="Arial"
FontCharSet FontCharSet=Ansi!
FontFamily FontFamily=Swiss!
FontPitch FontPitch=Variable!
end type

