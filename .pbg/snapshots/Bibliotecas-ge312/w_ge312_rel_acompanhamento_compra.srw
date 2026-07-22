HA$PBExportHeader$w_ge312_rel_acompanhamento_compra.srw
forward
global type w_ge312_rel_acompanhamento_compra from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge312_rel_acompanhamento_compra from dc_w_selecao_lista_relatorio
integer width = 3058
integer height = 1908
string title = "GE312 - Relat$$HEX1$$f300$$ENDHEX$$rio de Acompanhamento de Compra"
end type
global w_ge312_rel_acompanhamento_compra w_ge312_rel_acompanhamento_compra

type variables
Uo_Filial  ivo_filial
end variables

forward prototypes
public subroutine wf_localiza_filial ()
end prototypes

public subroutine wf_localiza_filial ();String lvs_filial

lvs_filial = dw_1.GetText()

ivo_filial.Of_Localiza_Filial(lvs_filial)

If ivo_filial.Localizada Then
	
	dw_1.Object.cd_filial[1] = ivo_filial.cd_filial
   dw_1.Object.filial[1]    = ivo_filial.nm_fantasia
	
End If

end subroutine

on w_ge312_rel_acompanhamento_compra.create
call super::create
end on

on w_ge312_rel_acompanhamento_compra.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;Destroy(ivo_Filial)
end event

event ue_postopen;call super::ue_postopen;Date lvdt_Sistema

Integer lvi_Mes, &
        lvi_ano

lvdt_Sistema = Today()
lvi_Mes      = Month(lvdt_Sistema)
lvi_Ano      = Year(lvdt_Sistema)

dw_1.Object.mes[1] = lvi_mes
dw_1.Object.ano[1] = lvi_ano

This.ivm_Menu.ivb_Permite_Imprimir = True

end event

event ue_saveas;dw_3.Event ue_SaveAs()
end event

event ue_preopen;call super::ue_preopen;ivo_Filial = Create Uo_Filial
end event

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge312_rel_acompanhamento_compra
integer x = 18
integer y = 288
integer width = 2990
integer height = 1420
integer weight = 700
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge312_rel_acompanhamento_compra
integer x = 18
integer y = 4
integer width = 1751
integer height = 276
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge312_rel_acompanhamento_compra
integer x = 46
integer y = 72
integer width = 1696
integer height = 196
string dataobject = "dw_ge312_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;Long    lvl_nulo
SetNull(lvl_Nulo)

Choose Case dwo.Name
	Case "filial"
		If Trim(Data) <> "" Then
			If Data <> ivo_filial.nm_fantasia Then
				Return 1
			End If
		Else
			This.Object.Cd_Filial[1] = lvl_Nulo
			ivo_filial.nm_fantasia   = ''
		End If
End Choose
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	
	Choose Case GetColumnName()
			
		Case "filial"
			wf_localiza_filial()			
	End Choose
End If
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge312_rel_acompanhamento_compra
integer x = 50
integer y = 344
integer width = 2921
integer height = 1336
string dataobject = "dw_ge312_lista"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;dw_1.AcceptText()

If Not IsNull(dw_1.Object.cd_filial[1]) Then 
	This.of_AppendWhere("r.cd_filial = " + String(dw_1.Object.cd_filial[1]))
End If

Return AncestorReturnValue
end event

event dw_2::ue_recuperar;//OverRide
Long lvl_Filial

Integer lvi_mes, &
        lvi_ano
		  
String lvs_data, &
       lvs_mes
		 
Date lvdt_Inicio
Date lvdt_Fim

lvi_mes	= dw_1.Object.mes	[1]
lvi_ano	= dw_1.Object.ano	[1]

If LenA(string(lvi_ano)) < 4 Then
	messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o","O ano informado n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ v$$HEX1$$e100$$ENDHEX$$lido.", Information!)
	dw_1.Event ue_Pos(1, "ano")
	Return -1
End If

lvdt_Inicio = Date(lvi_ano,lvi_mes,1)
lvdt_Fim	 = gf_retorna_ultimo_dia_mes(lvdt_Inicio)
	
Return This.Retrieve(lvdt_Inicio,lvdt_Fim)
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;This.Ivm_menu.mf_Salvarcomo(pl_linhas > 0)
This.Ivm_menu.mf_Imprimir(pl_linhas > 0)

Return AncestorReturnValue
end event

event dw_2::ue_reset;call super::ue_reset;This.Ivm_menu.mf_SalvarComo(False)
This.Ivm_menu.mf_Imprimir(False)
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge312_rel_acompanhamento_compra
integer x = 2094
integer y = 60
integer height = 116
string dataobject = "dw_ge312_relatorio"
end type

event dw_3::ue_preprint;call super::ue_preprint;//OverRide
Integer lvi_mes, &
        lvi_ano
		  
String lvs_data, &
       lvs_mes

lvi_mes = dw_1.Object.mes[1]
lvi_ano = dw_1.Object.ano[1]
	
lvs_Mes = Upper(gf_Mes_Extenso(lvi_mes))
		
dw_3.Object.mes_t.Text = lvs_mes
dw_3.Object.ano_t.Text = String(dw_1.Object.ano[1])
	
Return AncestorReturnValue
end event

