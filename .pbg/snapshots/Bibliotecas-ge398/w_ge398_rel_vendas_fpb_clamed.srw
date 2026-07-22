HA$PBExportHeader$w_ge398_rel_vendas_fpb_clamed.srw
forward
global type w_ge398_rel_vendas_fpb_clamed from dc_w_selecao_lista_relatorio
end type
type st_1 from statictext within w_ge398_rel_vendas_fpb_clamed
end type
type st_2 from statictext within w_ge398_rel_vendas_fpb_clamed
end type
end forward

global type w_ge398_rel_vendas_fpb_clamed from dc_w_selecao_lista_relatorio
integer width = 4791
integer height = 1356
string title = "GE398 - Relatat$$HEX1$$f300$$ENDHEX$$rio de Vendas Farm$$HEX1$$e100$$ENDHEX$$cia Popular - Clamed"
st_1 st_1
st_2 st_2
end type
global w_ge398_rel_vendas_fpb_clamed w_ge398_rel_vendas_fpb_clamed

type variables
Private:
uo_Filial ivo_Filial 
end variables

on w_ge398_rel_vendas_fpb_clamed.create
int iCurrent
call super::create
this.st_1=create st_1
this.st_2=create st_2
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.st_1
this.Control[iCurrent+2]=this.st_2
end on

on w_ge398_rel_vendas_fpb_clamed.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.st_1)
destroy(this.st_2)
end on

event ue_preopen;call super::ue_preopen;ivo_Filial = Create uo_Filial

Maxheight	= 9999
Maxwidth	= 7620
end event

event close;call super::close;Destroy(ivo_Filial)
end event

event ue_postopen;call super::ue_postopen;dw_1.Object.dh_inicio[1] = gf_getserverdate()
dw_1.Object.dh_fim	[1] = gf_getserverdate()

This.Ivm_menu.ivb_permite_imprimir = True
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge398_rel_vendas_fpb_clamed
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge398_rel_vendas_fpb_clamed
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge398_rel_vendas_fpb_clamed
integer y = 284
integer width = 4690
integer height = 872
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge398_rel_vendas_fpb_clamed
integer height = 256
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge398_rel_vendas_fpb_clamed
integer height = 172
string dataobject = "dw_ge398_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case "nm_filial"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Filial.Nm_Fantasia Then
				Return 1
			End If
		Else
			ivo_Filial.of_Inicializa()
			
			This.Object.nm_filial	[1] = ivo_filial.Nm_Fantasia
			This.Object.cd_filial	[1] = ivo_filial.Cd_Filial
					
		End If	
End Choose
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Filial) Then
	This.Object.Cd_Filial	[1] = ivo_Filial.Cd_Filial
	This.Object.Nm_Filial	[1] = ivo_Filial.Nm_Fantasia
End If
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	If This.GetColumnName() = "nm_filial" Then
		ivo_Filial.of_Localiza_Filial(This.GetText())
		
		If ivo_Filial.Localizada Then
			This.Object.Cd_Filial	[1] = ivo_Filial.Cd_Filial
			This.Object.Nm_Filial	[1] = ivo_Filial.Nm_Fantasia
		End If
	End If
End If
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge398_rel_vendas_fpb_clamed
integer y = 360
integer width = 4622
integer height = 764
string dataobject = "dw_ge398_lista"
boolean hscrollbar = true
end type

event dw_2::ue_recuperar;//override
Datetime lvdh_Inicio
Datetime lvdh_Fim

dw_1.Accepttext( )
lvdh_Inicio	= dw_1.Object.dh_inicio	[1]
lvdh_Fim		= dw_1.Object.dh_fim	[1]

Return This.Retrieve(lvdh_Inicio, lvdh_Fim)
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;Long lvl_Filial

Datetime lvdh_Inicio
Datetime lvdh_Fim

dw_1.accepttext( )
lvl_Filial		= dw_1.Object.cd_filial	[1]
lvdh_Inicio	= dw_1.Object.dh_inicio	[1]
lvdh_Fim		= dw_1.Object.dh_fim	[1]

If (lvdh_Inicio < Datetime("2010/01/01")) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data inicial corretamente.", StopSign!)
	dw_1.Event ue_Pos(1, "dh_inicio")
	Return -1
End If

If (lvdh_Fim < Datetime("2010/01/01")) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data final corretamente.", StopSign!)
	dw_1.Event ue_Pos(1, "dh_fim")
	Return -1
End If

If lvdh_Inicio > lvdh_Fim Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data final deve ser maior ou igual a data inicial.", StopSign!)
	dw_1.Event ue_Pos(1, "dh_fim")
	Return -1
End If

dw_3.Object.st_periodo.Text = String(lvdh_Inicio,"DD/MM/YYYY")+" $$HEX1$$e000$$ENDHEX$$ "+String(lvdh_Fim, "DD/MM/YYYY")

If Not IsNull(lvl_Filial) and (lvl_Filial > 0) Then
	This.Of_AppendWhere_Subquery("n.cd_filial = "+String(lvl_Filial),2)
End If

Return AncestorReturnValue
end event

event dw_2::constructor;call super::constructor;This.Sharedata( dw_3 )
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;This.ivm_menu.mf_salvarcomo( pl_linhas > 0)
This.ivm_menu.mf_imprimir( pl_linhas > 0 )

Return AncestorReturnValue
end event

event dw_2::ue_reset;call super::ue_reset;This.ivm_menu.mf_salvarcomo( False )
This.ivm_menu.mf_imprimir( False )
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge398_rel_vendas_fpb_clamed
integer x = 1801
integer y = 44
string dataobject = "dw_ge398_relatorio"
end type

type st_1 from statictext within w_ge398_rel_vendas_fpb_clamed
integer x = 1778
integer y = 44
integer width = 2693
integer height = 52
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 255
long backcolor = 67108864
string text = "* Filtrando as promo$$HEX2$$e700f500$$ENDHEX$$es 5532, 5533, 5535, 5536, 5537, 5538, 5539, 5540, 7315, 7316, 51834, 51835"
boolean focusrectangle = false
end type

type st_2 from statictext within w_ge398_rel_vendas_fpb_clamed
integer x = 1778
integer y = 120
integer width = 3232
integer height = 52
boolean bringtotop = true
integer textsize = -7
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 255
long backcolor = 67108864
string text = "* Filtrando as promo$$HEX2$$e700f500$$ENDHEX$$es 108675,108676 , 113288,108085,108086,108798,109051,109052,109098,109099,111722,111724"
boolean focusrectangle = false
end type

