HA$PBExportHeader$w_ge134_manutencao_minimo_promocao.srw
forward
global type w_ge134_manutencao_minimo_promocao from dc_w_2tab_consulta_selecao_lista_det
end type
type cb_minimo from commandbutton within tabpage_1
end type
type cb_gera_planilha from commandbutton within tabpage_1
end type
type dw_5 from dc_uo_dw_base within tabpage_1
end type
type gb_5 from groupbox within tabpage_2
end type
type gb_4 from groupbox within tabpage_2
end type
type dw_4 from dc_uo_dw_base within tabpage_2
end type
type dw_6 from dc_uo_dw_base within tabpage_2
end type
end forward

global type w_ge134_manutencao_minimo_promocao from dc_w_2tab_consulta_selecao_lista_det
integer width = 4201
integer height = 2236
string title = "GE134 - Manuten$$HEX2$$e700e300$$ENDHEX$$o de Estoque M$$HEX1$$ed00$$ENDHEX$$nimo de Produtos em Promo$$HEX2$$e700e300$$ENDHEX$$o"
boolean resizable = false
long backcolor = 80269524
end type
global w_ge134_manutencao_minimo_promocao w_ge134_manutencao_minimo_promocao

type variables
uo_promocao ivo_promocao

boolean ivb_salva = False
end variables

forward prototypes
public function boolean wf_atualiza_informacoes ()
public function boolean wf_exclui_produto_promocao (long pl_promocao, long pl_filial, long pl_produto)
public function boolean wf_atualiza_qtde_estoque_minimo ()
public function boolean wf_valida_informacoes ()
public function boolean wf_valida_fator_conversao ()
public function boolean wf_estoque_base_total (long al_produto, ref long al_estoque_base)
public function boolean wf_estoque_minimo_total (long al_promocao, long al_produto, ref long al_estoque_minimo)
public function boolean wf_estoque_atual (long al_produto, ref long al_estoque_matriz, ref long al_estoque_filiais)
public function boolean wf_meta_total (long al_promocao, long al_produto, ref long al_grupo, ref string as_descricao, ref long al_meta)
public function boolean wf_estoque_base_maior (long al_promocao, long al_produto, ref long al_estoque_base)
public function boolean wf_promocao_marketing (long al_promocao, ref long al_promocao_mkt)
public function boolean wf_verifica_promocao_sap (long pl_cd_promocao, ref boolean pb_promocao_sap, ref string ps_log)
end prototypes

public function boolean wf_atualiza_informacoes ();Boolean lvb_Sucesso = True

Integer lvi_Row

Long 	lvl_Promocao, &
		lvl_Filial, &
		lvl_Produto, &
		lvl_Estoque_Minimo, &
		lvl_Estoque_Minimo_Ant, &
		ll_Motivo, &
		ll_Achou
	  
Tab_1.TabPage_1.dw_1.AcceptText()
Tab_1.TabPage_1.dw_2.AcceptText()
Tab_1.TabPage_2.dw_3.AcceptText()
Tab_1.TabPage_2.dw_6.AcceptText()

lvl_Promocao = Tab_1.TabPage_1.dw_1.Object.Cd_Promocao[1]

ll_Motivo = Tab_1.TabPage_2.dw_6.Object.Cd_Motivo[1]

If ll_Motivo = 0 Then
	SetNull(ll_Motivo)
End If

For lvi_Row = 1 To Tab_1.TabPage_2.dw_3.RowCount()
	lvl_Produto        			= 	Tab_1.TabPage_2.dw_3.Object.Cd_Produto                					[lvi_Row]
	lvl_Filial         				= 	Tab_1.TabPage_2.dw_3.Object.Cd_Filial               						[lvi_Row]
	lvl_Estoque_Minimo		= 	Tab_1.TabPage_2.dw_3.Object.Qt_Estoque_Minimo_Promocao		[lvi_Row]
	lvl_Estoque_Minimo_Ant	=	Tab_1.TabPage_2.dw_3.Object.qt_estoque_minimo_promocao_ant	[lvi_Row]
	
	If lvl_Estoque_Minimo > 0 Then
		
		//S$$HEX1$$f300$$ENDHEX$$ obrigado a informar se a promo$$HEX2$$e700e300$$ENDHEX$$o for de Planograma
		If ivo_Promocao.ivs_Tipo = "P" Then
			If IsNull(ll_Motivo) Then
				If lvl_Estoque_Minimo <> lvl_Estoque_Minimo_Ant Then
					MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe o motivo de altera$$HEX2$$e700e300$$ENDHEX$$o.")
					Tab_1.TabPage_2.dw_6.Event ue_Pos(1, "cd_motivo")
					lvb_Sucesso = False
					Exit
				End If
			End If
		End If
		
		Select Count(*)
			Into: ll_Achou
		From promocao_sos_estoque_minimo
		Where cd_promocao_sos = :lvl_Promocao
			And cd_filial = :lvl_Filial
			And cd_produto = :lvl_Produto
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgdbError("Erro ao consultar a promocao_sos_estoque_minimo")
			lvb_Sucesso = False
			Exit
		End If
	
		If ll_Achou > 0 Then
			
			If lvl_Estoque_Minimo <> lvl_Estoque_Minimo_Ant Then
			
				Update promocao_sos_estoque_minimo
					Set qt_estoque_minimo = :lvl_Estoque_Minimo,
						 nr_matricula_alteracao = :gvo_Aplicacao.ivo_Seguranca.Nr_Matricula,
						 cd_motivo_alteracao = :ll_Motivo
				Where cd_promocao_sos = :lvl_Promocao
				  and cd_filial		= :lvl_Filial
				  and cd_produto	= :lvl_Produto
				Using SqlCa;
			
				If SqlCa.SqlCode = -1 Then
					SqlCa.of_MsgdbError("Atualiza$$HEX2$$e700e300$$ENDHEX$$o do estoque m$$HEX1$$ed00$$ENDHEX$$nimo da promo$$HEX2$$e700e300$$ENDHEX$$o")
					lvb_Sucesso = False
					Exit
				End If
			End If
			
		Else	
					
			Insert Into promocao_sos_estoque_minimo(cd_promocao_sos,
																	 cd_filial,
																	 cd_produto,
																	 qt_estoque_minimo,
																	 nr_matricula_alteracao,
																	 cd_motivo_alteracao)
			Values(:lvl_Promocao,
					 :lvl_Filial,
					 :lvl_Produto,
					 :lvl_Estoque_Minimo,
					 :gvo_Aplicacao.ivo_Seguranca.Nr_Matricula,
					 :ll_Motivo)
			Using SqlCa;
			
			If SqlCa.SqlCode = - 1 Then
				SqlCa.of_MsgdbError("Inclus$$HEX1$$e300$$ENDHEX$$o do Estoque M$$HEX1$$ed00$$ENDHEX$$nimo para Promo$$HEX2$$e700e300$$ENDHEX$$o")
				lvb_Sucesso = False
				Exit
			End If
		End If
			
	Else
		If Not wf_Exclui_Produto_Promocao(lvl_Promocao, lvl_Filial, lvl_Produto) Then
			lvb_Sucesso = False
			Exit
		End If
		
		If Not gf_ge134_Grava_Historico_Exclusao_Promo(lvl_Promocao, lvl_Filial, lvl_Produto, lvl_Estoque_Minimo_Ant, 'D', ll_Motivo) Then
			lvb_Sucesso = False
			Exit
		End If
	End If
