HA$PBExportHeader$w_ge456_versao_sistema_pdv.srw
forward
global type w_ge456_versao_sistema_pdv from dc_w_cadastro_selecao_lista
end type
end forward

global type w_ge456_versao_sistema_pdv from dc_w_cadastro_selecao_lista
integer width = 2880
integer height = 1892
string title = "GE456 - Manuten$$HEX2$$e700e300$$ENDHEX$$o de Vers$$HEX1$$e300$$ENDHEX$$o de Sistema por PDV"
end type
global w_ge456_versao_sistema_pdv w_ge456_versao_sistema_pdv

type variables
uo_filial io_filial
end variables

on w_ge456_versao_sistema_pdv.create
call super::create
end on

on w_ge456_versao_sistema_pdv.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;io_filial = create uo_filial

DataWindowChild lvdwc_Linha

lvdwc_Linha = dw_1.of_InsertRow_DDDW("nm_sistema")			

lvdwc_Linha.SetItem(1, "cd_sistema", "00")
lvdwc_Linha.SetItem(1, "nm_sistema", "TODOS")

dw_1.Object.nm_Sistema[1] = "00"

io_Filial.of_Localiza_Codigo( gvo_Parametro.cd_Filial )

dw_1.Object.Cd_Filial			[1] = io_Filial.Cd_Filial
dw_1.Object.Nm_Fantasia	[1] = io_Filial.Nm_Fantasia
end event

event close;call super::close;if isvalid( io_filial ) then destroy io_filial
end event

type dw_visual from dc_w_cadastro_selecao_lista`dw_visual within w_ge456_versao_sistema_pdv
end type

type gb_aux_visual from dc_w_cadastro_selecao_lista`gb_aux_visual within w_ge456_versao_sistema_pdv
end type

type dw_1 from dc_w_cadastro_selecao_lista`dw_1 within w_ge456_versao_sistema_pdv
integer x = 59
integer y = 72
integer width = 2715
integer height = 264
string dataobject = "dw_ge456_selecao"
end type

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	Choose Case This.GetColumnName( )
		Case "nm_fantasia"
			io_Filial.of_Localiza_Filial( This.GetText() )
		
			If io_Filial.Localizada Then
				This.Object.Cd_Filial		[1] = io_Filial.Cd_Filial
				This.Object.Nm_Fantasia	[1] = io_Filial.Nm_Fantasia
			End If
	End Choose
End If

end event

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case "nm_fantasia"
		If Not IsNull( Data ) and Trim( Data ) <> "" Then
			If Data <> io_Filial.Nm_Fantasia Then
				Return 1
			End If
		Else
			io_Filial.of_Inicializa()
			
			This.Object.Cd_Filial		[1] = io_Filial.Cd_Filial
			This.Object.Nm_Fantasia	[1] = io_Filial.Nm_Fantasia
		End If
End Choose
end event

event dw_1::losefocus;call super::losefocus;If IsValid( io_Filial ) Then
	This.Object.Nm_Fantasia[1] = io_Filial.Nm_Fantasia	
End If
end event

event dw_1::ue_cancel;//OverRide

// N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ necess$$HEX1$$e100$$ENDHEX$$rio limpar as op$$HEX2$$e700f500$$ENDHEX$$es preenchidas pelo usuario
end event

type gb_2 from dc_w_cadastro_selecao_lista`gb_2 within w_ge456_versao_sistema_pdv
integer x = 32
integer y = 348
integer width = 2770
integer height = 1336
integer weight = 700
fontcharset fontcharset = ansi!
end type

type gb_1 from dc_w_cadastro_selecao_lista`gb_1 within w_ge456_versao_sistema_pdv
integer x = 32
integer width = 2770
integer height = 340
integer weight = 700
end type

type dw_2 from dc_w_cadastro_selecao_lista`dw_2 within w_ge456_versao_sistema_pdv
integer x = 59
integer y = 404
integer width = 2720
integer height = 1256
string dataobject = "dw_ge456_lista"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String ls_Sistema
String ls_PDV

dw_1.AcceptText( )

If Not IsNull( io_Filial.cd_Filial ) Then
	This.of_AppendWhere( "cd_filial = " + String( io_Filial.cd_Filial ) )
End If

ls_Sistema	= dw_1.Object.Nm_Sistema	[1]

ls_PDV = Upper( dw_1.Object.Nm_PDV[1] )

If ls_Sistema <> '00' Then
	This.of_AppendWhere( "cd_sistema = '" + ls_Sistema + "'" )
End If

If Not IsNull( ls_PDV ) Then
	This.of_AppendWhere( "upper( nm_pdv ) like '%" + ls_PDV + "%'" )
End If

Return AncestorReturnValue
end event

event dw_2::constructor;call super::constructor;This.ivb_Ordena_Colunas = True
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;Parent.ivm_Menu.mf_Incluir( False )
Parent.ivm_Menu.mf_Confirmar( False )

Return AncestorReturnValue
end event

event dw_2::ue_deleterow;//OverRide
Integer li_Linha
String ls_Selecao

This.AcceptText( )

If This.Find( "id_selecao = 'S'", 1, This.RowCount( ) ) = 0 Then
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma linha selecionada para exclus$$HEX1$$e300$$ENDHEX$$o.", Exclamation! )
	Return False
End If

If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Confirma exclus$$HEX1$$e300$$ENDHEX$$o do(s) registro(s) ?", Question!, YesNo!, 2) = 2 Then
	Return False
End If

This.SetFilter( "id_selecao = 'S'" )
This.Filter( )
	
Try
	For li_Linha = 1 To This.RowCount( )
		If This.DeleteRow( li_Linha -1 ) <> 1 Then
			Return False
		End If
		
		li_Linha --
	Next
	
	If Not IsNull(ivm_Menu) Then
		ivm_Menu.mf_Cancelar(True)
		
		If This.RowCount() = 0 Then	
			ivm_Menu.mf_Imprimir(False)
			ivm_Menu.mf_Excluir(False)
		ElseIf This.RowCount() = 1 Then
			ivm_Menu.mf_Classificar(False)
			ivm_Menu.mf_Filtrar(False)
			ivm_Menu.mf_Localizar(False)
		End If	
	End If
	
	// Se for uma DW atualiz$$HEX1$$e100$$ENDHEX$$vel, habilita a valida$$HEX2$$e700e300$$ENDHEX$$o do closequery da janela
	If ivb_UpdateAble Then
		ivw_ParentWindow.ivb_Valida_Salva = True
	End If
Catch( runtimeerror ru )
	MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o", ru.getMessage( ), StopSign! )
	Return False
Finally
	This.SetFilter( "" )
	This.Filter( )
End Try

Parent.Event ue_Save( )

Return True
end event

event dw_2::itemchanged;call super::itemchanged;Parent.ivm_Menu.mf_Confirmar(False)
Parent.ivm_Menu.mf_Excluir(True)
end event

event dw_2::editchanged;call super::editchanged;Parent.ivm_Menu.mf_Confirmar(False)
Parent.ivm_Menu.mf_Excluir(True)
end event

