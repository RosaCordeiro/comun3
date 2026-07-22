HA$PBExportHeader$w_ge161_consulta_filial_distribuidora.srw
forward
global type w_ge161_consulta_filial_distribuidora from dc_w_cadastro_selecao_lista
end type
end forward

global type w_ge161_consulta_filial_distribuidora from dc_w_cadastro_selecao_lista
string tag = "w_ge161_consulta_filial_distribuidora"
integer width = 3694
integer height = 2172
string title = "GE161 - Consulta de Filial na Distribuidora"
boolean resizable = false
end type
global w_ge161_consulta_filial_distribuidora w_ge161_consulta_filial_distribuidora

type variables
uo_filial ivo_filial

string ivs_filiais, ivs_nulo

uo_ge216_filiais ivo_Selecao_filiais
end variables

forward prototypes
public subroutine wf_insere_distribuidora_default ()
end prototypes

public subroutine wf_insere_distribuidora_default ();DataWindowChild lvdwc

Integer lvi_Retorno,&
        lvi_Row

If dw_1.GetChild("cd_distribuidora", lvdwc) = 1 Then
	lvdwc.InsertRow(1)
	
	lvdwc.SetItem(1, "cd_fornecedor", "000000000")
	lvdwc.SetItem(1, "nm_fantasia",   "TODAS")
	
	dw_1.Object.Cd_Distribuidora[1] = "000000000"
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild da distribuidora.")
End If
end subroutine

on w_ge161_consulta_filial_distribuidora.create
call super::create
end on

on w_ge161_consulta_filial_distribuidora.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;// OverRide

ivo_dbError 			= Create dc_uo_dbError

ivo_Selecao_filiais 	= Create uo_ge216_filiais

//dc_uo_dw_Base lvo_Update[]
//lvo_Update = {dw_2}
//This.wf_SetUpdate_DW(lvo_Update)

dw_1.Event ue_AddRow()
dw_1.SetFocus()

This.ivm_Menu.mf_Recuperar(True)

ivo_Filial = Create uo_Filial

wf_Insere_Distribuidora_Default()

dw_2.ivo_Controle_Menu.of_SalvarComo(True)


end event

event close;call super::close;Destroy(ivo_Filial)
Destroy(ivo_Selecao_filiais)

end event

type dw_visual from dc_w_cadastro_selecao_lista`dw_visual within w_ge161_consulta_filial_distribuidora
end type

type gb_aux_visual from dc_w_cadastro_selecao_lista`gb_aux_visual within w_ge161_consulta_filial_distribuidora
end type

type dw_1 from dc_w_cadastro_selecao_lista`dw_1 within w_ge161_consulta_filial_distribuidora
integer x = 37
integer y = 56
integer width = 1664
integer height = 332
string dataobject = "dw_ge161_selecao"
end type

event dw_1::ue_key;call super::ue_key;If dw_1.GetColumnName() = "nm_fantasia" Then
	If Key = KeyEnter! Then
		ivo_Filial.of_Localiza_Filial(This.GetText())
		
		If ivo_Filial.Localizada Then
					
			This.Object.cd_filial  		[1] = ivo_Filial.cd_filial
			This.Object.nm_fantasia	[1] = ivo_Filial.nm_fantasia
			
			This.Object.id_conjunto_filial[1] = "T"	
			
		End If
	End If
End If
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Filial) Then 
	This.Object.nm_fantasia[1] = ivo_Filial.nm_fantasia
End If
end event

event dw_1::itemchanged;call super::itemchanged;Long lvl_Nulo

Long lvl_Lojas

SetNull(lvl_Nulo)

Choose Case This.GetColumnName()
		
	Case "nm_fantasia" 
		If Not IsNull(Data) and Trim(Data) <> "" Then
			If Data <> ivo_Filial.nm_fantasia Then
				Return 1
			End If
		Else
			ivo_Filial.of_Inicializa()
			
			dw_1.Object.cd_filial  		[1] = ivo_Filial.cd_filial
			dw_1.Object.nm_fantasia[1] = ivo_Filial.nm_fantasia
		End If
	
	Case "id_conjunto_filial"
		
		ivs_filiais = ivs_nulo 
		
		If Data = 'C' Then
							
			OpenWithParm(w_ge216_selecao_filiais, ivo_Selecao_filiais)
			
			lvl_Lojas = Message.DoubleParm
			
			If lvl_Lojas > 0 Then
				
				ivo_Filial.of_Inicializa()
			
				dw_1.Object.cd_filial  		[1] = ivo_Filial.cd_filial
				dw_1.Object.nm_fantasia[1] = ivo_Filial.nm_fantasia
					
				ivs_filiais = ivo_Selecao_filiais.ivs_filiais
				
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma filial foi selecionada.")					
			End If

		End If
		
End Choose

dw_2.Reset()
end event

event dw_1::editchanged;call super::editchanged;dw_2.Reset()
end event

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)
end event

type gb_2 from dc_w_cadastro_selecao_lista`gb_2 within w_ge161_consulta_filial_distribuidora
integer x = 14
integer y = 432
integer width = 3648
integer height = 1456
integer taborder = 20
string text = "Lista de Filiais"
end type