Next

Return lvb_Sucesso
end function

public function boolean wf_exclui_produto_promocao (long pl_promocao, long pl_filial, long pl_produto);delete from promocao_sos_estoque_minimo
where cd_promocao_sos = :pl_promocao
  and cd_filial       = :pl_filial
  and cd_produto      = :pl_produto
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Exclus$$HEX1$$e300$$ENDHEX$$o da qtde de estoque minimo da promocao: " + &
	                     String(pl_Promocao) + " filial: " + String(pl_Filial) + " e produto: "+&
								String(pl_Produto))
	Return False
End If

Return True
end function

public function boolean wf_atualiza_qtde_estoque_minimo ();Boolean lvb_Sucesso = True

Long lvl_Row, &
     lvl_Promocao, &
	  lvl_Filial, &
	  lvl_Produto, &
	  lvl_Qtde_Estoque, &
	  ll_Nulo
	  
Tab_1.TabPage_1.dw_1.AcceptText()
Tab_1.TabPage_1.dw_2.AcceptText()
Tab_1.TabPage_2.dw_3.AcceptText()

lvl_Promocao = Tab_1.TabPage_1.dw_1.Object.Cd_Promocao[1]

SetNull(ll_Nulo)
	  
For lvl_Row = 1 To Tab_1.TabPage_2.dw_3.RowCount()
	
	lvl_Filial  = Tab_1.TabPage_2.dw_3.Object.Cd_Filial[lvl_Row]
	lvl_Produto = Tab_1.TabPage_2.dw_3.Object.Cd_Produto[lvl_Row]
	
	Select qt_estoque_minimo
	Into :lvl_Qtde_Estoque
	From promocao_sos_estoque_minimo
	where cd_promocao_sos = :lvl_Promocao
	  and cd_filial       = :lvl_Filial
	  and cd_produto      = :lvl_Produto
	Using SqlCa;
	
	Choose Case SqlCa.SqlCode
		Case 0
			Tab_1.TabPage_2.dw_3.Object.Qt_Estoque_Minimo_Promocao		[lvl_Row] = lvl_Qtde_Estoque
			Tab_1.TabPage_2.dw_3.Object.qt_estoque_minimo_promocao_ant	[lvl_Row] = lvl_Qtde_Estoque

		Case 100
			Tab_1.TabPage_2.dw_3.Object.Qt_Estoque_Minimo_Promocao		[lvl_Row] = 0
			Tab_1.TabPage_2.dw_3.Object.qt_estoque_minimo_promocao_ant	[lvl_Row] = 0
			
		Case -1
			SqlCa.of_MsgdbError("localiza$$HEX2$$e700e300$$ENDHEX$$o do estoque m$$HEX1$$ed00$$ENDHEX$$nimo da filial: " + String(lvl_Filial) + &
			                    " para a promo$$HEX2$$e700e300$$ENDHEX$$o: " + String(lvl_Filial) + " e produto: " + &
									  String(lvl_Produto))
			lvb_Sucesso = False
			Exit
	End Choose	
Next

Return lvb_Sucesso
end function

public function boolean wf_valida_informacoes ();Boolean lvb_Retorno = True

Integer lvi_Tipo

lvi_Tipo = MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Deseja salvar as informa$$HEX2$$e700f500$$ENDHEX$$es antes de continuar ?", Question!, YesNoCancel!, 3)

If lvi_Tipo = 1 Then
	Event ue_Save()
ElseIf lvi_Tipo = 3 Then
	lvb_Retorno = False
Else
	ivb_Salva = False
End If

Return lvb_Retorno
end function

public function boolean wf_valida_fator_conversao ();Long	lvl_Total, &
		lvl_Linha, &
		lvl_Estoque_Minimo, &
		lvl_Fator, &
		ll_Min_Matriz
	  	  
Tab_1.TabPage_2.dw_3.AcceptText()
Tab_1.TabPage_2.dw_4.AcceptText()

lvl_Total = Tab_1.TabPage_2.dw_3.RowCount()

lvl_Fator = Tab_1.TabPage_2.dw_4.Object.Vl_Fator_Conversao[1]

