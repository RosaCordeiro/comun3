HA$PBExportHeader$w_ge225_consulta_exclusao_nf_compra.srw
forward
global type w_ge225_consulta_exclusao_nf_compra from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge225_consulta_exclusao_nf_compra from dc_w_selecao_lista_relatorio
string accessiblename = "Consulta Exclus$$HEX1$$e300$$ENDHEX$$o de Compra (GE225)"
integer width = 3959
integer height = 1960
string title = "GE225 - Consulta Exclus$$HEX1$$e300$$ENDHEX$$o de Notas Fiscais de Compra"
end type
global w_ge225_consulta_exclusao_nf_compra w_ge225_consulta_exclusao_nf_compra

type variables
uo_Fornecedor 	ivo_Fornecedor	//GE003
uo_Filial 			ivo_Filial				//GE009
uo_Usuario		ivo_Usuario		//GE010
end variables

on w_ge225_consulta_exclusao_nf_compra.create
call super::create
end on

on w_ge225_consulta_exclusao_nf_compra.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;ivo_Filial 				= create uo_Filial
ivo_Fornecedor  		= create uo_Fornecedor
ivo_Usuario			= create uo_Usuario

end event

event close;call super::close;Destroy(ivo_Filial)
Destroy(ivo_Fornecedor)
Destroy(ivo_Usuario)
end event

event ue_postopen;call super::ue_postopen;Date ldt_Data

ldt_Data = Today()

dw_1.Object.Dh_Inicio		[1] = RelativeDate( ldt_Data, -10 )
dw_1.Object.Dh_Termino	[1] = ldt_Data

ivm_Menu.ivb_Permite_Imprimir = true
end event

event ue_preopen;call super::ue_preopen;MaxWidth = 4735
MaxHeight = 9999
end event

event ue_print;call super::ue_print;dw_2.SetFocus()
end event

event ue_printimmediate;call super::ue_printimmediate;dw_3.Event ue_Printimmediate()
end event

event ue_saveas;dw_2.Event ue_SaveAs()
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge225_consulta_exclusao_nf_compra
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge225_consulta_exclusao_nf_compra
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge225_consulta_exclusao_nf_compra
integer y = 448
integer width = 3872
integer height = 1316
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge225_consulta_exclusao_nf_compra
integer width = 3872
integer height = 420
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge225_consulta_exclusao_nf_compra
integer x = 55
integer y = 80
integer width = 3817
integer height = 332
string dataobject = "dw_ge225_selecao"
end type

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "nm_fornecedor"
			ivo_Fornecedor.of_Localiza_Fornecedor(This.GetText())
			
			If ivo_Fornecedor.Localizado Then
				This.Object.Cd_Fornecedor	[1] = ivo_Fornecedor.cd_fornecedor
				This.Object.Nm_Fornecedor	[1] = ivo_Fornecedor.nm_fantasia
			End If
			
		Case "nm_filial"
			ivo_Filial.Of_Localiza_Filial(This.GetText())
			
			If ivo_Filial.Localizada Then
				This.Object.Cd_Filial	[1] = ivo_Filial.cd_filial
				This.Object.Nm_Filial	[1] = ivo_Filial.nm_Fantasia
			End If
			
		Case "nm_usuario"
			ivo_Usuario.Of_Localiza_Usuario(This.GetText())
			
			If ivo_Usuario.Localizado Then
				This.Object.nr_matricula	[1] = ivo_Usuario.nr_matricula
				This.Object.nm_usuario	[1] = ivo_Usuario.nm_usuario
			End If
			
	End Choose
End If
end event

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)
end event

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case "nm_filial"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Filial.nm_fantasia Then
				Return 1
			End If
		Else
			ivo_Filial.of_Inicializa()
			
			This.Object.cd_filial	[1] = ivo_Filial.cd_filial
			This.Object.nm_filial	[1] = ivo_Filial.nm_fantasia
		End If
		
	Case "nm_fornecedor"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Fornecedor.nm_fantasia Then
				Return 1
			End IF
		Else
			ivo_Fornecedor.Of_Inicializa()
			
			This.Object.cd_fornecedor	[1] = ivo_Fornecedor.cd_fornecedor
			This.Object.nm_fornecedor	[1] = ivo_fornecedor.nm_fantasia
		End If
		
	Case "nm_usuario"
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Usuario.nm_usuario Then
				Return 1
			End IF
		Else
			ivo_Usuario.Of_Inicializa()
				
			This.Object.nr_matricula	[1] = ivo_Usuario.nr_matricula
			This.Object.nm_usuario	[1] = ivo_Usuario.nm_usuario
		End If
	
		
End Choose		
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge225_consulta_exclusao_nf_compra
integer x = 64
integer y = 504
integer width = 3817
integer height = 1240
string dataobject = "dw_ge225_lista"
boolean hscrollbar = true
boolean ivb_ordena_colunas = true
end type

event dw_2::constructor;call super::constructor;This.of_SetRowSelection()
end event

event dw_2::ue_recuperar;//OverRide

