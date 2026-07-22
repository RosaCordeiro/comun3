HA$PBExportHeader$w_ge391_consulta_falta_pedido_ba.srw
forward
global type w_ge391_consulta_falta_pedido_ba from dc_w_cadastro_selecao_lista
end type
type pb_1 from picturebutton within w_ge391_consulta_falta_pedido_ba
end type
end forward

global type w_ge391_consulta_falta_pedido_ba from dc_w_cadastro_selecao_lista
integer width = 5157
integer height = 2116
string title = "GE391 - Lista de Produtos em Falta na Bahia"
pb_1 pb_1
end type
global w_ge391_consulta_falta_pedido_ba w_ge391_consulta_falta_pedido_ba

type variables
uo_produto io_produto
end variables

forward prototypes
public subroutine wf_atualiza_produto ()
end prototypes

public subroutine wf_atualiza_produto ();Long ll_Linha, ll_Linhas, ll_Produto, ll_Achou

Date ldt_Movto_Inicial

ldt_Movto_Inicial = RelativeDate(Date(gf_GetServerDate()), -90)

ll_Linhas = dw_2.RowCount()

uo_ge390_regras_inclusao lo

try

	If ll_Linhas > 0 Then
		
		Open(w_Aguarde)
		
		w_Aguarde.Title = "Verificando as notas fiscais de compras ..."
		
		w_aguarde.uo_progress.of_setmax(ll_Linhas)
		
		lo = Create uo_ge390_regras_inclusao
		
		For ll_Linha = 1 To ll_Linhas
			
			ll_Produto = dw_2.Object.cd_produto[ll_Linha]
			
			ll_Achou = lo.of_movimento_compra(ll_Produto)
			
			If ll_Achou = -100 Then Return 
			
			If ll_Achou > 0 Then 
				dw_2.Object.id_retira_lista[ll_Linha] = 'S'
			End If						
			w_aguarde.uo_progress.of_setprogress(ll_Linha)
		Next
		
	End If

finally
	Close(w_Aguarde)
	Destroy lo	
end try




end subroutine

on w_ge391_consulta_falta_pedido_ba.create
int iCurrent
call super::create
this.pb_1=create pb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
end on

on w_ge391_consulta_falta_pedido_ba.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
end on

event ue_postopen;//OverRide

This.ivm_Menu.mf_SalvarComo(True)

dc_uo_dw_Base lvo_Update[]
lvo_Update = {dw_2}
This.wf_SetUpdate_DW(lvo_Update)

dw_1.Event ue_AddRow()

//This.ivm_Menu.mf_Incluir(True)
This.ivm_Menu.mf_Recuperar(True)

//Est$$HEX1$$e100$$ENDHEX$$ habilitado o Aux$$HEX1$$ed00$$ENDHEX$$lio Visual no INI ?
If gvo_aplicacao.ivb_usa_aux_visual Then 
	//Adiciona Linha DW
	If dw_visual.RowCount() = 0 Then dw_visual.Event ue_AddRow()
	//Seta os valores de redimensionamento da tela para compatibilidade com telas redimensionam
	MaxWidth = This.Width
	MaxHeight = This.Height
	//Chama o redimensionamento da tela, onde est$$HEX1$$e100$$ENDHEX$$ tratado onde deve aparecer a DW
	This.Event Resize(0,MaxWidth - 72, MaxHeight)
	//Seta DW visivel
	gb_aux_visual.Visible = True
	dw_visual.Visible = True
	
	Yield()
End If

dw_1.SetFocus()

Integer lvl_PxWidth
Integer lvl_PxHeight
Integer lvl_UnWidth
Integer lvl_UnHeight