For lvl_Linha = 1 To lvl_Total
	lvl_Estoque_Minimo	= Tab_1.TabPage_2.dw_3.Object.Qt_Estoque_Minimo_Promocao	[lvl_Linha]
	
	If lvl_Estoque_Minimo > 0 Then
		If Mod(lvl_Estoque_Minimo, lvl_Fator) <> 0 Then
			MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "O estoque m$$HEX1$$ed00$$ENDHEX$$nimo deve ser m$$HEX1$$fa00$$ENDHEX$$ltiplo do fator de convers$$HEX1$$e300$$ENDHEX$$o utilizado no estoque central.", StopSign!)
			Tab_1.TabPage_2.dw_3.Event ue_Pos(lvl_Linha, "qt_estoque_minimo_promocao")
			Return False
		End If
	End If
		
Next

Return True
end function

public function boolean wf_estoque_base_total (long al_produto, ref long al_estoque_base);Select sum(qt_estoque_base) Into :al_Estoque_Base  
From resumo_reposicao_estoque   
Where cd_produto = :al_Produto
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Verifica$$HEX2$$e700e300$$ENDHEX$$o do Estoque Base Total do Produto")
	Return False
End If

If IsNull(al_Estoque_Base) Then al_Estoque_Base = 0

Return True
end function

public function boolean wf_estoque_minimo_total (long al_promocao, long al_produto, ref long al_estoque_minimo);Select sum(qt_estoque_minimo) Into :al_Estoque_Minimo
From promocao_sos_estoque_minimo
Where cd_promocao_sos = :al_Promocao
  and cd_produto      = :al_Produto
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Verifica$$HEX2$$e700e300$$ENDHEX$$o do Estoque M$$HEX1$$ed00$$ENDHEX$$nimo Total do Produto")
	Return False
End If

If IsNull(al_Estoque_Minimo) Then al_Estoque_Minimo = 0

Return True
end function

public function boolean wf_estoque_atual (long al_produto, ref long al_estoque_matriz, ref long al_estoque_filiais);Select qt_saldo Into :al_Estoque_Filiais
From resumo_produto
Where id_rede = 'CIA'
  and cd_produto = :al_Produto
  and dh_resumo  = (Select convert(datetime, substring(convert(char(8), dh_movimentacao, 112), 1, 6) + '01') From parametro)
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Verifica$$HEX2$$e700e300$$ENDHEX$$o do Estoque Atual nas Filiais do Produto")
	Return False
End If

If IsNull(al_Estoque_Filiais) Then al_Estoque_Filiais = 0

Select round(s.qt_saldo_final * g.vl_fator_conversao, 0) Into :al_Estoque_Matriz
From saldo_produto s,
     produto_geral g
Where s.cd_produto = :al_Produto
  and s.dh_saldo   = (Select convert(datetime, substring(convert(char(8), dh_movimentacao, 112), 1, 6) + '01') From parametro)
  and s.cd_filial  = 534
  and g.cd_produto = s.cd_produto
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Verifica$$HEX2$$e700e300$$ENDHEX$$o do Estoque Atual na Matriz do Produto")
	Return False
End If

If IsNull(al_Estoque_Matriz) Then al_Estoque_Matriz = 0

al_Estoque_Filiais = al_Estoque_Filiais - al_Estoque_Matriz

Return True
end function

public function boolean wf_meta_total (long al_promocao, long al_produto, ref long al_grupo, ref string as_descricao, ref long al_meta);// Se o produto pertencer a um grupo, localiza a meta do grupo, sen$$HEX1$$e300$$ENDHEX$$o localiza a meta do produto

Select p.cd_grupo,
       g.de_grupo
Into :al_Grupo,
     :as_Descricao
From promocao_mkt_grupo_produto p,
     promocao_mkt_grupo g
Where p.cd_produto = :al_Produto
  and g.cd_grupo = p.cd_grupo
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		Select sum(qt_venda_meta) Into :al_Meta
		From promocao_mkt_meta_grupo
		Where nr_promocao_marketing = :al_Promocao
		  and cd_grupo = :al_Grupo
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgdbError("Verifica$$HEX2$$e700e300$$ENDHEX$$o da Meta de Venda do Grupo")
			Return False
		End If
		
	Case 100
		Select sum(qt_venda_meta) Into :al_Meta
		From promocao_mkt_meta_produto
		Where nr_promocao_marketing = :al_Promocao
		  and cd_produto = :al_Produto
		Using SqlCa;
		
		If SqlCa.SqlCode = -1 Then
			SqlCa.of_MsgdbError("Verifica$$HEX2$$e700e300$$ENDHEX$$o da Meta de Venda do Produto")
			Return False
		End If		
		
		SetNull(al_Grupo)
		
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o do Grupo do Produto '" + String(al_Produto) + "'")
		Return False
End Choose

If IsNull(al_Meta) Then al_Meta = 0

Return True
end function

public function boolean wf_estoque_base_maior (long al_promocao, long al_produto, ref long al_estoque_base);Long lvl_A, &
     lvl_B

//Select sum(r.qt_estoque_base) Into :al_Estoque_Base  
//From resumo_reposicao_estoque r
//Where r.cd_produto = :al_Produto
//  and r.qt_estoque_base > 0
//  and (Not Exists (Select * 
//  						 From promocao_sos_estoque_minimo p
//                   Where p.cd_promocao_sos = :al_Promocao
//						   and p.cd_filial       = r.cd_filial
//						   and p.cd_produto      = r.cd_produto)
//							
//  or r.qt_estoque_base > (Select p.qt_estoque_minimo
//  						        From promocao_sos_estoque_minimo p
//                          Where p.cd_promocao_sos = :al_Promocao
//						          and p.cd_filial       = r.cd_filial
//						          and p.cd_produto      = r.cd_produto))
//	
//Using SqlCa;

