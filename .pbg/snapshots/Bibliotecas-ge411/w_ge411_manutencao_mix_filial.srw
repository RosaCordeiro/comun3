HA$PBExportHeader$w_ge411_manutencao_mix_filial.srw
forward
global type w_ge411_manutencao_mix_filial from dc_w_2tab_cadastro_selecao_lista_det
end type
type cb_incluir from picturebutton within tabpage_2
end type
type cb_excluir from picturebutton within tabpage_2
end type
end forward

global type w_ge411_manutencao_mix_filial from dc_w_2tab_cadastro_selecao_lista_det
string accessiblename = "Manuten$$HEX2$$e700e300$$ENDHEX$$o de Mix de Filial (GE411)"
integer width = 1938
integer height = 1628
string title = "GE411 - Manuten$$HEX2$$e700e300$$ENDHEX$$o de Mix de Filial"
end type
global w_ge411_manutencao_mix_filial w_ge411_manutencao_mix_filial

type variables
Long il_Lojas
Long il_Linha_Dw_2

String is_Filiais
String is_Nulo
String is_Responsavel

dc_uo_dw_base dw_1, dw_2, dw_3
end variables

forward prototypes
public function boolean wf_lista_mix_estoque_base (long al_filial, long al_mix)
public function boolean wf_grava_historico (long al_filial, long al_produto, long al_qtd_eb)
public subroutine _documentacao ()
end prototypes

public function boolean wf_lista_mix_estoque_base (long al_filial, long al_mix);Long ll_Linha
Long ll_Produto
Long ll_Qt_Eb

dc_uo_ds_base lds
lds = Create dc_uo_ds_base

If Not lds.of_ChangeDataObject("ds_ge411_lista_mix_estoque_base") Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao carregar o data store 'ds_ge411_lista_mix_estoque_base'.", StopSign!)
	Destroy(lds)
	Return False
End If

lds.Retrieve(al_Filial, al_Mix)

If lds.RowCount() < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no retrieve do data store 'ds_ge411_lista_mix_estoque_base'.", StopSign!)
	Destroy(lds)
	Return False
End If

If lds.RowCount() > 0 Then
	
	For ll_Linha = 1 To lds.RowCount()
		ll_Produto	= lds.Object.Cd_Produto			[ll_Linha]
		ll_Qt_Eb		= lds.Object.Qt_Estoque_Base	[ll_Linha]
		
		If Not wf_Grava_Historico(al_Filial, ll_Produto, ll_Qt_Eb) Then
			Destroy(lds)
			Return False
		End If
	Next
End If

Destroy(lds)

Return True
end function

public function boolean wf_grava_historico (long al_filial, long al_produto, long al_qtd_eb);String ls_Chave
String ls_Nulo
String ls_Qtd_Eb

SetNull(ls_Nulo)

ls_Chave		= String(al_Filial) + "@#!" + String(al_Produto)
ls_Qtd_Eb	= String(al_Qtd_Eb)

Insert Into historico_alteracao_tabela(nm_tabela,
												de_chave,
												nm_coluna,
												de_alteracao_de,
												de_alteracao_para,
												nr_matric_alteracao,
												id_alteracao)
									Values('RESUMO_REPOSICAO_ESTOQUE',
											 :ls_Chave,
											 'QT_ESTOQUE_BASE',
											 :ls_Qtd_Eb,
											 :ls_Nulo,
											 :is_Responsavel,
											 'E')
								Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError('Erro ao gravar o hist$$HEX1$$f300$$ENDHEX$$rico de altera$$HEX2$$e700e300$$ENDHEX$$o. Fun$$HEX2$$e700e300$$ENDHEX$$o wf_grava_historico')
	Return False
End If

Return True
end function

public subroutine _documentacao ();/*

	Objetivo: Nesta tela $$HEX1$$e900$$ENDHEX$$ definido o mix para cada filial.
	Chamado: 
	Respons$$HEX1$$e100$$ENDHEX$$vel: Cesar Pereira

	Tabelas: 
				- vw_filial
				- mix_produto
				- mix_produto_filial
				
			
	Mix da Filial Diferente do CD
									

*/


end subroutine

on w_ge411_manutencao_mix_filial.create
int iCurrent
call super::create
end on

on w_ge411_manutencao_mix_filial.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_preopen;call super::ue_preopen;ivl_Largura_1	= 1902
ivl_Altura_1		= 1448
ivl_Largura_2	= 1797
ivl_Altura_2		= 1448
end event

event open;call super::open;dw_1 = Tab_1.TabPage_1.dw_1
dw_2 = Tab_1.TabPage_1.dw_2
dw_3 = Tab_1.TabPage_2.dw_3
end event

event ue_postopen;call super::ue_postopen;dw_1.ivo_Controle_Menu.of_Incluir(False)
end event

