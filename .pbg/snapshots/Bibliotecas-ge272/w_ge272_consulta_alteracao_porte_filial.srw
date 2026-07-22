HA$PBExportHeader$w_ge272_consulta_alteracao_porte_filial.srw
forward
global type w_ge272_consulta_alteracao_porte_filial from dc_w_selecao_lista_relatorio
end type
type cb_exporta from commandbutton within w_ge272_consulta_alteracao_porte_filial
end type
type dw_4 from dc_uo_dw_base within w_ge272_consulta_alteracao_porte_filial
end type
type cb_limites from commandbutton within w_ge272_consulta_alteracao_porte_filial
end type
end forward

global type w_ge272_consulta_alteracao_porte_filial from dc_w_selecao_lista_relatorio
string tag = "w_ge272_consulta_alteracao_porte_filial"
integer width = 3712
integer height = 1636
string title = "GE272 - Relat$$HEX1$$f300$$ENDHEX$$rio de Altera$$HEX2$$e700e300$$ENDHEX$$o de Porte de Filial"
cb_exporta cb_exporta
dw_4 dw_4
cb_limites cb_limites
end type
global w_ge272_consulta_alteracao_porte_filial w_ge272_consulta_alteracao_porte_filial

type variables
DataWindowChild	idwc_Rede
end variables

forward prototypes
public subroutine wf_insere_default ()
end prototypes

public subroutine wf_insere_default ();Long lvl_Regiao

/* Rede Filial */
idwc_Rede  = dw_1.of_InsertRow_DDDW("id_rede" )			

idwc_Rede.SetItem(1, "vl_parametro", 'TD'	)
idwc_Rede.SetItem(1, "rede", "TODAS"	)

dw_1.Object.id_rede[1] = 'TD'

/* Regi$$HEX1$$e300$$ENDHEX$$o Filial */
idwc_Rede  = dw_1.of_InsertRow_DDDW("cd_regiao" )			

idwc_Rede.SetItem(1, "cd_regiao", 0	)
idwc_Rede.SetItem(1, "de_regiao", "TODAS"	)

select cd_regiao
Into :lvl_Regiao
From regiao
Where nr_matricula_regional = :gvo_aplicacao.ivo_seguranca.nr_matricula
Using SQLCa;

If SQLCa.SQLCode = 0 Then
	dw_1.Object.cd_regiao[1] = lvl_Regiao
Else
	dw_1.Object.cd_regiao[1] = 0	
End If
end subroutine

on w_ge272_consulta_alteracao_porte_filial.create
int iCurrent
call super::create
this.cb_exporta=create cb_exporta
this.dw_4=create dw_4
this.cb_limites=create cb_limites
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_exporta
this.Control[iCurrent+2]=this.dw_4
this.Control[iCurrent+3]=this.cb_limites
end on

on w_ge272_consulta_alteracao_porte_filial.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.cb_exporta)
destroy(this.dw_4)
destroy(this.cb_limites)
end on

event ue_postopen;call super::ue_postopen;//override
String lvs_Colunas[]
String lvs_NmColunas[]

dw_1.Object.dt_calculo[1] = gf_primeiro_dia_mes(RelativeDate(Today(),-28))

This.ivm_menu.ivb_permite_imprimir=True

wf_insere_default()

lvs_Colunas = {'classificacao_rede','id_alterou_porte','cd_filial','de_filial','id_rede','cd_porte','vl_venda_liquida'}
lvs_NmColunas = {'Classifica$$HEX2$$e700e300$$ENDHEX$$o Rede','Porte Alterado','C$$HEX1$$f300$$ENDHEX$$d. Filial','Nome Filial','Rede','Porte','Venda L$$HEX1$$ed00$$ENDHEX$$quida M$$HEX1$$ea00$$ENDHEX$$s Refer$$HEX1$$ea00$$ENDHEX$$ncia'}

dw_2.Of_SetSort(lvs_Colunas,lvs_NmColunas)
dw_2.Of_SetFilter(lvs_Colunas,lvs_NmColunas)

This.ivm_menu.mf_classificar(False)
end event

event ue_saveas;dw_3.Event ue_SaveAs()
end event

