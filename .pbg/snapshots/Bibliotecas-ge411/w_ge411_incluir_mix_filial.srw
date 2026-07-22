HA$PBExportHeader$w_ge411_incluir_mix_filial.srw
forward
global type w_ge411_incluir_mix_filial from dc_w_response_ok_cancela
end type
type cb_confirmar from picturebutton within w_ge411_incluir_mix_filial
end type
type cd_cancelar from picturebutton within w_ge411_incluir_mix_filial
end type
end forward

global type w_ge411_incluir_mix_filial from dc_w_response_ok_cancela
integer width = 1765
integer height = 1572
string title = "GE411 - Inclus$$HEX1$$e300$$ENDHEX$$o de Mix"
long backcolor = 80269524
cb_confirmar cb_confirmar
cd_cancelar cd_cancelar
end type
global w_ge411_incluir_mix_filial w_ge411_incluir_mix_filial

type variables
str_parametros_inclusao str
end variables

forward prototypes
public function boolean wf_retorna_nome_mix (long al_mix, ref string as_mix)
end prototypes

public function boolean wf_retorna_nome_mix (long al_mix, ref string as_mix);Select de_mix_produto
	Into :as_Mix
From mix_produto
Where cd_mix_produto = :al_Mix
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		Return True
		
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "N$$HEX1$$e300$$ENDHEX$$o foi localizado o mix '" + String(al_Mix) + "'.")
		Return False
		
	Case -1
		SqlCa.of_MsgdbError("Erro ao consultar a descri$$HEX2$$e700e300$$ENDHEX$$o do mix. Fun$$HEX2$$e700e300$$ENDHEX$$o wf_retorna_nome_mix")
		Return False
		
End Choose
end function

on w_ge411_incluir_mix_filial.create
int iCurrent
call super::create
this.cb_confirmar=create cb_confirmar
this.cd_cancelar=create cd_cancelar
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_confirmar
this.Control[iCurrent+2]=this.cd_cancelar
end on

on w_ge411_incluir_mix_filial.destroy
call super::destroy
destroy(this.cb_confirmar)
destroy(this.cd_cancelar)
end on

event ue_postopen;call super::ue_postopen;str = Message.PowerObjectParm

dw_1.Retrieve(str.Cd_Filial)
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge411_incluir_mix_filial
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge411_incluir_mix_filial
integer x = 18
integer y = 8
integer width = 1701
integer height = 1332
integer taborder = 0
integer weight = 700
string facename = "Verdana"
long backcolor = 80269524
string text = "Lista de Mix a Incluir na Filial"
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge411_incluir_mix_filial
integer y = 76
integer width = 1637
integer height = 1244
integer taborder = 10
string dataobject = "dw_ge411_lista_mix_inclusao"
boolean vscrollbar = true
end type

event dw_1::constructor;call super::constructor;This.of_SetRowSelection()
end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge411_incluir_mix_filial
boolean visible = false
integer x = 0
integer y = 676
integer width = 375
integer taborder = 30
boolean enabled = false
string text = "&Confirmar"
boolean cancel = true
boolean default = false
end type

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge411_incluir_mix_filial
boolean visible = false
integer x = 265
integer y = 676
integer width = 375
integer taborder = 20
boolean enabled = false
string text = "Cancela&r"
end type

event cb_cancelar::clicked;Close(Parent)
end event

type cb_confirmar from picturebutton within w_ge411_incluir_mix_filial
string tag = "cb_confirmar"
integer x = 800
integer y = 1364
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
boolean originalsize = true
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\botao_confirmar.png"
string disabledname = "S:\Sistemas_PB12\Comuns\Figuras\botao_confirmar_desabilitado.png"
alignment htextalign = left!
long textcolor = 67108864
long backcolor = 67108864
end type

event clicked;Boolean lb_Sucesso = True

Long ll_Mix
Long ll_Linha

String ls_De_Mix

dw_1.AcceptText()

ll_Linha = dw_1.GetRow()
ll_Mix = dw_1.Object.Cd_Mix_Produto[ll_Linha]

If Not wf_Retorna_Nome_Mix(ll_Mix, Ref ls_De_Mix) Then
	Return -1
End If

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma a inclus$$HEX1$$e300$$ENDHEX$$o do mix '" + ls_De_Mix +"' para a filial " + str.Nm_Fantasia + " (" + String(str.Cd_Filial) +  ") ?", Question!, YesNo!, 2) = 2 Then
	Return -1
End If

Insert Into mix_produto_filial(cd_filial, cd_mix_produto)
	Values(:str.Cd_Filial, :ll_Mix)
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Erro ao gravar o mix produto na filial")
	lb_Sucesso = False
End If

If lb_Sucesso Then
	SqlCa.of_Commit();
	CloseWithReturn(Parent, "")
Else
	SqlCa.of_RollBack();
End If
end event

type cd_cancelar from picturebutton within w_ge411_incluir_mix_filial
integer x = 1280
integer y = 1364
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

