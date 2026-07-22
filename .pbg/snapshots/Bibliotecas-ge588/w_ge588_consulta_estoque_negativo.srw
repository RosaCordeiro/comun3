HA$PBExportHeader$w_ge588_consulta_estoque_negativo.srw
forward
global type w_ge588_consulta_estoque_negativo from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge588_consulta_estoque_negativo from dc_w_selecao_lista_relatorio
integer width = 4375
integer height = 1384
string title = "GE588 - Relat$$HEX1$$f300$$ENDHEX$$rio Produtos com Saldo Negativo"
boolean resizable = false
end type
global w_ge588_consulta_estoque_negativo w_ge588_consulta_estoque_negativo

type variables
uo_ge216_Filiais 	ivo_filiais

String ivs_filiais
end variables

on w_ge588_consulta_estoque_negativo.create
call super::create
end on

on w_ge588_consulta_estoque_negativo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_preopen;call super::ue_preopen;MaxHeight = 9999

ivo_filiais		= Create uo_ge216_Filiais
end event

event close;call super::close;Destroy(ivo_filiais)
end event

event ue_postopen;call super::ue_postopen;This.ivm_menu.ivb_permite_imprimir = True
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge588_consulta_estoque_negativo
integer x = 210
integer y = 2016
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge588_consulta_estoque_negativo
integer x = 174
integer y = 1944
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge588_consulta_estoque_negativo
integer y = 288
integer width = 4288
integer height = 912
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge588_consulta_estoque_negativo
integer width = 1317
integer height = 260
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge588_consulta_estoque_negativo
integer x = 82
integer width = 1248
integer height = 180
string dataobject = "dw_ge588_selecao_consulta_estoque_negativo"
end type

event dw_1::itemchanged;call super::itemchanged;Long lvl_Lojas

String ls_Nulo

Setnull(ls_Nulo)

Choose Case Dwo.Name 
		
	Case "id_selecao_filiais"	
		ivs_filiais = ls_Nulo 
		
		If Data = 'C' Then
					
			OpenWithParm(w_ge216_selecao_filiais, ivo_Filiais)
			
			lvl_Lojas = Message.DoubleParm
			
			If lvl_Lojas > 0 Then
				ivs_filiais = ivo_Filiais.ivs_filiais
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma filial foi selecionada.")
			End If
			
		End If
	
		//dw_2.Event ue_Retrieve()
	
End Choose
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge588_consulta_estoque_negativo
integer x = 59
integer y = 364
integer width = 4256
integer height = 804
string dataobject = "dw_ge588_lista_consulta_estoque_negativo"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_recuperar;//OverRide
DateTime lvdt_MesAno

lvdt_MesAno = DateTime(dw_1.Object.dt_MesAno[1])

Return This.Retrieve(lvdt_MesAno)
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;String lvs_Selecao
String lvs_MesAno

dw_1.AcceptText()

lvs_MesAno		= String(dw_1.Object.dt_MesAno	[1])
lvs_Selecao		= dw_1.Object.Id_Selecao_Filiais	[1]

If IsNull(lvs_MesAno) Or Trim(lvs_MesAno) = '' Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o M$$HEX1$$ea00$$ENDHEX$$s e Ano.")
	dw_1.Event ue_Pos(1, "dt_MesAno")
	Return -1
End If

If lvs_Selecao = "C" Then
	If Not IsNull( ivs_Filiais ) or ivs_Filiais <> "" Then
		This.of_AppendWhere("s.cd_filial in (" + ivs_Filiais + ")" )
	End If
End If

Return AncestorReturnValue
end event

event dw_2::constructor;call super::constructor;This.ShareData(dw_3)
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;This.ivm_menu.mf_SalvarComo(pl_linhas > 0)

Return AncestorReturnValue
end event

event dw_2::ue_reset;call super::ue_reset;This.ivm_menu.mf_SalvarComo(False)
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge588_consulta_estoque_negativo
integer x = 2213
integer y = 36
integer width = 238
integer height = 240
string dataobject = "dw_ge588_relatorio_estoque_negativo"
end type

event dw_3::ue_preprint;call super::ue_preprint;This.Object.Cabecalho_MesAno.Text = String(dw_1.Object.dt_MesAno[1],"mm/yyyy")

Return AncestorReturnValue
end event

