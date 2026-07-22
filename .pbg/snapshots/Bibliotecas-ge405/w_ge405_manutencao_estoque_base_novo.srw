HA$PBExportHeader$w_ge405_manutencao_estoque_base_novo.srw
forward
global type w_ge405_manutencao_estoque_base_novo from dc_w_sheet
end type
type tab_1 from tab within w_ge405_manutencao_estoque_base_novo
end type
type tabpage_1 from userobject within tab_1
end type
type gb_2 from groupbox within tabpage_1
end type
type gb_1 from groupbox within tabpage_1
end type
type dw_1 from dc_uo_dw_base within tabpage_1
end type
type dw_2 from dc_uo_dw_base within tabpage_1
end type
type tabpage_1 from userobject within tab_1
gb_2 gb_2
gb_1 gb_1
dw_1 dw_1
dw_2 dw_2
end type
type tabpage_2 from userobject within tab_1
end type
type dw_6 from dc_uo_dw_base within tabpage_2
end type
type cb_atualizar_filiais from commandbutton within tabpage_2
end type
type cb_filiais from commandbutton within tabpage_2
end type
type gb_5 from groupbox within tabpage_2
end type
type gb_4 from groupbox within tabpage_2
end type
type gb_3 from groupbox within tabpage_2
end type
type dw_3 from dc_uo_dw_base within tabpage_2
end type
type dw_4 from dc_uo_dw_base within tabpage_2
end type
type cb_atualizar_similar from commandbutton within tabpage_2
end type
type dw_5 from dc_uo_dw_base within tabpage_2
end type
type cb_atualizar_perfil from commandbutton within tabpage_2
end type
type tabpage_2 from userobject within tab_1
dw_6 dw_6
cb_atualizar_filiais cb_atualizar_filiais
cb_filiais cb_filiais
gb_5 gb_5
gb_4 gb_4
gb_3 gb_3
dw_3 dw_3
dw_4 dw_4
cb_atualizar_similar cb_atualizar_similar
dw_5 dw_5
cb_atualizar_perfil cb_atualizar_perfil
end type
type tab_1 from tab within w_ge405_manutencao_estoque_base_novo
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type
end forward

global type w_ge405_manutencao_estoque_base_novo from dc_w_sheet
integer width = 3639
integer height = 1888
string title = "GE405 - Manuten$$HEX2$$e700e300$$ENDHEX$$o do Estoque Base de Produtos Novos"
event ue_retrieve ( )
tab_1 tab_1
end type
global w_ge405_manutencao_estoque_base_novo w_ge405_manutencao_estoque_base_novo

type variables
uo_produto ivo_produto
uo_produto ivo_similar

Boolean ivb_Selecao_conjunto = False
Boolean ib_Atualiza_Dados = False

Long ivl_linhas

String ivs_Conjunto_Filiais
String ivs_manipulacao = 'N'
String	is_Filias_Nao_Atualizadas
String is_Grupo_Prd
end variables

forward prototypes
public subroutine wf_atualiza_estoque_perfil (long al_perfil, long al_estoque_base)
public subroutine wf_atualiza_produto_filial (long al_produto, long al_estoque_base, long al_filial)
public function boolean wf_dados_produto_novo (long al_produto)
public function boolean wf_atualiza_totais ()
end prototypes

event ue_retrieve();If Tab_1.SelectedTab = 1 Then
	Tab_1.TabPage_1.dw_2.Event ue_Retrieve()
Else
	Tab_1.TabPage_2.dw_4.Event ue_Retrieve()
End If
end event

public subroutine wf_atualiza_estoque_perfil (long al_perfil, long al_estoque_base);Long lvl_Total, &
     lvl_Linha, &
	  lvl_Perfil,&
	  lvl_Produto,&
	  lvl_Filial
	  
String	ls_Parametro

lvl_Total			= Tab_1.TabPage_2.dw_4.RowCount()
lvl_Produto		= Tab_1.TabPage_2.dw_3.Object.cd_produto[1]

If lvl_Total > 0 Then
	For lvl_Linha = 1 To lvl_Total
		lvl_Perfil = Tab_1.TabPage_2.dw_4.Object.cd_porte[lvl_Linha]
		lvl_Filial = Tab_1.TabPage_2.dw_4.Object.cd_filial[lvl_Linha]
		
		If lvl_Perfil = al_Perfil Then
			If Not gf_parametro_filial_vacina(lvl_Filial, lvl_Produto ) Then Return
			
			 //Verifica se vai ser atulizado no SAP
			If Not gf_filial_administrada_sap(lvl_Filial, Ref ls_Parametro) Then
				Return
			End If
			
			If ls_Parametro = "S" And is_Grupo_Prd <> "5" Then				
				If is_Filias_Nao_Atualizadas = "" Then
					is_Filias_Nao_Atualizadas	= String(lvl_Filial)
				Else
					is_Filias_Nao_Atualizadas	+= ", "+String(lvl_Filial)
				End If
			Else
				Tab_1.TabPage_2.dw_4.Object.Qt_Estoque_Base_Inicial[lvl_Linha] = al_Estoque_Base
			End If
			
		End If		
	Next	
End If
end subroutine

public subroutine wf_atualiza_produto_filial (long al_produto, long al_estoque_base, long al_filial);Long lvl_Total, &
     lvl_Linha,&
	 lvl_Produto,&
	 lvl_Filial,&
	 lvl_Qtd
	  
/// Conta Registros na DW4
lvl_Total = Tab_1.TabPage_2.dw_4.RowCount()

