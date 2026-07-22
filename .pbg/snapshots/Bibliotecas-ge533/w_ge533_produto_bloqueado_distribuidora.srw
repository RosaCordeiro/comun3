HA$PBExportHeader$w_ge533_produto_bloqueado_distribuidora.srw
forward
global type w_ge533_produto_bloqueado_distribuidora from dc_w_selecao_lista_relatorio
end type
end forward

global type w_ge533_produto_bloqueado_distribuidora from dc_w_selecao_lista_relatorio
integer width = 5385
integer height = 2096
string title = "GE533 - Relatorio de Produtos Bloqueados por Distribuidora"
end type
global w_ge533_produto_bloqueado_distribuidora w_ge533_produto_bloqueado_distribuidora

type variables
uo_produto ivo_produto

uo_fornecedor ivo_fornecedor

long ivl_produto_parametro

String is_Produto

string ivs_coluna_produto[], &
         ivs_coluna_distribuidora[], &
         ivs_nome_produto[], &
         ivs_nome_distribuidora[], &
		is_Uf

end variables

forward prototypes
public subroutine wf_insere_padrao ()
end prototypes

public subroutine wf_insere_padrao ();DataWindowChild lvdwc

Integer lvi_Retorno,&
        lvi_Row

If dw_1.GetChild("cd_distribuidora", lvdwc) = 1 Then
	lvdwc.InsertRow(1)
	
	lvdwc.SetItem(1, "cd_fornecedor", "000000000")
	lvdwc.SetItem(1, "nm_fantasia",   "TODAS")
	
	dw_1.Object.cd_distribuidora[1] = "000000000"
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild da distribuidora.")
End If

If dw_1.GetChild("cd_uf", lvdwc) = 1 Then
	lvdwc.InsertRow(1)
	
	lvdwc.SetItem(1, "cd_unidade_federacao", "T")
	lvdwc.SetItem(1, "nm_unidade_federacao", "TODAS")
	
	dw_1.Object.Cd_UF[1] = "T"
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild da U.F..")
End If
end subroutine

on w_ge533_produto_bloqueado_distribuidora.create
call super::create
end on

on w_ge533_produto_bloqueado_distribuidora.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event open;call super::open;ivo_Produto 		= Create uo_Produto
ivo_Fornecedor 	= Create uo_Fornecedor
end event

event close;call super::close;If isValid(ivo_Produto) Then Destroy(ivo_Produto)
If isValid(ivo_Fornecedor) Then Destroy(ivo_Fornecedor)
end event

event ue_postopen;call super::ue_postopen;dw_1.Object.dt_inicio	[1] = RelativeDate(Today(),-1)
dw_1.Object.dt_termino	[1] = RelativeDate(Today(),-1)

wf_insere_padrao()

end event

type dw_visual from dc_w_selecao_lista_relatorio`dw_visual within w_ge533_produto_bloqueado_distribuidora
integer x = 146
integer y = 1676
end type

type gb_aux_visual from dc_w_selecao_lista_relatorio`gb_aux_visual within w_ge533_produto_bloqueado_distribuidora
integer x = 110
integer y = 1604
end type

type gb_2 from dc_w_selecao_lista_relatorio`gb_2 within w_ge533_produto_bloqueado_distribuidora
integer y = 452
integer width = 5303
integer height = 1444
end type

type gb_1 from dc_w_selecao_lista_relatorio`gb_1 within w_ge533_produto_bloqueado_distribuidora
integer width = 1669
integer height = 428
end type