event ue_preopen;call super::ue_preopen;MaxHeight = 9999
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge272_consulta_alteracao_porte_filial
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge272_consulta_alteracao_porte_filial
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge272_consulta_alteracao_porte_filial
integer y = 312
integer width = 3593
integer height = 1120
integer weight = 700
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge272_consulta_alteracao_porte_filial
integer width = 2217
integer height = 280
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge272_consulta_alteracao_porte_filial
integer x = 50
integer width = 2194
integer height = 188
string dataobject = "dw_ge272_selecao"
end type

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge272_consulta_alteracao_porte_filial
integer y = 388
integer width = 3525
integer height = 1012
string dataobject = "dw_ge272_filial_venda"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;Date lvdt_Referencia
Date lvdt_Ref_Mes2
Date lvdt_Ref_Mes3

String lvs_Rede
String lvs_Alterado

Long lvl_Regiao

dw_1.Accepttext( )

lvdt_Referencia	= gf_primeiro_dia_mes(dw_1.Object.dt_calculo [1])
lvdt_Ref_Mes2	= gf_primeiro_dia_mes(RelativeDate(lvdt_Referencia,-1))
lvdt_Ref_Mes3	= gf_primeiro_dia_mes(RelativeDate(lvdt_Ref_Mes2,-1))
lvs_Rede			= dw_1.Object.id_rede				[1]
lvs_Alterado		= dw_1.Object.id_porte_alterado	[1]
lvl_Regiao		= dw_1.Object.cd_regiao			[1]

If IsNull(lvdt_Referencia) Then
	MessageBox('Aten$$HEX2$$e700e300$$ENDHEX$$o!','Informe uma data de refer$$HEX1$$ea00$$ENDHEX$$ncia para consultar.')
	dw_1.SetFocus()
	dw_1.Event ue_Pos(1,'dt_calculo')
	Return -1
Else
	This.Object.vl_venda_liquida_2_t.Text	= gf_Mes_Extenso(Month(lvdt_Ref_Mes3))+'/'+String(lvdt_Ref_Mes3,'yyyy')
	This.Object.vl_venda_liquida_1_t.Text	= gf_Mes_Extenso(Month(lvdt_Ref_Mes2))+'/'+String(lvdt_Ref_Mes2,'yyyy')
	This.Object.vl_venda_liquida_t.Text		= gf_Mes_Extenso(Month(lvdt_Referencia))+'/'+String(lvdt_Referencia,'yyyy')
End if

If (Not(IsNull(lvs_Rede)))and(lvs_Rede<>'TD') Then
	This.of_appendwhere("f.id_rede_filial='"+lvs_Rede+"'")
End If

If (Not(IsNull(lvs_Alterado)))and(lvs_Alterado<>'T') Then
	Choose Case lvs_Alterado
		Case 'A'	
			This.of_appendwhere("coalesce(fp.cd_porte,1) <> coalesce(fp1.cd_porte,1)")
		Case 'D' 	
			This.of_appendwhere("coalesce(fp.cd_porte,1) < coalesce(fp1.cd_porte,1)")
		Case 'S'	
			This.of_appendwhere("coalesce(fp.cd_porte,1) > coalesce(fp1.cd_porte,1)")
	End Choose
End If

If lvl_Regiao > 0 Then
	This.of_appendwhere("f.cd_regiao="+String(lvl_Regiao))
End If

Return AncestorReturnValue
end event

event dw_2::ue_recuperar;//override
Date lvdt_Referencia

lvdt_Referencia	= gf_primeiro_dia_mes(dw_1.Object.dt_calculo [1])

Return This.Retrieve(lvdt_Referencia)
end event

event dw_2::constructor;call super::constructor;This.ShareData(dw_3)
This.ShareData(dw_4)
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;Date lvdt_Data 

dw_3.ivm_menu.mf_salvarcomo(pl_linhas > 0)
This.ivm_menu.mf_classificar(pl_linhas > 0)
This.ivm_menu.mf_imprimir(pl_linhas > 0)
cb_exporta.Enabled = (pl_linhas > 0)
cb_limites.Enabled = (pl_linhas > 0)

Return AncestorReturnValue
end event

event dw_2::ue_reset;call super::ue_reset;dw_3.ivm_menu.mf_salvarcomo(False)
This.ivm_menu.mf_classificar(False)
This.ivm_menu.mf_imprimir(False)
cb_exporta.Enabled = (False)
cb_limites.Enabled = (False)

end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge272_consulta_alteracao_porte_filial
integer x = 3310
integer y = 60
integer width = 251
integer height = 160
string dataobject = "dw_ge272_filial_venda_relatorio"
boolean vscrollbar = false
end type

