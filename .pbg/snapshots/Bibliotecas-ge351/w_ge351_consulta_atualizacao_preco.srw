HA$PBExportHeader$w_ge351_consulta_atualizacao_preco.srw
forward
global type w_ge351_consulta_atualizacao_preco from dc_w_cadastro_selecao_lista
end type
end forward

global type w_ge351_consulta_atualizacao_preco from dc_w_cadastro_selecao_lista
integer width = 2414
integer height = 2296
string title = "GE351 - Hist$$HEX1$$f300$$ENDHEX$$rico de Altera$$HEX2$$e700e300$$ENDHEX$$o de Pre$$HEX1$$e700$$ENDHEX$$o de Distribuidoras"
end type
global w_ge351_consulta_atualizacao_preco w_ge351_consulta_atualizacao_preco

forward prototypes
public subroutine wf_insere_distribuidora_padrao ()
end prototypes

public subroutine wf_insere_distribuidora_padrao ();DataWindowChild lvdwc

lvdwc = dw_1.of_InsertRow_DDDW("cd_distribuidora")			

lvdwc.SetItem(1, "cd_fornecedor", "000000000")
lvdwc.SetItem(1, "nm_fantasia"  , "TODOS")

dw_1.Object.Cd_Distribuidora[1] = "000000000"
end subroutine

on w_ge351_consulta_atualizacao_preco.create
call super::create
end on

on w_ge351_consulta_atualizacao_preco.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;wf_Insere_Distribuidora_Padrao()

dw_1.Object.dh_inicio	[1] = Date(gf_GetServerDate())
dw_1.Object.dh_termino	[1] = Date(gf_GetServerDate())

This.ivm_Menu.mf_Incluir(False)
end event

type dw_visual from dc_w_cadastro_selecao_lista`dw_visual within w_ge351_consulta_atualizacao_preco
integer y = 1496
end type

type gb_aux_visual from dc_w_cadastro_selecao_lista`gb_aux_visual within w_ge351_consulta_atualizacao_preco
integer y = 1424
end type

type dw_1 from dc_w_cadastro_selecao_lista`dw_1 within w_ge351_consulta_atualizacao_preco
integer x = 64
integer y = 76
integer width = 1719
integer height = 228
string dataobject = "dw_ge351_selecao"
end type

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)
end event

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case "id_atualizado"
		If Data = "S" Then
			This.Object.Id_Pendente[1] = "N"
		Else
			This.Object.Id_Pendente[1] = "S"
		End If
		
	Case "id_pendente"
		If Data = "S" Then
			This.Object.Id_Atualizado[1] = "N"
		Else
			This.Object.Id_Atualizado[1] = "S"
		End If
End Choose

dw_2.Event ue_Reset()
end event

type gb_2 from dc_w_cadastro_selecao_lista`gb_2 within w_ge351_consulta_atualizacao_preco
integer y = 348
integer width = 2304
integer height = 1736
integer weight = 700
fontcharset fontcharset = ansi!
end type

type gb_1 from dc_w_cadastro_selecao_lista`gb_1 within w_ge351_consulta_atualizacao_preco
integer width = 1765
integer height = 336
integer weight = 700
end type

type dw_2 from dc_w_cadastro_selecao_lista`dw_2 within w_ge351_consulta_atualizacao_preco
integer y = 424
integer width = 2222
integer height = 1636
string dataobject = "dw_ge351_lista"
end type

event dw_2::ue_recuperar;//OverRide

Date ldh_Inicio
Date ldh_Termino

String ls_Distrib
String ls_Atualizado
String ls_Pendencia
String ls_Dw

dw_1.AcceptText()

ldh_Inicio 		= dw_1.Object.dh_inicio				[1]
ldh_Termino 	= dw_1.Object.dh_termino			[1]
ls_Distrib 		= dw_1.Object.Cd_Distribuidora	[1]
ls_Atualizado	= dw_1.Object.Id_Atualizado		[1]
ls_Pendencia	= dw_1.Object.Id_Pendente			[1]

If IsNull(ldh_Inicio) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o data do in$$HEX1$$ed00$$ENDHEX$$cio corretamente.")
	dw_1.Event ue_Pos(1, "dh_inicio")
	Return -1
End If

If IsNull(ldh_Termino) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o data do t$$HEX1$$e900$$ENDHEX$$rmino corretamente.")
	dw_1.Event ue_Pos(1, "dh_termino")
	Return -1
End If

If ldh_Inicio > ldh_Termino Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de in$$HEX1$$ed00$$ENDHEX$$cio deve ser menor que a data de t$$HEX1$$e900$$ENDHEX$$rmino.")
	dw_1.Event ue_Pos(1, "dh_termino")
	Return -1
End If

If ls_Distrib <> '000000000' Then
	If ls_Atualizado = "S" Then
		dw_2.of_AppendWhere("c.cd_distribuidora = '" + ls_Distrib + "'")
	End If
	
	If ls_Pendencia = "S" Then
		dw_2.of_AppendWhere("f.cd_fornecedor = '" + ls_Distrib + "'")
	End If
End If

If ls_Atualizado = "S" Then
	ls_Dw = "dw_ge351_lista"
End If

If ls_Pendencia = "S" Then
	ls_Dw = "dw_ge351_preco_nao_atualizado"
End If

If This.DataObject <> ls_DW Then
	If Not This.of_ChangeDataObject(ls_DW) Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar a data window '" + ls_DW + "'.", StopSign!)
		Return -1
	End If
End If

This.of_SetRowSelection()

Return This.Retrieve(ldh_Inicio,ldh_Termino )
end event

event dw_2::ue_postretrieve;// OverRide

Boolean lvb_Classificar, &
        lvb_Filtrar, &
		  lvb_Localizar, &
		  lvb_Excluir

If pl_Linhas > 0 Then
	lvb_Classificar	= IsValid(This.ivo_Sort)
	lvb_Filtrar		= IsValid(This.ivo_Filter)
	lvb_Localizar	= IsValid(This.ivo_Find)
	
	lvb_Excluir = True

	dw_2.ivo_Controle_Menu.of_SalvarComo(True)

	This.SetRow(1)
	This.SetFocus()
Else
	dw_2.ivo_Controle_Menu.of_SalvarComo(False)
	
	If pl_Linhas = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.", Information!)
	End If
End If

Parent.ivm_Menu.mf_Classificar(lvb_Classificar)
Parent.ivm_Menu.mf_Filtrar(lvb_Filtrar)
Parent.ivm_Menu.mf_Localizar(lvb_Localizar)
Parent.ivm_Menu.mf_Excluir(lvb_Excluir)

Return pl_Linhas
end event