String lvs_Fornecedor
String lvs_Matricula, lvs_de_chave, lvs_nao_reimport, lvs_desconhecimento
Date lvdh_Inicio, &
	   lvdh_Termino

long lvl_Filial
Long lvl_Nota

dw_1.AcceptText()

lvdh_Inicio    		= dw_1.Object.Dh_Inicio     		 	[1]
lvdh_Termino   	= dw_1.Object.Dh_Termino    	 	[1]
lvl_Filial     			= dw_1.Object.Cd_Filial     		 	[1]
lvs_Fornecedor 	= dw_1.Object.Cd_Fornecedor	 	[1]
lvs_Matricula 		= dw_1.Object.nr_matricula			[1]
lvl_Nota		 		= dw_1.Object.nr_nf				 	[1]
lvs_de_chave		= dw_1.Object.de_chave_acesso	[1]
lvs_nao_reimport  = dw_1.Object.id_nao_reimport	[1]
lvs_desconhecimento = dw_1.Object.id_desconhecimento	[1]   

If IsNull(lvdh_Inicio) or Not IsDate(String(lvdh_Inicio, "dd/mm/yyyy")) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio corretamente.")
	dw_1.Event ue_Pos(1, "dh_inicio")
	Return -1
End If

If IsNull(lvdh_Termino) or Not IsDate(String(lvdh_Termino, "dd/mm/yyyy")) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de T$$HEX1$$e900$$ENDHEX$$rmino corretamente.")
	dw_1.Event ue_Pos(1, "dh_termino")
	Return -1
End If

If lvdh_Termino < lvdh_Inicio Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de Inicio deve ser menor ou igual a data de T$$HEX1$$e900$$ENDHEX$$rmino")
	dw_1.Event ue_Pos(1,"dh_inicio")
	Return -1
End If

If Not IsNull(lvs_Fornecedor) and lvs_Fornecedor <> "" Then
	This.of_appendwhere_subquery("l.cd_fornecedor = '" + lvs_Fornecedor + "'" , 2)
End If

If Not IsNull(lvl_Filial) and lvl_Filial > 0 Then
	This.of_appendwhere_subquery("l.cd_filial = " + String(lvl_Filial),2)
End If

If Not IsNull(lvs_Matricula) and lvs_Matricula <> "" Then
	This.of_appendwhere_subquery("l.nr_matricula_responsavel = '" + lvs_Matricula + "'",2 )
End If

If Not IsNull(lvl_Nota) and lvl_Nota > 0 Then
	This.of_appendwhere_subquery("l.nr_nf = " + String(lvl_Nota),2)
End If

If lvs_de_chave <> '' Then
	This.of_appendwhere_subquery("l.de_chave_acesso = '" + lvs_de_chave + "'",2)
End If

If lvs_nao_reimport = 'S' Then 
	This.of_appendwhere_subquery ( "  exists ( Select * From  nf_compra_reimportacao c Where c.de_chave_acesso = l.de_chave_acesso) ", 2 ) 
End If 	

If lvs_desconhecimento = 'S' Then 
	This.of_appendwhere_subquery("l.id_desconhecimento = '" + lvs_desconhecimento + "'",2) 
End If 	


lvdh_Termino = RelativeDate(lvdh_Termino,1)

Return This.Retrieve(lvdh_Inicio, lvdh_Termino)
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;ivm_Menu.mf_SalvarComo(pl_Linhas > 0)
ivm_Menu.mf_Imprimir(pl_Linhas > 0)

Return pl_Linhas


end event

event dw_2::ue_print;call super::ue_print;dw_3.Event ue_Print()
end event

event dw_2::ue_printimmediate;call super::ue_printimmediate;dw_3.Event ue_Print()
end event

event dw_2::ue_reset;call super::ue_reset;ivm_Menu.mf_SalvarComo(False)
ivm_Menu.mf_Imprimir(False)
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge225_consulta_exclusao_nf_compra
integer x = 3424
integer y = 32
integer width = 338
integer height = 268
string dataobject = "dw_ge225_relatorio"
end type

event dw_3::ue_preprint;call super::ue_preprint;Date	lvdh_Inicio, &
		lvdh_Termino

String lvs_Fornecedor, &
		lvs_Filial

dw_1.AcceptText()

lvdh_Inicio			= dw_1.Object.dh_inicio			[1]
lvdh_Termino		= dw_1.Object.dh_termino		[1]
lvs_Fornecedor 	= dw_1.Object.nm_fornecedor	[1]
lvs_Filial				= dw_1.Object.nm_filial 			[1]

dw_3.Object.st_periodo.Text = String(lvdh_Inicio,"dd/mm/yyyy") + " $$HEX1$$e000$$ENDHEX$$ " + String(lvdh_Termino,"dd/mm/yyyy")

If lvs_Fornecedor <> "" Then
	dw_3.Object.st_Fornecedor.Text = lvs_Fornecedor
Else
	dw_3.Object.st_Fornecedor.Text = "TODOS"
End If

If lvs_Filial <> "" Then
	dw_3.Object.st_Filial.Text = lvs_Filial
Else
	dw_3.Object.st_Filial.Text = "TODOS"
End If

return AncestorReturnValue
end event