//If IsNull(al_Estoque_Base) Then al_Estoque_Base = 0

Select sum(r.qt_estoque_base) Into :lvl_A
From resumo_reposicao_estoque r
Where r.cd_produto = :al_Produto
  and r.qt_estoque_base > 0
  and Not Exists (Select * 
  						From promocao_sos_estoque_minimo p
                  Where p.cd_promocao_sos = :al_Promocao
						  and p.cd_filial       = r.cd_filial
						  and p.cd_produto      = r.cd_produto)
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Verifica$$HEX2$$e700e300$$ENDHEX$$o do Estoque Base Maior que o M$$HEX1$$ed00$$ENDHEX$$nimo A")
	Return False
End If

Select sum(r.qt_estoque_base - p.qt_estoque_minimo) Into :lvl_B
From resumo_reposicao_estoque r,
     promocao_sos_estoque_minimo p
Where r.cd_produto = :al_Produto
  and p.cd_promocao_sos = :al_Promocao
  and p.cd_filial       = r.cd_filial
  and p.cd_produto      = r.cd_produto
  and r.qt_estoque_base > p.qt_estoque_minimo
Using SqlCa;

If SqlCa.SqlCode = -1 Then
	SqlCa.of_MsgdbError("Verifica$$HEX2$$e700e300$$ENDHEX$$o do Estoque Base Maior que o M$$HEX1$$ed00$$ENDHEX$$nimo B")
	Return False
End If

If IsNull(lvl_A) Then lvl_A = 0
If IsNull(lvl_B) Then lvl_B = 0

al_Estoque_Base = lvl_A + lvl_B

Return True
end function

public function boolean wf_promocao_marketing (long al_promocao, ref long al_promocao_mkt);Boolean lvb_Sucesso = False

Select nr_promocao_marketing Into :al_Promocao_MKT
From promocao_sos
Where cd_promocao_sos = :al_Promocao
Using SqlCa;

Choose Case SqlCa.SqlCode
	Case 0
		lvb_Sucesso = True
		
	Case 100
		MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Promo$$HEX2$$e700e300$$ENDHEX$$o marketing n$$HEX1$$e300$$ENDHEX$$o localizada.", StopSign!)
		
	Case -1
		SqlCa.of_MsgdbError("Localiza$$HEX2$$e700e300$$ENDHEX$$o da Promo$$HEX2$$e700e300$$ENDHEX$$o Marketing")
End Choose

Return lvb_Sucesso
end function

public function boolean wf_verifica_promocao_sap (long pl_cd_promocao, ref boolean pb_promocao_sap, ref string ps_log);long ll_existe

Select 1
into :ll_existe
from promocao_sos
where cd_promocao_sos = :pl_cd_promocao
and cd_promocao_sap is not null;

if sqlca.sqlcode = -1 then 
	ps_log = 'Objeto: ' + this.classname() + '~nM$$HEX1$$e900$$ENDHEX$$todo: wf_verifica_promocao_sap ~n' + 'Problemas ao consultar a tabela "promocao_sos": ' + sqlca.sqlerrtext
	return false
end if

if ll_existe > 0 Then
	pb_promocao_sap = true
else
	pb_promocao_sap = false
end if

return true
end function

on w_ge134_manutencao_minimo_promocao.create
int iCurrent
call super::create
end on

on w_ge134_manutencao_minimo_promocao.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
end on

event close;call super::close;Destroy(ivo_Promocao)
end event

event open;call super::open;ivo_Promocao = Create uo_Promocao
end event

event ue_preopen;call super::ue_preopen;This.ivl_Altura_1  = 2050
This.ivl_Largura_1 = 3660

This.ivl_Altura_2  = 2050
This.ivl_Largura_2 = 4220
end event

event ue_save;//OverRide

If Not wf_Valida_Fator_Conversao() Then Return -1

If Not wf_Atualiza_Informacoes() Then 
	SqlCa.of_RollBack()
	Return -1
End If

SqlCa.of_Commit()

//Volta o motivo para NENHUM
Tab_1.TabPage_2.dw_6.Object.Cd_Motivo[1] = 0

Tab_1.TabPage_2.dw_3.Event ue_Retrieve()

ivb_Salva = False

This.ivm_Menu.mf_Confirmar(False)
This.ivm_Menu.mf_Cancelar(False)

Return 1
end event

event ue_cancel;call super::ue_cancel;Tab_1.TabPage_2.dw_3.Event ue_Cancel()
Tab_1.TabPage_1.dw_2.Event ue_Cancel()
Tab_1.TabPage_1.dw_1.Event ue_Cancel()
Tab_1.TabPage_1.dw_1.Event ue_AddRow()

ivb_Salva = False

Tab_1.SelectedTab = 1

Tab_1.TabPage_1.dw_1.Event ue_Pos(1, "nm_promocao")

This.ivm_Menu.mf_Confirmar(False)
This.ivm_Menu.mf_Cancelar(False)
end event

event closequery;call super::closequery;If ivb_Salva Then
	
	If Not wf_Valida_Informacoes() Then
		// Permite a troca do folder
		Return 1
	Else
		Return 0
	End If
End If
end event

event ue_postopen;call super::ue_postopen;Tab_1.TabPage_2.dw_4.Event ue_AddRow()

Tab_1.TabPage_1.dw_1.SetFocus()

//If gvo_Aplicacao.ivo_Seguranca.Cd_Sistema = 'CO' Then
	ivo_Promocao.ivs_Tipo = "X" //Diferente de Planograma
