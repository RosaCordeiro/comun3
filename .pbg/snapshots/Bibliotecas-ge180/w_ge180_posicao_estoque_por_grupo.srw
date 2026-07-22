HA$PBExportHeader$w_ge180_posicao_estoque_por_grupo.srw
forward
global type w_ge180_posicao_estoque_por_grupo from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge180_posicao_estoque_por_grupo from dc_w_selecao_lista_relatorio
integer width = 4576
integer height = 1928
string title = "GE180 - Relat$$HEX1$$f300$$ENDHEX$$rio de Posic$$HEX1$$e300$$ENDHEX$$o de Estoque por Grupo e Filial"
end type
global w_ge180_posicao_estoque_por_grupo w_ge180_posicao_estoque_por_grupo

type variables
Long il_Lojas

String is_Filiais
String is_Nulo
end variables

on w_ge180_posicao_estoque_por_grupo.create
call super::create
end on

on w_ge180_posicao_estoque_por_grupo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;Date ldt_Atual

dw_1.AcceptText()

ldt_Atual = Date(gf_GetServerDate())

dw_1.Object.Dt_Emissao_De	[1] = ldt_Atual
dw_1.Object.Dt_Emissao_Ate	[1] = ldt_Atual


//Habilitar a op$$HEX2$$e700e300$$ENDHEX$$o de salvar em planilha
dw_2.ivo_Controle_Menu.of_SalvarComo(True)


end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge180_posicao_estoque_por_grupo
integer x = 37
integer y = 804
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge180_posicao_estoque_por_grupo
integer x = 0
integer y = 732
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge180_posicao_estoque_por_grupo
integer y = 224
integer width = 4471
integer height = 1500
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge180_posicao_estoque_por_grupo
integer width = 2624
integer height = 196
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge180_posicao_estoque_por_grupo
integer y = 80
integer width = 2555
integer height = 108
string dataobject = "dw_ge180_selecao"
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

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge180_posicao_estoque_por_grupo
integer y = 300
integer width = 4402
integer height = 1400
string dataobject = "dw_ge180_lista"
end type

event dw_2::ue_recuperar;call super::ue_recuperar;Date ldt_Emissao_De
Date ldt_Emissao_Ate

DateTime ldh_Periodo

Long ll_Filial
Long ll_Linha
Long ll_Linha_Dw = 0

String ls_Grupo
String ls_Aux = ""

dw_1.AcceptText()

ldt_Emissao_De	= dw_1.Object.Dt_Emissao_De		[1]
ldt_Emissao_Ate	= dw_1.Object.Dt_Emissao_Ate	[1]

If IsNull(ldt_Emissao_De) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe um per$$HEX1$$ed00$$ENDHEX$$odo inicial v$$HEX1$$e100$$ENDHEX$$lido.", Exclamation!)
	dw_1.Event ue_Pos(1, "dt_emissao_de")
	Return -1
End If

If IsNull(ldt_Emissao_Ate) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe um per$$HEX1$$ed00$$ENDHEX$$odo final v$$HEX1$$e100$$ENDHEX$$lido.", Exclamation!)
	dw_1.Event ue_Pos(1, "dt_emissao_ate")
	Return -1
End If

If ldt_Emissao_De > ldt_Emissao_Ate Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O per$$HEX1$$ed00$$ENDHEX$$odo inicial n$$HEX1$$e300$$ENDHEX$$o pode ser maior do que o per$$HEX1$$ed00$$ENDHEX$$odo final.", Exclamation!)
	dw_1.Event ue_Pos(1, "dt_emissao_de")
	Return -1
End If

If (dw_1.Object.Id_Filiais[1] = "N") Or (IsNull(is_Filiais) Or Trim(is_Filiais) = "") Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione ao menos uma filial.", Exclamation!)
	dw_1.Event ue_Pos(1, "id_filiais")
	Return -1
End If

dc_uo_ds_base lds
lds = Create dc_uo_ds_base

If Not lds.of_ChangeDataObject("ds_ge180_posicao_estoque_por_grupo") Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar o data store 'ds_ge180_posicao_estoque_por_grupo'.", StopSign!)
	Destroy(lds)
	Return -1
End If

lds.of_AppendWhere("s.cd_filial in (" + is_Filiais + ")")

Open(w_Aguarde)
w_Aguarde.Title = "Carregando valores de saldo... Aguarde."

ls_Aux = "01/" + MidA(String(ldt_Emissao_De), 4)
ldt_Emissao_De = Date(ls_Aux)

