HA$PBExportHeader$w_ge427_incluir_mix.srw
forward
global type w_ge427_incluir_mix from dc_w_response_ok_cancela
end type
type cb_confirmar from picturebutton within w_ge427_incluir_mix
end type
type cd_cancelar from picturebutton within w_ge427_incluir_mix
end type
end forward

global type w_ge427_incluir_mix from dc_w_response_ok_cancela
integer width = 1591
integer height = 496
string title = "GE427 - Controle de Mix"
long backcolor = 80269524
cb_confirmar cb_confirmar
cd_cancelar cd_cancelar
end type
global w_ge427_incluir_mix w_ge427_incluir_mix

type variables
Long il_Mix
end variables

forward prototypes
public function boolean wf_proximo_mix (ref long al_mix)
end prototypes

public function boolean wf_proximo_mix (ref long al_mix);Select coalesce(Max(cd_mix_produto) + 1 , 1)
Into :al_Mix
From mix_produto
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgDbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Pr$$HEX1$$f300$$ENDHEX$$ximo Mix" + SqlCa.SqlErrText)
	Return False
End If 

Return True
end function

on w_ge427_incluir_mix.create
int iCurrent
call super::create
this.cb_confirmar=create cb_confirmar
this.cd_cancelar=create cd_cancelar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_confirmar
this.Control[iCurrent+2]=this.cd_cancelar
end on

on w_ge427_incluir_mix.destroy
call super::destroy
destroy(this.cb_confirmar)
destroy(this.cd_cancelar)
end on

event ue_postopen;call super::ue_postopen;il_Mix = Long( Message.StringParm )

If il_Mix > 0 Then
	dw_1.of_AppendWhere("m.cd_mix_produto = " + String(il_Mix))
	dw_1.Retrieve()
End If

end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge427_incluir_mix
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge427_incluir_mix
integer x = 18
integer y = 8
integer width = 1536
integer height = 268
integer taborder = 0
integer weight = 700
string facename = "Verdana"
long backcolor = 80269524
string text = "Mix"
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge427_incluir_mix
integer y = 76
integer width = 1472
integer height = 164
integer taborder = 10
string dataobject = "dw_ge427_incluir_mix"
end type

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)
end event

event dw_1::editchanged;call super::editchanged;cb_confirmar.Enabled = True
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge427_incluir_mix
boolean visible = false
integer x = 64
integer y = 456
integer width = 375
integer taborder = 30
boolean enabled = false
string text = "&Confirmar"
boolean cancel = true
boolean default = false
end type

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge427_incluir_mix
boolean visible = false
integer x = 457
integer y = 460
integer width = 375
integer taborder = 20
boolean enabled = false
string text = "Cancela&r"
end type

event cb_cancelar::clicked;Close(Parent)
end event

type cb_confirmar from picturebutton within w_ge427_incluir_mix
string tag = "cb_confirmar"
integer x = 635
integer y = 292
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

event clicked;Long ll_Mix_Insert
String ls_Descricao

dw_1.AcceptText()

ls_Descricao		= dw_1.Object.de_mix_produto [ 1 ]

//Altera$$HEX2$$e700e300$$ENDHEX$$o
If Not IsNull( il_Mix ) And il_Mix <> 0 Then
	Update mix_produto
		set de_mix_produto 	= :ls_Descricao
	 Where cd_mix_produto 	= :il_Mix
	 Using SqlCa;	

//Inclus$$HEX1$$e300$$ENDHEX$$o	
Else
	
	If Not wf_Proximo_Mix( Ref ll_Mix_Insert ) Then Return
	
	Insert into mix_produto( cd_mix_produto, de_mix_produto )
		Values( :ll_Mix_Insert, :ls_Descricao )
		Using SqlCa;
	
End If

If SqlCa.SqlCode = -1 Then
	SqlCa.of_Rollback()
	SqlCa.of_MsgDbError("Erro ao inserir/alterar o mix." + SqlCa.SqlErrText )
	Return
Else
	SqlCa.of_Commit()
	
	dw_1.Object.cd_mix_produto [ 1 ] = ll_Mix_Insert
	
	CloseWithReturn(Parent, '')
End If


end event

type cd_cancelar from picturebutton within w_ge427_incluir_mix
integer x = 1115
integer y = 292
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

