HA$PBExportHeader$w_ge346_manutencao_produto_promocao.srw
forward
global type w_ge346_manutencao_produto_promocao from dc_w_cadastro_selecao_lista
end type
type pb_1 from picturebutton within w_ge346_manutencao_produto_promocao
end type
type cb_1 from commandbutton within w_ge346_manutencao_produto_promocao
end type
end forward

global type w_ge346_manutencao_produto_promocao from dc_w_cadastro_selecao_lista
integer width = 3648
integer height = 1788
string title = "GE346 - Produtos para Retirar do C$$HEX1$$e100$$ENDHEX$$lculo do EB / M$$HEX1$$ed00$$ENDHEX$$nimo de Promo$$HEX2$$e700e300$$ENDHEX$$o"
pb_1 pb_1
cb_1 cb_1
end type
global w_ge346_manutencao_produto_promocao w_ge346_manutencao_produto_promocao

type variables
uo_produto io_Produto

Boolean ivb_Check

Boolean ib_iniciado_operacao_sap = false
end variables

forward prototypes
public subroutine wf_inicializa ()
public subroutine wf_valida_bloqueio ()
end prototypes

public subroutine wf_inicializa ();ivm_Menu.mf_Classificar(False)
ivm_Menu.mf_Localizar(False)
ivm_Menu.mf_Incluir(False)
ivm_Menu.mf_Excluir(False)
end subroutine

public subroutine wf_valida_bloqueio ();string ls_valor
date ldt_data

Select vl_parametro
into :ls_valor
from parametro_geral
where cd_parametro = 'DH_CUTOVER_MAX_PROMOCAO';

If SQLCA.sqlcode = -1 Then
	messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','Erro ao consultar a tabela "PARAMETRO_GERAL": ' + sqlca.sqlerrtext)
	return
end if

if not isnull( ls_valor ) and ls_valor <> '' Then
	
	ldt_data = date(ls_valor)
	
	if ldt_data <= date( gf_getserverdate() ) Then 
		
		dw_2.modify('qt_estoque_minimo.protect=1 id_retira_venda_calculo_eb.protect=1')
		
	end if
	
end if

return
end subroutine

on w_ge346_manutencao_produto_promocao.create
int iCurrent
call super::create
this.pb_1=create pb_1
this.cb_1=create cb_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_1
this.Control[iCurrent+2]=this.cb_1
end on

on w_ge346_manutencao_produto_promocao.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_1)
destroy(this.cb_1)
end on

event open;call super::open;io_Produto = Create uo_Produto
end event

event close;call super::close;Destroy(io_Produto)
end event

event ue_postopen;call super::ue_postopen;String ls_msg

wf_Inicializa()

wf_valida_bloqueio()

If Not gf_verifica_inicio_operacao_sap('DH_INICIO_OPERACAO_SAP', ref ib_iniciado_operacao_sap, ref ls_msg ) Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o",ls_msg,StopSign!)
	Post Event Close(this)
End If

If ib_iniciado_operacao_sap Then wf_set_somente_consulta()
end event

event ue_cancel;//OverRide

This.ivb_Valida_Salva = False
dw_2.Event ue_Cancel()
end event

type dw_visual from dc_w_cadastro_selecao_lista`dw_visual within w_ge346_manutencao_produto_promocao
integer x = 37
integer y = 908
end type

type gb_aux_visual from dc_w_cadastro_selecao_lista`gb_aux_visual within w_ge346_manutencao_produto_promocao
integer x = 0
integer y = 836
end type

type dw_1 from dc_w_cadastro_selecao_lista`dw_1 within w_ge346_manutencao_produto_promocao
integer x = 69
integer y = 80
integer width = 1897
integer height = 100
string dataobject = "dw_ge346_selecao"
end type

event dw_1::ue_key;call super::ue_key;If Key = KeyEnter! Then
	If This.GetColumnName() = "de_produto" Then
		io_Produto.of_Localiza_Produto(This.GetText())
		
		If Not io_Produto.Localizado Then
			io_Produto.of_Inicializa()
		End If
		
		This.Object.Cd_Produto	[1]	= io_Produto.Cd_Produto
		This.Object.De_Produto	[1]	= io_Produto.ivs_Descricao_Apresentacao_Estoque
	End If
End If
end event

event dw_1::editchanged;call super::editchanged;dw_2.Event ue_Reset()

If dwo.Name = "de_produto" Then
	If Not IsNull(Data) And Trim(Data) <> "" Then
		If Data <> io_Produto.ivs_Descricao_Apresentacao_Estoque Then
			Return 1
		End If
	Else
		io_Produto.of_Inicializa()
		
		This.Object.Cd_Produto	[1] = io_Produto.Cd_Produto
		This.Object.De_Produto	[1] = io_Produto.ivs_Descricao_Apresentacao_Estoque
	End If
End If

wf_Inicializa()
end event

event dw_1::itemchanged;call super::itemchanged;dw_2.Event ue_Reset()

If dwo.Name = "de_produto" Then
	If Not IsNull(Data) And Trim(Data) <> "" Then
		If Data <> io_Produto.ivs_Descricao_Apresentacao_Estoque Then
			Return 1
		End If
	Else
		io_Produto.of_Inicializa()
		
		This.Object.Cd_Produto	[1] = io_Produto.Cd_Produto
		This.Object.De_Produto	[1] = io_Produto.ivs_Descricao_Apresentacao_Estoque
	End If
End If

wf_Inicializa()
end event

type gb_2 from dc_w_cadastro_selecao_lista`gb_2 within w_ge346_manutencao_produto_promocao
integer y = 224
integer width = 3529
integer height = 1348
end type

