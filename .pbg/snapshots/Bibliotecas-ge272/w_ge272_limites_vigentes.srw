HA$PBExportHeader$w_ge272_limites_vigentes.srw
forward
global type w_ge272_limites_vigentes from dc_w_response
end type
type dw_2 from dc_uo_dw_base within w_ge272_limites_vigentes
end type
type cb_1 from commandbutton within w_ge272_limites_vigentes
end type
type dw_1 from dc_uo_dw_base within w_ge272_limites_vigentes
end type
type gb_1 from groupbox within w_ge272_limites_vigentes
end type
type gb_2 from groupbox within w_ge272_limites_vigentes
end type
end forward

global type w_ge272_limites_vigentes from dc_w_response
integer width = 1719
integer height = 1564
string title = "GE272 - Consulta Limites Vigentes"
dw_2 dw_2
cb_1 cb_1
dw_1 dw_1
gb_1 gb_1
gb_2 gb_2
end type
global w_ge272_limites_vigentes w_ge272_limites_vigentes

type variables
Date ivdt_Calculo

DataWindowChild	idwc_Rede
end variables

forward prototypes
public subroutine wf_insere_default ()
end prototypes

public subroutine wf_insere_default ();/* Rede Filial */
idwc_Rede  = dw_1.of_InsertRow_DDDW("id_rede" )			

idwc_Rede.SetItem(1, "vl_parametro", 'TD'	)
idwc_Rede.SetItem(1, "rede", "TODAS"	)
end subroutine

event activate;call super::activate;pb_help.Visible = False
end event

on w_ge272_limites_vigentes.create
int iCurrent
call super::create
this.dw_2=create dw_2
this.cb_1=create cb_1
this.dw_1=create dw_1
this.gb_1=create gb_1
this.gb_2=create gb_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_2
this.Control[iCurrent+2]=this.cb_1
this.Control[iCurrent+3]=this.dw_1
this.Control[iCurrent+4]=this.gb_1
this.Control[iCurrent+5]=this.gb_2
end on

on w_ge272_limites_vigentes.destroy
call super::destroy
destroy(this.dw_2)
destroy(this.cb_1)
destroy(this.dw_1)
destroy(this.gb_1)
destroy(this.gb_2)
end on

event ue_postopen;call super::ue_postopen;String lvs_Parametro
String lvs_Data
String lvs_Rede

Date lvdt_Data

dw_1.Event ue_AddRow()
wf_insere_default()

lvs_Parametro = Message.StringParm

lvs_Rede = Mid(lvs_Parametro,1,Pos(lvs_Parametro,';') - 1)
lvs_Data 	= Mid(lvs_Parametro,Pos(lvs_Parametro,';') + 1)

If IsDate(lvs_Data) then
	lvdt_Data = Date(lvs_Data)
Else
	lvdt_Data = Today()
End If

ivdt_Calculo = lvdt_Data
dw_1.Object.id_rede [1] = lvs_Rede

dw_2.Event ue_retrieve()
end event

type pb_help from dc_w_response`pb_help within w_ge272_limites_vigentes
boolean visible = false
integer x = 1755
integer y = 48
end type

type dw_2 from dc_uo_dw_base within w_ge272_limites_vigentes
integer x = 55
integer y = 256
integer width = 1618
integer height = 1060
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge272_limites_vigentes"
boolean ivb_ordena_colunas = true
end type

event ue_preretrieve;call super::ue_preretrieve;String lvs_Rede

dw_1.Accepttext( )
lvs_Rede = dw_1.Object.id_rede [1]

If lvs_Rede <> 'TD' then
	This.of_appendwhere("p.id_rede='"+lvs_Rede+"'")
End if

Return AncestorReturnValue
end event

event ue_recuperar;//override
Return This.Retrieve(ivdt_Calculo)
end event

type cb_1 from commandbutton within w_ge272_limites_vigentes
integer x = 1271
integer y = 1356
integer width = 402
integer height = 92
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "OK"
boolean default = true
end type

event clicked;Close(Parent)
end event

type dw_1 from dc_uo_dw_base within w_ge272_limites_vigentes
integer x = 59
integer y = 84
integer width = 1211
integer height = 92
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge272_selecao_limites"
end type

event itemchanged;call super::itemchanged;dw_2.Event ue_Retrieve()
end event

type gb_1 from groupbox within w_ge272_limites_vigentes
integer x = 27
integer y = 208
integer width = 1641
integer height = 1132
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista"
end type

type gb_2 from groupbox within w_ge272_limites_vigentes
integer x = 32
integer y = 16
integer width = 1285
integer height = 180
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
end type

