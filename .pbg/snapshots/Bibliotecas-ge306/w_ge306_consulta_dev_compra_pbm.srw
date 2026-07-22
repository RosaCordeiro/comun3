HA$PBExportHeader$w_ge306_consulta_dev_compra_pbm.srw
forward
global type w_ge306_consulta_dev_compra_pbm from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge306_consulta_dev_compra_pbm from dc_w_selecao_lista_relatorio
integer width = 3273
integer height = 1868
string title = "GE306 - Consulta Devolu$$HEX2$$e700f500$$ENDHEX$$es Compras Reposi$$HEX2$$e700e300$$ENDHEX$$o PBM"
end type
global w_ge306_consulta_dev_compra_pbm w_ge306_consulta_dev_compra_pbm

type variables
uo_filial ivo_Filial
uo_fornecedor ivo_fornecedor
uo_produto ivo_produto
end variables

on w_ge306_consulta_dev_compra_pbm.create
call super::create
end on

on w_ge306_consulta_dev_compra_pbm.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;dw_1.Object.dt_inicio	[1] = RelativeDate(Today(),-1)
dw_1.Object.dt_fim	[1] = RelativeDate(Today(),-1)
end event

event ue_preopen;call super::ue_preopen;ivo_Filial			= Create uo_filial 
ivo_produto		= Create uo_produto 
ivo_fornecedor	= Create uo_fornecedor 

MaxHeight	= 9999
MaxWidth	= 6135
end event

event close;call super::close;Destroy(ivo_Filial)
Destroy(ivo_produto)
Destroy(ivo_fornecedor)
end event

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge306_consulta_dev_compra_pbm
integer y = 360
integer width = 3173
integer height = 1304
integer weight = 700
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge306_consulta_dev_compra_pbm
integer width = 3163
integer height = 336
integer weight = 700
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge306_consulta_dev_compra_pbm
integer width = 3095
string dataobject = "dw_ge306_selecao"
end type

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "de_produto"
			ivo_Produto.of_Localiza_Produto(This.GetText())
			
			If ivo_Produto.Localizado Then
				This.Object.Cd_Produto	[1] = ivo_Produto.Cd_Produto
				This.Object.De_Produto	[1] = ivo_Produto.de_Produto+': '+ivo_Produto.ivs_Descricao_Apresentacao_Venda
			End If
					 
		Case "nm_filial"
			ivo_Filial.of_Localiza_Filial(This.GetText())
			
			If ivo_Filial.Localizada Then
				This.Object.Cd_Filial	[1]	= ivo_Filial.Cd_Filial
				This.Object.Nm_Filial	[1]	= ivo_Filial.Nm_Fantasia	
			End If
			
		Case "nm_fornecedor"
			ivo_fornecedor.of_Localiza_Fornecedor(This.GetText())
			
			If ivo_fornecedor.Localizado Then
				This.Object.Cd_Fornecedor	[1]	= ivo_fornecedor.Cd_Fornecedor
				This.Object.Nm_Fornecedor	[1]	= ivo_fornecedor.Nm_Fantasia
			End If
	End Choose
End If
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Produto) Then
	If ivo_Produto.Localizado Then
		This.Object.De_Produto	[1] = ivo_Produto.De_Produto+': '+ivo_Produto.ivs_Descricao_Apresentacao_Venda
	End If
End If

If IsValid(ivo_Filial) Then
	This.Object.Nm_Filial	[1] = ivo_Filial.Nm_Fantasia
End If

If IsValid(ivo_Fornecedor) Then
	This.Object.Nm_Fornecedor	[1] = ivo_Fornecedor.Nm_Fantasia
End If
end event

event dw_1::itemchanged;call super::itemchanged;Choose Case dwo.Name
	Case "de_produto"
		If Trim(Data) <> "" and Not IsNull(Data) Then
			If Data <> ivo_Produto.ivs_Descricao_Apresentacao_Venda Then
				Return 1
			End If
		Else
			ivo_Produto.of_Inicializa()
			
			This.Object.Cd_Produto      		 [1] = ivo_Produto.Cd_Produto
			This.Object.De_Produto        	 [1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
		End If	
		
	Case "nm_filial"
		If Trim(Data) <> "" and Not IsNull(Data) Then
			If Data <> ivo_Filial.Nm_Fantasia Then				
				Return 1
			End If
		Else
			ivo_Filial.of_Inicializa()
			
			This.Object.Cd_Filial	[1] = ivo_Filial.Cd_Filial
			This.Object.Nm_Filial	[1] = ivo_Filial.Nm_Fantasia			
		End If	
	Case "nm_fornecedor"
		If Trim(Data) <> "" and Not IsNull(Data) Then
			If Data <> ivo_Fornecedor.Nm_Fantasia Then				
				Return 1
			End If
		Else
			ivo_Fornecedor.of_Inicializa()
			
			This.Object.Cd_Fornecedor	[1] = ivo_Fornecedor.Cd_Fornecedor
			This.Object.Nm_Fornecedor	[1] = ivo_Fornecedor.Nm_Fantasia			
		End If	
End Choose
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge306_consulta_dev_compra_pbm
integer y = 436
integer width = 3104
integer height = 1196
string dataobject = "dw_ge306_lista"
boolean hscrollbar = true
boolean ivb_ordena_colunas = true
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;Long lvl_Filial
Long lvl_Produto
Long lvl_Nota

String lvs_Fornecedor

dw_1.AcceptText()

lvl_Filial			= dw_1.Object.cd_filial			[1]
lvl_Produto		= dw_1.Object.cd_produto		[1]
lvl_Nota 			= dw_1.Object.nr_nf				[1]
lvs_Fornecedor	= dw_1.Object.cd_fornecedor	[1]

If (Not IsNull(lvl_Filial))and(lvl_Filial > 0) Then
	This.Of_appendwhere('n.cd_filial = '+String(lvl_Filial),1)
	This.Of_appendwhere('n.cd_filial = '+String(lvl_Filial),2)
End If

If (Not IsNull(lvl_Produto))and(lvl_Produto > 0) Then
	This.Of_appendwhere('i.cd_produto = '+String(lvl_Produto),1)
	This.Of_appendwhere('i.cd_produto = '+String(lvl_Produto),2)
End If

If (Not IsNull(lvl_Nota))and(lvl_Nota > 0) Then
	This.Of_appendwhere('n.nr_nf = '+String(lvl_Nota),1)
	This.Of_appendwhere('n.nr_nf = '+String(lvl_Nota),2)
End If

If (Not IsNull(lvs_Fornecedor))and(lvs_Fornecedor<>'') Then
	This.Of_appendwhere("n.cd_fornecedor = '"+lvs_Fornecedor+"'",1)
	This.Of_appendwhere("n.cd_fornecedor = '"+lvs_Fornecedor+"'",2)
End If

Return AncestorReturnValue
end event

event dw_2::ue_recuperar;//override
Date lvdt_Inicio
Date lvdt_Fim

dw_1.AcceptText()

lvdt_Inicio	= dw_1.Object.dt_inicio	[1]
lvdt_Fim		= dw_1.Object.dt_fim		[1]

Return This.Retrieve(lvdt_Inicio,lvdt_Fim)
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;This.ivm_menu.mf_SalvarComo(pl_linhas > 0)

Return AncestorReturnValue
end event

event dw_2::ue_reset;call super::ue_reset;This.ivm_menu.mf_SalvarComo(False)
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge306_consulta_dev_compra_pbm
integer x = 3232
integer y = 100
integer width = 251
end type