type dw_visual from dc_w_2tab_cadastro_selecao_lista_det`dw_visual within w_ge411_manutencao_mix_filial
integer x = 37
integer y = 844
end type

type gb_aux_visual from dc_w_2tab_cadastro_selecao_lista_det`gb_aux_visual within w_ge411_manutencao_mix_filial
integer x = 0
integer y = 772
end type

type tab_1 from dc_w_2tab_cadastro_selecao_lista_det`tab_1 within w_ge411_manutencao_mix_filial
integer width = 1865
integer height = 1420
end type

event tab_1::selectionchanged;//OverRide

SetPointer(HourGlass!)

Choose Case NewIndex
	Case 1
		This.Width  = Parent.ivl_Largura_1
		This.Height = Parent.ivl_Altura_1
		
		Tab_1.TabPage_1.dw_2.SetFocus()
	Case 2
		This.Width  = Parent.ivl_Largura_2		
		This.Height = Parent.ivl_Altura_2
		
		Tab_1.TabPage_2.dw_3.SetFocus()
		Parent.ivb_Inclusao = False
End Choose
	
Parent.Width  = This.Width + This.X + 75
Parent.Height = This.Height + This.Y + 155

dw_1.ivo_Controle_Menu.of_Incluir(False)

SetPointer(Arrow!)
end event

event tab_1::selectionchanging;//OverRide

SetPointer(HourGlass!)

Choose Case NewIndex
	Case 1
		If Tab_1.TabPage_1.dw_2.RowCount() > 0 Then Tab_1.TabPage_1.dw_2.Event ue_Retrieve()
		dw_2.Event ue_Pos(il_Linha_Dw_2, "cd_filial")
		
	Case 2
		If Not Parent.ivb_Inclusao Then
			If Tab_1.TabPage_1.dw_2.GetRow() > 0 Then
				// Executa o evento de recupera$$HEX2$$e700e300$$ENDHEX$$o das linhas das DW's de detalhes
				Tab_1.TabPage_2.dw_3.Event ue_Retrieve()
				
				//Utilizado para quando voltar para a aba sele$$HEX2$$e700e300$$ENDHEX$$o o foco esteja na filial que estava selecionada
				If dw_2.RowCount() > 0 Then
					il_Linha_Dw_2 = dw_2.GetRow()
				End If
		
				// Permite a troca do folder
				Return 0
			Else
				MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione uma linha da lista para visualizar os detalhes.", StopSign!)
				// N$$HEX1$$e300$$ENDHEX$$o permite a troca do folder
				Return 1
			End If
		End If
End Choose

SetPointer(Arrow!)
end event

type tabpage_1 from dc_w_2tab_cadastro_selecao_lista_det`tabpage_1 within tab_1
integer width = 1829
integer height = 1304
end type

type gb_2 from dc_w_2tab_cadastro_selecao_lista_det`gb_2 within tabpage_1
integer y = 200
integer width = 1783
integer height = 1084
end type

type gb_1 from dc_w_2tab_cadastro_selecao_lista_det`gb_1 within tabpage_1
integer width = 1440
integer height = 184
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
end type

type dw_1 from dc_w_2tab_cadastro_selecao_lista_det`dw_1 within tabpage_1
integer width = 1358
integer height = 92
string dataobject = "dw_ge411_selecao"
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

dw_2.Reset()
end event

event dw_1::editchanged;call super::editchanged;dw_2.Reset()
end event

type dw_2 from dc_w_2tab_cadastro_selecao_lista_det`dw_2 within tabpage_1
integer y = 280
integer width = 1710
integer height = 984
string dataobject = "dw_ge411_lista"
end type

event dw_2::ue_preretrieve;call super::ue_preretrieve;String ls_Conjunto

dw_1.AcceptText()

ls_Conjunto = dw_1.Object.Id_Filiais[1]

If ls_Conjunto <> "T" Then
	If il_Lojas > 0 Then
		//Foi inclu$$HEX1$$ed00$$ENDHEX$$do no select da dw 'where cd_filial is not null' para fazer o appendwhere_subquery sem erro
		dw_2.of_AppendWhere_SubQuery("f.cd_filial in (" + is_Filiais + ")", 2)
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione ao menos uma filial.")
		Return -1
	End If
End If

Return AncestorReturnValue
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;dw_1.ivo_Controle_Menu.of_Incluir(False)
dw_1.ivo_controle_menu.of_salvarcomo(True)
Return pl_Linhas
end event

event dw_2::constructor;call super::constructor;This.ivb_Ordena_Colunas = True
end event

type tabpage_2 from dc_w_2tab_cadastro_selecao_lista_det`tabpage_2 within tab_1
integer width = 1829
integer height = 1304
cb_incluir cb_incluir
cb_excluir cb_excluir
end type

on tabpage_2.create
this.cb_incluir=create cb_incluir
this.cb_excluir=create cb_excluir
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_incluir
this.Control[iCurrent+2]=this.cb_excluir
end on

on tabpage_2.destroy
call super::destroy
destroy(this.cb_incluir)
destroy(this.cb_excluir)
end on

type gb_3 from dc_w_2tab_cadastro_selecao_lista_det`gb_3 within tabpage_2
integer width = 1687
integer height = 1156
string text = "Lista de Mix"
end type