type gb_1 from dc_w_cadastro_selecao_lista`gb_1 within w_ge346_manutencao_produto_promocao
integer width = 2089
integer height = 208
end type

type dw_2 from dc_w_cadastro_selecao_lista`dw_2 within w_ge346_manutencao_produto_promocao
integer y = 300
integer width = 3447
integer height = 1240
string dataobject = "dw_ge346_lista"
end type

event dw_2::ue_recuperar;//OverRide
Long ll_Produto

dw_1.AcceptText()

ll_Produto = dw_1.Object.Cd_Produto[1]

If IsNull(ll_Produto) Then
	This.of_AppendWhere_SubQuery("(Coalesce(pp.id_retira_venda_calculo_eb, 'N') = 'S' or pp.qt_estoque_minimo > 0)", 1 )
	This.of_AppendWhere_SubQuery("(Coalesce(pp.id_retira_venda_calculo_eb, 'N') = 'S' or pp.qt_estoque_minimo > 0)", 5 )
Else
	This.of_AppendWhere_SubQuery("pp.cd_produto = " + String(ll_Produto), 1 )
	This.of_AppendWhere_SubQuery("pp.cd_produto = " + String(ll_Produto), 5 )
End If

Return This.Retrieve()
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;wf_Inicializa()

If pl_Linhas > 0 Then
	dw_2.ivo_Controle_Menu.of_SalvarComo(True)
Else
	dw_2.ivo_Controle_Menu.of_SalvarComo(False)
End If

Return pl_Linhas
end event

event dw_2::ue_preretrieve;call super::ue_preretrieve;Long ll_Produto

dw_1.AcceptText()

ll_Produto = dw_1.Object.Cd_Produto[1]

//If IsNull(ll_Produto) Or ll_Produto = 0 Then
//	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o produto.", Exclamation!)
//	dw_1.Event ue_Pos(1, "de_produto")
//	Return -1
//End If

Return 1
end event

event dw_2::ue_preupdate;call super::ue_preupdate;Long ll_Linha
Long ll_Promocao
Long ll_Produto
Long ll_Nulo

Decimal ldc_Fat_Conv

String ls_Para
String ls_De
String ls_Chave
String ls_Erro

SetNull(ll_Nulo)

This.AcceptText()

For ll_Linha = 1 To This.RowCount()	
	
//	ldc_Fat_Conv = This.Object.vl_fator_conversao[ll_Linha]
	
//	If This.Object.qt_estoque_minimo[ll_Linha] < 0 Then
//		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O m$$HEX1$$ed00$$ENDHEX$$nimo de promo$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o pode ser negativo.", Exclamation!)
//		This.Event ue_Pos(ll_Linha, "qt_estoque_minimo")
//		Return -1 
//	End If
//	
//	If ldc_Fat_Conv > 1 Then
//		If Mod(This.Object.qt_estoque_minimo[ll_Linha], ldc_Fat_Conv) <> 0 Then
//			Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O m$$HEX1$$ed00$$ENDHEX$$nimo de promo$$HEX2$$e700e300$$ENDHEX$$o dever$$HEX1$$e100$$ENDHEX$$ ser m$$HEX1$$fa00$$ENDHEX$$ltiplo do fator de convers$$HEX1$$e300$$ENDHEX$$o '" + String(Long(ldc_Fat_Conv)) + "'.", Exclamation!)
//			This.Event ue_Pos(ll_Linha, "qt_estoque_minimo")
//			Return -1 
//		End If
//	End If
	