If (MaxWidth > 0)or(MaxHeight>0) Then
	gvo_aplicacao.of_retorna_resolucao_monitor(lvl_PxWidth,lvl_PxHeight)
	
	lvl_UnWidth	= PixelsToUnits(lvl_PxWidth,XPixelsToUnits!)
	lvl_UnHeight	= PixelsToUnits(lvl_PxHeight,YPixelsToUnits!)
	
	If (lvl_PxWidth <> 800)and(MaxWidth > 0) Then //Diferente da resolu$$HEX2$$e700e300$$ENDHEX$$o 800 x 600 (Padr$$HEX1$$e300$$ENDHEX$$o Loja)
		If lvl_UnWidth >= MaxWidth Then //Maior que tamanho ideal
			This.Width = MaxWidth
		Else 
			This.Width = lvl_UnWidth - 50
		End If
	End If
	
	If (lvl_PxHeight <> 600)and(MaxHeight > 0) Then //Diferente da resolu$$HEX2$$e700e300$$ENDHEX$$o 800 x 600 (Padr$$HEX1$$e300$$ENDHEX$$o Loja)
		If lvl_UnHeight >= MaxHeight Then //Maior que tamanho ideal
			This.Height = MaxHeight
		Else 
			This.Height = lvl_UnHeight - 650
		End If
	End If
End If

ivo_dbError = Create dc_uo_dbError

//Registra Tela para Controle de Inatividade
If (Not(ivb_permite_fechar)) and (IsValid(gvo_Aplicacao)) Then
	If gvo_Aplicacao.ivb_Usa_Timer_Out Then
		gvo_Aplicacao.of_insere_tela(This.Title)
	End If
End If

// Insere a tela response do array de responses abertas
// Necess$$HEX1$$e100$$ENDHEX$$rio a armazenagem para fechar as telas por inatividade
If IsValid(gvo_Aplicacao) Then
	If gvo_Aplicacao.ivb_usa_timer_out Then
		If This.WindowType = Response! Then
			gvo_Aplicacao.of_insere_response(This)
		End if
	End If
End If

//Verifica se no grupo de acesso a tela est$$HEX1$$e100$$ENDHEX$$ sem permiss$$HEX1$$e300$$ENDHEX$$o de altera$$HEX2$$e700e300$$ENDHEX$$o
// e seta como somente leitura os campos
wf_set_somente_consulta()
end event

event open;call super::open;io_produto = Create uo_produto
end event

event close;call super::close;Destroy   io_produto
end event

type dw_visual from dc_w_cadastro_selecao_lista`dw_visual within w_ge391_consulta_falta_pedido_ba
integer y = 1180
end type

type gb_aux_visual from dc_w_cadastro_selecao_lista`gb_aux_visual within w_ge391_consulta_falta_pedido_ba
integer y = 1108
end type

type dw_1 from dc_w_cadastro_selecao_lista`dw_1 within w_ge391_consulta_falta_pedido_ba
integer x = 59
integer y = 80
integer width = 1659
integer height = 104
string dataobject = "dw_ge391_selecao"
end type

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	If This.GetColumnName() = "de_produto" Then
		io_Produto.of_Localiza_Produto(This.GetText())		
		If io_Produto.Localizado Then
			This.Object.Cd_Produto[1] = io_Produto.Cd_Produto
			This.Object.De_Produto[1] = io_Produto.ivs_Descricao_Apresentacao_Estoque
		End If			
	End If
End If


end event

event dw_1::itemchanged;call super::itemchanged;If dwo.Name = "de_produto" Then
	If Not IsNull(Data) and Trim(Data) <> "" Then
		If Not IsNull(This.Object.Cd_Produto[1]) Then
			If Data <> io_Produto.ivs_Descricao_Apresentacao_Estoque Then
				Return 1
			End If
		End If
	Else
		io_Produto.of_Inicializa()			
		
		This.Object.Cd_Produto[1] = io_Produto.Cd_Produto
		This.Object.De_Produto[1] = io_Produto.ivs_Descricao_Apresentacao_Estoque			
	End If		
End If



end event

event dw_1::losefocus;call super::losefocus;If IsValid(io_Produto) Then
	If Not IsNull(This.Object.Cd_Produto[1]) Then
		This.Object.De_Produto[1] = io_Produto.ivs_Descricao_Apresentacao_Estoque
	End If
End If


end event

event dw_1::editchanged;call super::editchanged;dw_2.Reset()

dw_2.SetFilter("")
dw_2.Filter( )
end event

type gb_2 from dc_w_cadastro_selecao_lista`gb_2 within w_ge391_consulta_falta_pedido_ba
integer y = 236
integer width = 5033
integer height = 1656
integer weight = 700
fontcharset fontcharset = ansi!
string text = "Produtos em Falta"
end type