If lvl_Total > 0 Then
	For lvl_Linha = 1 To lvl_Total

		//  Busca dados da DW4 para Comparar com Excel
		lvl_Produto = Tab_1.TabPage_2.dw_4.Object.cd_produto[lvl_Linha]
         lvl_Filial		 = Tab_1.TabPage_2.dw_4.Object.cd_filial[lvl_Linha]

		// Compara e atualiza caso igualdade
		If lvl_Produto = al_Produto  and lvl_Filial = al_Filial Then
			Tab_1.TabPage_2.dw_4.Object.Qt_Estoque_Base_Inicial[lvl_Linha] = al_Estoque_Base
		End If			
	Next	
End If
end subroutine

public function boolean wf_dados_produto_novo (long al_produto);DateTime ldh_Eb_Inicial
DateTime ldh_Atual

String ls_Erro

Tab_1.TabPage_2.dw_3.AcceptText()

ib_Atualiza_Dados = False

ldh_Atual	 = gvo_Parametro.of_Dh_Movimentacao()

Select dh_estoque_base_inicial
	Into :ldh_Eb_Inicial
From produto_central
Where cd_produto = :al_Produto
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		If Not IsNull(ldh_Eb_Inicial) Then
			If ldh_Eb_Inicial <> ldh_Atual Then
				Return True
			End If
		End If
		
	Case 100
		Return True
		
	Case -1
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao consultar o produto na tabela PRODUTO_CENTRAL.", StopSign!)
		Return False
End Choose

ib_Atualiza_Dados = True

Update produto_central
	Set	dh_estoque_base_inicial = :ldh_Atual,
			nr_matric_estoque_base_inicial = :gvo_Aplicacao.ivo_Seguranca.Nr_Matricula
Where cd_produto = :al_Produto
Using SqlCa;
			
If SqlCa.SqlCode = -1 Then
	ls_Erro = SqlCa.SqlErrText
	SqlCa.of_Rollback();
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao atualizar o estoque do produto " + String(al_Produto) + ". " + ls_Erro, StopSign!)
	Return False
End If

Return True
end function

public function boolean wf_atualiza_totais ();Long ll_Qtd_Filiais
Long ll_Tot_Eb
Long ll_Produto

String ls_Erro

Tab_1.TabPage_2.dw_3.AcceptText()

ll_Produto = Tab_1.TabPage_2.dw_3.Object.Cd_Produto[1]

Select coalesce(count(cd_filial), 0), coalesce(sum(qt_estoque_base_inicial), 0)
	Into :ll_Qtd_Filiais, :ll_Tot_Eb
From resumo_reposicao_estoque
Where cd_produto = :ll_Produto
	And qt_estoque_base_inicial > 0
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao consultar os totais de estoque base do produto.")
	Return False
End If

Update produto_central
	Set	qt_filial_estoque_base_inicial = :ll_Qtd_Filiais,
			qt_estoque_base_inicial = :ll_Tot_Eb
Where cd_produto = :ll_Produto
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	ls_Erro = SqlCa.SqlErrText
	SqlCa.of_RollBack();	
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Erro ao atualizar as informa$$HEX2$$e700f500$$ENDHEX$$es de estoque base do produto." + ls_Erro, StopSign!)
	Return False
End If

SqlCa.of_Commit();

Return True
end function

on w_ge405_manutencao_estoque_base_novo.create
int iCurrent
call super::create
this.tab_1=create tab_1
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.tab_1
end on

on w_ge405_manutencao_estoque_base_novo.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.tab_1)
end on

event ue_postopen;call super::ue_postopen;dc_uo_dw_Base lvo_DW[]
lvo_DW = {Tab_1.TabPage_2.dw_4}
wf_SetUpdate_DW(lvo_DW)

Tab_1.TabPage_1.dw_1.Event ue_AddRow()
Tab_1.TabPage_2.dw_3.Event ue_AddRow()

Tab_1.TabPage_1.dw_1.Object.Dt_Inicio [1] = RelativeDate(Today(), -10)
Tab_1.TabPage_1.dw_1.Object.Dt_Termino[1] = Today()

Tab_1.TabPage_1.dw_1.ivm_Menu = This.ivm_Menu
Tab_1.TabPage_1.dw_2.ivm_Menu = This.ivm_Menu
Tab_1.TabPage_2.dw_3.ivm_Menu = This.ivm_Menu
Tab_1.TabPage_2.dw_4.ivm_Menu = This.ivm_Menu

Tab_1.TabPage_1.dw_1.SetFocus()

Tab_1.TabPage_2.dw_5.Retrieve()
end event

event open;call super::open;ivo_Produto = Create uo_Produto
ivo_Similar = Create uo_Produto
end event

event close;call super::close;Destroy(ivo_Produto)
Destroy(ivo_Similar)
end event

event ue_cancel;call super::ue_cancel;Tab_1.TabPage_2.dw_4.Event ue_Retrieve()
end event

event ue_save;call super::ue_save;If AncestorReturnValue = 1 Then
	If ib_Atualiza_Dados Then
		If Not wf_Atualiza_Totais() Then Return -1
	End If
End If

Return AncestorReturnValue
end event

type dw_visual from dc_w_sheet`dw_visual within w_ge405_manutencao_estoque_base_novo
end type

type gb_aux_visual from dc_w_sheet`gb_aux_visual within w_ge405_manutencao_estoque_base_novo
end type