lds.Retrieve(ldt_Emissao_De, ldt_Emissao_Ate)

If lds.RowCount() < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no retrieve.", StopSign!)
	Return -1
End If

ll_Filial = 0
SetNull(ldh_Periodo)

For ll_Linha = 1 To lds.RowCount()
	
	If (ll_Filial <> lds.Object.Cd_Filial[ll_Linha]) Or ((IsNull(ldh_Periodo)) Or (ldh_Periodo <> lds.Object.Dh_Saldo[ll_Linha])) Then
		ll_Filial		= lds.Object.Cd_Filial		[ll_Linha]
		ldh_Periodo	= lds.Object.Dh_Saldo	[ll_Linha]
		ll_Linha_Dw++
		
		This.Object.Dh_Periodo	[ll_Linha_Dw] = lds.Object.Dh_Saldo		[ll_Linha]
		This.Object.Cd_Filial		[ll_Linha_Dw] = lds.Object.Cd_Filial		[ll_Linha]
		This.Object.Nm_Filial		[ll_Linha_Dw] = lds.Object.Nm_Fantasia	[ll_Linha]
		
		This.Object.Vl_Estoque_Med[ll_Linha_Dw] = 0
		This.Object.Vl_Estoque_Pop	[ll_Linha_Dw] = 0
		This.Object.Vl_Estoque_Per	[ll_Linha_Dw] = 0
		This.Object.Vl_Estoque_Con	[ll_Linha_Dw] = 0
		This.Object.Vl_Estoque_Man[ll_Linha_Dw] = 0
		This.Object.Vl_Estoque_Ser	[ll_Linha_Dw] = 0
	End If
	
	ls_Grupo = lds.Object.Cd_Grupo[ll_Linha]
	
	Choose Case ls_Grupo
		Case '1' //Medicamento
			This.Object.Vl_Estoque_Med[ll_Linha_Dw] = lds.Object.Vl_Estoque[ll_Linha]
		Case '2' //Popular
			This.Object.Vl_Estoque_Pop	[ll_Linha_Dw] = lds.Object.Vl_Estoque[ll_Linha]
		Case '3' //Perfumaria
			This.Object.Vl_Estoque_Per	[ll_Linha_Dw] = lds.Object.Vl_Estoque[ll_Linha]
		Case '4' //Conveni$$HEX1$$ea00$$ENDHEX$$ncia
			This.Object.Vl_Estoque_Con	[ll_Linha_Dw] = lds.Object.Vl_Estoque[ll_Linha]
		Case '6' //Manipula$$HEX2$$e700e300$$ENDHEX$$o
			This.Object.Vl_Estoque_Man[ll_Linha_Dw] = lds.Object.Vl_Estoque[ll_Linha]
		Case '7' //Diversos = Servi$$HEX1$$e700$$ENDHEX$$os
			This.Object.Vl_Estoque_Ser	[ll_Linha_Dw] = lds.Object.Vl_Estoque[ll_Linha]
		Case Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o","Foram localizadas vendas para um grupo n$$HEX1$$e300$$ENDHEX$$o previsto. ~Grupo = " + String(lds.Object.De_Grupo[ll_Linha]))
	End Choose
	
Next

This.Sort()
This.GroupCalc()

Close(w_Aguarde)
Destroy(lds)

Return This.RowCount()
end event

event dw_2::ue_postretrieve;//OverRide

Boolean lvb_Classificar, &
        lvb_Filtrar, &
		  lvb_Localizar, &
		  lvb_Imprimir

If pl_Linhas > 0 Then
	lvb_Classificar = IsValid(This.ivo_Sort)
	lvb_Filtrar     = IsValid(This.ivo_Filter)
	lvb_Localizar   = IsValid(This.ivo_Find)
	
	lvb_Imprimir = True

	This.Event RowFocusChanged(1)
	This.SetRow(1)
	This.SetFocus()
	
	Parent.ivm_Menu.mf_SalvarComo(True)
Else
	If pl_Linhas = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.", Information!)
	End If
End If

Parent.ivm_Menu.mf_Classificar(lvb_Classificar)
Parent.ivm_Menu.mf_Filtrar(lvb_Filtrar)
Parent.ivm_Menu.mf_Localizar(lvb_Localizar)
Parent.ivm_Menu.mf_Imprimir(lvb_Imprimir)


Return pl_Linhas
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge180_posicao_estoque_por_grupo
integer x = 3730
integer y = 8
integer height = 192
end type