type dw_1 from dc_w_selecao_lista_relatorio`dw_1 within w_ge533_produto_bloqueado_distribuidora
integer width = 1600
integer height = 312
string dataobject = "dw_ge533_selecao"
end type

event dw_1::editchanged;call super::editchanged;Choose Case dwo.Name
	Case "de_produto"
		If Not IsNull(Data) and Data <> "" Then
			If Data <> ivo_Produto.ivs_Descricao_Apresentacao_Estoque Then
				Return 1
			End If
		Else
			ivo_Produto.of_Inicializa()
			
			This.Object.Cd_Produto[1] = ivo_Produto.Cd_Produto
			This.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque
		End If
		
		
End Choose
end event

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)
end event

event dw_1::itemchanged;call super::itemchanged;dw_2.Event ue_Reset()

Long ll_Nulo

String ls_Nulo

SetNull(ll_Nulo)
SetNull(ls_Nulo)

Choose Case dwo.Name
	Case "de_produto"
		If Not IsNull(Data) and Data <> "" Then
			If Data <> ivo_Produto.ivs_Descricao_Apresentacao_Estoque Then
				Return 1
			End If
		Else
			ivo_Produto.of_Inicializa()
			
			This.Object.Cd_Produto[1] = ivo_Produto.Cd_Produto
			This.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque
		End If
		
	/*Case "cd_distribuidora"
		If IsNull(dw_1.Object.Cd_Produto[1]) Then
			If Data <> "000000000" Then
				dw_1.Object.Id_Planilha.Visible = True
			End If
			
			dw_1.Object.Id_Homologacao.Visible = False
			
		Else		
		
			If Data <> "000000000" Then
				dw_1.Object.Id_Homologacao.Visible = False
			Else
				dw_1.Object.Id_Homologacao.Visible = True
			End If
		End If*/
		
End Choose
end event

event dw_1::losefocus;call super::losefocus;If IsValid(ivo_Produto) Then
	This.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque
End If

end event

event dw_1::ue_key;call super::ue_key;dw_1.AcceptText()

If Key = KeyEnter! Then
	Choose Case This.GetColumnName()
		Case "de_produto"
			ivo_Produto.of_Localiza_Produto(This.GetText())
			
			If ivo_Produto.Localizado Then
				This.Object.Cd_Produto[1] = ivo_Produto.Cd_Produto
				This.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Estoque
				
				is_Produto = ""
				
			End If
			
	End Choose
End If
end event

type dw_2 from dc_w_selecao_lista_relatorio`dw_2 within w_ge533_produto_bloqueado_distribuidora
integer y = 524
integer width = 5257
integer height = 1344
string dataobject = "dw_ge533_lista"
boolean hscrollbar = true
end type

event dw_2::ue_recuperar;//OverRide

Long ll_Cd_Produto
Datetime ldh_Inicio,ldh_Termino
String ls_id_distribuidora,ls_id_uf

dw_1.AcceptText()

ldh_Inicio 			= DateTime(dw_1.Object.dt_inicio		[1])
ldh_Termino 		= DateTime(dw_1.Object.dt_termino 	[1])
ls_Id_Uf				= dw_1.Object.cd_uf						[1]
ll_Cd_Produto		= dw_1.Object.cd_produto           		[1]
ls_Id_Distribuidora	= dw_1.Object.cd_distribuidora		[1]

If IsNull(ldh_Inicio) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de in$$HEX1$$ed00$$ENDHEX$$cio corretamente.", Information!)
	dw_1.Event ue_Pos(1, "dt_inicio")
	Return -1
End If

If IsNull(ldh_Termino)  Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a data de t$$HEX1$$e900$$ENDHEX$$rmino corretamente.", Information!)
	dw_1.Event ue_Pos(1, "dt_termino")	
	Return -1
End If

If ldh_Inicio > ldh_Termino Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "A data de t$$HEX1$$e900$$ENDHEX$$rmino deve ser maior que a data de in$$HEX1$$ed00$$ENDHEX$$cio.", Information!)
	dw_1.Event ue_Pos(1, "dt_termino")	
	Return -1
End If


If ls_Id_Uf <> 'T'  Then
	This.of_AppendWhere("d.cd_unidade_federacao ='" + ls_Id_Uf + "'")
End If

If Not IsNull (ll_Cd_Produto) and ll_Cd_Produto <> 0 Then
	This.of_AppendWhere("d.cd_produto =" +  String(ll_Cd_Produto))
End If

If ls_id_distribuidora <> "000000000" Then
	This.of_AppendWhere("d.cd_distribuidora ='" + ls_Id_Distribuidora + "'")
End If

ldh_Inicio = DateTime(String(ldh_Inicio	, "dd/mm/yyyy 00:00:00"))
ldh_Termino= DateTime(String(ldh_Termino		, "dd/mm/yyyy 23:59:59"))

Return This.Retrieve(ldh_Inicio, ldh_Termino)
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If AncestorReturnValue > 0 Then
	ivo_Controle_Menu.of_SalvarComo(True)
Else
	ivo_Controle_Menu.of_SalvarComo(False)
End If

Return AncestorReturnValue
end event

type dw_3 from dc_w_selecao_lista_relatorio`dw_3 within w_ge533_produto_bloqueado_distribuidora
boolean visible = false
integer x = 119
integer y = 1780
end type

