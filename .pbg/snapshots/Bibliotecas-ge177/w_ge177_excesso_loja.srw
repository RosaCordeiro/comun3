HA$PBExportHeader$w_ge177_excesso_loja.srw
forward
global type w_ge177_excesso_loja from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge177_excesso_loja from dc_w_selecao_lista_relatorio
integer width = 4663
integer height = 3220
string title = "GE177 - Relat$$HEX1$$f300$$ENDHEX$$rio de Produtos em Excesso"
end type
global w_ge177_excesso_loja w_ge177_excesso_loja

type variables
Long il_Lojas

String is_Filiais
String is_Nulo
end variables

on w_ge177_excesso_loja.create
call super::create
end on

on w_ge177_excesso_loja.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge177_excesso_loja
integer x = 37
integer y = 836
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge177_excesso_loja
integer x = 0
integer y = 764
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge177_excesso_loja
integer y = 224
integer width = 4549
integer height = 2788
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge177_excesso_loja
integer width = 1449
integer height = 192
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge177_excesso_loja
integer width = 1381
integer height = 112
string dataobject = "dw_ge177_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;il_Lojas = 0

Choose Case dwo.Name
	Case "id_filiais"
		
		If Data = 'C' Then
		
			is_Filiais = is_Nulo 
			
			uo_ge216_filiais uo_filiais
			
			uo_Filiais = Create uo_ge216_filiais
			
			OpenWithParm(w_ge216_selecao_filiais, uo_Filiais)
			
			il_Lojas = Message.DoubleParm
			
			If il_Lojas > 0 Then
				is_Filiais = uo_Filiais.ivs_filiais
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma filial foi selecionada.")
			End If
			
			Destroy(uo_Filiais)

		End If
		
End Choose
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge177_excesso_loja
integer y = 300
integer width = 4489
integer height = 2692
string dataobject = "dw_ge177_lista"
boolean hscrollbar = true
end type

event dw_2::ue_recuperar;//OverRide

If (dw_1.Object.Id_Filiais[1] = "N") Or (IsNull(is_Filiais) Or Trim(is_Filiais) = "") Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione ao menos uma filial.", Exclamation!)
	dw_1.Event ue_Pos(1, "id_filiais")
	Return -1
End If

If il_Lojas > 20 Then
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Mais de 20 lojas foram selecionadas, o relat$$HEX1$$f300$$ENDHEX$$rio poder$$HEX1$$e100$$ENDHEX$$ demorar mais de 10 minutos para gerar as informa$$HEX2$$e700f500$$ENDHEX$$es." +&
									"~rDeseja continuar?", Question!, YesNo!, 2) = 2 Then
		Return -1
	End If
End If

This.of_AppendWhere("r.cd_filial in (" + is_Filiais + ")")
	
Return This.Retrieve()
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	This.ivo_Controle_Menu.of_SalvarComo(True)
Else
	This.ivo_Controle_Menu.of_SalvarComo(False)
End If

Return pl_Linhas
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge177_excesso_loja
integer x = 1957
integer y = 0
end type