type tab_1 from tab within w_ge405_manutencao_estoque_base_novo
integer x = 5
integer y = 4
integer width = 3566
integer height = 1676
integer taborder = 10
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long backcolor = 67108864
boolean raggedright = true
integer selectedtab = 1
tabpage_1 tabpage_1
tabpage_2 tabpage_2
end type

on tab_1.create
this.tabpage_1=create tabpage_1
this.tabpage_2=create tabpage_2
this.Control[]={this.tabpage_1,&
this.tabpage_2}
end on

on tab_1.destroy
destroy(this.tabpage_1)
destroy(this.tabpage_2)
end on

event selectionchanging;Long lvl_Linha, &
     lvl_Produto, &
	  lvl_Produto_Anterior, &
	  lvl_Nulo
	  
String lvs_Descricao

Decimal lvdc_Fator

DateTime lvdh_Termino_Avaliacao, &
         lvdh_Parametro

ivb_Selecao_conjunto = False

If NewIndex = 2 Then
	lvl_Linha = Tab_1.TabPage_1.dw_2.GetRow()
		
	If lvl_Linha > 0 Then		
		lvl_Produto            		= Tab_1.TabPage_1.dw_2.Object.Cd_Produto          			[lvl_Linha]
		lvs_Descricao          		= Tab_1.TabPage_1.dw_2.Object.Descricao_Produto   		[lvl_Linha]		
		lvdc_Fator             		= Tab_1.TabPage_1.dw_2.Object.Vl_Fator_Conversao  		[lvl_Linha]		
		lvdh_Termino_Avaliacao 	= Tab_1.TabPage_1.dw_2.Object.Dh_Termino_Avaliacao	[lvl_Linha]
		lvdh_Parametro         	= Tab_1.TabPage_1.dw_2.Object.Dh_Movimentacao     		[lvl_Linha]
		is_Grupo_Prd				= MidA(Tab_1.TabPage_1.dw_2.Object.Cd_Subcategoria	[lvl_Linha], 1, 1)
		
		If lvdh_Parametro <= lvdh_Termino_Avaliacao Then		
			lvl_Produto_Anterior = Tab_1.TabPage_2.dw_3.Object.Cd_Produto[1]
			
			If IsNull(lvl_Produto_Anterior) Then lvl_Produto_Anterior = 0
			
			// Se selecionou um produto diferente do selecionado anteriormente
			// Limpa o produto similar
			If lvl_Produto <> lvl_Produto_Anterior Then
				SetNull(ivo_Similar.Cd_Produto)
				ivo_Similar.ivs_Descricao_Apresentacao_Venda = ""
				
				Tab_1.TabPage_2.dw_3.Object.Cd_Produto_Similar[1] = ivo_Similar.Cd_Produto
				Tab_1.TabPage_2.dw_3.Object.De_Produto_Similar[1] = ivo_Similar.ivs_Descricao_Apresentacao_Venda
			End If
			
			Tab_1.TabPage_2.dw_3.Object.Cd_Produto        [1] = lvl_Produto		
			Tab_1.TabPage_2.dw_3.Object.De_Produto        [1] = lvs_Descricao
			Tab_1.TabPage_2.dw_3.Object.Vl_Fator_Conversao[1] = lvdc_Fator
			
			Tab_1.TabPage_2.dw_4.Event ue_Retrieve()
		Else
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O per$$HEX1$$ed00$$ENDHEX$$odo de avalia$$HEX2$$e700e300$$ENDHEX$$o do produto selecionado j$$HEX1$$e100$$ENDHEX$$ est$$HEX1$$e100$$ENDHEX$$ terminado.~r" + &
			                      "N$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ permitida a altera$$HEX2$$e700e300$$ENDHEX$$o do estoque base.", StopSign!)
			Return 1
		End If
	Else
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Selecione um produto na lista para visualizar os detalhes.", StopSign!)
		Return 1
	End If
Else
	If wf_Valida_Salva() < 0 Then
		Return 1
	End If	
End If
end event

event selectionchanged;Choose Case NewIndex
	Case 1
		Tab_1.Width = 2600
		Tab_1.Height = 1700
		ivm_Menu.mf_Recuperar(True)
		ivm_Menu.mf_Confirmar(False)
		ivm_Menu.mf_Cancelar(False)
		
	Case 2
		Tab_1.Width = 3600
		Tab_1.Height = 1700
		ivm_Menu.mf_Recuperar(False)
End Choose

Parent.Width  = This.Width + 45
Parent.Height = This.Height + 110
end event

type tabpage_1 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3529
integer height = 1560
long backcolor = 79741120
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
gb_2 gb_2
gb_1 gb_1
dw_1 dw_1
dw_2 dw_2
end type

on tabpage_1.create
this.gb_2=create gb_2
this.gb_1=create gb_1
this.dw_1=create dw_1
this.dw_2=create dw_2
this.Control[]={this.gb_2,&
this.gb_1,&
this.dw_1,&
this.dw_2}
end on

on tabpage_1.destroy
destroy(this.gb_2)
destroy(this.gb_1)
destroy(this.dw_1)
destroy(this.dw_2)
end on

type gb_2 from groupbox within tabpage_1
integer x = 9
integer y = 272
integer width = 2505
integer height = 1268
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista dos Produtos Novos"
borderstyle borderstyle = styleraised!
end type

type gb_1 from groupbox within tabpage_1
integer x = 9
integer y = 8
integer width = 1797
integer height = 252
integer taborder = 20
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Par$$HEX1$$e200$$ENDHEX$$metros"
borderstyle borderstyle = styleraised!
end type

