HA$PBExportHeader$w_ge608_consulta_estoque_filial_dia.srw
forward
global type w_ge608_consulta_estoque_filial_dia from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge608_consulta_estoque_filial_dia from dc_w_selecao_lista_relatorio
integer width = 4690
integer height = 1968
string title = "GE608 - Consulta Estoque por Filial por Dia"
end type
global w_ge608_consulta_estoque_filial_dia w_ge608_consulta_estoque_filial_dia

type variables
uo_produto ivo_produto

uo_filial ivo_filial
end variables

on w_ge608_consulta_estoque_filial_dia.create
call super::create
end on

on w_ge608_consulta_estoque_filial_dia.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;ivo_Produto 	= Create uo_Produto
ivo_Filial		= Create uo_Filial

ivm_Menu.ivb_Permite_Imprimir = False

dw_1.Object.Dt_Inicio [1] = Today()

dw_1.SetFocus()

end event

event close;call super::close;Destroy(ivo_Produto)
Destroy(ivo_Filial)
end event

event ue_preopen;call super::ue_preopen;MaxWidth = 4700
MaxHeight = 3005
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge608_consulta_estoque_filial_dia
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge608_consulta_estoque_filial_dia
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge608_consulta_estoque_filial_dia
integer x = 18
integer y = 412
integer width = 4594
integer height = 1352
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge608_consulta_estoque_filial_dia
integer x = 18
integer y = 0
integer width = 1797
integer height = 396
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge608_consulta_estoque_filial_dia
integer x = 55
integer y = 56
integer width = 1737
integer height = 328
string dataobject = "dw_ge608_selecao"
end type

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case "de_produto"
		If Data <> ivo_Produto.ivs_Descricao_Apresentacao_Venda Then
			Return 1
		End If
		
	Case "nm_filial"
		If data <> "" Then
			Return 1
		Else			
			SetNull(ivo_Filial.Cd_Filial)
			ivo_Filial.Nm_Fantasia = ""
			
			This.Object.Cd_Filial[1] 	= ivo_Filial.Cd_Filial
			This.Object.Nm_Filial[1] 	= ivo_Filial.Nm_Fantasia				
		End If
End Choose
end event

event dw_1::losefocus;If IsValid(ivo_Produto) Then
	This.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
End If

If IsValid(ivo_Filial) Then
	This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
End If
end event

event dw_1::ue_key;Choose Case Key 
	Case KeyEnter!
		Choose Case This.GetColumnName()
			Case "de_produto"
				ivo_Produto.of_Localiza_Produto(This.GetText())
				
				If ivo_Produto.Localizado Then
					This.Object.Cd_Produto[1] = ivo_Produto.Cd_Produto
					This.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
				End If
				
			Case "nm_filial"
				ivo_Filial.of_Localiza_Filial(This.GetText())
				
				If ivo_Filial.Localizada Then
					This.Object.Cd_Filial[1] = ivo_Filial.Cd_Filial
					This.Object.Nm_Filial[1] = ivo_Filial.Nm_Fantasia
				End If
				
		End Choose
	Case KeyDelete!
		If This.GetColumnName() = "de_produto" Then
			String	lvs_Null
			Long	lvl_Null
			SetNull(lvs_Null)
			SetNull(lvl_Null)
			This.Object.Cd_Produto[1] = lvl_Null
			This.Object.De_Produto[1] = lvs_Null
		End If
		
End Choose
end event

event dw_1::getfocus;call super::getfocus;This.ivm_Menu.mf_SalvarComo(False)
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge608_consulta_estoque_filial_dia
integer x = 50
integer width = 4553
integer height = 1280
string dataobject = "dw_ge608_lista"
boolean hscrollbar = true
end type

event dw_2::ue_recuperar;//overhide
Long	lvl_Filial, &
		lvl_Produto, &
		lvl_Mes, &
		lvl_Ano

Date	lvdt_Inicio, &
		lvdt_Termino, &
		lvdt_Data
String	lvs_Com_Saldo
		  
	  
dw_1.AcceptText()

lvl_Filial   		= dw_1.Object.Cd_Filial 					[1]
lvl_Produto  		= dw_1.Object.Cd_Produto				[1]
lvdt_Data  		= dw_1.Object.Dt_Inicio					[1]
lvs_Com_Saldo	= dw_1.Object.id_saldo					[1]

If IsNull(lvs_Com_Saldo) Then lvs_Com_Saldo = 'N'
If IsNull(lvl_Produto) Then lvl_Produto = 0

If IsNull(lvl_Filial) or lvl_Filial = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Informe a Filial.", Exclamation!)
	dw_1.Event ue_Pos(1, "nm_filial")
	Return -1
End If

If IsNull(lvdt_Data) or Not IsDate(String(lvdt_Data)) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o!", "Informe a Data.", Exclamation!)
	dw_1.Event ue_Pos(1, "dt_inicio")
	Return -1
End If

lvl_Mes = Long(String(lvdt_Data,'MM'))
lvl_Ano = Long(String(lvdt_Data,'YYYY'))

lvdt_Termino = Date('01'+'/'+String(lvl_Mes,'00')+'/'+String(lvl_Ano,'0000'))

If lvl_Mes = 1 Then 
	lvl_Mes = 12
	lvl_Ano = lvl_Ano -1
Else
	lvl_Mes = lvl_Mes -1
End If

lvdt_Inicio = Date('01'+'/'+String(lvl_Mes,'00')+'/'+String(lvl_Ano,'0000'))

Return This.Retrieve(lvl_Filial, lvdt_Inicio, lvdt_Data, lvdt_Termino, lvl_Produto, lvs_Com_Saldo)
end event

event dw_2::getfocus;call super::getfocus;If This.RowCount() > 0 then 
	This.ivm_Menu.mf_SalvarComo(True)
End If
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;// Habilitar a ordena$$HEX2$$e700e300$$ENDHEX$$o na coluna
This.ivb_Ordena_Colunas = (pl_Linhas > 0)
Return 1
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge608_consulta_estoque_filial_dia
integer x = 2683
integer y = 32
integer height = 256
end type

