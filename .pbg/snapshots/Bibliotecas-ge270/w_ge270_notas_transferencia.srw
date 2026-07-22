HA$PBExportHeader$w_ge270_notas_transferencia.srw
forward
global type w_ge270_notas_transferencia from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge270_notas_transferencia from dc_w_selecao_lista_relatorio
integer width = 5157
integer height = 2524
string title = "GE270 - Notas de Transfer$$HEX1$$ea00$$ENDHEX$$ncia de Produtos Almoxarifado"
end type
global w_ge270_notas_transferencia w_ge270_notas_transferencia

type variables

end variables

on w_ge270_notas_transferencia.create
call super::create
end on

on w_ge270_notas_transferencia.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;Datetime lvdh_Parametro

gf_data_parametro(lvdh_Parametro)

dw_1.Object.dt_inicio	[1] = gf_primeiro_dia_mes(RelativeDate(gf_primeiro_dia_mes(Date(lvdh_Parametro)),-1))
dw_1.Object.dt_fim	[1] = RelativeDate(gf_primeiro_dia_mes(Date(lvdh_Parametro)),-1)

This.ivm_menu.ivb_permite_imprimir = True

ivb_permite_fechar = False
end event

event ue_preopen;call super::ue_preopen;//--Maxheight = 9999
//MaxWidth = 4720
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge270_notas_transferencia
integer x = 82
integer y = 1500
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge270_notas_transferencia
integer x = 46
integer y = 1428
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge270_notas_transferencia
integer y = 220
integer width = 5038
integer height = 2084
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge270_notas_transferencia
integer width = 1161
integer height = 188
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge270_notas_transferencia
integer width = 1106
integer height = 92
string dataobject = "dw_ge270_notas_transf_selecao"
end type

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge270_notas_transferencia
integer x = 73
integer y = 296
integer width = 4969
integer height = 1972
string dataobject = "dw_ge270_notas_transf_lista"
boolean ivb_ordena_colunas = true
end type

event dw_2::constructor;call super::constructor;This.ShareData( dw_3)
end event

event dw_2::ue_reset;call super::ue_reset;This.ivm_menu.mf_SalvarComo(False)
end event

event dw_2::ue_retrieve;//override
Datetime lvdh_Inicio
Datetime lvdh_Fim

dw_1.AcceptText( )
lvdh_Inicio	= dw_1.Object.dt_inicio	[1]
lvdh_Fim		= dw_1.Object.dt_fim		[1]

If IsNull(lvdh_Inicio) Or (Not IsDate(String(lvdh_Inicio,"dd/mm/yyyy"))) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Favor informar o per$$HEX1$$ed00$$ENDHEX$$odo inicial.",Exclamation!)
	dw_1.Event ue_Pos(1, "dt_inicio")
	Return -1
End If

If IsNull(lvdh_Fim) Or (Not IsDate(String(lvdh_Fim,"dd/mm/yyyy"))) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Favor informar o per$$HEX1$$ed00$$ENDHEX$$odo final.",Exclamation!)
	dw_1.Event ue_Pos(1, "dt_fim")
	Return -1
End If

If (lvdh_Fim < lvdh_Inicio) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Per$$HEX1$$ed00$$ENDHEX$$odo final n$$HEX1$$e300$$ENDHEX$$o pode ser menor que o inicial.",Exclamation!)
	dw_1.Event ue_Pos(1, "dt_inicio")
	Return -1
End If

Open(w_aguarde)
w_aguarde.Title = 'Aguarde...'
This.Retrieve(lvdh_Inicio,lvdh_Fim)
Close(w_aguarde)

This.ivm_menu.mf_SalvarComo(This.RowCount() > 0)
This.ivm_menu.mf_Imprimir(This.RowCount() > 0)
This.ivm_menu.mf_classificar(This.RowCount() > 0)
This.ivm_menu.mf_filtrar(This.RowCount() > 0)

Return This.RowCount()
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge270_notas_transferencia
integer x = 1339
integer y = 24
integer height = 160
string dataobject = "dw_ge270_notas_transf_relatorio"
end type

event dw_3::ue_preprint;call super::ue_preprint;This.Object.st_periodo.Text = String(dw_1.Object.dt_inicio[1],"dd/mm/yyyy") + ' $$HEX1$$e000$$ENDHEX$$ ' + String(dw_1.Object.dt_fim[1],"dd/mm/yyyy")

Return This.RowCount()
end event