//Else
//	ivo_Promocao.ivs_Tipo = "P"
//	This.Title = "GE134 - Manuten$$HEX2$$e700e300$$ENDHEX$$o de Estoque M$$HEX1$$ed00$$ENDHEX$$nimo de Produtos em Promo$$HEX2$$e700e300$$ENDHEX$$o Planograma"
//End If
end event

type dw_visual from dc_w_2tab_consulta_selecao_lista_det`dw_visual within w_ge134_manutencao_minimo_promocao
end type

type gb_aux_visual from dc_w_2tab_consulta_selecao_lista_det`gb_aux_visual within w_ge134_manutencao_minimo_promocao
end type

type tab_1 from dc_w_2tab_consulta_selecao_lista_det`tab_1 within w_ge134_manutencao_minimo_promocao
integer x = 5
integer y = 4
integer width = 4146
integer height = 2044
end type

event tab_1::selectionchanging;call super::selectionchanging;Long lvl_Linha, &
     lvl_Produto, &
     lvl_Fator

String lvs_Descricao
String ls_Dw

Choose Case NewIndex
	Case 1
		If ivb_Salva Then		
			If Not wf_Valida_Informacoes() Then
				Return 1
			End If
		End If
		
	Case 2
		If Tab_1.TabPage_1.dw_2.GetRow() > 0 Then
			
			//Tratamento para criar linha apenas uma vez
			If Tab_1.TabPage_2.dw_6.RowCount() = 0 Then			
				Tab_1.TabPage_2.dw_6.Event ue_AddRow()
			End If
			
			lvl_Linha = Tab_1.TabPage_1.dw_2.GetRow()
			
			//Somente no sistema Gerenciamento de Categorias o qt_estoque_minimo_matriz fica habilitado
			Tab_1.TabPage_2.dw_3.Object.qt_estoque_minimo_matriz_t.Visible 	= 0
			Tab_1.TabPage_2.dw_3.Object.qt_estoque_minimo_matriz_l.Visible 	= 0
			Tab_1.TabPage_2.dw_3.Object.qt_estoque_minimo_matriz.Visible 	= 0
			
			Tab_1.TabPage_2.dw_3.Object.qt_estoque_minimo_matriz.Protect = 1
			
			lvl_Produto		= Tab_1.TabPage_1.dw_2.Object.Cd_Produto       		[lvl_Linha]
			lvs_Descricao	= Tab_1.TabPage_1.dw_2.Object.De_Produto        		[lvl_Linha]
			lvl_Fator     		= Tab_1.TabPage_1.dw_2.Object.Vl_Fator_Conversao	[lvl_Linha]
			
			Tab_1.TabPage_2.dw_4.Object.Cd_Produto        		[1] = lvl_Produto
			Tab_1.TabPage_2.dw_4.Object.De_Produto        		[1] = lvs_Descricao
			Tab_1.TabPage_2.dw_4.Object.Vl_Fator_Conversao	[1] = lvl_Fator
			
			Tab_1.TabPage_2.dw_4.Object.Promocao_t.Text = Tab_1.TabPage_1.dw_1.Object.Nm_Promocao[1] + " (" + String(Tab_1.TabPage_1.dw_1.Object.Cd_Promocao[1]) + ")"
			
			If Tab_1.TabPage_1.dw_2.RowCount() > 0 Then
				If Date(ivo_Promocao.Dh_Termino_Estoque_Minimo) < Date(gf_getserverdate()) Then
					Tab_1.TabPage_2.dw_3.SetTabOrder('qt_estoque_minimo_promocao', 0)
				Else
					Tab_1.TabPage_2.dw_3.SetTabOrder('qt_estoque_minimo_promocao', 1)
				End If
			End If
			
			// Permite a troca do folder
			Return 0
			
		Else
			Return 1
		End If
End Choose
end event

type tabpage_1 from dc_w_2tab_consulta_selecao_lista_det`tabpage_1 within tab_1
integer width = 4110
integer height = 1928
cb_minimo cb_minimo
cb_gera_planilha cb_gera_planilha
dw_5 dw_5
end type

on tabpage_1.create
this.cb_minimo=create cb_minimo
this.cb_gera_planilha=create cb_gera_planilha
this.dw_5=create dw_5
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.cb_minimo
this.Control[iCurrent+2]=this.cb_gera_planilha
this.Control[iCurrent+3]=this.dw_5
end on

on tabpage_1.destroy
call super::destroy
destroy(this.cb_minimo)
destroy(this.cb_gera_planilha)
destroy(this.dw_5)
end on

type gb_2 from dc_w_2tab_consulta_selecao_lista_det`gb_2 within tabpage_1
integer x = 9
integer y = 416
integer width = 3525
integer height = 1484
string text = "Lista dos Produtos da Promo$$HEX2$$e700e300$$ENDHEX$$o"
end type

type gb_1 from dc_w_2tab_consulta_selecao_lista_det`gb_1 within tabpage_1
integer x = 9
integer width = 2418
integer height = 384
end type

