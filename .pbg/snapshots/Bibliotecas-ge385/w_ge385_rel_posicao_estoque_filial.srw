HA$PBExportHeader$w_ge385_rel_posicao_estoque_filial.srw
forward
global type w_ge385_rel_posicao_estoque_filial from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge385_rel_posicao_estoque_filial from dc_w_selecao_lista_relatorio
integer width = 3168
integer height = 1364
string title = "GE385 - Relat$$HEX1$$f300$$ENDHEX$$rio Posi$$HEX2$$e700e300$$ENDHEX$$o de Estoque Filial"
end type
global w_ge385_rel_posicao_estoque_filial w_ge385_rel_posicao_estoque_filial

type variables
Private:
uo_filial ivo_filial
end variables

on w_ge385_rel_posicao_estoque_filial.create
call super::create
end on

on w_ge385_rel_posicao_estoque_filial.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_preopen;call super::ue_preopen;ivo_filial = Create uo_filial

Maxheight = 9999
Maxwidth= 7140
end event

event close;call super::close;Destroy(ivo_filial)
end event

event ue_postopen;call super::ue_postopen;dw_1.Object.dh_posicao [1] = RelativeDate(Today(), -1)

This.ivm_menu.ivb_permite_imprimir = True
end event

event ue_print;//override
dw_2.event ue_imprimir_relatorio( "Relat$$HEX1$$f300$$ENDHEX$$rio Posi$$HEX2$$e700e300$$ENDHEX$$o Estoque Filial" , "CL", False)
end event

event ue_printimmediate;//override
dw_2.event ue_imprimir_relatorio( "Relat$$HEX1$$f300$$ENDHEX$$rio Posi$$HEX2$$e700e300$$ENDHEX$$o Estoque Filial" , "CL", True)
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge385_rel_posicao_estoque_filial
integer x = 293
integer y = 2268
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge385_rel_posicao_estoque_filial
integer x = 256
integer y = 2196
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge385_rel_posicao_estoque_filial
integer y = 292
integer width = 3063
integer height = 868
integer weight = 700
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge385_rel_posicao_estoque_filial
integer width = 1531
integer height = 264
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge385_rel_posicao_estoque_filial
integer x = 55
integer width = 1495
integer height = 168
string dataobject = "dw_ge385_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
		
	Case "nm_filial"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Filial.nm_fantasia Then
				Return 1
			End If	
		Else			
			ivo_Filial.Of_Inicializa()
			
			This.Object.nm_filial	[1] = ivo_Filial.nm_fantasia
			This.Object.cd_filial	[1] = ivo_Filial.cd_filial
			
		End If	
End Choose
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Filial) Then 
	This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
End If
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	
	This.AcceptText( )
	
	Choose Case This.GetColumnName() 
			
		Case "nm_filial"
			ivo_filial.Of_Localiza_Filial(This.GetText()) 
			
			If ivo_filial.Localizada Then
				  
				This.Object.cd_filial	[1] = ivo_filial.cd_filial
				This.Object.nm_filial	[1] = ivo_filial.nm_fantasia
				
			End If	
	End Choose
End If
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge385_rel_posicao_estoque_filial
integer y = 368
integer width = 2994
integer height = 760
string dataobject = "dw_ge385_lista"
boolean hscrollbar = true
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;Datetime lvdh_Posicao
Long lvl_Filial

dw_1.Accepttext( )

lvl_Filial 			= dw_1.Object.cd_filial 		[1]
lvdh_Posicao	= dw_1.Object.dh_posicao	[1]

If IsNull(lvdh_Posicao) or lvdh_Posicao < Datetime('2010/01/01') Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe uma data v$$HEX1$$e100$$ENDHEX$$lida para a posi$$HEX2$$e700e300$$ENDHEX$$o!",Exclamation!)
	dw_1.Event ue_Pos(1, "dh_posicao")
	Return -1
Else
	This.ivs_filtro_relatorio [ UpperBound(This.ivs_filtro_relatorio) +1] = "Posi$$HEX2$$e700e300$$ENDHEX$$o: "+String(lvdh_Posicao,"DD/MM/YYYY")
End If

If IsNull(lvl_Filial) or lvl_Filial <= 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe uma filial v$$HEX1$$e100$$ENDHEX$$lida!",Exclamation!)
	dw_1.Event ue_Pos(1, "nm_filial")
	Return -1
Else
	This.ivs_filtro_relatorio [ UpperBound(This.ivs_filtro_relatorio) +1] = "Filial: "+ivo_filial.nm_fantasia+" ("+String(lvl_Filial)+")"
End If

Return AncestorReturnValue
end event

event dw_2::ue_recuperar;//override
Datetime lvdh_Posicao
Datetime lvdh_Saldo
Long lvl_Filial
Long lvl_Filial_2

dw_1.Accepttext( )

lvl_Filial 			= dw_1.Object.cd_filial 		[1]
lvl_Filial_2		= IIF(lvl_Filial=534,1,lvl_Filial)
lvdh_Posicao	= dw_1.Object.dh_posicao	[1]

If Date(lvdh_Posicao) = gf_retorna_ultimo_dia_mes(lvdh_Posicao) Then
	lvdh_Saldo	= Datetime(gf_primeiro_dia_mes(Date(lvdh_Posicao)))
Else
	lvdh_Saldo	= Datetime(gf_primeiro_dia_mes(RelativeDate(gf_primeiro_dia_mes(Date(lvdh_Posicao)), -1)))
End If

Return This.Retrieve(lvdh_Saldo, lvdh_Posicao, lvl_Filial, lvl_Filial_2)
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;This.ivm_menu.mf_salvarcomo( pl_linhas > 0 )

Return AncestorReturnValue
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge385_rel_posicao_estoque_filial
integer x = 3200
integer y = 24
end type

