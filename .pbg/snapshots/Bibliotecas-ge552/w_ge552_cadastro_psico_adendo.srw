HA$PBExportHeader$w_ge552_cadastro_psico_adendo.srw
forward
global type w_ge552_cadastro_psico_adendo from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge552_cadastro_psico_adendo from dc_w_selecao_lista_relatorio
integer width = 2679
integer height = 2364
string title = "GE552 - Cadastro de Psico Adendos"
end type
global w_ge552_cadastro_psico_adendo w_ge552_cadastro_psico_adendo

type variables
uo_produto io_Produto
end variables

on w_ge552_cadastro_psico_adendo.create
call super::create
end on

on w_ge552_cadastro_psico_adendo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_preopen;call super::ue_preopen;io_Produto = Create uo_produto
end event

event close;call super::close;If IsValid(io_Produto) Then Destroy(io_Produto)
end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge552_cadastro_psico_adendo
integer x = 37
integer y = 872
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge552_cadastro_psico_adendo
integer x = 0
integer y = 800
integer height = 240
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge552_cadastro_psico_adendo
integer x = 23
integer y = 360
integer width = 2569
integer height = 1776
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge552_cadastro_psico_adendo
integer width = 2085
integer height = 336
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge552_cadastro_psico_adendo
integer width = 2016
integer height = 232
string dataobject = "dw_ge552_selecao"
end type

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "de_produto"
						
			io_Produto.of_Localiza_Produto(This.GetText())
						
			If io_Produto.Localizado Then
				This.Object.Cd_Produto[1] = io_Produto.Cd_Produto
				This.Object.De_Produto[1] = io_Produto.ivs_Descricao_Apresentacao_Venda
				
			Else
				io_Produto.of_Inicializa()
			End If
	End Choose
End If
end event

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case "de_produto"
		If Not IsNull(Data) and Data <> "" Then
			If Data <> io_Produto.ivs_Descricao_Apresentacao_Estoque Then
				Return 1
			End If
			
		Else
			io_Produto.of_Inicializa()
			
			This.Object.Cd_Produto[1] = io_Produto.Cd_Produto
			This.Object.De_Produto[1] = io_Produto.ivs_Descricao_Apresentacao_Estoque
		End If
End Choose

dw_2.Event ue_Reset()
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge552_cadastro_psico_adendo
integer x = 55
integer y = 436
integer width = 2501
integer height = 1672
string dataobject = "dw_ge552_lista"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;dw_1.AcceptText()

If Not IsNull(dw_1.Object.Cd_Produto[1]) And dw_1.Object.Cd_Produto[1] > 0 Then
	This.of_AppendWhere("v.cd_produto = " + String(dw_1.Object.Cd_Produto[1]))
End If

If dw_1.Object.Id_Situacao[1] <> "T" Then
	This.of_AppendWhere("g.id_situacao = '" + dw_1.Object.Id_Situacao[1] + "'")
End If

Return 1
end event

event dw_2::doubleclicked;call super::doubleclicked;String ls_Retorno

dw_2.AcceptText()

If dw_2.RowCount() > 0 Then
	OpenWithParm(w_ge552_altera_psico_adendo, String(dw_2.Object.Cd_Produto[dw_2.GetRow()]))
	
	ls_Retorno = Message.StringParm
	
	If ls_Retorno = "OK" Then
		dw_2.Event ue_Retrieve()
	End If
End If
end event

event dw_2::constructor;call super::constructor;This.ivb_Ordena_Colunas = True
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	This.ivo_Controle_Menu.of_SalvarComo(True)
Else
	This.ivo_Controle_Menu.of_SalvarComo(False)
End If

Return pl_Linhas
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge552_cadastro_psico_adendo
integer x = 1362
integer y = 840
end type