type dw_1 from dc_uo_dw_base within tabpage_1
integer x = 32
integer y = 64
integer width = 1760
integer height = 184
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge405_selecao"
end type

event itemchanged;call super::itemchanged;If dwo.Name = "de_produto" Then
	If Trim(Data) <> "" Then
		If Data <> ivo_Produto.ivs_Descricao_Apresentacao_Venda Then
			Return 1
		End If
	Else
		SetNull(ivo_Produto.Cd_Produto)
		ivo_Produto.ivs_Descricao_Apresentacao_Venda = ""
		
		This.Object.Cd_Produto[1] = ivo_Produto.Cd_Produto
		This.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
	End If
End If
end event

event losefocus;If IsValid(ivo_Produto) Then
	This.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
End If
end event

event ue_key;If Key = KeyEnter! Then
	If This.GetColumnName() = "de_produto" Then
		ivo_Produto.of_Localiza_Produto(This.GetText())
		
		If ivo_Produto.Localizado Then
			This.Object.Cd_Produto[1] = ivo_Produto.Cd_Produto
			This.Object.De_Produto[1] = ivo_Produto.ivs_Descricao_Apresentacao_Venda
		End If
	End If
End If
end event

event editchanged;call super::editchanged;dw_2.Reset()
end event

event constructor;call super::constructor;This.of_SetColSelection(True)
end event

type dw_2 from dc_uo_dw_base within tabpage_1
integer x = 32
integer y = 324
integer width = 2459
integer height = 1196
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge405_lista"
boolean vscrollbar = true
end type

event ue_preretrieve;call super::ue_preretrieve;Long lvl_Produto

Date lvdt_Inicio, &
     lvdt_Termino
	  
dw_1.AcceptText()

lvl_Produto  = dw_1.Object.Cd_Produto[1]
lvdt_Inicio  = dw_1.Object.Dt_Inicio [1]
lvdt_Termino = dw_1.Object.Dt_Termino[1]

If Not IsNull(lvl_Produto) and lvl_Produto <> 0 Then
	This.of_AppendWhere("cd_produto = " + String(lvl_Produto))
Else
	This.of_AppendWhere("dh_inclusao_produto between '" + String(lvdt_Inicio, "yyyy/mm/dd") + "' and '" + String(lvdt_Termino, "yyyy/mm/dd") + "'")
End If

Return 1
end event

event ue_postretrieve;If pl_Linhas > 0 Then
	This.ivo_Controle_Menu.of_SalvarComo(True)
	This.SetFocus()
Else
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Nenhum produto foi inclu$$HEX1$$ed00$$ENDHEX$$do neste per$$HEX1$$ed00$$ENDHEX$$odo.", Information!)
	This.ivo_Controle_Menu.of_SalvarComo(False)
End If

Return pl_Linhas
end event

type tabpage_2 from userobject within tab_1
integer x = 18
integer y = 100
integer width = 3529
integer height = 1560
long backcolor = 79741120
string text = "Detalhes"
long tabtextcolor = 33554432
long tabbackcolor = 79741120
long picturemaskcolor = 536870912
dw_6 dw_6
cb_atualizar_filiais cb_atualizar_filiais
cb_filiais cb_filiais
gb_5 gb_5
gb_4 gb_4
gb_3 gb_3
dw_3 dw_3
dw_4 dw_4
cb_atualizar_similar cb_atualizar_similar
dw_5 dw_5
cb_atualizar_perfil cb_atualizar_perfil
end type

on tabpage_2.create
this.dw_6=create dw_6
this.cb_atualizar_filiais=create cb_atualizar_filiais
this.cb_filiais=create cb_filiais
this.gb_5=create gb_5
this.gb_4=create gb_4
this.gb_3=create gb_3
this.dw_3=create dw_3
this.dw_4=create dw_4
this.cb_atualizar_similar=create cb_atualizar_similar
this.dw_5=create dw_5
this.cb_atualizar_perfil=create cb_atualizar_perfil
this.Control[]={this.dw_6,&
this.cb_atualizar_filiais,&
this.cb_filiais,&
this.gb_5,&
this.gb_4,&
this.gb_3,&
this.dw_3,&
this.dw_4,&
this.cb_atualizar_similar,&
this.dw_5,&
this.cb_atualizar_perfil}
end on

on tabpage_2.destroy
destroy(this.dw_6)
destroy(this.cb_atualizar_filiais)
destroy(this.cb_filiais)
destroy(this.gb_5)
destroy(this.gb_4)
destroy(this.gb_3)
destroy(this.dw_3)
destroy(this.dw_4)
destroy(this.cb_atualizar_similar)
destroy(this.dw_5)
destroy(this.cb_atualizar_perfil)
end on

type dw_6 from dc_uo_dw_base within tabpage_2
boolean visible = false
integer x = 1810
integer y = 448
integer width = 773
integer height = 68
integer taborder = 20
string dataobject = "dw_ge405_selecao_arquivo"
end type

event constructor;call super::constructor;This.of_SetRowSelection()
end event

type cb_atualizar_filiais from commandbutton within tabpage_2
integer x = 18
integer y = 1436
integer width = 741
integer height = 100
integer taborder = 40
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Atualizar Filiais via Excel"
end type

event clicked;Integer lvi_Arquivo

long 	ll_Linhas,&
		ll_Linha,&
		ll_Produto,&
		ll_Estoque_Inicial,&
		ll_Filial
					
String 	lvs_Nome_Arquivo,&
			lvs_Msg,&
			lvs_Arquivo,&
			lvs_Path,&
			ls_Parametro
		
