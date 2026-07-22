HA$PBExportHeader$w_justificativa.srw
forward
global type w_justificativa from dc_w_response
end type
type cb_fechar from commandbutton within w_justificativa
end type
type cb_ok from commandbutton within w_justificativa
end type
type dw_1 from dc_uo_dw_base within w_justificativa
end type
end forward

global type w_justificativa from dc_w_response
integer width = 1431
integer height = 616
string title = "Aten$$HEX2$$e700e300$$ENDHEX$$o"
boolean controlmenu = false
cb_fechar cb_fechar
cb_ok cb_ok
dw_1 dw_1
end type
global w_justificativa w_justificativa

type variables
//A mensagem pode ser alterada no OpenWithParm( w_justificativa, is_msg )
//Ex: OpenWithParm( w_justificativa, '15Informe o motivo do cancelamento:' )
//Utilize as 2 primeiras casas para definir a qtde minima de caracteres.
String is_msg =  'Informe a justificativa:'

Integer ii_qt_Minima = 5
end variables

forward prototypes
public function boolean wf_contem_caracter_especial (string as_registro, ref string as_modificado)
end prototypes

public function boolean wf_contem_caracter_especial (string as_registro, ref string as_modificado);String ls_Caracteres, ls_x
Integer li_Row, ll_Total
Boolean lb_Retorno

If as_registro = "" Then Return False
as_modificado = ""

ls_Caracteres = "$$HEX1$$1420$$ENDHEX$$'~~$$HEX2$$e700c700$$ENDHEX$$^$$HEX1$$b400$$ENDHEX$$`$$HEX55$$a800e200c200e000c000e300c300e900c900ea00ca00e800c800ed00cd00ee00ce00ec00cc00e600c600f400f200fb00f900f800a300d8009201e100c100f300fa00f100d100aa00ba00bf00ae00bd00a700bc00d300df00d400d200f500d500b500fe00da00db00d900fd00dd00$$ENDHEX$$!@#$%$$HEX1$$a800$$ENDHEX$$&*()_-=+{}[]?/;>.<,|\"

ll_Total = LenA( as_registro )

For li_Row = 1 To ll_Total
	
	ls_x = mid(as_registro, li_row, 1)
	
	If Pos( ls_Caracteres, ls_x ) > 0 Then
		as_modificado = gf_Replace( as_registro, ls_x, "", 1 )
		lb_Retorno = True
		Exit
	End If		   
Next

Return lb_Retorno

end function

on w_justificativa.create
int iCurrent
call super::create
this.cb_fechar=create cb_fechar
this.cb_ok=create cb_ok
this.dw_1=create dw_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_fechar
this.Control[iCurrent+2]=this.cb_ok
this.Control[iCurrent+3]=this.dw_1
end on

on w_justificativa.destroy
call super::destroy
destroy(this.cb_fechar)
destroy(this.cb_ok)
destroy(this.dw_1)
end on

event ue_postopen;call super::ue_postopen;String ls_Parametro

ls_Parametro = Message.StringParm

If ls_Parametro <> '' Then
	ii_Qt_Minima = Integer( Mid( ls_Parametro, 1, 2 ) )
	is_msg = Mid( ls_Parametro, 3 )
End If

dw_1.Event ue_AddRow()

dw_1.Object.texto_t.text = is_msg
end event

type pb_help from dc_w_response`pb_help within w_justificativa
end type

type cb_fechar from commandbutton within w_justificativa
integer x = 23
integer y = 420
integer width = 315
integer height = 100
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Fechar"
end type

event clicked;String ls_Retorno

SetNull(ls_Retorno)

CloseWithReturn(Parent, ls_Retorno )
end event

type cb_ok from commandbutton within w_justificativa
integer x = 992
integer y = 420
integer width = 402
integer height = 100
integer taborder = 20
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Confirmar"
end type

event clicked;String ls_Texto

dw_1.AcceptText()

ls_Texto = Trim( dw_1.Object.de_observacao[1] )

If ls_Texto = "" Or IsNull( ls_Texto ) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", 'Nenhum texto informado.' )
	dw_1.Event ue_Pos(1, "de_observacao")
	Return -1	
End If

If LenA( ls_Texto ) < ii_qt_Minima Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O texto informado deve conter pelo menos " + String( ii_qt_Minima ) + " caract$$HEX1$$e900$$ENDHEX$$res.")
	dw_1.Event ue_Pos(1, "de_observacao")
	Return -1
End If

If Pos(ls_Texto, "~r~n") > 0 Then //Retira algum enter que tiver no texto, para n$$HEX1$$e300$$ENDHEX$$o "quebrar" o xml.
	ls_Texto = gf_Replace( ls_Texto, "~r~n", "", 0 )
End If

CloseWithReturn( Parent, ls_Texto )
end event

type dw_1 from dc_uo_dw_base within w_justificativa
integer x = 14
integer y = 12
integer width = 1385
integer height = 392
string dataobject = "dw_justificativa"
end type

event editchanged;call super::editchanged;String ls_Alterado

Choose Case dwo.name 		
	Case "de_observacao"
		If wf_contem_caracter_especial( Data, Ref ls_Alterado ) Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","N$$HEX1$$e300$$ENDHEX$$o utilize caract$$HEX1$$e900$$ENDHEX$$res especiais.")
			If Data <> ls_Alterado Then This.Object.de_observacao[1] = ls_Alterado
			Return -1
		End If
			
End Choose
end event