type dw_1 from dc_w_2tab_consulta_selecao_lista_det`dw_1 within tabpage_1
integer x = 32
integer y = 72
integer width = 2373
integer height = 304
string dataobject = "dw_ge134_selecao"
end type

event dw_1::ue_key;String lvs_Coluna

Tab_1.TabPage_1.dw_1.AcceptText()

lvs_Coluna = This.GetColumnName()

If Key = KeyEnter! Then
	
	If lvs_Coluna = "nm_promocao" Then
		
		ivo_Promocao.of_Localiza(This.GetText())
				
		If ivo_Promocao.Localizado Then
			This.Object.Cd_Promocao	[1] = ivo_Promocao.Cd_Promocao
			This.Object.Nm_Promocao	[1] = ivo_Promocao.Nm_Promocao
			
			This.Object.Dt_Periodo_De						[1] = Date(ivo_Promocao.Dh_Inicio)
			This.Object.Dt_Periodo_Ate						[1] = Date(ivo_Promocao.Dh_Termino)
			This.Object.Dh_Inicio_Estoque_Minimo		[1] = Date(ivo_Promocao.Dh_Inicio_Estoque_Minimo)
			This.Object.Dh_Termino_Estoque_Minimo	[1] = Date(ivo_Promocao.Dh_Termino_Estoque_Minimo)
			
			If Date(ivo_Promocao.Dh_Termino_Estoque_Minimo) < Date(gf_getserverdate()) Then
				dw_1.Object.Periodo_Encerrado.Visible = True
				dw_1.Object.Periodo_Encerrado.Text = "Promo$$HEX2$$e700e300$$ENDHEX$$o encerrada. Era v$$HEX1$$e100$$ENDHEX$$lida at$$HEX1$$e900$$ENDHEX$$ '" + String(Date(ivo_Promocao.Dh_Termino_Estoque_Minimo)) + "'"
				cb_minimo.enabled = False
				cb_gera_planilha.enabled = False
				
			Else
				dw_1.Object.Periodo_Encerrado.Visible = False
				dw_1.Object.Periodo_Encerrado.Text = ""
				cb_minimo.enabled = True
				cb_gera_planilha.enabled = True
			End If
		Else
			ivo_Promocao.of_Inicializa()
		End If
	End If
End If
end event

event dw_1::constructor;call super::constructor;This.of_SetColSelection(True)
end event

event dw_1::editchanged;call super::editchanged;Tab_1.TabPage_1.dw_2.Reset()
dw_1.Object.Periodo_Encerrado.Visible = False
dw_1.Object.Periodo_Encerrado.Text = ""

Choose Case dwo.Name
	Case "nm_promocao"
		If Not IsNull(Data) And Trim(Data) <> "" Then
			If Data <> ivo_Promocao.Nm_Promocao Then
				Return 1
			End If
		Else
			ivo_Promocao.of_Inicializa()
			
			This.Object.Cd_Promocao		[1] = ivo_Promocao.Cd_Promocao
			This.Object.Nm_Promocao		[1] = ivo_Promocao.Nm_Promocao
		End If
End Choose
end event

event dw_1::itemchanged;call super::itemchanged;Tab_1.TabPage_1.dw_2.Reset()
dw_1.Object.Periodo_Encerrado.Visible = False
dw_1.Object.Periodo_Encerrado.Text = ""

Choose Case dwo.Name
	Case "nm_promocao"
		If Not IsNull(Data) And Trim(Data) <> "" Then
			If Data <> ivo_Promocao.Nm_Promocao Then
				Return 1
			End If
		Else
			ivo_Promocao.of_Inicializa()
			
			This.Object.Cd_Promocao		[1] = ivo_Promocao.Cd_Promocao
			This.Object.Nm_Promocao		[1] = ivo_Promocao.Nm_Promocao
		End If
End Choose
end event

type dw_2 from dc_w_2tab_consulta_selecao_lista_det`dw_2 within tabpage_1
integer x = 41
integer y = 468
integer width = 3470
integer height = 1412
string dataobject = "dw_ge134_lista_dw2"
end type

event dw_2::ue_recuperar;//OverRide

Long 		lvl_Promocao

dw_1.AcceptText()

lvl_Promocao 									= dw_1.Object.Cd_Promocao[1]

Return This.Retrieve(lvl_Promocao)
end event

event dw_2::constructor;call super::constructor;ivi_Tipo_Cancelar = RESET
end event

event dw_2::ue_postretrieve;call super::ue_postretrieve;Boolean lvb_Sucesso = False
Boolean lvb_promocao_sap = false
String ls_log

Long lvl_Linha, &
     lvl_Promocao, &
     lvl_Produto, &
	  lvl_Estoque_Base, &
	  lvl_Estoque_Minimo, &
	  lvl_Estoque_Matriz, &
	  lvl_Estoque_Filiais, &
	  lvl_Grupo, &
	  lvl_Meta, &
	  lvl_Meta_Grupo, &
	  lvl_Meta_Produto, &
	  lvl_Promocao_MKT, &
	  lvl_Base_Maior, &
	  lvl_Pedido, &
	  lvl_Compra
	  
String lvs_Descricao