dw_6.accepttext( )
dw_4.SetRedraw(False)

is_Filias_Nao_Atualizadas = ""

// Mensagem para Orienta$$HEX2$$e700e300$$ENDHEX$$o: Layout
MessageBox( "Aten$$HEX2$$e700e300$$ENDHEX$$o","Para atualizar os dados das Filiais via Excel os dados devem estar da seguinte forma:~r~r" + &
                     	"Coluna A = *Filial~r" + &
                     	"Coluna B = *Codigo do Produto~r" +&
                     	"Coluna C = *Quantidade")

lvi_Arquivo = GetFileOpenName("Seleciona o arquivo", + lvs_Path, lvs_Nome_Arquivo, "XLSX", "Excel 2007 (*.XLSX),*.XLSX, Excel (*.XLS), *.XLS")

If lvi_Arquivo <> 1 Then Return
ivl_Linhas = 0
dw_6.Object.nm_arquivo[1] = lvs_Path

lvs_Msg = "Importar a planilha com os dados de Estoque Inicial do Produto Novo ?"
If Messagebox("Aten$$HEX2$$e700e300$$ENDHEX$$o", lvs_Msg, Question!, OkCancel!, 2) = 2 Then Return

dw_6.AcceptText()

lvs_Arquivo = dw_6.Object.nm_arquivo [1]

dc_uo_excel lvo_Excel
lvo_Excel = Create dc_uo_excel
Open(w_Aguarde)

// Inicio Leitura Arquivo :  Refer$$HEX1$$ea00$$ENDHEX$$ncia o arquivo 
If ( lvo_Excel.uo_Referencia_Objeto_Excel(lvs_Arquivo) ) Then
	// Coluna de Refer$$HEX1$$ea00$$ENDHEX$$ncia
	ll_Linhas = lvo_Excel.uo_Verifica_Tamanho_Arquivo("A") 
	
	If ll_Linhas > 0 Then
		w_Aguarde.uo_Progress.of_SetMax(ll_Linhas)
	
		For ll_Linha = 1 To ll_Linhas
								
			// Lendo os campos do Excel
			ll_Filial					=  lvo_Excel.uo_Lendo_Dados(ll_Linha, "A")	
			ll_Produto	 			=  lvo_Excel.uo_Lendo_Dados(ll_Linha, "B")
 			ll_Estoque_Inicial		=  lvo_Excel.uo_Lendo_Dados(ll_Linha, "C")	
			 			 
			 //Verifica se vai ser atulizado no SAP
			If Not gf_filial_administrada_sap(ll_Filial, Ref ls_Parametro) Then
				Return 1
			End If
			
			If ls_Parametro = "S" And is_Grupo_Prd <> "5" Then
				If is_Filias_Nao_Atualizadas = "" Then
					is_Filias_Nao_Atualizadas	= String(ll_Filial)
				Else
					is_Filias_Nao_Atualizadas	+= ", "+String(ll_Filial)
				End If
				
			Else

				// Valida$$HEX2$$e700f500$$ENDHEX$$es B$$HEX1$$e100$$ENDHEX$$sicas
				If IsNull(ll_Produto)  or  IsNull(ll_Filial)  or IsNull(ll_Estoque_Inicial) Then 
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Filial/Produto/Estoque Inicial est$$HEX1$$e300$$ENDHEX$$o invalidos.~rLinha do Arquivo: " + String(ll_Linha) + "~rFilial:" + String(ll_Filial)+ "~rProduto: " + String(ll_Produto))
					Exit
				End IF		
				
				// Valida$$HEX2$$e700e300$$ENDHEX$$o Filial/Produto Vacina Liberada para Loja 
				If Not gf_parametro_filial_vacina(ll_Filial, ll_Produto) Then 
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Filial/Produto s$$HEX1$$e300$$ENDHEX$$o Vacinas. N$$HEX1$$e300$$ENDHEX$$o liberado para esta Filial.~rLinha do Arquivo: " + String(ll_Linha) + "~rFilial:" + String(ll_Filial)+ "~rProduto: " + String(ll_Produto))		
					Exit
				End If 
												
				// Acessa Fun$$HEX2$$e700e300$$ENDHEX$$o
				 wf_atualiza_produto_filial(ll_Produto,ll_Estoque_Inicial,ll_Filial) 
			End If
				
			w_Aguarde.uo_Progress.of_SetProgress(ll_Linha)			
		Next
	End If    /// Final Linha
	
	If is_Filias_Nao_Atualizadas <> "" Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produto selecionado N$$HEX1$$c300$$ENDHEX$$O $$HEX1$$e900$$ENDHEX$$ ALMOXARIFADO." + &
									"~rAs seguintes filiais devem ser alteradas pelo SAP: "+is_Filias_Nao_Atualizadas+" ~rAs demais foram atualizadas com sucesso.")
		is_Filias_Nao_Atualizadas = ''
	End If

End If //Final Excel

Close(w_Aguarde)
dw_6.Retrieve()
Destroy(lvo_Excel)

dw_4.SetFocus()
dw_4.SetRedraw(True)
SetPointer(Arrow!)
	
ivm_Menu.mf_Confirmar(True)
ivm_Menu.mf_Cancelar(True)
ivb_Valida_Salva = True
end event

type cb_filiais from commandbutton within tabpage_2
integer x = 2624
integer y = 444
integer width = 882
integer height = 104
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Sele$$HEX2$$e700e300$$ENDHEX$$o Personalizada de Filiais"
end type

event clicked;Long	lvl_Lojas

