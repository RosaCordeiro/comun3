HA$PBExportHeader$w_ge654_devolucoes_convenio_ecommerce.srw
forward
global type w_ge654_devolucoes_convenio_ecommerce from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge654_devolucoes_convenio_ecommerce from dc_w_selecao_lista_relatorio
integer width = 4507
integer height = 2372
string title = "GE654 - Relat$$HEX1$$f300$$ENDHEX$$rio Devolu$$HEX2$$e700f500$$ENDHEX$$es Conv$$HEX1$$ea00$$ENDHEX$$nio Ecommerce"
end type
global w_ge654_devolucoes_convenio_ecommerce w_ge654_devolucoes_convenio_ecommerce

type variables
uo_Filial 		ivo_Filial
uo_convenio ivo_Convenio
uo_conveniado ivo_Conveniado
end variables

on w_ge654_devolucoes_convenio_ecommerce.create
call super::create
end on

on w_ge654_devolucoes_convenio_ecommerce.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_print;dw_2.Event ue_imprimir_relatorio(dw_2.Title, 'CL', False)
end event

event ue_printimmediate;dw_2.Event ue_imprimir_relatorio(dw_2.Title, 'CL', True)
end event

event ue_preopen;call super::ue_preopen;ivo_Filial = Create uo_Filial
ivo_Convenio = Create uo_convenio
ivo_Conveniado = Create uo_conveniado

end event

event ue_postopen;call super::ue_postopen;date ldt_atual

ldt_atual = date(gf_getserverdate())

dw_1.object.dh_inicio[1] = ldt_atual
dw_1.object.dh_fim[1] = ldt_atual

ivm_Menu.ivb_Permite_Imprimir = True

This.ivm_Menu.mf_Recuperar(True)
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge654_devolucoes_convenio_ecommerce
integer x = 105
integer y = 1936
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge654_devolucoes_convenio_ecommerce
integer x = 69
integer y = 1864
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge654_devolucoes_convenio_ecommerce
integer width = 4407
integer height = 1788
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge654_devolucoes_convenio_ecommerce
integer width = 4283
integer height = 348
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge654_devolucoes_convenio_ecommerce
integer width = 4210
integer height = 264
string dataobject = "dw_ge654_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;Dw_2.Event ue_reset()

Choose Case dwo.Name
		
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
		
	Case "nm_convenio"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If data <> ivo_Convenio.nm_Fantasia Then
				Return 1
			End If
		Else
			
			ivo_Convenio.of_inicializa( )
			
		End if
		
	Case "nm_conveniado"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If data <> ivo_Conveniado.nm_conveniado Then
				Return 1
			End If
		ELse
			ivo_Conveniado.of_inicializa( )
			
		ENd if
		
End Choose
end event

event dw_1::editchanged;call super::editchanged;Long lvl_nulo
String lvs_Coluna

SetNull(lvl_nulo)

lvs_Coluna = dwo.name

Choose Case lvs_Coluna 
	Case "nm_convenio"
		If data <> ivo_Convenio.nm_Fantasia Then
		    
			This.Object.cd_convenio[1] = lvl_nulo
			This.Object.cd_conveniado[1] = String(lvl_nulo)
			This.Object.nm_conveniado[1] = String(lvl_nulo)
			This.Object.nm_conveniado.Protect = 1
			
			 Return 1
		End If
	Case "nm_conveniado"
		If data <> ivo_Conveniado.nm_conveniado Then
		    This.Object.cd_conveniado[1] = String(lvl_nulo)
			 Return 1
		End If
End Choose
		
end event

event dw_1::ue_key;call super::ue_key;String lvs_convenio
If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case  "nm_convenio" 
 			 	
			 ivo_Convenio.of_Localiza_convenio(This.GetText())

			If Ivo_Convenio.Localizado Then

				 dw_1.Object.Cd_Convenio[1] = ivo_Convenio.Cd_Convenio
 	  	   		 dw_1.Object.Nm_convenio[1] = ivo_Convenio.Nm_Fantasia
			End If
			
		lvs_convenio = dw_1.Object.Nm_convenio[1] 		
		
		If  Not IsNull(lvs_convenio) or Trim(lvs_convenio) = "" Then
			dw_1.Object.nm_conveniado.Protect = 0
		End If
	
		Case "nm_conveniado" 
	
		  ivo_Conveniado.of_localiza_conveniado(ivo_Convenio.Cd_Convenio,This.GetText())
		  
			If Ivo_Conveniado.Localizado Then
				dw_1.Object.cd_conveniado[1] = ivo_Conveniado.Cd_Conveniado
				dw_1.Object.Nm_Conveniado[1] = ivo_Conveniado.Nm_Conveniado
			End If
		 

	Case "nm_filial"
			ivo_filial.Of_Localiza_Filial(This.GetText()) 
			
			If ivo_filial.Localizada Then
				  
				This.Object.cd_filial	[1] = ivo_filial.cd_filial
				This.Object.nm_filial	[1] = ivo_filial.nm_fantasia
				
			End If

	End Choose