event dw_3::ue_preprint;call super::ue_preprint;Date lvdt_Referencia
Date lvdt_Ref_Mes2
Date lvdt_Ref_Mes3

String lvs_rede
String lvs_Rede_Filtro = ''
String lvs_Regiao_Filtro = ''

Long lvl_Regiao

dw_1.Accepttext( )

lvdt_Referencia	= gf_primeiro_dia_mes(dw_1.Object.dt_calculo [1])
lvdt_Ref_Mes2	= gf_primeiro_dia_mes(RelativeDate(lvdt_Referencia,-1))
lvdt_Ref_Mes3	= gf_primeiro_dia_mes(RelativeDate(lvdt_Ref_Mes2,-1))
lvs_rede			= dw_1.Object.id_rede 		[1]
lvl_Regiao		= dw_1.Object.cd_regiao 	[1]

If lvs_Rede <> 'TD' then
	lvs_Rede_Filtro = lvs_Rede
Else
	This.Object.st_rede.Visible 		= False
	This.Object.st_rede_t.Visible	= False
End If

If lvl_Regiao > 0 then
	lvs_Regiao_Filtro = 'Regi$$HEX1$$e300$$ENDHEX$$o '+String(lvl_Regiao,'##')
Else
	lvs_Regiao_Filtro = 'TODAS'
End If

This.Object.st_rede.Text		= lvs_Rede_Filtro
This.Object.st_regiao.Text	= lvs_Regiao_Filtro
This.Object.st_mes.Text		= gf_Mes_Extenso(Month(lvdt_Referencia))+'/'+String(lvdt_Referencia,'yyyy')
This.Object.t_mes_1.Text	= gf_Mes_Extenso(Month(lvdt_Ref_Mes3))+'/'+String(lvdt_Ref_Mes3,'yyyy')
This.Object.t_mes_2.Text	= gf_Mes_Extenso(Month(lvdt_Ref_Mes2))+'/'+String(lvdt_Ref_Mes2,'yyyy')
This.Object.t_mes_3.Text	= gf_Mes_Extenso(Month(lvdt_Referencia))+'/'+String(lvdt_Referencia,'yyyy')

Return AncestorReturnValue
end event

event dw_3::constructor;call super::constructor;This.Visible = False
end event

type cb_exporta from commandbutton within w_ge272_consulta_alteracao_porte_filial
integer x = 2295
integer y = 64
integer width = 594
integer height = 104
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Exportar Porte Filiais"
end type

event clicked;Long lvl_Linha

Date lvdt_Referencia

lvdt_Referencia = dw_1.Object.dt_calculo	[1]

dw_4.Reset()
For lvl_Linha = 1 To dw_2.RowCount()
	dw_4.Event ue_AddRow()
	dw_4.Object.Filial	[dw_4.RowCount()]	= dw_2.Object.de_filial	[lvl_Linha] + ' ('+String(dw_2.Object.cd_filial [lvl_Linha])+')'
	dw_4.Object.Rede	[dw_4.RowCount()]	= dw_2.Object.id_rede	[lvl_Linha]
	dw_4.Object.Porte	[dw_4.RowCount()]	= dw_2.Object.cd_porte [lvl_Linha]
Next

If dw_4.RowCount() > 0 Then
	dw_4.Object.st_mes.Text = gf_Mes_Extenso(Month(lvdt_Referencia))+'/'+String(lvdt_Referencia,'yyyy')
	dw_4.Event ue_SaveAs()
End If
end event

type dw_4 from dc_uo_dw_base within w_ge272_consulta_alteracao_porte_filial
integer x = 3058
integer y = 60
integer width = 251
integer height = 160
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge272_filial_porte"
boolean border = true
borderstyle borderstyle = styleraised!
end type

event constructor;call super::constructor;This.Visible = False
end event

type cb_limites from commandbutton within w_ge272_consulta_alteracao_porte_filial
integer x = 2295
integer y = 184
integer width = 594
integer height = 104
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Limites Vigentes"
end type

event clicked;String lvs_Rede
Date lvdt_Calculo
 
dw_1.Accepttext( )

If dw_2.GetRow() > 0 Then
	lvs_rede 		= dw_2.Object.id_rede	[dw_2.GetRow()]
Else
	lvs_rede 		= dw_1.Object.id_rede	[1]
End If

lvdt_Calculo = dw_1.Object.dt_calculo	[1]

OpenWithParm(w_ge272_limites_vigentes,lvs_rede+';'+String(lvdt_Calculo))
end event