String lvs_Null

SetNull(lvs_Null)
ivs_Conjunto_filiais = lvs_Null

uo_ge216_filiais lvo_filiais
lvo_filiais = Create uo_ge216_filiais

OpenWithParm(w_ge216_selecao_filiais, lvo_filiais)

lvl_Lojas = Message.DoubleParm

If lvl_Lojas > 0 Then
	
	tab_1.TabPage_2.dw_4.Reset()
	//dw_4.Event ue_AddRow()
	
	ivs_Conjunto_filiais = lvo_filiais.ivs_Filiais
	
	ivb_Selecao_conjunto = True
	
	tab_1.TabPage_2.dw_4.Event ue_Recuperar()		
		
End If

Destroy(lvo_filiais)
end event

type gb_5 from groupbox within tabpage_2
integer x = 1815
integer y = 8
integer width = 1696
integer height = 420
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Lista de Porte de Loja"
borderstyle borderstyle = styleraised!
end type

type gb_4 from groupbox within tabpage_2
integer x = 14
integer y = 544
integer width = 3497
integer height = 876
integer taborder = 40
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Estoque Base do Produto Novo"
borderstyle borderstyle = styleraised!
end type

type gb_3 from groupbox within tabpage_2
integer x = 14
integer y = 8
integer width = 1774
integer height = 524
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Produto Similar"
borderstyle borderstyle = styleraised!
end type

type dw_3 from dc_uo_dw_base within tabpage_2
integer x = 37
integer y = 84
integer width = 1737
integer height = 424
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge405_detalhe_1"
end type

event itemfocuschanged;This.SelectText(1, 100)
end event

event itemchanged;call super::itemchanged;If dwo.Name = "de_produto_similar" Then
	If Trim(Data) <> "" Then
		If Data <> ivo_Similar.ivs_Descricao_Apresentacao_Venda Then
			Return 1
		End If
	Else
		SetNull(ivo_Similar.Cd_Produto)
		ivo_Similar.ivs_Descricao_Apresentacao_Venda = ""
		
		This.Object.Cd_Produto_Similar[1] = ivo_Similar.Cd_Produto
		This.Object.De_Produto_Similar[1] = ivo_Similar.ivs_Descricao_Apresentacao_Venda
	End If
End If

If dwo.Name = "id_manipulacao" Then
	ivs_manipulacao = data
	Tab_1.TabPage_2.dw_4.Event ue_Retrieve()
End If
end event

event losefocus;If IsValid(ivo_Similar) Then
	This.Object.De_Produto_Similar[1] = ivo_Similar.ivs_Descricao_Apresentacao_Venda
End If
end event

event ue_key;If Key = KeyEnter! Then
	If This.GetColumnName() = "de_produto_similar" Then
		ivo_Similar.of_Localiza_Produto(This.GetText())
		
		If ivo_Similar.Localizado Then
			This.Object.Cd_Produto_Similar[1] = ivo_Similar.Cd_Produto
			This.Object.De_Produto_Similar[1] = ivo_Similar.ivs_Descricao_Apresentacao_Venda
		End If
	End If
End If
end event

event constructor;call super::constructor;This.of_SetColSelection(True)
end event

type dw_4 from dc_uo_dw_base within tabpage_2
integer x = 37
integer y = 596
integer width = 3451
integer height = 804
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge405_detalhe_2"
boolean vscrollbar = true
end type

event ue_recuperar;// Override

Long lvl_Produto

String ls_Manipulacao, lvs_Sql

dw_3.AcceptText()

lvl_Produto 		= dw_3.Object.Cd_Produto		[1]
ls_Manipulacao	= dw_3.Object.id_manipulacao	[1]

// of_appendwhere_subquery

If ivb_Selecao_Conjunto Then
	
	of_restoreoriginalsql()
	
	If Not IsNull(ivs_Conjunto_Filiais) Then
		This.of_AppendWhere("r.cd_filial in (" + ivs_Conjunto_Filiais + ")" )
	End If
End If

If ivs_manipulacao = 'N' Then
	lvs_Sql = "r.cd_filial in (select cd_filial from parametro_loja where cd_parametro = 'ID_REDE_FILIAL' " +&
			  "and vl_parametro not in ('MP', 'PF') )"
	
	This.of_AppendWhere(lvs_Sql)
End If

Return This.Retrieve(lvl_Produto)
end event

event ue_postretrieve;ib_Atualiza_Dados = False

If pl_Linhas > 0 Then	
	This.SetFocus()	
End If

Return pl_Linhas
end event

event itemfocuschanged;This.SelectText(1, 100)
end event

event editchanged;call super::editchanged;ivm_Menu.mf_Confirmar(True)
ivm_Menu.mf_Cancelar(True)


Long lvl_Filial,&
	   lvl_Produto,&
	   lvl_Qtd	
		
Long	ll_Filial, ll_Qtde

String	ls_Parametro

ll_Filial	= This.Object.cd_filial	[row]
ll_Qtde	= This.Object.qt_estoque_base_inicial[row]

//Verifica se vai ser atulizado no SAP
If Not gf_filial_administrada_sap(ll_Filial, Ref ls_Parametro) Then
	Return 1
End If

If ls_Parametro = "S" And is_Grupo_Prd <> "5" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Para a filial " + String(ll_Filial) + " $$HEX1$$e900$$ENDHEX$$ permitida apenas altera$$HEX2$$e700e300$$ENDHEX$$o de ALMOXARIFADO." + &
								"~rPara alterar demais grupos de produto para a filial utilize o SAP.", Exclamation!)
	This.Object.qt_estoque_base_inicial[row] = ll_Qtde
	Return 1