If pl_Linhas > 0 Then
	
	lvl_Promocao = dw_1.Object.Cd_Promocao[1]
	
	If Not wf_verifica_promocao_sap(lvl_promocao, ref lvb_promocao_sap, ref ls_log) then 
		messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o', ls_log)
		return -1
	end if

	//Se for promo$$HEX2$$e700e300$$ENDHEX$$o SAP bloqueia o campo estoque minimo.
	if lvb_promocao_sap = True Then
		tab_1.tabpage_2.dw_3.modify('qt_estoque_minimo_promocao.protect = 1')
	else
		tab_1.tabpage_2.dw_3.modify('qt_estoque_minimo_promocao.protect = 0')
	end if
	
	This.ivo_Controle_Menu.of_SalvarComo(True)
	
	If dw_1.Object.Id_Atualizar_Produtos[1] = "N" Then Return pl_Linhas
	
	If Not wf_Promocao_Marketing(ivo_Promocao.Cd_Promocao, ref lvl_Promocao_MKT) Then Return pl_Linhas
	
	Open(w_Aguarde)
	w_Aguarde.Title = "Atualizando Informa$$HEX2$$e700f500$$ENDHEX$$es dos Produtos..."
	
	w_Aguarde.uo_Progress.of_SetMax(pl_Linhas)
	
	This.SetRedraw(False)
	
	For lvl_Linha = 1 To pl_Linhas
		lvl_Promocao = This.Object.Cd_Promocao_SOS[lvl_Linha]
		lvl_Produto  = This.Object.Cd_Produto     [lvl_Linha]
		
		lvb_Sucesso = False
		
		If wf_Estoque_Base_Total(lvl_Produto, ref lvl_Estoque_Base) Then
			If wf_Estoque_Minimo_Total(lvl_Promocao, lvl_Produto, ref lvl_Estoque_Minimo) Then
				If wf_Estoque_Atual(lvl_Produto, ref lvl_Estoque_Matriz, ref lvl_Estoque_Filiais) Then
					If wf_Estoque_Base_Maior(lvl_Promocao, lvl_Produto, ref lvl_Base_Maior) Then
						If Not IsNull(lvl_Promocao_MKT) Then
							If wf_Meta_Total(lvl_Promocao_MKT, lvl_Produto, ref lvl_Grupo, ref lvs_Descricao, ref lvl_Meta) Then
								lvb_Sucesso = True
							End If
						Else
							lvb_Sucesso = True
						End If
					End If
				End If
			End If
		End If
		
		If Not lvb_Sucesso Then Exit
		
		// Verifica se a meta $$HEX1$$e900$$ENDHEX$$ por grupo ou por produto
		If Not IsNull(lvl_Grupo) Then
			lvl_Meta_Grupo   = lvl_Meta
			lvl_Meta_Produto = 0
		Else
			lvl_Grupo        = 0
			lvs_Descricao    = "AAA PRODUTOS SEM GRUPO"			
			lvl_Meta_Grupo   = 0
			lvl_Meta_Produto = lvl_Meta			
		End If
		
		// Verifica a necessidade de pedidos de filiais e compras para o estoque central
		lvl_Pedido = lvl_Estoque_Minimo + lvl_Base_Maior - lvl_Estoque_Filiais
		lvl_Compra = lvl_Pedido - lvl_Estoque_Matriz		
		
		If lvl_Pedido < 0 Then lvl_Pedido = 0
		If lvl_Compra < 0 Then lvl_Compra = 0
		
		This.Object.Qt_Estoque_Base       [lvl_Linha] = lvl_Estoque_Base		
		This.Object.Qt_Estoque_Minimo     [lvl_Linha] = lvl_Estoque_Minimo
		This.Object.Qt_Estoque_Matriz     [lvl_Linha] = lvl_Estoque_Matriz
		This.Object.Qt_Estoque_Filiais    [lvl_Linha] = lvl_Estoque_Filiais
		This.Object.Cd_Grupo_Meta         [lvl_Linha] = lvl_Grupo
		This.Object.De_Grupo_Meta         [lvl_Linha] = lvs_Descricao
		This.Object.Qt_Meta_Grupo         [lvl_Linha] = lvl_Meta_Grupo
		This.Object.Qt_Meta_Produto       [lvl_Linha] = lvl_Meta_Produto		
		This.Object.Qt_Estoque_Base_Pedido[lvl_Linha] = lvl_Estoque_Minimo + lvl_Base_Maior
		This.Object.Qt_Pedido_Filial      [lvl_Linha] = lvl_Pedido
		This.Object.Qt_Compra             [lvl_Linha] = lvl_Compra
		
		w_Aguarde.uo_Progress.of_SetProgress(lvl_Linha)
	Next
	
	This.Sort()
	This.GroupCalc()
	This.SetRedraw(True)
	
	Close(w_Aguarde)
Else
	This.ivo_Controle_Menu.of_SalvarComo(False)
End If

Return pl_Linhas
end event

type tabpage_2 from dc_w_2tab_consulta_selecao_lista_det`tabpage_2 within tab_1
integer width = 4110
integer height = 1928
gb_5 gb_5
gb_4 gb_4
dw_4 dw_4
dw_6 dw_6
end type

on tabpage_2.create
this.gb_5=create gb_5
this.gb_4=create gb_4
this.dw_4=create dw_4
this.dw_6=create dw_6
int iCurrent
call super::create
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.gb_5
this.Control[iCurrent+2]=this.gb_4
this.Control[iCurrent+3]=this.dw_4
this.Control[iCurrent+4]=this.dw_6
end on

on tabpage_2.destroy
call super::destroy
destroy(this.gb_5)
destroy(this.gb_4)
destroy(this.dw_4)
destroy(this.dw_6)
end on

type gb_3 from dc_w_2tab_consulta_selecao_lista_det`gb_3 within tabpage_2
integer x = 9
integer y = 436
integer width = 4069
integer height = 1444
string text = "Estoque M$$HEX1$$ed00$$ENDHEX$$nimo por Filial"
end type

