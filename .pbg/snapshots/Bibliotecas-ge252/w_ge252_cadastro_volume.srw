HA$PBExportHeader$w_ge252_cadastro_volume.srw
forward
global type w_ge252_cadastro_volume from dc_w_response
end type
type dw_1 from dc_uo_dw_base within w_ge252_cadastro_volume
end type
type cb_2 from commandbutton within w_ge252_cadastro_volume
end type
type cb_1 from commandbutton within w_ge252_cadastro_volume
end type
type gb_1 from groupbox within w_ge252_cadastro_volume
end type
end forward

global type w_ge252_cadastro_volume from dc_w_response
integer width = 864
integer height = 428
string title = "GE252 - Cadastro de Volume"
boolean controlmenu = false
dw_1 dw_1
cb_2 cb_2
cb_1 cb_1
gb_1 gb_1
end type
global w_ge252_cadastro_volume w_ge252_cadastro_volume

on w_ge252_cadastro_volume.create
int iCurrent
call super::create
this.dw_1=create dw_1
this.cb_2=create cb_2
this.cb_1=create cb_1
this.gb_1=create gb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.dw_1
this.Control[iCurrent+2]=this.cb_2
this.Control[iCurrent+3]=this.cb_1
this.Control[iCurrent+4]=this.gb_1
end on

on w_ge252_cadastro_volume.destroy
call super::destroy
destroy(this.dw_1)
destroy(this.cb_2)
destroy(this.cb_1)
destroy(this.gb_1)
end on

event ue_postopen;call super::ue_postopen;Long ll_Agrupamento

dc_uo_dw_Base lvo_Update[]
lvo_Update = {dw_1}
This.wf_SetUpdate_DW(lvo_Update)

dw_1.Event ue_AddRow()

ll_Agrupamento = Message.DoubleParm

If Not IsNull(ll_Agrupamento) Then
	dw_1.Retrieve(ll_Agrupamento)
End If




end event

type pb_help from dc_w_response`pb_help within w_ge252_cadastro_volume
end type

type dw_1 from dc_uo_dw_base within w_ge252_cadastro_volume
integer x = 101
integer y = 80
integer width = 667
integer height = 76
integer taborder = 20
string dataobject = "dw_ge252_volume"
end type

type cb_2 from commandbutton within w_ge252_cadastro_volume
integer x = 512
integer y = 224
integer width = 311
integer height = 100
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Cancelar"
end type

event clicked;Close( Parent )
end event

type cb_1 from commandbutton within w_ge252_cadastro_volume
integer x = 229
integer y = 224
integer width = 270
integer height = 100
integer taborder = 10
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "OK"
boolean default = true
end type

event clicked;Long ll_Volume

dw_1.AcceptText()

ll_Volume  = dw_1.Object.nr_volume [ 1 ]

If IsNull( ll_Volume ) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Informe a quantidade do volume.")
	dw_1.Event ue_Pos(1,"nr_volume")
	Return -1	
End If

If ll_Volume <= 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","A quantidade informada do volume deve ser maior que zero.")
	dw_1.Event ue_Pos(1,"nr_volume")
	Return -1	
End If

If dw_1.Event ue_Update() = 1 Then
	SqlCa.of_Commit()
Else
	Return -1
End If



Close( Parent )
end event

type gb_1 from groupbox within w_ge252_cadastro_volume
integer x = 23
integer width = 800
integer height = 200
integer taborder = 10
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
end type