End If

Choose Case dwo.Name
	Case	"qt_estoque_base_inicial"
			// Adicionado para Bloqueio de Movimento de Vacinas
			lvl_Filial = This.Object.cd_filial [Row]
			lvl_Produto = This.Object.cd_produto[Row]			
			lvl_Qtd = Long(Data)
			
			If lvl_Qtd>0 Then 				
				If Not gf_parametro_filial_vacina(lvl_Filial, lvl_Produto) Then 
					lvl_Qtd = 0 
					This.Object.qt_estoque_base_inicial[Row] = lvl_Qtd
					ivm_Menu.mf_Confirmar(False)
					Return 1			
				End If 
			End If 		
End Choose
end event

event itemchanged;call super::itemchanged;Long	ll_Filial

String	ls_Parametro

ll_Filial	= This.Object.cd_filial	[row]

//Verifica se vai ser atulizado no SAP
If Not gf_filial_administrada_sap(ll_Filial, Ref ls_Parametro) Then
	Return 2
End If

If ls_Parametro = "S" And is_Grupo_Prd <> "5" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Para a filial " + String(ll_Filial) + " $$HEX1$$e900$$ENDHEX$$ permitida apenas altera$$HEX2$$e700e300$$ENDHEX$$o de ALMOXARIFADO." + &
								"~rPara alterar demais grupos de produto para a filial utilize o SAP.", Exclamation!)
	Return 2
End If 
 
ivm_Menu.mf_Confirmar(True)
ivm_Menu.mf_Cancelar(True)
end event

event ue_preupdate;call super::ue_preupdate;Boolean lb_Alteracao = False

DateTime lvdh_ServerDate

Long	lvl_Total, &
		lvl_Linha, &
		lvl_Estoque_Inicial, &
		lvl_Estoque_Base, &
		lvl_Fator,&
		lvl_Filial

		
dw_3.AcceptText()
This.AcceptText()
	  
lvdh_ServerDate = gf_GetServerDate()
	  
lvl_Fator = dw_3.Object.Vl_Fator_Conversao[1]

lvl_Total = This.RowCount()

For lvl_Linha = 1 To lvl_Total
	lvl_Estoque_Inicial 	= This.Object.Qt_Estoque_Base_Inicial	[lvl_Linha]
	lvl_Estoque_Base    	= This.Object.Qt_Estoque_Base        		[lvl_Linha]
	lvl_Filial					= This.Object.cd_filial	[lvl_Linha]
	
	
	If Mod(lvl_Estoque_Inicial, lvl_Fator) <> 0 Then
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O estoque base deve ser m$$HEX1$$fa00$$ENDHEX$$ltiplo do fator de convers$$HEX1$$e300$$ENDHEX$$o utilizado no estoque central.", StopSign!)
		This.Event ue_Pos(lvl_Linha, "qt_estoque_base_inicial")
		Return -1
	End If
	
	If lvl_Estoque_Inicial > lvl_Estoque_Base Then
		This.Object.Qt_Estoque_Base      	 	[lvl_Linha] = lvl_Estoque_Inicial
		This.Object.Dh_Alteracao          		[lvl_Linha] = lvdh_ServerDate
		This.Object.Nr_Matricula_Alteracao	[lvl_Linha] = gvo_Aplicacao.ivo_Seguranca.Nr_Matricula
		This.Object.Id_Alteracao          		[lvl_Linha] = "M"
		This.Object.De_Motivo_Alteracao		[lvl_Linha] = "PRODUTO NOVO"
		
		lb_Alteracao = True
	End If
Next

If lb_Alteracao Then
	If Not gf_parametro_filial_vacina(lvl_Filial, dw_3.Object.Cd_Produto[1] ) Then Return -1
	
	If Not wf_Dados_Produto_Novo(dw_3.Object.Cd_Produto[1]) Then Return -1
End If

Return 1
end event

event constructor;call super::constructor;This.of_SetRowSelection()
end event

type cb_atualizar_similar from commandbutton within tabpage_2
integer x = 1431
integer y = 1436
integer width = 1024
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Atualizar Baseado no Produto &Similar"
end type

event clicked;Long lvl_Produto, &
     lvl_Total, &
     lvl_Linha, &
	  lvl_Filial, &
	  lvl_Estoque_Base, &
	  lvl_Estoque_Novo

Decimal lvdc_Demanda, &
        lvdc_Estoque_Novo, &
		  lvdc_Estoque_Decimal

Integer lvi_Percentual

String lvs_Classe,&
		ls_Parametro
		
is_Filias_Nao_Atualizadas = ""		

lvl_Total = dw_4.RowCount()