//	If This.Object.qt_estoque_minimo[ll_Linha] > 999 Then
//		Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O m$$HEX1$$ed00$$ENDHEX$$nimo de promo$$HEX2$$e700e300$$ENDHEX$$o n$$HEX1$$e300$$ENDHEX$$o ser maior que 999.", Exclamation!)
//		This.Event ue_Pos(ll_Linha, "qt_estoque_minimo")
//		Return -1 
//	End If
	
	ll_Promocao	= This.Object.Cd_Promocao_Sos	[ll_Linha]
	ll_Produto	= This.Object.Cd_Produto			[ll_Linha]
	
	If gf_Houve_Alteracao_Dw(This, 'ID_RETIRA_VENDA_CALCULO_EB', ll_Linha, Ref ls_Para) Then
		ls_Chave = MidA(String(ll_Promocao) + Space(5), 1, 5) + "@#!" + String(ll_Produto)
				
		If ls_Para = "S" Then
			ls_De = "N"
		Else
			ls_De = "S"
		End If
		
		If Not gf_Grava_Historico_Alteracao_Tabela('PROMOCAO_SOS_PRODUTO', ls_Chave, 'ID_RETIRA_VENDA_CALCULO_EB', ls_De, ls_Para, gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, 'A', Ref ls_Erro, True) Then
			Return -1
		End If
	End If
	
//	If gf_Houve_Alteracao_Dw(This, 'QT_ESTOQUE_MINIMO', ll_Linha, Ref ls_Para) Then
//		
//		If ls_Para = '0' Then
//			This.Object.qt_estoque_minimo[ll_Linha] = ll_Nulo
//			SetNull(ls_Para)
//		End If
//		
//		ls_Chave = MidA(String(ll_Promocao) + Space(5), 1, 5) + "@#!" + String(ll_Produto)
//		
//		ls_De = String(This.Object.qt_estoque_minimo_anterior	[ll_Linha])
//		
//		If Not gf_Grava_Historico_Alteracao_Tabela('PROMOCAO_SOS_PRODUTO', ls_Chave, 'QT_ESTOQUE_MINIMO', ls_De, ls_Para, gvo_Aplicacao.ivo_Seguranca.Nr_Matricula, 'A', Ref ls_Erro, True) Then
//			Return -1
//		End If
//	End If
		
Next

Return 1
end event

event dw_2::constructor;call super::constructor;String lvs_Coluna[], &
       lvs_Nome[]

//This.ivb_Ordena_Colunas = True

ivi_Tipo_Cancelar = RETRIEVE

This.of_SetRowSelection( "if(id_vigente = ~"S~", if(getrow() = currentrow(), rgb(0,128,128), rgb(255, 255, 255)),  if(getrow() = currentrow(), rgb(139,129,76), rgb(255,236,139)) )", "", False )

This.of_SetFilter()
end event

event dw_2::doubleclicked;call super::doubleclicked;If dwo.Name = 'st_selecionado' Then
	
	Long lvl_Row
	
	String lvs_Marcacao
	
	If ivb_Check Then
		lvs_Marcacao = 'N'
		ivb_Check = False
	Else
		lvs_Marcacao = 'S'
		ivb_Check = True
	End If
	
	This.AcceptText()
	
	For lvl_Row = 1 To This.RowCount()
	
		This.Object.Id_Retira_Venda_Calculo_Eb[lvl_Row] = lvs_Marcacao
	Next
End If

Parent.ivm_Menu.mf_Confirmar(True)
Parent.ivm_Menu.mf_Cancelar(True)

If Not This.of_Coluna_Sem_Validacao_Salva(dwo.Name) Then
	If ivb_UpdateAble Then
		ivw_ParentWindow.ivb_Valida_Salva = True
	End If
End If
end event

event dw_2::getfocus;//OverRide
end event

type pb_1 from picturebutton within w_ge346_manutencao_produto_promocao
integer x = 1947
integer y = 68
integer width = 128
integer height = 104
integer taborder = 20
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string picturename = "S:\Sistemas_PB12\Comuns\Figuras\question_1.png"
alignment htextalign = left!
end type

event clicked;Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Sem o produto, ser$$HEX1$$e300$$ENDHEX$$o listados todos os produtos marcados para retirar do c$$HEX1$$e100$$ENDHEX$$lculo do EB ou que tiveram m$$HEX1$$ed00$$ENDHEX$$nimo de promo$$HEX2$$e700e300$$ENDHEX$$o cadastrado.")
end event

type cb_1 from commandbutton within w_ge346_manutencao_produto_promocao
integer x = 2971
integer y = 84
integer width = 594
integer height = 112
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Atualizar via Planilha"
end type

event clicked;String ls_Retorno

OpenWithParm(w_ge346_atualizacao_via_planilha, "")

ls_Retorno = Message.StringParm

If ls_Retorno = "OK" Then
	dw_2.Event ue_Retrieve()
End If
end event

