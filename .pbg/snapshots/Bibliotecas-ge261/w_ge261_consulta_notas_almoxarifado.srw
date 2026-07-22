HA$PBExportHeader$w_ge261_consulta_notas_almoxarifado.srw
forward
global type w_ge261_consulta_notas_almoxarifado from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge261_consulta_notas_almoxarifado from dc_w_selecao_lista_relatorio
string tag = "w_ge261_consulta_notas_compras"
integer width = 3602
integer height = 1900
string title = "GE261 - Consulta Notas Almoxarifado"
long backcolor = 80269524
end type
global w_ge261_consulta_notas_almoxarifado w_ge261_consulta_notas_almoxarifado

type variables
uo_fornecedor  ivo_fornecedor
//uo_filial             ivo_filial
end variables

forward prototypes
public subroutine wf_localiza_fornecedor ()
end prototypes

public subroutine wf_localiza_fornecedor ();STRING lvs_fornecedor

lvs_fornecedor = dw_1.GetText()

ivo_fornecedor.Of_Localiza_fornecedor(lvs_fornecedor)

If ivo_fornecedor.Localizado Then
	
	dw_1.Object.cd_fornecedor[1] = ivo_fornecedor.cd_fornecedor
   dw_1.Object.nm_fornecedor[1] = ivo_fornecedor.nm_fantasia
	
End If

end subroutine

on w_ge261_consulta_notas_almoxarifado.create
call super::create
end on

on w_ge261_consulta_notas_almoxarifado.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;dw_1.Object.dt_inicio [1] = today()
dw_1.Object.dt_termino[1] = today()

This.ivm_Menu.ivb_Permite_Imprimir = True


end event

event close;call super::close;Destroy(ivo_fornecedor)
end event

event ue_preopen;call super::ue_preopen;ivo_fornecedor = Create uo_fornecedor

MaxWidth = 4125
MaxHeight = 2000
end event

event ue_saveas;dw_3.Event ue_SaveAs()
end event

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge261_consulta_notas_almoxarifado
integer y = 296
integer width = 3497
integer height = 1400
integer weight = 700
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge261_consulta_notas_almoxarifado
integer width = 2135
integer height = 268
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge261_consulta_notas_almoxarifado
integer y = 72
integer width = 2080
integer height = 184
string dataobject = "dw_ge261_selecao"
end type

event dw_1::ue_key;call super::ue_key;String  lvs_coluna

lvs_coluna = This.GetColumnName()

If Key = KeyEnter! Then
	
	If lvs_coluna = "nm_fornecedor" Then
		wf_Localiza_Fornecedor()
	END IF

End If
end event

event dw_1::itemchanged;call super::itemchanged;If dwo.name = 'nm_fornecedor' Then
	If IsNull(Data) Then
		ivo_Fornecedor.of_Inicializa()		
		This.Object.cd_Fornecedor[1] = ivo_Fornecedor.cd_fornecedor
		This.Object.nm_Fornecedor[1] = ivo_Fornecedor.nm_razao_social
	End If
End If
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge261_consulta_notas_almoxarifado
integer y = 372
integer width = 3429
integer height = 1292
string dataobject = "dw_ge261_lista"
boolean hscrollbar = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_cd_fornecedor

dw_1.AcceptText()

lvs_cd_fornecedor     = dw_1.Object.cd_fornecedor	[1]

If Not IsNull(lvs_cd_fornecedor) Then
	dw_2.of_appendwhere("nf.cd_fornecedor = '" + String(lvs_cd_fornecedor)	+ "'")
End If

Return AncestorReturnValue
end event

event dw_2::ue_recuperar;//OverRide

Date lvdt_Inicio   ,&
     lvdt_Termino

dw_1.AcceptText()

lvdt_Inicio		= dw_1.Object.dt_inicio		[1]
lvdt_Termino	= dw_1.Object.dt_termino	[1]

If Isnull(lvdt_Inicio) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","$$HEX1$$c900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio informar a data inicial.",Information!)
	Return -1
End If 

If Isnull(lvdt_Termino) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","$$HEX1$$c900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio informar a data de termino.",Information!)
	Return -1
End If 

If lvdt_Termino < lvdt_Inicio Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","A data de termino n$$HEX1$$e300$$ENDHEX$$o pode ser superior a data inicial.",Information!)
	Return -1
End If

Return This.Retrieve(lvdt_inicio,lvdt_termino)
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;ivm_menu.mf_salvarcomo(pl_linhas > 0)
ivm_menu.mf_imprimir(pl_linhas > 0)

Return AncestorReturnValue
end event

event dw_2::ue_reset;call super::ue_reset;ivm_menu.mf_salvarcomo(False)
ivm_menu.mf_imprimir(False)

end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge261_consulta_notas_almoxarifado
integer x = 2766
integer y = 36
integer taborder = 50
string dataobject = "dw_ge261_relatorio"
end type

event dw_3::ue_preprint;call super::ue_preprint;Date   lvdt_inicial		       , &
		 lvdt_final              
		 
String  lvs_cd_fornecedor       , &
		 lvs_nm_fornecedor

dw_1.AcceptText()

lvs_cd_fornecedor     = dw_1.Object.cd_fornecedor	[1]
lvdt_inicial				= dw_1.Object.dt_inicio    		[1]
lvdt_final					= dw_1.Object.dt_termino		[1]
lvs_nm_fornecedor	= dw_1.Object.nm_fornecedor	[1]

dw_3.Object.st_periodo.text = String(lvdt_inicial,"dd/mm/yyyy") + ' $$HEX1$$e000$$ENDHEX$$ ' + &
										String(lvdt_final  ,"dd/mm/yyyy")

If Not IsNull(lvs_cd_fornecedor) Then
	dw_3.Object.st_fornecedor.text = lvs_nm_fornecedor + ' (' + lvs_cd_fornecedor + ')'
Else
	dw_3.Object.st_fornecedor.text = 'TODOS'
End If

Return AncestorReturnValue
end event

