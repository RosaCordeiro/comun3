HA$PBExportHeader$w_ge252_selecao_fornecedor_inc.srw
forward
global type w_ge252_selecao_fornecedor_inc from dc_w_response_ok_cancela
end type
type st_1 from statictext within w_ge252_selecao_fornecedor_inc
end type
end forward

global type w_ge252_selecao_fornecedor_inc from dc_w_response_ok_cancela
integer width = 2075
integer height = 548
string title = "Sele$$HEX2$$e700e300$$ENDHEX$$o de Fornecedor"
st_1 st_1
end type
global w_ge252_selecao_fornecedor_inc w_ge252_selecao_fornecedor_inc

type variables
uo_fornecedor ivo_fornecedor
end variables

on w_ge252_selecao_fornecedor_inc.create
int iCurrent
call super::create
this.st_1=create st_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
end on

on w_ge252_selecao_fornecedor_inc.destroy
call super::destroy
destroy(this.st_1)
end on

event ue_postopen;call super::ue_postopen;ivo_fornecedor 		= Create uo_Fornecedor
end event

type pb_help from dc_w_response_ok_cancela`pb_help within w_ge252_selecao_fornecedor_inc
end type

type gb_1 from dc_w_response_ok_cancela`gb_1 within w_ge252_selecao_fornecedor_inc
integer width = 1947
integer height = 200
end type

type dw_1 from dc_w_response_ok_cancela`dw_1 within w_ge252_selecao_fornecedor_inc
integer width = 1906
integer height = 120
string dataobject = "dw_ge252_seleciona_fornecedor_inc"
boolean vscrollbar = true
end type

event dw_1::itemchanged;call super::itemchanged;If dwo.Name = 'nm_fantasia' Then
	If Not IsNull(data) and Trim(data) <> "" Then
		If data <> ivo_Fornecedor.Nm_Razao_Social Then
			Return 1
		End If
	Else
		ivo_Fornecedor.of_Inicializa()
	
		This.Object.cd_fornecedor[1] = ivo_Fornecedor.cd_fornecedor
		This.Object.nm_fantasia  [1] = ivo_Fornecedor.nm_razao_social
	End If
End If
end event

event dw_1::ue_key;call super::ue_key;String lvs_Nulo


If Key = KeyEnter! Then
	If This.GetColumnName() = 'nm_fantasia' Then
		ivo_Fornecedor.of_Localiza_Fornecedor(dw_1.GetText())
	
		If ivo_Fornecedor.Localizado Then
			dw_1.Object.cd_fornecedor[1] = ivo_Fornecedor.cd_fornecedor
			dw_1.Object.nm_fantasia  [1] = ivo_Fornecedor.Nm_Razao_Social
		Else
			SetNull(lvs_Nulo)
					
			dw_1.Object.cd_fornecedor[1] = lvs_Nulo
			dw_1.Object.nm_fantasia  [1] = lvs_Nulo
		End If
	End If
	
End If



end event

type cb_ok from dc_w_response_ok_cancela`cb_ok within w_ge252_selecao_fornecedor_inc
integer x = 1143
integer y = 344
integer width = 398
string text = "&Confirmar"
end type

event cb_ok::clicked;call super::clicked;String	ls_cd_fornecedor, ls_nm_fantasia


ls_cd_fornecedor	= dw_1.Object.cd_fornecedor[dw_1.GetRow()]
ls_nm_fantasia		= dw_1.Object.nm_fantasia[dw_1.GetRow()]

if MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o', 'Confirma a inclus$$HEX1$$e300$$ENDHEX$$o do fornecedor ' + ls_nm_fantasia + ' (' + ls_cd_fornecedor + ') para incinera$$HEX2$$e700e300$$ENDHEX$$o?', Question!, YesNo!, 2) = 2 then
	return
end if

CloseWithReturn(Parent, ls_cd_fornecedor)
end event

type cb_cancelar from dc_w_response_ok_cancela`cb_cancelar within w_ge252_selecao_fornecedor_inc
integer x = 1554
integer y = 344
integer width = 430
string text = "C&ancelar"
end type

type st_1 from statictext within w_ge252_selecao_fornecedor_inc
integer x = 64
integer y = 244
integer width = 1893
integer height = 52
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 255
long backcolor = 67108864
string text = "O SAP ir$$HEX1$$e100$$ENDHEX$$ emitir a nota de incinera$$HEX2$$e700e300$$ENDHEX$$o para o fornecedor informado"
boolean focusrectangle = false
end type

