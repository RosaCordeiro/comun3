HA$PBExportHeader$w_ge139_consulta_estoque_produto.srw
forward
global type w_ge139_consulta_estoque_produto from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge139_consulta_estoque_produto from dc_w_selecao_lista_relatorio
integer width = 2501
integer height = 1384
string title = "GE139 - Relat$$HEX1$$f300$$ENDHEX$$rio Estoque por Produto"
boolean resizable = false
end type
global w_ge139_consulta_estoque_produto w_ge139_consulta_estoque_produto

type variables
uo_Produto 			ivo_Produto
uo_ge216_Filiais 	ivo_filiais

String ivs_filiais
end variables

on w_ge139_consulta_estoque_produto.create
call super::create
end on

on w_ge139_consulta_estoque_produto.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_preopen;call super::ue_preopen;MaxHeight = 9999

ivo_Produto	= Create uo_Produto
ivo_filiais		= Create uo_ge216_Filiais
end event

event close;call super::close;Destroy(ivo_Produto)
Destroy(ivo_filiais)
end event

event ue_postopen;call super::ue_postopen;This.ivm_menu.ivb_permite_imprimir = True
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge139_consulta_estoque_produto
integer x = 210
integer y = 2016
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge139_consulta_estoque_produto
integer x = 174
integer y = 1944
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge139_consulta_estoque_produto
integer y = 352
integer width = 2427
integer height = 848
integer weight = 700
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge139_consulta_estoque_produto
integer width = 2144
integer height = 316
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge139_consulta_estoque_produto
integer x = 59
integer width = 2094
integer height = 232
string dataobject = "dw_ge139_selecao_consulta_estoque"
end type

event dw_1::itemchanged;call super::itemchanged;Long lvl_Lojas

String ls_Nulo

Setnull(ls_Nulo)

Choose Case Dwo.Name 
	Case "de_produto"
		
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
	
		dw_2.Event ue_Retrieve()
	
End Choose
end event

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	Choose Case This.GetColumnName() 
		Case "de_produto"
			ivo_Produto.of_Localiza_Produto(This.GetText())
			
			If ivo_Produto.Localizado Then
				 This.Object.Cd_Produto[1] = ivo_Produto.Cd_Produto
				 This.Object.De_Produto[1] = ivo_Produto.De_Produto + ' : ' + ivo_Produto.De_Apresentacao_Venda
			Else
				ivo_Produto.of_Inicializa()
			End If
	End Choose
End If
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge139_consulta_estoque_produto
integer y = 428
integer width = 2359
integer height = 740
string dataobject = "dw_ge139_lista_consulta_estoque"
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_recuperar;//OverRide
Long lvl_Produto

lvl_Produto	= dw_1.Object.Cd_Produto			[1]

Return This.Retrieve(lvl_Produto)
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;Long lvl_Produto

String lvs_Selecao
String lvs_Id_Saldo
String lvs_Id_Zerado

dw_1.AcceptText()

lvl_Produto		= dw_1.Object.Cd_Produto			[1]
lvs_Selecao		= dw_1.Object.Id_Selecao_Filiais	[1]
lvs_Id_Saldo	= dw_1.Object.Id_Saldo_Negativo	[1]
lvs_Id_Zerado	= dw_1.Object.id_saldo_zero		[1]

If IsNull(lvl_Produto) Or lvl_Produto = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o c$$HEX1$$f300$$ENDHEX$$digo do produto.")
	dw_1.Event ue_Pos(1, "de_produto")
	Return -1
End If

If lvs_Selecao = "C" Then
	If Not IsNull( ivs_Filiais ) or ivs_Filiais <> "" Then
		This.of_AppendWhere("s.cd_filial in (" + ivs_Filiais + ")" )
	End If
End If

If  lvs_Id_Saldo = "S" Then
	This.of_AppendWhere("(s.qt_saldo_final < 0)")
End If

If  lvs_Id_Zerado = "S" Then
	This.of_AppendWhere("(s.qt_saldo_final <> 0)")
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

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge139_consulta_estoque_produto
integer x = 2213
integer y = 36
integer width = 238
integer height = 292
string dataobject = "dw_ge139_relatorio_estoque"
end type

event dw_3::ue_preprint;call super::ue_preprint;This.Object.Cabecalho_Produto.Text = ivo_Produto.ivs_Descricao_Apresentacao_Venda + " (" + String(ivo_Produto.Cd_Produto) + ")"

Return AncestorReturnValue
end event

