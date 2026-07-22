HA$PBExportHeader$w_ge004_selecao_convenio.srw
forward
global type w_ge004_selecao_convenio from dc_w_selecao_generica
end type
end forward

global type w_ge004_selecao_convenio from dc_w_selecao_generica
integer x = 160
integer width = 3346
integer height = 1536
string title = "GE004 - Sele$$HEX2$$e700e300$$ENDHEX$$o de Conv$$HEX1$$ea00$$ENDHEX$$nios"
end type
global w_ge004_selecao_convenio w_ge004_selecao_convenio

on w_ge004_selecao_convenio.create
call super::create
end on

on w_ge004_selecao_convenio.destroy
call super::destroy
end on

event open;call super::open;String 	lvs_Convenio, &
		lvs_DataObject

lvs_Convenio = Message.StringParm

If Trim(lvs_Convenio) <> "" Then
	dw_1.Object.Nm_Fantasia[1] = lvs_Convenio
	ivb_Pesquisa_Direta = True
End If

// Seleciona a dw que cont$$HEX1$$e900$$ENDHEX$$m somente os conv$$HEX1$$ea00$$ENDHEX$$nios da filial
If gvo_parametro.cd_filial <> gvo_parametro.cd_filial_matriz Then
	lvs_DataObject = "dw_ge004_lista_filial"
Else
	lvs_DataObject = "dw_ge004_lista_matriz"
End If	

dw_2.of_ChangeDataObject(lvs_DataObject)
dw_2.of_SetRowSelection()



end event

type pb_help from dc_w_selecao_generica`pb_help within w_ge004_selecao_convenio
end type

type gb_2 from dc_w_selecao_generica`gb_2 within w_ge004_selecao_convenio
integer x = 18
integer y = 284
integer width = 3273
integer height = 1000
long backcolor = 80269524
string text = "Lista de Conv$$HEX1$$ea00$$ENDHEX$$nios"
end type

type gb_1 from dc_w_selecao_generica`gb_1 within w_ge004_selecao_convenio
integer x = 23
integer y = 4
integer width = 1723
integer height = 256
long backcolor = 80269524
end type

type dw_1 from dc_w_selecao_generica`dw_1 within w_ge004_selecao_convenio
integer x = 41
integer y = 64
integer width = 1696
integer height = 180
string dataobject = "dw_ge004_selecao"
end type

type dw_2 from dc_w_selecao_generica`dw_2 within w_ge004_selecao_convenio
integer x = 46
integer y = 336
integer width = 3227
integer height = 924
string dataobject = "dw_ge004_lista_matriz"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String 	lvs_Sql, &
       		lvs_Fantasia, &
		lvs_Nr_CNPJ

dw_1.AcceptText()

lvs_Fantasia = Trim(dw_1.Object.Nm_Fantasia[1])
lvs_Nr_CNPJ = Trim(dw_1.Object.Nr_CNPJ[1])

If lvs_Fantasia <> "" Then
	This.of_AppendWhere("convenio.nm_fantasia like '" + lvs_Fantasia + "%'")
	Return 1
Else
	If lvs_Nr_CNPJ <> "" Then
		This.of_AppendWhere("convenio.nr_cgc like '" + lvs_Nr_CNPJ + "%'")
		Return 1
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!","Informe algum par$$HEX1$$e200$$ENDHEX$$metro de sele$$HEX2$$e700e300$$ENDHEX$$o.",Exclamation!,Ok!)
		dw_1.SetColumn("nm_fantasia")
		dw_1.SetFocus()	
		Return -1
	End If
End If
end event

type cb_selecionar from dc_w_selecao_generica`cb_selecionar within w_ge004_selecao_convenio
integer x = 2533
end type

event cb_selecionar::clicked;call super::clicked;Long lvl_Linha, &
     lvl_Convenio

lvl_Linha = dw_2.GetRow()

If lvl_Linha > 0 Then
	lvl_Convenio = dw_2.Object.Cd_Convenio[lvl_Linha]
	CloseWithReturn(Parent, String(lvl_Convenio))
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um conv$$HEX1$$ea00$$ENDHEX$$nio na lista.", Information!, Ok!)
	dw_2.SetFocus()
End If
end event

type cb_cancelar from dc_w_selecao_generica`cb_cancelar within w_ge004_selecao_convenio
integer x = 2926
end type

event cb_cancelar::clicked;call super::clicked;String lvs_Convenio

SetNull(lvs_Convenio)

CloseWithReturn(Parent, lvs_Convenio)
end event

type cb_pesquisar from dc_w_selecao_generica`cb_pesquisar within w_ge004_selecao_convenio
integer x = 1929
end type

type st_mensagem from dc_w_selecao_generica`st_mensagem within w_ge004_selecao_convenio
integer x = 27
integer y = 1328
long backcolor = 80269524
end type

