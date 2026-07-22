HA$PBExportHeader$w_ge062_mapa_pendente.srw
forward
global type w_ge062_mapa_pendente from dc_w_consulta_lista
end type
type cb_1 from commandbutton within w_ge062_mapa_pendente
end type
end forward

global type w_ge062_mapa_pendente from dc_w_consulta_lista
boolean visible = false
integer x = 1120
integer y = 772
integer width = 2450
integer height = 1528
string title = "GE062 - Consulta Mapas Pendentes"
string menuname = ""
boolean minbox = false
boolean resizable = false
windowtype windowtype = response!
long backcolor = 80269524
cb_1 cb_1
end type
global w_ge062_mapa_pendente w_ge062_mapa_pendente

on w_ge062_mapa_pendente.create
int iCurrent
call super::create
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_1
end on

on w_ge062_mapa_pendente.destroy
call super::destroy
destroy(this.cb_1)
end on

event open;call super::open;//Override

SetPointer(HourGlass!)

String ls_Parm

Date lvdt_Inicial,&
     lvdt_final
	  
ls_Parm = Message.StringParm

lvdt_Inicial = Date(MidA(ls_Parm,01,10))
lvdt_final   = Date(MidA(ls_Parm,12,10))

dw_1.Retrieve(lvdt_Inicial,lvdt_final)

If dw_1.RowCount() = 0 Then 
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o existem Mapas pendentes no per$$HEX1$$ed00$$ENDHEX$$odo consultado.")
	Close(This)
Else
	This.Visible = True
End If	
end event

event ue_postopen;//OverRide
end event

event ue_preopen;//override
If gvo_Parametro.cd_filial <> gvo_Parametro.cd_filial_Matriz Then 
	dw_1.Of_Changedataobject("dw_ge062_mapa_pendente_filial")
End If
end event

type dw_1 from dc_w_consulta_lista`dw_1 within w_ge062_mapa_pendente
integer x = 69
integer y = 68
integer width = 2281
integer height = 1192
string dataobject = "dw_ge062_mapa_pendente"
boolean ivb_ordena_colunas = true
end type

event dw_1::constructor;call super::constructor;This.ivb_Ordena_Colunas = True
This.ivb_Selecao_Linhas = False
This.Of_SetRowSelection()
end event

type gb_1 from dc_w_consulta_lista`gb_1 within w_ge062_mapa_pendente
integer width = 2359
end type

type cb_1 from commandbutton within w_ge062_mapa_pendente
integer x = 2025
integer y = 1308
integer width = 370
integer height = 100
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "&Fechar"
boolean cancel = true
end type

event clicked;Close(Parent)
end event

