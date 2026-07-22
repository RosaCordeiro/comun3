HA$PBExportHeader$w_ge381_produto_por_promocao.srw
forward
global type w_ge381_produto_por_promocao from dc_w_cadastro_selecao_lista
end type
end forward

global type w_ge381_produto_por_promocao from dc_w_cadastro_selecao_lista
integer width = 3058
integer height = 1892
string title = "GE381 - Produto por Promo$$HEX2$$e700e300$$ENDHEX$$o"
end type
global w_ge381_produto_por_promocao w_ge381_produto_por_promocao

type variables
uo_produto io_Produto
end variables

on w_ge381_produto_por_promocao.create
call super::create
end on

on w_ge381_produto_por_promocao.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_preopen;call super::ue_preopen;io_Produto = Create uo_produto
end event

event close;call super::close;Destroy(io_Produto)
end event

event ue_postopen;call super::ue_postopen;ivm_Menu.mf_Incluir(False)
ivm_Menu.mf_Excluir(False)
end event

event ue_save;call super::ue_save;Boolean lb_Alteracao = False

Decimal ldc_Normal
Decimal ldc_Clube
Decimal ldc_Normal_Ant
Decimal ldc_Clube_Ant

Long ll_Linha
Long ll_Find
Long ll_Promocao
Long ll_Produto

String ls_Erro

dw_1.AcceptText()
dw_2.AcceptText()

ivm_Menu.mf_Excluir(False)

ll_Find = dw_2.Find("pc_desconto > 100.00", 1, dw_2.RowCount())

If ll_Find > 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O desconto Normal n$$HEX1$$e300$$ENDHEX$$o pode ser maior que zero.")
	dw_2.Event ue_Pos(ll_Find, "pc_desconto")
	Return -1
End If

ll_Find = 0

ll_Find = dw_2.Find("pc_desconto_clube > 100.00", 1, dw_2.RowCount())

If ll_Find > 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O desconto Clube n$$HEX1$$e300$$ENDHEX$$o pode ser maior que zero.")
	dw_2.Event ue_Pos(ll_Find, "pc_desconto_clube")
	Return -1
End If

ll_Produto		= dw_1.Object.Cd_Produto[1]

For ll_Linha = 1 To dw_2.RowCount()
	ll_Promocao			= dw_2.Object.Cd_Promocao_Sos			[ll_Linha]
	ldc_Normal			= dw_2.Object.Pc_Desconto					[ll_Linha]
	ldc_Normal_Ant	= dw_2.Object.Pc_Desconto_Anterior		[ll_Linha]
	ldc_Clube			= dw_2.Object.Pc_Desconto_Clube		[ll_Linha]
	ldc_Clube_Ant		= dw_2.Object.Pc_Desconto_Clube_Ant	[ll_Linha]
	
	If (ldc_Normal <> ldc_Normal_Ant) Or (ldc_Clube <> ldc_Clube_Ant) Then
		
		lb_Alteracao = True
		
		Update promocao_sos_produto
			Set 	pc_desconto = :ldc_Normal,
					pc_desconto_clube = :ldc_Clube,
					nr_matricula_alteracao = :gvo_Aplicacao.ivo_Seguranca.Nr_Matricula
			Where cd_promocao_sos = :ll_Promocao
				And cd_produto = :ll_Produto
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			ls_Erro = SqlCa.SqlErrText
			SqlCa.of_RollBack();
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao atualizar o desconto. " + ls_Erro, StopSign!)
			Return -1
		End If	
	End If	
Next

If lb_Alteracao Then
	SqlCa.of_Commit();
End If

ivm_Menu.mf_Confirmar(False)
ivm_Menu.mf_Cancelar(False)
ivm_Menu.mf_Excluir(False)
ivm_Menu.mf_Incluir(False)
ivb_Valida_Salva = False

Return 1
end event

type dw_visual from dc_w_cadastro_selecao_lista`dw_visual within w_ge381_produto_por_promocao
integer x = 37
integer y = 980
end type

type gb_aux_visual from dc_w_cadastro_selecao_lista`gb_aux_visual within w_ge381_produto_por_promocao
integer x = 0
integer y = 908
end type