type gb_1 from dc_w_cadastro_selecao_lista`gb_1 within w_ge161_consulta_filial_distribuidora
integer x = 14
integer y = 0
integer width = 1719
integer height = 420
integer taborder = 30
end type

type dw_2 from dc_w_cadastro_selecao_lista`dw_2 within w_ge161_consulta_filial_distribuidora
integer x = 46
integer y = 492
integer width = 3561
integer height = 1364
integer taborder = 40
string dataobject = "dw_ge161_lista_filial"
boolean hscrollbar = true
boolean hsplitscroll = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Distribuidora,&
	   lvs_Filial_Distr,&
	   lvs_Situacao,&
	   lvs_DW,&
	   lvs_Text,&
	   lvs_Conjunto

Long lvl_Filial

dw_1.AcceptText()

lvs_Distribuidora 	= dw_1.Object.cd_distribuidora       	[1]
lvl_Filial        			= dw_1.Object.cd_filial              		[1]
lvs_Filial_Distr  		= dw_1.Object.cd_filial_distribuidora	[1]
lvs_Situacao      		= dw_1.Object.id_situacao            	[1]
lvs_Conjunto			= dw_1.Object.id_conjunto_filial     	[1]

If lvs_Distribuidora <> "000000000" Then
	lvs_DW   = "dw_ge161_lista_distribuidora"
	lvs_Text = "Lista de Filiais" 
ElseIf Not IsNull(lvl_Filial) Then
	lvs_Dw = "dw_ge161_lista_filial"
	lvs_Text = "Lista de Distribuidoras" 
Else
	Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o fornecedor ou a filial para efetuar a sele$$HEX2$$e700e300$$ENDHEX$$o.")
	Return -1
End If

If dw_2.of_ChangeDataObject(lvs_DW) Then 
	This.of_SetRowSelection()
	gb_2.Text = lvs_Text
Else
	Return -1
End If

If lvs_Distribuidora <> "000000000" Then
	dw_2.of_AppendWhere_SubQuery("fd.cd_distribuidora = '" + lvs_Distribuidora + "'", 3)
End If

If Not IsNull(lvl_Filial) Then
	dw_2.of_AppendWhere_SubQuery("fd.cd_filial = " + String(lvl_Filial), 3)
End If

If lvs_Situacao <> "T" Then
	dw_2.of_AppendWhere_SubQuery("fd.id_situacao = '" + lvs_Situacao + "'", 3)
End If

If Not IsNull(lvs_Filial_Distr) and Trim(lvs_Filial_Distr) <> "" Then
	dw_2.of_AppendWhere_SubQuery("fd.cd_filial_distribuidora = '" + lvs_Filial_Distr + "'", 3)
End If

If lvs_Conjunto = "C" Then
	If ivs_filiais <> "" And Not IsNull(ivs_filiais) Then
		dw_2.of_AppendWhere_SubQuery("fd.cd_filial in (" + ivs_Filiais + ")", 3)
	End If
End If

dw_2.Object.Cd_Filial_Distribuidora.Protect	= 1
dw_2.Object.Id_Situacao.Protect				= 1
dw_2.Object.nr_gln.Protect                        = 1
dw_2.Object.vl_Minimo_Pedido.Protect		= 1
dw_2.Object.nr_Prazo_Entrega.Protect		= 1
dw_2.Object.dh_Horario_Corte.Protect		= 1

Return 1
end event

event dw_2::constructor;// OverRide

String lvs_DataObject

This.of_SetTransObject(SqlCa)

lvs_DataObject = This.DataObject

If Trim(This.DataObject) <> "" Then
	ivs_SQL_Original = This.Object.DataWindow.Table.Select
End If

ivo_Controle_Menu = Create dc_uo_Menu_DW

ivo_Controle_Menu.of_SetDW(This)

SetNull(ivm_Menu)

This.of_GetParentWindow()

ivb_Selecao_Linhas = True

This.of_SetRowSelection()



end event

event dw_2::ue_preupdate;call super::ue_preupdate;Integer lvi_Linhas,&
		lvi_Linha,&
		lvi_Retorno = 1

String lvs_Situacao,&
	   lvs_Filial_Dist

dw_2.AcceptText()

lvi_Linhas = dw_2.RowCount()

If lvi_Linhas > 0 Then
	
	For lvi_Linha = 1 To lvi_Linhas
		
		lvs_Filial_Dist = dw_2.Object.cd_filial_distribuidora[lvi_Linha]
		lvs_Situacao    = dw_2.Object.id_situacao            [lvi_Linha]

		If IsNull(lvs_Filial_Dist) or Trim(lvs_Filial_Dist) = "" Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o c$$HEX1$$f300$$ENDHEX$$digo da filial na distribuidora.")
			dw_2.SetFocus()
			dw_2.Event ue_Pos(lvi_Linha, "cd_filial_distribuidora")
			lvi_Retorno = -1
		End If
		
		If lvs_Situacao <> 'A' and lvs_Situacao <> 'I' Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A situa$$HEX2$$e700e300$$ENDHEX$$o deve ser 'A' - Ativo ou 'I' - Inativo.")
			dw_2.SetFocus()
			dw_2.Event ue_Pos(lvi_Linha, "id_situacao")
			lvi_Retorno = -1
		End If
		
		If lvi_Retorno = -1 Then
			Exit
		End If
	Next
End If 

Return lvi_Retorno
end event

event dw_2::editchanged;// OverRide

end event

event dw_2::itemchanged;//OverRide

end event

event dw_2::ue_postretrieve;// Override

This.SetFocus()

Return pl_Linhas
end event