End If



end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge654_devolucoes_convenio_ecommerce
integer width = 4352
integer height = 1688
string title = "GE654 - Relat$$HEX1$$f300$$ENDHEX$$rio Devolu$$HEX2$$e700f500$$ENDHEX$$es Conv$$HEX1$$ea00$$ENDHEX$$nio Ecommerce"
string dataobject = "dw_ge654_lista"
boolean hscrollbar = true
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_recuperar;datetime ldt_ini, ldt_fim

ldt_ini = Datetime(dw_1.object.dh_inicio[1], time('00:00'))
ldt_fim = Datetime(dw_1.object.dh_fim[1], time('23:59:59'))

Return This.Retrieve(ldt_ini, ldt_fim)


end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;Date ldt_ini
Date ldt_fim
Long ll_Cd_filial
Long ll_nr_pedido_ecommerce
Long ll_nr_nf
Long ll_Cd_convenio
String ls_cd_conveniado
String ls_id_situacao
String ls_id_dev_lote_fechado

dw_1.accepttext( )

ldt_ini = dw_1.object.dh_inicio[1]
ldt_fim = dw_1.object.dh_fim[1]
ll_Cd_filial = dw_1.object.cd_filial[1]
ll_nr_pedido_ecommerce = dw_1.object.nr_pedido_ecommerce[1]
ll_nr_nf = dw_1.object.nr_nf[1]
ll_Cd_convenio = dw_1.object.cd_convenio[1]
ls_cd_conveniado = dw_1.object.cd_conveniado[1]
ls_id_situacao = dw_1.object.id_situacao_cancelamento[1]
ls_id_dev_lote_fechado = dw_1.object.id_devolucao_lote_fechado[1]

if isnull(ldt_ini) or ldt_ini = date('01/01/1900') Then
	messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','O Campo per$$HEX1$$ed00$$ENDHEX$$odo inicial deve ser preenchido.')
	dw_1.setcolumn('dh_inicio')
	dw_1.setfocus()
	return -1
End if

if isnull(ldt_fim) or ldt_fim = date('01/01/1900') Then
	messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','O Campo per$$HEX1$$ed00$$ENDHEX$$odo final deve ser preenchido.')
	dw_1.setcolumn('dh_fim')
	dw_1.setfocus()
	return -1
End if

if ldt_ini > ldt_fim Then
	messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','O Campo per$$HEX1$$ed00$$ENDHEX$$odo inicial deve ser inferior ao per$$HEX1$$ed00$$ENDHEX$$odo final.')
	dw_1.setcolumn('dh_inicio')
	dw_1.setfocus()
	return -1
End if

if ll_Cd_filial > 0 Then
	this.of_appendwhere_subquery('f.cd_filial = ' + string(ll_Cd_filial),2)
End if

if ll_nr_nf > 0 Then
	this.of_appendwhere_subquery('nd.nr_nf = ' + string(ll_nr_nf),2)
ENd if

if ll_nr_pedido_ecommerce > 0 Then
	this.of_appendwhere_subquery('nv.nr_pedido_ecommerce = ' + string(ll_nr_pedido_ecommerce),2)
ENd if

if ls_id_situacao = 'N' Then
	this.of_appendwhere_subquery('nd.dh_cancelamento is null ',2)
Elseif ls_id_situacao = 'C' Then
	this.of_appendwhere_subquery('nd.dh_cancelamento is not null ',2)
End if

if ls_id_dev_lote_fechado = 'S' Then
	this.of_appendwhere_subquery("nd.id_tipo_devolucao = 'E'",2)
ENd if

if ll_Cd_convenio > 0 Then
	this.of_appendwhere_subquery('nd.cd_convenio = ' + string(ll_Cd_convenio),2)
ENd if

if ls_cd_conveniado <> '' and not isnull(ls_cd_conveniado) Then
	this.of_appendwhere_subquery("nd.cd_conveniado = '" + ls_cd_conveniado + "'",2)
ENd if

return 1

end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;This.ivm_Menu.mf_SalvarComo(pl_linhas > 0)

return pl_linhas
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge654_devolucoes_convenio_ecommerce
integer x = 4279
integer y = 88
end type