type dw_3 from dc_w_2tab_consulta_selecao_lista_det`dw_3 within tabpage_2
integer x = 37
integer y = 488
integer width = 4014
integer height = 1364
string dataobject = "dw_ge134_lista_dw3"
boolean vscrollbar = true
end type

event dw_3::ue_recuperar;//OverRide

Long 		lvl_Produto, &
     		lvl_Promocao
String	ls_id_mostrar_apenas_filiais_abertas

Tab_1.TabPage_1.dw_1.AcceptText()
Tab_1.TabPage_1.dw_2.AcceptText()

lvl_Produto  									= Tab_1.TabPage_1.dw_2.Object.Cd_Produto[Tab_1.TabPage_1.dw_2.GetRow()]
lvl_Promocao 									= Tab_1.TabPage_1.dw_1.Object.Cd_Promocao[1]
ls_id_mostrar_apenas_filiais_abertas	= Tab_1.TabPage_1.dw_1.Object.id_mostrar_apenas_filiais_abertas[1]

If ls_id_mostrar_apenas_filiais_abertas = "S" Then
	This.of_AppendWhere("f.id_recebe_nf_transferencia = 'S'")
End If

Return This.Retrieve(lvl_Produto, lvl_Promocao)
end event

event dw_3::constructor;call super::constructor;This.of_SetRowSelection()

ivi_Tipo_Cancelar = RESET
end event

event dw_3::itemchanged;call super::itemchanged;long ll_cd_filial
string ls_adm_sap

If dwo.Name = "qt_estoque_minimo_promocao" Then
	ivm_Menu.mf_Confirmar(True)
	ivm_Menu.mf_Cancelar(True)
	
	ivb_Salva = True
End If

Choose Case dwo.name
	Case 'qt_estoque_minimo_promocao', 'qt_estoque_minimo_matriz'
		
		ll_cd_filial = getitemnumber(row,'cd_filial')
		
		if Not gf_filial_administrada_sap(ll_cd_filial, ref ls_adm_sap) Then return 1
		
		if ls_adm_sap = 'N' Then
			messagebox('Aten$$HEX2$$e700e300$$ENDHEX$$o','A filial ' + string(ll_cd_filial) + ' $$HEX1$$e900$$ENDHEX$$ administrada pelo SAP, n$$HEX1$$e300$$ENDHEX$$o $$HEX1$$e900$$ENDHEX$$ poss$$HEX1$$ed00$$ENDHEX$$vel realizar altera$$HEX2$$e700f500$$ENDHEX$$es.')		
			return 1
		end if
		
	Case Else
		
End Choose
end event

event dw_3::editchanged;call super::editchanged;If dwo.Name = "qt_estoque_minimo_promocao" Then
	ivm_Menu.mf_Confirmar(True)
	ivm_Menu.mf_Cancelar(True)
	
	ivb_Salva = True
End If
end event

event dw_3::ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then		
	If Not wf_Atualiza_Qtde_Estoque_Minimo() Then Return -1
	This.Object.Legenda_t.Visible = 1
	This.ivo_Controle_Menu.of_SalvarComo(True)
Else
	This.Object.Legenda_t.Visible = 0
	This.ivo_Controle_Menu.of_SalvarComo(False)
End If

Return pl_Linhas
end event

event dw_3::doubleclicked;call super::doubleclicked;If This.RowCount() > 0 Then
	Long ll_Linha
	
	This.AcceptText()
	
	ll_Linha = This.GetRow()
	
	st_parametro_historico str
	
	str.Cd_Promocao	= Tab_1.TabPage_1.dw_1.Object.Cd_Promocao	[1]
	str.Cd_Produto		= Tab_1.TabPage_2.dw_4.Object.Cd_Produto		[1]
	str.Cd_Filial			= Tab_1.TabPage_2.dw_3.Object.Cd_Filial			[ll_Linha]
	
	OpenWithParm(w_ge134_consulta_historico_alteracao, str)
End If
end event

type cb_minimo from commandbutton within tabpage_1
integer x = 2450
integer y = 180
integer width = 942
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Importa Estoque &M$$HEX1$$ed00$$ENDHEX$$nimo via Excel"
end type

event clicked;Long lvl_Promocao, &
	  lvl_Retorno

dw_1.AcceptText()

lvl_Promocao = dw_1.Object.cd_promocao[1]

OpenWithParm(w_ge134_insere_estoque_minimo, String(lvl_Promocao))
end event

type cb_gera_planilha from commandbutton within tabpage_1
integer x = 2450
integer y = 300
integer width = 942
integer height = 100
integer taborder = 30
boolean bringtotop = true
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
boolean enabled = false
string text = "Gera Planilha de Estoque M$$HEX1$$ed00$$ENDHEX$$nimo"
end type

event clicked;Long ll_Promocao

dw_1.AcceptText()

ll_Promocao = dw_1.Object.Cd_Promocao[1]

If IsNull(ll_Promocao) Or ll_Promocao = 0 Then
	MessageBox("Aten$$HEX2$$e700e300$$ENDHEX$$o", "Informe a promo$$HEX2$$e700e300$$ENDHEX$$o para gerar a planilha.")
	dw_1.Event ue_Pos(1, "cd_promocao")
	Return -1
End If

dw_5.Event ue_Retrieve()
end event

type dw_5 from dc_uo_dw_base within tabpage_1
boolean visible = false
integer x = 2651
integer y = 912
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge134_gera_planilha_estoque_minimo"
end type

event ue_postretrieve;call super::ue_postretrieve;If pl_Linhas > 0 Then
	
	Integer lvi_Retorno
	
	Try
		
		Open(w_Aguarde)	
		w_Aguarde.Title = "Gerando planilha... Aguarde"
			
		This.Event ue_SaveAs()
		
	Finally
		Close(w_Aguarde)
	End Try
End If

Return pl_Linhas
end event

event ue_recuperar;//OverRide

dw_1.AcceptText()

Return This.Retrieve(Tab_1.TabPage_1.dw_1.Object.Cd_Promocao[1])
end event

type gb_5 from groupbox within tabpage_2
integer x = 9
integer y = 260
integer width = 1568
integer height = 160
integer taborder = 30
integer textsize = -8
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 33554432
long backcolor = 67108864
end type

type gb_4 from groupbox within tabpage_2
integer x = 9
integer y = 8
integer width = 3502
integer height = 252
integer taborder = 30
integer textsize = -8
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Verdana"
long textcolor = 8388608
long backcolor = 67108864
string text = "Produto Selecionado"
borderstyle borderstyle = styleraised!
end type

type dw_4 from dc_uo_dw_base within tabpage_2
integer x = 37
integer y = 72
integer width = 3451
integer height = 164
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge134_detalhe_produto_selecionado"
end type

type dw_6 from dc_uo_dw_base within tabpage_2
integer x = 27
integer y = 308
integer width = 1518
integer height = 96
integer taborder = 20
boolean bringtotop = true
string dataobject = "dw_ge134_lista_motivo_alteracao"
end type