type dw_1 from dc_w_cadastro_selecao_lista`dw_1 within w_ge381_produto_por_promocao
integer width = 2011
string dataobject = "dw_ge381_selecao"
end type

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	If This.GetColumnName() = "de_produto" Then
			
		io_Produto.of_Localiza_Produto(This.GetText())
		
		If io_Produto.Localizado Then
			dw_1.Object.Cd_Produto	[1] = io_Produto.Cd_Produto
			dw_1.Object.De_Produto	[1] = io_Produto.ivs_Descricao_Apresentacao_Venda
		Else
			io_Produto.of_Inicializa()
		End If
	End If
End If
end event

event dw_1::editchanged;call super::editchanged;dw_2.Event ue_Reset()

If dwo.Name = "de_produto" Then
	If Not IsNull(Data) And Trim(Data) <> "" Then
		If Data <> io_Produto.De_Produto Then
			Return 1
		End If
	Else
		io_Produto.of_Inicializa()
		
		This.Object.Cd_Produto	[1] = io_Produto.Cd_Produto
		This.Object.De_Produto	[1] = io_Produto.ivs_Descricao_Apresentacao_Venda
	End If
End If
end event

event dw_1::itemchanged;call super::itemchanged;dw_2.Event ue_Reset()

If dwo.Name = "de_produto" Then
	If Not IsNull(Data) And Trim(Data) <> "" Then
		If Data <> io_Produto.De_Produto Then
			Return 1
		End If
	Else
		io_Produto.of_Inicializa()
		
		This.Object.Cd_Produto	[1] = io_Produto.Cd_Produto
		This.Object.De_Produto	[1] = io_Produto.ivs_Descricao_Apresentacao_Venda
	End If
End If
end event

event dw_1::losefocus;call super::losefocus;ivm_Menu.mf_Incluir(False)
ivm_Menu.mf_Excluir(False)
end event

event dw_1::ue_cancel;//OverRide
end event

type gb_2 from dc_w_cadastro_selecao_lista`gb_2 within w_ge381_produto_por_promocao
integer y = 292
integer width = 2944
integer height = 1384
end type

type gb_1 from dc_w_cadastro_selecao_lista`gb_1 within w_ge381_produto_por_promocao
integer width = 2080
end type

type dw_2 from dc_w_cadastro_selecao_lista`dw_2 within w_ge381_produto_por_promocao
integer y = 368
integer width = 2871
integer height = 1288
string dataobject = "dw_ge381_lista"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;Long ll_Produto

String ls_Situacao
String ls_Fronteira

dw_1.AcceptText()

ll_Produto 	= dw_1.Object.Cd_Produto	[1]
ls_Situacao	= dw_1.Object.Id_Situacao	[1]
ls_Fronteira	= dw_1.Object.Id_Fronteira	[1]

If IsNull(ll_Produto) Or ll_Produto = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o produto.")
	dw_1.Event ue_Pos(1, "de_produto")
	Return -1
End If

If ls_Situacao = "V" Then
	This.of_AppendWhere("s.dh_inicio <= (Select dh_movimentacao From parametro Where id_parametro = '1')" + &
								 " And (s.dh_termino >=  (Select dh_movimentacao From parametro Where id_parametro = '1') Or s.dh_termino Is Null)")
Else
	This.of_AppendWhere("s.dh_inicio > (Select dh_movimentacao From parametro Where id_parametro = '1')")
End If

If ls_Fronteira = "N" Then
	This.of_AppendWhere("s.cd_promocao_sos Not In (860, 1415)")	
End If

Return 1
end event

event dw_2::ue_recuperar;//OverRide

dw_1.AcceptText()

Return This.Retrieve(dw_1.Object.Cd_Produto[1])
end event

event dw_2::losefocus;call super::losefocus;ivm_Menu.mf_Incluir(False)
ivm_Menu.mf_Excluir(False)
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;ivm_Menu.mf_Incluir(False)
ivm_Menu.mf_Excluir(False)

Return pl_Linhas
end event

event dw_2::constructor;call super::constructor;ivi_Tipo_Cancelar = RETRIEVE
end event

event dw_2::itemchanged;call super::itemchanged;ivm_Menu.mf_Excluir(False)
ivm_Menu.mf_Incluir(False)
end event

event dw_2::editchanged;call super::editchanged;ivm_Menu.mf_Excluir(False)
ivm_Menu.mf_Incluir(False)
end event

event dw_2::itemfocuschanged;call super::itemfocuschanged;ivm_Menu.mf_Excluir(False)
ivm_Menu.mf_Incluir(False)
end event