type gb_1 from dc_w_cadastro_selecao_lista`gb_1 within w_ge391_consulta_falta_pedido_ba
integer width = 1705
integer height = 208
integer weight = 700
end type

type dw_2 from dc_w_cadastro_selecao_lista`dw_2 within w_ge391_consulta_falta_pedido_ba
integer x = 73
integer y = 312
integer width = 4969
integer height = 1548
string dataobject = "dw_ge391_lista"
end type

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

	This.SetRow(1)
	This.SetFocus()
	
	wf_atualiza_produto()
	
	//This.SetFilter("")
	//This.Filter( )
	
	This.SetFilter("id_retira_lista = 'N'")
	This.Filter( )
	
	If pl_Linhas = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.", Information!)
		dw_2.ivo_Controle_Menu.of_SalvarComo(False)
	Else
		dw_2.ivo_Controle_Menu.of_SalvarComo(True)
	End If
Else
	If pl_Linhas = 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhuma informa$$HEX2$$e700e300$$ENDHEX$$o cadastrada.", Information!)
		dw_2.ivo_Controle_Menu.of_SalvarComo(False)
	End If
End If

Parent.ivm_Menu.mf_Classificar(lvb_Classificar)
Parent.ivm_Menu.mf_Filtrar(lvb_Filtrar)
Parent.ivm_Menu.mf_Localizar(lvb_Localizar)
Parent.ivm_Menu.mf_Excluir(False)

Return pl_Linhas


end event

event dw_2::constructor;call super::constructor;// Habilitar a ordena$$HEX2$$e700e300$$ENDHEX$$o na coluna
This.ivb_Ordena_Colunas = True
end event

event dw_2::ue_recuperar;// OverRide

Date ldt_Mes_Atual

Long ll_Produto

dw_1.AcceptText()

ll_Produto = dw_1.Object.cd_produto[1] 

If Not IsNull(ll_Produto) and ll_Produto > 0 Then
	dw_2.of_appendwhere_subquery("r.cd_produto = " + String(ll_Produto), 3)
	dw_2.of_appendwhere_subquery("r.cd_produto = " + String(ll_Produto), 9)
End If

ldt_Mes_Atual = Date(gvo_Parametro.of_Dh_Movimentacao())

ldt_Mes_Atual = Date("01/" + String(ldt_Mes_Atual, "mm/yyyy"))

Return This.Retrieve(ldt_Mes_Atual)
end event

type pb_1 from picturebutton within w_ge391_consulta_falta_pedido_ba
integer x = 1806
integer y = 112
integer width = 137
integer height = 108
integer taborder = 10
boolean bringtotop = true
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\question_1.png"
alignment htextalign = left!
end type

event clicked;MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Regra para mostrar a lista de produtos:~r" +&
								"--> Produtos com saldo menor que o estoque base nas lojas da Bahia~r" +&
								"--> Produtos ativos~r" +&
								"--> Produtos que n$$HEX1$$e300$$ENDHEX$$o tiveram compra no CD nos $$HEX1$$fa00$$ENDHEX$$ltimos 3 meses, sem considerar notas de pedidos de faltas da Bahia ~r" +&
								"--> Produtos sem distribuidora ativa na Bahia [n$$HEX1$$e300$$ENDHEX$$o controlados]~r" +&
								"--> Produtos com distribuidora ativa na Bahia [controlados]~r" +&
								"--> Produtos com distribuidora ativa em Santa Catarina~r" +&
								"--> N$$HEX1$$e300$$ENDHEX$$o mostra produtos de geladeira~r" +&
								"--> N$$HEX1$$e300$$ENDHEX$$o mostra fraldas") 
end event

