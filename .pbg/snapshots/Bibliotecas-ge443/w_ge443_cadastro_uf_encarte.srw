HA$PBExportHeader$w_ge443_cadastro_uf_encarte.srw
forward
global type w_ge443_cadastro_uf_encarte from dc_w_cadastro_selecao_lista
end type
end forward

global type w_ge443_cadastro_uf_encarte from dc_w_cadastro_selecao_lista
integer width = 2816
integer height = 1800
string title = "GE443 - Cadastro de U.F. para Encarte"
end type
global w_ge443_cadastro_uf_encarte w_ge443_cadastro_uf_encarte

type variables

end variables

forward prototypes
public subroutine wf_insere_uf_default ()
public subroutine wf_inicializa ()
end prototypes

public subroutine wf_insere_uf_default ();DataWindowChild lvdwc

Integer lvi_Retorno,&
        lvi_Row

If dw_1.GetChild("cd_uf", lvdwc) = 1 Then
	lvdwc.InsertRow(1)
	
	lvdwc.SetItem(1, "cd_unidade_federacao", "XX")
	lvdwc.SetItem(1, "nm_unidade_federacao", "TODAS")
	
	dw_1.Object.Cd_UF[1] = "XX"
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no getchild da U.F..")
End If
end subroutine

public subroutine wf_inicializa ();dw_1.ivo_Controle_Menu.of_Incluir(False)
dw_2.ivo_Controle_Menu.of_Incluir(False)

dw_1.ivo_Controle_Menu.of_Excluir(False)
dw_2.ivo_Controle_Menu.of_Excluir(False)
end subroutine

on w_ge443_cadastro_uf_encarte.create
call super::create
end on

on w_ge443_cadastro_uf_encarte.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event ue_postopen;call super::ue_postopen;wf_Insere_UF_Default()

dw_2.Event ue_Retrieve()

dw_1.SetFocus()

wf_Inicializa()

uo_subcategoria lo_Subcategoria //GE022
lo_Subcategoria = Create uo_subcategoria

lo_Subcategoria.of_Localiza_Codigo('509001001')

dw_1.Object.Subcategoria_t.Text = "Somente Produtos da Subcategoria: " + lo_Subcategoria.De_Subcategoria + " (" + lo_Subcategoria.Cd_Subcategoria + ")"

If IsValid(lo_Subcategoria) Then Destroy(lo_Subcategoria)
end event

event ue_cancel;call super::ue_cancel;dw_1.Enabled = True

wf_Inicializa()
end event

event ue_preupdate;call super::ue_preupdate;Long ll_Find
Long ll_Linha
Long ll_Produto

String ls_Para
String ls_De
String ls_Erro

dw_2.AcceptText()

ll_Find = dw_2.Find("isnull(cd_uf_encarte)", 1, dw_2.RowCount())

If ll_Find < 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro no Find da dw_2.", StopSign!)
	Return False
End If

If ll_Find > 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a U.F. do encarte " + String(dw_2.Object.Cd_Produto[ll_Find]) + "'.", Exclamation!)
	Return False
End If

For ll_Linha = 1 To dw_2.RowCount()
	ll_Produto = dw_2.Object.Cd_Produto[ll_Linha]
	
	Select cd_uf_encarte
		Into: ls_De
	From produto_central
	Where cd_produto = :ll_Produto
	Using SqlCa;
	
	If SqlCa.SqlCode = -1 Then
		ls_Erro = SqlCa.SqlErrText
		SqlCa.of_Rollback();
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao consultar o produto '" + String(ll_Produto) + "' na produto_uf. " + ls_Erro, StopSign!)
		Return False
	End If
	
	If gf_Houve_Alteracao_Dw(dw_2, 'CD_UF_ENCARTE', ll_Linha, Ref ls_Para) Then
		If Not gf_Grava_Historico_Alteracao_Tabela('PRODUTO_CENTRAL', String(ll_Produto), 'CD_UF_ENCARTE', ls_De, ls_Para, gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, 'A', Ref ls_Erro, True) Then Return False
	End If
Next

Return True
end event

event ue_save;call super::ue_save;wf_Inicializa()

If AncestorReturnValue = 1 Then
	dw_1.Enabled = True
End If

Return AncestorReturnValue
end event

type dw_visual from dc_w_cadastro_selecao_lista`dw_visual within w_ge443_cadastro_uf_encarte
integer x = 37
integer y = 984
end type

type gb_aux_visual from dc_w_cadastro_selecao_lista`gb_aux_visual within w_ge443_cadastro_uf_encarte
integer x = 0
integer y = 912
end type

type dw_1 from dc_w_cadastro_selecao_lista`dw_1 within w_ge443_cadastro_uf_encarte
integer y = 72
integer width = 1842
integer height = 148
string dataobject = "dw_ge443_selecao"
end type

event dw_1::editchanged;call super::editchanged;dw_2.Event ue_Reset()
end event

event dw_1::itemchanged;call super::itemchanged;dw_2.Event ue_Reset()
end event

event dw_1::ue_cancel;//OverRide
end event

event dw_1::losefocus;call super::losefocus;wf_Inicializa()
end event

type gb_2 from dc_w_cadastro_selecao_lista`gb_2 within w_ge443_cadastro_uf_encarte
integer y = 268
integer width = 2702
integer height = 1336
end type

type gb_1 from dc_w_cadastro_selecao_lista`gb_1 within w_ge443_cadastro_uf_encarte
integer width = 1929
integer height = 232
end type

type dw_2 from dc_w_cadastro_selecao_lista`dw_2 within w_ge443_cadastro_uf_encarte
integer y = 344
integer width = 2619
integer height = 1224
string dataobject = "dw_ge443_lista"
end type

event dw_2::constructor;call super::constructor;This.ivb_Ordena_Colunas = True

ivi_Tipo_Cancelar = RETRIEVE
end event

event dw_2::editchanged;call super::editchanged;dw_1.Enabled = False

wf_Inicializa()
end event

event dw_2::itemchanged;call super::itemchanged;dw_1.Enabled = False

wf_Inicializa()
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;String ls_UF

dw_1.AcceptText()

ls_UF = dw_1.Object.Cd_UF[1]

If ls_UF <> "XX" Then
	This.of_AppendWhere("c.cd_uf_encarte = '" + ls_UF + "'")
End If

Return 1
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	dw_2.ivo_Controle_Menu.of_SalvarComo(True)
Else
	dw_2.ivo_Controle_Menu.of_SalvarComo(False)
End If

wf_Inicializa()

Return pl_Linhas
end event

event dw_2::itemfocuschanged;call super::itemfocuschanged;wf_Inicializa()
end event

event dw_2::losefocus;call super::losefocus;wf_Inicializa()
end event