type dw_3 from dc_w_2tab_cadastro_selecao_lista_det`dw_3 within tabpage_2
integer width = 1618
integer height = 1072
string dataobject = "dw_ge411_detalhe"
boolean hscrollbar = true
boolean vscrollbar = true
boolean hsplitscroll = true
end type

event dw_3::ue_recuperar;//OverRide

Long ll_Filial
Long ll_Linha

dw_2.AcceptText()

ll_Linha	= dw_2.GetRow()
ll_Filial	= dw_2.Object.Cd_Filial[ll_Linha]

dw_3.Object.Filial_t.Text = dw_2.Object.Nm_Fantasia[ll_Linha] + " (" + String(ll_Filial) + ")"

Return This.Retrieve(ll_Filial)
end event

event dw_3::constructor;call super::constructor;This.of_SetRowSelection()
end event

event dw_3::ue_postretrieve;call super::ue_postretrieve;dw_3.ivo_Controle_Menu.of_Incluir(False)
dw_3.ivo_Controle_Menu.of_Excluir(False)
dw_3.ivo_controle_menu.of_salvarcomo(True)
Return pl_Linhas
end event

type cb_incluir from picturebutton within tabpage_2
integer x = 933
integer y = 1184
integer width = 375
integer height = 108
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\botao_incluir.png"
alignment htextalign = left!
long backcolor = 67108864
end type

event clicked;Long ll_Linha
Long ll_Filial

String ls_Retorno
String ls_Nome_Fantasia

dw_1.AcceptText()

If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("GE411_LIBERACAO_PROCEDIMENTO", Ref is_Responsavel) Then
	Return -1
End If

ll_Linha = dw_2.GetRow()

ll_Filial = dw_2.Object.Cd_Filial[ll_Linha]

If ll_Linha > 0 Then
	
	str_parametros_inclusao str
	
	str.Cd_Filial				= ll_Filial
	str.Nm_Fantasia		= dw_2.Object.Nm_Fantasia[ll_Linha]

	OpenWithParm(w_ge411_incluir_mix_filial, str)
	
	ls_Retorno = Message.StringParm
	
	If Not IsNull(ls_Retorno) Then dw_3.Retrieve(ll_Filial)
	
	dw_3.SetFocus()
End If
end event

type cb_excluir from picturebutton within tabpage_2
integer x = 1335
integer y = 1184
integer width = 375
integer height = 108
integer taborder = 50
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\botao_excluir.png"
alignment htextalign = left!
long backcolor = 67108864
end type

event clicked;Boolean lb_Sucesso = True

Long ll_Linha_Dw_2
Long ll_Linha_Dw_3
Long ll_Filial
Long ll_Cd_Mix

String ls_Mix

dw_2.AcceptText()
dw_3.AcceptText()

If Not gvo_Aplicacao.ivo_Seguranca.of_Libera_Acesso_Procedimento("GE411_LIBERACAO_PROCEDIMENTO", Ref is_Responsavel) Then 
	Return -1
End If

ll_Linha_Dw_2 = dw_2.GetRow()
ll_Linha_Dw_3 = dw_3.GetRow()

If ll_Linha_Dw_3 > 0 Then
	ll_Filial		= dw_2.Object.Cd_Filial				[ll_Linha_Dw_2]
	ll_Cd_Mix	= dw_3.Object.Cd_Mix_Produto	[ll_Linha_Dw_3]
	ls_Mix			= dw_3.Object.De_Mix_Produto	[ll_Linha_Dw_3]
	
	If MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Se o mix '" + ls_Mix + "' for exclu$$HEX1$$ed00$$ENDHEX$$do ser$$HEX1$$e300$$ENDHEX$$o apagados todas informa$$HEX2$$e700f500$$ENDHEX$$es de estoque base." + &
									"~rDeseja continuar mesmo assim ?", Question!, YesNo!, 2) = 2 Then
		Return -1
	End If
	
	If Not wf_Lista_Mix_Estoque_Base(ll_Filial, ll_Cd_Mix) Then
		lb_Sucesso = False
	End If
	
	If lb_Sucesso Then
		Delete From mix_produto_filial
		Where cd_filial = :ll_Filial
			And cd_mix_produto = :ll_Cd_Mix
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgdbError('Erro ao excluir o mix da filial. Bot$$HEX1$$e300$$ENDHEX$$o Excluir')
			lb_Sucesso = False
		End If
	End If
	
	If lb_Sucesso Then
		SqlCa.of_Commit();
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Mix exclu$$HEX1$$ed00$$ENDHEX$$do com sucesso.")
		dw_3.Retrieve(ll_Filial)
		dw_3.SetFocus()
	Else
		SqlCa.of_RollBack();
	End If
End If
end event

