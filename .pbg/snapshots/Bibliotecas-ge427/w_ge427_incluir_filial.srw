HA$PBExportHeader$w_ge427_incluir_filial.srw
forward
global type w_ge427_incluir_filial from dc_w_response_ok_cancela
end type
type cb_confirmar from picturebutton within w_ge427_incluir_filial
end type
type cd_cancelar from picturebutton within w_ge427_incluir_filial
end type
end forward

global type w_ge427_incluir_filial from dc_w_response_ok_cancela
integer width = 1778
integer height = 416
string title = "GE427 - Controle de Mix"
long backcolor = 80269524
cb_confirmar cb_confirmar
cd_cancelar cd_cancelar
end type
global w_ge427_incluir_filial w_ge427_incluir_filial

type variables
uo_filial io_filial

Long il_Mix
end variables

forward prototypes
public function boolean wf_verifica_filial_mix (integer al_filial)
end prototypes

public function boolean wf_verifica_filial_mix (integer al_filial);Integer li_contador

Select count(cd_filial)
into	:li_contador
from mix_produto_filial
where cd_mix_produto	= :il_Mix
and 	cd_filial 				= :al_filial
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Erro ao localizar a filial: " + String(al_filial) + ' no mix: ' + String(il_Mix) + ". " + SqlCa.SqlErrText)
	Return False
End If 

Return (li_contador = 0)

end function

on w_ge427_incluir_filial.create
int iCurrent
call super::create
this.cb_confirmar=create cb_confirmar
this.cd_cancelar=create cd_cancelar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_confirmar
this.Control[iCurrent+2]=this.cd_cancelar
end on

on w_ge427_incluir_filial.destroy
call super::destroy
destroy(this.cb_confirmar)
destroy(this.cd_cancelar)
end on

event open;call super::open;io_filial = Create uo_Filial
end event

event close;call super::close;Destroy io_Filial
end event

event ue_postopen;call super::ue_postopen;il_Mix = Long( Message.StringParm )


end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge427_incluir_filial
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge427_incluir_filial
integer x = 18
integer y = 8
integer width = 1719
integer height = 180
integer taborder = 0
integer weight = 700
string facename = "Verdana"
long backcolor = 80269524
string text = "Filial"
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge427_incluir_filial
integer x = 46
integer y = 76
integer width = 1673
integer height = 72
integer taborder = 10
string dataobject = "dw_ge427_incluir_filial"
end type

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)
end event

event dw_1::itemchanged;If dwo.Name = "nm_fantasia" Then
	If Not IsNull(Data) and Trim(Data) <> "" Then
		If Data <> io_Filial.Nm_Fantasia Then
			Return 1
		End If
	Else
		io_Filial.of_Inicializa()
		
		This.Object.Cd_Filial		[ 1 ] 	= io_Filial.Cd_Filial
		This.Object.Nm_Fantasia	[ 1 ]	= io_Filial.Nm_Fantasia
		
		cb_confirmar.Enabled = False
	End If	
End If
end event

event dw_1::ue_key;call super::ue_key;If This.GetColumnName() = "nm_fantasia" Then
	If key = KeyEnter! Then
		
		io_Filial.of_Localiza_Filial(This.GetText())
		
		If io_Filial.Localizada Then
			If wf_verifica_filial_mix( io_Filial.cd_filial ) Then
				This.Object.cd_filial  		[ 1 ] = io_Filial.cd_filial
				This.Object.nm_fantasia	[ 1 ] = io_Filial.nm_fantasia
				
				cb_confirmar.Enabled = True
				
			Else 
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Filial j$$HEX1$$e100$$ENDHEX$$ cadastrada neste mix.")
				This.Event ue_Pos(1,"nm_fantasia")
				cb_confirmar.Enabled = False
			End If
		End If
		
	End If
End If
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge427_incluir_filial
boolean visible = false
integer x = 64
integer y = 408
integer width = 375
integer taborder = 30
boolean enabled = false
string text = "&Confirmar"
boolean cancel = true
boolean default = false
end type

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge427_incluir_filial
boolean visible = false
integer x = 457
integer y = 412
integer width = 375
integer taborder = 20
boolean enabled = false
string text = "Cancela&r"
end type

event cb_cancelar::clicked;Close(Parent)
end event

type cb_confirmar from picturebutton within w_ge427_incluir_filial
string tag = "cb_confirmar"
integer x = 823
integer y = 208
integer width = 462
integer height = 108
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
boolean originalsize = true
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\botao_confirmar.png"
string disabledname = "S:\Sistemas_PB12\Comuns\Figuras\botao_confirmar_desabilitado.png"
alignment htextalign = left!
long textcolor = 67108864
long backcolor = 67108864
end type

event clicked;Long ll_filial

ll_filial = dw_1.Object.cd_Filial [ 1 ]

Insert into mix_produto_filial( cd_filial, cd_mix_produto)
	Values( :ll_filial, :il_Mix )
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_Rollback()
	SqlCa.of_MsgDbError("Erro ao inserir a filial " + String(ll_Filial) + " no mix. " + SqlCa.SqlErrText )
	Return
Else
	SqlCa.of_Commit()
	CloseWithReturn(Parent, '')
End If


end event

type cd_cancelar from picturebutton within w_ge427_incluir_filial
integer x = 1303
integer y = 208
integer width = 439
integer height = 108
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\botao_cancelar.png"
alignment htextalign = left!
long backcolor = 67108864
end type

event clicked;String ls_null

SetNull(ls_null)

CloseWithReturn(Parent, ls_null )
end event