If lvl_Total > 0 Then
	SetPointer(HourGlass!)
	dw_4.SetRedraw(False)	
	
	dw_3.AcceptText()
	
	lvl_Produto    		= dw_3.Object.Cd_Produto_Similar	[1]
	lvi_Percentual		= dw_3.Object.Pc_Saldo_Base     		[1]
	
	If Not IsNull(lvl_Produto) and lvl_Produto > 0 Then
		Open(w_Aguarde)
		w_Aguarde.Title = "Atualizando Dados do Produto Similar..."
		
		w_Aguarde.uo_Progress.of_SetMax(lvl_Total)
		
		For lvl_Linha = 1 To lvl_Total
			lvl_Filial = dw_4.Object.Cd_Filial[lvl_Linha]
			
			 //Verifica se vai ser atulizado no SAP
			If Not gf_filial_administrada_sap(lvl_Filial, Ref ls_Parametro) Then
				Return 1
			End If
			
			If ls_Parametro = "S" And is_Grupo_Prd <> "5" Then
				If is_Filias_Nao_Atualizadas = "" Then
					is_Filias_Nao_Atualizadas	= String(lvl_Filial)
				Else
					is_Filias_Nao_Atualizadas	+= ", "+String(lvl_Filial)
				End If
				
				Continue
			End If
			
			// Valida$$HEX2$$e700e300$$ENDHEX$$o Filial/Produto Vacina Liberada para Loja 
			If Not gf_parametro_filial_vacina(lvl_Filial, lvl_Produto) Then 
			   MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Filial/Produto s$$HEX1$$e300$$ENDHEX$$o Vacinas. N$$HEX1$$e300$$ENDHEX$$o liberado para esta Filial:"+String(lvl_Filial)+ "~rProduto: " + String(lvl_Produto))		
			   Exit
			End If 
			
			Select qt_demanda_diaria,
					 qt_estoque_base,
					 cd_classe_reposicao
			Into :lvdc_Demanda,
				  :lvl_Estoque_Base,
				  :lvs_Classe
		   From resumo_reposicao_estoque
			Where cd_filial  = :lvl_Filial
			  and cd_produto = :lvl_Produto
			Using SqlCa;
			
			Choose Case SqlCa.SqlCode
				Case 0
					dw_4.Object.Qt_Demanda_Similar     [lvl_Linha] = lvdc_Demanda
					dw_4.Object.Cd_Classe_Similar      [lvl_Linha] = lvs_Classe
					dw_4.Object.Qt_Estoque_Base_Similar[lvl_Linha] = lvl_Estoque_Base
					
					lvdc_Estoque_Novo = Round(lvl_Estoque_Base * (lvi_Percentual / 100), 2)
					
					lvl_Estoque_Novo     = Truncate(lvdc_Estoque_Novo, 0)
					lvdc_Estoque_Decimal = lvdc_Estoque_Novo - lvl_Estoque_Novo
					
					If lvdc_Estoque_Decimal >= 0.50 Then
						lvl_Estoque_Novo += 1
					End If
					
					dw_4.Object.Qt_Estoque_Base_Inicial[lvl_Linha] = lvl_Estoque_Novo
					
				Case 100
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produto similar n$$HEX1$$e300$$ENDHEX$$o localizado na filial '" + String(lvl_Filial) + "'.", StopSign!)
					
				Case -1
					SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Produto Similar na Filial '" + String(lvl_Filial) + "'")
			End Choose
			
			w_Aguarde.uo_Progress.of_SetProgress(lvl_Linha)
		Next
		
		Close(w_Aguarde)
		
		If is_Filias_Nao_Atualizadas <> "" Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produto selecionado N$$HEX1$$c300$$ENDHEX$$O $$HEX1$$e900$$ENDHEX$$ ALMOXARIFADO." + &
										"~rPara a altera$$HEX2$$e700e300$$ENDHEX$$o das filiais " +is_Filias_Nao_Atualizadas+ " deve ser utilizada o SAP.~rAs demais filiais formam atualizadas com sucesso.")
		End If
	End If
	
	dw_4.SetFocus()
	dw_4.SetRedraw(True)
	SetPointer(Arrow!)
	
	ivm_Menu.mf_Confirmar(True)
	ivm_Menu.mf_Cancelar(True)
	ivb_Valida_Salva = True
End If
end event

type dw_5 from dc_uo_dw_base within tabpage_2
integer x = 1838
integer y = 64
integer width = 1650
integer height = 348
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge405_detalhe_perfil_filial"
boolean vscrollbar = true
end type

event constructor;call super::constructor;This.of_SetRowSelection()
end event

type cb_atualizar_perfil from commandbutton within tabpage_2
integer x = 2482
integer y = 1436
integer width = 1024
integer height = 100
integer taborder = 40
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
string text = "Atualizar Filiais via Porte de Loja"
end type

event clicked;Long lvl_Contador, &
     lvl_Perfil, &
	  lvl_Estoque
	  
SetPointer(HourGlass!)

Open(w_Aguarde)
w_Aguarde.Title = "Atualizando Estoque Base por Porte de Loja..."

dw_5.AcceptText()

dw_4.SetRedraw(False)

is_Filias_Nao_Atualizadas	= ""

For lvl_Contador = 1 To dw_5.RowCount()
	lvl_Perfil  = dw_5.Object.cd_porte[lvl_Contador]
	lvl_Estoque = dw_5.Object.Qt_Estoque_Base [lvl_Contador]

	wf_Atualiza_Estoque_Perfil(lvl_Perfil, lvl_Estoque)
Next

If is_Filias_Nao_Atualizadas <> "" Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Produto selecionado N$$HEX1$$c300$$ENDHEX$$O $$HEX1$$e900$$ENDHEX$$ ALMOXARIFADO." + &
									"~rAs seguintes filiais devem ser alteradas pelo SAP: "+is_Filias_Nao_Atualizadas+" ~rAs demais foram atualizadas com sucesso. ")
	is_Filias_Nao_Atualizadas = ''
End If

dw_4.SetRedraw(True)
dw_4.SetFocus()

ivm_Menu.mf_Confirmar(True)
ivm_Menu.mf_Cancelar(True)
ivb_Valida_Salva = True

Close(w_Aguarde)
SetPointer(Arrow!)
end event

